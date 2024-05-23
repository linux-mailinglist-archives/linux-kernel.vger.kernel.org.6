Return-Path: <linux-kernel+bounces-187550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A348CD352
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B9A1C222A7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E82414A4DF;
	Thu, 23 May 2024 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdVSNWA0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082FB14A4EA
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469949; cv=none; b=uEnI5IVoSmrmwq7GUwYz/vY+IJ5DBRRMl3iqnvsl/NQrg0HNUOu6W2A2SQLXQVT/Y8tyUE9ae90XzPB2qn7wyyrNn6/21w9akfF1bq+P/5Pp80zqZeSsF+st4xydPILbTaagudrG7bfEtqJmB9kwPUMyOoQNAG3ELkOJCrl2TUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469949; c=relaxed/simple;
	bh=280FAOT3JH+qQoJYo5EweKg7PaJa82fjJcdFcxH4bHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqMmfFDqKi1iT0dIh0Z8dEpabOW2EKkpp7NNf887/Q9D4CxpEtteOPuGDys0UOqFysORTA5Yf4hE8WK05mMsAUWnahZL1vCX6nqe2jYaaql7eUw2c14PwYuKGw8mnovFzlVm9f5cGvOP+tQ+9kZGhiYrCyDbn0hkl6NJxP4TrYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fdVSNWA0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716469946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6b8ckFLNrH+n0z5ZTQUnQT/jgZD23ydywQW1AVdLZHU=;
	b=fdVSNWA0SJ0KlCD2PwolrL44C0yZ4Dzabn3VagoFH/b4rCj2kirMX+jgX2P+5qxMe15FKj
	IwcUGziR32e0vpUv2GY04p7Oqr1Ig9e2uIZX0Ma++PbhWJ8WvVAugn4FgSUOGaIjpiZZRs
	ySzOLhF9gB3b3lr1gvPcqqNMvSmsVe4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-iOCUxihRPp--ENdret5jUA-1; Thu,
 23 May 2024 09:12:22 -0400
X-MC-Unique: iOCUxihRPp--ENdret5jUA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E49E93C025A1;
	Thu, 23 May 2024 13:12:21 +0000 (UTC)
Received: from [10.18.25.182] (unknown [10.18.25.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 94124491034;
	Thu, 23 May 2024 13:12:21 +0000 (UTC)
Message-ID: <fe13bd05-76c5-4bf8-bfda-f9ecf08b2272@redhat.com>
Date: Thu, 23 May 2024 09:12:21 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: sagi@grimberg.me, emilne@redhat.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, jrani@purestorage.com, randyj@purestorage.com,
 hare@kernel.org
References: <20240522165406.702362-1-jmeneghi@redhat.com>
 <Zk4sEpypKqeU67dg@kbusch-mbp.dhcp.thefacebook.com>
 <20240523064525.GA28524@lst.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20240523064525.GA28524@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 5/23/24 02:45, Christoph Hellwig wrote:> On Wed, May 22, 2024 at 11:32:02AM -0600, Keith Busch wrote:
>> Christoph, Sagi, 6.10 merge window is still open and this has been
>> iterating long before that. Any objection?
> 
> No, it's not.  The window for development closes with the release for
> 6.9.  New features must be in before that.

So what's the next window for new features?  6.11?

/John



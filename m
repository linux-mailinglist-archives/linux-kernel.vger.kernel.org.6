Return-Path: <linux-kernel+bounces-187580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7E78CD4CA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46D31F224FE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0554014A4E9;
	Thu, 23 May 2024 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUJ39K6A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34B91E497
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471193; cv=none; b=eMksHh6Q7pj1KirR+fh6l0dXi4MpZQs9jA4wyVJjDWzVP+mbc1941vD1pq72vc+lIumio7pydynPDlwzeRteoM0CvixrGyETYz4YFxZT/iKPOze6EcNyJlRC3d2WDMd9zovgZ0vHN3axq4R0Fbk0zoX1BFIbNwnqmOqoSJU2UJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471193; c=relaxed/simple;
	bh=4o3GAOCq2Lz+ggESTfW+Xwh287kbqlK80oIOkmGI7z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NEMpE8R5TRM+9OTuZ+Qn2Mg5/TosbWtPxjAbN45F2qObtpYSYnhO4PLrvobUvwLnVS6MLDlz3Dx9YHSJG9mzRMgnuhR61K23R6itFUysvXGby3P9FdetcbM9PBSlKwf75t+Q97vzbiV7r9tUsh0tZ0YAvmILUibfrTK5riIJ6IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUJ39K6A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716471190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mjRKHkCHJaZREpZFTXzAPPKwBxIeivQ6IBLkno7Bz2Y=;
	b=YUJ39K6AIVamJNAsQUIcpR3mMmU7b0kFTClKGw7aL5cFN6Ew0/iNPrgZR+V7R0WX/nHLrI
	8AyENSrFfOitGhmVywmcswYCgmZ9T7eXX4Iya0jFv5pen4bW6eHfJsAe1B6gpE9br14tH4
	CYUVyS2QE/TjPbqjR7WPVKBdgRCCdcw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-IV9B1EUWOG2LUuftIbx_Pw-1; Thu, 23 May 2024 09:33:07 -0400
X-MC-Unique: IV9B1EUWOG2LUuftIbx_Pw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE6A3812296;
	Thu, 23 May 2024 13:33:06 +0000 (UTC)
Received: from [10.18.25.182] (unknown [10.18.25.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 43FC27412;
	Thu, 23 May 2024 13:33:06 +0000 (UTC)
Message-ID: <17692dc1-0817-4216-8e9b-3c9207802ae3@redhat.com>
Date: Thu, 23 May 2024 09:33:06 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, sagi@grimberg.me, emilne@redhat.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240522165406.702362-1-jmeneghi@redhat.com>
 <Zk4sEpypKqeU67dg@kbusch-mbp.dhcp.thefacebook.com>
 <20240523064525.GA28524@lst.de>
 <fe13bd05-76c5-4bf8-bfda-f9ecf08b2272@redhat.com>
 <20240523131617.GA23604@lst.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20240523131617.GA23604@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5


On 5/23/24 09:16, Christoph Hellwig wrote:
> On Thu, May 23, 2024 at 09:12:21AM -0400, John Meneghini wrote:
>> On 5/23/24 02:45, Christoph Hellwig wrote:> On Wed, May 22, 2024 at 11:32:02AM -0600, Keith Busch wrote:
>>>> Christoph, Sagi, 6.10 merge window is still open and this has been
>>>> iterating long before that. Any objection?
>>>
>>> No, it's not.  The window for development closes with the release for
>>> 6.9.  New features must be in before that.
>>
>> So what's the next window for new features?  6.11?
> 
> What else?

Then merge it there.  Duh.



Return-Path: <linux-kernel+bounces-335757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F332597EA2F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75923281807
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4CE196DA4;
	Mon, 23 Sep 2024 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTOtiEny"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA32E17543
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727088774; cv=none; b=TobO5Fhq8TWWEH9SxrT/o1wu0Uoe/TtOb2wgYLqDOQl/2o3ll7zcpoMM/shBsHoe8smoNB5namkIGiVAgmI6O02xtNfaIPPVDBBJJ6KSMe7U9XgrqpdA9pJLMD6EEuaXYV5kXljTHfq4m5UHMHjpmDyR70uIBeLGj7WzmMYsoZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727088774; c=relaxed/simple;
	bh=Y+sOs23LxoBNVTfS3KszCVfFBU/ZZVHdw76qtjXQLyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9TUaR8GryP9ERv2gSM0pRW3Sqn3Wp/M4kW+sIMtQ27bca3IzUFm2AvPBzcW0cmjGuDFNCDIoQo11RJRS9MuV5liu+tz8SBAVWPuZeyA8c6aiRpHgX+IsjFeplFW8kq1bvjVs2suVpxSH30/cS6NBoB6A7Xf6qScJIyo+L/5Sw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iTOtiEny; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727088771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+sOs23LxoBNVTfS3KszCVfFBU/ZZVHdw76qtjXQLyw=;
	b=iTOtiEny2wmJUvoz76YeCBqyNl/ygbKRaKmBnn/zvGwcS3kc20Cr2QUxqJ+YOhap3Qomhg
	wvvAtiLsPwH4Rb0jqn2IaEsXsitnJEajkSuFs/bNgbfMUiAndUhGsnxcjJYIkDQS5FiYN+
	CxvTjCET6YrdJQ8Vskon1IxiRo9CV6Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-_B_MAFsMPKuFULX2GCN3Xg-1; Mon,
 23 Sep 2024 06:52:48 -0400
X-MC-Unique: _B_MAFsMPKuFULX2GCN3Xg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 677B019CC856;
	Mon, 23 Sep 2024 10:52:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.16])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 74F6419560AD;
	Mon, 23 Sep 2024 10:52:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 23 Sep 2024 12:52:34 +0200 (CEST)
Date: Mon, 23 Sep 2024 12:52:29 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: "Liao, Chang" <liaochang1@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>, mhiramat@kernel.org,
	peterz@infradead.org, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: uprobes: Optimize cache flushes for xol slot
Message-ID: <20240923105228.GB20793@redhat.com>
References: <20240919121719.2148361-1-liaochang1@huawei.com>
 <20240919141824.GB12149@redhat.com>
 <41fdfc47-4161-d2e4-6528-4079b660424f@huawei.com>
 <Zu2VdYrLWTJbVOAt@arm.com>
 <b90ce6f1-0d47-2429-5536-a8d5d91d6a70@huawei.com>
 <20240923071856.GA31866@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923071856.GA31866@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 09/23, Will Deacon wrote:
>
> However, we should use __GFP_ZERO anyway
> because I don't think it's a good idea to map an uninitialised page into
> userspace.

Agreed, and imo this even needs a separate "fix info leak" patch.

Oleg.



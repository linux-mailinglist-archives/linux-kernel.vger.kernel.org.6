Return-Path: <linux-kernel+bounces-365265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D9799DFAC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7000E281B10
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC40198E9B;
	Tue, 15 Oct 2024 07:50:59 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF554139578
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978659; cv=none; b=WD0Ty9pcBDCwo618NAQr1P9faPEwV4MY9F31FHdTcz/degAb7FK0CaXZPnPynQvzcvMQIdYT/eWeIo4VSfQxemY0aXj2d1GJkvZQgXrVg6gIxrd+WjVEUiYANBTkPnsJpHASBLRMmnLOk8IVWKJVTgJIv/x5nD96VI/4PvmW6ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978659; c=relaxed/simple;
	bh=CD4X4YxulKeimUGER7E5WK5B2c5PYKfxDc84u8d3caw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4o+d8Peua3AHk3fyX5oKl9WqUOTh2jW8PLOuQSfCdT1ztEbHWZXSET1vm0NpmseXd+aNE3AcWY+LYojvA7EgHIVlUrBYwyiGJXk5J7MqEwG5lHPFkd1Zfo6qpuaHM3jZV/6pZPXFHTcUfbZWzAccjOQUQJApxaes8jDsPQc/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C7860227AA8; Tue, 15 Oct 2024 09:50:53 +0200 (CEST)
Date: Tue, 15 Oct 2024 09:50:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, stefani@seibold.net,
	jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kfifo: don't include dma-mapping.h in kfifo.h
Message-ID: <20241015075053.GA25249@lst.de>
References: <20241014144643.51917-1-hch@lst.de> <ab456339-18fd-45d8-abde-b04196e0f604@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab456339-18fd-45d8-abde-b04196e0f604@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 15, 2024 at 09:47:31AM +0200, Jiri Slaby wrote:
>> diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
>> index 6797770474a55d..680243751d625f 100644
>> --- a/drivers/mailbox/omap-mailbox.c
>> +++ b/drivers/mailbox/omap-mailbox.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/kfifo.h>
>>   #include <linux/err.h>
>> +#include <linux/io.h>
>
> Oh, I've just noticed this. Why io.h?

Because it would not comple with out it.  To be specific: asm/io.h is
where __raw_readl and __raw_writel are defined, and we generally prefer
the Linux over the asm headers.

>
> -- 
> js
> suse labs
---end quoted text---


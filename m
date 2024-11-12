Return-Path: <linux-kernel+bounces-406726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC839C62D0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA9D1F25563
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94970219E34;
	Tue, 12 Nov 2024 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ny5bp63s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020B720B218
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731444424; cv=none; b=op576TwN531oX3TeVb4VOIOte4GK9kVlON9Ola+gF23U2yI2OtsnMJqjcrRxpWk1gH0CKNecvGPtls2cmsB6x/wE9J012qQdujOSWBRI6ZZNLMF0B5ao9JSK6LAeF+2niyKNph49cuJb2XbhI8RTyhu5F7GsoouvgWLMs94HcqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731444424; c=relaxed/simple;
	bh=cNdLSa1e0i0zJBM5n+pEe+12XHmggYolrYFKZI/3xsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cxqqm7Otm8cL6kUjJCbusqlUHC6BP7ZJ1MenRHJ2j+uq74C9PRNbJ9LyzZAhozo+hA2lKFUo47mFdu6l653vvA+pXW4n2RWYRNUIcuOO7f12+in/wQ5TGFky99/PUXQk/fpTrZaHWmAQoVEC4GBCTZXt0oVs1fIVZE5CMT3GjjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ny5bp63s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55918C4CECD;
	Tue, 12 Nov 2024 20:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731444423;
	bh=cNdLSa1e0i0zJBM5n+pEe+12XHmggYolrYFKZI/3xsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ny5bp63sriCqj14P3XlrY0XVodLKFsv6PK6Tv2Of55OHSYDus2vOfad5fihelCBtb
	 0dmzB8g7y6MNMS5443gaCTioao6GjzHxG1h91P1kpsvGvTDL6ei1Hty1C01qeaklQB
	 4/SibMPYNZzjiCaKVkA8sPnckWGZa8T5n/8pmhX/3wU4kPPrrNT5bCUCLzO2K+kJbj
	 OTRRoKUUXM8kY5Joz3ttJelQZsASaSvwZDT8daNp1TkkfUQw0uqguiMlUa6zz6z9Nn
	 gI+rmaINuzSnp+kWvrLdGMZEzP673cIUqO7LQ0lbYDk4sTlBIEq3fjI/XZHQB2z7vN
	 z4EN96gP9ckBg==
Date: Tue, 12 Nov 2024 13:47:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bob Beckett <bob.beckett@collabora.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, kernel@collabora.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Message-ID: <ZzO-xdUJLA1wSUeu@kbusch-mbp>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112195053.3939762-1-bob.beckett@collabora.com>

On Tue, Nov 12, 2024 at 07:50:00PM +0000, Bob Beckett wrote:
> @@ -2700,8 +2700,8 @@ static int nvme_setup_prp_pools(struct nvme_dev *dev)
>  		return -ENOMEM;
>  
>  	/* Optimisation for I/Os between 4k and 128k */
> -	dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,
> -						256, 256, 0);
> +	dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,256,
> +				       dev->ctrl.quirks & NVME_QUIRK_DMAPOOL_ALIGN_512 ? 512 : 256, 0);

This line is overly long and a bit difficult to read that way. I changed
it to this:

---
@@ -2693,15 +2693,20 @@ static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)

 static int nvme_setup_prp_pools(struct nvme_dev *dev)
 {
+       size_t small_align = 256;
+
        dev->prp_page_pool = dma_pool_create("prp list page", dev->dev,
                                                NVME_CTRL_PAGE_SIZE,
                                                NVME_CTRL_PAGE_SIZE, 0);
        if (!dev->prp_page_pool)
                return -ENOMEM;

+       if (dev->ctrl.quirks & NVME_QUIRK_DMAPOOL_ALIGN_512)
+               small_align = 512;
+
        /* Optimisation for I/Os between 4k and 128k */
        dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,
-                                               256, 256, 0);
+                                               256, small_align, 0);
        if (!dev->prp_small_pool) {
                dma_pool_destroy(dev->prp_page_pool);
                return -ENOMEM;
--


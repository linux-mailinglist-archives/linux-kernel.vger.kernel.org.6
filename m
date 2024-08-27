Return-Path: <linux-kernel+bounces-302884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC4C9604A9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08E21C221AC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A25197A95;
	Tue, 27 Aug 2024 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LSgrVHtt"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54425194AEA
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748068; cv=none; b=i48D3KQAArn55uJH+L+wZNKB6d9hyGpEBSCU16vYC0/qXZbiSyIzLAH569wXp4gwrGfHTEU7UBoOqe2yxcvWnbYQpO+WvkwjVnoXcSIbSCwfhixdWKEbXf74oWiIZSL9Re22dkHpacqqaN8qsbp5JRssnhUrPHp1IgO8phNPifM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748068; c=relaxed/simple;
	bh=0gqafYpFsfCbct7kk8S2BYP5nbyMWFsVauV6F5Nxq/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdK5UX5swBEfopxH4gnBqQkxUoowuHO85Z40FaMLahm4Q/lRHQm43d3nKPMxdF0jVfihtkz5uVysr2wXIK/pTyCZ3riDRPbpz9cyQHCkdoftsTk/CWp42IqgbYoc63vl64dQIDurokLBdxD/6CJSUg3namTmd9J7BlnSret63ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LSgrVHtt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-371afae614aso2776447f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724748065; x=1725352865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WLgLPlnbrmv4PGVaAQ6YPq+VN6mj8qeNpxeetEpH32c=;
        b=LSgrVHtt7QbUqXRt6SFc7bj/e1hpMznZLTxByh8hHJDppVCrriJoQwpO15l+UJoWqs
         sC8x5NYN8zMQFyrrWepOtj1WNh+H2Qww+F3B5aHz6JyRv0toaMOfvbqw607eWEyudnXF
         h2GqvSCz24iUiSyQQYPAATi7bnPHGsZrWOHKkqH8yTf+va5p/waJgLQrdYy4p9QFj9Nz
         WmaxcBAZ98M/RfMgKjURnFKJK+NC9UflUx6S2IQrIpy6JyLdlYSdjM251q3jztc6eoJt
         A8SgMxhP0EJy6yFTn5aJMRpk+ilqYz0uuOFzn6llX96JL+9UHq6hyhhHasSLm50eWtXj
         ZNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724748065; x=1725352865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLgLPlnbrmv4PGVaAQ6YPq+VN6mj8qeNpxeetEpH32c=;
        b=dzylEoAEyydQ4/mVIYdEQahDI01ji5ySU1Sm/anrKGvTHbkKpH5FEDjvA+Tawr+iuh
         hAijDGn8VFS28GDa0Qra+zGFyxv7iP6TEz2tx0dB8rXinNgVVFY22P7i+QM5rMoEZiwr
         7pLjBgsLvekMiwUDxYkfiVZcSd/e/qJLf+hcq+OKs/Dh6SPcgl865N5+VbSl5RH53T5Y
         yMzZ+zbZEibzOR1rhPv5uaP8rQeVDKCzySI9/mHW6XD97Z4N/cEYEyaIHelhQHIqoK4w
         tbK2JxTqZQSqu9QiCaMCFXUx/qbQrEM2X5Jv8IlSiG28CI+GG2mp3gFRGtogsFWvSeUe
         0a2A==
X-Forwarded-Encrypted: i=1; AJvYcCXGJqoGVjSxhPvbkW333k0OhqDicLpqVHANAqTQckabj6VUPNeEhYncH1ZMjI9BKpUpsNU1+LWBOiYzk10=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsysBG5jCTauSvvNoevbtsjtC7zI1Bbq85wJ8Lg5KisHV7dgXI
	KB5B7x0K8gezFb5RHmcRsPkm3oHQOx/ULil6m2j+erF6mC3AQAXYQOhB7/IkmLI=
X-Google-Smtp-Source: AGHT+IHD7U7oSMgJ9gZmwzeFhSQFaYKGfPgUODPIaCGYW/yRpAXBwWn9ZvxiQiZASTmx9Yv+oyqxPg==
X-Received: by 2002:adf:b309:0:b0:367:4e05:bb7b with SMTP id ffacd0b85a97d-373118e3c8emr7193339f8f.53.1724748064612;
        Tue, 27 Aug 2024 01:41:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac517a442sm179351675e9.36.2024.08.27.01.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 01:41:04 -0700 (PDT)
Date: Tue, 27 Aug 2024 11:40:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: added bound check to geoid
Message-ID: <8d62104c-ac1f-447a-8b53-cad4e66a6c8d@stanley.mountain>
References: <20240827055555.65371-1-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827055555.65371-1-riyandhiman14@gmail.com>

On Tue, Aug 27, 2024 at 11:25:55AM +0530, Riyan Dhiman wrote:
> diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
> index 7f84d1c86f29..d93a5d428ab9 100644
> --- a/drivers/staging/vme_user/vme_fake.c
> +++ b/drivers/staging/vme_user/vme_fake.c
> @@ -1059,6 +1059,13 @@ static int __init fake_init(void)
>  	struct vme_slave_resource *slave_image;
>  	struct vme_lm_resource *lm;
>  
> +	/* If geoid provided, validate it is positive and less than VME_MAX_SLOTS */
> +	if ((geoid) && (geoid < 0 || geoid >= VME_MAX_SLOTS)) {
            ^^^^^^^
Too many parentheses, but really there is no need for this.  Just write:

	if (geoid < 0 || geoid >= VME_MAX_SLOTS) {

> +		pr_err("VME geographical address must be between 0 and %d (exclusive), but got %d\n",
> +			VME_MAX_SLOTS, geoid);
> +		return -EINVAL;
> +	}
> +
>  	/* We need a fake parent device */
>  	vme_root = root_device_register("vme");
>  	if (IS_ERR(vme_root))
> diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
> index d81be8e4ceba..97323b5563e8 100644
> --- a/drivers/staging/vme_user/vme_tsi148.c
> +++ b/drivers/staging/vme_user/vme_tsi148.c
> @@ -2252,6 +2252,13 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	struct vme_dma_resource *dma_ctrlr;
>  	struct vme_lm_resource *lm;
>  
> +	/* If geoid provided, validate it is positive and less than VME_MAX_SLOTS */
> +	if ((geoid) && (geoid < 0 || geoid >= VME_MAX_SLOTS)) {
> +		pr_err("VME geographical address must be between 0 and %d (exclusive), but got %d\n",
> +			VME_MAX_SLOTS, geoid);

Here you have a device pointer so can use dev_err(&pdev->dev, ... instead of
pr_err().

regards,
dan carpenter

> +		return -EINVAL;
> +	}



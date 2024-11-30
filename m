Return-Path: <linux-kernel+bounces-426134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F509DEF5F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 09:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FC14B213D3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 08:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9CC14A4FB;
	Sat, 30 Nov 2024 08:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KzAhad+v"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC033F9
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732955505; cv=none; b=nms/o4I8WB4e1nHP6BAXSULKe0s5GrNhfhd7oYCWfqKXm0jYmpNyfiaFNfvj45N1HXxtfGPf7a7/nDuLY8GJFJUKZlaHFGwivzDRQe9YF9RC3oFWxcvrjoZB2X/SHM50XK7lfQB5DunQb6CI84ofeKcvL7/IYaszmn/XjcVNmQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732955505; c=relaxed/simple;
	bh=2vU3DW+i1nRl5BuWN6iuv1YL42295447JcJg71SdVrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwC0AutEd/QTJlnnwwAENNGWnKYprVNxGb0kDivbxm38hfZq7wFCxj1qE+wYbrk8Ww7JgzKB6Xv70mibihEdN68lH0riFpe0xzoJVEvbjn7nXmNI8LnN5Y5o4rWlBKwLXD0i8q7XU3iFRejw3iXEpSDVtpuksZO+1asK1ueT0aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KzAhad+v; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ffe4569fbeso20311131fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 00:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732955502; x=1733560302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jAlLAAAGM9bVH738rgOjUvG+kp8ufe3wXv46mmUzS24=;
        b=KzAhad+vzp08qvJKtNcoq6+1Bixm2r9J/KmKKb8n33YGUQs/CWLc85Zj38Wx51wSVa
         CfgQWhVHjKW3gdATtQolurTkofnGt9LS1Vgv67rRgU4lGvXo4y6fkVO2ptNab75hMIRD
         Dsu828TPYjDP+RgQNM3k1aGhuaxZ716BVCi0zwEZn6FL1aw7vTKSXaYQ7oOTJibCAA3S
         AcUH3Oksl5uukTF86WV1ViMozCSki5e0b/qYbzHE8Crep9E+mTWqzi+acDYfhghsBI1s
         LkEFh5dvIKIc6DL1enRXiQ5bv591a82SKfjDUnwzANJWDUgPndIfAZ7fF2FECJiGg+NO
         MOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732955502; x=1733560302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAlLAAAGM9bVH738rgOjUvG+kp8ufe3wXv46mmUzS24=;
        b=mPl0LA998AzTQTQHdzaMwAgIJ9NtXCgQnc6I9Fv4Mpa6DPKJerzjzDgPZnNl1oaSye
         OkSMw3thKg/c4kz3Dxh8yxzfBe3eDL56zu0haRqoXlM75jE9kw7iNXc5NFmnagOhBKeL
         Cbu6seowLgeu8h+ACQllJz3kEdgjTpzIhSHRVdXUAnMoYtW99IJiYKe//BqzcHlAsxwb
         CyBBIhpq4eK19oKWuKs1qFoR38LrUlYV3uzrQf2XkXIy8SUyyTif9e6YJSfts44wHmQd
         r1v/1qz85hfRNIPvEL1kQB7rrxZlpsm4K3OkJxWtglCalqfZMiW4kQCzYrOMpm03kJXU
         4D7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVlyRf4WEAELCEcm5XtwBWcBC/fVKVyf6jlvEy8PLkQ/6kkg+OMfmPrRPbwGrg7t/oj4/jD30NAYJgLu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9m0Bb+8dZZzltktjnAaT3BgxGE5uiYrtvKFylwCZx/5dggjtc
	ZnYYNQOPZqRp8LCNNfNNQg/gaECqFMyaZIpgSiqr53et3eSkflgbedwZCVEEgLvcxf8RSaEnxLn
	s
X-Gm-Gg: ASbGnct4qchx4nI82HZoMA7gWV3grw7VO/ba7feoqo6g0ziNldKTyEXFCXy+q54QTkk
	FqZDfK8d/LgrLhfAfLxkGwYA5eqBc3SZqg0VljKRq9k5pS958tkVIT7NYQ3UEhZ6FfyKIB6g/Nl
	EcAjAqtPcP0ZjsbKjLhCGHYKA+XMvHXlmjnlY2OLajYDC7lFKiMY9ChDaTlTOkH2IRVVhivXn5f
	karhTfLsVKVBEmBy9WmqpBKMoEYmgHicSms110JQBmH3h+QlXNgcoXeXD47S1phYik2Op4zOxUV
	qicmUPKoCNBRmsKB7vPicDkgsy1zZA==
X-Google-Smtp-Source: AGHT+IHqlibCJpfN5cUZPPd4TL/8XxztYBv4PAhJSEPCWQRqaxNuibgDwkMBYYVSBLF2QupVe40mkw==
X-Received: by 2002:a2e:b8c3:0:b0:2ef:28ed:1ff5 with SMTP id 38308e7fff4ca-2ffde23dfe7mr37315291fa.15.1732955502004;
        Sat, 30 Nov 2024 00:31:42 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbb8fc5sm6296371fa.22.2024.11.30.00.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 00:31:40 -0800 (PST)
Date: Sat, 30 Nov 2024 10:31:38 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Guy Chronister <guyc.linux.patches@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm:panel-orientation-quirks Added DeckHD support to
 panel orientation quirks for Steam Deck This commit introduces a new quirk
 to handle specific orientation issues for DeckHD panels on the Steam Deck.
 The quirk ensures the correct display orientation for these panels,
 enhancing the user experience on Steam Deck devices. Tested on my Steam Deck
 to ensure reliability. Feedback and further testing are welcome.
Message-ID: <t4faz7cyi5lnib2zsxxv3j5ykltrecsjee6hrb3ky2g6gdypju@6u6ggrhuisjr>
References: <20241127203545.17475-1-guyc.linux.patches@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127203545.17475-1-guyc.linux.patches@gmail.com>

On Wed, Nov 27, 2024 at 02:35:45PM -0600, Guy Chronister wrote:
> Signed-off-by: Guy Chronister <guyc.linux.patches@gmail.com>
> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 7 +++++++
>  1 file changed, 7 insertions(+)

It seems that you didn't break the subject / commit message properly.
Please add an empty line after the subject line in the Git commit
message and post v2.

> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 3f2e2b851cbc..c412273799cb 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -456,6 +456,13 @@ static const struct dmi_system_id orientation_data[] = {
>  		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galaxy Book 10.6"),
>  		},
>  		.driver_data = (void *)&lcd1280x1920_rightside_up,
> +	}, {	/* Valve Steam Deck (Jupiter) with DeckHD */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
> +		},
> +		.driver_data = (void *)&lcd1200x1920_rightside_up,
>  	}, {	/* Valve Steam Deck (Jupiter) */
>  		.matches = {
>  		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry


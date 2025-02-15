Return-Path: <linux-kernel+bounces-516358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F52A37019
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 19:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701AC188CDB0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8A61EA7D1;
	Sat, 15 Feb 2025 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rxpai/9g"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B8B1DC9BB
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 18:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739642960; cv=none; b=LtAxLjkeyNR4A5KsyiPnWfg5EJ0S584IZvvZqI8qjFUDCTZP3VEIjrYUIbW6p32lAbF4M2ehi9rru4U78R5+TQgK78lAA6iTL04vQAEFRsIJXcdz8jfPWSQs9B5X4D/7OeNzmRM3eTCyWni1ABB3n5/U2x2LsQGLd3AYfieLWp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739642960; c=relaxed/simple;
	bh=15rssCfKMTilTq8EURyKsVA3WP9YhrGVgBbF5uFWkcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cT7sTtV/39JGwJBiUR2xPCJK8HfdeX2cQusZnPZ15BjO1H2Ye0rPgq1BproIKw9+12Xb7O5m7xEU/yNTl6evSa9q1iy5JCERrGCi31b8VQJZiTeHgRLxRnqMYKTgWAUz+CHTfuxrGW3eWlV1Wo11477w1y8hHBQ8502yorrZ10M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rxpai/9g; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c0893f9aa6so96025585a.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 10:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739642954; x=1740247754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NPF/Alw+//gUVq8mrgRf1sA3HpgcZBGZ+ed5dpOL9uU=;
        b=Rxpai/9gvE5emvOAheIBBTm16HKzGR6aUB95kJde7ip9ADje7qxrtPY4//zFj2BlDa
         kyGTxfJH45u7IX7i75CemgS41VeU6X1u1erXVxR8xrnmR4QTCDjKIp5qV/xKmE2X4niX
         ZXTiXyFtQtuUkiQwcXc1Qj80EgxHfnYP5WNPZkR4RJK0qdylylmKJ0qd+nejBVg8TtZ6
         uCHjOV/nC4Am1w8ynoDyIz6x+ocSEdOAF+5Yrry/Jhg4UyB9PJTCBQ6PG7LjjmLVdLex
         BayFDXwGp8ZgLi6Nwl0y6w7fuPlmyL0o+jf3hOGgpOF7Z2N07BAny+Gbpi6TevRlH9Bk
         Lxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739642954; x=1740247754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPF/Alw+//gUVq8mrgRf1sA3HpgcZBGZ+ed5dpOL9uU=;
        b=dALS2HptuEPDmKIBC/ZMktCNdy7f3YtcMGgB9YQxORj7BCocx3bCot5UFCqqISMQfR
         PBZSMjB7x9Q5andSpcRXdoJR5KqMmYehedTNH8Z0eDwT6oF0bJLGMIMJdl9zjw+RsfNl
         Y9LMqa0nG3lbHtdgZ/FJDvFEOWtJBX33rMnO22AWJLgzUfvItwfITum0ag6GUGrUD4L3
         Q251dHngLh7RgXORe//Qp6G4M7wpDi19kyAxl4zfdi04rOlwYIGQGnV2vpV84Q5Jxher
         0QXkgRLv2gj9FevfMuvgDwU0SpZ6NpwS07DTOJv42p10EM4URd6M4bPX8xGoUXxMrXSq
         yqOw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ4jZwDCb1X3Ixmua6M1uxvoRephbrr5M+NKrS3Eys6NO+tj8229J3NTyRp5WH6yOZ3PEqdn6OL4PLSLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5BteKD3olzNVvq+Ju6rRj/WgeTjfvJYCYmZz3sNFnjRbTMacV
	sgRxcNgH55SszicUk3zW+D2r2sF6ILZJndFqGD09mkZlBuLNUaZ5
X-Gm-Gg: ASbGnctAX0n5+W9coolQUHXPK9W0/yqlnb5HNtVRLDMaf4RM/cwks22uQlL74sLOt2M
	Q2VEn55HlPyDj1ZCiSe4d1Jba7haiSW/4/c2DPOZ6+alSeDEHNO7PC2qjZpiPqb/l+HqmmkuMv3
	2oqviWKIRC+TEZNFlS2n0+NWfMpsSWAglUMPPGFnlWLM3H99KPPkYC1Rk/5Z5gsJT9k+hnOxTHk
	KbTvXkr+ANP0OJbIP8rTayW3SZzhvfrs4bzUYKatp4PBCyODKcyIeCBl1Gwo6625LJmqcMsuld6
	C6lDBLQJCL3ZtAiJaWwYC12X+exu+gZV8srVk32FXKnv0LIxmRE7
X-Google-Smtp-Source: AGHT+IEl9KdRZhqzx5Xxn8OZkjroz7UixGi1SO9rhPskdpCEoIBJLhf+0gV/LBbwxGIzrqNyLlXW+Q==
X-Received: by 2002:a05:620a:4441:b0:7c0:7f07:a635 with SMTP id af79cd13be357-7c08aac61c6mr588315685a.53.1739642954075;
        Sat, 15 Feb 2025 10:09:14 -0800 (PST)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d77927csm34123606d6.10.2025.02.15.10.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 10:09:13 -0800 (PST)
Date: Sat, 15 Feb 2025 13:09:11 -0500
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, David Laight <david.laight.linux@gmail.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] drm/repaper: fix integer overflows in repeat functions
Message-ID: <xn7ikpjzqddnrna72ojiitufruemineonyhh5cmwizrrnt4txp@gh2sy6ixddx7>
References: <20250116134801.22067-1-n.zhandarovich@fintech.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116134801.22067-1-n.zhandarovich@fintech.ru>

On Thu, Jan 16, 2025 at 05:48:01AM -0800, Nikita Zhandarovich wrote:
> There are conditions, albeit somewhat unlikely, under which right hand
> expressions, calculating the end of time period in functions like
> repaper_frame_fixed_repeat(), may overflow.
> 
> For instance, if 'factor10x' in repaper_get_temperature() is high
> enough (170), as is 'epd->stage_time' in repaper_probe(), then the
> resulting value of 'end' will not fit in unsigned int expression.
> 
> Mitigate this by casting 'epd->factored_stage_time' to wider type before
> any multiplication is done.
> 
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
> 
> Fixes: 3589211e9b03 ("drm/tinydrm: Add RePaper e-ink driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

After discussing with David Laight I cleared up my concerns.

Reviewed-by: Alex Lanzano <lanzano.alex@gmail.com>

> ---
>  drivers/gpu/drm/tiny/repaper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
> index 77944eb17b3c..d76c0e8e05f5 100644
> --- a/drivers/gpu/drm/tiny/repaper.c
> +++ b/drivers/gpu/drm/tiny/repaper.c
> @@ -456,7 +456,7 @@ static void repaper_frame_fixed_repeat(struct repaper_epd *epd, u8 fixed_value,
>  				       enum repaper_stage stage)
>  {
>  	u64 start = local_clock();
> -	u64 end = start + (epd->factored_stage_time * 1000 * 1000);
> +	u64 end = start + ((u64)epd->factored_stage_time * 1000 * 1000);
>  
>  	do {
>  		repaper_frame_fixed(epd, fixed_value, stage);
> @@ -467,7 +467,7 @@ static void repaper_frame_data_repeat(struct repaper_epd *epd, const u8 *image,
>  				      const u8 *mask, enum repaper_stage stage)
>  {
>  	u64 start = local_clock();
> -	u64 end = start + (epd->factored_stage_time * 1000 * 1000);
> +	u64 end = start + ((u64)epd->factored_stage_time * 1000 * 1000);
>  
>  	do {
>  		repaper_frame_data(epd, image, mask, stage);


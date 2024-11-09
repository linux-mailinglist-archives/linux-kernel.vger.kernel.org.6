Return-Path: <linux-kernel+bounces-402725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A65BD9C2B01
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 08:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B743282BF8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 07:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0B613DDA7;
	Sat,  9 Nov 2024 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wmhtFJ62"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACCA1DFD1
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 07:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731137264; cv=none; b=BfwfQrIDvwdSXPAU4y3w9dYmAxp1w3Gda/dIGbVX1pz5X1utKtRsD9EtFxZ+aBVjOecZ0gm+W3hKWhxmRvsi0w3cre0kdCBzvhobtBcqdGUlWxHrZ+p65Gc3lC/FthscWwgx6CaGVEbrzH9fnLF1spSVlY5yXSAHXKQhSa6G9Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731137264; c=relaxed/simple;
	bh=Hc+bt49KwT5u866HdPmotplZCxEi/SoIiFxu85fy+GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDgvwbdUOAvI/W1w9Mex5nZkiaJj2/sYbqIdCBjGJJfd1XhwJo9HqOw9L2klQf+tK4ABQT1wBGCj1y86t5txKeGHLVuItKoN5cUt0fV+23FLX8qDdhtjZsxIFI87FiLT/+Ipwo6+Ga6edxd67CSWbbw2ndznLdf+OViC7RqPbgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wmhtFJ62; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53c73f01284so3541341e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 23:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731137260; x=1731742060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B9fI080awPbonlrkWrLsFoWwGLZIeSfif4j0EfQsirw=;
        b=wmhtFJ62VP+CjC3OnbFRtlaFNt05cIhZojziWucfX7gTIiFjUTxTB5IuUWOaoKx0kk
         2R9Xvk7NaJZolXYa9+sO0SDX8O/IPYMlTR7vJ1f7smuC3lswxR43fcyr8XcGdi7n+4E7
         YKkdK2F+B1FQiHtuDbzDBAyXxB7Xx0/5UoJx0qJALN23xZ70PTGdSrfpRK805pj70hSx
         KazT1xp2oVtCAqoSidHW8HBLr/dXTPRzLDpRtrm7YKE9NipieV1AswDUz/KE+1hfKLhb
         kA0WI13XDB+USxdGsLSE1KO4FpTo7q+GtVdz1J2yoqCF0IRnjdwVOatF8sWyB/UTJmTO
         Fy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731137260; x=1731742060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9fI080awPbonlrkWrLsFoWwGLZIeSfif4j0EfQsirw=;
        b=d1cQ8qre4e3MKMfbZ/MW2WkzXg4EFwCsZhXmXJKTgUITtTy06XKGeflXL8MMFGSk9d
         +NAHC1IZyfgj75jcPPaezKtJ202rWrUmAgtm5VU4bvLgwDkvoMa4r+SNg6I+XjlQzDc+
         Yk/2dQlrZp9wWSkq3p3tHgw8x5+5yZID2MfBNvY0byYbovHU+XgE025NOKXC3KCEVXcl
         IKMRsN71Yx0wJxfyUOey06OfaGG+xLg4NxHbdM3Cx80Vgxofgbl3hclkrXBE0Tv9CmTH
         TNuFElytbYgjjQ8ZEUQuX2MgJHeU9i6c6IGulLAYhBLtfV/Knf35uffENja/D18m0/vY
         nTUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8T9klrpTvqzB/IwHf6xiB4P3H9Ft+KMpQfgaIFtzfFJzi0wUdKEjXY1MjOGMvNK/CC51U49QsHegAy5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLVBiNI/fC/PTOIJui4Xm9FjZXMCOwVpoYw6b9yM9Q+eDu6NQO
	mbjAI0Br6sJZYE1AhpIwSBqJ89+ImyWOdeafFp0HsEh4xd4aJRacqLie3PFF8hY=
X-Google-Smtp-Source: AGHT+IFyOhoQ+rfgLRCoNb7gQKLETRW95YFlZMv2VhExQEiHrCZG8nl7kXlwjl3ffuIpfwgnFGpLoQ==
X-Received: by 2002:a05:6512:b93:b0:539:f689:3c30 with SMTP id 2adb3069b0e04-53d86289e48mr3033987e87.20.1731137260094;
        Fri, 08 Nov 2024 23:27:40 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826787c7sm859897e87.6.2024.11.08.23.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 23:27:38 -0800 (PST)
Date: Sat, 9 Nov 2024 09:27:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] drm:sprd: Correct left shift operator evaluating
 constant expression
Message-ID: <exeho44dd45ujgha6jmnvt2idbq4twfm3d7lxmhbfgfeujyhmn@tohr2hoytwhl>
References: <20241108-coverity1511468wrongoperator-v2-1-72bc73d8691f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108-coverity1511468wrongoperator-v2-1-72bc73d8691f@gmail.com>

On Fri, Nov 08, 2024 at 05:11:25PM +0000, Karan Sanghavi wrote:
> The left shift operation followed by a mask with 0xf will
> always result in 0. To correctly evaluate the expression for
> the bitwise OR operation, use a right shift instead.
> 
> Reported by Coverity Scan CID: 1511468
> 
> Fixes: 1c66496b1391 ("drm/sprd: add Unisoc's drm mipi dsi&dphy driver")
> 
> Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>

Please drop the empty line between tags.

Also see Documentation/process/stable-kernel-rules.rst

> ---
> Coverity Scan Message:
> CID 1511468: (#1 of 1): Wrong operator used (CONSTANT_EXPRESSION_RESULT)
> operator_confusion: (pll->kint << 4) & 15 is always 0 regardless of the 
> values of its operands. This occurs as the bitwise second operand of "|"

Is there any kind of a public link for the report? Should there be a Closes: tag?

> ---
> Changes in v2:
> - Added the fixes tag
> - Link to v1: https://lore.kernel.org/r/20241105-coverity1511468wrongoperator-v1-1-06c7513c3efc@gmail.com
> ---
>  drivers/gpu/drm/sprd/megacores_pll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sprd/megacores_pll.c b/drivers/gpu/drm/sprd/megacores_pll.c
> index 3091dfdc11e3..43c10a5fc441 100644
> --- a/drivers/gpu/drm/sprd/megacores_pll.c
> +++ b/drivers/gpu/drm/sprd/megacores_pll.c
> @@ -94,7 +94,7 @@ static void dphy_set_pll_reg(struct dphy_pll *pll, struct regmap *regmap)
>  	reg_val[3] = pll->vco_band | (pll->sdm_en << 1) | (pll->refin << 2);
>  	reg_val[4] = pll->kint >> 12;
>  	reg_val[5] = pll->kint >> 4;
> -	reg_val[6] = pll->out_sel | ((pll->kint << 4) & 0xf);
> +	reg_val[6] = pll->out_sel | ((pll->kint >> 4) & 0xf);
>  	reg_val[7] = 1 << 4;
>  	reg_val[8] = pll->det_delay;
>  
> 
> ---
> base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
> change-id: 20241105-coverity1511468wrongoperator-20130bcd4240
> 
> Best regards,
> -- 
> Karan Sanghavi <karansanghvi98@gmail.com>
> 

-- 
With best wishes
Dmitry


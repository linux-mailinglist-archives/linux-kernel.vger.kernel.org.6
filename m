Return-Path: <linux-kernel+bounces-249475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8047492EC3B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DB4CB20CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8AC16C862;
	Thu, 11 Jul 2024 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YTrhPskK"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAB816B38E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713855; cv=none; b=mRFIzWmsxNSccR4sBszBLs0q5zreKU8UWxlRdxvj3gzaVbUShx7CR+YowNrtYluEN9yA1FZKqVQDS7YT4cil4wP/FVETSfq4ebsB6cvd+RLr9MdTSvybpcGBi9TGN6A3c0NMUKwCjsiaTvP31GTztcXvJu4UHsWkkPY1gftxoLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713855; c=relaxed/simple;
	bh=UlomuCi2jufaKAgRER7mFTLXjMfqKIuCEo1u/GmUxXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFzXUR5FxtAUCyT8UxCy+bGeprVH9xN2Nk4ldBfukIkz3bWO729Lk8UcSTQQPw5OEfrx0ZvrcbUA/AC4Cp2rmZs+CDjJfPOv5/JFNu0eKr838DJUCfYbf9VlqVPJCX6X13ZQpyjmBhrFT1QQYF+1mSx7yQkjF6sisUg+JtMV82k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YTrhPskK; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5c477d97159so597289eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720713852; x=1721318652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jJRhE3D3xf0203P+ET/Sk8dDphxVA1D2zZsW0yadFHg=;
        b=YTrhPskKSSzbEcmULdSbVD7301IETT7/a2O7cpB4J+LEu75veXBb3eR9Wyir1nlfLk
         XC3SPDhsTXl2zxX1cdAhdfex6J5CmJcB0vSv2Y309yIYLeuV5ozUmmTt5yKLQgMr9HdN
         r7xkQg9u4UIlbuQzIuh6yrH3sB1arBzd2rSBCe4bHmLPeb8x/3egyF+nwnUGY5bP2seA
         PhrUmyOdGgMc9F6OnUiGH+Xpq0m3YdLhx6Gz4VRQnNt0L9JSZCGcWMiklKiBKHagpTxZ
         z2hkoon+BVh3sYPAwhwzGVhQgnPrxGrhC88pHKtS2+iQ4wLofH6unjXmS5ea6cXpyHoc
         op5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720713852; x=1721318652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJRhE3D3xf0203P+ET/Sk8dDphxVA1D2zZsW0yadFHg=;
        b=kzXpS3hB/WppYeFS8QB4XF60EJcwoTGo5nN4rLN9D404SvGS513cKq6FskSMvjpAwt
         ve6VB3bTzyO6Ar70Fv7ZVGUcufHneSwn/+rCH/ZuCEHdAMqOg71xuKo+TVVJJgYKOjtK
         9rrPmSKb8YuAe65z9lilKxKFj7RNUceydz1J/vxl/i/gXGPjroZa8BucXrex3I3ccvA8
         sRSfna2u7fbSjath+UIEKOzed5dpqOOP5uBjPGXs/JEb9723dW8Dr1NL1nA9K2CCkc4P
         BKbbSzs6VlYcgnrl9B8Qvc+bl+SaJvYZCMXbj/8S4HHnd7xMyYmU+1jXh2DSKwdKqP7M
         cWbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnsOySUpO3yKxfCyuVzfebIKCwO7TSN3i59480/P7skxpsYNIN5Shpn2X2Mje0VjW8Pd67UgzQZlxBbUktKWOK0tA/6Rpy1FVm+bEA
X-Gm-Message-State: AOJu0YxZyfSAsvukaEl2+NnYU7WTxHCuHGeRl+QWphXymtJqIqlfmZMR
	lbWwayGXZiAZTRDDkz+xNZvSeRflOpvzdF5dF+F96sbIEsycQUMtqROrrgjbmUf6knLAxzNfvBM
	CYFK2Oo2UDXNbOpKDZyPHJqzehBjfq1C/uPFEIQ==
X-Google-Smtp-Source: AGHT+IHuIlKldLtTOQoLFnrewN3z8O8n69aqt+rXEcv+GsAIFjWQw6LCkcziQCx6eaN3xVdkr1up+9hn6/jeaKsoh+A=
X-Received: by 2002:a05:6870:9727:b0:25e:1817:e4ac with SMTP id
 586e51a60fabf-25eaec16f18mr7346929fac.42.1720713852312; Thu, 11 Jul 2024
 09:04:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711081838.47256-1-bastien.curutchet@bootlin.com> <20240711081838.47256-2-bastien.curutchet@bootlin.com>
In-Reply-To: <20240711081838.47256-2-bastien.curutchet@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Jul 2024 18:03:36 +0200
Message-ID: <CAPDyKFqzR4VJUHW5EHf7-vzZ=TNPDAngFYQfksduqgcx1qEAkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: davinci_mmc: Prevent transmitted data size from
 exceeding sgm's length
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Herve Codina <herve.codina@bootlin.com>, 
	Christopher Cordahi <christophercordahi@nanometrics.ca>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 10:18, Bastien Curutchet
<bastien.curutchet@bootlin.com> wrote:
>
> No check is done on the size of the data to be transmiited. This causes
> a kernel panic when this size exceeds the sg_miter's length.
>
> Limit the number of transmitted bytes to sgm->length.
>
> Cc: stable@vger.kernel.org
> Fixes: ed01d210fd91 ("mmc: davinci_mmc: Use sg_miter for PIO")
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/davinci_mmc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index d7427894e0bc..c302eb380e42 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -224,6 +224,9 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
>         }
>         p = sgm->addr;
>
> +       if (n > sgm->length)
> +               n = sgm->length;
> +
>         /* NOTE:  we never transfer more than rw_threshold bytes
>          * to/from the fifo here; there's no I/O overlap.
>          * This also assumes that access width( i.e. ACCWD) is 4 bytes
> --
> 2.45.0
>


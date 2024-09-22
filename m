Return-Path: <linux-kernel+bounces-335181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AEF97E24E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 17:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C95281153
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 15:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051A0D26D;
	Sun, 22 Sep 2024 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j5984OLk"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96733173
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 15:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727019120; cv=none; b=b6oOFfq4x3b+346urmffuPkyhSW1gvwTg2gp/RGAGxUy0jgymHQzevXdZ1/mh/70Rk49qDOn9DV8Q535stsNw+682Qa/IWEr+xn5EzTyakwPqJ4AKFs67FjwVGKY9EGTGBO2CrYHU/9iYsSXJnyW3kEc/3wF1NH3MYqL833eQ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727019120; c=relaxed/simple;
	bh=e30nyjvbgpfZbvKUdHV711kTPMJZVLSYITSi7AGNGmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+Rl4okigOC8/3bLdvTkTiPE5dGbfwHVt8l4C4IuWwRduBBAUrw8Fs5HgSr7kZkJf2zK7mVw12n90vAVZODFsTptW7O33R54LEZPTc4TcyUWumyKtjP6zTYHNdtkNU0FhoUzdad0PKZS4oDrM3hKpmLyzlpzk0c8O18HPT+a+/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j5984OLk; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f78b28ddb6so31777441fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727019117; x=1727623917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rBu+yMt4ecuORUuNgnAITQWuifw2CvZPRhFerzqyEAs=;
        b=j5984OLktvn3spE/o/y2KBzLuB/6oUmvqICvmK7zb/Vgo4NyTlDb54p9WGSz+aO9eu
         1uU7g4TanNAibiqEMdbsph2oZoS+2kie2pJxDesSLTjRiGPDr6kMDIRb6b1YDBBqEym5
         HVqbFfn7lc/9CA4GtUMWxxVsFwRs5Umr3tSIgt6uGjSk6YnBGdkByf9S5xk4J7zBo1iO
         hUhitsdOLV/OO0IC9EIL4/KOjY1N6KY+6iNVfNroYo/Ye5qlxflz93UktK41sxKwn8T4
         GmYe1UnKtgHqi1fbqCEUIhf8kwpCOmh4lfg+xzYmqaBdPSe1HB9zmeTAPMUr3M/rxzkM
         SDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727019117; x=1727623917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBu+yMt4ecuORUuNgnAITQWuifw2CvZPRhFerzqyEAs=;
        b=oO1OidSQPofJnLwRuWKrrhxkjMhNmUbAU1NvgolTrArTyL5BZ1kklcJhM4rXFCJEUJ
         uuIUJRNn6RGaOkMiH2V+KsgPs6scO+3d9q4wcRlOjqt9nEBWSHo9fpC51dkhvx51Eww3
         DlcEHe+6deAYtKv3h2/7YDMkbEbVH4U4sKUXHTdPlESdAnjajVNz+Q2CCFICzzZtpRIQ
         a4/RWHd06QXayYpys1fvWQRv/bnNcYYH3PPUi1u1Tl3QWRnpPZdRBUls0KAiQJpOUlP5
         7JbsY1JxCPBXXT/GoMy5+Q+lZNLdJp++GCpnL3ySGVgcZLyqNGMeODPr08DHfVJAS+Y/
         96zA==
X-Forwarded-Encrypted: i=1; AJvYcCWrjie3+tI2Ss/HFvApHjmX6JVfuvRgB4KpRUdvLihHKuzGP2gPTrbiBnu7d3yrd+Fq2t0JsxWEZR1gTes=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLerg2geYiLV3jEuqfZISlVRDU1Z/1yWNGNC3A7XXSggq6Svlj
	SH2Sb3oFmIrgNANM2Gi+EXhSvqS9xiG20yj8ixFdfAdgzHY8vdDudZ/AtTq3UUc=
X-Google-Smtp-Source: AGHT+IG5Bx8ECod33hSVelLeBxGFnMm3FDCUTkzDlOHsUsX6e1LsUv6REs514b3oaLgDEYh3kPkqgw==
X-Received: by 2002:a05:651c:2205:b0:2f7:583e:e967 with SMTP id 38308e7fff4ca-2f7cc5c4681mr46521891fa.40.1727019116597;
        Sun, 22 Sep 2024 08:31:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d3012bcsm26424971fa.45.2024.09.22.08.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 08:31:55 -0700 (PDT)
Date: Sun, 22 Sep 2024 18:31:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, jani.nikula@linux.intel.com, 
	thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: writeback: Introduce drm managed helpers
Message-ID: <rz3xk3kwwsfstjrqffp4vfkm7mvn5sdviwjzb5dodmsnb5v2fz@vuamquxmvt4r>
References: <20240906-writeback-drmm-v1-1-01ede328182c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906-writeback-drmm-v1-1-01ede328182c@bootlin.com>

On Fri, Sep 06, 2024 at 07:28:17PM GMT, Louis Chauvet wrote:
> Currently drm_writeback_connector are created by
> drm_writeback_connector_init or drm_writeback_connector_init_with_encoder.
> Both of the function uses drm_connector_init and drm_encoder_init, but
> there is no way to properly clean those structure from outside. By using
> drm managed variants, we can ensure that the writeback connector is
> properly cleaned.
> 
> This patch introduce drmm_writeback_connector_init, an helper to initialize
> a writeback connector using drm managed helpers. This function allows the
> caller to use its own encoder.

Also it introduces drm_writeback_connector_cleanup(). Ideally that
should be a separate commit with a proper description. You should also
document that existing users should call that function (and maybe add a
WARN_ON that can check if the function wasn't called).

Last, but not least, please don't add API without a user. Please switch
at least one driver into using this API.

> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
> Hi Maxime, Jani,
> 
> I tried with this commit to implement the drm-managed version of writeback 
> connector initialization. I tested with the current vkms driver, and it 
> seems to works (at least no crash/warns).
> 
> As suggested by Jani, I only created one function, which takes a 
> NULL-able pointer for encoder/encoder functions/possible_crtc. What do you 
> think about it?
> 
> Regarding the documentation, I think I repeated too much, can I simply add 
> comments like "see documentation of @... for the details / requirements"?
> 
> Good weekend,
> Louis Chauvet
> ---
>  drivers/gpu/drm/drm_writeback.c | 224 ++++++++++++++++++++++++++++++++++------
>  include/drm/drm_writeback.h     |   7 ++
>  2 files changed, 201 insertions(+), 30 deletions(-)
> 

-- 
With best wishes
Dmitry


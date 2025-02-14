Return-Path: <linux-kernel+bounces-515264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687B2A36298
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F6916ED80
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD44267396;
	Fri, 14 Feb 2025 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rcyOfamJ"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30956266EE0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548964; cv=none; b=Z/0eIC7u4YosAo4XtMVOtn2p75+4H8oJ+Nr25i9qNeFA97/fBFx5JE66kxana9aemvv93B9Usqgg5BcX8pnfpS48Dug6xjFPlw8fFI2PBfBMnWC4aO9VOc7nlULFoLN4Nz+sQPw6ExdrX6/N7y4Zgtz48y7c2t0HgE3hkg/MXsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548964; c=relaxed/simple;
	bh=7McRpc8Sf91JR5HwdKzNfIMCUoHTJyI13yOxt2JXQwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrhx8X6O5nfNstLJM61nVNiqvNuQ8k+32vNOLjAUjCsLhxpLHO+HgC8gGQA/DozgkuPyHfEhM/0K1HarHouXWtZRJfeF4CglUtIELZfEHctF0xNnL8UpC2xfIFY5oVpMCakkeC3Wqrx/q1vQUAVLIxwlCPZuv39KO25b8w40Gpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rcyOfamJ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-307325f2436so18408171fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739548960; x=1740153760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ni8M+7fnHjZEMfJNA97DV1PZ1vn01NK3p1wwHVgLyMQ=;
        b=rcyOfamJpXrPwb2DhmgIPU6E0QXk9K5tj8sYoDBGSwfwLPw6FNzu9LSDUg803NpLwF
         C831p9E4cgH9MrRBfSadqbZpvo0YcXUa9u6NJZR7zRot0TaisDFsig1v4+nERYdw2i9M
         VDy3XMxAX+flwy4qXwqcUctD5bUmotaCnV7PjDMFNKKXDVxTWkwrJ8IBRSsuqchRkB3n
         f0n6kNg2ldVuGB26Bxsr3oBm+rtBouoBCaRb6qTfQEBzO00RDuxTT6uWG0RQc0muYIog
         SJSoNCDI+4VK0ZiKK+4DL2UpM8BcrL6vxVVuWk5l/GRG0rgQKP4ZAadduB3VmqqiaPZQ
         1h/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739548960; x=1740153760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ni8M+7fnHjZEMfJNA97DV1PZ1vn01NK3p1wwHVgLyMQ=;
        b=HIvtBvg/eePQ9iZ8Z8l7RznAlr5lQjQr0TuRgImoJUuXRJO0FzksYyQcd6HzFUF+xd
         MHD3zR6Dl2+54y7T47mIS6iAIwOFtb6a4HQ6atVg0TcwYKGy9prpQdQdJgLjzmTMoZAl
         nMCpjRD8/BmdtUUY4+haYxrpq2cXSShG1Z3KScCG579K5d49O3dAj+sZKAOg9QwM4yFd
         hz8xpK744ufZRSM6+QFZu7Hn9H2l2n+c1/OTzzvA935I8syeubtH/W9qB+A9S3wv3e7S
         O1RHWJwOeJgLpwCn32shFQrG99g6T/hzgyA2l4BKyhbcoga92w7q94RnnE8CxMV4zTJ/
         BM5g==
X-Forwarded-Encrypted: i=1; AJvYcCWDGGle2xPgnOkLy26S5H7FqzvHO+QUsvAJ5LyZoki31mSl1h1SGhPxmG2pTHlYOsm/uiilAfRn3HIA+Vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEsVlZCaZitO/yxifg6d98571V43VQcuy8qlIeMSxzuOoCyRUd
	VcC+q9gUuSsHzp5YNIoDVOufzA5/PLwnLyNrFVnJQrIkXdzjAGZwH9KV9wnWKKk=
X-Gm-Gg: ASbGncuAh+WzbwnaQi4vLZMa0nhwfO7EyjFi1ZR7XMKssKKGLZt4W9qBf2/pMEcm33J
	1QSQp7gYsBTI0QuR7YiHOsbh/dKvTn1M7OrjR6ljtJUE4VQaxxT8apbm0DGsHTvq1R2EZ9ZU0zg
	CNg6IOvRse8aJVb1YqT1c2e1M6JYoZ/qGbpGk2tJH8WKGgo+p24ld8/IyclFTNuRhvYf28Ah0fe
	WmjhTL/0Sjr+N2WUHkNpwaU0nXefFyu+wEJ5SP+5zsT4Ngdda4AXwluKqG++USPH00+M4oB+tLR
	cRN+cPS40pYUCk0zj6avoYd+RvD/DEQXvgx6Te6Q0fQEnmIWTr7S+R1GmtSLWmh/zLSxu2Q=
X-Google-Smtp-Source: AGHT+IGn28EmgkCJxbojbPnsNpKARzTvTVEWepxmZw6Bez7lrsTqmABZYK92VlugVR6Dz8Cxy1cCRw==
X-Received: by 2002:a2e:bc18:0:b0:308:f4cc:951b with SMTP id 38308e7fff4ca-3090373a8f8mr40478541fa.23.1739548958674;
        Fri, 14 Feb 2025 08:02:38 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309100eabcbsm6136591fa.24.2025.02.14.08.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:02:37 -0800 (PST)
Date: Fri, 14 Feb 2025 18:02:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vitalii Mordan <mordan@ispras.ru>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sui Jingfeng <sui.jingfeng@linux.dev>, Aleksandr Mishin <amishin@t-argos.ru>, 
	Al Viro <viro@zeniv.linux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, 
	Jyri Sarha <jsarha@ti.com>, Quentin Schulz <quentin.schulz@free-electrons.com>, 
	Swapnil Jakhade <sjakhade@cadence.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Fedor Pchelkin <pchelkin@ispras.ru>, Alexey Khoroshilov <khoroshilov@ispras.ru>, 
	Vadim Mutilin <mutilin@ispras.ru>, lvc-project@linuxtesting.org
Subject: Re: [PATCH v3] gpu: cdns-mhdp8546: fix call balance of mhdp->clk
 handling routines
Message-ID: <kwrxxcjgjqvkwapfb7hrytf32ike3wqptjkr7mm3m4rz56xifi@ahbrdjt4cytk>
References: <20250214154632.1907425-1-mordan@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214154632.1907425-1-mordan@ispras.ru>

On Fri, Feb 14, 2025 at 06:46:32PM +0300, Vitalii Mordan wrote:
> If the clock mhdp->clk was not enabled in cdns_mhdp_probe(), it should not
> be disabled in any path.
> 
> The return value of clk_prepare_enable() is not checked. If mhdp->clk was
> not enabled, it may be disabled in the error path of cdns_mhdp_probe()
> (e.g., if cdns_mhdp_load_firmware() fails) or in cdns_mhdp_remove() after
> a successful cdns_mhdp_probe() call.
> 
> Use the devm_clk_get_enabled() helper function to ensure proper call
> balance for mhdp->clk.
> 
> Found by Linux Verification Center (linuxtesting.org) with Klever.
> 
> Fixes: fb43aa0acdfd ("drm: bridge: Add support for Cadence MHDP8546 DPI/DP bridge")
> Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
> ---
> v2: Use devm_clk_get_enabled() helper function, as per Dmitry Baryshkov's
> request.
> v3: Describe the paths that lead to unbalanced clock handling routines,
> as requested by Dmitry Baryshkov
> 
>  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-518284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55637A38CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416C81894A33
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FB323717C;
	Mon, 17 Feb 2025 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WCFwr28u"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F54187858
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822305; cv=none; b=cimTCI8w/Uhg3HXJCOnrd1e9YiCBJ+NMMegKDSvMQRWmf1ReFn3efyYEGqacOo0dHfs17GP4C3ozxMPs9QYjdEfcOob+6IqshGUn6jyC3Vojh1WVJxcl0j8MgX3l7F1EfrIX5ZSWCuXx+01J4YNYffSuyEy/P4sLfUKqgwPokyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822305; c=relaxed/simple;
	bh=uaKoGsnASt/b7lakAj7suu8kYLHtfanSP9LWcSikxR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxTyDKzAI+khCSxFm0s3EEu8u+C7+U8G6RxeWmN5ANoN/e8C6iSSY/kxVWLolW/Rl4l1K4niUHvlZeSfURhmFVueMjqdJC3TzOhDSdi66+zNLTlsFu8RV4KnuvqDbMmKTBNcy8qC/G+3yul7iu+LOnSH5/Zc3zzZ0f+vD8kS78o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WCFwr28u; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5452c2805bcso3504512e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739822302; x=1740427102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+eM01ELy6RFiGkjcxOpb1cojVzPpVE9t9t3LF3deNmc=;
        b=WCFwr28uaC77Ol847StJbwqNnjk2Mj7VUsk+ABqm08dJImK4Ov/NgTsCrWzKe92pN7
         laq3nBhxYPDT+gDGLz+wATOS4V+LzozLroIm9ydMxbK8JDRemPxxw80KRAu6XXC0Y0N+
         Oj/vcyiFB1hhiZS2NUPgbe3qUfg909qyzMDMOohSdYvNFGdrIjsP7TNjp2rEoWG16vVI
         8alkwMcVq83kbcwZzjtOBH22CMW3/IrQe1i0EU635bWKdKGsF4cRNMIGH6mg+C+aYoN0
         1K0cAMTLfulciV0FogWsvwr+lVk22zMWKhvZzzPKU3zp8NcH3ZxOosB2Kp8mTpRFIWop
         Dr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739822302; x=1740427102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eM01ELy6RFiGkjcxOpb1cojVzPpVE9t9t3LF3deNmc=;
        b=KoQSnpChjW/4PQxOaMfDdnNOnPDXnXUCMmZ5G563dghJBrmwAn2wNy1b5BdiCzJt42
         z84bNxQGN8fi21cS3UVJa0pUQcFE5kossbhxErjzw9feqdG0xMBY2f8Bi2SArCdQfgj3
         sKdcMaF3vXEtJUirvuVCIGgnCliqpRInLId3CxzysrDNZoTUtxXkshzuheRqTiOkr014
         us6iPiPPr9yg+unp9cpKvZcbeE4T7v/TlzDt2dIB/7eFiw/YssaxD84KS7CIp5y5uXdH
         lfKjtRcTqSdn11XYySQWCLattxs1FI9ROJlndHQuIdEG+LWEidCR12ebjdkIJ+Pi0DI0
         7dhw==
X-Forwarded-Encrypted: i=1; AJvYcCWeiNZRowLcawTQRXVomDqwmfoP8yvVfakNhAiiKeca439FDP6Rrkh2QhaJ+qSKb0ni/T22yPTZf/LiBY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6CXsnTIE1UHfxANgOylc6vTTUqR2cN5XK4EFS1mYgz83eaOQ0
	EaWDb0AurMY5Ek0g6sqxkyO+9gxtUBA9aW9EBunRnJ2vfjKHObMZOSD3VRxb1Q0=
X-Gm-Gg: ASbGncu0wXWQbPzHr933DcUg1buO6Jg95PKTqaCyLKHDGYE5gXH5To3KVNK+CP1wmmS
	ptrgyUwr97BKs817Qcx4m0UYyZ6uRXhCMdhj3NeylIQ1KpxkjBDkAOeZ1DVd+Wjv/GHsY01qxLe
	3bV8dLnqi/89Im8Ire5dtgfCXNpxnsBoc+ayxNvaxVcR7mcs342eFzjF8qEf/AzMPu5qqEIO39L
	uX57WGR4fqVHeO5vw/AZme4BLOGzeSTp7xWBNajmw6C2ATmF4My7nDFGN4lhIChnYZnVoYp/j6P
	U0ySkaUVVGf95awCU8g/OLLHBfOmzVE7ID2AG8QTKmtctcSZJ9SsRF036wipLXxSa3yqr0U=
X-Google-Smtp-Source: AGHT+IEbKDaSdPLHIMQ9eXv6L5J9v69avK8N05Xy7KhfzTpN1ljeSBVhl0WhGYyS/jPkWJgZWNtb/A==
X-Received: by 2002:a05:6512:2823:b0:545:4cb:b25d with SMTP id 2adb3069b0e04-5452fe37326mr3210895e87.13.1739822302051;
        Mon, 17 Feb 2025 11:58:22 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452b496aafsm1288648e87.29.2025.02.17.11.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:58:20 -0800 (PST)
Date: Mon, 17 Feb 2025 21:58:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Vishal Sagar <vishal.sagar@amd.com>, 
	Anatoliy Klymenko <anatoliy.klymenko@amd.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Michal Simek <michal.simek@amd.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 03/11] drm/fourcc: Add DRM_FORMAT_Y8
Message-ID: <lzzp5cgsh3qegxtctttys3tvtr2j2ciurm2jnmmm3d6cgjei5z@rzu4p5afxf6f>
References: <20250212-xilinx-formats-v3-0-90d0fe106995@ideasonboard.com>
 <20250212-xilinx-formats-v3-3-90d0fe106995@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-xilinx-formats-v3-3-90d0fe106995@ideasonboard.com>

On Wed, Feb 12, 2025 at 04:56:07PM +0200, Tomi Valkeinen wrote:
> Add greyscale Y8 format.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/drm_fourcc.c  | 1 +
>  include/uapi/drm/drm_fourcc.h | 3 +++
>  2 files changed, 4 insertions(+)

My 2c is that it's useful to have YUV (well, Y-only) grayscale formats.


Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-335856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F5D97EB8F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3FD282132
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9A9198845;
	Mon, 23 Sep 2024 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qrbxk6xI"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1169E1714DF
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 12:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727094874; cv=none; b=o+rN2/TE5QHtfNYNOKD+adAN8cGqhrQeHR9s5kRfni+ThDQUvauxoBtnCrEbBcx+mwp+kUZ/slQc4G1Ajfp5W5GLUllt44UJ2TOEqB/M4SyFEjyk9YNvVlGcrnEy87RZ65Y9RtE2fHWNsI6WAZSUxbfFI2gFFX8JTJ5lJVCUelE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727094874; c=relaxed/simple;
	bh=2XIX5mz0RBmDA5euJxp8y+Wts9scQnp2U7ggIINJNfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBsvM5Fl5apipdncKWkR3JWmPxqw3bJ6b6oU0sSm3CqVmgWHC6X8uN5mqTkCi2J7r5JrQQvonZ+iLBt0uO4lYcXRYfw8kD37tPWucZv927r0SxbD8Sd4YlHuof5wwsX/6CEyHEtB8m/FR4CCrqFq428e/qz/S+5wlypzF67YalA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qrbxk6xI; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso6524662e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 05:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727094871; x=1727699671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N49f57cTB1HFzUzgYfoooYdBFUEP0IAy2wA8kB5amCA=;
        b=Qrbxk6xIlmuXiAb5NeGL8tx3dGug+9UrmYImmGkd3HDu8wWZeyYncJksHxxP5wLUBx
         gT14Rg6vw/ytfkIhuyGtDTD08mheaf42txP++D5Htqt7MrXjARI28xsjEIsvy99faZJ0
         gBRevDSoCLaKUbJrVW7xeBBzPkykyAmBkiK+VLEkgwdXMg2yKgjDYPrXUQcCuUrDyvvl
         6S19c1oXqAq/yxsSPFub/i6XpET4RyZp3oFsowOkHU8CYtE3b1CV3Dlok5FmvIcaGDmT
         g3FaqlFUcUqX2v+/qjeSts4Ch/fZnOu5xzxE8J6HwGa7FuuIFEiwtpqW61+Ey08MADqq
         V9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727094871; x=1727699671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N49f57cTB1HFzUzgYfoooYdBFUEP0IAy2wA8kB5amCA=;
        b=jl9SLYpNZLCVofWPPSuBw53qU6m2lSxEhGh/mNpqo9/jyXw/IKOO3XrQQCURSqly5C
         xLupb0GCX8kTbDHxBBVC5vOLNe/1geT0a6bMS2p0SMvfJlF2SpeA7sM/rfhR+BQfhgjB
         HyGiWIr9b3nmIY8feCuKKnn2It6nzOloDjAgLjomK/y4VB+5Lh2E0FtL/4AYUkNizTn+
         70DQOSpbTweSEzLMHwSbWOb/OaWak93i6ricdH51i/Y06KOlNSEZGTKF7rcy2v5p30kc
         A3x1U6OK1d3EN7EmbIHgLwf3sH//d4++kGnHjNRFrBefJErzau+ObuugpAp3wA80eCV/
         kBfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpIW2ZWXASQ2/rbxxe1GiMSCjiQ4qJYhrjgJA+lzfJCAgEZArbTWFeJkBFMmBmfpxPHHY8Ac+isKpNQqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0rrv7KV/zuSiXZ58Mv7VyYdMIK5v3+zilQMxvGLBkFQFqY1Dd
	f2JyEeN5eTLtJA4oEEwmPhmzEeg2gQW+qc1VqtZTGbeB2Hzql5lhvmfw7fJ8nYI=
X-Google-Smtp-Source: AGHT+IF/DFl2Yi5RkcdlR+iT6PwIVo32HuubtE9mc1DgRuA6fscZHZXvy947e5s+d+LPPRSSLjp9eQ==
X-Received: by 2002:a05:6512:3048:b0:533:4785:82ab with SMTP id 2adb3069b0e04-536ac2d6a6bmr6515979e87.1.1727094871107;
        Mon, 23 Sep 2024 05:34:31 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53687096914sm3251007e87.170.2024.09.23.05.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 05:34:29 -0700 (PDT)
Date: Mon, 23 Sep 2024 15:34:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: deller@gmx.de, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: pxa3xx-gcu: Convert comma to semicolon
Message-ID: <rsegcr3fhm5hfb5vbe7zlmvmffwmctoxv77kohoonswpqlo45v@qkg4rfeforyc>
References: <20240902075724.3824567-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902075724.3824567-1-nichen@iscas.ac.cn>

On Mon, Sep 02, 2024 at 03:57:24PM GMT, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/video/fbdev/pxa3xx-gcu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


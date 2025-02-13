Return-Path: <linux-kernel+bounces-513475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08518A34AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD2F18866AB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B19024BC16;
	Thu, 13 Feb 2025 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b4ovIyUi"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3C22222BB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464844; cv=none; b=awAS2PZp+MD6cg5wXs3DsYDG3h5t9PHxWMaP9CC3B4sAJbmwMFlCorXDMIlWnc36UEmj2qBx1SaVp37P89GFdvYZJwAkKu2dFZCMJtuNp+hOinaDsIX6d/knS4GAW/NQgIFXYWm4+VzfZvP4Rz3LjmtlUUG+kEnbyhLWjjS2z1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464844; c=relaxed/simple;
	bh=rYWHCyQgChfPqlVZdXh5q9e52cZ5xrcrBOIQ5aKETPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OC6afIgIdM9bvZv9Blq4Zq0f3FrolhQ7CLTxbj218EaD7D+z6XM9P2Ud3MDnq2q7efdT4P12C8sTRLMABB3t57F3ghd3j1uzmcZGI8hMjDMRZONSNRA6BdpsVxi5DfgRnjOgBCZzKHnd+arvSXcXOp7+N+rS+ngHPqoTaufoUl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b4ovIyUi; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-307325f2436so9878301fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464840; x=1740069640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LMnzVOaqbPiWJZc1ATkgCkD1AufYLWgWH5h8h9uqtDQ=;
        b=b4ovIyUiG02Ejjb/Ps6zAq8K8prfCmBK2NqeXAKQDg9hCmyw+H5p1UK1wl2eMjr1Tc
         9Ad4DBwN98/PywFy6mzNdLVLYuwusqX2/OyVwiMJv6SRbMGpr0EyFKdgdGB0pifmrvJJ
         eGzeYlpOQbeRBfJY2cSZM+nuRfecj3w3ouDOkji/b9Fag8vulhn/Wh0sIjfRTspwhgme
         AVkNAdZm4U3eLKjCg6JxSnEZYIJ3+ZWdbh1vt0P6yKax/WIUS63IKI83NXk+rdMGqT6x
         MN+N2UAktZvGHACGYzxExZXYiZVe2MqVE4+L0FJqFy9tczLS0KkS+4wSbYn41FSeUgwA
         UOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464840; x=1740069640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMnzVOaqbPiWJZc1ATkgCkD1AufYLWgWH5h8h9uqtDQ=;
        b=eVJYSOCNndA0AxJHTkCxVraRpGmRNLLfhMV1r89Pm19hzOAypgS767EbYRVIVIWHJD
         GxyVQ/6A5LY8WG9tbQHXnjbA02RWOCom00ekvhFQkWG4i9AtILPwpO48FC3ScE7/9HkS
         O7sc52gYQY2/A7MG0N7gXiBkLme3PDzj/jgMwAg69F08DfnX1j08jRkHWI2Aigy8gHBO
         NJnTQaOmj5GFjm/VziwFDvxLAcMcVIFiAyrB7bYKUWKeHIBSMaXCHrTWRP6FtPNnvwZn
         jOyT0ZXAsGA/Vnyb38pt8e2G5xz//PaS6Z01WmSDpLxSXQn7KH03IS3SYq3oTBO+Kdm8
         Tmkw==
X-Forwarded-Encrypted: i=1; AJvYcCXbCJTSnTmuKzwNGFlzqNCq6qTSz27DMG4bB7PEcMefqbvh/vT+z+CC29A5qEXBJn7uPgt3nxa0pkoCgq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXMcNdkeCzmdoM5XvW76KsUMbdzsKDH5tqqrJBKSK0xbRY2nlw
	amMaZLQZV/dddFkI/QrlEYMUkWCCBVGLAaihRjTYQXGKbNQvBte8fIcyxyzGIew=
X-Gm-Gg: ASbGncuHxZVvdqmoMTOgY5p18uQsKTpTMJM7C0GV+rnaRVzWOMj5TIYN5HJeKBiWCf9
	z9Qh/uFdLuC7IoEOMCGzXRVDDPHOU14Sr2mIb1PL0f57UbfICYoWpeD0TreXnfpVK8rC2xoyk5B
	ZIwbWKKW8Zn028u+TesSNErz8LLIMaGHzr2BNsoe3INLLG4fBb0Lu3wmZvdztcO3PruOltFGLG7
	H6TEwoktPoPuwd3rRkrJKLVrLV5401PYFXUH1G6ZYOHLmGeeWsDvv+wDgVkeMrUgPuQjJJp1x8C
	xDrjQ8LVms9sVFvzlHwnvOuqL344S7qTSKreuXXu6gR707ZkEAeXbTnVK77z7I7wYffTRYE=
X-Google-Smtp-Source: AGHT+IE+DLZp2bM7y7i3VvWDlRtn34R3/3QTYkYHVUJ0a3IROZ4IO4tvISTZRCot/igQUEAuu0KXWw==
X-Received: by 2002:a2e:be86:0:b0:306:124c:69d5 with SMTP id 38308e7fff4ca-309037615d5mr30076241fa.34.1739464839693;
        Thu, 13 Feb 2025 08:40:39 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3090ffc695dsm2463621fa.0.2025.02.13.08.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:40:38 -0800 (PST)
Date: Thu, 13 Feb 2025 18:40:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 22/37] drm/atomic-helper: Change parameter name of
 drm_atomic_helper_commit_hw_done()
Message-ID: <2dmba5jptkg5epllhukxzt2teuf2pbt2w5cw44jh7vbma7q2os@hfcg6zjm7tuv>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-22-e71598f49c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-bridge-connector-v3-22-e71598f49c8f@kernel.org>

On Thu, Feb 13, 2025 at 03:43:41PM +0100, Maxime Ripard wrote:
> drm_atomic_helper_commit_hw_done() signals hardware completion of a
> given commit. It takes the drm_atomic_state being committed as a
> parameter.
> 
> However, that parameter name is called (and documented) as old_state,
> which is pretty confusing. Let's rename that variable as state.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


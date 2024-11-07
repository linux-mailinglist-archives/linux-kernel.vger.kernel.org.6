Return-Path: <linux-kernel+bounces-400045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C809C0836
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35EC1F22692
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E445C2101B7;
	Thu,  7 Nov 2024 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mnwSTu1A"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7722114
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987766; cv=none; b=C0p1/Z0PP6JSflvkE8U7KFmxN20FmIiJtLgBE4JF2R2WsbaqRb8oUiit9ZCWrzy8iiDuMBE5TGPe/0El6OSI+rzB7wCis/n+QEX5NIOuu0EIZRR0gY6mCZQ4hV/e8PSGyNBtyWVn0fft8SD8WEiLxEZC/HhvKH5p/bB/1cl/EhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987766; c=relaxed/simple;
	bh=BiUYl2soU36xrQBB4eiVNEdpKOJvHeeEQTnlmEm4yM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lg3Ubyi7RSk5Gx4uJWdH/k6vRU19kwspuXQ14Lyv5SL/NLVZPWd5CWHofu5D6O1mK4uSVXs+C+q0eqMuNGz8Uql7g5i1ge9e0I7wAgQ3W60sR6PzxP41dGzY0tDFNX1MY1VLMlRBFj0/ubLI62m4h6dIV/oDJ1hYQVyAyA/heT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mnwSTu1A; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e3f35268so945121e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 05:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730987763; x=1731592563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=22xOEFDUKtzH1RkL0q7gdFIurZuuV8lHMvP9OcbXdk0=;
        b=mnwSTu1AITviwNyuLt6xETjCJc0XYfP7LQiYg6v1QkScVy+e+ZUwqpGRSvFh49/JrV
         1ECziaVMkRtnEG9pXG0Ub5QBeVY2nymtvmhCVOSfCXexpx9+rGpTeW+6T0x2vMRsF8Qq
         CFXTQalkiYvqN/0KXw0R5wWsaA0VGPsjoIN+/q+T5xP3xgWp+cN1g8HE6YZMrGMuUL6W
         sUOFmcPb1cv9FhWYfDiqpHC/Yozt18C6n1lT/hRF2daWa9RfE+ub54Ch4B7p5jlCOzOs
         mlQmEEgE8JBoXaGf+nQw/ioy4+livp4LAJdyO5UBLLcezX5QSqgpYlIJWgwqH/wOf3+u
         BqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730987763; x=1731592563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22xOEFDUKtzH1RkL0q7gdFIurZuuV8lHMvP9OcbXdk0=;
        b=ew2a8V33/fUErP4TcqiUtdXM3EBbCBZu0aXbggQnSA0G2SRexjrSmSYxqF3qqmys0v
         Yt3L6o9yDIIy93Ht51aW8IWfzriaWJMrGnb4fpAETNCbH+EYOckrs7ZWnzKYdC06/7gX
         dhmZowE2j+UPuF58MU5qFJzlguUcsdijs9FrsymZvpnKSO62rB8Cacl+JsgtXm1MN6/C
         iAb4mEYxkTfg3H4Ld9e+iM3SlHnh4qrDcIC5nGrIK0dzsVB9xzo3nxosyAyMBixtT9Eo
         XJcYQOcg7cRfQ17xNx+7x8E+5ibEclv+MciaKVPTiLTbcxuviDrqlcwN6VijbEZHWNjC
         AMpw==
X-Forwarded-Encrypted: i=1; AJvYcCVulg8ENuBsdRVruhnURXlUB6KsyByW0FvPEC8B66kdEuF2Nm84Vtp5WjHRWuayjA8HL8rn8KGvQI384RI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoESk7c/EQlqH9UlGBlZEsnaBllW9bOZWTpB+U/Vdw/x8JanIg
	UV25lwluSM368Pzaz4Ag/hyBG4w7zU7hTT17r/PPeBSScGeMQssW1I/qaQ4nKPc=
X-Google-Smtp-Source: AGHT+IHUagBWPMmBh4EiOrB3yVjeY1HaiP031J1nWQB2/wkG393Hem3zaDuXF9PmeQAHxLP6A0R20A==
X-Received: by 2002:a05:6512:3343:b0:535:6cde:5c4d with SMTP id 2adb3069b0e04-53d65de5381mr12041759e87.3.1730987762659;
        Thu, 07 Nov 2024 05:56:02 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d8269a86dsm226684e87.31.2024.11.07.05.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:56:02 -0800 (PST)
Date: Thu, 7 Nov 2024 15:55:59 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] drm/connector: warn when cleaning up a refcounted
 connector
Message-ID: <p45gxavvtsr6monn5us7ndf24p47e3vjyykuejtcg5ji5sk2xn@gljukglstv6z>
References: <20241106-drm-small-improvements-v2-0-f6e2aef86719@bootlin.com>
 <20241106-drm-small-improvements-v2-4-f6e2aef86719@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106-drm-small-improvements-v2-4-f6e2aef86719@bootlin.com>

On Wed, Nov 06, 2024 at 11:48:27AM +0100, Luca Ceresoli wrote:
> Calling drm_connector_cleanup() should only be done via the free_cb =>
> .destroy path, which cleans up the struct drm_connector only when the
> refcount drops to zero.
> 
> A cleanup done with a refcount higher than 0 can result from buggy code,
> e.g. by doing cleanup directly in the drivers teardown code. Serious
> trouble can happen if this happens, so warn about it.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/drm_connector.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


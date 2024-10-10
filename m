Return-Path: <linux-kernel+bounces-359426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43153998B46
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8DEE295A46
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFD91CC174;
	Thu, 10 Oct 2024 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="isyhRglW"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39FE1BD018
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573642; cv=none; b=hDqaHKjKPEk1xDX7+I8gfqnCEXFbXzH1XGLJ0k93Ts1UnxUjRXj4svuegn+0x0guwHl8cXmk/AeXFAK3AtpSpT3V3ZGPnPuxOzW9Ddyn2Yi2bM2+6m0jeGy0bDw85C4t9COn5zAWwqoInx//BiD4HE3GDmLgvpykSOHqKOeHEFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573642; c=relaxed/simple;
	bh=bBl/8kLn3PMgofJWXoRDcak4u44INDe+5nr3slY9Rag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOR9xZTsaeNPzo5xvriOa0Qy/bHSzJTKpGHXp4PDSG2U/2kH1dkdgk5boztrxL+sJDSjVeg6B5QUD+ghrCDQI6iwJ89UnozlqJ5blpVmB8B3P0T6EBfr31ml6eVon0UlWtF552RSjL058GJeB2jMqm778q5fyv1X++9HnJic4rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=isyhRglW; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539885dd4bcso1422516e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728573639; x=1729178439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yl+AJ7lyFwjwDvwphBTlSXLZHqolk5S2mucilQyKVTA=;
        b=isyhRglWpvkyu3Ci3+LSBZsQVMxL6rsmfguP0dtkongfYWduhQ6UIqcwUpS7meJqR3
         TUtDI/vB/uQOC2bRt9Bna9f+46vXhbiM+8HLMVnSgPBZsi8RsGcYVUn9J2Q39oavlMjt
         WBIQgvTaB78139WJ80dKYax9nGBuzVz4jcP0UX5e2va2216aX3Pnw4KTpBAfkGJm1DOu
         kly3Kz5pyGPHQF9U/u+gyjhSldGVleFkjMyla1HkFArnA6lsSqXTmHBgIylb28YYXy1D
         Z871g64FbGB22XWcPXyho5WvobYWzpi6/47XJEFFrbkbeR/lXiUCR1SFepNaS5TcNG2n
         R1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728573639; x=1729178439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yl+AJ7lyFwjwDvwphBTlSXLZHqolk5S2mucilQyKVTA=;
        b=vsZP0xThk95k0R/RALR6Evk/GwS1sSVn3TlSjjAPIGlAo2xq7CYo1WiXg67h3cVkuJ
         Wufi+xKcIMK7ohGOkIZ+nnBWfhQ2R2qBAbcHAYwaVdsDTQZkXPfxIGOJtlWXttVljeUg
         O1wvx7G09ciXHihhyBSgIM4nW9KYexFlaHofIgxtxfyNTNzH4RRwicZGtJy/L50w0Jnk
         W1awsmamUlA4gQ3/AdGPWryehbqYxH+ObEEszfYnXT0Wiho8eLr3cw3aWMkP/Xrckf4h
         X4Mcs0BpUNXccdqS4eEWz2kpgC2CxlEAnQFsZGo1L1uFhUmY7pKXASGWx52bJDcUSi2U
         BWUg==
X-Forwarded-Encrypted: i=1; AJvYcCVfNoQSfA50uUmsBEhBGAx6rDaHKCruUxHu0SGgAKRtoAx2jnCtm/tcYb8tF3akcYYs5wvPurTXzhm5Mmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YypiUbydDxmKLI8aV6+IRR83ndSWm/S0tWOfm16NVXNbH9TGyx/
	w6YeAVsLPNa/Sy/DTLnMT+I8QKDrQEeJEDuMauzPsyUdtYKaZp+ya2w9Gsedu0Y=
X-Google-Smtp-Source: AGHT+IH/AhoqLxAeDa8GrTS+pYtnDRk05gpq3mqxJbZBvTFUqCKS16r2AzappociNsYeq9ZA5HsNug==
X-Received: by 2002:a05:6512:3195:b0:535:3ca5:daa with SMTP id 2adb3069b0e04-539c488d6f3mr4627086e87.7.1728573638749;
        Thu, 10 Oct 2024 08:20:38 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb905182sm287086e87.258.2024.10.10.08.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 08:20:37 -0700 (PDT)
Date: Thu, 10 Oct 2024 18:20:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, quic_abhinavk@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH] drm/msm/dpu: Don't always set merge_3d pending flush
Message-ID: <5scqahnsr5i26rkumg5eqdiwrg5n7rrnrp5642c6moxucf6w3r@xcgrxtjhj3pz>
References: <20241009-mode3d-fix-v1-1-c0258354fadc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009-mode3d-fix-v1-1-c0258354fadc@quicinc.com>

On Wed, Oct 09, 2024 at 08:41:13PM GMT, Jessica Zhang wrote:
> Don't set the merge_3d pending flush bits if the mode_3d is
> BLEND_3D_NONE.
> 
> Always flushing merge_3d can cause timeout issues when there are
> multiple commits with concurrent writeback enabled.
> 
> This is because the video phys enc waits for the hw_ctl flush register
> to be completely cleared [1] in its wait_for_commit_done(), but the WB
> encoder always sets the merge_3d pending flush during each commit
> regardless of if the merge_3d is actually active.
> 
> This means that the hw_ctl flush register will never be 0 when there are
> multiple CWB commits and the video phys enc will hit vblank timeout
> errors after the first CWB commit.

From this description, wouldn't it be more correct to always set
intf_cfg.merge_3d in WB code (even if mode_3d is NONE)?

> [1] commit fe9df3f50c39 ("drm/msm/dpu: add real wait_for_commit_done()")
> 
> Fixes: 3e79527a33a8 ("drm/msm/dpu: enable merge_3d support on sm8150/sm8250")
> Fixes: d7d0e73f7de3 ("drm/msm/dpu: introduce the dpu_encoder_phys_* for writeback")
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 5 ++++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c  | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 

-- 
With best wishes
Dmitry


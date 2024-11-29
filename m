Return-Path: <linux-kernel+bounces-417332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DFF9D52B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA1F1F22583
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3D01C3F0E;
	Thu, 21 Nov 2024 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gvCuZSEM"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBAB1428F3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732214666; cv=none; b=s1voEukFrVYYgDw07uQmAZYz4O9+2U80fakvRcnZhAESLrGGP89ywiAN3bLB2dbRDEQegcX9PerWTviVOV6K2DkPougV8+Ac7OlJEsMEHowQhOR/LNoy+UnjsIjCTNAtTkXjvsyZdfh4WkB9ZzSKk4QIeSaAYQOZSEtYawIGziY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732214666; c=relaxed/simple;
	bh=0iXEZP10lMiFvqi+1JJCxNY441IVtcYkv7fsyr5IQSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tI7rEZKpOGDqpY+9EO2AGS+Q/r12vKrz02zu+xPpK3wEOZBFDY70fofIJ38qX83Ob+VWNY9H/wy50H1IomohqML2pORHEl5R9oGpxpVV3EOd31eiD7FE8a91lkulFd19VWLzIomZvcSijTAPEBRgqo/yN2FBMnyaQxhD7Iucm00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gvCuZSEM; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539d9fffea1so1156272e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732214663; x=1732819463; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TZyh5R6Jjbt7oN7KVsZQw9ZFXBRvyZ4Sk/f6o54iZsw=;
        b=gvCuZSEMYZ9ionoELpCChVruD1ekPOwiLm8SwmoA3U7tXZc4H3T5isIRMvkDp5zQjx
         pAXsW70fq+OW+b4glBXIRreI7bM4lf2tWv8a3GoFMgUaS4RxH2aFC3KIVXRWGPMS/Mmc
         nQcWyf+4YfckdVN9P1t6KdCp0msGAmiywdEKT1psucrxPDN706R4DGGR7l8mdvJ2hiYJ
         6a5wsjOrP+Qyn83+InSPWfdeDNd1WovU0okKGJ4dvCdnpEb4O9w3jsRrEDyvVElPzYAZ
         hyG4rK2GKPACZnRZdMs/UgYKkLXL2eiYzn7ri3NWs9VW1rWnQhjuHK07wlBAydHLewCd
         C0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732214663; x=1732819463;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZyh5R6Jjbt7oN7KVsZQw9ZFXBRvyZ4Sk/f6o54iZsw=;
        b=tX0JEFyWg8K6B8oskPGjGjmLzYcgQbj2tjVMlpRos2Kyk3kW745cM5l0WAJXdfHO02
         II+ZokZjDXZ1jWWLn2LvHjue0lEWIvExZRaRtfeprh3WGmMsYBo6uuPDAz6P/bk5putf
         fuWIY5E4HRSqIG0UGkoeJoDtIs9yngtUlP2OmTU02AD6W4Ww6FKIEN3kmj437HKghybv
         2FcwPxXg8sfw1I8/YwcoZcIuBRahilcnIw5DQTtsmtck6k8Cs0sAi/2Ft70K0l/qXiMN
         7cd9KF1wfkHJJ8BBm5CXz9mDhFyJhGXjK+l+NgDIZUvF1R6ysA/vCr9EZnjO3gkr027u
         14wA==
X-Forwarded-Encrypted: i=1; AJvYcCVno+ucVBZyeMXLqirInDBIh2LrM4cUOUGpFHPhjsf1bw+jkKblrrsclXwd1CMw8+nld1bpqQUaDrjWaFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwpojCiiElDXUHnJlLsbZ8pEjVXOwWvWrG5uY5o0d0ffhuf85r
	1hreCebpYgEfuN8OPJZfJ2e0KMUzH0nvYTHmd13AF5Jy8C/skAixMkLXOGGyttI=
X-Gm-Gg: ASbGncsz5swQ2dY7/gwp0GnHPBN+qlrCquvKF22gvUcIJd0KM9v8UbPGuosm/a8mzWo
	gRbpWVyRx6r1ltP/HhvRu2mlueTAUBBLJYIH0V7oA4b7Z+rozjWNl0MQ0PU8qzEpQcPwQlOL3+L
	qFaX3eJW3+Iz8Hg3g1q40dDEzmD7hdoXgAY/rVf/Wttnoj3Z9GgQ76xzQpX6m9POE+6JdsegpYE
	bqchCf0ullOkaGFPrrIQoOQrfeyMutTKtjki3mMNx9aG7RyvAytBX+09w4+bg2ypFiIbaQo+jWC
	aiCvUypd+1n5hrpudn7Zngfuq1vxpQ==
X-Google-Smtp-Source: AGHT+IG7nxOfbTTnTu4v1sr9zkOK5csQupd0P6YOCsdv1of5Sqk8kO39dWTULCj7D8rgDzFjdACzwA==
X-Received: by 2002:ac2:430a:0:b0:539:adb0:b91 with SMTP id 2adb3069b0e04-53dc138a1ffmr3344284e87.57.1732214663097;
        Thu, 21 Nov 2024 10:44:23 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2496a37sm43307e87.234.2024.11.21.10.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 10:44:21 -0800 (PST)
Date: Thu, 21 Nov 2024 20:44:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Akhil P Oommen <quic_akhilpo@quicinc.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 03/11] drm/msm: adreno: move features bits in a
 separate variable
Message-ID: <dtt6d427u5yep3i3b3zxxef7uh572aeu3vtatmjvpbqfpjbvjc@epkkr7oumncn>
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
 <20241119-topic-sm8x50-gpu-bw-vote-v2-3-4deb87be2498@linaro.org>
 <fkezpguictntg2wkouwqipnaaiauo6vu46n7a2xzvlorzvyeaw@bbcpj3bs5eko>
 <CAF6AEGs6zT_kaTXNohUaA7KWZxZTr4byaoMoLAceuyqA7S+2CQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGs6zT_kaTXNohUaA7KWZxZTr4byaoMoLAceuyqA7S+2CQ@mail.gmail.com>

On Wed, Nov 20, 2024 at 10:54:24AM -0800, Rob Clark wrote:
> On Wed, Nov 20, 2024 at 3:18 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Tue, Nov 19, 2024 at 06:56:38PM +0100, Neil Armstrong wrote:
> > > Now the features defines have the right name, introduce a features
> > > bitfield and move the features defines in it, fixing all code checking
> > > for them.
> > >
> > > No functional changes intended.
> >
> > I think it might be better to squahs this patch into the previous one,
> > it would simplify checking that we use .quirks for ADRENO_QUIRK_foo and
> > .features for ADRENO_FEAT_bar.
> >
> 
> IMHO better to keep this separated

If they are separated, it is easy to overlook presense of a statement
checking .quirks against ADRENO_FEAT_bar.

> 
> But we don't have _that_ many features/quirks so I don't find
> combining them all that problematic
> 

-- 
With best wishes
Dmitry


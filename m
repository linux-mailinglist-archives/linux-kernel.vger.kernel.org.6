Return-Path: <linux-kernel+bounces-537732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C1FA48FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6261116D7FA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163A4195B37;
	Fri, 28 Feb 2025 04:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CQxYpcq6"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8794F819
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740715444; cv=none; b=ok+t1Nv7ZhVWzLllGo09yYSZ8MRtTzSABIL80H+aRt514zrfqCyQ4Y0sai5q5eke7LCC4dt7sfMK0P7Yd28AMl9U4giTnnG9bHu2HMOh8TxEgx7NvllAHAe8vCw3ZF1Fd/1fB/yYSJC58WOtToW5n81D16Uww3GgocarAly+508=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740715444; c=relaxed/simple;
	bh=yjpHU47lcxuI7NezIsym2hhyx+WdaZiRRUZi87/74KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVA08Ue5VD+lSfUBA7y9a6kq3psN31RmcJTDhB+AE62U1cT9HPyuPv2P3I8bjDU1orHaV+5ZeE3JdbhE0OmLBnSlU9KegbmVutP3mJhxXK96UyZ6g76w8+cbmosF82auQRGug8oZ0/61rhVWVVOZcFsD0sfQ2zQnkIhIXY46iLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CQxYpcq6; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54298ec925bso2546984e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740715439; x=1741320239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qd/SSjZSdsFXpP8Mw5Z4CDkuUKoi98PoVJbFfa8a+ac=;
        b=CQxYpcq6ft4BwgkFyYLcBYH4d7AkpbdbEHltFgzXFm1mij0oUF8XKRs2xjlm7JpQgo
         5Zr4mvu2Wa2iNfR3C5SrY8mfFNH2h1UoTlZGYTuRuotDMmKZAXoMhhRa5ljtYUlPhAM+
         n+yusGsbUEbLXd+31tE2EAQe8EEbGS8c8MDUt7jNLNE6ncnQlm7Akp0Gaba9p+cO1f4D
         USHQgso6zURMyEYpEwNPYq2sXsmXHL8X9dZmz27VzTSlCVLf6uxSLfzt1gjXhgKYSL2c
         yWoVdbAkAxdVbU4apO4ZyIXXGTUtwlwWYx7AkrhbbfsqzaxpBmgX11GX+hS0Cvm/wk+t
         Orjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740715439; x=1741320239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qd/SSjZSdsFXpP8Mw5Z4CDkuUKoi98PoVJbFfa8a+ac=;
        b=iU+97NC5a7vdXJkLuSsINBNWitOkdR3TdNvlkxl1XD1mNHXQgtjCXb6lbrF/xomNWP
         GD5bZmZymXHp+DZkgf8lW5tKm/ldPQ+xqSWU+vg24XNXCk11R+8u/w71JpEKrRLljsVB
         huk3tlyRiPz+Gxzd7tpau3m/PGcnCZ1MrXRlru/d2cyygFJBOqT0WYbRd7Q49N3z4dXv
         bX1YHMCI+52K9MHI/NruK39KsPypZL/Be56kM5WcG3e79zl3aFMhZTWGAtE8XC4S4TP6
         s4JgcCSxNR5fcXXs6lOLFMW+FxZHeVia3EjojM2hXpSNjMLTZePCNSlwKNGH1MdlluiG
         0U0g==
X-Forwarded-Encrypted: i=1; AJvYcCUC2pHXHITnm9rmPrMi6HeLvqPCGVfamEA02xalbjR6tmt1VQ4QjlZ3UctSMxP9CBtANOo4dpUJQFcxT/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD1o9F+1P+VMFVhGcK/KQIp8QMgRmEOtP7wy6P1XAxYkKjxaT1
	ayPOwHRd/LqpQmUaTYvHiA+usHRbu1MlnK6HfxrZttUFUVYF7hilPwg9r8dbA9A=
X-Gm-Gg: ASbGncvdaJ6dY6X3l4UXeL08tQXx9OySc3/yJyVquh5G00//FAw6gPQp1WXkDuXnX8q
	JR5Y/AThWOlPgBiOdJEVmgCZS/uj6+k2G8gBKcl201F0QKCNn3nYjqQ28wJJsxW6bQjYXej/Fz+
	np7K0TyX69HROzwN7knOa6LziNXygTRoIqE5Pj8qXXZ9PMkWGZh04XibwZEmBe2civ4+t9AkOu6
	wkfLqxc+75QJ1R+7oWNIk2r5Ga7pJN8YLQuewdtyCy5Ewp54ng8kdGJAMzmWuU1J9WJ220prfVC
	XpkLJ8mdMRB6i3BH3u+A8IZix4ILwtmzeeABMDV/nRu5VUanoSZ6VoB4kyZTRa2reqdzEl8ylMt
	L78olpw==
X-Google-Smtp-Source: AGHT+IHNQymHd5ykzqnXmyMsW1a5EMx9alc09Hn9+MB6NToh83PZlB6/RNRvKwbTSqirwQlRGlJx9g==
X-Received: by 2002:a2e:b70f:0:b0:308:eb58:6571 with SMTP id 38308e7fff4ca-30b9341382cmr4665921fa.26.1740715439491;
        Thu, 27 Feb 2025 20:03:59 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b962da0ccsm1003861fa.27.2025.02.27.20.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:03:58 -0800 (PST)
Date: Fri, 28 Feb 2025 06:03:55 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] drm/msm/dpu: remove DPU_CTL_SPLIT_DISPLAY from CTL
 blocks on DPU >= 5.0
Message-ID: <6utf3iirzf7vtotsjxswtiuodt75mtrmhlofvsju5qfdmx7sdk@6mflw7g67ljy>
References: <20250220-dpu-active-ctl-v1-0-71ca67a564f8@linaro.org>
 <20250220-dpu-active-ctl-v1-7-71ca67a564f8@linaro.org>
 <45evxcbkcenkoiufh6vqpq5ngfz3mz62evvjxehmqgp5sd4lo3@a5swxugzf4fm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45evxcbkcenkoiufh6vqpq5ngfz3mz62evvjxehmqgp5sd4lo3@a5swxugzf4fm>

On Fri, Feb 21, 2025 at 12:37:40AM +0100, Marijn Suijten wrote:
> On 2025-02-20 12:26:24, Dmitry Baryshkov wrote:
> > Since DPU 5.0 CTL blocks do not require DPU_CTL_SPLIT_DISPLAY, as single
> > CTL is used for both interfaces. As both RM and encoder now handle
> > active CTLs, drop that feature bit.
> 
> I was wondering if this bit only existed to ensure the right "pair" of CTLs
> exist: not on DPU 4.0, but on DPU 3.0 we see that CTL_0 and CTL_2 have this bit
> but not CTL_1.  Meaning that split display can only work when that specific pair
> of CTL_0 and CTL_2 is used in conjunction?

Unfortunately I don't have a deep knowledge of those platforms and I
don't have a way to test it. My SDM660 board (IFC6560) doesn't have DSI1
routed anywhere.

> 
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> 

-- 
With best wishes
Dmitry


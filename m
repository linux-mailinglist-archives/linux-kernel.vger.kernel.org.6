Return-Path: <linux-kernel+bounces-442128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E8F9ED853
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BEAE282D39
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6122D1E9B35;
	Wed, 11 Dec 2024 21:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k7zbKkyl"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DA31E9B36
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733951974; cv=none; b=fmwZjSFD19ewM587tvcKAsqjRcnmmiYP5aTp7pOxOhKFUQItXJxkt1kiMx4JqoHBxTYzBrK0dSocageXW/3MMQ30hL+RqfbjrybsRpYqSfQeWcxB2mWEU2TfenlEEWgkapjsiuM5hRhFKmfeeOz3DA98QDS/SsAq00Fp6UAEfDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733951974; c=relaxed/simple;
	bh=HYpTBgw49iGGQnoZixVyDOp+jWreZ3c1N/xlRY2EXfY=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpJ3nhq+8ZIdXctOIjgdEs+v62q4uav2/ftSTXhmWEWmOvj9GY4DbKmxA0Rl3ahbVd9xD3aoqIPIWcMkn8CHwOASP2WHEP321tv4+b3ogGXgtIEDK9v6zkHbHAcgc0DunMgUEDqJyNpk1fRIl325YGyQfgUE0vY5+4D/Wx+8Vro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k7zbKkyl; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e3d18886010so308900276.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733951972; x=1734556772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYpTBgw49iGGQnoZixVyDOp+jWreZ3c1N/xlRY2EXfY=;
        b=k7zbKkylDfXQKrfwtGV+Eii+as6j+ngABWpEa73iwgd/nKCSeKpcXS7GzUDU42Tk8o
         l0Tv2uJjhbEsjvXnN2AVoo9kde3Xr98kXAuchQmeipFsMk+xC3li7iA4x9SKE4qHbCaU
         Oxv61kve+EQPNvT8ptmlgcwd0aeViaPNpt9zU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733951972; x=1734556772;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYpTBgw49iGGQnoZixVyDOp+jWreZ3c1N/xlRY2EXfY=;
        b=k32eUGIwOaShqzneE2UKoRaAkkjG2OKJ8DVY12M20ogxAo/26odmW94lfDD/yW4/IU
         +YfesstGOhjTmcFNvvKqtlS5AcGFMqFtqdNan2gjWwPeHkIA4BaQCJbS3JgZj5p6Uy+K
         Ps8QfYSFed1I6nEG+mn58Wnre/NLLAY8U//3IWJM2xEDjcfk5cVUmDlknD5T7DyOVF8W
         04gyOQE9CKGp9Bjjz1mHaRhvowoJ3YIjPM5ERjStpuZ8bt4TPeEzLXsBEcxx/O2ZXH0J
         AWVuNl11IzJOK9MwXBtWRytS34634beNlzdZCmLvqSsJCvbO3OchGZ2FLvZOyStpXsSf
         Y4+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeC1ogPchAE8rdXRI/LQY4Lq+tshvyyYVrg2KDIo1u/QAZlZKoFeM8kmK6SBv2v30Zce+G4744bNfm7DI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw0/VMUN8STH+e/wPt+UXbiLuaL57xV4iIO/Kw/5aCLgXnvZzQ
	xw44j9TzxEKUBbWwd4aDWYbuH4NiNMPXCHYgSKyFWSTuqjjsB4tIBYkzAjN+a9puTc1QX6WFIbL
	wb+hFJSk5JOEGTsBCi6ly/mkcAX/IMBUMyGeR
X-Gm-Gg: ASbGncsLCva2vbEHsa+VB8CAJcbLZSsMmmjras4BG2zBL6Wbb9w2i8/2IalnloSfljP
	s5L9v4RotGAidXTExfDMsZxhzyM8MLOzqi3ySl/2IToM9RU+sPQOYddSzgkY/ipc=
X-Google-Smtp-Source: AGHT+IG0n1apsTNyaVMm69eKfJ0OWmTmr6rAMEZdQLhM95ckH8dadOxw475UNN17L54dURE+0mDPgl6bERAbF28z3lI=
X-Received: by 2002:a05:6902:2709:b0:e3c:9ed1:4944 with SMTP id
 3f1490d57ef6-e3d8fb607a4mr1059614276.1.1733951972207; Wed, 11 Dec 2024
 13:19:32 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Dec 2024 13:19:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241202-fd-dp-audio-fixup-v2-1-d9187ea96dad@linaro.org>
References: <20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org> <20241202-fd-dp-audio-fixup-v2-1-d9187ea96dad@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Wed, 11 Dec 2024 13:19:31 -0800
Message-ID: <CAE-0n533qmCvd78GncN=cEkYqvfQ8ejs3xr7E=ucUJ8SqfSeDA@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] drm/msm/dp: set safe_to_exit_level before
 printing it
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Cc: Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-12-02 02:06:31)
> Rather than printing random garbage from stack and pretending that it is
> the default safe_to_exit_level, set the variable beforehand.
>
> Fixes: d13e36d7d222 ("drm/msm/dp: add audio support for Display Port on MSM")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202411081748.0PPL9MIj-lkp@intel.com/
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>


Return-Path: <linux-kernel+bounces-264139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3021D93DF60
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 14:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D501F216B1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 12:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65517F486;
	Sat, 27 Jul 2024 12:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cUbgvF9g"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601845466B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722084433; cv=none; b=ime7/KUQNBYOdU+tYuoZal7tkcpLggq1G3Kfi2k/FPvrQDe1LgXEAvt7pSgT6MhyE8VFLcwyTYdlgKxnbBw6yGfNdVKsp2KCUXg8hCIlsKbDqNXnNNGdvJfzm10B0w2W49zMHxaqQ0fDr4lI5GviOF24MRLXxPjq39F3Qa3sNu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722084433; c=relaxed/simple;
	bh=4tmNfpeUgQbQUYvb8PGmYMyCd9dQP9Tt18NGCG1Bto0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDjPa2GbEwwcG8LkAnwtYSDSbadWvRBHfEjrXTbX3SAN7Qn89oEmmV2nk57u8UdsgPI5WJwJZECt0r1Te7l5OGHsoFxvXQzLpbTo/gYY+p7RTwMPSkUQCf9ZtVp104MD7Kk7Ls12tbDaK7aEmDL81kJ57YvFLAYCgKtpuM9QEwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cUbgvF9g; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6512866fa87so4988477b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 05:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722084430; x=1722689230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ruf9ZndZlLo67VSTxRYzKSbRXRLxQV2q8v9gXBq+h+k=;
        b=cUbgvF9gxostbejgPz/mvShlKZ6afGTo8GIWJba/V8h7nWU/fHZVya09BTJO5SQ55d
         j/diDoLlQYO2H1FNa1n9LJrQ/lL5R5hTt4Jcyc/gJBnMwu/kIfDE/wrSdQuhQLcpW8zE
         0bafaK7jlarisbP/VP5qAGXVcfSEAvqbd1nx/u9SN20AOkaCXsEEhI8bgXCYmG3jDEN1
         oD17+za4lMuVoxEJV5AWsVNPetOb9U3IYm4dsdCLvXxhxbo5WHKozD2ar7C5q/M8CNRf
         NPcvxsswUa7lawmp0SG4dVThPNCdIyqrN+6VDUSH95LskDpDvCCQ1qtYXQ49Bpg+h0pY
         wLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722084430; x=1722689230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ruf9ZndZlLo67VSTxRYzKSbRXRLxQV2q8v9gXBq+h+k=;
        b=qPwW9JmkYP6wKtgmMtPMStCOSwvrr3PV33AyLaTa5sXg4wV/E9GKpl3n8u1Pji3fv2
         nCTw8jxvjMoua4O6q3kgEEE2zB2SpE6S4uSZByBOGBLN8Q/kI+XedHhmENVkq2dYTUhT
         S1A6xyiomF4SFuOqF7AVQH8MgnUckkMkDo3yDmdvk0ttkcvCMQMsgydNunn+ouDYQbRf
         SB/8rKL5fr9VDRvGITyHP1JjcZkJw//GPYOs0Y0107Usk2EWPtKzyblyvYdL8I7CwE/J
         bEfPspj+5IFRwf3OZe8i+ROOyouoWfmWcDuErGnx/Qwe5XycsxtjTY1HIqfRx6fNicqR
         nCtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrvS0owuEhRradGJiIZ4q+FvQ3SF6LPKzL2fRz86mceH1ZomrVst3WmOxph8howJnnUn+HRIGDev03FjOQuKLiv39ts/aBJB+7jhMm
X-Gm-Message-State: AOJu0YxO8BTjQD3osIaUYe/vUikdVDXOdPoqyYdGQLlIrGsp0uxb94R7
	jxzvnz59YeAaxDq1Jn3j8gcbkF7PrfyYH4d0mW1vkvA32OnpzlCel92/k6shu1Xqhnz2rdDp7kn
	mY3EDmH3BZ3HGvJCFH1fDqjicscltEGMMqwnZEGdISLmvgkfjNjs=
X-Google-Smtp-Source: AGHT+IFhK/Aj+oSR7J0lYtH6rQPZBzgOq9awlN5aMDE4hP6kpLKtN1cPj+5K1G7neerc+C+JBOWJXklm+962FR0VIbM=
X-Received: by 2002:a05:690c:f0c:b0:64a:f40d:5fd2 with SMTP id
 00721157ae682-67a05b95447mr29458067b3.12.1722084430178; Sat, 27 Jul 2024
 05:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725220450.131245-1-quic_abhinavk@quicinc.com>
In-Reply-To: <20240725220450.131245-1-quic_abhinavk@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 27 Jul 2024 15:46:59 +0300
Message-ID: <CAA8EJppFcPRcMzjB8hxbWK9G19J-C720DP7gukW3ds8j-Af92w@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: reset the link phy params before link training
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, dri-devel@lists.freedesktop.org, 
	quic_jesszhan@quicinc.com, neil.armstrong@linaro.org, swboyd@chromium.org, 
	abel.vesa@linaro.org, Rob Clark <robdclark@chromium.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 01:05, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Before re-starting link training reset the link phy params namely
> the pre-emphasis and voltage swing levels otherwise the next
> link training begins at the previously cached levels which can result
> in link training failures.
>
> Fixes: 8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # SM8350-HDK

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-442305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156DB9EDA66
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E11167B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC571F237B;
	Wed, 11 Dec 2024 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IkMvmag8"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D3C1DD885
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957470; cv=none; b=OThvtQpsZw4zxV2zYWY4ZyjvNL7qSXfmCOnf0s+b5LqexCjcwp12ey86gNCqshWhTonuBjVMFTJ4gHO62HD/LHowUIxDwm/8l7Vwpk7SsS5ofCkPgjaISQ50BGaPWGFjkTX9c7n4obuHUfT/+tfoM0GHOhuy/5YUegLLr0VaNOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957470; c=relaxed/simple;
	bh=FPSw2nF/lJm2UWC2sCJezAEzDmgl9FQYGt/yXj/bTk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAeCG4cS9USBx4Ep7bdRFvXjSntQ6ky+3ex+7TX3VrqZfllTQ1SM0S6zGPZrEd5tz5HbeEDOpNxhGRp2ek0jmhf2ozUTg09EgeK1lOe+6ABYbyDsnVPBkQmZiQjcM2F+uBh5ld5akyvF+kkrLRUS98hYJXJdVQM3KxDCM7QUEes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IkMvmag8; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53e389d8dc7so5460753e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733957465; x=1734562265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKgmtaCixVS2eTp9TrZ+8kVzXwyvmutreSuRkttynvI=;
        b=IkMvmag89aMHktcgnpoEMPTecMUFOpFJ8KJHuc7GdO3lK4v1OrOYSQDk2Ej527FFMR
         bwyVr5iKlZf8ik4s8J+cnj5mW/9en8ClzQkp60qt+fsK/Y/ahJ8RmdXzI4qfsPmJk5+f
         gONEo21rWe30csPX9KEZRyjFq9D/Q8yjXsch4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733957465; x=1734562265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKgmtaCixVS2eTp9TrZ+8kVzXwyvmutreSuRkttynvI=;
        b=atncuO8cq9z6ZpkAViFKPuHxR9GDLzNLUvEQlAO+iIIhPTN2Ys3isHv845mw+hIDse
         +BPgDVyANNtdOW2Q9H+dnvTHK3u/D02O2Egz+oZ/RXC1aviOaRnlenxp9cRFTN8+Ym9j
         syH6hcpf0Irz1DLU3GKSSsDg0HrYmcFbRWkwP4is85KpTqgsbn6wXQ8gd+hxH2jxaIA/
         YCx6RPGdZVRZGUzbjZZpYYpbKmuvL414MEuFBMIio8nv+3dhAE2O9m2o7ScBLCXLueDj
         9NQl/hv9z10DKjN7YU+bBZEh4R4CISCxWrIQA7LnyUorLf99AA4gpg0H+9X06M8Vo1Oo
         IE8g==
X-Forwarded-Encrypted: i=1; AJvYcCUOLwI0S2Hr8p92hG7UhvH5KNnBy/Utxz41It24gGdKLj31CCtKHmaupbUJn1n1yQ772Q5HGYypcRBPJcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3KsN3cjSpX6v+jLFvcsr1jA/CsJwrZBmL40KjTaq+uG2oEQT8
	cF8ZbH5pbw8Dc3vbUdPdj28Z7uJ0ZSlvG7q9+agBE5JdE+y/rwqhgoF2BV6aaOyTgsWKBA0qVZm
	M+8s2
X-Gm-Gg: ASbGncuI+G/4Z8I1nHsMc78I2/fmHzRjTfYdUeKrdNkXo1jcH2gemqGzPoRmD6zwSLi
	NgX7cunV/GerqFW3fy/rV+hF7d6EgesxdmifP8EXjUtdaFhTxTzrubmEO/iJr7fds8JrbbIFlN/
	irgVjS8HY9XNXMpa0bOBmXTOStCG+r44Pje7RJpUEzGEFRTNyKMK2ipl8acrpBh6RO3Bek/ncDz
	HHguxTbDH65F0wOctmd2LpEiGAMgMKipWjw+7xYgWdfcWFTuoq37RQhECsXXD/IpVOsQTqLPd3V
	ooMxyIOim5IQVxzB2c02uw==
X-Google-Smtp-Source: AGHT+IHXxOJ9gIHqikyDE7oivpASeJKk3nQ+J5RMP7ynv7AHANGE/MMJXZ61CJFCW5BvOm5D4+3Srg==
X-Received: by 2002:a05:6512:1188:b0:53f:8c46:42b3 with SMTP id 2adb3069b0e04-5402a5d3f22mr1415782e87.12.1733957464653;
        Wed, 11 Dec 2024 14:51:04 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401f432380sm1124812e87.101.2024.12.11.14.51.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 14:51:03 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3003d7ca01cso48284351fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:51:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+ZMwrY0HpzPKLBieT7niyX+Cf6WHksSsN4BjKak91dKRv2l1xOZ1zcI7tHQP06UNBYTiDv4ogmUc7D08=@vger.kernel.org
X-Received: by 2002:a05:6512:3d11:b0:540:17ac:b379 with SMTP id
 2adb3069b0e04-5402a5e5682mr1002664e87.25.1733957462810; Wed, 11 Dec 2024
 14:51:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211-check-state-before-dump-v2-1-62647a501e8c@quicinc.com>
In-Reply-To: <20241211-check-state-before-dump-v2-1-62647a501e8c@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 11 Dec 2024 14:50:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V33utY6rby5e+RkRfUQQ40g2Bq3xr=G9q3if8TNoq1kg@mail.gmail.com>
X-Gm-Features: AZHOrDlpR97b9ybDcxqzZ165UcoKpL_oopMC2BgdmlXON_-hpEKkrEAlm1wccLg
Message-ID: <CAD=FV=V33utY6rby5e+RkRfUQQ40g2Bq3xr=G9q3if8TNoq1kg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dpu: check dpu_plane_atomic_print_state() for
 valid sspp
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 11, 2024 at 11:51=E2=80=AFAM Abhinav Kumar
<quic_abhinavk@quicinc.com> wrote:
>
> Similar to the r_pipe sspp protect, add a check to protect
> the pipe state prints to avoid NULL ptr dereference for cases when
> the state is dumped without a corresponding atomic_check() where the
> pipe->sspp is assigned.
>
> Fixes: 31f7148fd370 ("drm/msm/dpu: move pstate->pipe initialization to dp=
u_plane_atomic_check")
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/67
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
> To: Rob Clark <robdclark@gmail.com>
> To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> To: Sean Paul <sean@poorly.run>
> To: Marijn Suijten <marijn.suijten@somainline.org>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Stephen Boyd <swboyd@chromium.org>
> ---
> Changes in v2:
> - move pstate->stage out of the pipe->sspp check
> - add reported-by credits for Stephen
> - Link to v1: https://lore.kernel.org/r/20241209-check-state-before-dump-=
v1-1-7a9d8bc6048f@quicinc.com
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Tested-by: Douglas Anderson <dianders@chromium.org>


Return-Path: <linux-kernel+bounces-312436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4090996969D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A2B1C210EE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590BD201252;
	Tue,  3 Sep 2024 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPGgWoDz"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F88420124E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351097; cv=none; b=fy1ZN0PyIvZrq/vRqA06Vap0DGiLCag6IuBWYZPTlklq4ucHdKhp/40/bu4zKk7pjEPp8TWizKb/lcu+kQPXF39DYqZvtv1LjtXhuUAQnkVe3E7gwU02q0jIUQ2S6DjIItzh0NNC8C4pko9ivLoW+u/UW6/XtFzUl/2GcCKMbno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351097; c=relaxed/simple;
	bh=oK2N716Wf5zWuyGseX+K7OxwDsTjJt4KWsutUjuIEwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eooSA2F+z1CQkNEGPbRWXWdSnRaEIMg4L3wo4VloauLyBMWgeA4wpbI60Lv4QOVP69VO6GofQuA+a8JZVFALGuwtJrS0whTDS973wgaBjHEcGO5ryClgipml+vilFTTKF2JIKLmp9ochvDxOFyKQgQD3JxRDOjrmaJceHHVMaCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mPGgWoDz; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53438aa64a4so6035981e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 01:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725351094; x=1725955894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oK2N716Wf5zWuyGseX+K7OxwDsTjJt4KWsutUjuIEwg=;
        b=mPGgWoDzK+7qApQWCsbaYxiABpN0rhd7ZXJ/XaaYIrjcqIJp/WItudNPNcYTtoE8kf
         Cmv3360wCvPPec2qvMpO5ZNxT4Q1uVDpYqr+Vji8Nf6U0rVo9lcJfM0T2dmg2zPdoFXp
         g556LFc3ybQmITTPpANP4GoxT9fhY9r5z6LrzkuV4HbmudwcfX3tPhqBoWs7wSjSCSOZ
         ZSqd8QIKX3l68uQlUfmY4cFILPkIyqWUZe7QfiTRbRIx5m/WeHnicdirBsODM23mfCXV
         6OPDk/y2o0DX4qRLPyvMSWcTwmXWIAnd+HEM/H4EQSwGx1qHDACKO2uIW2K3asIO47XT
         TnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725351094; x=1725955894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oK2N716Wf5zWuyGseX+K7OxwDsTjJt4KWsutUjuIEwg=;
        b=kdxxECaGl6TQySxwspSDtJJJT4zGzlSfAGd6Qn5A5DjkWJG7RPBwU4eXSfYwNOI5m9
         iYFOEXEANlmnVcbI4sHptGrXqqLgcGHI3RKwDVHMh2E92HFXwCvhFYHCXhfMy1KTiPao
         YU1yJwkzX7AgPhuGPu65BdiVnSNHIX5Gd4iUAgUQxhkjpOsOEmeg58kF6SHjbpD+OiSZ
         1rctdt0jS9sX0p3tv/qjHAmt0tRqsRAqUGfXdzyQ0SLlKmLZK7JQ3Uxx0gKoMxweSfGu
         2tGXJHAVvfw5A3zFmg9j9sp/2iSCsIm+09qZ0GqiOqL1cpA7cmpEAgyXAZcY13CS05L3
         u9aA==
X-Forwarded-Encrypted: i=1; AJvYcCXeYmoBpIVosO9TQa2YlvicyB8ywhgJZgukXM6o1zalItj+7Uk/l1AUlPq0koT9y8wj0KKGRjEUrn3onrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCb0nn6derB3E28s8nI/wgJSvtvTZy5P8/oMaIRk03fZKp4JpX
	xlaYzkN26cEsm7mmj63h5aGMWBBt8F0o7Q3bTsg6FcwuWlcys3YPVg+2X2L8S70LBwRb5vrV6B+
	FYeA8AoeyzDuFET0QzZ+Yl/BHZRYhNok8OObh4Q==
X-Google-Smtp-Source: AGHT+IFA+v/Lw2VM8YBLUxDrbigDTMftuBsPCXYDExzuRQnypmgUTiFnyFUrx8r3ouJS7IWB+TH+Av+oI+GuAY+0oHc=
X-Received: by 2002:a05:6512:1044:b0:52c:9e25:978d with SMTP id
 2adb3069b0e04-53546b691afmr8245078e87.45.1725351093898; Tue, 03 Sep 2024
 01:11:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org>
 <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-1-bdb05b4b5a2e@linaro.org>
 <CAA8EJprgHAmuFxj5hO5BYFywW7sGC2VcMZwaadBLOmYJr88OYg@mail.gmail.com>
In-Reply-To: <CAA8EJprgHAmuFxj5hO5BYFywW7sGC2VcMZwaadBLOmYJr88OYg@mail.gmail.com>
From: Jun Nie <jun.nie@linaro.org>
Date: Tue, 3 Sep 2024 16:11:22 +0800
Message-ID: <CABymUCPEnU2ReAve=P6yzndZy5-=YQRB60bixxHGeoQK4cWTAw@mail.gmail.com>
Subject: Re: [PATCH 01/21] drm/msm/dsi: add support to DSI CTRL v2.8.0
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2024=E5=B9=B48=E6=
=9C=8829=E6=97=A5=E5=91=A8=E5=9B=9B 18:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 29 Aug 2024 at 13:19, Jun Nie <jun.nie@linaro.org> wrote:
> >
> > From: Jonathan Marek <jonathan@marek.ca>
> >
> > Add support to DSI CTRL v2.8.0 with priority support
>
> Proper description is missing

Actually, there is no clear doc for this register. Any URL or
doc key word to search?
>
> >
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
>
> Several tags are missing here.

Co-develop and SoB tag, right?
>
> Also, how is this patch related to quadpipe?

It is a must per test. Maybe it is just related to dual-DSI.
We can have answer if 2:2:2 is enabled.

- Jun


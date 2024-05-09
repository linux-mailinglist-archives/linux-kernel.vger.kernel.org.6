Return-Path: <linux-kernel+bounces-173968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1C68C086A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B611F2272C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE871FB2;
	Thu,  9 May 2024 00:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ogFMQDTH"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ADE17F5
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 00:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715214518; cv=none; b=a1YV4tyQ4MCHUJAc4zELDz4lCn4v7FdqJT+JPNz1bxP4TuGsD1aZm/bXoQh6y8AYTDnp0OmaBQ+dnjVjAlkIetLg9SXpOTZ+e0L9pG0J+tZkPJ6L+8V2cB5LMvto3WxZCVH7ffbryyIiE5meKPNlhDH1rObQ9ooXL15PwC4aLag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715214518; c=relaxed/simple;
	bh=V7Z93WRnPd6lnnQhJgTDhVba2h0S96dv3o2cjGDZJsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8aKUbw75uATsVnWPhRpuEm/hcczqa0wap+3WN8i3v2uHB0NJvST/j6EClS+JbBCU6NJFiwPgawLq2wy9ZZeSgrJGPrV+coQotqLe7vTQJX4uM0hiIci23DafSI80LW4qifqcYw/tH0WuzaqWYg70tIHZixwGn08CmdsxV+io28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ogFMQDTH; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59a387fbc9so69412966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 17:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715214513; x=1715819313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNeX2fBf0OvUGSKCQhqRKM/UWS2VcuqiFL3hMwMX2kY=;
        b=ogFMQDTHiNt2oqVeLbRAHvatL0i++yHX93NlkXl7XdVLtypDk9HW0FD14XF0iXn6pI
         stnn/0foDhyWHMTy0M5KS5WBnjDxd6TVjixW23cwNF+JARk3Kq88oXKF2vGIWwB+iZSc
         AI9OnUCLVRPJ5+ZjiK/REHC6plOKiAcoUpw8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715214513; x=1715819313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNeX2fBf0OvUGSKCQhqRKM/UWS2VcuqiFL3hMwMX2kY=;
        b=NIgmrTop3tH5H4mR1up5Kk7O2uNhRrF6lFIVQPxtXpzju19sh3xNLIcWd3llieUQjS
         UkkiOLMXAiQGFLel7BND86cR6SqXuP6OdYxaq1w+apW+II0WN0Rcts58zgQIonxQXho+
         9l8i6FGXoaCn3vutteHDGWCYbkW7/MutfE7mrgTZjtHyISlqtbyu/cRe+TtlRXQPTbhW
         8GUoxDEqmd/9yUNG6j18LNoHclIPm4u9GFrP4iYWBuu2SIdv9LTGeY6ILnjHTRPNfLfd
         UR1C0tRmA79ao7OkfsE0MU1QsDY8V3YNVYa2KjIA7ZUOO8YS3E+WWd3ct6dhbcU1pLV8
         z7kA==
X-Forwarded-Encrypted: i=1; AJvYcCWG1HthhVQcVRXggZxkt7RRs0uvsKzcOFSibiQmjtrtwOnO1EcdW+SlFJMfXkAdnSZ8HBA6Dd4WG71joXHMwBcKgoYFDC9JfEk2R/Pm
X-Gm-Message-State: AOJu0Yx/8uFYBiYvr+OMlkyj9987N7ZuCj1uGaD8F8qqIJoAblEJuuAN
	MFkDKKRmkN8qzpsQ1r+IakUDtdIG0CtiTADhq5JtzqJNT/l8QRr8WhikVzQJJQa/MMk+/nFxEuS
	EY3w7
X-Google-Smtp-Source: AGHT+IHoyTpWGyaZQOtVrIVWPhCPZ33VyfJjLApwvpmP1btPh/eFGwhh/ryaHcj80hJrKk1+9FD5OQ==
X-Received: by 2002:a17:906:8c5:b0:a59:a85c:a5c6 with SMTP id a640c23a62f3a-a59fb94db21mr198532566b.22.1715214512987;
        Wed, 08 May 2024 17:28:32 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d532sm16035966b.18.2024.05.08.17.28.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 17:28:32 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41a428374b9so17855e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 17:28:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVk/ZMv/YAOcWwStei/qTP2DpF6zRPjVY7Nr6qbhDsZljwCvWadgLByR1Bz/z5/mv676V2dDhqn+ZgGVSNtS1hbtXuTsXHVJ42oXsb7
X-Received: by 2002:a05:600c:35d1:b0:41f:a15d:2228 with SMTP id
 5b1f17b1804b1-41fc26b9f66mr933245e9.0.1715214511425; Wed, 08 May 2024
 17:28:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507230440.3384949-1-quic_abhinavk@quicinc.com>
In-Reply-To: <20240507230440.3384949-1-quic_abhinavk@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 8 May 2024 17:28:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xa6LJEWZwdUXvFVPQ0-qnDZroDi6tkZaLFHiarJ2gyew@mail.gmail.com>
Message-ID: <CAD=FV=Xa6LJEWZwdUXvFVPQ0-qnDZroDi6tkZaLFHiarJ2gyew@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: remove python 3.9 dependency for compiling msm
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, seanpaul@chromium.org, 
	swboyd@chromium.org, quic_jesszhan@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 7, 2024 at 4:05=E2=80=AFPM Abhinav Kumar <quic_abhinavk@quicinc=
com> wrote:
>
> Since commit 5acf49119630 ("drm/msm: import gen_header.py script from Mes=
a"),
> compilation is broken on machines having python versions older than 3.9
> due to dependency on argparse.BooleanOptionalAction.
>
> Switch to use simple bool for the validate flag to remove the dependency.
>
> Fixes: 5acf49119630 ("drm/msm: import gen_header.py script from Mesa")
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/registers/gen_header.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

No idea if we're supposed to allow python as a build dependency. That
being said, I can confirm that this fixes the problem for me since I
ran into it too [1].

Tested-by: Douglas Anderson <dianders@chromium.org>

[1] https://lore.kernel.org/r/CAD=3DFV=3DXnpS-=3DCookKxzFM8og9WCSEMxfESmfTY=
H811438qg4ng@mail.gmail.com


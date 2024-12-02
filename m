Return-Path: <linux-kernel+bounces-427145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026439DFD3B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EB0281DE0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DC91FAC34;
	Mon,  2 Dec 2024 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sh2DOCRR"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003DE1FA827
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131972; cv=none; b=n/CmJGkuaUOcA/UQjTGErIknYO/EzapfOLmvntQ0o1ba1EwAKg/YcRbKdtgibWLRFYoYbkIP9ymlr/HLZqm2AVSNq2RbRfoaKVd2sBoaTRpMqrwz9iXn/VKuvZdjD85/hH8AfGxaK8opeS75bn1kKfUAxy+l3Voq+Z9tWNP258A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131972; c=relaxed/simple;
	bh=eYORF81wpS5r5CboRFAWx5G/GfVASyQGa5TvPaUF1yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sg4g/e+rnPoBYAUoq6aVhWNs8py+w+dY9Yj6C940BgGWFsMMvY1BLT6VgZpVU8NYWtV8QmIOsyPO1iuDgtSwZneq9vc3MpUAFwwFaR71iIz3jbeGB3rVDPb5nDbfjXzgUYuvALWoYtayQbjGuIslddx56MGRFli6i1LWcBH75fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sh2DOCRR; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e3982e9278bso2893123276.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 01:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733131970; x=1733736770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykJ4gnZ8OI+lNlsS7GnWz+Q0GYuAZsbDat/k0gHdcy0=;
        b=Sh2DOCRRIP6YQyWFw5vRejWNdbnXGXUZjmZke4QJ2bHCf61mc6wP+yJR4eHngvM1gU
         8tWJsx6K6OPnI4w5DBbz6/Jv5VTiXulyrBYcYNRU2+C329w0scY2lWBoSumjGlAq9OEu
         jiMnld81lJMCu6yS0kYHoQpcqPwySI3xSPwVdaosVJ2XVzor6pk7+E+MTatvrwtalDDT
         Iv8FqF0MUK2Hesrat+bXYf8hcuJ1GNWJ7+7Vw5S3KNHaunVZiAq0rWMf0e7fiFQhb7RC
         x/T5oi3ff+8TXtQyeJLTySyYOQOiKT7IUuziCxcflV4hjdzvXyrNnH/Z+vc/HYHGlbjh
         TtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733131970; x=1733736770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykJ4gnZ8OI+lNlsS7GnWz+Q0GYuAZsbDat/k0gHdcy0=;
        b=Gbho21s2eNjuYAUrWbfbKl2OhGSNDPJXl4c2K+3bjwl1koogi3fc4aAHwMOjuFfDDe
         UJ7LfKc+5WvjcTxdUTPfrSvp0iFOvnsUmafsW7ontCJNO2Py8f0hhoVstR+Ej1MjzxtI
         esecjTCTKCSbjG5fAJFpUohLHjEIeMm6/T4d2aJacjOJ6MYFSQmUXve01GWJ00LxE9Q8
         RK58znu78LoEI2tBqWaCEzu5SQ38EjaYeBPznT6hroT/Ma0LYRs8tWMBQvWHFfpJm1RH
         aV6eQw5iElaq99tfVNxsN5NdeAKzuAoYEeJWKp2ntbidBSRUxh8ALuIQXZlmSgc1l1Rf
         TDFg==
X-Forwarded-Encrypted: i=1; AJvYcCUV4Q/MhV+xyLOWbFONUpwVFdOr3AfvfmpqGeYStciffm5M+llSBwNDqNVRYO/MXRCTZBRRMrlbGBJRRVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz220kLfjkFH3OPixW5WSloOfiLatxX/XmBF8piT6qNUXcuT6fI
	qXu8S4SteIyOVicjF1KhSvzbDTvQaIrd7YBNURqCjA1OfQzOjaJQ2Iow+F1Wv5sUVfOEDwcnPTY
	nUB41qlRoFNAYvRpgOBydaJATXFxrRrzK+Vc9Yw==
X-Gm-Gg: ASbGncvHZMqd85bmxjEprD7O1nLoSskF8JqQM9t/sYPkG747TST0iqDxhslS1vXVny+
	pwlCw5kFW9wipailDErhGvr2amqNhjw==
X-Google-Smtp-Source: AGHT+IGT3z3TbHSFBQBWWQ1KvYeMAU20/kLWtZdyfcltpfmv3iUgGjIOBFmp2Bw/pBAtCruUtd0beWsC6yrtxdL0HE0=
X-Received: by 2002:a05:6902:150d:b0:e38:b889:7eff with SMTP id
 3f1490d57ef6-e395b870d38mr18514341276.6.1733131969951; Mon, 02 Dec 2024
 01:32:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129-add-displayport-support-for-qcs615-platform-v1-0-09a4338d93ef@quicinc.com>
 <20241129-add-displayport-support-for-qcs615-platform-v1-6-09a4338d93ef@quicinc.com>
 <CAA8EJpprTGRTxO+9BC6GRwxE4A3CuvmySsxS2Nh4Tqj0nDRT_Q@mail.gmail.com> <95a78722-8266-4d5d-8d2f-e8efa1aa2e87@quicinc.com>
In-Reply-To: <95a78722-8266-4d5d-8d2f-e8efa1aa2e87@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 2 Dec 2024 11:32:45 +0200
Message-ID: <CAA8EJpo-1o9i4JhZgdbvRxvoYQE2v18Lz_8dVg=Za7a_pk5EDA@mail.gmail.com>
Subject: Re: [PATCH 6/8] drm/msm/dp: Add maximum width limitation for modes
To: Xiangxu Yin <quic_xiangxuy@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_lliu6@quicinc.com, quic_fangez@quicinc.com, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Dec 2024 at 11:05, Xiangxu Yin <quic_xiangxuy@quicinc.com> wrote:
>
>
>
> On 11/29/2024 9:52 PM, Dmitry Baryshkov wrote:
> > On Fri, 29 Nov 2024 at 09:59, Xiangxu Yin <quic_xiangxuy@quicinc.com> w=
rote:
> >>
> >> Introduce a maximum width constraint for modes during validation. This
> >> ensures that the modes are filtered based on hardware capabilities,
> >> specifically addressing the line buffer limitations of individual pipe=
s.
> >
> > This doesn't describe, why this is necessary. What does "buffer
> > limitations of individual pipes" mean?
> > If the platforms have hw capabilities like being unable to support 8k
> > or 10k, it should go to platform data
> >
> It's SSPP line buffer limitation for this platform and only support to 21=
60 mode width.
> Then, shall I add max_width config to struct msm_dp_desc in next patch? f=
or other platform will set defualt value to =E2=80=98DP_MAX_WIDTH 7680'

SSPP line buffer limitations are to be handled in the DPU driver. The
DP driver shouldn't care about those.

> >>
> >> Signed-off-by: Xiangxu Yin <quic_xiangxuy@quicinc.com>
> >> ---
> >>  drivers/gpu/drm/msm/dp/dp_display.c |  3 +++
> >>  drivers/gpu/drm/msm/dp/dp_display.h |  1 +
> >>  drivers/gpu/drm/msm/dp/dp_panel.c   | 13 +++++++++++++
> >>  drivers/gpu/drm/msm/dp/dp_panel.h   |  1 +
> >>  4 files changed, 18 insertions(+)


--=20
With best wishes
Dmitry


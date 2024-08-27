Return-Path: <linux-kernel+bounces-303986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFE996180B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53A31C210C5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25001D31B2;
	Tue, 27 Aug 2024 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LCvtAl4N"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A211C6F74
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724787086; cv=none; b=ZS0No/YOjpRlHrPDGGUHLnOwmLrAYFhXdRF63hvU2een+pn6fF0FenYbXvcOsTm3SxsoriFIR3Drh265SyWz58g0MkncM37cgePiKLxRjinUL26NQEu5q86PKmwwtNDxy8YwJQrjcmb3Ip/eLUa9VmMCh61Sq7zZC7DwuDd3mGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724787086; c=relaxed/simple;
	bh=T6Gc7IagPDiIeIpVlgHMgeMNX//208zTDI7EtxaFhQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8qesX/it1jxb6FkH83zEZxc/XOh9cBjnX2uhR6yjhndiET0IKh0EmIOqO+HqFbxh6tsntonCO4XbYCsW3LqNMDbGMlybTDC0uGlILhhMAQuRQZMskaXZc7DBXn29LPXxBqrB+3NBBiBL19jYCLAurZz2LR1NjnmX5t+nhj+HNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LCvtAl4N; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5d5e97b84fbso4630855eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724787081; x=1725391881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgLdThQMvvxQD0GtX+hFcwHT8qG9FGW2/1VwCCGBPww=;
        b=LCvtAl4N3KKJB0cI3ecAVBXWxoiEsILCFWj+o+TeLfNcIq8UA1wY053RXBZ9sO1pX2
         qmlp4I8z2eYXjHcm3Ibvb5A/gqVSb+xv7/8/c5HTH3Cz8QjcU2n0lfScRw9+9KS5brZB
         lU0NPRjjAQkd4U+DxoykCLAgnHalvpZ31u5Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724787081; x=1725391881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgLdThQMvvxQD0GtX+hFcwHT8qG9FGW2/1VwCCGBPww=;
        b=u+QZ8Xb9SJXFlijXVRsRCnpfWJqS+yuSb7Byx4nL8a96isciV3FJcxzwqFP5R+8SCC
         EWbqXhItQK+gJGwuGRaO6uhqVkJcDW1om4Y7l1J6wMpHyOul1Hfc2OFOcpIDDMD4dDLA
         uWS72PqelRLLqEs/x6Ee/IUXsxGySr/dZ1mn8P6yNLOaer2X7XIr29kuDE7dR89recTW
         rHBT2KbQ4VoHAd4hjkCclXqhexjQFKULjC3PVKOG+W2OGO2RMIC+GcWvggP1/1p2i/WV
         8l16YYQBDMyqIUBu4Ur8L/kXJR7TeO51ERiNXrGz1xDOFfg5s6io/DORoI4sPDcQm50L
         Am0w==
X-Forwarded-Encrypted: i=1; AJvYcCU3jE3yiA9s+8QBCcF4SansiQXRGP0yIKF1vlyDQCZps9Vu4mPGJhyc2Tt0C545HB7vTO1E9DY6iyu7xsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBzoHlRUOVTZxKABwUI+wFHohNoykpDJ8CZX4WGGpjYO8L8Vtb
	FaHcqidB1Kl4vb5bYFCJuF/YL8ZvQMSc85V3nY/tLztmw3Q4yWDsow6ZlPIiPfV2QZbuQ3NkljQ
	=
X-Google-Smtp-Source: AGHT+IECC7ZM7kvTc0yJew4o5fN2su/kkGA932xYogAVupqiv5MLIHPX7Qep712F6BOT9qKWcK/JlQ==
X-Received: by 2002:a05:6871:80e:b0:260:e713:ae8b with SMTP id 586e51a60fabf-27759d54a8emr4560999fac.20.1724787081170;
        Tue, 27 Aug 2024 12:31:21 -0700 (PDT)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com. [209.85.219.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3bb1a9sm575632785a.75.2024.08.27.12.31.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 12:31:19 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6bf7b48d2feso31619406d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:31:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV48cu/3rSFf64rf3UtOsxlikwsHC5CTobYxnvQMmowdzdOsDex+hAKhQDbvGjFvjia2/evTAZHREXbHQw=@vger.kernel.org
X-Received: by 2002:a05:6214:2d45:b0:6b5:468e:d417 with SMTP id
 6a1803df08f44-6c32b6ba466mr42369256d6.23.1724787079270; Tue, 27 Aug 2024
 12:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715-x1e80100-crd-backlight-v2-0-31b7f2f658a3@linaro.org>
 <20240715-x1e80100-crd-backlight-v2-2-31b7f2f658a3@linaro.org>
 <7daa3c0d-cecf-4f50-be32-ae116b920db0@linaro.org> <ZpUcI3KkIa58zC55@linaro.org>
 <d1603248-afe8-4594-9e2e-81ba208dff00@linaro.org> <CAD=FV=WimxYmDrkfn0+E3MbXp8kS9TicN2kT3AM4eM+SAwYsOg@mail.gmail.com>
 <CAD=FV=XfvD1OniNBrCrA8C6XjOB15fye8EdnniNmgpu4DnpH6w@mail.gmail.com>
 <CAD=FV=Vp1Trv2JeFtqk2=Zhi0B7io5w402GkG_UhYm2q34q8dw@mail.gmail.com> <aa0f4f1c-3043-4b03-8b9f-f9a39f3682aa@linaro.org>
In-Reply-To: <aa0f4f1c-3043-4b03-8b9f-f9a39f3682aa@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 27 Aug 2024 12:31:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xw_Zpf3zpWMzK0tU-L+sUTiq05uZS5Z-Knci=9M=dGGA@mail.gmail.com>
Message-ID: <CAD=FV=Xw_Zpf3zpWMzK0tU-L+sUTiq05uZS5Z-Knci=9M=dGGA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] Revert "drm/panel-edp: Add SDC ATNA45AF01"
To: neil.armstrong@linaro.org
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 27, 2024 at 9:26=E2=80=AFAM <neil.armstrong@linaro.org> wrote:
>
> On 27/08/2024 17:36, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Jul 22, 2024 at 8:49=E2=80=AFAM Doug Anderson <dianders@chromiu=
m.org> wrote:
> >>
> >> Hi,
> >>
> >> On Mon, Jul 15, 2024 at 6:51=E2=80=AFAM Doug Anderson <dianders@chromi=
um.org> wrote:
> >>>
> >>> Hi,
> >>>
> >>> On Mon, Jul 15, 2024 at 6:02=E2=80=AFAM Neil Armstrong
> >>> <neil.armstrong@linaro.org> wrote:
> >>>>
> >>>> On 15/07/2024 14:54, Stephan Gerhold wrote:
> >>>>> On Mon, Jul 15, 2024 at 02:42:12PM +0200, Neil Armstrong wrote:
> >>>>>> On 15/07/2024 14:15, Stephan Gerhold wrote:
> >>>>>>> This reverts commit 8ebb1fc2e69ab8b89a425e402c7bd85e053b7b01.
> >>>>>>>
> >>>>>>> The panel should be handled through the samsung-atna33xc20 driver=
 for
> >>>>>>> correct power up timings. Otherwise the backlight does not work c=
orrectly.
> >>>>>>>
> >>>>>>> We have existing users of this panel through the generic "edp-pan=
el"
> >>>>>>> compatible (e.g. the Qualcomm X1E80100 CRD), but the screen works=
 only
> >>>>>>> partially in that configuration: It works after boot but once the=
 screen
> >>>>>>> gets disabled it does not turn on again until after reboot. It be=
haves the
> >>>>>>> same way with the default "conservative" timings, so we might as =
well drop
> >>>>>>> the configuration from the panel-edp driver. That way, users with=
 old DTBs
> >>>>>>> will get a warning and can move to the new driver.
> >>>>>>>
> >>>>>>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >>>>>>> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> >>>>>>> ---
> >>>>>>>     drivers/gpu/drm/panel/panel-edp.c | 2 --
> >>>>>>>     1 file changed, 2 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/=
panel/panel-edp.c
> >>>>>>> index 3a574a9b46e7..d2d682385e89 100644
> >>>>>>> --- a/drivers/gpu/drm/panel/panel-edp.c
> >>>>>>> +++ b/drivers/gpu/drm/panel/panel-edp.c
> >>>>>>> @@ -1960,8 +1960,6 @@ static const struct edp_panel_entry edp_pan=
els[] =3D {
> >>>>>>>      EDP_PANEL_ENTRY('L', 'G', 'D', 0x05af, &delay_200_500_e200_d=
200, "Unknown"),
> >>>>>>>      EDP_PANEL_ENTRY('L', 'G', 'D', 0x05f1, &delay_200_500_e200_d=
200, "Unknown"),
> >>>>>>> -   EDP_PANEL_ENTRY('S', 'D', 'C', 0x416d, &delay_100_500_e200, "=
ATNA45AF01"),
> >>>>>>> -
> >>>>>>>      EDP_PANEL_ENTRY('S', 'H', 'P', 0x1511, &delay_200_500_e50, "=
LQ140M1JW48"),
> >>>>>>>      EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &delay_80_500_e50, "L=
Q140M1JW46"),
> >>>>>>>      EDP_PANEL_ENTRY('S', 'H', 'P', 0x153a, &delay_200_500_e50, "=
LQ140T1JH01"),
> >>>>>>>
> >>>>>>
> >>>>>> How will we handle current/old crd DT with new kernels ?
> >>>>>>
> >>>>>
> >>>>> I think this is answered in the commit message:
> >>>>>
> >>>>>>> We have existing users of this panel through the generic "edp-pan=
el"
> >>>>>>> compatible (e.g. the Qualcomm X1E80100 CRD), but the screen works=
 only
> >>>>>>> partially in that configuration: It works after boot but once the=
 screen
> >>>>>>> gets disabled it does not turn on again until after reboot. It be=
haves the
> >>>>>>> same way with the default "conservative" timings, so we might as =
well drop
> >>>>>>> the configuration from the panel-edp driver. That way, users with=
 old DTBs
> >>>>>>> will get a warning and can move to the new driver.
> >>>>>
> >>>>> Basically with the entry removed, the panel-edp driver will fallbac=
k to
> >>>>> default "conservative" timings when using old DTBs. There will be a
> >>>>> warning in dmesg, but otherwise the panel will somewhat work just a=
s
> >>>>> before. I think this is a good way to remind users to upgrade.
> >>>>
> >>>> I consider this as a regression
> >>>>
> >>>>>
> >>>>>> Same question for patch 3, thie serie introduces a bindings that w=
on't be valid
> >>>>>> if we backport patch 3. I don't think patch should be backported, =
and this patch
> >>>>>> should be dropped.
> >>>>>
> >>>>> There would be a dtbs_check warning, yeah. Functionally, it would w=
ork
> >>>>> just fine. Is that reason enough to keep display partially broken f=
or
> >>>>> 6.11? We could also apply the minor binding change for 6.11 if need=
ed.
> >>>>
> >>>> I don't know how to answer this, I'll let the DT maintainer comment =
this.
> >>>>
> >>>> The problem is I do not think we can pass the whole patchset as fixe=
s
> >>>> for v6.11, patches 2 & 3 could, patches 1 & 4 definitely can't.
> >>>>
> >>>> Neil
> >>>
> >>> IMO: patch #3 (dts) and #4 (CONFIG) go through the Qualcomm tree
> >>> whenever those folks agree to it. If we're worried about the
> >>> dtbs_check breakage I personally wouldn't mind "Ack"ing patch #1 to g=
o
> >>> through the Qualcomm tree as long as it made it into 6.11-rc1. I have
> >>> a hunch that there are going to be more Samsung OLED panels in the
> >>> future that will need to touch the same file, but if the change is in
> >>> -rc1 it should make it back into drm-misc quickly, right?
> >>>
> >>> Personally I think patch #2 could go in anytime since, as people have
> >>> said, things are pretty broken today and the worst that happens is
> >>> that someone gets an extra warning. That would be my preference. That
> >>> being said, we could also snooze that patch for a month or two and
> >>> land it later. There's no real hurry.
> >>
> >> For now I'm going to snooze this patch for a month just to avoid any
> >> controversy. I'll plan to apply it (to drm-misc-next) when I see the
> >> device tree patch land. Since the device tree patch should land as a
> >> fix that should keep things landing in the correct order. ...and, as
> >> per above, the worst case is that if someone has an old DTS and a new
> >> kernel then a panel that was already not working well will print a fat
> >> warning and startup a bit slower.
> >>
> >> If somehow I mess up and forget about this patch, feel free to send me
> >> a poke when the device tree patch is landed.
> >
> > More than a month has passed now. One last warning before I apply this
> > revert in a few more days.
>
> It's fine if you apply it now

Thanks! Pushed to drm-misc-next:

[2/4] Revert "drm/panel-edp: Add SDC ATNA45AF01"
      commit: 01cc7b2e8a59fcae0c4493720561e5b33a195fe7

-Doug


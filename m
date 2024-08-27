Return-Path: <linux-kernel+bounces-303646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3D69612EB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8B71F22D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D131C8700;
	Tue, 27 Aug 2024 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FP7PKvM8"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE1D1C688E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772996; cv=none; b=Jhr3WUXFwPcCItZdpaTO9HyIceq0VoNn1co8LvZM1Tupa9UfTXHx+0ljV5ZIrZqfNUCY/PoHdm39VUmhfLMlqg1+AVoGrE0EWH977WzC3K3Pp+tV8YqVX/BeFaUVyQEfB0fsMbvOPvGwOEGHVWCcYyfklhab/01TSMR+MNFaAUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772996; c=relaxed/simple;
	bh=xKBxjuzhKzHAYCEFbj9br0eAFH6a2cGlC6D9UNQ53ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pnrqoMXBsM0kBsqmNgQ1ZkAe7+NwJQ51SkFabnq4pFg1iEJldNLzZxcRTvWvoBLGf4rdtRCTsb62o9Qo/bKWYx6krZMVmH+RC9ZPcXphFAVt4T4UOPJbeQZk5vCdNNWHUlFAtCnuyhPz4Ck3EKp0/0IZtr0In+IA+nAUdmHiiFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FP7PKvM8; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6bf7ba05f75so47643496d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724772991; x=1725377791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zP4KpFI1wEFgqr9Fa1v3gv1lXKIWQkFSNhyHX5LJ2uU=;
        b=FP7PKvM8h3XcILJPzHpxdTHjX3jkRRF1L7JgrZgZPZCZcEs5X+uvLBOeslbhmJbyRv
         gDHg6FbPZBmUc0XdoVuC96V1xchEjo4FSJttrpHxm6WxB+RDAQ+nlpL51NQ3bUQNQiQW
         NZOw3/Crm5BVSMGRpmEiwpJ9N214IVed1kEYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724772991; x=1725377791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zP4KpFI1wEFgqr9Fa1v3gv1lXKIWQkFSNhyHX5LJ2uU=;
        b=xABf/PYJiSmRCDe9/wxLjQ23awaGvF6txMQgxKDYzvSoyVzr9/FabbeOqzmsW6html
         elM3Is0PuiVg5ipdqvFSLewEiA146oSn0OmYUfMCzAMkzOZs3yeWoq7R7cZYqF61QFIR
         wSDSPpmEaDDI/TovlvsTQrYpCfGf+3ccSlsAuhOQ7ei2veLUPU+ekZqDoZ0DifLS1jHC
         UtAkhfwmJeYUSlU7RVPY388snJTvgAhGZaGxKytYrFf1CyvZb+gsXDDd/l1Dm0CgLLCn
         tRaXC+PVppISNEBTyVEJpWYuD4Dsa9060OXqGqL70s93yQdKb/bW+jRC2kf8GihFzIeD
         7YpA==
X-Forwarded-Encrypted: i=1; AJvYcCXeLuYQU6gYIdcZKYgjc/vxFz8seg0NEOEqfnEATQv/mIlhZte7xKf0o+HSoY/fsZ/r4k6jBTm26ESPOhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzamoSeBcFZlds6O8JB/Or8TKKNdk0AXvgwvrP0uWzD4+qQSvhF
	2k3fYGv+rqooOAnbmgyTIZ5nCLEyu+WgxNho2Hc0Hsi1Js2KMA9ZoGO7dWUyZtq3ZDb7AghQHeI
	=
X-Google-Smtp-Source: AGHT+IFKl8oX2PYrHvuAc2pY9LE3/qjDjCDMMEEw/cjfgta2iX44iKVBcC4sdIkrBmxD34+GNhpbwg==
X-Received: by 2002:ad4:4390:0:b0:6bf:835a:87b6 with SMTP id 6a1803df08f44-6c32b221de0mr40595366d6.27.1724772990814;
        Tue, 27 Aug 2024 08:36:30 -0700 (PDT)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com. [209.85.219.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162db0c26sm57495196d6.89.2024.08.27.08.36.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 08:36:29 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6bf705959f1so48251026d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:36:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzX7x9ttnv1XWN3AtX6OEfLDFbU6NxD07CThTbMBK+zzRLsXmHlO2ZnJPIMpmo96aiCUFMNJ91Pd1i+/A=@vger.kernel.org
X-Received: by 2002:a05:6214:258c:b0:6b5:2be1:cd6e with SMTP id
 6a1803df08f44-6c32aea3e83mr62311556d6.4.1724772988561; Tue, 27 Aug 2024
 08:36:28 -0700 (PDT)
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
In-Reply-To: <CAD=FV=XfvD1OniNBrCrA8C6XjOB15fye8EdnniNmgpu4DnpH6w@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 27 Aug 2024 08:36:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vp1Trv2JeFtqk2=Zhi0B7io5w402GkG_UhYm2q34q8dw@mail.gmail.com>
Message-ID: <CAD=FV=Vp1Trv2JeFtqk2=Zhi0B7io5w402GkG_UhYm2q34q8dw@mail.gmail.com>
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

On Mon, Jul 22, 2024 at 8:49=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Mon, Jul 15, 2024 at 6:51=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Mon, Jul 15, 2024 at 6:02=E2=80=AFAM Neil Armstrong
> > <neil.armstrong@linaro.org> wrote:
> > >
> > > On 15/07/2024 14:54, Stephan Gerhold wrote:
> > > > On Mon, Jul 15, 2024 at 02:42:12PM +0200, Neil Armstrong wrote:
> > > >> On 15/07/2024 14:15, Stephan Gerhold wrote:
> > > >>> This reverts commit 8ebb1fc2e69ab8b89a425e402c7bd85e053b7b01.
> > > >>>
> > > >>> The panel should be handled through the samsung-atna33xc20 driver=
 for
> > > >>> correct power up timings. Otherwise the backlight does not work c=
orrectly.
> > > >>>
> > > >>> We have existing users of this panel through the generic "edp-pan=
el"
> > > >>> compatible (e.g. the Qualcomm X1E80100 CRD), but the screen works=
 only
> > > >>> partially in that configuration: It works after boot but once the=
 screen
> > > >>> gets disabled it does not turn on again until after reboot. It be=
haves the
> > > >>> same way with the default "conservative" timings, so we might as =
well drop
> > > >>> the configuration from the panel-edp driver. That way, users with=
 old DTBs
> > > >>> will get a warning and can move to the new driver.
> > > >>>
> > > >>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > > >>> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > > >>> ---
> > > >>>    drivers/gpu/drm/panel/panel-edp.c | 2 --
> > > >>>    1 file changed, 2 deletions(-)
> > > >>>
> > > >>> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/=
panel/panel-edp.c
> > > >>> index 3a574a9b46e7..d2d682385e89 100644
> > > >>> --- a/drivers/gpu/drm/panel/panel-edp.c
> > > >>> +++ b/drivers/gpu/drm/panel/panel-edp.c
> > > >>> @@ -1960,8 +1960,6 @@ static const struct edp_panel_entry edp_pan=
els[] =3D {
> > > >>>     EDP_PANEL_ENTRY('L', 'G', 'D', 0x05af, &delay_200_500_e200_d2=
00, "Unknown"),
> > > >>>     EDP_PANEL_ENTRY('L', 'G', 'D', 0x05f1, &delay_200_500_e200_d2=
00, "Unknown"),
> > > >>> -   EDP_PANEL_ENTRY('S', 'D', 'C', 0x416d, &delay_100_500_e200, "=
ATNA45AF01"),
> > > >>> -
> > > >>>     EDP_PANEL_ENTRY('S', 'H', 'P', 0x1511, &delay_200_500_e50, "L=
Q140M1JW48"),
> > > >>>     EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &delay_80_500_e50, "LQ=
140M1JW46"),
> > > >>>     EDP_PANEL_ENTRY('S', 'H', 'P', 0x153a, &delay_200_500_e50, "L=
Q140T1JH01"),
> > > >>>
> > > >>
> > > >> How will we handle current/old crd DT with new kernels ?
> > > >>
> > > >
> > > > I think this is answered in the commit message:
> > > >
> > > >>> We have existing users of this panel through the generic "edp-pan=
el"
> > > >>> compatible (e.g. the Qualcomm X1E80100 CRD), but the screen works=
 only
> > > >>> partially in that configuration: It works after boot but once the=
 screen
> > > >>> gets disabled it does not turn on again until after reboot. It be=
haves the
> > > >>> same way with the default "conservative" timings, so we might as =
well drop
> > > >>> the configuration from the panel-edp driver. That way, users with=
 old DTBs
> > > >>> will get a warning and can move to the new driver.
> > > >
> > > > Basically with the entry removed, the panel-edp driver will fallbac=
k to
> > > > default "conservative" timings when using old DTBs. There will be a
> > > > warning in dmesg, but otherwise the panel will somewhat work just a=
s
> > > > before. I think this is a good way to remind users to upgrade.
> > >
> > > I consider this as a regression
> > >
> > > >
> > > >> Same question for patch 3, thie serie introduces a bindings that w=
on't be valid
> > > >> if we backport patch 3. I don't think patch should be backported, =
and this patch
> > > >> should be dropped.
> > > >
> > > > There would be a dtbs_check warning, yeah. Functionally, it would w=
ork
> > > > just fine. Is that reason enough to keep display partially broken f=
or
> > > > 6.11? We could also apply the minor binding change for 6.11 if need=
ed.
> > >
> > > I don't know how to answer this, I'll let the DT maintainer comment t=
his.
> > >
> > > The problem is I do not think we can pass the whole patchset as fixes
> > > for v6.11, patches 2 & 3 could, patches 1 & 4 definitely can't.
> > >
> > > Neil
> >
> > IMO: patch #3 (dts) and #4 (CONFIG) go through the Qualcomm tree
> > whenever those folks agree to it. If we're worried about the
> > dtbs_check breakage I personally wouldn't mind "Ack"ing patch #1 to go
> > through the Qualcomm tree as long as it made it into 6.11-rc1. I have
> > a hunch that there are going to be more Samsung OLED panels in the
> > future that will need to touch the same file, but if the change is in
> > -rc1 it should make it back into drm-misc quickly, right?
> >
> > Personally I think patch #2 could go in anytime since, as people have
> > said, things are pretty broken today and the worst that happens is
> > that someone gets an extra warning. That would be my preference. That
> > being said, we could also snooze that patch for a month or two and
> > land it later. There's no real hurry.
>
> For now I'm going to snooze this patch for a month just to avoid any
> controversy. I'll plan to apply it (to drm-misc-next) when I see the
> device tree patch land. Since the device tree patch should land as a
> fix that should keep things landing in the correct order. ...and, as
> per above, the worst case is that if someone has an old DTS and a new
> kernel then a panel that was already not working well will print a fat
> warning and startup a bit slower.
>
> If somehow I mess up and forget about this patch, feel free to send me
> a poke when the device tree patch is landed.

More than a month has passed now. One last warning before I apply this
revert in a few more days.

-Doug


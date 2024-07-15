Return-Path: <linux-kernel+bounces-252631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6696D93161A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88281F22349
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B1A18E75D;
	Mon, 15 Jul 2024 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lU2o1Srk"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D5618A95C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051510; cv=none; b=mIVPwYF5+DtuKtFAQG+bL05rQzQ6ew2yh3KvX1D7hR+ULo/4MFu+/3h5JFdCtWSi9sFcr+084dRh8UuKqw/nOssekgUZWiHQ6UrfP5I1B3aTgDKYrBafY07LsWVLzvsDf6N3hDhoQxtfnHr1QdLMOA3zaLRU66xZ2OGqIttbFlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051510; c=relaxed/simple;
	bh=ra2iu8Gz+ImwqgdjtFBQAdcGSDiM4U9XizTOJ8q2aDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thBy6/ugO67CrAMvju2U4RKatBbiewCiHGE9OFBGBYWVCy3yjLIzS2+IYOHy0mtlIk0o9JOJis95G7dLTMFWKNtbS7PUFjoLFwDDngiVy3gPhTYzew61i+qlKuwI04dj13GwSkOdXEwbLt6c3zEtVTfgAj/2XBz7YwfspGJfAWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lU2o1Srk; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-79efbc9328bso314252685a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 06:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721051506; x=1721656306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxXwbEHWXO/2KvCuP3hi693DOR1kiAPLV7jI7n5DAfw=;
        b=lU2o1SrklGN1ASW7Bo61bQT9M+6hqpOjHpD+q1EsWLz7GNiYkwUWlKdBoaspm1+ZE9
         N/aU1tjKH+NbtoWmWfIn0gNGH5WA6sodKjBwSl8xBoydA3QJp4fIU8SlQxZtf22pH2kG
         3+WpRHcnX1u9STITeVqUKFvKL7+UkXui2lrzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721051506; x=1721656306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxXwbEHWXO/2KvCuP3hi693DOR1kiAPLV7jI7n5DAfw=;
        b=B4xM5YqfbVUnJAuXxCivLALuuQ1CxNoLDnhXvHoSUN2k8RQPuValkQ2HK09PeYDtMk
         4R+3glRNh9gCYBpq5tPz7aAZMiO0ww7i9FpeDJP+uQwMaFLZ2HB6+86XwuA27MdtK2Z7
         cQac3pqFd6/UlfypFD4XPuA/6+Nc5TZw3pDDFI4CGW/ss2dMzMfXT8KnOY99rc4+9Gtq
         I/EmvLdZYzo98vlT8Fg/4p4M7NGJhu1smzONt1yKV+GF+YmHgV6b6HbEgcn2nzIFZ5Lq
         R009xvPwJsdBtewCsbw5SbQTKPxSnsCz45Wd98CO7ov9s/nFTIElygfShzTkoGf4Yapa
         bdWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbICt9Mkrib4uzJNZ4/io9ORkis/W7rP2jAavJlgW3kjHAcw2Fu66Q5xf1AZ+82VwVjYnf53p07hTkiUJ51nj3GQb1rafrI9ZODBKn
X-Gm-Message-State: AOJu0YwV8QTLTgWQsgpNj3uukz/1R0IDDaNFfzz70RMFHfbjNN7fpSSp
	EVUDACfquWe6HT8729KdvgWvxjsTW86hXdVEnbgZSBKv2OfF+IvK7nYBuY6ybyrrQ1OeHds8r30
	=
X-Google-Smtp-Source: AGHT+IEM28/9arer4efbUz27EC7wuJEk3/SnUP1N3sC6qYT2mhtWNBxDuBxhaYwK+CTORnZCVoSv9Q==
X-Received: by 2002:a05:620a:470b:b0:79f:1559:272e with SMTP id af79cd13be357-79f19ae387dmr2606702285a.61.1721051506504;
        Mon, 15 Jul 2024 06:51:46 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160ba4e00sm201189585a.2.2024.07.15.06.51.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 06:51:37 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44a8b140a1bso532591cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 06:51:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQyYerj94BfDkFi5E7Ki2OhIUQ6ofL5/kVlq0ugRc+mtgle+6vOuPh+aPaUJmXiE+C+CDn1poiNl0yu5YxL7pt+6eQJPDJH5u7ZNwj
X-Received: by 2002:a05:622a:124b:b0:447:e728:d9b with SMTP id
 d75a77b69052e-44f5a31e028mr6194241cf.26.1721051494780; Mon, 15 Jul 2024
 06:51:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715-x1e80100-crd-backlight-v2-0-31b7f2f658a3@linaro.org>
 <20240715-x1e80100-crd-backlight-v2-2-31b7f2f658a3@linaro.org>
 <7daa3c0d-cecf-4f50-be32-ae116b920db0@linaro.org> <ZpUcI3KkIa58zC55@linaro.org>
 <d1603248-afe8-4594-9e2e-81ba208dff00@linaro.org>
In-Reply-To: <d1603248-afe8-4594-9e2e-81ba208dff00@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 15 Jul 2024 06:51:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WimxYmDrkfn0+E3MbXp8kS9TicN2kT3AM4eM+SAwYsOg@mail.gmail.com>
Message-ID: <CAD=FV=WimxYmDrkfn0+E3MbXp8kS9TicN2kT3AM4eM+SAwYsOg@mail.gmail.com>
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

On Mon, Jul 15, 2024 at 6:02=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 15/07/2024 14:54, Stephan Gerhold wrote:
> > On Mon, Jul 15, 2024 at 02:42:12PM +0200, Neil Armstrong wrote:
> >> On 15/07/2024 14:15, Stephan Gerhold wrote:
> >>> This reverts commit 8ebb1fc2e69ab8b89a425e402c7bd85e053b7b01.
> >>>
> >>> The panel should be handled through the samsung-atna33xc20 driver for
> >>> correct power up timings. Otherwise the backlight does not work corre=
ctly.
> >>>
> >>> We have existing users of this panel through the generic "edp-panel"
> >>> compatible (e.g. the Qualcomm X1E80100 CRD), but the screen works onl=
y
> >>> partially in that configuration: It works after boot but once the scr=
een
> >>> gets disabled it does not turn on again until after reboot. It behave=
s the
> >>> same way with the default "conservative" timings, so we might as well=
 drop
> >>> the configuration from the panel-edp driver. That way, users with old=
 DTBs
> >>> will get a warning and can move to the new driver.
> >>>
> >>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >>> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> >>> ---
> >>>    drivers/gpu/drm/panel/panel-edp.c | 2 --
> >>>    1 file changed, 2 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/pane=
l/panel-edp.c
> >>> index 3a574a9b46e7..d2d682385e89 100644
> >>> --- a/drivers/gpu/drm/panel/panel-edp.c
> >>> +++ b/drivers/gpu/drm/panel/panel-edp.c
> >>> @@ -1960,8 +1960,6 @@ static const struct edp_panel_entry edp_panels[=
] =3D {
> >>>     EDP_PANEL_ENTRY('L', 'G', 'D', 0x05af, &delay_200_500_e200_d200, =
"Unknown"),
> >>>     EDP_PANEL_ENTRY('L', 'G', 'D', 0x05f1, &delay_200_500_e200_d200, =
"Unknown"),
> >>> -   EDP_PANEL_ENTRY('S', 'D', 'C', 0x416d, &delay_100_500_e200, "ATNA=
45AF01"),
> >>> -
> >>>     EDP_PANEL_ENTRY('S', 'H', 'P', 0x1511, &delay_200_500_e50, "LQ140=
M1JW48"),
> >>>     EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &delay_80_500_e50, "LQ140M=
1JW46"),
> >>>     EDP_PANEL_ENTRY('S', 'H', 'P', 0x153a, &delay_200_500_e50, "LQ140=
T1JH01"),
> >>>
> >>
> >> How will we handle current/old crd DT with new kernels ?
> >>
> >
> > I think this is answered in the commit message:
> >
> >>> We have existing users of this panel through the generic "edp-panel"
> >>> compatible (e.g. the Qualcomm X1E80100 CRD), but the screen works onl=
y
> >>> partially in that configuration: It works after boot but once the scr=
een
> >>> gets disabled it does not turn on again until after reboot. It behave=
s the
> >>> same way with the default "conservative" timings, so we might as well=
 drop
> >>> the configuration from the panel-edp driver. That way, users with old=
 DTBs
> >>> will get a warning and can move to the new driver.
> >
> > Basically with the entry removed, the panel-edp driver will fallback to
> > default "conservative" timings when using old DTBs. There will be a
> > warning in dmesg, but otherwise the panel will somewhat work just as
> > before. I think this is a good way to remind users to upgrade.
>
> I consider this as a regression
>
> >
> >> Same question for patch 3, thie serie introduces a bindings that won't=
 be valid
> >> if we backport patch 3. I don't think patch should be backported, and =
this patch
> >> should be dropped.
> >
> > There would be a dtbs_check warning, yeah. Functionally, it would work
> > just fine. Is that reason enough to keep display partially broken for
> > 6.11? We could also apply the minor binding change for 6.11 if needed.
>
> I don't know how to answer this, I'll let the DT maintainer comment this.
>
> The problem is I do not think we can pass the whole patchset as fixes
> for v6.11, patches 2 & 3 could, patches 1 & 4 definitely can't.
>
> Neil

IMO: patch #3 (dts) and #4 (CONFIG) go through the Qualcomm tree
whenever those folks agree to it. If we're worried about the
dtbs_check breakage I personally wouldn't mind "Ack"ing patch #1 to go
through the Qualcomm tree as long as it made it into 6.11-rc1. I have
a hunch that there are going to be more Samsung OLED panels in the
future that will need to touch the same file, but if the change is in
-rc1 it should make it back into drm-misc quickly, right?

Personally I think patch #2 could go in anytime since, as people have
said, things are pretty broken today and the worst that happens is
that someone gets an extra warning. That would be my preference. That
being said, we could also snooze that patch for a month or two and
land it later. There's no real hurry.

-Doug


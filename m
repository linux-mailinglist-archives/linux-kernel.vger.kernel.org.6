Return-Path: <linux-kernel+bounces-220367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5E890E04F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 02:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4E7282EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 00:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A690817A902;
	Wed, 19 Jun 2024 00:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ivYdYx2U"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B57317E441
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718755210; cv=none; b=KKO58L+DMhTbXRMFv0MMA100sfkpCUGs3VL/frF/COpIrdk+hWiExsInRLM96pxBZnQgSQ5srKpB5GcupWXlx2810xwT3YrNSg4PkH+Rr239fJXHijPJ5STSrNCRSXXsbAA1wkWAxfnUM3RmiPylSqiDa62pSHiaSoSM8mM9gXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718755210; c=relaxed/simple;
	bh=PuNTi5bUdDeMTi/XN+FoMWULngrNdVFbUfdvtMX5iBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/3zzh1i+iBDH50y0mOhOiQ+HPUKmJUYMco+PUmabfyrjIKGWNGlwLPtrbAuEsSogVCB7ytgSUbF7uR9UFqc+4OgKsJ6VWdvm2F6R9MTg9lEeARW9ik+5C/GubcrUmyvwh/Z3DH8HWJ8GWYow5BkJa4U7TVCcdSHB6d+4fJH9Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ivYdYx2U; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-795482e114cso506833785a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 17:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718755203; x=1719360003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dd6aptPdhHSWBGR29uSXjubG6ZgMcokb3JBWxjGVcBM=;
        b=ivYdYx2UGZfDyrOxZhR1AqPEq8tbLrb6UhDQ1xRjcoFk7JaXoz4KIuTtArpjS0ebh/
         MICsIkzbc4WUChM70CmuDArSs/FiDiAgg3cd+3pgVs4uiXuIxFuMYohTQWnH50b5PNni
         bsT1PVNEylPy18/BvSRQCtzi0E5DxllcR8fgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718755203; x=1719360003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dd6aptPdhHSWBGR29uSXjubG6ZgMcokb3JBWxjGVcBM=;
        b=CsmXg7xz8cbgIo8t9aXOQGKfDx1inyQsJbQmA4B8uvqH8cKtD6AKqupDDFX/4QN1d3
         Z7luFX/5qTbEEqP4AM+9toWVlm3Z3EQSbOcjvU4Yh9SNJZ2L4aSVb57ZJ0wD2862JL4/
         JpelPEN06Da+43l7bV+F/XK4AnciTp8swCnaBhcqisATsKUwIIEELm6Mi6GUxS8QTWRc
         fnoKHQem9U4vqsfgEE1NWluwRcsa421vhzwpdtZWOhK0x2LxHpx1WwWuPL6VMEMRugK0
         O85AKf2dPCM/LAN0mIC0y01KLxJ7pLLIQFYCBxsAhu+AY1iqfF5NbFK6h9ZAUrxIJwnL
         rbWg==
X-Forwarded-Encrypted: i=1; AJvYcCUqQxcVBy7tRhLzdu00gR7GK4l5rNYFONDNmjVu8tul8BHS8dvHz5Rw/wu9JqiYll51emsVKSybPLXAv3etE/QW9dQPxTjY3x3Q06Ms
X-Gm-Message-State: AOJu0YwNDDobETO4c1Ox9+MNRSjIpFQvYj2imbazTaNurX2tKXeDqEBc
	kS9hfiwaL3tqwEwdziuwQuTqd3ijCEpALVFnVydJFEVMbY+e2bNM2IsZE+A1ryfFmxHa9hNrWn0
	=
X-Google-Smtp-Source: AGHT+IH6rRF0hkAaXMjvngmgn6gUJibU3Se21rJpDV5AmYhgOdJjRndQTjkcpGlprJU62Ic5v739Iw==
X-Received: by 2002:a05:620a:4589:b0:797:adf9:b328 with SMTP id af79cd13be357-79bb3e5821fmr141023985a.42.1718755203309;
        Tue, 18 Jun 2024 17:00:03 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abc0ceeesm563870685a.73.2024.06.18.16.59.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 16:59:59 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-443586c2091so212041cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 16:59:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrSBivg+v3bCTRzAB8aFfvFdcTIPEMwv4EfrODanyrw5c+szaDSRdr7AifRzICvwwY/tMOnACt4T6L3IvuRv4HgHhzVkXGHKBGZKzd
X-Received: by 2002:a05:622a:54d:b0:443:99d8:746 with SMTP id
 d75a77b69052e-444a8b5e25amr1444801cf.0.1718755199364; Tue, 18 Jun 2024
 16:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614-sc7180-pwmleds-probe-v1-1-e2c3f1b42a43@collabora.com>
In-Reply-To: <20240614-sc7180-pwmleds-probe-v1-1-e2c3f1b42a43@collabora.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 18 Jun 2024 16:59:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WYAgKRwYrBgFvBjaR8WS6Cf4Q2mcH6ifwCp3ygbEdbOw@mail.gmail.com>
Message-ID: <CAD=FV=WYAgKRwYrBgFvBjaR8WS6Cf4Q2mcH6ifwCp3ygbEdbOw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-trogdor: Disable pwmleds node
 where unused
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Clark <robdclark@chromium.org>, Stephen Boyd <swboyd@chromium.org>, kernel@collabora.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 14, 2024 at 2:00=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Currently the keyboard backlight is described in the common
> sc7180-trogdor dtsi as an led node below a pwmleds node, and the led
> node is set to disabled. Only the boards that have a keyboard backlight
> enable it.
>
> However, since the parent pwmleds node is still enabled everywhere, even
> on boards that don't have keyboard backlight it is probed and fails,
> resulting in an error:
>
>   leds_pwm pwmleds: probe with driver leds_pwm failed with error -22
>
> as well as a failure in the DT kselftest:
>
>   not ok 45 /pwmleds
>
> Fix this by controlling the status of the parent pwmleds node instead of
> the child led, based on the presence of keyboard backlight. This is what
> is done on sc7280 already.
>
> While at it add a missing blank line before the child node to follow the
> coding style.
>
> Fixes: 7ec3e67307f8 ("arm64: dts: qcom: sc7180-trogdor: add initial trogd=
or and lazor dt")
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dts   | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dts  | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-kb.dts  | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10-lte.dts | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dts   | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts  | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dts   | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts  | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi              | 5 +++--
>  9 files changed, 11 insertions(+), 10 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>


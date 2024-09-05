Return-Path: <linux-kernel+bounces-317043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A4896D88B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2821F271EE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916CB1925BD;
	Thu,  5 Sep 2024 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PCtmJgo7"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872A81991D9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539382; cv=none; b=Mdk1oXs+tlaf6XBfOWbsHvy2ZVlLpFZTDSCz1ZO8SrmLVKZxfB83fyo8JD7gUqMzNNY37n+hK8raCL4IAKqe6stFMm7ML3t0lYrfx5xZ3bag4/zhaFPCfQ32VRf/K0SQ+bzcB+18qZBVEFAM2H4twnpQ7I7AOQzJ8arkSaPbHQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539382; c=relaxed/simple;
	bh=jovfnA/sLiRs7oZPBOhlwuC/A7Xo/vsKuc6XF/CfEsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJrMELaMKHupCeHDIpoC5Et9o3irFAfV7gv7wPFUXzp0+Qzg+OiiyjGwqNj/pmG/W4N9DjZIwcatDQjgVLosNC6G79yP63UsrEFWCJbet/lxIUdXyJYwYaS6mWnpZ7tlFn1r6Dp2y4oVvh2W+c6ai+JhtxwJwX0kYhQSGVBCvjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PCtmJgo7; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5344ab30508so1696012e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725539379; x=1726144179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fK76HDEi4aX/89LJo8UpuFQxmvfmza86TzqdAoWDznE=;
        b=PCtmJgo71PzEX/hckEYV+KVeb7AYpEs74r2eDuoMtt6f8D6jNhnXtcTzIvbqrvvlKA
         P3DLwK7eBlf67HE/hP2gORs33luZdcfKRP+sFbCq1tTk0sZC4JE8rjSvRC9t59R5dmY/
         5OqOebSxPGIqhPJQP56xGuV473TV35un6euJ65/HF4jyIJT60r1sHAti0HSem+OvlRBR
         ID4F8QVsSTfD4w0uQ6lJ6MR4okWsvrVt0OeQvZINBE997p7nKBNdeJLjtXqtlh8GXGIz
         NrSOVmjr6dV3L/dxn8qg40BqR5rZrcRLoprQ9izSZh+b9WRPVu/CzTqtUHs2Sia+Sw6w
         OAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725539379; x=1726144179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fK76HDEi4aX/89LJo8UpuFQxmvfmza86TzqdAoWDznE=;
        b=e4ix77RctAxYxJdbY26hoXbNKu1eEFexyTD69+ry9cDwzRsJ/Y9lcE1jTpIulexTAe
         nkU+f/8TATGBiC+ssr3vN2ZWwzsSD1sC6ILzZ4vthR4Tqc7HBxGOEVkC3IPX2ghQvqop
         GiM310jvZEb0ls5CxYfKmCGc+0SQphSJBOzSGUDV9rjmz0QxSCEZ5ohPSVgz8gO2Ks+X
         AzTqYnBmpEg5QqLGuRhaeLk7rNOCiDr2IS4AFXqrXdLR02xQRsDfadsVCBAaVFywUiIE
         iVBSHTAhz44bXhLNnLyjJYVF2uoucQCMSKaGnG5IpOVucCsFFb2K+vFikVSeGtafDK+8
         zgrA==
X-Forwarded-Encrypted: i=1; AJvYcCU4OhQPO4ICBCDhHeiThcgimw2/HwD1/CdHdVJhFMGB+Exlj/7UKto30eyLlHPbgwA7MrekOzFNXlTJLCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX48uT9NTYjgMW9DnIl9arihJdqmNx94EUL5NF6g51AXlWCG9/
	kQtzdR6X9DZGGWVPChFV+pg8WuHb9marAUqFvskx4JmvyeMks/aKaBmYrMPQgS1WsxkaH4wlrwy
	I56FK98zQaN+95CKeUaJ34yz1RWv+0ZFE9Rp9Hg==
X-Google-Smtp-Source: AGHT+IFlwyf2AQmKglWdLPgpR7ABMAwdEChx44kvPSTZUPxSNTNFWAxUZMKqkmDV46ZT+VfT36PQ4GQgXUyrMg+rgJs=
X-Received: by 2002:a05:6512:2309:b0:534:53ce:54a8 with SMTP id
 2adb3069b0e04-5356779ac83mr1653495e87.30.1725539377827; Thu, 05 Sep 2024
 05:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905122023.47251-1-brgl@bgdev.pl> <20240905122023.47251-4-brgl@bgdev.pl>
 <CAA8EJpo2-P8N92XFRYszbZwo1gDbRPe+O=THafxWSbk1ZH-BoQ@mail.gmail.com>
In-Reply-To: <CAA8EJpo2-P8N92XFRYszbZwo1gDbRPe+O=THafxWSbk1ZH-BoQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 5 Sep 2024 14:29:27 +0200
Message-ID: <CAMRc=MfcRXW51_xPYXesJctzo6-U3gm0fjJpG=-zAJewVnc7YQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: sc8280xp-x13s: model the PMU of
 the on-board wcn6855
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Steev Klimaszewski <steev@kali.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 2:27=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, 5 Sept 2024 at 15:20, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add a node for the PMU of the WCN6855 and rework the inputs of the wifi
> > and bluetooth nodes to consume the PMU's outputs.
> >
> > Tested-by: Steev Klimaszewski <steev@kali.org> # Thinkpad X13s
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 98 ++++++++++++++++---
> >  1 file changed, 86 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts=
 b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > index 6a28cab97189..88b31550f9df 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > @@ -400,6 +400,67 @@ usb1_sbu_mux: endpoint {
> >                         };
> >                 };
> >         };
> > +
> > +       wcn6855-pmu {
> > +               compatible =3D "qcom,wcn6855-pmu";
> > +
> > +               pinctrl-0 =3D <&wlan_en>;
>
> pinctrl for the bt-enable pin?

Ah dammit. :(

I'll resend tomorrow to avoid spamming the list. Thanks.

Bart


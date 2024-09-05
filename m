Return-Path: <linux-kernel+bounces-317032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0323B96D86C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236921C2569F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB4619D063;
	Thu,  5 Sep 2024 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sjnpjkLu"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A6E19B3F9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538906; cv=none; b=TbJy9/RZQcNBPTNgWe3Vcn190QCec9L+YGab9v3dxThNpceFTtTw+3+6mIxXSIz7FDkAz3ccs1z81lQhJHC+YA2QS7Jxd37an/YehYNjCqTjEdIjI9T5zrwctQMn/pkI0OvTxplWzUSBlSo/TjUpuR47zZNFPyXYMKXqPF84mjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538906; c=relaxed/simple;
	bh=F01XbYYcnFz3IrGJAZEt/h6KlLzKcoJy+krrnv7pnJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPbtfnR9tn8+/ZpIEAPMpw6dv1qdYjzQGsY/4I/ZjmlpDT/tqU2mzpyqezzNh4mnVAfrixzrvq0s5IYlrBveVn1tKJ4R/8APsncZdPIXqPgU/W/kYYsOrwfOYefR6pXikafqbtPSD9o9kyWefOq6wwXG6vPQuFQ+7F1mOzDBHk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sjnpjkLu; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5353cd2fa28so822962e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725538903; x=1726143703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TACxCNrG/DopYef41PGhbtqig8LKMsOnKp3kgyqsYHs=;
        b=sjnpjkLuw1INmoHTo4VwdOPWr86OrPYTHyFc/HZSTGlqSL6+lE7mj9xYlg75bPN8HZ
         kzEjJLRDJiWSdnIN1+h+vysHjaN0eg5g+8sesDdqTd/0SCR2K8aCH0mCk++/fKkYUlvK
         Kn3QfRNFsEpaMbjYffJiYlj/lCGEZ2wrhRMOeVV/oduW6/CQozNRJmqwitRz/1FF/JZ8
         NoH7rVr1owoHGNkcpNCl2fSlAmznjPLahN+AK70aQCYIzrM/V4E7Yw6OmgzKejP5ahIx
         TnrL547DbyQFevjgVs4vF/oPJObQD2oKnGr9Gyd8XWe1t2kcYzq4FT12R9hYGL70Rw0Z
         zo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538903; x=1726143703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TACxCNrG/DopYef41PGhbtqig8LKMsOnKp3kgyqsYHs=;
        b=fu01v2c1zJfrNDwdeWwxP7YWP3KcMsJXBM0BxsQkj4yYfpP7ceZubgTod8UXF+kono
         4XOWFMtO94DECfIA5uEw688ZEHFoBmcwblS6O+PP0LLsjbU22DWEZL7jgkvCXVlOwwWd
         Ewj5xPNQGpGNnNYpt/hqflOvausoi9H3W8Eq8yoYdxTu+6qAcaK2IyxRkOQQOB9im8sa
         lIEkL2G5RWcsCy8Zq9BH0fXqkqx1blZx9JNM4020zpxQSjfHYGl7ljxujV5/ns9ifJ5/
         wBJRuFX+ryDKGomC6uSXkexp1m1DLscCO0q4motqR7yJp9VYLW7T6RXQrDeP6K5CR8zM
         4ikg==
X-Forwarded-Encrypted: i=1; AJvYcCUOTxm6jpG7z31gyGp5mH/K/C7yDEW8Cg/RedlhZt8NpwZ7hcZwaNG5B943m1NPQWzMrAeHy2GaeiZOk8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfTpYQhhkWYlfnqKNwaRTxT3Gnkfbt4ZSYdmKw1R0gw42LufsF
	9dECxOpf0yRxwAQ4AP45kKU89P0dBxfnquWspsQW1IRqWU+JhHmYxDjsQBumW3yXOa6NeJxr1Qp
	R6oXLYgykcc5plvzrISrURI18D3JclNOzHqZ3LgZDE80AyY34
X-Google-Smtp-Source: AGHT+IFcMMTAuv+S+5/9hcRxIAh41Pmij3mBunr6XibOfsaQXElI+A3yPmhY2q3bx6emgGpGca4XjRlTGGn+3XPVLNc=
X-Received: by 2002:a05:6512:3e06:b0:52c:dfa0:dca0 with SMTP id
 2adb3069b0e04-53546ba0eabmr12703593e87.43.1725538901776; Thu, 05 Sep 2024
 05:21:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903093629.16242-1-brgl@bgdev.pl> <20240903093629.16242-4-brgl@bgdev.pl>
 <lpjfpgnbhrp3u4rqczoouf2kvktdigisi3sjhfstanw4t5g2sc@fvqana5gftds>
In-Reply-To: <lpjfpgnbhrp3u4rqczoouf2kvktdigisi3sjhfstanw4t5g2sc@fvqana5gftds>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 5 Sep 2024 14:21:30 +0200
Message-ID: <CAMRc=McmnXe83bsRf+uivV05Z_dv8V9ox5Rx3kGH9O1eDpka1A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sc8280xp-x13s: model the PMU of
 the on-board wcn6855
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Steev Klimaszewski <steev@kali.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 4:18=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, Sep 03, 2024 at 11:36:28AM GMT, Bartosz Golaszewski wrote:
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
> >                       };
> >               };
> >       };
> > +
> > +     wcn6855-pmu {
> > +             compatible =3D "qcom,wcn6855-pmu";
> > +
> > +             pinctrl-0 =3D <&wlan_en>;
> > +             pinctrl-names =3D "default";
> > +
> > +             wlan-enable-gpios =3D <&tlmm 134 GPIO_ACTIVE_HIGH>;
> > +             bt-enable-gpios =3D <&tlmm 133 GPIO_ACTIVE_HIGH>;
> > +
> > +             vddio-supply =3D <&vreg_s10b>;
> > +             vddaon-supply =3D <&vreg_s12b>;
> > +             vddpmu-supply =3D <&vreg_s12b>;
> > +             vddrfa0p95-supply =3D <&vreg_s12b>;
> > +             vddrfa1p3-supply =3D <&vreg_s11b>;
> > +             vddrfa1p9-supply =3D <&vreg_s1c>;
> > +             vddpcie1p3-supply =3D <&vreg_s11b>;
> > +             vddpcie1p9-supply =3D <&vreg_s1c>;
>
> As the WiFi is now properly using the PMU, should we also remove some of
> the regulator-always-on properties?
>

I added a separate patch that doesn't seem to impact anything with the
PMU changes applied but will be easy to revert if something does
break.

Bart

> > +
>
> --
> With best wishes
> Dmitry


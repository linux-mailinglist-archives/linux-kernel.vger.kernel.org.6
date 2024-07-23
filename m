Return-Path: <linux-kernel+bounces-259939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6375493A029
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9518D1C21C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD9B15098E;
	Tue, 23 Jul 2024 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yElmIR5i"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66A413D609
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721735172; cv=none; b=TTxtb0bhpAMOa5LPGbeduhs7pVptsJu5KolsCwj2l7Kp/wlFQ2eUaK/ZqCsACxu8a3qQ5EQ8Po7AKbw1UVb7qRFtEhwMa38ixQWYmFDYV1uMTgOgGG/4QMzTsMfrfMoIrrXYENmrQqi8rorrWYmDE2HncFnetK9Q2vHDc6cIT04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721735172; c=relaxed/simple;
	bh=M5tjVdtGLE6ZhRpxAclw0H4aLNG85TmecfEaglE2mMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgaA4ds2BHyyHFv2IHRYXj7sPcaDpgHajb+GFoWyaiYOl+lZcfW2XzMBcG1AB7YiEWUieiOrzNkrJJvrYzEOtWcIXZiPuolx9IswTKWwiDFLiX9hnaNHZiG2E1ZxLT0KLPsilD5Z6qorsx8qS3JOHcpOdjsr5pQaDYHL3Q5arEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yElmIR5i; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-661369ff30aso46469217b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 04:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721735169; x=1722339969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9J1nHOASn3flj0zt7AwDv5DGq2s4Mkvfg+lObtW6fk4=;
        b=yElmIR5iufXUJkRbAbB+3tdViw2k2FSWmERBLicHa3aZCP6mvA31RF3LSqqugn7opI
         Kibcu2fVvQARMjuQ1eOZ9DnTDB5ffB1c3BBjPooZEPVW6CjijTV+0nV7GX6lxmegZEzA
         Gg6ixkpoXAtfc7iuiw8rVVdmQerggsv70XSoorDm9MXGLTAwZ4OoN87impVMJy+tkcj9
         6sBZcBsF8mVRZPDDhonR3R8730e4Fifi8dygmMERoyCcclX2ev5hi2GrTuj5x+Om2DKb
         78Uy79ShLka+Sb+XaT6VikddiJqE0iT4/2igHPD+yl3Zz0tEnClqkGwg6rCXoYxIN6Fk
         s6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721735169; x=1722339969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9J1nHOASn3flj0zt7AwDv5DGq2s4Mkvfg+lObtW6fk4=;
        b=Q3LQkC4pCGeVGQ/Sek3g0qt92vwutsGmV4BY6Rz4V91a5IJZ6BcXPntCACbqA6THS6
         /60XGOLa9cmFle7xuu/tA+WfhcGiracPyn60C4tVjmPwCE8PZC/CCTxaoVK+ZxnmvWz3
         R1qkztVFBV2Mv8M4zMM0vXPpngMhr3Uggtgs8GPfake2XcypjY6tb/mBT8chdiSnsHia
         N4JHXl0ovrtzWnfuwNimRuFWn8tyv1x61BX+LKBHgknYpOx5M9UUIpOYvVCHPhHIXV07
         qgAmrGacj/HgB52TWvbj24Ydq4rpeOD0V8FInAkWTZHgyeLOodKI6hvo1yz+MbKySCWn
         4u5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWB+9uk2MFJ2SDlpZRw+kI0sqpZkvvaNwieOx9iPb1lQGBW3fu87XF4lzL7EJd6vwQ0qJ8H+ZtausJwG1dAU2OTGyNaWhwfbGdIRiaY
X-Gm-Message-State: AOJu0YwRCtsvj+eZ7V5bajit3bW/UXwI1wNMPdJaR4V/BCFJoLY8lZLJ
	L2eOc5ELCsZd6TwpSO1jRaEnBF38BUzPrYtD0bZ4p2HR6aq2lHx6JDog23wlTH2UzHp4z2l/0Hs
	fLQsLhxW2xaUhKYoIh8a7/BY3xdih7uf4DQKWAQ==
X-Google-Smtp-Source: AGHT+IGSYGEDmVnHeFsuTjlmIqz/4ONf12+6+8f3LKRIe2y+UOYqU4Ftt4o/BdIVEMd/OYTtRDd0xQtn8+Y5L3Jy2LU=
X-Received: by 2002:a05:690c:3107:b0:64b:2cf2:391c with SMTP id
 00721157ae682-66a641398e9mr106886647b3.18.1721735169615; Tue, 23 Jul 2024
 04:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722-pmic-bindings-v1-0-555942b3c4e1@linaro.org>
 <20240722-pmic-bindings-v1-3-555942b3c4e1@linaro.org> <umsttn5qdjzg4cmgwya53la2sd57z3kxv5wo2b4nwme3jlthis@4vn3vwnlldkp>
 <df3bb042-1fb6-46ef-ad6f-1cbe0a380dd0@linaro.org>
In-Reply-To: <df3bb042-1fb6-46ef-ad6f-1cbe0a380dd0@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 23 Jul 2024 14:45:58 +0300
Message-ID: <CAA8EJpqEDqY79pFv_FUH43++BW1iUz3J6sozCEVNfQyQPBjCsw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: qcom: pma8084: add pon node
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 14:39, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 23.07.2024 1:35 PM, Dmitry Baryshkov wrote:
> > On Mon, Jul 22, 2024 at 12:47:57PM GMT, Rayyan Ansari wrote:
> >> Wrap existing pwrkey node inside a pon node, to conform to dt schema.
> >>
> >> Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
> >> ---
> >>  arch/arm/boot/dts/qcom/pma8084.dtsi | 14 +++++++++-----
> >>  1 file changed, 9 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/arch/arm/boot/dts/qcom/pma8084.dtsi b/arch/arm/boot/dts/qcom/pma8084.dtsi
> >> index 2985f4805b93..dbf7afcbfd8b 100644
> >> --- a/arch/arm/boot/dts/qcom/pma8084.dtsi
> >> +++ b/arch/arm/boot/dts/qcom/pma8084.dtsi
> >> @@ -19,12 +19,16 @@ rtc@6000 {
> >>                      interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
> >>              };
> >>
> >> -            pwrkey@800 {
> >> -                    compatible = "qcom,pm8941-pwrkey";
> >> +            pon@800 {
> >> +                    compatible = "qcom,pm8941-pon";
> >>                      reg = <0x800>;
> >> -                    interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
> >> -                    debounce = <15625>;
> >> -                    bias-pull-up;
> >> +
> >> +                    pwrkey {
> >> +                            compatible = "qcom,pm8941-pwrkey";
> >> +                            interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
> >> +                            debounce = <15625>;
> >> +                            bias-pull-up;
> >> +                    };
> >
> > It might be worth adding the resin node too, see pm8941.dtsi
>
> This is a cleanup series, adding features is another thing and it
> would be nice if somebody could test it

Agreed.


-- 
With best wishes
Dmitry


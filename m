Return-Path: <linux-kernel+bounces-259902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A1E939F7B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344111C2202F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3767714F9E4;
	Tue, 23 Jul 2024 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HAeVsB6U"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E459A14F9D9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721733132; cv=none; b=iyjc5abwCE2+zDr0rswR/AZQW/7leRM6YRhs5TUIQwKPV4HWAGoGUmN/EUSbuDehBZgRtBT8vrty5jwQHmjOlwMCER5fGavqeDALxoJysX6nOBA464DYIrERRf+eCWai3xXeyIyhLulep5Q3DYpe95j5VsbbUdSUuzFSNqDc4uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721733132; c=relaxed/simple;
	bh=IvzIW2clA3I7GZ4v4J56J8ja6IwCiuGy9Lu+qz6Lwgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPVlQ/u/YhkxehVRQ4sM2Hl1p5dKKJxKoB1LLSRgc1Pl8Btc/3PU6P2MicZu4SY7h3z9a8X3q0YP7i1gz4Mk0aYx/uX9VzA21+XkSAiVG0lM3IDacgbvHu4uJNVQSYIXRUedoRG2mkjkhi9m7MED9KVQZzPBJs3aRh1Q55W2FE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HAeVsB6U; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-66a1842b452so36098507b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 04:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721733130; x=1722337930; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VY9kR9+u3xGnZyuvPfUJwJjyKQqZEzEIXFGJcOyXF/A=;
        b=HAeVsB6UidUpRNiP3gzF9maf0b/iZHaEbQisFR31OJY3ZdLhIe4h42cYfkeSrTMD2C
         EioCdv0zT7DwBefyplv5gMlbEjbrrThrzMOaw85mnGFXeb/rnOeEIKo0t90FcbMSi5n3
         66CyABxcc3Z4yijmvqiW053d5cka6QDsnBrfHW4SlgJOjW1P0l5J5qh9rSYlcDWMAb3x
         WXXN/z22SPY9HeGSSKAaAmw6fK4mm4AIhgS6bBwMwrZDGNxcB28ehygWU12dISY9sl9t
         RmrNLYcEq++EG7vWsUTC3EWcrvRNaJlsDCijBHWlUlzWEb5878R0bKWvBBv3n+wAB61e
         0TXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721733130; x=1722337930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VY9kR9+u3xGnZyuvPfUJwJjyKQqZEzEIXFGJcOyXF/A=;
        b=RtHK3OM2LB7MWCitsPO1SDCyVGT/zktTr9PzPGsJWdFNR+7OFZPz4lq3XDVU9ps0KU
         bOw97uQJ5eSssUtXFo19PLBWw0IwoK4LJhU+4X9lUM8GVRltvWPfdQPC1D8wcr5h190g
         Dtf0HJkvG8pK5PNrc/oJEucZ7zE5BzWRfK9sPhIWUW6OdiPmrZTjk2awV25/qEQFJnEZ
         1uhmfdSmmrbTkWhWg+Ecb6xQ5qy4iMXx09ishDMipGiW8Y4687PKfoNAQTqx11SSoqDx
         HvuFPq804xUCjlJt/DBBCwMwbEi1qjBIaRPtq1l+3rW6jYMDSXSRBSTubtGB550yOQWr
         cmWg==
X-Forwarded-Encrypted: i=1; AJvYcCV2LJOb/h2StlwSKdmVV7+eNRkVdlt7XwUWLwynKl/cKeTb9gf5BAKGpKMyuHMcYkY+ZI735fwqpi8+DTSvVMWRcIxJSkc6NGkND+Yy
X-Gm-Message-State: AOJu0YxkGuMdkHAgwi7QeGfqJP0VXxrHCDqFiBNBEBdkmak+O1z2t5FZ
	PVnH94Rz3GkQqY+VDqUddvt07V1xFK/HM+Q72wtC486HtnMKUTZYC6+uBtDggOwqTo0qGiCo8Km
	WS0Li7qATC4CdK6zoAlmh/ZyKGdUCIHRIB0QZjQ==
X-Google-Smtp-Source: AGHT+IFMnTFT7vPcY+Zxr0a0QqBAxxsVv2qmTLZ+m/AsVwQAEBYUMa+4mr/VFc2Y7CyYP17aKtDXJGa2I0EwFghD4fk=
X-Received: by 2002:a05:690c:f94:b0:64a:5ff5:73ef with SMTP id
 00721157ae682-66a654aa5d7mr128979387b3.0.1721733129835; Tue, 23 Jul 2024
 04:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722-miix630-support-v1-0-a6483cfe8674@linaro.org>
 <20240722-miix630-support-v1-3-a6483cfe8674@linaro.org> <3a257754-2118-4a7f-9753-f1a2392f9279@linaro.org>
In-Reply-To: <3a257754-2118-4a7f-9753-f1a2392f9279@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 23 Jul 2024 14:11:58 +0300
Message-ID: <CAA8EJppvwXEiNs-6orVMSkkjJu4nYY4ZNdshbB1sUM=z4ouYXg@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: qcom: msm8998-lenovo-miix-630: enable
 VolumeUp button
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeffrey Hugo <quic_jhugo@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 02:24, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 22.07.2024 1:57 PM, Dmitry Baryshkov wrote:
> > Add gpio-keys device, responsible for a single button: Volume Up.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  .../boot/dts/qcom/msm8998-lenovo-miix-630.dts      | 25 ++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
> > index f585bc8ba2ce..bca309ac0cb8 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
> > +++ b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
> > @@ -3,12 +3,27 @@
> >
> >  /dts-v1/;
> >
> > +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> >  #include "msm8998-clamshell.dtsi"
> >
> >  / {
> >       model = "Lenovo Miix 630";
> >       compatible = "lenovo,miix-630", "qcom,msm8998";
> >       chassis-type = "convertible";
> > +
> > +     gpio-keys {
> > +             compatible = "gpio-keys";
> > +             autorepeat;
> > +
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&vol_up_pin_a>;
>
> property-n
> property-names
>
> > +
> > +             key-vol-up {
> > +                     label = "Volume Up";
> > +                     linux,code = <KEY_VOLUMEUP>;
> > +                     gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
>
> No debounce-interval?

Strangely enough, no. See existing defines.



-- 
With best wishes
Dmitry


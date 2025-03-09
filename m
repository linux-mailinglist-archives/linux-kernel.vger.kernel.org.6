Return-Path: <linux-kernel+bounces-553394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1578A588A4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 22:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E463AC31E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 21:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6D821D5BD;
	Sun,  9 Mar 2025 21:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xdM81uMJ"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D77216B3B7
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 21:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741557159; cv=none; b=S358T0kzen+tBkyctJITVTexpArLoMCqiLoS0rIiSo57nD4reu4PFC8ffq5a0rSSnnBM49WYjmipeLgBOy+mWd5tOJqQcfYVxxYRb981QIUGuWWLM6I5MvenbhUTvrcI/G/9tCVbaIRwprojjjA548I6HLzCIXQFDzVIsxqKREQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741557159; c=relaxed/simple;
	bh=znDduV8o5do63kBgnI87Al2XfPX6k0jTsz0vM1YT25o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDfNSOh7quLxgNuoNBXC7Pp5GBAsTrbAYB6rmHAXjeSw0rY2n38IOgooynArfQzfcu4WUoAkkzkpvYZZ4VDycoqsl2owfl3d4o5pAML5ifgi6Xelez4t9X1fywskun89nfWrlhyRQGEDwntEFLx40lWdkJUqx4pxyA2YGFcbSeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xdM81uMJ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6fead317874so30534607b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 14:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741557157; x=1742161957; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x2cXZ1H4OWYbGTrPh8vFke/8+4UNPAMB80eBPTb7iwg=;
        b=xdM81uMJ8UUubdaE9BAReuxEUkQmJPSYLKm1g+r53p7I+R1wGOKzP8pwiSnVFV4q05
         +9zMEcx1oKBxl07pIERLrYr5r+UYTW7K7SjYueE3iyOfbGPQop3wi7nulqmYyq0TozS1
         m8bmhaWaHyfzkBlp4FhHfwpagWv7kFpQ4p3PpKnSCPwKIABQqXNfvZ0dvQ6G2oC3Fd2k
         2+7gWwXMsSLo7U3xfCcek8hSsdaxGhZ1bvf9CiXC48hwd2TFU7RlunPgDP6I+6D9wQod
         uSIG57P5J68a+AiS9GpXZkArPaqy/hXHZEB+4bNov+oj7o8UwMxtKYZbZguSWdDaBFpO
         ziXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741557157; x=1742161957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2cXZ1H4OWYbGTrPh8vFke/8+4UNPAMB80eBPTb7iwg=;
        b=jJKrDUjbmStVmDSCiYNPao1pPit0HuoYBMh2rC5mHrJw0sdktcnlX8/PdLxJrKdNnY
         HM+jEQ7j0bbpvAgzz64quO714sWS8pPm3NKZ+LBt8UMggM3wraX/+7q397t/j24ijFwW
         eaE1X8/86ez9FFSr1Qs/y3lQxtojOU8SHy5Vktm4wuBbAb//KJ6ZkKsWSqtoD4xVfkaG
         vefjx3ovGjapfZ5A0/2ZlyLBiebpjrrqFQRwJGPw3sGLd+wEWaYtKin0GlaNsIX6tuAo
         V0iwf4FUadieCiyxbo/52sWEhoVbWVpWXi/9813bYt5Dsl/XKRkwquSFjqGXY4ed3mfp
         xOHA==
X-Forwarded-Encrypted: i=1; AJvYcCUMzBrlmxI43nnaRb5MD4ErWPa1b8MN/KAdbCng0P+rTw9aN4v4SRops7KrvDmCbmdacHPgmxf36SK3zPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4sjJAQqxoooU0LXUPnz8uWoY/OvZWAr18OzPfy8CgbQ4YOjDk
	TjnJYz+6KIQ9Y4AQhr9d1dgWxLyiebK/DFeLPhDdph3OTmA3eEKrWT+GL7D12RAeONptt3nbqQY
	foGtHgNxdi9CFUE2xsV+eXKei7YdUaVjBhaqhLg==
X-Gm-Gg: ASbGncvTfousWJU/xj2QFY24fM+ek1Ecu9RYzm9Io0irHMbgC6MeU3EEOF+UzzrEh08
	JYPzq82fE4XQclKclh9csHpMEmBAFmQLyRaP/sY+vZgXaDJw9Ygn4v4EzSCe2By3AKmnzbyQsrK
	fGobsgT/nADVVk1zQ6+A94uhRCHolBZzCrWuVTeepmc3St6eUNhARMY50=
X-Google-Smtp-Source: AGHT+IEwTe7+gG6re5FQDG7RY1yURSNJRkSyIZAU9lwF7FoyT/rEI0T3LIFPG8BM7OfSqpJwMlkh2/UTicN36O2msKk=
X-Received: by 2002:a05:690c:6f12:b0:6fd:9f44:f3ab with SMTP id
 00721157ae682-6febf2f2438mr162990607b3.13.1741557157024; Sun, 09 Mar 2025
 14:52:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309-lg-nexus4-mako-v3-1-1dc2807df296@ixit.cz>
 <l4lv22oi2ktubf7aveqxqtwb7zz7cfrzdayuxxgwdj46ygubfs@qpl6ut37taoe>
 <88da307c-0403-405d-8356-c8baeb18eaba@ixit.cz> <qu5w56bp5yurdgbhjpeiabn5pvpoov7xfyta5j7djnnrveak42@povbs5bddtsz>
 <c67defb5-f677-45e0-9316-cf0a60238393@ixit.cz>
In-Reply-To: <c67defb5-f677-45e0-9316-cf0a60238393@ixit.cz>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 9 Mar 2025 23:52:27 +0200
X-Gm-Features: AQ5f1Jo8FnoegJUkwQU389SNer04ipCTPWac6KL_0tUVVQOS-Rp5nkRzvpEdsJ0
Message-ID: <CAA8EJprdmS1dFem_7vud=QgZ2G27crYF2X3G4=QRS76c8EJvCA@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: dts: nexus4: Initial dts
To: David Heidelberg <david@ixit.cz>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Ivan Belokobylskiy <belokobylskij@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Mar 2025 at 23:39, David Heidelberg <david@ixit.cz> wrote:
>
>
>
> On 09/03/2025 10:36, Dmitry Baryshkov wrote:
> > On Sun, Mar 09, 2025 at 10:17:29AM +0100, David Heidelberg wrote:
> >> Hello Dmitry!
> >>
> >> Thank you for looking into it. See replies.
> >>
> >> On 09/03/2025 09:33, Dmitry Baryshkov wrote:
> >>> On Sun, Mar 09, 2025 at 01:45:51AM +0100, David Heidelberg via B4 Relay wrote:
> >>>> +
> >>>> +&riva {
> >>>> +  status = "okay";
> >>>> +  pinctrl-names = "default";
> >>>> +  pinctrl-0 = <&riva_wlan_pin_a>;
> >>>
> >>> Where is it defined? Also pinctrl-names should come after pinctrl-N.
> >>
> >> definition is kinda aside in qcom-apq8064-pins.dtsi .
> >
> > Ack, missed it.
> >
> >>
> >> All other suggestions incorporated, if it's OK otherwise, let me send v2
> >
> > I think this also needs several supplies in the riva device itself and
> > in the iris subdevice. See qcom-apq8064-sony-xperia-lagan-yuga.dts.
> >
>
> I don't have the device in my hands, so if I figure out the regulators,
> I'll not be able to test new WiFi setup. I would drop the WiFi node for
> now, so at least the base regulators and eMMC gets and possible someone
> with devices in his hand can push more functionality forward, if you
> don't object.
>
> There is slowly forming some APQ8064/MSM8960 community, so I think there
> will be updates, now I would just settle with minimum, so our downstream
> changes will contain only small chunks to get upstreamed.
>
> Would you be ok with this approach?

Yes, that sounds perfectly fine.

>
> >>
> >> Thank you
> >> David
> >>
> >>>
> >>>> +};
> >>>>
> >>>> ---
> >>>> base-commit: 0a2f889128969dab41861b6e40111aa03dc57014
> >>>> change-id: 20250309-lg-nexus4-mako-da0833885b26
> >>>>
> >>>> Best regards,
> >>>> --
> >>>> David Heidelberg <david@ixit.cz>
> >>>>
> >>>>
> >>>
> >>
> >> --
> >> David Heidelberg
> >>
> >
>
> --
> David Heidelberg
>


-- 
With best wishes
Dmitry


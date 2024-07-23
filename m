Return-Path: <linux-kernel+bounces-259885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FBD939EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC431F22711
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECA314EC57;
	Tue, 23 Jul 2024 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O1czTTXx"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C143913C818
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721730807; cv=none; b=U+eatq/Hu1TJbODseXp9jMJdrxjuM7ZVbn0MspiqI9wM+PzAYGkkdmVbAxHFOkDsGyb82DH9WDQD84n6jgZB3WiUY2PTMbROHi9uDQH+1Xgg+IK+1X8Z78VNuxm7dMvTzdK4dhYmA2/HN4phCDkuCiINSPsbJM+IV9b0nZWOxKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721730807; c=relaxed/simple;
	bh=m5FZdSlKSn2HH1WK/8QoH35aY2wLvBYaB1dz9p412/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUE5BgahYPUSVaWmt8e1aP8cegxncHzeP4y25fq+QL2/8XZ2uHTt60hRWDFVZrBLBd42Bd8OQHatfOaj70OCquy4VQvJH/6q/cKRBEFOJFZAUav4uREAJ1YrAhQAZCR7btoiGXV5g0I+CCdHJKPOIpAVa+Nyf76mY6d+ICOtljE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O1czTTXx; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dff17fd97b3so4981682276.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 03:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721730804; x=1722335604; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+cYfTKvKSj7lLoJokuJJ1LaOPnzxS1ubH2/iuemUb/w=;
        b=O1czTTXxBv7hIsLjrT7Wth+zQcXcVk93479T+TDZu3p40qhTehJ/NtUBbK1HQ9cW7H
         0kzJgwb3zuvaflqowmUH/yajv2sGhoX/RAo1f2Jn3MrgwV0CsPPGL67XrxYVNvoVrnWW
         WsuAxvNpsvtv1rR9RyMlXRSXaQLPk3hOWtdm3Mhn1N9wFsKowrMqOj3AXkSh2kjePN+y
         mR9kVBHrCW4O6MKYmqa83tzVLpO4S18k3hZ/iLHwbWRllWTFOlix9FJWZthVaCSHVqlV
         K5Asg4gUUVDiiBgA7NPYfNuU1wwg02o4lfzJ1/p2FOWCgFakFz/d8MCYug7WnbcwYwTE
         m6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721730804; x=1722335604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+cYfTKvKSj7lLoJokuJJ1LaOPnzxS1ubH2/iuemUb/w=;
        b=ASxaJbbTFsCtOPeo3lOpFsuuQc4RMQ/LBMlSpUBNb4rbl8Yn1sCGwNpf/zHTVGEaZF
         HWugO+VoPWosz4cosbPoFz66a13G2Cqp5Cx7JdXPicq7YMMffzLksef7JI9qXaS33wB0
         eD6NCaJTnwPNzAmf1+reYiJ6KKFudBTkErWaSiyeGApuMECRQTPep8fZdVIpTYl6/hDW
         9vSn5Qv9t0w6PlDrvkafIHn55FghyppLLmWvXQ+oVf37euTFRYJfRo1a3bo7YdVHpURy
         QL4THnizKkYv04I1DfHf5i/obJrEvjkfm244KMiF5UOh+S4wBQ5efV4NbQ2rqoyf2cJt
         P5Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXayE6D5v/TK3EAZ0gR1Tlw+XsuvpE4UKL573/YZJATe9pjydKrr5n3z8yZV3+3nqMUNN2RJsxOWTZkxG8QTCTF7i37kuQHAxLY66Y/
X-Gm-Message-State: AOJu0YyZtJeI7DC2tX2JErbDufOYwGCJsxtPbvOb4p5BjxdIl98u94Vf
	NqGAqCAnwp7uKjsDj3AVCCYefFWMPaVuJnthb5qtCes/7WFG3X+7h5xwSn7RK+QMZS+aAa4IzZz
	RrctPpDaxS4hRF9Pjv1G9qJD0hrhy9q3Ey/1NLEJiI1AzjzuX
X-Google-Smtp-Source: AGHT+IE00J2zhKrMFAIQ9tWF9/wq6znQzjO6mWhp+k6HEoTeyFAK8Bt9BVV2ly5zyAI3/BeUBiSvs/jJzJr+pm3H9bE=
X-Received: by 2002:a05:6902:2486:b0:e08:8aba:644a with SMTP id
 3f1490d57ef6-e088aba655emr8727052276.19.1721730803694; Tue, 23 Jul 2024
 03:33:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722-miix630-support-v1-0-a6483cfe8674@linaro.org>
 <20240722-miix630-support-v1-1-a6483cfe8674@linaro.org> <cac3d7ba-2a62-479d-94c2-c6dc4d7a5ba2@linaro.org>
 <CAA8EJprROf-aJgJvUMb3D+dCzOUO-eRzM3khM6ZY8b+z+_gByA@mail.gmail.com> <2448216d-344d-4ffa-826f-d077ab9b1958@linaro.org>
In-Reply-To: <2448216d-344d-4ffa-826f-d077ab9b1958@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 23 Jul 2024 13:33:12 +0300
Message-ID: <CAA8EJppu3eaWrgz89Qkx3ZXrQoWVgL1ODoX224g7FYh1pX=Ydw@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: qcom: msm8998-lenovo-miix-630: enable touchscreen
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeffrey Hugo <quic_jhugo@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 13:01, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 23.07.2024 3:09 AM, Dmitry Baryshkov wrote:
> > On Tue, 23 Jul 2024 at 02:22, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>
> >> On 22.07.2024 1:57 PM, Dmitry Baryshkov wrote:
> >>> There is no point in keeping touchscreen disabled, enable corresponding
> >>> i2c-hid device.
> >>>
> >>> 04F3:2608 Touchscreen as /devices/platform/soc@0/c179000.i2c/i2c-0/0-0010/0018:04F3:2608.0001/input/input1
> >>> 04F3:2608 as /devices/platform/soc@0/c179000.i2c/i2c-0/0-0010/0018:04F3:2608.0001/input/input2
> >>> 04F3:2608 as /devices/platform/soc@0/c179000.i2c/i2c-0/0-0010/0018:04F3:2608.0001/input/input3
> >>> 04F3:2608 Stylus as /devices/platform/soc@0/c179000.i2c/i2c-0/0-0010/0018:04F3:2608.0001/input/input4
> >>>
> >>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>> ---
> >>>  .../boot/dts/qcom/msm8998-lenovo-miix-630.dts      | 28 ++++++++++++++++++++++
> >>>  1 file changed, 28 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
> >>> index a105143bee4a..118c55f5bcfd 100644
> >>> --- a/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
> >>> +++ b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
> >>> @@ -11,6 +11,24 @@ / {
> >>>       chassis-type = "convertible";
> >>>  };
> >>>
> >>> +&blsp1_i2c5 {
> >>> +     clock-frequency = <400000>;
> >>> +     status = "okay";
> >>> +
> >>> +     tsc1: hid@10 {
> >> weird (and unused label)
> >>
> >> very non-specific node name too
> >>
> >>> +             compatible = "hid-over-i2c";
> >>> +             reg = <0x10>;
> >>> +             hid-descr-addr = <0x1>;
> >>> +
> >>> +             interrupts-extended = <&tlmm 125 IRQ_TYPE_LEVEL_LOW>;
> >>> +
> >>> +             pinctrl-0 = <&i2c5_hid_active>;
> >>> +             pinctrl-names = "default";
> >>> +
> >>> +             wakeup-source;
> >>
> >> double tap to wake? tap to wake?
> >>
> >>> +     };
> >>> +};
> >>> +
> >>>  &blsp1_i2c6 {
> >>>       status = "okay";
> >>>
> >>> @@ -35,3 +53,13 @@ &remoteproc_mss {
> >>>  &sdhc2 {
> >>>       cd-gpios = <&tlmm 95 GPIO_ACTIVE_HIGH>;
> >>>  };
> >>> +
> >>> +&tlmm {
> >>> +     i2c5_hid_active: i2c5-hid-active-state {
> >>> +             pins = "gpio125";
> >>> +             function = "gpio";
> >>> +
> >>> +             bias-pull-up;
> >>> +             drive-strength = <2>;
> >>
> >> Since there are no other pin definitions, you can do better and not
> >> copy the old rotten style ;)
> >
> > Both node and pinctrl were c&p from c630. But was is rotten here?
>
> yes, we stopped putting a random newline in there quite some years ago

Ack

-- 
With best wishes
Dmitry


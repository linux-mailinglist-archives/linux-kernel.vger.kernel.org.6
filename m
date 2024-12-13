Return-Path: <linux-kernel+bounces-444396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A53159F0620
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182D01889FF3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681A419F40E;
	Fri, 13 Dec 2024 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g+8BpnAH"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC96192D70
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734077581; cv=none; b=c5H5vlCgXf6SPXsTP6ZhtixlfuoAhg1NDrLvdyN/9DOHOwvA3P6SfOlNWoXaaRoAnpo142llkQhxFEDwo0Abi0tRTnLM+7SEUR+IPtL3WJIB/nizxzQngpwG4h+glH+lJnq89mjd1Ps+v1n8+9x7G7FR9boPkc1XZhS4aB+vmBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734077581; c=relaxed/simple;
	bh=tWk511liBgM+yz6vuBZVI8/a4feX1Rabookt5WONy50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VeQgfw8tsvKadMx6rRVL6q6S+1iQUz1z6JYEa9whV6EKj3fksbH0AYm8pKQnO7ANwkWM5LePUxAtygGx1TbTPOEcXALgJn3dmt51dfmrbi4BEAfxX5UVzzr+zzq7CkVE1jLK/9xQQ0RedE/GRHdcDOU5UzgaeCNd6CVC0G+rKBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g+8BpnAH; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6eff4f0d627so14087527b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734077579; x=1734682379; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+P1B0OXe79edCU/e2uscFDI6rCzd7tyRFS9q5De2k1I=;
        b=g+8BpnAHiPQYv39Y+GYIUzwpQfe9NIa8lipfD1NYidJhTXy9YIip28fki8Ukr/jvKs
         0ywPaNc10ScGAfbsqwg12DosMCJilQhGS67ymZxZGDJt+PxO/aW/aIhsH50uvq8Jcnjz
         /dCBasquMVPSNeCKixB5jc+pxWadm1Yixiw+8zWk17p3GvAVGdzO7AwwGYkfFUU27kSQ
         AKEIDKa68IW6EPU+kP5V1SlPlKE9hjCld5dd8iff3KyDtQy9uiBNCNX4hpXIkjxk5kms
         pV+cdp3DK0N8NMqjmgUN3beDdOhVL8akNzhmiqbF6Kr199qsL7Ke9dDdLrXo+agnv9Ed
         EvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734077579; x=1734682379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+P1B0OXe79edCU/e2uscFDI6rCzd7tyRFS9q5De2k1I=;
        b=rNF0slmHeXf3Khr5cAMyWOGcKz1vobE8EUHyR416FyM7cfucxI00JCdJKKVuMFXswp
         Oo7sR0siDszcmyGN+8eu7AHWcLHuN0S+Du2IwrDa/e07s1VbbGRPlq0wOXnlHPlClOdV
         eFW5XEZkvICtBdbr6qVECPPqFWmmGGN9c2L0zcLg5ZPqpWDupGgHi7Hn+mJ21eVWCj7g
         QzvjQrHwwtIt6AsTsnd15dydObZZahjcs67HAlfsPNkHFn4mh0fdzKLdMG17ZDwmTXJJ
         rY5gRX3q4+JtiD4MbL/l7yq3x413auUwRvXv5dvjEhaaXc19DryvFDnW2Kg+4PeohSAx
         TPEw==
X-Forwarded-Encrypted: i=1; AJvYcCUr2RnafJSkwZYFnB69HC1sH3KKNxc8ARd3s/KhJ4uOaW8bYfg/i7xR6czKedP80unkDYsDTEkOw7fDepw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg73li29TQvddUKAeJyySUoXkjWCYEBfrvCRVt/qInDbCohomi
	J0R0KmnaBwnfghyPMbKeArKa3i6yERQUunDuN4Pa4HtJSV8NWYpc8nwZAO+O+3EpN1cLRBpjven
	pyNacTTCb+auw/J5jw8pgY+5r9as/Jtyk6SjaED19+yNXLVeepNPSrw==
X-Gm-Gg: ASbGnct6d5kiciIKaQ9qAmKyHMNGkMDRMo09Y2aobvyLGwBwxb0blWlT2Om7zIoe3tS
	QaqYivwMcBCwXxpoHop0XsVtc0xipXLYD95bKhQ==
X-Google-Smtp-Source: AGHT+IES0H+DSBOHc15NUCPFG86F/fOtSz6wxW2AEs4u1OdoW7DwhJxfJZdRAdql8IXRFMVRwXr53zU/RlyWGDEVsak=
X-Received: by 2002:a05:690c:a8e:b0:6ef:c688:1b61 with SMTP id
 00721157ae682-6f279ad0d06mr18194147b3.6.1734077579155; Fri, 13 Dec 2024
 00:12:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211-add_usb_host_mode_for_qcs615-v2-0-2c4abdf67635@quicinc.com>
 <20241211-add_usb_host_mode_for_qcs615-v2-2-2c4abdf67635@quicinc.com>
 <cc3edfc6-f53c-401b-b766-f8e560eb24b9@oss.qualcomm.com> <4476bfe9-41fb-4ec3-b352-624fba75cf3f@quicinc.com>
In-Reply-To: <4476bfe9-41fb-4ec3-b352-624fba75cf3f@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 13 Dec 2024 10:12:48 +0200
Message-ID: <CAA8EJprMTtJnpeG0itjm157pzspJ50BVCv5SpYfqzkUYyKHZ+w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: Enable secondary USB controller
 on QCS615 Ride
To: Song Xue <quic_songxue@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@quicinc.com, 
	Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Dec 2024 at 08:59, Song Xue <quic_songxue@quicinc.com> wrote:
>
>
>
> On 12/13/2024 2:14 AM, Konrad Dybcio wrote:
> > On 11.12.2024 9:26 AM, Song Xue wrote:
> >> From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> >>
> >> Enable secondary USB controller on QCS615 Ride platform. The secondary
> >> USB controller is made "host", as it is a Type-A port.
> >>
> >> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> >> Co-developed-by: Song Xue <quic_songxue@quicinc.com>
> >> Signed-off-by: Song Xue <quic_songxue@quicinc.com>
> >> ---
> >>   arch/arm64/boot/dts/qcom/qcs615-ride.dts | 28 ++++++++++++++++++++++++++++
> >>   1 file changed, 28 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> >> index f41319ff47b983d771da52775fa78b4385c4e532..26ce0496d13ccbfea392c6d50d9edcab85fbc653 100644
> >> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> >> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> >> @@ -203,6 +203,15 @@ &gcc {
> >>               <&sleep_clk>;
> >>   };
> >>
> >> +&pm8150_gpios {
> >> +    usb2_en_state: usb2-en-state {
> >> +            pins = "gpio10";
> >> +            function = "normal";
> >> +            output-high;
> >> +            power-source = <0>;
> >> +    };
> >
> > Does this go to an enable pin of a vreg / switch?
>
> Thanks for comment.
> We go to enable the pin of PMIC chip. The pin of PMIC is connecting to
> host-enable pin of USB converter. Need pin of PMIC chip to be high
> level, when USB is as host mode.

What kind of USB converter are we talking about?

> >
> > I think we settled on describing such cases as fixed regulators
> > (that are always-on for now) - would you remember, +Dmitry?
> >
> > The rest looks good.
> >
> > Konrad
>


-- 
With best wishes
Dmitry


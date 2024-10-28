Return-Path: <linux-kernel+bounces-384561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FC09B2BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7791F229C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74FF1CB9E0;
	Mon, 28 Oct 2024 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QHglcP8V"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E085193060
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108517; cv=none; b=ApyhejUkwXRyzyr46fPLAZfwRuhfsiCovjfHMlkSqc1cR5oAhq5MbC9RjCEmkad2XJ177w0arLiHnYaMX7QPbBRHkvr2BsuQS64fDRgCcQx5Qas+SZSQcB1wEuI0BlictOxmEycfPZSyzgCInvN7a7UeDnzG4KMk/nAK1v5RBjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108517; c=relaxed/simple;
	bh=Xv9M5xfOc1wxGZrwaqn1SfRj4pgqlBBcSc1XElq37/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3Eaf11KJcmLr0CYofmtpLl9+9+X13Dr+VDQVttwWuyHGyTWwQGyFb9TCeHQUuzGkeTH/8cYzx0uylz0f55pgj0WNIGy/zQc9ngrN8pAr1P/Wl4I12Fb0vVNqvxQwizcW/ea0S6KZ3BwlhO4V39VFhWGf0X+qNdAS0FgQA4sKtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QHglcP8V; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e5ef7527deso42026357b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 02:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730108514; x=1730713314; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oiX/iT3MGW/8gbZHj00AjboGGe8ICnr6A2PFnCy1ZuU=;
        b=QHglcP8Ves/5ssZORq/LhM2Iw/l47GOe4idmUx8D9K6RvdQcRUVcWoQmuZGHVZ1J5A
         Bop8yZLMV6cmyuaMlnamQ7tNL05i23saEIbK4mYw1AVX78/N3DR0foLW7QvGwltRFLDc
         w5HH52L+t0AFoeSXARNwP3wjxpzu23xL4hF+OP6+mQNPKbJM8rMVCTMFttWEjHe+5mni
         /F/ST3uCNJX+YSzIv45W4v+U+hcVDe7ObDJBVwvAd5tpZAQRpT9B/Auh6V9eKA5gSdjr
         8fU9b9g23rgbibJjZ6wLqGTta2d2nOViTX0FojO2+BSi2baqdtCtu0o0pYqOsPXumRGR
         x4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730108514; x=1730713314;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oiX/iT3MGW/8gbZHj00AjboGGe8ICnr6A2PFnCy1ZuU=;
        b=BvyUtNzYMWhTKOFZBEEsZiZczOXyYrRd1CQ/rvFzn+ATqN9xDAIWwGaKo/viQOgJ+g
         sCxwtRfKBIAdi5mmisBl+7TOWK2mX3KatAW4P+EnMVfGdfOrUPdhub2DcZ/JSTrD+tDa
         GMsXNft6AXLus6Q1Fjy/+Iy2O3Tn35nwuHCwG0NUa2JIk2jQ3nmyLYVFQmFMtxubk6Uq
         y3CtIqUxdZOqcWmlSw48ujwcAl6L5aRneNEXeslmu2tssqwyB8a59L8ecBR33G58dMYi
         fbcZ+rKZ42dKuE9KDn7ssRef3YGEPkH02cKTuCz8fcdtsCvmD5rYU2NhzysYMbz56B+i
         r+Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXTSKURhBzbNGB2OWUwlgxdeEKR1HC38P7aHiN7lpru+EBHUPLfuAoyup7AwM9Vqpw3T36Q6pZsUEZX/bk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw61vlKpY57wCgCivGwhA6rygOrYfqH/qpXvyvY5azAHiObzQAn
	4yBGK9NdrQ/p+okcAhVQ4wWM9UO9sGwrwuobfHzTqm7XJdKAVx6DiDJoYPhnvw4cMO52Lc31EPN
	bx969pX9vDjA0KR1fTurQpszcnBh0Hc7DLI0CehsheUonNTpC
X-Google-Smtp-Source: AGHT+IHrOCxCyJ8ThUv82DKoxK74MLXsAExLltokn+0bupLwZqHCYVLbaaRKX5qboWle+dvaUBIdAPCllC73pA7SJH8=
X-Received: by 2002:a05:690c:6c04:b0:6e8:497:49d7 with SMTP id
 00721157ae682-6e9d88e765dmr69472497b3.2.1730108514314; Mon, 28 Oct 2024
 02:41:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028-adds-spmi-pmic-peripherals-for-qcs615-v3-0-f0778572ee41@quicinc.com>
 <20241028-adds-spmi-pmic-peripherals-for-qcs615-v3-2-f0778572ee41@quicinc.com>
 <j4ggfrynyoriseef5r5x6uwgo6cespll2np7uitc64yagoa6pz@r3ro2cpqrrry> <38cceae8-5203-4057-bd8b-f20fe3656474@quicinc.com>
In-Reply-To: <38cceae8-5203-4057-bd8b-f20fe3656474@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 28 Oct 2024 11:41:43 +0200
Message-ID: <CAA8EJprYHjYVM58e7i7Sxj64DSth4hhW_cUZ3hGqX7u0ecZFQg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: qcs615-ride: Enable PMIC peripherals
To: Tingguo Cheng <quic_tingguoc@quicinc.com>
Cc: quic_fenglinw@quicinc.com, quic_tingweiz@quicinc.com, kernel@quicinc.com, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Oct 2024 at 10:40, Tingguo Cheng <quic_tingguoc@quicinc.com> wrote:
>
>
>
> On 10/28/2024 4:23 PM, Dmitry Baryshkov wrote:
> > On Mon, Oct 28, 2024 at 04:03:25PM +0800, Tingguo Cheng wrote:
> >> Enable PMIC and PMIC peripherals for qcs615-ride board.
> >>
> >> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
> >> ---
> >>   arch/arm64/boot/dts/qcom/qcs615-ride.dts | 15 +++++++++++++++
> >>   1 file changed, 15 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> >> index ee6cab3924a6d71f29934a8debba3a832882abdd..37358f080827bbe4484c14c5f159e813810c2119 100644
> >> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> >> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> >> @@ -6,6 +6,7 @@
> >>
> >>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> >>   #include "qcs615.dtsi"
> >> +#include "pm8150.dtsi"
> >>   / {
> >>      model = "Qualcomm Technologies, Inc. QCS615 Ride";
> >>      compatible = "qcom,qcs615-ride", "qcom,qcs615";
> >> @@ -210,6 +211,20 @@ &rpmhcc {
> >>      clocks = <&xo_board_clk>;
> >>   };
> >>
> >> +&pon {
> >> +    /delete-property/ mode-bootloader;
> >> +    /delete-property/ mode-recovery;
> >
> > Why?
> Because boot modes will be supported on PSCI module from another patch,
> reboot-modes are required to remove from PMIC side.

=> commit message, please.

> >
> >> +};
> >> +
> >> +&pon_pwrkey {
> >> +    status = "okay";
> >> +};
> >> +
> >> +&pon_resin {
> >> +    linux,code = <KEY_VOLUMEDOWN>;
> >> +    status = "okay";
> >> +};
> >> +
> >>   &uart0 {
> >>      status = "okay";
> >>   };
> >>
> >> --
> >> 2.34.1
> >>
> >
>
> --
> Thank you & BRs
> Tingguo
>


-- 
With best wishes
Dmitry


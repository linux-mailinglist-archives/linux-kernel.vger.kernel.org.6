Return-Path: <linux-kernel+bounces-259519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE739397C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 03:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA57C1F2223A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 01:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCA13EA83;
	Tue, 23 Jul 2024 01:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pfCcvHWK"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDDE12C486
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721697006; cv=none; b=GZWHhWwJm78HwW7OLzInF0261M71xsebBqIeCk8QeiJ8z0LyksFPiJNRYPI3P9wgM7Vcu0KFNUPOP5ngs9uhDbaMsX7fW0tO/pteA8PcnAgwDbWUUBq3GGceOXMpWHXPTjBbwuloo66nYYBANR94YwraPESw/eqL0XGRNF7b2TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721697006; c=relaxed/simple;
	bh=F/YVPIt96eiD4fDEqIVV0BjgbhD3AMknFfl6Pf7/Seo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RUGWB/f45acYl6tgkIpkcc3hxlIBSkFB/au5zqO2RM58LeLDfIVG+G+hdycQNlzkI6doZiFoeoivVbf67ZPE1UzKQ//CbeuxadKt1bmVfjgMH6dsSCw+dcUCqmTSi25fke6WQalRA/btWEQ0E9fMik+x8a0R/CZIDTohZRLpxD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pfCcvHWK; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e087264e297so2568650276.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 18:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721697003; x=1722301803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M+1mttumgraTmz8as/o8R81jMF1pkFas9HuIkAF6YD8=;
        b=pfCcvHWKnncLvDK77wOZxrlYBUxm4zUEWiym7FZUc4hLGCfIZusQgzm/EuvrqrMZmf
         fxUZFGn4ZgNKNkFbtjdAH5SirzedHAI5SSq7eKRFI8SiRWAhnS2yJ8D0upOPR/DziyON
         UDBc5Ukzlx2LRSZCTkSx6q2yHOIKmnbppzjbKENRtNGpWnux86axCDc0qcJg+oE7PEVi
         hTJ77yFXvsWtjR8cCjWPhI21hPLziqVEJX7QS4k0O6qzgXf5hvv3X40ppnjxouPU+Z9V
         26XldUzrLd/U4PsNqkiOgagsBTrnJs7r0bF/GHcrRUxgdlSpsiGlIQqffVLTAtV2YG8/
         5+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721697003; x=1722301803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+1mttumgraTmz8as/o8R81jMF1pkFas9HuIkAF6YD8=;
        b=GrKUUTcqIWM6Z/zT/b14C6xVnR5c4gvycdvAOzFFjkc0rj/xy5riBu033tMljYI+Mj
         cFQnFlhexkizbleDQFIPsQgXivEvbYQlenR8dpazvyIj46OHZ4oo3lf+rUpSnTvPjt+G
         8bpYfmyhe1gB0/691XX8gKBuOk1EGoNpkJEsxEeRsmH2dicpcwJ3DNtMzsAe+2DqcK2f
         PJj9TI4VCGtaT5ZSv0FCDiTaBmLj8VOjwq1MP5PHQ1pt+lutHE9Z54NPyePFBDlbzYvU
         k8L6pyDkJcwt8xE4SlH14AhTOdiZKq42JNtzdVvYHJRIvHf2qzVTt0TYLkuWKJIM2lk4
         vs+g==
X-Forwarded-Encrypted: i=1; AJvYcCUjgJiW8AF/sAvVa2HUiHvKOAGPJp3iG7SyVpRZCP2C3Z+GGOjalg8ro/MUfjWwST378cLXfq8rf/yym5olIIyR9m1h2Ef8Gfafgkdy
X-Gm-Message-State: AOJu0Yw+q/9xHcHgRv/BPZ8FLTvGwzQmp8iSHqzEs3T2nl8vXSr6HAEz
	dNLV8Eumb8J6IvIcYwXQhnhkHV9CVZ3XMMsPvDq4a02vN7JusMa3PFrDqBArxKtSw6UWGb6Qoak
	BSK8qk6fpAeVzGm8fBXnj53JRj40xaHx8BLsmwA==
X-Google-Smtp-Source: AGHT+IFWh7F9HmWfROqNp44wr2VtiezP9UnvrKwkDXP8VHIqTEKzjfkOOrND9UfYVARn0ktR6qDNF/AN9J+nSHMSp2M=
X-Received: by 2002:a05:690c:4087:b0:651:a00f:698a with SMTP id
 00721157ae682-66a65e6516amr86737777b3.38.1721697003132; Mon, 22 Jul 2024
 18:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722-miix630-support-v1-0-a6483cfe8674@linaro.org>
 <20240722-miix630-support-v1-1-a6483cfe8674@linaro.org> <cac3d7ba-2a62-479d-94c2-c6dc4d7a5ba2@linaro.org>
In-Reply-To: <cac3d7ba-2a62-479d-94c2-c6dc4d7a5ba2@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 23 Jul 2024 04:09:52 +0300
Message-ID: <CAA8EJprROf-aJgJvUMb3D+dCzOUO-eRzM3khM6ZY8b+z+_gByA@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: qcom: msm8998-lenovo-miix-630: enable touchscreen
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeffrey Hugo <quic_jhugo@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 02:22, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 22.07.2024 1:57 PM, Dmitry Baryshkov wrote:
> > There is no point in keeping touchscreen disabled, enable corresponding
> > i2c-hid device.
> >
> > 04F3:2608 Touchscreen as /devices/platform/soc@0/c179000.i2c/i2c-0/0-0010/0018:04F3:2608.0001/input/input1
> > 04F3:2608 as /devices/platform/soc@0/c179000.i2c/i2c-0/0-0010/0018:04F3:2608.0001/input/input2
> > 04F3:2608 as /devices/platform/soc@0/c179000.i2c/i2c-0/0-0010/0018:04F3:2608.0001/input/input3
> > 04F3:2608 Stylus as /devices/platform/soc@0/c179000.i2c/i2c-0/0-0010/0018:04F3:2608.0001/input/input4
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  .../boot/dts/qcom/msm8998-lenovo-miix-630.dts      | 28 ++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
> > index a105143bee4a..118c55f5bcfd 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
> > +++ b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
> > @@ -11,6 +11,24 @@ / {
> >       chassis-type = "convertible";
> >  };
> >
> > +&blsp1_i2c5 {
> > +     clock-frequency = <400000>;
> > +     status = "okay";
> > +
> > +     tsc1: hid@10 {
> weird (and unused label)
>
> very non-specific node name too
>
> > +             compatible = "hid-over-i2c";
> > +             reg = <0x10>;
> > +             hid-descr-addr = <0x1>;
> > +
> > +             interrupts-extended = <&tlmm 125 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +             pinctrl-0 = <&i2c5_hid_active>;
> > +             pinctrl-names = "default";
> > +
> > +             wakeup-source;
>
> double tap to wake? tap to wake?
>
> > +     };
> > +};
> > +
> >  &blsp1_i2c6 {
> >       status = "okay";
> >
> > @@ -35,3 +53,13 @@ &remoteproc_mss {
> >  &sdhc2 {
> >       cd-gpios = <&tlmm 95 GPIO_ACTIVE_HIGH>;
> >  };
> > +
> > +&tlmm {
> > +     i2c5_hid_active: i2c5-hid-active-state {
> > +             pins = "gpio125";
> > +             function = "gpio";
> > +
> > +             bias-pull-up;
> > +             drive-strength = <2>;
>
> Since there are no other pin definitions, you can do better and not
> copy the old rotten style ;)

Both node and pinctrl were c&p from c630. But was is rotten here?


-- 
With best wishes
Dmitry


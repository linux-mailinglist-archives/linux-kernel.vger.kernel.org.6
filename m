Return-Path: <linux-kernel+bounces-569909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C37CA6A944
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2794348058F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60272628C;
	Thu, 20 Mar 2025 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZon6yTm"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE931B4F0F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482794; cv=none; b=kCAVhcWwee0sdCQtqKpnYP0QY0F5K72mavKDv8GbruCdXN2nwGNlcztX1Gbcd0bifdjxcDmdq1wBWHWPR3RUuefEF92tTEoUhIc1juywkxpSx3yyj+pbsW1dfU2o9azVnhbBDY7ITDXDslIIKiTkr6g1XDEFEudc0XczeIBO0lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482794; c=relaxed/simple;
	bh=GF0VK7dHmJO63fo0/Pot316tCpl4vo7OCRgrDVzVx/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkIFTELNiMpIfSVVPPVPqFfxhBojk8Ce7vzuNzneiB40F5wBoJfX3IbIqsXtv26JaAnwb/uYkzzTLo6wEggB9AuOVngEEvhdcHty8pMqNOEqYm+jlNPR2i+3VZ6JshVQ8Pto5YjGYoh0NkrPiWPkiO0IL20papbulgNqvDuFAq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YZon6yTm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so8393885e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742482791; x=1743087591; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1dCpo5qNPPogUTHw1o2z5IsnXomo/xWgvWYpE6X6Nss=;
        b=YZon6yTmN7L/3X2tFcN58C2zcFmmib2yIYDaIrxfKIPDY3oIFzV9ws8u80hyCWK3zq
         aj0jLrF98TDtkEkYRpbq0Y0mwFjiRFcCfQV1YNQo7l3o99RoV1c4YF66Oqrjo/t9fV/k
         646tFOO88yqRSfi/smXqDdrjmyEi6z0/W79C+95P+swuSi+m8U5MRbaqjNNBFn/5edNb
         FpOlGah6LLkEMQ2ABK5YIm0yqxekl1rH8ZXEZQfMYTZ1JrkWH/jbQwHkLqmFPEhddcAD
         yiPR7gEdP8zU7YhRcod3qcer5alYOhWtTaD5q2K7sHzqOg7hN9zTyWDVTOwWk7sfMNMb
         9VIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742482791; x=1743087591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dCpo5qNPPogUTHw1o2z5IsnXomo/xWgvWYpE6X6Nss=;
        b=YTrZuA3oAE3UpQw6efr9haKsiVYqQG+SBPwA5JIqj6ysMy6dqRkvhRtJiXBSVkHQJJ
         j8ZCtGCgmNoGGeWW5rl74NWQ5Ukd4uwLaOf3/y9rt7JhCZ26xaDzsxgbXSTM0IBz1k/y
         pehTsrHDNucLlpa1pr2Xq/VKb1LLPPBWG0CEVnaWNx+Dr2owpT5hplKzmUJty0SpwROh
         hxGeee33JnOz0iV0cbuK8XPa00NfZY7ke4Tx+mdPRoqUF7n2yA99PaoX8Lh239cUgCl7
         CsS0djSF3ZKwFcnZgBatAmAyY2RuA2tMqvl7oyCpUXR7MWsjiC5+DHKiez4gjpwPqUMi
         EX1w==
X-Forwarded-Encrypted: i=1; AJvYcCVc8v8jenWk7wWaXzBZSO/IMMB4SsES0usRTebUH9tHOWf1p//2eXbeWAQStiJ45TXwIH8+83WkWTP+t1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC+hpsMs+jxlPqEx1xBPqhnUmIlTRK+jmDgEhPmreKY4sTikSC
	+5mUepTjnJfJwrE2DKrhdFyiebRs2gA30CTMbiKi/o+L7bEi+eckrWppFbgom1+LzHg3GRsovwU
	t7jREMgRTrqwVwrZ0lHFEqnETj5c266MIVC5XTA==
X-Gm-Gg: ASbGnctsVE+ktV7Seds4RcBswFa7/CMcT7eSgWof5EWJ27nVvkNGDlhDx+XbFUoFM9i
	LqpFm4ateyENIMVf13fHkFAn2xDn+5kw7O8HMYfByUtIFzen/6ikiHJAxXupVVuacPqPJoh3Sp6
	Omdmai1s51HzRFbnoboRcL4IybtDEtHe7h1s/YEbQ3fCJd4Rq9/6eY9yqotPM=
X-Google-Smtp-Source: AGHT+IEuovMa5wU5MZaFsiegZRX9kpE8KrzlwzUFosPnm3xJM5d92iy014o6qQlzbCC26zceDb2qYp50jMoAELnW4f4=
X-Received: by 2002:a05:6000:400a:b0:391:3207:2e75 with SMTP id
 ffacd0b85a97d-399739bc965mr8027422f8f.18.1742482790540; Thu, 20 Mar 2025
 07:59:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320115633.4248-1-srinivas.kandagatla@linaro.org> <20250320115633.4248-6-srinivas.kandagatla@linaro.org>
In-Reply-To: <20250320115633.4248-6-srinivas.kandagatla@linaro.org>
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Thu, 20 Mar 2025 14:59:40 +0000
X-Gm-Features: AQ5f1JqWow6fqmzjop6LRMzUEYKQ_-u1q6WapafopX3_R9ft_ibeNfvcRLu1M1E
Message-ID: <CACr-zFAvcvBsTE2Y8W2i-o59x-PiUGJYsyb_OtBWJ9VvgipYNQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: x1e78100-t14s: Enable audio
 headset support
To: srinivas.kandagatla@linaro.org
Cc: peda@axentia.se, broonie@kernel.org, andersson@kernel.org, 
	krzk+dt@kernel.org, ivprusov@salutedevices.com, luca.ceresoli@bootlin.com, 
	zhoubinbin@loongson.cn, paulha@opensource.cirrus.com, lgirdwood@gmail.com, 
	robh@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org, perex@perex.cz, 
	tiwai@suse.com, dmitry.baryshkov@oss.qualcomm.com, 
	linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	johan+linaro@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Srini,

On Thu, 20 Mar 2025 at 12:02, <srinivas.kandagatla@linaro.org> wrote:
>
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> On Lenovo ThinkPad T14s, the headset is connected via a HiFi mux to
> support CTIA and OMTP headsets. This switch is used to minimise pop and
> click during headset type switching.
>
> Enable the mux controls required to power this switch along with wiring up
> gpio that control the headset switching.
>
> Without this, headset audio will be very noisy and might see headset
> detection errors.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

I tested this series (with
https://github.com/alsa-project/alsa-ucm-conf/pull/522 and latest
audioreach firmware X1E80100-LENOVO-Thinkpad-T14s-tplg.bin) on top of
Johan's kernel (https://github.com/jhovold/linux/tree/wip/x1e80100-6.14-rc7/)
on OLED T14s with Gnome and PipeWire/WirePlumber from Debian unstable
and everything appears to work OK.

The following works:
- internal speakers (no regression)
- internal mic (no regression)
- 3-pin headset, the default output auto-switches when plugged/unplugged
- 4-pin headset with mic, the default output/input auto-switches when
plugged/unplugged

Please let me know if I can test anything else.

Tested-by: Christopher Obbard <christopher.obbard@linaro.org>

> ---
>  .../qcom/x1e78100-lenovo-thinkpad-t14s.dts    | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
> index b2c2347f54fa..b40775c20493 100644
> --- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
> @@ -19,6 +19,16 @@ / {
>         compatible = "lenovo,thinkpad-t14s", "qcom,x1e78100", "qcom,x1e80100";
>         chassis-type = "laptop";
>
> +       /* two muxes together support CTIA and OMTP switching */
> +       us_euro_mux_ctrl: mux-controller {
> +               compatible = "gpio-mux";
> +               pinctrl-0 = <&us_euro_hs_sel>;
> +               pinctrl-names = "default";
> +               mux-supply = <&vreg_l16b_2p5>;
> +               #mux-control-cells = <0>;
> +               mux-gpios = <&tlmm 68 GPIO_ACTIVE_HIGH>;
> +       };
> +
>         wcd938x: audio-codec {
>                 compatible = "qcom,wcd9385-codec";
>
> @@ -36,6 +46,7 @@ wcd938x: audio-codec {
>                 qcom,tx-device = <&wcd_tx>;
>
>                 reset-gpios = <&tlmm 191 GPIO_ACTIVE_LOW>;
> +               mux-controls = <&us_euro_mux_ctrl>;
>
>                 vdd-buck-supply = <&vreg_l15b_1p8>;
>                 vdd-rxtx-supply = <&vreg_l15b_1p8>;
> @@ -367,6 +378,13 @@ vreg_l15b_1p8: ldo15 {
>                         regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>                 };
>
> +               vreg_l16b_2p5: ldo16 {
> +                       regulator-name = "vreg_l16b_2p5";
> +                       regulator-min-microvolt = <2504000>;
> +                       regulator-max-microvolt = <2504000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
>                 vreg_l17b_2p5: ldo17 {
>                         regulator-name = "vreg_l17b_2p5";
>                         regulator-min-microvolt = <2504000>;
> @@ -942,6 +960,13 @@ int-n-pins {
>                 };
>         };
>
> +       us_euro_hs_sel: us-euro-hs-sel-state {
> +               pins = "gpio68";
> +               function = "gpio";
> +               bias-pull-down;
> +               drive-strength = <2>;
> +       };
> +
>         kybd_default: kybd-default-state {
>                 pins = "gpio67";
>                 function = "gpio";
> --
> 2.39.5
>
>


Return-Path: <linux-kernel+bounces-442041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DD49ED74A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203BF1683DC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D376A20E010;
	Wed, 11 Dec 2024 20:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ypZ384k9"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1401FECCA
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733949327; cv=none; b=Y4dQQBQnpjRW1GRgaiK4O8eU9XsBBwzQ68x9je9MwE9IJLPh26S+IfmooGXPk4TyjqXKaUS3uVpojxAW/UcWsPKNU5kU8gA0DV8koMgyDE8pKoQVjxozWe2xbeyKqeuTeK+7JP9ghkzUmvfkpMoG6w95dNwYHOZEDr9He2K4QDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733949327; c=relaxed/simple;
	bh=Tj2T0jHpnxc9hzjyEB3IbVNpdJMAMoG6iZPl2j/XGQ0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gPYTnckp0p84a0jVs70zPDG+vjMn4wVXyLQqYudTuZtJdWjO14p5C0rx/745L7f8OhlL60GiRJbTsN38NAlZpSA66R7RuLTe+z5A51AdsoCwnDB7knFyRFO+GFS5Gj1t4lOvmAyrlTWaprkwYfXzfTqAu6M/HpDUCKVL9v93B1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ypZ384k9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43618283d48so13895235e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733949322; x=1734554122; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFRzH/Iv8Aaw4sWsAQhZm9VRnaxy7gZCZYmxkSDRSlw=;
        b=ypZ384k9YprNIGK66fxB1tBMaGFZiqNxEgZpDBoUf0l5QFURs04aCjOwHkxHPH5o5u
         WPctAyhqptAoNfevf9fmLHovXIv6eDKEmyb76mwZWH+lH1yESx5YboB6F8PPolSdP5zd
         8v+U/mNey4rMSfcgaZlOeWh/Y1sGF340JRN0bbrbt2mF0ogGtFc2BzwwbZCJUR7hecEe
         CKtLTyYQDppU8zDfszGj6RnQ60Hch3czjrHltn54ghNI8fpWvEst4HFkk/51v+ac1SvU
         YN4B2LE1Yp/Gh42oj0ygFr7p/ebpm6UoMqHVqhLe44CTTNK5XB5wIllBo0dqoUUUiqly
         aGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733949322; x=1734554122;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uFRzH/Iv8Aaw4sWsAQhZm9VRnaxy7gZCZYmxkSDRSlw=;
        b=HEtO0SfSJdAUxawTvnZ7RQin/WH9vEznfqXRHWeSvGPsDBQUxrNSTjsOhOkVhnlPP2
         qKRn4DwDCd+tg0CtBXYQkwmTMmBwJl8WlPFdL/FC7250GbQaiTyg8wznlBhD+DQXjOsp
         YNGdm89ZdGun9LPkz1jMuQO5+/nwri9ln+U2tyPJvwTf5Jf5TMuzdJaG9Xl274uVS9Mq
         w0sjtzgZkTXDA4KuuFirMdtH2XcNm/2Ib7uJU/dsdNR2zVpDlXxmT/CjVCJcq5QsSdV0
         o6IRz4Ivc2r/ON+ZLabxaH90FaRh2KlreZBPgwgM/2MkDgLUsLj3gAyX9dJhThAE5lCv
         faPg==
X-Forwarded-Encrypted: i=1; AJvYcCVujISX5Z4d706udLy4/uQ7gaH4W5hxwzmYvBzlq3uM5MK/4hkKmmuC/JA3jJAAbHZnsBcc82JL0+gubxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgLbfs2mMxdtJx/r1CCz4rFJwKLF8XEWM2ddWYA2nN7NsFRqna
	XBnAv4CF8UKiFIhwVXo7O0QucE14kZDTC6y2VCHywlNWn9yh/MsVqvxkjjjB/pE=
X-Gm-Gg: ASbGncu3X4mb03fOJ2tBdRJsGydtlmdq1RHML0Y2fCxCSQVFxd1n7dIN+mYEQv/n57y
	173v3AmI8xgrYD9GFLXQuzYP/+e/iL4AF9gwxPPIMZJoNB98/GOjFfb1WaWNzQbX9pUK8jbJ7b9
	TtqzyEffLCCgBIni+3VnCEYwIbq4bgNnIJMoN/DCGP+I5Ng9pD4mVpT2O2MrZfbT1wEBjSJyA83
	pFMhAenvHCREoQjGG2Oydhi5z1XOM2Y9M4PZn2B0xhzAvt7bI+iKGQ5
X-Google-Smtp-Source: AGHT+IEvGMvfNKL3Lr/V0TIh8L5co6EyNTn2QDgjDa1ZNU6WRGQ6MpM69ERpnAXmDRumCMLvlZCOWA==
X-Received: by 2002:a05:600c:3593:b0:431:55af:a230 with SMTP id 5b1f17b1804b1-4361c43ed3fmr33174845e9.33.1733949322346;
        Wed, 11 Dec 2024 12:35:22 -0800 (PST)
Received: from localhost ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361eccec81sm25126715e9.37.2024.12.11.12.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 12:35:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Dec 2024 20:35:21 +0000
Message-Id: <D695QHHBLGUF.7HOOI1E8RMTS@linaro.org>
Cc: <broonie@kernel.org>, <konradybcio@kernel.org>,
 <konrad.dybcio@oss.qualcomm.com>, <andersson@kernel.org>,
 <srinivas.kandagatla@linaro.org>, <tiwai@suse.com>, <lgirdwood@gmail.com>,
 <perex@perex.cz>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <dmitry.baryshkov@linaro.org>,
 <linux-sound@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 06/10] ASoC: dt-bindings: add wsa881x-i2c binding for
 analog mode
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
X-Mailer: aerc 0.18.2
References: <20241101053154.497550-1-alexey.klimov@linaro.org>
 <20241101053154.497550-7-alexey.klimov@linaro.org>
 <woeeh7cosv47z4ckqbomfc3rqqxfolyfycgcz32do2yadg7xdj@geqank3dp55t>
In-Reply-To: <woeeh7cosv47z4ckqbomfc3rqqxfolyfycgcz32do2yadg7xdj@geqank3dp55t>

On Fri Nov 1, 2024 at 7:57 AM GMT, Krzysztof Kozlowski wrote:
> On Fri, Nov 01, 2024 at 05:31:50AM +0000, Alexey Klimov wrote:
> > Add binding document for WSA881X family of smart speaker amplifiers
> > that set to work in analog mode only and configurable via i2c only.
> > Such devices are found in Qualcomm QRB4210 RB2 boards with
> > SM4250/SM6115 SoCs.
> >=20
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> > ---
> >  .../bindings/sound/qcom,wsa881x-i2c.yaml      | 103 ++++++++++++++++++
> >  1 file changed, 103 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881=
x-i2c.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa881x-i2c.y=
aml b/Documentation/devicetree/bindings/sound/qcom,wsa881x-i2c.yaml
> > new file mode 100644
> > index 000000000000..51b040b134d2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/qcom,wsa881x-i2c.yaml
>
> Filename must match compatible.
>
> > @@ -0,0 +1,103 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/qcom,wsa881x-i2c.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm WSA8810/WSA8815 Class-D Smart Speaker Amplifier in Ana=
log mode
> > +
> > +maintainers:
> > +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > +  - Alexey Klimov <alexey.klimov@linaro.org>
> > +
> > +description: |
> > +  WSA8810 is a class-D smart speaker amplifier and WSA8815
> > +  is a high-output power class-D smart speaker amplifier.
> > +  Their primary operating mode uses a SoundWire digital audio
> > +  interface however the amplifier also supports analog mode and it
> > +  can be controlled via I2C. This binding is for I2C interface.
> > +
> > +allOf:
> > +  - $ref: dai-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,qrb4210-wsa881x-i2c-codec
>
> qrb4210 is a name of a board, not codec. i2c is redundant, codec as
> well. 'x' is not allowed.

qcom,qrb4210-wsa881x-i2c-codec came from qcom-soc.yaml with the advice
that it should be qcom,SoC-IP.

Anyway I am working on updating the qcom,wsa881x.yaml as you pointed out
in another email.

> This is qcom,wsa8810 and qcom,wsa8815 compatible with it.
>

[..]

> > +
> > +      wsa881x@e {
>
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-device=
tree-basics.html#generic-names-recommendation

The best I can come up with is "amplifier", or it should be at least "codec=
'.

Thanks for the review!
Best regards,
Alexey


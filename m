Return-Path: <linux-kernel+bounces-261630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2995193BA1C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDEB1C2192C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41B86112;
	Thu, 25 Jul 2024 01:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M9VlNN0e"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDD24C74
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721870754; cv=none; b=sSRpMBnxY8K+8nmZFVROeym2Q8n+RFDLNUpR5RNHfnBBdv5qsf/QmiEw7zlwXIGJRwV0jtTyuFNG5GOTt1Un1OZDLwRxGgAl8HfT/WXbVwz39ev8A/a3HWcQfCHB7xvN2LNGR7KF/OWxnk3ILvqdI+RNSWpno69vEdPFbhwXCAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721870754; c=relaxed/simple;
	bh=XVNqcsmTCRyoFrb+4P5fA3cNXlrvLknmPxWx3PJtIO4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=fBM+CW8jIperAA0FKPydOSVJVZBlH8UM5qgedNydyINq+rmpP1pKA+OgfvLQ0OR9uHtbjy5564EXX+w+hf8YfUTIRsadqbFS3k8RCLwGiJK+F6OUgxQCBdH0LgSptnDSzxe4sVC+h2a9GVpVmoMd20xde9MhmZWN1WSBg64XJ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=M9VlNN0e; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240725012547epoutp03774c2e82a69e27819df04b0e0250ba99~lUFJqumI51354113541epoutp03M
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:25:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240725012547epoutp03774c2e82a69e27819df04b0e0250ba99~lUFJqumI51354113541epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721870747;
	bh=uRQaKTTWctTeaeXsIhmDe5HIcJLnXPQLSZGPy/JIKeg=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=M9VlNN0eyO+NfxgPlIJF0I6jAqxauHCRrSy7R/7A2SusAqu59zH8FZv1mg4Upsh+h
	 vYWaUcPWQzOvdV8cJCgiEcpoi86gyBsvYxF4/RHqpFUHi4pBYVbqefe3KuvK4z9Bsv
	 a5r+tnOy7955VAQ07Z6wynNg5J+MCw0/+X2oLqZw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20240725012546epcas2p398a2ba91f79ab5160baecc7e474794fb~lUFJK-Rdj2632726327epcas2p3m;
	Thu, 25 Jul 2024 01:25:46 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.99]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WTtVy29cZz4x9QJ; Thu, 25 Jul
	2024 01:25:46 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	D1.C8.10066.A99A1A66; Thu, 25 Jul 2024 10:25:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20240725012545epcas2p2465cf815c2f14ea518ac70784a1f8da0~lUFHvt2p42106021060epcas2p2b;
	Thu, 25 Jul 2024 01:25:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240725012545epsmtrp1d53fba58e344394957cf546cee4a4ff5~lUFHu2SX91325113251epsmtrp1Z;
	Thu, 25 Jul 2024 01:25:45 +0000 (GMT)
X-AuditID: b6c32a46-4b7fa70000002752-fa-66a1a99a631e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	78.A7.08964.999A1A66; Thu, 25 Jul 2024 10:25:45 +0900 (KST)
Received: from KORCO118965 (unknown [10.229.18.201]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240725012545epsmtip217a37a6600e623e1d83b5a17c7429e2d~lUFHa7N_V2714027140epsmtip2p;
	Thu, 25 Jul 2024 01:25:45 +0000 (GMT)
From: "sunyeal.hong" <sunyeal.hong@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, "'Sylwester Nawrocki'"
	<s.nawrocki@samsung.com>, "'Chanwoo Choi'" <cw00.choi@samsung.com>, "'Alim
 Akhtar'" <alim.akhtar@samsung.com>, "'Michael Turquette'"
	<mturquette@baylibre.com>, "'Stephen Boyd'" <sboyd@kernel.org>, "'Rob
 Herring'" <robh@kernel.org>, "'Conor Dooley'" <conor+dt@kernel.org>
Cc: <linux-samsung-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <18f5565f-11f5-49ce-a816-366cff25b703@kernel.org>
Subject: RE: [PATCH v4 1/4] dt-bindings: clock: add ExynosAuto v920 SoC CMU
 bindings
Date: Thu, 25 Jul 2024 10:25:44 +0900
Message-ID: <035601dade31$92374370$b6a5ca50$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKlY5hu3bVCnsOExtpi/jJA6pOgwAIfj46DASLmYXQBsRRpxrBJ/zFw
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmhe6slQvTDL5fZbZ4MG8bm8WaveeY
	LK5/ec5qMf/IOVaL8+c3sFtsenyN1eJjzz1Wi8u75rBZzDi/j8ni4ilXi/97drBbHH7Tzmrx
	79pGFgdej/c3Wtk9Nq3qZPPYvKTeo2/LKkaPz5vkAlijsm0yUhNTUosUUvOS81My89JtlbyD
	453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgE5UUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQX
	l9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRn/HueXvDfrGLp/Y/MDYw3NLsYOTkk
	BEwkDjzrYAexhQR2MEqs2c/XxcgFZH9ilLjy+iAThPONUWLTuyY2mI6m1ReYIRJ7GSVOv7vD
	DuG8ZJRYNHcFC0gVm4C+xOru22wgCRGBO0wSl6e/AatiFljHKLF55hGwjZwCdhIvlpwD6xAW
	CJPYOqODEcRmEVCVWPzyEpjNK2Ap8elZA5QtKHFy5hOwemYBeYntb+cwQ9ykIPHz6TLWLkYO
	oG1uEud26ECUiEjM7mwDO1VC4ASHxMtj99kh6l0knt1fCvWPsMSr41ug4lISL/vboOx8icnX
	3zJBNDcwSlz71w21zF5i0Zmf7CDLmAU0Jdbv0gcxJQSUJY7cgjqNT6Lj8F92iDCvREebEESj
	msSnK5ehhshIHDvxjHkCo9IsJI/NQvLYLCQfzELYtYCRZRWjWGpBcW56arFRgRE8spPzczcx
	glOvltsOxilvP+gdYmTiYDzEKMHBrCTC++TV3DQh3pTEyqrUovz4otKc1OJDjKbAoJ7ILCWa
	nA9M/nkl8YYmlgYmZmaG5kamBuZK4rz3WuemCAmkJ5akZqemFqQWwfQxcXBKNTC1eL8reWG/
	+1f0q5OG3itlz3iqLOz6/vMnb3hO8es5C/bYpHaulqxVifRgvb7GY6WmfNa7rMPM6g4lnkYr
	WE9svBegcHqbysRJBw7LTDz3++7SBcITd+itimP1SVBJkHG9Zrb+pfTeZ5qzHrOtU7mx8nGu
	xfwP8tcmJS/MUixe0r1lgWFfss3txXZFM7e8lUvauLdfmGfGJo+fLQZBxtsLDY69PNB47p2+
	l1dW3Y1IDpZdc6qEK2KCV80LSK5KWJxT6aowO3yx6MvF50qWmHz0Kd3T4i1h4f6tt/J+Q6Wp
	34oIjkOWxzPfrzhSduBhJ0uH47L61vh1i+oVLgsYHXjYumHp9tcfcqekFzxxajZSYinOSDTU
	Yi4qTgQAnAd/KEYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSvO7MlQvTDO4c4LR4MG8bm8WaveeY
	LK5/ec5qMf/IOVaL8+c3sFtsenyN1eJjzz1Wi8u75rBZzDi/j8ni4ilXi/97drBbHH7Tzmrx
	79pGFgdej/c3Wtk9Nq3qZPPYvKTeo2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDL+PU8v+G9W
	sfT+R+YGxhuaXYycHBICJhJNqy8wdzFycQgJ7GaU6D/bywiRkJHY2PCfHcIWlrjfcoQVoug5
	o0TP+dNMIAk2AX2J1d232UASIgKPmCSmH/nEDuIwC2xilDi3+yYbRMt3RomF0xcwg7RwCthJ
	vFhyjgXEFhYIkZi8qBVsFIuAqsTil5fAdvMKWEp8etYAZQtKnJz5BKyeWUBbovdhKyOELS+x
	/e0cZoj7FCR+Pl0GdB8H0BluEud26ECUiEjM7mxjnsAoPAvJpFlIJs1CMmkWkpYFjCyrGCVT
	C4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCI1FLcwfj9lUf9A4xMnEwHmKU4GBWEuF98mpu
	mhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe8Re9KUIC6YklqdmpqQWpRTBZJg5OqQamA0IPJt59
	eFHqhOi+o28j6z4npXI+rFg096rpvVdlLVrF27gvZ6xdfSMhefnys/Znv1n49zzUX3ffMm6x
	xpqnS6Yu4rt/S/CBVGX77M7FJbO+VDx97n3hHNOlA2cEM/YxC4UcaNi/geXWhZz42q9O/l/n
	uTA6y6+zlVP5m3f0r+lltb8pM6b4Ju2r/+M48fwNR8nXU3+d43t/N1Ja5yZPwkL1+TOTJdO3
	nfS8vGX1jRus23rqeJJ8bV8zldzcvKA65k9KA8N7ffXT7Bq3NCzWCm9wOPeI/91hyUsrdrVE
	WLRnquy5++zwoSvJBVomL3h2Fsknzby0xX/+7ifFllu7rPs8EljMrSomG6x+vKbYKVGJpTgj
	0VCLuag4EQCZ40xNMwMAAA==
X-CMS-MailID: 20240725012545epcas2p2465cf815c2f14ea518ac70784a1f8da0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240722223340epcas2p4ab83b1e8dbc64eaaf32f4f8b7e3f015d
References: <20240722223333.1137947-1-sunyeal.hong@samsung.com>
	<CGME20240722223340epcas2p4ab83b1e8dbc64eaaf32f4f8b7e3f015d@epcas2p4.samsung.com>
	<20240722223333.1137947-2-sunyeal.hong@samsung.com>
	<18f5565f-11f5-49ce-a816-366cff25b703@kernel.org>

Hello Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Wednesday, July 24, 2024 7:12 PM
> To: Sunyeal Hong <sunyeal.hong@samsung.com>; Sylwester Nawrocki
> <s.nawrocki@samsung.com>; Chanwoo Choi <cw00.choi@samsung.com>; Alim
> Akhtar <alim.akhtar@samsung.com>; Michael Turquette
> <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>; Rob Herring
> <robh@kernel.org>; Conor Dooley <conor+dt@kernel.org>
> Cc: linux-samsung-soc@vger.kernel.org; linux-clk@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v4 1/4] dt-bindings: clock: add ExynosAuto v920 SoC
> CMU bindings
> 
> On 23/07/2024 00:33, Sunyeal Hong wrote:
> > Add dt-schema for ExynosAuto v920 SoC clock controller.
> > Add device tree clock binding definitions for below CMU blocks.
> >
> > - CMU_TOP
> > - CMU_PERIC0
> >
> > Signed-off-by: Sunyeal Hong <sunyeal.hong@samsung.com>
> > ---
> >  .../clock/samsung,exynosautov920-clock.yaml   | 115 +++++++++++
> >  .../clock/samsung,exynosautov920.h            | 191 ++++++++++++++++++
> >  2 files changed, 306 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.y
> > aml  create mode 100644
> > include/dt-bindings/clock/samsung,exynosautov920.h
> >
> > diff --git
> > a/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock
> > .yaml
> > b/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock
> > .yaml
> > new file mode 100644
> > index 000000000000..90f9f17da959
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/samsung,exynosautov920-c
> > +++ lock.yaml
> > @@ -0,0 +1,115 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://protect2.fireeye.com/v1/url?k=79ef652b-1864700b-79eeee64-74fe
> > +485fb347-9d0b27f7b9bcf4cc&q=1&e=af4d44eb-4030-4020-8a28-394e2a873516&
> > +u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fclock%2Fsamsung%2Cexynosaut
> > +ov920-clock.yaml%23
> > +$schema:
> > +https://protect2.fireeye.com/v1/url?k=4f1f645c-2e94717c-4f1eef13-74fe
> > +485fb347-e7ad6ce5885cf0ba&q=1&e=af4d44eb-4030-4020-8a28-394e2a873516&
> > +u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
> > +
> > +title: Samsung ExynosAuto v920 SoC clock controller
> > +
> > +maintainers:
> > +  - Sunyeal Hong <sunyeal.hong@samsung.com>
> > +  - Chanwoo Choi <cw00.choi@samsung.com>
> > +  - Krzysztof Kozlowski <krzk@kernel.org>
> > +  - Sylwester Nawrocki <s.nawrocki@samsung.com>
> > +
> > +description: |
> > +  ExynosAuto v920 clock controller is comprised of several CMU units,
> > +generating
> > +  clocks for different domains. Those CMU units are modeled as
> > +separate device
> > +  tree nodes, and might depend on each other. Root clocks in that
> > +clock tree are
> > +  two external clocks:: OSCCLK/XTCXO (38.4 MHz) and RTCCLK/XrtcXTI
> (32768 Hz).
> > +  The external OSCCLK must be defined as fixed-rate clock in dts.
> > +
> > +  CMU_TOP is a top-level CMU, where all base clocks are prepared
> > + using PLLs and  dividers; all other clocks of function blocks (other
> > + CMUs) are usually  derived from CMU_TOP.
> > +
> > +  Each clock is assigned an identifier and client nodes can use this
> > + identifier  to specify the clock which they consume. All clocks
> > + available for usage  in clock consumer nodes are defined as
> > + preprocessor macros in  'include/dt-
> bindings/clock/samsung,exynosautov920.h' header.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - samsung,exynosautov920-cmu-top
> > +      - samsung,exynosautov920-cmu-peric0
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 3
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 3
> > +
> > +  "#clock-cells":
> > +    const: 1
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: samsung,exynosautov920-cmu-top
> > +
> > +    then:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: External reference clock (38.4 MHz)
> > +
> > +        clock-names:
> > +          items:
> > +            - const: oscclk
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: samsung,exynosautov920-cmu-peric0
> > +
> > +    then:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: External reference clock (38.4 MHz)
> > +            - description: CMU_PERIC0 NOC clock (from CMU_TOP)
> > +            - description: CMU_PERIC0 IP clock (from CMU_TOP)
> > +
> > +        clock-names:
> > +          items:
> > +            - const: oscclk
> > +            - const: noc
> > +            - const: ip
> > +
> > +required:
> > +  - compatible
> > +  - "#clock-cells"
> > +  - clocks
> > +  - clock-names
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  # Clock controller node for CMU_PERIC0
> > +  - |
> > +    #include <dt-bindings/clock/samsung,exynosautov920.h>
> > +
> > +    cmu_peric0: clock-controller@10800000 {
> > +        compatible = "samsung,exynosautov920-cmu-peric0";
> > +        reg = <0x10800000 0x8000>;
> > +        #clock-cells = <1>;
> > +
> > +        clocks = <&xtcxo>,
> > +                 <&cmu_top DOUT_CLKCMU_PERIC0_NOC>,
> > +                 <&cmu_top DOUT_CLKCMU_PERIC0_IP>;
> > +        clock-names = "oscclk",
> > +                      "noc",
> > +                      "ip";
> > +    };
> > +
> > +...
> > diff --git a/include/dt-bindings/clock/samsung,exynosautov920.h
> > b/include/dt-bindings/clock/samsung,exynosautov920.h
> > new file mode 100644
> > index 000000000000..ad89728a4396
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/samsung,exynosautov920.h
> > @@ -0,0 +1,191 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +/*
> > + * Copyright (c) 2024 Samsung Electronics Co., Ltd.
> > + * Author: Sunyeal Hong <sunyeal.hong@samsung.com>
> > + *
> > + * Device Tree binding constants for ExynosAuto v920 clock controller.
> > + */
> > +
> > +#ifndef _DT_BINDINGS_CLOCK_EXYNOSAUTOV920_H
> > +#define _DT_BINDINGS_CLOCK_EXYNOSAUTOV920_H
> > +
> > +/* CMU_TOP */
> > +#define FOUT_SHARED0_PLL		1
> > +#define FOUT_SHARED1_PLL		2
> > +#define FOUT_SHARED2_PLL		3
> > +#define FOUT_SHARED3_PLL		4
> > +#define FOUT_SHARED4_PLL		5
> > +#define FOUT_SHARED5_PLL		6
> > +#define FOUT_MMC_PLL			7
> > +
> > +/* MUX in CMU_TOP */
> > +#define MOUT_SHARED0_PLL		101
> 
> This is some odd numbering. Numbers start from 0 or 1 and are continuous.
> 
Okay, I will update.
> 
> Best regards,
> Krzysztof

Thanks,
Sunyeal Hong.



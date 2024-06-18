Return-Path: <linux-kernel+bounces-218718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D184F90C492
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 09:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0970B20AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 07:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C05513D516;
	Tue, 18 Jun 2024 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwQzBYzv"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0704413C9B3;
	Tue, 18 Jun 2024 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693944; cv=none; b=HrHyeBF14um6zPdRge0ojunZb49VTYMJLfnOEPyzueWUgTkKQocHsPBzw6E8UpSXj4Beu/hddbEGdyvARPdcaE9pl2FyVpq8itxckBEPcbUVEUhe2zECwbwEEqhjpi8B0bFSMRjJVkvfxjuOyGJ5j5NiOMjwgl30wcAgl7YyXYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693944; c=relaxed/simple;
	bh=t9F6u6IJmEFG4P2YU5LD36dj4+mI/cyeimKQjVCUWlE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=AHzNDc2KHb6otiF6rKlDMW31c7REgHtG2XL71CjSdNEeWAptDHubcV15au/2OzltCEW0qTsTlc5k2WEVSGjk+1I89WbmGYpQERb56HJq/wg+rY1l+XlbiaNgP13u3LOPpXqQhbAWTl5+yZpsY5oyyWd3wFLq8rjqtAsIvwA6StE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwQzBYzv; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70601bcfddcso1455994b3a.3;
        Mon, 17 Jun 2024 23:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718693942; x=1719298742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9F6u6IJmEFG4P2YU5LD36dj4+mI/cyeimKQjVCUWlE=;
        b=kwQzBYzvSTWNLRTU4ko1+EBrdqwnyeewOV4vNV5sQSFB34Wh5Vj/5OmLXMGd+S1/X7
         Saq+0ct6ZEiIbfBQ99aNJLUJstH+r+nACnk7uVAwpMn/+QdrWYAIww8NgEbJoBNI/8qg
         57Gk5v6NRi3JAYlF7RL+XnzCm0uK6XGclHwOAnsneM5ORK5nAYjITnGIpgBxaif1+zNZ
         4TfhsNpEGnVLEIErM1ksH+WK+tWf9m/hayBemt+56V6FOFzg1HuFtkjBPNmvRBmlVhip
         2jF/Ck4mbFGCOlLcPHpVKcpbnStqpQw6HRcff5aLyhyhAn8WxGujYL/tMoBybRx3vUBF
         wJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718693942; x=1719298742;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t9F6u6IJmEFG4P2YU5LD36dj4+mI/cyeimKQjVCUWlE=;
        b=Ff9QWyDnHC5m06LQiBHryWd5+zKjZh5QPfovzgmbj+UkUY5sXiKEr8Se6hyBQFGHtZ
         /JDTnTi7Sup4oFSh/Yubf49TDGRdDRw3w6SNTkkP+wpqGaqC9VyCHd1zS/QzTOe0F8Ie
         DVNFH18VbUpqQHqzRiY0Jb/ge4glmhWZbwMLbXSV/7zdcUMbJalrImpA82z1y/K62fYP
         7krLovOhYmbEKxIPtG9r2nP5USbtjvpjhWlI5dSimwIIQVdG/14o1IbECXRTpaBQfTp1
         sy75Z47rZn/KwWtF/Xb/VlgoFboWVN5V/DIH3QvCVHvbc4+xDHQZv2AcNp6A1I8y1laP
         K4Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUCs90810W2a9LMKZnBB0LDm+uQfRgWZsIcT1JGV1cSVRkAfvmAm5CFO3WLEIzjI6Owh1y/soI6JBnTVe01sGLKMVP/VQQXYaW03i5sMCQbIzuqKKhugU2kOgkfM9eZ6vWQ9y3jXZB12A==
X-Gm-Message-State: AOJu0Ywd+0Uj45w6xvafPHWLIPSg1C6TMLm0NsBVjPmLkGRva3oPBGBC
	uDXG8FGGWTC8SO2vpcJlH5fyx3SoTylrIpYKFMQGATt0xSZGBYFm
X-Google-Smtp-Source: AGHT+IEX9TfGGQ/S5B0tqGgdQQ9ZVCt+0dUpnuU5ru1HCrVIQoO7l66wIP5ByO9l79JqEaPnUT5ODg==
X-Received: by 2002:a05:6a20:3946:b0:1b6:dffa:d6ec with SMTP id adf61e73a8af0-1bae823dbd6mr14600662637.46.1718693942175;
        Mon, 17 Jun 2024 23:59:02 -0700 (PDT)
Received: from [127.0.0.1] ([122.161.50.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f993eae952sm6720865ad.267.2024.06.17.23.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 23:59:01 -0700 (PDT)
Date: Tue, 18 Jun 2024 12:28:48 +0530 (GMT+05:30)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, heiko@sntech.de,
	sebastian.reichel@collabora.com, andy.yan@rock-chips.com,
	s.hauer@pengutronix.de, jbx6244@yandex.com,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	javier.carrasco.cruz@gmail.com, skhan@linuxfoundation.org
Message-ID: <b7363a2e-7c49-4716-a43b-41d420a10438@gmail.com>
In-Reply-To: <79f3ae72-e733-433c-a577-e0092e3ce20e@kernel.org>
References: <20240617085341.34332-2-shresthprasad7@gmail.com> <f691c7f9-cd81-4bdf-a794-95118cb26686@kernel.org> <CAE8VWiLqBUq=-PzT2XVKB_C9nvEERM0x-maWU5qt0+aK1Rd-kg@mail.gmail.com> <79f3ae72-e733-433c-a577-e0092e3ce20e@kernel.org>
Subject: Re: [PATCH v4] dt-bindings: phy: rockchip-emmc-phy: Convert to
 dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <b7363a2e-7c49-4716-a43b-41d420a10438@gmail.com>

18 June 2024 11:50:41=E2=80=AFam Krzysztof Kozlowski <krzk@kernel.org>:

> On 17/06/2024 20:14, Shresth Prasad wrote:
>=20
>>>> +examples:
>>>> +=C2=A0 - |
>>>> +=C2=A0=C2=A0=C2=A0 grf: syscon@ff770000 {
>>>=20
>>> Drop label... actually entire node looks not needed.
>>=20
>> From what I understand, this `phy` node should be a sub-node of a `grf`
>> node which is why it is part of the example.
>>=20
>>>=20
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "rockchip,rk3399-grf", =
"syscon", "simple-mfd";
>>>=20
>>> Drop
>>>=20
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0xff770000 0x10000>;
>>>=20
>>> Drop
>>=20
>> Removing `reg` causes the following warning:
>> Warning (unit_address_vs_reg): /example-0/syscon@ff770000: node has a
>> unit name, but no reg or ranges property
>>=20
>> Please let me know what the prefered solution would be here.
>=20
> Obviously you need to drop entire node... You cannot just drop reg and
> leave unit address.
>=20
>>=20
>>>=20
>>>=20
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <1>;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 emmcphy: phy@f780 {
>>>=20
>>> Drop label
>>>=20
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "rockchip,r=
k3399-emmc-phy";
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0xf780 0x20>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&sdhci>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names =3D "emmcclk";
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drive-impedance-ohm =3D <5=
0>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #phy-cells =3D <0>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>>> +=C2=A0=C2=A0=C2=A0 };
>>>> diff --git a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.t=
xt b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
>>>> deleted file mode 100644
>>>> index 57d28c0d5696..000000000000
>>>> --- a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
>>>> +++ /dev/null
>>>> @@ -1,43 +0,0 @@
>>>> -Rockchip EMMC PHY
>>>> ------------------------
>>>> -
>>>> -Required properties:
>>>> - - compatible: rockchip,rk3399-emmc-phy
>>>> - - #phy-cells: must be 0
>>>> - - reg: PHY register address offset and length in "general
>>>> -=C2=A0=C2=A0 register files"
>>>> -
>>>> -Optional properties:
>>>> - - clock-names: Should contain "emmcclk".=C2=A0 Although this is list=
ed as optional
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (because most boards can get basic functionality without having
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 access to it), it is strongly suggested.
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 See ../clock/clock-bindings.txt for details.
>>>> - - clocks: Should have a phandle to the card clock exported by the SD=
HCI driver.
>>>> - - drive-impedance-ohm: Specifies the drive impedance in Ohm.
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Possi=
ble values are 33, 40, 50, 66 and 100.
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If no=
t set, the default value of 50 will be applied.
>>>> - - rockchip,enable-strobe-pulldown: Enable internal pull-down for the=
 strobe
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 line.=C2=
=A0 If not set, pull-down is not used.
>>>> - - rockchip,output-tapdelay-select: Specifies the phyctrl_otapdlysec =
register.
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If not s=
et, the register defaults to 0x4.
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Maximum =
value 0xf.
>>>> -
>>>> -Example:
>>>> -
>>>> -
>>>> -grf: syscon@ff770000 {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "rockchip,rk3399-grf", "sysco=
n", "simple-mfd";
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <1>;
>>>> -
>>>> -...
>>>> -
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 emmcphy: phy@f780 {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 compatible =3D "rockchip,rk3399-emmc-phy";
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 reg =3D <0xf780 0x20>;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 clocks =3D <&sdhci>;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 clock-names =3D "emmcclk";
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 drive-impedance-ohm =3D <50>;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 #phy-cells =3D <0>;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 };
>>>> -};
>>>> diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b=
/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>>>> index 79798c747476..6e1b1cdea680 100644
>>>> --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>>>> +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>>>> @@ -176,9 +176,12 @@ allOf:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Documentation/devicetree/bindings/phy/rockchip-pcie-phy.txt
>>>>=20
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 patternProperties:
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "phy@[0-9a-f]+$":
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description:
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Do=
cumentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "^phy@[0-9a-f]+$":
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: object
>>>> +
>>>=20
>>> Drop blank line
>>>=20
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas=
/phy/rockchip,rk3399-emmc-phy.yaml#
>>>> +
>>>=20
>>> Drop blank line
>>=20
>> The rest of the document also has these blank lines, which is why I've
>> also kept them here. Are you sure I should remove them?
>=20
> Yes
>=20
>>=20
>>>=20
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unevaluatedPro=
perties: false
>>>>=20
>>>> =C2=A0=C2=A0 - if:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
>>>=20
>>> Nothing in example? Isn't the example for 3399?
>>>=20
>>> We want only one complete example of such multi-children devices, so th=
e
>>> example can be moved and included in existing one here.
>>=20
>> The example in this file is actually for `rockchip,rk3399-usb2phy` and
>> not `rockchip,rk3399-emmc-phy` which is why I haven't touched it.
>=20
> What? That's gref, not usb2phy.
>=20
> This patch and your explanations are very confusing.
>=20
>=20
>=20
> Best regards,
> Krzysztof

Sorry about this, I'm still quite new to doing this.
I ask that you be a bit more patient with me, I'm still trying to learn
how things work here...

Regards,
Shresth


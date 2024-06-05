Return-Path: <linux-kernel+bounces-203125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A19A8FD6CB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79D0EB215A2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CCF155303;
	Wed,  5 Jun 2024 19:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=incomsystems.biz header.i=@incomsystems.biz header.b="nAaIanT/"
Received: from mail01.incomsystems.biz (mail.cipherdyne.com [162.250.226.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855271527AA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.250.226.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617115; cv=none; b=UgEiEIcG3uSJrGBqqVscOnd076dRJbyKUylOzMRxpaqJ1GGJZsEcf7O7TnnD05XXV/7REqlaA3t0C4elugyjPudVn0ijJePQjdSR/iuWkMpb4hDUqfIr4yBR+QhDgkc9ZZNm7WcyV8Eu3ikg3NsauNcf2MRu7cGKld9ComkTlHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617115; c=relaxed/simple;
	bh=1I7dMMv3ctrad10isf9k0RCeb8faALDIC31J2T38qNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZIjd25AvU9v5aTDxpAedBjYWshTky510E4ouKcgoq++4YLcN1V96PvE++jvEsodKB4X/fplZXvHNemECM2u9vD6DqpjbSGZQ7vxOse+CJ6H58xl4SOCCfeN72ZqVrGcDTtjcIt0RJicXcxkvKoq3gSRkGCpN83D/tbY3hftxNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=incomsystems.biz; spf=pass smtp.mailfrom=incomsystems.biz; dkim=temperror (0-bit key) header.d=incomsystems.biz header.i=@incomsystems.biz header.b=nAaIanT/; arc=none smtp.client-ip=162.250.226.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=incomsystems.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=incomsystems.biz
Received: from mail01.incomsystems.biz (localhost [127.0.0.1])
	by mail01.incomsystems.biz (Postfix) with ESMTP id 4VvdHH0GPlz1dM2n3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 14:45:47 -0500 (CDT)
Authentication-Results: mail01.incomsystems.biz (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)" header.d=incomsystems.biz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=incomsystems.biz;
	 h=content-transfer-encoding:content-type:in-reply-to:from
	:content-language:references:to:subject:user-agent:mime-version
	:date:message-id; s=dkim; t=1717616746; x=1720208747; bh=1I7dMMv
	3ctrad10isf9k0RCeb8faALDIC31J2T38qNw=; b=nAaIanT/vPIGUiYq9T7Yq1f
	pr4Ox4k6Uzcli5ozurq1kei6O/tOChe0LReSg4LxBMRAD8WKd9HuY5mww9OAoYAJ
	szpL5o2sJD1UIOoGV3h4LFDgxM80Y1YLGwkaSPUJMTgCb1YZdMQFfyPzf9gR78OC
	mFhT17iF/tKHL3pJyG+g3BgUVMVmaXJFFCpBkY99b0e2aWIVIdD8jy2RIMnMkA9t
	0CCxvo0ozD4sFXpivqGIC9zD1NtADgckel2H6A3KmOW1zVTXMCKTi2ejh74G84L3
	rB4qlibi0Uj6Tt+5nuSU8gAnhLstVMTDshi4WSpju8kGzQUcYvYV3tekslUNAxw=
	=
X-Virus-Scanned: amavisd-new at mail01.incomsystems.biz
Received: from mail01.incomsystems.biz ([127.0.0.1])
	by mail01.incomsystems.biz (mail01.incomsystems.biz [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2IUCEimiiFnC for <linux-kernel@vger.kernel.org>;
	Wed,  5 Jun 2024 14:45:46 -0500 (CDT)
Received: from [10.0.1.120] (199-47-118-71.fidnet.com [199.47.118.71])
	by mail01.incomsystems.biz (Postfix) with ESMTPSA id 4VvdHF4B4Zz1XZRs8;
	Wed,  5 Jun 2024 14:45:45 -0500 (CDT)
Message-ID: <659dfd80-5962-4265-836d-5761c3e41ca0@incomsystems.biz>
Date: Wed, 5 Jun 2024 14:45:42 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add PCIe pinctrls to Turing RK1
To: Sam Edwards <cfsworks@gmail.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 =?UTF-8?Q?Daniel_Kukie=C5=82a?= <daniel@kukiela.pl>,
 Sven Rademakers <sven.rademakers@gmail.com>, Joshua Riek <jjriek@verizon.net>
References: <20231208062510.893392-1-CFSworks@gmail.com>
 <6311244.MhkbZ0Pkbq@diego> <66f413d2-1a5b-b9e3-3c86-35a1d150f486@gmail.com>
Content-Language: en-US
From: Jonathan Bennett <jbennett@incomsystems.biz>
Autocrypt: addr=jbennett@incomsystems.biz; keydata=
 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
 YdQTKZDQSuKmpmCIzJrRCnc=
In-Reply-To: <66f413d2-1a5b-b9e3-3c86-35a1d150f486@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 12/8/23 11:27 AM, Sam Edwards wrote:
>
>
> On 12/8/23 04:05, Heiko St=C3=BCbner wrote:
>> Hi Sam,
>>
>> Am Freitag, 8. Dezember 2023, 07:25:10 CET schrieb Sam Edwards:
>>> The RK3588 PCIe 3.0 controller seems to have unpredictable behavior=20
>>> when
>>> no CLKREQ/PERST/WAKE pins are configured in the pinmux. In=20
>>> particular, it
>>> will sometimes (varying between specific RK3588 chips, not over=20
>>> time) shut
>>> off the DBI block, and reads to this range will instead stall
>>> indefinitely.
>>>
>>> When this happens, it will prevent Linux from booting altogether. The
>>> PCIe driver will stall the CPU core once it attempts to read the=20
>>> version
>>> information from the DBI range.
>>>
>>> Fix this boot hang by adding the correct pinctrl configuration to the
>>> PCIe 3.0 device node, which is the proper thing to do anyway. While
>>> we're at it, also add the necessary configuration to the PCIe 2.0 nod=
e,
>>> which may or may not fix the equivalent problem over there -- but is=20
>>> the
>>> proper thing to do anyway. :)
>>>
>>> Fixes: 2806a69f3fef6 ("arm64: dts: rockchip: Add Turing RK1 SoM=20
>>> support")
>>> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
>>> ---
>>>
>>> Hi list,
>>>
>>> Compared to v1, v2 removes the `reset-gpios` properties as well --=20
>>> this should
>>> give control of the PCIe resets exclusively to the PCIe cores. (And=20
>>> even if the
>>> `reset-gpios` props had no effect in v1, it'd be confusing to have=20
>>> them there.)
>>
>> Hmm, I'd think this could result in differing behaviour.
>>
>> I.e. I tried the same on a different board with a nvme drive on the=20
>> pci30x4
>> controller. But moving the reset from the gpio-way to "just" setting t=
he
>> perstn pinctrl, simply hung the controller when probing the device.
>
> Ah, I'm guessing it died in:
> ver =3D dw_pcie_readl_dbi(pci, PCIE_VERSION_NUMBER);
>
> If so, that's the same hang that this patch is aiming to solve. I'm=20
> starting to wonder if having muxed pins !=3D 1 for a given signal upset=
s=20
> the RC(s). Is your board (in an earlier boot stage:=20
> reset/maskrom/bootloader) muxing a different perstn pin option to that=20
> controller (and Linux doesn't know to clear it away)? Then when you=20
> add the perstn pinctrl the total number of perstns muxed to the=20
> controller comes to 2, and without a reset-gpios =3D <...>; to take it=20
> away again, that number stays at 2 to cause the hang upon the DBI read?
>
> If so, that'd mean the change resolves the hang for me, because it=20
> brings the total up to 1 (from 0), but also causes the hang for you,=20
> because it brings the total up to 2 (away from 1).
>
>>
>> So I guess I'd think the best way would be to split the pinctrl up=20
>> into the
>> 3 separate functions (clkreqn, perstn, waken) so that boards can inclu=
de
>> them individually.
>
> Mm, maybe. Though that might be more appropriate if a board comes=20
> along that doesn't connect all of those signals to the same group of=20
> pins. I worry that attempting to solve this hang by doing that will=20
> instead just mask the real problem.
>
>>
>> Nobody is using the controller pinctrl entries so far anyway :-) .
>
> Then it's interesting that this board requires them in order to avoid=20
> a hang on boot. I'll see if there's anything else that I can find out.

I've just finished testing the latest iteration of this patch with=20
6.10-rc2 on my RK1 on a Turing Pi 2 carrier board. I can confirm that=20
unpatched mainline fails to boot with the same hang described here, and=20
the patch does make the board boot again.


--Jonathan Bennett

>
> Happy Friday,
> Sam
>
>>
>>
>> Heiko
>>
>>
>>> Note that it is OK for the pcie2x1l1 node to refer to=20
>>> pcie30x1m1_pins. The
>>> pcie2x1l1 device is *in fact* a PCIe 3.0 controller, and the=20
>>> pcie30x1m1_pins
>>> pinmux setting is so-named to reflect this. The pcie2x1l1 node is=20
>>> so-named
>>> because Linux does not (currently) support routing it to a PCIe 3.0=20
>>> PHY; so in
>>> practice it is effectively a PCIe 2.0 controller, for the time being.
>>>
>>> Cheers and thank you for your time,
>>> Sam
>>>
>>> ---
>>> =C2=A0 .../boot/dts/rockchip/rk3588-turing-rk1.dtsi=C2=A0=C2=A0=C2=A0=
=C2=A0 | 16=20
>>> ++--------------
>>> =C2=A0 1 file changed, 2 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi=20
>>> b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
>>> index 9570b34aca2e..875446fdb67e 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
>>> @@ -214,8 +214,7 @@ rgmii_phy: ethernet-phy@1 {
>>> =C2=A0 &pcie2x1l1 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux,pci-domain =3D <1>;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "default";
>>> -=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&pcie2_reset>;
>>> -=C2=A0=C2=A0=C2=A0 reset-gpios =3D <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
>>> +=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&pcie30x1m1_pins>;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
>>> =C2=A0 };
>>> =C2=A0 @@ -226,8 +225,7 @@ &pcie30phy {
>>> =C2=A0 &pcie3x4 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux,pci-domain =3D <0>;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "default";
>>> -=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&pcie3_reset>;
>>> -=C2=A0=C2=A0=C2=A0 reset-gpios =3D <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
>>> +=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&pcie30x4m1_pins>;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vpcie3v3-supply =3D <&vcc3v3_pcie30>;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
>>> =C2=A0 };
>>> @@ -245,17 +243,7 @@ hym8563_int: hym8563-int {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 pcie2 {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcie2_reset: pcie2-reset =
{
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
ockchip,pins =3D <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> -=C2=A0=C2=A0=C2=A0 };
>>> -
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcie3 {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcie3_reset: pcie3-reset =
{
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
ockchip,pins =3D <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> -
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vcc3v3_pcie30_=
en: pcie3-reg {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 rockchip,pins =3D <2 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>>
>>
>>
>>
>>
>


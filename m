Return-Path: <linux-kernel+bounces-207431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFF4901709
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 18:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3FE11C2096F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 16:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665A1481A4;
	Sun,  9 Jun 2024 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="hkHs631w"
Received: from shout12.mail.de (shout12.mail.de [62.201.172.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A71DDBD;
	Sun,  9 Jun 2024 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717951576; cv=none; b=vEsgej041vngvm+87NDkeZgeIqfpLBVn8O+dg5xTM8iuM9nTWswURSrCQUriF4awzFpaE9T00nNCj/4Pj/z4URDhjPzyrvXkoS8ZLWmc01Bs6iTDNGeAGT1iuiFDPdz5neQAepyt1ca8nkjO5ajh9Eyk0TQTJYDq0Monx0IfaRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717951576; c=relaxed/simple;
	bh=jfyGvlGEvYiwFZvbfeRUSKsLW6JLidUM2IzOwSvkqQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PA/EVsQnYYae4dYhitZWrjlhYgCx4xlXPeZBKeACPTjNCXJxpqESioBGBUVzoKXH+CHh7EZaLbgpxPzB3XRvLe/9HZaWhpqSVZQa4FEErEewhziRbNj0zPzOdYmLtvMULQv9t6n0F2itynq3KGH/xuwpLPwvkBDF19DBPDtJREE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=hkHs631w; arc=none smtp.client-ip=62.201.172.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Received: from shout01.mail.de (unknown [10.0.120.221])
	by shout12.mail.de (Postfix) with ESMTPS id C2B7B2409FD;
	Sun,  9 Jun 2024 18:46:12 +0200 (CEST)
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
	by shout01.mail.de (Postfix) with ESMTP id 90618240B96;
	Sun,  9 Jun 2024 18:46:12 +0200 (CEST)
Received: from smtp01.mail.de (smtp02.bt.mail.de [10.0.121.212])
	by postfix01.mail.de (Postfix) with ESMTP id 6AD4580208;
	Sun,  9 Jun 2024 18:46:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1717951572;
	bh=jfyGvlGEvYiwFZvbfeRUSKsLW6JLidUM2IzOwSvkqQk=;
	h=Message-ID:Date:Subject:To:Cc:From:From:To:CC:Subject:Reply-To;
	b=hkHs631wRZz1GbWKIX3UpR9O1OykwtF24iobhVeHL1/2HnaQzh3XrqcBfaXByZ2gl
	 wSAfOPiJzuHv84dxGJ0rLkMZdvereVZO+myZ7FEY2ZHiAmKTFtpUZDbwFgit87eE60
	 krVRwg8LZIViCzNAg+7LpzptSCicGp9DZnUQM9fvpm8EP4qpytEtaorzPbBR5w2RS9
	 hyI6//dy+QnvitRz0lwsltlFRkRjDndc02KAf4rUCy7adjAYCwnKDe32VzIQQcmRfR
	 5hjfpAajtwoBjJYhRxqN1+ZSD40LzNQTWS7RL8ChoLFL9Zoqx9LqH5M3GBmdxC8sUW
	 CuPcQ5xFbGn5A==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id 80DE7240EBC;
	Sun,  9 Jun 2024 18:46:10 +0200 (CEST)
Message-ID: <9150cfa3-ab22-4b1e-a392-2cb9469f3821@mail.de>
Date: Sun, 9 Jun 2024 18:46:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add FriendlyElec CM3588 NAS
 board
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 linux-rockchip@lists.infradead.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Space Meyer <me@the-space.agency>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240602211901.237769-1-seb-dev@mail.de>
 <11747652.CDJkKcVGEf@phil> <f5cfcf3e-27e5-464a-9adf-261753ad6de7@mail.de>
 <4035271.e99z0qppnp@diego>
From: Sebastian Kropatsch <seb-dev@mail.de>
In-Reply-To: <4035271.e99z0qppnp@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 3052
X-purgate-ID: 154282::1717951572-1AD2B878-FAB12F85/0/0

Am 09.06.2024 um 18:05 schrieb Heiko Stübner:
> Am Samstag, 8. Juni 2024, 19:22:01 CEST schrieb Sebastian Kropatsch:
>> Am 08.06.2024 um 16:38 schrieb Heiko Stuebner:
>>> Am Donnerstag, 6. Juni 2024, 15:13:20 CEST schrieb Space Meyer:
>>>> On 02.06.2024 22:20, Sebastian Kropatsch wrote:
>>>>> +	vcc_3v3_pcie30: regulator-vcc-3v3-pcie30 {
>>>>> +		compatible = "regulator-fixed";
>>>>> +		regulator-name = "vcc_3v3_pcie30";
>>>>> +		regulator-always-on;
>>>>> +		regulator-boot-on;
>>>>> +		regulator-min-microvolt = <3300000>;
>>>>> +		regulator-max-microvolt = <3300000>;
>>>>> +		vin-supply = <&vcc_5v0_sys>;
>>>>> +	};
>>>>
>>>> These are 4 seperate regulators according to the schematic. However, as
>>>> they are all fixed, idk if they should be split or kept like this.
>>>
>>> personally, I really like the power-diagram to match schematics.
>>> I.e. $debugfs/regulator/regulator_summary will produce a really nice
>>> graph of all the system's regulators, so it's definitly nice if the
>>> hirarchy matches. Also prevents head-scratching later on ;-)
>>
>> These are indeed 4 different regulators according to the schematic.[1]
>> But they don't have any pin to control them separately. I can
>> duplicate them 4 times if that's the preferred practice.
>>
>> But matching the schematics won't be possible either way, since
>> e.g. there is only one single 5v regulator acc. to the schematic
>> (vcc_5v0_sys), but vcc_5v0_host_20, vcc_5v0_host_30, vbus_5v0_typec
>> and so on are needed since each device has a different control pin
>> to enable its power. Or is there a better way to solve this while
>> having only one 5v regulator node but still being able to set the
>> control pins separately for the different USB ports?
> 
> The other option we often use is to define multiple phandles
> for a regulator. For exactly that case where one gpio controls
> a set of regulators.
> 
> So you have one regulator
> 
> vcc_5v0_host_20: vcc_5v0_host_30: vbus_5v0_typec: regulator-vcc-whatever {
> 	foo;
> }
> 
> So in short there is not set rule, but more like a best-effort to get as
> close to the schematics as possible. I.e. someone going from dt
> to schematics should be able to just search for an identifier
> (of course same for the other direction).

I see. And then later in the file have something like this?

&vcc_5v0_host_20{
	gpios = <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
};

&vcc_5v0_host_30{
	gpios = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
};

&vbus_5v0_typec{
	gpios = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
};

Will this work? I thought these gpios would then all just go into
the above mentioned "regulator-vcc-whatever" node, overwriting
each other. If so, I think the solution of keeping them as separate
regulators would still be fine, since as Space Meyer mentioned that,
although all USBs are connected to the same regulator, they have one
SY6280AAC power switch each and these switches have enable pins (which
are seen above in the gpios).


Cheers,
Sebastian


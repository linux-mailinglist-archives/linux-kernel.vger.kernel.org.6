Return-Path: <linux-kernel+bounces-207157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 528A1901300
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 19:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1011F216BA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 17:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC828168BD;
	Sat,  8 Jun 2024 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="QtPq22zk"
Received: from shout12.mail.de (shout12.mail.de [62.201.172.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293C2C13D;
	Sat,  8 Jun 2024 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717867338; cv=none; b=huFBhNfaylP0ZpvXu4D7OVqTrdJ+PSx/bk6/Yiuyzu1icmpLSp0qsig1xztn5PTaCn9PUjr7OkwajWlq7BvARKXkS7BPnKAkwBttfowTPeMxdE9A7P2OyeN4A6D9QhlYqddQN29LUGsQa0+aB5kz/BMztBJZvvVfeRmQspJ3O8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717867338; c=relaxed/simple;
	bh=nTqQvFr46P0vv3NLlWh3QruttC5WiwbWCLiZjuxYiw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aik9nygMvObun6eyDmnnHA8kAoww/OM68lN4aeMA/WOrhXa+WJLFZbqlKsg3E9OdDrRkk1ToNmuzkd0ZgvdlzyWFudYbE5LXxRwEAibxKdCmJtsHO+My6lWac75uJxudT/oJZnR0/KubsDt+LFbIzTIbwyPlF+/GDUv4k1P+MxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=QtPq22zk; arc=none smtp.client-ip=62.201.172.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Received: from shout02.mail.de (unknown [10.0.120.222])
	by shout12.mail.de (Postfix) with ESMTPS id CD59324195D;
	Sat,  8 Jun 2024 19:22:07 +0200 (CEST)
Received: from postfix02.mail.de (postfix02.bt.mail.de [10.0.121.126])
	by shout02.mail.de (Postfix) with ESMTP id 7CB59240D28;
	Sat,  8 Jun 2024 19:22:07 +0200 (CEST)
Received: from smtp01.mail.de (smtp03.bt.mail.de [10.0.121.213])
	by postfix02.mail.de (Postfix) with ESMTP id 56B9FA00E2;
	Sat,  8 Jun 2024 19:22:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1717867327;
	bh=nTqQvFr46P0vv3NLlWh3QruttC5WiwbWCLiZjuxYiw4=;
	h=Message-ID:Date:Subject:To:Cc:From:From:To:CC:Subject:Reply-To;
	b=QtPq22zkCst/3Odw3H+ZrzKPc1+PJfy5CFLdCIEFwWJf+Ty5hUeca2pvr47pY4cQ6
	 haBxMXq9Ugs0o2vgBln2sBpNoVHcggwHiOUWQ3mO/Q1MDc6YjFK2SQY1IhjiVzSYxw
	 dQGcHZsD/nDFfUuQ4YlvPcXCq+O6Rnr8/tFqFvfX660fttgMej8ZcQA0FOF9Cw04Sp
	 7q8+1n0+RTvUKgS6I7+4QpMmUItv++HH3CH0RHDgFGIc7CERs2Sfx98Rj6N2jiDQir
	 ExM4+gGeZPlqpzkBS+i/9W8EEKtx5AZEjBS8wYbMn6tcoSSm2WhOoF8oY+mTHfnyvi
	 qUzdmukmKW3lQ==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id E0C8124009E;
	Sat,  8 Jun 2024 19:22:02 +0200 (CEST)
Message-ID: <f5cfcf3e-27e5-464a-9adf-261753ad6de7@mail.de>
Date: Sat, 8 Jun 2024 19:22:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add FriendlyElec CM3588 NAS
 board
To: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Space Meyer <me@the-space.agency>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240602211901.237769-1-seb-dev@mail.de>
 <20240602202132.2012-2-seb-dev@mail.de>
 <c4087311-cbd2-415e-a582-3565f2f62e81@the-space.agency>
 <11747652.CDJkKcVGEf@phil>
From: Sebastian Kropatsch <seb-dev@mail.de>
In-Reply-To: <11747652.CDJkKcVGEf@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 2691
X-purgate-ID: 154282::1717867327-31E241F9-A930B556/0/0

Hello,

Am 08.06.2024 um 16:38 schrieb Heiko Stuebner:
> Am Donnerstag, 6. Juni 2024, 15:13:20 CEST schrieb Space Meyer:
>> On 02.06.2024 22:20, Sebastian Kropatsch wrote:
>>> Some RK3588 boards are still using this property, the following quote
>>> is from rk3588-tiger-haikou.dts for example:
>>>       &sdmmc {
>>>           /* while the same pin, sdmmc_det does not detect card changes */
>>>           cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
>>>
>>> I am unsure as to whether this comment from the quote might apply for
>>> the CM3588 as well. Please let me know if you are able to tell :-)
>>
>> I don't quite understand this. However GPIO0_A4 *is* routed to the micro
>> sd CD according to the NAS schematic, page 16 around A5.
> 
> for the actual sdmmc_det functionality ... possibly some pinconfig thing?
> I.e. pull-whatever settings?

I have no idea. I just removed the "cd-gpios" line in v2 due to a
suggestion by Jonas Karlman and then stumbled over this comment.
So I'm not sure whether to include or not include this property
for the CM3588 NAS since I don't know the consequences.
Probably in the end it doesn't even matter :)

>>> +	vcc_3v3_pcie30: regulator-vcc-3v3-pcie30 {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "vcc_3v3_pcie30";
>>> +		regulator-always-on;
>>> +		regulator-boot-on;
>>> +		regulator-min-microvolt = <3300000>;
>>> +		regulator-max-microvolt = <3300000>;
>>> +		vin-supply = <&vcc_5v0_sys>;
>>> +	};
>>
>> These are 4 seperate regulators according to the schematic. However, as
>> they are all fixed, idk if they should be split or kept like this.
> 
> personally, I really like the power-diagram to match schematics.
> I.e. $debugfs/regulator/regulator_summary will produce a really nice
> graph of all the system's regulators, so it's definitly nice if the
> hirarchy matches. Also prevents head-scratching later on ;-)

These are indeed 4 different regulators according to the schematic.[1]
But they don't have any pin to control them separately. I can
duplicate them 4 times if that's the preferred practice.

But matching the schematics won't be possible either way, since
e.g. there is only one single 5v regulator acc. to the schematic
(vcc_5v0_sys), but vcc_5v0_host_20, vcc_5v0_host_30, vbus_5v0_typec
and so on are needed since each device has a different control pin
to enable its power. Or is there a better way to solve this while
having only one 5v regulator node but still being able to set the
control pins separately for the different USB ports?

Cheers,
Sebastian

[1] 
https://wiki.friendlyelec.com/wiki/images/1/15/CM3588_NAS_SDK_2309_SCH.PDF



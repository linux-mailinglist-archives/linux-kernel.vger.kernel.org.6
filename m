Return-Path: <linux-kernel+bounces-223583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D3C91151C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBEF91C2299E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622B77FBBD;
	Thu, 20 Jun 2024 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="Vn7sJmKi"
Received: from shout12.mail.de (shout12.mail.de [62.201.172.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF20A2E859;
	Thu, 20 Jun 2024 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718920100; cv=none; b=gtw+3Rx0gFdMqNAldb9LAQ4/4hX9d/aiECWxYf+6ZcTl7Y90U0DgZtIEnAhwJf86m3k+ciMgDaDpg+119PhWraMUo0ovfKNKNzDMDad9whNEVFq+OCY179OGiyf2t8CH0WQ9PkhUVZDN7WF1/W5GLoWBUWJrzfRVPABGoax8NOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718920100; c=relaxed/simple;
	bh=iq4LT+jyWGK+Ggs3f9sRwblW6Uz0uQJK4QXqBRqHS48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOO2898JqlVmLTvxJs6DcgSx8l1V4A3qq5LIm65/ECvqhqkVx10tbwGrovkWIDtI59no+C9zb83aZKqh8bGlmQYfn2kATFi3DaNCRMM+3nwHJvIqezId7sUbCQ8LIK28dllseQ4oZlhaP6aiqJoUvlWu37P89qtY3KDRUMuzuFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=Vn7sJmKi; arc=none smtp.client-ip=62.201.172.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Received: from shout02.mail.de (unknown [10.0.120.222])
	by shout12.mail.de (Postfix) with ESMTPS id 71EB2240AE7;
	Thu, 20 Jun 2024 23:48:11 +0200 (CEST)
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
	by shout02.mail.de (Postfix) with ESMTP id 510B3240E88;
	Thu, 20 Jun 2024 23:48:11 +0200 (CEST)
Received: from smtp01.mail.de (smtp03.bt.mail.de [10.0.121.213])
	by postfix01.mail.de (Postfix) with ESMTP id 3408D80102;
	Thu, 20 Jun 2024 23:48:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1718920091;
	bh=iq4LT+jyWGK+Ggs3f9sRwblW6Uz0uQJK4QXqBRqHS48=;
	h=Message-ID:Date:Subject:To:Cc:From:From:To:CC:Subject:Reply-To;
	b=Vn7sJmKioo/vVPjRjBiQdn1e/iqneX/zujqFhr/NkFIZMQ+2Go2xXHs0meftyb7VW
	 eZsewcjYvQaTnTMdez4fedy51q2YtJKHjHHNFU+nw/0R4aHjpb7BNj0HMOTeYgNcWb
	 Upz6iXkbJm5ylowLCTH6+bVzlwAmLk3es+1B8WDkz2rSLU62SqnrqKnXlvfSZn8Pld
	 LVuqReINdq03YRp1TC2uHDz9koT3TibUGsOGbW3ZuQLpkzhjgXD35pgfgRs8aMB0J1
	 XA9lP0ugSBsmhRsoPxtXS4LAbqpGjsdmm7d/LrCmISuWECxRl1ZUlYNlhwQOhLoaJD
	 aNftFxTOfMNbA==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id 650BA240573;
	Thu, 20 Jun 2024 23:48:10 +0200 (CEST)
Message-ID: <dd08df6f-5074-4fc2-909d-1d4f7676b2b3@mail.de>
Date: Thu, 20 Jun 2024 23:48:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/5] arm64: dts: rockchip: Fix regulators, gmac and naming
 on NanoPi R6C/R6S
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240612205056.397204-1-seb-dev@mail.de>
 <20240612205056.397204-3-seb-dev@mail.de> <2396550.3c9HiEOlIg@diego>
From: Sebastian Kropatsch <seb-dev@mail.de>
In-Reply-To: <2396550.3c9HiEOlIg@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 2485
X-purgate-ID: 154282::1718920091-0EE221F9-1BC16D9C/0/0

Hello,

Am 20.06.2024 um 20:39 schrieb Heiko Stübner:
> Am Mittwoch, 12. Juni 2024, 22:48:11 CEST schrieb Sebastian Kropatsch:
>> Fix the alphabetical ordering in some nodes and rename some regulators
>> and pins to match the schematics [1][2] as well as to adhere to
>> preferred naming schemes.
> 
> General rule of thumb, when you need an "and" in your subject or a list
> like the above - you definitly want to split the change into multiple
> commits.

Thanks for the advice! I wasn't sure and didn't want to spam the list.
Also, my email provider only allows a limited number of emails to be
sent every day (series with 5 patches, with 9 recipients = 45 emails
sent). So I might have to send the patch series by spanning the
different patches over multiple days.

If anyone knows an email provider which is better suited for this kind
of open source work/mailing lists and is also privacy respecting, please
let me know :)

I will definitely split these changes into separate commits.

>> In addition to that:
>> * vcc_3v3_sd_s0: Fix voltage to be 3.3V
>> * vcc3v3_pcie:
>>      - Move to NanoPi R6C, this power switch is not available on R6S
>>      - Fix vin-supply (is vcc_5v0 per schematics)
>>      - Add gpios/pincrtl to enable power
> 
> this defnitly needs its own patch
> 
>> * vcc5v0_usb: Remove this regulator since according to the schematics,
> 
> this too
> 
>> * vcc5v0_host_20 and vcc5v0_usb_otg0 are directly powered by vcc_5v0
> 
> this could be grouped together with the 3.3v change
> 
>> * gmac1: Add rx_delay of 0 (no delay since phy-mode = "rgmii-rxid")
> 
> with rxid mode, why is the rx_delay needed at all?
> Shouldn't this just work without the property?

In theory yes, but with the property missing, you'll get a warning
message in dmesg which says:

	Can not read property: rx_delay.
	Set rx_delay to 0x10

So it will set the rx_delay to a value which is not 0, even if rxid
mode is selected. I guess this is something which can be fixed in the
driver, but that may be beyond my abilities.
Setting the rx_delay to 0 gets rid of this warning, so it seems to
be a viable workaround.

>> * rgmii_phy1: Add phy-supply as seen in schematics
> 
> separate patch
> 
>> * pcie2*:
>>      - Add pinctrl reset pins
>>      - Update vpcie3v3-supply to match the schematics
> 
> separate patch
> 
>> * sdhci: Add vmmc-supply and vqmmc-supply
> 
> separate patch
> 

Thanks,
Sebastian



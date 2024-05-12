Return-Path: <linux-kernel+bounces-176981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4708C3816
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 21:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC361C21331
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 19:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFE15028A;
	Sun, 12 May 2024 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="k6xk3aN1"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA855102E;
	Sun, 12 May 2024 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715540855; cv=none; b=q5Cj0KuEQLp4NM8qgO1O2VZCCfeDFstTWU5FU4b2PeyDa318X/HvTxptUYKOLdJ9RM6rlwDaAYz+Ab6vafOst608+8bhYx5jnGHHaMsqb5acDP4aKhPA/TIhNDxAv5Ndu9/Z+C8pkOxDHM887XsG5IUGB/lJQgv5Z1qDXt7Bq2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715540855; c=relaxed/simple;
	bh=to6jmO+EBhSNRP4yMtY2wwECbwS2E9PNoQd42aJjGrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VkCXVYuxQViRc5IW0eaey3juM5koLdTJza+3bz88m7UAAsM7W5Z3vaRlcFgGqPstmIUiKFoinOick9MCuCjzwaZVCaP7KaREr6ZKxRF8zreBPTBDYaF3TNX6OPXF1ALS9VYNzDAts2vO4bj+VFPiNaMoC+5PQjTqA8uCc1NPifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=k6xk3aN1; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 84E37120003;
	Sun, 12 May 2024 22:07:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 84E37120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715540845;
	bh=2rLH5TzP+km5UCLaOhbG3t3/0duKaiLCAy3iw53i790=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=k6xk3aN1sH9YnprLNrA0TrGzy+pVwxtShIrPAHyKUyGn5V7eBIURawthug715H4O8
	 8bzbaLRl3JXui/ROukePFD3A/QHqUOIYGwhLbogg+gXGZ//ngX4gkghaWjP7YlONAr
	 1FB+O2eSxFUGUfbZl8D2oTdVkAlEMTrKzJZK/drYvPP8YWDRPiOAVfMGbLyLPnj/cS
	 TgnSI00sivc8BHlr/+L0uVgbTCQmc9R8xYJ0/2j67w7RwN/kB4pZ1jKOE4wYHbnxE2
	 I2ptCygTTK9xfyNm7rpXTjV7BL+ve0n6qsSLP5rq8a1QbDLR8lMq6MIHVLlT8pvu5Y
	 yphCnkiyFOg0A==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun, 12 May 2024 22:07:25 +0300 (MSK)
Received: from [172.28.66.92] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 12 May 2024 22:07:24 +0300
Message-ID: <3fa610c2-1f69-41d4-b06a-035980483b3c@salutedevices.com>
Date: Sun, 12 May 2024 22:06:23 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [APPROACH 2 1/2] arm64: dts: amlogic: list all slave clocks for
 audio clock controller
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Jerome
 Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Michael Turquette
	<mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>
References: <20240508144259.191843-1-jan.dakinevich@salutedevices.com>
 <20240508144259.191843-3-jan.dakinevich@salutedevices.com>
 <20240508175013.GA2244257-robh@kernel.org>
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <20240508175013.GA2244257-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185167 [May 11 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/12 16:13:00 #25178084
X-KSMG-AntiVirus-Status: Clean, skipped



On 5/8/24 20:50, Rob Herring wrote:
> On Wed, May 08, 2024 at 05:42:58PM +0300, Jan Dakinevich wrote:
>> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 27 ++++++++++++++++++++--
>>  arch/arm64/boot/dts/amlogic/meson-g12.dtsi | 26 +++++++++++++++++++--
>>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 26 +++++++++++++++++++--
>>  3 files changed, 73 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> index 6d12b760b90f..28f4ec5f39b0 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> @@ -1342,7 +1342,9 @@ clkc_audio: clock-controller@0 {
>>  					 <&clkc CLKID_HIFI_PLL>,
>>  					 <&clkc CLKID_FCLK_DIV3>,
>>  					 <&clkc CLKID_FCLK_DIV4>,
>> -					 <&clkc CLKID_GP0_PLL>;
>> +					 <&clkc CLKID_GP0_PLL>,
>> +					 <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>,
>> +					 <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>;
> 
> All 3 cases are just unused clocks on the end. I suppose that's not 
> always the case. You could just set 'minItems' in the binding to 
> avoid needing to pad the end and the dts changes.
> 

You are right. I mistakenly thought that 'minItems' can not be
redefined. But not, it is allowed to redefine it and it works. Thus,
this patch is not needed for this approach.

Anyway, what do you think about first approach? As for me, it is more
simple and readable.

> Rob

-- 
Best regards
Jan Dakinevich


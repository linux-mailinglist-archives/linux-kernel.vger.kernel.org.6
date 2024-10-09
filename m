Return-Path: <linux-kernel+bounces-356575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC85996389
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12141C2144A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D4618871D;
	Wed,  9 Oct 2024 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="t5W20TBR"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFFD18A6A3;
	Wed,  9 Oct 2024 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463177; cv=none; b=ooRnmEfzmG7ug4YzL4JicP9TwQiewUT1OPgTJQK6vfp6VI7mRDiPZPTp/r8y0zPAMG37hcTnOuR55JeWzKmagY3q++9aG96a/3Bc90z7SlUCv9v23g2cXzfm7I2leSl73D4lJDtLLcUJz0MkJnA9OqebahRvBVp7NCVOQp6R5lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463177; c=relaxed/simple;
	bh=dSbta17hSoAG7yd4UayGUHCC1Bkg/IBUtpzJ5u/8oBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XurXd396yd59H1rNKq7cIkwvhuUxeH3nc1TYC48M55/N2llEiKdQqV1F8fjWb6MFXl5qV2Moju/CwxyA58V8Npag48ofmQuzvSaOOMPD64Rssj6n5rBaO9H/pbjGvkKkWykUG0jKDJPhC9DYh/a96UPHc/1pz8loPKPELl14/QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=t5W20TBR; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 001a3916861a11ef88ecadb115cee93b-20241009
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=vn8tEkGuRtMHF0tlfEZ8QyLNGegxpb21cpoM4gTfZRI=;
	b=t5W20TBR4Bs0NOmarixuKBTt5N/bD/VpG0DQjOfOmawGgL5SSOtF7Dxv2CpLC8fuDAGc21fdbCuKBnQJ0YKIUO9AlTrtc+YpLa0TD6p+q4EuHDg8MNki9jese+uIjILEQBkEBOuhRda0fQ6uXGso6pb3RsEINW26QObtW3qkseg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:8e41a18c-e275-4304-b881-602f6cd4a15d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:b1688726-5902-4533-af4f-d0904aa89b3c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 001a3916861a11ef88ecadb115cee93b-20241009
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1674189266; Wed, 09 Oct 2024 16:39:30 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 9 Oct 2024 16:39:28 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 9 Oct 2024 16:39:28 +0800
Message-ID: <95e29964-8932-19cb-f812-db516e90b889@mediatek.com>
Date: Wed, 9 Oct 2024 16:39:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: mt8390-genio-700-evk: add
 keys and USB HUB
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Alexandre Mergnat <amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>, "Chris-qj
 chen" <chris-qj.chen@mediatek.com>, MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
References: <20241007090244.1731-1-macpaul.lin@mediatek.com>
 <20241007090244.1731-2-macpaul.lin@mediatek.com>
 <8cdce399-1f42-4558-9cdb-c36b96205212@collabora.com>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <8cdce399-1f42-4558-9cdb-c36b96205212@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.507200-8.000000
X-TMASE-MatchedRID: 1GZI+iG+MtcNtKv7cnNXnSa1MaKuob8PofZV/2Xa0cLBs8kDsMW7w9j3
	ZmXrgmMgjwYPH9x94AlRJr0x5pq5roNNUcsMbelEbBu6+EIezdwXGEjE96ler99RlPzeVuQQlwW
	f7/4SyDulL6ml/horeewFAXG5XM8DyU5XnWcIgDPhuXUWQoMQt77VXHusOfivFLXUWU5hGiH8Z6
	9+gfjbulzsna8FWSVpW1nyZ73XgFcaAgQzCMe24Qs9VkfCh3uAQKuv8uQBDjohvFjBsLEZNNfpf
	O5YhTb3EGriuommA29Uz7QIBqLdbduz/TmKWd6abajVAc2DKqa4hAMe708bDhPuWwH3mlrqA5He
	1kDS+OLnzlXMYw4XMAGLeSok4rrZC24oEZ6SpSkj80Za3RRg8OTE7AvI+717DsePfxQaxS5tDwQ
	X/T3LMgsQeNnCo+C/oloOgBiKq/U=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.507200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 0CEDD76DD3F0A1570982FFD2F507549A12C2E622B9C4CAD2B27D6E2F7E860BA42000:8



On 10/8/24 16:20, AngeloGioacchino Del Regno wrote:
> Il 07/10/24 11:02, Macpaul Lin ha scritto:
>> 1. Add i2c, mmc to aliases.
>> 4. Add PMIC_KEY setting.
>> 5. Add USB HUB TUSB8020 to xhci1.
>> 6. Re-order spi2 node.
> 
> Please either add the aliases in a different commit, or add that to the 
> title.
> 
> arm64: dts: mediatek: mt8390-genio-700-evk: Add aliases, keys and USB HUB
> 
> Additionally, I'd really like to see a "conversation-like" description 
> instead
> of a kind-of-checkbox list.
> 
> Something like..
> 
> "
> Add aliases for the I2C and MMC/SD controllers to keep the numbering 
> consistent and
> describe the TUSB8020 hub present on the USB XHCI1 controller instance 
> to enable
> resetting it with its specific reset GPIO.
> 
> While at it, also move the spi2 node to keep nodes alphabetically ordered.
> "

Okay, Sorry for providing incorrect order of modified and added items.
I'll update in the next patch.

>>
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> ---
>>   .../dts/mediatek/mt8390-genio-700-evk.dts     | 57 +++++++++++++++----
>>   1 file changed, 47 insertions(+), 10 deletions(-)
>>
>> Changes for v2:
>>   - Fix order of spi2.
>>   - Update pinctrl in i2c4 and rt1715.
>>   - Drop IT5205 and RT1715 nodes since the DTS are not completed yet.
>>   - Add #address-cells and #size-cells to xhci1 for supporting USB hubs.
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts 
>> b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
>> index 96b272567cb1..3e77f59f2c74 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
>> @@ -23,6 +23,15 @@ / {
>>                "mediatek,mt8188";
>>       aliases {
>> +        i2c0 = &i2c0;
>> +        i2c1 = &i2c1;
>> +        i2c2 = &i2c2;
>> +        i2c3 = &i2c3;
>> +        i2c4 = &i2c4;
>> +        i2c5 = &i2c5;
>> +        i2c6 = &i2c6;
>> +        mmc0 = &mmc0;
>> +        mmc1 = &mmc1;
>>           serial0 = &uart0;
>>       };
>> @@ -249,7 +258,6 @@ &i2c3 {
>>   &i2c4 {
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&i2c4_pins>;
>> -    pinctrl-1 = <&rt1715_int_pins>;
> 
> What is this extra change?
> Please describe it in the commit description.

okay, I'll fix this.

>>       clock-frequency = <1000000>;
>>       status = "okay";
>>   };
>> @@ -867,6 +875,17 @@ pins-wifi-enable {
>>   &pmic {
>>       interrupt-parent = <&pio>;
>>       interrupts = <222 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +    mt6359keys: keys {
> 
> Is there any reason why we can't just put this node in mt6359.dtsi?

That's a good point.
I think I can try to add this in a separate patch for mt6359.dtsi.

> Cheers,
> Angelo
> 
>> +        compatible = "mediatek,mt6359-keys";
>> +        mediatek,long-press-mode = <1>;
>> +        power-off-time-sec = <0>;
>> +
>> +        power-key {
>> +            linux,keycodes = <KEY_POWER>;
>> +            wakeup-source;
>> +        };
>> +    };
>>   };
>>   &scp {
>> @@ -874,6 +893,15 @@ &scp {
>>       status = "okay";
>>   };
>> +&spi2 {
>> +    pinctrl-0 = <&spi2_pins>;
>> +    pinctrl-names = "default";
>> +    mediatek,pad-select = <0>;
>> +    #address-cells = <1>;
>> +    #size-cells = <0>;
>> +    status = "okay";
>> +};
>> +
>>   &uart0 {
>>       pinctrl-0 = <&uart0_pins>;
>>       pinctrl-names = "default";
>> @@ -892,15 +920,6 @@ &uart2 {
>>       status = "okay";
>>   };
>> -&spi2 {
>> -    pinctrl-0 = <&spi2_pins>;
>> -    pinctrl-names = "default";
>> -    mediatek,pad-select = <0>;
>> -    #address-cells = <1>;
>> -    #size-cells = <0>;
>> -    status = "okay";
>> -};
>> -
>>   &u3phy0 {
>>       status = "okay";
>>   };
>> @@ -921,6 +940,24 @@ &xhci0 {
>>   &xhci1 {
>>       status = "okay";
>>       vusb33-supply = <&mt6359_vusb_ldo_reg>;
>> +    #address-cells = <1>;
>> +    #size-cells = <0>;
>> +
>> +    hub_2_0: hub@1 {
>> +        compatible = "usb451,8025";
>> +        reg = <1>;
>> +        peer-hub = <&hub_3_0>;
>> +        reset-gpios = <&pio 7 GPIO_ACTIVE_HIGH>;
>> +        vdd-supply = <&usb_hub_fixed_3v3>;
>> +    };
>> +
>> +    hub_3_0: hub@2 {
>> +        compatible = "usb451,8027";
>> +        reg = <2>;
>> +        peer-hub = <&hub_2_0>;
>> +        reset-gpios = <&pio 7 GPIO_ACTIVE_HIGH>;
>> +        vdd-supply = <&usb_hub_fixed_3v3>;
>> +    };
>>   };
>>   &xhci2 {
> 

Thanks
Macpaul Lin


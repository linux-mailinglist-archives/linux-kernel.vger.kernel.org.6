Return-Path: <linux-kernel+bounces-187261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380508CCF23
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2BD2840C5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE1413D24C;
	Thu, 23 May 2024 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="PufRdOOz"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0EC4F8BB;
	Thu, 23 May 2024 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456382; cv=none; b=Y6lX/2r631lcynOKMMXe9XiQl0W35yeitzP3RUxvDGLtOSb5VqLLrr9FA143bbzyW+HfG/a1WVtdLv4RDCI206UAASNUeWZm/D7e34ZXB6eLvEd24o7CC3l8nf0Ym9JEDNJex1FZLJoM0wIKYJYj7YyObhkN89BOJA2aBmCAMTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456382; c=relaxed/simple;
	bh=mZIvFW1R655YiHIs3pL1O2UbrsipmjSZNLSK4Z+cg3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mfUNJ92gYXLrd5/a2G+SSoziD55WkSF0LSO7Z7HbuUdAza2G2p1xkJJFxiAOkYTadSxJ1vKkdoH176S42sT5HVKdZd/ByvbYYs+RheQpU8MN0Rcg0NjAcAg7gqssOESSZ/ALjvEb7+N1klR4f2SVWF4P3C8h/PTbvWaSXPA1P7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=PufRdOOz; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 16C9512000B;
	Thu, 23 May 2024 12:26:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 16C9512000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1716456367;
	bh=gHUqcjWp2xIyO52p4qTY5VyeM3URmg3fyC25O04Zm8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=PufRdOOzVVltHs65jFqxAGESyJ0g57PyDpQGJv6yfkvjr09MOGS9bZSDS3FGOlfd/
	 Zt+JVkjFhTvPZpDQyDHpHKqlnFnpEBMAnYL/IOYRCH3Z6yE0XimL4pxejg9TbR7TD4
	 s1WX8NAbhpG6PC9QU/fivAwzYaxpWe3KMhQjswFeO4n2iQPf0PaseT7cp0gqxD/+3z
	 IoqAFyF7zVcAUkXqySoJMBbzpKeAkVAWkusUymJc12x2r8sfckhmkFXA9erb8s7fSZ
	 +BGUOr24o1OakxuNFxSk2tBQ8IZOLSuQJcRg5ex6+SNKhNCQCseyvHQGKc4/yhqTsc
	 ORmitbmcqITpg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 23 May 2024 12:26:06 +0300 (MSK)
Received: from [172.28.225.118] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 23 May 2024 12:26:06 +0300
Message-ID: <f2a491d1-17ac-4bfc-a21b-895fffc38d97@salutedevices.com>
Date: Thu, 23 May 2024 12:25:00 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arch/arm64: dts: ac2xx: make common the sound card
Content-Language: en-US
To: <neil.armstrong@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, Dmitry Rokosov <ddrokosov@sberdevices.ru>,
	Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Lucas Tanure <tanure@linux.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Rob Herring
	<robh@kernel.org>, Xianwei Zhao <xianwei.zhao@amlogic.com>
References: <20240521222155.28094-1-jan.dakinevich@salutedevices.com>
 <20240521222155.28094-2-jan.dakinevich@salutedevices.com>
 <447ed20b-a505-4758-9351-522fd12049f6@linaro.org>
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <447ed20b-a505-4758-9351-522fd12049f6@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185436 [May 23 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;sberdevices.ru:5.0.1,7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/23 07:54:00 #25244744
X-KSMG-AntiVirus-Status: Clean, skipped



On 5/23/24 10:36, Neil Armstrong wrote:
> On 22/05/2024 00:21, Jan Dakinevich wrote:
>> The declaration of sound card and its dependencies is identical in all
>> consumers of 'meson-sm1-ac2xx.dtsi'.
>>
>> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>> ---
>>   .../dts/amlogic/meson-sm1-a95xf3-air-gbit.dts | 87 -------------------
>>   .../boot/dts/amlogic/meson-sm1-a95xf3-air.dts | 87 -------------------
>>   .../boot/dts/amlogic/meson-sm1-ac2xx.dtsi     | 87 +++++++++++++++++++
>>   .../boot/dts/amlogic/meson-sm1-h96-max.dts    | 87 -------------------
>>   .../dts/amlogic/meson-sm1-x96-air-gbit.dts    | 87 -------------------
>>   .../boot/dts/amlogic/meson-sm1-x96-air.dts    | 87 -------------------
>>   6 files changed, 87 insertions(+), 435 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts
>> b/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts
>> index 9b2eb6e42651..90ae38c30592 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts
>> @@ -7,73 +7,10 @@
>>   /dts-v1/;
>>     #include "meson-sm1-ac2xx.dtsi"
>> -#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>>     / {
>>       compatible = "cyx,a95xf3-air-gbit", "amlogic,sm1";
>>       model = "Shenzhen CYX Industrial Co., Ltd A95XF3-AIR";
>> -
>> -    sound {
>> -        compatible = "amlogic,axg-sound-card";
>> -        model = "A95XF3-AIR";
> 
> model should be board-specific, as for sound node because dev board
> variants can be different, so I don't thing moving sound to a common
> dtsi is a good thing.
> 

Ok, I can redefine the model for each board.

>> -        audio-aux-devs = <&tdmout_b>;
>> -        audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
>> -                "TDMOUT_B IN 1", "FRDDR_B OUT 1",
>> -                "TDMOUT_B IN 2", "FRDDR_C OUT 1",
>> -                "TDM_B Playback", "TDMOUT_B OUT";
>> -
>> -        assigned-clocks = <&clkc CLKID_MPLL2>,
>> -                  <&clkc CLKID_MPLL0>,
>> -                  <&clkc CLKID_MPLL1>;
>> -        assigned-clock-parents = <0>, <0>, <0>;
>> -        assigned-clock-rates = <294912000>,
>> -                       <270950400>,
>> -                       <393216000>;
>> -
>> -        dai-link-0 {
>> -            sound-dai = <&frddr_a>;
>> -        };
>> -
>> -        dai-link-1 {
>> -            sound-dai = <&frddr_b>;
>> -        };
>> -
>> -        dai-link-2 {
>> -            sound-dai = <&frddr_c>;
>> -        };
>> -
>> -        /* 8ch hdmi interface */
>> -        dai-link-3 {
>> -            sound-dai = <&tdmif_b>;
>> -            dai-format = "i2s";
>> -            dai-tdm-slot-tx-mask-0 = <1 1>;
>> -            dai-tdm-slot-tx-mask-1 = <1 1>;
>> -            dai-tdm-slot-tx-mask-2 = <1 1>;
>> -            dai-tdm-slot-tx-mask-3 = <1 1>;
>> -            mclk-fs = <256>;
>> -
>> -            codec {
>> -                sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
>> -            };
>> -        };
>> -
>> -        /* hdmi glue */
>> -        dai-link-4 {
>> -            sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
>> -
>> -            codec {
>> -                sound-dai = <&hdmi_tx>;
>> -            };
>> -        };
>> -    };
>> -};
>> -
>> -&arb {
>> -    status = "okay";
>> -};
>> -
>> -&clkc_audio {
>> -    status = "okay";
>>   };
>>     &ethmac {
>> @@ -102,27 +39,3 @@ external_phy: ethernet-phy@0 {
>>           interrupts = <IRQID_GPIOZ_14 IRQ_TYPE_LEVEL_LOW>;
>>       };
>>   };
>> -
>> -&frddr_a {
>> -    status = "okay";
>> -};
>> -
>> -&frddr_b {
>> -    status = "okay";
>> -};
>> -
>> -&frddr_c {
>> -    status = "okay";
>> -};
>> -
>> -&tdmif_b {
>> -    status = "okay";
>> -};
>> -
>> -&tdmout_b {
>> -    status = "okay";
>> -};
>> -
>> -&tohdmitx {
>> -    status = "okay";
>> -};
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dts
>> b/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dts
>> index 6e34fd80ed71..c74ce9c246fa 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dts
>> @@ -7,73 +7,10 @@
>>   /dts-v1/;
>>     #include "meson-sm1-ac2xx.dtsi"
>> -#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>>     / {
>>       compatible = "cyx,a95xf3-air", "amlogic,sm1";
>>       model = "Shenzhen CYX Industrial Co., Ltd A95XF3-AIR";
>> -
>> -    sound {
>> -        compatible = "amlogic,axg-sound-card";
>> -        model = "A95XF3-AIR";
>> -        audio-aux-devs = <&tdmout_b>;
>> -        audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
>> -                "TDMOUT_B IN 1", "FRDDR_B OUT 1",
>> -                "TDMOUT_B IN 2", "FRDDR_C OUT 1",
>> -                "TDM_B Playback", "TDMOUT_B OUT";
>> -
>> -        assigned-clocks = <&clkc CLKID_MPLL2>,
>> -                  <&clkc CLKID_MPLL0>,
>> -                  <&clkc CLKID_MPLL1>;
>> -        assigned-clock-parents = <0>, <0>, <0>;
>> -        assigned-clock-rates = <294912000>,
>> -                       <270950400>,
>> -                       <393216000>;
>> -
>> -        dai-link-0 {
>> -            sound-dai = <&frddr_a>;
>> -        };
>> -
>> -        dai-link-1 {
>> -            sound-dai = <&frddr_b>;
>> -        };
>> -
>> -        dai-link-2 {
>> -            sound-dai = <&frddr_c>;
>> -        };
>> -
>> -        /* 8ch hdmi interface */
>> -        dai-link-3 {
>> -            sound-dai = <&tdmif_b>;
>> -            dai-format = "i2s";
>> -            dai-tdm-slot-tx-mask-0 = <1 1>;
>> -            dai-tdm-slot-tx-mask-1 = <1 1>;
>> -            dai-tdm-slot-tx-mask-2 = <1 1>;
>> -            dai-tdm-slot-tx-mask-3 = <1 1>;
>> -            mclk-fs = <256>;
>> -
>> -            codec {
>> -                sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
>> -            };
>> -        };
>> -
>> -        /* hdmi glue */
>> -        dai-link-4 {
>> -            sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
>> -
>> -            codec {
>> -                sound-dai = <&hdmi_tx>;
>> -            };
>> -        };
>> -    };
>> -};
>> -
>> -&arb {
>> -    status = "okay";
>> -};
>> -
>> -&clkc_audio {
>> -    status = "okay";
>>   };
>>     &ethmac {
>> @@ -81,27 +18,3 @@ &ethmac {
>>       phy-handle = <&internal_ephy>;
>>       phy-mode = "rmii";
>>   };
>> -
>> -&frddr_a {
>> -    status = "okay";
>> -};
>> -
>> -&frddr_b {
>> -    status = "okay";
>> -};
>> -
>> -&frddr_c {
>> -    status = "okay";
>> -};
>> -
>> -&tdmif_b {
>> -    status = "okay";
>> -};
>> -
>> -&tdmout_b {
>> -    status = "okay";
>> -};
>> -
>> -&tohdmitx {
>> -    status = "okay";
>> -};
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi
>> b/arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi
>> index d1fa8b8bf795..7b20a8ff3dfb 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi
>> @@ -12,6 +12,7 @@
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/gpio/meson-g12a-gpio.h>
>>   #include <dt-bindings/input/input.h>
>> +#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>>     / {
>>       aliases {
>> @@ -127,6 +128,60 @@ wifi32k: wifi32k {
>>           clock-frequency = <32768>;
>>           pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
>>       };
>> +
>> +    sound {
>> +        compatible = "amlogic,axg-sound-card";
>> +        model = "AC2XX";
>> +        audio-aux-devs = <&tdmout_b>;
>> +        audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
>> +                "TDMOUT_B IN 1", "FRDDR_B OUT 1",
>> +                "TDMOUT_B IN 2", "FRDDR_C OUT 1",
>> +                "TDM_B Playback", "TDMOUT_B OUT";
>> +
>> +        assigned-clocks = <&clkc CLKID_MPLL2>,
>> +                  <&clkc CLKID_MPLL0>,
>> +                  <&clkc CLKID_MPLL1>;
>> +        assigned-clock-parents = <0>, <0>, <0>;
>> +        assigned-clock-rates = <294912000>,
>> +                       <270950400>,
>> +                       <393216000>;
>> +
>> +        dai-link-0 {
>> +            sound-dai = <&frddr_a>;
>> +        };
>> +
>> +        dai-link-1 {
>> +            sound-dai = <&frddr_b>;
>> +        };
>> +
>> +        dai-link-2 {
>> +            sound-dai = <&frddr_c>;
>> +        };
>> +
>> +        /* 8ch hdmi interface */
>> +        dai-link-3 {
>> +            sound-dai = <&tdmif_b>;
>> +            dai-format = "i2s";
>> +            dai-tdm-slot-tx-mask-0 = <1 1>;
>> +            dai-tdm-slot-tx-mask-1 = <1 1>;
>> +            dai-tdm-slot-tx-mask-2 = <1 1>;
>> +            dai-tdm-slot-tx-mask-3 = <1 1>;
>> +            mclk-fs = <256>;
>> +
>> +            codec {
>> +                sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
>> +            };
>> +        };
>> +
>> +        /* hdmi glue */
>> +        dai-link-4 {
>> +            sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
>> +
>> +            codec {
>> +                sound-dai = <&hdmi_tx>;
>> +            };
>> +        };
>> +    };
>>   };
>>     &cec_AO {
>> @@ -298,3 +353,35 @@ &usb {
>>       status = "okay";
>>       dr_mode = "otg";
>>   };
>> +
>> +&clkc_audio {
>> +    status = "okay";
>> +};
>> +
>> +&arb {
>> +    status = "okay";
>> +};
>> +
>> +&frddr_a {
>> +    status = "okay";
>> +};
>> +
>> +&frddr_b {
>> +    status = "okay";
>> +};
>> +
>> +&frddr_c {
>> +    status = "okay";
>> +};
>> +
>> +&tdmif_b {
>> +    status = "okay";
>> +};
>> +
>> +&tdmout_b {
>> +    status = "okay";
>> +};
>> +
>> +&tohdmitx {
>> +    status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
>> b/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
>> index e6e9410d40cb..a4800488b161 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
>> @@ -7,73 +7,10 @@
>>   /dts-v1/;
>>     #include "meson-sm1-ac2xx.dtsi"
>> -#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>>     / {
>>       compatible = "haochuangyi,h96-max", "amlogic,sm1";
>>       model = "Shenzhen Haochuangyi Technology Co., Ltd H96 Max";
>> -
>> -    sound {
>> -        compatible = "amlogic,axg-sound-card";
>> -        model = "H96-MAX";
>> -        audio-aux-devs = <&tdmout_b>;
>> -        audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
>> -                "TDMOUT_B IN 1", "FRDDR_B OUT 1",
>> -                "TDMOUT_B IN 2", "FRDDR_C OUT 1",
>> -                "TDM_B Playback", "TDMOUT_B OUT";
>> -
>> -        assigned-clocks = <&clkc CLKID_MPLL2>,
>> -                  <&clkc CLKID_MPLL0>,
>> -                  <&clkc CLKID_MPLL1>;
>> -        assigned-clock-parents = <0>, <0>, <0>;
>> -        assigned-clock-rates = <294912000>,
>> -                       <270950400>,
>> -                       <393216000>;
>> -
>> -        dai-link-0 {
>> -            sound-dai = <&frddr_a>;
>> -        };
>> -
>> -        dai-link-1 {
>> -            sound-dai = <&frddr_b>;
>> -        };
>> -
>> -        dai-link-2 {
>> -            sound-dai = <&frddr_c>;
>> -        };
>> -
>> -        /* 8ch hdmi interface */
>> -        dai-link-3 {
>> -            sound-dai = <&tdmif_b>;
>> -            dai-format = "i2s";
>> -            dai-tdm-slot-tx-mask-0 = <1 1>;
>> -            dai-tdm-slot-tx-mask-1 = <1 1>;
>> -            dai-tdm-slot-tx-mask-2 = <1 1>;
>> -            dai-tdm-slot-tx-mask-3 = <1 1>;
>> -            mclk-fs = <256>;
>> -
>> -            codec {
>> -                sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
>> -            };
>> -        };
>> -
>> -        /* hdmi glue */
>> -        dai-link-4 {
>> -            sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
>> -
>> -            codec {
>> -                sound-dai = <&hdmi_tx>;
>> -            };
>> -        };
>> -    };
>> -};
>> -
>> -&arb {
>> -    status = "okay";
>> -};
>> -
>> -&clkc_audio {
>> -    status = "okay";
>>   };
>>     &ethmac {
>> @@ -103,30 +40,6 @@ external_phy: ethernet-phy@0 {
>>       };
>>   };
>>   -&frddr_a {
>> -    status = "okay";
>> -};
>> -
>> -&frddr_b {
>> -    status = "okay";
>> -};
>> -
>> -&frddr_c {
>> -    status = "okay";
>> -};
>> -
>> -&tdmif_b {
>> -    status = "okay";
>> -};
>> -
>> -&tdmout_b {
>> -    status = "okay";
>> -};
>> -
>> -&tohdmitx {
>> -    status = "okay";
>> -};
>> -
>>   &uart_A {
>>       status = "okay";
>>   diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
>> b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
>> index fc9b961133cd..dbd8625285b6 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
>> @@ -7,73 +7,10 @@
>>   /dts-v1/;
>>     #include "meson-sm1-ac2xx.dtsi"
>> -#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>>     / {
>>       compatible = "amediatech,x96-air-gbit", "amlogic,sm1";
>>       model = "Shenzhen Amediatech Technology Co., Ltd X96 Air";
>> -
>> -    sound {
>> -        compatible = "amlogic,axg-sound-card";
>> -        model = "X96-AIR";
>> -        audio-aux-devs = <&tdmout_b>;
>> -        audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
>> -                "TDMOUT_B IN 1", "FRDDR_B OUT 1",
>> -                "TDMOUT_B IN 2", "FRDDR_C OUT 1",
>> -                "TDM_B Playback", "TDMOUT_B OUT";
>> -
>> -        assigned-clocks = <&clkc CLKID_MPLL2>,
>> -                  <&clkc CLKID_MPLL0>,
>> -                  <&clkc CLKID_MPLL1>;
>> -        assigned-clock-parents = <0>, <0>, <0>;
>> -        assigned-clock-rates = <294912000>,
>> -                       <270950400>,
>> -                       <393216000>;
>> -
>> -        dai-link-0 {
>> -            sound-dai = <&frddr_a>;
>> -        };
>> -
>> -        dai-link-1 {
>> -            sound-dai = <&frddr_b>;
>> -        };
>> -
>> -        dai-link-2 {
>> -            sound-dai = <&frddr_c>;
>> -        };
>> -
>> -        /* 8ch hdmi interface */
>> -        dai-link-3 {
>> -            sound-dai = <&tdmif_b>;
>> -            dai-format = "i2s";
>> -            dai-tdm-slot-tx-mask-0 = <1 1>;
>> -            dai-tdm-slot-tx-mask-1 = <1 1>;
>> -            dai-tdm-slot-tx-mask-2 = <1 1>;
>> -            dai-tdm-slot-tx-mask-3 = <1 1>;
>> -            mclk-fs = <256>;
>> -
>> -            codec {
>> -                sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
>> -            };
>> -        };
>> -
>> -        /* hdmi glue */
>> -        dai-link-4 {
>> -            sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
>> -
>> -            codec {
>> -                sound-dai = <&hdmi_tx>;
>> -            };
>> -        };
>> -    };
>> -};
>> -
>> -&arb {
>> -    status = "okay";
>> -};
>> -
>> -&clkc_audio {
>> -    status = "okay";
>>   };
>>     &ethmac {
>> @@ -103,30 +40,6 @@ external_phy: ethernet-phy@0 {
>>       };
>>   };
>>   -&frddr_a {
>> -    status = "okay";
>> -};
>> -
>> -&frddr_b {
>> -    status = "okay";
>> -};
>> -
>> -&frddr_c {
>> -    status = "okay";
>> -};
>> -
>>   &ir {
>>       linux,rc-map-name = "rc-x96max";
>>   };
>> -
>> -&tdmif_b {
>> -    status = "okay";
>> -};
>> -
>> -&tdmout_b {
>> -    status = "okay";
>> -};
>> -
>> -&tohdmitx {
>> -    status = "okay";
>> -};
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts
>> b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts
>> index 9ea969255b4f..3b2df25ca630 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts
>> @@ -7,73 +7,10 @@
>>   /dts-v1/;
>>     #include "meson-sm1-ac2xx.dtsi"
>> -#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>>     / {
>>       compatible = "amediatech,x96-air", "amlogic,sm1";
>>       model = "Shenzhen Amediatech Technology Co., Ltd X96 Air";
>> -
>> -    sound {
>> -        compatible = "amlogic,axg-sound-card";
>> -        model = "X96-AIR";
>> -        audio-aux-devs = <&tdmout_b>;
>> -        audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
>> -                "TDMOUT_B IN 1", "FRDDR_B OUT 1",
>> -                "TDMOUT_B IN 2", "FRDDR_C OUT 1",
>> -                "TDM_B Playback", "TDMOUT_B OUT";
>> -
>> -        assigned-clocks = <&clkc CLKID_MPLL2>,
>> -                  <&clkc CLKID_MPLL0>,
>> -                  <&clkc CLKID_MPLL1>;
>> -        assigned-clock-parents = <0>, <0>, <0>;
>> -        assigned-clock-rates = <294912000>,
>> -                       <270950400>,
>> -                       <393216000>;
>> -
>> -        dai-link-0 {
>> -            sound-dai = <&frddr_a>;
>> -        };
>> -
>> -        dai-link-1 {
>> -            sound-dai = <&frddr_b>;
>> -        };
>> -
>> -        dai-link-2 {
>> -            sound-dai = <&frddr_c>;
>> -        };
>> -
>> -        /* 8ch hdmi interface */
>> -        dai-link-3 {
>> -            sound-dai = <&tdmif_b>;
>> -            dai-format = "i2s";
>> -            dai-tdm-slot-tx-mask-0 = <1 1>;
>> -            dai-tdm-slot-tx-mask-1 = <1 1>;
>> -            dai-tdm-slot-tx-mask-2 = <1 1>;
>> -            dai-tdm-slot-tx-mask-3 = <1 1>;
>> -            mclk-fs = <256>;
>> -
>> -            codec {
>> -                sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
>> -            };
>> -        };
>> -
>> -        /* hdmi glue */
>> -        dai-link-4 {
>> -            sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
>> -
>> -            codec {
>> -                sound-dai = <&hdmi_tx>;
>> -            };
>> -        };
>> -    };
>> -};
>> -
>> -&arb {
>> -    status = "okay";
>> -};
>> -
>> -&clkc_audio {
>> -    status = "okay";
>>   };
>>     &ethmac {
>> @@ -81,31 +18,7 @@ &ethmac {
>>       phy-handle = <&internal_ephy>;
>>       phy-mode = "rmii";
>>   };
>> -
>> -&frddr_a {
>> -    status = "okay";
>> -};
>> -
>> -&frddr_b {
>> -    status = "okay";
>> -};
>> -
>> -&frddr_c {
>> -    status = "okay";
>> -};
>> -
>>   &ir {
>>       linux,rc-map-name = "rc-beelink-gs1";
>>   };
>>   -&tdmif_b {
>> -    status = "okay";
>> -};
>> -
>> -&tdmout_b {
>> -    status = "okay";
>> -};
>> -
>> -&tohdmitx {
>> -    status = "okay";
>> -};
> 

-- 
Best regards
Jan Dakinevich


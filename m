Return-Path: <linux-kernel+bounces-177447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECE08C3EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7970FB21326
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C3314A0AD;
	Mon, 13 May 2024 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="uD2yM309"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7118146D76;
	Mon, 13 May 2024 10:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595692; cv=none; b=j+kVkTJ91VvaCH3FwdNESGPLoIeyFaNrbDRKOGmiIdQx2m88JLfImGS73m3Jzgti8/ktVnir7FcQcTPaerwoxRgJZNPT5QKcz2nZbr9ABScyNnOYW8+XEaOgZsovM/ca4U7nG6IvgaHPOGZkFiG8KvGdfEWTWTXN2uc6xQaF6I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595692; c=relaxed/simple;
	bh=1mT/poC6eK9uofrKRt10Sk8hkBcaVE5MPWLJMvDEFR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CHoWF1e0XiUxCMhUP+8qtDFaErAD4rN1oX8uFLYMfnvh8tM2bHfBd2GuztIkGciHaWISTZr+XxfsPLYp5u96b1gO0lIxin//jirQeSckTd1MQKBgrT/1NNdIj542f+rkHMY7JgYe4C4jxqs8m/Nq6dCjdvSkaBfw8uPNbkK5Goc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=uD2yM309; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8E12312000D;
	Mon, 13 May 2024 13:21:23 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8E12312000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715595683;
	bh=Gn/Rt6hFwjiHJvNZkbzYpga0+RVCKD7S0ie1DFPi/Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=uD2yM309DjHBMvvSLX6ucXCb1X7jDB8wC9PvGMBURZe1L5sLyPHqmIdm+dmjbWvKf
	 v9c16sZZsAVNr3kIRxt2uEGhMH96MqAl9frkYtRcdEx4Wfvojh+XkMYpiRTSfLDJNo
	 6uqOIeAwB6nmeipYaz73EgfKfcMESIHMhrtWOyYwye8lGQwLso5JvZjCYQHm2syqCo
	 OejucoNWCsXZyvUS7qCOjS3pMK+mEsPktLpAKGcRhC9gwdDrSANsSCj+3zkMXPZME3
	 VJOlunsXp82SWxK8g94nzE97f9XNDGkb1FYMaiYZimup2IM1uosB6jXTPV3IR1vC8G
	 hpVS/7q07nvcQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 13 May 2024 13:21:23 +0300 (MSK)
Received: from [172.28.160.201] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 13 May 2024 13:21:22 +0300
Message-ID: <8769f323-fbff-bd75-a1f5-7ec789639b82@salutedevices.com>
Date: Mon, 13 May 2024 13:10:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: amlogic,meson-nand: support
 fields for boot ROM code
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
CC: <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <oxffffaa@gmail.com>, <kernel@sberdevices.ru>
References: <20240507230903.3399594-1-avkrasnov@salutedevices.com>
 <20240507230903.3399594-2-avkrasnov@salutedevices.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20240507230903.3399594-2-avkrasnov@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185182 [May 13 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/13 04:27:00 #25181647
X-KSMG-AntiVirus-Status: Clean, skipped

Changelog:

v5 -> v6:

* Update description in 'yaml' and commit message by adding more details
  about such special Meson mode. R-b was removed so.

Thanks, Arseniy

On 08.05.2024 02:09, Arseniy Krasnov wrote:
> Boot ROM code on Meson requires that some pages on NAND must be written
> in special mode: "short" ECC mode where each block is 384 bytes and
> scrambling mode is on. Such pages are located on the chip in the
> following way (for example):
> 
> [ p0 ][ p1 ][ p2 ][ p3 ][ p4 ][ p5 ][ p6 ][ p7 ] ... [ pN ]
>   ^           ^           ^           ^
> 
> pX is page number "X". "^" means "special" page used by boot ROM - e.g.
> every 2nd page in the range of [0, 7]. Step (2 in example is set by
> 'amlogic,boot-page-step' field. Last page in range (7 in example) is
> set by 'amlogic,boot-pages' field.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  .../bindings/mtd/amlogic,meson-nand.yaml       | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> index 57b6957c8415..284f0f882c32 100644
> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> @@ -64,11 +64,29 @@ patternProperties:
>          items:
>            maximum: 0
>  
> +      amlogic,boot-pages:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Number of pages starting from offset 0, where a special ECC
> +          configuration must be used because it is accessed by the ROM
> +          code. This ECC configuration uses 384 bytes data blocks.
> +          Also scrambling mode is enabled for such pages.
> +
> +      amlogic,boot-page-step:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Interval between pages, accessed by the ROM code. For example
> +          we have 8 pages [0, 7]. Pages 0,2,4,6 are accessed by the
> +          ROM code, so this field will be 2 (e.g. every 2nd page). Rest
> +          of pages - 1,3,5,7 are read/written without this mode.
> +
>      unevaluatedProperties: false
>  
>      dependencies:
>        nand-ecc-strength: [nand-ecc-step-size]
>        nand-ecc-step-size: [nand-ecc-strength]
> +      amlogic,boot-pages: [nand-is-boot-medium, "amlogic,boot-page-step"]
> +      amlogic,boot-page-step: [nand-is-boot-medium, "amlogic,boot-pages"]
>  
>  
>  required:


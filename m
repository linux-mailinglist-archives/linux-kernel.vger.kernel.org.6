Return-Path: <linux-kernel+bounces-169528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EFD8BC9F5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EABEF1C212CF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477881422A8;
	Mon,  6 May 2024 08:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Fn/8o3+D"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23501419BC;
	Mon,  6 May 2024 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985323; cv=none; b=hzlaaRus5Gav4/WtqETKAASfDATAhZp1aflrRLY8FmDowTEhX3Y5cQbys9g2oGNLF+4zukZ0aXw95PtB9JA2JI7DMPVbmRCknYkjRnNs575R8EMyI4q90ALw1kHMT2shagndqoLNxNqMHg3ZfAwH2Tlng9L/9rL+9oJXP9Pr5Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985323; c=relaxed/simple;
	bh=C3Shq+hF7VDqs6og2Tt9ormcKaEnc47JGcJfVttheQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bppxwRzm2WNzH9ytbbHJ9pSeqgdNVQFq+05naiN0FnKqJLoOM8yQ+rwQF1v9DaLw8JPGjdG6WCn/uIxGKbiYHJ5J52CQMwJEuqBwZnv6slucsMSNXLxZQtHHGrZwB6vr9DDxtpdJVKsL171VCdBQzejLmphouzpP3J5cm33c1p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Fn/8o3+D; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 330DC120007;
	Mon,  6 May 2024 11:48:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 330DC120007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1714985316;
	bh=8cwbIcjblu4wOeTL1PzC2Bk4VwPtVX0H4EOc1bQEhQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=Fn/8o3+DgyUBAwln6bXs8pBXOnWmpmMHVQkW4HdPk9Yk/dgk+89nq4cVuozhCXOn6
	 xmNNWlLvL6easjk8KXBeg9K9hEe+eaplY0ua/bciaC6apHIBXlv3fQ8FfzwryXmkDl
	 lPEg4zDdCMlZSyixVL/scrfIFtirjNdp2pZ16xgBaavd7dLN/NodsuWk+xEP2PmkY2
	 CTX5+hLyA2WJw0onlXiUtpLQMmqPUluaPq08gIbEOGYKHgC+MVy/IWnNEOdVPInOEc
	 YaH7Zzd4wNtieopExVRu2rFHL1MXw7ju4aPz5BEQhSiMfv6R8rBQImxBSARvTaowYw
	 oFt4NsWg/Z7Hw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  6 May 2024 11:48:36 +0300 (MSK)
Received: from [172.28.226.125] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 6 May 2024 11:48:35 +0300
Message-ID: <c6af5c6d-0272-8c2b-00a3-29c20c3b7938@salutedevices.com>
Date: Mon, 6 May 2024 11:37:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 2/2] mtd: rawnand: meson: support R/W mode for boot ROM
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
	<vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, <linux-mtd@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<oxffffaa@gmail.com>, <kernel@sberdevices.ru>
References: <20240416085101.740458-1-avkrasnov@salutedevices.com>
 <20240416085101.740458-3-avkrasnov@salutedevices.com>
 <2e5b39a1-ffe6-1186-2ce7-51b61c5006d3@salutedevices.com>
 <20240506104753.25e5f8cd@xps-13>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20240506104753.25e5f8cd@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185070 [May 06 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_arrow_text}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/06 05:16:00 #25106397
X-KSMG-AntiVirus-Status: Clean, skipped



On 06.05.2024 11:47, Miquel Raynal wrote:
> Hi Arseniy,
> 
> avkrasnov@salutedevices.com wrote on Thu, 2 May 2024 08:09:34 +0300:
> 
>> Hello, sorry, pls ping, 2 weeks :)
> 
> I was on vacation, I am currently late by 30+ patches, yours is on the
> list ;)
> 

Hi! Ah , ok, no problem! Thanks! :)

Thanks, Arseniy

> Thanks,
> Miquèl


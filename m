Return-Path: <linux-kernel+bounces-245656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D69D92B592
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276332816E4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70DE157461;
	Tue,  9 Jul 2024 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="f+yhCnVH"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9023A155C93;
	Tue,  9 Jul 2024 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521709; cv=none; b=p+E2hNCelvk98FISpknSNiId/yWgJuOrKozxGyUJ1Qo931QCdHEQmj4pbodrV+A0X2E4Lo+P1B/By80orC6HkAxKGZhV66SX1Zh7ljRhwiu+oYcwuq9sPdGh08AaJC9ushItafpjwbptQ59xEYiaFrxZXtG7bIVjBBCWu4YpJ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521709; c=relaxed/simple;
	bh=gyB7v+AqACavkmGFJ869As5NNRl8dkIY4iBD16/6g+4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y2InRNyRceIQ2hgQtQIIUgK7jwjuEv8936n8AX6JpUaa+azI74IY5MzJg2u0oi88XYgStS/OXiKR+5JiKJUzLNHoehIMKSMf0A+qGnGyKosBLYbPDy082G/1mdBIaQFwvB8IMZ6YLfBlllcaWmLxAslBF3gSnPXxqcrLYamipsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=f+yhCnVH; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 17815100003;
	Tue,  9 Jul 2024 13:41:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 17815100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1720521697;
	bh=sR12pzHltQx08uov/cGpqyvv5R5yIyi/05+p4TSHs1E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=f+yhCnVHh1ukQUEJQQq8ciO2JctFMfi3a3z33BbGroNTI8BMMnHKb/s+Vfjtgys3o
	 E7qzgaO9MKM9vrepW6wv35SxSMMoDLWY7Au5zrvIk8TayQRRlRhAqXTwXjPT43SAKe
	 ssT/npOfN5856mQQJziWBVHkM4Mp4HnrWd9nKwBY+S1MSVTLJiW794AtBG8aSQj9NW
	 /WGZ0H1cxPjX9wtI4Ri+KKXGpb/3y2m8XZce+vgYxEobXBCVU/GmbduSRU7ozi1ZG7
	 2rLOMhyAiY315Gg3cb5RH30fas89S4ZyAlRvKA/PzVc2/949IsxddaPczZgq8djdho
	 lpIqfMYdHU7dA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  9 Jul 2024 13:41:36 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jul 2024 13:41:36 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Igor Prusov <ivprusov@salutedevices.com>
CC: <prusovigor@gmail.com>, <kernel@salutedevices.com>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Add ES7243E ADC driver
Date: Tue, 9 Jul 2024 13:41:15 +0300
Message-ID: <20240709104117.33431-1-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186389 [Jul 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 23 0.3.23 8881c50ebb08f9085352475be251cf18bb0fcfdd, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;github.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/09 09:10:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/09 09:10:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/09 09:37:00 #25918307
X-KSMG-AntiVirus-Status: Clean, skipped

This series adds Everest Semi ES7243E ADC driver and bindings.
Driver is based on David Yang's implementation [1].

[1] https://github.com/BPI-SINOVOIP/BPI-R2PRO-BSP/blob/main/kernel/sound/soc/codecs/es7243e.c

Igor Prusov (2):
  ASoC: dt-bindings: Add bindings for Everest ES7243E
  ASoC: codecs: add ES7243E ADC driver

 .../bindings/sound/everest,es7243e.yaml       |  42 ++
 sound/soc/codecs/Kconfig                      |   3 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/es7243e.c                    | 676 ++++++++++++++++++
 4 files changed, 723 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es7243e.yaml
 create mode 100644 sound/soc/codecs/es7243e.c

-- 
2.34.1



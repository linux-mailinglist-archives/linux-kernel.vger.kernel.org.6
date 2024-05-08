Return-Path: <linux-kernel+bounces-173437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCE38C0069
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70F928C6A5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178171272B4;
	Wed,  8 May 2024 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="hbJjq/xO"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658D6127B7D;
	Wed,  8 May 2024 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179420; cv=none; b=HwMKv6FtANBrsja4VeU8yHIeH7xH/fY7dprOSwDqrlMCaz5NZTEwOTdWZmMvIe55yKkj9/uklDaqO6rQVcJlRmtsxn8Hi8OmW7pK8GS7AMYSs6Cck+9mX8kfPcMvMzZiumT5cHGS2v+UophKLh/NFmscovn77D4HVuurRlYqKLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179420; c=relaxed/simple;
	bh=gswKs53jkS41oULvg9VhAYsMQyN8wbsdJDS4kbBwULg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q4CvJQ3uft82cU2eiz2yk+S0fkNpWwkCqIxVlnvJYtIJleqrZof2SzktObuyOreZZJehYXV8kvv2hHaCNM5qj4gS86wbt8ZcTiPbKIlE7RLOcCEvFtcy7t3gG7zL7y2GULerhjRvHwbhyKFELXU2wku5h6GhSosLarbsA0Fe540=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=hbJjq/xO; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id AC99E120008;
	Wed,  8 May 2024 17:43:30 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru AC99E120008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715179410;
	bh=0jC9OmU53LLfwrewlLDVbsUks0O+ztvJHUVnwfXtnnc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=hbJjq/xOsUZo4lq6NzU+mi2uH0Fa4xKbcDdoVehmhEvqdrge33F1MqIfwMpT6BHNn
	 X+Dtopb7QTym6SHfQw0FoNwaEeLPBQGxlEaURt3CJv0k9rgqeVN+0dmPVyIlG+7R8v
	 LJXMLBIlHD+ujEtO6ePzBBa60wVtOr425HQuYQ8/etDlYXpfYZOr0JMDq/b2Sdfl6n
	 d1EhVyZCaEc6eUlIwpagQ7LQgU86vp9gduMl9dx+6OKWeSEFm6ybvZGD/urqMVeHn7
	 qK9Xa/w/eqAWjG0Rm0iNWRcKhRqB7Sosi918x3E4NnqSVmGxAO7Cmjuxc+lIggGB3b
	 ZQMmtnWtYx+VA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed,  8 May 2024 17:43:30 +0300 (MSK)
Received: from CAB-WSD-0003115.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 8 May 2024 17:43:30 +0300
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Michael Turquette
	<mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, Rob
 Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Subject: [QUESTION] Convert axg-audio-clkc to YAML format
Date: Wed, 8 May 2024 17:42:56 +0300
Message-ID: <20240508144259.191843-1-jan.dakinevich@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 185143 [May 08 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, {Tracking_bl_eng_cat, c15}, salutedevices.com:7.1.1;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/05/08 13:27:00
X-KSMG-LinksScanning: Clean, bases: 2024/05/08 13:27:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/08 09:52:00 #25122865
X-KSMG-AntiVirus-Status: Clean, skipped

Previously we discussed how to implement dt-schema for audio clock controller in
Amlogic SoC [1]. Also, there was an earlier attempt to convert to yaml [2].

Let me remind you that the problem is that only "pclk" clock of this controller.
Other clocks are optional and they are allowed to be not routed.

I can suggest two approaches how to deal with this. Could you please tell me
which of them is more correct?

Approach 1: use 'additionalItems' to declare optional clocks.
Pros: 
 - it is short and simple;
 - no need to modify existing DTSIs.
Cons:
 - checking works but 'additionalItems' doesn't expect no-boolean value [3]
 - there is reasoning that all clocks should be specified ragardless if they are
   used or not [3][4].

Approach 2: assume that all clocks are mandatory and declare all of them.
Pros:
 - it is more common and compatible with existing meta-schemas;
 - may be architecturally it is more correct.
Cons:
 - boilerplate in schema and in DTSIs;
 - requires modification of existing DTSIs.

Links:
[1] https://lore.kernel.org/lkml/20240419125812.983409-5-jan.dakinevich@salutedevices.com/
[2] https://lore.kernel.org/linux-devicetree/20230808194811.113087-1-alexander.stein@mailbox.org/
[3] https://lore.kernel.org/lkml/20240419210949.GA3979121-robh@kernel.org/
[4] https://lore.kernel.org/lkml/07b1ca57-49a0-4151-99bf-caac053eaa01@kernel.org/

-- 
2.34.1



Return-Path: <linux-kernel+bounces-309547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A01966CA0
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226D01C21A81
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60C21C1AD4;
	Fri, 30 Aug 2024 22:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qIP9yvtG"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2108.outbound.protection.outlook.com [40.92.47.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA6E1C1AAC;
	Fri, 30 Aug 2024 22:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725057590; cv=fail; b=K9e7b6DAoKpFaUZ5c9DmRtHv7EHh11O2ppFc3UEF4yy97WuRIf4OJegerkb+/TbKvvVzTC2prp9qigi0ZRfxZ1V9jsinUSrIaIrRCej84SJiDHlWcb/EMBtd32f91vQpg/HUeDyiWUeO11HS3Qmtf37ySuXiEsQMmK3o2D62FAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725057590; c=relaxed/simple;
	bh=/rd9ciBj/5whmxuCOTy70l3op3kzfrt6s5wjfzjmqi4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jthck8X3EoGDttJ+2TYjMUNB4ZuMPtKgVUephVEnKl/Vj/4fpCUZtjR/HLCm5R3Ccec7zfHtuZqASU39UEYEGAlFnjKZJoUahCpjSonQZiGOdZLef6X2RKn2/s8y6sla6nSPw87oa0jgS8/mKmwmKTfLFRwhjMZ5sYHRpKxQC9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qIP9yvtG; arc=fail smtp.client-ip=40.92.47.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YElPbM/e1MnCAWfLI6utzgz932quV6fjzhT8/fImhWjFKoa/bwnNdHaKKoJyMHwaw7jcjNdUDE7YIsSMYfRw3aQAuuI3TaTw6EDksEimjk+9T7/cJ6x0fiAdCIfeZQsp89n2nYtlPa0N04WzB6BPhOn8nH7A7S+bpDbdmCpsD0guceir603cFgEHQHj49X53+cAwwwX/mDnYso0NIPdi+FM5vbCrRQ8F92VRzKF9HPdhTZg5NgXTPKFW6R+yHzk8yAl1Rk3GYJnDzfLITSI3k7rU+bKwGH4xGoI3dPGGTQkf+0RAyO6vEIVCNb8ChHS76xTP0cnlzKg4nCUJO1B2yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6YbgBXUsI6i4VrqWyESrBgd6zvJmgXie4ZP5gPtRB8=;
 b=c4nKCMZuoBowaZ3mSQq7Fm6cZn/mV6SRfPPWXMe9/3JLUyG/DNJusdK30yxm4pc3khcMFKWzQWVjlyJWFOouH+65g0w38slCYStKNXDmgH4x7/3l3fRZRQZ7YdEWvtrbXstzrFBq5Ly9nuewzgG15MQ8MycxzoaCWQaRc3QZeoBftD3QEOpRxmYKh5iKk22lQwfnOVJu7bG8MkbD3EGxhvgFRogCFlAF8No3tNtXQahIrt2CjYushp2jprYw1eYJgZCkpAiqM/oAuoe5vLmRWOlw9Dnepre+hiw6J5bo8AgM38apdtbph5oU9VFNlsR6m5tZvi0VglQsgXeDF3q+5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6YbgBXUsI6i4VrqWyESrBgd6zvJmgXie4ZP5gPtRB8=;
 b=qIP9yvtGilbDgAObACnKGYwbVP1j1dBjZdzC6HFFb118NRCOrhJVr0dTgLRJgrke3ORpYEBsnezHa6cJg0v1wtWCSyCh5378wldS2xQz4/6zNkvEuVeP5M6Ypsj/j8hQsMe81K/aGw5XWE0jzJdoKLLYrJoJpqcePcdgX1mMeCnn5CfB14TcyBGU2m40QSrjrJRFEy95kIrvneh1wFyc2iaeHPvKf679jpWJLynatrFOULaiIsmnjbOG4H4k7Qh5/+spO0ym5lY4aGJF4OrQfaYfXbnMzj99aL6pERkfl2me3w8UFNLRD1LzQu0rxF2jDStBb8oYv9IuQyY1sXJYRg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by LV8PR20MB7473.namprd20.prod.outlook.com (2603:10b6:408:227::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Fri, 30 Aug
 2024 22:39:42 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7897.021; Fri, 30 Aug 2024
 22:39:42 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Haylen Chu <heylenay@outlook.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] riscv: sophgo: Add pinctrl support for CV1800 series SoC
Date: Sat, 31 Aug 2024 06:38:40 +0800
Message-ID:
 <IA1PR20MB495374DB8C4208575AAC9675BB972@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [GvOITqPhaSUdcV+Vq4ROuqQMlvBo77upmihILKOEtp8=]
X-ClientProxiedBy: TYCP301CA0074.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::14) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240830223841.27471-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|LV8PR20MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: c6065540-c888-4399-a635-08dcc944a3b5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|19110799003|5072599009|461199028|8060799006|4302099013|440099028|3412199025|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	3IfGiXqJS79SFDh4czAlGCPx8GCHNLeg/qfPa78BZ+duSJ2GmbckIkzN3iz6Z6bgWZ9LaY1375ZMcyezDobAfeml9bYfgByRTq9jVDLyhDHG60uqWVj1cifwzn2jkMhfOa5yJGHioSFjJHNf74/PsjrMis0qtHWOJfSmoL6ZbqAi5hrZVHpYVkLO6/6s8Ev5EdyO//0CRt/naxBPddtJYBH+sDsrtMEpZvIo+t+Q8B+Iqk5YejKec+Na82R/P5ivc0ajUGmNlIzzjtQ5/aYwYJBZKbCK/nz9DTlQwyfqq/35bicVFX2tQ7/FxiJtDdDBWbapP4yRa49cCsVN/50GwxwwaRLH9HjmuDf7PIFm5T3aEkQECipKEfdQjfO93G52q51mIfD1JLzPEmVOQNY+nuAFgRjCT1uFNnOzaTTeAIUkRcBZINqgg790Oe+VvH8SgfRCel1a5n210XoaAXSgM/lJM4fdo/iQk4ERSg6am1JRD7oWvXlGUfTNjM+zPLpVF1IIE+5sLy/FCatGLy5qAu2/KnTtjTlofEwSJ6UP5y/S+F23vioFN6MZ7r5XF7sTp3coCIDKVrRVTmcmUONqil+Z6BRaTSKvicv+JRq6ghYih7GSj98C841Ums5AFEBQCLlYzmtEydO6KO/4cfwNIYFKrQFdjyn4GOJ20ibDUbXHzGofp13XaZTo5GWPnaP4ZJq6vNDPmp4/SM5wFYHgMQmzZpTrp5h6YxTNDPLZxKvgacbQpU2FTnhafvIf3yN6AoCzw32TegUf9IeHDWh1lsqiowRZA8p+7BNBQZH1DIqDWtZfzks/9IdpdPNh3OIgnif85Q+bY1sDvcT1HaUPET64hvnka9ghkpoup8UBj8A6lgGCSYq8u8rau8zCzAHWK/bj3vc3nqH/HEXpwAeD4w==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L6uo1YEzbTPxhFCSzGjl4W0eGtN4EYk4reXaR5Q4RnfH6pDUU4fZ2Mp4glmR?=
 =?us-ascii?Q?UXLdXFNTTTWg4t8c/QHf0f7t3LTQ0r4fO+B/6DK3MoZyi94+wWf/13lMBCNA?=
 =?us-ascii?Q?cBdAjuPRKdMdw/px9sBqwlfitvkxXzMnPKN/rRMYYYrge0+swKPj8PLD0wI2?=
 =?us-ascii?Q?3ivICceozDNrJOrs68+Z43k/xUpZIqEv+JJ7dHcZ3ycTQXJTSYw89ZmxOVsi?=
 =?us-ascii?Q?admdKjT/k+Lg2jMGr2PLmSu6q00+NYy4dfEohQsgjFKX2dEZeU6a+XQQ+Cmq?=
 =?us-ascii?Q?BQqgwrpBhhBQMBjipJGLrwlf8KhZogF25Y3+Sklz+Nk51MPVVG7pI8GHfxx6?=
 =?us-ascii?Q?zr+x7o2FtJPs8/gqHPx7keotXBJ63pSsc6lco03D9RuApvdWqz1v690oqPOA?=
 =?us-ascii?Q?1sWU8RsDLgWapXctPaasxygASXNdfqeAq1YKN7Nm2RGJVpPuudKBbMmZxZPu?=
 =?us-ascii?Q?SGbeXWHEa9V7wT9Mu6CL8nLe7/vaJuFsaN99pDbFUIUsV2tCzuZeMG/sHyII?=
 =?us-ascii?Q?F6tBzo5lF1UlShsGJhWfe97WcRsdAnePvLIx2ecGOamkaTC1YM+YtNmWdBOg?=
 =?us-ascii?Q?nEuCvtjl+9EaWYlOfkuOjHYShcqpEwKU8LmybXlvt1YPu86+g9a0j4jvM0fE?=
 =?us-ascii?Q?qjDBhLNsF0gfGo1SJW4m65HwBG/ETbGBEamcvOC3KusS6wYHDE+wsnZvCXZE?=
 =?us-ascii?Q?xmTxI9+ZDAfDZUnSzsG9O/LZmzPDqj/xWbzoB+vvwNMe0Prw5kYUkqGPTj8H?=
 =?us-ascii?Q?AsZk4vBEvk1ASgUve8nAGZPAEypu1FShNmBaI3AVmSRbXQeA6P0tUKaLGj94?=
 =?us-ascii?Q?zVRsoRnd4dVCTHj8Rn4IBp9RuJAV8NhbP9LHgGP9q8RvCmYFmJOZLvRZL7uX?=
 =?us-ascii?Q?4g+jx96+zji+qNtJDYooHk+f7YNnLqb8GvYqJhU3caRbr0gdSDsF7susEIqI?=
 =?us-ascii?Q?PXfwzDLOgindGY1Nj0ATAncRBp0HMRXrtrkZORBM3eytTj8TvJoj03ItPcJA?=
 =?us-ascii?Q?RtufSUUg42cR6mnQOZFNejjx4fosdFHaHSlbegOC/oRy7NPJ3KR2akCW0jiS?=
 =?us-ascii?Q?SxJEfKQZGNvqRZ+El+NF8s5ZHqWz2MMxYft667pjjZtsGc19OuwK65dzqwmM?=
 =?us-ascii?Q?y6YGbc4rOGfOCCBSrTjmMYmnZGG5OutnJtLZwT2pRl0ELtvEpWPksUHTxa3r?=
 =?us-ascii?Q?ni/9cfA1+hrSyOn1QkFrSkCgqvcxQ58ZXomI2qnRGRhWmxcEwEmsnRyCu/QU?=
 =?us-ascii?Q?rMKC+7Dyb5Mu8DixiP3f?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6065540-c888-4399-a635-08dcc944a3b5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 22:39:42.4287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR20MB7473

Add basic pinctrl driver for Sophgo CV1800 series SoCs.
This patch series aims to replace the previous patch from Jisheng [1].
Since the pinctrl of cv1800 has nested mux and its pin definination
is discrete, it is not suitable to use "pinctrl-single" to cover the
pinctrl device.

This patch require another patch [2] that provides standard attribute
"input-schmitt-microvolt"

The v4 version is from [3]

Note: As current documentation is not enough to guess the pin
configuration of Huashan Pi, only the pinctrl node is added.

[1] https://lore.kernel.org/linux-riscv/20231113005702.2467-1-jszhang@kernel.org/
[2] https://lore.kernel.org/all/IA1PR20MB495346246245074234D337A6BBAC2@IA1PR20MB4953.namprd20.prod.outlook.com/
[3] https://lore.kernel.org/all/IA1PR20MB4953DC78BB0FE0C57EA94F91BBB32@IA1PR20MB4953.namprd20.prod.outlook.com/

Changed from v4:
1. remove the alreay applied patch
2. fix 1812h header file problem.

Changed from v3:
1. binding: drop unnecessary type
2. binding: use right ref for pin node.
3. binding: remove mixed spaces and tabs.

Changed from v2:
1. remove unused export function.
2. drop "drive-strength" and only use "drive-strength-microamp" in
the binding.
3. drop unnecessary ref in the binding.
4. drop unnecessary entry for binding example.

Changed from v1:
1. replace attribute "sophgo,bus-holder" with standard "bias-bus-hold".
2. replace attribute "input-schmitt" with "input-schmitt-microvolt".
3. add vddio operations support to report pin state.

Inochi Amaoto (2):
  riscv: dts: sophgo: cv1800b: add pinctrl support
  riscv: dts: sophgo: cv1812h: add pinctrl support

 .../boot/dts/sophgo/cv1800b-milkv-duo.dts     | 49 +++++++++++++++++++
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       | 10 ++++
 arch/riscv/boot/dts/sophgo/cv1812h.dtsi       | 10 ++++
 3 files changed, 69 insertions(+)

--
2.46.0



Return-Path: <linux-kernel+bounces-205776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2676F900029
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B224F28AB0C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2183616132F;
	Fri,  7 Jun 2024 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="it33gaka"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2071.outbound.protection.outlook.com [40.107.249.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385F915D5C5;
	Fri,  7 Jun 2024 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754464; cv=fail; b=LNdbgrx3qAKxvicnMLvALN5qaQ01PJMmwbrd3ZULl1E8o3ZkaSSVxr4rn/k3kpTxcFzzydTV7BN50J+YbQ/xPvDuTHTPYAPIVzOUcM69Nw+KLJPGEaw53zywbh0/cmJNmMoJzFlAKpr8HvOZgGVFymrwwhS73yomQMoDk/sVit4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754464; c=relaxed/simple;
	bh=EdTYqBxadtY2HYA1NzjCy24oXQlUT2Dqvdo85dtRYz8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Ri/QjyQMESj06lcTLHNLOHaQgVNSXlAQ+q4lYNEHPT359BD3CPu5Lv1bsnvyH0kbBbLNguUjspyNhZuleBQZy8Lm2SCMOvscwKOgA5DPl/g4DReXRTwRkoCaCnCdb6WzzbF8VrjkOmsBiOaTAAm02LGAawRAKlTdRAI7L2+XUS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=it33gaka; arc=fail smtp.client-ip=40.107.249.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZyOsVOJONI1jk/22WUBJCutR/Je9+aV0yk6LdwXG9BjIrLe+wdYg5uLnS0C0LEh1OvST/CQBhwVE9UENfXBEWXeMB8JAcjbbDZVnaJYyo55kqxEI9/vjirMd/eiM52vAKCib2OQSLPj956yn1TybWcfa0l6UUVVNGfgzlGn7z2iWeik2qKGwhhPiiQpsC08lT5hTQ2thQNXaO4LIRXHLypZO3JG2y1NxFy0uP26b0XpPfZ7Y2zFpa/Ldl6yIh1N7PgWZgUZaUVs8oTmM7ggzORWyJPlBJYA1G8EOvWtGG2MZVgnD8y1pziFEyY4WlTc3HR9DpvOCGSk6qAFAZ8iCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUREBq54H9jZE7Z7onfglTlP4FFzPb8AIpnJT0Otv+Q=;
 b=lvZLdRu67NXlRzgKqULKjB7GQ28oufC35OdQdHjEKw9RZDaU5C+/4ZY7vU04z6sMIkldbyoSwTaFzEaQasIEZGzOXnS573Bq3jp95UUSWzpmhXTmRFxB3z77F0kR5eNrlcQ6EmWSpPUxHsjTv7my/we49lXVQi8F2tw0NRiVl2EqJgJ3gNOlESj6nMhvg27VArYsf0wH9+pcBcwsuyQwma7Edhx1u9Gh9ycYZ6zEm/Ul01JfztlVmiO9T6+5t6efpwuUAhMwjjgX2cMGHP8JIxG/3gd9c+KQuiIP/Yqg+1TBidMzGeUtDqsB4S+aGJXuKn+qkvU5JdqKp4Uw30MA7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUREBq54H9jZE7Z7onfglTlP4FFzPb8AIpnJT0Otv+Q=;
 b=it33gakapBhZqR0fy1oQKp2LGn+5hQgWAk5TdI3+wxlpps8zYJQBJ98yBM5+cDq6/H9agPRhUqIKUBkJX0NrdjMgUhTyDdzcVttjZ8/x1lu86sd16NSMSO8ld40IyyH/gzB7L6ULXE/hTxHHq3ExAD2naD9mpkWH6r4ekuCp9+U=
Received: from AM6PR08CA0046.eurprd08.prod.outlook.com (2603:10a6:20b:c0::34)
 by PRAPR02MB7833.eurprd02.prod.outlook.com (2603:10a6:102:29d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 7 Jun
 2024 10:00:57 +0000
Received: from AMS0EPF00000190.eurprd05.prod.outlook.com
 (2603:10a6:20b:c0:cafe::ce) by AM6PR08CA0046.outlook.office365.com
 (2603:10a6:20b:c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Fri, 7 Jun 2024 10:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000190.mail.protection.outlook.com (10.167.16.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 10:00:56 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Jun
 2024 12:00:56 +0200
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Jun
 2024 12:00:55 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 7 Jun 2024 12:00:55 +0200
Received: from pc49102-2217.se.axis.com (pc49102-2217.se.axis.com [10.88.7.5])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id D9CD332E4;
	Fri,  7 Jun 2024 12:00:55 +0200 (CEST)
Received: by pc49102-2217.se.axis.com (Postfix, from userid 9470)
	id D2F356476FDC; Fri,  7 Jun 2024 12:00:55 +0200 (CEST)
From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: [PATCH v2 0/2] tlv320adc3xxx: Allow MICBIAS pins to be used as
 GPOs
Date: Fri, 7 Jun 2024 12:00:44 +0200
Message-ID: <20240607-tlv320adc3xxx-micbias-gpo-v2-0-b140a45ffffe@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEzaYmYC/32NQQqDMBBFryKz7pSYaNGuvEdxESepDlQjiYQU8
 e5NhW67fA/++zsE69kGuBc7eBs5sFsyyEsBNOlltMgmM0ghK1HLBrdXVFJoQyqlhDPTwDrguDo
 cmqEyJTXVzSjI+9XbJ6ez/egzTxw259/nVSy/9ldt/1RjiQKVEEa1ZInqutOJw5XcDP1xHB/DI
 +ymwQAAAA==
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, Baojun Xu
	<baojun.xu@ti.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ricard Wanderlof
	<ricardw@axis.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Ricard
 Wanderlof" <ricard.wanderlof@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.13.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000190:EE_|PRAPR02MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 01bba9b4-2942-4c67-b82a-08dc86d8b99e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|36860700004|7416005|1800799015|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yk45OStnSXFrWXlneFJTN0o5ZmpURUZEd0tUNDloV1Z1eGlNbE5wbHBGb2E3?=
 =?utf-8?B?QzZoTXpGMmc4QXhwWmFhekRlQTRpM2FkWTR4ZUg0MTBLTnJSV2o2NmlIMGJk?=
 =?utf-8?B?QW9JRElubmN6U1MzWFo3Z1Q0Wjh5cWJPTGsvcnRORU5jcUJGUzJrenlSdE4w?=
 =?utf-8?B?YUlPZmZkZnRFOU85S3d4MUJUcWR1TWdmOGJtWGRrYm94Mk5VSG4zMW01RjF5?=
 =?utf-8?B?Yi9HMHJJS0J0VkJZMmdsS0xmZUZxSnBOOVB5NHhpRWc1YzJGUlZsb3RGU2pU?=
 =?utf-8?B?MWFyc2dJV0c1a2wrUXI5MGpsQllrZTZUcDFmdDBNWnBZUjVXeXFCWjVmeWw0?=
 =?utf-8?B?QnNVYmxhVlFMaUVLTkpHWTRPWWFrY3M2QzlaQi9DYmJDeGhMKzF5cXExZEdj?=
 =?utf-8?B?eWk1UGVSb2Y5Q3hWL0dKSmJGcTVzK0g3T05DT2dRRDludGlBN3ZsNUgwOEt6?=
 =?utf-8?B?c1NOcXR2eGlwODhSMzh5dmx3TzNNZmhBV1BvRVNkQ2VlZFRSRFZXRGllODF2?=
 =?utf-8?B?Z3c5YjZZcmxNZG0wcGZJMHdkZjFTbExoR0VHMy9pelpvd1FkaTBlN0ZnOERL?=
 =?utf-8?B?OGd1akdJK2l3SEoybGdHM0FncG1kVWRaK3hzSEsyZjJDNkZoQS9vampqUjg2?=
 =?utf-8?B?ZmsvcGFNZ0c3b0Q2c0JsMDNpSHhiQnR0OXR6ZVM1NlUyOHRVTWdPRXk1eHFM?=
 =?utf-8?B?VDR6UFNYb1R1L1JNdlFwUE53c1NpYWFlcUFjbSs1R3luekxLc0tFRm55WHhy?=
 =?utf-8?B?Z3B6R0xCVE5PcVc1eUhNYk5meGhzWnhkamxZTmtRMWdtSElueGMyMVZyVEk2?=
 =?utf-8?B?T1NYay9XOFk4SlJQdlZyVWZLMDh5cVlEUUhrSFF2Z0Q1eXEwditzZjBJVkZN?=
 =?utf-8?B?akE0THhxc3c4M212cXVpYUcydTBLZFdSSGNiZTVWWUdGWGQ2ak1TSm9vUEpW?=
 =?utf-8?B?clUzU3VTSzJpQndqemM1dzRXTmpVZTUvbGlhL1p0T1docE9ZenB0ekNwMnY3?=
 =?utf-8?B?elpzOU84WFFLYXEwOXF0bXlLZWJFVGR3bXpyRnY5ejEybVlnazJQdHVhd1ZY?=
 =?utf-8?B?Mk4wRSt5Qlkzd3BoOVNNZlBuTnA4algrOW82MHQ3Zit6MjFYTmEyN3JnSmhH?=
 =?utf-8?B?U254MU5XczJnZFRsc3RhZlRrNTlTRjhiUGxuZnZxeFA1SUxRMzFkdS94UGRF?=
 =?utf-8?B?ZThkcWRSSld3RzlZdzJubVFZNnk5ZDI1TWdIcTRKc0FVMC8zc1lmMElsbUNE?=
 =?utf-8?B?OEQvK28xeUlIU1dqMEJMb1NIV0tuLzBTRHpzZ0cxRkFGQmd4UWEreTF5bDh6?=
 =?utf-8?B?OEorQUJmWityNW05V2dUR1d4MFdyQTZ0WTlVVWoxd1p1OUgvSGVSRUJ4blI2?=
 =?utf-8?B?ZXZ3OWN1S1FSOWFjMUthbi9tRGpYdDFudDZhdTBiUXNXcVEzYVdLWG5aSjV6?=
 =?utf-8?B?WWxOZFU5Ry9paGxmVVFLQnArclNKeG1QaEtBSk1zbktoWmJwMVhHQzg0dzd6?=
 =?utf-8?B?M2ROMVRsanJkVUVJNmFYdXVyeWcvUlRDamhZTGFONDMrZXRNWmFtOWJtNlpQ?=
 =?utf-8?B?VVB6WTEzdnVZUDdoTE5RaTYzK291N212ZlVwM01iUjlLc09IK1VsVVUxTkRC?=
 =?utf-8?B?aHdKV2Z4T0xpblJFOStIcTR0VXRHVktHUTlISnFjbC93Yllxc0RCMjR4N0Vk?=
 =?utf-8?B?T04zZ0JLZTd1am5RcE5rbm9NOHBnYitsTFNiNlF5VWlJMkd3cmpiMW9jYW9C?=
 =?utf-8?B?WGsrdlZDTXAyQXJWdDZ6UEs4WFZnemZJcFhmeVZHUW93Mk5WbHNVTy9nbk05?=
 =?utf-8?B?R1pRZjNhRytKQm1NY2FjWDN3dEY1NHNQV2tNL0JBZFRKTGlOcHVxTE9TajlM?=
 =?utf-8?Q?k4szi4/xQYoqn?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400017)(36860700004)(7416005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 10:00:56.4543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bba9b4-2942-4c67-b82a-08dc86d8b99e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000190.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR02MB7833

In some cases, depending on system design, the MICBIAS pins on the
chip are not needed as such, but a couple of extra GPIO pins would be
useful. This patch allows the MICBIAS pins to be configured in the
device tree as general purpose output pins, controlled via the GPIO
framework.

Owing to their originally intended purpose there are some limitations:
when the MICBIAS pins are deactivated, they will float, so will likely
need a pulldown in many applications. When activated, they will
assume the voltage specified by the micbias1-vg and micbias2-vg
properties, respectively, meaning that the resulting output voltage
will be 2.0 V, 2.5 V or AVDD .

Signed-off-by: Ricard Wanderlof <ricard.wanderlof@axis.com>
---
Changes in v2:
- Corrected typo in yaml document for ti,micbias2-vg property reference
- Added dependecies to yaml document for ti,micbias1-gio and ti,micbias2-gpo
- Link to v1: https://lore.kernel.org/r/20240529-tlv320adc3xxx-micbias-gpo-v1-0-300d39cecc55@axis.com

---
Ricard Wanderlof (2):
      ASoC: dt-bindings: tlv320adc3xxx: Add MICBIAS-as-GPO properties
      tlv320adc3xxx: Add support for using MICBIAS pins as GPO

 .../bindings/sound/ti,tlv320adc3xxx.yaml           |  24 +++++
 sound/soc/codecs/tlv320adc3xxx.c                   | 105 ++++++++++++++++-----
 2 files changed, 108 insertions(+), 21 deletions(-)
---
base-commit: 47d09270d7776e46858a161f94b735640b2fb056
change-id: 20240528-tlv320adc3xxx-micbias-gpo-b8b4d1c846d3

Best regards,
-- 
-- 
Ricard Wolf Wanderlof                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30



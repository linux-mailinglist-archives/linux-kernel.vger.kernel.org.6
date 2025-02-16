Return-Path: <linux-kernel+bounces-516495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0E5A3728A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 08:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30353AF42A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 07:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DFF1552E3;
	Sun, 16 Feb 2025 07:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="nPmwIxTA"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11021109.outbound.protection.outlook.com [52.101.65.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27E64C70;
	Sun, 16 Feb 2025 07:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739692784; cv=fail; b=BpFeGhm3HwMtrVHft3I+G3aoEIr/S7OLUpor3cvVevThNxY1gqAlc4gEdWRfb+PckGrgTGTK/sH+N2dk31blMc6L7xoR96jV7j4S1XDeAYy/8LvbIAJBd3GcT0168OXBq7+U9CIYEn+sCDzhU5pqOU1TajBMu9MCgnqs9embM1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739692784; c=relaxed/simple;
	bh=hSj2TSfC31oZ/+yj8hhkfv6Osx3XkXiq7IVAMIWzTIY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZnOIqLqWAAKr57TpDTcQ0WLBuknjB0EjNXfR0/LBEkXEqTvWisBZgc9R6dNJAEW2SigCTqRbq0GtkPS4B8l5AoT9CKwz1AZJBYfYCAHaHInKTF7aOEdA3E49WuPon3YbzpWXFm4MUEqy/IuEhmrioUNp827T9Edrk4XVJb0SBgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=nPmwIxTA; arc=fail smtp.client-ip=52.101.65.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+IOj9xzxmD20y8xDo/mXx2aLJXFoxxrHJSsmC1crFG0ImsXEZAmW0nr18I1SGMppWwr14lBolXp6Wq5MBfH/p9x5wrSDe8ELPZNSdYR/EGr6RraKA+ThqG0zEe3Nb4xka1ZzPdbGoBRq1gDdQ5WeljPHme5jnV7CFk1STQeNlIGMRQE300qRlV91gh1kTL5totwMPE+BUkWLSXOmvjZxOTANY1WpNpuZsKolJFOnMUJA/eBTx+OrnZo4UXx3wEgUxFWex7/Zdp20ulWGMebSBilusQ9zwpAX6QrJWMAf7oEQ1YLDFylNKgf575ALxyu3rfsoIeUVxYMznjRo38Dsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7JGj9Y2NvlR+Ur5b6WMaXa2nlsT9ZFJEwFDS8Jks74=;
 b=nde4yHoXtvJsg02lpn04yUWQ/T+XbvsUeKeTqVJ+jBy8FNqHQe1fWChhIplTSAKw7w4c/GO59N5hEVDwV2pDr+D1V4n/L6VvewFVWMgDc5+QokkqvOl0eKI0eZpjKQsv25v9fIk2YBg/oT21MWTJJS5TzGlHKlByxyPya6Pp4TOnNZ2Go5HLVQrf5PVlIj0iilwRT8BQGW2PcvucV8pVoNXpRntzLLsoKIJ1g+8jPiz5RSeXBCffD00kNRN4thxErE00fIMi3H4Nd6/yzGvTqphlmBRiYpxl5Fcs1O2vSdwhCvuzxbg2AKkg0rVWmKqTn2Zhzr6A2aHz5CtKjhy+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7JGj9Y2NvlR+Ur5b6WMaXa2nlsT9ZFJEwFDS8Jks74=;
 b=nPmwIxTAPVl6A6BwkbUzvQkfZWEP5dxtNnJNh1cCqxX/ZRl3rY7pp5FPZJzCnxE9wAHxi28AuNHTSKmwojq8AEb8/3hbQQ1XH0ERu/5hNheUS0OUZcXYsiCM/IpfW/1tygjHfaSohuJKDW1+eHxuBq17nlunwbYWUQD35NOSHesrNUOwWaVA97y+b2+i/yaIc0nKu1gbwtfInu0VPnUgUrXBJ6+93oyaJOPqmPwhUaaFORqCgsMMLiCJhoj02I71xYWNEdybQJkmtDphgRldz69wwmdVNSfUXNstm8B/RPGLB3vCQ5klO7RU4yoz9EPxm54G5PNOZbplU4MJ52TB+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB10572.eurprd08.prod.outlook.com (2603:10a6:150:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Sun, 16 Feb
 2025 07:59:35 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8445.017; Sun, 16 Feb 2025
 07:59:35 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH] arm64: dts: mediatek: mt7986: fix pwn fan settings for sinovoip bpi-r3 board
Date: Sun, 16 Feb 2025 10:59:26 +0300
Message-ID: <20250216075926.1083813-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB10572:EE_
X-MS-Office365-Filtering-Correlation-Id: 5970ec0a-2b2a-4355-25bd-08dd4e5fda77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6sLF3u6EdnLXS6pMmVqDhPOafT4Cp18lCnUsxbQlpFkjeBFDmauNXynn3sZ9?=
 =?us-ascii?Q?DVVlBXcLAxV698QdwrAsycFA1fS3O7AZRH0ODMMjlfLDHC3Nup8HYGpVX/+o?=
 =?us-ascii?Q?fZvKwxJ9h+VJgcfzckAm/OfqXpWyPh/ZnNvszDN25i6WtGZILgzFf9l3AjHD?=
 =?us-ascii?Q?jpQtfBpaRhJu223fL2xKQRPlXMVZNYMO9EGOFrKWWKroiMQSuz+IuN0vmx/c?=
 =?us-ascii?Q?zVuHSHa+YcbmEtpzAKRYKz5GHQPDcfCalTLyhfbcoIA5apVoEy7u6LHGrF2G?=
 =?us-ascii?Q?DacnFvg0CTDnA7HC+hBC8n9aLk+7y9O5jrLcnO0iV6bBOzFfRgeYrZvNFYue?=
 =?us-ascii?Q?BUrR2DXjwNFV5TMajTBxnqZcRNKOmGsXRUPpqXkw0yXloBbFoHWMvygbrWZ/?=
 =?us-ascii?Q?k7v86Rlw+iS8HaI2px77c0Ha6cuifee6FlF00VgjibS0/suc7x59bBMR9wLL?=
 =?us-ascii?Q?9eTwZYX6/JayGOODiXgKZAIH+fGsjmpUUy4omlw2vVPC0LRqb+04pnwtpHoi?=
 =?us-ascii?Q?xTZSHRSrwTnOy0AW15/joC8xTEkIXOMYzJJBrmnRpi4Ra9KMKVW5fKTyj+P5?=
 =?us-ascii?Q?D82VcU6mYORGwRCnEbhqR4wuV5CLsZc/i0mHxDcXfdzUE0U12tbYeY5kRL9V?=
 =?us-ascii?Q?37qYJQwo3TsZO1QHFydgGqtfqEL6AIGJ5Oq426LVBXrCWUxd1F7wYJRnlzp1?=
 =?us-ascii?Q?Fhsm4oFX92kKUlcDHz49zjxuLpq/UIW3I5NdiREP0ucZ4VUCuv4afLxxVZUC?=
 =?us-ascii?Q?AyCjmdiRg+HG6/b+8jh15jhJieA3S0Ro731PsRcig/IXepTFcFI6aC5Lbqz6?=
 =?us-ascii?Q?C5tT+E508iCXpipAG3awKp7/Tn1pZGNM33EZBel35n9DakUeUMw+gfx0lxAy?=
 =?us-ascii?Q?sQkvikhEGg/aT5DnF21p9AHFg/7jsJ4HqQ0a8WLwWtVJGwnD5kKC5CG6WVyZ?=
 =?us-ascii?Q?O9iX1furLcsQmYSeCJYCXeQoMpJ0cscSo8wDP598ekjR9BuC4LfB+zY2D8CU?=
 =?us-ascii?Q?Z03JR53JwGHgzOlqN5VAjDe0E7hQGvCkBUgTmm9qtOosP+lR4swpdCO22msc?=
 =?us-ascii?Q?ZCchzBL83w73uJc6Pc1ilOE1KOcFBf2pB7kiitpC6Mg+sWA6M9TwFb99b2fn?=
 =?us-ascii?Q?RHvQt1YlpFsl8bVh4ietkBA+x6weYlvbN6+J4px5kKuD9LXMny73bq4oGBDA?=
 =?us-ascii?Q?3cHnMzEqXAHLKOSoUO8GLIFdgJVUzTETzPkANFFxPncaXyM7QOHj80RhKjxW?=
 =?us-ascii?Q?dpEo4vUP60nHpBUyQ0Toz/Zhj4X8vtTZg0tK4hyQdr9p6UBLRS6eMINAASFs?=
 =?us-ascii?Q?ogJTJdMzB/7Q5DEBNMcX2HIZsEkBntCLKmDrx49xThJU3d2I+pRa6VB3Cqnv?=
 =?us-ascii?Q?1ETIIs3MV8Km2HHH1wJ/l8fiRFFoxtvai1EkMkBZ5/6UU6CBtCgjsrkUMjmt?=
 =?us-ascii?Q?69xbIFBnbHoKcAn8iAPpP0Zyu11LPkmZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kOOoZ36eFnled11GdbKW4GP3KKvzOnC2UHBIEEFu//50r3EygAQFtiyjINiE?=
 =?us-ascii?Q?op6f/O0PVPZx2Ur9YNWnPixoWXGtOgMwpjR60ODYR5ViW31uPA8/TP5kVIHK?=
 =?us-ascii?Q?kx6PxElucRtHYuaTDveJ/4LgRQ53m4JF+DR4VoQIWfovbZcb3xOg881u9RTY?=
 =?us-ascii?Q?fBSpI5gzEyhBpo8+SCr1l0KmHZsCYNGjbxzLwrYUsaZtme5azjOCbSqrFEMp?=
 =?us-ascii?Q?nh22iHsilu4juKrjVL9sD4WF8fKE5fbWF7cAqp4lKAO7susVQkRn50hJjf1d?=
 =?us-ascii?Q?UjS/HaM+fpA0sYsnS/Gt6xT3lJ/8YN/kfRAGYBX5cMDLFw7DASJWnhyVC/h/?=
 =?us-ascii?Q?nVtt5b8u+iyT4978qFbZZCi/YMb1yMHoXDXz4M70eq4HQdsGE7n+l3FxSFEh?=
 =?us-ascii?Q?Kt/4N9sM1J7IB3v+MfOXKFzk7vFeZ3NLonawror+J+TRFtjrjbPP1bRvwEZz?=
 =?us-ascii?Q?MjoHuo+u/3lwO+28GAeD5lcPDXF/cBN/lmm9zom0iAEIhHIPOqso/Glfl/Hz?=
 =?us-ascii?Q?8JxIdhOUsUL0QhH+0b8PNEEqyLM2cZFB9xR11A15bNQC8m5jsjKhIGzwHLrm?=
 =?us-ascii?Q?/hB2Nlx0JgPzN/cMehzRfQFc+wqd59M8zIed9WMSeK9NJcs5PDCwsPLSCJ3x?=
 =?us-ascii?Q?YH8zOeuvkpyFK701qEqzvpbq/Dl2dD10PsJh4/U1zGDpGuYyS4sg1Vvb05/a?=
 =?us-ascii?Q?+MK/R6kLvwKCO/4EDtUwu+NhQyIG8l/WlXqzbR2cIfd6IHQnj8ynWDr3bNIq?=
 =?us-ascii?Q?7y9FzXpDaQRH/B6nsIFMDlRsWQxUJQGI7YnFKVZKW3jsfyZrwD93gkrI3vWS?=
 =?us-ascii?Q?qzSSxCYiEeqvMzrc3780nHqEdh0W9Ta1fV2JqBchmux//rTphh4WFZOtU5L0?=
 =?us-ascii?Q?ZTtafCz4ua7Wa1E9qeVy/mku89ZULsRgvNzmd80MxkQTOhfWtFbRfr/KHVf5?=
 =?us-ascii?Q?wMXueq64ZOrDXyvkDP3hcCACrzwIqlvkwIFYX9/mkppE5tbuf4KipwgYq+1C?=
 =?us-ascii?Q?ovKA1z7ItsF0lK7vgJE/8h4gcvWyAy3liqhdXGI/hSK5nOhld4aLngPJsv/x?=
 =?us-ascii?Q?g+I4hNbxZqFtsqFRL7OgAp9alf+wa/1fZMSj/CyU4zAJq/xIQeIYgL7Nh3MV?=
 =?us-ascii?Q?/kRNQzasRFHn93n8jK1ZOVArdH42y42DWQXSTcJAjJCRRfNBJatF41cSOuKr?=
 =?us-ascii?Q?LthJrCaglYixwBiriOj+Qz5weR9m+VqNTDLZtfpSRIm17hyrpsTVadJv0Gt5?=
 =?us-ascii?Q?bFn6c80NeCuXNxEABX0LcvsFqSIDd3JgFrv1RRindQKicr8O1DL7Fdpu1LAD?=
 =?us-ascii?Q?BhXwHXscehwCFXFmTP12xj8sFWQmAjEu5tMjgUSjUXnrfGolrYj904P5W1Bp?=
 =?us-ascii?Q?ui59ZdbhdYHkR0BKJsz1a/1dUoiuJ5A+TDUjbb+T5/NMqM61CE+f9do3go/Y?=
 =?us-ascii?Q?ZqXl6nhmPjE+G9dk5/8BdkAiCt9Fa6Tao+D8WqAqHm37GnUxyzBExIEbuxt8?=
 =?us-ascii?Q?Wti8gUSJGOVxEM1laKxTvY3VhqeXCwOIV6qRDU+ZqqinMEWLetW6bIKzUNqx?=
 =?us-ascii?Q?3dwpKRgwHMNkl9zR9R9yaV9yowYEYPouIfHV/TTemczLD0zijz86W6LDQxRH?=
 =?us-ascii?Q?nXp4KyGSpcouew3ko0oG5Wk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5970ec0a-2b2a-4355-25bd-08dd4e5fda77
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 07:59:35.2980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msb4M2xyVsqXNa6+V4ZTsvf21ZdZOC9Shy5DbukpcSrod751jQK59MC7SuZOLWJzptRiihf/OBQTEIYYuYMs4IfTeICyJsJ4oijrYDAC/B8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10572

Popular bpi-r3 pwm fans like this one

  https://www.amazon.com/youyeetoo-Barebone-Fan-BPI-R3-Integrated/dp/B0CCCTY8PS

will not work properly. Trying different pwm setting using a command

  echo $value > /sys/devices/platform/pwm-fan/hwmon/hwmon1/pwm1

I found:

  pwm1 value     fan rotation speed   cpu temperature     notes
  -----------------------------------------------------------------
    0            maximal              31.5 Celsius        too noisy
   40            optimal              35.2 Celsius        no noise hearable
   95            minimal
   above 95      does not rotate      55.5 Celsius
  -----------------------------------------------------------------

At the moment we have following cooling levels defined:

  cooling-levels = <255 96 0>;

for cpu-active-low, cpu-active-medium and cpu-active-high modes
correspondingly. Thus only cpu-active-high and cpu-active-low are usable.
I think this is wrong.

This patch fixes cpu-active-medium settings for bpi-r3 board.

PS: I know, the patch is not ideal as it can break pwm fan for some users.
    There are some peoples that use handmade cooling solutions, but:
      * discussed cooler is the only 'official' pwm cooler for bpi-r3
        available on the market.
      * most peoples will use passive cooling available on the market or
        the discussed cooler.
      * the pwm-fan dts section was added before the official cooler
        appears on the market.
    Thus it should not be a lot of harm from this fix.

This patch may not be enough. Users may wants to tweak their thermal_zone0
trip points, thus tuning fan rotation speed depending on cpu temperature.
That can be done on the base of the folloving example:

  === example =========
  # cpu temterature below 25 Celsius degrees, no rotation
  echo 25000 > /sys/class/thermal/thermal_zone0/trip_point_4_temp
  # cpu temperature in [25..32] Celsius degrees, normal rotation speed
  echo 32000 > /sys/class/thermal/thermal_zone0/trip_point_3_temp
  # cpu temperature above 50 Celsius degrees, max rotation speed
  echo 50000 > /sys/class/thermal/thermal_zone0/trip_point_2_temp
  =====================

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
index ed79ad1ae871..b0cc0cbdff0f 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
@@ -42,7 +42,7 @@ fan: pwm-fan {
 		compatible = "pwm-fan";
 		#cooling-cells = <2>;
 		/* cooling level (0, 1, 2) - pwm inverted */
-		cooling-levels = <255 96 0>;
+		cooling-levels = <255 40 0>;
 		pwms = <&pwm 0 10000>;
 		status = "okay";
 	};
-- 
2.47.2



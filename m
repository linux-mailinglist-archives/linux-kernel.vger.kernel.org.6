Return-Path: <linux-kernel+bounces-205777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3F590002A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6463B1C20341
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAEE15FD19;
	Fri,  7 Jun 2024 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="roTqp7YB"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2047.outbound.protection.outlook.com [40.107.105.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B453515F30D;
	Fri,  7 Jun 2024 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754464; cv=fail; b=CjZmgMMY3E8/9KUIkJNkmxpqph2H3PbUK+AMX5no5tB5T9fs7VFvBfTsxyBK1B/qu6AldMr/VB/VuBnN5PQ7Iagr9rudrafx2RtbWvkzzq+vzhI+AH3DaS5CjissIeK2BTEz3J5rRWFN9KX2Sq4wKA1/DJ08/OjkfD7I6CpH5cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754464; c=relaxed/simple;
	bh=2ETKfb8VK13PTpYLFe3lnJNuwIXowCxaZWOea5Pv7io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZS1pjL1uDpSthBwjY3wCmFOnAFjnw7E0tf5/L/C85KVzUMSJjs/3x4QYcNF5wEEe9rguw002cLwnEVNsFNHWoigaNRiGnbKNhu6oSVN2LwyJSRhkTYLjKB/MNhVeWo/i49M0MuywZ6qzA2ihHLx8zdNxvkOIfD7pJl72D8cx/z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=roTqp7YB; arc=fail smtp.client-ip=40.107.105.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KW4s/o1dK9+1Sply5NjHK8/xNHLSQXxzioB1DyXN23aBRoCkEQp/UWVYI0R0x3+9G6+DcUgsSFoH5kWSUnfa5obji1T8KmYe/lkXE6O3RFfg9AyTJaxB89YxYSy3ZY6GDFL5Ldot76Idb7ko08hayPbJ0AI+bXkH7qTZ+ck0XvYn0K98RZ8IRSlxMWPMDE7+6F0yLOIpZ7Z9+NB8QSPmDhC6tu8HAte25e0FFG9hjGCZhaNu25K0LdLAjuCMrDh4kbqXD7L/QKV6S7zeLusmCHhJFULZYJEPveGV5+Mpl6ONBZljeNCmTp6A5gGyOj9CU9XnFXrKif2XOTG4XnPmhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1ZWXcyDO3jwG8kkAMerrUqvg4yIbozd2NQHtmO25kY=;
 b=BpAYKNLMHBeFZzGtdeO5klOne34KpMacY9A7GQvCWNR7YFnNE+4zJRUFzqZ1mAzmAnIm5Ije4+K1M6Cpo7woR7PnlmWaAvcQ3MP9FpFxo/aPjWZiwUN9aWGC5wXK1W0QvOV6st0YuYFUub/ZegW0phInNxq+nPNufJevnDOIWB1NFyTxud6Y01izzdk8WKWkT+uf9VVvbimztc1tVbPUcadHacyijsWaQHWrxiYGyhh51ZFzKdgLkDbJbApx0o1wG/P9Z+BxlkBYHOC+JfJfyXOa2w+jaLnfthxUYXsXj9QAxqr5mrY4aCGvRv2o0JQQJ1sqabjc78N3p5Wf7MxgNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1ZWXcyDO3jwG8kkAMerrUqvg4yIbozd2NQHtmO25kY=;
 b=roTqp7YB2Jz+2DUX+vlnRMdqasHyLnrz4yeaS8gl37mbrKT5IEQFcHubTsB5qcVZltEf6LMmJg25enhhVn6A5MrZwTWPAAlZqgRDjiM0Rg0tYWPUjbjshHmB6mH1baDOdZV/b/d55WEifHE2PPFidfN1Ka0b5O88xA45jtIUy3Y=
Received: from AS9PR06CA0147.eurprd06.prod.outlook.com (2603:10a6:20b:467::19)
 by DBAPR02MB6152.eurprd02.prod.outlook.com (2603:10a6:10:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 10:00:56 +0000
Received: from AMS0EPF00000195.eurprd05.prod.outlook.com
 (2603:10a6:20b:467:cafe::ab) by AS9PR06CA0147.outlook.office365.com
 (2603:10a6:20b:467::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.18 via Frontend
 Transport; Fri, 7 Jun 2024 10:00:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000195.mail.protection.outlook.com (10.167.16.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 10:00:56 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Jun
 2024 12:00:55 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 7 Jun 2024 12:00:55 +0200
Received: from pc49102-2217.se.axis.com (pc49102-2217.se.axis.com [10.88.7.5])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id DD2A93349;
	Fri,  7 Jun 2024 12:00:55 +0200 (CEST)
Received: by pc49102-2217.se.axis.com (Postfix, from userid 9470)
	id D74706476FDE; Fri,  7 Jun 2024 12:00:55 +0200 (CEST)
From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Date: Fri, 7 Jun 2024 12:00:46 +0200
Subject: [PATCH v2 2/2] tlv320adc3xxx: Add support for using MICBIAS pins
 as GPO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240607-tlv320adc3xxx-micbias-gpo-v2-2-b140a45ffffe@axis.com>
References: <20240607-tlv320adc3xxx-micbias-gpo-v2-0-b140a45ffffe@axis.com>
In-Reply-To: <20240607-tlv320adc3xxx-micbias-gpo-v2-0-b140a45ffffe@axis.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000195:EE_|DBAPR02MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cac7c60-98e5-44a9-d4d1-08dc86d8b986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|7416005|1800799015|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0k4WWVDMndpd0xGV1hGeFlHRUhmdE1MZ1ptY2JUM2pqZ0VxNjJrQUpPTVgy?=
 =?utf-8?B?bk1HZk1OaC9lV05HMEFzaDdiQlFzdVlGRHdzOVFaRnRGU1dXWnlsY2hnMkZ1?=
 =?utf-8?B?aVc0VlhaWnNWT1ZoMThwWDZWYno3NktGejlDTWZBMDc1RFF2dW5vNG1rQ2kz?=
 =?utf-8?B?bGNQRmV2UjA1azNsdDlpZ1RoZzIvZXJFWEwvUm4rbm9TejVvRndqdWp4c0VC?=
 =?utf-8?B?VHo0QkxpR3lrKzJ0T05Da1NWWmpuRHJHRkVmcmdIUmZiTkNFSlMrcFU4aFFm?=
 =?utf-8?B?bDE2N2wvd1lVMXFzSW5jbDZXdW4vbDJMcVpsUWVETXM0cFJjMGd2NWNpcCts?=
 =?utf-8?B?VGpPSEVHOHhLNlV6WGRlc0xWdEk5TjFZbzhjVGZBU3YyWVJjSFlyN0FPaTg2?=
 =?utf-8?B?bkpXTm1WL2JyWnh3S1FLY2lnYWdzKzR0c3hNSjEweWRWS0IydjcxdGtCbjZt?=
 =?utf-8?B?UkhIVzRWQ2FZeUVsd2V0WDA0SDl3T1ozaFloemgyZUgyZzBySDNEVmIxbE5U?=
 =?utf-8?B?Q1hxU0t6YUNVOTdFaUgrYjB2MllLVTVsQ3BHZlBWVzJhWldmUU9JTUpNUlhR?=
 =?utf-8?B?UUN4dHVoR2htWmR5OTVnN3FRdGN3aDVZeTgxNUlIYWg0TUZwMnpyRVhjUStn?=
 =?utf-8?B?WXJIUHlRR1FMekdsWmdIWFU4RHZSQ29uckwzelkrUzR6UWtNNkZBeU1RNFdD?=
 =?utf-8?B?MlpMai96NlFGUGlqMEt2dkx3dXFnUnhDOFBGZmlTL0NYWGRTV1Z4RTNFS2ta?=
 =?utf-8?B?T2JkOXJoMHVYYSt1d2ZZbXFna3QzVFc3djBJL0Fhd2NjbzBpcURENi9pblZK?=
 =?utf-8?B?SzlCZ3grSWd4eXd6OUx0MTFSVDczUVI4STYybElOUVljUWtSN3NXbWZXVVIx?=
 =?utf-8?B?b2E5MXdVUE02b3M4WTdZdG91QUZxbXJrckpzQUhxQ0RQZEdlRjZWNnpOV1FU?=
 =?utf-8?B?cWZhODA3VzY2Vm03Y2NDUmExNWYwaTVtY21PTXJnNSttbUw0Qm05aEwrSUJ3?=
 =?utf-8?B?L3VzRWdEWVpkVWJ1V0VORHpmSG5lQVI2TmlIT2RuYVZTSG83Ny9Ld25aOTNu?=
 =?utf-8?B?aU9OdUdoVUVDL3VoWXMxTzdpYlRLSkJCMG14RHJWdWpCdG5idkVPenhSK29r?=
 =?utf-8?B?bVNVZVhFL2xmZGlpZUxXV3JhRmFZSll6eTZqVFI3clRXa1huQ3BnSzRTZFlO?=
 =?utf-8?B?dFJMOWlpUFM0QllIQXFkY0JKd3dpbzNJSnFoSEE2dC81SE1HemxjaXhyZE8r?=
 =?utf-8?B?cjZkTmpNcGltYWxNRmVhZTI2dytYci9rZ0lpL0txRHd5dnQ0dTUydFdlYitQ?=
 =?utf-8?B?WWNrNi94NkRwVUF0akEyWnIxTXlTMUM4eXNRYldvRVp5RERhS0xMaExycHZV?=
 =?utf-8?B?NXVMdERqcWdVRWVuaExYZ3hsZGp4VUg5OG1QSXF6S0U2NUN1ZWErc1U5ZFFE?=
 =?utf-8?B?VGIrMWJRUERYbzkwNlJqOGhBYkVaZkQrbXVOcWw1c1l2dzdvYmh4NURrOSsy?=
 =?utf-8?B?a0RrRmZzbXNWKzdGMFpmZk00WjBEK2ppTW9jTzhndEEyTEVHRFVDbTVEdnZX?=
 =?utf-8?B?RW8zQytVd0VaVU5CekwwL25XQkduNlgvTXNwZWR6RkZxZHQvMlFOTHBlaHh4?=
 =?utf-8?B?MXM4N0o5eDZFdjhNcElUTDRmd0JWckZhUHIyQkRKZzY0WUlqNjUxQ2ZIQUtU?=
 =?utf-8?B?aEUrQXNVVk9XU29ZSFBqb2o1RFVucllHY3o5Qm4xS3hwNUhwUG8zUDM0QXhE?=
 =?utf-8?B?MVlNZmNtdEdSNVQwcFNIRnJ0N2k1eCtkMlBSdmxFL3I2WHU5Yi9YT21iaWsz?=
 =?utf-8?B?UXpGUWJmQUE1dWlXOHUzRGtHaGs4cEE0Q3dEUy90V3JucDVnbHVrTjJPbzVq?=
 =?utf-8?B?cC91UnZDRGh1TDBBUVpoVERPR0hGK1Q2dElpZEZRaWVtSWtQRWV0ODQrR3R2?=
 =?utf-8?Q?lJ6X8zcGceM=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(7416005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 10:00:56.3134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cac7c60-98e5-44a9-d4d1-08dc86d8b986
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6152

Add boolean ti,micbias1-gpo and ti,micbias2-gpo devicetree properties.

When set, the respective MICBIAS pins can be used as general purpose
outputs controlled via the GPIO framework, in addition to the two
configurable GPIO pins.

This is useful in applications where the MICBIAS functionality is
not required, but it is useful to have a couple of extra GPIO pins.

The voltage on the respective MICBIAS pin in the active state is
governed by the ti,micbias1-vg and ti,micbias2-vg properties,
respectively (same properties as when the pins are used as
MICBIAS pins).

Signed-off-by: Ricard Wanderlof <ricard.wanderlof@axis.com>
---
 sound/soc/codecs/tlv320adc3xxx.c | 105 +++++++++++++++++++++++++++++++--------
 1 file changed, 84 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/tlv320adc3xxx.c b/sound/soc/codecs/tlv320adc3xxx.c
index e100cc9f5c19..182955bccebc 100644
--- a/sound/soc/codecs/tlv320adc3xxx.c
+++ b/sound/soc/codecs/tlv320adc3xxx.c
@@ -40,9 +40,10 @@
  */
 
 #define ADC3XXX_MICBIAS_PINS		2
+#define ADC3XXX_GPIO_PINS		2
 
 /* Number of GPIO pins exposed via the gpiolib interface */
-#define ADC3XXX_GPIOS_MAX		2
+#define ADC3XXX_GPIOS_MAX		(ADC3XXX_MICBIAS_PINS + ADC3XXX_GPIO_PINS)
 
 #define ADC3XXX_RATES		SNDRV_PCM_RATE_8000_96000
 #define ADC3XXX_FORMATS		(SNDRV_PCM_FMTBIT_S16_LE | \
@@ -321,7 +322,8 @@ struct adc3xxx {
 	struct gpio_desc *rst_pin;
 	unsigned int pll_mode;
 	unsigned int sysclk;
-	unsigned int gpio_cfg[ADC3XXX_GPIOS_MAX]; /* value+1 (0 => not set)  */
+	unsigned int gpio_cfg[ADC3XXX_GPIO_PINS]; /* value+1 (0 => not set)  */
+	unsigned int micbias_gpo[ADC3XXX_MICBIAS_PINS]; /* 1 => pin is GPO */
 	unsigned int micbias_vg[ADC3XXX_MICBIAS_PINS];
 	int master;
 	u8 page_no;
@@ -329,7 +331,7 @@ struct adc3xxx {
 	struct gpio_chip gpio_chip;
 };
 
-static const unsigned int adc3xxx_gpio_ctrl_reg[ADC3XXX_GPIOS_MAX] = {
+static const unsigned int adc3xxx_gpio_ctrl_reg[ADC3XXX_GPIO_PINS] = {
 	ADC3XXX_GPIO1_CTRL,
 	ADC3XXX_GPIO2_CTRL
 };
@@ -960,14 +962,23 @@ static int adc3xxx_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	if (offset >= ADC3XXX_GPIOS_MAX)
 		return -EINVAL;
 
-	/* GPIO1 is offset 0, GPIO2 is offset 1 */
-	/* We check here that the GPIO pins are either not configured in the
-	 * DT, or that they purposely are set as outputs.
-	 * (Input mode not yet implemented).
-	 */
-	if (adc3xxx->gpio_cfg[offset] != 0 &&
-	    adc3xxx->gpio_cfg[offset] != ADC3XXX_GPIO_GPO + 1)
-		return -EINVAL;
+	if (offset >= 0 && offset < ADC3XXX_GPIO_PINS) {
+		/* GPIO1 is offset 0, GPIO2 is offset 1 */
+		/* We check here that the GPIO pins are either not configured
+		 * in the DT, or that they purposely are set as outputs.
+		 * (Input mode not yet implemented).
+		 */
+		if (adc3xxx->gpio_cfg[offset] != 0 &&
+		    adc3xxx->gpio_cfg[offset] != ADC3XXX_GPIO_GPO + 1)
+			return -EINVAL;
+	} else if (offset >= ADC3XXX_GPIO_PINS && offset < ADC3XXX_GPIOS_MAX) {
+		/* MICBIAS1 is offset 2, MICBIAS2 is offset 3 */
+		/* We check here if the MICBIAS pins are in fact configured
+		 * as GPOs.
+		 */
+		if (!adc3xxx->micbias_gpo[offset - ADC3XXX_GPIO_PINS])
+			return -EINVAL;
+	}
 
 	return 0;
 }
@@ -977,6 +988,21 @@ static int adc3xxx_gpio_direction_out(struct gpio_chip *chip,
 {
 	struct adc3xxx *adc3xxx = gpiochip_get_data(chip);
 
+	/* For the MICBIAS pins, they are by definition outputs. */
+	if (offset >= ADC3XXX_GPIO_PINS) {
+		unsigned int vg;
+		unsigned int micbias = offset - ADC3XXX_GPIO_PINS;
+
+		if (value)
+			vg = adc3xxx->micbias_vg[micbias];
+		else
+			vg = ADC3XXX_MICBIAS_OFF;
+		return regmap_update_bits(adc3xxx->regmap,
+					   ADC3XXX_MICBIAS_CTRL,
+					   ADC3XXX_MICBIAS_MASK << adc3xxx_micbias_shift[micbias],
+					   vg << adc3xxx_micbias_shift[micbias]);
+	}
+
 	/* Set GPIO output function. */
 	return regmap_update_bits(adc3xxx->regmap,
 				  adc3xxx_gpio_ctrl_reg[offset],
@@ -1005,9 +1031,17 @@ static int adc3xxx_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	unsigned int regval;
 	int ret;
 
-	/* We only allow output pins, so just read the value set in the output
-	 * pin register field.
-	 */
+	/* We only allow output pins, so just read the value prevously set. */
+	if (offset >= ADC3XXX_GPIO_PINS) {
+		/* MICBIAS pins */
+		unsigned int micbias = offset - ADC3XXX_GPIO_PINS;
+
+		ret = regmap_read(adc3xxx->regmap, ADC3XXX_MICBIAS_CTRL, &regval);
+		if (ret)
+			return ret;
+		return ((regval >> adc3xxx_micbias_shift[micbias]) & ADC3XXX_MICBIAS_MASK) !=
+		       ADC3XXX_MICBIAS_OFF;
+	}
 	ret = regmap_read(adc3xxx->regmap, adc3xxx_gpio_ctrl_reg[offset], &regval);
 	if (ret)
 		return ret;
@@ -1049,7 +1083,7 @@ static void adc3xxx_init_gpio(struct adc3xxx *adc3xxx)
 	 * This allows us to set up things which are not software
 	 * controllable GPIOs, such as PDM microphone I/O,
 	 */
-	for (gpio = 0; gpio < ADC3XXX_GPIOS_MAX; gpio++) {
+	for (gpio = 0; gpio < ADC3XXX_GPIO_PINS; gpio++) {
 		unsigned int cfg = adc3xxx->gpio_cfg[gpio];
 
 		if (cfg) {
@@ -1061,9 +1095,15 @@ static void adc3xxx_init_gpio(struct adc3xxx *adc3xxx)
 		}
 	}
 
-	/* Set up micbias voltage */
+	/* Set up micbias voltage. */
+	/* If pin is configured as GPO, set off initially. */
 	for (micbias = 0; micbias < ADC3XXX_MICBIAS_PINS; micbias++) {
-		unsigned int vg = adc3xxx->micbias_vg[micbias];
+		unsigned int vg;
+
+		if (adc3xxx->micbias_gpo[micbias])
+			vg = ADC3XXX_MICBIAS_OFF;
+		else
+			vg = adc3xxx->micbias_vg[micbias];
 
 		regmap_update_bits(adc3xxx->regmap,
 				   ADC3XXX_MICBIAS_CTRL,
@@ -1091,8 +1131,19 @@ static int adc3xxx_parse_dt_gpio(struct adc3xxx *adc3xxx,
 	return 0;
 }
 
-static int adc3xxx_parse_dt_micbias(struct adc3xxx *adc3xxx,
-				    const char *propname, unsigned int *vg)
+static int adc3xxx_parse_dt_micbias_gpo(struct adc3xxx *adc3xxx,
+					const char *propname,
+					unsigned int *cfg)
+{
+	struct device *dev = adc3xxx->dev;
+	struct device_node *np = dev->of_node;
+
+	*cfg = of_property_read_bool(np, propname);
+	return 0;
+}
+
+static int adc3xxx_parse_dt_micbias_vg(struct adc3xxx *adc3xxx,
+				       const char *propname, unsigned int *vg)
 {
 	struct device *dev = adc3xxx->dev;
 	struct device_node *np = dev->of_node;
@@ -1383,16 +1434,28 @@ static int adc3xxx_i2c_probe(struct i2c_client *i2c)
 		dev_dbg(dev, "Enabled MCLK, freq %lu Hz\n", clk_get_rate(adc3xxx->mclk));
 	}
 
+	/* Configure mode for DMDIN/GPIO1 pin */
 	ret = adc3xxx_parse_dt_gpio(adc3xxx, "ti,dmdin-gpio1", &adc3xxx->gpio_cfg[0]);
 	if (ret < 0)
 		goto err_unprepare_mclk;
+	/* Configure mode for DMCLK/GPIO2 pin */
 	ret = adc3xxx_parse_dt_gpio(adc3xxx, "ti,dmclk-gpio2", &adc3xxx->gpio_cfg[1]);
 	if (ret < 0)
 		goto err_unprepare_mclk;
-	ret = adc3xxx_parse_dt_micbias(adc3xxx, "ti,micbias1-vg", &adc3xxx->micbias_vg[0]);
+	/* Configure mode for MICBIAS1: as Mic Bias output or GPO */
+	ret = adc3xxx_parse_dt_micbias_gpo(adc3xxx, "ti,micbias1-gpo", &adc3xxx->micbias_gpo[0]);
+	if (ret < 0)
+		goto err_unprepare_mclk;
+	/* Configure mode for MICBIAS2: as Mic Bias output or GPO */
+	ret = adc3xxx_parse_dt_micbias_gpo(adc3xxx, "ti,micbias2-gpo", &adc3xxx->micbias_gpo[1]);
+	if (ret < 0)
+		goto err_unprepare_mclk;
+	/* Configure voltage for MICBIAS1 pin (ON voltage when used as GPO) */
+	ret = adc3xxx_parse_dt_micbias_vg(adc3xxx, "ti,micbias1-vg", &adc3xxx->micbias_vg[0]);
 	if (ret < 0)
 		goto err_unprepare_mclk;
-	ret = adc3xxx_parse_dt_micbias(adc3xxx, "ti,micbias2-vg", &adc3xxx->micbias_vg[1]);
+	/* Configure voltage for MICBIAS2 pin (ON voltage when used as GPO) */
+	ret = adc3xxx_parse_dt_micbias_vg(adc3xxx, "ti,micbias2-vg", &adc3xxx->micbias_vg[1]);
 	if (ret < 0)
 		goto err_unprepare_mclk;
 

-- 
2.30.2



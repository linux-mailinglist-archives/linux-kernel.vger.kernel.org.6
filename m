Return-Path: <linux-kernel+bounces-368415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 933929A0F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A211F27936
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5AC210C33;
	Wed, 16 Oct 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="domwBhOO"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66281C878B;
	Wed, 16 Oct 2024 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095808; cv=fail; b=XDUeOK9PILt1GMtXw++KqpgLQAW9JOXzcEJjDIbMHcZjrxkkiiXNZO0j2WFuatYOlG7wu3SYbKdxVi/RSMAzW0P1AbcW3JTXiS4//hfIVl7570yDhixEXdrE6NQPscFu36YUcKnAQt/y05j72d/weFl+pPsR6geHIonDKnx8GMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095808; c=relaxed/simple;
	bh=+dpiySDz8vsFXVv0IQq3AL4vjQRI9ghq2INCCWn3234=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=mnAFj7lCJpaonhcISL+lXi8WXLVKq6e8/PFKYb34zS1oEG9JxNeUTVF9wA9iwOknz42fJTyWLTRkGbFrmEkdN1V0HIE0/m/9/1t7hG8J3Xa0HExlpXM140NIyq6N2cbS16fjwmJQ1f1lWwVoCgYkvm434yHT9S+2daTf0kxfKeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=domwBhOO; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkknVPsCQLZg9v0VGXox85guwY8b+Z06CZyTuS88TZKBJ563t027q4XhicJP+8z0Kzh2Vx6aYN8anVJQCRf7WU/9TenjQBgQ2xXUdqlByDsy1ovGPzb/Azwj7Ia9mkycNC5OpownlcRNGzG9G7fBB3dwYcPvfmqgCkaJKwCyXg09NNSNUucaiyjZ2wYqUh205S0tPipdodaUJ6SVI5GH24VxqokmuTnls1yYjOK/4q93U0tnQEcezzQ4/6fOULxD+cuIGItnmXMedycL+Ox4uhLknQeChHuVF04QVTFZip+y0DiRfMXWw/hYI1Iiy0bi6zxZQorim5IyYg/7xlbVhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30um4cK80ybjAYbvEgl6yVrxzP11FlGtfBIwNz16t4c=;
 b=OuMnrkBn4j44AEFDCkGgyouHsJkHBslm1JrCOZR2UPqpWo7rmLWLopGOpEKilx6nR0WDQkjv+Wo2699wWJUiYX+XB3zajupS82+PoOSaMDgQfbpXvpzk9mMj2+IcliJ95vkcA1HSR4RKctOg7/6TLgjmxpgkFe96sJADnPNUbdU+42Q7s9vMYpkHl6thJqZNHViZGGkPd0V1PQr70bE9Y3zOiwyiC53PmX9DGRlS/VmWzi5473FlqoVJxSNwo8nfkyIX6WmJn8+QvuEYW+FIMnml0kzsBHyw5my5XdDXfsVUOn0sc6xGUBsHYSZp5lzUJafjsQAMIvXdao5Hm7pbhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30um4cK80ybjAYbvEgl6yVrxzP11FlGtfBIwNz16t4c=;
 b=domwBhOO+x0qQWlJZVguKjiWae49WoBZAlyQ6jpvvqfOf7S48lQ9SVFCNuvFppbHJuVTX4R2pB1VOP6wc0MveOa0NrvXBUqGC7VBZ1dkgXQSrpF3tQVGHUp6NoCmoFMsD3aX9GpO/x8DWwKvyaEIH9v7eILedlGHfBoB35EhLmiJfguyoSh8M0j8QJ3Dt3mQH+4vnCVovUHXd0zQAGZmKV8YCTze7ZMyLPaWazoddpktsX2wQhkzjR1CZEWLEa75KFPqeVb5zzf4wydUctWYep4u2Ky6PlEAMHs/fFtxi2wXZLA4s1N00WzWXdB8LGwkUfwWI/sk9KXQ89ZWYLBc5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8599.eurprd04.prod.outlook.com (2603:10a6:10:2da::7)
 by AM0PR04MB7043.eurprd04.prod.outlook.com (2603:10a6:208:19b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 16:23:22 +0000
Received: from DU2PR04MB8599.eurprd04.prod.outlook.com
 ([fe80::763:eb3b:6607:1e72]) by DU2PR04MB8599.eurprd04.prod.outlook.com
 ([fe80::763:eb3b:6607:1e72%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 16:23:22 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v9 0/5] v9: firmware: imx: driver for NXP secure-enclave
Date: Wed, 16 Oct 2024 21:48:57 +0530
Message-Id: <20241016-imx-se-if-v9-0-fd8fa0c04eab@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHHnD2cC/13QzU7DMAwH8FeZcibIdr458R6IQ9akLId1U4uqo
 qnvjlshmuxoK7+/7TzElMeSJ/F2eogxz2Uqt4GL8HIS3SUOX1mWxLUgIA0GnCzXRU7c7WXUAMZ
 AUKmzgt/fx9yXZc/6+OT6Uqbv2/izR8+4df9SEKqUGSVIcp2J1umANr0Py/21u13FljFT5UjVj
 tgx6hP6EI0KrVOHs1hvPSt20SXyKUfT6dg6fTgHpnZ6m0cJADL6iE97msoh1c6wsza6EEBF76h
 1tnLUOMsuZ7Jszp6e93SHC6Br5/Z/6RPFs9Nkdev8v0PA5j7PLqDRyvNQl9Th1nX9BdWq1a0oA
 gAA
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729095547; l=19552;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=+dpiySDz8vsFXVv0IQq3AL4vjQRI9ghq2INCCWn3234=;
 b=r+UMdcaMmWCCR5iEK2XqSaQzheRbvJVozmIAeZ88MH9t3dRpUHl8A+7TwyVWN+zFfqfIZfEiK
 zCTYMP2PwR6AYyfSy6ijlfaRkh5eB6WlMRelMX5LnGeVVYNB+PMBKPQ
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:3:18::25) To DU2PR04MB8599.eurprd04.prod.outlook.com
 (2603:10a6:10:2da::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8599:EE_|AM0PR04MB7043:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc06512-4217-4391-4e0c-08dcedfeda86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Znc3Q0gvT0psVVV4WFJHL0RUcGpYRnZvZ1Q3bTFzNmRSTzRTZDhyaVdyQ2sr?=
 =?utf-8?B?RnRmVlFhRWdjRThrSmlGRXVuWEV3UlovMVVKWGFkUGVEM2V1MTd0VHhZNXB1?=
 =?utf-8?B?Ulg2SGdBTHF2ak5idVQ5czY0OGJ5d3Z5S3NJY0NBclRJc2Myd1BXVUQ1QUtu?=
 =?utf-8?B?T2VKcE5KV2dzMU51c3hiTzE3cU5xUDIzc2J1bjRlTFJZSVN3YnhZMmd5M2pz?=
 =?utf-8?B?cmRVWkZqdGJ6SEJ4NjQzYXRaRGhhRHZHd1AvVFFFWXI3WG10ZHFzMkNjVWxk?=
 =?utf-8?B?VFNOTU5XOU5ENU9PNlBhU2Z3bHhUNjdZVDI5bTlxd3paZGQzNG5sTVluV2V4?=
 =?utf-8?B?UmVlSmJmMVN4NDdQTkhqcDZYRlVZMHFnOTJDZ0JGSkZHZDNRdTBVZWFITUlx?=
 =?utf-8?B?UWJ4ZVIwRG1IYWJFQnJLakgvM21QUzdPZDNCOXpqMWtXVFhNSmQ1ZmdWVWdt?=
 =?utf-8?B?UnNkNnhPeWpQdXZFZ1k2YmdBd3JTN2k1bE9hQ3ZoRWR2SUtoUmxSOXlWTThS?=
 =?utf-8?B?ODVycFJZWS9uNGJFZEp3QjI5SmcrMTBwNDFhS1VlSlhabEpBS0ZuamNsSG5m?=
 =?utf-8?B?bmlNazhRLzF2MzRJY2Ewd3drWGp6UHIxbGdnSm5PN2NTNDNBTEVTTTMwdWM3?=
 =?utf-8?B?aU0zV0dkbWpES09JclphT1lPSHh0b1RCRHBuMXVXTDRzdGZNNHBrYWlHT0lC?=
 =?utf-8?B?eDdIWkk4dlptK294RGprZ0ZSWjR6Uzc2RzVXZllicDlCUHM3S1R1Nm0vd0p5?=
 =?utf-8?B?cC9QS0IxUmtwcUZtRHIrcU5qbGxJRnJUMk0xNlZ5Z2VNand1cUtLV2xMNUdU?=
 =?utf-8?B?b3g5aW1ET1dMN1J5c0dHWGxTSEJsNytoVE85NG45bTR5Q2NnL3NlRDZNV01C?=
 =?utf-8?B?RTRLV3RpaGxhYXhhZWpYRkJqaTE2aWd1VDJNUmkyU21tMnIvY3pYSnhQL0Z4?=
 =?utf-8?B?LzB1N1hEQm5nL2NuSDdCM3F0MEU4RElBcWpUUndiYzd3VjI0cGNvNG55bTh5?=
 =?utf-8?B?REkzQnJqR2djY1RnMCs1Q243UTN1TnpLTFVMTFhLc1JZajY2dWoxa2J0UHRh?=
 =?utf-8?B?Y1hsNDlZYUREUmhqaGhmU09YaGZ4cFhSTTJIc0FrMVRCY1RTemJicTZGNUxG?=
 =?utf-8?B?TlFkeWpscU1kLzBKTFpNY0ZnNk1MUU5HekduY1hyOXgrMlY4VTlBNGVYY05J?=
 =?utf-8?B?SnZ2TU5mbUxJeWlVNU1NQ1UwRlArTmZxOFFqRDR0OVRzaG5kUTJMV0JmWnVT?=
 =?utf-8?B?R1pXV20yckJhSXhUSjZ6YnJNeFBQQldFYXVEWVhwS2UxUFlPR1Iwd1BzVVgr?=
 =?utf-8?B?RHhYVk45OUk1WFRQZWJETzFSTXVleHZZaFZsaGV3WUs2QlZXNHBlbmt3bjZ4?=
 =?utf-8?B?cHVXbEl0KzBudEJPTUs1VHc0NU04dWtKUm9KMWF3dXpLSEFQK0hYY3VrcmN3?=
 =?utf-8?B?T0VRRzJKTzIrOFFib3J2RlVsdmxQeDEyTUlRaS9jYWt5QVM5ZzB6VURVODFO?=
 =?utf-8?B?cjBKYWlmODJFb1k4S2ozQm5xdTFkangxM1RMRVg0c1dhOVh3ek94MnNtTXRH?=
 =?utf-8?B?RGd4cXRkV0VNRXY1cXUvTUxTQlNRUEpNS2cvSmpmdW1YSHNERldzQmVmY2Ey?=
 =?utf-8?B?WmhjWnNOaWo1alVqay85Rnl3eG5hU2FhNGlJMjVKQTBNSUVxZmtTNVNtOGJu?=
 =?utf-8?B?MDQ0ckdrTWljSWNDUHdBMUVQSWtMZTl6UWVDanBSOTJnT1IyNk5aN2JOVHFT?=
 =?utf-8?B?Nm9ZejQ1VC85TzYyUHRnK0l1cTdQekhYNzJmdDZBSUkyZXNha05VMHR0OFhL?=
 =?utf-8?B?TU45TkRIbTR2S3h4ejk4QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8599.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzU2b0d4MmVxRXQwSjhLU2x3SGp0bit0azJyOGt4UUtnRWJKLzVPM0ZZZXdo?=
 =?utf-8?B?eTR1M1lCdlhqWE1EYURhdFFTRGU5ZFhRYWhOS05Ub1dZV3owTlVnNTVJemg0?=
 =?utf-8?B?UncwQ0dRbHI4N2NHc09CSGN6a1hqV1RrL3ozTThpR1dmcldMV0tWTldvY3lP?=
 =?utf-8?B?RzZJUGdaWEpIUjZ1WEp4SlQ2eVMvNWlYWDBRdkl0dC90L25nOGVYQnR0dzlh?=
 =?utf-8?B?OFk4Sjl6K05yR0dua0NoNlQ2K0hkMlpSRGVRSmRwZVJUOTZPNjdzOExrdC9i?=
 =?utf-8?B?dHBFUzlzQmZKTGQvTnZqaUFhMysweW1QVG1xclVMZ2syTXRVR3RUM0t1Z0pn?=
 =?utf-8?B?YzBuYzdBbHVranNMMXAyZGlhb2xWZnlkejhvNXB6eGNPMVlzalpvQUZyZldE?=
 =?utf-8?B?bmJjNTNxK0k0QnA3UUdyOWh0RGhpWTA5aVl2TjQvQjVDVk8rWE5YL2ppalMr?=
 =?utf-8?B?S3F0bHo3QkQyOHFpa0ZOUDV3b2xjdVFVSTR2Y0VDZGluTUZaVWIxbHpsajZR?=
 =?utf-8?B?c1BsMVd3U2pTbWZRS3UydGV5ZFg2ZHNLaVg2TW85QWxnN0RHV2J3K1pNV0xS?=
 =?utf-8?B?NDM1V1lFYnpCSExvc1JmVERNaHQzZWNNRkU0TjV2a25WQlFvM3ZGb0doc2Z2?=
 =?utf-8?B?ZjNkWG0wV3ZGV01CRXFESk9VMUtpbm9OdHhoRlFpUTFSR09sV3dtQTZ4VU9v?=
 =?utf-8?B?czBoc3p5VWJKeWxHYkRKNjRoQmpya2dDTFliODk0VlNuWXk3N0JQOFhIZlQz?=
 =?utf-8?B?bXQwOWh4R2JxL01RaUxUZENHRmsxQ3ZDcm9FZTVMU296R1U1NERvWnpoUDdr?=
 =?utf-8?B?SXNNamgxbmIzZ2ZaZjNCdlhHTjI0VXZEWk9ISTlrMm5wUjJ1SDMwZzk2ZVBN?=
 =?utf-8?B?YkdhWnRDajYrTFhRZjFMZzhFQVFRNUwyWG5QY3BKZGZ2WDlldU9VTTB2dWpF?=
 =?utf-8?B?eW51RG5jcENHd3hkcDNuQXY5bExnVHl4cVo2dzhBOEQxQUR3c0JjcVh4cWww?=
 =?utf-8?B?eVpzbXh2NDExS0ZQcEhlemF5bGsvTjhuTUlqLys0Z21jcXlWSStxSTk0MEc2?=
 =?utf-8?B?UlB6SGc1NkRFWEFQMDVUdEZ1VTNGUUJXWE9adWRpMFE2VWFzd2dWR0VCL25D?=
 =?utf-8?B?WFArMG9ZTWFUQmROMnJEdzV4QVh5enZtM2Z1MHdhQWsycmZuU25EbDZqY2FT?=
 =?utf-8?B?Yzl3TXhibUhUemxNRVhnSkxpbDBEYlgybWJtazZzeklkbjJGbDRIdy9hUzhD?=
 =?utf-8?B?RDU2UHpKSnVmaVBGS2RQT1B4Ykd1WFBnejBHbkQ2eGRjVGJOUEZOZXB2OFUv?=
 =?utf-8?B?MVVzVDgwdGQxMVVhMVdLWVMzUEJXK1JJWi9PWjZNVjNFRXh6Yzh1VWVwSUFK?=
 =?utf-8?B?QkhoTnIvRVRHQ0tRb3RoNlBwWklvU0FJQXVyT1BYL2hTTk1rYndHS1RjTGJE?=
 =?utf-8?B?WVhkNncvUDZ3SWRvemtudk44TWhFQzVGNzMwdzlyMHBiek8rSzhlVjdaeU9m?=
 =?utf-8?B?aUQ2RU5TR2JLayt5bUhySkRkTDIzb0FFYzYzWVorc2w5ZjlQWmJzemNPalpm?=
 =?utf-8?B?dnJRbHplNnhXdlBsYU5Hd0hWUy83TCszM0VBcWp4bm9FVHRTd0ZEY3ZsYzNm?=
 =?utf-8?B?RkFqbWVWYWV0ZDNCT2tQR0thdDFWNkdaWTN6Ym03VHVSbnRSMnovZ2RwZ1pa?=
 =?utf-8?B?eU5ITW9SYXU2Q2NsaEllSUtNVlNRYVExd3ZBTmc5VXZEdmg3OHpKU1dTTnRK?=
 =?utf-8?B?TW0yTHdBdURBeGdSL3BaS0VwRjVnZ3ZmM0JxdGI3K2NFRVZMZHkyU2dzNm5T?=
 =?utf-8?B?UC9seTF3c0V2ZU9vR1B2bjZUNUxTNGtiS0pCd0M5UUdlOThvazdjNVpOMEdZ?=
 =?utf-8?B?RXBSalEyeHF1ZHlrak00T1FTRk0xTVNteUI3bERScVpJMWdJcURuYzhSUWpo?=
 =?utf-8?B?Y1VaQ2RtUnZlMWNXMWpsWXR5dnhWNzFNU0tWOHBSRTBDRXdyeXgxWUx0TWI5?=
 =?utf-8?B?OGJSdVQzZWZZVk5NcG1yU08wdnlpaUh4L01JNmdCZVZFODBzaTFmRGRQUTB2?=
 =?utf-8?B?WTdJWDg0TSsxbGlWUzh1R0JwV2ZBWmkzZ01RSFhST1pjTEd1UG4ySkdsVnd0?=
 =?utf-8?Q?FTgnguFsZbsdbaQKaBupcDiDl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc06512-4217-4391-4e0c-08dcedfeda86
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8599.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 16:23:22.7916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMiCEIkEDxURSpOsDynWdSVKuRmjJKf1LFYLCZEMw1/8w/qlVPRqBr0S9oAqW3F7iAf2uYzYgi4qxNoef7+eWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7043

4/5
- change se_if_remove function signature, required after rebase to v6.12-rc1.
- move the info->macros to a structure "struct se_if_defines if_defs".
- Removed "info" from "struct se_if_defines if_defs".
- Moved "mem_pool" from "struct se_if_defines if_defs" to "priv".
- Fetching "info" using container-of.

5/5
- Fetching "info" using container-of.
- Fixed issue reported by sparse.

Reference:
- Link to v8: https://lore.kernel.org/r/20241015-imx-se-if-v8-0-915438e267d3@nxp.com

Changes in v8:

5/5
- Remove the check for SE_IF_CTX_OPENED.
- replaced dev_ctx->priv-dev, priv->dev, whereever possible.
- func "if_misc_deregister" moved before func "init_device_context".
- func "init_device_context" before func "se_ioctl_cmd_snd_rcv_rsp_handler".
- func "se_if_fops_write" and "se_if_fops_read", are moved after func "se_ioctl_get_mu_info".
- non static functions "se_dev_ctx_cpy_out_data, se_dev_ctx_shared_mem_cleanup & init_device_context" are moved static and local scope.
- Removed back & forth between the two structs "struct se_if_device_ctx *dev_ctx" and "struct se_shared_mem_mgmt_info *se_shared_mem_mgmt"
- removed the NULL check for bdesc.
- fops_open, is corrected for acquiring the fops_lock.
- Fops_close, mutex unlock is removed. Infact check for waiting_rsp_clbk_hdl.dev_ctx, is removed.
- sema_init(&dev_ctx->fops_lock, 1);, replaced with Mutex.
- structure member se_notify, is removed.

4/5
- removed initializing err to zero in func ele_fetch_soc_info(),
- replaced 'return 0', with 'goto exit', if the condition (!priv->mem_pool) is true.
- replaced "struct *dev" with "struct se_if_priv *priv", in base_message API(s) and others.
- Created a separate structure "struct se_if_defines" to maintain interface's fixed values like cmd_tag, rsp_tag, success_tag etc.
- removed the macros "WORD_SZ", "SOC_VER_MASK", "DEFAULT_IMX_SOC_VER", "RESERVED_DMA_POOL".
- Added handling for "ctrl+c", by postponing the interrupt, till the response to the "command in flight" is received.
- Removed the mutext lock "se_if_lock".
- furnction prototype for "se_save_imem_state" and "se_restore_imem_state", is changed to pass "imem" by reference.
- Added a new structure "struct se_fw_load_info", dedicated to contain FW loading relevant info. It is a member of struct info_list.
- split "imem_mgmt_file_in_rfs" into two "prim_fw_nm_in_rfs" and "seco_fw_nm_in_rfs", to be part of "struct se_fw_load_info".
- moved the function "se_load_firmware" prior to func "if_mbox_free_channel".
- function "se_load_firmware" is updated to use "request_firmware", instead of "request_firmware_no_wait".
- function "se_load_firmware" is updated to load "primary" fw image, if the imem_state is not BAD. Then load the "secondary FW" image.
- Added a new mutex_lock in the function "se_load_firmware", for ensuring FW loading done once, when there are multiple application are in play.
- instead of "wait_queue_head_t wq", used "sruct completion".
- add devm_add_action with action as se_if_probe_cleanup.

Reference:
- Link to v7: https://lore.kernel.org/r/20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com

Changes in v7:

5/5
- struct se_clbk_handle, is added with a member struct se_if_device_ctx *dev_ctx.
- func call to ele_miscdev_msg_rcv() & ele_miscdev_msg_send(), are removed.
- func se_ioctl_cmd_snd_rcv_rsp_handler(), is modified to remove the func call to ele_miscdev_msg_rcv() & ele_miscdev_msg_send()
- func se_ioctl_cmd_snd_rcv_rsp_handler is callig func ele_msg_send_rcv(), instead.
- Mutext "se_cmd_if_lock", handling is removed from this patch.
- func ele_miscdev_msg_send() is replaced with func ele_msg_send(), in fops_write.
- func ele_miscdev_msg_rcv() is replaced with func ele_msg_rcv(), in fops_read.
- fops_open is modified to create the new dev_ctx instance (using func init_device_context()), which is not registered as miscdev.
- Only one dev_ctx is registered as miscdev and its reference is stored in the struct se_if_priv, as priv_dev_ctx.
- Separate func cleanup_se_shared_mem() & func init_se_shared_mem(), for shared memory handling part of struct dev_ctx.
- Input param for func(s) ele_msg_rcv(), ele_msg_send() & ele_msg_send_rcv(), is replaced from struct se_if_priv to struct se_if_device_ctx.

4/5
- A new structure is defined name struct "se_clbk_handle", to contain members processed in mailbox call-back function.
- "struct se_if_priv" is modified to contain the two structures of "se_clbk_handle" - waiting_rsp_clbk_hdl & cmd_receiver_clbk_hdl.
- func ele_msg_rcv() is modified to take a new additional input reference param "struct se_clbk_handle *se_clbk_hdl".
- func ele_msg_send() is modified to take a new additional input tx_msg_sz.
- func ele_msg_send_rcv(), is modified to take 2 more inputs - tx_msg_sz & exp_rx_msg_sz.
- func se_val_rsp_hdr_n_status(), is modified to take input of rx_msg buffer, instead of header value, as input param.
- each caller of the func ele_msg_send_rcv(), is sending these two additional input params.
- func se_if_callback(), is modified to work on two structures of "se_clbk_handle" - waiting_rsp_clbk_hdl & cmd_receiver_clbk_hdl.
- Variable "max_dev_ctx", is removed from info & priv struture, as well its usage.
- New member variable "se_img_file_to_load", is added to structure "priv".
- Other member variables - rx_msg(ptr), rx_msg_sz, completion done & list of dev_ctxs, is removed from priv struture, along with their usage.
- func se_resume(), updated to wakeup the two "wq", part of "struct se_clbk_handle": priv->waiting_rsp_clbk_hdl & priv->cmd_receiver_clbk_hdl.

3/5
- Node name is changed from senclave-firmware@0 to "secure-enclave"

2/5
- Node name is changed to "secure-enclave".

Reference:
- Link to v6: https://lore.kernel.org/r/20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com

Changes in v6:

5/5
- replaced scope_gaurd with gaurd.

4/5
- replaced scope_gaurd with gaurd.
- remove reading the regs property from dtb.
- Added NULL check for priv data fetched from device, as a sanity check, for ele_base_msg apis)

3/5
- replace firmware with senclave-firmware.

2/5
- replace firmware with senclave-firmware.
- drop description for mbox
- Replaced "items:" with maxItems:1 for "memory-region"
- Replaced "items:" with maxItems:1 for "sram"
- remove regs property.
- remove "$nodename"

Reference:
- Link to v5: https://lore.kernel.org/r/20240712-imx-se-if-v5-0-66a79903a872@nxp.com

Changes in v5:

2/5
- updated the description of mboxes
- updated the description & items for mbox-names.
- updated the description of memory-region
- move "additional properties: false" after allOf block.
- removed other example except one.

4/5
- Corrected the indentation in Kconfig.
- info members:mbox_tx_name & mbox_rx_name, are replaced with macros.

5/5
- Replaced "for  secure enclaves", with "for secure enclaves"
- Replaced "user space" with "userspace".
- End the line "[include]<linux/firmware/imx/ele_mu_ioctl.h>" with a period.

Reference:
- Link to v4: https://lore.kernel.org/r/20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com

Changes in v4:

1/5
a. Removed - from EdgeLock Enclave.

b. Removed , after "Each of the above feature,"

c. replace "can exists" with "can exist".

d.
-messaging units(MU) per SE. Each co-existing 'se' can have one or multiple exclusive
-MU(s), dedicated to itself. None of the MU is shared between two SEs.
+messaging units(MU) per SE. Each co-existing SE can have one or multiple exclusive
+MUs, dedicated to itself. None of the MU is shared between two SEs.
 Communication of the MU is realized using the Linux mailbox driver.

e.
-All those SE interfaces 'se-if' that is/are dedicated to a particular SE, will be
-enumerated and provisioned under the very single 'SE' node.
+Although MU(s) is/are not shared between SE(s). But for SoC like i.MX95 which has
+multiple SE(s) like HSM, V2X-HSM, V2X-SHE; all the SE(s) and their interfaces 'se-if'
+that is/are dedicated to a particular SE will be enumerated and provisioned using the
+single compatible node("fsl,imx95-se").

f. Removed ",". Replaced for "Each 'se-if'," with "Each se-if'.

g. removed ","
-  This layer is responsible for ensuring the communication protocol, that is defined
+  This layer is responsible for ensuring the communication protocol that is defined

h. removed "-"
-  - FW can handle one command-message at a time.
+  - FW can handle one command message at a time.

i.
-  Using these multiple device contexts, that are getting multiplexed over a single MU,
-  user-space application(s) can call fops like write/read to send the command-message,
-  and read back the command-response-message to/from Firmware.
-  fops like read & write uses the above defined service layer API(s) to communicate with
+  Using these multiple device contexts that are getting multiplexed over a single MU,
+  userspace application(s) can call fops like write/read to send the command message,
+  and read back the command response message to/from Firmware.
+  fops like read & write use the above defined service layer API(s) to communicate with
   Firmware.

j. Uppercase for word "Linux".

2/5
a. Rephrased the description to remove list of phandles.

b. Moved required before allOf:
+required:
+  - compatible
+  - reg
+  - mboxes
+  - mbox-names
+
+additionalProperties: false
+
 allOf:

c. replaced not: required: with properties: <property-name>: false.
   # memory-region
-      not:
-        required:
-          - memory-region
+      properties:
+        memory-region: false

   # sram
-    else:
-      not:
-        required:
-          - sram

d. Reduced examples. keeping example of i.MX95.
e. node-name is changed to "firmware@<hex>"

3/5
- node name changed to "firmware@<hex>".

4/5
- used sizeof(*s_info)
- return early, rather than doing goto exit, in ele_get_info().
- Use upper_32_bits() and lower_32_bits()
- use rx_msg here instead of priv->rx_msg
- Moved the status check to validate_rsp_hdr. Rename the function to "se_val_rsp_hdr_n_status"
- typecasting removed header = (struct se_msg_hdr *) msg;
- Converted the API name with prefix imx_ele_* or imx_se_*, to ele_* and se_*, respectively.
- Removed the functions definition & declaration for: free_phybuf_mem_pool() & get_phybuf_mem_pool()
- removed the mbox_free_channel() calls from clean-up.
- Flag "priv->flags" is removed.
- Converted the int se_if_probe_cleanup() to void se_if_probe_cleanup().
- Replaced NULL initialization of structure members: priv->cmd_receiver_dev & priv->waiting_rsp_dev , with comments.
- Removed the function's declaration get_phy_buf_mem_pool1

5/5
Changes to Documentation/ABI/testing/se-cdev.
a. Removed "-" from "secure-enclave" and "file-descriptor".

b. Removed "-" from "shared-library"

c. Replaced "get" with "getting".

d. Added description for the new IOCTL "send command and receive command response"

e. Replaced "wakeup_intruptible" with "wait_event_interruptible"

f. Removed ";"

g. Removd "," from "mailbox_lock,"

h. Replaced "free" with "frees"

i. In mailbox callback function, checking the buffer size before
copying.

Reference:
- Link to v3: https://lore.kernel.org/r/20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com

Changes in v3:
5/5:
- Initialize tx_msg with NULL.
- memdup_user() returns an error pointer, not NULL. correct it by adding check for err_ptr.
- new IOCTL is added to send & recieve the message.
- replaced the while loop till list is empty, with list_for_each_entry.
- replaced __list_del_entry, with list_del.
- Removed the dev_err message from copy to user.
- Removed the casting of void *.
- corrected the typcasting in copy to user.
- removed un-necessary goto statement.
- Removed dead code for clean-up of memory.
- Removed un-mapping of secured memory
- Passing se_if_priv structure to init_device_context.
- Updated the below check to replace io.length with round_up(io.length).
	if (shared_mem->size < shared_mem->pos|| io.length >= shared_mem->size - shared_mem->pos)
- Created a function to cleanup the list of shared memory buffers.
- Used list_for_each_entry_safe(). created a separate functions: se_dev_ctx_cpy_out_data() & se_dev_ctx_shared_mem_cleanup()

4/5
- Changed the compatible string to replace "-ele", to "-se".
- Declaration of imx_se_node_info, is done as const in the whole file
- Remove the unused macros from ele_base_msg.h
- Remove the function declaration get_phy_buf_mem_pool1, from the header file.
- Replace the use of dmam_alloc_coherent to dma_alloc_coherent
- Check for function pointer, before calling the fucntion pointer in imx_fetch_se_soc_info
- Removed the unused flag for SE_MU_IO_FLAGS_USE_SEC_MEM.
-  Removed the unused macros WORD_SZ
- instead of struct device *dev, struct se_if_priv *priv, is used as argument to the funtions:se_save_imem_state, se_restore_imem_state, imx_fetch_se_soc_info
- Removed ret from validate_rsp_hdr.
- changed the prefix of the funtion: plat_add_msg_crc and plat_fill_cmd_msg_hdr.
- indentation correction for info structures.
- remove the check for priv not null from se_if_probe_cleanup
- Removed the casting of void *.
- se_load_firmware function is corrected for not freeing the buffer when allocation fails.
- Checking if get_imx_se_node_info() can return NULL, in se_if_probe()
- imem.size has type u32. return value from se_save_imem_state() will be assigned to imem.size in case of success only.
- removed the flag un-setting in case of failure. priv->flags &= (~RESERVED_DMA_POOL);
- removed the function call for devm_of_platform_populate(dev);
- Checking for not-NULL,  before calling the funtion pointer se_fetch_soc_info.
- Removed the checking for reserved memory flag, before freeing up the reserved memory, in se_probe_if_cleanup.

3/5
- Changed the compatible string to replace "-ele", to "-se".

2/5
- to fix the warning error, replaced the "-ele" & "-v2x" in compatible string, to "-se".
- Added an example for ele@0 for compatible string "fsl,imx95-se"

Reference
- Link to v2: https://lore.kernel.org/r/20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com

Changes in v2:

4/4
- Split this patch into two: 1. base driver & 2. Miscdev
- Initialize the return variable "err" as 0, before calling 'return err', in the file ele_common.c
- Fix the usage of un-iniitialized pointer variable, by initializing them with NULL, in ele_base_msg.c.
- Fix initializing the ret variable, to return the correct error code in case of issue.
- replaced dmam_alloc_coherent with dma_alloc_coherent.
- Replace the use of ELE_GET_INFO_READ_SZ, with sizeof(soc_info).
- Replaced -1 with -EPERM
- Removed the safety check on func-input param, in ele_get_info().
- fix the assigning data[1] with lower 32 address, rather than zero, for ele_fw_authenticate API.
- Correctly initializing the function's return error code, for file  ele_base_msg.c.
- replaced 'return' with 'goto'.
- Use length in bytes.
- Corrected the structure se_msg_hdr.
- Moved setting of rx_msg  to priv, into the function imx_ele_msg_send_rcv
- Will add lockdep_assert_held, to receive path, in v2.
- corrected the spacing at "ret  = validate_rsp_hdr"
- FIELD_GET() used for RES_STATUS
- Re-write the structure soc_info, matching the information provided in response to this api.
- The "|" goes to the end of the previous line.
- Moved the locking and unlocking of the command lock to the caller of the function.
- removed the safety check for device private data.
- Structure memory reference, used to read message header.
- In the interrupt call back function, remove assigning waiting_rsp_dev to NULL, in case of response message rcv from FW.
- do while removed.
- replaced BIT(1) for RESERVED_DMA_POOL, to BIT(0)
- The backslash is removed while assigning the file name with absolute path to structure variable.fw_name_in_rfs =.
- Update the 'if' condition by removing "idx < 0".
- mbox_request_channel_byname() uses a "char" for the name not a u8. Corrected.
- devm managed resources, are not cleaned now, in function se_probe_if_cleanup
- Used dev_err_probe().
- Used %pe to print error string.
- remove "__maybe_unused" for "struct platform_device *enum_plat_dev __maybe_unused;"
- used FIELD_GET(), for  RES_STATUS. Removed the use of MSG_TAG, MSG_COMMAND, MSG_SIZE, MSG_VER.
- Depricated the used of member of struct se_if_priv, bool no_dev_ctx_used;
- Moved the text explaing the synchronization logic via mutexes, from patch 1/4 to se_ctrl.h.
- removed the type casting of info_list = (struct imx_se_node_info_list *) device_get_match_data(dev->parent);
- Used static variable priv->soc_rev in the se_ctrl.c, replaced the following condition: if (info_list->soc_rev) to if (priv->soc_rev) for checking if this flow is already executed or not.
- imx_fetch_soc_info will return failure if the get_info function fails.
- Removed devm_free from imx_fetch_soc_info too.

3/3
- Made changes to move all the properties to parent node, without any child node.

2/4
- Use Hex pattern string.
- Move the properties to parent node, with no child node.
- Add i.MX95-ele to compatible nodes to fix the warning "/example-2/v2x: failed to match any schema with compatible: ['fsl,imx95-v2x']"

1/1
- Corrected the spelling from creats to creates.
- drop the braces around the plural 's' for interfaces
- written se in upper case SE.
- Replace "multiple message(s)" with messages.
- Removed too much details about locks.

Testing
- make CHECK_DTBS=y freescale/imx8ulp-evk.dtb;
- make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx-se.yaml
- make C=1 CHECK=scripts/coccicheck drivers/firmware/imx/*.* W=1 > r.txt
- ./scripts/checkpatch.pl --git <>..HEAD
- Tested the Image and .dtb, on the i.MX8ULP.

Reference
- Link to v1: https://lore.kernel.org/r/20240510-imx-se-if-v1-0-27c5a674916d@nxp.com

---
Pankaj Gupta (5):
      Documentation/firmware: add imx/se to other_interfaces
      dt-bindings: arm: fsl: add imx-se-fw binding doc
      arm64: dts: imx8ulp-evk: add nxp secure enclave firmware
      firmware: imx: add driver for NXP EdgeLock Enclave
      firmware: imx: adds miscdev

 Documentation/ABI/testing/se-cdev                  |   43 +
 .../devicetree/bindings/firmware/fsl,imx-se.yaml   |   91 ++
 .../driver-api/firmware/other_interfaces.rst       |  121 ++
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts      |   17 +-
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi         |   13 +-
 drivers/firmware/imx/Kconfig                       |   13 +
 drivers/firmware/imx/Makefile                      |    2 +
 drivers/firmware/imx/ele_base_msg.c                |  279 ++++
 drivers/firmware/imx/ele_base_msg.h                |   94 ++
 drivers/firmware/imx/ele_common.c                  |  333 +++++
 drivers/firmware/imx/ele_common.h                  |   51 +
 drivers/firmware/imx/se_ctrl.c                     | 1331 ++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h                     |  134 ++
 include/linux/firmware/imx/se_api.h                |   14 +
 include/uapi/linux/se_ioctl.h                      |   94 ++
 15 files changed, 2627 insertions(+), 3 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240507-imx-se-if-a40055093dc6

Best regards,
-- 
Pankaj Gupta <pankaj.gupta@nxp.com>



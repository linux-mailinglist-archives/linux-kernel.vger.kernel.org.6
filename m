Return-Path: <linux-kernel+bounces-285051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971389508B2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F007284DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E9E1A01BA;
	Tue, 13 Aug 2024 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pxyb3Wz/"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600819FA9F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562136; cv=fail; b=NY7idaTNzfce/B6JeYSl1M3ZWOztZRl336zMcbi0mkW1RywrDntoMUwD6sGH9aLazLMIB1hCoPUQvllQL0bLKTzG/ZZXN6vrbNku/sOlhCUGKZ5U0u+bSC/kzPfSBHvrs469BZSc4A2q/c5qP+tMZcr1e6n9HBBiwPZG28GYviA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562136; c=relaxed/simple;
	bh=nvcmTWDJj+SrtpBzaB8l8keUZ2F8Z2oCpFCzJlzH9us=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IfPwgVYH9gfXWoo1Gq1qvOHvJYw6jeocpXfQ+RK22oUnowpHK+rlxJ6IgdkJiVo8usH5QVoURMbKh6876yNvgFc8aFrZQlVfcie1ZUE05VgO4lAgTVEUPNc7M5dihEzA1j55sjksTAPr54/wmMAsRoBBOLa1E4vmVJ/OUNBSDII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pxyb3Wz/; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUySjTbPCaDi9BVxnyT5GCLJ/SLB35nTPLdSdaNe/Ioj5YsrxTeUQjk3jAYwsyiEA747m815kPzSe6EPGBAeiJQDixLF5oQmqkQYlE1fK8vO+Vn3DM+Kp2VJPfKP87MJhsg7+JFOJ1mXcPCBULq3rb2QvbA13Kzm3Hic2RV7S48o6HbzngVb9g06LxcAhHDmpo5QTy3EnU8C2pkXBzPjN9X3O9tKL9V1ZTs7XrYFHBO8oYXUoQDZImQaDYb+qDzh/LF+4cFdT4TlkEuqIOZOJm32pa8OBCWJneQJ+O/yMjw9+dsTJrtwPjt89WEySQPr2C1RvWjFOJc34J8VP2fYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jk3Sg8K892J5LLK9qnygB0m2WRCfBM/GY0tQ0z2NeDw=;
 b=aoroXpYg78M5cnYZaU+aiYb4osHvKA0JQ29nrO90Jj14GWnSmObArQHNg74KG4heMg9y37U7SbcY+dgfKS71JwpfCA/soO8RbH47rb+xzP+M6rPYy5Bv2Nf2zDzfb4bLJ1+CNLoXWsLC5rOQkERC+hthHZ30Z7tIQ8F4lDFA4D5xtnq6mONmOmkwxmBmBtiz8D1C1IZ+3FHp6LmM0yQYycvm/LgL8WPWg4JDGvfDHX5yv2c9OuwG8a9zZo1e/zuCVy3z9repY1Cc1jPZYP8rYrljokpgFaKW4BWRZK/pqyUTgWqX2BW9Pm6k8lJ5u3mY4IrU49/aj8udRUGZWxF23Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jk3Sg8K892J5LLK9qnygB0m2WRCfBM/GY0tQ0z2NeDw=;
 b=Pxyb3Wz/EOpHMAZPPGGxlpejPg65BcLMIa90/r6FjrWuOgmKHXpn/q8F3mBDUATvwPDMeJXDDNMvUy7HUdpm2YqcLa6VC4KznmzXAZhrFaswT4dOp8Z0HHZgFKUCNqAUb6WIPiLTUz+lqmRN9UNkaruhymsJ6aVywZ0nsU0G1IXbvrs6o1PtwUpoAQa+DVVmw2EQJ38bJL7ifeXFmpzXnvHrUkwelYp2G6offIgLWeBeJlHXGaD6Me/04JhFJSAxvGOcnzh+j2Vgr/OEC980noVQZvYqJd86kxHClCCNS6N0jT636VKHiYtC/hgWMcGazkEN4t4P6+0Eoh5M1sEnkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 15:15:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 15:15:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 11:15:01 -0400
Subject: [PATCH v2 03/11] i3c: master: Extend address status bit to 4 and
 add I3C_ADDR_SLOT_EXT_INIT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-i3c_fix-v2-3-68fe4a050188@nxp.com>
References: <20240813-i3c_fix-v2-0-68fe4a050188@nxp.com>
In-Reply-To: <20240813-i3c_fix-v2-0-68fe4a050188@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723562115; l=5289;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nvcmTWDJj+SrtpBzaB8l8keUZ2F8Z2oCpFCzJlzH9us=;
 b=x5XiFTV1Fax58n9YQ6RD5YTd7QDCwA5yVOOZt5k2+oYaM3D0toNZ9ZPMesddvRrd/5HrGwOyG
 +LcwritCa9gBBWN+GYobInDb8536jgwnCVR2/HB/6l/+Aj0XcC19D3G
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0125.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e9eede-6f01-4f81-3dfa-08dcbbaac455
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cm1xaEFKNTVLZE9JT1Fid2NWYmsxNlFCNHNGUjk5a3NwV0NmTkRWb21iTGh0?=
 =?utf-8?B?RUhHblZPbWc5dzY0bFFlYlFSRzczRG9Kb0N5WWZKY042SUlFa1NCSGM0YTBJ?=
 =?utf-8?B?T3F3b0U2M3JwdVVTbGVhYkppb1pqZFdaZEk1VmVHZVNIUDU5RVdWWWFzQUJM?=
 =?utf-8?B?SGpPaEFSdXpGL2JWODNyVFZlV0t4TWY3UzJ3SmhNR05UdFQ0S1FRTHNiZ3hJ?=
 =?utf-8?B?M1RBdFhUWUhpc1lGNTB3L0IxZkd0a3lkc3F4WEQ4MzViRGxUaXIwMVpHMXlK?=
 =?utf-8?B?QUVKdGtzNmFya05IZUN1MkZWMHRtaVRlM1RRVmI1NFBOMDBZM2wvUWp3T2Nx?=
 =?utf-8?B?MDN1ZSszb1NSenkxbVhhbUlhYkN4VzJRL245VUNTeWF1STEwWk9qRENtUm12?=
 =?utf-8?B?YjNYV2k5WXd6T2toQzZad2p3TjNZVjNaSk9WMk1XMzVLc2RnRmg0MjhzRmhv?=
 =?utf-8?B?ZnlaSE5ITXlzc3NRUE11ZVlTZmJFTVR3T2lURlpGS1V1M0pDaDlPekZyUGw4?=
 =?utf-8?B?NDMwUUZPSmpaWmpJSk1kM2VzbDhTVTQzaWc1VjdVTkNnZC93SlJOTEVFTlEv?=
 =?utf-8?B?eXd0TGswYjh5SUxkeVByMHJKY1UwR0R0NTE4V2Q5U3RRWlNRNjFVcVVIVmJM?=
 =?utf-8?B?ZEFxMDA4djVOYUtacFZyWnlVcjVTVlRPQVNvbTUyL0ZySm0zMURCMlliTFkr?=
 =?utf-8?B?T3RGdnpYOFNwZjBWU2VjS1IxckxqVE1yZGpmQWRCVktqN2p3RkRlbHRsaDdB?=
 =?utf-8?B?dWU0YW90V1MzenhkeGV6WXpqZ2lEOUZRMitIUDRlNnVDRnF4Z1pObWRDM0JX?=
 =?utf-8?B?a2dsTlBDMVp0NE90NTZIZVFCZVZnZDhVdERzVzk4TU5aaS9OUFQxek5zWmpC?=
 =?utf-8?B?eXoyY0VYd1FpMVU0SUtoRVA0QTJUWm5CVTdkYkdFaTBIcElIdldCNVl4WHVG?=
 =?utf-8?B?UlBieUlrb0RCWTU3MHpPVUZOMXQvWk5jcUI5YUhLa1dlRDhRVVFpaE00UzFK?=
 =?utf-8?B?Q3NOUWxhS0gxRnF2cnJIZ2xoeW5KVlJ1QXVtMEZuZm1zSlhHMmtyTm1IODJH?=
 =?utf-8?B?b2RQOGhZVkc3b1JnbXBOYnFWdm5GNmkya3VGMVZ0aXozd3duZVNhdGNqYVJp?=
 =?utf-8?B?VXdFazhoMTQzR2s4VE8vS1BRaVpLZnVVSlRya3Z4K3VhQk1aRHF5Z1RGOUtr?=
 =?utf-8?B?UkJqdXhrOG9xZkd1eSt0V1ZhR0EwaEZ5MnNSTm9wWUJwK2FuWHVUSDVZNFI5?=
 =?utf-8?B?VFhzMjM5UnZydGVlZHc5SFNLK25uRVBRRU5YTGI1ejdhSW1jUWZDU29OdkhO?=
 =?utf-8?B?d1FLSzRlR0w4c1g0WERBUmgwMTlkVk1HY1hsNUx1N1BmS3hvTkQzT3JQMVFh?=
 =?utf-8?B?eXV0RkZZMjB0Wkk3UDRMekdVSFBzNytZMUpxc0pGNzdNcGd4NkordjFSVytV?=
 =?utf-8?B?M25GMlZ1Q0QzRXhJVUllV3JpQU1paXR0b25xdlV5MCtmdFNSemgvRHVsWTJo?=
 =?utf-8?B?RFB0aUdQQUdqL0RxMDhIRnR4eEx4bWVYNVRyOGY4aEttQ3ViV253VEIvSlJG?=
 =?utf-8?B?M1g2QURzaTBKRjc4ekI3d25hKzBQdWREV3F5c1ZnQU5BczFveGFzcDdRZ2hk?=
 =?utf-8?B?bUJPSGE1VkR0NnlycWtpa2pUdVVvdUg1OHlQMkFVY3VKWk9zU0FyK1BDK0NZ?=
 =?utf-8?B?M0ZnYjNLYlk4bVQ0N1BxZiszekF2MVRrekEyNUFjKzdDOGJFNWs3dW1ydERM?=
 =?utf-8?B?MHdPcFZLR2ZIRFo2RVF3c040TGpMR042eG1ZLzdHQ0VZZ3pUYjcxZkEyMlEy?=
 =?utf-8?B?Zk9ZU2ZTT1NiUmVrRFNERTd0RTEzeXFPMXQ3VExzYXBMdEMzYkQrWWFQZDhY?=
 =?utf-8?B?eVFWTXpvV29XeHo1MTBVWGlzTnlIcjJvNTgwckpsclFyQXc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Y1hmeXJmVUFHY3AyN1kzckJkNVpPbWVUaHRORWpUaGpualphSDFVc0krOTJt?=
 =?utf-8?B?dFcveEE5V29DRmxtbUh4Y2M4MnpkSGlyNW9UN3dRNjZ2MTJQRFdzaGF1VEhQ?=
 =?utf-8?B?VmFTenNxcktYb2QzbnJBcFozanZUdWFWQnMzWmdMekFJekJYT010SkNFUFJS?=
 =?utf-8?B?YzFJa21rVjFOZlNlSUhWWWJaQ2dqOUR6WTh0bjZZVXFpWUpjaFZpL1RvNVRW?=
 =?utf-8?B?U3RTRXdpakZnWjBVZEd1Rlp4Yk1nOGNaOXdnR1VGLzdQNk13Qmo0eG1FQTl3?=
 =?utf-8?B?UEYwVGJya0x1TFJuUUd2VU0xY1ZSYzcwKzNKcEhJK1BYbWVmRUtIV29vbEJ6?=
 =?utf-8?B?OWtPdFo2aHVhdHdGVjJFUjZnRlJUM2F3dXZ4V0ZiQlg1Q1lXRllvU283Q1dm?=
 =?utf-8?B?UlJMY25uR0ZEcFJzNmJtbE1HT1lGZEl5d2FYQ2ZxM0xMYzg1Qm14bmxSWlMr?=
 =?utf-8?B?KzBXdlJSbnBReVJlYmpWVlc1SjBqN1dWYzMrbnUvT29yWThBeUVkSDVFTjdW?=
 =?utf-8?B?WDQ1Z2ZKbjdmZDQ5bWY4MzRETGE2QnpXTlJuRGFadXJoTURnU3JTQUFSMDcw?=
 =?utf-8?B?ZTNYZk02L2p4SFB4N2J1WEVwZmJ5VzBBeDdGeFpQV0MwWi8wa3Jsbk4yMWp3?=
 =?utf-8?B?aktIWnVIeTQ3WTlBTnJGOTZqamd4VGVzM1p1TUxyRWZhT0p0N2Qwa1hTQURZ?=
 =?utf-8?B?ZWFwazJkbXBHNjkxTUcyaS9jR2NRNjM1a2IweU1mc2toMTRWMlVaeDRNdElI?=
 =?utf-8?B?M2p3and4YlZmclVqVHpHMXg0OW1ndjQ0SGllL21PU3VjSnAyN1hETEc4elBj?=
 =?utf-8?B?WVBBOG83Q1d3eU1YWnorSXJiSXRqYUZUeFkrNTYwUzI3M29GdmU1NERSMEUr?=
 =?utf-8?B?cEZzODh6V3psb3hjRnUreGp1NExUZ2VzaHlhcmttK1NNWjZObGtjNHFkaXdF?=
 =?utf-8?B?VkVyamxqUVB1ZVdTV2RaRXRQb2VZNnB2WlpIUG1vZUdrTjMxWlFZd3EwRW9U?=
 =?utf-8?B?VnVMMzJZY21DWWVLOE9NSjM4VmJXemlwQ1NTSjFmMktiNlB4dGpxUGxua1J4?=
 =?utf-8?B?cTlJWDhJNXY5VGhRWmpDY3VlelFwMmhzcDZmUlVydnZZRFE2TlA4TVk0ajd4?=
 =?utf-8?B?VWRWZ0JQb09uUDBCQnpGY3dseGxpVWRGRGdLVmNlREZkUHJ6NnJ0MzN4ZndV?=
 =?utf-8?B?NmpMNHpUY29Id2lTcG04UmdIYnN3YkticnBUaFdVWXZHZUV3Q3hrLytIVGxH?=
 =?utf-8?B?N0YxemIxOEErcGhmdlNPY3Y0OHN5TkFyQU1OUzlHRnBlWHFhejZDL29ab2lh?=
 =?utf-8?B?SlZOS004d0RqamtFZm4zOWxzM0RRZS9DVkNJY2YyWFM1SlJuc3ZtMTlyZ3JD?=
 =?utf-8?B?VzBnUk81U1orb0xmV202SUlBWmYzaHYzQTJqZ0IxbDVmcDd5alE3Z1Ezc2lE?=
 =?utf-8?B?U1lCU1FtdmxGSUFWTDhnUm5LSjMzS09aeUFYd2I1TU5MQ1dnZllUcnlEc0hW?=
 =?utf-8?B?NEQrVmIxQU45aHpoUER2eXM2MGN0ckRvVy82N0R6aXpGdkRqNjlxRUZSRWlW?=
 =?utf-8?B?VEl3MEQ5Z0tZb0JUc1lvZU4veFZBWDBrSkpNRU5hTUxzZHFHdHdSWGRwcld6?=
 =?utf-8?B?ak9Zb1NDeEw0bFA0Syt0Zm9EY2lHeFBzZFlIYlhNMmxGN2dYZGgxUGpSQ0g5?=
 =?utf-8?B?T0Z2Rm4vcGNzNzJVQlV6YzBvdkVSbkF2Mk5STnp0dFV1OFNkMllwU2hGQkVL?=
 =?utf-8?B?TzVlQi9zQkF5VzRJRDZuQmswQS8zWUI1WUZZOVZ5M1R1RFdnVWZ6QWhPSHA1?=
 =?utf-8?B?RkNabWY0bmJ4Z0ZWOTVpbUdFdmM5NU9VY2taMU4xcHp5TVJ4YTJXaDF5MlZF?=
 =?utf-8?B?NGJIeXEwRFRvZE1JdmhhaHZvWkpoVzlyUzc0elRtZHpRV2VLOXlVSkNteDFV?=
 =?utf-8?B?NUNlOTRFd0tmSUwvSTlmWHpnZmNEaGVrb253R2RLcUNUS3JLVTJrYmdhV0Nr?=
 =?utf-8?B?NDlKWFJEKzF4QnBzVk1yZ2N3SHM0TnBHa3BGVU91TVNLMlBmWWF3cnNPQzcy?=
 =?utf-8?B?Ni9JOGh0VmdMUnhEb3owMWhGMkFJM0VBaS9INkd6a2dvNHNtZDRxNldaRm4x?=
 =?utf-8?Q?iZtg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e9eede-6f01-4f81-3dfa-08dcbbaac455
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 15:15:29.3427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kS15Mq+/IwEW8EDy+F/J4h5osrWefahFHsJKiQo6g6OVpWcngDQEeEoBiKmiluCdVrI9df3x0/0BpINaYSMGGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8404

Extend the address status bit to 4 and introduce the I3C_ADDR_SLOT_EXT_INIT
macro to indicate that a device prefers a specific address. This is
generally set by the 'assigned-address' in the device tree source (dts)
file.

When an i3c device is removed from the bus, the old address status is set
to FREE, allowing other devices to use the address during hotjoin. The
I3C_ADDR_SLOT_EXT_INIT status indicates that an address is preferred by
some devices. The function i3c_bus_get_free_addr() will first attempt to
use unassigned addresses before searching for assigned addresses of devices
that have been removed from the bus, trying to best match the
'assigned-address'.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master.c       | 43 ++++++++++++++++++++++++++++++++++---------
 include/linux/i3c/master.h |  6 +++++-
 2 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 85c737554c940..4281f673e08d8 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -345,7 +345,7 @@ const struct bus_type i3c_bus_type = {
 EXPORT_SYMBOL_GPL(i3c_bus_type);
 
 static enum i3c_addr_slot_status
-i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
+i3c_bus_get_addr_slot_status_ext(struct i3c_bus *bus, u16 addr)
 {
 	unsigned long status;
 	int bitpos = addr * I3C_ADDR_SLOT_BITS;
@@ -356,11 +356,17 @@ i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 	status = bus->addrslots[bitpos / BITS_PER_LONG];
 	status >>= bitpos % BITS_PER_LONG;
 
-	return status & I3C_ADDR_SLOT_STATUS_MASK;
+	return status & I3C_ADDR_SLOT_EXT_STATUS_MASK;
 }
 
-static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
-					 enum i3c_addr_slot_status status)
+static enum i3c_addr_slot_status
+i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
+{
+	return i3c_bus_get_addr_slot_status_ext(bus, addr) & I3C_ADDR_SLOT_STATUS_MASK;
+}
+
+static void i3c_bus_set_addr_slot_status_mask(struct i3c_bus *bus, u16 addr,
+					      enum i3c_addr_slot_status status, int mask)
 {
 	int bitpos = addr * I3C_ADDR_SLOT_BITS;
 	unsigned long *ptr;
@@ -369,11 +375,22 @@ static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
 		return;
 
 	ptr = bus->addrslots + (bitpos / BITS_PER_LONG);
-	*ptr &= ~((unsigned long)I3C_ADDR_SLOT_STATUS_MASK <<
-						(bitpos % BITS_PER_LONG));
+	*ptr &= ~((unsigned long)mask << (bitpos % BITS_PER_LONG));
 	*ptr |= (unsigned long)status << (bitpos % BITS_PER_LONG);
 }
 
+static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
+					 enum i3c_addr_slot_status status)
+{
+	i3c_bus_set_addr_slot_status_mask(bus, addr, status, I3C_ADDR_SLOT_STATUS_MASK);
+}
+
+static void i3c_bus_set_addr_slot_status_ext(struct i3c_bus *bus, u16 addr,
+					     enum i3c_addr_slot_status status)
+{
+	i3c_bus_set_addr_slot_status_mask(bus, addr, status, I3C_ADDR_SLOT_EXT_STATUS_MASK);
+}
+
 static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
 {
 	enum i3c_addr_slot_status status;
@@ -388,6 +405,14 @@ static int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr)
 	enum i3c_addr_slot_status status;
 	u8 addr;
 
+	/* try find an address, which have not pre-allocated by assigned-address */
+	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
+		status = i3c_bus_get_addr_slot_status_ext(bus, addr);
+		if (status == I3C_ADDR_SLOT_FREE)
+			return addr;
+	}
+
+	/* use pre-allocoated by assigned-address because such device was removed at bus*/
 	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
 		status = i3c_bus_get_addr_slot_status(bus, addr);
 		if (status == I3C_ADDR_SLOT_FREE)
@@ -1906,9 +1931,9 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 			goto err_rstdaa;
 		}
 
-		i3c_bus_set_addr_slot_status(&master->bus,
-					     i3cboardinfo->init_dyn_addr,
-					     I3C_ADDR_SLOT_I3C_DEV);
+		i3c_bus_set_addr_slot_status_ext(&master->bus,
+						 i3cboardinfo->init_dyn_addr,
+						 I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_INIT);
 
 		/*
 		 * Only try to create/attach devices that have a static
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 4601b6957f799..c923b76bbc321 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -284,6 +284,8 @@ enum i3c_bus_mode {
  * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
  * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
  * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
+ * @I3C_ADDR_SLOT_EXT_INIT: the bit mask display of addresses is preferred by some devices,
+ *			    such as the "assigned-address" in device tree source (dts).
  *
  * On an I3C bus, addresses are assigned dynamically, and we need to know which
  * addresses are free to use and which ones are already assigned.
@@ -297,9 +299,11 @@ enum i3c_addr_slot_status {
 	I3C_ADDR_SLOT_I2C_DEV,
 	I3C_ADDR_SLOT_I3C_DEV,
 	I3C_ADDR_SLOT_STATUS_MASK = 3,
+	I3C_ADDR_SLOT_EXT_STATUS_MASK = 7,
+	I3C_ADDR_SLOT_EXT_INIT = BIT(2),
 };
 
-#define I3C_ADDR_SLOT_BITS 2
+#define I3C_ADDR_SLOT_BITS 4
 
 /**
  * struct i3c_bus - I3C bus object

-- 
2.34.1



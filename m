Return-Path: <linux-kernel+bounces-175491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 161F98C2066
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393501C21B96
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE771635C1;
	Fri, 10 May 2024 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UzCRxHrw"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2064.outbound.protection.outlook.com [40.107.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A27916193B;
	Fri, 10 May 2024 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332274; cv=fail; b=dmhG/RQN/CglehJOWGfx6NZKjrVe6DejzmzimKK8Wy0Oo5CuQwqR5hdDau1wrlULOKaKzgS1OF/uu6l6PIbxzhp6UvrZWheewT4mdl/QDxsfn4dNcQu7gyUPPHne6F3W9Ed+uFcxjGBATeJ4GZCrfvq+gA1CiTnzC/8bfKcgnEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332274; c=relaxed/simple;
	bh=rcCtVWuFJLRqXg+s+ZbKpx/twvYOuewRyu/zZTOc/H8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VtKMUPLV6HyV0FxyQkNrBH5kV/V7uJwdyfVcaEYzG40WpfCEWfzrB/kk7MzSvD1jmGR/7l/Y93N6Pc3nqkFdhwo7WPFK0037TIWP474NS2OcLEcVaellu6lxk0k+gDhpi26SrazbyaJoNl/fJyIp6PZrcylsEKPOty89Qm5NFN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UzCRxHrw; arc=fail smtp.client-ip=40.107.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDFUZBE9fS3znG/FFGcuAMhOS4wiPdS5XZ8Swo8na00YecuvbpduCcyLwfH28J6+52Ul6esjXrEvKuq6sF2T+5ql6XYf7Y6xhD9E69sgBuFS2dBC0/lJkD3lgEYq4rebfmLgEKCmOwCMXGZDs0j8iT5QUcdnOcq8oR3lZTcrCDfM5NOobAtthXcgL42jy75BpK9zB2SFREVN2Ij0aIi1LBYRY5PmcgBkwCLCf+m5FI1a2Co2/pBS8vVN7YZtLnN+9z0qwifaOk07iKLjybILug/Y5mSJFNkGVbqnaUoxhmamVTwGA5ECrXP4MjQ26NN8pfAJ0awFMPNAw4GZscvDVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUBHObqX7+uXERJEHkjNWet6mkZy6+My8u8xzR/PX/E=;
 b=MQ8Y224dxHdYmiiCLd3zsT8/oihKnYpuMj5OGIhYQJcPxgCrZTnkAI2RlUwkfx9G8kSTOCehRXcHhsmCfdgRtvhNWoUAndRrFokGIvGBXoAav4GPDBfJlKzLq6wgwAB5SXHao4AIJG0u4L3uPrr0cRh5wZZ9Tzgig8O/4km+5hJeaBN1CYufCKP5SAOEjWmxJ1LJeMlG7mmb4pC9AwiwZdAUz+l8o1MxOutIzSCdEtF5ZkrunQhzGOo79bXICO8b98dtEgzWYoY9OsN/eqS6xWADlRmZ+EpjjyYbh/By1R8Ly+sA3VoZPHeiZgD3C8Rgn8Fn6RhZSWD32PTfDzMXIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUBHObqX7+uXERJEHkjNWet6mkZy6+My8u8xzR/PX/E=;
 b=UzCRxHrwzW7BJ9ZSJYDguNwuo1dO+zYZ4qXWzi1ocg0RcihH0UPNeCnErNFgC0JBCqkYVjTBSzsBNpuhBIuUFSI96LZayKfpKCftEvvom/G6aQvxkOccwQ87Jh7MMU0BUr1qiuF0Klo2OCqE/tULDe5PcxLc4Ec88SF8p8JBzNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8065.eurprd04.prod.outlook.com (2603:10a6:20b:3ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 09:11:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 09:11:09 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 10 May 2024 17:18:56 +0800
Subject: [PATCH v2 01/17] clk: imx: composite-8m: Enable gate clk with
 mcore_booted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-imx-clk-v2-1-c998f315d29c@nxp.com>
References: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
In-Reply-To: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715332748; l=3100;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=iITI+dk+sPkjkDWQwUetdnNFKtogLu9x+44sHjDOVUI=;
 b=0xANIgI2P2N15uUR/SSVlX0gFKuyAI8GiCGRvGZbUDqm9oZuocii25681OUiNVbJErPxgDdqR
 rY323O3kkLRDRkJMH4iKPuDmVflefzaXl3Fn9xOAwwUD3ZAbp+89iAv
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f577022-5d5f-4471-de57-08dc70d121ad
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|366007|1800799015|376005|7416005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2NGb0NNd2ZuNDlIdjVJTGJpMENTWTJONkhra3dWdEhwM0hzbk9UdThmVnJ3?=
 =?utf-8?B?MnZDeWF2NHBNTklaQVpZcE50VDZhVkxaeFovdjBUWkNSM2hpZUdpQkE0aStQ?=
 =?utf-8?B?UUdaU3JFWmpsa0tSeXVTQm1wbnNma2w0MnhiYW9SRlByOEtqZWprUnd1Nlly?=
 =?utf-8?B?d1VKUUQ4SWpNRmhrbXB1VU9CejBoK0dVdEcrclFXQUZaK0pxaDNPU20yV3hu?=
 =?utf-8?B?azV0Z1lHdzNvNS93UmFrVnk3WW9RVjFYRkF3SVJ2NWFTWkZLZG4xelNIdEtk?=
 =?utf-8?B?Q2U5OUVnOHVXWW92ZU1zbG41cVh6cFFBY1BzenRZOWJwbE8vOHl4dWs1UThn?=
 =?utf-8?B?dzFNOWF5eDZoaCttM0x5WmtWM0ZIdjBYWTRZQUR1YzgxUUY4a1phOVhybkEy?=
 =?utf-8?B?YU53TFVMdm53SkZJNnpqZGQycERxQ3VHZGVZNXRCNmQ5WnhVbnh1ajQ0bEUv?=
 =?utf-8?B?T0RwVGRleTZjTnhQbC9nSkYzNTgvMFFkSGZOeGx3TnBjclhQdE9RZFA4Z09W?=
 =?utf-8?B?V1dUOGJqU1p5RUhiWlAybHNJZURKaTF6YlZpelhoNFBuNEdkM3o3SDhpRUVt?=
 =?utf-8?B?OGpRZVdCU2NXRkRDOEJwZzJieVlMMmE3WWZza2FTUEFHdUcxOHBLRVFhWk1B?=
 =?utf-8?B?bjFidi8wejQvcHN5ZmcrSUQ5aDIxZzhyRHYwV1RZNHliNm9mWTFNb2VHRU4y?=
 =?utf-8?B?VS8zczNXTDF0UzMvOTJ5T0NWV25rbE5vdVF3S0tRTkU5YzZsekJ2L3J6OWsw?=
 =?utf-8?B?MG1VaWRocGdCekN6TmppTDN4M0xSd08za0dIWXB0dGprekkvMy9VeW82bHhE?=
 =?utf-8?B?OGtFNlFJbzA3NWIyZnpSRWhadk5EcXh2RSt4bGJPYTlHZHlqL2Y4eG1HRlda?=
 =?utf-8?B?OGU0Mnd3Uzl3NGhsTlRxT2I2YUJuaHpidCtqVmtlUklEV2J3ZVBvSGZKZHc0?=
 =?utf-8?B?YmhQR3dsZmpYMjZDcGpwZTlJdUpEd05aeis3WmQ3eFhPeE5KdTlhWTlVNHdP?=
 =?utf-8?B?VG91VStUSC9DYTc1KzJ6aFZ5aldXK2RhNno0cXFxOEVSeU5xdDFoOTg4UGNs?=
 =?utf-8?B?ZlQyT1hqK0FJVEJqc1ljRVhTaEovL3k5cGJBejI4d2JrcUd2SGhwckorQ1pI?=
 =?utf-8?B?N1p6RzVJYzVkUlA2czZpQTUvcWREMWtqNmdjQzV6U2hIdFlvcEF2RlBQMGg1?=
 =?utf-8?B?MU9DT0FhVi9yV04vQVpSWUlVWU5SYzVpRVhJeXRSMHRqNnF1aWRUUENxM0xW?=
 =?utf-8?B?V3k3emR0YmpCZ1A3cWJMaUpLY01YQWEwVnkyekVEWDNxR1p4TDdJUndIOC82?=
 =?utf-8?B?R3hSZndxZGd6M2hMMHpPdndxb2IzZG1lWVpXc05IYlRlOTlWZjJ0RTVzZWN2?=
 =?utf-8?B?WHUwWFJlcmhZb1hjRUE2dFZMMlZEbit5Rkc4VDZsMURGNmlZdytqNUNPbHZB?=
 =?utf-8?B?WUx4NWlWQzNacVo3MUlMSDgwM01pRnlRM1NVUmpkRFpTMlpFYkdpZ3VMbDNG?=
 =?utf-8?B?TXZiY3ltR0ovWUt6bFdnbERPSFBXN3BtZG9KRXMxeW8xNHdTYVZLb1Boc0tH?=
 =?utf-8?B?aEROU1ZBcmxJL01HbVdZUDFFNnNCbDMvMkwyWEphbkdDN096NzFiemJqaEF4?=
 =?utf-8?B?MHdrZmx6UXR3Y0xXRmFCeG9KV2VlMzljK0tvc0ZPMC9CdDNWOVJZeXZDNzNr?=
 =?utf-8?B?OHF2VWg2amdyQnhWaGRhZVNtanI2M3A3TGxwOE1ubWNYYUxMM1RCSDUrZDJD?=
 =?utf-8?B?Q2J0WmtYeEdwVnhZWS9EQUY1L3lPOS9LZVJjbkFYUXEzaEtkL21Gek4wQkxP?=
 =?utf-8?Q?z/bKd5wWcdPeaNMVFreo4/+1fNJIiUaDZKv/Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUc0djd3TmtFWjBhWWdnUUtFaXBCdHpkeGlScThkWHIxaXN6Sm4zMUhEbEdX?=
 =?utf-8?B?c0ZScytLc3dJVHRwekRHZDd0em1RbG03TDFhMWxCT0t1b0RVMDhHYlhSb3Av?=
 =?utf-8?B?SzM5aCt4TmdvOURZMXpCd0dYOFNGVFE5VUc2UnEwVUprdHJtdTBwUTBxSnYy?=
 =?utf-8?B?Q2lZTmo3ei8rRU9sK0htdkxtVEtSbzNDS0JTRU5BelI0eVFCejVKVnZvVEY0?=
 =?utf-8?B?RjdDV05VeFh6ZXZ6T2dUcytPNnJLTDhHdDRpbHpVanI3cVhTRlFXeTFKUENo?=
 =?utf-8?B?WlJDQnVOTW9CU3E4UDI5ZVVXNW5LRnVkdnVZM1k4WkRBT3N1QS9kK0pwcm9z?=
 =?utf-8?B?b2FUWlJ6T3BvdzIrLy9kQW1LS0MxTGpYZUR1T1JhNVdJdXZyWjVkNDhPRldO?=
 =?utf-8?B?MDRuQkh2NWZXWnBnREdVTm5sRmhtajhSRWhZdjI2dzJBaFJMelQvMDE1ZVo1?=
 =?utf-8?B?djFCeTJBSWoxVC9rcHhwbjRabTV6aWdsaTUyVmVaY3FLSlZma0xzZlN5TUJQ?=
 =?utf-8?B?WGZXWG0rNWMzZ21UZFJmRm4vWUN3UmVzSDJmd0ZRNE12cEs0OFl2Q3pFdFNG?=
 =?utf-8?B?Vk4zS3VPVVNyMHhtR1NkZXlTWTJBZ0tuRkxtRVJYNG15Z01FeW9WRTJnSUc0?=
 =?utf-8?B?RU1RYXJEYmRwaEp3WVlaazFkK2lFYnM2YXI0YXZXd1pGaEg2bzI2alBCQVRL?=
 =?utf-8?B?Y3FNT1ZscmdkMzkvWUZhSkN3NVAxUlQyeFVtRU5NeklvUGpLQ0hmK0dSVUY1?=
 =?utf-8?B?U0h2TG1RN1BPd2VWVHpKbG1TM3dWNTgvREE1QWZlSGtJTUNUTjgyNFJJdnhn?=
 =?utf-8?B?YXR6UmljcU82cUdKTGpWK2c2dTdXK3ppc2lyZXlVdkdtdHZPdnU3cU5LbVpK?=
 =?utf-8?B?R2tRbmdsQm9RZVJDTDhQYXVuWGxvc2JFdlhYNldiMFJzRnVUUXg5eTRJWkxi?=
 =?utf-8?B?bkkyeGo0V2dTQ1QzRU9WRkhpVG9xY2VUdjdrbWdYbEx6Z2ViWEhKbFNnckh4?=
 =?utf-8?B?N1hRd0dSK2tXbEp0eGpTNjNoYUtPSllaVm5wam0vc2krTnpDUVlXcnNzSHhi?=
 =?utf-8?B?R3RHUXdLclBERUZIQmdzQTNkTjB2NURPVGpjVndpZGtVeW44SVdkRjlpK0JG?=
 =?utf-8?B?SUZ2RXBSVlRKYmZLY2pjaUR1UDRia2ExbDI4K0lsSk9GL0ZyMXZOMmIybHZy?=
 =?utf-8?B?c0g3dHQ0Y0Fvc0o3enFOMEM0ZWc0VEpFL3J6UDk1UWJFcjJTUnpJTGlLdlFq?=
 =?utf-8?B?ak45NVRLUm9vS0lwQzlCd1RHbEtiWnJ4THp2MU5qUkNUd1N5MUJNM3hUZDRP?=
 =?utf-8?B?cFRyQ3BCK3dhalZ1QTU2YTh3V2M4azRaNjZ3Y1NreTJoWklYK2JZOFF0amZO?=
 =?utf-8?B?YXArNzE1WDJEMkswK1VOdmIzVnVwZ3ZvWUhJK2tyZWllckhEK2EydUYranZU?=
 =?utf-8?B?Z3E5V00yTnlza0VwSE5Ed0Yyc3hIYzF2WVBrNUgxL2RqeVhjZFZBdFhrV2lr?=
 =?utf-8?B?WWtuZXBpT2pUU0RxYjg0aGdXRisrYTlaYWhuTy91WVFOOXZvWTljN3poSnRU?=
 =?utf-8?B?Myt5RDAzcWFKWUxDSmNtZVdMcjN3SlJiWTlzTmE2eElXUkJlSGtRSU0reHkv?=
 =?utf-8?B?UkcrbjVvbzBKaEU3U1FkN1FWdGY3VTV2alFsUzQyT1BXcExXQW54RVhQZmxJ?=
 =?utf-8?B?WWVJN2psZFA5b0xhVkxYUHJLQSs0UnMrY0o0OE9FZ0trZFZOM2hiMVUxN0E1?=
 =?utf-8?B?SUd3aEVKdjZZM05JYzZPcmVlMDR5cGgxdHU3bWNvcnlzbTFid1J4bVZiakZG?=
 =?utf-8?B?cE1SREhCenBFbmw0eG5sMTVkbTZ0VVBIN0ZnVkwwVk5qd3UyZXMvT2hSK1V4?=
 =?utf-8?B?OUI2RVkyNGN6OXl5UnNMcU4vMEUyZGc1WDZoemxHZGszTFEyQ2FEa0tKa3l0?=
 =?utf-8?B?WktVbVRjOEpraU4za2xsNXYwVHJnRzUzVTVOcC9yMVl1Y3VmUW8wODI4NGtO?=
 =?utf-8?B?MXBTdEUxYUcxRW1xc0NWNUNPZWV2eHc5RTU4WGVVVGZSVjF5TEM2b0U2c0do?=
 =?utf-8?B?QUlURnFmRGNjK3VHNmtGUlp1V2hmeFJweFU5TVFHR0RHMkorSzdFdWNaWlRM?=
 =?utf-8?Q?FI4z0tP/V3Afh994f84EQgX3t?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f577022-5d5f-4471-de57-08dc70d121ad
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:11:09.7658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fugmc0eBF0T9Cii/3fiHZV/ucar29+W6qW/e+sYfKxW2u1BcI0rUE0DE+T/+os7nyB2OIlE3kitq+WG6yWy0WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8065

From: Peng Fan <peng.fan@nxp.com>

Bootloader might disable some CCM ROOT Slices. So if mcore_booted set with
display CCM ROOT disabled by Bootloader, kernel display BLK CTRL driver
imx8m_blk_ctrl_driver_init may hang the system because the BUS clk is
disabled.

Add back gate ops, but with disable doing nothing, then the CCM ROOT
will be enabled when used.

Fixes: 489bbee0c983 ("clk: imx: composite-8m: Enable gate clk with mcore_booted")
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-8m.c | 53 ++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 8cc07d056a83..f187582ba491 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -204,6 +204,34 @@ static const struct clk_ops imx8m_clk_composite_mux_ops = {
 	.determine_rate = imx8m_clk_composite_mux_determine_rate,
 };
 
+static int imx8m_clk_composite_gate_enable(struct clk_hw *hw)
+{
+	struct clk_gate *gate = to_clk_gate(hw);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(gate->lock, flags);
+
+	val = readl(gate->reg);
+	val |= BIT(gate->bit_idx);
+	writel(val, gate->reg);
+
+	spin_unlock_irqrestore(gate->lock, flags);
+
+	return 0;
+}
+
+static void imx8m_clk_composite_gate_disable(struct clk_hw *hw)
+{
+	/* composite clk requires the disable hook */
+}
+
+static const struct clk_ops imx8m_clk_composite_gate_ops = {
+	.enable = imx8m_clk_composite_gate_enable,
+	.disable = imx8m_clk_composite_gate_disable,
+	.is_enabled = clk_gate_is_enabled,
+};
+
 struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 					const char * const *parent_names,
 					int num_parents, void __iomem *reg,
@@ -217,6 +245,7 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 	struct clk_mux *mux;
 	const struct clk_ops *divider_ops;
 	const struct clk_ops *mux_ops;
+	const struct clk_ops *gate_ops;
 
 	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
 	if (!mux)
@@ -257,20 +286,22 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 	div->flags = CLK_DIVIDER_ROUND_CLOSEST;
 
 	/* skip registering the gate ops if M4 is enabled */
-	if (!mcore_booted) {
-		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
-		if (!gate)
-			goto free_div;
-
-		gate_hw = &gate->hw;
-		gate->reg = reg;
-		gate->bit_idx = PCG_CGC_SHIFT;
-		gate->lock = &imx_ccm_lock;
-	}
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		goto free_div;
+
+	gate_hw = &gate->hw;
+	gate->reg = reg;
+	gate->bit_idx = PCG_CGC_SHIFT;
+	gate->lock = &imx_ccm_lock;
+	if (!mcore_booted)
+		gate_ops = &clk_gate_ops;
+	else
+		gate_ops = &imx8m_clk_composite_gate_ops;
 
 	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
 			mux_hw, mux_ops, div_hw,
-			divider_ops, gate_hw, &clk_gate_ops, flags);
+			divider_ops, gate_hw, gate_ops, flags);
 	if (IS_ERR(hw))
 		goto free_gate;
 

-- 
2.37.1



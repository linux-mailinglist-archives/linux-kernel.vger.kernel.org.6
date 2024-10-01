Return-Path: <linux-kernel+bounces-346391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A1498C433
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56821C21427
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7051CBE9F;
	Tue,  1 Oct 2024 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XNWZt/WC"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2088.outbound.protection.outlook.com [40.107.247.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62A51CBE98
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802537; cv=fail; b=bo1he1Z1Geq3PB5flzuYm2bOBa9owjc++ggOGMZLkxAsOTjYVnT48dsZC8NjMh1jtSaQHAH8sR4Fs2PaB6kYLXqG+DJBQUTyYsIuJaoTM4DkoCcoOudroQz1X+T8AaVMAqNfEr+4M65h4qnVG8f9tWnmmRb30gry2E6JGFtaVP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802537; c=relaxed/simple;
	bh=DaFfN+74X5tC67JPy6GOxKmdvDVTxdkWjGpCgAk2ELc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rNLXTdMJhzNZtjAdkdnQcwsMgdfRcyRoTlSTMEVKdabe3uZpCOO/5D4x9vTR0uD6UF0UgF4CUgpaBgcksHjyd4s5W44fjq5pd2Te0sz/YIdEbMJWeNRUz+/zrLlD5lqZk+MjwQMB8EAStseCrSlbYm8Wc1Kqxqrz1IFQ+g45ILU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XNWZt/WC; arc=fail smtp.client-ip=40.107.247.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptlxuuzBWxGt+VILVWVhlhT6uzjhiNSdLScLzwJV9BKpZsAPqkgZcJQm/ywZ3N5psI0lYgdN5t8klNgaNs3I20tKvAOZeVuWVCJstri2R0TJdz8l9rvuvuxGVI0V3IpgPG3OOiphS4AqvPmePkVErWhfaGzi7+jrKMn6ZgOa/uCoL5GhqEmwZXpG/OO+6bW5YtPdwQrb1yj00Dtowb4PrEh1yLCkwkmi8cb/7K1D+E1GsD4hC9SX5oUe5NrDfAfroMQ8t0c5IcqxqJW65lp1+dtdEMI4d7WbAj0CSN8HIbXdZxfLD3Annf066naub9Xuf1tLlFBlK//DT6xn/MsWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQfovDJ1ujrnEJUjiym92VRPxtkwgLrPMWqWNVDo7Hg=;
 b=aH5jnb1IjTqirryEox+IgOOkh+GbB0yzZPXI4k4FoC3Wj8JSn3bKmOboLCrwQ0WcchZEVXr0dAPoQ2rKqQZOFEevfjzcW4vOQvFLESgRYlDPTvDH9fcl5pnPpwS9/VUan2DxIcmplnnTMhRyL8jiHygYioN34pBykRXTH+vypvBI8+Y5bZdbg48Az+uAWQUqrpKlSKJDOdU5/3Z96m3963TJIPp+KS5pHFocZJb7UXrmu1LcuRKkgw/q7G/UqT/BfQOpc+wQsYupPaw5Du4X/mzmPZ7UaZmqJ7FqSAy9e1PdEtyr99Rc6lU+CSsXLHHuHp/lqx9n3EofR864daJeZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQfovDJ1ujrnEJUjiym92VRPxtkwgLrPMWqWNVDo7Hg=;
 b=XNWZt/WC9ZZGaoozUF2XmhKdAlg9nTm3Gzw8t8+9zOmQTUEFuHSeaDwDQOGQdYVW39zsTvAZq9rPJWfMAf9BkqhQTvXMTXNmlU5GaCec51kQaQauEOrlT467pwnjcIV4RjvYeOlnyH2KfsXGSt3AFkWuI2V/gy9666RD1TP/7Fv3yko8rFTWFq0CdGJXB/ZMI0ZYhawsHm/g4VyiBSkuonfRd/RBQ478a33/IMKiUa0OevFd6z5CVqnGY1OgsQCod1W+7ZGrLENL76n1PmUfcXY9/Jh+zeofhpjS3m5SpVjczYwdewnSBqTiRCy8aLXvj6XxuQmh7i4sIpMl7ZffIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9710.eurprd04.prod.outlook.com (2603:10a6:102:268::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 17:08:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 17:08:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 01 Oct 2024 13:08:20 -0400
Subject: [PATCH 1/3] i3c: master: Replace hard code 2 with macro
 I3C_ADDR_SLOT_STATUS_BITS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-i3c_dts_assign-v1-1-6ba83dc15eb8@nxp.com>
References: <20241001-i3c_dts_assign-v1-0-6ba83dc15eb8@nxp.com>
In-Reply-To: <20241001-i3c_dts_assign-v1-0-6ba83dc15eb8@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 arnd@arndb.de, bbrezillon@kernel.org, boris.brezillon@collabora.com, 
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev, 
 miquel.raynal@bootlin.com, pthombar@cadence.com, 
 ravindra.yashvant.shinde@nxp.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727802526; l=2002;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=DaFfN+74X5tC67JPy6GOxKmdvDVTxdkWjGpCgAk2ELc=;
 b=fAX8X1NwHDskH+QD8eHzVE0vVBShlP+PdkBhAhv4loUsBHQu7qbdbmhXAmSX1GTg8x6ap9ki1
 tKQJHD9hd3iAeEsr4hXyLODMUYk2K9huSMsXNmne5OxK+5cfhjiCfcy
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9710:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7491f2-a605-4af1-a4e6-08dce23bb9d2
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aFFOTlFYT1RaS3N5ZGlrQmp5YTMyUFpYd0NWK3FnVGF0Z1R6alJZR2c5VHJI?=
 =?utf-8?B?Z2xuVTdHSHBXVVZPdDdtM0FGVHdYVnpUS1BkM0N0bEtsWVVUT2FaZkVtdnYx?=
 =?utf-8?B?Z2FpZ1BLME81aWxwWmFESmlvU1hmK29LamhzbklScU1yeFhuR1d3Zll0aEdO?=
 =?utf-8?B?SGZleElBK3Z1QUs4Sm9oV25hS1pWWEoxbFg3SUFOMXVQNXA4M2hTTE5qSGNu?=
 =?utf-8?B?R2RGaC9IQStteTlBWUhOV0lXZXlNbXdrTktuRmZDbEQyWmt3MzdvSFhKSU1D?=
 =?utf-8?B?aG5Yamo1TStWbFFOQTZRRm5RS1lWQmtEbzg0UW8yb2FtdjdhWVFaaytOZ21V?=
 =?utf-8?B?bitzdWwwUElFNGp1ZWd5cFFtZmVLU0htTWFaU0tZS1NBc0dDR3NZTURvSkRL?=
 =?utf-8?B?MjZtSVp5VStXSVNMRGdpbzlWZmxkYjJuSHZTOGFjN1kybzZkNzZ1WThnWm1t?=
 =?utf-8?B?aTEvMmljY3dIME9XRUZUZm9IaWxmY24zd2RmdjM5bHR4aGxuUWljQXBxZWtJ?=
 =?utf-8?B?RWNTVXdEQlhUbTltdUU5SkJRUVRaY2NXdXRudmpRV0ZsUlJpdkR2SmlDMGVC?=
 =?utf-8?B?eUxpWWIvR2ZTWXlsbUtPR1lGVDdTTmNTT01RTnZ2SFpJd3hkRWJVYVFtblBr?=
 =?utf-8?B?aTFLcUhrVk1LMEVNSVpHcERQMzhsNEcveE9Ka3Y5dDBPU1VsZkkyZzhMbVpM?=
 =?utf-8?B?UG9RWUF1TXFzYlQyaDZlRjR2UGxsbnVKZUZrNWtUZXFuVjhYY01CaXlkRnhB?=
 =?utf-8?B?VmJ1bjJza3JrR1FHMmJmRkhIOXpMTzB3dlBGd0Q3OUxYU0RaK3YwdCtLeHdX?=
 =?utf-8?B?c0hhTlpZdFFrRjdUQ0pJbWNpclB5REZJWFBmREo4ZVFvVWtzVU4valNyd1RR?=
 =?utf-8?B?RFJaQVp1aHZSNU11bXJ6bGIreW52TE1UQTVOQ0ZXWWJ0T2dSaklMb2k2UzQ5?=
 =?utf-8?B?dnhoa3NFYlZ1N1g3TExxdFlNK2JkUHdpc0k4YTNxWE53WlVBWk11cnZiYms0?=
 =?utf-8?B?R1l1Wm5kSTV5OFp5MS9wcnkza1R1Y2VKTFZwSUdLc1RKYVR5TVRZRVVtdGhm?=
 =?utf-8?B?THVPVThsRDhqWjk1R3E5eENYMTFDRnlmTWN6a2pLbHcyV0N2VGppTWk4Q2sy?=
 =?utf-8?B?dVBqdm8rdFhqbHBVZnc0OHI5bXM1Qm4xQ3Zhb1RVK013U0Z6WnUwK0d2Nktu?=
 =?utf-8?B?N3J6V1VWem5vYnlVeXVzVGVwMVI3MWpBV1J4bVl5aTBjMTBqT0VYNUtaZU1E?=
 =?utf-8?B?VElSTnJFdDJQb1NpNmo5M0t2Wk9OQllvN2ZZQ2oxUzlSMHBwVys3Q3YrWUdH?=
 =?utf-8?B?ODNmQzBQcjlMTVpJUG5Gb0hzOXNldmVFYTU1ak1nek43enZkbXBFZktUOGZ2?=
 =?utf-8?B?dkdyYkRmSWIrK1NkU09zYW9LWUFCd2o0cDlRaUM3bkxvZGU1ZzBvOGszQTdW?=
 =?utf-8?B?Y3FLS1UzL3FPaWVkbHdnVW5kcUN1WEpXeHduZUJjdFFJbENMTXd1N3VMTWl6?=
 =?utf-8?B?eHJrMGZZMlBtYkl4Zm5DYzBJb1dqOHRSeFlWSGk0UDNwN1dET2hkV2FDRXhF?=
 =?utf-8?B?OE1MSTNLOTV3c1VDNjdqUjJyZ3ZEdXduSUo5UEZqR0hEZENHNVhtbEJ2WG43?=
 =?utf-8?B?SzhyQzZnVFEwWVJjanloZjRnaEhlT3VyNEs1ejFZTjZJajJmUUE2cDVvK1VO?=
 =?utf-8?B?cjk2c2xnMVBtRjRuRFBNcnpidGZkQXJZT2lrY1czcTZlM2JWZTNJQ21QbjI0?=
 =?utf-8?B?NFNaR2xFenNrb1BzS29ScXBIWkZKOERHT3BUelhMY2l2NnRPUDBBNlJXZ2Vz?=
 =?utf-8?B?cWlucXFTVGRzS0FZM25KYUg3cUNqWG11UmdHbWdKdklSSS9NY2x1T0VTRGc2?=
 =?utf-8?B?ZXVQSjVnVTlDNS9pekcxOThEMlRiY0xHeTRwSmEwaHluMUE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QXdJaWoxT3JMNHplcFNsVE43UVFXTXc4b3ZkWktCRk9KRHc5NGYwZkVpNHlV?=
 =?utf-8?B?NlpPY09wM2g4MnR1MDF3S2I4aGRCKzN1UEVOTVFzVTRQcUQwbk9aTEhhTjhK?=
 =?utf-8?B?K05FMmsvS2pUcU1TTDZpK1BSQllmWU0wTVo3Yjd2OHdBa001T1I3OVZEWGJl?=
 =?utf-8?B?TmVTZFU3S3NMdXlUejNnOWRaTmtvZXNvZUhuQ2t3YTN4cWhYbEphR3hPQmpv?=
 =?utf-8?B?cUZtWVA4TllOUTZxa0JKM3FrenN4ZHIxa25SSTBRVVU5bnlmQ0pJOGE2eG8x?=
 =?utf-8?B?TzVoV1ZsRGNjZlNnemo1VjNud2ZuemdKdkc3aVRDRDR4NzZWR2M1Y2VrM0hn?=
 =?utf-8?B?OENLR1dKQWdKVXZHNlAySlhMTUkrdUFBRHZ5dXBlVXBSNlNRcWREZCtVYWt4?=
 =?utf-8?B?N0ovTGVSYTZHb3N5QnBQQXl1NU8rNUNVZUY3NjNaenJQZnZQUWg5bjFXNWhJ?=
 =?utf-8?B?SHk2QjZXOUJvOU1HVTliZ0k1dUxRT0lIZ2gySWxiYXB1WmZERzRNWHliRmhC?=
 =?utf-8?B?elJCQVlldjFJYWV0RWZVL0hZY2R1WFlJaUFRN2R1YmQ5V2Y0MVNjeWsveHZi?=
 =?utf-8?B?QlM4aG9sN1Z5cGZjZUFBWURUTEhQamNaZEZwRzJHSXhVS29McyswdnoxTmRp?=
 =?utf-8?B?Q0dZa3QvbmM2dTcrSHhxaXpyWDFHSmZmZnlBREY4b2JaTVo4RmE3TG9xZGdL?=
 =?utf-8?B?UTMzd1o3RmtIM3F3R1ZNYzJXN3cwRXNrTHFnS2t1VTVTU3JkRW1tS2hBdC84?=
 =?utf-8?B?VmRxdVBUWlA2YzRRaEQvTFlKNEs0WmlKR3RWSDgzNld4Yy9yVTQ5VnJhVW5M?=
 =?utf-8?B?OXlSZUlMT0xGamRzeFFEQVVCVkhLRzVsT3Bxd1VpZHFjL3piWGxXUFVEZytV?=
 =?utf-8?B?K1YzNElUUVpqd0Npc1VDaUF1VExBZmtJR0ZHNUJkbThENEU0VkZHdzN1VG16?=
 =?utf-8?B?dUJMQlJhVkFmWS9EaTM1djlnemJYb0lBVXQxODBJYXhpQnlpOXRLYXc1RTlU?=
 =?utf-8?B?K04vNzFYSFRrbzRnbEQyL1RFTWlSKzRSQmFQUXE4c2dJd2dEVEhpTFo1elUv?=
 =?utf-8?B?OGp3L2xrSE45bUhyTTFGazh2V0UxT1FqSCs1VEl5UytnN3NIQjg2UHZJV1c4?=
 =?utf-8?B?SExuOGdsWEh5U25JdCtpVGo5VXkzT1ZwSWRWTTVJL2ppb0lnK1R0RmhkYy9y?=
 =?utf-8?B?MDl6SjE5dS9rbnE1bjk2c1NDM0xScysvb2JJWjZIOUhJZ21rWk5abENDWlly?=
 =?utf-8?B?ZWxYOXp0YnkySUZ1TVZQOFZoanRDc09kTnlTMHlRMHJySE5PM2hLUEVXRFZ3?=
 =?utf-8?B?TUxhMHJqS1RjQXkrUnhYZGt0UWdIWHBERVgrK1E3ZW1tOS9xaGU2eXgrYk9S?=
 =?utf-8?B?S1ZITkZYWEFsblhUN1krVFZ3Q3BiR1BhOENOL254WUwzMmRPS3MrQUl3VkhO?=
 =?utf-8?B?QWJzeGlxQUpNYWVESVRxcEhPbnFNdGxyTDRZWm9NNzNUanF5eUlyWVZyVU4v?=
 =?utf-8?B?TWxDWjk0SjV5QzhoUkhIOVJnczNXOGd3R0ZSWDNKRkc0cEQwbTk2SG1yaC9X?=
 =?utf-8?B?UTMwYTNBTHd0dXdzN3htNGFyblNRaytXVWJmQnl0ZVo5QXJEbXVtN0twcDdE?=
 =?utf-8?B?OW1EL1VleHphQ21KZHVEdmt3eC9xaXF2TXA2dUMrUWhGbkdTSTJybm13cGlM?=
 =?utf-8?B?dkFaU3JYOXNpUC9pUEFYSnJOYkpuTUYwOFBPV09CSFQzTUxPenN6MFhXN0RK?=
 =?utf-8?B?b1RyMGEzcXpLWUF0dEVPWUhNQkhlOTJzS3EyMGlUakZvSjYybjJFUzJSZEdq?=
 =?utf-8?B?VWdDWXhzNjU5U2E3VTdCL2xacVlXRW00a0hWOFlFbVdXRnlmMnNQblNjU2xi?=
 =?utf-8?B?M1RKSzVnRTNrcTdIcW9Tb3N6RkpnNktkdERTNjJHTUFOenBhZzU4Z000ZUl4?=
 =?utf-8?B?dW13aG16QXdSc0hNUXhKMVpsWTBHb0VLc2FLOHA2MFcwbG94bVBqZ3I5cmFt?=
 =?utf-8?B?N2JtTU1UOVcvZlUzaUFsM05tUW9LU3U4Rmp2L2w0YW1KMFhmaUNaYStsUlNC?=
 =?utf-8?B?U3VlMmVjbzJvSXMrM3h1bElrNDdmWEJsd0FJTnllRlB4ZGRCNEg0Q1ZkWGha?=
 =?utf-8?Q?W5oWEzD4mGJyX248vTDiLcM7n?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7491f2-a605-4af1-a4e6-08dce23bb9d2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 17:08:52.9280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqW3sXG2upmX0JquukqmCdaigM50q59DKBwlg5dK3iSlfOKT+f3vUz2uOabbB7t7u0s2Bhh3FN2G/E7D/AbacQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9710

Replace the hardcoded value 2, which indicates 2 bits for I3C address
status, with the predefined macro I3C_ADDR_SLOT_STATUS_BITS.

Improve maintainability and extensibility of the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
- rename to I3C_ADDR_SLOT_STATUS_BITS
---
 drivers/i3c/master.c       | 4 ++--
 include/linux/i3c/master.h | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 6f3eb710a75d6..dcf8d23c5941a 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -348,7 +348,7 @@ static enum i3c_addr_slot_status
 i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 {
 	unsigned long status;
-	int bitpos = addr * 2;
+	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
 
 	if (addr > I2C_MAX_ADDR)
 		return I3C_ADDR_SLOT_RSVD;
@@ -362,7 +362,7 @@ i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
 					 enum i3c_addr_slot_status status)
 {
-	int bitpos = addr * 2;
+	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
 	unsigned long *ptr;
 
 	if (addr > I2C_MAX_ADDR)
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 2a1ed05d5782a..2100547b2d8d2 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -313,6 +313,8 @@ enum i3c_addr_slot_status {
 	I3C_ADDR_SLOT_STATUS_MASK = 3,
 };
 
+#define I3C_ADDR_SLOT_STATUS_BITS 2
+
 /**
  * struct i3c_bus - I3C bus object
  * @cur_master: I3C master currently driving the bus. Since I3C is multi-master
@@ -354,7 +356,7 @@ enum i3c_addr_slot_status {
 struct i3c_bus {
 	struct i3c_dev_desc *cur_master;
 	int id;
-	unsigned long addrslots[((I2C_MAX_ADDR + 1) * 2) / BITS_PER_LONG];
+	unsigned long addrslots[((I2C_MAX_ADDR + 1) * I3C_ADDR_SLOT_STATUS_BITS) / BITS_PER_LONG];
 	enum i3c_bus_mode mode;
 	struct {
 		unsigned long i3c;

-- 
2.34.1



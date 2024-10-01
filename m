Return-Path: <linux-kernel+bounces-346390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2E698C432
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B91B1C21B2C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA41D1CB508;
	Tue,  1 Oct 2024 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F0x3G7Ua"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2088.outbound.protection.outlook.com [40.107.247.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FD31CB50B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802535; cv=fail; b=Oe+P+nbdsTL6CmBkYpmF5uZpUBiPtOZ+tFiHA4aRFlyX7vPjPq56c5wZf9ACi1/p30hj2Jm4pZczntKbNkdaMed1VcIiQN/VhXWQ3th6UYoE0iWCCIdkbb9Ab10PmGxFT/UGTeBj83LXZQFY0w5UO2O/A9hVaUESmIK0Rg9QyW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802535; c=relaxed/simple;
	bh=LTE5ego0SeLYowWBP7tV0c5GAHBDraD1MgZKK4UYgJg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=bkaVN86TWIeIp9SRvMlfsl3DuIYxEcUA2Efl6BcMlfxaiSTcNwBWOvBT2QJy3l4w2ONyeR47GR4McTUXVJ1mneASx4S8i+DrAGoWQaGpRXvXyf/troYgAQjN8KR6zoeo0buOR4V7aaiVRZQ15FOEJVmTooHC21+UwgDxhoO9RuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F0x3G7Ua; arc=fail smtp.client-ip=40.107.247.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBR+tZFozV2Wr2Qd9SjuvQjyXxdrTzhbT4IeiL/CRAhL2DdB27roFeMSvnxzoTioA5DlcUms62VXbycBaE/wSM3b/T125xMH4xFP2UJZrY5/yQbjQh8BfTl6Cn/oiKz3cE3/zT8vnd51YMp+jVBnKhbAd0Sb00/9baZxA7De3zr7EPd2yyht7Ldn9HjtBPpI/2uTWqeWwY+71AyAqB9qbCMVnnU7QVm6lWgkyHExCnFqejclTP1gCIRCdx3EM5sy/IGnUw8q7Tp/ojknZt0U0eP1cHxAMDB5jo4dsRU0AbYvAyDH3RxkuT0ASItklZGjMM9az4uzUghtym6/LV0AEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aay5jINYC5iI7kAZW+VAYpy5xHGg1bMv8Z8UFYY/6GY=;
 b=OkVeeaAq4p6W4ABmnAAFqCyS57hVykAK+NXUbEHn4LtibZrAKXfBb2SaLimgInojppkx45Alt+sN6w5R2c3CCThH8yumMspn05eY0MDNeOXHJAZgjHTvg7josn0e7qrhnDyUTUZ1jsRj2dq7mOCEAXRJfC3KNl7fYmrUplRFT7O6JKiYVzLg331Jr62Czi1QOb1KXZRFUk2oFnhF6HsyFKEKVfKWxpS7iALaNsuPJHrBks88hKIZ5QeM/jzSZ0sfK7IEbDPq3JNbK3QHt6yay5z3fwE5K7WCrqjRnEjOsn+oA+jU7SDrES4TSy+ORdSYPEN2XhMT4DDgw2S3EwAqTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aay5jINYC5iI7kAZW+VAYpy5xHGg1bMv8Z8UFYY/6GY=;
 b=F0x3G7UaB/EKgOPXwx5tiiaqQWqlExCZxeOGbbfUDUYmDZ94O3u71FnmrD1ui4Q6/sYdeoh6eMQgy8FZ0+YW7BeKXmMhN6q4USJuNqDnE8OQYiPLLCYFKTxyXsbK6jNP+zOVvTHp8ouwLpQmU/sguylMcQ9HB/MOkvhf0a3494cfTjMT1fcvLss1yndT9poksjxbISbw/CQVWjM2cXLZjVl7hWHaHcqGoRKskVK+sSLwDqb+5yn/gnKOfwF1aFrYndLHRPmZ4JRvV7UBAx7WvrSBlptd04LwzBqdpopR71I2fbrjnAJbCsD92frGrmWDo7y+jrcf4TZSzVaNQHzspQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9710.eurprd04.prod.outlook.com (2603:10a6:102:268::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 17:08:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 17:08:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/3] I3C: master: fix the address assign issue if
 assign-address is exist in dts
Date: Tue, 01 Oct 2024 13:08:19 -0400
Message-Id: <20241001-i3c_dts_assign-v1-0-6ba83dc15eb8@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIMs/GYC/x3MMQqAMAxA0atIZguNVQevIiIljZqlSiMilN7d4
 viG/zMoJ2GFqcmQ+BGVM1Zg2wAdPu5sJFRDZ7serUUjjtZw6+pVZY8mjDhs5BwRBqjRlXiT9x/
 OSykfdnHfX2AAAAA=
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 arnd@arndb.de, bbrezillon@kernel.org, boris.brezillon@collabora.com, 
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev, 
 miquel.raynal@bootlin.com, pthombar@cadence.com, 
 ravindra.yashvant.shinde@nxp.com, Frank Li <Frank.Li@nxp.com>, 
 stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727802526; l=2712;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=LTE5ego0SeLYowWBP7tV0c5GAHBDraD1MgZKK4UYgJg=;
 b=codmkhwH0jS5jJVcDN0BerUYEf0uSm4Guowl22bRKPicXqpnF5Wso1Ry4Veg07yOwy4UFO512
 6cIsaagZL+KCayGv/GWyeGA1pfMipWlNsM43SL+Eag5G+JdggVg1N8c
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
X-MS-Office365-Filtering-Correlation-Id: 8ea9a791-60c7-4cad-c77b-08dce23bb7ce
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TU5JcnZWZG9YNDY0VXc1ZnFFbjhWNStxV3RsWWZQelczclhXZkR3bVNOejJ3?=
 =?utf-8?B?elFzNSsxVWRQRWRpTHR5Y3VUMWlqZGJFWHZvMlRaM3VlZGpYNkkyM0lVellQ?=
 =?utf-8?B?MGRHSTlZbVY3UTQwQWlQZ3ErWWdCZEFxUWRaMWpXdnhmU2hXSWtQUHloeWpS?=
 =?utf-8?B?M3Q1aFdnaG1GTFNzTWNDalNqSEQza0Q2U1FtQm9oK2c4bFBMN1EyUkl3UUZh?=
 =?utf-8?B?WVlpZExZNXVnMjA2dlp3TWhpZDk4Y29pMXh2K0prbEYzNEVOMTg0TjRzVUFx?=
 =?utf-8?B?bW5TNVkvdFNiSWhlcHJqbDZmOU9xSHB6MFNrdDRXR3A0WVllMW05RWduWDNw?=
 =?utf-8?B?TG0xaDhRQU0rRi9TYmpKN0x3aDRTUFpLWm52MFdsYzdWYk5CZXoxSHZCOWNG?=
 =?utf-8?B?U3k5S29SU1RBOXZhcTBzbDdveFN1eG5EV0FzTlg2dGdjM3pkRU5HNkgrNnRS?=
 =?utf-8?B?WlhySDdjRHZ2dCtCZDA5R2tZVEYwNWR6WHh5OWVxMHlpMmc1anY4VnRGd1o1?=
 =?utf-8?B?eVFQblBnNWQrd3o1NFMzRDdEWVlRTUtEbU5Oalp5N2paT2tQdG52b1B4WUJO?=
 =?utf-8?B?c3lEREdZVTl3MmJZRTh0UHFaMEFjZStPYXVyYTBlUlRLNTJVRG9jZndoUy9B?=
 =?utf-8?B?QTVlMmZtbkZTM1ZpWEZrUURZeE9hTHo1emN6MXk5cnZzNngwdVExekNlRity?=
 =?utf-8?B?RU9zMEFNQlZRY2dMclJSNGZzZUxyWEtpNlptN3l4ZnREcndKYVJpUUc5OWEy?=
 =?utf-8?B?WjhNcVJvQ1lTV0FqNDdON3BieTNaT2pLcjVXQ3JsZDIwOC9LVll3eHRGQ1Vt?=
 =?utf-8?B?VWpwenFuK0hFNjJKZFliblRHVm1RSXVNTlQ4Q3lRbEEyOStEVklTZ21FWXJV?=
 =?utf-8?B?SkVOOGJXbWk4TEVxYTJpTkZDQTZJSjNyQVZxTmduU3A5d0EyNDdFOHRUZFU0?=
 =?utf-8?B?bmVpc3NlZzhuZWxNVHFXWEZXcDZNdFMyeDhjdFBFTWg3TThOSVZlaHRPeUZx?=
 =?utf-8?B?UjhKUHBGc0QySEU2TkxRVW84R0psd0dXeTRMSkxGaHZ1cC9WaUlsV0tuSWdu?=
 =?utf-8?B?dTlXRWNLYVI0b3RhNlI2dnlNNUNKK05HRUJ3Z3d6Sm5tcWtpTk5vbG9zWEFN?=
 =?utf-8?B?MytMNTFIeHFhSERPWFI3OTE3ajhnSGZ4UFdjMUExSnpBb1pZLzM3RDV2NWtm?=
 =?utf-8?B?VEVhTmJPdytMcGdnVXVMTUFNelhFaFowZ2ZlUXpqS2RUK2J2QmlveElXeCt2?=
 =?utf-8?B?OWhrbFcvOVhvUEZSL0h3azFDNVpXZ1ZINU5YeGN1TmNDaE15bmRIb0hqWXNN?=
 =?utf-8?B?VWE1N2kxcHQ1VzZZeE9lVDVhNzNGcUNaaFlzYUwyTFpKTCs0OFFoTFVCS1dr?=
 =?utf-8?B?SHRhVDV4dEJ6V3N4M29YRmRmYVpFYzJFa2NpM25semNFZndhR2F1eS91Q2JM?=
 =?utf-8?B?MG9TdGhITCtZWGowRXFXYmsvT0NZcmxTcWt0b1RpbE94a2p0TnQzcUFaSTh3?=
 =?utf-8?B?dklBSnhDNWtYTGtMQStna3hHZitKNjF6N3dzek03cU82QlVZVnJueUt0K0ZR?=
 =?utf-8?B?WCtCYm1BVEhDOVE1VHBSc0lITXc0MmsyeURKWkQrSFl0dXdxamFDUGRmRENn?=
 =?utf-8?B?TFlDZEd6aU1CV1Fseng2U0VaN3dVakJ3cDdRd0pGTTNGb25VUEROM1JicFdK?=
 =?utf-8?B?SERON0hqSG1ESHMxWHNFaXh5R1FBeXp2MUdiZWU3QnRNalJYRVN6ckNRcHlj?=
 =?utf-8?B?N2hPVjdid3ZvTnA0Wk5NRnpSV215bWRxRmpZUDhOckdBd2orVmp0c2dMZnow?=
 =?utf-8?B?QTQ3dkZueTgvcWlic0JFVzYwNzhFMFpKQUtKNXR1U3hHMy80ODllV2xoZ241?=
 =?utf-8?B?MjVvT2RSc0lORXVUTXd2YXAvZUhwUUdjRmlZSzBsTXZlbmc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NjhTVnFWRHdjb3ZwdjF1Z1NSbzM1QnE2TWdUT3k1clB4a1pyOTFPanRMeTdm?=
 =?utf-8?B?cEI2YlFPRE5oNlRYNDhxZ3UyRnYwd3BOMmdFNkFqQXlzOFhjdGx4UkRYRTM4?=
 =?utf-8?B?Q3ZhZm1wVm5KWVNDV3I1UXVZSGxQNVpReStwM3VCVVFJbUkxaU5sdzB3dFdI?=
 =?utf-8?B?U1ZMU0xxY0EvR0g4eW56UmhrMVpWK0M2dnlQcGhZaTNYTE1xOUdPTk9rQWZ1?=
 =?utf-8?B?V2pKVSszZy9VTzV5WmJQSlV4Z2w4RVNrK3FlUE1qdjBTdmNIWkJDVGVlTGlV?=
 =?utf-8?B?VkxyZWFRcUovUnQ1UDc4ZlFLczZQMHI2MWk1VnFrVlhsRnlPeFNmU21lWkl1?=
 =?utf-8?B?SGdxaytzamFHUkhMZStlalJqYkMrQ08xdzN0eElGVVpEeDdJTnhML1k3Umdp?=
 =?utf-8?B?YWJBVnRGMTg1OVZIR3dTWnl2RkdaTU02bmk1TXJIY3RyajE3a0ZPWk8xV0Ey?=
 =?utf-8?B?UElReDRiR2VvUkpua05DWUc5NW15cWhDV0sxMm4xWU9kTEQ1dnlVcXhRZGRD?=
 =?utf-8?B?STkyRFJVcjBuZWxJUzhFSWpGVGFaY3V0RFBVTnRrRit3c2JZQmtnQlhzeHl0?=
 =?utf-8?B?bnJJTEFFWEFCKy83SlI2YTBLN1hRZEx5OWFob3F1UGdIMklqOXRDNll6L2hF?=
 =?utf-8?B?U3pKdTI0WDhZUFB6Rmlrc2kyM3BkekZjbkVvUjEzZVc3M3VPTFNGV2dCNlpM?=
 =?utf-8?B?ZTV4d0ZaQUE3d3FaV3VJcko3Tm84NFdQbkhyekROZmRYSWRQUnZ0bzZ4RmY2?=
 =?utf-8?B?T0F3OGNzZktNTHEyT3JOazdwWm5qTmhNcFQwNVZUdExQZjRqUWx4SnhPc3FP?=
 =?utf-8?B?MTArQnB2cjR4MnV2cE5uei9lUFlSQXcyZnB5ZEZPUWN6RklRV2xXYTFKcmo2?=
 =?utf-8?B?bE5ES25nUjFEb2VqWjlBWGpsY2t1QmhhT3g3aVFkSWQ1aHc5ZzBsZ3pZaVBi?=
 =?utf-8?B?QkQrOVM5RHhsaEd1cUtGTjNWd01KQ3RjR3BPblV0RU1SZHg2VWtNY0hKeGsz?=
 =?utf-8?B?YWtYcVpxbjJaNjk5SnFKaXE0N3hqRzlpQnQwbFBadG81c3A2TlNqdU9LTVdY?=
 =?utf-8?B?RU9WeHNWbllKRWQ0aFoyQzFqS0wxb1A3bzZGejlwRGNDVmNOTWpZVTBMNW5L?=
 =?utf-8?B?c21YWldPRVpweVQ3Lzd1aGRDclBsSzZ1WC9vcCthRTdwWHpMUndyTWxUMG9h?=
 =?utf-8?B?bDFnbkY5MU1rWU43ZzZaSnFoQzRUM2FyZmlnbzBjNWNYdG1TbEVpOUk1NDBr?=
 =?utf-8?B?QW45SU9FTU9ISGNUZGYvcVZFbmZkTkpkRVNLVm50enNiVTZ4RVo0VElHZUdN?=
 =?utf-8?B?MGQyM3dsS2RlTDdPV3hOYnE1VVdnME1YQVZ2cmphaUg2Z1Q1NGRCS2pDVW80?=
 =?utf-8?B?RmcwK0hWTHFSNWZuMUFzeHpMQjFNSjJUV1h5amd2MndEV3oyczFrZ0pKQTMy?=
 =?utf-8?B?K09rdDJPbXk1N29VQmt2V1lEc3JoZnd2YXVLVEowQmV2enhwVkkzVnovaTR3?=
 =?utf-8?B?WVV1cU9ZaGxWcU44aS9uK2FiUzBUUHFzMUtxUCt1S056SlpqdHhDVnpId2Z2?=
 =?utf-8?B?bTJHOHlBcG11YkFlWTkrN01XdTN5dU9oc1lITWl4MVl3VG4zc21oUXRiVWZw?=
 =?utf-8?B?YkFYVDdoK1BVL0FCbGx4emJla2x5UHhnSFJpcFVvRTVlSThoUkg5WDB6S0l0?=
 =?utf-8?B?ei9yUjFSNzdaVDJnL1dFVnhuTjg1R0xacmREa1R2amMrU21oaW5WK2pVQkxs?=
 =?utf-8?B?ZXQyUlE0aWRBUDROREVObVlqTGd6ak9QSWpEWUVKMmxwYzJiTXN0MjE1b0dQ?=
 =?utf-8?B?S2djYnI1RnpHeXNLV0FoK1JNTFl6M1liTElMKzVQQW5MN0JkY1ZwZm9PTS9Z?=
 =?utf-8?B?cGJNYVVZay9LOXluUEpMZ2plVUhNaGxtZnIwM01Hd2ZrcEVYNC9WNjRqMk02?=
 =?utf-8?B?dkd0MXJhd3gyVDZDK1Q1ZWphKzFUdWhUYUxqWmhhNWU0cTVyUFBsOHUweE8v?=
 =?utf-8?B?Qm10UzdZTTM3cXI1VnpMdXdUbmgrUkxzaENJNzNCU3BVVFlOMkNtYmtSeito?=
 =?utf-8?B?ZVIzL2F0Zk1LaFRnS0VlbDFoNjA3RXBXak43am5HbTdtK0pUTit6ZkZIR0Na?=
 =?utf-8?Q?jPmKi97ppNoAiwPJFfRBEdd+p?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea9a791-60c7-4cad-c77b-08dce23bb7ce
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 17:08:49.5302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkAeZaOqZfiqf+wnwDv9OIGhlKmYnY3ImxRPJKD90OmNy7ND96KTfYctj3sZII1DDIw1IdcRN3JRWMjJU5IVJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9710

These patches are split from
https://lore.kernel.org/linux-i3c/ZvrAuOBLgi+HtrPD@lizhi-Precision-Tower-5810/#R

There are discussion on
https://lore.kernel.org/linux-i3c/20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com/T/#m16fa9bb875b0ae9d37c5f6e91f90e375551c6366

Basic back ground is
The current framework is
1. get free i3c dynamic address
2. if found dt have assign-address for such device (identify by PID),
change to such address.

There are problem in current implement.
If device A have assign-address 0xa, device B have assign-address 0xB,
which described at dts file.

If device A is not ready during i3c probe, and device B hotjoin happen,
0xA will assign to device B, so if device A hotjoin later, address 0xA
Can't assign to A because B already use it.

Mirquel's opinion is return address B when B hotjoin by scan dts by PID.

The issue is the controller HCI (i3C standard),

I3C HCI Spec 1.2, sec 6.4.1, when do DAA,  "DAA CMD and dynmatic address"
queue to cmd together.  We don't know PID before DAA CMD. So dynamic
address can NOT get based on PID.

When do DAA in HCI, it needs a dynamtic address firstly before get PID
information.

Consider this need more time to discuss, so split from previous big serial
to avoid prevent other fix patches can't be merged into i3c tree.

This patches's overall design:

1. keep current frame's work flow
2. reserver all address, which assigned in dts.
3. the device with assigned address have high priorioty to get such
address.
4. if all address without assigned by dt are used, use offline devices's
assigned address.

To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de
Cc: bbrezillon@kernel.org
Cc: boris.brezillon@collabora.com
Cc: conor.culhane@silvaco.com
Cc: gregkh@linuxfoundation.org
Cc: imx@lists.linux.dev
Cc: linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: miquel.raynal@bootlin.com
Cc: pthombar@cadence.com
Cc: ravindra.yashvant.shinde@nxp.com

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (3):
      i3c: master: Replace hard code 2 with macro I3C_ADDR_SLOT_STATUS_BITS
      i3c: master: Extend address status bit to 4 and add I3C_ADDR_SLOT_EXT_INIT
      i3c: master: Fix dynamic address leak when 'assigned-address' is present

 drivers/i3c/master.c       | 85 +++++++++++++++++++++++++++++++++++-----------
 include/linux/i3c/master.h |  9 +++--
 2 files changed, 72 insertions(+), 22 deletions(-)
---
base-commit: 77df9e4bb2224d8ffbddec04c333a9d7965dad6c
change-id: 20241001-i3c_dts_assign-d615fc33cc1d

Best regards,
---
Frank Li <Frank.Li@nxp.com>



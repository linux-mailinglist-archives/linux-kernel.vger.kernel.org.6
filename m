Return-Path: <linux-kernel+bounces-295894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79D795A2A7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC422818F3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1761B1D42;
	Wed, 21 Aug 2024 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PWB5vJLO"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2064.outbound.protection.outlook.com [40.107.103.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917121547F6;
	Wed, 21 Aug 2024 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257195; cv=fail; b=Dlll0Ft3+EXmS8RWv5H84FpQ8e5Kk19oyZrNUxnO5j0BTRdB0pAd3NsjK42cYJNcv74SYpy9a03kScOCvF82DaladsOmA01C0TH7LuEZE3mG+qGA6qjZRK+B5vBPQj2X+qcSzYRMAJQF8FCO5lfM72OxCNkn10tb16fDnmJQWBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257195; c=relaxed/simple;
	bh=EXCQ2yHg5GsraSbI5hSEprSk//rI7vkb56MC0YIBq3s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dZeZXKQtPYJbjaUAsf1P+ppC7rmE9M7Ig3YzU23oLbR1TnDHKs0TjFiLHq+GYC8X95fIoecMW3ZQdnxdDw6BeeW5S2ZSRvv7dBDseFcCZkGNq2g36dKqGjNFW4/5pGlf2fc1Xku0nI4/FvKBsgms3C2nbeP/qW95nkr2hqQ3kxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PWB5vJLO; arc=fail smtp.client-ip=40.107.103.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAstBK6woEJG1+8KgpRqxGI1yaD38L3018Luv93T1dEtb7FDqYHVtBy+3rGHJ7wLklU9jfY5fOyeJ85PjuEo7DZYc/jG+nkZmuxnOdtWW4XhUHkONVx66eyliPIgvsC24a6DWjXg8n3O4g82YfaPG9TxhJqf0DbwMj99Lgnb4TlPIF25TULcbhEC0hidfjDAkJGtzTb+LjVc9KSUTEeQDME/WYPDk3G/JKGvbcTRhwMGRSWCcH/L3FJ8xnRaLuVy9eb0TbwEYw2eEe/dENxLNfoI5taf+Z48/mjNX8rC7cH+4erWIDD2JHuKfE7Rc8MoQysWxj/XbypS9lLvovB7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdrCIBO/TZyt4l7MWJRsQaIAmL6xsDKfq9X4Mftx/o0=;
 b=WaoV8SlMU75m9qJ6YKD/AWcrld6XorDze3IMjLsw+c79K2w1TOISdKB/aoUbcTxpr/szzyZnf0gUkUxz9oXHBXIWLeQxyQ60p9TKRnWz8bdy3HmTNI19DMatG2Cp1DgmXn1W313K/BrpybEDTZ8EvbAysA0aVnPX0XgFCpgMNJlc65BL1muwwFzkX5EIF82Y5S0ltkJr/PZU2udqVGJbyhFLyYiEyEJ66/V+rC22ME6+U84631DwBHl9N1MLiAEyiwrGZuIOinUG3b4hrdqXtyZ2E1F+9qR03vKQBa6HcF7ih7pQsIy8XZnz+BS/InrKp/zrswGhaaq9fqLvbbXxfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdrCIBO/TZyt4l7MWJRsQaIAmL6xsDKfq9X4Mftx/o0=;
 b=PWB5vJLOgDUKCxwjtrYbFIiKqtZg6bYlbYry+IJQ/l0KWgtCl1gn7FRfdc4GR98XJ6nDHj6OyGdjq3Ok8A6XiXoDKKGi+QAl1XWY20TsRIs3j0PWHxGHneYJrJ/XNHTL8nncrM+IAShfL3FtFC6tNIettUCLOAO96UX7xdPLgd6ws7cfqmq32HC8Dpqk4KaJTjGoezy7XSc0wQBlEMgv+qOBTVLJmq9hbeAVLdUxPm/MfxmVAVNxtEIEkUescypY/vdnO6c9asZD4iV9m/TMDvnPUXNY5WKhyoWEdL7lK0UMTsbZq9mynjqCLNSeF+usTTulscEEUQBtGPRivRpr0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7817.eurprd04.prod.outlook.com (2603:10a6:10:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 16:19:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 16:19:51 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 21 Aug 2024 12:19:07 -0400
Subject: [PATCH v2 2/3] usb: dwc3: imx8mp: add 2 software managed quirk
 properties for host mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-dwc-mp-v2-2-2a29b6a5c2f4@nxp.com>
References: <20240821-dwc-mp-v2-0-2a29b6a5c2f4@nxp.com>
In-Reply-To: <20240821-dwc-mp-v2-0-2a29b6a5c2f4@nxp.com>
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, jun.li@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724257180; l=1475;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=EXCQ2yHg5GsraSbI5hSEprSk//rI7vkb56MC0YIBq3s=;
 b=4DeK1iLrhkfcT5U0l7VdnjEUUpj5XNyQUUrRr9jFUbuFX0vt2MycHtg+gA5/wfhs/QaO5QFR6
 u8BoXirNvixB70/FKbCkzBFVWNuhj4JnupcY+lulcQbr48/B9IaMhTc
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0056.namprd08.prod.outlook.com
 (2603:10b6:a03:117::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df93d16-533a-4034-0f32-08dcc1fd154d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDJ1aThqdEV4Q3l1NHBUaVBQUVYyY2NvNHJYL3VEMjdmazM3VWJiMERUanhZ?=
 =?utf-8?B?N3pwWjFIMzZNZjFrU2FkZG1jZ1dBQVhvektHMkxyV2VSckU2bHMwMUIxTFJh?=
 =?utf-8?B?V1hNT0V1dXJGVENUMFA5Z2QrS01TdHN3V2dlYS9IY2wyd21MRDBCVUVjbVBs?=
 =?utf-8?B?V25FeFZYR1pMQzBHUUpqVWlVdm9IbjNnemI1emVWRWZxeVpXWnlrL0RpdVhS?=
 =?utf-8?B?MEdxcmJzMXg0Rm9OQnF1UE4vRk1Ea290cVpQQVU5Q3RWQkZaUkx0M0FEcTll?=
 =?utf-8?B?LzUrWnpqa3d2SEdSWVEvYVllNWZmejNtNlVORHM0Y3dzVVpoV0RvZkZ6YkpC?=
 =?utf-8?B?bklQMHVrMTEzdnVnT2NtY3RINS8yT3dwOEpBQ3NwOHpwa1QyUno1SGNLWmV2?=
 =?utf-8?B?dU9DVklZV3dzaEpwZ3pxOG45N2VOOXVMaHAyWkFSTFpjUHpvQ29HNXVURmV3?=
 =?utf-8?B?NTJNOWZpbDBWbEJXOCtqYW1xWTJ2NVJuMmQvTDk4Wk1SZHlOMm9YUUhGcWtD?=
 =?utf-8?B?ZUlUeEZrWlNndXpJSUpNTXRqb1YwR0V0cGdLU0JrT1N0RUp3M05FMU82RDFo?=
 =?utf-8?B?Qk9ZSTM4QWJTanJlK3BXTUViT05xU3krV3ZBZVRmN1o3aG5mOVIrUmo0TGs0?=
 =?utf-8?B?UERGZXFCWCsvSFZQWFMrQjcxTDMxZEprRXEzOUdhY29oYStVeGlNd25ZVXpP?=
 =?utf-8?B?Rm80UEZudzB4NzBZWmdOTWJLT0NhNUdhK3ZFZWQ3Y3NSaUJqME9aZThpQzR3?=
 =?utf-8?B?cEZ5VndObjJRODhkdW1Dek82NTFVdVFiUkVkeVRGRVpSWU1vUERCZmd1Y21X?=
 =?utf-8?B?K1d6WFBtQWNpeGVpZ2xYNlp6VGtjd3pXZFh4REFXMFJzM1h2RHY2RnNrQTFs?=
 =?utf-8?B?ck9GMGVvcFdCRzI2STFMbnJlNlVjclZtdGk0cWswUi85V1lsa3JxREFta3hz?=
 =?utf-8?B?SjJhai9jU2J0WU8wR3FFQkdCYWhDZDFtSDZTSEZ2LzcxOHlDdXI0TlV0REhL?=
 =?utf-8?B?aCt6QVlIa25WZHB2RGRyakNBOEl6azRPbmRucXZNK01yRlRFUDFJTWpjSitn?=
 =?utf-8?B?VzNIaTJwM3Y2QzFsNG1hWm9RSVgxV1Zvd09KbGpqZVFFakg1RHo5THVMTGZZ?=
 =?utf-8?B?VkZBYTlISFY3NVQ3UG93bFVIeENuZ3duY1ZhZ1pKNCs0VDhhblhjMllZMFF4?=
 =?utf-8?B?SEcxeUQxRjlpRUJxNy9CaGZkRENVWktvNFA1emlXaFJyL0tWNWlvWURUYkhn?=
 =?utf-8?B?UGJHNmRlc1VpWmNDbGlOb1VMNzRQakZPZUdHQnRUZmc0Ym83YnVDc1FwZGFh?=
 =?utf-8?B?WSs4OGQ4WnUwclA5UjZPY0Q2cml0WG9QaHpmT1pkSGVwR2JrN1NCdHF6UXdj?=
 =?utf-8?B?NkNDVWxhRmRoQkcxbGM3NnlCS09YQkVqSlNQL1NjUjU3N2ZWZHQ2YzlsaStw?=
 =?utf-8?B?VlF1MzhmQldyRGIwa3oxVDlDeVdCdmZNNDhKQUUxaGN0NnNGTm9DSkFLdk5X?=
 =?utf-8?B?SG5xSjFGcEo0YnA4elp2Y3ZrR21tVnBaa3FlK2VmYkh6Vlo3ZzVXNnh0aW8v?=
 =?utf-8?B?dDIvbDVVNGJEQjlJdVFhRktNcFVHQVZvczhROGdlckRaQndLWkVXaWYySnpP?=
 =?utf-8?B?b3IzZy85VGljZnRrdWJWbGRrVGNkdzFMa3gvcmkycC9Ja2k2VktMaWFkeDha?=
 =?utf-8?B?ZWpoUlRCV2Q1VmZMNUpDMFpNSEdNU0lLcU5mQ1p5d3hOMGVMNTJuSFZwUkhw?=
 =?utf-8?B?ZlQrb0ZSMkp0NUtlUGtyMEtSYURnTkN2SEEzVXZsMG5PQjIxa2ZKV0pHYmJ1?=
 =?utf-8?B?MTlDUFFUUXNjTmdUL2JneFA2N2t5bnZVVnZmWTdadnhIQUVmcXJoQnEwUWVB?=
 =?utf-8?B?SlJGMC9uUmwrYzUyTkxiS01zVGRFdDI1RnV1VXVTVll2d2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1lHTnZXRDMxUU4zclBwRWwzREJoWjdNQTJRdGRkdFZoNXJKVll1QUZJOGhn?=
 =?utf-8?B?MEQ3MXVHK1M2RENlNEFZZUZMQkFJaUpoMUQwODlNUUc2NGpQQkY5ZkdBYjN2?=
 =?utf-8?B?ZzJvU0hrL0xIN1VVRUJWbVE5TkY3UnpvS3BYRGRhcktESEZKcHl3a1R1RGZP?=
 =?utf-8?B?QXU1S2pxSGZteGpCcjQrcVRrRWlRY1RQeE1rQ2tmelE4MnA0UWlqazE1RFkz?=
 =?utf-8?B?NmRiMFVuYlVBb2pDQlhQekNCcnJYSmlscHM0TWVoMUdDMnVtRnlpV0xXQzZu?=
 =?utf-8?B?WWNtZmJ1UW1yOE9PWmFpdjB1T3BWNHNacWJ0bWYrQ0pBQngweTRIaUdHcWZa?=
 =?utf-8?B?SlZyVVBWRjdKZVlKTTZFMnJNc2NmSVhGMDlNTERCWDB0c3ZzbUdhYjZ1akJ6?=
 =?utf-8?B?K1E0U0o2d2VhTjBGK1JZVU5SdTFUSFMzRUNZNHY4bEpVZmRPdUdvUG9iZnZq?=
 =?utf-8?B?OE9mK3ZpVFduLzFoZ3llWkpBU0ZKMFMyR1RNNk1aWmczaXU1UE4vdmtqN3lo?=
 =?utf-8?B?ZVF5WmxqcCt2Z3Vna0hFK2JPejJnaXBuNEdYQUpRWjEvRWNuNWlsVnZLTkp4?=
 =?utf-8?B?RVpNZUN5STgxSXAyV1dKUlZiTCs4QlJxWU1ZcExIejM1QklTcThvT1RvKzl4?=
 =?utf-8?B?NlpFWTl4U0Y1MWg0cm54Y01yM0xvN3gvZlp2c0I0VUUrMFhxaEUvOXo2Q01U?=
 =?utf-8?B?dFlqbHBvWU1TYnlhNnBZTVllOXcvRkx6RmtDWVowOEprMlZwRG1NZzF2eW9F?=
 =?utf-8?B?SG9QNzRTdjF2MHlhWG9JS0Uxcm5YYjBnd0dWais1Q0pUQmU2ck1pZ0Z5WlZN?=
 =?utf-8?B?TVArWTY0SkVpZ2M1WU9aakFMQ2VuSWN4MWhCZmtaODQ5emVqZmxZajk2ZDhN?=
 =?utf-8?B?dnFEWlJjNzVERGJjTXR0RFNOaldYSnRLcU5BTTVzaTRzSHBvYjdpZzRndjQx?=
 =?utf-8?B?SWtmTlNpZUxxVThvUG9EdmRZeU9MbndRck1iWDkxc1NxdkNMK0FqaEpSSWp0?=
 =?utf-8?B?bVZYOTRDSmFWb3IwOHpURktob2ZaeEZsZ2N5SjFFR3IrWjU2aGJXMERlS012?=
 =?utf-8?B?RlJlRmRJVzVxM0J0N2ZaVHYwc01KQnZMTHlJVDAyVExqVGRIbVVpd0pFb3Vh?=
 =?utf-8?B?QnR3aXVjeXdSVGs1ZmE4U3JkU05RVlNPVmxvS0lkVDRRUm1EalBnUlZFT1R6?=
 =?utf-8?B?RTJ2Tk9PdHd0a2VCWkE2QjRuNWNrUnNUSSt0L2lTVkEyeDZ0WUlZWlFTei9Y?=
 =?utf-8?B?dGRONzNNLzdFL1N6OFdEN2FRRlMrQXBxbnU0RUV1dkU0MTI1Yk9kRnBjcjlW?=
 =?utf-8?B?VmNBeVBla29CY2tEQU1FOVI0eldhVFZFQ3Y4NjR1U3ZDNUM1eW93NlJTN05U?=
 =?utf-8?B?TFgzSGlBY0VpOXgzTjAyS1lPOGJXZEQ2M25wRERRTkN2SGVMNVljYU9VNXpY?=
 =?utf-8?B?OHY1RDQyTzNkOVpjZm1tMXVFWmdPdCtKYzE2emluaHMweUFxUitPNTQwWkNO?=
 =?utf-8?B?RHRmMDlRYkR2bCsvSi9CT2x0VThBSC9jcXZqTE1ibS9JQVdYMXUxTFhzV0Ns?=
 =?utf-8?B?am1QZlArNEJkaEQ3R3pPNUJJSStUYzErMUZiSjdCS3JPZ21rc1VzL2tmVVhp?=
 =?utf-8?B?T1JlWDJwRDdyNFdtYlk4ZnRCY3pzQmJoL20xeGlmdmtXZmlWYkhEUXN6clRa?=
 =?utf-8?B?TitFZnhvb0xyMkRTZlU3ZDBna0ZzbHZEQWMvUGxMQXBzdHduajJJTzZEbU50?=
 =?utf-8?B?VTYzVkxYQTV0ODVIVWR0YU8yWnpPSXBhdFhDbHYzVmlPR1U5ZjZGdjE1dVlk?=
 =?utf-8?B?dXFPZHg5a2lNZHlpWlAxMEtGNkxwYmN6WUNuOS9mWk9uWWJYb1RNNVFudlZ6?=
 =?utf-8?B?WnM0K2VQYUJubmN4bDFFRWJIcXBldnI2a0VjUXVvVkZ2NDF1WkhDSE52TnpY?=
 =?utf-8?B?WlRVSzRPTnVxL3lpeEdrZ1NmUURlRS9lU0lxN1FyYW9YQmpwV0lyREliRHhS?=
 =?utf-8?B?TGV1R2EwZktQWUQyWnROdGo2OGI5cWFCcVRUWGlDSVgvcHhOVmIvZldFNVhy?=
 =?utf-8?B?enJhYUFRbmR0QlJqK1B5c3UwSWZOdHJkbmZJRWQ2THBFU21sTG81Z3pzbjdL?=
 =?utf-8?Q?TIvxADUIf8CJOqTqstHxz1tqF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df93d16-533a-4034-0f32-08dcc1fd154d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 16:19:50.9095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwN/8adcRtHGkV0M58Zd//7LiLrXLyzC2UpS6uH9sK72l0aCAfetjs4Wz8jU2LDu0qZM2kUGMxXZWPPX6YPxSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7817

Add 2 software manage quirk properites (xhci-missing-cas-quirk and
xhci-skip-phy-init-quirk) for xhci host.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- use {0}
---
 drivers/usb/dwc3/dwc3-imx8mp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index 392fa1232788c..bd6953246f42e 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -144,6 +144,17 @@ static irqreturn_t dwc3_imx8mp_interrupt(int irq, void *_dwc3_imx)
 	return IRQ_HANDLED;
 }
 
+static int dwc3_imx8mp_set_software_node(struct device *dev)
+{
+	struct property_entry props[3] = { 0 };
+	int prop_idx = 0;
+
+	props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-missing-cas-quirk");
+	props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-skip-phy-init-quirk");
+
+	return device_create_managed_software_node(dev, props, NULL);
+}
+
 static int dwc3_imx8mp_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
@@ -226,6 +237,13 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 		goto disable_rpm;
 	}
 
+	err = dwc3_imx8mp_set_software_node(dev);
+	if (err) {
+		err = -ENODEV;
+		dev_err(dev, "failed to create software node\n");
+		goto disable_rpm;
+	}
+
 	err = of_platform_populate(node, NULL, NULL, dev);
 	if (err) {
 		dev_err(&pdev->dev, "failed to create dwc3 core\n");

-- 
2.34.1



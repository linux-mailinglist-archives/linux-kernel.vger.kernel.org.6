Return-Path: <linux-kernel+bounces-434994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390729E6E30
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF999280A73
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163201FDE0C;
	Fri,  6 Dec 2024 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jNQYcUc5"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2057.outbound.protection.outlook.com [40.107.249.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF0D1FC0F6;
	Fri,  6 Dec 2024 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488290; cv=fail; b=ZnEHkoFrYZU+rKz6uhRZY5Z3hd3351v2vtciL5e1F46ONn2CF3xYKSICL/TY9Ygo5y1yBNEVw14KC5Ry0FEkmXAqCuW10t/7GGjvw3dQoj3IHltHa+OvAizGaUKsu+6ch5l1ujZDT/ztRQdWuen1M6nZP9Vw3YM8DRm21FmZHl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488290; c=relaxed/simple;
	bh=3BH/gaJYJeTDpJFYVqlB+YqqxHvC2DQiKeUVA4Cr0v0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UtI0/ZmMWjVCSwYyZzOMVmxv+czZums4E0ANZC3p2jc1AwpD5FciaQPh302IudGL0Mp36oBkY1r+RLX8/bIAlU6KlwFz3JeHZeVFc18HAq2lRCZou71SCZLlauyepPehz1mO8jVDadSTBCT0xWw3/dQOLRsduanfMQK0T7xa0ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jNQYcUc5; arc=fail smtp.client-ip=40.107.249.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEBRPWEIK5W8F7CB/q3ukOqH4NKEePPWsOjo5FcVPzdB/wVGXwVRkeNP2Nu04wvyThayGKVJZL+quAKxtqexrPCjQxYM6+kRnzD8LStC39Z3wU5UXaMyKEB8QwtYlAwCy415mc/B1PypidZEalxhVAeuVZ/P7WVTxpFy4yv98SaScL9XqYT3teJtgharB7sCkYjScdy8EI7EuvAtaqqdO666/RLOcGQ0UEu8v0wAW/SQrx7trwv96/Z8okNG5W+KW7eiDrZqDF/9epDwy3Pfs7ktujofmsPpM6n9etRLgGgOauVji8qyEdGNwtHOOohP+Mj9jAPJPaIfYD1x1FDKKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ramg/LlFf4bZis+Y58Q4bHkqemVET9h0BhtEsVDgRb8=;
 b=ZhsSsiEPVS7933bqlb0g2iWQlRB/9R1O1j6ycABk1PWFEVXT/CNYdsrm/WqyBkW1sfUfTBxRuP9C1x0pKe0Ptdk5Rb/LWds6l3btN4ty2LjsRSbjlmh2eRBtR4/uCRfqiDuNmS25MRmFhAKx6Z/IZpLZv3iIC83mwsMGxINrOgQRyb8JcA9laX5WaGx21EoBBTMUKBG+UCQ0Wxs7Dsjw1qrqAGIY34MPu3A3xhFmlnmEEpSnwtyJU0OZyiD5wSmTMvE7gsV2mr23VeDFZEMVWAdr8HGUQFYuaWKQd20i5GYpZiQ01Z+ste1ksFAgm/wR3Wy6KY6IP+uGUV5k/rf/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ramg/LlFf4bZis+Y58Q4bHkqemVET9h0BhtEsVDgRb8=;
 b=jNQYcUc5tRc88HjjWFRW99H7WjAQtGsWZacdiEd8dTOt6NR7nbqyEb7tgFD1YpgeMZQaijcZ4j0VcB8d+xX/ml59MWIZvLkF1pCTX/nJq1bl6TT5JpOEGkPHDU9M2GLr/62RrzwcxFRLZikn4IJYc5+PhB8+XzRXyZ48rBVg7wOUwOB+K9+CU9TpIRw2eA6FEDR86cb9No9oVMw9v7NO1B1h9jWbKt1fRVYuL0oHtrmRN0IQm02cPqiYAnxS+j6JeVqqFug+UpU6HVvx90xHVGrFsoDKJWw0Pvfmj+aeMgR6vk6YBuhhSP+bvSjLkOF2m8hKlLUHBq4GsnMRlRcUUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI0PR04MB10439.eurprd04.prod.outlook.com (2603:10a6:800:238::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 12:31:23 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 12:31:23 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH] arm64: dts: s32g: add I2C support
Date: Fri,  6 Dec 2024 14:31:19 +0200
Message-ID: <20241206123119.1688712-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0152.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::21) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|VI0PR04MB10439:EE_
X-MS-Office365-Filtering-Correlation-Id: a24f01b0-1709-432f-adaa-08dd15f1e50b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGVXKzN1NSt2WEczd2VpNmZiaElOTFE3NmxsL05acjU1eCtpUmlIaGU2L0lC?=
 =?utf-8?B?eEVrMkVCRFU5bnZxVUw0cVZGeTVhWUtJeFFhR0M4MjhnVzBPYnJzWjMrWXR3?=
 =?utf-8?B?Q0V4RmpZc2J5UURieU5BdWF0dzJIdXFLZllOTnc0YVRWSXNKU3NzL1NmYk81?=
 =?utf-8?B?OE1BR215RkxOUlVLdWhNY2UvdElQVEE5SVA4cFkrRFZ4Y05YVVZ0T3l2Y09q?=
 =?utf-8?B?UnJOWlYvblFMZmY1ZlgzTHRIWkJYei9sOE9JWXV5aldBWFA5UVFac0NlK1hv?=
 =?utf-8?B?eGhJV00rWE1HVS9jQ3B4dU92djhpSjZqSlVXYmZ4alJSSFFYeVhld0hSeWMw?=
 =?utf-8?B?UUV0Q0dZUUM3V0F4d2Fvdnh2T1RibFFwU1dXTzFQdlByRzFlUVExTC9XdG9l?=
 =?utf-8?B?dmFMR0hhdFFIbzdWbE56NW5lZHBUbm96QndHUTlHdzdSOTQxaGJuRFhQZFpo?=
 =?utf-8?B?WXZPMjIxVGVsalhLY2JiR2FIV2x0d1VuM2YwNFRORGdEV1NFMG9uQTJIeVY3?=
 =?utf-8?B?UTNWU0U0YzJnTFo3eS9sQUNReDIxbWczM1d2azFJYXRtM2J1bVVxSXEyTE9R?=
 =?utf-8?B?M3oxdzJnMlJTREtuUWJhS2l4dVJMd2Vxb2dwcmtvbUJGRHd4eUZlMDMrTzBZ?=
 =?utf-8?B?OHN6WWI2UVdnc3RqWHNKKzNkWFkzVVZrS0REQmdaYktiMDFyODNuelpIMFlF?=
 =?utf-8?B?N1htdThLc2YycGZaZE9xUUo4V3A0Z1hFQ1lZdGt1SHhhQnB0Q3d3UEZVYnk1?=
 =?utf-8?B?cjhhTjZFa29UTWpIUmNxOSs5eXdnUzJzVnRJSmIwb3doSkQ1UWxhTVVOd0xI?=
 =?utf-8?B?a2pEN21HYzZyaWJSVExjKysyclhJeDFiYVV4R1VtTVJKSlY1UXZWZXducWJy?=
 =?utf-8?B?SFQ2UlZFTmpnZVdzT0NmK2xKcEZDZDRIZi9sY1NHWlRXeHMvRmNtdE5rd0Jj?=
 =?utf-8?B?eThsUDUwbDlBdjkyZnFadnphRnBRenpzYTNQWUxyWnQxbjNOem1nSVlRdjg5?=
 =?utf-8?B?YWdXN0NRZERsaVpscHZXK2xBWTVFSnVYSFZFanlUWUI4VkZ5VzZwQjFwN3J2?=
 =?utf-8?B?MUY3U2RHYzVtRFFKeVZ2RzllSXI4dE5COGY2UHJDenlDTVNQWk5xUG9Va0FR?=
 =?utf-8?B?YTV4V3VmcjFXVWhpdEpJdmdXMDNERXhrMmtTUHFlVnhUOEFIK0VyVU1DKyt4?=
 =?utf-8?B?aFpYZjVSS2x5UkJCSUpaL0E5L2dQeENQelhKZUwwS0dTTW03UU5LeUcyNzdZ?=
 =?utf-8?B?Nm1QOS9sclFIMGxLT1VvYlB3bEcwWFE3dTlQb1BJSzZwQlk4ZHRia2lySmI0?=
 =?utf-8?B?OWpEQ0x0TUZNMW1GODJhRzhwZkJYYmZZZHJMakxMYjllb1lnV1paSzdwRnJE?=
 =?utf-8?B?aFAvaE53cW1hcUczcTRVdGUzNmk0Z0d4azBxYU1wYnpUMGlBU2NmWXQ3NGJ4?=
 =?utf-8?B?ZEhZNEpSUzV3YklKMW5NMm1XdDkzUi9RL0g4U0xBTW1mdE5Sa3RMKzR4Q1hD?=
 =?utf-8?B?NWVqSDZIbGUvQ25IOGYxRXlZdHlBTXozMjFFTlhDT29oN2NISFlkWmFXcHNE?=
 =?utf-8?B?RjVoUDgyS3FQTkFydCtJcGlTU1MxQ29YbzE4bDV6WStMbWE1aVpYbnlVZWRF?=
 =?utf-8?B?emt5d2FxUXpjV283WkVYeTk1Nk9iS09VamFIVTNYSmI2VExtYVNKbFRGd2RM?=
 =?utf-8?B?MXBhUGl2VmdKbXFGZm5YT1V2SDVwS2dqYVk2NEFpbjJxSzZRN1hDanNKTFBr?=
 =?utf-8?B?VGIyK3U0QkFvSi9xY28zcXFYQStzazdGS0dYRVE2Z05OWUxiSyttOTQvSDlM?=
 =?utf-8?B?Q3MvYkRPV2gvOFBRNEtXZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXAra01qY1hMbEdkTSttMGhkLzJTbDFQMGdqckJQd3VhVC9JTlM1QmdxTjQw?=
 =?utf-8?B?ejBORlpYYVlWbCtKYnREOVUvOXc4TWZVOXNqL3dEUnZzZCs4cWg4TW15QVlx?=
 =?utf-8?B?ZC9NMW5VMnpTcm5MUlpNSXZyQW00OERzTHBIZzRXa0EwUzZIb1d2czl5QTdS?=
 =?utf-8?B?VEZjV3kwOTZTWEVDZWxyZkhJVFM1MXF5RUpVclY1RXVxemY3cFRIeVFWVlp2?=
 =?utf-8?B?S3oxYkttSmVlaUR2TXpjdzhOOUVFbFdoeG5RbVZ1NnNJemtsVzV5VVVlWG0x?=
 =?utf-8?B?Z1dwZDBBSmdYeitlNWpWcS9jKzVGV29OQ0lpUGZHRjZtRzQ4S2p5YXJNR3J1?=
 =?utf-8?B?RC9YWnRkWjRyb3ZvYWdvZFRGditlL2I2KzJTK3NKOXBReHMrYnVHMzRWc2l6?=
 =?utf-8?B?aWVTWWZweEZWZ3V2SmdiVFJDOUtlWDBXNjRyM2xmY3VYZUwwT0FxZkI3MFVD?=
 =?utf-8?B?bGVrMCtZdDFPNldlQUxxVHVWR1p4TlB5c3NTdHJMa3ZTOVczYUk0eTR4NENw?=
 =?utf-8?B?UHlHVkt4OG5Oc2Q3U2RVMzl1QnJXQUdybkR6dWl6bEtlR2luV2w3bVRRN3Vm?=
 =?utf-8?B?ZHo3Q2Z1cEFBaEFnQ1pyVXlHcnFiZ1AwdDVWL1RvVU9yZVIydU9UMlRNVTFN?=
 =?utf-8?B?Tm5JdGpCRFJpNXJNUFFOMHF0enhmK01VSWoxWEhWQXFndkhpdFRQNFI5NFBm?=
 =?utf-8?B?SEN0YytPd3NCODEvQ2xzZU5MVEJZcUVmSGN1d21OQkp3T3JhYUVtb0JXWFc4?=
 =?utf-8?B?anFrdG1ZZ3pSQisybkhuakVvazlXS3p4NnBNUFVRS2lRKzNmNndmKzFNUzNK?=
 =?utf-8?B?aXA1dTJMQmFjaVBXeGx0aXBvYzRwVTFtV1VpVE1TZ2hJb2JpYlF1OThSSDYr?=
 =?utf-8?B?cDJzM2dYbUU1RkVzZ2ttZVZIYmU4OTczcFllWUhFYXRLeU1JemZQN3RsbVgv?=
 =?utf-8?B?MzVhU3MvUS9iWlhUT2o4ZkpWc3hDUmYrRzJjZVlwL1hpTHQzNEVudyt0VmF5?=
 =?utf-8?B?a3hhRUowNnBDb1BGcmdhdGtHVDFqYXBZaWgvdGxSQ1ZBL0Urcy85Y1J6Ri90?=
 =?utf-8?B?ejBCUHBxeXRSakQyTHA4ZU9KRnlTL3g4UzN1VXU0RGtsbXZveHlvS0tKZW13?=
 =?utf-8?B?WjlFMlRvTWp3M1FNb3l5TXJxRWFZVSsxa0owd2Qyb3QyTHEvUlExSWZ3c1Z0?=
 =?utf-8?B?ZGMxK1UxMnc4QzJyZFhpYW1FanRWYlBlQmtLUVlIelhuaHBZRGZzczZ6S3Ba?=
 =?utf-8?B?dnlHSjRDY0FWWDh5LzIvTWJGRTZkRTJFckY1ZHBNZExRVXE0MVR3QWUwcTZU?=
 =?utf-8?B?Mzk4bW9MUjZ5dnVrNFRZRkNudkVGNlQ1ZjdpUEYxUk5UYlZwb0ZReDJLNzB4?=
 =?utf-8?B?Sm44NjlJU04rU011OFoyUGlDak84QWR4SVVOaWtmSnBRUE42Sk4veERhcmFZ?=
 =?utf-8?B?Zlc1VVNNZDRrcTZ3NVIrTEtIOFNZWExMWjNsYVRsMkxsby9ndFIzMkJIbnJX?=
 =?utf-8?B?RU1BcGJwdnd5c3RoNVdJbXNZVnhackNKSjFwUXZQOEtuRi8zV01JeTJrWnJW?=
 =?utf-8?B?RkdxK1FOQTdsT0w4UTU2NGNDOGVRUkRLRklCRmxtaHpFSm9iZkFTa24wOVll?=
 =?utf-8?B?YnJMSVlMK3pRaXZ0M1g2WTV2ZHY1NEZCbEhZbmNtM0gxZlo0ZThZbHNNT24v?=
 =?utf-8?B?ZFl0Q2ZRM2pIZ0w1d0JKVEtZT3JzT2xTTXhsSVpOQ3JBMjFnMEpYNEQyTkh4?=
 =?utf-8?B?bEFyRHN2bzgrMnE4WW9aRlVQQlg3bUNuT2VOSTV3bWd5RFFNeFgxSm96a0dE?=
 =?utf-8?B?blhFU1d4WEEwRVR0TEFVWlM2R1YxTjdGK2Ftd0tBdUROUmdmWFlzT3VOdEV3?=
 =?utf-8?B?WDRXa09GOTZDT0hLNnpJODkyZmVHM3JRTG9HUzJjZ3ZrSERITWRHc0FyNzRP?=
 =?utf-8?B?TjFWNktYS3NEREg0L3ZqZFQ3a2N5TDk3cnVxbjM1TlV4M3Y4aklqNFNxTlFp?=
 =?utf-8?B?RmdiL3FsMG56NUZYcC9qN1RXcmRtcFpDN1lEdUtNMmFJejhBeFo2eWkxdk02?=
 =?utf-8?B?bkYyUUNXMy94SzhVMEU5QWdlaEVHRmh5SFozaEd5WGpEWUpjSk9JOXNnL2ho?=
 =?utf-8?B?YXh0SElwMHByUFRhOEJkOCt3ZWRSRS91TFJrTllyS3pWTmFsNHpSMWpRZ24x?=
 =?utf-8?B?MEE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24f01b0-1709-432f-adaa-08dd15f1e50b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 12:31:23.1931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wpaAwdFb4MfJCsSHv2xNUcg678iq7eSJJp/a0/3NyEQAc4tUJGQtrWdCdbXM+TSwGJRUaJziWrHbb/H9wexiF4u/mnxmp3QRCYOYFW1/i8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10439

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add the I2C Devicetree nodes and pinmux for S32G2 and S32G3 SoCs.

With respect to S32G2/S32G3 SoC based boards, there are multiple RDB
(rdb2 vs rdb3) and EVB (for G2 vs for G3) board revisions. These versions
are quite similar. The common part for the EVB revisions will be
centralized in 's32gxxa-evb.dtsi' file, while the RDB commonalities will
be placed in 's32gxxa-rdb.dtsi' file.

This refactor will also serve for other modules in the future, such as
FlexCAN, DSPI.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi      |  45 ++++++
 .../arm64/boot/dts/freescale/s32g274a-evb.dts |   1 +
 .../boot/dts/freescale/s32g274a-rdb2.dts      |   1 +
 arch/arm64/boot/dts/freescale/s32g3.dtsi      |  50 ++++++
 .../boot/dts/freescale/s32g399a-rdb3.dts      |  12 ++
 .../boot/dts/freescale/s32gxxxa-evb.dtsi      | 150 ++++++++++++++++++
 .../boot/dts/freescale/s32gxxxa-rdb.dtsi      | 124 +++++++++++++++
 7 files changed, 383 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index 7be430b78c83..0e6c847ab0c3 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -333,6 +333,33 @@ uart1: serial@401cc000 {
 			status = "disabled";
 		};
 
+		i2c0: i2c@401e4000 {
+			compatible = "nxp,s32g2-i2c";
+			reg = <0x401e4000 0x1000>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 40>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		i2c1: i2c@401e8000 {
+			compatible = "nxp,s32g2-i2c";
+			reg = <0x401e8000 0x1000>;
+			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 40>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		i2c2: i2c@401ec000 {
+			compatible = "nxp,s32g2-i2c";
+			reg = <0x401ec000 0x1000>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 40>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
 		uart2: serial@402bc000 {
 			compatible = "nxp,s32g2-linflexuart",
 				     "fsl,s32v234-linflexuart";
@@ -341,6 +368,24 @@ uart2: serial@402bc000 {
 			status = "disabled";
 		};
 
+		i2c3: i2c@402d8000 {
+			compatible = "nxp,s32g2-i2c";
+			reg = <0x402d8000 0x1000>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 40>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		i2c4: i2c@402dc000 {
+			compatible = "nxp,s32g2-i2c";
+			reg = <0x402dc000 0x1000>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 40>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
 		usdhc0: mmc@402f0000 {
 			compatible = "nxp,s32g2-usdhc";
 			reg = <0x402f0000 0x1000>;
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
index b9a119eea2b7..c4a195dd67bf 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "s32g2.dtsi"
+#include "s32gxxxa-evb.dtsi"
 
 / {
 	model = "NXP S32G2 Evaluation Board (S32G-VNP-EVB)";
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
index aaa61a8ad0da..b5ba51696f43 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "s32g2.dtsi"
+#include "s32gxxxa-rdb.dtsi"
 
 / {
 	model = "NXP S32G2 Reference Design Board 2 (S32G-VNP-RDB2)";
diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index 6c572ffe37ca..666e4029e588 100644
--- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -390,6 +390,36 @@ uart1: serial@401cc000 {
 			status = "disabled";
 		};
 
+		i2c0: i2c@401e4000 {
+			compatible = "nxp,s32g3-i2c",
+				     "nxp,s32g2-i2c";
+			reg = <0x401e4000 0x1000>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 40>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		i2c1: i2c@401e8000 {
+			compatible = "nxp,s32g3-i2c",
+				     "nxp,s32g2-i2c";
+			reg = <0x401e8000 0x1000>;
+			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 40>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		i2c2: i2c@401ec000 {
+			compatible = "nxp,s32g3-i2c",
+				     "nxp,s32g2-i2c";
+			reg = <0x401ec000 0x1000>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 40>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
 		uart2: serial@402bc000 {
 			compatible = "nxp,s32g3-linflexuart",
 				     "fsl,s32v234-linflexuart";
@@ -398,6 +428,26 @@ uart2: serial@402bc000 {
 			status = "disabled";
 		};
 
+		i2c3: i2c@402d8000 {
+			compatible = "nxp,s32g3-i2c",
+				     "nxp,s32g2-i2c";
+			reg = <0x402d8000 0x1000>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 40>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		i2c4: i2c@402dc000 {
+			compatible = "nxp,s32g3-i2c",
+				     "nxp,s32g2-i2c";
+			reg = <0x402dc000 0x1000>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 40>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
 		usdhc0: mmc@402f0000 {
 			compatible = "nxp,s32g3-usdhc",
 				     "nxp,s32g2-usdhc";
diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
index 828e353455b5..eb73a5dcebe7 100644
--- a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
+++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "s32g3.dtsi"
+#include "s32gxxxa-rdb.dtsi"
 
 / {
 	model = "NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3)";
@@ -39,6 +40,17 @@ &uart1 {
 	status = "okay";
 };
 
+&i2c4 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	ina231@40 {
+		compatible = "ti,ina231";
+		reg = <0x40>;
+		shunt-resistor = <1000>;
+	};
+};
+
 &usdhc0 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc0>;
diff --git a/arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi b/arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi
new file mode 100644
index 000000000000..a44eff28073a
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright 2024 NXP
+ *
+ * Authors: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
+ *          Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
+ *          Larisa Grigore <larisa.grigore@nxp.com>
+ */
+
+&pinctrl {
+	i2c0_pins: i2c0-pins {
+		i2c0-grp0 {
+			pinmux = <0x101>, <0x111>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c0-grp1 {
+			pinmux = <0x2352>, <0x2362>;
+		};
+	};
+
+	i2c0_gpio_pins: i2c0-gpio-pins {
+		i2c0-gpio-grp0 {
+			pinmux = <0x100>, <0x110>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c0-gpio-grp1 {
+			pinmux = <0x2350>, <0x2360>;
+		};
+	};
+
+	i2c1_pins: i2c1-pins {
+		i2c1-grp0 {
+			pinmux = <0x131>, <0x141>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c1-grp1 {
+			pinmux = <0x2cd2>, <0x2ce2>;
+		};
+	};
+
+	i2c1_gpio_pins: i2c1-gpio-pins {
+		i2c1-gpio-grp0 {
+			pinmux = <0x130>, <0x140>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c1-gpio-grp1 {
+			pinmux = <0x2cd0>, <0x2ce0>;
+		};
+	};
+
+	i2c2_pins: i2c2-pins {
+		i2c2-grp0 {
+			pinmux = <0x151>, <0x161>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c2-grp1 {
+			pinmux = <0x2cf2>, <0x2d02>;
+		};
+	};
+
+	i2c2_gpio_pins: i2c2-gpio-pins {
+		i2c2-gpio-grp0 {
+			pinmux = <0x150>, <0x160>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c2-gpio-grp1 {
+			pinmux = <0x2cf0>, <0x2d00>;
+		};
+	};
+
+	i2c4_pins: i2c4-pins {
+		i2c4-grp0 {
+			pinmux = <0x211>, <0x222>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c4-grp1 {
+			pinmux = <0x2d43>, <0x2d33>;
+		};
+	};
+
+	i2c4_gpio_pins: i2c4-gpio-pins {
+		i2c4-gpio-grp0 {
+			pinmux = <0x210>, <0x220>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c4-gpio-grp1 {
+			pinmux = <0x2d40>, <0x2d30>;
+		};
+	};
+};
+
+&i2c0 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-1 = <&i2c0_gpio_pins>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-1 = <&i2c1_gpio_pins>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-1 = <&i2c2_gpio_pins>;
+	status = "okay";
+};
+
+&i2c4 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&i2c4_pins>;
+	pinctrl-1 = <&i2c4_gpio_pins>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi b/arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi
new file mode 100644
index 000000000000..d992c0c9e695
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright 2024 NXP
+ *
+ * Authors: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
+ *          Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
+ *          Larisa Grigore <larisa.grigore@nxp.com>
+ */
+
+&pinctrl {
+	i2c0_pins: i2c0-pins {
+		i2c0-grp0 {
+			pinmux = <0x1f2>, <0x201>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c0-grp1 {
+			pinmux = <0x2353>, <0x2363>;
+		};
+	};
+
+	i2c0_gpio_pins: i2c0-gpio-pins {
+		i2c0-gpio-grp0 {
+			pinmux = <0x1f0>, <0x200>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c0-gpio-grp1 {
+			pinmux = <0x2350>, <0x2360>;
+		};
+	};
+
+	i2c2_pins: i2c2-pins {
+		i2c2-grp0 {
+			pinmux = <0x151>, <0x161>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c2-grp1 {
+			pinmux = <0x2cf2>, <0x2d02>;
+		};
+	};
+
+	i2c2_gpio_pins: i2c2-gpio-pins {
+		i2c2-gpio-grp0 {
+			pinmux = <0x2cf0>, <0x2d00>;
+		};
+
+		i2c2-gpio-grp1 {
+			pinmux = <0x150>, <0x160>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+	};
+
+	i2c4_pins: i2c4-pins {
+		i2c4-grp0 {
+			pinmux = <0x211>, <0x222>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c4-grp1 {
+			pinmux = <0x2d43>, <0x2d33>;
+		};
+	};
+
+	i2c4_gpio_pins: i2c4-gpio-pins {
+		i2c4-gpio-grp0 {
+			pinmux = <0x210>, <0x220>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c4-gpio-grp1 {
+			pinmux = <0x2d40>, <0x2d30>;
+		};
+	};
+};
+
+&i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-1 = <&i2c0_gpio_pins>;
+	status = "okay";
+
+	pcal6524: gpio-expander@22 {
+		compatible = "nxp,pcal6524";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-1 = <&i2c2_gpio_pins>;
+	status = "okay";
+};
+
+&i2c4 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&i2c4_pins>;
+	pinctrl-1 = <&i2c4_gpio_pins>;
+	status = "okay";
+};
-- 
2.45.2



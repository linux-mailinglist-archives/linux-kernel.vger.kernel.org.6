Return-Path: <linux-kernel+bounces-241146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7747392778B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9511B2307D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2246B1AEFED;
	Thu,  4 Jul 2024 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Dvzm3WwP"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2070.outbound.protection.outlook.com [40.107.105.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B791AEFD8;
	Thu,  4 Jul 2024 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101426; cv=fail; b=rzDvS7zLOZYE0M2I3qMSN5kmK5RubaJPX5HcqkdzIakUwqv7IvjUCNt4HkfnFHFsLkoswuG22HOmkD4Um9Z8Z9ANPysQiepmVkzLCAMWVOnlTy2zFBKf7oyOrEESsVkPVtTR/yWlswtlMGJ9R3/rYWdL+VC4TDgnR9NaoaIHoFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101426; c=relaxed/simple;
	bh=bDlVcz7E8wOZmco5B1wqXFgok+23f5lq1HnCoNdxKrg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Y8ruCrjCNNj8KSW/rklNzKB5+yIvgnzALIPuX9bAOzV9tFnXtSrh+qtoOWrPjafpGBpgwxDFYMMF4gUmyK3Hfzgd5JESO3Lg6xsgVhj9Mv9u0amxeMtXHcmV8VRYSKcdT2vvowKjHYm41kCgmrT3s0WPCiajEtoi3RAUe+YwkU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Dvzm3WwP; arc=fail smtp.client-ip=40.107.105.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgzWP6mZzYv23b71JFiaEoeOyF/bo3LD3ZJ3xAYIGqtbLhAMV7b3SXMo5R28IBEaI1ctShtqumdWp2suVM0ZeYMeeRXMurRV1QyyAJxpF6N8yeCJMYQvxxBUNuDpZA5zUZ28DX27+gms6ehZ/xDbeamUHDIzSUK6a+eMAsLQMf9HjPgUQfGHCkXtPJrtrMHdzeRXcn9HzyfoBRJWdTDASdCbRJZiHk+ZJzslHe/GyuAHUTjgrG1Uo9IZc+xtHtS8eeq5BFF5ekD07k9Q86GFXnvxXRWUc1+sq2nIfyZReh4SmKhjnCyjXEhQJIMC2D6XjhWjH0ySScrE3svsMmzxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAD+CngXYS9A7r/WAFUBhILOkdPjBwT3mrBOGhMHxvo=;
 b=mcJKMRLIWVmjnFBMDngBMhVocvqSsvMfydLbMuJK/H2ohUnGE7sLoCeVJgYXjwpcXC1pLHzUrVEBvQpPbClN96VE+m0LmaB0Fv0Z4Nd7oHnSTJk9tgPlQZIYYKDBZo8Ipm12AP/DUwgLt11DKRDJuN6a0R5c4evs43MOhlbNf08X+rBPGSzB+YC7YTiHyLo6Nui1lffYWYeGbUlzVoKHSqdUQ4WJdGEAIY/Y/sOdfiGbsVXfp+eVqmYJ7DuQ79JK8iDoUdS4BTq311XTDWw2+8nAQRM/i0dW7T+Y8Ht3gg2XX1vF3IvwsuYV/cH/aFh+1vgds+0JWUsbbraZ9oGnkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAD+CngXYS9A7r/WAFUBhILOkdPjBwT3mrBOGhMHxvo=;
 b=Dvzm3WwPVS0hj5llhv5Dg6DmoUUtEEQ4WJdPUopVChkxIplPybW4wP241s7D/V2kF2o6PaTQFsilzJntqzvrXKcbQzGdxIUFYKzb21Ufy5SX+x0cX47JFrKDJ7hFMUvYBPLfVssanxfCmHpLBbFZJ186lLo+tbor/hSHWiEXLjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DB9PR04MB8153.eurprd04.prod.outlook.com (2603:10a6:10:245::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 13:57:00 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 13:56:58 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v2] arm64: dts: s32g: Disable usdhc write-protect
Date: Thu,  4 Jul 2024 16:56:53 +0300
Message-ID: <20240704135653.2969532-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0106.eurprd03.prod.outlook.com
 (2603:10a6:208:69::47) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DB9PR04MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 9951a4e7-c031-4030-7a56-08dc9c312b26
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUcxazdlQmE3cjlVQkhuaDZqVDVVS3VCN1R1ZXBrSFlxdVlvcHhOQ0h1bnZi?=
 =?utf-8?B?UTRHcU52TjQzdnhQUkRidDNpNEZoMFIyM3p2aENoajJuYWdwVnorSE5tSHhB?=
 =?utf-8?B?WW8wYTRRU3k1V1ZCZ0o3cFhOSkRhWkxkblJiZHU1K2M2UEZncXhPTkNTdHVL?=
 =?utf-8?B?eHBzeG5EeFBpcmJhZ1ZBNWFzTzJWYWZCQnJ0R2NoM3BTWWswdmFjWEM5ZldN?=
 =?utf-8?B?ajU1ekliV3FBbjJUYzAyQitRMXpMbVRzKzhjUFNjWVFwdGVRbUw3K0hQTGRm?=
 =?utf-8?B?MWhhdGt6MWw5WmlxZ0IxaGtuemhTRzdCQ1doN1p6UnZybjhqaGFsYzhZbExt?=
 =?utf-8?B?TlF5UGdKR2RZK0ZSZ3U3UGd5VFRDRVlIaHpvcWRkS2lUdmpWeHdURjlMcW4z?=
 =?utf-8?B?ZjJsUFRMZlB0ZE9UdVpoYVRNT3E4TStWWHBmT0ZPakkxVHFWbGE3SHFqQjJv?=
 =?utf-8?B?Rjg2ZzFSZUdrOTg1d3lzUDJidVF5UGcrM0xWbm9rU1N5b04yQndySndxS2Zy?=
 =?utf-8?B?Q0F4YWMwTXF6WitPRWFVU010b2U1MDU3c0VobmhkRU1LbjJXa04wYXNMamtj?=
 =?utf-8?B?dHdzR1ZMRnNmZXNTY3k0NUt3eHd5NFg1VEdZQ1ZIZ3ZHSzkycEFoMngzQndO?=
 =?utf-8?B?NkdEWk1VRW0vVGdVZFRkdk5PMVRnVWM4TGt0aWFKZ2IwQ1NDY1Q4U00wTHEw?=
 =?utf-8?B?ZGtleWFPa1pGOEJjZHplR013ckxaWnRaaWtYZlRGdUJtd0YzQ2c3TmpzZjYy?=
 =?utf-8?B?WlA1bFZaYUpIQW94Vkh1eEZwdzJVbnFpZEFsaTZVVUVoMlVQelZ1UXpkQ1RU?=
 =?utf-8?B?TkdrMEV0Ym9ZcjRheElzdTVSOU1UTWxnMVF6cytkZFB4SC9kVWo2UkNpWENG?=
 =?utf-8?B?TnBadVMyUjhyN0dOZnVJNXpuRjBPYTF4WXAva2UvUU1EM2NNNk5ZblNhZVJ5?=
 =?utf-8?B?aGFqZFZpK2dSQkF6VXovek9MUWx6cG1pbjByYlJmUUhGWEc4SVQ4NXJOQjN2?=
 =?utf-8?B?SkpyYTY5dXp2YWpBTlZxbXJTMXk4czFseUw1c1VWdzRWcERMbU9IR2xOMnJI?=
 =?utf-8?B?T0huMGlRbW9LakozcHNkcmY5RGlDM2tBdklpc1c1Y3VBTFhIc2ZuWjhQckIy?=
 =?utf-8?B?MXFaS1NwUkErK2VHVEswNnBseGhJWWlHcU0vTm1BQ243QUtkZDFXZE0wckFV?=
 =?utf-8?B?WVNrTTVETzJGMldSYTJWdlV0UjU1NUNLbUdjT0ZXZUJJL0JEQTZ1b2dJZFdm?=
 =?utf-8?B?MGdWRUg2OEl4RmdEb29aekxKakx2MUpWc3RQa2RLdEhnSnR6dFdsbWxPMFdU?=
 =?utf-8?B?NVdUM3Z2blAydDlyOEh3SGFUaDBPMGJBeHNpY1BGVFVOM1pGVmRCMWQxV3Jk?=
 =?utf-8?B?bTl6OENoRU1aOWVkZlV4ZjI4MXRYbW03bktnMnhseGNKWlNRY2RvbTdaN0No?=
 =?utf-8?B?RmJOdkhaMGNTYnZxMmIrWThldGJRa3BtUzZrTGhCSHJKOVRmSHp6Umc2R29H?=
 =?utf-8?B?bStWbWN1bG03aGxXTDFwcVU4Yjdsb2RHeHBJVWZBZ3lEYnYwY2tEYmlrY0R4?=
 =?utf-8?B?Q3hSRE1tZTJ4QmcyWkhLYjdpUUpEcnpjZitHQ1JEb1pvMzgzVkRZdDhuUFY5?=
 =?utf-8?B?MkJNSjlOM1E5RUFYL2JvVS9WcUpLSHdDWjdCZjdKZDV0a0VzZ1crTndlUGts?=
 =?utf-8?B?M2t2RjZCNWUrc2Z2YXNhc2s5QUFkMWRmV3Ava3lpeHJSa2NMSzJ0TmY3NHcz?=
 =?utf-8?B?cDZyREJTbVdUVFZNTk5CRTRuM0lHdDNWSjA3N1hFUEorbDA4QkEzaFpDYllB?=
 =?utf-8?B?Y0NwVHlKMlVDRTdxNWo5eDFIOXpWRDBMOVkxTHptS0g5NlNKMDZOTERhOWRN?=
 =?utf-8?Q?CC1ueOFUA2CAr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0w4dHZMaE5rVzJWaFRJYkgwQmkzK0pHMktaaGhFdXNZZ3lRNGVLTE9Kd2ky?=
 =?utf-8?B?ZWtQQXd0QlZlaGprS0MwMlRPV0RvdWJmQWI4YUlPUDYwSlhzdVpBNzdQSUtQ?=
 =?utf-8?B?M2t6V0w2bW5iV0luaTNROUt3RVpRUE9UdVkrT0pPZ2hYbGd1TkFkbVhrRmY0?=
 =?utf-8?B?bmhxYlY1L0RaRDRaWUJiZXFkOENFellJSVBQbjVoSU1iNWJkeHRkMFl1M0Nz?=
 =?utf-8?B?bVBIK29WZ0phQ2ZLVUE2MnhMNllQa2RJYncxN1ZrVm96Rno5ZS9YNzdzaloz?=
 =?utf-8?B?bnZ4NzYrOHMwYkNiMFJFd25helZNRFI1bHAyVlAzbnArdlErR1RXTmZDSU9j?=
 =?utf-8?B?b01zQXBGa1RjeVEyenlqaGhjd2hWSllCekM1K2plUHMxeHRYUVVJcUxPdjNh?=
 =?utf-8?B?K1YwRVQ2Q2FFeDk4Q2JrQW1lUjk4RmhjK2xlT2NRNEkvK2FJK0QrQXl4WkRo?=
 =?utf-8?B?Z0tMcmZwOTBkbVlEejFjVFJEd0JuVTcrcHJUNVFBQTRXajIzZXBGV01KZTM0?=
 =?utf-8?B?K1FITTNicitYOFloaFY4SzlVcDV6eHR4TTJzdzJIYVhIcWt0RGdRS0tnUmlx?=
 =?utf-8?B?Q01JTmE3RnlIMWlkeldhYlVHc0w3QklLZW94U3c0NTZFTUNjR2VFckhmYUJO?=
 =?utf-8?B?YzZTMUZ0MzNPUlBIYWpId05JV0h3dEN2cVZDQVJZb0pmZjMvSzNpcjNIZlZM?=
 =?utf-8?B?WEZVUk5wemtNMDJUaVJUSTZpcGlDS1FLdlExczlMZTkrT0dieEdnL2RxRjBy?=
 =?utf-8?B?NmlaRGwrSE9HQU91UnNndzd1SVNNc0FtemMxWkNZT3loTHpmWGlHNXgrczJR?=
 =?utf-8?B?Z0lmZkVSRktZQ1UxakcwYTJ1VWJSanFIT3ppUjAyWGZGRDlVQ2I4dDhaVFpW?=
 =?utf-8?B?dVFPNlc2MXU1YlZpUmhmWWRVWXVYYk1SSUJmUTQ1aG9BdWx0VDA0KzR6cGJE?=
 =?utf-8?B?T2VmY2N4djNkZ1V6T0NhTVNESDVkMHRIc3ZSYW9CUVFBM01TNzRQL3l5ckUx?=
 =?utf-8?B?VFdETml2YlFqendnYzR0ZDJkS1BzN1dGd0puU2syUkcraWdDOEFHdDRqVWNq?=
 =?utf-8?B?REc1YjFKbWlCa25ZT2NnSXFsbXRFT0F4N0xvT3d4QmlUdFZsYllvQy9Hanll?=
 =?utf-8?B?VVRoWVlicVoydkxOb2F1QjVYaE12cFA3MmdwMmtkaVNIUGU4a2RXVDlrTmpX?=
 =?utf-8?B?cHNWUUFQdkt2ZEhYVmJuc3Y2dSt6ajVwbjVHd3ZxWUt2eDBlTUxXRXZYZFRt?=
 =?utf-8?B?S0VPa0tLZDBMZWduMUtBWTJNL2lDSk4rTVg1cDcxS2VibUg2RWZYeVVyeXZw?=
 =?utf-8?B?aGxGUVlCbkFiYlRTM2loLy9BMUliNUdLVmIwKzViektYVmFjZ2MydkNNdmZm?=
 =?utf-8?B?a0p5QVNianpRN0x5UlJTeHljdStwRTRHOGlDeEE4WW9WTGRjN2pBbE9NZHUx?=
 =?utf-8?B?YXZQRGJySlRvYUlYM1hVMTZIa2UwS2RiVVA4S29VcHQxclhkYm9OUWpHdTY5?=
 =?utf-8?B?YUgxTCtWUDl5NHBCSHZKQkI4dHVMc3FHdHo5RDFSMURpU0ZDMXhyQ2VySHFL?=
 =?utf-8?B?RTdUczVUNHB3b09WS2pSMnNONEFEN1B2T0ptL3hsNC9iaE44NFZDRS9OdjZL?=
 =?utf-8?B?cnllZkpaMkR2SjFGWkFoSld2YTRHczJiNVhzVHZFRytoQWRPTHUydzdPZHBM?=
 =?utf-8?B?RUNpNm96ZnNvaEp4WEk3VTJNS000ZzNqeUVtc21RNEp6cHRGWmRPaUJ3OUht?=
 =?utf-8?B?RmZMbVVOVnZ1NlBjdStyUS9hK3JnU1RmdzFoUjBhZ2VhQU5pYmJJYkpmckh6?=
 =?utf-8?B?OGRSVkZEajN1ald1TmlSWi91NGZvc1VXc0ZNM0hXd0ttbkpXREl3VGREd1ZU?=
 =?utf-8?B?VVY3c2ptQktHaXhCK2ZxSGtXS0pmQlFxSFUyTTZ1ZmRIa2NQYzdELzQzajR4?=
 =?utf-8?B?VlArSW1KWUdtYTJrdTNuWEdpd3NWNThtekY1NWpHRCs3NVcxNktWNk0zTXRu?=
 =?utf-8?B?R3dtdHNJd29pZm83N3NIdmhjaEFVZy9ZZFRjKzBIbUdnYkhUSVA1MFhKSlVH?=
 =?utf-8?B?UnAzTm9VTGdJbWZiZGtNOXN5Z0IzYzgrKzRzRlQ3WlowM243SSt2aWl5MlQv?=
 =?utf-8?B?T0lJR3BGcnZvSENjRDZZYkVqTERPdTJ4bmI1bEE5SmtEQUxkNmVETnQyRGFY?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9951a4e7-c031-4030-7a56-08dc9c312b26
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 13:56:57.5559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6w4nwuLIq/XwjgQjyA5DoLF6Z+L4IoTN2DvjGwaIRcSJ97s3oS+9D7xyj1kNFLgGeZgStC8twmqPPxt1YqVvLOXPw+cCsXDvt42Xz2MrfMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8153

NXP S32G2/S32G3 SoC based platforms do not
use a pin for SD-Card write protection used by
the uSDHC controller.

Hence, adding 'disable-wp' usdhc device-tree property in order to fix
observed warnings on SD boot as the following:
"host does not support reading read-only switch, assuming write-enable"

Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32g274a-evb.dts  | 1 +
 arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts | 1 +
 arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
index 00070c949e2a..dbe498798bd9 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
@@ -34,5 +34,6 @@ &uart0 {
 };
 
 &usdhc0 {
+	disable-wp;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
index b3fc12899cae..ab1e5caaeae7 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
@@ -40,5 +40,6 @@ &uart1 {
 };
 
 &usdhc0 {
+	disable-wp;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
index 9d674819876e..176e5af191c8 100644
--- a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
+++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
- * Copyright 2021-2023 NXP
+ * Copyright 2021-2024 NXP
  *
  * NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3)
  */
@@ -41,5 +41,6 @@ &uart1 {
 
 &usdhc0 {
 	bus-width = <8>;
+	disable-wp;
 	status = "okay";
 };
-- 
2.45.2



Return-Path: <linux-kernel+bounces-319210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ADF96F957
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23FE284DA7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F841D4173;
	Fri,  6 Sep 2024 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ctYyrnru"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013045.outbound.protection.outlook.com [52.101.67.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C4E1CFEA7;
	Fri,  6 Sep 2024 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640256; cv=fail; b=d7WMweL/jR+HTL653Zxe5vMG8CCOTM7uiYlNfS3XzKBqwzKRDvokgXnDZNeUDJ18ESA7XuJfqyKIn2TdJ9GDtf0yKmBtaBDaYyTs8IpZEoBlzf6uRPwPFihIZdsbN+Vq92CnkerXid2A7G878AsoIFTOzzpPCP0Mgll65jJpLO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640256; c=relaxed/simple;
	bh=1y6wKuY3lLivGgUCZ+enzjVmHg1X5T9f98D9O9FkOCY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=g/6RMgkfutZQleWFHbZpHntkmaSIjmjzqfwhuTLJDy2Xh1WaoNJabN7EAVq1HP5imYAElMxLzWO2AmdCZJVkK7UbOI3UV63Uvr/WGAvZ8Vhvfk3Ay//WDXZtX80Vie/ZBSu0m9zLk6yjljg60hSJCr0TPbb3XzrLT+G06m+Nvro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ctYyrnru; arc=fail smtp.client-ip=52.101.67.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwwBZ/jV5/9GhAy5ZUF1W0cdh+Q5NgsX7jYI4SIOh+s2GC0ca3UxAiA5v3RkyLcNJNjukU/3NeJ5Jcud9vuDQ4jsZA53iOVqOs6G1gmU+maL+hh2x2rYAOyRPlIjzMaKURJkebgUxoCiad8ev6Jcsg1URUbr5+HEdTXUtZKPV5awmpuIl1qUne2zsJBEk4WbPyKNGFvdSRJfXaXtEEsOgxog0NHX9+rkQwPyZRu5mkwmxw30dMDK/kulleOifrt6un4M00xDadBmxifFMiXzl4lgFzrHfQt23VwkZ9k/D218DdmLQgPhoUbgRGrb8IrFhObLYA+4AEShT1xmPOXoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3PyQ3OqzY1b7DWAOLQk2VptSxdMIPCGeMHz4/TfjGU=;
 b=FFNEcLsDVh+YjlxtawlJ7nxA3wuZUj3KcnXk/uFQ3L4hwASIGkfn7DqF7glH01993/NCarRc0ixLX2Rzb6cvnzxXMbmZPGc+eLJP0SfdOqB7ebIHZnCUU7TI+gj1VbBGSdqO3cOoDY9GsrUrh8RQ5MCXUdhazl/ytFcx1E50ddcz4I0lVHvcH8rOTXVwSPETYn6RRmofe21vbFdKnygwFlzDBrfKsXhFu4lsp1K5dKJmYsstkKIRpcMrcm+ads8aXSqnJZoBZtQ1nulY1E6Pd2MNGE54yCuk3W7Orze/0WkagcDjHpLJZepqMO2S0DZdtiUEoBLFNZUKuoZRbmn70A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3PyQ3OqzY1b7DWAOLQk2VptSxdMIPCGeMHz4/TfjGU=;
 b=ctYyrnruX3egUprKvv2wieDvsM2B2ixzV72UxzOeqUn/ESp9a+5alo51sLUH0ozIphQD5hXYZBEK0e6/pmTJfAiRJbqIhg94/sQ0HW81lEoIvJMoScfDbaKOk52O0KZNRWvpTxrhcoWlmUdXYfpD9XcL0NZVWXDq6IWISkMR1191n9XHJM7p24lY92VUjsah0UEe2WQUjygqLVVlr+V7QaxTeGicHs7YD7abUZoaqgTjLZfeTJtRNrSog71TcbSDlcQvcZcwdMX857WO+Pskr0gWkQhpc82WxSJ5m2PQPkcmYae7AE0fC5wYUPpuBHqqnww3SgjVxFWADkDCb8L4lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8405.eurprd04.prod.outlook.com (2603:10a6:102:1c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 16:30:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 16:30:50 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 0/3] usb: imx8mp: collect some improvement
Date: Fri, 06 Sep 2024 12:30:36 -0400
Message-Id: <20240906-dwc-mp-v5-0-ea8ec6774e7b@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACwu22YC/1XNTQ6CMBCG4auYrq1ppx2wrryHcVGHQbrgJ2Aqh
 nB3i4mgy2/S5+0kBu4DD+K0m0TPMQyhbdLA/U5Q5Zs7y1CkLUCBVbnWsniSrDtZaMwsM2F+0yI
 97nouw/gJXa5pV2F4tP3r0416uX4T8E1ELZUEh4xk2TC5czN2B2prsQQibOgI678RFuTB3TKPB
 KX9R2ZDTtkVmYSMds7mucmY1D+yvwhXZBPyXHj2VCrEbEPzPL8BaoN6czkBAAA=
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, jun.li@nxp.com, 
 Frank Li <Frank.Li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725640246; l=1672;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1y6wKuY3lLivGgUCZ+enzjVmHg1X5T9f98D9O9FkOCY=;
 b=OG9lyzt7B3drnyGvTaN6R9GJRFwCvk8INdFskUsCTexqIXZIbyvqidLL2lMAP+3trmCsAf16S
 H2YnvAssaEhB6apDwZJ5uUJzKtHv6BPZNYTluD7WkdUL/Wrx2MB0vUg
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:a03:255::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a88bdf-69aa-4c77-9515-08dcce9144d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WndzSnFNYWJiUjZWMkNBVDBCL1ZWK1FjYXZwM3RaaEN1K0MvNjhIbzdUYllx?=
 =?utf-8?B?ZGhqbDExaFQ2cXZJckpGUmlRdmxjOExKMmU3MW9NdUZPVVpMbEVCTVBlOTZL?=
 =?utf-8?B?cFZlWW4vZTcxYkVBSlQzT3RLcTJmVS9FcDJHZGszK2Y5NXV5YjdUY2p0NTNZ?=
 =?utf-8?B?cW8rU2dXNURJelBxZURla2tLcnQwWHhNZVJ0SDhFUTFCZVZJb3RRWkZwRkFZ?=
 =?utf-8?B?YmI0TmY5eVJmUVg5akVKL0hVSDhJUnNjWEtNS05DbUlOQlZnS0lIQmE1dlJN?=
 =?utf-8?B?WjlqM3h2MkpxVjBKWk5ZTXA4K25FUEw3dFRyVzBGcFo5TWtNWjhPNnZmOWhz?=
 =?utf-8?B?WUY5c2lsK0IyQXlzNVFIRElFYy9LRVpnMTBHUzlHR2h5K01vdnovMlQwVzFl?=
 =?utf-8?B?R3l0bStQSWtBVUg2Nnk2L0Y4ZHN4TW82NUVITzhya0pNWG5pY09KR09JeVNZ?=
 =?utf-8?B?VTM3N2F6N1BjSXBhTWw5cVljMUpuTjR2VjhGa1YreGowdHNoWXVpbG5EVEZk?=
 =?utf-8?B?Vk01aktUV1FmRmpQVWcrbWlsWEJHWEJXNnhBNnFRWitKdXJXWVYyRjkwR3BF?=
 =?utf-8?B?SlpwZTdISERwa2hBZkJtREJuTGxhcWJCb2J3L254Y0R4ci9nVjduaC9yNnR4?=
 =?utf-8?B?M2FBOVZaN1d0MkZLcGs3NnBDaWtDYURQY08vZDhxRzhZK3U2TGJWd1E0Z29O?=
 =?utf-8?B?aFVXSXRVN25vV0FmUkxSZVg3RmlFVHJlREtSN3lHRnIwZ0hWTVBvYVpqRkpJ?=
 =?utf-8?B?Z24wOW5vMHc5S1ozc0kvMW9KREV3VWo1RHFQMGJuMnZXK3UxV2RJek9iaXJv?=
 =?utf-8?B?cFdteFQ3QUNxaWJOckpLZnArUTBNT3lIQml3TXhKeHBlY3REME9CdjdyaS9l?=
 =?utf-8?B?azVuU1pEUDdHVHFrSXhMZFJCV1Z0dldiZElMQ0hjZzQ2bmIxVnkvN1YyS3NB?=
 =?utf-8?B?Y0l1b3J0VXdXMHZkTzNoZXpaVVpOR1lValpBbWRqY2h0emZJc2FCL0tZb2Zz?=
 =?utf-8?B?U1BzL0Nmdk05RnFrQTFOMVNvMFppWTFSZjBPOG95R1RlYXhsbEhKMWtreUZh?=
 =?utf-8?B?WWMvNm9nZDRZSXQ1ZDl2Rjg5VTM5VXBHb1pDVWVrZlBUZ2VIU3AxK1lON3B1?=
 =?utf-8?B?YkRnU2RmM21pSXUweU9oRTh4VXpYcVVWd3hqRE5LMUEzSGZyUFVqNFlqbGVI?=
 =?utf-8?B?dm93bGt6cXY3VkdmZW9OMGk3b0hram8wNVM0Rjlub2xFWEJ5T1NmbVZFbkRa?=
 =?utf-8?B?NFVMUTB6Vnp5bXJJbEYwcGZoVXpjeTdqK1hqVkk5d1hoeXJ5YmYvRVZBSzFR?=
 =?utf-8?B?UExsOGpkbnVqbWxWOC9oNjNPcVVGb0E4NHUyR0dNUXZta3RNSENVV1BFWG1j?=
 =?utf-8?B?Vk1FMTQ0dzFUeFJCQTE5NzNSNEJ3WVpxT1RHdG9RcUpna1JmQXNmT2NITEIy?=
 =?utf-8?B?NjVxamFZajAvQzhwTWROV0pBcDEyZDFoQlBIZmZIVGRPbnBaNy9Xclp1Z2xx?=
 =?utf-8?B?SlQzQzhud0FNWi85YnhwbyszclN6TkNXTU12QXFqVmYxWWdFNlk2YXY2M3M2?=
 =?utf-8?B?dys2OCtlYzJJSWYyMmNqQVNaekE0Y0FnK2ZhNmxlcEhZR1c3cDJpMG1Pc2dt?=
 =?utf-8?B?U1c3WnJsb093Um9hRGY3U0JPQitqS1AwYUhHQlgwZ0pRTDAzU0JQc1BxaE5N?=
 =?utf-8?B?RVRRRmtqY01ZSkRQN0xIbENMeVdtL0g0ZWx2dmhaZ2ZyenNEN3U2OUpUcUlh?=
 =?utf-8?B?Mmc2VmZPWlhvM3NYSW5lVVBESlFmYmwza0ZEWnpqZGhQbDd1YmpKaE8xNHc3?=
 =?utf-8?B?TlRsUS9YTEFxSTJHaHBjcVdlUDNsSjg4MExCWGxCanNMZ0Urd3Qwd2R6MStu?=
 =?utf-8?B?cVNTYXpGblBIbksvVzhkdE5tdVJoSXJDb2tqcXZrNGd2M0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVVwTWFuUjMzWXNONlVUYSsyM1VPQ0RtTm1MaFQ4WjVVOWo5Tm1OSk5BYURy?=
 =?utf-8?B?Wk1VTVkrSWk1akhLTHErUmpLOTRsbWFTSnhxRkFSc1QyQVRtaTYxYjZGaC84?=
 =?utf-8?B?N3NLMlUrSGRSRkYzeHVlSlI5dXhHU244OVlUQzlFVWtTNUI1MWlQM1BBVUhp?=
 =?utf-8?B?bkpja0gzd1hrZXdXTGpmSkZzMTFKMzBPOTl6NXY2ejlZTkU0enRpQ1EreVZa?=
 =?utf-8?B?Y2EwMEQ1UzFXcTliNWNSVjlHZWhpa1RVbjAwV0ovc0daZHVVa25vQmU2WFRx?=
 =?utf-8?B?QUVoeFZpOGJmNHRmS0VPVzFzVDdMbWJVWXhqMUpHT3BjYUNPc0FrNkJrckNs?=
 =?utf-8?B?S0NqVEp4Y3hxNGo4RGhoOHU5UWlnU3YyK0hzV0kvS2pYS2tQYTVRODBiRFYw?=
 =?utf-8?B?RkNvTGZzcmxmZXhuY1o0cjJKQzRUQTR6VXlTVHBmSkZlOERVODhSY1RKQllY?=
 =?utf-8?B?MjUydGgyTHc5bGM5OXllUVdIY295VmU2M3l4cE9IcXpiV0JQald2Y2t0VWxn?=
 =?utf-8?B?QzFoQ3Rrc1luaVZ4WS9IampTNnB1OUxCVEsrS3NVc3owSm51UEJLbWs2a1lO?=
 =?utf-8?B?SldRdk9qZk5HcHc5YnBwdUZWVjJwS3pWbWlyYnYzWCt3OUF2V1dTSldMa0lM?=
 =?utf-8?B?NFBEV0hTekF0b0V6WGxiNHZRc3RyVXNoVVlLQzBBWWdJeU1CN0JPZ0NOdWVu?=
 =?utf-8?B?bHdManRncGpTNitHK0VzZWN0S1hJREMvQk51YnYyN2ZRYnZzbHh1VHBYTytY?=
 =?utf-8?B?ZVRQZjFmbHFxTlNHZkpyOEUvQ2ZkVW90M1F6d3YzcDAycnI2WWtKeW5YYkow?=
 =?utf-8?B?amNxUjFQb3B3ZXkwakplbWpUaWdkUlNkTDN5RlJhb3VKOWNaaktvRFFOazJp?=
 =?utf-8?B?R1MyZFgwNlBaTFNCWnpFbGpFcUxNOGpkbG5kRFJ3ZWthb1Y5ODdPWiszbmE0?=
 =?utf-8?B?ZzFZMGZvSTB4UjZlVlNneU9sTDhDUXhlNXlsUlZFTDBOUXNhZG95cm9jUmN3?=
 =?utf-8?B?TkFPNnNFSHlSd2VId3ZpeEx0ck1tU09ydFVWVyt6U0FvRjkyMlNlUytWVFY5?=
 =?utf-8?B?Zzc0REpGZGJlUElmRUY2bVZZakFlNjd4bFc2eFlhdUVIbjJBb1p5TUVHUUtS?=
 =?utf-8?B?bHRkamh0aFlibytyVTQ2QnU4bDR2T1QzK2ZFcll5T1pVaWNjMi9acVBycmpH?=
 =?utf-8?B?SmxPaE9XMXlXM1dqWVdEb2dORUNJTnJoUC9Lc3NlT2hPZkdvUS9tNUNnL2Qv?=
 =?utf-8?B?Z0dLTGl5MUp0SHlJbzlMdW5LY1Z3WThGdkVSSVdnZ0NPb3BReVoyRE9hZDEz?=
 =?utf-8?B?cWlTR2dBRXZvN3BXL3Q4T1BNQW5Pd0o3d1ZjSXpjMDZRQ3pjcm1WemdvMkc0?=
 =?utf-8?B?Q2MvbGxYSUlKZTJ1NE9QWDhPTkd6ZnplQXlleDMrbDc1bFpma0lEdm1mdWx1?=
 =?utf-8?B?ZWI1MUFYN1RHL2szNmVXSUJnV1VXYUx6K3IxV1JFY3l3bUd1bE1BZ2NPTmZX?=
 =?utf-8?B?WEROM1oyY0RsS0tjRjVPREVQSndNUVJ0clhnd2tvR1NjZkRhYVNoL3lQTlhK?=
 =?utf-8?B?L0R4TklaRGRqVENJL24zWS9JNGJNTEFsUGM2QkNGRWtFS211V0pHbVE0WE8x?=
 =?utf-8?B?S3FJUTFQR1doMnRaWERpWjUxbnB3eWdIUHRMUHV2ek5EelZWV2l2d256RGZS?=
 =?utf-8?B?YWlURE53WUFpaUkzSlRpcU9MbDh2amJMb0lRS1g0cWJlR1dQanY1cWpLTkZK?=
 =?utf-8?B?ZStOVG44NHN4UFZjWHcwZEJFRW9EREFVZW5sZHVBRnRqMURMQ1pXSWY5YkxM?=
 =?utf-8?B?ZW16djQrVjVwKzQzaG5yVjRSR3BMRjVrUFdKQ1BHMUs0bVBtQ1pQNUFlQ3Mw?=
 =?utf-8?B?K2lKSGJqZnlmVWRRQTV2dzlvSkdyQm8wQi9LV0hWZGNKNmh4RmdvMXRBZ2Zh?=
 =?utf-8?B?cCtBbHgvOTVtOEdrK2tDdHpDY2NLTnFvNW1OMkU4QjV5L093RGo4SUhJQ1dm?=
 =?utf-8?B?Nk5GSkxwRkNpb3NoTjFIWHg3MHNSaEs2R0YzdG9yRWpxcGgvVDBYNzE0S2lw?=
 =?utf-8?B?a0VIay9pVWRCTlFISkZtbHQyaFp4RVc4RUR4cklSbU52REFvcWRpaEg3Nmtr?=
 =?utf-8?Q?GmmQuODxklOWAOuGI4YR0kb50?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a88bdf-69aa-4c77-9515-08dcce9144d5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 16:30:50.1915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJKWge7FFBAdyi+JIm5NS9w61ldM5kWR8h62D+mCeTj7mATsv5y5fpw8W6VNxxxGNhTlae4nmmeDQFzLoAk1JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8405

Apply two quirk for imx8mp dwc3 host controller:
 usb: host: xhci-plat: Parse xhci-missing_cas_quirk and apply quirk
 usb: dwc3: imx8mp: add 2 software managed quirk properties for host mode

Runtime pm and wakeup:
  usb: dwc3: imx8mp: disable SS_CON and U3 wakeup for system sleep

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v5:
- Fix rebase error
- Link to v4: https://lore.kernel.org/r/20240905-dwc-mp-v4-0-aedaeacf0556@nxp.com

Changes in v4:
- Rebase to usb-test
- Link to v3: https://lore.kernel.org/r/20240904-dwc-mp-v3-0-319947736ec0@nxp.com

Changes in v3:
- see each patch
- Link to v2: https://lore.kernel.org/r/20240821-dwc-mp-v2-0-2a29b6a5c2f4@nxp.com

Changes in v2:
- Remove patch dwc3: core: add a core init flag for device mode resume
The problem can't reproduce in latest kernel. pm_runtime_get() in irq
handle return false because run time pm already disabled at
device_suspend_late(). So runtime_resume will not happen before system
resume.
- Link to v1: https://lore.kernel.org/r/20240712-dwc-mp-v1-0-295e5c4e3ec9@nxp.com

---
Frank Li (2):
      usb: host: xhci-plat: Parse xhci-missing_cas_quirk and apply quirk
      usb: dwc3: imx8mp: add 2 software managed quirk properties for host mode

Li Jun (1):
      usb: dwc3: imx8mp: disable SS_CON and U3 wakeup for system sleep

 drivers/usb/dwc3/dwc3-imx8mp.c | 33 +++++++++++++++++++++++++++------
 drivers/usb/host/xhci-plat.c   |  6 ++++++
 2 files changed, 33 insertions(+), 6 deletions(-)
---
base-commit: 9c0c11bb87b09a8b7cdc21ca1090e7b36abe9d09
change-id: 20240711-dwc-mp-d1564eec57b1

Best regards,
---
Frank Li <Frank.Li@nxp.com>



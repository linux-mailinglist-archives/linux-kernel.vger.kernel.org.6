Return-Path: <linux-kernel+bounces-201068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A2E8FB8EA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9301C219D9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D004C14900F;
	Tue,  4 Jun 2024 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="BkncP1Iy"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2090.outbound.protection.outlook.com [40.107.15.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9CD148FE0;
	Tue,  4 Jun 2024 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518519; cv=fail; b=rwZcWIUv0IpPx0yEEApq1AeZDobPNXc0Ck4oblPZy24yG6EbJCFyhxW9cfs8/flckHrj5vmG8vTphU87OMqpc6k6Ba+kz8TbbogjgMGCq/fSyi1H9x/H/wMjRmiHQR4/+0RUoW60n7fjl7yrAQgws8AIzywrTjEAEnBgfIAuPfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518519; c=relaxed/simple;
	bh=fNNwkLaLanXWRSM5i229bQrd1v9W2KrA4I1JIX+6UuU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FE50S6YGpFThOKpRf5EdyWAMwzxjcE7Oqlq9DHIRipO6JGuQLg/7ymqNkXc8gWIpexbijZenjBI9+q4C6OTqogaa1SvZKS2iMPSPFu59l7v6N4EYziFKQuQMmulXIpwWMzks23YzPhWxyL14QXxI04IaFLj/nJ2X7UgdNrhzGhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=BkncP1Iy; arc=fail smtp.client-ip=40.107.15.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTc1VF8bX2kBjrGpFnzPjDd4dnFCU8bQ73810yhpFnK4KLjcr4JOg4Ti01tvF/3IdCNkPuANLEGkVvME6a4/hXCWR+biysB477G8zStRG0dLRZz6AJXTt3f0W7D2ZxfB/7KD3oRIQ6zaTtB8rKWe1XNt4hWCnTrFa7VDpm2ggEzfINwz9rpxgmTIUldNjP+Ji3XorpKHZgaBOOEELwb0P2Co0qjHZF6j9kEWLgJb7SgqoId1fRGRlyNpgaGJQhzUrUBPQyqRywV/Z4RXUXzA4mrbl3JWQ+LCtktF+osxSpYWbGtq9ezu0l7hcalsbdLCLXtxXENjQkuGbXuC1nd1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4qnfQ+QQZN9oKjn0Q6893frkDg1cZfJxfCY7iSusMA=;
 b=RVEZpo2Dt+9uRB6m5WYSgTDpdbH/z41R88Xhh1oV9C26VodIKCq+63n31iqSbwVpryviqR+H+ozDXA7jPqpJy5FKI+Pp2LeqWentyMmKquHjbhXZIZJvQ7k9DNeNfFS1fmCgZtKky09DGGHnBmKXBiANsk597epPrzh0gAiF9WgyeBE7QVBLNSC0oOWTTNbHC7q3GDiEYWPWDCP8O9Np5H6fLIYxtpCUgiBbpw2vXyLDfU+fN9Ou27TPeg03VAp1NMsQNE9xsoWKUjqUJMRgVyv6es697E7DB1wN9dvShoQyl6wcV2s/XKPFjWlL/w6/gQnkBFymmJTCHSg6UpKXzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4qnfQ+QQZN9oKjn0Q6893frkDg1cZfJxfCY7iSusMA=;
 b=BkncP1IyCzMjSu7ayTrGPnRF1vyNji3e+TIWBQn6g2L+C16XHeXsR1s3FenB/mWd8HW3bwYjpTbDhCTTipsAPaDRgy6DW18I2ajNCVI5otVEBgM5ogtbALqZzf6FwZNxEczhmSFZh0qjZm8Csa+mN4EZj8b4rf9NULUgBRIOgOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com (2603:10a6:803:122::31)
 by PAXPR04MB8893.eurprd04.prod.outlook.com (2603:10a6:102:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 16:28:26 +0000
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6]) by VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 16:28:26 +0000
From: Farouk Bouabid <farouk.bouabid@cherry.de>
Date: Tue, 04 Jun 2024 18:23:51 +0200
Subject: [PATCH 1/4] arm64: dts: rockchip: add mule nvram/rom to
 rk3399-puma
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-nvmem-v1-1-b784260a36a6@cherry.de>
References: <20240604-nvmem-v1-0-b784260a36a6@cherry.de>
In-Reply-To: <20240604-nvmem-v1-0-b784260a36a6@cherry.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Farouk Bouabid <farouk.bouabid@cherry.de>, quentin.schulz@cherry.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: VE1PR08CA0003.eurprd08.prod.outlook.com
 (2603:10a6:803:104::16) To VE1PR04MB6382.eurprd04.prod.outlook.com
 (2603:10a6:803:122::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6382:EE_|PAXPR04MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2e841c-9c22-4114-ff0e-08dc84b35c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czM3b05UNENLb1Iwamx1NklzTHc2TUlxUmpaM2JEU00rS1NZRi9ucHJXOU55?=
 =?utf-8?B?YldLZjVPMFp6dnJTN3NZUTBxZlFSTmhpQWg1NkRqN0xrOFpmM05hK2RXWFlO?=
 =?utf-8?B?ZVFCQU9lUVRha0xkMVNZcThadFdETVhHUVpVejhFcFUzRG5UVGxjWUpySFFZ?=
 =?utf-8?B?VVduNExicjhwaEE3RnJVTG9tZHpvQmFpVFA0RnhaNHg1NENvWDhzV1R4dVNY?=
 =?utf-8?B?WE8wTHIyNHFNcEVZNE5Eb0NMVzFJYys2NkRudGFqaXYxRGF2QXZERXNQZDhi?=
 =?utf-8?B?bHlpMEV1UTMvQTkxaG5ZaEZ3WkRaSFZsZjBJS2FXbVU1M3djRmlYWE4wRVFK?=
 =?utf-8?B?SXhXOU04Z0pyOEQxMHBCVEJxcmg1VzZFdTlPMmZ3elJ2aW9taTlvd3RXSHNX?=
 =?utf-8?B?bmttdmxSaVNnMytsZmdRZkRWVDFqK1BIUVp1ZEF6L3FtZlV3Yjk5RncrbWIx?=
 =?utf-8?B?MlJTODB6Uks1VjZ5OWkyY25HVGVLeU4ySEdBdlpHVndFOHFGMEMwSVVFWUtR?=
 =?utf-8?B?bjJmS09ieXBsWmZ1Q1FBTWJHWUttb2tKRGRIbmwwemtMbjdvK2I3V2NUWXA0?=
 =?utf-8?B?K2pMb09Rd3c0eTlSS20wNnlGMEtKbXVBcWV1SDhuajdReGN4NXBEQzdVWlAy?=
 =?utf-8?B?cms3YjJXVDFJWXpHdVNXRi9uS25LRWtIK1ZvVHNqWkhsMlova0l2YWZ6eG1n?=
 =?utf-8?B?SVh6WEU5WjJ5d3diYXZZRmdxUmIvbTAzcW1Ha0JyK0lGK0JnM1A4d2ZrZEZ0?=
 =?utf-8?B?SHl0cjR6ZktLS0dtL29TblVCbE41ME5XcmtoUzFSdHFZTFlkblF1Vm1OYVND?=
 =?utf-8?B?c3BnRUg4Ri9uN3g1bzZxcjl2SnlnRkh2L2ZIL281c3RvK1lmM0xZbkxVUE5l?=
 =?utf-8?B?ZjFTVkY5L0svMmJRQm54KzU3RU5WdUJBRVdkazM3QUgwNi9kTGFjc0dKTDc0?=
 =?utf-8?B?WnlUYWpJZmVRTi9HK3dDSGhkVkpEN0lUV1BHbUZhZ2NuSUVaMEFGMkVTYU5I?=
 =?utf-8?B?REtHM1I3RmJhdkVSbVdvbEVXUWFEK1ZBZDhyOFBjcHlJenlud1FkZjhWOGlZ?=
 =?utf-8?B?Z2pxUUZ4c3QvcEVUWlh4T2owVDFmSEE5a2QwSzNwVDIySnFaY1lvNWM2SEZU?=
 =?utf-8?B?dFFrMXlkNEw4d0xmUkd2S1FaYUV4b2swSjcvN25pSjRXWHBUS3VKbWU5YlBM?=
 =?utf-8?B?N0U5QWptd1J6c3RydFc2cnhBcHRnbEYzZFBFZzhYaDlDRnhrWGhYaXhxcGJN?=
 =?utf-8?B?WTJteWpmVFdweXdVbXBzMjN6Wk9HcldVZnd3cFpIVFc2R2tCK1g3SWVUZjBn?=
 =?utf-8?B?UVBZSG8zY0VPOXU0YkY5TS95dGs1MnowK0cwYTcwRnlhVVJlMklPNmZnZGF2?=
 =?utf-8?B?K1JhSHc3SStIZUpMV3JDOTMvbWhzcENsR0FTMStoNTRtSDdjVTQ2d1A5MDRF?=
 =?utf-8?B?RmRtMHQvajZuRUJJTXZkakxLSWFCd2h6ZVVYL0RPeXF0RzhWcU5Md3dtQzJR?=
 =?utf-8?B?ekNDa0RjMmlPNWYzanc1VlloVk16QlBFT28zQ0pFMXNRM0c1UWlUTWFFYlBx?=
 =?utf-8?B?Rlp6ekN2U1h6VHdWUFFkbjJYSm1Ocmo0VEt2TmsyOXhjQ1hIUlpMU0xPS0Vn?=
 =?utf-8?B?KzFzSGRXR1lqTFg0Q3Z2OEVPU1ZwRU04dWhsbUlKVUk4bHA1SWFMdTN0cnZk?=
 =?utf-8?B?RHVFS3A5K3NDSElNd1VzNzl6bTNvUm9WL0p3L1daTlpnRytTM3hlSW0wdDh2?=
 =?utf-8?B?Q3prRVpPb1dJSXFlN1BkRXpHSFYrU210dTZIR0JIU2NJbG5EclNiQ1p5SFIw?=
 =?utf-8?Q?kKhuAN3nj/8yqlTDWRsDDGLbqheXYpXvPiRJM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlFvU3ZIUGZKSW1IN3NXdkgzNVVoTzlZVXJ2MHRoRlAxR2hpbkhYN2RsMXNC?=
 =?utf-8?B?U1gyRFdWRWVGTDkvb2lqSXFuWXdRbC9rekpFbG5WS1U3TStnNEJ2eFlxU1pr?=
 =?utf-8?B?VWpBNjNGSDFPSG9ieDhOTVQ2eTZYWVg5TVY0QzNIOVpraXBmRGVySC9VeGxC?=
 =?utf-8?B?RDNPRkxvMkhic1RsSWxzeExiVHhzbTk5UVN1bSt6MWliQ01Pa1cvREJndDh0?=
 =?utf-8?B?RUZJcEJTRkxHZ3Y1QThyUDNuQ1k3djl3bnhmMFpWdW1SMEwzMDQ2Tkl3TW5u?=
 =?utf-8?B?V0h0VHR4ZzFCMXk0V1F4eTEvbnJwUWllUmx2QmFnb25WbS9zREhCL0Qxamlr?=
 =?utf-8?B?bW4vb21qVWxodERDT01JQ3FVY3ljWjNaYkcrYjNiWkM2SFExRWhpU2o2eitW?=
 =?utf-8?B?dnRWTE9YSlFNUEY3eFdlTDg5cnlIK2ViN2ZabjIrNGRiVElHNURKeU5VdUpH?=
 =?utf-8?B?QUVTcW5Tc1BFL3hqMk9iMjNrN2l4REhSUzRWTzhyaFdrSk1scitLVEtEeUJW?=
 =?utf-8?B?bHgvT0V2Y2pVSjkwNTlqSnBoQzFjRVBEOWtUc2RnU1ZGZGFoWGNlMjRGLzVl?=
 =?utf-8?B?QXNhKzNGWVlvamZ3WE5KRU9BTFQ2QVU5SmRuOVdEbFBUaFBucnVMMS90Snl4?=
 =?utf-8?B?MDFmYzRILzJqNzVVbldtTUdOdERmeHNZYkhqTnF5MjYvRzMxUmVuMzE0NFYz?=
 =?utf-8?B?TXJCOENZV2R6NjJ4ek1ZZHBmcDJ5ZmQxd1BEU2xzaEp3R2ppR0xaQ3o4bHF0?=
 =?utf-8?B?Q2srRjlJQXExaVUxOGlET2pJTmRDNnh1VEMyMm5ybkhKbDNuMTUzeHV0YnQ5?=
 =?utf-8?B?VnVkUVZ3NkxqLzY1ajBPM042Qkhnc3ptenpmUkMvWWV4MTA1L3M0NkhuSVpQ?=
 =?utf-8?B?OWIxSUdtcit3aEMyd21jUy9rU1pKODBjY0tkSUJGeFZwdGVkeTFTYytab1RU?=
 =?utf-8?B?UXZzOWkwdFpCNm8vbVREYkxJcWZKOGllVHZGVGVpVE1Tay9oV3dhOVFMdWgx?=
 =?utf-8?B?QXhkN2xkYmdpNXlnSHU1Zlo1ZWh3VGlnYVIva216Um5EOGZwaEs1TlR2dTM4?=
 =?utf-8?B?R21xNkhreUNPTEpWOVNsZkdEYUY2VTltQXVPelRjeHFqc1Z5Wmh2TlNMZ3Fh?=
 =?utf-8?B?bmY5dzlESWNtdUVIcEY2Q3hZSDdnMFIwY2pwU29rdzFDVVVUNGVLSjFhMnRy?=
 =?utf-8?B?Ti9LcGFROVlKWHN1NExwOHZqQ3ozbUNLS2l3NEM5Uk5Db3kzSXlidmR3ZFg2?=
 =?utf-8?B?REIva2tPNXg2TWs5T2hZQ1I1ak1DbSt5cU1EREZMcW5vODNHL3pweXh4N1R6?=
 =?utf-8?B?eGV1eTdQR2VkSDNka01MKzg5ZlNtZU9PWXN3L001ZVUwRzVTL1dQODJsV1FG?=
 =?utf-8?B?RS9OQkNQWXp5Ty83emgwRzMxVU94SXJWWFltWVdIUXdrMzE0Q0NnNlFLbjgz?=
 =?utf-8?B?aXRoa2tqTERNZ2diVmo2MGQrc0R4ZUpabUNudVNMQkJpT2dyV2hCVXpvdExn?=
 =?utf-8?B?ZkxQZ1ZveFhnRHc4Mm40c1orR1d6K2hYOFZSdGt4NzUxQkxhOWV4cGlubUdL?=
 =?utf-8?B?U0VYZjcydFZGa3ZGeEtxeDNTVFRydmlGZERKWXdjWmFtRXU2TWZNV0d6TlZa?=
 =?utf-8?B?bGxEclZJUWc4OHNwMnJKVFlSWmk3ZGhnNWVIMmpnKy9lOXFFcmNjenZPMTRB?=
 =?utf-8?B?NHNDWVJpNWJKb0xZbzNLWEdqemZXY1lSK0RIOVJ5cXVRVFg2b2h5NklIMXlT?=
 =?utf-8?B?VVFDRGdwVENsenU0VW1rSE91QjByVklkQmUxbFlqWUJBcS8wVENzTWFtT2Uw?=
 =?utf-8?B?d1ArNGd3bWJGMmFPMEJpZXBUQ1F6aEdjc3ZPZnBoNnZ2Nzk5MHRXK1RqM1Zs?=
 =?utf-8?B?bk9LT0ViWGZRdjRNZ0dTTzNRSzBkQTZuM3IrL2ZVS2RVRlYxL1F4Qy9GTHRl?=
 =?utf-8?B?MVhNVUFCdkFNNE92ektjeXdmTHJUcGkwd29va0xHb0ZPcDZRczhHRHhzN1Bt?=
 =?utf-8?B?dFJsWjBSd3hXWTVvSWE3aHFuVVRlT3AzUkREcW82cHY4Vm9qM2kyelpneTNG?=
 =?utf-8?B?aHdGQ3U0WlJ0WlJ5QXMrYXYyVklud2R4T1d4S2I0NFh6UGpYRHpDd3NUK1R4?=
 =?utf-8?B?OFRHTE1tVzl1ZHp1dGF3VVhQU1FmeDhTcHBkNlB1ckh5Z0U2TG1vRnVqZU1z?=
 =?utf-8?B?a0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2e841c-9c22-4114-ff0e-08dc84b35c7f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 16:28:26.6710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3njefz0yTYfzBX2Jmlz1YEOS4A4jG7Vnv1yFkoSefuXClWS5SI+r9gnZMnAntVDHgNej3EDzyAbUzMHK0h1lnC8f86dKUeHFSwdwkq3XqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8893

Add mule NVRAM and ROM on the Mule I2C mux (0x18).

Signed-off-by: Farouk Bouabid <farouk.bouabid@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 45 +++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index 69b57cde7d78..7ab688c46a49 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -11,6 +11,8 @@ / {
 	aliases {
 		ethernet0 = &gmac;
 		i2c10 = &i2c10;
+		i2c12 = &i2c12;
+		i2c13 = &i2c13;
 		mmc0 = &sdhci;
 	};
 
@@ -395,6 +397,49 @@ fan: fan@18 {
 				#cooling-cells = <2>;
 			};
 		};
+
+		i2c12: i2c@2 {
+			reg = <0x2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			eeprom@18 {
+				compatible = "atmel,24c02";
+				reg = <0x18>;
+				size = <8>;
+			};
+		};
+
+		i2c13: i2c@3 {
+			reg = <0x3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			eeprom@18 {
+				compatible = "atmel,24c02";
+				reg = <0x18>;
+				read-only;
+				size = <32>;
+
+				nvmem-layout {
+					compatible = "fixed-layout";
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					mule-variant@0 {
+						reg = <0x0 0x1>;
+					};
+
+					mule-bl-version@1 {
+						reg = <0x1 0x8>;
+					};
+
+					mule-version@9 {
+						reg = <0x9 0x8>;
+					};
+				};
+			};
+		};
 	};
 
 	rtc_twi: rtc@6f {

-- 
2.34.1



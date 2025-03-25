Return-Path: <linux-kernel+bounces-575409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F774A70257
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82104841E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E072580D2;
	Tue, 25 Mar 2025 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xh3G/fGC"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011065.outbound.protection.outlook.com [52.101.65.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3D82E3392
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908882; cv=fail; b=JyS9sR3WIM6HzR9lGJ3oc/jZBsvxji/z3gYIiMqXj3+0cJzzNc05Bd/ZewBV7fOF+cCE+FgJI6JG5UoUcl4Ks0OlIl/fxU8s4YB1ZPvLqa3pLemF/MNIm2/Wmm/VDtfCtbQbOgxtdpahMIqbekhX3ED4JcIm60XbSbhzJIjdei4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908882; c=relaxed/simple;
	bh=sXNyyLroDBMqYBOaAEqcFMtF74EFg4Jrwn1e5jYcbBo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a4HJbT9H7y8TMpkTWQWtrX2J0tQmQJy7purXl7CfmUdkk5Ca1VNXKOC/8dK9MezcLAZsdQ3vgr1lJ7nb9RTUdNPuiaIOa2KUxYrztCSkzwxhRJ8y1RVkF6tPJJ3gnUs3Ddn9tOSV3awxD+aeU//0POW8uKoB370TxUPZfAN/byg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xh3G/fGC; arc=fail smtp.client-ip=52.101.65.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouVcODml5VoLhYAL7O8uGPva0wnRn2LBuCDebfY3yaM9FKQzRt6tCtPP7aon7BysOkM8hCPkjQrEU2iRnGyIGwWD+Q44jv+THyiYmAeTOaGFwcobRmnoIcg1b0PNwfe5dMG0MTAksY+4iXlGZrFRr5dHmZ1lI45z2sW0XFQqrlC8EIgId7Q0R8HT1RBevXHqlIvTQw7AzI8oBApm5JwbucajyHbKBteMbrrq1JVs17MNtpzN4QbmDEbPn4MUPSphKyWM9eW/7KCUXjrjDZLpalALrLtR9jGrBgLLpETf0+spciklpLeFRv+DLzzjld1EJR9WOsSlw9+k95Ko2VsgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TyvjstiVa8n57IkCiQkQ0Z3af/85QEq7BrJIiK9W18=;
 b=U8+yRZOYW4nvka5fRKwUq+oYyaZKEX1ly/sVcho3esX6QgCi6KEx1R+10EnbMMKC5sE3OgeesIG3u6jL6Nz6gTkGjDLQoX74xjRSaTnkybeb7xr39hZWsTIXPWqB8WRwfnDF3XtleCYLJSLjrVTzh5fngxFXkfe3RMiByRrIux6v9gCDfPyfZWA+y7vC4KH+1s8E/roiOesXvEYEyP2mUrzKFGYV/COUgd43vp1u7B+0c0qOtd/eBwhCPkjC9twkNX3q1h8YGB7g3XV24lYB2Z4kFCHPRXEBb3VUOBvUmbdMfXwgYBMlwIvDBrDHbUWH6yFGskDwSeqsah1lveuNoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TyvjstiVa8n57IkCiQkQ0Z3af/85QEq7BrJIiK9W18=;
 b=xh3G/fGCCECmBUov6V741u82v5OdYcDkBFOlqLKVXVw3ZJqmSAeheuVmPv7L4Ui2WqvDQeQ3aEkkHMDx+HDcl8qt+YJK2usREfk011Yb9SeCk7+OT3NOnUNrhCga1xAFvHa9hHEJo/47lkl43tB/qMDEIroc7gBzOsAhcUEG8cUtC7y4T20HkBzFHCwQvyo66mY6+rf4t3mxnX6Foip/I6Hl78TRat6wS9y9Yl0PIFaeXhJig6Ar/ZEiNcDAXWqCDJ9YwqEIIywsIxvB69/VvI++6vKD/nlDCP5tNvsTQqvITGZs+6iKdEcdjTwMNw1n7QvJrPMuPRx4ridNaQiUBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by PA1PR04MB10324.eurprd04.prod.outlook.com (2603:10a6:102:448::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 13:21:17 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::c96e:12f1:67b7:ed74]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::c96e:12f1:67b7:ed74%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 13:21:17 +0000
Message-ID: <50d2c651-746e-4ddd-4036-f72742a622f8@oss.nxp.com>
Date: Tue, 25 Mar 2025 15:21:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] clocksource/drivers/nxp-timer: Add the System Timer
 Module for the s32g platform
Content-Language: en-US
To: Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, Thomas Fossati <thomas.fossati@linaro.org>,
 Larisa Grigore <Larisa.Grigore@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, NXP S32 Linux Team <s32@nxp.com>
References: <20250324100008.346009-1-daniel.lezcano@linaro.org>
 <20250324100008.346009-2-daniel.lezcano@linaro.org>
 <d60fca36-0beb-2574-cb82-3969bbfb58a9@oss.nxp.com>
 <8c208e8c-2e1e-430c-916a-dbc6732881b0@linaro.org>
 <065d6f32-3161-8316-bbbd-4da18eef839b@oss.nxp.com>
 <098c5de8-9291-4f3e-a276-500825cac7c5@linaro.org>
 <068713cb-47ca-ae26-e113-9f5026be9196@oss.nxp.com>
 <cc2dd75c-e279-4e55-ab88-75498e93146a@linaro.org>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <cc2dd75c-e279-4e55-ab88-75498e93146a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0020.eurprd03.prod.outlook.com
 (2603:10a6:208:14::33) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|PA1PR04MB10324:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b3a1f3-eaef-46b1-8370-08dd6b9fec69
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0lrVkh2YXpQZjUvckd1bDRhWTVqTjJrT2RwbzYvc3NQMGJaNWhKVzJBeHVi?=
 =?utf-8?B?RjhRNi9sblRkQWk1MktmZ0I3TkU5MUU5UTQwSGxVNGZsdDhyVkUxNVVZY1Ex?=
 =?utf-8?B?V09vTldaS29CV3FPSnAycTJiV0MzSVY1WXVQVjVLaTU5aEJSYWJMaW1SQXZT?=
 =?utf-8?B?WWIvcTZOV1J3V3FpUVpQanBpZWVyWURSL000dENLQTZVQjRiRVE3ODI3cTIw?=
 =?utf-8?B?UXhOUHpEdExBam15L3pvTGV6OGZSc1VWNTJwdUJyc3E5YlVWcDBsOVFQRzl4?=
 =?utf-8?B?TG5Fb0hHZzZXdWtVQW5Kbmc5T3lBQXAwL3FJTUpLK2l1WlRNSE1mSEFxZkhB?=
 =?utf-8?B?dHRnZzlIdVZvNER5QkpYL2JwSjZ0VlBYemNZRjlvVlFrY2o5OEI0VjUzMWIx?=
 =?utf-8?B?OGhqNkNUSWhYbExySFBKWUN3WWlQbytTZVBiNDQzb1I2c0FvWWlpU3R6UDR3?=
 =?utf-8?B?YTdkdHR0cG8zY1pyUU5nUTFYNUhtK0VrQ3FhR3B6ckVCNDc0OHErZ1RVQk9I?=
 =?utf-8?B?cUxVYkloeERpWVZ2S0FRaWZSMG1WOEs0ZjVBWEtBQlNSSDNoWWFjWWxVaEMw?=
 =?utf-8?B?aVlCYU9Ba1VBeWZMaTlzRnpHZzVzaWUvT0kzdHlEVGdFS3ZMRFpqZ3Q3L0ZH?=
 =?utf-8?B?V0VxaStXUDhNMHY0WGVQK2M5V2V5NityN2pVc3VlYWRaOWo1VDljYXpLdWZn?=
 =?utf-8?B?Qm9jU0xGOWcreVdNbkdWSktHN1hLYTdCODJReTJLdDVtV25wNk1wNHBmM2xL?=
 =?utf-8?B?bDBCYnFzMVcwbWZnOFdXd3o5SzhMV242ZzJrSTZCaitPNVQvdU9iR1o4U2F5?=
 =?utf-8?B?dXUvL01lRGZ2a2JmUWl3OHAwRXEwc1pFRlZBV2d6blNQRFYvUUo1dU9hb3hV?=
 =?utf-8?B?eTVlUXhzWW0vL1N2bi9wc0Z3WmFKeGM2SHRoS2xnSDB0ZTdkNWxlcFhkNVZM?=
 =?utf-8?B?MmZ5Wk1YdDUyb2ZJN21uUDJzWHJqelJQR2pKTTRGcVh6QjlBbUFwLzlnUFBW?=
 =?utf-8?B?YlBVUWFtcjFsOHExdWc3bklKUXVpOVZjTytINXlGVTVwM3ZlMzVUVCtyNE9Y?=
 =?utf-8?B?ZE9NaTc4NjRFM1g2YnZ4WVk0cnZkQ0ZFZEI3cnFkcU5PNkxMTnU4UmpOVlpl?=
 =?utf-8?B?VklBWldaY21PSTlkS29rUUFuNXJmbGpKSkZHb21QMm1wTk9LNWRMY0xhdjQ5?=
 =?utf-8?B?QU1lNnZ0ck5zUklaY1BoTXV2dExmR0REb2ZGOHN0T01oWFhTZ0IrMTBCeVJM?=
 =?utf-8?B?TEpNekE5MkQ5SkpxYm9GVDVHWDM5b0lmRlp2MUtWN09pSTRQQ2RINmpZcGVp?=
 =?utf-8?B?MlZYVEJaSzlrcWF3THFBbW03dzZuY2krLzZNZllaQmcrS2NpRDNnVmw2WS8v?=
 =?utf-8?B?elI0aW5kem41Qk5lTVp4UXJzRzdLcDJVMWhSSjR6MkpvUjlndlBxSndmWWpj?=
 =?utf-8?B?YlVkU1BTYXNHcFI5d3NHTzBJd0xobGNKMDVOMFphQTh4SHRUMXFlU3lWdFQr?=
 =?utf-8?B?enlha3JhVU16QWcvRjlLdHlNQVowQUtRZmJjaklnU20yRXpMZ2I4UGtsU2FV?=
 =?utf-8?B?aUFNcFBMaWd2NHhad0prUlNWNlJ2Q3dCbTAwUHZiNUlHemNtWlUwbHdRaWdh?=
 =?utf-8?B?cUJjQXZoVnZ0aERlS0kvcmZLTktodFRFK1NrazFTbmJHalZCK2s4ZkNMTFNM?=
 =?utf-8?B?VlNPT2E5UGF2Z3Z2M0xLMGg1aFJqL290QTQvTDl6ZG95cGs1ZFlONmtuclF4?=
 =?utf-8?B?Q0RNQkE3QWtSMVJ1VHBOQ21iZjRFRWhDYUduWmVjYnN5RXVZY29yMEpucVVN?=
 =?utf-8?B?dDh1ampyVWorRnF6cVZzbWs3cXFjZWxUeFU5VkNJVFF0TTZCSzlJbjNFdW43?=
 =?utf-8?Q?1MH67mTJg72H+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1luV3BsU3BUVlhZUDRlTUk3Ym9vclJvYXFMT1hEbWFiVDJHeGg4M3pYUE9T?=
 =?utf-8?B?eHp2RERFSEIrakozVEUrRjFoSStJN3RsQ0U2V2x1Q0NBYTFWelcvRDgyRXpG?=
 =?utf-8?B?MXYybVJLdXBPVXNFaGtvcmpveUVUNHpZN1NaYjg1c0tqTDF2TG82Nm12dGhH?=
 =?utf-8?B?UVc3OFRWcGxvMUxaaUpIcnlSMWxRQ013OUNubDJmajNZbmFLSmFsT3d2ZFZK?=
 =?utf-8?B?am5pdFF0cnNrY1VDclRUc3BDSE5YaVp6cnU5Sys0cGxJOHlkelBETGo3N0JG?=
 =?utf-8?B?QmhBclpid3hoTWlDUGVXNm55R1Q2L0tDTDFxUWVNYXhhTGk4UkJkcGRva2NU?=
 =?utf-8?B?WlNZa2lJZTlNR3NocEpPVUN6V0ZoSWpxT09xcnluUHhLQ1lnWTR1R1o3SUpF?=
 =?utf-8?B?eDlxcE5DVUhiNUhMdzZXSlMwM3RXVTBBNTc3aEhDYXVxaG9NQWdCMFJhdFFw?=
 =?utf-8?B?QkFmcU45RUluSFNvRm1iRGM2blZCVFVMMjA2UnkzSVFIU2cxbStPYW0vQ1Vx?=
 =?utf-8?B?Q2dITnFLMXdlRW5SYkdyWktlSHdKSUpCK2JxS2piSzBweTY4NHNxRkVXZGdO?=
 =?utf-8?B?OWFiWDFOOW8vOFl4NDNieUhyZUYzN0lJOEZFUWx1bVcrbEJlb2MreSs4MVJG?=
 =?utf-8?B?QlhINlU1TGdMVmhNNWVHQ0RCcW1iSXNTNjNRaFZBRXRDM1o2dXBnWXVjRnUx?=
 =?utf-8?B?VGRrZE1HWFNwaXY1SCtRTTZPL3kzZkZhem96Wi93eEZZOE8zQ3Yzcm9PcStn?=
 =?utf-8?B?dW9GekM1OUU4akdhQnlkRnEyVXN5Qy9tdjN4U2czaGtZMG9vb0dXNTY0VVJO?=
 =?utf-8?B?aDArU3JKMXpreUhqLzFSMUU3WGh4dzNJQ3p4R3BPWFptcHRGVDkzbzQvYlkr?=
 =?utf-8?B?Z3VJMVVLS1crb2VWVk1PRlJYMm5EanE4a3crT1ZXcGJDZTdtVkM5cTRCVXFY?=
 =?utf-8?B?ZzNzTy93Ri9BMXU2dEwwaTkxQU1MVDlsQVdKNFU0M3QwQWdTT3I5cUUzSys0?=
 =?utf-8?B?Y2xTRXIzT29qVGp5c2tiQjV5QmNuQmNNV09CR3kzd2JpT3dOZTlaZVB6Y3hx?=
 =?utf-8?B?TU0wUndEQUMxZ2FhNko2NHpkMWY2VnVNZE52QnhmVWFTM1VoRFNiZnJVZkNi?=
 =?utf-8?B?TzVqd3IyQ0p2RG5LRjArWm13bmRLUEFoNkx1Sks4V2lQNXE0SXQrZnFWQmNY?=
 =?utf-8?B?RHZXK2N6eUN0VDNnMTBMVWdIV2hidmhmYzZwTmNZKzMvVVYxZVdicEVWeGtl?=
 =?utf-8?B?TzB1M0ptTXJVVkVYK0NLSERBNDBTMGJVTFNkS0VUeHVBOUp3Rkdzb2c5dlVN?=
 =?utf-8?B?N1JnZGt6MDJHdkU0NU5GZEdIbi9LVXQyQVJmUkM4NUdkM1ZXeHVKVVo0RkEr?=
 =?utf-8?B?Q2J2cTZVc1hnMmJzZitMcVJhQVNuU05sVEUzOWdQQUlQZDg0UisxME5kK1Za?=
 =?utf-8?B?UGx6aGdBelZlakVVc1ZVRXM3M1NOcGNmbWNSTjhNRllSY2xVcU5yeENPbFhP?=
 =?utf-8?B?aHRmSmQxSlFYWHZkd21SNFJPbGpRZERlT0cxeW1tUTJNcFpIeWJCeGQ0SEJG?=
 =?utf-8?B?QjkxSXRSWmdWQjlOSERESEdDR3lENk5OdTg0WUh0QXNrK2NnMURxNXQvUXJC?=
 =?utf-8?B?MUFUSm81VWQySHZ0RnQ4am02ZUNuTWM4VWhZbzZBdUZGU3VRMGo0TmsyeHZu?=
 =?utf-8?B?d2RrRjVVTWZRSEw2QUdFMHNSNVlUQlVGa0luUC91c3JybG5pR09paldHVzhu?=
 =?utf-8?B?eFduOUlVbllWRXBZclN3RW43bi9aVWUvRVhJd3gwR0NWbWllYXl5N0ZwUFh6?=
 =?utf-8?B?M2cxaUlabnUwL2VRQTRBWnB4RWhGTzV4ZnN0N04vTWhOYTIxaHI1b1BmaGFL?=
 =?utf-8?B?elptTGtCa0lZU0ZUVVlGNXlHL1VXNHFBZXUyMWM5UERQZVpyQzBKalA4WUNQ?=
 =?utf-8?B?TjR6enlTUWpFMzB3V0pTdjJtOGo2dXJLbEgxUm9nZWdPdVgwWllUcUxabHVh?=
 =?utf-8?B?MU13YTVoanNPd0toUXJJQUl1bXkrdEpXdVNDT1pzVzVJQTdybDZ5K0o2NllQ?=
 =?utf-8?B?Um5KQWNsd25iNzdXME1xYlRMMXlzUWxEZDZFZWk3WEc2dmsrT0lSbXpBUG52?=
 =?utf-8?B?L0NVNDlDdmN6UFkxcUl1VUJ5TUJKaEdCdGdLSWNaSW85MURTeVFtTUdyZ3h0?=
 =?utf-8?Q?y+28VZpLQqVo0pUzPShqXxc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b3a1f3-eaef-46b1-8370-08dd6b9fec69
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 13:21:17.1855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKcJSLU1O3JD50Rv7Z4+Ett+DePBsjJ3/S3+6tq2uiz2kQDDmPH59MmEEjEjIphB3nWtPlJFyKGIcyiSsZpifhp3AZIKerQXAWJExdw7Mtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10324

On 3/25/2025 2:51 PM, Daniel Lezcano wrote:
[ ... ]
>>>>>>> +static int __init nxp_stm_timer_probe(struct platform_device *pdev)
>>>>>>> +{
>>>>>>> +    struct device *dev = &pdev->dev;
>>>>>>> +    struct device_node *np = dev->of_node;
>>>>>>> +    struct stm_instances *stm_instances;
>>>>>>> +    const char *name = of_node_full_name(np);
>>>>>>> +    void __iomem *base;
>>>>>>> +    int irq, ret;
>>>>>>> +    struct clk *clk;
>>>>>>> +
>>>>>>> +    stm_instances =
>>>>>>> (typeof(stm_instances))of_device_get_match_data(dev);
>>>>>>> +    if (!stm_instances) {
>>>>>>> +        dev_err(dev, "No STM instances associated with a cpu");
>>>>>>> +        return -EINVAL;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    base = devm_of_iomap(dev, np, 0, NULL);
>>>>>>> +    if (IS_ERR(base)) {
>>>>>>> +        dev_err(dev, "Failed to iomap %pOFn\n", np);
>>>>>>> +        return PTR_ERR(base);
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    irq = irq_of_parse_and_map(np, 0);
>>>>>>> +    if (irq <= 0) {
>>>>>>> +        dev_err(dev, "Failed to parse and map IRQ: %d\n", irq);
>>>>>>> +        return -EINVAL;
>>>>>>> +    }
>>>>>>
>>>>>>    From commit description:
>>>>>>
>>>>>>> The first probed STM is used as a clocksource, the second will be
>>>>>>> the
>>>>>>> broadcast timer and the rest are used as a clockevent with the
>>>>>>> affinity set to a CPU.
>>>>>>
>>>>>> Why is the interrupt mandatory when the node is probed as a
>>>>>> clocksource?
>>>>>
>>>>> It relies on the DT description and it does not hurt to have a
>>>>> consistent code path for clockevent / clocksource even if the
>>>>> interrupt
>>>>> is not requested for the clocksource later.
>>>>>
>>>>
>>>> If so, in my opinion, it would make sense to use the same STM instance
>>>> for both the clocksource and broadcast clockevent, as both functions
>>>> can
>>>> be accommodated within a single STM instance, which will help reduce
>>>> the
>>>> number of STM instances used.
>>>
>>> The broadcast timer is stopped when it is unused which is the case for
>>> the s32 because there are no idle state powering down the local timers.
>>> They have to have be separated.
>>>
>>
>> This wouldn't be the case if the STM is kept running/counting during the
>> clock event setup, with only the clock event interrupt being disabled
>> (CCR.CEN).
> 
> Are you asking to use two different channels for the same STM instance,
> one for the clocksource and one for the clockevent ?
> 

I suggested using the CNT register to obtain the count for the clock
source, while using one of the STM channels for the clock event.

-- 
Regards,
Ghennadi



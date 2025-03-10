Return-Path: <linux-kernel+bounces-553845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D6EA58FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F9E16BCE7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D632253E4;
	Mon, 10 Mar 2025 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="UhzbPSxN"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021081.outbound.protection.outlook.com [52.101.70.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8882122333B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599170; cv=fail; b=VJ5pM+N/D4pPlVqIZWsv2/Ew+VO2NE7RmAo4m51wf16ognzhUYFnFF/TlKQvNW8Ua2B/EolOcGnJ7aJfhlLiuy0hSQjSbewDk6HdBqtA4AUcYaP+v0GzCvRgqGBSlfpRordTClF9M7DSka5bf5mSo07IFxtk/4WXBDnLbwvip6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599170; c=relaxed/simple;
	bh=tuzYVCQ5OGDpAG1wFVJMHd0VQe+neUlZyXCxnVndIBY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sei2SdCbWTcril1Me+sfxMb2KE0ZWisNA3yiC/vnR1tAQM1LndMAfcdOZXc1Cl1KEnv4EOKU/KkvPY0d6RUTiH6OxzaLTOYXxygleg7nU0rB4Ulmr9BcwLQDBsN//ahTrurILGbwve6xo4sAdZh+r99Y7mpxrp2KKMudVMPEXCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=UhzbPSxN; arc=fail smtp.client-ip=52.101.70.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSdvMO9T7VP+LNahHhNnJch7XzQyJQjYAOtsFPg7sz4T6qF150sDJP7Hf6kfm+uO4Rvc7tlDc8VCuwI88IxsvR/fYeginTxoNKxWs/Fux/ZvtDHa508rOfoLEmv+xOBzWDgXwJkL5nom36JHsIzAd1BYy9DFZqPpK1lk9uH6pXnAnJ97Fb0fvIgwrbbJOvY5X3KpeYpNfrhrvvERazElST+FlWgKP4ef4BaWOOUTspGs1xWxxEEFcRyKxYgbaCVwGYmeo+ZuAncxkxogz9NDWKimWyxjAgT4acXHfLlUhFTZNR7geL5T+ytyVcYRKAVNWgFH8/JtKDIUP0RTQaH31A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xxg2ds9B3ZeZYg50/wXNf990MfnCst457iGIPw4DG08=;
 b=vRlkYpUYe3jMkSm1sSR39E3krUwmPB0T8hOegVwCKU7N6W5s0KXL+oVI34Vp8dY5i5ajx0XM+vPr6ZB88XZcdZkwK6b5HqIbw+mH0Q2W7E4vmcYolY70yTkR5JqtlwvL1wVDeeS8P7J+CXUew0LDS7gNrCbtiERKtLmrWg/FmupxW52lx66p49JWkyM/ghHQVT3TfRzia5lDevoLxUY0/TdJ7k/qEBiLHJgL2mgjQJjXBlyHT1HUWFRfLEFL2KcmMIe6JukYByJ0VvFdsc5O/sRpxqgXPjyhlgqmkIx4t65i4FaSzHO+3qc5CteFPczcSfRDdGvqTiKdbFxXwVWJOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xxg2ds9B3ZeZYg50/wXNf990MfnCst457iGIPw4DG08=;
 b=UhzbPSxNsicMl2KX/aoIKCchpz5Lu+ZJb9moTMFUzoanYqAUwsOdLW7gU7vuTGqT+Fzh3Dz8v4sdpswUH9yo47IXCogX7EPN8f+qDD7zT2cNOU2FYFQqKxjnolrScsR9iBIdkvlZndwLrH0UA1bDagYMya1qvKy3TZvaMY0vBnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS2PR10MB7761.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:644::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 09:32:44 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 09:32:44 +0000
Message-ID: <638865e3-53ea-44a4-a541-ed73ee2c476f@kontron.de>
Date: Mon, 10 Mar 2025 10:32:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: freescale: fsl-samsung-hdmi: return closest rate
 instead LUT
To: Dominique Martinet <dominique.martinet@atmark-techno.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Adam Ford <aford173@gmail.com>, Marco Felsch <m.felsch@pengutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Lucas Stach <l.stach@pengutronix.de>, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, Makoto Sato <makoto.sato@atmark-techno.com>
References: <20250310-8ulp_hdmi-v1-1-a2f231e31987@atmark-techno.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250310-8ulp_hdmi-v1-1-a2f231e31987@atmark-techno.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::10) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS2PR10MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e84e00-077f-41b0-cc1c-08dd5fb682b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmR5QnBQTVZsQi8rRnlGd2ppNUJLQWVpMEgxT3cyOWY5TXpLSzR1c1ZiTzg1?=
 =?utf-8?B?SVN1bWhIV0FyS2hkRkc4eVVCYnhSSkdXWUIyOVpNTWttQzdOK2E1Vzg0N3Bh?=
 =?utf-8?B?bmYvZ2Uva2o2M0pSdExsSStRWlE3TnIrZ3lQaUtrUGlOTVNETUxJNUR6Q0dI?=
 =?utf-8?B?ZHovakxuaSs5ZVV2d0JvSHpreVJiRXR6V1UrMHZNblNpSGN1SVlBVXlZTUNs?=
 =?utf-8?B?UkhYd29mZEM4VmFOTkVSVWYvKzZDOEI4K2Fna0loZTA3YVQvam9mQWQ5bUpU?=
 =?utf-8?B?a3pGMDlsVjljUk1rY3k5U0h6T3BnOVFsMm5HTkxWUGdQU1luMXhzUVRhOHRS?=
 =?utf-8?B?YUFNTDVjWko4WDJEZURUczlFUWtXeHp1OGhxUkN6NXZWUllmcHcxUlQ0T1Ni?=
 =?utf-8?B?VXltS2pKNmRYV29qSEtOVnl4VkJxLy8yVkJkTTBzUkl5QTNhOWdtUFN2SXJS?=
 =?utf-8?B?TVFCT0dJWjRaQXBQbktKWExCUzBaSzcxaG9IdWc5N1RDcXZjeUVuQi9jMzdx?=
 =?utf-8?B?UjNOeEphOXVnTU1vNDE3SHFNYThXUFc5WWVSTFQwS3VsRXB3NnJIallpcVl5?=
 =?utf-8?B?S1NXaHFBU1VUcDdmUmt5c3A3eU5ZcU5WUW44d2NYd1JCSmpTQjJ2Nllob0tx?=
 =?utf-8?B?eGxxaGthUmZyVzNadkdhdWY1VEdzRDJEWVg5czlpcmpTdldIcnpKWDJHR3k2?=
 =?utf-8?B?NGxoUkFuUlFFM05NUE5KWkFLcnJBWGJkeEEyb3gra2lqQTNRK2hyQitKNmdl?=
 =?utf-8?B?V01LUG1tczJwVGxUa3pmZXB3UjJLWUxBSDBxbkhTbUx6S2RCR3FUVzBZakJs?=
 =?utf-8?B?QUVmQzdaUTcybkhLbkJXNjJLdEtuSGNwNjJ0V3hqS1NsaWRrMUh1UDJUVldI?=
 =?utf-8?B?cis4aWl2b29pT1hoR0NVV1Iya0wwc09HQjg3dXJTaUVmWjNCNUpXSGhWN1JR?=
 =?utf-8?B?OW53U3E5Z2FHYlJ2Q3N3eHNvNkYvbnhkR1ZacjByVExXdlk5Ynh4N1FmeTF4?=
 =?utf-8?B?dDRRSGozU3lYOHJrU21yWk1BSmo2MEMvckx6VUQyNXpmVlR4NnV3T1hadUZa?=
 =?utf-8?B?Mldiai9xYVpYRlA0dFppNG9QbFUyMitLQ2NUVVd6emE4S29oS0U5UEZNRkxE?=
 =?utf-8?B?RUpPZDhGWGhKMlcwQ0U3UExQVTFuRzc4Y01nbVZoREdLcDlic1lCbXN2amZx?=
 =?utf-8?B?cFJTOERFczg1c0FkanpPajlhSjhhS0dIWnB0TWsxQkdLenV2eFA3Q3ZpOXVK?=
 =?utf-8?B?eU1zb2lzenFZNXNYaytDWms1eFZhbkxpRDUvdHgvdzJhNnlicmt2UERKbDE0?=
 =?utf-8?B?WVpDN282VkRudkladTkyQWJQeXZXaTJPY0xlTUx3d003dktKUmo0bTFZSmlq?=
 =?utf-8?B?WkVUaUFhM1BaK2N2Q0o4elJrRHRzeldsUHRFLzdISkhxK0pjakNPM2lnc3M2?=
 =?utf-8?B?VDVwMXgvbHVTNUNwcnJib3g5SDNKM3U0NjA1YUZ3ZGkzVEJOQ1Jobk1wZURo?=
 =?utf-8?B?NS9SamJRcEt0bndYczQ2U0VXdjl0L1VqKzRCeUtJZ0Y4cTQzNFZ3dGJvbHBC?=
 =?utf-8?B?UUNJYlNQWnQ5cGFVZXNwMTdrVkhCRWR5ZjBZTldrbFhQSzdLcFdBWGVEZXRP?=
 =?utf-8?B?aE51dFJ1THdOWldhUW96TmFSQnhCOGdhVWgzeFhOY2ZuaGtodFVXc2pYejhM?=
 =?utf-8?B?Q3dMNzhBc0JYVkdXbzNpTFVVOG1TamlJYzJSVXQ1L2RDVzJDLzB0OUVhVXc1?=
 =?utf-8?B?Yml6VDJtY283c3gvTHViQkJBMXA1eDIzNGd6UHc2emxtWGREUzlPTmVjcWdq?=
 =?utf-8?B?MGpVUjF5SU1qY0ZVV2t1Q3dRRjcrcTV1WlE4Q1NjV2gvWGNZUnVLYnVNTEM5?=
 =?utf-8?Q?N48UbErKrwzk/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elVSS24vNllsRm1DZlkrOUlIZERkWStSOWJuVGk0Ryt6ZjlvNXE1YWVxbkMw?=
 =?utf-8?B?K0MyTTErSG1IUmZiK01Xb1lYV09CVUdoRHN2S0RQVWlOUGhsaExyZ2dDVFln?=
 =?utf-8?B?VThWYkc2YWRZSXlKTG1jMElIOWpGU3ZDNE9HMmI1b3g3bVBNZW1oZVFReE9v?=
 =?utf-8?B?b0MwMGNDNnY4N2d3SFdrS04yaVFROU1aWEgwYkE4cDgxcUtHalpQdEhySjlj?=
 =?utf-8?B?c1dtSXJHK0NVZGZmemhNNU1kbHBONkcwZUhrQ1o4TWdCQU1BOEdtdkIwdVl3?=
 =?utf-8?B?cmp5ekptajdJbi9wMkJYNXVWc0JqRlRzREpjTkRKM1dpTnJock12VXRhNTl2?=
 =?utf-8?B?cEdtOVM4SGNpQkNHRXhFT0wwUVFlK29GYi9lU0cxY0FhTE5pSkw0Zmh3Tlp1?=
 =?utf-8?B?Zm52Z1M0aE5FckZkaFhqYWlnR1ljK0RYRXkrN1JOakRCaVM5ZTA1M29sbVFn?=
 =?utf-8?B?NXJETDZiRjNzWDRwejVDemVaRWlNZFZXc2VHVXRZVXBvU0dlN0twOHovdEhD?=
 =?utf-8?B?WGpoWDI1T2p4eTVzYU5VSVc1RnBEak5ibk9KQ2lGYkdkcWJvVi9FSlFpQ3VG?=
 =?utf-8?B?M0NqRVZ0MzJaRmtiZlE1VXhQZFVieVFkeTlhVFNCclR6WkdsWGxwQmcxaDkv?=
 =?utf-8?B?WXlHQ3d5d3lTVFNtMVFaQ1NFc1RqRW53a1liSzg2UnJPY2ZmT3N5M3Z4a0VM?=
 =?utf-8?B?d2R2SmpqYXN6MEFPSHZGdHhSdTNnWW1QOVdaOVZJVk12dWlQQzIxWVBuUjFK?=
 =?utf-8?B?Rkw2Z2FQM1ZNUGk0aGR6V1o3b2tSSjAzYXdEK3hjZ25ZNVpHUm5LVDNiUVpF?=
 =?utf-8?B?ekI5QzJUWlZrMEx5ZkdhN0NyZjM5TGl5bWNuSERmZGw3T2RLSk9KWFFGUUlk?=
 =?utf-8?B?ZDJBRGt6RjdpNG9GUTVEd21keENibGIzd1U2ckQwczVNU1g3c2Q0Vm5GNitM?=
 =?utf-8?B?THNwTHVFeE94cFRmOGErbUg1V09QME9Za3BPK1Rtbk1OeCsxbW5HR0d2M3Nw?=
 =?utf-8?B?TTJ6MU5RdmZvelZpbG4rWHVjd1VOV2JyalQrVW50RUFRdW1OZHZpNjRvdG5o?=
 =?utf-8?B?ZEtndHc5L1VnaGg4YTZldkRnMTlGaCtUWW1vd1QwVHljbkxsbXNDeGp5YnhJ?=
 =?utf-8?B?ck04UDE5TGpJWitLd0o0MHVoNFdBL3JiZTBFQWpzWHFXeDFJdjFUT3lWSmdM?=
 =?utf-8?B?R3IwK09WeTRxckppdlFuV1QzbTh5VC9aY1QzUldkUWZoM3puTEFPQVRVaFpP?=
 =?utf-8?B?U3Z6eHdwamw3QVdiY3lUTFhIaG5TWkJoY2FQVWtCUms0NTJSbHU3bG1POE1L?=
 =?utf-8?B?Wld5THZxcDBPQkJ0Q1kvdHJVcmh3ekYyU0hmOEZqbEpFTkhlZFpTL1RpQnV0?=
 =?utf-8?B?Z3h0eDFVVW5nWjNzaktqanVYSi9kaE9VSGoyN21jaS9hUHFzMUQ4bDlDSnhh?=
 =?utf-8?B?dmlJVjl4aVBCdVEyRm5Wb2J0SHJTdXdxR1h2aEs3V0llZFlzK3ZER2ZUTVlv?=
 =?utf-8?B?WlJ0OGk5TmRLbnRKWWt3WFpUYUJhdXZQUC9MSzlPK1JzOFJLVzAxZUVKOWJS?=
 =?utf-8?B?NTVXZnk1OG1lc3pnTDdDVlg4TlNkOFpOanpWWlRkbEtVOEd1YlFIdnVZRG50?=
 =?utf-8?B?dUJORXFEdHpOT001NHA5TmMzYXR0cHFZMm1JbmhOV0k0MXhRMGZQMGd5S3d3?=
 =?utf-8?B?bStrSmwrVXBWb1NQWkZqVElId1JValBTak90WnFKQlZoWWpWV2RiTHk2eTNH?=
 =?utf-8?B?V0xQVzBab2FGbExodjNvczkyR0JvL3Fsd3hYK0RBMVlZR2pNWW51VCtMcEpV?=
 =?utf-8?B?SzFpOVRkdDFhMC9FOWJJcnViZTFoUklxb3dBVnpXbEl3cUJiZnBNOXk5UTRa?=
 =?utf-8?B?TXpRRWRLSzViZUZseEh3STVGajlCejN0c21pbS9mUlUrS1VrOGI0eWk1bGxL?=
 =?utf-8?B?aU05NUdGSFJQcVNuOE5lczFSNUljajNGSzVhTnE2QUhESXlXZjNlY3Zpejc2?=
 =?utf-8?B?QUg4N0g5M0libGRGMFRRK3M0TkZZM2xURWJQeFcza2NMenNOdVVmNUxMS0I0?=
 =?utf-8?B?VXNyWXRKNktJM2p1aU5XSmNFaHJlZERkd3BxSzNvMnRHNjRFbENCKzVoemVO?=
 =?utf-8?B?Y3JKTjJ5aXR1OWhlbUVDQ2hRTWpBb2oyR3RKdjlqOU9NNC9KUzJYYTN6MGhR?=
 =?utf-8?B?cXc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e84e00-077f-41b0-cc1c-08dd5fb682b1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 09:32:43.9619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33EVTlW8Ne7ZWU7MP+oyC1yIqoK6rEU2bj46V2RwWS1O+Di77FnrnsOF0UKjs+7I+fbXAd+ykxYSl5mKuuuP0MDEtVc30+n0B1ya/nnCztY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7761

On 10.03.25 2:21 AM, Dominique Martinet wrote:
> From: Makoto Sato <makoto.sato@atmark-techno.com>
> 
> If the requested rate is not an exact match of the integer divider
> phy_clk_round_rate() would return the look up table value,
> but phy_clk_set_rate() can still use the integer divider if it results
> in a frequency that is closer than the look up table.
> 
> In particular, not returning the actually used value here made the hdmi
> bridge driver reject a frequency that has an integer divider rate
> within 0.5% of the target:
> for 83.5mHz, the integer divider generates 83.2mHz (-0.36%), but the
> next LUT value (82.5mHz) is 1.2% off which incorrectly rejects modes
> requiring this frequency.
> 
> This commit updates phy_clk_round_rate() to use the same logic as the
> set operation.
> 
> Signed-off-by: Makoto Sato <makoto.sato@atmark-techno.com>
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

This looks good to me.

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

But I think we should also add the following Fixes tag:

Fixes: 058ea4a06704 ("phy: freescale: fsl-samsung-hdmi: Use closest
divider")

> ---
> We're finally using this rewrite in our (outdated) tree and noticed the
> "best" mode missing on one of our picky displays.
> It all looks good with this fix, thanks again!
> ---
>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> index e4c0a82d16d9ef0f64ebf9e505b8620423cdc416..91c4d27a31f48fc49f1e8417d7089f5519b8a0a2 100644
> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -557,8 +557,9 @@ static long phy_clk_round_rate(struct clk_hw *hw,
>  	if (int_div_clk == rate)
>  		return int_div_clk;
>  
> -	/* If neither rate is an exact match, use the value from the LUT */
> -	return fract_div_phy->pixclk;
> +	/* If neither rate is an exact match, use the closest value */
> +	return fsl_samsung_hdmi_phy_get_closest_rate(rate, int_div_clk,
> +						     fract_div_phy->pixclk);
>  }
>  
>  static int phy_use_fract_div(struct fsl_samsung_hdmi_phy *phy, const struct phy_config *fract_div_phy)
> 
> ---
> base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
> change-id: 20250310-8ulp_hdmi-f8deac08611e
> 
> Best regards,



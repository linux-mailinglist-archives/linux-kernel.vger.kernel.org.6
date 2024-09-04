Return-Path: <linux-kernel+bounces-315168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C5096BECE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8671A1C218B3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0681DA303;
	Wed,  4 Sep 2024 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="TwXM9Hc9"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2105.outbound.protection.outlook.com [40.107.22.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607611D2204
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457240; cv=fail; b=VZsy/xbYnkqdcrpNy7qjpTA4H3NA/0xkFZFQt0cGFW5fkbLQvK/bLCPYYrgV5Zn9F5UOLqxEvcNfIbLJbDtMjMZrT2yJyK0iAHUP81S32l4SCdwPYlMuYDKUH4tutGJX3aZ4h8i1x4jZcJ13s97a1m622aVLiwZkXkGP/oajVm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457240; c=relaxed/simple;
	bh=bn6dfKYZ08poNc8yXcJPlIQBC033xvj40Wa5G0ES0nI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ukvj2f+smzQEzFQ5Z1qV6cCg8ilxBLsNgo0Xhlwh/P1BXxWLwx2sNLzzwWQD+tXnJucephjNtHvXYPol8X7zz55TsgC1edbL0PGv5jslA1kPf8txU572DLy5fTP10rhx1c3hQ2eHMsqLO8VNAg2uumuBb/7VPa9e+V3y497BxSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=TwXM9Hc9; arc=fail smtp.client-ip=40.107.22.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8NahXtJvwzRWAEaEgzcvNYUncXEDbSuTWqBp5jvIvd8kngVn6GG++22pYvmBFak0l3Tt+jZlUioEnLv9oeDdBvSoOTnAjy6LVbDusyAeos94jep2bpiery/xykuXexg5cy8sXm9brumut9b9YDGl5w8dMi01zU+SxPLM+BpdL31Oron3xf86vNrzFrlYdkAy9NSNgDNSgQRGnaj3mS/3cv23rCYiJzw2wn3hWeUa6VlpGyvGiBLF/Vfa5hjiIP1xxdvU43iKZ4PH0lkFZwkBgstEnJyXVLRHBWCIBTwvILwsR2lKK0xGwgBedLofBNYLaHoaUEMkG3mm7CGQgTmEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvdSiHToPJ+ZG//uPw2nzizGJ8e/gqF/iTUSy1GAS0U=;
 b=vqwI7gG+GYYR0LV/rKcQ6yuwytDNEXxhMKLWNPqcrO/GrTLzwPTohvyUbvVYYMh8kdpnLbmcSxi6kyYbkclJOZbZ/u4p+qeVGluSMXGdrkreuLY1UVca6otoSyVzUCX8jLDyM8f7qbL52jE3kRpxBswl8JUjG4dilI5RYnPTIsN6xmmWfDCOR8L7DYoVF55diD/Fnldmsxa6jH7W/nq5bykW0HybdEgrNbsHiu6OLq106qeLFmFA7czjWAdoL4etMTGxc9TYANv7DOOdQwTXqYNX9x000Ih2o0AWsC8NAlDbaal9Mm2v6fWsiGcLLIpzvWCg4eNZDGyz79wFldJKVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvdSiHToPJ+ZG//uPw2nzizGJ8e/gqF/iTUSy1GAS0U=;
 b=TwXM9Hc9EBVlnbJbehTtMT9tw1hj5kBLIiPKy6uRg+B0fgyQj2fpS4GqpRK3+mWJiCjRRLvs2ANb5cptl3vUuAZTU9e5IiQmOaphGzAdeWyniuYKdPJFzwFzhbpmeiOUOBjeWgbOGZeQVJgoH1wdp1IoqPhA94AWRbpcMPsSlFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB6953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:414::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26; Wed, 4 Sep
 2024 13:40:35 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%7]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 13:40:35 +0000
Message-ID: <0a860fc7-14df-40c6-a92a-868568ae7a24@kontron.de>
Date: Wed, 4 Sep 2024 15:40:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 4/5] phy: freescale: fsl-samsung-hdmi: Use closest
 divider
To: Adam Ford <aford173@gmail.com>, linux-phy@lists.infradead.org
Cc: dominique.martinet@atmark-techno.com, linux-imx@nxp.com,
 festevam@gmail.com, aford@beaconembedded.com, Sandor.yu@nxp.com,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Marco Felsch <m.felsch@pengutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org
References: <20240904023310.163371-1-aford173@gmail.com>
 <20240904023310.163371-5-aford173@gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240904023310.163371-5-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::22) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: bd0a23fc-179f-4ad7-020d-08dccce72780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3MwRk5ZK3lvUDFPRGRvNHk5UFdZcmdvSktqMGRZUDdML1hYbjZZaHpSRmsz?=
 =?utf-8?B?ekJIZ0JkQ1REaXpsVGpUS1hwNXVBT1lWU2lWRUJsY3F2OFhEV0FJQTdpZ3g0?=
 =?utf-8?B?emQvRkcvWFUxWENtRitjN1JWZWtnNW9UQjRVSzJEMG95aTRETWVreUhGMUo1?=
 =?utf-8?B?ZVB3UlNWdlVEVnBzVGY1TmdkNGhaazhrOXd1YXhwa2dOZVdzdy85OG5Dczg5?=
 =?utf-8?B?S2lLQXBCcThucXJWODl2UnNiWEpneWp3MzZpYk0zV2wvZXNTQWdrNllCK2Qy?=
 =?utf-8?B?WllGSTRkVmNWcFB5VHV6ckJ6am91eEJXQW5McU9mU3RlRXRxTVY5QWg5dFlT?=
 =?utf-8?B?bGIxb0hPaEY3YkhJRE1pd1g4UFlXWFkxUzhSSW52Sm8xSmR2d2V0bEZkL3pU?=
 =?utf-8?B?Rnl2Rm9tbW5XS3I1SWNLRDhrbkJhbWMrQlN4TU1MV1c2ZjVYUDZkaDlQSW1o?=
 =?utf-8?B?WW9LZ1A2cHhxcEtOSjV5Q0JBTEthdkNOOW0xSFZ6dFNYY3pscXJKeGJadVFt?=
 =?utf-8?B?NjdRcEY2bU8rSXpaV3JqMzE5bjJYN2JVc0NHWGc2bm90Yy9mc3o5NW5iV3Zp?=
 =?utf-8?B?WWR1bkdVelBHT21kWUVmZng3ZTRCNFl2YmNLd3hsUkdQU1BVV09OOGlwWStM?=
 =?utf-8?B?N3M0czRNdkl3Z0tWWFJyek9KWFQvMWMreGZ2bzlUMDc1ejc2RmFadndZVGVx?=
 =?utf-8?B?RmwrdDBGT1gyQThiYUNiVytSU3c0aGFldVdhTjNXN2JqL29taDJQRi9QS0tI?=
 =?utf-8?B?NGh2SEhRUUVLRXkvNmQvSkFKUm9XMTFMZkpvME9SclJrM0phd2RTUjF2Y1dv?=
 =?utf-8?B?dkVpK0FGTDVKRjBUSFZJYVJaSHl4TkNFQVNnS3BpbEY5c0ZIYzRZZW5JQVk2?=
 =?utf-8?B?M2JpbWpuTEtNMWJsSXhXSTZOa1k3M2hJdTRxZS9qSmpNYzFlMGE3VzNhMWJC?=
 =?utf-8?B?ZmtWUkEzZXF4dEFTTTZDcCtmemxpbHRCS1JPa0ZRM3hpMjJPeERMYnFLNmhH?=
 =?utf-8?B?QVlvUGdtUkZTNlFEYW1LNHdRYU5VYjQ2UUNaZ2t3Ry9ZeloyenJtczR1eUNP?=
 =?utf-8?B?cmxudHhHNmY2TkFrLzdrTEZTR0ptR1MzRVo1blZtRmJYNzZzQ1hhVUdjN0tJ?=
 =?utf-8?B?Rkk2SGplUzdzMUZRdXQ3a2x5ckQ5VC9NRjdhNXVyYXEzd0ZRVXcreXgwc2tT?=
 =?utf-8?B?bUkzckUvYjBhVVF1aDRNMnAvWEtRZU5hcmtaYVJWR0tzNi9ibzRHS2ZiWkhI?=
 =?utf-8?B?bjcxVFg4T3RqM3NDdXVNdGs4c3JZeFFEM1FVVDJGTGZzenFpNWpVUTYzb1hF?=
 =?utf-8?B?Y2RHdUViUStvSkwreFpZTDhqQm1DL205S3dOdlgxZCt2cEZ6aEpHemIxRERP?=
 =?utf-8?B?bXpmc3Q2c1NOWUU5STNVT0RnQ245TU5RdUhVYkpKb0JIa20vTE12YmlUM0xS?=
 =?utf-8?B?d29Ba2FxYlZtZ0hONnk0a3FCbUpYOThTaG1jYy9xR0FGazk2Nk1ndGZmeVBp?=
 =?utf-8?B?dWVKd1RrVFdIODJDd3QwbE5mQkk3MUFuRCt3b2ZqemsyT2NtZmpIdFduY2Rl?=
 =?utf-8?B?cFZHenJQaWF1cndwNTRUQU9Vbzk3T2F5SjJvUGEyYXYrNi9DQjBkdlhBaTNv?=
 =?utf-8?B?dUN0RXB2dnVJVEwvejNoRzlrWVJSUHE2N3FFR2ZVVnJQZkc0VitBa3FpZ3gy?=
 =?utf-8?B?NTlvQWcrYm1EVWxtTm5ZcmlVcnVCWEI4TG9vdWtQVER5alZXNktYdW1LdGRi?=
 =?utf-8?B?QUttcXByUVg1VUtPeC91RTFmT3Znb3ViYUxxekVmOEVxaGhJbVFYelIzcWIv?=
 =?utf-8?B?a2EvVFBkMzFQYUp2QU41dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cE4vL2pDOEU0SFBVRGlaOTk0cm44VnlMcG1YUi9ybGJ3VWRtT05BN2VmZmFL?=
 =?utf-8?B?MWp4ZnFiL0M1ZWtVWmx0N3Fndy9FY0NqL3VsbXJFc1pDcHlJdE9MREcvTlJz?=
 =?utf-8?B?Rnl6Z1JXT09mek84OS9ydU9NYW1aRWpXWVNQa1JXbEFPdnpqVmY5S29VaGVy?=
 =?utf-8?B?a2tielNzc1pOT1k4TWlLNmpWSUVzUTB3dGQ3WDMrL0k4VEVwZXZCMlhyb0ls?=
 =?utf-8?B?dFhLZEZqL2M0VW56ajBDVUh0d0xWQkZKOGh6MkdKZDFKdWdHZ3YvbDc2WVRo?=
 =?utf-8?B?cVdWZXNYQkJvWUNRVnRmN0RuckJ1VVI1TXQwTE5UdUpsSEZKN01nNEQxWmd6?=
 =?utf-8?B?SFEwcGtTVDR3RFFUUWk5TFIxZG5URVhWOWlMYldsbHFlLzdtaDFzRkdaeGc1?=
 =?utf-8?B?TW5ISmdQcjVDeCtYait5VEdDM01mYm9KUE5ubXZaMHVMdWxLTjVUY3B1RTFU?=
 =?utf-8?B?YXp4QmhjVGlZd3NCSVVnaFNpT1lJMmtXRDNKbi9uUHBBTi9QYzJ6RXMvL2g2?=
 =?utf-8?B?T1pCZUlzU2R3M0wzckhEenFNZEN2a3ZzeE14L2FQUm0rdk5KbUVyanpYQ0RR?=
 =?utf-8?B?UEFkR3VOanFjWnA1RlBMb1FlK3JRcm4rZXVwZ0NCTE5BTW01VjdqaG12U08y?=
 =?utf-8?B?V0NlWlkzTVpLcWo3bS96dWdtK0liNVhCN3RHRWZySFpYamE4YkVISEtSQW5j?=
 =?utf-8?B?SUZaT2JrUHdmS0JYZ2NTVmwxWDV1dzFvbXhVbUhtOVZ1LzJyZStxSUZNNmti?=
 =?utf-8?B?QW1OOWo1ZGRLR2tVVkdsR3pEWmZrbUxySEltMGdrS1JoUlluNjJOWWl1YlM5?=
 =?utf-8?B?RUFMMS9FYmxXZFhIRTNUb2RGNTR4ZDJ0WXJocExwNUhMWUtjNE5DbWVvWEIy?=
 =?utf-8?B?Tnc0dXljeWxTcDZHempkK1RDNk9JLzdvV0RhQVJqQis2T2N5VGsycWlsa2Jz?=
 =?utf-8?B?ajB1VFBRN0tlcU02ei9wZXRzd2tyQW45cE9vNGNPUFpFR2ZLZEpUL3lSeVRJ?=
 =?utf-8?B?UUFNckRGaVFJa2RZOFpjbXhTSENhMzk2OGJRUUEvUzJKc1RhamZsdXltQ0ow?=
 =?utf-8?B?NDFaV0JDNVAyWE8wTXFKK3BhbkxJbENuNE45Sk1CSHRFUHVwVmJwMktoV1M1?=
 =?utf-8?B?eGVEV0pwNnZmMnJ1TTV4Mm1qbkFaZ0pMNG15VXFkN1NqdDRudzNOYjFpQkRU?=
 =?utf-8?B?VWtNSkd5bE8zQ0pCN21PQW1Edk1hQkJHVGY3N1p5T2RqOExWMkRQLzdYK0kx?=
 =?utf-8?B?MkZaMW9OVE1Pd2JOYmJwNkhMeTNxNER0K1BaTHI4MnpRT3hreWtHYTc2Zmsr?=
 =?utf-8?B?Ly9RODYvV3ZmOFVETE1zZTlJYVZhTEFkN0Qxc1Zsb0lqRTh3cm82bGZlSk9I?=
 =?utf-8?B?V2d5eC9mclVnYVE1ZWxpRGZ3WDdqbFVRUW1nVHB3UjFHaWd0STRVVkpLYUVi?=
 =?utf-8?B?NFBXSnNvc1JDdFBJZ1RKU0gyTlBneXY1eGhwNEFjcU54YWExQnN0YmFtMGxl?=
 =?utf-8?B?R2ZZZ3RPZjd5dm9IT2VvTnBJeDJZVG5zYkRORGVKK2lkMzYxR1M2YUtYMEt6?=
 =?utf-8?B?blVWUXIxSU5BZHVmOXU3V2VNODQrN3pDek5RZDF3bGl3MjVDYmlpeXAxOU1Z?=
 =?utf-8?B?Y0YwT2IyWTdGckUxMHhkMTI5MFljTkxrUlpXTUxtQTV3S210L1M4Vkp0OTAz?=
 =?utf-8?B?cG5yTzJZQTV0ZC9Sa1hySmxVb25ad0ZFcjJpelIvdjNoTkNCZzByTHZOTkR1?=
 =?utf-8?B?R1FkcndTV2h6VHBVVmpSKzRFdnhPMHllYzA2c0ZIK0t1VnRGSGFBaW9XMGRj?=
 =?utf-8?B?VUNOcnJCVzE3NExGMGl5blIvTEduNXM2UlFOaGYxaUllenFGeEZGVWtuZ0xE?=
 =?utf-8?B?dFAxNksrY2c3QUlkUWdiRFcxR3NrUGxGa0w5QjF3UE5sZ1pzdUpWMnF0a2VS?=
 =?utf-8?B?dytqU2Z1ZmhIdG1xelBjbytGOUMwSlYzaWNud2w2Nm1udnIzMjRKaklydFRM?=
 =?utf-8?B?SzErU3p2cEVCZU9qcjF1UGt6S1hyckxnaVZLby9nTUM3Y1ltWDlpQWUzdVdx?=
 =?utf-8?B?RDR6Mml2VkphOE1CZnBYNDFrSHZBbDdqd2oyM0RxcEoydkRwa0t3MStQTlR1?=
 =?utf-8?B?SXJEbFhWaDEyMkhqRXhOTi9VYXIyaE5MelJGMlcydEkrVlg4S1YwUVprck1M?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0a23fc-179f-4ad7-020d-08dccce72780
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 13:40:35.2790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nUFFZOS8JN8Z4o/xsRn5yrrNCNNIUrGXuzkYMK3HDj+ggiyVGLB8WkAw7Jz7Lpn7J0boZOH1YeUrLdheGfn/zbrAX9o1cV+kBjemXg3/cQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6953

On 04.09.24 4:32 AM, Adam Ford wrote:
> Currently, if the clock values cannot be set to the exact rate,
> the round_rate and set_rate functions use the closest value found in
> the look-up-table.  In preparation of removing values from the LUT
> that can be calculated evenly with the integer calculator, it's
> necessary to ensure to check both the look-up-table and the integer
> divider clock values to get the closest values to the requested
> value.  It does this by measuring the difference between the
> requested clock value and the closest value in both integer divider
> calucator and the fractional clock look-up-table.
> 
> Which ever has the smallest difference between them is returned as
> the cloesest rate.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> ---
> V5:  No Change
> V4:  New to series
> ---
>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 40 +++++++++++++++-----
>  1 file changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> index 8f2c0082aa12..56b08e684179 100644
> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -550,7 +550,7 @@ static unsigned long phy_clk_recalc_rate(struct clk_hw *hw,
>  static long phy_clk_round_rate(struct clk_hw *hw,
>  			       unsigned long rate, unsigned long *parent_rate)
>  {
> -	u32 int_div_clk;
> +	u32 int_div_clk, delta_int, delta_frac;
>  	int i;
>  	u16 m;
>  	u8 p, s;
> @@ -563,6 +563,7 @@ static long phy_clk_round_rate(struct clk_hw *hw,
>  	for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
>  		if (phy_pll_cfg[i].pixclk <= rate)
>  			break;
> +
>  	/* If the rate is an exact match, return it now */
>  	if (rate == phy_pll_cfg[i].pixclk)
>  		return phy_pll_cfg[i].pixclk;
> @@ -579,15 +580,21 @@ static long phy_clk_round_rate(struct clk_hw *hw,
>  	if (int_div_clk == rate)
>  		return int_div_clk;
>  
> -	/* Fall back to the closest value in the LUT */
> -	return phy_pll_cfg[i].pixclk;
> +	/* Calculate the differences and use the closest one */
> +	delta_frac = (rate - phy_pll_cfg[i].pixclk);
> +	delta_int = (rate - int_div_clk);
> +
> +	if (delta_int < delta_frac)
> +		return int_div_clk;
> +	else
> +		return phy_pll_cfg[i].pixclk;
>  }
>  
>  static int phy_clk_set_rate(struct clk_hw *hw,
>  			    unsigned long rate, unsigned long parent_rate)
>  {
>  	struct fsl_samsung_hdmi_phy *phy = to_fsl_samsung_hdmi_phy(hw);
> -	u32 int_div_clk;
> +	u32 int_div_clk, delta_int, delta_frac;
>  	int i;
>  	u16 m;
>  	u8 p, s;
> @@ -602,19 +609,34 @@ static int phy_clk_set_rate(struct clk_hw *hw,
>  		calculated_phy_pll_cfg.pll_div_regs[2] = FIELD_PREP(REG03_PMS_S_MASK, s-1);
>  		/* pll_div_regs 3-6 are fixed and pre-defined already */
>  		phy->cur_cfg  = &calculated_phy_pll_cfg;

                             ^ unneeded whitespace (comment belongs to
patch 3/5)

> +		goto done;
>  	} else {
>  		/* Otherwise, search the LUT */
> -		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider\n");
> -		for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
> -			if (phy_pll_cfg[i].pixclk <= rate)
> +		for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--) {
> +			if (phy_pll_cfg[i].pixclk == rate) {
> +				dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider\n");
> +				phy->cur_cfg = &phy_pll_cfg[i];
> +				goto done;
> +			}
> +
> +			if (phy_pll_cfg[i].pixclk < rate)
>  				break;
> +		}
>  
>  		if (i < 0)
>  			return -EINVAL;
> -
> -		phy->cur_cfg = &phy_pll_cfg[i];
>  	}
>  
> +	/* Calculate the differences for each clock against the requested value */
> +	delta_frac = (rate - phy_pll_cfg[i].pixclk);
> +	delta_int = (rate - int_div_clk);
> +
> +	/* Use the value closest to the desired */
> +	if (delta_int < delta_frac)
> +		phy->cur_cfg  = &calculated_phy_pll_cfg;

                             ^ unneeded whitespace

Are you sure that this is correct? The calculated_phy_pll_cfg is only
set above if there is an exact match for the integer divider. I don't
think it contains the data you expect here, or am I missing something?

> +	else
> +		phy->cur_cfg = &phy_pll_cfg[i];
> +done:
>  	return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
>  }
>  


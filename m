Return-Path: <linux-kernel+bounces-567508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0158A68731
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3A5C420AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AA72512EA;
	Wed, 19 Mar 2025 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="Wr4yzxWV"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2095.outbound.protection.outlook.com [40.107.255.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891541B3937;
	Wed, 19 Mar 2025 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742374026; cv=fail; b=Fdr4QD1Bq/sDQvJ031xlD72/7zw5s/m42lHqzIsJPEwTh+FJ+EqSzUbIjEUipP3Od70glkbTmhTEq+8K5tsExaF083pGC4jq2MbtBEuXtKpnyRm2cFCXnaYK7MNztVhgTbOLh3hgJ0g0lybHwI9PDVCYP4TO6TJWeT9NN6NpvPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742374026; c=relaxed/simple;
	bh=7adAUA4ZHh+qOMdw04V0JcsPMR8WCMUiTp65J6laHmU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DjLXeLaOi/SN9MYGLx9MRiM2oyPyIuF3tNagTB3IVUI7gPMoWyqBtGa/JCEW3LYLyYGDWyAelGTey1e6NcuwB0uwmz/zvROiJt0Q775wFDsGMOCaLkO42N4/oWRi8k2GqNdkQUdXD8QPA/VRMkfSq3EWKnkcXYPQ1XCN9/4VdOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=Wr4yzxWV; arc=fail smtp.client-ip=40.107.255.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnIHq3ikBCARhw5QuI4U4yGe3yewM2bhEdFajls5t9+vfINhddkrL+DPHoF3DOnDTzztiEhLO3xjefSQq/O6OebFxuzGZIn+a0cu0dfqSijhkoD/mrWBRtnaDbg3SsamSYn+89j9fqZmiesMJ2IGDrrbLrNJYqjGlfgbuoz1MdHVz44+ccomL0xQJtG7jhP9cXnBh+Zae9CFqY+UrAn95t/AjK0iO5X7lseNhM5AfJbY+be6xGEdTMlxm0KHpIm79Cbt367/daeZxELhLqMi2fHDnm3YGTrmrS/w9+uulQuOejkaHwIrWCCUHu4820VkuttO9EoNRbwH4t2fRnGn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ib+3v0DsSjyp0ngUbIrBJjY47A3I7XSXLz/rIKT0B/s=;
 b=cl3AMl7Hm2ubIP64xVPlgeNbdAGviOYWL4GqFfCmZ/wE9xZRhwDnjbFGa6JZ1FqIvhbBDXXEV/0Xjc8iVtESb3Yxo8auOdxIR4aMKyzIYWDnyuWjImWmbR7ons34se72hlQ0MG9BfyqpfDYGqoHTpQ+GIiOP5rVNp1C7a8GtOvP3F8QDz4tleWi9HppvdDI+k+GoqPuHCbG0OLTd58jQVQBQ8XOmbx1GY/MDdQQFh2ACdqnXsO9iMWARYkYNwr+nJdJpu6uOaJ/H0iV1/1kxmENloRLQP2ir5JKeOjiLvFyB7rNlmMddUY8gqMwk4RZBZIpN0EZifuuXbzuQ0GcXHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ib+3v0DsSjyp0ngUbIrBJjY47A3I7XSXLz/rIKT0B/s=;
 b=Wr4yzxWVnYwAcifla6OTTfJxR5puBJr+Tjn2+4JVm7kywK7LT4nlHYsGrUcw1d2sR22hexfjYnX2oN5WLvIRxQq3dVFUuiV1e2ndpum0XRQeOw/yQhGH9zvqdJX2tJDVlhpIqXTtIdLm15nhNsEKjoZAeycQX0W9BDrrboJtY0VnnRZKwcFy5nnZxU92ptysGM3199E1MfYp2ob7cHikWN8YL84Rl95iEbtwdGkbK1Dt9sAt/mAcP4HyXs/6vFa2tMNKGYNrLQbNdjV4R2lJT86r396ULXpeJz7f5imz8hlcJN0h8XSGGFBh4T8ssI5DYj2aYj1YokpmrIlS4SobKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com (2603:1096:301:113::15)
 by SEYPR03MB6698.apcprd03.prod.outlook.com (2603:1096:101:6b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 08:47:00 +0000
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d]) by PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d%7]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 08:47:00 +0000
Message-ID: <6c1ca29e-37e4-488c-b3a3-f61aad7f8dcf@amlogic.com>
Date: Wed, 19 Mar 2025 16:46:53 +0800
User-Agent: Mozilla Thunderbird
From: Jiebing Chen <jiebing.chen@amlogic.com>
Subject: Re: [PATCH v4 6/6] arm64: dts: amlogic: Add Amlogic S4 Audio
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 jian.xu@amlogic.com, shuai.li@amlogic.com, zhe.wang@amlogic.com
References: <20250319-audio_drvier-v4-0-686867fad719@amlogic.com>
 <20250319-audio_drvier-v4-6-686867fad719@amlogic.com>
 <20250319-quizzical-coyote-of-assurance-d4c91d@krzk-bin>
In-Reply-To: <20250319-quizzical-coyote-of-assurance-d4c91d@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0203.apcprd04.prod.outlook.com
 (2603:1096:4:187::22) To PUZPR03MB7135.apcprd03.prod.outlook.com
 (2603:1096:301:113::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB7135:EE_|SEYPR03MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d468ac8-f142-44f2-42c0-08dd66c29cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUpiQnVpVHRFTDFUbUJmQnF3Q3ErWUI5NTcrenNjeldmTk5ucFAyU2NWZFRP?=
 =?utf-8?B?SGw5eWFtU1U2Z3R3Q0RJR2pDMUJ2eklOdkVRcGV0ODQyKzV6SzBQSmxGakZO?=
 =?utf-8?B?dTBDdlpESUM3cEUrVnFuTXUvY0ZzTGVhdCtHUmpzQU9yaDhjRnBtalVCUkNi?=
 =?utf-8?B?WTRtcE9jclk0clFpSS9jUWZwdlA5dnhyUWZ4TVIrUERXUmE3RVovRDlLZUhP?=
 =?utf-8?B?TEpEVlV3NmJmRGZhSzVaZ0VpVWthbDc2amJnQU9ZenJkbmRXMndUVVNqYTBo?=
 =?utf-8?B?dWFuSFUrM21EK2l3ejlGRUFDZDlDWGdaanBURlBDcWFDZXNuNDFTcEdxNUhp?=
 =?utf-8?B?SjBscGltY3RDWEhZRnZsUHlmWCtvK2RkZUFCUFFWV2VNT2RIOXRsQ082aDFF?=
 =?utf-8?B?U1pBWjY1RTRpT3hwbWhDRUl2S0NNVU5QQ0phcUxIaWxIdkt0Zm9qMTNKelF4?=
 =?utf-8?B?M0VUQTQwU1h6bEV3ekxJR04yYmJ4ZFMzNmhFZXI1OFE5cnJDV3pPRDRiSnJZ?=
 =?utf-8?B?c1RNVVNzUWxIeTN1VTRzZEpBamw4eTMyL2N4My9LR293NlVnemRPd2ZxaTVt?=
 =?utf-8?B?amVoYzV2YUN0Nnc3RXJCU291S3V3ZWE4TnNQN24vQ0d6MUdLUFh2ZWFPbmkv?=
 =?utf-8?B?d25hOHBteGZ4dUpSMitiREhXdnhpQ0EzakZIQTl2ZTNnN25WRm43Z3BVYjVr?=
 =?utf-8?B?ZE1xQU83aXE2SWYzV2tRK21adFZQVm1CWTREbnZocm9GcGZpQWZlMndDdmNX?=
 =?utf-8?B?eStQYVlQZ0FhUmxOVmgrcmg2cDZSUkZBTHVITVBTQWxxRHhjbVZzVDkxelpB?=
 =?utf-8?B?OVpjLy9rS3RwbXNCOTZDdXRCcllGaHF1V09MdEFMSW5PVlYxbC9rQ1lNZDlu?=
 =?utf-8?B?MTBYcXNUYnlQVzhaWXlUU0lRWjhVNHV3L1NCc21JbjJjSjRpN3pCaEZPeTFk?=
 =?utf-8?B?d24yVnFFeVBGYXk5aCsvUzZEdEdQVk9PZDZjUktNVzRMMFIwWjNGWUx1U1Jl?=
 =?utf-8?B?NmRzNFZKMHl3NVlXRW5rRmR4cUx1a0hXYlVYYmlIbTBucC9qbUNMRXkvcWlU?=
 =?utf-8?B?R1ZWMEpJNHh4MVBQa2ZZRUtvdUFMdVBteGlQS2Q4eG9nWWVCN3RvMVM3bkEx?=
 =?utf-8?B?cmtlL1pvTGNOT3VTcEVGdC94V3pBbkpzdTRnSTNUZkJnSmxXWGVoY0kvMVpS?=
 =?utf-8?B?SkhrSkV3K0RZcStoMXE3S1RyY2JWVUUvdUxhenJSVDlxQWtxVUlzbExLVUp6?=
 =?utf-8?B?ajlyV1JBSDY2dGgxczNoNWFxYWxqZ0gwdG5JUE5OK3JRMjkxQUVBU3BteU9n?=
 =?utf-8?B?bDNlT01WL2RyNXpaQW95TFhHaUkxWjJMenpkSktEUnBuOE9OUW40N3M4RE4r?=
 =?utf-8?B?NllGY1NQblRSd1hwdC9KY3pyL0hvRkRQcjkwUGdGdTJmQkN1WGtDU0R2Nm1Z?=
 =?utf-8?B?dHhZMHhKWHovSkFkU3pPRm1FS0ZUUk4rUGZ5UEt6YldaWFFDN1g5cjZQb2Zn?=
 =?utf-8?B?dVJCZWw1SVZ5bUFPTThjZmxLSHdrZm9BYy9PZXRhKzlGaEhWTHBNYmxneXdt?=
 =?utf-8?B?bytnTVhRcUlJWlljd0pxdnl5SWNMWmJpRjRvdWNrZlZWbktmSXo2ZHh3V0FZ?=
 =?utf-8?B?aERZcE5MT1QxaSt5SHBXbTI5R0E3S29UVHJLVWlFeVNaN0tCL0ZKK3p3UlVS?=
 =?utf-8?B?eVcxeTdsaUlOa3hxeGV1bkV3M25vWGg2aDZyeE5FWlBKOGR2cUlWbHVYOFN2?=
 =?utf-8?B?bUtveDNWMjlFc2ZSYzNMRHJpQTVENElCTDhsWDdCYmd4T3F5VVZWT1VzMzY2?=
 =?utf-8?B?TlJIUGtZWjJhNDc5WElLUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB7135.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2FuMmpqbC9WL0oyV2tEVW1LYWhMdzJsdU0vZ2FIRkd1T1JqMmEvYnVMd083?=
 =?utf-8?B?UWdQOGs3NzhZWnVHMHpxUVp1THRFVnlFSVErbVBNYkhvSTdRUDlqV0ZGRXRJ?=
 =?utf-8?B?a3NqaDk1bGRiNC9HMEYvelN4SXdyL01POU9NeW9CZms2dDNOd25uRll3TnZu?=
 =?utf-8?B?TzFpSXFNcGdrbjh1R1VWNVRjOFF3M0ExeEVjLzBDR0lhUzV4aFdzbUpPckVa?=
 =?utf-8?B?cjFndlhRaHkya25hT1RzcWt4ZzJ3cW0wZlhIb0c5anB1TmdHcHZ5aEhkZzhV?=
 =?utf-8?B?OHBOU0xkMll5ckpyaDN4S0NpaHl6QTVTaG5NdTJld2RCa25hQlhGSFBWTWZ2?=
 =?utf-8?B?bC9VWUxDZWlWeWdrcm5BUWlKQWN3enJpc2pRUlhIL1RMSWdWYWZkOWdoMG8r?=
 =?utf-8?B?b2tWcGdnS0JKUUsxSVR1OUs4YmM0RURDZ3VTcThwTG9UZmRxWFJwSXNTWk9j?=
 =?utf-8?B?eXA4Z3REQkJ6SjNRQ1NvZFNaTlI4ZkFUb0pSaEVPaWI0ZmRuSTZuS1FvcTN4?=
 =?utf-8?B?SzYvS0d0YUVMRlN6TWRCL3lWWGU3cmc3YVVkRy8wdVQ2ZlFwTVovbVlCUmkr?=
 =?utf-8?B?QzNzaGdKQkxPMXc0RHR0NDRBZ0ZITzdLTUNLZ0IwQWN6SDZTQ2ZyZGwvZmRQ?=
 =?utf-8?B?dFRxUGI2M0xTNkVRMDFWRzlralBPMEtNeEhPQVZML3RLNUh6ZU9ZS2U2eFph?=
 =?utf-8?B?eStkSUtXeEdHSWo5V3BkQ2gwR29FSHpmdk0vdjYvZ1J4Z2FVTUdpTU5oTzFx?=
 =?utf-8?B?OFJHcEpGenoySndiS2pxNklPK1EzY3psRDRBeTVKM3ZVeW00U0xWWnE0WGN5?=
 =?utf-8?B?R1lsY2RIZklVZ2pFdFFOWlI3MmVta0VGY2lyQy9GdDlUOXhwdWlpbytRbHhH?=
 =?utf-8?B?UnpkVDZEcm1RWFlaeE5XVnJXN1VsdVluYmNUUkpmcXhXSEJjYXcyWUxSck5X?=
 =?utf-8?B?YUhoa0lLYlFHdlo4WW1XYVRqVTVNQ2llRkF5VHN2SE4veTU5K01tVGgvYm56?=
 =?utf-8?B?Snl0UXIrbmZTK2NKSmxXU042aUZ3T2ZianFGM2I3dG5iQ0FyRWNLSGJIanQr?=
 =?utf-8?B?ZzFBOHA4WVpMNGJaTFZWRHkxT3l1ZC9kbnhraEFSSlJ4dURJUmxUZ0V2MXdr?=
 =?utf-8?B?aDF3Q05JKzlMY2JhL2ZnNmNyUEhjVWd2RS84RmkvckdESnRKMjQ0TG92cGZU?=
 =?utf-8?B?YkhXb09nTjAxSmFCTHl3Rks3YkVjT1hFem51NVVhY3dreDBIMUF3VWxHSW9M?=
 =?utf-8?B?SEpmakFGaGRHeWxWZkNpSFlseTYzZnFPN2NEcytIczV0OGhZOS94WjAwWXhq?=
 =?utf-8?B?RUQ3WC82V2xFYStZbFBYQlY2RTFtS0o4ekowMlcwWFp1NUJhSEtQblpacGZR?=
 =?utf-8?B?WGpnWDRHbWxEcXI5cEV3RkREbzRZOXhPT3ZSN3dac3kwcGlqbFVzRDZ6blBt?=
 =?utf-8?B?V1pJTmhQVDBNdHhkUEErYTh0MCtDL3dIbk5YbjZzNDJWcDJtRlZJZG5Lbndy?=
 =?utf-8?B?ZW56SUV3TjB4OFVpNWh6MGxkU3R6UlFlY1c4d1hxcmFLVG1YUUhzVmpUVWox?=
 =?utf-8?B?a1pORzhMeHR4Y1BjcWtSaEYwNTZFd1hGR1ZCU01kdUdENnRPY3duenpKSWcr?=
 =?utf-8?B?RzVURWdhaExGeDVXOHBMSUR6S1VjUFVCVUlrZEoxVU5XYUU0ZE5jQ3hBWTVn?=
 =?utf-8?B?UEhHUVZ3UEFTNVZuN2w5SFNtQmtNZ3I3c2p2Tzh3MEtDMUI1QkllejVjVnB4?=
 =?utf-8?B?cFBrcVR4VkhveEN6anJnK1U0cE1taDNReUw4UzdFK2VVanRLbUh2U1VVUGJq?=
 =?utf-8?B?L045MmhhdjNtR3ZhbGZrUkd2WTlZZGlRNCtveGljT3VpdVpuSlNUVE5qWk9p?=
 =?utf-8?B?dFBROVR1TE1BQmlTbGppTy92UnVsTm82Z0RFUXd3MG5DS1BBUEFITlVUVFpM?=
 =?utf-8?B?QUxNcXVrd25iUlpVK3BvYVpleHRmUGtkMm5qS2NvNGZZTkR4T0pKU1RLZFlT?=
 =?utf-8?B?SUt3MmY3d09hejE1R2Y4YmhidGJXdlplUE1XMFdmZ3k1cWJ1YUtVek4yb2Nt?=
 =?utf-8?B?R2Y5Zmg2K2NndFQvWXRUN2Joc1NlR0ZDVlI1d3NjSndLYno0ZVY2NVF3bVhp?=
 =?utf-8?B?Wm43ZlExU3JkT09VR3FsSFYzUE0wRXpaMzZERENoZnZpUENmTnc5NHROS0ZM?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d468ac8-f142-44f2-42c0-08dd66c29cbc
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB7135.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 08:46:59.8806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RSjAJT/U/cjycWChDUWGdRL4zf++fhFF0s4QcAmMWblXY9kdyYwXLDGxzy2NOac97pDZIeB25t4WBlmIPWBVD81h3ywn62Uo5burJQFBNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6698


在 2025/3/19 16:26, Krzysztof Kozlowski 写道:
> [You don't often get email fromkrzk@kernel.org. Learn why this is important athttps://aka.ms/LearnAboutSenderIdentification ]
>
> [ EXTERNAL EMAIL ]
>
> On Wed, Mar 19, 2025 at 03:04:49PM +0800, jiebing chen wrote:
>> Add basic audio driver support for the Amlogic S4 based
>> Amlogic AQ222 board. use hifipll pll (1179648000) to
>> support 768k sample rate and 24 bit (s24_le), 24bit sclk
>> is 48fs, use mpll0 (270950400) to support 705.6k sample
>> rate and 32bit, use mpll1 (338688000) to support 705.6k
>> and 24bit.
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
>
>> Signed-off-by: jiebing chen<jiebing.chen@amlogic.com>
> ...
>
>> +
>> +             dai-link-12 {
>> +                     sound-dai = <&toacodec TOACODEC_OUT>;
>> +
>> +                     codec {
>> +                             sound-dai = <&acodec>;
>> +                     };
>> +             };
>> +     };
>> +
> Do not add stray blank lines.
>
>>   };
>>
>>   &pwm_ef {
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> index 957577d986c0675a503115e1ccbc4387c2051620..83edafc2646438e3e6b1945fa1c4b327254a4131 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> @@ -11,7 +11,11 @@
>>   #include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
>>   #include <dt-bindings/power/meson-s4-power.h>
>>   #include <dt-bindings/reset/amlogic,meson-s4-reset.h>
>> -
> Why?
>
>> +#include <dt-bindings/clock/axg-audio-clkc.h>
>> +#include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
>> +#include <dt-bindings/reset/amlogic,meson-g12a-audio-reset.h>
>> +#include <dt-bindings/sound/meson-g12a-toacodec.h>
>> +#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
> Old style was correct.
>
>>   / {
>>        cpus {
>>                #address-cells = <2>;
>> @@ -46,6 +50,36 @@ cpu3: cpu@3 {
>>                };
>>        };
>>
>> +     tdmif_a: audio-controller-0 {
>> +             compatible = "amlogic,axg-tdm-iface";
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "TDM_A";
>> +             clocks = <&clkc_audio AUD_CLKID_MST_A_SCLK>,
>> +                      <&clkc_audio AUD_CLKID_MST_A_LRCLK>,
>> +                      <&clkc_audio AUD_CLKID_MST_A_MCLK>;
>> +             clock-names = "sclk", "lrclk","mclk";
>> +     };
>> +
>> +     tdmif_b: audio-controller-1 {
>> +             compatible = "amlogic,axg-tdm-iface";
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "TDM_B";
>> +             clocks = <&clkc_audio AUD_CLKID_MST_A_SCLK>,
>> +                      <&clkc_audio AUD_CLKID_MST_B_LRCLK>,
>> +                      <&clkc_audio AUD_CLKID_MST_B_MCLK>;
>> +             clock-names = "sclk", "lrclk","mclk";
>> +     };
>> +
>> +     tdmif_c: audio-controller-2 {
>> +             compatible = "amlogic,axg-tdm-iface";
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "TDM_C";
>> +             clocks = <&clkc_audio AUD_CLKID_MST_C_SCLK>,
>> +                      <&clkc_audio AUD_CLKID_MST_C_LRCLK>,
>> +                      <&clkc_audio AUD_CLKID_MST_C_MCLK>;
>> +             clock-names = "sclk", "lrclk","mclk";
>> +     };
>> +
>>        timer {
>>                compatible = "arm,armv8-timer";
>>                interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> @@ -101,7 +135,6 @@ apb4: bus@fe000000 {
>>                        #address-cells = <2>;
>>                        #size-cells = <2>;
>>                        ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>> -
> Why? What is happening in this patch - why are you changing so many
> other pieces?

Hi, Krzysztof

for last versions ,it it not match the amlogic,axg-tdm-iface.yaml

so we must be change the order, otherwise a warning will be thrown，we 
copy the dts config from merged dts

the old order not meet the dt-binding rule, Another change, we only add 
the audio clock reg

+ compatible = "amlogic,s4-audio-clkc"; + reg = <0x0 0x0 0x0 0xd8>,

add <0x0 0xE80 0x0 0x10>;

We have not made any changes to the rest


arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-0: clock-names:0: 'sclk' was expected
         from schema $id:http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-0: clock-names:1: 'lrclk' was expected
         from schema $id:http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb: audio-controller-0: clock-names:2: 'mclk' was expected


>>                        clkc_periphs: clock-controller@0 {
>>                                compatible = "amlogic,s4-peripherals-clkc";
>>                                reg = <0x0 0x0 0x0 0x49c>;
>> @@ -134,6 +167,17 @@ clkc_pll: clock-controller@8000 {
>>                                #clock-cells = <1>;
>>                        };
>>
>> +                     acodec: audio-controller@1a000 {
>> +                             compatible = "amlogic,t9015";
>> +                             reg = <0x0 0x1A000 0x0 0x14>;
>> +                             #sound-dai-cells = <0>;
>> +                             sound-name-prefix = "ACODEC";
>> +                             clocks = <&clkc_periphs CLKID_ACODEC>;
>> +                             clock-names = "pclk";
>> +                             resets = <&reset RESET_ACODEC>;
>> +                             AVDD-supply = <&vddio_ao1v8>;
>> +                     };
>> +
>>                        watchdog@2100 {
>>                                compatible = "amlogic,s4-wdt", "amlogic,t7-wdt";
>>                                reg = <0x0 0x2100 0x0 0x10>;
>> @@ -850,3 +894,327 @@ emmc: mmc@fe08c000 {
>>                };
>>        };
>>   };
>> +
>> +&apb4 {
>> +     audio: bus@330000 {
>> +             compatible = "simple-bus";
>> +             reg = <0x0 0x330000 0x0 0x1000>;
> That's not a simple bus in such case.
>
> NAK
>
>
> Best regards,
> Krzysztof
>


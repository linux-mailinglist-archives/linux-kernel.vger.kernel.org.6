Return-Path: <linux-kernel+bounces-183853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C69C8C9EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6027284D58
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6571369B2;
	Mon, 20 May 2024 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="hPUdUEVu"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57107136669;
	Mon, 20 May 2024 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716216122; cv=fail; b=BW5ddesuckyY+R4dAqxeCclCQp0Z+32e6ZZYR6QMwknAcL7xJHN/dUXHfM93XqlZyqH8hObybiccfqvHz3SwNknVnyjqozpxa2Lo8oEaXbkmr1y6FJ5yISBzoK10euo1dlCOzcaBecOskZHdeY1xypdAkyMJ7Ei8m1xXts/NBqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716216122; c=relaxed/simple;
	bh=L/Zmv17X3g7j6qYIhnUqsiyD+FHieecBYk6Q6O0RyHI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VINtYhxLHIGwTqYMvumPtoOu9bsyedIdnbaWQl9blXNve8n66zTJGkQ2bI3Os3Y3WimHiOLTiWfxW0bBXulRHVQ/Abhaw7BM6iimoKYR+bIlfukXTBv7swc9hV+y7lQ2Gn8w20HVJ4+PctafFygoayEUkgPhc+DwME7+80k6wSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=hPUdUEVu; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KD0BWV021146;
	Mon, 20 May 2024 07:41:35 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y6sphwag2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 07:41:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vt79OwBA9/jQmDSaMk9BZ6ND0GYOeh7Tu+BuTdZT+pJHQG23UZEZ00SYF7PFRRawUZJO6ZrCA6ANndkJYCU0KLWOBaw8B2k6rswB9DFjB43JzsBGcmLQOr73675xtWJpatzf9PCl1H4+JMZ9zifteRusUahUJ8x4EN9SVLLyDrZe4ElsOxU9S1LmkYDZwkIiPhEWmnZHHDo3t0MLKjcT1mq/9NGRtVoOsjREdeXDhLs18+KyWHLhlQRq2k2c37fkPA5oUfsfH5FxguxsRBm+1sQRLABuS6cPEeZrYT5B5rpd5DUdCWTPOj8Qwq303STcWsk5+tHWgKxEsiEwWnjzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GKX5E3R+HRYos61B28aQoYdln1r62l0A5zusSbQkoU=;
 b=Shj0EaKUhjWZwOAzSFc8rqipF1PooZuV+fBQX7USFO5DfS4QeSFgNycmwiWQvu/81CjAhYf+89yVSzvY//qzt/5KicqToYQbe+tNaoz17zurN2g60xuGTC9SMljHekbfmAlLwVlzBYK1zApjh04QJcl2XUQbhyhKbzKKWH+qfiJA8dICxjC3PUorvtfQOiibzkVvyrZL9z3SusNjgfCubSDoiDefchdjy7TvS2S83lhJrFcLpD/QcYRLnzA8zNDqypASnX0Uyhg679ub9okFHSZAWHkaLg2qFMxAknRZd4Ay+ovgaIR/G7qFMneqYkh7a6KsUdbmyYOT3/DJPbexTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GKX5E3R+HRYos61B28aQoYdln1r62l0A5zusSbQkoU=;
 b=hPUdUEVuWuBXADMTy3C8QUy97D2kKkKPRHQKoHPPfR6IayG59OVSKV42fUx0Ozp42AB+kxOnzeP1wz/elnmIafbC4YI+5aWiMqE/7A0Dsd1jb9+KKchjtKDmfkm7iFX5wcp7xoJBaDVgprIGzPtpj4Xiqgwdoth6p5LpYC/JXes=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by CO1PR18MB4748.namprd18.prod.outlook.com (2603:10b6:303:eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 14:41:32 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%5]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 14:41:32 +0000
Message-ID: <fc91b997-f90b-4e3c-9a89-5db932ba148c@marvell.com>
Date: Mon, 20 May 2024 20:11:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] reset: add driver for imx8ulp SIM reset controller
To: Frank Li <Frank.li@nxp.com>
Cc: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, Liu Ying <victor.liu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>, laurentiu.mihalcea@nxp.com,
        devicetree@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240516204031.171920-1-laurentiumihalcea111@gmail.com>
 <20240516204031.171920-3-laurentiumihalcea111@gmail.com>
 <ade33946-bb94-4357-bc6d-a354661b50ca@marvell.com>
 <Zkd0uIaJiwzYrBIK@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <Zkd0uIaJiwzYrBIK@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::9) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|CO1PR18MB4748:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fcb7747-bc56-45f7-154b-08dc78daf121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bDRza25nRy9HcGlpNWt1Z1VpbzEyVFZVT2M0M3RnL1h3bU01dGc3cjZIMmZE?=
 =?utf-8?B?SzlqbmgrQ2d4d0NpWEtlVXBSOXBMOWJrNkNwS1ZwUm4yVG0ydyt5M3A0MGFZ?=
 =?utf-8?B?T1dYdEwrWFVvazYrK2tyUW5sRGx4NWcwSWNQZFFqZHdZMVlROGtQUkRxSTFK?=
 =?utf-8?B?a3plL2Q3UlNVYVNKZW5sTDhxZXdPc2ZRa1YvYjIvN2Z4djRzT1NNZ0R3dGJX?=
 =?utf-8?B?SkFYL2p1RWhwclA5aXBDZnBKemJmZ3ZIaXJ1ZStOQmtER2ZHWjFPblY5NXdl?=
 =?utf-8?B?Sm82SVNqOUFuemVnTU5rakUwdDRuWUQ3L2JILzFlSm11ZDBucjg2a1A3N2lX?=
 =?utf-8?B?T1RKQURyVDdIMnR1SmJKSUxaUXZsVGZmSTV6OVJtaVdHUWVzeSt0OVdsN0li?=
 =?utf-8?B?SWxLc2xET0VLWGljZVRrVkhYb1Y2Q2E4ZERCblkxNUIvWkIyaXcxcmxhWjk1?=
 =?utf-8?B?MUFTS0ExZDc2aVJQVXFueUxUNTJ5YTZJckZmUDdhb2lDem52cjJEZFNGb0ZP?=
 =?utf-8?B?TFV3U1FIRGhLZmt4Zi9jK3k0VllMc3ByU0dyMFhMQmhBVGtiN3kyN0x6TmpX?=
 =?utf-8?B?YnZiOTJ2OVNLbXpYQTNDR3NwelpTNjhRSUVDUmNsVENFNGtBSU5hRkh5bHp6?=
 =?utf-8?B?UE1pY005TmVvMkRCdG5LSHVvTGpqQmVtcTY2TFcyZ3J4S3ZlV0h3SmlHU3cr?=
 =?utf-8?B?SXdmclBQWEhIcjZGZEpLY2hpTkV4VnIyTTlCY2RQTlZOWDY4MEVlYmFEblFk?=
 =?utf-8?B?VVBKUlJleU80SWtUMEo3WVMzYWJNU3NEY0xtbmRaN25yS3RteUxlME5idVo4?=
 =?utf-8?B?Wmt5Y2p6UVY3Rmx5RDVKMjBBN2RQcWcwUG9DcTQxY0NTVVh6eVE2OHVrVzRX?=
 =?utf-8?B?aUI3QmV1ZjJubG4wMzZYejV6UWVuT3B3cUx4clNwdkQyUEtHMTlQRE5RNFdr?=
 =?utf-8?B?ZS9YSjFIV1VDS3ltMHRGMHdVWmxDcTExT3JGaVU2V2h5UEtzcENuOWdHSXBE?=
 =?utf-8?B?N01PZ21LVlBMY1I2a3h3eDBmVUxhd0h2TGFyV05BelczblVvN2F1bHBUWlZt?=
 =?utf-8?B?bVdabUZwNDlVaitiMnNQWGZiNDV1SlJJZFhQenZ1aStwM2RDOVl4Z0VTR25V?=
 =?utf-8?B?SHpnUDNjcVZSWmtUd0JFTUR6NGJGa2N6UERkY1FBeC8vZFFOUlFlSmlFb3dZ?=
 =?utf-8?B?NTNzRzJmS0lyR3hnYTFFQTFzSUI2NUpxdHU4blpxdzQ0TGNOK3JwYVdjTEhY?=
 =?utf-8?B?emhPQko5a3FlK0tqNlFhVGU1ckt2bGpFQVhza0tVMlZHYit6ZEhyeTJ4QVhn?=
 =?utf-8?B?UG5YSGY1SEpJd3ZsdlNnQWJackROWnhFTzZvdGpjWndScjdhSldQV0VsdUg1?=
 =?utf-8?B?R1RDbGdZYUI4ekI4NDdTaUFqZ29DV09WdGNPdzYrTnpoempnRmdsdzIvSVlt?=
 =?utf-8?B?djdGYjNaUExVTWx1MmFHMGVxOHhldTZINitoSURDQXhQdzVPZGVVUVFTZ2Vw?=
 =?utf-8?B?MVlORnNXUUY2UTM0RWM1R1k2QTRUZlRPRTlFRXRGclZ3cWRpaTNjaXlWM296?=
 =?utf-8?B?RGhvZCtDK2phbFBOZXRKTnBLTlRxOFBsRm9abkFvYjFsNnhXSll6MVhWaHRt?=
 =?utf-8?B?NGFhaVp5aU1ucU8xSXB2cStBVDRzT2c9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?clRhYUFlWitDdzlYcFhjdUZZNloxa0JNVDJuY0RlUmtBM3RUMUYwVFNaZHhC?=
 =?utf-8?B?MFRmOUJrK3BXUzUvdElsNkM3NDJ1S0JZM2hqdUxIanU0S0lxNzgwNTNMUmt4?=
 =?utf-8?B?aFdvUHlCZ2pvUUV6bW1ZWGttcWhCY1p5Mm9QL1FvdnRGS1pEWWtHYnBkWHU3?=
 =?utf-8?B?eDNtemNIUmhxenlxS2crRnVHMjM4ZTdrU0FSOUJqbHFkM3ViYUVsMW0zejJv?=
 =?utf-8?B?amlXc3FOQXRZRktaUUtiT1NTUXVNVXpndkJGSTlnbHorSWF4Q2QyRTBuUzE1?=
 =?utf-8?B?RHJmUUVXQ1JtME1jUGw5WmdLc2lVMmlhTm5YM1ZqclBsOGlYM0Q4ZnV3azFa?=
 =?utf-8?B?NXljRHNtZ0lzVk45YVVreXU1YVR4dHo5ckJnNkhobnBXWGdDcTZ5WXUvbGlT?=
 =?utf-8?B?Zm5RdFJRTGlrTGxGK1ZRRWl1WU5UOHBlTkNqOVVndWhhVW54NW9RakprSlhH?=
 =?utf-8?B?Y1A3LzVob1pUc2x0Wm50VjlSWVhMemprN3ArWjBaL0hyMzRSSFhRbUlWZnhx?=
 =?utf-8?B?bVFKTGhCUENyM1hEL0tROEJ4OFB5UGYvSHdQVDVMQ1RIa285RVRFZmQrRVRB?=
 =?utf-8?B?UWx4bkhYYStJbXBma0FRN2g4VWlWQ1JLTFlDVHpFUWZHQmJWQW1tYkdEMDc2?=
 =?utf-8?B?cndibWxMRnR2M3M3TEkzZUdydDBLS0hhcWMwMy9CZFBpNGFyS25kc3owK2xZ?=
 =?utf-8?B?UmV6aXc3MzAwNFFvOVhRRTdFclBZUzAydG0wdktCNWRab0taQ3Q5eXZDTkJ5?=
 =?utf-8?B?eHU3aUVEZ3FNNzRxMnBvamtQZGNwWVVqSnkrajR1em1lUklCb1FraUxnVWo4?=
 =?utf-8?B?cEdvOEttalBHcVRTSTF0YlNvVlNHMXlpVWFhQnpaRnB2bHl2VWs1TWNlSnhX?=
 =?utf-8?B?UDdrT1JtQzFWQ3BFLzhJaHE4V0U0Z3hONXlZb2wxaTZqdW5YTlhVRm9QL1Ju?=
 =?utf-8?B?RVNTeHVhWHhGbStOcmZ3RXNzcnlDMENrZjdzSlJpL1pVTVVpeHQvSThoZ3hs?=
 =?utf-8?B?Q3BxOFl2NS94SHhUSFJFVGFydU50djhtbWhwSmRlWnJ1cUlxQjU0M3Y2YW11?=
 =?utf-8?B?SEc5c21Sb2ZRbXRhQ2M2ZVhWaUtSYjFhRWVUMTJQN3g2ano2UlpUUlNXdWIx?=
 =?utf-8?B?eS9PVERLRmNjT3JVYXJCQmR5RzNiNytwUVI3YVFUWWpZdEFUM0JtSkFJKy96?=
 =?utf-8?B?UjVJQkQ2aDBjYU8vZ3JYNW1rZCt4V3RlZFRaSnp6LzU5VWpEZnFEMDNQVmVX?=
 =?utf-8?B?cWhUYk9aVGgxRlBHc1puMzBueUMrRWZuYXcwNFRJY2tHaHIxRVhHTWp0N0p6?=
 =?utf-8?B?N1FVWFZoVlNkK25CY2E1WmxZdmZXSlBJQjYyV0p6TmtvNDcrOUJONjNsK1pl?=
 =?utf-8?B?RzdIVSsvNXlVcGtLZS80dUNkSnE0V2hVbnhsM3pBU2czY3FXVWFNVy9EODJT?=
 =?utf-8?B?Sk0vbnZhZ1VPaFAyUzhXeDNQMmQvNnFKeDFJRGlUNlhiWjRzTGNyWE1nM2Nz?=
 =?utf-8?B?U3ROaDNwQUw5azZ6YjhEancxZHl1Y3pmOTg5OVZhbG9ZQ0hIUkxSUUcycU5j?=
 =?utf-8?B?eVF4REhtS3FCT29kVXMweFFKaEFCNitCR1pSdHM2Q2dVMHpiZ3ZqeUFjTW03?=
 =?utf-8?B?TkZKdTZibnUzZ1c2b01WNWlFV3BMWndWZ2hZQTJJbzB0bWkwTUdkTCtvS1Ar?=
 =?utf-8?B?Q2JwbmZGcFN5SnhtdlM0b0VZSTlmZWYwQzk0SzVYVWZ6UFpUYmp2OGZ4THRV?=
 =?utf-8?B?dFpzbEtsS1c5ZS82VzJlb28yejJERmhWY0orUUIyZm1wSS9Ca0VTcG1RT2w5?=
 =?utf-8?B?NjdXa0RDcC9BZVlyUDRsbkdoUjdVekc0SXN1TlF5Rk1UeW0vZFpWaU5OME9n?=
 =?utf-8?B?MVhPbytNYVl3aXQxTXh6S2xZeHJKbytmd3VLTWM1S3BVUGZNb2c5aG10NnlP?=
 =?utf-8?B?c0NSTUNHaVdHaXN4TWxsNmFiSkR4U2VrT1pRbVIrMitRTWVzalJmV1FnVk5W?=
 =?utf-8?B?d3gxdUYzakJrNVpodG1TSFE3R3VxQko4TG9WRDZFQjVWWlpBY1NIY3VlMjNa?=
 =?utf-8?B?T3hjZWxOQVluQ0F2YnRqMi9uaEZhOXVCZ29NN2F2RGE2dEkvSy9DYVl1WWpi?=
 =?utf-8?Q?gjouCJjsVhHABz8EgeXjzs0Au?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcb7747-bc56-45f7-154b-08dc78daf121
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 14:41:32.6595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMN6fdfJcvenwHVd97d0pxohHIKTppEADgXvLKIDZJjYWWo/d6KGiaqmEkxBBZ+hRkHp1VuvrWVTZvAnFPJBZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4748
X-Proofpoint-ORIG-GUID: GcWhw80Wgxo5pHRSTN3Ufdms-BJ8QOqV
X-Proofpoint-GUID: GcWhw80Wgxo5pHRSTN3Ufdms-BJ8QOqV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_05,2024-05-17_03,2024-05-17_01


> 
> ----------------------------------------------------------------------
> On Fri, May 17, 2024 at 11:51:30AM +0530, Amit Singh Tomar wrote:
>> Hi,
>>
>>> ----------------------------------------------------------------------
>>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>>
>>> Certain components can be reset via the SIM module.
>>> Add reset controller driver for the SIM module to
>>> allow drivers for said components to control the
>>> reset signal(s).
>>>
>>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>> ---
>>>    drivers/reset/Kconfig                         |  7 ++
>>>    drivers/reset/Makefile                        |  1 +
>>>    drivers/reset/reset-imx8ulp-sim.c             | 98 +++++++++++++++++++
>>
>> Just out of curiosity, can't this be accomplished using a generic reset
>> driver?
>>
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__elixir.bootlin.com_linux_latest_source_drivers_reset_reset-2Dsimple.c&d=DwIBAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=MnEcoegPnKc-F7TNf8PB3icMf8uCGrxsh6mEDWgNq3YA-OugL6Y53LxytlBGcsKp&s=6mBPHYYYXoyyxPPbUeOiIpwR3CXdnui1W3nkUJQ76Vo&e=
> 
> reset-simple have not use regmap. I think it can use ti's
> https://urldefense.proofpoint.com/v2/url?u=https-3A__elixir.bootlin.com_linux_latest_source_drivers_reset_reset-2Dti-2Dsyscon.c&d=DwIBAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=MnEcoegPnKc-F7TNf8PB3icMf8uCGrxsh6mEDWgNq3YA-OugL6Y53LxytlBGcsKp&s=D6tqLNYrUbsdG_gYg4G-ORlC9YKz4XRAlVeo1hyoYS4&e=
> 
> Or should change ti to reset-simple-syscon?  or add regmap support for
> reset-simple.c
> 

Quickly looked into U-Boot (not sure if it's the right reference), and 
it has a separate reset-syscon.c file:

https://elixir.bootlin.com/u-boot/latest/source/drivers/reset/reset-syscon.c

So, converting reset-ti-syscon.c to reset-syscon.c might be the way to go.

> Frank Li
> 
> 
>>
>>>    include/dt-bindings/reset/imx8ulp-sim-reset.h | 16 +++
>>>    4 files changed, 122 insertions(+)
>>>    create mode 100644 drivers/reset/reset-imx8ulp-sim.c
>>>    create mode 100644 include/dt-bindings/reset/imx8ulp-sim-reset.h
>>>
>>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>>> index 85b27c42cf65..c1f4d9ebd0fd 100644
>>> --- a/drivers/reset/Kconfig
>>> +++ b/drivers/reset/Kconfig
>>> @@ -91,6 +91,13 @@ config RESET_IMX7
>>>    	help
>>>    	  This enables the reset controller driver for i.MX7 SoCs.
>>> +config RESET_IMX8ULP_SIM
>>> +	tristate "i.MX8ULP SIM Reset Driver"
>>> +	depends on ARCH_MXC
>>> +	help
>>> +	  This enables the SIM (System Integration Module) reset driver
>>> +	  for the i.MX8ULP SoC.
>>> +
>>>    config RESET_INTEL_GW
>>>    	bool "Intel Reset Controller Driver"
>>>    	depends on X86 || COMPILE_TEST
>>> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
>>> index fd8b49fa46fc..f257d6a41f1e 100644
>>> --- a/drivers/reset/Makefile
>>> +++ b/drivers/reset/Makefile
>>> @@ -42,3 +42,4 @@ obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
>>>    obj-$(CONFIG_RESET_UNIPHIER_GLUE) += reset-uniphier-glue.o
>>>    obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
>>>    obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
>>> +obj-$(CONFIG_RESET_IMX8ULP_SIM) += reset-imx8ulp-sim.o
>>> diff --git a/drivers/reset/reset-imx8ulp-sim.c b/drivers/reset/reset-imx8ulp-sim.c
>>> new file mode 100644
>>> index 000000000000..27923b9cd454
>>> --- /dev/null
>>> +++ b/drivers/reset/reset-imx8ulp-sim.c
>>> @@ -0,0 +1,98 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +
>>> +/*
>>> + * Copyright 2024 NXP
>>> + */
>>> +
>>> +#include <linux/mfd/syscon.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/reset-controller.h>
>>> +#include <dt-bindings/reset/imx8ulp-sim-reset.h>
>>> +
>>> +#define AVD_SIM_SYSCTRL0        0x8
>>> +
>>> +struct imx8ulp_sim_reset {
>>> +	struct reset_controller_dev     rcdev;
>>> +	struct regmap                   *regmap;
>>> +};
>>> +
>>> +static const u32 imx8ulp_sim_reset_bits[IMX8ULP_SIM_RESET_NUM] = {
>>> +	[IMX8ULP_SIM_RESET_MIPI_DSI_RST_DPI_N] = BIT(3),
>>> +	[IMX8ULP_SIM_RESET_MIPI_DSI_RST_ESC_N] = BIT(4),
>>> +	[IMX8ULP_SIM_RESET_MIPI_DSI_RST_BYTE_N] = BIT(5),
>>> +};
>>> +
>>> +static inline struct imx8ulp_sim_reset *
>>> +to_imx8ulp_sim_reset(struct reset_controller_dev *rcdev)
>>> +{
>>> +	return container_of(rcdev, struct imx8ulp_sim_reset, rcdev);
>>> +}
>>> +
>>> +static int imx8ulp_sim_reset_assert(struct reset_controller_dev *rcdev,
>>> +				    unsigned long id)
>>> +{
>>> +	struct imx8ulp_sim_reset *simr = to_imx8ulp_sim_reset(rcdev);
>>> +	const u32 bit = imx8ulp_sim_reset_bits[id];
>>> +
>>> +	return regmap_update_bits(simr->regmap, AVD_SIM_SYSCTRL0, bit, 0);
>>> +}
>>> +
>>> +static int imx8ulp_sim_reset_deassert(struct reset_controller_dev *rcdev,
>>> +				      unsigned long id)
>>> +{
>>> +	struct imx8ulp_sim_reset *simr = to_imx8ulp_sim_reset(rcdev);
>>> +	const u32 bit = imx8ulp_sim_reset_bits[id];
>>> +
>>> +	return regmap_update_bits(simr->regmap, AVD_SIM_SYSCTRL0, bit, bit);
>>> +}
>>> +
>>> +static const struct reset_control_ops imx8ulp_sim_reset_ops = {
>>> +	.assert         = imx8ulp_sim_reset_assert,
>>> +	.deassert       = imx8ulp_sim_reset_deassert,
>>> +};
>>> +
>>> +static const struct of_device_id imx8ulp_sim_reset_dt_ids[] = {
>>> +	{ .compatible = "nxp,imx8ulp-avd-sim-reset", },
>>> +	{ /* sentinel */ },
>>> +};
>>> +
>>> +static int imx8ulp_sim_reset_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device *dev = &pdev->dev;
>>> +	struct imx8ulp_sim_reset *simr;
>>> +	int ret;
>>> +
>>> +	simr = devm_kzalloc(dev, sizeof(*simr), GFP_KERNEL);
>>> +	if (!simr)
>>> +		return -ENOMEM;
>>> +
>>> +	simr->regmap = syscon_node_to_regmap(dev->of_node->parent);
>>> +	if (IS_ERR(simr->regmap)) {
>>> +		ret = PTR_ERR(simr->regmap);
>>> +		dev_err(dev, "failed to get regmap: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	simr->rcdev.owner = THIS_MODULE;
>>> +	simr->rcdev.nr_resets = IMX8ULP_SIM_RESET_NUM;
>>> +	simr->rcdev.ops = &imx8ulp_sim_reset_ops;
>>> +	simr->rcdev.of_node = dev->of_node;
>>> +
>>> +	return devm_reset_controller_register(dev, &simr->rcdev);
>>> +}
>>> +
>>> +static struct platform_driver imx8ulp_sim_reset_driver = {
>>> +	.probe  = imx8ulp_sim_reset_probe,
>>> +	.driver = {
>>> +		.name           = KBUILD_MODNAME,
>>> +		.of_match_table = imx8ulp_sim_reset_dt_ids,
>>> +	},
>>> +};
>>> +module_platform_driver(imx8ulp_sim_reset_driver);
>>> +
>>> +MODULE_AUTHOR("Liu Ying <victor.liu@nxp.com>");
>>> +MODULE_DESCRIPTION("NXP i.MX8ULP System Integration Module Reset driver");
>>> +MODULE_LICENSE("GPL");
>>> diff --git a/include/dt-bindings/reset/imx8ulp-sim-reset.h b/include/dt-bindings/reset/imx8ulp-sim-reset.h
>>> new file mode 100644
>>> index 000000000000..a3cee0d60773
>>> --- /dev/null
>>> +++ b/include/dt-bindings/reset/imx8ulp-sim-reset.h
>>> @@ -0,0 +1,16 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
>>> +
>>> +/*
>>> + * Copyright 2024 NXP
>>> + */
>>> +
>>> +#ifndef DT_BINDINGS_RESET_IMX8ULP_SIM_RESET_H
>>> +#define DT_BINDINGS_RESET_IMX8ULP_SIM_RESET_H
>>> +
>>> +#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_DPI_N    0
>>> +#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_ESC_N    1
>>> +#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_BYTE_N   2
>>> +
>>> +#define IMX8ULP_SIM_RESET_NUM                   3
>>> +
>>> +#endif /* DT_BINDINGS_RESET_IMX8ULP_SIM_RESET_H */
>>



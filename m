Return-Path: <linux-kernel+bounces-413154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4D49D1449
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED94282367
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1789B1AA1C5;
	Mon, 18 Nov 2024 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p0q2r+hb"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591C21A08B6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943153; cv=fail; b=YoR3b16VxwlbS+1eCwBfHRTaSpzU9bETYodfmFv89HSpPdeh62c6cb82v4AxAtUy9s2c7zrtThEK24LaoW2aN+hdEkIhCBRbFMS35CpUMO3A3ynZy27XOCuY2cTwc/bETFLV5Wy0HjCTo26q82qSArjeoWX11kZToXVBIE4mGNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943153; c=relaxed/simple;
	bh=5KMaiFjr4MNzywz2JjEiz5Lt2kkvWYw+YxIbOlYMCNI=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=o+2y4AXVTh0y09ONdehT6dzDetCsMSwSB5wcsd1EotZZ49kpTB9StmUhxboFZEXqISJuUrSnRzRaUyDe4KcA+Ew9mpivOBjW/K3KFCMJrfmgoKtq08oLpmkSX5EoqUmxGBm85xMILYVVtTzPGveXbsGHOtzyzkvsxn5lYOPyh6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p0q2r+hb; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFF8SC2umEu4ByjI921Omuo03pUaVAlzj1xebwl3JpzSAOLaGBN0j/lJl98KsKCYvHQJwrb4U+t2bMMv1e+BkLhfPQxPrdDFm/2o0eqr3Izi1hEpD+DCJw/tS5B1ZrGS6RWIA+QgH+g7FQVBJYQWMHe0B7D02QReztqX/r4a3q2sWN0Oa/HDVJ2x2nvIHgaNYgTHJM/tY8Zz5n5PTAkbiufotTOKkce1iU7KihnhS5T/YrMy+zUQMW10sLBm/C7a3apDxSRNEooQenOHsVn1da1UjtSlnGC2OQeaoeEuiHmgpCy5wa8rGfVl23TyDdSV7bjnDebriCnpCqNHV3o32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJZrbxnljXz4T+KsxZ0Nlb8qS5jJKXEO3l2D+wKX9T8=;
 b=bQ/Jhld+u2uF5b9Vg7pTGNieSr6jfd3VJfowej+oQugnrbmAWFRqA2BB+tOz2lsVIEQjOAsBUu5PfEb2WAHCHTF3SUn0Jp6WK9l+3S2OLtGwyROJm+nvkoFM8pleP3ZRoFMfpupUoS0Rdd3keuiGUU7HYf5Umk8j3Hl18bwCpJKJivxNJvyLxR+XRl99cPyJIyXj/U41gQf+j6lZv9yVK8rQCcwqkG6JXuifl6ID/ASyEQj84kBeAW4eJudMe92rJwPbD5PHI4ExX9Vu2ROkeOS2vHbpehQX7JLH6CTk+5v6q+HstTGwyNEsy/iYsE3MboO7hw9HhKXEYoQ8ANaAUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJZrbxnljXz4T+KsxZ0Nlb8qS5jJKXEO3l2D+wKX9T8=;
 b=p0q2r+hbhqyhB7LnQbFk69Zfix40HkExmjLoys3WFT1//3giNqKDZYgBfEcZGG6vyRcohDCpj6FkZ2MAVzh7dYkvxiCDBcoaA3EdoPRdxygVIHcGm8GmFCloVMDgQCh+wdDJ2yqCuAo0/U1MWgUxiqecz104qY8ma0ZsSA4AzIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 15:19:07 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 15:19:06 +0000
Message-ID: <7cc5e26c-42fc-a700-ae19-608920cafe44@amd.com>
Date: Mon, 18 Nov 2024 09:19:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
 mingo@kernel.org, bp@alien8.de
Cc: x86@kernel.org
References: <20241118010819.46602-1-bhe@redhat.com>
 <20241118010819.46602-2-bhe@redhat.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v2 1/2] x86/ioremap: introduce helper to implement
 xxx_is_setup_data()
In-Reply-To: <20241118010819.46602-2-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:806:20::26) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: aa54e622-7f45-431b-8cc9-08dd07e45803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXAzMnc4YlV2TWM0S2RQQXF2MmphdEZGVkR2bENURlBmOHM3V3ZZWlR0d1Iy?=
 =?utf-8?B?ZWRPMGNnQkZpNXFETXBGODh3eWtTbStwTkpTeXdFbm5BQXBOdFRDdCtjUXVD?=
 =?utf-8?B?S0pKL0xMeUVpd1I0bUpiZXc1NjF1Q0NqSFlrbnVRSDFBZzFTT3VOTCt3dGtp?=
 =?utf-8?B?bjBkVnE4N25NQTFJU1pCWjA4TnlnUHNqKzlzWnZVSnFTSVBnRUpJWk1sTEE5?=
 =?utf-8?B?bEtGTC9zeGk4WXpOSkZTQ0MveURHTHRvNEFmSXcwOU55cURBS2Y1bEJKSTI1?=
 =?utf-8?B?Wkc0Q2xJZ3lFT1h3NWZVby9EOXVQSUJSWXQ4bEJwVlpLTWV3elQ0U2dIYWJq?=
 =?utf-8?B?TS84MEJOaENJZTh2VUsxTGtERTl1VVNBS3FtZjRJNnFLNkR6RHhiZDhRY3p0?=
 =?utf-8?B?U2ZZL3RUeWRhbDdxaUFTN3hTaGFNend4d0xPditUbFNXU2tRSXBzdmZINUpm?=
 =?utf-8?B?NG80emIyRGRGYmdDMDFwK0xpZW1Lb3VJeGt6emR4eGNoQ2oxZjk0blk5bElZ?=
 =?utf-8?B?a1V2REdQMjI4eXhaQ1Fiai9FVk5VL0J6MEJwM0NncjZqVGYvSjlyRGtqUVpR?=
 =?utf-8?B?Q3h3VUJaRkI3ZGxJNWhvZlFUZWswcVl4Z1Iyb3NRRmRNVW5PajY3a1JONFR2?=
 =?utf-8?B?Z3Urdm5FT2E2aExqMWdKdWxPVzhJRXNJMWhZWGJybTh5M01YWkdnQk1FYVpt?=
 =?utf-8?B?WTVyb3VhZTMrK0dlVGdHd1dHQWVxWVpNK2d2L2NjZ1pBY3htNFBBQ2lDSzhk?=
 =?utf-8?B?OFY0eU02UHhMVG8rMm9KU0JVSnhSZTQxRnRUcnlNdnlCTDhMMXpia05nWlFU?=
 =?utf-8?B?clhkc3pGWFN0blJhK2hkVWNxTnpnVklyQ3lVTm5lK0I5TVlYY0wrbWtJTDdi?=
 =?utf-8?B?MzRSUk5nQlF2aEsvWWVMWnQ0czJkc0p5L2p3VUJ0OXFQenQ4dkNJTll5aHVx?=
 =?utf-8?B?MVNIRGFISmVoZUhtTmpGc1UySWJhL0YvdnB1WUVqRmtWMWhpKzc2TkVxM3Ay?=
 =?utf-8?B?a1ZrUldxdUdoMzg0ZkpwV1RRN2hTS2l0Y05qdU1jVjNaK2VxZ1p2TWxTSGFw?=
 =?utf-8?B?S1oxZURRTmp2OUxsTXcyNkNMYWNyVi9BSWF3MzM4YkVKc2FyalpvL21lRWth?=
 =?utf-8?B?U216UTduNVZ6MEt3WmdCenZEY0k3RjErOVRIVnBxWVhmS1NGRUZkS2E4Z0Z5?=
 =?utf-8?B?ZUo4RWVPbys0alFWVWtHWk9ESVpSSTFVUkdTY250M1QxUDZtQ3lVNzZPWTVI?=
 =?utf-8?B?YjB5elVuYXJrYWNvVitJdTAwbHZ6Qzg2TDA4bHU2azNWM21pMkEzNDZWRjRY?=
 =?utf-8?B?amt3UFdLYXozTy9Ya2IzUzN4K3N1ZjZNSDhnNGZFL0lkSUVQR2QydDhRR0Zy?=
 =?utf-8?B?VXJDMEI1MDhzeHA4UXVkTkZVaWdXTWRkRlhrRVJNOVZodVJrVHBpQm10NHRK?=
 =?utf-8?B?c09WbXVMdkJnQUxLdnZwVXpyWlh3QmNwYUZkRENHenBWbHNUeWt1VkxBT3Mr?=
 =?utf-8?B?RWEySmJySzByZWJMUTN4YlZOdGlkL1VudEQ1eXVQVHExS3RnRUQ2OG5lTHY2?=
 =?utf-8?B?WHFtbU9tb05zZnF0bklDSFNScExIVVowQkZFWEV0K3cxQVA2ZzhCTWNrM3Rs?=
 =?utf-8?B?QitMUC9vZkwwOVZ1MTVpQUwrUTFLZGhwWFpUeTEyejRDYkVQSFFEd01DRFVK?=
 =?utf-8?B?dUluN3JrZ212TmtyQ0JPQ2ZiT3lLRHRPUTJWZFA4UWE1R2FnVnBwTzFkejJm?=
 =?utf-8?Q?/Dp/RmayMHSh09INiHIpLd73GeT19lxVnrzukSC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGR1NVVTckxjMXBLSmlyZTJUQmtVc0svKzBWWFFyaENkSWI0N2tpd0tuTk9n?=
 =?utf-8?B?STMrSDk5VHBndDNLUW43ckQ0QU03bTFzanpoK1pCK2ZmVjVxaU1QMUJDYSs5?=
 =?utf-8?B?ZHpqbzFBRVF6SDVFYWR5Q3hrR3Q5eURUejgzT0lFUW9TcWJkckhvdFYydFRO?=
 =?utf-8?B?U0dJdnlXYlg0dzZJRDNtdGJIZ0lyVVpBT0d3Y3A1SG44V0k0YTZENlJQcjhC?=
 =?utf-8?B?TkYySGRGNnF0dS9xc0NxMC9NU3hvQ3BsUEwyRHVtaVlTald1Q1UvQTZHOEJw?=
 =?utf-8?B?Y05SVFp1VnRPTHZuT3Z6L2RTcVVXbzUwcWMwS2lxQTBJa2dOdEljekNIYlUw?=
 =?utf-8?B?QnVaOSt6S0NmNmc0aytyeS95cDJ0bUVRME1IaityWVgrNm15cWhYcW5nWDZu?=
 =?utf-8?B?VVNpczNEd3ZIbUczSzA3OEwyaGRwWjZpTG1YaHJMNnNYWTFURE14bWpUWmxk?=
 =?utf-8?B?NFdSWGI2TXBEdVp6T3FYeHFVQkN0RjgxVWF6dEFtSzJpVENyZE9VT1JUeHdI?=
 =?utf-8?B?UUc5MlRqSTZ4dkVGZEJmQjRIRlFiK21LV2tNajI2a056RzRsTXI2eFZ1VFRD?=
 =?utf-8?B?TCs4Vll0RFdSNERhd2FjOHBHajRJMVl3UGIwVXZwUXdHQm9OYmNLV3BKeHlw?=
 =?utf-8?B?NU9hNkFTK2JQUzVPTzl2Nk8ybm1yTXF6ekFNMU51Q2ZjTEx6RUN5U1dnUE5z?=
 =?utf-8?B?WmozK2hWcDNMN3oxKzVGUXJBck9TR0czbTkyS1VvN2pQcHQySlFvQm9INTFp?=
 =?utf-8?B?Y1ExakY2NEV5RGhJQVJUSjJBQXVtV05QeTJ1QTFGVms3djZpSVF2MTBLZHNH?=
 =?utf-8?B?MjRBTGNHcHF2aFJwUmhJWmg4L0g5QTlLSENOVW9lMzVNd0kxaVYrNURxQTYv?=
 =?utf-8?B?TWl4Sk1CNU0ycE5oWDllUTZFQXNHd0NvWml5cytNeSsyQXRVRmVWSzA3K1NZ?=
 =?utf-8?B?ZVlMOUdQcXFjaWo0VVR0SWJjYXNtUzBqOGhJYWdOL2dnUExHN2t1MloybjJt?=
 =?utf-8?B?bVZndDBBTGZEYWZJSmRlQVc5VjdxenVQZnNSbnFBeWRaNDd0MVNHWjR4a1Fz?=
 =?utf-8?B?aDg5WXB3YllRdFhYT2k5Nm5ucGRPSEZVTEY0NmpyWmwxZmxYYVF6VC9jK2JJ?=
 =?utf-8?B?SWM0b2t1YVRId2t2YzdUcWowYUlNbTh6UFQ1Z1BWUEFLKzhxd0JzdkNYSWIv?=
 =?utf-8?B?UE12VmZ4dGdLMUtzbm5OdWttUmZGRE1EUTlCZzFobyt0NW93Y1VyUS9IYy9F?=
 =?utf-8?B?V29xUzJKODM3THhiTDhtYml3QVBiNVRhUmNoTVZSTmJPZUZZdG9xd0VvWUl5?=
 =?utf-8?B?VUtxOUZTTWlOTEI4cmY2cHZrM1VMTTk0YnJGUlRxQXhiZzZKdS9pMmFvNGpQ?=
 =?utf-8?B?d1dCaWpOQ0NLeklCcUJnTDl0MVZUd3dqUnZSa3pBbWRmR0FocGgydmNpQXdK?=
 =?utf-8?B?aGYxVnV4cnZXNHUzVWlGMHh6ZEV1TGkxdS9TQzhhYlBCWVBZeWhDZHFsWU9J?=
 =?utf-8?B?Nkh5Wnk2SjlSN0lrNGFYaHNzMlV0WTdxZWwyYkdWbFA5ZVJLUlpaQmdkZ3o4?=
 =?utf-8?B?Zkw0SE1iQmd0TTdQOUx3ZUZ5Um9IWFNRYUVEMnIrN1YvTWE5R1JqVzE3R3JT?=
 =?utf-8?B?SkVMbUZBZXJoZTcxYXNzQ3Z4aE9DL1p2S1E4WVpSaWVEOGFuWUNNSG1SNGti?=
 =?utf-8?B?RE15QmlTNVQzK3lkNTNKVUd5RkNyaHR2Y1NEYlhYN1pCYzNFcnZGTGRqTHlY?=
 =?utf-8?B?cjRnSVF0RjJHcFlGa2pVcDR1ZU9iRlcvQ051U0pjd05UeHFIaG1sTW8xTDVn?=
 =?utf-8?B?bitqcjNpUVVCOTd4SEUxcmNsNHZwb0w2d0xXNnRtSVdPaUlQTHZZWnJiVVZP?=
 =?utf-8?B?WmgxaFkvTGNPUVoweW04Wk9mdEQ4dmxDUURVZFZTakhmcWRXdm9iU0N0QnZx?=
 =?utf-8?B?SCt5MWVPbG1hRzFzbXdHWThlM0YzeGVSRFRGVzR2OVQvMnd6Y2l4cHhmOGRw?=
 =?utf-8?B?S2tGbXcwUHRDR09TbHBPZ2pod3BSTHpZWWZGazVQVkw3eWJrNHdVR2ZSTDRD?=
 =?utf-8?B?bzJQQzEwOXF6d040a3pXZ2FKY2oxOWdRZnc0b2lFZmZ5NE1wU0dmTk5qREdj?=
 =?utf-8?Q?HEeWgFYDF7KPMje8soUNvSFdr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa54e622-7f45-431b-8cc9-08dd07e45803
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 15:19:06.8452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXxzGL3YGLQMaEG1RExsPthI/e732j+VUx4mbfz8GhYpW9GpmgNLJTyUvG/qR1D4hksunju2JDm3s1wPKEXiGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074

On 11/17/24 19:08, Baoquan He wrote:
> Functions memremap_is_setup_data() and early_memremap_is_setup_data()
> share completely the same process and handling, except of the
> different memremap/unmap invocations.
> 
> So add helper __memremap_is_setup_data() to extract the common part,
> parameter 'early' is used to decide what kind of memremap/unmap
> APIs are called. This simplifies codes a lot by removing the duplicated
> codes, and also removes the similar code comment above them.
> 
> And '__ref' is added to __memremap_is_setup_data() to suppress below
> section mismatch warning:
> 
> ARNING: modpost: vmlinux: section mismatch in reference: __memremap_is_setup_data+0x5f (section: .text) ->
> early_memunmap (section: .init.text)
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/mm/ioremap.c | 108 +++++++++++++++---------------------------
>  1 file changed, 38 insertions(+), 70 deletions(-)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 8d29163568a7..68d78e2b1203 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -628,12 +628,13 @@ static bool memremap_is_efi_data(resource_size_t phys_addr,
>  	return false;
>  }
>  
> +#define SD_SIZE sizeof(struct setup_data)

Nit, I still think you should use "sizeof(*data)" in the code instead of
creating a #define.

>  /*
>   * Examine the physical address to determine if it is boot data by checking
>   * it against the boot params setup_data chain.
>   */
> -static bool memremap_is_setup_data(resource_size_t phys_addr,
> -				   unsigned long size)
> +static bool __ref __memremap_is_setup_data(resource_size_t phys_addr,

Oh, I see why the __ref is needed now, because this calls an __init
function based on the early bool.

While this nicely consolidates the checking, I'll let the x86
maintainers decide whether they like that an __init function is calling
a non __init function.

> +						bool early)
>  {
>  	struct setup_indirect *indirect;
>  	struct setup_data *data;
> @@ -641,31 +642,45 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
>  
>  	paddr = boot_params.hdr.setup_data;
>  	while (paddr) {
> -		unsigned int len;
> +		unsigned int len, size;
>  
>  		if (phys_addr == paddr)
>  			return true;
>  
> -		data = memremap(paddr, sizeof(*data),
> -				MEMREMAP_WB | MEMREMAP_DEC);
> +		if (early)
> +			data = early_memremap_decrypted(paddr, SD_SIZE);
> +		else
> +			data = memremap(paddr, SD_SIZE,
> +					MEMREMAP_WB | MEMREMAP_DEC);
>  		if (!data) {
>  			pr_warn("failed to memremap setup_data entry\n");
>  			return false;
>  		}
>  
> +		size = SD_SIZE;
> +
>  		paddr_next = data->next;
>  		len = data->len;
>  
>  		if ((phys_addr > paddr) &&
> -		    (phys_addr < (paddr + sizeof(struct setup_data) + len))) {
> -			memunmap(data);
> +		    (phys_addr < (paddr + SD_SIZE + len))) {
> +			if (early)
> +				early_memunmap(data, SD_SIZE);
> +			else
> +				memunmap(data);
>  			return true;
>  		}
>  
>  		if (data->type == SETUP_INDIRECT) {
> -			memunmap(data);
> -			data = memremap(paddr, sizeof(*data) + len,
> -					MEMREMAP_WB | MEMREMAP_DEC);
> +			size += len;
> +			if (early) {
> +				early_memunmap(data, SD_SIZE);
> +				data = early_memremap_decrypted(paddr, size);
> +			} else {
> +				memunmap(data);
> +				data = memremap(paddr, size,
> +						MEMREMAP_WB | MEMREMAP_DEC);
> +			}
>  			if (!data) {
>  				pr_warn("failed to memremap indirect setup_data\n");
>  				return false;
> @@ -679,7 +694,10 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
>  			}
>  		}
>  
> -		memunmap(data);
> +		if (early)
> +			early_memunmap(data, size);
> +		else
> +			memunmap(data);
>  
>  		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
>  			return true;
> @@ -689,68 +707,18 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
>  
>  	return false;
>  }
> +#undef SD_SIZE
>  
> -/*
> - * Examine the physical address to determine if it is boot data by checking
> - * it against the boot params setup_data chain (early boot version).
> - */
> -static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
> -						unsigned long size)
> +static bool memremap_is_setup_data(resource_size_t phys_addr,
> +				   unsigned long size)
>  {
> -	struct setup_indirect *indirect;
> -	struct setup_data *data;
> -	u64 paddr, paddr_next;
> -
> -	paddr = boot_params.hdr.setup_data;
> -	while (paddr) {
> -		unsigned int len, size;
> -
> -		if (phys_addr == paddr)
> -			return true;
> -
> -		data = early_memremap_decrypted(paddr, sizeof(*data));
> -		if (!data) {
> -			pr_warn("failed to early memremap setup_data entry\n");
> -			return false;
> -		}
> -
> -		size = sizeof(*data);
> -
> -		paddr_next = data->next;
> -		len = data->len;
> -
> -		if ((phys_addr > paddr) &&
> -		    (phys_addr < (paddr + sizeof(struct setup_data) + len))) {
> -			early_memunmap(data, sizeof(*data));
> -			return true;
> -		}
> -
> -		if (data->type == SETUP_INDIRECT) {
> -			size += len;
> -			early_memunmap(data, sizeof(*data));
> -			data = early_memremap_decrypted(paddr, size);
> -			if (!data) {
> -				pr_warn("failed to early memremap indirect setup_data\n");
> -				return false;
> -			}
> -
> -			indirect = (struct setup_indirect *)data->data;
> -
> -			if (indirect->type != SETUP_INDIRECT) {
> -				paddr = indirect->addr;
> -				len = indirect->len;
> -			}
> -		}
> -
> -		early_memunmap(data, size);
> -
> -		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
> -			return true;
> -
> -		paddr = paddr_next;
> -	}
> +	return __memremap_is_setup_data(phys_addr, false);
> +}
>  
> -	return false;
> +static bool early_memremap_is_setup_data(resource_size_t phys_addr,

This should retain the original __init reference.

Thanks,
Tom

> +						unsigned long size)
> +{
> +	return __memremap_is_setup_data(phys_addr, true);
>  }
>  
>  /*


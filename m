Return-Path: <linux-kernel+bounces-565155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0588FA661E9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89316189B646
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAF81F63F0;
	Mon, 17 Mar 2025 22:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k3IYnGtr"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E20B946F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251495; cv=fail; b=e17I8OR7+uxGvvKr87df2n8GFPs5I5xZcPxlxncTzfEzRchN4jUf8MDTWYdWpXUXNKWYKQiat4YOShoF25djERgTnBDiPyUn6WVLQvVh5j0Bw3PL2zlJShiHV52/WxILfrPbOZYgOUfptPvQyCWOvRWCB21PTA8S6mYZyyeUvG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251495; c=relaxed/simple;
	bh=YoPcBxObUg3k9ou/4vDRsbRIwCMkgYkKUYDEdat62a8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HAK+/LbVomnPhuZzcnR/jFOyrK1uUGc4J0MDh2m1eaz8FVCXcCi4AmcBf+USJPIFH/hPpAo5eQ2t7fBrsdNAxaVpnfEzzf/FlDq+JJG5iYdL6pBxUSc4Rd8/milYe12fHj6CGiIGQZ8PX2PtC77D15r6P8cYN60430efuwSmXlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k3IYnGtr; arc=fail smtp.client-ip=40.107.96.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6Of0yMd00dWv1Jvsb42+MCkCPCDAK9/4BHp+wBGTNvmT/jRTgOmYbwhlS2weyBqqzwY5Tukl75esMepRMnI1TyvgWiFr12EAY9Aknb1Qs11gAfqY1uav1wKGKYV3Yw9Xc/E+UZZoSwcR5c/flhH7l7K6I1A3cqZDMfB8DgU8HD+QcA4+ZuBTcHNy+JJom3RWoSJXMy7/ct8aeM+tYoFx9lkzfpJRXKSBk4+Xs5OThBrEoubUnmQUElsNztY/x8Wy5ICZWSyKL/0FXTZQve8fNeQuHsqHhg6QqIhZtjvO1Ej+zzdShAvz3wh08z9f6A0GG47NGyada+o64izzR4s2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXYrMVEc2Nmm666p21EWKS116+D9/AJqPHHmW3CFJ7U=;
 b=nhek2QqCkPvAA0LP9B/xON9TfjWH0/Wc3JpUzv1DX+itiT/VNxDtMFeU+7f1hs34RRvf6DsYA2tE/exOJy9tsBSnrQnciO9/n2coWkQVT9K0z1jd/oDPbz72fgWzfMv8QdLNDz+wyZzQ8jj6UxJfQPt1h8SIPgQTKln2LNKWlSoxVtQiIYwAqPsDSRAh5eG1hMPFYEIszlF7DTlnGegw16DZlBQwlZIrIB6sqW4mzegGZzmBT2bhl5zV6+2zxgHLMR9ZXFCWYuYd5nPb+BX0UA8G5U4c/BaJzPnt1qTHu04ZODSKOu0Ow4J40SSfj4HSHkHYhWsuFj/lzx0ktK3lxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXYrMVEc2Nmm666p21EWKS116+D9/AJqPHHmW3CFJ7U=;
 b=k3IYnGtr0dHUwYkmErkvKACTMIvcMi2WQ7vIwlxwcgqZzGUDbhhaDTQ3n3wlzkvyuEZvceXHFfpV5hKoOwHx86K78cJp02XNNk8VM+D/a4F/ORISf15t2c6ph0fHHLTqqKQ255rY3FIvpdZ1iNcGKC/k+eqmzJrkwVwaOPYTS+XxhD/qcQscENNjLDkhbt67Gz2NOwnS/rJMXhhc+tshqwJnT2VIzqhSHgfH4wMTw4zFJQJBgG7rja4ywVfsFGMSuvM6w+bIbE8EB5GNDActA2nq9OvOuwCfO9qVG5oY3QYd9KAWcuAtKx47X0GYUkcOMr5ncs3cYKo45UfCenZSpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 22:44:50 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 22:44:50 +0000
Message-ID: <828a9227-6a42-4bc8-a55e-fda9febe6e82@nvidia.com>
Date: Mon, 17 Mar 2025 23:44:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] sched_ext: Choose prev_cpu if idle and cache affine
 without WF_SYNC
To: Andrea Righi <arighi@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20250317082803.3071809-1-joelagnelf@nvidia.com>
 <Z9hZ9fgtGNd8DeEf@gpd3>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <Z9hZ9fgtGNd8DeEf@gpd3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:208:32e::17) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|BY5PR12MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bcd9d09-c740-46eb-7c39-08dd65a553a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXBOQkJkbWZJNnQzd3U5b0FSSHVYV3czekVwaE9aVER0emFQNHY3WlFpM3Fu?=
 =?utf-8?B?aHovWG5jK0ZEUEE0VjUrSDI5OXNMaWpTQ1FCdHJCTm5BZnhqNkJ4MEFrR09i?=
 =?utf-8?B?RlVtaFphaGdnYUNBdWxZcXUzQmYxV1JQdUxLZktpQ0JCWklGWjRFeXhRRkxa?=
 =?utf-8?B?Z01qdWtPTFB4UnpMSEU1dmoyZUVWaXV5Vk5Oa055RmRLSnlDQzk0SEU2eitP?=
 =?utf-8?B?YVB0aGtFRENVYnJyb1Y3MEpwb3B5bTVETGp3THB0MXdmc0J0TFFNYWZnS05V?=
 =?utf-8?B?bUlZakVraGF6NFhJTlhiS3p0OVlOUnZlWFVsaVFNdUhGYWhDa2FpV3ovbGxR?=
 =?utf-8?B?YTd0WHJmZ2VoeE84V3BCN2IyV2xBZnB6YW16VC8vcGFGUnd6REdzU1ZRSWFj?=
 =?utf-8?B?RDRXakRucGJwYzdPaVd3RzRFSmpJdjBOeFZZVHA4eWhYT2pyNU9BclZ4Q2Np?=
 =?utf-8?B?azZuc2ZsZXd3UmgrdTBxWFE5N1pSREpLZFdKLzBWOVM2NTFLQWwwaFNsL2No?=
 =?utf-8?B?cktrSk1QVzhPNFVIWDlyN0VKSGFDVWR4R1IxWmFTSHV2d09BN3dzYUtHY2VB?=
 =?utf-8?B?YzBmczRFMmZ5U0xzRjE1RlQyZzFQdG53dUcvcjhrZ3pOS2x2dkRtUG9CS2lO?=
 =?utf-8?B?bE9HaUo5bDhhUks2YXlNb3FVZ20vYmtmY1NKSDh4Y09QOEtseTJzZVE1OWI0?=
 =?utf-8?B?VlU1R0MwZEp2M3BzRUxZSVJXZGlLa1Uya0k1UmxGRjNINDMxcGhYS2Y4MGRX?=
 =?utf-8?B?Z2Nxd2pwdDEwMENEVDV5RnkvWG82RnllYXpoSFNCdmhiTC9LbkFtdVE0aXRu?=
 =?utf-8?B?QXJFdE93b3FLdFlIWVMza2NNT040MnVKbGx6R2t2eTYySVdCWkJ6ZDI3R3l4?=
 =?utf-8?B?UGYyNGIrcnRITk9TSkpBd0tKd3VzTHhzMzdZRzZYUDVkVWNNcncreHEwWHhC?=
 =?utf-8?B?RXFsNW1GNzdlVWl1bnpqWkQxS3hpS0lsazkydWg1N0kxamt1OEdFV3lZWXlz?=
 =?utf-8?B?c3NCai96dFdzQ2thbHlyK1N6bWorVXhnRGlyN1R1eU93aFN0MTBKVGpqSmFS?=
 =?utf-8?B?cWhCamdsWnhGaUJMT2hXRmtPaUdmWHpLemZKOExwN0EzS0ZQR2RCNkc1WXlW?=
 =?utf-8?B?RU9zaEVWU1pSVEZLSWo3ZERHOGFsWHNqbU5oTVh4YzZtLzU1aXN1TzgxRW9y?=
 =?utf-8?B?MEk2VTBOY1RKczgxU09HUVFGQjVmaDU5WlNwVUFLUzRzOFl1N3V2MVRUaXRr?=
 =?utf-8?B?cHdWQzhzclBqSVg5YWZ2amQ4WGJ6bm1pWVpPK3ZOYmJYRjFheXVhZ0pTQ2gr?=
 =?utf-8?B?alVMNGdEWk9JS1ZPa0FrSzdRd2IzZUVPYW0xUWQ0Z2gwTlNKaVU5T1ZVcTVq?=
 =?utf-8?B?bkNFQUhIV2g4a0xOU3c0TlpwcVBDV0NBNHViYW9qOFM4azdRU0xJN012WUFj?=
 =?utf-8?B?RTlWek14c2ZEUXNLdlEyNzNGaWJFWFdycDlWekZXMEZZTCtzNnB6a0dsVzQz?=
 =?utf-8?B?eWZQUG1valF2L3ozRGxpZU56YVRsc0RmWTBXZUpicEVQc01RenV1bkg3akQz?=
 =?utf-8?B?NWloTTJ6RDlqZ3BuMWgrZ0RXaGp1WHJGY0xxQmcyOGhRbFpMdmd5eDA0RTRU?=
 =?utf-8?B?ekFqV095T3JoM1pJRWtaMHNoTmdaOGdVN3Y2K1B5TGNBTjQ0U3JDZ295V0V3?=
 =?utf-8?B?NGJOQmozQjlhMUdWMS9ZQUlPS1lDdFljQm9yeFpFSEFmcW9DaE9ZTTJydEZq?=
 =?utf-8?B?cXQrQU8xbDJlKzNlN1VmQy8yYi9JNkFqTmRSbDBDZDRocjBjcGlocTR3elBj?=
 =?utf-8?B?UnZ1SXBqa2NXUWFUMmFUZ3BJTmVOV0VOdUJtUDNmNTMzT0NQLzhCWTRmNW1x?=
 =?utf-8?Q?IL6wzHxBG42BK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEM1OVhFSitVNVFkTXNVQzZYNFM2dEQxem5IWisrTk1ENWxyWjloU1h2Vzkv?=
 =?utf-8?B?aVc4RXppSGVaRFdaV05JbmpRSWtyODF0NW1mOXc3ekhoMXF6K0txRzJTZzhH?=
 =?utf-8?B?WHhBSFljeWVTYWc5ZVlQVjNBMS95eGRLMG5TVEhpU3Brc3FjdWhvc0tmdW92?=
 =?utf-8?B?UHJIQUc5UlBGV1Fia2I2a2Z4QjFFSmtqUG5JVHVlN3Jic2tQQ1JsRm5mK3lD?=
 =?utf-8?B?NjhJTU5EV3lxMzg1TDgxTFdDK0pIRndKNTFWUTdVMWZaTFplSVN2SXFBY2pY?=
 =?utf-8?B?VHVJZzlGUGhuY1g3WWxRMXFHVER5eisvMEIyaUJOZ1BSNWk5RlpFbUdxbjAy?=
 =?utf-8?B?bDl6YjNxaXNlTUFSaVF3VUNiM3lrMUUwM0J4WW0xTVZ5ZVNETHZlYURCcHJY?=
 =?utf-8?B?Uk04MUU5UUdsR0ppTUlNZXlCbHI3VSsvZ1Vld0hzRitLSXlBSmZ2ZCtkV1Nm?=
 =?utf-8?B?cnErc3U0dW1PUXJsVEJOZkFwdVNzaHJMaUVLOWp2c0xoTXVyaU1nOEplUEJn?=
 =?utf-8?B?ZlpOZE91OXRSN21NeVhiWnpEbUZTeFpVVjVtY1UvZGxPRlpkeSsvNzk3NmR4?=
 =?utf-8?B?YWZsdFkzaks4QTBFYXVBTkdQUGZvSGxVQndHVk5tc0lNblBuY091dk4wVmk1?=
 =?utf-8?B?MEVzVUZabWdZc2NRbEFVZXdMWk5ZL1VuNkJyL2dYZnZEazBiWDNSeDdLbWtS?=
 =?utf-8?B?ZHEvV1pRM2x5a1hCSERuRzFOMWc0QjV3WWgvN21XQ0d5TE1FS0N3cWE2Mzdy?=
 =?utf-8?B?VWpQLzZSa2xQSkxrcjFmZG4zK0o1TE02VDBVeDNpdURhNWNqNFg2WEVkY2d4?=
 =?utf-8?B?bDIyaU1veWRrU0ZwN2w2aFlmamJHd2VpUXhyVVlWdjR3T0MzcGJ1dUdJQmRE?=
 =?utf-8?B?RVhMblQ4UWZIOWl4QmFVbldQaXZONXpSekozdGtLdnZrTDZTMllCcXplZFJz?=
 =?utf-8?B?NlU3RDY1NHRFRWtJeDhqNU1XZ0hQSXA3aE5rdlg4UjJVc3phc01tRWpNbjc2?=
 =?utf-8?B?dXBMdzMzWnpIUkNHeXZNM2lsQkw2VlI2ZUZXR0xNZjZCZnoyeHFCMjBsNVJi?=
 =?utf-8?B?dTRGckExU09nVUViYlZkNU1mKzRyVjFYY2oxbksvMzczd2ZtNWt2WHhZaUxC?=
 =?utf-8?B?UDRwWEtINzEwNk9sNU9abjdmRkhsU2JJcG1sbDhuVXhCZ1VUSjE4ZTA3SGVp?=
 =?utf-8?B?ektUTUtwVmh0VUdIRVAvdVI2bU95L2ZZYnBvL0xzM0hsdHdCQ3Y5Z0k1VHI3?=
 =?utf-8?B?aDBxNTRBUTNlcUN5SHE4dk0rWTNtWFpXWTBIQWMzQk9zYnlPcFR4UCtxQStR?=
 =?utf-8?B?RjErREJFMElqK3ZLMHFtaUNMN0U2a1Q4RGtaaVJkNWpWVmhxdFhrOUJlSThp?=
 =?utf-8?B?cjhpM0hSa29JYXF5eEttMDdHVTFTZVpkdmhKUGtDU1JWUGRkNmVIS3hIdEZq?=
 =?utf-8?B?ZW5IQzUvNzNZUnpsczRTY0NsRVVZVWFwb05vb1k2OUtwakZMbGFITGl0TVdi?=
 =?utf-8?B?UUkyTDRNQUZIS3dVQmtNelA5U0xGcUM4Yk9VeVhSMmNuQ3BKZHlpK0FxNWMx?=
 =?utf-8?B?N1pPS3RJZVBUNjRTYjRlWGgxdTZTbnNkL2liTFpEdzIwT09WNi9OT0F5bk1t?=
 =?utf-8?B?b1RjVWM4WFgydWdjWkNOdDFmYjZ4TnUrT3FidTR2UXd6bmVXUlVGTW5OdGd1?=
 =?utf-8?B?alRuM1o3elkxa2JnV09rRTRjS0EwOGdSOHRYNEFNVEc2c1NNRThqRS93cFp4?=
 =?utf-8?B?YzJPVS9zWXdHNHJFQS9JbmxIMk8vWTU4Z2l2amQvQUZwZmJWUUE5V3JLVlph?=
 =?utf-8?B?cC91ZmRHTjkyUWNCUHV4TVptVEJMUjZWVlFDRmxPZGJ1Yyt0RGtBSW1lZ3k3?=
 =?utf-8?B?WkR4NU5qbmdJUjV6SEpsNlVJK0lrNDNlL29wTXR6eEZMdHY5K3VrMy9oSlFS?=
 =?utf-8?B?SnZFZjBKZHh4SjJibFV5YlhYV0tPUTRSa0JPdVFRb3FmbTI0UnJ6aVlwWnJJ?=
 =?utf-8?B?bTJaZ2wxem9KNzRpNzY1NGpnMkc2bmp3Q1NVdXpSbzJqNGhrTzdCTnZGVHpk?=
 =?utf-8?B?bTIyMVZiKy84YXdqTERXS1NtUTZ6VzVKbk10eUZoOUE2NDlDT05aM2lQOUFR?=
 =?utf-8?Q?x9nCFK6UX+JZqmXMeGkDjT0ky?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcd9d09-c740-46eb-7c39-08dd65a553a7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 22:44:50.5421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LP+clqPeM83CyMoWXE7oinL8LDqHMtKCtevbpjUOyaBFyJbDILm8g8wPVeSGwi5qNUlj+xxl/DAmRUMfQ/o3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273



On 3/17/2025 6:20 PM, Andrea Righi wrote:
> Hi Joel,
> 
> On Mon, Mar 17, 2025 at 04:28:02AM -0400, Joel Fernandes wrote:
>> Consider that the previous CPU is cache affined to the waker's CPU and
>> is idle. Currently, scx's default select function only selects the
>> previous CPU in this case if WF_SYNC request is also made to wakeup on the
>> waker's CPU.
>>
>> This means, without WF_SYNC, the previous CPU being cache affined to the
>> waker and is idle is not considered. This seems extreme. WF_SYNC is not
>> normally passed to the wakeup path outside of some IPC drivers but it is
>> very possible that the task is cache hot on previous CPU and shares
>> cache with the waker CPU. Lets avoid too many migrations and select the
>> previous CPU in such cases.
>>
>> This change is consistent with the fair scheduler's behavior as well. In
>> select_idle_sibling(), the previous CPU is selected if it is cache
>> affined with the target. This is done regardless of WF_SYNC and before
>> any scanning of fully idle cores is done.
>>
>> One difference still exists though between SCX and CFS in this regard, in CFS
>> we first check if the target CPU is idle before checking if the previous CPU is
>> idle. However that could be a matter of choice and in the future, that behavior
>> could also be unified.
>>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> ---
>>  kernel/sched/ext.c | 24 +++++++++++-------------
>>  1 file changed, 11 insertions(+), 13 deletions(-)
>>
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index 5a81d9a1e31f..3b1a489e2aaf 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -3479,7 +3479,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>>  {
>>  	const struct cpumask *llc_cpus = NULL;
>>  	const struct cpumask *numa_cpus = NULL;
>> -	s32 cpu;
>> +	s32 cpu = smp_processor_id();
>>  
>>  	*found = false;
>>  
>> @@ -3507,22 +3507,20 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>>  			llc_cpus = llc_span(prev_cpu);
>>  	}
>>  
>> +	/*
>> +	 * If the waker's CPU is cache affine and prev_cpu is idle, then avoid
>> +	 * a migration.
>> +	 */
>> +	if (cpus_share_cache(cpu, prev_cpu) &&
>> +		test_and_clear_cpu_idle(prev_cpu)) {
>> +		cpu = prev_cpu;
>> +		goto cpu_found;
>> +	}
>> +
> 
> One potential issue that I see is that when SMT is enabled, you may end up
> using prev_cpu also when the other sibling is busy. Maybe we should check
> if prev_cpu is set in the SMT idle cpumask.

Hmm so you're suggesting select previous if it is part of a fully idle core
*and* shares cache with the waker.

That does sound reasonable to me, will look more into it, thanks.

 - Joel



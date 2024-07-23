Return-Path: <linux-kernel+bounces-259972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D1093A0A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE751C22171
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84617152504;
	Tue, 23 Jul 2024 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i6VsXO6g"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34BA26AD3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721739351; cv=fail; b=sGBAwvlS149o5rW2y3jxe2Va9Sv/SYGktzrSLriZB7855OgxCoSdpAYEYj8igEkjD+KoB1ipnGZeBTyC1RaKWP3B9H2Gq2HaFb/DTS/j3jtOFW7hBjcd9cFRn1ST/sQ60tjW0sj0uWfm2GCayj3S38SlZulJuG+W4+M5ABzw4fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721739351; c=relaxed/simple;
	bh=/ZaUJEPRIQhPh7DoazWqHcPiNlqbcSkvy65mkvT6K5k=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=qwfoL2f3W6PhWU1jL5gK6LUowpLoKD8QGe4+rgcWdkMIB6hbujyvX8xwlJ6av4Q+Cnsb2xgLtNAZy/mITGBZSlXCJpz10+9RKk7iccnmiGk2I7mvqKOkRWufHr54ehfofUpFrwdAZHJcppM+Ebg+Wkr833y/G+zG2uWfnkEsfoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i6VsXO6g; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1n+a1eJJJa6SRyL/pwzxY+1+HPPR4o2hQF0c0OxMqeQPVO+x0dajq427+HDRmdmuEDxbtpVGMjgD3CHnu1EUlPNu+WZ0S/B5dhOSRC/SKGcZ5MaDq2Z8smumgVnm9ipOEDT7LnrKzCEgS02IdmuEMmQO2rKCB6Z6xtuL0SbgvAiL30fCliYeWftsNLz78pcSNhjjkqZpg1jlWyKF+a4R/Y5mHChXAy9ZK1CHDkOdRian04kNQ8QklmIG8JcSsgT/E6Rnop/LuVkockYj0ht607xd4hxFosgAj4OtTYNxGC1qaEOatDtKI7vcigc4CAan7Y2MuOeg0SLHImTGLhmbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZaUJEPRIQhPh7DoazWqHcPiNlqbcSkvy65mkvT6K5k=;
 b=wXD+PAxwjqmgjVvYXXD56ESiJDHrb6ooWJ9+FRVeAjS2OEMEPzk/mywpHo2g/knO4qFn1dNYp4PwsQHCpSeqltbPbnhHVKTuXtxPaShD8Ca+2QsNf63R2LUixz6U9YsQ1GfB8JD3hIt3Q3I9wK3bgHJzGWpzKTJw+4Gd3nopFZl67fSMgadjbbukEumLxKCmOw/rAWMe60GV5TX72z/jZSAfTamQ1+kZJ121FYkZcqUYO8pPksT84q/OAp9iOSAKUkVJ99TDuQ7/MGUKRHZbcHVFRmTyGlKPXurVQwZStN6gddXZ9PCjLM6dTgrTzWR7t59hQdrYsqpLCKf7chNJ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZaUJEPRIQhPh7DoazWqHcPiNlqbcSkvy65mkvT6K5k=;
 b=i6VsXO6gPRzNgHzbFr0aeIfBBJZlNkUH+XoGT/RYR54Ud6RgJKGkPrj4CXpcbw5p8Jl18juBxFsH+yDhoCr4meN49qUGQcvwBAuenkQzSyWehc/5IieV6/eRSYBV8VawHFtMBae9nfkOZ6RvkzEHIiK6YiqpbjFYBR4DkQ/lzLw1/pofWzsqeSFm+VFSh1YAf0qBLItC4hBSqyWQ3A+K3kTaYR0Wlj0Gtz0cPRiqU9c4WOzjsYJe3JNnsHurKZfitJBv51Fd+Egyy/y62PI9Y+b656tonaQsL7jk087BO4qlfYfFb+odIciKxcZZ51kyy67kC/7IIn97sMndcP3ADw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SN7PR12MB8148.namprd12.prod.outlook.com (2603:10b6:806:351::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.33; Tue, 23 Jul
 2024 12:55:46 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7784.013; Tue, 23 Jul 2024
 12:55:45 +0000
Content-Type: multipart/signed;
 boundary=857aeb5eb8ac595fc0fd24c31e33c7732b27998251f07fe7bdde34f72e7c;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 23 Jul 2024 08:55:43 -0400
Message-Id: <D2WXNR4E4LKB.2OILQ9OHM2GQI@nvidia.com>
Subject: Re: [PATCH v2 2/3] memory tiering: introduce folio_has_cpupid()
 check
Cc: "Andrew Morton" <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
 "Huang, Ying" <ying.huang@intel.com>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Kefeng Wang"
 <wangkefeng.wang@huawei.com>, <linux-kernel@vger.kernel.org>
To: "David Hildenbrand" <david@redhat.com>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.17.0
References: <20240722172917.503370-1-ziy@nvidia.com>
 <20240722172917.503370-2-ziy@nvidia.com>
 <6effd690-3cf2-46bc-8061-2d19922ad4fa@lucifer.local>
 <3d9ea6fd-03f4-4fd5-8407-2201e8ba5010@redhat.com>
In-Reply-To: <3d9ea6fd-03f4-4fd5-8407-2201e8ba5010@redhat.com>
X-ClientProxiedBy: MN0PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:208:52d::14) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SN7PR12MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f75f52-af4e-46c2-7b04-08dcab16c4b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0huVFRLMkV5bUl2MjJwaE5WQXg3WEJVSUQzMkNqdDRON0VRNGtwRFlsb3F6?=
 =?utf-8?B?d2gwYkFEM2hBR2VodDByYks2TU95dWhPTHoxUW9vYk1hWjU2VDRKU2U5Q0lG?=
 =?utf-8?B?Z0ZubmthOEQrekRtWWhseHB6T085TjVML0M0WDd4RCtTR1Z0clptTmh1bG9j?=
 =?utf-8?B?TDA1Z1V0dElzTmM0dzF4alpRa1ZWblFzU2lBU25TK1V4eHJlVEdXMGtzNXZS?=
 =?utf-8?B?bDBncTdiUWJmWmU3enF0ek9BeE1yMDVmOVArYU11ZEJ0aC9FNXJhTXYvdVhI?=
 =?utf-8?B?dlpQMjRQeUtlSDNKZyttdUNJUDVKTW9haHNkS0dWMkFyYkgwY0xoRDMvbTht?=
 =?utf-8?B?YTh5VUpRRmhLS2I4SkhsSWdMWWVFSmU5aEs0TmthcS9ZaHNYblM2OE41K2FV?=
 =?utf-8?B?d2hWMTFhR2dtL01FUmlZVnlKeTZ4K3EvVnMweUtXTUdHUGYrNlNPRzZtMzN1?=
 =?utf-8?B?STBuYmdtaEtKeFU0K0dQVW5zV2ZPTlJmdWp5WUZ5OVVYRTcxY1ZKOWxmM2w1?=
 =?utf-8?B?WWhBeVo4eWtuKzRVbmZMaThIc3ZKNmNVazBrbldDV21qQ1gySUtaSjhPNldT?=
 =?utf-8?B?YUd4Vjk3RnlZQ0NhUnU1SElNWTRZL0hPR2JmQ0h0NVd0THZJa0t6a0Vwb2pB?=
 =?utf-8?B?UzdVUVdWRjNSSXVSckN4S1gxRlhkVUF5c3ZkN1JnWERCUjNDN1ZEZlk2b3Zw?=
 =?utf-8?B?dWFoblhFMlQzcFAzZDE5YXhlSDZXNXUydnp2bEJrV3ZxRTh3Q0ErQU1rRVQr?=
 =?utf-8?B?MHJLT1NVUGl0aUQxcTZjYUMxVEdiazk0OEdBMHhndkVFVXZZS045QmRtVHF3?=
 =?utf-8?B?eHR1R1c3VzJUU0NHa3JKQkV5bzVQaVpzemZmOVFnYit0cUhSdFdldUlXSG05?=
 =?utf-8?B?ZEQ5cGx0SkRjVE02T29kdENBUXR6ZGp3a2h4TmJwN2lxN1hHY0t2clFEVnA5?=
 =?utf-8?B?SG52SDFkN3JuQWhDNFNOZWVjUXN0cTlHR1pZUkR5bXo4elpQOG1lK041ejdJ?=
 =?utf-8?B?Y0ZqZWNiYVM3ekNQd2taaGJHOGhWR2xEUVhCNlorNSs1Vm5VY1NDcFZ3K2Qy?=
 =?utf-8?B?SkcxSVpNZWRDdzRycUFnSy9JWHAvR3o0RmljWGtjRThWLzB2eGFCYVZTaEM5?=
 =?utf-8?B?Z2Y3K3pwSHRVSlhKUTBnb3JoRUNNYTQ5Q08vUW1TVldWZ0oraytXdFJZQXdS?=
 =?utf-8?B?dGFaaXB3ZWg5ZjRtWGE3MWN2RVhzZzlXUXhVaFB5Tm1jR0g2Y0JGUFliZm1w?=
 =?utf-8?B?S2VrQWVvV3RhUXlrSXREK3NOUUl5L1dxcTlkMHdYdnlISFNBak8yNlBTRDFP?=
 =?utf-8?B?Sm5JTTliN1VkTmkveHJyY0l0MDgzbmM4Q0R5Qzl5WlZpeGN5VDVhMlc0czRO?=
 =?utf-8?B?NTE0UWhDZ1p6d1E0ZThVZForSjJUdGxaOFhjNTlEVkY5d21UaEIrZXlpb0p6?=
 =?utf-8?B?NWxkWkphQkhoL2grVWc1UkZVbFJ2bGFBVk1Lb2JiTHlkbVBJTVVXTGNQNUkv?=
 =?utf-8?B?Z0IzSlkwRzRBWDdJTWNpdjNWSldpRkVHb3FiMDc0bGJtWmdtY2UzWjVyc214?=
 =?utf-8?B?WmZ1d2YrRS9JUTd6RnFybU11RFpXRXJFc05vSjNkWDNSSjhYcjhmVkJBSllx?=
 =?utf-8?B?TVdjMk53Z0hJWW54K3ZENkxLUmZxWm00ZnZEYzZvV0NQdzZJL1lxSk02ZzRq?=
 =?utf-8?B?Y2VrSVFEdzZKYUVHYnRzd0J5UUo5WjZocVA2MnJTNExoMlBpM3h3VklPdjhO?=
 =?utf-8?B?UzR0cWZ1bnVDelpScllMSlB1ajFaVTltNEpDRDFnR3VIVjhDNHEveEZGZE5r?=
 =?utf-8?B?ZUdVdG91SFlMODhaTkZ2UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ek1kZjVUU2RCeTJ5ajEwY0VPc2N2MStMZGFMSkxKbXpBOFdnNEc4TTYxdnhC?=
 =?utf-8?B?amp3ZmhxMFBpaU9vTE1kYzVySy9Ga3NhN3lMR3V5dlU1OWxHWlBNRXhPSGpF?=
 =?utf-8?B?L2ZEZWE5cU1SZHA4Tkg4ajBuUnVjZ25GOTF3bDI2SS92Wm9BUHlzMWFXNlFS?=
 =?utf-8?B?TW5MaU9zbzBCbHVRNlY0SVdoSXk0dTBnWEw2cFQxaThWalJXek5POWJIUnJO?=
 =?utf-8?B?aFVoekI2VWszOVMxT01XM3A4NFBsR3o4OHlMeGZLR0NTMkJyeUkvRWRiNEov?=
 =?utf-8?B?Q1lsOHdJa3RaL1c2M2IzMTc5SlZjMkZQNXY4bmx5WkM3aWd0YkxMQWVOVHRu?=
 =?utf-8?B?SCt1SWJxcmhtQURkUlJRbzh1RjlPdjFOQ1RqNDVqbVQwY2NhZGp2OVJ1UEUx?=
 =?utf-8?B?a1RuZlBXL3NRdDVxd0NsMTlMbVg1UTVrUEszN1JXUk9XZTRVd1RFMHNlQnQr?=
 =?utf-8?B?T2Y3WE03U3ZqZ3hqdjVxOVhtL0ovZ0NCbXhpZWNzcU1qUjF6djlRNm4rUFJV?=
 =?utf-8?B?dmRINmVaMVp3REVlbVQ4UUgzS1lsUGp2aWMrRVhtN3lCRmpYNUhwQUhvWUp5?=
 =?utf-8?B?bHRNbG8zRVFyUHpkWUY0S3MrSGQ0azZnM2UwM24wZHpwTnh2cStjVHhzT1Jr?=
 =?utf-8?B?SDlBVzVOOUk0bFB4NUFGVS95UFFiOUZyM2FLZ2xzSTVtVWp2Z01jTHhxa1BS?=
 =?utf-8?B?Q1orS3lBa2pHcU5QY0pNUEdDQkxLaHNUNUNzandzRGFaMW9OQkdlU0gwbjhl?=
 =?utf-8?B?b0JWTWZPcFY5QmZmR1lST1RxNFNxaEFZSFpnV2JMQ0lxd25tWGo2Vi8wbUdK?=
 =?utf-8?B?VEZqMldhR3FCTGxDc3UwNUZIOWhjb1NSRCtaRWxyV1ExdUswTVdzQ3kzQ3VD?=
 =?utf-8?B?Sy9kNmtqSHMyL3hIcCs1VC9jeW5GVVMrMHdia0VjTG5EZzZGRGI5Uno2TWNi?=
 =?utf-8?B?RHQrbzV2R05wdERObjVTejZONnc4NW9oa1NLa0tGK0ROaXUxVGJoQ0tqb3ZW?=
 =?utf-8?B?Z1kwVGplRlNiQ29UdVlUbmlUbFJqSlVMTU5HU2dPQkxQTkRhMDRpNzMrSEZG?=
 =?utf-8?B?ZXhmQ1NpdmE0V3lJeHNBZ1FqbTJjUm5NREVpSGwrSmhHWHZaV3N6NTZsbjF2?=
 =?utf-8?B?WWIweDNvN1M0YXlUOXFVTlBjdnlUUHJXaEEvbFlJVDN5ei9rMEV1QTYyUUpi?=
 =?utf-8?B?QTlremlPVHVVQjRDdEM1YXF2ajBDd2UrMG5BQWZLWHh4d3RiSUlLK2NEQ3FR?=
 =?utf-8?B?NGVPdTNLNGlUUUZvR1lRMjNucmdPdTJQSUp5ZWtJeXpKTVBsL21palVzNG40?=
 =?utf-8?B?a0JMQ0NvNkh2RmVYS2wrTU1pZ3cxc2RaL2NCK0kyTWxxTzQ1Z0RZZ09GK2xB?=
 =?utf-8?B?d293Ukl3TTVFdkp4c2hJUnUzVTNJQWNMbU9CQ0RieGVkZDBFRS8zaEpCck5R?=
 =?utf-8?B?amZMeHFBc1BGOGFzRnY4RllGSVFNM0JhazVqNkU2WGk4amFHcWtlUVhBQkJ1?=
 =?utf-8?B?K01SSHI0MERpYmZGOGpmVjNGeDNKbXZ4Znk0ZWpUOHN3MlUzK29uR3R4VWVw?=
 =?utf-8?B?SC9hbUM0V1hOcW9pdm5sK0VaWWlGZWR6T0ZCSGJqczRBMG9MSk0xU0VqM0VT?=
 =?utf-8?B?K2FKMkJUVkJGdmMzMlZsa0FjUHVyN2pENVdWYmRQV29mc0JUakt2ZkU0Vm9r?=
 =?utf-8?B?WndiR1VWTTRycFc4dHdpOXVGR2krUk8xcXkyNTlJM0J1VE9LVXNvOE1YTk11?=
 =?utf-8?B?U01iaEQ5MmdkYTVkRm0zOVVla1NDYjgvYjZuMjFobFNDR2dkaGtaRkJJa3Y1?=
 =?utf-8?B?SjlBRnAyb0xBMS8zaWMrWDY4a3ZweWZXcW16cXhWam11N0dwMDdzNG1NcUZZ?=
 =?utf-8?B?RFBjU2R4WHhzeWJqaEVRZ2NBNzRYZWN5eGw5MGxhUUE0dHk2OE8wT253TjFI?=
 =?utf-8?B?TlZMM0FiUnZhNWM0bWJjdmMyTHdhT1JSYVV5SWlnOGxDQzJHS24zNXNvamxx?=
 =?utf-8?B?a0VST09OZ0xOUnJYS1VVRDlJWWM2RDJhTDJJdVdoRGk4RzQ3Q0RuMHlMNnNG?=
 =?utf-8?B?T0h3L3VGRUtWeXVKdXlWMVRDcWNSa0ZZWEpGci9uejh1eFBhUGxiTFBwSXJy?=
 =?utf-8?Q?u5QfIaim38SBKkqdw7DSmen/n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f75f52-af4e-46c2-7b04-08dcab16c4b1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 12:55:45.8608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SeEJhpsn6KZbiC0Tce7yEQHWfkkMBxm87W/d5knkGynnfbuF/VUYHYw9XjMK6Rud
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8148

--857aeb5eb8ac595fc0fd24c31e33c7732b27998251f07fe7bdde34f72e7c
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jul 23, 2024 at 6:14 AM EDT, David Hildenbrand wrote:
> >=20
> > The static version of folio_has_cpupid() is defined in include/linux/mm=
.h
> > if !CONFIG_NUMA_BALANCING but you define the function in memory-tiers.c
> > unconditionally, a file that is compiled predicated on CONFIG_NUMA.
> >=20
> > So a config with !CONFIG_NUMA_BALANCING but CONFIG_NUMA set results in =
a
> > compilation error (I just hit it this morning in mm-unstable).
> >=20
> > A minimal fix for this is to wrap the declaration in:
> >=20
> > #ifdef CONFIG_NUMA_BALANCING
> > ...
> > #endif
> >=20
> > I've tried this locally and it resolves the issue.

Will fix it. Thanks.

>
> Agreed, with that
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks.


--=20
Best Regards,
Yan, Zi


--857aeb5eb8ac595fc0fd24c31e33c7732b27998251f07fe7bdde34f72e7c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAABCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmafqFEPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUxHUP/iY9v4aplc/TGkmgmNdEvBCtj/rSP+jFrHAr
16NMNP3XUTYnhr9pIENaqvWaxTJC6iXhRUEy7WloB3NRSwSFhf5uJuzoS4TdVjyE
sUVwzDx7nFHwdMQFAYB1k5HC5BJ1WJuPzfPcrCUu9OMof1qfrbt/jErskHu5xMzk
8a4bUL30mGZbr0+6UGcYBzoAC04ZmGQE7zgyH1ph2CXHcAm9Mueim7VrpTcdgMgo
3WUyDoIXaRRNFW33+LaFcIZ4pz+SYnq5zYOwnKaQTNUoaLztmFFqGAuQrc0tejsE
reoWW0+tf2ymMUpCSbs9WhQlp/ITqMbT55oYHwJwSJmV/3vbA69067IizeSK5EQQ
7QUZd6oI7PmHNOuxGBl3/1s4rkElfMS3dEPGhm2BASNVJvc6DbTLidEkx1b7mIrg
/XbrhHMA7rng1fthsOIObfwTX7reDHASlC0eav+RQQK0yXRDs+ZJM89QnYlyPXxV
2Kay3OFn9VuHdzslo0OL5iQj79zw2jd8bbcDo3FBKnS11fDCPfl+S9cZOG9EQ/9E
6qP5uIL2rxsfepY60wFo/C05AJFh0sOWu8CAle3+lQXy4ct20RRrbSN2vkVw8FYu
TxW0tHsCQE7nviHt/Yj3InM0gFMkisqp5PE0xBBPPrI9X8gFXwpoNURXbPzrJpmE
540lD5E7
=SmJf
-----END PGP SIGNATURE-----

--857aeb5eb8ac595fc0fd24c31e33c7732b27998251f07fe7bdde34f72e7c--


Return-Path: <linux-kernel+bounces-573092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD985A6D2FB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 03:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592171892C33
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 02:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9213073176;
	Mon, 24 Mar 2025 02:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="AyBQoUTw"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2040.outbound.protection.outlook.com [40.107.215.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DEDC8E0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 02:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742782397; cv=fail; b=g90isc192fVtn3fzJzjrlGvKG+VVBV2SPOz0HGySUFhARaZq2tMZlK6P8mdTkoFgDfg4P4zAI8eclT8tbIXifsSd17FKSR/+NltAgKYf/pIMS/oGTgDTvQCouWZolYpsY/XNgYcW/w3MZGd1G7rOd2aBLVmAE5vvoVFBVblW3YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742782397; c=relaxed/simple;
	bh=2nSA7PpCAqZf2bvLtTxIe/ltVbSD8E32bLVJmHX0vYE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a1AKpFO7mBxqTccJZLdvr46sw36BvOcbC25Abb9g5mbOCnxfRFQrP5abttlVQXa7BDG83KzLBYYRnyjh6D3rIQGn2nN1rD1IBSOrM1Tc/8QV2Wi34jAEVTcI/Dwn0wK7TPs76yIbdrq3GIfq3N0K/l7BvatiSwydSDwQPvePlvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=AyBQoUTw; arc=fail smtp.client-ip=40.107.215.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBR1TCDgEiyGsjdOUcWUAJG157OiJt5OltPkFXV5WlI4NNBRw9VTb1eRAP5u1NHSL+Goo9SKy/9r8jL6pDeRSPGJ1r5tvYzMpMlPpvx1hs34mM9E5Xxv1Pd0yvvrcGdyhJQ8UC0LaQL+M610RBLoeZ9oyUwRwVqD5UoXded+bBXTWAgFfs6TJ9G2sob+x2AMrshGMuIiIgkcg/oGSFa5Donw1U99065dnBTlAKaWTrzHEbwGs8DkTBHQKlTQwLN118tafH2Mu21qdxMCt0LAqoGcsjATfeDdQWhwFNTTbGQZccqCV42+hlCdsSMVvMFXr7oNP9oD0yt91aUXNdlSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nSA7PpCAqZf2bvLtTxIe/ltVbSD8E32bLVJmHX0vYE=;
 b=uQsE9n8F4zNY2l5ebyGWa2MnOPcgtbcwK2jKTCmoTys0hQbiXl+hFOdPIs9TrbS93oqDzQgD5Qccuo0k9So7nwAP7s8ri10B4d1jKMiv5ZiUw1+ATy+84BIh8dJVWOpMydYfaoDMTjjX9ZKrWZRsKM4l5cqTJTTfR2Tv63k6cYPtO4fSwI0W6bXu1JVjQUntZB3iISbyI4xk3qQKf7CvjEWHppIP5Wbq0zn7hK25bMQQvoYC5LUVwrgdw2UwNbbfh8ImiNrodyw/Wy+zDvdmaQc66udt/Irt+u+/j+HZSCbh/QCyZnqv6tCUENLognskuAmr6mZl7ZDzLLxGlb5L5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nSA7PpCAqZf2bvLtTxIe/ltVbSD8E32bLVJmHX0vYE=;
 b=AyBQoUTwH1rm/gGCCddvAANlWRNbOQOWxfjNmtTNpr13Bxji8UqoXGNohu3Z/FcMTAvbMpA1JN5GtChLMJdPDYXjcrBB2e5g3auHARfKQNxZXcRcz2b8NGrwW+cjMqLIKPIPDX5e9jNxzI6aTTlYQLhablvEBGBEeRKlzIVBHuUi5nqHTh6y4J3FSPabuSF/QWuXJKQsg8gy/NFXqqpVZg4+4uXIi6hx37v0f9rbKFv+NWlY2cqsI6C5dRAomtnBA9LwVeFdYyaB31mTFu+G6WY27oD5mfkK4AwWCEUn3OctTAKudwISPBkpRRZvz0VG9V260/jIdF37mhCMcUJ59A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by OSQPR06MB7279.apcprd06.prod.outlook.com (2603:1096:604:294::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 02:13:11 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%3]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 02:13:09 +0000
Message-ID: <752e606b-640d-46d1-a8e0-fa714b29a7b6@vivo.com>
Date: Mon, 24 Mar 2025 10:13:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
To: Hillf Danton <hdanton@sina.com>, Christoph Hellwig <hch@lst.de>
Cc: bingbu.cao@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, opensource.kernel@vivo.com, urezki@gmail.com,
 vivek.kasireddy@intel.com
References: <20250317055304.GB26662@lst.de>
 <5a12454c-16a1-4400-a764-f49293d8dece@vivo.com>
 <20250318064805.GA16121@lst.de>
 <5229b24f-1984-4225-ae03-8b952de56e3b@vivo.com>
 <20250318083330.GB18902@lst.de>
 <bcbbc2e9-858f-46ed-909e-1d911dd614f0@vivo.com>
 <20250318084453.GB19274@lst.de> <20250319050359.3484-1-hdanton@sina.com>
 <20250319112651.3502-1-hdanton@sina.com>
From: Huan Yang <link@vivo.com>
In-Reply-To: <20250319112651.3502-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYXPR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:403:a::20) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|OSQPR06MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8373db-0bea-4aa1-c897-08dd6a796bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmdzUnhvMjd1T1l2ZTVKRWJab0Q1M0VXejgxNG15WGxQTEhXSGJWYTgvcVZL?=
 =?utf-8?B?Vm9yV29iNG9BN204VWVaQnY5VW1VWmxTNVdNd2RrVExicFdqM1lKWmxzVVlo?=
 =?utf-8?B?TkxsL0xxa0V2dWpucGNpa2dDZ3JZcDB3alFqL29nQUZCYUxuQkNzeVZrajl5?=
 =?utf-8?B?NmN1K1JiOTlXWmJ3TTJ4c3NPWFEyWW5SZENlOW5JNGFWU3hFME5kRkVJMWZI?=
 =?utf-8?B?ck1LNXpxRG9UUnFsMEZ3ZzhCb1FDdmhMZWtLVkRKb0g5N1dyd3FOcmt3a0hJ?=
 =?utf-8?B?NVFscFJMcHR3QVlVUnRPSnlyeXhWdXBCQ2ppVjdVdFdkZ2NzMGRpdFVUbUp5?=
 =?utf-8?B?aWpBc3VZNDVWK2taRjJGLzFvU21pUWE4Y0dPTzBkQ3B0b1ZSNDZoUklDRDFt?=
 =?utf-8?B?ZlV2L1JSUE9MWVcxekNsdmUzM1h0dUdxcjVURnR6Wml3V09YaFJ3dHBJTnFn?=
 =?utf-8?B?Uis1VDVJN3pHV3lKMCtjQWtYRDY2YUtXZnpCUWkxb3VDYU9UL0NxWjRKTzVS?=
 =?utf-8?B?WDNHNnU3TXh1OVY0eUxjNTlsc3RzK2NmdHVSTGlSUGlJNTBOdmdXVy9mS2Fm?=
 =?utf-8?B?T1JDMVlJakVDTFEwczU4elNmNEhQTVhadWN2VHNLKzR6OS8weStTV0NIV1lY?=
 =?utf-8?B?K0hpZmdkbEx6ckhjZDlwVUwrZ3N4ZnhBY2FSRDZsZ1BKRUpUTCttdVozalBY?=
 =?utf-8?B?czJGSkg0OERCM3lxUkJBUlRjRFphSjB5cWRNdXBDYXkydkRPRDA2TzBnMS82?=
 =?utf-8?B?d3c0enBZU1RrakxhaVJnajRYQjdKUlZPdHZBS3lJb0trS0M2bnZCZS9hZFda?=
 =?utf-8?B?UlBaTFNHT2Q1Y2xTcHgvbVJsNlJlc0xwR1dVNzRYREhHVEdCQ2hJMUV1U2Zw?=
 =?utf-8?B?cTRkUEFxS0FOVDgzSzgvTnVra1dXd0VIcE1Ld0Z1VnF1K0huaGtEMWtqVXhH?=
 =?utf-8?B?K2lHV1luMkNuOUNyWEZ3dFg1ZzdveCtiQU1zY0R3Y0RIZGpKdTM1dEdzbE1H?=
 =?utf-8?B?UG5zVkl2Z1JHcjFWdzh6bzgyT2ZBdlZyK0haSHM0WFQ0a25RbDYrRkFyZXE4?=
 =?utf-8?B?M2krdkM0S05wSHFLVEZLeU5Hci9aNWVuYXVOOWpjYjdRbDlSWUNYV0JIdWo1?=
 =?utf-8?B?dFQwdXhRc2hCTktWQXVYRmJrYUxiTHVMdmNVWGcrUGdzZjhuMzVsbU5MMVdO?=
 =?utf-8?B?ZlQ2VHp0eW41dkRZaW1vUHB5ZXQ5UTR4TU5PamlZRDd5Q3BGM0trQ3FJMHVI?=
 =?utf-8?B?REI1UTU2clcxcUdTYkcyUEx1TG1YU1NKNTMxY28zVnh3MzRhTWlZN0puRlo0?=
 =?utf-8?B?akg0WWEwSmd6aWZqY2VHSklBQ1ZNK01TRjdWTWRwc293REV6dDZ6RHJ4b2o0?=
 =?utf-8?B?VSt3bUQ3QXRWd2IxdEdyVE1EOVFleFp3S1lRdUtDdWFvTVFwUFlTY0VRdEth?=
 =?utf-8?B?aTBkdjJ3bVR3UTN1VFN5OUhlQ1VKUHpxVExwcHl1UTVPa2JxMnRqRlJkbXBK?=
 =?utf-8?B?M01ReUtYSVV5ckM5c3dHdDdwTm40Z0FoelhPTFFxb1UzTWJxdEN2SzRFeXE4?=
 =?utf-8?B?cUx0ZDFBaEtSWHoybVdxU1dtRjZnQ0dPWkZMY0RWYkViU0xQaGRlWEgwVnZ6?=
 =?utf-8?B?OUs3UEx6TTQyTlYyd3JiSUVkQVNaZHpTWjlqR2tqeE5vN0pvMUxLck80ejhw?=
 =?utf-8?B?ZzR3T25zWm1QVDRRd2NSRy85bkVjT0M5Q0t2T3o3NmU4TFdpdnBDYWFFWHZU?=
 =?utf-8?B?V2RkZjZlYldwekpYRTd2RC9NREJHRUZ4VGt4ZmI2MU94dzkwL2d6MlNSQ1lv?=
 =?utf-8?B?aGc4VXRwYkttc0ZhMHAzdWNpdEthOUIrYUUwVXJoNk5Ed1FvNEU0L2dXZ1dS?=
 =?utf-8?B?S3l6VlBybDRXMngzWHZoMFBXbCtoZmZIemovUmxpRll3WXJMK0VCWUlyMjI2?=
 =?utf-8?Q?EoZedR5yepD+ymWd0Mac+A3UHI1gB1Zv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3dpUWM2T0ZtWlZhMU41TWZyZlVFaU5iRnRlUVVpZTkxcHZQclArTVpCK0hR?=
 =?utf-8?B?aVJiU3VmV1J3ak04ajJ0STJ5SVEvaXF2bXZqcVh5dEZ0SkJxRVZub3NhS241?=
 =?utf-8?B?RmNQbEpoWFZlUXljQk9JYXJDUUtOT3M4d1JQWFdFNTVyODZoNkkxODJHZFE3?=
 =?utf-8?B?MDNERWZvRHBSbzBVTFAwRFlZMm1nNk9QUzNFOHVJbHF3QnJPZ3E3YUx2SGtJ?=
 =?utf-8?B?cDNWMTJGMFFDbUMrMjdMM25DT1BRQkwvQ2RMbURkMDZydXBOWDh5RzEzRzBt?=
 =?utf-8?B?eHVlbmcxZGIwdEF5K0F0SnlWL3UwMklMYkQzL1JKWUlRYzljTnBBOWwxU0dH?=
 =?utf-8?B?OE5pVTBOVUhOdURtWmpocWZYUWZxc0gxc2s2YTgrMWtGbWV0U3ZlVVFMdFV3?=
 =?utf-8?B?V3M2OUJXN3lqQllseGw3WjRRRmRYc0pvcXlSa21GbGFXU2VkN1JjaFpnMnhF?=
 =?utf-8?B?N2VXRHZBamp1VEphTzhWLzlBZ1I0REFEL3I1NUNlYXQ3dG1lRnQ5d25XanV4?=
 =?utf-8?B?aG1ONUUrKzVrRy9KeWVHRkpzZTVkN0xrUkx4VkI2Y1p4Zk1PbERIQjZuZVZL?=
 =?utf-8?B?RThTZmgvanA3eTlSM3UwNzBWOVgwU3JXSFYydjc5ZCtmNkttNmc4L0dPZjQ4?=
 =?utf-8?B?OXRzUXhKdnlKVENuZk5IU1A3YjdoSjZjS096K2JCdEhkRnB5RjlRa0p5Z3Zv?=
 =?utf-8?B?cVNOVHpuNVFmbVZnSHQvOTd1NEpMeWdSNWZHdjR6Ti9pTkJvTHVuM0hvQ2to?=
 =?utf-8?B?MVVQQWJ1dkw5SmUrQ0tBeVJXc2ptQnJDLzg0UXBKRHUrVW5GWWc2d3drUU5K?=
 =?utf-8?B?NTQwSDdJb3hxTDBVQmdsM3gxUkxOZXZaZ2VKeVFrWHoyb21pSElYQ0pNakpM?=
 =?utf-8?B?a3JLcXhZZlBEYlViMEx1ZXV0VkhsTlZCeGdTbmJjU3M5TkJsekwxWE84LzZo?=
 =?utf-8?B?dTRVK01WTWhoVGZydmRYd3lpb3lwcWhjMmk5aW50SmxQdms3a1FKUUorM0NN?=
 =?utf-8?B?VklwanJ3OWlqREttNm90M3pKek1qZEdJc09JLzV3SVlsSk14cWxoMUJBblUy?=
 =?utf-8?B?bFM0Tjh6azJQOUFjNEo4dFMxUTJLVHNiNVpGUDJndHJuSzVFQTFTTUhDZ0Jh?=
 =?utf-8?B?ZE5mWUJDYi9lS25GeDFDTUJUOG1iYkpkSmI3VS9hYmpLOHIrbSt4U2FJMlNR?=
 =?utf-8?B?MjBSUzhZMDZ1ajFpbzh2Z1l5Rms3cUhiZXpGNS9CcGYxcC9ldmdQR29DZ3B3?=
 =?utf-8?B?QXNYczFBcUx6bk9tSXVoVk9DWEw3OXdKQ3dlMDFuTnVyS2Q4VEdiWHVERWtp?=
 =?utf-8?B?VHJzUmdoRGtXenRlVDhzcTNwa0VWWGxWMnJHc0ViK1AvS0w4Q1RWYm5pUi9P?=
 =?utf-8?B?N1h3d2NNSjNCUFNEQUpxbXNuVlFZdjdEMFIrUFhlTjJxZzRBUFNjbnd3WDJ3?=
 =?utf-8?B?REV5TllXei9PY3BVVEJxcklUUTk1VStnZE5RMmIwRW9kWlc2V3NKMzhyL0Jr?=
 =?utf-8?B?OVpCUTZBSU1vdUczY3lmWUlNOEtHalRSeDlYWGlxeVNVY0dlZjl6QmhvNDJC?=
 =?utf-8?B?dXpVazZHSENvM3pkMEp5eGJSMCttUVdjdEZXWXN6aUhHRHAyWCtFTjByTk5j?=
 =?utf-8?B?cllpRFVYSnEwUlVJazVuZS8wRzdSTmlUVGZ0UlN3SitXYjBIWkI5RTJjUzJX?=
 =?utf-8?B?SUdzYjhPWUhDUmR4bXh1YUdJaldzeVRSQy81VkJ5YjBOZVVTRkFCWFBSVEtj?=
 =?utf-8?B?K0EvdnVYOHV1UU5GUGdDOThZL2pGTVpJa3B4WS9tTHVsdi9PRDBBVjFkaEh0?=
 =?utf-8?B?Z1V5S1hiSDZnQ1VVM0N5N1Z1cXNHNklRTlBVdmVpNlBhYkZqM3Vsc1ZCSXdD?=
 =?utf-8?B?TEpESnRDZ29hQTFiWm5sYkQ2R3p1WkpsU05LYWVrN2tzVjVKQlBDZ09KRHpt?=
 =?utf-8?B?MFErYzNQdndOZzFxMHQxZUFRRFJjVHUzTTd3Rnh2d3NDMkxYSytWaDF6NTVY?=
 =?utf-8?B?am9MTyt1dVlaZDJKL2ZmZEw4REl3OGhpaC9IcUxCQ3ErclVpRnI4VWlmc1ll?=
 =?utf-8?B?eStQSVVYS01SVG1ONnVkSGFzTDNyMThZYjJPeWdpcnJXMzdHcGFLZElBOEps?=
 =?utf-8?Q?6+u07qtBLHvJ21Pwn1FVMAf9y?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8373db-0bea-4aa1-c897-08dd6a796bad
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 02:13:08.8611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YTIt0+HlsbuptBGLxkLU6sjBypXCZF5oNJRP3uPYRvSqEnH5cxKyFnocrIAaT3HUHjIr3a4Mlv7U2jgcNdyOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7279

HI Hillf,

Thanks fo your suggestion.

在 2025/3/19 19:26, Hillf Danton 写道:
> On Wed, 19 Mar 2025 09:08:51 +0100 Christoph Hellwig wrote:
>> On Wed, Mar 19, 2025 at 01:03:55PM +0800, Hillf Danton wrote:
>>> A quick fix is to add a vmap_pfn variant to walk around the pfn
>>> check in question, like the following diff (just for idea show).
>> No.
>>
> Patient to see your fix, given no low hanging peach left for Mr Folio
> in case of HVO, (feel free to ignore, who is likely about 2.6-mile
> less tough than you could be).

I now believe there are two way to resolve the HVO folio can't vmap in udmabuf.

1. simple copy vmap_pfn code, don't bother common vmap_pfn, use by itself and remove pfn_valid check.

2. implement folio array based vmap(vmap_folios), which can given a range of each folio(offset, nr_pages), so can suit HVO folio's vmap.

1 is simple and can fast fix this issue, but may not too good. I need discuss with bot Christoph and udmabuf's maintainer.

2 is hard, but may worth to research, which I also will try to do. :)




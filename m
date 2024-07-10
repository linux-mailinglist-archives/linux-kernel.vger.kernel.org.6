Return-Path: <linux-kernel+bounces-246917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0480A92C8E9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A751F23CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3336239855;
	Wed, 10 Jul 2024 03:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="HpQAZwjo"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2070.outbound.protection.outlook.com [40.107.215.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFBF168D0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720580766; cv=fail; b=F7l5r4DaJW2GH+AzwE4gi2sAp4HSTPdD23g2vPgIK15acvmdqQdRi1nDJzCsS0bW71ViHx9zXEN+pE26Z4aN4UDl/4ShstKfM0wBGQ6vTRm6xp0w11B0ClAc0qPT93T5MoDPuNzP6dhec9k9ESQUUwvJcBshLq4jt6VAm2PBgWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720580766; c=relaxed/simple;
	bh=1oiDfYrs0dAKpC+obxtQnCzafjHkUEuGGgYedo2uFGw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XHHALGhsTMmh/t7TcPacrru+nqos2G2qvWvYHJ3+ISLIoA+psU5O+M0Dynx+sntJSCmRcOv1jf+nNOVU/rZJFu79ua33cRoNroz1SSmLBNdofzzCrHPjm19Q0qbcTi1pqTplbaMz7vbE+zEE273Wi5QwYgKc/NqjVpopqoPVj1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=HpQAZwjo; arc=fail smtp.client-ip=40.107.215.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCKaf0rydjS+GtrcTjlD9z/9cKW5wGnNKss4OtAu3KMFkk4pMLug3KBMopmzfL75ytiJkr9lNTjIVXi1OBlRbFEX+FBNLeKYugoFQJf09VT0Ojl9CsNll11zt82wnF2jT6q7Xia3w7QhyVjNCMKYU4W/C/5TQezt9Hk5ALSsUi8IXX4Bax6iDhD8Kh5jfoqGQW5Iwpkgd+KZLeCmlERiLLFfTOo79dcH+ksgct7ykYsV1varWorWRk71wEphNkQcvvRVConSsPC/PfSmxCjjKbS67r+Ob37isriPsO5cUJ4uXPei54tVIncDEFDkwC2YdmCIMD/sqg81deYKTFS+BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MONZwtHh/ZBLZ2ju1G2NMtCjtSA/Y+5JQIeoTg5Kxs=;
 b=bx+t77m1Monpp/8Hux9PWv8OEROek5TH9mYGtlbvKRb7AwYnPINg62Uazjkzj8BBE7DrVqOe9HSFgz8JwM2bcBfWpSKvPxmx1+jFIUGEv1bssjFXySZ3BcymbPvfLDG6m7jCLYoeGk7bqhwCgrt/98P/EW8x0wJEajAzRdt6MHfxeYBbbCbxXv8RU7vYL+S59lzO9XyA5XESrOumH6vjqt4TynKdTdZzuld851xhMa/kGV15Y4Q6wbEcXEm1l/+Qx2ptSEH9fXB1zG2Y44LaWKvoiMHAK/0xchTZB88USxuG3qEnPdPOCzEsNbNfvk0o71EDHkoP4nKyA+rJx1AOTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MONZwtHh/ZBLZ2ju1G2NMtCjtSA/Y+5JQIeoTg5Kxs=;
 b=HpQAZwjoEC/wE3JNW7jhmGj7jIYiMFsHqMohrSgkMyhCti0qJHPcORU7iFvVzLQ2AvBKKNgQGfEzfc10x9Zsoz+xe1Kfn9fwtTKfyJvgckj5ap0rRco+W++IdswQwCrxQ8jL0Gj8/w57tWgqPElmqSNzSHtMHnHMfjzbdVp5t/hKv9bpR9WeMimCmOr9ojSbx6wOyjlzvMGH171OCJ72GbthwJnw07DLa2c/Zg6ObZTgC7Pm5SDbgR/6Tyhtpk4N2YsKnwxDUUiW4EDDjULErcxRLJMoupwZqGkWF5THtX6DHoywNyDM/ji9IFQ6dsPKjqQoClxrbFfpG+n/YpIulQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB6014.apcprd06.prod.outlook.com (2603:1096:101:ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 03:05:53 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 03:05:53 +0000
Message-ID: <2450be89-f729-4a75-a008-90ab247313d1@vivo.com>
Date: Wed, 10 Jul 2024 11:05:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] mm: shrink skip folio mapped by an exiting process
To: Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, opensource.kernel@vivo.com
References: <20240710023901.1624-1-justinjiang@vivo.com>
 <CAGsJ_4yX5K3ytepCAqRbHfiEUKGxApvSin0d2ohK3ohGu7CfTg@mail.gmail.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <CAGsJ_4yX5K3ytepCAqRbHfiEUKGxApvSin0d2ohK3ohGu7CfTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ff224b-4a4e-4688-f0bb-08dca08d35e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjlBcVlXZUVyc3FyblByRFNza0RVN0YvR1NvUHYwZlZLL1hROUFUT3prWGVW?=
 =?utf-8?B?cFhCZ2wyMEFWaVg4MnNGQ3hzWUF1eGpQcFlSR1lMTlhCWE5xdU1XcXFjTmVu?=
 =?utf-8?B?UTQvSXdJUHlGc2gzK3dQYXJlcEVzK1ZZWC9SRDFrRzUrT3p4dUhEbXh1Q012?=
 =?utf-8?B?Q1NpYW5kUU5IVGJqeXM4dVl4WHNZOGdoTjdCVDRwTmJmaTNadlN1eTFaTXJJ?=
 =?utf-8?B?U1pBdC9QZzBLdUdYQllmUkVJZDF3ZHhtWkx6RnUveFBqdElPZHg1aHNMdUZL?=
 =?utf-8?B?S2ljdUJ2MERuZXVmd2g0NmUxSU96TlU4bUJYT2h4bm1ndkpIaGVsUkR2T20r?=
 =?utf-8?B?a09qS1NmMW5VR3lWa3lITWZPVHpUMk9TdEhuL3hKdmpZV0EzVUlFR2NFakpK?=
 =?utf-8?B?Wlo0cFZTREJUVk8wQ2FlOGxQRWFPUXZvQUZIa2VzdG5mR3RmTE1pK3Zqa2Iy?=
 =?utf-8?B?V2pObmpKVGd4WEFVR1RMakFpMEV3L2ZIT1F4QmZBbmVmeFJOWFZ5UHZQOE5o?=
 =?utf-8?B?RUZNVDRpY05LTWl2OWNoRXUvQ0d2VDVKOElkNXB3c2JiLzk3M3VHdUtWUTRm?=
 =?utf-8?B?dW9wNFE2dDFMVEVKbndxdXI1V3J2Y1RwdDZEUkdQYThTeDhxbHI0WXNTSVp4?=
 =?utf-8?B?Q0IzbHorUWJKRk1GZitjTjBIS0dvNzlIenBwQzVvWjBEdEpqMjFsQ1RtQzZH?=
 =?utf-8?B?QUJKQ242c1BzbVZjaE43QWtDc3Nham1BVnB6b2J1Mkd2OGdOaGw3N1hWYzVq?=
 =?utf-8?B?em53VEFUbXNUbExrQ0RSSjZLTnFxdDVtelhyMXlnWHlMbnkrQkpRbHAxMUZu?=
 =?utf-8?B?RWd1a0tKdWJPdVNXTiswQkE0MUpDbU5NVjBydXBtWHgwdXhqblJERU1NTU1D?=
 =?utf-8?B?ZjQ1Ymt3S21Qb0tBMmdRRW9NbkV2MHlYeXFtNEVjQS9Cc1AraWxoU2QrVDVj?=
 =?utf-8?B?ZCtXczU5SWY0SXJieWpCYWZrZlNKSE9XTVV3STQ0dld3VkxvTzNOSHArU1M1?=
 =?utf-8?B?bWo3SHRKdEtGTmJLNU55YWZ2d2dRS21hbGJPU2tscW9pNjdFS2s5L0U1c3g4?=
 =?utf-8?B?cWR4QUhNaGNMeGJUUmxDaFlzY0x5TVNvU05naWd4aGJmSlFjM0hoM3pkY0Ri?=
 =?utf-8?B?bUwzQnZUeUFzOEVEV2w5bTN5RnlrOGRkN1NqcGVOd2RMdmZaSVhHYVZndnda?=
 =?utf-8?B?YXo2ZUVUc0lVb3hUaUYzeC9rY3lTclJKaU1HQUkrckp3Q01YZ09zREp2c2Q5?=
 =?utf-8?B?NTJYUFlMQlpVM3NXM1dVSVZoV2ZVY2hvVWRhVk5ncUtNUzlHd1ZCYmVpLzBS?=
 =?utf-8?B?YW5lTFVqUTNVcFZNRFhKZUJJSmdLVlp6d3l6UUlZWHBQUFNCUC9DVTNPUE9W?=
 =?utf-8?B?djJPcHNoTDZ3bGp5d2R2Z1crMFI3MmZtN0x4ZnIzK3N6TmpSZGJCaFh5blRO?=
 =?utf-8?B?RGNna0EyTDhmbmNxc1JjR1dNK0dzQ3YraXh3cWZmcG1NN0MrNVM5blJzMkJE?=
 =?utf-8?B?ZjdWMVFjVTkyL2U4ZTVwMWpQYlpmZ2V1T0xjRlR1QnVHYjBCUkNYQVY0UzZI?=
 =?utf-8?B?MEZZc1JOZ1Ivd1VORmNid0pWL1JKdnpyZmxPR1RwdC9CV3N0M3o0UDlnSWEw?=
 =?utf-8?B?V21SV2orQnVkblVJN0tGanZERTVuenZ0OE9peUV3bCtwUFdmR2JGT0dRT2Ft?=
 =?utf-8?B?TGRveTBWZWF5UytjNjRoZEQ5SkZ0cXF6US91aU5mV0pnN0s2aWxKd1NaL1VY?=
 =?utf-8?B?RS9WOGN6WHE5SldQY0x3MnZyRG10em5KRWVEaHNuSUYrSWpuSFhZTEthc1gw?=
 =?utf-8?B?MTh2K2NMV2RmNzlXZXJFQU52bHlWQW5xUEVvSnIxYVl3aGxBdXp0anFQLzdz?=
 =?utf-8?Q?1uEzRYM2wst5j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmpzQUNyanFCTDhGZ2xQeStQMTh5NHJ2SzJ6VVpQdjdkZEp4LzJZZ1NzUWJ2?=
 =?utf-8?B?RDliQVJoc2hGSFhvM2hmaTkzZXdlV2NrWFJxUW4vYWlybTdWZ3FheFFLbjBW?=
 =?utf-8?B?VUpGSUhXMGtwVDZqZVlJSVF1d3I4WWdhUVhPOEVWV3grakdVbGRBeHBvWDVJ?=
 =?utf-8?B?ZXBkSGE4cjFESFpLT0pjejczSHVkd2R5Tnh1SUZVVVF0Q2xFdmIwUFA2dklF?=
 =?utf-8?B?ZVUxbmFQakMzZDdQVjNzdkpwWXRiYVczWGNwL0pBcUtQajNiZmFSM3NjQTBk?=
 =?utf-8?B?anpGWXhOYnJtQUc4V0g1Mk9VMTFhQnFNN1NrbXBJeGdZUmFtSUYzMUFOVS9t?=
 =?utf-8?B?VFh2cVZIdFNsWXI5NGFOamVNZ0FSWHVBMVhkbmxRazY2ZUcwOThxOEJtWDVU?=
 =?utf-8?B?Q3J5OHdpbUR5TmVrV3gwa29OaHRzdmpTejZDL0t3d1dxR0dKYWNaNFRCMXg4?=
 =?utf-8?B?NlNkVU5ZVVYwU1duVm1ReDkvRjJvdEozczc3WXZWdFpmenAwNlh0aGVPYTdU?=
 =?utf-8?B?MUh1WnpHYi9WWDArUlR2enl4N1VHREdUOFlxK2hpSGE0Q0VLNUNjQzlkTnRp?=
 =?utf-8?B?NE9td0NhSVFNRUVqN1ZJKzdpQzJDSzh0OXRjM0ljbHlBMndDc2hYS29xWHlX?=
 =?utf-8?B?ZXZxRUNTSkFBejBVSWRyNXNId3A4U3hiNzJlSlcwQmJjL3IrdTZTM2ZLamlZ?=
 =?utf-8?B?Z0d1TFM2cFZZdm1FTW0rMk4wZmVxUXFFdGJqRGVKRUROTFdObmVCbUtib2Vs?=
 =?utf-8?B?YzQ2ZGhBWWFkZk5jTWtXcE9ieGY2VGprbTRTNEc1K3FLbkN1SzlXaWdnbGVu?=
 =?utf-8?B?Y3ZOZ2tRNjhWNU9qUy9jQ0w4c2ROcUtUMVYzY3lPQzl1TUpVbEREb25QV1Yw?=
 =?utf-8?B?NFpnTTRPeHc0UWtrb1lPWGh0VnZQeHl4a04wOUphNWVlMkNiVys0aWNZVHBC?=
 =?utf-8?B?b2xXR1NrZ3M3aVBja0J5eUtPYnVhc1VVMXR1ekpVSHVlTXVraTFJeFZ5QXZp?=
 =?utf-8?B?UGFGQ2pkT2p3SGhOdGhmMUtiWHh4ZDJvRm5vb05RTnVjOW5uZHhPSWVEOXpJ?=
 =?utf-8?B?U0FTYlZRTk1UNFZoa2Jab3NlRmpTY0s5cUlmYzVuN0ZSRTVoSGpWRFlvWnBG?=
 =?utf-8?B?V3pMUTYyVHRxQllNbkVnZjhPVHJvZEU0SGVINE9lN0c2ekVNWFlSQjVyUTRE?=
 =?utf-8?B?MzNtZG5mcU11TFU1eXViUG1RN3dXS01jRnZRbmEzTUFVRHFkOUYwcUNGYWpU?=
 =?utf-8?B?TkRyaXpETHJrNEliUGhlUlliWUZDSXVXUEVEZ3FuSVEweG1SSG53MTZzNXg0?=
 =?utf-8?B?a2dTVGg1SEJHNTJDVng1T3h2M01ObHMwVGRKbys4a090U2xKR0JSSGZvbmFQ?=
 =?utf-8?B?MDd4UkFTNVFJUHBsamJteW93SjYwQ1VDalJMa0gwSnJrdDM2cDEwRnJaQmVQ?=
 =?utf-8?B?MVQ1azMyUlRpVTN2bG9iTjd6MVlRcW5JL2hlYVdrbTdBcEpicnVJU1JyUFg4?=
 =?utf-8?B?TjQxZk5FRHdVZTZZVk5VYjdYZlptRUpjdzhScE5ydHltRjVCK2RaS3lGZG1I?=
 =?utf-8?B?cDlUVSt6ZDBBWldyd1BaYndicGZ3OWIxdExuLzZrR2Rhc1c5MlVvaElRa3Yv?=
 =?utf-8?B?V2FoV1pZWUhiK3F1NnplVWtkS1duUVdwMU95eUo2NW1nd29YRVlZcEIzd2F1?=
 =?utf-8?B?VnZtL3JjTExidG9XMjd0RVlWQVlSWk9jOG5DbS9WZGRTWHAwRm9nM1ZMWXdM?=
 =?utf-8?B?ZjNOVHdGcXFETmsxZzBacmhRWVBWdmQzQzcvN0hxMWhUZzFVRFJqT24vS2ZM?=
 =?utf-8?B?RkM4cHp6VDVDdWtvZkRBODlINUkycXd3dDdCYUNyOGlvUFJjd3ljVDJOMXM4?=
 =?utf-8?B?dlQ1cm1UNTJmUitweXRNNHJJWlRsWGY5MllrTlJNUzZlVENNelVEMllLSm5O?=
 =?utf-8?B?TW5LNGpuajM4V0NWWnlMUjFxZG5qYkxYSVBQNGVpN0I3NFliTnE4VkhrNjE4?=
 =?utf-8?B?bmtkejlHMXVPbW9Rb2M4ZU5JdklMNng2cmkrZTJjNU9kKzBGV3RPZmJjRGV3?=
 =?utf-8?B?V2RzeDVOWS9QOXlaalI2RSs3Vnh4eUxDQVJuMW8vUzBvSVM5OWs5d3YxdGdS?=
 =?utf-8?Q?KU0QCpVXjv59lPdzoFkjjeUYU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ff224b-4a4e-4688-f0bb-08dca08d35e1
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 03:05:53.5443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itj8ClYNWD/RyuhS+m4DWYt+WQq4SeFxQYnXHy1IMLhJtoOGS6kjgc7h8vWDaexStIbcPN/gT0AHt25SpH4kvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6014



在 2024/7/10 10:41, Barry Song 写道:
> On Wed, Jul 10, 2024 at 2:39 PM Zhiguo Jiang <justinjiang@vivo.com> wrote:
>> The releasing process of the non-shared anonymous folio mapped solely by
>> an exiting process may go through two flows: 1) the anonymous folio is
>> firstly is swaped-out into swapspace and transformed into a swp_entry
>> in shrink_folio_list; 2) then the swp_entry is released in the process
>> exiting flow. This will result in the high cpu load of releasing a
>> non-shared anonymous folio mapped solely by an exiting process.
>>
>> When the low system memory and the exiting process exist at the same
>> time, it will be likely to happen, because the non-shared anonymous
>> folio mapped solely by an exiting process may be reclaimed by
>> shrink_folio_list.
>>
>> This patch is that shrink skips the non-shared anonymous folio solely
>> mapped by an exting process and this folio is only released directly in
>> the process exiting flow, which will save swap-out time and alleviate
>> the load of the process exiting.
>>
>> Reviewed-by: Matthew Wilcox <willy@infradead.org>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
> No, this is a disaster. Please ask someone for help before you send it.
> Neither Willy nor David has ever posted any Reviewed-by tags.
> Please do get someone to help you. Stop posting like this!

Reviewed-by tags information has been updated in v9. Thank you for agreeing
my idea and providing strong assistance in improving the subsequent patchs.

Thanks
Zhiguo

>
>
>> Acked-by: Barry Song <baohua@kernel.org>
>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>> ---
>>
>> Change log:
>> v7->v8:
>> 1.Add tags of Reviewed-by and Acked-by.
>> 2.Add #include <linux/oom.h> to solve compilation issue.
>> v6->v7:
>> 1.Modify tab indentation to space indentation of the continuation
>> lines of the condition.
>> v5->v6:
>> 1.Move folio_likely_mapped_shared() under the PTL.
>> 2.Add check_stable_address_space() to replace MMF_OOM_SKIP.
>> 3.Remove folio_test_anon(folio).
>> v4->v5:
>> 1.Further modify to skip non-shared anonymous folio only.
>> 2.Update comments for pra->referenced = -1.
>> v3->v4:
>> 1.Modify to skip only the non-shared anonymous folio mapped solely
>> by an exiting process.
>> v2->v3:
>> Nothing.
>> v1->v2:
>> 1.The VM_EXITING added in v1 patch is removed, because it will fail
>> to compile in 32-bit system.
>>
>> Comments from participants and my responses:
>> [v7->v8]:
>> 1.Barry Song <baohua@kernel.org>
>> You should have collected tags such as reviewed-by, acked-by you got in
>> v6 while sending v7.
>> -->
>> Added in patch v8.
>>
>> You didn't even pass the compilation stage because you're missing
>> 'linux/oom.h'. It's quite disappointing because I believe in your idea,
>> but you didn't even build it before sending.
>> -->
>> Sorry, I overlooked the compilation of folio_likely_mapped_shared() added
>> in patch v5. Compiled and Updated have been compeleted in patch v8.
>>
>> [v6->v7]:
>> 1.Matthew Wilcox <willy@infradead.org>
>> You told me you'd fix the indentation.  You cannot indent both the
>> continuation lines of the condition and the body of the if by one tab
>> each!
>> -->
>> Modify tab indentation to space indentation of the continuation
>> lines of the condition.
>>
>> [v5->v6]:
>> 1.David Hildenbrand <david@redhat.com>
>> I'm currently working on moving all folio_likely_mapped_shared() under
>> the PTL, where we are then sure that the folio is actually mapped by
>> this process (e.g., no concurrent unmapping poisslbe). Can we do the
>> same here directly?
>> -->
>> You are right. we might use page_vma_mapped_walk_done() to bail out.
>> (Barry Song)
>>
>> 2.Barry Song <baohua@kernel.org>
>> By the way, I am not convinced that using test_bit(MMF_OOM_SKIP,
>> &vma->vm_mm->flags) is correct (I think it is wrong). And exit_mmap()
>> automatically has MMF_OOM_SKIP. What is the purpose of this check?
>> Is there a better way to determine if a process is an OOM target?
>> What about check_stable_address_space() ?
>> -->
>> Sorry, I overlook the situation with if (is_global_init(p)),
>> MMF_OOM_SKIP is indeed not suitable. It seems feasible for
>> check_stable_address_space() replacing MMF_OOM_SKIP.
>> check_stable_address_space() can indicate oom kill, and
>> !atomic_read(&vma->vm_mm->mm_users) can indicate the normal
>> process exiting.
>>
>> I also think we actually can remove "folio_test_anon(folio)".
>> -->
>> Yes, update in patch v6.
>>
>> [v4->v5]:
>> 1.Barry Song <baohua@kernel.org>
>> I don't think this is correct. folio_likely_mapped_shared() is almost
>> "correct" but not always.
>> Please explain why you set  pra->referenced =  -1. Please address all
>> comments before you send a new version.
>> -->
>> Update in patch v5.
>>
>> 2.Matthew Wilcox <willy@infradead.org>
>> How is the file folio similar?  File folios are never written to swap,
>> and they'll be written back from the page cache whenever the filesystem
>> decides it's a good time to do so.
>> -->
>> What do you mean is that the file folio will not have any relevant
>> identifier left in memory after it is reclamed in the shrink flow,
>> and it will not be released again during an exiting process? If that's
>> the case, I think we only need the anon folio is skipped here.
>>
>> [v3->v4]:
>> 1.Barry Song <baohua@kernel.org>
>> This is clearly version 3, as you previously sent version 2, correct?
>> -->
>> Yes.
>>
>> Could you please describe the specific impact on users, including user
>> experience and power consumption? How serious is this problem?
>> -->
>> At present, I do not have a suitable method to accurately measure the
>> optimization benefit datas of this modifications, but I believe it
>> theoretically has some benefits.
>> Launching large memory app (for example, starting the camera) in multiple
>> backend scenes may result in the high cpu load of the exiting processes.
>>
>> Applications?
>> -->
>> Yes, when system is low memory, it more likely to occur.
>>
>> I'm not completely convinced this patch is correct, but it appears to be
>> heading in the right direction. Therefore, I expect to see new versions
>> rather than it being dead.
>> You changed the file mode to 755, which is incorrect.
>> -->
>> Solved.
>>
>> Why use -1? Is this meant to simulate lock contention to keep the folio
>> without activating it? Please do have some comments to explain why.
>> I'm not convinced this change is appropriate for shared folios. It seems
>> more suitable for exclusive folios used solely by the exiting process.
>> -->
>> The skiped folios are FOLIOREF_KEEP and added into inactive lru, beacase
>> the folios will be freed soon in the exiting process flow.
>> Yes, the shared folios can not be simply skipped. I have made relevant
>> modifications in patch v4 and please help to further review.
>> https://lore.kernel.org/linux-mm/20240708031517.856-1-justinjiang@vivo.com/
>>
>> 2.David Hildenbrand <david@redhat.com>
>> but what if it is shared among multiple processes and only one of them
>> is exiting?
>> -->
>> Modify to skip only the non-shared anonymous folio mapped solely
>> by an exiting process in next version v4.
>>
>> [v2->v3:]
>> Nothing.
>>
>> [v1->v2]:
>> 1.Matthew Wilcox <willy@infradead.org>
>> What testing have you done of this patch?  How often does it happen?
>> Are there particular workloads that benefit from this?  (I'm not sure
>> what "mutil backed-applications" are?)
>> And I do mean specifically of this patch, because to my eyes it
>> shouldn't even compile. Except on 32-bit where it'll say "warning:
>> integer constant out of range".
>> -->
>> Yes, I have tested. When the low system memory and the exiting process
>> exist at the same time, it will happen. This modification can alleviate
>> the load of the exiting process.
>> "mutil backed-applications" means that there are a large number of
>> the backend applications in the system.
>> The VM_EXITING added in v1 patch is removed, because it will fail
>> to compile in 32-bit system.
>>
>>   mm/rmap.c   | 15 +++++++++++++++
>>   mm/vmscan.c |  7 ++++++-
>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>   mode change 100644 => 100755 mm/rmap.c
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 26806b49a86f..5b92c3dadcc2 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -75,6 +75,7 @@
>>   #include <linux/memremap.h>
>>   #include <linux/userfaultfd_k.h>
>>   #include <linux/mm_inline.h>
>> +#include <linux/oom.h>
>>
>>   #include <asm/tlbflush.h>
>>
>> @@ -870,6 +871,20 @@ static bool folio_referenced_one(struct folio *folio,
>>                          continue;
>>                  }
>>
>> +               /*
>> +                * Skip the non-shared swapbacked folio mapped solely by
>> +                * the exiting or OOM-reaped process. This avoids redundant
>> +                * swap-out followed by an immediate unmap.
>> +                */
>> +               if ((!atomic_read(&vma->vm_mm->mm_users) ||
>> +                   check_stable_address_space(vma->vm_mm)) &&
>> +                   folio_test_swapbacked(folio) &&
>> +                   !folio_likely_mapped_shared(folio)) {
>> +                       pra->referenced = -1;
>> +                       page_vma_mapped_walk_done(&pvmw);
>> +                       return false;
>> +               }
>> +
>>                  if (pvmw.pte) {
>>                          if (lru_gen_enabled() &&
>>                              pte_young(ptep_get(pvmw.pte))) {
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 80f9a486cf27..1d5f78a3dbeb 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -863,7 +863,12 @@ static enum folio_references folio_check_references(struct folio *folio,
>>          if (vm_flags & VM_LOCKED)
>>                  return FOLIOREF_ACTIVATE;
>>
>> -       /* rmap lock contention: rotate */
>> +       /*
>> +        * There are two cases to consider.
>> +        * 1) Rmap lock contention: rotate.
>> +        * 2) Skip the non-shared swapbacked folio mapped solely by
>> +        *    the exiting or OOM-reaped process.
>> +        */
>>          if (referenced_ptes == -1)
>>                  return FOLIOREF_KEEP;
>>
>> --
>> 2.39.0
>>



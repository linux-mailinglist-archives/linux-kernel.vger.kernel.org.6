Return-Path: <linux-kernel+bounces-182350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6EE8C8A1F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 18:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C11BB236C3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9E4131BB4;
	Fri, 17 May 2024 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="QOmsI2I/"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2104.outbound.protection.outlook.com [40.107.223.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEB813173A
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715963435; cv=fail; b=ZgwKvePfGwcDOU3wCpcJZBI2exoX1RbH8Lw6u5v5ucERiNvqbGuoetiSeaV5FnVR3VwMxSgx/B2f32O8t+bYkZK0P2r9LxnYCksWmoi+6HULzcB7XP4sAo6jIjDg/q9iUPiRxt1sLCje/jjIaZMXOxrL15VERMyypn2lCFkN2v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715963435; c=relaxed/simple;
	bh=fkASTgi5jtiTPYUzL/4TygcmZRnMbO4FhyQkTTIgB3o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uNkWx7S+JFLZShZY7DPRDt/oj9hlcJ7h5CBeiiCx02zGYRoyAA/YKaqRHzOCMcSdnrK2/kwjji85o5DC4IrcdeWirOff1TghAeljSkXQW5yQzsLSjfkhfjCuJxsnF9aCI3AW8v+BMPDpTPGeST8Ef8aKr0Pz1PHsYi34e9DV03E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=QOmsI2I/; arc=fail smtp.client-ip=40.107.223.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmZ0jT7S8N3b8Gl1nVzq/Lv6umwexQQ5+VPhyvFIAgbx/veGsRWHDPKifj0pSev74kaNLR78t881miIcozWv+RqkTDLyVRPGQXGyu5VwXZEcP+eqw8wdcIZ0axmEe0ofMTKoToPeFRpiLk9uSfNh8iEYHKVNm2GoOopy0jkCExeB/NZHrM1Ap0AyzYXkHw5lCHv22osIX1SMmr+k7raFQs73lqQFUrh15cFm9Lxoq98V0cSBSdals2D/xZ9lE+fFprTCxZyMH8whxYuxgE3FEbDt0esedXT8SY67Kyx9exOv2WJcB6nDNwR7gE28TU7wXSTciOjaNt28Fb1nZmYlXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NS1cw/7/BKc4fmzWyUBucp+sA5aLqycL/PMTT0KHS/A=;
 b=dGxhqXuG7XR43Eu7iWYf+MB1BzTaci3zHxbhmf6D9QL0mEDrP6PBMEOJv/ifeYXHhFixtNb3THHBpmLsFHHmZwXsHt4JDLE/zuP1JWuo/dnFguRJl5pdC6nKOMYB9fwjm38+AebdS5o0Efj9Z0f8L8Ov89kIVqvU4aH2la0IL38DSzPviGD/aEDME7foXgrcyvTr39JRUFxQ3P99amnQJThaBKsMhlXS5GZmoJ2MzseyEXsjZMaGWulIEdqsL/xNpqsrS3VArCoFlFOVa3+xaWyeTtNntZXoEx3+i+A6pW1nSPcuiRTnm282ki8LbWqtG9Ri1pb12e4L9nx4uswD1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NS1cw/7/BKc4fmzWyUBucp+sA5aLqycL/PMTT0KHS/A=;
 b=QOmsI2I/TvasRqXdVU8gkG8WMv6VdeZapHgfppaCjQKXj9rsU0In66iO+grLraCq6gTfLoXt2d64qHkhRFFeKDaDbLDy5tL4gM5nmrmqRoVpvIk4Be/cAff0fof5RFMbkkzP5IQ6pHWA/2j1o565J/wWzbTRb02Cyt6hmucvwNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 MN0PR01MB7561.prod.exchangelabs.com (2603:10b6:208:370::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.30; Fri, 17 May 2024 16:30:28 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%4]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 16:30:28 +0000
Message-ID: <570c686c-6aa1-43f0-ba31-3597a329e037@os.amperecomputing.com>
Date: Fri, 17 May 2024 09:30:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: force write fault for atomic RMW instructions
To: Catalin Marinas <catalin.marinas@arm.com>, peterx@redhat.com
Cc: will@kernel.org, scott@os.amperecomputing.com, cl@gentwo.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240507223558.3039562-1-yang@os.amperecomputing.com>
 <Zj4O8q9-bliXE435@arm.com>
 <6066e0da-f00a-40fd-a5e2-d4d78786c227@os.amperecomputing.com>
 <ZkM_WXxEQo51mrK5@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <ZkM_WXxEQo51mrK5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::23) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|MN0PR01MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d4e331-a5c4-44c4-203d-08dc768ea9cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3F0WC9ETHhXNEhyeUdPZDJCYVdXcnJIR0UxMFZrMEd4Q1VlY1UrSGIydWgv?=
 =?utf-8?B?SEltRnhabXpnTEMvTmR3aFlleG9qaVVDazVxQUVTcU80Tyt4Z24vVXU5aHIr?=
 =?utf-8?B?eEdDODBtWGovc0hGSXNaT01iblk1VUxhaUJNdk1QYlJsWGVpT3hoY3JlelJH?=
 =?utf-8?B?eVkva0NxaEU1SVVqcldyanJDZVlER1RFUmUvaFN0WFNSc0VFSmxyTnh1eU5B?=
 =?utf-8?B?bGUySG81Y2hGQkFZREg5VnpFQXhIM1FuZkpkdDh0OTVoQUNMakU4cnl5TWND?=
 =?utf-8?B?MVVwMmRVRUl0UWNLNWZFSmFxVE5vL1lUR2lhaVFnd2gxbjhxTGRmSy93emxq?=
 =?utf-8?B?ZWFsQUFnTmVqSmxpTStpVzVpMXdqZHZKNTl4dnM2WWl3bEtmZFo5L1g5U1ls?=
 =?utf-8?B?cWxaUzJPMTdZSmVUVDlVRmdrQ0lCRStLR1JqSU4yVnNGZHFaZWc0cVlLeHdh?=
 =?utf-8?B?Qi8zelhTVDJPNWR6Y21xWVJsNGNxOVJGanBDZHBVSVpoNmpNL1Q1WWlhUXE3?=
 =?utf-8?B?RC9scnlpUUZOaWdSOUU3QzJEcXkzQ2JKbU5HWEt4M0pvTHJydHFmdWZ1ZUpT?=
 =?utf-8?B?WmZhYW5QT3JBdTV5alpIdWJBWFU2akNzeURCVHh4TjRVNnZIMjVGTDE1bm1p?=
 =?utf-8?B?WmR6MHA0aWRUdXkxTVpvNU5YQ1JISDF5WmVGYmsrbi83VEswZEpOaTd0akFN?=
 =?utf-8?B?N3MrVEszbGhWRlFFZEVzMHhZbmdsM0EwSy85Zm9jaTgyVUs2YkVVclUwclhr?=
 =?utf-8?B?YmxsY2ZLTEFxYy9QV2tjbU5OTTRscitFbHNVbHZUWFRIeGpMYUNBeERxRlNQ?=
 =?utf-8?B?U2JFWUtNSlJLRUIzbDBoNEJaZGhheE1EeW9MYURTKzBxK1JFdXRNbFNCQ1Vn?=
 =?utf-8?B?ZHlrWEkxTWpCbVNMSE5yNE9OS0xUVHVIZVY1Mm1IS2QyQ3NaQVBKS01jRHFs?=
 =?utf-8?B?MDBUSllqS1dFVmUvRkVBVVRLZml2WDhMcDJCTzhVTzdYMGVkZ2xFbkxlYXRC?=
 =?utf-8?B?bmg3VEVkVzZPSWNhbDhEcThYaFgyMUg2VVBJaklDWmR1S2o1WDB3c3hJVU14?=
 =?utf-8?B?TVpYMGw2R2tWRmpBaXVrWFJHYXlJTm9IRTBYakh2MnZGMFQycWNKa1VObmZn?=
 =?utf-8?B?UXY4bjFsNlNWeHJtYlE1cnRvQUVhRitPZ2hsREZMUHV4bmxIZVY0VGlYVHBq?=
 =?utf-8?B?cXdjcVVzMmRwdlYxbzB6Zjl4R2RTYTRtSXJpeFl0QmlLRWZHMXpha0RHZTNG?=
 =?utf-8?B?b0Q5UWdMMTZyQ0ZLcHRoaXV1Tk1FUXJVMDEyTkhkOGZSUmZpN1ExSEFOSSsx?=
 =?utf-8?B?UWdyOFQrVUxtR2NHZ3FNcHJRWWx0SUZUUHk5cENVYmNocGhxaXpKeHdvblph?=
 =?utf-8?B?QS9YdzAwYUtVYlFmd2J1Zng0SXVvbG9DQjl4cTNITVhmazNMUFc5Wkp4Zk9t?=
 =?utf-8?B?NWZ2L1lobWVTeTg1TnpSTnpCYzJMdTV0RTFyVHlBVnpvcFdoK3JlTVJyd3o1?=
 =?utf-8?B?RCt6aXBETWtNaEh4ejJiTWxvZ0srYmtjdUQ1RVdPVCtUdGpXMmJveFc0RjRQ?=
 =?utf-8?B?WGxJTlJLR252U2xraUxqdy96NndUT3dqZ3poTVlCOEdnQVVKTjBLb0JzbWtE?=
 =?utf-8?B?OVR4ODFSRlBlODlOY0hQY0o1UVEzU3ZscTdZR2pyMHh6UmJUdVBsU3ovbkdr?=
 =?utf-8?B?M0NwL08rdUFZMDhMazlzWGpYZllEMHFTcFlCVW9SZkVvalZmNUpncUhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3d4K3NGK3UwSVNuZlVNN3EvWElJekhwdDhzWE8vdmVjZjUwaDcvWUxDMDZi?=
 =?utf-8?B?QXdrT3ZRRURLZHhuTFIzVEhJaCt4ZHQ0em5iNzJxVGlQU1pRbGF6QnorYVR5?=
 =?utf-8?B?RVlLU2w2eE1kSWVGWUM0dHE1N2hEaXV1OXlHa3ROc2c5dU9od2FmV1hGQWZY?=
 =?utf-8?B?UVJwSDRHVzM2ZjBtSWd0RkZOSUNOTnBBV0lDU3BBYXJwejJwa3N6SEpFeVp2?=
 =?utf-8?B?c3YzYXh3NHh5dm1iVmpoMHRvRm9OSnNSNFRGWi9uTmRVN2RTSUR0ZGVUdzg0?=
 =?utf-8?B?Z29jSEN5L3QxaHpZTURYR3hVamUxREhTT3hJWmdXNTRCOHZMdnBISVpGMlZI?=
 =?utf-8?B?WnRxS3hhUkF3UXJaNUdPZy9CK0J3aUFyUVppMVg0WkZxdERob0pjdE5qWWJI?=
 =?utf-8?B?V0xKK2FQS083ZGdnb1hhVzUyaUliUjBZaW9lbTRYQ1piTEtsemlnMVEwV3Rs?=
 =?utf-8?B?U00zS1F3VmZXeDNjYVdMYm9kNXVXZmFmQlUzaUt1YXIvdHVsNWJtRnVGMTFS?=
 =?utf-8?B?K3FvZlJZRWd0bXZabDU3UkQyY1hUNFZvQUdMSG45U0Y1RVNtSUVwb0JGUEhU?=
 =?utf-8?B?bjJ2cFltQWVEVWNDZ0dZWDhxd3VRTHBtbGErcml6RDVHNzVjeEs1R2lnNjNn?=
 =?utf-8?B?ay9GTUJPbkp1bSs1Ri91VGI2QjhWM2hvc2dXRExuRUtPcGpzTGhkWFc2cGVZ?=
 =?utf-8?B?aDdLMlpWSnM4dXhlcXRCMkFsSDhwdkRPS2xqRjF5a1FDTzkxV1p5TW5OeE5p?=
 =?utf-8?B?MzRCUlo3Y3BhZ3c5VCt2WWxuMUZEOEYyWUZOMHE4K2NZMWtKbkJYYXlJdlM2?=
 =?utf-8?B?elRFTkdickVqMVhNdUYrbE01Mkd5T1k0OG1OZ0VwTitqL2lPNHJCb3g2MnRO?=
 =?utf-8?B?K1EwUUZiNUxUTmJxd25ZYnllSlpPYWowbjlBVXZsVmc3VkkrdXVTSWYvRm9p?=
 =?utf-8?B?Z0txaU9QUm8wVjg1d3p2ODdndTBRU3o2UzRFeGlhUnk1d0hZbW9pUkdEcUt1?=
 =?utf-8?B?L2lCMzdLMWpCbkRCNmEwM1BkQjlUdS94b2JzU2VPKzVEc2xHN1UxQldzc3Yx?=
 =?utf-8?B?VkxyYUkwQ1BXRy9Cd0VyNkt6RHdZbU5RMGxYMVUyOEdCaTB2MkVVcEt2TlE1?=
 =?utf-8?B?bWI4QUxxNmkwc1ZEUWNpQWtvVWxuUittUExhQWE0cHVGZkRBL1loOE5XVEZq?=
 =?utf-8?B?Yks3R0k0RCtodUtnQm9yWm8vZzNONlFYQ2VTUlMwY1FnOWRGcnFiZG1HaTNT?=
 =?utf-8?B?RkhNb05XWDlwdW8vS3pBdXNvZ2VGSTVRNHI4TVh1YWJrams4bFVEdWNNWENy?=
 =?utf-8?B?bHM5TFJTdzVVQmxRWStDZ2xsb3laVk9vMlF2RWlZTXNRVFdwdDZNWkxVczZZ?=
 =?utf-8?B?OHlnUGdFK3M1WG13RHdHZHZ0QWRGUEVTNTFQanlvb2k5ZlorNk9lYzRpTER4?=
 =?utf-8?B?bXE0Rk5GbjhVR2pTaGNBcjl3bnpsdkQ1NExiUDJCSWpXYy94dE1aWHFZN0tx?=
 =?utf-8?B?V1lDLzgvWTVMZ3RyQk02UEttR000a1ZDYmZKempFWVFyUG53Y005MnFua01n?=
 =?utf-8?B?R05TTkxSTU1IUXhWSHJPZFBqTFFTOWVFWFpMeTYrT25laW5hZEsyWEZhZVJH?=
 =?utf-8?B?MTh5OVpsU3Q3SlRaWVJmN2RNQ21Sd3ZWazJad0JhYmtKUTNDM2lzblZYMDlv?=
 =?utf-8?B?QUlMY0VhLzNVN1lzVm9qNUtsOFNyUmlGOWdtdnlidmswSENkcWgyeDhUcHYy?=
 =?utf-8?B?QTlQanI4ZkpGZTJqR0NKZ0hjVXFmQWg2cDVhdE5SQzZQSGNUdW12ZFdGVk1P?=
 =?utf-8?B?SEQ5WWE5KzBrU3g2UmY2anRyM3ZkMlhZQUpnT25Oa3hINzRDVm45RWEzNkk0?=
 =?utf-8?B?cDJoUlAwT0RxY3ppWFRoenk3VnRvREtmWm5oSW81Ukl0WWJIcnhycFpwNmFa?=
 =?utf-8?B?MFZmVlpBcmF6RzdLeFBnYjc4aDYyeFE2QTYrVEZCUkhabmFZamFITXNCVmtD?=
 =?utf-8?B?aTZWYWFCdndmU3RKNWlWbkJZZTFlUjRWc2x6ZW9hRVZQbm5XeThqRzgzT0Jn?=
 =?utf-8?B?OU91NWxKNWl2SFZmWW5yMnAvcEtxN1g3TVBSb2Z0bHBrbUV4bnNZS05XdXRm?=
 =?utf-8?B?blFTSk11b3k0cndhWXJ4RGtySVRBWno0NVJjNGtZcUVRem9KQkpIb3BVWlBL?=
 =?utf-8?Q?gNV1EW1doosgNpY45wbYfjk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d4e331-a5c4-44c4-203d-08dc768ea9cc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 16:30:28.6920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWuorVGOy7pJFS+M8JjM5+j0GXCmwMmitbvaxocM+vV1LBvcsHPgZhsMLqE+lKc/NfFZzAZ2HXzO7vx6zMavKFSyTlSooTgF5ntp6OlUD8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7561



On 5/14/24 3:39 AM, Catalin Marinas wrote:
> On Fri, May 10, 2024 at 10:13:02AM -0700, Yang Shi wrote:
>> On 5/10/24 5:11 AM, Catalin Marinas wrote:
>>> On Tue, May 07, 2024 at 03:35:58PM -0700, Yang Shi wrote:
>>>> The atomic RMW instructions, for example, ldadd, actually does load +
>>>> add + store in one instruction, it may trigger two page faults, the
>>>> first fault is a read fault, the second fault is a write fault.
>>>>
>>>> Some applications use atomic RMW instructions to populate memory, for
>>>> example, openjdk uses atomic-add-0 to do pretouch (populate heap memory
>>>> at launch time) between v18 and v22.
>>> I'd also argue that this should be optimised in openjdk. Is an LDADD
>>> more efficient on your hardware than a plain STR? I hope it only does
>>> one operation per page rather than per long. There's also MAP_POPULATE
>>> that openjdk can use to pre-fault the pages with no additional fault.
>>> This would be even more efficient than any store or atomic operation.
>> It is not about whether atomic is more efficient than plain store on our
>> hardware or not. It is arch-independent solution used by openjdk.
> It may be arch independent but it's not a great choice. If you run this
> on pre-LSE atomics hardware (ARMv8.0), this operation would involve
> LDXR+STXR and there's no way for the kernel to "upgrade" it to a write
> operation on the first LDXR fault.
>
> It would be good to understand why openjdk is doing this instead of a
> plain write. Is it because it may be racing with some other threads
> already using the heap? That would be a valid pattern.

Yes, you are right. I think I quoted the JVM justification in earlier 
email, anyway they said "permit use of memory concurrently with pretouch".

>
>>> Not sure the reason for the architecture to report a read fault only on
>>> atomics. Looking at the pseudocode, it checks for both but the read
>>> permission takes priority. Also in case of a translation fault (which is
>>> what we get on the first fault), I think the syndrome write bit is
>>> populated as (!read && write), so 0 since 'read' is 1 for atomics.
>> Yeah, I'm confused too. Triggering write fault in the first place should be
>> fine, right? Can we update the spec?
> As you noticed, even if we change the spec, we still have the old
> hardware. Also, changing the spec would probably need to come with a new
> CPUID field since that's software visible. I'll raise it with the
> architects, maybe in the future it will allow us to skip the instruction
> read.

Thank you.

>
>>>> But the double page fault has some problems:
>>>>
>>>> 1. Noticeable TLB overhead.  The kernel actually installs zero page with
>>>>      readonly PTE for the read fault.  The write fault will trigger a
>>>>      write-protection fault (CoW).  The CoW will allocate a new page and
>>>>      make the PTE point to the new page, this needs TLB invalidations.  The
>>>>      tlb invalidation and the mandatory memory barriers may incur
>>>>      significant overhead, particularly on the machines with many cores.
>>> I can see why the current behaviour is not ideal but I can't tell why
>>> openjdk does it this way either.
>>>
>>> A bigger hammer would be to implement mm_forbids_zeropage() but this may
>>> affect some workloads that rely on sparsely populated large arrays.
>> But we still needs to decode the insn, right? Or you mean forbid zero page
>> for all read fault? IMHO, this may incur noticeable overhead for read fault
>> since the fault handler has to allocate real page every time.
> The current kernel mm_forbids_zeropage() is a big knob irrespective of
> the instruction triggering the fault.

Yes.

>
>>>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
>>>> index db1aeacd4cd9..5d5a3fbeecc0 100644
>>>> --- a/arch/arm64/include/asm/insn.h
>>>> +++ b/arch/arm64/include/asm/insn.h
>>>> @@ -319,6 +319,7 @@ static __always_inline u32 aarch64_insn_get_##abbr##_value(void)	\
>>>>     * "-" means "don't care"
>>>>     */
>>>>    __AARCH64_INSN_FUNCS(class_branch_sys,	0x1c000000, 0x14000000)
>>>> +__AARCH64_INSN_FUNCS(class_atomic,	0x3b200c00, 0x38200000)
>>> This looks correct, it covers the LDADD and SWP instructions. However,
>>> one concern is whether future architecture versions will add some
>>> instructions in this space that are allowed to do a read only operation
>>> (e.g. skip writing if the value is the same or fails some comparison).
>> I think we can know the instruction by decoding it, right? Then we can
>> decide whether force write fault or not by further decoding.
> Your mask above covers unallocated opcodes, we don't know what else will
> get in there in the future, whether we get instructions that only do
> reads. We could ask for clarification from the architects but I doubt
> they'd commit to allocating it only to instructions that do a write in
> this space. The alternative is to check for the individual instructions
> already allocated in here (after the big mask check above) but this will
> increase the fault cost a bit.
>
> There are CAS and CASP variants that also require a write permission
> even if they fail the check. We should cover them as well.

Sure, will cover in v2.

>
>>>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>>>> index 8251e2fea9c7..f7bceedf5ef3 100644
>>>> --- a/arch/arm64/mm/fault.c
>>>> +++ b/arch/arm64/mm/fault.c
>>>> @@ -529,6 +529,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>>>    	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
>>>>    	unsigned long addr = untagged_addr(far);
>>>>    	struct vm_area_struct *vma;
>>>> +	unsigned int insn;
>>>>    	if (kprobe_page_fault(regs, esr))
>>>>    		return 0;
>>>> @@ -586,6 +587,24 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>>>    	if (!vma)
>>>>    		goto lock_mmap;
>>>> +	if (mm_flags & (FAULT_FLAG_WRITE | FAULT_FLAG_INSTRUCTION))
>>>> +		goto continue_fault;
> [...]
>>>> +
>>>> +	pagefault_disable();
>>> This prevents recursively entering do_page_fault() but it may be worth
>>> testing it with an execute-only permission.
>> You mean the text section permission of the test is executive only?
> Yes. Not widely used though.

I tested my patch with exec-only. No crash, just the optimization didn't 
take effect as expected.

>
> A point Will raised was on potential ABI changes introduced by this
> patch. The ESR_EL1 reported to user remains the same as per the hardware
> spec (read-only), so from a SIGSEGV we may have some slight behaviour
> changes:
>
> 1. PTE invalid:
>
>     a) vma is VM_READ && !VM_WRITE permission - SIGSEGV reported with
>        ESR_EL1.WnR == 0 in sigcontext with your patch. Without this
>        patch, the PTE is mapped as PTE_RDONLY first and a subsequent
>        fault will report SIGSEGV with ESR_EL1.WnR == 1.

I think I can do something like the below conceptually:

if is_el0_atomic_instr && !is_write_abort
     force_write = true

if VM_READ && !VM_WRITE && force_write == true
     vm_flags = VM_READ
     mm_flags ~= FAULT_FLAG_WRITE

Then we just fallback to read fault. The following write fault will 
trigger SIGSEGV with consistent ABI.

>
>     b) vma is !VM_READ && !VM_WRITE permission - SIGSEGV reported with
>        ESR_EL1.WnR == 0, so no change from current behaviour, unless we
>        fix the patch for (1.a) to fake the WnR bit which would change the
>        current expectations.
>
> 2. PTE valid with PTE_RDONLY - we get a normal writeable fault in
>     hardware, no need to fix ESR_EL1 up.
>
> The patch would have to address (1) above but faking the ESR_EL1.WnR bit
> based on the vma flags looks a bit fragile.

I think we don't need to fake the ESR_EL1.WnR bit with the fallback.

>
> Similarly, we have userfaultfd that reports the fault to user. I think
> in scenario (1) the kernel will report UFFD_PAGEFAULT_FLAG_WRITE with
> your patch but no UFFD_PAGEFAULT_FLAG_WP. Without this patch, there are
> indeed two faults, with the second having both UFFD_PAGEFAULT_FLAG_WP
> and UFFD_PAGEFAULT_FLAG_WRITE set.

I don't quite get what the problem is. IIUC, uffd just needs a signal 
from kernel to tell this area will be written. It seems not break the 
semantic. Added Peter Xu in this loop, who is the uffd developer. He may 
shed some light.

>



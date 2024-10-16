Return-Path: <linux-kernel+bounces-367911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5619A083A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503561C20DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AE7206E7F;
	Wed, 16 Oct 2024 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h84j1AIz"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4A12071ED
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729077597; cv=fail; b=fxX+FCltApfgPh/tgkeYnCYvCJl0B14FVMBFKE2lsh+oSL6NNKRaFzW2myfD26R6VrXUuOk6Yx7fAjmtiSEI5yeuq/QxxoaMnq6H2T26EiZp0wDxFlxhtKavrtpNdStKPc4axtUnRCS1gDyHLMnthWCbMG05T0I9Rdqmgp66Uyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729077597; c=relaxed/simple;
	bh=qyX7rKk7i2/92sVrgCeChb7MrbuRaXM/umqPxm+D98s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lb5HNL3N7OmvS4mY4rZsar9eDM0CGiwJS65KXYqF37g5n34U5EP2v8WLQUSgrhY/nhvxhp/Q2R+3JfCVBo2tGYOiz0ZM/yI6XYM0yLmO+zivVfMgfEpaL/h8ETetV6wwu3X6ww+N4y8BKxwFGAqAZLtm3heEnZUbNFjfpxDjJYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h84j1AIz; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urDD4BYLko4MZRotdn3oPvZ6qrUX/X/khGYZDFt7Z/+AvOxTncUkJjmYI9+6a+4W8UMphINm9XLL9IU6VVYR5rOT0blHH9aZjrv1RUw5tNWRKMJ27ya4NfKuH4YdAYsXOYedBcF2wGJlBqXccQsexpJhAMLd5PfRMooWgo1YXM/zBrqDVkr+weo0MSeDJd0/gBHoaTVexf9GBetxWQK0JKW3PSbX5pyYVlEio/iYD0Rdd1oDWwNdEclgxx9teeCqgJF4pzG6PFYd1vwpACieWbpPbke8wiH2XpiIV7FXi3O6Novn4J9AJ5NbV9n6M3/YKJCP8fSus+SLLmpyTmYfzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kjp5YG0Hryrl85OqWWfQguDq0uJka0Rkow0ilgKSzZ0=;
 b=uLqfGGEwect4WCceWsiEFFbwFJ9pzt3v1uyVk9moU3okETg3TjHQU6LLSF4JkscFsL3/hoUZ7q7p9JS/8yTgNp2sjokC7wOZ+Y6LEsO+rohS2ze1RimVMyXPuS7GM6by/Fped4ZHU0E66bOTLgmWKo6+ig5Ga7uiRMqLv6MxlxHKCytjtVqhaJArzgxG0alXelFgGOhCH/64/RnG6Owk8oiZc5NaXVT3/eu4QnuvszhtCclPjs+nBCpCoG/32qxN1rMQLq9su4jGr9vcTyI691kk67/faACsqGIGFi792gdTHaBr+FlAGvwCz1CiKYELBT16jdJkKTA/uk3FmgKXnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kjp5YG0Hryrl85OqWWfQguDq0uJka0Rkow0ilgKSzZ0=;
 b=h84j1AIzjdpZFcb83A7Nkr/qRVxC5zKzOkZ+rHh+t/UGtBoVukLwvOZi5zcW1Bcoe9ulSO/EdaQukYjoIjtmmexKAPRYSsbIerxk08UD6OcPFr5axO7lnOE2/wuAgkydBxCcjGzR3C1FpZ/3b2acpPVa2bO0OeZKatptP5UNsjlCLWGvUQ2Q8lJi8WNRtt50gtluF/wp9EZr3ZPJEOLXkbR2zIhhjKWXnB7iUch/AhZxcSEBam4b0SaLGxluzlLPmoyFjY2EH3ZNqEltFiXbcxsBeSWM9QBTNa9b1uJID4w0BDlzMDtEB/hJ6FY9CQeQG6qaEkCo1yKcbA1KygQnZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH7PR12MB7163.namprd12.prod.outlook.com (2603:10b6:510:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 11:19:52 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 11:19:51 +0000
Message-ID: <843da504-34bb-4067-85b6-49851a1ff517@nvidia.com>
Date: Wed, 16 Oct 2024 12:19:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] driver core: Avoid false-positive errors for
 intentionally skipped links
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Saravana Kannan <saravanak@google.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org
References: <20241015-fwdevlink-probed-no-err-v2-0-756c5e9cf55c@collabora.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20241015-fwdevlink-probed-no-err-v2-0-756c5e9cf55c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0309.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::13) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH7PR12MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: d721c966-bc39-4a14-2184-08dcedd47405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXhRWE1kNE83ZGczZUF2OWM4YTBaWnAvZ1J5eC9RcUplTmVRdDdhRlVUQVhV?=
 =?utf-8?B?QUw5dXVsT2xCR1RjR2dSTDFDWGltOW4wVXpQOUhNQ0ZHKzdnWjBzZFo4S2hw?=
 =?utf-8?B?YTBTYm15UEhYNzlYZ3RZTlNQb2JQOVNyckp6dGNWbVQvMWhkOVhTQzNTVHh6?=
 =?utf-8?B?Si9vNWlLNjFJOHBmS2Z6WDZoemNyaGw1d0xMTEZHYVJRMGsrMmNlVXpmOU1o?=
 =?utf-8?B?MEhIWVhONVhMa3FsSkl3TnhzOUJIZGhhelRHWitmZ28ySjBLVnp2Q0pudnZt?=
 =?utf-8?B?UHJWcXgwMjcxZTRxZFl1VXQvZVlMRjRTUWNadmViN3pzbTg0UDRUT0QvNDNM?=
 =?utf-8?B?dCtOaVNReEdFWDREY20rcXNKemJkaVZ4NDVDdThOY2IweXVTTFY0dDZMSnd5?=
 =?utf-8?B?L1V3L2duN21tOSsyaGcvd0VrQ1orUkFwWU5LcjFPQXBtQlB2U1c1U2o1a2dP?=
 =?utf-8?B?eGdSTVBwbVo1VHYxV2s1SVNsZjNDSGxSa3IzNGgvMTlIN3FieVZlN3JGMFor?=
 =?utf-8?B?bTE0T2ZQM010UjlIUDV3cUpDd2tzWE5VNXVaenZDMWpuZ0FlNlZMQ0lyWVBR?=
 =?utf-8?B?WDI1bjcxNStDRTUrT3BKRWU0TnBtVUx4WEhQWm52alFYeVZqRTJqUTd4emtP?=
 =?utf-8?B?cGRBTVVMSTBYUm82S2s1ck5RY1hicnVEKzc1alE0Zjhkc3BDbDQ3cGRCU201?=
 =?utf-8?B?clJxeGNOaGQ2N3VrZVp0KzFMdlc4OHJDem5zc01wK21GZWFOcThSYlpOZEor?=
 =?utf-8?B?UjErOEI0TEZYNS81M2dzRCtCZjd2bnlCREV6K2NtM1BXWXFLNDl6eXVHS2w4?=
 =?utf-8?B?aVlXa3Z0UkgrZ1lJZUlhQ0ZreklpRDlnemU4Yjg5WkdHdnYxS0xSTzNTa3dQ?=
 =?utf-8?B?WEpJNlltRGE0ZXgrcDladVRUbEYxeDFsTC9ySFRra2VQMHRUVkxaTlJUTmZJ?=
 =?utf-8?B?RzU5OG1OU2RtTzMxT1lOeG9iS2xhb053cXZvTEMya0M3dWxHTzJUdWsrNUFU?=
 =?utf-8?B?YXR4Sk4zby9remt3T0hsVWlsa0h4VUtpbisvV1BQSVJKV0JYUFVnemJGVUx2?=
 =?utf-8?B?S2hONXd4aU1oZXREMTIzbkxjSjIwS1d2WHNDNG5oOVZITUFMZXZkOFhsTkhj?=
 =?utf-8?B?L1VxR21QcFVyMFFmMWxZbW9JWUtpeUVOb0w2STNTTDBqL0g5OFJSaXQ2Tjlu?=
 =?utf-8?B?VHliVC9UMm9rK09qOTFibTlZUnEzVnV4cVVrVllubS95NUhPbW02bTRYTit6?=
 =?utf-8?B?L01ZNWM5ZnlxeFJnTHNieGdndEpVdW5zcjJ4MnMvNk4wNFBsV0dDZFNBWi9F?=
 =?utf-8?B?U2pnajdDSlltMW8rZnlBNjR2TzJxcVQzemttdktLYUpITEFRc1dYU2RoRHFm?=
 =?utf-8?B?VDJoRDVJRFVDTXI1R0JXdGdySThBM0xFVjJNdEtnOXBhZjF6aWhIOFZSVVFH?=
 =?utf-8?B?cnFGM0RMNUVEVFRpcGpWdXExSno0NS82TFZKbDVndnhXbjJXcjFCUlZiY0hS?=
 =?utf-8?B?R21aY3QycmZqUk01QlBrV0hYR1RuOENIUFoydGlLL1hsZHZaZFBURjJKWmw5?=
 =?utf-8?B?ZzJaeUxDTStoaTlSK3NpZGpQVlc2WndkTVlQZ2l4WGI2SEZOZlgrTTZJaThq?=
 =?utf-8?B?ZUhWNGlLa29IRXhGZnF6M0tZOE8rSnorZmZaYXlYMlVvZWtQNERFMWlUMjJ2?=
 =?utf-8?B?TC9xQU5hREh3aUVMNDRBUGRSWXMxN3NaUjRoSWFXOU8ra0o5bnJJNGpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVNGWmcxMXNyajdXZUMyWFozRVVrZ0JrYkVFMml0T2VQSWJobEFTeldBK0lN?=
 =?utf-8?B?Skdjai9SSUkwUjNkek9GdHB1ajg3a0I0am12ejZza0hRTDRLOWVvd0JBUEd3?=
 =?utf-8?B?b01sTmNYaVpTL1dLaGREMktFcFIxRGtncEVubzhGc2N2UUdPY09xZHR0aWRS?=
 =?utf-8?B?WDNUTnBvcFpuQlVKK0NhMDVlRDJPVlVDdHdNRjBndC83c21QeFYrSTE0cXJs?=
 =?utf-8?B?WW9Ea2VnaHc1dFVNVWd5RW03aXVHT3hUQ0RiSTFUNWUvR2l2MFNxRmNIa3px?=
 =?utf-8?B?aW1iL3dKY0tiaUZLd3hHOFNsTHptSGVWdkFNSnA1d3VLY084Tkl4bmsrU3dC?=
 =?utf-8?B?eC8rcnM2Yld3aHRnMmlZREZ1K21mMk0vSmRXZW9XdEIzSnNzU2M1cXJDR0tO?=
 =?utf-8?B?OGV4TWtESW9mUU1McXlCRHNWcDZTVUlhdDR0Uys0WnhjZUt1ZVJlYUtaelhs?=
 =?utf-8?B?bWpFaUlLMitoQTVCaGVjTDlsVi9zdHdTVms0SENlVmc5cXU5ZTU4clQ1N2c1?=
 =?utf-8?B?OVpSbjNDbTY5a2g3Z2VPcEFVVTEvSURQam9SbWJmd3BqUkpqc1BFM1JFWHY3?=
 =?utf-8?B?OThsS2x4MEpVQzBYRVRCdjZEclFrV3BWWWwxWWVvZlk2cHZwWFozeDRYUktE?=
 =?utf-8?B?aUNjSmJyeFZkNjAxemYva1BvTlJFZHBqMStKSGJ0SUdiTlFWVnFlZlVGQWw5?=
 =?utf-8?B?azU4aGtXNDJTSk1BaDZBZVNFQWVmbjIvd3JCaE5zMmhXaGg5SjR6cCt6WWhZ?=
 =?utf-8?B?M1kraEF2ekh5Y2owQUNSMW5wNWJLcU9FczZBaDZ0cnNjR0VnUUQ1UUk4bXlX?=
 =?utf-8?B?TFpWVEsvV0o2ZTJZczAxT0JLQkIxekJFaGhlTFJDU2Q3S2Uxd0h1M3Q4bTVC?=
 =?utf-8?B?NktCMXp0bmpGbW1vanRwQXc3NDVPR09xK2ZzaWFOanFXOHhrc3pCNXFOUlVl?=
 =?utf-8?B?MWZhMzhkeS9OSnRsM01UVTFmTVpWYnVKbUlKN3RzYnlLMmhZc0JZaDQ5bzhK?=
 =?utf-8?B?VXJIYkNpRTAwWTdTdFhVVTg0c3BtTGZxWGN1YW40bFlwU0ZVTDA1UlNSeW0r?=
 =?utf-8?B?ZnNWRVYyZE1QcFJrZUt2ZmJFVHNYaElZS1VBWnIyeWc2c2dlSjRXcHF4RmxM?=
 =?utf-8?B?cGdPYUEyT1k3S0NPTHJRYkN1a05saWV6dmNOVWZXWjJ4NE1CWXlEa0NndTJh?=
 =?utf-8?B?SmFHUUhDTEJDS0N5TTNETjN0VUxlSStSdU5tWndEU0FsVnlUdmV5cXFMNk9S?=
 =?utf-8?B?d0NKRjVOQjhWblhKVGJPUTVUUlc4bWVTb2RIWm1GTmFNcXRweHRLM3JDUTJM?=
 =?utf-8?B?RXFXRWlmZFdpQUNpSTNKdGRnNWcyWTNzaDFiaGlreVZWVUh0cG9wMXZiTEUx?=
 =?utf-8?B?RWpSdG9nU2JkeFRyYVhxeWgvNEZhbnB5cFZXdklQUUczcm1NY29jbHZoNVdw?=
 =?utf-8?B?Zmg3Ry9Hb01lbXVYMldqM1BITjdudXlWbko3UXlYaVpMYm16OFZ3bFhITWtT?=
 =?utf-8?B?R3krWkVMeTBUdkt5VFFVZHA2Qmh0a25jc2k4M1oxUHJYL1paazAvaFozcldn?=
 =?utf-8?B?dnNtRkhxRHRvd0NLSWZVUDY2OUpCcEIxS3hNTmRmNlhJZXkvY3pVUXZUT1RE?=
 =?utf-8?B?SG94RXdLVlR1dmYySnZpQkFtTk90MWFXcnU3R2xCS0w2czJuMk5VU09MaU1V?=
 =?utf-8?B?WktkalFDT3RCSThTeDI1bmJ6UXIzeGlzeGUySE1tTVNzbXBBZS9VMm5tRjFt?=
 =?utf-8?B?TFc5UW02dWdFanFSK1RCY3JCQmo5WDRvS0FvclpUQ0VxYW5tazBKTGZkWWxQ?=
 =?utf-8?B?WkMyYURhRm4xemZZRFdwNmMrSlcyNExkZVpKRVhsM0NTck9MdWtMZlBlMmFl?=
 =?utf-8?B?MDhPWjFqMHZ4d2FwaUxoVVpMVmdkZlJYK2JyRjI3bU9zMmxrSEFoNFpoTks0?=
 =?utf-8?B?c3c1ZE1vMTh5YkY4T3BTbUV3dW5OSDdHM2xvai92aGtmWFo0dWNPaE9GSjQy?=
 =?utf-8?B?aDFydWM0dGR1OVhkeXNPR1JuY0tLTGw2dkZGeml1dG1pczdCWTk0b29NU2tY?=
 =?utf-8?B?WTJ4bUpKY20xaG0wWno4UTU5VEs2eW0yWjZocFF1QWx2ZTFhQmI2MDQwWkFR?=
 =?utf-8?Q?g5b0OWwW1CEXmAN2XuCz1EVza?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d721c966-bc39-4a14-2184-08dcedd47405
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 11:19:51.7582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5UyEKnhslG0mKleD0AE2gT1u8u9f4H62c3FNa4WM44pap80aDTr/OKTnHoje71q0wqPKuExBpfDx6TurYWaew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7163


On 15/10/2024 22:27, Nícolas F. R. A. Prado wrote:
> This series gets rid of the false-positive errors printed when device
> links are intentionally skipped. Patch 1 commonizes the logic into a
> helper and patch 2 uses that to remove the error.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> Changes in v2:
> - Added patch 1 introducing the device_link_is_useless() helper and used
>    that in patch 2
> - Link to v1: https://lore.kernel.org/r/20240624-fwdevlink-probed-no-err-v1-1-d1213cd354e2@collabora.com
> 
> ---
> Nícolas F. R. A. Prado (2):
>        driver core: Create device_link_is_useless() helper
>        driver core: Don't log intentional skip of device link creation as error
> 
>   drivers/base/core.c | 28 +++++++++++++++++++---------
>   1 file changed, 19 insertions(+), 9 deletions(-)


Looks good to me. For the series ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic


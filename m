Return-Path: <linux-kernel+bounces-367860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBBA9A07B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1E17B26680
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C923206071;
	Wed, 16 Oct 2024 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mHRGB+E/"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1376A18E054
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075606; cv=fail; b=gJ4gO4+D4RcBTkbAM/vHo9q2Ho/OP6v1G/2tLinpHNQ26JBrz4REheFAbEyehBwqOVhKcBVAKYrWDdJtiLz71EdsOuAE8xe8lHZuQkbhepS0z6QGIFCSOhzEFByAoPQEAquvCxXqaUXtps9Pegg5aqRKq8d6jgVvFvNK0iawwZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075606; c=relaxed/simple;
	bh=h19xq6VP7vQeK3fldZHq6vK7vWECWH0kvFXNK2Cb2u0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aJRLABj2KvKg1iAgytTmmYaawUDN9tEIjgpdIzLxN9GbIe0KGBKVGf6VbSU7LmoazOoNyxzy0sNeQam/xDx0jUZkEcCnnNR0nH4RYt1ydWOqPxTTu06CMOwf/QLErrH9kxoxC2KxQlpDKpYOPo6GlT704n0oiOb0X0bRxLT1m/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mHRGB+E/; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpsuBqm4MUoh9cq/smSgJ93xTvkWfHcR+3RVTXHmgOgrH/3EqgqgG4bc/Y4nysmqv75rfwdfeKqVsBzaEl7hmOcm2b/nJYU1QRQR4KTYThZKV/JaHNsOdog+yH1WdHk/uEvtURuZthzssXOl1WtArTnoI3Aq39qLSR02ibR6yTRQPdxcj6t6ioecQAhXqkbpdxO+I+aQTK3p1zYQSAAK5g2b1mg5uVQ6RhX1gqg9g3icybH3hTSZAtyRPFJkgxfziU+hX7YsmWxRE0Cp9ZWvLcf8T+GS4Oo6xfVko31QbDrFOeP132Hce3vpV37oQaPkvAmlwhIIhhxXcY3zG2Uaeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6wB/s+Y070ZVivlK93B7BLKwlihx95W3+mShkGGBTU=;
 b=ugLUnej6giWquVPSXGck/2s09+oEdodHsTNZfHCTd015Sg9/Gt2UdLYuxMHANdpaAruljUdFoRBIM9lrdzMBxP+S0yK5lmXJXCaMi56nN+fk6rLuOeMEXzyliMgqGkPpe+Ydzu6vJ8W7PpLfBZCVAYoh5zvZMxTIVNVzTucCIsvAbhxR+9K0RJjxhd5IDxYMhDidqWsRbD18RYxdKO8H8mN30g8JlBERegN5eyErSqNBt5oWNSjwbj0IXuUx7YjlLfSsyLyKmQ7s6eaQAEXFeruw2BgT9uTHddNtUKHZ0wBJwKAniRKmRmzjCPXvovZ2tgxkr6VrZ3grkZasaKDm9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6wB/s+Y070ZVivlK93B7BLKwlihx95W3+mShkGGBTU=;
 b=mHRGB+E/viZ25Y/UFEvWerAoks/AIVgVvioqhr7HgqcnE5KlwS2swwJV3LS46vPGjzqWIBJPgyRIcarujNum6Zrpjoo4r8V6k/ETE02VUAprKq+fZJ3Nv22YJBqQv2LfqEDOQzb564D/0HN+k8LqGzt/qB36nnUf8kS7KNQYLT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 SA1PR12MB9472.namprd12.prod.outlook.com (2603:10b6:806:45b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 10:46:42 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 10:46:42 +0000
Message-ID: <465bff34-c145-90f9-80d2-b9e69791022b@amd.com>
Date: Wed, 16 Oct 2024 16:16:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 2/8] x86/sev: Add support for the RMPREAD instruction
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 nikunj@amd.com
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <4f9d9eac997784cd11f4243d545dd05e670b2e4c.1727709735.git.thomas.lendacky@amd.com>
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <4f9d9eac997784cd11f4243d545dd05e670b2e4c.1727709735.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0230.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::15) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|SA1PR12MB9472:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd03860-4d2c-4bdc-30b6-08dcedcfd215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0wyYTlvMnloKzlmdFpTZ0hIeFhFbThvWE5rbG5NRVprMWpvb3lvdklRc2dD?=
 =?utf-8?B?am1TOUI0VXpjaHlwZkVEelBjc3NBRjlrYzJvbEV4ZzRnTEtYTUtTcjJnNjJq?=
 =?utf-8?B?K1NTbERQZ0NRWUVNczR1c0lZdk9hQVlyZDFmRHNvKzVOdzV0WDcvNjZGZUpz?=
 =?utf-8?B?WnJ2RTBJSVJka25ucyt0OGhsSlBMUUM3VWo0N2pTNGpUY2VkYmRZd0gvVWtY?=
 =?utf-8?B?SFh3LzZuVXlJelhHV1RlQit4dE9wTFdzaHRZWjZIVGtnVFpvNkl0TG5RenJy?=
 =?utf-8?B?ZFJLNTIydG8xTitJZTdTalZNTlFtZDFBNm9Kdlc1MzY2SFVPMlIyT0hlazdW?=
 =?utf-8?B?WitlNGgwdFdsejZaY2M1VXRNWVZRL1pJYnlGUGg5dnhlRmxOOG5yaHVkOVRQ?=
 =?utf-8?B?Qmc2SjUzdjgxY3VRNWtPdUg4SE1xaVhRYUpjYk5JdFI4WFhPbUdrTXFKT1FL?=
 =?utf-8?B?NnJrbEx6VHBvUlVUNWJVQnE3d3ZURWJqWjV1T2Y5Z1FvVThreDZLUWdKL1d1?=
 =?utf-8?B?U0h3OXFxT1ZnM2QyOFF0V29TZDZGS1J4KzFhd2hzTnpVMmhscSt6UXpmMGtE?=
 =?utf-8?B?dDl1dGlMMDBObVIzSHVOTXdYd2w3OHp1WW8wQWdyTUdrYTFuemJiVEZ6Nmkz?=
 =?utf-8?B?TVlFbnpDaEx4dDFQdUdDS3pqT28rc282aU1YR0thY1lyaXFnZkUrNWJEdTFx?=
 =?utf-8?B?OEVXekNITTlRckhIbGdwRzZSN1FNSUZSVWxJcGxuejlPbjFjZjl1Tk5MMWNZ?=
 =?utf-8?B?ZXpzd01USnVqOVYyc0ZpendDL0VvenRCTktLZzEraFJlSklZMFhlSmZoZUdx?=
 =?utf-8?B?WnIxYmhyaWVzdStjWHlabjRqWm1oMkhCYXFBM0lLYm5DZzFhYk5tK3VoRFJM?=
 =?utf-8?B?UkZFU1U0VUFQRmFDYzhxbFRrWlZnaG40ckoyM2YyZTBLTEZOYktOazZjRWRW?=
 =?utf-8?B?WmtTaS9QUlJ1VFd6QzloYlVIYkIzRTl1VTFhdkdVaHVWaTZtS20wZmdWa3dy?=
 =?utf-8?B?QWVZWDlUVk9yMG1xblRwTHJEbk9RYjJ2WDVRSUs3MTNRaHpHREI2R3FrUXR5?=
 =?utf-8?B?eUVXc3FpYzJ1aTdIaFJsUlZpTVVWNW5MN2diajR5K1lPUlo5Nk5zSDJ6MWsw?=
 =?utf-8?B?RXFUdjBUN2sxaHIrV25VSzlYaGFtWkVEZ21Zbk5wU0JjWnd4OWVSTmdRaG1Q?=
 =?utf-8?B?bmpVK285VmJZakdjNitpZnlzRzBScHY2Z3hFaGZoUndDclR5REZ3SGpmdGFM?=
 =?utf-8?B?N0dpTUpwUzlJNkEzQ0xseGhpRmxldkswNkRxOFRnRXlMVFVyVTU2ZVcraFdS?=
 =?utf-8?B?TXp5Y0dqWFB0UTV3ZHowWTNNVUQzWVNBQUthU04zbnBrcE1NblJGby9xZVlV?=
 =?utf-8?B?ci9FM2JuZE1TQmVocTZPOG9GUXlORWpRSTlodEw0b0ZIcldHVFJ1ZzArTDg4?=
 =?utf-8?B?TTlFbGhSRENHNWg3WWFQRzYyQlFYRnVTOEZwZ09TN2dWS3FLQmFncXVMVElN?=
 =?utf-8?B?WjEyUUp2RUQ3ZlRjUlpDUktsT0x5a0NJZHQzRDBJUmRCMWNwbzN2RGhrOW9h?=
 =?utf-8?B?Z2NWSnBuU2tLV3lGUWErWlNhS1RYbUZzS2s2ZFc5YnNybW5xZVhZZGdDdmRp?=
 =?utf-8?B?QlMxbDFoSkNwdlplTmowemVlSHR6d0Zqb1BaVXprQ3JaWVVRU2lIT2RyZVVt?=
 =?utf-8?B?WXhxRGs0VjhWeTN1Y2RCbm1CcXlkMlJLUGVXZnZFT0R0VG1mb2lGd0FnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RytTN0REaGs2WW9adXFMNktrVmZYVUZhV3B3ZUJ6aC9lZWxNUVBRam1jUWFQ?=
 =?utf-8?B?bURXb2hiSVNnU2ozd2g5V1pTUnlpY2NhNEc3VDVpdXdxODZGRGdnVkR5ODVp?=
 =?utf-8?B?cFBORWhwWWs2ZGNqaXdLMDNCaTl0ZDk2a0Nkd2wrek5vQVBIK0dzdlJmN1Zt?=
 =?utf-8?B?bmUrK0RCanRtNjVkMURjbW1ReW01YXpVeHdPdWQ3cHVlS25qWnJhTDVEblB4?=
 =?utf-8?B?c0NqSFozNEFZMlpDQjdLQmh2bkdmNWZkNndocHJob1ladDg0TldueEVJN1NM?=
 =?utf-8?B?SGFWZDY1ekZFbHJTbHA3TGZQYWlkWlF3VXgxL2xSNXJpSlBXTUVuZDhXWThK?=
 =?utf-8?B?UnpHNGZtbERrOTN6amlMcjZURWNXdzJ3WFdzQVJEbllWNEV1Y2NIaHFGUnFj?=
 =?utf-8?B?TWsyQUd0Ym01Z1czWndEMUxqRmZLTU5LaE5wamNQUXZic3hqaUlpZGNNYzk5?=
 =?utf-8?B?aUErL29GajZlUjluOUpzajBGdEhUbjVad3A3N1FGdysxcHBZK2Y4am5YdnJX?=
 =?utf-8?B?QUsvR1pKT0U4QmtFS282ZUxVVUdaSmMrWXF1SGwvQ1k4S1ZTVU56bC90dWxW?=
 =?utf-8?B?UlQzMUc2K1FHc25DYklMZWRaWFpSbFhCeEpCYVA2bXBDTGZ4dFcvZEJ6Mk5Q?=
 =?utf-8?B?ZGhnNHQyUE80MFRaVWZ0Slo5ZUFFUGtna1doRHZocytad0lFV3Q5ZVdhdno4?=
 =?utf-8?B?aytpTklBam50azhWTkhpa1RmY2hKa2F3KzJEcU03OXp4ekdMejZ6ZWFUcjl2?=
 =?utf-8?B?OTJRWFV1TDZVWjgzR2JSYkhwR0RsTnIrS3V3VUlIWStyaVRNVVRLeFVLNUxG?=
 =?utf-8?B?QXdlNWZEd0tPelRVWmxWbWExRlYrZThaMjFZeTI5OGxhdFlSTFFITCt1MVNR?=
 =?utf-8?B?YUVzOXpybnVJYXFQYjJxdk9WV284OWRhakVmeXMwaTh2YmxQbnZROE9KT0ZY?=
 =?utf-8?B?WHdrc1p0VnZkLzJwTWFkNmVaT3p2WCtjQmFIMi9DVVZsTmMxZFlleU5TcUQ3?=
 =?utf-8?B?SERaU2I4RkJBcm1BOHA4eUI4SzlVa1l5TXEzSmlQblJzdTBnajNqUFNUemVY?=
 =?utf-8?B?R3ZjTllxTnluemtzSUR0eWtqZlNIcy83OTJveC9XRVVPQ0N3VlZUTmNxQWY1?=
 =?utf-8?B?QjlMRGJtamdmdHNyS3dlNS9RaWxqU3I2T0hKdHlSaEx0TTV3c213MEZjWXRD?=
 =?utf-8?B?TDErS2RtbDdiYW1KZUhScXF4Y2NvSTh6dGJwRWsvS3pzMjBtaFNEK2pVWjJy?=
 =?utf-8?B?QTRqQm5tejJ0WlZXdEJjVitSUGFORXBTNUl5YlJ2ODFqWDhLNnBuY3JtcDhM?=
 =?utf-8?B?cWtsSWQzaDRwYUp3UnIxMTV0eUlxcFFzTmt1aWNjRTVudG5TME9aZWpqaWNl?=
 =?utf-8?B?NFMxeUcrMXFFaFBScFBRZ2s0V1hzRXVLb1RUQUZxTmhRVHpLMGxuT3ZhQnNQ?=
 =?utf-8?B?UjFFelVmN3B1Z0ZTU05leGUwZktQSkt4VFBJalFtNVBadFBXTTZaaW1hZkMr?=
 =?utf-8?B?RitJUnBIanQydE5zTTRMMUEyYVpOL2J5QUZRN1ZLWDN0dHNkTStqZXhVS0U4?=
 =?utf-8?B?ajMydldIU0lpTFc1OVNOV3VUY1VjZjlQVnlJWGFKTGhyeEZ6TGhoWGZsbmta?=
 =?utf-8?B?cnhaRGprUTdNcnZ5OXpzZE9qcVBjTjFWZkdBS0tkRHlVSmhSVW52QUROSDc2?=
 =?utf-8?B?U0lIQ3pBZlhqeDFSN0tuamJ1SUV3dHFHRDgzRzNHWnB2ZnpmWjZIQWEzVUJy?=
 =?utf-8?B?OGpHYjJTS1kyYks0QVYxS3kyellHL3dyRENRTmt4d1BSQ3poMml0YUk1T1Bn?=
 =?utf-8?B?c1VyYTA0SDBVM3JkNVgwTXN3ZENVWHhxRlJSOXN1c2ZzR1E4THNDSXJRZ2lM?=
 =?utf-8?B?Y0RNSXVHYjI0cm9RNEZ3L1JqbFBqdXBKVXJCZ3FESzNaVlh1bzJ6aFNrQ1p2?=
 =?utf-8?B?cVd5a2hwUHB2b0pUVlUxNm5mekR3WTNUa01ieElQbEwzQytZSnM3MmROZGFY?=
 =?utf-8?B?cElyUVFNNXluanpOdkljeG9RYklpcm1oY3pyQStaaEt4UG80VlE3aEJtcHcy?=
 =?utf-8?B?NHM4aEIzajR1NER0Z0JpMFlIUkJ4UlRXdjJWSGllSjROUU5iYUN3ZEhtUkZ5?=
 =?utf-8?Q?Q0394EdHIpZsqSKzFP+j554iH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd03860-4d2c-4bdc-30b6-08dcedcfd215
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 10:46:42.1782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkrGLfh2rIhIiaTE0IngRKfDMvWBA63EXLcpt9ohUl57V1/jnqOYmUm6KocFF14/ri1eNI0UzE98t8FdgbQEag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9472

On 9/30/2024 8:52 PM, Tom Lendacky wrote:
> The RMPREAD instruction returns an architecture defined format of an
> RMP table entry. This is the preferred method for examining RMP entries.
> 
> The instruction is advertised in CPUID 0x8000001f_EAX[21]. Use this
> instruction when available.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>

> ---
>  arch/x86/include/asm/cpufeatures.h |  1 +
>  arch/x86/virt/svm/sev.c            | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index dd4682857c12..93620a4c5b15 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -447,6 +447,7 @@
>  #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* Virtual TSC_AUX */
>  #define X86_FEATURE_SME_COHERENT	(19*32+10) /* AMD hardware-enforced cache coherency */
>  #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" AMD SEV-ES full debug state swap support */
> +#define X86_FEATURE_RMPREAD		(19*32+21) /* RMPREAD instruction */
>  #define X86_FEATURE_SVSM		(19*32+28) /* "svsm" SVSM present */
>  
>  /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 103a2dd6e81d..73d4f422829a 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -301,6 +301,17 @@ static int get_rmpentry(u64 pfn, struct rmpentry *entry)
>  {
>  	struct rmpentry_raw *e;
>  
> +	if (cpu_feature_enabled(X86_FEATURE_RMPREAD)) {
> +		int ret;
> +
> +		asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfd"
> +			     : "=a" (ret)
> +			     : "a" (pfn << PAGE_SHIFT), "c" (entry)
> +			     : "memory", "cc");
> +
> +		return ret;
> +	}
> +
>  	e = __get_rmpentry(pfn);
>  	if (IS_ERR(e))
>  		return PTR_ERR(e);



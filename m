Return-Path: <linux-kernel+bounces-574669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7ACA6E84D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE7D1750CD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EBF178372;
	Tue, 25 Mar 2025 02:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="io7APqff"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9756F31E;
	Tue, 25 Mar 2025 02:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742869259; cv=fail; b=PEAEh8W/AoGQmXzun8roLhTdm05AeR+gGwmZJjuI3QtDvPzdEd1o16sG6XakYL/26wLgIHmRuDwZKygGbQx2FhSLNcxGoiwpU3IVr3uPyk2UDAbR2wdOsjzpybcysKV46HJNq11ldHQB5aGquAFN61+BuSpvSFchAHNQmT5JFHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742869259; c=relaxed/simple;
	bh=ggW18ZyWU34ZouALEwkt5olqyiKiM/pQiyQCvgogmwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nlqHOl6dPxkJSNLoFL3egmDit7+6fWni+L/xIPyLlLGnBOQqN3xxipBGjOtnkB2mVIKHdBalE4fqJXEQAqAp1RuWkqkQIu+MLd0E7WkhDrra3Qivuzf4OY32W1q4E1R2kuIDzv2TXPVjNZCV9rzpfl92BKaEjQTvE1XfEukxzJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=io7APqff; arc=fail smtp.client-ip=40.107.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzkAcH+dk2zbect0oWfMQBO2HM66zrGz3fWXgO4XRAkLWDi1eNJgbITXJ7mafr54weTPgzuMSzVoPtvqGOwvZctnIhQlpcR8xaL8R1HHJLScYIlSz20yQWSLKxFj6+cXViOL6dcBvPo98n82df4HvuTDfV6glMI4MFpgULv06SjD56WE5WCIV0ATPzNP8vhlNH8NvmvJqmecPa9XTvp9+/+frYWBcPYkq+Ybgh1fUZ41YFGkFvR5vQxxeTpIyimuwv0862UwrErj8w1DjUQHp3vanv4RhbhpbkK1AA/B4zq080+9uPXJ8MllW5uz772aCR8dqLIAw+OvmyD+JHiaFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggW18ZyWU34ZouALEwkt5olqyiKiM/pQiyQCvgogmwo=;
 b=iTxMvpnEQ21wYuuWTuiwBvIOE9WGmJc4GqZZQx3Td2jRqedQXGPaq4yWgyM/NXyoA2Mxn/LLt7Gyx4Dy5ijiMo5HyTXe1rHGptHoH5OpLLLzwiTOpcKbquaYDWxwum8bpLM+u7eWufWbHgfPXK7QXVnyIQAui8DSU+QTxp3Zhyf5xzneBssVZyHFEc+zJqdceTUsp5ooG4EXOF5/OOiXFEPE5UkLLy0y2TYFjkWaMxnXMJvelaCwCDA2QQI60ij9CF5MeTjL4ROPIugHJA/eXp5nhKpA1rnrf7rHJsKk8XYR+BKHJGXopXR4FI6q6t/l8QYAVCxpaAasgHHYG6o8WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggW18ZyWU34ZouALEwkt5olqyiKiM/pQiyQCvgogmwo=;
 b=io7APqff22BDUPI60QbB3ow+aVWV+y9M7/4KbSTpgL9WeVQtnQQgLtDSGalyT6QMcAsCFRZ9Bqv2hfWwps0jMygDNINgUZTukjupEByYznc97nCAjwJ/P8OTvan3hVhFoRw4emoK5NZHrJJwZcxKrqvU4PTmJA38HGRcl5c9W2qB6bDon5iFlalQi8pM+9Vio6i1flxZuGb/uRHUVnn7xK3xuMvnX+q00kPkoXj5SzgIWJIRYIwsU/iiCj114Ydwz5e39Ymis6XGVrzr18zITx7dunbeRz3KcGsvs+blwsZIUrE2oYgTD3CMr7wi3KXCFoQho/MOlWa3dL2RIJ3NoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 02:20:53 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 02:20:52 +0000
Date: Mon, 24 Mar 2025 23:20:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Changyuan Lyu <changyuanl@google.com>
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de,
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de,
	catalin.marinas@arm.com, corbet@lwn.net,
	dave.hansen@linux.intel.com, devicetree@vger.kernel.org,
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com,
	hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org,
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com,
	mingo@redhat.com, pasha.tatashin@soleen.com, pbonzini@redhat.com,
	peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org,
	robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org,
	saravanak@google.com, skinsburskii@linux.microsoft.com,
	tglx@linutronix.de, thomas.lendacky@amd.com, will@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v5 07/16] kexec: add Kexec HandOver (KHO) generation
 helpers
Message-ID: <Z+ITA48uRCpMkvGV@nvidia.com>
References: <Z+GIRecXeYXiPrYv@nvidia.com>
 <20250325002145.982402-1-changyuanl@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325002145.982402-1-changyuanl@google.com>
X-ClientProxiedBy: BN9PR03CA0266.namprd03.prod.outlook.com
 (2603:10b6:408:ff::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: e83a6eda-aa1a-4a1c-a0a4-08dd6b43aa9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oBozeVnmC6/KAEgE9DVFU5Fe2Go3KvuhgIIxNUyF7Q8dqqFB3Moeq6ux2+zD?=
 =?us-ascii?Q?MDln2r4lx/fPdgkgtKcgMWUOL4Z5mmySav0n9j+7h3Y8KHEVGpIHCYAAwsrJ?=
 =?us-ascii?Q?mr3YX1K08Gu6zcjQnkbkBc7PhDtKsp0EsO8yQXGgDEFZcaAaz3Et6gYKpQ14?=
 =?us-ascii?Q?5uoqMWoxu2iKjgEYkT5yHeEllVpLmVZPBxaxS1dXmzQGFOFyvhPujn3OGQOr?=
 =?us-ascii?Q?ipQ3sIhxeWSXbpf1UV1BEYEollQEpu5MaWoKorDet8MoE6PAKlZPQpnFIrXu?=
 =?us-ascii?Q?MqzSp14nGDlJVCtJoqro0jsObgNKGi95IaxGoaHlar/b1+01kDAnS7inNNjW?=
 =?us-ascii?Q?G9nU4/UvJ4PeWLh+fWnjh0en+4Ka0jcSUt9jVjHaN4CBoN5FZeT++EfeFc6X?=
 =?us-ascii?Q?+Dt8FBfBGZodrb8dTqS02WcEKlmB79ckD/hc+87Mr/G/6GJUkmEnMfJs747k?=
 =?us-ascii?Q?qoJt7IOJGW3jfiwsXXsxDfgDyxAeFKLs9rIKevcnskikPXzbshM6oog0iiUh?=
 =?us-ascii?Q?eQBXVklfNlJ1spabsiOwiCEVJGIwG9+qUyUawaIxTVHX8QBsfoBh1u98ojbz?=
 =?us-ascii?Q?g+L6gSNDBE7bwzHrZQ9EHNchuHnec/zv2VgiAvG5ABX2qEkFE4AMhOBoD057?=
 =?us-ascii?Q?5+5D8vPSUwGcjRIfc5HsTbA+r74C1rFN/tQRB+RlBd1/pN5BguZg8YpxSUNT?=
 =?us-ascii?Q?yPROV6RHTYU7O3fD1HYvH2pRBXjWvPA/k2ENH0Zn3nR0oyGDk916C7vv5Kvc?=
 =?us-ascii?Q?owqIZbDp9WvGRzyzK2lo+59CdcPnjN2tkVsiuozoUnmoD0xL8AfOTXf8C5rT?=
 =?us-ascii?Q?/PIm/8IL3vgDyLAL/0tR51wSYP8asRLbW8zIfMhucXax+oWeJR03aCM+OTzT?=
 =?us-ascii?Q?Uk/8YXj3/V35VbxRcpjeCR0CGzK8AYYBJc7+T+XOKEiSGbR6Ud0KO4VEXCd7?=
 =?us-ascii?Q?TJvaO2qwoT5Tuq375rOyT9+FZD4f5ClyY+EfUbc0u0EPrnw3LhgH/lD5TjVz?=
 =?us-ascii?Q?UNdLun7+PRb1EDxD6ZVsn0665HiBMntuQiNCZb9rSWf2+CpOKlDoqUgNM6HF?=
 =?us-ascii?Q?IBTGheJRU8ge1BA+E7/Z3nVPDgZZW4SuucKR29BwgxlWxApTdkv1/t6ipGnZ?=
 =?us-ascii?Q?Bd5SD+z56LF010+8c4r5SUYvsEPh4W6eNoyOMPbZX9zMt7o+EOOCGXH3SWZR?=
 =?us-ascii?Q?eO9czcoMToYtxX77WbK7Uh+o850/lYPdNxL3NGlfZSBUTsKBM/XWbomgjmZ2?=
 =?us-ascii?Q?US124gQJfR7wHQo93CI8hm5q0cc95ndx3DOvkcY0tsxSSfUokwOu2H7CLrpN?=
 =?us-ascii?Q?y3v2z0L8JMzidw+9nxGEcVhx/KKXh483cfNZKgPySjCS8QoPT+dSox3r5p3X?=
 =?us-ascii?Q?f3ej2OTO6VZF+nS7VM//irpT6bU/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M6s51Gwb1b+z1MN9gIXbl0tb387Avb41RyGI5WxJyiSDAPA9Gr78Jzmg9opE?=
 =?us-ascii?Q?qtICrUtNryZxYQWhePyfiWl67s01tUMpQxcWc5r+pENT7NIj5R9V0lpSgDRj?=
 =?us-ascii?Q?n0QY7FWlb/vRTzh+PKi6X+dC5VlpN/q8fFqgYaJL4OQTQnN1JBXPuojKGOnm?=
 =?us-ascii?Q?evYUfYdtnJJdWxfPxNUHiMGDYxVN9BdFRljJTpKNG1MgbEr0FHyFqDQKLuK5?=
 =?us-ascii?Q?maii2fwNDlsN3zFmH8R9zWDULPHz3te7WSX1Jdxck7RmJpxmSZczRcrH+tqu?=
 =?us-ascii?Q?dhU+T8WkiiwBL+pL/Ddtsaz7wMzP/nOJ3g7voGK6QVD7lntmolBkDGJiFDds?=
 =?us-ascii?Q?pMbl5W7y4+bWFfIQxJrEYygGQmb8zzI+rsEuFtxIhQ5/CAjssnqLC8MdyhQT?=
 =?us-ascii?Q?Jj5jTPhWeOV5ZWzpF0ZrEDtufRJzbvQZ1OCuk0lV95WINqgzk5/6D9UXKwzz?=
 =?us-ascii?Q?lGhbJPltWofC2JWiWIVvlaZkxVHLLH7qDu3VbNCQ+bVLKjRLkT7a9k54yoq7?=
 =?us-ascii?Q?x53EMraMk4isJj63hY9PXp3uW5ZlnUENT+gwUmQgL58wu/JWsManJZ91msiX?=
 =?us-ascii?Q?8TybNutY+9FRxq6/YlHt2YD2PeeReRPFNw5ihcgHndMpkZEXWTpaSsWDvcFV?=
 =?us-ascii?Q?csUrUNMIn2ZTWFeHRpgG+5FQAVC7jFnpHzGxCneajFf9D6eb7JBA42Gn1LC1?=
 =?us-ascii?Q?/cV1il9iMO/u4ku2H9hO47Vjvzp6HqwrP8NvPbbFCbgERLdSCBxfW/N4XqqM?=
 =?us-ascii?Q?NZXXWyhHM6pPR/t4G3dUVKnt8GHUQJeFiePRDC1M21SX7oD82fXiH9Y7PRoF?=
 =?us-ascii?Q?fO19ZffashxswjzhwA5kqxtvmHLPOzBgpU9nG3KdtRi7Eodb5XHmC/bRHiHP?=
 =?us-ascii?Q?5QF0ix12Otdit6ZM6WUYJX3zmP8n7Fb4Rd4Le/OkroKBpx/BvkFaJAjjtphg?=
 =?us-ascii?Q?IKRQ5M8c1p5gK3elqn1T+XaO+cT5VO2/9rJGwNBjaoZTZP89yH/7JCDH/8Dc?=
 =?us-ascii?Q?iydMEovuGc/kxnaVJ5IBYLqk/4e4Qzd7cwriDJA+voR/hH3CMxDgIeHSINjl?=
 =?us-ascii?Q?YBwjnEXMxvrW4wNTzzNwxhM8c8GIhUs5MI4uAyYHB107KIJr8V+vgBIQaZgn?=
 =?us-ascii?Q?u1rpMuYW8fepDYY5YI94Ths4Wa21WsKFs8PsqLSPR+HAOzlB6XsbfxH1FP/H?=
 =?us-ascii?Q?NGRTb3UlLxT1hIDUiooy3hck+Onl7WKGbaELArptqoHVbtxvAgGqyHxGNcKD?=
 =?us-ascii?Q?V49oBbIZL2HuUVGv642x+36DBZl21lQi3IsRWUtllhvDF2ZklZoGEWfwz1cO?=
 =?us-ascii?Q?43qBzCzavFc1SzQ9FABG1KCJuOz9KbrexC3VEZz3xiziJeBSKoDmuDrZRc4R?=
 =?us-ascii?Q?vmqRz5I1InJJExxl8or0ERxYIfxTKv5AkEBIyWu+gX2IuupkDCTFcNzhZ1B+?=
 =?us-ascii?Q?zzfrkXjcuzhwfldy7EuJ/Udd9Skg1W4u4CXFPtCO4Mu48TniR6l/1mrH5sHw?=
 =?us-ascii?Q?M4mOI/IUMdpvlX9rWup5IaY9htSpeOdI3IjRC9fe4S28mjAzGnle/zKOhHpF?=
 =?us-ascii?Q?WwkqySuNjwwEmu/NNK4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e83a6eda-aa1a-4a1c-a0a4-08dd6b43aa9b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 02:20:52.8536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MK3+FmDc4lbdk4IE/Cwj7mqjBcuvAP51dnKZ4DTppiOdtl/jbBY86CEm8rhkci2p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075

On Mon, Mar 24, 2025 at 05:21:45PM -0700, Changyuan Lyu wrote:

> Thanks for the suggestions! I am a little bit concerned about assuming
> every FDT fragment is smaller than PAGE_SIZE. In case a child FDT is
> larger than PAGE_SIZE, I would like to turn the single u64 in the parent
> FDT into a u64 list to record all the underlying pages of the child FDT.

Maybe, but I'd suggest leaving some accomodation for this in the API
but not implement it until we see proof it is needed. 4k is alot of
space for a FDT, and if you are doing per-object FDT I don't see
exceeding it.

For instance a vfio, memfd, and iommufd object FDTs would not get
close.

> In this way we assume that most FDT fragment is smaller than 1 page so
> "kho,recursive-fdt" is usually just 1 u64, but we can also handle
> larger fragments if that really happens.

Yes, this is close to what I imagine.

You have to decide if the child FDT top pointers will be stored
directly in parent FDTs like you sketched above, or if they should be
stored in some dedicated allocated and preserved datastructure, like
the memory preservation works. There are some tradeoffs in each
direction..

> I also allow KHO users to add sub nodes in-place, instead of forcing
> to create a new FDT fragment for every sub node, if the KHO user is
> confident that those subnodes are small enough to fit in the parent
> node's page. In this way we do not need to waste a full page for a small
> sub node. An example is the "memblock" node above.

Well, I think that sort of misses the bigger picture. What we want is
to run serialization of everything in parallel. So merging like you
say will complicate that.

Really, I think we will have on the order of 10's of objects to
serialize so I don't really care if they use partial pages if that
makes the serialization faster. As long as the memory is freed once
the live update is done, the waste doesn't matter.

> Finally, the KHO top level FDT may also be larger than 1 page, this can
> be handled using the anchor-page method discussed in the previous mails.

This is one of the trade offs I mentioned. If you inline the objects
as FDT nodes then you have to scale and multi-page a FDT.

If you do a binary-structure like memory preservation then you have to
serialize to something that is inherently scalable and 4k granular.

The 4k FDT limit really only works if you make liberal use of pointers
to binary data. Anything that is not of a predictable size limit would
be in some related binary structure.

So.. I'd probably suggest to think about how to make multi-page FDT
work in the memory description, but not implement it now. When we
reach the point where we know we need multi-page FDT then someone
would have to implement a growable FDT through vmap or something like
that to make it work.

Keep this intial step simple, we clearly don't need more than 4k FDT
at this point and we aren't doing stable kexec-ABI either. So simplify
simplify simplify to get a very thin minimal functionality merged to
put the fdbox step on top of.

Jason


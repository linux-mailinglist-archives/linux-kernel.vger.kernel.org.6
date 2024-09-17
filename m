Return-Path: <linux-kernel+bounces-331435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B076797ACE2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51431C20BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF0F15D5B6;
	Tue, 17 Sep 2024 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="PRnQjy+V"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF8F15B572;
	Tue, 17 Sep 2024 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726562172; cv=fail; b=aCNyjzwy03CRN4gMjColEGkYUCPpvaXUZGQiF/3jaP+r9eCUgMPpRj5TiEcQPH8JXlzA/nCuXzVPS6tlNN0svclrFYv4da+PcDUfBi+9lc/1AZbgv+e+DlARNQE8+nlsEt61/8rdkKac51sHyIgAfCxLeJvLISD9pNerkvdZPt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726562172; c=relaxed/simple;
	bh=zklEZMq/JCJQ5PWnRS2lOX+4GdRcVFbcDZSLTFawap0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TSBkaAITm1Ve/EA/K9rP8VTDseeerKnv53Fm9GcFkb+yrGjtmyOcGeohj3VoclU7Z3SUMJmx5K8krMgveBIu1ADLJ8tkFIk15slFB8e3N31v14kH7ABQMAaDjgrnoAaYfn/vRCErhG8nu2jeVHV3BaQvEH9ZcCXlhLFAXklKEk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=PRnQjy+V; arc=fail smtp.client-ip=40.107.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsXcc0ArrFu08mvrhna/DsC+0qpiIYTHJ9FKj/HsfMyA+kRjiaQp2qZmpQ/aPC9OBcsESAVfCbmJCToPuJIxa4CnFwvD8TgGal2PbwvAqFTn84g8ux5spQh2+F4D6P2qGayuxQ8ytW1eoiFxKpEb3wXdiK74V7nYeDs162PNrqHoJOxjqkVNcH4zvol2d42yo2sxe/KxbrvdJ/3hiRdbhLbKMhvubylxglf0tLRJGI+6C38wwxzNlYhtG7UdRu1MvbPAyLzutlRPsqBbg4BUc/w+BQ++rWBKKaE7hIS6yidBxwKrPaeDs5esSsoFsBQC/3ZdtXg1PN4ge/v7xPHBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTokSok+4SY+py88mP9h+4iyNc/oMGVNnlHYFyyOcOI=;
 b=MOeje8u2nbAF8ExqmFlAo7y/OENu/cDxTHZZZZm+Nm9MzbknYOE/AiD7EgLWdmWYbDpPM0Lyhya4pehyfyBUYwK3zsI+wmWGSFCHJeMNrBBFGpa62xE+6FVwpfPUXCmNXACdC2uXEM21iBD6s1dvYkC0sd4+gudB2KqV5XhZNoCoh+8F85oWHPfTwBWMs7dc6mSYHApQ49xmGMBSztlBvPJ3f40Kg0+rcyp9nxoZ/kEYcO68IIitRUULC2xkuEKaIt1lsX0fH92QRN5jMQId6vQxWMXKYBX/vdX9stCIGOJD+vIvHGcOxeJF1sosOvMnR81Ce8YgnzYek6It0FB1vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=de.bosch.com; dmarc=pass (p=reject sp=none pct=100) action=none
 header.from=de.bosch.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTokSok+4SY+py88mP9h+4iyNc/oMGVNnlHYFyyOcOI=;
 b=PRnQjy+VeO/syyUkuTlqSo15WARdgNx/cqxQ+qm2iY1Oqp1UVTN1o/I7/3b5nXH8xGs2mqdmfC/DmhXbYuP5BNqa7IO+wLesUgkgU8YIkHz0vVJB+ziUI1h94zHJRn03IvJ6lo6fjulPqs4pE4aNJcfARjZynFb3XtN71+siVPxBH848rcbbgoAXtzkQwrbKsuc3U1wu9naG8jqipMIuhL7ZP6U+i0fiw2IumFunJHH7fLib3+M1nFViKI+GvPhsxdh82eJ+9yHeiC6OiMc1EnD/esU+dl+FPTHQi6nTkv7XxHV1AazlJiFyTVKlvcB5Uik7pIDjo7tf8EqacZtsOg==
Received: from DU2PR04CA0219.eurprd04.prod.outlook.com (2603:10a6:10:2b1::14)
 by DU0PR10MB7025.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 08:35:54 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::cb) by DU2PR04CA0219.outlook.office365.com
 (2603:10a6:10:2b1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Tue, 17 Sep 2024 08:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 17 Sep 2024 08:35:51 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Sep
 2024 10:35:28 +0200
Received: from [10.34.219.93] (10.139.217.196) by FE-EXCAS2000.de.bosch.com
 (10.139.217.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 17 Sep
 2024 10:35:27 +0200
Message-ID: <1037016e-d3fc-45a5-9607-38ca85eeb65c@de.bosch.com>
Date: Tue, 17 Sep 2024 10:35:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: Adds examples for the `Either` type
To: Nell Shamrell-Harrington <nells@linux.microsoft.com>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <wedsonaf@gmail.com>
CC: <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<benno.lossin@proton.me>, <a.hindborg@samsung.com>, <aliceryhl@google.com>,
	<tmgross@umich.edu>, <linux@obei.io>, <kernel@valentinobst.de>,
	<kent.overstreet@gmail.com>, <matthew.d.roper@intel.com>,
	<kartikprajapati987@gmail.com>, <rust-for-linux@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240916233507.11779-1-nells@linux.microsoft.com>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20240916233507.11779-1-nells@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|DU0PR10MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f92fc58-ad61-4a65-dccf-08dcd6f3bd47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzNVRGV4NmQ1R09aUCtvMUlZUDJhR0E0NlJiM1ZqSEVZRlhPSGxEZnZqcWty?=
 =?utf-8?B?TEUydXUvb1p4Tm5jaVFVUzlNblZ1N0M1bGJQNkl5Q2NVWEU4TC9LcHZpa21a?=
 =?utf-8?B?NERLZzdUWDh0dHJPTUhOdlhNQTNhYVBmTU9EN09ET2RJbFJwUEU1elZWNVgv?=
 =?utf-8?B?U1k4Qkd6R2ZWL3JXVi9VTXl1am9xS0RoSW5Ob0FOcThzSVpFSStOcHZFdmpH?=
 =?utf-8?B?S0Z6MGlRR3RNR2YrVzZMcVVVTmVQNmFCZWRiOXdzb2FlWE1QSFUzcjVCM21K?=
 =?utf-8?B?NEhsTWd5RVcxV29SL0JQN0wyalF1cWl6VGIxSlg4OHJsOUJqV2xHTlpUbXJ5?=
 =?utf-8?B?U0ZKL0dVUVB4d2J6S1FlbTV5dlJPZXZxUDM3M2d6M2FzRlNEOGFTUm9zcm5R?=
 =?utf-8?B?OWxkL0VqZExYdC9USytIczhXWU95WURjb3doelo0ODE2UzkzRmtyV0QzNnJW?=
 =?utf-8?B?K2wxTU9EQzJWOUlHQ0xSSDVISVRtazBXc0tUY0JiOGdzRVgvUnlMaVZnaysz?=
 =?utf-8?B?cVhJbkREUk5Hdnd3WTBEanEvczN1TmNmQUZRc2NMWnZJVmsyZzU4bzV2OU9Z?=
 =?utf-8?B?VUpZcGZRVWROSzdTQ1R3SHNRTWJibTRkc2NoYUd5NUJUV05jT2dCWCt6ZGV5?=
 =?utf-8?B?VVNhdms5QlVnT3NDTnhNV01TTUIraHJ0Mm5aa2V4MW5BaTU0TnpHTlJ1MUdr?=
 =?utf-8?B?c1g3aXErR2tNb0wrQk83Q3h3SmJnaWZ3alRvOUltc3l1QlpqdjdQS1FlVDB3?=
 =?utf-8?B?eVRQYVlaeUpsN0dnTVhhaERybE1MOVhVUWpERWE2MkpIWHo4RW03SVl2SWpX?=
 =?utf-8?B?MkNSVzZtUldDMGFUc1pZbloxQ3lpQ1k1TTNJWGNTaXJXTGwwdk9kbG1YZHhZ?=
 =?utf-8?B?V2hWa20wNTFWM1plQ3F1dVZzVzhla2VOa01wRmFHa2xVM3pkWFhEMEg5cmJy?=
 =?utf-8?B?S21ZR3NNTVpuZWc5cWRmcUNoMS85UzVNMGV3Ymx0eW4yeFpJZVJiUVRaZUxr?=
 =?utf-8?B?Z2l2VEppS0FhdDk3U2NLMHFkeVNsVHVnazlLVGdGbjZuSWxpUWdnNG9obHJE?=
 =?utf-8?B?Y1YyTWNWd0hsMDVxZEt5c25Eb3pXY2pTaTVLR2o1U0k4ZE9MbllmeHllcUtC?=
 =?utf-8?B?bXgxVmN2eTN4T0NMNlI0Y3k3MStrT3hUeEtkTFZDNXlHc1JTQkh6a2hGWmdi?=
 =?utf-8?B?Uy9pbUcvNmhaaXYvd0xWUjVzRUdsVDkyNHF5ekNoMWkvOGNETVY5bXNuNjhX?=
 =?utf-8?B?ZWM4bFlxQmJ0eENaYVpEN0RWSERKdmVEL1F6ZFlUVE9PU0dtdzBURWJ6eisy?=
 =?utf-8?B?Q3l2U2E4ZXpUb0tINGVmdWhWbGlaWVVnOEVFREhBS0xsSW8vT2RqeXdRZ1Yz?=
 =?utf-8?B?WUtyM3ZEZXpGcnMvRTB0bytLOWJxWnZPdFFxNDRucEg3Uk9tR0ovbWJPcndn?=
 =?utf-8?B?NmI3RjFGbjU1ZmdxVGtoQXhRbnpheTJtNXhuaDBFTjJ4YWNMT0N0SEswQnRx?=
 =?utf-8?B?UU54N2Y2SUZ1WnQ2b21EK0NDbzlDOWJuczRCYktDZmxjQlZ0M3FKMUdabDBr?=
 =?utf-8?B?a3BSS3NzRUdMRjdvZzVNWUZ2WWVhUVJEczV5ZlJscGQwQjBvcGlOUWh5SXk2?=
 =?utf-8?B?QXBFU1JWSmo0OHVwb2h6d1hXRDVyTG5GQ0lNNUVZdkthY1lOR29tUVR5SDJn?=
 =?utf-8?B?Skc3TldybEVzc0NWKzRxaWtwbXY5dEl6YTV3N3R0TXI5RHRlcllQaFdrbk1J?=
 =?utf-8?B?NU8vZGZzc2FrdFd4UnZpN0ZselY1ZEFKQWYvN1ZBZjdTcitCWGFkcWVvU005?=
 =?utf-8?B?dlhvdFY4eklBc0poMXA5V0hFOENBdmN2Z29uTW54amd4ZEU0VkxsWHEvRE1J?=
 =?utf-8?B?YW95U1paNWpNaUw2QjdQdmtxSVNQUlNzWE1EK2VIU3BpaEdmQTI1Q0MwVTMz?=
 =?utf-8?Q?2D43qoS+ScJZejTC7RyLXPPJ+WU9DRbv?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 08:35:51.9830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f92fc58-ad61-4a65-dccf-08dcd6f3bd47
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7025

On 17.09.2024 01:35, Nell Shamrell-Harrington wrote:
> Adds examples for the `Either` type

You might want to check

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

"Describe your changes in imperative mood, e.g. “make xyzzy do frotz” 
instead of “[This patch] makes xyzzy do frotz” or “[I] changed xyzzy to 
do frotz”, as if you are giving orders to the codebase to change its 
behaviour."

For example:

[PATCH] rust: types: Add examples for the `Either` type

Add examples for the `Either` types.


> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Nell Shamrell-Harrington <nells@linux.microsoft.com>
> ---
>   rust/kernel/types.rs | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 9e7ca066355c..f22f6e289198 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -461,6 +461,12 @@ fn drop(&mut self) {
>   }
>   
>   /// A sum type that always holds either a value of type `L` or `R`.

It looks to me that the default is to add

/// # Examples

followed by some verbose explanation before the test code below.

> +/// ```
> +/// use kernel::types::Either;
> +///
> +/// let left_value: Either<i32, &str> = Either::Left(7);
> +/// let right_value: Either<i32, &str> = Either::Right("right value");
> +/// ```

I ran that on the the target and got:

# rust_doctest_kernel_types_rs_3.location: rust/kernel/types.rs:485
ok 107 rust_doctest_kernel_types_rs_3

So:

Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Thanks

Dirk





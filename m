Return-Path: <linux-kernel+bounces-374965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AF59A7289
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD206282F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA5B1FAC3A;
	Mon, 21 Oct 2024 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DRL+hCSI"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FFF78C76;
	Mon, 21 Oct 2024 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729536103; cv=fail; b=keydKc+sWrf41Zd5musNOrjwAOwdwsMVsRRSCJv1jyaOXZUg6eOyT9QGgEsqcgOhbmrw/8O3efGoMt0IhMO/LD4dRw/YISczoKFQiwzqKjC5y1HXmBZYosOfQTzt6oB6zE9FE4hzfJN1FVF/ZiVHQ8i8tgsWARZOidatNZwtB2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729536103; c=relaxed/simple;
	bh=KjfR4Uf+60pLzGSQ1GZE/bgYkwx6yDR/WyCt9ORyXcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QCuAzVwWH2OKPUZ33GOnvBbgaXCFYu6sel19cwrHzNGddwhSzZrUQ+63rOVrjHoXa2umHC8DsTW0gTNOIGbCogfgt5qe6RZxkx2bFVKHuVipN8m8IHfSGADpiIo+IClNfYoGI1mkoRh6PYP1+rA864rUdgaM1jlqvWjIYsZ4NnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DRL+hCSI; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QV6uK8E9T9SMvd6SA/+V2xOEk6fwCV7o/y5J52O8I+NvbjhfKd87XYE+tNm85lqNwxGFl3TsWmMfXQUnI1Ea46cxqB1g/HrIg0i3BhJDon6VEX4KXyM/q5dA8vNNAIS5OYtNWv9kLiqlwU+vWZUcU4/YeNFgB6c2hS2NEWuKAkVuX3+hlqOUTdOjETyIW19xa3VvvoIUZNTn2jzaECY4K7PbIjNzGE9IPPaJE8xPGta80iHqbX/qo1NEL9wirkSecY8laQNMxd9hA8AbKZkw+HF4p0D4y52dkj4kXI5gwqI8BXCNmwk1k5FqO5cl+uRwP8RD4dKWgZBaxroSeejHiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Gcne9Cbuf5N2BxvrrqRzwwLYEnr/FagWPh/9ZQ0dxE=;
 b=GHzkEt+mlA14XXbJoDpZji6A9sZq4lGkpshgNumqhPte6Cx8Gz1MME7yylWgY5Sz2OcnwexqV9s+eMwvhQmCnkUAwosCGEF+L+M4VEgLGXqVxgs1OS0XuIIgDbLEv4GhAUGKjloWi1u2KVgdyjneLtK+pmG6OyUdjVoPcqWtk+n4uGcAMcsjDG5iuV3IpKzPCmHMatwK9dBPsDYLbzpqKI3MbEBpfBvGhV2qBpK10Q3Qk4ZxBEAMXWQsNBfB7dM1VG4+c5+QxQeYZkoiRa8X6/BjGpHGpbWqQrRBJvJUM4W3+IzkiPfHfOFsXO1UvQkCq+n9ppFDSXUxBY5wbEXxnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Gcne9Cbuf5N2BxvrrqRzwwLYEnr/FagWPh/9ZQ0dxE=;
 b=DRL+hCSIzeDkTLY9T3VdRuot1r51IpyKIj/YvDTu41l/v7F2rdGIuxS+P1Cg0WXEUiKP/BIE0AyXIL0qtPZEVjMKDBb7ZhhDriUZWDTSr1aQZZgI93T3I4Ca3U3ZWQOSGjF05zneEgYWU5QlsxCfD5CUvLfMhHgq9832/duHDLAzR1p7oITLWKL1PM2JBOAi4Jrua31l1Snssx3qzUo940j448L9WFTIAK9EFUJmDnyTmMu2jNkcUS+f2cKIz3ysm6aoHnhaSXiSLnYiZu+hL6Of3MoLWr+ZfG7bZmB50cIqItL0yd/vmoZJhQ73JRHSEJtDVj96ryvbzDxAA7z9hA==
Received: from BL1P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::21)
 by IA0PR12MB8694.namprd12.prod.outlook.com (2603:10b6:208:488::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 18:41:37 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::be) by BL1P221CA0030.outlook.office365.com
 (2603:10b6:208:2c5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 18:41:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 18:41:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 11:41:14 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 11:41:14 -0700
Message-ID: <b93805c1-28a6-4ad9-b0d2-5116ef4b0d83@nvidia.com>
Date: Mon, 21 Oct 2024 11:41:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: page: add Rust version of PAGE_ALIGN
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <linux-mm@kvack.org>,
	<rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241016-page-align-v2-1-e0afe85fc4b4@google.com>
 <81e9b289-b95c-4671-b442-1a0ac3dae466@nvidia.com>
 <CANiq72mW8seB=938XZM7bwdSU43z0eePXinE5QPYyybvNfbUeA@mail.gmail.com>
 <dc5e7653-8d6d-4822-9c29-702ece830717@nvidia.com>
 <CANiq72kuQ-fNTYw33czgN3_DYjixzk01+hahFhR4QSkENeDBkw@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CANiq72kuQ-fNTYw33czgN3_DYjixzk01+hahFhR4QSkENeDBkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|IA0PR12MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: f3511769-555e-4ee1-b3e9-08dcf1fffe86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVRKN1Q2K3B0K0NrdHNpWkVrUUFacmFxWXVJakR5RG1hQTd5RFR2SURRcTBt?=
 =?utf-8?B?Sk5aUlY0aDZSay9mM2xrYmRIU0NuQW1hcHFLSEc3VUZDZ3UwRGVSM0xCWnM3?=
 =?utf-8?B?MjUydUZYaWJrTFBmNXpybHFkSU1XcVRIQWg2QWRuYTBsYXlmS2hYSis1MEh6?=
 =?utf-8?B?bUh0L0lYcGVmSk1FWjBGalVQSVo0TWJlTGZJSGptaE9aYnRQUjNsUlR3cnZi?=
 =?utf-8?B?QlJPcUpUVWJBTGk1VjZqN0xJSDB6emswc1VSYXFvS3c2ZU1xeU9idTQ5NVFw?=
 =?utf-8?B?UEg0V0txNVVDeTVDVTBrd2FsRVV0OUlGWUlzeXZpZHFTeU5jZkpRdkRhalR6?=
 =?utf-8?B?MEtMMjQ1elJUWHhvNjdxZDBRZXA3OFdWSjdZdUhiRmJBWGdhM0plMjZGSmg4?=
 =?utf-8?B?bmswSTg0SWdnMmovcEMxQXYzU1Z5MDBTVlZqSmM5anJKWGtLTzFvV2EyRW9Y?=
 =?utf-8?B?bzhURHJEZE5mL0FMb3h3dVlyQlZkMEg3YmU1Mkg0TitSOGJGSmtFVUpPaU1G?=
 =?utf-8?B?SVRCQk4zWW1PeVpLb01OVytHY3h1NSs3N3lKMFhEa2luTjJSWEJsOFc2elVZ?=
 =?utf-8?B?Z0dzTDNtMUExTVJ6K29MWnVjZTVkTlkxVnRORDZ3VVVlNGthZ1Y2dS9FYXNr?=
 =?utf-8?B?eS9MRzIrQmVZcTN5OEtDcU4wMVprUmRra0lBd1p2dXdKT2VvWVpVaW5OZzQ5?=
 =?utf-8?B?a3NDanlPc2VTNTlrd3dLVS9JZVYxTnczUFRyb285SFliblQ2V3dqbVVJSks3?=
 =?utf-8?B?NjRQMHVGYld2V1pzakwwelJnNDJhb3BXMnNFL1FaZlhxN1JZTFo4Z3FRSjNV?=
 =?utf-8?B?RnpwNzJBSy9BN05URTdldmpWa3NhMXM4SFM2ckN3dkVmeFE3QkpLVG01Q0E2?=
 =?utf-8?B?Vk5ENjllWCs3QzdoZXdlajlsWTdTZ0ZpczBxS3lLeXJGSTZXRDRVRnZyQXdF?=
 =?utf-8?B?U3Q4NHJCeGNLSG5wZEU5SG9Ec3F4K09mR1hGVGl4cUhpb2JkVklDM1Q0OGdI?=
 =?utf-8?B?dUt1MWc0dkk3c3Z5RWJvZEZFUmlBUlBkb1ZORjBGQmRxZ2tTMS9aaDlubTFM?=
 =?utf-8?B?cUVGOXZpUlJ0ZTZQeUhGUkhQMGhzdTA5Z1ZlM3IzUDVmTThRYUdoT3VEUmF1?=
 =?utf-8?B?VEgxdEh2T2tkeGFuUVdzRFQyMTFySHVHNGw3UVhGaE1GRFNJSjQ2bFhJQUlD?=
 =?utf-8?B?dWZHaWRwRDQ3dXpYem53ODRkdXdHdWw4emM5M3h3NDNTejhoQ1hlK1lyaVJN?=
 =?utf-8?B?NUplK0szb295aWhnc1VUQnlpQkFsRHRKd0lhMlFSYXhMUVE3U0pyYllqTGdZ?=
 =?utf-8?B?c0xKWEFoTXFERmtxTlFsaCtYeXl1T1l5dVc2QkliOVV1emQ2TFJOYzAyMTR6?=
 =?utf-8?B?YW5IcHZPdFJpcmhIcmsraVNNWENMcGszODRJT0NscFJ1eGQrejlPZHdKbWxn?=
 =?utf-8?B?aVpmVmJJRFRONzg1NEYzUFA1dWZJZFR0VW53aG1INUNtaVdIMUdDOVdpMDV1?=
 =?utf-8?B?NEJCcDV1ZzVBdTRuaDBRNzZ3ekc2WXlqUHgvaXdqMjA4eXNYTEpHdHhpQVJL?=
 =?utf-8?B?M2JaQld4MWtqM1RmMVFzS1JJTkNUN0VabWNYMnhPR0w0K29zNUc3ZWdNME1P?=
 =?utf-8?B?MG1kam5aaDA5VmVKOU9YeDEzL1R1OFVETWlnRCtYbTB0SU83SjVYTDRXUXBQ?=
 =?utf-8?B?RzJNalRLckpQUHMyK2taU1BJTXFUY1RaU0J1ZkVqZE02aFNmUjd0QWZldkJR?=
 =?utf-8?B?M2VEL29CT1RzMC9Dbk4wS3hKZUFLcEVZRXQrMEg5eDJwa21jSENCT2l6V3Bp?=
 =?utf-8?B?akxUaC9DOTlaZ1BBUEJpeTRDKytIL3hLQnJJZENDNHF4OGhQNFBseE1YaDdK?=
 =?utf-8?B?eFBlcm5HemxId3dUWGhmRHZwVmV5YlZtTDFjUVpoUUVPTXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:41:36.6931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3511769-555e-4ee1-b3e9-08dcf1fffe86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8694

On 10/21/24 11:37 AM, Miguel Ojeda wrote:
> On Mon, Oct 21, 2024 at 8:35 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> Is this another case of C and Rust using different words for things??
>> Wow. OK...
> 
> I am not sure what you mean -- by BE I meant British English.
> 
> See my other reply as well -- I just changed it anyway because Rust
> apparently uses "parentheses".
> 

Right. For spoken languages, that's simply preference, and I would not
try to impose anything on anyone there.

But in this case, at least for C (and, from reading my Rust book(s), I
thought for Rust also), "parentheses" is a technical specification, and
we should prefer to be accurate:

     parentheses: ()
     brackets:    []

Yes?


thanks,
-- 
John Hubbard



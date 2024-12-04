Return-Path: <linux-kernel+bounces-431137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009119E3958
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E7C2827E8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43121B4152;
	Wed,  4 Dec 2024 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="d7pFsz23"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013040.outbound.protection.outlook.com [40.107.162.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1180D1ABEDC;
	Wed,  4 Dec 2024 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733313450; cv=fail; b=CvXUiQPVyrfYHV1KYysQYN0wqMED12uoRDkfGxR9M1uNkW1lU3p1jtOIcWsvVbqLIIX3d8Vyrq8GeR9KGYx3/M+yA19jovzIVDlydEgyt0RnZGrLiik63/URw1Gm7QbQVZQEmmTLS2lwmn0K8Tfw0NkwdsGC/L2zFXum9ohw78Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733313450; c=relaxed/simple;
	bh=UYaEynB4m7TmBPGZ/3wuZ9otL+A3PP5K991gBKiH3f4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MFpiXXJcdOt9ORSaqbB+xsO52CNnPb+dgC6A/t4k+kKvQfZGO8VyE8OtClNreLgeVCbYqTOmPi5eEg/12T+z1M/7R7trZa1SsN4lvGsfULMiFa3tupXIOaWSiR9iZNFu0fWqWOO3VTd6GRByBMNV2h/nzYnyp+JgqCIn8+xeUjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=d7pFsz23; arc=fail smtp.client-ip=40.107.162.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BE5XaOhoX1n7Xr7RQZwRKYZyFFcrMouQp1f89TKPSaKp1H52c/O6N33ycjVU1lunz/j/hxceoWGpQM2ssZ56G/2Jgbsw+nYdk3UnNSYXMPkj/kny6r5zmeG8UtCHdXESlFjl3J877Kp0DxXer/lAi/hFLeaekHeXiAG38wDy+dntaGU3MGPIreM/d1RD2IlE4uUyNUuQF813KPTUYG7nifBfawVALRAxetyKhfNqA+m4a0dQ6lT1yFPPvECpCMsfIuADOpltXcpjEWuQ377Vt2F6yvRuaw9U3KnFiLPlHzt7uCqndIlRBmdOhKEuWqrcawhw6PB9khLQ6jVF6Yiu+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8A5EMBj+FKRofWzt22mCcTY1CJW6b9+Ar4X9SEgFNRU=;
 b=k0OOb+s5FW8bGmXzrCU0YTphg+MvyxbdrUwP8raWhzDz5GSD1CPLFN+iSuCIV2Fth/TfUxmFEONohf5L8v2AmKqltiMFxAYf96EXUhhcM+bQztLFOXLlrzOETg0TPBBIiUiaadzjOPc3AKMosYtskCbATh3IXMfLDPcBlgEqct4LBdsQgLnVZz+z4bBGLp29KuvvC/WG8eDeU+E4J+hBYFd59VRtToGRUgVkZAFtLfS2kKzlBUc4hSbPWAqGLPJd4wvopoCIDE35DNkCuZh8UIQHVahoSdUUHBZoONhMwmTWCRhKvGim3x1hFM3nY67I7ugbuazTd3pu+UoiGi71BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=gmail.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8A5EMBj+FKRofWzt22mCcTY1CJW6b9+Ar4X9SEgFNRU=;
 b=d7pFsz238TSmXuySIykj8lRVBoL3no2kbFvN2z5cEvMGKbeWO1YtU+auC0WD/jjyzfPj14WaRqUbs1MqT4RQ1sI928kGCwN0nYMXjMI9zcS/sZX4jiq13In1cyNA8uAsdNB0g3ikRANj3ntd50Xwt2WWIRe8AfXnmM85gr9Gzu8fpqifBthMrk09e8q6Ri8mkEX0nFJl8lcKrgz5KUet7AU4KyVMcYr9gGCDJ8S3SxygUrx2AWNHHiIKN/32U8ajz5+0CmPJK6Hx909hbnJ3u1+bEE71ngsNu4/xPS9VoLuz01JNid3zyzEa2u36sc4LY1IFyu+G7MKxyO7lUqs8cw==
Received: from AS9PR0301CA0019.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::29) by GV1PR10MB6634.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:82::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.8; Wed, 4 Dec
 2024 11:57:19 +0000
Received: from AMS0EPF00000199.eurprd05.prod.outlook.com
 (2603:10a6:20b:468:cafe::56) by AS9PR0301CA0019.outlook.office365.com
 (2603:10a6:20b:468::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Wed,
 4 Dec 2024 11:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AMS0EPF00000199.mail.protection.outlook.com (10.167.16.245) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 11:57:19 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Wed, 4 Dec
 2024 12:57:12 +0100
Received: from [10.34.219.93] (10.139.217.196) by SI-EXCAS2000.de.bosch.com
 (10.139.217.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.43; Wed, 4 Dec
 2024 12:57:12 +0100
Message-ID: <6c1ccd07-1a42-43bb-9162-0d6401db72fc@de.bosch.com>
Date: Wed, 4 Dec 2024 12:57:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] rust: alloc: Add doctest for `ArrayLayout`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, <jtostler1@gmail.com>
CC: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, <rust-for-linux@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241203051843.291729-1-jtostler1@gmail.com>
 <CANiq72ksaJcpjHi8=vuWLTLLfik9smaqY9oJXjwtieXgJ6Gy9Q@mail.gmail.com>
Content-Language: en-GB
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <CANiq72ksaJcpjHi8=vuWLTLLfik9smaqY9oJXjwtieXgJ6Gy9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000199:EE_|GV1PR10MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: 164b0ba1-1858-4328-33ae-08dd145ace48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tk1IQVpwN3I3eTlOaVBNRWRMZXdrWm1zTlM5UzFpUzlQUVR2R3ZaSm5QOTJD?=
 =?utf-8?B?aUdtTWhQL2NuS0QrOGhpU25nTnBhWWdmWFloTHpGMEt5LzNDQm1YQjMrYjd2?=
 =?utf-8?B?bHUweGx1VmQySkNZdEM1b3dMR0c0SG5TdUlPbDBQdXgwSEFzdUFOakl6L2Rs?=
 =?utf-8?B?QldvT0JIbm01WmVKR2I0RGFBRnFJUldJUkdac2FISkYrQzR3ZXNUVTRYejhX?=
 =?utf-8?B?OEVnSUFYYWtQaml3bGNaeFVCL0xWdkpQZ00reWloV2c5M3VMWjdZcmtpamYz?=
 =?utf-8?B?OUZOZGhWZ3lPSGtPem40amFOYjZWSml5OFgwS0lBU2ZYdy82M1pjK3F5RCtK?=
 =?utf-8?B?WUhYWEFHb29KVHhvQ2tlcFlnU3czUGFhS0xSZDd1VVcrZ2o1QWFQVEZqTEVW?=
 =?utf-8?B?dnEzWXdia3JEa3JVWVlaQjFqNG9XbXdkNWpzdmx5cmVlaGpWRzdoUXZvbEsx?=
 =?utf-8?B?Y2xYQk1nTHQ0TVdCYmxEcVpZdFgwYkcxcm5SVlRLcTlFY2o0RXlCN3I4SktF?=
 =?utf-8?B?a3Y0amVBcVI2UWdEbGoyODk1TmRzbzBsUm92Q1BxWjlIVUZFaEE0RktqdXda?=
 =?utf-8?B?b1ExaDB6bGpiTTVJa1hETDNGOVovM0Npbm5kUWJMbEN1R2dDL0dsS3JzeUg0?=
 =?utf-8?B?dmE2TTNIaWVLVGFwSlhxazNkSzhiaVdyakZ5VjVmbWpBNXZtWERtd3VCeXc5?=
 =?utf-8?B?ZVNIRzdsUU5SM2FjV3VBZWtOZ3h5RnRoM2R0SjNKMWQ0ZjJnSTJFMHo4NUtC?=
 =?utf-8?B?MW8zak5yV1A0TXMrY09PUWpLQWhLOWtJTjljNHNWVTlRNE84a00yeWlCUkZJ?=
 =?utf-8?B?VUFoOFlVenRPZDNyOGJkYVFzdlhwdVQ1T1RZM1ZHM0p5b3BzYWpkdWpacnRZ?=
 =?utf-8?B?V25TekRZbjBobGJWTXpWRWxlUjZsN0xZd0VyODc3V3VZMUNmcDZkSUNWMTY2?=
 =?utf-8?B?bkVKbjlHQXdmY3liRUNxd3VFRjZjUlN1Z3FEeWZOYzNJbnVBaUtKamlTRFlG?=
 =?utf-8?B?SFdOY1VaTGRwM3NkL09CTFVKbnpUb1JNek4vYUFBellwZGtObWRyR2ZwVGFO?=
 =?utf-8?B?SEIrN1NDSWhNS1VYdkh3aENiMnh5SjFsUldBOXpVZG9nZDhHOUJPY20vaUZm?=
 =?utf-8?B?MVVqdVN1Y2FsdWhzZkIrUXFJTGlvTzMxcDM3SXJDcWdRRlhpbzlOSWpkSUIr?=
 =?utf-8?B?eEUwaVJGdkw3OTBPWVVkL1dxcllhRXZiaFRYRUpKNHQ1QVhsSWZUSmxMMVQz?=
 =?utf-8?B?bE9ia3A4WDA4NVEvd0Erc0YyY3hIRWlxK1l1SkVrb1NIVXBtK2wrV0VKZ3gy?=
 =?utf-8?B?U3VZV3BueTg4SVh5dzBuenVRRWVLTFJzejhLNEVrODdBeGI4dUpYNW9zWnAz?=
 =?utf-8?B?dUlhWCtsbGRQSGcrR21mc2FITFo1SDMxekN3RTFkQXhPdEpHU29HdDhKbFpn?=
 =?utf-8?B?YlNGQlkzTE1VN05zL0pCZTAzQTVXa21VNk5ZM0lBY2Q3SkZld285RGJkMzJT?=
 =?utf-8?B?ZFBLL25vdmM3eVd4UXZEYS9PQTREVWpVVzUrVno3LzUvcUdhZ1QrS1BxM1kv?=
 =?utf-8?B?cXpuaFhEMGo4SEZUWEpDclYzZWJoUWl3MjM4dGV1RkR1Qm9Idjl6QTE5V1lR?=
 =?utf-8?B?RzI4WThrRVdCYWF1MW1ZcmtocnErc2orL2ppUUJUZkhSOCtRb2x0a1lFTWZn?=
 =?utf-8?B?Q0UrTFRIU3IvVTlwYTJkNWxCcEJxN2FxbFZrUlVsZ0Yxb3QvcEdaVFJyZkVn?=
 =?utf-8?B?TUlDNTFzYmlBTFJUWlJ0OTNsbHN4TFJSaS8zajMwakpRYUNRNDFMdUhwd1dz?=
 =?utf-8?B?SThQQnhmTlJ6UkVmUzBPSTU5dFZkV1RzU1F1YXFQNTdnRHZpWEJwcFYvRWd3?=
 =?utf-8?B?N2ljV0xtamRxRUMvU3RjTGhrWFU0M3ZHQ3k0a3J1UEF4OWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 11:57:19.6303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 164b0ba1-1858-4328-33ae-08dd145ace48
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6634

On 03/12/2024 09:48, Miguel Ojeda wrote:
> On Tue, Dec 3, 2024 at 6:19 AM <jtostler1@gmail.com> wrote:
>>
>> From: Jimmy Ostler <jtostler1@gmail.com>
>>
>> Added a rustdoc example and Kunit test to the `ArrayLayout` struct's
>> `ArrayLayout::new()` function.
>>
>> Kunit tests ran using `./tools/testing/kunit/kunit.py run \
>> --make_options LLVM=1 \
>> --kconfig_add CONFIG_RUST=y` passed.
>>
>> Generated documentation looked as expected.
>>
>> Signed-off-by: Jimmy Ostler <jtostler1@gmail.com>
>> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
>> Link: https://github.com/Rust-for-Linux/linux/issues/1131
> 
> Thanks for the patch!
> 
> A few procedural nits: please Cc the maintainers/reviewers, especially
> the main one (Danilo) -- for that, please see
> `scripts/get_maintainer.pl` as well as e.g.
> https://rust-for-linux.com/contributing#submitting-patches for one way
> to generate the arguments.
> 
> The "Signed-off-by" tag normally would be the last one -- that way
> people see that you added the other two rather than the next person in
> the chain. It is good to mention the tests etc. that you have done,
> although normally for a patch like this it would normally not be
> mentioned (since all patches that add an example need to be tested
> anyway).
> 
> Finally, a nit on the commit message: normally they are written in the
> imperative mood.
> 
> By the way, the "From:" tag on the top would not need to be there if
> your "From:" in the email headers is configured properly.
> 
>>  /// Error when constructing an [`ArrayLayout`].
>> +#[derive(Debug)]
>>  pub struct LayoutError;
> 
> Ideally you would mention this change in the commit message too -- it
> is the only non-comment/doc change, after all :) It is also important
> because, in general, so far, we have not been using `expect`.
> 
>> +    ///
>> +    ///
> 
> Please use a single line.
> 
>> +    /// ```rust
> 
> You can remove "rust" since it is the default.
> 
>> +    /// use kernel::alloc::layout::ArrayLayout;
> 
> This line could be hidden -- it is `Self`, after all, so it is not
> adding much for the reader. We are not fully consistent on this yet
> though.
> 
>> +    /// let layout = ArrayLayout::<i32>::new(15);
>> +    /// assert_eq!(layout.expect("len * size_of::<i32>() does not overflow").len(), 15);
> 
> See above on `expect`.
> 
> Moreover, since it is a test, it is fine to panic, but recently we
> were discussing that examples should ideally show how "real code"
> would be written, thus using `?` etc. instead.

Slightly off-topic here, but should we try to document that somehow?

What's about something like [1] below? If it is ok, I can make a proper
patch for it :)

Thanks

Dirk

[1]

diff --git a/Documentation/rust/coding-guidelines.rst
b/Documentation/rust/coding-guidelines.rst
index a2e326b42410f..f09af264fff12 100644
--- a/Documentation/rust/coding-guidelines.rst
+++ b/Documentation/rust/coding-guidelines.rst
@@ -373,3 +373,58 @@ triggered due to non-local changes (such as
``dead_code``).
 For more information about diagnostics in Rust, please see:

 	https://doc.rust-lang.org/stable/reference/attributes/diagnostics.html
+
+Error handling
+--------------
+
+In C, it is common that functions indicate success or failure through
+their return value; modifying or returning extra data through non-``const``
+pointer parameters. In particular, in the kernel, functions that may fail
+typically return an ``int`` that represents a generic error code. In Rust
+this is modeled as ``Error``.
+
+Use Result
+~~~~~~~~~~
+
+In Rust, it is idiomatic to model functions that may fail as returning
+a ``Result``. Since in the kernel many functions return an error code,
+``Result`` is a type alias for a ``core::result::Result`` that uses
+``Error`` as its error type.
+
+Note that even if a function does not return anything when it succeeds,
+it should still be modeled as returning a ``Result`` rather than
+just an ``Error``.
+
+The ``?``-operator versus ``unwrap(``) and ``expect()``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Calling a function that returns ``Result`` needs the caller to handle
+the returned ``Result``.
+
+This can be done "manually" by using  ``match``. Using ``match`` to decode
+the ``Result`` is similar to C where all the return value decoding and the
+error handling is done explicitly by writing handling code for each
+error to cover. Using ``match`` the error and success handling can be
implemented
+in all detail as required.
+
+Instead of the verbose ``match`` the ``?``-operator or
``unwrap()``/``expect()``
+can be used to handle the ``Result`` "automatically". However, in the
kernel
+context, the usage of ``unwrap()`` or ``expect()`` has a side effect
which is often
+not wanted: The ``panic!`` called when using ``unwrap()`` or
``expect()``. While the
+console output from ``panic!`` is nice and quite helpful for debugging
the error,
+stopping the whole Linux system due to the kernel panic is often not
desired.
+
+In consequence, using the ``?``-operator is often the best choice to handle
+``Result`` in a non-verbose way. For example (inspired by
samples/rust/rust_minimal.rs):
+
+.. code-block:: rust
+
+	use kernel::prelude::*;
+
+	fn example () -> Result {
+	    let mut numbers = Vec::new();
+	    numbers.try_push(72)?;
+	    numbers.try_push(108)?;
+	    numbers.try_push(200)?;
+	    Ok(())
+	}
diff --git a/Documentation/rust/testing.rst b/Documentation/rust/testing.rst
index 568b71b415a45..aed50070c979f 100644
--- a/Documentation/rust/testing.rst
+++ b/Documentation/rust/testing.rst
@@ -123,6 +123,11 @@ A current limitation is that KUnit does not support
assertions in other tasks.
 Thus, we presently simply print an error to the kernel log if an assertion
 actually failed. Additionally, doctests are not run for nonpublic
functions.

+As these example tests might be used as examples for "real code" they
should
+be written like "real code". For example, instead of using
``unwrap()``/``expect()``
+use the ``?``-operator. See Documentation/rust/coding-guidelines.rst
(=> Error handling)
+for some background.
+
 The ``#[test]`` tests
 ---------------------




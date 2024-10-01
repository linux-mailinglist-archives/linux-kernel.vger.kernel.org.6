Return-Path: <linux-kernel+bounces-345209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDDE98B32B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7943F283F37
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 04:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7629E1BBBC9;
	Tue,  1 Oct 2024 04:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="BgRZqhId"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275C71BAEF8;
	Tue,  1 Oct 2024 04:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727758619; cv=fail; b=aoZzu0RJ3rZgDS37dzMijHlz+h9gKdBQAAKLPlEM5cTgGrmmWGuTSUs+QohDXEUuUKFTPYOh3insRJyMnWcH4V2c+br/mQJgT+TASKCLoCnk9HwDyRAktnrX5fRuMR6em66zBfSUMFpyLueBlP4XLgU8dV5mCoblc1IZft9k/dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727758619; c=relaxed/simple;
	bh=tYUdj0DN9S7C3daRbcDfUyQu3508qXeatwPuzSWaYw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dDx2kDXvpwjdNTAJwzivYAaH9dDXjqAZmlnZJHOz/RE9jCqMRO1quvMRVKi0TCwfDMrKFZ371PuICBcujQMaX5lWu5y0HlH99AwxOY4gr1xhQ4NWRJiOzZIUFmtLmIlabC6+OrrTYI6wQKrHIjhYECdavZklwL1wqtcWiLUm2Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=BgRZqhId; arc=fail smtp.client-ip=40.107.21.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjJcf5vnvLFHvnkbv6/Le0ZSRE2KUz3LMzsIEjMeGzKBwd/Ze82kNRagP5p/pEOFEvBzCFxTtRj5xeIjmN3HjFHjVBGgsExLl9sp804EdZVPDX54/BUxnF4cndOzs56QtT46n8DkKjYjfyYpaBZPcmHHaAFEDNm7Jbr5OyOHKApa7dppkNFtXe2P2iVZwEbI3+jPUBRuJw3Ubj6NU+3QpjEsUf+UNeRm/3AkirkksQhRZwqWgKmv8fvmp40XugD4830/KcY7obNAoxcFSOAQ0HlsLrdCc2arM+G2f6P3FdaCV8wwrgMemQk2h2tY3ekfV6LWgPVnKJQHQ89KTLpSHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKl7koysEE/fomPlYnBh9NEAbve0+I6ET8/ajE/NBnM=;
 b=n4xCwaawAADAOc7tNvXby/fnubJwCBoNf8GqmCsNkmI8SWTN7Onzw3SpO5VVcEDVASni9Nsw/P/vADkDaTSxnyVTLJXfvP707nSVhg4pk8ah6B7l8NmOjFGb7EjnaHfghaKEOK9wU6KCXeAA/LP51TXNLDmALlIuJJMVKC87AT3jpCKMXLoll/5x9917COpl6JqMqQGS0VndoxsVnwh0hOJQSOao9W5bEnu1zTroQeWQz9T++TRRtUizQrWyXiMzExo3l2OBjC7p+gNgaCXT/7nPkVCnQNViwjHMUn7P0jy2l5xI10zZAWpkOgWjciR5lGSIn0JAeUyqChOPp/ggIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=proton.me smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKl7koysEE/fomPlYnBh9NEAbve0+I6ET8/ajE/NBnM=;
 b=BgRZqhId+P3HdVGswJpF0fav+o8qOK5JEdkYDjgv/nhaXt/v/mD7GBzYaN4ouf/CARAH4l8F3DAZmm5+mPky1b4RRGaPe6p7QoaZBylpggMreZnoZibOjBVTR+PgIKW9XF2Opfef/pwxbFwKSxVASMA7rapSz61fdAWs8CzlVCU3nf4S5yTCOOReJmLtX8RBV3Ob13MAn+GKSVl0mXv4z35IpalNv6c7az+7vify5gnSt5i3uM8qZDJKlL+V3gCJU37nkUeWQ8wQS32o5wsJZrMZkhefduanl+/h/MxbuhmYFY+3Qce24kfl6d8x814mKWQJ/cvWZzEv7r+ZCO+pBw==
Received: from DU2PR04CA0018.eurprd04.prod.outlook.com (2603:10a6:10:3b::23)
 by PAVPR10MB7060.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 04:56:51 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::9d) by DU2PR04CA0018.outlook.office365.com
 (2603:10a6:10:3b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Tue, 1 Oct 2024 04:56:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 04:56:51 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 1 Oct
 2024 06:56:21 +0200
Received: from [10.34.219.93] (10.139.217.196) by SI-EXCAS2000.de.bosch.com
 (10.139.217.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 1 Oct
 2024 06:56:20 +0200
Message-ID: <ad3e4f4c-883b-49a5-ba4b-562c13eee08e@de.bosch.com>
Date: Tue, 1 Oct 2024 06:56:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] rust: sync: add `Arc::as_ptr`
To: Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg
	<a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
	<alex.gaynor@gmail.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>
CC: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl
	<aliceryhl@google.com>, <rust-for-linux@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
 <20240917222739.1298275-4-a.hindborg@kernel.org>
 <e7e42ff2-1543-48b3-9bd3-bdef5ce66348@proton.me>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <e7e42ff2-1543-48b3-9bd3-bdef5ce66348@proton.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B622:EE_|PAVPR10MB7060:EE_
X-MS-Office365-Filtering-Correlation-Id: 161f949c-9a8f-4c3c-745b-08dce1d57690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2VYUXlNYk4rZ1hjeU1VM1pKdTRCY0dMVThZclJrUkMwK3N6YTlxRHdIYjhD?=
 =?utf-8?B?clZLZzRSWXVNYmdWeCs2SkdQWTluQmEvcGowbUY5d0hNZytMNWhqR1hCVy9I?=
 =?utf-8?B?OEVzRGsvVWIwN3FjMW9hVXNJNnhvVWV0MXVEeUNDQ0lzNFByT1NzVUQ2U3VX?=
 =?utf-8?B?Y0hsNGRldWNHRW5NVS9DTGROOElSR2pYSlZFMGdkUmJkdmRZYm5raHNXSzht?=
 =?utf-8?B?YjQ5STlSNVh2ZGVmQWN0NGJ5U05lN25uNVFkTnByZkVXZEpiMm5tTE1pMG1w?=
 =?utf-8?B?M3hUSFdCeXQraEVkM2lCQVFJWHl1ZFRab29wTFFmZlJQY2NtZEh4elhCbkdZ?=
 =?utf-8?B?RUMrUHc0VFQ5ZVo4c3h0dE1mbmk4QW9LVEtRR24rbU9hTXZxWVlrOEhjSTJz?=
 =?utf-8?B?WjNBbmMvWnk4NFZIeG56NmhWcEQ5a2FJUURVYkVITi9jUTZleEU3UHp6M1V5?=
 =?utf-8?B?aHBMT0JTMEhTWldwMTg2UTF6NVBaTGE2dkdhY0pWNzNIVTRsaEF5Sitpb3dr?=
 =?utf-8?B?aTRKY2RFUUJoeEdVN0FjUG9XVGJMeGtmMGkwZEFXTlBucTN2YlpiMVFLSFgr?=
 =?utf-8?B?Si94aXNpbDVRbkFzK1BOL3lJbE1iay9LWno1cVErUDJSa0F5dDlBRjNVeDFm?=
 =?utf-8?B?Mk9JQ0xnckwybk5Xb3lRL3F2enpYODdEeVJ1aG1XTmhVZHNlK1RZWk5lRjhL?=
 =?utf-8?B?SUh6RGsrTlNxRGdYOVRoaEh5cUxGVmUrTVNJamZDOSt2U1pxQmdoY0VyUkFY?=
 =?utf-8?B?enZFMzdMNjhSZnZoY0pxVzV5b01ETk9XQXlpTEpTQ3pjWjNsQ3VreU0yUFpL?=
 =?utf-8?B?ZENYL3pQMW9oNXVuVUdycUU5YWxoU1E2VmdkS2hJNm5WU2s5eDNjVWhzYnNQ?=
 =?utf-8?B?ZjN0dGZ4TEtzZ2dSeEN4dEd5Y3YveUg3REJsM0R3ZXNQVUw1RGZmbkRuN05J?=
 =?utf-8?B?UjZTcUN1aHhXUjM2cDZPZ2IxQ1EyWFgveU1RTTJ2QThQV0lIcU1VVVNtaDRM?=
 =?utf-8?B?SGxGRmIzSm1wUHYwNkZrN3lRdFJPbTdLZEpsS1o0RnY3TlVnNTlNOWRrWHFa?=
 =?utf-8?B?YXhCa1ZLbDlSTHZvSndnenZFTWZLbDBoUmprSDE4ZXhrOHVjcDlsSVJWZUM2?=
 =?utf-8?B?eERoYWMxMkxWZnhPYXp1bmFSN3FjdnBadjdMbnNTNkdTTlVWalAzNnZPNXVQ?=
 =?utf-8?B?UnYrZnJBUHBad05QQk93cGRQNXllTkNjdmhKUTB4TnE1ODJQQUUxd2V6RG53?=
 =?utf-8?B?WmdIM0E5S2ZCczh1SkZHQkp5dW9QQXpJSXdJVnVUTHNNekk4RzNiN2xuYS9Z?=
 =?utf-8?B?V3VwYk5yckFveml2Qm5vajVoUnRFeHVkVXM4Und3ZW1yMndjQlZTNDlaZHhC?=
 =?utf-8?B?NVNrVUwxclppbXN1Z0FaOU8vbXdjUzVneVJKbzdLWnVrK054MHgzczkyNkJ1?=
 =?utf-8?B?S0w1U3dyVjhkaWcwKy9GLzJxaFd3R2c0dVRtT1pQRlFLTjVDUStSek9lUWQ4?=
 =?utf-8?B?NVFFU25TeDFOaUNSNVZnWHJVQklpL0RSU2l4L2lha1dkWXM3M0ZyTlNDdm9K?=
 =?utf-8?B?d2l5RlgwVmo2UlFNeHpmNklpbjJqcnF2M2ZaZERBVnJYOHVXclpYS2JNcmJx?=
 =?utf-8?B?cTZkMzIzMUJMRGYzVzEweWk0OE12UXpkNTlJeVNJME5KQm5neVkvNFVQdVpj?=
 =?utf-8?B?dUkrZzE2OGhyUXlHendiM3B3aGRFM3UvV21RV1FIczN1WFJHRUUxcjFHdmhk?=
 =?utf-8?B?RWVoaXVDOGtlUEt5UFZsaUFKUnRjYTE0ZGpUbFdWRGFSWGVuVzZTSzR5a2pt?=
 =?utf-8?B?WEgrei9sa0E5VUt0NmZjUlB6ZWFoblh6ZU91WTl6SHZqR0w4M3lYUXAvOGYv?=
 =?utf-8?B?eStsSlg2L3AzOGpqOSt2ajdKOUh4MldkOHB3eGZ4Tld6SVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 04:56:51.2292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 161f949c-9a8f-4c3c-745b-08dce1d57690
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7060

On 19.09.2024 16:03, Benno Lossin wrote:
> On 18.09.24 00:27, Andreas Hindborg wrote:
>> Add a method to get a pointer to the data contained in an `Arc`.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>   rust/kernel/sync/arc.rs | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
>> index 3673496c2363..a57ea3e2b44c 100644
>> --- a/rust/kernel/sync/arc.rs
>> +++ b/rust/kernel/sync/arc.rs
>> @@ -258,6 +258,14 @@ pub fn into_raw(self) -> *const T {
>>           unsafe { core::ptr::addr_of!((*ptr).data) }
>>       }
>>
>> +    /// Return a raw pointer to the data in this arc.
>> +    pub fn as_ptr(&self) -> *const T {
> 
> I don't know if we have a convention for this, but shouldn't this be an
> associated function? Because if `T` also has an `as_ptr` function, it
> will be shadowed by this one.

Yes. In Fabien's out of tree regmap we have an as_ptr() for Regmap [1] 
which operates on &Arc<Regmap> [2]. Once this patch is applied to arc.rs 
the compilation fails as then Arc.as_ptr() is used, not the 
Regmap.as_ptr() any more [3]. Switching this to something like [4] makes 
the compiler happy.

Thanks,

Dirk

P.S.: Just to learn something: For the unmodified, failing case: Is 
there a rule when which as_ptr() will be used? Is there an order rule 
for the shadowing? Any documentation link?


[1] 
https://github.com/Fabo/linux/blob/fparent/rust-ncv6336/rust/kernel/regmap.rs#L71

[2] 
https://github.com/Fabo/linux/blob/fparent/rust-ncv6336/rust/kernel/regulator/driver.rs#L418

[3]

error[E0308]: mismatched types
    --> rust/kernel/regulator/driver.rs:420:33
     |
420 |             config.cfg.regmap = regmap.as_ptr();
     |                                 ^^^^^^^^^^^^^^^ types differ in 
mutability
     |
     = note: expected raw pointer `*mut bindings::regmap`
                found raw pointer `*const Regmap`

error: aborting due to 1 previous error

[4]

diff --git a/rust/kernel/hrtimer/arc.rs b/rust/kernel/hrtimer/arc.rs
index ff04b0b75bb39..7c39ab440e1c6 100644
--- a/rust/kernel/hrtimer/arc.rs
+++ b/rust/kernel/hrtimer/arc.rs
@@ -25,7 +25,7 @@ unsafe impl<U> TimerHandle for ArcTimerHandle<U>
      U: HasTimer<U>,
  {
      fn cancel(&mut self) -> bool {
-        let self_ptr = self.inner.as_ptr();
+        let self_ptr = Arc::as_ptr(&self.inner);

          // SAFETY: As we obtained `self_ptr` from a valid reference 
above, it
          // must point to a valid `U`.
@@ -57,7 +57,7 @@ impl<U> TimerPointer for Arc<U>
      fn schedule(self, expires: Ktime) -> ArcTimerHandle<U> {
          // SAFETY: Since we generate the pointer passed to `schedule` 
from a
          // valid reference, it is a valid pointer.
-        unsafe { U::schedule(self.as_ptr(), expires) };
+        unsafe { U::schedule(Arc::as_ptr(&self), expires) };

          ArcTimerHandle { inner: self }
      }
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 1466d9cd41652..0a314c2f4c5ea 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -259,8 +259,8 @@ pub fn into_raw(self) -> *const T {
      }

      /// Return a raw pointer to the data in this arc.
-    pub fn as_ptr(&self) -> *const T {
-        let ptr = self.ptr.as_ptr();
+    pub fn as_ptr(arc: &Self) -> *const T {
+        let ptr = arc.ptr.as_ptr();
          // SAFETY: As we derive the pointer from a reference above, 
the pointer
          // must be valid.
          unsafe { core::ptr::addr_of!((*ptr).data) }




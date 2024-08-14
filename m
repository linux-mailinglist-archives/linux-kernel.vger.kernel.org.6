Return-Path: <linux-kernel+bounces-286395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C49951A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB35C284ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594D21AE849;
	Wed, 14 Aug 2024 11:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="caI0ftG1"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E65D33D8;
	Wed, 14 Aug 2024 11:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723636529; cv=fail; b=qvT6mS2sxu9kIIPQHIfHXBiC7bQaF/LKO4gCVyD1KLVwRYadkXQ5arm/OZRNHYpYZvUU/rVoKZ3smPpY9rguUiQrFIUz0r/viHKkw+t1MwqFnbleSIZNiQeYp4McU3cwTexUtFMJuE0Uuq34b7KYZOHM/miVFXQeRcRObrjMD+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723636529; c=relaxed/simple;
	bh=+9H/baClj9LI7kQEhROjzOagWRdU5pbxwYS7yklpvt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rw8dN1RapBYAbgiHQ1LhEcjbGGSF5SJPaUpzmdVaRBp286tj2poAtax9vrPfw2KIdROvcYFeJpnaEyKrZZweeO1/CWv/nkb9qvNRmMz8HAEzsFHDs8q9bAimYWY74pCDcYpY4dllkkFfE+d8WEDa5mTWNg5diXEyAZ9ag18BZns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=caI0ftG1; arc=fail smtp.client-ip=40.107.21.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAzc9qqjKiL/c/J/BsgnAs3UgZM6S0dzcim9aYo7wDLwiEEaDU7rrbzxgI+pzALu7caflV+E9n2ltScDNGfoLrcp/FGbuYgkQhKYkp49hb2+6QQYY1XouEp11DxgiP0juO+2RNWwtfp3KcU3kpaH0jZEGQVajPeUckJ6Hq8YZY9Gv+OukHTFlYr9Ed1M6S/YzAzU44UldT+Pf2IJhzfwQh5dNvFHcYf5Uudpwjg6468rfpmPD2g51KlBa56ntySNyks2Fs38YMqxNs1y5TnP+fGJxFbc+NQRwFn9Rfyapd94rknGyDrIh8di0fx1p8uSZEcUNcCa8cnBfe2pF0g/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdC2q/4Gi5rx4a3nhwLZpAoee7VZoXBquTNped1AM7A=;
 b=rRh415onp1oTT22+Dpb9VRkhn0OcHk23GpcKbGna5tSUFS3IgEHhph8vT5yfUG81lU9xMIErLhlGbC/gX/t9F0k8oiApo91IKkb0Q+gTCwfp7v+Dekid23t7OxPg5vFARk+cYgg1Moyvr3GUEmd+Gg6dxowIQsTJt9uDLUCQfAm1+50l0Gf9v0p02qRhANpxv77l4a+nVqVvbWcbwx2Oi0v3+dB+JeSv5/2330cRIxvc/D9zkeBJF0ojtucMhCkKDgPorhp5okE4TOkTFTZZM2AOSTGfTVBdU1RXgErljnSvCFnQay+nNJohbwCFsnhe06pYl5iM/3WHVjtPRG7pQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdC2q/4Gi5rx4a3nhwLZpAoee7VZoXBquTNped1AM7A=;
 b=caI0ftG1cW2nlaK5hLm+MLMpdV9j1sGzY8Xqa6YLtExZx6sZUjJMA4m+1mKB3OsgWcCNmH5CmAnfOlQt4MPtTHmjtqqvNvD0b0OMZ6xK5zG+/CKIisuPMP3rz2/VZIMJvSsulOc6nzKIvxU/IVKf4HfYKYcNoXrL1eAs184kOGCKVRFrbcwCsd6+dOxL9xJp+UeTGF2FSsOJca1vAm1N9BWaK14Vi6z2z1CjEC+qMU53GsqPQKSNY63fkzFC9BhPekmv22V84BLGk0Oa3s54NaIGxuRypy0GYuakx0oS7uGmPvofSUIdUahapxxXSwmtz5NzL2q1kJ9OoG1ZdBg4BQ==
Received: from AM0PR04CA0085.eurprd04.prod.outlook.com (2603:10a6:208:be::26)
 by DB9PR10MB8141.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 11:55:22 +0000
Received: from AMS1EPF00000041.eurprd04.prod.outlook.com
 (2603:10a6:208:be:cafe::6b) by AM0PR04CA0085.outlook.office365.com
 (2603:10a6:208:be::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Wed, 14 Aug 2024 11:55:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AMS1EPF00000041.mail.protection.outlook.com (10.167.16.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 11:55:22 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 14 Aug
 2024 13:55:22 +0200
Received: from [10.34.219.93] (10.139.217.196) by FE-EXCAS2000.de.bosch.com
 (10.139.217.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 14 Aug
 2024 13:55:21 +0200
Message-ID: <d83155b4-1c73-4191-85b6-55d1b904a926@de.bosch.com>
Date: Wed, 14 Aug 2024 13:55:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/26] rust: alloc: remove `BoxExt` extension
To: Danilo Krummrich <dakr@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <wedsonaf@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <benno.lossin@proton.me>,
	<a.hindborg@samsung.com>, <aliceryhl@google.com>, <akpm@linux-foundation.org>
CC: <daniel.almeida@collabora.com>, <faith.ekstrand@collabora.com>,
	<boris.brezillon@collabora.com>, <lina@asahilina.net>, <mcanal@igalia.com>,
	<zhiw@nvidia.com>, <cjia@nvidia.com>, <jhubbard@nvidia.com>,
	<airlied@redhat.com>, <ajanulgu@redhat.com>, <lyude@redhat.com>,
	<linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20240812182355.11641-1-dakr@kernel.org>
 <20240812182355.11641-12-dakr@kernel.org>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20240812182355.11641-12-dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000041:EE_|DB9PR10MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 70dffa1b-464d-4526-3f80-08dcbc57fa26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWhoeXo5bnN4SXlaZEJLSVIwV1d5SkZjUU90aUpoM1VNQ21rZURhS0xNaWhT?=
 =?utf-8?B?V1A2Q3B5cGRPYzRxdXk2TmZpQnlIR0k0OGp5dE53WlhWMnBINkg3c2hWdDdK?=
 =?utf-8?B?QjZjU2dxdlYzaXFZNlJXOHRGWUdOQ0ticmVpZEFwY3htallqcU5Xdm5QZkNR?=
 =?utf-8?B?V2Z3VUoyVVVEY1c5a3JjeVo5eFRmbWV6VGwzWGhpRG9COWF6cjlPK3ZwK3hT?=
 =?utf-8?B?eXc1eHByb1IwU0xQdDN5UkFyVHlOM2pRVlBsVGZrK3htbW5FaDN3NTFVQWd3?=
 =?utf-8?B?a3BXci81cHRjWEg3RXc5L2tEZktDOEdUcDNhUVE5UmdMVDlteGlWZUg4dUZ5?=
 =?utf-8?B?cloydTJpSlhmZlZCNmh5cGgxV0FSeWZ3QWp3M1RIcDJjcU41ZDBiZjlvS2tJ?=
 =?utf-8?B?bU9abkdtRWU5NThTcnNNWU9aSHZXZFA1TzdYZnVJL3A2bjZVM3Z6dDc4c2Jj?=
 =?utf-8?B?dUthbG1QWUdkRUNqdDNsaE5ZTitOV09oQnJuWCtDRUgvOVdORVZEZ0VjdEw0?=
 =?utf-8?B?R3Q5THdZelpiWWN5eGZsMmExTUhxR3d4YWF6aWJFQVA4VGhIWkZCWWYwTDY0?=
 =?utf-8?B?b3c0NWZRMlpkSWZSUU1YM05DQi95M0NuK29BNklWWVpoYnI2ZW1kRUthMyt1?=
 =?utf-8?B?Nm8yOHRZeXhYN284ZExCZ1pXQ25WYUZLNVlzMXc1cmFtQjFFYnJpQ2JucCtz?=
 =?utf-8?B?VllQRW9rT3dpMjZMd1A3TGdDcTZrM1NsTmRGMDRxUGlHV3owNi90T3lSb2k3?=
 =?utf-8?B?Wk9NL3M3RUJpWHpIVWlWSE1ZRU9LZXIzSnUzUStYeTZ5M0lEWlp3MzUvTDl3?=
 =?utf-8?B?VHFoTE1KM1hiNno4bktWVGMwTGJ2MzRrVGRNOStqUGYzV25IT0dremxQNW9G?=
 =?utf-8?B?S1c5WTdmcTJQd2JKV1pPR3RCV3pKdEU4YW1OVEhkSEp6UnY4SGF1TlZ3UWEz?=
 =?utf-8?B?M1c4ZjN3MGtibEdFajFMSTU4UnN0MExscUxhVktiNmVtTHdkYVlDUXlwdGJB?=
 =?utf-8?B?bjczTWFaSTBQUDhIcnlZa2N2d1Jvc1ZwelE5VkNUK2FoWDIwdk1mTHFhSVVV?=
 =?utf-8?B?N1BiTDNuZ0U0bVM5dmJ5VS9NYWJNQVBXRTl6QnhBWEJPYW5zSkd1NHByMm9w?=
 =?utf-8?B?d2k4N0IrbTBicVVtZENEelVISjQ0MkhhUUgxMk5mMUZUUUdTTHV6YlcvSUYy?=
 =?utf-8?B?Q09BUHVmbmw5eGxzeXdtNEdlS2NhcUovaGRzZDZuSGpjQlEvMkRyV1hEcVM5?=
 =?utf-8?B?VlBUNDRYbFRYL2xpaE5pVWdpMGpObE5BbHJBUEtrUG1BZ0s0YmZNQUJtSy81?=
 =?utf-8?B?TlBSc3JsUXRSS1BDWVZuZlFWTXI0T1FQTzY0Q09PT0c4ckkrSjVsQUhLcTZt?=
 =?utf-8?B?UWg0bXMxc3IvYitRaUc4NlBDNCtDR0ZzQ2tXWVRyUHNtVXlyYXkrZ3FrUVNF?=
 =?utf-8?B?d1gzVENTTzhBblpmVkZFbDJaVlpDekdBbnRYZ1htY0dXMVVZVmdDZXlSdFpU?=
 =?utf-8?B?WWUvbnk1bmxSZlpURGIrbWNCUCtBdTJzNFNUTncyazZKeVNuR1d4bk12UkYz?=
 =?utf-8?B?VS9HWURNUXpjUkQrUGYrMlk5aTYyU2NzZWhJSHhSQUY4Y2w1VmdTQnlnR09M?=
 =?utf-8?B?QTZWVFlUeDlGOXJtS2doRGF0YVFNMFliRW1zYk0zelZyQTBOUCtZSDNPc2pN?=
 =?utf-8?B?L0pmUEZyT0NneVYvbU82RG9OdlpCdVplVGZaTDFDT1NKTzNKK2hDRjhsUlZm?=
 =?utf-8?B?N0tQQWhCaE1sWXc1ajBMNUdIdW9UcTdzb0dFbGVsWE0zcHZnZlYzMlFJeDJj?=
 =?utf-8?B?RFBoa3JLQ0IrVGRYZ3gySE1GUzVlaVFHd3ZVNklzMUJEZW1iT1RzRlIxTE9r?=
 =?utf-8?B?OFpLOHZhWU9YWEVhVXJ5aWtlSnFOSFdtR0xFckdCaEN3d0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 11:55:22.3973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70dffa1b-464d-4526-3f80-08dcbc57fa26
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8141

On 12.08.2024 20:22, Danilo Krummrich wrote:
> Now that all existing `Box` users were moved to the kernel `Box` type,
> remove the `BoxExt` extension and all other related extensions.
I just noticed that in the recent 'rust-dev' branch we have a change 
which *adds* something to BoxExt:

rust: kernel: add drop_contents to BoxExt
https://github.com/Rust-for-Linux/linux/commit/62c34da1da6c01a635ea2308cb42996d0571059e

I'm unclear how relevant that is. Just want to mention this in case it 
would make sense to include that directly in this patch series to avoid 
a future add-on patch ;)

Thanks,

Dirk

P.S.: It looks like anything like this at least makes the compiler happy:

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index d67f975502246..e91d441835d54 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -9,6 +9,7 @@
  use core::mem::MaybeUninit;
  use core::ops::{Deref, DerefMut};
  use core::pin::Pin;
+use core::ptr;
  use core::ptr::NonNull;
  use core::result::Result;

@@ -270,6 +271,28 @@ pub fn new_uninit(flags: Flags) -> 
Result<Box<MaybeUninit<T>, A>, AllocError> {
          Ok(Box(ptr, PhantomData::<A>))
      }

+    /// Drops the contents, but keeps the allocation.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::{Flags, KBox};
+    /// let value = KBox::new([0; 32], GFP_KERNEL)?;
+    /// assert_eq!(*value, [0; 32]);
+    /// let value = KBox::drop_contents(value);
+    /// // Now we can re-use `value`:
+    /// let value = KBox::write(value, [1; 32]);
+    /// assert_eq!(*value, [1; 32]);
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn drop_contents(this: Self) -> Box<MaybeUninit<T>, A> {
+        let ptr = Box::into_raw(this);
+        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
+        unsafe { ptr::drop_in_place(ptr) };
+        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
+        unsafe { Box::from_raw(ptr.cast()) }
+    }
+
      /// Constructs a new `Pin<Box<T, A>>`. If `T` does not implement 
[`Unpin`], then `x` will be
      /// pinned in memory and can't be moved.
      #[inline]
-- 







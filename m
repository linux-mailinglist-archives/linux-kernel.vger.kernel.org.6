Return-Path: <linux-kernel+bounces-522383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1909A3C974
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9195B1889D32
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E40B22E3F7;
	Wed, 19 Feb 2025 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="o1AmmdRX"
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021086.outbound.protection.outlook.com [52.101.100.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ABCEEAA;
	Wed, 19 Feb 2025 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996245; cv=fail; b=LkuQC8Qf4+4cAGHpOJ0jMol6SEYZjt9uhzM7mNeIgycPQOttBdr2YfUX5zgX7OeWdjAeOceR3+8YkO4UdiCkEYYR9JLjw9sCmk5vR16PYQPpXOpyOeI+VTvpKija//AhOlKKot5o5dOP+GoIeOVl0DKTgHA9M0Wh+HZ/bv8+fxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996245; c=relaxed/simple;
	bh=57F9H9cid+f5sk6Rg2VbDCegnoZihq519rd5WFtGZmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jLb+gE0MH3jRA7eKJa+UZ2qdP7rEeZGlIcjpmjVyUkz1/oZ8szqR6y+3CeiZ55GCZ2gmkoqraMcBJADFXUSXhUU2dOfs2nL0fpMLV5L0o969U9SRmN7493uTOF0DStqg/w8MF33Iz9HvGYr520eyPNRHu31BAA5MFArq57cWeE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=o1AmmdRX; arc=fail smtp.client-ip=52.101.100.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USrSsyKzfxTx7NhefI6C5RvnFvMXeoqKAa1YfAMcH5wHha6hw0guYIHSx/RPCx+KKxxjbzdm+5cowpb6614Fymn9rhuy8txjX4f3fmUCR39YZVrKpWrDZ5tVm+05aTQn+RyoLEpsdc6WHLM1d5lnHjpwZjGfEItphXVEL4h3cd4fxOCy4g0I7QkPjEJu0a5RW5z6raIR24E157uXn0anzaoKsvU/7R403O+410k9gFgDoIXo7ppCQs3URFEnbY79BfptbNNHZksgeNKJqLYC+vF2i9wH2R/4t/IYsTJt56r1z1nE2Arn0DSFlCqfLiMtE4O1xAtTdJURwfPrNBPFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3OjeCQFUqK0mZLsIu5Vd0ymD0QGE5uSzh4XqZ3vans=;
 b=BOSL2B7IgVDGN0ONxtkZZrZ4uqZV3EAyDOCaaa4/cPw+7ACQtWnVfp5kUwn5y2gwLzixqAWoVehyZo1KEoV9qa83eS2aaw7pUQQ0EAu4MBVTFeX62yejT6DDbGxHIm5S30sJfYzRxLNrtwNkdD3l5PYqFjI/yIxr67pm/ktNMosbgB7G4b0/ifK44YdPGcfUG4BkHzZCXUukQRhD3APij4ZLH02fBPp6s263UeTgi+/BRfRePcjbtBzsTLbIugL/cCIDtGPXZzx/EFTJlzkFVwblA7UHLob5KaC1QlBVwOBiH6vdlSkQii1O1TLIuYFKEfcX8dBWBsIbEsrJ5uWPWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3OjeCQFUqK0mZLsIu5Vd0ymD0QGE5uSzh4XqZ3vans=;
 b=o1AmmdRXaANjDzfTD0bVZMLTRy9OWyg3j+P9zHsIjr/VK2s8LwA1fJYSYn0v7qZ8H6xq0j47HXA5LrC/1PSLZX37kdhTWURAQySiZ7J/yXd4ASg4nOCzA+9YtNtXwKq3xFj0H1o33ZSRt8bJ01Ktnz9Qsd5KimI7gif/2KfLoEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB2783.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 20:17:21 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8466.015; Wed, 19 Feb 2025
 20:17:21 +0000
From: Gary Guo <gary@garyguo.net>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Lyude Paul <lyude@redhat.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] rust: implement `kernel::sync::Refcount`
Date: Wed, 19 Feb 2025 20:15:30 +0000
Message-ID: <20250219201602.1898383-2-gary@garyguo.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250219201602.1898383-1-gary@garyguo.net>
References: <20250219201602.1898383-1-gary@garyguo.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0225.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::10) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB2783:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b6dbc8a-1ffc-4e40-a4dc-08dd51226a79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YXIwrfe8+8uPJuxYApnZfWia5UUKyErKRtkWW6zpW3/Brlu/JXVohYBaEa/A?=
 =?us-ascii?Q?MCjY3pIhh9+NcV8Ac+c+vdh0RgnQVuWamrR0LQoWjg7M9E+TRJKNXFYV1C2F?=
 =?us-ascii?Q?tNtgEhsKSBN4eVSEiWtNQL5c3vTJgo/35+Pw7ZEbrt6XxGKHQCLzcjwftIBk?=
 =?us-ascii?Q?4xJq+ppXNTK2loThj210P7tWv2Mlv0gOobGKGQMuJeYWWfxQ5hqEjY51CJC5?=
 =?us-ascii?Q?gARHSWxXN5Z3RI3WnOq8nWA1E6mYQkbtgeTJPv4cDvUKmOQQ61CQMds3dPlq?=
 =?us-ascii?Q?m+So+lOHDplr61NdA3SZVgKzRxtOlvvO1yAqyWGu9y75+CsMqXSQSMHkjetW?=
 =?us-ascii?Q?isbe4oc2Hgsn300LsEVI/aAFl9te4z9HUcfHheNShGAf9qYxAP4T8ncisE9S?=
 =?us-ascii?Q?F5VP7/WMPdfOkJz/OmSSgMQgj9MAakwAXRrrT+2RqooGDbm+uXFyyMV9mSWi?=
 =?us-ascii?Q?nZ5JXSc2nYD10Wtck7L4E99dSJxyYaJVipEzWt6WhsmD/LYE7Sp0DKxM7U7a?=
 =?us-ascii?Q?TfsoCBMqzspASXrDOWdbSRXZ5z2/f2g/sh0XAvOKYev1CQue7C6cvBJrl2gY?=
 =?us-ascii?Q?IO4dh5cmZpL82wpTsTqranbjfxqorOPZ7HgF+yq4reiJgbioy6kZDQX8c0tc?=
 =?us-ascii?Q?H/eSTPwcLMWH0+NEI/onxbupoQmSijflfGHk/P1iWbFfF+r1437N4cFsgG9f?=
 =?us-ascii?Q?c6pCiN3kmq0H+brvMtKHKRlf1z3YLx/lkX+6tLIz7koRBfq2/rgg9vwlSIhU?=
 =?us-ascii?Q?XMvY8b8Vdxp7h3nEgHlAH45+Sy3lHQMEalNycmuLKtzO6PklEAHIqv4YTJyY?=
 =?us-ascii?Q?5aFf4+KUq6boUYbcx5eSIsLwEHoUOzMTLkIZZapC2W5NkRK6Eu+7xsmq2sFm?=
 =?us-ascii?Q?eStEkeSXS/S8G+ZdxNuvP+GvRAdUjIlsIQbIBayCFYA8pDvWW3ZYQgZmDo+v?=
 =?us-ascii?Q?6ry/hzKHvvoE25LdKyToSyY+StVSmf0dtBGzg4EvntNWyJURKZU5ofq6JAJS?=
 =?us-ascii?Q?BVRXGOUTLPpvgqf6+bfakhqt8IZfgFixQjn2BhomRzsNECnEDo+vRSUy9mEn?=
 =?us-ascii?Q?10UBWPqwh9astW/9TalhylhjBztlIFAMx0h6bgPtgLVBvqLSz5Qu3tryJzw2?=
 =?us-ascii?Q?5qA/nHrWsVl4fp0zgk8+vnurdI5DvDU34Jd/e6vKcOZI7lKP4/osPGIfLDGC?=
 =?us-ascii?Q?k09HJXYDBgdhiM7iRWXDReTGaIntkYuo8gHYgiLZBuJUMtaGbrCWXGX9n+u1?=
 =?us-ascii?Q?hP0Jn92sV8pQLBuEoFEottBbu2gpWJp3gdIZrJr2cX5IsVVUxDShwibOyIJe?=
 =?us-ascii?Q?WzFZLdiwKbEHrkDeZMPCjMpwfR+jZ5UvEw3aszRRcMKAY4+vnW+OAXfrSRaA?=
 =?us-ascii?Q?6OiGv6Qryew6JmTThS1WlhMCPT40CgysFnMxp8utwK+huEGdQTb3QSBxqCXP?=
 =?us-ascii?Q?uce238cHjQc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ArW5mWQ9cZ593UF5PR5J9Ilsho0qL+WCT7ohLartUrxzvTVHsbd66A+om9a?=
 =?us-ascii?Q?7X9LqMdejPkjMglTv5GCYVv9iUkTpPLCN8fb7p9/jTSnugJ5IC2oSt0qBQW3?=
 =?us-ascii?Q?ofpqbh/BrBkdtNuPNZFcDlI2WvAS21HaRrPwZGXZivKuuTPtrB/b03Z5CWR9?=
 =?us-ascii?Q?MBnoFL7H4ESVO0b5XqXuOtV8e/iWUBqV25D21i7oCEbyj/RaiTJF1ofN/gOk?=
 =?us-ascii?Q?LAg0PX5LXaJKCQIu+O9jsM47tGC++pIS95r9ZEVUb/IOLE77znwX3Ue9g1kQ?=
 =?us-ascii?Q?YIOoQ6sE79mdAr2lHRnLvWkVg1lILi+yyLcz5ZydLAKBRRZNRsxP2fBp3Li8?=
 =?us-ascii?Q?khleAMa5hnXgHncXoAGwxwAb2EPsb9YyFMfBhE5fD8V7YvdKgKTXvKk2Rp2l?=
 =?us-ascii?Q?Ttjt6opfVblfaRWmELa3Tqxfhv+V6wO9rXXfJdBjyO5/jo6LAXYFK8Q8N+Ey?=
 =?us-ascii?Q?CVMZk5O8c5Sl8pxEGe+XJJERP69npU7oNimsykAze00CSzR7xxoSW0IGVNAo?=
 =?us-ascii?Q?0CHGHRYo/VYbiuC3L4aXiOCaGpa2EjbOAWrc0pGh8tvPrEmTIXSTMwUH9SPa?=
 =?us-ascii?Q?DNrDMSQBeihOoINYbniCIsbeAi+Xp326YgsELif/nRGrus4M3MJv7/b7M5Eh?=
 =?us-ascii?Q?G46+6x4OIRSNtw+XzY3YFUkFd6FrwzRzJiUlCdZTzHjNolNFJS62k8YylanG?=
 =?us-ascii?Q?ss2AODFxrP41sHirlwewkkB1atdI1TNrGp9pA7tTtN9znPaWu6uV2WS42Rjz?=
 =?us-ascii?Q?atqZaS9yK8rJOPuhInrWHfpvAPQ98wqILvL4BnJZt2t7Yxk+BMZuBnNi3uel?=
 =?us-ascii?Q?Zd2Zj+GWqSkeqT2ZhfQxzKSg28mPPuICDUS+wrb50IEEbP94mE/tYayn5ySy?=
 =?us-ascii?Q?JeNDBjWk/11s3xI10mnMBpg8EqlaENJUcpCwy9BxJMpZkuuR/nVzvaqWJ/tS?=
 =?us-ascii?Q?XrLQOeSDWasbuBWyPEwJ7z6gc7yeTbNZiwBi50dmcPieaBRkBp4A8GjYWrUx?=
 =?us-ascii?Q?OtpOglqtB5dd3RDmICiL7FiRuPI3mSdq5SsAO9fms/HL8G1+ULmg6YDpyFn1?=
 =?us-ascii?Q?Th5W4MP69iAEA1mx+IoBvl7iw5h7q9x6x50huyn5yr/Q7l+WBhFQu5W/+2rq?=
 =?us-ascii?Q?bbyluPFQHaJI5yE+OEbRU5xbOleTFpcAlyivI4xqOWPl3PDgMi+alENORB5w?=
 =?us-ascii?Q?6+ofdvyGpLVaMdTyiHP8oUFYdXPyT0ppjbKhLrWL5Ah293t5GLk70uEOO9uA?=
 =?us-ascii?Q?ztLi954oogGZXaUC02xAM5z0/UAshTXf6mRTTRF417KzbSAXMDYu/x5Z1mCE?=
 =?us-ascii?Q?m0JTnY9BfLcrOHQjbWfVEJDhkXtQswukRJ7xK4su+CUPhXy1MyQgYd3bdun4?=
 =?us-ascii?Q?37qXxpPVF8VP3+TT1DlreC0Y5uUG+VcfJByPdGkcYKGWi0Y0TP2a78/z9pcC?=
 =?us-ascii?Q?NQ/wcZZPQosm3L4WDUu8pmjQPgVyIV+ns3QyVDDIv+Ix3UOWYRSFVcIe0QLH?=
 =?us-ascii?Q?ue/vDes2T0ceoluNPJx8MAc6NK6xTTwRLBS4Pq7queTTJOJIyOluqz16o/Oo?=
 =?us-ascii?Q?3mVpa5UXsr6aOWqh2pDAj9dZF/LKPuyTXdOwxeGfOe02EzQ1FtELXY9NQ0NK?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6dbc8a-1ffc-4e40-a4dc-08dd51226a79
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 20:17:21.4889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mKtE/UBi5KfAAdPIcpGL9qkatayuDTi1V2IkCimH4CGEMNUEJkFuLh3VSCx20lYENdZJeY+WmXHjAOff92Jpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2783

This is a wrapping layer of `include/linux/refcount.h`. Currently the
kernel refcount has already been used in `Arc`, however it calls into
FFI directly.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/helpers/refcount.c      | 10 +++++
 rust/kernel/sync.rs          |  2 +
 rust/kernel/sync/refcount.rs | 86 ++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 rust/kernel/sync/refcount.rs

diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
index d6adbd2e45a1..d175898ad7b8 100644
--- a/rust/helpers/refcount.c
+++ b/rust/helpers/refcount.c
@@ -7,11 +7,21 @@ refcount_t rust_helper_REFCOUNT_INIT(int n)
 	return (refcount_t)REFCOUNT_INIT(n);
 }
 
+void rust_helper_refcount_set(refcount_t *r, int n)
+{
+	refcount_set(r, n);
+}
+
 void rust_helper_refcount_inc(refcount_t *r)
 {
 	refcount_inc(r);
 }
 
+void rust_helper_refcount_dec(refcount_t *r)
+{
+	refcount_dec(r);
+}
+
 bool rust_helper_refcount_dec_and_test(refcount_t *r)
 {
 	return refcount_dec_and_test(r);
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 3498fb344dc9..b196cd0b358e 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -13,6 +13,7 @@
 mod locked_by;
 pub mod poll;
 pub mod rcu;
+mod refcount;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
@@ -20,6 +21,7 @@
 pub use lock::mutex::{new_mutex, Mutex, MutexGuard};
 pub use lock::spinlock::{new_spinlock, SpinLock, SpinLockGuard};
 pub use locked_by::LockedBy;
+pub use refcount::Refcount;
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
 #[repr(transparent)]
diff --git a/rust/kernel/sync/refcount.rs b/rust/kernel/sync/refcount.rs
new file mode 100644
index 000000000000..a6a683f5d7b8
--- /dev/null
+++ b/rust/kernel/sync/refcount.rs
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Atomic reference counting.
+//!
+//! C header: [`include/linux/refcount.h`](srctree/include/linux/refcount.h)
+
+use crate::types::Opaque;
+
+/// Atomic reference counter.
+///
+/// This type is conceptually an atomic integer, but provides saturation semantics compared to
+/// normal atomic integers. Values in the negative range when viewed as a signed integer are
+/// saturation (bad) values. For details about the saturation semantics, please refer to top of
+/// [`include/linux/refcount.h`](srctree/include/refcount.h).
+///
+/// Wraps the kernel's C `refcount_t`.
+#[repr(transparent)]
+pub struct Refcount(Opaque<bindings::refcount_t>);
+
+impl Refcount {
+    /// Construct a new [`Refcount`] from an initial value.
+    #[inline]
+    pub fn new(value: i32) -> Self {
+        // SAFETY: There are no safety requirements for this FFI call.
+        Self(Opaque::new(unsafe { bindings::REFCOUNT_INIT(value) }))
+    }
+
+    #[inline]
+    fn as_ptr(&self) -> *mut bindings::refcount_t {
+        self.0.get()
+    }
+
+    /// Set a refcount's value.
+    #[inline]
+    pub fn set(&self, value: i32) {
+        // SAFETY: `self.as_ptr()` is valid.
+        unsafe { bindings::refcount_set(self.as_ptr(), value) }
+    }
+
+    /// Increment a refcount.
+    ///
+    /// It will saturate if overflows and `WARN`. It will also `WARN` if the refcount is 0, as this
+    /// represents a possible use-after-free condition.
+    ///
+    /// Provides no memory ordering, it is assumed that caller already has a reference on the
+    /// object.
+    #[inline]
+    pub fn inc(&self) {
+        // SAFETY: self is valid.
+        unsafe { bindings::refcount_inc(self.as_ptr()) }
+    }
+
+    /// Decrement a refcount.
+    ///
+    /// It will `WARN` on underflow and fail to decrement when saturated.
+    ///
+    /// Provides release memory ordering, such that prior loads and stores are done
+    /// before.
+    #[inline]
+    pub fn dec(&self) {
+        // SAFETY: `self.as_ptr()` is valid.
+        unsafe { bindings::refcount_dec(self.as_ptr()) }
+    }
+
+    /// Decrement a refcount and test if it is 0.
+    ///
+    /// It will `WARN` on underflow and fail to decrement when saturated.
+    ///
+    /// Provides release memory ordering, such that prior loads and stores are done
+    /// before, and provides an acquire ordering on success such that memory deallocation
+    /// must come after.
+    ///
+    /// Returns true if the resulting refcount is 0, false otherwise.
+    #[inline]
+    #[must_use = "use `dec` instead you do not need to test if it is 0"]
+    pub fn dec_and_test(&self) -> bool {
+        // SAFETY: `self.as_ptr()` is valid.
+        unsafe { bindings::refcount_dec_and_test(self.as_ptr()) }
+    }
+}
+
+// SAFETY: `refcount_t` is thread-safe.
+unsafe impl Send for Refcount {}
+
+// SAFETY: `refcount_t` is thread-safe.
+unsafe impl Sync for Refcount {}
-- 
2.47.2



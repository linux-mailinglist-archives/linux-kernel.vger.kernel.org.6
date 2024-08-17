Return-Path: <linux-kernel+bounces-290817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECE7955916
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 18:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF82E1C20D7F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 16:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE6F1553AF;
	Sat, 17 Aug 2024 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="cpZFotpV"
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021125.outbound.protection.outlook.com [52.101.100.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614587D417;
	Sat, 17 Aug 2024 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723913659; cv=fail; b=NiFrrCeyT3/fCjm37AVswHfI6JJ6DK4/9OdjI7eG3aJJLqLv25B6icLbF+ocGU3pjSvJf4yriuwLlfXs+pt44l/zYfkvklPyfBD+yaQ8OFntW0AGELUVLYpK0Qx2WH5f2YgORTr7f9gJt+lQhLl7cJlVWpP2NejjHlRQJznUU74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723913659; c=relaxed/simple;
	bh=VE+Pia01QW1TbqteHzqkr23eaBvj2I6g1kdEiBBTyRc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OHVJdK9MKkVzxWCs75V5nNprnsjzVv7VPn5AuLI1fiirn+PhrVJFYltXEj8N4IHmURuHRD9CB2gTL8sYSwxkKHjB1HPWASPjz5dIQKIWhZQE40appd6amj3UWjtfYd7XUMNv4N+VhFFFzIE3sqGr5poYH+tii9zyCSa27NeAM+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=cpZFotpV; arc=fail smtp.client-ip=52.101.100.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9Mcli9/+nbtgao/jjTWxOljNTRIUlj87jfMSK9O0us/IwQi7WNdk/4Q6IQfEp4JKxojx++zdoihsL6BRlCIF0pf0nwAw0/YHoGlGRVEXMJSy3ZOlEnFy5h7+iGXjTFDQn06HCbYanda6gacdWGCu8UgaNpIpHLBNLRAgvUzTwh7dB4Ow2dn+lrx2+CzwmhWg/cNbCRgZpJx21UA1PqxVY5Yd3d6AiUmu02IJIerzdi4luo5FzUFMF3iuFMNMKdL//lS5FXp3f9Jj/zPAU+ZlI3+J2lQnC12HGpeBVHQPnWiBtZJSyhwKn/ONOi24Gd8j9u1fwhWRlyFIKvfpwIJzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fB+SZULu2Adta05MYEZabaT2Tn+as/RGpHzeLr4/+o=;
 b=AvW1wajGDyavckZODzHFVmeIRh7+R65lHML8osXCuNiwqFWKTcNfQEBNaYHhmm1hXgGNOtjLOnK4IJHxtxvoIQeOKKA/us2mAvRxsHfFQA/9G8oYJszTkigU6pKlvLBKTMb4BlE3PWbWyWxdJWCh98RFd2SC+9oXMQQ0vbNIvD4wzACPbcknO4oZ6/B3xaK2M4KPSwRdW7KVoYOe5aaCbU6gvETA2XL/UzyodiMrPt6fw2PCqDdkD1ApNjByWc6zb+ZZMO7va4Ym7tVU6Yzu3pTMHFIrK/Awo1c7e3RS99K+Xb61zp9ZfCRAh8OpjMb5oIb400+BzoPIqAxwoSwjXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fB+SZULu2Adta05MYEZabaT2Tn+as/RGpHzeLr4/+o=;
 b=cpZFotpVozGdpAalVDeqokBXHcz0F53l7Zeu4Yn/TRO7JEwXulMo4VtM1ZR4stG+EezAY3H8I/KhzI9rF1j02z6JKT7E6mfLhcSAo+HMvJJ0v0LwxJvphx/O52O+Tof5PaJyT3ewB08yTScKkPk9pUg6VBLIIQ+T5nnYZmK79c4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15f::14)
 by LO6P265MB6876.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:31a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Sat, 17 Aug
 2024 16:54:14 +0000
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::4038:9891:8ad7:aa8a]) by CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::4038:9891:8ad7:aa8a%6]) with mapi id 15.20.7875.019; Sat, 17 Aug 2024
 16:54:14 +0000
From: Gary Guo <gary@garyguo.net>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Dirk Behme <dirk.behme@de.bosch.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] kbuild: rust: auto generate rust helper exports
Date: Sat, 17 Aug 2024 17:51:32 +0100
Message-ID: <20240817165302.3852499-1-gary@garyguo.net>
X-Mailer: git-send-email 2.44.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0567.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::20) To CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:15f::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB5186:EE_|LO6P265MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: dca8a008-9420-4139-6832-08dcbedd3972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AQrjzwVbjSasFcfyH1E8SosMQyojIcpnKwCa+rJ7wKQsE2w1h6yAC9QbwlJw?=
 =?us-ascii?Q?Ir7/XEIJd5E3wQaaeWAjpnSHpg0Yc7rj9Ip1ZkhzizyrcE4MAwhyWrud/ajU?=
 =?us-ascii?Q?JnIWEHIeYOGl2eZy0Pujv1QK+xHfgxBzsw4AJ35mpDCEDf9WlJD2lCglCvae?=
 =?us-ascii?Q?lRnxgGR6BqZ/iVs0/Rw8HnCKAs6Y81afrFtmTqresdstbWYgbzEUX+D5rFEB?=
 =?us-ascii?Q?yux8/A9VYgeKYus/snV7WpHGE61hoy3rTC/ENCiCnvLUM8taMtcjKmiGoelz?=
 =?us-ascii?Q?J7/wlShpb7ESmxEAARG6WEezeWK7Rp4aa+YX4eVXadZAIj1+LTc/GldDx1ej?=
 =?us-ascii?Q?EUk5rUmSPFD4Wz6C0hQGbzTf9Y6Lehz3upFl1awcIJ0YM9MVyrRlBJP6Vixv?=
 =?us-ascii?Q?iDN0nhRcg/IZDxGbjyDmCOica5s7KjyDlhGYP1obirbksZBZYEX0tnoKfrHe?=
 =?us-ascii?Q?c367PVlsyPnzwOiV1mh9peb80MXONQi1PaVhVt+I49pKMO7GjGeNHiCrCH9n?=
 =?us-ascii?Q?htmMPiqPM7saDcfQVgPomNGMd9EtdbRcTTYPnsFFGEhABPbqUhSyEhC96LRm?=
 =?us-ascii?Q?v39xao1KKUuNrNoJDH4lps67wzZZww1GQswTM9PmEvK2Hj7Z5RuTo0D+tQCY?=
 =?us-ascii?Q?Ln4blLSHUzpIHn2hIRU+AfGgJDe2iJCzbek6tfB+1mDjcUWy39XMTnAojv4g?=
 =?us-ascii?Q?Bn05OR9w8VVpw7FT+qdzmyDJSdqqEUhThZa5MLXYkxx7eceOFS9T6/X/4SqN?=
 =?us-ascii?Q?tV+VVmBsV8UQr+BJ1G+1NDKfhXhWXQnP3TeWDL9GMxFMchv5RklF2EkAJqWs?=
 =?us-ascii?Q?BHXeEO4bgeIo5aSnKZ+l0Dy+goXNCTgrbsuwkdhCSTIFb/4rptP3OrFAWVFe?=
 =?us-ascii?Q?4+PR3i7h6T8nkqrqTsZ0iKJ6b8yteAUgTFTWZVfdHdqKOSSA3p0PoGA9CFwd?=
 =?us-ascii?Q?C0NVR+HKC5lrReDjp3npvVM1/8vRKQrS832T9cPtXh6+lB0RCddVwNzbUcYE?=
 =?us-ascii?Q?oIrIRhTQRiEkUnonzONAH4gnlDm/HyXqrrDPQxPpOjonutg6lEfJdm3BMngu?=
 =?us-ascii?Q?aIm7V6BpqBK7Re3bvW2ReRVcEqgPsbmklseyrAHkWxuNOdOGL8+SyfNAcLsP?=
 =?us-ascii?Q?N/6ovhc509JnpT2hoA9wTzPtUnPeDmASb31h0uKoK1RotzNOMu7OCVUWpiuC?=
 =?us-ascii?Q?Vf17BGNRKKSEonMIgVfcK5fBHwsZNwzEPVUW77QB/z+QkZTOGkvrDR1OJOYL?=
 =?us-ascii?Q?mrEPJ/U/xzF6ky/nD6n9VHQZHN9qlbLiQvB0rizaHfhFYARsYZJEsjw3iUJH?=
 =?us-ascii?Q?zRe3+xKpmtnvekZ3mrkcO6IrJVziFE+LZvnXxeL8fr19RaMzMzy2NBIllznS?=
 =?us-ascii?Q?Arel+n90Rho2kWT5UTpTMG//luIexPM27ltWjDkoZ6rQkhpJbQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FogBLKsXA3uiHGa4xFj3TJcBaKcjVWnEtcecgTJgqm4Dw7U9tFo13XShyfc6?=
 =?us-ascii?Q?zOGLnYpi6oXhl2KpzF3X+75bcOtQtXwreYtM3V/lu2ISJ5VTMsG4JGZFV0PD?=
 =?us-ascii?Q?v2vGc4gAe7MkPd5MvAp3RxeW4AmvQ9YxlxnEZLaym46JaIPh9DtWZOHZhexM?=
 =?us-ascii?Q?kDomcRjaXnY+VU+E0Mk5a+ydbRrpJoKViTQhW7hCrWKPX99OUpPxpEwFOL6F?=
 =?us-ascii?Q?XrV6OYtpi2ggthsNi26iWCgLRRlABs3sZ6hefB6nRkczisRZe9JcWsazB/BY?=
 =?us-ascii?Q?Ey3EDIz5iRwMBNPKoPl67KC7RedfJll2NNzMwY7PCPvz3VLvLWhf/DV3+p/M?=
 =?us-ascii?Q?DirM8JD1ymQUNg0uMWVwJsGcbzYGrfqSc/Rvk1N8/vFEswt/MJN1NmXS3exO?=
 =?us-ascii?Q?xgSwt5LmwDyy8DupA7+wafPqNCF2z2krKQbdQp25TRBNhn4m2w6uUy2moITZ?=
 =?us-ascii?Q?nQMVKKe9kaJhBov89RDCDs+w3dae9aH88e5ilAjEUkYkTsFPI5ua+kKkW2Ce?=
 =?us-ascii?Q?vUgQ7RXm3IaqO7H92TsmqJJ97/CEgHIPt0A7finBFU38ORQoCbmahOKugwNG?=
 =?us-ascii?Q?13SLApaDF8A5nNhyDhC2QZYETLWyGv3QRajkKy5Yx821J9j5OmeKkFs0ZhH4?=
 =?us-ascii?Q?zkymVIeXTyNcbcT6tM8JevQVm37XWxQEQcHDlZNgcU5TF3/VBJpu65r0wJ8v?=
 =?us-ascii?Q?adO/7fJtpuxMxl3GT8oMXetHLQeZL990N5b4Zc76HWsSUTi5pzq3WOcBDQju?=
 =?us-ascii?Q?qL/ucA3nT1Bga5P7Kgr3zZLA1A/u5DHIJzHhZAb5Zr9ZHIUwtDG/lpaHS3oj?=
 =?us-ascii?Q?MaslDuG5mp4ForKLJzwqV1oWjpNFLFy3WbFqUV/ogSjHKIzbSKIl9yZTZtpU?=
 =?us-ascii?Q?wz+Bv7Bno2LThkMKzzfSkofp+6ZaawJ8V3l1+FJpMAI1Aedc2Woq2O0p9bCU?=
 =?us-ascii?Q?988/AcL3V5rAhSIlkSzozZMkuzoWbFLVralN78d6FcCK3k4HVoKQE8owDtVw?=
 =?us-ascii?Q?X36G8Hv9CPYzxR1MS73srTQ0yJCDwy2Vh8xWJCv40sZSGwrjRleV+XwFY4Oq?=
 =?us-ascii?Q?Roh4w9CwadXjjhKKsWt7hwx2o4BfeZhwS0LvQOa7wqtSF2TFiRl8eyCDO2dI?=
 =?us-ascii?Q?HR7g17VesJhWzhMZ2BuZJKpFNDsPE849pdEjJqYlfOYWejtvT9kXHal3z8Sd?=
 =?us-ascii?Q?22RcMsimN5zlMHNUW+SMqtORtZa+yKzjQGy1cdmo/zpBvpABUeoN9TXx70Sh?=
 =?us-ascii?Q?iH0h3xAa/bb681nD4le2nwVEJy20xZFjp0tnaZeD+cFMlSl8puZgTBJFRsd2?=
 =?us-ascii?Q?eK/lZ94lLl62K2WXXApyFv4Mvbz7W3FBYv9YEcO7DfLZpKY89L6aEinZk7VA?=
 =?us-ascii?Q?yw6CK88RLBqjfJtf1wRAU6XFsykls3L5mRuB2T5Tn1sDzMGdWuWN00SHCYW4?=
 =?us-ascii?Q?QCzqQZoCOjVOzPYGhpN+ancXZYAi46zBOSMg2vhaaJFic+Ta9YnLHJjK4xVA?=
 =?us-ascii?Q?HG8ubxCUGhqQ1ckGh6xD4s8T4KwDAlO//eFW8pkS1lkvUzpR+i+/yHNy6wF2?=
 =?us-ascii?Q?Qo9zIzSSY+jRsNpO1DFB96OrQYS2ynAoEKqCQU5g?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: dca8a008-9420-4139-6832-08dcbedd3972
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2024 16:54:14.1950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1Pnxcd+/dgxkPyMjXlglK6uJB1UCSDK5rwrfQwKDjUcpVYhJMGn+7vQwORUtC+CxpCoOIbB3GDnwUE9cBr7mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6876

This removes the need for explicit exporting all symbols.

Generate helper exports similar to what's currently done for Rust
crates. These helpers are exclusively called from within Rust code
and therefore can be treated similar as other Rust symbols.

Signed-off-by: Gary Guo <gary@garyguo.net>
---

Notes:
    Changes in v2:
    - Split from the helper inline RFC [1]
    - Rebased on Andreas' split helper patch [2]
    - Moved comments about helper export to Makefile
    
    [1]: https://lore.kernel.org/rust-for-linux/20240529202817.3641974-2-gary@garyguo.net/
    [2]: https://lore.kernel.org/rust-for-linux/20240815103016.2771842-1-nmi@metaspace.dk/

 rust/Makefile            | 16 ++++++++++++++--
 rust/exports.c           |  1 +
 rust/helpers/README.md   | 12 ------------
 rust/helpers/blk.c       |  2 --
 rust/helpers/bug.c       |  1 -
 rust/helpers/build_bug.c |  1 -
 rust/helpers/err.c       |  3 ---
 rust/helpers/kunit.c     |  1 -
 rust/helpers/mutex.c     |  1 -
 rust/helpers/page.c      |  5 -----
 rust/helpers/refcount.c  |  3 ---
 rust/helpers/signal.c    |  1 -
 rust/helpers/slab.c      |  1 -
 rust/helpers/spinlock.c  |  3 ---
 rust/helpers/task.c      |  3 ---
 rust/helpers/uaccess.c   |  2 --
 rust/helpers/wait.c      |  1 -
 rust/helpers/workqueue.c |  1 -
 18 files changed, 15 insertions(+), 43 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 967da95ba8b0..3171a9021494 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -16,8 +16,8 @@ no-clean-files += libmacros.so
 
 always-$(CONFIG_RUST) += bindings/bindings_generated.rs bindings/bindings_helpers_generated.rs
 obj-$(CONFIG_RUST) += alloc.o bindings.o kernel.o
-always-$(CONFIG_RUST) += exports_alloc_generated.h exports_bindings_generated.h \
-    exports_kernel_generated.h
+always-$(CONFIG_RUST) += exports_alloc_generated.h exports_helpers_generated.h \
+    exports_bindings_generated.h exports_kernel_generated.h
 
 always-$(CONFIG_RUST) += uapi/uapi_generated.rs
 obj-$(CONFIG_RUST) += uapi.o
@@ -313,6 +313,18 @@ $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
 $(obj)/exports_alloc_generated.h: $(obj)/alloc.o FORCE
 	$(call if_changed,exports)
 
+# Even though Rust kernel modules should never use the bindings directly,
+# symbols from bindings crate and the C helpers need to be exported because
+# Rust generics and inlined functions may not get their code generated in the
+# crate where they are defined. Other helpers, called from non-inline
+# functions, may not be exported, in principle. However, in general, the Rust
+# compiler does not guarantee codegen will be performed for a non-inline
+# function either. Therefore, we export all symbols from helpers and bindings.
+# In the future, this may be revisited to reduce the number of exports after
+# the compiler is informed about the places codegen is required.
+$(obj)/exports_helpers_generated.h: $(obj)/helpers.o FORCE
+	$(call if_changed,exports)
+
 $(obj)/exports_bindings_generated.h: $(obj)/bindings.o FORCE
 	$(call if_changed,exports)
 
diff --git a/rust/exports.c b/rust/exports.c
index 3803c21d1403..e5695f3b45b7 100644
--- a/rust/exports.c
+++ b/rust/exports.c
@@ -17,6 +17,7 @@
 
 #include "exports_core_generated.h"
 #include "exports_alloc_generated.h"
+#include "exports_helpers_generated.h"
 #include "exports_bindings_generated.h"
 #include "exports_kernel_generated.h"
 
diff --git a/rust/helpers/README.md b/rust/helpers/README.md
index 940b24bb552d..f2be545ef946 100644
--- a/rust/helpers/README.md
+++ b/rust/helpers/README.md
@@ -3,15 +3,3 @@
 Non-trivial C macros cannot be used in Rust. Similarly, inlined C functions
 cannot be called either. The files in this directory explicitly create functions
 ("helpers") that wrap those so that they can be called from Rust.
-
-Even though Rust kernel modules should never use the bindings directly, some of
-these helpers need to be exported because Rust generics and inlined functions
-may not get their code generated in the crate where they are defined. Other
-helpers, called from non-inline functions, may not be exported, in principle.
-However, in general, the Rust compiler does not guarantee codegen will be
-performed for a non-inline function either. Therefore, this file exports all the
-helpers. In the future, this may be revisited to reduce the number of exports
-after the compiler is informed about the places codegen is required.
-
-All symbols are exported as GPL-only to guarantee no GPL-only feature is
-accidentally exposed.
diff --git a/rust/helpers/blk.c b/rust/helpers/blk.c
index d99c965eb59b..cc9f4e6a2d23 100644
--- a/rust/helpers/blk.c
+++ b/rust/helpers/blk.c
@@ -7,10 +7,8 @@ void *rust_helper_blk_mq_rq_to_pdu(struct request *rq)
 {
 	return blk_mq_rq_to_pdu(rq);
 }
-EXPORT_SYMBOL_GPL(rust_helper_blk_mq_rq_to_pdu);
 
 struct request *rust_helper_blk_mq_rq_from_pdu(void *pdu)
 {
 	return blk_mq_rq_from_pdu(pdu);
 }
-EXPORT_SYMBOL_GPL(rust_helper_blk_mq_rq_from_pdu);
diff --git a/rust/helpers/bug.c b/rust/helpers/bug.c
index e2afbad23dcd..e2d13babc737 100644
--- a/rust/helpers/bug.c
+++ b/rust/helpers/bug.c
@@ -6,4 +6,3 @@ __noreturn void rust_helper_BUG(void)
 {
 	BUG();
 }
-EXPORT_SYMBOL_GPL(rust_helper_BUG);
diff --git a/rust/helpers/build_bug.c b/rust/helpers/build_bug.c
index f3106f248485..e994f7b5928c 100644
--- a/rust/helpers/build_bug.c
+++ b/rust/helpers/build_bug.c
@@ -7,4 +7,3 @@ const char *rust_helper_errname(int err)
 {
 	return errname(err);
 }
-EXPORT_SYMBOL_GPL(rust_helper_errname);
diff --git a/rust/helpers/err.c b/rust/helpers/err.c
index fba4e0be64f5..be3d45ef78a2 100644
--- a/rust/helpers/err.c
+++ b/rust/helpers/err.c
@@ -7,16 +7,13 @@ __force void *rust_helper_ERR_PTR(long err)
 {
 	return ERR_PTR(err);
 }
-EXPORT_SYMBOL_GPL(rust_helper_ERR_PTR);
 
 bool rust_helper_IS_ERR(__force const void *ptr)
 {
 	return IS_ERR(ptr);
 }
-EXPORT_SYMBOL_GPL(rust_helper_IS_ERR);
 
 long rust_helper_PTR_ERR(__force const void *ptr)
 {
 	return PTR_ERR(ptr);
 }
-EXPORT_SYMBOL_GPL(rust_helper_PTR_ERR);
diff --git a/rust/helpers/kunit.c b/rust/helpers/kunit.c
index 905e4ff4424a..9d725067eb3b 100644
--- a/rust/helpers/kunit.c
+++ b/rust/helpers/kunit.c
@@ -7,4 +7,3 @@ struct kunit *rust_helper_kunit_get_current_test(void)
 {
 	return kunit_get_current_test();
 }
-EXPORT_SYMBOL_GPL(rust_helper_kunit_get_current_test);
diff --git a/rust/helpers/mutex.c b/rust/helpers/mutex.c
index 29fd141c387d..200db7e6279f 100644
--- a/rust/helpers/mutex.c
+++ b/rust/helpers/mutex.c
@@ -7,4 +7,3 @@ void rust_helper_mutex_lock(struct mutex *lock)
 {
 	mutex_lock(lock);
 }
-EXPORT_SYMBOL_GPL(rust_helper_mutex_lock);
diff --git a/rust/helpers/page.c b/rust/helpers/page.c
index b3280c80b283..b3f2b8fbf87f 100644
--- a/rust/helpers/page.c
+++ b/rust/helpers/page.c
@@ -7,18 +7,13 @@ struct page *rust_helper_alloc_pages(gfp_t gfp_mask, unsigned int order)
 {
 	return alloc_pages(gfp_mask, order);
 }
-EXPORT_SYMBOL_GPL(rust_helper_alloc_pages);
 
 void *rust_helper_kmap_local_page(struct page *page)
 {
 	return kmap_local_page(page);
 }
-EXPORT_SYMBOL_GPL(rust_helper_kmap_local_page);
 
 void rust_helper_kunmap_local(const void *addr)
 {
 	kunmap_local(addr);
 }
-EXPORT_SYMBOL_GPL(rust_helper_kunmap_local);
-
-
diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
index 13ab64805f77..f47afc148ec3 100644
--- a/rust/helpers/refcount.c
+++ b/rust/helpers/refcount.c
@@ -7,16 +7,13 @@ refcount_t rust_helper_REFCOUNT_INIT(int n)
 {
 	return (refcount_t)REFCOUNT_INIT(n);
 }
-EXPORT_SYMBOL_GPL(rust_helper_REFCOUNT_INIT);
 
 void rust_helper_refcount_inc(refcount_t *r)
 {
 	refcount_inc(r);
 }
-EXPORT_SYMBOL_GPL(rust_helper_refcount_inc);
 
 bool rust_helper_refcount_dec_and_test(refcount_t *r)
 {
 	return refcount_dec_and_test(r);
 }
-EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
diff --git a/rust/helpers/signal.c b/rust/helpers/signal.c
index d44e8096b8a9..63c407f80c26 100644
--- a/rust/helpers/signal.c
+++ b/rust/helpers/signal.c
@@ -7,4 +7,3 @@ int rust_helper_signal_pending(struct task_struct *t)
 {
 	return signal_pending(t);
 }
-EXPORT_SYMBOL_GPL(rust_helper_signal_pending);
diff --git a/rust/helpers/slab.c b/rust/helpers/slab.c
index 3e0a1a173d8a..f043e087f9d6 100644
--- a/rust/helpers/slab.c
+++ b/rust/helpers/slab.c
@@ -7,4 +7,3 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
 {
 	return krealloc(objp, new_size, flags);
 }
-EXPORT_SYMBOL_GPL(rust_helper_krealloc);
diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
index 04fd8ddb4986..acc1376b833c 100644
--- a/rust/helpers/spinlock.c
+++ b/rust/helpers/spinlock.c
@@ -12,16 +12,13 @@ void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
 	spin_lock_init(lock);
 #endif
 }
-EXPORT_SYMBOL_GPL(rust_helper___spin_lock_init);
 
 void rust_helper_spin_lock(spinlock_t *lock)
 {
 	spin_lock(lock);
 }
-EXPORT_SYMBOL_GPL(rust_helper_spin_lock);
 
 void rust_helper_spin_unlock(spinlock_t *lock)
 {
 	spin_unlock(lock);
 }
-EXPORT_SYMBOL_GPL(rust_helper_spin_unlock);
diff --git a/rust/helpers/task.c b/rust/helpers/task.c
index b176c347f0d4..7ac789232d11 100644
--- a/rust/helpers/task.c
+++ b/rust/helpers/task.c
@@ -7,16 +7,13 @@ struct task_struct *rust_helper_get_current(void)
 {
 	return current;
 }
-EXPORT_SYMBOL_GPL(rust_helper_get_current);
 
 void rust_helper_get_task_struct(struct task_struct *t)
 {
 	get_task_struct(t);
 }
-EXPORT_SYMBOL_GPL(rust_helper_get_task_struct);
 
 void rust_helper_put_task_struct(struct task_struct *t)
 {
 	put_task_struct(t);
 }
-EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
diff --git a/rust/helpers/uaccess.c b/rust/helpers/uaccess.c
index 3d004ac1c180..f49076f813cd 100644
--- a/rust/helpers/uaccess.c
+++ b/rust/helpers/uaccess.c
@@ -7,11 +7,9 @@ unsigned long rust_helper_copy_from_user(void *to, const void __user *from,
 {
 	return copy_from_user(to, from, n);
 }
-EXPORT_SYMBOL_GPL(rust_helper_copy_from_user);
 
 unsigned long rust_helper_copy_to_user(void __user *to, const void *from,
 				       unsigned long n)
 {
 	return copy_to_user(to, from, n);
 }
-EXPORT_SYMBOL_GPL(rust_helper_copy_to_user);
diff --git a/rust/helpers/wait.c b/rust/helpers/wait.c
index bf361f40c7cb..c7336bbf2750 100644
--- a/rust/helpers/wait.c
+++ b/rust/helpers/wait.c
@@ -7,4 +7,3 @@ void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
 {
 	init_wait(wq_entry);
 }
-EXPORT_SYMBOL_GPL(rust_helper_init_wait);
diff --git a/rust/helpers/workqueue.c b/rust/helpers/workqueue.c
index 12e2ee66aa4f..f59427acc323 100644
--- a/rust/helpers/workqueue.c
+++ b/rust/helpers/workqueue.c
@@ -13,4 +13,3 @@ void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
 	INIT_LIST_HEAD(&work->entry);
 	work->func = func;
 }
-EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);

base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
prerequisite-patch-id: 97916a5ce500a204e6e5b4c5726691f080d6fbcc
-- 
2.44.1



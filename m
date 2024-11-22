Return-Path: <linux-kernel+bounces-417925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9099D5AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E202830F2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFFE18595E;
	Fri, 22 Nov 2024 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="bT8Hr7hF"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4618D175D44;
	Fri, 22 Nov 2024 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732263210; cv=fail; b=fUf+osCrSUcTYQASq0ViGIM9NX7lC4C2ENBGZO4m7zEKc8qCfZ0UGEyPLHaqaC7mlY5tMk+GGzHEcCnncOcNSw0J8u1Z83K/Q6gRS7ZYrymfwmUiVKxaSNLgxgkhZhxjDRPz/Yh7XIazvf/zBdpEUtjmRPs7VAseKjcPctSvJMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732263210; c=relaxed/simple;
	bh=MlVv9PsfuMRjUAAKgth18/bnwx7jidm3QiDZIMTcshA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DgskSGPdl5pMOePVrRaqI4hlb/3hSb9xT1aOmtofN2lDq1ek2pP/Y3VcLxpEe9tAvry6NAAx4lRP6TwGnVJTxcMP7/AxodWcNCwtcvlV3iUCOVnO3CI43oztQrydgPd0QVuM+4epE0VYohRl87Sd+NMp2ULQ5CBR+MJHtC7GAN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=bT8Hr7hF; arc=fail smtp.client-ip=40.107.21.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXDR2T//pre3ux81mh+a8GnmrxpgmZJmHguX1A7WGlIRPZQdTP2qYMI8fzlvsxyqJXAFeROw5HGuu7OFl6vGPychvTCRkjsvCuLkTJc/lMFgH4yofuBaeg/UKnAxsTGZ/dybrTkAuafWojy2WOeycNYsjMMANLLPqPtk6PaJv/mSJrouVI11QConbMQGFm/iE4w3ia0OXtBWg4t7RTP0zXYSzk1TNmy8EmSDj6mWwdUHhY0PWy3QLW+SnyxvdmicP2+Brgf8Hm3DUs4yrhx3YFl4ctbSVAT82OxSfMnG4M8Wx7iwO7YalGwrJ3ilue4ubBuppQEbK0ybp36xz6XAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EainHozCiKst0dkLrwErtXuEGvYmtG4EUYCMH9x9Y8=;
 b=Azu0HmM4UXgXlAzdtwoSriWQY32gCBoxIrSdHK1oABkBDofvELfDFuWZD9MQAOslsRDSwV5rbXUokjUocwVtjyd64s1OAjsZF1CUc1JGrcxsmRbjkYo44xzKJkqeDUIPx91tbq0c196FqIkQL9H6Oe5slTh8Vn1xotkqAV3Q73TjBPaZWO594Sb6wTECORDGCGtvAUWHqbZNH8sx+H2TWPjq2j8VtQuhhNS6qnwzxSANvKL8ZxGZ3MPA6/sWZ4DTgsAVc7SQjVBUSNZjBvS9CjYf8pS+tl6fA+F23czoHnGk+e2T30bMIJ9qYko5y4CgsWdsDKWAvhw04Qd0ZnPvKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=google.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EainHozCiKst0dkLrwErtXuEGvYmtG4EUYCMH9x9Y8=;
 b=bT8Hr7hFteJfNfd3JPdw4/pv3dyoxBBpWEeO+CbTj4mIRDuig3qKI3VuWA0pcbzlhnu+np8U9S7dlXHwf9toR/9zB6n0SqDZU6kLtBt62+aaboe/hW+3rcDZVf51lGvzWX53qc8s+LwSB+dFwPX9PuFcaOH6SCZOuLIuMX1VJOsIhu+BOTulznjBi9Gl4SI5N/qvS8zosPqDo7+UVaVedKiOsm1OYlQRkR/UWYXKfdZpmsZj2XLmttDTIlL7fmh4f7JvjyqihcsRudrh/Op0wJdLxTvJrDzKQSp9/BaC23/CAhjfqB6pjjeHmM79PuKk8P9hzBb3zipy4YkLbxeRgg==
Received: from AM9P250CA0003.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:21c::8)
 by GVXPR10MB8843.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.13; Fri, 22 Nov
 2024 08:13:20 +0000
Received: from AM4PEPF00025F96.EURPRD83.prod.outlook.com
 (2603:10a6:20b:21c:cafe::83) by AM9P250CA0003.outlook.office365.com
 (2603:10a6:20b:21c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.16 via Frontend Transport; Fri,
 22 Nov 2024 08:13:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AM4PEPF00025F96.mail.protection.outlook.com (10.167.16.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.0 via Frontend Transport; Fri, 22 Nov 2024 08:13:20 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Fri, 22 Nov
 2024 09:13:15 +0100
Received: from HI7-C-0001H.de.bosch.com (10.139.217.196) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.43; Fri, 22 Nov 2024 09:13:15 +0100
From: Dirk Behme <dirk.behme@de.bosch.com>
To: Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, Rob Herring <robh@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH RFC v2 1/1] rust: Add bindings for device properties
Date: Fri, 22 Nov 2024 09:12:57 +0100
Message-ID: <20241122081257.1776925-1-dirk.behme@de.bosch.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F96:EE_|GVXPR10MB8843:EE_
X-MS-Office365-Filtering-Correlation-Id: e30834e3-57a7-4b80-65be-08dd0acd86da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wilTtPcHqNqyb9E7tJHcHsEWQsgR6tj2g/h9X5Zmi6YkhHuLj5eHKxmyIDul?=
 =?us-ascii?Q?7Q2x5u0aYVID+t4Os7UXEu233eILnuxGlI/6M+rya/W1M0Utqg3kq81LDTD7?=
 =?us-ascii?Q?nLzhLgu9Z+9jDaYu9n8J7LuaADdSJau10YpeS7B3QOA2LVTra/gQZpwXtEud?=
 =?us-ascii?Q?jMHUTAi9P8HWq9NPbqQ4nHpmADtsagGDuONA6vhBHKLlCKFdekfpg7SuCHCA?=
 =?us-ascii?Q?CN4IGfqvwo7XMtvljL6sCi2MulBPSbCbMyhDes8mS4TfhIliUyrEDlOGB5yB?=
 =?us-ascii?Q?9rXDYc3vKuT5otinXn5oWoiIYdH15dGhjazP9E6dKUMqiypETni1Uy21zpPC?=
 =?us-ascii?Q?7AXIPJ3b3VPAaQxN5Wxe9zwRD/PB300nBvX0cjXgoKVRqePLkOM9Hkwx+srB?=
 =?us-ascii?Q?cKefZTXyizqErfBUFlY6eoUcNlSTgqld2UMJqQWZBAm9HxpMRexdsmm32451?=
 =?us-ascii?Q?b/IHNCE4weOILTebXEKAp5LGTDigtwC7Y8PjW4M0z+rRi1IvRZsTyUEsXxFn?=
 =?us-ascii?Q?RyOKofT0USIDeohbYJHZP0IIDZ7g/gzeRWRRKG8S6zAor9m12jFuJDXGHqSp?=
 =?us-ascii?Q?ja3bl+s2cjPrurxaGOPsT182/NOJat1WuXqnKTMYeJmEOKXG6iZZHyu2f814?=
 =?us-ascii?Q?zMGprGmUNkA/c9A/t7+gO/4PD6+IvsLasIDVWWpcANG1ZqOpRRNyQ7CavY4v?=
 =?us-ascii?Q?vXjlqn6v1Khh3xGCsi6x/xuCJndptai2Z/hZgqM0iWJKZ41aLWcbo0hLBTsq?=
 =?us-ascii?Q?SgiBr0ZhxAcGGRVi9+u/tYUJN3rtwM9WleqShK1HCCORPYs8QXrlk4e4RK5C?=
 =?us-ascii?Q?cJBBJGUsLlU59S8ow8bX+Jw+2D3HwWnzzMPmvkF1RKjMpznyJsQJXFJ6osj9?=
 =?us-ascii?Q?xM9cgcPmt2vygcGlsN8P4y2EZff2GHJWG9q0JarN4yEi1seQZheNInuA6tjz?=
 =?us-ascii?Q?PM7TaHpWiMEdvPqWxFdt+5nvBynSyuxKZrS5LtOUaH3oRHM6COC8C4sHvc6t?=
 =?us-ascii?Q?6KBtbM0lMdNSQ4+U5k4fIEJ7+s8AsHW6iumGkhxJefCz/SWhKFWTZCf4MqR9?=
 =?us-ascii?Q?VxgUOuKnV86S0nnkwK5IW3ywizyTgDnhh3O8UNStP0URiNCfforzPrcLD5qN?=
 =?us-ascii?Q?kAa+SFlLdenaY4KP+xnI64KAFbKr05+xO/w5w3B+ipiV4QjekIe7O+zTEk4N?=
 =?us-ascii?Q?KKoLxOPE9zxKiVxFqT4YzzihtEsEc17MRO8FqIwCzbDJp1N3c89ZDZLsjTOB?=
 =?us-ascii?Q?X5drJGkTc7eYl1BbqP55A/Yb0DGFsxWrh7gojJ4oVxiDmRQ1T2eJw/NdNRxy?=
 =?us-ascii?Q?Gf5KvdqJ59Rnvo30tfvNNnxT5GuGQ7VbEYU5N+9KtI8qe34412z8UvmhBh2f?=
 =?us-ascii?Q?S35an77WS+WzcCrswUwlwZWpwqIW?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 08:13:20.2730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e30834e3-57a7-4b80-65be-08dd0acd86da
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8843

From: "Rob Herring (Arm)" <robh@kernel.org>

The device property API is a firmware agnostic API for reading
properties from firmware (DT/ACPI) devices nodes and swnodes.

While the C API takes a pointer to a caller allocated variable/buffer,
the rust API is designed to return a value and can be used in struct
initialization. Rust generics are also utilized to support different
sizes of properties (e.g. u8, u16, u32).

To build and run the Examples as `rustdoc` tests the kernel Kconfig
options `CONFIG_OF` and `CONFIG_OF_UNITTEST` need to be enabled
additionally. Besides the default `rustdoc` test options
`CONFIG_KUNIT` and `CONFIG_RUST_KERNEL_DOCTESTS`. This even works
on non-ARM architectures as a test device tree is built into the
kernel, then.

The Integer trait is proposed by Alic Ryhl [1].

Link: https://lore.kernel.org/rust-for-linux/CAH5fLgiXPZqKpWSSNdx-Ww-E9h2tOLcF3_8Y4C_JQ0eU8EMwFw@mail.gmail.com/ [1]
Co-developed-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---

This is an update of Rob's initial patch

https://lore.kernel.org/rust-for-linux/20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org/

condensed in one patch (see below). Rob's initial cover
letter still stands, esp. the part regarding the dependency
on Danilo's PCI and platform device series [2].

Changes in v2:

* Move the major parts to property.rs
* Use the Integer Trait proposed by Alice
* Use MaybeUninit proposed by Alex
* Use Option<> to distinguish between optional and mandatory properties
  proposed by Rob
* Introduce a FwProperty trait. The prefix 'Fw' reads as 'Firmware'.
  Just 'Property' seems to be conflicting with existing.
* Add some rustdoc documentation and Examples (based on Danilo's
  platform sample module). With that I squashed the test device tree
  changes into this patch as we don't need to change Danilo's platform
  sample any more. That change is trivial. Please let me know if you
  rather like a separate patch for it.
* Some more I most probably missed to mention ;)

It would be nice to get some improvement hints for the FIXMEs :)
Trying to use the assert_eq!() fails with

error[E0425]: cannot find value `__DOCTEST_ANCHOR` in this scope
    --> rust/doctests_kernel_generated.rs:4252:102
     |
4252 |             kernel::kunit_assert_eq!("rust_doctest_kernel_property_rs_0", "rust/kernel/property.rs", __DOCTEST_ANCHOR - 150, $left, $right);
     |                                                                                                      ^^^^^^^^^^^^^^^^ not found in this scope
...
4369 | assert_eq!(idx, Ok(0)); // FIXME: How to build this?
     | ---------------------- in this macro invocation
     |
     = note: this error originates in the macro `assert_eq` (in Nightly builds, run with -Z macro-backtrace for more info)

  CC      drivers/base/firmware_loader/main.o
  CC      kernel/module/main.o
error: aborting due to 1 previous error

[2] https://lore.kernel.org/all/20241022213221.2383-1-dakr@kernel.org/

 drivers/of/unittest-data/tests-platform.dtsi |   8 +
 rust/bindings/bindings_helper.h              |   1 +
 rust/kernel/device.rs                        |  22 ++
 rust/kernel/lib.rs                           |   1 +
 rust/kernel/property.rs                      | 370 +++++++++++++++++++
 5 files changed, 402 insertions(+)
 create mode 100644 rust/kernel/property.rs

diff --git a/drivers/of/unittest-data/tests-platform.dtsi b/drivers/of/unittest-data/tests-platform.dtsi
index fa39611071b32..a5369b9343b8a 100644
--- a/drivers/of/unittest-data/tests-platform.dtsi
+++ b/drivers/of/unittest-data/tests-platform.dtsi
@@ -33,6 +33,14 @@ dev@100 {
 					reg = <0x100>;
 				};
 			};
+
+			test-device@2 {
+				compatible = "test,rust-device";
+				reg = <0x2>;
+
+				test,u32-prop = <0xdeadbeef>;
+				test,i16-array = /bits/ 16 <1 2 (-3) (-4)>;
+			};
 		};
 	};
 };
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 217c776615b95..65717cc20a23c 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -19,6 +19,7 @@
 #include <linux/pci.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 0c28b1e6b004c..2dea5ac2a6a73 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -6,6 +6,9 @@
 
 use crate::{
     bindings,
+    error::Result,
+    property::FwProperty,
+    str::CStr,
     types::{ARef, Opaque},
 };
 use core::{fmt, ptr};
@@ -189,6 +192,25 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
             )
         };
     }
+
+    /// Returns the firmware property `name` value.
+    pub fn property_read<T: FwProperty>(&self, name: &CStr, default: Option<T>) -> Result<T> {
+        T::read_property(self, name, default)
+    }
+
+    /// Returns the array length for the firmware property `name`.
+    pub fn property_count_elem<T: FwProperty>(&self, name: &CStr) -> Result<usize> {
+        T::count_elem(self, name)
+    }
+
+    /// Returns the index if `match_str` is found in the firmware property array `name`.
+    pub fn property_match_string<T: FwProperty>(
+        &self,
+        name: &CStr,
+        match_str: &CStr,
+    ) -> Result<usize> {
+        T::match_string(self, name, match_str)
+    }
 }
 
 // SAFETY: Instances of `Device` are always reference-counted.
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 9e8dcd6d7c014..474f2eadd6616 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -56,6 +56,7 @@
 pub mod platform;
 pub mod prelude;
 pub mod print;
+pub mod property;
 pub mod rbtree;
 pub mod revocable;
 pub mod sizes;
diff --git a/rust/kernel/property.rs b/rust/kernel/property.rs
new file mode 100644
index 0000000000000..776d23e4d5985
--- /dev/null
+++ b/rust/kernel/property.rs
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Accessing (DeviceTree/ACPI) firmware properties.
+//!
+//! C header: [`include/linux/property.h`](srctree/include/linux/property.h)
+
+use crate::{
+    bindings,
+    device::Device,
+    error::{to_result, Result},
+    prelude::*,
+    str::CStr,
+    transmute::{AsBytes, FromBytes},
+};
+
+use core::mem;
+use core::mem::MaybeUninit;
+
+/// A trait for integer types.
+///
+/// This trait limits [`FromBytes`] and [`AsBytes`] to integer types only. Excluding the
+/// array types. The integer types are `u8`, `u16`, `u32`, `u64`, `usize`, `i8`, `i16`,
+/// `i32`, `i64` and `isize`. Additionally, the size of these types is encoded in the
+/// `IntSize` enum.
+trait Integer: FromBytes + AsBytes + Copy {
+    /// The size of the integer type.
+    const SIZE: IntSize;
+}
+
+/// The sizes of the integer types. Either 8, 16, 32 or 64 bits.
+enum IntSize {
+    /// 8 bits
+    S8,
+    /// 16 bits
+    S16,
+    /// 32 bits
+    S32,
+    /// 64 bits
+    S64,
+}
+
+macro_rules! impl_int {
+    ($($typ:ty),* $(,)?) => {$(
+        impl Integer for $typ {
+            const SIZE: IntSize = match size_of::<Self>() {
+                1 => IntSize::S8,
+                2 => IntSize::S16,
+                4 => IntSize::S32,
+                8 => IntSize::S64,
+                _ => panic!("invalid size"),
+            };
+        }
+    )*};
+}
+
+impl_int! {
+    u8, u16, u32, u64, usize,
+    i8, i16, i32, i64, isize,
+}
+
+/// Reads an array of integers from the device firmware.
+fn read_array<T: Integer>(
+    device: &Device,
+    name: &CStr,
+    val: Option<&mut [MaybeUninit<T>]>,
+) -> Result<usize> {
+    let (ptr, len) = match val {
+        // The read array data case.
+        Some(val) => (val.as_mut_ptr(), val.len()),
+        // The read count case.
+        None => (core::ptr::null_mut(), 0_usize),
+    };
+    let ret = match T::SIZE {
+        // SAFETY: `device_property_read_u8_array` is called with a valid device pointer and name.
+        IntSize::S8 => unsafe {
+            bindings::device_property_read_u8_array(
+                device.as_raw(),
+                name.as_ptr() as *const i8,
+                ptr as *mut u8,
+                len,
+            )
+        },
+        // SAFETY: `device_property_read_u16_array` is called with a valid device pointer and name.
+        IntSize::S16 => unsafe {
+            bindings::device_property_read_u16_array(
+                device.as_raw(),
+                name.as_ptr() as *const i8,
+                ptr as *mut u16,
+                len,
+            )
+        },
+        // SAFETY: `device_property_read_u32_array` is called with a valid device pointer and name.
+        IntSize::S32 => unsafe {
+            bindings::device_property_read_u32_array(
+                device.as_raw(),
+                name.as_ptr() as *const i8,
+                ptr as *mut u32,
+                len,
+            )
+        },
+        // SAFETY: `device_property_read_u64_array` is called with a valid device pointer and name.
+        IntSize::S64 => unsafe {
+            bindings::device_property_read_u64_array(
+                device.as_raw(),
+                name.as_ptr() as *const i8,
+                ptr as *mut u64,
+                len,
+            )
+        },
+    };
+    to_result(ret)?;
+    Ok(ret.try_into()?)
+}
+
+/// A trait for reading (DeviceTree/ACPI) firmware properties.
+///
+/// This trait serves as an interface to the device property API
+/// which is a firmware agnostic API for reading properties from
+/// firmware (DeviceTree/ACPI) device nodes and swnodes.
+///
+/// While the C API takes a pointer to a caller allocated variable/buffer,
+/// this trait is designed to return a value and can be used in struct
+/// initialization.
+///
+/// There are mandatory and optional properties. If a property is mandatory
+/// it has to be there. If it is not found an error is printed and returned.
+/// If a property is optional and found the value is returned. If it is not
+/// found the default value is returned. If the default value is not provided,
+/// an error is printed and returned.
+///
+/// This logic is controlled via the `default` parameter of type `Option<>`.
+/// If `default` is `None` the property is assumed to be mandatory. If `default`
+/// is `Some(<default_val>)` the property is assumed to be optional and the
+/// `default_val` is returned in case the optional property is not found.
+///
+/// However, this doesn't apply to boolean properties. For boolean properties
+/// the property exists or not. If it exists, it returns true, otherwise false.
+/// So `Some(<default_val>)` does not make sense in this case and should be `None`.
+/// An error is printed and returned if this not the case.
+///
+/// As errors are printed in above cases users of this trait are supposed
+/// to *not* do any additional error printing. Of course, appropriate error handling
+/// (without printing) needs to be implemented.
+///
+/// *Note*: To build and run below examples as `rustdoc` tests the additional kernel
+/// Kconfig options `CONFIG_OF` and `CONFIG_OF_UNITTEST` need to be enabled. This
+/// even works on non-ARM architectures as a test device tree is built into the
+/// kernel, then.
+///
+/// # Examples
+///
+/// ```
+/// # mod property_example {
+/// #
+/// # use kernel::{c_str, of, platform, prelude::*};
+/// #
+/// # struct PropertyExample {
+/// #     pdev: platform::Device,
+/// # }
+/// #
+/// # kernel::of_device_table!(
+/// #     OF_TABLE,
+/// #     MODULE_OF_TABLE,
+/// #     <PropertyExample as platform::Driver>::IdInfo,
+/// #     [(of::DeviceId::new(c_str!("test,rust-device")), ())]
+/// # );
+/// #
+/// # impl platform::Driver for PropertyExample {
+/// # type IdInfo = ();
+/// # const ID_TABLE: platform::IdTable<Self::IdInfo> = &OF_TABLE;
+/// #
+/// # fn probe(
+/// #   pdev: &mut platform::Device,
+/// #   info: Option<&Self::IdInfo>
+/// # ) -> Result<Pin<KBox<Self>>> {
+/// # let dev = pdev.as_ref();
+/// #
+/// # dev_err!(dev, "The following two error messages are intended and correct from the tests:\n");
+/// #
+/// // Read an existing property as bool. This has two use cases:
+/// // a) Get the value of a boolean property (true == exist, false == don't exist).
+/// // b) Check if a property exists. Not limited to boolean properties.
+/// let prop = dev.property_read::<bool>(c_str!("test,u32-prop"), None);
+/// # //assert_eq!(prop, Ok(true)); // FIXME: How to build this?
+/// # dev_info!(dev, "prop: {:?}\n", prop); // Debug only, drop later
+/// if prop != Ok(true) {return Err(EINVAL);}
+///
+/// // Reading a non-existing property as bool should return false.
+/// let prop = dev.property_read::<bool>(c_str!("test,bool-prop"), None);
+/// # //assert_eq!(prop, Ok(false)); // FIXME: How to build this?
+/// # dev_info!(dev, "prop: {:?}\n", prop); // Debug only, drop later
+/// if prop != Ok(false) {return Err(EINVAL);}
+///
+/// // Invalid, returns with error. Don't use `Some(<bool>)` here (correct would be `None`).
+/// // Should print an error.
+/// let prop = dev.property_read::<bool>(c_str!("test,bool-prop"), Some(true));
+/// # //assert_eq!(prop, Err(EINVAL)); // FIXME: How to build this?
+/// # dev_info!(dev, "prop: {:?}\n", prop); // Debug only, drop later
+/// if prop != Err(EINVAL) {return Err(EINVAL);}
+///
+/// // 'property_read::<integer>' or 'property_read::<array>' can read either optional or
+/// // mandatory properties. If the property is mandatory and not found, it will print an
+/// // error message and return with error. If the property is optional and not found, it
+/// // will return with the given default value.
+/// //
+/// // Assume 'test,u32-optional' is an optional property which does not exist.
+/// let prop: u32 = dev.property_read(c_str!("test,u32-optional"), Some(0xdb))?;
+/// # //assert_eq!(prop, 0xdb); // FIXME: How to build this?
+/// # dev_info!(dev, "prop: {:#x}\n", prop); // Debug only, drop later
+/// if prop != 0xdb {return Err(EINVAL);}
+///
+/// // Assume 'test,u32-mandatory' is a mandatory property which does not exist.
+/// // Should print an error.
+/// let prop = dev.property_read::<u32>(c_str!("test,u32-mandatory"), None);
+/// # //assert_eq!(prop, Err(EINVAL)); // FIXME: How to build this?
+/// # dev_info!(dev, "prop: {:?}\n", prop); // Debug only, drop later
+/// if prop != Err(EINVAL) {return Err(EINVAL);}
+///
+/// // Some examples for mandatory property which does exist.
+/// // First in Turbofish syntax.
+/// let prop = dev.property_read::<u32>(c_str!("test,u32-prop"), None)?;
+/// # //assert_eq!(prop, Err(EINVAL)); // FIXME: How to build this?
+/// # dev_info!(dev, "prop: {:#x}\n", prop); // Debug only, drop later
+/// if prop != 0xdeadbeef {return Err(EINVAL);}
+///
+/// // Second with type annotation.
+/// let prop: u32 = dev.property_read(c_str!("test,u32-prop"), None)?;
+/// # //assert_eq!(prop, Err(EINVAL)); // FIXME: How to build this?
+/// # dev_info!(dev, "prop: {:#x}\n", prop); // Debug only, drop later
+/// if prop != 0xdeadbeef {return Err(EINVAL);}
+///
+/// // Reading a mandatory array of integers.
+/// let prop: [i16; 4] = dev.property_read(c_str!("test,i16-array"), None)?;
+/// # //assert_eq!(prop, [1, 2, -3, -4]); // FIXME: How to build this?
+/// # dev_info!(dev, "prop: {:?}\n", prop); // Debug only, drop later
+/// if prop != [1, 2, -3, -4] {return Err(EINVAL);}
+///
+/// // Getting the length of the 16 bits array.
+/// let length = dev.property_count_elem::<i16>(c_str!("test,i16-array"))?;
+/// # //assert_eq!(length, 4); // FIXME: How to build this?
+/// # dev_info!(dev, "length: {}\n", length); // Debug only, drop later
+/// if length != 4 {return Err(EINVAL);}
+///
+/// // Match a string.
+/// let idx = dev.property_match_string::<usize>(c_str!("compatible"), c_str!("test,rust-device"));
+/// # //assert_eq!(idx, Ok(0)); // FIXME: How to build this?
+/// # dev_info!(dev, "idx: {:?}\n", idx); // Debug only, drop later
+/// if idx != Ok(0) {return Err(EINVAL);}
+/// #
+/// # let drvdata = KBox::new(Self { pdev: pdev.clone() }, GFP_KERNEL)?;
+/// #
+/// # Ok(drvdata.into())
+/// # }
+/// # }
+/// #
+/// # kernel::module_platform_driver! {
+/// #     type: PropertyExample,
+/// #     name: "rust_property_example",
+/// #     author: "Rob Herring and Dirk Behme",
+/// #     description: "Rust Property Example driver",
+/// #     license: "GPL v2",
+/// # }
+/// # }
+/// ```
+/// The above examples intentionally don't print any error messages (e.g. with `dev_err!()`).
+/// The called abstractions already print error messages if needed what is considered to be
+/// sufficient. The goal is to be less verbose regarding error messages.
+pub trait FwProperty: Sized {
+    /// Reads a property from the device.
+    fn read_property(device: &Device, name: &CStr, default: Option<Self>) -> Result<Self>;
+
+    /// Gets the properties element count.
+    fn count_elem(device: &Device, name: &CStr) -> Result<usize>;
+
+    /// Returns if a firmware string property `name` has match for `match_str`.
+    fn match_string(device: &Device, name: &CStr, match_str: &CStr) -> Result<usize> {
+        // SAFETY: `device_property_match_string` is called with a valid device pointer and name.
+        let ret = unsafe {
+            bindings::device_property_match_string(
+                device.as_raw(),
+                name.as_ptr() as *const i8,
+                match_str.as_ptr() as *const i8,
+            )
+        };
+        to_result(ret)?;
+        Ok(ret as usize)
+    }
+}
+
+impl FwProperty for bool {
+    fn read_property(device: &Device, name: &CStr, default: Option<Self>) -> Result<Self> {
+        if default.is_some() {
+            dev_err!(
+                device,
+                "Error: Default value should be 'None' for reading boolean property"
+            );
+            return Err(EINVAL);
+        }
+        // SAFETY: `device_property_present` is called with a valid device pointer and name.
+        Ok(unsafe {
+            bindings::device_property_present(device.as_raw(), name.as_ptr() as *const i8)
+        })
+    }
+
+    /// Gets the properties element count.
+    // FIXME: Could this be made to be a build time error?
+    fn count_elem(device: &Device, _name: &CStr) -> Result<usize> {
+        dev_err!(
+            device,
+            "Error: Boolean type does not implement element count"
+        );
+        Err(EINVAL)
+    }
+}
+
+impl<T: Integer + Copy> FwProperty for T {
+    fn read_property(device: &Device, name: &CStr, default: Option<Self>) -> Result<Self> {
+        let mut val: [MaybeUninit<T>; 1] = [const { MaybeUninit::uninit() }; 1];
+        match read_array(device, name, Some(&mut val)) {
+            // SAFETY: `read_array` returns with valid data
+            Ok(_) => Ok(unsafe { mem::transmute_copy(&val[0]) }),
+            Err(e) => match default {
+                Some(default) => Ok(default),
+                None => {
+                    dev_err!(
+                        device,
+                        "Error: Mandatory property '{}' does not exist ({:?})",
+                        name,
+                        e
+                    );
+                    Err(e)
+                }
+            },
+        }
+    }
+
+    /// Gets the properties element count.
+    fn count_elem(device: &Device, name: &CStr) -> Result<usize> {
+        read_array::<T>(device, name, None)
+    }
+}
+
+impl<T: Integer, const N: usize> FwProperty for [T; N] {
+    fn read_property(device: &Device, name: &CStr, default: Option<Self>) -> Result<Self> {
+        let mut val: [MaybeUninit<T>; N] = [const { MaybeUninit::uninit() }; N];
+        match read_array(device, name, Some(&mut val)) {
+            // SAFETY: `read_array` returns with valid data
+            Ok(_) => Ok(unsafe { mem::transmute_copy(&val) }),
+            Err(e) => match default {
+                Some(default) => Ok(default),
+                None => {
+                    dev_err!(
+                        device,
+                        "Error: Mandatory property '{}' does not exist {:?}",
+                        name,
+                        e
+                    );
+                    Err(e)
+                }
+            },
+        }
+    }
+
+    /// Gets the properties element count.
+    // FIXME: Could this be made to be a build time error?
+    fn count_elem(device: &Device, _name: &CStr) -> Result<usize> {
+        dev_err!(device, "Error: Array type does not implement element count");
+        Err(EINVAL)
+    }
+}
-- 
2.46.2



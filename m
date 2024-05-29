Return-Path: <linux-kernel+bounces-194661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBC88D3F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94F1289051
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7721C9EA1;
	Wed, 29 May 2024 20:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="fnSOY5Pn"
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11021010.outbound.protection.outlook.com [52.101.196.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539041C68A6;
	Wed, 29 May 2024 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717014568; cv=fail; b=I59GhCLEYihqOUDrvEVGK0WQYXUbJ4kryXG110TzQLyjsiFjo+nBvM7ZeXPl4shoZPW55koA31LhY/KDHyr1bKgaVrmAapP4UpeOXj6WUiOJ5Mw8+sEhKP1Gftu5bIgmowFUgrG9hZV1ov9QnH5iQ/tIWA/VfTTRdR/bgQ4byr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717014568; c=relaxed/simple;
	bh=OX3liQOo5u7P8XiyoGFfXHsverfGlQS2IjzewwZznR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ijV88nWiV4TNT8ug51/gKk7A5snahsd/Xr2pll3FL+c1tfzV8pqvIDjvFeYuwrcFv4S4DimNeEUvik/IbxmxTu96wiNbN2cZbP3ybPlOcCGH/mA3g0//JfMYP8IdoPPnL/bL6mvZPK5ZYgWaQSQT0M8umQFvdhH/Sz4kXA5xS0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=fnSOY5Pn; arc=fail smtp.client-ip=52.101.196.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eELwWgeTBYqbMbDwCx80Rq92WVL/tfLIQ9+dGJYOdcMPhg6XfWoGrqHWlWUGkhVfzSYpDDRBR3dcLEVgqHJyDDSyNBHIfjtlFTdfcEyHiKfOQ/VB3YP4FdWzwE0Wt3cr5IuvelNII3caB1Qmz4VY8vypIF9cTIl5gADmS4+Bv8yixNKS0D88k8AcWaSKQfjRbGWb+sSgAoj5RBcjFSsfigca3Cupo8lOkn3GtcJ77xl6vQdg8ELS5X2pOmzG6b06sR60eXI2iJGEcI68OGd33Cr6fjF69ZVYdE8K3YzFbRS/zV5pbZAr5vdQBrUlBAIT/j4KxuJfrbAqx2a+fCHAOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nhv8XV15nEEuhMemScpNrfwRZeyQrY4Dj0Gl4B9wr3Y=;
 b=i90EW5EFjsego5xM50ydFoaN5wcSvsuy+mABwqH8XVH9CTZFzKQpVA2Vz60EjlXsZ2eSD3+W0F4bgX8voZfZq5IqLstZIHt3cmNktZayTUm8MeMJyWEAwYASHwItQevK1bxY4I7wkqaedhLwYWK50j7MZgGXni0UwqpBiSg8VfubnU+8RZubshuiSfS5PNQMX/G36ynYgwQ+OK8HME59o+V23fvF1t0XVMhn2uUMdF/eRav0mn59dlWlZUlSKbb0nKzc9llSdpiNUYWsdxLr6ps9aOs4xm6nQ9A8irrb/cqG4WBW+Qcw9IrCGYh5JdK2HUCoaRHwj2ZOhjXylsShwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nhv8XV15nEEuhMemScpNrfwRZeyQrY4Dj0Gl4B9wr3Y=;
 b=fnSOY5PnbI5ew9kttGa3zydpEWQK43A8HYHIMzFfr2d3ir2sbFeiBkDgXOq24iJDEuLulcB8Rq8x7cHoVV3iTSzpfiCajnwGGrZ1TWsaaUrL+pSfOzRDbcdUWeXb9Ws3yFKJY/891KBr5t6spJb8I+KKeUQI5LEi+USake2+cSw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO9P265MB7874.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 20:29:24 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.7611.016; Wed, 29 May 2024
 20:29:24 +0000
From: Gary Guo <gary@garyguo.net>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] kbuild: rust: auto generate rust helper exports
Date: Wed, 29 May 2024 21:28:14 +0100
Message-ID: <20240529202817.3641974-2-gary@garyguo.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240529202817.3641974-1-gary@garyguo.net>
References: <20240529202817.3641974-1-gary@garyguo.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0222.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::11) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO9P265MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 63e00d28-16dc-4dc4-9267-08dc801e073e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8xWYUsQRSpN2fizbbwi9zV/8tWKB1HMu0CVam7V6JDVk7Fmzu32/u1HPx7Ke?=
 =?us-ascii?Q?0uuawibFCpsozhnfkPc/n/NVqZ2aSnhyeJyjD1vB1WofjboFWmfezYRPi+jk?=
 =?us-ascii?Q?FnG1orhcwECdKbxLFisEqAbbvJgkh/goHnMkTf8AKmAQHyfOH2IEGxd1Fgqv?=
 =?us-ascii?Q?KG6TKb8ikauC+Du3ynoe9ztyhPhT2hFuLjcV1zuqCTuFjjo9UZfciFKgM0ea?=
 =?us-ascii?Q?/HL/J657P4xjIK/RItTuZ9uI4IqMEeDi/xhXyopdwnU7ieWdJTpoEymTn6Ss?=
 =?us-ascii?Q?t/jcdgk6+Txb1o1a0CaJCjNAPkjm2CXoucPa8MwmKSgUqRkPh1prJk4XbRBI?=
 =?us-ascii?Q?HJeL2HymfWgjONzsKRHpxrmv0pQx7HXOgKCTpWL0JoA2cDgCObmBhDSxxVXN?=
 =?us-ascii?Q?0+2VINdweF4mamH+YBVTUZtdlGX96PzttMteI6ECMBmsh8JMhAiNGUQEAgqZ?=
 =?us-ascii?Q?5/C5pgG4b+M66nAxEQ6n51gVjPlubsN7XmnESqf4qSra/UpDDBLTPqTwfqP8?=
 =?us-ascii?Q?Jh2/iP7H4vcSWxAu/AFhVWqTwqQ8Cn+Vu1vouls0wFiCK1XdShL15lce5qkR?=
 =?us-ascii?Q?AP3rQbDWdF+JMyX1QewPbbdVaPnyy49nwXD5WXVOHoufXf7v2Dbk3u1/uzES?=
 =?us-ascii?Q?ZI1iLxDRQ8ze4dSN+b7DfuIQIztHST7ATIRnQY+YRGFozVWOn+Jdol6UQkmJ?=
 =?us-ascii?Q?1hil1y6gAcM2tnw8y/hY5v4MIoC76yoWVxg3YcWpFIZNNJa2monnhOXdvIkh?=
 =?us-ascii?Q?sjcWt86G0moPu1aIrCzpu4Z/KfcgnIrY7lgk/q4u14FYffK3tKMygnDuNKYp?=
 =?us-ascii?Q?64LUKVbtr9yeEtOZ0NIkR/gdFvHAscBtcG935D+1QCS5g9p2m6efbM5qGbsS?=
 =?us-ascii?Q?IYwNPligK41rbyXwKDtJ4DE4Jp0NOPpQaTA0Dd+V3rTywOXHrkjixAXuFjfp?=
 =?us-ascii?Q?A89egoFMIS5jkufxRg4aSucLobyfrhW1u6rd4TC+gZW7pGSDS+dpuAM5vaXv?=
 =?us-ascii?Q?DJwK9AfO+dQ0+lQPUw31u6jLMwxtHv8NgrnYXXiqdGbCRPghvdNLzDtTsZwx?=
 =?us-ascii?Q?W3JjkqqZ3P1Tlggyyjkbzt9KADeQxPl1D5II1OTop8L8rKKF0zBsHYrgaUtG?=
 =?us-ascii?Q?jyTS2CJwegcszkxQVDx2zCE+n9jwX5dCLJkvm56ayKvlmCI3gv6tdkvrjgkm?=
 =?us-ascii?Q?6GaD+PzRghy47JCLVUhAHFp5DJcvRHvZMtj9mrvBvdgQIT4F1Ykjd4JfCJKA?=
 =?us-ascii?Q?RjodK9srVJ01rKYcq4BJZZNz4s92i+W3Vx9Xcm72lA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Hz9bzkeDNTL1PrvQYlCwjBsHVB7MOtzH8uLMq6kfzOPiHqkafkl9WmH37Yb?=
 =?us-ascii?Q?AXz8RtpjJKeMPkUgSBI9QRTrVquGNAxNDbs0TCffRl1FgQWSQNA73v+N9KcK?=
 =?us-ascii?Q?Xz0GszBIx/tnKTxS3eYzNYTPO2MV8Kk+sjeLplapdqMzh1BH5P3A7EkpHhIp?=
 =?us-ascii?Q?u1OQ45T00mjBzaqJc1yCGj05WlEc3vUamfVnvcWbF7DqZPW1plXaULmrviBu?=
 =?us-ascii?Q?J+TheZ6gyv7jwYF/DJ5VsE2QEdtUk3AEdVG1iBnNiDU3HvTi4kKogz6DNfio?=
 =?us-ascii?Q?qNJqcVdL/P5Y9dJB+ODx0IIXzlJWT/PRp0l87HZZPDsWfyADQZhIV4+5rHO+?=
 =?us-ascii?Q?+JPb5ra95kwznSwtF6V/dAFpHiUT2Yx9cgih/q07iXEPbJ/CWwSJdN+2tC56?=
 =?us-ascii?Q?/WT+gS7zgiDvX5cH7eBvhe/6GWuhHtRyP1rO99oo7+6VkczPdKqa4L6bIWik?=
 =?us-ascii?Q?q0Ov4/OC+ParDmFgNzyaz9jCDtzbYd+wILk0QBb+tJhNW5XSu6R00H++KdCz?=
 =?us-ascii?Q?27EqGZRjLC58r6jVywbDEEbjxYZibAiWYJvcWml7lQr5zBvpHhgb2frobJDC?=
 =?us-ascii?Q?J8/QA9AqNgvJSGfniplpaX66Vh1qy/SjtG+UiSTU9uCbGa7hBQcfm1PgFNw7?=
 =?us-ascii?Q?Gavt54lqrwzkzV0iUA4uL2kqWMAgetbQtT2f/k3/8VrFtodInGDaCVsiFYdr?=
 =?us-ascii?Q?3FAHTpYo2csSQN4XaRj4c6z6XPL1VH717sPFqJaDSUC2t391/jTRwh9xO7OJ?=
 =?us-ascii?Q?Bc/8NY0HzpZbmy96/hA9Rz09p/1AqKGIeIVdl7VMp4M36UGKXds7CwuLX1gb?=
 =?us-ascii?Q?nHGckj0Cfzx1jrdNMhbmLgd/YQebecsUnI3hOn4qezt6j+TJ6R0rOdSaTEdQ?=
 =?us-ascii?Q?tYqZ1UVrM7DtyAZIZUZwImPAmGj2a1xQAHh9gCU3DZoJVAVpT+YeKP+e+GOc?=
 =?us-ascii?Q?N5X8uAyvVRe+DmZ8M5ZqflAr2Zde1WnCnqyokgNjRYeRyoEpQ9O7NOrZ4Asz?=
 =?us-ascii?Q?kfCCTIPF7C68h993P3wGHXZowiGPtFUV3ujtdkXrpu8TXYc0dmqAtZOZNHcE?=
 =?us-ascii?Q?nA5j2MTg+ZypRD/3bhfonXQEhVsgahlPcrhvtvu9CxnaHIbmtoHnRw0DwCUw?=
 =?us-ascii?Q?oEl5BpGqYx5RvcnP8WZgiBGWNdeQkZZLi8DhJoaXciz/7KUvkrUZeuIGfq8f?=
 =?us-ascii?Q?u1nWo/4YLkLPnDeIvauMdCRIv09Uv1gvJjLQ5CqnVCYLI/Y+eoqJLXn7/bPA?=
 =?us-ascii?Q?l6pj+OQcahNaOq6Vt+dfz6iBzsQM31Qur9MzBzqK7Wgi+UmauTKKd5/u80Is?=
 =?us-ascii?Q?e7YAvq/Y3Oag285bnNZYAB45dPmFjVH3GlsGitsSmX+u7+PjsWz3RdF5P8v3?=
 =?us-ascii?Q?FPyFeTNbK5Hn7JCBjAzuQIfIXFjq4pHHk+1pnCsF+mNzO9iyypNGtsYmPBaE?=
 =?us-ascii?Q?rUXXbf79it6MPQlUSpXqVNNb4YqykV0lB9ZWD5+lraXyOk5EjQi3xWi3ginZ?=
 =?us-ascii?Q?Zd4WIKUGJUmd8TLKYoewFl2j5H48+LPqBDio8bJCQMusPu0wm9naELW/QSOR?=
 =?us-ascii?Q?z3hPL0vJ/J9eVa1STbgB8DhwAsJTrtnXMja4FL+0jifgT0bJ7QAL9VaTMPPu?=
 =?us-ascii?Q?OS8HWvHYL0ZF+G3C4tlyTFo7b0t22BDKKpBAxmI6YjVr?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e00d28-16dc-4dc4-9267-08dc801e073e
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 20:29:24.0030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APNKlsKBEksII8pmXisVlPFRW/wdhBBFwoJJNSeDUS0Kki7ger/qGJ0nOueOr8f/vkg5ytLPMrKHTHL5Z6kOZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7874

Generate helper exports similar to what's currently done for Rust
crates. These helpers are exclusively called from within Rust code
and therefore can be treated similar as other Rust symbols.

This removes the need for explicit exporting all symbols. This change
also makes it easier to support inlining these symbols directly to Rust
crates without them being exported at all.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/Makefile  |  5 ++++-
 rust/exports.c |  1 +
 rust/helpers.c | 20 --------------------
 3 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index f70d5e244fee..b4d63ea9209f 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -17,7 +17,7 @@ no-clean-files += libmacros.so
 always-$(CONFIG_RUST) += bindings/bindings_generated.rs bindings/bindings_helpers_generated.rs
 obj-$(CONFIG_RUST) += alloc.o bindings.o kernel.o
 always-$(CONFIG_RUST) += exports_alloc_generated.h exports_bindings_generated.h \
-    exports_kernel_generated.h
+    exports_kernel_generated.h exports_helpers_generated.h
 
 always-$(CONFIG_RUST) += uapi/uapi_generated.rs
 obj-$(CONFIG_RUST) += uapi.o
@@ -373,6 +373,9 @@ $(obj)/exports_bindings_generated.h: $(obj)/bindings.o FORCE
 $(obj)/exports_kernel_generated.h: $(obj)/kernel.o FORCE
 	$(call if_changed,exports)
 
+$(obj)/exports_helpers_generated.h: $(obj)/helpers.o FORCE
+	$(call if_changed,exports)
+
 quiet_cmd_rustc_procmacro = $(RUSTC_OR_CLIPPY_QUIET) P $@
       cmd_rustc_procmacro = \
 	$(RUSTC_OR_CLIPPY) $(rust_common_flags) \
diff --git a/rust/exports.c b/rust/exports.c
index 3803c21d1403..aa1218b325e5 100644
--- a/rust/exports.c
+++ b/rust/exports.c
@@ -19,6 +19,7 @@
 #include "exports_alloc_generated.h"
 #include "exports_bindings_generated.h"
 #include "exports_kernel_generated.h"
+#include "exports_helpers_generated.h"
 
 // For modules using `rust/build_error.rs`.
 #ifdef CONFIG_RUST_BUILD_ASSERT_ALLOW
diff --git a/rust/helpers.c b/rust/helpers.c
index 2c37a0f5d7a8..895f4b696962 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -37,13 +37,11 @@ __noreturn void rust_helper_BUG(void)
 {
 	BUG();
 }
-EXPORT_SYMBOL_GPL(rust_helper_BUG);
 
 void rust_helper_mutex_lock(struct mutex *lock)
 {
 	mutex_lock(lock);
 }
-EXPORT_SYMBOL_GPL(rust_helper_mutex_lock);
 
 void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
 				  struct lock_class_key *key)
@@ -54,97 +52,81 @@ void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
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
 
 void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
 {
 	init_wait(wq_entry);
 }
-EXPORT_SYMBOL_GPL(rust_helper_init_wait);
 
 int rust_helper_signal_pending(struct task_struct *t)
 {
 	return signal_pending(t);
 }
-EXPORT_SYMBOL_GPL(rust_helper_signal_pending);
 
 refcount_t rust_helper_REFCOUNT_INIT(int n)
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
 
 __force void *rust_helper_ERR_PTR(long err)
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
 
 const char *rust_helper_errname(int err)
 {
 	return errname(err);
 }
-EXPORT_SYMBOL_GPL(rust_helper_errname);
 
 struct task_struct *rust_helper_get_current(void)
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
 
 struct kunit *rust_helper_kunit_get_current_test(void)
 {
 	return kunit_get_current_test();
 }
-EXPORT_SYMBOL_GPL(rust_helper_kunit_get_current_test);
 
 void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
 				    bool onstack, const char *name,
@@ -156,14 +138,12 @@ void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
 	INIT_LIST_HEAD(&work->entry);
 	work->func = func;
 }
-EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
 
 void * __must_check __realloc_size(2)
 rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
 {
 	return krealloc(objp, new_size, flags);
 }
-EXPORT_SYMBOL_GPL(rust_helper_krealloc);
 
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
-- 
2.42.0



Return-Path: <linux-kernel+bounces-568775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53063A69A55
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E900718960CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DFB215049;
	Wed, 19 Mar 2025 20:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="tbs8G+y0"
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020123.outbound.protection.outlook.com [52.101.195.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831012135DE;
	Wed, 19 Mar 2025 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742417533; cv=fail; b=Dfgn6H622O9oBdhRFg5LwgRGq2EjtCbnWZN5bYrlPC7pCAfMxvzpbNcTWrnKKi/QDc0eTtgARCMRMMHwGtDmG5Ve9QVIq3zQTMiFSmZj1u92+VN1hpvI0knjXeBj05zxJc5c3rPFd+hXuQRXaO/ql+8F76gie4V0fch3aQrbn3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742417533; c=relaxed/simple;
	bh=6DvTfanm03WyPt7ws3Z4dA+5it3WmFgxNnEuyEaTXXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KMNuTNkBwteiIK7VKh8ZnW3ajiQVtXzmP5acoqXfm+yoKKVKkr+P7MJH9KcaS7lVQ1dZWDiiJ3kTPg+3YioYwj42xD9sFmc/1ykiwj6VnmC+Ef+MZ1YSPehQuL3pjjuopLFIxp/gPK2+zp5PdDpL9zyFwoqSflleA0SfCk6+DOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=tbs8G+y0; arc=fail smtp.client-ip=52.101.195.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNyPt0Y2BMebiQx2b83q9UVUcWBS9m7vGcKQ1Hi8ix6CBa5TjWNgQ9b3wBxvZuqSFouA73jcR23O2PGtyRRpTVgHeeA4izsj/EBwvJ4vJNIOnJ+nIddPzXoMPzCawWza4hTNqnR3evU06TO+uWSBEbrrF+QxBYqGJBNCxxoRQZ6Vf7aWm0QHNp/vmisfvMNrO0rvkIm4NCF2OLpfblvGQ5XpDiUDE1AVO2S2wsYVvpLP6gZxXaXuBLwZ8tiLEaLS+uS1SzPpxIYCMBplzlAMzkSoJlImILV7RZWTkGRFmSVv4I2InqwIvx9H1emtDKv+IM19mHkN+L40lQFK2kBs+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cfe6Tjinc01BJlzDHHEKn3C10IE62YJ/wJwZAS3HFfk=;
 b=ZDqrj4wrVUl0o6smt9bLMB5FHIltc/IUepm21mNTcY0G0p3vhueeO2eQXvWvYssMRBBnEsRu3MZ4XOQk7YF3bnjFSpL8LD0rfg1L8rKNXYiP+EoNaf7eHJ0jFuPl7/5A5QLK0mmPy/redFzVca09Ul/uVwfKj42/1vuoKRGFOYvL0oXUTrOBVdB3mvI6IXYgp/9aSBQZtLBROZOu9jVN0sVR7RB7D9cqdeUSg7EKPtvhdI7GxKsNXpVb3BnBxWEMLYscJRh+1XCr5vSaXZRQEsdA3J/YaqyodMO3df8eyxUT2ZxA+6tlCC318UoYivzJ9N8YDAc6vjP7V/jHra7p/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cfe6Tjinc01BJlzDHHEKn3C10IE62YJ/wJwZAS3HFfk=;
 b=tbs8G+y0Ccjoqc33wo3UBDt43UJJHlRY6iasiGdMkptfF+KULXOH7A/4I4XABykOVz4GgFSxKmWt50D67dkbps16CY1H41pNe97QSLml3GPCJTACh+pURloJEpglQHZkzG0t17v20J5+I7xr9ZZvQkdY2ZtwRcn703PCKZpPoLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6182.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:184::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.13; Wed, 19 Mar
 2025 20:52:08 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 20:52:08 +0000
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
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yoann Congal <yoann.congal@smile.fr>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Chen Ridong <chenridong@huawei.com>,
	Jann Horn <jannh@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] kbuild: rust: add `CONFIG_RUSTC_CLANG_LLVM_COMPATIBLE`
Date: Wed, 19 Mar 2025 20:50:38 +0000
Message-ID: <20250319205141.3528424-2-gary@garyguo.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250319205141.3528424-1-gary@garyguo.net>
References: <20250319205141.3528424-1-gary@garyguo.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::27) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: fc89736b-611d-46d3-0c32-08dd6727e9ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jLKRXeK0L2WciAiK1sEpURVinMo/TMJy+u3MgZt3HcZXu0EZPpS7fWK+Uhn/?=
 =?us-ascii?Q?xV+h91vWvXHaVUU1+vn9cg5aAaqbEhPXLFxBGvfq18ZBv18iDuqjbWEAMDIz?=
 =?us-ascii?Q?rI8HW1epJVH4MKoSIVUckRyloQUVurqRcp86qHbs4QBWoW1TxExFCeQ/sdgA?=
 =?us-ascii?Q?9KsmQFKE0LtlIAG0AYWTeqwNcnxwrbrqVHncI9VmPlfuE6W7fStFM8yzgC3H?=
 =?us-ascii?Q?JHd2zFBRQ1qWjwCSOeR7EilqaRDfEUNyjDfx/e/3aqRIKLFWx6UL06nJuTDl?=
 =?us-ascii?Q?NbHFsdoyrZ5chdBGBsS7l5k94c2HX4r6j06D19lJ0TqHy8lw4HGDhik8CMob?=
 =?us-ascii?Q?jxET619UGd287QYkpsW6iyzpdw5Zm0uZWmrCo8VTLhNggpufl6ptCPaJgezu?=
 =?us-ascii?Q?eISdwwlDAUrAD3NdBJyYU0bpY8NJEVzoEtwIC6eSgvoFWVr7FBkfegnfqzuN?=
 =?us-ascii?Q?kz4xiXzBrckic5UYPIxjWd0nghYvdjYkMAzUH8vw9ZBxOBXng09jkkHpyBka?=
 =?us-ascii?Q?tqOk113UITfMsSjs/Ui3iWST8HhFDTum+IljjVf2FcHfwW+On3JURNvkeWWn?=
 =?us-ascii?Q?bnXrXnZxqN3Yl7SBbkHwvRbHTqnQXkZm47tsH5nLwvx8vx+GjDluAJsELBwJ?=
 =?us-ascii?Q?hVsZcxaugGbk+zXu7EefxmQ/6oeA3VfF0TUkWzgo2UH2IAFaBrykPS4Ru5cf?=
 =?us-ascii?Q?/Imuipd3lZgmB3wI52hwIdbwpQrm3sV2rk1fJpqRUkqTtuxpdP9Cza3Y2w1A?=
 =?us-ascii?Q?A+z0JHty4Mk+X4umSUIq/r0tOf8YNL0n7mkU6ecywL/wz9pJI6WWxNyBxHmY?=
 =?us-ascii?Q?FxMTaha0qyEhnYeFGm2BfAN//P26QAWV/ZCJ1+rFmKmd/gKvCi0nI3au2y7N?=
 =?us-ascii?Q?1cMlOn5NyrcVP/2tS4FI6slcCRefvEmadJtLsMkvDgAAdMP5fg9RP3cvx4ar?=
 =?us-ascii?Q?o5UkcBYwZwDl4nYCLWmX8vsFfreKBlUm65V67NuvOk5qLWrG1HCReO/A8nbG?=
 =?us-ascii?Q?s7l5nfm7DO6vM1mQlo3xAV2w3Msxc9KL4ThgGMqEfGrvnXOKBwgaNpEBkBWR?=
 =?us-ascii?Q?Cr5rzrnqQeHa1GnzKzqLLCRRvS/F4+sxydmTAwwCiIEfbpb3Ccsw2+cw9lzS?=
 =?us-ascii?Q?XNQlh+qAcH/mTWxQQ8wTVPIbAKRBA0HZUCaG7PKeWo8AFhJMaSDCiNlw97HS?=
 =?us-ascii?Q?qYK643PGuZI43FAdmSf9SZlewjxLtHu7dPE+adIe9wv6t2MEaI1bPdtxXOWB?=
 =?us-ascii?Q?ZWd50FGaAYl+F9OnUaIY48WrpbecdHYC9hU4xa6k/4pTMy0mWi73bLysMtqh?=
 =?us-ascii?Q?5gCVdDCyf+ct+D+B11kBZ8QiLFnf592ShEi13NTogzYlSHoLVUWg0Vy3bepZ?=
 =?us-ascii?Q?PcLl0IpLq4DL5uwdz2cwjvr1CnPRFO0NBQSbRskJ+9qb5fAR9oO67kbAekRj?=
 =?us-ascii?Q?xSKpw481l/c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0SJXVyE7fY3OEDzyI5A7frQU9ZefNCpsThzh9S/FyjC6zE7Eiarkzjc+UpaJ?=
 =?us-ascii?Q?nnh+x7jAIirTMi9sPhW2uMyy5vueS4r2XKsPx5UaWaGx204AptGUOP0nUwXR?=
 =?us-ascii?Q?azoE4EoNvqgzw5Rup3nJgWiK9HHgOVWll2K/mOpj3R1gD091OkrD6tATqsbU?=
 =?us-ascii?Q?zVH0sdHnORSFY5UcZVqTGGspRQfi93u5MAfbeylDGJ+55DZZrIUjOQxFkc0a?=
 =?us-ascii?Q?Kr4NFIFt6sbfBZGfeQe72LlaG+WrR1sCHIvemqp7i+cbI8rNWLxyUKTajNtH?=
 =?us-ascii?Q?hpsnkgj/UJrAvbjWto9SX88VLtiTqDVN6jYurUJtXk9Zq2qFaPNAIgzOP3Ky?=
 =?us-ascii?Q?WTurkH3CEUY5doE1niykoluC48QP7PhRx64cdBTMrdXZp9WnzZsrBRyXP1DB?=
 =?us-ascii?Q?zZ9gZmqDDgWcuW9K+zkezSf9XwaS5G7fq1szwCXFfusAYf4M7BY9LUQBT+5s?=
 =?us-ascii?Q?7NbHLkIrXSfAABPW4KNQ5VGKPzesSMJqQCnzWHQsksH1KpPZ6hCYaQB4df5D?=
 =?us-ascii?Q?q7aiBt2c3pNd3FRxb7I6Ka20rC457ji/MUEOPl/AlabyY1UovhSk4VMtyyx4?=
 =?us-ascii?Q?wpA+kevWa2trmmThDaaeofUctho/BJLlmI3R0nH3g5WI64yRZfdg8oOqcB7u?=
 =?us-ascii?Q?wN3boXqOlOTDpcSn+768eeZ7I0W8htDXnk7XExNIBFIxDSWXUZf4yUVR7zS1?=
 =?us-ascii?Q?Dvbelr03kWO2ptfIDEt86p/TgQrgw6c/gsbtwHy8+p9+d7zrVpSsxzmKuahs?=
 =?us-ascii?Q?Y8RX8hrJu18ZrKmgqD25plPsVzZDBRMoONXgZ6BgMqfkO7hzjRE+LWDO4rfN?=
 =?us-ascii?Q?IkKnn9MBxXJx95ucRLc6DOfxApljJe1OEs9Yh8xYHcMdhN0Q8XAK+l1bZomF?=
 =?us-ascii?Q?Rzzlj55TfJCctYXISlRd661CrAeqbyYcLpWBaLqTxhp5W1OmQZq8npsLPpWO?=
 =?us-ascii?Q?Bh3j8M2uwunFvHtCNwl/UVGAOjLNotd8LZjJ0k9M7hTVSntCRxWnOFGtNrKo?=
 =?us-ascii?Q?0iOWUWsUUd0KcmBWCEZ/0IOCwW53pPHI4ikAwo7eixD28YR5lLeQimFk4wIj?=
 =?us-ascii?Q?lhelbDHHKtHKH2YCpxql/5LUNGweqtayiVS9uPuT9DG9t4zO8p/rkySDjBM6?=
 =?us-ascii?Q?QiMgvJqDTnQUz0Fvjw3jMkyl6W2aUPeaHNxNJJOffKt8z4jtxYognqh+GNda?=
 =?us-ascii?Q?9SXw5CSUcMxY2LGxeKBSvvXu7LmLSZW32NUm8pQirrbd2eim6+ErkGLfE1To?=
 =?us-ascii?Q?rR/kzwOm88chpgvX4xHWr8aq2QX0LlxdjLVodVGDiFHuzL3pNxATLGJ3DUXt?=
 =?us-ascii?Q?yZ3jhjTmPlvdvIfxJI9bSzZVVON5wKFo6Z3+LqN4XxOZ+nZwUWLNBNSbTKhb?=
 =?us-ascii?Q?P4Uke4FYc+K12/Rvhx+D/BTXfIwvq8XH4IkjS3iSFoH1TXgFXzBwMkK0Qb4A?=
 =?us-ascii?Q?67Ti2859palJjjekquj/dgmMJ5yTqOydRW6jb2e7bJeBcUtT5LhZtTbzaw0v?=
 =?us-ascii?Q?vd14ZTwoLZATUxqU88vs37rd6ws4qQdcx5gu4qHacBYMYyUithpeJLkcCeDX?=
 =?us-ascii?Q?yDWdfXP2YsX0jSZdkSjJD+uNGxv9M5pgQ5EbQZ05GhVmU1BeodBCQDIgXY8o?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fc89736b-611d-46d3-0c32-08dd6727e9ea
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 20:52:08.3580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /tMFtE3agxIUWweKq6Xj6DxleGIWZg7yAtVgjti6ykMoTbY5gyhKKd7B+8x9D+f6XNlWRtx3rh9pcOnWw42Mjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6182

This config detects if Rust and Clang have matching LLVM major version.
All IR or bitcode operations (e.g. LTO) rely on LLVM major version to be
matching, otherwise it may generate errors, or worse, miscompile silently
due to change of IR semantics.

It's usually suggested to use the exact same LLVM version, but this can
be difficult to guarantee. Rust's suggestion [1] is also major-version only,
so I think this check is sufficient for the kernel.

Link: https://doc.rust-lang.org/rustc/linker-plugin-lto.html [1]
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 init/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index d0d021b3fa3b..e76e4ad7d4b9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -82,6 +82,21 @@ config RUSTC_LLVM_VERSION
 	int
 	default $(rustc-llvm-version)
 
+config RUSTC_LLVM_MAJOR_VERSION
+	int
+	default $(shell,expr $(rustc-llvm-version) / 10000)
+
+config RUSTC_CLANG_LLVM_COMPATIBLE
+	bool
+	default y if CC_IS_CLANG && RUSTC_LLVM_MAJOR_VERSION = $(shell,expr $(cc-version) / 10000)
+	help
+	  This indicates whether Rust and Clang use LLVM of the same major
+	  version.
+
+	  Operations involving handling LLVM IR or bitcode (e.g. cross-language
+	  LTO) requires the same LLVM major version to work properly. For best
+	  compatibility it is recommended that the exact same LLVM is used.
+
 config CC_CAN_LINK
 	bool
 	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag)) if 64BIT
-- 
2.47.2



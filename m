Return-Path: <linux-kernel+bounces-330097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371439799B0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 02:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570A31C2233D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 00:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4774C9A;
	Mon, 16 Sep 2024 00:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="biSi6V7P"
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020085.outbound.protection.outlook.com [52.101.196.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E389C2CAB;
	Mon, 16 Sep 2024 00:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726446838; cv=fail; b=DVYReXUaN2IEGeOylOgzE/38lBMvyVWMJbh9w8y1/XbBgyhECILpmNUeXpeu8RoHBTZ0O73wIvchSEm7u7DQYIBEUzFehdxFINWD45ibxqqo5NVtHj9XrFpPVbkj0qccOE7jr4Ue22lAePk45ZH4/2D9gYvEGzlsumsH29ppkDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726446838; c=relaxed/simple;
	bh=38JG8A1San3JPGzoUiDCGb02vVRCl7H4xMGbF03EExc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t2mf2nslXCzPje6E4N7i9C1hYbL6NGegkowck4WgG0G/kKUzrGr6wv8oKLz48RNnwXjqmFE+3cX2kt8GuDc8jTRfoWmad/jyv6sHbgL8YAEr+jr0qwcJiR+R9t8AJHj/HLwR0nuuM3vndQwPimbljZBS74746tpUhxbm3MxCnkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=biSi6V7P; arc=fail smtp.client-ip=52.101.196.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zU8ToY4IkJORSQ6bbX+O/T8SPv57roeszvVG6GMsz9S3zoMkx4njGRjVUuhn1ZuVxVFCxG5CysaMgFRRabadiV8mpDw6Xu7MwCvQ2lxwsxJvZW4iSWdj//a6Ze1ueHhhcoieiZ55V3SRAUaVe7JEtFzNCvtIC+rogM5Z2gAZW/zSJ/bidlqsiaK8PAfTQibyhAfKhAHh6JJIO5Wy/Np0JwyZ7WJg/jnvvvXaYeUOLAcTITsJJvbDi4ouaDSNwTD8Qrd6Bi+XrnQCaEbdkMV9GvdTc6UshSFAMchpyoq6FpJCQrEIXzRSPqYAgCuJuhXB0kCzf0+3Z1qhRqco0ThTzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFftSz9230W/o8mCsyvhGGaqpONFtGaDC2Te+rF57mg=;
 b=UsKH7vrss9XhmZBiyQVl5qouA2VyUYA1VfuZ4UpgfvGxhdh0DOgdlaM3yE6JmPzhn43yCafYNWf744Bs2/FVkzdJBQDiVDQsQ1rXOBGKj4qdg7gl6kQWiX8SFyknztR92PScGk2mW+b24DttmWs+uTOwmCYTz2duTaeboSl0PeWU9yHcx0+D2uDyw3PON0xTLBSuaRiCEO5MAGAxyr1S8Gr1gucbD1I33Q9l6o/zMw5REd9N8K4GqfYaBtC3wOno/lcyYIcShiidA8h+kNzP8kA67aF8SOTXyOJCyGdtAxhLm2oCzvBwLASM483uJf4Wp0U1lRSctQjhZt+sl1rmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFftSz9230W/o8mCsyvhGGaqpONFtGaDC2Te+rF57mg=;
 b=biSi6V7PibxazAyqB3YjyHH5QJqGH10EIZQ8TtrC+i26ZveD2txh5q6sCJonqrw7uJJ30hz7My41qL2W1Is1qxERfrn+Tz+R86wdmwD+WPcNeMwuMM+PtfAv7NS1PAdMHFK3nIEbM0JmCKG7rJiTa1gx5RmWgVdKPZX+cF89p+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO8P265MB7935.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 00:33:53 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 00:33:53 +0000
From: Gary Guo <gary@garyguo.net>
To: lkp@intel.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Cc: conor.dooley@microchip.com,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	palmer@rivosinc.com,
	rust-for-linux@vger.kernel.org
Subject: [PATCH] rust: fix `ARCH_SLAB_MINALIGN` multiple definition error
Date: Mon, 16 Sep 2024 01:33:46 +0100
Message-ID: <20240916003347.1744345-1-gary@garyguo.net>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <202409160804.eSg9zh1e-lkp@intel.com>
References: <202409160804.eSg9zh1e-lkp@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0335.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::16) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO8P265MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b6e23e-33c6-4069-bba1-08dcd5e73df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UKABUcxdgGrx3DjUknfiyEvs9LmYr+Y1YLhk9tf6bCdcjDHyXUvOS3/wNfgW?=
 =?us-ascii?Q?ipTDUsjRyws5TA2aY8qFCZbrCI7WsX3kGojcdL65IKmP1ypL4Giv3wk/yGNc?=
 =?us-ascii?Q?4jlyOWKPeTS9zlafZVDnSLGHxbC/IyoQVuQmsUnQ/JVWhsZXKXW064byE25+?=
 =?us-ascii?Q?kojCYRIQej4ODM2F31yi06nEpPs0sDFyulWycoAVM4RTh34K7g2QRgNVWUet?=
 =?us-ascii?Q?zz0sdgz4ugQJm8YuCqB2y00l5EFJvs27UkZjgqwfrCuJpGtYklMR7Pj1qgC/?=
 =?us-ascii?Q?VqQbyhvfUxP0ipgHsPCfH7ka2sgjoadnbCzPncy78U4e2R1qUjG+XBC5XVd5?=
 =?us-ascii?Q?WHDrsAyeU6vyJKRAM3JZOneOUThMoCP744RQPA4Tt+26JM+oX1aw8fTAw58t?=
 =?us-ascii?Q?YKRJdYn0bpRLzegpX+kmgqws9qkDBW2HIbuTzKTZvNspW1oVEyyDfvHMkYa5?=
 =?us-ascii?Q?8dNmmTqpn0KwdMPCPi0gJvgwQRA//8NP91fKUjOMfj7vFJmCNFYBt34ZyAWn?=
 =?us-ascii?Q?+ZGuQXXWq0co+C8z3+8HlMljGYsqkyftghe//geHAE0u/oDWfLwSNZDG1oSx?=
 =?us-ascii?Q?s1Z+f1THjAOSJL1NpuE36LfcqCw/fzcG/o/35+Xj0mGKjfij/yYuDkDaqlcC?=
 =?us-ascii?Q?Et29wqWkmM4gopA9r121sjxs2/UEfCi+d1SuM/kX+P/3BRU0GKouUKk6s3DG?=
 =?us-ascii?Q?Pg2lZMF4KVWLiKlxGj+vkMpe20YbnhGnUoDFF8IBg6kLqUjcZR7+aL1r7jLK?=
 =?us-ascii?Q?eI57NpUc55I1t93tuL6U4EhJxP+L4APGNup5mmjOT1fTtb3k37Kat10uWS9q?=
 =?us-ascii?Q?8U1LS/Hho76FrjgWBGfkfrFmDv/MDjAawndCiPOd4V+KuZx7Zo7QqXic9RkP?=
 =?us-ascii?Q?natNey1iMmfFK2HvhmrzUTNowZRRbdmE/zE/nOvR1hI9vwZZbtfpKcuTOjVT?=
 =?us-ascii?Q?Ctl3B4vKqXLfLnxR+9llKaYg/sw0TM6I671rkgwSHriGhf5A42CiEj6XisSe?=
 =?us-ascii?Q?fYWwPMH+kIw8qB1KJeARxHfg7alZDo3zlyfIkYH60tMoFaZYF4KCXDVUR2rE?=
 =?us-ascii?Q?W7CfWL23EyCFXUlYg77oXmUA6BFy0M2LPYV+XMyVVuLGGkRpnoBOQ4n5akun?=
 =?us-ascii?Q?hsP/+E7ZJYbltlKHGgXj/hO2uZOvJmPA9cuCTBooj2vE5t4qL90JbaXGW8zz?=
 =?us-ascii?Q?Pcd0d6xXdH3R+Eiaox9pJHZ2SKo/DGRBEGkxD36Alv3FKI8CO715a2dqOPqm?=
 =?us-ascii?Q?EuIu4qrHi2ktuo0V54PwZ1vs6YnIFaqDZV142F+ydYFBcQWMqMUVGhCH3YIX?=
 =?us-ascii?Q?n/vTwJ/5PaOFy92K+ScFSWmoELT/mzoKK0ihZl8VV8eYKWNZZj3Qhq/x58Sl?=
 =?us-ascii?Q?mlnxOmYEtgw9CQ/Cf4uTv2Ue5a0lAl7/tEbr3uPJ9CZa7ms/iA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iiC+b3pmKHGOGn9k6dyS/MntMbIGdVX+dJujRcbTMVgQ00IjVihucnCYY3f6?=
 =?us-ascii?Q?vfIKQ5KWXGfX2dp629pB2Xbca59ulDDXCaJaSwhCNuBa0TRFq8SqBbht31+S?=
 =?us-ascii?Q?BnEoltnyaj78vvO2Fd02YAgOPFJ10yFDLCQMqAmwSM7qKBBOQ5Ld4aclNIU6?=
 =?us-ascii?Q?HHU/bL6igO1x9MVk+ve8PLstxyHhtVBGDKT3/GU62J5Z30hnwXQJ/O8/p/N2?=
 =?us-ascii?Q?w78zmoPaPskb/2yadbaY+a5YSBTCBfQkLB564u4sMA1nntEDsRUePnUjt7NV?=
 =?us-ascii?Q?dXj6Adqz6vKfwNsie3pkiMqMuKO+QjnIGglk4atKZct/6RmvmouLGmnxUtqT?=
 =?us-ascii?Q?O3EzHGjz/TkBEemMIShFplNGBGe4A7VfAxbnOgItlkJJEKV1F4zkG4RfnQpM?=
 =?us-ascii?Q?tL9ng85YrRshyVIfzdH7nTSFaKE3TzaGSTZY7EsDhJBL566P77mXI94o4KqF?=
 =?us-ascii?Q?G1oWfxk2EInhkO6R31xQoH/j0NY/XjOtT8AWRyriqsw23emnF1Wb2iR5YgJS?=
 =?us-ascii?Q?dXhY2B1vb7qPI+pAM1ZDzyk3jRx58TTqBT8M1HoynOtg1o83cy2hA3sUK542?=
 =?us-ascii?Q?N/8UD20oknzDoP+gq9nGJSBym0HcEwftCjiRF8EWeTEDaLPBQGC7ujGxICLO?=
 =?us-ascii?Q?xtuKRSnr8iqznzmYbVXyLt3vM/GzuwfXg+hsMPYS1wEx9nED1LnDYlazSuvP?=
 =?us-ascii?Q?aeKCL9z5WUeoi/75I7hWlxov4UHZof2nRSIy+qw8fvTJtWwxW991iBR5K5Xz?=
 =?us-ascii?Q?TLdmcHQHifmCfbpAVD2MDFv3edFrN2W+/yVJQwL0CXEDAQUxGlDPg+unabaE?=
 =?us-ascii?Q?uvAnpPAbjbg6lIQdVDU7Ibv1SjJHMeki/7bths7+6Q3cjX9khoAMz+0a2u+i?=
 =?us-ascii?Q?IimHENcfQ4i54ut9KfA4PTX1lnTnw9ZsVKuzzSmsCsWFSUoTch4yo2dqdDq5?=
 =?us-ascii?Q?fWdQHvxCnnpDF53w44aFCfb3J/BOHTnvO92Jb40R4RilhXWqz13vO/+WUQFG?=
 =?us-ascii?Q?tM/0D3NKa6bEGcM1QsZWPxofqB5e/OcunBWgvmn14HWgONoi+IvIMRxp4rIU?=
 =?us-ascii?Q?kfZoN0CggOFUczIXL/XjxyBFpj0hXfz2saeL1pjsjsoRhIB38zuaPgaLfC88?=
 =?us-ascii?Q?NPYmkA5f2+EVOAZCfBp7Q5Fp1VxL+nRuM5Yv5XY4hevYPS6MMByiKf1rcbT5?=
 =?us-ascii?Q?Wn+CI7oyFJbxykT/XgJqWQWWzIzX0ZkgODDV3/XlHiYhd6QccAG0Q7pAQmm7?=
 =?us-ascii?Q?Iu4aVlEd8wypgo3gBDydFQx8LgCsHw7M6oxnoMgv6q+t4ynZRWYZNM5JF6xd?=
 =?us-ascii?Q?8og+tWgMEY1RxSgRWuRSqHRQ7vXfjHekHVv/Zd23vqP4Y03lMrJddAWKE2+J?=
 =?us-ascii?Q?WWoPk0NN8JaVGT1Eni0a3jL2pchMWLlBdm8uOrP9sGyodmHq3vMrG/doFv89?=
 =?us-ascii?Q?NtHrM11LYHPBtNofSaAdWl4LwtARAjMcEYTrsjrmZysDcZWE+Slzu+N/B7oU?=
 =?us-ascii?Q?tvEr0cU1uJJzdxK3TFebJ9WZG84zj8pXvNsFibWp70pTwf6EVPC4i8HrFgzO?=
 =?us-ascii?Q?1zbsyNjloHhZ6ivxAN7XNLMKl0PLCo1wWFQJkgosBfg0+4/oZwkeC30YrvCW?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b6e23e-33c6-4069-bba1-08dcd5e73df0
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 00:33:53.5486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFXlSSZsCfmXetWVRuHtimvHQeGZoksr/7l5nZ5Ruz/fYu3ND2Pll42LraMseluUmjDWXKXYgVLCAuxeLl9d6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7935

We use const helpers in form of

    const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;

to aid generation of constants by bindgen because it is otherwise a
macro definition of an expression and bindgen doesn't expand the
constant. The helpers are then have `RUST_CONST_HELPER` prefix stripped
and exposed to Rust code as if `ARCH_SLAB_MISALIGN` is generated
natively by bindgen.

This works well for most constants, but on RISC-V, `ARCH_SLAB_MINALIGN`
is defined directly as literal constant if `!CONFIG_MMU`, and bindgen
would generate `ARCH_SLAB_MINALIGN` directly, thus conflict with the
one generated through the helper.

To fix this, we simply need to block bindgen from generating directly
without going through helper.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409160804.eSg9zh1e-lkp@intel.com/
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/bindgen_parameters | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index a721d466bee4b..b7c7483123b7a 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -24,3 +24,8 @@
 # These functions use the `__preserve_most` calling convention, which neither bindgen
 # nor Rust currently understand, and which Clang currently declares to be unstable.
 --blocklist-function __list_.*_report
+
+# These constants are sometimes not recognized by bindgen depending on config.
+# We use const helpers to aid bindgen, to avoid conflicts when constants are
+# recognized, block generation of the non-helper constants.
+--blocklist-item ARCH_SLAB_MINALIGN

base-commit: d077242d68a31075ef5f5da041bf8f6fc19aa231
-- 
2.44.1



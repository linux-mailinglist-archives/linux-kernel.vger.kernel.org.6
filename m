Return-Path: <linux-kernel+bounces-522386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FA7A3C978
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D305816AA58
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3470722F3A3;
	Wed, 19 Feb 2025 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="abSmI0qi"
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020110.outbound.protection.outlook.com [52.101.196.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D064422F15F;
	Wed, 19 Feb 2025 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996265; cv=fail; b=iSwHA4rB894tSlkHD74B3aBPxEdGVKuuybwKES2WSr1IU8lrpHBYeQ+KkQJSOjwcocsspuWhwCLgk4c6ZdqE0iBWab2g9BPHQSwFA6ZHigIQUBzrnYobeq/hXgruUdvu4vf9GbTdOZhlvCjStIEXca0upqnvekJ5yvNy/JSUkoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996265; c=relaxed/simple;
	bh=5mqZ/IUm862hExSAD/UNTT04M5Bn/qoBaI5vTr4iDE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gvHuATEuqWhcxogYUeMhhOanys6xQA6DpvRAouMDXq8euX4ChtfRY6lTCVRvZlzBObOuRgfV+Em02lFtLH+g4JA8wkFE0/JVZLshBLFMKmnIFGO2U22QEVHJyW2DArr9c0mxrXwHc/Jn5nsDBCpbB1Y9FsRAbKWKZQ0VwTzqs2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=abSmI0qi; arc=fail smtp.client-ip=52.101.196.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flmXmb6Xex8HJz1Na5G+PL1Fjrnq7mIIzNRvtqNok8w4OnExXYSG0x3dQ0rcuHZDl6U4mMQ60YsY53oLvDI2ESqwILmeJPxO0k/yaNDfFXHvpyIou6DKTMb75Cg4/CS53ewUmJ8pW3KeFE3aYTCc1UsZb4KIfk5S4HcI66K/+Ap4xDUS264UGQwt3EAXQGyOj+sUS1CUFArpVPWxRx3PwA1DVKGTuNP72yiM2is3ueo3uccmpPm3NJEh7a1CiZHtj+bY+DjZsyE5LtSeuPoJ7QilKpiZRILOwVOS0q6XpG1UGBYhnXgPK84PqS8Ab8eM9jrrLsk1wwxXvkuzR/Fy8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNF2Wrxj2vaD+ZQDZolqYkLE2I3TKD+6eEPk7Jj4qH0=;
 b=Yiz3ggb82q0EgNpY51DIPRT+OQdoYpx2x7zR1Qvlg0+K45uwDcG7oEJHI1io/CQR5PiKivCGTbE5miPVA97XsTx+5UeaMh60vpiDGaq59F3uYDJBNVBFFli6UtigQdgbSu2eB+yKw35Q55EHP4o3A3hmo7zy+Ta7M0p1+mr/uEHrRelOPJoImru44tejauSxhR2rJVsOncvrKzlVyBmKf49feZadt2Rl2y8VybkDUR8mpWfzE086FB+YZVv0qpBGqmM2Ox/tJfX5J3nHZRphBHoolm6pn4gZ5AsMfLxGLLYp+CwH0+98NUEt5xtHKtwH9128Zu/vTzr9rMKktoOUFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNF2Wrxj2vaD+ZQDZolqYkLE2I3TKD+6eEPk7Jj4qH0=;
 b=abSmI0qiuzikaD5CQ3lV0yXffJ5FfhWlBrXtV86cAxKIuGdzStlpnj13jJaZhqIwnamKLjFVnDjFVjC4CF/o1UuujlPww4uMQmtmTrdT70IEDxWbk6e19L8IKCb//+rShl+OzoXNCNT/Ij8fLcPiob4O/dFhH7fbR+2qRjJ66Ws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB2783.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 20:17:38 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8466.015; Wed, 19 Feb 2025
 20:17:38 +0000
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
	Danilo Krummrich <dakr@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] MAINTAINERS: update atomic infrastructure entry to include Rust
Date: Wed, 19 Feb 2025 20:15:33 +0000
Message-ID: <20250219201602.1898383-5-gary@garyguo.net>
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
X-MS-Office365-Filtering-Correlation-Id: e5b4ab5e-8571-42df-bb24-08dd51227490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M3EYap6uTLGuk/oyCCRM8zrHnhLSiEFU9WbFijTrAKoQNGY+adds//P5jwd/?=
 =?us-ascii?Q?AT6pFIljS8F9iTV2p0UxMgvM9Ro98IvajVrVPrCYP3t6dezCPEzu73cPLYCo?=
 =?us-ascii?Q?St1lXzTmcK3J1wmbgAFkKSa3fYV+zuNAeZe05agcD6IfS+JACYc6uHNo5JL/?=
 =?us-ascii?Q?9pb+8UNSuqoa+JhaG+gjhpHgQpRO/Wx8/dSQmnuw+ZQyudCIhwMEaBi48eK/?=
 =?us-ascii?Q?ikRoGGpbVDCSaOq8FVdVioE7xzYeuJq9OGn1CKL8hg//Z99T1+hXi3CwM4xC?=
 =?us-ascii?Q?yZOIPTmkFada9gFl02QFEIcbIyP9ie36QFMn3jqB6zHPj7nVO71xyZPb7ffL?=
 =?us-ascii?Q?c88VDZGPAInF62pXZrewj2UfOpK3DJzKejuG/eFsLAoVlh4PogoFsIjuKvn5?=
 =?us-ascii?Q?JTyictrOPert0hGYz8ZxaE3BuiQsGippFBmN0P9QK3iXWDlw2mcN0w8TTfUr?=
 =?us-ascii?Q?koDyu1A9mg+h22hNiL+OzXCsU4rSLlw9WVB9s1z7OcgwhpPxQBFxZ9ByZwcQ?=
 =?us-ascii?Q?2f28K9IVznZFAyGytW2FGMcXQkM7OPes6oAjHUKgmvlohRPwgZe3HVeGKYDO?=
 =?us-ascii?Q?cxPZMfK9ygYTR4fO0JNJPVTa8e2/BnCXPyTUMAQRbpckXDfBsSFVvFjX7YqV?=
 =?us-ascii?Q?lvb5ANVkAkQhzdsqIzmWgW+QHKwvd4xtJI5p/U4RTGAkjAx282zeCFKPuTKM?=
 =?us-ascii?Q?OQpgdJTRhbc0z5rzHPiPcVQkweOllHqwg8X5O41+vB5syOZwbhyNmWSO3/1t?=
 =?us-ascii?Q?QY/rWD4NwwAY7KOy7/qyh1OCmPRE3NFrDnaSfwsLrmqAbVjtcE6jSn2+bONX?=
 =?us-ascii?Q?tnfD0hIVumQwoCBRTx/uempdy1DFvpCAWDzqTP8IVKs/H4Ows+5tH54WyVPf?=
 =?us-ascii?Q?wYuQ14YxHKwExFUh7v9RBgXVky5sGUqbA0FJ72bxUvg2Wzxqb5wDBHbSzPlg?=
 =?us-ascii?Q?9wObUzhp2eghd1lC8YhaO8wG7v8atWife5nvpySQb9C4PvMrhyo/0T4+/Skv?=
 =?us-ascii?Q?vUXyu3XXUW56y0ffEO3fvWY3SOXgbrh0pCUUFiBUEW+Sxpd8KIlWGnu3l+dP?=
 =?us-ascii?Q?cYulqT7NkQtqs050oz2lG+8Qnq/Ly0kptS1WzBmxXhHHCWCTrZP3b44oqPjt?=
 =?us-ascii?Q?KViILM9Rp1xn/WIV9lvqPt12Sjznhr01htTM55gO5DrwA21SJi54wvxXQElp?=
 =?us-ascii?Q?CfGxNXHCvUPQpXjVX1/STMD0LKe3YUAs23J5nN5fi5Lt1HIlXXMqM8lB7Uee?=
 =?us-ascii?Q?vEv5GF0rmK5LOSLVd+0gR17iplAIeza2OVAFw+8860stwG2/l3bArr80CT3E?=
 =?us-ascii?Q?DOa39qPtHKjIdKrBOER3zHQYi2286oEX/WhR17/Ieggw69TTsyiB4YmbjOQR?=
 =?us-ascii?Q?88K0dC8OzpiDoFn1GU/oHfDSbiLPYZwXpzvwBvKC3wBhaBj1osGvcMiFg5Nq?=
 =?us-ascii?Q?q+FrljQI7Ys=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BTy5r2pH32pQ3SMINslfT3bIJQzyeavDWbLmmkjQEmCcsqMoO3X9hfk9cN3L?=
 =?us-ascii?Q?qN3CaHusLuMCC/QLWb88Bo6kQG3yfj/Qp/szVIwN//wioyHeUVMinX46r4Sy?=
 =?us-ascii?Q?KzN33tmo8pjkIQtk3vxf9h5iMipm7Ts28fXwIdkMdNdqrL1aXDv/6FElc3Ke?=
 =?us-ascii?Q?Kq+oikxVsvNiW6tjx/zlplgt7I7MmzOcf6gKty8RUCkhyO9rPKRx+QQ/f2uy?=
 =?us-ascii?Q?yGcPd3QECywj56/hOrPRsvCExi9uduikkxRUv5y2XHpiPDSnvZgRX+WOTo9t?=
 =?us-ascii?Q?3U+ZT1iJi8ROVikZ1Z8SQ9hnRperD2SsjOrEvX+CsAsTM3l9p9LbpUl+dl+I?=
 =?us-ascii?Q?yUtDgUbywLcSWo84F8qhiw/BYMC8JHlzZ/t80b4mY0GQYPbLJhzBIrbyrJjz?=
 =?us-ascii?Q?9oA0VeRd4ixR83E65Yi1bU3j+cr0vGH6P4BDsty/IH6jY+fTt2cW4Eoi8p1N?=
 =?us-ascii?Q?Atasjhye4fXoPO3P/jB/iUmUZ2xx30qPWgfRZrjOjhCNijR0b9F6sAd/5s0i?=
 =?us-ascii?Q?0gATYDmIlfF3NRFg2vttr1nCYpzAUo9c4DNceRpnmYs5WoQkMTNuGKBByFyM?=
 =?us-ascii?Q?ugldPrrNaOx0cTLHD91YbFqNOO8xwhi6ougHmJTt/SbO47iQvEADMsi28fc/?=
 =?us-ascii?Q?5ohuZ04sYefSWep1OUwZf/QeaW/doj5JcySnX0gQO4dfjqv3YiMFy7hUMaau?=
 =?us-ascii?Q?LCcYbjZUTi2Oa1t2aKy5k2O99F49ab771SluPqTXRzcF09lJEq37/tGwHKs8?=
 =?us-ascii?Q?/NXuGnPKPLKCRUq/+iEOHpjw/TZltaCrObNo/jca72o1G9kUfVZomtUqdJes?=
 =?us-ascii?Q?/4Cs6qA8XKbGw2P+beHqn3pOoD3dKyTRBaF52BrVmidlB7m5gPwbd9XgjOIJ?=
 =?us-ascii?Q?LwygaUWW7+vEOSXULI+LcOzwYxC8upuzFpJmHjHI3ASBq7KSF1WaVbmTt8rY?=
 =?us-ascii?Q?72wO9CsuzxJRj+9/5EOoIuFjDmKHvbKF0N7pvd5QQQxFIV085G2KYdN4FldD?=
 =?us-ascii?Q?xmVOK9e/YwtsXQDapofy+9rF44Db4rq/aVxZ90VUKSOCUl49LelJvm0bS5dh?=
 =?us-ascii?Q?dB23/2sYPJ5b7eAfM+30lOr0HE0LBvyL45U+iySy/xc7EZoUNcPULWM5YLDU?=
 =?us-ascii?Q?H/Crtj6X0h3k03kYw6Fooygo1X7fRbhlVdnHH2v32XZPyaJFduQc8/lVZV1A?=
 =?us-ascii?Q?6HY5UxmnjzWy7e2vgJhqDQDmNh9vrcnmGOyQkgbSVagCgOMts0qsIJVwySNa?=
 =?us-ascii?Q?WeeobOkpFF2bUCpd+kBvqU6QtVKZNFJR0597SecT2fJ1tCgMNOSnT7BkrUi7?=
 =?us-ascii?Q?BINmV2hivC5YgR1NuhsO+3gXZocG34wLhmYYuQPwgodn1xayXQlFcmYkiirT?=
 =?us-ascii?Q?v2NLY5CGeEyJM5oVQYMqrNMUhtaSQSJL3895rSSP9FDXouUS3U/K5citg3pp?=
 =?us-ascii?Q?z+97FfKZsGItVCbGKxmAvBqGxdGGdK1539SMgYRvp3ynl4kjV1QfokjH4K20?=
 =?us-ascii?Q?zlzDNOq0DnZI3D6YKFNUuSGa4zAMYLafdIxaqfMdwyvDSIZ6CuPSAE0Uebi+?=
 =?us-ascii?Q?VPINNxynd2act3TiotBXynqIBbu+2nYguKmC5TukWHjtNRUBfwSr0z3D1ZV0?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b4ab5e-8571-42df-bb24-08dd51227490
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 20:17:38.4305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+PfOK9XqEsjU8OoUulMBI9kloRJ73nracmNWZqVKc15p1QGdaWQ2HyEPDw156x6OTuftQRimWAlWD+tEkI0Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2783

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c8d9e8187eb0..55d303633598 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3725,12 +3725,14 @@ M:	Will Deacon <will@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
 R:	Boqun Feng <boqun.feng@gmail.com>
 R:	Mark Rutland <mark.rutland@arm.com>
+R:	Gary Guo <gary@garyguo.net>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/atomic_*.txt
 F:	arch/*/include/asm/atomic*.h
 F:	include/*/atomic*.h
 F:	include/linux/refcount.h
+F:	rust/kernel/sync/refcount.rs
 F:	scripts/atomic/
 
 ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
-- 
2.47.2



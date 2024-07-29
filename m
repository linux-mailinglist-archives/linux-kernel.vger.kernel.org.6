Return-Path: <linux-kernel+bounces-264997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C82993EAFE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16951F22024
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885667580D;
	Mon, 29 Jul 2024 02:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nPh8T0+p"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2103.outbound.protection.outlook.com [40.92.19.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0363C2AF16;
	Mon, 29 Jul 2024 02:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722219247; cv=fail; b=Q3cHCBYjZvqh2Yimwnh5+w1Ld06ZVXgAcwAxT6VlazYBRAqTvw8aBtyGH6nR7GH8IjFXDVce5KmKZNmRzCzku5qo+Log7ljYkqnuWSWOl0+hwlYwx+I8EtxUA4dfkzVB6Vy05mNJ3lAH8WOA8KC6JaPNWvRZqxuOmBV9HWCwtv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722219247; c=relaxed/simple;
	bh=xLVWcnq3v7rVKVXtktkKfXs06saiWquv93lLfTPFR0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PmErfZwEgditSa7RlNM9sJRJbrMA9AAH85GNJoW1AsNji6DYbJT3bcfrLLLRxlQSJBbxOIuKQTXWP+0zi/gTlmNhWuGE5oGQbJkGYN3MstEcqjkr57y8QAqbbdj+6pgJ+6NjTpukzX33OE8AXxp6Vvwhfwo5NhRd3exf7cGZ+3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nPh8T0+p; arc=fail smtp.client-ip=40.92.19.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+TL75xYwIE1ZjU+3lVI5XboT9ahitNmhvO5bQIAXraL1eqyglhGRO9nWVY6MVnQVwpEXrG/NRXDmXCzsl9ri5iB+Bf9kr+Y4AEhXuApsTaoCSWm6T1j/95mj4HXy0XF7VhJbCz+pdUay4Vvm+J1bG6/kwr5wcltYxFvdDB+2BTlw8rpX/66lsl5pjgCokWU35x2B/ycM8f9MZ6OSO+D5V8SlGfu+rFdc/nxDBnvWm43yO7NvJWv4d+PkmnygF0ylc1lheuyQx4gLscUNP8lLZXpb/305j9Bu2U8WzFsvtnwS5iVS9Lmvh8EFAk6BPkh2+tICCbdDgkMOWgnajeMbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pt6FcloHGt8gJAQDYpoi3ucjCbNbH5NVP/W4OUd8Wzg=;
 b=xVXFl+ofo3kcPlq4JR9JRZJLdOhZ33kb9rZFO3978O/9zncjP5OIkRfSW0lM/o3t/lxBn3gqnoHo7RhPWDiI01D2QObqBG3OFG4e/qWnxdxvPwEhThxM8qZW6s3zCYSFJMouK85034ROxdZw0y8q9s4nSuWbFkV8lCxKl1hwbYq0LCkGi7oZqdf52LpHPrM1vI//fPlGLlkEOuVEJxzkdFOaoyhbuNVQO/PBvl2vH9AShmOc6TNwy8znStegw/3A8mFpKJrZjbSZTsioRuY5hz0Izjq7SOmfupxajDqWMZZqAGYYzQnjSv0fndizRCKfnktKeqgMi9kMD1YwglCRng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pt6FcloHGt8gJAQDYpoi3ucjCbNbH5NVP/W4OUd8Wzg=;
 b=nPh8T0+pKqq24pBk1r82SLzMtRAC9qAZ3VaZ6NawmBP/Xeqsxz+yQWKekdKJ5ulVsP2PByjs7MsiJ/iiYvqGSF7fXRacTIxWxdD3pI/6s7YMha7dmxIR8YVy/JbQwaEjFFWv+fIaj7MMn63Ai4C2nLE58KpNpxerdouTEh+ON912KNezh6Qs096o3G2ZdQX6HsszyeKrOB0RgkmVuv1pLwGuVuReN9SeSc19CPVSayGUoqwimq60mg5P3pY3AnuxPbi94a0fvVSCKKmay9Hhx1TxQpCBHg4emsm8emUWb5c2iPTzsijej4R1h0D2YTeDXTOhv4DS7NjJiV1EdvFIPw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS0PR20MB5767.namprd20.prod.outlook.com (2603:10b6:8:144::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Mon, 29 Jul
 2024 02:14:04 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 02:14:03 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Guo Ren <guoren@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Chao Wei <chao.wei@sophgo.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] riscv: dts: sophgo: Use common "interrupt-parent" for all peripherals for sg2042
Date: Mon, 29 Jul 2024 10:13:33 +0800
Message-ID:
 <IA1PR20MB49531F6DFD2F116207C1397DBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <IA1PR20MB4953DB82FB7D75BF8409FFF4BBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953DB82FB7D75BF8409FFF4BBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [oJ9NJf110jF3GOzHE14+BhaR3Fy3NBoVJThuLwWNElc=]
X-ClientProxiedBy: TYCPR01CA0171.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::17) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240729021336.838887-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS0PR20MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: b298987a-011b-4c0b-c82e-08dcaf741e2d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|5072599006|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	9IMv4UyFMAcQzvP1COH2BkRogmqCgl1IN5sssJPs3dKTNEqqwSwllvZdt0hEOrb6Nhxtse27Mk7WCvGK7ZnXa0gtLVoQPEjFwIOrIhzWNMI7/ii40UQlrDbB5dZz1IkfTcE8y+TaL1JsS811iHRc+k2D8VzODEbYkqrY4pF9nOGTqA+7gl9Jxv/XVM4E9J9aPy6aD7VpBS+2/AM6KonQcK4sQ4rE53UmhFZjK6GEa1KvHHBjnRdsuFLtjJcjHvJCZWplLladI7nDAngODDje/51ovLiqGehuvS37t+PuvKx6ZtKcUcJraKsnsPfcopxHSESQiFkg9E476Gb6QfSSsM91bBm+ebECfjT4Kf0B053CBt01SAXO/yeEHBMY0LG2Sm6FmN2y4c6PrbDnZC6BqixLqXourrCypUCCv5doIbPWve+RodZ7weEFG3J0lMqqpz0vGtk78ZK+pUgcXiCU2jBQGznuUoohDyPWyVjvkwVFgQMMG4yWIiHDTk0PKowsNYinPm4A4bvHLCEyWjCtoeZLHUeBSpdCD0GpgPh7VfFQg9d9hHV4MGNOjkbmwj8XaiZr6UvpqZsmpUrFPBrqinS1KVt6RQ3/AclP8ZonhpiZ1OBz0n8B2tUKmztcTkcJhMEY9hX1mAAgHy7FpsXUABQ/fLXJEdGWCdLkR1QQXrZ1ioerdebbsy2aVoBhFiMM/zVrZmAB5p/7YCcd+nOknA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eWDfKt6AQFK2MVvxilyqxzc725ywxC7ZJK9BOODd2SAd0qQTxpo9zIXz0J36?=
 =?us-ascii?Q?PopbgObQYa5ML4iaLMsOfq/iOm9YNOtBy46Je3/poSjPMneAjya5BmUULP+J?=
 =?us-ascii?Q?AhZfvk05B06wqDU+MyubvA449QG3mSy8zm+tygR+Gtbg7qhsyR2vn/zUNvpD?=
 =?us-ascii?Q?p6KWudOjhiZbo+mxtjPVjKLrj4zXvLJIhjsrI2gBewaL568sCV4EaPRqd0xL?=
 =?us-ascii?Q?tveXB0srmwX9LaNcCNqxriVBnGhto05fTOP0MKAgg7fGNoYgv3odgQlU6y2F?=
 =?us-ascii?Q?RYdrRnojVLv48eVltUj3i9mUTKeLZDHHmxy1Vcqw2tqNrRvLp5YSBNxbDXzX?=
 =?us-ascii?Q?CjsVeODWdVdsfhBwps++Ae6zOVNP7jK4zUy62JUdACerezyNmLBXTy2OBBpS?=
 =?us-ascii?Q?JHg0wdSVD0nrkv6CMGYoK9WTAbwnyl0dYsUBiWRkvTmpgLqejk3tGH6/tw+D?=
 =?us-ascii?Q?s7oUf8ti9j1lrs5pRBkFEzzH3u6DhyqmaWBXaglK1q9PfcrQFgCHZKpo9TrY?=
 =?us-ascii?Q?amKTzF6NdMHH19uau2uG+HjGlg9SRzxUt88x07UeTB7rsyGGEFj7l/olkQof?=
 =?us-ascii?Q?IZ7ht+dx2+Yi3EMxpUfacfQEOe49FDHJnnOOeyI5GLkESs6FW4EmvHuVua30?=
 =?us-ascii?Q?Klziy30uhCQv7WBortsKSqneZvaKiZk67Ogv46ef2lHuMfyVWb+d0AqdlwFY?=
 =?us-ascii?Q?TDljBpYPZaf1nnfpnFCFpIIm1gstzBqX8ICnvhaqhnRCzSvLNVo+Alf7VN9C?=
 =?us-ascii?Q?KDDBjY8tPs898sDNnssFOOsjdD/48uMLh0kpI9brgQKYAkvNG1Tnm+8bAwqk?=
 =?us-ascii?Q?74WR99XAT7mJ9S5nIkU7vvWwi1CJPoU3LDd0725t573usdP+JKI83p6Wdjea?=
 =?us-ascii?Q?oi5f2k0dqk7lP4RYSu02phfZwkU9j7AbVQ3VcDoruDP2AALerd3PVVehToL8?=
 =?us-ascii?Q?FKqn2Jkf9ZibtXxNr8K/qDoXZhG7i4IX51Iwz81Z+Mcg8a7rQH6mliuJ/t1N?=
 =?us-ascii?Q?WEi+6OV52gU5yNqtyOsd6S8dGkwqywbTqq2fMRi3x0UZRyHr/F4IiMKX93+/?=
 =?us-ascii?Q?hnHQ+O9cFBHKA5tD2Rvs+c9X+nxP4qPUmxO3P4JCxE39vZlthOFPVYCM8ihP?=
 =?us-ascii?Q?IRy31++pL16GvzC5lC14WTmjcRShKeurnxj1cf9haIOe9OTm1/wA6C3L7grv?=
 =?us-ascii?Q?KsAosWpPu8DRPP7Uangyeb3EYKgbDhGI7H8l3FDlOxncT+ylRXRYesQ84PS8?=
 =?us-ascii?Q?4Z3mBfwgaym6nDuRqCLN?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b298987a-011b-4c0b-c82e-08dcaf741e2d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 02:14:03.8805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR20MB5767

As all peripherals of sg2042 share the same "interrupt-parent",
there is no need to use peripherals specific "interrupt-parent".
Define "interrupt-parent" in the SoC level.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index 34c802bd3f9b..c61d8061119d 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -44,6 +44,7 @@ soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
+		interrupt-parent = <&intc>;
 		ranges;

 		pllclk: clock-controller@70300100c0 {
@@ -388,7 +389,6 @@ rstgen: reset-controller@7030013000 {
 		uart0: serial@7040000000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x00000070 0x40000000 0x00000000 0x00001000>;
-			interrupt-parent = <&intc>;
 			interrupts = <112 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <500000000>;
 			clocks = <&clkgen GATE_CLK_UART_500M>,
--
2.45.2



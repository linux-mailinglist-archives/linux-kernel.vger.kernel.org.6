Return-Path: <linux-kernel+bounces-322178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D192972558
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 00:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C331F24B7A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE2B18CC07;
	Mon,  9 Sep 2024 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="I4SwhRDI"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2103.outbound.protection.outlook.com [40.92.47.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF6F189B82;
	Mon,  9 Sep 2024 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725921350; cv=fail; b=I/q6yYsd26G/J78rDyE0pBzvjmn1a2mbDuHYFLbsfmTUWMhvCPM9Z4iCY8l0c4Nim9wtUYntMgG3Mt8IwKZXJrkUJp2Z7TEcKEKvUBeFnzL+31yTFpG64veipvP/TaAG0iq19SkZB5yqSH/mOSsL6UEheqG8DBYMXJatBrofy8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725921350; c=relaxed/simple;
	bh=ySOIPdZbdAVjYvXYw1O18T/qKtME6F1NexjZy4K0Ioo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AfLRmi8mnRDZAUam9Yf+I0Oo95N6KkAXUdJC/NHecg37Y4xRSk9UgkdjPBp7JBDU/w3kGhaJAa1J2mS7LeuH7LYWrmjTemEDHNy/f/x8ovP2m9l5FN2sNbdSig72PWDjuGmb2xuQDC6D0WPKzs49ZuqM1nZVIpjGPiRHkeA/oxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=I4SwhRDI; arc=fail smtp.client-ip=40.92.47.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOJI8eghTUJFZ8ptEhtwk6cNv1hONE+cWP+pVuf2TsApTB6aOxRuA686umXMObkdWYE3lW3zTPXSHb0iEKRucBZdbWnZuDZFFztbazSsh/GFFsQOLdh/ryhpRFKqGgIFu/8MJabW4D+4i9xHaCFRhexQgxsiQYTbuqe5+RaFmM2mBce4VS7x0517vBYraGm874AQ0BWrWLdbXUGiWXoRTlKHjeoWKUI7e1MYOXHAGIrnMU8ROkbAd3HSKgi3hW1TZ2ErvVVlkiATWark0Aqv+rDAMA8k7rldee7AHLGD5yyzcCqQ7CkMU+4pZYLg3GmVEO/bcI5rC+jA3uN9iVM80w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5c2aj/TfUE6Fvn9mKZ5dp1a0LZQmZ1Xxq9azDwRQjaM=;
 b=wjeZfA/15+eEYRnCrQlAUnGZqvgrmHE3v8Y/9h2DBFcuQYIWYNwllWhhF1+I/D9d60gdJoxTL5FjKzt0hV3M4nDg7+7rjY7R65+R/QmPr9yplo/nj+ihKlijdsSWGyMKRqZVMjJz7yBbaGZ2cVpqN+a26cganXX/Cu+BAMbXeLbzDGIutvL12W9P/KI0Yg1OsG0WGleRA1T3+L4mZlJMdIMPJZ6+q2AoEl+LpYCb16ow21Fg8no1wA8hlkdTm6kxrBpgv9dq2qSmo4I9FL1FwsEffaMuevNizS4z8St5MCIzwVFHsYyHBQ/Lqn+TdThipKl/ltJGJrVb3PwkxzVYCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5c2aj/TfUE6Fvn9mKZ5dp1a0LZQmZ1Xxq9azDwRQjaM=;
 b=I4SwhRDI7J44gctd1jPsNAN2DWB3dy1X0aRund42SrLvcZTpZCwA8IjAJOYYMZRmot5PGaVYaQpaFFugAkWO+nG67+kQPhOhTw4OJcDo0n+F3P+A1a8fL78XzRY43LHg8uoGavMrIq3UyAhzPZSZJROYlBt12pU00NR4GwvGXUdIYjVcNolappoRXEUiR5rzqDqqtoDBmYoxGVR9EG+DkKw9whjKoKVHXKqqzI7x6CKhFW5fluA4h5oELAeQr6NNRIALnEyk2ZYN4yz5yFpsVEvmDGzuJp+At0t9DfchoxurBIH0bEvKqJu0Z+HA/tiVhw+4LrvpMtWnP78o140Akw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH8PR20MB5195.namprd20.prod.outlook.com (2603:10b6:510:1c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Mon, 9 Sep
 2024 22:35:41 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7939.017; Mon, 9 Sep 2024
 22:35:41 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Haylen Chu <heylenay@outlook.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] riscv: sophgo: Add pinctrl support for CV1800 series SoC
Date: Tue, 10 Sep 2024 06:34:27 +0800
Message-ID:
 <IA1PR20MB49538E389C866882FAF35B8CBB992@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [U4lnD7fs2zrgdyt0qDoC9g9Iv3q4f8A7ssxsX4ALygw=]
X-ClientProxiedBy: TYCP286CA0219.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240909223428.31064-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH8PR20MB5195:EE_
X-MS-Office365-Filtering-Correlation-Id: 2320a47b-1cd5-46a8-c094-08dcd11fbc09
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|5072599009|461199028|15080799006|1602099012|4302099013|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	WUZbtRNbh5dmcellRKAxz+Dr/F3rD9rIpizXm7L7pi3oR02Vfoz+88GBzK3iRDBAiHYlE4xsBOA+A1DEDRdevCyLkEYhQK0/2G4AMsMxTh0sx3MSbczaep9EfXrLCjvJjH4uI2BPmKlEhEYRllKVorsEW/v3gFqSuYbnbP8MF9dnI98mGHonUCjkbRDJHorqIq8O3A33hI0jaeenBK7dE0u8chLXyC7Sbyrt/Kk7PhLRgupY0Atp6t4AWtNwG/lDeflr9SclwSPP20ol0jTh1SAY4FaQAJi2XwLNKDL8UgfSQgpdXPAN0KwhR9MGfWrQs0/0FviCNIVdCn1PnEJfTvoeTR/8w6AIEJXrvG2J29Hq9e1XJimMvRC1tdlNxgzEI19OIqIyFLCmzJGhfrd/udSkMSHdigaFIxhkM3dy5pOkdOvZ41WFPXJ8xuJw1p6lpaa8S1I/mb+axNFLCM3WxwKdXN5Nw1VrP7LTwCqPou4/uXIwsvIIMGwUxzh6/OxRyxX6DrnA2vx9uXqliQuwoD6NCBeHzZ6pMkYhS6TJ3NT+2gCcQvgsE99M3aKRcWKHLi0LauhshTSarqRPvkklA+Skmj0wsoVpcw4Vrm74ZFP9kGACCgzg7nW/ywSvkOXSPJ3OAb9q3liZUNsC1XDNSqunWO6xg1dravXyoyB6XTFHmhcWAaX1HjbfcNEWM/ZAbUENRDtc9WL2hgjIBw/XLEBFlP4LciV5L3WKyd1b+V2p5xh/Gu8XaZISUV2COD+/Lh4vuPoqwS6HZ7rl7gSnrq6R+M1m9f/D5+Jvub+9EEjTei2ogdiiYPwf1xKvxcgCN1AUvPcudDJlIH7Ge1RT0t4bQc07aOAdeb790daG1jgmq503pCm+5mCx29eHntFLAx4XRgZcRZUt/KvJTdtoAQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xQK2cUG1Qs4gUKskmu5wzRTvSoXWMNU+zdIvM3L26Vxym8C/AKP5OAq01Mwh?=
 =?us-ascii?Q?odx+OUCPmlP+lgInczGwvc4vn+FtOIemiJJbjICGq2+MK/RgqG+epiMi0Pkg?=
 =?us-ascii?Q?usdQlDiQSUIW/QV2PerwD2k1BrqWAdeofFNgfUP+f28OmaglsYmj44gx0p9B?=
 =?us-ascii?Q?3rfNnXJc0sWxTLx6dWwrGbh+ECnOKcdJRDL9IQivDte5TQCCHRE6oUTKn11r?=
 =?us-ascii?Q?PpJbwjKllOSG4iPEtH54GfId03QpgRVeGqZzdFdEgGKUmpf1zJk0VtT2E6bw?=
 =?us-ascii?Q?vb39dP+mGtbhc5GQBSklzrK23v9Xx2T8mocabHnQG78fJEjRJAoZ2uOsS+tr?=
 =?us-ascii?Q?/61T/d9jBv93uNVsberC9RPmc8NgOD7cz6sgQIiRPrBk9VX3oOwFW57YVF3U?=
 =?us-ascii?Q?+GbLfGo2w0d65eNb2LkqxAPlzKDNGdze2X89WiODwrvhzljZxgnr1J9IBjm9?=
 =?us-ascii?Q?dAk5SdANY8mGNKZEn+vxn8g3+0AZrgmfKa1yampnRF5Kuu5AHLYpv+wtXfOf?=
 =?us-ascii?Q?Tgdnu9ZyIfTzMO8/5vO2sUvues98caycSIFumW7cjendEOYEPi8snJLnV2z6?=
 =?us-ascii?Q?QpSRM4JD4HGYxSh0xjDICqukqB1g4DaWx8AYLMUQJsH1tHuPi0Lamz2fKuYC?=
 =?us-ascii?Q?M4uXuaWF0rLCxpuhTMKZpGFnnYFEBpLSO7gYhEwOTYs5+sHFfr/GzdHC46sK?=
 =?us-ascii?Q?/Pg43rdXZWibjypCQeDTcu/p7rmSYEZfC5EPGc0vYX/lZyqaJeYZwdfJ6WXP?=
 =?us-ascii?Q?95Egs0/unkDo1pLY9rOHOFvTzNUo7caR8EgfTGfpSY5LTnlBAIqJUyfCDCoX?=
 =?us-ascii?Q?6JVjtC3fZQilqALY5VjFK91w9j+0bIKtLoH2834K9mpOqt+b4ZUUC0lZ0gKj?=
 =?us-ascii?Q?7Gb95sLTVFqvhRaBOky91eIZqoyXxdU7rfKAeYvWtQDajJZR7kk2gXEJKqCC?=
 =?us-ascii?Q?myygO+JFwXHIXHCsl6EbYyjm97mxLuntxDEM8NNCykDVtYFWdeR6F6iO+8a6?=
 =?us-ascii?Q?3+nb1RIDuJcgDmC0UhpZea9taFH1JhQ8xYObBeXNSb4vivCWo1l05BiJyGDf?=
 =?us-ascii?Q?Z3dDfONKo7dErzRQhBp2krRBDgCjwCJnWmEBISj14wDzuwqK8ttSEfkHG3/4?=
 =?us-ascii?Q?O7ZrMp/Qiz55tkNQ9/aQY2fnIB/x/1kNwbLVYo/rFbg8lM+5XEQUU9PAlZjP?=
 =?us-ascii?Q?4yEd4s0cEPbCG3iQn1bLuf3+yfWukWjI7Gv0vk3hSOVFUtFVWKnfuQ1ovUIT?=
 =?us-ascii?Q?N4iWHXaT9IGoRY1wGD3v?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2320a47b-1cd5-46a8-c094-08dcd11fbc09
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:35:41.0397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB5195

Add basic pinctrl driver for Sophgo CV1800 series SoCs.
This patch series aims to replace the previous patch from Jisheng [1].
Since the pinctrl of cv1800 has nested mux and its pin definination
is discrete, it is not suitable to use "pinctrl-single" to cover the
pinctrl device.

This patch require another patch [2] that provides standard attribute
"input-schmitt-microvolt"

The v4 version is from [3]

Note: As current documentation is not enough to guess the pin
configuration of Huashan Pi, only the pinctrl node is added.

[1] https://lore.kernel.org/linux-riscv/20231113005702.2467-1-jszhang@kernel.org/
[2] https://lore.kernel.org/all/IA1PR20MB495346246245074234D337A6BBAC2@IA1PR20MB4953.namprd20.prod.outlook.com/
[3] https://lore.kernel.org/all/IA1PR20MB4953DC78BB0FE0C57EA94F91BBB32@IA1PR20MB4953.namprd20.prod.outlook.com/

Changed from v5:
1. fix dts node address.

Changed from v4:
1. remove the alreay applied patch
2. fix 1812h header file problem.

Changed from v3:
1. binding: drop unnecessary type
2. binding: use right ref for pin node.
3. binding: remove mixed spaces and tabs.

Changed from v2:
1. remove unused export function.
2. drop "drive-strength" and only use "drive-strength-microamp" in
the binding.
3. drop unnecessary ref in the binding.
4. drop unnecessary entry for binding example.

Changed from v1:
1. replace attribute "sophgo,bus-holder" with standard "bias-bus-hold".
2. replace attribute "input-schmitt" with "input-schmitt-microvolt".
3. add vddio operations support to report pin state.

Inochi Amaoto (2):
  riscv: dts: sophgo: cv1800b: add pinctrl support
  riscv: dts: sophgo: cv1812h: add pinctrl support

 .../boot/dts/sophgo/cv1800b-milkv-duo.dts     | 49 +++++++++++++++++++
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       | 10 ++++
 arch/riscv/boot/dts/sophgo/cv1812h.dtsi       | 10 ++++
 3 files changed, 69 insertions(+)

--
2.46.0



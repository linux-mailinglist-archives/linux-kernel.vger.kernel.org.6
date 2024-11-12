Return-Path: <linux-kernel+bounces-405231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED329C4EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC0B1F25004
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 06:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB32420A5FB;
	Tue, 12 Nov 2024 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="FDzoeasR"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2126.outbound.protection.outlook.com [40.107.21.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2AC2038C3;
	Tue, 12 Nov 2024 06:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731393719; cv=fail; b=WUa8InF+5A7bJRJqa0hGKKxcBMMHoBYHgbb9aSgFHvvUxuf7rpG7NarlqmMAA4SFfbssSo+m1zyarGX1Eg9EQ+FlgA4/gXvRm016vk9ouf5hpePmsBPoI1j6sckCNOiqPxjpCRsnAgpf5Q1PVpB30dck3e409zaBGMfVCktVBmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731393719; c=relaxed/simple;
	bh=2IUxhVx4+QhUYEOJVzldKwi9BTM8+aqCQ9WkmisU0Qg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=CG7ph8qGL6vj2tZrwvXHbcEKCiuRXZR5E9X/YF96NQgDdztyTtDhhNS3bsHjBnaF2XKNZQSY7XqO7c3Z/WXLjU/hixTvoWhi/LfWaVQhTTub0lakqu8AOpwlfsJw7r2oET+Yb0mwBbKaJTQSShtrxguV6hUmPvMZsBc8RpiMvNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=FDzoeasR; arc=fail smtp.client-ip=40.107.21.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YB9qkRso6H5e0bZBrFPtpZiFeSeuWmAVUM0qBxzY0ldGeh6gBOTbeUVjQ4MJ9aT6QkFU46RzkvJ6UVRexTnXPDLSmpK03S/JxTnXgKfIF+ObPEpbsaY2/eFigHqpHgANdODtwveHwf1QCpiW4VuuMT8tU5GPNQmGFy8EHA/ig+5FE996eaDwe6btGDOvLrSn06CUx3ElfLPQzOXn3WB1jO1xdgZygA+3ZpSduEa9/NTucmRjc6tp1kfapO9zYlwBep2KXVrIQH5dFNFmRzkbRVtxa3QacYMiBgSA68HIiGOgeWz6YhYRH0EaB9R/TXw6jSB9om2KrXYkFYh3jlIj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wwx46hUc+JITaPM/J9cxfHmkLSgKxq4hLxxMn5dJUo=;
 b=eEQUTjDxrAMfvaFiNctK336n0XclwS5wqCNco9dbcnm4mucPWjKu6zEXxLIUCy/XNmgzU/+WWfqUVFXSHWkqbkt8dfeQ1HIl1U0TAy6bozvhUv4sENvqWaxI75ebHEMLND0D6QFcE7whQGwWeEU6X04tmiaIcW+riZvcxvoxdaAxtt72MHXFQEhr5Kf7/7zzbORO3Ylrf/UregmzUR+6QoTsHSJIWPnCHoAiVNP4LbivPtNrP2MBLj8n9oTJ0CSCwUZAZnFRhKtoAIkk7NMQPZ3qurRGjJQbPfl2Elx5TLZ/mZUYpXnUbo3f8ulFUZnEjddMyzCqrRlEHOV/Ra21VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wwx46hUc+JITaPM/J9cxfHmkLSgKxq4hLxxMn5dJUo=;
 b=FDzoeasRNSl0qy6xaS7f+wXcSjY0Ly05m3T8dtKGgiYKciBgX6b95JLmEpLuiOLBSnDBms5X9sEpdY2X8AG+WnobDavQlfebjum8BWWC7I3i0k7AZHQABvExVTyyNVNG6nTT9RbHCTMpeMUKWdjzdmuUZ2cDfFBg2Bp3y7eY9D4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU4PR04MB10959.eurprd04.prod.outlook.com (2603:10a6:10:586::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 06:41:53 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 06:41:53 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH 0/2] of: add support for value "false" to
 of_property_read_bool
Date: Tue, 12 Nov 2024 08:41:31 +0200
Message-Id: <20241112-am64-overlay-bool-v1-0-b9d1faff444e@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJv4MmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQ0Mj3cRcMxPd/LLUopzESt2k/PwcXTODRGPTlERLY+M0cyWgvoKi1LT
 MCrCZ0bG1tQDqUwsdYwAAAA==
X-Change-ID: 20241112-am64-overlay-bool-60a35da933f7
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Josua Mayer <josua@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
 Yazan Shhady <yazan.shhady@solid-run.com>, rabeeh@solid-run.com
X-Mailer: b4 0.14.2
X-ClientProxiedBy: PA7P264CA0446.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:398::29) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DU4PR04MB10959:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d41947-929c-4966-b521-08dd02e5182f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yk9DZzIzM01rNU9ieHVGUWdYNE1mOTZaajlDb2lXVHc1OVRjbTJSeU9TZnBs?=
 =?utf-8?B?OTFqZ2NUTjZEL2cyMXlBbU5Yc3grQ3k0RUNqdmY4b0VVQXR2RU12eTN1SWo0?=
 =?utf-8?B?VFg3ZWJQMlJqZ0ZBMDg2enU3eVI1L3RpeTlDL29uUXYrVHFvZzRVblN4T3B4?=
 =?utf-8?B?ZFdFZlRURUJ3aXRFelMvK2FTMDZrcVhpMllwNDlRc1ViT2FCLzhKR1NocTJ6?=
 =?utf-8?B?dU5KZ1JUVE00Nm9RNlQ5ZFN2ZTh5K1ZhclVSOUU2Y1NoVlJQQTB2UDFGTHp0?=
 =?utf-8?B?Ni9WNG1qZ1hFbDhFdXZYams1WHhLZm00Wmt5VS84Nm1qeGRpMWkxekFpbHk4?=
 =?utf-8?B?ZVpBK3I5d2VJeVVOdmphVEhEUTl3dmFEWUVzRXBQT0ZIMVV3MVJqZlllWHU2?=
 =?utf-8?B?UUdydzhLVzc2SzI4cHFzZkZ0UzdVRzVYWnordEJPU1VMcVcybG5IVWo3SDRQ?=
 =?utf-8?B?UFhHM3kwek9QWC81cW5aYWR5WVRRZnNTWi9jZys0TGVHeWZac3B6WmtWcjho?=
 =?utf-8?B?RG5panpCZnJoSEQ4OUhDLzE0TTdzQy8xU1YrYUxoNE12Y0xySDZPWkVGR2JX?=
 =?utf-8?B?ei9EVVRPaDI0WERpb21FNGRwNmEvNGtiTkN4d1VkYXczTGlVajg5dzZrZ2x6?=
 =?utf-8?B?R1E3N0Nrbzh5TUs0cGNDNnpmZlBjWTRjZmJzSkx1VmlVcm8venkxbkJvWnQ5?=
 =?utf-8?B?L1dYOGVMVkhzbXZLVUFVUEJuOFg3Qkl6cTFndHRFSk5seTgwSEcvK3crdzJ4?=
 =?utf-8?B?dGZ6b25WeGRRdUJPb3M2TnpBcHFWMHRIZXpOWm9IbXZ5RFhsb2VXOE40cFhS?=
 =?utf-8?B?WS9lWjdqQ3JveWZaU3QxeitmblBpRm16OTNXajVyanNIb2IxalNRdVN5MW5Q?=
 =?utf-8?B?bVZUcjNVeWFkNU04djNrbVpPUkU1L2FiRXlmMDBWVkdHcUZyeDBNVXFNd3R5?=
 =?utf-8?B?U0hFaHhrN1NJOCtyNHBtOFZCa1NVYmFQNURIbHMrRFJlcm5KeDB2REZMaXVn?=
 =?utf-8?B?dm8zN1VqUjkyeFZCUzBQaHJmTDg4U2c0TDNNZUVIOXFpa2NDVWRvWVVKRnUz?=
 =?utf-8?B?eDBtdU1OU0dYZno1TTdqa3VXc0xKT1k5eEVLMWVEU05mank2eGhKZ3Jha0h2?=
 =?utf-8?B?eTlOckQ2QytHcm5GUVo0K1RTbTdEdWpUNkQ2bVp2V0ovenlkNUp5dHU5MkNH?=
 =?utf-8?B?SWVFbXgweUlzU1g2aXZRY1Q2TTlIbm9aWDlxb2I2dENDVFR6Z2JMQXhzY2VG?=
 =?utf-8?B?VTl5QUlMbnY2U2JobnNJdlR4TDJ2a2hFUmRhUEZ3bExiOEZhKzBodGxXbndS?=
 =?utf-8?B?cjVzcDRYdzJYQm9MQU9BcFQvRVYzcUJZZ2MxQ1pqMEkxYkRIcmlsbHA4NFFY?=
 =?utf-8?B?VmQ4TllkQXFWMW1SREtZZm01YlhuMGNyOGx6YUwxbVUrUG1QL0tLVkpDMHNp?=
 =?utf-8?B?eUtnUHZpUkRRTEdWL3J0Y3RMSXVFYm5pbkhBUTRyKzc2b0ROV1JYOGdBcXBY?=
 =?utf-8?B?NGUxdjM2Z04yTG1TZmprMThZZGxyNnBya1hqRkNQckNvS0xrdlJPQ0N1TW5N?=
 =?utf-8?B?VEJHNGRTUFhuK0UrR1FXbVI5VUoyMGtpelMyMVpLOTRGNC9HZnFwb0lmMVU2?=
 =?utf-8?B?b2gyeXUwcTZGY1ltMFJ0QUsyUUk1cTNkaHdxWGFrYXJZV3lrUUJhU0I0TWdR?=
 =?utf-8?B?TkhUdy8zMVh5VTVydTRoVU9CYWJmRHBIZzhkc2J4UTY3SWFqZ3R1KzR1cExh?=
 =?utf-8?B?UUYrQ3JKUXBlMG1oWVdXdzVDamZqVWt3a1BQS2l6TVpHNFQ2Mnd1OWdlU2ZW?=
 =?utf-8?B?N29zc040Skl0MERGV0JoaC9zL2lzWEw4UXM4RmNKSDBsblExNmFtWTZXemlV?=
 =?utf-8?Q?OVA+WGvL+2oup?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T29rVytVd0M3d3ZGaE9hTUlEWGUwZGtxMnNIOExDUXdoMEQvZXJXa2tlV2NU?=
 =?utf-8?B?UEZDNGd1NGp6Q0ViMzRaWFpoSUQ1ZHZKL3hwSFg3MkgxZEJ3anlhUmtDd0dx?=
 =?utf-8?B?eHBVcUdiVjJHNllieUF0MHdwdXVwcFNFOGhiRkg0eEpBa2tDVG15c2FhRE8z?=
 =?utf-8?B?SlBaYjQ2cTRyaFQzWUd2azYxa0dtcDVVYzIvaFlPblVUS3l5MmlrQ0lndlpu?=
 =?utf-8?B?YlRzM2U4WGtzR1ZpbVZ4ZnNJUE1KS1JYM2JRYTdYelBnSWI3RXJtQXlnbFZa?=
 =?utf-8?B?SHJLaC9nSE5WblRoeTlqNXN3SThMKy9tYmkyNzFvYU5vVzZwaTJwd3E2aDE1?=
 =?utf-8?B?aHdDUmw0L0wzSVJjM0tCT2ljSXRaRlM0dTI4SnBYdjdVdnc1TVhJWTBaRnJV?=
 =?utf-8?B?MThHZXRVQkhjOFZacldveUlqT2FTVUNJcEhQRE5LT2dkRjN0YXBQMVI3SW5r?=
 =?utf-8?B?R0tUZzZJQjBBdTVxZlF2bzk3OGZkU05JRkZtblRDU0F1b2d5ZW80N0NkRlov?=
 =?utf-8?B?T09JRnJJYjVEWFVvd0FZL2ZHNXhTK0dKbnlqSEgwK1VDUW85Y3NxRlNZb2tW?=
 =?utf-8?B?UkNndXByek1KU2VDelBTaEJvM0lyR3VLUURpWjVoMHNhWXRxNmk5ZDhWQVRj?=
 =?utf-8?B?VExXQnpnN0Y0OEVJSEdYa3E4b0hIYWtxWkZGRnBtcmRMUUpSNnpCM09pdk83?=
 =?utf-8?B?VW5mV3N5OXhXN2lpeEZ6N2hXLzc4bVVFdE16c2xGVWYyS0RmblVMVjJUTDVl?=
 =?utf-8?B?dDhYTFRYM1RKMER6Mmpoa1VXUUFkQWV1SUNxaE1LOURCbFhuWnFXVkdQVjNk?=
 =?utf-8?B?aWxaYlo2SHFPMy9VN1h5WHBicWR5a05RMW0wclNWS2xlSjRXRkRzZitTamQx?=
 =?utf-8?B?UnJqMXZ1ZEZGM2szVXozYWxSK1dlZVA3QmQ2d3VNd3d1STF6T2hvMzdKVWxP?=
 =?utf-8?B?enFpbldsQS8rQVZqWjdITjB2bU9vWXRMUWpGVm4rcjZVM1ZscDU4ZkwzWlUx?=
 =?utf-8?B?S2hpRWtCZ2xkME1GTnAyN2lRb0hCakJkZmZiQ21VNnpOSk9ublFheFh2ZUNr?=
 =?utf-8?B?enlONkN3cVA3RHpIRHBOenlQVHdPVEtrZm93SE93NzEvV3p1M3JKbUUwd3BY?=
 =?utf-8?B?RzQwdXJWVHVkMlkxVDZHaS96SmRoSlIyM2xuanMxall3RHJERUtyWW1PRkR5?=
 =?utf-8?B?QkNubEhtWTBlRjZ4aGtneTJmRDNGWkxLdWRqRmkyZUJrMWNRbmNaUjh1V1RD?=
 =?utf-8?B?OHNCUUxMNjVmUjV0WWRRVXYwNmRnSTRVM3pJZUFaWlVpb3pGeGxyOGVtLzF1?=
 =?utf-8?B?WmxZY0E2OUJ4SGdMLzRHM3Y1MTRYZmQ2cUZYcVVTT20yS1ljK1lmUUFaWkVm?=
 =?utf-8?B?WVRXM3E2VzhDZVlCQ3NMSHE5aDZ1T0o1YmdIaTNMaWpDRkcrM3k4cWdJcmF6?=
 =?utf-8?B?NGtTTitGNm5hUDRkZXNRdCtZN0tXY3N1MVZUYXQzMVVzcVZMOXRGdEh6bG90?=
 =?utf-8?B?UzJuYXZsVDFLZ0tla2w3R0VzZG9NSVorcVRGazJnbnk3ZlpOclMzaXdwdWR1?=
 =?utf-8?B?c3E3Rjh1ZzlOMjZjR21tejg4d2ZQdWtpM1ZhRGg4MHZCZWZ6L0F3cDFjTjNU?=
 =?utf-8?B?Vzh3RGw4M2FzeHkvMWR4MHdiZmlDVlZIOGpvTjlSUlBLME1LRXBNYmZtTjRW?=
 =?utf-8?B?ZGQ2UXZuZGsvQTBiL3JRd2RiOXB1dExOODBEaW5MMGs5THNiNmVJSW5QaXY5?=
 =?utf-8?B?OXUwcll5QTMrK3JTelRzZVBzYlVVYjFzNDdTQW9YYWxyV0FGRHJaQ2ZjNXNu?=
 =?utf-8?B?c1kzZnBVU3VUZVFiWW5SeXB2clc4ZjhwazlpdmNwWjE3SDcweGVJR3lSb3V1?=
 =?utf-8?B?Zk9QVEZXNGJieUt4OGI3bk1pRjRNM2pKU05CSXcvR0J1RGlSdEI0ZHV6ZW1o?=
 =?utf-8?B?VTl5eWJXREVic0lNQTlRNlk3Qjh3QWM2WDJLTXY2Q3czQVIvbmVYZU52dDVr?=
 =?utf-8?B?MVNXbVA2a01Qb2xCVHhoNnZ5U25LL2c2NE9rcng1aVF6U2V4V2puOS9RVlZC?=
 =?utf-8?B?NzJzUFRtUlJ3dmZJdWdvaDNIWEZMZjZvSG1hRGRacUpqelI1S0c3eWMzUWdn?=
 =?utf-8?Q?aXIoweVvy0O1BWwQ51111ibpZ?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d41947-929c-4966-b521-08dd02e5182f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 06:41:53.4511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQyLbP71e1xPwPfuVtWhUzEoV8HK9Q72U5Y6/Iu6uI3RJXPTc1k5kJuUvZTU+8JW1wiigW/RTQDD5qkHlgUmtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10959

Boolean type properties are usually considered true if present and false
when they do not exist. This works well for many in-tree board dts and
existing drivers.
    
When users need to overrride boolean values from included dts,
/delete-property/ is recommend. This however does not work in overlays
(addons).

Geert pointed out [1] that there are several invitations for using
strings "true" and "false" on boolean properties: [1], [2], [3].

Add support for a string value "false" to be considered false on boolean
properties by changing of_property_read_bool implementation.

Affected by this issue is AM642 HummingBoard-T overlay to enable usb-3.1
function. This is an alternative solution to dropping
it's disfynctional overlay [1].

[1] https://lore.kernel.org/linux-devicetree/CAMuHMdWY0J7uooeRbUGwjkeCLd2UVyN9dtDWUkg5pJ3sAULdsQ@mail.gmail.com/
[2] Documentation/devicetree/bindings/sound/rt5651.txt
[3] Documentation/devicetree/bindings/sound/pcm3060.txt
[4] arch/arm/boot/dts/ti/omap/am335x-baltos.dtsi
[5] https://lore.kernel.org/linux-devicetree/20241101-am64-hb-fix-overlay-v1-1-080b98b057b6@solid-run.com/

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/linux-devicetree/CAMuHMdXTgpTnJ9U7egC2XjFXXNZ5uiY1O+WxNd6LPJW5Rs5KTw@mail.gmail.com
Fixes: bbef42084cc1 ("arm64: dts: ti: hummingboard-t: add overlays for m.2 pci-e and usb-3")
Signed-off-by: Josua Mayer <josua@solid-run.com>

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jon Nettleton <jon@solid-run.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>
Cc: rabeeh@solid-run.com

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Josua Mayer (2):
      of: add support for value "false" to of_property_read_bool
      arm64: dts: ti: k3-am642-hummingboard-t-usb3: fix overlay boolean value

 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso |  2 +-
 drivers/of/property.c                                    |  2 +-
 include/linux/of.h                                       | 13 ++++++++-----
 3 files changed, 10 insertions(+), 7 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241112-am64-overlay-bool-60a35da933f7

Best regards,
-- 
Josua Mayer <josua@solid-run.com>



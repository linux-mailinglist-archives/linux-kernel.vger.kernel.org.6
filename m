Return-Path: <linux-kernel+bounces-201918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7348FC543
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C821C21E45
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90EB18C35B;
	Wed,  5 Jun 2024 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CP9wWpdj"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2045.outbound.protection.outlook.com [40.107.7.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C8318C35C;
	Wed,  5 Jun 2024 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574250; cv=fail; b=Fq32ayiWH0/ViMJtp/d11VnBq5+I7drHhI4FwG1zlALGs+WEeEgcGqyZP5BCPeTqyXEy22nn5/cY5TyQvy1thquR4HeaBbtY07MgoPPcji1qqgdbX7nu/zYkldZ0ddmXBz/nxbOC2C1beuCnvgawH+GJuk4eZIyPVf9tt5zgpRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574250; c=relaxed/simple;
	bh=Y2LF9/L2pcWWC8bV3kFIeBPg7yFtwM3Qs3LUL5N93P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R97vkV6Yj2YjQeRhdrmWICeifKfjZiBgwFkEPpdytNu9jhW7hMjP9VHi0DO3WD3IWXBrakDlExuIbMXP1iFBRnpuFvFpMCri2R5UIykQ1DEZJn1DkHT5Z9I9n9k8wQLBCcdH7PNi0tFMejXHumlWV6pbSTDfhuSlMM0n/WrkV/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CP9wWpdj; arc=fail smtp.client-ip=40.107.7.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6Qqfk7QCAiqIWxb58aELIuC22P0ESAOyXdmJ089dAuJLU9mUVCbrsWq/iEK3HbiAKmYNoMAC7N74WvP7kAapdoSLMLvhTAWBSw0d/OlyQohsJzD9i5LdUtwd7mcGD70rAhpXHZVXhr8hlB4tizrFn3Adiy/NzVRVvoQY3s1YZjZdftb1RPKrzYResfPrrOnRgzSYmAjMBecSkKT/KfkrE4NN0w8ta84D7Yco214bqEukAVQ0eyY1i8WAX3SuZxmwwEw/dOUUbqwWK3/gmbZVmdWgUAvNZbQ0QFkR7QTDOoEBN4LoWnpLzhsCW7wpH4w5IEmm/SgQZxzqyPUGtlEhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H63DRPxoNMzVC2rkzoAaEx9JVklJgMs1I6DRKzjRkQs=;
 b=RxZ0/lmARXlQoyDHVBeW9pSsKz4oTkm3a5YD6D2BxqGauNntcU6CBNUpGllTWZNnjLqRmHSI7GkclfZZYZTTf0qigRCYAB41IFTCeHvuf0oQSuKCVATlebfi87hEspUXHiXyfI5gLmWbvPYtFHzN5elEq82CzN+06gq79kt74SwKuYSnSYb76aQLv+L3E5SSBoNaJsE/ZBF92p4xq5jCqll6JmDTnRNL+KuYdel+uldxFI3NOB6H/UdS/i8UZH4EYVyB3JL3H2g6l4j3R1x3xoJAnrhAExODYFaPz3TGsrbi+aFMoQySASwHbs5sX3DiKrsdesA1j9XrrjmPxnE6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H63DRPxoNMzVC2rkzoAaEx9JVklJgMs1I6DRKzjRkQs=;
 b=CP9wWpdjJCISdIRI3J+qMssqmvB+VQ8CypKogPjroTb3GkYdlUGUkOBSvPlRXLP4MJ9e+lXM9sB7yL37PWrkOIj4J+oi8jWsjmJ4DlPSYEfOur9LHa5nolL+bn3C+OtXkUlZ8JdmrQbcn9nsVt311cxuVP1LqCRCZhRwH/anLrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by PAXPR04MB9277.eurprd04.prod.outlook.com (2603:10a6:102:2b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 5 Jun
 2024 07:57:25 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 07:57:25 +0000
Date: Wed, 5 Jun 2024 16:59:38 -0700
From: Pengfei Li <pengfei.li_1@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, abelvesa@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	ping.bai@nxp.com, ye.li@nxp.com, peng.fan@nxp.com,
	aisheng.dong@nxp.com, frank.li@nxp.com, tharvey@gateworks.com,
	alexander.stein@ew.tq-group.com, gregor.herburger@ew.tq-group.com,
	hiago.franco@toradex.com, joao.goncalves@toradex.com,
	hvilleneuve@dimonoff.com, Markus.Niebel@ew.tq-group.com,
	m.felsch@pengutronix.de, m.othacehe@gmail.com, bhelgaas@google.com,
	leoyang.li@nxp.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/5] dt-bindings: clock: Add i.MX91 clock support
Message-ID: <ZmD76mp2dPVv6HeA@pengfei-OptiPlex-Tower-Plus-7010>
References: <20240530022634.2062084-1-pengfei.li_1@nxp.com>
 <20240530022634.2062084-2-pengfei.li_1@nxp.com>
 <20240604150306.GA596314-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240604150306.GA596314-robh@kernel.org>
X-ClientProxiedBy: SG2PR01CA0170.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::26) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|PAXPR04MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a37b75e-3ba4-4b99-4527-08dc853521c3
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230031|366007|376005|52116005|7416005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?S2dmL3k0dTRialRESld5RXZZcVlUUEV0K2VMY05WYU80ZW00RjB3bWZob3pq?=
 =?utf-8?B?TkQzT1VFZGFLV1RsNEdxaU40MTl1L0pWVjBBVUFYTlNmcjg0dWVkNHFOb1dV?=
 =?utf-8?B?ZHFZckMvTjZDMFlIOHlReEIxS0o3ZDRoTy84a1RRN3E0d0hjaVByUWUzZzUz?=
 =?utf-8?B?Z3ZPdFVZZ1pHaW9OdWtwblNKMjdzU1dadXh0RTNpUUxFNFY2ZXl5WldvVkZJ?=
 =?utf-8?B?b09OdVBkeW5TNExSZ1JEWi9MelpTc2gxWDJCQTN1bGxIa0I1TGRaV084S1RJ?=
 =?utf-8?B?SGpRNURjVlF5Z25MbXU2L2ZoeU14WmpKVFkzU3luM1kydHlzZG5hYXhMUFlr?=
 =?utf-8?B?WjVDUmRRSXhtK0dlb2tjY2d5MzliN2JEenpKYk94TmlQWGdtbHplTEtaUFRM?=
 =?utf-8?B?SUZ5RFhjMWw2UGU0Z3JzaE1GRStuSGdKS1IwNm8vbzlOUncxaWt5dUdScG53?=
 =?utf-8?B?ZFdpNkIwZkJVYUFoTXdUS0Q1NE9sMlVTWUJtUjJyd1RTT2FXNGdsbElmU1JK?=
 =?utf-8?B?cnlFS1BnVjEybzhHdFROdVVhTmRMZktSM3FwUDFSZTlhc01OcVFEUGQrTmpo?=
 =?utf-8?B?a2FQNkNYcFRUV0dLSVAxRXNndDBSMW5LTkxjZUdPOHVicTZLSmEvTGI3WkFk?=
 =?utf-8?B?Z2JuZWg2WW9Id2NNK2lUWlMrTHhzZUlvallxNnk3Qnh2d3FXemI5Z0drQzdY?=
 =?utf-8?B?djlJT3lZWGFKb1IyVU5RYzFEKy9hY0p3MldXVkszd25vRExzcnh4bmNpNEZk?=
 =?utf-8?B?dElLa2o0SkM2ZWJ4NWcvQjZkd3IrSWtmd3pZU3krMndZRXpqTkM1MWh0TVV0?=
 =?utf-8?B?VlJ2N2c3Y0dwZXdRVlBYejVMZjRXSmM1QWZRTjlYSkljQjV0TFNIOE5wUUxr?=
 =?utf-8?B?a0hVUmFXVmMrWXgxVEpIeHhrT01GUno5NlYyNTF4WkRNWis3eWxDNmxQVlZu?=
 =?utf-8?B?VEpwYUk4MTdhTFpXVGdHYjRpczNWYmxIWnh4dGFxMHZWTVJ1ZjdsN1UzWENz?=
 =?utf-8?B?ZC9XU3NUZXhicjIyRC9HK0wwam5BSUV6alo4dHIxMlZtWUNXUW1vVTNYdHE2?=
 =?utf-8?B?WnRQM0hpcFJQSkVRb0hFOGNuSzVUKzYzTG9TZXlSaUxBQ1FjU25JSHBEWDY0?=
 =?utf-8?B?dTI0czRYaUpRYitnbnZuL1BhVzdZR2owU1ZxTGMrNXBQRkdGMU1teXpGNFdQ?=
 =?utf-8?B?WUVQL3Z0WTZMTElFMm5Va2c0TkYycXM2MFJicjlQYVNMVEV4NG1kZjMrNEZ6?=
 =?utf-8?B?TXNyM1JrUEp6NE9kRzZwSC9XNjVHTGxINCtja2x2QkJRdWVlN2k0Z0E4UzQ3?=
 =?utf-8?B?d0VmYTFVMGdteCthd1REWlZGM0UwZ05EaWJ6M0pzOTBGaERDaTdHdFZtbzUw?=
 =?utf-8?B?c3F6Nm52Q09tUElJNzZ2YlhGTVUzU280Q0dPYk80Vmg4aCs2ekt3K2NqYWtG?=
 =?utf-8?B?ME82Mm9KeDJqNkVjbkprNkFlaXE5ekpyYVE3ZFN2WlpoaisrSjgrZHFWcnVJ?=
 =?utf-8?B?a1JUNWF4Ly9ycE41ZGcwSjE0OU9hQzRGQXBodUp6M2JsOG5UUTZaRFN2bm5s?=
 =?utf-8?B?cTk0U2ZyOWN4Wm5GbVlaaitTK0ptVXV1Z1Y2NDB4NFZLNWhmQVdWOHkvMzBG?=
 =?utf-8?B?SDRHQXpKY2hiRm9PcTYwUE56OVpienpEUDJSNzVYZ2J1RzZodlFEQkQ1VkxI?=
 =?utf-8?B?dVlPclQza2FMRnR5Nm9hZnlqWW8vbUgwTnFVVTFPQzBkYzJWdDNlejkrYnJ0?=
 =?utf-8?B?b1JCVHB5dERwME4xMkl1V1VKOWoxOVlCeTY1VEVzaEZoNEhyQkNzYldRTEV1?=
 =?utf-8?Q?DF9y8pHc69FsI06Fpwr9Cw9H14xKlCMXQ0AeY=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(7416005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eCt4STl3cklGaTR6TnpaL0Ridzh2NXF3WXFSVjFPRVhiOUJab3Bjd295ZlY1?=
 =?utf-8?B?VGRDQVpnYzlWWFJScDFIZXhhVURZTGtjZnhTaGlxUTNtdkdrblV6MnpRV0g2?=
 =?utf-8?B?WGxlR1I5ZmNNZWl0ZHFMZkRaTVN2MkkvV3djYlpNQ3FuVTdScWdNQTdwcURv?=
 =?utf-8?B?UFo1bHpUTlZCblY0aklnL2haaEtHakF6dUd6U2lxT3dUdzZtRS9QR1Y4dlRi?=
 =?utf-8?B?YnRHVUVPQzZxUmRtOVQxY0hEaWR1cG9JZG56eVlCclR0Sy9zblY1T292Z3NY?=
 =?utf-8?B?b3d4QTZZa2pkWGFFeVFsVDYwejZMT3RRRUpWeXY3WTJkR2orMmQ3QUlTK2NQ?=
 =?utf-8?B?c1VRbFhaYUVGbjZuYWlWeWhYbzBEV0h3Q256SlJmOVRBTjFaYm4rTnY0Nmov?=
 =?utf-8?B?OStiL1ZKTTBvR1g1Syt4SW96MEVzenA1Y0tLcUdyY3VLZ0RHTjdvZXZremdu?=
 =?utf-8?B?Q3AwZWdheXAvajhuTUR2Ky9rTG9pbkFNVjA5YTF2c1BQbWhQUU9lVDJGYkI2?=
 =?utf-8?B?cldDOG1ydXhuNktpb3QzVlQ0ZDlHdzZmRWw3bGNnYlpCWjJnUk02dGVxQSs1?=
 =?utf-8?B?dnJ1Vm4vcUY3Q3RJWmhaaTZOdDRJMHdsTW9XV3ZwNGRVQUZtWjFJUS9GMDZX?=
 =?utf-8?B?ekhpejhxc09BQngxekxjcVloeC95VWlKM29wVVM1cTEzSlhmRDVCcGRWRWJB?=
 =?utf-8?B?OHRWYVBFTkptYnNJZUJyUEM5NG1CK3lzTGFMNFZ1Y1p2WitYNlZoSDNxZktK?=
 =?utf-8?B?cjhmL2lwc0QwNEMxZzlxeFVrTGpOWGw4RFFYTFBaL0ZQNlErU3NNcVZkUmJq?=
 =?utf-8?B?YXg0bHNDM0M1VzkvSmlDbnAzdkZDU0lTUi96c2xHUldxS0FiRWZDRXhYazAr?=
 =?utf-8?B?S2l6L3VrRk5CQUhWUWF4UmFvZjlNWkUyN1VDNEdxMlJCanVuMGNmRGkrNnEr?=
 =?utf-8?B?dytiZkhYRmNtQStCN2pNRFFXeE1CcjBiTVE4bXJOemtrTERwQktOL0ZqaGpu?=
 =?utf-8?B?NnlBYnhVYjRDVmtuS0NoYjZZbGhCMHM0Ump6TTJRWXBwRjNjelhkRFJEV1Vx?=
 =?utf-8?B?QlE1YTVGOXIwbzQxS1lBR0trSTIwV3FzMDIzTUJ0N0MxcHRMUW9MbGtQVkMz?=
 =?utf-8?B?QzhoSzRyTVJrTmNHcXdXL2NsSWxVMWhValJWQWYyTldaNXhLRGJ2dGh2Wmgx?=
 =?utf-8?B?UWluZ2NuNHV0cjhOWkJzVDZibXNCNDA0K3YzbEtVSHVIYjFXM2JadHhCNWda?=
 =?utf-8?B?aEhvUnVqeVIzTUFoSnowMFRPc3hiWFEwWDhsVmk1VjVhQ1hJVmthQkpKekoy?=
 =?utf-8?B?emJkZEl5ZFRaR2diemtqaUNkNTZVKzBXd3F6RGdZR200anNtclVteERqQ3Ix?=
 =?utf-8?B?NE9OdkJxNzFzUDJ5OFRSQmVGWkVCeTVTcGlhdi91NHRmaUxhQ25YSFpuREpJ?=
 =?utf-8?B?aE1LbjE2c0NnOHRyN01zT05vS2IxZTNSV2NmWko3Qm1VQkFEbG9zdzd1RElk?=
 =?utf-8?B?TXcvR01uRnJQSTFvUEJLWTc2Nm1WM2xnNGpZSFZkYklObFE1SjRFUGN6YVd0?=
 =?utf-8?B?RG1SVGZ2c1N1eWdmWmttMXU3RGt0R1dhZEZuUGIyck9XRlBaUnZqWGE4TXZK?=
 =?utf-8?B?MXBLbjVZeTZBSUVzZTlsbkZYdGR2bCtaTHVjVS82djBtRi83aFJMMmFMTCtO?=
 =?utf-8?B?TDZsRUFMcGZMZUgxdENISStuR3dLVlhFbEp0VHRobTU3REdmNHAwNGY2S2FY?=
 =?utf-8?B?bFFrc1djZVNsT1laTG4rdkUzekdjNkdsME5PeFJsbFVwZ0ZKdWVGSkp2ZnZV?=
 =?utf-8?B?N0hoNEdRQnYweEpOdittMTk2N3g4SUZKODVUTVJ2VzBzb2g1WXpCWVZPZXNy?=
 =?utf-8?B?TnFEaUVRMHhUekVZREdYckpRcGRYa1FCelJrTkIyYlpFeE5zejhROWxTOTFG?=
 =?utf-8?B?bkhEYVpBV3k0V0QwK1hDVFQ1YUxvQjh1V25pL093TnRXQUJDYWJCVUNWNjlG?=
 =?utf-8?B?NStzcGR4VG56MzlZNDNpbXgzMFdpSmR0dWxETWJoNzJ1dTk0YXoydlJmK0FW?=
 =?utf-8?B?QzJadnpxai9IVjhBN2lLREhsTFlkcVFSemlvcGErYmt2UGp5Z25zQm84UHBK?=
 =?utf-8?Q?FN5tM7lYEWma+9oJhkEXUSv+w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a37b75e-3ba4-4b99-4527-08dc853521c3
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 07:57:24.9743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OXwc331pKyVDlScLaaIOzAh1rM8nd86NNdHG0eqExZIq37uMLgFqrYN20g3XgplBS1DbanB82oYqnfpsvtFGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9277

On Tue, Jun 04, 2024 at 10:03:06AM -0500, Rob Herring wrote:
> On Wed, May 29, 2024 at 07:26:30PM -0700, Pengfei Li wrote:
> > i.MX91 has similar Clock Control Module(CCM) design as i.MX93.
> > Add a new compatible string for i.MX91.
> > 
> > Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/clock/imx93-clock.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/imx93-clock.yaml b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
> > index ccb53c6b96c1..98c0800732ef 100644
> > --- a/Documentation/devicetree/bindings/clock/imx93-clock.yaml
> > +++ b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
> > @@ -16,6 +16,7 @@ description: |
> >  properties:
> >    compatible:
> >      enum:
> > +      - fsl,imx91-ccm
> >        - fsl,imx93-ccm
> 
> Should fallback to fsl,imx93-ccm? Being a superset should be ok because 
> your DT should never use the non-existent clocks. If not, where is the 
> driver change?
> 
> Rob
> 

Hi Rob Herring,
﻿
Due to the different maintainers of the CCM framework and DTS, I have separated 
the CCM driver patch and plan to send the DTS patch first before sending the 
CCM driver patch. If that's possible, could you help merge this patch first? If 
this is not allowed, I can also send out the CCM driver patch at the same time.
﻿
BR,
Pengfei Li


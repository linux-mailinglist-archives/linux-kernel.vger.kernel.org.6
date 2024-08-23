Return-Path: <linux-kernel+bounces-298316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C613E95C5A8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE74285F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 06:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F5113AA20;
	Fri, 23 Aug 2024 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NasnSeHL"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6232D139D13
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395268; cv=fail; b=tFT7ERJVNF30oCdLaaBMrWH2IYbpMzR+KCmMeaVltZxHMjyantn+Uc3JeNa9f75Yli6EC90CoxJ+8079ztyhSB160pVssPm4W4VdQ3acPoTzNvb7pe+eN0/eP5tXgYqXrg4/hCPkhTnnm8f5iIDcWtN/msAnDEXjQuWgLbugY8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395268; c=relaxed/simple;
	bh=qzllsCcdrHzWcL85smuiIlBFuUxzr2b3muxUj0z63DE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sJezWWrAATQD4ICARVi+gN1IToZi06LXAzPchKJrqnsrBH1GjzA+4Js7LJPka2MWcBzyoqUFdZFII3EEcfrVZP1IzaI0bRji0K+k0wH7/+LpT+YNHZyOYAJpVJAma+T8PYzN5f15jin18UhjuVYwbStTGPd6kbcoQ9JYekYLl0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NasnSeHL; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUpeDQ7wZ3VGzG50XQr9GUrLVLn4jH8lfvtoUtKn15RibTvu48Ye8jtyrK4kvu3LchnGdNgncWX04NZhU+k5N+6Mmp8Z6BU/oyd6FXEdnfAyhNfcEOCn2raSHU7a4S8RNRQpzRc6XgFiSFMk36/2XBwTUnCfdXhhp2D8dlHh3Ffok2k1NMbhVeLBKTALbaRuoBh2XLBW6z8Fmefx7RkPd8oydpVsfcu+1aX3hhpgzenWB1MFmJqz0qDw2ghFATSWYxeuLkknNACw6iXtLjWmpKckG0oVxXbbRpoAGL4qKFXDx4c3wH5RHjjyPkzJevInpl2/ptP/ostm5n5X2brTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzllsCcdrHzWcL85smuiIlBFuUxzr2b3muxUj0z63DE=;
 b=QKj9wkq13YXDjPVsabb0I7aY0C25GCmFiKT9MkOINWgTy7JryaJ1GDJxsAMlCFEW6036NDpMG9agWplHNxjMrWse6ZrzZ+LB6JDo+Ap3fae2oVGHojUm9pN52AjlB8SkHYzp5hGcfRZpdyqenZsxRO7OcRAFi8OOk2589TEXu32uW15eLKAnR017gu22CCsWaedz2aP6Sx4uf90BDlZhVKOnDdsZuP/OCMFBUGQbvDwqbY1ItU+6mdeQhfBcwCe7MrMo7l+HsVzvFR1oFcbZ0rTsR3VtuThsP8R70ZSPU4PHD00/HYv8opYv4zefGi9Aot5zQ0qrROPlo6UIORDiow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzllsCcdrHzWcL85smuiIlBFuUxzr2b3muxUj0z63DE=;
 b=NasnSeHLSPCfEHbuJyJfLhB2876UD/FwPDi/5GGO5L4iIHgruGEerzBOoMr7sepgOlaVIWzi24qnK/2oN2aFtqCpRDBgZLU2R8njJGxPYZ7L17EUP+FU9EOAOTFFl187WrBX3MG4joBLH0deNyhZlbCw8z4R0I5IppdhwzdIKtP4+S4X7nTchJwW2gj+IL3BgNH95dtWaQA4mz9qp5FbfhpW3msw38KtqmulLRKFQmu1/+vl7TqGjAvOzo1E+E4Fci7/HoFAVZ1H/iPHx6PFOTMcqrKKdOt6S47d841nrUE56ApAoKvA+mb7FbmiauOP650ewVQep3mtf4In9/otqg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 06:41:04 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 06:41:03 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next RESEND] nvmet: Make nvmet_debugfs static
Thread-Topic: [PATCH -next RESEND] nvmet: Make nvmet_debugfs static
Thread-Index: AQHa9GKQSA/r5RlGxUmmWIo9F3RKPLI0ZhOA
Date: Fri, 23 Aug 2024 06:41:03 +0000
Message-ID: <f2ce9842-5361-423c-b281-812cb19fc2ed@nvidia.com>
References: <20240822071916.3547318-1-ruanjinjie@huawei.com>
In-Reply-To: <20240822071916.3547318-1-ruanjinjie@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH0PR12MB8580:EE_
x-ms-office365-filtering-correlation-id: 01c54a05-9d31-405b-dc71-08dcc33e8f4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dHdqNkt3dS8wOVgvbkw0b0JUUmJIb0dJM29HVXk4UlNBNGw4UWx3Y3lGNTBF?=
 =?utf-8?B?Rm54dk9VZDV3OUFDQlFBRTN1M3AybWtkZGlVNGRCME01NHdwMENTaDUxVWxx?=
 =?utf-8?B?MUEzeGNKSzBiWUNuT2UvZ0djeE9VdmxWKzN0QTBGdUJLektRa0dFTmRuSGtT?=
 =?utf-8?B?QXRuM0YzYmVmWVlHeXppcmE2NHRxLzlEWmdFUkpYUGdpVVdSV0NaRVdudUh2?=
 =?utf-8?B?VjJFa0JYMmlGaW9SbjhSc20xdFFLd3l6eDNROVNDOWkwelZBK2xpc3V5Q0Z6?=
 =?utf-8?B?UkZJN041UkxodnhvMWsvcWNlYktDaDk1OFgzMkNBUUZkU3A1bmhsUXd0eHBG?=
 =?utf-8?B?OHZMT01GTlVsRFg3d2pZdWs5blk4MHpEbkdoaFM2ZWNGSEhtQWtnbElFZTdp?=
 =?utf-8?B?VVFzN3FwaUFESmlkb3MyQ00rVW42N1VOdUVVK2hKZVk4ZzZ3R2d5YXI2QUFB?=
 =?utf-8?B?OXdwVDFsYXRyWVVrMGVIVmE4NGNCWjdiYkNWRnY3ZThrTHhYbjE5RFhZMVFj?=
 =?utf-8?B?SzFsc2dsQkY4VktXL1JIM2Y1SkxDWForU1RzMEVGQXNWL3JEaUFTMGVucTNX?=
 =?utf-8?B?ams1ekJISEZxUjNkWllZQWt3Z2xtaW84SjAxSkVEUXF0RE1zNWREcFBnUE14?=
 =?utf-8?B?S1NOd0llbDk2SGMxaXp1ZUJ2ZUxoTnVQNkZlQlFoVzdjc3FrV3FpVlhnc0lm?=
 =?utf-8?B?eGxORWJNRXRoMmhTUDRVaW1vd1dJcjdpRFZYQXRPOCtWQWs2UnNqSWM5OHox?=
 =?utf-8?B?bHZXaldIWUl4SmM5enFWbFM2OTRMZVRURkFkaFZxekk3dVVwWTVBKzl6Tkxk?=
 =?utf-8?B?c25Ndlg1WEhDVklyWVlMSDVLbUxDMEVwbXljRFg5SzE2TC9sYWRrRlcyOGpq?=
 =?utf-8?B?RkZKSHZqRXRIVmlDZWt4bmdIK1JnVnEzbnFvUEZWVmdlRGdDdEl2bm5EbzlS?=
 =?utf-8?B?eWV4Mm8yLzJySXMwUE1KWGtraU5ObU80cllET0VwSmN5d1llV2JRR21kRWly?=
 =?utf-8?B?dWMxajNESVhEMTRvSHNRNjdyVVU0S1haMXZpRUlpZHZCOUhuVHZNai81S1Y5?=
 =?utf-8?B?TjA2MUlzQkFZTjZPc2l3SjYxU010OVROUlZEV0dTNWNQN2g4c1FWdEU3dUZF?=
 =?utf-8?B?aEJRWTNscHRUaEVoRVhBUERocEVIR2d4Z1d0TlNzWG9ERnRUaDNwOXpPZXFV?=
 =?utf-8?B?emxnS0JqM2lJdldLYWdCZjluNG5DdHBLMHBoNDc1NWZnRzl2Y2VKY0JrdjF1?=
 =?utf-8?B?NHhvbGxQbWhBcWJCY2pXNW0xRUhtSGJsYlhJNDN0OXA2U2RoUCtDTVl2d3U3?=
 =?utf-8?B?d0Z3NXFYSERjZDVuMXA4dU1PWElxbVU2TGVXYTZIK3UySGRsTk1SbEwrZytH?=
 =?utf-8?B?MDRSSUM3Sk5BMG1vOUUyV1hYTS9jZi9UeGpIaG0rK08xSFRyVVZuQkxiT1dw?=
 =?utf-8?B?VjU3cGdRLzhoclBheG0zTmFpUU1nNTVVM2hUQXNheFpheVlHWHpGOUFPMGNR?=
 =?utf-8?B?eGMxZ0Q0UlFpVHJWRGJOZHJUTXFoRkxjbDFnaTNEb240eG42eWFaL2dLVWdO?=
 =?utf-8?B?UitzREJHVndJTTdtMGpXcnhQODRuK2Rkekc0a3BHeWFaTm5CR2ZVdExOUjJ1?=
 =?utf-8?B?VzhrZFJuZ3d3dDZKQUZQd3U2V0FXOXNNNTlrclpMcnBpcGE5UTh1NWdkOGRz?=
 =?utf-8?B?U2NrL29ndkZHeHZmMHdDM1hFZHpmenpFeWMxd1NSNGJGTFQxZzQya20xei9v?=
 =?utf-8?B?Mm5uQUpTVHFEcVdxVEZvNnN0dTE3ZnYySUxEOFFTL0dzRVVVc0hBbHE2Ykhv?=
 =?utf-8?B?ZHFDWGVjejNGejQ5eHY2dFR3ZzY0OFZDenJTdVAvR1gxVWd1dzNSQ3I4ZDJQ?=
 =?utf-8?B?YXIvREZKOFN3dmxLdkduNzVkazdMS216eDZPb0dicGR5eGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QkxhOUl6RzZvZWdZanczcjNLbzZXcndiZVlUYnYzT3B5bUd2TGZhbGtvKzZ6?=
 =?utf-8?B?TE1iclBLOGM0NFNOdTJSL3lJd3FibDB5Wm9ZVk8wMnBoTkluSzhUTkNKeTNF?=
 =?utf-8?B?WU9zLzMrSHdBMzRlSWViYlc2SHozWGd1OTBRM3ZKVG9kdm1NWStRMmJZTklC?=
 =?utf-8?B?bnd6T0w0UUxNK25najlmZUJRcXVsMHN2bTRLb2NWS3ZlMFVmYmVHTnBFRkFK?=
 =?utf-8?B?REpERm1icU9JdUNQYXJNQVNUVGx1ais0cldseC9LTk4xcWVpbXB3VDBnNElj?=
 =?utf-8?B?dTVHWHNOVkl6TzFOamwyM29VdnNrdlJ5TEkzNFBmVXlRbTBKbHdmcUJQUHZk?=
 =?utf-8?B?Y3lVUDY2UStiVExMallYM1N1ekhaaFlGZkV3eENDZjhpcUxQL1d6Z3RYb2hG?=
 =?utf-8?B?ZjZOYTZyc0pGWVdLNEJBd3F5NnR6ZVM2MXJQb0xTKzh6d1hqSkp4UlZodVIx?=
 =?utf-8?B?VUJ1OVpmdmRPS0RqUjNxTzEvSnczYmozc1pNRzhaT0pQV3J3R1FLQVVZUGM1?=
 =?utf-8?B?OHFGZ2dvL3lnQzhSVTVTSDVZdXo1RUlQdm94elNCNW1QN2dDeXY4d0lzTHpN?=
 =?utf-8?B?L0VYRTZSQkFLN2xFL1Fkd0p0VG1kRi9TZndSL3FRVVFEcGhma2dKOVpPVGRX?=
 =?utf-8?B?RTRZeTBEazM3RnEwSXRZL3EwV2xCNVRQTzRRd1BDVUFyZVJLMTVocGozazVs?=
 =?utf-8?B?SmU4T0x5M0h5Tyt5cUFleUlya2c5eEp1YzhmQ1ROakhnWUFxRFVZaW8zcnZN?=
 =?utf-8?B?L2NsWmtvdkJSYmZsWkRiV1BNUWZ0MmVLczFabHBFZVp4SGlBK0ZFSnh3WkNk?=
 =?utf-8?B?RERrMkU3UWVtRUlOVE55Qyt6NVhxbDNubTd3QkkxVmVaOG8rbVJCYU40SXJo?=
 =?utf-8?B?b292UldsbVlGRlFwcjVQd1RQaW42RTFuS1Qzc1dqaTVTb1NPNFUwb2YxTkwz?=
 =?utf-8?B?MUVjdHJlWmlYT2JKQmVIZ3Q0amR4Z0dxQXBrb1NMOVEydE9VL29CQXA5d05q?=
 =?utf-8?B?WGZESVMyTCtScFh0ZUt6ckdFc1JCemF2S1ltcXJNcHlTc0lDMzhTVmVsZUdI?=
 =?utf-8?B?TXNVNlN0ZEVYUTIvVzJmQ0F1bHlZSFZhL2pBT2xXRGhSMTBSTFp5WlljWVoz?=
 =?utf-8?B?UG9WYzAvUzF1aUUvbzVLSnVYK0hhMzRJUTNmcTg0MVYzdVlaeE9veTNoamJi?=
 =?utf-8?B?cFJzNS9KdjBQVlpSeVdaKzVZNURBWjNDL2EybDZ3U2ZCTlJFWEc5d0x3YzFI?=
 =?utf-8?B?a0JJM0hMR2VEYjNSeFNGVmE4M0s0c0xZMEtnalBMclBKcjgvbUczeFg0dC9O?=
 =?utf-8?B?YTBTUkVvQ1FHTWNpMEZnVU5pZElzUnozd0lNWCt1eWtvSXlFZEdSbk56K2FU?=
 =?utf-8?B?dzR5ZVNOcUF5dHgxaTIzQmFMV2dQRmM0UjV4SGFqWjJid2NGUXlDclBvQVBY?=
 =?utf-8?B?U1lRcDBJSjZkem51Tk4xVmVqMW84dG54cXdVUHhGZlpmaitPaEsyZUZMcGhm?=
 =?utf-8?B?d1ZIUFo1alFsK05tdUNkMkgxcE1RcVhtSXFTRENiM2VqSFRyclNxQ0RVT2Rx?=
 =?utf-8?B?V2thR2hhdTNKQjVwbHMvYzRXaURLa3l5R2V5QkRwRFUvc1lvODNHSXd3OTh1?=
 =?utf-8?B?UkJSRjBqRTRvUEZkWEU5b29Sam5KNU5HT3RwS0RxU05OOHdEZW04N2pEdGp1?=
 =?utf-8?B?YWVrcEZ5S0RBV2U3clZCMU4wUi9LRGlncGtudk9yaUJUQU9Jc3FoRURpeGxs?=
 =?utf-8?B?dTl2d3BUdk1zZ2xRankxTDhMTlpEMVUrdW4vUVhreC85ZThxWmNMeUpJVzM2?=
 =?utf-8?B?MzI4ZjhvZGl4Wm9qczJoeGlGUU1XdTEvVTFKYWJUMUdsZkkrMHhRSDJPd3Q1?=
 =?utf-8?B?L0RFcERzUzM4RmdtRkFQaDF2eFhzZ0dHWGxLbXNhR2pzSEN2cGxRUjdrVG9k?=
 =?utf-8?B?d00xdmJQeWlYTmthZEtsdEVnZUZjYTl1MitQRGtkdW1SS0hSMDVYM1Nma01Z?=
 =?utf-8?B?R1ZoNnJkbWV6ZXViaGt2VXBVZ20rZ0RQT1ZIaW42Vnc0VFR1aUZsd2h3SCto?=
 =?utf-8?B?MFVZSDJKVEVqbzdCS3VCUm5PVjF5RHhsS2Q4ejlPVHl4c09xNDdZRXBKajhX?=
 =?utf-8?B?SE9yWEwvdG9wUkZTSndlR1F1dUwvbi9PZ1BZYXlzcUE3ZzJkYVlQVXhnWnJn?=
 =?utf-8?Q?2YC357CIVq2fQbhxKjmojosSQNTMEL3Hwt/ci11sZTh8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C342DCCE2C1A24DB0A57FFD02050476@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c54a05-9d31-405b-dc71-08dcc33e8f4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 06:41:03.8801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9GifwrXBz5OHws4klKhXpMBKoqH0pbypTqppwVnAo+JcGmZGY4QPKmX695fSk7ykT45R4SMuLdftlKPNJ9+EEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8580

T24gOC8yMi8yNCAwMDoxOSwgSmluamllIFJ1YW4gd3JvdGU6DQo+IFRoZSBzcGFyc2UgdG9vbCBj
b21wbGFpbnMgYXMgZm9sbG93czoNCj4NCj4gZHJpdmVycy9udm1lL3RhcmdldC9kZWJ1Z2ZzLmM6
MTY6MTU6IHdhcm5pbmc6DQo+IAlzeW1ib2wgJ252bWV0X2RlYnVnZnMnIHdhcyBub3QgZGVjbGFy
ZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/DQo+DQo+IFRoaXMgc3ltYm9sIGlzIG5vdCB1c2VkIG91
dHNpZGUgZGVidWdmcy5jLCBzbyBtYXJrcyBpdCBzdGF0aWMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IEppbmppZSBSdWFuPHJ1YW5qaW5qaWVAaHVhd2VpLmNvbT4NCg0KSSBoYWQgcGF0Y2ggd3JpdHRl
biBmb3IgdGhpcyBkaWRuJ3QgZ2V0IGEgY2hhbmNlIHRvIHNlbmQgWzFdLg0KDQpSZXZpZXdlZC1i
eTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCiBGcm9tIDE1
ZmMyZWQ0ZDk1MDhkODQ4OWNlOTlhODc5NGY4Y2JmNDVmMmIzZDIgTW9uIFNlcCAxNyAwMDowMDow
MCAyMDAxDQpGcm9tOiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KRGF0ZTog
TW9uLCAyNCBKdW4gMjAyNCAyMjoyODo1NiAtMDcwMA0KU3ViamVjdDogW1BBVENIXSBudm1ldDog
bWFyayBudm1ldF9kZWJ1Z2ZzIHN0YXRpYw0KDQpNYXJrIHN0cnVjdCBkZW50cnkgKm52bWV0X2Rl
YnVnZnMgc3RhdGljIGluIGRlYnVnZnMuYyBhcyBpdCBpcyBvbmx5IHVzZWQNCmluIGRlYnVnZnMu
YyB0byByZW1vdmUgdGhlIGZvbGxvd2luZyBzcGFyc2Ugd2FybmluZyByZXBvcnRlZCBieSBrZXJu
ZWwNCmJvdDotDQoNCmRyaXZlcnMvbnZtZS90YXJnZXQvZGVidWdmcy5jOjE2OjE1OiBzcGFyc2U6
IHNwYXJzZTogc3ltYm9sIA0KJ252bWV0X2RlYnVnZnMnIHdhcyBub3QgZGVjbGFyZWQuIFNob3Vs
ZCBpdCBiZSBzdGF0aWM/DQoNClJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGlu
dGVsLmNvbT4NCkNsb3NlczogDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1rYnVpbGQtYWxs
LzIwMjQwNjIwMDUwMS41RHJGdThGdS1sa3BAaW50ZWwuY29tLw0KU2lnbmVkLW9mZi1ieTogQ2hh
aXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCi0tLQ0KIMKgZHJpdmVycy9udm1lL3Rh
cmdldC9kZWJ1Z2ZzLmMgfCAyICstDQogwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvZGVidWdm
cy5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9kZWJ1Z2ZzLmMNCmluZGV4IGNiMmJlZmM4NjE5ZS4u
MjIwYzczOTFmYzE5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9kZWJ1Z2ZzLmMN
CisrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvZGVidWdmcy5jDQpAQCAtMTMsNyArMTMsNyBAQA0K
IMKgI2luY2x1ZGUgIm52bWV0LmgiDQogwqAjaW5jbHVkZSAiZGVidWdmcy5oIg0KDQotc3RydWN0
IGRlbnRyeSAqbnZtZXRfZGVidWdmczsNCitzdGF0aWMgc3RydWN0IGRlbnRyeSAqbnZtZXRfZGVi
dWdmczsNCg0KIMKgI2RlZmluZSBOVk1FVF9ERUJVR0ZTX0FUVFIoZmllbGQpIFwNCiDCoMKgwqDC
oCBzdGF0aWMgaW50IGZpZWxkIyNfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmls
ZSAqZmlsZSkgXA0KLS0gDQoyLjQwLjANCg0KDQo=


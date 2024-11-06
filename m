Return-Path: <linux-kernel+bounces-398388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162A39BF0AA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21CE2823A6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D073A202F8C;
	Wed,  6 Nov 2024 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3Wgfoo8O"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F410B20264C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904600; cv=fail; b=mzl013SOuHdRNggKwZlnFPGd/rb68DC6WBdxnZul0+NuvvYbDzJoVIzwM3tcb3G7tmihksSneEGQ/EDlyPcIJGoGMHGILfKMrVLylhIm+skNHhRqHWszgImZQW3AI0ZNXdArXCE1lsWWO/46m+dj0O0wxJLaDoY1u5qE4OFDp3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904600; c=relaxed/simple;
	bh=LJ9hSPb3xXqDveGulp5E9CAB9xLXDiVx4ko3PgN3kLo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ufk8tfHKJ1G/Cd3DJZpmICrlHlAeNPsxu4TC5CGEpWQqBiFIUo0Bij0vlgQvGlU/8OrFtAO+Ir9GT4dArn9GueDIMgETL6SwhCs5uVU8bghoXqbG21kGMoJ5K1RVSC6JFh8mxS73Hlouuc1W+gr98zU/T9nnY/whi+Ww2an4SUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3Wgfoo8O; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAdrWm3Wn+3KkVNbD5X/PlS2bdSxmbebwqSj4KFfkJfkZCARKOyfm3nsKE7qWsp1iP670uw+ChzUmOgfbAXcHO/2gIBfhPz43lY5AjLAWp8Y4U1PPwzkGBhtKBhmOPFwDrqIwtkIVAg2YFT2wiHxTUchJho5UFbCxx2vkW41TrjYVmCo3+/PrPkJCuEV6ZqNzubGAqYfMsASLlZA/9bHQss77deSF2o9BAQU2jholtFuFf+BhtAkHHk4SRgV4GBLqJyv4s6Ay7yuu51hQb3pRoAPjXA1jayACsZ8ymG4ZaojhhAB/Ib0LHQRa47yAb+DKEVA5MPnckGaTOKCTTuk+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJ9hSPb3xXqDveGulp5E9CAB9xLXDiVx4ko3PgN3kLo=;
 b=e6EV+zCs7UMil9KtNSHOiQF9OAEhK+y2HZTx6Ib7nggOi9NRNCPbMCuY6dCHzgxS7Kg9lJk0ap2ISTIXBjd9ADqf3HjyR+OgcpudIsmBrirpqAD2Ek+5dLw6bUKzt6nktnp+0QQHBzojwfLlkOBc/fE6iLk7FlkL/WwqoJfr7/Q44P40xNGJOsrO5kGipsayeOmhLmwfAIZJiWFbJn4w8PI3VbdbhtQo92UtrwpnQSCjd4113lVkelPkdJbfECGFvVnD9IzwoOLUox2pcdz06jKEp3uvvc4lZxAesEFHb+ujAYoyyYCUbjE00i/Jp/o1LNx1NHDnP17jcgxywgIJuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJ9hSPb3xXqDveGulp5E9CAB9xLXDiVx4ko3PgN3kLo=;
 b=3Wgfoo8OQnIxzUMD8k73yRHueKF9BPKMZVjgv6UZQL4lKCRP3TDcbozL4xTjkMJMmeF/jg2fLjIOGNbjz2bGgIDyLM2PvLb8xpe5N+WGrwhfy2Xrz4VV5QwGuG6y8J3h9U/d9uOj7bosZ3ngy24/wJPjz79T3C7DosDir+4rgGg=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by SA1PR12MB8096.namprd12.prod.outlook.com (2603:10b6:806:326::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 14:49:56 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 14:49:56 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 19/35] Documentation/x86: Document the new attack
 vector controls
Thread-Topic: [PATCH v2 19/35] Documentation/x86: Document the new attack
 vector controls
Thread-Index: AQHbMDg1JLBBlMsMQUStBRLaO7h7dbKqT+jQ
Date: Wed, 6 Nov 2024 14:49:56 +0000
Message-ID:
 <LV3PR12MB92658EA6CCF18F90DAAA168394532@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20241105215455.359471-1-david.kaplan@amd.com>
 <20241105215455.359471-20-david.kaplan@amd.com>
 <20241106103922.GBZytHWloHcFZ8CNL_@fat_crate.local>
In-Reply-To: <20241106103922.GBZytHWloHcFZ8CNL_@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3aa4774b-05da-47a5-beb6-c3c1de4296c1;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-06T14:28:40Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|SA1PR12MB8096:EE_
x-ms-office365-filtering-correlation-id: d1917092-dc97-426b-9a62-08dcfe7247a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z09CK3NqemFPQmZSblBRdUQ1a1RRQ1pFNWYxSWN0S0JpdnpGUUYyWTBlSmhm?=
 =?utf-8?B?a3p3c2hSRGpkRm1xbm1iZldpRmVJdGpTbEVzeEd6cjhSQXNJdkdldFRNZTJo?=
 =?utf-8?B?NVM5Y1k2TzlFaHVSOGZBeWNlVlRyWEh6OEp4MlNWdDNYS1pkalM2U3dGbHFC?=
 =?utf-8?B?Z1o0ay9rakI5N3EzMUpJTDZ5UkU5YWRKN1hBUG8zL3VMRXlybnQ0dkh0S3ZZ?=
 =?utf-8?B?SFQwV0NlblZqcnc4Z0NRNzhTQUYzRDNVNDhBdWtDdmNnazhCU2wyNEw2NEdH?=
 =?utf-8?B?VXNBN1dJZzRtbTl1WWJva0xSbnIxdURCU21vTmZpZTYvT2M4SG5wdmNZZ1Vs?=
 =?utf-8?B?c1NUSnpGaXhlTlR5K0JvcnNHUjlGMzRxcCtjS1Z5VC8rWXQvM3NjN0ZxWm1j?=
 =?utf-8?B?MHVJNFZGTXh0dWdEMWRqOHd1SnpLcXhObkt5b1JCS1RDdzUvU09QSU13UFg4?=
 =?utf-8?B?M20wZi9aSlFNVDZWRm9SS20wd2xyTW1pVDY2Rk9vT1VGVnRxQWVxY3dEK1ZO?=
 =?utf-8?B?SG9jcEhkbHdHZi91eTM2NmM2Q21URTJ0OXYxS2RRMkI4aC9mNEFwVDRKNjRT?=
 =?utf-8?B?MzRBeWJFQkNJYnpnYklScEltM1RYd0hJMlA1VjE0cnUzYVYwNVJYVWw0MGFa?=
 =?utf-8?B?VFFNZVBwdmVqemp4VUc1N1NiWTJrN0ZJWTZUaWJOKy9LSkh0UWlxUGdrR1R6?=
 =?utf-8?B?cnlMRWdMWS9KalY2S1FYbzBTaUhQZ3M3cDZuampxaXVsU1FYZGdFOTh1czVk?=
 =?utf-8?B?a0w0ZTY1WEVEZGIrVkR1eXZTM3I4QmVyL0Q3VGQ5L1c0RjhGMDBzWFgzRWFj?=
 =?utf-8?B?NkdiSlUzK3lrLzFUOTNibDZjMGdDWG1DSEhDRnNVQnFrb1JhWVdmcjZCNFJQ?=
 =?utf-8?B?K0JGWnpQZWp5eGF6Z0hLVjEvNlNEQnNwL3JKcWlCWmh6NHNPeW1nOUtNRU1J?=
 =?utf-8?B?ZVhYdE5laGFxUStabU50dWoxeG45TWZDdUdPNWRWc2NRNE9tcWhBRjJtRUhS?=
 =?utf-8?B?dFZFQ2MxWStPSzBIeEFwSnJzRlFiak9JYTZuRzgvWFdTNEZpRm51WDQrTDEr?=
 =?utf-8?B?NkxqK2xyWjIzT2FzSzVxUnZoVHpxbXRHUjZLM2lnVTNjVFI1QzNOb3p6amh1?=
 =?utf-8?B?Q0tLdUYvWEtnZzJMRnpwbmI1MGltOCsrRzUydUJWd3ljSFA3dGtOdldwWGly?=
 =?utf-8?B?RmNIT21aY1hPMGlzajcvRGJqUXljTGpUUWp0cnA4Qi9vakdSNDZraTNmc0VQ?=
 =?utf-8?B?QzA0bFdiWVEwUEFiMkNVV0NVa3ZsUHZ0QjFWMTM4UTBjTlNmRXZabkpUL05j?=
 =?utf-8?B?WkZ5dFBQVTczakJQMHpEdmwvVnBuV2g3OHc1dHhpb3hVajFtd2crT0RPL2ZZ?=
 =?utf-8?B?UGhuYzl4UjdkUHZsNjcycjRWU1FQRVZUZkozb0t1K3ptNHFOOEEwZDB6eWR0?=
 =?utf-8?B?U0Rxak45QXhKaC83L25ab2hLanBzc3ZubldiNUdBeTlzbTR4TEl2UTBuR0pS?=
 =?utf-8?B?d0NiNnZQNUdVY1pWeVRYOG8vd3BLQW51WEl1M3BzdzNyL2k2Wm5WaURCQzN0?=
 =?utf-8?B?NXhuZEN6eFdHeGNQdmtuSUtRK2FON3B3bUtxVlY5WUlBZUNsc0NCZ3dBaVg5?=
 =?utf-8?B?akVtVXVtbVVuVVRFeXQzQ2hySm5DMitkTkFGVno3UDEzbGRYSWNXb3AzOUtk?=
 =?utf-8?B?UU1rTHVjNEpKNDdScjFhdkhXamtOK3FWMXc3b0wrYTYxS3V5NkpwSVcvcXdl?=
 =?utf-8?B?ZG04eHhNN2dOQW13S1RpUkxuNnBwLzRzaWhnVlU5eWxHSnN6Qitya25xK0RW?=
 =?utf-8?Q?x/2/uQE0i5kiSIZgcrI7pxXqtFSOAiVNOitdI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVRGVWcxSkgvd2IvMEVMbXhLcEVmMCttUUZodkVScjd6b1IwdlNvU280WkZC?=
 =?utf-8?B?L05zRnBONGpNdlRRQ3lTRHlGd2poTnFrOEc2NHI2VGZVandMdllaL2pYQXRH?=
 =?utf-8?B?WHBDNlc3U0VPM0hEL1h6VHZuTE44RDJKMXpOeGV3UWVVcWE5VGpEQUJiY25F?=
 =?utf-8?B?OGVRbitpRlljMk91NUVXVTZlSkxIZ2lqRnR3OHh4T3BjdjdWbXpBVVQ4OUcv?=
 =?utf-8?B?dWJRUUtBamZTTkQwcmpaVmdPS1FQS1Z6Z3BqQTUxOU5aVzBYaFNNQmx3M2xo?=
 =?utf-8?B?UC8vUVpEKyszQ2VHeVhPc2N0MTNJRUsvcEZteGpzeVRKUUwvYXJBejEyUWdC?=
 =?utf-8?B?aUM3VlRWdVNjOUZDbjdlY2x4Z29xbFRBbEd2NmxYZnlWVWpJZXoxV04wZ2Rv?=
 =?utf-8?B?a3Yxb2pXdlFsNTJMaFZrU2pBZ3VEcXNaZ2NOOStxV1dLT1U2VFlXZC9CT3NC?=
 =?utf-8?B?Z05iaDJqbUFIOVVHMU5PREhueUxrNzRPcFlhZmtlVk1rT3RBZ0E4KzFSWTF1?=
 =?utf-8?B?YzlhVmgyZUJlY01UMDhuSThkenEvamdGQWxndTdid0NEdld3dmtsZ09VSmho?=
 =?utf-8?B?QkNPOEVmQVEvb08zNUk1RGtudzVHa29tU2dhT3gwUmpWeGxCejlueXlOeEdw?=
 =?utf-8?B?REhrUmU1MXJ4aFE2aEtYTUpycnJyeVNRVmJaM3RtV004eWhJbDZKeWUxVlFp?=
 =?utf-8?B?RUU2bG9QMW5RNHdNM2c1Y1FsaWJqVGhQSHpuRjVkZStieFBQc3dkcFJmM2dX?=
 =?utf-8?B?S1Z0SWs0bW1hb1FmQ1NHR09XanNOaEJ0UXZUNWxnQUtTUmd0b0JyNWZJYWpr?=
 =?utf-8?B?K0FGMjErZkhDamRNZ3B5K2JoY0ZQM1NZR2VyOHdtbnB1TFczamd4NC9NWG9P?=
 =?utf-8?B?SHlseFhNR1RLQW1TQkIvV2F4WFVNcUtiaGdMKzNkTkZoN2xNVGdBdVZ4VkNS?=
 =?utf-8?B?THVUcFArYWVMVjVGdW83K0thUnZQdm8rZXExYlUzNVFoM2JFQmRCRjk1aUha?=
 =?utf-8?B?aGpDNUZaVFlkbFR1Y1Vyczd6YXJ0dXEzR2p2WjJOallDQW4zUmVlMERrSkRx?=
 =?utf-8?B?VzFKVnJJazAxK1RqRWNGeWMvUXFEeEpMcXV3MjB3MEQ5U2xNdDlJcXdhR3Mv?=
 =?utf-8?B?VlJmL3I2OVRINmVmMHZ5MjBhcjVtbkVmKzZOaWhlaXNuY0dKV3JvY3hQRGNY?=
 =?utf-8?B?NlV6RG9rdXJmRWRjK2hFLzI5M1J3TDJsQ3lkTVc2dnpiUUpDenBwbFZiU2Y1?=
 =?utf-8?B?VkdlQVA5SUVMcUtQcStwdG5lZ1ExY01HTXdMY0Z6S1dqYmRsYld6UmpOdEpv?=
 =?utf-8?B?alZSQ3VySlVsQzdHWnhoNkV3RU9CSzFRVTRLSDdyMW56czdxOGwxdVNxY2tr?=
 =?utf-8?B?ckNsVEZNSy9wbTEyTHNIOWRLb2UrT25FTVhRbGlwbnNjV2lWOVN3RkNNbmNr?=
 =?utf-8?B?S0ZmcVFMT1FyUUorYWlnSktYOFM3dklEdUdQdVFNWlllUXJpZGdGbnlPQVRS?=
 =?utf-8?B?aGE1MnZmc2gzUTVQQTdWUzJHRXNLUWRvRzlQTjNhVVJuSEErTnhyMElqM044?=
 =?utf-8?B?RWZISDhLQWxOZlJJUHlWV2gzWE1oaDdwN0s5R3R4bzcwdUU3R0ZOb3VpTTlD?=
 =?utf-8?B?UTFQdGlmOUttNC9aR3VhbjA5R1BLVzJQdGdvV2xCYXFURmcreGtMUVJMZThR?=
 =?utf-8?B?enVZMld2L1BudCtFdTByb1UrbWJhMFlVTUJYMnZMQnhNN3k4c3ZFbmo5UVNY?=
 =?utf-8?B?Qzc0Q1g3dmU4UjhtaXhyNmhHcUxjeExpdE1QOEdyUTRnWGw0R1E4TTFrRWlQ?=
 =?utf-8?B?NDZ0M3dHRFRXa3IvZUNrbDdURC9rNHdBUU9nbFZyN0FUVU1vaHV5OFFieHo1?=
 =?utf-8?B?VklsaEh3dDM1NkthejhlbGhkMkg1M2twaW5MbGwxOWVreDZGVGNrQWowcEVN?=
 =?utf-8?B?bGk4bUl1WXlEc3NNUWtLTmxJZUJQSldib2hTNzRqeHZHV05BOUtnRTdnV2lp?=
 =?utf-8?B?M3hnQ2RJL01ERFAxYVZiREI3SDQ4OUVwdHh0MW5ZdUNiVC8wUU50Uk9sVkp1?=
 =?utf-8?B?UituUGpzSElsVEQ2cXJJYkhQam1keVA3aE5GQ21RZ3R0NkVmSzFYbGo3My9s?=
 =?utf-8?Q?gRXk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1917092-dc97-426b-9a62-08dcfe7247a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 14:49:56.1325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wi0VCcCV54kD9Onh8a9UM/vDds/wsasa4dzPSugwc870Lvsxa8eU4TJR3nhK4PBM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8096

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciA2LCAyMDI0IDQ6Mzkg
QU0NCj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPg0KPiBDYzogVGhv
bWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6
QGluZnJhZGVhZC5vcmc+Ow0KPiBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VAa2VybmVsLm9yZz47
IFBhd2FuIEd1cHRhDQo+IDxwYXdhbi5rdW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb20+OyBJbmdv
IE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47IERhdmUNCj4gSGFuc2VuIDxkYXZlLmhhbnNlbkBs
aW51eC5pbnRlbC5jb20+OyB4ODZAa2VybmVsLm9yZzsgSCAuIFBldGVyIEFudmluDQo+IDxocGFA
enl0b3IuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYyIDE5LzM1XSBEb2N1bWVudGF0aW9uL3g4NjogRG9jdW1lbnQgdGhlIG5ldyBhdHRh
Y2sNCj4gdmVjdG9yIGNvbnRyb2xzDQo+DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5h
dGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBv
cGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4N
Cj4gT24gVHVlLCBOb3YgMDUsIDIwMjQgYXQgMDM6NTQ6MzlQTSAtMDYwMCwgRGF2aWQgS2FwbGFu
IHdyb3RlOg0KPiA+IERvY3VtZW50IHRoZSA1IG5ldyBhdHRhY2sgdmVjdG9yIGNvbW1hbmQgbGlu
ZSBvcHRpb25zLCBob3cgdGhleQ0KPiA+IGludGVyYWN0IHdpdGggZXhpc3RpbmcgdnVsbmVyYWJp
bGl0eSBjb250cm9scywgYW5kIHJlY29tbWVuZGF0aW9ucyBvbg0KPiA+IHdoZW4gdGhleSBjYW4g
YmUgZGlzYWJsZWQuDQo+ID4NCj4gPiBOb3RlIHRoYXQgd2hpbGUgbWl0aWdhdGluZyBhZ2FpbnN0
IHVudHJ1c3RlZCB1c2Vyc3BhY2UgcmVxdWlyZXMgYm90aA0KPiA+IG1pdGlnYXRlX3VzZXJfa2Vy
bmVsIGFuZCBtaXRpZ2F0ZV91c2VyX3VzZXIsIHRoZXNlIGFyZSBrZXB0IHNlcGFyYXRlLg0KPiA+
IFRoZSBrZXJuZWwgY2FuIGNvbnRyb2wgd2hhdCBjb2RlIGV4ZWN1dGVzIGluc2lkZSBvZiBpdCBh
bmQgdGhhdCBtYXkNCj4gPiBhZmZlY3QgdGhlIHJpc2sgYXNzb2NpYXRlZCB3aXRoIHZ1bG5lcmFi
aWxpdGllcyBlc3BlY2lhbGx5IGlmIG5ldw0KPiA+IGtlcm5lbCBtaXRpZ2F0aW9ucyBhcmUgaW1w
bGVtZW50ZWQuICBUaGUgc2FtZSBpc24ndCB0eXBpY2FsbHkgdHJ1ZSBvZiB1c2Vyc3BhY2UuDQo+
ID4NCj4gPiBJbiBvdGhlciB3b3JkcywgdGhlIHJpc2sgYXNzb2NpYXRlZCB3aXRoIHVzZXJfdXNl
ciBvciBndWVzdF9ndWVzdA0KPiA+IGF0dGFja3MgaXMgdW5saWtlbHkgdG8gY2hhbmdlIG92ZXIg
dGltZS4gIFdoaWxlIHRoZSByaXNrIGFzc29jaWF0ZWQNCj4gPiB3aXRoIHVzZXJfa2VybmVsIG9y
IGd1ZXN0X2hvc3QgYXR0YWNrcyBtYXkgY2hhbmdlLiAgVGhlcmVmb3JlLCB0aGVzZQ0KPiA+IGNv
bnRyb2xzIGFyZSBzZXBhcmF0ZWQuDQo+DQo+IFJpZ2h0LCBhbmQgdGhpcyBpcyBvbmUgb2YgdGhl
IHRoaW5nIERhdmlkIGFuZCBJIGhhdmUgYmVlbiBiaWtlc2hlZGRpbmcgb24gcmVjZW50bHkNCj4g
c28gcGVyaGFwcyBpdCdsbCBiZSBjb29sIHRvIGhlYXIgc29tZSBtb3JlIG9waW5pb25zLg0KPg0K
PiBNeSBpc3N1ZSB3aXRoIHRoaXMgaXMsIGJlY2F1c2UgSSBhbHdheXMgdHJ5IHRvIG1ha2UgdGhl
IHVzZXIgaW50ZXJmYWNlIGFzIHNpbXBsZSBhcw0KPiBwb3NzaWJsZSwgSSdtIHdvbmRlcmluZyBp
ZiB3ZSBzaG91bGQgbWVyZ2UNCj4NCj4gICAgICAgICB1c2VyX2tlcm5lbCBhbmQgdXNlcl91c2Vy
DQo+DQo+IGFuZA0KPg0KPiAgICAgICAgIGd1ZXN0X2hvc3QgYW5kIGd1ZXN0X2d1ZXN0DQo+DQo+
IGVhY2ggaW50byBhIHNpbmdsZSBvcHRpb24uDQo+DQo+IEJlY2F1c2UgdXNlcl91c2VyIGFuZCBn
dWVzdF9ndWVzdCBlYWNoIHB1bGwgaW4gdXNlcl9rZXJuZWwgYW5kIGd1ZXN0X2hvc3QNCj4gcmVz
cGVjdGl2ZWx5LCBkdWUgdG8gaG93IHRoZSBwcm90ZWN0aW9ucyB3b3JrLg0KDQpUbyBiZSBjbGVh
ciwgaW4gdGhlIGN1cnJlbnQgcGF0Y2ggc2VyaWVzIHRoZSB1c2VyX3VzZXIgYW5kIGd1ZXN0X2d1
ZXN0IHByb3RlY3Rpb25zIG9ubHkgdHVybiBvbiB0aGUgbWl0aWdhdGlvbnMgcmVxdWlyZWQgZm9y
IHRob3NlIHNwZWNpZmljIHZlY3RvcnMsIGFzIG5vdGVkIGluIHRoaXMgcGF0Y2guICBUaGV5IGRv
IG5vdCBhdXRvbWF0aWNhbGx5IGVuYWJsZSB0aGUgc2FtZSBwcm90ZWN0aW9ucyBhcyB1c2VyX2tl
cm5lbCBvciBndWVzdF9ob3N0Lg0KDQpIb3dldmVyIGR1ZSB0byBob3cgTGludXggd29ya3MgKGF0
IGxlYXN0IHRvZGF5KSwgaWYgeW91IGhhdmUgb25lIHRydXN0ZWQgdXNlcnNwYWNlIHByb2Nlc3Mg
YW5kIGFub3RoZXIgdW50cnVzdGVkIG9uZSwgeW91IHJlYWxseSBzaG91bGQgZW5hYmxlIGJvdGgg
dXNlcl9rZXJuZWwgYW5kIHVzZXJfdXNlciBjb250cm9scyB0byBoYXZlIGNvbXBsZXRlIHByb3Rl
Y3Rpb24uDQoNCj4NCj4gQXMgRGF2aWQgc2F5cywgd2hhdCB1c2VyX2tlcm5lbCBhbmQgZ3Vlc3Rf
aG9zdCBlbmFibGUgZm9yIG1pdGlnYXRpbmcgdGhlDQo+IHJlc3BlY3RpdmUgdmVjdG9yLCB3aWxs
IGNoYW5nZSB3aGVuIHdlIGFkZCBtb3JlIGludm9sdmVkIGtlcm5lbCBwcm90ZWN0aW9uDQo+IHNj
aGVtZXMgc28gdGhlaXIgb3ZlcmhlYWQgc2hvdWxkIHBvdGVudGlhbGx5IGdvIGRvd24uDQo+DQo+
IFdoaWxlIHRoZSB1c2VyX3VzZXIgYW5kIGd1ZXN0X2d1ZXN0IHRoaW5ncyBzaG91bGQgbm90IGNo
YW5nZSB0aGF0IG11Y2guDQo+DQo+IFNvLCBwcm92aWRlZCB3ZSBhbHdheXMgRFRSVCwgd2hhdCBn
ZXRzIGVuYWJsZWQgYmVoaW5kIHRob3NlIHZlY3RvcnMgd2lsbCBjaGFuZ2UNCj4gYnV0IHN0aWxs
IGJlIHN1ZmZpY2llbnQgZGVwZW5kaW5nIG9uIHRoZSBrZXJuZWwgYW5kIGl0cyBwcm90ZWN0aW9u
cy4NCg0KT25lIGtleSBwb2ludCBpcyBub3RlZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2U6IHRoZSBr
ZXJuZWwgY2FuIGNvbnRyb2wgaG93IGl0IGJlaGF2ZXMsIHdoYXQgaXQgZXhlY3V0ZXMsIGl0cyBh
ZGRyZXNzIHNwYWNlLCBldGMuICBCdXQgaXQgY2Fubm90IGNvbnRyb2wgaG93IHVzZXJzcGFjZSB3
b3Jrcy4gIFRoZXJlZm9yZSwgdGhlIHJpc2sgYXNzb2NpYXRlZCB3aXRoIGF0dGFja3MgdGhhdCB0
YXJnZXQgdGhlIGtlcm5lbCBtaWdodCBjaGFuZ2Ugb3ZlciB0aW1lLCB3aGlsZSB0aGUgc2FtZSBj
YW4ndCByZWFsbHkgYmUgc2FpZCBmb3IgdXNlcnNwYWNlLiAgUmlzayBpcyBub3QgYWx3YXlzIGEg
YmxhY2stYW5kLXdoaXRlIGRlY2lzaW9uLCBhbmQgdGhlcmUgY291bGQgYmUgYSBwb2ludCB3aGVy
ZSBrZXJuZWwgZGVmZW5zZS1pbi1kZXB0aCBtZWFzdXJlcyBtYXkgYmUgZGVlbWVkIHN1ZmZpY2ll
bnQgYnkgc29tZSwgYnV0IG5vdCBhbGwsIGFkbWlucyB0byBlbGltaW5hdGUgdGhlIG5lZWQgZm9y
IG1vcmUgZXhwZW5zaXZlIG1pdGlnYXRpb25zLg0KDQo+DQo+IE9uZSBvZiB0aGUgYXJndW1lbnRz
IGFnYWluc3QgdGhvc2UgZ2V0dGluZyBtZXJnZWQgaXMsIHRob3NlIGFyZSBub3QgZ29pbmcgdG8g
YmUNCj4gKnZlY3RvciogY29udHJvbHMgYW55bW9yZSBidXQgc29tZXRoaW5nIGVsc2U6DQo+DQo+
IG1pdGlnYXRlX3VzZXIgLSB0aGF0IHdpbGwgbWl0aWdhdGUgZXZlcnl0aGluZyB0aGF0IGhhcyB0
byBkbyB3aXRoIGV4ZWN1dGluZyB1c2VyDQo+IHByb2Nlc3Nlcw0KPg0KPiBtaXRpZ2F0ZV9ndWVz
dCAtIHNhbWUgYnV0IHdoZW4gcnVubmluZyBndWVzdHMNCj4NCj4gVGhlIHRoaXJkIG9uZSB3aWxs
IGJlIHRoZSBTTVQgb2ZmOiBtaXRpZ2F0ZV9jcm9zc190aHJlYWQuDQo+DQo+IE9oIGFuZCB3aGF0
ZXZlciB3ZSBkbyBub3csIHdlIGNhbiBhbHdheXMgY2hhbmdlIGl0IGxhdGVyIGJ1dCB0aGF0IG1l
YW5zIGFuDQo+IGFkZGl0aW9uYWwgY2hhbmdlLg0KPg0KPiBBbnl3YXksIHRoaXMgc2hvdWxkIGJl
IHRoZSBnaXN0IG9mIG91ciBiaWtlc2hlZGRpbmcuDQo+DQo+IFRob3VnaHRzPyBJZGVhcz8NCj4N
Cg0KUmlnaHQsIHNvIHRoZSB3YXkgSSB0aGluayBvZiB0aGlzIGlzIHRoYXQgdGhlcmUgaXMgYSBj
b2duaXRpdmUgcHJvY2VzcyB0aGF0IGFkbWluaXN0cmF0b3JzIG11c3QgZ28gdGhyb3VnaDoNCg0K
MS4gRGV0ZXJtaW5lIGhvdyB0aGUgc3lzdGVtIHdpbGwgYmUgdXNlZCAoZS5nLiwgYW0gSSBydW5u
aW5nIHVudHJ1c3RlZCBWTXM/KQ0KMi4gRGV0ZXJtaW5lIHRoZSBhdHRhY2sgdmVjdG9ycyByZWxl
dmFudCBmb3IgdGhhdCBjb25maWd1cmF0aW9uIChlLmcuLCBJIG5lZWQgZ3Vlc3QtPmhvc3QgYW5k
IGd1ZXN0LT5ndWVzdCBwcm90ZWN0aW9uKQ0KMy4gRGV0ZXJtaW5lIHdoaWNoIG1pdGlnYXRpb25z
IGFyZSByZXF1aXJlZCB0byBlbmFibGUgdGhlIGRlc2lyZWQgbGV2ZWwgb2Ygc2VjdXJpdHkgKGUu
Zy4sIGVuYWJsZSB2dWxuZXJhYmlsaXR5IFggbWl0aWdhdGlvbiBidXQgbm90IFkpDQoNClRvZGF5
LCB0aGUgYWRtaW5pc3RyYXRvciBtdXN0IGRvIGFsbCAzIG9mIHRoZXNlLCB3aGljaCByZXF1aXJl
cyBpbi1kZXB0aCBrbm93bGVkZ2Ugb2YgYWxsIHRoZXNlIGJ1Z3MsIGFuZCBpc24ndCBmb3J3YXJk
IGNvbXBhdGlibGUuICBUaGUgcHJvcG9zZWQgcGF0Y2ggc2VyaWVzIGhhcyB0aGUga2VybmVsIHRh
a2UgY2FyZSBvZiBzdGVwIDMsIGJ1dCBzdGlsbCByZXF1aXJlcyB0aGUgYWRtaW5pc3RyYXRvciB0
byBkbyBzdGVwcyAxIGFuZCAyLiAgVGhlIHByb3ZpZGVkIGRvY3VtZW50YXRpb24gaGVscHMgd2l0
aCBzdGVwIDIsIGJ1dCB1bHRpbWF0ZWx5IHRoZSBhZG1pbiBtdXN0IGRlY2lkZSB3aGljaCBhdHRh
Y2sgdmVjdG9ycyB0aGV5IHdhbnQgdG8gdHVybiBvbi9vZmYuICBCdXQgdGhlIGF0dGFjayB2ZWN0
b3JzIGFyZSBhbHNvIGZvcndhcmQgY29tcGF0aWJsZSBpbiBjYXNlIG5ldyBidWdzIHNob3cgdXAg
aW4gdGhlIGZ1dHVyZS4NCg0KV2hhdCB5b3UndmUgcHJvcG9zZWQgaXMgdXAtbGV2ZWxpbmcgdGhp
bmdzIGEgYml0IGZ1cnRoZXIgYW5kIHRyeWluZyB0byBoYXZlIHRoZSBrZXJuZWwgZG8gYm90aCBz
dGVwcyAyIGFuZCAzIGluIHRoZSBhYm92ZSBmbG93LiAgVGhhdCBpcywgdGhlIGFkbWluIGRlY2lk
ZXMgZm9yIGV4YW1wbGUgdGhleSBoYXZlIHVudHJ1c3RlZCB1c2Vyc3BhY2UsIGFuZCB0aGUga2Vy
bmVsIHRoZW4gZGV0ZXJtaW5lcyB0aGV5IG5lZWQgdXNlci0+a2VybmVsIGFuZCB1c2VyLT51c2Vy
IHByb3RlY3Rpb24sIGFuZCB0aGVuIHdoaWNoIGJ1ZyBmaXhlcyB0byBlbmFibGUuDQoNCkknbSBu
b3QgbmVjZXNzYXJpbHkgb3Bwb3NlZCB0byB0aGF0LCBhbmQgd2VsY29tZSBmZWVkYmFjayBvbiB0
aGlzLiAgQnV0IGFzIHlvdSBzYWlkLCB0aGF0IGlzIG5vdCBhbiBhdHRhY2stdmVjdG9yIGNvbnRy
b2wgYW55bW9yZSwgaXQgaXMgbW9yZSBvZiBhbiBlbmQtdXNlIGNvbnRyb2wuICBJdCBpcyBwb3Nz
aWJsZSB0byBkbyBib3RoLi4ud2UgY291bGQgYWxzbyBjcmVhdGUgZW5kLXVzZSBvcHRpb25zIGxp
a2UgdGhlIG9uZXMgeW91IG1lbnRpb24sIGFuZCBqdXN0IG1hcCB0aG9zZSBpbiBhIHByZXR0eSB0
cml2aWFsIHdheSB0byB0aGUgYXR0YWNrIHZlY3RvciBjb250cm9scy4NCg0KSSdtIG5lcnZvdXMg
YWJvdXQgb25seSBkb2luZyB0aGUgZW5kLXVzZSBjb250cm9scyBhbmQgbm90IHRoZSBhdHRhY2sg
dmVjdG9yIGNvbnRyb2xzIGJlY2F1c2Ugb2YgdGhlIHJlYXNvbnMgb3V0bGluZWQgYWJvdmUuICBG
b3IgZXhhbXBsZSwgSSdtIHRoaW5raW5nIGFib3V0IHNvbWUgcHJvcG9zZWQgdGVjaG5vbG9naWVz
IHN1Y2ggYXMgS1ZNIEFkZHJlc3MgU3BhY2UgSXNvbGF0aW9uIHdoaWNoIG1heSBnbyBhIGxvbmcg
d2F5IHRvIHJlZHVjaW5nIHRoZSByaXNrIG9mIGd1ZXN0LT5ob3N0IGF0dGFja3MgYnV0IG1heSBu
b3QgYmUgZnVsbHkgc2VjdXJlIHlldCAod2hlcmUgdGhlIGtlcm5lbCB3b3VsZCBmZWVsIGNvbWZv
cnRhYmxlIGRpc2FibGluZyBhIGJ1bmNoIG9mIGd1ZXN0LT5ob3N0IHByb3RlY3Rpb25zIGF1dG9t
YXRpY2FsbHkpLiAgV2l0aCBhdHRhY2sgdmVjdG9yLWxldmVsIGNvbnRyb2xzLCBpdCB3b3VsZCBi
ZSBlYXNpZXIgdG8gdHVybiBvZmYgZ3Vlc3QtPmhvc3QgcHJvdGVjdGlvbiBpZiB0aGUgYWRtaW4g
aXMgY29tZm9ydGFibGUgd2l0aCB0aGlzIHRlY2hub2xvZ3ksIGJ1dCBzdGlsbCBsZWF2aW5nIHRo
ZSAoYWxtb3N0IGNlcnRhaW5seSBuZWVkZWQpIGd1ZXN0LT5ndWVzdCBwcm90ZWN0aW9ucyBpbiBw
bGFjZS4NCg0KLS1EYXZpZCBLYXBsYW4NCg==


Return-Path: <linux-kernel+bounces-509989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4392FA316ED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA97168394
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 20:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDABF2638BA;
	Tue, 11 Feb 2025 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ViLQj90l"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED7261596
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739307238; cv=fail; b=hQz9O2Sy4G7s7Oq53MykJ+I6MhJa4s8B4XjOD4DJ9mQyuQn96ZF2qhJIDgsltV/pnaXcDmEH9VttBTpvkIVsKVAHMrYXrwZS9eb8K/j5Aqg5+n6hNXmuS14+O3zNVeuypfUAaUBZtVkcBeE0P4pjZdxsz2ESI1M5NxNtdiFPr1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739307238; c=relaxed/simple;
	bh=lchPN+L+S39pACpnYfet77enzetLghOWgNEChYPlPqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XJU9FKfdlA1UOfKKpUTRtWE09XYFQzMtOZCdUNhqpCJcniQvqKgXWt2N5hEiEkboB5XTAWiLj8PxDVahU85+8UGJ+AAbAHHBdI6tkzCYll7e6vb4IivuUPIgb9vXfaTzm5rslXbD1XvVf2qBf1Py9L+Aq9ZWyVkgH+u+nicugkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ViLQj90l; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnYkNH4aGLGjr19tq4WxZzvgZKCB9EsdfHb+KYkT+WDL1DI9RkIIpy3DWUGJqC37paGmvcgiohsl1i4/ycKMGDLABuyJ/hg5xjs6dBB5+8A8IyZb8TC4pheHPhWHhySn2omFaxFWaLHaF51/rgVfcx1LFudslUdolEou9cI6Kx8jxI/fozzLy0ux8NegeCaAxVk8OwMLq1gjYaEKn3Kiw6Qu8kGXp7++ufGPqKVl0ouYFm/s2vyw9Ff04DhbKbbaHbRhDo5W9ZHp2s/fyfc0MwUsVFEsg7RL2uTJrxCt8i1PBVj7+FWiqbPosO/056uZ57nLpV2z/5k1byoBxPF6GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lchPN+L+S39pACpnYfet77enzetLghOWgNEChYPlPqQ=;
 b=kt3BcC/e6yCwYMdI/XmAuqTF/mfrGapX9nt9+UqzRm4U8Tt2+w3wvLu42wyA7fpduB4gq/kWnnJ3nwmnaPaCGOsWVtaeJ6l12TZPxYmSDB759qVVmzs0AGuWLplCeBAHhMNbYmKYwYbW/o2AehzYIUMj/j6G0bUKtgH4W5ZWezD+aOT+kSQ+vWYKhDaTakgmKtwq5766WUgU/QivExuTjajYMK707PhXtiZpyeSN+5XEDgsCFEzqA6NOh2DWhHtqaWB+e/LfAvyimfN9lvjncH7n50mJVrXB5kXiPWeYPfnlxZtY7MV9gt7cOBttz4R5zb8Og4JR7ZHFpfL2Ck8otg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lchPN+L+S39pACpnYfet77enzetLghOWgNEChYPlPqQ=;
 b=ViLQj90laH66Q0XGddKTHqWhhaSrDHB2EmWSXI/evcEFyBoLOjBwthRRDCIgQLwmjlYE0mDeXbpKQLJ6CHoAUOt27CFq1OsmwWVIy40hQ1e+++QDl0vtkpcMugVbWgCAh1si6OIq0e5cPD09+PYVFEXKuHE1+hxq/QOR8yu4Vyc=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by MN0PR12MB6030.namprd12.prod.outlook.com (2603:10b6:208:3ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 20:53:53 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 20:53:53 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 21/35] x86/bugs: Determine relevant vulnerabilities
 based on attack vector controls.
Thread-Topic: [PATCH v3 21/35] x86/bugs: Determine relevant vulnerabilities
 based on attack vector controls.
Thread-Index: AQHbfLSQUDPou+7NY0ixBqOC/d0dv7NCczYAgAAAWcCAABu7AIAAAStQ
Date: Tue, 11 Feb 2025 20:53:53 +0000
Message-ID:
 <LV3PR12MB9265E936344F123A5464D89794FD2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-22-david.kaplan@amd.com>
 <20250211184130.2fl4jvdwd4e5y32a@jpoimboe>
 <20250211185400.vwu3tkqr4gc2r5tu@jpoimboe>
 <LV3PR12MB9265D7BF6446C2D84414E42C94FD2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250211203430.vvuf7aks3hrozv5b@jpoimboe>
In-Reply-To: <20250211203430.vvuf7aks3hrozv5b@jpoimboe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=0dac6786-d4cd-46ef-92e1-8b43594080c6;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-11T20:38:41Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|MN0PR12MB6030:EE_
x-ms-office365-filtering-correlation-id: 23abe4b9-48c6-4910-acf3-08dd4ade31f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YVpSVWZQQjc4ZUI3am1DNFZCR2JLOG9HdzdWZ1dxWlAzTDhEamREMDR0bU9j?=
 =?utf-8?B?R3pFYXlNRTJMY0FjNFhTWnhPakF1RDdETFBaK2FlenFXQXB3RVFEVXpLNkts?=
 =?utf-8?B?a2tRbUJNN2gwd1l6RmJ3elRWRnpUNWM5WDZaQVlBY3VRYXpRbXpia2hjc3hF?=
 =?utf-8?B?OGMyZXJzaUdtY2pmL2RCc25KM3QyVmRNVFd1TFNmTEhHNTFrYXhqS1ZrQStP?=
 =?utf-8?B?dG0vMGp0WHBaM2lhR3NCdndoN1FHVmxhYy9RS3VQc2pvVS90M1F5OXd1QXR2?=
 =?utf-8?B?Y3pCTmVzU3paLzg0KzRBa2JPM242MFNYeGhUbVRpRjV0WEFNd2FZY3NJaTdT?=
 =?utf-8?B?MkkwVXRYVXdIMHg3TWR3QzMxZlYyK0xRMURLVFpyVU14L2U4eU1xVmdKaHg4?=
 =?utf-8?B?blFwSnlvb1VMbmdtODdRZ2MxcEtGYkdzaUgyZlNLU2ZtTjl2R3o5S1RsTDQ0?=
 =?utf-8?B?V0d4VnRpTHprQWdQdEZoaVRUUGJFaWxLNldDTkhqMFpoMXo0WTVacW5PUCsy?=
 =?utf-8?B?NDhBQStuak9aYXFjK0hIT3d1NmhEWDViK21LNlVFRERsY0owaDZlSkZZci9k?=
 =?utf-8?B?TWhDSFI0ZVBScDBoNUdMZUJWbGVyZm9LelFBNmNpVkY2R293azhkeTBXdyt3?=
 =?utf-8?B?MVhnMi80K1Joa1dGTDdSU0ozOERER2duS1pUU1hmWEZYdmkzQWc3dXVLc1Nu?=
 =?utf-8?B?bjMwWDdvTFdhYzBGM3FQd0JUSVZJYVZmT2ZqRWhtV1hOeWRKekpRZ1RhS0M2?=
 =?utf-8?B?UWdZMU95RmFONUFXU21lUk9iRzlWTTJYSVduYm5KNGxCemFnWWpIQU9oQkI0?=
 =?utf-8?B?cERxNThXVGNScTlJZENQaExvU21NTmdjMjhxVS96bFcrRVROMWVhYm9KcGxR?=
 =?utf-8?B?U2VYaERqaG52dDdyVGlMNklzMS9OTjNXdU9hT24yTDQwazFONWVJM2JGUEto?=
 =?utf-8?B?K21nUC9hcTJHMjRmakdxRm8xNXBXOW1DTVlPUTJZRjRMUGxnQVJra2ZlL05R?=
 =?utf-8?B?c1RkRXJ2OG1ramFZZkFOaXgvTU1nRnVEQWlhNnJTWjk4YUVkUmpjbjhxdmN6?=
 =?utf-8?B?aU1FNWhGZFJMSUdqSUVkZFFQRVlvTi9MR3N1bjFmUUNYSFVPSTZMNW5Pb0F4?=
 =?utf-8?B?amJXWFJvaTIrOFJoaW9rR09iQUZGUkp5Qjc0UVB1ZUtKR3locUxRbExRM1BU?=
 =?utf-8?B?SDN2MFpLWEtYOWIzTlh1WGY2SmZpSTVYMDJjUU43U0VRY01UcUE1V0NTZHd5?=
 =?utf-8?B?M05IWGsxWXRTb3B3Mk1HNDlPdFBxb1JwY0M4SEU1MFl6Tm1Yc2ZNQlRVY2hC?=
 =?utf-8?B?cm5Dd2JUaHRWUmNLNWNiSnZhTVVEWVdKV256YzBGWCtiNXhPVUIwd3ZqS3VE?=
 =?utf-8?B?Nm9LYUZKWUNuWmRnRmVUOWJNRVFQNmduaXpsN29FTUFVOWRCdkNyMi9NeVhr?=
 =?utf-8?B?dDhKaGNmeW1HOTIxV1RwN29KTklUUUluckUzR1N3aU1IelJjMk5XaHZyZnFn?=
 =?utf-8?B?YjlwRU8wSkhNK1BvZnF2c2FHRGRQNmFhR2U5QW4xOGZqYTJzOGNFTnVZZys1?=
 =?utf-8?B?U2ttWTBHeXV6aWJRTzh5N05oYlBvMVpXV2p3U2MzSS9xZmQyMEpsVGg2dzla?=
 =?utf-8?B?ekFXVmNQUDY1czFOdmZtdy92TXlvaWhuclVvTk5YRG5mbzVIZzZ5QVBQRjg4?=
 =?utf-8?B?L1liK0wydWQ5NDU0K0c0eTRNdWhTTFV6elNDZHIwL2RtZytTY3B4WTUrOE9v?=
 =?utf-8?B?U0d6YmxISzZJc1lkcS8xTTdiV1Z4STk2UXJNODNsMGU2UkErcHZmdGpiTTFa?=
 =?utf-8?B?dXRFcGhoK3E4eitEa2p4WGRvNVFqaWF2My9US1RwZE1KRVJIRHJZNTlMZVdn?=
 =?utf-8?B?N0tpQnVUN2c0SG15RXpKeC80UnNoTnFIbmIwNDVEbmVOU0F3ZUJDZ1FnTlg5?=
 =?utf-8?Q?HfZME4D7cN/5r5yv+e3Xw+JlYHV5Vt0O?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wkc3T0FYZi83Rk9FQzBMaEw3S2lWSElwS0tWaGxSbDFLNVEvcjI3eWJQcUh2?=
 =?utf-8?B?V0FXQXZzMmhWUE5CY25RMkpFcEN4RktGWjExRndUOVg2OUhreTROU2R2Nmxy?=
 =?utf-8?B?SkJWcFIyeFo2bUo5OHMwQnJDQXpjVEdMOVUvOThBSmJvL0luOUtJVzN5VXp2?=
 =?utf-8?B?SWptMStHRkJYMDI4NlVxUE11bG9VZ0pCZzNML0g1d1N4U002V0o2VGpWUDFO?=
 =?utf-8?B?WFY4RXdaY0JVRGZidm9weHpDRHlEUUpsZ25lY3JzZTQ1S0dkNzdENHFncits?=
 =?utf-8?B?WEhMNXhCSmhjUUlob0J0QnNIUXU2emtGRVdlaHo2alhNaFBXK3pLVWxCaVU2?=
 =?utf-8?B?V3Y3QmRtR3lSbG83eUVpS24wdnU0Zlh4enZ0Wm1jVlh5TmxNOVJHanVnR21B?=
 =?utf-8?B?QTJKMnFneUFtTUxZRy92bWdBd3VtNmhSUzVMNDVZUUtSNnlwME5MUjk0dXlG?=
 =?utf-8?B?Vld1ZXVvU0hXRTVrcDB3VW1udGVTNHlOZXNBbEs1U3MyQnE2dnZlaGVId1J1?=
 =?utf-8?B?dDM1MlRpcklzYVZIWVVSbkxhVmlLTDlKS0VmK0pWRWdnZW5vcldEWUVoMGtL?=
 =?utf-8?B?VlEweCtJU2FGYTZQTG5uazA3ZHpYcVNtRjdEeWUzTEozRy82UjhQNEVXQjJx?=
 =?utf-8?B?NEJwaGFpcVZpbTYvYThXYW53bW9Nc3o4RlplRHpHMFkzRU81cGwveHdNdjN3?=
 =?utf-8?B?ZWRsSERZTVp4Z2tMMVROR3NpVEVBRHdENWZpOXRkSWFtajRjL3MzNkg3c3R6?=
 =?utf-8?B?ai9vQVFCUEFzSERQSzA3c3FXdXJURkRpcFlxNk0wK1VUbmd1dVVha0hUM1NS?=
 =?utf-8?B?dmRCVG4vUUtzYnVNVHdWZzZCbEZQc3cyeW9lMmxvVTFiS1VmS29Fd1pSRDZX?=
 =?utf-8?B?TzZuc1NzQkdONmNTbmJ0UmNKV2J4OHZGSGpxbTh5SytFVXdxUXBvVzFKSllB?=
 =?utf-8?B?NnRQa2ZBVmFtY09RNGpBWjBmVUZOblBwei96V1FrRXJVdWNXRUJQS1FYdnNU?=
 =?utf-8?B?L1cvMTBLY3ZnazdSakFSaStqT3hFbnVETG5NVkxCbzViT1c3VU85QnZ6TnZH?=
 =?utf-8?B?elFNQUdLVGhvMlFhV25WY2VteW1BWHNQRnc5cHZlZVRmWDFPWTIzZzlTaC80?=
 =?utf-8?B?c2NBWGRsNUswSVIwaHdVSnZpbk5yRlZPdmxPNWg4d1pqU05jdzIrNHV3YVdh?=
 =?utf-8?B?R1ZoWm5TTzdNdllhM3VUMnNKZnMrNEU4TUloU1oxM0p4a2x6emVPcmJ6bGJr?=
 =?utf-8?B?TTByZmsvcFhrd3VadVNBMzR4NFFyY3RWRXhubVZEekU5bGxUYUc3RFRqVC9y?=
 =?utf-8?B?SGRMRnYxZGZhRzJLZUJFOGhSL1NpcjVROWQ1YzcyNXBrY0ZibXhSclRFblo1?=
 =?utf-8?B?N0tiY01STjRUQXhTSTd1d2JEdFIwdFdEaWlBSXpydFpxcGRqTGorMm5hYjBh?=
 =?utf-8?B?YWJuVkNLZWxXTGk4ZTRiWHlWZUdNM0kwOHMvRHZFVStvSWF1a1B2RDBuT040?=
 =?utf-8?B?NVA4WnF1TXQ0RkorSXVkcVEvVmxoTmhKWlEweFRJNWwvSklIbFF4RlNEUUdl?=
 =?utf-8?B?b0s3TlZ3UFBtdXpuZWJPMHN3b1dpdVNBNmROY3ZQRElZcEVtQld1UHVlcFRN?=
 =?utf-8?B?S2pSUVNTQjlvaGQ3SGlvbmQ5dlZLS056MzZhdEorKzd6cU5USWNGYlNUMjZH?=
 =?utf-8?B?MGNDWHJNN0l3WHQvR2JUZ0VNNURWWmlYWXdkT053Q3dBdUc2VVpCYXFQVjlU?=
 =?utf-8?B?M2tLMlBxTFdJRU01ZEc2TEZxbnZrcCsrRTRGN04wYmdCNXhqaHd0TGVBKzVR?=
 =?utf-8?B?R3dpaEZ2QWlsaHE5eVZaY2Ywb2hqL1B4N1NOU0V0SVYrdnE4aXpOS1EyMW9x?=
 =?utf-8?B?WUhVU1VkdVB1YzIwaVNTMFNDTVd5NjJPZ0hvN0RWdmRRbHNFeCtqbExTNDNH?=
 =?utf-8?B?b3VDTjZqSXozbitRNzQrYUtBWmxxRUVKN0orTDR5SnB4ZnQ5aWh0UG1QdFhT?=
 =?utf-8?B?cEorNXliME5ib1ZCV1FDUEhiWlM3TjA5T1NMdlh1SFFDc254TDZXL200VVF5?=
 =?utf-8?B?Nk1xdkxlbWpTYWl0eDBtREh6Z0c0a1NEL2VnNC94MUNJS3pqb3ppNXdYbmFq?=
 =?utf-8?Q?54F0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 23abe4b9-48c6-4910-acf3-08dd4ade31f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 20:53:53.7373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GKoFCC6GSPtZHfDOogwR3x7T3OcRil9CF7ATj2sCqOz93fr4Go2kBl7hU6HDoq1F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6030

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3NoIFBvaW1ib2V1ZiA8
anBvaW1ib2VAa2VybmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMTEsIDIwMjUg
MjozNSBQTQ0KPiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+DQo+IENj
OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47IEJvcmlzbGF2IFBldGtvdiA8
YnBAYWxpZW44LmRlPjsgUGV0ZXINCj4gWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsg
UGF3YW4gR3VwdGENCj4gPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IEluZ28g
TW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgRGF2ZQ0KPiBIYW5zZW4gPGRhdmUuaGFuc2VuQGxp
bnV4LmludGVsLmNvbT47IHg4NkBrZXJuZWwub3JnOyBIIC4gUGV0ZXIgQW52aW4NCj4gPGhwYUB6
eXRvci5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjMgMjEvMzVdIHg4Ni9idWdzOiBEZXRlcm1pbmUgcmVsZXZhbnQgdnVsbmVyYWJpbGl0
aWVzIGJhc2VkDQo+IG9uIGF0dGFjayB2ZWN0b3IgY29udHJvbHMuDQo+DQo+IENhdXRpb246IFRo
aXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVy
IGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3Ig
cmVzcG9uZGluZy4NCj4NCj4NCj4gT24gVHVlLCBGZWIgMTEsIDIwMjUgYXQgMDc6MDQ6NDRQTSAr
MDAwMCwgS2FwbGFuLCBEYXZpZCB3cm90ZToNCj4gPiBUbyBleHBsYWluIG15IHRoaW5raW5nIGEg
Yml0IG1vcmUsIG1pdGlnYXRlX2Nyb3NzX3RocmVhZCBpcyBpbnRlbmRlZA0KPiA+IHRvIGVuYWJs
ZSBjcm9zcy10aHJlYWQgbWl0aWdhdGlvbnMgZm9yIGFueSB2dWxuZXJhYmlsaXRpZXMgdGhlDQo+
ID4gaGFyZHdhcmUgbWF5IGhhdmUuICBUaGF0IGRvZXMgbm90IG5lY2Vzc2FyaWx5IHJlcXVpcmUg
ZGlzYWJsaW5nIFNNVC4NCj4gPiBUaGUgcmVxdWlyZWQgY3Jvc3MtdGhyZWFkIG1pdGlnYXRpb24g
aXMgZGVmaW5lZCBieSBlYWNoIHZ1bG5lcmFiaWxpdHkuDQo+ID4NCj4gPiBGb3IgbWFueSB2dWxu
ZXJhYmlsaXRpZXMgKGxpa2UgTURTKSwgbWl0aWdhdGlvbiByZXF1aXJlcyBkaXNhYmxpbmcNCj4g
PiBTTVQuICBtZHNfYXBwbHlfbWl0aWdhdGlvbigpIHF1ZXJpZXMgdGhlIHN0YXR1cyBvZiB0aGUg
Y3Jvc3MtdGhyZWFkDQo+ID4gYXR0YWNrIHZlY3RvciBhbmQgd2lsbCBkaXNhYmxlIFNNVCBpZiBu
ZWVkZWQuDQo+ID4NCj4gPiBGb3IgR0RTLCBtaXRpZ2F0aW5nIGNyb3NzLXRocmVhZCBhdHRhY2tz
IGRvZXMgbm90IHJlcXVpcmUgZGlzYWJsaW5nDQo+ID4gU01ULCBqdXN0IGVuYWJsaW5nIHRoZSBt
aXRpZ2F0aW9uIGluIHRoZSBNU1IuDQo+ID4NCj4gPiBUbyBiZSBmYWlyLCBpdCBkb2Vzbid0IG1h
a2UgbXVjaCBzZW5zZSB0byBkaXNhYmxlIGFsbCB0aGUgYXR0YWNrDQo+ID4gdmVjdG9ycyBleGNl
cHQgbWl0aWdhdGVfY3Jvc3NfdGhyZWFkLCBidXQgZm9yIGNvcnJlY3RuZXNzIGl0IHNlZW1lZA0K
PiA+IGxpa2UgZW5hYmxpbmcgdGhlIG1pdGlnYXRpb24gaW4gdGhpcyBjYXNlIHdhcyB0aGUgcmln
aHQgdGhpbmcuDQo+ID4NCj4gPiBJIGRvbid0IHJlYWxseSB3YW50IHRvIHRpZSBtaXRpZ2F0ZV9j
cm9zc190aHJlYWQgdG8gU01UIGRpc2FibGUNCj4gPiBiZWNhdXNlIG9mIGNhc2VzIGxpa2UgdGhp
cyB3aGVyZSB0aGVyZSBpcyBhIGNyb3NzLXRocmVhZCBhdHRhY2sNCj4gPiBtaXRpZ2F0aW9uIHRo
YXQgaXMgZGlmZmVyZW50IGZyb20gZGlzYWJsaW5nIFNNVC4gIFlvdSBjb3VsZCBhbHNvDQo+ID4g
aW1hZ2luZSBidWdzIHRoYXQgbWlnaHQgYmUgZXZlbiBtb3JlIGxpbWl0ZWQsIHdoZXJlIHBlcmhh
cHMgdGhleSdyZQ0KPiA+IG9ubHkgcmVsZXZhbnQgZm9yIHNheSB1c2VyLT5rZXJuZWwgYnV0IGFs
c28gaGF2ZSBhIGNyb3NzLXRocmVhZA0KPiA+IGNvbXBvbmVudC4NCj4NCj4gQnV0IHRoYXQgImNy
b3NzLXRocmVhZCIgdGhpbmcgZG9lc24ndCBldmVuIG1ha2Ugc2Vuc2UgYXMgYSB2ZWN0b3IuDQo+
DQo+IFRoaW5rIGFib3V0IGl0IHRoaXMgd2F5LiAgRm9yIGNyb3NzLXRocmVhZCBhdHRhY2tzOg0K
Pg0KPiAgIC0gQ1BVIHRocmVhZCBBIGlzIHRoZSBhdHRhY2tlci4gIEl0J3MgcnVubmluZyBpbiBl
aXRoZXIgdXNlciBvciBndWVzdC4NCj4NCj4gICAtIENQVSB0aHJlYWQgQiBpcyB0aGUgdmljdGlt
LiAgSXQncyBydW5uaW5nIGluIGVpdGhlciBrZXJuZWwsIHVzZXIsIG9yDQo+ICAgICBob3N0Lg0K
Pg0KPiBTbyBBTEwgY3Jvc3MtdGhyZWFkIGF0dGFja3MgaGF2ZSB0byBpbmNsdWRlIG9uZSBvZiB0
aGUgZm9sbG93aW5nOg0KPg0KPiAgIC0gdXNlci0+a2VybmVsDQo+ICAgLSB1c2VyLT51c2VyDQo+
ICAgLSBndWVzdC0+aG9zdA0KPiAgIC0gZ3Vlc3QtPmd1ZXN0DQo+DQo+IFNvIGJ5IGRlZmluaXRp
b24sIGEgY3Jvc3MtdGhyZWFkIGF0dGFjayBtdXN0IGFsc28gaW52b2x2ZSBhdCBsZWFzdCBvbmUg
b2YgdGhvc2UgZm91cg0KPiBtYWluIHZlY3RvcnMuDQo+DQo+IFNvIGNyb3NzLXRocmVhZCBjYW4n
dCBiZSBhIHN0YW5kYWxvbmUgdmVjdG9yLiAgUmF0aGVyLCBpdCdzIGEgZGVwZW5kZW50IHZlY3Rv
ciBvcg0KPiAic3ViLXZlY3RvciIuDQo+DQo+IElmIGEgdXNlciB3YW50cyB0byBiZSBwcm90ZWN0
ZWQgZnJvbSB1c2VyLT51c2VyLCBvZiBjb3Vyc2UgdGhhdCBpbmNsdWRlcyB3YW50aW5nIHRvDQo+
IGJlIHByb3RlY3RlZCBmcm9tICpjcm9zcy10aHJlYWQqIHVzZXItPnVzZXIuDQo+DQo+IEFuZCBp
ZiB0aGV5ICpkb24ndCogY2FyZSBhYm91dCB1c2VyLT51c2VyLCB3aHkgd291bGQgdGhleSBjYXJl
IGFib3V0DQo+ICpjcm9zcy10aHJlYWQqIHVzZXItPnVzZXI/DQo+DQo+IFdoYXQgdXNlcnMgKnJl
YWxseSogY2FyZSBhYm91dCAoYW5kIHdoeSB0aGVyZSBleGlzdHMgc3VjaCBhIGRpc3RpbmN0aW9u
IGluIHRoZSBmaXJzdA0KPiBwbGFjZSkgaXMgdGhlIGZ1bmN0aW9uYWwvcGVyZm9ybWFuY2UgaW1w
YWN0IG9mIGRpc2FibGluZyBTTVQuDQo+DQo+IFNvIGEgZmxhZyB0byBhbGxvdyB0aGUgdmVjdG9y
cyB0byBkaXNhYmxlIFNNVCBtYWtlcyBtb3JlIHNlbnNlLCBlLmcuLA0KPg0KPiAgIG1pdGlnYXRl
X2Rpc2FibGVfc210PW9uDQo+DQo+IEFuZCBtYXliZSBhbHNvIGFuIGFkZGl0aW9uYWwgZmxhZyB3
aGljaCBzYXlzICJJJ3ZlIGVuYWJsZWQgY29yZSBzY2hlZHVsaW5nIG9yDQo+IHNvbWUgb3RoZXIg
aXNvbGF0aW9uIHNjaGVtZSwgZG9uJ3Qgd29ycnkgYWJvdXQgYW55IG9mIHRoZSBTTVQtc3BlY2lm
aWMgbWl0aWdhdGlvbnMNCj4gbGlrZSBTVElCUCI6DQo+DQo+ICAgbWl0aWdhdGVfc210X3NhZmU9
b24NCj4NCj4gQnV0IHRoZSBzdGFuZGFsb25lICJjcm9zcy10aHJlYWQiIHZlY3RvciBkb2Vzbid0
IGZpdCBhdCBhbGwuDQo+DQoNCkl0J3MgYSB2YWxpZCBhcmd1bWVudCwgSSBkZWZpbml0ZWx5IGFn
cmVlIHRoYXQgY3Jvc3MtdGhyZWFkIGlzIGEgc3Vic2V0IG9mIHRoZSBvdGhlciB2ZWN0b3JzLg0K
DQpJZiBJIHVuZGVyc3RhbmQgeW91ciBwcm9wb3NhbCBjb3JyZWN0bHksICdtaXRpZ2F0ZV9kaXNh
YmxlX3NtdCcgbWVhbnMgdGhhdCB0aGUga2VybmVsIG1heSBkaXNhYmxlIFNNVCBpZiBhIHZ1bG5l
cmFiaWxpdHkgYmVpbmcgbWl0aWdhdGVkIHJlcXVpcmVzIGl0ICh5ZXM/KS4gIEkgd29uZGVyIGlm
IHRoYXQgc2hvdWxkIGJlICdtaXRpZ2F0ZV9zbXQnIHdpdGggYSAzLXdheSBzZWxlY3Rpb24gb2Y6
DQoNCidvbicgKGRpc2FibGUgU01UIGlmIG5lZWRlZCBiYXNlZCBvbiB2dWxuZXJhYmlsaXRpZXMp
DQonYXV0bycgKGRvIG5vdCBkaXNhYmxlIFNNVCBidXQgYXBwbHkgb3RoZXIgZXhpc3RpbmcgU01U
LWJhc2VkIG1pdGlnYXRpb25zIG9uIHJlbGV2YW50IHZ1bG5lcmFiaWxpdGllcykNCidvZmYnIChk
byBub3QgYXBwbHkgYW55IFNNVCByZWxhdGVkIG1pdGlnYXRpb25zIGxpa2UgU1RJQlApDQoNCkFu
ZCB0aGlzIHdvdWxkIG5vdCBiZSB1c2VkIHdoZW4gc2VsZWN0aW5nIHdoZXRoZXIgdG8gbWl0aWdh
dGUgYSBidWcsIG9ubHkgaW4gd2hpY2ggbWl0aWdhdGlvbnMgYXJlIGFwcGxpZWQuDQoNClRob3Vn
aHRzPw0KDQotLURhdmlkIEthcGxhbg0K


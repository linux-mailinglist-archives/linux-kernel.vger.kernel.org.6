Return-Path: <linux-kernel+bounces-511528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 430B4A32C49
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49341882AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDD1250C13;
	Wed, 12 Feb 2025 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F6C2ZoY1"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4E3254B09
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378859; cv=fail; b=AjfmzSa9++CWc+5oXhDYRFfwiNCWKdcbN0PWh0D2G2OTLrUnXPWdPePIKfqWlIioBn1IRX78Ga9fYG+qzuJO3sy4kiCRJx4MtGA6u5lWUkkRfCCkIRB3Grqpb2B02Lz+RVBbVEMPY/EQ2YhDl6Gar8kPsutAuCGkMiDP7bWRTOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378859; c=relaxed/simple;
	bh=H2GkMO5/XF/jY8TPkgrwF+MoeLtNFuZ2Moim8FDDw+k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GYBFo+8HOEdjXvk6QJQBSmEFaDqgSHwO0B7JkZPsXK8Py8jb4KLHX/zKskfk0BCPe2HuWzb5OHOWUj1YoOVAZyvdWaYdodLRWNHAKpwp7ayVYqp0mRUc86bQjvqYZzNIrtS23ETj35ArKTDSMBY+UZGRM+GS7yHDGg9ymYNk6WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F6C2ZoY1; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5SFLpCCyTOBAlr2FB8M0v1DGQ/AmGpUhr9q4H5+XOTtqdNadG7fs3iQAgdOixL8Rqs1RRwcLiBIxYjmN6Ds6Cb0q2IuF7znjWR4en/dlvks5BTrKx8iirHbu67cBmlpqwY4orWKC0eaN5KZc3d1Z8WEA439MpGl+Df4mEDd/UtA1nLZ7+EUbffU02aI7tuSTClRvxxD4shAQxy12+olBl5/GwM9E78N8RRBzOzKfyEZ9OBomdDdFe0JWxf2M0YCUDwAFL3QeC6z/sEGzxcmqv6HKOGan82OPkfNIvmOKICQNPjEratEdykEkbSEVVrx00NXRZ0HLR1DD3PW8sFtKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2GkMO5/XF/jY8TPkgrwF+MoeLtNFuZ2Moim8FDDw+k=;
 b=Dim42+VLXDMs8Pyz1eezi5pVfaOEaZ44nchcY70kG8xaJe9TOwnbZJXp5+E90yAk4AIkW+KJ+aTY0PbVaoZZymB+g5h8mrMhMUTyD4YlWq9C7Br6uGPgnSenfJkRBcLkBz78jRysU3aTpQuZyVyr2K7Q1E1YzL+Ft0n7IrqJ+Yby4YwpZeG9vVpcaKXyGRNG2sTUpoy9iAUCS8WJri64U2mjZLhpuaJstxKz+ybVMQSi7vG8Jt8AO8JlBe0rKOUV9RKB6QjpfFzXwamnqxaMJ7ug57u3y5715/94YEA7tQFNrxtWDT7lHieelLbbJXYwZeY7G7qD9ux62ejbcNAjqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2GkMO5/XF/jY8TPkgrwF+MoeLtNFuZ2Moim8FDDw+k=;
 b=F6C2ZoY1Ph8oAKeyMUUKH+gW26qThrirbRJ/RSteIR9wa7QK3uXx1iiSWxzVXcGLD+IO4SPu+WHufP2X20gWKLTbgb/3dKwS7JW40J3JLycM1ziL6dj4AlLvn0lzwYmj2sqs7X1vjssV7FTr2AZzLVuDc+otcOB99S1JmSH7AOs=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 16:47:34 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 16:47:34 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 17/35] x86/bugs: Restructure l1tf mitigation
Thread-Topic: [PATCH v3 17/35] x86/bugs: Restructure l1tf mitigation
Thread-Index: AQHbfCM8XQ2nedwNKk6oCXDxxYBLHLND40Ug
Date: Wed, 12 Feb 2025 16:47:34 +0000
Message-ID:
 <LV3PR12MB926500B2ABAE8E1EE6D843FB94FC2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-18-david.kaplan@amd.com>
 <20250211012104.mxhmvghlmyf52uaa@jpoimboe>
In-Reply-To: <20250211012104.mxhmvghlmyf52uaa@jpoimboe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=049b170b-eb5b-4754-8a35-c18cc466eb3a;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-12T16:47:16Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|MW4PR12MB7032:EE_
x-ms-office365-filtering-correlation-id: 96c83508-99a2-452d-86ea-08dd4b84f344
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R004MTNBZ3M1L25ERVF0MWsrS2ZxeDd6alJCV3F1c0FXUTcyMGVTSThxRm5V?=
 =?utf-8?B?VkZMVjZuZWhsT2cyVUlVZkRmZWpPQjMvUkJPa0U5TmlvTS9Qc2J1eThRMUQ1?=
 =?utf-8?B?cEFuSFZwSFA4SmFidG55c2JnY3NjaFNZbTFPMGNOZitua3dLbmFXRW9aMHBr?=
 =?utf-8?B?emVmUlNQRDRxZFM3U2RMNzRBa3hRcDZGTmcvcXh4YXJYdElCN1Ftb2hxa0hX?=
 =?utf-8?B?aGpTN0tCOVhUcGNiWFNnMlVnNExIMG1QREg1K3RIRFZFMFlIMmlwYVRtUFZi?=
 =?utf-8?B?L3VQaWdLQmRYRTdLOEF1ZnhVd3J5NnpsWUljeEYyOWpka1RDY2t2eDlzckF6?=
 =?utf-8?B?eFRYN2hvMDk4L1VIL3lycFhGOHdTOENyd3hmcXIzUmVCRHQ5WDhycjExc2xZ?=
 =?utf-8?B?bEFuSGNoazNXY012YWMvOWtRVVpwTE16UDNoUjlFTllPZHgrTEdhS1Q3UmZi?=
 =?utf-8?B?VkFCVFBlaDMvMFJxQnBaNmxKbUJPNHozaUplRUVsNTVYdUtBYUk1ck8zYVk4?=
 =?utf-8?B?UVpNRExCY1ZHcVVWZlhoUGhVb1lSd1c1VVJFYjlTS1lHTmdoc0FhZCs5YlNo?=
 =?utf-8?B?UnZsOC9GeWJEaUdBRUZtdFBIR0lRTldtRm05S2M1Tnp1dk1ibXk3UmNqVlhO?=
 =?utf-8?B?NERJUzExb0s5OEMybENTZjVzTFU4b3hSbk1HUkRSZWI4SkNNQzJBY0xEcUJJ?=
 =?utf-8?B?R05iVklEOEhpU3oyMlYzKzlQV1ozOVJvTy9Hdi96Mm1Eb3kzc1ViU2pobE9v?=
 =?utf-8?B?d1JWQ3g2eGJLTUs2MVduNjZGOUtkZmVyUllqdmFkcEJYcVh2ai9QdUZ1VUVG?=
 =?utf-8?B?RlVBMW5hZ2xRQ3JkbnhWQkRGeXREZVFHcGoyT2tYR2tNdlJpaElhUDNydHFQ?=
 =?utf-8?B?N1dpbE1rS2I2T1J2OCtvK1VYRUNLMTZLOTVWYTlyNUlSQ1hMQUxXZE9vMG5D?=
 =?utf-8?B?TlA3d0c5YUc4YUQ5Z3dnaDJ5MSsxbXA0MTdtcFVld044SG1xZXFuWExNVXZw?=
 =?utf-8?B?YnZDRHhhM3VIOWpFVVpZeFJnMEhpK3NaTlhTWUI0Nzd5Tm5CdEhieEtjYVRK?=
 =?utf-8?B?UlhoaHVnRGxtUVR0aTl3MllQYVF5cC9Ic0hqQzMzazk1b3EvMU13UWEzYitR?=
 =?utf-8?B?TSs4dnFyWE0rWEVpRnh5TWg0Qk8xcjRvLzdML1M0R0NxUExxN0oxNFhOWWlP?=
 =?utf-8?B?c3d4bjhQY0xvdDhNempZS25ad3ZDSm8xRzIyLzVTcWxKT0tsSlFiNGtNbUZN?=
 =?utf-8?B?UUZ0aHlLSnhsRk83QkpGemVPOUNzeHBQa2VlTlYrOExlWFlHTWhBaGFKNnpE?=
 =?utf-8?B?YUl0ZCt4VDJMckszVEgxOXFjNXl5WDhwUnF3cjJkTGRlWTZuUUlEOGpLaDBZ?=
 =?utf-8?B?dUdDVURsQWI2R3Iva3pRYTBUWFdCWjRHM2FtSERvbUlybVZEcHhSY2JmRDBF?=
 =?utf-8?B?Z3ZESmxqOXFQckV6VlRZbkRRQ3JIWVJaSDJwakJUeDRNNmN3UmZGMm1CQVhD?=
 =?utf-8?B?ZGZ0RXJGZUhqZndXODdKRFR3eFdwQzRsUmNZL2NMdjc0dVZEakxUblZMVFlq?=
 =?utf-8?B?SVQwRENyR21LUFB3OGFyNDN1L0YzMnNNWFMyZDFwRDl5TUpSZitTMlpQYWNX?=
 =?utf-8?B?Y3d3ZE11NU42MjBJSS96a0hiditiL3JnV00xRGtnYVZ6QW1HaDVMTlJuU1ZU?=
 =?utf-8?B?dHF3ektDdENCTDhmS1hGOUNjekRXZWo3Njk2VzE3YTlReXJ5a1hNTmhrZERI?=
 =?utf-8?B?OXJweDd6amRRL0Jkb3E0M280TWhucWhzZUFxMEEvVWl0SUxxMzM2T3pzWlpE?=
 =?utf-8?B?cW5scWFNNzRWQ3EvNDMraTNOOHdXSkdLRlVvV3VBNHZDczZFMUJGNEhuM0NL?=
 =?utf-8?B?cVVTMWpQcXByeHBMUzJpd2xmSUZ3OU41bjhSdzZSMWwyRC9TZ2pmYzBTTldD?=
 =?utf-8?Q?DYfsDfrAv2g1iTtos1blStLftYsqn/hA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aldrbGFzbUxTcGxPS3FsQUpRWFZJUVVNZG1SV0NsUGRlaG5vRGNRUUlFNm8z?=
 =?utf-8?B?KzZoTndxTnNhU3pacHZBbUdjWS9Xb1ZrdkxBNWVMMmR0ODRYakhnaVQ3dnYz?=
 =?utf-8?B?MXVkL1NCWmVueTdRcHVUSTZvTWc4K25ocnFDTTRvYThsZHhxdlNDR1BQTHFl?=
 =?utf-8?B?dndtOVFvOVBqd1ltUU9IRkpMNGpLM2YwNGFNZ1A2N21Gb25hb0VSd242aDhY?=
 =?utf-8?B?TUVFZm5ZYms1ZGFNUm5Ob1pvYTVxdjlzWnNCNElzZ2laak0rQlh6aHdYL3lv?=
 =?utf-8?B?R0JjRFJxTXZhZmpIVUpiWk54NDhBNXlvTlBGU0F0YUtONFp2eGJtNHVHdndV?=
 =?utf-8?B?akNaSVdJQjlnSU50S2dpUUlLeFE3UTlLMk1iZUR0cXhmZHNwcDQ4TWFoemxX?=
 =?utf-8?B?Y1I5eUxrdDZoTHNIYjlHSjE0V253Ujg3V094WlBCTlNvTE1oSXkveTZYQ01H?=
 =?utf-8?B?M3g1c3NXMFUvSndSTEN4SkJYSHJCSGQyN1VZTEc3T0tJaTBnelE3V2czSWpH?=
 =?utf-8?B?NGQyNHZFOXUzbHBsdWFrcjhpVUk1OWlNRzV2VzlISjRFSitUVmJpWEVBdGdD?=
 =?utf-8?B?Y3ZtdEJ0NFFvK3hEeWQwbitqYUhzd0Y3WFhpenpaY1FiTHRQNmFFUDgxWEsz?=
 =?utf-8?B?R0pLYUFoRmNzNGlOUmJsTnRwUWt4aFNNeWxISE0wbFN3Z1hoNkR2MllFcFRV?=
 =?utf-8?B?TzNxUllDOUgwelZjZStwWDJBTTlLcStTeG9HUzFueUNrcTJHNWlUYkRtWm0z?=
 =?utf-8?B?YkZPM1ZpTmcvaVNPS1BKYlRzRGJWUTlIbnIrV0t4SUIwVUVuaTZDVmVsNHRW?=
 =?utf-8?B?Tm4rUGRHYjJrdFlSRVU3eGRVR3JBalMzTWVaMEFFbDhtV0Q4WE9yTHVvY3Va?=
 =?utf-8?B?UEZVeUxRaE51NnVyY0wzM3JSbE9WNmdVV1hnR21JeTljekQ4WTJsblNkK1F4?=
 =?utf-8?B?dklZcCtnUitSQ1MvUitvQTZUQUhkUVlDNWVJdmFJOWdWemxBREsvM09zRGZQ?=
 =?utf-8?B?M3MyRkhvNUlqQXhyYjM2R1l2YlhxMjU1Ky9ISVdsa25GNldINXpvQkdtRVRN?=
 =?utf-8?B?eXYxcFp0YmNBZTR0K0dWL21jdSs3UENsYzJsdnpxdU5GUkhBU0dmSjdJUmdh?=
 =?utf-8?B?aU1pQUl6S3JVdGh6UldlQ09aMHM5WGNVUm1pNFQrSzE2NkFFUXF5Q2FvSzVh?=
 =?utf-8?B?bzJRdGVsMEgxWmt4bVNuN2x0NlY3TGNqemNUTDMwZmVLSTVXZkNjQk50OVFJ?=
 =?utf-8?B?dlBUemJKVG5Rc1R5UzZsNFZBc1pUd0lLbitKWmpJdUVJU3ZyMWtROW0wQ2lj?=
 =?utf-8?B?NTRBOUZZUFMwWlAydEp6d2U1OG42YmZSUUdHcmRneVoyZzJaVm13TTlBZzRE?=
 =?utf-8?B?MlREZEF6WWdydXpUNGJqaDNvQ2RQUGw2T3FJaWcvWW8xZVNVWlYxd2RrTEEr?=
 =?utf-8?B?cDNoTUFVTlJocDdVNDN4a1lhbStzQlNrWWQydGdDWEt4a2xwcVdKS25hTFMw?=
 =?utf-8?B?Ynlmcko1ajVVWHVySXpNM29BS1VkOUQxTkw4V29JTk9sUGVvbWVyeHB2dW5Z?=
 =?utf-8?B?OVFBMGpReWRhOG9PVVVwTm5MVmtleThhSW1PQ3NrS1hTVWRNeUMyZ3VCaGJS?=
 =?utf-8?B?VW0wYk5qZExsRVEySTR2T2ZkNU1xSkplVVI0dXorUFRnQlpGd1pURk9aVHdQ?=
 =?utf-8?B?OW5LQjdJendHU1JBTUtSbzFaYmRqbENnVWJOU1BiVkg1NFREMzNqS0ZVK0NO?=
 =?utf-8?B?U1R6OEpDMlBsM1lCSXJVSjVKTklVSE1MTDFrNURIRFBpSnY1M0ZrYkNMalgx?=
 =?utf-8?B?U1Y3aDRidTd4YStxemswTmVYcUZZZEFiUWVpUG1nVTh1b2laUFAxelk1VmlE?=
 =?utf-8?B?TGRuOXZEVms4MnNFMlFQZzE0WFNqWDNYdzREaWNPSmZMSkVvZi9DbnppOHlT?=
 =?utf-8?B?RUo1WkpkWXFWK1pXdFB5ZEVNa3R0eXptQUI1Rnl3VjdwY2s1MG1PSjB4RktN?=
 =?utf-8?B?YUV0TCtWTkNNQTB5dXNrL2Y1MForaGdwRUZXVzlIQjU2VERTME8rSDQ0UjUx?=
 =?utf-8?B?RzZKQm1qb0VJUTg5QmpaR0RUNlU1UWdQYjJrV2hxTmlYZ0xOTGVETkppa0JC?=
 =?utf-8?Q?un7Y=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c83508-99a2-452d-86ea-08dd4b84f344
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 16:47:34.5120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2hbiuevOwqb1PMNRCzEPIVufWW432vR2NwOVLgDKUgB7e/qi8BWWzYJ/ZbKpCXg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3NoIFBvaW1ib2V1ZiA8
anBvaW1ib2VAa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAxMCwgMjAyNSA3
OjIxIFBNDQo+IFRvOiBLYXBsYW4sIERhdmlkIDxEYXZpZC5LYXBsYW5AYW1kLmNvbT4NCj4gQ2M6
IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgQm9yaXNsYXYgUGV0a292IDxi
cEBhbGllbjguZGU+OyBQZXRlcg0KPiBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBQ
YXdhbiBHdXB0YQ0KPiA8cGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tPjsgSW5nbyBN
b2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBEYXZlDQo+IEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGlu
dXguaW50ZWwuY29tPjsgeDg2QGtlcm5lbC5vcmc7IEggLiBQZXRlciBBbnZpbg0KPiA8aHBhQHp5
dG9yLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MyAxNy8zNV0geDg2L2J1Z3M6IFJlc3RydWN0dXJlIGwxdGYgbWl0aWdhdGlvbg0KPg0K
PiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJj
ZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tp
bmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9uIFdlZCwgSmFuIDA4LCAyMDI1IGF0
IDAyOjI0OjU3UE0gLTA2MDAsIERhdmlkIEthcGxhbiB3cm90ZToNCj4gPiAgc3RhdGljIHZvaWQg
X19pbml0IGwxdGZfc2VsZWN0X21pdGlnYXRpb24odm9pZCkNCj4gPiArew0KPiA+ICsgICAgIGlm
ICghYm9vdF9jcHVfaGFzX2J1ZyhYODZfQlVHX0wxVEYpIHx8IGNwdV9taXRpZ2F0aW9uc19vZmYo
KSkgew0KPiA+ICsgICAgICAgICAgICAgbDF0Zl9taXRpZ2F0aW9uID0gTDFURl9NSVRJR0FUSU9O
X09GRjsNCj4gPiArICAgICAgICAgICAgIHJldHVybjsNCj4gPiArICAgICB9DQo+ID4gKw0KPiA+
ICsgICAgIGlmIChsMXRmX21pdGlnYXRpb24gPT0gTDFURl9NSVRJR0FUSU9OX0FVVE8pIHsNCj4g
PiArICAgICAgICAgICAgIGlmIChjcHVfbWl0aWdhdGlvbnNfYXV0b19ub3NtdCgpKQ0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICBsMXRmX21pdGlnYXRpb24gPSBMMVRGX01JVElHQVRJT05fRkxV
U0hfTk9TTVQ7DQo+ID4gKyAgICAgICAgICAgICBlbHNlDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIGwxdGZfbWl0aWdhdGlvbiA9IEwxVEZfTUlUSUdBVElPTl9GTFVTSDsNCj4gPiArICAgICB9
DQo+ID4gKw0KPiA+ICt9DQo+DQo+IEV4dHJhIHdoaXRlc3BhY2UuDQoNCg0KQWNrDQoNCj4NCj4g
PiArDQo+ID4gK3N0YXRpYyB2b2lkIF9faW5pdCBsMXRmX2FwcGx5X21pdGlnYXRpb24odm9pZCkN
Cj4gPiAgew0KPiA+ICAgICAgIHU2NCBoYWxmX3BhOw0KPiA+DQo+ID4gICAgICAgaWYgKCFib290
X2NwdV9oYXNfYnVnKFg4Nl9CVUdfTDFURikpDQo+ID4gICAgICAgICAgICAgICByZXR1cm47DQo+
ID4NCj4gPiAtICAgICBpZiAoY3B1X21pdGlnYXRpb25zX29mZigpKQ0KPiA+IC0gICAgICAgICAg
ICAgbDF0Zl9taXRpZ2F0aW9uID0gTDFURl9NSVRJR0FUSU9OX09GRjsNCj4gPiAtICAgICBlbHNl
IGlmIChjcHVfbWl0aWdhdGlvbnNfYXV0b19ub3NtdCgpKQ0KPiA+IC0gICAgICAgICAgICAgbDF0
Zl9taXRpZ2F0aW9uID0gTDFURl9NSVRJR0FUSU9OX0ZMVVNIX05PU01UOw0KPiA+IC0NCj4gPiAg
ICAgICBvdmVycmlkZV9jYWNoZV9iaXRzKCZib290X2NwdV9kYXRhKTsNCj4gPg0KPiA+ICAgICAg
IHN3aXRjaCAobDF0Zl9taXRpZ2F0aW9uKSB7DQo+ID4gICAgICAgY2FzZSBMMVRGX01JVElHQVRJ
T05fT0ZGOg0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuOw0KPg0KPiBOb3RlIHRoZSBQVEUgaW52
ZXJzdGlvbiBtaXRpZ2F0aW9uIGlzIGFscmVhZHkgZG9uZSB1bmNvbmRpdGlvbmFsbHksIHRoZQ0K
PiBYODZfRkVBVFVSRV9MMVRGX1BURUlOViBiaXQgaXMganVzdCBmb3IgcmVwb3J0aW5nIHRoYXQu
ICBTbyB0aGlzIHNob3VsZG4ndCByZXR1cm4uDQo+DQoNCk9rLCB3aWxsIGZpeA0KDQotLURhdmlk
IEthcGxhbg0K


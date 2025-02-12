Return-Path: <linux-kernel+bounces-511631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA50A32D7C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578C13A5B90
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B5A25B681;
	Wed, 12 Feb 2025 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5MXTKjP2"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B46256C7D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381307; cv=fail; b=Jycu4c34fOOaxwk6uvtdLYwQjXs3bWgA+mOmpvWO+DGWf2d53X1jPt2PKlvBsY7nakkq27mU1ZlmBs/rBcA9CoyD85WBaM2qyYtedDeywoOrsHvUPAPSDtf5xWhf5OC1VXpiwqMp5dOyIEtrVT1/k4i9pUExJNJ1fXzBD8/NPzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381307; c=relaxed/simple;
	bh=ImxukFAlBX+W/70P33rWzK6TJ2hVQLIr3Ttry+zDlfU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QhKqpDZ/XugVKznOOyLOLy58cq+fPQw8ukl2nBtLio4df5xLeqmTn2FoI4O4lTkYvBY1BfNbplMIfAx6Ng3Jrr+vPlmIrBCdg7+XqWhZbWPcKy3A8C3G+CugN8Mk2RGFJC7ERB8ZltVA8BfiMrGi2yJ/Wha0CJNeAT2Mg4qSnfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5MXTKjP2; arc=fail smtp.client-ip=40.107.96.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1HBs50sdKmzHTPbNkhNM6qwAIVc48OJnrqEoATNYIhsQLa2LyY3JnFd3SwpI7c9znQpUBfGWn9ouSPx7qVl6xuOB57KisSWQmtSj+bgwXdYRh2h0KsFCQQ0wuNeIirHVV5H9+GniQiGpmtGOnBQGYgJ73wfWok04HZ5qT0irfsDX2zXIgwyT6MFPDXux+j480X3flD8wR85UkV9eGVBWl5FVEBvA5C/hfSJjw12+zus7lXkWsbORG5r6jkxQ9MSBifDCdO88jJRVgTXCqzrUb3GljiIlsOxX1Lx6zMhcrEo2wDHgDCadjOkmtL++EDtEe9yGLzVwk6IE6kVIZw0tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImxukFAlBX+W/70P33rWzK6TJ2hVQLIr3Ttry+zDlfU=;
 b=HD5i61GwiFlEKaXs7H0qhbJ0jzv0EMjlWHjQTzehGL8d34drQfREle3lVPPywll+pvyM1p3Zje2WDcfspgCo1WU1uXbLt/YvFKBJi51V4FaAJwn/V44p/bnrZFefWyIa36PX70JHPQOM5+RXpLM1YanP9uJosc4Wwn7W8cXYgDH5OEC4i7DhmEsgkVKxO7peEUXZJF/4JckspjnGZD/ihjc6N5wf/h7QRw43S5PwTq5w8rW4D1wMIyGfWjOp5ejcHEgWNZVfkqpcWgwxcDPJOEHhmc5FyGmjozs3YrbR31TaS2fvUgvnJulp17pkGHLEJaTs4sqrY1G1F/SG4aU1Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImxukFAlBX+W/70P33rWzK6TJ2hVQLIr3Ttry+zDlfU=;
 b=5MXTKjP2gIh9ZzqIEHZN78OGVZaIJnx3lU9cljmbKcnzxTLI28fRcVG1XOX3wyVY1DmfgISJSzqFe5eJFX0b3Hh3HawRyF+d57qZn0lx2jWuvpG2U2MX21uDKFzmTcmnUtCLj7Y92KTx/TVmpShrEsQ2/h+V/ILo8asaExDP9Ks=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 17:28:23 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 17:28:23 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 06/35] x86/bugs: Restructure mmio mitigation
Thread-Topic: [PATCH v3 06/35] x86/bugs: Restructure mmio mitigation
Thread-Index: AQHbfBOuckoYbW1FJkubQrZxxdetIrNChtuwgAA3joCAAS+HoA==
Date: Wed, 12 Feb 2025 17:28:23 +0000
Message-ID:
 <LV3PR12MB9265E88D27667AE6BAD9F7F394FC2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-7-david.kaplan@amd.com>
 <20250210232951.x4mbmpjy57jpunb5@jpoimboe>
 <LV3PR12MB926503692B759DF39113626294FD2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250211231839.bmcgj4vnvjyba74d@jpoimboe>
In-Reply-To: <20250211231839.bmcgj4vnvjyba74d@jpoimboe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=90192af2-d99a-4f1e-9188-395d1553e75a;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-12T17:25:01Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DS7PR12MB5765:EE_
x-ms-office365-filtering-correlation-id: 6996df99-9f7a-4be2-29dd-08dd4b8aa6b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VDNRODdXcXc4cVltTXBpcWYvcDFCQjZPb3hkRTIwRjNzbHZzQ0pmVEtZV3JZ?=
 =?utf-8?B?cDhsanBMdmJjZnhWWTczOEFQZit4WExaYzluM05CclNmenovdERxbGlDeE44?=
 =?utf-8?B?T3BqVzlmUmhWZXRRUjRTNW9DcUV5TW4wdFpaSWxOdWMvSHBUUmhBM3hDL3gw?=
 =?utf-8?B?RkpqRm93VW1FNlNQbDZYUFlmYzFLUmZrNG1vMk5rWVpWa29FTHo0N0FMTDJT?=
 =?utf-8?B?ZVpBaGdlVHg3Y0o3T0ZHREZkNW9zVkpYUTRvcnFvdjNuMjFWbTVDSjJmaDN3?=
 =?utf-8?B?T3BpNU5sWDVoMm15aUNMa3g2NC9ka09WeW5sNmcvdHZ6SVhnRlJLcVVUazNW?=
 =?utf-8?B?Nm42SFJJMlVydW1VcEtXMUNNSW1hT0ZabUJtaXhuZThpNVN4VGdPalhpYWFT?=
 =?utf-8?B?MVJaZmVCQ2RTdDU3WndrUXMzOUlLa1hWbTF5c1E5ZVpMcU5TcGZLNDQybmgr?=
 =?utf-8?B?L1p2LzNGbmYyM0VxeTZPNlB1ZHJydWZmRVZ4bHFwZFI1Sjg0UDNUdEhpR200?=
 =?utf-8?B?QXN6Nm9xc09tQUJ4ZlMzVHhteTAzbzZBaVdzdTkwN0g0cUoybjJFeVNuNzl3?=
 =?utf-8?B?STdXNlJnL3YxS0NzZUozWGFWakZNNmlkaW4yeU15L2ZLWWdEODhiV3JQKzBx?=
 =?utf-8?B?WXhKNjBTVGNrNnZhVTk4dkRIblFKNkRRTXFQbHQ1QzZUY1ZNamlNa3VTZmw2?=
 =?utf-8?B?S0NLRlgrZzR6WjRub09XVXB6UTkzZTZSMkRZa0thbG9RUjhwWmIwSkRrdzRZ?=
 =?utf-8?B?M0pLeWpUZzFEVTZvZUhNZHFMb21IQUJpL3g4OGJFa2pxa2hUT3dYZjNRZW95?=
 =?utf-8?B?Y0hJOTlyRExERk94NjR4U1JzNWV1ZUpaWkNtT0szSHZDR1FSYXpaUWFXYUZ1?=
 =?utf-8?B?OWpVbmlUUVBwL1pWM1FTT1lvOEtRMGVBV3AvR2ZLNjk5WWUzb1k4Z0FzMGMx?=
 =?utf-8?B?NlgrQllkWkhCb2pZa2h2MldwTTdYNmIyNWU5K29kemoxdHlNSTlVMzdLTlQv?=
 =?utf-8?B?TXdQVks3c1hRYWFFSjRqT0MyblNTQkJrcUVoWDZZbVNmcVR1cUhzNXQrUE5B?=
 =?utf-8?B?QkYrWVl3R0J5RWMxK1lVWHdlQlF2T1RzNWNzUURqcXVLRGlzK09HUnNOK0dN?=
 =?utf-8?B?VHZ2N1M2OVlZQjFNNStWSzBvM05lN3RpQnltVHZSU3NMUEZLSHFkd043R0R6?=
 =?utf-8?B?dkpmYTBiZWxYRWVpangrN3YxTTN3UTh4Y2RLaDVxUTR6dCt1TUFNMzJuZnJT?=
 =?utf-8?B?TDl2R3J0YkNkQ2NJeENLT0kxeENwNk52SEZCUGZBZXdyV2w4U3hSTStyWUhs?=
 =?utf-8?B?cUdmU2dGbC9VczRRRXZDTHlqWC81MHJ0TjNFODRYQnBGam1OdE1zcUduNmF6?=
 =?utf-8?B?MG82Q1FuRmZkRWY3WVZSemdFUmh0S2p6TlZidWZDTnpLZ1ArL0xERGlPc3R1?=
 =?utf-8?B?dnd2N01DN1BOL1VGbXJsMUx5am1yVnY5Y1RSZWErMmRjL0E2ME5wVWVPL1Iv?=
 =?utf-8?B?MmgxbkxvdEorSHVjRGdPOGFqRnp2ZjRkZXBSREhtR29XRUpKSm9ra3ErcWU0?=
 =?utf-8?B?NmMrQjhtQi9yell0ai9HbHVqSVVVRysvamZHT3dLSEFucWtrMEJ2TlZqTURk?=
 =?utf-8?B?OGRjWkFKMjdpekRpUGNUamlsZHloYjNQNGJ0bnpVVEYrZVhTaEJGRDBNNVZX?=
 =?utf-8?B?dFRUQ0lTYklwN2lxeDE0MWpkSG1ZSWxmMnlnQ0lWZGE0T3FHUjJyM3czdFN4?=
 =?utf-8?B?aWxseUNnVndUeVFuZWtHM0x6WkgwTWtlaVdiOHFZNW12WnRVQ0pmaEd6ZGpR?=
 =?utf-8?B?MHIvU0NFWWFkbGZhazBFeHhTL3FHblB2T2Y2eTY3M2xUbGprMlRicnBzRmJ2?=
 =?utf-8?B?MnM3WlB6dlFUdW1MbDJwUDJSbGVzakFzcWE1ak9vc042YzJRcXg2dDBoNmJL?=
 =?utf-8?Q?trqio4aeEfjx0Zbm3tP2rLskbAcFvSlQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGFBSThNZ09xQk1Wc0tEV3ZzQ3lXd096R2JpTTJJbW0vOVVuSnJIUzMreXVG?=
 =?utf-8?B?YXBTUDNRZFNidCtlWTVKVVBwNFVDK3pXUmNXc1Y0QnlxYkR1d1d5bnFPelc0?=
 =?utf-8?B?S0JMbjFqS1VuMkhHczBkWDBoblVtUmNXYUVrZ2tHdlZzMitORTdPWVpMNWNC?=
 =?utf-8?B?UUlUOGFXSndwWFBnN3NPYS9YcWRFVCtjVjY5MmpMSUpQZGtLT0NpNCszRHRy?=
 =?utf-8?B?Ti9mVk5zNnpucUN0VGpMc1BsK0J5aGlWdnlYSzRGeFR0SjE4L3JaUnVkQjNt?=
 =?utf-8?B?bkhBVFZHV2FiUWo3TGdKMi9zTG9OdXZaRzhzYTZSb3ppZlU1cDRGZUI0U0wr?=
 =?utf-8?B?RDczRXNzdk1ZcGJBR0N5djJHbC9sZ0syMXJrMmlWUnZCb1VnVkJVK0lGdXh3?=
 =?utf-8?B?SHU0U3RMc0ZlcEk5bTVvWWhFejVtSjZDc0FSZUZ1OVlWZE5FRGQyMFA0NWdU?=
 =?utf-8?B?Sjl6Sm5oR2VTSkltcWVBV0hmQlo0Vm1OSTlxNFRVVWFKWFFzcWtESTYvOFM3?=
 =?utf-8?B?bXRFMFVQMWR2ME5KeE9LaDNFQjRzckhLa0NqQ2QxejZZVTYvZUE3eDRuQ2pL?=
 =?utf-8?B?NU1Tajd6Y2FjbVFwN0paMEllM0JmQlZFb1lIcUNEaXU4RW9LdCtHV01pRzEx?=
 =?utf-8?B?d1BETE91Y1UrSzZYRDM3eVQxckJSQUJIZGdnK0FuaHhSbmF5dkhZNDNJRWlz?=
 =?utf-8?B?OSt1WGVqRncxN1hLUHZ4eE9pdkd4MzA2OGJMLzdQZFE2aTBRVXYzM3E1U0wz?=
 =?utf-8?B?TlVZeDFneVJUei81bnJZTEZ2MFkzYVR3TzV3Q0hKalN5ZUJzWnVTOURSZjU3?=
 =?utf-8?B?NFh3WFdPYkJMNnBXWDBlSGNPZFNUQjhuWXBtMmsxbkZ5cXB0azV1ZFNGYmRU?=
 =?utf-8?B?OUlUQjArL0FybW10dUJOcjBRQVgxdS91eUl0WU05eXRTVDVETmRDMVZBZTBa?=
 =?utf-8?B?dFNuV0NvY3RDeVhWWUIvSHNDSk9NQ1Y3UnBid2FBNU1rMkdwTVNjSElETUpX?=
 =?utf-8?B?YXZMTjh3YUdDWXA5UUNoWnN2NW5Gbk95bHFnNmlmYzVoQ0k3bUFZdDhuemN3?=
 =?utf-8?B?VUF5NTRXU3d2WU5kVUcxU25ycVpoeTMzTjZaUklDTFpwdjgxdWUzanNpbGNx?=
 =?utf-8?B?Q0w2TTl1RVlJemVRdU5GdnpNVTdwbGwwOVVjSGZkejcyNjR3bjIrS21GaU90?=
 =?utf-8?B?U1RXVXJMbzRFRjZSMHAxNndXVG1UZ1laaVZiYi9LY2taOW5GZXVzL0NRVG9k?=
 =?utf-8?B?YzFZNmVuUUZydGRrU0ZueXlOK2d5WkltdFpldFpMdXAzeWhWRWQyTEs5SStO?=
 =?utf-8?B?SFhxQ1BtYVlHdXQvQnY4YUs5Nit4emZkR0w5eDhLNjlYMGNxTmFWYnhhU3d6?=
 =?utf-8?B?SE1Xelo1UkNvdi9iUkZaSEo2bkVtV1NIVVRsaWU1clBSS1hoZ2hKTDg3UURi?=
 =?utf-8?B?cUprbjBNRGt3VE5ibm1ZZ3ozMXN0N2lrRTJDTXQrZUswTEdvNFR1d29Tc0N4?=
 =?utf-8?B?SnlPTXpOTGdBaDA0UGxUTEhiTjRSdzIrMjhBejZWaW5wdUhzUVRsTjB2L1Bz?=
 =?utf-8?B?anBiLzlSRjljNXdPZHBjL0ViUUNyOGNwWk12Z09SbVdvY253T2NpK2FiRWZV?=
 =?utf-8?B?ZUUyeDJTbFRZWnZmaS9XT3NQVmlNZk5nVGlJZkpYUm9JWTU1VGc3aUJCS0po?=
 =?utf-8?B?aC9zeUVhL1FKM1BVblJrZ1dNd0YwbkFMWVBkRGl5RXJUamNxVjc3UDZqQkdJ?=
 =?utf-8?B?Q2RVTjViendpd3dQeEJxeXo5R2Uremd0bERmRlhteUhnSVR3MHZYbWlXR0Er?=
 =?utf-8?B?TTFoZ1RZUWhFb1VYeVlvZlQ0aldHdTdQWkhqZjdiK0tGOTlhQVBQS3FzZG5Z?=
 =?utf-8?B?dHF2VFJqcngwOERqRWY0UTZORlQ1VVp2UzhSUHQxWFZ6U0dHb2RNbTJ4L1o0?=
 =?utf-8?B?SWRPOTFGZEhocjRtVmFaeUordklmVGpYa2UrMXdHRnE0aUtYZVFJVkRBK1Uz?=
 =?utf-8?B?b0lwbUFOeUVlUTc3enNVUVU2YTFYVGQ2bmtpWkRmYkN0a01FWWFuelAvVUY5?=
 =?utf-8?B?YVQ1dHljaldVWkVlcy9KaUIxRFR0MmZKeHhRd054VjVuVDQ3SFl0d3hPdHZy?=
 =?utf-8?Q?nHvU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6996df99-9f7a-4be2-29dd-08dd4b8aa6b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 17:28:23.1029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q7lh7xlvK57r+ovUk0sfizp98SX+sVfBO+LsMfe1vxwzMRXj2mZhdpwmFprKyk+E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3NoIFBvaW1ib2V1ZiA8
anBvaW1ib2VAa2VybmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMTEsIDIwMjUg
NToxOSBQTQ0KPiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+DQo+IENj
OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47IEJvcmlzbGF2IFBldGtvdiA8
YnBAYWxpZW44LmRlPjsgUGV0ZXINCj4gWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsg
UGF3YW4gR3VwdGENCj4gPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IEluZ28g
TW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgRGF2ZQ0KPiBIYW5zZW4gPGRhdmUuaGFuc2VuQGxp
bnV4LmludGVsLmNvbT47IHg4NkBrZXJuZWwub3JnOyBIIC4gUGV0ZXIgQW52aW4NCj4gPGhwYUB6
eXRvci5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjMgMDYvMzVdIHg4Ni9idWdzOiBSZXN0cnVjdHVyZSBtbWlvIG1pdGlnYXRpb24NCj4N
Cj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3Vy
Y2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNr
aW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBUdWUsIEZlYiAxMSwgMjAyNSBh
dCAwODozNToyN1BNICswMDAwLCBLYXBsYW4sIERhdmlkIHdyb3RlOg0KPiA+ID4gPiBAQCAtNTM4
LDIxICs1ODIsNiBAQCBzdGF0aWMgdm9pZCBfX2luaXQgbW1pb19zZWxlY3RfbWl0aWdhdGlvbih2
b2lkKQ0KPiA+ID4gPiAgICAgICBpZiAoISh4ODZfYXJjaF9jYXBfbXNyICYgQVJDSF9DQVBfRkJT
RFBfTk8pKQ0KPiA+ID4gPiAgICAgICAgICAgICAgIHN0YXRpY19icmFuY2hfZW5hYmxlKCZtZHNf
aWRsZV9jbGVhcik7DQo+ID4gPg0KPiA+ID4gUmlnaHQgaGVyZSBpdCBkb2VzIHRoZSBmb2xsb3dp
bmc6DQo+ID4gPg0KPiA+ID4gICAgICAgICAvKg0KPiA+ID4gICAgICAgICAgKiBFbmFibGUgQ1BV
IGJ1ZmZlciBjbGVhciBtaXRpZ2F0aW9uIGZvciBob3N0IGFuZCBWTU0sIGlmIGFsc28gYWZmZWN0
ZWQNCj4gPiA+ICAgICAgICAgICogYnkgTURTIG9yIFRBQS4gT3RoZXJ3aXNlLCBlbmFibGUgbWl0
aWdhdGlvbiBmb3IgVk1NIG9ubHkuDQo+ID4gPiAgICAgICAgICAqLw0KPiA+ID4gICAgICAgICBp
ZiAoYm9vdF9jcHVfaGFzX2J1ZyhYODZfQlVHX01EUykgfHwNCj4gPiA+IChib290X2NwdV9oYXNf
YnVnKFg4Nl9CVUdfVEFBKSAmJg0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9SVE0pKSkNCj4gPiA+ICAg
ICAgICAgICAgICAgICBzZXR1cF9mb3JjZV9jcHVfY2FwKFg4Nl9GRUFUVVJFX0NMRUFSX0NQVV9C
VUYpOw0KPiA+ID4NCj4gPiA+IElzbid0IHRoYXQgYSBjcm9zcy1taXRpZ2F0aW9uIGRlcGVuZGVu
Y3k/ICBpLmUuIGlmDQo+ID4gPiBYODZfRkVBVFVSRV9DTEVBUl9DUFVfQlVGIGdldHMgZW5hYmxl
ZCBoZXJlIHRoZW4gdGhlIG90aGVyDQo+ID4gPiBtaXRpZ2F0aW9ucyB3b3VsZCBuZWVkIHRvIHVw
ZGF0ZSB0aGVpciBtaXRpZ2F0aW9uIHJlcG9ydGluZz8NCj4gPg0KPiA+IEkgZG9uJ3QgdGhpbmsg
c28sIG5vYm9keSBzaG91bGQgYmUgbG9va2luZyBhdA0KPiA+IFg4Nl9GRUFUVVJFX0NMRUFSX0NQ
VV9CVUYgdG8gZGV0ZXJtaW5lIHRoZWlyIG1pdGlnYXRpb24gc2VsZWN0aW9uLA0KPiA+IHRoZXkg
c2hvdWxkIG9ubHkgYmUgbG9va2luZyBhdCB0aGUgb3RoZXIgdmFyaWFibGVzIGxpa2UgdGFhX21p
dGlnYXRpb24NCj4gPiBhcyBkb25lIGluIHRoZSB2ZXJ3X21pdGlnYXRpb25fZW5hYmxlZCgpIGZ1
bmN0aW9uLg0KPg0KPiBCdXQgaXNuJ3QgdGhhdCBhIGJ1ZyBpbiB0aGUgcmVwb3J0aW5nPyAgQUZB
SUNUIG9uZSBvZiB0aGUgbWFpbiBtb3RpdmF0aW9ucyBmb3IgdGhlDQo+IGNyb3NzIGRlcGVuZGVu
Y2llcyAoYW5kIHRoZSAqX3VwZGF0ZV9taXRpZ2F0aW9uKCkNCj4gZnVuY3Rpb25zKSBpcyB0byBm
aXggdGhlIHJlcG9ydGluZyBpZiBzb21ldGhpbmcgYWN0dWFsbHkgZW5kcyB1cCBnZXR0aW5nIG1p
dGlnYXRlZCBieQ0KPiBzb21ldGhpbmcgZWxzZS4NCj4NCj4gRm9yIGV4YW1wbGUsICJtZHM9b2Zm
IHRzeF9hc3luY19hYm9ydD1mdWxsIiByZXN1bHRzIGluIGJvdGggTURTIGFuZCBUQUEgYmVpbmcN
Cj4gcmVwb3J0ZWQgIk1pdGlnYXRlZCIsIGJlY2F1c2UgdGhleSBzaGFyZSB0aGUgc2FtZSBWRVJX
IG1pdGlnYXRpb24uDQo+DQo+IEJ1dCBpbiB0aGUgYWJvdmUgY2FzZSwgd2l0aCBYODZfQlVHX01E
UywgIm1kcz1vZmYgbW1pb19zdGFsZV9kYXRhPWZ1bGwiDQo+IHNob3dzIE1EUyBhcyB2dWxuZXJh
YmxlIGRlc3BpdGUgaXQgYWN0dWFsbHkgYmVpbmcgbWl0aWdhdGVkIGJ5IFZFUlcuDQoNCkRvZXMg
aXQ/ICBJbiB0aGF0IGNhc2UsIG1kc191cGRhdGVfbWl0aWdhdGlvbigpIHdpbGwgc2VlIHRoYXQg
dmVyd19taXRpZ2F0aW9uX2VuYWJsZWQoKSBpcyB0cnVlIChiZWNhdXNlIG1taW9fbWl0aWdhdGlv
biE9TU1JT19NSVRJR0FUSU9OX09GRikgYW5kIHRoZW4gZW5hYmxlIHRoZSBtZHMgbWl0aWdhdGlv
bi4NCg0KPg0KPiA+ICAgICAgICAgLyoNCj4gPiAgICAgICAgICAqIEVuYWJsZSBDUFUgYnVmZmVy
IGNsZWFyIG1pdGlnYXRpb24gZm9yIGhvc3QgYW5kIFZNTSwgaWYgYWxzbyBhZmZlY3RlZA0KPiA+
ICAgICAgICAgICogYnkgTURTIG9yIFRBQS4NCj4gPiAgICAgICAgICAqDQo+ID4gICAgICAgICAg
KiBPbmx5IGVuYWJsZSB0aGUgVk1NIG1pdGlnYXRpb24gaWYgdGhlIENQVSBidWZmZXIgY2xlYXIg
bWl0aWdhdGlvbiBpcw0KPiA+ICAgICAgICAgICogbm90IGJlaW5nIHVzZWQuDQo+ID4gICAgICAg
ICAgKi8NCj4gPiAgICAgICAgIGlmIChyZmRzX21pdGlnYXRpb24gPT0gUkZEU19NSVRJR0FUSU9O
X1ZFUlcgfHwNCj4gPiAgICAgICAgICAgICBib290X2NwdV9oYXNfYnVnKFg4Nl9CVUdfTURTKSB8
fA0KPiA+ICAgICAgICAgICAgIChib290X2NwdV9oYXNfYnVnKFg4Nl9CVUdfVEFBKSAmJg0KPiA+
ICAgICAgICAgICAgICBib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfUlRNKSkpIHsNCj4gPiAgICAg
ICAgICAgICAgICAgc2V0dXBfZm9yY2VfY3B1X2NhcChYODZfRkVBVFVSRV9DTEVBUl9DUFVfQlVG
KTsNCj4gPiAgICAgICAgICAgICAgICAgc3RhdGljX2JyYW5jaF9kaXNhYmxlKCZtbWlvX3N0YWxl
X2RhdGFfY2xlYXIpOw0KPiA+ICAgICAgICAgfSBlbHNlDQo+ID4gICAgICAgICAgICAgICAgIHN0
YXRpY19icmFuY2hfZW5hYmxlKCZtbWlvX3N0YWxlX2RhdGFfY2xlYXIpOw0KPiA+DQo+ID4gRG9l
cyB0aGF0IHNvdW5kIHJpZ2h0Pw0KPg0KPiBJICp0aGluayogdGhhdCdzIGNvcnJlY3QsIGJ1dCB0
aGlzIHN0aWxsIGhhcyB0aGUgc2FtZSBpc3N1ZSB0aGF0IE1EUy9UQUEgYXJlIG5vdw0KPiBnZXR0
aW5nIG1pdGlnYXRlZCBidXQgbm90IHJlcG9ydGVkIGFzIHN1Y2guDQo+DQoNCkkgdGhpbmsgdGhl
eSBhcmUgZ2V0dGluZyByZXBvcnRlZCBhcyBtaXRpZ2F0ZWQgYmVjYXVzZSB0aGUgbW1pbyBtaXRp
Z2F0aW9uIHdhcyBlbmFibGVkLg0KDQotLURhdmlkIEthcGxhbg0K


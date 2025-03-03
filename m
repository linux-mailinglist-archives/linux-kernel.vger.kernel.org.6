Return-Path: <linux-kernel+bounces-542409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ACCA4C99A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D283F3B9869
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EE22405F2;
	Mon,  3 Mar 2025 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G1dVonaV"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00223215193;
	Mon,  3 Mar 2025 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021477; cv=fail; b=Joj4kxkGIxgqS2FGhzAwrvcRy+EixOEgKcYDwxeCiIcoeq4zhxQVBCwvYr4s9oklmxIh1FQUx2Tdh7edQPnz51/EGAQpMNN4cyeBaqD5dzs1O1IjYL+7wbsH7Y+GCESMaeZQbHX/zgSInDxkhre4vidM+krpr/sci4QE9s29yck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021477; c=relaxed/simple;
	bh=KgWptd1QjGeycfUGEufQAIxGdpS0fqdQ4xWCk9pJQ20=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AcvySmn4UeyKOWtjxwRdbdjY7vVU6EbJD6pvEkFnfrZVOg20vAi3qeM5wjXnSAgbhqvg8rb8RtZi0Fx00o7nrC8F9XzfyHbd12E0C0fFgi8DVWoeuaKVnAJ7e2nuKEXHl62yIpwsPb+C1S9kACK4xepTxggAY6FWdfm2ijunEUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G1dVonaV; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SShMP+CAOc08XT6tZ64/c022C+5yoObaH1Gvuvmsvt6bNM3g8hhbrACbRa2snp2odiKxKRpANoz0Lp3XNaHMRQk7lk/bklxtenVB4RRseXIfUnVVZSPGoMF0coYyUj9G2PNGYq83pGji6eCYByJ57JeybsREV6sjpkc6J0CPm6Elb8dEEqLcHJmUO24DnIRj1vPmsVWxI+tMpqisJXExJhQ3224j1kCM/1R207tD7cdi38LzGoxwQuq5Arm0XA2woUtiAu10dc/Qe3vp6uKUugeYVr//O6NAwvaNFbhuqe2oPJWzv0HVCjUX2R7148JfnRJqEQwG0iO8sQwh9PVh/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgWptd1QjGeycfUGEufQAIxGdpS0fqdQ4xWCk9pJQ20=;
 b=HRfwPqTgP1oOjAdbo6fJMuDVQKmAySJp6HaDHCJq+dNmTJ+m8DUZXa6Ej3TwFjrqvtoQZqijz3sJXXm6XspljifwsJNswnlsDpXCUF7H0etgxZX3SFyPlAt9v1BKFZ3dRkQxgB445ylu/+5VcaAUzfhrEWr0GXZF+/pEY0CRPJSN8PFxUCZXTXjax/S+f1EFisaPCyAGEJbDck/eFSMaEo1EHZxsY/uoSlqKMpXmCN8Dzj2j961Xq5y4p/AmOx6vYp//0pns9NP9rKRemPa5mm8BodIV/a/V1n7608dH/yqEX5OST7zTc8KywFWSuatI8gebfNAcOyTsFl6RELSP5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgWptd1QjGeycfUGEufQAIxGdpS0fqdQ4xWCk9pJQ20=;
 b=G1dVonaVM58ZFJw3cCLev5CH/o4FGRLiJZYMWe/T1ShMnx3yda0xAyYZd97an8J+dz2H9CIUInFXC64sa5CTTYNnJUFbBVkqTigjeZXWZwJdQANenGUI2Ns+oHd0OkG71mFrwKAvAPFGy6h6XH2rmf/bkJXvGN6HvXOEm5CW6aE=
Received: from DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) by
 MW4PR12MB7437.namprd12.prod.outlook.com (2603:10b6:303:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 17:04:32 +0000
Received: from DS0PR12MB6440.namprd12.prod.outlook.com
 ([fe80::6576:7d84:1c66:1620]) by DS0PR12MB6440.namprd12.prod.outlook.com
 ([fe80::6576:7d84:1c66:1620%6]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 17:04:32 +0000
From: "Nirujogi, Pratap" <Pratap.Nirujogi@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
CC: "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Chan, Benjamin (Koon Pan)"
	<Benjamin.Chan@amd.com>, "Du, Bin" <Bin.Du@amd.com>, "Li, King"
	<King.Li@amd.com>, "Rosikopulos, Gjorgji" <Gjorgji.Rosikopulos@amd.com>,
	"Antony, Dominic" <Dominic.Antony@amd.com>
Subject: RE: [PATCH v1] platform/x86: amd: Add ISP platform info
Thread-Topic: [PATCH v1] platform/x86: amd: Add ISP platform info
Thread-Index: AQHbi/lRPFcNs+OJNUSl4jCuybPPvrNg/2mAgACcsIA=
Date: Mon, 3 Mar 2025 17:04:32 +0000
Message-ID:
 <DS0PR12MB6440CF4D8D72A843EE7D73D2FEC92@DS0PR12MB6440.namprd12.prod.outlook.com>
References: <20250303050102.2298520-1-pratap.nirujogi@amd.com>
 <1a9d0962-4cdf-47a8-a0b4-5b4b2e0df207@kernel.org>
In-Reply-To: <1a9d0962-4cdf-47a8-a0b4-5b4b2e0df207@kernel.org>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1e23e3e1-bf57-48d3-891f-a4f55f359944;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-03T16:33:41Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6440:EE_|MW4PR12MB7437:EE_
x-ms-office365-filtering-correlation-id: 84e6e228-c88b-4076-0d70-08dd5a7577a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UFV4VGxCNUVIVEsvSU5Pa00vWEkrVFNpTG8rUnZJOXRIWTh3cWw4blEyK3lk?=
 =?utf-8?B?VHJYb20ySUVGcC9QNDZvK3BSUXhnenAxellrRjM4K0pyRnZYbGErNklBcElR?=
 =?utf-8?B?dG1RZ1pldlZhU3NxTE9tZTR6TGxBNGZQaUQySnBhMHB2Y2xGajRoSnRGdGpI?=
 =?utf-8?B?WHlqd3EvRWh6WUFYQktDQlRuUXBDdzZLVHBqME5JWExzakd1V2MwVExrMTdk?=
 =?utf-8?B?RXVMK3RhRjFXVDBGdHVVOG9OUDFCdjNRQUFlYWtXc1BERG8zclNBNHI4T2Uv?=
 =?utf-8?B?OENZM1hSK0pVTHdVNHpZaGltY3UvcWRnWjhDVmpoc2loMy9HM1E5Ukt1ckRL?=
 =?utf-8?B?S3FXR0FCbjhhaVFDV1dERWE5bVhvMEJZZDZMdW9mUklwUVdGVTAyd09GSENq?=
 =?utf-8?B?MnVRWmdGSXF4K3R4M1FsYlErUE9hb3B5QW11NDBDRit6WHh2RmtUUnlhM3hT?=
 =?utf-8?B?bnVXSWdXajdwbVcvSWY5Nm1Xc2ZwcnA3Tnp4Mm1FZXdPakNBMitCQ25sT0Jm?=
 =?utf-8?B?NHgxcnU0OVJjRmhrdWU1M1hqQzN1ek5MZzFWNlJ3UGI5aXlrNGJjRW5NWjlI?=
 =?utf-8?B?ZUNHa0lQY0JSZ0pLZzllc2VKaGZrTlBNWWZzQjhhNGdlRk9wTS85bHhRS1kr?=
 =?utf-8?B?ZGJkeHVHREFHYmQvcCsvTi9EU0JYTWdpcGxSb2hnY25PY1RzTnhEVW9ydXhP?=
 =?utf-8?B?ZEtZMCs2VnJuWGJ5dEFYN2o3MnVpM0M4MDhWem11Z3NJd2k5T1N2dGdxeXJJ?=
 =?utf-8?B?T3hXUHBjS2pTRTRYOTlOajk4SG9tMVJweDUveGgreW1lOGM3TlBLbEpHUXk3?=
 =?utf-8?B?bUkzbUJyWHdRYm5rNXd5ZFowLzVVMXR6QTc1emp5TXFWNk15OEhmR0xTak0y?=
 =?utf-8?B?UUFJcjdrOWZ1VzZSSzdkN2JITFVTVVZ3eUJhcnh5YjNNM0R3WGV0Rnowb3I5?=
 =?utf-8?B?WTIwZkt3UmtnZUV0UWlraytZUGJvZEM5NXZJNVVSUitDN1laQzZaZVdTcGFq?=
 =?utf-8?B?THBzQmFPait5d3RMQXVTbU80SUdNTzAxZ0V2UDZwYjdid00rVjdMc1dmbWpp?=
 =?utf-8?B?YmxyQVJveGlzdzRVdUhnc093ZXg0ekpDR1VrNjZiUU9zNFhkK0F2NmhkM2JW?=
 =?utf-8?B?UmpEOEFibWkrVUtpTjBUbkZrZi9LT0RLdUdQNTgzNWZiSzdEczdXY083T3VV?=
 =?utf-8?B?ZHd6WlZzWC9RZTlwNXZZMnA0QmhyS3c0OTFRM2F0eVozbG83YjcxL1pEbFJp?=
 =?utf-8?B?SEYxYjZ2VHFEdWdjdlpBTW1nL2ZNU2QxZUU1TXFyV1RzUDZEVUI3QWpUVHQ4?=
 =?utf-8?B?dXAzbEl6VzFYMzJOL0RjZm9pUnJsTnVpOTdsMTFBakNnTTFDeFJxTDh1clpU?=
 =?utf-8?B?TC9kQ215L2YzSmlIT3NVcGpaSHRUTnVzRFhlcTFrME9SVWNHNEh5TVZPWStq?=
 =?utf-8?B?NlBXRzltWEN1cm1hLzlxbjVmQjl1cDB3aXczZk1DZ3BQdTliNUFJZXNnTENw?=
 =?utf-8?B?RUFoNmdFbEpYODlXeXFUeUZ5MFRHWVFsdkpXbDl5cVdlMGp4RjRUMDV6SXRD?=
 =?utf-8?B?ekJnVWlTZVhjaFVLSFZVN2NZb01FbmxkWjVMWG5CVjV2eG5HTkJzSHhaa0pv?=
 =?utf-8?B?N1Nza2NCK3ZpTE5XbU5lenVEdnk4UzBsRUlqUXBwbzZROWZldzdKZ1ZjaXdq?=
 =?utf-8?B?a3Z0cnRNQW51UVgzTkZRYXBjWTZFNzRXSTR2dEk0OXUvR1ZCNXhjZWw4cVp0?=
 =?utf-8?B?a1RNVXE0cm1EN3FObFF4YjNwMjVTSmxaWmxxT3hGQTl4bTRBcFhBSjFqTGVM?=
 =?utf-8?B?YUhBTTd2Y0Yva3hUNHk4cHkyRyszWDRDT1FMN1dLaGtCV2pMNFhwY2ZKWnFB?=
 =?utf-8?B?WktvYmpGR2VxRG10NjJVOGhVU1IrMmdYLzZDcnlva3hIYk5YMXg4QytrblZF?=
 =?utf-8?Q?GC3pebQ80lm1i5tl7+NdB7a5NCPK/8yt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6440.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c2hBR0dsVXhMQUpad2dVYmI5NWllcmtjN3A1SUtMdk11cDJsNTREcFZKQzRW?=
 =?utf-8?B?UzFqa1VJQmJyVldKdDl6Q2k5MXBQbUlWZklWb1Jkc1BNRnZJYXhReHVlc2ph?=
 =?utf-8?B?ZXdGdEUwa1VpNm81Q29rb0c5OFRsTkpFNzBVU0NsaURKaDh1Q3NndnBKK1RU?=
 =?utf-8?B?VzRMRTZPWEx2NkxFOEtZdXMxTWlWM0lJblFwbXZSTWlORXdqcEpYcmplMlNa?=
 =?utf-8?B?MWV3bzFRUHRzbFNIRk5TbURFRWtXMjdKOGFsK2pBVC9xa1ZHcGtWNmhuays1?=
 =?utf-8?B?V0ppQ0RMWnFqZGk0Vzk2Tk5KV0NIUzFJb3ZVRGd6bU5sOTM3dlRiOGhLNlFJ?=
 =?utf-8?B?bmlPM0FkSFg3TWZuZzV5bHFVZ3ZHem1zL0xHZVo2aVlnZld1Q2ZDdkVqV2lO?=
 =?utf-8?B?WTUwVnE3N3FwNHlkcHZXSlRoTjdJWE45Ly9PdzFGUE5kL1k1K3QxSzF0aS9t?=
 =?utf-8?B?T2FPQ2REaTdYZFlFY0ZmR21Hc0RZTmdpMC8vRHVDbHZUR1BDZmxoaDlTcW5n?=
 =?utf-8?B?ZWVybExvNm9iZVphVVFlelpSZ2VvTmp4SzluZVpwd2I1cXpaVm11M0lydENO?=
 =?utf-8?B?Zk9yQ2ZvRWx4bjkyeElHVHpkOWxPOTFDSWVCOVg5RjJZNFl6RE43dEtuWVVB?=
 =?utf-8?B?OWd3ZVFBY2s0bkZUdjAxUzZKOUtCMUpNSlAwMmNrTFNYRFpJbFduRU5QZDUx?=
 =?utf-8?B?WUhmelBVTUt0b29hTFlCSW1KOFFnOTJpa0Vuc1AwekJ0VzBHWFRoUUw2K1FU?=
 =?utf-8?B?ZC9RM0FLRmQvVnlmelFaRSsrRTdtNUFCS3ZaVUIyUU1QRTB5V2JBcUdNQnQ1?=
 =?utf-8?B?L09Dd2xZeWRkSDhBcWRTbFR1OTRlcVVGSm9DUm9FWmpKWU1XdWdmWG1NY084?=
 =?utf-8?B?KzMySllwaUF1Y0l1eFFqTUhRRU9LMHhURXdkWlBLUlBnZUtobXVoYnloRVh6?=
 =?utf-8?B?MndZcERzaFlVVFNwTkxmeFdWZWQ4TmhjYThIeVZBdFRma0lZa0dxL2ttcDV3?=
 =?utf-8?B?SkRJV293NTdXb0QzSi9ZNk5RRC9ycG1SdnhnNnEzOUJ3aXMzVDM1L2ovY29U?=
 =?utf-8?B?eTZHUDI3OU1vK2Z5WXFGVm8wK0hBWUpWWGFsdUg3MFJzWEVFdHJHanR6YldP?=
 =?utf-8?B?RDNaMjk2TUZ6YUV5SU43bld3cDhPUzB0TFk2NllaOVdOczEvMmRRaFJ2dlVW?=
 =?utf-8?B?UzdOZ2p2RytFRTZmZU5mN093RmNBVUxRZ1QzSVdrQzQyaG5ObzZuczBCbWRS?=
 =?utf-8?B?clBYV3VzSE9FNXdMWExHQ1FCUmR3Nmhqa1pkTDlabEo3enNZdFhGZ01lb2o2?=
 =?utf-8?B?dzY2T2pNcHpSNlltcTJOY1JmMlJhSlpXMnlKMDZHZ3BDWjVXeHJkV25hL0R1?=
 =?utf-8?B?RDBhdkVMYm9nMmZEaTRyNlB4T2NmMWFSZ0w4dzlyWGVsTHlaTHBwYmZpdVcw?=
 =?utf-8?B?YVY5R2VzNi90b1dOZVlJczZDdG9ERElrb3lvWHhlQW9YKzduSmJtOVFEVXE0?=
 =?utf-8?B?U2ZkRTRFUWhHK2VnNG9lOUdHQW11ckozaVhNazdEdmFsRG5RNDZ5QU9pT1JB?=
 =?utf-8?B?UnJIRVY0bDM4bSs1dmovMXZEODRMQis3VXFodllTV2tmcEhrNDZCRGZ6Z00r?=
 =?utf-8?B?TUltV3JtdzBWT0lmZjViVEFmMkFqUW5xRC93UGZ5QlFFVEVCZFFEdHhRbjNK?=
 =?utf-8?B?ZmhEcHNMVHZoZ2N2RHVtVXV0b2p6VlFaN2tPQjVRSEFHeXEyYTNqMllsYmtC?=
 =?utf-8?B?eGpFT29qTFp0WjcycFNqQmF3Z3hUbEVxNCtUbjA1VGM5TGt0V0dsenp1TzV1?=
 =?utf-8?B?L2V4eG43dXhBaWhJc3RwL2FRbkhYbC9kK2xiQVpmaTFqTlFMYjRPZTY4ekZT?=
 =?utf-8?B?VGgrd3B1UXIxdFljbFVaMkdjYlN2SGhseE1lK3FlNE1YTTNLWDlocnVGUnlZ?=
 =?utf-8?B?UU8rdTlOMU5xUDdwQ3N1WmFiL3dlZnRsMVpEc09ZSC93L1JhQnJDSG5uOFhP?=
 =?utf-8?B?WmcwUDFpNEpuV0Y2d1lMS0E4QmNJd3kzV2ZReVRZMStqZjJKaVRpdnVWdGRM?=
 =?utf-8?B?QW5Ed0xjNTRlcUdWdTBNVEVnVXdscEM5UHBkbnJ4eXFRM3NtWE9SSkVrNTk5?=
 =?utf-8?Q?KgRw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6440.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e6e228-c88b-4076-0d70-08dd5a7577a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 17:04:32.0624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kx/JrgTJeJIR2LC4kt8oJJ0q7O0cQGiUFqS2ltb14TnG5JHT07Vw5XpVJUf0mKDWEE+lZ+boX4Iuad/6pL5dEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7437

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgS3J6eXN6dG9mLA0KDQpJIHNob3VsZCBoYXZlIGNhbGxlZCB0aGlzIHBhdGNoIHYyIChp
bnN0ZWFkIG9mIHYxKSwgc29ycnkgZm9yIHRoZSBjb25mdXNpb24gY2F1c2VkLCB3aWxsIHRha2Ug
Y2FyZSBvZiBpdCBpbiBteSBuZXh0IHN1Ym1pc3Npb25zLg0KDQpIZXJlIGlzIHRoZSBjaGFuZ2Vs
b2cgZm9yIHYyOg0KDQotIEFkZGluZyBvdjA1YyBhY3BpIGh3IGlkIGNoZWNrIHRvIGVuc3VyZSBw
bGF0Zm9ybS94ODYgYW1kLWlzcCBkcml2ZXIgcnVucyBvbiB0aGUgaW50ZW5kZWQgQU1EIHBsYXRm
b3JtLg0KLSBVcGRhdGVkIHRoZSBjb3B5cmlnaHQgaGVhZGVyIGFuZCBsaWNlbnNlIHVzZWQuDQot
IEFkZHJlc3NlZCBmZXcgb3RoZXIgY29tbWVudHMgZnJvbSBNYXJpbyByZWxhdGVkIHRvIG1vZHVs
ZSBkZXBlbmRlbmNpZXMgYW5kIG5hbWluZy4NCg0KSSdtIGN1cnJlbnRseSByZXZpZXdpbmcgdGhl
IGZlZWRiYWNrIGZyb20gSGFucyBvbiB2MSBhbmQgd2lsbCBmb2xsb3cgdXAgdG8gYW55IGZlZWRi
YWNrIGFzIGEgdjMgd2l0aCBjaGFuZ2Vsb2cgYXBwZW5kZWQgdW5kZXIgdGhlIGN1dGxpc3QuDQoN
ClRoYW5rcyBmb3IgeW91ciByZXZpZXcgYW5kIGd1aWRhbmNlLA0KUHJhdGFwDQoNCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2Vy
bmVsLm9yZz4NClNlbnQ6IE1vbmRheSwgTWFyY2ggMywgMjAyNSAyOjEzIEFNDQpUbzogTmlydWpv
Z2ksIFByYXRhcCA8UHJhdGFwLk5pcnVqb2dpQGFtZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8g
PE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBoZGVnb2VkZUByZWRoYXQuY29tOyBpbHBvLmph
cnZpbmVuQGxpbnV4LmludGVsLmNvbQ0KQ2M6IHBsYXRmb3JtLWRyaXZlci14ODZAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBDaGFuLCBCZW5qYW1pbiAoS29v
biBQYW4pIDxCZW5qYW1pbi5DaGFuQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBw
bGF0Zm9ybS94ODY6IGFtZDogQWRkIElTUCBwbGF0Zm9ybSBpbmZvDQoNCkNhdXRpb246IFRoaXMg
bWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNh
dXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9u
ZGluZy4NCg0KDQpPbiAwMy8wMy8yMDI1IDA2OjAwLCBQcmF0YXAgTmlydWpvZ2kgd3JvdGU6DQo+
IEFkZCBvdjA1YyBpMmMgYm9hcmRpbmZvIGFuZCBHUElPIHBpbiBpbmZvIGZvciBBTUQgSVNQIHBs
YXRmb3JtLg0KPg0KPiBEZXRhaWxzIG9mIHRoZSByZXNvdXJjZXMgYWRkZWQ6DQo+DQo+IC0gQWRk
ZWQgaTJjIGJ1cyBudW1iZXIgZm9yIEFNRCBJU1AgcGxhdGZvcm0gaXMgOTkuDQo+IC0gQWRkZWQg
R1BJTyA4NSB0byBhbGxvdyBJU1AgZHJpdmVyIHRvIGVuYWJsZSBhbmQgZGlzYWJsZSBJU1AgYWNj
ZXNzLg0KPiAtIEFkZGVkIEdQSU8gMCB0byBhbGxvdyBzZW5zb3IgZHJpdmVyIHRvIGVuYWJsZSBh
bmQgZGlzYWJsZSBzZW5zb3IgbW9kdWxlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBQcmF0YXAgTmly
dWpvZ2kgPHByYXRhcC5uaXJ1am9naUBhbWQuY29tPg0KDQoNCkRpZG4ndCB5b3UgYWxyZWFkeSBz
ZW50IHYxPyBBbmQgcmVjZWl2ZSBjb21tZW50cz8NCg0KPiAtLS0NCg0KV2hlcmUgaXMgdGhlIGNo
YW5nZWxvZz8gV2hhdCBoYXBwZW5lZCBpbiB0aGlzIHBhdGNoIGNvbXBhcmluZyB0byB2MT8NCg0K
DQpCZXN0IHJlZ2FyZHMsDQpLcnp5c3p0b2YNCg==


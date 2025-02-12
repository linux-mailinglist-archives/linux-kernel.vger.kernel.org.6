Return-Path: <linux-kernel+bounces-510311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD596A31B05
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669F0164F2B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE89D1DFED;
	Wed, 12 Feb 2025 01:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cGWhdg2r"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2099.outbound.protection.outlook.com [40.92.22.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3126EFBF6;
	Wed, 12 Feb 2025 01:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739322598; cv=fail; b=Wa/x/cTEPqz8+8fprpKid9umdBd8o054E/ZVp5LpG2ouzpyvx5kpftuOUWjgKHzgOJpTOQnP5IUM56DQgfA14Cloyv02DHAdMMDr4w+YSfkg/j4dtlcxRtciY6HIUqYPsfWk1k+XpDzgRhq4k2mBGVwuzefX2q8YGxl0XcOKqOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739322598; c=relaxed/simple;
	bh=2Dbn2teUeL9/A45aHDWNl1KFhPUNIw+NGLeHTRizsT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JOYA/wmMlfELcQ/BpsRFT0RLNxfNCUI28lUnzRLZOZInhwGKpkOVpogO4YK3ECNLYERHG/3xSqPOUc9xj7s1Kbz65+2NdU742hcjDTeE4gTfATRbG0Kx9usKjM8W/JdxWdVOVBoT/rZwjNHZ5Vs9FGc0589o9W/xSpkza/3VMfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cGWhdg2r; arc=fail smtp.client-ip=40.92.22.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0Cza8yhJRtff+TTgtn+NxLizHgltL5k2i5ViER6kRJ9+oWX13DZZnQgtKqZ5I5VnFec68uUqpRluSXZnaTIUtEdNOiGhnf6LoEU1If+yyopNAFYShKZTk01ukdHlMP8Rs0L9LgN5RDbPpRDtYgNDFr7oUVWzc5cFUwBX4wadDDMr157Dbt3O6Dps5CeeA8UCVYHhWSdzLrc2pacVvwiHzxMB954jTnsVWtVAoEk1rZPAevlX73HhxFPpjWA9XWaoeNYzxOUJl1JHkRm1sXV4nbCYFv+wJR8eMgiFoZRfkxkHoLDg3Np6cwYeR+6PKP5haYWtQFE+JeMQd1Q7glMOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Dbn2teUeL9/A45aHDWNl1KFhPUNIw+NGLeHTRizsT8=;
 b=yVU06VuCqVylanFcAvjQi4O/rhwPNLiwLB83dYhwUpKaS2FhRtKqdDmwhpONtK01AD8J9miAqdAYfDbXTkmWVHve4FqN/0DnUhTmQ5U0T/HkDadAa4NmIAWxGnb02IFvlavwEOi9v80b1sSR9PlNI29nLa93Rkp2g72C1lA9Vip6Hz7RejtBVINSm153/MgxnwKyS+RVDU/yF9bKI5CudfPGDQ6iPyYWL4h7odaM0rEcqy5yMnSVntUtax5Z/Q18D96OhvoA/qy3h1jQ6bmoeMtgeGDt47qHDNCWN1MRVlTW5ERTBXZHqcoyFPoo5OYCoWWbw/VdSjN6tC18ppa05w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Dbn2teUeL9/A45aHDWNl1KFhPUNIw+NGLeHTRizsT8=;
 b=cGWhdg2rfS6sIS5HjL+NOLLInhCtmXOR4TfrsQkprNSwlbfNb7D92keB/rnPmIqzU0IkebMsrs9fwDs4mM9tqLeZvY7n/X0WCblStI3T+oL/dkNvvsYX8qIoYI9uBj+281TzP3A8eC8glOMF6pEH2HgBrQl9FFZXofE3QM4EsAJGV8G8TU6eh2U5ziL7rLsAgRMeVZ+biQN7Mk1wfGyITaCG5yjHHv3l3twGbc80FUF/sGWpyNhKlqP3mUZ5MtDrgz6BmqQsIDJ20cBS4h3vn/rSm3sv64wL2wp0Kwl+GLN9ujJQ2MJPmkqG1Ule2N1/eKdUGHQqB3JO8L1OTwioqw==
Received: from BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 01:09:53 +0000
Received: from BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991]) by BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991%5]) with mapi id 15.20.8422.012; Wed, 12 Feb 2025
 01:09:52 +0000
From: Zhou Stephen Eta <stephen.eta.zhou@outlook.com>
To: Richard Henderson <richard.henderson@linaro.org>, "mattst88@gmail.com"
	<mattst88@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC: "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch/alpha: optimize virt_to_phys with compiler automatic
 sign extension
Thread-Topic: [PATCH] arch/alpha: optimize virt_to_phys with compiler
 automatic sign extension
Thread-Index: AQHbfGT8bXQnnoZcCkuc2ewxr4TU+7NCUeAAgACKJ0g=
Date: Wed, 12 Feb 2025 01:09:52 +0000
Message-ID:
 <BYAPR12MB3205F7AB3307D62DAC5B8977D5FC2@BYAPR12MB3205.namprd12.prod.outlook.com>
References:
 <BYAPR12MB32057EF854A36230B5BC7E1AD5FD2@BYAPR12MB3205.namprd12.prod.outlook.com>
 <a1803d33-c92a-4294-acd0-a2152fb0c163@linaro.org>
In-Reply-To: <a1803d33-c92a-4294-acd0-a2152fb0c163@linaro.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3205:EE_|MW3PR12MB4364:EE_
x-ms-office365-filtering-correlation-id: 8fa0d25e-23e9-4296-f3cf-08dd4b01f451
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|6072599003|8062599003|15030799003|19110799003|461199028|8060799006|102099032|440099028|3412199025|41001999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?VGFPS1lGVFdoM3AzSFpiWFRSMHV0M1U2aEsvOWM5Zm1QanN3U05HQkRkc21P?=
 =?utf-8?B?Z2RNMlg4TEpFcVk1clhNSi9jS1NhWHlVRlYrQVpXU0F6YS9vQ3JPMkJhUk1y?=
 =?utf-8?B?dE9JTVNhdnZqRCtHeDg5Qkk5ZXpkdDNmR3RoMDdFelF0dlVsWGJWQjdNQm43?=
 =?utf-8?B?VERsQmQ3OVdKRzkwYmFMdUVFcGd6UlJvcEVLaUZnYVBzbUg1cUU2bzEyUEFZ?=
 =?utf-8?B?MGcwbHN4NitPUTh5QURvSE5mK25RUXJ0aVJYdENmTVh5RldnWldLeHhCT0hV?=
 =?utf-8?B?ZENzWFBIWnFaU21BMFViM3QzVUlMSkl3YnpFSHNQWTczQzBtOEdqalJDN2E0?=
 =?utf-8?B?cUNQc1RIWGN1bytRT0t0NGpTRkVQajNtVWc4Ri9Ld3lZeXRZQ21aRlBhODBG?=
 =?utf-8?B?eWdIaFlReDEzblorMndDMUR4RzBwQ04rLzdQUXlZZExicFh6SmhVYWhlL0Mr?=
 =?utf-8?B?bXNGSmN3dkJkZzh6UUwzcmprTGNpK3ZyL1NyNDZncmttaGNnTWpoaktxRDk1?=
 =?utf-8?B?U284U2lDa2dGdk5JSDB5Rkh4VVNPc0ZPMTNzUHB1dDl5NlczUzA0eWQzTDQ4?=
 =?utf-8?B?T29XQTFnbDVGZVAva2FSeVRUYzhRbGxqNmNTQmVxOElkZHQybXprbXJoaVZD?=
 =?utf-8?B?ci9kN1g4VllBOE0xQW1oQ1Y5VHFscFZiTUJKeVM4S21remV5M1FoUCs5a2hH?=
 =?utf-8?B?aDYrbXBLY0JmN05zWmE1WUxqdzBQMTgyY1J4bWxrK3h4Y1pTZU5UeW4yQ3BK?=
 =?utf-8?B?UGJVc0dGaUp4aGpUTnA1VHRVQ0dnK3VWdDVBTmRJZkdQaGJrcStqeVJwbWRr?=
 =?utf-8?B?Q01Mb01nN0hUWURoRmt6a3dRUkNDQ2RpOUR1THZrTUV1R0hCRnZlQlBFOVgy?=
 =?utf-8?B?T3NmVmdnbTBVbTBJUmYwY0lpUnhVTUlhMU1tNFNydnc5SVljZmQ0SSthTnZI?=
 =?utf-8?B?UTluS1JoVWlobEkxV3VnOENiQzdiL013T09xUHpxelRpRm9PS012a3B6OTJL?=
 =?utf-8?B?YkN2djk1ZUtqekJlM3BSd1pkc0o5NGYvN2FicU5IbGNnUjVoc1N0M2EvbWRS?=
 =?utf-8?B?dVgxdXVjWG1qS1FRbDlSRVNzclYrQldsVHUzL0FxWXJ3NnFteGZCSTJhL2tI?=
 =?utf-8?B?dHZUWlFDbXZrN3dNdkdJVEZQS1RiejhGQkNPMWtONkRSNzl5QVFzOG11eFF3?=
 =?utf-8?B?aHpyaml1OGtkVDZoQWpleEFhWDU1MXFLZVZDREFnTFhGS2JEeENWbFZUSjNE?=
 =?utf-8?B?VlVaWmpMSlBucnduaENyTUI5cUN2Z2h6bWhvTW5XWVUvdUJZM2tzbVR2YVg5?=
 =?utf-8?B?MjVULzFNRHR4eC9jalpsTmpaYlZMSkpmS1pObS9HZm5nNmNlWmN5UTNCVkVC?=
 =?utf-8?B?dGtZTnNrTno5UElwbWNRUmRiN0lMZ0toWVNONm5ES0RWcjUvNVA2aEpFVEVM?=
 =?utf-8?B?QXFoeFVUSnQrTkNYYUdwYmI0RG1WU1cyL005ZEt2RE41WHpKc3YwV2dUQUFk?=
 =?utf-8?B?Q0VNTDZhUnh2T2I3NGZFV2RsRWFIcFdyL044SW5LK25idUxDOE9TVFNqMGph?=
 =?utf-8?B?VXZZUT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UE9KamE2R29qNUdhNE9pdlJqOWNnRUlORkY5MjV2di84T1ZZOHpidlh6YzZS?=
 =?utf-8?B?aUJaNjhSM3BFY0M2RFhWd09tQUg1anU3K0lJZDhwajNEem5hNnpGdDNrNjNE?=
 =?utf-8?B?c2FUNTQ3aDA4TTR2bjNKenV3UkRGRVA1Q0R5R0RVQWplMTdhUDdwd1lZemEr?=
 =?utf-8?B?RThnSUJJSzNCQjhyR2ZKZ0cvdUkyK1F3NjdGQ3NiczFTUklvNGUzSVJCWDBV?=
 =?utf-8?B?Mlg2U2NwQnlRWVZrQmlPU05CUGcyOGU4ay9EWHA3RXZSOEFnL29uOXdnOTlt?=
 =?utf-8?B?SzR6dHdvTm1xU2FTd3MxeDk0c1A4R3h2RXRUSGEzVWc4dWIzdkRlRnVGK00y?=
 =?utf-8?B?Q01Xc1V2YVNCUUFxMng2OWo0YmRoQVErWXNabGdGR2JoYTJHWGRLUUVtS2x4?=
 =?utf-8?B?VDY3d3o3bk1lcUhnQ2xWRHp1Z3FDdVJZelROVjhhdlg3a0M4b2x4N0JHZ01i?=
 =?utf-8?B?dHE3SEVGUWx0VzQ3aG0yeERrVW9HVDJIVUhkOHRxUGJ3SWs4dlBwRUw2L1hk?=
 =?utf-8?B?YjZMM2ZKSGErQ2VjbXVtbHR5TzdHOXB4Nm1KN1cvYWJwRTl4MWZQUEJnbFN6?=
 =?utf-8?B?UjVkVW9UVTM4UHBQbFhVTGJMa1RHcEVOV3FVQWJjZWoyVmFUWkk0ME9SUnVE?=
 =?utf-8?B?UEhXSVFpcU5jOS9QMVY1VjRlWkkzbHlBVkptbnU1bXEwOWZhQ3FidVdtRG5T?=
 =?utf-8?B?NjJvbFg5ZE5jZ3E0Yk8rRlh4ZW9YSDM1MVZML2VZRW5CN0c4UnpxeDQrbWJo?=
 =?utf-8?B?RzJ0WWdCMDhQWUZhRGJtUUFTQzg4UWtCdUx1aVk2cjdWTEVxMFQ5TWFydHYx?=
 =?utf-8?B?eGVOOUpKUWl2d0pHZ0N1RFpJaDlYRDdKMTRqNk5KdHhBb3BPQjFseFhUTDNq?=
 =?utf-8?B?eXZCM3JvK3M4RDEvcGZzYll0NHdueWttSHc5NTdNMVoxNUxrc2FQYXc4Nlp1?=
 =?utf-8?B?NW1rWXlZT3FLUXRrYy8zckd3WHo1aEh5TVdJRURrWDBza1M5L1UzWE9DSWhD?=
 =?utf-8?B?ZUFqcDBrZS8wUVlzdHVyMFV1bERNUWs3NHkyL2VzdWVBVlorWmZDaEVDZ0hq?=
 =?utf-8?B?bTdTOGZrSW1LcEhLTUY4YS92TVp3QUJSdGNxMmtyOEdvM25DRTMvMTlvNkRu?=
 =?utf-8?B?QjlvU09XVVVJZ2s4V2VvSFFmK2NvVTdFUWxYUnYxd3BiTStRa1pKUjlCWHU3?=
 =?utf-8?B?alJzMDZraXJuWm0xL0xvUy9NWFJ2TERmbG0vemtaZkR5R2ZQL0loYU90RXlj?=
 =?utf-8?B?OVE5Z21aQ2l6WTJwQ2wwL2Uxdk85MktTbE9FNmJnanVGZSsyR3NVVXhZMURD?=
 =?utf-8?B?bVNPR0RCYWRNZm5jSklVajc3UnlTOHdtcWNZNGFoeDFqaVpHaHl5cHIxN3Y2?=
 =?utf-8?B?OVhURHdjYXhRckJSQWI1YlMzVm1Ib01MeVlPY1lwQXRjcHQ5cmRmQUNsWEhn?=
 =?utf-8?B?SmZUdWVCc0VrRm1HS2p0T1UzK3MwNlpoVnQ5aWhQYzZzeTRMMWxaY2hCRGtO?=
 =?utf-8?B?Y0w5YW9oQ2lqL3U3WGlvMmx6STl3OUYwVHUyVWFFVFg3N29Ba2ppZEl2cEdr?=
 =?utf-8?B?QWRydk1qc2hReEVKTkFFdzVsd3ZnempEZXc2Zy9RT0VxS3NlanpyUE9CRWFW?=
 =?utf-8?B?dFFKYmtZdDBZVEFiZ09yWENFK0R3aHZVOXAraTFDZmN0ZWNaRFZCMGhZUHZ1?=
 =?utf-8?Q?H+NC552mRdpsEAkVs+vB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa0d25e-23e9-4296-f3cf-08dd4b01f451
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 01:09:52.2243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364

SGkgUmljaGFyZAoKPiBOQUNLLsKgIFdoYXQgZG8geW91IHRoaW5rIHRoaXMgZG9lcz/CoCBXaGF0
IGl0IGRvZXNuJ3QgZG8gaXMgc2lnbi1leHRlbmQgZnJvbSBiaXQgNDEuCgpJIHdvdWxkIGxpa2Ug
dG8gcHJvdmlkZSBzb21lIGNsYXJpZmljYXRpb24gcmVnYXJkaW5nIHRoZSBwYXRjaCBJIHN1Ym1p
dHRlZCBmb3Igb3B0aW1pemluZyB0aGUgdmlydF90b19waHlzKCkgZnVuY3Rpb24uIE15IGludGVu
dGlvbiB3YXMgdG8gcmVseSBvbiB0aGUgY29tcGlsZXIncyBhdXRvbWF0aWMgc2lnbiBleHRlbnNp
b24gYnkgdXNpbmcgdGhlIGxvbmcgdHlwZSwgcmF0aGVyIHRoYW4gbWFudWFsbHkgcGVyZm9ybWlu
ZyBiaXQgc2hpZnRzLiBIb3dldmVyLCBJIG92ZXJsb29rZWQgdGhlIGZhY3QgdGhhdCBvbiB0aGUg
QWxwaGEgYXJjaGl0ZWN0dXJlLCBsb25nIGlzIGEgNjQtYml0IHR5cGUsIHdoaWNoIHJlc3VsdGVk
IGluIGEgc2lnbiBleHRlbnNpb24gZnJvbSBiaXQgNjMsIG5vdCBiaXQgNDEgYXMgb3JpZ2luYWxs
eSBpbnRlbmRlZC4K77u/Ckkgc2luY2VyZWx5IGFwb2xvZ2l6ZSBmb3IgdGhpcyBvdmVyc2lnaHQu
IEluIEFscGhhLCB0aGUgc2lnbiBleHRlbnNpb24gc2hvdWxkIGJlZ2luIGZyb20gYml0IDQxLCBh
bmQgSSBtaXN0YWtlbmx5IGFzc3VtZWQgdGhhdCB0aGUgY29tcGlsZXIncyBhdXRvbWF0aWMgc2ln
biBleHRlbnNpb24gd291bGQgd29yayBhcyBJIGludGVuZGVkLiBJIG5vdyByZWFsaXplIHRoZSBp
bXBvcnRhbmNlIG9mIHJldGFpbmluZyB0aGUgbWFudWFsIHNpZ24gZXh0ZW5zaW9uIGZyb20gYml0
IDQxLCB3aGljaCBpcyBjcnVjaWFsIGZvciBwcm9wZXIgYWRkcmVzcyBoYW5kbGluZyBvbiB0aGlz
IHBsYXRmb3JtLgoKQmVzdCByZWdhcmRzLApTdGVwaGVuIEV0YSBaaG91Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KRnJvbTrCoFJpY2hhcmQgSGVuZGVyc29uIDxyaWNo
YXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPgpTZW50OsKgV2VkbmVzZGF5LCBGZWJydWFyeSAxMiwg
MjAyNSAxMjo1MiBBTQpUbzrCoFpob3UgU3RlcGhlbiBFdGEgPHN0ZXBoZW4uZXRhLnpob3VAb3V0
bG9vay5jb20+OyBtYXR0c3Q4OEBnbWFpbC5jb20gPG1hdHRzdDg4QGdtYWlsLmNvbT47IGFybmRA
YXJuZGIuZGUgPGFybmRAYXJuZGIuZGU+OyBwYXVsbWNrQGtlcm5lbC5vcmcgPHBhdWxtY2tAa2Vy
bmVsLm9yZz47IGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZyA8bGludXMud2FsbGVpakBsaW5hcm8u
b3JnPgpDYzrCoGxpbnV4LWFscGhhQHZnZXIua2VybmVsLm9yZyA8bGludXgtYWxwaGFAdmdlci5r
ZXJuZWwub3JnPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZz4KU3ViamVjdDrCoFJlOiBbUEFUQ0hdIGFyY2gvYWxwaGE6IG9wdGltaXpl
IHZpcnRfdG9fcGh5cyB3aXRoIGNvbXBpbGVyIGF1dG9tYXRpYyBzaWduIGV4dGVuc2lvbgrCoApP
biAyLzExLzI1IDAxOjMyLCBaaG91IFN0ZXBoZW4gRXRhIHdyb3RlOgo+wqAgRnJvbSAwYmYyZGQ4
MTZjODM2OWUyYzY5MDg2OWI1ZjZjNjcxZjI4YzJiMTk2IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAw
MQo+IEZyb206ICJzdGVwaGVuLmV0YS56aG91IiA8c3RlcGhlbi5ldGEuemhvdUBvdXRsb29rLmNv
bT4KPiBEYXRlOiBUdWUsIDExIEZlYiAyMDI1IDE2OjQ4OjE0ICswODAwCj4gU3ViamVjdDogW1BB
VENIXSBhcmNoL2FscGhhOiBvcHRpbWl6ZSB2aXJ0X3RvX3BoeXMgd2l0aCBjb21waWxlciBhdXRv
bWF0aWMKPsKgwqAgc2lnbiBleHRlbnNpb24KPgo+IEluIHRoZSBgdmlydF90b19waHlzYCBmdW5j
dGlvbiwgdGhlIGZvbGxvd2luZyBjaGFuZ2VzIGhhdmUgYmVlbiBtYWRlOgo+IDEuICoqQXV0b21h
dGljIFNpZ24gRXh0ZW5zaW9uKio6Cj7CoMKgwqDCoCAtIFRoZSBtYW51YWwgc2lnbiBleHRlbnNp
b24gY29kZSBoYXMgYmVlbiByZXBsYWNlZCB3aXRoIHRoZQo+wqDCoMKgwqDCoMKgIGNvbXBpbGVy
J3MgYXV0b21hdGljIHNpZ24gZXh0ZW5zaW9uLgo+wqDCoMKgwqAgLSBUaGlzIHNpbXBsaWZpZXMg
dGhlIGNvZGUgYW5kIGxldmVyYWdlcyB0aGUKPsKgwqDCoMKgwqDCoCBjb21waWxlcidzIG9wdGlt
aXphdGlvbi4KPgo+IDIuICoqRml4IGZvciA2NC1iaXQgQWRkcmVzcyBPdmVyZmxvdyoqOgo+wqDC
oMKgwqAgLSBQcmV2aW91c2x5LCB3aGVuIHRoZSBpbnB1dCB3YXMgYSA2NC1iaXQgYWRkcmVzcyB3
aXRoIGEKPsKgwqDCoMKgwqDCoCBuZWdhdGl2ZSBoaWdoIGJpdCAoc2lnbiBiaXQpLCB0aGUgc2ln
biBleHRlbnNpb24gY2F1c2VkIGFuCj7CoMKgwqDCoMKgwqAgb3ZlcmZsb3csIHJlc3VsdGluZyBp
biBhbiBpbmNvcnJlY3QgY29udmVyc2lvbiB0byAwLgo+wqDCoMKgwqAgLSBUaGlzIGlzc3VlIGhh
cyBiZWVuIGFkZHJlc3NlZCBieSB1c2luZyB0aGUgY29tcGlsZXIncwo+wqDCoMKgwqDCoMKgIGF1
dG9tYXRpYyBzaWduIGV4dGVuc2lvbiwKPsKgwqDCoMKgwqDCoCB3aGljaCBlbnN1cmVzIHByb3Bl
ciBoYW5kbGluZyBvZiBuZWdhdGl2ZSBhZGRyZXNzZXMuCj4KPiAzLiAqKk5VTEwgUG9pbnRlciBD
aGVjayoqOgo+wqDCoMKgwqAgLSBBIE5VTEwgcG9pbnRlciBjaGVjayBoYXMgYmVlbiBhZGRlZCBh
dCB0aGUKPsKgwqDCoMKgwqDCoCBiZWdpbm5pbmcgb2YgdGhlIGZ1bmN0aW9uLgo+wqDCoMKgwqAg
LSBJZiB0aGUgYWRkcmVzcyBpcyBOVUxMLCB0aGUgZnVuY3Rpb24gbm93Cj7CoMKgwqDCoMKgwqAg
cmV0dXJucyAwIHRvIHByZXZlbnQgcG90ZW50aWFsIGNyYXNoZXMuCj4KPiBTaWduZWQtb2ZmLWJ5
OiBzdGVwaGVuLmV0YS56aG91IDxzdGVwaGVuLmV0YS56aG91QG91dGxvb2suY29tPgo+IC0tLQo+
wqDCoCBhcmNoL2FscGhhL2luY2x1ZGUvYXNtL2lvLmggfCA4ICsrKysrLS0tCj7CoMKgIDEgZmls
ZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hbHBoYS9pbmNsdWRlL2FzbS9pby5oIGIvYXJjaC9hbHBoYS9pbmNsdWRlL2FzbS9p
by5oCj4gaW5kZXggNjVmZTFlNTRjNmRhLi40ZDdjZDc0ODZiN2QgMTAwNjQ0Cj4gLS0tIGEvYXJj
aC9hbHBoYS9pbmNsdWRlL2FzbS9pby5oCj4gKysrIGIvYXJjaC9hbHBoYS9pbmNsdWRlL2FzbS9p
by5oCj4gQEAgLTcwLDkgKzcwLDExIEBAIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyB2aXJ0
X3RvX3BoeXModm9sYXRpbGUgdm9pZCAqYWRkcmVzcykKPsKgwqAgewo+wqDCoMKgwqDCoMKgwqDC
oMKgwqAgdW5zaWduZWQgbG9uZyBwaHlzID0gKHVuc2lnbmVkIGxvbmcpYWRkcmVzczsKPsKgwqAK
PiAtwqDCoMKgwqAgLyogU2lnbi1leHRlbmQgZnJvbSBiaXQgNDEuwqAgKi8KPiAtwqDCoMKgwqAg
cGh5cyA8PD0gKDY0IC0gNDEpOwo+IC3CoMKgwqDCoCBwaHlzID0gKGxvbmcpcGh5cyA+PiAoNjQg
LSA0MSk7Cj4gK8KgwqDCoMKgIGlmICghYWRkcmVzcykKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiAwOwo+ICsKPiArwqDCoMKgwqAgLyogQXV0b21hdGljIFNpZ24tZXh0ZW5kwqAg
Ki8KPiArwqDCoMKgwqAgcGh5cyA9IChsb25nKXBoeXM7CgpOQUNLLsKgIFdoYXQgZG8geW91IHRo
aW5rIHRoaXMgZG9lcz/CoCBXaGF0IGl0IGRvZXNuJ3QgZG8gaXMgc2lnbi1leHRlbmQgZnJvbSBi
aXQgNDEuCgoKcn4=


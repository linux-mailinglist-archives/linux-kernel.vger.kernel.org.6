Return-Path: <linux-kernel+bounces-536979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB745A48697
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8663B6031
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C1A1DDC21;
	Thu, 27 Feb 2025 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="l7r3wDrB"
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011025.outbound.protection.outlook.com [52.103.67.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05F21DE2B9
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740677323; cv=fail; b=MhfCCOUgMjhUcyCjQzqNq510FJi0yoDfIVDmx2LhIqpXSgfsdpxREdOELic42gKa/qgq71ksLY8ueO62X0Rpo3oNnWqnbdl+hLZtmZo6zxqdWc1dLtU3j61z/u9kejrcFaX6bjvr9g9TR3iCnf5zRODXMOjtxgtNtU3TnPb//7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740677323; c=relaxed/simple;
	bh=2hGIHrMMfYhzWtpU/vHvgFAH+DSnaxqr4LOS4u3Hy5o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F9ofbtbSZ1uiPDH96yv7Opgjgpzl8tllcmPO4m9inEJioeR8wJUWZeO5dS2ic985cvl8V1c0AktQKI/hlBu+2y5kSiDxr5tCMqOIDNysUuy50k/2g4h12WOa3BrbSRfBvXPLWkS2YMpm+JdiqfxnT76mpa3aHM3Yf9ONdU/b0Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=l7r3wDrB; arc=fail smtp.client-ip=52.103.67.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFFM7VsQN80Ob8cafGSSGP36fFWuCUtMMwDjQgeIkvM1n9suxEvEx9rZaW5zjHKCneW4qvn431h9rmCohjyGrttfKqpuYldJliX/1n5HjXSWwzv5mGBRfGPDA4lJWrA2QGSK9zDII5L9toYwfE/r7CBghD69Sae41SQgQ6BLzcvR0EOmlkjvcZBbGxzlSsgQOB3YkJS9BgTwWoyfTDsCH5TeOVOjw1b0LIQteGS3cS2pn/clrsy2X6Ic+NMFqWqesg0eN4ze5qFtGRN8rCArsLd5/mzpCJSPch13jqJFz09pbdhavCATGA1q2YFUQZ3CIx+RmbMUG6RUA3e2nqNAOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hGIHrMMfYhzWtpU/vHvgFAH+DSnaxqr4LOS4u3Hy5o=;
 b=V7m6v0eWIGXEyZBGhKzIBqdcvzPT+ZVAipHKyNg61gR62DJasWPkcjB/Y9uMoNZrGOpJ+nP7FwIjnKcMNlec7XsSRXEreE8+ml2lnSvZ1l9tq7pZrS6fMdTBiN+3ZxgxCn1xOY7PPCzOtI+OZGf9MDFfr5+aVyxdmokSpESyHDjGSwxnw7Z9+XSBD1VfPqNCAoAkvUOC1e+XpFXF+Jy37L991t/0+WQ8+M7iD5kUqTbILqg59FS6bwH/L6aXltusznE2nSW0nZ8vZne61tFVnGkcPU4XzrKr203UYZ0E0WcBwrCeFEM0N3qbjHkON8/kKEFxhy7g9PNzNfN32OQ4fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hGIHrMMfYhzWtpU/vHvgFAH+DSnaxqr4LOS4u3Hy5o=;
 b=l7r3wDrBOdmH/wX+9xTPK9gvGu9x0cgME7Um7DjNg4FS/DVT7ah9ojZHooSCpjGMN2RNng1YJV9HMpYUcvp7iggGahklSbjJQoqNl2EE6iBmPGRUA5Em+l+TsKJfN+s1lgw5MHMkzApgGU3ioY0KWqwMpHp17j6fYo3Ui27py+/RhEdtuJRn9IL+eUPqeX/pGqs/YAU/3JWRhnu9xLM9pbpT1XpIzU4Qcpm9EvRDqwFwkyEdjVkUo6Tq4HkgZ/H4L7I5Qsr8TG0lSCjjy+sVi+e7XIAY+E6UNrpErZc1lbbPiCPp9bhyCql7f43xO95xvKYhh7M0904yCJmkFQLZlQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB7281.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:34::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Thu, 27 Feb
 2025 17:28:33 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 17:28:33 +0000
From: Aditya Garg <gargaditya08@live.com>
To: kernel test robot <lkp@intel.com>
CC: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, Paul Gazzillo <paul@pgazz.com>, Necip
 Fazil Yildiran <fazilyildiran@gmail.com>, "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>, Kerem Karabay <kekrby@gmail.com>, Atharva
 Tiwari <evepolonium@gmail.com>, Aun-Ali Zaidi <admin@kodeit.net>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 2/2] drm/tiny: add driver for Apple Touch Bars in x86
 Macs
Thread-Topic: [PATCH v4 2/2] drm/tiny: add driver for Apple Touch Bars in x86
 Macs
Thread-Index: AQHbhsGm46fWR/3mxEipqc6+PMbxkrNbYvUAgAAJkwU=
Date: Thu, 27 Feb 2025 17:28:33 +0000
Message-ID:
 <PN3PR01MB9597926E81D2787F2210B84CB8CD2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <844C1D39-4891-4DC2-8458-F46FA1B59FA0@live.com>
 <202502280028.1Y9QMcR0-lkp@intel.com>
In-Reply-To: <202502280028.1Y9QMcR0-lkp@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB7281:EE_
x-ms-office365-filtering-correlation-id: d35f5743-503a-4f22-4e61-08dd57542938
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|6072599003|461199028|7092599003|8062599003|19110799003|8060799006|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZzdJTDlicW5la214QXBCNllvY1RGUkdYOXBQTkIvQzBTY1BaSGpRd3AxdDhH?=
 =?utf-8?B?cmJUR1Z0cWZ5NXN4cDBicTlaN3FtOUhBdmhPUTg1Y0dhd2wwMTlGOFRla0V5?=
 =?utf-8?B?U0VXOEtybUZSWERaUWJSM0dxdDZIODR1MVo5UjVYNkhFVS9hUHRrV1FpU2M0?=
 =?utf-8?B?dDhZZU04cTZITUQzcFM3MW9oL01GMnUvYi95RU52OW5RaGo5R1ZBL21WWHhj?=
 =?utf-8?B?bjFzMmg3K1EweXNHUkxKbklBU2JEcW5DUkhyclljMlgxbzFUamh5aUJ6YXJv?=
 =?utf-8?B?RWZHa0F2TXVCWlZUZGZiaUVWcjVWMENUMHUxTFh5bTNlaUpHeDJtUC9iUzJT?=
 =?utf-8?B?MnIwcmN6cURRK1c5bDJHdjZNRzFMaVNMVkVvMTZnOEVaQ2tuOFJ5L01sT1Va?=
 =?utf-8?B?bGg5NERmeEZ1Y1h3Q1g4bnFqQmtUeWIxZjlTelljNnhvU0Y0Rm50WjFCeElu?=
 =?utf-8?B?NGFhLy9PVVJoejExWWlDMy83T25kYlJvVitSRU1oeHhlV291dWhWTkEveUl5?=
 =?utf-8?B?MG5xT0d0RGcvR1hiYzkrOWMveU05QmE0cmxyR3Bnazl3MVlwTFJldlcyVTFP?=
 =?utf-8?B?NThVVVppQ0Z2V3UzUkZkSUVObE56Q3pzcEM2QXpZTXZMWk9lV094UzVOOG0w?=
 =?utf-8?B?c1ZwdDBXaFB2S0FRVElaZnB4eTNKZW5DU2wvU3p0MCt5OGJCQ1I5eEZjbThU?=
 =?utf-8?B?a3R5ZHFVUlpQS2plOXlueEI4amx2T3lYZk8wczk4L1FaRytrZjA5ejM1VVNt?=
 =?utf-8?B?MUVqV0xPbStQTWdPZVYvL1ZOYXZRdDl4VlRpczNZaGpJZTBGNi9qOEdOYW1O?=
 =?utf-8?B?dUljNFJQV1Q4S2JSSXR0MDEyNTVaTXRpUUFSOXZlR0RjZTdtbzBTUlpiTWdy?=
 =?utf-8?B?TEpPT1FNNEphNEU3KzJKZmNIRXJJR2R2bmx0YklWckszNWRiamtOMjU2Slov?=
 =?utf-8?B?eXh2MHZZTjc3OUc1MWVDTHRnZmdpN28vNlgwYVhCQVhuZjNOQ3VZVWtGLzJI?=
 =?utf-8?B?d21xR1ZCcUkwN1ovOVBJTEhIeWk5UWdxWHBucUZWRGhqeUp6NUtHQzdKYUla?=
 =?utf-8?B?R0d5M1FzSnRzdkNvNXM5N0d2WEV4b2JLLzdpTUNoUDZSbm5yTGc4WHJtUXhV?=
 =?utf-8?B?Z09BZ0RuaGJVNjF3cmZheldiSzZPYXhBcElpTXVLTllnMFRMYkE4WmxiaUw3?=
 =?utf-8?B?UjJ5OWhsSVc1dkRLZERKMFJ6QVFFKy8reWlhbFBZOExjM3VFL2tXY1NEcDc4?=
 =?utf-8?B?SDlnRFd6OC93SFhhc05lQVFOMUJCTFJDZE5BMld1dnJOMXp0MXdmRG1NdTF6?=
 =?utf-8?B?SzllRGhIdmNBakRWenBsYUF0RTVMSTV0U2pGSHY1RkZSNGJFV2lnSDFrTlRs?=
 =?utf-8?B?RFRPMVNPRXNKbk9ySTNMT3Aycll6bHBJMmZSdGVESTVXV25PSEdDZkdvKy9a?=
 =?utf-8?B?S1hVYk9mQ3Q1K2NZOFVEK0NWVFhjakdxYjZOeXdCSitHcVpRT3hpb1BuRkwv?=
 =?utf-8?Q?/k8c2Y=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SEFaWEs2L1RQMTM3M1ZqYjFKcWhxOFZKMVdmV1RjYXVMczdZRjRGZzNjOXpn?=
 =?utf-8?B?RENuWW9pTmd1VU41bHhTUXIza2luMis5QlBXNDBsOWt4SmMvbENka2xBZ2RO?=
 =?utf-8?B?RlVhOG1zTnZuZlFVRTJtQ0ZrOUIwOWt4ZkFielRPcEtycUV1VmczNjcyaXFX?=
 =?utf-8?B?c0UvbzI2RHdwSVVZMU9oK1N2U3NQa0R2R0VsT1ZvNGd5b0tKUXdtbWxMN0xG?=
 =?utf-8?B?YzlkUEJnM1dPc2JJY0dwc0Z4NUJORjhVRWd5QjlScnFsL2tJNE5NRS92Q1g0?=
 =?utf-8?B?STFrRW1mTWdTaWR1OVpFZXB4RzRQSnR6MmkvSHIwTU0ySStEQjFGeDZhalc0?=
 =?utf-8?B?dHQvYzdYRkpZNmREL2Zrd2JqaGQ0UGtrVkkyOGtYZ1FVekNTR0liWkRqSHUx?=
 =?utf-8?B?aXhPWm1lZmpUY1dpUjc5YU0wWlFZdWxuZEhlTVQ1bysrWTlXOEpnUVZGNDJ5?=
 =?utf-8?B?RWp5OTk3VEdnb053TkN1aTJkaDE3N2xtRWkxZU8rZ3pMVE5WeUhPc05UeWlz?=
 =?utf-8?B?d3B1NjVHekdrMU9RLzVoajU5eDNEK0cvUnh5azRxSlhOdi9ZMDVuYjVoTjZQ?=
 =?utf-8?B?OVpucDI5OUV5ZXNiODAzckpWRG1xdUIwSXh6M1d0T0NzN2QwVytaR3dUMGJK?=
 =?utf-8?B?bWQrRFJJVlRvYk5GUDdPTlBFbW5iTCtkZFdUSGJ6Wi9HcWVmN1VWZWorMXRs?=
 =?utf-8?B?VmtHSTdjb3RRTTBqV1pyWmtTRjdlL005a2VBalllM3ZpNjRTdjcxeExrK24z?=
 =?utf-8?B?b3VwenNxV0xpRVhkMi9xaU11M1M5QXhjU011US9mWTgyUGdoWUNzL1ByQUNu?=
 =?utf-8?B?ZStXbWErMDVibE90SjFrR1BTYTJ3SkNsSThGdHR6WHpMWFlLd3RSWTJWK1do?=
 =?utf-8?B?WXNmenZwM0pzMHh1OXJqMk0yUHN3Rk5WTTc5aEtRSUpKT2VhNXdtcWtDallC?=
 =?utf-8?B?RUR4Yk1mR3E2VmUxUldBSHpId0tVT0ZCZ24venhlbVBVZ2xBKzF1WW1ZZ2pY?=
 =?utf-8?B?U0FpYnFSWEFOcDc4Zm90N0F4Vk1CbS9qZEtDZXlSTk5nb2tOY2JnMkMzL0VH?=
 =?utf-8?B?RnhTUUNpLzFaZXJMK1BVaVgyaUNnaU1tYmZPeDErZlhEakRGbEtDbk1yVSs2?=
 =?utf-8?B?WUkyNlAySCtuSXYwN2FQdUtINjZWQlZwK1F2VTFSaHVadFUrVUlLNFhPNEJJ?=
 =?utf-8?B?SXErOHlPeGVPczZydE9RNmdaTDI5MklRejYxTTNxeHFiZGxmc3JqdXlhZTk3?=
 =?utf-8?B?RWYxUENNVktuaFZ1SGgyMXo3UmNXcVg1MlU4cXFMVGM2eFdWcURSY2hEL0pO?=
 =?utf-8?B?N2tYM2pIdEJtN0FOcDk4dEZVS0RXeHllMEVMaENLaXBwT04rakFYQUErYU5V?=
 =?utf-8?B?Qi95L1VnUnZFbjNjQUVPblhSQ0RrS0krVVN5RU92b1FpUlZZcU0zeDRBWkdP?=
 =?utf-8?B?WmFDNlJmODZEWUtTTWI2NFV0RXpYT2FsSlpEeEdyQ2ZyY0hQa1d5RVhiSFhK?=
 =?utf-8?B?U2JuTGVZQ3dieXFzWWZMUW9JOHdJVVd6WG5YVzU2WHdpemxZTlR3KzNBVmwr?=
 =?utf-8?B?TUhjVzg1aEJnVUJJV2JwTzR1c0ozc2lHOTJybWtMYkxWVlZTaHQ1L1JtRm9X?=
 =?utf-8?Q?EnjY/Q66+OBB9Cd0t9BunbFRUBi4Zz8W0yVCqaMGwDW4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d35f5743-503a-4f22-4e61-08dd57542938
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 17:28:33.6505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7281

DQoNCj4gT24gMjcgRmViIDIwMjUsIGF0IDEwOjI04oCvUE0sIGtlcm5lbCB0ZXN0IHJvYm90IDxs
a3BAaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IO+7v0hpIEFkaXR5YSwNCj4gDQo+IGtlcm5lbCB0
ZXN0IHJvYm90IG5vdGljZWQgdGhlIGZvbGxvd2luZyBidWlsZCB3YXJuaW5nczoNCj4gDQo+IFth
dXRvIGJ1aWxkIHRlc3QgV0FSTklORyBvbiBsaW51cy9tYXN0ZXJdDQo+IFthbHNvIGJ1aWxkIHRl
c3QgV0FSTklORyBvbiB2Ni4xNC1yYzQgbmV4dC0yMDI1MDIyN10NCj4gW0lmIHlvdXIgcGF0Y2gg
aXMgYXBwbGllZCB0byB0aGUgd3JvbmcgZ2l0IHRyZWUsIGtpbmRseSBkcm9wIHVzIGEgbm90ZS4N
Cg0KQSB2ZXJzaW9uIDcgb2YgdGhpcyBwYXRjaCBoYXMgYWxyZWFkeSBiZWVuIHN1Ym1pdHRlZCwg
bm90IHN1cmUgd2h5IGtlcm5lbCB0ZXN0IHJvYm90IHRlc3RlZCB2ZXJzaW9uIDQ=


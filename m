Return-Path: <linux-kernel+bounces-221262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D28690F0F9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F609282D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9519C1DA23;
	Wed, 19 Jun 2024 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="MTWYN9L6"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2150.outbound.protection.outlook.com [40.92.62.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3821CD15;
	Wed, 19 Jun 2024 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.150
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718808181; cv=fail; b=Yjqtjg3CO6wEMBIDupsU+9x/cjR2zbVFXV+Yiil8Ow3tXy7u22REcUBpP490STCifC39tqKxyIJPBl8TDG78sHF95Li8Snp9QS1IWlZzkpCzEPbSh2uPtIxZIBIM5lXGjVOshGoMzeLSbMP/2iSSFMCm3QKDv7wjKUDAu8LHcaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718808181; c=relaxed/simple;
	bh=iQX5fPkdLtD4l3cB3xUitFZ/vGSzLQ2eP0ovoyRmp/M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XsgUWCK8md6KVJZxTNdq2GJChtjnk9DBB/dxRRkbgIN/hy0+4Aa/4CwmVTJDYsaeKmW8T4Qvqinhn7YWDz8n2efRVqEFOXUAZ+mr2lH6sDO+ufOtagPUxvzdskb/n5UbsT182ZqL3p7qiuXrAj6P7S4h9UFC4Qif18hB3RVIrk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=MTWYN9L6; arc=fail smtp.client-ip=40.92.62.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCbiOvSzbuJJILWlljP4PVuLpr12uVIIjPezsDN6iO/qlBCUJ5JcXWC7Fws/J3/O8fc/1wankwLVmeE0SJgPikQlX1SClL1p8qDZKcfp+1xMQvfamqTx/r0+z2FNgaKGOvbo5yshvAYVM0OJIlJyKY2x+8x/G+Q29CW9/a+T566pC2bph25gV/8QE+YnAx4J4jAwqocSVib1i8N7Ux1WHAZQ0djngAUZ2eyxfcxGacQKZRxp/gYUYtKUDLlYxZtiRjgTtFWApUAb4FhATCD75Qje7sTohZjhhN5TLT0M3OLordq1fNzBA9N0ApvYm2z2ZU31NfVCCVsYRcHrvkpXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQX5fPkdLtD4l3cB3xUitFZ/vGSzLQ2eP0ovoyRmp/M=;
 b=UQ6Vy4PlfNYhjwQivd5lEyroRFAhQ+zu1KXJ4Q7NIx2OKSm23p3+7taqvRxOP/CX1Jw6BTe60el2v4so/V9OKsz3RZYgVp1pgqVHmEyzBWNfDJpNurEm9S8dgV9TrrRB21I7Ra9tiIhc6iTCOE0lzFG6nvTslPNDZgqMM7U9a3vqWeVuDnXeJ5hfj29MJpKRdN0BPTuGyJXdKDhAqyOlclurRi2IfVO/3El4ue42WkAFeB2k+GbVhzl9PfgixmB2U3DbZU+bFNL0pYfNPeGZo41YpYWDiRepPfvcPsBLv+TkmoC7QARuv0l0brmii25yU88c8IQO3jHt/SFuBYouOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQX5fPkdLtD4l3cB3xUitFZ/vGSzLQ2eP0ovoyRmp/M=;
 b=MTWYN9L6l0YGCXPhMbt15Vc9o4Wy/JCnHQGx4jdSBeyhQyvMO2FGv8TPE+zcs2qh2JyWPwv/HgMajVM892QbL0svRBYqCIzW52F1jq+ChiNUiAErQYGpp7vO0W5UorSBOO22UXWeEFvPNNspSO/m5sDvgC2gPZb7JT44nUhZ6nUnDSp6AyJ2Bp75id2rrsSgfLPKihYLbJFEwKILJsBxk41kNhG/MrBDbn8d6qRTl4RHjX5Mny7ahuz1NAyGxLGmslCXyBtnANMblWml9UQyZKIOw4uLBD8k5J5Ilp7E85w9KlLuuZzg0NRbYz720PRCaLKxcGF4TS1iXzEAM105VA==
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:9b::8) by
 ME3P282MB1602.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:a1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.19; Wed, 19 Jun 2024 14:42:53 +0000
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3]) by SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3%2]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 14:42:53 +0000
From: =?utf-8?B?6Z+15rabIOS7ow==?= <d1581209858@live.com>
To: Inochi Amaoto <inochiama@outlook.com>
CC: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, Chen Wang
	<unicorn_wang@outlook.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 1/3] dt-bindings: mailbox: add Sophgo cv18x SoCs mailbox
Thread-Topic: [PATCH 1/3] dt-bindings: mailbox: add Sophgo cv18x SoCs mailbox
Thread-Index: AQHawZIDXpA1fvG1y0K0Pqnnh8DDpbHOG/iAgABRdJk=
Date: Wed, 19 Jun 2024 14:42:53 +0000
Message-ID:
 <SYBP282MB22382156EC7B065009EE8D95C4CF2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
References:
 <SYBP282MB2238DE0DA19C6EF411B2356CC4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
 <SYBP282MB22389FD1E07BBDC6FE1D90A0C4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
 <IA1PR20MB49531E9C016A91E52F5D59C4BBCE2@IA1PR20MB4953.namprd20.prod.outlook.com>
In-Reply-To:
 <IA1PR20MB49531E9C016A91E52F5D59C4BBCE2@IA1PR20MB4953.namprd20.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [cgzTxAvI79e3GcVUX0pxR5/KhVXgYCvf]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBP282MB2238:EE_|ME3P282MB1602:EE_
x-ms-office365-filtering-correlation-id: b4a8a505-662a-44b6-30c1-08dc906e1a17
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199025|1602099009|440099025|4302099010|3412199022|102099029;
x-microsoft-antispam-message-info:
 dW+qjLWn/Ymi3Jyjb94MN7nKi4KMkDZjok+fiCvy4I/atwZTiLAGVe+WTBFERoSs1DaVpIfCGzjynzkckYLFTXsmrWcfz8SndwNVWnJpUq6xgrZo+gTgzBrji0E4GiGBC98Km0AMZcrWau/UBKfxDvyDV4cIdQVe5gtaYq9lgaudm5f79GfQ/SdBHg5qq1+32u2xIQ+lK8oS1gTM6RNFx278mPrwbJim2e9w1d1s8IHgzFOwFd5rcUL3Ga08Q7G9o66OYgiZOVJZ3/b8HbiJUAYadIRCbK99LeW0GjRN6mozNPuvyjKiKBNfB/to7EcECDeU2DO/XHyxj6KIJcuBKXqvemYH6We+r8X2FpbLqZ1I+xdCKvHWZyUAVwaMmHyKvLb50UvOg57rkYOJx9jvFRtiGUf937nuw9rJtTkRfvNfNL6l/5gZEKY0Y/IcTu7MMX28tjUW1eVrJPLZRaH4hRpvYugOnbIfOCWs498mFwT9DLPIXypYRaUPMG8GNi/4eWj/qI1bt+4wLJyTytxjKn77CN5mGusMmkEtJANXkm+3GAyiQ1kUu16oj06S5VaOuRhiot1H6hIDCMmHcarVP+D62KVRl+B6hkl2bO0IueBgwa64/s425LJEXqDbgZRmkDO04deHB/cop81KfakbrAm4qyskbryXXhUSwayQBHmO88+QBcH/HW/BMHOBhC2x
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVVSWEN4Vld1YzBnRnBlbzlQeGxoWmRURytuSmxvOTF1UkR3RmhEZGdNSUxh?=
 =?utf-8?B?VThWTkd3NEVaSHhtVVhHeFRKRDVmYU5WdFVKQ2dvbGVmdXQzTjlURFZXRzQ3?=
 =?utf-8?B?eDExbENSZmEreVhKUC9hcTJpV3F1NFg5ZDE2TjNHT1dITFl3WS9WWTVxU2VE?=
 =?utf-8?B?MTBhVmRqeEZGT0doTUpCZjNtZ3k2Y0ZIWGJxZFJRdHF5eloxakE3Qk1IK3ZB?=
 =?utf-8?B?VSt4ZGViMlIxQmo4S204VTUxQ0VQTEdNMHlLOENYenJYeWxWZnkzQVR0UjdM?=
 =?utf-8?B?eG0veDlWYVBqQUdGV3B4SUpBQzV0YldKaFM4ZWlUYXJCd3VYa2ZISXRucjNp?=
 =?utf-8?B?czFXOHdJSENPNjVCdThsQkphc3VySUMrNmV3NU5yYWEzK0R3ZkF2cDN4RDdX?=
 =?utf-8?B?dldaMnJqZE5FdDFCVHRUSjlpNUQyVCtwQUZGQmYvMEJjLytEK0RkbVFrNWRp?=
 =?utf-8?B?VnFKY1RGR1dMRUthZUpEL0l1aXo1WUh5dTBkYWVET0d2Smdqdkx4eXo2cWFl?=
 =?utf-8?B?dFpKTk8zYXdWVlVUb0h2OWRyTjZJMHgxb21zazVseWdWL1lEMzFnY2xQYjJD?=
 =?utf-8?B?cGRvNnFtWUJ4VmxCK1Bkcml6SklUZGNNUks0MzVzU3JnUVg2ME9Dd2hEbjBF?=
 =?utf-8?B?Q0JjUDNyWWdwcERCQzRETlExTVlmUEJySU1PSmtISDh4dUJOcUs3c0FiT0pM?=
 =?utf-8?B?bWFuZ09WTkNKeXNpMmJ5NWl3UVIwN1Y5RWhtaE1hTk1zS2lEcUFBbVM0M2VP?=
 =?utf-8?B?eC9wM2V0Mmt2K1VoVHFkVHlUdk9RcXV2bWlHdjJTamVITjJjSkdKbXA3UnZX?=
 =?utf-8?B?MW9oc3ZHTnFWeFVUeEhEWE9zU21rWjBGVXZBUm01dmxBSGdVVVZrMkNIeE1h?=
 =?utf-8?B?d3puajdWUVFYaVFxVzQ5RmlCUjF0QS84MzFHc0FFU095NnAyQ1ROV0ZNODd2?=
 =?utf-8?B?RnlqeGlrRGg2SmtzMkF5ZTlzRFFLTFNXMHUrZTNoM3VqY1gyVGlHOXI5VUx1?=
 =?utf-8?B?Z0lmSmRyMmphREZYQ3pHZkNCU2ZLakEwZFl2c0xwQ2pkM0RSQ01BbUlCNUlH?=
 =?utf-8?B?MTNFVG1RNWM1T3hnMStVdDFVd21LUTJMbUdtTXdXQjF3anA4TWFHcjBReXBV?=
 =?utf-8?B?RWZoVWRDVStWek4yeXhabDRFbEd4aG8yY2NlL1NMTmphQ25yVDh0YUx4dERj?=
 =?utf-8?B?dGloWXowaEh4Z3lnalA1ejE5RFZvTEhMcGIzUGsrSkRoMEltMWRWMml2YStK?=
 =?utf-8?B?M2JMUTljMlhZQmRZQ3hYQ1VqZWQ0UlZtREJsVXlSaWJYVC9sdWxQOWcyUmYw?=
 =?utf-8?B?aXV4WmEwNGRHQVhneklQa3U0eTZsck52dGMwTWlpR1FRR3kwbkZkRC9oRStU?=
 =?utf-8?B?Tk5BNGhYK1RiVmRFUTZYempHSC9wZTNOa3BGb2tEamt3VE5WNjZEeVdlaExx?=
 =?utf-8?B?ak91akZTYUJMdHBIbklTcE9MaE54ZzhrbjhCUUhxNDFqdC9WVjVrMUx6WWQy?=
 =?utf-8?B?VHJvVDlrdzhTTDFYUWRCVGVBMVhhaHRxcGxqUm9Zc1JybURlSEpTMzNrZTls?=
 =?utf-8?B?clgzVEM0LzdwOTFkSE1GcEZ0NlArTVVKL1Z2a3lSenBHTUVtUXgrbVA4Rys1?=
 =?utf-8?Q?6zFEQFJXT91xq6iJz/tyI/NtXCQ4gvFgwKmVstik+Xpc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a8a505-662a-44b6-30c1-08dc906e1a17
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 14:42:53.8055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB1602

SGkgSW5vY2hpLAoKPiBGcm9tOsKgSW5vY2hpIEFtYW90byA8aW5vY2hpYW1hQG91dGxvb2suY29t
Pgo+IFNlbnQ6wqBXZWRuZXNkYXksIDE5IEp1bmUgMjAyNCAwNjozMwo+IFRvOsKgWXVudGFvIERh
aSA8ZDE1ODEyMDk4NThAbGl2ZS5jb20+OyBqYXNzaXNpbmdoYnJhckBnbWFpbC5jb20gPGphc3Np
c2luZ2hicmFyQGdtYWlsLmNvbT47IHJvYmhAa2VybmVsLm9yZyA8cm9iaEBrZXJuZWwub3JnPjsg
a3J6aytkdEBrZXJuZWwub3JnIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBjb25vcitkdEBrZXJuZWwu
b3JnIDxjb25vcitkdEBrZXJuZWwub3JnPjsgdW5pY29ybl93YW5nQG91dGxvb2suY29tIDx1bmlj
b3JuX3dhbmdAb3V0bG9vay5jb20+OyBpbm9jaGlhbWFAb3V0bG9vay5jb20gPGlub2NoaWFtYUBv
dXRsb29rLmNvbT47IHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbSA8cGF1bC53YWxtc2xleUBzaWZp
dmUuY29tPjsgcGFsbWVyQGRhYmJlbHQuY29tIDxwYWxtZXJAZGFiYmVsdC5jb20+OyBhb3VAZWVj
cy5iZXJrZWxleS5lZHUgPGFvdUBlZWNzLmJlcmtlbGV5LmVkdT4KPiBDYzrCoGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZyA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1y
aXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnIDxsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3Jn
Pgo+IFN1YmplY3Q6wqBSZTogW1BBVENIIDEvM10gZHQtYmluZGluZ3M6IG1haWxib3g6IGFkZCBT
b3BoZ28gY3YxOHggU29DcyBtYWlsYm94Cj4gwqAKPiBPbiBUdWUsIEp1biAxOCwgMjAyNCBhdCAx
MToxMjozM1BNIEdNVCwgWXVudGFvIERhaSB3cm90ZToKPiA+IEFkZCBkZXZpY2V0cmVlIGJpbmRp
bmdzIGRvY3VtZW50YXRpb24gZm9yIFNvcGhnbyBjdjE4eCBTb0NzIG1haWxib3gKPiA+Cj4gPiBT
aWduZWQtb2ZmLWJ5OiBZdW50YW8gRGFpIDxkMTU4MTIwOTg1OEBsaXZlLmNvbT4KPiA+IC0tLQo+
ID7CoCAuLi4vbWFpbGJveC9zb3BoZ28sY3YxODAwYi1tYWlsYm94LnlhbWzCoMKgwqDCoMKgwqAg
fCA3NSArKysrKysrKysrKysrKysrKysrCj4gPsKgIDEgZmlsZSBjaGFuZ2VkLCA3NSBpbnNlcnRp
b25zKCspCj4gPsKgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbWFpbGJveC9zb3BoZ28sY3YxODAwYi1tYWlsYm94LnlhbWwKPiA+Cj4gPiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvc29waGdv
LGN2MTgwMGItbWFpbGJveC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21haWxib3gvc29waGdvLGN2MTgwMGItbWFpbGJveC55YW1sCj4gPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NAo+ID4gaW5kZXggMDAwMDAwMDAwLi5lMTg2OGFhZjIKPiA+IC0tLSAvZGV2L251bGwKPiA+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L3NvcGhnbyxj
djE4MDBiLW1haWxib3gueWFtbAo+ID4gQEAgLTAsMCArMSw3NSBAQAo+ID4gKyMgU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IChHUEwtMi4wIE9SIEJTRC0yLUNsYXVzZSkKPiA+ICslWUFNTCAxLjIK
PiA+ICstLS0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21haWxib3gv
c29waGdvLGN2MTgwMGItbWFpbGJveC55YW1sIwo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0
cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIwo+ID4gKwo+ID4gK3RpdGxlOiBTb3BoZ28g
Y3YxODAwYiBtYWlsYm94IGNvbnRyb2xsZXIKPiA+ICsKPiA+ICttYWludGFpbmVyczoKPiA+ICvC
oCAtIFl1bnRhbyBEYWkgPGQxNTgxMjA5ODU4QGxpdmUuY29tPgo+ID4gKwo+ID4gK2Rlc2NyaXB0
aW9uOgo+ID4gK8KgIFRoZSBTb3BoZ28gY3YxOHggU29DcyBtYWlsYm94IGhhcyA4IGNoYW5uZWxz
IGFuZCA4IGJ5dGVzIHBlciBjaGFubmVsIGZvcgo+ID4gK8KgIGRpZmZlcmVudCBwcm9jZXNzb3Jz
LiBBbnkgcHJvY2Vzc2VyIGNhbiB3cml0ZSBkYXRhIGluIGEgY2hhbm5lbCwgYW5kCj4gPiArwqAg
c2V0IGNvLXJlc3BvbmRpbmcgcmVnaXN0ZXIgdG8gcmFpc2UgaW50ZXJydXB0IHRvIG5vdGljZSBh
bm90aGVyIHByb2Nlc3NvciwKPiA+ICvCoCBhbmQgaXQgaXMgYWxsb3dlZCB0byBzZW5kIGRhdGEg
dG8gaXRzZWxmLgo+ID4gK8KgIFNvcGhnbyBjdjE4eCBTb0NzIGhhcyAzIHByb2Nlc3NvcnMgYW5k
IG51bWJlcmVkIGFzCj4gPiArwqAgPDE+IEM5MDZMCj4gPiArwqAgPDI+IEM5MDZCCj4gPiArwqAg
PDM+IDgwNTEKPiA+ICsKPiA+ICtwcm9wZXJ0aWVzOgo+ID4gK8KgIGNvbXBhdGlibGU6Cj4gPiAr
wqDCoMKgIGVudW06Cj4gPiArwqDCoMKgwqDCoCAtIHNvcGhnbyxjdjE4MDBiLW1haWxib3gKPiAK
PiAic29waGdvLGN2MTgwMC1tYWlsYm94IiBwbGVhc2UuCj4gCkkgd2lsbCBmaXggaXQKPiA+ICsK
PiA+ICvCoCByZWc6Cj4gPiArwqDCoMKgIG1heEl0ZW1zOiAxCj4gPiAtLQo+ID4gMi4xNy4xCj4g
PgpCZXN0IHJlZ2FyZHMsCll1bnRhbyBEYWk=


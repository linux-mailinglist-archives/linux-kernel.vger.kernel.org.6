Return-Path: <linux-kernel+bounces-185935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B71158CBD0D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31AE41F22A95
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE9D1EA91;
	Wed, 22 May 2024 08:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="PT0enLgW"
Received: from MRZP264CU002.outbound.protection.outlook.com (mail-francesouthazon11020003.outbound.protection.outlook.com [52.101.165.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171B07710B
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.165.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366772; cv=fail; b=I5AJDCzUEcfwU3NqYR7vN2A1NceJK/9ISt2X3K5bfrRJqIXUPpn0T6MyyjqVxuzZ/TUoUXjbUs3NHfD5JDVDPdop4i74aCdXOKR+0hZjreU2vn8bE815FoUwFKsMXV8u6Gx+BeC2qcH0xy2/SCV70AjrADAD8rCygWkfv6ohHog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366772; c=relaxed/simple;
	bh=pxrVUCCWgKKaQrWD3xmWEPmxU+647jWO+q+FUe1/YJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mFOxRGNZUf/5d8Ac5dmk0SgyQ6MDJRPsGCatQrJo51b/SpPnQjqEXdrGzBd1C0cDFSEDJgvjXzza2v5pBdUfVOPQS9hfmxwdRmjCUNM/fnnhxAIAcv5OZarrXUh2RdT8+ardyN7ufZFFTjS/Xp0yBmfQRx5bbpqaRR/+/B+tzjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=PT0enLgW; arc=fail smtp.client-ip=52.101.165.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nt3BMVyj88k5jd5uoRTJK83wlVUEOyw/tc1T+30t0w7STM09clPi49NKkVYkIIQ416x6UZluvACpADa5tXo4f3ytCT5WBB8kdNGNM9IejzVvn63kMHW126Cn1KnzaO4xudrPBz2XhVzravIPMwfr2oJLKvYdXObifr2c7mwiKVex/83BuuJWxZgxEZpQYQ8H2mUNiwTM5Mo4KEx7JGuVS/gLC5Op8Dl7TxnkF4nxj9Yz5gu99e+xR1jYp9k6pDRhFNF8uS9jF2dyz8dD0fONjVzzJ35vxLoaIb7IudAnfiH4Wq0HkSuVLJNoZPUuCxlve4orl+aZ0e/UsLMqTxL3Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxrVUCCWgKKaQrWD3xmWEPmxU+647jWO+q+FUe1/YJo=;
 b=ZCaA2vgyre96JTbbwG/4sXrA1Jp3miTKxwscsVQ1SnyXu/n1PSkbS86mxJsRgo8xQrz5d6weDNPWUG7fTApnJqt/6kAopIt+z/Vau3B7h9f7krhn1Mq+BfFFgvHuJASd4XHFP8hwRBQsD/dY9cve3Yi7cnzexY4WH4/01QgQKnnW56jy2lHRinwsFIfN1JrROJzbjKCOjocyDQJJVAyPtSa9Euvrte5L4T37j/hGafw4nS+70ZcNwQnbvtzvdVvYDfp1JbaqUHH8vcloMpo13wQCJdFWOI5nzE5p1jPoc0XSgaoWLjru1krDsOvaWRmooLFalHBZ4UFaA/MN/ElJlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxrVUCCWgKKaQrWD3xmWEPmxU+647jWO+q+FUe1/YJo=;
 b=PT0enLgWYIKNTCWXnA0HUQbXtNWgbOHeU0IhRSnDRmy2/HzLJeoCjKz0rAhy0x+AukBn4gYWS3+Ex9PFlrTxE5JNz2Pv8NbrPSLfAS+tpB/lGUNzdhPcKS1ivftXuXyCTo7TGUgU1XhjjrlfRNf0F/HtkAc31zjzS2iYel1hIQyv4UXKDvJhZ4SKd78bIJ2PdzhnNKWH5rn0bh5H3hmbTXfpKhCsBjQTXkL9h72UMEdFsIcvE4PuVyysgaOAwi6eYTrd5dOwAet4OQPRmvaiLDY3LSOy+CUiICvltk74wRuqnmrnSy/VjWzeCw7bIAtCavfI7tsAwy5lD5ocLo9gZw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3403.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 08:32:47 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::96ff:7284:1fa1:b02a]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::96ff:7284:1fa1:b02a%4]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 08:32:47 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Oscar Salvador <osalvador@suse.de>, Michael Ellerman <mpe@ellerman.id.au>
CC: Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Peter Xu <peterx@redhat.com>, Nicholas Piggin
	<npiggin@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH v2 06/20] powerpc/8xx: Fix size given to
 set_huge_pte_at()
Thread-Topic: [RFC PATCH v2 06/20] powerpc/8xx: Fix size given to
 set_huge_pte_at()
Thread-Index: AQHaqIxxLOw0k+xnhUqWHgWN6F7AE7Gf2z2AgAB6CICAAIrJgIAAkNWAgAGDQgA=
Date: Wed, 22 May 2024 08:32:47 +0000
Message-ID: <f09a21cd-4152-44b2-9874-5afaa894bcbc@csgroup.eu>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
 <04f4e737608ea0b177b88057db138fbf0d6ab138.1715971869.git.christophe.leroy@csgroup.eu>
 <ZksUiwNaKx2n1fJO@localhost.localdomain>
 <f26807dd-bbd2-405d-9a88-c0654c525a5c@csgroup.eu>
 <87zfsk2dnu.fsf@mail.lhotse> <Zkxo0xmTHgjgBtKw@localhost.localdomain>
In-Reply-To: <Zkxo0xmTHgjgBtKw@localhost.localdomain>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB3403:EE_
x-ms-office365-filtering-correlation-id: 2fecc5da-42a5-40dc-d602-08dc7a39c24b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?blVVYk9kR1FwY1pyTkFhWS8zS0NnYlhPOVdFSmFrWG5EdkJCWS9KMmlhUng1?=
 =?utf-8?B?aVlpRXN0cnFYRHhvMmNBdUMyMWkvTGJBQTJ1TzNXdkVtYVZ5QklWQnduR1Ri?=
 =?utf-8?B?UWZYaGsyanptYmlTWEhVSXNsOWdiRnBiOUVMUEVpWHgrM0Z2c0tqY09sUkhM?=
 =?utf-8?B?VVU0RVF2dE1qd3ZEbTFQMlNtQldoUy83SUkwSFVYOVc4VEJoTXBVMTM2SGcz?=
 =?utf-8?B?eFJUWVptRlZrV2FLRG8raWNhU3M4dHRtTmNGejBJbVEyNWxSb0I2cWVub21B?=
 =?utf-8?B?SEduZDgwUWdhWE5KdWc2SmZUdk9iNTBkNURndGVzcTZUdWJsaXFYYmpLQXFX?=
 =?utf-8?B?d2pmYURlL1NkUmhQQ2FWU0xDbUdXcWlodFVvYmlFMTlOc3ZBZHdLMXppTG1I?=
 =?utf-8?B?Nm5NRW5CVWtSYnQ3cVlicTBHS1A0b0tJM3FkTzB3Z2ROYURTUVhCL0JEdzA1?=
 =?utf-8?B?L3dLWnpteGF0eDNPYitqSHNmamlJK3IrdW1rRXpFQlQ4NlA0emk5YStYOFQy?=
 =?utf-8?B?NXllKzZhRkZSUnBLcTMyRU5vMEJ0S2JWZ0ZsdG1FV2NwZVhHenlPM2UvTW1H?=
 =?utf-8?B?UFN5T3gvSlNDdmlUS1NSaTVMN1E3aU1NZEpER1ZLd3dKRlYwczJqL1MvWFk4?=
 =?utf-8?B?VkdKRjNzWFZpeS80MnNsbnQxdHRtRlorcGVXUmN2WllxYjRFVk5BZTVKNmlv?=
 =?utf-8?B?SnFIamhKNG9wYWNQWGtBWEY3MFJKa3VkeTN0SUVIa3JOMENoMGpjUE1qbWFK?=
 =?utf-8?B?TVBKVUw0cWJCRVZuYTRYSnJWNjNKenh5MlRyUi9yd3dqTmUyWEhHaks2RG0w?=
 =?utf-8?B?SmJuV2cweG9PMS9BL05pTEg0aklFSUp2c1lYcC9rcTdldWlQSUt3QUF2QkdF?=
 =?utf-8?B?dWZJQ0tqS3dvRm1TTUxQZTlBYkFOL0J1TzFEWU5hMXIrNHNMSmFRSnlsenBG?=
 =?utf-8?B?aUc2TmlUWjVLNWY0cUJUV2FvcGhET2o0UHU0V0NiWUFzS1dLMmY0Nng3ZXps?=
 =?utf-8?B?QmV4SWRvYUhBZTEyVUpJb0dHTlkrdjIrbjNxdW5zQjFhd1ZOclpyWXZqcDhJ?=
 =?utf-8?B?aGhtVXdHUGFtbW44dTkzL0xTODBOdENoYTh5cnBoRENDRFR2YTNXWTVhNjln?=
 =?utf-8?B?V1RpS3JjQnZzeWphVk5wUkxUQWN6VUQ2dmV3d2xnV2MzS2hPQ05ieHpmcjQx?=
 =?utf-8?B?OUxkMFFkWm1GdVNXdlVRb013Mmt2Zk1CK3ZGWDRSbmNud01MNmdkVnJBZjYx?=
 =?utf-8?B?dHlRaGZWSmdPQjBiYUxSNmttUFp2K3IxSm85U0sxdDlCcGdMclE3anJ0NUYr?=
 =?utf-8?B?cmZYYmRzSmZVNjd0NE5RN29tSUVGY3l4dVJ6Y2pHNy9YbEtrSHlORGFSNERW?=
 =?utf-8?B?UGNHSVQ3aURrT0ZRUGY5SExkVWNXV1MzS1RicXA1WjF1UWdYd0pqdFlNU3lk?=
 =?utf-8?B?OStQVll6UjhhdmFMTTVmL1pQYzIwMTlBQXFka0xGMURaV2ZkT1FMbVJsOSs1?=
 =?utf-8?B?Y0ZlNlZPczZWUCtJTm1FRVIwVDBNeW8xR0VpVjNYYVNjcG9qeWhUSkpGTDhz?=
 =?utf-8?B?T05mK2pqUDBYajErMk1pcHd1Y2tLNEtVTWZXV2cybzlublJQVzlRTVZRaXo4?=
 =?utf-8?B?dUJmSlczMEdVWkhzT0VmcklYTk1lTXVOZGhxNWNTUjdvdTdkN2ViYklPcjhn?=
 =?utf-8?B?NXJwZml5SjQrakNHZWErVmtyTW1jU0RnR1E4elcwQ002NEc4VGp5L09mc0Za?=
 =?utf-8?B?U2h1U00xSk5ZT3BvcDdweDQvKzYvSXlIUDQ5QUdCdmp6aVVHaDNpaFY1VG0x?=
 =?utf-8?B?MGc5aUpwVy9KQVk3c2lSUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFVrczNLck54b3l2WE9wRFcxanc4UDZnRjUzNi9UaGVCWkl0QmNSSlA2Rjho?=
 =?utf-8?B?MUovRUFCUmc1WTlDTlRMNlZ2djhtdUtKVXhRd1k4QUJUM1Jpc0hVclFPbXFN?=
 =?utf-8?B?WVdWNTZScGxpNVJGRTZDUkJNQTU4L1pEc3dhOWhtRzEvMHkvb3ZheUxDVWxx?=
 =?utf-8?B?eDRvYks5KzhzZW9aMFhOb2dxcTR6T3FiQkxkS3dPRGVXTUJ1Nnh3aUprK3Rh?=
 =?utf-8?B?SnQ3UEhlQTJJMDlqOUtNQWNUVjJ1ZzduV0c4YWI4UWRPRU82V0pNRFVNSllK?=
 =?utf-8?B?NE1mZHhJalgzenNkd04yMkFuaUFwMnRFUlF6VUR1M292S3I0RERScHNQWUgy?=
 =?utf-8?B?RUQxeGoyemVPRTNNOStEaUh6dDBCdjJuSTJYN0FlSWpiVUVtVWE3VXZHVW9k?=
 =?utf-8?B?bURMQUhuemlYT2JpQUJ0SnhXZ1BXZTR3MUNCaTdsRk9WTDB1aUtHWDZmM3Fu?=
 =?utf-8?B?a28vQTJJZDFENHo4WnduTjZaWmo0SEtGa1ZrYytRd2lVd0ptaW41OUxKTjAz?=
 =?utf-8?B?bHFucmxpT2xOdVdzbUJuNEs3NjlJRXZFUmNCa1k3U3pSYlJVWGJnaERNTndG?=
 =?utf-8?B?TXFmbUhDVFVETUU5RC9YYjBVdGtPVmxVSVRNSmVjaTk1UzNZSElmUVpTdElj?=
 =?utf-8?B?WC9ULzRsWEViZTdFTklEUlU3T2psVE5Dai9nNENMaVFHWkRDNUlJeUFCWE4w?=
 =?utf-8?B?TlMyVFZVcmFON1E3SDlNRTBGeTFOMWpkY1htVncxTTBLaUg5RGRJUEVBcHlT?=
 =?utf-8?B?aHVtL2xiMnhFeDJnSzF5dWJMNnNONGJFWjVqdi9tMzMxTExGS3E3UzcyMnpQ?=
 =?utf-8?B?RXVQc0RoUjhKdEV3ZTM3TkN4WlZ4dXBScktGYXo4NXdSMTBaeVdQd2xadmsx?=
 =?utf-8?B?bG1LdVc3UFhGL2VTelBIaXVnM1RFUkhDaWlCdnF0NDNkRGlKRTZjYWlLWGo3?=
 =?utf-8?B?R0MzbmlXdHdBY3JTN2YzTWxZU21heEdQTVUyZmkwQU93MThXeXBFMENFT29C?=
 =?utf-8?B?bEFvOEtlbGVvQjhGeTFBb0wvZ3VSNVRLUjkrclF4ck8zOGhtTWwvUDlZSnpw?=
 =?utf-8?B?RFZnMkdMemlUUE9LQWM4TnMveUdZL1VrNzgyU2k3OW1PTG5uQVVEQzVqVERk?=
 =?utf-8?B?ZTJHQ2YzeWtacVBTSnBCSlkzT0pZRHREbWRFbERSKzM3TmdScG5hWm9WbTdt?=
 =?utf-8?B?bTZ3aVlTQTUyc1VWQmNpcDhrUWtwU2U4VHF0VlVNTk9KbnRyTDZYeWVrZCtV?=
 =?utf-8?B?dEtZaGVDd0sxYUlqekh1TzJnaGR5WEFJY2lFdUF4VGV1Q0E2REFRUWYrd0hj?=
 =?utf-8?B?NXlSZnRRQlVjdzM4SjNOZzJSM1c4dnJoYXphVVo4aHZaUDdOTzZSZVRxY2gy?=
 =?utf-8?B?WDhuQzJvL1NoanpTbGJIa1JhQ1owNGluZWtZZWJDWUlRYWZ1VHN3V3VwYUFi?=
 =?utf-8?B?ZXFDSmUzQWx6a2pjVzNZTnBFNWFLUFcvQ0lWYTdBdzkzdk9QRmxiUGhkMTdl?=
 =?utf-8?B?R3BKelZaMUF4M2dWQkMxTGJiZFdIcnRDcDFqeElCdXlRc0UxNzVMTkxyaVNh?=
 =?utf-8?B?WFpMZ2o5TnBBenB4bDFZSWN5YUJ2Y3BCTHFZNG0vem8zME9kZStLc3BPMWQy?=
 =?utf-8?B?OHBVT3QvS1ZkNVJObU9EbWtYa1VkcFRGWENSY0FGQlFhWWtPRHlQdlF6OWVY?=
 =?utf-8?B?cWpuMS9JQ3N6RHlDcU1uMkc4YjlOQnlHYWNwaC9kWTN2NUlBVkV2UTNUU3hT?=
 =?utf-8?B?Zld1Tm11dCs0SlEwMTFmbmRMTVcyTURaREVpenN1ZmFSTmVFZHdrRVhDWFM4?=
 =?utf-8?B?TkoxczdXdmRTSUQzTm03b3c3T1BjTzY2Nm9vb3ArcSttejlQUWRrRisxQnUx?=
 =?utf-8?B?NDVNYXBnc1pLTllIU1VnREsvWG01aUw0RWJZaUpQL0ROWkxidHRsdkVYb0RO?=
 =?utf-8?B?MmhpVW9oL0RkTWV4UzBIclhJSkRCczN3NjhLbHNTNHFLem53RnBjYzFMQW9a?=
 =?utf-8?B?aWJEdUlNeGFDMWNkTE9GaE5TdHNpdlRYcVZFaU56T2tOdlBTSHpsWnF3Tmho?=
 =?utf-8?B?Y0d3RWNIMklRUUlDRGdsZGNTV1o5SGFKbW5oVytXcmlVcCtIK09ZV1g4QUwv?=
 =?utf-8?Q?LV10AafwF68K2g7/ki6wui3ny?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAC840D28F5F7E42B830DFA64786AC11@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fecc5da-42a5-40dc-d602-08dc7a39c24b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 08:32:47.0620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PtcetPAVWH2iY9DFwd0L5jSoWWa6u0eyVsVITCfooROXpywmtnd6xsXXk1syq71HV/aG+58h4tyiK7p8NAmZesAux7K6OhupBRd7RZnvweU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3403

DQoNCkxlIDIxLzA1LzIwMjQgw6AgMTE6MjYsIE9zY2FyIFNhbHZhZG9yIGEgw6ljcml0wqA6DQo+
IE9uIFR1ZSwgTWF5IDIxLCAyMDI0IGF0IDEwOjQ4OjIxQU0gKzEwMDAsIE1pY2hhZWwgRWxsZXJt
YW4gd3JvdGU6DQo+PiBZZWFoIEkgY2FuLiBEb2VzIGl0IGFjdHVhbGx5IGNhdXNlIGEgYnVnIGF0
IHJ1bnRpbWUgKEkgYXNzdW1lIHNvKT8NCj4gDQo+IE5vLCBjdXJyZW50bHkgc2V0X2h1Z2VfcHRl
X2F0KCkgZnJvbSA4eHggaWdub3JlcyB0aGUgJ3N6JyBwYXJhbWV0ZXIuDQo+IEJ1dCBpdCB3aWxs
IGJlIHVzZWQgYWZ0ZXIgdGhpcyBzZXJpZXMuDQo+IA0KDQpBaCB5ZXMsIEkgbWl4ZWQgdGhpbmdz
IHVwIHdpdGggc29tZXRoaW5nIGVsc2UgaW4gbXkgbWluZC4NCg0KU28gdGhpcyBwYXRjaCBkb2Vz
bid0IHF1YWxpZnkgYXMgYSBmaXggYW5kIGRvZXNuJ3QgbmVlZCB0byBiZSBoYW5kbGVkIA0Kc2Vw
YXJhdGVseSBmcm9tIHRoZSBzZXJpZXMgYW5kIGRvZXNuJ3QgcmVhbGx5IG5lZWQgdG8gZ28gb24g
dG9wIG9mIHRoZSANCnNlcmllcyBlaXRoZXIsIEkgdGhpbmsgaXQgaXMgYmV0dGVyIHRvIGtlZXAg
aXQgZ3JvdXBlZCB3aXRoIG90aGVyIDh4eCANCmNoYW5nZXMuDQoNCkNocmlzdG9waGUNCg==


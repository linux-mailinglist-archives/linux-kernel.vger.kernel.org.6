Return-Path: <linux-kernel+bounces-407840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9756F9C758E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C991F24EA9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B954136672;
	Wed, 13 Nov 2024 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FkW/cXfn"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E38208A7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510308; cv=fail; b=iJU9WYSFObraHZqdBXaB4lLfCiGkut+qkTQgLc2/Tct9LQwJ8grUC98jh1xCYrn3l+uikTXfk7TTJaJjOTjhlLLD92pk57x6uQB55pVPfyZzkI/+UhLSNBqkYqsW+8Qa9mgE3SmzHcHUo3+rvwC3utXHT3wYQUcJK41AB7LRWIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510308; c=relaxed/simple;
	bh=3VrPrFah5Ke4ZDgrj8PWHnhj/OP5PKsVu6j8z4fI8R0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=crG5V83wUkckIyDrIsuwCsP0K8f7ElKIIAvx37htvmuJMDGzCzIyuRiGtQzB5wJhTFoX4aMh+lqwZwCjCKS4iOT0gU0+x0DPZeqqS8EEwFxPPLhUEurlK2NaDNU6dl6QYGu9fhaUwjUpjwUDY78r51koundVQQPieiV2yEYa8rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FkW/cXfn; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eL6d8hgb98rxASlAoVVIo9obR2rLoNvPBjPHnMkF4EJTc4FQskyeqgrZaDveRAoN92hB5nzJI7xbl1oUzTaJYWTVmtdDDRk56PoyT7r2Uu6w0SOeA9ipue/4Sxj3zew0hGPWnpOmnLrPAfMxH2qYR7AH93dnluM9iuDGrxXs6oWL+YQcCNS55J/ImvRm0qj7CWiPsmQXohhBvhRLuOATfOex0UABT456sxDfY/uJWt1u//sKlNCb2+1v1Xmz4hJoNbf4c0lKikWbjkOApKyLOEkGTeV4n/w/qiZAB6p0gMzPdgoxXe59ANVRDSXs2d6/tPsJYxMm+/J9Bsdv+pY5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VrPrFah5Ke4ZDgrj8PWHnhj/OP5PKsVu6j8z4fI8R0=;
 b=WEMujzTz0muD9qF5VirrwwYcbGZfCqhfk5oOIxr4pjH2GseiSpY/CpaBuej9c3w/ZXne2qxARwMz184P/af4Ij5lenvQ7zYD/PJhLRC664Z+zJLZ+fab90HRezXkOmjDP8i0Nhxss1kZaolGrtwtSPgmjpXDXiR5JwDlMLqKeqvcCpmHy0gcV3k1Dkp6nh/ZGGt0V/RQlZjB7uGfsyYd03x6GqFS5NiS3fYLlv+bPVDAid28L6BmVoMUG8O/tyt+BbyqMJuhFxcNY2iZswR7L8e/bTQF73FuneXelMuxCyIYTDlJGb+Lac1maohFlgAKMbzyZjm2CVm76TOg3L4tXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VrPrFah5Ke4ZDgrj8PWHnhj/OP5PKsVu6j8z4fI8R0=;
 b=FkW/cXfnEhfD/L/FkyuEQurBIyj8rKSd25/gSo3XVyciuSLcBsSd1h3K44hJitPCPJQJ+J1gpnywbRmMg6LOoVBZ1D3njD09OYKvsJ83Pq9h6HlUeebIipK/UHIlXdpup3oABo7LS154dl+7TBk+7yDfYoXXA9bRuopDBeoFhSU=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 15:05:01 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%6]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 15:05:00 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Brendan Jackman <jackmanb@google.com>, "Manwaring, Derek"
	<derekmn@amazon.com>
CC: "bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, "mlipp@amazon.at"
	<mlipp@amazon.at>, "canellac@amazon.at" <canellac@amazon.at>
Subject: RE: [PATCH v2 19/35] Documentation/x86: Document the new attack
 vector controls
Thread-Topic: [PATCH v2 19/35] Documentation/x86: Document the new attack
 vector controls
Thread-Index: AQHbMDg1JLBBlMsMQUStBRLaO7h7dbKqT+jQgApQQICAAKyDAIAACV4g
Date: Wed, 13 Nov 2024 15:05:00 +0000
Message-ID:
 <LV3PR12MB926503BA63C616562E508D8C945A2@LV3PR12MB9265.namprd12.prod.outlook.com>
References:
 <LV3PR12MB92658EA6CCF18F90DAAA168394532@LV3PR12MB9265.namprd12.prod.outlook.com>
 <f3ddabdc-39fa-45fa-97fd-d8508c2229c9@amazon.com>
 <CA+i-1C1zN_GcLagTRgfJqT6uFoZaMZj1NUfxkvP7eG=VGQ0GGQ@mail.gmail.com>
In-Reply-To:
 <CA+i-1C1zN_GcLagTRgfJqT6uFoZaMZj1NUfxkvP7eG=VGQ0GGQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=95057f9d-2ffc-4ea9-bc1d-011079888366;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-13T14:49:27Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|SN7PR12MB7449:EE_
x-ms-office365-filtering-correlation-id: 3c5c921c-e1ea-4f66-c9ad-08dd03f48bcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TUoybHM5S2xvYkJUNllRd1Z0RWtxdkUyMDdYdm82TjlUTWhtRXlCRnJtUmdr?=
 =?utf-8?B?dXRrMFpBajQ2ZkZRVUIxOE5sT3VIVU9JdVdSeDdJYkdPVEVRalA4QWpQMjA1?=
 =?utf-8?B?bTZucFBSU3I3UGhZSnBuNzhrUmRleklsQ1JiSnViSHl6SUpqc2toNzBkSTVh?=
 =?utf-8?B?R2FuMk1BQWcyRnQzU21mYXd6YTZDQTN0MVhabmlLemhpWFdVRG5idTEzQitT?=
 =?utf-8?B?eVhoeWd4NlJaclJLVFJnVXYvem9wSmV4WGRxa0lCbFhNTFNBcWhkUnQrOE9I?=
 =?utf-8?B?QUMwSmtjdnlnaGpIMDMxN3BjNGE4ZWNkR0ZXRkV4ZlJXM09YRDRFU0JBTjNw?=
 =?utf-8?B?d2UweFc2T25ZWXMyeU9iV2hrVTA5WElraGdKemJaSVRuWC9KQlFUb0kvWWVR?=
 =?utf-8?B?UFNwalA1bTNVU2h4aVV3dmJPbGVZbURYYWVicjhMNnhTK1IrZkZidGFZWDV0?=
 =?utf-8?B?bEQ2NGtTbXVDRVV4YjduWWhaZ2tPNDRtMnhlQU0xVlhzSlU0YkJ4UDg0dXo2?=
 =?utf-8?B?aUtZajUxVWNuRjBWVnM2S2VCZjdVOHlFYjJub3hMMVhxenlzWkNnekRnRnBZ?=
 =?utf-8?B?d3JpTEJmSFo5S2pGaXZXRkNiOEtFVm9JbG5yU04yYWltQlo1dVpLVERDZU83?=
 =?utf-8?B?QXI3b3JXbmRKTkNNQXE5cEdyMnBVSXNIMGxmMThMN1R0Q0Uwa1NDL09wcGtW?=
 =?utf-8?B?b2xTLzNCWnVld0ExcURjSE5SaHpHYWYrckliMmlIYzdzdVRGbTRWRVZyenhw?=
 =?utf-8?B?OU9IdzlKWVlpUi85MmllakI0d0JxZVlza2lrS3JZaVFUbVFKZFlwVjh3TmJt?=
 =?utf-8?B?QzFreXpUUnVSc3h2VklMUndzUUhVZUJCT3JjZ0g2RUZzemo1UE9lNkdSampi?=
 =?utf-8?B?ckRobWg1bGJnQ0VHUVFKTEpZNTNYTGJSbWYrMXRST3VxQXJ2eWtlUm1sN3hm?=
 =?utf-8?B?eThHOG9VRFRqQklsR1pCVkVzUnpOaUc0dVRZSG00UUFUbEl1TGJmZW9nZjZx?=
 =?utf-8?B?WmRWNjM1d3NqcE9ZTnVQdGpSTkM4RkdiQUgzMzV6Y1RtQ09yZ0R0U2k0N1Zu?=
 =?utf-8?B?QVNFQWhTNEZkRnh2L1BPaVA5TEd0cDZSbDJ0c2FzR0ROdndpb1ZNT2kxekFz?=
 =?utf-8?B?SXpGM3dhQ0JxSUMvMW5GckI1MlV5UlVsZTlOWXVtbVYxRW9kOHBvaS9uTklm?=
 =?utf-8?B?WStHS2JkQXRiK29yb3QwdnJwdCtWaTZPVFRzWFo2Z3EwQzdJdWNId2lrbiti?=
 =?utf-8?B?ZzBIb29rY2M0b0JjdGVvcHJXemNLdjRKQ3NmdVZWYUw5OTFpVGhCWGU1MnNj?=
 =?utf-8?B?TjVUaTNJcVBmNnJiQmtHbkNWNWFlU3NuOThseUJQM3ZJYmVETDRleWhxM2sw?=
 =?utf-8?B?TTUzMWtLSlB1YjBLVjNMZk1mUzc0bjRtNk4zNWtRS2NrcnJmTVpHclZSeWFl?=
 =?utf-8?B?UUhoMUxuU0h6WW5pWHI1YjVhMGpDSHd0TGEvdU5lTmV4alFUTmh0NXNBYXQ5?=
 =?utf-8?B?KzZYcUNMRmRZcFBUam5xRGZaZjdIM01mWW5WSEN2c1JMWDNNdytkazIvTVFT?=
 =?utf-8?B?NUViaVhaTGlzQmhKNDgzY2IrUkh5UTVzZDQ1SXpFWmxZT2xPMXNpem9CV3dO?=
 =?utf-8?B?RnkxWkxza2w2VXEybzI0QnhCVW9XOTZPQWlxeU45T1hpU2oxT09wb0pjak1Y?=
 =?utf-8?B?c0x6U3BwaUdzemV5Q0lCaDZJMm10RTk3Njk2UXU1NXlyR3JkaTFZZjcwSnpP?=
 =?utf-8?B?Qklhcm0yTllhd1hvOEJuNlUwMU52bDdrakZob2pjVDNsNlN2OFN2REl1S1Y0?=
 =?utf-8?Q?bM8S8okNoZD0YC3NPvKjnuxxw+Fb50DGc/1y0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UkR1VG5hNDVjYldTeXdaRXRVY2RTc2VORHBjdS9Yd1dNdlNhS3BKQUhWd0R5?=
 =?utf-8?B?VXF0eW5wUFBOc2huTXZXcFArVnNzdnV5WUg4RTdnZEFScVY3N0swU1lkK1BU?=
 =?utf-8?B?Y0dVYzNZa3YvbG40OTkwcjU4TlEvN0U2RmkydzZFM1hOVlJDUHRYZnBDNVIz?=
 =?utf-8?B?OFBTZFR0bWVaUndVRkFWcWtTY3VmL0xXclpFM1VsZ0F1bVBac01tL1hGdXRr?=
 =?utf-8?B?eXlqMEUrc25UN2Q2alp3QzZtUkJqTDZidC9xcjFSSWJUWXJ6M2c0VkFDbU02?=
 =?utf-8?B?RnErd3ZaU2NEcWlCdHMwZ2pvMzRUT0lkZTZXUkc5OFRJZnJsYk5Ld1VEMkt2?=
 =?utf-8?B?VGlVR3M3bit4a1VaNFEyWVMvbVBJbVN5N0JMTnh5Uk9CaU9FanlsVkx5OUhM?=
 =?utf-8?B?ZTl3aXZYWExBVG1ienRnODdOMU5TeTUyUFlkeFNPQ0hKOUNWNUZFQm5TWnc3?=
 =?utf-8?B?NjVEWE5nNWdiYnFpbHFOSFhsZlg5UXBKdENpd0JUVE01R0IrdU1jK21uWVAz?=
 =?utf-8?B?Y0l6RmVURkE4QlYxRTRRNnpQMjh3UXZ6eUNRYUtucGVFSVFPUTRQZ1QrdDZS?=
 =?utf-8?B?R1Rxa01xS3Z2UEVQcU0rQzUwZzd3OU9ka0Fzc3ovZmtrb1REaGtybExhRm94?=
 =?utf-8?B?N3VKTmdJSVJDMnFtbGZQOXR3TmpnT1JHRWlEUU1GdUNhTnlhRFV4RHlpMG1S?=
 =?utf-8?B?SElSbzhaTis4MG5sNnErY2trTTJ6RW1UNG1INWRkdmdCUjJmbHh4SHFHS0Zr?=
 =?utf-8?B?Mmx4SkdCZTRvV3JRS2Z2SFZjWklzalhIWE9XZUoxVStINjlMeGFiMFZYSUxW?=
 =?utf-8?B?Z0ZITmhGcTNwdGxZd2lHYzdpcVdOR3NlTU01Ny9IcW8waGUzTmpGYWFQbWtI?=
 =?utf-8?B?NEZxOXloWklkMysyOXJLb1B6aU4vZTVTRFIyZ3lidUxINWJhbElNVEdtYzNQ?=
 =?utf-8?B?RGUxaGYwZlBwQ3E1RTYyZmdjK0UwQ2ZiOStBbVdXR3hXN2F4TXlkZDlVa1Zp?=
 =?utf-8?B?OXE1K3JqRFRkZ1JMZGpVV0NUQUpPc3dVaFpqU3V6Si9BZklWVStDZm1SaVh6?=
 =?utf-8?B?OVdSYkRzTUlNTTRCbm81RzdBWFVSNm9ZSnBMZWxRdEpoRXRwOHc1MkNDVkV0?=
 =?utf-8?B?b2FsVmxoclNhNWd2Z212Y3VXZ3lxQlJzclVoUEtNQjdJbkxKSEVxQzM1QWh1?=
 =?utf-8?B?YjFzMnNmSUdzTGtEdGQvYlB1MWswSHdKdWVLMFE0SCtFZ0xxU2gvTWh1V21N?=
 =?utf-8?B?bTNRTTNPZFBpc05ES2doQmdmU3lhbWJYa05DWjI3SUpZeXk1cjVPNlBCUTV4?=
 =?utf-8?B?ZlNOSGh4QURRS2xMd2NsdlllVW5QakVpY3dXZ3hqUHZaYTFjOVRMbHBBVnlm?=
 =?utf-8?B?ak9ZNVUrdmh3bTFsbjlmTTdOMlJOMnZrKzJ1WUwzckVXT3A0NzNqRnlITnZI?=
 =?utf-8?B?TEJlTkR3OTZkbEVOMHBrRTI1bFhiWHJwTW5YeDRyL21CeHhURTlWRXJmcjBp?=
 =?utf-8?B?RDQ3ZHd3Unk2VlV5N3FiRkZPQTJZWXZLTndvdGZZNWdUSTEwNDA5SnNWWkFW?=
 =?utf-8?B?MURGTmJRRmN4YUI4amNHS25mdGU2bitGVWxpZytBT25HdVlpZ3dBYkdVWC84?=
 =?utf-8?B?NklhUzZvV2NnWWlUaUozZmxGNXRCZHhoL0dycXBaN29DLzR0MGlaVzJaUTZ5?=
 =?utf-8?B?MS9IQXFBOWUra0xWa0xzY2JpSDdUV09kWXp5dnAwT2RVeXBaREtCR1NuWWpp?=
 =?utf-8?B?NjUwcGtNOHV0NEZOeWc3N0VTbExBcGY1T1Y4THk1QktDbTB5VmdUQUpYMGFz?=
 =?utf-8?B?MmNSSVFkSm1mM1NsZDhDVzhibjdvb0Z5MmlwcXVtbHJld1h5cXFaK1JMOEVM?=
 =?utf-8?B?T2JDc1dvTENxTlhDZzArZ1ZneGJZcmVIdXo1QmVKZlJ5SzVHME9QbTlzQ2Jh?=
 =?utf-8?B?UzgzTm5Fd29LUzBMVHJFWXp2TWFmTkwrNVhxWkJQVEhkYzM4dlVpKzJ5ZmVs?=
 =?utf-8?B?QnJnZndHK1lsVlQwcFhYT2NBc0IvTi9JbjJwMEdoV2I4d1pPZUNUMWJxdWFZ?=
 =?utf-8?B?M2NNeXNHbzk4SUd1eGZCdm5RZnoyZXV0dysveU5rbHFwNkFuYjMxeFZLa1J0?=
 =?utf-8?Q?f5Gg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5c921c-e1ea-4f66-c9ad-08dd03f48bcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 15:05:00.8265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YLcVgTAhP6eCt97DSPBjJ8zHaOE41k6ctghAUBZeZZl5zN5Rnb2o6K7XazxXERqg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCcmVuZGFuIEphY2ttYW4g
PGphY2ttYW5iQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMTMsIDIw
MjQgODoxNiBBTQ0KPiBUbzogTWFud2FyaW5nLCBEZXJlayA8ZGVyZWttbkBhbWF6b24uY29tPg0K
PiBDYzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+OyBicEBhbGllbjguZGU7
DQo+IGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsgaHBhQHp5dG9yLmNvbTsganBvaW1ib2VA
a2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG1pbmdvQHJlZGhh
dC5jb207IHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbTsNCj4gcGV0ZXJ6QGluZnJh
ZGVhZC5vcmc7IHRnbHhAbGludXRyb25peC5kZTsgeDg2QGtlcm5lbC5vcmc7IG1saXBwQGFtYXpv
bi5hdDsNCj4gY2FuZWxsYWNAYW1hem9uLmF0DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMTkv
MzVdIERvY3VtZW50YXRpb24veDg2OiBEb2N1bWVudCB0aGUgbmV3IGF0dGFjaw0KPiB2ZWN0b3Ig
Y29udHJvbHMNCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBF
eHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNo
bWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBXZWQsIDEz
IE5vdiAyMDI0IGF0IDA0OjU4LCBNYW53YXJpbmcsIERlcmVrIDxkZXJla21uQGFtYXpvbi5jb20+
DQo+IHdyb3RlOg0KPiA+ID4gSSdtIG5lcnZvdXMgYWJvdXQgb25seSBkb2luZyB0aGUgZW5kLXVz
ZSBjb250cm9scyBhbmQgbm90IHRoZSBhdHRhY2sNCj4gPiA+IHZlY3RvciBjb250cm9scyBiZWNh
dXNlIG9mIHRoZSByZWFzb25zIG91dGxpbmVkIGFib3ZlLiAgRm9yIGV4YW1wbGUsDQo+ID4gPiBJ
J20gdGhpbmtpbmcgYWJvdXQgc29tZSBwcm9wb3NlZCB0ZWNobm9sb2dpZXMgc3VjaCBhcyBLVk0g
QWRkcmVzcw0KPiA+ID4gU3BhY2UgSXNvbGF0aW9uIHdoaWNoIG1heSBnbyBhIGxvbmcgd2F5IHRv
IHJlZHVjaW5nIHRoZSByaXNrIG9mDQo+ID4gPiBndWVzdC0+aG9zdCBhdHRhY2tzIGJ1dCBtYXkg
bm90IGJlIGZ1bGx5IHNlY3VyZSB5ZXQgKHdoZXJlIHRoZQ0KPiA+ID4ga2VybmVsIHdvdWxkIGZl
ZWwgY29tZm9ydGFibGUgZGlzYWJsaW5nIGEgYnVuY2ggb2YgZ3Vlc3QtPmhvc3QgcHJvdGVjdGlv
bnMNCj4gYXV0b21hdGljYWxseSkuDQo+ID4gPiBXaXRoIGF0dGFjayB2ZWN0b3ItbGV2ZWwgY29u
dHJvbHMsIGl0IHdvdWxkIGJlIGVhc2llciB0byB0dXJuIG9mZg0KPiA+ID4gZ3Vlc3QtPmhvc3Qg
cHJvdGVjdGlvbiBpZiB0aGUgYWRtaW4gaXMgY29tZm9ydGFibGUgd2l0aCB0aGlzDQo+ID4gPiBn
dWVzdC0+dGVjaG5vbG9neSwNCj4gPiA+IGJ1dCBzdGlsbCBsZWF2aW5nIHRoZSAoYWxtb3N0IGNl
cnRhaW5seSBuZWVkZWQpIGd1ZXN0LT5ndWVzdA0KPiA+ID4gcHJvdGVjdGlvbnMgaW4gcGxhY2Uu
DQo+ID4NCj4gPiBQZXJzb25hbGx5IEkgd291bGRuJ3QgcHV0IHRvbyBtdWNoIHdlaWdodCBvbiB0
aGUgcG9zc2liaWxpdHkgb2YNCj4gPiBkaXNhYmxpbmcga2VybmVsIG1pdGlnYXRpb25zIHdpdGgg
dGhlc2UgZnV0dXJlIGFwcHJvYWNoZXMuIEZvciB3aGF0DQo+ID4gd2UncmUgbG9va2luZyBhdCB3
aXRoIGRpcmVjdCBtYXAgcmVtb3ZhbCwgSSB3b3VsZCBzdGlsbCBrZWVwIGtlcm5lbA0KPiA+IG1p
dGlnYXRpb25zIG9uIHVubGVzcyB3ZSByZWFsbHkgbmVlZGVkIG9uZSBvZmYuIEJyZW5kYW4sIEkg
a25vdyB5b3UNCj4gPiB3ZXJlIGxvb2tpbmcgYXQgdGhpcyBkaWZmZXJlbnRseSB0aG91Z2ggZm9y
IEFTSS4gV2hhdCBhcmUgeW91ciB0aG91Z2h0cz8NCj4NCj4gWWVhaCwgcGVyc29uYWxseSBteSB2
aXNpb24gZm9yIEFTSSBpcyBtb3JlIHRoYW4gaXQgX2lzXyB0aGUgZ3Vlc3RfaG9zdC9ndWVzdF91
c2VyDQo+IG1pdGlnYXRpb24gYW5kIGZvciB0aGUgUkZDdjIgKGxvbmctYXdhaXRlZCwNCj4gc29y
cnkpIGl0IHdpbGwgYmUgdGhlIHVzZXJfdXNlci91c2VyX2tlcm5lbCBtaXRpZ2F0aW9uIHRvby4N
Cg0KSSBkb24ndCBzZWUgaG93IEFTSSBjYW4gZXZlciBiZSBhIHVzZXJfdXNlciBtaXRpZ2F0aW9u
LiAgVXNlcl91c2VyIGF0dGFja3MgYXJlIHRoaW5ncyBsaWtlIGluZmx1ZW5jaW5nIHRoZSBpbmRp
cmVjdCBwcmVkaWN0aW9ucyB1c2VkIGJ5IGFub3RoZXIgcHJvY2VzcywgY2F1c2luZyB0aGF0IHBy
b2Nlc3MgdG8gbGVhayBkYXRhIGZyb20gaXRzIGFkZHJlc3Mgc3BhY2UuICBVc2VyX3VzZXIgbWl0
aWdhdGlvbnMgYXJlIHRoaW5ncyBsaWtlIGRvaW5nIGFuIElCUEIgd2hlbiBzd2l0Y2hpbmcgdGFz
a3MuDQoNCkFsc28gZ3Vlc3RfdXNlciBtaXRpZ2F0aW9uIGlzIG5vdCBhIHRoaW5nLCBkaWQgeW91
IG1lYW4gZ3Vlc3RfZ3Vlc3Q/ICBJZiBzbywgdGhlIHNhbWUgYXJndW1lbnQgYXBwbGllcy4NCg0K
DQo+IElmIHdlIGRlY2lkZSB3ZSB3YW5uYQ0KPiBrZWVwIGV4aXN0aW5nIG1pdGlnYXRpb25zIGlu
IHBsYWNlIG9uY2UgQVNJIGlzIGF0IGZ1bGwgc3RyZW5ndGggdGhlbiBBU0kgbW9zdGx5IGZhaWxl
ZC4NCj4gKE9yIHBlcmhhcHMgdG8gYmUgbW9yZSBjaGFyaXRhYmxlIHRvIEFTSSdzIHN0cmF0ZWdp
YyBwcm9zcGVjdHMsIEknZCBmZWVsIE9LIGlmIHBlb3BsZQ0KPiBzYWlkICJJIHdhbnQgQVNJLCBi
dXQgSSdsbCBrZWVwIHRoZSBvbGQgbWl0aWdhdGlvbnMgZm9yIGRlZmVuY2UtaW4tZGVwdGgiIGFz
IGxvbmcgYXMgd2UNCj4gdXN1YWxseSBkb24ndCBuZWVkIHRvIGRldmVsb3AgX25ld18gbWl0aWdh
dGlvbnMgZm9yIHRob3NlIHBlb3BsZSkuDQo+DQo+IFNvIHJhdGhlciB0aGFuIHNheWluZyAiSSBo
YXZlIEFTSSwgSSBjYW4gdHVybiBndWVzdC0+aG9zdCBtaXRpZ2F0aW9uIG9mZiIsIHlvdSBzYXkg
IkkNCj4gaGF2ZSBBU0ksIGd1ZXN0LT5ob3N0IG1pdGlnYXRpb24gaXMgdmVyeSBjaGVhcCwgbGV0
J3MgaGF2ZSBzb21lIGNoYW1wYWduZSIuIEluIHRoZQ0KPiB1dG9waWFuIGNoYW1wYWduZSBmdXR1
cmUgb25seSB2ZXJ5IGFkdmFuY2VkIHVzZXJzIHdpbGwgaGF2ZSBhbnkgaW50ZXJlc3QgaW4gbW9y
ZQ0KPiBmaW5lLWdyYWluZWQgcXVlc3Rpb25zIHRoYW4gImRvIEkgdHJ1c3QgbXkgS1ZNIGd1ZXN0
cyIuDQo+DQo+IEkgZ3Vlc3MgYW5vdGhlciB3YXkgdG8gbG9vayBhdCB0aGF0IGlzOiB0aGUgZGlz
dGluY3Rpb24gaW4gdGhlc2UgcGFpcnMgb2YgYXR0YWNrIHZlY3RvcnMNCj4gaXMgcXVpdGUgc3Vi
dGxlLiBUaGUgZmFjdCB0aGF0IHdlIGFyZSBldmVuIGNvbnNpZGVyaW5nIGV4cG9zaW5nIHVzZXJz
IHRvIHRoYXQNCj4gYXdrd2FyZCBzdWJ0bGUgZGlzdGluY3Rpb24gaGlnaGxpZ2h0cyBhIHdlYWtu
ZXNzIG9mIExpbnV4J3MgY3VycmVudCBtaXRpZ2F0aW9uDQo+IHBvc3R1cmUgYW5kIEkgdGhpbmsg
QVNJIHJlZHVjZXMgdGhhdCB3ZWFrbmVzcy4gVGhlIHdlYWtuZXNzIGlzOiB0aGUgY29zdCBvZg0K
PiBtaXRpZ2F0aW5nIGF0dGFjayB2ZWN0b3JzIGRvZXNuJ3QgbGluZSB1cCB2ZXJ5IHdlbGwgd2l0
aCB0aGUgZGVncmVlIG9mIHRocmVhdCB0aGV5DQo+IHByZXNlbnQuIFdlIHRoaW5rIGl0J3Mga2lu
ZGEgdHJpY2t5IGluIHByYWN0aWNlIHRvIHN0ZWFsIGludGVyZXN0aW5nIGRhdGEganVzdCBieSBn
b2luZw0KPiBpbnRvIHRoZSBrZXJuZWwsIGJ1dCBpdCdzIHByb2JhYmx5IHBvc3NpYmxlLCBzbyB3
ZSBoYXZlIHRvIHBheSBtaXRpZ2F0aW9uIGNvc3RzIGV2ZXJ5DQo+IHRpbWUgd2UgZ28gaW50byB0
aGUga2VybmVsLiBSZWxhdGl2ZWx5IGxvdyByaXNrLCByZWxhdGl2ZWx5IGhpZ2ggY29zdC4gU28g
d2UncmUgaGF2aW5nDQo+IHRvIHNheSB0byB0aGUgdXNlciAiZG8geW91IHdhbm5hIHBheSB0aGF0
IGhpZ2ggY29zdCBmb3IgdGhpcyBsb3cgcmlzaz8gV2UgY2FuJ3QgdGVsbA0KPiB5b3UgaG93IGxv
dyBpdCBpcyB0aG91Z2gsIHdlIGNhbiBvbmx5IHN0YXJ0IHJhbWJsaW5nIGluY29tcHJlaGVuc2li
bHkgYWJvdXQNCj4gc29tZXRoaW5nIGNhbGxlZCB0aGUgJ2ZpenogbWFwJyIuDQoNCkkgZGlzYWdy
ZWUgc29tZXdoYXQuICBUaGUgZGlzdGluY3Rpb24gYmV0d2VlbiBzYXkgZ3Vlc3QtPmhvc3Qgb3Ig
Z3Vlc3QtPmd1ZXN0IGF0dGFja3MgaXMgd2hhdCBpcyBiZWluZyB0YXJnZXRlZC4gIFRoaXMgaXMg
ZXNwZWNpYWxseSBlYXN5IHRvIHNlZSBpbiB0aGUgY2FzZSBvZiB0aGUgYnJhbmNoLWJhc2VkIHNp
ZGUgY2hhbm5lbHMuICBJdCdzIGFib3V0IHdoZXRoZXIgeW91J3JlIGluZmx1ZW5jaW5nIHRoZSBw
cmVkaWN0aW9ucyBpbiB0aGUgaG9zdCBvciBhbm90aGVyIGd1ZXN0LiAgVGhlIHN1YnRsZSBwYXJ0
IGlzIHRoYXQgdG9kYXksIGd1ZXN0IHNlY3JldHMgZXhpc3QgYm90aCBpbiB0aGUgdmljdGltIGd1
ZXN0J3MgYWRkcmVzcyBzcGFjZSBhcyB3ZWxsIGFzIHRoZSBob3N0J3MgYWRkcmVzcyBzcGFjZS4g
IE1lYW5pbmcgdGhhdCBpZiB5b3Ugd2FudCB0byBwcmV2ZW50IHRob3NlIHNlY3JldHMgZnJvbSBs
ZWFraW5nLCB5b3UgbmVlZCB0byBwcm90ZWN0IGJvdGggcGxhY2VzLiAgQVNJIGNhbiBwb3RlbnRp
YWxseSBzb2x2ZSBvbmUgb2YgdGhvc2UgcHJvYmxlbXMsIGJ1dCBub3QgdGhlIG90aGVyLg0KDQpJ
J20gYWxzbyBuZXJ2b3VzIHRvIGFzc2VydCB0aGF0IGJlY2F1c2UgY2VydGFpbiBhdHRhY2sgdmVj
dG9ycyBhcmUgY2hlYXAgdG8gbWl0aWdhdGUgdG9kYXkgZG9lc24ndCBtZWFuIHRoZXkgd2lsbCBh
bHdheXMgYmUuDQoNCi0tRGF2aWQgS2FwbGFuDQoNCj4NCj4gQXQgZmlyc3QgSSB3YW50ZWQgdG8g
c2F5IHRoZSBzYW1lIHRoaW5nIGFib3V0IHlvdXIgd29yayB0byByZW1vdmUgc3R1ZmYgZnJvbSB0
aGUNCj4gZGlyZWN0IG1hcC4gQmFzaWNhbGx5IHRoYXQncyBhYm91dCBhcmNoaXRlY3Rpbmcgb3Vy
c2VsdmVzIHRvd2FyZHMgYSB3b3JsZCB3aGVyZSB0aGUNCj4gImd1ZXN0LT5rZXJuZWwiIGF0dGFj
ayB2ZWN0b3IganVzdCBpc24ndCBtZWFuaW5nZnVsLCByaWdodD8NCg==


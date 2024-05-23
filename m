Return-Path: <linux-kernel+bounces-187929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04508CDADE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47F71C22C37
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7D283CBD;
	Thu, 23 May 2024 19:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cyg18026"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C8583A0D
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716492527; cv=fail; b=j7doy15Sab0QD+uWfLYoGRwuOqEVdj8GXFj+rGtUovNQkcK/P+z53fr7ddOHDsXrhCO0IK754sg2XVpVlvDvEjWc1RZdelc6AHGTLjEoNJJh3E3de01RgXUkm2rNvfSPSrNzocL/8Mhgob+3w1yPJ72OvAaWeD1c0K4MM0yJYFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716492527; c=relaxed/simple;
	bh=mhBR8zzHV1sRVKf1SiG3fhv2m+qPWVdgYQ4Kdtno0fc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KcfrRjm/IRsLJNOE/90fpAxZW1jFWq/koG5hubsWgtX0W6Wu/Ot+oOcSkt0szq9+dl5fxrN7hatsV6PFHLpoo9luhLutRDwGhSkrJ+4gYdPTQu7veLLoYdS5uKVuXnmm52tmz7h0oyB/KFgcblxGhlclSm8BfZDrOoeX0yA/z5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cyg18026; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAAaAnoXYqNyvwL4y4blWOYSNrQAqWCEQwWJlQbgmZv24IJSH8tQFljgSDN0vZDjZFoFnOY9r+i4tZToHLU8/t58ptrGfG97cJzh7K2mXw6Cu6IngbPQ7bdMMvGLExeGMUvGCeaTYBdBmiN5PhftG/r3PF3cU8m68ds3mDnXfS42PAYIa4SplvIhLXqec8Z5ETv5HK558M1vIpdtSENjPCrYAqjsUnUfRqc6Km6WhKxmM0YrlY4WEAQXNb/KfytKICMak/bZV+CG7ppxfC57HmrQUXHlrWWdtjS1SvqC/DgHkIKJLWLLx/gBCrnDNwyeUv2a5dqTb4p/xg+6l0hFdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhBR8zzHV1sRVKf1SiG3fhv2m+qPWVdgYQ4Kdtno0fc=;
 b=X7m0oGNpooG6L77LHbyp5FeVfgJJoS300+BkQrreeOVZc6bMoPfP5HfxKZ61omN9a9/JDas1uC6CPfkR6u2tIxm+bdpzQi895WOaKRyQpG3EnyQs3PjCbV/J9Gxoa9r1w2+bb0FJ5UJMDxK0i33drFcNgl3Q2tF5ohmbin5Ljz2gD8ZDjIpYDIXpIz48nxFZlIPm1Lnlr22x5C7i6jUzuT0ONrHY6pLQ/XwBVKNHiJlAE0vykbKlEoA7NY/OXEj3MTynG74OBeQoHm5/uZwj0Zr3SKycNY3YR1t67/SUBjdDXyO/NDNuZrL1i8LLAYHZqvuX6OSSMKE4iXFi8LSClg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhBR8zzHV1sRVKf1SiG3fhv2m+qPWVdgYQ4Kdtno0fc=;
 b=Cyg18026HXUAQ9QvjxdQUPw50wEpSFCU8y8I9Q+Gxc1RX+rBREAVNncEev4bPZaM06tVmMnPk3Wx2zc1kv9e+HWGF60vO8fNDEdKOVS5tSsMXrDQe5hcSi+SefHWIcHOTEBHW3e0NRuz7zfhBftuxQWz1/AyCSnnf4aYek8o9JMNHMGT+hmrj02l3vOGk5R9o8dSmM+5VcY5IiAgp4auTLjwWYOCJrXY4Oc9ekgyi+aLdz3FP2wlzcOv84m+ukYNT8fp0b6f+diQsWect7jujsziUF/bTgLwvqj0bjimaZ4Mz0UJo/OKP7+8pAZypT2q/yusvXBs0AoPo7ryaroHEw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN6PR12MB8469.namprd12.prod.outlook.com (2603:10b6:208:46e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 19:28:43 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 19:28:43 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, John Meneghini <jmeneghi@redhat.com>,
	"emilne@redhat.com" <emilne@redhat.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jrani@purestorage.com"
	<jrani@purestorage.com>, "randyj@purestorage.com" <randyj@purestorage.com>,
	"hare@kernel.org" <hare@kernel.org>
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Thread-Topic: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Thread-Index: AQHarGjF7HO7Dhk/3EeKOsPlzX5snbGkOs4AgAAhN4CAANoAAA==
Date: Thu, 23 May 2024 19:28:43 +0000
Message-ID: <b7cfba48-91ea-46cd-b867-559d9d0d135c@nvidia.com>
References: <20240522165406.702362-1-jmeneghi@redhat.com>
 <935f7e10-ccb4-4891-8f29-84909c061e7a@nvidia.com>
 <60758e4d-4bdc-4a99-a151-a9009a8a460f@suse.de>
In-Reply-To: <60758e4d-4bdc-4a99-a151-a9009a8a460f@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN6PR12MB8469:EE_
x-ms-office365-filtering-correlation-id: 645cfe47-22e8-408c-75a8-08dc7b5e8eb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?WXJnb05JOTNVMWFxZjdFZVhxdnRJQ296WmhPRG00T0MzTmlQUDRYZXFjUkJv?=
 =?utf-8?B?YmVHSndGWlcxOGhNaS9lZy9DR0pLeHplZmxoSExsdTAxdnBUbXRVWmxkbXR5?=
 =?utf-8?B?RzFQRDBraWkwNTliK1A5NlRqeHhXL0Z1S1F5dHZZeVFyZTh0NkkwVEZyaUU2?=
 =?utf-8?B?S3ExdENhM3RhNjBiZjVYbTVOOEhuL1lNR3MrSW1MWHlkYlRsWjM2NzJSTC81?=
 =?utf-8?B?bVZ5c1ZSWU9QUG9WZEZwZmRNalo3Z0VyQVpSSEd6MlEzcnFvTGJTSlFMNUl3?=
 =?utf-8?B?cWIrTGpJZTVhQnphVm5JajNPSkl5S0JTTkFENFFneGowZFRxUmFxOU9WZGVv?=
 =?utf-8?B?Y3lvbndIM2lHWklCYmp2YWwzNkhKcmtnVjAydy9oaFllUloxMlRudm1nMGFR?=
 =?utf-8?B?VzBtMHN2bVlCVE12UEFHUmwvS2Zqa3R2NDN0Z2EyV0RjS0x0TTdnb1JTMkNO?=
 =?utf-8?B?Wi9GcW9ZWWV5ZHllTlpENVR3V2NtS2F2Vml6ZXEyQi9tN3d0Y1QwcTA1UVVv?=
 =?utf-8?B?ZkViN01adFpNbUIwQ3kxNW9Ncm5IUW9VQmtIaUVld0R1RnNIdzNLSWlqdElx?=
 =?utf-8?B?dVVJRlM4YjNKbFZJOE1VY095M2g2UUtLbWRheUpmTkVCSU04Y0VhODBQa05S?=
 =?utf-8?B?R0VzTmRWVjBSSnRybTUwNm5KbnZJd3E5M2E3cHdJRU5jYUtvcEtNQ0lJZHFU?=
 =?utf-8?B?YzhvbC9tQTZIT1JtbVhQV2FFVWF3SzA0ZzlZWHVlcHJMZTNDSzd3SWhWTzlV?=
 =?utf-8?B?b0hOZUJCa3BLQTdnVjZXWitOeC9JZlN1Skl5KzFTeUVrVWNwWlR2ODdZNEdx?=
 =?utf-8?B?NjdIb1duQzZCT2FROVVLOUpUNjY5Nm1GUnBFdVVzMHgrU1FvTDhZRGpWR3dk?=
 =?utf-8?B?SVpWenJIQ1VqcEtsRERYSXgwRW1qNXpRTUdvVmU2MjlKV3h5M25nTklUMlhC?=
 =?utf-8?B?ZEJvOU5Tejlkb0hQNEZGYlVtQ2hkVWJBU3VGYjhJUGs2YzlEVnpXcGtFajcw?=
 =?utf-8?B?Z0hGb3pCVkFWMmVzNDhJeWFselFpbVhZbHBIMGtsWDhyczVYYnBWdHdPZTFX?=
 =?utf-8?B?NHFERVNjRXZyKzFYT1RWSGpHR05ZamRzU1dhMDQrcnJDK3hiQzd4d1hwdHc0?=
 =?utf-8?B?MjVtNUt3OTMxbGpDV2owSDdyNGhPNEg4eWUxM0Y5ODlqRURkTXcveERXbHA3?=
 =?utf-8?B?UThFWGhqK1BmdXVMNGlEcjJGdmlaZ3lwVFdyS1lPSzI3OUozVjJMTC9qdXJ2?=
 =?utf-8?B?VUQxL0F1bmNNT0JYUjlSQXF3VVJkZElKdVZVU3M3UEtqeS8vSWxHVXBMMzMv?=
 =?utf-8?B?bFhpQkRjMi82Q21UQUN5R0wwWXF3Tng4RXRxMDdmdlBIY0JzdEJBTVJmdkpB?=
 =?utf-8?B?VDNOVjlEd1RKdGNERkZJRmRLdDFETVEzblh1TkpJTmJIc1VnNjVMK0M0czQ1?=
 =?utf-8?B?Z3NBamRCR3FTTER3QlFTRHh1bVRTMnhnYkVHVnYzRkJkZEdneTlEWVdJejMy?=
 =?utf-8?B?K3c2VmpoZ09zNGhoOHg0MytNQTlZaVpQQUF5WXl4eFZkODFLUEduOTBSK09C?=
 =?utf-8?B?WmRRcVo4djdNem96bmNGMklIWFRFcFpLYlJ4Y2dFRzhwUjYzeVVpVWRsV1g5?=
 =?utf-8?B?TC9MS1VQVERnaXpTSTEyYTN2RUQxVnNOcnEwVjlzaDZEQnpGL1Y4UjNoVmdN?=
 =?utf-8?B?dTlMUDJ0RUFqWVdhUWdjc3loVWQ3cU5xMExKY3hoQ0ZidXBadmt6QjZ3WEhr?=
 =?utf-8?B?eitwQ2pCNUdObjREZmhTYWZTdGtVUzlsMVN2cFdNQThydTdoT0hzazlvRTZX?=
 =?utf-8?B?V0VhR1FsbEdPSjFvTjlFdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXVMZFVBOXFhRUxGZXVEOFVvdk9EWlJzOFAyT0ZWb2VkV0NGVzcyellYc08r?=
 =?utf-8?B?WThsK0dQVXpSYXAzRDdCS3kvMDdvZlRnc1dva3J5cGVQaFhwUnlRK2ZGRWo0?=
 =?utf-8?B?U1hkQjNzc29HcHNNeStxMk80VUtiTkRVd3ROZ0dZQU5ZalBVSVZ1Y1YvRTI1?=
 =?utf-8?B?VExWV0ZRSUJIcHlLd2VUZUtVWlhXcWRsaGFEdzFSdFZUNXprZ0dwK3dMVDgy?=
 =?utf-8?B?Um9wWUZ5dk8xd2dQakpNbDN4ZVRab2VFUlg0dHJmOFZoMTJYVnlvVUVtYWt6?=
 =?utf-8?B?dHY0NDZjai8rWWJDYlE1ekhyNDJ1cTZnbHdwVGxEQ0N0R2RVK3VtdVlvc1Zs?=
 =?utf-8?B?cWtVRXVIUmxaeTlybDN5bmZXcEJFWEl4OFB3ci8vMGdXYmNUUkxUa3R6MmJn?=
 =?utf-8?B?MVg0aUNpdVdIRlVZcmtrNlltdjcxUklKNmNOWk5DeHcwVitvUGgrOUVSZlln?=
 =?utf-8?B?MmM3Z2dBVGg2VHBlL1duNStkMVRGVmR5QTNoVzN1UURqRlk5QkdOa3c5K1ht?=
 =?utf-8?B?U21jK2xHaGc2T1E1MzV6TjVTUEFudnVaVzhJNFJTRFFpSzdYcFZPMDYxV3Zl?=
 =?utf-8?B?RWtVVW1kdUFNMEJTaXp2RzE2ZGwrNVlEQjMrbk0vL2JZRzZ1RjRub1g0bS9M?=
 =?utf-8?B?NWlMM29aR0FhYitKdWNMTFJqN1BkVHRPOE1DRm9IZE5tUTl0N09yUGN0V1VH?=
 =?utf-8?B?dWM4QUxXZWt1TTEzR2tnQWRhRFBuVEhNUkk3azF4c1RIUUZqSXFpNDFJdkFT?=
 =?utf-8?B?R0Q4dXp3TTJ6RlMxU2tmL05yelpZT2U1RFJjRm92ckphNERnNEFGSitDeWJJ?=
 =?utf-8?B?V2JrNmFmMWwvYklhZWhndGVzNmRDK3FLRnA0cG9KRDlCbXZEVm12Zm5PWC9N?=
 =?utf-8?B?MzZPZC9va0pxT1phU1dxZk13SkRLaU5aY0FKMTNIMTRDeWZwSGVkOFNhY2M5?=
 =?utf-8?B?dHRvalNaWEE4TCsxSnNuQ3NzZUVRemR2TXdJWlNlWG9xSGV0cUk5SWVaRjVp?=
 =?utf-8?B?cXVIRWkzeVhEd01RZ0NocXBPNEpva3JYTkU4STVQb1R0QjloekFkWFhaZERI?=
 =?utf-8?B?cXludGx5aTBnbWZPb3djSGpiRDVyNDFEMTJKVG15V3FuOVNpS25iYWlrVkFJ?=
 =?utf-8?B?RVJ2RXNpVU9zVWhuV0Zod0sxVkM4RGJzOTNTdWVzdXhGOFNyVWRnVEdVamY2?=
 =?utf-8?B?Sm1kMjRpQ0RpTThiVi9IUlZSTEg0WkdXLzZoRkZzYUZESEJoYUtCZkdocUVx?=
 =?utf-8?B?Z3h6SkFpY1p0OXI4V0lHY1d3cEtZMG8yTG8rZ0tpWmM1OGNhODRtZ0VPTXdt?=
 =?utf-8?B?by92cFk2N1FydGo1OGpobFZCM0NDY0I3cVpicTFtbC82U2RySXl4cERnM3lx?=
 =?utf-8?B?ZkN1UHRLV1QzQ1J3VVdpb3VDNGJvQldyZExUU25yWitzTWhwVlBIYTMvMmhT?=
 =?utf-8?B?SEFIUHhMcDk3UmROMmFTM1BxZXpacCtCT0M0Y2lKcElhNFRRc2VyclN4YlNU?=
 =?utf-8?B?c2hJWG0wS0FuM09IYWwrU3lyVUtGaE16NlV1NlJwL2xNMk0xUTlrdGEvK3FC?=
 =?utf-8?B?V1hIVWRCeW5teTZKanE5dUs5bUhUb1A2U0JrMU9aTnpyVW51VVprSzY0Z05V?=
 =?utf-8?B?TkkycFFKWTl4R0txRWxGOTBLRGRBZlYrUnQyYURVQ2dMbHdpZ3dKTExQRDM4?=
 =?utf-8?B?Tk10Ny9ZeGYrWnptZlhqOHRpUkVGZXZvOTlQbWxQVHRTT1ZQOFRSVE51d0R4?=
 =?utf-8?B?ck1tTjhKY01oNUFCYnVIMW9CUHdoV3h5OUlnbFM4OE1kajRpOG9jMjlJbFY2?=
 =?utf-8?B?RlNFbDVwbkdnMUVteS9tajRFS0dYNGo2UDRXN3pmUXY0WlZiSjhKbk04Q0ZS?=
 =?utf-8?B?RHRLdWF2bGFYY0VkN0lMcGNoSUFXMEluTFl6aHdUNFhheC9zT1hIa0lNYmVV?=
 =?utf-8?B?K1J6L1AyOTgvMkd0akpUMG10OFVYVnZEOVBkWXkvOXhVOVdRbmdSOVo1bDFV?=
 =?utf-8?B?Nk1LU0l5ZTdLK3d5WVBxejVvOE1JWjVXZXZuTTdOemRzL2RFc2NSVFBPTUxU?=
 =?utf-8?B?NjNDV1IzMUZiMlljM1hoTGs4ZTNpelBZVXhEZmdBbVJ0WjhuSGdnUnF4Tk44?=
 =?utf-8?Q?d7C6YkmCUOX1MvFOXGxWTtEk1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC5A9EFECD6CC24EB2FDBA4570BF5ABA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645cfe47-22e8-408c-75a8-08dc7b5e8eb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 19:28:43.0863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N8Gnzcfg3cjR8dtva+y7XU18ZdRK8S7YdM+uzxM3oZYrohSD6I9ap8TTJPsHVAjWn9B0cEl6cBcGFZau/K4HZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8469

DQo+PiBhcGFydCBmcm9tIHRoZSBmZXcgbml0cyBwYXRjaCBkb2VzIGxvb2tzIGdvb2QgdG8gbWUu
DQo+Pg0KPj4gUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+
DQo+Pg0KPj4gbm90IGEgYmxvY2tlciB0byBtZXJnZSB0aGlzIHBhdGNoLCBidXQgd2UgbmVlZCBh
IGJsa3Rlc3RzIGZvciB0aGlzIGNvZGUNCj4+IGluIG52bWUNCj4+IGNhdGVnb3J5IC4uLg0KPj4N
Cj4gQXMgcHJlc2VudGVkIGF0IExTRiBieSBEYW5pZWw7IEFMVUEgc3VwcG9ydCAoYW5kLCB3aXRo
IHRoYXQsIG11bHRpcGF0aCANCj4gc3VwcG9ydCkgaXMgb25lIG9mIHRoZSB0b3BpY3MgdG8gYmUg
aW1wbGVtZW50ZWQgZm9yIGJsa3Rlc3RzLg0KPiBBbmQgd2l0aG91dCB0aGF0IHdlIGNhbid0IGhh
dmUgYSBtZWFuaW5nZnVsIFFEIHRlc3QuDQo+DQo+IENoZWVycywNCj4NCj4gSGFubmVzDQoNCg0K
d2UgY2FuIHdhaXQgZm9yIEFMVUEsIGFzIEkgc2FpZCBpdCBpcyBub3QgYSBibG9ja2VyIGJ1dCB0
aGFua3MgcG9pbnRpbmcNCnRoYXQgb3V0IC4uLg0KDQotY2sNCg0KDQo=


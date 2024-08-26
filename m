Return-Path: <linux-kernel+bounces-300711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 147D495E774
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 05:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C8A281579
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 03:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7242EB02;
	Mon, 26 Aug 2024 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Wl04CXRa"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2081.outbound.protection.outlook.com [40.107.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9E31373
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 03:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724644225; cv=fail; b=GA17WKVNmyp3mGxoR1o8YuX9yOfHy4+DajAgUsmhXOQm/U46uzyU5nCpu8UgaInvECfNofcx8W4KEO8yP8SVD/iUdw+WxrAplBwO/KkJOigUfmBX8L87amevHMxpPe5ws2I4iKulHZ40F9l7I5YqsP9qhEmhnCA5FsCgf8zjYT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724644225; c=relaxed/simple;
	bh=+GnHkS+JEi5OdXKj+tZB45jwOVTI9Otv0/42Yb/IiG4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dl8t5gOYjeA61hnFjXGtEYHInDFYa1oNMDPHDTcK3+ZDoZUZKndf3nIj1NJtfgc1EzqweEdVrSBi+qzlD5a6QMGsSc0pQzEkXpcwnuM1ycIMWQg55W0KIdLI69ZHYbrW+lx4R/1MiMFQa9mnTKgwGcX8n6Y+Kwo0Ppb1RdqX4Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Wl04CXRa; arc=fail smtp.client-ip=40.107.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGYfWp3CgJeM7jFfxIFNiOzLeEmqDiG9rSeMrdBn/CBrKRDjEf7x33VPBBEZBt/QlyEKEntAGhnCrsFcrxT4QrRkP4mfYXCulOlBOlfE19XZTEqowSiRQEI72i4eGMmCXnJiHmINz3VeqTtgVMf7a9ww6zEhFBYAjl5toN4HR7HcnimX2hiFekOm8MdVaX4HNkXYmTH/6eeC6PW8wOEOMNqI5YBnsHA6LgbG4mt92JsVTOhh9tGBmixATB2t37n6yyQ9wozPDGB4lRBtscV0R7fTF0zzhQeknoWN9LyuVf8b30YfUiD4fLPWHGLXOdVoPxB6T9wbTl9S9FHAeZ/0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jma4uwROkCkFCn7U7pK7m9iDLUupdqADieqk7ZezW4c=;
 b=j8HRMAAymFNCwwZouLn3zFPsKWieQlfs+vU0VmtuEd67qLpXG2uNb3UDb7qiCdurPnS5NQr5+sZZcgLx4FLGArunZWZiJhckvXKYC6wMDNtkf8FHIF+MNMK26dG4ytjQhG9lmCVkgDbQFDoH/qx5+2zFGPgADz7AFbkxgS+mTwMqyCedFVJWND4yXiv45jqFZYC8Hineq3s5Xq1oXjUSoYF3RgQlY0OUzie0JFX6MyBe95LndHZuSY5eLSi+ws33Nc4n7bJlDLYVWDxe6ESGtOQ8bbQuJZJRoSDazlqOnfu217Zu3ADV40Wk1mYsj8CKj3sAkWVi4rhh/t6W+e7yyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jma4uwROkCkFCn7U7pK7m9iDLUupdqADieqk7ZezW4c=;
 b=Wl04CXRaYRR9sVKGaKWt4OBIscC1vO+YUQe3ui03g8u3+aee9KAFjo7lxt86a2ItsmuwigmjFl2MGniGtevTeX0zzdlke2Q6AIdPTyogidpt1vAcnv2uUwuwqLQ0ZwLzi5ZpXSUItqp+g3j6O5tQL/Q3Ki3W86tpJARuD44+L4k8LDT0+J2gwjHDudH1UpaT77r3mcM0NqGxMTsg18an74mBDJ6UhtLuFR+i072bVcCdIGv5le8JBSaG2psmc5LcMAtZPs/vAnOTZmXI2qZ3IDVwoXI25TToU1OoMGLIbJs6/k2axU3K1LdI9D80YDorOvnySsLOEXprE8fWyD5ZqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB6252.apcprd06.prod.outlook.com (2603:1096:101:c5::14)
 by TYZPR06MB5527.apcprd06.prod.outlook.com (2603:1096:400:28d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 03:50:18 +0000
Received: from SEYPR06MB6252.apcprd06.prod.outlook.com
 ([fe80::d2f1:960e:a2e7:406b]) by SEYPR06MB6252.apcprd06.prod.outlook.com
 ([fe80::d2f1:960e:a2e7:406b%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 03:50:18 +0000
Message-ID: <8a1bb3ed-5d4c-46cc-88a6-c7fb1c1f60c0@vivo.com>
Date: Mon, 26 Aug 2024 11:50:15 +0800
User-Agent: Mozilla Thunderbird
Reply-To: 11162571@vivo.com
Subject: Re: [PATCH v3] drivers:smumgr:fix up the misspellings
To: Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240826034722.1795097-1-11162571@vivo.com>
From: Yang Ruibin <11162571@vivo.com>
In-Reply-To: <20240826034722.1795097-1-11162571@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0036.jpnprd01.prod.outlook.com
 (2603:1096:405:1::24) To SEYPR06MB6252.apcprd06.prod.outlook.com
 (2603:1096:101:c5::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6252:EE_|TYZPR06MB5527:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d194595-46ab-417f-8b69-08dcc58233e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|81742002;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHRuWkVkc2pMbUI5dzl1T1p2ekxwMDdqbncxR3d0TUF6NTVJN2FRK0FtN3Zi?=
 =?utf-8?B?eEdHZWxFMzVqOWhvK0RMNkNEQytkWjIvdjBBM201dzRqcXBSOEhTc0R3ZExE?=
 =?utf-8?B?bzNXZ0lxY3E5ak9ndUtJOGhVNkJsYmJPR2phZzVxNzRWOVh1YlBaWjcxOHMr?=
 =?utf-8?B?THVsenJuTWI1bWJHWUNRZmhIaERVY04xdDlLcklpUlo5NFpiQmhmaUV3bVZ6?=
 =?utf-8?B?SDVPdWJJb0dZai9TbmZmVEt3NWs5ZHllMEc3V2VCNk94TThTdnphYTVoYVYv?=
 =?utf-8?B?bjU2SjZ4OUJlNFo4Y3Axd2x6bklsajhQYWx1OXczOHAxVjVKSHBBbmxPNnNk?=
 =?utf-8?B?VE51dXd3SlZsblVwWEdkMUpuc05JcExtaldOL2YzUVhaN1h4dzg3RTBpdHNL?=
 =?utf-8?B?eldaR0VZT2h2cGZRbnN3ZVFIS01maVdDcTY2Wm13SUMzZ1BPaHM3eGJWK0la?=
 =?utf-8?B?Z0pYRE9MWGJHRXZXVHR5WkJnNStpUzMrUUN1S0RqS1A5OGxRT3hLYm9uZXFu?=
 =?utf-8?B?VG1JZUNIblNqZ0UwcjRRbW0vYnM3UUdVUjVWVk16ZlJ5bDI5a1ZsTjhRZkNK?=
 =?utf-8?B?VVl4OFU1M1RWTTNHcTcxVGx5NzFRUGdXS1dCM1I1NHU3QmFLSURxSThSUVJ6?=
 =?utf-8?B?dXlvaWFONjhESFR4ZUdkbG01QXVIeGxkTTNXZ0haSVJKNzlTWURxSUdvSlJi?=
 =?utf-8?B?ZGZrZzJNU0VkSVlYYkdHNVBBOW9LaVhEUWROb2U1Vkp1WTlrWjI5cWVKWUZO?=
 =?utf-8?B?S2FNZjV3UkJKWk1uYkxtbDVYZ3R1RlgrM01WTlJFMHhLL0F1Z3UvaEhKMEVP?=
 =?utf-8?B?emF0a0k2MlRLUDRLV2NTcWh0MWRmajg3VDBqdE9PQVBXZXNlNElTUFNXT0tG?=
 =?utf-8?B?cEZXRjFmUEhyRUlkRHkyaUV3eUJ2RTQ5MEVGS3JyWUJmVHlWelZPdnQxTnV0?=
 =?utf-8?B?N1Y5cFpJOGlDQVpRR0MxSlYrRmpmTjM4bWhYRDhvdm9XdzJZKzYybVJrQlNi?=
 =?utf-8?B?VW1PWTFHdXB6RUNJNTNrellPeHNxRUxXUVBnQkVHa3FHOERsL1kyb3JlNk9O?=
 =?utf-8?B?MjgyQVpQSHlHU1lYZmtuSndkRXE2a1RpTU82L2szb0M0UFA1bHNsNVZzTE5i?=
 =?utf-8?B?WlBLeTlIWG9SeXZzMWF3enBpYUNtMDJzS1NBLzNVZUlpdVZqbnBFVE9mZWty?=
 =?utf-8?B?ekluMFp1bVdpZ1VBK3V5V0UzdmhnWG9sbXBvRHRFZEF0MGhJcWpjQ2xuQlBJ?=
 =?utf-8?B?MzZseWE1NUJPSWxnZ2V2SDQyNURkakNEV25McHdyRjY1RWltYjU5Rk5HSUtB?=
 =?utf-8?B?a2F6eFJibWN6OWprc1N2b282T05Ua3NhWStRNWVmNll4TFgwcnRWaU9lWE14?=
 =?utf-8?B?Wi9NTmVLcGQ0eGhHUzhrVitpSGh3b05tUDdNR1hFNzNwMFdvQSs0QzhFS3RS?=
 =?utf-8?B?azYwQmExbSswWHF2bHFpNDkvc0lnZFFmcW1EejJacGdxR25yVlIydURaWHNs?=
 =?utf-8?B?VGlJSjNEMWhDMm9XdDFacnlkYU5jamViVVc0MHlvOFZLcFQ4VmxxeFg3SGw0?=
 =?utf-8?B?WTQxL1lybkEzOC91TDhsMkFSK0tSVi9haEFaQzBmcXJjWmVUUndXZFBDSE0z?=
 =?utf-8?B?Y3d6L0orcjhMWjFzVEF1MFdybmxQbHQxbncySnE2Zk40b1N5L0p6NnZCUXh2?=
 =?utf-8?B?ZE9CR0tnVExSZ2N4UVN2ZmxTM2FWRVJBdVFpdFRzRGlaejFPUnVVZjY5Y1VR?=
 =?utf-8?B?SEhnZEJOakJJTk1PZW1TeEVBYS9UandVNiswSzNZby81NXVVdzZ5WHF1QTFN?=
 =?utf-8?B?emhaRGkzM0RYejhTZ09DNkFvWDIvQURXaDdaMlNiMmQrWTdJbENWbmRzNldk?=
 =?utf-8?B?OW5MZHE4cXFzOU05WmpxOUlwbEZzWEpULzdmSnMzNit0d2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE1abUIxMEU1YUxuS0FBTUlRa25BeW8reUw4Q3NGTEU3YkVLVnNIM3lzajla?=
 =?utf-8?B?NzFqQ1l3UE1tUEdKYVhnTlM3RDl4SFBQRFBVK21RNlFDL1FTUEI2a0M2cHRW?=
 =?utf-8?B?S1VZNllha3FPK2ZuL1B4clhVY21GQjB5S0pOYmw1VmJZZHo2cU80MmU2UDgx?=
 =?utf-8?B?SDBHZEdKSkJucWNLZVNUZHNKcmdKYTd5bzdkMUlNc3RMSDNocW93bTNGV0tn?=
 =?utf-8?B?TUxxQ0ZmTFdDWlVnbk5CU2RsU3hQcU5sS1lyNElDbGJEbFJOZTN6TlE4UTNX?=
 =?utf-8?B?K3l5a3hub0ZqeHA0MUZFTUEvTmJqYUVEcHFQQUU3bjYwaFdva3lzS0hHK1h0?=
 =?utf-8?B?RXdhZXhpeXo5Qm1pTFBqY0ExLzZVVHZwNEF1ZFNSNGYvWTU3N3BxejBiVkw3?=
 =?utf-8?B?Nmd1SFJMZ29uZnZ1VFpGNUdGT1IzVjJ1RVZBUlF0K1JOQUZ4ekxMRmZJNndt?=
 =?utf-8?B?UVZUeDZIdW14UHE5VnFnZjJ0RENENmppK2pQcFpDNFIrUXlibzFDK3B6VXV3?=
 =?utf-8?B?ZWtFbWkxRXhRaXBiRVVpdENwMnR0S0pPL2RTTzJhaFJ4UmNJWWlIdXRPNjVQ?=
 =?utf-8?B?dmxxUVRtbWlQTW9MZngvelQramFuYW1KWU5WcWF0UVVQRXl1OERwOVgreWRi?=
 =?utf-8?B?QzV1UUtsa3J1VW9wNnRkVmZiZjl1blcwWVVMZ2JrNnRydnJ1M1NkVWhxeGxT?=
 =?utf-8?B?ZnV5SVZ4NHpRUDh6NkV6a0I3RGxnWlJuNk04cUNsZmVyR0JIWDVLbnVybjBZ?=
 =?utf-8?B?djVUeWt6UXRkSC83clhhcE5IeE8xalNkSmNMeVBCcDE1MlRha0FxQ1lpVWps?=
 =?utf-8?B?S0d5T1NYaUJic216bUE5QWEwcXZheHV3K0Z3Qzg3YXVKR1pGbEI4ZTJmc2ZI?=
 =?utf-8?B?MGlWTE42RmlSR1pzRk00MUVZNVFkQUtwRy9ZZ05oR0VGSlVlTVZZaFRHbnV6?=
 =?utf-8?B?RWJFZy96WjdxTGtKRy9xemtFaHBiV2JtYWRGZ2tJSWpkWkRVVjltbnFtMU9G?=
 =?utf-8?B?bVhqTkd5M2NjWXBzS0lPay9QNWs4blZzd2p1eHhzK1Z2V2tSbEY1TTNjVjNh?=
 =?utf-8?B?ZTdmcFdHeXFFWFJOQ0xTNGlKRklNQXlDQ1dqNUpicjB6ei9XT0ljUEI4Z1NE?=
 =?utf-8?B?d25WNEJUbXcrZm91azRBZ1krRTNsVVZWYkxpbHJJamU1RnBFUUZJNVc3TVRL?=
 =?utf-8?B?WG5tZUhmeHo3ZDFoZmZtWTVYaFdsNHBEbFkwbFZtcnlwSkpQcnEyR0x5Mmho?=
 =?utf-8?B?b2lURXpCbXFPcllnV0NCVDdwRmplYzFCQWMyL1l5dFJoWS9DU21VRVkyWTFa?=
 =?utf-8?B?L0plblgzOWhvTkd4blRDYUtJVWY3Z2RiR1FtT2pXYnVOTXphOEFud3pvQXkw?=
 =?utf-8?B?RENFYnFlZXZlRVB3cW9MUXlUT3phRE1Ga005UXVBVVk5Z2VaTnoyRzRpNzlI?=
 =?utf-8?B?ZGorLzk2L09CMFJ0MzFIeXArN2I5a2RzRGRueWVGWENOWE1FVTZUTjZJaS9r?=
 =?utf-8?B?bExTejIyd1RtbUttVnFjR29TSFRxZTNqZktGTC92aiszWjRncENGK2xmS29Q?=
 =?utf-8?B?aTZqOGQ4Sml4RVlSMEtSMWFjN0ovN0hVSVpaNjhCVkxsTE4xQjQ2L1B6QUFX?=
 =?utf-8?B?Q2xPdmI2TDVRcWF0Vnc4dXlOSFhJdVlZaXRrSXlkN3ZrOWVVZG8yN2gyclNs?=
 =?utf-8?B?ZVR4Zkg3TytqbUFVWUtRcTA0RTZxYmxxQldWUFBGbDFXUDIwNnMvSTZSZExZ?=
 =?utf-8?B?MWo4RWNrUllialJ2Wlh2V2JzeHRKamFuS1NheUsybWR4TVpSZnVUc0pHdXU2?=
 =?utf-8?B?WkdhVWF0OE04QTB0M2NYZDBBMU05Q2ZTM2pxdXpKaXFSN1k0Y1dGb2kraWkv?=
 =?utf-8?B?dVROYUJ0YzFRRkJDcFpJRXNxNzdtNmxXdWlpM2RCUlljMEFBZ1N4Zy95MlB3?=
 =?utf-8?B?ZzM2OEdxVkJGclIxWFpKZS9wVWJ5ZndsZVJIcUgxQjhYYWhKZnFPVk53UXdM?=
 =?utf-8?B?ci9UQzdiVWMzTHczVHBodmluSWNwZmhURXNhU3dwdFdOVXFKU1RHTUxtcVY3?=
 =?utf-8?B?VFV0M1ltTG53WnNMYjZFaGRFNUEwRGsxcmNnVjJQL29ORGszL3BwZis2bEU5?=
 =?utf-8?Q?tntdDSD6hh+gxkbfjan5CB5Af?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d194595-46ab-417f-8b69-08dcc58233e0
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 03:50:18.7833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0XSnpFo6Ku9BMs6Ej1A9ekkh2FMAuQAyqPj1PjIqAZigznzCcwWewDzvcghDZDEVHHRuDzm0XVUwo8aRdPlDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5527

Sorry, please ignore this patch for now.  As the wrong subject line.  
This patch will be updated later.

在 2024/8/26 11:47, Yang Ruibin 写道:
> Hightest is a typo. It should be highest.Please ensure
> the consistency of variable naming.
>
> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> ---
> Changes V4:
> -Adds some information in the subject
> -Updated the ignored misspellings
> ---
>   .../drm/amd/pm/powerplay/smumgr/fiji_smumgr.c    | 16 ++++++++--------
>   .../amd/pm/powerplay/smumgr/polaris10_smumgr.c   | 16 ++++++++--------
>   .../drm/amd/pm/powerplay/smumgr/vegam_smumgr.c   | 16 ++++++++--------
>   3 files changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
> index 5e43ad2b2956..e16efc44df88 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
> @@ -1014,7 +1014,7 @@ static int fiji_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)
>   	struct SMU73_Discrete_GraphicsLevel *levels =
>   			smu_data->smc_state_table.GraphicsLevel;
>   	uint32_t i, max_entry;
> -	uint8_t hightest_pcie_level_enabled = 0,
> +	uint8_t highest_pcie_level_enabled = 0,
>   			lowest_pcie_level_enabled = 0,
>   			mid_pcie_level_enabled = 0,
>   			count = 0;
> @@ -1054,27 +1054,27 @@ static int fiji_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)
>   	} else {
>   		while (data->dpm_level_enable_mask.pcie_dpm_enable_mask &&
>   				((data->dpm_level_enable_mask.pcie_dpm_enable_mask &
> -						(1 << (hightest_pcie_level_enabled + 1))) != 0))
> -			hightest_pcie_level_enabled++;
> +						(1 << (highest_pcie_level_enabled + 1))) != 0))
> +			highest_pcie_level_enabled++;
>   
>   		while (data->dpm_level_enable_mask.pcie_dpm_enable_mask &&
>   				((data->dpm_level_enable_mask.pcie_dpm_enable_mask &
>   						(1 << lowest_pcie_level_enabled)) == 0))
>   			lowest_pcie_level_enabled++;
>   
> -		while ((count < hightest_pcie_level_enabled) &&
> +		while ((count < highest_pcie_level_enabled) &&
>   				((data->dpm_level_enable_mask.pcie_dpm_enable_mask &
>   						(1 << (lowest_pcie_level_enabled + 1 + count))) == 0))
>   			count++;
>   
>   		mid_pcie_level_enabled = (lowest_pcie_level_enabled + 1 + count) <
> -				hightest_pcie_level_enabled ?
> +				highest_pcie_level_enabled ?
>   						(lowest_pcie_level_enabled + 1 + count) :
> -						hightest_pcie_level_enabled;
> +						highest_pcie_level_enabled;
>   
> -		/* set pcieDpmLevel to hightest_pcie_level_enabled */
> +		/* set pcieDpmLevel to highest_pcie_level_enabled */
>   		for (i = 2; i < dpm_table->sclk_table.count; i++)
> -			levels[i].pcieDpmLevel = hightest_pcie_level_enabled;
> +			levels[i].pcieDpmLevel = highest_pcie_level_enabled;
>   
>   		/* set pcieDpmLevel to lowest_pcie_level_enabled */
>   		levels[0].pcieDpmLevel = lowest_pcie_level_enabled;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
> index ff6b563ecbf5..d785cc6468ef 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
> @@ -1050,7 +1050,7 @@ static int polaris10_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)
>   	struct SMU74_Discrete_GraphicsLevel *levels =
>   			smu_data->smc_state_table.GraphicsLevel;
>   	uint32_t i, max_entry;
> -	uint8_t hightest_pcie_level_enabled = 0,
> +	uint8_t highest_pcie_level_enabled = 0,
>   		lowest_pcie_level_enabled = 0,
>   		mid_pcie_level_enabled = 0,
>   		count = 0;
> @@ -1114,27 +1114,27 @@ static int polaris10_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)
>   	} else {
>   		while (hw_data->dpm_level_enable_mask.pcie_dpm_enable_mask &&
>   				((hw_data->dpm_level_enable_mask.pcie_dpm_enable_mask &
> -						(1 << (hightest_pcie_level_enabled + 1))) != 0))
> -			hightest_pcie_level_enabled++;
> +						(1 << (highest_pcie_level_enabled + 1))) != 0))
> +			highest_pcie_level_enabled++;
>   
>   		while (hw_data->dpm_level_enable_mask.pcie_dpm_enable_mask &&
>   				((hw_data->dpm_level_enable_mask.pcie_dpm_enable_mask &
>   						(1 << lowest_pcie_level_enabled)) == 0))
>   			lowest_pcie_level_enabled++;
>   
> -		while ((count < hightest_pcie_level_enabled) &&
> +		while ((count < highest_pcie_level_enabled) &&
>   				((hw_data->dpm_level_enable_mask.pcie_dpm_enable_mask &
>   						(1 << (lowest_pcie_level_enabled + 1 + count))) == 0))
>   			count++;
>   
>   		mid_pcie_level_enabled = (lowest_pcie_level_enabled + 1 + count) <
> -				hightest_pcie_level_enabled ?
> +				highest_pcie_level_enabled ?
>   						(lowest_pcie_level_enabled + 1 + count) :
> -						hightest_pcie_level_enabled;
> +						highest_pcie_level_enabled;
>   
> -		/* set pcieDpmLevel to hightest_pcie_level_enabled */
> +		/* set pcieDpmLevel to highest_pcie_level_enabled */
>   		for (i = 2; i < dpm_table->sclk_table.count; i++)
> -			levels[i].pcieDpmLevel = hightest_pcie_level_enabled;
> +			levels[i].pcieDpmLevel = highest_pcie_level_enabled;
>   
>   		/* set pcieDpmLevel to lowest_pcie_level_enabled */
>   		levels[0].pcieDpmLevel = lowest_pcie_level_enabled;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
> index 34c9f59b889a..3e73f380a591 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
> @@ -878,7 +878,7 @@ static int vegam_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)
>   	struct SMU75_Discrete_GraphicsLevel *levels =
>   			smu_data->smc_state_table.GraphicsLevel;
>   	uint32_t i, max_entry;
> -	uint8_t hightest_pcie_level_enabled = 0,
> +	uint8_t highest_pcie_level_enabled = 0,
>   		lowest_pcie_level_enabled = 0,
>   		mid_pcie_level_enabled = 0,
>   		count = 0;
> @@ -925,27 +925,27 @@ static int vegam_populate_all_graphic_levels(struct pp_hwmgr *hwmgr)
>   	} else {
>   		while (hw_data->dpm_level_enable_mask.pcie_dpm_enable_mask &&
>   				((hw_data->dpm_level_enable_mask.pcie_dpm_enable_mask &
> -						(1 << (hightest_pcie_level_enabled + 1))) != 0))
> -			hightest_pcie_level_enabled++;
> +						(1 << (highest_pcie_level_enabled + 1))) != 0))
> +			highest_pcie_level_enabled++;
>   
>   		while (hw_data->dpm_level_enable_mask.pcie_dpm_enable_mask &&
>   				((hw_data->dpm_level_enable_mask.pcie_dpm_enable_mask &
>   						(1 << lowest_pcie_level_enabled)) == 0))
>   			lowest_pcie_level_enabled++;
>   
> -		while ((count < hightest_pcie_level_enabled) &&
> +		while ((count < highest_pcie_level_enabled) &&
>   				((hw_data->dpm_level_enable_mask.pcie_dpm_enable_mask &
>   						(1 << (lowest_pcie_level_enabled + 1 + count))) == 0))
>   			count++;
>   
>   		mid_pcie_level_enabled = (lowest_pcie_level_enabled + 1 + count) <
> -				hightest_pcie_level_enabled ?
> +				highest_pcie_level_enabled ?
>   						(lowest_pcie_level_enabled + 1 + count) :
> -						hightest_pcie_level_enabled;
> +						highest_pcie_level_enabled;
>   
> -		/* set pcieDpmLevel to hightest_pcie_level_enabled */
> +		/* set pcieDpmLevel to highest_pcie_level_enabled */
>   		for (i = 2; i < dpm_table->sclk_table.count; i++)
> -			levels[i].pcieDpmLevel = hightest_pcie_level_enabled;
> +			levels[i].pcieDpmLevel = highest_pcie_level_enabled;
>   
>   		/* set pcieDpmLevel to lowest_pcie_level_enabled */
>   		levels[0].pcieDpmLevel = lowest_pcie_level_enabled;


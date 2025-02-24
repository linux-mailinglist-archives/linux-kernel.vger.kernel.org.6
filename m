Return-Path: <linux-kernel+bounces-529517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B58CBA4272D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A5116415D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801FB26138D;
	Mon, 24 Feb 2025 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dC3w5uHa"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1CE261375
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412790; cv=fail; b=tpVzgEcyH+EgY7b2R764kcTdoNvLq74U0sSeAsIeCTjh3xLjyz3KEt7N+iELKJZ4C6TnxO1+1YqIT8pxcSU6VbASDVLHy+3/HzVDsyTco2GF2/s1AhlOmqB7MnJgTV4Y+BJHB+xDi+NNDxaSAXFfR+T0LjEi9PHclf7zM1SQ9Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412790; c=relaxed/simple;
	bh=xZc5SR4eKSGMogNYn3wyyen/iEhNaKEz8Vqp8BIg8bQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cpaMZMxcv9yQTRPD4erh0EpH0jUuOjFCbSN4spWo89I7Z8PJnMxmCblm+02LOXivQwpoqVLBCqrlIC1Mfr4jRJB5k/GG+JW49cCxWKa/YgXCzcmsdgPdAtX7815/kWXSM+owtHsmHN2uclBl603QRML2ElOEFIlfnz3xleFCjDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dC3w5uHa; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2TsO82wzINLUT10fd4AKEiXYXBylgGLH2Y5If2u/7EYc/JsbzEnZ9cWXDvXw6N/DcVKj2EtCYFcpW2kIYwqEipqf6umV2BmKzYnmfB7lKqjgbqFSBP0tbWkzy051ZLOdUlW5xyhq1dHg4TObOM0yozOVzTCvUpadqtqo9jeC+wlLiKnXpCFeU4d6CDLBCkA9doN2GkgeWit04hsTZ2KHmQ8ojOwuKI8S8+dAK13KwgJocmMNBWUtK65oksQWN3GtaO19DvhdSOirc1ZEkNu95/VoJCLdMqkCPEksCDEQGXfxdKRASeNYBvfuRQQgTASLNCVSny35NnUNgHFcCXwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZc5SR4eKSGMogNYn3wyyen/iEhNaKEz8Vqp8BIg8bQ=;
 b=rjvC69Ftt/Fh7Vv3m/9UVf3AMkmLdBivoX08I01ATRvrRWRcs3iWXZFx2Plis8l34uaD5D7DWgiNHslfD1WxgAxnb+qHSbJxTCU1I3Jux1KKRl/oPtn7fJVRDz7hvmF/FLt3I0fvewBH5y13/VS93oVU6sLgZnjqxymXJTC7SR4vgvMHY/ejT8Pk7ljab1Pt7Mj2+Gu+uwIbGjvtV9K12AGJ0sE2vK987FJVFVjxZIKPLaITNZySnkTXpLyJ4V0nOJAlwnqDk7Pn+StdDfGpvjJgvNjT3aBHW/cBHxM2dKhMM5K/BY+2TsjMQZmeq8blO4oYYCb4Wxo5bcqz1hx9Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZc5SR4eKSGMogNYn3wyyen/iEhNaKEz8Vqp8BIg8bQ=;
 b=dC3w5uHaIXUm06cHdXR2pQz13I5J4Us4d45BGHYzUZ2JS3TBYnzcRHWQlGZUPiAQG5Xmnan+H9TiiaFlJqXPd8P+QbreZm3UkwQVF4MVmt3OUBdYDWm0MW9WoUfTVk+V+1bg3Zdbiu+OsN7w/ArPxvCCcUjSQsFcXvtiJQzfRi8=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Mon, 24 Feb 2025 15:59:40 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 15:59:40 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 12/35] x86/bugs: Restructure retbleed mitigation
Thread-Topic: [PATCH v3 12/35] x86/bugs: Restructure retbleed mitigation
Thread-Index: AQHbhtMh3Ck15bnYr0WhdCCvTJhtL7NWnDRQ
Date: Mon, 24 Feb 2025 15:59:40 +0000
Message-ID:
 <LV3PR12MB92656DECEFAD6DFA64FBC41F94C02@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-13-david.kaplan@amd.com>
 <20250224154529.GJZ7yUGfQiyQJc_aMl@fat_crate.local>
In-Reply-To: <20250224154529.GJZ7yUGfQiyQJc_aMl@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c1f0cf90-b029-467e-86bb-0a0e77181ec4;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-24T15:58:20Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DS7PR12MB6288:EE_
x-ms-office365-filtering-correlation-id: 5caedf5f-237b-4d04-8de8-08dd54ec3f14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dm12aWhHS2tBNEFtQlpxK0FrZlhJN1VDZVJrSTYrSTZzc3NVMFlrYm4yL1l3?=
 =?utf-8?B?OXRoT2tnOS94eDFscVJKTmpnMzFwMVBqYm9HanZqM0RYUzZNMzZuTHZhaStk?=
 =?utf-8?B?UllQSWdtdlZNMjhZZUtRbFROenNTdGowYXhWa2cwZndaOVRtSUlXK3ptbm5U?=
 =?utf-8?B?a2twWlNxV2VKQ2krYW4yQUJEVVVYcVFRalNjbWdWK0JPSW5JVWJaZlJzZ3J0?=
 =?utf-8?B?VmlSYWJuTTRGcTQvMkJOcUFCMjFJVmFiV3ZBOFl3NUo4R0xUVVR4T1p4bGNm?=
 =?utf-8?B?Ymw0WFpRSWhqa0lQaFBOZlgybEZGNFRzaHFIc2o3Q3RqNGZCQmx6OVFRRDBk?=
 =?utf-8?B?M0NnTWM0NGRWSnBzYS81VmV6anlTVFRabS9hdUJEZW96eWlmVWgyK3NyTE10?=
 =?utf-8?B?ZFB4QTE2SThGN3BQOG9pamQ3SlhoZVBCWjRpUnBkdHBuYS84aXBSZUxSTjQy?=
 =?utf-8?B?R2tjTEFlQjU5eWxicVZYYUFJV0U3YzZ0RkF6T21BeXVqNmQvSkxBKzBTSWpI?=
 =?utf-8?B?TkdQL3FLUWZKalBTRDZVV2x3TitkdG82bC93NnlrK2g2cUJ0VGVOeEdieU5B?=
 =?utf-8?B?MzhMOUxLTkhQd0g2bjdMRnIrODVrbElCa0Q3WWtVd0EvV00rTFNKSFI1eUpM?=
 =?utf-8?B?Y2ZaSy8zTVp1clhNbmdhMDdEbHRIV0ZqQllVWG1LU2Q5UFJOQUVzREthNWlB?=
 =?utf-8?B?T2tWbjlrWVdqNHRqemRLcDRzaVhKcktRMkhYWnlTc2pxRk1uRmlKNnpnaHVK?=
 =?utf-8?B?a0krd2N2MUVTSFNabzh1UnErcThRRTlEcmNRUnlTckczQk9yeWpkZU41V3pZ?=
 =?utf-8?B?cDNGT0lqZmptWGlJTGdva0JsMnkwbXUzQ0h6UnNKZGkvNmlobmxNelJTK25T?=
 =?utf-8?B?RHJLYTAxZFprUWdLejBvNDB5QlFEa0lkS01NNk5LU2VWSll4WEZmYlN1TGw2?=
 =?utf-8?B?Y2svQ0JVd3Y2bEJ1SmZ2bGRqTnp0Q3NxV1NXbVBmQ1FzSGM3TXd6UjhVVU5q?=
 =?utf-8?B?N05yR0o4dElWVjR6emZFVHI0T3Z1UGNnSGFYZ3o5TU5YQXBGRzdXeHZYMFg5?=
 =?utf-8?B?NTRWUWd2aEJVRm1SeTM2TnlLZFQzbDliTHhlVXR2VFlsMVpLNVFwdGxkRm9E?=
 =?utf-8?B?SjB5NEx6V2pkeEQxYjZyVFZpQ05yZVlDSjZQMHgwTFFxcFhTNllqVGJEMVVP?=
 =?utf-8?B?UWcwVkl0WGdjVmVaUnBIakE4U0VFK3JzelRXVzRJb1RpSkI2aHZtNFVjMmpi?=
 =?utf-8?B?Ni93UTBqYXkvSXAreG1FRkFiRHYxZHNhOEJGQXZtUVhYemY1ZW5qZGc4dlZ1?=
 =?utf-8?B?RUhXYzZ0MldtaW92UHMyUWg3RDJ6MG51elhMMk5KTGcyd3VqNzVRbTBDd0V4?=
 =?utf-8?B?anVuLzJlQmxmZHZGMzcvOHpwb1VReG9vMW5GTEs4YlFyc0tsNkZGaXlZQ2Rm?=
 =?utf-8?B?VnpDTUpEVzhVdEFCWlVSTy9HcjF0MGhkK0hVSFdVOFlFTW52RUhmaG8rSGY4?=
 =?utf-8?B?WWNneUVyTXE2bFRJaHNIVUE3bGthNFZWYjNuQ2NHQ2JPMFN1b25mQ21mUCtW?=
 =?utf-8?B?M2NFS3plV2YrK2NrYlA1YzFGalhBdGNKL2VSdndOUnhaNURJNG1FUDh3SHA1?=
 =?utf-8?B?dXNkb1kxV09MVENTb0tqZkJ2YUJLOVhiUFBKUHczTG1qcU9zYUNKVHR1bHRH?=
 =?utf-8?B?MStna0hSYWNYcVVxZkpPWFNtQVNIdVpaa2VJWUphaWxKbEt5NU15KzFtTjJY?=
 =?utf-8?B?c3ByYkl5RHU0eEFvYnhJaDdnelZFNUcxZjVFeGplbTZ0MlJtRVliUlRMK2sy?=
 =?utf-8?B?RDZHcy84b212a3dxdzY3US9sK3paSTZod0VST2xMRlgxdE9wMlErUzREOURw?=
 =?utf-8?B?RWtvNktNbGg2NFp2M3VrZEFQM0lIUm4vV253UUVTTUtwZWI5TWJXMDE5SE9N?=
 =?utf-8?Q?1xngkUMQBZSurFoGJucbloZCOt6qT1sw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWkvem9NZ3Rudko1NlpGeGI5SlFCSlRkak5LNmtqVHVXNGsrQ005dmZKSFZF?=
 =?utf-8?B?VUtmZzNwTlljYkRJRE5zbWw0SGdhMXhndHRhYTdUN1lwSDc0RVFmUWZyQUg5?=
 =?utf-8?B?T0xCOFprMzNxN2lrK1VVQ1pPYS9VUy9JelJjUFhZYmFOZXhidUxzN0hBd2Ev?=
 =?utf-8?B?eE14aWxzSTJ1REk1b0hOZzNicHcyWlJVTG1VUnVMZWZWNUNDV1pzeUJIVm4w?=
 =?utf-8?B?Z1ZmV2dCZHpYZGhhS1BRNmpqVVoyeHZJV1Nkajl3UEd1eEZXdE0yRXBzZEFD?=
 =?utf-8?B?Z1hDbG4vWDN3VkF2bExKYlFYcVMvR1FnMU1OTTZSTnR1U3lmbXRsR1ZvNmN4?=
 =?utf-8?B?R0tqK3VIOHN1bHc2YzlRZGdhREFVRHlKUTJFRG9yVFhZSWVieXlocEFSMzhi?=
 =?utf-8?B?dkp2Sk5aR1hRaG5NQ2FWakVFQnRvdEpPYU5JQkR6bFhwVGNmYXUzSWdzN1U5?=
 =?utf-8?B?LytaRXM4V1E2VHBRWHJjblpCZllsL1pTRGkxd3ZWeEwyaU5VdWJaWXFQSnpq?=
 =?utf-8?B?L0pFQ1dmdFhDZWtSQ3N4RnZiWHFURHpaSGtVZkw5RkZ4WTdLaDBwWW1lYTJs?=
 =?utf-8?B?c0JmR3RqZFd0TGZjdk5tdGdndTVWRFp2eU52bkR4NWpVajBKaW11OEUrVkVQ?=
 =?utf-8?B?MUREQjZycTRXQU1IZERJV3RIRWlCZDNPVkN4R2VoaFVUVEdQMTFxOExDaW5T?=
 =?utf-8?B?MndMT2VGQzlVQllXWmE2ZExuUWFxTGhqRkxEZDl4Z3NZdFE1ek1NYUU3Q3NH?=
 =?utf-8?B?S3FkQjRybFJwc1NIMmdnYU81RVg5VFhJRlNoWC80cHVhZFJabmJMRlpkUHFI?=
 =?utf-8?B?LzhiVFVTL2Y3MzQ4N1BZOGN1Y2ozeEpRNUF1ME9mdEN6cGRxYUlMdjduZlIw?=
 =?utf-8?B?VWxaTWtlOWcrcW1jejNJN3VzUDVuRCs5cmZqajZOcE5zTk9SUTN1Mk4zS0dQ?=
 =?utf-8?B?OStXckwwZmxQT2YvNHlac3BVSWYrUEdoSERYVU1ucFhpcHZiaThVSkRCeGow?=
 =?utf-8?B?TnRHci9YTzlqTHFjQU1PT2RaVm5UbmluK1BHVHllc1FlbzlsWmhlMTRVK3gz?=
 =?utf-8?B?cjNzOHBYcXRRaHh4QldNN0QzcFZ4TldlWk9Xam5GSzZ1d0hqMWRPc0lPaGZD?=
 =?utf-8?B?TEo0NGJrSU9aNzAvZi9SbkswbHh4R3NBZHBra1cwcGZpcG81aFhNbGNSeXM1?=
 =?utf-8?B?UHhBZlloOThieFRKKzRDTUFVOWJxNDd6YmhydnV3aTFpckZCSTd6WXJNa2c4?=
 =?utf-8?B?Z0YyN3VnQ3ZneHBxR3FybkI5UTV5YkEwZmtnc1B4L29jN0EzNEpMbUxwaXJQ?=
 =?utf-8?B?YjFwVDV2bERDRWlaMmlOL1VGVEJHZmpwSXRmbEY4eTJ0U1d4UXVOVmdVcWd2?=
 =?utf-8?B?ZWdGd3F1R3VzbzNSZFhpbUxmcVI4dEFKZHpOOVJjZXJQSXJrQkhTSmNCYXFu?=
 =?utf-8?B?NENRSFIxUUxCWkRxZTRrdmNnLzdTYWVEUmVyQmloL2FvVHdwVFRmKzREMUlZ?=
 =?utf-8?B?dzduTlVuZGZiNUQ2T1VPNTNIQkg1Nk1wN1AvclVoc29rUithbU5VdmxLV3Fm?=
 =?utf-8?B?S3RNTzVhNHJtOE5Gd1VrY2duWXRZcnZVTTRMLzVjNE9HMVBmY2NabGJ5angx?=
 =?utf-8?B?NFduQWRiOVpEdm5kQVBvb0xrZHZXam5HdXNJMmtPZVpiN0NLUTJxQnFmQjc2?=
 =?utf-8?B?dTZGb2R0bmdkcVlzMEIxckdsR3pDczZzV1p1UVNTWURNalVxNjJiVGZmTjFC?=
 =?utf-8?B?ajR5RW0xRmh1RlBHRmkrdU1ZMmpCQlRZM2RrSlhMUE9DYXhhZ2gzY1hGRGYz?=
 =?utf-8?B?c1FVa29BRHZhQ0JJUVo0RlZKVTNlNCt3ZjdGUFVoeWQyWjR2MUFGWnJVcUls?=
 =?utf-8?B?RUk5bHVLZlhRN1JGVStqRWduL3NQK2cvMVVVU3haK0lWOXJGcTBSVk4vM3gx?=
 =?utf-8?B?SVgvRTdjL01Kc29Cd3g0T0p1bEJYVXdoWE9WTDZoYStPdWJ3c1RIOGRHYi9x?=
 =?utf-8?B?cWFVQzBqYmIxZWsvbjI4cnVpOVlwSVl6aWFUeFVaRVAyT01qNjd3N1c2NVdG?=
 =?utf-8?B?U3BrV2ZtaGN0ZXFtbU0wWXZnQXJUbzhNNHNxQjZUQU1kWWJSOEF0SGNjdFli?=
 =?utf-8?Q?OH0E=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5caedf5f-237b-4d04-8de8-08dd54ec3f14
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 15:59:40.3306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nekwbfjDxvihRiQBFtkl8OXhOvNyRoOMvJOdGeKBTmDlTqonUcNxbMwROonuoQ4R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6288

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAyNCwgMjAyNSA5OjQ1IEFN
DQo+IFRvOiBLYXBsYW4sIERhdmlkIDxEYXZpZC5LYXBsYW5AYW1kLmNvbT4NCj4gQ2M6IFRob21h
cyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBp
bmZyYWRlYWQub3JnPjsNCj4gSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQGtlcm5lbC5vcmc+OyBQ
YXdhbiBHdXB0YQ0KPiA8cGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tPjsgSW5nbyBN
b2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBEYXZlDQo+IEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGlu
dXguaW50ZWwuY29tPjsgeDg2QGtlcm5lbC5vcmc7IEggLiBQZXRlciBBbnZpbg0KPiA8aHBhQHp5
dG9yLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MyAxMi8zNV0geDg2L2J1Z3M6IFJlc3RydWN0dXJlIHJldGJsZWVkIG1pdGlnYXRpb24N
Cj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBT
b3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNs
aWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBXZWQsIEphbiAwOCwgMjAy
NSBhdCAwMjoyNDo1MlBNIC0wNjAwLCBEYXZpZCBLYXBsYW4gd3JvdGU6DQo+ID4gK3N0YXRpYyB2
b2lkIF9faW5pdCByZXRibGVlZF91cGRhdGVfbWl0aWdhdGlvbih2b2lkKSB7DQo+ID4gKyAgICAg
aWYgKCFib290X2NwdV9oYXNfYnVnKFg4Nl9CVUdfUkVUQkxFRUQpIHx8IGNwdV9taXRpZ2F0aW9u
c19vZmYoKSkNCj4gPiArICAgICAgICAgICAgIHJldHVybjsNCj4gPg0KPiA+IC0gICAgICAgICAg
ICAgYnJlYWs7DQo+ID4gKyAgICAgaWYgKHJldGJsZWVkX21pdGlnYXRpb24gPT0gUkVUQkxFRURf
TUlUSUdBVElPTl9OT05FKQ0KPiA+ICsgICAgICAgICAgICAgZ290byBvdXQ7DQo+ID4gKyAgICAg
LyoNCj4gPiArICAgICAgKiBMZXQgSUJSUyB0cnVtcCBhbGwgb24gSW50ZWwgd2l0aG91dCBhZmZl
Y3RpbmcgdGhlIGVmZmVjdHMgb2YgdGhlDQo+ID4gKyAgICAgICogcmV0YmxlZWQ9IGNtZGxpbmUg
b3B0aW9uIGV4Y2VwdCBmb3IgY2FsbCBkZXB0aCBiYXNlZCBzdHVmZmluZw0KPiA+ICsgICAgICAq
Lw0KPiA+ICsgICAgIGlmIChib290X2NwdV9kYXRhLng4Nl92ZW5kb3IgPT0gWDg2X1ZFTkRPUl9J
TlRFTCkgew0KPiA+ICsgICAgICAgICAgICAgc3dpdGNoIChzcGVjdHJlX3YyX2VuYWJsZWQpIHsN
Cj4gPiArICAgICAgICAgICAgIGNhc2UgU1BFQ1RSRV9WMl9JQlJTOg0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICByZXRibGVlZF9taXRpZ2F0aW9uID0gUkVUQkxFRURfTUlUSUdBVElPTl9JQlJT
Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICAgICAgIGNh
c2UgU1BFQ1RSRV9WMl9FSUJSUzoNCj4gPiArICAgICAgICAgICAgIGNhc2UgU1BFQ1RSRV9WMl9F
SUJSU19SRVRQT0xJTkU6DQo+ID4gKyAgICAgICAgICAgICBjYXNlIFNQRUNUUkVfVjJfRUlCUlNf
TEZFTkNFOg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICByZXRibGVlZF9taXRpZ2F0aW9uID0g
UkVUQkxFRURfTUlUSUdBVElPTl9FSUJSUzsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgYnJl
YWs7DQo+ID4gKyAgICAgICAgICAgICBkZWZhdWx0Og0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICBpZiAocmV0YmxlZWRfbWl0aWdhdGlvbiAhPSBSRVRCTEVFRF9NSVRJR0FUSU9OX1NUVUZGKQ0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByX2VycihSRVRCTEVFRF9JTlRFTF9N
U0cpOw0KPiA+ICsgICAgICAgICAgICAgfQ0KPiA+ICAgICAgIH0NCj4gPg0KPiA+ICsgICAgIGlm
IChyZXRibGVlZF9taXRpZ2F0aW9uID09IFJFVEJMRUVEX01JVElHQVRJT05fU1RVRkYpIHsNCj4g
PiArICAgICAgICAgICAgIGlmIChzcGVjdHJlX3YyX2VuYWJsZWQgIT0gU1BFQ1RSRV9WMl9SRVRQ
T0xJTkUpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgcHJfZXJyKCJXQVJOSU5HOiByZXRi
bGVlZD1zdHVmZiBkZXBlbmRzIG9uDQo+IHNwZWN0cmVfdjI9cmV0cG9saW5lXG4iKTsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgcmV0YmxlZWRfbWl0aWdhdGlvbiA9IFJFVEJMRUVEX01JVElH
QVRJT05fQVVUTzsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgLyogVHJ5IGFnYWluICovDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgIHJldGJsZWVkX3NlbGVjdF9taXRpZ2F0aW9uKCk7DQo+
DQo+IEVyciwgd2h5Pw0KPg0KPiBzcGVjdHJlX3YyIGFuZCBzcGVjdHJlX3YyX2VuYWJsZWQgY2Fu
bm90IGNoYW5nZSBhbnltb3JlIC0gdGhlIHNlbGVjdCBmdW5jdGlvbg0KPiBoYXMgc2V0IHRoZW0u
IFdoeSB0cnkgYWdhaW4gaGVyZT8NCj4NCj4gVGhpcyBraW5kYSBkZWZlYXRzIHRoZSB3aG9sZSBw
dXJwb3NlIG9mIGhhdmluZyB0aGUgc2VsZWN0IC0+IHVwZGF0ZSAtPiBhcHBseQ0KPiByb3VuZHMu
Li4NCj4NCg0KVGhpcyBjb2RlIGlzIGdvbmUgZnJvbSB0aGUgbGF0ZXN0IHZlcnNpb24sIEkgd2Fz
IGFibGUgdG8gc2ltcGxpZnkgdGhpcyBhbmQgaXQgb25seSBtYXR0ZXJlZCBmb3Igc29tZSBjb3Ju
ZXIgY2FzZXMgcmVsYXRlZCB0byBJbnRlbCByZXRibGVlZC4gIE5vdyB0aGUgdXBkYXRlIGZ1bmN0
aW9uIG5vIGxvbmdlciBoYXMgdG8gcmUtY2FsbCB0aGUgc2VsZWN0IGZ1bmN0aW9uLg0KDQotLURh
dmlkIEthcGxhbg0K


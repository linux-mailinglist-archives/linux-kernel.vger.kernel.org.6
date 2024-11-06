Return-Path: <linux-kernel+bounces-397575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF089BDD8C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 04:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB401C21804
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4291619004E;
	Wed,  6 Nov 2024 03:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X/qYgjVX"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA6864D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 03:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730863243; cv=fail; b=exKpVYy5bSD9UILAyiyraX3wpv5dtcaZx/Xr0kYds+aLoQdaTg3PcBTtV8+hdwx+U5OxElK6+8PE3pFolkErmv5ngpHClrmsYXccBJrMbwtBbB3aTSrr4b6uYvwFaRsVwMmnjVLdFD91U5LNAEdkS0wfiGBp+cYgPD/qgmmtlM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730863243; c=relaxed/simple;
	bh=RQTBzdrpA673iFiBlh72mUJA28q1GbtMJCs988tbg2o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EFNxd34w0DTYbVvSMKmQXNVbMiIh7p6vuYlFeSua9dlel+O5aDjP4zGK1Zt2IC7nho160+R2uqJaFgFefc6poFTYZbATU5FAl+/dWHnaiP7nUHpGNTA/519o2eFGpnsCgNxsD6YD8VnANY66IW4NP4o26Gw09l2xZuTb08zTlJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X/qYgjVX; arc=fail smtp.client-ip=40.107.100.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKrskUhXkkZl9LrI+EXp4JTWtObII7uNhr+DinS6krlIVR9N31muDOd/UlFT2lRmmMkSMXU/aNjDiVdy2gc4/QwLwS4FRBI8epDoJu2Jn7Rckktw7Om91uzTXZVdMQarT9INCRezqBH0P/OwoJLxW7jwt86gu+lH0gCC+VazRlC8RONZCs3IWtL7soTq3sqTyWheCl49s3iK3wfpHpgJpwJKVdBp3gC7uxlPu5JoBkoV5w5h/qbW5hzZzdccbxRb7tx0FP7mKj2crgpP+ssMzGrvAwZBOasWdaE8QoBZm4+2Dm6Je7dMC9fMhfv3Yhv/j97PIZ9ZrPebDzkc5/ySig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQTBzdrpA673iFiBlh72mUJA28q1GbtMJCs988tbg2o=;
 b=phPnSpMr9BM1NF3fDiDU7JKbbYFbM8+1xoqQbmT7UAehu+TWzSCxztW2ol7MJ5eHat9omz/L2uGmQwhHNoLuHSb5ZKrZE9ngLbc1ItGjS9HOAXer6xOrp52s/JJRlQ8W29F+l9TltdH9Rvq56lRSV1Hihpk9WH4GqMoDOjVxN609iau968X/aDQy+ZptxLnZ/2n9KLisajM/oQpSBb9sjgjp0BdZ65Y3AvPdakjMTjCb7niEoLtmmbjvWuJxt9WtM6YzwbzTDGWoHtQNUZLTn23f0Vjif+pM2fXz1+Lj7heSpK7/VrIfuvQyWkGnr8b2jozFIqMJPbGPcWxWl4i6GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQTBzdrpA673iFiBlh72mUJA28q1GbtMJCs988tbg2o=;
 b=X/qYgjVXFaqmXxfE9/i9U8U+fxuJRp1pJwpxpyBMrmMeicvO74h76ilGkG+LWdUw9xAJk3qWGv0XMvmQwS84pDHLjM8q/0ghAvcsvH7KwRsxPXFXNHDWJRbvpLeg3bEmhoJyYhQtP6U4iCt9SoxIhc5FqelmS/i4EY6vSPBhFhA=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 03:20:37 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285%3]) with mapi id 15.20.8114.031; Wed, 6 Nov 2024
 03:20:37 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
CC: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Pelloux-Prayer, Pierre-Eric"
	<Pierre-eric.Pelloux-prayer@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>, "Koenig, Christian"
	<Christian.Koenig@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Bypass resizing bars for PVH dom0
Thread-Topic: [PATCH 2/2] drm/amdgpu: Bypass resizing bars for PVH dom0
Thread-Index: AQHbL0jnzeSblsyF4UKh6ng0gKqwi7KosqCAgAFmCQA=
Date: Wed, 6 Nov 2024 03:20:37 +0000
Message-ID:
 <BL1PR12MB584921467E47ABAA580D95F7E7532@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20241105060531.3503788-1-Jiqian.Chen@amd.com>
 <20241105060531.3503788-3-Jiqian.Chen@amd.com>
 <e6dd8f17-2322-4fd7-bdcd-861e77fcfc8a@gmail.com>
In-Reply-To: <e6dd8f17-2322-4fd7-bdcd-861e77fcfc8a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.20.8114.031)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DS0PR12MB7656:EE_
x-ms-office365-filtering-correlation-id: 88dcf118-74a7-444b-72f9-08dcfe11fbf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YUpUZ0FaRnFIMHVubnhnWnIwMGVQeFVkMTdIcVB1L3hhVithbFhxZlVvWldv?=
 =?utf-8?B?MVd2TFc3SU83Zk1NajJSUko0K05jSHlCYXJOOCtsVExESjJlRnRRVUdHU3hl?=
 =?utf-8?B?c0M0a1pKYzNOeE9SWXcxM2R4RExSZkhYRGJ2ZnZHaU45VURQVWs1ZmJ0eUYw?=
 =?utf-8?B?d3g0eDNVR0c4a096Qmw5MkVSRFZpcmJqNWVtY3BUSG8zWFFDNlhyOVZETHN5?=
 =?utf-8?B?WEpXb2VzSGNaNXBveTFDNGc5eVJOMjlNVDBDZEtpNW5IUFNTOVVFWXVYNlN2?=
 =?utf-8?B?c1BhZjRoVHZzMHhJWWhhWHF5TGs0MTArS1poRkx2c1ozQm5tYklDWHV1cmJX?=
 =?utf-8?B?MVhxaFBaQURYWU1NNFFyaFRVemdlck4yamU5bUlvT0djbFVWanB5aG9rWnFC?=
 =?utf-8?B?emluTE1sK3hIc00wRm9HcFpuQjVZZ3hSY0k3NCtNZ3owdTR3d1lnZGJWWWUx?=
 =?utf-8?B?Vll1VEtJbVpwbVltNUlWRUZFSnRUMDAzSlp1SHQwdUdETzgzeHlMWjdTZzVT?=
 =?utf-8?B?L21jUGpNeXI3ZXdhNitMOTdBd2dLY1psR0FLVXdaQ2c5WERyOTl4SjdoaXd6?=
 =?utf-8?B?Sk45eUJrQzc3VlBLR0lZL0FTZGIxdkNNMk4xcVBqcWl2K3pRUWNxWkFweXVh?=
 =?utf-8?B?NFBQbENrL2l0a1UyV2ZPM0xTUEpoQWxHMEtsa01kTXU0akFpclExZnZSSU10?=
 =?utf-8?B?WEFwUlhMd1JDbkI5K3l5OEtXQS9GWnhZY1lQczZlMW5LMzJ3WU0xWXBHaFkx?=
 =?utf-8?B?VUdUMWZhVDhmOVR4YTdDQ3VpMlJiVWpDSGc5MmNrdmV0eFVzQ2xjckFTTlJD?=
 =?utf-8?B?SmdUSCsxRGRUdGNsV3RoVEcxdnd1d1R5UFFIUDVuYnh3NncwVkttdDBFMGhD?=
 =?utf-8?B?eHhzcnBwS2lSYVB2Zk9YK0I4QnRiMzEwUm1udC9lMmVRV1ZaSlRiMUcwYlc4?=
 =?utf-8?B?blUzN1BwbW82ZGw2ekN5RW96b1JpcE0ya2tKVkQ2Y3pJRHNGM0EyWmh2SGE2?=
 =?utf-8?B?d20yRHEyV1dvZllQdjUzU01qNkFJMENwRnplRjR2TXQyd0o4Smd4VkVrZmpL?=
 =?utf-8?B?ekQ1cXFwRXNjdjE2Z0ticlVyWC9xZXc5dHE2aGdJcjN0K2xGMUNFUGo2UzNp?=
 =?utf-8?B?ZUhSTjZSTjk4VXVPWGE0T013cHExWjJuVFNjYzVKdHZYUzZSQ2swY1AzRGZX?=
 =?utf-8?B?Wm1vczJpUm1WYmp2bmdPL1IxNjdNWW9jQ1RTZWx6UUZsZ28zZUdXd3IxTUJH?=
 =?utf-8?B?UEZBRWs1ZlFUWUVrWmNxZk0xTzdmSm5tUmFLelZjK1BKeDRXVkh4N0pGYStP?=
 =?utf-8?B?d2ZObGtka2Z3RnZzUDdsUk1FaDFYVzRVMDNMbW5BQkh1UEgrUjVmQUgvcUJz?=
 =?utf-8?B?Q1dMNnBRSkw0aWY1NUloVmE5aC9GS0hUa2JLc0I5TkJWczFLbm16RFVDYjlP?=
 =?utf-8?B?YTFwVHlvelV3ZnUwN1hTU3MzOUdjT0dPUnNGTm43MTlwTnZ2UDdhOWNZWDBi?=
 =?utf-8?B?SXpOQVd0RGYvcXhQalloQXpxNFEwQzllU3J1c2Nhazg2SmVKZzlBSzFYc3U0?=
 =?utf-8?B?VHZaNUhoZ3ZzS3lkMHI2cUUrV25FVW9HYXk5L2tVamRJVUhsemlpbjRBbjF6?=
 =?utf-8?B?THRtMU9Td3dxYmE1cWFibjJFSDg5a1gvZWtwK0ljVk9zcmJRRzlVMU5kSXZ3?=
 =?utf-8?B?WGwzN0RnSkhFVUlER3R3ZkpKbXJIcHp2T2dvbVpmeFA3Q0FQSnVuNUVUTUg3?=
 =?utf-8?B?SE93eTlvOHpzL1pVRnBqMlR1TTdYZEFNR3M2ZnZmZkRpZVQxcDI4RlpHOGpt?=
 =?utf-8?Q?MBs1lCVb9eGIeaMcJ5omQQ2ZKnnSawgDdv2WI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDF3OUU1cjFyZDJKclN0SzhiOGUxd2VTdWZNelVBeGthZlo1dzFLQ09nOUoz?=
 =?utf-8?B?L1Y5MndTUjhaaC9HN1hjd2xVRVZwbDlIWjBULzlVemVsMTgxbjZnQnNnM1I5?=
 =?utf-8?B?NEdNKzRTdzNoeEFNSlhvOHNXVDNBWStTUndnYklxSFZLREtEQlRvSVBrcnBO?=
 =?utf-8?B?VTNhWDJQaG1lVGE2T3dHZ2dhOHQrTlVGanVKVUt6ZFl4VVN4QUZvcTUyN1VN?=
 =?utf-8?B?bENXR3l1eFF4Nldwd2Ryb1pRMSt4TkJ6SGxJQm1NaDlkNGV5Tnc1SjNZa1ZQ?=
 =?utf-8?B?RDE5TVUwWThVekU1dDRGTUY4YVV4M1l6NDltWi92UmEwUEIzY01zdzF6MHVH?=
 =?utf-8?B?RjhVTVhrdGFxTE5JdkZraGpZdGwrbEMwMWsraUFjM05xQ2lDa2FTWWJkNjB2?=
 =?utf-8?B?VFMyM1MvOUt4cUt1a1BDNk1ocFJoRUVHSUp1ZkZXOEoxd2k4VDUycUovTDlk?=
 =?utf-8?B?UXgrQWdvSVpCVWdERWkzandmb01KTkhkZ1R0Z0I2U2hDYjlEUCtFcTljSXVv?=
 =?utf-8?B?V21lb29ockZnWEllMEhVK0t4SXg3ZGFhMW5JaUl4b2JPL3d3dDYxazZUK0VT?=
 =?utf-8?B?NDVwdXdmZmR6L21hS1RBTnRVenQyVms0a3lKbE50eGJRVzB0cS9yY0hreXlK?=
 =?utf-8?B?M2tlSUhsbHFnZy9xSFllNndScHBvVXpSZEtNVlpQdTNRM0p0T1pQbVlGRExt?=
 =?utf-8?B?UUM0TXh0OTR5b0RrenJ2d1ovNU1iMUxuSEdRN2pKWVVXcHh6ZURTNXBINFJV?=
 =?utf-8?B?TUd1QlVuYzcxbU85R2g5YzFOTUh5dVBQZnlJaytnQVMyWlJaOHVzeTJlbUQy?=
 =?utf-8?B?dWsvTzRreElWV2hJNDBhbUtoZ2l6VzdqbHRnVWVvbnV0UkE2OWFXRXR2THNI?=
 =?utf-8?B?SzQ5eGZNTXRuL0FoYVU3aUhVbUpIYkY1WWFVMlRPNUlKMWFLaUI5NUFvbUpT?=
 =?utf-8?B?d1l2WE9EL3h5blEwMXMyNWEzZEVaakZMTHhjSUFwdTI0VlZzYytJbXdiTkZW?=
 =?utf-8?B?aW4rYUNLSWVxcnZla3l3R1ZwYjJtZWdJODlpa3M1SnZTSDBnWVJUZmh1N0pQ?=
 =?utf-8?B?VjI1QWRiZ2dXWnp6TUkxOXJFZDQ1SFpzcDR1VlRjZ2FsZUZhTVExZjNMbWRs?=
 =?utf-8?B?Z2VDam5iNnNzVEl6a0kxY1EwSEVkMzRiUk11L05rZjZxRlhXT0QzNnEveUs0?=
 =?utf-8?B?dEFrWkxvcUxHYmpQWXRUd09SMEdKV21yMkc5Q1lTV21QUjVtTW50QmdqaW1s?=
 =?utf-8?B?OC9DdVMybXA2dFVaUTRDeEJqUXN5UTZjVU1tdmE2NjhHYU1MSXN6cVNDL09N?=
 =?utf-8?B?WWFJeTBkQy9FU1ErbzM3a2QxOVdXR1NrdW8vOVpBbCtvNEVRMWVzVjNQUW1l?=
 =?utf-8?B?MExQclFvVFhYYTRqVGxreDlEUE92bTdIWDg3VGpBbjA4TEk3aGUwaTgrdHEw?=
 =?utf-8?B?cnA2QUpDMHZEbHNRWFJCcXQyQ0w4bmRCaGxkTktPOXNyREtPMkR5STBsZGNu?=
 =?utf-8?B?MkxZVHVjVTg3ZW1kdkYwZ0hTSytaS2x3WHJkOWxBczFjNnlMRFBDQVRIa1Fk?=
 =?utf-8?B?NjdHT2xSVGJzd2VMTWUxWlZTa3RqVUtDMzNLT01TcXd4OEx0VE1vdUhITWtz?=
 =?utf-8?B?YkdncmIwTjdhRDNCVVVULytoS2NXV0h3cUZwQ3NTbWZyL2lvV1JNV2lLT0xl?=
 =?utf-8?B?SmlEelhuZlpCd1pnQlpFNmVJQkVMUmpSMUNrR0RkYjBvZGt1UEtMcnJvRU5D?=
 =?utf-8?B?QzdHS1pneVU0Wk9sRDA4TnVuT2hXdndjVkptNUE5TkRGWW51U2N5QnlJV0dm?=
 =?utf-8?B?d25NNmVvZmowWlVEMHNDRkhQeGg3dVJ1Yk1aTXYwRCtaZGkrR0lkRGxHWWdB?=
 =?utf-8?B?dDkxVlg2WEdEWjVYQWRNRndGYmdHaHUwRC83RXoyV2VhdERlb3Y0VmEveWVH?=
 =?utf-8?B?b0RkVjFOWThwMXRYNkx0QTVZQUM0dXMwRHF1dVlEdHNPNEVsS2x0OGNtU2cw?=
 =?utf-8?B?MWVTVmxCRTVyRWM2d1NPNjRNWGh4elU0dm9KVXFmamlTYTNtU0dNWjkvTFRQ?=
 =?utf-8?B?d1Z4K3N5eTNCd3ppM1dMYW1EZmVTSlQvR0pkeERJUXM4V1JONTR1c0pDMGhE?=
 =?utf-8?Q?l8GA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28CDE974FD5CCE498F4D81D53485B2C8@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88dcf118-74a7-444b-72f9-08dcfe11fbf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 03:20:37.4535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3l9lnwp0X20fN/jYzm+dmKOCHLqB497ZyCg/kn28NLfYS+yqGNPp6k03+8kwZkBmdzgzoM6eybt33WUgCUL4NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656

T24gMjAyNC8xMS81IDIxOjQyLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOg0KPiBBbSAwNS4xMS4y
NCB1bSAwNzowNSBzY2hyaWViIEppcWlhbiBDaGVuOg0KPj4gVlBDSSBvZiBYZW4gZG9lc24ndCBz
dXBwb3J0IHJlc2l6YWJsZSBiYXIuIFdoZW4gZGlzY3JldGUgR1BVIGlzIHVzZWQgb24NCj4+IFBW
SCBkb20wIHdoaWNoIHVzaW5nIHRoZSBWUENJLCBhbWRncHUgZmFpbHMgdG8gcHJvYmUsIHNvIHdl
IG5lZWQgdG8NCj4+IGRpc2FibGUgdGhpcyBjYXBhYmlsaXR5IGZvciBQVkggZG9tMC4NCj4gDQo+
IFdoYXQgZG8geW91IG1lYW4gVlBDSSBkb2Vzbid0IHN1cHBvcnQgcmVzaXplYWJsZSBCQVI/DQpW
UENJIGlzIGEgdmlydHVhbCBwY2kgb2YgWGVuIGh5cGVydmlzb3IgdXNlZCBmb3IgUFZIIGRvbTAs
IGl0IGlzIHdvcmtlZCB0byBlbXVsYXRlIGFuZCBwcm9jZXNzIHBjaSBkZXZpY2VzIGNvbmZpZ3Vy
YXRpb24gc3BhY2UgYWNjZXNzLCBhbGwgdGhhdCBhY2Nlc3Mgd2lsbCB0cmFwIGludG8gWGVuIGFu
ZCBoYW5kbGVkIGJ5IFZQQ0kuDQpCdXQgdGhlIFJlc2l6YWJsZSBCYXJzIGNhcGFiaWxpdHkgaXMg
bm90IGVtdWxhdGVkIG5vdy4NCg0KPiANCj4gVGhpcyBpcyBtYW5kYXRvcnkgdG8gYmUgc3VwcG9y
dGVkIG9yIG90aGVyd2lzZSBnZW5lcmFsIFBDSSByZXNvdXJjZSBhc3NpZ25tZW50IHdvbid0IHdv
cmsgZWl0aGVyLg0KPiANCj4gSW4gb3RoZXIgd29yZHMgeW91IGNhbid0IGhvdHBsdWcgc29tZXRo
aW5nIGlmIHRoYXQgaGVyZSBkb2Vzbid0IHdvcmsgZWl0aGVyLg0KWWVzLCBvbmNlIEkgYWRkZWQg
ZEdQVSB0byBYZW4gUFZIIGRvbTAsIGl0IGRpZG4ndCB3b3JrIHVubGVzcyBJIGFkZGVkIHRoaXMg
cGF0Y2ggdG8gcmV0dXJuIHN1Y2Nlc3MgZm9yIFJlYmFyLg0KDQo+IA0KPiBSZWdhcmRzLA0KPiBD
aHJpc3RpYW4uDQo+IA0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEppcWlhbiBDaGVuIDxKaXFpYW4u
Q2hlbkBhbWQuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IEh1YW5nIFJ1aSA8UmF5Lkh1YW5nQGFtZC5j
b20+DQo+PiAtLS0NCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYyB8IDQgKysrKw0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNl
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+IGluZGV4
IGIzZmI5MmJiZDllMi4uMDEyZmViMzc5MGRkIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+IEBAIC0xNjE5LDYgKzE2MTksMTAgQEAgaW50
IGFtZGdwdV9kZXZpY2VfcmVzaXplX2ZiX2JhcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikN
Cj4+IMKgwqDCoMKgwqAgaWYgKCFJU19FTkFCTEVEKENPTkZJR19QSFlTX0FERFJfVF82NEJJVCkp
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+PiDCoCArwqDCoMKgIC8qIEJ5cGFz
cyBmb3IgUFZIIGRvbTAgd2hpY2ggZG9lc24ndCBzdXBwb3J0IHJlc2l6YWJsZSBiYXIgKi8NCj4+
ICvCoMKgwqAgaWYgKHhlbl9pbml0aWFsX2RvbWFpbigpICYmIHhlbl9wdmhfZG9tYWluKCkpDQo+
PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+PiArDQo+PiDCoMKgwqDCoMKgIC8qIEJ5cGFz
cyBmb3IgVkYgKi8NCj4+IMKgwqDCoMKgwqAgaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkNCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4gDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0K
SmlxaWFuIENoZW4uDQo=


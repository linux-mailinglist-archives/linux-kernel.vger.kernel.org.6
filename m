Return-Path: <linux-kernel+bounces-573058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A4CA6D254
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DD037A2C21
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837651B4231;
	Sun, 23 Mar 2025 22:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="brH4wqub"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9306F3D561;
	Sun, 23 Mar 2025 22:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742770664; cv=fail; b=asTOeQvYZTn1yjWdb/DaZ32WhSokT1bQIPWu6CDRvdpaTf4LYhKF9h5SagP0puo1spOyg3SL/JbwrLyxp/0XAT5KpQ/ofOu7H3FIyLLy8M5EAj5ORAaTArGn7zd+Z9e250Sxx1LSfk3Kohs+Yq70RNeD/Ck2lcVbgbzZT7q0ncQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742770664; c=relaxed/simple;
	bh=nJvw99DPMLyhaWolqWJE5h+FKAYIhb+8ECUmmvqqkgs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iYrQfiOBBgYBL3xByV7rv+b5zhF+HfxC+6WAdy/XGHO5XVmy0XloEnKyAwcUOKhf6/nkeVlr5He4+EmVT5N+4epUrabinvuGyw6kZtNjwm8Fy56CzpgfV1nwT55sCeICfPTdrVTeLrV82RMW9QHfoJml2ae0ZAAany9VW0W8Dow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=brH4wqub; arc=fail smtp.client-ip=40.107.101.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikFiGcXKsutze/cIt9ZyORSRZPvPBDIlnN70zmh+UkdZRbMNfjXEJ5124PwUJJ7oYurVQkWU/us1jvEUkb+I++xfHjXcHPoZK+mto2OKnz/Tl4ztRnQC7w9ymYLM4i8uh0Ys+BIXIR+r48ayJLLdzCW0S8lnd7dwXsnZiy4rYc5XvXieQGEzr0fbJc2qf+QpfXxSg2BDK2WuA82BQTxMccvjkU6pajyYlNZDMkUa1vqczYEGBmbSG0JTq5JFxKr8Zs1ZERoV7Mxjs7akUg4mXhksKI4Z/2sX03EElkqY1lDbe43fTv+aDBPxtJ4XIqecEwT6OouO0uPSQXK9m9fHuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJvw99DPMLyhaWolqWJE5h+FKAYIhb+8ECUmmvqqkgs=;
 b=D1svfOlyI9rGTjhnlLiDPC6wqLkLd6kW2pZ88AMcRFdrBfI8X9oAKvJkpqOdPFZzzOBmiJLBVR0sVT7nYlpPN1mxPbTre8g0l4jDGOqt6dhye+PJBITRa9ioDR9uEYGxz+Blj8KVFy0Ccx17zT1qn7GIMdcpY2V5xjUiYtJoVY0OYyFtl8Foe24hKJh3D1lfYxzGsTV61ukYcivNh/yKKRCNFYrpyz/I3Wq+lANLM7sqHlO4iw3etY+gWYZq8jtoAaQF5JzU5paAvrQT1K6CprgcvhkDyow4hkvweZrvYzsUuxAfyQCx/djtyhVrRmBKUc50XCIZp+Y1bX6IQ5IWsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJvw99DPMLyhaWolqWJE5h+FKAYIhb+8ECUmmvqqkgs=;
 b=brH4wqubsoISGgyCFw7XXYT0MmisqbKX1JhWKiTeJrYp1pWG48x9cHRIbH5lNr5srBJnaPNEohIuB3ocO6QhUZXsDVwbZHrBNAIo4mdskuhsmmtmC+rRNtxhHOqH4Db3U9M6wePenYay/5UrSs9MWzZMk+/xssJswXRzkfnDTi5RCGane3sEQ9jYRDZx7hKQcAyyFXGTyllup7silnHdK6pI9uxDNX8G9iz+haX9sxbv5xIJarXe79axsBIGJg6ds1VxqWRQi/L2XowuOuR1O2C9FiWWn04CXXZwGGbSHncfaU1Qc/O1bwnaprlh8X0Mp1iI9VJaJIsyq5gzWOzQtw==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA1PR12MB8191.namprd12.prod.outlook.com (2603:10b6:208:3f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Sun, 23 Mar
 2025 22:57:39 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.040; Sun, 23 Mar 2025
 22:57:39 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Frederic Weisbecker <frederic@kernel.org>
CC: "Paul E. McKenney" <paulmck@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Neeraj
 Upadhyay <neeraj.upadhyay@amd.com>, Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/2] rcu: Comment on the extraneous delta test on
 rcu_seq_done_exact()
Thread-Topic: [PATCH 1/2] rcu: Comment on the extraneous delta test on
 rcu_seq_done_exact()
Thread-Index:
 AQHbmA2PfoS7IZWyfEqV4ThgpclOkrN5OYoAgAGjWICAATgYgIACWN4AgACLYQCAAEHXgIAABaiAgAIOfQCAAA6IAA==
Date: Sun, 23 Mar 2025 22:57:39 +0000
Message-ID: <EF52A95D-C68B-4CB7-ADF3-5278FA79DCA5@nvidia.com>
References: <Z-CFnKELSqFotela@pavilion.home>
In-Reply-To: <Z-CFnKELSqFotela@pavilion.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|IA1PR12MB8191:EE_
x-ms-office365-filtering-correlation-id: d8f0f717-874f-44de-0c87-08dd6a5e1ca9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d2dRN3F5ckRaVWVydVJTUEdnTmxVRmcxVWxBdmY4WEZmaUZvQUwyUStxWWZO?=
 =?utf-8?B?ZXgvWWdGTG9pSmNTVVV4VnZrYkY0WVZQR1U1WVBtTkJCU3AxRUVwdmNxOVAx?=
 =?utf-8?B?ek1WaUZHV0Ftb1dTWGFWZ21VTldGT3BmdDVUcVBKT0NuU2FXVDVudlNlMzNx?=
 =?utf-8?B?Rk5WcktQRlRHV200MnJibCtWd01HeTRvSjdyL1lFcVArdUNHUkk1RmRLMnJo?=
 =?utf-8?B?VFpZTitpd3dDSWVKNjlwQmYzdkYwWHhlNjc1ZDFBbkE2UzJCRWlLT2g4M05w?=
 =?utf-8?B?RFVJUGwwMmN0QVRNR0RtekJ5NENJVHR1K3BoVjNKNDRrL3R5WmZjSS9LVlE3?=
 =?utf-8?B?TnRQUk5MQU51QUV3VWljMVFrWERKOEh0THVpdXQvemtiSmxEWGdUVmFjTXU4?=
 =?utf-8?B?aFlZekhTTTNSQnJ6aVV0ZlZsbldTMTZ0b2tab0I0bFJCV2tlS1pHM2VNb2tP?=
 =?utf-8?B?K2hqL1h3WDNhWWh6dER6cG55dll0VWxIbXhFNDdpbGRKMFZzK0NOTWd4dWFD?=
 =?utf-8?B?S1ZUM2NMRlRnTm8xZ2Evc1hiczMwMXhpQTF3ZE04Z2YwM0JzSG1ocVNoUTg2?=
 =?utf-8?B?dUtpL2NnSFFKMkxaMkNzMC9PZ3NSNHEvWWZZdm5tTERIVEluK0V5YWVqa0pz?=
 =?utf-8?B?R1VmOG1lSnV3Z3pxT0NIa0JNM2NOYXhQbWowNkhGTGJEbDZHclVlQ2lnVGc0?=
 =?utf-8?B?OUZoelRCcERlOGswVGJCU1hHc1R0Y0xlL05kcURYYTVxdmdOc09DYkc3YnE3?=
 =?utf-8?B?eGVxZHZVU3hIMEduZkNjV0Z5eHBLbGdTOUsxdjJPL0Q5M3BudVViL3Mwb2h4?=
 =?utf-8?B?R2FXY3F6cWFuUUNmVXpWY3gxWm8wbnZHcFV5VkhCRUw0UFlDbk50NTNrM1VO?=
 =?utf-8?B?VTBuYUtmYWJHWmFUWHRHbU9UR2lxRzJYQUJ1SFNsMnhINDE5NlJjYXlIbWZo?=
 =?utf-8?B?aFBlcHZaNmlGbUZzRytpbGtySzhndnhDTFhYOG4yRTJLQmM5d0t6RUl1T0li?=
 =?utf-8?B?SERIMUphVy90R2oxaGJOQVFjS3dmRlFmSko3bWlpalpDY2NiWTl4eVRJQ1lF?=
 =?utf-8?B?OHB6OG82SUh6M1kxR1hGUDlsRjZPVm9yZFdYdUd5UCt1QXVwdzhXckxmYi94?=
 =?utf-8?B?TkIzOVVadHhRY3lVYndEalluTnVBUFRkNlRuUHBoZUgzTjJub2lOdkJHVHM0?=
 =?utf-8?B?SkVsTERrcm5qUTMyS0hzcFpaSmkrRFhuWktPZlZBS2JYbmQ0cTQ3M2FIckRO?=
 =?utf-8?B?d2pteHZWUklKM1NKUEt0c2wrK0NjZU9YRGlCejQ3TUtnL3JNRFVzR1ZLSkFs?=
 =?utf-8?B?U0JaWkZSMmY3UWhEalE3UGdLOVQvRjBwM0lOVnora3NUTlFNMUZvUnA0QU5U?=
 =?utf-8?B?MEVtUlJnOXlwV3VHQzB2OHV6U2d6YW9GKzQ3cTlOaUgzWW9oMW9RTUlLY3p2?=
 =?utf-8?B?Y2NrTnRmRytXVVRpSjhQRkNyNnBOQ0x3cXdVT0NuMy9EWjRUYzhveW9NeFhl?=
 =?utf-8?B?cVYxb3h4NnMxeHRFdWhpSGpkNTQ2ZlhLbnVObDZ1WnFsUzhqRUVzOUhaNGtY?=
 =?utf-8?B?dzVDRFRwMVhRUUw1WUUvdW9OYTU2ZTliNXVLVXhOalVpb1dvaXIvMzZYbzdY?=
 =?utf-8?B?OHE3VjBSUHhtUmc3WS83aXJrejFEY24rSWNCVktTOXVZVW0raUROTmtFRlZp?=
 =?utf-8?B?bUk1NDN2SlJyck9qaTBPRkpiVGV5SWVCbHpEb3F4cCt2blh3UHFiMFA2UVcx?=
 =?utf-8?B?ZndvVGNaMno5MFByMFpacGpKNExISTdybzRXZnR1dFhod0Z5bGtoaHlDMDBH?=
 =?utf-8?B?RTBJWmtSNFpTaE1vOERtaWhXemRwYk9uWVNSSmxXUnYvQXZkM3hjRURRbFFR?=
 =?utf-8?B?ZEM0WW5NSitjUDNXMlh3Qm5mUXJqY0pmZXQrdGgySVB0dUF6eE5DbkZvTWFQ?=
 =?utf-8?Q?581EY3K4knMpv+xbDoB1acfymzdduIrr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHRNRFhDNCsxcHlKWktUWUk4a3QxK3c0WS9wa0pkZG1CWi9VRjltNnJNK29L?=
 =?utf-8?B?dkpjbk9ORm5hczMvcDBETldrODVFemtaVW5tL2FQMk1YTmgrYVNiRVZrcWc0?=
 =?utf-8?B?MFJRUkRNSzIraVpwUEFoU3hFa3NmbTdJcjNYbUV4ZmdCUUQ2dFFHbmVEczUv?=
 =?utf-8?B?SWs5S3hVVklxQW11WDdxOHdvM1E0R1ROU3pyaUpoNHBGRE9QSkxtT0RmV25x?=
 =?utf-8?B?UGJlSnNlaEdhUzdMVktlVjVrZVpkL2dadDd4OWNpZGt0L2dMaHl0S2JuRFlS?=
 =?utf-8?B?UkR5bzdJSUlHMzRMNm1oQis0bFRBWWpJeG1WbTNFTEJnS0l1MWNBL01TM2VY?=
 =?utf-8?B?UmZWbytCOEVMaStqSXR2NGRCSEpLTkRYU1cyTUxVTnp5dEFVZ2FrZm9yQUxE?=
 =?utf-8?B?R0gwTFNxNisvU3NDakdmZThXWVhIenRQc2liUzcwRFI1WldDV1l4alVhY1k2?=
 =?utf-8?B?c2RSZDhTUG01RkFTenBPb1VFMnZkeXRoMXhpZ1p3bFlmaEdsUzE0Um52S0Zp?=
 =?utf-8?B?eHNzSWNPVk01b0pDejYvZDQ5dGt6S0lyZmFRczVwNGtwL0hmeE5DTWFEbjZY?=
 =?utf-8?B?ZVlDLzU0ck5VT0o0ZzZKdU1NeWxNQjVYM2dCYkNqanE0NGJ4OWZMQ1R3bGVa?=
 =?utf-8?B?VXhKaWw3MS9wcHo1WFNXZ09sU2FHTXF0Nkl3a0I2cnByazNLYmE5SG95Rld0?=
 =?utf-8?B?L2ZPQmUySDdnTDBOYlFwclFndnowbmdPbkcrMkZLeUxUaDF3MGdtQjI4MTFZ?=
 =?utf-8?B?UFlUcGJBY2tya2ZiY3B2WmdDY1QvSzdPaVhlYVpSdG9JR01TRXRZNFVIMUxN?=
 =?utf-8?B?Z3A1c05hL1VqNU05VnRDT2JJU3EvdHdwaE5ydktTMEZBblppZEdlemsvTCtP?=
 =?utf-8?B?dkYrVEprOS9iejg3d25zY0pkMDFXWlo2d0MzUG5ONVhMYTM3T2lneTd0T0JC?=
 =?utf-8?B?dWFmZFVIb2YzOTFBVTJieVYrS0VTc0xQbjVGOUozMFd5NzVqQUpMT0hBZ0wr?=
 =?utf-8?B?aEw4RnVLdFoyaDZubmNObkZnREpEN0l3K3JuZlZZS3NJVU1ZU1QyQU1YWE1Q?=
 =?utf-8?B?RytVRllwM3hKNWFJSTg5eHNTaVd6U21OblFoZFJDM2tmNWhreWJNTld5MTJn?=
 =?utf-8?B?Y0tpVGo0S3UzZElnWlBZSVlJVEk4VnhrVDAyWFBnUVNRZTNaam1oRFp4MzFx?=
 =?utf-8?B?K1VEd1BYV2VhS0RMMWNRYjJHbDhWWGc0U1hWYkxJVGJ1Ykt4STVwbmo3TUk2?=
 =?utf-8?B?RUFqaEFkVVNGK2EyeWwvUnlVVFc1R2x5aGN2NFhhb0kxeTIybWtDaVlVVExU?=
 =?utf-8?B?emhUYXY2Uk1vNWN0SUsxWVdmeUFHK2UxRTY3L0Y3TVlHY0ZtMEVtejd6TnJy?=
 =?utf-8?B?UGN1cWptdStZZVdVcE5kdGhmVEVzRmpJaEtNSENyTWdZcXArWlJmenhVYkND?=
 =?utf-8?B?ZUdHV05oczBGYlQ0WHhhbUF4QXMvL1Q3dW1PcGZOcEhhSjRjdnVTc01DUUlN?=
 =?utf-8?B?OCt5azBhaTV1YkdDTXFNdFNpTnEycTRUVTZ2Z1I0UlpWTFZRNVR3QUZ0b1dJ?=
 =?utf-8?B?cndqWDhINStiaTlWOWc3NEpXRVhnMERWMTFjYlNGRTlSaU5CNk5tZVovVkxX?=
 =?utf-8?B?T1lwajlhdmI2MlZuQkNpMUx2SFo5NG1EQ0FoV3l5VS9FQW9lQ0pweVZ0dGMy?=
 =?utf-8?B?NDdRam0vTmxDMTRtVS9rRWp1Z2lpeXc2UnhHemxaVkJSVm5NZTIyVEY2TDlH?=
 =?utf-8?B?UDhaMnJJRURBMkZvTUZUNGpoT0JrVFlOMlpveURHSjhMSXZ6MGc1L2NDSnV1?=
 =?utf-8?B?VEtnanpoWnNTMnBwWGlEM1dCN0grZGNra1FKTEdkdVdVMnViQ29iSDQ3Ty93?=
 =?utf-8?B?dkRvTTE1TDVEVXRnU0wxTW96dW5NKzZIWS8ydUNkTklsZFhvVkl1b1dFbHVL?=
 =?utf-8?B?a2pGUDZEdG12WkxnR2tlNE5aQXA0MzVWei8ycHFsUGJ2eVBUdDZwZHFIdVpv?=
 =?utf-8?B?OWtVcUVVeXhHNkJESnc5N096bktZZk5hdm1WblFNQTVEZTZ2VjNZNEdOQ0Zr?=
 =?utf-8?B?eXV4V3BhZFQvTzRZWXY2bXhBSzA5VjlqWHdqRUtKcm1aRFkyOEJ1YnZqTWNr?=
 =?utf-8?Q?sa95IgkMYVZ2vrdRrsFwdQGVg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF1DACDEE38CE04B949DBFA5AB6AF814@NVIDIA.onmicrosoft.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f0f717-874f-44de-0c87-08dd6a5e1ca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2025 22:57:39.6539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BGgKuwM0fTL94StbKXEVwN/K+bdEKf3ltoDtc15jRLIY9lEoyIXOx6g1eacQhNHhVQrUg5KoVdjKQE6b2k62LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8191

DQoNCj4gT24gTWFyIDIzLCAyMDI1LCBhdCAxMTowNeKAr1BNLCBGcmVkZXJpYyBXZWlzYmVja2Vy
IDxmcmVkZXJpY0BrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IO+7v0xlIFNhdCwgTWFyIDIyLCAy
MDI1IGF0IDAzOjQwOjUzUE0gKzAxMDAsIEpvZWwgRmVybmFuZGVzIGEgw6ljcml0IDoNCj4+IA0K
Pj4gDQo+Pj4gT24gMy8yMi8yMDI1IDM6MjAgUE0sIEpvZWwgRmVybmFuZGVzIHdyb3RlOg0KPj4+
IA0KPj4+IE9uIDMvMjIvMjAyNSAxMToyNSBBTSwgRnJlZGVyaWMgV2Vpc2JlY2tlciB3cm90ZToN
Cj4+Pj4gTGUgU2F0LCBNYXIgMjIsIDIwMjUgYXQgMDM6MDY6MDhBTSArMDEwMCwgSm9lbCBGZXJu
YW5kZXMgYSDDqWNyaXQgOg0KPj4+Pj4gSW5zb21uaWEga2lja2VkIGluLCBzbyAzIGFtIHJlcGx5
IGhlcmUgKFp1cmljaCBsb2NhbCB0aW1lKSA7LSk6DQo+Pj4+PiANCj4+Pj4+IE9uIDMvMjAvMjAy
NSAzOjE1IFBNLCBGcmVkZXJpYyBXZWlzYmVja2VyIHdyb3RlOg0KPj4+Pj4+IExlIFdlZCwgTWFy
IDE5LCAyMDI1IGF0IDAzOjM4OjMxUE0gLTA0MDAsIEpvZWwgRmVybmFuZGVzIGEgw6ljcml0IDoN
Cj4+Pj4+Pj4gT24gVHVlLCBNYXIgMTgsIDIwMjUgYXQgMTE6Mzc6MzhBTSAtMDcwMCwgUGF1bCBF
LiBNY0tlbm5leSB3cm90ZToNCj4+Pj4+Pj4+IE9uIFR1ZSwgTWFyIDE4LCAyMDI1IGF0IDAyOjU2
OjE4UE0gKzAxMDAsIEZyZWRlcmljIFdlaXNiZWNrZXIgd3JvdGU6DQo+Pj4+Pj4+Pj4gVGhlIG51
bWJlcnMgdXNlZCBpbiByY3Vfc2VxX2RvbmVfZXhhY3QoKSBsYWNrIHNvbWUgZXhwbGFuYXRpb24g
YmVoaW5kDQo+Pj4+Pj4+Pj4gdGhlaXIgbWFnaWMuIEVzcGVjaWFsbHkgYWZ0ZXIgdGhlIGNvbW1p
dDoNCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiAgICA4NWFhZDdjYzQxNzggKCJyY3U6IEZpeCBnZXRf
c3RhdGVfc3luY2hyb25pemVfcmN1X2Z1bGwoKSBHUC1zdGFydCBkZXRlY3Rpb24iKQ0KPj4+Pj4+
Pj4+IA0KPj4+Pj4+Pj4+IHdoaWNoIHJlcG9ydGVkIGEgc3VidGxlIGlzc3VlIHdoZXJlIGEgbmV3
IEdQIHNlcXVlbmNlIHNuYXBzaG90IHdhcyB0YWtlbg0KPj4+Pj4+Pj4+IG9uIHRoZSByb290IG5v
ZGUgc3RhdGUgd2hpbGUgYSBncmFjZSBwZXJpb2QgaGFkIGFscmVhZHkgYmVlbiBzdGFydGVkIGFu
ZA0KPj4+Pj4+Pj4+IHJlZmxlY3RlZCBvbiB0aGUgZ2xvYmFsIHN0YXRlIHNlcXVlbmNlIGJ1dCBu
b3QgeWV0IG9uIHRoZSByb290IG5vZGUNCj4+Pj4+Pj4+PiBzZXF1ZW5jZSwgbWFraW5nIGEgcG9s
bGluZyB1c2VyIHdhaXRpbmcgb24gYSB3cm9uZyBhbHJlYWR5IHN0YXJ0ZWQgZ3JhY2UNCj4+Pj4+
Pj4+PiBwZXJpb2QgdGhhdCB3b3VsZCBpZ25vcmUgZnJlc2hseSBvbmxpbmUgQ1BVcy4NCj4+Pj4+
Pj4+PiANCj4+Pj4+Pj4+PiBUaGUgZml4IGludm9sdmVkIHRha2luZyB0aGUgc25hcGhvdCBvbiB0
aGUgZ2xvYmFsIHN0YXRlIHNlcXVlbmNlIGFuZA0KPj4+Pj4+Pj4+IHdhaXRpbmcgb24gdGhlIHJv
b3Qgbm9kZSBzZXF1ZW5jZS4gQW5kIHNpbmNlIGEgZ3JhY2UgcGVyaW9kIGlzIGZpcnN0DQo+Pj4+
Pj4+Pj4gc3RhcnRlZCBvbiB0aGUgZ2xvYmFsIHN0YXRlIGFuZCBvbmx5IGFmdGVyd2FyZCByZWZs
ZWN0ZWQgb24gdGhlIHJvb3QNCj4+Pj4+Pj4+PiBub2RlLCBhIHNuYXBzaG90IHRha2VuIG9uIHRo
ZSBnbG9iYWwgc3RhdGUgc2VxdWVuY2UgbWlnaHQgYmUgdHdvIGZ1bGwNCj4+Pj4+Pj4+PiBncmFj
ZSBwZXJpb2RzIGFoZWFkIG9mIHRoZSByb290IG5vZGUgYXMgaW4gdGhlIGZvbGxvd2luZyBleGFt
cGxlOg0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IHJucC0+Z3Bfc2VxID0gcmN1X3N0YXRlLmdwX3Nl
cSA9IDANCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiAgICBDUFUgMCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBDUFUgMQ0KPj4+Pj4+Pj4+ICAgIC0tLS0tICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tLS0tDQo+Pj4+Pj4+Pj4gICAgLy8g
cmN1X3N0YXRlLmdwX3NlcSA9IDENCj4+Pj4+Pj4+PiAgICByY3Vfc2VxX3N0YXJ0KCZyY3Vfc3Rh
dGUuZ3Bfc2VxKQ0KPj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIC8vIHNuYXAgPSA4DQo+Pj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc25hcCA9IHJjdV9zZXFfc25hcCgmcmN1
X3N0YXRlLmdwX3NlcSkNCj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAvLyBUd28gZnVsbCBHUCBkaWZmZXJlbmNlcw0KPj4+Pj4+Pj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJjdV9z
ZXFfZG9uZV9leGFjdCgmcm5wLT5ncF9zZXEsIHNuYXApDQo+Pj4+Pj4+Pj4gICAgLy8gcm5wLT5n
cF9zZXEgPSAxDQo+Pj4+Pj4+Pj4gICAgV1JJVEVfT05DRShybnAtPmdwX3NlcSwgcmN1X3N0YXRl
LmdwX3NlcSk7DQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gQWRkIGEgY29tbWVudCBhYm91dCB0aG9z
ZSBleHBlY3RhdGlvbnMgYW5kIHRvIGNsYXJpZnkgdGhlIG1hZ2ljIHdpdGhpbg0KPj4+Pj4+Pj4+
IHRoZSByZWxldmFudCBmdW5jdGlvbi4NCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBTaWduZWQtb2Zm
LWJ5OiBGcmVkZXJpYyBXZWlzYmVja2VyIDxmcmVkZXJpY0BrZXJuZWwub3JnPg0KPj4+Pj4+Pj4g
UmV2aWV3ZWQtYnk6IFBhdWwgRS4gTWNLZW5uZXkgPHBhdWxtY2tAa2VybmVsLm9yZz4NCj4+Pj4+
Pj4+IA0KPj4+Pj4+Pj4gQnV0IGl0IHdvdWxkIG9mIGNvdXJzZSBiZSBnb29kIHRvIGdldCByZXZp
ZXdzIGZyb20gdGhlIG90aGVycy4NCj4+Pj4+Pj4gSSBhY3R1YWxseSBkb24ndCBhZ3JlZSB0aGF0
IHRoZSBtYWdpYyBpbiB0aGUgcmN1X3NlcV9kb25lX2V4YWN0KCkgZnVuY3Rpb24gYWJvdXQgdGhl
DQo+Pj4+Pj4+IH4yIEdQcyBpcyByZWxhdGVkIHRvIHRoZSBsYWcgYmV0d2VlbiByY3Vfc3RhdGUu
Z3Bfc2VxIGFuZCByb290IHJucC0+Z3Bfc2VxLA0KPj4+Pj4+PiBiZWNhdXNlIHRoZSBzbWFsbCBs
YWcgY2FuIGp1c3QgYXMgd2VsbCBzdXJ2aXZlIHdpdGggdGhlIHJjdV9zZXFfZG9uZSgpDQo+Pj4+
Pj4+IGZ1bmN0aW9uIGluIHRoZSBhYm92ZSBzZXF1ZW5jZSByaWdodD8NCj4+Pj4+Pj4gDQo+Pj4+
Pj4+IFRoZSByY3Vfc2VxX2RvbmVfZXhhY3QoKSBmdW5jdGlvbiBvbiB0aGUgb3RoZXIgaGFuZCBp
cyBtb3JlIGFib3V0IG5vdCBiZWluZw0KPj4+Pj4+PiBzdHVjayBpbiB0aGUgVUxPTkdfTUFYLzIg
Z3VhcmQgYmFuZCwgYnV0IHRvIGFjdHVhbGx5IGdldCB0byB0aGF0LCB5b3UgbmVlZCBhDQo+Pj4+
Pj4+IHdyYXAgYXJvdW5kIHRvIGhhcHBlbiBhbmQgdGhlIGRlbHRhIGJldHdlZW4gInJucC0+Z3Bf
c2VxIiBhbmQgInNuYXAiIHRvIGJlIGF0DQo+Pj4+Pj4+IGxlYXN0IFVMT05HX01BWC8yIEFGQUlV
Lg0KPj4+Pj4+PiANCj4+Pj4+Pj4gU28gdGhlIG9ubHkgdGltZSB0aGlzIG1hZ2ljIHdpbGwgbWF0
dGVyIGlzIGlmIHlvdSBoYXZlIGEgaHVnZSBkZWx0YSBiZXR3ZWVuDQo+Pj4+Pj4+IHdoYXQgaXMg
YmVpbmcgY29tcGFyZWQsIG5vdCBqdXN0IDIgR1BzLg0KPj4+Pj4+IFlvdSdyZSByaWdodCwgYW5k
IHBlcmhhcHMgSSBzaG91bGQgaGF2ZSBtYWRlIGl0IG1vcmUgc3BlY2lmaWMgdGhhdCBteSBjb21t
ZW50DQo+Pj4+Pj4gb25seSBleHBsYWlucyB0aGUgbWFnaWMgIjMiIG51bWJlciBoZXJlLCBpbiB0
aGF0IGlmIGl0IHdlcmUgIjIiIGluc3RlYWQsIHRoZXJlDQo+Pj4+Pj4gY291bGQgYmUgYWNjaWRl
bnRzIHdpdGggMiBmdWxsIEdQcyBkaWZmZXJlbmNlICh3aGljaCBpcyBwb3NzaWJsZSkgc3B1cmlv
dXNseQ0KPj4+Pj4+IGFjY291bnRlZCBhcyBhIHdyYXAgYXJvdW5kLg0KPj4+Pj4gQWhoLCBzbyBJ
IGd1ZXNzIEkgZ2V0IGl0IG5vdyBhbmQgd2UgYXJlIGJvdGggcmlnaHQuIFRoZSBjb21wbGV0ZSBw
aWN0dXJlIGlzIC0gV2UNCj4+Pj4+IGFyZSB0cnlpbmcgdG8gaGFuZGxlIHRoZSBjYXNlIG9mICJ2
ZXJ5IGxhcmdlIHdyYXAiIGFyb3VuZCBidXQgYXMgYSBwYXJ0IG9mIHRoYXQsDQo+Pj4+PiB3ZSBk
b24ndCB3YW50IHRvIGNyZWF0ZSBmYWxzZS1wb3NpdGl2ZXMgZm9yIHRoaXMgInNuYXAiIGNhc2Uu
DQo+Pj4+PiANCj4+Pj4+IEEgInNuYXAiIGNhbiBiZSBhdG1vc3QgICgyICogUkNVX1NFUV9TVEFU
RV9NQVNLICsgMSkgYXdheSBmcm9tIGEgZ3Bfc2VxLg0KPj4+Pj4gDQo+Pj4+PiBUaGF0J3Mgd2l0
aGluICIyIEdQcyIgd29ydGggb2YgY291bnRzIChhYm91dCA4IGNvdW50cykNCj4+Pj4+IA0KPj4+
Pj4gVGFraW5nIHNvbWUgbnVtYmVyczoNCj4+Pj4+IA0KPj4+Pj4gY3VyX3MgICAgcyAgICBkZWx0
YSAocyAtIGN1cl9zKQ0KPj4+Pj4gMCAgICA0ICAgIDQNCj4+Pj4+IDEgICAgOCAgICA3DQo+Pj4+
PiAyICAgIDggICAgNg0KPj4+Pj4gMyAgICA4ICAgIDUNCj4+Pj4+IDQgICAgOCAgICA0DQo+Pj4+
PiA1ICAgIDEyICAgIDcNCj4+Pj4+IA0KPj4+Pj4gVGhlIG1heGltdW0gZGVsdGEgb2YgYSBzbmFw
IGZyb20gYWN0dWFsIGdwX3NlcSBjYW4gYmUgKDIgKiBSQ1VfU0VRX1NUQVRFX01BU0sgKw0KPj4+
Pj4gMSkgd2hpY2ggaW4gdGhpcyBjYXNlIGlzIDcuDQo+Pj4+PiANCj4+Pj4+IFNvIHdlIGFkanVz
dCB0aGUgY29tcGFyaXNvbiBieSBhZGRpbmcgdGhlICBVTE9OR19DTVBfTFQoY3VyX3MsIHMgLSAo
MiAqDQo+Pj4+PiBSQ1VfU0VRX1NUQVRFX01BU0sgKyAxKSkuIGkuZS4NCj4+Pj4gMywgcmlnaHQ/
DQo+Pj4gSnVzdCB0byBiZSBhYnNvbHV0ZWx5IHN1cmUsIGFyZSB5b3UgdGFsa2luZyBhYm91dCB0
aGUgdmFsdWUgb2YgUkNVX1NFUV9TVEFURV9NQVNLID8NCj4+PiANCj4+PiBUaGF0IGlzIGluZGVl
ZCAzIChSQ1VfU0VRX1NUQVRFX01BU0spLg0KPj4+IA0KPj4+IEJ1dCBpZiB3ZSdyZSB0YWxraW5n
IGFib3V0IG51bWJlciBvZiBHUHMsIG15IHVuZGVyc3RhbmRpbmcgaXMgYSBjb3VudCBvZiA0IGlz
DQo+Pj4gb25lIEdQIHdvcnRoLiBQZXIgdGhlIGFib3ZlIHRhYmxlLCB0aGUgZGVsdGEgYmV0d2Vl
biBncF9zZXEgYW5kIGlzIHNuYXAgaXMNCj4+PiBhbHdheXMgYSBjb3VudCBvZiA3IChoZW5jZSBs
ZXNzIHRoYW4gMiBHUHMpLg0KPj4+IA0KPj4+IEFncmVlZD8NCj4+PiANCj4+PiBJZiBSQ1VfU0VR
X1NUQVRFX01BU0sgd2FzIDB4MSBpbnN0ZWFkIG9mIDB4MTEsIHRoYXQgaXMgYSBzaW5nbGUgYml0
IChvciBhIGNvdW50DQo+Pj4gb2YgMiBpbnN0ZWFkIG9mIDQsIGZvciBhIEdQKSwgdGhlbiB0aGUg
dGFibGUgd291bGQgYmU6DQo+Pj4gDQo+Pj4gY3VyX3MgICAgcyAoc25hcCkgICAgZGVsdGEgKHMg
LSBjdXJfcykNCj4+PiAwICAgIDIgICAgICAgIDINCj4+PiAxICAgIDQgICAgICAgIDMNCj4+PiAy
ICAgIDQgICAgICAgIDINCj4+PiAzICAgIDYgICAgICAgIDMNCj4+PiA0ICAgIDYgICAgICAgIDIN
Cj4+PiA1ICAgIDggICAgICAgIDMNCj4+PiANCj4+PiBTbyBkZWx0YSBpcyBhbHdheXMgPD0gMywg
IE9yIG1vcmUgZ2VuZXJhbGx5OiA8PSAoUkNVX1NFUV9TVEFURV9NQVNLICogMikgKyAxDQo+PiAN
Cj4+IE9oIG1hbiwgSSBhbSB3b25kZXJpbmcgaWYgd2UgYXJlIG9uIHRvIGEgYnVnIGhlcmU6DQo+
PiANCj4+IEZyb20geW91ciBleGFtcGxlOg0KPj4gDQo+PiAgICBDUFUgMCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDUFUgMQ0KPj4gICAgLS0tLS0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0tLS0NCj4+ICAgIC8vIHJjdV9zdGF0
ZS5ncF9zZXEgPSAxDQo+PiAgICByY3Vfc2VxX3N0YXJ0KCZyY3Vfc3RhdGUuZ3Bfc2VxKQ0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8vIHNuYXAgPSA4DQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc25hcCA9IHJjdV9zZXFfc25hcCgmcmN1
X3N0YXRlLmdwX3NlcSkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAv
LyBUd28gZnVsbCBHUA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJj
dV9zZXFfZG9uZV9leGFjdCgmcm5wLT5ncF9zZXEsIHNuYXApDQo+PiANCj4+IA0KPj4gSGVyZSwg
dGhlDQo+PiBVTE9OR19DTVBfTFQoY3VyX3MsIHMgLSAoMiAqIFJDVV9TRVFfU1RBVEVfTUFTSyAr
IDEpKTsNCj4+IA0KPj4gV2lsbCBiZQ0KPj4gVUxPTkdfQ01QX0xUKDAsIDggLSAoMiAqIFJDVV9T
RVFfU1RBVEVfTUFTSyArIDEpKTsNCj4+IA0KPj4gPSBVTE9OR19DTVBfTFQoMCwgOCAtIDcpDQo+
PiANCj4+ID0gVFJVRS4NCj4+IA0KPj4gV2hpY2ggbWVhbnMgcmN1X3NlcV9kb25lX2V4YWN0KCkg
d2lsbCByZXR1cm4gYSBmYWxzZSBwb3NpdGl2ZSBzYXlpbmcgdGhlIEdQIGhhcw0KPj4gY29tcGxl
dGVkIGV2ZW4gdGhvdWdoIGl0IGhhcyBub3QuDQo+PiANCj4+IEkgdGhpbmsgcmN1X3NlcV9kb25l
X2V4YWN0KCkgaXMgb2ZmIGJ5IG9uZSBhbmQgc2hvdWxkIGJlIGRvaW5nOg0KPj4gDQo+PiBVTE9O
R19DTVBfTFQoY3VyX3MsIHMgLSAoMiAqIFJDVV9TRVFfU1RBVEVfTUFTSyArIDIpKTsNCj4+IA0K
Pj4gPw0KPiANCj4gQnV0IGl0J3MgVUxPTkdfQ01QX0xUKGN1cl9zLCBzIC0gKDMgKiBSQ1VfU0VR
X1NUQVRFX01BU0sgKyAxKSBub3cgc2luY2U6DQo+IA0KPiAgICA4NWFhZDdjYzQxNzggKCJyY3U6
IEZpeCBnZXRfc3RhdGVfc3luY2hyb25pemVfcmN1X2Z1bGwoKSBHUC1zdGFydCBkZXRlY3Rpb24i
KQ0KPiANCj4gVGhhdCdzIDEwIHNvIHdlIGFyZSBnb29kLg0KPiANCj4gSG93ZXZlciB0aGF0IG1h
Z2ljIHZhbHVlIGlzIGFyYml0cmFyeSBhbmQgZG9lc24ndCBtZWFuIG11Y2guIEl0IHNob3VsZCBi
ZQ0KPiBsaWtlIHlvdSBzYWlkLiBPciByYXRoZXIgZm9yIGNsYXJpdHk6DQo+IA0KPiBkaWZmIC0t
Z2l0IGEva2VybmVsL3JjdS9yY3UuaCBiL2tlcm5lbC9yY3UvcmN1LmgNCj4gaW5kZXggN2FjZjFm
MzZkZDZjLi5lNTNmMGI2ODdhODMgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9yY3UvcmN1LmgNCj4g
KysrIGIva2VybmVsL3JjdS9yY3UuaA0KPiBAQCAtNTcsNiArNTcsMTAgQEANCj4gLyogTG93LW9y
ZGVyIGJpdCBkZWZpbml0aW9uIGZvciBwb2xsZWQgZ3JhY2UtcGVyaW9kIEFQSXMuICovDQo+ICNk
ZWZpbmUgUkNVX0dFVF9TVEFURV9DT01QTEVURUQgICAgMHgxDQo+IA0KPiArLyogQSBjb21wbGV0
ZSBncmFjZSBwZXJpb2QgY291bnQgKi8NCj4gKyNkZWZpbmUgUkNVX1NFUV9HUCAoUkNVX1NFUV9T
VEFURV9NQVNLICsgMSkNCj4gKw0KPiArDQo+IGV4dGVybiBpbnQgc3lzY3RsX3NjaGVkX3J0X3J1
bnRpbWU7DQo+IA0KPiAvKg0KPiBAQCAtMTY5LDcgKzE3Myw3IEBAIHN0YXRpYyBpbmxpbmUgYm9v
bCByY3Vfc2VxX2RvbmVfZXhhY3QodW5zaWduZWQgbG9uZyAqc3AsIHVuc2lnbmVkIGxvbmcgcykN
Cj4gew0KPiAgICB1bnNpZ25lZCBsb25nIGN1cl9zID0gUkVBRF9PTkNFKCpzcCk7DQo+IA0KPiAt
ICAgIHJldHVybiBVTE9OR19DTVBfR0UoY3VyX3MsIHMpIHx8IFVMT05HX0NNUF9MVChjdXJfcywg
cyAtICgzICogUkNVX1NFUV9TVEFURV9NQVNLICsgMSkpOw0KPiArICAgIHJldHVybiBVTE9OR19D
TVBfR0UoY3VyX3MsIHMpIHx8IFVMT05HX0NNUF9MVChjdXJfcywgcyAtICgyICogUkNVX1NFUV9H
UCkpOw0KPiB9DQoNCkFoLCBteSBrZXJuZWwgZGlkIG5vdCBoYXZlIHRoZSBjaGFuZ2UgYXQgdGhl
IHRpbWUgSSBjb21tZW50ZWQsIHNvcnJ5LiBJIGFncmVlIHRoYXQgdGhpcyBpcyBhIG11Y2ggYmV0
dGVyIGFuZCBtZWFuaW5nZnVsIGV4cHJlc3Npb24gdGhhbiB0aGUgZXhpc3Rpbmcgb25lLiBJIHNo
YWxsIGNyZWF0ZSBhIHBhdGNoIHdpdGggaXQgYW5kIHNlbmQgaXQgb3V0IHdpdGggbXkgb3RoZXIg
c2VyaWVzIG9uIGZvcmNpbmcgdGhlIHdyYXAgZm9yIHRlc3RpbmcgKGFsb25nIHdpdGggdGhlIG1v
ZGlmaWNhdGlvbiBmb3IgdGhlIG5ldyBjb21tZW50cyB5b3UgYWRkZWQpLg0KDQpUaGFua3MhDQoN
Cg0KPiANCj4gLyoNCj4gDQo+IA0K


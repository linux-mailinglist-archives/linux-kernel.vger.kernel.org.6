Return-Path: <linux-kernel+bounces-355397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BBF9951AA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC4A1C25561
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30181E009C;
	Tue,  8 Oct 2024 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="050U4JFd"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058AD1DFE1C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397530; cv=fail; b=I0qZslpUscmr1FDh+pua8yMC+JDVXQ6skIRTzrAiub50oKDcIan/qgb3teU8XiO4HYSh46DHQYlrbQAp8TZxrgCXulcDaX0PPV+ieLOSwvi0dL/MdDgZ23fgP9F1g1Xb/sYssiZKoqMyhfZlPB4Vmom/jiAaW7+7FNaSo5y8PfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397530; c=relaxed/simple;
	bh=eENB/p3XBVkGs2zqc/GBCwUxHosW4y0LCoTMEcSpU5E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BR1oa1zQ6FGy8tgFAqXmH41p+/GRgyC6XeF4xQSh3EeMnsK4qwsqz7KuHr/dVclni6lU6JtooGsQ9a7RpjctSatj6peQRxJrjtSMkiXf4rwp2JIYzjdqOoKBhu/0pfr0rL/65Vln1GSN9cYOknWzwSe/fb+Yilp1wJ4kNd6HA7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=050U4JFd; arc=fail smtp.client-ip=40.107.100.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBqtH6f1Se6PZ/LCNpQJYy6gqWyCKk1w3jjbaAe/FBbcodZV6hIyTFBO1mF8fQnhbft9F7Ec9SZh0/m3VUMsdNGsU9smu80Bt7En80Eq63wdc3OrhEt+QlRcov/ktJXgZKJyggWiP+XoMf5/qzsJXAcqyTWzse/BgKtbqsqzRdVy2omEdqDIPYnb1S1t+DzHsF/SHORst5SOW4j37atiXsiZ0+TcxjAErl0wjdYplAVJN5h5JuUOS3GN6jLViDrO+jd1xHOMhNrwztnUP1RMsD9r4nd+ernrdw2TUUKPJ7540VdVpKNeI5NAlKdInAdzyrGZplaKpTkQnN1C5nm4gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eENB/p3XBVkGs2zqc/GBCwUxHosW4y0LCoTMEcSpU5E=;
 b=nkp26MDhdUoNbQvLaGLDfWT8UZEYTq+/CVYkrQ2fCar3qxjy/fY6bukC0JCS9sXgdTwzzTcok2aprcYW7xMuvg05uKjYhaCXf6GsPJjatKimXK94bbw5P0ziGnf8lmqsTs8DoZKW1J9p/u/TWvDKjrgXqUuPsZwVg9ge2d+fFNdQhtvA1bK4G3SzdqYEwCkg36+mXsSBbHmgE5aJVx6Q8bF4boGMxUECF8m4qxwYX4RNEBgKJlVd2kQHmqeNa1P4+XVNwUcgiebJaJkGtux1NgOFfLU8KJ9dee0CFoKPe3cToNmBBHX9hMdzv5Oez9mi3mL+tQQp0WZO+RnFjk4iOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eENB/p3XBVkGs2zqc/GBCwUxHosW4y0LCoTMEcSpU5E=;
 b=050U4JFdX9kMDnnf5JUcjqkJuF7tWGTgFpqVJ8bYuxltWbBoYG72XuHd0uYgXyp8yhaGQbLE9AzAPZdAncMa8no3uSZPuRAfMkvLj68WEbZVU5h3C385bhZ55e6NSazoOUJtVf7Cz4/L8Vo5U0YagxJxJSo948M3Db1d2hbTVo0=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by SN7PR12MB7883.namprd12.prod.outlook.com (2603:10b6:806:32b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 14:25:26 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 14:25:26 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Nikolay Borisov <nik.borisov@suse.com>, Thomas Gleixner
	<tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra
	<peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 13/34] x86/bugs: Restructure bhi mitigation
Thread-Topic: [RFC PATCH 13/34] x86/bugs: Restructure bhi mitigation
Thread-Index: AQHbGX93pXXH0sEgMEi8DUshUFfVebJ86DWA
Date: Tue, 8 Oct 2024 14:25:26 +0000
Message-ID:
 <LV3PR12MB9265593AD43E5844542914E1947E2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20240912190857.235849-1-david.kaplan@amd.com>
 <20240912190857.235849-14-david.kaplan@amd.com>
 <542216b7-7453-4fe8-b63a-cbe2fde0d4c2@suse.com>
In-Reply-To: <542216b7-7453-4fe8-b63a-cbe2fde0d4c2@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fe0a9c4d-f48d-43bf-8bf4-b2ba317a0b51;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-08T14:23:10Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|SN7PR12MB7883:EE_
x-ms-office365-filtering-correlation-id: d63c6afb-3d21-4c3c-3268-08dce7a50d83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TlhLQmhhSnJNcGxIYzV6cmVqMEt1WmJMM3lxV2piMU1SRWNDTy9JRDhEZkE4?=
 =?utf-8?B?VU5MeUVmRy9iRzNQUVJJVlphQnVNOUdrYVVLekNQMnRVb0liWS80MVM5RVJ6?=
 =?utf-8?B?ZjhFNk5KWFNQTmhIejFPeTdWYXhkdkNVTGVaVWgzSFQ5Y0RsSWxtQkdEYWlH?=
 =?utf-8?B?U1VRa1dyV2x3OFcwZHJTallxaHFDWEFoZHIvUDZBZ3pSOFFYU24zUEhCSTJU?=
 =?utf-8?B?b0JkOUpjTWdieU10VW1GeC9STHQrMG80TUVtQ1lTandhSjdHVTdvbFprYUE2?=
 =?utf-8?B?Mjk0MTBiczZrWFBPVWZvYUZqZnZzMGZGUXNTZkdDZWpKM3hObXhLTjg2eFQ3?=
 =?utf-8?B?ejNCblQzZXowbXZpY0lLZ2dwTGo4di90TkJwRGJINjhycVowWndXQ01majRY?=
 =?utf-8?B?YW9DS2tQekx2bTJkTzVmTUxyRE5mQ0RpbVZ5U1dITHEzVlhROVd4Rlp3eHgx?=
 =?utf-8?B?dmV5WXJpVGxheHZRdUU5eVVJWWd6ZkUyVnI5VjNwUzV4M1ZzR0RzS09Hb0V4?=
 =?utf-8?B?cndPT2hqeDNqZ1YyTGYxZkdYcERaWm00Sm1HUHJZbFhHM2pIZWJWSXMwc2lq?=
 =?utf-8?B?TCtPSjFCbFpqM0UvL1ZGeU9jeUFMYUJZb3dXK29CUmorWkJhSnhIVW14UVVo?=
 =?utf-8?B?aEpTMlhEeGJraHR6emtKdmJ4TGdyYkc3SkdHZmpWZnBDUmhzdkxFbGc5VFF0?=
 =?utf-8?B?d2N1eGxsb1M3d0RuK0x3blRwY1k3YnpFZEVZb2tIcVdicngwL1ZoWUt2Yi90?=
 =?utf-8?B?Z3ZSQmpLRWMyRk1PTWEzbDByNUx5U2sxbEZkYnRoNUpNaFY4YXlGNldHdW9B?=
 =?utf-8?B?SHNQOGRNK1V1TUg5NEVRajl5S3hILzBMQ2xzdm00bUp4czZhTHRGVWE2SXNU?=
 =?utf-8?B?cHdIU2dRL1NQd1B6MHlLVG9uT0xsQUpnWjZrZk1OU3pWOEhIbm85MVFvRGdk?=
 =?utf-8?B?WDEwYUFjTE5scjZHSE9IYW1DaEJRY1Vndk5PL2pjU1BOdWtNb0VEQlBIYlpx?=
 =?utf-8?B?azBsbkwyVFpJYjc4ODVkc0RYbVdkUGRzVU1IWU5DTXpiOFEzZ2Nyd2l1bjZ2?=
 =?utf-8?B?UExIVytJS1YwOTZ3YWhnWjlWWUl5cHNMNU5uelB0NVFHVnFEdmJzMk1XMC9h?=
 =?utf-8?B?Vlp1TDFybXNEK3ZNZ2FzYTRZRU9WVEs1WkgzcFg3c1dCUUxCM3pscHR5YTZq?=
 =?utf-8?B?cndHc283T0FFM21INXJjcE5vY1VSdlNCN0RiWW9uZ3pZYW1kcHhaOG1QbjRj?=
 =?utf-8?B?QlVzbS9tODdiOHN0dTlmSTIrUDdIV1BjU1huaktBOFc4OW8vT1NHd2Zna2RY?=
 =?utf-8?B?eUNNVWhHaUdWQzJHUjRlbzM0OGN5Y0gyZXVvUE1NRlpCZ2pqQm5GMlA4NENC?=
 =?utf-8?B?bzUwUGZEUkxBbEV0VE4xZDFrZnJtWHRHd1VvMTdtcTRuVGN6R2tVUHR0QTdV?=
 =?utf-8?B?NkM2cmp1ZzF1eFp0WWdEN3N5RmJuOHdhQzBUc2RUcGcyVVdnNGc5d0F2dFda?=
 =?utf-8?B?ZFZJNlFYQ0lzOWg1NDJaVFhQVUVjVWlNV1lPVGRLZmo5Zlh0Nlo4RFRudDla?=
 =?utf-8?B?K0RxSSt3VjZ2SHdZMG9GbW5WMjltTXNnWi9jc1N4ejZJR2FsNndoMElPK3ZN?=
 =?utf-8?B?MkVqbENIOVZWc1ZVRHF0TDVSVUNaNTlNUmlUZFpRY21MZXkzRXVyYjIrRDJN?=
 =?utf-8?B?dnVieDFxa1dTVjJqOER2cFlIOGhyVE8zT28zUEgwSnJTL2pJS1F3QXhHRW5O?=
 =?utf-8?B?bEcwaDVCSUd2M0tjRUJrTFZtZExPZTRFUkl3cWZTSXBNTTVXWVFNQjdiS3l4?=
 =?utf-8?Q?YoJi9cxRHaCL8UcsN9JnDWpik8Z/LssFnwBc0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NW1Vb0FDUnN2dFEvSk5LMUFLRFR0Und0ZnVVcFp2b1UyRDNRYlZiL0FPRW9Q?=
 =?utf-8?B?THhoaTR6Qis3RElxVVZzWTlVNmJuY3k5bUtleGI2YzJoMkN2ZmF0SGtwOWNV?=
 =?utf-8?B?RjR5U2xJTitjOTBPRXRQeU54SUYzN1N2UGNuU2dBbG1wb3o2cGY1b2ViWVNO?=
 =?utf-8?B?alhoY3gxVEF1MkpxQVQ5OU9HUHcwS1hiYmlUVVhQbHNPNHlESDdkcVhPclJy?=
 =?utf-8?B?M3FSNmJaa1ZoSno2UkUzbzV5Lzk3YVdUbEwybUZiMGNlODZ6QUZWYXF2V2hI?=
 =?utf-8?B?NDJxb3dEd01BVmNNZkZaUkQ1Y2FsV3VJajlEMmhFU0Q1OVR6U0tKV0FPYUtO?=
 =?utf-8?B?WUtLWWU5bjJ6OEsvTmFUZG42YmVOc3NIc1FhazZ3WVRyRmpWSHI1V2R1eDJv?=
 =?utf-8?B?Rm4xZDk2M0laWUdxZkQ0K3J6T0k0NDdib3ZaN3MzZmpJNU9CMHd6blZrdUVL?=
 =?utf-8?B?dEpxSTQrS0pzYVY4ejJ4MVhQWnFpK0kzWm1IaWN0ODN4QkhyalQzcVM1eHYz?=
 =?utf-8?B?WG1sMGVVRVROdW1HODB5bk9nNm03cTdqdjNjT0FVd3dEMlBoWDlTYitjUG9G?=
 =?utf-8?B?SUF5YUQ5SFY4QXc2aTNDaDVsanVKWXRyZlpsQmtpMkxOa3ZtOVZMcElpUENr?=
 =?utf-8?B?SGFsR2JlZHhwQkhoZTIyMEZNRWRqVUpsdC9FeUs1dmVYcWlsOUFuVE9POUc0?=
 =?utf-8?B?L3lOa1VwK1VlbEV6V3lqK3FmN1F0ZXUwT2tZU1pFb3VpK0tMWnRic3hOaW1i?=
 =?utf-8?B?c2U2cHgyRlZqUTVYSXBRbWtIajBNcVd4NEkzUVZNNitCU0tBbUl3cG9yeTl3?=
 =?utf-8?B?amVOZnhiWEF0ZW5QSUViaFJCa0FRSGpFTG1LRTluN2ZETFIyMUI4c2FnOSt5?=
 =?utf-8?B?Tm9icUdRTGhmQm1xSHNNTWxHM0c5NnhUQXNwYWpoY1poUEpUMnZZSWs0UGtB?=
 =?utf-8?B?aXVDY1RWZURjVjZseTJZK3dBYnlXQmRMR1Zsak1BWEpvcGd6NGVGMHN4Nm04?=
 =?utf-8?B?cUIvSU1ZZkpROXlvUUhXT2J3SjJPS01VTFR0R3VxVDc3S1VsRUlQdTR5QzJh?=
 =?utf-8?B?dTdnREpKWVFIOVlXRXF1MFA1THFBV0I3QWlqVlVJVHJyTTRkdVlOTHptUkdy?=
 =?utf-8?B?dHNRLzF0MFE1eTFYdXpadWFZOFVELzJOcjVHK3Q3eENSbGtqRDJ3VitDY3Y2?=
 =?utf-8?B?VzFxM0VEVEZXTWdyeER5QkN6dExtTUx2WEUwbDEwTEVVNWJna1EyUDAyeElP?=
 =?utf-8?B?Mm94QXBxRnZLSThHeEsvczA1bUxqajFSNk1MZ1JuKzA5b2JyUzNzRGdUWU8w?=
 =?utf-8?B?SGl4RWxQZTYvYlVNTUNON3g3R3RnTzNLcnBBYytYK3JMTzZqSm5SbVR0eU1I?=
 =?utf-8?B?M09xRnRiMmhrQkRwamlUK0FpLzhnRjkyWTcyRFR2NDlFU0puTUJxNDFaRkFD?=
 =?utf-8?B?bGNBb3lFYTFMRTRqaTRYS2lRTUJNRjRPN2M1SFdCMDM5U2xRVTFFYkxoYVZl?=
 =?utf-8?B?RGxqaXZqaWxjcVNFRUFuRTU0blBBUXZNdlRkU1pxNTk5dW9keEJUSFRZbEJz?=
 =?utf-8?B?eDY4cWhNOVlsL1RFSEFvNXJTSCtTVC9vMFZNY3RyMkkyd2tWeDdvalpVOXlF?=
 =?utf-8?B?eEpNRVlrMnNndjZ1UDBDZENmZEZZUithZ3N4Vi82NTlHeW0xbjhqSmN2cHdD?=
 =?utf-8?B?RytneDBRa1QxcENLL242VVJ0KzdaUExOYTRISXRRazJORmxOZm1jK0g4TUdO?=
 =?utf-8?B?T0dnZ0hOK00vM3R4eVVHL1Racm94L1ozRTJDRzNMT3p1WEJwbVhxKzNKQkVD?=
 =?utf-8?B?MVZkb2paWXN3MjRpY2tCZFdENFhDajZsZXBWUEd6R0d5MHA3bk5ibng2eUdy?=
 =?utf-8?B?S3RnalAyZTg2NW84dExGQTNzL2hvSkY0WVZVVEhZa2JlS1BFcGFZc0FZM2xh?=
 =?utf-8?B?cXRjQmxkRW9CcWExMjBQMmljdU9QTlYxZS8yQWxNN012YjZmODRPMksvcXZ5?=
 =?utf-8?B?L3N6QVdqSG9xUDBhOHgwT1FxVGgyNXhkaUxZa2EwRTVoQXpuY1BOTmZDSFV5?=
 =?utf-8?B?a3hVM3hWL3U0NmJJdWRWUGx5K1lYMTZiUG9FYzRJdGN0Z3FxUk03ZGJvZkhZ?=
 =?utf-8?Q?E7xM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d63c6afb-3d21-4c3c-3268-08dce7a50d83
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 14:25:26.1947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s4fhe5ISw7dRK9aQ80008timMTNOa+EMIdAVEbqgqWMCX6J60lsCwAutzEhsqDo5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7883

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWtvbGF5IEJvcmlzb3Yg
PG5pay5ib3Jpc292QHN1c2UuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDgsIDIwMjQg
Nzo0MiBBTQ0KPiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+OyBUaG9t
YXMgR2xlaXhuZXINCj4gPHRnbHhAbGludXRyb25peC5kZT47IEJvcmlzbGF2IFBldGtvdiA8YnBA
YWxpZW44LmRlPjsgUGV0ZXIgWmlqbHN0cmENCj4gPHBldGVyekBpbmZyYWRlYWQub3JnPjsgSm9z
aCBQb2ltYm9ldWYgPGpwb2ltYm9lQGtlcm5lbC5vcmc+OyBQYXdhbiBHdXB0YQ0KPiA8cGF3YW4u
a3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tPjsgSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5j
b20+OyBEYXZlDQo+IEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPjsgeDg2QGtl
cm5lbC5vcmc7IEggLiBQZXRlciBBbnZpbg0KPiA8aHBhQHp5dG9yLmNvbT4NCj4gQ2M6IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMTMvMzRd
IHg4Ni9idWdzOiBSZXN0cnVjdHVyZSBiaGkgbWl0aWdhdGlvbg0KPg0KPiBDYXV0aW9uOiBUaGlz
IG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBj
YXV0aW9uDQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJl
c3BvbmRpbmcuDQo+DQo+DQo+IE9uIDEyLjA5LjI0INCzLiAyMjowOCDRhy4sIERhdmlkIEthcGxh
biB3cm90ZToNCj4gPiBSZXN0cnVjdHVyZSBiaGkgbWl0aWdhdGlvbiB0byB1c2Ugc2VsZWN0L2Fw
cGx5IGZ1bmN0aW9ucyB0byBjcmVhdGUNCj4gPiBjb25zaXN0ZW50IHZ1bG5lcmFiaWxpdHkgaGFu
ZGxpbmcuDQo+ID4NCj4gPiBEZWZpbmUgbmV3IEFVVE8gbWl0aWdhdGlvbiBmb3IgYmhpLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogRGF2aWQgS2FwbGFuIDxkYXZpZC5rYXBsYW5AYW1kLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgIGFyY2gveDg2L2tlcm5lbC9jcHUvYnVncy5jIHwgMjIgKysrKysrKysr
KysrKysrKysrLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9i
dWdzLmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2J1Z3MuYw0KPiA+IGluZGV4IGVhZWY1YTFjYjRh
My4uZGE2Y2EyZmM5MzlkIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvYnVn
cy5jDQo+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMNCj4gPiBAQCAtODIsNiAr
ODIsOCBAQCBzdGF0aWMgdm9pZCBfX2luaXQgbDFkX2ZsdXNoX3NlbGVjdF9taXRpZ2F0aW9uKHZv
aWQpOw0KPiA+ICAgc3RhdGljIHZvaWQgX19pbml0IHNyc29fc2VsZWN0X21pdGlnYXRpb24odm9p
ZCk7DQo+ID4gICBzdGF0aWMgdm9pZCBfX2luaXQgZ2RzX3NlbGVjdF9taXRpZ2F0aW9uKHZvaWQp
Ow0KPiA+ICAgc3RhdGljIHZvaWQgX19pbml0IGdkc19hcHBseV9taXRpZ2F0aW9uKHZvaWQpOw0K
PiA+ICtzdGF0aWMgdm9pZCBfX2luaXQgYmhpX3NlbGVjdF9taXRpZ2F0aW9uKHZvaWQpOyBzdGF0
aWMgdm9pZCBfX2luaXQNCj4gPiArYmhpX2FwcGx5X21pdGlnYXRpb24odm9pZCk7DQo+ID4NCj4g
PiAgIC8qIFRoZSBiYXNlIHZhbHVlIG9mIHRoZSBTUEVDX0NUUkwgTVNSIHdpdGhvdXQgdGFzay1z
cGVjaWZpYyBiaXRzIHNldCAqLw0KPiA+ICAgdTY0IHg4Nl9zcGVjX2N0cmxfYmFzZTsNCj4gPiBA
QCAtMjAxLDYgKzIwMyw3IEBAIHZvaWQgX19pbml0IGNwdV9zZWxlY3RfbWl0aWdhdGlvbnModm9p
ZCkNCj4gPiAgICAgICAgKi8NCj4gPiAgICAgICBzcnNvX3NlbGVjdF9taXRpZ2F0aW9uKCk7DQo+
ID4gICAgICAgZ2RzX3NlbGVjdF9taXRpZ2F0aW9uKCk7DQo+ID4gKyAgICAgYmhpX3NlbGVjdF9t
aXRpZ2F0aW9uKCk7DQo+ID4NCj4gPiAgICAgICAvKg0KPiA+ICAgICAgICAqIEFmdGVyIG1pdGln
YXRpb25zIGFyZSBzZWxlY3RlZCwgc29tZSBtYXkgbmVlZCB0byB1cGRhdGUgdGhlaXINCj4gPiBA
QCAtMjIyLDYgKzIyNSw3IEBAIHZvaWQgX19pbml0IGNwdV9zZWxlY3RfbWl0aWdhdGlvbnModm9p
ZCkNCj4gPiAgICAgICByZmRzX2FwcGx5X21pdGlnYXRpb24oKTsNCj4gPiAgICAgICBzcmJkc19h
cHBseV9taXRpZ2F0aW9uKCk7DQo+ID4gICAgICAgZ2RzX2FwcGx5X21pdGlnYXRpb24oKTsNCj4g
PiArICAgICBiaGlfYXBwbHlfbWl0aWdhdGlvbigpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gICAvKg0K
PiA+IEBAIC0xNzE5LDEyICsxNzIzLDEzIEBAIHN0YXRpYyBib29sIF9faW5pdCBzcGVjX2N0cmxf
YmhpX2Rpcyh2b2lkKQ0KPiA+DQo+ID4gICBlbnVtIGJoaV9taXRpZ2F0aW9ucyB7DQo+ID4gICAg
ICAgQkhJX01JVElHQVRJT05fT0ZGLA0KPiA+ICsgICAgIEJISV9NSVRJR0FUSU9OX0FVVE8sDQo+
ID4gICAgICAgQkhJX01JVElHQVRJT05fT04sDQo+ID4gICAgICAgQkhJX01JVElHQVRJT05fVk1F
WElUX09OTFksDQo+ID4gICB9Ow0KPg0KPg0KPiBTaW5jZSB0aGlzIHNlcmllcyByZWZhY3RvcnMg
YWxsIG1pdGlnYXRpb25zIGhvdyBhYm91dCB0YWtpbmcgT04gdG8gbWVhbiBBVVRPDQo+IHdoaWNo
IHdvdWxkIHJlc3VsdCBpbiBvdmVyYWxsIGxlc3Mgc3RhdGVzIGZvciB0aGUgdmFyaW91cyBtaXRp
Z2F0aW9ucy4gSWYgd2UgdGFrZSBCSEkNCj4gYXMgYW4gZXhhbXBsZSBJIGRvbid0IHNlZSB3aGF0
IHZhbHVlIGRvZXMgX0FVVE8gYnJpbmcgaGVyZS4NCg0KSW4gdGhpcyAoYW5kIHRoZSBvdGhlciBi
dWdzKSwgQVVUTyBtZWFucyB0aGF0IG5vIGJ1Zy1zcGVjaWZpYyBjb21tYW5kIGxpbmUgb3B0aW9u
IHdhcyBwcm92aWRlZC4gIEluIHRoaXMgd2F5IHdlIGNhbiBkaWZmZXJlbnRpYXRlIGJldHdlZW4g
bm8gb3B0aW9uIHByb3ZpZGVkIChpbiB3aGljaCBjYXNlIGF0dGFjayB2ZWN0b3IgY29udHJvbHMg
d2lsbCBkZWNpZGUgaWYgbWl0aWdhdGlvbiBpcyBuZWVkZWQpIG9yICJiaGk9b24iIHdoaWNoIHdp
bGwgZm9yY2UgdGhlIGJoaSBtaXRpZ2F0aW9uIG9uIGV2ZW4gaWYgdGhlIGF0dGFjayB2ZWN0b3Ig
Y29udHJvbHMgd291bGQgb3RoZXJ3aXNlIGxlYXZlIGl0IGRpc2FibGVkLg0KDQotLURhdmlkIEth
cGxhbg0K


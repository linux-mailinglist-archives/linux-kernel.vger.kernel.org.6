Return-Path: <linux-kernel+bounces-325837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12335975ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3343B2387A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AD13A8E4;
	Thu, 12 Sep 2024 02:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yOP7nO06"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82F72BD1D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 02:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726107687; cv=fail; b=kIxYIEVmzfsNY6jjSV/sRYXbT/DsaZA0lrlOV3QRTVYld3MTkVUZk7tnM2HyIoR4Ifxd3/RUBXt3OKDrowL430tA5fp9vag8cB/fv1a6zv4L76Tay+B4Wofnm5dkOBCi1sXkkautJtnAFRGo2BMqcgCBPRMk2sbXVWkz/dKZook=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726107687; c=relaxed/simple;
	bh=tutZIHqIQ6LDwkeRkHa+Ns0ZsSToA5TnSqemm832qaY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gW0cqK1QBXl9+Y0Hc1qVoJx62drqxC1YpJQTPs1dl3exdpTeUu0qdsf46r8uKRkuipJgBE5vFNHyOEQ9aQZQvo8iEm20f0Y+X+NLp05PimrZT+6UvjA1FBfrnzCMuuW++QgphUYpqWDnkONSfE2Ts9me+fx237qvcXRNQ5QdXUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yOP7nO06; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjRVJGkSWRU66RpF4Kr8tm1U5lDkGwLFUm3nr8YXx/nHvSufB7e7w0/JHxW7xANjA9bV/7JkLSVmGay8d65BliSNu2XDdMO5Dy/y0/A6Q3sUof271w1z8D95LUyW8P0ou2vGxjm0phk4RecM3T0YzdLpbHE1pM7dB5yxP4A8ahUKJiCSql/XMnoCfNtQYzIPEONPCa7NvQzG1RGz9IVXpclmkGn25G89Fqg2FgOLnag1eOAwhGXk+4zsvNIi4xLPNVglz3g5Xlv1NI715USfEhzYs+RkbTHLdYnK9ZDX/5mUj4peZPINGgsTA7yA7Hl+RQVxa+SVKeGzyepdUCUxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tutZIHqIQ6LDwkeRkHa+Ns0ZsSToA5TnSqemm832qaY=;
 b=qO+Dj/5Ez5SZO/BUHfyIaIbx5V1LMqcA/+5x3KeV0GZJY692LPQ2w3o5uuPUQPrNVljbLXOT/JabVckPoL2Gbugc0j22+olfEwS6MNDrToOxDpQEyu4YkpI/jSoMV6Er5W5laeWKTkSmdiUglEZcsEkGbatP4xB715pw8cIV1xrkWtSzbMH1TLC3UNALYNVBKTFtN83cp4+AfB6/SxknE7y9FXto+NDV/tmFWzBzFLMRmADhAY+aefQKtBPwGphTCch/e15uLhV0mT8BMlg645de8+PMImPO9Citqse6Hy+I0OiDRCJx5irIMSsOJ9tjDedBQrRxWPcPowRTx0LvMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tutZIHqIQ6LDwkeRkHa+Ns0ZsSToA5TnSqemm832qaY=;
 b=yOP7nO06bS+eGD2MRnMVnoep3+fwjmgAoGy0CVS/XPwiifizWSsgNXky/j86r4956YKOyEZ6uuTw5GcnQRZBaQQibAOroK/uH5UnzoHuQXYXR70btRuDWGaqIb8EvGAoJRB1ZPPm51oMeHnHB6G1BO9yqbpt67EmlBHFj6WHU34=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by MW6PR12MB8949.namprd12.prod.outlook.com (2603:10b6:303:248::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 12 Sep
 2024 02:21:22 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.7897.021; Thu, 12 Sep 2024
 02:21:21 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: "Huang, Kai" <kai.huang@intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "x86@kernel.org" <x86@kernel.org>, "dyoung@redhat.com"
	<dyoung@redhat.com>, "sagis@google.com" <sagis@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Williams, Dan
 J" <dan.j.williams@intel.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Kalra, Ashish"
	<Ashish.Kalra@amd.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"bhe@redhat.com" <bhe@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>
Subject: RE: [PATCH v6 2/5] x86/kexec: do unconditional WBINVD for bare-metal
 in relocate_kernel()
Thread-Topic: [PATCH v6 2/5] x86/kexec: do unconditional WBINVD for bare-metal
 in relocate_kernel()
Thread-Index: AQHbAo9GtMXQ5J+L60GdV3fxNS9w/rJPeZbAgADXaACAAADYgIAAd2+AgAKmHWA=
Date: Thu, 12 Sep 2024 02:21:21 +0000
Message-ID:
 <LV3PR12MB92651EFF193770C82CDCD36094642@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <cover.1725868065.git.kai.huang@intel.com>
	 <79f0de36a2a4f33e6cea8f0bf6419a6dc09ba94c.1725868065.git.kai.huang@intel.com>
	 <LV3PR12MB9265B4512DE5F2D580DE3CF794992@LV3PR12MB9265.namprd12.prod.outlook.com>
	 <3f419ba5-7b95-45f0-adb3-d7397949c14e@intel.com>
	 <LV3PR12MB9265900A6564C22E9F6666ED949A2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <8b9ddac38a612a7ecee7511c657ba0bf84660d3b.camel@intel.com>
In-Reply-To: <8b9ddac38a612a7ecee7511c657ba0bf84660d3b.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=21508881-f956-4f2a-bedb-bd8d1576aee9;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-12T02:19:52Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|MW6PR12MB8949:EE_
x-ms-office365-filtering-correlation-id: 8392732d-645e-4472-414b-08dcd2d197c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?anY4eU5ORDdDbWUvTEFTck1qbzdQQzdqK2dnbFl4RHN4amR0RDN3N2Z6bTdV?=
 =?utf-8?B?dlJJdHZ6a0tpRk5xQmlKOENaanZOampZR2haZmVtU0Zvb3JWc0NRMEZuRURa?=
 =?utf-8?B?Q3NMbi92VEdwSTNrcjlWZCtIaDNZOXdDdTdlTVJIVmRoTmd0MVRoSzBNUitP?=
 =?utf-8?B?dE9pNVZFR0tMaTNQM1Z6YlY5U3R0ZU1PVEZ4NEVvQTZQdGh0YXVkU2tQbXMv?=
 =?utf-8?B?MitLcVE1cWFxTTc5NWxSZTNCQno1TGJsRDFRUHJiZnkrOHNaQkNOSVMzSmt1?=
 =?utf-8?B?bEhNb1YxaWhxdmdnNVZKWVMwcjJtalN5T0Z4Qm94OG1Ha0w3OHh0UE5aQW5y?=
 =?utf-8?B?UE16SkxnYmxGa3gyMmJoemEzMnUrZmNsejZOTGp5cVFvVTdRVmFyeE01Z1lV?=
 =?utf-8?B?Q1BwMml4NjF6SnMxbENUS3dLM2dvUmpYdzlVakgyL25XM1ZOYkxLT1o0clNM?=
 =?utf-8?B?Vmo5ejk4ZEVjVklTSjhMZDJEQmthSjZuVkxhdG1paVhzTVk3TVlIeGR2MUJ2?=
 =?utf-8?B?bUJLNlYxK0JBU1FYei9hb2hhcElvVXVzSTUxWG14NERYOTJPelQ5ekt2YUl4?=
 =?utf-8?B?cDhWZEZPSHJZOTMzTWRlUzJUb1BEQ2JiSGoxcXRDNXpaK2JSRjVlL3gyVkla?=
 =?utf-8?B?WWtESlZlUmZsN2FQOWJ3akNBT3kzYzdKblpKZlRYby9CUnRKRHRTTWNrTVU4?=
 =?utf-8?B?MTRGS241ZFQ2MXlpS1NRT0IwcjdWUGt1RE9sbitQUUlaeVdJSkhYbFF0bXIy?=
 =?utf-8?B?L1VTbm9zdm9YeUJVTmJrNEpSZ2xlODRvZU5OVURlSlhzT0gySGl5cW0rY3dC?=
 =?utf-8?B?K0FWNjJoTUxncmVyWEF0TUR4Y2NUWW5BR0VhcS9Pc0ljUHU4ZllRc0s0RXJ5?=
 =?utf-8?B?REJETVFJWS9wRHlFTmdSMXlpbXM4L2FsOXl6UGZwS1JyYkp6a1BrUm5lWjhB?=
 =?utf-8?B?Y3dCMWtMZHA0djArb1k5TkNLaHMrNXo5cW9BMU5pcThSVGRGcHpsLzJNMGZD?=
 =?utf-8?B?WjdNM25RZ25FcnFmZGwxWkE3dVorUjhCSWgvK2tlM0xKSm0xOHhyd1pPRlZq?=
 =?utf-8?B?dTZmdkR0NElsaXhsdXViSmc0ZVNxdGJNelJmelVjcVdTbnlJTEZCWHZka3A0?=
 =?utf-8?B?KzlpeHFpalhiYklyMlJTUWpzbEFtcXUxb0Zuc0pQdU9XR1JNSDNvMmU4M05N?=
 =?utf-8?B?OFdmdnFFNnFCYWFWRzhVb00rOHQrNUlET2VVZ3V1TW1Tbmc2a1NiUGhVV1Yr?=
 =?utf-8?B?Vkhqdk94Y29ZcjRwci9sUmdZcnVzV2FXVm5QZWpaa0cxT0ZDcG1IZmM4MkEw?=
 =?utf-8?B?YlFkQUJULzQ1d0t1blRVYXN3Tm92NzhkU0ptQnd3ZkJ5R2ZGNktCbm96NHRH?=
 =?utf-8?B?WkpWQUcvWFlCVVBPNlJYbnlHTm42V2ZibmdTL2NjQ20ySnYzRk92ajJERGFC?=
 =?utf-8?B?dmJPTUFJUG9BVFhiZWRVTEtTdFpSL045VEd6dXF0aEZwTnh2R2lEVlI3N1hq?=
 =?utf-8?B?azdNelBZNUgyUU5mdTFia2NiaXk0K1ZOZHowc01VNHBUckRVUEJsZkhScmFQ?=
 =?utf-8?B?WGVaZG1uMnlOeHJFUk8wQTFzQ3RHdTIxQUdLWFZCNTVMVTZZcG9vSmR0ZHpI?=
 =?utf-8?B?QVlUeEJTVFIrb21VQi9UNEhUaURPRHBhUmJoVWZoV3JzZDdBTTJtUHQ0ajVL?=
 =?utf-8?B?TDl0WDB0QzJGQnZiY2Q3cEpQajVUNFBiQXBtc1hURGN6ZTNJbEtzalBxNlU3?=
 =?utf-8?B?OVhmbUNTQ3FYMFdHczFWdzZvdXpIeGpwRUw3ZmlobFZWa0dwdXNnL29Ra3Rz?=
 =?utf-8?B?dDYrR0R4MHo4clNUZ2JUN3B2dU9hRC93SmdiRThnZFhrNjd0QjlMcmFIL0t3?=
 =?utf-8?B?SWRqdlp0ZmJiRndjMEVBeVY1U0h6am45WVZTTTZ0UUxVbDBlamVacVVaSHZM?=
 =?utf-8?Q?2pqOs4oTUag=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZTMrejVhVkRSSFN0dXVTOTMvV25mdXg5eDJmRUh2ZGJTWnZqTE9UbktWVXpq?=
 =?utf-8?B?ZTdiTWhqWHl6M011dS9ONm9mTHZZZ0h2SjU0Ni9uL0pqa3FtMW1qY3pjaE1o?=
 =?utf-8?B?c01Lbnp5SVBaU3RxTVB5clNnQmtoRUFGYkNZOFJwWmN0OTZwdnZWMm5YWDRw?=
 =?utf-8?B?SkNJZExWQ1FrZVBvc3pxRlRRKzhYcFBRQUU0U29rVUdabzI5TldsWk41bFow?=
 =?utf-8?B?dks5M3Njek9EZHFBQW5jLzg5ZlBhMzkxbXlIek5IeXlTTGttVHFqcWpOM0pL?=
 =?utf-8?B?L0xZcWhEL0VPa0lVTUNSMGUzR0F5R1NHT2RUQmVTV0JmK01INnV2bDJ3VG5t?=
 =?utf-8?B?SVhKT1crc0hTZkRYQjRsakdoMUJzTmswYzhPb0tUT013MWQ0VUdnbmw2RTRN?=
 =?utf-8?B?OUVxZ2JnY2ovRVBRbHlrcnJNM01nWlB5a2JUU2V1RkV4RFNZRkJ3STlEanYw?=
 =?utf-8?B?NTBHdlJyaTZSL1JlRnhaYkZIcHp2VklPcUFPTGk4bEdtVmx5b1ExcWtWQXBZ?=
 =?utf-8?B?WHE1VXhNR0FqTThrYjhGRms5aVNhV2N3LzZiNjNNb0tjcExjSHFvMHRJaUFE?=
 =?utf-8?B?T1pSK1dGbFJHU2h2b01wbDdQWTFlUU1DM2hZMVU0cThVelJVUTg2TXdFbGxv?=
 =?utf-8?B?bzgrWTYzQWV6bHd4cllPcmdmYk9LdUlDWndyUEdUSUpZYW5OY2IwcFlNU2Fm?=
 =?utf-8?B?QTRFVnhQN211bWgzeGtjTDZ1RG44Z2pWcGo5T2t0STJWZnJuaFJtcG45TlN1?=
 =?utf-8?B?OUErS2xmczlmOEtPNk1HNUtDQ0tydU9PWTNHWGh0Zzdkam1rdVc0OG9xY3FT?=
 =?utf-8?B?T2NaT2xxaEhEVTU2dEIrSjBLeTlMaVNIZ0tCbTh1Q3RIcEF2bnF3Q0tEeHdh?=
 =?utf-8?B?QVZQYlFSMjhhcjNXWWZYZEQ3MXpJeUZzUUwvN01DZXdtendFVDRWRmd2eXZv?=
 =?utf-8?B?NWNrVnBBL0dRczFrTVc3Nnd0bkFoK0NTV3IwYjlQK1hQYnpMUk1FbUp5Y0hC?=
 =?utf-8?B?NWVIbWU1N3cra0NDWTJsckFFUUhmL2lIblJmRUxDbEFFNnl6RU84bGhzVU9T?=
 =?utf-8?B?RzJZL0M0WjQrOGVVOVNJcS9PTm5MS3JienVGL1ExV3hWbXRrUHUwVU9nR2hX?=
 =?utf-8?B?RHlyd0RjNEF0UHFESHM0d2hwRWM5TkkvekllcmZRYnpjdzYwMS9tTGR3d1Bp?=
 =?utf-8?B?NFlpb1ltcVBucGswcHBaTXdaUjVxRmV5ZHorRDQ4UlFaOEcrOHk1N2pzaG5p?=
 =?utf-8?B?TUY0enh1VUU4WkNGVGxSTDZJdjFycEZQbmJZLzh6N3ZJZWxHR00zMEMreGpH?=
 =?utf-8?B?a1d3elNNQnFrZFBndXltejFISFZDL21xT05DdjBDcno0SnFuSm1xRHFBTFlK?=
 =?utf-8?B?MGoyZGFqS0dsbFRtZEQvcWN5NzJCTjlNbkxqb2xaeXNSSlI0M3llK09acDNL?=
 =?utf-8?B?cEh6Qnd3OWF4UVVkWkZ3c0FQaGdseDhLWDhDL1dic2xreFlyNVdEblJKdGR3?=
 =?utf-8?B?N2l0b1ZNcUJZc2pKNGtEK1ZZcEY0WTUxeGRVY2hVM0lvQkttMG1WUWR3Q2hi?=
 =?utf-8?B?M1ZOK3JVVk1BTitBaVpXbnNFZTYwZmM2TkhhY21ZcjUraTEwb2hBV1MvSWZX?=
 =?utf-8?B?V2MrV1ZRaEhZSUFDSkdEazVoNVlqc2c5STJtOFRvTFo5THBYVXFKODlYS1Rr?=
 =?utf-8?B?dUI2c2Q1aXdSOWs0aS84cXlndVErSlNaUUc3SFVJTEJvejZmYUlycEUxdUd6?=
 =?utf-8?B?Zy9XSjdHeTlxMlpsVjJNcG8xb1hhRUpuNC8ydXdXT0lrTG9UaS9VT1BscXZY?=
 =?utf-8?B?aFlGRWhaNDN0d1NHMmRQY3F0U2MxSUg2c0R3Z1ZSSzVjU25WVS9SZ1ZTQ3RS?=
 =?utf-8?B?a29rU084Y0d1MlJndDNaTFphYVRyVXFqZ3cvZUwxbk1aNTdjSGNWUHVJRk5T?=
 =?utf-8?B?QXVWeXd5eWZ4TWZuWlBFcm5WcXdaZXRXb21FdGxRUThiT3psU1l4bmZFU1Rj?=
 =?utf-8?B?VjB3aThSeVRJbmZJelJ0Z3d6NDRGR3U2QkdPRmFBNHl5djZQSE1WN2ZZUEtM?=
 =?utf-8?B?ZEUvN2pWSm9HNldjSlIxUWhZY2UrSWhhR0dlcHNIdHFOYW03MmdaRll5Tlkx?=
 =?utf-8?Q?DhsE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8392732d-645e-4472-414b-08dcd2d197c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 02:21:21.5522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UgEbi0Bk74fouoe3P1K/IAR8aCVHc7xlPDBixHR0xrveNKJ2DQc3wXAkiM90Q9kt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8949

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIdWFuZywgS2FpIDxrYWku
aHVhbmdAaW50ZWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTAsIDIwMjQgNDo1
MyBBTQ0KPiBUbzogSGFuc2VuLCBEYXZlIDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+OyBicEBhbGll
bjguZGU7DQo+IHBldGVyekBpbmZyYWRlYWQub3JnOyBocGFAenl0b3IuY29tOyBtaW5nb0ByZWRo
YXQuY29tOw0KPiB0Z2x4QGxpbnV0cm9uaXguZGU7IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxh
bkBhbWQuY29tPjsNCj4ga2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbQ0KPiBDYzogRWRn
ZWNvbWJlLCBSaWNrIFAgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPjsgc2VhbmpjQGdvb2ds
ZS5jb207DQo+IHg4NkBrZXJuZWwub3JnOyBkeW91bmdAcmVkaGF0LmNvbTsgc2FnaXNAZ29vZ2xl
LmNvbTsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFdpbGxpYW1zLCBEYW4gSiA8
ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPjsNCj4gTGVuZGFja3ksIFRob21hcyA8VGhvbWFzLkxl
bmRhY2t5QGFtZC5jb20+OyBwYm9uemluaUByZWRoYXQuY29tOw0KPiBLYWxyYSwgQXNoaXNoIDxB
c2hpc2guS2FscmFAYW1kLmNvbT47IFlhbWFoYXRhLCBJc2FrdQ0KPiA8aXNha3UueWFtYWhhdGFA
aW50ZWwuY29tPjsgYmhlQHJlZGhhdC5jb207IG5pay5ib3Jpc292QHN1c2UuY29tDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjYgMi81XSB4ODYva2V4ZWM6IGRvIHVuY29uZGl0aW9uYWwgV0JJTlZE
IGZvciBiYXJlLQ0KPiBtZXRhbCBpbiByZWxvY2F0ZV9rZXJuZWwoKQ0KPg0KPiBDYXV0aW9uOiBU
aGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3Bl
cg0KPiBjYXV0aW9uIHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9y
IHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9uIFR1ZSwgMjAyNC0wOS0xMCBhdCAwMjo0NiArMDAwMCwg
S2FwbGFuLCBEYXZpZCB3cm90ZToNCj4gPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIElu
dGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+ID4gRnJvbTogSHVhbmcsIEthaSA8a2FpLmh1YW5nQGludGVsLmNvbT4NCj4g
PiA+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDksIDIwMjQgOTo0MiBQTQ0KPiA+ID4gVG86IEth
cGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPjsgSGFuc2VuLCBEYXZlDQo+ID4gPiA8
ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPjsgYnBAYWxpZW44LmRlOyB0Z2x4QGxpbnV0cm9uaXguZGU7
DQo+ID4gPiBwZXRlcnpAaW5mcmFkZWFkLm9yZzsgbWluZ29AcmVkaGF0LmNvbTsgaHBhQHp5dG9y
LmNvbTsNCj4gPiA+IGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20NCj4gPiA+IENjOiB4
ODZAa2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IHBib256
aW5pQHJlZGhhdC5jb207IHNlYW5qY0Bnb29nbGUuY29tOyBXaWxsaWFtcywgRGFuIEoNCj4gPiA+
IDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+OyBMZW5kYWNreSwgVGhvbWFzDQo+ID4gPiA8VGhv
bWFzLkxlbmRhY2t5QGFtZC5jb20+OyBFZGdlY29tYmUsIFJpY2sgUA0KPiA+ID4gPHJpY2sucC5l
ZGdlY29tYmVAaW50ZWwuY29tPjsgWWFtYWhhdGEsIElzYWt1DQo+ID4gPiA8aXNha3UueWFtYWhh
dGFAaW50ZWwuY29tPjsgS2FscmEsIEFzaGlzaCA8QXNoaXNoLkthbHJhQGFtZC5jb20+Ow0KPiA+
ID4gYmhlQHJlZGhhdC5jb207IG5pay5ib3Jpc292QHN1c2UuY29tOyBzYWdpc0Bnb29nbGUuY29t
OyBEYXZlDQo+IFlvdW5nDQo+ID4gPiA8ZHlvdW5nQHJlZGhhdC5jb20+DQo+ID4gPiBTdWJqZWN0
OiBSZTogW1BBVENIIHY2IDIvNV0geDg2L2tleGVjOiBkbyB1bmNvbmRpdGlvbmFsIFdCSU5WRCBm
b3INCj4gPiA+IGJhcmUtIG1ldGFsIGluIHJlbG9jYXRlX2tlcm5lbCgpDQo+ID4gPg0KPiA+ID4g
Q2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2Uu
IFVzZSBwcm9wZXINCj4gPiA+IGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlj
a2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gPiA+IC0tLSBh
L2FyY2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0LmMNCj4gPiA+ID4gPiArKysgYi9hcmNo
L3g4Ni9rZXJuZWwvbWFjaGluZV9rZXhlY182NC5jDQo+ID4gPiA+ID4gQEAgLTMyMiwxNiArMzIy
LDkgQEAgdm9pZCBtYWNoaW5lX2tleGVjX2NsZWFudXAoc3RydWN0IGtpbWFnZQ0KPiA+ID4gKmlt
YWdlKQ0KPiA+ID4gPiA+IHZvaWQgbWFjaGluZV9rZXhlYyhzdHJ1Y3Qga2ltYWdlICppbWFnZSkg
IHsNCj4gPiA+ID4gPiAgICAgICAgICB1bnNpZ25lZCBsb25nIHBhZ2VfbGlzdFtQQUdFU19OUl07
DQo+ID4gPiA+ID4gLSAgICAgICB1bnNpZ25lZCBpbnQgaG9zdF9tZW1fZW5jX2FjdGl2ZTsNCj4g
PiA+ID4gPiAgICAgICAgICBpbnQgc2F2ZV9mdHJhY2VfZW5hYmxlZDsNCj4gPiA+ID4gPiAgICAg
ICAgICB2b2lkICpjb250cm9sX3BhZ2U7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAtICAgICAgIC8q
DQo+ID4gPiA+ID4gLSAgICAgICAgKiBUaGlzIG11c3QgYmUgZG9uZSBiZWZvcmUgbG9hZF9zZWdt
ZW50cygpIHNpbmNlIGlmIGNhbGwgZGVwdGgNCj4gPiA+IHRyYWNraW5nDQo+ID4gPiA+ID4gLSAg
ICAgICAgKiBpcyB1c2VkIHRoZW4gR1MgbXVzdCBiZSB2YWxpZCB0byBtYWtlIGFueSBmdW5jdGlv
biBjYWxscy4NCj4gPiA+ID4gPiAtICAgICAgICAqLw0KPiA+ID4gPiA+IC0gICAgICAgaG9zdF9t
ZW1fZW5jX2FjdGl2ZSA9DQo+ID4gPiA+ID4gY2NfcGxhdGZvcm1faGFzKENDX0FUVFJfSE9TVF9N
RU1fRU5DUllQVCk7DQo+ID4gPiA+ID4gLQ0KPiA+ID4gPg0KPiA+ID4gPiBGdW5jdGlvbmFsbHkg
dGhlIHBhdGNoIGxvb2tzIGZpbmUuICBJIHdvdWxkIHN1Z2dlc3Qga2VlcGluZyBzb21lDQo+ID4g
PiA+IGZvcm0gb2YNCj4gPiA+IHRoaXMgY29tbWVudCB0aG91Z2gsIGJlY2F1c2UgdGhlIGxpbWl0
YXRpb24gYWJvdXQgbm90IGJlaW5nIGFibGUgdG8NCj4gPiA+IG1ha2UgZnVuY3Rpb24gY2FsbHMg
YWZ0ZXIgbG9hZF9zZWdtZW50cygpIGlzIGFyZ3VhYmx5IG5vbi1vYnZpb3VzDQo+ID4gPiBhbmQg
dGhpcyBjb21tZW50IHNlcnZlZCBhcyBhIHdhcm5pbmcgZm9yIGZ1dHVyZSBtb2RpZmljYXRpb25z
IGluIHRoaXMNCj4gYXJlYS4NCj4gPiA+DQo+ID4gPiBZZWFoIHRoaXMgbWFrZXMgc2Vuc2UuICBU
aGFua3MuDQo+ID4gPg0KPiA+ID4gSSB0aGluayB3ZSBjYW4gYWRkIHNvbWUgdGV4dCB0byB0aGUg
ZXhpc3RpbmcgY29tbWVudCBvZg0KPiA+ID4gbG9hZF9zZWdtZW50cygpIHRvIGNhbGwgb3V0IHRo
aXMuICBBbGxvdyBtZSB0byBkaWcgaW50byBtb3JlIGFib3V0DQo+ID4gPiBjYWxsIGRlcHRoIHRy
YWNraW5nIHRvIHVuZGVyc3RhbmQgaXQgYmV0dGVyIC0tIHJlbG9jYXRlX2tlcm5lbCgpDQo+ID4g
PiBhZnRlciBsb2FkX3NlZ21lbnRzKCkgc2VlbXMgdG8gYmUgYSByZWFsIGZ1bmN0aW9uIGNhbGwg
YW5kIEkgd2FudCB0bw0KPiA+ID4ga25vdyBob3cgZG9lcyBpdCBpbnRlcmFjdCB3aXRoIGNhbGwg
ZGVwdGggdHJhY2tpbmcuDQo+ID4NCj4gPiBUaGF0IG9uZSBpcyBleHBsaWNpdGx5IGlnbm9yZWQs
IHNlZSBza2lwX2FkZHIoKSBpbg0KPiA+IGFyY2gveDg2L2tlcm5lbC9jYWxsdGh1bmtzLmMNCj4g
Pg0KPg0KPiBUaGF0IHdhcyBJIHRob3VnaHQgdG9vLiAgVGhhbmtzIGZvciBwb2ludGluZyBvdXQu
DQo+DQo+IEhvdyBhYm91dCBiZWxvdz8NCj4NCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL21hY2hp
bmVfa2V4ZWNfNjQuYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvbWFjaGluZV9rZXhlY182NC5j
DQo+IEBAIC0zNTEsNiArMzUxLDExIEBAIHZvaWQgbWFjaGluZV9rZXhlYyhzdHJ1Y3Qga2ltYWdl
ICppbWFnZSkNCj4gICAgICAgICAgKg0KPiAgICAgICAgICAqIEkgdGFrZSBhZHZhbnRhZ2Ugb2Yg
dGhpcyBoZXJlIGJ5IGZvcmNlIGxvYWRpbmcgdGhlDQo+ICAgICAgICAgICogc2VnbWVudHMsIGJl
Zm9yZSBJIHphcCB0aGUgZ2R0IHdpdGggYW4gaW52YWxpZCB2YWx1ZS4NCj4gKyAgICAgICAgKg0K
PiArICAgICAgICAqIE5vdGUgdGhpcyByZXNldHMgR1MgdG8gMC4gIERvbid0IG1ha2UgYW55IGZ1
bmN0aW9uIGNhbGwgYWZ0ZXINCj4gKyAgICAgICAgKiBoZXJlIHNpbmNlIGNhbGwgZGVwdGggdHJh
Y2tpbmcgdXNlcyBwZXItY3B1IHZhcmlhYmxlcyB0bw0KPiArICAgICAgICAqIG9wZXJhdGUgKHJl
bG9jYXRlX2tlcm5lbCBpcyBleHBsaWNpdGx5IGlnbm9yZWQgYnkgY2FsbCBkZXB0aA0KPiArICAg
ICAgICAqIHRyYWNraW5nKS4NCj4gICAgICAgICAgKi8NCg0KTG9va3MgZ29vZCwgdGhhbmtzIQ0K
DQo+DQo+IEJ0dywgaXQgd291bGQgYmUgdmVyeSBoZWxwZnVsIGlmIHlvdSBjYW4gaGVscCB0byB2
ZXJpZnkgdGhpcyBwYXRjaCBkb2Vzbid0IGJyZWFrDQo+IGNhbGwgZGVwdGggdHJhY2tpbmcgaW4g
eW91ciBlbnZpcm9ubWVudC4gIFRoYW5rcyENCg0KVGVzdGVkIGl0IGFuZCBpdCBzZWVtZWQgZmlu
ZSAoa2V4ZWMgd29ya2VkIGFuZCBkaXNhc3NlbWJseSBkaWQgbm90IHNob3cgYW55IGNhbGxzIGFm
dGVyIEdTIGlzIGNsZWFyZWQsIGFzIGV4cGVjdGVkKS4NCg0KLS1EYXZpZCBLYXBsYW4NCg==


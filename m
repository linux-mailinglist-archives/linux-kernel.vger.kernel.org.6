Return-Path: <linux-kernel+bounces-357794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5A0997626
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD109284910
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A84A1E22E9;
	Wed,  9 Oct 2024 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gcBmrRo5"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90749173336;
	Wed,  9 Oct 2024 20:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728504160; cv=fail; b=UvWcFfTXPi74VgP8Vol/+Sz1ZI+VgSJvAHxCvIp6Es1LZh+0yV/kpS1CgXIikRJ9smHeC7C7JF7X3RRd6vC3UYQNFD1N1hYJZcVx4jtMJzraMP1a3zAllzaaggoeinhSfgfl4RZ0+mzf/gU7+zde1uaPtQhEIBk67Fg1JDO7DmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728504160; c=relaxed/simple;
	bh=CXjFiwn7JJvtIrktBuFF9ZVqINjlx9x+lNscsS2AHbM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dX5xnpvTO3LTLyDBa+aZV+MgzqRI9Wgshif0rYEH3wripatRlMbqf1LtKXu8NN3dSbxunh4Z+gc7yKirE2pOTU1ImspO6bfiGsUFiOTR7Q7P2KaQoAEbXd4iFIpWVhdH03INhY+dkBgmLg5YPSdzBcbi2qGbbVIRyvz5MkbkrZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gcBmrRo5; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=escexa4jhR8ZGc8LqvEFnOZ297F8XDtlDYHbcxD22G7nlvWwvG/uMx0KMuHt0PXDnLW0dYYihVmiIQlSugU1LZigzoCYDPB0B17pbkz1hxI66E5GBh1Nqjy2Sbl3TE6iRbenA0lUbB9+WWykWRB3xfMyYanGEVed/MbgaqcYUDLgz5v+i8vy5OeBBP3fXlVcS1phCgOayvwthmkN78MICBNLl+uqBkJbQQFFq/1dQQx90RG/GGHR80FwqOML6+Qrf3PAFOKYdaKqvcsm90t6E6hnsKGae2bZhhuk3agnhf6nHCbMUeNAjlWtsdGD39cXrmYGysq7Bc6NrLAvJ8EAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXjFiwn7JJvtIrktBuFF9ZVqINjlx9x+lNscsS2AHbM=;
 b=Innr1Ooel0Oh0pzczDIA+blKR793NIaeKEueeD0kzGq3kN0ZVlXwI5rpL5Gn1MVmwTPy/wbFl4fn8iUsuT9dBKWlZ6BRsoFV348KyLI2WuOPujVcY0URyi/mwvwWUjosoPFRNGktkDnu9j3GEyr/du9qIVWtntbvi5VdWU9lMnEBiew7Y+vpzxSe3Iave8xl8ZkR0AeVx58g3ARuO+BkoFvFeYAUV82DBbT/06exzXjnUvl//BLrKupEEIW9ZwYiGgJqRsLzDm7x8hhvJwKXxDNZF6VoOQfE+t6BZf+DbkeN6Lb5O5yHQDWRnSn5pwJTMgPpepBB6yoqJDgiBlnFBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXjFiwn7JJvtIrktBuFF9ZVqINjlx9x+lNscsS2AHbM=;
 b=gcBmrRo58RbQxJR3QxcNHfKhdHJcHvQu/hozpC9Jfn/fc3hn+nOutyHOsQZf++qqBp5fh675je6rtgj0z/PRmps7/jGqThOx+ROXNL/D3/hmVrNSUxnWeHd27VVBBsvX3X4EQM0sxg6t1t11AXbb6Bk2AZL0Kceut7MP9uOToOU=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 20:02:34 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 20:02:34 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Daniel Sneddon <daniel.sneddon@linux.intel.com>, Jonathan Corbet
	<corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov
	<bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "hpa@zytor.com" <hpa@zytor.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pawan.kumar.gupta@linux.intel.com"
	<pawan.kumar.gupta@linux.intel.com>
Subject: RE: [PATCH 1/6] x86/bugs: Create single parameter for VERW based
 mitigations
Thread-Topic: [PATCH 1/6] x86/bugs: Create single parameter for VERW based
 mitigations
Thread-Index: AQHbGbegzRZsFOFa5keXyvP1YFB3hbJ+mhYAgAAASzCAAAXogIAAM4OAgAAEMpA=
Date: Wed, 9 Oct 2024 20:02:34 +0000
Message-ID:
 <LV3PR12MB926551F0A89B3C7B6209F3A4947F2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20240924223140.1054918-2-daniel.sneddon@linux.intel.com>
 <LV3PR12MB92651F4DF654C886B9F2BCF7947E2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <879b3437-c706-47c4-b1aa-b2def940f569@linux.intel.com>
 <LV3PR12MB9265A30309277CBB4A9B81D1947F2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <7c1de6fb-fa83-47bc-a57b-e6700860513d@linux.intel.com>
 <83686f5b-7957-432c-9e2c-d54e381c06c9@linux.intel.com>
In-Reply-To: <83686f5b-7957-432c-9e2c-d54e381c06c9@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=30e16f5c-4734-4885-a4f4-3bf66ef6cc44;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-09T19:59:14Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|MN2PR12MB4333:EE_
x-ms-office365-filtering-correlation-id: 9a770860-9c41-43e7-a514-08dce89d511a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?djVoQ0xKd1Aybm9qWStxeW5COExWbXNmK0I1dkZwcDdDcjVmVmRFZGN0alRZ?=
 =?utf-8?B?b1I2dHNRb2FLd1B1cmZmbEc4dVF3MlJKTVNNRW9Jc1pEYTFJVVRSRXNwMlFo?=
 =?utf-8?B?T1QzL0pLVENZM0dneDE3SHNjbXE1MGJwVUc2ck5zWXpQNGZBMGxIcDFmM2Z6?=
 =?utf-8?B?TlNnVi8vc3RVTlVtbFhHZGFEd3RkSzY2WVhCNjN4ZDJBYndsYjlRVFd5Vlph?=
 =?utf-8?B?Rm9VOG1Nc2ZBSTZMd0g1ZWJmSzR6eDd3TXhDV05IcU01T1lHbU53bHZuaDFV?=
 =?utf-8?B?SjE0djdqMlNtbU5pU0E3VENLN2dHcTU0WlBiUVpHRkJKMmcwK21UR0R1U05I?=
 =?utf-8?B?MVo4Y0RFb1hEVFh2b1g0OHlPd1MxblZNUXdacy81ekVKZU5rTTl1UFRxWjBl?=
 =?utf-8?B?OTRZdjVDbXVFeVI0RGRFcXdWdEtlRmowR21RMC9MeVdrSmVoVVUveEEwZkF1?=
 =?utf-8?B?UmRQWktHZEpsUUQ2WG5CSmVYcjFyUE9hdTJZdFIxeXhoV2k2MHFtZ3ZXYVNW?=
 =?utf-8?B?ZXZoWnpNNUw0K0x1L3RENzVmcFliZjNqME04bHhFK250WTJIMEYvNVZMdjg1?=
 =?utf-8?B?cjNHTjJ0MllSVG1mVkVyL1pKcFVXV3Q1L1phSjRNRnlYV3JyUU9BRWF3c0w0?=
 =?utf-8?B?cVJDREhMWkd6MC8rTlB2UTNyMTdoNE1nWWxjbCtkKzZueWlBL1pjYThaaHVy?=
 =?utf-8?B?cjluOTZaU3FQRDVUYVNXZU5icEw0RGxjWVZPbWh2NzRMemkvK2V1dW9CZTRW?=
 =?utf-8?B?Z3R2MVhRdExHV3QvNWt4ZzNucVB4TTdnZzIwdGx4dmNVL09RclFtL1pGd2Rs?=
 =?utf-8?B?Nm00UG9TVWgzOHNyNTFDNWFFQkg2RFVib3Z3UmR4em9pclh4OWozUHR1THIv?=
 =?utf-8?B?U1NNZE1jbi82ZXFFYVdCT0J5RHhJbVVXYnhzeUYzSmo0L3ZOQkxTSEVFc094?=
 =?utf-8?B?SFFyTkcyTzVNaXlLUDhOWW9TdVlVV2EzQ0tGNVAvWDJpQlFYSVd6SjE4NGp6?=
 =?utf-8?B?Q3NJOTFtSVgrdlBwMkUzUjMveXFpUzhoelpJTkFKZTBjWTJHRTUvalhpVlFO?=
 =?utf-8?B?L2sxcVJOek15SFlrU1N1emM2TDFncWJ4R1lXWWdFMmh6TGtmdkIwc1NoTnRs?=
 =?utf-8?B?WXhrK2swTUhvK2RFZ0FWdkl2blRHQVNJbDZ3ZnNVYnorRFJwMnpGMWRDa0o0?=
 =?utf-8?B?ZTlqZlhza3psWThBd2JYSG10SVd1OTNJclY0RC9wOHFuMGxlWi84RzV3Nnp6?=
 =?utf-8?B?Q1VoR2tYUUtiWDBHREhrUnc3c1NHd2ZrRE9meEpQbWdlVlZWYUNpMTdJWmkz?=
 =?utf-8?B?azBqcVlsUklvZ0FZbVdkcFIyNHVmRGVxRXIxUDBKVGp0UHBsbVU4dEpEVGxm?=
 =?utf-8?B?Tk5nZXVqZU1jY2tWak5ScnlDZ2h4VUZ2alFLa3BrZlpxemZadzNadWh6THU4?=
 =?utf-8?B?bWgrSEJwSThxdzRPS1NUbndrV3R1U3hpaWoyeFc2cFRmOXNacnprN0tKSVRT?=
 =?utf-8?B?RnIxR3ZpUTF3WFZDS1NXUW05RzJDZUR5ZmtDdEswV3VCWUdGMmt1NTByQWlq?=
 =?utf-8?B?TExiZE9tczRsSG5uU1FuMElUR2hjVWJvSU5pVVFJNzRicmhKNi92WlhoSnpV?=
 =?utf-8?B?WEpvVHNscHJVczlkdVdmSGhKbUpOdTBGVndEMHB3djNyVWlLZFJZZHVHc3ND?=
 =?utf-8?B?Y05DeWExWHdtc2RJTUc4cFluOUU5QThBSWhNNzFaYVlPZ1VQeWEwUCtQY2Qz?=
 =?utf-8?B?SlkxbjlnNUtlYWpKQzM0YTNPNmpTVVUwOEFXdnJ1WUY1NU16VzhHcFBnclRP?=
 =?utf-8?B?Y3FQWTdneEk3cGRZb2RVdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bTJNZ2FLNkZ1dlI4K0xyZVRKOC84OE1lUUZQQXBtdGg5dE96bFNSd1hyNFVZ?=
 =?utf-8?B?NjIzSm5CdmRHSmZNck9EOFFrd1YwREpLNEpnQWhFVUxYaHhNUS95SnVFczZo?=
 =?utf-8?B?eUtheGFvODhucFZ4SXpYSndmcnFaV05xcVZ2aVFyR0h0NGptNFJaRnlFdVc4?=
 =?utf-8?B?L2pYTU9jRGlmR0tId2srd05zMTlreXk3MlEvVjc3cHRuM2ttRmJYZENJWmh6?=
 =?utf-8?B?VEQxcWdnN1h1WDFOWHpsQWlSUWZQMmQxTlYyWWNKbjRteEx5ekFpcDNUUDJY?=
 =?utf-8?B?d1RJSmdwLzFYUVlJZVN2d3psOWdRODhYWFZuSTVQS0dScUxlQjJDMUVCRjdD?=
 =?utf-8?B?OUxvTW9Pb2FqVFA2NWpySmRNMElzbTMySUo5Qmk3YmVVZDBEQkhRV0UzbVIz?=
 =?utf-8?B?eGlHTkNzSG9sNHJnWWsxd011NWFQc0gyU003b1krbVBkNXRmSUJQSnNNSlMy?=
 =?utf-8?B?ZUdPMzJXa0w2M2VjRVZsK2JJM0xzWHJFVWQrMG1OdGJ2bFZJWFFjVWVhVjd3?=
 =?utf-8?B?YTNxRkR2bmZHcHcwbkREU2o2dlVDSTh0TzZ4R296RXNIcnVmV25DOGZwRlN5?=
 =?utf-8?B?SFYvSmF2bFQ3UkFaUTNGcy9qNzJJaldWc1hEUnVmRTBxK21VRFU2Y3Bja2lv?=
 =?utf-8?B?NCt1U2srZEg4UFVNU2NDeVBERGdqRzBtTFloRVdBbVRDMmFNNXZUOC9KczVL?=
 =?utf-8?B?Y01velZWN3F2NzdrL0VWcjRvNnB5a2pvUk13clVTVU1aWFpackZyUzk3NGlP?=
 =?utf-8?B?V3lJV1J5VVZ2QytFWnNaL0hqNnpadHZtNm9MVXZSd1NzV1lMZHBoMkxJTHdF?=
 =?utf-8?B?cFZXOS9CS0xNdGhNUlJoM0NqKzdvbmovSTVFZEFKT3BIZjRPdXd5TWhNZDRB?=
 =?utf-8?B?T0Q4TW1EKzdRUGU1SnE2VGk3UFRtQTFtbmErZlNBd2dIRk5sd0dFcndQWVUz?=
 =?utf-8?B?TWZoMllzREJzKzhKMk0xWG4rbWYrTWxkYlFIZVhHUDl2czFRRnJQUTl5K1NG?=
 =?utf-8?B?aldKL2ZTclB4NGdiZnZDTVlMYWZBZVk3WDhUV3VFLzlGNDQ5RDY2TWd0K3VZ?=
 =?utf-8?B?K0F2SmRPeW8rQUdFUXhrN2JzeWppdUxoek16NkY2QThSSmxvQTU2OU05eGVm?=
 =?utf-8?B?ZXY2QnQ5UVc3cWVEdzdpR1RKaEF3K01xQ2R5cDBSbDlFcURBbWR2T0NMcmxq?=
 =?utf-8?B?QTRMcWtRRlROZUxyMEE0RHY2S1lHYzk5cFlQM0s1Q3ZBeDVvQkpNRGR4ZUJ0?=
 =?utf-8?B?MXFhL3JMRGlNZ1pWVncyZnFIcVpyQ3YrblN1MU4wdkxzNWxTUHA3YWw0cVBD?=
 =?utf-8?B?UlZWb0R3TVNEMU1mL3VUcmFUWkR4YnBGeGcrQ2VlWFEzbUlaaHhsU2hwSXZq?=
 =?utf-8?B?b0d6bnRNbU9oTGNseDI4cGx0ZEhFZ2VHdHcwb0xYOUJPaWpDa3VBY01PWXNy?=
 =?utf-8?B?UkZjT2M3Q0ZGVHBLbkpaYlZsQ2d2WnI0bVE3dnFIaEpuZEc0c3VoRjZ1QVRB?=
 =?utf-8?B?alBiRTZROXF0aHdlN0t4ajJwVExuYlBncjRvVXZqREJVRHlybkVQNUp5L0NH?=
 =?utf-8?B?N3BZYmVMREpSSnBvM0gwajNEcE5PMEZ6N1lMYnIvaUdCVFVyU1ZhU3pWOWxY?=
 =?utf-8?B?a1krSWI0Nmh6ZnA2OVBydnZXanNxVTk3amg2cGRaOERBTDJ3TElNVXZ0RjlO?=
 =?utf-8?B?TFVZRjVocFNhR3hROE5EWGJTVEhoa29sTmlwQzl1bmd0bHRoUlZLREttTjBW?=
 =?utf-8?B?T2dVbkh2V0d6TUZ4K09Gd1d5aFI4a3AybWNPZ0lBN2U3QXI5MndSRUx1bkF4?=
 =?utf-8?B?SHVlekRmY0V4TCtDL3NXWHFDQzAwM1c4dDVqMWNQL3NmQkVMT29lOEM1U2hD?=
 =?utf-8?B?OVNjUTQwZGIxeXRTeHhpUkZPVUo2YStXMnhHclNTdGp2cU45aEd6WWg5RDV6?=
 =?utf-8?B?aXR5bVhvZEtKU2ZPdnNRMS9LYzdHTlltcmFHTWd3K2ZWMk8wRlRDWFRLMWdB?=
 =?utf-8?B?WkV1MVBZUW5iSDY2THl1RURxeW1hRWlFNkdCZnZnQngreU1EMWd4V0g2TVVV?=
 =?utf-8?B?TTRsRmJPSXpkMS9nL2FGaTZXQ0VDSW1iblRZZVNURkx0L2dENlFtR3pnbERW?=
 =?utf-8?Q?yks4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a770860-9c41-43e7-a514-08dce89d511a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 20:02:34.7841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fiKJK4uF0yPsyDQr0FONaXqDyFFGKfwIqi6Pna9A5LqatHMS1TLavJ10HT3jCi4Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWwgU25lZGRvbiA8
ZGFuaWVsLnNuZWRkb25AbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9i
ZXIgOSwgMjAyNCAyOjQ0IFBNDQo+IFRvOiBLYXBsYW4sIERhdmlkIDxEYXZpZC5LYXBsYW5AYW1k
LmNvbT47IEpvbmF0aGFuIENvcmJldA0KPiA8Y29yYmV0QGx3bi5uZXQ+OyBUaG9tYXMgR2xlaXhu
ZXIgPHRnbHhAbGludXRyb25peC5kZT47IEJvcmlzbGF2IFBldGtvdg0KPiA8YnBAYWxpZW44LmRl
PjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsgSm9zaCBQb2ltYm9ldWYN
Cj4gPGpwb2ltYm9lQGtlcm5lbC5vcmc+OyBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47
IERhdmUgSGFuc2VuDQo+IDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+OyB4ODZAa2VybmVs
Lm9yZw0KPiBDYzogaHBhQHp5dG9yLmNvbTsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4Lmlu
dGVsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNl0geDg2L2J1Z3M6IENyZWF0ZSBzaW5n
bGUgcGFyYW1ldGVyIGZvciBWRVJXIGJhc2VkDQo+IG1pdGlnYXRpb25zDQo+DQo+IENhdXRpb246
IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJv
cGVyDQo+IGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywg
b3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gMTAvOS8yNCAwOTozOSwgRGFuaWVsIFNuZWRkb24g
d3JvdGU6DQo+ID4NCj4gPj4+DQo+ID4+PiBBcmUgeW91IHN1Z2dlc3RpbmcgYSBuYW1lIGNoYW5n
ZSBhd2F5IGZyb20gImNsZWFyX2NwdV9idWZmZXJzIiBzaW5jZQ0KPiA+Pj4gaXQgaXMgY2xlYXJs
eSBhYm91dCB0aGUgbWl0aWdhdGlvbiByYXRoZXIgdGhhbiB0aGUgYnVnPyBJJ20gbm90IHN1cmUN
Cj4gPj4+IHRoZXJlIGlzIGEgZ29vZCBjb21tb24gbmFtZSBmb3IgdGhvc2UgNCBidWdzIHRoYXQg
aXNuJ3QgYWJvdXQgdGhlDQo+ID4+PiBtaXRpZ2F0aW9uLCBidXQgSSdtIG9wZW4gdG8gYW55IHN1
Z2dlc3Rpb25zLg0KPiA+Pj4NCj4gPj4NCj4gPj4gWWVzLCBJIHRoaW5rIHRoYXQgd291bGQgYmUg
YmV0dGVyLiAgSSB3YXNuJ3Qgc3VyZSBvbiBhIG5hbWUgZWl0aGVyLiAgSW4gdGhlDQo+IFJGRFMg
d2VicGFnZSBJIHNlZSBpdCBkZXNjcmliZWQgYXMgInNpbWlsYXIgdG8gZGF0YSBzYW1wbGluZyB0
cmFuc2llbnQNCj4gZXhlY3V0aW9uIGF0dGFja3MiLiAgUGVyaGFwcyBzb21ldGhpbmcgbGlrZSB0
aGF0IGNvdWxkIGJlIGFuIHVtYnJlbGxhIHRlcm0/DQo+ID4+DQo+DQo+IGRhdGEgc2FtcGxpbmcg
ZmVlbHMgYSBsaXR0bGUgdG9vIGdlbmVyaWMuIEhvdyBhYm91dCBzb21ldGhpbmcgbGlrZQ0KPiBt
aWNyb2FyY2hfZGF0YV9zYW1wbGluZz8NCg0KVGhhdCdzIHdoYXQgTURTIHN0YW5kcyBmb3Igcmln
aHQ/ICBNaWdodCBiZSB0b28gYXNzb2NpYXRlZCB3aXRoIHRoYXQgb25lIGlzc3VlLg0KDQpNYXli
ZSB0cmFuc2llbnRfZGF0YV9zYW1wbGluZz8NCg0KLS1EYXZpZCBLYXBsYW4NCg==


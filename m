Return-Path: <linux-kernel+bounces-541019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074B5A4B782
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 06:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF5F3ABF16
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C4F1DC075;
	Mon,  3 Mar 2025 05:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p3mGvIH5"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED37B23F383;
	Mon,  3 Mar 2025 05:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740979038; cv=fail; b=LtdgXa/E9a+vQz/9h5W9xT0t882bqUoiyCr7WLCbc/nxIssT7culitR7Wzgm4obciGypdS4Dqr5B8AaE2bH1eC/0+e9mrp6BYsbHqphVzcC7p/pFNBU4v3bq3dr7tD7K9nA3FFwpOPTFNNh+ZASd4FllmybcmDDZI6qAW1YJtD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740979038; c=relaxed/simple;
	bh=xXEJHb0V1sdz9aE56m/0yG/8QOAd4GnFo10vWP8UXbk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fKqg77c45rSuyoO7ofpaHKiXXqJxIiQEZI9VBwm1+bJSrCVoaerJ1mnN4KcuaqJXEDlcWM5A5alzYmHEAzHPijuaJx8gyEUDP6P1ZFtyXW42llUxbVnJrZOGMuof9j4CA+gegTxjcAax48Zc9oUhSWT2+38O5kuer4sG1lg0U9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p3mGvIH5; arc=fail smtp.client-ip=40.107.100.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+wPXcwi5fNAR5KoPiBpKOOgaX2KPE9Qx7gyY3FHUskd6dsmOqMoS6BQMCiz4MWyklXaHpccP1R4HyNxIbGGFiLiEqoZZJtj3VeeGEmdsg+ZynFP4u+JccjxPHt9XyovChxWvE+fLR2vePw0LWRPhWDqFd6aH2v9jajW5jRttA9iTVqGvmsszgWy6bgsT5qvNOiQ6VYalalZCDUQgqusrMvceDQbNhhzdUFjSBjp6odMD5f5ZVpjIGONFTlg9IwOL0feRsB7r3trjC4vv/YB2Fu7m/N5YtpiCml7/WuNxNXA6NzwcAcBC0rZMjmWifE0ECZjc3J6GXItXS/6z5w7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXEJHb0V1sdz9aE56m/0yG/8QOAd4GnFo10vWP8UXbk=;
 b=hgfmSr/9gS+lcdigPehxmFOFck2biYygvEvoG22NH7Bj522C0pCJalpahS1OXgCsOVCGwM+HQ+oF71YgLJNmDJfCI6ogu/QvJdxPPiPQGJbciRek0kfvEp+YidtbYRPHaxYhFAhjAWdkohJUG/x0F9B1qQ+jQRg4+qa/eqFa5rrhGZtjwPwfPdXlyxaZp49MA51SKb1hhrNXnm72k/S10ZFxtUw0m1ccWI3KpNlZ2M0ilOcDKmozD7yJYH/Sj8kD37iiqb2ZKu1yLWtFPAO3ZalvesWXctdqwxOtDFopVtm0etKUI3JI24lnmVvhFDv3sw9Hnb8WpzqpHCeJ8Kn4fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXEJHb0V1sdz9aE56m/0yG/8QOAd4GnFo10vWP8UXbk=;
 b=p3mGvIH5swov4wz1MAaQAPIjKIkmWFaVn6j81cWavMAtrN6butk0dRnmtdzOOHi/e5eVCu/I3Qw/nh8PUP1TY7CzWtpg1QRLigWegvO13YX7Ccpg6msObTzWFWzlaJsmquC0EklUhyV/6lGyynXOXHWng0Zp1mXTJ853X+v9xOI=
Received: from CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 05:17:14 +0000
Received: from CY5PR12MB6429.namprd12.prod.outlook.com
 ([fe80::1b40:2f7f:a826:3fa0]) by CY5PR12MB6429.namprd12.prod.outlook.com
 ([fe80::1b40:2f7f:a826:3fa0%7]) with mapi id 15.20.8489.021; Mon, 3 Mar 2025
 05:17:14 +0000
From: "Nirujogi, Pratap" <Pratap.Nirujogi@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "hdegoede@redhat.com"
	<hdegoede@redhat.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>
CC: "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Chan, Benjamin (Koon Pan)"
	<Benjamin.Chan@amd.com>
Subject: RE: [PATCH] platform/x86: amd: Add ISP platform info
Thread-Topic: [PATCH] platform/x86: amd: Add ISP platform info
Thread-Index: AQHbigKdbpsmFHrZKESUSDnn/jO07rNeUSWAgAKRLFA=
Date: Mon, 3 Mar 2025 05:17:14 +0000
Message-ID:
 <CY5PR12MB6429EE863D0ED9DC89EE86F0FEC92@CY5PR12MB6429.namprd12.prod.outlook.com>
References: <20250228170238.3484860-1-pratap.nirujogi@amd.com>
 <ac0a2d39-aecb-4f24-8198-906f660edb17@kernel.org>
In-Reply-To: <ac0a2d39-aecb-4f24-8198-906f660edb17@kernel.org>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c90924b9-9e73-430f-87a2-9ede0dfe2f36;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-03T05:14:42Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6429:EE_|BY5PR12MB4243:EE_
x-ms-office365-filtering-correlation-id: a98b3c0f-7096-422e-ec70-08dd5a12a8a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c1NPbk4yaWRoMVZjdUo1MUJjQ0NGeWJmaDBKQlJ4UGhlYmU0TlB4MmljbGJY?=
 =?utf-8?B?c2N4OUJveGx3MFUvOGNZajlrUmFsc3UwVUFYVFo3bTJCRWQrbzdLYzVGR2JB?=
 =?utf-8?B?UXhXNFF6UkdmZUJyNzRRMHhxSTR5d3ZCaWRoczhIbnFURzNCVlorcjdMZTVC?=
 =?utf-8?B?eDQzc2M1Zk9yZFBSNkxWUjdIZFNiU2dXOEtGaXRnY1ZmUWRacEE3OWtiLzd2?=
 =?utf-8?B?S3lZVGtuT3BMaGxGSk5DdzlMdGZ4TTBsUDVUeG1Ua2lvVHAzYXVWRnBPeUc4?=
 =?utf-8?B?YXhpL3lsdGJwM2grQ0kwWHpENmlPM0pLcDZkWFl2VklpT3RBTldCRGNxRnZz?=
 =?utf-8?B?Y0J1Z1I0MEFURkd1TTlESzMyTjNweGl4bU50UmJyRXZ6Z3hTaVc4aE5vTXBr?=
 =?utf-8?B?eDdXQjhJSTgzWjFnSXVzZEN0QUJNNk5scUdaY2pnKzFOenZoSFNNdyt5UHdM?=
 =?utf-8?B?ZW9MRk9lSXIyandxUHI5SEN6OVZIOEplcDFsV0JTV0VQN2VmSFlXRlZlczFi?=
 =?utf-8?B?ZGViMFl0dml0VzJPMDNsOHVBSnhoNVYrenIxQ21LTlVKOFpPVE55MUl6eC9a?=
 =?utf-8?B?ZVo3VlhZKzlINVNvY2xzdU13MHFrY1paelo0eTViQ1Ewc29WSEZ5K0NIT0Vi?=
 =?utf-8?B?eTluNkxJbnlHOSsrM25weGM2ZTM3YnZ5MnYxbDhYMkhick50L2tBbFFaSGd6?=
 =?utf-8?B?cWhuQldOUEZsclhGbjVLTldiVDdnK3JkcnBlTHg2bDhHSUlKMTNEZTFicnEw?=
 =?utf-8?B?OEg5cXBFdkhIV2NxelVoSHl4bXVMMU5qRmFEL0JtbUM3RHp6MkVRT3JYVnZD?=
 =?utf-8?B?T25oc1RZSC90OUxEWStzSVcwbjVud3pRZFhHdGhOem0veEN3RGFzQlVFUWNv?=
 =?utf-8?B?UkljWG43VFEvdzlLOFVtUnhZR1NodURxazNXRkZZSlJNa3VZaFFuNUc2YUFO?=
 =?utf-8?B?akpOOFVhTVBrQjNDZVRuamx5V3F2ZXpHNGFRK1F1bjZqYUZ1S0h6Y2FSUW1H?=
 =?utf-8?B?TSs5cXlZRmNkQjYwN1ZNNXNaTGJYZ09qYWZDeFkrRzBMa1p6ejczcjNPd3Ba?=
 =?utf-8?B?UTF5WC9OZGJEclJtUkxReW1lRG1IajYzTWltUnZRVTVkdHZjQU1vNnBjdmt3?=
 =?utf-8?B?TlQ4YTZORUcrays1S3J0RmtzdzJOdkhCYnFscndiSVZTVmV0cjl0eERhOXFz?=
 =?utf-8?B?Tm5aSExZWm9CK2RxcmUvMDVCZzIvVVRudHN6czdsQ1NWb2FBeHYrak15TEpM?=
 =?utf-8?B?bFJleU9KcmttcmIyRFVybllLWlp6M09CY0FrOERxcEJ1ZEJFeWdRTDlZdGwr?=
 =?utf-8?B?SkNMVkdaUmZTNzBicUMzcE50NUkwdTRIa0pRU3AvYjdPVGI3S2V1a3NhbVRt?=
 =?utf-8?B?MC94V21neEtabC9YWXJxVmVWNVJNQm5FcHhpWk1kOUxXeHFCV0x3a3lBZFNi?=
 =?utf-8?B?b1RFblY0SE40N3Z4bHpDVUFRZHFTV1lzd0Roek8xdGlhOHNIYU0xeEtDb2N4?=
 =?utf-8?B?aXhVa1RJbW9xUlhQU2JyajF6SXhTSFNKbkVHOURzN2d0QlZlVWlzdjF1clV0?=
 =?utf-8?B?SzU2ckJhc3JFUFdhUFFRbFhKNHRSaUd6cE90SnlzZW9FTkE4eWpYS3FnMGlj?=
 =?utf-8?B?Smc1NHJsaWs4dmc5ZnN1MTNpb1BodG1ETlJ6cWRQZjNRWUpxUFJrc3NjUnBI?=
 =?utf-8?B?cDhwb1dibmFCaVJFOTQ3bCtDM2RZbjdwcXlUUXVZRlhEb2UyVkFXV3hqaUs0?=
 =?utf-8?B?NDZvTVh1OHp3VG9QaC94NDNLYk1KNVY1cFp2OWg0UVJKZm05akNjTUdLMjdE?=
 =?utf-8?B?Z2RVZCs4SnZhRllGbjFRUnBoY3UyeUN0Z3Qwb1VnSXFaSFhhMUFnalhsMmFt?=
 =?utf-8?B?YURnSmxWQjluSzVveVdzU3FpMm15UnpBbEpHbGVjK2ZmQXdXV2prVllBV2FW?=
 =?utf-8?Q?LC+A33DA8vJNtgylRJWZWowmqQSfzv3R?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6429.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TlF6c3VWelNDb3U3YUhsbDFHNkdlcjlKaVBGQXdpdUdsZ2JsRWFsOVR5aitH?=
 =?utf-8?B?YnprT0FFaTZseXVDT1VhTVhyMlVnS1RKMmFwL2Q1QVVQUmI0NUNGN1dWQkZn?=
 =?utf-8?B?WlcwcUxiVk5DcWhiSXg0RFVDN01UVkVEVVZjZ1ExUmVXeDUxVENwTXBQdWhS?=
 =?utf-8?B?K2tKUmRLOWlJZmxwb3FiZmU0SW9xa3BQaHNoL3c0ZmpoTU52TlpnVUhjRnVF?=
 =?utf-8?B?cW1vZjdYcDM3NFVqajcwWHQ1RW9USXRZRDBjV0M3ZXQwL1R6ZGU2UWhzLzV6?=
 =?utf-8?B?LytlSE1RaVd3WTNDc05mQnVKNE9xQ2krQTREa1pvYkg1M2dTUkxpdXVzQTRQ?=
 =?utf-8?B?aG4rVHl3azhTcU1QQ2JRWWZMZzA2ZDRqb3BUVjZsUXk3ajlOUGMzVUdwTFFx?=
 =?utf-8?B?b3dVNnN4OUdldU1qUW8zU3FjQ2hUL09iOVJ3Vjk2Z3VIQTViVmxlektzWCtE?=
 =?utf-8?B?bkJ2K0xXTm1CYmZnTldNenY3bS9iYXYrR3Z2M0xmeWV4eWE1ODIrY3ROM09l?=
 =?utf-8?B?TzFXRUdTMHhNSXo0dEFIczZMa0dDMUgxVVM0aWVnR21DYjAwTVIwckFQTTVS?=
 =?utf-8?B?Z1RrTUFjNUYwTGhZMnZtY0Y0eXFqYXVlYWNvemZ6YXBta085OXFCR2hsNldK?=
 =?utf-8?B?OGkwVHErekhiMk80VmNMZ0VERmszdzdBMDNiWkg1aTJCd3QxQm9CS1RXNkRQ?=
 =?utf-8?B?Y1VnOWZjVkUzMVNNQjVXclo3SnR3QS9rcVNKZUFRL1ZSaGg4WnpPYkU1RVh2?=
 =?utf-8?B?dnlidGp3Nkl6UHFpL2lNY0p4UWhYTndsOGtXL0xYTmFYaDhlUWVWZEg2L1BX?=
 =?utf-8?B?VFVLTUVLTTlaL2h6K005U2VLRzVNUkd6NHVCeS8rc0N5cVREQmdtRmJZVkhL?=
 =?utf-8?B?L2EzREYwYlE2R3JoL3hFaGQ0ZjhhNGk2aGZtQ2UzQjl3MCtTMG5XaStDaEFW?=
 =?utf-8?B?bzBCREhXSkJXdmZsVWwrL0k0VFY0c0dLTmQzMVhhRTdRMVdOVHhMbnV3K2tK?=
 =?utf-8?B?TGlQUUFLdldNTkFDa1IxMnVHN2Y3Z2RKTGtHREZJNm1XNi81eEhiQ0ViSWt0?=
 =?utf-8?B?bVRDV3NMVU11WlJ1SnpTT1FDMmJFVGNzRG9kV1FLOHFmeXFpTHFpOGlGc2dw?=
 =?utf-8?B?Yy9VNC9kT1M3YVhmZWdMcHZxa1dzSGNkYkFYN2R0WDdsdHJydko1L2p6NXpp?=
 =?utf-8?B?SFFrczg4ZG9BV0R2SFhMZkdsM2xDL0kySEY1RnJoOUhORHo2b3I4NWJ0ZGkv?=
 =?utf-8?B?bFZWV0wyNUNFQkFoWkNURkpGaUYvZ2dkWk5RaXJEVzg3VlR3OUZWemlqckxI?=
 =?utf-8?B?aktTbGU4NmFyNWpGZERHSUpsbUVBdU1yTXlhSmJuR0dFY29kbTRVK3VNYVhL?=
 =?utf-8?B?ODV2YkFoK2FEYzYzSjcza3FYWXp2b3Brcyt3aWdOS1cxaERiNGtiTzRFNVI2?=
 =?utf-8?B?L0tqTG5aTUpDcDlnRER2aXlZU09WQVN5bnBDSTN3OWVKYURoK21TSWpIZHp3?=
 =?utf-8?B?aXpLQlZNYlQ3eU5VazFLZjIrQzJvMEtTNUFiOEw2NFk1VW0wOTVOUHE1UlhS?=
 =?utf-8?B?cWRzMUY5cEw2VW0xM0F0UmxIb2hqS1Z6OWtFd3p3aFdjeUhRUXFRUXEvL1Nx?=
 =?utf-8?B?eFdwYW13NHJaR0VPU2xXYXI2aXhQMGNkUDNoNm5LbUJ5cmRSQUNJclhBYnJ4?=
 =?utf-8?B?NXJpWGhVcmZmQUFrd0VESHV0YU8zQ3pDT2c0RllLUW1CNWZlWVdDZWFNZ3hj?=
 =?utf-8?B?SWZVQWd6YkxWU285QXZZdm9vd2llcEpKS21xN1NxZ0xvS1ZpRjk2TUM2K1Jt?=
 =?utf-8?B?MitXZ3ZzVXc0K240dUFiT1dsaDVRa2JIQ1U3TVppNlRsZytPUGZVdVVzVmJI?=
 =?utf-8?B?dFB0ZXNDTlJ5R0F6UFdFNUd0U2FlMEUxa1lCcnR5YWgwakMyQVdpQWowdCtY?=
 =?utf-8?B?bW9KRnZmbmJERVlEVk0zemYzRHJSQVZnVi9CUlpZQURhTGlXWUdhNUFUYy9D?=
 =?utf-8?B?TDZ5eUhGL3l1VWUzaDNnQVpTVitDZmdURWlPTEFNS01IVGxyNFdBU0YwSm8z?=
 =?utf-8?B?Skhvc0ZSTWNtYURGRVBMOTl4YVNUU2dlbmFVOHFZZWlTaXhkclZwVElWSWdz?=
 =?utf-8?Q?SJJ8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6429.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98b3c0f-7096-422e-ec70-08dd5a12a8a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 05:17:14.1213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QLr86B4Yf14Bp3VDkAA04oIyZagazTM6z84FVHUeyMwFf1cEBm/nG0sAPwh/uDkjobslWPsR+9u07wX+QelBmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHJldmlld2luZyB0aGlzIGFuZCBvdGhlciBB
TUQgcGF0Y2hlcy4gVXBkYXRlZCB0aGUgY29weXJpZ2h0IGhlYWRlciBpbiBWMSwgcGxlYXNlIHJl
dmlldy4NCg0KVGhhbmtzLA0KUHJhdGFwDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQpTZW50OiBTYXR1cmRh
eSwgTWFyY2ggMSwgMjAyNSA5OjAzIEFNDQpUbzogTmlydWpvZ2ksIFByYXRhcCA8UHJhdGFwLk5p
cnVqb2dpQGFtZC5jb20+OyBoZGVnb2VkZUByZWRoYXQuY29tOyBpbHBvLmphcnZpbmVuQGxpbnV4
LmludGVsLmNvbQ0KQ2M6IHBsYXRmb3JtLWRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBDaGFuLCBCZW5qYW1pbiAoS29vbiBQYW4pIDxCZW5q
YW1pbi5DaGFuQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBwbGF0Zm9ybS94ODY6IGFt
ZDogQWRkIElTUCBwbGF0Zm9ybSBpbmZvDQoNCkNhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5h
dGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24gd2hlbiBvcGVu
aW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCg0KDQpPbiAy
OC8wMi8yMDI1IDE4OjAyLCBQcmF0YXAgTmlydWpvZ2kgd3JvdGU6DQo+ICsgKg0KPiArICogUGVy
bWlzc2lvbiBpcyBoZXJlYnkgZ3JhbnRlZCwgZnJlZSBvZiBjaGFyZ2UsIHRvIGFueSBwZXJzb24g
b2J0YWluaW5nIGENCj4gKyAqIGNvcHkgb2YgdGhpcyBzb2Z0d2FyZSBhbmQgYXNzb2NpYXRlZCBk
b2N1bWVudGF0aW9uIGZpbGVzICh0aGUgIlNvZnR3YXJlIiksDQo+ICsgKiB0byBkZWFsIGluIHRo
ZSBTb2Z0d2FyZSB3aXRob3V0IHJlc3RyaWN0aW9uLCBpbmNsdWRpbmcgd2l0aG91dCBsaW1pdGF0
aW9uDQo+ICsgKiB0aGUgcmlnaHRzIHRvIHVzZSwgY29weSwgbW9kaWZ5LCBtZXJnZSwgcHVibGlz
aCwgZGlzdHJpYnV0ZSwgc3VibGljZW5zZSwNCj4gKyAqIGFuZC9vciBzZWxsIGNvcGllcyBvZiB0
aGUgU29mdHdhcmUsIGFuZCB0byBwZXJtaXQgcGVyc29ucyB0byB3aG9tIHRoZQ0KPiArICogU29m
dHdhcmUgaXMgZnVybmlzaGVkIHRvIGRvIHNvLCBzdWJqZWN0IHRvIHRoZSBmb2xsb3dpbmcgY29u
ZGl0aW9uczoNCj4gKyAqDQo+ICsgKiBUaGUgYWJvdmUgY29weXJpZ2h0IG5vdGljZSBhbmQgdGhp
cyBwZXJtaXNzaW9uIG5vdGljZSBzaGFsbCBiZSBpbmNsdWRlZCBpbg0KPiArICogYWxsIGNvcGll
cyBvciBzdWJzdGFudGlhbCBwb3J0aW9ucyBvZiB0aGUgU29mdHdhcmUuDQo+ICsgKg0KPiArICog
VEhFIFNPRlRXQVJFIElTIFBST1ZJREVEICJBUyBJUyIsIFdJVEhPVVQgV0FSUkFOVFkgT0YgQU5Z
IEtJTkQsIEVYUFJFU1MgT1INCj4gKyAqIElNUExJRUQsIElOQ0xVRElORyBCVVQgTk9UIExJTUlU
RUQgVE8gVEhFIFdBUlJBTlRJRVMgT0YgTUVSQ0hBTlRBQklMSVRZLA0KPiArICogRklUTkVTUyBG
T1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UgQU5EIE5PTklORlJJTkdFTUVOVC4gIElOIE5PIEVWRU5U
IFNIQUxMDQo+ICsgKiBUSEUgQ09QWVJJR0hUIEhPTERFUihTKSBPUiBBVVRIT1IoUykgQkUgTElB
QkxFIEZPUiBBTlkgQ0xBSU0sIERBTUFHRVMgT1INCj4gKyAqIE9USEVSIExJQUJJTElUWSwgV0hF
VEhFUiBJTiBBTiBBQ1RJT04gT0YgQ09OVFJBQ1QsIFRPUlQgT1IgT1RIRVJXSVNFLA0KPiArICog
QVJJU0lORyBGUk9NLCBPVVQgT0YgT1IgSU4gQ09OTkVDVElPTiBXSVRIIFRIRSBTT0ZUV0FSRSBP
UiBUSEUgVVNFIE9SDQo+ICsgKiBPVEhFUiBERUFMSU5HUyBJTiBUSEUgU09GVFdBUkUuDQoNClNh
bWUgY29tbWVudHMgYXMgZm9yIHlvdXIgb3RoZXIgcGF0Y2hlcy4NCg0KQmVzdCByZWdhcmRzLA0K
S3J6eXN6dG9mDQo=


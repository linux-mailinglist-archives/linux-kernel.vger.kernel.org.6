Return-Path: <linux-kernel+bounces-374580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342239A6C62
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3ED31F23C7E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5334E1EABA9;
	Mon, 21 Oct 2024 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qRg1UaQK"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7730C1F7092;
	Mon, 21 Oct 2024 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521614; cv=fail; b=OTX3zxKgJmgT9nZ9l8tK03llmBvsjI3td/oxQuXaVNf7UpV/wANI2fWrISgY4Tho7Axiy1BBCy3aF03lc/9/k98+vpCDoNKSK+NpDA/ozA78rXYHbGAAZkPYXdXsRvcDLKg2BOc5xm/tDzRaj4WNVmA2H4g28Zg/7mEBjkvRUkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521614; c=relaxed/simple;
	bh=og5KDLMp2KK8nk92QBvR2dsWb9vDzIX2Pb0a8UgNqls=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I0u5rG93oGKLCcGfXiQs/IvSAHW4HI+k/WHE3uEvl6vAKU8DhGc76uzxWfoAzAExbpRsnw2uoBurt/Oi9dn4PoVkJpJAoLwJuLHeDNhoY5/anYty0V9HgBgjTze3xz/tgIYzfrRfMRAmYblH0lIIuyNBuu6KYr5odSE+Nb+YGwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qRg1UaQK; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTf6wMOmp/vmyv40k9sWM9BF96J3Hr0nAlN5srPVqZDu1X6eDdnfI6KJoVwoWai+KXzYp3cZ7TnMVgwAhdZcarZqoxPJsd6uxNd9TK6vdnIoZgg/pvsD61JFawmmBvctu1Y+O1CQZf9K3Zxhj0cJnOVLjebOO0mStYGOtYxP4iStHrWzTaDvT/oCZbKG2cUd+rUkB3g0EpPjbuowq09vL4R6IB28t6W9jfvq1WVnLz6bzoEsdBStWOHSZ+NV6qUHHIe14ml869ZJmuqU5Aax95/v4xVr3j2KtOp1B1lRD1o7k5Y1INBD06VGg2rZaNjJv9WLAUjZrBKrXDpxuzqRXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wzT9wNCPSMj8Zf5EC+ks7bZ7vUVCU/HWaTgHojzVf8=;
 b=J8BoU1FwwzCed3ia6gYPlfkwu6hq2LXcVZdbkJTyMbtnlWY+b4MlrdQCc0c5us/F9YSAVgMiBBLn1gent5P6FnatBz9tI3H7bPdXG5m0OTlHvbSKJIxGisrQotpCXeUu7c7m2C3lraFLmREpcdCLodQOUVQVI1WaC2cNfTf3Rlc5lBTt6by1z7TG2tPBlefQh/QW9mr7Fbaq+ymAeDBUNuhGTqkg04Ykman98DOZesueO92U8fh9h07BKx7sk4LO/AbYS167RI5yheByKmCTWktIAPcGERpBKBTj1vzDJfXm0qerXseZi25Ts/bWKotLvuuh9Ifn8SbvfZYWklASpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wzT9wNCPSMj8Zf5EC+ks7bZ7vUVCU/HWaTgHojzVf8=;
 b=qRg1UaQKS2rBlWT3TeVMMYEnNnIoK8oVawHnN8kUoCh4FjaIV5tuHvUI5kdZ2MTSxaG6unaCuJF4HHqPvrz0vtpSsLpWvKyRCp4gyayFAoEspRVuJGZUQJWuMMvfPkwt8lnJkfm1mROuZ8BkgEoRqO2UR9OkcEKjGiXK+IyIvFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 14:40:08 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 14:40:08 +0000
Message-ID: <cfa7ef63-feb2-4afd-b05b-76335af888dd@amd.com>
Date: Mon, 21 Oct 2024 09:40:04 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 17/25] x86/resctrl: Add the interface to assign/update
 counter assignment
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1728495588.git.babu.moger@amd.com>
 <86c8fd4db89f264b1382cd22d7cf53c4510bf07a.1728495588.git.babu.moger@amd.com>
 <367f3877-e23c-4115-a004-1480ad2ab17f@intel.com>
 <78674f8c-963c-c6bb-ce8f-470d068299ca@amd.com>
 <c36e0c76-1666-4a31-984e-1ee6aed2e414@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <c36e0c76-1666-4a31-984e-1ee6aed2e414@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ce9b57-87fb-480a-7543-08dcf1de4283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWlXM0Rac2RvWWpSUGM3QnRoTndDMDhWOGVJUGdZS3V5cEpBZUdVWXBqNDgr?=
 =?utf-8?B?dC9DV3pINlhNdjMxQ0IrTVo0NmZ0em8wRGlPajZYOXNOVDRrYzdkZ3V3SWZG?=
 =?utf-8?B?SHlxVkoreG04VG9iZVVwd0toK2N2elJRem9pMzJyYzVTZzFOVExodk50R0JG?=
 =?utf-8?B?S3h2c3YxQ0hJWEM1RHhlem1ldG5kTzYxYWpXYXFMbDVvakhnVjM1YWNGaFJW?=
 =?utf-8?B?ZVd3M2ltQlVlQlQ5S0VFUWo4c283OVZUdjl6bisrMUQ0cjFPUFhYMGVxY0JK?=
 =?utf-8?B?a0UrbUtNYzhMVmNVdkJhM29SaTdiSDY3SmtoTFlHZDdFRXc1c2FXQWdMdmFR?=
 =?utf-8?B?TGRlNFYyR1NwdGVEbzlndW9GWkFMWWtQbmUyc2k2aE5WaEw1am9tTytoWW5O?=
 =?utf-8?B?N3pIQm94VlJVaWtMeCszV3JORDhDY1BiUkw0bnB3V2tXYVc0WW1hZ1A4Y1dZ?=
 =?utf-8?B?WTFLQkxVcGMrbFlGUDlOL055dm9sWFBCamg4c1dDMklNTDdQcGVxL1ZTLzdE?=
 =?utf-8?B?NWVrR1J5MEw4S2hsT3F6dHNMUm03YjJhQnVwWVI4YmZvT1VUWisvR1MzVDBG?=
 =?utf-8?B?ejVOZi84dFJrTXh0ZEttYWRlSUovSlRQREpKL2pFWTRTZE1QcXhReHdvSkRo?=
 =?utf-8?B?amE1ZmUrblQ1aUU2eER3dXp6ZHBmVDR3THhJNGpWSmxybEVSTTBFeXJVY1FM?=
 =?utf-8?B?aDJhaWFLbEtpM0FSeUxCOUhuRGx1MHFEeitFYmxsQ3NiSFVSK2d6QmdjRGpY?=
 =?utf-8?B?a2s3eG90Y2hWS0dRN1N6V0NOa01rSnRjbitXNFNONjNaN1U3LzB3cDNRbUtV?=
 =?utf-8?B?cndPbG0rc1VFWFpHR2I1bVIwZFl2YUszdjRmaUFjcW9NWXdCQjVvTlFDKzF3?=
 =?utf-8?B?dmhRYTAvSnBXY20yaXF5MXplT3NxVzhqUGRxOUJKU0xEaEZoWXJSN1NWaWtF?=
 =?utf-8?B?dFg4Z2RkQlg0Nzd1R1VvWjZzdFNNWm5BQWZwNTFremNZNHRTSlMzc2NET0xJ?=
 =?utf-8?B?T2VoQUZtblM3N3ZYV2FnMDN3UW9weW9MTUJBbVhSZGVBZVVrWGhTTWZjYmlH?=
 =?utf-8?B?THRlMDNtbHYxSk9lL01GMGFwbmpQdU9PcFNndC96aStRS0p0R3pES1dvUStn?=
 =?utf-8?B?RkkrQTNPYUhxSk9HZExxVDZjQ0xlTm1lWWNQRnAzSWRKVGNLR01wM01qc3kr?=
 =?utf-8?B?aG8yT2hqUzIyOGdlRjVCd2kvYlRVNDVuMDlGemJmaUxUSVg3bVpBeHQwNjBq?=
 =?utf-8?B?cXEwbVRNbkVlVjZMdnYrMlRlbGhGNUl0RzJ6R1p1Ly9mMFlrRGg4cEFIWXVj?=
 =?utf-8?B?YjlicUoxVVhYQ01TQ01rQWpEbTJCMXd4YW1mTE11QnVncmhmckx3cXcyWUVt?=
 =?utf-8?B?QWNQaGV1aWw4c3hTN2xPUjc2NTFhd0dYNDBIblJDMzdoNCtCb1pqOW5EcFMv?=
 =?utf-8?B?U00wcnJMZ3I2MWhKcndRV1FVOEJTNW9PL0x4elVVM3FKYjNrY2V3RWhtWGV0?=
 =?utf-8?B?S0ZCMVNrRFBCOU5CYUZFemdveUcxNW1Ka2pVbmpxVDlrUzZDb3pJeHVUU01z?=
 =?utf-8?B?QkF3Q0ttaGxnQWZSTmVaMVprSGVvQ0V2MWdiNTNyMS9sMlF0cVZlckVzb1ZI?=
 =?utf-8?B?cjJjN0NVZHJrRlVsdG85citWWElFM0pKalpuZlNmblZlOE01QWNnbnArUVZk?=
 =?utf-8?B?OFZjSExPOHIwbDJhdUdjaEJkUTNGWDlhYXM5dDdXNnMzc3JOcHQrTlZKZmUw?=
 =?utf-8?Q?dHxRoVNMK7RtZSIPXzoOacGaJtCiwgNp297CxtD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3ZlcnRRUURsTDJZdXlqVHlYYVdraWlNOXhtQ0k0UitZcmhYZXRKRVZPbFJu?=
 =?utf-8?B?bCt5MnFobS9Ba3VweW13WU5LSWl3clBsdWJFckRWLzlLblNmUUkvY2NBUDZ5?=
 =?utf-8?B?UkhNVldFTUFaUngxbldoVEhFUTRUakNZZHlDNUw4SXJnTHhTL1RFTDNwdnZX?=
 =?utf-8?B?NndzK1hlYldOeStoVkRWcUJQaE8wbGNaNm95K2tLMk5PWmVnWkZmVDgzY0tJ?=
 =?utf-8?B?Wkl3ZE9wYVRLTTRIbDllNHIxZXBHeWhEdTZQQkJvQkZOSzVoZlovSXAzbUE2?=
 =?utf-8?B?S1c0ajVobXpHd3RFVjdvQnh3d2t0RE92bHZ5N2M4R3ZDRmw2SmdaeWRqUW14?=
 =?utf-8?B?ank0ZU1aZ20zUWVScHZjRWVTOSsyOEdUSUwyT3NuQlpCR3RNVVFVN1kyWnRP?=
 =?utf-8?B?TVhRVnVvNHJ0Q1E1L2N1LzRkb2RhVDg4TWlycWlyZ1F3Szc2OWdPZnBIWUlw?=
 =?utf-8?B?ZDRsbjRyQ09PUlp3MGU4cEs1YjNWa0VUYVNNSVYxWnRmekQ1dk9GSWp6TVNm?=
 =?utf-8?B?RjUveTcvTkY1OFJyVzhOOHZicnR0NnIyajBNZTl2U3pUQ1ZIZmU1Q2RsTWdu?=
 =?utf-8?B?WXNiSnFuTzJUYUE1L1pheXhkdzdYWDJ1UG8xQUxEVUtNNWxMVzdTWjVSTlVk?=
 =?utf-8?B?dFRaQ0ZkZnFKSEF5emthWldzVlkrVllaUm9MSXpXMVJOWnArQ1o1a2lqK2hJ?=
 =?utf-8?B?emtSV1ozKzltZExXSFNTU0RiL2k1VWhCU09FWEMwQjdOVVd6QUp4TE55Z3lT?=
 =?utf-8?B?dmpBMklxQkpteGFzaUFXekIzMDNXYzQvMHBxclEzdkM3YnlFZWdJeDhHVHV5?=
 =?utf-8?B?TEhBYjBzQXBGZm8reXprcUxoYSt4dEFTT1Z6UWlHakVXWlZpMVVoTHRSdTJo?=
 =?utf-8?B?cEdWbEIrdzh0cldEUzBGclczenFYRkkwTHZmM0JmNlNiQnhTbU04R0pUUGIw?=
 =?utf-8?B?NHRxNUw5aWFFY01UbW1IVCtLYXRNT0ptZnZ2SXNHQlJpTlJFYnVYQWhiemhI?=
 =?utf-8?B?dmV1ODRxRFpHRURzM1BJdzVYVUt4T1E4aUxZRHloQ2RnRU4xNVFTajRRbE1P?=
 =?utf-8?B?Y1RvYk5rMmJDa2VMZzVWZEl4N2EzZjhUOFVMdDNhR1hOUUxuOHFrUkJzbFJp?=
 =?utf-8?B?NnJsREMvVUR1dlZTMnlaNWttcFl0OVZrUk1oZG83cktkN3pkSmJUTjhGY05L?=
 =?utf-8?B?YWtUM0JUMEFZdTUyaUlWKzd4Tyt4RmxzRklJOXFQV1lZREhOWmdETHRrTGpC?=
 =?utf-8?B?Sy9OdEVNcEdDd3NyQUhRNmxVaklwVyt4c1hraGNHekVJRnYraXIwckNUQVZJ?=
 =?utf-8?B?a25IT0dyM1g1aUxEZDUvWm9ueW5oOFJxV3o2OWsrUG1FbmNXV1VydThkN0Jy?=
 =?utf-8?B?bHdUdXl3MWlDSXFteExoUDE5UDZtM3FGSDNPOTh5OUkrYS94bmFlcTdtcEgw?=
 =?utf-8?B?MmtHUFJFUURWdnp0Mjd3MEVSV09ZNTduODBYSlcydEVud3JxVUJLeFQ4c0Zn?=
 =?utf-8?B?OEFLT3lRWllhQVEwakVkOHpkUElBL1FYdXlXazFXZVBjWVpIQ1JvZEZJeGk4?=
 =?utf-8?B?MEFmMEg4MnJBMzV4eDZZUEROZi9taEI5SVNNZlBoRndZRVg2RnVOMWc2VDVC?=
 =?utf-8?B?cm9hcy9VWXd1VGFNSTRORXR3SkZPYTYxdytvM2JPNURVZitBYTZqRkI0K1dF?=
 =?utf-8?B?c1V4OGJqZUF5VjVLa2NKS0hJRk1tNzlwZnZxOEFWU0psaEJ3VFRxTC94TnhS?=
 =?utf-8?B?ekxRd1JGT0ZGcERLQVRoQk1HWUw3MmxEQURlSk01WUtRSE1xajJPZmQvV2tO?=
 =?utf-8?B?L0V0NytKcGxwYkh5Q213UVg0RXZObDRPR3M4Wko0eUxROUQrTVovMmRiamdK?=
 =?utf-8?B?YjI1clFQYnZLRnFQb2pXL1Q4VU5YbmZ1OFJlRy9tYUdnbUlPWXdMUnY3UDZ3?=
 =?utf-8?B?blBZRGdZT3dFWW94RGVNUGNaNkNJWHluV3pEanUxNjNuNzFkekRFVGdhd0VO?=
 =?utf-8?B?dDNrZWoxWEFXZFpHeXprcDJHTFdqaUVJN0M0bk5IK3NwK3NrTkI5N2FDQ05q?=
 =?utf-8?B?dXFhbXlVcTRWamVMRWZWczdUUFI0R0NPWXpQdG5pU0d5Yk9ZUUJaYU1kS083?=
 =?utf-8?Q?NlyI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ce9b57-87fb-480a-7543-08dcf1de4283
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 14:40:08.2981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oG3bzJRA88B/NsaLuz9wrdW+oVuIQHYlVrpfA934MaAkGftqcZ9tIkzjbpY8Hx+e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5805

Hi Reinette,

On 10/18/24 10:59, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/17/24 3:56 PM, Moger, Babu wrote:
>> On 10/15/2024 10:25 PM, Reinette Chatre wrote:
>>> On 10/9/24 10:39 AM, Babu Moger wrote:
> 
>>>> + */
>>>> +int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>>>> +                   struct rdt_mon_domain *d, enum resctrl_event_id evtid)
>>>> +{
>>>> +    int index = MBM_EVENT_ARRAY_INDEX(evtid);
>>>> +    int cntr_id = rdtgrp->mon.cntr_id[index];
>>>> +    int ret;
>>>> +
>>>> +    /*
>>>> +     * Allocate a new counter id to the event if the counter is not
>>>> +     * assigned already.
>>>> +     */
>>>> +    if (cntr_id == MON_CNTR_UNSET) {
>>>> +        cntr_id = mbm_cntr_alloc(r);
>>>> +        if (cntr_id < 0) {
>>>> +            rdt_last_cmd_puts("Out of MBM assignable counters\n");
>>>> +            return -ENOSPC;
>>>> +        }
>>>> +        rdtgrp->mon.cntr_id[index] = cntr_id;
>>>> +    }
>>>> +
>>>> +    if (!d) {
>>>> +        list_for_each_entry(d, &r->mon_domains, hdr.list) {
>>>> +            ret = resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
>>>> +                               rdtgrp->closid, cntr_id, true);
>>>> +            if (ret)
>>>> +                goto out_done_assign;
>>>> +
>>>> +            set_bit(cntr_id, d->mbm_cntr_map);
>>>
>>> The code pattern above is repeated four times in this work, twice in
>>> rdtgroup_assign_cntr_event() and twice in rdtgroup_unassign_cntr_event(). This
>>> duplication should be avoided. It can be done in a function that also resets
>>> the architectural state.
>>
>> Are you suggesting to combine rdtgroup_assign_cntr_event() and rdtgroup_unassign_cntr_event()?
> 
> No. My comment was about the following pattern that is repeated four times:
> 	...
> 	ret = resctrl_arch_config_cntr(...)
> 	if (ret)
> 		...
> 	set_bit()/clear_bit()
> 	...
> 

ok.


>> It can be done. We need a flag to tell if it is a assign or unassign.
> 
> There is already a flag that is used by resctrl_arch_config_cntr(), the same parameters
> as resctrl_arch_config_cntr() can be used for a wrapper that just calls
> resctrl_arch_config_cntr() directly and uses that same flag to
> select between set_bit() and clear_bit(). This wrapper can then also include
> the reset of architectural state.

ok. Got it, It will look like this.


+/*
+ * Wrapper to configure the counter in a domain.
+ */
+static int rdtgroup_config_cntr(struct rdt_resource *r,struct
rdt_mon_domain *d,
+                               enum resctrl_event_id evtid, u32 rmid, u32
closid,
+                               u32 cntr_id, bool assign)
+{
+       int ret;
+
+       ret = resctrl_arch_config_cntr(r, d, evtid, rmid, closid, cntr_id,
assign);
+       if (ret)
+               return ret;
+
+       if (assign)
+               __set_bit(cntr_id, d->mbm_cntr_map);
+       else
+               __clear_bit(cntr_id, d->mbm_cntr_map);
+
+       /*
+        * Reset the architectural state so that reading of hardware
+        * counter is not considered as an overflow in next update.
+        */
+       resctrl_arch_reset_rmid(r, d, closid, rmid, evtid);
+
+       return ret;
+}
+


> 
> Also, I do not think we need atomic bitops here so these can be __set_bit()
> and __clear_bit() that also matches how bits of mbm_cntr_free_map are managed
> earlier in series.
> 

-- 
Thanks
Babu Moger


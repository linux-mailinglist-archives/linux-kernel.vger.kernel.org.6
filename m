Return-Path: <linux-kernel+bounces-568409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD6DA69500
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E27B1895E28
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72D81DF74E;
	Wed, 19 Mar 2025 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OaqT77KV"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203251A287E;
	Wed, 19 Mar 2025 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401858; cv=fail; b=O7WNv2Va+rW94n1tNNhZ/X6oN1l/5uAZtlEnKX9IS5XeFxRyryqr9Pn7/YV66ZqWjBKi0Xrci6YasUBWVOCKc6LG6S/7CV1eq4WE22ASisNwXfMwTovNA7DhPQA7gtST0KvhsDnGBPa8UAtQZ2mWPZukJkcoP17OHazdERDJrEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401858; c=relaxed/simple;
	bh=YcSNkS+IDfAs8vlm4ZyVneYyLVSxicW37pszuqOaSJU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nu3iT9Txv3PCTs2xEdgqNZHNFe7FRmLI9RuPCzMIht58vmNx7HYMUiOVT+L6yQ2uwYi5Ip5YP+M2HqciBcPnjhstmsZOUrZEdwHGdN16VMXTFjYSqeBld8b4V8k++qQhthlkRKLn/wuWuv0V82enB0C8ykT6XvIp0LfaHbKnxTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OaqT77KV; arc=fail smtp.client-ip=40.107.212.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeBG4mhsYglbEx5EfmtuUqGrsi4wMLMJHlwIe29ejIQ7WNEY1DHVzk5YGNaxoPIigR8yTX7Yg4MSQCJYxhN7s1tKcCx6xpwX93keRViwA/lsho9Axna00vPLDNsLQnWJMCZofE2LSBwEUGdXLOd8lnH06jUx/tJgimaln8wwTRGqLkJxkh/gf32sHGHhUpIl2SWi125kNZ7U3FziKKGPiQP2BeYNhcIYuETdPT7129wLzKBgfG4dUS72WVwy49H1Pm9PMPyia/6jy5F2PE7z7hnIeNSYXZwE/9rCFhTU1dSeKTGH/Ke0fqOGaSTXVbDa/kA33har1QhD+CiNshY8NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvXnsp0mPfGZ0/CSmXYmntrjOlmaG8wDlHwpC+0UJJI=;
 b=jQW/DXDKN1rF51pJ+5hqWEE3O850094qXz+vlKoGYgmK/AUNe3fRAdpEahbkVFld8OYUBmp5MkaF1cSMBrqYW0BJmRnJRGxDi/2apLRq9ZZVxz1sFruKD8JhgIPBcEydsidBEHIoBuqnfuvRTY9uJx/Q0fJ4bt1YZp8wV0Ej1uAdfK7viiSuvp3jL1Lj4BM2/7TC/VejpTM9gCWuDoixc/NvM7Edd5xT2T/thOqUV0uWcwSBDJyi1h5KKBTMYkK2v0e6afkwWHQIfP3pHauaAhP7ijhvXsFED+8cUABF669dI4GWr49aNJyOXkhReq8LcYHuMjxA6nceudJTHVtQwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvXnsp0mPfGZ0/CSmXYmntrjOlmaG8wDlHwpC+0UJJI=;
 b=OaqT77KV4yUPk7OWcA4nIhUBxRx6uDzRA+x3guVxAo+GQE+eCMWKEuW0zuXkB0/X+ep7O8u66Z+ZYCt9zhOcu4Bl2/g5eF+5OHH+robmwXmDkUWi25NxiTLCr+tU1tVEeSVx4wvJwDs9aEDfaygdJ/uAYBoL89044t/iYTgfovc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM3PR12MB9415.namprd12.prod.outlook.com (2603:10b6:8:1ac::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.34; Wed, 19 Mar 2025 16:30:52 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 16:30:52 +0000
Message-ID: <4a895660-c962-4598-ad71-01319e07b59f@amd.com>
Date: Wed, 19 Mar 2025 09:30:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] pds_fwctl: Fix a NULL vs IS_ERR() check in
 pdsfc_validate_rpc()
To: Jason Gunthorpe <jgg@ziepe.ca>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: Brett Creeley <brett.creeley@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <925355aa-c98b-4fa7-8e49-b97f6d551a86@stanley.mountain>
 <b9f49f34-1a69-41bc-8324-2e969e53f9eb@amd.com>
 <f391dc76-946f-45c2-af81-a5cb107ec783@stanley.mountain>
 <20250319162733.GE10600@ziepe.ca>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250319162733.GE10600@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0010.namprd08.prod.outlook.com
 (2603:10b6:805:66::23) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM3PR12MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: e0f9fa37-e45b-4522-1bac-08dd67036a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tkp2MzUzSDg4Ylc0QzViOU13UzZYVzhUYkpSYndSVi9iUnVRKy80WUtWbG1o?=
 =?utf-8?B?UTJhTTVYaGx0MTE4SlhzQ3I4QTBodGRUck1sTDBSSmU5ZzlxNUV2SHN1aUhh?=
 =?utf-8?B?ZmU1VEFvaWQ2Q1p0QW1jT2h0SFZ3Um5yR1Q3ZUxyZXArWXdCRVdaQ0Jtc1JN?=
 =?utf-8?B?Y2pMdjRlQnJ5UWhtUUpmb0QvZUZKTWpjd1RYYTAyVXNBZmhEbWtHVWVza0Zu?=
 =?utf-8?B?K294UE5QYnNXblJSSnJEWUVmcGtLQTA3ckpDWVpmWVJ4V1VJbWR1MVRzTlUv?=
 =?utf-8?B?UWNqWFhBa1FEOVQ0aE81eFhZcUZmNDkxN0x0dUZrSFh1OEZtZmU3QjBERmkv?=
 =?utf-8?B?Y1lrT2F1OU1lYWJpSUJqK3FRL0Njd0xNRVBud2xMbXBtdlFSL2hlM0ZyaGJo?=
 =?utf-8?B?SU52eWtvdFFmSVkyRXorQWxCWTh6cm9qOTh0QXRvaVBmT3lRNVJDQ1lnWVRz?=
 =?utf-8?B?WEFGK0p6dXEwY1ZZU0FOV25tb0tadEsxRUxTU2tvek1zZGZ6Mk1EeWVadUlW?=
 =?utf-8?B?MEUyYW5QeUtZZjBzUXIwR1JsU3hCaGpld2NmZUQyMjBMNkxRVlJQZllvWFhL?=
 =?utf-8?B?R2VrMS96bUo0RVdjL0c2VGY2cWZ5alI1d3NUdklCKzZZajJVZEdUa0g0ajFr?=
 =?utf-8?B?RldldnJuWGE1bEg4cnZUR0JGTkd3U0lVMHNOVlZCdzQ1U1ZVR2plU2QzZGFv?=
 =?utf-8?B?VlJkUnhhQ2w0U3JtVHo4VlRTWnlxekNVYlVrWDRYNzNTSGhPUmw1YThlRWlV?=
 =?utf-8?B?VnUvSC9GNXRmU3loWmVZR1Ztd0FPZWFtYndRaDY0b2dheEx2VDQwNERwVnJ2?=
 =?utf-8?B?R2t2UWtMZi9sUXFjcG54bTNWZklmQXV6bEYyQnZERi83c0FHb3E2cDNZbU1Z?=
 =?utf-8?B?US9JMWxiY1k3a2hvRmpQYiszM2JVSzViZ1ExM3RRclZEWGVyejUvMkF0VCtP?=
 =?utf-8?B?MnpwS3V5bFgrb3YxZHFIL0NobDNwdjJyVGZVL2o5MFcxV295ZzRJQW9IbWZz?=
 =?utf-8?B?QmZ5eCtmaVRTbmdEakxyb0N3YjkzTk1ZTHhtb05rTTFVUXZUbUI5eWRrdHlW?=
 =?utf-8?B?ZkV4QUovd2pIZUZvSUZFTlM3dy9KU3NrSWpiT2FhTnFrYWI5SXdubSttc0Nt?=
 =?utf-8?B?eml0K3ZEaXJ6YXRqOVVOK0I5eDdJd3NiUm50TVoyOU9VeVgxaTJ2SXlhRUEr?=
 =?utf-8?B?NUROMjFoRy9ZNmd4dWdWY3JvVU13Q2FWRlJtWjhoekZZMzhwbEZuWXh4UkNp?=
 =?utf-8?B?ZlJyL0s2ZmFzamFqZkRXdkxicUNsREV4T1IzT2lZZG5LMHkydkt2WFpqRzhm?=
 =?utf-8?B?NyswcDlhRDlSbUx0SDRtVXFJZFoySm8zV3I2TnpxaWRhWjJPLy9iUi9LUVp2?=
 =?utf-8?B?V042enJ5VC9VNHZDNlBrbHlic1h6YlQ2bFNKdHpkNmZPQUpaZ0Z3TFJSbGMv?=
 =?utf-8?B?Rm9QWDhoenoyaVdFUUxValdURHl6R0orTkllMUtubWF6cVR3VjlqQ0VvdFZu?=
 =?utf-8?B?WHhvQmVzUzI1cEtiSEFHc2s2Q2VEZlg3STdXaGFYRTQxalUvaG52RTJjRkxr?=
 =?utf-8?B?Y3U3YzUxMWNZRXZHb3JTbmtmem5GR3RIVHU5ZDhrSkR1ejBTMm9wUXp2Mngw?=
 =?utf-8?B?eWxsejhnM1QzSlJrUTZzZmhBMm9LS1BLMy8zOUFQM3FFNTVaK3ZtUmd5Zm9X?=
 =?utf-8?B?MCt4eWxscjVnS3lhdldSNWljZktRWU9ta3pvSUNPQTlQNmhJclNtUU4rNTFt?=
 =?utf-8?B?ZFR4MnJqMVBobkNkN0d4eXdDK0t1dmQzM2ErYThQelRLM0FsL05kN1R0V3Jn?=
 =?utf-8?B?WCtlTzNJQ1hib00rUGVYL0pyK0RQOU9MUmtHOXg3NFBlakc5cVZIcEljTUxO?=
 =?utf-8?Q?2E2nO/HWZAJBK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2pzSE1KZG5iZ2hBc0h4U3YzMnllMjdOdzRaWUN4WkVzWnoreW9OSDVpN01Q?=
 =?utf-8?B?ZWMrK0N2RkczRWg2NlN3RUQyM2g1VkhMeVJqTUtkN1dFblZDOUNIWWZ5VVNV?=
 =?utf-8?B?eW1kT1hPYk5PbUVoc01OWmRKaTd0amJabWRzVW0vMFNjV25jWm9FdStiRzVQ?=
 =?utf-8?B?VmxXbG1DeHF5WG1RaWhyODJMbzUyV3AvUzBncndBK1pMSitPVG5VQ1B1Rm03?=
 =?utf-8?B?cUZYNHp3b1phQk85bmE2Vnlrckl4OWVGQUYvdkJOTm9jNmM0VUE3RGVtQ3kx?=
 =?utf-8?B?b3UxVTUyYW1odEhOT0g3alVhQllzdHAyNVp1QmZoZWxsczVJMk5SSUhsUHYr?=
 =?utf-8?B?c250YXhUV05IWm40d0x4cTFHQmpJTGg1elJDbXNhWkdMOEJUR291Qk1SRDlI?=
 =?utf-8?B?Sm5GUUJZeHdiaE5MNEtwVTNjbjlDWWo5a2hiL2ErQnNaRzFTeWpIUGZTRFNv?=
 =?utf-8?B?UkM2WENZNTk2bEZNSkt3U2pIUXAyS3NNWEloYnowbVpKQ2FBSm9TRUhOUlFC?=
 =?utf-8?B?QkZxWTR5YjZkNWQrOTRQaW1CY21sZXBpS0JYMm1ROEh5ekJJZDM4Qnd5ZjRC?=
 =?utf-8?B?eGhDWHlQcUhRQThFWDhUTzRscUUzUlcyWmxFQVlrSmlKSVBMY21lK0U2c3dO?=
 =?utf-8?B?ZSthSExZbzl3clU1WGVDTXRycUJ2YTFneGhKM2FXOC83eW4xRUx5clBvTVlK?=
 =?utf-8?B?cmNCTjlXcDdkQVdqYU8yeWFMK1lrS016VTkwUHdwSzkrdkZNM1VUS0E5d1U1?=
 =?utf-8?B?N2laQnNnQ0RYL0tTK3ZXYTFxVzlZcm10WG5GdXA3cEpDWE1ESHlvQlRiamFR?=
 =?utf-8?B?M3NqbU1mejdWWmhQaGdFNUtPd2lxVTRVQWUrNDVYZVU1SE9ReFluN2laU3cy?=
 =?utf-8?B?aGZVdEtMNVJMbGJmaXJKYzZqSkFJaHllWGtuOXIyeU9wZUk0aE03SU0wNjdM?=
 =?utf-8?B?UjJRbkJmcklKQlRDRS9HZ0lUNDdCVlY1OStKdjk1cU03dTZ0aklydk9mSlQx?=
 =?utf-8?B?cS9KTk5hYUttNXQ2L3ova25ucE84MGo3aEtuZENvdDBLQlEyeE1wR1FueFN2?=
 =?utf-8?B?ZEZwc3RUaS9ISzEyd0FpcnpqWTZXSXA2dXlLK3NaeWt4S2NteXY0UlVDQ2NB?=
 =?utf-8?B?N0RqY3U2ckVJd2xwZlBBVHFDZXY4c28xRnc5TUtldFpTa0RVUDlROVdXOUhG?=
 =?utf-8?B?YWd2TngxNTA4VWNCTFJ6WlFnVXVwMjc1YjRWUGRyM1BxR3N6eVRTYkoxNEhy?=
 =?utf-8?B?eHBCaTZ5MWZLT29BQTVpa0xTV2JteFBnUmdacWFRbm54NkxHcHNlS1ltMEMx?=
 =?utf-8?B?QThybEZrVXh0dzlSd090QkZuenJHREo3em1kRFI5b3dIUEliTTFUUUpsc2c2?=
 =?utf-8?B?T3lRb1JBNnBOS3A0amJpaitNeTFBV1ZOOUJQRmp0Y0NjeEs2QUkzM3cxSmFQ?=
 =?utf-8?B?cEVJek9icWhPd1hMRStXZmlhanM2S3VDWFVnVzVTNWdiTWJOQXZKc1RNYndp?=
 =?utf-8?B?MTlUSWdqcTUySjJrczhjbTd0dE5uRGowS2lDNlZERWhjTVo2TTlDVjdwaXRq?=
 =?utf-8?B?VkYyQzJNZ1pmOVJJK2tYVm15NGNLNWxzWitZbk14ckczVldVWGo0Q1A4dXd4?=
 =?utf-8?B?Z2JLRTQ0L1hhMVdlR3ZxOGlYaHZtekZBVVcxYzhZTFlnRDdLa2toSDhHdzFE?=
 =?utf-8?B?Y3V3Tk95MEM0dDBNc3gzV0V0bzcvNSt0NXc4SFpQY0NlSlJqSWhtQlpnNjZ0?=
 =?utf-8?B?Q1ZoY1ZpdjNRcUloU0FiLzFYZjVPKzUvT1lHOVFiczVJRmdyb2VWWE92dVZw?=
 =?utf-8?B?ZHZnUXlHOVlUcXdNc3d3WUJFT2tscGU3Mk8wZytrSTNqeTl0aE5FSTd4YjJC?=
 =?utf-8?B?NGxxK1RJRDR4bUpyOXpPbmEycFNBcWJIR0d5bFM3azBxcmVsemtWRHRNcnRz?=
 =?utf-8?B?RlNvdzRYUXoraCtpSmN3M285Tll5WFVkZXZwVjFWbnNOWVJtS0xpaXJraVBG?=
 =?utf-8?B?WVpndUJNMGZyV1NaMjVlUFpmYVNmN3NpZVBTWUpVdnJIb2tnMUVKMXhwdVBF?=
 =?utf-8?B?QTgwS2F0cVl5UGR2b0U3NDhjbEhrUFdSKzBtSkpqUG1DSnhHRTcyZURDR0xZ?=
 =?utf-8?Q?OjQs03NHjaUvU2tnTD2tVgaYD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f9fa37-e45b-4522-1bac-08dd67036a67
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 16:30:52.6640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSOter/W3XGDCFH0F0p2M82f2tSxF/5U3FS4/ALCOsvkpajK5sZfsllzoa5ty/S9zLi5PnOLv+Dcrr4nPcI+Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9415

On 3/19/2025 9:27 AM, Jason Gunthorpe wrote:
> 
> On Wed, Mar 19, 2025 at 07:26:10PM +0300, Dan Carpenter wrote:
>> On Wed, Mar 19, 2025 at 09:18:31AM -0700, Nelson, Shannon wrote:
>>> On 3/19/2025 12:06 AM, Dan Carpenter wrote:
>>>>
>>>> The pdsfc_get_operations() function returns error pointers, it doesn't
>>>> return NULL.  However, the "ep_info->operations" pointer should be set
>>>> to either a valid pointer or NULL because the rest of the driver checks
>>>> for that.
>>>>
>>>> Fixes: 804294d75ac5 ("pds_fwctl: add rpc and query support")
>>>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>>>
>>> Hi Dan, thanks for this patch.  We also have this same fix in the patchset
>>> update that I was expecting to push out today, but you beat me to it.
>>>
>>> Shall I continue with our v4 patchset, or should I now be sending smaller
>>> patches to update from earlier review comments?
>>>
>>
>> I don't track how these things are merged.  If you were going to fix
>> it in a v4 patchset then just ignore this patch.  Typically in that
>> case you would fold the fix into the patchset anyway.
> 
> Right, please just send v4 and include a fix Dan's report.

Thanks, will do.
sln



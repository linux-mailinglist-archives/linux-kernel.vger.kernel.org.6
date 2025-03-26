Return-Path: <linux-kernel+bounces-576477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC75A70FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 05:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304153B1266
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB114155316;
	Wed, 26 Mar 2025 04:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dmeBBn3c"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A633A262BE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 04:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742961983; cv=fail; b=jLAW/Ffttfk8HhbelMyUd05ExdCO8rCD699U01ya+jGe5o3+vXmVPriYGM+vbA9xh23AxxgeQcwDQXHeAieQ2TlVYRL5G4wV+WJHyLbJpu9bKHMrSoXNBv4aLZN4eB65QddUXVFC/H553ZqjrT5YhNaUKWJ0eCCwnifEbXHlkUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742961983; c=relaxed/simple;
	bh=kDI1tbCTv5yZHF672vqlafs6cBKMDQo2vFn1wULF6lE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AGrw+nbGBdczLgxfQhrnR6DdnersyAGJMenYsKqHvFtySplO0Dh7whcazPzoLsEov/Vj8nU0ndqZytghWJNW9Sz1CKKZZqCk9v29/GTcL+DRJQt0B2xAMelBXyaStwTu1ObPNUCUJQ/L6VYkNm4KOURv2WDJaswjTgT+vKkf1sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dmeBBn3c; arc=fail smtp.client-ip=40.107.95.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZbHTI8xYtekPOANoZ/iaG82MRPAEO4vuCX1k1PEM04irC4TOa9hO39TBW7PMLf3X1GifJBiBZwhKin2U/HiSj8QP1LV/HUEcKiz2GZNs877S1/x39lNO3fgi9XEz23CkdgOKDXD5jXU89hhvaOkr6QbEw/GyPUKlstdurT3nSxm5k/2FI4folfyiC5NgcK8wuyi8sCKdPhyD7iYPHGoo+GY24JV9bUgi18hGQ7CET0dcsbrPb9+szrtsJzW0rruHVp1QDfnM+g0ZtPtDk7yZsBLyrp32B59qnN7vusXFfS0iaQbYw4RVQqaLxzbNhbgwtrw5MYnHGJHiK9Hci4ADw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDI1tbCTv5yZHF672vqlafs6cBKMDQo2vFn1wULF6lE=;
 b=KR6YHwEj8xGJyigccVRhHprnKNBeKKz/TFUbnNpTTwyVu+rK1LulTnY+2vrdJLJqQ7L/kfjjrrSeWTxIzIDI4WAhffEJQjM67J3rWP1sycxViR2WrJci0QI7lbl9VDd7WgoiF3DMpLZfASDD1PH112dbaKrSwruy72IZimhGMiv6hXkNUbrSF6fg7sIy5axERZvCxZdoa4Gu5bWEmWTxTZ9F0HZVdubAAJU6myWG4UvVmTOxAfJ8M+JFpGUlhuOi8wUW1AOWTC5mKM1TObIOmkBWV4TLbM1yU8hD93Bp9ZqjE4G1n1BW+S15Wl7Asdaivizz8kydA/8Dez5ccCmiHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDI1tbCTv5yZHF672vqlafs6cBKMDQo2vFn1wULF6lE=;
 b=dmeBBn3cCkmqoEv84n0ufDJBozupm7pxppXn6s4gHUt11ShFgll2KbIVYyVa7WCTfcSlfCFUan0Px+1BQDcqfX5+aIQ8Dy2VjInRZ32AH0IWcMfRPD+sOM89/jejIQsE2lhVDR6nRA+zwG71wCPBLFCyAs2swKulEEZ2b/Tr4Gc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CYXPR12MB9427.namprd12.prod.outlook.com (2603:10b6:930:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 04:06:19 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8534.042; Wed, 26 Mar 2025
 04:06:19 +0000
Message-ID: <1ab95590-9a70-4380-af43-6b21a158fa7e@amd.com>
Date: Wed, 26 Mar 2025 09:36:11 +0530
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH] testing/radix-tree: add cleanup.h to shared/linux
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: Daniel Gomez <da.gomez@kernel.org>, "mingo@kernel.org"
 <mingo@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
 "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "liam.howlett@oracle.com" <liam.howlett@oracle.com>
References: <20250325214049.87817-1-sidhartha.kumar@oracle.com>
Content-Language: en-US
In-Reply-To: <20250325214049.87817-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0199.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::9) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CYXPR12MB9427:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d34a3c-3be8-40c0-a455-08dd6c1b8f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlVQeFlLZjZ4T09NaCtkUTRmZ053QXBLVCtCL0lmQjlOTllXek8rY0xTR3ZU?=
 =?utf-8?B?UERiK1ZyczR5TnRZZ0lXUnhKTExpQ1g0S0loMWt3RzcydTUyZGFSYjZ5SktR?=
 =?utf-8?B?aXNGTjFpcUtCVUN6SW52ckFqMUt4QjlKQzlpZk1RQVpTSU42OUg2Y3lQdk81?=
 =?utf-8?B?bDZ4MXRoV2MvbC91SUxYMFkwYmFqeHZEOVJRRXV1cXJKR2JFdklGbEZGVS9u?=
 =?utf-8?B?YmY1RjdVT2RIN0I1SzVMSWR6YWp4TEU5RDNzc1M3UXpQUnpNRFdkM0pYUitC?=
 =?utf-8?B?RGxtTTFYRW5OWjNNWnlBbVFHZHRyV1NCb05YNDAvblNBNFRQeHUrL2EraWJp?=
 =?utf-8?B?UHpObXNadWdZaS85Y1VFSHpSQmtSZk1XMEVFeTQ5Qlc3TmxkUERTellFTEVZ?=
 =?utf-8?B?RUgvclduM1FUTnZrKytoZVM3WGxNMXpwcHZSQmppQzVENlR3U3FWVU9HcUNr?=
 =?utf-8?B?ektPYnAwOXI5K2lNTHFTbVFPTmZaOXk0ZUNxRVMraHdPWWhyenZ2azVCNTB3?=
 =?utf-8?B?MXR4TC93Q1ZvRDRaYnRob2I4dEVXQjFSOEVwZjNjV0dFcnZGdU43RjJiNTU5?=
 =?utf-8?B?Q294MUtMOWxKcDFGMFNOMHhYa3VXSjM2OXVMOTBtNW02TUFxTm5vdWVBSHlo?=
 =?utf-8?B?NmJteGpKTHZHYldsdVM5TkRXQ0xObUNDL3JhZkpkc1ZoNDNjVEwvSXNSa3Qz?=
 =?utf-8?B?OStpS3c2YVd2QUhSMjZnazBSdkxETXFKT3RSVmZWdGtya0pwRnZ0cDc5ZGU5?=
 =?utf-8?B?MXFiYlp5SkloMWdXTC84a2xqYzBXMzIyb3ZmRXEyMCtnanA4UnRDT1VORmVU?=
 =?utf-8?B?KzNPMElxc2l5R0s5UGRWZC96YUdZeDNWZENwTFhOZ1BhRXV4RXlSNHFHMm4r?=
 =?utf-8?B?bGE1cUVoVzVSOGwxMjNUcEpNdW5veEg0cVlncldweUJqaHNDd251aGtGVFo1?=
 =?utf-8?B?VzY4V2w1Y2RJOC82WXUrWmN2OEZYaUdUazVYbXZiQndRdXk5RGlpYm81d3pJ?=
 =?utf-8?B?b0poOGVwVEVvMXkzajJXTzU4dWpCWFptNHRGbWcrK0hzSXhFdjFJdXJ4dldu?=
 =?utf-8?B?b1BiQWcydDV2cGVCQVBERzJmSjdsODExcm44VnJkMGlUVURaOE9XYkMvLzVV?=
 =?utf-8?B?aHlqRVJZWjFQNmRJa1F4clZzYTVaUE94TkRKZWYzazlWNkF2ZFBnZ1NsZVlr?=
 =?utf-8?B?eWVpZkorYVdISnlwdWVpQndvRVR0aktXblZZZG55VDNmcjNXQjdhc1FOSG5m?=
 =?utf-8?B?RDlCdFEwQ29KR0o2VUFoc0prK0hEeFFIdTA2SXEyMjhoQngwRDJpNXhkcTBa?=
 =?utf-8?B?K0RaWjRDQ25ITm5RQzkvUXVTbCtKUys5bzNTQWpuTno0OCswWUszb1N3VktY?=
 =?utf-8?B?QUtKeVFJV3RqNGhwRXc1RlhqNm9nNG1BcW92Rk9jTWR5cElzMzB4VVhnUjhQ?=
 =?utf-8?B?dTcrSXdwNXNZclBLcFdra2w0dCtsNnFjOWdRaG9FQ1RCS0Mzbk5HNFl3K0JN?=
 =?utf-8?B?NWVuK3FUM25tNG9qc2FKZ1FEV1pkejU2ejBoUi94dHQyM21IbVFOQkQvMU13?=
 =?utf-8?B?YWlCeFo0TjRzdWdmc1dKL0hZTytkTkdsWVUvbEIrQUlzR1JTakVqK04rSjdR?=
 =?utf-8?B?QytLQm5yZU9oS1BJY1VmWnZPZlVLZ1NqaEN1aGRWd3J1Vk9tejJYK1NvZzlS?=
 =?utf-8?B?YnhtVllUQzI4cXBkUExjZElVTThoZVd4Yy9PcHJIZC80WDZyYWx4WVZtbTJ0?=
 =?utf-8?B?Ymw1VFZsVytnVkN2azZPSDBiak5tYStQei9YREpCcXQ0Y2RUY2ZyMjZoNGxr?=
 =?utf-8?B?Tk8xdm9neXdGdFREWlpSSzBpYVE3QnhYcGRQWnVVMkRuZnVzOURtcHJ1WGQ0?=
 =?utf-8?Q?K7zfEAG2qELWW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wk5DY0FtY0FiRjM0OGNsS3hxZWhXVytOUVUwZEdWdDBVQS9lV0s0dlduSWpR?=
 =?utf-8?B?cUlWeTkwTHB2b3ZBSzhleHE4aDVGeXNTSWQ5VWE5dFI4L1psRGl2WkpEVTA2?=
 =?utf-8?B?QUFGNFlZRGFFTVRWOW02eDVudnd6ODNBTmdnSkdoWTRmYVR4clJNOGdJN08w?=
 =?utf-8?B?cUd3L08zbmloakUzV1BPbTA5LzdiQUJsUW9aYlNVa2UxMktnbWtHYkV0MXpl?=
 =?utf-8?B?VTFEZDhwRHlLRHVEMlNPSHdjMTZSQVl5YmxaMEtVUXhXTHc5WVVndnVBdGhx?=
 =?utf-8?B?SXdWZlhjcnlPdWNVbHJJTzc1Ty9DNnR0WUhMMnNtSDZDNnozVmhGajk4cWhF?=
 =?utf-8?B?MjVVcXpSTWVuSEZvMWVjV3orZ1NzUWdLMXZnQWpYK2YxU2RoUHZmdnlRQ0V6?=
 =?utf-8?B?MG1PV2lGTGNVcWdEeEhUMXRNOWozWGZBUnVtQzVjVDdDSDZwY1FFdE5GT3lX?=
 =?utf-8?B?ZlVVSzArSFRYUi81Rk4rQUMwMXV0REc1QWF5L0xzZW5makV2L2VJdTg2aVZK?=
 =?utf-8?B?MysvRDhzQ014bDhGeTVxWlI1aXJXcUE5cGR0STdjVXhHSm5yS3p3ZENaMWUr?=
 =?utf-8?B?eXc3QVRsU2NBeXdoS1FCejRzd0JxTC8zTVBXTllDcUxkc20zd2s5RWxBcUdZ?=
 =?utf-8?B?b2FTWFdNekluQnlOSU9kMGh6OUlOU3pMYk1lNXBwOFlXMmJFVDJ5RkN5aFI0?=
 =?utf-8?B?WnFLTzRrR3dNS2pMalEzZXMwaHBlOFM0T2VtNERJdXVGS0hERUFEaitUcmZR?=
 =?utf-8?B?aC9yTk9PRXNKZG5PMUpNRnFtZEJBR3VSNy9oekRNUEg5V0V1cHUxSXhGWGFl?=
 =?utf-8?B?ZE1YeVNlOTdYSERjbEN1ZDJtRlNlR2Y2dW1kYzl0cHR3UGo2b01hRFdzMVBx?=
 =?utf-8?B?RzB5aUI1QmZmVjF3S05VN040c3ZwZ2NtSGRoYmxTRnFPS3BTWXRBVFMwZkZ0?=
 =?utf-8?B?WDcxVHpzQ1oxYSsyT1o0OWsvN2NXYTI2VnBJODREMlZ1Nm9HaW9ROS9yZTNI?=
 =?utf-8?B?d0FnRjVhMjFpWi9pbzFaTE1lRDQyOUlvRUd6QzMrMWFoanBBcUdUbit0UjUy?=
 =?utf-8?B?eXl0dStvaGVmWlZ2bVVNVzkvcnZEODR3QURSOGpTOFc5Q0IrKzdCcXplSHBu?=
 =?utf-8?B?OVN5RDduQytJNkZoSjlHRGlKK3RQc1I2SDl1Ym92eTkzSm9EdHdEU0h0ck5y?=
 =?utf-8?B?Q2lyU3dsYWFqSmhsS3pMbHZvS3k4U1AxUXRmNFZkdXlXVnYwYTVSbTVjRmhh?=
 =?utf-8?B?aUdYVUc3WGRXeEp3MngyN3hUUzAwbTBVQjFlV2ZWcXhNTnJwT3U2K3BUVE5R?=
 =?utf-8?B?b0psVWlWaTFSTjZwR09JQUpKVFE3YzIxU0FPMFpQcUEwRG92dlRPU1A5UjBN?=
 =?utf-8?B?WThLQjE2WGZBSEQrYkhIS1o1VnUrUzhFRW11R3dWUG5wTnZkWmdiKzdzOHZJ?=
 =?utf-8?B?V3hKMkJBY2NFVHV6MEcvR0MyMzBJOHJsMUpWUzNBYzJDa3RNamJOWGJFNnBr?=
 =?utf-8?B?c2FPc3lxVTNMNWk5N0VCL0QrZFJmWUoza1Jzb3VXSDNjU2laUXV0ZVcvT0wv?=
 =?utf-8?B?M1hpZzBSMTdTTW5vUnBPSVlxTGlvUUNuWVlRWWVDUVQ1YWxrVENBdlZvNDAz?=
 =?utf-8?B?VVV1VUVTVS9CajhoTGlnQjJyWXBjL1dDYk5zRm1BcGJ2SUVmVW0rZ2RYUStK?=
 =?utf-8?B?NlcvUTRYNUlISU44MmVheDNoWkE0VUtRdHBGRmxFTXllUUplQVdkOXZxdUZu?=
 =?utf-8?B?Y0dwWmpEMHRLdDN3cXh6aEpxZzM1ZkNqVFprRzNDZ1pIK3RHWXp5WTRYZXFq?=
 =?utf-8?B?cnZiaWo1SHY2dzgydmt2MHdUTitqMGZqWG8yV29sUFUxTHNsUDVFMExrV0hx?=
 =?utf-8?B?WkF1YnRLMVo0SkpFemg4eXVSbVNEMFlyZ1lHQmRKRnhYWm9WZkJpYzA5Ymp0?=
 =?utf-8?B?NW4xcDJscmRJdVpheno3QVRmV2ZMeUx2UmVlVkhRd0xxRURwbVNXOU1qMS84?=
 =?utf-8?B?bE8vQkk3RHczSTN6ZEc4Qzd5eTM1K2xRNmwyS2I3QkpQc08vd1ZzRS9IbnpI?=
 =?utf-8?B?aW11cnpVRWNNeCtabElYYkJqTUF1am9OSEdjQm1hS1F4QVpOVTZveTNQOG0w?=
 =?utf-8?Q?dCBbeu5aMbW856ZizlA5JUKjk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d34a3c-3be8-40c0-a455-08dd6c1b8f77
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 04:06:18.8125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnNYonhanG/zMLdWWxSNOSkw0TbTUMvWP8QoBZOmIEu/OPVJQSkFkKyJWlPypqLz/e4la05pkLjBVpCmYVOFZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9427

Hi Sidhartha,

On 26-Mar-25 3:10 AM, Sidhartha Kumar wrote:
> Create a cleanup.h implementation in tools/testing/shared/linux to build
> the idr code within userspace. This is needed after commit 6c8b0b835f00
> added #include <linux/cleanup.h> to include/linux/idr.h to build the
> userpsace radix-tree testsuite.

FWIW, similar fix was posted few days back:

https://lore.kernel.org/r/20250321-fix-radix-tree-build-v1-1-838a1e6540e2@samsung.com

Thanks,
Ravi


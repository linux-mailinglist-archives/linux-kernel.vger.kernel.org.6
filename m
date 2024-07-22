Return-Path: <linux-kernel+bounces-258644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22334938B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4439E1C21256
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0E1166308;
	Mon, 22 Jul 2024 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vo0rr2iI"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFCB1662E9;
	Mon, 22 Jul 2024 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721636305; cv=fail; b=hIZ+iqf/9nTPdmFM02JlHXfkPNcmNJfK5IvVw0Acizm47GhYXPH/kO7Vv2IaICgYqWJmjcfFYic5yN2CeP/+1K8N7CEEyXvS1+VYZQ5bjwJPyKgtXzMymP/s4vLTxVy4MaV5cg5G6997EFS9tc10r+pn6Hv7bATcUoOdbBR3is0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721636305; c=relaxed/simple;
	bh=b6+6lF+Gq/NAoR6CWKGQ5FKRs8r/4QDwMc7zdMmkdfc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=UXch3zreAzSdDJJ9w0rlZgiTeKuI+7rkd3YtNMX8NO1QCq6/bSSRKTuQu1MaEe1zJbfjXf+9HkY1zox/k5Jl5U40oJYUSnMd/j7+CaqnfLmySjvWN5xcAKMHGSAwO7LBMuI+1tZZpfvo5XwWp8DL5yayWSjYZCVZwmzwOvQiB5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vo0rr2iI; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K45mvdb0iXVy9i4vcvsEtt27YVn71v4kJAgrbcO30h3kTLsvrf5KlnpE+Glk4AsZRpBhTyQL/3/DdJdEAdhO/CvvCR7PZociwrH05c5A/zIRfPLDNn4NHkIRujTfj4Lh6FbNyh3D9jiABcTYEEya1ca7qbn0u9THvU6CLfRUE6LxJwDXABUDMkR4sfXGfJDPXPyz5jRIKJuLYtZv//aLw9B5hRQBVNFfj9HUelSPxi+Jw2qeuOdwW1yEHS68rrEjmsDEzcHLTSChrJEByPOkSSQEM5I8nTyTSY+bxn0IFm/8sOmUk8ZV2MoGnHNUNhd+T7ENGFHGp0Mjup4aCKUwvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDABx7JHr+O28SkfNAeQcTYx5GMU+IHMXiRX/XManNY=;
 b=DFljmhoaq7GCxpjI9D0yW74gtxJdkt4MivvOP5wxIS41lWeex0kkMQuWsDxs6Pv14jofET63PYB5XFQWXyMF9BIWZtz3MCWYXo/6xjVXkG0G9nxFvBQJLMB2UrhzpF5BLpnCPJiP+NBYHLfcLYbnlnPGanrvuHxVnLGNoyhkJ9CApXfk7HY0cgkZRNfLprguY0grSvGU7k/nXyL8P9t3lGuf4xcRo0h8oaufybFZECYgaIneluQXJGBKkrSYT2pwPsonkRiuyBjTmiLN9u/RPp32dCe5wep3DkAbaXSP5pHq7rY/3kbfh4wi+VxC0TVN70LrvrcsLcsagNHzC0pmzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDABx7JHr+O28SkfNAeQcTYx5GMU+IHMXiRX/XManNY=;
 b=Vo0rr2iIBRpxX+8y6qsvo979PCqKVVkpxC6UfCz11DBhj7kxkrq850Fo8SjJjXtGbHvYHuIHajCFT/V5aVSbTfQQL9+u8H7THluPIOvgJmbVwVdnM58dQX/Z7BupSaQweQE3eMKbT8ZDH+2uNaAl+gOzLrB9rFgF5HfwlpnAxAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Mon, 22 Jul
 2024 08:18:20 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%3]) with mapi id 15.20.7762.030; Mon, 22 Jul 2024
 08:18:19 +0000
Subject: Re: [PATCH v2 3/8] misc: amd-sbi: Add support for AMD_SBI IOCTL
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@roeck-us.net, arnd@arndb.de, naveenkrishna.chatradhi@amd.com
References: <20240717081027.2079549-1-akshay.gupta@amd.com>
 <20240717081027.2079549-4-akshay.gupta@amd.com>
 <2024071719-boil-curvy-48df@gregkh>
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
Message-ID: <526b14e9-60f6-980a-35f5-37529591a1ab@amd.com>
Date: Mon, 22 Jul 2024 13:48:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <2024071719-boil-curvy-48df@gregkh>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MA0PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::12) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|SA3PR12MB9157:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c753fc-3990-48d1-9c4b-08dcaa26d834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enJkY3J1emp6bVBRMC9DWmpHQThSOTREM2FWMThHc3NxWC81NllJN0diMHJE?=
 =?utf-8?B?Q084OVRTbHRsVk9IUUFvN3Yyb1EybGJPdzY2ZVVMRjR0YWgrS1RaTzFnbVRN?=
 =?utf-8?B?ZEQ0YzVUbUdTNm12VUhYM1ZqbW9qMXRGRnFuMHE1dmxUWk9takJ1bWRmQjEx?=
 =?utf-8?B?UExBVHRzSnhWcXVtdVFsK0k5M0JvUlJEeVlPRXQzQVY4SlFNQVJ0WXhjVXFQ?=
 =?utf-8?B?dFltblVFQlBQdk1yMWozNVc3RG1xSDdLWEJWTDMyMGZsZmZWRWV2V2N2WTA2?=
 =?utf-8?B?VGo0MHQrQXQ3N1pPamxWb0dBTEdYMEowUkc4WEhvazg0TE5qWkVxOWlpS1ov?=
 =?utf-8?B?ZWI0WCsra2hSck14ME93QTg1bzVkdTBVeHdZZnRPcjNWV0tBZFJLK2JjZHVL?=
 =?utf-8?B?V0pMSVArdGhaQ3lDcDEzUjJiU2pqNWVFVEtFcG91ZmVEdjNIK25LMys4eW83?=
 =?utf-8?B?aTBkMit0R2pzNEZvVWdIQllZbFVLNHhma0tQRldQck9lTVdJY3VKbUlnL1NY?=
 =?utf-8?B?YzhnZUtpU2UrTlJDVm05OGZaNVpSMmU4a2xlVUFnT1NhK3Q3dDBYZ1ZCVVBp?=
 =?utf-8?B?VzhKZytnaXZXTWhEWHEwaFk3NUFSdy9FTkUxL3NGc3Nuc0dFbGErQmF1aXJS?=
 =?utf-8?B?QnpKZ1NmRHllRk1qTUZZaitOMTRzZkppd3p2UkNUbFUzVmFqbzBySnYwRmdk?=
 =?utf-8?B?L3ZFQ0VQSUZ4S0phZnJjaWQ0MGhlM1hHRFVHS0o0c2paM1p4SThhVnptL1Fm?=
 =?utf-8?B?WFpPSFVxcENweWdsd3VJalRJdlZEWlpmVUpDeVE0cFFSNmdxRk5zRXdlcW1y?=
 =?utf-8?B?Tktka2hkaXVHZkd6a2tzWS9BeFgxaldTT2Rjd1l4SXRCQ0VlVjFhdFd6UGE3?=
 =?utf-8?B?OWpRSWNpOUx5LzhQL2ZlZkp6am9LRS9CN3lIUUg2Q2JRVmtPU1A0U1ZWU3R1?=
 =?utf-8?B?SUVZcVZKUlhzZUJWeGdRZzZCVDBraWxiWHJLaGdTQjZLWi8rU1B1enM4THBX?=
 =?utf-8?B?eWFmaUJqUHY5RXUvc3d5QUh4dGpPamV0Wi9RRXBZNUZ4bG1MM3ZKWVNkMnBn?=
 =?utf-8?B?cEZhaHRuUFR5ZytkaHB5WlVQZXFZQUwxeWpSaWIwRE1xZi9OM1p3VmVMekhV?=
 =?utf-8?B?MmxvUFpSRDhCd1g0YVNXVVNpUkx1b1UwNmVlc1NhdXFzMi9wdmlmVVZNZnB0?=
 =?utf-8?B?dHk1U2ZTdFVwbXQ0SXptSHBzSWhhSm9Lb3hHMHF0L0xWeVgyenNwcmJCemVz?=
 =?utf-8?B?Z05VeVBnMDFtWm1MMENFaTkrM3hpbVprdm9uZC9lSEdoTUF6c2NzekdySzhU?=
 =?utf-8?B?ZXQzQi9TaUpER05LT01vYmFpMWhwZ0piNW1NRGhGV0g4QkhIT0czZ1JlT3p0?=
 =?utf-8?B?VnRHcHhCVjNNeWlKOXQxYVFwWFQyaTJPb1RMZ0pBOExzSmEwellwT3lzNzJk?=
 =?utf-8?B?TVVtdmNXN216Nmk1M1FrTk9ZZ2UvZktXQU1VOGZMa3ROcEt2ZDVyOENyeTM4?=
 =?utf-8?B?MXFFMWFpUFc5VUt0S1RKbUhGTDVyclVYMXozUmhJRlp1RU5Ndm1OMWNVa2lr?=
 =?utf-8?B?MEs1SVFzMktZTUpOZGNYVFdSdGtOWkpJdmx0dEhVa0JadjY5WnViVkR4ZXJh?=
 =?utf-8?B?VTMzeE9jZWE0RG1qbW5BdW9IS3ZUNll5TmZmQzZFOGNqdi9XWGU4bWNvOHYz?=
 =?utf-8?B?MzYrQ0FqVUs3TXlKRkhxT1RGTmw5SEpaU1E1Q3I5TDZaajhTY3RGQTh3QzVV?=
 =?utf-8?B?eHova3k3UnMyUnpqZmlzcy9ncmtCd2tVeGttaDVVblR4YmZ2ajYxUC9JdjFL?=
 =?utf-8?B?bDlENjRpVk9ONVNWNTBtQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eldPdCtsaWNsVVBVR3JrZE4yaWZHOHRpeEZuWnpQYi9yMmtVNTh3RmQ3MUQx?=
 =?utf-8?B?REkvc01CcWx5WWRycmtrSEZ5MXcxdEFoU0ZDVHh0R2dXUDc0OERtNVVSK0J0?=
 =?utf-8?B?ejVtdzdhYzQwUGVMNkROdE5KTUpjQlBvcmxyUytpMkpIZExDc01PV3lhem1v?=
 =?utf-8?B?Tk9DUVhuaUtmUGlndWtiY3ZQcy9XSFl4YmFDWERYQ0ZoTkNSOUVOdktPNGty?=
 =?utf-8?B?MDNDWlczTEQ2cXV0aXFCckVQR3pHQ015Ump0RDN4NjFPbGRMdG5Vc2ltb0ky?=
 =?utf-8?B?SGIrVmdXMEh5SktaV2ZpTmw2dmJzM3BRZTBodG54bmRibEVXT2V0MnZaMTh1?=
 =?utf-8?B?S2VoYkxONTI2QVl4Mi8zL2c1U256bktNdlJTR2lTUDh5cGFycTRXb00xOU9R?=
 =?utf-8?B?a1dDU1NoL1FiSklZTWNSVHZXcldZUkZRS2ovSG1aS2JQb2plbjJESjRlL25p?=
 =?utf-8?B?RHlZeFNTNUtJWHg2VkttUy9sRStGajNrNWNzdmUreHhTVmJlR2RwWDFYTXpq?=
 =?utf-8?B?cGMyZ2hZajVLQXJYTlUvejJnSExRK3FEMDFrN2p0UjN4b3Z1L0hSbHhQN0pP?=
 =?utf-8?B?cFpFNHl5VnpqaElWNVIwOUE0RXk0YmE5YjcvcXoyL2paaE9nTGZjWXAySUhB?=
 =?utf-8?B?MEQ4NjRLWDdMSlZpVXdGVWdpZU5POTNnZTZDSXh1VEdDRkxWMG8ycTMraEZG?=
 =?utf-8?B?K0FGRFVINDJKdERNWXpCdnhJS1lMTk5Nc3FlRExURVRIdUwwTHp3WVhySG1o?=
 =?utf-8?B?bDN0bW1uQ29FQ3NDdWFOMWIvQmNTN0RReFZMeDBha3BoVlZGOFpwS3M4L0o1?=
 =?utf-8?B?UUlVcGdkMkpGM3VUWUdQZVhyZDQybGlEcE9QeDcvVGw4bFFXYXN0ZXdaZncx?=
 =?utf-8?B?K2xBNmlzdnpraGJTVzlkVjVTYXZ3OGo4WHcwRlJXY3BySWFPK2dyYVYxdWlS?=
 =?utf-8?B?NHVNSGtWQmtsanJlOXpIU3V2b3p3ODAvUUNWcU9wTE9iVWliYVBFcWJqendv?=
 =?utf-8?B?aHJuNGd3Zk85WGdxWFdJS2pWcnJVTzZPVVJ3Ulh3eVd3YlY4cmNTZDN1b2hi?=
 =?utf-8?B?blJ3di9FNXZZQ3N6eHpuYkc3L05Ua2xwZ21CRGtZWCszS0xpQ0FrTWlDa3BW?=
 =?utf-8?B?eW8wcFdvSzRUTGFXS1hrbUZOUkQ0NHlXaUVJTSsxQm1jdGJuVytRUkJxVFFI?=
 =?utf-8?B?dm4rWmFwb0YrbnVwbE0wL0tUOWRtOUFYWk94NUNDdGkxUnN1YVlnTVIxTTdu?=
 =?utf-8?B?WWZENmk2RDFyYlNFSnhHbXRla2NTN3lyMjI5SWV1Wkk4c1NONlJ0ajBFMmxq?=
 =?utf-8?B?TTEweXI2RUp6bHU3VWIyUzNaZjFoSjAvdllXdE56bkoxL2c0YkMxNG1JOFVl?=
 =?utf-8?B?N1R1c1p1dTVZc1lRbE53MlA1cmYvNVVlUnZ6ZkMzb3pQQXpoYU1UcmdoRVVi?=
 =?utf-8?B?QU1wMGZCK2wyekdpRVBTY3pVNk53YjBZYjZ6bzM3TytXL09HWVU3Tm5oVVVr?=
 =?utf-8?B?cktiMlRlZEdtd05JczU1TkZSRXNxNVE1dHE3NkhXYU94ckxNVDkrcSt0VFha?=
 =?utf-8?B?Zkh4UzZjWHlIenc5SnlXN05hb01mUWh0dmM0YlM1YWRFQ1ZyOE05OEVkRE80?=
 =?utf-8?B?WHpxWCs0cHpvL2g4UEx4YUphTmYrREJnTHhTamZYdlVYTWpJSHNreXZtcUJx?=
 =?utf-8?B?U2VXS2dvMldrNjZobCtRY0JhL0RHU2U4b0FhTHBuSmN1dXFrTFVBZVh6SzBY?=
 =?utf-8?B?Y0d6akx4SlFhZmJ1dGxDOWxDMEp0NU9hZUNkZ1MxZ2FkZDViU1dWOUt1Rkhw?=
 =?utf-8?B?bHpkZFBPMUg3K1NHZmZkSG5wL21BUUc2dDB4Skw2MDVOakgvUy9PV2RpQmsy?=
 =?utf-8?B?R1BNNFZ5MUZiT1FFZWRTbkwrVjlpWitkNUhQdDhCR1g4ZENjdGllTU5DZVVU?=
 =?utf-8?B?S0tkYTNDYVVIUUhPQm9jLytZUHhETjhzOG1tbG5pN0FmVUVIS1YyYVZTeTd0?=
 =?utf-8?B?cUk2ZmJMQjRoekFJRWg3TVcyb282WnY0ZGJsSjh3YlgxY3RjemxnY3ppeVhK?=
 =?utf-8?B?MkVLaGVySzRTb09Id3B6bmxONi9yRk9sL1lBVFhzbFE0ZU02YzArUXhJU05i?=
 =?utf-8?Q?T3Y5InWxCOdpWdAW3cE7wy0Kn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c753fc-3990-48d1-9c4b-08dcaa26d834
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 08:18:19.6353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VFbKOalzPutjbepeSdMAqyv9s0IB6uvGZ7sylgfl1Ffetaamx6xBB/G5Zmjt+KmcAo5lebYhPfuT/nymGfTvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9157


On 7/17/2024 2:14 PM, Greg KH wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Wed, Jul 17, 2024 at 08:10:22AM +0000, Akshay Gupta wrote:
>> +/* These are byte indexes into data_in and data_out arrays */
>> +#define RD_WR_DATA_INDEX     0
>> +#define REG_OFF_INDEX                0
>> +#define REG_VAL_INDEX                4
>> +#define RD_FLAG_INDEX                7
>> +
>> +#define MB_DATA_SIZE         4
> These are VERY badly named global defines for all of the kernel and
> userspace.  But most importantly, do you even need them here?  If so,
> please provide something sane.
>
These are required as used as-is by userspace. We will modify the names 
of the MACROS.

We will update the MACROS with AMD specific prefix.

>> +
>> +struct apml_message {
>> +     /* message ids:
>> +      * Mailbox Messages:    0x0 ... 0x999
>> +      */
>> +     __u32 cmd;
>> +
>> +     /*
>> +      * 8 bit data for reg read,
>> +      * 32 bit data in case of mailbox,
>> +      */
>> +     union {
>> +             __u32 mb_out[2];
>> +             __u8 reg_out[8];
>> +     } data_out;
>> +
>> +     /*
>> +      * [0]...[3] mailbox 32bit input
>> +      * [7] read/write functionality
>> +      */
>> +     union {
>> +             __u32 mb_in[2];
>> +             __u8 reg_in[8];
>> +     } data_in;
>> +} __attribute__((packed));
>> +
>> +/* ioctl command for mailbox msgs using generic _IOWR */
>> +#define AMD_SBI_BASE_IOCTL_NR        0xF9
>> +#define SBRMI_IOCTL_CMD              _IOWR(AMD_SBI_BASE_IOCTL_NR, 0, struct apml_message)
> Why is the ioctl command not prefixed with AMD_SBMI_BASE as well?
Existing APML library uses the "SBRMI_IOCTL_CMD", so will rename the 
AMD_SBI_BASE_IOCTL_NR to match with ioctl command.
>
> thanks,
>
> greg k-h

Do you want me to make these changes before you review the rest of the 
patches?

Thanks,

Akshay



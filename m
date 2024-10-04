Return-Path: <linux-kernel+bounces-350770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6875990965
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439151F218B9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8EA1CACDB;
	Fri,  4 Oct 2024 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="VehfFOWi"
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020072.outbound.protection.outlook.com [40.93.198.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7465D1E3788
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059843; cv=fail; b=TTXxeWJlKubPKwNYtNFjWF2I1DjGjBFrHw/vLX3ZeSQB7OzVVTH10CDT3Xn8NrixNfuJLjNOKBk5DByuTyVb9gYxDaT4ZufFfeIA3l3Dy292WhfmwUrykKQJAKUTg90gsjztHOOcDwYereW2WOOGXQT3AjW4KeLDL5miuVrUxSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059843; c=relaxed/simple;
	bh=yUH1ZklFbs9zMNGmpnpdJacjP29L1NERt/Qff6RUW2k=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M8Q435dFgaOTvlWVMy/AadxHS86aaKVHBNFG24HvmLcqiRnosiZRtil7Slt7reDO0+7ADAwFNa0nZKZfLKyqa7A1GRVIR84CdU/e1Zaw42WQ8t1+ZtOgvDVlEt8LejWa6Plwytj1zgOH4YegKUSJVICehihbrw4F983o7aAbGao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=VehfFOWi; arc=fail smtp.client-ip=40.93.198.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHx5z9dhyLHXno28GB8lvz2js94EoTfof2qDHPRprzFQYzCAr0CIZJOu7dX26/2yDgsKa/tN7uIC1DsV0YYKC5mW0+Y0dQfijIv9YIH1TTXRfRn6zEhL0PVCTYgJhlSzVfF8nnOO8lxxbA9TNPkibrXv9BQEEw3LDlA8Ff8Wc4VuFTAgD8zWxsBWhmNEIe8tO90T6AUgkbGTFl5ZoRY7Zoy5rrVDQLc2dx5xhUASMJJEmIPAEozuAEjRv/TEOy50VJe+TrgBdh+So3tE0CmDxdBgo8uPyXr9jDCj0yCg5E7lYhLCkEDO6UJ7ahFpylHQQOyyi1RnDrHLqXz0JSuv6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NA7K66vYN7b3iiNCe8YDFSfe8pmHg2RZdbE6vDwMdF0=;
 b=LGdlDZ34GpKMMHlm4BUIvtBSG5BV2Q96trb9WBv7NxGa2DxvXdIVn4cqTXrcTR+0OYeZ9owJxihM2TJB+M4ZTeVlSVe0LUnLrPnSmHjrYWq20Iz74FOr/va6q2kuiY2iFVdtkOeu2kD74BCvDJEJaeQQqcG4vp2Vj5ZZft3Czk7b7AqYAdZXfpgR94JSdNViXXpsnbXghTcD+dFtDoQ7WwKXRz1maw628n6+eUKJ0nqJz+5RtQ4nP+rHkRNbeubN8B7FSR00iJRFNbsIOs9VMN8mdRHw/zlJ625O4b9p7Fqh/uzoioPn/jO712Y611QPs0L56oJH+cz3NZ6UPpq4Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NA7K66vYN7b3iiNCe8YDFSfe8pmHg2RZdbE6vDwMdF0=;
 b=VehfFOWiF0e3GGCiOF5Pb2+UR9g7WYJLgYb1NzGaB/A4+E8FKCIM5/PMRwtNmTGek2AMWP90BtnVC0hg6EnQZIfzOh9+h6HWy9aXcpjgS0m9OqnMjxNNlIZ6W1UjJbMVvZhfNwjCZngZ+38m2OvJcP8kIKNCPYqx0a0RMAkLSbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB6777.prod.exchangelabs.com (2603:10b6:510:93::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Fri, 4 Oct 2024 16:37:14 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Fri, 4 Oct 2024
 16:37:14 +0000
Message-ID: <9f28e3b3-a47d-4a83-911d-fd7a6b95fd60@os.amperecomputing.com>
Date: Fri, 4 Oct 2024 09:37:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
From: Yang Shi <yang@os.amperecomputing.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, james.morse@arm.com, will@kernel.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241002175514.1165299-1-yang@os.amperecomputing.com>
 <Zv2ONA2b3+kMAizm@Asurada-Nvidia>
 <1c9767e1-4d05-4650-bc14-65a18fc63cc2@os.amperecomputing.com>
 <Zv2diJDU6v60hKtU@Asurada-Nvidia> <20241002194004.GT1369530@ziepe.ca>
 <f28cab76-8030-477a-84b1-461dc02451ff@os.amperecomputing.com>
 <20241003111603.GU1369530@ziepe.ca>
 <43c2227a-71c9-4cbf-bfec-5a2fbf698f27@os.amperecomputing.com>
 <20241004124343.GE2456194@ziepe.ca>
 <26ee77f2-720d-4e16-9f6c-fa15fd13d305@os.amperecomputing.com>
 <20241004161408.GJ2456194@ziepe.ca>
 <7ad66e5f-d6f8-4144-8ab2-d4ea499e2665@os.amperecomputing.com>
Content-Language: en-US
In-Reply-To: <7ad66e5f-d6f8-4144-8ab2-d4ea499e2665@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::35) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f650185-daf6-4d03-4365-08dce492cd34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVVEV2thTWI4bzAycWpYalZMcnlwczhHNHhKT0NxYmRQSXJmR0VKZkVsMUp6?=
 =?utf-8?B?QlAxVzlBZVpPUGsvOTVpRzlhOUx6QUxTemRtTTdhQmhDQlNjZU1pWmhPenU3?=
 =?utf-8?B?d1FsK2dlanExVmZZak9jV1p1UnpUTWUvdGFrSElzdVRJUkNzcEl0dTIreDN6?=
 =?utf-8?B?dmhQOXZJUnI5YUVmVkRRUnRpcHlhYVp4Rk9TbjhzUnFmdUMxQTFTOGxpRzJ1?=
 =?utf-8?B?R2hYbFVwTTZCY0dUV3VkbGRJSGJmYzdxMTBTeGlhSXN6ZzA3SVZyRDEwYVgw?=
 =?utf-8?B?cC9HU0kyUms2aElBYnR6VWNxWnNhRWx5a0JreUpzeXVxamRsbGYxQkFHSCty?=
 =?utf-8?B?YThkQVFXOXNMMDJ4S2MvMWRPN0lLeDdLTHpwV2ZzTGpWUmp1cnhLd2pUNm16?=
 =?utf-8?B?SS9qWWJIbWdGOWxhZXVGbk9mTDZHWFhac2Z4anRkc3BWdGY5TlNyTm9yQ2U4?=
 =?utf-8?B?aEhldFRhL00xUDZpeEo4QVVsenp6UXVaQ0RjbWRDYm9uTjV2c1pUUXFuVUZH?=
 =?utf-8?B?TU1DZWk1Z2c1M2VJN3FzOW52bFZLZ3VpZzRnbGZTWFcyY05ETzdTUGd6bjZZ?=
 =?utf-8?B?K1dxWjRJV2JJYlB0bGZ5T1oyeU45cGFvcDYveW00eitsWDErQ0FDQ1U1MUFB?=
 =?utf-8?B?aStmYnVadHpMRUJUMXkvYWIwUjhKMi9xQTc0VVFXbnVFRy80dTlEZkFraUp5?=
 =?utf-8?B?cDFob0VtYVA3RVJDTFg0aHh0OXB5TWgxcms3YzVKZmdGcHlJVG9XVWhxbDlQ?=
 =?utf-8?B?Tm1DU0tlc3daWkZ2TTI2R2owUVRlNWFjUXZWWWVLY0pHMUhoczBPdFBuOGhG?=
 =?utf-8?B?WXY1WTc5c09qS1paamZyTTI2UjdyS1RWUHg2c1ZFdm1JSk02eE5FTTJhN05C?=
 =?utf-8?B?UXByQ3VVdXJoaTZIdWdENFI2ak1DalV0QnhOYkpBMnJUcE1wa3pIYnhoZzZM?=
 =?utf-8?B?b012NzZ4NHhaWHBlWUdtbjNnMGFpYkk0bVh1TWhCM3dJNWRpS0lvSGkvSi9i?=
 =?utf-8?B?WjUrRFZHZVIwRHVvNHpkdmF2OTF4bVVHcSttcDFRMGx5OUYxLzg4R0o2eFox?=
 =?utf-8?B?ZjY4UnlUWldwN3pRaS92ZW1Xd3lkeGxkSDJqdGpvSFRvdUtMRld4RWlldlV1?=
 =?utf-8?B?K0d5dTJGQVF2eGZENUpaWlMyYmV6UE1NK1FSTm5RZEZJMWJQTUNsWE9qVldH?=
 =?utf-8?B?OU9qOGRUdEFtN081QWFMTXIvdE96c1dYcGJrU3ZvZU5FZGIvWml5bTRHTkRG?=
 =?utf-8?B?eHQvMCs2SjlpekZkc2plY3FWMVpGSG11bG0zNCtEMUVsRnZpOHdyN2xrV1gz?=
 =?utf-8?B?ZkhrQ3M3cXBKTzNhT2NTNTlvd0l6MVZKeTlVWGpHQldBZUNmR3lUcXdmL2g5?=
 =?utf-8?B?bkpObnZPVXJxUGRQTHl3eGQ0Z05lMDlZOUl1TTNhdlk3Rmkzb1h1ckh4ZVl5?=
 =?utf-8?B?WTJhNS9CQ2tZY2V4eFhSZnBuU2xob2RuQTQraVU3VG0yanROVEJ6dVQ2K0Ev?=
 =?utf-8?B?Y2dKWVVoQlc3ajhTTGlQMGVmaGdzN3F4eTZPdkFnUUU4Zk9aV2VhQkZlTW1V?=
 =?utf-8?B?Q2h0ZGtTMnR4cWRJaDhtT1ZyWm0waGNsZDdUNWxQNTQ5Y0xlSnRENEh5N3NF?=
 =?utf-8?B?K2JrY0g4UGJ5VEd0SHRFeDlaRHM1Vk8wYWdiaVNRdFJ6SE1MNDVkZXVZTys5?=
 =?utf-8?B?eTNZbDlOMmFzYXBLK3pGYVBuMFVqcm0zTFE0VWpoSENldTk0a01zc0NnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXloc1hvQWEvTHVpd1pXcVFFa3A1THhEMnZoblM1NWJ0SVQ3UEZXZE1LYmdX?=
 =?utf-8?B?L0NHVzdwbnlqZituTzYxY2dHUmxKZzd4MmJ1NXNRcVBIczB6MGVEU2JTZnFy?=
 =?utf-8?B?d0d2SjVEOGJOTnFDZWlBVGJEVEg2WUpidjM5YnBqeW0wOHY0bWVCK1JhNUVV?=
 =?utf-8?B?QWgzaUtlUVVTZDdxVmlrTG9IdFh0eTFXdHZkK1hSejhoQ0xsOFBwS1gwUFJ3?=
 =?utf-8?B?ZTUyNFJkcHdpZjFWY3BUTWpQSkhVelNkWmUzODBBVUpRNWN6VzVSenZ3REZF?=
 =?utf-8?B?QlFFRURKRWgxTjhjSzZWRnl4NGVBcGxmakhHa0RnaEROSmRHVmFsV3E3SjEx?=
 =?utf-8?B?MGxBY3ppU2hMcG9BTXkxVi9JVHFXSUw0ZWtSS1ByYk5tNEZIM2FUWVJjdGhK?=
 =?utf-8?B?aFh6bHVMNlExRkdLV1YyQ0YvUUYwbGpiemkySDVCUi85d1lpKzJBSjZjem9u?=
 =?utf-8?B?UDFZYjU4MEFObmR4eThNeS93UFcwVzJvQ3lNaEZsUmVBVVppTXJVcUhtWHJX?=
 =?utf-8?B?eTA4RUgzMkFqODFGY1pFVEdDdENLa21sdWRoYkRPeXR3SnhNWDZwVGdWMzhl?=
 =?utf-8?B?bHNKOC9hUld2UVgwT2xHcVk4dzhxbnhoeEc0b0N1VWtkUkVxQnQ2NGUwc3pW?=
 =?utf-8?B?N2c5SW80akFoZHp2amdYN005aFZSbWJBSFNuQ05yM3Q1ZExGQ0VXaGpMRXM4?=
 =?utf-8?B?MTJaSHhDaWV0blJMYjRuNXREU3pVMjZ0VnhZTlp3T1NDNlZGU05aQUpoZ0do?=
 =?utf-8?B?d0hHRTRSSHhJd2RIK2xFbi9PajBPTnlaTS83aTIxeFdEOHg4aitXZ0V5cExV?=
 =?utf-8?B?M2FMNFlTQmxTRS9QQW92a2N0OEw2Y3RPSTZyZlV5a1hBb2FzOXJ2TXJ1TnZI?=
 =?utf-8?B?REtGM3MvMWJENEtxdGdTdW1yQUV2MVNCNm43TlEzNnU0MTNwbnpDb0w4WEZD?=
 =?utf-8?B?YzZ2VWpCL1orWFliUXN4QW1CY1VnYUVqZS80YitacEtYaTM2cTRCSm5OMTlT?=
 =?utf-8?B?R1VrVGJjeXV4UTZyd2g3d01wU081K3ZVLzF1ekQrQ3ZjVHQyajhnWnRrVXdQ?=
 =?utf-8?B?a0NKT1BwWC9MTXpDc1piaHo0YVZSdkZkQWFlSGJ2bC8zUVN3L3Q1RG9TSDZs?=
 =?utf-8?B?Q00wYytkazAwTnc4ZU1mZXJSR2ZKMWlkQSsrcVFzSDR4V0NzcXMxbzBLclFl?=
 =?utf-8?B?d2orNGlveGRLOE1yQllKYmE5REVqZzh4T0ZXc2IrYXduWDBUWjkzQWNIQWgw?=
 =?utf-8?B?eUZocDkyZ3djUVRTRG1mdzlHc0tFRTFXYXEwek5DcHhDdEpPaUlYUEtxTTBX?=
 =?utf-8?B?NnBwbUZUa09Ma08yaTZ2RUdCSkRNZFZuemdkdGsrUVdBMHZSUnVzR3pZdU8v?=
 =?utf-8?B?dW8vekFhUENsUHRXZ3NCREFHQ1N1S2hWWWkxa2xwcnd2TUw4bEllNEltN3Ny?=
 =?utf-8?B?OVBadUliUVRIMWp0aWM4Q0N4Rkxxc2xQS3Q4KzNzWE5VbDEvbDVlQ2NSc2pn?=
 =?utf-8?B?RlNzekxkRXRESmNmZEljRWhQbENYc3AzSXhVNE13VHZqU1NwWXVrZ3VWcC9Z?=
 =?utf-8?B?TCtOZkU4cUV2cmNMZlVDbUp1bnByUjFhbTVTMnZEMEdVbi9MR09lMHB6ekNX?=
 =?utf-8?B?Q0JUNkoyMU5XZENzWTJ1N0UxTE1vZVRMVXNjSG9BV3BRU2tOVnl5Z1lWWFNp?=
 =?utf-8?B?ams1bFhBeHpxdFF6MGk0cFUrUWc1cTRodkFjWTdlUzRIMTg1Y2lhWEM4Umtv?=
 =?utf-8?B?OWJJQ1ZSeU5zdUFyaERidGZmcWRKNlhiV3FsaDZaYmVTL3RuWWdOK3pqMWk4?=
 =?utf-8?B?UWpNZHZ5NGRhaGRaZmFXT3RJRkk3OWFOYW9welhxRnRQbjVSNTBBbW1tNFg2?=
 =?utf-8?B?Y3RCTUJWY3NRM0FDNU8yZGVaNVYyaWVnMldzV1ZwSm42ditmU1d6Q01XMkxX?=
 =?utf-8?B?NTd3T2VnYVB6YXlWZGM0MTVrL1ZaanJJcm05dEllQVJmaDlJcEVacEhJS2tx?=
 =?utf-8?B?TDg1dk1qTjZqSWNXeVpnNW4zVDV5SXBqLzFCb3JxUFZVZzUyODJCNHdXeWdv?=
 =?utf-8?B?SzgwR2VtVzE0UDZEb2FpMzcvRFo2SG15eU4xWm4yRzRFNVJMa1gyZjZoK2Nn?=
 =?utf-8?B?eFBjWHZMcHpmS3RRNzBtaUFkeWxsQWZVNkp0SWttTC96eEVMMkx6cDJ5b0k0?=
 =?utf-8?Q?TGYfL6qFUtKZc31s5NfBJR8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f650185-daf6-4d03-4365-08dce492cd34
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 16:37:13.9974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jT7PV5qW5/hop9e0IpKpgUcmNzFbSO7JkY8xFKm3GMUrHEuPbOcC/YCBrj5ghrdV266QT7gqha05AyomCwZM1Kc3z9+2lA579+MGB9hG2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6777



On 10/4/24 9:29 AM, Yang Shi wrote:
>
>
> On 10/4/24 9:14 AM, Jason Gunthorpe wrote:
>> On Fri, Oct 04, 2024 at 09:05:46AM -0700, Yang Shi wrote:
>>>
>>> On 10/4/24 5:43 AM, Jason Gunthorpe wrote:
>>>> On Thu, Oct 03, 2024 at 08:31:23AM -0700, Yang Shi wrote:
>>>>> If I understand correctly, the check is mainly used to avoid the 
>>>>> u64 -> u32
>>>>> overflow. This check guarantee no overflow. If some crazy hardware 
>>>>> really
>>>>> requests that large memory, the allocation will fail.
>>>> Sure, the kalloc will print a warn on anyhow if it is too big
>>> Thank you. Will spin a new revision.
>> Oh wait a sec, it is not so simple, the 31 is too big because the
>> multiply will overflow or truncate to size_t too. This is why I picked
>> something lower.
>
> How about define the size as u64?
>
>  static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
>  {
> -       u32 size;
> +       u64 size;
>         struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
>         u32 num_sids;
>
> It won't overflow and the large allocation will fail anyway.

The size parameter passed to dmam_alloc_coherent() is size_t type. We 
may do:

+#define SIZE_4G (4 * 1024 * 1024 * 1024ULL)
+
  static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
  {
-       u32 size;
+       u64 size;
         struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
-       u32 num_sids;
+       u64 num_sids;

         /* It is not practical to have too large stream id size for 
linear */
         if (smmu->sid_bits > 31)
@@ -3667,6 +3669,9 @@ static int arm_smmu_init_strtab_linear(struct 
arm_smmu_device *smmu)
         num_sids = arm_smmu_strtab_num_sids(smmu);

         size = num_sids * sizeof(struct arm_smmu_ste);
+       if (size > SIZE_4G)
+               return -EINVAL;
+
         cfg->linear.table = dmam_alloc_coherent(smmu->dev, size,
&cfg->linear.ste_dma,
                                                 GFP_KERNEL);

>
>>
>> Jason
>



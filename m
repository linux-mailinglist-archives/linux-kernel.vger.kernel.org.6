Return-Path: <linux-kernel+bounces-350783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1F39909AA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12FDA1C21446
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCAE1CACDB;
	Fri,  4 Oct 2024 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="LiXum9/R"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2093.outbound.protection.outlook.com [40.107.96.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D25A1C7292
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060402; cv=fail; b=qsIIiop9YLrnHxkv2O8pkqzkgKolQx7aWQIgehmfFZEf9p8b2NzWzwoYg0IVNuSbYbZXxhpTuIPcvaxUEBD8rdql57UcvDsUIHIS0RuIh6QONCm5gdX7fmwYkEjLO1/xEXmlDcFJ+EmKWyBoQTaKwThgZUML90SmljROZOEBWZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060402; c=relaxed/simple;
	bh=LkLoU1sdyK7dtTOFZ1Q3PbiNgeELnR06UqD1WKWvHWk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L5L3rE7R1V6XkoIgC8EVdqw7twWS/D/WtLgD6Wyw5VSnPG6VqrIiYjCu6MaQbCN9mDApa/7vgtWWRykihx4MpIZfZFoFAqcL3pQJJpS83PAiCBD/BquS5Quho2xE0/jIgnenJIxjbT5eNVtqNwFaeNvDMjiqn9PNoiaB3wj/6ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=LiXum9/R; arc=fail smtp.client-ip=40.107.96.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKkIntQs972VXq54IbjRCXebVq5uF7nmS81mENYtgsDIqUy12nPnMbUO+VHfc/AZD6RF0Osna5MCe34t0VMVtYBQ/XTLJAlF3h9tr8o8kI4X3HNEHu3p/hS2hJs45P/1l4mjz0FfhHS1xZY7WK+EEe/J6mu2l/eBqxpl1XCwhJHtn+QVB05sPc8H4OUjJZvZAeaSDwMrA+05NgpcyZTi95C2Fyk8J8g6u41//xZ6GFKdx+N2NdDXyZ3pJ+6FMUYN3dVMKx0m6LYYMGhzDVSrP/Qe7hk8wo1AA3KjkI15pWG8ddIGwy/sedvjGnnvViHJ6olBwM5CRTNYq4GXGDrarA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ph/upMBf3LQ7YKrJnDlWoCXDJmOCDDBMPyyvEsZPh/8=;
 b=IGjkKrBBvIhHQ/3jykUHUDllW+5TJFWyyYK7zB2HNND8J5dKy2T9/UVzHQv5YEl+p0+wM3BD09XzR4U5+D6RGG9r46399T+RTQ2yM7NMvF372bRc+w0Z1dentGoTcbI86Pks0QpneUOqt0ZyYpHRveKMraiV6KX4k8KLN3xvb/YnI+UIw+wA81aKjXBTgwEU4GOLtAzeCMOnZ3IfNoKfflEa0GoFYlMqMtxIDM5hZ/l3StTpcRIG4LEeBnrDtMbQ9yMpavVv+zJyqwV3nP4ggBwOjJbFwPdE5msdGb6GhJGFDXEndckSVHVOlSRvPF/tU+BdjFVP1U6Dq889YF16Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ph/upMBf3LQ7YKrJnDlWoCXDJmOCDDBMPyyvEsZPh/8=;
 b=LiXum9/RRfSRXINGUO5N2GkIbss62qa8J1+Ak7/QlO1Lal6Wt6O2IRWNCflCzzIf0tvtJqyyqBDln89Hs2NEXG+ir9hf6wFxXnIQdZ57hoe2cfAnX+l30+rcihBJy7Mds1u6GSXPMUicBYo3HS7a0797xmQ/+N+WlWcEQ9NOpjg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA0PR01MB6425.prod.exchangelabs.com (2603:10b6:806:ea::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.32; Fri, 4 Oct 2024 16:46:38 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Fri, 4 Oct 2024
 16:46:37 +0000
Message-ID: <9a714b1a-f33f-4439-ab32-3ae359fb5033@os.amperecomputing.com>
Date: Fri, 4 Oct 2024 09:46:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, james.morse@arm.com, will@kernel.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <Zv2diJDU6v60hKtU@Asurada-Nvidia>
 <20241002194004.GT1369530@ziepe.ca>
 <f28cab76-8030-477a-84b1-461dc02451ff@os.amperecomputing.com>
 <20241003111603.GU1369530@ziepe.ca>
 <43c2227a-71c9-4cbf-bfec-5a2fbf698f27@os.amperecomputing.com>
 <20241004124343.GE2456194@ziepe.ca>
 <26ee77f2-720d-4e16-9f6c-fa15fd13d305@os.amperecomputing.com>
 <20241004161408.GJ2456194@ziepe.ca>
 <7ad66e5f-d6f8-4144-8ab2-d4ea499e2665@os.amperecomputing.com>
 <9f28e3b3-a47d-4a83-911d-fd7a6b95fd60@os.amperecomputing.com>
 <20241004164130.GK2456194@ziepe.ca>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20241004164130.GK2456194@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::7) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA0PR01MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b43b8c-ead3-4d71-0e4c-08dce4941d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUtkSFo1WENJUHdKd3RHc1RkdmJOU3hUZzJtbjBoS2RFK3VXenBiRzN4Yzhz?=
 =?utf-8?B?bmJqWkJhcVRpendyRHVnWWsrcG8yOEEwWWd6cVQxelFnVzNreUhpaEkrU1Rl?=
 =?utf-8?B?RkhhQ0V3cWpsQnQxOXdXTGRjYWQxNytyTjJpUVV3L2pOdjBkaUtMbXpaMm5N?=
 =?utf-8?B?cTcxQmVSbERNK21SNUgzRngxcWNTcEtOd3NmeTdYY1VPQXJ1Y3JLanJFMXlw?=
 =?utf-8?B?SmYwOVlCSDNWTkp4THE0OGFVUXMvYnRjL29XM0pNRWdXWUpmaFhTMEZzSkdE?=
 =?utf-8?B?d2ErMm5JTzcxVENkUXJ6blY1OHpCRWFTK25ZQkpsaXJVc09NKy8yNEJyVEMx?=
 =?utf-8?B?S0Jxd0tMWlh1eVBHaTJXcGxrZ2l2QnRQNkVNL2tIbHNDa2ZTM0poZGVhSmN5?=
 =?utf-8?B?Tjk1TU8vZFFHcmJ3T0tzWU5PekZQMWFjMEZCbFd3Z0lTRWVEcEYvRUt4eGVa?=
 =?utf-8?B?Mno0S3Z0cTBGTzVXMmE4ZHdSYml2eGZVaW9hUExUOWtraTBYOG9TRXJlem5w?=
 =?utf-8?B?ZTgxVmpJWHo1bmFqV2ZkNlVTWVpicmMvTUp1ZjdVNkNsQ3l6QXBHTitPc2F4?=
 =?utf-8?B?Qy9QU1RqYjliVUd5aEtoNkt1YUxpblpzengweWRaUHJjSDdvMW9lQ0dualhn?=
 =?utf-8?B?SEtteEZyTHFydS9wQkE4Y1d0S0JzMkRwUjVHell4QWNiajNCSlBBcnZXNnRn?=
 =?utf-8?B?WHNlVUpOeXlteTUrRTNlUzlyeHRwUnlCRVRlVE5uTk14UExPUlNxd0d1WStG?=
 =?utf-8?B?R0hjMUZmNzRTd0EwVDk0cVBQbzQvZlIrMjRPNXBocnZkcjhuWTkxWFNsQzVM?=
 =?utf-8?B?N0VBQmtKR0dHNWFURkp5UnBaVUp5dWZ1V0JWejBwN2s3RW1EZFNZSVJIWkZK?=
 =?utf-8?B?Z1NnL28rbE9rUURYU0hHZ0FmclltZU1BSlA4SmlWV1E3L2RGSm1VWW9LQ2dq?=
 =?utf-8?B?UFllN2dnOWxOaHEzMmdzSjNZOXRTRW1pM0pBZkorSktzdGl5c3Nnc0NVRzcr?=
 =?utf-8?B?WlZWbnFOeitodGF1djltSHJWdHdzMDEyQUdYdWhJZmFRU1kxYm5PMC9WWVpI?=
 =?utf-8?B?QUtVRHQ4UWFJSjZRUW1SNFcxNTBQUis3TUhpZW5GUXZYUkx1Q0hMczBPV0FZ?=
 =?utf-8?B?SE01dHgweVN2cTR3UDk2UG5tYVgvL3hTa2tZVXYxUWxpMkNLWEowK3ViQnRR?=
 =?utf-8?B?WHpGSlRPUnhHVitQVzh0Mlh6aFlvYytCTklSQ1RVZk1hRUN0RGZmQ1E5OXI0?=
 =?utf-8?B?THZURXVRR1Q3Q2RDZEZKL3NweTA4N1Q4cWdBbWNoODg3NUxBMStXMHRFQk1F?=
 =?utf-8?B?VjZzWVVwUFE0eElnTlRsZ3B6V3dzTXU2bitOMEpXOWpEMGN1QW5xNGgxbzdw?=
 =?utf-8?B?YStGTlU3SVlkUkppam9KbFpzRHNUUE1sVTNPV0c2a09LT2J2b0xyQUViZUor?=
 =?utf-8?B?TTBjZnFwTGYycEl6V3JvMWEvSEEvcXgzaHlwNzAyUVpiU0JCaFVzaFhxUDBz?=
 =?utf-8?B?MkFqZHZOd3FMbHZMYkJRUWFocjMxSjlaSk1oRzdIZElyckFRUkJ2eHJXQWJX?=
 =?utf-8?B?aFZmYzRkNXVRc2ZsV01rTTlwZEJXMnF5ZEJidGVFMFVDTUdTOWZpTW1xVDFZ?=
 =?utf-8?B?eHZXYW1ycE5qeDgvRnBQMk1JRzBEZ0ljNlRCRW1FMjI2Wk9ISHBqNGRldlVo?=
 =?utf-8?B?dSs2RUVEcDRlZ0VSazdCSFBUWGw2azlyWW5CL1dmVVZxd0hGbTNuRHhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk9neUphbGNXNWtEWGdHVDBPZUZlTHQ1S2RiVTI5UDNEY2dGZTVvaUNUZ0FB?=
 =?utf-8?B?c3hOdXgydVVZcEJpVnBqWEdHdjhNU0lhWHlyMXJzcGdvMHFuU1h2RUxEV3py?=
 =?utf-8?B?M080M0d6am0rQ3FJSzZnS0M1R0F0NFNCaE55dTl3MWZWOFB6eXRDcFhOS2Jm?=
 =?utf-8?B?ZWhjcmZsazBPeVE2RnZhTC81bFl3NUlpZ2NBU1d6Y1VnYTVFeTdLeit5ZEdx?=
 =?utf-8?B?NDhxZDVZSjdkcGFUZUs3dVV0RllsQk50OXRZL3lKN2RKWVlDN09iUmpQQUVx?=
 =?utf-8?B?a2lzeDlxUmJBbitKQW9wMU53aHB3ZjhSVU1hdXpIcnRrOSttUjVFNFFoanFy?=
 =?utf-8?B?N05zSVBPSjdDbzhjTFdiRXRqVkllQ1dIOWt0VUx6YVFpeFZ4ay9rYTRaMDA0?=
 =?utf-8?B?ODhtTzRua0JTcnRJYW5TUzFEQUg3bTBxa2dOcXFLcmJBc1lIdWg5aWpsc3RL?=
 =?utf-8?B?MXB3UzIvSUdtTDliNFVPZ1JkeEFZK3RjTTZCVXAxOFBob3lmZk1QdURRTkgv?=
 =?utf-8?B?T0hyc3Uxa2o0Y3p1Zm04ajA1c2UwZXhpa0RsUkFKYXZGRS9SOGpzQThwcmhz?=
 =?utf-8?B?SzNFeCt6N21KVk4rY1V2RlpnN3k3cXNjUjB4TU1KSUxuRnUzcjNiNldsN1pu?=
 =?utf-8?B?TG4vQk1ZdmlLdjJ3Slk5dHlWRkdLYVdOeW43Rzc3K0VXclY5ME9rRjUrcmh2?=
 =?utf-8?B?M0kvQUlxaFd0YXpCclBoWkFKbjF4NjlJOUlMa29hb2k0K2RwWGYzalhrS3pn?=
 =?utf-8?B?dGFVOGRXQlJFdE42UnNQQTR4c25YVEZGQ2dYNUdZZElYM2JldGdMa3JPM2M4?=
 =?utf-8?B?dklQRk5LenBOdGFuUmtFbW0vK01WQXFMUVEva3ZJTWhrYmJyNEE1dzJkYldL?=
 =?utf-8?B?bzdsaHlCaVBMR0ZqVzRnKzJoZWNFN1JBeG1ycTB3VGcrR0VWaVhNcjNVcTZT?=
 =?utf-8?B?Vi8yeFF3UHE0cyt3d3d2UEhFZ1YwS0dkcVF0TnY5SGFiRVhRZG1NcWJ0Zml5?=
 =?utf-8?B?MVdiZkJxNFlHazYzak5TYmJLL3o4bWRZUzBLZXptZ1BuZ3dPZVRNQzBVUzNS?=
 =?utf-8?B?Mi9IVVVCT2lQTzJMNlh5MEhJSkVvdS9DczNNR09jcmJBb1BPN0NyZ1dRN0I3?=
 =?utf-8?B?M2IwYUIvWlhqeW8vRjVtYWxrdDEzRWMyNTAyNjdDc3NzNkxNMmJET2ZTeVp2?=
 =?utf-8?B?dmlCVEd4MTd0czFiNjlIdWVFQ0ltdDZQSy9NLyttYzJLeUMyRmZ2YndrNjll?=
 =?utf-8?B?VCtHeDJ6aWNCNWNSS2V5S3A1NDZjYi9yVzYyQm9pMm5LQ3Z6S20wVUlWbVkx?=
 =?utf-8?B?MUNHUXE3S082Z0VESmZvZEo4V2pwQ2NIYm40MytFc1VRdjJjWHZBMS9XT1BD?=
 =?utf-8?B?bGZJN2ZNSEZmTm95L3FzQS9EM1FOdmZOWlRzM3VhYk1SZ2dBaUtFOGszWElz?=
 =?utf-8?B?d0l3L0lPQTJBdi9NWVljalI0NmkzV1pIUzFBUmZ1M2s1QnRqQWlSQVB3L0pH?=
 =?utf-8?B?RkxiSmg1ZFlxUllqeDRoV1FwYTRINmpZNXJiYWVaSWdBOGFmWVB5Z016dVRG?=
 =?utf-8?B?WW1lTDBscmRkZVNyeUJkZkF5aHlZSlIwVXJSQnNWZHZIOUJkMHpXM0VnRDBO?=
 =?utf-8?B?LzJhZlNxVlNpQ29rSThvdkJRRVUwZmVGUEduNU15VTRFVDgrYmowMFNKdWFV?=
 =?utf-8?B?dVVuWmhyWHpoVkw1NVE2ME1BMHFPUWhQNDlzVWp1aEJ4N0hHUHlndUZUY3I3?=
 =?utf-8?B?VG9zOG9nTUU1ZzdrVXlmTDljckd1Wmw2Rm90a2lPUGFIUlBVOVpTaGh5aWpq?=
 =?utf-8?B?cnJPUGEvZTlNeXRpTDdvR2V2K3hsWDNWejM4MFlneURqM2RMazJCY3dJRzZM?=
 =?utf-8?B?TjFDOGRtTUl6MlVab3l4Q1BLVFNFdy84bFYxTGdGL25jK1VMWElYL1VtbTR0?=
 =?utf-8?B?S2xpc20rZSsvSnhOYVRnUm81VUs0bUQ3cEhBQWhQc2lIeWFxR1BHcXNiY3Bq?=
 =?utf-8?B?eXBmZVR1VDR4MFRVbGdBTlNIekxjcytjRE90ZnpSa1hEZkU0eXVFVnhYYTlr?=
 =?utf-8?B?WjBmWm5IazFNZitQam9uM3dxeGxLSHhXTlFVQ1lHa3R1cUlQWk84OGxRUmhx?=
 =?utf-8?B?cjIzNXAvaHZET3psekg0aDk5V09icjN4a0tsVXkwWENldWoyRGFucnpsZ2dh?=
 =?utf-8?Q?gNs0ZlOre69EjebxbuzPJ04=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b43b8c-ead3-4d71-0e4c-08dce4941d4c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 16:46:37.8812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: waHrPjIy8omEfGNtj5WcDEQ4aP/miUo5ts22eldpgyHr2/UzgDGBElFLcupq/GbA5GJvFfh1hmrIJskHTfaPglM24GZEFQNZNE17fWc891Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6425



On 10/4/24 9:41 AM, Jason Gunthorpe wrote:
> On Fri, Oct 04, 2024 at 09:37:10AM -0700, Yang Shi wrote:
>>          size = num_sids * sizeof(struct arm_smmu_ste);
>> +       if (size > SIZE_4G)
>> +               return -EINVAL;
> If you want to do it like that then 'size >= SIZE_MAX' is the right
> expression

Thank you. Will take it.

And with the size check we don't need to check smmu->sid_bits.

>
> Jason



Return-Path: <linux-kernel+bounces-522802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D010AA3CEA4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133843AB140
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B9D15624D;
	Thu, 20 Feb 2025 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="VUhNr9rV"
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021079.outbound.protection.outlook.com [52.101.57.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD88118E025
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014710; cv=fail; b=QehOkz99ZweZHAtRv8IzZ7km968ypEAOANWO6BVGqfE7IrTQ/HUnDUr7qiD0M+3SGS/og3AXRBUIvwFdx1SYa2ZT226Ai9qSQx+DG/WGEsZN3oXKSMgiVYLSGRl5td6snqiJjXCtTjUqbe9fF1/pzDIFbnsz9VwJWfVhk07HSio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014710; c=relaxed/simple;
	bh=jg9LaeSpf/13EIZd5yOvz8myMHEIQJ7hvUIsp/k1ffQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PCbPQ9Ojctg7cNlVyIp5bU2MsJkYMyenY462TScz6v+fyzncEobhvB5oUMceqbig3pIPG8Ud+r7hjYibLRjnymV6kjb6raF8Ff7O0KxpQBVvs2+Xn+BTVf3THvGLlJjKtWVv0KobewkcIn/WuKq8DWubnvTBe/0JqqrRNKBh7sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=VUhNr9rV; arc=fail smtp.client-ip=52.101.57.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evtX0dPtv0zpWRW6ilWKe5RJht0c13gVZ7nL+DQiVNz8SKDdo3n+YpGennJSXTIykfQ71+xTZtGLjK5PNBxChw88awppvK8GsHd9jp+1d52b5PuvJ416agBWpWVtpYdSo54eXEibMMUp5RTcF2JTWgLxozkztvOzgPUNg0/Z2k8XB5nhuXc3V1Q17Zc/XL8bGUyPI57xIca8VVGwS6KI1GMpTVBb2+4xLfV7rND5SDo22m/0Nj9KWHO5CqLStt/45RsCL4Hs2wXH+c6QNVnkU3IszghP7mxY9IyRahg8lOX8zhiKGmQxnGKsxNcpDNYIBBiIt8l7ZsI8XJZ/BVlhgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0dUrjhbZwBp91fTacUnvbQ69/pNZMspEhRDsuynGrc=;
 b=cSoVhNBDFIwBsFVxrFicrE1X6kpjIOt7N9LIyrxoUrk8zVhW2z9kwjGV6FhFGQrUO+jEBUc5xqhKNUNGQ5XCoCrfLsQoy1rsKb2LCqdFSkMfUvz3sfuA8OiYTuOpjqfbrlFiLxpI6g34Gq172whCVfMjfiWd+JIu2Ms4YqI+9uMFb/VptJVjR0oq2zY14uEKwIqOJ0tpHnugI8R/6qF6mVdT/2kRCgX65Y+TnnQrigqUOKiQKUUzU7575SbKGIVAWgxGTfW2I+CJ0E2fKZQbWetA0bByMmSglKqzmk3fxGx/hJ7FU0smkjoNUc1Co8rMweG0z7J3mgQfqP+jriwd0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0dUrjhbZwBp91fTacUnvbQ69/pNZMspEhRDsuynGrc=;
 b=VUhNr9rV+RCziGMfI5eWadPvupTkFP+9BVCcN+4fuW3nhYXoiNISLHD+qBKMFuDAb+f4GeYBtP7Z2brWnQS1GiodLt6PAfefFaHav6YbDe6YxrGgq32g8lcAYG/Vy6HXSACbiz7uIM1OSuvTHmzcz0j/IgsbpdVO1nTrMKegbWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 MW4PR01MB6114.prod.exchangelabs.com (2603:10b6:303:79::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.12; Thu, 20 Feb 2025 01:25:03 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%6]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 01:25:03 +0000
Message-ID: <bfe7fc8e-b22b-4ff6-92c1-7444a0d6c5c2@os.amperecomputing.com>
Date: Wed, 19 Feb 2025 17:25:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] arm64: Add BBM Level 2 cpu feature
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 ryan.roberts@arm.com, catalin.marinas@arm.com, will@kernel.org,
 joey.gouly@arm.com, broonie@kernel.org, mark.rutland@arm.com,
 james.morse@arm.com, yangyicong@hisilicon.com, robin.murphy@arm.com,
 anshuman.khandual@arm.com, maz@kernel.org, liaochang1@huawei.com,
 akpm@linux-foundation.org, david@redhat.com, baohua@kernel.org,
 ioworker0@gmail.com, oliver.upton@linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250219143837.44277-3-miko.lenczewski@arm.com>
 <20250219143837.44277-5-miko.lenczewski@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20250219143837.44277-5-miko.lenczewski@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR15CA0134.namprd15.prod.outlook.com
 (2603:10b6:930:68::23) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|MW4PR01MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba509d4-c5f2-4fc0-01e0-08dd514d66ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFpBS1NQS0k5eVZsY1BGa0VXQjRJbHNybzJ3L3hXZUJXSDNQMktuY2k2NEhh?=
 =?utf-8?B?VGdJU3BIdE0vYjBpYnpPYnRaZWRZTkFrTnhlaUk2aW9XdjgwS2J6QjkzRVg1?=
 =?utf-8?B?NGdXU09lNW9IUWN4WHlBU1VNNEl6OERIMW5BN0lrUW8vSy9EQmNrdmZLY011?=
 =?utf-8?B?dG9NUDhkd0lmQyt5UUZFa2M0RC9BRkJsak84TUc0TXFwcWNkVWUxYnUxWURC?=
 =?utf-8?B?YWY2M3UwbWJMWlk2ZzV4QW9BV09xNTl3K2swaW51MHM4WXZUczRzRTFRc2JD?=
 =?utf-8?B?YWx3dG9WazgrUFNSNGxqazdpM1VBbERkckxsQ3IyOGhhQUp0SjY2dUhhb0dH?=
 =?utf-8?B?eTJBWkFBQ2xjQlpNNjNwZjhTMk4vODEzN0xVdlZXbzB0NU9nWHo3Yzg5cTBM?=
 =?utf-8?B?RFdaVGpMbTBGWWZTZjd2Uk9ZUVVXSmpQa2NkWENRR3hsS3ZJam5XK3NpcnNS?=
 =?utf-8?B?S2pKdVF4NnZBL0ZJVXNjYW14V3JMTEd1WWx0QmtJNTdpeGN5aCtGN0ExMmdO?=
 =?utf-8?B?RzVoOUhtelBXMklrM3FPZUJUMG4ycW8yQVBiTU95L1VYUnYvTExMN1k5Nnl6?=
 =?utf-8?B?cU9DSko3UG83VEJFT05zSTJxV3FwWDFvVDBuOS9CcURlNFI5azJtOHJqNlJ5?=
 =?utf-8?B?YWNmcHNzZWxDVExya0MzWUZ3aTRrbmxkNDVmSEYvdFkwUG5mNG5tVzRZM0tH?=
 =?utf-8?B?L2pWMUlDZkJ2NmlQWDZwK0ZRczFZcDBIY0xPQ0g0eitvSkNpQllCbHNIWEZK?=
 =?utf-8?B?WlNpeU55aUtYd0dhMlRwSWZvaUJpWXpOK2tDZ3g4b2NyWW81YnpKL1BYdUNs?=
 =?utf-8?B?aGh3UW13cUEzY1M0WE55MGVPbGkzM0pOZDQ3UktoL0E5eFlCeW16R3VSQ09H?=
 =?utf-8?B?aEtvZTlramZneGtsTGdLbmJWVm5UQ29oQmExSUsyR3VZcHNJNmhxTWlnWmNG?=
 =?utf-8?B?NUYwSnYzWlplVjVPY2J5aExEQUk0MzlmUVpnMWV4aDc2TkZBUitzaklteGxK?=
 =?utf-8?B?WjVDNGh6amJxdDRtTkgxRmF3Q252NmtjUlJ6VU1YR3h2czFkL3pvUmhGQzdI?=
 =?utf-8?B?U0FPdGZQSER4SHRoZDNBVE5DQVlBZHo4SWVFS0ZnWDVkZnpCOUJrKzEwcXc2?=
 =?utf-8?B?QWhVc1MwZnZxN2ZTU1htNDkvalUzajN6a1BIZ3c0ekdzS3V4NUJzMHpSa2FK?=
 =?utf-8?B?TWwwVUVSallJK3YvdDl5MVNDZ0Z6a3NkeHhYQmd4ODBRaFcxU3F4MWZ1QXBD?=
 =?utf-8?B?czY5bDI1YlhjUXRHTDBEQVNSeGFsa1VsRjc4dzg2THl1YkNudmp6U0tHVFN5?=
 =?utf-8?B?amJPeTU4Z0ozUU5pVWhMZG1SQUNmSGxrMFFMYjlDVERBVG9yb2lJMnVWalZG?=
 =?utf-8?B?b3l2aThtNkJ4YU96OVpxb2wrN0ZOdmpteFMzd2JRbWJXVmRJZXBzVmlFZ29p?=
 =?utf-8?B?cWlWZ1lnTHo0Nkk2bzFMbWFMcmtmZmR2Q2Y1S1paQ1d2ZXZLTnpBMVp2TnRC?=
 =?utf-8?B?ZE10NE9ySHRaQTZYeHZmeXlvVmliVVFWNFozdW5TTnRLR0Vxcm1pYzZqVHZr?=
 =?utf-8?B?V2xVOEtEMy9qZzA2ZjJ1bS9pVHdrS2NsSXJLNG9GeGV2OCttb21PeDZvdmM5?=
 =?utf-8?B?T0VGQnFRcWlUV1ZPY0w3V1V3R3ZhRGdwUWhIeVpIaHJiMGhIeVBNaFpwVGVZ?=
 =?utf-8?B?T0diWFJMSWpUNHQvUi92Z1JPcVBaU0RZeFFkV08raU5CWkgxYnNQcngyaXlX?=
 =?utf-8?B?QVdQWHZuRVRaREdTNlR5dHpxK2ZTUUI3YUZLK0hIemp3aFFJVWdrdENwc0xn?=
 =?utf-8?B?NjZ0ZGExZTRhejdQYWlpWGVuMkpzUStwTUpaNnFteGxVY2ZManc0N0JrNUFF?=
 =?utf-8?B?d1lpWERLS1lsNlNseWNaUWZadmNHSFgybC9UZllUeWpLa1VEOUlSUjk1WlZK?=
 =?utf-8?Q?TBu/ZMafZSg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(7053199007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnNOYk9nVDdSUzZkT3pzakVQdjQyYWZHd0h4ZTdmM0YzQmM2K3pUaFNpUHFG?=
 =?utf-8?B?aDFBSWxPclBsYmpvTXRZR1lQZ1RIcnhtOHhqWnZuMkRVVVdGOFgvaTJURnRu?=
 =?utf-8?B?YkNxWFVuKzJ4NnIwZVJuS2NEV1FDZFpwLytjR1NaRVg0NGk4TFhXWkhBUlVq?=
 =?utf-8?B?VjZXVXNwRzl4UkhobVd5OG1zelRxeEpqSGowUHZiVkIwM3JSSEs0TFdpeEJ5?=
 =?utf-8?B?UktZSVpHUmI1emI0WDlEaXJ6V0crRzUxQUpHSWpiMUxsaFYvVzdWUWFFbmRl?=
 =?utf-8?B?R0I3R0I3Z3pJMlc3UExQUkluMWRVTXl2RXF0emhtYWRNSnFsUlY4K0dUNWpq?=
 =?utf-8?B?d3VXV0tMSkdXUzQ4L2kzVTVNbHF2MUIrTVIxY1JtL1AwR2tBMGRvMGtMdGlW?=
 =?utf-8?B?TGQrQW9HbmNHbk9xWWFtWkZETElDbUdmbGpTM1dVYWNGV2ROTVhuWW1NNUhj?=
 =?utf-8?B?MTMyVk1qS3pIRkJmYjJYdVNYVHk4N1NhUWJHMWtzTzQ1YUJFeERvbjlrdTZC?=
 =?utf-8?B?Y0FpTERVUFZ6WmdjN2pJNUN3YXNTN0RCVlRyeHR4QjY5VVpGdGVpdkZEMzRV?=
 =?utf-8?B?c3oyVXkzeHdrYjZGTHJ3VDdUS0pPZHZ1WjNJbi9tL05JY2ZHdFE3RFgrOTcy?=
 =?utf-8?B?V0djbGsxbE5uL09wOTdBK3ZMVHJMb0tBVktpYUVwc0xzRDBZanZBSkJydWY0?=
 =?utf-8?B?NXlYVHRNejFHN0FzOFJKcWMzK1lVYVJUUkxoTlNnTWN6MFhaUld0V0JvVlYy?=
 =?utf-8?B?Z2c4cGFRbDYrS096RGptbWxHR3hUNnV5M08vUTFPeFZoWENkRUNKNGlxZEpR?=
 =?utf-8?B?Sm1hOVJ3L2swRGk4d2JkN24vN0ZBSWpYSTQydTJpa1NqSWoybXFUb0NLVkVi?=
 =?utf-8?B?b3Y3b2hjMnB1c2dTSWt1Wk9sbi9YdHMxSU00bS9zZ1RYNGFzem1uQ2ZRcm92?=
 =?utf-8?B?dGN4MDIyek5JZ1JBdlpKZm1wbjZWaXg3MlQ5NXU1K1ZweXZILzIvNkJ5d01U?=
 =?utf-8?B?QUpuakI3MlJNMGdNV3NIU0VDdjJBVldQSXpDNnRndW1ZMjFTZ3V6UDNIRUFX?=
 =?utf-8?B?SVZEUjYzd1kxbXJMV1M1ZHBqQWlIYzFpYXIvVUlEMU1mQXpuNERNRmp6eVl4?=
 =?utf-8?B?K2FBYjFhc2pDZFVLTTdPSjlRcnRWRzZua0VQeEtrN3l6NWN3em1wd3laUWdX?=
 =?utf-8?B?dXpDRGUrbGxhUElQUTRmWW94NFFsU210R0t0Qlo5VEpQR3lGS3R2NFcxOVZp?=
 =?utf-8?B?akZiakpqV3RHNzJ5TkE1V2pGMkRjcC9XVElJbzlSOVNDSE1Hb0xzU2l0clpl?=
 =?utf-8?B?d3FNOVcrZTloSFRpZTR2dExPS21RWk5HSzRUalNLMnY4QnZEU1FCVDVYSDRR?=
 =?utf-8?B?dFhWUkNITklhaFlzeVZjL05mcmZoVXFoMDVCdmRJdWVFdGhmL0JHVDJ6TTJh?=
 =?utf-8?B?enl3MFg3Zm93SkZaWFhuaEZ5M1FsODh4d2YySjhkTXhmb2NoQjdqbUFKOWx4?=
 =?utf-8?B?V3dVQkc5MlFkMkVRSllvWW5ySEtUZk90cWNtTVQ2MUJVaVB6UzhjMXcyUnEw?=
 =?utf-8?B?enlQWkptN1B4LzltdFdmQ0Roc0s3YUtnUldDeUw3QmtIRGZCTnJjSnlrRUR3?=
 =?utf-8?B?WDVJVWNnRnZGMUdXYXZsdjU0dGUrckNuOWd6bkdLVVdrRFZ6MWltcy9tZlRB?=
 =?utf-8?B?Sm1rOU5iYnhDMTFScVI3VjJ3Q3JZSTd3eDR2QnIrR2RYYjNyaUt5amNWeXpG?=
 =?utf-8?B?T0hESG85Si9wNU0zWFBtVWJuZmQ0MVRZdjBYZUJLSHlxWWlkeCsyR3crTUpI?=
 =?utf-8?B?ME5maWdMNVA1aEJmQytmQytYcnJCeS9rczhMWnpqRTVnQy9XUFdrU0xhdVJL?=
 =?utf-8?B?Ty9XeExVNEkrQkFQc0dvcDJ4Vm1seTNGRlI2TWx0L2Z3Rm9GOVZ5TlpwRFYw?=
 =?utf-8?B?ajdETHA0MjRwUStpaWRERVFXRkhWYzZ1RkhZajRSeC9NWllEVUkxcjRkVmtz?=
 =?utf-8?B?aERvMzFKclEyeU5GZm85bFRpbnI0NE9pcVJPYXFPUDJwbUxkVFRNSkQ5S3Vm?=
 =?utf-8?B?MXdhbXpGdmtETVhIUStORWVLTlNsaG1xbExpVUNvQVBSS2pGdWEzMkdDSFVM?=
 =?utf-8?B?SlI5bFk0b08zVVRuTzRGdTFNYXlKME1DVlZad1BkaGtoUmNlQjRYa3B3L2NV?=
 =?utf-8?Q?J+xp+BwKqk3khXKAIZJrsuA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba509d4-c5f2-4fc0-01e0-08dd514d66ea
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 01:25:03.8416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgAgh9KAxg3KqdOsvyQDJ7unyoRt+/kCS8bjupY1z2x6Qc0gZ2AbDPXCRrszta3HY5QvnJDiIRtBfx5pbrjX9oj3OyvXem9XpAYUCvBFhEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6114




On 2/19/25 6:38 AM, Mikołaj Lenczewski wrote:
> The Break-Before-Make cpu feature supports multiple levels (levels 0-2),
> and this commit adds a dedicated BBML2 cpufeature to test against
> support for.
>
> This is a system feature as we might have a big.LITTLE architecture
> where some cores support BBML2 and some don't, but we want all cores to
> be available and BBM to default to level 0 (as opposed to having cores
> without BBML2 not coming online).
>
> To support BBML2 in as wide a range of contexts as we can, we want not
> only the architectural guarantees that BBML2 makes, but additionally
> want BBML2 to not create TLB conflict aborts. Not causing aborts avoids
> us having to prove that no recursive faults can be induced in any path
> that uses BBML2, allowing its use for arbitrary kernel mappings.
> Support detection of such CPUs.
>
> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> ---
>   arch/arm64/Kconfig                  |  9 ++++++++
>   arch/arm64/include/asm/cpufeature.h |  5 +++++
>   arch/arm64/kernel/cpufeature.c      | 32 +++++++++++++++++++++++++++++
>   arch/arm64/tools/cpucaps            |  1 +
>   4 files changed, 47 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 940343beb3d4..84be2c5976f0 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2057,6 +2057,15 @@ config ARM64_TLB_RANGE
>   	  The feature introduces new assembly instructions, and they were
>   	  support when binutils >= 2.30.
>   
> +config ARM64_ENABLE_BBML2
> +	bool "Enable support for Break-Before-Make Level 2 detection and usage"
> +	default y
> +	help
> +	  FEAT_BBM provides detection of support levels for break-before-make
> +	  sequences. If BBM level 2 is supported, some TLB maintenance requirements
> +	  can be relaxed to improve performance. Selecting N causes the kernel to
> +	  fallback to BBM level 0 behaviour even if the system supports BBM level 2.
> +
>   endmenu # "ARMv8.4 architectural features"
>   
>   menu "ARMv8.5 architectural features"
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index e0e4478f5fb5..2da872035f2e 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -866,6 +866,11 @@ static __always_inline bool system_supports_mpam_hcr(void)
>   	return alternative_has_cap_unlikely(ARM64_MPAM_HCR);
>   }
>   
> +static inline bool system_supports_bbml2_noconflict(void)
> +{
> +	return alternative_has_cap_unlikely(ARM64_HAS_BBML2_NOCONFLICT);
> +}
> +
>   int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
>   bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
>   
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index d561cf3b8ac7..8c337bd95ef7 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2176,6 +2176,31 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
>   	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
>   }
>   
> +static bool has_bbml2_noconflict(const struct arm64_cpu_capabilities *entry,
> +				 int scope)
> +{
> +	if (!IS_ENABLED(CONFIG_ARM64_ENABLE_BBML2))
> +		return false;
> +
> +	/* We want to allow usage of bbml2 in as wide a range of kernel contexts
> +	 * as possible. This list is therefore an allow-list of known-good
> +	 * implementations that both support bbml2 and additionally, fulfil the
> +	 * extra constraint of never generating TLB conflict aborts when using
> +	 * the relaxed bbml2 semantics (such aborts make use of bbml2 in certain
> +	 * kernel contexts difficult to prove safe against recursive aborts).
> +	 */
> +	static const struct midr_range supports_bbml2_without_abort_list[] = {
> +		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
> +		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
> +		{}
> +	};
> +
> +	if (!is_midr_in_range_list(read_cpuid_id(), supports_bbml2_without_abort_list))
> +		return false;
> +
> +	return true;
> +}
> +
>   #ifdef CONFIG_ARM64_PAN
>   static void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
>   {
> @@ -2926,6 +2951,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>   		.matches = has_cpuid_feature,
>   		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, EVT, IMP)
>   	},
> +	{
> +		.desc = "BBM Level 2 without conflict abort",
> +		.capability = ARM64_HAS_BBML2_NOCONFLICT,
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.matches = has_bbml2_noconflict,
> +		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, BBM, 2)

Hi Miko,

Thanks for cc'ing me this series. I and Ryan discussed about how to 
advertise BBML2 properly in my thread 
(https://lore.kernel.org/linux-arm-kernel/4c44cf6e-98de-47bb-b430-2b1331114904@os.amperecomputing.com/). 
IIUC, this may not work as expected.

The boot cpu initializes the boot_cpu_data, then the secondary cpus need 
to update it, the "sanitized" register value will be generated. For 
example, TLB range capability is determined by ISAR0_EL1. If all the 
cpus have this feature, the "sanitized" register value will show true 
otherwise it will show false.

BBML2 can be determined by MMFR2_EL1. If we can rely on it then system 
feature does work. But the problem is some implementations may have 
MMFR2_EL1 set, but they may not be able to handle TLB conflict. We can't 
rely on it solely so we check MIDR in .matches callback instead of 
MMFR2_EL1. But system feature .matches callback is just called once on 
boot CPU because it is supposed to read the sanitized register value. So 
you actually just checked the MIDR on boot CPU in .matches callback if I 
read the code correctly.

I'm not quite familiar with cpufeature details, if I'm wrong please feel 
free to correct me.

Yang

> +	},
>   	{
>   		.desc = "52-bit Virtual Addressing for KVM (LPA2)",
>   		.capability = ARM64_HAS_LPA2,
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index 1e65f2fb45bd..8d67bb4448c5 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -26,6 +26,7 @@ HAS_ECV
>   HAS_ECV_CNTPOFF
>   HAS_EPAN
>   HAS_EVT
> +HAS_BBML2_NOCONFLICT
>   HAS_FPMR
>   HAS_FGT
>   HAS_FPSIMD



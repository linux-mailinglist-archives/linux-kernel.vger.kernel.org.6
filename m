Return-Path: <linux-kernel+bounces-576274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 095C9A70D2C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA4D1898373
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709271A2C11;
	Tue, 25 Mar 2025 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WFkChQAW"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B7F197558
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 22:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742942754; cv=fail; b=OREHRu/DVTgs8DRKKJQIC1QymvurFiS1F5DVbbIGFMdKwoFR6BYyOsPxVswp1WoRS/EIBVLWzgsUgzeyzZUecS5K9sk6Pv3LiP+62zzhpJGwKQuTvumVqSt6ThsyHeeeNXQ3YAPXw/ZfkAIVLFhMJsAL2bv7H9d3NI26h+y8630=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742942754; c=relaxed/simple;
	bh=1M2rEyyZm4Qj9mgfxn24iGHTOS53EXI7AHH9AvWi+5g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sH8i8/6MdIyH79mVgochxeyYkIimr5DxnKes2VkJFlRMPwO1HsR0zMh68TEWeOlnxm0kt5mxrSbE9uhyuqRv0NbBnz9emkLVzDy2XXH5u8M37QXr4E+UsDpFbUxTGbUMGyKo1hi89zneDELpqDv/7tK/UsbbFVTGExmZhOlJH+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WFkChQAW; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypiBuGrQkfGYAmSXWz5OhF8MX8s/1/TvzwvSesU+Bti2oxB4RDCOHoiwpSj83tgI0PSHQfugQdo2UcDaWRVkEmTqHDmO0bhzFYUqHAzw4Z+tM4N4XFltOI39/PTxp2PEPT95P9DTaIp4RLV4v/F6Er8JyKQeK7313m6YHJWAXtsWd40Wfc5c1lRjv9EhRvI549pr0Vyvsds8Uf45UyrN6ASrUYdDMvtITxoLX3PJNPMBtvFOatsPYg3wZvM9b7q3BWrjliB0JDQNbmPLakHynotZ/XQHnEAuJC+jab5HnFwT8nEgreisvgpp0CN71idIZAQZqthrgqQJq4jBywgxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9kM0q6r5cCIySEzOpdAWI7jKMKY4UPpPraAkhj2sRw=;
 b=XXM6uAi5TeWiB66mmYw4uzX9o7gvaR12t+QZB4GvVkJgVZBw/oqA9lFe7Zg+TZ8VEGBmXeOZ+kGwsCneby/Q4enmCi4izN9tzAaL/cTNsL7ljB5BX7eM30fHdk/E8CDi+Ufaq1Qx3DyQV87tSzr826ZrxjCniBUV6TkGVTQa2ZfvK5VEIk4triQUJMS85z1/SCaF2R+7MWBIrIQQj5EcjjHuc8yzUvCpO2w6WdrKrZuIA4yATg3hGB3EnKJ6yMq2E1kqf4UdsbRkl8FRwIBKtndCgqiu8J002PCL9xDQXrRQwd31lmxrufOBK8wpZgG6IIyMXBCkJv4CZAk+NtIHWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9kM0q6r5cCIySEzOpdAWI7jKMKY4UPpPraAkhj2sRw=;
 b=WFkChQAWYHB1dYxe+iUKHWJdpdOIz6yN611cOmBHzl07jytlsUXcTyrnJytMUeYDl3fY0Uioqfg7nZcQqFIm1zkl0FFvb0bGX85yq5urfIdWGuOuP7FToCHB2Nc/CK41ArtAjeVH9i56KTikJxdU1NxoOP+61GcCsLOnyvYcVQpZ1gNQp615xYN8yxYgcMWIS8KKSmJliNDvY7HTap9edo2bu+4j5iHuNxpwfFX+cZ2nEn1bXYIza8IhuzBzDF43P7XbgtR6KzvhqOr7OsIgzvxI4vJN02XxEvpzIbhnhS4ysXGD0Ofb8L7s3CyvBrhF3OJdWBP/g+Z9f0AX5ExAkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 22:45:50 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%6]) with mapi id 15.20.8534.031; Tue, 25 Mar 2025
 22:45:50 +0000
Message-ID: <261e7069-9f65-4a89-95cb-25c224ff04f1@nvidia.com>
Date: Wed, 26 Mar 2025 09:45:43 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bert Karwatzki <spasswolf@web.de>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
References: <20250322122351.3268-1-spasswolf@web.de>
 <688f2757-e364-45db-ad54-daa6ff1c4f3c@nvidia.com>
 <6e8ad3cd27b570aaefd85395810cc90bb3120734.camel@web.de>
 <7cdbe06c-1586-4112-8d27-defa89c368e9@amd.com>
 <b1d72b95-5b5f-4954-923f-8eebc7909c4d@nvidia.com>
 <938c2cbd-c47f-4925-ba82-94eef54d9ebc@amd.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <938c2cbd-c47f-4925-ba82-94eef54d9ebc@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0355.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::30) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|IA0PR12MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: 73122e8a-2c2b-4066-1410-08dd6beeca72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2F1aXVyM1g2ZFhxam0xZ2JIcGdRblFNUXBTSWF3dWdKTk1VTXl6U2dVU3or?=
 =?utf-8?B?eUN2NkQ3SGVzRitZZUQrWkloY09DZ0ZyUkxJM3FvbjBCV2RvaXlCTHJ6WE5i?=
 =?utf-8?B?SlRxYTkrTTk5YlVMVy9vdEM2YWtjeGhrM3loQjc0ejFUa3VFamlXOTRhVDda?=
 =?utf-8?B?bXBVOGUxdlJYai8xMDVGalY5N1kwcmVYekpiaDlmeHVQcWtoSWthMEFVRzE1?=
 =?utf-8?B?eVdRdFczbDB2d2gwdUl2NnN3bWpSSDhrRGxrblZ6QUo3YmFDU00ycE9ybE5r?=
 =?utf-8?B?MWxSaTA3bU9oSkVka1Vyc3ozRGxXRWJEbHowT2E1azFLeXA3a2VGcUU3MTdV?=
 =?utf-8?B?di9MVEFxaUZSaWIvamxHbzRBcDdrbFVaWE1zWjNjVU95d3N6MGc1OG91b0Vn?=
 =?utf-8?B?NFdiSSthRUlFMHFKZk1KYnNtcEpXTndOcXFSK1BsM0srMzIxN1dTaG9HTHNx?=
 =?utf-8?B?eUJJOGxDWE0vcGhpUXNQUlhIZFhybW5DWUNyWUNtSFpiMDJ6UitIc3V1L2JM?=
 =?utf-8?B?WFlZQ05zak82NTRndE5tSDBqV202YW1zaXl2ZE9sa0dzWktid3RxWXN0dHox?=
 =?utf-8?B?Y0lJbUFUWjhVQVRuUDVObktUbUp5Z2E2MGFxY1pCMzJuMVF1R0d5YXk5Z096?=
 =?utf-8?B?V1FzKzdDemlTMkFBSDZhUW1aaEhOc0MvN01zNjZQWTNCdmhyTWxrU1l0aXF3?=
 =?utf-8?B?dzAyeGxSY3BVUnhOVVV4SXZnam9TSytuSVIzcXZsZHhyWEM4aVJzaWNWZjkx?=
 =?utf-8?B?Ym5kdlVlZC8rMWxpUzhHbzhPZU1DQkFHZjVyQWdmZzZmOVQ0eHZmTXJZcGM3?=
 =?utf-8?B?VVI2ek1KazR5QTI2UWZIUXJrTlE1OVZvTzhjSW5sMUxKSFdTTW83QnZFMGUv?=
 =?utf-8?B?dWRvL0YyQmNabVI4Qi9PWDNDNjVqVGp2dlRXUjAxbDl6N0QxZGlCcGNXaGFH?=
 =?utf-8?B?UExGSW5WZUVvNS9JZEZNb2swYWllNEFrRmNTcWRXSE9BTHhNNTdRcE9FaHRQ?=
 =?utf-8?B?Uk1zOFZuUXB3SzJPclp5TE9rK08zS2s5WWF2c0hqUEUrZ29lQWJOZlN0b01a?=
 =?utf-8?B?bnkraFJoKzRFemhlZ3k0elVzMjUvV0pJRnY1Wk1EQ1FqRVUwRHNtNmxKb2F5?=
 =?utf-8?B?cC9BMWVkY2R6a0wxcEJPV2RaUmdOQXZEdVQ2UDlTa0IxMDdYL1h6YTd6Vnd2?=
 =?utf-8?B?a1lzdm9BWXJIdTBaTW1JbjRsSDNET2xyRnBGMW5ucm95a04vYlZEcVhqMlZF?=
 =?utf-8?B?cHNEakpVdDJLV3Fzc0UwYkx0cGxxNWpYK3FSaHlLaWR3VE5Ld1ExY2dRWENX?=
 =?utf-8?B?K0loU29QWm1QWEtXWUNSd2szNlB2b2IvSzBEK0FnNHBpYitLQlp0Y1p0em9H?=
 =?utf-8?B?bWNoVlFrcHo4Z3NLYWZ5bGFEeUwrQytXZUFUaWNSTXNKaG5iMFo0RkpRSXA1?=
 =?utf-8?B?dzI3UEJFS2hMNG5jaVdOeGZYK0JHZ3pycWdua2JMOXlPMlo1NmJtdjRhZ216?=
 =?utf-8?B?T3g4UHVPZDc5RHZsajdVTXo2bkM5UVRKN1FDTkFwZUhWZ1BuOWJtZzh4WmZW?=
 =?utf-8?B?UFRFejM3N3hJejU0WFo3QW42UzZBc3crWFcxV3hsbzFmSlVNRStkdkcrdUFH?=
 =?utf-8?B?WTNWWVA4M3BRKytqMXhRMFdxbm02VjhpdnJjMldkdHd0b1FDMzVJdjlvSEpz?=
 =?utf-8?B?c1l1Q3ZMVkgvRDZtZ1dQbDZpc0pkWlJTWUIvdzM0WkcxZEwzNVZKRkt1bWJE?=
 =?utf-8?B?REtUMFliVnZZdFlnTzF0TzExbWVxQnB4WjR3ZkY1eVZkOWxtaXVxSGhLTUdS?=
 =?utf-8?B?WU1aR1JjcjVmbWx1N1dIaHJyVUJzaldCZ21XZjkreHdNRWJJVzdHTDRqSUk1?=
 =?utf-8?B?cU50TTlVQmNEYVlHRi9meWlCMk1mUGFYNnBMODBBRUh6VnA3NFRVdE9CQlNS?=
 =?utf-8?Q?K9j1kH5PA7M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVpzRjhra0ZjVnBUUFJ2SVZGSjVMaWlsNEhRWUxVeEFvOUQyWGVUUzFTVHln?=
 =?utf-8?B?MW4zODgzNTdPeDQ2OXRFMUdTTnBkbnU3OU9haWNhZnRPZlhYaHRkTEJKbzZ6?=
 =?utf-8?B?ME1WU2FNUG1DRmlYMXJacHFNcXp0VWRCMjVVTEVmVXhlK0VYM0syK3NjS1Zl?=
 =?utf-8?B?N0VmL2s2S1F6TldTUVlYNGoxSDU4OE9TVG5nVkQzZVJpSWtKVEcyZDk5cWZG?=
 =?utf-8?B?UVRUcEp2WlA1YVFmcTJHMVhaeWtNRXJ0d3NuRExnNnJJZTB1WGtKZXB0L1BT?=
 =?utf-8?B?KzlMUUozRzI4dkIwZUFGNGFMKzFNK2l2b1RmWUJ4S2ZNNXkxaWtERnlCcHpS?=
 =?utf-8?B?RlpBUVU1RDhBd2d0UmJkRjJHaEk4S1VxMGUvbTdpTTJsL29PRTkreUVxNVZo?=
 =?utf-8?B?MjdhOXIyUFhwaU9tbGF0Ny9ZVkV6ODJ2TE9hR1FLZzkzVWxoWjFiMzUzM0pK?=
 =?utf-8?B?RXliU0NJYnJ0NWZ6cHRjd0FTZlBicGtzWG5UYlliUmZTbEhSQnd2d3ZCUHpx?=
 =?utf-8?B?VXNNU0xWMi8rMUpUK1ZGNWMza2RrdmkzNS9JeGV0emdyYnpqdEZUWjJCclRj?=
 =?utf-8?B?Qzg2Uld2K1pzc1dvL2w5WGVKQUUyTE82TDdiMFpzRnhGcDNyZWZKVlhmRGlT?=
 =?utf-8?B?alhZMnp1QjFFQ3N5RlUrc2toNnNDQUJHbWl0SHVzMHFubmlYMWkvTjlUOGtQ?=
 =?utf-8?B?R0s3bGJkTnRMN0cvY0UySjlsakFOT3c3eTdnMUxrckU2M1crODJsTkVkNlR5?=
 =?utf-8?B?bkYxc21xZmlVNXBzMGQ0RkdJUUpTREhjZ1owZlVVMkZuN095VGRNN0Q1QU1C?=
 =?utf-8?B?RzkrSGhFNUpXbGxQVzRobFFxU2pyV2RJRlAyOEZPcThtdFd3bTlPVVlmbE81?=
 =?utf-8?B?Z0xGcm91ZVE1OFNvWWY0VGt6N1hYcWt6alhidUlYRXZoYUdORjlrUkxSV2lI?=
 =?utf-8?B?WExGSXptbVVXUEV6blRjaHdQaUpXQ05SVC9BQW9QVGovSkNMajlvRDJVd3pr?=
 =?utf-8?B?ZEM3eVdjdEhuV2hETkNrSG0xUkZTUXBYeHNVMXZGZnkzTjFuYTBEMEsxMXZt?=
 =?utf-8?B?eVVaU2hSQTJ6TDN2Slk4bXorK2haWDdtZmNJaksrUVhub2M5SEV1SkFycndq?=
 =?utf-8?B?ZlBTMGdCZGIrd3VHS0lyRW1pcU9wTmxtYUZYN3RBRHQ0SmxCeGdMM2RVK0Fs?=
 =?utf-8?B?KzRpOTZmVjJqOW1aeGk1TVljS01KSHp3NEZLWFp5R0FJcmtpUFNDQi9mZDFS?=
 =?utf-8?B?QzJBN2d5bGplMzhnbFRFMU1oSkM5NXIyZGpMMGNtYnEwSDNQY2xTbk5wZnZa?=
 =?utf-8?B?RXBjeWZocXNjbkhjS2YyNEhOVjM1Y1IxdmI5c2FLM3Q5dnZ1U04vbHVuSHhV?=
 =?utf-8?B?OXZ6eUJlQW4yUDRQZWFjMVYzYy9qUmpCYlBGRkhqc1N4UjYzMzhOYXAyWkQy?=
 =?utf-8?B?QUQ4SjFkbkRDWTc2WEQ3MVhoQUg3bDVoaUU0aCttTVpqR1NqaC9sNjNtdE1t?=
 =?utf-8?B?MnF1OS90TW1icWUyb3U0dEJtMkYvQlRPYlFNNlBCS3VyUHM3ZStDV1ZvdlM4?=
 =?utf-8?B?YVoxUW9jWjhGYjZuaE84ekI2Zk5SenhZbjRrU0pub1dISExlSlhjZWJLZm54?=
 =?utf-8?B?N29jU1JraW50MzdMUzZKV1grZnRwSldFN0xvOXNlZHJZWmJuSUpYSEJuVUdC?=
 =?utf-8?B?cDFQVldrL0lSbmxjR1h3azdiNmhLNDZ5VEsxclU4YWkxUHNYWWduK0hDclo2?=
 =?utf-8?B?RStDek05OHBOemhOVWVQNGNoVlpsTlV5MkR5ZWkrS3p1Z3I2T2x0WnphNFdk?=
 =?utf-8?B?YzAydnYzQlYzSmttL1pzdy9oZENhUGFkY1RSREc5N08wUS9FdkQzOHJDR2xN?=
 =?utf-8?B?WUFuZmdYQi9iUGtTb0lKNmJNZWxwYWk2Z1ltOEphTnVUSEhWMkNYWmVRNlFM?=
 =?utf-8?B?QUtkUFFObTAyeWtpVllDUE5jNlhiZUlrOVZGSzNoSW5WNEQ0MXRKaDA5dmht?=
 =?utf-8?B?b2tKZ1N2SVpRUUNLZTBzcmRiUU40WnBZb2R2VWR1V3hwbzJMOHgxSXEvVkox?=
 =?utf-8?B?Y2oyZW5LNjFBbUdXdUFybW1ZcXN0M3p5THk5NlJ0QXVRZmduQUQ5d3F3V3E4?=
 =?utf-8?Q?4H8NEOLLnXgIWb/Gjo/aRDqtP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73122e8a-2c2b-4066-1410-08dd6beeca72
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 22:45:50.0331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KxKVSrbh7YLiLMCGCdqHys6cKXNEgOG9AxCataBC9oRj+2lt68U6bHCGCXRQvomF02Rav1dwMfejj0tgc6EdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984

On 3/25/25 18:35, Christian König wrote:
> Am 24.03.25 um 23:48 schrieb Balbir Singh:
>>>> lspci -v reports 8G of memory at 0xfc00000000 so I assmumed that is the GPU RAM.
>>>> 03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 23
>>>> [Radeon RX 6600/6600 XT/6600M] (rev c3)
>>>> 	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
>>>> 	Flags: bus master, fast devsel, latency 0, IRQ 107, IOMMU group 14
>>>> 	Memory at fc00000000 (64-bit, prefetchable) [size=8G]
>>>> 	Memory at fe00000000 (64-bit, prefetchable) [size=256M]
>>>> 	Memory at fca00000 (32-bit, non-prefetchable) [size=1M]
>>>> 	Expansion ROM at fcb00000 [disabled] [size=128K]
>>> Well when you set nokaslr then that moves the BAR address of the dGPU above the limit the integrated GPU can access on the bus (usually 40 bits).
>>>
>>> Because of this the integrated GPU starts to fallback to system memory below the 4GB limit to make sure that the stuff is always accessible by everyone.
>> Why does it fallback to GPU_DMA32? Is the rest of system memory not usable (upto 40 bits)?
> 
> We need to guarantee that we don't run into using bounce buffers since the high level APIs doesn't necessarily inform the kernel about the state transitions for that.
> 

So effectively on larger systems (CPUs with more than 40 bits of addressing, the iGPU has to 
always go through the DMA32 window)?

>> I did not realize that the iGPU is using the BAR memory of the dGPU.
> 
> When the displayed content is rendered by the dGPU but the monitor connected to the iGPU you somehow need to get the image to the iGPU.
> 
> The most efficient approach is that the iGPU copies the image from the dGPUs BAR directly into memory it can scanout from.
> 
> Alternatively we can allocate some system memory, the dGPU copies the image into that and then iGPU then copies the image into the scanout buffer.
> 
> Some newer hardware can also directly scan out from that system memory and so avoiding that extra copy. But this has a bunch of pre-requisites, for example IOMMU needs to be disabled or in pass through mode.
> 
>> I guess the issue goes away when amdgpu.gttsize is set to 2GB, because 2GB fits in the DMA32 window
> 
> Well I would not say that the issue goes away, it just makes your symptoms go away.

Agreed

> 
> The trick is that the gttsize is what we give to the Steam game as maximum amount of system memory it can allocate. So it most likely stays below that and so the extra system memory buffer for scanout can also fit below 4GB.
> 
>>> Since the memory below 4GB is very very limited we are now starting to constantly swap things in and out of that area. Basically completely killing the performance of your Steam game.
>>>
>>> As far as I can see till that point the handling is completely intentional and working as expected.
>>>
>>> The only thing which eludes me is why setting nokaslr changes the BAR of the dGPU? Can I get the full dmesg with and with nokasl?
>>>
>> IIRC, the iGPU does not work correctly, the dGPU does, so it's an iGPU addressing constraint?
> 
> The problem is more that the iGPU doesn't have any local memory, but rather just uses (potentially stolen) system memory.
> 
> But the questions remains: Why does the BAR move around? That should most likely not happen.
> 

The second region seems to be additional, I suspect that is HMM mapping from kgd2kfd_init_zone_device()

Balbir Singh



> Regards,
> Christian.
> 
>> Balbir
>>
> 



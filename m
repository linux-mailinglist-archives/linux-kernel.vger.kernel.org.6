Return-Path: <linux-kernel+bounces-511426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F26A32AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1F81616CB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE9121147D;
	Wed, 12 Feb 2025 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hV+XOXeu"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FD1271814
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739375825; cv=fail; b=bfzZX4n2I9ZY3YTyc7sR7J1+svHUN28BYfNtYO3cffrwVkA2r46javKQJ0VKp/wBe+1wWy/SPKzdT04idya0GeDiohme3j2HOPpX9qgtN03eVC/0zA0925oE+W5YtJFN/Sq42IxN8AOkvCtFVQ0BazWM6N71TbSjt2UZgE2WUpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739375825; c=relaxed/simple;
	bh=aY89joIy84C9zSUBy0c8krg5wBs9bHkqvuWQ/nE201A=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=orExBRUGUFXT05ClmPu0jB+RyoLMfMX8f7NPf+gRwUmMiipfF1KhPMWD0/QLdfjwnwFPKelSC577/m6DFjDFP/pUjh/1QqzPfHulxWq908W7X4vJ7+Is+b3bK5AcaLCclOpo3WDXjqshZttA3uASDfx/Gx5XCQlIdoeZa7F5BNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hV+XOXeu; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dN0rf6lO/KuNbA35CL4OPodPE10PhvM/lr4E9EbeUKzX6U2zS/dB33NdIXtn2BFrg59RLCroUK5mHZo7Q2yRCSDqC3gKG1RifNNGlToupb0lw2i6NZT7l2E7bIIUUPoQtQI2ACJp6hDWTp3/06gDh0d/kKbsefZHvNEZyU6OhZ1wp1UtOX+I0MKxRRQ6vfSD6D9im0/KBDupxlh3dv2KpiMFYuT1F+QA/YqUiwhusSjbSxZgJMAhGaR7tnqMtq7txu4TjXd/Ls77oGnepbCD7n6IxR6/F92YDcCaYOaq7ojHfI/PWavHis2GZzMnBcaGuMMXlIlfHmTQD4/ketfbFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGsx1T6hnACsltM0j3nut7n0Gdoziy5C1aNJdlQ9Qzo=;
 b=XgS+16BTAxeCxiWgWdHBwp9A25pV8Zp1lYpjkUqw+RNV9wdG0zQo5O8+ayH+RXMEXuBVPJw35Mp/U6/0+fx5JHilotc/QQHVbgCI6+UwuCwI/ULQVbQgSelnzRoLglxgyJj4ZBUunTlPgEpVZxvYS/LcRYxqy+Ezrs+Ds1sGYLM5VXO/gvPvI98E9ezZXkGhUAfpGd8poDUCt+Ay4qogSEIXBHQNqVRNgEjN/LTQBzqVeP2U/0kyNp70JFOqQELv9UZRPPugpT8zJS5ESmG4LJPsxU+lFrZEaRoe77imwSVHpvjAazl+Wl10NUvTpjLkW43dy83Rh0erhWmKbASb+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGsx1T6hnACsltM0j3nut7n0Gdoziy5C1aNJdlQ9Qzo=;
 b=hV+XOXeu4OkEccg2CO7ToCwppuOkjbVI7OEh3Z1Gfkj58+b+GA1w+NwfDtyuN0wmmcr5ziDr5cHTGlIqKXWFodwKDLJEYQouQf5FN1Lj6GKPGc8QvpCJHDUTUiYteZ6+bsY7kwXu+QMB7k1NJhI1ye1Fv6FJR31eZjdfav0Iczg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 15:57:01 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 15:57:01 +0000
Message-ID: <93281f16-4237-b6d6-624e-cc805adb1c37@amd.com>
Date: Wed, 12 Feb 2025 09:56:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Vern Hao <haoxing990@gmail.com>, Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
 peterz@infradead.org, dave.hansen@linux.intel.com,
 zhengqi.arch@bytedance.com, nadav.amit@gmail.com, kernel-team@meta.com,
 linux-mm@kvack.org, akpm@linux-foundation.org, jannh@google.com,
 mhklinux@outlook.com, andrew.cooper3@citrix.com,
 Manali Shukla <Manali.Shukla@amd.com>
References: <20250206044346.3810242-1-riel@surriel.com>
 <20250206044346.3810242-5-riel@surriel.com>
 <CAPguPOhWYV4dKZBm7-bFknDa2Ct5L1Bxc5K+Acox0FM1aAgiww@mail.gmail.com>
 <281d6fd629a1965ee0065f99ac5d693bace9758b.camel@surriel.com>
 <4f63d409-89c0-412b-8d69-371261f305ea@gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v9 04/12] x86/mm: get INVLPGB count max from CPUID
In-Reply-To: <4f63d409-89c0-412b-8d69-371261f305ea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0125.namprd11.prod.outlook.com
 (2603:10b6:806:131::10) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c875810-bd04-4608-a05c-08dd4b7de32f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0JiN0sybC9uWUE5TjdScmdMNWZlRUxOOTkzcE54ZjFHOGg5QStkYTk0VDNQ?=
 =?utf-8?B?TzZvaG50QXlwYkJ5NUR1ak5iUndKR1lvRERlUFFEWW9VaXg4TGw1SnA3ZldH?=
 =?utf-8?B?UGZSM3Y0MWNOOUtCTEpMQjE5K3BOUGlHclhkK05MWTYxNlBSK1UwVzZKN1Va?=
 =?utf-8?B?VWlkUTJBMnJFZk5XWHY1bFBZbWVKTjJLVmFMNU9TV0w0SFYya1pnbzdFZ1J3?=
 =?utf-8?B?dzcrMW5xMG9oamFDcFlmODlnVXZLTXoxZmlmQmdPZm1lRnFlM1FZQUVzWVUr?=
 =?utf-8?B?bDVSYmhuU0d6QlRjcktnZ1ljN3VDcnhzL2ZaMGt6T0xsWXc5dFZtQ0U3TUFC?=
 =?utf-8?B?a0tyTE81cEtWS0lWSWYyOW5pQ0RTWlFKWFRyczBkOVFXYWRLQXZDWHVQV2Z4?=
 =?utf-8?B?T1JmdHJmTjQ2Y3Q1K29reDlxL0VSTU9icnV1VWlScSt5NmtkcU9ielZGbUtW?=
 =?utf-8?B?V3VQTG1lRW1TMzVDbWtnL3Jqa0hYZytmcW1rWHVCdEV4TTF2S1RQN3VCVS85?=
 =?utf-8?B?TVNqR09kbG55MlZ0NzV0ZTNVbll5Zm4xcWFtYkg1R0d1Tk8rTVRwMkdHbCtM?=
 =?utf-8?B?cytaTGdKbm9PVUJvVFF3UDNBRHZYZUcxQmN0OFMzMVBZRjdKdFZrU2lzVWkx?=
 =?utf-8?B?Z3VLcE12UFA2VFZKVlFGa1loWi9HalU4NVJqRkQyTHRPZHhOQTlxcU5UaGpw?=
 =?utf-8?B?cXUzR05yVDg0U0F6Ung5c2JWK2dvdnEyZ0cxeHMxUlR0aHRzajNmR0k0RGlz?=
 =?utf-8?B?alN0OThQdDRMWUxIK1ozZTJzQkRCNUc3aExOaHdJckFiV1N5V1pySTVYK2pp?=
 =?utf-8?B?eDgwd0ZsdnNjSlF0TUxuRlZrckFrZ25HNWxLUWNJTE5pS0Yvakljc2VXNHY1?=
 =?utf-8?B?RE9PcUozSDBlWkhCUVF3bTQ2Uy8vK2xjWjB2Ykw1ei90RkN5SmNwYkNnUFp4?=
 =?utf-8?B?SVcxajhzRVNuKzRPU0VHTmRyS0p1WWIwQk5sMVNkWDZacHlwQVdlVGZJYTZj?=
 =?utf-8?B?RFRqNVNtVWtSS3dDR0pJMHNLZ0JlQ2JCdVpEL2RwM3JMK3p2WGFrYW9DMzhG?=
 =?utf-8?B?eit2dkxEQ001UUo3VHB5RXJwRmFEZGY3RVZvQVZhMDY3TlBUWHlOQ0JjcnI5?=
 =?utf-8?B?OC9PYmhxOFNyQnplVExUVG5pb2pHMWNpSTNBYU1Vak8rM3F3dW9sTU9zUGxP?=
 =?utf-8?B?ZmxyaTdPUmxTQlVmTkdzcmN6cElTZC9QSVd3ejN2dk9kS0NsMmlRYS93ellq?=
 =?utf-8?B?NWxlVXZVS2ZieURtR1hYMnJKdXo1L0hpMVJsN1ZwZnQ1VGRIQzV3VVNtb0dv?=
 =?utf-8?B?NlpHTE5WQXJBRDk4cm9oMk5rY01qN1pPOU5zbVdxQXB1UG5PSzQ0aDJkQm1h?=
 =?utf-8?B?djlETmlyeEVqU3hXN3BGcmtWR24rU1k0TFFzOElCaGtONVF5RlRoMk9obmRw?=
 =?utf-8?B?bVhxVFRIbnhmcThrTUZON3c4U044V1pyZStVNURyNTdrUFNHNkJRZng5Wlpx?=
 =?utf-8?B?SnNtbkRXVUl5aE9HUm13bjJSQ280QmwwK2NHSjQzZ1RlWWpZZ2NSMGI3amlj?=
 =?utf-8?B?ZGJGRG1DaXRiY3FJUlU3WjB6NDMyNHg1dm1QNnlzaXhab0g5U0FMVHc0Kysw?=
 =?utf-8?B?aFVDaUFnZlA5bFJpWW1yM0N6MUhIdUd0WHFndGJDK2hJSmdQZ2ttYWpCb1lD?=
 =?utf-8?B?UmJKQlFCRCtXYTAvNUJlWkZrUU81NUlQUTR4K1FITm1YTlBqMVpkclFNSW5W?=
 =?utf-8?B?Q2g0K3hqTk5UQnNkSDBydEdXOHNRSHFYUjhmUmxFNEJsOGVheFZlcDFiZ1M4?=
 =?utf-8?B?c0lETk9kenNmeXh2SForMngyVEpPVXByeU9RNDY2MVBhalRnN2htTFlPVkZ4?=
 =?utf-8?Q?HYIN1UEmKXu4Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2F2cUdBSWxFNjdwdllQVDc3WEYwUktzM2x0cGRCZmRwck9kU2d2em9EOHM1?=
 =?utf-8?B?YzVDWFBZMXJWclVCMWI1MU4wL3ErYUxNZE1BVERURzBteEw4ajdkLytTckQ1?=
 =?utf-8?B?SUorT25ISFdkNloxT01qdzNtSWdxSlNNTGhhdkRkUVNyelpYb3NNS2Z4UFBO?=
 =?utf-8?B?YnNyRUtpT25IdG1SdWNobXRQazlyTXphWHdUVHFORWdBRjRISzl1UHJSV2d4?=
 =?utf-8?B?VzEzSjByQ3ovdnB2TXQ4b2piMGEvRWJvMm5LbTcvNXZUK21SUlhKU015ekJh?=
 =?utf-8?B?MUFMUGRtMEYxUTJISDd0ekFjMlpHcmlSNlZaVm00NFJ3TFhUZlc0YkIxcUN6?=
 =?utf-8?B?RTVaMVlMUmN4SEY3cWY1OXlmUzJudmFEb2RuY29zVFQ3cDFaM25NMGUvSnl3?=
 =?utf-8?B?aUVNM1Fwc1pzQUxLT3kxR2tjSmlBWFRuSVhvVjZZQ21mUlpnVlRJRDRTT0I1?=
 =?utf-8?B?QWkyb0VNN1U0MW1KRE5jTXpvTHVVQXExNTJBN1dYVVhzWmJ6WVJNZGpLU0p5?=
 =?utf-8?B?bTFFMEpLTU54TXlScGozZXhsSEJRVUtQR2g4T1lvaExVcjRzaHJVSXpJTGdo?=
 =?utf-8?B?L3cxRjN5ZGd2akd2QUZqOURpMWJQYjY1WUhaWUtUMVQvQW5tSk1YZ2E0UlBq?=
 =?utf-8?B?Zk5Kcmc1UW5UMEthdDl4OFdjdm9hb3Zpc1dLQ3FuZ3VFVmt0SkRaYXVSaXlt?=
 =?utf-8?B?SmVGN1h5RzV2TVBscmhXTlBkOVRrTDRyQXRhQjl3ZHZSVm85MStyYXVyNG1H?=
 =?utf-8?B?RXcxdkRGM1g0ZXFMQW1zNEtMNkw1OUtvVTA1QkdCMUR0RTJDQ0x4TjBxZ3lH?=
 =?utf-8?B?TUNTR0Nyenl6RDhsWiswenJNd2VEYmcxRFA2MkRBT3FiNFZRTFBhTXY5dGZI?=
 =?utf-8?B?Si9YVVZOMDVHWmdVcTZKbXlQclVZcEVyU1ZURUZCazdvYWVVb0Z4OU1od2tE?=
 =?utf-8?B?dzVqV2E1QjNNSjNQVG45S2FMeTQ1N0lOelJrRjRQdGw0Q2s0TVc1Z0FON2VJ?=
 =?utf-8?B?UmNvMTZrU3ZNZzBoaXh5NTJBVVplQXNWcXpEaTBwVkgvS3QxeEZwOHZ5UUxh?=
 =?utf-8?B?NE8rOFlLNy9WVVhCakdOZnlTWlZmWjRrMFhHVm13ZXRSMitjRmhhbTlmSUh5?=
 =?utf-8?B?cytZZEQxelVTUm9LdzB4L1QyazF0ZFVpOUpLR05vbVEzbWVnU09JaklaWnVH?=
 =?utf-8?B?eitjbWlRSUsrbWtKelUxN2NjTW9HQ09CUnVVRnJGT3lFUi9SS2FVcm9kMTcr?=
 =?utf-8?B?aXF4YjQwWUtyUzFOKzgzempQc1pBMlBEMGFveWpWZURUcEpNY1VLa0JEcHNL?=
 =?utf-8?B?VG1QallBVkt5WEVId29ScjF5ODdhUG50NFUrMEhqQ2U5RDRTcUNzd0tTZjlL?=
 =?utf-8?B?R1RSQVFNdXNiK202Q1BVR3hOMk5wY1ovOXE4UUQ1di9kalpZL3VTWXUzQVlt?=
 =?utf-8?B?MjFBbStlQUg4VzZzeFdNS0QrWHN2YW1PWkllT0pxQkhaNE9ia1dyZVhPSys2?=
 =?utf-8?B?YWR6czV3YnoyMmlMUGloSU1vUHQ1QUk3eVNCajJzRk4zMmd1Snd4U0I5UTBJ?=
 =?utf-8?B?dDN2Nkdpd2xMM2FWcVR4N0RKTGIxVTJJMTRZbDJPdU9EOERmeHF3WnJ1bFNL?=
 =?utf-8?B?QXdYckxwUHhXQ1VCRTVNMGFyVFh0dWhQWkdrQ09OU1k4TUtVNzRNZ2NKWktJ?=
 =?utf-8?B?eHY2Sjl1MTRqQWVmNkxFUW9xdmNaZTZiejJqN0FsRFVyTVoyMVRYZGNjbTho?=
 =?utf-8?B?alVYUFk4YXJHSjlzUnp0bVVYT1YwUS8zaG9VeTBiRWpjRHAyU0xQS29jTXZG?=
 =?utf-8?B?bC9jQnptY05iN1RVV2Nkb2pjamlWQndRQXNqN29VQXphMjFzek9iZ2RFeGlv?=
 =?utf-8?B?MzlGNVBBTmdIQ0ZqWjRHblY1UGF3ZjI2UExGc29sUUNZV1ZFZFpKcDk5Qmlo?=
 =?utf-8?B?NDFVZ3FKZWVsU2lVWFhweGQzN0JIOEx6RFBMc1VTZVk3Y1BYK1ppWHZzTVV2?=
 =?utf-8?B?LzZ0K2k2UnBCTzBzMTR3WWJybEFKUUFSQWkyMkhYUno3SmRnRHJodGNRMjBW?=
 =?utf-8?B?dEFLVkxJVGsvZEZVRUxjUWJIejhHRnhHNzFCYitrOGtEZFdWVnIwVG1QVjcx?=
 =?utf-8?Q?Iu4HVZERxZb6ltsFmzGYI5BYS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c875810-bd04-4608-a05c-08dd4b7de32f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 15:57:01.3460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jiup/aBt2tfbElf82oeK5T0v84J6hWMbJn3QW3P1GoRMARluUpm5A9nD2S7i/r+beLUvKeh7QjfFBw4kb4TtdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279

On 2/11/25 19:57, Vern Hao wrote:
> 
> On 2025/2/11 00:48, Rik van Riel wrote:
>> On Mon, 2025-02-10 at 15:30 +0800, Vern Hao wrote:
>>> I do some test on my  Machine with AMD EPYC 7K83,  these patches work
>>> on my host,  but failed on my guest with qemu.
>>>
>>> in host, use lscpu cmd, you can see  invlpgb in flags,  but in guest
>>> no.
>>>
>>> So are you plan to support it in guest?
>> How exactly did it fail in the guest?
>>
>> Did the guest simply not use INVLPGB because that
>> CPUID flag was not presented in the CPUID that
>> qemu shows to the guest, or did things crash somehow?
> i support these patches in host and guest, and add this patch to support
> cpuid flags in kvm.
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index db3838667466..fd21d9438137 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -488,7 +488,7 @@ static inline int __do_cpuid_func(struct
> kvm_cpuid_entry2 *entry, u32 function,
> 
>         /* cpuid 0x80000008.ebx */
>         const u32 kvm_cpuid_8000_0008_ebx_x86_features =
> -               F(CLZERO) | F(XSAVEERPTR) |
> +              F(CLZERO) | F(XSAVEERPTR) | F(INVLPGB) |
>                 F(WBNOINVD) | F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) |
> F(VIRT_SSBD) |
>                 F(AMD_SSB_NO) | F(AMD_STIBP) | F(AMD_STIBP_ALWAYS_ON);
> 
> But  in guest,  use lscpu cmd, i still can not see  invlpgb,  so  i just
> wonder where is wrong ?

Well, for one, the INVLPGB instruction has to be enabled in the VMCB in
order for it to be used (unless it is an SEV-ES or SEV-SNP guest). Also,
lscpu won't show "invlpgb" since the patches don't define the feature in
the way that it would be visible via lscpu. You need to issue CPUID to
see the bit is set or not. Also, you might need VMM support in order for
that CPUID bit to be set in the guest.

But, it will take hypervisor support to use INVLPGB in a non-SEV guest,
since non-SEV guests do not use global ASIDs. In this case, the
instruction will need to be intercepted and the hypervisor will need to
determine how to process it.

If you have an SEV guest, which use global ASIDs and use the same ASID
for all vCPUs within a guest, you can use INVLPGB in the guest without
issue and without needing to intercept the instruction.

See "Guest Usage of INVLPGB" in AMD APM Vol 3 under the INVLPGB
instruction documentation.

Thanks,
Tom

> 
>> My understanding is that while INVLPGB can work
>> in guests, actually implementing that is a whole
>> other can of worms, and definitely not something
>> we should try to tackle at the same time as bare
>> metal support.
>>
>> A TLB flush hypercall, with IRQ-less flushing on
>> the hypervisor side will probably get us 90% of
>> the way there, potentially with less overall
>> complexity than actually supporting INVLPGB in
>> the guest.
>>


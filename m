Return-Path: <linux-kernel+bounces-331903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAB797B2AB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC7C1C21BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A655D178CDF;
	Tue, 17 Sep 2024 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i8zN0pWO"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DAAE57D;
	Tue, 17 Sep 2024 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726589541; cv=fail; b=VhXkTrMPO529RqQPxLpoFn2dWHRPGyzkv+lnFjYxQSOlRTmkpnmspQ+OW7gCxd7noSQSIGhr62H/+unxfUlYdkEQRc4LpkDXiuSSh0aFFO97ZuYOAHI7+Eu7rCp247gVr7SrZ9S1uzqpY26GnFphCxf4/3vw0KxpT7HtQXhyBY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726589541; c=relaxed/simple;
	bh=g2qRwN9NqXWttbMCOaPeyCSr4PE/SoeSldGOzQj97+w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dyJNXhlaEDGTNbMfpRhvov1z285fNg6M1wV3xpIeYm0IgfjyMcU4UwFEaxscgAN3dcMmCfOyx7XkK5978iUOpSPSv+DUBT74R0U3bzORaq6ZGH44zYFoRUBfMF6g7GcBuL0eYXoTbHcJ4eKggB9f5z//hPtYF3L+AqP3DOpJolU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i8zN0pWO; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtsR9W9yTpq00jFSXZtOy+8w8WjFz8DP2sWoTFK339FG+LfPbOy2wQC3umC1EfSYqv5MSWvBB9TA/I80LUWHlf76SiHravXCbtDH3bIyxB4Ot64fHlQM+G8jLxABsfNMVQaPzlAu9dR5gvNbhJ1SzST+Jxxc+Hv+9wgjZ5teepI+61yQa4V0w5RKr74XV56m/+WDM9gW5KSArd54HTnXNsyzCQMqdqvHuaVK1yTzZdHnKShaZFaZkRndKPvUvOVNLQdPYLaQeorBCOq/D+9HSpyJZjGIQxBIOsgLZ001Z/61qEllyUzFXfyadVQ+Gr9pTXwvbZDsU3iCyqxDHJhfDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FoY6Jm6JOU0m/YeBpQSgN8OhQC9RPtxkiXU07NSSE0=;
 b=KZbK2Z40SG/y5DBTYVt1Yshq88WlwoU/3COXDAQoaSvvnqzcIeU/SkSn00BYjcZe4iaj7Bv0CpgE812FhSdfmO/q5Zwh+Ck+YOF2hL1XiVFVJ+4nMJiavrAL2tLD3BALF+X/uSNhJcm8m0y6j57nNncf6tr9Z+oQqXTjjJ+qIjSZs+6aXWLDZz2W3SPg6Jm7gRV0Um+QDvCvAiIblXFWMeDBW4OsKs8yhOMPjzQ0Jk+0SSk5UcsUFx3rauV84UXEKDglt6dSRQfTUNinmjxywN/a84hN3FDfAgwV4Cpl4zOesnnS7Tzd5TkKnomO1+sECiUGbwv/V0/nRt70gfW54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FoY6Jm6JOU0m/YeBpQSgN8OhQC9RPtxkiXU07NSSE0=;
 b=i8zN0pWOB07J7UkWfh92yHsdoQqZ5urjx5fetAQ+rXdsVBukBGO3blAhXWBeFjvQ64CM3pvPfR+ctF2EhuXesfHJos799+MECUFLXYDN4V1nXGli1kNeC+yxAZnAJ48nxAIhK52u9JGQ9VHwiq8LNBPvIsWszwUNTN5ZSC9WVM+xzz7ysswdxb22YoLwc0R8Tr2WfcsieSjkZNf4t11gCzEZXRArQiLCWNMs6QD5Vq3eTkpCIj8yUsJdRv4TIkjFqfowel3paAICkJ03jBKv4DJLYW0/49yTqb8f7d5FTjywbe4fvzUAuvH0sGb0oiqKOVB3rFHKCH7JveAyXDpunA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 16:12:16 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 16:12:16 +0000
Message-ID: <c7c4bd25-5fcb-43a7-9f89-389e50784e07@nvidia.com>
Date: Wed, 18 Sep 2024 00:12:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm_mpam: Fix T241-MPAM-4 workaround
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>
Cc: James Morse <james.morse@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Rohit Mathew <rohit.mathew@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vikram Sethi <vsethi@nvidia.com>
References: <20240819220818.201870-1-sdonthineni@nvidia.com>
 <20240821124247.000067fc@Huawei.com>
Content-Language: en-US
From: Koba Ko <kobak@nvidia.com>
In-Reply-To: <20240821124247.000067fc@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::20) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: b5cbe3de-da95-49e3-f07a-08dcd7337f3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0N6ZUV3NGJ0WktOS0NUOGtSR2JJN0VrRVVWd0JBN3E0cU1JZzE5V0JDTkNa?=
 =?utf-8?B?OHFZcUQ3VzY0bEU3eFk2dUdGVkM5MWVtTXhJQkF0T2owN1gvL01tZFFvWTc4?=
 =?utf-8?B?cWw4UDJWbVFrMFFacTJpRzJXOXJxUU5mSTZqZ0dnb1BXZEQ3K2xST0oyYlpC?=
 =?utf-8?B?aWU4NVd0dXM5ZlE3c3pkclJmWUxKMlc0QUU3bGZYcytJVlhCeEN3d29sYndP?=
 =?utf-8?B?RlVtYmw3RGMzb05CK1hkcmlGaG1iYWlnZHIwT1lWK1YwWlN4eXR3bDE0bmE3?=
 =?utf-8?B?Y05yREZjazlWdTk4MllxOXBSL3Z1dXV0cFE4N3JBalY3MDJSMHlsdUdZVUVr?=
 =?utf-8?B?V0d4Szg2dkQwbVhPZFBLMVdNcnkrZ2FVelRQdThwMEdMc290cmxKQ1hRWlZ4?=
 =?utf-8?B?ejhwcWV1NFdlMkhOdnRhalZFWlZYVmx0QlY5NVpsYTVybnpJSUIvYjRuVFJE?=
 =?utf-8?B?TGdFVXB0Y1A4eVFCL2N4SVBTOWJsTWtKbDYzMXVqaGorRnhXMWxkMTRGYjJG?=
 =?utf-8?B?d1VkV3BuVW9PcHlLckx6azV4V00vMmc5SmpWRTg4SHpLOGZWZDZaYXZwY1ZQ?=
 =?utf-8?B?OUJoSTZHbDRYWGdwZ2ExditKeW5xT3Myem5qWTA0aHhzMkpFZUIwNWxNbnE3?=
 =?utf-8?B?ZWxSbm0xdUhuRlFaNm5MYStwR1dWTkphR2FWeDVPdkJBZFAvak4xNDJMalNH?=
 =?utf-8?B?WWFYVnZRLzNBWDFZQjRRSjI5YTc1UGEwSExEUnF6V1VtRWFHWHllQjBtR1NG?=
 =?utf-8?B?ODZvM0dRVHduTTRLVk1JYnR1WjdkSDM3cUJnY2M3TWN0cXl4d0FxYjZjcDJx?=
 =?utf-8?B?NkpPRlJOK3VvUElZVFVkc1Y0VmlNWkdBNHlzZmJzQU13b1RhQk51RUZBS1Fp?=
 =?utf-8?B?RWQvZVJFL09DRUtmd3hkN1RoeUpySWFpYTluQ1NoMXJRTUhEcmlIeElGeWdS?=
 =?utf-8?B?bUE2bUo5K05DV1c5RnVXSzZ2ZVVSNzJTakFGa1dFU1Zib2s2bXduOHMweXBw?=
 =?utf-8?B?Z1g3M0xLWG4yNlpsbWZDM0UxU1dxUHh3ZjBBL3lnR3B6WEthclNVandoU0cx?=
 =?utf-8?B?cnBxZnNMQjZYa0QwVWNKaWlMREN1QzRtdWRNY3gzQmh5Vjl2R0ZMRjRTU25H?=
 =?utf-8?B?Vm0vcE15ODNDMTdpVmJMbGRaUlBpTVE0dytCVDhadTV4QTNiSFE0cktQN1oz?=
 =?utf-8?B?dXJ1SzJQN3NvdnBDeUFtWmgyd3pCbUZrYXQ3KzZnZnJESVBVNWJLbzFHcDg0?=
 =?utf-8?B?Mk0rVEJvWDVpc1lCbkVuSmJjKzV2NlQzbTN4eTVkUTdPY3o5WC83WFpndGVG?=
 =?utf-8?B?V2VpdVVWc1EveS92SnI0OG9zVFZudGhERmRvQVUvclRCdE5OM2RFSGFuSTYw?=
 =?utf-8?B?RVZCOExWMDNIL2ZRRmorT09yRDE5c1RmTzBOeGhBakRGeU5QYnBERysvY2Ri?=
 =?utf-8?B?cGpyZ3NXRE5pVW9ldHB4MHNEeGJBcEFZWGFCWVlZM1M5bFZ6OHM5R25LWEx6?=
 =?utf-8?B?NXNpL0ZxZnpweXpWUUtBeHM0cEpMSGwrbXRWSDAzeDlPNkFPR1M1MEN3VXJ4?=
 =?utf-8?B?T0RyTDNPTTArUXFLSHlrQUxtWkMyMkpEYWlxM0Z5OTkyeHpyaVlsM041dmdI?=
 =?utf-8?B?bVdsbFF1R0ZDNVkwUGUxaklBRnpyaTVLMUtuSEJkb2Q4Y2lXWnlqUGN0Wmx6?=
 =?utf-8?B?amQwT3lDZExreVNYWFR6dUlCNzZtUDZKTWRCSzlxYTZEeFR2dlpoQ2l6TjN4?=
 =?utf-8?B?TnJRYkd3RXRKUU5BeFNXSkN5R2J0K3cycUlpWHdFbjFPRkQwMTl3RXU3R2V5?=
 =?utf-8?B?L0VPY3dmVVNYYjFJVWR6QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WS9CcHpOSGo3WDNpR3dCVUhGS2pKa28vZ1Y4cFBtQjlGV1dmd1JYTkZsV1FC?=
 =?utf-8?B?dGJxbGZWU0oxU0hBTFJzN1RuTjVNcFNQb1FvOHIvN1BuU1h2TTNhYm9maHhZ?=
 =?utf-8?B?VVV0SnJwWWJmUlcvYmRFTitFMXFmYi9Vck5zcWZEOWtVTlVKL3BWKzdlSTNp?=
 =?utf-8?B?d25aejViZXY1c1hBYzAyS2xMdVBaaDhJcjdYZjlkb1poaGJiVUFmYkFWdXBx?=
 =?utf-8?B?TXZrU1FCN3FYaHVrS1czcFU1OFNGWldvRjc2bks4UWJBTGc4RnJ2OFlrcDRz?=
 =?utf-8?B?YStYZ3JrZXZYb0VidlRlUlJNSjNMNGtmSnRsZElhQjJtVDNWYmttc2Q0eUJr?=
 =?utf-8?B?QTFuOGh1N2RMaHA0cUpZN0VQOFVGaUkzb0ZMWk13RmxXaU4vNk1GRUlqTy9Z?=
 =?utf-8?B?ZGhDaXovSVR6VExteWhhODZaMTMzK3prMnJZTVU1aFdwMnU3cGZvaU9RR3Vh?=
 =?utf-8?B?eTRQR0ttRmtGNTh0T2Q5QmxIQnJTTU5nNjhqOHppNTRlTjN2VUZnb1g3WW0x?=
 =?utf-8?B?M1dpeGFYdGF4RmlqK3Q2Ynp5Y01OWE1VelNFaDZxODBmK0F2SFpZY2F2akJ4?=
 =?utf-8?B?dnJCdENhRmJhVGNQOEdKUkZ2alZNZWxLZmJMN1poOTk1TlZHWHNheFRPRXpz?=
 =?utf-8?B?Tk9Jbzl4emQ3cHRBdlREbFZjeVNocFljMS9JYmRmZlFYc3NkU2F4c3NWbDF5?=
 =?utf-8?B?MVEveHl2QWMrWFNWc2xrbWJWYTh1dXV1RldHcDRLSXVIWmN1NU1DQTU5OWRl?=
 =?utf-8?B?ejN6WS9LWFhBZHhmcmt5a0tkRy9tUzRTRzNZbmFoN1JkZzZla085VkJDUXg1?=
 =?utf-8?B?RDVKZXEyRFVoZllOaU1CMC9hampXM2tDWEZnTlJOOXg2V3dISmZMZm94MEtW?=
 =?utf-8?B?K2xYSE9weEcvSDBmS1BIOEl5bkRwYm5MTWpZRHdMSm9aOGxjbVoyeUIyUC8x?=
 =?utf-8?B?WUtBZGhjUzRMdGdkSTQyOVM3dk95ZHBpTlFBekxXU2tDNzRHME1hOXVjUTBo?=
 =?utf-8?B?T090WGNCSHROZ214VVJid0h6MTAwbVBYMW85OFNIZmRGbTY5MFp5SzZDWTJK?=
 =?utf-8?B?VllSOHlNSzJyaGg3T0lBdkV2QVdqRW9QUVBHTnpOQi8yR0pxVThNcDUxVGlo?=
 =?utf-8?B?dmpDQVBCa21lMjg1c1ZwRWVTdjI4alIyZU56SzdmQTNDWEo2OGlmbmFzMDNN?=
 =?utf-8?B?QW9FZmZURzg0d1REZ1IvbC81MEV1Wks4TlZtSk5Ib2l2R0JBck1EZW5nOG1T?=
 =?utf-8?B?bElNMEk0Vkt0S2ZNVEpndFN0RmtQNW1SQXZ6Y1hVMStHMXZVUmk3bk84SjVS?=
 =?utf-8?B?K0NpTFNRSnV0SkQ0M2E1Nkl3N0lOZnNmVldaRnpVRDJNRlJuK25iaVZaalNE?=
 =?utf-8?B?ZGo1VTZYUURVN216dDNPS1hnV3JWQlMzY0dyajY5VDJBalA0YjNpNkx5enJ5?=
 =?utf-8?B?V1NRU1hueEo2QStqWjBlYzF2L0hmTUxyUWRYbGczNkxrSGpCelZ4ZzZNR1Rh?=
 =?utf-8?B?aVhaT25qWWU0UXg4Yys2Y25TZVN5R3NnMTRHNWhTR1daMWJwTzFDUS8weWd4?=
 =?utf-8?B?QXNYVGFVcml1WUdGOTYyYytYR2FGUUtibmNNTGF6STBQL3JCcGxWbE5SckNl?=
 =?utf-8?B?R3hwbDRPdG9iOXFTQU9ucUg3RnYzTCt3WDgxRzFiSWtVYkVrTWd3enZRbThI?=
 =?utf-8?B?WXFOdmk1VEZOODJUTXBYZVRJUmZpM0Vjcy9ha0gxQnVMVVNBUXRIaTUyZkN1?=
 =?utf-8?B?N0JIQzV4dnNIWUV0SmFHN0Y2WVBwSWtmemQycXlWdFlzWTlMRjMzalVHZGFh?=
 =?utf-8?B?VllWcnVrRGlRQmxXbjd6eEpUUklrWm1hbWowY2J1U3p4ZTYrZVdFS3Q2bGpG?=
 =?utf-8?B?SGh2c04yT1hjK3JnSVYwaVMvbUlKaHlBdHc3QUp2dGhpd1U3dWhkVkhDU3dS?=
 =?utf-8?B?dHJUVzhEYkZhNGx6TGU0RVh3bHFPZWl6K2M1M1VvRW4zU3E5N1A0ZTRLS0hk?=
 =?utf-8?B?d0Y3MWh5d1RnM0FpaFo5S2hWcmNIWDFVb0NqN2srTDdXQlJGWXA0ZUxib3dz?=
 =?utf-8?B?UDdyTFBSbTZiZDlFNkR0bVZ5T2RvM2RaQUZ1enBpQ1dsRzMyelh0T1VnSWtP?=
 =?utf-8?Q?f36u2CdLz4qkwV38dfiHV1Gte?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5cbe3de-da95-49e3-f07a-08dcd7337f3f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 16:12:16.1207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6U9d8LxjBB0dIrjXCJ2F90UzixFGZwxpA6Hkwbv1WdaNv2BynCqZa8mKhjD2ZISYwuKtFKXVr6yj2fmqAfL6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074


On 8/21/24 19:42, Jonathan Cameron wrote:
> On Mon, 19 Aug 2024 17:08:18 -0500
> Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>
>> The workaround for T241-MPAM-4 was applied incorrectly, leading to
>> MBW_MIN being programmed with a zero value when the user specifies
>> MBW_MAX is less than 5%.
>>
>> This patch ensures that MBW_MIN is programmed with a non-zero value,
>> set to 1 to fix the T241-MPAM-4 as expected.
>>
>> Fixes: 13ff1b527e40 ("arm_mpam: Add workaround for T241-MPAM-4")
>> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> Hi Shanker,
>
> I can guess which branch this fix is for, but good to mention it
> in the patch given it's not mainline.
>
> Jonathan
Hi Jonathan,
could you please share the cgit of branch?
Thanks
>> ---
>>   drivers/platform/arm64/mpam/mpam_devices.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
>> index a802ca1c9f05..e49a27c02c66 100644
>> --- a/drivers/platform/arm64/mpam/mpam_devices.c
>> +++ b/drivers/platform/arm64/mpam/mpam_devices.c
>> @@ -2990,7 +2990,7 @@ static void mpam_extend_config(struct mpam_class *class, struct mpam_config *cfg
>>   	}
>>   
>>   	if (mpam_has_quirk(T241_FORCE_MBW_MIN_TO_ONE, class) &&
>> -	    cfg->mbw_min == 0) {
>> +	    cfg->mbw_min <= min_hw_granule) {
>>   		cfg->mbw_min = min_hw_granule + 1;
>>   		mpam_set_feature(mpam_feat_mbw_min, cfg);
>>   	}
>


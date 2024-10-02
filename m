Return-Path: <linux-kernel+bounces-348182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDD798E3C9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43FBD1F24C27
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719892141CC;
	Wed,  2 Oct 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ftFImNGX"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022087.outbound.protection.outlook.com [52.101.43.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9E61946B9
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899231; cv=fail; b=SUvgRT2lM4h21cNc3xy7QvraG2w/SB2P7VLrAdSL8s1VTuBQPUFn5IGq0MdwfB9cT4EU4U4gl1AlFzsAsdMojeHeFIHThQvqG5XB5DHRvt2yQVSPG2EKHdUtltCzwIdN6wBZrOCPAQmr2Z26cTaamEzuwj+LOyx9eb6pZQf5M1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899231; c=relaxed/simple;
	bh=WzBJy7tMeIOvG6NspFZLq8EJNsO3T7Jb4rekopjQRWw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EKKuvv3sUY2Z+HGJC4X9kc3++rPg1YXn4+qtSgN6WmdZPCRSXDYTNuTZH/G01U8Jx5n3GHckkr5b25QVfhkO/UG1vI7clrz8HFQBbbWWO3p9lSSn6IIMNQEUqKhrcwZcDbyzdJIWmyalMBv4KvUWprEwf6LjmMXcTObqWiW7syw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ftFImNGX; arc=fail smtp.client-ip=52.101.43.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZflSDcHU+7xOwVOFwJF+CtDV/O7t/XLZ+BjpMnr1uWMKI0Oua7YXsSjBr+aRLsz8013+63Ca/0p1uSgTeTtk9GsyGcid/PrSjeOOYtBK3qZN6SDxQBolt1IEqoLgz0ebct4RGm4Z7XhZBEvh8SoRNK8A/JEDA8pyjLC6f/oIr+5oDKf0fNIzcE1K9Kb8ttYX8lt051Tc7TzYKjVdLBUOwj7HPm1NCY3xuQDD9nR9mPHQdrMPoKzNaKnbMjSGdZMzPRngZjQqjxwRcH2qe4Yc/tAmuYlo/+HYKpNum1YQtE+A2NHLtNV9ciwGeyjc+kpIi9bLWf65AqBzKR/u+2/g1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LdxIrl9+gDkWJL4zmP3q6Icc7sz84xfDJMG7/m2M54=;
 b=U35njyngutIMTcTEWjbWJc8H463Jh2ffn5agekcpL1rUa8fWpNLKL7r7VZx/oPilXxNgpEvVdKAT0t6R7A/BbfhG7pT2lU2FS4n0D87qRkv8hoXBEJkN//CxZYtZgbWwhd+66CMcxC2BiddsK9lLjb1Zx0qINR8QhfPgkn+UhOnHh1DJwhPNYt23g9hqBi/+U6WN5+1w4u0ib2eeEuP6ljXqzFkRfbPsoD2mhLfQKafoB41ptfMvDnPvRyfIaxv76Bbi2GV88nCkCXqUfkLowwR4/y1qh+4/gueQ9OHBxgNnS65fzntmvE1bcQ6I1PfVzM0Oam+OhYsVxXeHhdkMsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LdxIrl9+gDkWJL4zmP3q6Icc7sz84xfDJMG7/m2M54=;
 b=ftFImNGXYN99FRD6I/vH1OuHMOg9FsUg2qa5Q21AvoTwnhqtoWBNX6+HVOjQ2jUu9tluNhNuAgYx10MyYnjTSu3kg7sR7fCiBJynBpwe7PED7TXNIoiF4LDq2IeAobAj4rdDbY20a/4Qwdvain4UM+bXf9zxLyidvAAceRUZZsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB7893.prod.exchangelabs.com (2603:10b6:510:286::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.32; Wed, 2 Oct 2024 20:00:27 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Wed, 2 Oct 2024
 20:00:27 +0000
Message-ID: <f9933026-4756-403c-8f36-cf64fced8ff9@os.amperecomputing.com>
Date: Wed, 2 Oct 2024 13:00:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
To: Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>
Cc: james.morse@arm.com, will@kernel.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241002175514.1165299-1-yang@os.amperecomputing.com>
 <Zv2ONA2b3+kMAizm@Asurada-Nvidia>
 <1c9767e1-4d05-4650-bc14-65a18fc63cc2@os.amperecomputing.com>
 <Zv2diJDU6v60hKtU@Asurada-Nvidia> <20241002194004.GT1369530@ziepe.ca>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20241002194004.GT1369530@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0056.namprd07.prod.outlook.com
 (2603:10b6:a03:60::33) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e7037d-3815-4459-fde4-08dce31cdc51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnhGQzZZbnRaVldkSzJVWHl2Z3ZJN0puSXZnOUp0d1dNZWxpV2F4WmdDUXhk?=
 =?utf-8?B?eUQ3SElxcDIrNnFhZHFKZ1JqMzRmN0plN1FDZXZlOGFDTlRvTDl0WWlwVkdl?=
 =?utf-8?B?bXpzdW1lWDBGU08rVmhJdmEzZnRTLzNmdHJaQ1BLWnNKWi90ZUQvRkVKemJ2?=
 =?utf-8?B?OWNmdCs3QWYrOTYrN1pXdTFkeUJaK3c3WWorQ2lObHlCdUpSWE9VYWRHV2Iz?=
 =?utf-8?B?ako2MkpPZ3RFSklmc0pFdVJ4enZvRGR2c1NJbzlaSHpIRUVHMHlZc2JWUlha?=
 =?utf-8?B?MEV4V3luTEVZZkQxL1BXc0R0OUQxWVRkdFJnOGFyRkQ1RzlwV2FyYStiK1lt?=
 =?utf-8?B?U0Z0UDBPSkNIbXBxZTh3VEtHRDRxa3g1S2hEVThuOEJ4anpUNlV3dmhLby9G?=
 =?utf-8?B?TUZoSHlQQTlJR1lITW9Kd0FZR3J5eEFYNnoxUEdkOGJubXp5N2JFSlQ3RlZQ?=
 =?utf-8?B?UlE2amtoMzdJTyticlF0ejBQd0hEZkJEVXo2WlhFVkJQUWllY0E5VDRjSDEx?=
 =?utf-8?B?TlUvUVc3dlBPbG1nNzNDUDNqRnlyK2RvTDVVTGw2RnNhT2Nxd1BOaUtwMmZQ?=
 =?utf-8?B?dXZ4MnBVNVlxYzhIVzI2U0QzOU9yNTUvUEZjNnE4eTd0dlJDVFJRT010Y28x?=
 =?utf-8?B?bDFKNDVVKzMwc2podnZOdUdpbFBnMktvU2JmSGwwS05ha2cyWjlJRDJDUDZK?=
 =?utf-8?B?MFNSa1RoaDAvMFEzeHlUOEhvbnZCMVQzdC9hL3pzSXFXMTFLVjdvdzM2RHFE?=
 =?utf-8?B?QkdqWW85SUtjeUpaQ2FOVGlGZVFmS2JBMUx0OE1PZzBlb1FtM1ZsaGQxcnU4?=
 =?utf-8?B?bGkwWGQ4VGZIbm9hajNKMmRjRjZiWmI5QjBWdGZZN3NrM05IYVZmVVQ1d0Ju?=
 =?utf-8?B?ZW15SFZnV0ptMVBDNGlkY04rMUlKT1lIbkwrMjVqN3lkUkFQekRtWUtLdGtC?=
 =?utf-8?B?dHdaNUlURFRnNG41WWZjM1hmSFJUd013RFlCQ3V1RkFhdUwwRkhSRlMrMGtC?=
 =?utf-8?B?NGw0TGE2dERNOTNBQlhxMlFkYTZpN0FKSE5FcXhXWUlLZGt2WE9icUtiZ3dK?=
 =?utf-8?B?Z2w1ZmROMnZvS3JSaHY1QXdNWjczRjIxRHB0dzRKNG5MTnNSYW1yMGdrVWw3?=
 =?utf-8?B?VmRuby94WmpobjRPQ2h4dUw3aEgvb1A1RkdzWmc0TE42Z1BKcFNQY2xnZ3Zq?=
 =?utf-8?B?ZTBaL244V1M0K2I0eXdCbjhLSnVPcXdUamt0dWVjMGZRd2ZRanNkSXBYVmlX?=
 =?utf-8?B?QndFTUdXQzYvUnVzcndkaVVrY2ZDWHRCWFhCVzA4ejBCaUJCWW9lQjNMS2ZL?=
 =?utf-8?B?YmhFbzNqTWExbWdyd0x0ZWVnR1NNbVpyUnJLRzNPZFdjdU8ybnZDM0RWemx2?=
 =?utf-8?B?YmhlTDM2blY3N2NUUUFNZHE0YktEMGxWZW1RYW1rMkg4amwwa1dLSk9tblNF?=
 =?utf-8?B?VVhOUGpEL0VySVR2ZGxZMVh4cy9MMjZQOFpNTnpTVjlEc3ZhdmsrV2huRS9q?=
 =?utf-8?B?MkE4QjQzQnZYWC9SLzlHREh6UnQwV2tFTWk4UWtVc0Nja3l0akREK3padHBU?=
 =?utf-8?B?dUJ4UzNSWFpuUE1nVjlTSTFMUU5taWVaMFVMVTc1RENwOEpoZlFRZE1zQnhH?=
 =?utf-8?B?b0liMkVyTUVFcm9NYUNqc3RxYS9IRnNoM3Bld0VYbGpobFVYMlZVazlpMWd5?=
 =?utf-8?B?UlBrMmF5YzF2b21PT1V2bUllYUJJSjQ3ZHM4ODBVRzRoR001MEFpb2t3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnlQenExWUFBbGJUcjFmRSsrekxjVVZOUTc0YWR6RXNJT29obUZpeUpMM2FE?=
 =?utf-8?B?S3d2Q3cwSVA4OFdwY3dIL0k1NFdpRlplR1c4YkZSZXVOMFJVOVlLa1VXWXNE?=
 =?utf-8?B?dHRYenlpTDg0VUNZL0JQZFU5anlSS2tWdGVvTytJVkttK2FLQ0tXNlBKNjVR?=
 =?utf-8?B?VUhaN2RudWFjdkdvclF3VkdIL0h6OEdwdVlOUVdZdU5vYkhmNEd4cDczc3Bl?=
 =?utf-8?B?ZkJGbXFETDNrZzEyeXI4c25RdVdMQWFYd2dYT0JHaWtITWpLTGNST1IwRHZj?=
 =?utf-8?B?WXAvYVhsQytXOERoQi9uQVJ3QmpuYitqbHcwY09XTVpvbkx4cDUwSStDeFA0?=
 =?utf-8?B?Qnh4MTJmaGg5T3UxL29kbkJ6YUh2MTRVVnFqVHh0TmVBU2J6WUxzWk5ENzNL?=
 =?utf-8?B?RXB2UElmYkxZZ2dYbVlXU0V0QXJVdnNCbThmSEo3VEhrMTlBTkxVQjBLQlI4?=
 =?utf-8?B?SytMRXh2WWtqQ2psdm01dFV3bEUxWi9qc0RLeWN4NnhIbWY4bFN4ZUVycWRu?=
 =?utf-8?B?RGpkZytZMWtmSmN0NkpFRXF0SzdEVG1Mc1ZzWGY1MDd3eHorYmxtcE1XY1NO?=
 =?utf-8?B?dEFWTWtyUjJsYXMxUHFuclltcExvTCthZ3FIMTkrdUQ5K0ZYRUhqQytPNVRP?=
 =?utf-8?B?SW9USnVQaE45NWJ1bFVqdUxudzNkR240K3RmZUE5OGtJb2ZvRnBMRnZQNnRi?=
 =?utf-8?B?a1ZuYXRsNGd1ZkRnMUVzWEZxbmFCWnlTQmZDN01DYXZ0Mk1sWVBqQ2Z5clVq?=
 =?utf-8?B?ZEZHTnVyNzNBQ0dIMEJLTDhUSHFvSmdxVGhHQ2g4ZDZ4Z2lwcnFNN25IbCtS?=
 =?utf-8?B?bTB4dkhUQng1bW1VUWd5K0FUNXNjWlV3alZsTmU1aktqVVFSUzUvanhiZHFi?=
 =?utf-8?B?RUZnelFQRVlLdkhxR3hDZDZKTWdFekpkTG1YT1NwSmFXUk8vMXJPUWRxUnlK?=
 =?utf-8?B?RWliUGhZZ2NMS2txVDNxU05NZHZXZDljdmFEWDg4V2JydWt6V0d1ZlRQbTBV?=
 =?utf-8?B?TkJTMDM4QnBrVXZLbjBVd1JHNnpOK1ZrNzFvYnFYKzJNWUFhaG1oTUYrdGwr?=
 =?utf-8?B?dk5YQ0I5Y1VNdUxvWC8rMHpML2NqQ0NpZ0xJVWYyMlVNc3ZjUmRYN1BkME1K?=
 =?utf-8?B?VGRmdGU4UkkzYjlSdGEvZ0Yzdnl0R0syS1pkT09rR0FrVFo1S2w3NCthWUIy?=
 =?utf-8?B?OWdEYXpmMzEyUUx2TlZnQVNtRnhQWFRhK2Fpc0JyNlVXUmtheUhzVjc5Um1C?=
 =?utf-8?B?cU1tQitWQTlyaGFLcGMrczlSMnlpREV1cjVlYWhKYUJUMHpmcXBtRFNvd3FE?=
 =?utf-8?B?NzVFSU1VQmhlbTU3YzBBRHBhNkhFVUVmWFRnMHRWYkFpMit0bDNadWVmR0t0?=
 =?utf-8?B?amtBUUFFU2NpMjRiS254K0pVMG1oTmpxaHVPaEZVN2NxTVkreVJwY3ZLS1hv?=
 =?utf-8?B?RjBMWmhxOGo4QkZweFhidy9oc1R6M2FXVTFCRjdDRzhQSU85elRDRWRKTUVF?=
 =?utf-8?B?blp3RnRRbWNoYXlNMmZMZ1F5ZlhwUGNvSmJIWFlPVmxpRDFwVEptVXFpa25D?=
 =?utf-8?B?cEFUc0NsTzlkazdyQm91LzZQUGQ0dUpOSGdlRDJyQjZVRFdaZW90OHFQcmZq?=
 =?utf-8?B?U1pDY051TWdmSCtiZDVsZWhCT05ZeERxVUVBL2dBUHZTMGhVOTlJL2YwZGdP?=
 =?utf-8?B?MmYwRHh6a1hHOGY4OVZEWTNFUnArREdQbG1kY2RNQlBnTWpnUXZEQnJQY3Fw?=
 =?utf-8?B?Y1FEeUhqL1ZhL0t3Skxpa3Z6QkVGOFgyYlN5TlJuc3VnSDROTjNTb3puTVdr?=
 =?utf-8?B?a2twK0VCaEpyVzZGb3dMWlhxMkxiZFNxcTdKWUYyVVI1R2RzM2lPcmp4T1Ar?=
 =?utf-8?B?enVIU2RnbHRZSzRsUEs5aGx3SHRPYW0vd0VBWm9YNUcwaXZFYXZYVWRqK2hP?=
 =?utf-8?B?VVRGZUlxVi91YWhQWm81Q2lGY2ZJMzlKN0pyY3F6U05INTVJZVdQbXVRUmd4?=
 =?utf-8?B?a1RkL0YzSFR5VFlWNVNLaEkrSDNZVjMyc0V5ZnVpWnN5dXdrME5yZ1ZqZTRq?=
 =?utf-8?B?c3VsZ0RRL3BNVnNoU0UyNmQzNjR5ckhnQmpCRGp6OFlnV1E1NjdjWkVrUkxw?=
 =?utf-8?B?MDlrUlVhK1N0M0F5WldGRnlNSXUyZjJtMVdocGhQU1o2M2hvOUNjMkxmT2FD?=
 =?utf-8?Q?rCu1H+GMpgcbsMr8RW0aDEw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e7037d-3815-4459-fde4-08dce31cdc51
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 20:00:27.5738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gE5LKszIydTloaQBMejlEL9d9cwJvfEBjLBj6dFKfWyqbmC5grBUsCK6LY6iewFkB2y4hFJydUK+inj01haokq09nfrUiIO3jCnvVMrQzWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7893



On 10/2/24 12:40 PM, Jason Gunthorpe wrote:
> On Wed, Oct 02, 2024 at 12:22:48PM -0700, Nicolin Chen wrote:
>> On Wed, Oct 02, 2024 at 12:04:32PM -0700, Yang Shi wrote:
>>>> On Wed, Oct 02, 2024 at 10:55:14AM -0700, Yang Shi wrote:
>>>>> +static inline unsigned int arm_smmu_strtab_max_sid(struct arm_smmu_device *smmu)
>>>>> +{
>>>>> +       return (1ULL << smmu->sid_bits);
>>>>> +}
>>>>> +
>>>> Hmm, why ULL gets truncated to unsigned int here?
>>> No particular reason, but it should be better to not truncate here. Will
>>> fix it.
>> Yea, and looks like we are going to do with:
>> static inline u64 arm_smmu_strtab_num_sids(struct arm_smmu_device *smmu);
>>
>> Then let's be careful at those return-value holders too:
>> -----------------------------------------------------------
>> static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
>> {
>> 	u32 size;
>> 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
>>
>> 	size = (1 << smmu->sid_bits) * sizeof(struct arm_smmu_ste);
>>          ^^^^
>>          overflow?
>> [...]
>> 	cfg->linear.num_ents = 1 << smmu->sid_bits;
>>                      ^^^^^^^^
>>                      This is u32
>> -----------------------------------------------------------

Instead of relying in separate emails, I'd prefer reply in one single place.

This is linear stream table code, IIUC nobody actually implements such 
large sid size with linear table per the earlier discussions.

> It would make some sense to have something like:
>
>   u64 size = arm_smmu_strtab_max_sid()
>
>   /* Would require too much memory */
>   if (size > SZ_512M)
>      return -EINVAL;

This extra check is definitely fine to me and makes sense. SZ_512M is 1 
<< 29, so it means no hardware actually has 29 bit sid size with linear 
stream table. It makes sense to me. But I'm not smmu expert, so just 
would like to double check such configuration is not existing.

>
> Just to reject bad configuration rather than truncate the allocation
> and overflow STE array memory or something. Having drivers be robust
> to this kind of stuff is a confidential compute topic :\
>
> Jason



Return-Path: <linux-kernel+bounces-400144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C019C0985
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153E3284C0B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A3B1E04AF;
	Thu,  7 Nov 2024 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qi0dQ+/Q"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B8917C79
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991689; cv=fail; b=WPwzYOByF9MiXpBlB1rmfHPaXmZZnLLrQcEqB+LDEBfw7gkHFwVm8mRpXnHuasCm8ltS+JyRUSqD/7qLIu2hcAbcU1aWYdfdCOjyDeQv3eRBqe2OyMwqn8yluHdKjh8JQcLyTZ8xQ692brf7HlQJS7kpwbfIU7DV+jDHKH9J9DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991689; c=relaxed/simple;
	bh=pK7OQEPdQrYteHfDVBdLBKOAOk0s7WrWG38HbSp3DlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b1ZW7NJ+UU49TnkIH3ju1/NPGFxx0cr9SbsW2nPHm5/ga6hq9xKDfdRbXG2CYwjcRgm83O/wzSqbuQOutxk96Bn8KKBfUjzuh3wHsRPHbjTrSNGijhnnkTfYjS89qSnFcGqrwY9+rn3nC2HH/3rTDudkfX5o+vvvrY8aIBOWI2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qi0dQ+/Q; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKZCDCixFCxC9aqEDnK+XdrPYGERR61dQ7533oOeWkPNoLRIgo25r6vHl9CQ2JJYjnV4HMw4jlBZz8k2nJDiLB3quTnMsumLK1xsMjx0Zp6wKvcfmZCFGHwSfYPUqmOYTXJHWstTRlEKjw3JLwyE7tY9pu0J99hlEz3PBTIrTj5euk9+FH7SN5Fbka0tUfMYrCxisT22089Tgm4JLjFVUBPxofnTHotlmY5MEjzfb8XJzKHrO5lxfuK8j1+mEGDIu6VnkI2+hrI+XvBhpLKKojQqaaUo50vmxGLicxPa2o/thQNseaKwvhX6zT2lJBc9hR+iB5ZzoU+oD675/DkUVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pESU1KtUBrjBkQhO539T0j7c0FTuq+g2WpkM49IHpn8=;
 b=l828OBoV8howQlCNRDvbgiG9aciamF8XNNyE7VlM2dJHSz+11yk0Bqs++gHNka1jzn7/VIH0IOJZ4CCj7NN1GiXWhxdqFIwmLxwQSSW3rxdasj9o+iJGfKhOyKG8yVjHM3XOrC8Ix+kb5sBiRY36y9mu8FDdrwcNplscfpWYtWoGqcLsu3UM/a0u1HaHKXxBq7sgorO2XdLoQSJv7wQun/Ym9k9fiynT/nWJh75nId+O8G+fgVBzmO2fr06Uz8Xg5QN3Im0/Phdnty2zziPWDaF/6x6on+CVjBu9qV2ajbnJHDYhwRWF1PHsEZ/pio4KN6nPEJ3vPVN4kF2ewcuXaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pESU1KtUBrjBkQhO539T0j7c0FTuq+g2WpkM49IHpn8=;
 b=qi0dQ+/QdsGdSnHkliTshIzOMCuLom41m7FIaIv7lTs8fKymGI/h4YCY4ndrB8LSVTQY3PMkIvZ6LtLzvVj9Sro2+vShQENHjDbfTTrFqcdZJey2417D7qmYdGGP+AUWMt/0X6QfETTFVm3tZ9sp5/Kv2fEHD3X2/Dl6O40UWkFXUSOrQ79WrDluRwOOg57AXVvJ2enrAe6ToDDTKmZDa/93gaJcJRQlXUmE5kvk9tE8rgE1wJpsdWDJ6VRK3AOt4RF+VDAAlXheOkuqnhWJUhIjUD3HLK6TNYDlKOOk/IdRcGAGL7B/P8q5OBoC7/6FMXUaUZVZP+yJ+Zjx/ReKaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 15:01:14 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 15:01:14 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org, Ryan Roberts <ryan.roberts@arm.com>,
 Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] mm/huge_memory: add two new (yet used) functions
 for folio_split()
Date: Thu, 07 Nov 2024 10:01:11 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <7C0C7025-DBCF-4544-8E95-1E781CA94710@nvidia.com>
In-Reply-To: <C9096636-C91B-42C0-A236-F3B7D9876489@nvidia.com>
References: <20241101150357.1752726-1-ziy@nvidia.com>
 <20241101150357.1752726-2-ziy@nvidia.com>
 <e6ppwz5t4p4kvir6eqzoto4y5fmdjdxdyvxvtw43ncly4l4ogr@7ruqsay6i2h2>
 <C9096636-C91B-42C0-A236-F3B7D9876489@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0045.namprd19.prod.outlook.com
 (2603:10b6:208:19b::22) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e9bc07b-661e-4607-2277-08dcff3d060e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oiD4+/7xDHzxd2H38VvGfKaZTOjhEJD6LmRjUmUNCioeqzAeujWA3OEkyeyH?=
 =?us-ascii?Q?bkyHzE2jRWymtYsfJjmbEJ0yYaIKnRYzTmm+ZKZWsx6pg2ZKT9MeHNQLEyGl?=
 =?us-ascii?Q?yR8Tc+52q4Q4C3PoGfvSV35EGys6pMOPuyOjc/TTrnbOHnv7WWsk1hsPBbC5?=
 =?us-ascii?Q?C/T0TM0vhZB4BFI/NQlcT6POumTELtTLyY2ClWzZEMeItdKRBMyHO3h1JLaC?=
 =?us-ascii?Q?H+1zWY72Rk/+nUbcqFuJaaeDhqYgy90dTAnx/du72rUFCEGY3alBPvzOYbWa?=
 =?us-ascii?Q?JrWWpGVnWaKXfhIpfqBl+9JPuGMy35eEoIW/vZujL5Bnd6u/QPIBf+ULTlbQ?=
 =?us-ascii?Q?/M9HBq5BDJ+u2Oo47Vzt+rpavPGzKg6wcFmTGu7OUF7C79lkV4lqf9PvTOHA?=
 =?us-ascii?Q?61PBbPWs8/PK8qahCleNi7WBV9vKkGo3i6iL4bodqPFVaVuW439cy6hAtUPV?=
 =?us-ascii?Q?317Ss5dScmtOLYGeNOjnvsItPxUn7BRtPgH93FS06urP+WjHL/pvGSqvNS2/?=
 =?us-ascii?Q?/iaEjqhyPOIK4NwLr9onvN547M5AiLZaEleXpKDaiLNz1Hoqy7Eraz3nxLIf?=
 =?us-ascii?Q?l5DINh/ECJA+jQLvlj2bKTkY/7t373/78VgD0K1HmsEfT1pnbdDEgRcaB3/B?=
 =?us-ascii?Q?BT6TcwuVkjh72YZGkxn6WhbJqa9RQvYhqCnLzSBUk24MdxBLM8jxgnu30UyT?=
 =?us-ascii?Q?5rseCefZ5KPdHtaNgQR0hMEpYsnLs/E+SPbkzeR3wehxHP11ngtnfDaza265?=
 =?us-ascii?Q?yYweuCcMlpQ5wgocLa950M/0Qqzi4j0majQqjWBdvN6X1rtUF3FsMnL5Hs+J?=
 =?us-ascii?Q?8T06dx7bsk06Y4waekkFBz+a0hH3CM+TCtPTOCmHNtzPcJ3p7IexCHlVICa8?=
 =?us-ascii?Q?Pdf+vhmNKWe+rPGUhHv++9H9UZ3DL3kCDC2QIae/eqdEYDn8q0I43i9YH4wl?=
 =?us-ascii?Q?5b5HhDXRbM6dhFCWnDBxdVeJOHn56jMjsgdnf279M8NScvg9FAVxWxqc8BzK?=
 =?us-ascii?Q?hHgqkuRuEXTaZHtcBfxxFVejoD6Gd/dW6OVJ+nZNeV8BxfrWejKF9iRbp1Ay?=
 =?us-ascii?Q?2uZLCLNV0PkcrapAiuwRgT9yMSxHscx7pOz1SaHf/Gfy47b0+Xny64IoStct?=
 =?us-ascii?Q?rui0AR8nDwS14bh23DlcF6tVoXMaHCZzibZ7CLAr0oteTiYFCC8x/PakqRXt?=
 =?us-ascii?Q?630bducw4xOOGBvTUu+k0hjWIF6ZAQzcD6vgO1B/npuSeuUZvDtpnZUNL+n2?=
 =?us-ascii?Q?FEBKVe38x1TEF/BExZY8vGBzDol+WZUJ4VCF1rNSyJzo7XVVt5vmH71iJmCB?=
 =?us-ascii?Q?4vtnk+B7CnpNXZ5HAOdhl4jy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ucwVJUsofIkgz0Xo0QxTL9HKcfda6eNqwC0PvnXSlXPjCgrtS242MXYMHm6O?=
 =?us-ascii?Q?Xl5hKWBTApR4tH4qgtdISfJ26hS9IdNuWShW05Fd3Jezx+tzsxDyi8z7QSTR?=
 =?us-ascii?Q?o3CfZiuPYxcicjBmOGYye4rseLZsr7IY8/jbsFJZaHHV4KXlnJUcpWemA0vj?=
 =?us-ascii?Q?dRn1gs7cq5MBbxgDcCKPabVfGy6v01F0Q1ySgdO2GWUBGEwBr3GBfHQMMKU4?=
 =?us-ascii?Q?iADEwE/K6ERPkj+lhMmgKC/Ved9WjxbBONZ5vT6AaHXkJOJaYuGYX33z+NL1?=
 =?us-ascii?Q?MCqagOaxf+EO62tDCIjE7EUWEdIgyUFgNTrVRQCwd7k/9ZKsB5xak0jVliod?=
 =?us-ascii?Q?JHgxwpVRHDfqXMREcqwYbI4osqupZyCosi8QixZvWmHAJcawxe2k1N0P97Rf?=
 =?us-ascii?Q?DfHMZ7XWmj/AZtCHU6SPEy8a/4dFGJvov70Bb7PEpEIp9YpN/WicmTwmpOW2?=
 =?us-ascii?Q?e1oIwMBPkqKuI5EEyfgN/rIwPDlSOrmojf2kuUMo5mIUwRq4x0cDUda9N8cC?=
 =?us-ascii?Q?/sh7167mScJ/YNJX5zTp1oc7Ugpe+/7jWhtnc/brywKC+kP8sDjmWK8LjS5Z?=
 =?us-ascii?Q?PnLJRbKPAmWS1amHNnwgP3dYY4wMVqyXK8VI+Lqnn1qg2s465xzWxadVnZa4?=
 =?us-ascii?Q?xQuxe0eWlXmu5qOZpzH6U0S3L6eFrYCIVNe5exkqgu77BLfHDSeN16ZFgUJD?=
 =?us-ascii?Q?nqaP8XJIRzkfuwcCCAhZ9F9UP+mrJaD3PTqkPotSpptEnW/cNho5V6HoTHBM?=
 =?us-ascii?Q?dKjYOYHNHY4uYqVn1tsZ98gNFzsNFiflz2fO82EtZRnP45f8ibvEY+fB06Dz?=
 =?us-ascii?Q?dlQEypvDkjLqTAXY3nvMVQL7Lno5TrR66De6WAdRAJU/clUUpcmyauUlHhF2?=
 =?us-ascii?Q?8nGYBaQAUFBNPYxEUVlpi7LrHVzuKy91yYrWduzYGk9FHk0T1PrEh+H1A6e1?=
 =?us-ascii?Q?dU0boXUKrzto7as4EFm65fpNq/VNNVscoLSEruO8kf7dmGPc3wBl71mldjP5?=
 =?us-ascii?Q?0iUx6Zy+zfbh1IQ8rJO40s7F1k7TbJoVHVeZdpbNJae1oi//wdip0g+FZczJ?=
 =?us-ascii?Q?JpckLunquvc/B7eVvZHuVYMFyrSEQQ6AECB3HQ67T8KqwX48euqwaOFFZkpO?=
 =?us-ascii?Q?fXX1RR6A7Ab9CNqmFVwdwu0d7jJLIcvQqLMu9pAbK39REltfvhdlaBos6Woj?=
 =?us-ascii?Q?W3mcCJemxORA44LoauWdY8nTSaVivmAavNEYLdTxYfc01MlAJGoROxITkmLP?=
 =?us-ascii?Q?mIkamsQimtNzNHo0kHEO2XSlAQ3c8pQMF3775N5mHABT7XzRR9mGQE7KHfIG?=
 =?us-ascii?Q?WJEEAyGucMEQ25uWJM/1xhEK5BxVG9ZTA9POjRsqKd+npO6Gpl2cB22rZkHI?=
 =?us-ascii?Q?ht0P5KpCS5+WmpLUH8PvIH4Ml42a/Eqv+RX4vYY+hAaOLR3aG0R8ZTlilVk+?=
 =?us-ascii?Q?y9xyouU/r8Pqpx3gVOQFrlsEFiaAF0Ell3se2CgEAn/CE56+bTmp+2LzN6pm?=
 =?us-ascii?Q?JfiDdbw04yORtfK5VuJeyiafdQBi3EGe/M7cLWuFBO3VcovNL/drDJvAiSTd?=
 =?us-ascii?Q?0HIYCB7dVCAwIgONvGAkb6Qo6YoX6X6v7zRKT/6F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9bc07b-661e-4607-2277-08dcff3d060e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 15:01:14.0495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHGDCltsUoaGrLdABG/AWCt6Nveq/XCTp7yy3QoiFc19dEL93B3S3orREca7TSxs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019

>>
>>> +
>>> +		if (mapping) {
>>> +			/*
>>> +			 * uniform split has xas_split_alloc() called before
>>> +			 * irq is disabled, since xas_nomem() might not be
>>> +			 * able to allocate enough memory.
>>> +			 */
>>> +			if (uniform_split)
>>> +				xas_split(xas, folio, old_order);
>>> +			else {
>>> +				xas_set_order(xas, folio->index, split_order);
>>> +				xas_set_err(xas, -ENOMEM);
>>> +				if (xas_nomem(xas, 0))
>>
>> 0 gfp?
>
> This is inside lru_lock and allocation cannot sleep, so I am not sure
> current_gfp_context(mapping_gfp_mask(mapping) &	GFP_RECLAIM_MASK); can
> be used.
>
> I need Matthew to help me out about this.

Talked to Matthew about this, will use GFP_NOWAIT here, since we can fail
here and probably should not get into atomic reserves.

Best Regards,
Yan, Zi


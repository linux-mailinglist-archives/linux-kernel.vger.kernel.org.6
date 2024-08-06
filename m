Return-Path: <linux-kernel+bounces-275840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C13D948ADF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1225928843F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791D9166F35;
	Tue,  6 Aug 2024 08:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JWx1cg4b"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB52F28F5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931596; cv=fail; b=JzilOWyySoz8XAx7l7bQEUsCftpmy9yBcfI8GyCLrRNER4/lwEO+wkYDq8xV1NqyqoeupJz8S8eK97hUQRYANIfe1av7qkQhjC/8E+1497L6ADFUBO6g5CBINP8lXT4XUvym+kOEs67LJFDjarEe2TeKKbaN5Wn1YupOe9AvukE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931596; c=relaxed/simple;
	bh=DJqLrJDa4wawsbZn2XFsebp//OOlvnJ0x2v80AtQUZc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uF+mTKSO7Kj0vSeHTEYA5e2lY8yy8i7qxAGtSsph1/5Wla5rJ9bDnXYmyVZ66pQWmOQskOeB2ROGEJdPYeFJ0dJbrjDTT8NE40S5laTOl0UetOHlVF1UF6wXQx9wCSzqwbRMfDQxsnI7sTQzJ/rYv5fqrWPz/BEN+JIDB5BlFds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JWx1cg4b; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8YhX2TWPSYNb2L8AlAeGsRQs7soIoRGguaed5iH3aukOhKgPrDW4BwunWsrlZMXUz6O++eIFoMKICdnv9IqxV2AGtESCxNkyQ02+NkTEWrKCq2ibCuMkCpX980f6LSd+sjfT1R4YatZGFo6fTSr7hiILfvG+Mwb/DLBhVvBX3y9BZ0drvEuNUwMURpSMl2TCLhneATPosImbiCBCIm7YkVefQbx1TbJTSDggT+g3XuKavnHjZg2eS5UI9qjlo6SxAhYnBady/0VnNyceGX+43mId94XcFCQDSeLTkEDWfCzFrHOqUgUBPygf/CVVoTsYwuNRvXoV0gnSjmLTFGj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lozNba6u1javkJl4qzI55kiRjiMazsjpJB8slJQ9y1k=;
 b=UrNEObqHFlqQXkUkIYV1zv0605KKee35kD8oQzmFxoKVsnM5wLuMElE69j8iqUzJY05PVIrH0cvAoFc3r5BdTJJNsQDSL3KagzpL2EbDSEJTjGO7cIVQ1Gnl0f8dVJxmGQEqgPzDC2IoUsXCUwbdA/r+1InqjW1P3H+RoE0/w0JdhJe/wIiB90aRDUR17icZzgvCKGU/yO0NM+WqGCL7GZW9YmpqnDB+QhCrAPpdm9IHthFwCAdwPJhM5jUrmy/Z0lhkABrBqYewXr1Z7TZAX4UmSlIApdHPZ8S/1HUM6N9ZHrE73BuIuJOCrP1Vfx3Tqr7rL0gONSLs0QFZvq7eWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lozNba6u1javkJl4qzI55kiRjiMazsjpJB8slJQ9y1k=;
 b=JWx1cg4bC1XRKfq7F8LqcZfGBcqdoYNUUtq1f0N1hSa7jefwRFwwDs3ES0+sYVV9lFihG2JdTQtgl1/XOX1gjIjaK6GzqXhSAddTrI9BC8Cb6bIdMza8pSI/IlnYTe29KzD6xXz+njZsqdir66RA2MUFEpChxojy7YLEgSIgvsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Tue, 6 Aug
 2024 08:06:31 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%4]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 08:06:31 +0000
Message-ID: <55b113d8-d782-4d6d-b5a9-e916a1a9b3b5@amd.com>
Date: Tue, 6 Aug 2024 13:36:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] i3c: mipi-i3c-hci: Add a quirk to set PIO mode
Content-Language: en-US
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240806075843.277969-1-Shyam-sundar.S-k@amd.com>
 <20240806075843.277969-3-Shyam-sundar.S-k@amd.com>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20240806075843.277969-3-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::11) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|MW4PR12MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f7d1a2a-27c8-4ad4-29ea-08dcb5eeae16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXFWa0xzNDlUV0lyaDIxcWlVVGdWbEtDMFh0UjV6ZFNpdnB2dkM1VUNTYjYv?=
 =?utf-8?B?b3pFUmVtTmFEZUhEQjhJWW5ibll5NmhHcCthQVRzSVpjYWQzTm1uSmhPYnUx?=
 =?utf-8?B?d2lEdCtvVURCSmk1cEdsWGMxN2lHQkpzMmF2c0xQT1pZTXRzeGF6d0liTXJv?=
 =?utf-8?B?K1EyZFpsRHpLVG9OWkptSGc1N3VqNmtFU0RCekxhT0l4WG9kcTJFZDBUY3Bo?=
 =?utf-8?B?QldtQm50VjVQSlMxTEgxbWZWYmxuRk5janRzWW9sWFVTNVlTMjNBcnd6TkN4?=
 =?utf-8?B?N1YrMml1RWgzVVd6c2lRYTZoYmNoZnZISEpxQ05od1dBRVRsTGR2czhpTldV?=
 =?utf-8?B?aEI4dTUwMnpmOE5rUHJVdU9ENUtCdFdyMXRsV3ozelpqeGFuQjNOL0hWTVQr?=
 =?utf-8?B?Nm8vNExmVHBCZmVPTUVxMmtPdlA5Mng5dGlsaFVNaldDdlRNOVdyZmlKL05h?=
 =?utf-8?B?R0k2bmtPZEVPbmk0OHFtR0hGR1pIUFJGSWppdG8wK0tpa2dQMFNnSks4UWsw?=
 =?utf-8?B?Qm1LMCtlZG52VHhQQ09OWUM5NFgxclJMb3hGVTNhS3pnYVM5QUZ2ektaOTRP?=
 =?utf-8?B?cGxQanJzZDFhcFpXUEd4WXgvR3NUbXpTVVR2aUpqSU1DSVp4eVhNWENtcXVx?=
 =?utf-8?B?a1B6SEhrUWZkaVl1cHl1NUlwWFc4Sk03ekdhRUFhSCtBMHArYTNXblJZcCts?=
 =?utf-8?B?WXlUV2ZPejhMb3ZmTFhsREsxNHQrVzd6enQwd0h1NXBaT3dXQmRuUzBld29K?=
 =?utf-8?B?dEplNUZpQzFOWHBQVHNQQ2FuR0tyOFpHbStJR0tQMFYzcW53a05LeDltRHhk?=
 =?utf-8?B?N0tYUzc1Q0ZwWi9VSCtQMW5aSklIc1grVjlrK2ZoNUhnQ2liai9CK2FLWmVD?=
 =?utf-8?B?cURMbzdEYVJsV1ZOeGpiZ0lLeURIaCtUZktPQzRlYStqNUJ5VTAzdXVlNjh4?=
 =?utf-8?B?Y3lMSCtxWEplVW5xMFVuTHRkMXpMVEg4WkNhc05sQUhNbk5jQ1VlNmV1aFhX?=
 =?utf-8?B?cFQ2UlpMZDcvbkRqYkIxcWYzSUVOOVdZdmVBemJjTzNOUm9vcnhlenVJZFl1?=
 =?utf-8?B?a09URjMvbklxZ24rSTBINlR6MlFiQW82TnZXbVlXNFpFVjNDc1B6T1FHcXZW?=
 =?utf-8?B?cFgyTWVZa2dyYjFBakFWWk0xLzJ5SUhyVlFYMjdJb2E1RENNQkpLakNxMXFi?=
 =?utf-8?B?c2VQcmk3b3ErVVB1dm56TEtrVE5DZDhvaTVXR0h3d2p0SG9GMEdGb0I5ZjRJ?=
 =?utf-8?B?ZndIeE5EWDdMenF6ZlRBVHZKNUVPSUJGWmQ2eFlXNzBKUzdVczkyVmpHaFBM?=
 =?utf-8?B?dVRPZ0xJZUdlcFdYdVZXQWV2d2tJMlNFK2RzR01QNk9OVVhHeGE2TS9DQ2FL?=
 =?utf-8?B?emZHekpjTDVxS2IydVBnYzh5NE9kUjJacXRGVVR1MWpGNXdncUQvdVNlZUR4?=
 =?utf-8?B?M2V0bGdkQTM1YmNtcUtGa1pobVBSNi8vd2duT1o4a2FjMyt0Z0FET2txTzNt?=
 =?utf-8?B?WTA5dlFhUXd0Y1FCcWJTaFZVcjN3R3BXZGVQcGQ1eCtEaTk3Y1FsQVJsVHFI?=
 =?utf-8?B?aVdoTkRqNVRUaTlHemFDSHFvUHh1SmFjOHFiOVFuNXRnNURDTTZjcmg1eGJ5?=
 =?utf-8?B?MnlyQmtDZVovVHMwVC9FamkvL2lsQzNjOVlGeHVQYndtdCtNa2NFTzJ4dGpZ?=
 =?utf-8?B?S05wRkxRNkxMYzJHbWYwQU4yVHRlNG04dEs3SFU0TGxtK3VzcVFLNjdYNGNQ?=
 =?utf-8?B?V1hQU21NV0VHbzNrdk1jMDdmbkxNRXBUak5vRkZseXZabThYR2JtT3AyTUVo?=
 =?utf-8?B?b1Nmejd4Z09Kb2pzek0xQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1dQNWx3WHJUcGoyZGRvQkd5aFVxRDE1NUhCTGluanNaSDE1OGhXMW54eWlX?=
 =?utf-8?B?NitqQlgyKzdPT0d1dHN6OUJPT1ViTGlFZjdDVTNpcGh5aWFkQjk1ZXJuZzVN?=
 =?utf-8?B?TDF0Y2wxODF4cEtkOG9TeU80RHlMRXJBdU9CMFp0V3dXMjFYSW01VnZQMFpS?=
 =?utf-8?B?Q2tURjJoWlpSWkdNbGcyNW9sRW1YNTJvM1c5c1lTWjRnQWtKR1dTRFVaQVdI?=
 =?utf-8?B?RndxbllIQWphTkxtdmZabVRqNWVId1drWnNZTUtrTVRCMVBjNG5XMi9DNUlo?=
 =?utf-8?B?K2xrYlZkWnZCZ0QxUXA1dll4OTVDQUpWbTYvWHhRK2ZQT1JiSmlnTVFFQzlM?=
 =?utf-8?B?bzVQeTF0bWgrUk9GQVQ5QXAvLzdpakwvMnk0OUd2VExocGtaOFVFb2dEU1Bt?=
 =?utf-8?B?M1BxS1UwblRnU1ZsZG9UZ2lqbmZFd2VxR21TQ1hSd29rZ3RrZ1JUbFlRak5N?=
 =?utf-8?B?blFJTFV0RUlXOFhad2tGL1h6M09OUWRFMkoyOW5oZnRxcEI1Qk9yU0ZKT2VJ?=
 =?utf-8?B?VGlpZU1lR3lBdjd2L1NHLzNKcUk3R2Iva2laK3FiQ29aTTh6ZmdMQUtMVlZR?=
 =?utf-8?B?ZXA4dWE0VERqR1BjWWpwMmRkMm80TGhXMkEwaXMvUzRnZXBQdVl0M2ZQc2xq?=
 =?utf-8?B?dUp5Sjh6T2JJSFpjMUJkNHFEMTNlTHVqaXVwNU5HMVV0UlNQRUFSeEtDc2to?=
 =?utf-8?B?SVkyeWswcmpJLzlqS016K2puY2Q1RW9TOEh3N0M5NzJrdHcxaWRkQkZmczB4?=
 =?utf-8?B?QkZpV3ZaNExXb2tIcDhFdUt6ZXVtVEtRb01KSk1sNm1ObHp1TDVkWnFqZnNE?=
 =?utf-8?B?SXVWUTBFYnZXaWJaT1c5R2VrWk04bDJNY1A2VDc5a1Q4U3Vjd1lqc05VUVY4?=
 =?utf-8?B?dUI4ZzgzQXZwMXI1aUVIT0NkSFJ4WVRGaGZEV1hNd0hDM2JSbTB5NlFjazJQ?=
 =?utf-8?B?M2RqOThYR1dnN1ZVSFFwTFI0LzFTbjU1dTNPdXRuVjFYa2tLakczckdWeU8v?=
 =?utf-8?B?M3NYcEJwWHp4bHlHNUpZbHRKSTZqak5iUUFabjNoREcwQi81Ym1IWnVyTGRC?=
 =?utf-8?B?RDFyd2xYRzFqd3BoTkRmdWpCN0t2WXVKM3dySXJMaEp6OE9EUUFpaVZwMzVV?=
 =?utf-8?B?SjRVQ3kzSVloOTVYTnh6eXZMdEVObWZrcmpocFhybXZxVFZ6RGFtYk9pTjRh?=
 =?utf-8?B?QVpFMlMrUjlSMHArY3dBS1JFbURQQkZEZUJ1UjkyT2ZCRS9UQ3NJQjdxVjhq?=
 =?utf-8?B?MVJmdHdlMC9xbHphTkpiWlhDQm5BamZqclk2NHRvL1h4VjhxNklrbFhmQjBE?=
 =?utf-8?B?Z0VhWis4L3VrZHNVdDNpSEF2KzJqTHlKaWUyWUJTLzZJcHQ0MHRHT0p0UHVN?=
 =?utf-8?B?NVAwMmNFYW5Yb2h4UVZYVWZzYzRsbEFvdmJkVklnZS9vZjhCeXFyaThJTVpY?=
 =?utf-8?B?QzJCNTcvTmF1UXQyamw5MEw1MWdpV3g0WlZibldORHFEYkV1dDNwM0k0eENJ?=
 =?utf-8?B?ajJxNGtaSVVLL1JNeGVzNEc4ajVEOFR2TzNvZ2NIaXdYcS9NbkFqS3EvWWVj?=
 =?utf-8?B?WlllMlpLV2cvQkNhSUdpbEgva2cxQWVwRXRJcGI4dU5zT0liblArUjFkbkVz?=
 =?utf-8?B?dW5kWUI1Zm0zOHc4YnlrK1d3b3hkbVF1WVA3OUVzVGlFazQ5c0dUU29tWVU4?=
 =?utf-8?B?QzJrT0F1dEt4M3pYaDRxRE0wNWJaUmFCWjhRK2NxNFl6VGlFVGJqWWROTXRV?=
 =?utf-8?B?Q2pLVDZscUw4SU52VDljVGFaMkN5YzE2VmFCQjJuaXRXSkRnL2xPb2QwRm9l?=
 =?utf-8?B?bnhLdFQ0Zk1PUG03RVpsczlRclNxZXh3dnZrWUpFb3lWSGkrMzlFNVAzSnBU?=
 =?utf-8?B?REJlMGV1TDVlNkI2LzUzY2lkN0YyUHpuQ3o0UWErUjl6TWhrYkwyZzJrcUVB?=
 =?utf-8?B?Z3B5SDc4eTAzSG9LUmgvWjZpRHUxbXZBZG5YdTE0Q3VldUtsYU1nVmV6OXUw?=
 =?utf-8?B?Qm9XQ1hVU2RBZHNhR1hxYUxwekxEUnlXeEdWZ0hqQnpsY1B0dDhZS3RKZGtk?=
 =?utf-8?B?aHppWjlvWWNsWnJLNzhLYzVOZlllZEFuTzFoY0ZFSmhOaUNnY25kdzZ6K0hY?=
 =?utf-8?Q?NEeC9nmuldh/ZIjKkFTObO670?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7d1a2a-27c8-4ad4-29ea-08dcb5eeae16
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 08:06:31.0184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNA0qFO5pdElUHJPr/a0/wr/b8NQ2+Zs29d5vHtk9goJ7ycedkmFnBX/0jkKzzH1fo2amsC6RtUHc7/1aoj1Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601



On 8/6/2024 13:28, Shyam Sundar S K wrote:
> The AMD HCI controller currently only supports PIO mode but exposes DMA
> rings to the OS, which leads to the controller being configured in DMA
> mode. To address this, add a quirk to avoid configuring the controller in
> DMA mode and default to PIO mode.
> 
> Additionally, introduce a generic quirk infrastructure to the mipi-i3c-hci
> driver to facilitate seamless future quirk additions.
> 
> Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
> Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
> Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
> Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>  drivers/i3c/master/mipi-i3c-hci/Makefile     |  3 ++-
>  drivers/i3c/master/mipi-i3c-hci/core.c       | 15 ++++++++++++++-
>  drivers/i3c/master/mipi-i3c-hci/hci.h        |  3 +++
>  drivers/i3c/master/mipi-i3c-hci/hci_quirks.c | 20 ++++++++++++++++++++
>  4 files changed, 39 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/i3c/master/mipi-i3c-hci/hci_quirks.c
> 
> diff --git a/drivers/i3c/master/mipi-i3c-hci/Makefile b/drivers/i3c/master/mipi-i3c-hci/Makefile
> index a658e7b8262c..1f8cd5c48fde 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/Makefile
> +++ b/drivers/i3c/master/mipi-i3c-hci/Makefile
> @@ -3,4 +3,5 @@
>  obj-$(CONFIG_MIPI_I3C_HCI)		+= mipi-i3c-hci.o
>  mipi-i3c-hci-y				:= core.o ext_caps.o pio.o dma.o \
>  					   cmd_v1.o cmd_v2.o \
> -					   dat_v1.o dct_v1.o
> +					   dat_v1.o dct_v1.o \
> +					   hci_quirks.o
> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> index 5ef848833a81..7843a3ac2121 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> @@ -33,6 +33,7 @@
>  #define reg_clear(r, v)		reg_write(r, reg_read(r) & ~(v))
>  
>  #define HCI_VERSION			0x00	/* HCI Version (in BCD) */
> +#define HCI_VERSION_V1			0x100	/* MIPI HCI Version number V1.0 */
>  
>  #define HC_CONTROL			0x04
>  #define HC_CONTROL_BUS_ENABLE		BIT(31)
> @@ -753,6 +754,14 @@ static int i3c_hci_init(struct i3c_hci *hci)
>  		return -EINVAL;
>  	}
>  
> +	/* Initialize quirks for AMD platforms */
> +	amd_i3c_hci_quirks_init(hci);
> +
> +	regval = reg_read(HCI_VERSION);
> +
> +	if (hci->quirks & HCI_QUIRK_PIO_MODE)
> +		hci->RHS_regs = NULL;
> +
>  	/* Try activating DMA operations first */
>  	if (hci->RHS_regs) {
>  		reg_clear(HC_CONTROL, HC_CONTROL_PIO_MODE);
> @@ -768,7 +777,11 @@ static int i3c_hci_init(struct i3c_hci *hci)
>  	/* If no DMA, try PIO */
>  	if (!hci->io && hci->PIO_regs) {
>  		reg_set(HC_CONTROL, HC_CONTROL_PIO_MODE);
> -		if (!(reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE)) {
> +		/*
> +		 * HC_CONTROL_PIO_MODE bit not present in HC_CONTROL register w.r.t V1.0
> +		 * specification. So skip checking PIO_MODE bit status
> +		 */
> +		if (regval > HCI_VERSION_V1 && !(reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE)) {

Jarkko, Apologies. I missed to address your comment on splitting the
version check and quirk stuff separately. Will do a resend, kindly
ignore this version.

Thanks,
Shyam


>  			dev_err(&hci->master.dev, "DMA mode is stuck\n");
>  			ret = -EIO;
>  		} else {
> diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
> index f94d95e024be..91e8a3833f3d 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/hci.h
> +++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
> @@ -135,6 +135,7 @@ struct i3c_hci_dev_data {
>  
>  /* list of quirks */
>  #define HCI_QUIRK_RAW_CCC	BIT(1)	/* CCC framing must be explicit */
> +#define HCI_QUIRK_PIO_MODE	BIT(2)  /* Set PIO mode for AMD platforms */
>  
>  
>  /* global functions */
> @@ -142,4 +143,6 @@ void mipi_i3c_hci_resume(struct i3c_hci *hci);
>  void mipi_i3c_hci_pio_reset(struct i3c_hci *hci);
>  void mipi_i3c_hci_dct_index_reset(struct i3c_hci *hci);
>  
> +void amd_i3c_hci_quirks_init(struct i3c_hci *hci);
> +
>  #endif
> diff --git a/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c b/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c
> new file mode 100644
> index 000000000000..8a8fbd697175
> --- /dev/null
> +++ b/drivers/i3c/master/mipi-i3c-hci/hci_quirks.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * I3C HCI Quirks
> + *
> + * Copyright 2024 Advanced Micro Devices, Inc.
> + *
> + * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> + *			Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
> + */
> +
> +#include <linux/i3c/master.h>
> +#include "hci.h"
> +
> +void amd_i3c_hci_quirks_init(struct i3c_hci *hci)
> +{
> +#if defined(CONFIG_X86)
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> +		hci->quirks |= HCI_QUIRK_PIO_MODE;
> +#endif
> +}


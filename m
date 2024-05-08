Return-Path: <linux-kernel+bounces-173382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6628BFFB7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A8C1F225FF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752F585642;
	Wed,  8 May 2024 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sMdUzcp3"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0605253389
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715177264; cv=fail; b=bYyh2ay7QHVbOO9tI40rAA4VcpIhO7iR3yFBxLUQ2XJifwUnai9yZMIVNBncLbOfdFCR9aRwqPwjBCtun+OKKM5+oEL6rCTkraKHQTUpKGjYqa+PWr+g8MCTR0kN5zuMEg5eo2wYsttw/eHjd+Ys2Ee4MWfKa9GD4xLomzVOgPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715177264; c=relaxed/simple;
	bh=UeyBFUwbaHpvXuW91SDhSkHUJyD6V7dSL7CHmY7go8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QS1AOvnYIm0AXE/C1cxMpZpGkEr2QYBmZ0hRztY5dICAeUlrLUXGLqtPZKF2px8l/8imNUGFJ0jT2FS9sjJYf1/wiMc3rFJlqXFpRadDXrkF0nGIeqqy/AvduVsplxQH8RUXfenjJX3Zb5BRpU1Nbll8+DJcrX0r5XiOiNm6+ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sMdUzcp3; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXHi5asP60j+w+ilHgNTdi7kOlKvqUSFUCqA+x03+wkubsPM2BCRSPX3JRFq6YPzCdoPQlsSEqhBwxP8rMVkdE0VrLjbQJhAGwOuz0vvYgmYPZ8XCpnxatP3aHJlENt6ypG6WFjlS9EuBE14lqnF7fxi7JrExhRolDTNMAvQGkk7km5EA75eJgdCzeUhUJbP5zvZujdqDjV+KbcI0EY+kBkkQr0nPBAEylwy6TPRbHy4RlRQ8Yeg5Xz8EoGPy3xKXVbSrlBUIif8vIQflUJFCXKdVPY1ga5cGwOP+JbjnAeYek1LdJd+9bpsujKu1hF31155+dCECYYlCLwqy3bJfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UtQwiQ/329REzwDnr4OOqySS8j2bSwwaxnfeUkPqz4=;
 b=hON8PJo640mKG7UI8g9NcxrNWlLTxMGpugBStltE21HoS0X81vA9O7QN2VT83K/RRbFQMr+17FayszIYiXEwVNHcERTNeztQx143p8Eqt6XQYatoV+lM91r90AOCD0m/l4HymmOZQOO2bbjtobGVB3f9Gzpsj+yEFFthhIuhwrjDgexvcPR5iD0cS1kBZFm09gvG57GBhablt/UznLCc60Sm2KrPhQvDCPc2dzTDIaHlH2qFsfey3gFmxb2eGFS9KILz59JbRpBHxZ4d1tO/gMmTdI0MeT9sJh4y44e+8xT0sQxR3PAR2efmIsxHblHTPyzcG8DKwY9QasbVDMvX/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UtQwiQ/329REzwDnr4OOqySS8j2bSwwaxnfeUkPqz4=;
 b=sMdUzcp3c3+HBXBudx2MlGjHlEwgDD/CwzByjcuVr06M+ZveoChO5LSjFgSJh+eM0H3Kje6bLdIACORwrw09yaLoDMyQW9HPhx5JaBnSiVs5fUDtTbNMEVI8TUpclxAygB6ES+xP5PlIiGl/MQG4q2p8K43yTSsqNvqWJOXltFRghTvS4NJ4LaFHyYIcl0MJ6Z8HHGzFF18aG8LcLrBEdcGmOnflGLKzbbJvlJEuS10B9X63fr0g/WQ8/dX5u51nR8Ep3c1stnTjrehHFOV3K6qcXUlYeAPwHocv1UZEXAS2oR7zeDwmurjQBcdb83LCt5NzixZX17vi7ackqL825Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.41; Wed, 8 May 2024 14:07:34 +0000
Received: from BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::afc:1e4b:7af6:115c]) by BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::afc:1e4b:7af6:115c%3]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 14:07:34 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org,
 maskray@google.com, ryan.roberts@arm.com, david@redhat.com,
 21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com,
 zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com,
 libang.li@antgroup.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v4 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
Date: Wed, 08 May 2024 10:07:31 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <B1DA2DA4-AFEA-4541-8DFC-0D815249A064@nvidia.com>
In-Reply-To: <CAK1f24mRVam3w9CZkq4O0smGUTVUQfdvA48mqsU+NKxMUxdz1A@mail.gmail.com>
References: <20240501042700.83974-1-ioworker0@gmail.com>
 <20240501042700.83974-3-ioworker0@gmail.com>
 <0077A412-0AF1-4022-8F49-EE77AE601ECB@nvidia.com>
 <CAK1f24mRVam3w9CZkq4O0smGUTVUQfdvA48mqsU+NKxMUxdz1A@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_345C16E9-0929-4633-85E7-1B5ED88F814A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL6PEPF00013DFF.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:1e) To BL1PR12MB5730.namprd12.prod.outlook.com
 (2603:10b6:208:385::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5730:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0d9c7d-7e48-4ae6-f1b5-08dc6f683545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzFXTnZTbFVYMXRuMEkxQzMwWFNHaWtxTmFNbGM3R282MkY5Uit1ckZtTFJQ?=
 =?utf-8?B?MXFjWVYyYnNWY0ZRTHVFaWcybkw1MXJIUFpIcWtJUVo0QU9salQveXc4ZWZO?=
 =?utf-8?B?WXZGck1QNUNRZHd2dnB0K1FwLzFPc3g4bzF2NVhWS3V3c0JsWVpKMkJjSG1o?=
 =?utf-8?B?TVBqQjNDeTh6WHAvRDZRd3RybVgyUjJ5QVRucHE5aEdoZDk0S3NFYUdxZkE1?=
 =?utf-8?B?NFlZdU5NOUpTMmFoYi95VUUrVHdSZlRSTlFWTXlvWktMNktmcXVleVI3c0dT?=
 =?utf-8?B?TkRYK3ZtQkdlUVZTSlJoTUZ6SW1POERZWVMyQkRjYWhLQXo1eTFnUFNZaHNZ?=
 =?utf-8?B?NGwyMTVxczdKWDIvYnpUeUFJNWhLd3RiUDdMeHpIWGJDb091YnBwNmlNVEhM?=
 =?utf-8?B?VmNFSlZmNVBoemNReXJxdXJrWTdacHNRRkJZWGZXVmpqd3g0NGtKNXgxWDA5?=
 =?utf-8?B?eGtEL1Z5a25kY2FlQnlHKzhIQmkxcnYvVUZWTzloTW1lYkg1Z3BVWkxVVytX?=
 =?utf-8?B?MXhhVUYyZmpUZVBZZVA3MFhmeXllQXp5RUorSTNld29XRUxwZTFZTGJ5YVZB?=
 =?utf-8?B?dXQxTGYrL210RHI4bHA3NDZnRXBidXd6L3VoRmtPY2JyN21oa1ZvSUtBSEk2?=
 =?utf-8?B?SlkwZmF4LzUxVEs1bkplY3BTenAyRC91azdmd2cyOHRIb29Jdjc4VzJQMmtp?=
 =?utf-8?B?aVpoRGRDSUxyZnFUc1BSTUtwVWcrd3krODFEQXVPS0ZNaVpCc0lTNi8vc3pD?=
 =?utf-8?B?Y3pCOVlJM2Rmcm5RLzVxbmpuU1ZyNmt0NXo3bVpCTmF0MnpCYmdhNEh2TGVT?=
 =?utf-8?B?bXR5R1pJZnppM2pZdGxVSldvb3BQUnZIa0J0dXhIZnZUOWJrK3BtNVErek9P?=
 =?utf-8?B?YU45T09kSWxKOHhsaVJSMVRKWDhndnovdGxSU2xDUU5xdGphR00vNnhDNlp0?=
 =?utf-8?B?Z1RxanJBMmt0QlROV1BqdERUYUVLUU9VcmUranQ2QUZkeCtrQWJ2ZnRjdGFz?=
 =?utf-8?B?UmtqNE1Fd29KdG9BNUNzaFJnZzJWQURXY0x0TjdmTnJWa2hpU3ZTYWZSdC9N?=
 =?utf-8?B?V2ptK3lSMnlLai9RNEJiNTZzNTZxSVJudWhuMXV5d3ppdis4T0VGRTl5RWFC?=
 =?utf-8?B?ZmVOWnUyMUZ3K2k0MDc1c0N6M1FCSXBCSWRlZjBUdkwvV2Zxd3dCeURpUDUy?=
 =?utf-8?B?ZUU5dnQ5c3IyelVvZ3RFOU1FdVpxRTF0YXh0MERVaC9vRVVDQzI5VWl5VWYr?=
 =?utf-8?B?Rjlub3BIenE2WGR5bnVJQ0g0c2lUalF3RGRkdWRycm1pMk9HNGtYNzZKZXhw?=
 =?utf-8?B?OFl5TWwwYkVENmEvMGxPOURNTk5GbWdzMElOV3BGNVd2c2R5dmFDNURhWHNF?=
 =?utf-8?B?R2ppSGJFaEJsY3dQVHVqMndZQTBnd0lHZ1M4MXNYS29ERUtoRnpZWjE3NVZ0?=
 =?utf-8?B?Y2ZORVVYSEp6L2ZVTUt3RkhJaVNlMEFjWXpwUEMzVjNYUnVBYm55THUzMjFk?=
 =?utf-8?B?eVE5UlhoVGJQc05DODNBVUZkbGNsbDJ0Y1VLbUg2cXk5alYyRjZZYS9BNzNV?=
 =?utf-8?B?djhzY3AyMVN6SUFkWEdHVHJGOGluSFR1dEZYNDJqZng3ZWszaUkrbTZibHhi?=
 =?utf-8?B?cXJ1RVhUWGJSVUZ6bnRVdEZpVW5SNDRNM242SEhBak82aFZ5bllrUTBDSHkz?=
 =?utf-8?B?OVlKSjlnS3NUSEkxdnM1ZStJVFB0TjdteTR2SWFhVmpXSENOS01ZTmJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2ZmNzNvS3VDYjdZdmlxd3JWNEtEVmlEKy9OVlJXRG5adWFyVjhPcjZMVDV4?=
 =?utf-8?B?R2Z3Q2J0eFQvYUVHYmlCUkRMaitBSHNpc1M4V3lyMFFCOWs0UlpKNmxnR01Z?=
 =?utf-8?B?ZVk3bkkvYk9IMTFqVzhyVUhKOG82S0R0ajNKS25WN3grQUc1TjdOd2ZsYm1o?=
 =?utf-8?B?Z0VjTXBYMWY3eHlkSFdPT3BaTFFvbGE5V1ZRRG5CYjdiUkFUMjIxWFBSUnVa?=
 =?utf-8?B?ZElvUC9HS1Zra1FmRU5zWFZlMFc2WURjOXVLbklvZGVEMEFJdGE2dU9uTi9N?=
 =?utf-8?B?eUYzTlFIYXhJVjRyWjBidnBPSFJDMUtJTDlkNlRXTVphazB4cWU2Z2JDaENW?=
 =?utf-8?B?SU04SGV3aS94aDBPN2xyY0kxR2RvYzlXS3pkajRQcGkyVno3dHVQVmY0OE44?=
 =?utf-8?B?SHZRVURKYjQ1ZnpBL1hnbmpwWVAyZDdUK1VwYmNWOFZISk9UemJvQjhxRjYr?=
 =?utf-8?B?MVliRHpZU1dpRFc3TUhSZkVBQVZBekQ5akxTaWVGSmpHY1pVc0VNNlRNQU9o?=
 =?utf-8?B?dS94R2hNSXlJYTNaNUtqcEFPOEVRR0tVSXFpcC83UWdaUFVwNFdrb3lFTThB?=
 =?utf-8?B?K1paNGFYbzZTZ2cxV0hXSkJBQXlsS21CaFJGVVBMYUNucDNPeEExbGlid0RT?=
 =?utf-8?B?ZWt0Z3RSbE1VMTJUQmIxUFJrNC9vN2lpelY2aDZnWnVUSk5SNnNFZXpUSEI0?=
 =?utf-8?B?RU9uc25KbXNQRkpUWkF1YjRoK3pib0FWTzNsbmxvVUNaZTN0SGthelFFSUFR?=
 =?utf-8?B?aFBSZ1FpVlQySHF2NTlKWlFVUkhjVWQ5NmtZZXZTaWljclErTC91ZXlMMEI0?=
 =?utf-8?B?UnI3a1FvWTFjT3JNYWQ5dFdhQWlMY2M5aTBjYjJkR0RtUzhlRFRTdGJib1hr?=
 =?utf-8?B?dy8xTWhWNFMvOFh4eFk0NWp0UHJIK1ZXQUhPMUVqTU8yYythek1kZkc4WWF3?=
 =?utf-8?B?blZNN2UxclJMZkg5THhOMFd2Ri9ocjRWUWtUQ2p1UHh4eHUyOE1CUy9BL2dJ?=
 =?utf-8?B?azhJZFF3R3BvTWZQaU5wZnltaDZZbmZOcVNrVGhjT0xlMjRDeGlNcEJRL3VN?=
 =?utf-8?B?bGJ0cGtlQXZRMU1sbHE3dElLc0lLL2VtMTdHRFJZOGhJQ0FVSXovY0tYd3Qx?=
 =?utf-8?B?eU5jZlpRKzNManFvVTdyWkNEbENCdTM3dm1lUU5rcDJXL2ppeHNuMmQ1b3dC?=
 =?utf-8?B?ZmtFVmEyNVE1eHI3UlpnNGNPeExta0lHMUlQbjA0WWVSMi9TSEg2U0Q1eTZp?=
 =?utf-8?B?d2NxZ2x2SlhGbkZFcFhpaHQzeXVKaWdvdmRoOUd1eUpuQ0x0b0xGN2Z2MjFx?=
 =?utf-8?B?dHFFR2w1ZjY4L0JYMURmMXd5OURYLzYxTkFJSUxNSXNOc1BDcGVkUGV6RHpu?=
 =?utf-8?B?ZUwzSHJhNU0yUG42cms4Zk9ZNlRsZFpNSVp0WjM3TER2RHpyeEpoSjdPNklR?=
 =?utf-8?B?REVmS0FBc3NTT3QvRDU4QmlJcFJMYWJoZjFQSnh6RFJRS3pvTU1paWtucmFK?=
 =?utf-8?B?cE9mRWFmQTFWMDJnUXRRV0xuU2R5eXh1THRPdFZodXY2RjI1Q1luWlFIOEhx?=
 =?utf-8?B?Q0h1dW5PdzVvamt2ckl1UzMwSzhiRFFabXgxcXNpUlpWQmhQZzhaMDRRaVhY?=
 =?utf-8?B?MWxIa2RLTk05ME9BVllFaE5QZUNRNEpWTmRtbjVycEozN0psbGFYSUN6L0hY?=
 =?utf-8?B?QXErd1dwak1rTHNtbUNhMGRaYVNuaGs4cUpoMGlEdVEzTTBTeEU5bHJQRGdm?=
 =?utf-8?B?WUYzamRzdTBzbjQ2OHZzd3VmTDNKV2t6a3E1OGc3VGI5K0hGWS9XVmlLTDlH?=
 =?utf-8?B?dzkzcXBINXVoS2VRSUxRQkV4ZnZES0xrSUVBY1diSDNoNGwzSFZGY045N1o4?=
 =?utf-8?B?WVZuRlNmMDNTTDJpTU5JS004dGQ3b3NSTEh5aytranBEV0xXelhrN1duTHZP?=
 =?utf-8?B?WnJJTC9nTmRrTlJkN2o5endhUFFXdUtyZ0Z4ODNDdDM0aG8xQVFhaGJucjdo?=
 =?utf-8?B?L0k3dm44MGZLempzOGxCME1EYzlId3owbzVaaTVqR2wvZjhieHFobU1jSGlB?=
 =?utf-8?B?OVUzRzZPeWM0aWtFblFvb1FFdnNXNElwYlNGNXhDZEl5aVJPUnVTWEpnNHB3?=
 =?utf-8?Q?9ZjGTXW4GFraSARkVolxProwp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0d9c7d-7e48-4ae6-f1b5-08dc6f683545
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 14:07:34.2063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTRom7tlC2UdGYfiFgHK2BtQ1DJOSfwyZJl/DGt3VTI8ZZsrcP+VQ9UNaC7PoE5S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296

--=_MailMate_345C16E9-0929-4633-85E7-1B5ED88F814A_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 8 May 2024, at 1:43, Lance Yang wrote:

> On Tue, May 7, 2024 at 11:26=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 1 May 2024, at 0:26, Lance Yang wrote:
>>
>>> In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
>>> folios, start the pagewalk first, then call split_huge_pmd_address()
>>> to split the folio.
>>>
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
>>> ---
>>>  include/linux/huge_mm.h | 20 ++++++++++++++++++++
>>>  mm/huge_memory.c        | 42 +++++++++++++++++++++------------------=
--
>>>  mm/rmap.c               | 24 +++++++++++++++++------
>>>  3 files changed, 60 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index c8d3ec116e29..38c4b5537715 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -409,6 +409,20 @@ static inline bool thp_migration_supported(void)=

>>>       return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
>>>  }
>>>
>>> +void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long=
 address,
>>> +                        pmd_t *pmd, bool freeze, struct folio *folio=
);
>>> +
>>> +static inline void align_huge_pmd_range(struct vm_area_struct *vma,
>>> +                                     unsigned long *start,
>>> +                                     unsigned long *end)
>>> +{
>>> +     *start =3D ALIGN(*start, HPAGE_PMD_SIZE);
>>> +     *end =3D ALIGN_DOWN(*end, HPAGE_PMD_SIZE);
>>> +
>>> +     VM_WARN_ON_ONCE(vma->vm_start > *start);
>>> +     VM_WARN_ON_ONCE(vma->vm_end < *end);
>>> +}
>>> +
>>>  #else /* CONFIG_TRANSPARENT_HUGEPAGE */
>>>
>>>  static inline bool folio_test_pmd_mappable(struct folio *folio)
>>> @@ -471,6 +485,12 @@ static inline void __split_huge_pmd(struct vm_ar=
ea_struct *vma, pmd_t *pmd,
>>>               unsigned long address, bool freeze, struct folio *folio=
) {}
>>>  static inline void split_huge_pmd_address(struct vm_area_struct *vma=
,
>>>               unsigned long address, bool freeze, struct folio *folio=
) {}
>>> +static inline void split_huge_pmd_locked(struct vm_area_struct *vma,=

>>> +                                      unsigned long address, pmd_t *=
pmd,
>>> +                                      bool freeze, struct folio *fol=
io) {}
>>> +static inline void align_huge_pmd_range(struct vm_area_struct *vma,
>>> +                                     unsigned long *start,
>>> +                                     unsigned long *end) {}
>>>
>>>  #define split_huge_pud(__vma, __pmd, __address)      \
>>>       do { } while (0)
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 8261b5669397..145505a1dd05 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -2584,6 +2584,27 @@ static void __split_huge_pmd_locked(struct vm_=
area_struct *vma, pmd_t *pmd,
>>>       pmd_populate(mm, pmd, pgtable);
>>>  }
>>>
>>> +void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long=
 address,
>>> +                        pmd_t *pmd, bool freeze, struct folio *folio=
)
>>> +{
>>> +     VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
>>> +     VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
>>> +     VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
>>> +     VM_BUG_ON(freeze && !folio);
>>> +
>>> +     /*
>>> +      * When the caller requests to set up a migration entry, we
>>> +      * require a folio to check the PMD against. Otherwise, there
>>> +      * is a risk of replacing the wrong folio.
>>> +      */
>>> +     if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
>>> +         is_pmd_migration_entry(*pmd)) {
>>> +             if (folio && folio !=3D pmd_folio(*pmd))
>>> +                     return;
>>> +             __split_huge_pmd_locked(vma, pmd, address, freeze);
>>> +     }
>>> +}
>>> +
>>>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>>>               unsigned long address, bool freeze, struct folio *folio=
)
>>>  {
>>> @@ -2595,26 +2616,7 @@ void __split_huge_pmd(struct vm_area_struct *v=
ma, pmd_t *pmd,
>>>                               (address & HPAGE_PMD_MASK) + HPAGE_PMD_=
SIZE);
>>>       mmu_notifier_invalidate_range_start(&range);
>>>       ptl =3D pmd_lock(vma->vm_mm, pmd);
>>> -
>>> -     /*
>>> -      * If caller asks to setup a migration entry, we need a folio t=
o check
>>> -      * pmd against. Otherwise we can end up replacing wrong folio.
>>> -      */
>>> -     VM_BUG_ON(freeze && !folio);
>>> -     VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
>>> -
>>> -     if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
>>> -         is_pmd_migration_entry(*pmd)) {
>>> -             /*
>>> -              * It's safe to call pmd_page when folio is set because=
 it's
>>> -              * guaranteed that pmd is present.
>>> -              */
>>> -             if (folio && folio !=3D pmd_folio(*pmd))
>>> -                     goto out;
>>> -             __split_huge_pmd_locked(vma, pmd, range.start, freeze);=

>>> -     }
>>> -
>>> -out:
>>> +     split_huge_pmd_locked(vma, range.start, pmd, freeze, folio);
>>>       spin_unlock(ptl);
>>>       mmu_notifier_invalidate_range_end(&range);
>>>  }
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 7e2575d669a9..432601154583 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1636,9 +1636,6 @@ static bool try_to_unmap_one(struct folio *foli=
o, struct vm_area_struct *vma,
>>>       if (flags & TTU_SYNC)
>>>               pvmw.flags =3D PVMW_SYNC;
>>>
>>> -     if (flags & TTU_SPLIT_HUGE_PMD)
>>> -             split_huge_pmd_address(vma, address, false, folio);
>>> -
>>>       /*
>>>        * For THP, we have to assume the worse case ie pmd for invalid=
ation.
>>>        * For hugetlb, it could be much worse if we need to do pud
>>> @@ -1650,6 +1647,8 @@ static bool try_to_unmap_one(struct folio *foli=
o, struct vm_area_struct *vma,
>>>       range.end =3D vma_address_end(&pvmw);
>>>       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm=
,
>>>                               address, range.end);
>>> +     if (flags & TTU_SPLIT_HUGE_PMD)
>>> +             align_huge_pmd_range(vma, &range.start, &range.end);
>>>       if (folio_test_hugetlb(folio)) {
>>>               /*
>>>                * If sharing is possible, start and end will be adjust=
ed
>>> @@ -1664,9 +1663,6 @@ static bool try_to_unmap_one(struct folio *foli=
o, struct vm_area_struct *vma,
>>>       mmu_notifier_invalidate_range_start(&range);
>>>
>>>       while (page_vma_mapped_walk(&pvmw)) {
>>> -             /* Unexpected PMD-mapped THP? */
>>> -             VM_BUG_ON_FOLIO(!pvmw.pte, folio);
>>> -
>>>               /*
>>>                * If the folio is in an mlock()d vma, we must not swap=
 it out.
>>>                */
>>> @@ -1678,6 +1674,22 @@ static bool try_to_unmap_one(struct folio *fol=
io, struct vm_area_struct *vma,
>>>                       goto walk_done_err;
>>>               }
>>>
>>> +             if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
>>> +                     /*
>>> +                      * We temporarily have to drop the PTL and star=
t once
>>> +                      * again from that now-PTE-mapped page table.
>>> +                      */
>>> +                     split_huge_pmd_locked(vma, range.start, pvmw.pm=
d, false,
>>> +                                           folio);
>>
>> Just in case you might miss here, since you will no longer align
>> range.start as Baolin mentioned in another email and you have a VM_WAR=
N_ONCE
>> in split_huge_pmd_locked(), you will need to align the input address n=
ow.
>
> Thanks for bringing that up!
>
> I do miss the alignment here when I decide to no longer align range.sta=
rt
> in another email - thanks!
>
No problem.

> Zi, could I move the alignment here?
> IIUC, we will not encounter a partially mapped THP here, and range.star=
t
> and range.end should also not beyond the VMA limits.
>
>                      align_huge_pmd_range(vma, &range.start, &range.end=
);
>                      split_huge_pmd_locked(vma, range.start, pvmw.pmd, =
false,
>                                            folio);

I think you can just do

split_huge_pmd_locked(vma, ALIGN(range.start, HPAGE_PMD_SIZE), pvmw.pmd, =
false, folio);

since range will later be used by mmu_notifier_invalidate_range_end() and=
 changing
it might cause secondary TLB invalidation issues.

>
> Thanks,
> Lance
>
>>
>>> +                     pvmw.pmd =3D NULL;
>>> +                     spin_unlock(pvmw.ptl);
>>> +                     flags &=3D ~TTU_SPLIT_HUGE_PMD;
>>> +                     continue;
>>> +             }
>>> +
>>> +             /* Unexpected PMD-mapped THP? */
>>> +             VM_BUG_ON_FOLIO(!pvmw.pte, folio);
>>> +
>>>               pfn =3D pte_pfn(ptep_get(pvmw.pte));
>>>               subpage =3D folio_page(folio, pfn - folio_pfn(folio));
>>>               address =3D pvmw.address;
>>> --
>>> 2.33.1
>>
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_345C16E9-0929-4633-85E7-1B5ED88F814A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmY7hyQPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUP4IP/jtEXe9ql6qHZlb1spaBzjP3leZHlHYEtDoJ
FlQaS8iF9zP7SAkYvLQ2kK5YiYG2GOyQzUPWsPgg9zv1NcvJ7Jt0ePXkwtT8lKYs
taw0BXKuTZy8MaM17N4LAeeE9mBDL2XKzWx23dDlm3xoqyyMmcFnpqbi03+X/b3J
L5jc+zLTQUZ0AkyWpK2ceojjPSdP1BkFJAt/8LY2Y5F+I6cdDxUEjdW6kxUdv5Wa
ILx2Rvq3lTPSDWqmD/BvFuAyHlOMtUmu/yvjxLfG1iqz26C7LQTWyJFDxemsFGmM
Lw6JCXtHKNnjBMvHmVfvtg5zdy9CLgD+EsQPszbcp2+H272uyGvKtSVp3GpzREo8
P5AmsJg0jgcONUMTHKI8OBrzMTf7daOYiVph+jro6cYxy1XWvIQLvPY1qsQt4U1X
otmVPDIXK8FR/ARsOYWQSRH1P+v8JapKfUY5f46dE/j96r50YubzOIMIS1OIp1Kq
+vdDwZBnysKRW8R6CBOJnwl2QXnDLW0A2uqXW4zaJVo8h8/pREVysxVkvFqFKVwN
46BIa94dkWxGvbxkpdUbByTefPGulhErD8ZiXHUFOI/KuOrBTPy3difX6LjVmoEW
G7OxwNBKjnsHPAE0NcejNFgT5JyC8pdoTJpSt38seUpMd2XgKoqdbNnn3uuoYFnJ
ZoaVIfFp
=sqUb
-----END PGP SIGNATURE-----

--=_MailMate_345C16E9-0929-4633-85E7-1B5ED88F814A_=--


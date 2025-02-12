Return-Path: <linux-kernel+bounces-510494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C02ABA31DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D1B188AD00
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 05:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4800C1E376E;
	Wed, 12 Feb 2025 05:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="emFKy4bF"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F5338FA3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 05:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739337584; cv=fail; b=PeeF+hUiNeepZMdXYiwiTmFwE8gIH7JMv/Qw5KM07scs9FiQCnrozhFlRxQ8eJNG8IkQCz23RY3hEkPk3xQm1cad13RSc2LXwM1hxGkL+GzEJslzchBwF9dJ36MK7axdfsPgj65KU2rKCG7+i0Gj5hXLU8YdyPVWo5vk/bPjOTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739337584; c=relaxed/simple;
	bh=0ak6Iz1vVZ/L9PigfjM55OfacYkNmZDInNmKDfHoNJ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XtHnd/Y9O4FkwDwreRrW/hb9qCsCZp9lZ7xq3dGc+LcQqg5zioG7z1U2xPtb3t4r7tEnnpEMWSS9jdF8f2/1z/0a63sFA5Xi3VqL9b6/x6MBJvR6VQMur5lFazBC5RgOef+enxRELGLSVpuvdAnhnAATo0VZH3mJCRIPiKM6lEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=emFKy4bF; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MT82a6ZLYFPRvv7JnLHtxrrjGVhN2D5tOVqXVP74pMuricb/QY26LwgKeF5ETipYO/I9EmxxAkfsBSU8p27nL52exwVqJNQIt2qk9i6S8NpUq86w70h2g2rHwxz77xg5opXPWVhZ8nqP3AXR/5Uw7nBhGhHnbEv0E4ljfuYzRY6eaSLB2logBc24rknKFYSNTAy0Zxd0pBwdJx46PQzaSoK+UrzVfu/cATRgbB+CZPQqFWsH4zPCTDA8EAz/pJkZLJvc5n/XfUhaWaQS85AfohvmGfxWg4uUv9xz4VcdAcV/gl3V5Lx5aR8l5YhkJiWGxk2Tkmlx/11NU4R1T4ecjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3sNoJKjbrbvQ2wTtSZxXSTgdAhcyFe8QSEYVWWjIg8=;
 b=CvBxI4lQ7d7QHt+IFjIHiid5pNzvc2Z7OtDL+U1k6yuj9Nl4oxt8Zu579jplCb4PO2QjOL5UUMmGmzh/4VjUcPzUe8kcdKAGgSi2XZU5LNw9sGdn6Nh6Jyu5UodghWqlFxBlSz2Kk/v+e+WpDlBMsk16i1gF808JJCf2Kf/wOCuiOtIfE19kv7UmxbRWir1ccmYMtHYsOqo0p8cUk4qR4gKHEiCvC4genDt9jVutQqoiHBn368QGElvTVhFBVPhBbv67WNIH1MTwKrS5E1V42afJZ04A/F34A60F5v3U9+HvGaRqKjpfwlhy69eSIZyPXWZSOVxyMYoEyaygQt+Wdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3sNoJKjbrbvQ2wTtSZxXSTgdAhcyFe8QSEYVWWjIg8=;
 b=emFKy4bFMSvcUHUMbVjoI7mFUmFB7OBQMIznjYI6vNepn0LzPqNxuLe6zMP6kfSFXFCyGudVY3IsdSBRgwhWfWEjbIWKKKN+TLR3IffLh9FL0Ud2LErcWrJr/AqTE5E+Cn3mUEuTGnTu5f5WNun36lowlr/yvV8kTSRwZLdGQ4k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 05:19:40 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 05:19:40 +0000
Message-ID: <540ba658-bfc0-480e-86ae-fbb42a68476f@amd.com>
Date: Wed, 12 Feb 2025 10:49:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/folio_queue: Delete __folio_order and use
 folio_order directly
To: Liu Ye <liuye@kylinos.cn>, brauner@kernel.org, dhowells@redhat.com,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250212025843.80283-1-liuye@kylinos.cn>
 <20250212025843.80283-2-liuye@kylinos.cn>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <20250212025843.80283-2-liuye@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::7) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: 83755ad1-c462-413d-8283-08dd4b24d937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEd4NnVmOUl3T0d4UWRaLzVXMFZEZXA0L2Y5Zyt1RjZEbXgyUS8wU0ZuVFMr?=
 =?utf-8?B?TGxtVUl6SVM4bHVpQXRLbnhEcktBSXY0aGFJWENpUkExbnZtOG1tWUNnZFdN?=
 =?utf-8?B?TENnRVJ0ekh0b3ZBSFR1ZDhHSmJoWWZIbHk5SndlZk9USm9ET0dHd2VxeU13?=
 =?utf-8?B?YldiKzJ2QWF2REtmd3ZJTXkzKzFPQmxENmp5TXl4LytMdW1ML2lHWjEzSWs0?=
 =?utf-8?B?Z255bHZMUTkybkxQYmJuTDBvcTJnMForNk9QMFlzUTZNTm1UTjdsTVd5QmZp?=
 =?utf-8?B?ZCtlOW91QXpCQktaVzBZaEg0Zk5GdmFXSGNaOUJEMnU1c3FRSnZ5R25GNDBK?=
 =?utf-8?B?U3VHcEhDY3RyVmZrOW9rS1RGTHBsRVZiV1NQS0JneGI3SksxNUlaLzBXRG95?=
 =?utf-8?B?SDBaS21JY1Y0YXFyaFlLUnN3cWJSaiszN0o1aEppWUdsSzF3VG5CM3M2bHZH?=
 =?utf-8?B?LzhTaHptZ2NJYVdHZ21uNFhKeHZ6Z045RnJxRHpZNFU0cEQ0NGdPcEpHVEtq?=
 =?utf-8?B?WVkrdGt6UnFwZERqYXdYMUNSSmpDSG0yQUY2aG9sVlhZRGNmRWdsb09PU050?=
 =?utf-8?B?Z2doRHVYbHhBa0JZR0o2M3dUZCtnMTRQZTNNSjc3T2lOTElGOXIySWVzTUZi?=
 =?utf-8?B?dSsyWVlSczhOWFlHMFBjQ2QzSnZkNXZyTG1NcHg4aW80UURsRmNqS3BiMDJW?=
 =?utf-8?B?dVlES1hEdVV1eUx3d2lOcGxydWpGZ2gzbUFNQzdxQm1JYU9tKzMxaWswN2ds?=
 =?utf-8?B?eDJRYXB1Qk9kY3BtZVZXdXNRTW1KTlhyT1p3S3VZUHoyclBJS2YrRW5wZ0t6?=
 =?utf-8?B?SnBWa2ZKT09tSWJia0tZeHRpbFJmSEtkUU5LUk1FZVFOYklqa3pUNFJ0QUNN?=
 =?utf-8?B?QmlzdWowSjNXS2M0TGZOV1dWSWZGcE82WDF2bjdKUW05OGttV1FrNTFKQk0y?=
 =?utf-8?B?Rll6MG03aTV4VmY4NWNLYURCV0hVVy9teDJoZmswUzl3UndnNXI5UGNJVlc4?=
 =?utf-8?B?ZllHN3FRSk9tUkVlRnQ2aXUrNmQ2Z0YrQVcxbXAyNlZJTnZsMFhzQ2FmVWpW?=
 =?utf-8?B?VHdRakhlbWlpdllPZWk4a1N2ZkNSZ21DSElRRnp4bUdzSHBrVEJvd3k1YnRN?=
 =?utf-8?B?VlVnY1JUa2hCaXMxOU16M1V3WWZKM053ZE9kOVI1K0cwQUdGVnZYNGxxZGdM?=
 =?utf-8?B?T0p0MjhDTFN2UmtlWWxtcGlkMUJZVlc2a2laTHdscThxRUhzSFZJNnR4ZGQw?=
 =?utf-8?B?dDNHdmpES2NvWE55SlNPNDFrdDNDRGVFeFJVOVBFVWduOUNBWEp1UkxvSHFI?=
 =?utf-8?B?N00xeUVhMW9DTTZzQUttSUxaeTJYcmZxblR6NjY2Q3dWOGdocVRUem1UVTN1?=
 =?utf-8?B?Y3NnL3RkalA1VjIxdzF2VEdHd0NaZ3QzckUvMWYzMkdzVWorajBiNFJ2U1Vp?=
 =?utf-8?B?Y1RiVUZoZmp4VHZiQ0JLZUJBQXMwamZuVkVnV0p3M1Q4dTUzeTdMR3Z1czVw?=
 =?utf-8?B?MFU2MnB1aFMwQ3M0NjN2ZzRwQ3U4Q3hsOUpMOTRlR3N5TTg5bExoSTJ4d0Yv?=
 =?utf-8?B?WFh2bHpGeVQ0bUdVMWJzTlBWSHk5QTNlR25JVEVHSVhKT0VVWlgyUVRtNERW?=
 =?utf-8?B?cUgvaG1JdGpGdTN0MmwxdjNudkZkMFBXeWVPRTBqb3U5QmdkQnUydlBPVWNu?=
 =?utf-8?B?cmpkd2UzTy9uV0hIbUh6c09NdTF5dGRNSUFOZWx1ekFjNDZDdURqZVdVT3RP?=
 =?utf-8?B?eTlxRy9Rb2VtVlI3aXF5US9GS2o4bE1IUjFTWVZIa1B6N3FVR1RPWEVaWXJs?=
 =?utf-8?B?OEFHeHZuYmFrU1JKeENjQXBFZkxPcjl5bW5LUHo2R2l2dldadDFjcmljOEU4?=
 =?utf-8?Q?ROkZtOxFNTkgM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlRqK3Z1ODNERG9BdXdJYXdrUTM4RUpKZGlsRDlGSkFlTTBFVzg4Q3hjdjVo?=
 =?utf-8?B?MFNSOXFiZ3N4Rk1qNDRmZjJza3h5ZTRSMjZCSjZiZzBlbmxOQXVMR1UrRE01?=
 =?utf-8?B?MUg4b2pWTFFyUnlRZFdhY2pNTTFkSndzSWpCVnVSKzM1S2I3czZmWmR5NlhC?=
 =?utf-8?B?enhmaCtCOUU0ZktqdkY0cHJSSnppZUNTVGNFdDdXQWcyWkZEMWlhUFc3MDRR?=
 =?utf-8?B?UUJ0SytNM2NPeEVNdW8vRFhiK1MxUWNrOWZjOGtaVjFHRmhZSHZNVzMvSU5U?=
 =?utf-8?B?ZHI4ajV1Uk1JTlpnV1IwSWJNU3BFVytIazZ1L296bG82SE9jNUM1UnNBTDg3?=
 =?utf-8?B?bGhoSzNROVo4MTlkNG8wa2lnTDVTbjVIYW9xSWtyUFZlZTB1dnhUTVlza0RX?=
 =?utf-8?B?NnVFa1pHVjlEa1BCYzBBUTVFVk1FeFN3MW1OeVJrcU5tWkUzN0UzUUcwYUp5?=
 =?utf-8?B?MTZzdDRtWkRURGZ4KzM5MGM2MEd6MDQra3d6TzNkQ2JSbUZHSkVSd0FMN2N4?=
 =?utf-8?B?eHVBakJpZU5wcU0xNnRFZDVUZCtJNE4yVjVIMzNubyt3b0VJUW03MDJLZ1I4?=
 =?utf-8?B?cktiYTBLT3J2UXNqVGtzdHhoc2tDUzRzSFhVS05XZXBYRnN6RE82N3Mwa3pG?=
 =?utf-8?B?UTE1WjF4MjYrRmZMZndtZ2YrQTJmbncyanFGWmZ2LzZqZDZCdEF3WWVNSkkr?=
 =?utf-8?B?ZnpVRlV4M0ZkZCtjL0p4L2ozdnZkOTNMbyt0L3NZRlZxTU9NQjdOUHA5Ym5h?=
 =?utf-8?B?TDQzUlREcDBBOGdvVEN1UWliRDR1NzErcm5ML2dvcHB2cFZpNTVVQjlBYVhB?=
 =?utf-8?B?eGdpN2swdnZoNmRINlR2bHlQYVVCUjhsYW94OXhOeXgxajlGdDgybER1SVZU?=
 =?utf-8?B?VlNvcFhCMU9zRDEvbXJuZk56WDFGQ0tGdWl3RUF1cS9ZKzBtM29aQis1dytU?=
 =?utf-8?B?RWJ0cGIwZnYvdzlMNUZIa3A0RGFhS3JXVkJCRC9iSkU2dHZWZW4xUXRzcVo5?=
 =?utf-8?B?RXdGVXZZRG9YZEpJRHJvc1FibHFJYVB1QnVSd2gyRUg1L2orNjZRWU1WVExr?=
 =?utf-8?B?eUp6eDE4bTBORTc0WHhQWFh4VXBnWVRjd2lrYXZIcWVOM2R5MVdlTlEvQUow?=
 =?utf-8?B?ZGNidVVEbDR4K3VmZVhLeG80aGhoOGFFaHlyOE43Y2N6YjVlMzhhYzZZMVNI?=
 =?utf-8?B?ZVpZWDBWOUpMUHVJbU0xaVFWUXMwY0hIclE3c2w5MUJxS09BQm5XTTdCcUJz?=
 =?utf-8?B?akRFZnlGWWVVay9ZS2tYZkNlTXlkb2xwNndKYnNWeFhsdlNDSFNGU1hYcEV6?=
 =?utf-8?B?cGwwRllubHdwWHVPcFRDdDNLMkViazFmNFNsSVlONk9lS2k5VFRGRVNiK3dL?=
 =?utf-8?B?K0tzeHczR2dCK3Q3MDVocmhQRmFqaDVVVWhLS2dnM2g1aEU0Rlh3RjArQTdi?=
 =?utf-8?B?N3pwVnBCS0tFTklvcGJaL0FDVWRpR2g4d3NZOC9IUUhtMzhSaDV0NW9UQWk2?=
 =?utf-8?B?QXkvb1VEZU9nc3M1bFVFbHNtWmZtSUxja2lRaGxBV01wVktRSndZUWJGekgy?=
 =?utf-8?B?b3BtWlhodEExSitkUTlvdU12UHpJNFVYbWRBMStXNlo3dkhxb2pTYy95ZmRM?=
 =?utf-8?B?ditQVHRPSGo4a2dHVVYxbUNzZE9VaGQ1bXhkVW0wOWFVOGxWNWFtU1ZPYlhP?=
 =?utf-8?B?Y2tYeFo2TDBpNXRVOUpQeFpqL0JFRFNHM1Q3d3F2RGI3L2N4aFMvbDVPbXFx?=
 =?utf-8?B?VzhHYjI4clVNNXJvRWdYd0pHRTlwZ3RBNFF2dTFFZktoSFoyaVk1L3hMUGxY?=
 =?utf-8?B?dFFTL240SCtDb1dmTkdOU0ttb2hFNFIwZDRIb0RmQnhoR2J4NW0vOExDRThh?=
 =?utf-8?B?bTlqVndLa0dLN2pNMnhOUzVWcTdxNWZwem94TkdqVEs2bTBkSmYxOXJRRDZl?=
 =?utf-8?B?M3owYUc4L2tmbUlQQzZ5SnZDS0d4WVU5YTB3aUZBdU5CM2JlWGRWWkRZV0FG?=
 =?utf-8?B?U3ByTFFVVWZZRTVkaUJKZEc4UkZPdHZrM2IwRHJQbXIzcVRDSlB3T1hqY2FB?=
 =?utf-8?B?U0ZpQUJXckNJYmtScmRPWHpzSURzcnF2U2JjT2JwTFBPOGo1eWpsd3ZJL0Yx?=
 =?utf-8?Q?WiE75l/JoiJdpu2lq8/lpuLHR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83755ad1-c462-413d-8283-08dd4b24d937
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 05:19:40.0244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6dtA5hMhKbyyuSDQ2wVjQAq2ufbLHyyyj160841+w+jFin8Cqy8Sn8uWj9kzv0iqwLluJGVmMxBvNRGxNQ9Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103

On 2/12/2025 8:28 AM, Liu Ye wrote:
> __folio_order is the same as folio_order, remove __folio_order and then
> just include mm.h and use folio_order directly.
> 
> Signed-off-by: Liu Ye <liuye@kylinos.cn>
> ---
>  include/linux/folio_queue.h | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/folio_queue.h b/include/linux/folio_queue.h
> index 4d3f8074c137..45ad2408a80c 100644
> --- a/include/linux/folio_queue.h
> +++ b/include/linux/folio_queue.h
> @@ -15,6 +15,7 @@
>  #define _LINUX_FOLIO_QUEUE_H
>  
>  #include <linux/pagevec.h>
> +#include <linux/mm.h>
>  
>  /*
>   * Segment in a queue of running buffers.  Each segment can hold a number of
> @@ -216,13 +217,6 @@ static inline void folioq_unmark3(struct folio_queue *folioq, unsigned int slot)
>  	clear_bit(slot, &folioq->marks3);
>  }
>  
> -static inline unsigned int __folio_order(struct folio *folio)
> -{
> -	if (!folio_test_large(folio))
> -		return 0;
> -	return folio->_flags_1 & 0xff;
> -}
> -
>  /**
>   * folioq_append: Add a folio to a folio queue segment
>   * @folioq: The segment to add to
> @@ -241,7 +235,7 @@ static inline unsigned int folioq_append(struct folio_queue *folioq, struct foli
>  	unsigned int slot = folioq->vec.nr++;
>  
>  	folioq->vec.folios[slot] = folio;
> -	folioq->orders[slot] = __folio_order(folio);
> +	folioq->orders[slot] = folio_order(folio);
>  	return slot;
>  }
>  
> @@ -263,7 +257,7 @@ static inline unsigned int folioq_append_mark(struct folio_queue *folioq, struct
>  	unsigned int slot = folioq->vec.nr++;
>  
>  	folioq->vec.folios[slot] = folio;
> -	folioq->orders[slot] = __folio_order(folio);
> +	folioq->orders[slot] = folio_order(folio);
>  	folioq_mark(folioq, slot);
>  	return slot;
>  }


Reviewed-by: Shivank Garg <shivankg@amd.com>

Thanks,
Shivank


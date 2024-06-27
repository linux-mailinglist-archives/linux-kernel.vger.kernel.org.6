Return-Path: <linux-kernel+bounces-232351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A6C91A741
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431051F2161C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBB824B5B;
	Thu, 27 Jun 2024 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iN8ftUe6"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA7C145A1F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493404; cv=fail; b=mE7FalH69Ys9A/xBbot/M57YxF5ZjjsWJ3wButd13guaX7hL6GEQU5BTS9xoJgKmyz36Nb0YxZ5y4H9WXd+iIO71EWw+s0kMB+0eyegEt51/jhZQkp9+5UsviO38o0MxE1XERQUlRQZmsw0OLjDUV7MEG0EvUm1ZPWv/wpo59+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493404; c=relaxed/simple;
	bh=M/rEC8jmx3b6X4k7kuZ4QPXsDgJgy07N2t0bco/QvT8=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=l5nV3SsVaBitq3kzxmmy7R4ZHTaD9YHHPxiO5kJq7zevT9Sus4mD+HebT9P8hVKNfrXuwqx9oAsQZRLPOSDWpHI9IYX1Pvnqghkpyf4+mbGafpjXVrg6A6ExSSMVqNI0fAsdfMfZ/aoikvRKJQjnRK4BYFIO9GkS+sNudzqeAqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iN8ftUe6; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ce4XaKgKvmgHfPfvVDLxpYo5Ou7qDaiQL9un2wSE9Hj1QlzP+ZX9ARj82txBlnaHT5ANAG6QXcoyYAHDNbip9BlTohXa65ieUgse77VFQVMrWjXGbWrRrHFFu4QJz2384dbl/SDMEHnBIkqlkS/Ct4Mwhn+weZ8nnSar0O3bJWbo0n/TI3pV42pqrbO9fAwuFVPmmApmcj/+gWD3VhmP/Ra2CTmd17Tvqg/UyIoIzeyLzn+yilpLldNd6XcIaoOOkmoWWrEY24YV/dpjs4NUW6ZOpwMYaxR8wt2eKNSmyI6njdMu94NHWDFa4oJT8BbSh9aMVq/0uAGx8OLkjdUhAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSVs6iKQvBcsPX0KG4nixlrSF01vtD3zB5hThrq28VU=;
 b=LUEw/q3PCuG2IW4AfMi1EBEYGU+7muw4St9ZIjafq7uKpwuYzpKCB2cHlQsteAwAzH+6C90ozXEUJC81/HK3VBQp/npQsYwZOCZ9AghpeUD9RKqkGwpvSpjRa1mzvaUwpLnxhGvk1nMGIbn8cFNJ86hvB6W9uroKcII+zgc2LM1khfwC2if/qVZSKj/sqbRsx+7gsgWmzt98ZJUvMmdxjy8mTTb8KHM6NCr2zc1tzkA7pL0tJyUTtZV9dbpQ9Rlv90eAdmH+nxaTjtQIuTPvgNWF5MRaM33Sk5BNOvwkg98Ws2CCCRpdSOMVRhu1x3tMTIFwpB1GzLZBaf4+TxDhjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSVs6iKQvBcsPX0KG4nixlrSF01vtD3zB5hThrq28VU=;
 b=iN8ftUe6y9J3Vxe8AtXDMQjOL9TayhqrBTU1iCNvmeeFp14fCaFIBKyxR7t4bgLGcc/UoS86Tw926fEGyPuyA0xKa7pX/ALX5PdPx5SWtz0yj5Z04GecZfqm42k75rW4d5Ng/ouj2PUdVCu3wj+9g+E0V1qiTVzAOTMSzapizmycFXwote+BTHRietBlBLGfDjgaeKT+omv86CVJspV7PYS2mUuDJc7koXg69sudBcxRqvvfX35vrUij/040a3thMkLIIfgUmZVYBM+ySpVHWEfyxB6yWscvW7rK5JU3R7oLQlRxpzLC6nQxw8ejb+HrqYHYU8WYRlKTJUV5m0WeSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.35; Thu, 27 Jun 2024 13:03:15 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 13:03:15 +0000
Content-Type: multipart/signed;
 boundary=1323b1646e077f3fb47f4d0bef7e8e4165e8e28306b7cebcbc8021f3474d;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 27 Jun 2024 09:03:13 -0400
Message-Id: <D2ATJC1R3T10.14DE626BQO28Y@nvidia.com>
Cc: <baohua@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <llvm@lists.linux.dev>,
 <oe-kbuild-all@lists.linux.dev>, <peterx@redhat.com>,
 <ran.xiaokai@zte.com.cn>
To: "ran xiaokai" <ranxiaokai627@163.com>, <lkp@intel.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable
 compound pages
X-Mailer: aerc 0.17.0
References: <202406262300.iAURISyJ-lkp@intel.com>
 <20240627123854.23205-1-ranxiaokai627@163.com>
In-Reply-To: <20240627123854.23205-1-ranxiaokai627@163.com>
X-ClientProxiedBy: BL1PR13CA0284.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::19) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: f362360e-8f31-4853-c334-08dc96a981f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTYzcEl5aTMxKzFrQkZzRWQzVWl5U2dIMU1ZeWlUT1l1WFlTa3ZmaW9UQ2V4?=
 =?utf-8?B?MWVld04waUNMMkhZZ21DdG94aTMveUp3Ykhqc1RrTGhKRWJxbi8yTVJtU1FX?=
 =?utf-8?B?enFDYUV6Q01DTXB6VzU1SWViYkFJYVpEU1VCYlZtdVFqOFAzWi9od2p0NVAy?=
 =?utf-8?B?S2hnT2Y4Y2dDOHBaaHZFbWcyK29nclliNTlJYlk1Y3kzQTVkMmNHdGg0S0l3?=
 =?utf-8?B?T1dxS2xIYk94Q0tVc1ZNblgwZTFhZUVrNEp4QXhrTmxWNEZzUDZnUFNJaTAz?=
 =?utf-8?B?MDd0dzVtcXczZnRpZTVrV1NrUUNkQlJxU3NISnpZdWlaNE9lZ0dOOUlkNzNN?=
 =?utf-8?B?THR0cHZRSFp3TzFzcmJVNHFuK2trM2tZVndiT0pIb0xnNHB2UG9lb2tqYWJx?=
 =?utf-8?B?V01IT0cwQ2x1MkVCRjl6SWpoK3ZVS3lhUm85VGk0bUhJSzRjQ0tuQUMyS0hN?=
 =?utf-8?B?RFUyKzNCSFFIdGpuVkp6eTVYWFhUaXNIeHVneXNPL1FBeGdtKzcyM3VpRUNl?=
 =?utf-8?B?SkREM24xVitsMk9DSnBJVG9jNFFYZCs1MUptMzlBZjJJOXdIMHZjMUpQWWZh?=
 =?utf-8?B?VXRaZUJhQjhpZmJURTV1b3Q1eHpoYlZxdlBwQS9FMTFCWWRkVzVXeHpSMjR1?=
 =?utf-8?B?VXNHWWF5ZjBGV1F6NVFnR2lQeG5UeW1namNmaXhUZFp6R1gxaTNlamVGcG80?=
 =?utf-8?B?YWVEeXEvMCtCeThYdkhtZHUrU0VxNDFnLzJ5V3Q3dGptTnByUGdCdmpuZ0I2?=
 =?utf-8?B?NmZmVGJOajdEcU1oTmVWL3djQndQWUc4NkkzNWpnem9xbWRhQUZiOWpldUF1?=
 =?utf-8?B?Y0lFWndkTlR5dlhueFBPTnFCdzZCaXl4RFYwRGl1RmxJN3N4VzRkb2ZFS0lx?=
 =?utf-8?B?RVF5VzdEbVUzcEFIbzk0ZWE3ektHYUFkUXhsV3hkRXd1STl4ZzY2K3gwUVB6?=
 =?utf-8?B?LzNBY2JDR0hoQ2t6ejlzMk51eGZjUjRDZVlvSVM1S2VlR0lPS0EwZVVMTjln?=
 =?utf-8?B?Z0IvRCtFaGpUUU5rcDEyZzl6WDRaWFg3ZTFzaDQ1d0taWjE4dzRvQmo3WS93?=
 =?utf-8?B?UEpXWlVRNDJ4RTFramxZVTFUaDNxdEJiSjB5c08xMjE5ODhpNDdQR3RYL1RR?=
 =?utf-8?B?RUs0ZGZhVWlWb1c1dWh1NHRvK1p0cFN3K2pud2ZzZmZGclFUYWRHY2NiK2ph?=
 =?utf-8?B?ZmNzUU1OdWVEVUxNdVpFUFl4bG9jYklZbmVaejUvbFFkVUw5Y3R3Y3dVT3Bm?=
 =?utf-8?B?ZFltbFN1VnloeC9iellnTm95RWc0Y0x5ejRibXFtTnRUOVl2c2dKMzZOUHd6?=
 =?utf-8?B?MWhsbDNYTmJYdm9yU1JkZ0hqZExaaVkwTlZrTDM4cm1nRktMVk5XUUFPV1Zq?=
 =?utf-8?B?SEVsZFIrRGZZa01Hb1E2VStibkhiR0tJNTdOajFidm9LNjJIVVBrU1Rzd3Qr?=
 =?utf-8?B?UWp6cko1UFp0Sm14SlBqTWUvczNvM2NDZFNIVVg0STNpOU9UZVNqS0MrRXpS?=
 =?utf-8?B?MlRtVDVDSkFacUZia2RCNDNXaFJJMWU0SWhIRkMzeUg0WGpYMU9QbHJRaSsr?=
 =?utf-8?B?bld3OTd0cFhYa1BCSnBaelFOTU9qeTBvM0ttcFJXVS94d2VKZnluV2dYc1Jq?=
 =?utf-8?B?ZFVCeWp0bVpXMGxIVmZFZUVuWi91TE51RTJqcmRWTW1WU3JYOHNaNlNRR3J6?=
 =?utf-8?B?WXdYYTdNQmpReE9UM1A5MWd6ZkVsd0tqS0NoaktZaW9qK3A4SFhVN0ZPYU9t?=
 =?utf-8?B?N1ZwY3NPYnovVmdGemRGai9EMVJmSmJJM095NTJOaVY0ZTRGcmdSMEFMVDgr?=
 =?utf-8?Q?F4IZ2kBqN9KSBrgstrNhgzGSagHkyNbMbt6oc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amtsYVR0V0xmVHdyc1N5N09LNTBKaCtqZ3hvNzBqQUJQbGhWLzk5K2R1a3I5?=
 =?utf-8?B?R2k3VEowVHJBa3Nvck1UWk5JRkJleHY1S1hnZkhRR3hZQkk0SXlOaFBmSVVF?=
 =?utf-8?B?OVZpeStmUjFWZStvSlV4Y0xzeXI0SFhnV29QMkZzcmlzUXZCaU9mTnlNeXFE?=
 =?utf-8?B?ejRzalVnTkRRYUJGMWRscStUdUMzRUhFeGNDelByK3pXL1NxeFpWZ3ZkMnpO?=
 =?utf-8?B?Ri9IZGpOT0FUTngxYnlqV0Nsdk9MSjY1bEk5SW5tNDlSa2ZLOEtBMFAydDRs?=
 =?utf-8?B?VmxObSt3QUcyZU9WT0ttSlNUQ01XWmFnYXRqTHlGRmlKN3M1RDRpOGN4TktM?=
 =?utf-8?B?ZFNPM2lzQXV5WlJucTY0ZTZYY1NndmxDemVpbUc4emtMQ0pqYXAyc3lrUnJX?=
 =?utf-8?B?STN3MTF1VTBvckNYUkV5bTVMS1BmNmFyZENjWllyZ2ttNFVYT2Q4bWR1enlV?=
 =?utf-8?B?KzV5QkJCblNJalpCaHFKNG55cFgwSFRmZlVsdzF1amlJdGJBelhlSm15VVRM?=
 =?utf-8?B?dkd6TnhZNkFFcVhsNDkzTzYwN296R1Z2WVFML21BaEpDWTA0YjdtZlZIQm8y?=
 =?utf-8?B?TTlVQTQvZUJ1aFp0bFJudnhheTRjUDBXVWJUM0dxNHJzQmYzWWJueEFCNFNp?=
 =?utf-8?B?S0dxL1R3a05GQ2hSWlhvM0VxT05JS1RsNjNlODRlRXJucVhUcDdRVFpJQXFU?=
 =?utf-8?B?MTgxRE54bXRIK1VHYmRrRm5NTERDaFMrOXgvSUlsK1hVdjQ1SnBOTThscWRw?=
 =?utf-8?B?aU55ejgyTnIrbmJLWFIrYWJOMW5qOVF2dEYyeTVIVk5zSG16RXczRjB4QzVJ?=
 =?utf-8?B?My9PdHN0R2VZWlltRDBReElnOXczOGVyUmpQOXRXS2lXaDBFcENFNzArU2hS?=
 =?utf-8?B?THcvVDRsa2QzSUFJUGJlQWZnY0Z2cXdoTzN1b243aHNxV0RsV0pYVGZHOVhY?=
 =?utf-8?B?WXFGcGQzcGZWelBzUzIvemcxUDVhd0pQUVBmZWh1czJ1YStONUNsYXlaSnU1?=
 =?utf-8?B?UW5yUG5ZNnlIWkhRY2ZvZEZ1WXdVQlFDWFM3NjJZTmFVb21VbG1DenNPV2pK?=
 =?utf-8?B?c0dKUnFBRTFmbUtvdkFoU0dvRGVnSVVCMjBaQ2tJRmJiZkg1dXA5OFhiNDZF?=
 =?utf-8?B?cWN6ZDh4L1pvczh2ZmxWd2JnQ29Wd3lyWVBTOW9SMGljRzBCcFR5RSs1Y1dK?=
 =?utf-8?B?T1c5ZTVBMVlBUlF2Rm9FZDNhRndVZm5tcDV4N3gvMjlUWHBhZTducUFGUjEy?=
 =?utf-8?B?Y2xFSktkMFNUcllveXY1ZVRtQzhLZm5za2RacExSZm1wOTNCc2Y3TVM0bWtY?=
 =?utf-8?B?bnFLV0JtK1NMVFo4M1BKakRFNE1kbVhMODVhRjJNVjZPZ29kcWQ0MXJwdkt0?=
 =?utf-8?B?WWpySHk1YWhjZWRVTGZBZERReWFRdkFmRlRMb2hRbjR5eXdsQndneHVQcUlW?=
 =?utf-8?B?VEFqeWlGZlpHVEFsMUtWMWNrRlk2S2c4NVpMd2pVMVBlYUVmSGV4RUFqRmFN?=
 =?utf-8?B?S0FIWG9FUlYrNGZIcGhFZzhhZmE1Q3dqWEpLY0tGa2k3SCtselRVQmtRZnM4?=
 =?utf-8?B?TVliNTBKYi8xZm1IdC9NbUNvWmNmTmxCV2hURnpkVDZLeVBMU2JEZk5MZWsy?=
 =?utf-8?B?TWJXVi9vaGFPRzY4b1lsclhpMEtKeFZxcDIrTXdnUThDQ29qeWxaMFlGeWRs?=
 =?utf-8?B?cmVRRm1PNWtGTEltaHRjRHl5VllSOXZBZ1VFRE9OZzFybmRLTXo4am9tU3Jn?=
 =?utf-8?B?Ym9uUWt0b3ovTmlycVNhTWlxYld6dkJTVmVic3pVQUlVaDRzYzRlRGFSdkRy?=
 =?utf-8?B?amg2NEhxeXNhYVVwWkp3clVLdlRTSVcrNTJTSzRtb2Z4Q1VjMlNGTlZlZXNK?=
 =?utf-8?B?MXhTNDJOMnI0cnlkUFA2TTh4QWZacGMrcVFrbldudC9RYStOVitqaVhsRGwz?=
 =?utf-8?B?bzllQWNYcmJPNFpsVGFwRCsyU084djZobzJkV0VlZWhtb3BYRlF5Ky9OR1Ju?=
 =?utf-8?B?VUZJRk55TzlwSk00Szg3eDF0TWpMUG80U2dhRlpyQURTSlVDWHZkMXJ2bGJK?=
 =?utf-8?B?dk5jbWlCeTlSdGgyU0dyTUNHc1psejZuK0NxQ3hvSllRendxN2swclkzekNm?=
 =?utf-8?Q?6b48=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f362360e-8f31-4853-c334-08dc96a981f6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 13:03:15.5068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDpknyuRwDsMZ+7PssuKzuSJfIuJjhJqflZh6BXaDFYdUVoWPUnYNL4EOzaBw1S6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149

--1323b1646e077f3fb47f4d0bef7e8e4165e8e28306b7cebcbc8021f3474d
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Jun 27, 2024 at 8:38 AM EDT, ran xiaokai wrote:
> > Hi ran,
> >=20
> > kernel test robot noticed the following build errors:
> >=20
> > [auto build test ERROR on akpm-mm/mm-everything]
> > [also build test ERROR on linus/master v6.10-rc5 next-20240625]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >=20
> > url:    https://github.com/intel-lab-lkp/linux/commits/ran-xiaokai/mm-C=
onstify-folio_order-folio_test_pmd_mappable/20240626-113027
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-=
everything
> > patch link:    https://lore.kernel.org/r/20240626024924.1155558-3-ranxi=
aokai627%40163.com
> > patch subject: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-map=
pable compound pages
> > config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/202=
40626/202406262300.iAURISyJ-lkp@intel.com/config)
> > compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 61=
7a15a9eac96088ae5e9134248d8236e34b91b1)
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20240626/202406262300.iAURISyJ-lkp@intel.com/reproduce)
> >=20
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202406262300.iAURISyJ-l=
kp@intel.com/
> >=20
> > All errors (new ones prefixed by >>):
> >=20
> > >> fs/proc/page.c:151:35: error: passing 'const struct folio *' to para=
meter of type 'struct folio *' discards qualifiers [-Werror,-Wincompatible-=
pointer-types-discards-qualifiers]
> >      151 |         else if (folio_test_pmd_mappable(folio)) {
> >          |                                          ^~~~~
> >    include/linux/huge_mm.h:438:58: note: passing argument to parameter =
'folio' here
> >      438 | static inline bool folio_test_pmd_mappable(struct folio *fol=
io)
> >          |                                                          ^
> >    1 error generated.
>
> Hi,
>
> This patch is the second patch of the serial:
> https://lore.kernel.org/lkml/20240626024924.1155558-1-ranxiaokai627@163.c=
om/
>
> and it relies on the first patch:
> https://lore.kernel.org/lkml/20240626024924.1155558-2-ranxiaokai627@163.c=
om/
>
> and it seems the first patch is not applied.
> Or in this case, we should not split these two patches?

No, this is the definition when THP is disabled. You only changed the
definition when THP is enabled.

--=20
Best Regards,
Yan, Zi


--1323b1646e077f3fb47f4d0bef7e8e4165e8e28306b7cebcbc8021f3474d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAABCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmZ9YxMPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUN1YP/i0/f011OW1RGJlR7RLtfPgnB7ewGXbKcJUu
mX2OnNaPTs5GJddJLh2VcF0ztE7p3xhk6PiR2SEXbtdlDlEZkUZ7uSSamNZlUyzU
wRcmP9LpyZgx/gtQf6LmqTWigMm7OeVFOE03fe5yomPWmXk7CTusKpjehxnMYku1
6GN5KmeBR4fV9qVEDCpjdlmSRvi1ovdjU1Sk9hhztMptGszQhFM3j7cJwLlZ0OjT
jI453CduRkT6tKFnyipsmBjnzCtnPwkU/CPF0fe3Sjn6eu+Whl5+T82Fi44AsBsF
BTPE513xEVnMxyAjlFkqPKY9+b/3qMBgIaX/6RZgIdNxl6h/snv/s+plSR/Cmgrl
IPjPA6OE9Hbg8H2zjmPQyiUd+cVPt4xXX7iA13L1wfIfXm0+L0fQOwvAqB2UT+cY
IEjzfYa8Ini0bmZW5f1vrGk11SsLGzFa5h7xgmg2nW4n/vPJyUNRRdY5aGTkxfiP
C87n0/r3oSNO3jbSlcrkQwXDw7XLpmGiiWtckK93wcczR0wyuBNOrG7pOLxBTWmq
hs/QiqV+Kg3y9ncglXeonRVXfEtuBnidXJ0W0JHf3JJCsdgsIiUo1pke3GEc04PQ
RV/qdZiKQ47hsR5J+m+uVYfZ7WtlFseA1Pucmm1kWnIt6XZ/YXjI3PfjYVKVggre
hGjELTf3
=R87k
-----END PGP SIGNATURE-----

--1323b1646e077f3fb47f4d0bef7e8e4165e8e28306b7cebcbc8021f3474d--


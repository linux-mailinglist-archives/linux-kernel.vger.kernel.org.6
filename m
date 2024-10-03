Return-Path: <linux-kernel+bounces-348699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0088B98EAB4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249B41C21C57
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA37713AA41;
	Thu,  3 Oct 2024 07:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z+EA6dsv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O21geUmL"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FABF12C478
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941429; cv=fail; b=cb+v9S0AEMixUCPjrWfM/OMBL+kECTow/du9Zc5Vou76u8gSdHT9USuxDEij9+s9Ii/o0HWflap5t+P7fgCKiOGttHytiYca9M/iYLII+2zUICQQKPusmLN088cPo3gV9TrkWFlHU0ETkeGqTasQdKhFXmox2xHLBlql9+kkgIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941429; c=relaxed/simple;
	bh=XVilsU1CiIhnLxT01oNTbP8KjuRpHZw4CNztbpNNlEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kpc7eDBfIpfAScuUTWs4dF1mMcIkw2UY9dB2GfEGbQo2Ng/apewSNG8jVmtXV9dKjCUxp93STTU1kLy+il50oHnLaOzuK3cgsXtVMCLnEvSgIpd/mpANOgwYsth34Y664iD+zWWoIkOfiPHIbp6bNRpU96hGSE7A5rXgNVrg1iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z+EA6dsv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O21geUmL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4936un7p027155;
	Thu, 3 Oct 2024 07:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=UBiPT0XLOacKMqA
	/rL7Nyji3u9w+Byz2OBtALcGNi9k=; b=Z+EA6dsvE3Y1xrWg1me9I5fNi4xH+kB
	dx/d/1N6p0of7pZKyc6smP7jHnnn83yihbdjIxAgaN5gaNpvItzUWZ7gCQoIbtTn
	YCiQgzzqEvx0cnFUfrSkRVsc1CNCxYqHle4vLh7cF7NZ8OYoahaVBJx7ythE3oMi
	zyvz8036hIfcIR173s5fywtdRML1/bUOdDhQEm3oJUW8LNr6xCT1HIul4knWbbx3
	cgpEGoYjdoyYsNEZDEu0v+l1T1+TebaE8wD2hOOrGr9vIOuB8BQeTioMPbNN70iF
	8IcejGUCm1zxiCCsCrQSLQsMMkPzjoa/go2n1WbO9IbF6hSJodf+yTw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41xabtua8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 07:43:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4937R2dq028478;
	Thu, 3 Oct 2024 07:43:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x88a371u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 07:43:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nH0b33MdiKlhI96s2nH2Dzk2Ged25CFygxO+ftDKoeY7BCVKnoH3odk07xx/C1Thfxn8LsCJlzrUtExfDmF+J6v3ArQ8jcR7gqVc8d4zhh/OdmfWGLqEcPKZ5UXkQvAT1zgbPGjioeQOcrP5Ex757xhii3tvIlfquW0LWSBHrnecMP3W20SCGDlnEuWAXHGtJCEiRvFMIQ9GY53oEy63yBasjNwu74QbjIRIOqGvWU6pHRMy6hw8ZpmO9AdHK8sr1aowttSj4I6AUQcr4lyRGbCnQAKPT9UAPUNVX4sjaMtshpboiQcE4p1cU+skNnxSnxfJmWlLC7c4gWCOR/OMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBiPT0XLOacKMqA/rL7Nyji3u9w+Byz2OBtALcGNi9k=;
 b=dFWjQI1dTvGEpNNsTBhy4RuCSDUPzE9L95jeq//MCKw4u3G8ge9bkkBSnGI/HXqaZh6rTiAmkFj8nAnZI1y9/ltXWS8ocXJVE06A1cCulSYONns81sYSHT94Ch1dcrZDvinVbEQLxiPvGOEnIllOMVCQ9uWZQKzcPW4UGp7LT4MkzIJFYnAqgVbYqTvGUJiV09+t4xZj59Yk9ZJ0e51OCGCij6fk4xNtzDf28ljTgkClClhGfchWnZVHU/kCsnDosm/1u62TPq6VaWs6CWyXiKcoKIh7tcusno441nfIKI3jcO0yFLuQj3+xHWg1fKpjRHZjLTqFE3UjYu8NFA7iHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBiPT0XLOacKMqA/rL7Nyji3u9w+Byz2OBtALcGNi9k=;
 b=O21geUmLqGpC/CVczORg9FuJr/mJaud312zg6m12WN60cdkjjGX90T8AaQNMSP1zWWy+TSd/qEG7g43+0GE/qtxaBBcvdH5Iv+GvQWLVKuJnZRgPMBTdiLuZku4yuoBdamS6z5IHU1YbzP5OqT/B99GTqNeq+rOW0KHbuhkXqzM=
Received: from PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16)
 by DS0PR10MB6702.namprd10.prod.outlook.com (2603:10b6:8:132::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 07:43:36 +0000
Received: from PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2]) by PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2%7]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 07:43:36 +0000
Date: Thu, 3 Oct 2024 08:43:32 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <c0d81622-aabf-4ad8-85d6-ba324f2a727f@lucifer.local>
References: <20241002225852.3863-1-spasswolf@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002225852.3863-1-spasswolf@web.de>
X-ClientProxiedBy: LO4P123CA0684.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::17) To PH0PR10MB5611.namprd10.prod.outlook.com
 (2603:10b6:510:f9::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5611:EE_|DS0PR10MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dcba792-ba41-4893-76a8-08dce37f167f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L0+9euKT2VFKA9BMFtxnMRRP9+esxvMhhqjPKw6DQ6+yZ3EMOLPAVd0pZdJ9?=
 =?us-ascii?Q?uDuyWSXT2FJksJZzPYK9Ro+YQ923PfzS5G0JFonf2CQNtS9q1ygV6Ku4cgnj?=
 =?us-ascii?Q?KJunWKFJx2WabSVnPXm/ijL9FnBLeO4fO31omqa1xwvqC5LzF+FK6PFT8e8J?=
 =?us-ascii?Q?iilvlR61xyum8vAZOA7PEiomDrQD+NV6qvjqtOd4Si0m94DS9LF5zHfhta7G?=
 =?us-ascii?Q?EAeHcJCGqGBGZtV+aSZvuuN2XNxXHWO8hRu4o6ocku1ZH77iP/RjqycH+HHh?=
 =?us-ascii?Q?AS2AGNh92Zeb2AogTXTqfumR5gi/Dj5VLj6t1JkuVAykV56Mz6vIxlbQdTw0?=
 =?us-ascii?Q?pcxazzQDsF63T8LBTBM6ut9pD46rj80L4ll2IU80McfAyPUyCPu0X5RL2kJa?=
 =?us-ascii?Q?d2OR2X/GraxHSZxPnxj/1Ww/SE1TOj4jsNZZMeEG8/Slj4iCgb1TADCqF6+a?=
 =?us-ascii?Q?GpqV6dwGtRLQRpIe8JivRZtoUiOMk9SrGEbFMjloAMPpng2+9SegW3TeLNbi?=
 =?us-ascii?Q?JY+iF509yTvhG1zHCtQwMqjjNoTEHfIX7dAMeIZ1WJ3nydW62hwcYqTlBoXK?=
 =?us-ascii?Q?v9tPGtAyGn47+o8wFTKDevSg3ApA5/0L53cSlyP8u77rBvws/sAlqbe99F5Z?=
 =?us-ascii?Q?WhUtoteK7Sd8UAmUuWweGd+GnLQbpzbBJ+sEvgboRWDwn0j74I47KlC5Be/l?=
 =?us-ascii?Q?2B6HNSo/J4rYO+aOp8n7Cx6jTzV5kF0kijNYZDo2QOOzgEC/4yLRcaV42wHv?=
 =?us-ascii?Q?U15RNplHO98gwdu9hfmsaaRnBvfT3Foy/76Vwm5a7uOzjovkCwBiNI6AudD7?=
 =?us-ascii?Q?hiVmYv/UkYNuuJSX6cZM0/NhzZfbe+vRsyzbvBqVEY6qKM6IOb5t6WFBAB17?=
 =?us-ascii?Q?E9vDCz3n3TA0u5jSbD4mMZF8c8VBSTLSsPlJ5RcTiTYryAJNIg56NhySS+JJ?=
 =?us-ascii?Q?MojqyQV1dAYL6O+fszYB7/1DcclALe+O0doyVdbWFgdGO5sA9t1iGsNJ4z3o?=
 =?us-ascii?Q?DtM40GBDY/ne1+8X6lb6kV/aELrHVNJY02wNmprzBvJVZysWdL7SN6VFHkbm?=
 =?us-ascii?Q?7jax/ctXBHMCP7GPRXz4kGbYyyIGFPKDJH7yECqDYemA8nIM1CEjVeX2y5ku?=
 =?us-ascii?Q?cGVwsHaDxyDF5dceBZiy/BXepD2Uv6PcInw2917zWZIbQuZMb+lYxL4BOKma?=
 =?us-ascii?Q?LOkM/ZnLOGaAlsvWvh9K9Vu0DaLiSjzc5M1/uLRNsRV+9R3B0StCqzoWW+pk?=
 =?us-ascii?Q?8YPuY3/P4IGfPV/NoTYRTHM5n2NBNukAsMvhQKr3Rg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5611.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PsJ8WLb86+bRN3cGMOl4aS39GaMOfmkLR16OJyaNakY/igelUNlMaBNfC2Mc?=
 =?us-ascii?Q?3K99CroQkCSE5nu/jwDLS7UUZTdBzpXCn8GBlxdcK0miqy3dW0/pXoEcLhiD?=
 =?us-ascii?Q?hqFvReHTYJIW2YToviPhLVJG8rrsS64ux0l+oHVRcdC7VjaP/TqivAY4sNKz?=
 =?us-ascii?Q?4oQXYdj7Oz7OhSWiDCZuqI11FvaoICGMTFdoRR2jKk1YCIrL8NaSoUQgQbs9?=
 =?us-ascii?Q?lb+v/WTeHvChN9FxJ8PfTbAmRM1YKzmkoJokgXTshWI0LQ+jNFzwxZXc/+hy?=
 =?us-ascii?Q?s3RFBrgfyoK5qG7Ooh09hqxexrKYCHlN9OCoV6Dsu4+brP+Y7lhTssyutyY2?=
 =?us-ascii?Q?dSG3xkz4CfFQQinScj+cB6qKIDHFGciK39kAWwBtLvexc3sq8f3RNHKCfKPY?=
 =?us-ascii?Q?w7lVTLBlNqc9Lxo4xkIOCusofjP6bU4EUfp14TdOqvdBWflB8SrlTZoUMhhK?=
 =?us-ascii?Q?nnsk1sRGwpyk79r+4PNMrcXKAI7ANo3mMriYwnkFl69FpJuV8EviYfqrRERg?=
 =?us-ascii?Q?ti8e2NcqJr6Fpdm3gmKFi3oOgcmz8UqzrPvM8yLGsqLukinAwtasnE7qWDbm?=
 =?us-ascii?Q?pv+rUvVK8BQeIcrXuqDO/K341G7e7tOCC4QYd4Kg6M8x6xE9qj8hYXe/qeds?=
 =?us-ascii?Q?8NGEAwoEZ4zWLg0JiiccUCJNKBpRtZgSr6gDrn4S1N0BZw5fH3dCzcovlN8d?=
 =?us-ascii?Q?VEHdRAW2qV2o/83FykTmFEJzfIErjvS7Ot+QNnhdexrWuFvfqlZMyYWnDNXy?=
 =?us-ascii?Q?i5J1TVLpZ6Bb+Twp2OCuY6cnyWAXybLjsGZVIPZCc1lsSyqwnULkR4Ol/+9y?=
 =?us-ascii?Q?xh7JoynyQ5fQEVlDiQGk51ehu00BZbby2LtmbuoJ57yduY+xRuzDAsDQM+Q9?=
 =?us-ascii?Q?3RoNI47XtsnHBpif0kgc8kYxDneIiO20ESPdcvOH8ppUu9WwghRLTHXZaRJs?=
 =?us-ascii?Q?JlFMPKhHDBoEK3HZliIO7a6ojaqhnwjgJ5dgnIePfWV/D7H+/k3OnTsCsaQg?=
 =?us-ascii?Q?1PjDOaN6s06Qug96SkS3AmJtLomdQ4bl1Q8GtwZduCOLabBBPOfQ5v5W7V+N?=
 =?us-ascii?Q?NRyoY9QEE2o7HhHrK2KFIrQbZBZjInKzH4KV4MFBueh8Vb6kDdWmx3lvlA0p?=
 =?us-ascii?Q?E4xHm+RfZgFPD2pnSjPTjYpzzOtHcAfR7rzm2WQFqbtMFTgLQ9iqUf5lYIJ1?=
 =?us-ascii?Q?/maBBIDcILhHZuNnw7AcYMvTzqS2tL1z6LH6b0j4pEFnA8ihNBtlqZ0cGkiq?=
 =?us-ascii?Q?to5LIovc4H+XWk1tyaOtDREsiOzqLWwphSz12wB1luvLuw4UfxQ4lvyOgDHY?=
 =?us-ascii?Q?Z0X5FZDeEEuyOrGSb20VkJo3TNyNVluwkBzWJ6W+vZoZAx86J0SgcaftLPS6?=
 =?us-ascii?Q?IesA89WpUuepcLTkNN5IqX8b/J0nMDkjhudnPKvxgVp5wsgX281/WH9pr4rJ?=
 =?us-ascii?Q?AdVRGDKehf4b1hNdCasfJefeRbehLVwHfhazAY0RY1s8ATXe+CxciPgKU96/?=
 =?us-ascii?Q?Mmhl4LzEePj1indXERp8DnbtkmnZ9ErCYhraASxBQg0MW3qvnwS99rk3KreE?=
 =?us-ascii?Q?vMcD1ExZb/UODzQyBbqnv2gVzasRXy4hVCntNqrkiXymcSSY8aEofinxKCXV?=
 =?us-ascii?Q?DpUZD8wsoXtH6lebiVzkKBvMrtCzXTvyxc77Db+zGskqPhObZGSvR59CGhU/?=
 =?us-ascii?Q?UmkWIA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T3kMtbXGkWXINQBXix7jicxBtn3qsvSiNi/GVJuFli1oeWyXRAlvkpHCnLSR9PaZBfE/6NOQ4HiEKc2zjViFw2MOH4gM1RtzZ6xxnuE4Ae5hy6ERsATFC1rDPhBrdtWDRVDsPnQFp61r07PWGA9v2mVlBkkom9mXaF0JvvcNteBmbg3Mo2DMAA1SpxS/uY0BOOnK3BEKkPAyCZkKkKsuXjSkIbwpwaxBiSCruFTRSZGqznfAs4wN0nx20FWOGoZ/XFaJ6J0Aeif8BqxLyrdL9/Db0dTSHqOSryzY4s8ifFTpsdX/UVMLiAaGh9m7NsrFZVHsHCgi+PBEmo9gAF3YrV2kx8JpkMU6gcgg4TUDIvpVfVDrav8mWe5wLLUI2zSHnWPZISayrztJCdGZY1iqF2t86A+MOMvguMsiJBEc+ckWY039oJdzVYfQrTmZ7vmUE249Jq9jdmfk6KaCx+GygGK1JlBgmJQujZUfQRSUlvhQL9WPCfXQTqCplfH6ZGhJpczWWMEsTGaGgh4BeQ6+Fjdu07ULZXW0MfsheJ9ExOJOEe0AKcIXGxyOKx8XVZEZX0kqTaXFdC5yUUm9g9gg/8Y5eySehuyA1WvK6/FUofI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dcba792-ba41-4893-76a8-08dce37f167f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5611.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 07:43:36.0051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rav+Ff/KDqVzrK5jsGAUzCTbQ3NJCuw7EkmNw7rLy1nZTKDuBZSZuKCofJ1k0Weh28Lsm0ZzDbZ7Ts4nqFwNiq4ghrhE4oVqNzhBm11IWaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6702
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410030053
X-Proofpoint-ORIG-GUID: LOjyYRfGoTdqtXnVQgR8zjxq99WMXap0
X-Proofpoint-GUID: LOjyYRfGoTdqtXnVQgR8zjxq99WMXap0

On Thu, Oct 03, 2024 at 12:58:51AM +0200, Bert Karwatzki wrote:
> I justed tested the same kernel version with a .config which was created by copying
> the .config from the standard debian kernel, running "make xconfig" and saving.
> I got a crash here, too, but only on the second attempt (this has happend a few (~3)
> times before). I'm not posting the log as it got to long due to the repetion of the
> procedure, also a standard debian kernel does not print the thread id which I guess
> will make the log more confusing.
>
> Bert

Replying here as the dmesg logs kill any thread you post them on sadly.

Could you try this updated version of the patch? Realise there's 1 specific
bit of information we need :)

Much appreciated as usual!

----8<----
From e2d37475a47f62e1c21ef2b7ab9432f019c4431b Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Wed, 2 Oct 2024 09:19:28 +0100
Subject: [PATCH] hack: mm: see if we can get some more information 2

Add some dreadful printk() hacks so we can try to get some more information
on what's going on.
---
 mm/internal.h | 15 ++++++++++
 mm/mmap.c     | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 mm/vma.c      | 34 ++++++++++++++++++++--
 3 files changed, 126 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 93083bbeeefa..cd9414b4651d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1443,4 +1443,19 @@ static inline void accept_page(struct page *page)
 }
 #endif /* CONFIG_UNACCEPTED_MEMORY */

+static inline bool check_interesting(unsigned long start, unsigned long end)
+{
+	const unsigned long interesting_start = 0x1740000;
+	/* Include off-by-one on purpose.*/
+	const unsigned long interesting_end = 0x68000000 + 1;
+
+	/*  interesting_start            interesting_end
+	 *          |--------------------------|
+	 *           ============================> end
+	 *        <=============================   start
+	 */
+	return end > interesting_start && /* after or overlaps... */
+		start < interesting_end;  /* ...overlaps. */
+}
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index dd4b35a25aeb..2a584fc5c937 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1341,6 +1341,18 @@ struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
 	return vma;
 }

+static void ljs_dump(struct mm_struct *mm,
+		     unsigned long addr, unsigned long len,
+		     vm_flags_t vm_flags, bool is_unmap)
+{
+	if (!check_interesting(addr, addr + len))
+		return;
+
+	pr_err("LJS: %s mm=%p [0x%lx, 0x%lx) [vm_flags=%lu]\n",
+	       is_unmap ? "munmap" : "mmap", mm, addr, addr + len,
+		vm_flags);
+}
+
 /* do_munmap() - Wrapper function for non-maple tree aware do_munmap() calls.
  * @mm: The mm_struct
  * @start: The start address to munmap
@@ -1354,6 +1366,8 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 {
 	VMA_ITERATOR(vmi, mm, start);

+	ljs_dump(mm, start, len, 0, true);
+
 	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
 }

@@ -1375,6 +1389,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	VMA_ITERATOR(vmi, mm, addr);
 	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);

+	ljs_dump(mm, addr, len, vm_flags, false);
+
 	vmg.file = file;
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
@@ -1390,6 +1406,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,

 		vmg.next = vms.next;
 		vmg.prev = vms.prev;
+
+		if (check_interesting(addr, addr + len))
+			pr_err("LJS: prev=[%lx, %lx), next=[%lx, %lx)\n",
+			       vmg.prev ? vmg.prev->vm_start : 0, vmg.prev ? vmg.prev->vm_end : 0,
+			       vmg.next ? vmg.next->vm_start : 0, vmg.next ? vmg.next->vm_end : 0);
+
 		vma = NULL;
 	} else {
 		vmg.next = vma_iter_next_rewind(&vmi, &vmg.prev);
@@ -1413,9 +1435,32 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vmg.flags = vm_flags;
 	}

+	if (check_interesting(addr, addr + len)) {
+		char *special = vm_flags & VM_SPECIAL ? "special" : "";
+		char *has_file = file ? "file-backed" : "";
+
+		pr_err("LJS: Interesting [%lx, %lx) flags=%lu, special=[%s] file=[%s] addr=%lx end=%lx\n",
+		       addr, addr+len, vm_flags, special, has_file,
+		       vma_iter_addr(&vmi), vma_iter_end(&vmi));
+	}
+
 	vma = vma_merge_new_range(&vmg);
-	if (vma)
+	if (vma) {
+		if (check_interesting(addr, addr + len)) {
+			pr_err("LJS: Merged to [%lx, %lx), addr=%lx, end=%lx\n",
+			       vma->vm_start, vma->vm_end, vma_iter_addr(&vmi),
+			       vma_iter_end(&vmi));
+
+			mt_validate(&mm->mm_mt);
+
+			pr_err("LJS: Post-validate.\n");
+		}
+
 		goto expanded;
+	} else if (check_interesting(addr, addr + len)) {
+		pr_err("LJS: Failed to merge [%lx, %lx), reset...\n",
+		       addr, addr + len);
+	}
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
@@ -1441,6 +1486,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (error)
 			goto unmap_and_free_vma;

+		if (check_interesting(addr, addr + len)) {
+			pr_err("LJS: call_mmap() on [%lx, %lx) old_flags=%lu new_flags=%lu new range=[%lx, %lx)\n",
+			       addr, addr + end, vm_flags, vma->vm_flags, vma->vm_start, vma->vm_end);
+		}
+
 		if (vma_is_shared_maywrite(vma)) {
 			error = mapping_map_writable(file->f_mapping);
 			if (error)
@@ -1467,6 +1517,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			/* If this fails, state is reset ready for a reattempt. */
 			merge = vma_merge_new_range(&vmg);

+			if (check_interesting(addr, addr + len))
+				pr_err("LJS: flags changed for [%lx, %lx) from %lu to %lu %s\n",
+				       vma->vm_start, vma->vm_end, vm_flags, vma->vm_flags,
+				       merge ? "merged" : "");
+
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
@@ -1510,10 +1565,23 @@ unsigned long mmap_region(struct file *file, unsigned long addr,

 	/* Lock the VMA since it is modified after insertion into VMA tree */
 	vma_start_write(vma);
+
+	if (check_interesting(addr, addr + len))
+		pr_err("LJS: mm=%p: iter store addr=%lx, end=%lx, vma=[%lx, %lx)\n",
+		       mm, vma_iter_addr(&vmi), vma_iter_end(&vmi), vma->vm_start, vma->vm_end);
+
 	vma_iter_store(&vmi, vma);
 	mm->map_count++;
 	vma_link_file(vma);

+	if (check_interesting(addr, addr + len)) {
+		pr_err("LJS: mm=%p: About to validate [%lx, %lx) addr=%lx, end=%lx\n",
+		       mm, vma->vm_start,vma->vm_end, vma_iter_addr(&vmi), vma_iter_end(&vmi));
+
+		mt_validate(&mm->mm_mt);
+		pr_err("LJS: Post-validate.\n");
+	}
+
 	/*
 	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
 	 * call covers the non-merge case.
@@ -1530,6 +1598,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	perf_event_mmap(vma);

 	/* Unmap any existing mapping in the area */
+
+	if (check_interesting(addr, addr + len)) {
+		pr_err("LJS: mm=%p: About to validate [%lx, %lx) addr=%lx, end=%lx\n",
+		       mm, vma->vm_start,vma->vm_end, vma_iter_addr(&vmi), vma_iter_end(&vmi));
+		mt_validate(&mm->mm_mt);
+		pr_err("LJS: Post-validate.\n");
+	}
+
 	vms_complete_munmap_vmas(&vms, &mas_detach);

 	vm_stat_account(mm, vm_flags, pglen);
@@ -1594,6 +1670,8 @@ static int __vm_munmap(unsigned long start, size_t len, bool unlock)
 	LIST_HEAD(uf);
 	VMA_ITERATOR(vmi, mm, start);

+	ljs_dump(mm, start, start + len, 0, true);
+
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;

diff --git a/mm/vma.c b/mm/vma.c
index 4737afcb064c..33f80e82704b 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1108,8 +1108,13 @@ void vms_clean_up_area(struct vma_munmap_struct *vms,
 	vms_clear_ptes(vms, mas_detach, true);
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		if (vma->vm_ops && vma->vm_ops->close)
+		if (vma->vm_ops && vma->vm_ops->close) {
+			if (check_interesting(vma->vm_start, vma->vm_end))
+				pr_err("LJS: mm=%p Closing [%lx, %lx)\n",
+				       vma->vm_mm, vma->vm_start, vma->vm_end);
+
 			vma->vm_ops->close(vma);
+		}
 	vms->closed_vm_ops = true;
 }

@@ -1179,6 +1184,10 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	struct vm_area_struct *next = NULL;
 	int error;

+	if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
+		pr_err("LJS2 vms->start=%lx, vms->vma->vm_start=%lx\n",
+		       vms->start, vms->vma->vm_start);
+
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 * Does it split the first one?
@@ -1202,6 +1211,11 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			goto start_split_failed;
 		}

+		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
+			pr_err("LJS: mm=%p vms=[%lx, %lx) split START of [%lx, %lx)\n",
+			       vms->vma->vm_mm, vms->start, vms->end,
+			       vms->vma->vm_start, vms->vma->vm_end);
+
 		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
 		if (error)
 			goto start_split_failed;
@@ -1217,12 +1231,23 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	for_each_vma_range(*(vms->vmi), next, vms->end) {
 		long nrpages;

+		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
+			pr_err("LJS: mm=%p vms=[%lx, %lx) UNMAP [%lx, %lx)\n",
+			       vms->vma->vm_mm, vms->start, vms->end,
+			       next->vm_start, next->vm_end);
+
 		if (!can_modify_vma(next)) {
 			error = -EPERM;
 			goto modify_vma_failed;
 		}
 		/* Does it split the end? */
 		if (next->vm_end > vms->end) {
+
+			if (check_interesting(next->vm_start, next->vm_end))
+				pr_err("LJS: mm=%p vms=[%lx, %lx) split END of [%lx, %lx)\n",
+				       next->vm_mm, vms->start, vms->end,
+				       next->vm_start, next->vm_end);
+
 			error = __split_vma(vms->vmi, next, vms->end, 0);
 			if (error)
 				goto end_split_failed;
@@ -1295,9 +1320,14 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	}
 #endif

-	while (vma_iter_addr(vms->vmi) > vms->start)
+	while (vma_iter_addr(vms->vmi) > vms->start) {
 		vma_iter_prev_range(vms->vmi);

+		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
+			pr_err("LJS3: addr=%lx, vms->start=%lx\n",
+			       vma_iter_addr(vms->vmi), vms->start);
+	}
+
 	vms->clear_ptes = true;
 	return 0;

--
2.46.2


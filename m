Return-Path: <linux-kernel+bounces-183811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D938C9E78
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5220D283192
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB48136673;
	Mon, 20 May 2024 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JaJizE9T"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35920135A6B
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716213470; cv=fail; b=eUhUJIAPo85wR713UzeyBNawM1ma7pQixq3YSwQJOqrjS31EVVsPhc33ILrLL50UCjdQb0pUB86o2to6EKlVJcjgkd9oyCNhfW9diUUDa/ErlxsEmlw8d77TTucVzWxrjzyVrRnmEXmv4jxxPO8X++gJ0Dg0nuY31/QJQO0WgGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716213470; c=relaxed/simple;
	bh=Mj6cOzSqHvPra7g+Emazt3R98Xfd2pHoU/7IL+hJiiY=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=SXGFudF6ayeFNzaVWvlm7z+yDV0aFlDyORUD5staCVhTVx9YNkbaprUakn1QhhmD/phsJFfxQ8BmFt+0d0KcbbaKeVFfRvVXeC2yUfk6M/5wfigEIH/4iDm1EERQjfk1efmWwe352Q0TDiZxKBm+8B8BMYn3tjhCemasGvoUsfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JaJizE9T; arc=fail smtp.client-ip=40.107.95.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muelqyRuKr8tZWfmTUWARvayVcQYm7QArXhmM7+A2wyz6/Egr8SSyIW+Z6MlfoSC78ZPaqoDCXyeq0sqzqG80fLXJ9AChnA+XbYMkD+RdcD06cXi6xzi4h7gzkTfcGhpBuh6X4MCs6sYg/QWM73pWazhcNj1DBc/hFiDr68zdOe6GDSqIijBoh/ygTR3v102fx9Tca20d2tkzSARqM+ZZ6Kt/EdgP2lkwGKvTEwt5j9V40EK2lw/tg2L9GHYf4DM3EgOhHik+dzLmgi9WusbHrYmTTSKQOgXCj3+AQS7j4i+C9MhVFNGRNihqGHqtcFV8ATE+L6YFnzeGQdKtoEqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0FFZ0t27/ssnqVjVUm8RKiTC58eC0Cn6C9xCl0K5Cg=;
 b=lyi3nFrbVrGsZoEJ1pbF/nzIicSaTNA9nMHRCN6shfmfVzq6fAi4s9OxU5Hv/PGzPJdHgRiQobPM4ZEgHLjNXAOhuLgnaerp+pOmJ9/ljb2I5GaOccyk90FRZawq94dgK4rK8zI2cTdnOFZMyoytnVR083z3N+jOAvPv700ohQr+sbMFLJ6p1LxMD3XOlRN5Lz7aovnWVhPV1nSzjE0+NwAvOTffi674lJotsJEmsjX2/Z4TvXdzIxLbelqr9o49zMlZ118OGPZGabjKjRnu34vGhoMNmQdM8/2XCtWl7OfrodOcEwF/41co0kfRyrd4YcJ4J56W+u26J8qT/jHo3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0FFZ0t27/ssnqVjVUm8RKiTC58eC0Cn6C9xCl0K5Cg=;
 b=JaJizE9TtoABkItEMhHOcAGQ70riR6BgcKMsQF4mWLWASn06eBSjpDBiKYZlxGNgG3EDMeaz5i5HIjbl/+o20VwLN8rSzof1ty3Jr4RelGvDcjEJuARs2TYBs4jPGRDsZU04scHB2kyxIvEGuMKn/9b2Qp85M1e57aKZKnn+62k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CH3PR12MB8187.namprd12.prod.outlook.com (2603:10b6:610:125::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 13:57:46 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 13:57:46 +0000
Message-ID: <f8a92b19-9090-40ea-c2cf-707005f583a5@amd.com>
Date: Mon, 20 May 2024 08:57:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 svsm-devel@coconut-svsm.dev, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <6cf54cac47f212f4c2b59b123855d8c183989022.1713974291.git.thomas.lendacky@amd.com>
 <20240502093520.GRZjNeWLXU5j2UMOAM@fat_crate.local>
 <66928741-aa5c-4bbb-9155-dc3a0609c50a@amd.com>
 <20240517155858.GDZkd-wkWmYegos-eT@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v4 04/15] x86/sev: Check for the presence of an SVSM in
 the SNP Secrets page
In-Reply-To: <20240517155858.GDZkd-wkWmYegos-eT@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR18CA0027.namprd18.prod.outlook.com
 (2603:10b6:5:15b::40) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CH3PR12MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: f434e58c-ae14-4ec2-3233-08dc78d4d38c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWFzMHhOOGZFc21UR3NYVHZZQkRrTm95ME9wQjFRN1hMeEZVUEZLM294M0J4?=
 =?utf-8?B?eUVXZm04eVlsalpZNmh6SldrUi90S2xFc0hCcExzRFJ5MllwU3Z4ekpHL0w2?=
 =?utf-8?B?ZEZTdXJMV0U3VG9qaGlYMW41TlBqVmhrWUI3aWttbllJUjJJWkhBS1FwK2Nz?=
 =?utf-8?B?SkFDTmZwNWJ4aXVBU2ZiUHh3aGhzRi9aRXJpVG5YZE9nclB4cTBkc1RrQjNo?=
 =?utf-8?B?THR4S0drMEhrYmNURVF3LzBhVjVSWUhHbDVrOGtVYXlKRTIwYU9BTFMrQnY3?=
 =?utf-8?B?L3g2K2JKTGRyYmpVQ0dsK0JCSGNlU1dkOU1KdW1FSlFvd0VoNU5OM2JqUkY3?=
 =?utf-8?B?blhJZ1V0N1Flb09BZ1J3Vk1nVzVWdjZ0ZTFSTEVCVGtjazAyUDNWelByc1FY?=
 =?utf-8?B?Sk5ZSTUrc09iSFh1cGFoaXl2dC8zMVFGdkVYdTVKc0huZTIxZVFMQWI1cER0?=
 =?utf-8?B?MjlKOGZENTBjLzI1RVMyZnBpYnRScEV5TmdOaG9pOXVaaGdpZGQ1WGh2RUho?=
 =?utf-8?B?TDg0VUpQT2c4VzF0OFUyUTF2Nm5DZzdIKzF6UDFTM1h3STlGR3p2S3U1TTZQ?=
 =?utf-8?B?YThWNXZ5Q1MwWlBLSjFQNU1MZ1pPckJNNjZMVnZjK0drOFcveFYrMkZUbjM5?=
 =?utf-8?B?Tk9qbCtxU0VYRlhkcFhPTkhsbWxxYzFZamFQOEltaENEeHU3NC9Ub3NDUEVr?=
 =?utf-8?B?WHJFdHVKRHRFWlM2MjQwZXo1bnJTWmIzZ3h3SVN0andjaTh4czNKQzlZeHRD?=
 =?utf-8?B?aUxlYWZRQ0dDWmVJWkNFeTkzd3kzcDRGa0ZvVis4MmtCdmczR3Z2MGREdUlO?=
 =?utf-8?B?ZGUxT3dzcC9HVytjTVZpZ1NpSEZ3ZWFERnlrelE0ek04MCtKUC93MFhSS0hU?=
 =?utf-8?B?c3pZYzhkWnE4OGhDaFJxOTNrakJPeDg2Smc3bUh3U2paVks4dTVOUzJQNVMr?=
 =?utf-8?B?NHR6RExIT2VsZ1dXSURTQkFFdnIydTBncWxaK1k0RU9TQjhvTFh5VjFnNUor?=
 =?utf-8?B?ZDN2YTh6cWgwUDZ3MG1ZdWdxNTY2MFExeDlFUFd1cEVLQjVmRkF3OHZLZWl6?=
 =?utf-8?B?UnZ0T3Vzb1JWYmcwUFBIMk1OU3lBRzQrRkUweGc4Nzk3ZHcrQ2lOUGlOZUJa?=
 =?utf-8?B?VHNoQ1IzbVdrYjQwclJFVE5aVVRiRTYvZVd5Z1VyWU5uQ3BkSFFXaW83aHpO?=
 =?utf-8?B?Z0ZIQkwrVVlRdUNWejR6MWxxRVRoRnhjYzN1eXNOOU1NK2cwL1UxVDdHb0Yx?=
 =?utf-8?B?a3hyK1F6aTJMNXd1YVlrRy91czU1SE0rUEdHY3J1ZmZsekRFWXpuUHlzb1hN?=
 =?utf-8?B?aXNkZ2Z1ZDFGUUxwekRKNmRDbGZ5UjZKaFNmakZuTGVHRDYzWGxnZ1ZXUVFj?=
 =?utf-8?B?N29QM01qRkVOU2VuK3BZOXJ6S2xpaFB2bmVLckpIdXJoTkowbFlabXFlMmFo?=
 =?utf-8?B?WWdXOC9XdFEyd2NVcGt1cklUcE1lWU1vNjNia29SUTZtckVKVDJBdFZ6MDM1?=
 =?utf-8?B?L2xVMllTRFQyT1gydjB0bmd3OGdDQ1EzVDdjdVE0S2h2RnA0VHRlTitpV0JG?=
 =?utf-8?B?SHJqZWd1ZXNwOXIvK3RGUy9oRzIvQXhqUk1vdHVaTTNyUndpWlZsWVkrQVJL?=
 =?utf-8?B?UEdkc3d4ZHIvWjhFMllNM1BCUTBibFZZbEFYTmJZVnllVzBKZ1FrZ0pnWVhi?=
 =?utf-8?B?NHFUc3RLVUhWbmtteXBGWUxiVUFjVTRBR2pMR1h0dW5UU2pzQ1YxOUhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmVwNW4ySXRsUGQzMzRwd2tvUWJjdnJ4Z2FTOXVsbE9rWEIxKytmOTN5M0lZ?=
 =?utf-8?B?WUJ6Nm9LZ2gwa0E2bmpPYWthSmV5OG5BVjR6Uy9ydk5Ub09rY2NqbmJlUFpI?=
 =?utf-8?B?cXlINGR3c21GTE8xVlBRQi9VNmxUbjU0TEszY2hkN3hyd3A0Rlg1NUVmelpV?=
 =?utf-8?B?cGlpU0J4c0ZGR1dQN3dSVzh1YnE0c2dQOWZucm56KzcyUHZQQk5WSlN3RXo3?=
 =?utf-8?B?SGw0L3Z2cVJDU0lHYlZVbnB1aXpoN3VsbzZ4bWFaRmxXSnpUbHJETXNkS1hI?=
 =?utf-8?B?K2tlQXRxZHh0VEdMNzhWeWxmMmxqTkljQWhqcmIrTk1pajE0WHkveHlod2Rq?=
 =?utf-8?B?c2dBaHJSREdpWkMrcmhRVlIyVWVlZEFFWUVucjMrM0pwS0MwcFllR29yWWY3?=
 =?utf-8?B?NDU2Z2dVUWI4dlZMdzUvMVV4NlNveU0xVERJSUNjYjFaWGtrOHpsR1Zzb2tT?=
 =?utf-8?B?SDRDbDZGQXdWVkg2b1paVzhZb0hiV1R6eTE1T3lSRkViWEJxNlcxOXpIMEhF?=
 =?utf-8?B?bE01V2wyM3FONU1MOGlUR2NwVk0xTXR2U2ZYdy80N291TnRIWnhCOVdnL0xU?=
 =?utf-8?B?TWFuSU9vZnk5WmlKVmU4QmlWdVAzZVNXZjd1bWR4VDZ2eG1VanhnRWVwcGs5?=
 =?utf-8?B?NnpYWGN4QWRteGNHbk9zbFRFUzBNQWYxLzFROWltT1U4RlVMQXlRT0ZtNnMw?=
 =?utf-8?B?Rk9SMWc1TkNJZkM5cmxDdGdWYlUwZ3JtMXRHMVkyUURIclN0K0cySndhRHhV?=
 =?utf-8?B?bzZQdnVHRFJwS3haR1J4dWpqV0l0VEtUS3dWZ05Bb3JQV0tXSWVpNHVEWHBv?=
 =?utf-8?B?Wlg2SW5zV3hLRDE1VkdiVW85eWQ3ZS82cWJGMFNsdkl3Z01hNUd5OVduKzN3?=
 =?utf-8?B?UkxsMUZ4RW5yWFdsUTJ2Q0hXZHVVMVArMjhoTUtrTWtwUXl3SUwrN2xGWVo4?=
 =?utf-8?B?Q2cvdkU2a2VMSTZjb1gxOHFVZnBnTHZGZ3dKK2ZycnBHd1Jkc0VmTi9DTXo1?=
 =?utf-8?B?dmZkUjJ6S3JSSlVhaXYxTFV4bUVxUFFjUFhNdkJqOVpNcGtjemJuSUhPUmlI?=
 =?utf-8?B?SmZMc3pHUGNkQ3dxYzFQRkdrTVhGNldHa0NWaEU3N1loVUhaRmdmZlVKSVl3?=
 =?utf-8?B?UzNOazdHS2RoWVdoa1dSZ0ZhTnpWaVVFMGNvV01iVmh3QW5xck5udjJodzkw?=
 =?utf-8?B?ek5pcWJyaThraHFmcUx0V1RHY1lOaVNQSG9wWHorNDJtM1hMd3FaRjRkUkls?=
 =?utf-8?B?WWxXeXA4ODRXYlRiZVlRY0hJcEdVU0VCT1ZRZXltd0cyYVYwUXBqQjBDY0Rh?=
 =?utf-8?B?cThjT09nVncyTjFGdCtkTVUrWHVsNUFHOExsQU41bHdCd2RWR3ovZlVDR2pa?=
 =?utf-8?B?cEhxZzBUMWEzMk12K0Y1VmhhOGdRb3BaN2cyeDV3dTRzNkxGc0tnWUt4Zzlm?=
 =?utf-8?B?VXZOMlpKVjZGTFpPMzFpTjU5d1UrbG1SNUV2RExNUU5FYzk3RWRtd08waGtN?=
 =?utf-8?B?Vk9mZitCNnhRM3FDcGJMRnl3dDk4NlVFR3FKQlk0clRMeDdHY0ZUZXRSaEFY?=
 =?utf-8?B?cUMzQnFtT3locTNnRmtWazdvNkx0dW9oalRSN3pBd1ZTMUdmMlZua0RvWWE1?=
 =?utf-8?B?VmUzRDJTWU9tNjBxSW5yNlhlSGhVQWxGamw1elpCZEN6OHlxZE5xdWV4OGM4?=
 =?utf-8?B?UnltWU5LY0t2a0tmM1JzWkhoampqTk5BMVR5bExpTUNqVE5IblRnLzYwVDh2?=
 =?utf-8?B?eDgzM0ViRlhUQzM0SHpGZ0lVV0ppSmFpT1hNOHRUUERGWFQwWVlGVEc5d3Np?=
 =?utf-8?B?WWM5Z0R2dEFsVDg4UXp2TUc2UWw4bWpPRDVwTytJWkJPMFlGcjdGV3ZYV1Qz?=
 =?utf-8?B?bVFVWTVQTlI4UFZVYURGbHNERWdkamQvSXJLUTVtMEpuaEVXcFVQSWErNXRR?=
 =?utf-8?B?TWNtOGpQNUNNc0pTM25kSWJnVFFWZzg2ajRsZTByUDlXQ0duQVEwcDFPeVYx?=
 =?utf-8?B?WHQ0MmJVYVMxYzBDZENFR1BkTkthU2ZPaHBHMjU2VnhHWWNVSGtWcGhXWXRU?=
 =?utf-8?B?Q3hNa2lBTC93d2M1ODg2eXRoTjZYTGtHWjBJaVBZbEtzb0J4YlJ6Q242V3Vr?=
 =?utf-8?Q?IjH9bkh5IF3QR4zZGvFDI9qFN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f434e58c-ae14-4ec2-3233-08dc78d4d38c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 13:57:45.9340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rneZGh8mAk8oMPb0ceAcAflYfuLS4/bA/MLoPOzEnuek0iA4xHbKPPqYKrQaHWFaRcsUBcPR9Mz6lS6wQiQYXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8187

On 5/17/24 10:58, Borislav Petkov wrote:
> On Thu, May 02, 2024 at 10:29:02AM -0500, Tom Lendacky wrote:
>> PAGE_ALIGNED and IS_ALIGNED are from two separate header files (mm.h and
>> align.h) which seems like a lot of extra changes for just one check.
> 
> No, pls put them in a single shared/mm.h header. And no, those are not
> a lot of extra changes - those are changes which are moving the code in
> the right direction and we do them sooner rather than later, otherwise
> they'd pile up and we'll never be able to find time to do them - sev.c
> movement attempt case-in-point.

So this will be a new shared directory in the top level include 
directory (as PAGE_ALIGNED is defined in include/linux/mm.h), not just 
in the arch/x86/include directory like the others (io.h, msr.h and 
tdx.h). Is that what you want?

Thanks,
Tom

> 
>> Not sure I agree. I'd prefer to keep the comment here because it is
>> specific to this rmpadjust() call. See below.
> 
> Just don't replicate some versions of the same comment all over the
> place. Do one big comment which explains which RMPADJUST has to do with
> VMPL levels - perhaps over the insn - and then refer to it from the
> other places after adding the specific explanations for them.
> 
>> Right. Not sure about the "cannot", more like "must not." The specification
>> states that the guest should run at a VMPL other than 0. If an SVSM starts
>> the guest at VMPL0, then the SVSM would not be protected from guest.
> 
> Yeah, well, you do terminate the guest if it is running at VMPL 0 *in*
> the presence of a SVSM so it is a "must not". Ok.
> 


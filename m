Return-Path: <linux-kernel+bounces-215533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 134C090943A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 00:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0AB1C20F28
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 22:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9991862A2;
	Fri, 14 Jun 2024 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+92UvkA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F24E148833
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 22:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718405287; cv=fail; b=T/6cs7tQhE+LvbqQiwJ07w1LZFbYFh8Ms9Acl2ZAfCP4vfITNz8UgAvQQggL3xPqQa7qswcKjBX9gy+Wq/Vh2ohRB6LnGaWvTyN52fIj8g7A05WyV/LlqjFFUIEFUSE3H72gbYbuStsdAUYfcUk4paXUCnvd476GZ6z1pVB/5gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718405287; c=relaxed/simple;
	bh=1C9/Gq7kLoS8RVwXovl4FIwt++3dCdIIiVBUXBGavCE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ms3tjPmtUGqhSbQcFT/xAbCn7b87SQwjS/HApd7pB4vVBVqa9E9rVRaCQ9TQ/VE6VM7TLAD35rCDPYZRE3iQWGKMtaX+d+e6qlh7m2bH3inL5/hL9/86P4r1u9D8lPitjjb1q8THRQBSQ7Ju7nFjzg9Ajk3fSooM75/aQyEetzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+92UvkA; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718405285; x=1749941285;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1C9/Gq7kLoS8RVwXovl4FIwt++3dCdIIiVBUXBGavCE=;
  b=V+92UvkAF63rNe32aU33yzJQnsI8AzQX1E7yYw1y0xNcJphMptdNmQ3F
   KoSYLPLnEehn/EsSlM4Gn0P1ZT6nywhBGobFlIass1li3o7yRuvFx6L8C
   XkEVcnJmpzcGhSQeC0vXNzs3PZnkj6+s5eRxdjLYvPfNZncTbAlFp07ti
   QtGCv42XU/qX+oZ2W/wfhl5fPzeTZGftGGTcAiskYsPCSh1776mNDpw17
   brDdCKDmGaCQp1KfKtKIEE0Nr45OJsZiljnSNXk4ESRZUsPcfvWYmQ1Je
   YhBW7iDw8mXdZ3yMgxsn7YJ+Up6fHeuzxJvE2sqq6fQL+AI/HmU+5LMyz
   g==;
X-CSE-ConnectionGUID: vjtHNmmCRxeqWHrXqYQnSA==
X-CSE-MsgGUID: goNscQmwRcGnbWrLJF3dCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="12084699"
X-IronPort-AV: E=Sophos;i="6.08,239,1712646000"; 
   d="scan'208";a="12084699"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 15:48:04 -0700
X-CSE-ConnectionGUID: rEAaId6+QqeR4zmHoKT1kA==
X-CSE-MsgGUID: FgbBPM5IRRiVvh8ZzBtFoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,239,1712646000"; 
   d="scan'208";a="40568925"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jun 2024 15:48:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 15:48:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 14 Jun 2024 15:48:03 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 15:48:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhjHOwY6Hwue++7rkDNoEC/zFOOEWyehTCeUNgbj5fFClAiKUMM+dOqCixsvI+gHa2zKYQLHR4LzMk93VyQ9taOOpdb8tOhuR5RCJoIkbfk8zMaLyk1wtpSaHsAIduQnMJQlt6ckcO58A6Z/enuY1p001Ymb3sfGFjZeb76A65/Po0mhrS3I8OhbKLJsEADUbUFBwOjGRIaXrCdvzdtH2vAXcu+t+coOM7kkFoPgzN6agyRsD5jrSw6kw6SVgO5XOwsTsqFN+f5NXJXagY7Rx88I2UxIXiiJTd2LLX4o0cVqWrBxGrXbTdPV9MbBeMbMMkEb7Nd/RZxGDCf+NQHmGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kR64K8s09bmPiO5lyNqNsqMDu16mTU4bZxk9yN3W5bA=;
 b=cfO7dNnOsNDivmfNd9r10k9bRNQgIZvdajkmG4fC4LWkDO/3Gj2/5et3AI4tIGLC9siJyC0P9E0EY4d6YhJkrtpo2KN52nxlTPL7JoRcKJ5ejLI0uWxO8A+O75hGNP+B36oZ7YWdOQ8tkkg2ahQE4oDcIgEr0JhxE6GNMsqHqA3Ov9nDNneAiDEwQ3zmGx+NsiQgWZ83AsvLWrj0XC+18GdeasPS2Wuptw4LMWg6af9SEG3dXXpDKEdR04JQU7lKkpimjjN9QaXT3unsC3NGRzp8xqnZ2SkrnQPcvyTXhestyqKdwp1b7f/5h1/7GUJIzTqDf1BJ2FQ2ztuhYbAuUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL3PR11MB6339.namprd11.prod.outlook.com (2603:10b6:208:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Fri, 14 Jun
 2024 22:48:01 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 22:48:01 +0000
Message-ID: <1e3bba2e-5cf6-4a77-b92d-5c7ab1661d17@intel.com>
Date: Fri, 14 Jun 2024 15:47:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Don't try to free nonexistent RMIDs
To: Dave Martin <Dave.Martin@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: James Morse <james.morse@arm.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>, "Shaopeng Tan
 (Fujitsu)" <tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>,
	"Jamie Iles" <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	Peter Newman <peternewman@google.com>, <dfustini@baylibre.com>,
	<amitsinght@marvell.com>, David Hildenbrand <david@redhat.com>, Rex Nie
	<rex.nie@jaguarmicro.com>
References: <20240614160843.11006-1-Dave.Martin@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240614160843.11006-1-Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0070.namprd04.prod.outlook.com
 (2603:10b6:303:6b::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL3PR11MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f6cc7a-871a-456d-a5e7-08dc8cc40b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|7416011|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFdGalRlVnFqLy9QUDY1bFdHWGZpV2JScFpCd2xTSXpDcklvR0VpckhOd1VD?=
 =?utf-8?B?UGVXU2Ryc1N6NVJHUDBmbXQ1ek5MZGVJeFdtMk0vZnNqVUNkVUFEUStPM2pF?=
 =?utf-8?B?RkJYVWJMY1lyQU5XMDBWbUJDZGROc2l1NkRiYWRBTjIzY3NZVUhWUXJCQzl4?=
 =?utf-8?B?MEQ3OW9OL3FQbVF3RVBLMi85NTUxdzJYNGtBT3NNRDhZYkZ6alBibTloM05T?=
 =?utf-8?B?K0hKU2dUVmoyMzJzeVVzQzVQbHlzdElZMzZsTXYyU1VpUHRQeVVwWERES1Vq?=
 =?utf-8?B?SENWaS9ya3VBWjhSSjhvd2t5Q21NamdYRUtmZzhtdWFNWVFFeE5xclMzNEw1?=
 =?utf-8?B?UUEwckFEWktnYTE0LzFxdFNaZXAvMEs5cGxXZXFhUTVRakJGcnVuTFd2ZklT?=
 =?utf-8?B?RHE5Q3ZmandhMTJGV3BaeUdKZWk5L3ZwYkR1dDEvZkF0R1FwK1llTThjL1Zo?=
 =?utf-8?B?OVB4aHUzZUpuaUxJNDhkSis2ekdwTUlEOVNUdGxnRXVmUzJlV0NoRktmRXdP?=
 =?utf-8?B?Yzllc0N0b3R6Q3dMaHFoUDBMWnhYVEFYaWtJTGhxZ29hUGZZMTh3ZXdmdW1w?=
 =?utf-8?B?N1puZ3V4WWVYY1Axd3FRTXhxaU1CbHJaUTdHNHVBN0VvMmh4R0RIbFd1MmQ5?=
 =?utf-8?B?RW55eUt4bkpReGkrUisySXlSQkcyNHd4UjAyUFNSdkRnaHdPTEtFajNtSTVw?=
 =?utf-8?B?Nm8zY2JsTTZiQm56bGZ2Qi9VNFB2bThHaFhMMG5oYjlweW5ON0hCTDVTQWtl?=
 =?utf-8?B?eXNjZ3RRWDkwSEt0WnBnRGw5emNPK3NkWVlmMHJIbFUrcEhObytDT3h1Z0wz?=
 =?utf-8?B?YzlQN0hEL1p5QjRUUzJvUm1JckJHUjJLczhYZm9WaHRCN0hSaHB4K2NOSFRY?=
 =?utf-8?B?cGkxS3N1MFhRUDU2c1JDSTRQOFdGSlptNGFQMUtzKzZrUjVXTFQ3V1FLODdN?=
 =?utf-8?B?QkU0elhuVlhKQ003d3dxWTVoVEpiODFlQXJLckNHUjJxUENMZGJEaitjZnM2?=
 =?utf-8?B?ZTIzNDhuaThVWUZ0RGlVNTV4VEg1R0dzLzIvaGE0a1U0TTlIUHBnaXpFVnJu?=
 =?utf-8?B?Tm5hL3hDRHpmeEZwWGF0SU1mNlJRQnN6NzV5aUlTWnFqZ2hCTXFqeVE5UlAw?=
 =?utf-8?B?cnRnQm9CRm56V1lYSWE2TGMwV1U3K012elg5ZE5hOEJVemxZVkJHa21MbUdw?=
 =?utf-8?B?SDN1SDlvQ2EwZ01iNzcrMVU4emZDa1cwV1hUQUtLUXFDRTBHMlBCZjgrbU1w?=
 =?utf-8?B?SFNhZm1haE5yN2l5a2hLMkI5VjYrY0JBOVpJVjFJZ25vQURKVUFuMzFsL0U1?=
 =?utf-8?B?eUkxTHE3a09MSUpCNUYvY1F6TzNZUFlOeW54MTc0djA4ZVM0V2pSVER3ejRZ?=
 =?utf-8?B?dGRKbFZoUUk2eldhTGRLUU1UUzRKYnZ0S2NrcXMrK0NNYmwxQ2R1MFA2bi9t?=
 =?utf-8?B?ZlhGdEhoT2c4T0FmRm1MYS9ZbHF2czZxNFR2dEZzbktQaklSV25LL1U5UTJP?=
 =?utf-8?B?WUF1d1RrRk5ncUE2eERweGhRTWlNeU9zL0h3SUNUWFJjSEhieHBNMUNBUzAx?=
 =?utf-8?B?aFUxdGxiZisvbTNVeHhuN2Z5K1pJbG9nUmhOY1VBR2FvOXlUOURlMkZXZHp2?=
 =?utf-8?B?dnFOazVUQ0JGeVJqM0JQSklMMFIyWjhINnoxS3VqaHorQVprUU0waVFmeWVk?=
 =?utf-8?B?ME4vK3FQUlBsSWVmRjNZdllEcHJNemdlbjRKZS9oTE05bkZubjdnYlVuT3M1?=
 =?utf-8?Q?vBPDQLz7YNYq6J4TkI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REsyckwrM250WDFhV3ZPQml3MzBXcXMzNkJ3bWFjRkVMSmp1U2pSc09YT2Iy?=
 =?utf-8?B?OU9Rd0tQR1h2a0duOXRVeXI1a0UrbjdqcGUvRW9vemtpUnJtZ2RGSFJIblEx?=
 =?utf-8?B?VnI1cEpGYTRJY2k3OHdJYzJVbVRGcnhvRStHZWgwWDM4VEpXaVhPaDhha0FO?=
 =?utf-8?B?aS9zWFcxYzRpejMxN1hYZis0MDlVdHBJOEJvMHQ3T2FqZ3NYYTV4UEdlZ2kr?=
 =?utf-8?B?RlpwbmFaenVDYTg3UDdUQUZ3ZmZXSTUvWWg5ekRDTEJhRzB4Z0h0RXlJakxO?=
 =?utf-8?B?L2JVbHhaY0t2d3hTdmF4K3J3Q01NaXQxbmJoZ2c0YUwxZlBidkJGRWZZTmEr?=
 =?utf-8?B?L0p5VnpUNzJyWHBNVk9wbW5rSTQzYUVZMkNIbGpqUDdzTStud2hpaUVhT08r?=
 =?utf-8?B?eENCQ3hOaHo3eTFCb3FWd3R6dDhMVzJrOS9iU2I0c2xFNE1MRmVHQWF3UlVn?=
 =?utf-8?B?clRDSzVoUTdicnNqZGlxNWNOMlJ6YWFqUWZIVC93bXNyQldrSkNnZmlHbVpI?=
 =?utf-8?B?MDVrQnQyOStkNW5hVmlrK1R2R0FmaGg1UHBESHo4TzFkVkkySWkzREFLQ0lY?=
 =?utf-8?B?ZEpIbnpjRTJ2RDhBUEZZcjZnZWUyZ3FDMjQrTmhRVGJMeERrWG1VWEovd3pX?=
 =?utf-8?B?VGdKdkFkZ0tUNjZPVHYvWlFkUmtjRDJGdlg2SmNnbFc4M0tSaTd3VnVESDlh?=
 =?utf-8?B?aGM0VVpSKzBSVTFBM0xKVHh0OHVhWnNOWUVzZXVNTlpiNGtDZkpDcUJCZ3lK?=
 =?utf-8?B?N25qSWw0Wm9vOTVRaGh6RlhtUW5xUmJrVHZJSDd5RGw2RnZtZ2djR0pCWkpD?=
 =?utf-8?B?dThPdmtSVERoRHZiQXRKR2ZEWVNheEVKVXJzby9CTm9xVHZVT0xZNWFpRVVE?=
 =?utf-8?B?eGNPRkY2ZDNxcStBQVNDVXB4V2tocS9uVVpHY0RjNnd3Z01rZXVHazdreEk2?=
 =?utf-8?B?bWVHSHkzbHRIRVc0VzlpZktrUUg2ODZ5MDAyQ2dKZTI5Vm5aWVJUaG1ickMz?=
 =?utf-8?B?cTU3ZUgyT3FIK3hCNzJxWHdnQ1IwK0pkcDVLU3JPUGk2YU9mdUZDS21Xekps?=
 =?utf-8?B?RHNiVWdUK1llY0xwZWp1bk44QWN3cGErR3U2eVgybnR3a1lVYlk2ZXRKb0tv?=
 =?utf-8?B?U1dQM3o0eFlkaXBacTE1UUlGanRZZnYxMEhqaUtOT0w1YjJGeEhaY1IrTVhs?=
 =?utf-8?B?cUVmZktBd1NrWDNBb0huZ3MvZU1qUHg3L1ByMkQ1NVR1T0ozbnJKQUNRTTVn?=
 =?utf-8?B?dHF1V283YThmempsMk41QThKdGN0QmNJU1I4YTVDcCtXM2djVXhqZ3E1aFI5?=
 =?utf-8?B?djlpM1QxTlY5NWV4L0RUWHN5YjJCdEs2T0hGemxsMVBXdm1rSmZSQ044blQy?=
 =?utf-8?B?WW1aSWV3N0czUldRam5CbDJTYXMyUUthSXdlMEVRK05neEUrcTVMblBGSndz?=
 =?utf-8?B?VEN5K0J2VHFSVlVxc1ZYSFQ5bmJGWVlZTisrblFlM2FJWnR0QzJDVlJpYTRU?=
 =?utf-8?B?elNxWVRqb2dOSTN1MFNkOHFaTkxJdVRUZnBPWWtsdmNkU0dGM1JqemkvL0Nt?=
 =?utf-8?B?bksyNlMwQXRjeUlZTmFINERsZGc2aDdJQlV4VEd1UGVYWjR4NSsrWGMxWVJ2?=
 =?utf-8?B?K0lLdHFPVHhhcGo0TjZ4Sm5MYmpmV08vQnhUK1UzZGJ0M2NhRkE0am44U0J3?=
 =?utf-8?B?ZS9EM042NFpkUmJBUzBaalk1eTkvdTZSNmIzcnlvNDRucHNlT0VzZU9lcHFW?=
 =?utf-8?B?alhqMUEvRHQwZERRWmlVYWdaRjNYUTJqdkZkNUw0aVRvSWEwUGNVTDU0c2lx?=
 =?utf-8?B?RXU5eDd3Q1pTdkJjTk9GS3piUk91d0w4d1FKWlo4d1Z2RjJuT1hsWGJ2NjNp?=
 =?utf-8?B?RU10UytMZGY1QXpEL0NLdGQreU83MTNaeG9nVnZqVEVEYTdZbGRsQlJKbkM4?=
 =?utf-8?B?MjBQbXlJaVhBMjJvQUE4Z1dFSVZjWWZETmJIMzNacHVaZVZsTzhnUGRIWWdU?=
 =?utf-8?B?amlGUmRLVTdGM2pyaU5OdWpkS2kzVzE3cUFGeG04OGUwWVY1NW84SnNKZHI3?=
 =?utf-8?B?WUZNTWxYeHNtMDBDVGVSRVRyMU53K2t4MXphWWRNemN6YVU4MzZMMkxRUWN5?=
 =?utf-8?B?ajJTaUtsbUVlMVdCOFRpM1hHTUpnSHBFbGxtTTZRMFdQdHZjQUNIMFJ3bUpm?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f6cc7a-871a-456d-a5e7-08dc8cc40b3c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 22:48:01.0886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtbQu4UxcOAL28JFDuYUE5Pb5lWDS7dmm69pMAsGYeQ7L0FxQ5/xcxYwCP/TnGZUUqUBbFBBWvqxzk9GYYmy8G8XdlP+Z46eglR5eXKgG+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6339
X-OriginatorOrg: intel.com

Hi Dave,

On 6/14/24 9:08 AM, Dave Martin wrote:
> Commit 6791e0ea3071 ("x86/resctrl: Access per-rmid structures by
> index") adds logic to map individual monitoring groups into a
> global index space used for tracking allocated RMIDs.
> 
> That patch keept the logic to ignore requests to free the default

keept -> kept

nitpick: I actually do not know if "that patch" gets same hate as
"this patch" so to avoid any potential feedback about this I'd like
to suggest that this is rewritten without this term. Perhaps
something like: "Requests to free the default RMID in free_rmid()
are ignored, and this works fine on x86."

> RMID in free_rmid(), and this works fine on x86.
> 
> With arm64 MPAM, there is a latent bug here: on platforms with no
> monitors exposed through resctrl, each control group still gets a
> different monitoring group ID as seen by the hardware, since the
> CLOSID always forms part of the monitoring group ID.  This means
> that when removing a control group, the code may try to free this
> group's default monitoring group RMID for real.  If there are no
> monitors however, the RMID tracking table rmid_ptrs[] would be a
> waste of memory and is never allocated, leading to a splat when a
> free_rmid() tries to dereference the table.
> 
> One option would be to treat RMID 0 as special for every CLOSID,
> but this would be ugly since we still want to do bookkeeping for
> these monitoring group IDs when there are monitors present in the
> hardware.
> 
> Instead, add a gating check of resctrl_arch_mon_capable() in
> free_rmid(), and just do nothing if the hardware doesn't have
> monitors.
> 
> This fix mirrors the gating checks already present in
> mkdir_rdt_prepare_rmid_alloc() and elsewhere.
> 
> No functional change on x86.
> 
> Fixes: 6791e0ea3071 ("x86/resctrl: Access per-rmid structures by index")
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> ---
> 
> Based on v6.10-rc3.
> 
> Tested on x86 (But so far for the monitors-present case.

Tested by booting with "rdt=!cmt,!mbmtotal,!mbmlocal".

> Testing on Atom would be appreciated.)
> 
> Tested on arm64 for the no-monitors case.
> ---
>   arch/x86/kernel/cpu/resctrl/monitor.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 2345e6836593..366f496ca3ce 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -519,7 +519,8 @@ void free_rmid(u32 closid, u32 rmid)
>   	 * allows architectures that ignore the closid parameter to avoid an
>   	 * unnecessary check.
>   	 */
> -	if (idx == resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
> +	if (!resctrl_arch_mon_capable() ||
> +	    idx == resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
>   						RESCTRL_RESERVED_RMID))
>   		return;
>   
> 

Thank you for catching this. This reveals how subtle resctrl is by
calling free_rmid() in paths for convenience and then relying on an
uninitialized variable for correct behavior.

This replaces this subtle assumption with an actual check.

With changelog comments addressed:
| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette




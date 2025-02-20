Return-Path: <linux-kernel+bounces-523025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2407A3D114
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228C63B8E87
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F8D1E3780;
	Thu, 20 Feb 2025 06:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJ4Zlix7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6EB179BC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 06:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740031237; cv=fail; b=nzzAJKjBFUPJr8bzYoTQk82xYJycJH87li9A3gKee/oYo2bZEr5VLaNFty22L/FP3c63B3SM87AShX/h4jplvHwvwRYMZsacuTWn2BPPb43gBY+JhQMTo155neOGNTlZKUjI+08vZFG9K8TppajZ1qxgeBq2F4LdAdZYaJ8UfM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740031237; c=relaxed/simple;
	bh=/vSsaMsUu5erDbxBNu9oxmkpgsOs0rQzN7XvnkrtFqQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RsuXgQvnKzm3KfVfKtXCwVkKktNLJopLpZ5IqsExI7Y0tVWZDIay2rhnVH+LlhcP9cO4lEgfZg+VcWEycj8fxfVb/JSIBmAap6R1NfevnjQk1AkuLT6CisdTviCwNEi/5+kHmii3HB8xXk7oOPN0Xibcytng5BUfioy8fS3X25Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJ4Zlix7; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740031236; x=1771567236;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/vSsaMsUu5erDbxBNu9oxmkpgsOs0rQzN7XvnkrtFqQ=;
  b=SJ4Zlix7jBZYI/uB0WHtqkBkL7RyT1tu2o6AaCqc8l4tMmvJ92oY6gXq
   34wfRw0IJc+p3sX7uRtjVk75qA32fAdJiTGlDG4yu0AaiMFr2BiCgniiq
   jXmRWoklTA3x+4yARoqzSKzJzwE+6xLU3LuBJ68EAmx/XQfhaXzjlDd2N
   kiGf1695OxBVU7aWVPX9rypSdBZNl/fRRJvi8IkGxvP5P7Pr/8Y1rRZ0h
   x6BiJSJkTATlxIwSXpwKEI0znlTO/M1oGNWLIrpfMvj5mHM+YbEnCNYyz
   Dy/llYnLI/1eYYpBskbrYk1m7HJUAreUQeEF+he1qJzl3FnEDP1RmNPhL
   A==;
X-CSE-ConnectionGUID: 7mXvKGWeQOmJnN/H45seVw==
X-CSE-MsgGUID: zcmI3r/YSjy9tX55ewGhtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51414525"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="51414525"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 22:00:34 -0800
X-CSE-ConnectionGUID: 5y5j9uE+R82HSOF7bUG24A==
X-CSE-MsgGUID: 87Os8FudR+S5Geaz9LNOQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115845402"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 22:00:33 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 22:00:33 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 22:00:33 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 22:00:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Us7SQdM8IQ0nlkxuhbMu1lCh7+OXhIcv/U1bZQSiK56fOrZWx2L/jtUh0Q1E/MeLAdsXSZcuX2GmF+6bJDCAn95cxtgNR8lJ3iu9j19l4Z7atUjCAgZFjq7GmqoHvdoye+9YvVBU686g6bhmlyFKYjzMq7rbVgJOzUqc1wLgBNWprJ5n8atjVtIKSZm0uf4PPHsdYlwJkBWbW+OJQvmuC3Hp3WjmpcBZTCYBHPetCkVYrQjEUWwQzUBR0Ve3FELa0XVAJTZcGd8X/kDDa7YfHAdRhG4vSIWdVzR/orZzT6wOFq8TNwy+52grEWvmdRcpSoN14gy5bR9dyLVVnDyAoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/xvIfXeIQN9yIso0bNmJ2GNhuS0sJDGXxpEro7v4+A=;
 b=oA4RaQJLJdxc1IobRWe6Ydt+q5OiLiri2Ss1OFrS9rY55zj7537dU8K/MBnmeO48RvsPO2ZCEVe9u0boom3oWCIshBZQmfejVT8nG/URY0ivQIduMS0QHYfduXMvfv0xxA5opuy2Hgr8TeJvLHpMxLvfeyrzP8ubpjD20QE8G/Up+RXs0rmGeNoFEjqM2r9dh91eTye9wx+QOIQVN7aTrzeznSUcMh+G6QYw2PRpBl05nXpKjbwZWBK1rnteE1y8X2AZ2xS061aLSflCfnNJxkeC2WfziYwy/woDKkC4EIWIawih/9Byb/0UFXXwbQaMkhQ4/WzpVUrQaXILhNKLug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA0PR11MB4573.namprd11.prod.outlook.com (2603:10b6:806:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 06:00:29 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 06:00:29 +0000
Message-ID: <44fc5a31-43d8-413d-b938-638294a1e096@intel.com>
Date: Wed, 19 Feb 2025 22:00:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 41/42] x86/resctrl: Move the filesystem bits to headers
 visible to fs/resctrl
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, "Tony Luck" <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-42-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-42-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:303:6a::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA0PR11MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: 27f2e686-a9ea-471b-a2fc-08dd5173e104
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OS85azZHbmd5QjJreWVUZHJYL05FamQzYzJnMGd2RUxPc1hOZGRueGR1ZDVm?=
 =?utf-8?B?S0huamZSUVlzdzhRdVErUG95WnJDZWRjc3dwaklCUVF4YjI5V2IrR0c2MlpD?=
 =?utf-8?B?SVMvYm44L3hWMzU4cmtoWWdUMEV0L1NNVkhPMEVZdEYwOW5LTVVPamhESTBN?=
 =?utf-8?B?L295dUU4d3RISTJKTTNXbi9WMXRscjQ5L2JEbWdFalA1Y3N5Z0N3d1pxUFMr?=
 =?utf-8?B?elgrNmFzNkdTU3lsY3daeDBJTjhXZk1mUEJlZUl0WnUrZTJKaDBkZE9kYzQx?=
 =?utf-8?B?OTZaY21KbVJiQi9IamdIZWMyY0cyYXA3NTQ0bE1YTU9xOWQ3TmF1OWpBT1Y5?=
 =?utf-8?B?dGpnanRFUXB6SW8zaVptd1lVNHB2NjNQNnFqMVNRMjI5VlZWNDdhM00vamJK?=
 =?utf-8?B?aXZBRnNmYWRlakFpTmE2dFJPeUtZQ0ZZekNNY29EdUp1RzlORjN4T25qdmNp?=
 =?utf-8?B?VVF5cWhYQ0NPSmx1TkltdE1sbkxhaEkvWEZ4SlA2bXJmNVltbGZuOWFnZkoz?=
 =?utf-8?B?UlBjZW9LczBjbDl1eld2b3FxMnI2M0VxRFJjMzBxV0V4TEdmK1NsYzhHcWVK?=
 =?utf-8?B?ZjVRTm0rdlJqRFV4Tis3Mnlsb3RUUitPMS9ZcXF4Ym1TWnBtcUhqUWY4VXBN?=
 =?utf-8?B?cHJlRHBleUNlVW52TkgwcWk5QjNjbnVIQzZSK1VLRFZ6SHgwOGoxWHMzQURM?=
 =?utf-8?B?NHNRempJNFdSRUtxZTlCaW8wTFVXTE9CYU05ZWlOWTFjYnZ0Vm9GbE5sZ0xo?=
 =?utf-8?B?bzFITGIrZm1uUUhvdFpwVEdNS29Yd1NYQVJuTUpZbCs5Z2tFcU1BL2N6WmxC?=
 =?utf-8?B?RDlhL2ROTFgwSWVRblhzcFF5STJuSzVXRXdsaExuSFNQQXRWQ29zMHF4eFBi?=
 =?utf-8?B?dDZkbU02T1luQXpuQ05weWF1OWF5dnBsZng3STQ2NE05N1gwb2xPMHhUYitN?=
 =?utf-8?B?RTdLQXp1c01QdW1QbXk2eXBjZUFSYnoyNkRMNkdkdUxmZHZoSzRBRUF0RFVo?=
 =?utf-8?B?ZXZpSEVmQkNwb25nbmpwWEhQTjFwaXlBMloybm9tWENHV25zeHp1RWNqeHVF?=
 =?utf-8?B?cUFYNW5wMExCSVBYajdrWUxxdkdtSTBiclc5emR3a1hDWUVzbFVweE9nN0da?=
 =?utf-8?B?L3dCNFhGZSt5dy9yWjFQcnVzTWxuY0N4ZWphOXI0cGpnTHNiaHZwdk5ZTW0z?=
 =?utf-8?B?dk5MUjlzM01CbFk3Y3drMXk4djUzZ3B3SUxkWWFrZmtmNzBEMElLQnpOcVdZ?=
 =?utf-8?B?bHFoeC9ldlZ3OW5LN2hrb2UxUUNlTVIyWUY5OXpEZ2huQTk1eG9LQ29DTHd3?=
 =?utf-8?B?d2d1MXI4NGlDeDJkK0JzN0tIUmFNRndKaUVCRUNrS1R6NG5pUkZncklwWXk0?=
 =?utf-8?B?QVloUUNxSmZieDZraGJndXc3WEZybXlPZ0tnbHdoWEZUV1piMUtVOEw3UjRr?=
 =?utf-8?B?TnVIb1VMdzkvV0JKYXJ5REJabS9qVHQ0VXFKS0FHY0RObktHa2p6bDQ0TlM5?=
 =?utf-8?B?MDFYekZRS2RubTdHakRFcFlwTmppQTdqOXhkN3RtVjB6RjZhU1RrUWx4Z0g5?=
 =?utf-8?B?RzZpN0pkaWtMdlF1Rjh6OS9rOWN3TUQ1OUtMVWc0SXF6c2tCWXA3YkIzcnZ3?=
 =?utf-8?B?eGJpRTRha1BlcUlmYUpBNllQTldGczhoVGk1Z2oyTEgvTG1RSUcrOWYwd3Ji?=
 =?utf-8?B?SGtRNDFjaWF6SndrU1BpNnNmOHN1b3paTnRvQjRIRkJjNkZ6ZVlwaHZ3RkZk?=
 =?utf-8?B?emR2ZGJmZittbFVlQnF0UmszNXQvbHpabTNFcFloekwyS2lDc0QxNWp3Y01M?=
 =?utf-8?B?S25ocGcvVTZBVjQxNHN5dHE5Unc3cDZ1dHNrU2Q0TldtZGxhU21weHcxZkVs?=
 =?utf-8?Q?TE5NcH4xSTXCP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWdodmVYL0hlMnZvcDFwS3crSFo5VHRMQzFSYU53YWo3TzIvbkd3cC9vc2k2?=
 =?utf-8?B?aWx6cVliUE9SK0QyM0w3QU5SMERjUCtZY3puMzYxZmFqeFhDRlkzSEs1SFg5?=
 =?utf-8?B?WXZWVlU5cENtcnFYMGY1Wlc1T2Z1eXFqcDJBdlpUeXlNRHFtUVpTM3RUeUlB?=
 =?utf-8?B?ZnFzclF5WlY5dTcyS1RvZ29vRmlnTEJ0a09hb2U5NGk2U0dZWlUzcndhcHpJ?=
 =?utf-8?B?M1RNMGJneVAxYkVVMkJ1dE9vVW5SeWFybXg3enhqOXpUNDBuM2d0VVE4UVpl?=
 =?utf-8?B?bEN5RmN2NXBDVnZxSkQ4MTJmaWQ2YWw0TVFFMDBROEtiN3l6dW4zVW9LdUY2?=
 =?utf-8?B?c0cva0VtYjFITCtuRVNCM0pSSVc2WlVhVTFHb2NXMVJpRStqSlRGV092OHBN?=
 =?utf-8?B?Y1p4Y0dLYzR5c1lUUE8zWXI3Ym0wcTk4OHVZeWFmeHh5U1ZtbVY2cHVmZG1i?=
 =?utf-8?B?aFlKNVQrdk9NenRUYWhOR3JMVDNhTUFldTUzMktXREpRazdsN2lVTHdpNEJP?=
 =?utf-8?B?NnRkT2F1WmdGa3Q5QmU4TjcwTWh1RG1BL3ZCUjNMN2FQRXUzb1JucHVTbEVF?=
 =?utf-8?B?NndJOC9EVnpNUFQ1TUlTUmlPZm9KN3Z5WUJpdnowR2MvVDUyTDJqU1lQbDFl?=
 =?utf-8?B?Z0txVWFzb3hNMDQ0SkkzMmV0bkNYc01wWHByaUhCbHBkbFhjY05BTGxpd3pJ?=
 =?utf-8?B?TDJteEVnQWwxcjZQTUtzNWdkODV2OVFQaiszcXg1bHR5d2dwcmRCN3NJM28w?=
 =?utf-8?B?WkVrL3VCMlAzQVFCTVc0elcvdUU5cWJZMVlYcFZua0kvazBWbGQ1eVRlNXR0?=
 =?utf-8?B?YWxpeStlN0dRWk9mOU02ZDYrS2VkN29tM1d6YVptV1FsVGlkRXpEOVlLc3JD?=
 =?utf-8?B?MjMrOHBaM1JRRHVacFpUQ3VYVW9pblhjNzMzcFRscUw2UVF2WGZySnVhVTZr?=
 =?utf-8?B?VkVFc1NVMzcyVGNUTEd6TzRPK2N2UUtMYmJyekdid0kwMGFWd09Qa3p3ZjZQ?=
 =?utf-8?B?eGxXOXFJc09lRDhhZ2c0T0k5TjBrcHNWYURwSE5xNm5KT3Q0dWNpTXExVEdq?=
 =?utf-8?B?WnVNajZHSmpLcWROeU56N2tybFlyL2ZtbGYwMDFqL3ZJYkYwTDgyeVNHNUgz?=
 =?utf-8?B?MGFGM3ErY1NMaFBrWnZMc3ZKV0hTbUxRQktqRHZHdGNIMGlBR2pRZEV0NGNv?=
 =?utf-8?B?MExJbUFoRFhGVllnZlJkZ0s3djVJQVdmOHZxZ3huajdUSERvZ1FSZXlBeVBw?=
 =?utf-8?B?a3JwbXRsV1ZaWkdnVUMrS0NObzYyMnN5NlNiUzlPYkNKaE1DdHk5SzZ5MHJs?=
 =?utf-8?B?ZStsd3lnVjdCc2l5Y29hSFBLWmhqS2NQOVB6R1BqRmQ0b0FLN28vSWQ5aGJZ?=
 =?utf-8?B?L2tOSUdwSktCVjFvTnNkc01mbnV2cG1qWkxIOTRyUVJLSVVrS2dEVVJKSGpt?=
 =?utf-8?B?RVZsMnpjazRXMXhQY1A3QmgwZlkvbklCQzY0L0FIMFRzSDMvVlVxeW91ZXlo?=
 =?utf-8?B?aDBTUVFtcGZGNis0R0JaK0RocWhTK3UvZk1KSHdYdUl3VGtEdEVzVGZqWjZ3?=
 =?utf-8?B?aDFWZVZRN053dmdEbjkyaVhUUmtFc1pKQ2tLQTF2eEgxYi9NdXVMOXQxNThY?=
 =?utf-8?B?WWh3QnB6a3BGK3Y2SDhRM0YrVmNQNVVCeTRRR3JiZjlWYkZ4TTFaek92VExi?=
 =?utf-8?B?WDk5c0FkU3A4ZTNVcml1cjhwK3BHTWdMUUtyY29PSmpxSE5oZWJqTlZiOXdq?=
 =?utf-8?B?cWo4bUNOc1pvQ05xWFljbEhybVFMM2VVSnpVNGNZLy9UOEhrSkRUeFpQd2JG?=
 =?utf-8?B?WVNIMUhCK3ZINUlvOXhUcklhQzN0TkJBNlZvaXhQaWlzUXpOYm5YNEEyRWYx?=
 =?utf-8?B?aEFIRGdJeHlCVXlxbnZja0N2MTNSSUh6a1ZIc2tFMkpxUlplbStqRURlYmRX?=
 =?utf-8?B?TnJ6U1RoLzRTU3VWSldvbE8yUU40RmJqMk44ZHlMTUIreFRLZENYSStBcEww?=
 =?utf-8?B?VG1UbE4zUG5mQ0tlbjVTSWdKdUtjbjBKUjFKOVdkNzZydEtJYytWSU9PcUh4?=
 =?utf-8?B?Q2ZaUS9HV0JyakhpdnMyeGU0aUQ5bU1DNFNpZlhSYSt4ajMwdmRpOTZwcXNG?=
 =?utf-8?B?a2s5SWFtdnM5Qk1SeVhmSFVaZS82dDVZZkdqUjVSb1pUZW5iTEhGd1pNdDAr?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f2e686-a9ea-471b-a2fc-08dd5173e104
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 06:00:29.6695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5FwGEkF4xo65/kRbBTSTihxCTMWcQ7zXERd34dKaSuOUGfsoDHch++lFGr2S2u3t2I5lZbxlLggjOKIDQi2oBBJBJ+eb/pRoOomvgUvX/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4573
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> Once the filesystem parts of resctrl move to fs/resctrl, it cannot rely
> on definitions in x86's internal.h.
> 
> Move definitions in internal.h that need to be shared between the
> filesystem and architecture code to header files that fs/resctrl can
> include.
> 
> Doing this separately means the filesystem code only moves between files
> of the same name, instead of having these changes mixed in too.
> 
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

..

> ---
>  arch/x86/include/asm/resctrl.h         | 3 +++
>  arch/x86/kernel/cpu/resctrl/core.c     | 5 +++++
>  arch/x86/kernel/cpu/resctrl/internal.h | 9 ---------
>  include/linux/resctrl_types.h          | 3 +++
>  4 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index 7a39728b0743..6eb7d5c94c7a 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -210,6 +210,9 @@ int resctrl_arch_measure_l2_residency(void *_plr);
>  int resctrl_arch_measure_l3_residency(void *_plr);
>  void resctrl_cpu_detect(struct cpuinfo_x86 *c);
>  
> +bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l);
> +int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
> +
>  #else
>  
>  static inline void resctrl_arch_sched_in(struct task_struct *tsk) {}
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 6303c0ee0ae2..f2cd7ba39fcc 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -288,6 +288,11 @@ static void rdt_get_cdp_l2_config(void)
>  	rdt_get_cdp_config(RDT_RESOURCE_L2);
>  }
>  
> +bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
> +{
> +	return rdt_resources_all[l].cdp_enabled;
> +}
> +

This moves resctrl_arch_get_cdp_enabled() to arch/x86/kernel/cpu/resctrl/core.c
while resctrl_arch_set_cdp_enabled() is already in arch/x86/kernel/cpu/resctrl/rdtgroup.c.
Most of resctrl_arch_get_cdp_enabled()'s callers are 
in arch/x86/kernel/cpu/resctrl/rdtgroup.c so it seems appropriate to keep it with
its partner resctrl_arch_set_cdp_enabled()?

Reinette



Return-Path: <linux-kernel+bounces-285843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5471B95135B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D581F23458
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDDC4C62B;
	Wed, 14 Aug 2024 04:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikdvBUlG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D65466B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723608141; cv=fail; b=HnTYBMZAynrzSCYTqg8V7RECrUwj8wyxI51+UXCpmFaRbJNBoQuTu5lZWcinOhcFS7Z4mk0vVLAW8JT37JcDcz/9QXsl6/0nIn36wzPygqrm0XzCNtlKly+PdPO2Kux0O7aVjZrVF5nH2ryvcoBTSMdLWBc9q49W3/hjQoWUlzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723608141; c=relaxed/simple;
	bh=edrHRUxhDhZpJSJLgrk/aqdiqfj41KbRUQg25gSIqyU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JJzLeu/2KFb/zlat6DPFrIMmbDM03zy4bo85AvtysbWVhloYyXsVWlyQ3mceu232vGlpE0H/8Y4ryMQuosQX7tchadp6Ol65QgWSF7vKkCfcQlF2nwXBLCiMQ++iey9I4LIjXhYgSY6z8DkJGaOsPKZnHj+WSjkGRONk/X+8NMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ikdvBUlG; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723608140; x=1755144140;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=edrHRUxhDhZpJSJLgrk/aqdiqfj41KbRUQg25gSIqyU=;
  b=ikdvBUlGDJ/AyJaM82aJ8oqribY5dYW7pwCgrRjHDfyjyPV/zs2bR1fm
   nXETsqMu6JMk5BMx5LvDBuhcVRlqcmIcjs+U6+4Kzd8gHkzVWQRJv8KHq
   jCaltp2eWXhIAiesZJ9qBcFwCYAse7SDi16T/DOzQ6uuyYQZ3lzObzccN
   n73HJF/Y5mDbJ6FxRT9C3H2Td4aTFGOVBjX2uWwt/QHhbR0LWyX9vMPKC
   WcC54XWjcXK2NlmyM3utqexkK3Fco7NpLPOhyTvLQ7eACM/zqTFEq1gBZ
   PPjF1Il4WqaGmd8RG40PvLoQHY7CjN4Eok/Ur26d6yqpa2IoKLz8gCisv
   w==;
X-CSE-ConnectionGUID: tFURXRRbTgWqxxbEXzVMfQ==
X-CSE-MsgGUID: HZASAzBJT/ihgurDid9BBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="32427167"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="32427167"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 21:02:19 -0700
X-CSE-ConnectionGUID: iK2PzULmRa65SngtvWkYgA==
X-CSE-MsgGUID: sofSZNX9QPSAyr9LTYhaIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="63541178"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 21:02:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 21:02:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 21:02:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 21:02:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNxg2sW0UXIHAV0HJ1/ICgdSLHRZWk6+qmg6pGKf0xkHzaNbL+CcIMPAchHpIL5ZdLG+dgJpshODfvf+oabbvwl92dT+RjvNhGxjbQ11DgX5FgxrtJhD2BmjYsYYCDAGyuG/++ytalSA23WuKQsA7KDpGIJDkoa3jlkT6HHTVhhdunrvTEZ2l8omLesL4QYbw9q242pVbvo60CKfww306KYyN5sLaPq5GjAl2IGbJNrBhqO42YuUHcBoPXsoYizUJcTJERmfXK+5gdIjBr5p9nHmLzp9jCnu/hgFZMpymp20KYGKsdc2U/7XDdtTzDSujneru6mo1Gz18zTcP4HVgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QWNw7N1kej/Y/3QiGUu0+LERxyj5P+9ncxIbVPNosE=;
 b=gWejLwtZHJDH8cMzLeWCst9ZP3ZWQldwKSmHhgaPnPqLuSG7D8JZJwUg/U6pVYRVhTPuW/MsXkWpprSxOSjkuTsQK80qmKCntJXI5a7gundGoD1nSNhqaPLbrxejpshnXf7BCgik6fl9n81JLGilFFD9tpSY+EOge4DFgHrE9KcGVG37IGBIxQCnk6PIHZutpKn2/BadZdrl7etLiBNl/VUiIFoZC1KBruvark+MK5c6mL+MDwpYSu5hQltoXKUGOmgHpG5ur4oUkTBy2nj+7jY2WUj6UVbZNpdENlFymxg1xWFWP6brEWFqV0a9zrOzBnm0Fg7V5C6mYRwybPOrwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4955.namprd11.prod.outlook.com (2603:10b6:806:fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Wed, 14 Aug
 2024 04:02:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7828.023; Wed, 14 Aug 2024
 04:02:15 +0000
Message-ID: <3e85512d-2639-4713-93c3-212b94838938@intel.com>
Date: Tue, 13 Aug 2024 21:02:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/39] x86/resctrl: Change
 mon_event_config_{read,write}() to be arch helpers
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>
References: <20240802172853.22529-1-james.morse@arm.com>
 <20240802172853.22529-21-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240802172853.22529-21-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0056.namprd04.prod.outlook.com
 (2603:10b6:303:6a::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: 742ec0a9-ecff-4da3-0f9d-08dcbc15e263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2hES09sZVlqczR3NDBwVUJtMTZQSXlmS0lsM1NHTmExZlNnT0FBclNXZTRF?=
 =?utf-8?B?Sm00WFoyZE40OW1pNzZ3cFUrSXg3cXY3clQ2RitYbkRTUndxRTV2R3dxTGth?=
 =?utf-8?B?empiK250WGZZMjJ0OXBNQVcxSnBUMnFpcm1wU3BtWDgwSUQxSlVOZEwwQzRG?=
 =?utf-8?B?ZGdHQ3RuTVhLRnV0ZFRSdXlvdmF2TjRFemtnUjN0aVRvMldUL25Nb2phZnlq?=
 =?utf-8?B?Mk14WnVPUFZVbUQyYklwT1QxTDczRGNQSndGaXBmZDdkWVVPeW44amd6UWl4?=
 =?utf-8?B?S1duamNFYlJwV3FSM0NDSkdvVDk2MkpsWGtGNm8yTVE5Q3hzQmZPekJ3blB3?=
 =?utf-8?B?YTBHbjdUNGt0YTJuMkN4TTNzVEhZRTkvUFQ2d3oxUUV6QzNSRTNSSWJkMmdo?=
 =?utf-8?B?UXp3QlcwYlhxRzAzQUVGYlNrRVl1U0JLZks3ZGVsUmlvYlAwR0FSc0RHczZM?=
 =?utf-8?B?YUNxM3daS2pGVEE1MTBRZjJocmphRzRSeitQM3J3c3B0U0gySUZTa1NDcW9Q?=
 =?utf-8?B?T0JIZU00a3dpUUM1N3NqT0Ria25CZGpyL0pzd3Q0MTc3S3NOem1NZXZaUTNT?=
 =?utf-8?B?Nm5hcXhzL2kweDJvakh3bGQzclJ4TDM0YjI0ODFqdXo3UmpGMXBUTXdHK1V5?=
 =?utf-8?B?cWo2cU1NWlVDcjV6S0l1dHdFOWd3YWYyc1drYnBDeUM1bkxaVkhnWXF4VWgw?=
 =?utf-8?B?RWpCMjJhdk5aY0ZLS2NkQ3ZsSzJTUm84SEVRMDB4SmNGbkIwSlpYUENVKzJh?=
 =?utf-8?B?WjVWUzZoVDlwS3dTNFVQMmRBMklPMGsvM3BjYmRsa3RLbndEWXY2Q3VqMlVa?=
 =?utf-8?B?NUlJR2FqcUJKSktUVlNQMUQvb1JidXcvUUcyd3hqVXRlWGJ1VTZsdlhGZnFk?=
 =?utf-8?B?cmR2Y0JYYWVxeU5YRW5yNEg4RGpoV0h0RkVMenkwb2ZUV28veERVUVd1eEtt?=
 =?utf-8?B?RUJpM3M0TlQrUUsralpnR0NmM2tmallPdEFmcXp0UVBxNW1mLzA0N2dQN1dO?=
 =?utf-8?B?Smk0bmN3eDNIZS9RbEpIZjVDVUQrM04rdzZDMGtyRzZCWjFsT2VQbDhoK0JZ?=
 =?utf-8?B?NzNrdEJzK2ljMXZROUREWjRRWjR1YmkvVjRYOVkzVFFMOGJ4dHExNmFadVY5?=
 =?utf-8?B?NGhzc0dFdGxBZjlIb0xoeGZnSnNIaHFnNld0YTcyNmo3Q3hLdlJoUHk3MUZo?=
 =?utf-8?B?dzlJcVVyN2hkYW5XdSt5cVo5NnhUOERIN2dSRXhrTGxxKzVuZDU5OEdEMU1n?=
 =?utf-8?B?cm5ZeEIyd3lyZlpwSXlscXY5eHQzYnJtV2RDMEwyOUFtK1VrcVZJZDEya1Ev?=
 =?utf-8?B?ZGJ6WWRWOHoxa0p3T0hNMFg3b2l2UTZQZnZjREZibm5KNUdIWnNrRVlTOUQw?=
 =?utf-8?B?M2Z1SGMwbU04OWNFT1ZBb05tc1B2MUZHZjN0alNVbk1pdmRtbGRaajhvRXRZ?=
 =?utf-8?B?dnhLcmlTVXBtRmlUM1NDV25qeFhMa21QY25QRi8zZUc0MUhxOUlDM21oZFVv?=
 =?utf-8?B?SjJwUzNSdjFmN1dtRFN2eXBMRFlsYmFWRnoxMWJ5U2ZFakdhU3c3SlQrNC8r?=
 =?utf-8?B?Q1pPQy9CRUtYcXRzOGI5K1hBcUtkTm9sR2hVdjVwNS9YbnNJVzZwdHVkbFdJ?=
 =?utf-8?B?SXNFdzNOcXNHRTBJTkpkYVV5L0FiRi9PdnQyTi9xd29ZTkdMMTY4SzZ6Rzdr?=
 =?utf-8?B?Y21BeUR3QTVYcE5GUjRhcVRGNzVkU3h1b0tSQXZFMm5sQUEzOTBzWEF0QmxQ?=
 =?utf-8?Q?xWx6VF50d7AbpCureE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDFUWi9KR2lSMER3TWRwWHpMaUVnb0psNE91emJMV2NTbDZKWFRaUHIwRDZ3?=
 =?utf-8?B?QWRBbklkMXRyZ1BkekZMKzY1TlBVdG9kSXNuZnFYeFNMbkYvZlBtNnlnTU00?=
 =?utf-8?B?QVFseEkvYkVWN3htSnhYajVERWZkbE1zSUJHby8zYVBUS1pmTjhWa05FQ2tP?=
 =?utf-8?B?RmtENWZVWUpocTlsQzF2c3VBVDY2MGlYVlNjeU1PdnFnMEpuMDFhMzhiM2FH?=
 =?utf-8?B?dXE1L2xQVVhyaUc0YTc4cDJrbG5sN2JBQU0zaVBxNm0xVWNOWXQ1VlVwZEoy?=
 =?utf-8?B?dmk1ZC9UUWhaWm1BbHhvZ2tiZ24rdld4TlB2cy9SUlZ2Y1dHOGJuay8vaWt6?=
 =?utf-8?B?OVc4N09nR1NKS3V2eW5jUVR2dEpZLzNxclBkOUVFYXdueE1pVkZZNmZmZXUw?=
 =?utf-8?B?dlpXdy9wNGNncldFYUhDTDF2M3lTN0lxN3ZLVVNGY0RYY3ppeGZzckpLYndT?=
 =?utf-8?B?ODZqbVlpamRNRnUxMUFPRk55aDFiSXMyMDF6MG51ZjU1aGJDelM1aUhnZ0Rr?=
 =?utf-8?B?STdjWEg4ZWE5dXRjQ3JEM25hRmRkWXpnMVo2L1NSMnc4QUFpNlNkVHgzY2My?=
 =?utf-8?B?VHBrcmVidlg5cThXeklsd3BoaVRRNENsdUhEVWwrbG1RYmZuSTBSdG1zblVK?=
 =?utf-8?B?RWc3U201RDZYVHkrQ0NOcGpLMkwxbE9mWE5yMkVJL1owdFVVN2hVcFpMYVFN?=
 =?utf-8?B?UWJqWlNwQ1FsQkx1UlF2TXNudjZLYi9vOGppM045djMrd3I2TElUcENxWURi?=
 =?utf-8?B?WnJ5ZDJzRnZNdEN3OEx5cDN5OWN4MnVHbE41VDlXRHB6S2xRdWhXN2w2UzBK?=
 =?utf-8?B?dEFEc01HZG00ejBqYVhmMFBlOW4xc0VEc1RwbXRKOHpaUXY5TmtFTiszeU1k?=
 =?utf-8?B?RktoTWdFbDdPcmI3ZEw5NXE0dnBEaTlCWmp4WHY4eHd1bVQ2bVhhRTNVbERH?=
 =?utf-8?B?NW0wTHNpQnI2dWlQYmpvTDFTR3VkL21lTXpGWGQ5QThWOWM5TU9WdWtYMHBl?=
 =?utf-8?B?aFVGMGdZdWFlcnNhL21kcTU2UFFiRCtsS3JSTWtGRUY3c0x6RHY3UW1vNy9r?=
 =?utf-8?B?aVdlc3Q4bU8yb1hwSHhmeHc5QnJLYm5EdWExOFRDaUwwVFE3U3ZITjhHRGc4?=
 =?utf-8?B?akxjekNrdUZWdDBsY0YzVnRhYmZrMzdRVmY2WUp0SXI4QVpuOVZhZHcvajht?=
 =?utf-8?B?anJLY2IyYy93dWlCeTJJbEVwcEFDY2xacmgvZFJpZ2Z0L0FZc2xRYm1uTjZH?=
 =?utf-8?B?cTZacVJ6bWxzL25lNmNCMk92RE5oRDFLRlZJR2pBa1doazkydkZnaXRwS1NI?=
 =?utf-8?B?Qmk2MENXK0pVSVZwVXdHM3JPSDl3Z25GZU8xN1FBb1dVT3l0Z0c1NmRvSVZ0?=
 =?utf-8?B?VER1TFF4bm1ZTWNuamw1RVhublFTTnMzUm5saGJxaS95ZlBGZ1ZaNnZhUmJX?=
 =?utf-8?B?TGVPRU5WQ3hvV2NsL1FkUlZqS0hqVEVES29LOFhLRnB2bWRTeUhzRC8ySW5I?=
 =?utf-8?B?OGNpVkIyb3FYbi92Q0FZcHh0U0pPUXg5TkcwSHpGcU9xWGpoUG1OeDVoM2o3?=
 =?utf-8?B?N25aU1dvMjE2Wk95N1ZwU1ZLUlJpb1FNZ0RJaWdGWU1Kell1WFpuWlFVeWw0?=
 =?utf-8?B?U05VL05pcHQxbmxHa0dJQmh4L0ppS3lMVzZDeUJycG1Rd3Y4bUJ0TEp4VzJ4?=
 =?utf-8?B?akJJYkR0S25QOWk2YTZjZFk1SXEreXg5VlFUMFhZYVZWMC9sc2VXRzM1T3lR?=
 =?utf-8?B?akxXUlEzcWRNODlFZ3d2NVExUkJ1N1hKVktTVG1vb2o0K2ZkdGVLakJyNjha?=
 =?utf-8?B?MmxVNXVWMEk2eXVWdTlpcmtSaDE1UUk5VzVaS2tXb0N6dW4wN2prZUs3OXZB?=
 =?utf-8?B?bXpydXNUTTR0RzhkNHJzS1Arb0R2YkNuR1llMDZZSklYYnlLbHJkVWt0UWhT?=
 =?utf-8?B?Q0E0K24wNlgvMHNwcGZ5a0gzZzc0MzU5VlcrUlorbUw4b1Z2Rlc1eE81REJY?=
 =?utf-8?B?NzU4OEJCcFFGbjg5dGpmdFk5ZFhzZGFpWjNuMDJZS2d4bnRaVUlVUlpnemxD?=
 =?utf-8?B?ZXlPZzlFNHUyQXdhNCtBbVR5c0VJU0p4SnQzTkNZbzM2WWlJLzFGcFVFOThZ?=
 =?utf-8?B?QXl3WDQ2blJFSXkrMVF6cDMrVHFyMXZxSkZTcUJJOEZEOExZSXpSZm5qL290?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 742ec0a9-ecff-4da3-0f9d-08dcbc15e263
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 04:02:15.9132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+4f893LveaJMMqri+4P1GEzS7/XqszJXaH+2CtGzVeHVAA+FQrl6WQwR1nSo8UWeUyDbm0tchEG1q3V3CyR3m2De/2iGKgwYvuoZkgkc3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4955
X-OriginatorOrg: intel.com

Hi James,

On 8/2/24 10:28 AM, James Morse wrote:
> @@ -1617,14 +1612,15 @@ static void mon_event_config_read(void *info)
>   	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
>   }
>   
> -static void mondata_config_read(struct rdt_mon_domain *d, struct mon_config_info *mon_info)
> +static void mondata_config_read(struct resctrl_mon_config_info *mon_info)
>   {
> -	smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_read, mon_info, 1);
> +	smp_call_function_any(&mon_info->d->hdr.cpu_mask,
> +			      resctrl_arch_mon_event_config_read, mon_info, 1);
>   }
>   
>   static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
>   {
> -	struct mon_config_info mon_info = {0};
> +	struct resctrl_mon_config_info mon_info = {0};
>   	struct rdt_mon_domain *dom;
>   	bool sep = false;
>   

Patch looks good, just a fyi:
https://lore.kernel.org/lkml/b2ebc809c8b6c6440d17b12ccf7c2d29aaafd488.1720868538.git.christophe.jaillet@wanadoo.fr

Reinette


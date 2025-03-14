Return-Path: <linux-kernel+bounces-561854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE02A61776
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5982688061F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AA82036F9;
	Fri, 14 Mar 2025 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AswuJBW8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2D420298B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741972986; cv=fail; b=DRa/1a1di3pvFSVIe/YA8xXg23hqZVR0zvswgPtWKeguIXRTtqPipNhw9SrCDKzhf27RcddVBDXPR5nadINN99u6vYThBjj7flb15dok4VAcwYNGMsVmTLy996myQRgo29cLvuTxLcPbOucKJWidT8TvM0pOt5kevAva4MFhG+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741972986; c=relaxed/simple;
	bh=FEYqDc21NcFJLilKIQfvCFMhHDf4lNADtm+8m4t7X98=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i6AVgZY/X+pya/cm5S5kwdVQjTGZfTx7wFPKeVYoTNprSppoKU9eFq5K191t0CyCT7qaS5ZHwqqNd+uTtQeiQbzhxbvTrKwSIaufL/vgB1431aDDIOcSbXZff/UarKNx+KbiuLhWgs1zLbu+zd4bY/V8fAzyqfmOEGM/MEEzrnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AswuJBW8; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741972985; x=1773508985;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FEYqDc21NcFJLilKIQfvCFMhHDf4lNADtm+8m4t7X98=;
  b=AswuJBW8nYKq8Zlf8O0V3P66pZrefpUBa7YyG6UCeljUXsdHRV2FebbS
   HZBo74U5agkgjENMoMA1i66QDwejqFQH7DcuLJg8UsSmbGWeSGDyZbbpQ
   xo9jnFRKw+AcfW4BQNt4xklVW3Je6VxJhFJd7wGpZGINtyIB+Jkz8nUAz
   5jwn3weJprU7ySlfGIDmPMRRKDqS45R2cBaQPV7A3OJG8+EnMlwj0CAYE
   1Jfe3qDS5887Ha+N5Xa6CuhACnEWhh7fm07CpcbChdE4TTwUgiL3Ra3kv
   IA/ikOcbNV0FQhaHVqSvBIxUPfwQL0Q4fE/dIPuMuSeHnHE1kYjYjH5IO
   w==;
X-CSE-ConnectionGUID: JOwGGfDORSaL7BYv7kEncg==
X-CSE-MsgGUID: LujFYmpBSi2Pqrh1vcHT2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="43022609"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43022609"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 10:23:04 -0700
X-CSE-ConnectionGUID: ZotunlAnRZm0sS1PBw7ibg==
X-CSE-MsgGUID: ypcSNDcOQHiMh0/o9VRjUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121292461"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 10:23:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 10:23:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 10:23:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 10:23:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hELzFuigYk7w8abIzy8u9Gsj4cHWnC2DABxVg7QRHxcGkO/r9wOzaOZ6VdEp/SSYGU9Xuv5kWKYzhDPmv52Mxc+wptWIjzurUOc4lKvaqJy8CH9aeEXyUJbPCUwWUz7lNW+p9g/p7tRmsC/vFTwfLZPgWnYu90ZhqRLPhmaZIJFZZg5beSdnrbgLHc+uDwoVBGhzw7HJTJiPf9LPjWp7JdNBdZ+WDNxfzeuAi9xfpnuyRaIx2qsWTAUqBmvZR+SpEC1oCYmqqkgosKtP0/41uTqAxqvGxPIegLvTfXbhAsHKvgMiTchcwB/ck+5/SdYvaA0eDUdnZYgg5uBvicHLsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJcQzNvq+lo30HlFqTFG0cOfqJRlpvA+YLmGcZiVrZ4=;
 b=j8N+maUC+jNpjYo4qsUa0FPiqlTzDCotcsrnaMqbgDLx+p1IOmTo7vNt3yFsLNDnNn1pIxJY1Vp1pjoE++yqlbIUsQgGJ1LFwjuyJf1H7jfPqS1MWK+/hf9ezWUl1bfvrccBd6x2IuUGp8SOV8ZAmSqSZJPVYI3+BRZhtR4Md54+e4ouQL9fXHXgqKXbpWGJSxSBLgJxmjU9mOfa55b5SMx6dzJYh4WgYZ5alXcQ3/7nj3AcNAPefettugq8ltfPRUFMrj76iSbevnj7YJBf3iz0y4UpxO535bnWAN+KCUUFDVCrL4n1P8ECaa1Gj75zMZJWMkT9f6k68xUCqJGKmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DM4PR11MB7757.namprd11.prod.outlook.com (2603:10b6:8:103::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 17:23:00 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 17:23:00 +0000
Message-ID: <6e86516e-1a56-48bd-9a18-529ec4c72f6d@intel.com>
Date: Fri, 14 Mar 2025 10:22:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] x86/entry: Break up common.c
To: Brian Gerst <brgerst@gmail.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>
CC: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "Andy
 Lutomirski" <luto@kernel.org>, Juergen Gross <jgross@suse.com>, "Boris
 Ostrovsky" <boris.ostrovsky@oracle.com>
References: <20250314151220.862768-1-brgerst@gmail.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250314151220.862768-1-brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0196.namprd05.prod.outlook.com
 (2603:10b6:a03:330::21) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DM4PR11MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: d9499c55-b141-452c-9932-08dd631cde77
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlVuNUw0YTdYWTRGTmF1VkVFdkw3QVdmVVVuNkhOMXRhVWFscFErS0dCRVFa?=
 =?utf-8?B?dVlPelBLVExFd2IxelRleGpHcnFDaGdaWWRkbWJOejVPY3RhSnQzUWNWM1pI?=
 =?utf-8?B?ZzhBN3IwTFJRVHZTakpiWWZOVzRlQk1UMEtXUkxnckRiZDUzM1RzNDI4b3Rz?=
 =?utf-8?B?MWNzOTFCaDV6K3pkYlpsK2R1OUg1MjF4UTJzOTRsRTBZclRadzdjaGVJaEw5?=
 =?utf-8?B?cXVFTjJwSzB4OHBTSURrNEpOcWozTmJ1V0tFTmI4Mi95eXY5YUkrVksxSDVV?=
 =?utf-8?B?cXpwb21QSzU0WGRoZ2ZPY1poMmdqdzZ2Z3pSSGZRNGxKdm93cTJGa2Voa093?=
 =?utf-8?B?ZWV5ZklRUnoyL0ZuSEQyQWlwSFpQTjNmNmNEVmY4OXRvaG9pdnlRbU0wWnY5?=
 =?utf-8?B?RGY1Z0ZSTUhxVlhGQXR0T2JXREZSSFhwdEdVTHZ6UFJIbjFGSnhUanNlbENV?=
 =?utf-8?B?bkNMSm9PdkRKM0FQM2dnZUZrMUlwNThHTE1WaU9xT21XWmdzR3ZoNHNVMEFl?=
 =?utf-8?B?aCt4ZkJHcVBzUyt3TnBZblR2TjQ4ZE5yM25aSVN0d3p6QzMrcHhHVHIrR2hG?=
 =?utf-8?B?Skw0VTJOT1ZoTzBKK1YraGk2bXZLQ1hyRkxvZEQwZGpBZmJHc3VRN2wxT1M2?=
 =?utf-8?B?UHhXVWQ5TFNwckpodzIrNE40NVF4N2NQV3NmcWxhTDB6M0hhRnpjaEZCVXdh?=
 =?utf-8?B?eHVZSkFqNFBGNmtvbmY5Vm9zejJ5ZTJubE11NGh6c1l4SHBSaG1vUUpWYklX?=
 =?utf-8?B?U2FxdngwaHRsYjNKRldURXpQdnptaWVYTEdWVXdvbHh4OFV1cEdmbkVCc1ZT?=
 =?utf-8?B?cGVZcFRMRHVEWCtvQy9rd0w2L3lQU3N6dDdFNHFFRUh2ZzZJcGdRc2MyTGxr?=
 =?utf-8?B?Skk0Q0hxd2NLRDJaaU91N0VWclZrZlZzeTN2a1M2Q3cyVUdpVmhtT0ZkUU5J?=
 =?utf-8?B?aThSanYzdElEVmlNVlZTRERDZFl6azZhNlQ0LzV6STdoaGJLd01HczgxZzZU?=
 =?utf-8?B?UmZnZ1VqRFVsQ1paSWxXMTVoRVdoK1FQWk5PU1Zwb3lhNUdDakNZUUpORUY4?=
 =?utf-8?B?M25OTWdIV0pWdStUaDBqTnRuUjVBbHE3cUNSTmdTT3N1VTJIS0NQTVpPY2gw?=
 =?utf-8?B?NWhUL0VhdVRTb09SVWFrdk1HNVBrRFpraU16cngvNGdMWkVVS0VOU3AvQWVX?=
 =?utf-8?B?bDhNcGppNEVEMEpLaTJ0U2VoNUVOSEtOVjg3U0x6aFFkOVhtcDJqL3lDY1l1?=
 =?utf-8?B?V2ZiOTM2S2pHRWtJM3ZOMC9lM1F6VG4zSnNaNkhTcmN6QVZQcnlyRFZ5dGlr?=
 =?utf-8?B?U25tblJHMTdFMzBFam9hbGNLL05oRmlYV1ZWMy9vV2doS3NGNzlYOHN3TlhQ?=
 =?utf-8?B?cnFYUER5WXp4NjhFL3NVTWdZNlZRSW9YeEZkK2VDcTZPZmt4WVEvRi9FQWZJ?=
 =?utf-8?B?UUtTSUFsNkw5YTZjNzVDSktabXRPUGdaMGt2WWNhMkhTNWlNZjNYdk5xbXFu?=
 =?utf-8?B?Y0gySENnaEFiWGNCN3hvdGU1MnJPUVVuRSs3eUwxd3RUN2I5UVdDWk9hRkFv?=
 =?utf-8?B?TVhMTFdMV0M4N3p2MC9kOGZVa0Y4aGg2N0xFVU4yTk1MYjlrbG9vR3ROZ0d1?=
 =?utf-8?B?TmNwdjZHdjJZYzMwSFBXa1ZjZDdmNktvc2JtazVoYlo5NURmZURRcjh4TGtQ?=
 =?utf-8?B?R1pZTzBmRFZvdUt2YXZ5UGNFeE5sbzdjVDNFT0RGS1h4S0t6d1JuYTRKMkxV?=
 =?utf-8?B?U1RkRkloR1NNVDRrYTRwSm9FTlpPVGVLRUE3N1NxcTlodEp0dks2QVN0ZDlR?=
 =?utf-8?B?NytlS25wWjZ3WGttQzJ1dlMvdWdTK0FqV3pRbVp4c3lzby9sNDJXSVg4NURD?=
 =?utf-8?Q?y1tKlG4aDdzHf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1Fwdkh6Y2ZDNDJYRzVOTm9GNmx0V2pGT2hCS2ZBSG5mbHNlZTJNMi8wV1kx?=
 =?utf-8?B?Nm9USFdMdFd5OW9uY3RBZDN3aFNGa0c2eVFYT2FHNXBYYVRZemlIeEdUYllr?=
 =?utf-8?B?SzFjam9YOHNOWGRONjY5RXhQUzNqVWRFcks3aVhQM0s0T1RiZE9wK2Vuczhn?=
 =?utf-8?B?QVZxdEtxYU1DbFJNbzh3K3A3OGNpWjdKRTNBakVQdm1KVkpqWXVNbzQ1SlJC?=
 =?utf-8?B?c3N3dWNPOThuaXY2aDllRkpWeG1TcmMrT2U2TkxGeTB6YkZuMWRQa2VnZXhJ?=
 =?utf-8?B?OU9tQllNRmZOWi96OU9hcVJPeWQwYTVNeTAzWG1DMWk5V3kyay8wZWZOT3Nn?=
 =?utf-8?B?S21tYWVqdkVqSGZ4eTJ5bk1uRUVIdVhUWUpKK1NveE96Z2xuUERzQTViVWp3?=
 =?utf-8?B?R1RHcnBUL1NDNnFqdXcrS1pGdnQyMjAvMGJRTkJzcndKNkhucGZFNjgrNXB1?=
 =?utf-8?B?bG9nVkh1ZCt2ckJMeFdqYWYvek9HQWYzdWc0UXM3TE1DYTBEdURheTVqOTh4?=
 =?utf-8?B?Ni9UaDUzVXNXKzlmeXoxc01paTNldmxEQS9ZZHFMYXdsSTBFZDM5RGJCbE9i?=
 =?utf-8?B?TloyOFBGSVlaU3lDdlZHekJlYkxlM1dmd1crMTVZTHVRRlpuaEZ1VXpYQzZS?=
 =?utf-8?B?SElqNzRxWFpaOWRjNFQ2UFVYQTE0bzhxd29KY2M1MWU1M0JxYVhHblJzOFZs?=
 =?utf-8?B?STNHa0ljb29CeE1hbVBHVTRmRWhoZW1MR1dyQnJWZG15V2xKVkVtcE1XZ1dS?=
 =?utf-8?B?a2JvYW1ldWNDNDNVSTUrTEo5eGFkNXpWaVRzUGdvdEQvcFhkRnppS2FVekpj?=
 =?utf-8?B?VEducW8rWjVBVWVWNlFJZ1JhZjNHelE5QjlGK24yQnRnRlhvUUl2NkNncWNv?=
 =?utf-8?B?RGxiU0EzOWlOVzZkcnl4dlh0dm9pNXRYc3JObU1HODJHK0d5bk5VTHlHMVh0?=
 =?utf-8?B?ekJva0ozakFFN01jS1VTSHRWRkpXUEZMbkx6NTh4aUJNSGxSWUQ0RU84ZEJz?=
 =?utf-8?B?SjJISXhSRW9ZSTk3UXdDTlJaWlo3ZkZpT1hYWmxIcUFFMFh6dDI1dFJQWktr?=
 =?utf-8?B?M0d1cVkxLzNjVStDdkxIa2I2RURzdjFrWUE1WnE1amF0UkpwYzBXRXdEZnJu?=
 =?utf-8?B?VURrNGJmSzhVSU93YXRTZ3NTdGl1QktvcGVrdVhJcVEwSFhndHg2eXRhbmFB?=
 =?utf-8?B?Q1ZURWhES2R0Qnh2UVFKeUxUS2FaY3E2UmZQMzJzRUVYU1NBSFlUWU91VVNz?=
 =?utf-8?B?cUtkQVRoUkZEdWg5UC9TaHlqZkhENHdzd2RuZXl2bGVOVUFjVmRIa1Jzdlhz?=
 =?utf-8?B?elFrRFdiakdqWjNQRUN4SXlaamoyejZTRDdZRUNmWTUrdURYSmd6MHl3Um5q?=
 =?utf-8?B?NTRaTkplUmZPV21qU0tNalU0dGZWYkdoVG5QMlduVGpFMVdua3dudWJNYm5F?=
 =?utf-8?B?eHNSdURwdE5rZkJUVHkwNzhrTUhsMzFoUUlLK2lDUlFKenFmKytYOExGNDYx?=
 =?utf-8?B?SnlBREowTjlId1Exdkc4Ry9qU2VEQVNsVTZheUttTUNHSnNzVXNpNm5WSVFm?=
 =?utf-8?B?cmJoOE5XS0FTL2E1U3g4TVBrTVFoT1V0MldKeXViYlhXNzNTOGdVbWE2NVJM?=
 =?utf-8?B?K3N3WXZ5YkdjTmJKMWRyMXJkOW12QUMzaVZIdEcyTDVIQnJ0cmhKYitVZW8x?=
 =?utf-8?B?YmRMcEtXdnUrSUNwUkNRQnpwK1ZxU0pScUx6WVE3VWhvOGw0eTRYN0Jlamxr?=
 =?utf-8?B?TEFQM2pUb09qdi83TjBEM1k3THorYi9Zc25wVVMxWkJaL1lXRjhFRTVydzM2?=
 =?utf-8?B?Sm12S0NSRDFsL3FuSldIdU9MWG02NWFiQ1ZtUnlVR0p1RGpLbXBoNnJmMy84?=
 =?utf-8?B?VlJoa1ZpcXVRYjBlZHE4V1ZWNFIyYTJkdUhSK0NBWXpMUXVzQlZMZnN4aDYy?=
 =?utf-8?B?Y0FOS1kyVFVVeVBTV3FtMUo1RFZqYkhyVDlKOGVLK2tWbVg4RkhGVjhCeEE5?=
 =?utf-8?B?ZmhZNnJPVzF6QTNFdURIb1hMYXVZY1A1QVNqTmx6VUJRb3YxZnI1MTI2dkJh?=
 =?utf-8?B?VHZ0RmJxV0p4UEI4MW05cndwYWlEUlNyZHN5ZjN6Q1ZYNDJHUEdSZFE1YVRy?=
 =?utf-8?Q?Ep2h9P0+y3h6EbS6azFt8RDQm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9499c55-b141-452c-9932-08dd631cde77
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 17:23:00.0427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRR+CXgEJyjlvudWCa9d5+BC2MzG/5Q3ezOSU4qN+fhwBNlWnhw7aW/1kFvuKuERetymqtgv2MkrH4ypB0OYhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7757
X-OriginatorOrg: intel.com

On 3/14/2025 8:12 AM, Brian Gerst wrote:
> The syscall dispatch code originally was put into entry/common.c so that
> common code for entry from and exit to userspace could be inlined.  That
> entry code has since been moved to the core kernel.  There is no longer
> a need to keep this code together, so move it to more appropriate
> places.
> 
> No functional changes.
> 
> Changes in v2:
> - Move Xen inlines to enlighten_pv.c (Juergen Gross)
> - Don't copy comments on the code's origins.  Git history has that
>   information already (Sohil Mehta)
> - Added cleanup patches (Sohil Mehta)
> 
> Brian Gerst (7):
>   x86/xen: Move Xen upcall handler
>   x86/syscall/32: Move 32-bit syscall dispatch code
>   x86/syscall/64: Move 64-bit syscall dispatch code
>   x86/syscall/x32: Move x32 syscall table
>   x86/syscall: Move sys_ni_syscall()
>   x86/syscall: Remove stray semicolons
>   x86/syscall/32: Add comment to conditional
> 

This series looks good to me. The minor comments in patch 7 can be
addressed separately if they seem useful.

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>


>  arch/x86/entry/Makefile      |   8 +-
>  arch/x86/entry/common.c      | 524 -----------------------------------
>  arch/x86/entry/syscall_32.c  | 332 +++++++++++++++++++++-
>  arch/x86/entry/syscall_64.c  | 111 +++++++-
>  arch/x86/entry/syscall_x32.c |  25 --
>  arch/x86/kernel/process.c    |   5 +
>  arch/x86/xen/enlighten_pv.c  |  69 +++++
>  7 files changed, 515 insertions(+), 559 deletions(-)
>  delete mode 100644 arch/x86/entry/common.c
>  delete mode 100644 arch/x86/entry/syscall_x32.c
> 
> 
> base-commit: d08c0d55110b7cbac186e5fa94b0c6d5f4d7905e



Return-Path: <linux-kernel+bounces-520040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D56A3A509
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397833AD5E0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DC9270EDC;
	Tue, 18 Feb 2025 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PkZLQI4+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2875218CC15
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902428; cv=fail; b=OvgFET3FC0yFQGLL7MTi1bUtIqGwZYW2yOo5usQO7LtmiNaHzCqXgQV+FWR0S7tWf0Ya235SHe/7kYlX+JeeWz3bbtEBKSTucSBUoi3K4y5H1VP+m21INZ/uBmCuYXw606P6u3gB4sz8P9KGSnTR0erDgphywtqQxSpjt3pwb+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902428; c=relaxed/simple;
	bh=f5Iuf3ZmGgzkyLaVt31I529Oo6It62h0qF9DeplIN2I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sqsLz08EjUZ4U7YtFjB9z78iIt/0lWpeNyvvxjEXVRdQzC+ETl/dZ8phduuBdfHR5ixwD1Tyv2IQ27wmYzFMyJVrIkuEcze9a6kMnYkyUsRyVPGWSp/N/K8nWGAfthScm5B8neR+Ohqs59YVHLeQcM1Yrt75mUh/H7OUIpNhxvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PkZLQI4+; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739902426; x=1771438426;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f5Iuf3ZmGgzkyLaVt31I529Oo6It62h0qF9DeplIN2I=;
  b=PkZLQI4+oteVDIL3foi2sByBDNNzscBxRoO8/mw05eKYCxvAjehtmb2L
   n6k0Rtx3EH/6bM9Q7RjokNRKolpJ/G846oxMttnk+zLndRGEdshLwzfw2
   6egxnx/ltPhZV4vBRCcWSgHRYguZjCc2LdVpY8Rz0KAkNePXxMyRfBhsF
   Odgq06asXT5VW2dgPCjYXgHuT7uafY3QZFDDp3qjZD3eS1nuJ1O4U2rC6
   e3ehxo+oi0D95tTyQGRW79DPRg7t46br9Y0hVN4xJvo12GPyNDDj3bLKJ
   Cm39YlTJdnQJ2/AQyiQ+57d2tAj6bBUpe/bYYhH2bla99MxPA4ni0cooV
   w==;
X-CSE-ConnectionGUID: oLqzPDpSSBqgnYDhDmJyQg==
X-CSE-MsgGUID: tb2NRVpLQU+3QonmD1cc5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="65967917"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="65967917"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 10:13:45 -0800
X-CSE-ConnectionGUID: YG6I97JNR6eEFRNODMxBSQ==
X-CSE-MsgGUID: zQbmurP4Q3CjXSeB6KxLOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115353602"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2025 10:13:45 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Feb 2025 10:13:44 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 10:13:44 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 10:13:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2EgIZwKLuiHLMYa5j2o/Ll305lU95hJ1iJ7AK4DK9kBl6yCLekEi+rnxhyLenNoy/e/nz3qlOUbuA1Wy18eYtOD5IaQ0oSnxYH0VcMIpKXrI3YvpSXwYlpIVK5K5vQQpZvSeKVRK/dxaAZvOjZaTWCAoS8iuzgJkp/b2SPqgDJYjaLO+yDs6QMSI1QYWWtbaJk1zvEjdL/LhBGFP7RBoHv9uMzMI+TcB3Nt5JzmZABvFba5YkEnS1DW+yxlWWEhZHZi8kT2FqM3Uf5pJMo4qEoV+yfJKHiJqlB87AJGxBn24zaxvmokVRvAf70fYUp2U08o+p16xK1A3Eed6T9R7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8qjBq8GH4J2h3fboohpZb5EfEiQS52w0tzu2GXLpfY=;
 b=XpbEIVmzd185i5Ka7KZDXAvYhT+6UfDJ+LY//pdlVt8tr1+DxCPu2fNIG63OhK1wJKlSIgZDj+Xdf8dNulJ9T5QhBiM8jrEEpf/QnIORiO0/gVHIuBrwIV17tQtbzcFIjb2b53ikgRs5r927iyXf/x/OyA/z4CqmTMZ+f348TMdf3zeJPqnZhH2NNrTQ4jW5sL/wMrTSPKn6I49XZpnZOUNDF++qDk9SkrCgowxr2bM4z1tXrc/ofjV63P/UNKGLJZCSLpiX2diEl8Eacl8Eyfuh/Tp84cZzDlmQO+/skhLwaS5gciHODSeIkh1mTshm7tUn8jrCv+p46pdzABjDDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 CY8PR11MB7314.namprd11.prod.outlook.com (2603:10b6:930:9d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.19; Tue, 18 Feb 2025 18:13:41 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%3]) with mapi id 15.20.8466.013; Tue, 18 Feb 2025
 18:13:41 +0000
Message-ID: <85eb9541-f33a-4bef-8bfa-d1394e850a7b@intel.com>
Date: Tue, 18 Feb 2025 12:13:35 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tsm: Add TVM Measurement Register support
To: "Huang, Kai" <kai.huang@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>
CC: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
 <20250212-tdx-rtmr-v1-1-9795dc49e132@intel.com>
 <828df2dd-a099-4146-96fe-0915cfa2e4b5@intel.com>
 <10ab62c7-d2fc-4014-a235-700bef017a3e@intel.com>
 <261614c2ae52b79028469f2b50e1b69df1882137.camel@intel.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <261614c2ae52b79028469f2b50e1b69df1882137.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0090.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::31) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|CY8PR11MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f26e4b-c25a-42f4-e1f3-08dd5047f959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmsrM0FIdzNsbFBSOUVPeVM3NWlBTDVvbkY5VzRUMlR0WG1HdDBJblZITDBw?=
 =?utf-8?B?Y3VTSGcxazlQdG1HMW5xQnY1N1BVeTVmT2NyUnp5UEtjV29EZmR3aEVEd0dS?=
 =?utf-8?B?L1JZTXBPL2hzbDFpbTJORXluRzI1b0FCUmR5ZkMySnBpdEFZdzEzL2tOK1FF?=
 =?utf-8?B?Ky9oSkZSVHVUTVlFd2piNHMxT015aGdoOFM2SXlwRTMzVU84OUFLSGhjVCs1?=
 =?utf-8?B?cmhaT2s2K05DSFEwTDA0bVh3V1ZPanR2bWYyWDBScFBOVFlPRUtST2ZpZU81?=
 =?utf-8?B?Qkt6NE1pYnY1c1R1UDRyNkJOTXBpa05ZaGtSY25pNHNsZXNvTlgwZUVWdys3?=
 =?utf-8?B?dG96RG9HS2xqbVRvZ20rd1ZWVjlHczROeFJDL2ZtQ0lxZ0p0cm4xbkx1S3NK?=
 =?utf-8?B?UGpUNVcrVkcyZ3EyRFV6N0F3OHRqNFZmSktEbWdyUk1jZWt6L2lhUStxRVZy?=
 =?utf-8?B?Nk0xbW1KTXBOZ0xpSDhLVVVibGpidHFtSFJrWTYvM2xCaSttTUtDSEYrQzRX?=
 =?utf-8?B?VVBWbjFWUko5YnNlb2dMWHo5SzRQWklHWTJES3ZXMFpDNWRMNlhneXMvQU5i?=
 =?utf-8?B?bTBlUlNKcXJNbFpNQ3RYYXg3cCtEU1dSRnR0Qk5LaEMxVWRMUG5KcERLakNh?=
 =?utf-8?B?cmNUWkdQOXRhdE9XeGxjOFh1eitiS3A1QXk3SmZpU1pxNVhBTTV0MlRyZU0v?=
 =?utf-8?B?b0JOM1JXYmFWL0x5WXllUWRYYWFER1ZnK1EwczJ2cCtBeWNrbU1FWStYMldW?=
 =?utf-8?B?WUJUTnNFTG1OSmovUnJDL1JyVWJwc3JCcnVvQVlGSkZjOCtQRElaS1pidnFI?=
 =?utf-8?B?ck5iUEZjaWtKSGZCTXZQOVp0NCtObEpWNENUdkZ5bUVidHR4ekwzY21kWitZ?=
 =?utf-8?B?WjVKYzNJckl2QWdhNnlnMjc2MWJ4d1hNSW1BVU9ZV2E2ZVJ0WUQyMVRxMGli?=
 =?utf-8?B?MmFJYUx4WS9RL3lwUkMyQXV2MFRZUUlla2pCaWVmdTZEblVlRUhCcFcxTUtl?=
 =?utf-8?B?NE95akwzeUpnQkN6SXBFcjRvR2l3S2YyS203VUpVSXN2VDRnMm1Sd2tWbzBU?=
 =?utf-8?B?TEJ5eS9EbitHR1RwSUg2Z2ZJY25FZ1NpdytZTWg0clBlcUIzdDBpbFVvemZ2?=
 =?utf-8?B?SHhGWnF0NE1kSWdLdDJTY2JnRXRTcVhuU0NJVy9CNHJIOXpUaXkwN05DdkZv?=
 =?utf-8?B?T3VaNUhKR1ZoS0IxQTJWY0VFeU96Q3hWNkpmVHZhS2ZBTzVIVkQyU1IvM3l2?=
 =?utf-8?B?azlnUXh3a3BONVFXRzBpVFJZc085alNjR202b2syY3AzZlpwbUdNUVUva2wv?=
 =?utf-8?B?NjM4aldvNVRDSmRoTExKVENsbVRWQ3RsNG4vRExCUjlSbGlQcTJmQUFPREhG?=
 =?utf-8?B?ZEsvK0g0eGJ1b0ZmY1U5cTRpcno2clJ3SVFhd2RadzhWRzFyOWVTbHVudUtm?=
 =?utf-8?B?ZS9WdktiZ1A4MTJTYStpVEpxdWdBTE9GZzRqcDhtUnNwVVpYeVhBQ2RjTUcx?=
 =?utf-8?B?cXIyRzVZZXNlRTl1aWlQaU1UdHZ1Q0RXWjFxR281anI2MlNMSHh0VnJDdVVi?=
 =?utf-8?B?YVJxS041MkphM3pFR0FlWjVDdkF5eksyc1JFa1Bmb1NDTThQOFlYZXM2NXFh?=
 =?utf-8?B?L051N2VJbnl0empUR3UxS0o3cG9rSlpORFpoajVhVzY3ek9UV01wYlRlV0sv?=
 =?utf-8?B?NDhiWlJCRzRnc1ZFbU5MZXBMaFoxU2pjbHdQNy9QNHliNDMxbTU0SXVlQnlI?=
 =?utf-8?B?YUwrVjNFbnVKMmJObStycmk1b3lzVG1jV0RMWlBwKzdTdGJXd01pWFM3QWU1?=
 =?utf-8?B?K0RjVW04SlRQazd3SHM0VjErQmp0Y2lhNi9TbFpuc1d5a1V6Ym5YSDUyMHQx?=
 =?utf-8?B?d1JDNi83dXpCcFowaU1KWXUzUXI1dUo1cVE3a1daTWJ0TFBMaW5IWkFUb3RV?=
 =?utf-8?Q?QuLjDayNpjE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTRMc1ZHUDhRNnFBRlB1WnZOYXovWUtTcFNFaWI5YXBoanB1RzViVkQzcmNP?=
 =?utf-8?B?QjNuSFcwY0dGelZWV1UxR0VXUGRpeVBXQzQ0MXpaZlJOaTUzOVk1b0lLRlR3?=
 =?utf-8?B?NHhFNE43MEtFUGJwN3ZnRFMwQXVXQVhJZWxtZWgxSWRjdGFzd3JWRlc5ODZR?=
 =?utf-8?B?WXJQbktVYWNNTmRiOUNyQ1BnR1BVdU5nbGdhbHp3Z2QzOGhpcTMyeEdsRnQ5?=
 =?utf-8?B?NFdOamJwekFtNmVDZ3Q5WXowNDd6Si9CYzlDcmZBa2dCdWVzMGw4SzRJSGVn?=
 =?utf-8?B?TVdQYVoxRTRBUUVMVEp5OGxKL1JMdVBmT1lySlhqaHdkR2JkN3FFQkd3cGEz?=
 =?utf-8?B?QzBKTGVNUEI3bXNYQWRSdXI3Z3JRM1hYeEJQTXQvNDRmeHNtTGVoSGg5Vks4?=
 =?utf-8?B?cm1ZcmNRbzZTbjRXWDZNakVGNTBwUmJJZVU3YjZiUUVzamRjdVhHK3dOMGFC?=
 =?utf-8?B?RXBDMkJTTlJXdkJRcnFSUDNoRm5CVW9yV0JZVjJuQWE3MWIzdGVjdkhtY3Nn?=
 =?utf-8?B?TG5Ba1hMWTVTbElsTE5GUXNBc3ZoYVhpVHN0SHZucHJ2alJ4TXpZVDFLZ2FB?=
 =?utf-8?B?OS9iTFhGL2JPSTd6U3BnbGdGUkRhY0UxYUZjTy9RR1JtWTNtVld2MGVBTXpk?=
 =?utf-8?B?eEUzbVNtcXhVaUZSZkUrS0hPS0NOOHh4SHk4VnVvQzV2ZlhxQWFqcThYdkVN?=
 =?utf-8?B?UHlyNkdtZDg3SGRVdFZxLzVzSTR1bDM5VEUyWDRia293WmFJU3Vkb1VzM2RR?=
 =?utf-8?B?L0lHUlNWaFhlMU1aMHZoTjRiN3FROGk0V3pERDNYQ2U2UlN0ZEJ6c1BtQ2NG?=
 =?utf-8?B?Uklldm0rQnhYNG1mblRPVEdsTFZSY2FvejYzNUdjN2w3RGRsTWlaZXprRmVX?=
 =?utf-8?B?UlJFZ0dFd3FOMHNOTm9jOUZhN1JVa1RyK2hWSkJQUzBiak91azN6a1AzUmZ6?=
 =?utf-8?B?Rnh3MkVGbW83RDJCNVJVUmdYTEtWUkxWTUNIVW5wdFpxRHFXOEUrNVlUa2pQ?=
 =?utf-8?B?U1RVNjJGNlBVY2o2RENXQVIxejhUQ3NXMzNEcUpTTnZsem9HRDFrUUptNmta?=
 =?utf-8?B?UFg1RS9mYUpFSkl6UFB2azdIWG1IRkNvR0preFMrNlNzRFNGT0x1QTdtSjNB?=
 =?utf-8?B?MUM0WUxpK0xNNEowcEI5Zm14OUNDZnhKM2tlL3NBUlg1U3NJUTdVcHZhL2dD?=
 =?utf-8?B?RXhJUnVieDU1NDBhczhITHQrNVdOQzJaMHBFNCsvUkRQL0ZJVTNLeUozUEdN?=
 =?utf-8?B?c0NQbFBYbDZMVXlFd2xCVVU0d25aOHpSWEJCOTBxM2R5QXM3aEN3aEhDVnhD?=
 =?utf-8?B?V1pLR1ovNHhKbFUxbmloTThJSDNac3lwYmZWQVNlbGZScGdUN2wxYmRlNEor?=
 =?utf-8?B?VmswQXI5NUk0clBoWkFrd0EwQldtd1E4UmQyYnhiV2VHQkhRKzF6SEhmeFhy?=
 =?utf-8?B?ME11c2xTak5tbjBFNE5nSXo5SGpZelJpVWwyVEtNMDMwelBGNmtKdFREdTlN?=
 =?utf-8?B?SVJEMGZwVEt1U0JTZUJtb28wUDVqSXZmNjRWbmIxR0xUQU1wSmlKUDFna1oy?=
 =?utf-8?B?OVg5RGMwcURFWjBUZUNtNUZDL2NJbEpHTmxVN3hMMDZmd21MTGM4VTZtcDhC?=
 =?utf-8?B?VEc0Ky8yV3hFVDNMNG4vRUdKK0xBRTJ0cWo0OWwxMGpyVExqWUJXQ0RxS0pG?=
 =?utf-8?B?RXpaN3kxdGIwV1htNDFHYTBpNVI1Y1pnd09VSzBWZlN4M0pPVURyeS9QTVVT?=
 =?utf-8?B?SjlLR1NoUDRVSWJnMXllblp4K29iNE5GTlhXVUdWUTVBZzV2Ym9TOHlQazZE?=
 =?utf-8?B?UzRhT3I0VTFLVExOWk44UTJ6Y20xU240ckdZeWhYN2R1bDhwaTU4ZFRVclE1?=
 =?utf-8?B?YmhoaXMvWEN5a1FiN253K1dyU3dSdHlLcDlZSFNuZlNBSE5zSTE4alF6ajEw?=
 =?utf-8?B?ZjJoQ0lieVMxMHliVjA4QVVkZHNtaGVuSWpvL0lIaGU1endsM2JnWGpXM2do?=
 =?utf-8?B?eGVjUlVYd0JPOHIzdHNHWHNqcWFBbGFWdnNrZmN6UE5oWnhiOU9YUFhxOVpo?=
 =?utf-8?B?eXh1V0RpcVdJMEdYSmYrWnQ1RklUa0taYlVDQWNZQ1QyeEdlM1cwaEdjcHA4?=
 =?utf-8?Q?DFnfXr4jnWXcm9GHB88OFLEte?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f26e4b-c25a-42f4-e1f3-08dd5047f959
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 18:13:41.4860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6Cv9du/JO1Ug6NPu1z3PrGsoFUhoq8mr5q9nHk1zjyqaHi6vP/6o6r35SdNKBohzkIuh0ZIPe2+ngodVzddkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7314
X-OriginatorOrg: intel.com

On 2/18/2025 3:14 AM, Huang, Kai wrote:
> 
>>>> +/**
>>>> + * enum tsm_measurement_register_flag - properties of an MR
>>>> + * @TSM_MR_F_X: this MR supports the extension semantics on write
>>>> + * @TSM_MR_F_W: this MR is writable
>>>
>>> Why a MR can be written w/o being extended?  What is the use case of this?
>>>
>>
>> This is because "write" may not be the only way to extend an RTMR. For
>> example, the current ABI proposed by this patch can be considered "MR
>> centric", meaning it's the application that takes care of what to hash,
>> using what algorithm, and which RTMR to extend.
>>
> 
> [...]
> 
>> However, theoretically,
>> applications should only be concerned the integrity of some sequence of
>> events (the event log). Therefore, there could be a "log centric" ABI
>> that allows applications to integrity-protect its logs in a CC-arch
>> agnostic manner.
>>
> 
> I agree "log centric" ABI could be useful.  I don't know a lot of the format of
> "event log", but I am thinking that making sure "integrity of some sequence of
> events" may not be good enough -- we actually need to make sure "integrity of
> each component" that get involved in those events.
> 
By "some sequence of events", I was talking from the perspective of an 
application. Different applications will generate independent sequences 
of events and because different CC archs offer different types and 
numbers of MRs that use different hash algorithms, what we need is a SW 
arch that can "pack" those sequences into something that can be 
integrity-protected by the HW resource from the underlying CC arch, then 
"unpack" it back to independent sequences to be verified/appraised by 
potentially independent entities. The "log centric" ABI will be part of 
such an architecture. This is too big a topic to solve by this patch. 
For now, what matters is just not to create roadblocks.

> E.g., a guest wants to load some particular kernel module during boot and wants
> to make sure the correct one gets loaded.  Userspace can trigger an event of
> "loading that module" and get this *event log* verified.  But w/o getting the
> kernel module binary itself measured as part of this step, we cannot really be
> sure whether this step is compromised or not.  In this case, the userspace may
> still need to (write and) extend the MR(s).
> 
By the term "event", it usually implies accompanying "event data", which 
could be/contain the measurements of the kernel modules.

You are talking about actual uses of RTMRs and this patch aims to enable 
those exact uses. :-)

>> And if that's the case, RTMRs may be marked RO ("X w/o
>> W") to prevent direct extension.
> 
> Sorry I don't quite follow why RO is enough for "log centric" ABI.  Could you
> elaborate a bit?
> 
My apologies for the confusion again! R/W controls the file permissions 
of the sysfs attributes, while X is the semantics of the MR. Clearing W 
prevents direct "write" to the attribute (by user mode) but doesn't 
prevent the MR from being extended through other interfaces. It isn't 
obvious in this patch because the "log centric" ABI has been taken out. 
It was originally proposed in 
https://lore.kernel.org/all/20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com/

>>
>> The use of "W w/o X" is to support pseudo-MRs. For example, `reportdata`
>> is such a pseudo-MR that is W but not X. So an application can request a
>> TDREPORT by a write to `reportdata` followed by a read from `report0`.
> 
> I am a little bit confused.  This series is about exposing "measurement
> registers" to userspace, so I thought there should be at least some
> "measurement" get involved for any entry that is report to userspace.
> 
> 'reportdata' is more like the nonce embedded to the attestation report, and it
> doesn't involve any measurement.
> 
> I can see why you want to expose 'reportdata' to userspace, but calling
> 'reportdata' as measurement register seems unfit.
> 
Glad that you see why! I called it a pseudo-MR but there could be better 
names. The intention of this patch is to create a sysfs tree that offers 
all measurement related functionalities to user mode applications. 
`reportdata` plays a role here because it usually carries the digest of 
something that the guest wants to attest to.

>>
>>>> + * @TSM_MR_F_R: this MR is readable. This should typically be set
>>>> + * @TSM_MR_F_L: this MR is live - writes to other MRs may change this MR
>>>
>>> Why one MR can be changed by writing to other MRs?
>>>
>>
>> Good catch! I'll fix the comment.
>>
>>>> + * @TSM_MR_F_F: present this MR as a file (instead of a directory)
>>>> + * @TSM_MR_F_LIVE: shorthand for L (live) and R (readable)
>>>> + * @TSM_MR_F_RTMR: shorthand for LIVE and X (extensible)
>>>> + */
>>>> +enum tsm_measurement_register_flag {
>>>> +    TSM_MR_F_X = 1,
>>>> +    TSM_MR_F_W = 2,
>>>> +    TSM_MR_F_R = 4,
>>>> +    TSM_MR_F_L = 8,
>>>> +    TSM_MR_F_F = 16,
>>>> +    TSM_MR_F_LIVE = TSM_MR_F_L | TSM_MR_F_R,
>>>> +    TSM_MR_F_RTMR = TSM_MR_F_LIVE | TSM_MR_F_X,
>>>> +};
>>>
>>> I am not sure whether we need so many flags.  To me seems like we only
>>> need:
>>>
>>>    - TSM_MR_ENABLED:  The MR has been initialized with a certain algo.
>>>    - TSM_MR_UNLOCKED: The MR is writable and any write will extend it.
>>>    - TSM_MR_LOCKED:   The MR is locked and finalized.
>>>
>>
>> W/X are independent and both necessary (see my previous explanation on
>> "X w/o W" and "W w/o X").
>>
>> I'm not sure if there are non-readable MRs. But theoretically,
>> applications inside a TVM (CC guest) may not need to read any MR values.
>> Therefore, there could be CC archs (in future) that do not support
>> reading all MRs within a guest. And because of that, I decided to keep R
>> as an independent bit.
> 
> [...]
> 
>>
>> L is to indicate an MR's value may not match its last write.
> 
> "L" doesn't seem to be able to reflect the MR value is out-of-sync. :-)
> 
> What does it stand for?
> 
L stands for Live. It indicates to the TSM MR core that the value of the 
MR is different than the last value written, hence should issue 
refresh() to read the value back from HW (instead of using the cached 
value obtained from the last write).

>>
>> F is for CC guest to expose (pseudo) MRs that may not have an associated
>> hash algorithm (e.g., `report0` on TDX).
> 
> OK.  But my thinking is such MR actually isn't MR at all.
> 
Besides Measurement Register, MR can also stand for MeasuRement. Not to 
debate what MR stands for, but this patch aims to capture/expose all 
measurement related functionalities. `report0` offers less understood 
yet important info beyond measurement registers, such as CPUSVN and 
measurements of the TDX module, so is considered within the scope.

>>
>> LOCKED/UNLOCKED, from attestation perspective, is NOT a functional but a
>> verifiable security property, which is usually implemented by extending
>> a special token to the RTMR.
>>
>>> The TSM_MR_ENABLED may not be needed either, but I think it's better to
>>> have it so that the kernel can reject both read/write from userspace.
>>>
>> I'm not sure what a "disabled" MR is and its implication from
>> attestation perspective.
> 
> I was thinking from the perspective that userspace may only be interested in one
> particular MR.  If that MR is not used, I suppose it should have default value
> 0.  But I was thinking that "refusing userspace to read" may be better than
> "returning 0 to userspace" for a particular MR, if it is not used.
> 
I'd try not to predict what applications need but focus on what the HW 
offers. HW features are usually motivated by specific usages, but their 
actual uses are usually way beyond.

Moreover, the traditional Linux file ownership/permissions can satisfy 
this need very easily.

> But from attestation's perspective, I tend to agree with you that "disabled MR"
> may not be helpful.  We need to send the whole attestation report to the
> verifier anyway and the verifier should only care about whether the MR values in
> the report matches what the verifier knows.
> 
>>
>>>> +
>>>> +#define TSM_MR_(mr,
>>>> hash)                                                           \
>>>> +    .mr_name = #mr, .mr_size = hash##_DIGEST_SIZE, .mr_hash =
>>>> HASH_ALGO_##hash, \
>>>> +    .mr_flags = TSM_MR_F_R
>>>> +
>>>> +/**
>>>> + * struct tsm_measurement - define CC specific MRs and methods for
>>>> updating them
>>>> + * @name: name of the measurement provider
>>>> + * @mrs: array of MR definitions ending with mr_name set to %NULL
>>>> + * @refresh: invoked to update the specified MR
>>>> + * @extend: invoked to extend the specified MR with mr_size bytes
>>>> + */
>>>> +struct tsm_measurement {
>>>> +    const char *name;
>>>> +    const struct tsm_measurement_register *mrs;
>>>> +    int (*refresh)(struct tsm_measurement *tmr, const struct
>>>> tsm_measurement_register *mr);
>>>> +    int (*extend)(struct tsm_measurement *tmr, const struct
>>>> tsm_measurement_register *mr,
>>>> +              const u8 *data);
>>>> +};
>>>
>>>   From the description above, I don't quite follow what does ->refresh()
>>> do exactly.  Could you clarify why we need it?
>>
>> I'll fix the comment.
> 
> Thanks.
> 
>>
>> Basically, refresh() brings all cached MR values up to date. The
>> parameter `mr` indicate which MR that has triggered the refresh. On TDX,
>> the 1st read after a write to any RTMR will trigger refresh() to reread
>> all MRs by TDG.MR.REPORT, while subsequent reads will simply return the
>> cached values until the next write to any RTMRs.
> 
> Yeah.  I also think adding some comments around the code using pvd->in_sync
> would be helpful, as I mentioned in another reply.
> 



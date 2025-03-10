Return-Path: <linux-kernel+bounces-555143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3661CA5A60B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B793A66DC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E4C1DFE11;
	Mon, 10 Mar 2025 21:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDdxOBFU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215891DE3D2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 21:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741641479; cv=fail; b=gCDTyuwYtsnT7iQtWcBcq8zGDVLVWsPs1x9z5CoBqI85a5UZ4veAEeISLGsDendyfwQgbAxEnI8uVNFqEQbjco458eddiFQtGlML47LFKO7Dr59LZR2Xpry8Whb2oFu99KmsKs+opIIj8V3287H/KmBXnqAONrwXAr+C+9gSZjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741641479; c=relaxed/simple;
	bh=4DFGO0s6VD10YOSIY28RP2XH5C8MfMxt4B/wpReIYSw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MQbgt7zwx5fUh4+7uLGUSgqlhV7KHXBSs414GNMhe9IYMdAbpILB/S05tysYhFE/O1qlaGe0csj3FfYgLoVpv4rshZjB4NH3O17nu73QvlZ5GiKsdVs6II2rd6wnCvX69GP8dRJv8fTOIJUNZSw5QDreUfKxmz/06eOzw2vv1+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDdxOBFU; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741641477; x=1773177477;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4DFGO0s6VD10YOSIY28RP2XH5C8MfMxt4B/wpReIYSw=;
  b=TDdxOBFUKNMXQ80tCJAZQXQYHsPZy8mjNTXzzy9jbtI7E9zZf3lGlb/N
   oy6SXbZwXfl2lSmEfUYlbvlGeEgR9bp0rL0oFoqa+F7bVPWqPTXnsQx1b
   Y18PDVwGSh5kaRyEwv65dhj5w62lvFRPacCsKYgFRXRnjx37eFO09kYL4
   8K4vU5nJcUXfqsemMNdqnQpMOultmz0eRGpFY4Id+KHfQrmztSg42PfNL
   upNBn3PMTNh9K+ICjKmb35qb93hlCUm96wFCQgD15xBd6V7N3myCpl/fv
   j9bNU+P0Uf5Y28UaBN3bCfqcUk8n5rhFboJGlGXx2H/AxvzocPBRCcuiq
   Q==;
X-CSE-ConnectionGUID: SmC8SUnJTsOLamvJMu/CoQ==
X-CSE-MsgGUID: uJaDWV91SWOcGOT5S1ASag==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="30233722"
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="30233722"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 14:17:57 -0700
X-CSE-ConnectionGUID: yaP5h+YbQEO2/jJA5IaRcw==
X-CSE-MsgGUID: yEa41nEtRUeecKRCdJ7E/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="120320437"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 14:17:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 14:17:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 14:17:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 14:17:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxvy+u38vzacFdmlisrcHvVq/saFn+uZAkK5pBn94eQWUuDJY8mF8HqTjufkSo6r04zO8RMSikqPa/a5pJEUt+67l36XZgsEEoDkt6f5gTRwt3AOtgqg1+VWKcQXecDtyqQxTz8INivvXh7zNWBOnfSpP6lUTNLSyM/CmYcaiWd3/ZjewZKix4tizcSr/GsBQye3huaidjA2sMnnMWmQwXIqKvTEq2L0baqogIhjI4N3vr5xQblKILHz94HYcNIGK3xTuZzVFNfYrWmvgGbFPVF8aKNZrWnLrG9pT7J0LVBsewZIVWqJm7CGX2WbPate+8PkgXixIY6XAU6tZ5OoHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SMxaU6H2mglj9YBjNRGBTI4KaqY2jd0lULdaNLMFHY=;
 b=Vkuuk1Lk4IIBMNALavixNHIM6QMj555U2SAAicJ/khEmzfjdk7BmBBfiKIZWgAmJL/eM/0/R+/+DhkTDev74QsKzHv3SjuP2lTdwMQk7wM/L6xX0Rf6Di/ij8eC2buxUqdiwWKEHw2RzbcACSwhInT1AH4e8XmFGvS17G+DxnnOmtQibSzd8JeIA8nhJGU9zCJsTUtEDscrcUIakr/XSEnZlkCsN3LNpg4/EPjYsoimXMSJ6oLau1akCf7fmMJ3gG2lPwJRMmoQHcl7TRvf2R4tST24rVvMb1TfAo2bqsBIlgSG8yHuRHECYfK2dIMiC5Jmajalhwd1EdHH8yEGyYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by SJ0PR11MB4975.namprd11.prod.outlook.com (2603:10b6:a03:2d0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 21:17:53 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 21:17:53 +0000
Message-ID: <6cd8d37e-19bd-4fb8-8b91-e5b2c5f6f7e7@intel.com>
Date: Mon, 10 Mar 2025 14:17:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [morse:mpam/move_to_fs/v7_bare] [x86/resctrl] 0021800a46:
 will-it-scale.per_process_ops 18.4% improvement
To: kernel test robot <oliver.sang@intel.com>, James Morse
	<james.morse@arm.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
	<linux-kernel@vger.kernel.org>
References: <202503102156.d70c4800-lkp@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <202503102156.d70c4800-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:303:b4::17) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|SJ0PR11MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: b7839c38-b647-4d60-84aa-08dd601904f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1BidVdkVjU0Mnpqb2puNnlPSUdRVStlZ1Z3NUNuSzIvVngxNG1FMk9pdURk?=
 =?utf-8?B?MzFJeFJpd3Blc1Vjc0ZFNFYrSGEyQmNHWTlTVUNqS00yZUNrU3BaZ3hRZG9v?=
 =?utf-8?B?ZVZaRHZMQTJPTStpNlBSWldzK0NVK3J2SVlQUlAzVEJONXJ2bjB0SXJDbGNB?=
 =?utf-8?B?cTJ5YTRmR1BuU2xncFFQdC9TNDNHVUltS0orVHFNQW5pQ0h0Y01IOFlnZVVI?=
 =?utf-8?B?MkdENzkrR2FpN0R3cTllRXUxMkhSdzhORGJOUXRscyswNHFjTFJLNUVVZ3g0?=
 =?utf-8?B?V1RySUF4QUNtNWl0RFB3dkZ4N2NTV1YyUGpxdWNIdkRuSnJiMkpjM3VLRmtW?=
 =?utf-8?B?bXBhYzJabkFSY1AwM2tpS05mQXgydXFibXVDZFpGK1FENmt6c1RvcVhRMEl3?=
 =?utf-8?B?R2N2RVBUMklReFJqR25oOGc4Q0VaR3A5cGpkWklHNjNWcjRSQjgvd29yZWdD?=
 =?utf-8?B?M0lXL1l5UmtTRUphQ3Q5NlRJUFZ0dTIyclM4cFZQQS81OFMrK3lMcE80cVdz?=
 =?utf-8?B?V3Zhd3ZtTGdBUmYwbXdhQ0grUC9oNVBQdHRqK05uTHBKYlRscG45N0d6MlN2?=
 =?utf-8?B?K0pyWWxxUEg3SVpvaCtXTXpvRGNJSlVWTTEydU1SQk5jVUUrWXdRVmV2eFFG?=
 =?utf-8?B?aEY1MDdyU1pxQ2tZTjBZSjdSRys4SElneXdUVU9vR296QXMyT1Y0czVWSkpN?=
 =?utf-8?B?ditkWlMrcCtiQ1BlZ0JBOTQxK08wZys4UnhVRmlLWGx3L3U3WTV0bjJSYXVq?=
 =?utf-8?B?c3Z3a0tub1RQc2NtQUY0Q2hxN2JEd2xsNWJMSmxEenJkR205eFJvREZzbE5t?=
 =?utf-8?B?dFV1MjJWK3NMQkY2QnZrZVVubVk5RTJzOVFLWjFBSzFRL0JnMUpOVk9QTnNj?=
 =?utf-8?B?MDlaNnV6YlNEWkhvQTVHcnEwc0FqMkFzUFZaYzVGemd1ampFM1A5QXVuM3Iy?=
 =?utf-8?B?M2hhOEVYcXBFRDZGWVV6NVV5eWIxcEpSZEtIdDNZUEt1ZTN6b2RNTFF1N2FN?=
 =?utf-8?B?SG9Ub212ZTVJZjd6V0RraHd4ZDNobTFZaU1Jd0JsNzZhU2JBK1o2aGVQaDMw?=
 =?utf-8?B?RGVHRGZPbFZoa0tXMWVCRnBWSElIT3VtTDdwb0dWcXI4NGRFY3IrZElXRytI?=
 =?utf-8?B?NGdCU245RC9EV1JsVGpYeE5XbThXRXZOMnhHRmtBbERteTV0dGFTY2g4OURp?=
 =?utf-8?B?ZVh3L2FRVnh1NjF0cHFveFFhZ09INU5iSmxYSDhrMjd1Um9oOENmYjdLU2tp?=
 =?utf-8?B?Sm9zeXltTGM2Tm1FaE1xVWJock5nOHFHclB1U0JwYllmRi9LRFFjQ3ZGNjUx?=
 =?utf-8?B?eWlaVGV0OWE1cW5oRU00OEN0ejRRUG1sS3dTUDNLRW5BTXVQK0xJN0ZWclZP?=
 =?utf-8?B?R2FSU2dyL25VamVhUC9wc3BLWlVOcFhlT1A3dUlEQ2MwQ2dKb0I2N0VSbW5F?=
 =?utf-8?B?N2NTdTI4N1QvY2EwZWRJOXdXMzVUTXJiZ2tBUktLV2cvM1l5UDJwTlhYaGN0?=
 =?utf-8?B?R1ZnRTFOaVkzY3lwTkhiUVM3UFVvTHQxelVOMTNTSDZrN3hYckdBZHVOVEVK?=
 =?utf-8?B?TWFTVmJZTUtnUWg4QWpiRzZ3WE5MalF4RzBhWmlqbHN5dURTTGV4L25zMkJR?=
 =?utf-8?B?QmtWM1lWUEYvcnJZV1g5WTNrUThlWVNHZmN6ZENkZ3FMVEwvZS9HNWRObnpq?=
 =?utf-8?B?a3krY1IvZFVOQXFqMWo0OG1GekNDcFIrRTFQTzFCeXdCbGxwM1VBS2pYU3Av?=
 =?utf-8?B?VFlWZWFCc2k1VTdhVUhUM0o0NGRZS2o5SjAvVGxLQ01KOWF0OXgxbTZnS0NJ?=
 =?utf-8?B?cVRRdnVwM1F4cmE5ZDNiQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0pjNHA3Uk5VWCtPT3I2RHgrYW15cURyRFh5NDcvNmF5TGxhbGhTL0lHTTIw?=
 =?utf-8?B?d0U4bXJJQ2piKzR5Ri9Fb2Jrb2E3bXJ6N1QrWEtOdytPcmM3SFhxWVdVUWZD?=
 =?utf-8?B?RXBJbEh1b1p0TGRFMktRTUhHUVZwY0NjZlBtOUNWWGtFODU0OHdwYnc0SDFa?=
 =?utf-8?B?dEtNNmpkMWxMU2JsYmV5cnlUQkxOMk5RRUgrM1VhNlh5VHRuL0tUWVMwSVF6?=
 =?utf-8?B?M1VQNHI5b1ovMUptZFI2NUVpT09UVHpVaTM4VlQvdWhlMnRNL1FyUkFwZ21r?=
 =?utf-8?B?RHc5RVQ4TWlldXdBSkhLNHl4eTBYSlJQRm1LUHVwSVVWMXpiL1BGWkY4T29P?=
 =?utf-8?B?QXRHMGxQM1cycm1BNnRIWEE0SjBTVlRoWVlvZ0xuOGNnRVVCNGRZdjdVOUhC?=
 =?utf-8?B?MlJveDVaRUV1S0UzdnI5WGdCdnNmS29RbTNzMlU1RHBUd0h5aWwvQnYwSUNI?=
 =?utf-8?B?UFdacnYvN1J1SHQyemtDUWlWYVJvaUdKRml6T1lJbkY4RysrbHRhMjBWcDVr?=
 =?utf-8?B?UStCbVBCMitwbzkrUTdjR3c2U0pYWUZla29oaXZ4WTI1VEZSYUprVjhpZXRW?=
 =?utf-8?B?UFdwV25TMWhMMjczYTBRSmFGSTdmbTArVENhM1AxdVdJcVl3MVBZNUJ0eEtH?=
 =?utf-8?B?WUhGSGJENzZRK2NmeEE2WU9aTmIyTDkyWGM3YnVVOTZzTGV2UzNHbEg4RlR1?=
 =?utf-8?B?N21IUnlsNjI2dFd5RTJXY056Wk4wUFA1amVzS1N1UlJIUk5WTDJJSGZmdFZE?=
 =?utf-8?B?UVNncmJXbkg4dUZrTnFwb2E1QlJSb25nWitxSjZLUFlXbmZMS09ldUtwRnVG?=
 =?utf-8?B?TkY3cWxMRVllbjNrVmk0dnNGMldETXJwdWFBSjNNYSthU0o0dnNaQkN0Y2o1?=
 =?utf-8?B?enAwR1dRRktzaUdRbVM0QWt6S2xHQklaVUNwZFJuMlpLSVNZd04rdFhxS1Y5?=
 =?utf-8?B?K09wWklQNXVmcXY5TjN0WlNZSjNDMDhNRmtvdzhVYWFxZXJxdlFtWGhwbFhY?=
 =?utf-8?B?Y1J4K1hydVdwU0xsQ01mQjVRQVIrUjk5MmN6K0UyUVV3WjlHVDZwbzRHMVI4?=
 =?utf-8?B?cjA1akJHN250Y1VxN3d1K3llZWNEY2tiL1Q4bWpXMzVBQTgycWIvb3BqeWxQ?=
 =?utf-8?B?YkVWTVVVOUpLL29BeCtuMW1Sc3ljdDVCczljWmdGVzN6bk9MWEZmM0hLamVQ?=
 =?utf-8?B?anNubTJPcUpaSlMvS3F2Z2hRWFdGVXEzaDE4MDN1aVVqZXd0dmthN2JVQndC?=
 =?utf-8?B?aElVeTN1V0x4dU0xSFJQUC9ZSzdnWHc0TXIyVlpNYUc0cURFVnIyOGc5Q0ox?=
 =?utf-8?B?K2JKNUd1b2RjNi9BY05wRjlEVy9wdGR3ZVkyME10WGdvbWJoMnJVbkxnMzBr?=
 =?utf-8?B?M0JPa1ZkKzZkSXltNXBsQVRYdm5mZ04xRTlUcjFwV3BvcXk2bS9lRU9TMGd6?=
 =?utf-8?B?M3pCa0ZVVXBKcEFHRk1yTkIyMVFtOEFUSGtJOE9zM25walAwUms2cWIrUS9S?=
 =?utf-8?B?dUswWExKb0U3MVdvdEtRa3lJa1FPcGp4QU9WbG13dnVhVDZGUlY0RXU2M1lp?=
 =?utf-8?B?MmorMEI2VVdsYTJhclpxNEIxeERIQldRdExTYjhrVTZST3hzQldZbHd1cGE1?=
 =?utf-8?B?aXllQzlBVEdhb3dJbjM0MmlZei9zUEV4VEsyalN4TGUwcWFMd0tuaHRWMHhw?=
 =?utf-8?B?bHhMY1hlSXN5WHFCaGVRRW5ESlI2VG01bWZFb1VMYXhyeHoyVnJmMHFNU1Rn?=
 =?utf-8?B?bEdGNUxqWkFELzNVc3ArTjVKdkNFZzFkYmdkTlBvZlhtNWs0V25BekN3NU5F?=
 =?utf-8?B?cWEyTWdCR3FzbFF2VitHWFNMMk1RZ08wdDZRc2EzU0JlMVg5SGY5TS9oTlM3?=
 =?utf-8?B?S2JIWGM0bFl2OThVYlZDbkZvMEJOZjZoMk9rRmlGd01FVWw5Wk53UmtqcXdG?=
 =?utf-8?B?dS9VTXh3QXpQcHJac1dSaDNvM2hnVndxbXg5d1ZqUW1TblZzRDNPRVErdHVE?=
 =?utf-8?B?VFJWa0Vmdi9ROUE4WHhjMmN0VDVFTEwxZVNaMk5IcFJaV0xjZWdKaFVRNm9r?=
 =?utf-8?B?bUJYaWhpYXh1Z1NWbTdlMUgxU2tIU2FpWXdOV2R4WTJoSXB4Lzh5MThiOUdk?=
 =?utf-8?B?VDJHOUhUSkV5S3hYdkkzdmpBRUpJSlM3ajkzM1BNZmJmZXlpaXZtSDhob09P?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7839c38-b647-4d60-84aa-08dd601904f1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:17:53.1648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXyTQP9WbYGcGqfoCsnqBb46EGeGFdyJiJimkMpRe7yjV233bBSp0cbm0/b1/+bOjAeiELPf77u8xyY7Cp747kZuzAxRXyMLxmqbOuyJ/KE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4975
X-OriginatorOrg: intel.com

Hi,

On 3/10/25 7:06 AM, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 18.4% improvement of will-it-scale.per_process_ops on:
> 
> 
> commit: 0021800a465d495a536265c52f8a031da43948ed ("x86/resctrl: Use schema type to determine the schema format string")
> https://git.kernel.org/cgit/linux/kernel/git/morse/linux.git mpam/move_to_fs/v7_bare
> 
> testcase: will-it-scale
> config: x86_64-rhel-9.4
> compiler: gcc-12
> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
> parameters:
> 
> 	nr_task: 100%
> 	mode: process
> 	test: signal1
> 	cpufreq_governor: performance
> 
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+---------------------------------------------------------------------------------------------+
> | testcase: change | stress-ng: stress-ng.usersyscall.ops_per_sec 18.0% improvement                              |
> | test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory |
> | test parameters  | cpufreq_governor=performance                                                                |
> |                  | nr_threads=100%                                                                             |
> |                  | test=usersyscall                                                                            |
> |                  | testtime=60s                                                                                |
> +------------------+---------------------------------------------------------------------------------------------+
> 
> 
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250310/202503102156.d70c4800-lkp@intel.com
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
>   gcc-12/performance/x86_64-rhel-9.4/process/100%/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/signal1/will-it-scale
> 
> commit: 
>   a13ae432a6 ("x86/resctrl: Use schema type to determine how to parse schema values")
>   0021800a46 ("x86/resctrl: Use schema type to determine the schema format string")
> 

It is surprising to me that these commits make a difference in these workloads. I searched around for resctrl in
https://github.com/intel/lkp-tests but is seems as though it runs the resctrl selftests only and do not
use resctrl as part of any tests reported here. From what I understand, by not even mounting resctrl, these tests
(a) do not exercise these code paths, and (b) do not use resctrl to control resources allocated for these workloads. 

Reinette


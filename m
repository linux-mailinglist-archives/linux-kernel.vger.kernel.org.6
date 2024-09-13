Return-Path: <linux-kernel+bounces-328803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DE7978912
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50551F23918
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E837146A93;
	Fri, 13 Sep 2024 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBmiqoej"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961CE84A2B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726256581; cv=fail; b=UF65XyuEV/PCW85k6bXvGoy9iUGO71JlB92pFDN4BqIg/tVdI+4HgeiECBzqHTEHS0f9POQRGdZQF+jxjFUrFx1AXd5jfZuIZQMDuX6eBUCxXVlrYNhAQW6hJ9I/BLtoqP187ia3UsXpD20A67omwAdViUHSCHN8B6gLNGaMP/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726256581; c=relaxed/simple;
	bh=KT40C3tfmZR6f9h7JmBPKES2yIlilPb5jqW2OClY0as=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QbL40CaB4KJOsee0bBBV2q++G7niLS1s1TbCAfn2XLPxUlH+be/Nu9VGbP389tK/XWnlU9TAZLZnqNH9SriGgXUOV/08j9fvoh73MqN10wFSkiES3qQl9ZNZn/T6Mh8Sp7pnEzquTVfl8LGLkD3kDl8ry/Xcv8Z9CyRF4dbh+PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBmiqoej; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726256580; x=1757792580;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KT40C3tfmZR6f9h7JmBPKES2yIlilPb5jqW2OClY0as=;
  b=OBmiqoejUfSmeo1TUWHfjL8vLzw8i2vGwYTZ+Hj8IM5euz4rykyYS//1
   jL6IeBEBfrO36nkYCi9MF7yJu1/sI7YbCgXLjMcnjdH8cyBzJFW7CEzOI
   HEn4JJtFi9RSBgjkbsydkfvIXnR+NAsHKR5brI4yeyPhaRMKF72Y+RB85
   oLkDkeNIE2ZkNICiudL3lEefLFGpuRtH6Q5sLHMER6LATqlaWYeIQWEhF
   qt2YpRBzerN3blx0CxlD0mg6+dUqTPYXDF+p0eP9cEB5h3J5oBjDWYM4n
   pWh+tqPNl6RDdzjXFQgqR7v8XlyFr2lrrzLT0XDK3k0ffq5+J8gTFKoJb
   A==;
X-CSE-ConnectionGUID: lB6idfPQQ2aHV9V56uO76g==
X-CSE-MsgGUID: dOJPmKk2TOqaUhCC4pyk1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25054883"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="25054883"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 12:42:59 -0700
X-CSE-ConnectionGUID: v5NNq1j3TiOePYJ2ar5bHQ==
X-CSE-MsgGUID: pXPhMXgzSQGL0wz4QcxfWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="98844122"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 12:42:59 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 12:42:58 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 12:42:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 12:42:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 12:42:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MScqkuwaqU/I6wUGK772vBjBHxJoqM9KxRvwPboi3b56MgNw0wEq6pUvmDk/VnkTrHFqKCsA7a4ywO3m3ty3wx6STf2e33tAOf+TDBoqmh0+VBcD3MuBzQ6DJ1hZa9BbDk8A9qRNlVOxLx0dAv//R/iyca9MxkXWnQkpdyshvsprFYHtGpOYlON3kH4m17w1qopTx1H0SqvFOgF9I97H+mwUNkrz5SwTU5lf1vrTTrwbYHrkfU3gG4NcsXJZ4SQTLOwHF3zmE9crWPaMeufsCFDRdZvyMWKUook0QFDGnL7BWX06JZMSxc7QhWmbb594xO1FwCPaDpeBT9fX9oa5Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2ConAOQxrmr7k6ev/U8jNM/tQ5o/QXMObcQzQzrnKE=;
 b=lACH6nmDh4QSzGd5rZntuWoirXuo2b6M0B5dejkS+QSgzs/ZWOR6b4vVy9Xl10V3wBL6fsZWxT+UoSrYo180DeEP2+44+1VeZ3Y8EnoJNToePVVrEXLews82qmyairWz3yoSDyQgO306qldyk5i0/BQ3yUZxRqNHiALPz7HWqVrMz6Wv6IhxDiOjIQbl9ZFMs/b8Q1+t8NYD77E0TmSBW/14lNK2Qzjsz3L6RDWeZDO5DAt17hLcT7YTjoTIxntEENGZpQWHWUJv10E296EfUfJXxkax6uth4ipoCGPtOAwrASou/E9n0rkfu5tQDoEWAVt7VY0RhVJ6Nwdlgase1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 PH7PR11MB6380.namprd11.prod.outlook.com (2603:10b6:510:1f8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.24; Fri, 13 Sep 2024 19:42:54 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%4]) with mapi id 15.20.7939.022; Fri, 13 Sep 2024
 19:42:54 +0000
Message-ID: <09413bd6-97fd-4c58-a793-d1faf71ecf20@intel.com>
Date: Fri, 13 Sep 2024 14:42:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] tsm: Unified Measurement Register ABI for TVMs
To: Christophe de Dinechin <cdupontd@redhat.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>
CC: "dan. j. williams" <dan.j.williams@intel.com>, Samuel Ortiz
	<sameo@rivosinc.com>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, Lukas Wunner <lukas@wunner.de>,
	Dionna Amalie Glaze <dionnaglaze@google.com>, Qinkun Bao <qinkun@google.com>,
	Mikko Ylinen <mikko.ylinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	linux-coco <linux-coco@lists.linux.dev>, <suzuki.poulose@arm.com>,
	<sami.mujawar@arm.com>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
 <20240910170959.GA213064@myrica>
 <B3201E6B-D479-45EE-9E44-868042E04E5B@redhat.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <B3201E6B-D479-45EE-9E44-868042E04E5B@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:a03:255::22) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|PH7PR11MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: 564bc489-8847-47ff-902f-08dcd42c427c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0ZUaFptL2ZrLzF1bkhqYktZRFB1U3V3TE5CcGtiOWFON1JvenRoUWtKMWNa?=
 =?utf-8?B?Q0lzdGNYT28xS0RwZEF4ejRxRS9uTzV1eUI5cGM5NEo2VFROVnpOTDJtZWl4?=
 =?utf-8?B?MlpYTW1Pd0ZkTGZ0QkxiZ1puZzZCYklEY0pYRjU0cDVmQXBBSGpxczNlamo4?=
 =?utf-8?B?eDVvSzQ4WVdDK0tNK0RMUzM4ZmFlL21DYks4R05aRmV2OEx6NE82cjRsTkNy?=
 =?utf-8?B?MzVYei9NREpMMUdETHhTRWdjSFlMeFJhUU1PeE1jVmE1UDZwVWxQWG8zellR?=
 =?utf-8?B?RWJMaFp4TXJ5dFpvbHFWS3ZXYi9nTGdlRFNQLzluTDg0N3RhK2Zpd2w4Q3lM?=
 =?utf-8?B?QStXR0JHUkNhaUNQZCs0bzdwdTZZd0RFZUVQTGVOTVcwbDhHc0FHa2t5dWZY?=
 =?utf-8?B?clJaM3lzWWhuTWdBMlU5WHhOaTl1YUErZ240d0J5T05xQjV6TWtJWnNqMUFa?=
 =?utf-8?B?NzRWc2tlbHAwcWYrcUY1UlgyMER5d3ozV0Y4KzdXVEpvSVJXdmdqUnFCVC9O?=
 =?utf-8?B?QkJGVFg0RmwyZkp3a3g4MkhXQkt2R3d1OFJFc0VET2ZVN1RtUHQ2Vlk4VUhp?=
 =?utf-8?B?b2hHQXRaam9OcDBHTGpLYTZNeDlhajlwZUV4YzVUeUNTY0NOcG5jQWl6ayt0?=
 =?utf-8?B?U1kvajFjSDh6VGpWZEZtcXcvNXpBNUZZdWt3R2xudnd1d1lHbTJGTFFoNjgr?=
 =?utf-8?B?eTJQZ1gvZ0p0MHVNdDlTdmI5UEMrWGRDS25ic1F2TjZWaEtLM1FSMjhtOU5M?=
 =?utf-8?B?WjRwWG1aQnRwbGQ3K1luWnBlNUdhUGE4S3dCWGJ5MXg2ZS9sTGl0TTVFYzBz?=
 =?utf-8?B?TTNxWXFsMzNEaUFFSmpZTXlraXR0Ry9mV09DaVB5WFQ0SkFWSjIyQnlEcUNv?=
 =?utf-8?B?QlIzYzdoMERxVCtVS0tGMzg5YmhLTWlXSFZvL3hpbmtGSEN1b2lLVHRTUUdO?=
 =?utf-8?B?UGxjWW5KOVFsMEpqeWJobUxKM1JSR0wrYXN3b2dxbUtXNE9JeDU2OGRacng3?=
 =?utf-8?B?RUlzZHVGM2Y0T01mdWwwYzlPRTJrRWtuazNVNXQyZjVOT3IrRkdndDlFT3pH?=
 =?utf-8?B?eDBaaVBsSGhLdERlV0h2LzdySUNLVEl3WnlJbnc1djZ3cFlXaW5XR3RkT1lJ?=
 =?utf-8?B?OUdDTWVBMWVqcytLc0RRZkVWVDBIYlJORnRkVTdlQi9YMVNMakFlNkgzSktM?=
 =?utf-8?B?UHhncm1HRzlWVTdBbjY1eFd2V3oxZWxNY0ZCNGw0UnZpSHB5eEFQYXBoRGha?=
 =?utf-8?B?c2FqaHhiYUZrOElhR1RBYzFmVTYvM2tjamdoZUZaTThHZWNSb0NPUFo1TGVB?=
 =?utf-8?B?Tm1KODJlTUQzUzlyVk81VndtNG1NT3ZDbXZxc3daampVUXV3VGxCaHpLVG80?=
 =?utf-8?B?UVliMm1lcWNkL3M1UHdTazhKNDhDQ3Zjd2xJYjhKSjdUV1VySnUzaVRjZnB5?=
 =?utf-8?B?eWs1NW5QOFVwTGtaOTB0NXVuWm5OTHYwSTBVdG5OREUyTURvT3FQK3A0RGYx?=
 =?utf-8?B?QjdWcnQ4Y1hQTU9Yenh0ODJSRzBSUWlpOWJzandCMDdTdFpUbUlIUVdwQzZ3?=
 =?utf-8?B?R2lOc2ZnZTZDNkMycHpXdVdBVkk4UmF4aW81T1IwUFZXRmptOE5oOGM3aUZm?=
 =?utf-8?B?TndDbFdFWmtzRkxrem4rWkNmOEo4VVgvNTBiMG81Wkprb1ZRczNHMlVrZXRN?=
 =?utf-8?B?dDNaZFFrMVI5eWZCakFFWHcyOHNSQzVpTUhaS2N4MjkrNnRZb3ZNVDBvUkg5?=
 =?utf-8?B?MWl3dGhjbzk3RVJ0S3Z5WFdDUjgzTUxhaUxvZGdrOXVVVG40RUdHcG5BdW9j?=
 =?utf-8?Q?uohhCkfkI7BOoEtiAkWe+sKsbqlbRIh4b0m4c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3dLWTdIOGFDSEhCR29yMWZ3dXdIcGFQdWU0QWxzVXZ3Q2FpNjQ4QVVNMkly?=
 =?utf-8?B?Zy9MUzVuOG5tZWJESlI3S1lDb1NEZkpZaWo4NWl4TWxldVUwQ3pJUjYwd2xD?=
 =?utf-8?B?d2pXSFlyR1dETzRybmhFdGVrZ3JTby9ySm84ZmxKRSt1dG5ST2d3NS9HV1dU?=
 =?utf-8?B?YktpYTd6VG9QRDluQkI0d2kyc0RYQjBqWVBxOU51RnVRQURNbCsxRENzbEcw?=
 =?utf-8?B?V2NrY0J6K3dBUVBYdkdYNzJLUUVYbVhPaUcxb05qZW9mQmVZb2plSlRxY3Rl?=
 =?utf-8?B?a0hCeGJ0R1pBWjVxbllaZmpwMkxRWm1XMVYwbWtUS0N3dXkvcU9wU29weUVo?=
 =?utf-8?B?SlJESU5RMnVrVFZFZlJaZDZoRHZvK241R2hLZC9tSkdzdG9ybmVpNXk0WERW?=
 =?utf-8?B?dFpWV3VRVjg3VmJSZmo2SmhWdW9nUmwyRk1QSHpEU3BsZVh4SVhsd2dsZkpU?=
 =?utf-8?B?VXpWQ3k1WGdxSUVSS1N5ME9jd3cvUUhpd2xNMStkWi9rMzZXVVlKSXVHcmYv?=
 =?utf-8?B?b1hHZWdYL3dVS2VzbWFpN0ZuTWFqd2M3RXBVN3l2bklMaS9iNzFjaHpqL2Vv?=
 =?utf-8?B?U2p4WVhLOFN3K2VwMytpakRkRjJZYklVb0gvVCtKcXhzMmVEZC94Y0R3bHFU?=
 =?utf-8?B?SkJiL2ZKOC9DRlQ0dFFSTFg3bllCaFBWOTdyd2FzRXNJYzRpTjJhYndsVllu?=
 =?utf-8?B?RzE1b29vSExDb3lHOGpTWjh6L3NUb01EVGJzTWdwT05hZ3hHUVRBeDJJNkY0?=
 =?utf-8?B?ZDNpSkw2VkFUelBaK2dBNlI3dXgrZ2hPZzRIN2JKWEovY3dseDhxQmhObUlU?=
 =?utf-8?B?MWdsQjhEYnFXZENyVGZTQWlvbnd2dUJNTExVU3RLZHRCUUxyRnlvMFphNXVZ?=
 =?utf-8?B?bW5UM2wrVGd3MkQ4emlRRkFsTC9PSkYwZ0dlR2dwY0VLYk1NYXFoUFRmanhm?=
 =?utf-8?B?azE3S0ltQ0Z3MkhYMTlMaTdCZ0VWMlg5QUhOVjh2M0NZOTFtWXU5WEtoK3dG?=
 =?utf-8?B?cjFXSlRNUi9aUC9VUkdKbWJ1cXdoeEZ3d3l3VmpCZEQ4NHVLRjJiWVl1azNk?=
 =?utf-8?B?Q0pSajc0eVJwbnFEcVpmdWFuZmRQeGNjdVNGMktCaE5ocis4VU05NjgwZGxv?=
 =?utf-8?B?Q3ZHTy9oS2xLQ0s3UHVDclRNZ1F1bU5JKzAwRm5OZlF6QTdmVEhjMXZTRThz?=
 =?utf-8?B?QWhsanBjYVY1N0pRVTVjcmJOK1pRNDMwa0lpSUxKcmZJektEYnUzREhaTU9Z?=
 =?utf-8?B?ZVVWWnB3WVFOSmtQQUpkOTZJZ0VyTjA3eUdmUzB2emFtRlI1UzJWL01FVUFk?=
 =?utf-8?B?dDRBdXF5TDBjOGRzN3JRRmJTM1JLbjU1YVgvdUhrV0Vkc3d3eDFUeE1EZGtM?=
 =?utf-8?B?LzJUeXRIREpLMFVOZHNmL1hHNzFDaWdPMjJBazN1NUNXbElaM2xUWkUrWENP?=
 =?utf-8?B?d21XOEIvSGNPd3IzQnVzZHRJWHRSNHlSS0wrTnJLU2J6WXhNUUV5RmFVU1FW?=
 =?utf-8?B?a1RWaUJiNThvbDQ5eWJzS00xbnhNVjN2V1hDenFRbmt1NGFSZmlwcUNCNnBY?=
 =?utf-8?B?UFpGSms1a3VCbjEzcU5pcWhINi9IY2V1YzNNTWtYalU5eEEwUVJWS0ZtNEc4?=
 =?utf-8?B?dUNoSEMxVmxKcWk5NysvZ1RxRE85bG1seHRUZGgxeFJ1V3ZiMzd3dHZXRTlw?=
 =?utf-8?B?VnhlbWJzYzJDK25WQnMrelhMSm9FNERqUVRqWmxHZERWZllUemJVSnJkQjFN?=
 =?utf-8?B?Q1JibEdYRUI5aUVVZk9WaDh1aFNmU0JqWmFudjNCMjBiYjhPQUM1ejJ3K29S?=
 =?utf-8?B?cEkyRTE1RmtSWUIxMlQ5ZHVudUp4bkFHZWdPaWdTdGc0TUQrWVlGd2ROc0Vp?=
 =?utf-8?B?QldCT1Jqdm1QWHMvd3hhQlNGYW8ra1pZYjlZa2YrNHNTQmtoUXMrSE9zMnFx?=
 =?utf-8?B?NUozL3lnbTZRR1VOTVlSVHkwZFJsQi9VY0V5eXBxSVk0VG9rOHVGcUhTL3dO?=
 =?utf-8?B?NzlmUUxoSGRrNTdhTFpZSzlzZ3hKcmc0YXpVUG5qVUZ1NlFWM0g4QWI1dXpo?=
 =?utf-8?B?L2tmRjUwWmRhNE9ndE9oM21ObWk2TkJiQzIvRmoyQy8rdTNLR01Yd1JNSlFz?=
 =?utf-8?Q?avPx9G3i5Rb6nacpklHYEpLnw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 564bc489-8847-47ff-902f-08dcd42c427c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 19:42:54.0984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQyUVE3vLzuk8rcRB+zCykHAmypEROuLUHjAkzKQNbCWEUGPp9SBLNEooSl8IBnc/telTa2mrNpZaR5cKxmUTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6380
X-OriginatorOrg: intel.com

On 9/12/2024 5:03 AM, Christophe de Dinechin wrote:
> 
> 
>> On 10 Sep 2024, at 19:09, Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
>>
>> Hi Cedric,
>>
>> On Sat, Sep 07, 2024 at 11:56:18PM -0500, Cedric Xing wrote:
>>> Patch 2 introduces event log support for RTMRs, addressing the fact that the
>>> standalone values of RTMRs, which represent the cumulative digests of
>>> sequential events, are not fully informative on their own.
>>
>> Would each event_log include the events that firmware wrote before Linux?
>> I'm wondering how this coexists with /sys/firmware/acpi/tables/data/CCEL.
>> Maybe something like: CCEL only contains pre-Linux events. The TSM driver
>> parses CCEL (using a format specific to the arch, for example TCG2),
>> separates the events by MR and produces event_log files in
>> /sys/kernel/tsm/, possibly in a different format like CEL-TLV. Is that
>> what you envision for TDX?
>>
>> I ask because I've been looking into this interface for Arm CCA, and
>> having unified event logs available somewhere in /sys/kernel/confg/tsm
>> would be very convenient for users (avoids having to parse and convert
>> different /sys/firmware interfaces along with Linux event logs). I would
>> have put a single event_log in /sys/kernel/config/tsm/report/ but
>> splitting it by MR should work too.
>>
>> As Alex I believe we need more similarity between the interfaces of static
>> and runtime measurements, because verifiers may benefit from an event log
>> of static measurements. For example Arm could have a configuration like
>> this:
>>
>>   struct tsm_measurement_register arm_cca_mrs[] = {
>> { MR_(rim) | TSM_MR_F_R | TSM_MR_F_LOG, HA },
>>    { MR_(rem0) | TSM_MR_F_R | TSM_MR_F_X | TSM_MR_F_LOG, HA },
>>    ...
>>    { MR_(rem3) | TSM_MR_F_R | TSM_MR_F_X | TSM_MR_F_LOG, HA },
>>   };
>>
>> Here rim is a static measurement of the initial VM state, impossible to
>> extend but could have an event log. rem0-3 are runtime measurements,
>> extensible by firmware and then Linux. None of the digests can be written
>> directly, only extended and read with calls to the upper layer. The tree
>> would be:
>>
>>   /sys/kernel/config/tsm/
>>   ├── rim
>>   │   ├── digest
>>   │   ├── event_log
>>   │   └── hash_algo
>>   ├── rem0
>>   │   ├── digest
>>   │   ├── append_event
>>   │   ├── event_log
>>   │   └── hash_algo
>>   ...
>>   ├── rem3
>>   │   ├── digest
>>   │   ├── append_event
>>   │   ├── event_log
>>   │   └── hash_algo
>>   └── report/$name
>>       ├── inblob
>>       └── outblob
> 
> It’s nice to have a similar structure between ARM and x86, but how does
> user space know what each register holds? For example, say that I want
> a digest of the initial VM state, of the boot configuration, of the
> command line, or of the firmware, where do I get that? When using a TPM,
> there are conventions on which PCR stores which particular piece of
> information.
> > Is the idea to defer that to user space, or should we also have some
> symlinks exposing this or that specific register when it exists under
> a common, platform-agnostic name? e.g. on ARM you would have
> 
> /sys/kernel/config/tsm/initial_vm_state -> ./rim
> On the surface, a convention + symlinks could be a solution to the problem.

But if we dig deeper, a conventions will be difficult to establish 
because different users/tenants/applications have different needs in 
passing configurations/policies (or additional whatever). A more generic 
model is to allow upper layer software to specify arbitrary number of 
measurements in the form of name/value pairs. For example, say `rim` is 
the only static MR on Arm but the tenant wants to pass in a policy file 
along with the tenant's public key. We could put the following 2 lines 
into rim's log (more like a manifest because the MR is static):

	kernel.org/tsm/static_mr mr_policy <policy digest>
	kernel.org/tsm/static_mr mr_pubkey <public key digest>

Then, assuming Arm CCA guest driver also understands the log format 
above, it would create 2 virtual/pseudo-MRs, namely `mr_policy` and 
`mr_pubkey`, to expose those digests to applications.

Then say, if the tenant wants the same application to run on Intel TDX, 
whose MRTD doesn't support the same semantics as rim, MROWNERCONFIG 
could be used instead - the same log entries but for MROWNERCONFIG this 
time. The TDX guest would then create the same `mr_policy` and 
`mr_pubkey` for those same applications to consume. Please note that 
those applications are CC arch agnostic (at source level).

During attestation/verification, the verifier is supposed to consist of 
a buttom (CC arch specific) layer and a top (CC arch agnostic) layer. 
The bottom would verify the integrity of the log using different MRs 
(rim on Arm CCA or MROWNERCONFIG on Intel TDX), then the top layer would 
extract and verify `mr_policy`/`mr_pubkey` against the reference values 
set forth by the tenant.

> It looks to me like this could simplify the writing of user-space
> attestation agents, for example. But then, maybe I’m too optimistic
> and such agents would always be platform-dependent anyway.
> 
I believe portable (CC arch agnostic) applications can be done, but 
there's still some way to go.

-Cedric


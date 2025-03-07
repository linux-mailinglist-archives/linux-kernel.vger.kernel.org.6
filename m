Return-Path: <linux-kernel+bounces-551796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6E2A5710A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6C13B8B5C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAB824BC07;
	Fri,  7 Mar 2025 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DKw5oa8Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C0E17B500
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741374273; cv=fail; b=d0sZz8E2eQ58oICT64jzRCyH+qkb957HafVPHkpzNryQ/MXQ+DEC2Wy14aZfA1OxyGqXJER43wnQkuMBTKba3vDekF8Y+nWqh01EF2YE/nZ1zzSfQR6JCyoQgfnoKbOdoAY/cgDXnWSLLXpNve77edl7vUEqJqqAZ2ldyqdnqVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741374273; c=relaxed/simple;
	bh=V8CuCbM0mrwWCRbXZY+K+zJPo1l2Fik1h/VV3JpBwE0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AmUFHkUW7+bDd72ASexoNOGmOzdj5XqRVWd5LEsjzJ3DWIXhyajIK8RPjfXgcz7pjNAbLbhBtVVUYUWOG1jLgqEOCm2PKmuaWO6wKLvw9isHHrFkMay1iFvwdGysfsK1QMyC2aSSepzc8mtAOi5adRycnUEIEtpeOHmsfSiFRn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DKw5oa8Y; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741374271; x=1772910271;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V8CuCbM0mrwWCRbXZY+K+zJPo1l2Fik1h/VV3JpBwE0=;
  b=DKw5oa8Y5iXx8L4ryPpPAcRnoNYutbix6uHBEQGftbAkNf2CrwF6iaYL
   DWEBFV4G8yz7jjyHtD/EHLN0CLGEgLj+daf9+PpWXggVlPxYZH/sUHkqZ
   UF7Zm8LO0jWrRXAjUvqYnxRGzrJivYwpC7PzLROCBLSZ6rit10+hQG4Ko
   te855LiEO025FOo5wExS/WvKqC5vuqJtim3W+Lj6bnDImw2U+O90L+D73
   4vmK5f0/YL30gXJkQzEBMQFEM3dNGwoDut8HayiulIdY65YurAkdJZeNA
   4wbsxj2k9f2IhogNSui5euoTT+903/7eO0CVu9nQNeyl/XTagLAVPH3Zs
   A==;
X-CSE-ConnectionGUID: 2Rl3eqg4S6ayGIPthix/1w==
X-CSE-MsgGUID: jVtk6sEuROWVDl5Di+2v0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42575486"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42575486"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 11:04:30 -0800
X-CSE-ConnectionGUID: pzqS4uJiRRuS9DzJXdKCZw==
X-CSE-MsgGUID: 63BRMufHQ5qilK0KWiI2BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="150203005"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2025 11:04:25 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Mar 2025 11:04:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 11:04:23 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 11:04:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5gAlglGweXUD03QnsURum46uXDs//4mwJbVib34aR0qdKKIBp4DT11HOCRs1jpdR0eQl3XKUi2xeb8yylmnOqI5AS+TXjVWY0GYn3Nu/BapdSclAhwX5kbawekLkiWM2pEnCvnJdZVheOLpprzIIOkCdI+KWyOUpuAUcRSrKURqhpAlfI0tvI8n8gd08YFXxCDlxVQreYS9cIEochwUA5d0dTGXNc+WnphwZSknGk7wNOa/1DNkOq6JvSpc6fVcfMWc0nC6uPYZnE53kDf9ExVUVJAVyHyuERC0/hoBUVOugFkMLRGUffJLxEQylK9H1xvFIn4jhF0Bb7ZEqboi2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3kJUL9pZ7GykAkFWxXof0Qm0iVnxC767ROWvi2q2z4=;
 b=uNKGNXmD4MQy/7wSb0VdeFPUe+s+juqerBMakkXSQuq5zRtIQeXOsw5vBEjUCTBgea/69oiLv6ld4opdfbjm0qvBTUXxPmoDehp/ydejwwxnQeZ/PFn0adnzpzMNGhflvFGsg4RlqXg0Xl80bkW/KR5TxZq5DI9e9lar4G5EwHXod9br+d2LH8MC0ZBwuMRobDQGp8ichPDA9sWG9jGB8f5w5QGwCLvWIpZlhgGi+woAI4v8y9TAUi4/uZLDK4S6e6flUPWGGiE+eqw5VGJmQ6osOTgjs0mzmn4Kr7RRSalmhTSxLygDn6KZSw14iLf1F8VKP+jxw/5BvHu8k5KGPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8024.namprd11.prod.outlook.com (2603:10b6:806:300::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 19:04:20 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 19:04:20 +0000
Message-ID: <6c9c4103-45e9-4fc9-93bd-5d6d48b27d79@intel.com>
Date: Fri, 7 Mar 2025 11:04:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 33/49] x86/resctrl: resctrl_exit() teardown resctrl but
 leave the mount point
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
 Donthineni <sdonthineni@nvidia.com>, <fenghuay@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-34-james.morse@arm.com>
 <053d8a62-022b-4bf8-8e47-651e7c3a2d59@intel.com>
 <0d290ca1-20cf-4165-aa4e-62da582a5461@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <0d290ca1-20cf-4165-aa4e-62da582a5461@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:303:8c::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a965aed-ce3b-4161-c8af-08dd5daaddb9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVpKQlVCeWs4RmF5Wk9VU252cUpKWGlRT214bTJQTkJMWjd5Q05ldHlDMThC?=
 =?utf-8?B?QUlmaDdRRTlMZktMZnNnRW1mbzRESlFXTWtrQXU3UzBQNWdEYTFEZHVhM3BP?=
 =?utf-8?B?L3V0cENJRnhBOFoxS1VTdFp0UmJSSmcrb1h3YkJEVU5jN21LcVBSRFRwUktS?=
 =?utf-8?B?d1ovN3I3cjNuVHIzUStGUXhzQXdwZTZlejJ2M21ubjlQemRyYitZVUZHaXNt?=
 =?utf-8?B?eGZUVlFDZEoxdTErVVRlQlF5M1RRbzVFbEIvbUZ3ZDZsZ2xFYlAyQ3Z4RTQ1?=
 =?utf-8?B?TnhyVkl1eVpZK0pJcjF1dmxNZ2wvMTU2NTlUam11cDJYaVZtSGNpUHNQb1ZY?=
 =?utf-8?B?cEhsZFgzbitZOW8ySnMwbnJlSXprcUt6ajd5NURaNUhaOWVuS2RaWDU5QTI3?=
 =?utf-8?B?OC8rSGI5a3JuWkhmVXhUNlNrc08ydEVjMFlPNDcybmtMWUFua3JXa1d5M0M1?=
 =?utf-8?B?RWNEdGlEeWwyOU43QWZabEdRMXBEYmFkZ2FQRTJTS3NsYVU3R3dsaG9XUS9k?=
 =?utf-8?B?cUF6aXV6ZHJSM3FvRkRvWUZDbGlMcS8vanFDM0lSMmxIUVFGOWhESmZzMk94?=
 =?utf-8?B?Q1htQk9ueW44SjMxZDcwVWRRL282QXhPOUFBMW9GeGpKbmluRG55cE04ZTFZ?=
 =?utf-8?B?eDVFK2d0L1oxR1ZyOW1QeGtFdHFWT3NxckZQaFBBZlY2QlZMQ01kY0o1aFFm?=
 =?utf-8?B?bEhmekpmVkR4SmF1Zzl5T1lJTitjSUhacjFSTll6NUNDbnJwWmp3cGYvb0ZO?=
 =?utf-8?B?OU5ucXRzaVo1WkVrMCsyaTNpSnhiVXNVZ21rZUdXZXBvWTNtTml4TFZNSHkr?=
 =?utf-8?B?VVR5V3gyRnY4cExYd1VzeVdSaGhQb1B3clZzMzlEU2xDZFdtczU2ejNweVVW?=
 =?utf-8?B?emxqS0hnYWhsRXdEMkVYRXNxY1RCeEtlZnVoaGprQ00wYkdjVjNzUUlCMmIx?=
 =?utf-8?B?R2VHM3o0aHJISEJRVktRak9oNXJPbnlKR25sOTB6ZUtyaGQ1NWpWdDNydnY5?=
 =?utf-8?B?UmF4ZmRJUno2dDBMbzBWNHAyT29PY0s1dEZmRU9UN21RUzVjN205Z2RtQlgy?=
 =?utf-8?B?S0hHM3lPR3pNMlN0S2E2d1JjU2M1dWJDeGNEYTcwb05HRER1aXYrQ0NBZ0Qv?=
 =?utf-8?B?M2t5RU5TcVEwYUZDcmJIWnJLMXV2ZTdxK1A2VlpsN2xWRmlURC9JMlhHS1M0?=
 =?utf-8?B?QnlSQWFINHlFOGYwVTRxTU1GOVh5Ly9ydmZmWGxERkdSSXF6QXNPL09EK0ty?=
 =?utf-8?B?Q1YydFQ2OGdFNEVpYU04aDAyM0dGWFZRTnZRZlNaYWhyWXMyVzU3MVpaTnQ1?=
 =?utf-8?B?VGRYOGNSdlBzTktGcmIrbUVyYWk3cENTNFJIVDVOeVJuODlDZDdUV0NyMVF2?=
 =?utf-8?B?OCtrTFZxa0pjZ0lsUk5iVTZEOC8zQzVFT2RWc245TGxlRWVRZFQwVEJzSDRy?=
 =?utf-8?B?VEh1aU9VZlJDaTVEV0p3OXh3bDJiVk9tYzBEVTFrMkk1RitaV2gwRXBUR3ll?=
 =?utf-8?B?aUlodjNONkJ3czJNVTJhNnRlcm0xWEtMeFVJYTd2Q2FLc09MV3FDSExtK0Rz?=
 =?utf-8?B?R0dFdS9aOWlsUE5Pa1pkUkh3WkVUT0ZpaktWWlJVTmpTcFBnMDV2NEFyRFg3?=
 =?utf-8?B?eU1sRkE2Z21uWWk5OVlXandVWHY1c2tpdG04elpQKzREc2dmbkQ5TVFyc29h?=
 =?utf-8?B?aTN6eU9QK1oyWnJSRFN2MW4rV2pncDhzY2p5LzM5LzUzTUFNbmg2MHBKQ3hv?=
 =?utf-8?B?QWxHdDRnVGU3ZnlWRDFkTHJWaVM5dm9aRTF2SWpCeFhwMzZhNW1IbDVaUEhL?=
 =?utf-8?B?RVBZSFhJRDFud3pnRmhkZ25rU01mWHFqMWc3NWI0T29uSy85c3FrVUswWVdu?=
 =?utf-8?Q?gbT1IU6shuuAx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzR2ajdDQXNvVndJL1BOSVpqclIvaDUrdTA4Sm5OL2JqVjFGRkRxeFRtcjBB?=
 =?utf-8?B?dVhyTDhQYmk5enRoYnEwY1lFekdxRDU2Q3EyTjU4dGRtSjh2cEhPMXVmc3dW?=
 =?utf-8?B?dk9HUXk1bVIyamVnekVXaFdNcjlLb0FCQ1R4bnBkOWI4bTZlUkpOYmIrT0s0?=
 =?utf-8?B?RmNkYk1taDV5SXpZLy9YcUFEZkJZZWcrdlBtLzdnUFQyQ1cybTVaZE93Z0dD?=
 =?utf-8?B?N0VEYWZ6L25kakNzdHdIWVhGTmo5Sk9MU2tvNjF1cnBPU2FITlF5dUZ1T1dy?=
 =?utf-8?B?cVlybjNKeUY0VWw3b0hqS01xZ1N2dWVTUnpYanlkQVJNRmNJYWxBUG5YQlBy?=
 =?utf-8?B?d0JtYlo1S0dYODMrdVZpSnN2WGowNzl4TGlkTUpRNDM0TUZ1TU5OSlhPOWxn?=
 =?utf-8?B?aG96ZHdjUk5VTTJFc3N6QzV3cXRxajNPZnRmS0xGZ0dGUWJKMXFGNlM2TUtl?=
 =?utf-8?B?RW1VaGE0cnlhZmFhYVdkTTdrbVQxWGxtd3NXNDQrRGt2NzdXOVBMU0k2dWJT?=
 =?utf-8?B?R3RNUzhPQXdhamhiZmNMdVorTHh2QXkwQWVlWWNRMWRvVEdEeEI5SUs4ZG5I?=
 =?utf-8?B?L09sSVNaZUdiZmN0dGUzS3FDN0NyZ1NuSDJiSlM1MkhSSmxxQWl5cDdUREN5?=
 =?utf-8?B?WXlTWWRzRUFJcFJCTjFXMlp1QkhlQmkxaU54Rnp6N1VsbXZKTHJNMTh6TFJS?=
 =?utf-8?B?SjRLWkVZaERmS0t0UVpkWTVTVk4xRHFnK29TN0ZQaHRWOW9LUXpXc29yOVU5?=
 =?utf-8?B?d0VDSnVwMEN6b0psczVFaXZzNitaNi9YTHpqNUdMRWtFdXVZYWl3dmMwOVpO?=
 =?utf-8?B?S2tTZi9jc0JYMHFyNHlXNE9kbFFjSVFNcVorcW9oUncxTzZMcXhVMmJYNUNJ?=
 =?utf-8?B?UjZLTThYbGtiUmtsZ2hHOGFtV282V25HZnN6S29MSk9hbmNFTFI1a0hWSjQz?=
 =?utf-8?B?UmVGdVFBUDlIRXA5MWVLREltWklhYmNqMzVmckxvQ2xoZjQ4azVoUFhiV0RR?=
 =?utf-8?B?Qll4MGhraUNsMmdUbzJNTUtaMjR2OG1HTGVYV2w1VlBYS0pWQVF3Ly9DaUkv?=
 =?utf-8?B?VWxyTlRSakJkeWRpTHJ6Q3ZLODd1SndtOXc5YytydmtGNHdIYzBpZmlkbzd0?=
 =?utf-8?B?Z1pUbmlKUEJ0QmpuRVpzS2M3ZDBqWFdXam9DOUtzYlZyV3J2RlhXU3huZXNz?=
 =?utf-8?B?SjJEeGNib1pOUTJNZGphaXFHNzJhdXAzY25nRlB5d0g4VHlVRzNEUm1xZmdr?=
 =?utf-8?B?Wjhta3o0a0NQU0NRRHZiTHV2czRNZVdncjVsaEFiYnJUeHczT0I1T2I5WUpJ?=
 =?utf-8?B?VGRxNkkxUW1icHJKQXlCTVhFYXE3bXpSMHVqK2lscmx6MTFhKzFkQ0lWMmZD?=
 =?utf-8?B?dnFmZzBKVVRFL21UbDdqanBzWjJaVm43akUvbmxIai9iTlpWU05Vc1VqdjBK?=
 =?utf-8?B?Z2JPcHQxcGFzV2xEWDJTcXNEL0kveFhJSXpGemlZeEFSeFZ2S3J5bWViWUZ6?=
 =?utf-8?B?U2hvUSttWnJ4VTV1aHVwRDFzYy85RXJXcW5jOUxlSXFYUzdYczAzVDgwZjZD?=
 =?utf-8?B?YTFSbGkyMUVDZ3RrNjhhb0VUNUp3eHB6Uk5SL2NuMmJ3dzBLb05HSVdac0Zy?=
 =?utf-8?B?WXVHVmdxVFd5alowZUVUSUlvSDkyd0cvYTlsbk9VQVd1TnowejV3TGwyVUU5?=
 =?utf-8?B?NU15SmNsd3RkMGJERHhpTDljVjUxZVo4QlZrOU5ncFF5VUxvWk03dmRiUUkz?=
 =?utf-8?B?Zmh1Z0ZjZmsvQmQ3SUFWeS9nWVpHNDJYWFBEQVdIM2VmQk1XcCszdXVHdWdp?=
 =?utf-8?B?L1RjUk1YMEVOZDRNK1BaSUpubkI5WWFZc2xwcEJMWTRTUUNjUHZTNk9aN0NO?=
 =?utf-8?B?cmVoSi9lWVJnSXBJcmZaekxtdXJrMmM5cjVSN3orTWhLWmxxbUNLUjdCRmty?=
 =?utf-8?B?ZlpkUGpqWUw1dWxqaGRtTGQwUnFYSUtZa2tyeThNYnhuK3RjRkE4d3B0V0JL?=
 =?utf-8?B?cG1HMHRERUFFN3BVbXAwL1lRaTl4YnhDNmlPT055TzVKaDZ1cHdHaVNZN0Vn?=
 =?utf-8?B?MWJ0NVhLSTBxTnhKYU9vTytPaWRLT2ovL1VLYVBqQUp5RlJXVDF2azhjcWY5?=
 =?utf-8?B?aHFqVldRa1QybmVOeXo4Vm5kdGk3M3VkOU5OejVFUXRRa0tYM29lbHJXenRZ?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a965aed-ce3b-4161-c8af-08dd5daaddb9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 19:04:20.4165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqiCy9nYCfNXWQ4cH2StTkUOzwl+Xvkq+ovmCIuPo+1aimJvNdsfwMqyYg5tJ0rRkFHtQXhJhU7sDxifquaWr53gt8p99clJtIr3o+vJp50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8024
X-OriginatorOrg: intel.com

Hi James,

On 3/7/25 9:54 AM, James Morse wrote:
> Hi Reinette,
> 
> On 07/03/2025 04:45, Reinette Chatre wrote:
>> On 2/28/25 11:58 AM, James Morse wrote:
>>> resctrl_exit() was intended for use when the 'resctrl' module was unloaded.
>>> resctrl can't be built as a module, and the kernfs helpers are not exported
>>> so this is unlikely to change. MPAM has an error interrupt which indicates
>>> the MPAM driver has gone haywire. Should this occur tasks could run with
>>> the wrong control values, leading to bad performance for important tasks.
>>> The MPAM driver needs a way to tell resctrl that no further configuration
>>> should be attempted.
>>>
>>> Using resctrl_exit() for this leaves the system in a funny state as
>>> resctrl is still mounted, but cannot be un-mounted because the sysfs
>>> directory that is typically used has been removed. Dave Martin suggests
>>> this may cause systemd trouble in the future as not all filesystems
>>> can be unmounted.
>>>
>>> Add calls to remove all the files and directories in resctrl, and
>>> remove the sysfs_remove_mount_point() call that leaves the system
>>> in a funny state. When triggered, this causes all the resctrl files
>>> to disappear. resctrl can be unmounted, but not mounted again.
> 
>> (copying v6 discussion here)
> 
>> On 3/6/25 11:28 AM, James Morse wrote:
>>> On 01/03/2025 02:35, Reinette Chatre wrote:
>>>> On 2/28/25 11:54 AM, James Morse wrote:
>>>>> On 20/02/2025 04:42, Reinette Chatre wrote:
>>
>>>>>> It is difficult for me to follow the kernfs reference counting required
>>>>>> to make this work. Specifically, the root kn is "destroyed" here but it
>>>>>> is required to stick around until unmount when the rest of the files
>>>>>> are removed.
>>>>>
>>>>> This drops resctrl's reference to all of the files, which would make the files disappear.
>>>>> unmount is what calls kernfs_kill_sb(), which gets rid of the root of the filesystem.
>>>>
>>>> My concern is mostly with the kernfs_remove() calls in the rdt_kill_sb()->rmdir_all_sub()
>>>> flow. For example:
>>>> 	kernfs_remove(kn_info);
>>>> 	kernfs_remove(kn_mongrp);
>>>> 	kernfs_remove(kn_mondata);
>>>>
>>>> As I understand the above require the destroyed root to still be around.
> 
>>> Right - because rdt_get_tree() has these global pointers into the hierarchy, but doesn't
>>> take a reference. rmdir_all_sub() relies on always being called before
>>> rdtgroup_destroy_root().
> 
>> Is this a known issue then?
> 
> Its just a subtle thing that resctrl was relying on, and I didn't spot. Thanks for
> pointing it out!
> 
> 
>> Since I am not able to use your test I created something new
>> after thinking there would be no response to my comment and indeed on unmount:
>> [  293.707228] BUG: KASAN: slab-use-after-free in kernfs_remove+0x87/0xa0
>> [  293.714718] Read of size 8 at addr ff11000309d88f30 by task umount/3793
>>> The point hack would be for rdtgroup_destroy_root() to NULL out those global pointers, (I
>>> note they are left dangling) - that would make a subsequent call to rmdir_all_sub() harmless.
>>>
>>> A better fix would be to pull out all the filesystem relevant parts from rdt_kill_sb(),
>>> make that safe for multiple calls and get resctrl_exit() to call that.
>>> A call to rdt_kill_sb() after resctrl_exit() would just cleanup the super-block.
>>> This will leave things in a more predictable state.
> 
> 
>> Why just the filesystem relevant parts?
> 
> The stated aim is to prevent any further configuration of the hardware.
> We can change that to 'unmount as much as possible'. I didn't think of it like that as I
> couldn't find an in-kernel way of triggering a umount(). (and the mount may be copied into
> numerous namespaces)

deactivate_locked_super() looked promising when I started digging but I
quickly found myself in unfamiliar territory.

> 
> 
>> Although, you also state "resctrl_exit() would just
>> cleanup the super-block" that sounds like you are thinking about pulling out all reset work.
>> This sounds reasonable to me. It really feels more appropriate to do proper cleanup and
>> not just wipe the root while leaving everything else underneath it.
> 
> After this discussion, my new proposal is to do this:
> -------%<-------
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 0d74a6d98dba..cee4604a59c0 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3063,6 +3063,21 @@ static void rmdir_all_sub(void)
>         kernfs_remove(kn_mondata);
>  }
> 
> +static void resctrl_fs_teardown(void)
> +{
> +       lockdep_assert_held(&rdtgroup_mutex);
> +
> +       /* Cleared by rdtgroup_destroy_root() */
> +       if (!rdtgroup_default.kn)
> +               return;
> +
> +       rmdir_all_sub();
> +       rdt_pseudo_lock_release();
> +       rdtgroup_default.mode = RDT_MODE_SHAREABLE;
> +       schemata_list_destroy();
> +       closid_exit();
> +       rdtgroup_destroy_root();
> +}
> +
>  static void rdt_kill_sb(struct super_block *sb)
>  {
>         struct rdt_resource *r;
> @@ -3076,11 +3091,8 @@ static void rdt_kill_sb(struct super_block *sb)
>         for_each_alloc_capable_rdt_resource(r)
>                 resctrl_arch_reset_all_ctrls(r);
> 
> -       rmdir_all_sub();
> -       rdt_pseudo_lock_release();
> -       rdtgroup_default.mode = RDT_MODE_SHAREABLE;
> -       schemata_list_destroy();
> -       rdtgroup_destroy_root();
> +       resctrl_fs_teardown();
> +
>         if (resctrl_arch_alloc_capable())
>                 resctrl_arch_disable_alloc();
>         if (resctrl_arch_mon_capable())
>                 resctrl_arch_disable_mon();
> -       closid_exit();
>         resctrl_mounted = false;
>         kernfs_kill_sb(sb);
>         mutex_unlock(&rdtgroup_mutex);
> -------%<-------
> 
> and call resctrl_fs_teardown() from resctrl_exit().
> 
> This leaves a bunch of resctrl_arch_ calls behind, the reason is its the arch code that
> calls resctrl_exit(), so it probably doesn't need to be told to disable things. For MPAM,
> the work of resctrl_arch_reset_all_ctrls() will already have been done - and all these
> calls will fail because the MPAM driver is blocking further access to the hardware.

As I understand it the overflow and limbo handlers will keep running after a resctrl fs teardown
done on error interrupt. As you mention in changelog this work is done because "The MPAM
driver needs a way to tell resctrl that no further configuration should be attempted.".
I believe these handlers may thus still try to interact (but not technically "configure"?)
with the hardware at this point ... is this ok?

rdt_disable_ctx() is an odd one to keep with the resctrl_arch_ calls that remain in rdt_kill_sb().
It may be a candidate for resctrl_fs_teardown() but unfortunately rdt_disable_ctx()
blurs fs/arch parts. What I am focusing on is the set_mba_sc(false) within it. Seems like this
may mean that the software controller will keep running unnecessarily. 

Thank you

Reinette


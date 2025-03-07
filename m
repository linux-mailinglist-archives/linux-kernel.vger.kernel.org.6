Return-Path: <linux-kernel+bounces-550442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A849FA55F99
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899833B1A47
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2286118DB15;
	Fri,  7 Mar 2025 04:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CC6TmPO2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE76C8FE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 04:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741322741; cv=fail; b=K33kK8+tg1XhSMBPOLsXl5pUH4w05gr2Wbe1Kcf42i0Fwt9mld3JSsUj1S9Utdt0qhR8zIZ+mlR3y0oaYBt0h1IqZS+Omxpb1XcwY42wvs5r7W4wUEtSnOjjOwBquNd9S5qtiddmdHV/4gEPqR1yoqxP4gf7HhLmg7quWYRtnrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741322741; c=relaxed/simple;
	bh=wkGV0ZuCAzHRIXICUUKwCVolxq4gIrItRHBq/yx6GZ8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RVvYe69oTDAzLsE/IgWmE7KbT7SnLy/hZgZETIxxTZcklsyRl0CyDvQWCjQ6OJj3pgrEMSwEVq/0CnDsynurwe52FQmGoi4GPYWMe616usk6N0lOtQHFXrGtsfkNslP3VN7W6StOR0Z6QKS7gwSuxbIebDp0GskeM4TnRVfvu+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CC6TmPO2; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741322739; x=1772858739;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wkGV0ZuCAzHRIXICUUKwCVolxq4gIrItRHBq/yx6GZ8=;
  b=CC6TmPO2JIQCxKsKlVEwabNVRsiFRIGnOLPWwp1gGmnnK3Oywl3ZOWkn
   otAAB/e4RAbBGH+hUuGLfKXcLT6I//HYPITIYhq5ezyNPJN+zc5VDGyra
   w0/aZOzTuxfvEas3gCKDYEWqCwzy34oGFBOV0szkAvzr27MdLuCazbpAZ
   rEDtbiJQ1RJ8CCBgRZFWAXiCnsnsGvgZVQghoj/2vqhR40ag3g6yntRkr
   nhY+kllncggihgkPzjMBDSQJBmP0QDCjUaVYsPvP/k/tcYOJn+SThfNyy
   aVlZCAu/fTv56I1GlIMByHoX81spQ69K+Z2t82X/XsLkyjiDSQqfPw7Wq
   Q==;
X-CSE-ConnectionGUID: 98C0rUMpSuWyZXvI32aFDg==
X-CSE-MsgGUID: X9ag1XJBRCixoihtsa+eDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="46017247"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="46017247"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 20:45:39 -0800
X-CSE-ConnectionGUID: g1Fy17wRS3SgkuHnImEBkw==
X-CSE-MsgGUID: C8loSYncS7SKKwp7gqMhug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123406714"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2025 20:45:37 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Mar 2025 20:45:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 20:45:36 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 20:45:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ly+MC6d3KNloPddnhvgMEIZnfuDLDbf9HA5zPluYVBDzZipbZCd6dYchLOD/WEKVEDyMpsU7aSm51gLXo6JlW4KzUA9CV3vhNxy3s4Xfu2utTlRH3RDgtGlTUIJbPTA8xiJui4G8GMiChDoRfayzf99c/NX5Wn3dYZVpIqWdJuY53nMaRWgkkzImZ2YiCyAs/5TBPsHzcKjgfGT57g0WiOhcpiNKK4DStrsYSCy7KFHIRZCLPtAa/2mPuBnUoKAeGM5piQYG6hsnYWnHtdTfl+h4OeMS/uiyFWl4zmAXlMApQG68S+KhEXd/0teZIs3XOt9k+pW4xvVxU0SwfA9Pbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjMNmWi+MTs1ZD+fRqx9dvrDO+kl44kMeHvyrKvtl2k=;
 b=F974YBxtUqpb5+bZu+sQ4Kg9cm/jmcqrHHJOs6QoszVA+Oh/BWtDvH/NnpfVKr7aWfSA62V7C+jvXM/fleSneHz2XT/t1ML+38CY9OY4SPDY/U/IucAGI5GrBcV3yM1coTnCo14YlfQiRfwVF0xuJXjR8WOQmXf0Qy42vTnUF7udOZUXfHHYpDrK9iTGpaZmnKVbbKhE/N/RzLTCUSQlyyaqK4zoiD3qe1LMEcKTokiyq1PBXzHLVJSmUoRAz6oLorVK5kzYEoTzJLiSMGAk7yd2eArAcAy4m6JDcKQzZZv2nYZy1zJfvPtmVRoytPnd2DiOx1Oy5ZZefDXX6X/cqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB5961.namprd11.prod.outlook.com (2603:10b6:208:381::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 04:45:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 04:45:33 +0000
Message-ID: <053d8a62-022b-4bf8-8e47-651e7c3a2d59@intel.com>
Date: Thu, 6 Mar 2025 20:45:31 -0800
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
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250228195913.24895-34-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:303:b5::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: d7dfd042-3f41-4431-baef-08dd5d32e568
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEphV005RGNEVkxoV0twSUdQR2pka2J2eUZINmFIdTI0UGdGbEdubXIxRkFh?=
 =?utf-8?B?RWJxSTg5TGVkbE1xQU9uSDZDd1QzeHdVL0czK1JSdkt5RWJSaklpdmp1VDJU?=
 =?utf-8?B?MC8xNXNjKzR2SURsU1hUd0xvV0NZTUtwTEQwT2FZTStBbzBmQ29uRVZQTzM4?=
 =?utf-8?B?dXI0OEhmbTVDTVFmZWFRQlhDbGxVOHp5OUtwSTYxUFczYS8rMmViS2R3ZkMw?=
 =?utf-8?B?N29tMTJMTlpwK0FIYkpKdFU5Z0lZTzZJU3B1cy9XNlU3WDQ3eEIyeklwdCtE?=
 =?utf-8?B?aHBmY0JxUWhXYmJxWGNNMDZZRWNkNGFQbW9CVWR4SkE1RkZtYWVSeXlwMVRh?=
 =?utf-8?B?eUQxQlordUx1OUtrcjFERS85ZWlBOWVUSHpCMHN0U29kTmZWMjFJbncvdUp4?=
 =?utf-8?B?M1NrdjlYOWw0SlhXQkdJa3Vna3FQTUQ1SEp2dmlOeDRkVStOaUN4QzNvSk51?=
 =?utf-8?B?VmVEcmxKVHpmSDBkUlo4anZZK0QwN0hMM3JzTVZ3cFhzZld5d3hkTFdJL2Yr?=
 =?utf-8?B?eXhMeW1mbWMwUXdyNWdNeXNaSXN0dHh6MTZVcnZvQ2pEeU0rWGxoVjFEUXQv?=
 =?utf-8?B?YzUrTjF1aFNzOHRWbHhqZThFcEd3RUdDcC94dFY1NVZHMDJPaUhqc1o5cG0x?=
 =?utf-8?B?M0ZPaUZGc0I4Q2RrbDMyZkY1ajJKSWNaYmtYV0I1UEpUcHh4NkwzUWlyL3A3?=
 =?utf-8?B?UDFjKzhrcURJeCs4NEpSWm01NlhXNk9XOEVKTHRaNUcrNGUrQVI5SzR3Zzc1?=
 =?utf-8?B?bkpCWXIwak92OURSd3JEQmd5c1JBODU3azBMMmxHNHBHdTJRZ3d4VHRuZUYw?=
 =?utf-8?B?cmNUKytUMjJHb2xnQzdiZHZNb1NMd3BSRHEyRHdUb1BIUTQwYmhvNFJlcVRv?=
 =?utf-8?B?R0JHVTAvZEhSUlBpWVdZaGlQWlJ0bExnYVYvdVZ2SVlKWFZQUVhlQklLdUZn?=
 =?utf-8?B?dmVEdExra3plVlF6WmtvZXJWbFMyVS9Bck5OYTFYV2xyVEdDRWs2QktLSk9U?=
 =?utf-8?B?REQ4S0JGS0h2aXgyWXlWMmdJdUY5SGNPVmhJazE5YitoM3RIcmkxOVptNDlY?=
 =?utf-8?B?NksrcUZJUEwyajFUVjNNQ1pKbjVOdTRDMVRwdkt1am85akFqeHdwdkhFbnJC?=
 =?utf-8?B?K24wTFp2SnpSSjQ1eVZrNjVuK1kxTnRRNlQvWGFCQXptTldobDZya0FXdXVO?=
 =?utf-8?B?Rm0vYTd3TndGTUxqWWFHb2dSbUk3YjFIUGVYN2FPUE9EQXU3cFdKNVluNEk1?=
 =?utf-8?B?UXBKQjF0R2FIVEl2ZTR1c1JjV25DcFFFUFVzSXN0QmgwOTl4TDNXN0dITUxr?=
 =?utf-8?B?OXhaNGU1UmhXbHRzTjFTYVRyb3V3Q0RNQkxqVVVNZnV6WHZsY0ZYV2xPSUFl?=
 =?utf-8?B?Ums2RzZadnpSclJQWFJmM2JpNnlFdGc4bmRwTGQ1Z1I1THl0alhZSnBLejJI?=
 =?utf-8?B?VWhKMHFqNUZLYVBML052b3FhWlZmaGI5RG8rQzhaTnJEQmJCdHI2OEphdWhq?=
 =?utf-8?B?SHVNQnlmSDRIdDJWWEEya0VhbHFrclFTcHNSZ2EwREE0bUluWHcybUNNNWVY?=
 =?utf-8?B?eUVka1Z0aTVYTXh3NVB5MEtRUXpyb3N2N01VU25CNjdYM2hpZHZrMjlUNnNG?=
 =?utf-8?B?ZWtDc1JOZHhGcFBtQWNzSjBzU0FWeW9jSUw5RHZERERoazNNcmJpTzBKdXFs?=
 =?utf-8?B?YkNJQnpxKzIrck5acFk1eHpMZjBhK0paLzdnUmJTclBIN0hUS0Jvc0NsYjVa?=
 =?utf-8?B?SnpjVkgvNUJDQUtpZ3lIdWcxL1RVY1dFenZ3d3ZqVW9DTG1sZVUxajh1SDFN?=
 =?utf-8?B?TXorVXNwcThFeUFHR1pyLzhSRGc5Mnpoc1Z3d1RWN1FGSldaWGdzQU1hL0tL?=
 =?utf-8?Q?VK/AimE7w7lPW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnZhbm8yOFdMNkUvTTlvUjN3WlpXQS9Sc0dvTlJTREJBK1ZVYnAvMHZmd0Qw?=
 =?utf-8?B?TEFFMkZpUk9FdWlQcGlKRitCOTZYVlI2ZjY5Z2kreG44UWN3V0FDNTRkR3hN?=
 =?utf-8?B?NVhkUW5XMkNJazhLQmtjbUY3RVMvQ1c3YnN1a09seGxMZjN2R3JDWFU0Q2N5?=
 =?utf-8?B?cFRKZ004NHZ6djdJaU5LczVGSHAvZ3ZVZWh1K1VpUVhRcFVMWEJBS1A5b2lO?=
 =?utf-8?B?Vk1QMnhoY3hDRXF6MmRTTUNVWHcrdmx2L2FlZzJYM1E4WFVTRCtzakJLWU5I?=
 =?utf-8?B?aFM0alVSMnIzcjR1QTdFK2lTOVQybkY2Wkk2cjZlUXY0amxIR3ZTWUlhbUZI?=
 =?utf-8?B?ZXAzaHFNdm9nZjlaelVndG0zbzJzWlNQcldpemt3TlNoUVRvWHJQU0w2TEd6?=
 =?utf-8?B?QUxHbzBiODlsTmZxT3JmSThLWHZEUGVwb1F2RXpERzl3Vzc0NE9HM0tqUzdJ?=
 =?utf-8?B?SGl2c1lDcXByTllEcHFSVHdaSitEYW1UM2ZldHZFVkh4UjNRaHM5M1Z5YkRn?=
 =?utf-8?B?MDU2M2hEa3hqNzhVNml4N1pmUDBPQjVpRVM4Nmd5ZG1IaGZGQkxudXVEak9T?=
 =?utf-8?B?ckExcHFsTVpzbVdEMUFpK1RjRE96NGZNdHI3Q3BmWU9NL2pKK1BRZ3hHeFJN?=
 =?utf-8?B?b2xMZTdXTWxXRmhTMHZwU3hIRU8zYlZWY2RyUFRyN3JlR0gvWG91UXMzKy92?=
 =?utf-8?B?em83cm9WN3Qvd2NMZHExMHZxcVc3TmJ1TitHNmttTXNjR2FjQThGMm1MQUtK?=
 =?utf-8?B?VTlOdjJyTHZrNmg3L012RkRrdmVEQVpyNFdObi81OUZsNWk2ZEFKQU93WVMv?=
 =?utf-8?B?ZzJ4dHhUSE1pYjVPT1FOUTlJREIzZTFHcUZydHQ0d3JSMjhldEJ1a2tFblpF?=
 =?utf-8?B?ak1QNUhJWWZVbUtwRlNVMnFwT0dzZHhoMUhmSHJTVk96a0pVMlVZYUR5c096?=
 =?utf-8?B?OTZodXBxdURrMHo1eFdKcnBSbVgrUDlzZExmV25SbHd0N0paR1RhelNDTG1M?=
 =?utf-8?B?ZG00OHNPazY5UVNaRkUyODFPOTlPbWJJNFVFbVlzZ2t5NitUV2c2Uy9SN2JI?=
 =?utf-8?B?TE9qZk0vZS9ISGVRQ09ldDZQdmFuQUpqZTZndGNORnJnNnI4YWdMYTcwOHZE?=
 =?utf-8?B?c0Y4L0hsem1CRzBFM0VKOFhtKzhENzVpaFNnVHpRdGxnTkk4Qm9DZ1FKeTBO?=
 =?utf-8?B?UVV0a1NEVHhPL3l4T0U0ZEMraWVneGZyQ3pGSXlXRW51b0s3TkJYeWU2aFBx?=
 =?utf-8?B?VUhBdlNCMUx6MDhlZFB3UXlsK01PZklVZXB4aHFwOGVIZnZoUng4cno2SC9I?=
 =?utf-8?B?WFgzWk5YWWdPM2F4Sk5mMkcralkwSzRidGJWdElkRUR5WHJSNmsveExJRjFD?=
 =?utf-8?B?b0FOeHg2cEl4c0c4RkxoTVdMOU5BQi9iU1BqUWxFL1o3Nnp6S0NrVVBmVW1t?=
 =?utf-8?B?dldrUmsvSzZzUmp6aGUvREYrZ1JkM1pjQi9FZ0J0akx0WFQvT2pZamtBN0R0?=
 =?utf-8?B?ci9NZjY5OVhnNUVyOHNWb0N6ZUIvWTZFaXNSUk9BU3dNVjdsMEthcmRDQmY3?=
 =?utf-8?B?dGRXQUxrS1lsODdOdjF5L3VZWFZ0NHAzUkFuN0VQdFoxOHNYL3l1WWpuNmVM?=
 =?utf-8?B?bTNlVUdSamtIaWRHbG90RCt2dXQ1a1hFR280bzBCUWVkbldGSm5iVUU4SmJx?=
 =?utf-8?B?alprR2FLVEYzUkVlYW14SVVvN0hHL3BQTzgycHNtNDgyYTkyRWQrQ1NFWlRI?=
 =?utf-8?B?ZVlzT29pM1RHL0RtRTk3OUxzcVpkdTUyYTJZS2JoQUsyNFBPWXlaYXgrQzJa?=
 =?utf-8?B?R0oxRjdPTjhpZG9tU0gvZTZBeUNzZEg0RityL0VFTkZDNjJxamgwR1FjMmIx?=
 =?utf-8?B?RkJ4QmJKQTkwZ0VBRDBmam02aGpONzNFaUhPZkFDWlBCTzhRSzBzODhtbm44?=
 =?utf-8?B?bVdBak5Gb3Zyem5QdWJTRTM4c1BscjZLUTY1eVAwQUkzdWRMb1BLNDZvQ1Ur?=
 =?utf-8?B?UEpZNWxKVzRQMTZLMlVURWJhY0hhRmkxUnM0ZTRHS0h6TU44SVY1cTlmL3p2?=
 =?utf-8?B?NXZQcXRKY0QyYUlLbXVFdjZleVZ5aThhUlV4a0ZZWlpXcm1VSGNYQXptTjZF?=
 =?utf-8?B?dWtUZW5NY2tNcVBkalV4WkxOejJYNjlJVXREc0NIUSsxOG53WXl0eE43MFVn?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7dfd042-3f41-4431-baef-08dd5d32e568
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 04:45:33.6594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNCXmpql1p0rM1Qrtcl9LeH4Wm4dARS3cJdtfEiqaARbIlMTzvknCl/dY8xGuibjdn0jsM2WEM2WOXt7sIvml4qONST//lmz7s9d8mwsylE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5961
X-OriginatorOrg: intel.com

Hi James,

On 2/28/25 11:58 AM, James Morse wrote:
> resctrl_exit() was intended for use when the 'resctrl' module was unloaded.
> resctrl can't be built as a module, and the kernfs helpers are not exported
> so this is unlikely to change. MPAM has an error interrupt which indicates
> the MPAM driver has gone haywire. Should this occur tasks could run with
> the wrong control values, leading to bad performance for important tasks.
> The MPAM driver needs a way to tell resctrl that no further configuration
> should be attempted.
> 
> Using resctrl_exit() for this leaves the system in a funny state as
> resctrl is still mounted, but cannot be un-mounted because the sysfs
> directory that is typically used has been removed. Dave Martin suggests
> this may cause systemd trouble in the future as not all filesystems
> can be unmounted.
> 
> Add calls to remove all the files and directories in resctrl, and
> remove the sysfs_remove_mount_point() call that leaves the system
> in a funny state. When triggered, this causes all the resctrl files
> to disappear. resctrl can be unmounted, but not mounted again.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> Changes since v6:
>  * Added kdoc and comment to resctrl_exit().
> 
> Changes since v5:
>  * Serialise rdtgroup_destroy_root() against umount().
>  * Check rdtgroup_default.kn to protect against duplicate calls.
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 2f34b7215679..0d74a6d98dba 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -4094,8 +4094,12 @@ static int rdtgroup_setup_root(struct rdt_fs_context *ctx)
>  
>  static void rdtgroup_destroy_root(void)
>  {
> -	kernfs_destroy_root(rdt_root);
> -	rdtgroup_default.kn = NULL;
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	if (rdtgroup_default.kn) {
> +		kernfs_destroy_root(rdt_root);
> +		rdtgroup_default.kn = NULL;
> +	}
>  }
>  
>  static void __init rdtgroup_setup_default(void)
> @@ -4387,11 +4391,26 @@ int __init resctrl_init(void)
>  	return ret;
>  }
>  
> +/**
> + * resctrl_exit() - Remove the resctrl filesystem and free resources.
> + *
> + * Called by the architecture code in response to a fatal error.
> + * Resctrl files and structures are removed from kernfs to prevent further
> + * configuration.
> + */
>  void __exit resctrl_exit(void)
>  {
> +	mutex_lock(&rdtgroup_mutex);
> +	rdtgroup_destroy_root();
> +	mutex_unlock(&rdtgroup_mutex);
> +
>  	debugfs_remove_recursive(debugfs_resctrl);
>  	unregister_filesystem(&rdt_fs_type);
> -	sysfs_remove_mount_point(fs_kobj, "resctrl");
> +
> +	/*
> +	 * The sysfs mount point added by resctrl_init() is not removed so that
> +	 * it can be used to umount resctrl.
> +	 */
>  
>  	resctrl_mon_resource_exit();
>  }
(copying v6 discussion here)

On 3/6/25 11:28 AM, James Morse wrote:
> On 01/03/2025 02:35, Reinette Chatre wrote:
>> On 2/28/25 11:54 AM, James Morse wrote:
>>> On 20/02/2025 04:42, Reinette Chatre wrote:

>>>> It is difficult for me to follow the kernfs reference counting required
>>>> to make this work. Specifically, the root kn is "destroyed" here but it
>>>> is required to stick around until unmount when the rest of the files
>>>> are removed.
>>>
>>> This drops resctrl's reference to all of the files, which would make the files disappear.
>>> unmount is what calls kernfs_kill_sb(), which gets rid of the root of the filesystem.
>>
>> My concern is mostly with the kernfs_remove() calls in the rdt_kill_sb()->rmdir_all_sub()
>> flow. For example:
>> 	kernfs_remove(kn_info);
>> 	kernfs_remove(kn_mongrp);
>> 	kernfs_remove(kn_mondata);
>>
>> As I understand the above require the destroyed root to still be around.
> 
> Right - because rdt_get_tree() has these global pointers into the hierarchy, but doesn't
> take a reference. rmdir_all_sub() relies on always being called before
> rdtgroup_destroy_root().

Is this a known issue then? Since I am not able to use your test I created something new
after thinking there would be no response to my comment and indeed on unmount:

[  293.707228] BUG: KASAN: slab-use-after-free in kernfs_remove+0x87/0xa0
[  293.714718] Read of size 8 at addr ff11000309d88f30 by task umount/3793

> 
> The point hack would be for rdtgroup_destroy_root() to NULL out those global pointers, (I
> note they are left dangling) - that would make a subsequent call to rmdir_all_sub() harmless.
> 
> A better fix would be to pull out all the filesystem relevant parts from rdt_kill_sb(),
> make that safe for multiple calls and get resctrl_exit() to call that.
> A call to rdt_kill_sb() after resctrl_exit() would just cleanup the super-block.
> This will leave things in a more predictable state.

Why just the filesystem relevant parts? Although, you also state "resctrl_exit() would just
cleanup the super-block" that sounds like you are thinking about pulling out all reset work.
This sounds reasonable to me. It really feels more appropriate to do proper cleanup and
not just wipe the root while leaving everything else underneath it.

Reinette




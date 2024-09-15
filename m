Return-Path: <linux-kernel+bounces-329677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A281097949F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07F81C21C19
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 04:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4938015E96;
	Sun, 15 Sep 2024 04:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H41NJSK6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299A91B85F0
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 04:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726374742; cv=fail; b=LI3oHurlxXoOIIcl1src8rn1OQ8fIHEpD9Ka/jpqlGnyFi3qNqRnRMVnMrVe7CRXyrUfrLYpS5RSlwk1OoIS54bL13hl4PyW2YxP015cWUsFKi3L6ZUDr3PD5JSnsbziN8bcYYDCcRP855SCFMU3jhHSvXm0euakGbz3o1YNJgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726374742; c=relaxed/simple;
	bh=6wkL+LlsDOFctQuvurrcEGVh5KQDznad7nLhCnGE9P0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BAChPbKoWAWbBM+dd2gXqMDzvlbaepojO58MEkgIXUp2BX2oyvVXZ0SQp98OTC/ecHRHFlIARkVW/g5AhazXiwnm5ELCVpjDWi9FWXIQnAbQURTBYBBZ71rtAVEdjQ0FJMVbgEK1qmvwmxEhjsrBSocqzkQIrEFMlOeBzKBgNvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H41NJSK6; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726374740; x=1757910740;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6wkL+LlsDOFctQuvurrcEGVh5KQDznad7nLhCnGE9P0=;
  b=H41NJSK6nf2aOaoCrOy3VsM+Av0nX9S9NGOLeXAnqeWUr+TnUez8mWml
   v8OMc1tityIaimNtuQXf6i5/Ycs4pVZKZe+wy1kZPfpxPxKAk68VWdJUG
   Gt+0HSeFjUfl0L6yqs+wEyl6VIXc3jARyhCYWphST0gP4ZdhKxZNamsNu
   eNQMG66XUwJ6JRTXjLKtwhGpP6iHJ5dg6fpyKuMdLT3dshD8pMBh4mq10
   SReu30yvfUjJHqBFp96L4G03APA6wIsRdlYrGVzgAch4x1DwGi2/niruH
   d3x8YuLouEDUX5jHPiX3YhkXwtLgbuu6nZHEhxy0wm0fR+HAlFIPNDJbV
   Q==;
X-CSE-ConnectionGUID: /d2K6PU+TRqjzXPK2C5ong==
X-CSE-MsgGUID: PHGsyWTpRiavVO5+iWXW7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="25333410"
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="25333410"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 21:32:20 -0700
X-CSE-ConnectionGUID: mrW+bzrYRpaaKNOv90l1lA==
X-CSE-MsgGUID: gcT6YwhBTgC0ZfkannMaVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="68232005"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2024 21:32:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 14 Sep 2024 21:32:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 14 Sep 2024 21:32:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 14 Sep 2024 21:32:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 14 Sep 2024 21:32:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6Ms/fACVKCVPntJsjklnvkB9d9eiSg0baF84q+wcpSPIZJfwpfluOdxGPnliaxfC2iOBD9zAvWYXMx5nDJYt5ZPQVuIuJORhwArsdEbYllk1km/m4gqCc8E+DxiRn8jc6DrwM8KhTFSLsVxYEbv96zE53/1p+sw18qqaAF91e2NiUWzQ9TwChQwE8BbUPGvQx1PKHM2avcs0ZCg0sh/2sPVAnf1yZ0nbHMYkKwrvba8jmE1y1hUWUz01yKG+ytDEg2Mhn5JBRROnJkT/W6hDiOIcIbw9Ubhpg14lbtj7BZ9s6MiUhKrvadfw8yiTt+ufZNwOYuqepbzak5oLeWv5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQDnSGZzFwKGXZaEkCDFs3dQZqLhakGZuGPTpMdYkmk=;
 b=mzuo6rcTNR4mcHJLofCD9rjHleXiwB6dqnQQLR7tL1rdyLHWXWn4XEzQp5/HtiAsNcnpJM45Xbyx81UQUiYExEKlsLlyVYXNjy15hQDYLvNrMwSzGR/oHN0/zNbtAsC22cQd/nER0mdUw5c2FiVOqhu3aTnvw/h9lp3T9LpNSoR3KuO6JDdPCJxVV88eUwXmwmxhYlT/cZqM4mdMsmT+KLtLfTFPGu8Vr07/y0Pxymk/FIj8OqzvcddAa2p9ZU2neOMHYB/SiQxaQ0Y7NjfxxKUDpx/2lj9aP/IPRKWtIEcubh4Ya4nQxe8a3q84JrtPtJflHtBU8LQFtmM4po2rmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 PH0PR11MB5047.namprd11.prod.outlook.com (2603:10b6:510:3c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.22; Sun, 15 Sep 2024 04:32:16 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%4]) with mapi id 15.20.7962.022; Sun, 15 Sep 2024
 04:32:15 +0000
Message-ID: <0c462120-578c-44f0-bc35-c41906646fc4@intel.com>
Date: Sat, 14 Sep 2024 23:31:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] tsm: Unified Measurement Register ABI for TVMs
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Qinkun Bao
	<qinkun@google.com>
CC: Jean-Philippe Brucker <jean-philippe@linaro.org>, Dan Williams
	<dan.j.williams@intel.com>, Samuel Ortiz <sameo@rivosinc.com>, Lukas Wunner
	<lukas@wunner.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, Mikko Ylinen
	<mikko.ylinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <suzuki.poulose@arm.com>,
	<sami.mujawar@arm.com>, Chong Cai <chongc@google.com>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
 <20240910170959.GA213064@myrica>
 <f6b0a1d2-c730-4b20-a8f3-afd9a7cf822a@intel.com>
 <14fc2ce22d224f05f4d382cd22f5242297e9fb86.camel@HansenPartnership.com>
 <CAOjUGWfgYoXBzUB8wFvO5LDq+=t7hAEksu0EA4Dc7FwbmUJp7A@mail.gmail.com>
 <f92766c96c993276bec770e8a255bca6cc46c292.camel@HansenPartnership.com>
 <c7157fb7-b8d0-482b-9ec3-d60179a95882@intel.com>
 <0b334090c4bf21740b19371664ad0d78b66830c4.camel@HansenPartnership.com>
 <f284ce29-6afe-40ce-ad81-b6b2cec9199c@intel.com>
 <cc8f30d105758c06566bab32ad6fdd87489f875e.camel@HansenPartnership.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <cc8f30d105758c06566bab32ad6fdd87489f875e.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:74::35) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|PH0PR11MB5047:EE_
X-MS-Office365-Filtering-Correlation-Id: 62979baa-a5e0-43cd-f1ff-08dcd53f605e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTMxVWFVNEJmSkdTOXQ5MUZvMmkxQk5sNmNLNVRGeVVQUWQvdHR3UVdVNGZh?=
 =?utf-8?B?Y2ZQaGRjLzJSS1lwS3RrcERzWEFybjc5cHFiOWNsZWR1WEdaVmEvajVwZFFz?=
 =?utf-8?B?UU9QbHA5dE96NG4xQzMrQW5CUnhMMDJXYmt4WWV4U1VTek9xVS9RenZUL2FI?=
 =?utf-8?B?eDdaZzlyYmd3eEJmaERLR25MUE5Sb2lvTWp5NmlBRU51cnUyaVl4bXZQUk5Z?=
 =?utf-8?B?N011aHpPZ3ovT1p0WllwZVZNU0NNVXg3VmJsTzlHVHNnREpZSXhMU0VmbGF3?=
 =?utf-8?B?a2RPMUdtOGpzWFlUYlN6a1B6RG1PV0hqVFA2TEVMcnpDS1hlY2VhZEVtNVoz?=
 =?utf-8?B?azE0Umd1cDVLU2gvVGVMK1J4WlpCTFIzTFRpc2R4NFNWdkZWSU9pc0ZXNE5Z?=
 =?utf-8?B?U3RPVSt4TDBwbU5PZHlOdFNuRlZVcEdzcWx0cWV1UXdkOU9UdG9GQm5yOVJL?=
 =?utf-8?B?TXBxNXJRdXFuUnVwYTVyZlNmZFNPcS9RWFJ3SGh3S2NNdTdyL2VoeVREYXZ0?=
 =?utf-8?B?ZkhzTkxVUHAzUzN5dHY5SUJGQ2xiVnFjUktqMWdnTSt0ZDZoMHh5RnVxOEpK?=
 =?utf-8?B?VkhTVlZtU2dLeHJ1eGllT1F4TSt1Mk1sR3ZnUzR4T0UwWFFOUjhOQmROOFZk?=
 =?utf-8?B?VWZZWTF1ZTViTlNveEdHOG5FdHI0RmRGSXM4UU1lcW1vN0FaMVBYQlREYmdw?=
 =?utf-8?B?emFlZlEzb3BReEs0bGZnbWQ1ck9xcTdEbExyQnM0QnJvK3puM2RHRnlCSlg1?=
 =?utf-8?B?MWNQTHhOU2RObEZpb1NrRXltV2NCcmNqMkJNQTlBbS9ndlVaeU9TOXY4R3BX?=
 =?utf-8?B?VmFGU2JncGNVVlJvLzhWTUx5ZGs5WjdGMi9qSmE1U2tUV29DTUd6b1k5YVZ5?=
 =?utf-8?B?VjIrczc1Q3E2bkhvZndlTkN1SmZyOHRtQ0g5cGdCSmZwaGxySEMvNlBGeXdS?=
 =?utf-8?B?VGtOR2k2K3FUR1VDVmN5ejMwSld4ODVDU1NuTGF6c1lvbFB4QnpuVWJtRzIv?=
 =?utf-8?B?Z2V1cGZBWXUxekNIVXg4QnQyZW1LckZ1UzYwcDVTT2YzRlZqcGVXUDBxVkdm?=
 =?utf-8?B?cEVXQWdwbDBYTUZ5RDYvTVVRRUpEVXEyMS9Kak9FenFiTExmb1BuaFFxOVhL?=
 =?utf-8?B?ZW4ySERHa2Zib2VkeitnQkFFWmMyM2J2NVd5WlNlVE5vZFAvOHRvekRJRmtI?=
 =?utf-8?B?aUxJMkxvWkFvcklHd2EzME9rZCtqZTFFK0tpK0tzVEppMU94ZzhNMWtvS3Fv?=
 =?utf-8?B?bU43WGNFb2QreExVSTAvOStKa3R0K0RaY2tlLzVCTDdZUDV0cmNtR09zcUNs?=
 =?utf-8?B?Nks2NUZEQ09BRGFRMDlvS3lsZjJzeU4vSThMM3BvNWVyMW1VWTBFY1FwTmVa?=
 =?utf-8?B?a3U1bHdnNWxybjhiaWhhNFMxSDhKbk1KNlQ3RGNRL1FkekJDdCtmbFZBRjBk?=
 =?utf-8?B?SHlaRG92aWRrT3dzdk5CajJRZzBJeUgrY0ZEdzgzei9vQ2d1cXJnSXU3STlF?=
 =?utf-8?B?VWNYUXRnZEpxOHVxcUFXR2Fwb2RZMTNBcU0zQkkyaVk5bVNCY3BydVNHRW5w?=
 =?utf-8?B?Tk0wTmRRZnFSVFBoZDBDd0JmemZ1MExtT2NnRXFQb1k4ZDg4UFZtanowK1Vu?=
 =?utf-8?B?L1pwVmtnOXdPQmdIdlJMdHo5K0RucTRIT09ocFB4bWdXRUMzMlRPTDhmTldR?=
 =?utf-8?B?anlEbjF4anpJZDlWdk1tUHU3THVjUlJhT29CaFYyMllFZ1ZjS0hVc0VPQWtl?=
 =?utf-8?B?YU82L1MyaDlaNjNWY2JGbHV6KzltWkFYTlpNMllFSVY4Z1JUc0FaNXFMWGdR?=
 =?utf-8?B?ZXBrRnhQSGtGMGZEZ3A3QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0VsazByaEVVUTJZdUZaZ1djelBvbVJKbDF6Z2YxYkd6YXV5TmtIK3l0SnNm?=
 =?utf-8?B?U1R3dHExeGFUZXN1TkZsZk41MmdGcFdwQVhQZng1ekd0VlFBRGh5eGc0S3Ix?=
 =?utf-8?B?M1dNdmt4TUtIZ2VySm0vczdVckg0NEZJb0pLTVRib2NRVXRJZXRhZ3RVcXlv?=
 =?utf-8?B?Tlc2eHg1bFZCdGcxQVUraG8ybS8xcW5senBVY0NrdlVsODNnMFk0dk9wdW4w?=
 =?utf-8?B?YVRBQURxQzVtVWdYQnI1QWY1YlNhTmtFZWhiTCsrcEZDVUY5SEswSEY1bGJw?=
 =?utf-8?B?UUVvWDUzRzJhakp1K2d4a0Q3UFlVWFdwMWV6ZVVWcUR4U3J2VG5CbjBJOXdL?=
 =?utf-8?B?M0o1bHBJK1RyYXhSeWhzajhncEVKSHJYNWQyVkhrNlFuaW9hVGF0UGdWMnhn?=
 =?utf-8?B?cEtLQS9NdmFUMHgybXhxUjJSS3dKdXZwd2UvaW5aUGc4bGtkRDVmalRmbE8z?=
 =?utf-8?B?a3F2dDNRbDRtdm1jWG1KaW1za3pzTXhVUW9VQmZPa0RhRW9tTVljbTBqTWox?=
 =?utf-8?B?V0lIU25ZZWV2LzBOYnJrSlBWMDY0UThCZDVPaFNVdlZWakVYcC94cTdEL1FW?=
 =?utf-8?B?UmgwTWh3akpzYVlvNHlQcDBlSi9JdUoxMDIrak1XNVlZdEFLc3BlTEZaS2RW?=
 =?utf-8?B?bXp3a0lnMHRvV1VrQUkrVi9TQm02OWgzWkRFbHBqaWpmM3pqVTZoYjdHcDVI?=
 =?utf-8?B?R0VSSndwdTZTeFZKaU45enpGbVlrQ2tTbGhnT1RoTGMyQWg5UTAzUkdEYVRP?=
 =?utf-8?B?a09raFEwaU40NjcrQWNQMzNaZHFpWjVkWnlNMkg3K00xZ0VsUGxZQkhOblcw?=
 =?utf-8?B?bVduVFZiZkNIdDBYb3ZGcm1BeFJLdHlhTGVNdlFjdEpxK2JGckFNcXFGVVJL?=
 =?utf-8?B?UlM5TjZOdWxsbm8zVnFUL0xuUXR3d1oycS9hbHBrN0djRHA3N0VabWhNZzMz?=
 =?utf-8?B?ckc5Mk8rTy82ZmhSbFRoZWhndXdwdXdLVDVXNXNDQjB3QUVYbjA2cjZYZDJL?=
 =?utf-8?B?eGZFMnpqVTV2dWxvS29ONEY0SWZ5U21HL0lSU2JNQnkxS1MwcmY3YlFxcVZs?=
 =?utf-8?B?UzBLVkpZemxoV3kzaG1aakRTS2lSRm9OTXFScWZsNVVUMDBiZFlLNDUrOS9U?=
 =?utf-8?B?RUIzZmk0TS8yaWIrViszakhZa0tOT2V0cFlnK0dUeUkrU21WRGhDckdaSXUz?=
 =?utf-8?B?TGpkZ1VpOTlTTkFWZVdUdWJyT3RZMzcxWVhKZkM0UG1zaWUvV0FFbzRHZmgv?=
 =?utf-8?B?dmZRam9ENXpsT1Juc1AzQ2t6aTBUVTdoSnNDc2QyRlVkdWVRZllZeTVnakFh?=
 =?utf-8?B?LzdCN3NJVlVzN1BCZlFnM05XWGlkYlhqNjcwby9XTDBFK3VsbXZadVczdCtR?=
 =?utf-8?B?OTdaYzhnL2E5MFlZc0VDeWlaK2l0YzJQWHhNeURyZTkwVjI5ck1mWC94ZDdv?=
 =?utf-8?B?THU3VEFFY3hvN1d4RERsMHlQNzdHUkZNRExybDhzY2xKU2NTdWFZVVNmdTRY?=
 =?utf-8?B?SXRCS2l1SzE5MXEvMEsvZjhjaytkVnlFaHp4eEN2YXMxM0NPcnVoYVhPbVdK?=
 =?utf-8?B?amVRV1pPR0REc2RpUjJSUW1aVkJiMmFvWWpKMDI2NUh0Rm1nVk5aWmZ0ZFc0?=
 =?utf-8?B?SnJBSHY4aW4rRGo3aTJ4WTREOEc5anAxdW9qMThrdDFWek93M1l5dFRLL0h5?=
 =?utf-8?B?Q3J6Z3dweDd3cXdNR1B3MTE1TVZTQlVhUldiUDdnZUdLVHUwSUplVTNXZUo1?=
 =?utf-8?B?UjN4bG1FM0lCYnViSHdzQkhlcElqK0Ezc3RiS3F6NnFWNFFYNTZNditiZzd6?=
 =?utf-8?B?RXBQZ2tIcElYQmlkMTFOV1JZOVlFSGFLV1ZCTjVHeVloSkgwM3h2OFc3dkxh?=
 =?utf-8?B?SDUvMlVGbEFYNHZrOHNzMUVnMWlwQWg4LzU2ZUpTRnM2RXZMMVZjamg0M09j?=
 =?utf-8?B?NVprZXR0QzhwQW11V2k3Um9mL003TlkzM1BsUkVuVXA2VVQ4dUp5WjloRTh2?=
 =?utf-8?B?Ny9oSnZDYWhVRjFLOFZreVk4SGZUeWNnVmJtMHB1R1hzY2pQdzBsRGdkODhy?=
 =?utf-8?B?VkFNSkZrenR5WnNSeXRadnhlbTV6SHVQeGlYSlpUNDRETERQdy84Zk9vS05J?=
 =?utf-8?Q?Yyjrm4u/WGVwqJFaFlGKAGLPo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62979baa-a5e0-43cd-f1ff-08dcd53f605e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 04:32:15.8331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kA7Oh+emVpL++OZgC7EinznzH0s7ZuM3RAQWEUktTlopqu1aIkgDPGKbrZzE12zUXIaQ8JDrOozLhFcMlGcGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5047
X-OriginatorOrg: intel.com

On 9/13/2024 7:55 AM, James Bottomley wrote:
> On Thu, 2024-09-12 at 14:00 -0500, Xing, Cedric wrote:
>> By "TCG2", I refer to the TPM PC client profile that defines the EV_*
>> event types. I could be very wrong but I thought IMA content/event
>> types had not been defined until CEL came along.
> 
> The IMA log has always been defined in
> 
> Documentation/security/IMA-templates
> 
> Even before CEL tried to add it as a format.
> 
We are on the same page. The TCG PC client profile spec didn't define 
IMA specific events. So IMA invented its own, and then was included into 
CEL.

>>   Though both TCG2 and CEL were designed to be extensible, adding new
>> event/content types would require revising the specs, which is a very
>> high bar for new applications, and is one of the major reasons for
>> introducing this new log format.
>>
>> Regarding the IMA log, there are several options to integrate it into
>> the TSM framework:
>>
>> One straight forward option is to dedicate a RTMR for IMA use. This
>> series allows off-log extension so nothing else (except mapping the
>> PCR to the dedicated RTMR) needs changes.
> 
> I don't see how that would help:  From the IMA point of view there's no
> practical difference between extending a PCR and extending a RTMR (it's
> the same mathematical operation).  The difference is how you get the
> quote and verify the log matches it.
> 
> I do note that since the whole problem boils down to the different
> quoting mechanism between TPM and RTMR, it is entirely possible, since
> the Quoting Enclave is all in software, for them to produce a TPM quote
> even for RTMR measurements that could be verified against some external
> key.  That way all the IMA tools would just work for RTMRs (which would
> seem to me to be a much easier way of getting them to work with RTMRs).
> It's always baffled me why Intel is so adamant that every existing
> measurement tool and pathway should be rewritten for the RTMR approach
> instead of simply being compatible enough to get existing tools to work
> with RTMRs.  You can still keep the current RTMR quote format and the
> certificate chain, simply add the ability to produce a signature that
> matches the usual TPM quote.  Since a quote is only a signature over a
> public key, the tools would work and the only difference is how you
> confirm the certificate chain.
> 
There's significant difference in the trust model betweem TPM and CC 
TEEs. Specifically, in the TPM case the CRTM (usually the BIOS boot 
block) is simply trusted, while in the case of CC TEEs the CRTM (pretty 
much equivalent to the initial memory image) is measured. Additionally, 
TPM is soldered to a physical platform while TEEs can be migrated from 
platform to platform. Moreover, certain TEE implementations, like Intel 
TDX, rely on additional modules for security (e.g., TDX module, SEAM 
loader ACM, microcode), and some of those can be updated without 
rebooting (i.e., without tearing down TDs). Therefore, a "full" TD quote 
(which is still a work in progress) will have to convey more evidence 
than the current TPM quote format can possibly accommodate. That is, 
even if the Quoting Enclave (or Quoting TD in future) can sign a TPM 
quote (e.g., by striping off everything other than RTMRs), an 
attestation service would still have to verify/appraise other evidence 
conveyed outside of the TPM quote to establish trust in the TPM quote. I 
believe there are similar problems in other CC archs/implementations.

>> The second option is to change IMA to use the new log format proposed
>> here. Of course, it'd require more changes than the first option - I
>> don't believe many people would like it at the moment.
> 
> I think that's true, yes.  And that's precisely the problem with this
> proposal: you're completely pejorative about log format but know that
> no-one is going to change to the format you're trying to mandate.
> 
I'm not trying to mandate the format. I presented this option briefly to 
show that I had considered all possibilities. Also, see my response to 
your comment on the 3rd option below.

>> The third option is "virtual measurement". We can define a virtual MR
>> -
>> say "mr_ima", to replace the current PCR. Then we back mr_ima by a
>> real RTMR by logging the value extended to mr_ima. That is: when
>> mr_ima is extended by value XYZ, an entry like "mr_ima extend
>> <hash_algo>/XYZ" is  logged to some native RTMR. Later on, the
>> verifier can replay the RTMR log to calculate an mr_ima value that
>> matches the IMA's log. This is actually an example of sharing an RTMR
>> among multiple arbitrary applications. Events from different
>> applications can be distinguished by the prefix ("mr_ima" in this
>> example), and a layered verifier can be built - the bottom CC-
>> specific layer verifies the integrity of the log without
>> understanding IMA, then the top (CC-agnostic) layer verifies
>> the IMA log using calculated "mr_ima" value by the bottom layer.
> 
> But this sounds even worse.  You're adding an extra layer and an extra
> logging tool simply to verify the PCR/RTMR quote and then after that
> you need to us IMA tools to verify the log.
> 
We are facing a challenge similar to what the TCP/IP stack solved many 
years ago. Think of it like this: the IMA log is the "application 
layer", where the actual data resides. The specific record syntax/format 
in the example (i.e., "ima_mr extend <hash_algo>/XYZ") acts like TCP, 
with `mr_ima` being a "TCP port". The rules introduced in this series 
for identifying event record boundaries and hashing, serve as the "link 
layer" to provide data integrity. The ultimate objective of this 
"layered measurement/attestation stack" is to allow multiple 
applications to share the same physical RTMR without interfering with 
each other.

Just as the TCP/IP stack requires different layers to handle various 
aspects of data communication, this approach do require additional 
tools, especially on the "attestation service" side. Given that we are 
just laying the groundwork, I believe the first option will have the 
least impact to existing s/w and will suffice for now.

-Cedric


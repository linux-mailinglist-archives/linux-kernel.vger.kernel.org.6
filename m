Return-Path: <linux-kernel+bounces-323708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B829B974245
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367221F265CE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B606C1A3BB8;
	Tue, 10 Sep 2024 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPAbt6S5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0231A2C3D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993365; cv=fail; b=WvX0RBzno3UTCfY2mX25qgVdVqguwDU1IwxwEOJOmnx8KtbV0tWA4bwwB9tPBL/PX65nd8idZZHM/vYrkzLCIokucbIbdcpzwGQBpdlCybuSAeVy0DeuWQFMVh6u7e0qw+CUvXjZ2KAVGXX57h+SN2oUBAKcSsKuRsMgZkXeyOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993365; c=relaxed/simple;
	bh=TfU/O2lRZLXV62ao6BoNaVj0DFlu1bJNWIo/jG5Q6GI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oXa7Scq/pVDGCFjEEOBBV7K5cLoLeCd6X5YWavd7AJcmLw5yNfaWl9t+E0ZlESeOB6+bouL6DgHPFuLc78WXUzSjEzC4npG2HkzWcfrScs3ZWTnk3exRB+WVD+poaYfyZPnp9cqTz+Ns0EZWbDXAA1Ws4jg8usFuTTEcexY0fOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GPAbt6S5; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725993364; x=1757529364;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TfU/O2lRZLXV62ao6BoNaVj0DFlu1bJNWIo/jG5Q6GI=;
  b=GPAbt6S5MsuB1bD6WpNZnBqYdkbCIa4ylTCaQ83/Q79lVopDx8v7Hqo5
   DZ3reF90GIlrcf7+IS77/2MXEJLRaqJUORhyiFSNJyDE/3ewPgNdZ5bkm
   PfeAdBgNTTwwVl2QSe0cNrVmlIyChVwPBtjLG4+A9Zn4Hvmmfq4/+nrQZ
   ia2FVEC5XCn8KaY3Oxn4ERroUTBsGZyjnc5hGySO8x7/uM1kWihpfizQH
   fvRpW84leWMmmKqZjQnrgQ8W3gO1NGm13XCS1wxixzXBZa0eyGzrpPb4e
   lTnCJV9Wtrb6o+CmbLDQ1FRYsDWgfyicwHO8MxDmdvFzhhFL3B3RedKbs
   A==;
X-CSE-ConnectionGUID: hZTEQn6mQMqdHdEeIeQptQ==
X-CSE-MsgGUID: s8fJ0/3hRmKSar0uXtLAqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="36142286"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="36142286"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 11:35:44 -0700
X-CSE-ConnectionGUID: ji6/jtrnTvy3pVjVq7rboA==
X-CSE-MsgGUID: dansisA9RReVFRROeK+nOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="67065744"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 11:35:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 11:35:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 11:35:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 11:35:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 11:35:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYXoPA4ifpBZvJ9IpE120Zmfd4FPkM8r9Yum0PFIphl7GxniUeKXacRoKeLjeBSL2Haz32KGS8B4X247olyT2RC6oKFYqagNr4pRxmvF1XRYez4ya0FkvQeAOnUQlO/qmwIcCpQN5HP6cY61oDJscJ+7SYvcqOyWU0/mdhltbEAW76ElqVF1GLMpxGtYe4jGIBKILw25r5kczsKJqreQEP2k13w1KH2JnpeLN2ExAW8+qhYRPXsMn0xR3QhUdbwNR6bkdm7hOXUwLtjs0XSeL59NtM5EIzP09EtPmgrACPpdPHDajv0kQilsb9dolHgeO5cZr0FWIWY5MJM/wGu+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72NA2VN0mVg7hhjs7WP33fu120V20JDLVk9Xuz+bkaA=;
 b=hjxkuzSXwOXUA/8IZomHWVRJ5FHMxOFkZRxo2kHYN8KxP5P8KDUOjdYTH0H/rlySYshZE+L0Wc0iiGq7zQf4Fcr+iLwy5hS/PsAmIoGKRCrGyBG3s9w1rHXIatZPqpD9sC1kKGk5TrKis0Fh9gZZVQkVHrshfOTcCq6JFMK6H/uhGFY/uJb9NCqnr8VYPjtuovYuNyeQ5+oloSa2DAUqlSS8YQhc6GIBO0jC3kVNiyf8fptAkhxTa0Sl08erxHpQYOxbbzgcfVaaNk6GeVLDSLBVcOBr2fg4eNQ8VcEwdc6SerSi1sTITTDcwR1shGPRE4tuNg3+sAvpEOrcZnKp/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SA3PR11MB7980.namprd11.prod.outlook.com (2603:10b6:806:2fc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 10 Sep
 2024 18:35:38 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 18:35:38 +0000
Message-ID: <dc3c2ba3-73db-4609-bc34-3181c44d0dd0@intel.com>
Date: Tue, 10 Sep 2024 11:35:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arch/x86/microcode/intel: Remove unnecessary cache
 writeback and invalidation
To: <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <tony.luck@intel.com>,
	<ashok.raj@intel.com>, Yan Hua Wu <yanhua1.wu@intel.com>
References: <20240701212012.21499-1-chang.seok.bae@intel.com>
 <20240701212012.21499-2-chang.seok.bae@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20240701212012.21499-2-chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0108.namprd05.prod.outlook.com
 (2603:10b6:a03:334::23) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SA3PR11MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: d86d4d91-6c35-44cb-ee5b-08dcd1c75dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tlova05yUkFuR3c4QjUreHlmRHVwQ1crdGhtTkJzQTlZb2FPNGNESzJJN2xG?=
 =?utf-8?B?ZWhWc2hhZWYzN3dwMXJFLzB1dEp2cUNCUnRXakdxZGY1bEgyMElIRFM2MVN6?=
 =?utf-8?B?ZEJTbzZWdm04REdrSXFRMThmWWozSHYyKy9iNmZhOWVlRmdERjlib2xhMGt1?=
 =?utf-8?B?Q09Cb0xPbTVQMTQ3VzlQZ21EaFVJTWJhaGplK2ZMKzNzTXQyOVI2Ukpxbkd3?=
 =?utf-8?B?NkMxNHpyYW54dFptVnh4RTRRbmVraklCdDBkNlpncVpZa0pYLzNYRG03Tk10?=
 =?utf-8?B?eXhnTU5oT1lkZ1duNWcraWYrK00yYWR1eUc1ZTNIOWlvcU9jY1NwQnZ4TlVO?=
 =?utf-8?B?MUdrbzM0eUxpTVM4R21LaldwWmpycVM0UC9wbS8xSlhVQWVKanVvVnMrTUwz?=
 =?utf-8?B?TWRRQlo0VG83M2xweXphYWc3OGxwMlFuclVLTDc1NmFNL1MvUWlwak5IbkxP?=
 =?utf-8?B?S05weDRGSVJ3clVGcWRpaUlkdSs3aVBVZHRGcEZndk5zYzZhUWowR09RWStJ?=
 =?utf-8?B?WXFYK0RxV3JuZGpOMjJYMmlvd2V6eGNOQ05qNUUvMWErTFJmM0F4b1AvRk95?=
 =?utf-8?B?Y1QrQ0d1M05sT3RwY3BRRzV1akFkQlFTdTdOM2tpdVRHOXRLSmo0dWQ3VFkw?=
 =?utf-8?B?THM2VHFhdmQweXVzY1Z5RnVrY0ZKdVNqTjN5V1BnNkduWDkvOUdDMU5zRFhM?=
 =?utf-8?B?U3IzR01wbGQvaHFrRE5jTTZjWnc4ZTdjMmw3czE3a2hUWnRPWEtDa1VmQkpw?=
 =?utf-8?B?eTJCQ3JObWh5bXUzR1k0eDJSNkVjWXV5cVIwaFp4WnRVMVc4L0k5V3Z2ZE8y?=
 =?utf-8?B?RVhLYTZBaEt6L1VuYWIzVElWZGZ4UXlLeHlCUlBJVTVnNzFTVWIzaWtDd3ZZ?=
 =?utf-8?B?OTJIcG1QQ0FiRDFkWWo3c1dNQ01MZ2JjUEdkZVlkaHo5Uk9GZEVCWTdxUW9u?=
 =?utf-8?B?VDhXRklRbnIvU0xydjRVWjZ0aGZMNlNJdDg1NjhZbUxsTmgxVjNMMmN3bHRT?=
 =?utf-8?B?R0s5bFp3RDlqUW1pc0VYYnZvdjZoTHBjWXl1RTUvUW9pZU94QTc2SVFtUlox?=
 =?utf-8?B?eGZSUndOZy9BSlFnNTc0QVZlN3Q4MDc2aEhkZnk5V052WERJUitjNHJkblBS?=
 =?utf-8?B?anFwYWNrTXRWWXBXbThFVmtQRnNnUmZybTMrOERhRU1NMG1XVTBOWWt6ZDhh?=
 =?utf-8?B?cTRHOHpVbzZoV0hKU2RSL3FjeTNKR3JvUDliZkxjYnNXYTdvVUJ3MUtxZkVI?=
 =?utf-8?B?bEFRbFVVeXM5ckI4amFaWU1zN0g2M0RIL1VrOC96YjNXbzQ1OW9yR2tlK2FL?=
 =?utf-8?B?OW8vWFZxMldLRytTTkhCL0pqRFhnam0wbjNZOHNLNUNrTFREMnF0enEzQ3FI?=
 =?utf-8?B?cmhmcmNwb0lObG9zeWNLY05leUVWWWZ4MGE5dDJFcUk5U01QdGlIaS9sUEhM?=
 =?utf-8?B?Ry93c3Iwd0xzNnRJQmZoZVpuM1hsZ0txSUx1aXFZWVdmamxvZ29rN0YzdEhy?=
 =?utf-8?B?T21DVWpYU1ZhellSb2Z1amJnd3RvTGx5aXVMaWMvVnErU01zR3hPTS9MWmF6?=
 =?utf-8?B?ajR0MzFBTVYrQkNaRjloWCs0SU5iQ0xCOW5mdS9uODJRVDdKa2pKbkpIUzN5?=
 =?utf-8?B?OVh1WktCRTFQWGZrTUVKOHFIdW43dVYwZHpzVlNXbjJoQzhvUG1OaVpta1Bv?=
 =?utf-8?B?SVJsVGlNTmpObWJWeGNiUUMxWHQxLzBkSFlCSFdLQkp2eExVNWlYYmZRbDNT?=
 =?utf-8?B?ZFlWK2ZDa1RkNkZ6cmpOMVAyN3NDazZDU1crTGZxbjVDazJGRDJQbFozUWRi?=
 =?utf-8?Q?I1vC+U0iaDi2gbjmVc2Heyl9BD6QiMSiH52H0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW5MbzFybzVkblV5SkFraXVsZU1BME04Wm9ONlM1RkJQMzBJZWNkSUMzRlNR?=
 =?utf-8?B?TFM5Uy95NUY0bzFQWmtpZFk3REV5dmUwQm5WdUVXVk5iZmJhemplLzNaTEFm?=
 =?utf-8?B?WFdnOHNKUmxlVXNVWHNXcnNQaUdmdnpxYnZPYStVeDBxcWhHNUdZc0o4Q0ZS?=
 =?utf-8?B?aDNHbHkwaUZCL1krYnBVU3hKbEE5SFlwRVFvOGg2Y2ptNWJHRWw5dWs0MTZH?=
 =?utf-8?B?WmdKcmxKbk1CemZkaENGeWhmNGh5TjZOK1RQcDhEV25xd3cwckgreWxVbmls?=
 =?utf-8?B?WEFUanRTVVpXQ2FOWEY4ZFJhUEFxTHVBSWhqTlAvV2pEbkRoSk5Tc0Y0VGRM?=
 =?utf-8?B?SFhrbjA1bmZEMlJBSXJJbXZUaSs5L3hVaEJGZnBTYmVmbGtKeVBqaWVaQUlD?=
 =?utf-8?B?ZHl2UVJ1UjgxKzFqZk9ncjloazZxd1U5clBoQkhwYnJ6WGZkYWZOYVNCeFd0?=
 =?utf-8?B?akh5Vm9Day9qdDhXc0NwU0sxODVhNVgxM0ZoaDRTalhpMmEvbDFWcmF5Rmsy?=
 =?utf-8?B?ZlBFZzVLRHNZWnpEc0QrR1BaYTNuTHZlaWdSSlBnajNtbXZZVHpQS3Z3K1Zv?=
 =?utf-8?B?WGRoSkFmNU5KR0cxWlNSeDQxTDliZ1NqSnpINzhydi90Z1dZaENoQ2wrdlRr?=
 =?utf-8?B?Q3VVUENBUFJCNS8walpIdHAxQ3h0NTdYOVpMMUJuWHdNMkpHNUQ4azc2Yksx?=
 =?utf-8?B?V3VHM3VxNDh3ZnA3c2FGVWtBTGdxRFlHSUd1YlVMS0JreFdpK1hoaU8yQ2w5?=
 =?utf-8?B?OFdtUTFManFVSzIwL2trSjFtR3dPOHJhRHR0dGVmNjNXcjZRNjdxSXZVZHpD?=
 =?utf-8?B?K0JhTGtkTHYranh0eFhGU1ZvRDBQWGhHMmNIQlFmYytWL01XVldYa3praWYx?=
 =?utf-8?B?OG9JK3hQR2dWaFNUUktHS1ZCdmE0QVE2cU51c21vMWJPMUJCem80a3BIV0Uw?=
 =?utf-8?B?UE5lRzkxZ25YSHpWQWtyNU1kZDZvMHVwcExmbEYrdGJpa213RmNRNjBydjB0?=
 =?utf-8?B?eWJNY1hmWEZlMWtyZTNrV0hXa0V4OVd3Snl1TWJIdzgxaURPN1JPU1UrUXlV?=
 =?utf-8?B?Tm03MWZ6aUhjYTBDQ1hLd2Z3SDZOZExFamZYdVJOVjM3TlFoNGtwRVVzdU5R?=
 =?utf-8?B?Z0NnZDFRUEJmRVArSnpBbUpESUVSd0pjeTc1YTNsZFlXeE5vL3E4cEcwY3BV?=
 =?utf-8?B?aGNuSTkrejFONHRrbmZUOEFiNnZIL3crWk9lZWdjd04vTDhRaVB1dy9DRHg3?=
 =?utf-8?B?djFjTTFDQlp3bjFhUTZXU1lnNWg1STlLUHJaVXh3YnU0Wm0yTEt5dE9Edlll?=
 =?utf-8?B?VnRNdzNZQmFOZDM3TEN1ZGV3cURHWGpRQjdrR1VnWWFFR0k5c0VWOWZzT01X?=
 =?utf-8?B?SjhMcGp3M242RzdkV1FzNXgxZU5hdTAwVzlKc055WUdUZTB0bXpkUDdrS3Vi?=
 =?utf-8?B?b2oxWnBOUlpZMmpDa0xNZjdJZk9iNUFEVkdaY3NZc1QyeHJUM3NPcVYxczNX?=
 =?utf-8?B?SmlNL0tqdCtyOWJoTlBGbmZVTlpmamloZVBLSlFQSUt1cVBka0lKMjkzclU4?=
 =?utf-8?B?VDV1K1ExVGpvc2c2SHFYWDdBWWo3MDk1SDQzYkRQVnZ3VURUdXJWTzM5ZjRZ?=
 =?utf-8?B?bmFHTi9zSXR1Z3FrdTl2eHRIN2Z6QTlGWk41dzVPSloyN3ZZU2FUbzRaUytM?=
 =?utf-8?B?eWo5SUNIZ3NoamVXOTJvYVE1bFl5eTN1QStjVjZsMmQ5ZDVvR2IrZVZmSXlB?=
 =?utf-8?B?aXBOcFBmMVlOVHd5bWxsNldWU1dCRG1waGNGak9HdDhxYURRKzZUTGV3K3R5?=
 =?utf-8?B?ZGhFcGdydGdQd01XZ09GQWExVERwaXJrRTRzOWU4YzNWa1J2RlhzWDhZUFJr?=
 =?utf-8?B?U3VvZmhZQ1dFNUZWN1BrT3BUdFdMZitQUzJRaUJVSEhWRlNKelVQa2FCZ2d4?=
 =?utf-8?B?dmc3UllpK01QNFJHRnhLT1ZQZ0dXcm5LdC9YNUMzTiswbGZJR29MU0w1bmlj?=
 =?utf-8?B?T3QycFBodjdzbG04Sk01MXZSY0paTS9jVGlEMHR1bEJZa2VTd1EyWVgvaDRl?=
 =?utf-8?B?dXhCMFBIZEsycEZlRGRzQUlGYkM4WTdidWVFTmRrM1hkSktoRFZVVlpGdjB3?=
 =?utf-8?B?dWxnNzVXa051VG1XSkIrUEtMRjJJQmhkais3elRvODhTNkt2ZDdYUnBVbis4?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d86d4d91-6c35-44cb-ee5b-08dcd1c75dcd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 18:35:38.4273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnTx0XFAMxag8pRAW84h7/ZlxDDNviGkCm5gDgOW1N7OxymgI2lP2gGbwba1ZT7OYAaDkfFHmseP7qitG464M/xe5X+9WumcjqSagW4Qo+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7980
X-OriginatorOrg: intel.com

On 7/1/2024 2:20 PM, Chang S. Bae wrote:
> 
> Additionally, the side effects of doing this have been overlooked. It
> extends the CPU rendezvous time for late loading. The cache flush takes
> about 1x to 3.5x more time than needed for updating the microcode.

To provide more context, the latency impact was found to be more adverse 
when late loading was staged using the new loading feature [1]. Its 
enabling patch set will be posted once the specification is updated, 
likely after the upcoming merge window. I will include this fix (v2) as 
part of the series.

Thanks,
Chang

[1]: https://cdrdv2.intel.com/v1/dl/getContent/782715



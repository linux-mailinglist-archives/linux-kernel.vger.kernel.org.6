Return-Path: <linux-kernel+bounces-214163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 388DE908061
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC9C1F22208
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999424A11;
	Fri, 14 Jun 2024 00:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gb+RQJ1q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013C217D2;
	Fri, 14 Jun 2024 00:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718326679; cv=fail; b=qAH7aKRvezRaY3vFPG6WjKuXOteg5XvGShXb6YWR0trJ5jsgC8onMm0MTPESJiIUec5lOv1GJza2fG4CQG6TBQOLYHCIgs8eGhyqvyLMkToCckEyb8YsXN7oGmsDq9LmmeY5PV6yGNfYIYyDeS/eI59f9yAp+A2AE75Uwr7pVaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718326679; c=relaxed/simple;
	bh=Vk/74QDHfoOriYie35fB6qGLbkcshG3Rz+R3Y+r60r0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kR+7mK5kr8uV4jRfZXsBgnhsHv8nxJFf8UWPiZdgps63iGMEoqK36PSHcZMP8Y/WKG2crIVXDO7eTTTyKzkTApd6S6Y2eqkqjySsv4j4RPC+xsT0R3T2M2BsYf4F8K/fZCX5HFIuEA5cxYL7xrriJEFd6qsClA/fKwVcPtfBbZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gb+RQJ1q; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718326678; x=1749862678;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vk/74QDHfoOriYie35fB6qGLbkcshG3Rz+R3Y+r60r0=;
  b=Gb+RQJ1qJgDnJRRioUkOGWEA8EkrbAB+WujDFe6xEw58MkiN/sp+Ycd4
   PKnKDlBexBuH0AL6EhHiCG4zmj1aGgMQhuZ6Ben3xuNG0JqGw2Le8b+3d
   Pne1TDadjIOzpsM7zv+yZMjqtaf3fOuXvglEYtsKGSq6W3G/GujrZFq8h
   o5WMnzd1NdbGMT500jJhJ73dcGUuYF34Kiyu/O3lB2wQEBVyPgfUkcSyg
   LwzMvwWbCMqB1F67oHC2hi58IH92Bxet3naqC7m+KvxjSw2d5A+o6xMgM
   c+ioa2Jg1aulW2wvc6Vrxcm8bfPd/VP5uLGDQ8uDrwkKQXMZuYUkuuJ+j
   Q==;
X-CSE-ConnectionGUID: Wtqf8O3ySm+SN4MO8RR6gA==
X-CSE-MsgGUID: EISW3Zq2SteR+D6bm/Edpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15166992"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="15166992"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 17:57:58 -0700
X-CSE-ConnectionGUID: NZ3yPV7ARkynVYUz/fEkjQ==
X-CSE-MsgGUID: GxsdtOT5Q1G/Qjm6kGuwpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40829776"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 17:57:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 17:57:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 17:57:57 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 17:57:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/Wi7DQM48+TEoOQiKAs16hmzSj1gcfr/Ag0KuIFCIMYxsVqHbVDNsuusNtwpzWKmeQIAdASsz3rP19slTL6nKAF9agYR+qt8mNDGc16+sTRTMxh6uMB+CgTc1E32mZEn1kUzDhmiMyfEyfOs/JK4JxDP0aimlG53V/RN5ZxixY1bJu8ckDnqoP0OZdTCuQhWS9YymR6be4Kg1vZTnr4u60tchPlQVOlagLPpKaOyEU7HPsTD5Q04MeaoV2CNt3cQEsVaMCggMuSKSfVEb1eQNASJbPzAGdUFy7be0dqaxQMd2wYJzzYMfTJsnWKvAx6v8jDQDV4WEKsN9u8jbdCmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiMXCNFLkVk9hxhhJuAlsqqzqlM873EwAzOdjBJyDQ8=;
 b=USCBnekot4fZw1i9jRqSR+9yiwjT8ngyE5S3luKptgwLg4+Q6DaP1rX+0WIXTdmlxSG2qtRs5uX8QRfGxcGfK5UuO2AssiyMMUzssx51413JScxRVJ7q7oHWxbH1/xKwxyG58v8T73uH5eIsLegMo6i2XSamik4G6TCjAl+QrDuKE3bXXImdxTgOdSEe4x/avvgblJgO8xt4CXERlbwSzSojAKaNoTtdI6bz/uXl+IRflPEmEjr0ca4l/CyTf/WgXRgSV3DGhhm2cmZDzbB3qso5xRQDF9cfk57oFRuQqE9C5JLt2k8b8dFKo4JgbtEfnP0+GKE0vNx5hhzszt9jbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB8567.namprd11.prod.outlook.com (2603:10b6:a03:568::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 00:57:55 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 00:57:54 +0000
Message-ID: <23aa42c1-6b55-4d29-8995-29fbddf98ed4@intel.com>
Date: Thu, 13 Jun 2024 17:57:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/19] x86/resctrl: Introduce interface to display
 number of ABMC counters
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1716552602.git.babu.moger@amd.com>
 <6fdb1c3df8960a9d634a7a904421c63406b1a4b7.1716552602.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <6fdb1c3df8960a9d634a7a904421c63406b1a4b7.1716552602.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0239.namprd04.prod.outlook.com
 (2603:10b6:303:87::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: e440f6d2-3944-4329-42f9-08dc8c0d0625
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|7416009|366011|376009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlRlSVZXVVJLNDZxTmVJTnUxMTY2eVQ5K2h1aktHREFmaUltNmtLY3pnVndh?=
 =?utf-8?B?OGdaSjhRVTNOSzFrenhmZHFoS2swVWZ2ZGVseGlFeFh0eUlQdHd6NTZoYklz?=
 =?utf-8?B?UFZwSUh0RjFwb29OZ2xzWFNBUTNTeFV4NkFuT2JlMXNkdEthYXV0Z2RMWXln?=
 =?utf-8?B?ZHRsNDBVZlZCTm41SkNPekpuOTVpYVBYczBUOFRncXZ3R21EMXE5d3llYUlR?=
 =?utf-8?B?NzNKckl4M3FETjhsTWMwdlVBS1ptb0phazNuV1VHeklHaHhKS3hXdDV1SzM2?=
 =?utf-8?B?QkQzbjEvb0hJRkFoWnhhN2Q1aml4ckkveWRTUTNLUElGaUlSYUJNdjNTOVdw?=
 =?utf-8?B?OUZiMEdVTlV2ZlMwWE4wZTBzUlJadDBERUZjVE9CQytwRFdVNm1iRXJrT0Jm?=
 =?utf-8?B?NjdsWEtYZ1hBME1DRXdEdHlNMFFMcWlaWjB0VXl3bzRPMlU2QXdVQ1ZXTlZG?=
 =?utf-8?B?Z2tRZ2lhMGhnYmtJQTFnVTJsMVFpMzFuZzY4c21ybVJpUnplekIzREs0ZjY1?=
 =?utf-8?B?SENoc2VjQVRySTRsS2RBQ1V5UmN3aVZteEpIQ3dnMWxQdkN3emdpNkY2VEVQ?=
 =?utf-8?B?cll5c1RMcHhaNkNsbnZuUjRQUm1mVGlhSEltMldERHZxUzV6amlUc2U5WXdZ?=
 =?utf-8?B?d3h3YlkzKytBVWVxZytSZUEwOGZOVnJuZERVOE1nUkJLcisrb1UyQXhmcndV?=
 =?utf-8?B?TGxEVlZvaUd2bkF4V3NJUmFDaHRoYWhscWJ6WkhqRjBQdFVFL0JrcExSUUlq?=
 =?utf-8?B?TXY4a2QvOHJ4U1dHRldjR0E2cGZyMXYybVFPNWZDMTd5YlBXSUpQUnhObFR2?=
 =?utf-8?B?SGVSQmxmYmdRKytMQU9qWVU1bEFoWTRIdS9SSHBrWUsyN2Y0OHlZNHg5ODcr?=
 =?utf-8?B?bGxxb2RGMTc5WmRxUEcvT2RUZnIvWk9QdWNtN0NEaDZnMGNuYjNoSDJabnJK?=
 =?utf-8?B?dy9UNlhyZGpkQ1dZQkpZUTFFT1I5cUdIQTE3THN0SW5aSzVxQzZMUXl3cGw2?=
 =?utf-8?B?MW5SdEpvWFhrWlhMcVB4cEdBOTlDV1V5cUNZMzlNZWxBUDRCcUs4ckxuSEd3?=
 =?utf-8?B?bnI5QjJsMDJHMU9hUkhJWlhUUHE1UGVIanZ1ampOdUkxVEVtZlQ4Z3lGVWdW?=
 =?utf-8?B?RzRWUFNhZEhROU1RUWNsM3NtVGlFVXJnNzM1Z2poRjZtVVErQzlPVzRnZVBa?=
 =?utf-8?B?dURsclMzRmEvVElpTTZTa0t0bEVyeWxXUkt2Uk9KaFQ1L2hVYnlRZ1BZQjBj?=
 =?utf-8?B?dkNRanVLKzBpN3B1RWVtU0c4K0tDdHZ5TmU2ZWRUdEZ2blp4MW5yYzNUQ3JB?=
 =?utf-8?B?dmc1ZGYxbkg5K0JBRjAvZFJtdGI3T1l6RVl6a1BqaTN5eUNpVU4vTDA5Wmdk?=
 =?utf-8?B?K2VyK0ZIT1ZYcFNUN0xVMkRzemQ2bjJwdW5zNjJ5VHVORmovdUt5ZENqamlN?=
 =?utf-8?B?S2RDaVREbmw1SVNkQW1uZmtjOXJrRUFhR29udlVYbnRMeWpTbFBycTZwQU5y?=
 =?utf-8?B?ZnQrSnhUUitKRlFFOTZZMWc4NWpyTk00eGZEQW9sUnZzazJpV0V3eG0vOEdz?=
 =?utf-8?B?ZTlia3ZVMHNMSGk1RWd3WTJvUGs5aVk2aDRlODF2YXR1T0NXTXdvRW5ydW9S?=
 =?utf-8?B?Zmx2aE5EeWV2NHo2TWNUaC82cXRKTlBiNkZvYlNvcnhmbmNXcyszYkhWY1Zn?=
 =?utf-8?B?d1A0N0gwZENiU2F2bzM4OWJzTkxuTXhWaGkzYVJmRmRvNGhIUW8xb2h0VGFP?=
 =?utf-8?Q?wFoNOhKb7twpp7119Rf6skADyrEki88pcl0aG1b?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(7416009)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWUrZVk4YkdWR0gzK2xNZlpBM1phRjBkU2tZbVhXSG1UUmZKa25EaUVQRWdJ?=
 =?utf-8?B?amo4THk3VTZaelp3QzJVQ2RubzQ4VUUzQXNUL3c0Mk14R0JVbkFYOUxUVmZx?=
 =?utf-8?B?RjlDQlpNQVV3c1RMN2FBTFNkWnV5aE5KRVF2S1E3eEtkNUwrNGtmUFh0YkFZ?=
 =?utf-8?B?VnVraENwNDJjY29EL0NWWUZjZzdLSkJOU25ZRnlvWTF6cTloWHFIZmpxNHVm?=
 =?utf-8?B?YXprVGM3b0lRYkMrTG5oNWdxYTZMbjRkMEhaUnB6a3NJUUZURm80T0FkQ1R5?=
 =?utf-8?B?ZXBxSzY1U2p0dnNlOW0vV0dyNGhEanlIb0pGdEc2R0dlalI4VzM5UTZKeFc5?=
 =?utf-8?B?R2JhbVI1TC91dHIvdHdHSGF5b1F2R1NFUjRPYWFTb2dEanVvWlBqd3NaSDJt?=
 =?utf-8?B?bW9kWk1mRGJqbnlUUWNVelY4TkNEWFNRU01mblBXb1NGd2hWdEhTam14TGNC?=
 =?utf-8?B?QW1PWlI3Qzltd1RvQndxVlI0dTNac0xKMDBZWTVYT0t4TUVZaU1rWHJ1Q21o?=
 =?utf-8?B?WkRyOXpuTjVSeFpza1M4NTNmRzNsNlF0S0FEc3ZBOGh6QXhSQ0xOQUx0YjZ5?=
 =?utf-8?B?am5ERGloTFlCM3ZvcDZTZVV6RkxQSnZPbW1qelVHeUZpZlA0RWxnM3lZNlpD?=
 =?utf-8?B?N1hiZnlHSkFPOU9uTTBFSkFFY1J5STQ3c1NQMWdxbG5HTmE0aHUwTElJSU1t?=
 =?utf-8?B?b3hoSXBKMkRuZzJlSHRidEwxa09oUEFGSDlrenFvdTlGZHpnRjgveVlsdWhH?=
 =?utf-8?B?M0NEaVM3RVpzL2s4UkhmR2h2YVBoVDBnYWRiWDN0WmdjUGNoTy9RSDc1Nit0?=
 =?utf-8?B?bkZITnU3dHRiRk9XelJRaTk5UnFJa0x6M3orczlES2Zjd3J1bDJKSmxmM1FL?=
 =?utf-8?B?VDV5SDZYaGpyYnB5QXNIeWJEMVFySDlXa3ZLbnJDM3FGak5RM0dsN2NiMUlG?=
 =?utf-8?B?dDFpWkkyZkEzRWYvU2ZMcVFZZEwrMktDWHhlSlUvZjY3OSt0aTdxV2ZoQU1o?=
 =?utf-8?B?RjNiRGFtMFpYR3oxMEFzNEZJRDYzTkppcVpiNjRkdHZvNjNUZDk5V2tiWFFQ?=
 =?utf-8?B?a3J6S0xRbUgxZjNpT3EyZzNwZ0JuK1VtRTVSVjRiNHl1RWpsRklCOENjWkdR?=
 =?utf-8?B?aFNwd0k4T1Z1aFo3TEFoczRUdWQrazJqYkpnaVFNVVZqWnhVV1U4UE9tSVhY?=
 =?utf-8?B?ZDZ0SjkyMTgyY3JLVkZINm5Ua3lHaERpODBJK0dvNTFUOUZJQWZzcThKaTlw?=
 =?utf-8?B?SDlLcFZrZURaaTNRckxvb0V0aDBPeUU5cjFoL1BKcXhZa1ovWWlxUUZmNVo2?=
 =?utf-8?B?cmdleVBqRHpCbjFhelVwVEM1cmdTbHFNYktjN3NtbW01dlRaTXJsKzRXUjNk?=
 =?utf-8?B?dHF3ZXBRK3ZtTWRXTFFtWWtqcmZWN2pLSTdPWjcrSUsrOTRRalozcFp6QkZE?=
 =?utf-8?B?cFJZa1AraHUwaG5TT1l1SStua3hXR2VjMElvS0NSVzdJbkxOOWRTeGRiT2hU?=
 =?utf-8?B?YTMwQ0RCRjVOK1d3L3N4S3lyajdvdXZpZ1I5UmJid1V4T3d2bnp0a2Foam8v?=
 =?utf-8?B?aHE1S0FlamxRYzdpMXJYWHo2alduVUhYVmcxcmc4NUVVNmlkcXBQRTVBdE5j?=
 =?utf-8?B?NXhjS3RtUXJCaWVBREd6TVczSk5QbmlKd0ZKY0hVeVBDN0FpZjIxVnlYVTZ6?=
 =?utf-8?B?R3dyenFDN0RFTm1IV0dtSk5tNEoxOUJFSXdRMDdoaHhkY3oydDlKUVlPbFl0?=
 =?utf-8?B?NldkTVFwdzlHUm5tTklHWVF3djdJNEp5b29FL1EzelpXZTBZT1ZnU21HbnJZ?=
 =?utf-8?B?bmRXRXRzRmIzMDlIUWdQcHdlMFRIYnp6bUJxQmpldlJoNXd0SnFwS2hNODgw?=
 =?utf-8?B?OTB1Z0ZzV3RJZFlZM3NETXhMYnNwb25SZDVuR3A5dFZOTDNLUE52YWNHWk1n?=
 =?utf-8?B?UllycUJHTFUzbFA2RWU1Qi9iRzdmQ20wTDRROTJRZVhUUTNQWjFtWUFjS3Fi?=
 =?utf-8?B?WTg5OW5VTlozeFRyelhsYTNmRFYxTnVqbUl4RWhZR0FMRGw5ZVB3b2RkQTNX?=
 =?utf-8?B?WlBiZlY2dllQK1EvbFkzWGFFY1c5N1g5VWJEMGRxYlFub0dQMk9OaWtFZ3Jh?=
 =?utf-8?B?U0hJamJ4V2xlOE5CRmg4Vit0SUJlelZVM0hKNDdlY1Blem13K0VSaGl1bGhv?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e440f6d2-3944-4329-42f9-08dc8c0d0625
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 00:57:54.6386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSkC5k0bwiGCQzH953Hhk10KbvKGzdMmBP8IBoRg5m2CjVH3VpauI2kpmQgLxP+UBvX4Ic+wgWZoy7qgEVMSnXz8m6gXBB5YsRtz49pabuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8567
X-OriginatorOrg: intel.com

Hi Babu,

On 5/24/24 5:23 AM, Babu Moger wrote:
> The ABMC feature provides an option to the user to assign a hardware
> counter to an RMID and monitor the bandwidth as long as the counter
> is assigned. Number of assignments depend on number of ABMC counters
> available.

Take care that this interface will not just be used by ABMC. I assumed that
when the user switches to "soft-RMID" then the value of "num_cntrs" will change?

> 
> Provide the interface to display the number of ABMC counters supported.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v4: Changed the counter name to num_cntrs. And few text changes.
> 
> v3: Changed the field name to mbm_assign_cntrs.
> 
> v2: Changed the field name to mbm_assignable_counters from abmc_counters.
> ---
>   Documentation/arch/x86/resctrl.rst     |  4 ++++
>   arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 ++++++++++++++++
>   3 files changed, 21 insertions(+)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 02790efaabcc..7ab8172ef208 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -257,6 +257,10 @@ with the following files:
>   	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
>   	    0=0x30;1=0x30;3=0x15;4=0x15
>   
> +"num_cntrs":
> +	Available when ABMC feature is supported. The number of ABMC counters
> +	available for configuration.

This can only be understood by folks already familiar with AMD's ABMC feature. There is
no information about what "ABMC feature" is, what an "ABMC counter" is and what
"configuration" can be done with it.

Do you think this num_cntrs will only be used by ABMC? What will happen when user
enables "soft-RMID" or some other mode?

Reinette


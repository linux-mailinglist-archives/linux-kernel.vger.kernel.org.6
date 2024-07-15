Return-Path: <linux-kernel+bounces-252021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7B7930D20
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 06:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4AA71C20A59
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 04:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED0A6BFD2;
	Mon, 15 Jul 2024 04:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="THu+sqeE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF250D51E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 04:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721016522; cv=fail; b=GKFlZEoVoWAo++IcZKXJt0YMk8pKKbNXqevBtu1gZqzD7nm3KGrlkFQpThsTrC3KsTG/A4Sw9AQxt1lLJl+lCOv656fRFq3NP2WzmBTf/Rn8/vRZS7/2tdXSJqDWe8jayGkNWCZ5JD2s2cjY3obZAhQESiEFVCdixxh6+1fuY/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721016522; c=relaxed/simple;
	bh=MsuguLo6ub80/VKchfbCP/Jco/qP0QRgTieBqz2o5HQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S3REBPNQwsaYECPVMoQMZ/li4Lr/jXYJRqLpn+PcZNfTC+vtZ1feO0ovF1Bbdbn6u1Q9xVjUr5KdA6LxZxVXr8dVts8Na/kaE5+GvnEVpSTI/gW/kDAepXShxoRpZyDHHHGJtPGVxo3H8GYQnrbneefRwcyjiaWlNl9zmiSCMCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=THu+sqeE; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721016521; x=1752552521;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=MsuguLo6ub80/VKchfbCP/Jco/qP0QRgTieBqz2o5HQ=;
  b=THu+sqeE+p96tgCQni1Vl7DibOVpCR1DTOVge4sYFSpiJmsOYJ8XVsvA
   nMkQli1tcLfwdA3nt7cVB236nw/fguSZ8jrpwwSQPi1VNmfghaJii0lZ5
   zF4RX8TzHywhoGCHYywwPk44Cwzhjd6FXmd5iZEwyGXh8FpvRK39QHBHM
   hJ3X2GAp0N4ZVl+0q3UqGNFr68LhUx318Q25MT+2QKgimKcPggj62PfLS
   9GwnDtLMVEDQQEQH6mAq1sz+gM/7VWq37tb9yJPOWP4M2jHv66nJwjlLw
   TtD/y1DK3A7mMX/6A0JzQmhZ+XLmZEJT/ihpwfP361qYUjre1cjptUYoK
   A==;
X-CSE-ConnectionGUID: ZPjj0htjTOWrmR2tO8uESQ==
X-CSE-MsgGUID: vuhEEYDxSfSbXibLLZLGTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="29773322"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; 
   d="scan'208";a="29773322"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2024 21:08:40 -0700
X-CSE-ConnectionGUID: pMHm8vgWQoGP0l36wOpktA==
X-CSE-MsgGUID: dVRwIg5MSo2E4lstfmr5Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; 
   d="scan'208";a="80575398"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jul 2024 21:08:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 14 Jul 2024 21:08:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 14 Jul 2024 21:08:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 14 Jul 2024 21:08:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuJP0QMcc15PcNv7z7qI2k9jR1iDvM4Ko4yG/vjvG53hozJQK7rHejfOxbQLMGAJ70q6S9ndIEUCncu9KSLfUC+4OD54XrhFhUInwGpqpFLK1vkmAcmhAF2dYJU7ADlwHB2lTgqRrjLZA5QMoKc7XsVM48nCW7kP0gSgNE0SOOwn7cGY5GA96dPw392tb+TyU72LtBuWjvG/w7qbTuC+knwJDhNBbq4eS/NyaF292XGbnkPlNGFi5I2LA9Xh5jMTkzg+B6IfSybsWfldflVUmUAy7qIGrw723nl6JfSRmgsBGDr1VF6SzX84AiUQceqbiTgHpU3w5CYfASlmU0vsfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Cs0CmAHCeCG/QpcIkqDaHJH52uUQTuK40OUmOlBOck=;
 b=Z/stoaGNXRlfY3Q2Tej+pKeegYpPSueGi4Xm83NO1Y63KkBodrzuc9meYsbCOaSTBHd/Hznt7sZjmzUOyZufPktnAyalYmr2QEmeuxAMOROwzFsRd3quvyKF7meztJkMpJIJgXwkN27FBAtB9+1FPBZaQLTEj6ZxeVdnr5xuULOhBFwWDECcysCurWAFjIAlN6XCnyA+yf89rhez5Pi8mXR0xkQvCXte2UmJsrGxVb4p7DKmzvjXEIwK3ioqThdX5uTR4UWOVI5yLceolR3GK6GFJGD1S9TcePRcs/f0RO1fWQHCnyKYBuKGGW6eMa+xaOP0xAkB8sTtscPZv7utIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY5PR11MB6320.namprd11.prod.outlook.com (2603:10b6:930:3c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 04:08:35 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 04:08:35 +0000
Date: Mon, 15 Jul 2024 12:08:23 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Muchun Song <muchun.song@linux.dev>
CC: Yu Zhao <yuzhao@google.com>, <oe-lkp@lists.linux.dev>, kernel test robot
	<lkp@intel.com>, Linux Memory Management List <linux-mm@kvack.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>,
	Frank van der Linden <fvdl@google.com>, Matthew Wilcox <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>, Yang Shi <yang@os.amperecomputing.com>, LKML
	<linux-kernel@vger.kernel.org>, Huang Ying <ying.huang@intel.com>, Feng Tang
	<feng.tang@intel.com>, Yin Fengwei <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: Re: [linux-next:master] [mm/hugetlb_vmemmap] 875fa64577:
 vm-scalability.throughput -34.3% regression
Message-ID: <ZpSgt6NQw/qz3MhV@xsang-OptiPlex-9020>
References: <202407091001.1250ad4a-oliver.sang@intel.com>
 <CAOUHufYdGbgnqNprKVUH8woMR_R5Wcc=281vcmm3+NRO-=+-jw@mail.gmail.com>
 <ZpPD4Mz3t5xT87aN@xsang-OptiPlex-9020>
 <CB8E06DE-0DB7-4605-AB19-19CF4F0F17B9@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CB8E06DE-0DB7-4605-AB19-19CF4F0F17B9@linux.dev>
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY5PR11MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: ccef1ad2-68e1-4083-2293-08dca483cc24
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmpnaDd3KzFDeWl1UVpKZjROM0xjYWRoOHY5bWt0azQ5U0pqMGsxKzJ5OE1W?=
 =?utf-8?B?aGZ0UHdURjltalNvZ3g2RU40TVM0YllCMGszMHBRSjNNVGwrQytNNjZ1eGln?=
 =?utf-8?B?ZW1HcCs3YUF4UGQvOS9ad2h3QWhxcmxBcVVaQTZyeHMweWllOEtUQzZsbU9R?=
 =?utf-8?B?ZC8yVUdIcjZGSWR4enVKN0VtUXlRN1A1UHMzVkg4aUh1OHlxUTZjSStTTDVr?=
 =?utf-8?B?MXRITXdnTEZKN3Q4K1krMUVBaE5OMUVJeTd3bU5mMEhHK2NwZ29aUG1VQzMv?=
 =?utf-8?B?M0RGWW9UdlZxeVVZM2lmV3NhQU02b0tjb2Fzd1FNWTBHbEVER0laRzZoYXB6?=
 =?utf-8?B?V043b21nVnYyMzVLK0ZzQ3pFUzduRnpLcHBCSlJiM3BlY0JPTzJaSW5BVldh?=
 =?utf-8?B?MDN0WUcyb1RRQzVoT3ljVnZsMTU2bGNzTnEwNzJpTTJsb2R0RjBvTHdYTklh?=
 =?utf-8?B?VXBjMVBycWorZVpzK3dMc3p0UzNyNDBoN0UvZzY0ZzRkblBiMHYxdHRKQ1Mw?=
 =?utf-8?B?UTVWZEJlbGRadVViOGNyOENibXo4VEVEOG9YOERWb0V6MFJoZ0pHRVNObnJI?=
 =?utf-8?B?NzlpdXcwaDA2MEVhb1JZWmN1Wkgzb09QRjNwak1QK3BwWFIwU1M2UjluUkRm?=
 =?utf-8?B?Zm5EcDRwUHJPS0ZWcVNQc2JxY05xRTlvcENHT01mMFh4bTZ4ekZVQWpydXVt?=
 =?utf-8?B?cXQ2VTU2SXlkRTVtbGtjSGpzSitscy9KYXc1L0ZrdldYYlFKNzJhT2svZElP?=
 =?utf-8?B?bXlhR0NjemVxT1liTHpBeUFzSnU3R2tDVzg1YXR6emtlMy92ZHpqN09lRUNB?=
 =?utf-8?B?YUhxaHJuVG5QQTM0TmduYjMwOE5FWmZldGtGalZRQjd3b1N3RlNHalVLOXdi?=
 =?utf-8?B?RFMxYUtmWlZMb1RZU3R2MnhCcUE4V1Z6bTllZTdsL25ib1hmd1Z6a1lYbE5C?=
 =?utf-8?B?NHNBQ21CSzZZQ3NiV0psVlJNY3hlaWJRZHVlRkd3RktKbzFhNUlTWDdtUFJM?=
 =?utf-8?B?a2FETjZCOE1aK2RZTEVnUFZuLzJQLyt6Rm5UWXFHK3AxT0hUdFFJZ3JGampn?=
 =?utf-8?B?dHQyWmwyNVBXWkZiMHU5aFFvRml4SUdQbGtSa3J4NUdqbm9qUHRiSWNjSDJw?=
 =?utf-8?B?MW9LMzRxYWd3VU5JSGV4MFhJZ2tCdzdQd0k0RzdVUEZEYW5VRWFnSjIvNWRs?=
 =?utf-8?B?Nms0a0w4aTJVZkZSTmFuODBPSnRNVG9JZ2J0UTNHZmRQRVFqUWZERHRNOU9q?=
 =?utf-8?B?SkIwL3NySDZOWUpON1NNVjdldk91SEQ0U05hQ2ptZ1dDOE9odEdVR1Boam5S?=
 =?utf-8?B?aE5ERVlVb2cxZ3ZlZmtFaE9Ma2tseml0UlBpQlhqYURlS2JVUDlGRGhmMEpW?=
 =?utf-8?B?REpYT3R4RGcxdE84anBqWWdIekk4d3JlWE94d3RxSStjMk1LdVRNRzVSSENu?=
 =?utf-8?B?My9sR3Q1NmdqczFuRE5jRllOdllLMnhIM1hQSnRGNU9xRjhRZGE1NTBQTFUz?=
 =?utf-8?B?enF0REhDVGhyOUdEYmNRRFloS205VU05ck9NVG9zWFQ1emVKUDNONDhQdjI3?=
 =?utf-8?B?ZGFhbXRaZUlqUldjb2RZWkRlNU9iaTB5L1d0cUZQNm9zMklyR2drUUlYYXM0?=
 =?utf-8?B?bzRObmhtc3g5ZjczTnpPWmk0b1BBeWloYXZLbFNsUXE0Y3lXTGFZemd6ckRK?=
 =?utf-8?B?UDc3QTZYcnJxQ0EwOStZSDRreENvbGNNNkVxUDQzZlpna0RQaEpRbWcxWHBa?=
 =?utf-8?B?azFkN05iUFE1TGZIZ0NWTHBya2N5QVNFRWZUZFZoY3VyOFVubEcyVDdBUnZN?=
 =?utf-8?B?N1BqOWNObmF3VW4xOWI5UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjRDTVdYZWNMR095SjhpSExDa21BdWVwcUV0cFVtOTB4NGdSRDFLUVdYTjBX?=
 =?utf-8?B?ZkFzb2ZHZXMzb01qbEJMc244c1FHTWxIeCtrNU55WU5wbGdVS3NnWXR6YVo2?=
 =?utf-8?B?VE9KWFZTeWltbCtQY3lrS2ZPZ0hwWDYvZmFOdDFiRFR3NEJRMTB1NEpPTFJW?=
 =?utf-8?B?aGc4OUIxU083UHUyN0JrS3ZjaTNqSW1TcUJCeU1nU3ozdmpVbHpCWE5EUVJL?=
 =?utf-8?B?d0RlV2UwT1F3ZUVnemFvQWpJZGE5S0FCME5PTjhUdVc5ekZnL3F5QzM1aENj?=
 =?utf-8?B?STZ0c1ZJbzV3cFczeHJDL0c5Tmg5RWFCSCs5c3VFMDZiYm5qNFVkMGczcGx3?=
 =?utf-8?B?dkQvZ2ZKbVMzeU5GSlFCYklOUHdPQkFvaVdjT0RMMHN1Y2IxR002UVV2NUdl?=
 =?utf-8?B?OVNLZHMvRXM4cHRGSTdHd3NwcFZ4T1YvTTVsRzBxSjZtUlI5YXhIeEJzbDZu?=
 =?utf-8?B?blU2eGZtQzRRUERYUWhsVU1iZE12SUNnd1IyMjB6Q2lGUWMrVzhoNGcyZU4z?=
 =?utf-8?B?K0VMRjR2aTFVdTRjRzkwVk1ZSUthTWZzbmNCWkpsYUwwU2Fpd1RHWkNiWk9p?=
 =?utf-8?B?bmVSTjFZOWwwT1JmUWtVS2ZabnFncFY1MG15eWJNNkI4MFhYK3pXWmZmc1Vi?=
 =?utf-8?B?RkJJMnljV29tMmRxajJTTUlmTTlocFQvbDlHMExFcis4alNXSHZLZkF0a0FK?=
 =?utf-8?B?S2tYRHYrYXlNY0loZ2ZoZElOeDMvT01JSGFJdmFkSlBNem5JQlFIUHpoVmxk?=
 =?utf-8?B?Z2NZd29EVEkyVDFSNjd1L0h5ZnV3UjczMVZmRkJEYXV3Wm45MkFZc3dzNkEw?=
 =?utf-8?B?Tjd5U2ZMKzJXaHU5eU5BR1lLYmo3VXQwRFJycXIzTW1vYjFTbElTODJ3NXFF?=
 =?utf-8?B?TzlTOFd6SkR5Y084RjVpUnEvM2I4ZFVQTm5lTlZzK0RpTzZXeEk1SG1tcG1I?=
 =?utf-8?B?Z1M2SHVBTDVtVkxxTWx1NVIyQW5xUkRLaDFuZ0ZTNFRVaVBGUUlWNCt1eCtN?=
 =?utf-8?B?aTNReC9rTVNVZ3pwalJrRW43NjZucE5lVFJVa05BSW9uMDVmK1ppU01TWC9P?=
 =?utf-8?B?N0xJbFd2VXU0M0NzMEdZYzFEdktOWUpxVFA4TFV3dDN5TWlqczJ3SWhGT21Z?=
 =?utf-8?B?UG1NSlA2UDFXWHlCZ3lad1lMSHNFQ2VjNHNBWGQ2Q25WMWtIU1F6Y1B1bEgr?=
 =?utf-8?B?QjFZUTV5K1lFU2FSYWRWM2RxMktXNkxIQlQ5dGxPTFJmTEoxbFprNnhLYXZW?=
 =?utf-8?B?LzlqbmNRTzVlWFo1QU85OG9ld3JzNHErYk5vOHIrRlhzdmdoVjVqb0JvWHQ0?=
 =?utf-8?B?TU5XOGRXc0JFTE9UbkRuMHVMWmNzaDJFYU91Z0FGQ3pCYTRkclRkb3M5QlFX?=
 =?utf-8?B?NDBSN09YQy84ekNPMVB4L1JZR0FOK0hxN0tPZU9tUGFWcGt6SXRmcTJKVVYw?=
 =?utf-8?B?bHYvQ1VlUmIvUU5TanlhcHpZNHNxbklPelo5MFA3T0ViMXRLUVphR3ptVXlz?=
 =?utf-8?B?ZlUwOUVFRDUvdE5na1NnSlhFbGl0eWpha3RNaUszQXdFZXhIbm9ZbTdaR1NY?=
 =?utf-8?B?d0F5TzdlUnR4TFJ3LzJ3Wm0yM251WUNDT1R6TDVITXpxckhhQmhkZlNLRysy?=
 =?utf-8?B?QU4vZm1jOXRhUWRaSFRkZjVUc24vQk5rL01FRDlvN0VUWjFGNXRESmE5bkli?=
 =?utf-8?B?V2t5V3pPaDNtbmZrbW4wQXBFNVdxNjFvZ05KS2szb3IyZWM3KzhhY0RIUlFJ?=
 =?utf-8?B?RFRxTUVUYnRMS0dhSHJIajcrS2dxd2ZQN2FiaWFtcy84ZllKc3doV1FGQTZl?=
 =?utf-8?B?eWRkSDJ1cDZXTE9GOTM4d3ZkT1p5djB5V0VzVi9JS1pvNStaZTZuSy9LVzRI?=
 =?utf-8?B?WkhNRGNzLys0WVdUNE1GQWQxbmpjY2ZMUmpMRk0xQTdBNVVLd2R1aU5PaEQv?=
 =?utf-8?B?U0NML25KT3VFVXlRdlNaYUZLQ2JYOUhXcjhtWWQ5Z2J1UVBsVWJielpxdUkz?=
 =?utf-8?B?ZlNrZVcwZWJiRDdnempzaUFHYkhVSGk0RzArb0xySmtZQUZ0bVdHSk94K2Zx?=
 =?utf-8?B?ZnVCRXp5N1ZSMmRZRXhMS25pL1FvbnpvUExVM29oQnA0OTh2eENSVjVMOWNr?=
 =?utf-8?B?UVl3SVpFRlFJeVdrU0FOYjRmNGI5NHcvUDRjamVwSWxNQWhwc3Y1SFpieEx2?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ccef1ad2-68e1-4083-2293-08dca483cc24
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 04:08:35.3340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5pSD4+z9KUOYGm4KDCAidPEwfyVSQWirln+IRIMoOjXo/Tf/uKgoNUTeM/InVjWpONbJhmr+hUjLeTT6gEjyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6320
X-OriginatorOrg: intel.com

hi, Muchun Song,

On Mon, Jul 15, 2024 at 10:40:43AM +0800, Muchun Song wrote:
> 
> 
> > On Jul 14, 2024, at 20:26, Oliver Sang <oliver.sang@intel.com> wrote:
> > 
> > hi, Yu Zhao,
> > 
> > On Wed, Jul 10, 2024 at 12:22:40AM -0600, Yu Zhao wrote:
> >> On Mon, Jul 8, 2024 at 11:11 PM kernel test robot <oliver.sang@intel.com> wrote:
> >>> 
> >>> Hello,
> >>> 
> >>> kernel test robot noticed a -34.3% regression of vm-scalability.throughput on:
> >>> 
> >>> 
> >>> commit: 875fa64577da9bc8e9963ee14fef8433f20653e7 ("mm/hugetlb_vmemmap: fix race with speculative PFN walkers")
> >> 
> >> This is likely caused by synchronize_rcu() wandering into the
> >> allocation path. I'll patch that up soon.
> >> 
> > 
> > we noticed this commit has already been merged into mainline
> > 
> > [bd225530a4c717714722c3731442b78954c765b3] mm/hugetlb_vmemmap: fix race with speculative PFN walkers
> > branch: linus/master
> 
> Did you test with HVO enabled (there are two ways to enable HVO: 1) adding cmdline with "hugetlb_free_vmemmap=on"
> or 2) write 1 to /proc/sys/vm/hugetlb_optimize_vmemmap)? I want to confirm if the regression is related
> to HVO routine.

we found a strange thing, after adding 'hugetlb_free_vmemmap=on', the data
become unstable by run to run (we use kexec from previous job to next one).
below is for 875fa64577 + 'hugetlb_free_vmemmap=on'

  "vm-scalability.throughput": [
    611622,
    645261,
    705923,
    833589,
    840140,
    884010
  ],


as a comparison, without 'hugetlb_free_vmemmap=on', for 875fa64577:

  "vm-scalability.throughput": [
    4597606,
    4357960,
    4385331,
    4631803,
    4554570,
    4462691
  ],

for 73236245e0 (parent of 875fa64577):

  "vm-scalability.throughput": [
    6866441,
    6769773,
    6942991,
    6877124,
    6785790,
    6812001
  ],

> 
> Thanks.
> 
> > 
> > and the regression still exists in our tests. do you want us to test your
> > patch? Thanks!
> 


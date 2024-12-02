Return-Path: <linux-kernel+bounces-428479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 340CE9E0F01
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FAF4B23986
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9091DFD99;
	Mon,  2 Dec 2024 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKRJf/3A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B001DA116
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733179610; cv=fail; b=kHGMqTpnbPu+xgNq2u1YhYLhB1AZ82eOtuh7wlMAsozdDpoZvh9EJ/gsqdO7Hjy/6pox1W6VhFGqxcOeIPbihABIbb4VBMx56ZZkbXtA8H3pYZobsZda9AhGOHoCB4leVQYY1OfbK3fz1MdzWbBYpUDL6UyDUfyrmNwou4eHHXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733179610; c=relaxed/simple;
	bh=NCl7DDXzBy0QDdXT3mwlQrk77K+G0f76b3EMEnZf3rE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ETkY2fJKjz3dm0D8cownXadlXBezL3CHPjiiTBxMjMAlTX6X+oOflFK6Po9iR48HLRtT4hOLHsghfumMK8FpJkzaYHI5DHbqab/iuuDUztBwx/Q1yBur8V/WaFFMcGkPoWgU3VhfcYLalxbvmIrAcd1oySoxFhrl00MSILsiPSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iKRJf/3A; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733179609; x=1764715609;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NCl7DDXzBy0QDdXT3mwlQrk77K+G0f76b3EMEnZf3rE=;
  b=iKRJf/3AFG2t6O93FOGMY+W6YpjiMBwg5y3esvtav/IWcmCqVot1Dgnr
   +CZB+xQaeSjEK3XTWoC59einjFAGnWsMfC553qJoH7oq3njM5w+GawZKw
   4afamdQj4Ys+CbjnmfjT2mPuDGReIrFDC2pwSGB3y0bdKcfubdYUL0DeL
   jULynzpDIbb4ENEgtYIvoAWeEDwpQolT3+MhYFqgNamz1t/Cbc/vSlByh
   a3rzkWc1Xk0mvbBg7uwxMHdjF3Nf72LF+caIq29gpgVBvdmUzudUq55NF
   0IvPb1RX//ussUs1s5RL9uD8ZqUFbpgMkgGzaLcYIxJ7ILKtmgASCpd0P
   A==;
X-CSE-ConnectionGUID: H8SdsfnAQ0WqSSa/kj2q1A==
X-CSE-MsgGUID: yQ1mpOkoSt+6BnmaVk+INQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="32727044"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="32727044"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 14:46:48 -0800
X-CSE-ConnectionGUID: Gu2zWloVS/+os4SWY1YLww==
X-CSE-MsgGUID: SrJrCmpdR+WKwEXrsCsIsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93331362"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 14:46:48 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 14:46:47 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 14:46:47 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 14:46:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOyOgltzHE3YquSC7V2e3rRwrRnMzL+3/Yp2C5ielCXBfq5ClwxOWzAlxDpfA64MZBSc1D8bx1mJTBJUfOz13eBnZOW28SYMCKsXdrE05Z5db0DEjjd0oVWU1GfRoMOsV7PfY78Vq7AUlfnImwQRlQ3lORLwdHXRs+C1RR+ACl5Gc3Uiqy1WtYxKFKxfebnIhZrQu6NLYI3NLUSlMNdje5/zgAsCnJbYUc6JNHIIGZaUxW+Ezca1QeRTJTYp3FN2MMwgbxXOyQSg7U9y/lQN/1d9udG0mYif74aHe3mlZMCggQslpIAGvhpW+AKHZqew5uLOh2s9rZgStVKXPhIjIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgGCfLrBFJNcr3apFHTFnGLkHQ5IwMgj908wrbY+HYY=;
 b=puDpzmkC7ADy69JjXR7LNsJOem/fa2nf/0LStjGhXgEsVwr0L572fgkRp/EYIs0I0PWeyBVAxQcwqZSbrfUsl4ntBIjXKTOtAWEikRjB0RjFgbxbH02L6Wnmz0s1n/T6j/N96HfipJ0PFhfDf3qetLJz8vgaQPX3bsqGKUs1Z3rVV13SPyX08l+UQ2FqEUaRs51dDusukbPz8Bshuz6tJnkG7nVJeRCzB5tSz56S4S9VbDnzUzX0+cDA81tnrgjirCgrDYaOaTCg3sr6udU2FNccM/WyzmzX8jSefvUpRUH4nMJeHoUawTdmegzBT+lMWYzj+xmLldNH025+Cud9rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CH3PR11MB8316.namprd11.prod.outlook.com (2603:10b6:610:17b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 22:46:42 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%7]) with mapi id 15.20.8207.014; Mon, 2 Dec 2024
 22:46:41 +0000
Message-ID: <fb8d4e7f-2704-265d-65a9-1e3e37b5fca8@intel.com>
Date: Mon, 2 Dec 2024 14:46:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: resctrl mount fail on v6.13-rc1
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, "Luck, Tony"
	<tony.luck@intel.com>, Peter Newman <peternewman@google.com>, Babu Moger
	<babu.moger@amd.com>
CC: <linux-kernel@vger.kernel.org>
References: <Z04pz3AlvI4o0Mr8@agluck-desk3>
 <868b451a-fdba-4b45-bff1-9ac1023080c8@intel.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <868b451a-fdba-4b45-bff1-9ac1023080c8@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:a03:40::48) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|CH3PR11MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 005e1ed5-cb3d-4086-edd6-08dd13233067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzdPaFhxR0FoT0ZZd1VZenVBbG9pcThOMW5FMEs3U3p0aE9RTld3ZTdCRjZT?=
 =?utf-8?B?N1BHcWl2eXFvUGNDNGNnZUlkRWhCTHVKYyt3N0FWNFJralBpZ1JuWTZNMUxx?=
 =?utf-8?B?OHJOR1A5ZmN0OWJIdDY3RExRNWVLSlgzc2tSYUdPeHFWdW5yWlhKQ2dOVGNq?=
 =?utf-8?B?WnduMHVMQzBmcmFvTUhrbzk4a2FBYmVDQ0d1ak1MVFByYy9KbmNXK0svNTl5?=
 =?utf-8?B?aUJiM3gzQzdrcUJ2dHB4K3ZmWjVYNXVSK09ZZ05JVlJ1SkxsWEVxcnErMjRV?=
 =?utf-8?B?MWNYTklRa1ZIT1d6TWwyNlh4VWw0dVkrejBtTUxSd2FrTHgzUHUwK05UcGlP?=
 =?utf-8?B?TEhsT2lvajdKbGdwUCthYkl2d3p1bytEdXVHT2JNTWZTM21xbkJiellGRFlV?=
 =?utf-8?B?ZnRkSVFoNnlRNEpoV1JVSEVlQW5JRGdvaEhNNStFZCtTajRKbk1sa2Z5Y25H?=
 =?utf-8?B?MUo4dzQ5MGkwUHZXTW9vKzFOVVhHbGpKdGxPQWErOWk0aWdVSENhQzR0dHdR?=
 =?utf-8?B?Y0lnb1FoY0FvdENKdWExZ0V3NFBOa21CTzZEWFBVM0xzVWNVdjYzOFlVWG1H?=
 =?utf-8?B?VG5taVA4ZmFvS2dzcy8wOFFCMVNmeUxETi9MTHJaRW4vSUd4T0JqdW5wNVNW?=
 =?utf-8?B?SkxlV3lFWUowRnVSRWpIM01sZThnU1hwamU4WHIwVnQrY2pkOGxtdnAzM1VR?=
 =?utf-8?B?R0oyUEZnbmdYeG0ydkx4akdyWGV2aktacnBJYi9uNlV2Y0ZIL3MzTXhQdnk3?=
 =?utf-8?B?SHl1cE1Ld2N4L0hHUDJRN0NhZFBoakdtWmo2SXZZNE5tRzNZdERLWDlocGtP?=
 =?utf-8?B?aWlidFVlcER3QUt4MGpwZEdpcmVKZGE4NEZjQUZDMStIbXlvL2tjdlM0VFdN?=
 =?utf-8?B?MmdlMlVrZk9sUDdPRG1KY3gwbWhJa2xhM1F4c2RRQlkwcUxJenhqK1J0bjEx?=
 =?utf-8?B?YUF1V0JkbnhTRkxtTHVpa2h3T3ptSmNGUjdYQkxvRmNKL0htcEhwZDlqL00x?=
 =?utf-8?B?UUNKck15VHhLeFVyUys0WWo5ZTFUT0VBdGFwSEpoOEFJalZBeUVrMjVqNldR?=
 =?utf-8?B?U21GODg2ZGxPUUFOZUZHT3RwMFVmT2drMklKU20zNis3OUtKSWlQM1hZQ1h1?=
 =?utf-8?B?VDZFYmJGQloxdktiNytlSDBYaTF5UkxFVUx4Y3pWVkRDbzNVVzR2bkh4Qnpp?=
 =?utf-8?B?SUtZbnUrMTQxaTlaeHJHSjBVeWg0WEJybTYrNmtnbWlhQ2ovLzlhVHdWQVFU?=
 =?utf-8?B?eDRiN2MvTXZ3SXc1RjRtc0NZTjdFT25PWURFUTdPTHFyVCtpWnUrNnVzL0R5?=
 =?utf-8?B?MkcyU05NaVU0V3dtZERkREUrNlVBV2xDTzRBc0xPTzRUa0ZScmwrQW5IQjNW?=
 =?utf-8?B?U0c0TG5nL3lyT0dNS2gvTFhkSG9XemZzMHBnSWwxVjc5ZlB2NXEzV2hLaFJz?=
 =?utf-8?B?ZlR2aXpBR2k4OTZKdFk0cFczV0hYL0M1aUhTdGNwT2FtOGdUTW9oUUZFcS9r?=
 =?utf-8?B?cWFRdFpZbWZUbngrMTNjcURwVHhGT1ZpcFdOdmZ1Z3ZrWEI1Mmxob2NIOEtF?=
 =?utf-8?B?SEYycnpwTnBubEpxVEJ1aDdEMWdoclN4Uk9lTVFGQk0xa0lxckVWelJlZWhY?=
 =?utf-8?B?MUo1TVJrZThJeFIvNFp3SFFVQ0UrUDhQcEhLVjNnSXpDL0VKYnpiQWFocWwy?=
 =?utf-8?B?b0hQVkMvdnNaUS9EV2xoQWNGVXBDMU8zK0FDcXI5UzJtTHZDekM2emFxWUQr?=
 =?utf-8?B?RG9CSjdzQ3h3N3lZMDI4NDF3NmpFRE1YbjNyci90dG83QnpQNVFUaEkrbUhG?=
 =?utf-8?B?cHJqbENSYlI2ZnV0RFd6UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0pwRjZENEx3MTJnZEZEWXdMMnh4TExsQU5peldoUmdPREZNbE12eGFQa2hq?=
 =?utf-8?B?bjlHZ1Z5VlF2VnQ4SGMza3VIWU1UbHEzS2xEZmpBY3NYczRIa0xBZmRXT2tv?=
 =?utf-8?B?RDVwdDV4ZjlVRTJvQjNJZWcvMFJDV3BOLzVKdTloR2RpUUM1ZVdHK3BZUm0z?=
 =?utf-8?B?SExUSElNanZpc2ZFckpucnYrcFJ1UzRwczJlMEJ2SHBFc2dicmpIRjVYK2FJ?=
 =?utf-8?B?dmRVWFhCQy84WTVtRmdwTVBZTmZVRDNqdHUzKzJNUkVhVmkrVUVPVWhNRGN4?=
 =?utf-8?B?QWJmU0JpVnAwaEdWb2NTM0RzSHdvR2pmdDd4ZHRFd3IxMGpPZ2pVUTRMYmla?=
 =?utf-8?B?TGprVmU2SW5yd3pnN1FmcHVWTnlEdWRnOWhGZWU2anRJNHlqeGFjdFJDb2w2?=
 =?utf-8?B?R3laVSs4c3RiODAwTklqeFdMZWIyZkE4VzlpVzhCN21wWWVDS2JEN3NJRHpH?=
 =?utf-8?B?bEY4VlhnOUtXSnVzZ0xUR0pZOTJkZGlXSHNKb3F1RDYzdHJUOHBqUU16YzJm?=
 =?utf-8?B?eUZ2QU5ibnNFdjcxMVQ5ak5BbjNtZ09WdllRSDAzL3B0VWcvUTdMSUkxcFZE?=
 =?utf-8?B?OHc3c1hiZXB5T3BwbGdHbVJzcDNHcnhmUEdBam9UWm1nWmdDd3FhZDBZL2hG?=
 =?utf-8?B?SGg4UkV3Tmw4eFhRWlNqSlZQbjJscURCbGZrL0VBNCtZQmNIZGg4TENkeW1w?=
 =?utf-8?B?ZUFYRE1iNkI5Y3NPRkFIYTVaOTlkb1hKMEJQa1NUaDhVaktENjY2YVhRL2FM?=
 =?utf-8?B?WUNFSDhacEJYM0phdFQwTXY0aGswalFHeFFhVC9aTHhDOFVYclo3aUNZaVdF?=
 =?utf-8?B?NkpaazhTcUpZTHAzaWtyRjdDb0ZZOFhka0Q5Q1NlcXI1aU01TVowUDZRT3ZN?=
 =?utf-8?B?SmN4Y1pHeXhFM1JVNUtrU1o3T0d6L3I3ZUNSNXhPTTR6NkhaV3JtTHlURmph?=
 =?utf-8?B?MmZRVVp6Qll3MHQ3aG4wZkNkS0xWNUVEcUhxRCs3cTBGWU1pTCtiQ2xEeERO?=
 =?utf-8?B?YXdBRFpxRlZ5VnNLMW83Yll6c3NjZXZVQk8zS2xhSm5CejVLT2JuSzZMZW1F?=
 =?utf-8?B?a1Bpd1VYTEhKTGFJVm1hTmNOc2hrZTZJbThoSU5xYlJpUUEwWlBSbktlaGsx?=
 =?utf-8?B?SG1tT3ZGZ2lBbldzQTBCb09jR3hWSlA3ZlRiNWlxOC9sRnBwQ1B6enZSN3NB?=
 =?utf-8?B?MlhtaGdoTWZSRWJXa1d0VWl0N1REeUN1b3ovOTcyYzR5em5EY3Mremo2MzRp?=
 =?utf-8?B?dngxUExQQzBub3lDRGEvbTNDeEFLRVN2eHdOSlA0ZS9DK2cyUXhYc2hUQlJZ?=
 =?utf-8?B?YjhwVnRNajJqbjhQam1GNldXbVA4WmUvMWdXU2RCZHhSRkxZNy9EMmVjdG9p?=
 =?utf-8?B?L1ZvQXpsMXpvT09kM2E0UlQvd01GemFRcFRWVC9zdlp5bGhDeDdsMTZFYlJ3?=
 =?utf-8?B?TkYvanpGRlpRR1d4UU0xcmJ5U1lwcWFXdDZNR0pBd3FyUXRlKys2endkRUI2?=
 =?utf-8?B?YXJrVWhxSnJBek83dkZOYXdLMlVLeUQ3bUg1ZHp6SE9ZOGtpc21FM2l2OUlO?=
 =?utf-8?B?RmlpSE50T3FyNXFmdldjMGJUQXp3MmNzaWh6ZUo0ekw0d0FGOUJQbzcyeUdY?=
 =?utf-8?B?T1dxaXV1YlU5V004NTRRMXhFSGRsQ0FDeGJpQTkyS0ErdEJHMEZlRTUxZXg2?=
 =?utf-8?B?aGV2MXg4ZGkrNUkwaEdtOTBYdGhXQ0F5ODA4UFIwcmROWjV1NGlONm5SVVB0?=
 =?utf-8?B?WmFuaTVmM2pjakxYanh0blMwREw3NDkxb2hTOUQxeFhITmxuTlgrdFRPQzFK?=
 =?utf-8?B?RFdjVFF3ZTZuN0Q2NFNUemUzUW4rT2NGV1htM2VSQjFkTjk4VG8wYXZIdERV?=
 =?utf-8?B?SWxlNU5UVzVqK2FEMlFOWTZLMjAxVHZ6N2w1WjJMRnRkSUZYeWNYeHpJYmtG?=
 =?utf-8?B?cVR0dWRzM0F1bkJjK0JxbGdHS2o5Y3U1R2p2M2JOK2xpTjFWNXpPYTdQc1lV?=
 =?utf-8?B?YVpJU3dIdFZoek5FYWtrczVNNDhOTTcwQ0I0NFFDZ3RpZ0dsU1VuTW9RbzlU?=
 =?utf-8?B?cTRrR0lTUldrTjBvcWdJU3lXK0VnOUs4SVFtc0Y0M0NmdlFHR0s4ajNvVCtB?=
 =?utf-8?Q?jswjM5ne64SttDIRf60ug0wn6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 005e1ed5-cb3d-4086-edd6-08dd13233067
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 22:46:41.6077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3OkkkvJc8004ZwoYpGRRld0h6FpgMghEv3DSgJrrzp7zaLy7q1o8JE7uppCNQ1KsdV4201AERwNawgchJqHBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8316
X-OriginatorOrg: intel.com

Hi, Tony and Reinette,

On 12/2/24 14:26, Reinette Chatre wrote:
> Hi Tony,
> 
> On 12/2/24 1:42 PM, Luck, Tony wrote:
>> Anyone better a decoding lockdep dumps then me make sense of this?
>>
>> All I did was build v6.13-rc1 with (among others)
>>
>> CONFIG_PROVE_LOCKING=y
>> CONFIG_PROVE_RAW_LOCK_NESTING=y
>> CONFIG_PROVE_RCU=y
>>
>> and then mount the resctrl filesystem:
>>
>> $ sudo mount -t resctrl resctrl /sys/fs/resctrl
>>
>> There are only trivial changes to the resctrl code between
>> v6.12 (which works) and v6.13-rc1:
>>
>> $ git log --oneline v6.13-rc1 ^v6.12 -- arch/x86/kernel/cpu/resctrl
>> 5a4b3fbb4849 Merge tag 'x86_cache_for_v6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>> 9bce6e94c4b3 x86/resctrl: Support Sub-NUMA cluster mode SNC6
>> 29eaa7958367 x86/resctrl: Slightly clean-up mbm_config_show()
>>
>> So something in kernfs? Or the way resctrl uses kernfs?
> 
> I am not seeing this but that may be because I am not testing with
> selinux enabled. My test kernel has:
> # CONFIG_SECURITY_SELINUX is not set
> 
> I am also not running with any btrfs filesystems.
> 
> Is this your usual setup in which you are seeing this the first time? Is it
> perhaps possible for you to bisect?
> 
> The subject states "resctrl mount fail" - could you please confirm if
> resctrl cannot be mounted in addition to the lockdep warning?
> 
> Reinette
> 

I can reproduce the issue with
CONFIG_PROVE_LOCKING=y
CONFIG_PROVE_RAW_LOCK_NESTING=y
CONFIG_PROVE_RCU=y
and SELINUX enabled.

Thanks.

-Fenghua


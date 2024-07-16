Return-Path: <linux-kernel+bounces-254032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B53932AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DB31C22AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0955F19DF52;
	Tue, 16 Jul 2024 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2bQUi1t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C841DA4D;
	Tue, 16 Jul 2024 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144353; cv=fail; b=s/+RWaTA4wt47KklfHY+0XC2O7LLe4A9Q8JLbatN2e3XtNiaWRrARG0PrSiffs2VweqySA9N1m5Mh2OnwHlK6E4awO8qvpReKic5jz9DgxDN40zvMNPAC4oePRjp9CXc+x086/PQNoV3vtIZVGeMDub8KRCFDWkYGdH15+oxpjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144353; c=relaxed/simple;
	bh=dq1XXAVuYU7eOGFy5QZE6PxnZcjIFCpOG8hzM1cx3ck=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V122153178yvbaKqE/OPqUWZP/S1y978GOFnCDjn7ePbIEGHzfIUMil2P7G4DezC59yR+h2j/M2ZMj6sJ38blv+wmCNsfYlmX117HDUUHRCQFkhYXidY7ayIaN6aEhZ1HEqFjsc9MmdFCOKLDwMTbUKDQb6dMZU9nbHwDTthLSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2bQUi1t; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721144352; x=1752680352;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dq1XXAVuYU7eOGFy5QZE6PxnZcjIFCpOG8hzM1cx3ck=;
  b=N2bQUi1tOwy2zfUSYQrdl74emk10dMQMGmYtoN3kKy8ZsFyeG+zsxtRG
   xELhK7iKldNlk0ZJmmKTLd+D6LOsRDPApGYl1O+5Hs6f2f43A597fF8MY
   s+mqYDaGSB6XMee717wdNCqkas0IKblReJhjQUgtJb6ThJ57+1Rm0GQ/H
   MewCZIalkUJCyJ7ApojrO6dpiVr6U5vPz73+lAI0owlHib9UmwokuHn1p
   zCiOHsQq0ZmbHbQnfwgp5v5o0nvQN7Niof+MMen7dvRpF9KWflxbdUnSP
   l6jlMIuRmnxPv4+E90raNBQydOgb9TPfYk5IKsy+cAuNiGEGitsEgSmSk
   Q==;
X-CSE-ConnectionGUID: JGxU6de3QmiAqxLsj4BRTA==
X-CSE-MsgGUID: 24CUp9WWSmKAGcOHy2L3Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="29200007"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="29200007"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 08:39:11 -0700
X-CSE-ConnectionGUID: AKvF8bzOSc+56Uf15pTmUA==
X-CSE-MsgGUID: rUmkyJ0HTlKAQueHuwiZfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="49981472"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jul 2024 08:39:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 08:39:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 08:39:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 08:39:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjeqXVS26zNR90nnPMaeBXTS+Bs8ycEAhebB+eMDpN/4UrIO9ZC3oQj0dNYaEV9Ze61f7az+ojXjKK/fsY2+LimjoZ5uKQMGZOfvFBCJGq4hHlC75knFnFpDqJJ63a3eslghd5zUXaxahDAKRnJIXVLQQqQNVxJWR66oA5A0irm5rt/VpwWENKMMYG7iaxGS4NuS2q+qjCKexHJTlAYrvVlYzme1wOwziNxPPMf+s9ybIMheQ/zE5+Wl1SjLXxrIhbz0TebSUlBUFQSP5t7a4ix5M32j8yxTFjnxMJtl60PoxXxg5+h5Cxg/ct0HrgxN7L9bR8z0mfXPSOLmk5HKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvYe2qldavWFq3W2dIU7WiYcmDUqXv43Wx/8bgQ5/ho=;
 b=rqwMUGc1vqpsx9FM7nseasQBlIdytnxuLAvOQYIC/3ertQiyJwjh6UOHdszK1NmvXC3lhUJKikjzB0g6y/o313bpZP4BdimMfT7H+8tkqJD1ejB1nR+jaQz7GFk7HJvAMaxHb7+n0AbGQoJDu6VumQ97w+9ks5zGUwRVepXmuUtUsWVFgvOYU35v74n/jCjv2uCFz46rLjEM9lQUSoM/Op5nrekl3vOWmSlScXvJA2zABf1tv6LVRobffxCgTAYYYwSE7r8FcfSJvDP/N5P5OU1AdpVATziWchUhfJ8vo9JFzW+4/dI/bdRzHtgSKRe+Y92OAN9HclYQcw0Y+s8+Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6822.namprd11.prod.outlook.com (2603:10b6:806:29f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 15:39:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 15:39:07 +0000
Message-ID: <6be685f7-e99d-42af-b26e-d5e542f597fd@intel.com>
Date: Tue, 16 Jul 2024 08:39:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Slightly clean-up mbm_config_show()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Fenghua Yu
	<fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <b2ebc809c8b6c6440d17b12ccf7c2d29aaafd488.1720868538.git.christophe.jaillet@wanadoo.fr>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <b2ebc809c8b6c6440d17b12ccf7c2d29aaafd488.1720868538.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7a760b-08fe-467a-63f3-08dca5ad6de8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SE4zdldacGRrVnhnUUtOd3ZjSlkrWUcvS3dlVXZQaUNlckJLemlhQ29ISTdy?=
 =?utf-8?B?RUN6bnRuSE9sd1ErQmlEOWl5OER3ZVpxeFBDMHlEbERVSVp5MDIwc20wNnRD?=
 =?utf-8?B?MGZLbDA4bXpoZFN0QnYwZThRamN6WXluMzRNWVJtczRLek95U1E2bklVUHYy?=
 =?utf-8?B?UUdKaS9GSU5JNk11WVNXVFNWLy9sSjNYZUNPNHhWNzFURWl3eUhnOFFqcW8v?=
 =?utf-8?B?MG41ZVF2ZStQU2x1Z3FCeEFlVFVObUo3S0JFdkxTK1lXWG1RWVBROFRzS210?=
 =?utf-8?B?NGZ1RjV2aGdMTXFDYkdXREtHR1J3RjVRNTU1V0h4OTROQVFLOU8ySHJFZGpW?=
 =?utf-8?B?RTAwbDRRN2RUb2g1MXEwVDNvZ1hRMFdkb1F1bzVld2hjY2RTZ3crUjQ5SG5V?=
 =?utf-8?B?WFk4RzdMUVIrRlNiS0JrZC8xQzNWb01aQUpQai84RFBZbVM1VUxLTWg5cUow?=
 =?utf-8?B?eWZTMldZSDBxMW12S2FJVys4b3BIRG5QaURaY0YxL1lZMFRJdExnK1VpTk8y?=
 =?utf-8?B?YTh3N3hiUjdEd2ZYTWIxM3BPeStTZ1N5TEkvYXJOTmJ4WTNmNTNSM080bjF6?=
 =?utf-8?B?SElHY2hPN1pMMFhyK0VSS3hIbUlsbDBBNWZPUVRKYWF5cWtlcUlSb21RdkFB?=
 =?utf-8?B?M1N1bXc3L01xMkRPWFdWbHNYYi9MODkwYzlQRnlmMFBWZTBxcFZlNVV3b2hw?=
 =?utf-8?B?Wmk0emtaWHczRkJ3VUp2aEk3dW1ZODQ4ZEppYi9EK1RDTkxicGphR1BhMTRE?=
 =?utf-8?B?V1JXVEVTTFg0ZlFYODRyNEEzSHBLcmcwYVpmbU1xN0VZMmdRczk5TzJoeTJQ?=
 =?utf-8?B?dlFuZ1F3dyt0QnFHcmNGV1hveHdqeTBlSjlhZWNUSUJ2ZFpqNk91a2txTzNY?=
 =?utf-8?B?bDVMTXkvWTkzaGVvdWxHczc2emd2eFFoeHdoWkcyTWRJR0xmVmFhOFNQZjZy?=
 =?utf-8?B?UWxiSll5Ky9JVFlSYTF6VHBsdXpxSjlqZ2Y3ZGlONnM5bDRlTmpGSmFXcVFv?=
 =?utf-8?B?Tk90ekRiSFV5amJUazlVWlgwTmRMTldvSjFVQ2JXdXhsTDU4SjQyeUlaaG94?=
 =?utf-8?B?dURLRzl3cGd5THE4eGxpaTRZcnk1U0hCdTBDa0hzdDg1aUlNRjE5ZGl2dXEr?=
 =?utf-8?B?ejFMMW4zMVA5VFU5YWplNHg5dEpwR0JYM3dtbk5yZW0rNWRTZVplcWE4TXg1?=
 =?utf-8?B?RW9rellnVUM0TzVjTzJIY0N4aENVNlp6VmFYY09SV21rellFb0hhRkc4WUNY?=
 =?utf-8?B?eW9acFF1a2JRbnVuUFM0eldqRmdiZ1JWUklvNFgrMTlNdGNSbk1QazUwVGoz?=
 =?utf-8?B?N3BXTDFZUEtkVmFENTRWSE1RbHE4VEdKNXNNWHpPaTNlNVNkQTRUTVRQWGtB?=
 =?utf-8?B?UUhhcEFPb2V5RVcwcElnL0VDcXI3bkJvR0tvZElITEliRHFkeHZOZHROUFV5?=
 =?utf-8?B?a0I3clY0SHBXdnk0OWZFRlBWaVN2Nk03Yk1JNHBSRXFidGJNbUNTNWF3R1Vk?=
 =?utf-8?B?ditOYlNGK1BoRE9nQVZzMWltM0x6QWdnK1ZWZHpGM0VwblRva2MwTHJwd2Nn?=
 =?utf-8?B?TXdVc2FVQzNtVEw4WTFiaUx4WmFlMHVOcWMzMEZ0SS9BcnE3MURCWkpmcVRU?=
 =?utf-8?B?VFc5dyszOFZjVmhBa3Z1NXgrMHYvZW11NlJrS25TNlVrTUZ5NG5td2pZM1lX?=
 =?utf-8?B?ZWYwTktFYm1ncitXTVRzMWNYYWpSUHQ5eGZTakRFdG9zRlFlVldXaGRaR1JS?=
 =?utf-8?B?enRDWndldUFNVm1YWTB4ejRjMnlGMktTWmdtNTVJajF3YTl5RitRMDZVUmJT?=
 =?utf-8?B?cUJzVjMzL3RlWGc3bVg5QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnJhRzloRzlNcVNMQjNHYmdqMWpha3VSaGRFRWZyWWZ0Q2hScWxVYjN6U3hR?=
 =?utf-8?B?WnU3ZldQTEZ3ZURSSE9wSGw0SEpHdnFIb3FhVFh5WUdaRFZwWUlrZzRzSWRu?=
 =?utf-8?B?U1BBbm5DWlpwNXd6dDIrUEJUZFJRNFVPZE1Cb3lLVEZJeGw5NjBpNHJMTXNG?=
 =?utf-8?B?bFc4eEV6MnluZWxtbytxQWV2bnNUZGFBSXV1ZDV0WFZQOTZUY1UxWUlYSkdZ?=
 =?utf-8?B?ZXRkRS9nclVscUYvQWwwNFg0OE1rQS9oNERCSG0rV2FseHZEVjk4QTY5dlVw?=
 =?utf-8?B?cWIyaGN6WXFhMVM1RWNDUDVTTG1nYXlBQlhhanZlYUpJejh1QmtIQVBCSTZV?=
 =?utf-8?B?a0lUb3l5aHJSSE5VSFJiWHFlQTRCSXo3YW40ZHVXNzMzSmYwYVlWUDJkRzZS?=
 =?utf-8?B?TWVraG9sNXUxSWpxdU9jNHlQS3dWL1pOM0hGdVAyVTMveVBqd3R0cm9FWkFy?=
 =?utf-8?B?WFdxaHJ6RjRxWDZIOEVRZnN6bzFPelJTa08yTkxld0xhUjZUVXNKUEliY2Mx?=
 =?utf-8?B?UXhPVEtJQmFiQTBlT3hYMUpOSVAyUWFtMll0ZHVDdjRldUdISnZ5WkVpWUpK?=
 =?utf-8?B?ZWxraTY1QUtuRVZXQ3kyU0F3U3prOWFJQmlDK3hiZnZmZjdGQlRudjVxa2Iv?=
 =?utf-8?B?MkVWNDR5TWRMNXhZQS9ESFNQSlA2MUg2SXliSHg2ejY2SWMxNXhid1hSYWFF?=
 =?utf-8?B?QWhjNHRpUGR3R3BXNjBLcXNSNGNnckMxZkY3MmlzUVU4RmdxLzZ4VkJ5aTRV?=
 =?utf-8?B?Y0d2OTBsWUNxeWtOY1JvVGg3Y2RjSWgwWm9CS1hTdndub2c1VGFGMnIyQVd4?=
 =?utf-8?B?Q3l0QnZQZEhBZVdsNGJtK0hwOTIyT1pzd2tTampmNXNrdm5kb3pXRlphK0tp?=
 =?utf-8?B?TXI0OXhqbXdRSGllbm1WM08zT09QZGh2U1VVQTROTlZDQk5YWHNrU1dud1Qv?=
 =?utf-8?B?dE9MVldTRVlPTUJjYy94K3ExSnpiNmV6K3lQaks1cHVpY2IrZ0NDMUxlYkN2?=
 =?utf-8?B?S1I3TytTM0tOVmQrOWk4bEdRY3R6TnZBcDVidmZpUWtuYm9ZbmVzY1RmVzB5?=
 =?utf-8?B?Q0NwRWF1OXJhc0dMb2FiU3Z6ZWk4UXZSR3BXMGxrMHhhL0JPSDFnZVM0K2gv?=
 =?utf-8?B?UzJ2a2ZDRm5tT0t3KzR5WENZWkMzaytteklDR20rZDBYTlF2cGF0ZGVLRzk2?=
 =?utf-8?B?RHBQS21KcXBldkZTTFB3Rnp0MTJvVWNWSmgzUGtnc0Q5YUxKN0E3WFBnQXNC?=
 =?utf-8?B?aHFtM25ueE83eUlORzMwUHNRc0NnQXBIUEFwaCtQWlFrcG9nWlpCNkZ2REp0?=
 =?utf-8?B?V29JTXVkK25vTWVkS2pOYUxQTW4xankzSW9aNFRKWEY5NHFnOGRwSFNJb1dz?=
 =?utf-8?B?eGMyd2xSVExmYWpvUUlQSElEbWhlLzJreWJRc1BVUTRFajduVmhKU1NtU0FE?=
 =?utf-8?B?QTdsU0UwdGEwODBXMy9DSHBUS2ljM3QxUENRNHJGR2IyNlZmZ2RvcFZSUzI5?=
 =?utf-8?B?cjlSNThTNi9WRkNhRURuSHNCdE9vc1RRMHJTSlJBcWl6RUJKdUVKa3VkT05C?=
 =?utf-8?B?cDk4QnRubzA1QW0zYVQxTWNocWppZkRCZ0pVREtQQzJCN1k1aDBSU0NSbW1G?=
 =?utf-8?B?SjZndndSOHRMNEp1dm1SY3I1cVBML2EzTEFTdXFORDhsTDcwcXNra3JYS3Ez?=
 =?utf-8?B?eWNtbjUyQXBQNHJGM1laR1NnUHBIQkt3dlYvcFVCWEUyNWxyVFpuZ0Rhd3Fw?=
 =?utf-8?B?aStSRVQzV01mVzBCTXVMc1BBcjNpelJVRzU2NHYzQjlaOWszaFh6TU9tcFhQ?=
 =?utf-8?B?S2ZXN3N3UHh5VzVNS285aGpzeGhGUjhRVlV3Z1d5M01xc1h1RkU3dUhIckQ1?=
 =?utf-8?B?YW5jWTI0N21lOSs2U2dVaGVUemE5UzUycGo5VkZ2RGp0MWlXKzc4cXBsMWw4?=
 =?utf-8?B?UVY2QjVhaEpPSnkxRDIrZjhQYjJBVmoyZHlIU1dxVWJFVXhudld0UGpzSkIw?=
 =?utf-8?B?ME1WVEIzczJtMm9HZ1NqaFUyQVN4azZIL3FpaHpseXRJUGpFVHhEbzRDcTIr?=
 =?utf-8?B?SFp3WlowdXc0NndWSmtEMFpyVU1lSktGMG50MTQ2U0UySkoySEUyOVlLQnpt?=
 =?utf-8?B?V1RJMXFlTDVMYmxjNS85MG1IYVgwVk9tbzMrS0MyZEt6ZFRLMFM5eEo4YTI4?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7a760b-08fe-467a-63f3-08dca5ad6de8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 15:39:07.2823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qq9H+s1xQgh4nP30MThXLP2E5b6b10tUqQYfhnjUhOTZ9+qzkifpPpHIEs19y8hjTNnIngEfMNt/Kc/qUJSwUr7p9suWwolp0evpe9QTTdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6822
X-OriginatorOrg: intel.com

Hi Christophe,

On 7/13/24 4:02 AM, Christophe JAILLET wrote:
> 'mon_info' is already zeroed in the list_for_each_entry() loop below.
> There is no need to explicitly initialize it here. It just wastes some
> space and cycles.
> 
> Remove this un-needed code.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>     text	   data	    bss	    dec	    hex	filename
>    74967	   5103	   1880	  81950	  1401e	arch/x86/kernel/cpu/resctrl/rdtgroup.o
> 
> After:
> =====
>     text	   data	    bss	    dec	    hex	filename
>    74903	   5103	   1880	  81886	  13fde	arch/x86/kernel/cpu/resctrl/rdtgroup.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thank you.

Reinette


Return-Path: <linux-kernel+bounces-561746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1441A615A7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1387717FCEA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D1220110B;
	Fri, 14 Mar 2025 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kk5NWW0y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6026F510
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968157; cv=fail; b=F/32ciJ6p68zq782T0NMZshlSWzDVWnkluf+WuYnZpyRvYtZL21urGyqVnXqLWOpsl6WFdIQ+tDtanyDiaQFh371M+HHCAlDpAu0sfjOdUUnQJov7iZ7FES8DAPGvertykzLTZo6PbivvDu26jinimuTt7F3kPbILtFZ1WFj2Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968157; c=relaxed/simple;
	bh=nGf03U5wyLyyFedZhoApAkXyE0J9qtgEfGqzlv/XzjU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UEgV79DTyJomYJ9MCSI6XVSe68R17oP9j6iTxx3ItS8x8Wig7yUMWWzH55yxzIx+16D3YF6HDNqq5jEh5a8p1IJh2SHo6vGPblicKutUxfyXtGVlztPZj2pFya61bSPZeZRNzvOeyF5XRAy6PE8wv46482NMJklcDujOwo8S9P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kk5NWW0y; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741968155; x=1773504155;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nGf03U5wyLyyFedZhoApAkXyE0J9qtgEfGqzlv/XzjU=;
  b=Kk5NWW0y/rmL1zY+ytpvYEl3f0YdUUk6AJMmgGAkN4h2+yIoH8Vy8UwJ
   dKmRHXIRcstbs2AzYixXrekL8+1/9FWRi+7vLJoEk+4c9h9a5yobsVmbf
   2psMINKJUwkI34BxKYlCWkywLxBFiR84zD5BFJ7rDg8zNzHj/NpwPUGSr
   50JytC9+85c+yvO9ALsa9V+qo4JQbr+b6rv4rVIes19PDXtR2ARE4L+5i
   Zoyu+U7GH1hjLCdJ0GhL2xjq29QDC60EKUGDQYCJLlreYf5yufuNV99+c
   3wPZQyCf/hMGfX+T9VXjsDuC6Bzx32EYn2tytmJqdtk8pwyg2VCgTTxSN
   w==;
X-CSE-ConnectionGUID: iYcyEhMmShmfTAyroraHig==
X-CSE-MsgGUID: GZb/kYndSOqHsk1XHDf/fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="46913122"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="46913122"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 09:02:33 -0700
X-CSE-ConnectionGUID: hS9YIkx7TeubqCM0U/PEOg==
X-CSE-MsgGUID: GJ9OQIzgTsCf/2lsb+ERew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="152264154"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 09:02:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 09:02:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 09:02:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 09:02:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCHxsMvgemmt8xHAtK7PPjO7V399uqSsMFIuQN3m17JJfLoflrKfn6rwsZgQguw9xnfv+IGAIoZgZfA5ObqNbVi1MREngd7MCrvcSOszH1j3qPy2cu83//4TsuPD0X/P0Puesz0KiKAeOtkxYwp6YC1n+vGqaySio7bPloRlWCqis3n7A4G0S0wUzkhDZKptYtPuYfh/fM4xH1jMPviVwoUXY7S8R8/BQnx4WijNFiBMwce1F+b9Tapd1Nxlf98ABM4p/fRT9bQhI6AcwlyXnivnX//p6tlI04Q3JM8adges/EdKBAWSPpHu4Vr8bXVO/ss61Inyech5l0Ov+BEwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8re8J/EqLT1YG7PdvScfVxWFBbsNuf5fjZf7R1swjGA=;
 b=JcwFZ8AGKenNd4/bSFdRvrRsMZ2idPOono+GWADg99yx+cY5j84UxICJBPScYGYAB4/7R1ifV7Ssy8elchs6uR48VIUtnV59VeKu+tntWMCafPS+KHIj4umXqhU3L/z929+ASsSkP1Jl5kpz+uGcPsCAE0jUy56ulEhOxzZJ8AnFA24QzrAyjpMEx7iwc/IwiE2e6F7lJjUWAyPP0Y9r01Xm5l6u6SYM3rLIn7b3vbccPmSkj+Iuh/43OeaGDNobxYeOMP1/vPQXAlahv+79lrvYeXWfDqSwcr9EQ+l3ixLnu35oNlHP8RfCJPwS5noYoj2FyTKQH8IAvLWnqcO8kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DM6PR11MB4627.namprd11.prod.outlook.com (2603:10b6:5:2a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 16:02:12 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 16:02:11 +0000
Message-ID: <8f52bc66-1ad3-4b8a-b2a7-2d25d3f544a4@intel.com>
Date: Fri, 14 Mar 2025 09:02:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] x86/syscall/x32: Move x32 syscall table
To: Ingo Molnar <mingo@kernel.org>
CC: Brian Gerst <brgerst@gmail.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner
	<tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski
	<luto@kernel.org>, Juergen Gross <jgross@suse.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>
References: <20250313182236.655724-1-brgerst@gmail.com>
 <20250313182236.655724-5-brgerst@gmail.com>
 <a30872ce-3acf-4d6a-8d96-c073c6f33895@intel.com> <Z9P4Fx9Kl7mkSh9F@gmail.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <Z9P4Fx9Kl7mkSh9F@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:a03:332::16) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DM6PR11MB4627:EE_
X-MS-Office365-Filtering-Correlation-Id: 7069d758-7795-4fea-2c87-08dd63119479
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVJ2TDFEeEZ0YTRZcThYUWdhdGlnRElZcUVsNjd0ekd2VVBDeU1SVm4zaHBN?=
 =?utf-8?B?anlhVkc5cEVsYWFjbmZyZW9NZFJiWDg4MFE5RnFUaG5iUlNIRkFVd2l4TkZJ?=
 =?utf-8?B?TEk3YldZejljT3R5RkhlTkF6WXhwVjlPVjhGaW5tdjdHTkU2dDUxNFBwUVB0?=
 =?utf-8?B?ZURZYWM5ZXowUG9zL3V5TmlTTWNvcjAwREFTWEtrUzB5d0w4dWVpU0lRV1Jz?=
 =?utf-8?B?QnFDTnYyQjJxVHFyQWhhT2JSNll1YWh0S2RFQzRocWhFMElleTFZZCtJalQz?=
 =?utf-8?B?RnlhY2NFTnVIM0QyYXNHdHlaWmZPQ0lzZG1LdDNGMUJIcEtDQWo2aXpiUldZ?=
 =?utf-8?B?bVhHRUFCemhVVkVmS25BS1lYR3BpNnJUSWJyc25ZTlB6VXZuelBjOENIWkNo?=
 =?utf-8?B?eFF2WXZrZDNaays2ZUI4M3dGenlXTHQxcXFPNTlsNDVYZ2pBUmhaZzU5cGda?=
 =?utf-8?B?ei9sMFFiU2NhMjZmQkxDczZSMUpjRjA0V0JMbHAyS0ViMjVkcGdSUVNqSUdP?=
 =?utf-8?B?NGpOc1BkSmhkRmVheHdnUXQrczdrNVloUnFGOUNoQWQ5Q2NxcUZoQ1dXeFNi?=
 =?utf-8?B?Q3hjT01jRXQ3VHhSd1g3TUI1TSs3SDFPR0R2cVBGcG9EOEZzT3FmM0FSOU00?=
 =?utf-8?B?TWwvTEUwTnJVblVkMXN5alg0QlN5endrL2x6SjNSS1NHcW9KWFcxNklvOWdT?=
 =?utf-8?B?SXF3RTZ6Wnc4aDU2T1hHUzBuUHhDZHpJTkJrRVZveDJNWGFIK01xQ0hSejl2?=
 =?utf-8?B?bmtnaXNpUFJzUHZhVWMwYUs3V2VxOVVhbTlKVjFiUUFXeFJ4R0VJSERaS29W?=
 =?utf-8?B?NlFoNkxmYmVZSHpiem9qQ0FkbHVQcjRuWG9yVTFzYzI0RjNnNWt3bjlEYmdm?=
 =?utf-8?B?ZitFcmF0TWNwa0xaQngwVkRLNTA5R3lsR3JRc3Z5L1lXRGVzU0VFVHBsZEpr?=
 =?utf-8?B?eEpIWndlaXh0dXB5R0s1ZXhNVjN0TnNoeVNoaXNBYjMzR09Jcmw4S0dPeTY4?=
 =?utf-8?B?SGpVNlRhQyttQUExN2Q1SVJGRFBOMklEcWdIcjlHb3JJeDAzSHE3OExMR1pF?=
 =?utf-8?B?WGZaWGZ4aXk3cGN0NDJkY1c2a3BZUnVHRDQ3M3BaZE5GaitBVGRCUWl3YytG?=
 =?utf-8?B?ZjBsRXVydmZXaTV6KytNNlhYY0tZM1VldHh0d3pCRk9TUUhzTmI5OW91SUNi?=
 =?utf-8?B?MUxCLzJENnRwdEJ1dHdOazRXdkJEenpMQ0NJYnVTeWdXQmVBV0xuSWxCME81?=
 =?utf-8?B?ek9CZkVsZktncWRodkVTb3lPUlRRVUdHY1R0czJKZ3IxbExoSkpERmFiMHQ5?=
 =?utf-8?B?SGhxaWFzVTYvQUNQYzZ6NmZRRlhMa3Nja2Q0eW1ma0R3NzVwUGdEVjJvdnhV?=
 =?utf-8?B?TU5lb2Q0Y1R0dXlUeGxuVHphY3dzSXNOUEVuamxRY1dzZDRPczYrRWQ2REw1?=
 =?utf-8?B?dkxkZ1FGcFJOYzNEZzRiZUhlWnhIbzZLQXFUTTBUdGVaVlMvdE1yb1VPQ1Er?=
 =?utf-8?B?WkJDRXZuL2E4ZlNjV2JpRUR0aVduYlBjZ1pxTEpVMGo4MnNNR3BKTStkUnZj?=
 =?utf-8?B?b1FqUkJqRG5CODBsWGlXV25IMXl3ajdxdENlbzNFNGtwNDY3SnIwSUJ0akcy?=
 =?utf-8?B?TXJ5S3JxWnNuMmpyNjZCL2tGVVhDOWl2VklBZmxtUkdZeFpHdUQ2bFBmUjBp?=
 =?utf-8?B?ZitrR0NhZlBxSlV0UDUzNGluWlFIYXlWdTk4RXN3Y3BSSklYMkJ1Zkp4ZmJU?=
 =?utf-8?B?dkdBVUExV3o4VkRkc3NjczlqeWt0NWRFNjRoNnFSaVB6RjhRVjFpTHhEZ0lm?=
 =?utf-8?B?UCtLQXJlRll0UWJLdDF6SUF3TUV4UE9HMkwvWk15aDY3SExmTmlQbjR4U3Er?=
 =?utf-8?Q?tWfwtriu48jlf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Si9tZHA1TDV4eERpTURzdmhjWGRmdUVuNFFQQjBhdnlmYW9zcXI0Tjh5R2d1?=
 =?utf-8?B?Qjh5bzZQK0VFTmdKMDNoU3M2ZFhxL2hra3Bsai9vQkplSjgwa1RseGRXek9z?=
 =?utf-8?B?SUdlclphcW5hZ2tUZTdrOHoyeXRTeW4rdVVzdzBpMU5VWU5GQTNsRktwSUNy?=
 =?utf-8?B?L28zQ0lWOTdGNzNtUWxBTmVuemtPT3RaV0ZnUUswb3daWmJUdlE1MEpPdktY?=
 =?utf-8?B?RldGamY5aTFURW5mR2RYd2tjQXNHbmpkeVFjY3NzTWloUTl5UTdOZTlBL0lo?=
 =?utf-8?B?VGUwVjNoeVlSZ1dDc0xJeWo4ei8wcG43OUFhUGJIR3Bra0hHcHdMcVpNT25Y?=
 =?utf-8?B?V0JIM3VXWllTWDVvTENuL3lvdU9zK3cxUlFsbmp6YlU2dFpsMlUxSkhRODlO?=
 =?utf-8?B?VG11aWQ5VSs0TDd4bVU0REpGcWNzaVFDdG82ek90b1Y4MUNTMFdCYzQ1Ulk3?=
 =?utf-8?B?L1lhRXVDSkdQdlZ1MXNRN2xrdzdFa3llOFRjaFFWNUd4VFpYdFNzenpJKzc0?=
 =?utf-8?B?LzZQeU1FaU53ckFJbllOWHJaalcyL0xkaUYrYnFMcW9mY0I1aUxGRTRJVWZq?=
 =?utf-8?B?UFZXOUJzYytGdEpqVmtmaU5RMlJ4RUFLYkdnMUh6ckhJV1JhSXZmdUFoMXdm?=
 =?utf-8?B?Q0tpOVdZN3Z2R2p4SGs2eitONFNRbm1CVHprV0hJWGQrMzdEYUs0V0FmYWlS?=
 =?utf-8?B?RHdiNm55UlZaVXRYQ1lyazNacDE4TGowbVAxZUQxcW0wam1BcU13KzZWVGZt?=
 =?utf-8?B?ekxNVDVmZHA5bHJaTVBiQ3JjMUpqL2dqMW5BdUFRZDdQYml1dDdtRHlRN0RI?=
 =?utf-8?B?d3EzTnp1RXEzbllWYyt3bUNzTngzZWwvdGxoaGVMSGRQZHQvSGZHTDVPeVkr?=
 =?utf-8?B?RUh2Tm1sSkNSNk1KRDVRSnRvZHZnQk1WYzc1OVFQc3JXVFBLVXdRclRBN0w3?=
 =?utf-8?B?aVRxMW9rMUs5V1hZRVJ0ZGlWaDBIN2N0SXRIQVhUZFhiQ0V1U0FST3V1Sysr?=
 =?utf-8?B?eXBobEdkclNGQjhPK084VHI4R0J1SHlwL0RHL1ZNWkpJWUQ2ODNySGpUbHZp?=
 =?utf-8?B?U2s0QVhMVHhNei85VytTRzdhVFR5VVduRkt5M01ncnF3Y3QyeDExVmRROXVN?=
 =?utf-8?B?OGNhS1ZKNW5lVnZYeDdyOEhyWkZKNW50QWIyYmRkaXIwS1BSZHdWU3c5N2tV?=
 =?utf-8?B?N3RRdG8rTk94eW1HeHhCQ3VCSUNKREYxNlBZendOTnUrbUpLMGl2N3hpSEU4?=
 =?utf-8?B?anpCSVNWUWpwTmRqY1FKNURHVFBnWWNSRDQraGVCemZSZHh3L3YvaGo4b2ta?=
 =?utf-8?B?bTBaY0tBNzI0akdEVS84ZDZySC9SYjd2ZE8xSEdMWlFvcEFvWFlHeDBtZEJR?=
 =?utf-8?B?OWJjM0tHdGFnK2g1U2dKdlBxbHFWbGZkU0xEMnB5Ui9sbnpXRjhNZ2twa2lE?=
 =?utf-8?B?c2sycjRRUDR0SlV5RUs2SnIzOFphdDdLLzd6YXFhSGI3VUhJeUZ4K2Foais0?=
 =?utf-8?B?WVlSOVNmUlZYR1RwS1doK28vZjFOeDVheUU0aGxnUVl0bzBZQzdxS2xjdUlz?=
 =?utf-8?B?ZDhmSXN1dlNOQzJZUjVvRUFYTFE4SkcrL1IxYU5tb1YzckMyWndHaE5nWExU?=
 =?utf-8?B?TmQ3S1VJK3dXSlVzRmxnTHJEM3RpTzhrNlRhdmdmbkNueVFOOGFRYjhYVkdZ?=
 =?utf-8?B?dXpHMGxoOHNtaE5XMC91ditsUHdLT2FIS1R5cm03aVdqdUNqT0FlK2RoSmZQ?=
 =?utf-8?B?NlhMR1F1a1ZpeTlaVTZzREFibk1wVFlhTE55U2lyb1dEQWQyWVZjRHBvMzk0?=
 =?utf-8?B?bUs4VGh0b2dQeDhQMFdoYk1GRTBTRUp2RGpxQjNOU2kwZDNBdUFrNXNFRTAy?=
 =?utf-8?B?eWgwWUJZczlkVkJVZjhWdlM0YXBSSW16SWp2RmgvYzl3RVYraXdJUVNkbEln?=
 =?utf-8?B?ZmM0bzE0S0pXZmYrbGJyKyszc0FKOWtObGhGbGFYN2VTVzBzcXFQN0V1UnE5?=
 =?utf-8?B?VDhtbWgrVDlhWjc3Z0p1ekF5aUJlbGpSOXgzZUhtQjB5SERSS2lmczlMMVlj?=
 =?utf-8?B?WDlnY2VLanpqMlA3bTlwWnRCRFlubUdySXZJUmpLL2hGTC9PdW04MXVCRW5W?=
 =?utf-8?Q?UVloozvY17TnfpWB5g7zZZ/rV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7069d758-7795-4fea-2c87-08dd63119479
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 16:02:11.4937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+yBMmcpGUveF6wquMO+zKlmKIP4capgBSSIOl5ZvI8ss9olu/Olf8LdE4UXF2+jlHcEA7K8OfwrrIHbgK241w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4627
X-OriginatorOrg: intel.com

On 3/14/2025 2:34 AM, Ingo Molnar wrote:
> 
> * Sohil Mehta <sohil.mehta@intel.com> wrote:
> 
>>> +#ifdef CONFIG_X86_X32_ABI
>>> +long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
>>> +{
>>> +	switch (nr) {
>>> +	#include <asm/syscalls_x32.h>
>>> +	default: return __x64_sys_ni_syscall(regs);
>>> +	}
>>> +};
>>
>> There seems to be a stray semicolon here. The original code also has it
>> but it doesn't seem necessary.
> 
> BTW., seeing that you've gone through this series with a fine comb I've 
> added your Reviewed-by tag to the series (with the caveat that the 
> details you've pointed out will be addressed in followup patches).
> Let me know if that's not OK.
> 

Thanks, that would have been fine with me. Reviewing the v2 series now.

> Thanks,
> 
> 	Ingo
> 	



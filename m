Return-Path: <linux-kernel+bounces-306014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 154FB963810
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9DB1F2413E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7B11C2BD;
	Thu, 29 Aug 2024 02:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3l7elyq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8254C28E8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724897260; cv=fail; b=h5PhDwLm9/b/ewY9X9YVPz8d5ITmfBH215fKXt41XR1Cs1irHfudvAUugoVlsdbkyBgBqJCp3EFWucX+EbGj6CqLLlY8r/ew+WQZ+j3ZUSxMrD5kmF8BHxdSipXDlk7cWwwqdvY3W9InA68uBQUvqpKT78xFqDOQH7UzmFOGam4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724897260; c=relaxed/simple;
	bh=hCIvc0qdi0a/WkhSFaH8uoNQ83jPjUNAXPXW70b0+Ck=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ahR02jqa5mvdVQAiwE5f7QA/4tiEaxqBxmKHejtV6SogSPVNQWB1NatLtoIuEuj9CiVsbE4LBcbnUzZToiH3xsiK+FEgeh7CT3fQzUvrUfk1i1Kq77Go/m0l/25WRBqdWCDZ8RRKRv2+5laqFIyHkP89SSL4TgoGGVZZOKoQkr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3l7elyq; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724897258; x=1756433258;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hCIvc0qdi0a/WkhSFaH8uoNQ83jPjUNAXPXW70b0+Ck=;
  b=i3l7elyqBxEEfxqyrzOJy1XJufcl+NH6L5OV6Vss4byIReB/HPpENhgu
   I3b6XxvXTjvhjqgfVsepDvlxcPL0ItYvCancSZFtlNLpl+cMlZFbaH/Kj
   LPNZwOS1BhZ1/F8SHP45uj5Src13EBXyWPWMkHrhJYMU6Elf/aykp5lw6
   DcjVyjRfSFmYeAT9QXiYN1lXED91pYlYz7iQ2d8/3VzFkHnHkzgMIckiD
   woczk/4hiwaD753VHoI+HRmfzwnZIEeWxkL5z/x0YigkV8VdcT9ypw5/h
   gmbkTLa7lE6g40fEBG6n4AfyM37TI55ZezW+i0mFLlVz2X6kcFQHX5tpK
   g==;
X-CSE-ConnectionGUID: CokhdRoRTMSWZrLStSNaoQ==
X-CSE-MsgGUID: 0iXwBQbQSKqvSZzRv3dSjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="26365613"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="26365613"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 19:07:38 -0700
X-CSE-ConnectionGUID: 8XpfgaITSvixHNJxUz3xhQ==
X-CSE-MsgGUID: D9sHX5HEQ++zEo8KECxSwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="63368273"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 19:07:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 19:07:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 19:07:27 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 19:07:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymoRqDVXbbHRUVh3OOedvJ+LWVBAcCYbHyDzy67rot5OX+5SovnWuxBh4AS74RkZMmdR2RXEfzT+Hu2X95er+Hkc88XRqzx4NYoLxwWT/m3Ld7wIj7SjgBzLzT+waTIkP5EaRF7d5fyroMgIu8/7bZPzDKKbh18IxBX9mTjGVxhH4ApKmMxPPmyTgq1xDXP9oipl+6uhZjqBwoxDdjbkjJGQg5MbeRlf0gMqL5/gjJEvJ8rktj1y0tgpp4ELjCyRLPNQ0auI48FlzV49Ho8xpRk/Q8mGZWSHJihfUXkdTL/GE6XbgwxPTWviNcs0UeBg0WJXBnWsLwj24dSaQASo0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTbuCxbKHOVqJn4HCzsaoY4POs5XSytYQ2CSQh8llYc=;
 b=EfIwLFff3EakZ4YAH3FWmDT9ZVxxGrIOt2MqIImzI8Gsrwj2rYIgv2v6d1AzBGR2nURj35jxJAu+9WeMak0LHUp6iKnPbkr+rxYXcb4MWDYZVkVUoIL9VqZfQShoC0zB2WkAwhecIv6Ej4oVSW/4WOy03wS0qjV/LhFYYaJ9nOSfmyrxxof92a+IDE7EVEnN5p6nfSxxE3GzIH0iWPhn10lcR9J4mFZRvErCjXgGTR383MZT99y3nIw1/5aeFC+v8PqQxV5L/BGRxFqDWfNThQnIEFNSxIBxe3Bh45quF2jrDfhmCSicR8jtFBWpjycBRoCmDaYqgQLka2QyWlYxzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by SA0PR11MB4542.namprd11.prod.outlook.com (2603:10b6:806:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 02:07:24 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 02:07:24 +0000
Date: Thu, 29 Aug 2024 10:07:16 +0800
From: Philip Li <philip.li@intel.com>
To: Kees Cook <kees@kernel.org>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>, "Arnd
 Bergmann" <arnd@arndb.de>
Subject: Re: include/linux/slab.h:552:15: error: type defaults to 'int' in
 declaration of 'kmem_buckets_create'
Message-ID: <Zs/X1DT9VOtHulk1@rli9-mobl>
References: <202408280559.FIsoHAAc-lkp@intel.com>
 <202408281843.D8948B2@keescook>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202408281843.D8948B2@keescook>
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|SA0PR11MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cdaf052-264e-4107-6236-08dcc7cf5314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fnXwq6y/8MOyqBi+WGaNc2TYM7VNTIkK01Wpfr6FTQDEsffHFAaHyFTK3ru+?=
 =?us-ascii?Q?Dr2MHiFHXCEACv+o9Rf4458aS+63iyDBNN7RkWFTtb1VLF6/aKKr8qbnDSoM?=
 =?us-ascii?Q?YDVIuXwjHcNoe36xQ5bjmlgtuAXpNsG0cQTaPDV522QnrAqxFUEoGzCvOmqn?=
 =?us-ascii?Q?XGarLVkebjR4uy933I3didX1w7ZKe+Nn3zaErBGZo9f+zCoyN65ZXego6f9b?=
 =?us-ascii?Q?KZCDGs3nLO2/R3vRtZAR7h82IvMd/kzQylewtF+j+NpDkBcO/+cYEfuym5gZ?=
 =?us-ascii?Q?fVy8DCpLjkPLcXtkIMSBmvitkW9JpS1JR0DxekAdYByO2sA6XbfUlPz6guer?=
 =?us-ascii?Q?jk+jKLTy/6DCoKaoVzqxAWIprCRIZ24YqaFElSe6XaLrsgo/ok+Xmxn+zyVX?=
 =?us-ascii?Q?rqv3TiEmEmilI2Tv90JJyBqDNJ6Whe4Y9exLmOh849LgmtaEfkOdhET7QaSJ?=
 =?us-ascii?Q?ks8waRysxTCVpENd0e5nDn8hP7YmYhALMdJV4VTg+JFocVX0lQWWcv1ttgMJ?=
 =?us-ascii?Q?SwxSv2L3sQ4nPI8aki6MgHd0U0Ln3PFDhKt6zkge9gYPkWoYnizUpZdAcIQ1?=
 =?us-ascii?Q?J7JPX0/NtgTU0Um5gALNr4fCcpN1GzeBIzp/n/G2hPpetCTLStm5eiDcjxCz?=
 =?us-ascii?Q?XXc1UNz4Clv7+KmUrYy3AvQzxS6heW14/GueCKw3cUiEoK7dYq0V1OsS0Lgt?=
 =?us-ascii?Q?VFb0QIFuXmckzrYGShBWFYvQqE339bpQc49TkYHNSJ9FFNWVDHq3zdAH7NjU?=
 =?us-ascii?Q?uFYBwCu8RKop4syX22gV3u9GX0V6a01SC1C4Pl4yHVKxlIujKqRQZyo+yEUq?=
 =?us-ascii?Q?Qv+dHRqIwLanoSuyIe1s6Z+fiw+sf10RihYxccKpWYkibYAeFgutRDrav+iJ?=
 =?us-ascii?Q?9NUkjDaaN3BKf2A/82HopAYP+GhHwvD1WVq9DLqWNRxV3TZNpnBFZk+2DDGi?=
 =?us-ascii?Q?fYhWZnxoxanbSTHgnTnO4ITdkzm8it8o0gbW+OI4VqZe7n05edX1gld1ThsK?=
 =?us-ascii?Q?yfwoufGcndb/TihQO3eiwRJ1kyUMngEwg6+jV24R6X7M+MFF24Dv28WlLUSr?=
 =?us-ascii?Q?/oDAvvgZTNrWCv7G3qd8/vgfWVWJuxKGGTvA99HCebz1+url6Btpfij7Uon3?=
 =?us-ascii?Q?dCgx0M7E52Bihs9k3E8bmEm4XIMx1AU5Cc7TqzNKiRcFXuJADhU6kSZQ37fy?=
 =?us-ascii?Q?TbtDlX5OvkE+IqEmAP+FaVMy8u3MB5Sq6pSVGM2H8i6/JVde8bAzV/pBs1fh?=
 =?us-ascii?Q?QgoGVbf4f9wqjpW1WxuUDvAQTNHew33q7hheKyPYChLQTLsX8kWFnyz4y/mb?=
 =?us-ascii?Q?N/Iipgzes78X9j1tcS68Gb9E?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N0oPMblHo658jjeNQSVSj44v5aS5JBgrN07bNAyD5fjhricz5ZqjpX2B3soy?=
 =?us-ascii?Q?Ib2HrOrVyba0AEe5yyyjFMTEIKijsVXcUIR2y+UitbTL3sdlGs6+/Ygi//1A?=
 =?us-ascii?Q?OHpQ4D255gltwJYPAZBfRq5K47qRckaSO2uBkg5oLoSSrp9XTvJjkaxOFuZb?=
 =?us-ascii?Q?2lc56SOqc7D1NA+umYaGDlhT+sk44gXjaXe1Ft7rpJYEwLBe9Pv7pdweNFN7?=
 =?us-ascii?Q?6A7Z5+Wkyb1l5+HNgc6Li8mhqhJq2AIc5rx13qjSspJvjm5hobrzaVpiLbwL?=
 =?us-ascii?Q?gzSZrpEEokokANT64CdtvWJoSH3CET5Tk44kWsIA6ibgMRGHAQ5qDINexXjq?=
 =?us-ascii?Q?vguEQu/KXJi2X4AuQSrZUtIkCG6w/I8sOJxPDhjeXaRib4OaQLNJriifxg28?=
 =?us-ascii?Q?lty6wkVj6hjvGUhWXn1e91A1SPRJ5mZnsVTacWk1fHTUM+uYowYN/FUdREa8?=
 =?us-ascii?Q?gxcHw8QaJp1U0qS9og2p/wpwyrBZEwi4ujTjbQhWNblwywueQk50ofTLHhqK?=
 =?us-ascii?Q?Yh661mJsjhWcqj1FczTb8UG9ml3CrbCEbvEqx54lwybrbV2hlv96ciN8i56Q?=
 =?us-ascii?Q?I1ugEYho7Jn6SEj0NmnfxZnQtH2gVuccWXADNPXgSa95S2TUPIUnNtJ+UsEy?=
 =?us-ascii?Q?zdiK067/9ohX7vW1SX/vzy3db/Ipki4OVesy5dkCkMNB7VcBZG2n162qXKzB?=
 =?us-ascii?Q?gYdh21SVFkestl1dV+yc3DsGiK7y4Sf6v11LigdMcnRVJCTBAiQEqMKB/5E/?=
 =?us-ascii?Q?HyKOk51kJJPdgMB7QHWovcaR+Pk+TJGFwkSeUuw1WbR3dLEZyAm4RIew8z7d?=
 =?us-ascii?Q?iQ1yEY4yy70uQZpm5WVKU9FVmuAClpdidEiSFUxbN1sz4dHi1/byhFomb2Dl?=
 =?us-ascii?Q?TTAtnu/KIGQGKr4WZpnjwqdeH4Dzh0ZUvAuLN27PmtiuqC/oEfEptKepXx+Z?=
 =?us-ascii?Q?hMFjpe+7fPr25F9xkDn2hOWwm50YZo/au6sxzgIsAiiy+QAvXxk2DmxtgxJz?=
 =?us-ascii?Q?F6ltdezU7mlYR5dX1KJniGJu7im9L9RfaRIZdoqJbehkow3kyQ+8CcsmNwS5?=
 =?us-ascii?Q?GdGqfzR9y1nJCGFG1dnnoMgVm7opEBRMjS4R6jyeWf0Dg2lnxlthPxpq9Xdx?=
 =?us-ascii?Q?ULjuJp15wSeXR564Z+B5E3J2OAUEofhCvbtbm6GzT7k2P1/NIns5ExhPB9sR?=
 =?us-ascii?Q?6WH2ErpUMAgAjvt6nO9xrZmfZ8EnWDasbaHI7PR7I2OBtGCJg5i3fNs5b4D7?=
 =?us-ascii?Q?oezJzMxXuqhZZSM2WHh9OblSIs1Vvpi+LjP1hqP0j5PaFY9L3bvSGxuy50aY?=
 =?us-ascii?Q?omdUWW+3qKfUgT6GrhdD7aJ4gYs4HlP3HQGNvbnZkpqag78DPR4VdRgv4QVA?=
 =?us-ascii?Q?kOLMSATDO0ai6bpWDo28tdL9jMjnfjpT84/ITRhFpnWA4sOx3jPJbteNKNF9?=
 =?us-ascii?Q?OPKJDyx16ApBMXHm1zt25hrpB36rWw7LibwgBHGdKWnPLENT3B/TKn6tvB3L?=
 =?us-ascii?Q?PlQeubsmQqZvswJtiJkL9st3DtRjxRVEj+E8fVFceDsSIHsIO5drmqztzz6g?=
 =?us-ascii?Q?CE/8li5jajkS0wFnlpmid/gqnAMIEYodHsYTybid?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cdaf052-264e-4107-6236-08dcc7cf5314
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 02:07:24.8551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AHX29JC/vszUjxK8PcvOuF2yF8VbJcm8w6Xs+1vaad3V69rThG0feTjTRrrXT6Csp34FYO3v0ZY2XyNYz+YuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4542
X-OriginatorOrg: intel.com

On Wed, Aug 28, 2024 at 06:47:59PM -0700, Kees Cook wrote:
> On Wed, Aug 28, 2024 at 05:21:04AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   3ec3f5fc4a91e389ea56b111a73d97ffc94f19c6
> > commit: b32801d1255be1da62ea8134df3ed9f3331fba12 mm/slab: Introduce kmem_buckets_create() and family
> > date:   8 weeks ago
> > config: x86_64-randconfig-072-20240827 (https://download.01.org/0day-ci/archive/20240828/202408280559.FIsoHAAc-lkp@intel.com/config)
> > compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240828/202408280559.FIsoHAAc-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202408280559.FIsoHAAc-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    arch/x86/include/asm/fpu/types.h:355:22: note: in expansion of macro 'PAGE_SIZE'
> >      355 |         u8 __padding[PAGE_SIZE];
> >          |                      ^~~~~~~~~
> >    arch/x86/include/asm/page_types.h:10:33: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
> >       10 | #define PAGE_SHIFT              CONFIG_PAGE_SHIFT
> >          |                                 ^~~~~~~~~~~~~~~~~
> 
> This continues to be a problem with CONFIG_PAGE_SHIFT with this config,
> and is a known problem with no clear fix[1]. I think reports could be
> silenced for now.

Got it, we will configure the bot to ignore the further report.

> 
> -Kees
> 
> [1] https://lore.kernel.org/all/85bb8bbc-f48d-46fd-aebb-03b2f7d3980a@app.fastmail.com/
> 
> -- 
> Kees Cook
> 


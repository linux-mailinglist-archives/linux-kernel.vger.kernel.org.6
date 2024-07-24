Return-Path: <linux-kernel+bounces-260558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6641F93AAE5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B00C2862F3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3BEFC11;
	Wed, 24 Jul 2024 02:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b6DLylPV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFC018040
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721786842; cv=fail; b=K89Izx0fSNmIMRW4In1m4WsAqSTT74PIu7E4TklEr7XRi6iCtx0VzRzx91j5bcrC6VTn9F/YWsvaBvyQA9C+xD6nLfRHzP0t+oPehKcItOJbeoy+M6mL4ylqP2JapRdIO+JcYRhFzdopEMzCcZyDj6xtk13I3QSXOflvzmKGZ9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721786842; c=relaxed/simple;
	bh=tGc31TpwRWC+V/KaxSImlgEhJmcR1cXJov95YGt18b4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EsmNpoqaupU+gof3W217iEc76aGQR4HmhyW3FI0YoNxBKq6fmO5FO8i1zn9POFzEDiQZ/pzgDJgSYi6vMzJcHEWqXwQ7JGcygtPd/vRJ/KDr/77b+0j9XWaiYQh2XHrVk9H5Rakf2Uetzn75ITFIApzakS2s1f08FPfiJrM9sXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b6DLylPV; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721786840; x=1753322840;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=tGc31TpwRWC+V/KaxSImlgEhJmcR1cXJov95YGt18b4=;
  b=b6DLylPVwOv/aqbYkOx0BTJ3jWiAJqLj4Y9KU8oOMez8/mvFqiT+jUbG
   3YeNt3xpdKo0V+SG5lw/gQ9zV3SHh2VY5e5fBOta7R344WQd2gDHCeVDW
   kYxQCshcY1LSQLkQxxBRjM4clN7TzoWGs86sB8sFm+bNNH2cLY4JX1jDE
   oxoiJeA7M7rddCS8pzrU2+7cXjJYisxwKkrgcV5gQVEfU4XLW+p5NCIu9
   9VJHqY51J/wGI8iuuAcirHO7lNpICVxTtpUnjRWcsULthK94zU0J8PUwN
   I2VSmblALqwvgr2bhPhwtIH5NZtaFIZp8UuSKBmxfsf6qME9Sv1woT8Ew
   Q==;
X-CSE-ConnectionGUID: tyo0cDvfQ3GlLQg4OqSYbQ==
X-CSE-MsgGUID: 8N33rJ3vRVWJoGU6jOdkXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="30859676"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="30859676"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 19:07:15 -0700
X-CSE-ConnectionGUID: eg3JmvT1RqO8v9THRbHJFw==
X-CSE-MsgGUID: sq1tb9LKR8GsmNjALW6pRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="53030161"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jul 2024 19:07:15 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 19:07:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 19:07:14 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 19:07:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+epMfN7DLAZW/a5AjTu5LMRzuoAcblN0BUxlULjwUuHU8x3Eo+kEIZZIAQCJU8RIblKbm3nHjZFUb0qAVhMs+fH5MnOE+lhWe6fP7zqUj94jRXWLvaH3GafNzHweaOtVbZMLj+OmLzT2KF9SYOypbK/Yr78s9BcwEHPg5VDzNixwb7DokRZXQOfHEADEbTgvCxcfnSpjEmZLnVGhrRiLr70bO5rYeBcT6Hhny5sJ9T04vPdc59Lmw6VXc+I+O3Hbh3HWEz1xk4l/+oM18bDcgaZs5X5ksKqjReyMv2ALzc3xM6EFEi8oPiocftzsvU4jih5N05iNp8neLLha0lUkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umm+aEp4BYcbPDQUCPYUZJpbTjQzws7jli+W159Kznc=;
 b=a2NHj5IJj/u2rjEtf9dNYsvkCIiRagnJK1Fi2G+S0quBC2GGwrroN5qtCr0sDTAH9W5kVVGE4f95KUCXABNQDaBwKgWCN+zQ/9wnYMf77mwChSN7JbLycnLHyWtprK9//8+Z9vGnUu7FM+W6oApqwHslFg2qZovlmvOg3LVft1S3esDu2onkO9JjrmIWhDg+JfmXek2f1/dOHpZKf1y7/STGWiE1ZwyhJm4kGCeC1So4m5XLu6qma38ORnDRL+F60E1yo9beTJ6262sgSwK1Mczh8eFabsllQ9jsao2Ai6R9AXTXYHhkNYYV1kG7Qdj6YZ1xbMEHneyIU0BMkrp7ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.17; Wed, 24 Jul 2024 02:07:07 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7784.013; Wed, 24 Jul 2024
 02:07:07 +0000
Date: Wed, 24 Jul 2024 10:06:45 +0800
From: Philip Li <philip.li@intel.com>
To: Qu Wenruo <wqu@suse.com>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, David Sterba <dsterba@suse.com>
Subject: Re: fs/btrfs/inode.o: warning: objtool: insert_inline_extent+0xa8:
 unreachable instruction
Message-ID: <ZqBhtQ9SBZ2yLek8@rli9-mobl>
References: <202407231331.vNHHJPnu-lkp@intel.com>
 <8afac96c-979e-47b4-8416-c26ba4c4a348@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8afac96c-979e-47b4-8416-c26ba4c4a348@suse.com>
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6039:EE_|DS0PR11MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: b14e3650-231e-475d-6db4-08dcab8551c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmR2ZUQyRjl0UWhrT3dsNmoxeXNLUTIreC91cisrajdTQnJ2WlVXZTBFS0Jw?=
 =?utf-8?B?UnpXSkt0Znh3dWh2K1hIOURSbEgrajExRHlORmF6SGlMczNaZG1CaHFKL2xx?=
 =?utf-8?B?Q0t2VHBIMU1sYm5qczlub1JyU002ZWtUU011N0Q5czRuY0JSU2xIMlNxZExa?=
 =?utf-8?B?RDUxTk00MmdKTU03WVRTQUJXMnVqSlhLR2czL2NWQ2liMkltcjlndjJnY0pl?=
 =?utf-8?B?UmR0bDBaLytuTC8xZTE1OEpQOXhkdDZlYk5OSFBrcHc1clhLNzI0Q2gwMnla?=
 =?utf-8?B?WFRnYUk4T2hGYzVOR0VnMFVuMmE0bVZvUWlSbzRZbnAvK3RCOWxuM3lvVzho?=
 =?utf-8?B?RXoxL0Z5Y3JyelZhcXpiU1ZLb0YwOEcxbkpzb1R2ZUdHT0t6MUphaDEyeHRC?=
 =?utf-8?B?YjgwWEVDaDE2ZUEvTU5USzBkeUFtaUx6RHZrZ0t1TzNNOWVodVZ5QVByTk9j?=
 =?utf-8?B?RlpuMC9qQjhwaTRzYjNUNFZaMFdnWXVMdFpzQTNQOVBnaHY3UXg0TnhXcWFU?=
 =?utf-8?B?c0xyNjF3QjJHMElKSnNnRE1CTTFyRkFXM01ZSEhBTEZoU3o0SDFQbTlLNHd6?=
 =?utf-8?B?UlIzVzR6cWtjZFRzaDJkSWtHS0QrRCswN2VJNHBPZGlhZkd1aEpUbUJqcmd4?=
 =?utf-8?B?VE9aaS80YmJsSjU1SnN3SHpoL2RMdzd6c3RySG9pZ1h5MVZId0dKVkRJeVJk?=
 =?utf-8?B?Mkc1YmNPcHRIcTRnL1JNZzBXQU9TMHdVTTR2cjVORFVVbk81NXFKbnFVelVC?=
 =?utf-8?B?Z3BKeFVLbFp2UXpEMHlBMzd2STBUcms3WkM2cEpMZDY3clVpVmpYZVBKUTNk?=
 =?utf-8?B?bzZ2dy9lM2JTTVBNOG5JN3FtcGpRMG9EVjZDcGozWmVVZFhHTkxlZDJaK0x0?=
 =?utf-8?B?eDczNndmeUVEai9vTm1OVEhYMElRZC9yMktZTnE1WTRUK0dwVnh5aGh0SFlm?=
 =?utf-8?B?V2NyNzVvbERPTkFFcVhBNjVWZ2pIc3dyQXFNS3Jnd2d6L09XVmxMcGRjZzBE?=
 =?utf-8?B?YW9LamZodzIrTW1aZTZXbFp4aGNQNGMvU0RVWGxQeElMU0lMNEVLN3cxSmx0?=
 =?utf-8?B?d25jV2RhYVNFS1hNTXlQcU90TUFVb05KdTlSdk5vckowV042NkFvbFVjT00x?=
 =?utf-8?B?TjNPajhHb0Y4NEl4U2VDRUY0UFBDaHB5WDF4L0pYcWxNY1dJUjJ6OHJUL2ZE?=
 =?utf-8?B?TUMyc2lLcTFCQzNaTExqTmpoNWpXOTBOaGhNRzlBTzVwQlBmZ0daTG8xYk10?=
 =?utf-8?B?K0ZFUGNTMUJ6NFNqWlRpNU5jRUJ2MlFKV0xSdkRSS1MxcjlaSHdrd2M3VHdH?=
 =?utf-8?B?UDFISWo3R3NObGhRNWhJNy9SK3VKSElUd1diWUNDVHdwd1R6Nm9KdFJqNnhO?=
 =?utf-8?B?N1JTMTM2QllIRmtrNmh4cjZjdUYwZnZ0R0s0cVA0MkZ3REduc2dpRUcxQVV4?=
 =?utf-8?B?M3J2RVB3MEt5Wm9vV0d5cHB5RVNOTVdBL0ZCRURvemg2S0s0MlQvOWcxZVd6?=
 =?utf-8?B?TGtCQTgrK3diZENPeGIvS3BaeGpnYW9HUkU5L0dydlhkQ0JXekZkNWZNYWRi?=
 =?utf-8?B?azBFZmhFajU1cWZ5dWZNREhlVkRBZWd1ZFY3ZWNPcXJCanIvcWJrczNHWVZI?=
 =?utf-8?B?bnVZWVA1blR0V2xRUUZ3VWFhNlQxZGVDL3pRbnFKK0UvT0tUZWlwVWowNFdB?=
 =?utf-8?B?ZnlYRzVvY051ZVpLeEJOR3dWU0MyQ0NvRTM2SDBaKzNOUEhZd2ovZGdWaXNm?=
 =?utf-8?Q?8M3UQ1IUwv3XLKFiVGRSdIO1LiWHKIyrdbgEXJ6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnVXZ1FOMDkyLzhpRlkzaC9wOHEvSXJtNzNOSlNqRjJHMjdMbTVnRmNUR3pX?=
 =?utf-8?B?Q0hmaDlrK0hUMGxReGNFSkZWSWpmY3gzWDBURkFLWkdOWTE3WENKNjVTRzBi?=
 =?utf-8?B?UlRma1hQdW04YnFuSnVIaDRaUzAvczE3RHBrc1g2cDV5R3h5TzMxUjl3dUZH?=
 =?utf-8?B?UkhyVTYvRnBZWUcvTFYzK0RxUFdFL29tQmRoWHp5ZW5RWEZaaEQvbmNwUVlS?=
 =?utf-8?B?bVhDWmhBTmFhampnZE5XVVRlR1VEcmg1ODRuNGxITVBIMm1vRzE3LzQ2QjFT?=
 =?utf-8?B?VTR2dERCQWVNbDhWeDdyUThoT1ZBcjBJNGJmbTBaSGdpbStKVDFzdzVQVVZp?=
 =?utf-8?B?dkp2TDZCeDVNdE96SUVKVDROeEdPL0RlWlFKamd3M3hIc1B2TUlwc3hSL29T?=
 =?utf-8?B?K00yekNaZjVxK0t0am1hdWRhYVByM3pha2o1MGtnOU5PeHpmOTRpemJpaW1s?=
 =?utf-8?B?cEh5RzF0MCt5by96cnVXZkswWFBBenY1NHd3dXVERWtIQnh1aTgveGpzeTEr?=
 =?utf-8?B?QWlCSWt0aHU4Q0dBbGd3L0FmaDFsQkVuYnJOYnA1NGZ0cjA3MG1qbGd4ZUpR?=
 =?utf-8?B?WkRPK3FNS21tOFdSbGNIYVcvT09IS3pBU2Jjd2ZCWWw3ZFFiZ1dSV2JrZHJC?=
 =?utf-8?B?THA0bW55Y1Zyd2N3d1JCaFV6OUFXOGtGRXlpVjZvVndKaGlRN0NKenk5dWpx?=
 =?utf-8?B?UkNTdE90NGJpYVhDK3V0OGFlWU0zeDZWOG9kRkhjODR4OWtpNVVCSDJVdW8w?=
 =?utf-8?B?dFgyVzVvK0ZSUkNUUHRxTk1mRlU2bzROb2F6ZkJMVGttTXcycG03aUtlN0pn?=
 =?utf-8?B?TDNpTTBOUytzQktWQ1JiVGdhdzZMdGYrY0NramU2RjNoRk1pQ1BNWFlKb0Jq?=
 =?utf-8?B?b0ZGVnNKSlY1Zm1KV2U0cHZDYlpDY1RubWNCUHJWNHNtclZraXliVVJkS0xD?=
 =?utf-8?B?ZXBsRTFzTW5jS0thSG94dGN0MitHWkRFSVZ6MWdab1FkdVVzMk40bmZvcWc2?=
 =?utf-8?B?ZUhMVVdEeTdOUU9PTW1Nd0ZKWnRsVW13VlN4cUhTaFlPMjlHZWdsUStPaURt?=
 =?utf-8?B?N2Ewbk1yVDVWRXVHcHU3c3JOUWRwVGhtdTd4Rmx3RUtZZ2dPYVZSaDRIZFQ1?=
 =?utf-8?B?cm16Unpoc3pMRnZkdldWMC9ISEJmTTZyWGxRS2o4dThCRGJMV3NNSDdmL3Br?=
 =?utf-8?B?Q3lPaWI3bXFDMjl0d1VDR0FXK2h0cDFra1ZPUVhwam9MMWtSZUNldmoxYXBV?=
 =?utf-8?B?VXVaenpzKzYvbTVzT0Q3a1FMZWE2WTd0TEdaL1BnZmVseDZ4STZoL1AzZWNk?=
 =?utf-8?B?WUVxY3RqcXRyWkszUHRJNEtDSUdaNGJQMFJNNHRLZEZhcXF2Wml4VDJEMnZF?=
 =?utf-8?B?WkRZOXFnYUFyMFVTdllGRnlaSUNuQ1JMVXV1OU5acWtxdExLWno2dXZWYkQ2?=
 =?utf-8?B?ZnQ1WjgzaDhQVEdmSy9yNEFpbVY0d0NnME0wSlhhZkhReXByOTAwY21JUXMv?=
 =?utf-8?B?VjQ2RTY1cXFYdURPbUhhdy9CT2kzL21PUU1PNHpBL1hDZ3VWUWlOU1IrTFFu?=
 =?utf-8?B?ekgyenQ4NVFCQ1FPWHBaaUthSkVwWllkSkRENXFEeTFHenNQSWdwV3BkbWho?=
 =?utf-8?B?d3BJMzZWdGVoV3EzVm04RTN5STVYVmd2ODlOZWxPN1lMZHZLVWQrempDZTcw?=
 =?utf-8?B?b1RpZHZQRURtZ0J6U2VhN3dmU0lXaEptaWEvV0gwOW1Wb0t1dDUvTzVGS1ds?=
 =?utf-8?B?cGQvNlEzREphbll0TXc0R2JQQkRHNkw2azA3OU1EVVRvU3NCY0RWSGQ1YW1x?=
 =?utf-8?B?RWRyeElETDNZTmdNRjd5NitRYS9od25IZUxwRmplNFF5MW1KeCsyZnZtU1h5?=
 =?utf-8?B?L3VPYWVOeGdjQWcrUUkwRll6dk1BN2RKQmlFNm5DNCtXcGZvWk9zN2s5TDVl?=
 =?utf-8?B?LzVtbDRLNmpjclJlRmZhQkswaWRLdkhqai96TEhYV2FrNTQzRlo2OFQ2Q012?=
 =?utf-8?B?MTFQRjd6UlpzQm1hUFQ1R2dQc3NocHBWY0JoWWxjOW5XblZuVVJpcWNiQzZ2?=
 =?utf-8?B?eDV3SmVoNXI5VDJlTnUwTnY3cnA3d3dBaUFabEh0THlGRWJTMFliWjFnOUNN?=
 =?utf-8?Q?3Ah+hM2TPDbU6i7B/Q8QLmtNA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b14e3650-231e-475d-6db4-08dcab8551c1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 02:07:07.1950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +K86+jjZ270ipcjkeREFFh+80dXxVBgmiOqjELkTd1jF93LD6M1YxSJ2Hg+00Uw2CeHSyeFC6AKImrLyNtTkJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8208
X-OriginatorOrg: intel.com

On Tue, Jul 23, 2024 at 03:07:54PM +0930, Qu Wenruo wrote:
> Hi LKP team,
> 
> Thanks a lot of your reports.
> 
> 在 2024/7/23 15:02, kernel test robot 写道:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   66ebbdfdeb093e097399b1883390079cd4c3022b
> > commit: eb1fa9ab470285d39bee268bc2a90d1786610711 btrfs: make insert_inline_extent() accept one page directly
> > date:   3 months ago
> > config: loongarch-randconfig-001-20240722 (https://download.01.org/0day-ci/archive/20240723/202407231331.vNHHJPnu-lkp@intel.com/config)
> > compiler: loongarch64-linux-gcc (GCC) 14.1.0
> 
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240723/202407231331.vNHHJPnu-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202407231331.vNHHJPnu-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > > > fs/btrfs/inode.o: warning: objtool: insert_inline_extent+0xa8: unreachable instruction
> 
> However for those not-so-common archs, mind to provide the code line number
> if possible?
> (Better for all archs)

got it, usually the code info is provided to all archs. Not sure for this case, but
sometimes it does fail to show code info if the error like this doesn't contain line
info.

> 
> Although unreachable instruction warning is mostly false alerts, I still
> want to be sure.

Sorry, kindly ignore this report for now which could be related to tool chain upgrade to
loongarch64-linux-gcc (GCC) 14.1.0.

We will further check whether the issue can be reproduced on gcc-13.

> 
> Thanks,
> Qu
> >     fs/btrfs/inode.o: warning: objtool: btrfs_del_delalloc_inode+0xb0: unreachable instruction
> >     fs/btrfs/inode.o: warning: objtool: btrfs_set_delalloc_extent+0x18c: unreachable instruction
> >     fs/btrfs/inode.o: warning: objtool: btrfs_evict_inode+0x9c: unreachable instruction
> >     fs/btrfs/inode.o: warning: objtool: btrfs_get_extent+0x3d0: unreachable instruction
> >     fs/btrfs/inode.o: warning: objtool: btrfs_set_range_writeback+0x7c: unreachable instruction
> >     fs/btrfs/inode.o: warning: objtool: compress_file_range+0x388: unreachable instruction
> >     fs/btrfs/inode.o: warning: objtool: cow_file_range+0x128: unreachable instruction
> >     fs/btrfs/inode.o: warning: objtool: btrfs_finish_one_ordered+0x174: unreachable instruction
> >     fs/btrfs/inode.o: warning: objtool: btrfs_invalidate_folio+0x1b8: unreachable instruction
> > 
> > 
> > objdump-func vmlinux.o insert_inline_extent:
> > 
> 


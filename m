Return-Path: <linux-kernel+bounces-296877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DE095B015
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 427FAB222E9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B8416A94F;
	Thu, 22 Aug 2024 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIIGCx4q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9861802E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315002; cv=fail; b=aBQGFz0mVMUwZPz8QEkmgiT8lKsvVb7LGSzT+Gy4iBPduq6PtR2MaafUpzD+/YjZ2KkPYrrByfbKHE7MhOKmMf5GjuWE81Xttbatu11gHEDJ/1kruBD56H96K5PxjWfqCxY30cM5V2SLXgSXi2j6hKG+h0E3SipDCyRbRuHl2YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315002; c=relaxed/simple;
	bh=mCAGOEL8vWg8Lfg1gWH7r3tV8UCgxennwDQ6Z3ucKDI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hZ94YDBsmeashmM40/x2wALKWCo81aUumSdVoCgEoZkeNHRLe8dFozqN8MPz05I1jWAwhfa2r1SIbBK0WlfO0LYc03ijfGPvJzVb17zJN1wsFseXetav3QXYrFGzoZe2kPj3ns+VDWRZ7FuB34AMb0uBURBVypmAXm2k49SM+Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIIGCx4q; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724315000; x=1755851000;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mCAGOEL8vWg8Lfg1gWH7r3tV8UCgxennwDQ6Z3ucKDI=;
  b=nIIGCx4qkgoyJyNDoBjleWobsQLtR5Sy8WovDUu+uSC6UC5LLGHG9fSn
   DXnIsiuNF2F/9jb5KRzcvu4ZAAwIigSGA0lRJF4w6qMDDswPx3JhN6s9e
   64jER+D3mcdqPjnu9sFS1FMzVDxvGKRN2M9DMAnlAvKiWwCFomFwZSvkj
   LrgckD7oAPpEXz1LTMvcvE1PIQz75NmOxSEw4k4Hv7Sndcr7dPdWS+QOa
   HNkErVFxNutiooy/wpe0HPDySBNle0GjJU4UqtsU7mRZuFpbC3cIos1J1
   jrZsfVDuNLBD6dW1JV0c36j24MBm1o8II92uXhF9Kw/Vg7zWonB2Fv4T8
   g==;
X-CSE-ConnectionGUID: Ek2PFM/kR0e0uaD3CXc8Mg==
X-CSE-MsgGUID: 1R+28bqTR3uipy/VlkyXlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22884283"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="22884283"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 01:23:19 -0700
X-CSE-ConnectionGUID: 7WaJyXGvQoSBNEC3n7fVeg==
X-CSE-MsgGUID: 6vLUPagHR3e51yx6TMnIdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="98863830"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 01:23:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 01:23:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 01:23:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 01:23:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdTKteD/0EbhewTq7+CIYPFKnPwzz+YV/fmLR3VKSgY6n5iNtX3RWQR4OhnZm/biiaEXjIryGb7cYQGXraR6p9NSkhr+vbV/OW5Cs+YHOg2Nz3CGRvZ9FBQoDiKZRNXAZquhLbhhqL6d2MiS+ROWhMXwLlfu7k2ZI6x9r+hKcA91jUrBJ1yAOc9hqj1qb85CgiXyab+OSoSpuV9PkKIktattl6LlWkn8OpCDEpikZEVR/kJKCYXQrLfnhECDERUYfNelAQ2iAqWSQmndAnmHzusjyl53qOCK3bsROPhUsA9XpUBWW4wtBcr5Ixo3SAF5lB639eF9Ue7YMcQJZFKxVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDupw29WyDrPc0x4bgyhbLK6ff0VY3/c+cq/M4WkBoM=;
 b=bpNfoIaagZ0Fe1SrwZMq7axm7stNOW2CqQ2D2p9BFCxWRthviR9ff5UFPmzwTpW/WfDSg9ei8o2F02SA4C6V/t7xDsk/S5T5eA1oxuHPNCLHSEz3eYG1iPFyRe4xYHdycrX70jHtTSswBaKi52p8BfxJOeXDK8Tjmzv7LSBNl59sqNMKP65Q23YGgZxDC3g5niFpMX4gAETcFsyt66s4+QTuEABdjL5dAruVdJdtLy8f2rEuqV0byE6zVr04xpjWAWuA7eDK+cEvDlwZFpNnHT/ReYhf8sd23eae7r4XRIX1PIbOc1MpanGITCMoj6RZXOh6ve6Zbf3Vl8qzTNv1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 by CY8PR11MB7315.namprd11.prod.outlook.com (2603:10b6:930:9e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 08:23:10 +0000
Received: from CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3]) by CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 08:23:10 +0000
Message-ID: <3ba6caea-654e-4dcd-a4a4-bfdcf808f0e5@intel.com>
Date: Thu, 22 Aug 2024 10:23:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING: [xtensa] modpost: vmlinux: section mismatch in
 reference: ice_adv_lnk_speed_maps+0x14 (section: .data) ->
 __setup_str_initcall_blacklist (section: .init.rodata)
To: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>, "Max
 Filippov" <jcmvbkbc@gmail.com>
CC: <linux-kernel@vger.kernel.org>, Pawel Chmielewski
	<pawel.chmielewski@intel.com>, Jacob Keller <jacob.e.keller@intel.com>, "Paul
 Greenwalt" <paul.greenwalt@intel.com>, Simon Horman <horms@kernel.org>, "Tony
 Nguyen" <anthony.l.nguyen@intel.com>
References: <202408220755.LlaA10C6-lkp@intel.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <202408220755.LlaA10C6-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0178.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::22) To CH0PR11MB8086.namprd11.prod.outlook.com
 (2603:10b6:610:190::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8086:EE_|CY8PR11MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 627f4a49-1cea-4a97-93bb-08dcc283a8ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2E2ZDlhOGs0emhGekdDR3RFb29jRlVCMkc0bzdRVmVaMml1N29LMFNYTkxL?=
 =?utf-8?B?MEcvT1U1Sk5WcFdid2xvOEJ4MVp2dWNFakd5cGl5aFJOaU50VDAvc1YzWlFO?=
 =?utf-8?B?YzhtU2dCNGM2Qi9INDVYWHc5dXFuRFVHcTBwVmttRis4NWlmdE5iaFhmVUVl?=
 =?utf-8?B?dTdxaFIrS2JUMnlHbi8rNmxVckIyRHp5aERwTHExK25BZ0gxU2VUaGIzbm9I?=
 =?utf-8?B?SC94S1BvV1NSMlZiVExYZURzbHg5SE5tWklnMm5CcnYvZ3pBcHdVb3ZINVVN?=
 =?utf-8?B?SUM4QUU2NWJvUktmVVpteUEzeTY4L044ZERhc2hyM1M2MTVFci9CeFNjeWxM?=
 =?utf-8?B?Uk9ISzZmRHNoang1T2tPL1IvR2ovaHRBSUV0WGZKMHc1RjBqdHpCZmpzTVJz?=
 =?utf-8?B?VDQvWkNJcGliYTZreFVDT1I5MVdETHVnZDBkYmMzRDJOZ2NILzJ5WGdtNUhp?=
 =?utf-8?B?Q3JmU0k0SkNCZHQyWkVSaHRzR040eXhNMTRVUmxBRmQ5VTlSL1RIWVpBWDJr?=
 =?utf-8?B?Skd5b0lPZEFmK3R6WXNuaHMwcnNuWHdLRXNzb1lRNmxWazlNbXJ1NG05a1BY?=
 =?utf-8?B?UC8yZWFIZTR1bkJPYmExN3FMdXJ4S0xldFdlT1RzK284QWhSYXNjVjdQbHN5?=
 =?utf-8?B?SzdWTmhseGt0MWhGNFVvaEV6d0FwL1BSMHBkRnpvVGE1aE5qN1V6Rlh4dk9u?=
 =?utf-8?B?aXZ3UXc1amdmeklNQk5oTzR1OHVYQkpYMkJIL3h6UEl1YlVzR01XMU4rQVcz?=
 =?utf-8?B?RHp3ZFhXdHZtczZkWEt2R3o2ZVBDSHRlR0JFdy9iVVhhZmFzZ2E5akwzaUla?=
 =?utf-8?B?TFIyR0JjWHNvY25YZVh3RUNQZ0xQWGxLK3ZLbVhCcndIR3YrMEt4VWQrVWda?=
 =?utf-8?B?SEk0Vk9LUHR5Q2p4R3pzOHNFc3FIV3hpVGowMWMwN2ErZ1haU2JXTld0UmN5?=
 =?utf-8?B?Nm4zNzhhckluaVlMakhvd0tTV3FvWHN3S3prcDNpNEFjcUo2YjJ2OVlDSTRw?=
 =?utf-8?B?UDVrbkc5TXY1SmJMS3d3cVA3RFErNFBHeEJsZExCT1ZyRzU2a2E2eCszRkZ2?=
 =?utf-8?B?N2tuOHZsN1hKVVN5RW5uMUd1ejZ0Y2NyQ3dNTUVVckU2TXpHTkJidFdzdjB3?=
 =?utf-8?B?MWV5SlZKbG9hNlNlRXRFT3FjdFhCeWxQSEZRN240aU4yTmNCSUgwaUVmYUMz?=
 =?utf-8?B?dm9yd01VNXZ1WXNMbWRxQlFES0FxZlVtOThoQURnUmZuN2VGb3hVdlN4dXpl?=
 =?utf-8?B?dzZEQmZBc3dGNVBNWS9TY2xBNytFYU1UcnViSmhmRCtvRG15Zm5zRElZOUZ2?=
 =?utf-8?B?dkZuejJ1djA4Uks2d3F1NzRHT3BBTmNIcEF2ZUVacXJidnpNdHQ5SjJGTVZR?=
 =?utf-8?B?VlozTXpsNEdDckhLZzE3YVNidHJlSUFWblI3S1lDeHFiU3hqdU9acEhJRGNK?=
 =?utf-8?B?M3Z3dzdxV3k3U1pDRU9sN3dCcUlocy9PTXJYVU90ZWVQaVZsc0xaTVBCL1NL?=
 =?utf-8?B?WTFiZE9ZcU1nTlg1N1plbjZQSjRrc3Y0V3ZVemVwN0NZczdxYTVSdHNWYk0z?=
 =?utf-8?B?TUI0OE9LYzY1R2NvclIyR1QrRUNUQ3BlZ21hdVlqN2k3WXZQMldrYUI4UmxP?=
 =?utf-8?B?dktqRS8reUl5OFhDSHIwVkZYQk5GSVFjTmxacE9xY3c4L3lzQ2REd3B0c2Fs?=
 =?utf-8?B?SHRWN1lDMnBzd3lGTnIwUGs3SEd3VFpwMWNNMlFPbWJDd3FMYUdQSVA3T2Fk?=
 =?utf-8?Q?we8n3D8KVSPGmVWSqY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG1kOURIeGpNcGY0eGJXOVZpd1pZYW5mYTAwbm1ObzRWWTlxTFBud1diSm9D?=
 =?utf-8?B?L1dMcWdZMnl1dmQ2STAxcEVQbHliMDBrOXhYS1dwQW1icjdocCsrWUd6WEVz?=
 =?utf-8?B?WEgvQ1RhNHNIdXF2N3VUZ3hIRzhkcU4yR2p5SGtQM0toUTluS1NrWWN3RC90?=
 =?utf-8?B?V0ZZNmcvbG9pMDBUL1gwbEF1OGVpUWVjdEhhcHBtUk9rajdMSyt6N3p3enhi?=
 =?utf-8?B?ejUrc0NWYnFEVk1hTUFMK0FvVENqN0cvdklySGxHVmJwT2NheXlsVWIzTHhp?=
 =?utf-8?B?WjE2NWVFZHNKUmRzMzlCVEdJRnZ4U04xQ0NBM3AwOUhuLzRtSzkwNTlPN1Q2?=
 =?utf-8?B?L1MwWEE2c0Q3d0NQTmVQUExsOVJvUEhMd25wVTdGZUpxWWRDU1NsaHhxWVRa?=
 =?utf-8?B?UUlYNjQ2N3ErOG9rSUxXS3NpcndxSmR0Qnk1OHhwaWlhUTM0MG4wU0FFc0ly?=
 =?utf-8?B?NmZ1NG5OaXpRMDRlVWNSbFBqUVd4b2l4QjBQOFdKdkxMZ2FKUVErTFhlRWMx?=
 =?utf-8?B?WUp4aTFMUjZ2K2xWVnZBOUQvWkhqUXFiMDVHWEc3Mzk2RjhPZWljRFZtNkQr?=
 =?utf-8?B?TFloWE5CT2dMNy9rZlNJL2VScmxJQVZ5d0d4T2NpRE1mdjgvVE5CdFp1SFpS?=
 =?utf-8?B?a043YXphcm1xVTBBSVVka3NpekhxSzF6NW41RWx2ZU1kWkVteU8vL2s4ZU5N?=
 =?utf-8?B?ZjNRc3oreUxuNXVGRjRodUxuQjRJaGNPVUZOa0JCcWlFVEhuY0dZOWZhYzZl?=
 =?utf-8?B?dU51NVBGUTl6YWwyNXZSSlBqQ1RzY1VHVzF3d1pmMG5MTHY2Yk5LdVBoMUpj?=
 =?utf-8?B?QnlQN2xsajhtamJOc3NxVDZES045bzNRc2pkM1JEbTR6R2FVclhjWVFEcFFx?=
 =?utf-8?B?WnRsdkdLWjBWNHpwSWRFT2RTYWtJL1BxK3F2N21CR3crb2JHcnF5U2tEWU0x?=
 =?utf-8?B?a2h3RHQxaEo0bEozZ3FzejE4MUFxWll6ME9OQ0ZSUkxEL0thcWxEdVFyQVNO?=
 =?utf-8?B?djNEVFpMemNCNDcreVB5M2FyUVhSMUhEMkRCdE5scmcwdEFVNzVQMFAxcTZ3?=
 =?utf-8?B?ZGVJKzZwYmNSbTFvaGVrcVJwZ1RxRThlUnV2ejUzcTdWdk85MHlvYkJ1cGhF?=
 =?utf-8?B?c1R0WG5aUnRNNEg5cGVFSzZxWWphN2lyV29FLzlaRjl1U0NnSndKSGIrZWR5?=
 =?utf-8?B?UVdKWXdEdXRxSjVjU0o5bDNHN1VueDVpV0o2MnVtQzB2RExIckxJZ1hqa0th?=
 =?utf-8?B?N2FWejJvdS84eldlK2JzY3M0RTNGbjhTM1JuVHBLdit4UVRsbE5jRkYrbFpG?=
 =?utf-8?B?dk1IUzh6TVV1czVEU3c2UnlFZ1pHV1hDdVdNMkdXby9uRE9QdTdLL0xCS2hO?=
 =?utf-8?B?QXpWRk0xc1dlK0VIWGVsS3pWUFJEeHhJaHVZUWhnWlFBdVNZaFBnWGN4Tkdj?=
 =?utf-8?B?Z2VPT0RaYzJCUHo2aFRGUC9qVWdGZHpOTHc2ZC8vSjUxbUluUHkxa3kxUU9l?=
 =?utf-8?B?VnRDMzVxYjFBVjBUQXhqVm1welhlbENteVlHZzRWQU1YNDVwUWJheE1WNkNO?=
 =?utf-8?B?d2ZLRWFRbCtKeitRa3NBYnBYd1JyUm5lWGwwUHVkc0dHRHVwWHp4SFB5TWVS?=
 =?utf-8?B?S3EyMDhDcEo0dGRwRlpBS1lxNERRdDlRZlFyWmtObHkwTm9ZRUZ6dlppbCtx?=
 =?utf-8?B?M1NrS21GbkZkM1RkTmFIb3NoeFBVR3NRWE9YYVFHZWpKTmNVcHdLQ2hEUXA1?=
 =?utf-8?B?Q3N1YWFNc2taYlRVanJmS1ljc3ppTDFHYnVRWFRnTis0TWN4bTZtdFlEVVJq?=
 =?utf-8?B?U29INTZwMzRoRzZkNkFnYjVKS1QrUjAyenRSY1JuMmtlVkJOc3Qzd0g2RGZi?=
 =?utf-8?B?bFowSm9tdjFIVk1HSE41eGNvVmFERHFFVTNnMTdObGxyeDRtS0ROd092ZGdT?=
 =?utf-8?B?TkZzSVlBK3N2R3Zsamo2S1o1U0RJMmJUelc1MjR5Um53ci91MndORjFHQ1Zm?=
 =?utf-8?B?ZWE5Zkh2cnJIOXJvOC9jR3NYSEVPajRNblJHcDlOdzBYNTZYU1lZSVBNanll?=
 =?utf-8?B?RmpPSndZd3RiZTI3V3hFQys0SnIySDZiTVlGZE14dTFnM0luZm0wN0lVVkxT?=
 =?utf-8?B?dk5CcXpRRWw4UlBzSHZ5aXJoVGo2VnpNait4dG9tYWNKUDRzRzFnZnloQ21J?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 627f4a49-1cea-4a97-93bb-08dcc283a8ac
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 08:23:10.7293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOHGmNHBUAwFidrZYn972Hm7MB5iQQq1G4Q2kywGAv6YEetRv+QDZGFTIajmp/U1g3F0sv21AkfaRXY9Lmp4fNcyvwk45l4hqnvEbqDQiAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7315
X-OriginatorOrg: intel.com

On 8/22/24 01:24, kernel test robot wrote:
> Hi Pawel,
> 
> FYI, the error/warning still remains.

Apologies that we did not replied to the original report.

> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b311c1b497e51a628aa89e7cb954481e5f9dced2
> commit: 982b0192db455d288fc1deb06632f529c35daa15 ice: Refactor finding advertised link speed
> date:   10 months ago
> config: xtensa-randconfig-r123-20240821 (https://download.01.org/0day-ci/archive/20240822/202408220755.LlaA10C6-lkp@intel.com/config)

I wonder why there is 6.6 kernel used, perhaps not a big deal.

> compiler: xtensa-linux-gcc (GCC) 14.1.0
> reproduce: (https://download.01.org/0day-ci/archive/20240822/202408220755.LlaA10C6-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408220755.LlaA10C6-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
> WARNING: modpost: vmlinux: section mismatch in reference: put_page+0x78 (section: .text.unlikely) -> initcall_level_names (section: .init.data)
>>> WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0x14 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)

I have spent just half of hour on that and I'm clueless.

For reference, the driver code is:
	static const u32 arr_name[] __initconst = {
		SOME_CONST,
	};
and core kernel has:
	#define __initconst __section(.init.rodata)


@Max Filippov, you have authored much of xtensa arch for kernel,
especially XIP support, and touched .init.rodata back then;
perhaps you have any idea what is going here?

> WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0x30 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
> WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0x4c (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
> WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0x68 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
> WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0x84 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
> WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0xa0 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
> WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0xbc (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
> WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0xd8 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
> WARNING: modpost: vmlinux: section mismatch in reference: ice_adv_lnk_speed_maps+0xf4 (section: .data) -> __setup_str_initcall_blacklist (section: .init.rodata)
> 



Return-Path: <linux-kernel+bounces-210957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F17904B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB61B1C22DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68A584DFE;
	Wed, 12 Jun 2024 06:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NuGVPfHq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF4D84A48
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718172120; cv=fail; b=L0WK7v5Z3+iwDdAVIXwXRal8kcLWVJLhVw/Ji9awWMRKUTxFxIyxoKn/Oemq1ywbP1VnPHVvYmmIknDgVzAKY4TzA+3GZ7YE7Pho6lUkfcEBkGXzCtJGY6ib4bvFARJHkU5biCzeNGhjae91Rk2bHatPEMjkOOLlxYKx9h9PfMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718172120; c=relaxed/simple;
	bh=G28djTwuQ/tvMFor9GaahciBLwrEJS8B5UdBmXRkyTg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eg0nTWSx3j27aNiYFvGUhVwgx2gnqWRp4O/RsVxbWN2z5NbR5CzY7vw/HZoLlyQ43yIGtjlpEj051lbby2TpjDAlUjefILDPMZHoZekZc8HwGzD17EghbVVFjcJP88ZRTfowVG9LG6X4rD8vXPQophyfe5bVv28L9kcFnbRTRF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NuGVPfHq; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718172118; x=1749708118;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=G28djTwuQ/tvMFor9GaahciBLwrEJS8B5UdBmXRkyTg=;
  b=NuGVPfHqXRi83WIWR3ywpFZTFodDy7xOVXv4h6DvR2SrBo3VmDPgaYUJ
   wBGA7BzeNTgP+qhrzylo8usoPog3wwFFUftmqhw776WGqNMSNM94KMvsu
   46G/V3MdjbPDip9JD09F/iJGPfcCNyKvAtJfpXKA+YaUx87GlhdSeB5lb
   DNwaKwDCQFj6BfGEzhnxFhYUrfMmI/Qke4V4B2jfF4IifvTDI38I2jY5L
   LksopR5czCsZ0Y9oPL7t7GUdiF3KmePhmwikLZYdutiy+cm2tPisZ27zS
   EzTznGzx+kuSMDIxRoWmYYIGUokEeIdqf6uao0v6s0dRYTFw84NYaw7D1
   w==;
X-CSE-ConnectionGUID: hSxzRvu6R/OT8NE7jXLSyg==
X-CSE-MsgGUID: nJBpGEn8Qz+3AYVQ8dC/rg==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="40324714"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="40324714"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 23:01:53 -0700
X-CSE-ConnectionGUID: 7WCGN17NRxq5OJwDnfRsbQ==
X-CSE-MsgGUID: gOmoFSnSRgaGJZLhQrlkKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="40380427"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 23:01:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 23:01:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 23:01:51 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 23:01:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHZuOAzQjBvfAxaCZz3pUqk1bqJrfwwe3nxgG4y/w6MjaSuJBOP4UYXqsNmiEbSHb4PuMa/lLKL54a94TrNfqOnx+ybESqDJqPTBvHtmkUvUiHrJCBOSGpSCVcJLusrmGTAHWYUbxMX6zrdA/XQi+oMo8jF6SahDjYumgeDYUIypAQBe0myi42flpeObohamC6WUGGOvdidGC5SFfr5WBMZsnk7FmtOXsZyoIrZL8zuWnRInDHldMulKw/2lmTEVuKDy15BHp4uB62+8x1riBzj3eI8023p9FuDqJ+oIWXkqEISc9XHRPgw0pNBP4i4kHoTaVhAhcGp1tk75EoaIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omtajww5hqPkiwD0qg+DbQzlVE6bdf4lGcUyAZ9Ga6s=;
 b=kTWHvucFGOzvOB/xxobo4eENlDHCgUl9SFDV+0JqJvbbRBUSbyf13kLrPEixBk0MAgEFCSuPI47txj98wOhX+5lk+n9nP1PsPXnduPE/QhX3iZWW3lhcb6QXUTdVAde2uHH84hhUzuFNkWTAI7FH27h8y1q3XELkk8ylJbK2TEXRsS03MNMUJEGymmcGaGvnKZ2f5CFotWAUvdPGWkt0QTXd9s4EaZsGyIzTVwvZaJ89nEnvE6ivyYbghX1t/fs1QcdDvjkllpZG3QhzI9Cx4BqMAYWUPvm81S6C5jnXiMlDdRXKSVUR90QBL2UpSKReifORfyftLoyBQDHdQoF9Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8094.namprd11.prod.outlook.com (2603:10b6:610:156::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 06:01:49 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 06:01:49 +0000
Date: Wed, 12 Jun 2024 14:01:40 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Yang Shi <shy828301@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Christopher Lameter
	<cl@linux.com>, David Hildenbrand <david@redhat.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, Peter Xu
	<peterx@redhat.com>, Rik van Riel <riel@surriel.com>, Vivek Kasireddy
	<vivek.kasireddy@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <lkp@intel.com>, <oe-lkp@lists.linux.dev>,
	<oliver.sang@intel.com>
Subject: Re: [linus:master] [mm] efa7df3e3b:
 kernel_BUG_at_include/linux/page_ref.h
Message-ID: <Zmk5xAF+vHYLwzoG@xsang-OptiPlex-9020>
References: <f4599bd2-72af-4e8d-a0fe-153b69816133@redhat.com>
 <CAHbLzkrOspjVuQw=BN2+RZmV_Ydpz_50yY7FEakJw8Zm14Y9-Q@mail.gmail.com>
 <a088b5cf-503e-4ed7-b427-f17a9ec5d1a8@redhat.com>
 <CAHbLzkpnDPYWq=HnaJcKhKnppdNikX4YG+1Ysu8Z+XJCoKK4SQ@mail.gmail.com>
 <CAHbLzkr5K=4Shiyb5KgPTQ20jE2Zo08wK=mT3Ez9ADEdJe0Z9A@mail.gmail.com>
 <Zl3M7iniPQaPFDrW@xsang-OptiPlex-9020>
 <CAHbLzkrOTAaYahG4JYMNrJDhQNZZxW9u+2n71J=v1XYJEVpUdw@mail.gmail.com>
 <CAHbLzkr16YZ80ES5U4BEWJ+ueL22nDJtgH=eOztdHfy080diPw@mail.gmail.com>
 <ZmEb2mdAbBQ/9PMP@xsang-OptiPlex-9020>
 <CAHbLzkqORuPjr3p7aZGPKSLfdptrg=z1624rcxjud_zs3+HnCA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHbLzkqORuPjr3p7aZGPKSLfdptrg=z1624rcxjud_zs3+HnCA@mail.gmail.com>
X-ClientProxiedBy: TYXPR01CA0047.jpnprd01.prod.outlook.com
 (2603:1096:403:a::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b72f2e3-f8a4-4f87-2861-08dc8aa525eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|7416006|366008|1800799016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHhrMTJlN0ZkL0pONjloWEJ6aFZWWlVHWjdLUWdZU3ZpWmFJNC9PK0ZzTE1L?=
 =?utf-8?B?MG1mcFc5U3dUeFB0aTdyc2JpR3pJZUlkNFFHTTlrVlBEUW8vZ0dKYWIrczBZ?=
 =?utf-8?B?YWpVSGRRV3YwRnlOendtSTBCQ0NHcndHbGFBdjFvVGIzRWtQVzUvT0JvcXgr?=
 =?utf-8?B?Wk1GWUQ2VldwMEQxVzJBMDR6bzlmR1NQejNwOTA5T29ORTdXUjlEUElTNFdr?=
 =?utf-8?B?Rk05QzhOTXpsSzlvZXNPdlB5VjR5QSs2RWhZejc2MzZQVTJDUVNXcDZMMG9C?=
 =?utf-8?B?TlNDdGtzTm82MFE2ZDlhSm1nU2h2OTBNVE1xS0tjSHBjdXhRcE5nNDc5ZDNC?=
 =?utf-8?B?QVptWnJJTnFCMGVxeVI5K3RpNUtQY1Rrdlg0VlIrcmkzUzlwSEkvTmVHT3I1?=
 =?utf-8?B?T2NLbWpEazlrT3FObFp0UUswNnNraS9IZEhqMlRrMjZOMEM5U0k3YWlYT3lC?=
 =?utf-8?B?eURjSHBReGlTdEY3WnpYVE9pc01tc3lRTGord3BuQ25PdTVITFBxUzJDMzFD?=
 =?utf-8?B?NStaenYrZXhqT05IS28wazlzUkVMRU5neUFYMTNUdzBzRzI4UnFpZUtkMmh5?=
 =?utf-8?B?djRZYUtaVXVmeHJ6OVFVRElZZExCekM4REVxRHVhVFJPaGZkbG1VaUx6UE0z?=
 =?utf-8?B?UCs3bElxYVpRWTNhVVNzdVJGeG1wZ2JrTFBJb3dpZDhUdVR2YXBqV2crVXVK?=
 =?utf-8?B?WnpqdDVVVmRQR2xsbHYwdSt4cXlKVktvZE9vTThZWFJjN2huOFhYbER5dHVB?=
 =?utf-8?B?Smw5czdMUmo4SXhHOHhaTE8zblVpWTRUYmZ6VnJnSitpMmhRTWo5b2UxVWJq?=
 =?utf-8?B?NytWcTRJQ1ZqWnFSRTRpYnVEQnNKSU9lK0s4SFlKazVWVVBoUGdSam5tbUdH?=
 =?utf-8?B?RXVWaHd6ZS9NRkx3ZEpjKzhMeXBuMHB1T2FyRWM5d1JiOFpFTHBPbjhJTUZS?=
 =?utf-8?B?OXkzamxTNnVCTXJsZE10TjdNTERzQU9nY1lPMmwxYjhwU0ptZGZHN3RnM3RU?=
 =?utf-8?B?WERDVVVKcncrTm4zT3I5Tk9OUUM5czhac3Q0d2JxNHBveExmV2dnL3FIMUgw?=
 =?utf-8?B?RVdQMGt2WFlFbkJHdG16dVFKNHN6eTRuOUtKQ3N1U2pqaVpWWGdWKzc1ZGhE?=
 =?utf-8?B?U09xY3ZGYmNnQWFrcGRDRDV5RkM0RnpFNFUvT04raktDTGxsVm5yRG5uclNv?=
 =?utf-8?B?bHBGWnRzb3luaUJWaW41ajliNzBmd09PQ21qRVBOeHhxZHhDQ2kyWjFQWFR1?=
 =?utf-8?B?Mk9hUmFJVHJIUmdHNHpuekgzSnA4NG5UVGlySStpa0haeTRuWUQzd0JieTF5?=
 =?utf-8?B?Q1RrNEJKWElwM1NjSGNKeFJEbWZuYk1ub2x6KzFTVUpYVnA1b2cwd2RKV0RR?=
 =?utf-8?B?MlFyUDZQMnhiS2dvOFN5TWlYa3cwamxBeWNLanlzYW04TXJJc3hHZHJyclp3?=
 =?utf-8?B?MXBBWXhKMW0wRmhoelFkWU1kWnBMWE1MRVBvN3c0YzZKZ1F4TkkyZFdxd1dP?=
 =?utf-8?B?M1FybjZja29SKzczdElLOUVIM2orTTArVFRncy8wV09RZXo1V0NkTlBmSnNZ?=
 =?utf-8?B?TFo3a3hBWU1Hd3N3UnNKaUJQd0tDVkF4VkhvQ3I2YmJYTlpudTI3VVFPaDQz?=
 =?utf-8?B?elVvZXF1a1pvc1BSVERQQ0R5S3drUDBLTFJIaStuY0llS3JGamNxRks5M0tY?=
 =?utf-8?B?MllyREdHblJUeGk5a05OZ1FUVmx2YnF3VHo3RUlJRlcwL0UwQVNiL1pzR3dB?=
 =?utf-8?Q?jyTbuaoWbPlq8PX578VIwkDVO7mBr9WFxEjlZw2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(7416006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHJFeHd6Z0VsV3hpUkwyOENFZVZIbWlKNzdRd0k4SFJFNTIwTmNMdzJmNkFs?=
 =?utf-8?B?aVA1VzJGRlpaVERLSHhoSWtFN3VTQit4RnhDY1BlTUZWOTV4Vzhnd0xSbkYr?=
 =?utf-8?B?aU1ZeFcxRVkxanlRR2gvQXBCU3dxbjVCeXdzeVNIc3BGazVydWpLaVBsMmRa?=
 =?utf-8?B?d04xYlJIajVzRTgvSFdvMlJBS0tVSHlHbmx3VFhFR0lON2FybzZZTzl3KzQ1?=
 =?utf-8?B?cHdrUG9FOXYwNGNUR1VNWjF6Zis1TnQyVW16d2Q0OWVDSHFxaWhpQTdQdFpO?=
 =?utf-8?B?M24ySDZiUURhWTBadG5CMWtWeW5OR2dENGQxMzFvcE5CY21wTVdFUzNqQ1dM?=
 =?utf-8?B?cE8ydjJQUGxOb2FqTkNZY3FZcTllK2V4RnZkZzlSdmhoVmRlWkExQm5HYlhz?=
 =?utf-8?B?WWE5N0Z3VXJVZ0JaNlhvYUZZWUpUc0FtQTNMWXdmUVRHRzFNNmhrM3BQZVQ1?=
 =?utf-8?B?VHpuTWYzYkRDWkFlQWhyblBETzJXV2ppTXlZWHQ1WnZ6WjhZS1E0U0U2Zmxp?=
 =?utf-8?B?Y1M1RXBBYUlUWHM4M3FHZDlRVkh0SDdlYWRpOFQ0Z0dzbEZQTktmQ0hTc2sx?=
 =?utf-8?B?diszMEZGVDJKbVRuVEh5bWFZb0NGczVraG5aZG51NWE2Tjd4T1duNzdpY3ZK?=
 =?utf-8?B?enV2aWIzZnk4WnhpOTVSQi9rbDZFQmFBVDI0cGpYRmorZU4zOWFFb3cwVXI4?=
 =?utf-8?B?cUxCRXJpbVhEdTNaWldlWjIwOXVBaHBYNnJLTUNSS1BYYUdaVmhLaHlwMWE2?=
 =?utf-8?B?U0FWT2xxcVREQVY5NUlCQ000ZEhzak9uaGZpRXAzRHBnVVZVZ3ErOEd4WTBl?=
 =?utf-8?B?dVdhQXRYQ2xoS21acERmU0JPZlZqVEozMFJsOGRpV0srOCtyTUNUNHNSWnhD?=
 =?utf-8?B?emhqKzQ4ZDV0eHZUWHdxOGxZWjlBanZFRW5wUFoxUWYxQzRhaUFUcWY1VDFz?=
 =?utf-8?B?cUJ2a2NGTjhHQndYbklyTnExMTZYTVFNWXBxMGgwdk8vdE1ULzdab3JpWU1M?=
 =?utf-8?B?amFVc0NsM3hMc0tVZ1JrdEMwT2Fucit1ejBISHNLRUVqcGNseGVyS0dpWW56?=
 =?utf-8?B?SEZSU2MxMmpod2s5UkhRUFd0N2VSYW9td0tFQllEb2hwcXdMUGpmT09VbVV3?=
 =?utf-8?B?aW90c0kzMlh1MTJ4UENyTFBlVHdDTnRCZmJCV2tRVFVVakoybFFidGozOWxz?=
 =?utf-8?B?MnRCNmpLVXVyTDU2KzUyZnRGSkxwRDJtRWx3WDdsTzlhUXExN2VQQWNzdDFJ?=
 =?utf-8?B?WE9zVUg0VTdKWjJGSGpnaUw3TGJaaDdLY0IzK1dBMjBUS3NoNEI3ZlpNVlQ2?=
 =?utf-8?B?TTVVRjZKOU1zd3ozd3c3SHpUUjVYY2Niamc3VWlaSStIUkV2c2dYK0dvczVh?=
 =?utf-8?B?ak1aZTI5TFdHVHc0Rlp1WkxSMTVRMTJMWHFGUFNUTitEWjBUVGZibzJHY0RP?=
 =?utf-8?B?QlVVVlJjV3BkZkdML01aaEM3NG9TVnQ3RHVLNzYwZnJXU3J3OS96ai9Pb1RU?=
 =?utf-8?B?NHVMeDJ4bkN6UTN0dlFuaWJncUttSDZwdFBmLzI4ZXhWM2dWZmJIZHhSSVJP?=
 =?utf-8?B?S1pReXdLeDdkM0UvQkdhQzBrKzdpbjNaNmZNWU4yb1hFUkh3ZEIwMUx0Wmdp?=
 =?utf-8?B?WFhDbndiOXM5aUsrZzRsOUdTZlJLdDVOTzF3T1VXQjZmdjV2a2R4U21kVjRh?=
 =?utf-8?B?NDZjSytoT2dsZnFkVHJxbTc0QnAzbi9yV1BxcnVIWDJsaGpPVWIrZDh1ZXBH?=
 =?utf-8?B?bEZQc1orMG9hbzhRQmlhSFhIc010U3BDTXhTOTN4SXVVMytEdWFmVUN4VVJE?=
 =?utf-8?B?MU01eVpsellsSTFMdG8yTDhFeUhRa2JxUWpjcSt5VG9RNlI1Z0VjM0dIQnpo?=
 =?utf-8?B?NlJ1MXF5SUMzdzRMRGFOYzVielZJWjF6VXhxQ1o5ajE3ZkJOblJKTUREKy9P?=
 =?utf-8?B?L3dEZ29XSTZkcmthQnhDT0hyRFRWY2EyODVieGRrVnlxNUNHSHZVNVlmVVND?=
 =?utf-8?B?cXFPQlJldCttaWdLY21GaXpraEN0d09RRzVVTDRIQlgzOEIyejBwU09lb1Ar?=
 =?utf-8?B?b1pjczBlZHg1VEdTRE5mbGo2WEdLSWxtRFRsUFgzMnJCSHZaUUkxdVNJQXR6?=
 =?utf-8?B?VG5xU2FEQzQzUVhtd1JyYk9rWVJuektiSzBNcEtRQlFTZHkzUWZkREM4U2ht?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b72f2e3-f8a4-4f87-2861-08dc8aa525eb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 06:01:49.1984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZ0+sMAJFuncbHHjaH9XvE5Sif7FqGro77wCPohHkda1qTwncOiCa+rVC3NRAP7SSJ6N3DBLci02vEzuhWqetg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8094
X-OriginatorOrg: intel.com

hi, Yang Shi,

On Wed, Jun 05, 2024 at 08:44:37PM -0700, Yang Shi wrote:
> Oliver Sang <oliver.sang@intel.com>于2024年6月5日 周三19:16写道：
> 
> > hi, Yang Shi,
> >
> > On Tue, Jun 04, 2024 at 04:53:56PM -0700, Yang Shi wrote:
> > > On Mon, Jun 3, 2024 at 9:54 AM Yang Shi <shy828301@gmail.com> wrote:
> > > >
> > > > On Mon, Jun 3, 2024 at 7:02 AM Oliver Sang <oliver.sang@intel.com>
> > wrote:
> > > > >
> > > > > hi, Yang Shi,
> > > > >
> > > > > On Fri, May 31, 2024 at 01:57:06PM -0700, Yang Shi wrote:
> > > > > > Hi Oliver,
> > > > > >
> > > > > > I just came up with a quick patch (just build test) per the
> > discussion
> > > > > > and attached, can you please to give it a try? Once it is
> > verified, I
> > > > > > will refine the patch and submit for review.
> > > > >
> > > > > what's the base of this patch? I tried to apply it upon efa7df3e3b or
> > > > > v6.10-rc2. both failed.
> > > >
> > > > Its base is mm-unstable. The head commit is 8e06d6b9274d ("mm: add
> > > > swappiness= arg to memory.reclaim"). Sorry for the confusion, I should
> > > > have mentioned this.
> > >
> > > I just figured out a bug in the patch. Anyway, we are going to take a
> > > different approach to fix the issue per the discussion. I already sent
> > > the series to the mailing list. Please refer to
> > >
> > https://lore.kernel.org/linux-mm/20240604234858.948986-1-yang@os.amperecomputing.com/
> >
> > got it. seems you will submit v2? should we wait v2 to do the tests?
> 
> 
> The real fix is patch #1, that doesn’t need v2. So you just need to test
> that.

we've finished tests and confirmed patch #1 fixed the issue.
we also tested upon patch #2, still clean.

our bot applied your patch upon 306dde9ce5c951 as below

5d45cc9b1beb57 mm: gup: do not call try_grab_folio() in slow path
fd3fc964468925 mm: page_ref: remove folio_try_get_rcu()
306dde9ce5c951 foo

on 306dde9ce5c951, we still observed the issue we reported. clean on both patch
#1 and #2

306dde9ce5c9516d fd3fc96446892528af48d6271a3 5d45cc9b1beb57386992c005669
---------------- --------------------------- ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |
         47:50         -94%            :50         -94%            :50    dmesg.Kernel_panic-not_syncing:Fatal_exception
         47:50         -94%            :50         -94%            :50    dmesg.Oops:invalid_opcode:#[##]KASAN
         47:50         -94%            :50         -94%            :50    dmesg.RIP:try_get_folio
         47:50         -94%            :50         -94%            :50    dmesg.kernel_BUG_at_include/linux/page_ref.h


> 
> For patch #2, I haven’t received any comment yet and I’m going to travel so
> I’m not going to submit v2 soon .
> 
> And I heard if hugepd is going to be gone soon, so I may wait for that then
> rebase on top of it. Anyway it is just a clean up.
> 
> 
> 
> >
> > sorry that due to resource constraint, we cannot respond test request very
> > quickly now.
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > Thanks,
> > > > > > Yang
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Cheers,
> > > > > > > >
> > > > > > > > David / dhildenb
> > > > > > > >
> > > > >
> > > > >
> > >
> >


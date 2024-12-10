Return-Path: <linux-kernel+bounces-439032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E759EA9C0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827CC188643E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D0822ACEE;
	Tue, 10 Dec 2024 07:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYt6fIe+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6EE172BD5
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733816396; cv=fail; b=JH8UTsA0FKLvFJiNZs/4DvAvUPCvVzKQGay2LoeocMHgMhmbFH5BcBRn+XTVyc66YtB5/RvdmOk36blh6OWnwKZ9Q8uxit9Gs7SeUTeFEuM7T7uL3aFpj0SBfcE+kvPi2HPgpjg7F4qlgziFD7b3J1RcHCABye7Q2Eb/vigEazI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733816396; c=relaxed/simple;
	bh=IKokAhD2X5z15/3PpQACkSa9C8SCLnJPWpDBEpbpeVA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TZLmz6OG+4kLOXzfP3wnNG1DyQJduFtaU3MV4VfF1QwyFeU9y3k3hGS3MlfHQMAx/KPGPR3pXvB0A85CCB59SRSBkRfqoJJfu3dchQ4qMKLykPXZaOR19o9rW2jh6ye7eywo467Q3SNSEfw7Rm+mzsBjx5J2L9Gje695/p98DqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYt6fIe+; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733816395; x=1765352395;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=IKokAhD2X5z15/3PpQACkSa9C8SCLnJPWpDBEpbpeVA=;
  b=DYt6fIe+ciVK3eiyVXt5yBRJ3/LdF53R5g51iwDJam82pm921b+sEmA5
   LPeqUacYFa+9ekVfLuS+Y6EyhTerq2z+FsB7SCAqUaL6mdxf0z3u4YYzQ
   VSFYukNwlazHq4fQDGcNebY1ocKTNPuuV7fafyV98sNil/FubcNgVu2PW
   FVe/lyJOqvPFxea2lTi61Q00n3oKlK0xE2LmrMWxLi3XkTP/ujlBLE13C
   05KCfVNna/ztx0zGpIPIzr6RJDHMo2kQmm+kuvZJYbx+4t5DHRI958SC/
   eR4M2ZcRwSbIpoRpzQDEsxqVoXSiRN7T46zW92JXkkcx7cdyc1UuYfz6f
   Q==;
X-CSE-ConnectionGUID: qHO3q9LwQAmaLo2YFHEuNw==
X-CSE-MsgGUID: ZogF2+z+Q4WB7EJJ5m72Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34284076"
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="34284076"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 23:39:54 -0800
X-CSE-ConnectionGUID: 2QSpP9BuTcCRsUyyxMQ3xw==
X-CSE-MsgGUID: xMkO7DlSSNigpmZvA7eK6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="95030756"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Dec 2024 23:39:54 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Dec 2024 23:39:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 23:39:53 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 23:39:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3OHNZ7GDBhsiDsOQX6Plk8qbKhJN5vC7WnF+WJxrY7y1TAM+fzl+52e+aqkXC6h8WsTTfGdcJ2y8lGo4VFz6vy5071MtXIFRgDiN+6PL8teXW3ym575FJ4k79fuGt2vPUS33lZomWPBhBpfddHTsgbTD1GsVpTHQCmXBOeX8Hov0YXDbyFtZB18qJbJ9OsnKEZ92qY7QmuaQsEct6BaPOTrT/Lq/fi6vqeAmBI6uoy5uSIraRtf9ylgdB3XddA325+ed8aNhwirt4JRO7iPhiSEAm0t9UduOQqESSb3Rg+kobQh6zKZCnpnwKxHbzHbN4mNQpenJWpSkb9uget0SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/Yeuc4QgLO/QHDRbdIXh+uigmZzG2oiwSVe65ioqIY=;
 b=Clk8u5iWIsKvLU9Z4yc0YSHch13j/N7a/4lERUwWzwry/EFY7nw6V0okXtjXdZAo+dQtgWw48irV77ekI393gThrlegGSQyRst8lxfB+P7JbNhhFfytp3HrOsiV8/u/TznpYO0nqG92NDoCq7RO7cY+9WE/Y1jK7/NPkTS6xTMZA5mEgw9IZxfWnZjqtaWd3SdPJlJkh078/5pbgz3K4XMeQ/xYpzoJ+qAmLXTD0Rbkn2bZ74rMhwzzFnm7ZE11hkkBPte/DrTqC/SO2wCZZ7LoK53d6KIt7WXLE9gF5OqDAkMIUihMZhf/qos49D7kIutJIpP3BY/1AMxYXUl1WUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB8028.namprd11.prod.outlook.com (2603:10b6:806:2df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 07:39:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 07:39:45 +0000
Date: Tue, 10 Dec 2024 15:39:29 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Suren Baghdasaryan <surenb@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, "David
 Hildenbrand" <david@redhat.com>, David Howells <dhowells@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Hillf Danton <hdanton@sina.com>, "Hugh
 Dickins" <hughd@google.com>, Jann Horn <jannh@google.com>, Johannes Weiner
	<hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mateusz Guzik <mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>, "Mel
 Gorman" <mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>,
	"Minchan Kim" <minchan@google.com>, Oleg Nesterov <oleg@redhat.com>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, "Peter Xu" <peterx@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, Sourav Panda
	<souravpanda@google.com>, "Vlastimil Babka" <vbabka@suse.cz>, Wei Yang
	<richard.weiyang@gmail.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [akpm-mm:mm-unstable] [mm] 85ad413389:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <Z1fwMatrJCZdoEDu@xsang-OptiPlex-9020>
References: <202412082208.db1fb2c9-lkp@intel.com>
 <CAJuCfpGeKgOgqq69OD-TMoQLhyy+HuTKK=cQPHMY2DgNcJf5Xg@mail.gmail.com>
 <Z1Z5FbBHojF6ywfA@xsang-OptiPlex-9020>
 <CAJuCfpGqauvtrVVqrf8ge7ba=AB3Jk7daRDdqYzOSxpB462i0w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGqauvtrVVqrf8ge7ba=AB3Jk7daRDdqYzOSxpB462i0w@mail.gmail.com>
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: a922d3ef-ea6d-4416-2c92-08dd18edd15a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXMvRzhFUjUwSlZ4dFh2dFl1Ty9hU2puaVpZMHQ4SXBGbHJSdmQ5ME5Ub0Fl?=
 =?utf-8?B?S1lENDhNZDYrUy9WQURsTEJrRWhncEpkYnNkMVQ4S0ZBcVg3czJQVCtzTzc3?=
 =?utf-8?B?N1NYMTAzc0grZ1NVdCtPKzJta0N3WU83azRUeDZ2WXplSlc3WWZWcEQwWVFu?=
 =?utf-8?B?ajlGdDVocUQwdTVEbDl1Zmx2TTdERGZsM3JoMnJXaktsTDRTWmFTak1NMFY2?=
 =?utf-8?B?OENneTZWelRleC96NFVLSVFlc3dDeDVQN3pBMXZ6Z1hLMng2UDdINTZnZFlQ?=
 =?utf-8?B?NkFTeEl0OXFhd0ZhNjBFc25FRHVXYXZBWnc1MWdqMFIzK2ZiUVd6R0NUL2ky?=
 =?utf-8?B?bmMwd0t6Tk05RnRxdER1WC9zSnN2YjcrclRISGl4R2lMMnV6ZzJNcHRtS3FE?=
 =?utf-8?B?T3FPUnlmc05OR1FCbC9IZEpHeE9tQjBEeFJISVhEbkJObDYwNS9nT1VDcUNV?=
 =?utf-8?B?YkZVU0ZQUHFuNnZBTHI2aFplN1VLc2hUVFJxTUFqQ1AvNnRURDFoVG9IMURE?=
 =?utf-8?B?UDhaVXllSnZ4SkRRR3lDeW9TSGRoTTI1NkE1UjNITmRKemkvUXc2NzBCK3o1?=
 =?utf-8?B?cDZNSERZR2ZGYlplcEJsSnVBTFpUWWN5V21MU0tMTnN5SERuOVlIQVgvcXZi?=
 =?utf-8?B?a243V2k0Sk05OFNiZ204dzZ0aGVoWHp6c0hJNnVKUnpmWnpBMzRNMHIwTEhk?=
 =?utf-8?B?NWFKVSt1blNqTlowbngyTHAxSGZsY09wbDZhWUNVNzRuZjIzT0w4bWtSTHdr?=
 =?utf-8?B?UFQrU2hYTE9YZDZja2dPVzVuTFZYODhyV1dqV3I5TXZkWGt6aFRYdU93N0l3?=
 =?utf-8?B?cWpZMXdoQVpCbEpjS2VnellGQWlURFJBNUoxZExkRTl4RlFvSTd4NHlUbWNy?=
 =?utf-8?B?MWthSmhKWHFOUnIxTmk2WHJWNFp3K3NzUVpZeFF4MENFcmdpeWcyVmVrbmhv?=
 =?utf-8?B?YmVkQnlRNEJUdzFORFlFQlRDYm5UVWxXL28wY2VVbUJKaXNJOHk1MkR5dzFh?=
 =?utf-8?B?TkFMUDNOeWRGZFc5aHBXUWUvb2crRDBud3JpQW1QU2VHSzF5SXVHQ3NxREVQ?=
 =?utf-8?B?Y2dhNG9xYzJYRVJvUmlDQW9PSHRUcUdiQTI4NzVKYkl4b1lGZlBMS2ZndGNl?=
 =?utf-8?B?dWNCdnJ1SFFFQTRBTWl6LzNwMXBRWUtUcVVKS09TZWhsYkRJREhzaHBkZ2Zw?=
 =?utf-8?B?bmtBQlVsRk1LUTR0eGtCenRuMi90eG9QZ1ZoblBFbE1oZHlkaTNFZ0J5UklW?=
 =?utf-8?B?cU16aXRPQy9STHFKQ1JoM2lhQUltbmhtTEpDWEdPblNHbzIyZDVCeVp0M284?=
 =?utf-8?B?bjMraHBtMENMMHRnWk95cURnOXlIN1BzRXlkRFFSQkNBUlVaTFBlL1VEQVZn?=
 =?utf-8?B?aE9XcEwrR0VlZ085ajQ3alBLZXBWdkxRbExEaVRJVzJGWWZLSlo4Y3FZakVQ?=
 =?utf-8?B?aFhHbVlVRWdrMEw4TTE4a1NDY0N1aFNMaWZtVDU3REtIcFE0M01Xc0RqdUFY?=
 =?utf-8?B?VE9peXpSaUdFZjNkSUIvdWdOTTJOK1dMYVlJSWdvc0tXbzdjRkJiZHJseFZ3?=
 =?utf-8?B?MUtzbVVKbm9veWR4VTJxeXFSYlNFa0F0RDVCVlJGMEI3YjkyYUxoRlpiTS9O?=
 =?utf-8?B?cXFZSnVIRTVrT1NQTWJOOWdkUk90ZU1XeC9OUGhJa01CMEVRaUJMbEtEaG9m?=
 =?utf-8?B?TWlvM216VWVtUmxhNHlReE9WQUxxaWRZWWZjL0pXd1FxOHJzN0I3V1kwZXlM?=
 =?utf-8?B?RXlFNU5XcWpPZ1M1dExDdGpVbkl4S1g2RWJoZHgza2hpMUlVU1pzZ2YvTVY4?=
 =?utf-8?Q?6GrMSM0m1XKqrR+/b4DgKkM/z50xnQRZ1ACHU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2xsaUo1Rkc5MmJ3d3Y2Sml0RWE3amNGL3pWbnJsUExUNWRvMmtEM09NTTF4?=
 =?utf-8?B?cVd5bXByODh2dWszT2NxU0d6aWRiekhmZjRIQTJudDBnb291M1VmdkJ4SU9S?=
 =?utf-8?B?MzFIeGZKYUFCK2w0TGFlcmFmUVgwSHFEcE9qRGM2NDZsY3ZkcktPbktEdGds?=
 =?utf-8?B?RW1CU2tNaXl2Rjhnei9QeXBVdjBoa0FRc0pRNVhRSm9CQzVXTjBEZXZiSEpq?=
 =?utf-8?B?VlJXNGI0QnRkd1Z5dGlna25OVlNuMnZ4b2lLY0xXZ3hPNnJuN2NzTklzanJG?=
 =?utf-8?B?eHR2MDBZcWc5bjRqU29peW9QUzQ5dEMzNmN3VXZTZ1lDblEvaXJDWGRLOWJj?=
 =?utf-8?B?Z0lnWnVNUVR6VlRaYmpzViswczNaNE9XTTZKSUJrSVRpWm1tUkZLK0NrZ1ZD?=
 =?utf-8?B?WTVmTjNwaU1hUkQyVlJqZ0x3dlRHOVk1MzBEZlZ0NUlaZ0pSSHlBSWlQUjFh?=
 =?utf-8?B?MVF5YXhUTFBUb3pHS3BWdkRWditxZyt2aGVLMlg2UExtMmVSeTBJNGdEbmJr?=
 =?utf-8?B?V2dUL1pQS2lleXR2RUNUeFQ2V3hLMmFkZmRWd3ZHSHhZRWVUZXlJS3hma3dq?=
 =?utf-8?B?WlM4U3Y4dFNuWXdpVlJZYlh0VmJTL1kvYXdNWWQ4TGR0ZVhJU3dQRmN2WnRR?=
 =?utf-8?B?OUd1Y0NpdjBoRXFtZUY2TXk2eVRBVC9PdHpkdG14ampyeUE4L0txeEtqTm15?=
 =?utf-8?B?bEM0L0E2dHRFdVJPSUtUT3oyaHhtSEJRNjRINzZiRVBwTGU5dStVTFlWQmtI?=
 =?utf-8?B?QzZLeXpxU2ZXZllGQnAyZHIyTXRvalkxUkZLL2x0amMwemdaZGd1L2F4aGRF?=
 =?utf-8?B?K3FER0tnbGJqaUk4Z2ZNSEFKMFY5TWIrVFpOY0Z2ZlZHOW1GNXQydlAvamNI?=
 =?utf-8?B?a09KcldjZHliV1BIeVZZcWJCQ2lRNU94Y2dYMzlsTW8xay9hdEtURENWRWJM?=
 =?utf-8?B?MU53bW9qZ0wwOUxQYWhGNS8wQytPbXU2YkVzYkQ4bWE0amxnTDhZSkFBbXNn?=
 =?utf-8?B?anQ2ZlZMZGF5SGY3dWJHbW9FK1ZaOFJ2S2pkcTNxTytKTHNEblRZL1oyRGh0?=
 =?utf-8?B?U0wwL291UFNNQ0p5dlMxU1NWbGxRcVI4UGRuVGpFZkJ3ejhYM2prdUNzQUJ5?=
 =?utf-8?B?SDYxSDdDalNJMVM3b1BJdGswZ1hMY1NXaCttU1Z2QkJnc3RqL0lZNjZJbmVs?=
 =?utf-8?B?RWdTaS9ZMVE0SFdJVjJabnY2ODI2cmtEMjFkaEZIN0FIUkl4c0pkdjkxM3E5?=
 =?utf-8?B?S3RMck14TksxSklYTytKNlZnK3J5Qk9xVTZ5MkR2ZWtmaEVPVTRXVFp5MW45?=
 =?utf-8?B?ZWhPZFlQNG8vWE4xZFcyMFRmdndCRDhveExVVG9jczdhU2pGWHNYZUFodGdX?=
 =?utf-8?B?ak5ibWV5UW5IZFVPdXFJM090cmtBc0FqR3c4dWhNRlZIdG1VeFhXOVRXdk9n?=
 =?utf-8?B?N0diUW1kM0xHSXorWG5XVlcxREN6eWdweEpGTHc5YnZQWHZYT3c0WlEwS2My?=
 =?utf-8?B?enNmdFVKbExxUWRzWEh5Mm9SZCtKUnlxUGVNckpBZlNFRS9GZWFKQnVUMVF3?=
 =?utf-8?B?Qkd1dStiYS8wWVR0ZFFLUjRocE56d2lkZkxLTjM2MTQyRGZ3N1N1MTdjRUEz?=
 =?utf-8?B?SlA1KzFCeWZyRWJ6NSsrOGNxMW1Vb1NKeXByL2RGMklBVjJJOUNCeFFuOGlJ?=
 =?utf-8?B?ZFZxSk85VTJiWU15SFhDVmJhRmJ4RmUyTEc1MHpCTVY4elEzOW01L2tRZHlr?=
 =?utf-8?B?Z3hva1Fab1hDeGV5MU9YVFpFM0RKcVBFMFd5ZkhEb1NGb3FoNmtSSVl5emts?=
 =?utf-8?B?amd1MU04dDNrc1NCakQ2RldUZGg2cWk2VDRuQzN6SzNjVzJCQ3pDd3MxTDBP?=
 =?utf-8?B?ci9HcWRTWnBLbGJwRFI2anZ3YTBEalhLKzFQQjVXUVVhOGM5WWovME9yVFRU?=
 =?utf-8?B?WDh3SWpuRUFualNyRy9Kbm0zek81M2phNm5OVktCU1d0enFObVB6MTU2MUY0?=
 =?utf-8?B?TnQ2KzVnbW1vZXU3NG5kdVgvMjh4Ty9MMkk3c0tvTGFKTWxXbUpBSVY4Y05a?=
 =?utf-8?B?emJsNjBvL1dMQmZnNU5GM3NSdG1xZU1WR2dFaEFOMmIycVF2MkxHYkdTNElO?=
 =?utf-8?B?UkpocWFweUF3K0w3bXdKNWdpb3FaTWI0bUxxMkVIVlJYeE5JeDZsVXY3M0tq?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a922d3ef-ea6d-4416-2c92-08dd18edd15a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 07:39:45.6454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGKcZOsc2/FBH9ZoFHlnexO2a36nGBnhBCE1FgcUa9UocdUXWcCF/XHP92Gyf6ocHq21xpTjG3rb7C38gKjCRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8028
X-OriginatorOrg: intel.com

hi, Suren,

On Mon, Dec 09, 2024 at 02:20:07PM -0800, Suren Baghdasaryan wrote:
> On Sun, Dec 8, 2024 at 8:59 PM Oliver Sang <oliver.sang@intel.com> wrote:
> >
> > hi, Suren Baghdasaryan,
> >
> > On Sun, Dec 08, 2024 at 06:09:05PM -0800, Suren Baghdasaryan wrote:
> > > On Sun, Dec 8, 2024 at 7:26 AM kernel test robot <oliver.sang@intel.com> wrote:
> > > >
> > > >
> > > >
> > > > Hello,
> > > >
> > > > kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
> > > >
> > > > commit: 85ad413389aec04cfaaba043caa8128b76c6e491 ("mm: make vma cache SLAB_TYPESAFE_BY_RCU")
> > > > https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-unstable
> > > >
> > > > in testcase: boot
> > > >
> > > > config: i386-randconfig-141-20241208
> > > > compiler: gcc-11
> > > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > > >
> > > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > >
> > > >
> > > > +------------------------------------------------+------------+------------+
> > > > |                                                | 98d5eefb97 | 85ad413389 |
> > > > +------------------------------------------------+------------+------------+
> > > > | BUG:kernel_NULL_pointer_dereference,address    | 0          | 12         |
> > > > | Oops                                           | 0          | 12         |
> > > > | EIP:lock_anon_vma_root                         | 0          | 12         |
> > > > | Kernel_panic-not_syncing:Fatal_exception       | 0          | 12         |
> > > > +------------------------------------------------+------------+------------+
> > > >
> > > >
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > | Closes: https://lore.kernel.org/oe-lkp/202412082208.db1fb2c9-lkp@intel.com
> > >
> > > Thanks for the report!
> > > It looks like anon_vma passed to lock_anon_vma_root() is NULL but it's
> > > not obvious to me why my patch would cause that.
> > >
> > > Oliver, how can I reproduce this locally?
> > >
> >
> > To reproduce:
> >
> >         # build kernel
> >         cd linux
> >         cp config-6.13.0-rc1-00162-g85ad413389ae .config
> >         make -j$(nproc) HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
> >         make -j$(nproc) HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> >         cd <mod-install-dir>
> >         find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> >
> >
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
> >
> >         # if come across any failure that blocks the test,
> >         # please remove ~/.lkp and /lkp dir to run from a clean state.
> >
> >
> > config and job-script files are attached in original report.
> >
> > one thing we want to mention is this seems only reproducible with i386 config in
> > our tests.
> 
> Thanks Oliver!
> I think I found the issue and
> https://lore.kernel.org/all/20241209221028.1644210-1-surenb@google.com/
> should fix it. Could you please try it out?

we confirmed the patch fixed the issue we reported. thanks!

Tested-by: kernel test robot <oliver.sang@intel.com>


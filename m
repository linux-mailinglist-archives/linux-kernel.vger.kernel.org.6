Return-Path: <linux-kernel+bounces-202967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACA18FD3C6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 814A9B268A8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228F713AD03;
	Wed,  5 Jun 2024 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B2xy7z30"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE25713A3FE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717607963; cv=fail; b=EEwEb1XfoSS/WK4fdVUN1dnT/MGTs9GqLIRE8KoE8d3xjaNCTFB7MyZQmoel5zxRL2WYTff49GzzZS2DlVj2QLuTwtsTFbxfa/6riDJJiTZ+kPgXTJiPiJlu2tgN8X3gwgg+R5u+BOjFGY+DaVXfyCHoRlzvQI5QgeX907yAWBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717607963; c=relaxed/simple;
	bh=rijYiF+iOn93Rz+U/LXclqQB1hM+xoQrLseNUjM4QJs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BSmqbviZ/U0W2k75TOQnQDz/5rkREzliysbBzISkrKJfJuhKUjff3V3TnkbfcML5vfD0T9/D/vjVEqWQSW1jDn+DXoagivJcKEhIBp4D2M+8cBB8Te503RQ4FSrJyQIqieJJn7kmaqSDz8x+Hb768Gq02TYpzz8HgYjd1kZTD/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B2xy7z30; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717607962; x=1749143962;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rijYiF+iOn93Rz+U/LXclqQB1hM+xoQrLseNUjM4QJs=;
  b=B2xy7z30R29KJLrQoDdLvekDbJO2OHclyn46y7mu3UXysBZYsPh9zD2R
   uUyY7lfc1Pdk8Vm/OwItGPgznBHe4rNOMxUGjA2k68AzWy1RQRDO/VwVj
   maINEP6DU4gg+0Q8jfwB7rUBcyIP7ixKLjK0+akrbN94xVMlmiaBZJLIS
   8+SK1708Z95f8zmn+0bL5yRlfgpsKwoZyka9p3KqOiSHSqdxzxg2672Wu
   7SR1QbuoM0KbPPlzsRCg9EMGJnAVz+lcnezl5RxuVUmFPMXUOQ4hOtFpd
   X1y7Cg5QCHAUzJkwRL1JXca0A3xhUinJhYyd98h9/aYYL4XGgydHVvILz
   w==;
X-CSE-ConnectionGUID: /QKDHjERQPqgmNt5j3Fzpg==
X-CSE-MsgGUID: 5llmcebXREmF44mW69kFGg==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14453676"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="14453676"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 10:19:21 -0700
X-CSE-ConnectionGUID: cWVSfBeKQgiGTQ5Rd+eS1w==
X-CSE-MsgGUID: fab71LJ9R/aKD2Bf2lqR7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="60850435"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 10:19:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 10:19:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 10:19:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 10:19:19 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 10:19:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLmpx5aEmfkpzAMVuShE+mpGhdiWzARnB6UAle2samtLZ4L166bvZE48VF1E8iTFMPifYxsjMpQ5rG6Yd4T289LMIh27rmFaGnY3OXrwGbqZ3kUQQW9Fk+WsXbiNRuWxwv5CFHHr+B87k3iKU5IBdLqbVySxF2xJKUaOJeb996ghg/wH3aRoJ6HVdcvKSWRDsQmfO1TfMxAHcjvz+uDB9bX7OLeWBnWnkGDVwdkaiNwSslDUy594nIA609RmoZsqs6CivTOKuzfs1WaqhoWEvt0EU8dWhdnMJyAGWTa/4sS+Alog7fnCCrRdMfH0K4SZl3oxagTFWJVMkdiqC6Rqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzYr1bN05CHBoLIy/GSdDTQHJ5X8whPBDGFEiTJKnrY=;
 b=EZdZDt+hRUPC9MP29V41JEwu2HyWYmQ/6eqVlKbhDy+XU/0sBojab/R1EG87p8GnZadsGc6cfnWyYvevsmVPCbfUfEFSXYIvbrmaAkCq5doH+kJf73qpB4QRmtUVgJMSW7iL/xek56TgmUbFwyXYrYwKeDq8ATZw8l1Eya+pAbpt/1l4NeytgB7Vn4YfYH62qlfPnwCbmrUHnGJjkkV3KLABfs3kzlxF8VRqKiStDd1Qyb0/fw+HiCIRgTyDlQULB8rrVenlgH2MXkiNqxmvmGR6K66YXtKKT/2+SFnVyqNKOdXEQvYyBXjTau6t6Jn483AMrAjnCcnzv1R05S00eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 BY1PR11MB8053.namprd11.prod.outlook.com (2603:10b6:a03:525::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Wed, 5 Jun
 2024 17:19:18 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 17:19:17 +0000
Date: Thu, 6 Jun 2024 01:19:03 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Chunxin Zang
	<spring.cxz@gmail.com>
CC: Chunxin Zang <spring.cxz@gmail.com>, <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<yangchen11@lixiang.com>, <zhouchunhua@lixiang.com>,
	<zangchunxin@lixiang.com>, Balakumaran Kannan <kumaran.4353@gmail.com>, "Mike
 Galbraith" <efault@gmx.de>
Subject: Re: [PATCH] sched/fair: Reschedule the cfs_rq when current is
 ineligible
Message-ID: <ZmCeBwNO2t2ikrcm@chenyu5-mobl2>
References: <20240524134011.270861-1-spring.cxz@gmail.com>
 <ZlCyhDspcZQhxlNk@chenyu5-mobl2>
 <06649B84-DA1D-4360-B0C4-79C81A34BC08@gmail.com>
 <cf8fdb86-194b-34c4-f5e8-dd7ddc56d8d9@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cf8fdb86-194b-34c4-f5e8-dd7ddc56d8d9@amd.com>
X-ClientProxiedBy: SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|BY1PR11MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: 7337e064-5e3a-4d67-1ff9-08dc8583a18a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?etneLSXDiHNb8NWptYqIdg2ug/zgaA5d0l3RDFAE9FbqRPb3Y+HP4W35Poba?=
 =?us-ascii?Q?zm4axZoodWDDwAoR7sTxTYjtSdPXaDLb2cPkGk6kIADtaOlxhagFuoY5QWHl?=
 =?us-ascii?Q?RrrTLMyQRPpl6ccWzMtUnL62BZ9OFYYIwliLgHCsyRREGiv+jUhOr3MufznT?=
 =?us-ascii?Q?na6FJG88cj1c9ROKMIEaYRZF4jRAPRkQtnfDPChs7Db3S+HIAUUcrp8k1puo?=
 =?us-ascii?Q?nu0wtO0NHj3UOE2e9phnQLcaIniYoajim72qUAqnIN+NvL9i2AKVAdlwkhk1?=
 =?us-ascii?Q?SxWwl1OfWmpppVwl6r0TZcoIsl5wWzq6MYSnRfUo/mg0EqrvrwBE6uw1Qs5a?=
 =?us-ascii?Q?D7QQE2NOoA70a5Ru3pLx28QRueTkfm0pXTtf9o3E/5JkN0GGydSixs51xhiW?=
 =?us-ascii?Q?lW8HbWfrWQdIN00KwjaX6AUaY78AeqXrkEVO1d0rD1/NpvM16Jl2TiBMVzxb?=
 =?us-ascii?Q?TmTt8HLo+aTCoR6h5+1HHo2cAFjdRxQKutJOVmLes6D59NU35+9Fs9km/zqI?=
 =?us-ascii?Q?DnjwZYuyi+39uQ3suw6CX8ujwLvzY+0smO0I4buFR4VR1G8CJ+D5oNj4hlJl?=
 =?us-ascii?Q?40+sGtMXoZOY/YXbPyO11BXfnjAXXS0VMC1wDgbSoc3pubAPzWU6oCWtNfXl?=
 =?us-ascii?Q?pQ2D+Wogm0xdtnBV0kSh1pHiYMDlSpnCse4pKtUBb+N8/wrCQ68UQ9NMrTUs?=
 =?us-ascii?Q?IWn/+AP70hS8wwYTFYfryZC8CcjA8J4WGTn7OfauBEhhr05jsQ6nxRzFhwNf?=
 =?us-ascii?Q?hViVQZdI9a1+KDOxcWi5uqQ00a4MZzE/5WzuWNFp3IEpZ2c+vtVb3ueES+Sn?=
 =?us-ascii?Q?I3vvuRpRATO/UIxi/c7aEC7lgkZB0Fcstn3vFaQmwGf5XxbdoXzFDc9tbggn?=
 =?us-ascii?Q?NFOybQEElgDgljUcov3jBZaESQOL29E1iwhf3P3s/BSEE69zhAo55yVBSq1A?=
 =?us-ascii?Q?hAzur4n4qL8q11r94ieIS2podHQ+UFTHEUW7WaB2huyWK/eLz6p2FWzSrUuh?=
 =?us-ascii?Q?0X9z0Oy4I9o4xLMMWMDQ7hI0mmLk9souWeqR+WlCL1VzGDtrFurW7N+baqM7?=
 =?us-ascii?Q?QU4rjv+PEa6VdJV/VvfOdbH16QWMXZYcUWp2qdpmNbA8r+WHPmWg6lm6KpW1?=
 =?us-ascii?Q?1KCia66+Bh2oAAezGWoQBpnr8g55PCBfQeebIEaKr/POCRHuJqM6CJWpYYFF?=
 =?us-ascii?Q?9ZnyHQjYOKus74VYR/ZqbUS8DwWKJq9jyBNCNurXlqKBTNKydQPeuXp7puPr?=
 =?us-ascii?Q?irPbi1VrChjyPldxyQl9OWMPWiqK/o0ORe0D/FtI/fnUbn+iXo5tP57m9FZ8?=
 =?us-ascii?Q?cvQAgcINyj1+dnWfDGFsSR6j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U0yn33SSLOGOr0IzVxG/Gl9arw+g/ZrUAOJEZXSQBxqM2U+VcQdT2iu5N9wk?=
 =?us-ascii?Q?H+gh5L8qoAytegjPASPPbp1yKP+1rBOCBH16KehleEXeKzirHaVgv4/xRHPn?=
 =?us-ascii?Q?9TdqBbceVXFlhLM4mooJYG8MUxrkC8Ar6LpcLmfmTl96+QBoBHEJ/txHc2kj?=
 =?us-ascii?Q?icC51QKl+AvBZoopMMcS83+knxf5jEIathN14upgQPR1ZAwwYJemNmQ9fkcY?=
 =?us-ascii?Q?Gh+9DRpD4H6zdd/dSZjHG9ZsacYyzhCkFvTDM5iHTRjyvmvFM71CmduQhaaW?=
 =?us-ascii?Q?dsZhcw05x2W3jpMXIPOJV17IWZcXeH2eFNinRJtnNuTldwQ7yalVz9KbWwA0?=
 =?us-ascii?Q?0eCONw/sneJxj7vgKxv2j6PNuDX7kh8lAZTIkTmAp34p/uqf4QAub4Z/RT00?=
 =?us-ascii?Q?DKpxR5OoWqLLZOfAwHXvdsGh3PtbZR52lEZe78XReCAPlFWaxCw6rD5Osl99?=
 =?us-ascii?Q?Ol1mwnFKsJHBfOtj5p5H1QTxrp0K9tPswBGdMhe/KlSJ/njnz+VGwtLpg3ec?=
 =?us-ascii?Q?XqJnWU1VTOiPHab9CpCjsK9ua6Cg1Jf500ZwWJbQgnZ250BM/LdhnV19FzHK?=
 =?us-ascii?Q?N7rjKkPjCrL0hexsm7zlrQj7IeMTgNu4QZyFwPxnzF0XWFLK+rXIh0U89dwO?=
 =?us-ascii?Q?LZBuc8EwzN7JtMk3HQLEju3MJuUQTaa3/Rk77bTHoHJlEiBj2QV5jAzbrZkv?=
 =?us-ascii?Q?0ovUxd7mGQ6zAk4oU+9wXUeep8ahKEJqNlOcx0qml0v7wLgJOPC0jN1h5Css?=
 =?us-ascii?Q?bJOEm4eUDs8lUk/FX6iqAGARSto/kcn7cyr4Qz1Q6UNhbX+CoeBRBY3p7ajJ?=
 =?us-ascii?Q?i95ThHgeWgsloLQxWwOrqcK0PnzXAD7305be/rayLm2cB6NICtk9/gZj0NzY?=
 =?us-ascii?Q?V2XPhiP0Kp6d9sKY7DMpw1UkjsZU8jxeiAghGCAHjRS0Bc365JzWmsHD83qv?=
 =?us-ascii?Q?3hdYe1voLZ11eay82szPdnFVX5KKZDFmuPsqdi3RSmHAENzheLHliZ+QlnwX?=
 =?us-ascii?Q?A1YvIGrxU2qj3a1JhXuEdjmn3qUwPtjy6vxBLAd/0JAvQX+7bI6RuSME8Pc3?=
 =?us-ascii?Q?Hxps281xi04niwNN/rF7sV1s7IILPi1D40bvbZJduzT+h/XAPHTRKQug+a2v?=
 =?us-ascii?Q?7GX6Fu/rVMTV6Z6PTs+VX4QXln4f6mi3Uj6WsSVgBCVXK5CTejJgp8+vkegq?=
 =?us-ascii?Q?nSV1c2jtu0q55P5Uos1OSOZ5ArDIdrUxFcOkutJpfO3PRGNgKIIkn8XcPlqn?=
 =?us-ascii?Q?8RvYRPbrPAkMEHdzlzg5/He3cAFm1UTO6nQwS/BcY66cBw+3jF7cQsgPi1KO?=
 =?us-ascii?Q?N2hC8TVde0VdMVQj3e9/DhYSAPf9BZFQM5V2608U4DQ0RVCY+nYB8ZdxsASZ?=
 =?us-ascii?Q?1A3f4W3iU/oR9FqoXFdEKgItpG+SZmwHD+v7ZooLaA05blO/V+WNLDyzbNIc?=
 =?us-ascii?Q?BhacAjOhsuJmORrYGhQxbQIfzRwHmDfQqMgCZwczNJd/USZgIZl12G5LR+8d?=
 =?us-ascii?Q?jwvHJzTYiHbeIpaXa+WPTKaa2htduScor/tDbbVHDWIlkA2LuoZ6Z9WyPVtV?=
 =?us-ascii?Q?zNmvsGtAw111QVqB3+eNe86wTP8mh7sM+EHK15d+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7337e064-5e3a-4d67-1ff9-08dc8583a18a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 17:19:17.8615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFCj/KFnw9BNeQJcjRbOvcNMnpOEmXZoJpnny2l644Hu398cMn+ua6xTq9r6cO/ADDVmLo6oRkrR3foJ/wremA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8053
X-OriginatorOrg: intel.com

Hi Prateek, Chunxin,

On 2024-05-28 at 10:32:23 +0530, K Prateek Nayak wrote:
> Hello Chunxin,
> 
> On 5/28/2024 8:12 AM, Chunxin Zang wrote:
> > 
> >> On May 24, 2024, at 23:30, Chen Yu <yu.c.chen@intel.com> wrote:
> >>
> >> On 2024-05-24 at 21:40:11 +0800, Chunxin Zang wrote:
> >>> I found that some tasks have been running for a long enough time and
> >>> have become illegal, but they are still not releasing the CPU. This
> >>> will increase the scheduling delay of other processes. Therefore, I
> >>> tried checking the current process in wakeup_preempt and entity_tick,
> >>> and if it is illegal, reschedule that cfs queue.
> >>>
> >>> The modification can reduce the scheduling delay by about 30% when
> >>> RUN_TO_PARITY is enabled.
> >>> So far, it has been running well in my test environment, and I have
> >>> pasted some test results below.
> >>>
> >>
> >> Interesting, besides hackbench, I assume that you have workload in
> >> real production environment that is sensitive to wakeup latency?
> > 
> > Hi Chen
> > 
> > Yes, my workload  are quite sensitive to wakeup latency .
> >>
> >>>
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index 03be0d1330a6..a0005d240db5 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -5523,6 +5523,9 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
> >>> 			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
> >>> 		return;
> >>> #endif
> >>> +
> >>> +	if (!entity_eligible(cfs_rq, curr))
> >>> +		resched_curr(rq_of(cfs_rq));
> >>> }
> >>>
> >>
> >> entity_tick() -> update_curr() -> update_deadline():
> >> se->vruntime >= se->deadline ? resched_curr()
> >> only current has expired its slice will it be scheduled out.
> >>
> >> So here you want to schedule current out if its lag becomes 0.
> >>
> >> In lastest sched/eevdf branch, it is controlled by two sched features:
> >> RESPECT_SLICE: Inhibit preemption until the current task has exhausted it's slice.
> >> RUN_TO_PARITY: Relax RESPECT_SLICE and only protect current until 0-lag.
> >> https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/eevdf&id=e04f5454d68590a239092a700e9bbaf84270397c
> >>
> >> Maybe something like this can achieve your goal
> >> 	if (sched_feat(RUN_TOPARITY) && !entity_eligible(cfs_rq, curr))
> >> 		resched_curr
> >>
> >>>
> >>> @@ -8325,6 +8328,9 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
> >>> 	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
> >>> 		return;
> >>>
> >>> +	if (!entity_eligible(cfs_rq, se))
> >>> +		goto preempt;
> >>> +
> >>
> >> Not sure if this is applicable, later in this function, pick_eevdf() checks
> >> if the current is eligible, !entity_eligible(cfs_rq, curr), if not, curr will
> >> be evicted. And this change does not consider the cgroup hierarchy.
> 
> The above line will be referred to as [1] below.
> 
> >>
> >> Besides, the check of current eligiblity can get false negative result,
> >> if the enqueued entity has a positive lag. Prateek proposed to
> >> remove the check of current's eligibility in pick_eevdf():
> >> https://lore.kernel.org/lkml/20240325060226.1540-2-kprateek.nayak@amd.com/
> > 
> > Thank you for letting me know about Peter's latest updates and thoughts.
> > Actually, the original intention of my modification was to minimize the
> > traversal of the rb-tree as much as possible. For example, in the following
> > scenario, if 'curr' is ineligible, the system would still traverse the rb-tree in
> > 'pick_eevdf' to return an optimal 'se', and then trigger  'resched_curr'. After
> > resched, the scheduler will call 'pick_eevdf' again, traversing the
> > rb-tree once more. This ultimately results in the rb-tree being traversed
> > twice. If it's possible to determine that 'curr' is ineligible within 'wakeup_preempt'
> > and directly trigger a 'resched', it would reduce the traversal of the rb-tree
> > by one time.
> > 
> > 
> > wakeup_preempt-> pick_eevdf                                      -> resched_curr
> >                                                  |->'traverse the rb-tree'  |
> > schedule->pick_eevdf
> >                                    |->'traverse the rb-tree'
> 
> I see what you mean but a couple of things:
> 
> (I'm adding the check_preempt_wakeup_fair() hunk from the original patch
> below for ease of interpretation)
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 03be0d1330a6..a0005d240db5 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8325,6 +8328,9 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
> >  	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
> >  		return;
> >  
> > +	if (!entity_eligible(cfs_rq, se))
> > +		goto preempt;
> > +
> 
> This check uses the root cfs_rq since "task_cfs_rq()" returns the
> "rq->cfs" of the runqueue the task is on. In presence of cgroups or
> CONFIG_SCHED_AUTOGROUP, there is a good chance this the task is queued
> on a higher order cfs_rq and this entity_eligible() calculation might
> not be valid since the vruntime calculation for the "se" is relative to
> the "cfs_rq" where it is queued on. Please correct me if I'm wrong but
> I believe that is what Chenyu was referring to in [1].
>

Sorry for the late reply and thanks for help clarify this. Yes, this is
what my previous concern was:
1. It does not consider the cgroup and does not check preemption in the same
   level which is covered by find_matching_se().
2. The if (!entity_eligible(cfs_rq, se)) for current is redundant because
   later pick_eevdf() will check the eligible of current anyway. But
   as pointed out by Chunxi, his concern is the double-traverse of the rb-tree,
   I just wonder if we could leverage the cfs_rq->next to store the next
   candidate, so it can be picked directly in the 2nd pick as a fast path?
   Something like below untested:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a5b1ae0aa55..f716646d595e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8349,7 +8349,7 @@ static void set_next_buddy(struct sched_entity *se)
 static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int wake_flags)
 {
        struct task_struct *curr = rq->curr;
-       struct sched_entity *se = &curr->se, *pse = &p->se;
+       struct sched_entity *se = &curr->se, *pse = &p->se, *next;
        struct cfs_rq *cfs_rq = task_cfs_rq(curr);
        int cse_is_idle, pse_is_idle;
 
@@ -8415,7 +8415,11 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
        /*
         * XXX pick_eevdf(cfs_rq) != se ?
         */
-       if (pick_eevdf(cfs_rq) == pse)
+       next = pick_eevdf(cfs_rq);
+       if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && next)
+               set_next_buddy(next);
+
+       if (next == pse)
                goto preempt;
 
        return;


thanks,
Chenyu

> >  	find_matching_se(&se, &pse);
> >  	WARN_ON_ONCE(!pse);
> >  
> > -- 
> 
> In addition to that, There is an update_curr() call below for the first
> cfs_rq where both the entities' hierarchy is queued which is found by
> find_matching_se(). I believe that is required too to update the
> vruntime and deadline of the entity where preemption can happen.
> 
> If you want to circumvent a second call to pick_eevdf(), could you
> perhaps do:
> 
> (Only build tested)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9eb63573110c..653b1bee1e62 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8407,9 +8407,13 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	update_curr(cfs_rq);
>  
>  	/*
> -	 * XXX pick_eevdf(cfs_rq) != se ?
> +	 * If the hierarchy of current task is ineligible at the common
> +	 * point on the newly woken entity, there is a good chance of
> +	 * wakeup preemption by the newly woken entity. Mark for resched
> +	 * and allow pick_eevdf() in schedule() to judge which task to
> +	 * run next.
>  	 */
> -	if (pick_eevdf(cfs_rq) == pse)
> +	if (!entity_eligible(cfs_rq, se))
>  		goto preempt;
>  
>  	return;
> 
> --
> 
> There are other implications here which is specifically highlighted by
> the "XXX pick_eevdf(cfs_rq) != se ?" comment. If the current waking
> entity is not the entity with the earliest eligible virtual deadline,
> the current task is still preempted if any other entity has the EEVD.
> 
> Mike's box gave switching to above two thumbs up; I have to check what
> my box says :)
> 
> Following are DeathStarBench results with your original patch compared
> to v6.9-rc5 based tip:sched/core:
> 
> ==================================================================
> Test          : DeathStarBench
> Why?	      : Some tasks here do no like aggressive preemption
> Units         : Normalized throughput
> Interpretation: Higher is better
> Statistic     : Mean
> ==================================================================
> Pinning      scaling     tip            eager_preempt (pct imp)
>  1CCD           1       1.00            0.99 (%diff: -1.13%)
>  2CCD           2       1.00            0.97 (%diff: -3.21%)
>  4CCD           3       1.00            0.97 (%diff: -3.41%)
>  8CCD           6       1.00            0.97 (%diff: -3.20%)
> --
> 
> I'll give the variants mentioned in the thread a try too to see if
> some of my assumptions around heavy preemption hold good. I was also
> able to dig up an old patch by Balakumaran Kannan which skipped
> pick_eevdf() altogether if "pse" is ineligible which also seems like
> a good optimization based on current check in
> check_preempt_wakeup_fair() but it perhaps doesn't help the case of 
> wakeup-latency sensitivity you are optimizing for; only reduces
> rb-tree traversal if there is no chance of pick_eevdf() returning "pse" 
> https://lore.kernel.org/lkml/20240301130100.267727-1-kumaran.4353@gmail.com/ 
> 
> --
> Thanks and Regards,
> Prateek
> 
> > 
> > 
> > Of course, this would break the semantics of RESPECT_SLICE as well as
> > RUN_TO_PARITY. So, this might be considered a performance enhancement
> > for scenarios without NO_RESPECT_SLICE/NO_RUN_TO_PARITY.
> > 
> > thanks 
> > Chunxin
> > 
> > 
> >> If I understand your requirement correctly, you want to reduce the wakeup
> >> latency. There are some codes under developed by Peter, which could
> >> customized task's wakeup latency via setting its slice:
> >> https://lore.kernel.org/lkml/20240405110010.934104715@infradead.org/
> >>
> >> thanks,
> >> Chenyu
> 


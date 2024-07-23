Return-Path: <linux-kernel+bounces-259570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AF193989D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 05:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9CF1F226F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 03:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFBC13BAFE;
	Tue, 23 Jul 2024 03:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzudgWwb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AB58814
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 03:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721704979; cv=fail; b=jIztcXdmPwwQHlQQUZp/6CgM/4V5uf81JWI3UWRKmNbueqGga0bAmyem/zvAkACS5w6BuuUheUG1ycQ/GCsGk4YyoO5c6QT/eIRJbQ9bz0DMjLPTBjdezcq4bQdmVxaWCmsBmKVbg5nroEZX+EfIftz+6Lrp1wGdcRRsThxaoMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721704979; c=relaxed/simple;
	bh=iBE6h+XiXpyVhk8p9VwP7sb0EgNaHqXEhSj9U7JkiXU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kPVQx8meLfBDi4f8horYN/8N8KXqXxqCztiHIlplHoEESAzY0hwl8ffMlRHtyQQJ3uFJKh1XOvrgnRh6Ezy3mTA3UGdk7VW6yw4Y4x5/k+XoTOdSfClm7mNIc6wbEPKpVrjylmW79fmC7C7T5xpoaaVbDWkSH5rZUHyyYvZEqVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzudgWwb; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721704976; x=1753240976;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iBE6h+XiXpyVhk8p9VwP7sb0EgNaHqXEhSj9U7JkiXU=;
  b=SzudgWwbMmHgmiJq0Jd9qDyagnEt3DhytSOKYimTjMHXTgWbMKOz+yc5
   9zRfWzVjUbipEPgV8irOTEezxwr25ck0QA1g+12XVQ/ViqZKawGDFLb/w
   Tvm7tFmkkMhjrKeokqRHj7p0/T9zyXGsZqFhITOS1MLyetdqf20iSifJc
   9KhPmDqUPA5wO+wmu4pG6iQIkYE33Y87Wv4OfsR6WKdfXCPgBmQji00ZJ
   GOJ0YKSSTOvUy9s8FhnfYFWoMvQyA5TRwfoj0zqDiGUssci9kUM0nCRg+
   dn327zvp4L3CKpKwN9p6i8An9aXaH+qJ0MviEALVDKafM3I+Km3GJX34A
   A==;
X-CSE-ConnectionGUID: JFogjNjQREKyRpG9slrG3w==
X-CSE-MsgGUID: L9FIPlZhRcqnWV5EtVOP2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="19433194"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="19433194"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 20:22:56 -0700
X-CSE-ConnectionGUID: CVhSC91LTxuUqyZC4Wd+WQ==
X-CSE-MsgGUID: HcJpUITpQN2zASP5GYYVEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="83106854"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jul 2024 20:22:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 20:22:55 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 20:22:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 22 Jul 2024 20:22:55 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 22 Jul 2024 20:22:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuctKD2dwvlGnnWsHRQdMQbUEwVQqcCMX2B3IqrwOSkjTpfAQKNXKiaOf7044A/+kYHytQfFBKF/ZGzA68Lt6gf8ClR427ABJ/M3DtcoynkcfZs6BE1PK+U9qqqrudaiDYPsEEXaIjIZfbiyCKfQo/i6oB79TqmdVxXblKM8Tkmu6B7OukWcpw54GfA00Q43zTSPBt7BLIMqkCUjabWW8jJ3QcU4hAI2ma56UZb+otTnFtcRTwzUCsIs+3xhg90zxBqapMx9o+EFKX2ipc6HcWXAgZVEt7Q8x/nyIbpgLHZeHv83kFS3LyTLFdw0HvwSWtPoHIHTye1tkRUuKHmUeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4o/862oi0WjwfG9cpqcK7IYQfIy8j343A6aTiCgoFQ=;
 b=v+kIVsHl1KBfHNbodt6Y+ABhpPFIOP8hM6JTKv823RYYxN8GGh8kaJj6q+1YgrRz2Cojg/ZXkq3iE/6R4M0MJaVDxfN5kok5jaZS4d/6ugEX04vgbTO0/Bt97YlG5+D95upamy6/U+0xuOK2xENX1fLFH2BLEbKGpU6OdNRCSe88hByWQwxz+SxcTJmpv4jlx02J/VU2pJRfZ/IowmWrjSZjA+3BQs14zO6k7y+eR1vq9BWtNBP+cyIaEX4dXdwDo6I2WaJQyBDa5V8DbYBYsDNH4DtO38BhHcILpQ9S8AOWjDf+CQzmT7yr5b05u7LOPxb/JOgm7pft9fYmmxijTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB7966.namprd11.prod.outlook.com (2603:10b6:510:25d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 23 Jul
 2024 03:22:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Tue, 23 Jul 2024
 03:22:47 +0000
Date: Tue, 23 Jul 2024 11:22:37 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Alex Shi <seakeel@gmail.com>
CC: Alex Shi <alexs@kernel.org>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: Re: [alexshi:mmunstable2] 934c05f8c5:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <Zp8h/ZZTQ0lwmcJa@xsang-OptiPlex-9020>
References: <202407221607.49138a71-oliver.sang@intel.com>
 <a634bf58-9195-4c6f-b3d8-468d47e71033@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a634bf58-9195-4c6f-b3d8-468d47e71033@gmail.com>
X-ClientProxiedBy: SGXP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::24)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: f827c07b-2e8b-48fe-17f9-08dcaac6b91e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3G7O97aqp2ZZ93z9Pqo8GRFv6BS7Q4I5Wl6MyHLO/qk5yHFHetr0ndiH8U0Q?=
 =?us-ascii?Q?ZbQa6IOSomkx0dmxurAXZL9HHj1ACd+zy3wYBsPDNTLMXPAMTTSNO8BVubxH?=
 =?us-ascii?Q?FJfzz3MpnXMOA9Yorr0mXdPfGld26+XTSzDLATI509tv9QLUR6s9m+zLkt/6?=
 =?us-ascii?Q?3aUIkoumA5hcR+dUNQLYJxi0VcrL4y/rhzJljoA2S8iRNAHG+dAGN2mkTEej?=
 =?us-ascii?Q?d4OqwPuzknoBl/p7jPCk/U3vCsRwcuSHijl9a3l33839bwAWe0HRUIa3W9c7?=
 =?us-ascii?Q?yMFcNhijyHTnh5LSBIs1JCEkWSnEY+EIU/Bhzpo7eKRjHjV1ToS4Y/l+9VE4?=
 =?us-ascii?Q?sCEFUnNydwK84n5uut3FhU6YILxaqlbaXWbV9GcJBQwQQeZeP3L/hMvuYJQS?=
 =?us-ascii?Q?IwxdHTWRuzIKXd8LvPYgcnh3jIYADl5Kk1EgdFMHYc4r1AgtQz3z70lJmWxU?=
 =?us-ascii?Q?OBbvzFkaOWI9AMDAKngoNQetdxmVOVw2dArl2PUgga1cb6BzAmOc4F6heY4p?=
 =?us-ascii?Q?ajrjfp3o7B4zmU4N8e1OAmPiT0HZnlEdqVipQFSTU58IDJjdHqhbImGced2D?=
 =?us-ascii?Q?+OM+4bI+yFAgB6AkKVtmP4RlcIph1zbQEDj6KguD6BmyIeseO2Upv8JRxtge?=
 =?us-ascii?Q?jPDKCw6nyyBrtnKdJ1WTaWmdMBdJM+y3FIpsBEuNCRHD5V7h3X9ti1kmY5O3?=
 =?us-ascii?Q?fuvmUmeJLISsfXTcW6GMHBlvvW27VARCdnsTuep5UfGo8LxWbJvg2M4Ig0gH?=
 =?us-ascii?Q?X1dRlc/IaxgKjvSIgzjSlDOfgPnmpFjb2NGhJ5N1eYszQHYDkiwcLPkGUTbI?=
 =?us-ascii?Q?AwSdXsotnzi9ySmRuSvIMOlmy9jBYwArsTjbsP9T+hQ1sxPjG25xjyKsftCI?=
 =?us-ascii?Q?l/texju6VBczjdJA0JHvZwzF1f2qyPI7wYtpL/F1gIEE4fKaZtYk6PssLszo?=
 =?us-ascii?Q?6/8KX9S8579kAwlSmPYLxECdTACXhjco42mcOeP3AYaR+IA+0oEWq4OWYdMT?=
 =?us-ascii?Q?oryI5u8vDpRE/4a6Cmnyx2Cwv1n/lZwc/XYH1yKGf4uv79Li3vClOi728lKU?=
 =?us-ascii?Q?W5KxP6pjaCOfZMjICmePVlLIaOCWlWPiYBc+au9olh/Sab3GM9FosHp7B73d?=
 =?us-ascii?Q?SKwO07LewmQiOqksj99Dq9IbcxzbJCjK0CFDAFwhOqclcxjfiRZ4wjr+a00U?=
 =?us-ascii?Q?DPNiF8jCtLHhaq1ifQdIyHT1sCzkgxsNPzGJA4uOU7oYfQ/BVACFGImLXdLz?=
 =?us-ascii?Q?xJIvHr2LqbQKFDev9BF5YC2WJAxzOjZeN9ylSm2l6YEdcLPEjSnkrYj1nSis?=
 =?us-ascii?Q?fHw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pUGOx+b2JDgcvrshu4pf2OjwQoS8/fZFcjGQiuNC2bk7Yu6y+rStg3Qk5biP?=
 =?us-ascii?Q?uSk0L8kktYm8HM9a8JByvZv7pqG/NmkGB9F8w2cYZdQ9uU7wMR1Wy0kQnCLu?=
 =?us-ascii?Q?aCMRNrEuJgYXTONJf4G1muQRY1/VTVXSbLDHZFDwLRcyVBztI/8Qgnxf7zf1?=
 =?us-ascii?Q?ebSq79v6QHFj25DnJUYayhKyscpxyKU3QxGuK+/QynuoMu5Saa4gN3rqZNNK?=
 =?us-ascii?Q?zqlH7qgjQooRyjITm8sPvnNTqcu3yjlDDfSmIo2S3Hvz19frcnFrIQu01Fhh?=
 =?us-ascii?Q?WV3DGv2QxkFeYmrK6TDU94xcySVeum9KjxIm4qZe3+Q5PVD++SwrCYo/Gb5U?=
 =?us-ascii?Q?yT/quYOCb/u4odPHD8uGf8uOCE6A4gjtIVsyOdW6TikoKs3zm3wH99oNdmzx?=
 =?us-ascii?Q?noIXdBBpl61k3u918q++yUMI9VERoggCcTuWMkrF6clFrJi/PbxYLaCuTkUq?=
 =?us-ascii?Q?I3Yl80TV1ZB1tI3HnVeWMKeRrECnjfFrenO5Cxr1hH8SYNbI+yRERnDaUPlX?=
 =?us-ascii?Q?VMlvnGqVY7cKujYG9bOmuarnYxe3gjnEU4/+irAA+1a+PUn+VeaUs1a90Gez?=
 =?us-ascii?Q?pXm7ttY18IGQP7JZAgZL0i76uod2ys/RDaQUQy1FqAeJxQXQ1Ln0bmQSEh1P?=
 =?us-ascii?Q?JUd/UcMLmjTBIeKPnjlX+aNG0nN3F75BxsDGAtFcdJfbxAiCI4gqE++EtYNn?=
 =?us-ascii?Q?zeW305xogH+YVxp3qRceAYsiajQvyGCtLDMD2kw182W6pIAgNpq0TlyaE4OJ?=
 =?us-ascii?Q?RfgqKC/lZ44fqon/RiI2JzrIXZuvaM4TUiA5mAJF6choKIcZEMPss41aXqJp?=
 =?us-ascii?Q?5oEy4CECTuDxLzyqVRnvqCCdWTqremh7c1Jlm/mbHViRoyoaO2NAhQIMM3B4?=
 =?us-ascii?Q?hJ8ihNDkvNnc0jF6R/W6Tx4UwalE2OQDoy9xedl5E0Z6Fu/JES434usE8cda?=
 =?us-ascii?Q?0o3SwTQLKkZJrA1intOJXewj+lk0biua/hJ3amK7q/PTPzmJHN7jN/KGl1Xr?=
 =?us-ascii?Q?O0djORh02kK7mwuEQH2z2z89uYONw8uv+idbmxcCzGGLHcjhtmxoqzE0HKFH?=
 =?us-ascii?Q?n8f6KOENC8k7TWWTgL5+c4P/y8DnWCUg84FI9Fbhw5Kvm/TjzpxllB2ijOwX?=
 =?us-ascii?Q?Hxoyvt2lkJLCrZNiH2zFtFFfzMvBdnRuex5RQGTlZ0AuDHiZbtaUspwW1jKb?=
 =?us-ascii?Q?xs/8vfS0Uoxu4KeHD6F5gwD76dfu30hqV7UvgkMaZ3bFG6Y1wQo2Psi/mxay?=
 =?us-ascii?Q?JyqVuOgXBQt7AnIS1nHM76uygUUUkSmRKGh5MmcICJx1CyGnIzv3zticzL1k?=
 =?us-ascii?Q?MdvHzDtOHFpx00P4g93w5gz4ZYBOpiqjtJsgJT7iKQ+wsEN7ibdWIhcVV6wY?=
 =?us-ascii?Q?gg/W22JDGtD/RLbjql4siAfUf4QDcVp66hEYtUShYvAHE2+yI3eRYtJUDNOP?=
 =?us-ascii?Q?pP91AuRksGvUuXWy9oJsVx/yYEWpWxUT9G1rx7iwhwZrkUH13asiHj1+xwOL?=
 =?us-ascii?Q?1IXTScwSXjQXw9oz54jx9mPwHqzyD/FcvPdiyg5FKIljXW3c/kzzM4mVZ96z?=
 =?us-ascii?Q?58xeHQiZJHfDpzaUKAQ0ZrfmWC2NahYZyDz5BQhVRCAsSdpSeb0Hd2CKhtaA?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f827c07b-2e8b-48fe-17f9-08dcaac6b91e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 03:22:46.9274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fw35ZwEKjZ8iSCGoHKiCOiTNWpirwyHqgH+svzRL+P0akKFUx67n3FkmkCqh7ABEoCotdV2pqcMgto0h4IoalA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7966
X-OriginatorOrg: intel.com

hi, Alex,

On Tue, Jul 23, 2024 at 09:58:25AM +0800, Alex Shi wrote:
> 
> 
> On 7/23/24 9:05 AM, kernel test robot wrote:
> > 
> > hi, Alex Shi,
> > 
> > we noticed there is a mmunstable3 branch now, but there is no same title patch
> > there. not sure if this report is still useful, below report just FYI.
> 
> Hi Oliver,
> 
> Thanks a lot for your testing and founding on my unreleased code branch!
> The problem should be resolved on my latest code yesterday.
> But multiple archs maybe still are fragile in the branch. Are there bootable in virtual machine, like arm, s390, etc?

we did boot test in vm, but only for x86_64 or i386.

you may notice we also send another report
"[alexshi:mmunstable3] [mm/memory]  f6ba7ce983: kernel_BUG_at_mm/page_alloc.c"

for both commit, we made some further check and cofirmed they cannot boot
successfully on both vm/bm, again, we only test x86_64/i386 for now.

> 
> Thanks again for your great work!
> 
> Alex
> 
> > 
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:
> > 
> > commit: 934c05f8c50fed91942a8aa9db46a0feae38594c ("use ptdesc in free_pte_range and pte_free_tlb series functions")
> > https://github.com/alexshi/linux.git mmunstable2
> > 
> > in testcase: boot
> > 
> > compiler: gcc-11
> > test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > +---------------------------------------------+------------+------------+
> > |                                             | 5977eb9785 | 934c05f8c5 |
> > +---------------------------------------------+------------+------------+
> > | BUG:unable_to_handle_page_fault_for_address | 0          | 6          |
> > | EIP:clear_user                              | 0          | 6          |
> > +---------------------------------------------+------------+------------+
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202407221607.49138a71-oliver.sang@intel.com
> > 
> > 
> > [    3.645340][    T1] BUG: unable to handle page fault for address: 00100016
> > [    3.645713][    T1] #PF: supervisor read access in kernel mode
> > [    3.646020][    T1] #PF: error_code(0x0000) - not-present page
> > [    3.646326][    T1] *pdpt = 000000002e992001 *pde = 0000000000000000
> > [    3.646663][    T1] Oops: Oops: 0000 [#1] PREEMPT SMP
> > [    3.646933][    T1] CPU: 0 PID: 1 Comm: init Not tainted 6.10.0-rc6-00481-g934c05f8c50f #1 c5190225c17d1f7c5bcc60b13088ed2c9e32ac25
> > [ 3.647536][ T1] EIP: __lock_acquire (kernel/locking/lockdep.c:5006 (discriminator 1)) 
> > [ 3.647797][ T1] Code: 8b 75 d0 e8 d8 9b 3c 00 85 c0 0f 85 a0 01 00 00 31 db 83 c4 38 89 d8 5b 5e 5f 5d 31 d2 31 c9 e9 60 6d be 01 8d 74 26 00 31 c0 <81> 3b a0 cb 44 c4 0f 45 45 0c 83 fa 01 89 45 f0 0f 87 10 fb ff ff
> > All code
> > ========
> >    0:	8b 75 d0             	mov    -0x30(%rbp),%esi
> >    3:	e8 d8 9b 3c 00       	call   0x3c9be0
> >    8:	85 c0                	test   %eax,%eax
> >    a:	0f 85 a0 01 00 00    	jne    0x1b0
> >   10:	31 db                	xor    %ebx,%ebx
> >   12:	83 c4 38             	add    $0x38,%esp
> >   15:	89 d8                	mov    %ebx,%eax
> >   17:	5b                   	pop    %rbx
> >   18:	5e                   	pop    %rsi
> >   19:	5f                   	pop    %rdi
> >   1a:	5d                   	pop    %rbp
> >   1b:	31 d2                	xor    %edx,%edx
> >   1d:	31 c9                	xor    %ecx,%ecx
> >   1f:	e9 60 6d be 01       	jmp    0x1be6d84
> >   24:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
> >   28:	31 c0                	xor    %eax,%eax
> >   2a:*	81 3b a0 cb 44 c4    	cmpl   $0xc444cba0,(%rbx)		<-- trapping instruction
> >   30:	0f 45 45 0c          	cmovne 0xc(%rbp),%eax
> >   34:	83 fa 01             	cmp    $0x1,%edx
> >   37:	89 45 f0             	mov    %eax,-0x10(%rbp)
> >   3a:	0f 87 10 fb ff ff    	ja     0xfffffffffffffb50
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >    0:	81 3b a0 cb 44 c4    	cmpl   $0xc444cba0,(%rbx)
> >    6:	0f 45 45 0c          	cmovne 0xc(%rbp),%eax
> >    a:	83 fa 01             	cmp    $0x1,%edx
> >    d:	89 45 f0             	mov    %eax,-0x10(%rbp)
> >   10:	0f 87 10 fb ff ff    	ja     0xfffffffffffffb26
> > [    3.648776][    T1] EAX: 00000000 EBX: 00100016 ECX: 00000000 EDX: 00000000
> > [    3.649136][    T1] ESI: 00100016 EDI: 00000000 EBP: c01f1b7c ESP: c01f1b38
> > [    3.649504][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010046
> > [    3.649890][    T1] CR0: 80050033 CR2: 00100016 CR3: 0054bd80 CR4: 000406b0
> > [    3.650252][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > [    3.650611][    T1] DR6: fffe0ff0 DR7: 00000400
> > [    3.650863][    T1] Call Trace:
> > [ 3.651036][ T1] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
> > [ 3.651256][ T1] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
> > [ 3.651457][ T1] ? oops_enter (kernel/panic.c:642) 
> > [ 3.651680][ T1] ? page_fault_oops (arch/x86/mm/fault.c:715) 
> > [ 3.651927][ T1] ? __lock_acquire (kernel/locking/lockdep.c:5137) 
> > [ 3.652177][ T1] ? kernelmode_fixup_or_oops+0x68/0x8c 
> > [ 3.652513][ T1] ? __bad_area_nosemaphore+0x133/0x238 
> > [ 3.652850][ T1] ? bad_area_nosemaphore (arch/x86/mm/fault.c:835) 
> > [ 3.653116][ T1] ? do_user_addr_fault (arch/x86/mm/fault.c:1452) 
> > [ 3.653389][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4300 kernel/locking/lockdep.c:4359) 
> > [ 3.653693][ T1] ? exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539) 
> > [ 3.653952][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494) 
> > [ 3.654265][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1054) 
> > [ 3.654524][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494) 
> > [ 3.654838][ T1] ? __lock_acquire (kernel/locking/lockdep.c:5006 (discriminator 1)) 
> > [ 3.655087][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494) 
> > [ 3.655400][ T1] ? __lock_acquire (kernel/locking/lockdep.c:5006 (discriminator 1)) 
> > [ 3.655650][ T1] ? register_lock_class (kernel/locking/lockdep.c:1285 (discriminator 13)) 
> > [ 3.655916][ T1] ? filemap_get_entry (include/linux/rcupdate.h:339 include/linux/rcupdate.h:812 mm/filemap.c:1858) 
> > [ 3.656179][ T1] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5756) 
> > [ 3.656408][ T1] ? pmd_install (mm/memory.c:424) 
> > [ 3.656638][ T1] ? slow_virt_to_phys (arch/x86/mm/pat/set_memory.c:811) 
> > [ 3.656896][ T1] _raw_spin_lock (include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
> > [ 3.657130][ T1] ? pmd_install (mm/memory.c:424) 
> > [ 3.657451][ T1] pmd_install (mm/memory.c:424) 
> > [ 3.657669][ T1] finish_fault (mm/memory.c:4870) 
> > [ 3.657902][ T1] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:63 (discriminator 13)) 
> > [ 3.658156][ T1] do_pte_missing (mm/memory.c:5100 mm/memory.c:5193 mm/memory.c:3947) 
> > [ 3.658398][ T1] handle_pte_fault (mm/memory.c:5522) 
> > [ 3.658647][ T1] ? __lock_release+0x4f/0x17c 
> > [ 3.658921][ T1] __handle_mm_fault (mm/memory.c:5666) 
> > [ 3.659174][ T1] ? mt_find (lib/maple_tree.c:6952) 
> > [ 3.659394][ T1] ? __handle_mm_fault (mm/memory.c:5800) 
> > [ 3.659656][ T1] handle_mm_fault (mm/memory.c:5745 mm/memory.c:5832) 
> > [ 3.659897][ T1] ? lock_mm_and_find_vma (mm/memory.c:5921) 
> > [ 3.660167][ T1] do_user_addr_fault (include/linux/sched/signal.h:425 arch/x86/mm/fault.c:1391) 
> > [ 3.660426][ T1] exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539) 
> > [ 3.660663][ T1] ? find_held_lock (kernel/locking/lockdep.c:5244) 
> > [ 3.660905][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1494) 
> > [ 3.661221][ T1] handle_exception (arch/x86/entry/entry_32.S:1054) 
> > [ 3.661478][ T1] EIP: clear_user (arch/x86/lib/usercopy_32.c:66) 
> > [ 3.661712][ T1] Code: 34 b8 00 00 00 c0 29 d8 39 c7 77 29 ba 42 00 00 00 b8 63 1d 95 c3 e8 fe 6f 5c fe 89 da 31 c0 c1 eb 02 83 e2 03 89 d9 8d 76 00 <f3> ab 89 d1 f3 aa 8d 76 00 89 cb 89 d8 5b 5f 5d 31 d2 31 c9 e9 4a
> > All code
> > ========
> >    0:	34 b8                	xor    $0xb8,%al
> >    2:	00 00                	add    %al,(%rax)
> >    4:	00 c0                	add    %al,%al
> >    6:	29 d8                	sub    %ebx,%eax
> >    8:	39 c7                	cmp    %eax,%edi
> >    a:	77 29                	ja     0x35
> >    c:	ba 42 00 00 00       	mov    $0x42,%edx
> >   11:	b8 63 1d 95 c3       	mov    $0xc3951d63,%eax
> >   16:	e8 fe 6f 5c fe       	call   0xfffffffffe5c7019
> >   1b:	89 da                	mov    %ebx,%edx
> >   1d:	31 c0                	xor    %eax,%eax
> >   1f:	c1 eb 02             	shr    $0x2,%ebx
> >   22:	83 e2 03             	and    $0x3,%edx
> >   25:	89 d9                	mov    %ebx,%ecx
> >   27:	8d 76 00             	lea    0x0(%rsi),%esi
> >   2a:*	f3 ab                	rep stos %eax,%es:(%rdi)		<-- trapping instruction
> >   2c:	89 d1                	mov    %edx,%ecx
> >   2e:	f3 aa                	rep stos %al,%es:(%rdi)
> >   30:	8d 76 00             	lea    0x0(%rsi),%esi
> >   33:	89 cb                	mov    %ecx,%ebx
> >   35:	89 d8                	mov    %ebx,%eax
> >   37:	5b                   	pop    %rbx
> >   38:	5f                   	pop    %rdi
> >   39:	5d                   	pop    %rbp
> >   3a:	31 d2                	xor    %edx,%edx
> >   3c:	31 c9                	xor    %ecx,%ecx
> >   3e:	e9                   	.byte 0xe9
> >   3f:	4a                   	rex.WX
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >    0:	f3 ab                	rep stos %eax,%es:(%rdi)
> >    2:	89 d1                	mov    %edx,%ecx
> >    4:	f3 aa                	rep stos %al,%es:(%rdi)
> >    6:	8d 76 00             	lea    0x0(%rsi),%esi
> >    9:	89 cb                	mov    %ecx,%ebx
> >    b:	89 d8                	mov    %ebx,%eax
> >    d:	5b                   	pop    %rbx
> >    e:	5f                   	pop    %rdi
> >    f:	5d                   	pop    %rbp
> >   10:	31 d2                	xor    %edx,%edx
> >   12:	31 c9                	xor    %ecx,%ecx
> >   14:	e9                   	.byte 0xe9
> >   15:	4a                   	rex.WX
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20240722/202407221607.49138a71-oliver.sang@intel.com
> > 
> > 
> > 
> 


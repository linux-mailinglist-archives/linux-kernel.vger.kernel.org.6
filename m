Return-Path: <linux-kernel+bounces-198712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CB58D7C70
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35CF1C2184D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7714642B;
	Mon,  3 Jun 2024 07:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFFLkxJ7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F663FB1C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 07:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717399705; cv=fail; b=r6KCHCbCMlf0LNIPo1JXDGI94+xabZV5b9SVhOQWu77VIBlgnLZ80Nf4IsJwt+esmR4P8Q7GJ8m63Y/MWsjE3LmHd70oD7At5rw0OmwUWZVhB3+G3TPMMAwIogaHHeIorEzqXHxWLSaL5ziUuuNshRd8QSjFzyiqS0wxW/R3YOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717399705; c=relaxed/simple;
	bh=iqgXOMK+12H85afjIhIPZ3y82K1dAC4dFz+ZxWpT44E=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qvgUBABQyWIXry19uYf2c3TlXfKh1mXdfnz5Q/RbO7YHQ8O0M80FMsJ6UU73uXyqZkJkQGKAqmG0/jR7AG3nEIwHyaR378Yeu5qiFJnBorO4gTj+yFf3vgdM7l3n1P2x97lND76KoybS9JX4BsAi8L8ctW/g/lOOyRCT2fkDdrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFFLkxJ7; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717399702; x=1748935702;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=iqgXOMK+12H85afjIhIPZ3y82K1dAC4dFz+ZxWpT44E=;
  b=iFFLkxJ74Hdy/EvYImHOMlm+rxcHdIzJkVgesFyvzpTn7QIyVBv0tZuC
   wR/z83ACPrkJWR+UslRvf0Yu4NxKu7hqZ3521LnHRCHoqP0rNGbO/mnr6
   B5Gt/Gfp5lGwrp4sWXGFNNnoWwNWr5jK1MqHbUt0hBK4DrxSzBAhJ2tkX
   BRnSFOpIhbDCZF6+WvKods3eQh66Obwj7RkH421zIF3tWE2a6JmmeJn+r
   c3aGGe5x9owbdZxgYtT3oIvjIGhYPIBAYk0xINiUsTGeCnGS3tfvtRF2I
   +Dx/+JK3Xn+/WyuGjFleJ1Bq+pDfizddYNGqeFIwiVLdxb58PZpcJtv0z
   Q==;
X-CSE-ConnectionGUID: zBFva1myRSCmirtFFxdg9A==
X-CSE-MsgGUID: v50rnMDZQMGfVAvzd4P6PQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="14003157"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="14003157"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 00:28:16 -0700
X-CSE-ConnectionGUID: Il6lrHvsTBeSeuodcVHTqA==
X-CSE-MsgGUID: 3tZQ7JKGTn6ATMQpRyo3gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="41236559"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 00:28:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 00:28:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 00:28:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 00:28:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j55K1lKvWb5oWJRelR+wcMBGKjldb2vtEiBjisDRrJqn9y1nDDZuhXCBN7EU8dpAZY7rKarJ5Uj8+/yATKx+wVFMr6t5MRxKiTUyIxKCNR4IfG4J43sIZYFHWEH8hYv7stBDzM0tyWeq7qSLeFN0e81T9HWoCBeb8ZXqQl4gX4GHFtzkQDMqtZsj/Ot7RJ9dmjrXU1N6tz6Qjc+7NdpfvG1L6hTSa9pHN8D6JibZ59OkbuxtNo/U3O2pquvznoQCp8AovXOnNHBPcunFA0hLErnhMjCmthXnjIQNuhqFku4bGDmco+a/ZvCrRKbrKj0aWyokka8fGvc1YJ95DUpelQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAnDE8soC7FBlRPHbLRoPkxMVi50g+xBLTQN56FDxTQ=;
 b=c/HzOhJsO0me1GLuNhUvsmIR53EJ71CDTSUBkdOdyVBmiC+IxyPrrStDwPc93jv65CPAdpMU66wKsNEz8izuqR6cVkmXoOJKmD3jFGkimH4hqo7thonA3Q7Wnm2SVcBFUtppVNIveG4Q69ZZ+JPl2F8IRw9yZzo640ICPXp6ynXDO1/DfTfVxrXhC+scNxmo2dLwMh4l6ZRYOyPFwjjiw/VnMBMSnhRZwyvpzGGs9z6ssNnWZ8DfXqXaleXu2BnbtsztRRXhZja4YdlESuicQuoOPRUWvhmQn41e+J5DptTCpVlG5XMye1SDolvaCl7OnqLrZcHmMqhmIjDz135wYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY5PR11MB6188.namprd11.prod.outlook.com (2603:10b6:930:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 3 Jun
 2024 07:28:11 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 07:28:11 +0000
Date: Mon, 3 Jun 2024 15:27:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Zhang Qiao <zhangqiao22@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <zhangqiao22@huawei.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] sched/numa: Correct NUMA imbalance calculation
Message-ID: <202406031516.a1956bdc-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240524035438.2701479-1-zhangqiao22@huawei.com>
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY5PR11MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: 072c31c5-33cf-44f9-bd6f-08dc839eb8cc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?mt9hTUQhkABhU3XCd2ZAEfHaR7eBUzRuY4ZDot/KtPKSEuyzX4PWcIwzCo?=
 =?iso-8859-1?Q?F0dKomfKhJy1YUC5T6snth5ATJFcz80aeYhCvshGnGQppdCASKbuKhLT5L?=
 =?iso-8859-1?Q?xSMA44ga/4HKcK/H7BRE3xobA8ls0RUM4HJbWknBZrq0Oo78ju15OGF46+?=
 =?iso-8859-1?Q?MEObhfq/ETTD/SUlIEL7dSduPeHLfDnSpfqzAvFS8uNEJlEF2ykdNkD9pM?=
 =?iso-8859-1?Q?N6R2YhUuAqBIjCGIAiYkBRWV0H0ZyqnYsBMPzMLFgLpD8HBpM8eKh8ZxoX?=
 =?iso-8859-1?Q?/RBjS8U7D/1BJarlTLI1y1n6tfUvsQywH6ykRQhhsb1NTbgMB68fGj0dfY?=
 =?iso-8859-1?Q?gjFk897q213i/HbAArfHidAmyBKsA046ejgDgu4WdBcVoe1CB1XqOfzSBD?=
 =?iso-8859-1?Q?6O7yc3VXyCKtJmQ/Z3cLh/YjL1rMatL9XYwvfaS4jeLwzA1XIdZ89Zw7/3?=
 =?iso-8859-1?Q?fkrtyK86to3/sYkiuLhiqHF4y3/tu5hMhORgJhjLZ6zdCc/8HMQYE/B53X?=
 =?iso-8859-1?Q?usj3o9xeUKyM4Nd/b/JMcGYD6dhcASu9qSIVvTq12xUb83FIc/1kEKXbfD?=
 =?iso-8859-1?Q?g0n8LKuyHoCjpYPQg1ud0zuxyEVwwPV6ZoPTH51o1yj7HbJ/+w5qz8w81q?=
 =?iso-8859-1?Q?QoXLImRgaUY7rFYXReDDHB+gjPCvuzAUy3aJRwBI7XK0g3YciE46PbWnt9?=
 =?iso-8859-1?Q?YS3oh07QDBOuQu79pm4VN+J87XTxC3hM3s1BQcuN7R2aofPmLJh2q4ICKk?=
 =?iso-8859-1?Q?kzZJJQ3k53TDd3C3BxoFzPotcd2eyOSEDPHNRUope2CuV3CfxFH/+d0yE7?=
 =?iso-8859-1?Q?7t5RxcRQxey9jx7Wru3szHapuZ2D3Ia16pWU/kEhqzM2050FTgsN6KD33S?=
 =?iso-8859-1?Q?J/Kds3tjnyLOD+pK/LlpMmepwTOvBAmd6Cl9dQZzwEGdDdU4qysKmyYGv4?=
 =?iso-8859-1?Q?+3QyF4zX7Gg24uT3bcw3cmuIJOUkk/hJWbMbatjI8UQI+cdJS4Cgw8JvzA?=
 =?iso-8859-1?Q?AY3I1FLl4GUPY/bf3JhdZC4TizGDsYr1reO2lFbsjRHhQRCX8SPt2RjL2G?=
 =?iso-8859-1?Q?66FRDwE3vIOOLagImMqMa2CNlt/Gj2Tt/nNKHSnb5al/2HRtGVde+8TM/Z?=
 =?iso-8859-1?Q?iK+LAvsNCo09ilTFzKdY3L2eX7Jjhi4dLidpjzplD/aMABd+1ZnmAJhjX0?=
 =?iso-8859-1?Q?uB9U20rM/nMTX5NWX93giWkJxhWijEHGASY4whrnPHNthwtAO3prMVXDVp?=
 =?iso-8859-1?Q?e9jbkg6PaIiFvBppX80A/f5V0Q3L9u8/4JllyfPvk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?j29HsKOqI74SBQBzvsmlev6REazMzLDZ5wp/n1e2jtEuXzYDkzgDmnbhha?=
 =?iso-8859-1?Q?9FuQjJqwg01cozjOegO6BlQnMsQmrLqsLuy20TTDgZ4GbHUIukKLYVYEYl?=
 =?iso-8859-1?Q?bQBV5RFb7vuAkSlY4Cj6wiD3PK8pH/olIxKkJrECmmOgFGdhRoZOUK1Ia2?=
 =?iso-8859-1?Q?tvPYfSSm/iZmeE9QERky6dp1BbpiSiuXRABhsbVhty7yFf9Y8iLIkknkTy?=
 =?iso-8859-1?Q?fTFHRqQ9o/8S/RAv95My2dHllCR81FdY0pGTaHl0x1K+CRbUms/5CxJ97H?=
 =?iso-8859-1?Q?81zFc8f9ucMMslPVbo6/SA/yQWP39HZmkjleOTSHaRctJFcwK8jsRYijhP?=
 =?iso-8859-1?Q?+ObdmvLrrWAGb2ckZhfswA/85/pnfSglzN9LoXa14LEDILk9N/Wh850vB3?=
 =?iso-8859-1?Q?4F06ExyuD7WLN/uzNpWdey/Sj+tuo+3rJYNlFl8iFNQO2jc+AiDaQMPEND?=
 =?iso-8859-1?Q?/tp/DRTwafbkok4CTPfW64YdGmla3pxKCEmr0PuTQ/7JGFHXCHpQLoMF5+?=
 =?iso-8859-1?Q?fbQhgDVP9Mf0JbOpFg6sgnpchEp2r5ANTvWWGLODGyFCNCH4pfdu+gZ9as?=
 =?iso-8859-1?Q?WY0pDMzFv9kdgzmIn01xt+B7rsEQxzUF69vApCPd5kXOpIPdv8K30sdRh3?=
 =?iso-8859-1?Q?mny2FfNSDzoWKi3Spol12GlLbo4QjHg57DIj1ruPFpiDt1rkD46uCO5Obb?=
 =?iso-8859-1?Q?2DWkUYBMccu4RMoWxRUtHL3erzevNW3lR6lyNl8O2TXyNllVb+BL/bBjW/?=
 =?iso-8859-1?Q?KNLP8XPu80jO8Z9UA0FSWKGXhvhLFaSz7K+7D9cKcHjabFStGRCBaxUxz4?=
 =?iso-8859-1?Q?dkTpLPDmskaMzZXGRDRbZKaI7gQf9nrPvEJNs4imVNaxqDzWmlWSdtAFDn?=
 =?iso-8859-1?Q?XStvohrWxCQpI3Ikxs3lUQ8u/2Z7+1SlVbRDaHPscKItsdmG8flsI+blxx?=
 =?iso-8859-1?Q?Vxmmx/yDFf5BevrX9MHlOYHV+OUpO6DASh64IjKR1eJqWLdwxsB9IqVbi0?=
 =?iso-8859-1?Q?n7SdYG6gvrQtWGdpCBI5tw9b0SZu01hcbBBJhzniFsyh/Kf36eflbi1ozg?=
 =?iso-8859-1?Q?j3oh+qJ64jkN99tfGL4rXncyR7Mp0oAnZ17t6uV41Wtx7TkhWV/dMHrE66?=
 =?iso-8859-1?Q?SizpVUr9jk+qSm4essLrbcj6w6kLj6ncOJMo1Ul1ldnY/B14IlbQOul5E0?=
 =?iso-8859-1?Q?OaPXX0Q+hvmPWCS9+75bPbOIwYBTSgDalTZZ4bjpa2CvcdsryJCq9v9KeU?=
 =?iso-8859-1?Q?M+OeWDJV8Pv17R+xjYXnPJsRnoLrfJlCYwIQn8gx22Mvnk9kZKjARbSSz/?=
 =?iso-8859-1?Q?wQ6GjLnXtyoFBTkEpNumhrHMzX+HvGQvNYMppXsrJ3/o//XNyFpix0YIj0?=
 =?iso-8859-1?Q?GJ1NYlL1PaekoD+pohJWZYfoDU8fisKe5Uy2MCA8Ixop/oY1h48iDmmmKL?=
 =?iso-8859-1?Q?VyzsTxkiPoG/kghFgphJi/NO5sCX9EdO187q3USlUZ5lMQn2a08V7HqKps?=
 =?iso-8859-1?Q?qksqvGcbEDMp1TbWc2rek9Rw9ZMieA6qxDjsbFJP4Xc3nYQ1DydZRvP6gs?=
 =?iso-8859-1?Q?BKY6wR5FT+qlKDjWwybhyiHdHCkDILFa/W3qSZjzc/Ba8BQkvfxgUqnr4l?=
 =?iso-8859-1?Q?9aIrYhBEmQWrBm3CsyAyeMMdba02TSycHKn23mf1QdJ1euEmVanr4anA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 072c31c5-33cf-44f9-bd6f-08dc839eb8cc
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 07:28:11.2377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WlNhe8y8CP4JbWOWRepxO804cFX5Oj4KdAn3QuIljKK20PPK/9Yz5op8PaHv82ue6QNHCrjb/WRe8tEK7L8ijg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6188
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -40.4% regression of unixbench.throughput on:


commit: 6efc66e7c7874a28529068c203fdb7c1be61036a ("[PATCH] sched/numa: Correct NUMA imbalance calculation")
url: https://github.com/intel-lab-lkp/linux/commits/Zhang-Qiao/sched-numa-Correct-NUMA-imbalance-calculation/20240524-120507
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 97450eb909658573dcacc1063b06d3d08642c0c1
patch link: https://lore.kernel.org/all/20240524035438.2701479-1-zhangqiao22@huawei.com/
patch subject: [PATCH] sched/numa: Correct NUMA imbalance calculation

testcase: unixbench
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
parameters:

	runtime: 300s
	nr_task: 100%
	test: fsdisk-w
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | unixbench: unixbench.throughput -6.8% regression                                                   |
| test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory        |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | nr_task=100%                                                                                       |
|                  | runtime=300s                                                                                       |
|                  | test=fstime                                                                                        |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | unixbench: unixbench.throughput -26.7% regression                                                  |
| test machine     | 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | nr_task=100%                                                                                       |
|                  | runtime=300s                                                                                       |
|                  | test=fsdisk-w                                                                                      |
+------------------+----------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406031516.a1956bdc-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240603/202406031516.a1956bdc-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/300s/lkp-spr-2sp4/fsdisk-w/unixbench

commit: 
  97450eb909 ("sched/pelt: Remove shift of thermal clock")
  6efc66e7c7 ("sched/numa: Correct NUMA imbalance calculation")

97450eb909658573 6efc66e7c7874a28529068c203f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   3120812 ± 38%     -25.8%    2315045 ±  2%  numa-meminfo.node1.MemUsed
     58215 ± 82%    +136.7%     137820 ± 40%  numa-numastat.node1.other_node
     58215 ± 82%    +136.7%     137820 ± 40%  numa-vmstat.node1.numa_other
    179.17 ±  6%     -35.8%     115.00 ±  6%  perf-c2c.DRAM.remote
    110.00 ±  8%     -37.6%      68.67 ± 13%  perf-c2c.HITM.remote
     40561            +1.7%      41238        proc-vmstat.nr_slab_reclaimable
     42171 ±  3%     +19.1%      50238 ±  9%  proc-vmstat.pgactivate
      0.72 ±  2%      -0.2        0.50        mpstat.cpu.all.irq%
      0.02            +0.0        0.02 ±  2%  mpstat.cpu.all.soft%
      1.96            -0.2        1.72        mpstat.cpu.all.usr%
    179.76           -40.5%     106.88 ±  4%  sched_debug.cfs_rq:/.util_est.avg
    490.36 ±  8%     -22.9%     377.95 ±  5%  sched_debug.cfs_rq:/.util_est.max
      1.60 ± 95%   +1152.2%      19.98 ± 34%  sched_debug.cfs_rq:/.util_est.min
 3.065e+08           -40.4%  1.828e+08 ±  4%  unixbench.throughput
    279695            +2.2%     285832        unixbench.time.involuntary_context_switches
      1556           -12.8%       1356        unixbench.time.user_time
 1.138e+11           -40.4%  6.781e+10 ±  4%  unixbench.workload
      6.70 ±  4%     -72.5%       1.84 ± 18%  perf-stat.i.MPKI
 2.183e+10           -42.2%  1.261e+10 ±  5%  perf-stat.i.branch-instructions
     67.36           -25.8       41.57 ±  7%  perf-stat.i.cache-miss-rate%
 7.876e+08 ±  3%     -85.5%  1.139e+08 ± 32%  perf-stat.i.cache-misses
 9.921e+08 ±  3%     -79.6%  2.024e+08 ± 22%  perf-stat.i.cache-references
      2352            +1.5%       2389        perf-stat.i.context-switches
      4.30           +72.0%       7.40 ±  4%  perf-stat.i.cpi
 5.124e+11            +1.0%  5.174e+11        perf-stat.i.cpu-cycles
    264.94            -2.5%     258.31        perf-stat.i.cpu-migrations
    805.75 ±  2%    +906.4%       8109 ± 20%  perf-stat.i.cycles-between-cache-misses
 1.066e+11           -42.2%  6.159e+10 ±  5%  perf-stat.i.instructions
      0.28           -21.7%       0.22 ±  3%  perf-stat.i.ipc
      0.17 ± 32%     -48.9%       0.09 ± 16%  perf-stat.i.major-faults
      7.45 ±  4%     -75.8%       1.81 ± 26%  perf-stat.overall.MPKI
     79.47           -24.5       55.01 ±  9%  perf-stat.overall.cache-miss-rate%
      4.82           +75.2%       8.44 ±  5%  perf-stat.overall.cpi
    647.78 ±  3%    +679.6%       5049 ± 29%  perf-stat.overall.cycles-between-cache-misses
      0.21           -42.8%       0.12 ±  4%  perf-stat.overall.ipc
    350.17            -2.7%     340.75        perf-stat.overall.path-length
 2.191e+10           -42.0%   1.27e+10 ±  4%  perf-stat.ps.branch-instructions
  7.97e+08 ±  3%     -85.8%  1.133e+08 ± 30%  perf-stat.ps.cache-misses
 1.003e+09 ±  3%     -79.8%   2.02e+08 ± 21%  perf-stat.ps.cache-references
 5.155e+11            +1.4%  5.225e+11        perf-stat.ps.cpu-cycles
    259.95            -2.6%     253.24        perf-stat.ps.cpu-migrations
  1.07e+11           -42.0%  6.204e+10 ±  4%  perf-stat.ps.instructions
      0.17 ± 33%     -49.5%       0.09 ± 17%  perf-stat.ps.major-faults
 3.984e+13           -42.0%  2.311e+13 ±  5%  perf-stat.total.instructions
     53.92            -1.2       52.69        perf-profile.calltrace.cycles-pp.folio_unlock.simple_write_end.generic_perform_write.generic_file_write_iter.vfs_write
      1.63 ±  2%      -1.0        0.60 ± 61%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      1.38 ±  2%      -0.5        0.90 ± 14%  perf-profile.calltrace.cycles-pp.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
      4.98            -0.4        4.56 ±  6%  perf-profile.calltrace.cycles-pp.simple_write_begin.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      0.84 ±  2%      -0.3        0.50 ± 45%  perf-profile.calltrace.cycles-pp.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.generic_file_write_iter.vfs_write
      0.92 ±  2%      -0.3        0.64 ± 10%  perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      1.00 ±  2%      +0.1        1.09 ±  3%  perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.89 ±  2%      +0.1        1.02 ±  2%  perf-profile.calltrace.cycles-pp.security_file_permission.rw_verify_area.vfs_write.ksys_write.do_syscall_64
      0.78 ±  2%      +0.2        0.94        perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify_area.vfs_write.ksys_write
      2.48            +0.3        2.74        perf-profile.calltrace.cycles-pp.folio_mark_dirty.simple_write_end.generic_perform_write.generic_file_write_iter.vfs_write
     98.96            +0.4       99.37        perf-profile.calltrace.cycles-pp.write
     96.59            +0.5       97.10        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     96.42            +0.6       96.99        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     95.83            +0.6       96.47        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     95.24            +0.8       96.03        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     92.78            +1.2       93.98        perf-profile.calltrace.cycles-pp.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.30 ±  8%      +1.6        2.90 ±  9%  perf-profile.calltrace.cycles-pp.down_write.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
     21.91            +1.6       23.52        perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
     53.97            -1.2       52.73        perf-profile.children.cycles-pp.folio_unlock
      1.41 ±  2%      -0.5        0.92 ± 14%  perf-profile.children.cycles-pp.__generic_file_write_iter
      1.09 ±  7%      -0.4        0.64 ±  5%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.02 ±  8%      -0.4        0.58 ±  6%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      5.00            -0.4        4.57 ±  6%  perf-profile.children.cycles-pp.simple_write_begin
      1.00 ±  8%      -0.4        0.57 ±  6%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.85 ±  9%      -0.4        0.45 ±  5%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      4.90            -0.4        4.50 ±  6%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.80 ±  9%      -0.4        0.43 ±  5%  perf-profile.children.cycles-pp.tick_nohz_handler
      1.21 ±  6%      -0.4        0.84 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.93 ±  2%      -0.3        0.58 ± 14%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.75 ±  9%      -0.3        0.41 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.80 ±  3%      -0.3        0.50 ± 15%  perf-profile.children.cycles-pp.file_remove_privs_flags
      0.99 ±  3%      -0.3        0.71 ±  9%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.91 ±  2%      -0.3        0.66 ±  9%  perf-profile.children.cycles-pp.fault_in_readable
      0.50 ±  9%      -0.2        0.30 ±  2%  perf-profile.children.cycles-pp.sched_tick
      0.50 ±  2%      -0.2        0.30 ± 17%  perf-profile.children.cycles-pp.__cond_resched
      0.59 ±  2%      -0.2        0.40 ± 12%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.50 ±  3%      -0.2        0.31 ± 14%  perf-profile.children.cycles-pp.security_inode_need_killpriv
      0.49 ±  2%      -0.2        0.30 ± 16%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.42 ±  2%      -0.2        0.26 ± 15%  perf-profile.children.cycles-pp.cap_inode_need_killpriv
      0.50 ±  3%      -0.1        0.35 ± 13%  perf-profile.children.cycles-pp.file_update_time
      0.38 ±  3%      -0.1        0.24 ± 14%  perf-profile.children.cycles-pp.__vfs_getxattr
      0.34            -0.1        0.22 ± 13%  perf-profile.children.cycles-pp.up_write
      0.28            -0.1        0.16 ± 15%  perf-profile.children.cycles-pp.rcu_all_qs
      0.42 ±  3%      -0.1        0.31 ± 13%  perf-profile.children.cycles-pp.inode_needs_update_time
      0.42 ±  3%      -0.1        0.32 ±  2%  perf-profile.children.cycles-pp.__fdget_pos
      0.26            -0.1        0.16 ± 15%  perf-profile.children.cycles-pp.generic_write_checks
      0.28 ±  8%      -0.1        0.20 ±  3%  perf-profile.children.cycles-pp.task_tick_fair
      0.16 ±  3%      -0.1        0.10 ± 16%  perf-profile.children.cycles-pp.strcmp
      0.16 ±  3%      -0.1        0.10 ± 16%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.32 ±  2%      -0.1        0.27 ±  6%  perf-profile.children.cycles-pp.folio_mapping
      0.14 ±  3%      -0.1        0.08 ± 17%  perf-profile.children.cycles-pp.folio_wait_stable
      0.13 ±  2%      -0.1        0.08 ± 14%  perf-profile.children.cycles-pp.timestamp_truncate
      0.08 ±  5%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.update_load_avg
      0.10 ±  4%      -0.0        0.05 ± 45%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.12            -0.0        0.08 ± 12%  perf-profile.children.cycles-pp.xattr_resolve_name
      0.35 ±  2%      -0.0        0.30 ±  2%  perf-profile.children.cycles-pp.w_test
      0.14 ±  2%      -0.0        0.10 ± 11%  perf-profile.children.cycles-pp.aa_file_perm
      0.12 ±  4%      -0.0        0.08 ± 12%  perf-profile.children.cycles-pp.generic_write_check_limits
      0.14 ±  3%      -0.0        0.10 ± 14%  perf-profile.children.cycles-pp.xas_start
      0.08 ±  5%      -0.0        0.05 ± 46%  perf-profile.children.cycles-pp.setattr_should_drop_suidgid
      0.07            -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.inode_to_bdi
      0.43            +0.0        0.45        perf-profile.children.cycles-pp.noop_dirty_folio
      0.33 ±  3%      +0.0        0.36 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.06 ±  7%      +0.0        0.10 ± 12%  perf-profile.children.cycles-pp.task_work_run
      0.06            +0.0        0.09 ± 11%  perf-profile.children.cycles-pp.task_mm_cid_work
      0.62 ±  2%      +0.1        0.71 ±  2%  perf-profile.children.cycles-pp.write@plt
      1.03 ±  2%      +0.1        1.11 ±  2%  perf-profile.children.cycles-pp.rw_verify_area
      0.93 ±  2%      +0.1        1.05 ±  2%  perf-profile.children.cycles-pp.security_file_permission
      0.81 ±  2%      +0.2        0.96 ±  2%  perf-profile.children.cycles-pp.apparmor_file_permission
      2.02            +0.2        2.26        perf-profile.children.cycles-pp.folio_mark_dirty
     96.98            +0.5       97.50        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     96.84            +0.6       97.41        perf-profile.children.cycles-pp.do_syscall_64
     96.15            +0.6       96.78        perf-profile.children.cycles-pp.ksys_write
     95.58            +0.8       96.36        perf-profile.children.cycles-pp.vfs_write
     92.85            +1.2       94.02        perf-profile.children.cycles-pp.generic_file_write_iter
      1.32 ±  8%      +1.6        2.92 ±  9%  perf-profile.children.cycles-pp.down_write
     22.10            +1.7       23.77        perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.87            -0.3        0.56 ± 12%  perf-profile.self.cycles-pp.write
      0.77            -0.3        0.51 ± 12%  perf-profile.self.cycles-pp.vfs_write
      0.88 ±  2%      -0.2        0.64 ±  9%  perf-profile.self.cycles-pp.fault_in_readable
      0.63 ±  2%      -0.2        0.39 ± 16%  perf-profile.self.cycles-pp.__filemap_get_folio
      0.57 ±  2%      -0.2        0.39 ± 12%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.48 ±  2%      -0.2        0.30 ± 15%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.32            -0.1        0.22 ± 12%  perf-profile.self.cycles-pp.up_write
      0.27 ±  2%      -0.1        0.16 ± 19%  perf-profile.self.cycles-pp.__cond_resched
      0.40 ±  3%      -0.1        0.31 ±  3%  perf-profile.self.cycles-pp.__fdget_pos
      0.22 ±  3%      -0.1        0.14 ± 15%  perf-profile.self.cycles-pp.file_remove_privs_flags
      0.19 ±  2%      -0.1        0.11 ± 17%  perf-profile.self.cycles-pp.inode_needs_update_time
      0.21 ±  3%      -0.1        0.13 ± 15%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.20 ±  2%      -0.1        0.13 ± 16%  perf-profile.self.cycles-pp.generic_file_write_iter
      0.17 ±  2%      -0.1        0.10 ± 15%  perf-profile.self.cycles-pp.rcu_all_qs
      0.19 ±  4%      -0.1        0.13 ±  9%  perf-profile.self.cycles-pp.folio_mapping
      0.16 ±  3%      -0.1        0.10 ± 16%  perf-profile.self.cycles-pp.__vfs_getxattr
      0.16 ±  3%      -0.1        0.10 ± 16%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.25            -0.1        0.19 ±  7%  perf-profile.self.cycles-pp.do_syscall_64
      0.15 ±  3%      -0.1        0.09 ± 14%  perf-profile.self.cycles-pp.generic_write_checks
      0.16 ±  3%      -0.1        0.10 ± 16%  perf-profile.self.cycles-pp.ksys_write
      0.12 ±  3%      -0.1        0.07 ± 12%  perf-profile.self.cycles-pp.__generic_file_write_iter
      0.08 ±  4%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.file_update_time
      0.07 ±  5%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.setattr_should_drop_suidgid
      0.10 ±  5%      -0.0        0.05 ± 45%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.12 ±  4%      -0.0        0.08 ± 12%  perf-profile.self.cycles-pp.strcmp
      0.10 ±  5%      -0.0        0.06 ± 46%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.11 ±  4%      -0.0        0.07 ± 16%  perf-profile.self.cycles-pp.simple_write_begin
      0.08 ±  6%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.fault_in_iov_iter_readable
      0.10 ±  4%      -0.0        0.06 ± 14%  perf-profile.self.cycles-pp.timestamp_truncate
      0.14 ±  3%      -0.0        0.10 ± 11%  perf-profile.self.cycles-pp.security_file_permission
      0.25            -0.0        0.21 ±  7%  perf-profile.self.cycles-pp.xas_load
      0.09 ±  4%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.10 ±  4%      -0.0        0.06 ± 14%  perf-profile.self.cycles-pp.rw_verify_area
      0.08            -0.0        0.05 ± 47%  perf-profile.self.cycles-pp.security_inode_need_killpriv
      0.12 ±  4%      -0.0        0.09 ± 13%  perf-profile.self.cycles-pp.aa_file_perm
      0.10 ±  5%      -0.0        0.06 ± 14%  perf-profile.self.cycles-pp.generic_write_check_limits
      0.13 ±  4%      -0.0        0.10 ± 12%  perf-profile.self.cycles-pp.xas_start
      0.27 ±  2%      -0.0        0.24 ±  4%  perf-profile.self.cycles-pp.w_test
      0.13 ±  5%      +0.0        0.15 ±  4%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.40            +0.0        0.43        perf-profile.self.cycles-pp.noop_dirty_folio
      0.33 ±  3%      +0.0        0.36 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.06            +0.0        0.09 ± 14%  perf-profile.self.cycles-pp.task_mm_cid_work
      0.58 ±  2%      +0.1        0.68 ±  3%  perf-profile.self.cycles-pp.write@plt
      0.64 ±  3%      +0.2        0.84        perf-profile.self.cycles-pp.apparmor_file_permission
      1.28            +0.2        1.52 ±  2%  perf-profile.self.cycles-pp.folio_mark_dirty
      4.44            +0.5        4.92        perf-profile.self.cycles-pp.simple_write_end
      1.19 ±  9%      +1.6        2.83 ±  9%  perf-profile.self.cycles-pp.down_write
     21.84            +1.8       23.60        perf-profile.self.cycles-pp.copy_page_from_iter_atomic


***************************************************************************************************
lkp-spr-r02: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/300s/lkp-spr-r02/fstime/unixbench

commit: 
  97450eb909 ("sched/pelt: Remove shift of thermal clock")
  6efc66e7c7 ("sched/numa: Correct NUMA imbalance calculation")

97450eb909658573 6efc66e7c7874a28529068c203f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      4.45            -0.4        4.03        mpstat.cpu.all.usr%
     47683 ± 23%     -33.9%      31506 ± 46%  numa-meminfo.node0.Mapped
     62853 ±  3%     -39.3%      38178 ±  6%  perf-c2c.DRAM.local
      4308 ± 74%    +376.5%      20527 ± 10%  perf-c2c.DRAM.remote
      1655 ±  8%     -34.1%       1091 ±  6%  perf-c2c.HITM.local
    213.56 ± 31%     +75.8%     375.35 ± 16%  sched_debug.cfs_rq:/.util_est.min
     22805 ± 14%     +59.1%      36281 ± 32%  sched_debug.cpu.nr_switches.max
      2625 ±  5%     +34.2%       3523 ± 20%  sched_debug.cpu.nr_switches.stddev
    376936            -6.8%     351324        unixbench.score
 1.493e+08            -6.8%  1.391e+08        unixbench.throughput
      4712            -9.6%       4261        unixbench.time.user_time
 7.182e+10            -6.8%  6.694e+10        unixbench.workload
      6.15            -8.6%       5.63        perf-stat.i.MPKI
 6.874e+10            -8.3%    6.3e+10        perf-stat.i.branch-instructions
     54.38            -1.4       52.98        perf-stat.i.cache-miss-rate%
 2.564e+09           -16.1%  2.153e+09        perf-stat.i.cache-misses
 3.729e+09           -14.6%  3.186e+09        perf-stat.i.cache-references
      1.42            +5.6%       1.50        perf-stat.i.cpi
 4.125e+11            +1.7%  4.193e+11        perf-stat.i.cpu-cycles
    503.97 ±  5%     +10.4%     556.41 ±  3%  perf-stat.i.cycles-between-cache-misses
 3.482e+11            -8.3%  3.193e+11        perf-stat.i.instructions
      0.80            -7.8%       0.74        perf-stat.i.ipc
      2.13           -52.7%       1.01 ±100%  perf-stat.i.metric.K/sec
      7.38            -8.5%       6.75        perf-stat.overall.MPKI
     68.88            -1.2       67.67        perf-stat.overall.cache-miss-rate%
      1.19           +10.8%       1.31        perf-stat.overall.cpi
    160.68           +21.2%     194.69        perf-stat.overall.cycles-between-cache-misses
      0.84            -9.8%       0.76        perf-stat.overall.ipc
      2332            -1.2%       2304        perf-stat.overall.path-length
 6.859e+10            -8.0%  6.309e+10        perf-stat.ps.branch-instructions
 2.563e+09           -15.8%  2.158e+09        perf-stat.ps.cache-misses
 3.721e+09           -14.3%  3.189e+09        perf-stat.ps.cache-references
 4.119e+11            +2.0%  4.202e+11        perf-stat.ps.cpu-cycles
 3.474e+11            -8.0%  3.198e+11        perf-stat.ps.instructions
 1.675e+14            -7.9%  1.542e+14        perf-stat.total.instructions
      4.41            -1.4        2.98        perf-profile.calltrace.cycles-pp.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
      6.21            -1.3        4.89        perf-profile.calltrace.cycles-pp.simple_write_begin.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      5.80            -1.2        4.60        perf-profile.calltrace.cycles-pp.__filemap_get_folio.simple_write_begin.generic_perform_write.generic_file_write_iter.vfs_write
      4.62            -1.2        3.46        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      3.83            -1.0        2.86        perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
     47.48            -0.9       46.54        perf-profile.calltrace.cycles-pp.read
      2.54            -0.8        1.70        perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      2.53            -0.8        1.71        perf-profile.calltrace.cycles-pp.file_remove_privs_flags.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write
      2.22            -0.7        1.49        perf-profile.calltrace.cycles-pp.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.generic_file_write_iter.vfs_write
      6.80            -0.6        6.20        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
      1.71            -0.5        1.18        perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.56            -0.5        1.06        perf-profile.calltrace.cycles-pp.security_inode_need_killpriv.file_remove_privs_flags.__generic_file_write_iter.generic_file_write_iter.vfs_write
      3.30            -0.5        2.82 ±  3%  perf-profile.calltrace.cycles-pp.filemap_get_entry.__filemap_get_folio.simple_write_begin.generic_perform_write.generic_file_write_iter
      1.34            -0.4        0.91        perf-profile.calltrace.cycles-pp.file_update_time.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write
     41.64            -0.4       41.22        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      1.30            -0.4        0.88        perf-profile.calltrace.cycles-pp.cap_inode_need_killpriv.security_inode_need_killpriv.file_remove_privs_flags.__generic_file_write_iter.generic_file_write_iter
      1.34            -0.4        0.93        perf-profile.calltrace.cycles-pp.security_file_permission.rw_verify_area.vfs_write.ksys_write.do_syscall_64
      1.44            -0.4        1.06        perf-profile.calltrace.cycles-pp.__fsnotify_parent.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     40.93            -0.4       40.57        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.96            -0.4        3.61        perf-profile.calltrace.cycles-pp.__fsnotify_parent.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.08            -0.3        0.74        perf-profile.calltrace.cycles-pp.inode_needs_update_time.file_update_time.__generic_file_write_iter.generic_file_write_iter.vfs_write
      1.00            -0.3        0.68        perf-profile.calltrace.cycles-pp.__vfs_getxattr.cap_inode_need_killpriv.security_inode_need_killpriv.file_remove_privs_flags.__generic_file_write_iter
      1.02            -0.3        0.71        perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify_area.vfs_write.ksys_write
      1.11 ±  2%      -0.3        0.81        perf-profile.calltrace.cycles-pp.xas_load.filemap_get_entry.__filemap_get_folio.simple_write_begin.generic_perform_write
      2.56            -0.3        2.30        perf-profile.calltrace.cycles-pp.touch_atime.filemap_read.vfs_read.ksys_read.do_syscall_64
      0.82            -0.2        0.59 ±  2%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      2.15            -0.2        1.93        perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.filemap_read.vfs_read.ksys_read
      2.36            -0.2        2.16        perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.80            -0.2        0.62        perf-profile.calltrace.cycles-pp.up_write.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
      1.06            -0.1        0.91 ±  2%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.61            -0.1        1.49        perf-profile.calltrace.cycles-pp.security_file_permission.rw_verify_area.vfs_read.ksys_read.do_syscall_64
      1.49            -0.1        1.38        perf-profile.calltrace.cycles-pp.xas_load.filemap_get_read_batch.filemap_get_pages.filemap_read.vfs_read
      0.86            -0.1        0.79        perf-profile.calltrace.cycles-pp.current_time.atime_needs_update.touch_atime.filemap_read.vfs_read
      1.18            -0.1        1.10 ±  2%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify_area.vfs_read.ksys_read
      0.65            -0.0        0.61        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.56            -0.0        0.52        perf-profile.calltrace.cycles-pp.xas_descend.xas_load.filemap_get_read_batch.filemap_get_pages.filemap_read
      1.17            +0.1        1.25        perf-profile.calltrace.cycles-pp.down_write.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
     27.64            +0.9       28.51        perf-profile.calltrace.cycles-pp.filemap_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     49.34            +1.2       50.51        perf-profile.calltrace.cycles-pp.write
     13.49            +1.6       15.07        perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.vfs_read.ksys_read.do_syscall_64
     12.82            +1.6       14.45        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.filemap_read.vfs_read.ksys_read
     45.11            +2.4       47.49        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     44.56            +2.5       47.10        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     43.08            +3.1       46.14        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     41.63            +3.5       45.11        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     35.65            +5.3       40.93        perf-profile.calltrace.cycles-pp.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     27.63            +7.3       34.92        perf-profile.calltrace.cycles-pp.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
     12.84 ±  3%     +11.1       23.94        perf-profile.calltrace.cycles-pp.simple_write_end.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
     11.12 ±  4%     +11.5       22.65        perf-profile.calltrace.cycles-pp.folio_unlock.simple_write_end.generic_perform_write.generic_file_write_iter.vfs_write
      4.53            -1.5        3.06        perf-profile.children.cycles-pp.__generic_file_write_iter
      6.28            -1.3        4.94        perf-profile.children.cycles-pp.simple_write_begin
      5.95            -1.2        4.71        perf-profile.children.cycles-pp.__filemap_get_folio
     48.70            -1.0       47.66        perf-profile.children.cycles-pp.read
      6.39            -1.0        5.41        perf-profile.children.cycles-pp.entry_SYSCALL_64
      3.90            -1.0        2.93        perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      2.66            -0.9        1.79        perf-profile.children.cycles-pp.file_remove_privs_flags
      2.65            -0.9        1.79        perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      4.27            -0.8        3.50        perf-profile.children.cycles-pp.rw_verify_area
      2.34            -0.7        1.59        perf-profile.children.cycles-pp.fault_in_readable
      5.51            -0.7        4.77        perf-profile.children.cycles-pp.__fsnotify_parent
      3.53            -0.6        2.89        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      3.27            -0.6        2.68        perf-profile.children.cycles-pp.security_file_permission
      2.11            -0.5        1.58        perf-profile.children.cycles-pp.__cond_resched
      1.64            -0.5        1.12        perf-profile.children.cycles-pp.security_inode_need_killpriv
      3.38            -0.5        2.88 ±  3%  perf-profile.children.cycles-pp.filemap_get_entry
      3.00            -0.5        2.52        perf-profile.children.cycles-pp.xas_load
      1.46            -0.5        1.00        perf-profile.children.cycles-pp.file_update_time
      1.66 ± 16%      -0.5        1.19 ±  7%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.72 ± 16%      -0.4        1.28 ±  7%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.53 ± 17%      -0.4        1.08 ±  8%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.38            -0.4        0.93        perf-profile.children.cycles-pp.cap_inode_need_killpriv
      1.56 ± 16%      -0.4        1.11 ±  8%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      2.40            -0.4        1.98        perf-profile.children.cycles-pp.apparmor_file_permission
      1.25            -0.4        0.85        perf-profile.children.cycles-pp.__vfs_getxattr
      1.98            -0.4        1.59 ±  2%  perf-profile.children.cycles-pp.__fdget_pos
      1.24            -0.4        0.84        perf-profile.children.cycles-pp.inode_needs_update_time
      1.29 ± 16%      -0.4        0.92 ±  8%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.24 ± 17%      -0.4        0.88 ±  8%  perf-profile.children.cycles-pp.tick_nohz_handler
      1.18 ± 17%      -0.4        0.82 ±  9%  perf-profile.children.cycles-pp.update_process_times
      0.82 ± 19%      -0.3        0.51 ±  9%  perf-profile.children.cycles-pp.sched_tick
      1.19            -0.3        0.88        perf-profile.children.cycles-pp.rcu_all_qs
      1.45            -0.3        1.19        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      2.66            -0.3        2.40        perf-profile.children.cycles-pp.touch_atime
      0.82            -0.3        0.56        perf-profile.children.cycles-pp.generic_write_checks
     39.27            -0.2       39.02        perf-profile.children.cycles-pp.ksys_read
      2.39            -0.2        2.15        perf-profile.children.cycles-pp.atime_needs_update
      0.52 ± 17%      -0.2        0.32 ±  9%  perf-profile.children.cycles-pp.task_tick_fair
      1.22            -0.2        1.02        perf-profile.children.cycles-pp.xas_descend
      0.83            -0.2        0.65        perf-profile.children.cycles-pp.up_write
      0.50            -0.2        0.34        perf-profile.children.cycles-pp.strcmp
      0.88            -0.2        0.72        perf-profile.children.cycles-pp.aa_file_perm
      0.50            -0.1        0.35        perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.46            -0.1        0.33        perf-profile.children.cycles-pp.folio_mapping
      0.46            -0.1        0.33 ±  2%  perf-profile.children.cycles-pp.folio_mark_dirty
      0.41            -0.1        0.28        perf-profile.children.cycles-pp.timestamp_truncate
      0.40            -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.xattr_resolve_name
      0.42            -0.1        0.30        perf-profile.children.cycles-pp.folio_wait_stable
      0.74            -0.1        0.63        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.35            -0.1        0.24        perf-profile.children.cycles-pp.generic_write_check_limits
      0.54 ±  3%      -0.1        0.44        perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.29 ±  3%      -0.1        0.19 ±  2%  perf-profile.children.cycles-pp.setattr_should_drop_suidgid
      0.77 ±  2%      -0.1        0.67 ±  2%  perf-profile.children.cycles-pp.xas_start
      0.98            -0.1        0.89        perf-profile.children.cycles-pp.current_time
      0.19 ± 19%      -0.1        0.11 ±  9%  perf-profile.children.cycles-pp.update_load_avg
      0.21 ±  3%      -0.1        0.13 ±  2%  perf-profile.children.cycles-pp.__x64_sys_write
      0.19 ± 20%      -0.1        0.11 ± 12%  perf-profile.children.cycles-pp.update_curr
      0.24            -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.inode_to_bdi
      0.42            -0.1        0.34        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.52            -0.1        0.45        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.26            -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.amd_clear_divider
      0.64            -0.0        0.60        perf-profile.children.cycles-pp.r_test
      0.13 ±  2%      -0.0        0.09        perf-profile.children.cycles-pp.is_bad_inode
      0.42            -0.0        0.38        perf-profile.children.cycles-pp.generic_file_read_iter
      0.14 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.noop_dirty_folio
      0.43            -0.0        0.40        perf-profile.children.cycles-pp.w_test
      0.08            -0.0        0.05        perf-profile.children.cycles-pp.file_remove_privs
      0.24 ±  2%      -0.0        0.21        perf-profile.children.cycles-pp.make_vfsuid
      0.27            -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.__x64_sys_read
      0.23 ±  2%      -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.make_vfsgid
      0.15 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.write@plt
      0.09 ±  5%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.21 ±  2%      -0.0        0.19        perf-profile.children.cycles-pp.read@plt
      0.11            -0.0        0.10        perf-profile.children.cycles-pp.folio_mark_accessed
      1.24            +0.1        1.30        perf-profile.children.cycles-pp.down_write
     27.98            +0.8       28.81        perf-profile.children.cycles-pp.filemap_read
     50.22            +1.1       51.30        perf-profile.children.cycles-pp.write
     13.66            +1.6       15.22        perf-profile.children.cycles-pp.copy_page_to_iter
     12.88            +1.6       14.52        perf-profile.children.cycles-pp._copy_to_iter
     87.02            +2.0       88.99        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     86.00            +2.1       88.15        perf-profile.children.cycles-pp.do_syscall_64
     43.32            +3.1       46.37        perf-profile.children.cycles-pp.ksys_write
     41.98            +3.4       45.42        perf-profile.children.cycles-pp.vfs_write
     35.87            +5.2       41.08        perf-profile.children.cycles-pp.generic_file_write_iter
     28.02            +7.2       35.24        perf-profile.children.cycles-pp.generic_perform_write
     13.00 ±  3%     +11.0       24.04        perf-profile.children.cycles-pp.simple_write_end
     11.16 ±  4%     +11.5       22.70        perf-profile.children.cycles-pp.folio_unlock
      3.77            -0.9        2.87        perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      2.45            -0.7        1.71        perf-profile.self.cycles-pp.vfs_write
      5.29            -0.7        4.58        perf-profile.self.cycles-pp.__fsnotify_parent
      2.24            -0.7        1.54        perf-profile.self.cycles-pp.fault_in_readable
      3.45            -0.6        2.82        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      2.28            -0.6        1.72        perf-profile.self.cycles-pp.write
      1.80            -0.5        1.31        perf-profile.self.cycles-pp.__filemap_get_folio
      1.40            -0.4        0.99        perf-profile.self.cycles-pp.generic_perform_write
      4.72            -0.4        4.31        perf-profile.self.cycles-pp.filemap_read
      1.84            -0.4        1.48 ±  2%  perf-profile.self.cycles-pp.__fdget_pos
      1.30            -0.3        0.98        perf-profile.self.cycles-pp.simple_write_end
      3.38            -0.3        3.08        perf-profile.self.cycles-pp.read
      2.79            -0.3        2.50        perf-profile.self.cycles-pp.vfs_read
      1.16            -0.3        0.87        perf-profile.self.cycles-pp.__cond_resched
      1.55            -0.3        1.27        perf-profile.self.cycles-pp.do_syscall_64
      0.75 ±  2%      -0.2        0.51        perf-profile.self.cycles-pp.file_remove_privs_flags
      1.38            -0.2        1.15 ±  2%  perf-profile.self.cycles-pp.apparmor_file_permission
      1.18            -0.2        0.97        perf-profile.self.cycles-pp.xas_load
      1.33            -0.2        1.14        perf-profile.self.cycles-pp.entry_SYSCALL_64
      1.11            -0.2        0.91        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.60 ±  2%      -0.2        0.41        perf-profile.self.cycles-pp.inode_needs_update_time
      0.96            -0.2        0.78        perf-profile.self.cycles-pp.security_file_permission
      0.65            -0.2        0.46        perf-profile.self.cycles-pp.generic_file_write_iter
      0.71            -0.2        0.53        perf-profile.self.cycles-pp.rcu_all_qs
      0.99            -0.2        0.82        perf-profile.self.cycles-pp.rw_verify_area
      0.50 ±  2%      -0.2        0.34        perf-profile.self.cycles-pp.__vfs_getxattr
      0.77            -0.2        0.61        perf-profile.self.cycles-pp.up_write
      0.50 ±  2%      -0.1        0.35        perf-profile.self.cycles-pp.ksys_write
      1.00            -0.1        0.86        perf-profile.self.cycles-pp.xas_descend
      0.75            -0.1        0.60        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.47            -0.1        0.34 ±  2%  perf-profile.self.cycles-pp.generic_write_checks
      0.77            -0.1        0.64        perf-profile.self.cycles-pp.aa_file_perm
      0.40            -0.1        0.28        perf-profile.self.cycles-pp.__generic_file_write_iter
      0.37            -0.1        0.25 ±  2%  perf-profile.self.cycles-pp.strcmp
      0.74            -0.1        0.62        perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.06            -0.1        0.95        perf-profile.self.cycles-pp.atime_needs_update
      0.38            -0.1        0.27        perf-profile.self.cycles-pp.folio_mapping
      0.30 ±  2%      -0.1        0.20        perf-profile.self.cycles-pp.fault_in_iov_iter_readable
      0.33            -0.1        0.23 ±  2%  perf-profile.self.cycles-pp.timestamp_truncate
      0.33            -0.1        0.23        perf-profile.self.cycles-pp.simple_write_begin
      0.96            -0.1        0.87        perf-profile.self.cycles-pp.filemap_get_pages
      0.30 ±  2%      -0.1        0.21 ±  2%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.82            -0.1        0.74        perf-profile.self.cycles-pp.copy_page_to_iter
      0.66 ±  2%      -0.1        0.58 ±  2%  perf-profile.self.cycles-pp.xas_start
      0.43 ±  3%      -0.1        0.35 ±  2%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.25 ±  3%      -0.1        0.17 ±  2%  perf-profile.self.cycles-pp.setattr_should_drop_suidgid
      0.25            -0.1        0.17 ±  2%  perf-profile.self.cycles-pp.file_update_time
      0.27 ±  2%      -0.1        0.19        perf-profile.self.cycles-pp.generic_write_check_limits
      0.26 ±  2%      -0.1        0.18 ±  2%  perf-profile.self.cycles-pp.security_inode_need_killpriv
      0.12 ± 28%      -0.1        0.04 ± 45%  perf-profile.self.cycles-pp.sched_tick
      0.23            -0.1        0.16 ±  2%  perf-profile.self.cycles-pp.xattr_resolve_name
      0.14 ± 21%      -0.1        0.07 ± 12%  perf-profile.self.cycles-pp.update_load_avg
      0.16            -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.__x64_sys_write
      0.68            -0.1        0.61        perf-profile.self.cycles-pp.current_time
      0.52            -0.1        0.45        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.66            -0.1        0.60        perf-profile.self.cycles-pp.ksys_read
      0.19            -0.1        0.13 ±  2%  perf-profile.self.cycles-pp.folio_wait_stable
      0.23 ±  2%      -0.1        0.17 ±  2%  perf-profile.self.cycles-pp.folio_mark_dirty
      0.09 ± 23%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.update_curr
      0.33            -0.1        0.28        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.14 ±  3%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.inode_to_bdi
      0.18 ±  2%      -0.0        0.14        perf-profile.self.cycles-pp.amd_clear_divider
      0.12 ±  3%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.cap_inode_need_killpriv
      0.36            -0.0        0.32        perf-profile.self.cycles-pp.generic_file_read_iter
      0.52            -0.0        0.49        perf-profile.self.cycles-pp.r_test
      0.09            -0.0        0.06        perf-profile.self.cycles-pp.is_bad_inode
      0.09 ±  4%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.noop_dirty_folio
      0.24            -0.0        0.21        perf-profile.self.cycles-pp.touch_atime
      0.34            -0.0        0.32        perf-profile.self.cycles-pp.w_test
      0.17 ±  2%      -0.0        0.15        perf-profile.self.cycles-pp.make_vfsuid
      0.17 ±  2%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.make_vfsgid
      0.20 ±  2%      -0.0        0.18 ±  4%  perf-profile.self.cycles-pp.__x64_sys_read
      0.84            +0.2        1.03        perf-profile.self.cycles-pp.down_write
     12.60            +1.6       14.16        perf-profile.self.cycles-pp._copy_to_iter
     10.85 ±  4%     +11.6       22.47        perf-profile.self.cycles-pp.folio_unlock



***************************************************************************************************
lkp-cpl-4sp2: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/300s/lkp-cpl-4sp2/fsdisk-w/unixbench

commit: 
  97450eb909 ("sched/pelt: Remove shift of thermal clock")
  6efc66e7c7 ("sched/numa: Correct NUMA imbalance calculation")

97450eb909658573 6efc66e7c7874a28529068c203f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  10622634 ±  7%      -9.9%    9576106 ±  7%  meminfo.DirectMap2M
     10183 ± 38%     +83.6%      18694 ± 62%  numa-meminfo.node3.Mapped
      2753            +3.8%       2858        vmstat.system.cs
    112.50 ± 11%     -28.7%      80.17 ± 15%  perf-c2c.DRAM.remote
     71.83 ± 10%     -37.1%      45.17 ± 12%  perf-c2c.HITM.remote
      0.64 ±  2%      +0.3        0.95 ±  4%  mpstat.cpu.all.irq%
      0.03 ±  2%      +0.0        0.05        mpstat.cpu.all.soft%
      2.86            -0.9        2.00 ±  3%  mpstat.cpu.all.usr%
    200343            +1.7%     203741        proc-vmstat.nr_inactive_anon
     39333            +1.5%      39924        proc-vmstat.nr_slab_reclaimable
    200343            +1.7%     203741        proc-vmstat.nr_zone_inactive_anon
 1.234e+08           -26.7%   90543615 ±  6%  unixbench.throughput
    308205            +7.2%     330488        unixbench.time.involuntary_context_switches
      2293           -32.1%       1557 ±  3%  unixbench.time.user_time
 4.584e+10           -26.6%  3.365e+10 ±  6%  unixbench.workload
      1.63            +8.5%       1.77        perf-stat.i.MPKI
 8.764e+09           -30.9%  6.054e+09 ±  4%  perf-stat.i.branch-instructions
  53207984           -33.8%   35207703 ±  2%  perf-stat.i.branch-misses
  60891213           -18.9%   49358107 ±  4%  perf-stat.i.cache-misses
  81919293           -18.5%   66726450 ±  3%  perf-stat.i.cache-references
      2716            +4.1%       2828        perf-stat.i.context-switches
     12.99           +45.8%      18.94 ±  4%  perf-stat.i.cpi
 6.633e+11            -1.9%  6.508e+11        perf-stat.i.cpu-cycles
    262.21            -1.7%     257.83        perf-stat.i.cpu-migrations
      9077           +22.0%      11075 ±  4%  perf-stat.i.cycles-between-cache-misses
 4.259e+10           -30.9%  2.944e+10 ±  4%  perf-stat.i.instructions
      0.65 ± 38%     -78.2%       0.14 ± 27%  perf-stat.i.major-faults
      1.43           +17.7%       1.68        perf-stat.overall.MPKI
      0.60            -0.0        0.56        perf-stat.overall.branch-miss-rate%
     15.64           +42.7%      22.32 ±  5%  perf-stat.overall.cpi
     10918           +21.3%      13241 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.06           -29.8%       0.04 ±  5%  perf-stat.overall.ipc
    354.92            -4.3%     339.50 ±  2%  perf-stat.overall.path-length
 8.988e+09           -29.9%  6.301e+09 ±  5%  perf-stat.ps.branch-instructions
  53819268           -34.2%   35393062 ±  3%  perf-stat.ps.branch-misses
  62559137           -17.5%   51613567 ±  4%  perf-stat.ps.cache-misses
  83864961           -17.5%   69192337 ±  4%  perf-stat.ps.cache-references
      2667            +3.1%       2749        perf-stat.ps.context-switches
    256.89            -2.5%     250.41        perf-stat.ps.cpu-migrations
 4.368e+10           -29.9%  3.064e+10 ±  5%  perf-stat.ps.instructions
      0.57 ± 38%     -78.5%       0.12 ± 26%  perf-stat.ps.major-faults
 1.627e+13           -29.9%  1.141e+13 ±  5%  perf-stat.total.instructions
  31406618 ±  6%     -15.0%   26687201 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.min
      0.81 ±  8%     -19.2%       0.65 ±  5%  sched_debug.cfs_rq:/.h_nr_running.min
      0.12 ±  4%     +39.4%       0.16 ± 16%  sched_debug.cfs_rq:/.h_nr_running.stddev
      3660 ±  8%     -20.2%       2920 ±  5%  sched_debug.cfs_rq:/.load.min
      7.56 ± 13%     +48.6%      11.23 ± 17%  sched_debug.cfs_rq:/.load_avg.avg
    183.83 ±  4%    +113.6%     392.71 ± 24%  sched_debug.cfs_rq:/.load_avg.max
      3.10 ±  8%     -16.1%       2.60 ±  5%  sched_debug.cfs_rq:/.load_avg.min
     22.00 ± 17%    +100.9%      44.19 ± 20%  sched_debug.cfs_rq:/.load_avg.stddev
  31406618 ±  6%     -15.0%   26687201 ±  6%  sched_debug.cfs_rq:/.min_vruntime.min
      0.86            -9.8%       0.77 ±  6%  sched_debug.cfs_rq:/.nr_running.avg
      0.81 ±  8%     -19.2%       0.65 ±  5%  sched_debug.cfs_rq:/.nr_running.min
      0.05 ± 27%    +125.9%       0.10 ± 24%  sched_debug.cfs_rq:/.nr_running.stddev
    894.39           -10.8%     797.67 ±  6%  sched_debug.cfs_rq:/.runnable_avg.avg
    791.84 ±  7%     -15.9%     665.91 ±  5%  sched_debug.cfs_rq:/.runnable_avg.min
     93.56 ± 14%     +50.6%     140.93 ± 11%  sched_debug.cfs_rq:/.runnable_avg.stddev
    887.62           -11.1%     789.04 ±  6%  sched_debug.cfs_rq:/.util_avg.avg
    664.85 ±  8%     -17.2%     550.39 ±  6%  sched_debug.cfs_rq:/.util_avg.min
     56.28 ± 25%     +84.7%     103.92 ± 20%  sched_debug.cfs_rq:/.util_avg.stddev
    215.40           -66.4%      72.28 ± 10%  sched_debug.cfs_rq:/.util_est.avg
   1167320 ±  5%    +115.2%    2511775 ±  5%  sched_debug.cpu.avg_idle.max
    758966 ±  3%     -15.8%     638698 ± 11%  sched_debug.cpu.avg_idle.min
     45953 ± 19%    +366.0%     214146 ± 11%  sched_debug.cpu.avg_idle.stddev
    458.94 ± 11%     +18.5%     543.69 ±  5%  sched_debug.cpu.clock.stddev
      1080 ±  4%     +14.6%       1238 ±  4%  sched_debug.cpu.clock_task.stddev
     12684 ±  4%     -15.7%      10688 ±  5%  sched_debug.cpu.curr->pid.avg
     13960 ±  3%      -7.1%      12966 ±  3%  sched_debug.cpu.curr->pid.max
    599.40 ± 50%     +94.7%       1167 ± 35%  sched_debug.cpu.curr->pid.stddev
    557932 ±  4%    +110.0%    1171426 ±  5%  sched_debug.cpu.max_idle_balance_cost.max
      5628 ± 50%   +1323.6%      80122 ± 11%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ± 11%     +25.0%       0.00 ±  7%  sched_debug.cpu.next_balance.stddev
      0.87           -10.0%       0.78 ±  6%  sched_debug.cpu.nr_running.avg
      0.83 ±  6%     -21.5%       0.65 ±  5%  sched_debug.cpu.nr_running.min
      0.11 ±  5%     +40.3%       0.16 ± 15%  sched_debug.cpu.nr_running.stddev
      1031 ±  3%     -11.3%     915.37 ±  5%  sched_debug.cpu.nr_switches.min
     14.58            -0.9       13.68 ±  2%  perf-profile.calltrace.cycles-pp.folio_unlock.simple_write_end.generic_perform_write.generic_file_write_iter.vfs_write
      0.85 ±  4%      -0.5        0.36 ± 71%  perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      1.16 ±  4%      -0.5        0.67 ± 13%  perf-profile.calltrace.cycles-pp.w_test
     17.31            -0.5       16.82        perf-profile.calltrace.cycles-pp.simple_write_end.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      0.74 ±  2%      -0.5        0.27 ±100%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.81            -0.3        0.47 ± 45%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify_area.vfs_write.ksys_write
      1.44 ±  2%      -0.3        1.14 ±  4%  perf-profile.calltrace.cycles-pp.xas_load.filemap_get_entry.__filemap_get_folio.simple_write_begin.generic_perform_write
      0.65 ±  2%      -0.3        0.36 ± 70%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.write
      0.91            -0.3        0.63 ±  8%  perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.88            -0.3        0.60 ±  8%  perf-profile.calltrace.cycles-pp.security_file_permission.rw_verify_area.vfs_write.ksys_write.do_syscall_64
      1.06 ± 16%      -0.2        0.81 ±  8%  perf-profile.calltrace.cycles-pp.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
      0.61 ±  3%      +0.1        0.69 ±  4%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     97.14            +0.4       97.50        perf-profile.calltrace.cycles-pp.write
      4.01 ±  2%      +0.5        4.51        perf-profile.calltrace.cycles-pp.simple_write_begin.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      3.87 ±  2%      +0.6        4.42        perf-profile.calltrace.cycles-pp.__filemap_get_folio.simple_write_begin.generic_perform_write.generic_file_write_iter.vfs_write
      3.51 ±  2%      +0.6        4.07        perf-profile.calltrace.cycles-pp.filemap_get_entry.__filemap_get_folio.simple_write_begin.generic_perform_write.generic_file_write_iter
     95.31            +0.7       95.98        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     95.40            +0.7       96.07        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     94.16            +0.7       94.89        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     93.23            +1.0       94.25        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     90.40            +1.8       92.20        perf-profile.calltrace.cycles-pp.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     60.12            +1.9       62.04        perf-profile.calltrace.cycles-pp.rep_movs_alternative.copy_page_from_iter_atomic.generic_perform_write.generic_file_write_iter.vfs_write
     88.25            +2.3       90.55        perf-profile.calltrace.cycles-pp.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
     66.98            +2.9       69.93        perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
     14.64            -0.7       13.93        perf-profile.children.cycles-pp.folio_unlock
      1.17 ±  4%      -0.5        0.68 ± 13%  perf-profile.children.cycles-pp.w_test
     17.36            -0.5       16.90        perf-profile.children.cycles-pp.simple_write_end
      0.92 ±  3%      -0.3        0.58 ± 11%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.88 ±  3%      -0.3        0.54 ± 11%  perf-profile.children.cycles-pp.fault_in_readable
      1.46 ±  2%      -0.3        1.15 ±  4%  perf-profile.children.cycles-pp.xas_load
      0.92            -0.3        0.64 ±  8%  perf-profile.children.cycles-pp.rw_verify_area
      0.89            -0.3        0.61 ±  9%  perf-profile.children.cycles-pp.security_file_permission
      0.82            -0.3        0.55 ±  9%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.74 ±  2%      -0.2        0.49 ± 15%  perf-profile.children.cycles-pp.__fdget_pos
      1.06 ± 16%      -0.2        0.82 ±  8%  perf-profile.children.cycles-pp.__generic_file_write_iter
      0.35 ±  3%      -0.2        0.17 ± 16%  perf-profile.children.cycles-pp.xas_start
      0.63 ± 31%      -0.2        0.46 ±  8%  perf-profile.children.cycles-pp.file_remove_privs_flags
      0.66 ±  2%      -0.1        0.53 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.32 ±  3%      -0.1        0.20 ± 10%  perf-profile.children.cycles-pp.generic_write_checks
      0.26 ±  5%      -0.1        0.15 ± 14%  perf-profile.children.cycles-pp.generic_write_check_limits
      0.30 ±  5%      -0.1        0.19 ± 11%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.43 ±  2%      -0.1        0.33 ±  8%  perf-profile.children.cycles-pp.write@plt
      0.22 ±  8%      -0.1        0.13 ± 11%  perf-profile.children.cycles-pp.aa_file_perm
      0.33 ±  5%      -0.1        0.26 ±  8%  perf-profile.children.cycles-pp.inode_needs_update_time
      0.38 ±  5%      -0.1        0.31 ±  9%  perf-profile.children.cycles-pp.file_update_time
      0.22 ±  4%      -0.0        0.18 ±  7%  perf-profile.children.cycles-pp.up_write
      0.22 ±  3%      -0.0        0.19 ±  5%  perf-profile.children.cycles-pp.__cond_resched
      0.18 ±  7%      -0.0        0.14 ± 10%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.12            -0.0        0.09 ± 10%  perf-profile.children.cycles-pp.rcu_all_qs
      0.06 ± 16%      +0.0        0.11 ± 14%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.07 ± 18%      +0.1        0.13 ± 16%  perf-profile.children.cycles-pp.perf_rotate_context
      0.12 ± 14%      +0.1        0.19 ± 13%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.02 ±141%      +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.ret_from_fork
      0.02 ±141%      +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.01 ±223%      +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.kthread
      0.41 ±  2%      +0.1        0.49 ±  4%  perf-profile.children.cycles-pp.folio_mapping
      0.62 ±  3%      +0.1        0.70 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.25 ±  4%      +0.2        0.44 ±  7%  perf-profile.children.cycles-pp.task_mm_cid_work
      0.25 ±  4%      +0.2        0.45 ±  8%  perf-profile.children.cycles-pp.task_work_run
     97.71            +0.3       98.00        perf-profile.children.cycles-pp.write
      4.01 ±  2%      +0.5        4.52        perf-profile.children.cycles-pp.simple_write_begin
      3.89 ±  2%      +0.5        4.43        perf-profile.children.cycles-pp.__filemap_get_folio
      3.53 ±  2%      +0.6        4.08        perf-profile.children.cycles-pp.filemap_get_entry
     95.82            +0.7       96.53        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     95.74            +0.7       96.46        perf-profile.children.cycles-pp.do_syscall_64
     94.42            +0.7       95.17        perf-profile.children.cycles-pp.ksys_write
     93.50            +1.0       94.53        perf-profile.children.cycles-pp.vfs_write
     90.41            +1.8       92.21        perf-profile.children.cycles-pp.generic_file_write_iter
     88.50            +2.3       90.81        perf-profile.children.cycles-pp.generic_perform_write
     65.15            +2.5       67.64        perf-profile.children.cycles-pp.copy_page_from_iter_atomic
     62.50            +2.7       65.23        perf-profile.children.cycles-pp.rep_movs_alternative
     14.51            -0.7       13.80 ±  2%  perf-profile.self.cycles-pp.folio_unlock
      1.02 ±  5%      -0.5        0.57 ± 14%  perf-profile.self.cycles-pp.w_test
      1.45 ±  3%      -0.4        1.02 ±  9%  perf-profile.self.cycles-pp.vfs_write
      0.84 ±  4%      -0.3        0.50 ± 13%  perf-profile.self.cycles-pp.fault_in_readable
      0.73 ±  3%      -0.2        0.49 ± 15%  perf-profile.self.cycles-pp.__fdget_pos
      2.63 ±  3%      -0.2        2.40        perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.59 ±  3%      -0.2        0.41 ± 10%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.34 ±  3%      -0.2        0.17 ± 17%  perf-profile.self.cycles-pp.xas_start
      0.52 ±  4%      -0.1        0.38 ±  8%  perf-profile.self.cycles-pp.do_syscall_64
      0.66 ±  2%      -0.1        0.53 ±  5%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.35 ±  3%      -0.1        0.22 ±  8%  perf-profile.self.cycles-pp.xas_load
      0.25 ±  5%      -0.1        0.14 ± 13%  perf-profile.self.cycles-pp.generic_write_check_limits
      0.30 ±  6%      -0.1        0.18 ± 11%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.43 ±  2%      -0.1        0.33 ±  8%  perf-profile.self.cycles-pp.write@plt
      0.53 ±  4%      -0.1        0.44 ± 10%  perf-profile.self.cycles-pp.write
      0.22 ±  7%      -0.1        0.13 ± 13%  perf-profile.self.cycles-pp.aa_file_perm
      0.33 ±  4%      -0.1        0.26 ±  6%  perf-profile.self.cycles-pp.generic_file_write_iter
      0.65 ±  2%      -0.1        0.59        perf-profile.self.cycles-pp.folio_mark_dirty
      0.12 ±  7%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.simple_write_begin
      0.22 ±  4%      -0.0        0.18 ±  7%  perf-profile.self.cycles-pp.up_write
      0.17 ±  9%      -0.0        0.13 ± 10%  perf-profile.self.cycles-pp.inode_needs_update_time
      0.17 ±  6%      -0.0        0.13 ± 13%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.18 ±  5%      -0.0        0.15 ±  9%  perf-profile.self.cycles-pp.ksys_write
      0.11            -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.rcu_all_qs
      0.06 ± 16%      +0.0        0.11 ± 14%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.10 ±  5%      +0.1        0.18 ± 13%  perf-profile.self.cycles-pp.folio_mapping
      0.76 ±  2%      +0.2        0.92 ±  4%  perf-profile.self.cycles-pp.generic_perform_write
      0.24 ±  3%      +0.2        0.43 ±  7%  perf-profile.self.cycles-pp.task_mm_cid_work
      1.96 ±  2%      +0.2        2.19        perf-profile.self.cycles-pp.simple_write_end
      2.05 ±  2%      +0.9        2.91 ±  2%  perf-profile.self.cycles-pp.filemap_get_entry
     62.00            +2.6       64.63        perf-profile.self.cycles-pp.rep_movs_alternative



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



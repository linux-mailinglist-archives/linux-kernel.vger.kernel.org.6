Return-Path: <linux-kernel+bounces-200162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023F58FAC12
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3901C21581
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733661420A3;
	Tue,  4 Jun 2024 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B8FmNItE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922E414198E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717486184; cv=fail; b=Ze1Yz/GZ8TwCr7mtXfPXJyJJmFWU8LmACmjMFXeSVtBWXQCW8e/8vF1+ALIFTf6PospRCP80XaSXp5YLQ5UEMOuRySJ/w29V/eGQXyac9NEhEcA4QtbohwCqQpF97AIeaidDW0qqLdqArh81BK+T2o14FpbCC4aR/eBStLPNU1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717486184; c=relaxed/simple;
	bh=eDnJITooXVl8GooW8sRAmQVgSGENoTeg5JTVLbcXrJ8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q0QSaiAoCXcyAW9bhmL3LYAbtA4tTSXfY8XpJdANG+2r79VBSPmGxaIpGypWZY3nAaGHvn8UZZUQeehc1sY6FuWaUsq/mzzU/qCTpa6sZU4tDQsjZ5sHhg2A5hKISkp8rB6yMICIoJQ+BaPDgldXHOJB5KIfHI82yZt6rIHU1x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B8FmNItE; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717486175; x=1749022175;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=eDnJITooXVl8GooW8sRAmQVgSGENoTeg5JTVLbcXrJ8=;
  b=B8FmNItEOVcRxUWHMU48bsxloLliCvcjepipgDdSm+GXhF5lE8Vc64gC
   K9tvkitZDuIj65l71jbFsdJXhgSBpMzoP5OzFXYdZUW2T74EQdyLcyTAd
   AldB8hx/x3FVmMhBlsFIyGr5rxzm6jxkMhucs8SwDoOicJcNkdLQDtXaF
   HTyYjlXmLEEZnPO3RlyDV5OdfwUuYEDhKvMOoLBNN+SRX18yt+fIZGleE
   KcB/ehmbLvJzES84hCTe/JgwxgnafZ3WwiUa7+sSVsVwnkYq+y6+GOmmz
   9JNlu7gDELt8zfJqq3MtUvP6gYlvTiw2k69M87WG4m1CRHm/l6tO8eHi6
   A==;
X-CSE-ConnectionGUID: mMaUCuFfQWCLNl7qwF4wnA==
X-CSE-MsgGUID: znRzYS5vTmGqk1z+1Lvl4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="24588853"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="24588853"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 00:29:30 -0700
X-CSE-ConnectionGUID: llV9g5jGTfa0S9Ha/wj/ig==
X-CSE-MsgGUID: 4PS57T86Rr+uNQvFH/tvCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="42082058"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 00:29:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 00:29:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 00:29:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 00:29:27 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 00:29:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Txd0zApgPVNAP9/Hi/TaySisfIh8asU511rHQLuG+GPJ54mL/5Ieplfzc68rXNQy65FiwUr0WFivv38Oxbo1rI+Oqctk19lY9tU0DgJnRd1VDHinHUcd1+6YrE+rj+CqZg0+HQTBvVzbAJdcI+crkMF0hKjTudxsZIVewxKJ1QSRaBJpQUtnxU5Ofk88SmMhtsRsp8bDNOhA+K0lHVYCNDAPMnofz1fNXJoY8qvwulUIhH/nVoqVv0AmalQ2zQjA6+9IkwlgZggw8S3ZAVy0HrOlduJhJ7D4epG4+P3yRUhq7H07vL8+NZss7n+Wg5zaBNN6Le7y7b3QAYluWafNZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQx2hKeTDpjBFNB34XfTonldlvUPwfOv9hPD0YQYDVY=;
 b=kt55aNwDCejBGUMtgYZbAz6NXaQfw2XZz4HS78sEBYlg+uZYVOl5h1c0jXSbZp7YyebVyWwLV2CQEBGR0/9pp5PadQlPA/e7w6z0wlflb5P9503791C7ySiWggWNmSeyuRA5swRRce1FKtRI8xDqAP43x2sKXAa9vwQEVMc6KOKmkiF/I/2XR0Hs6tDR684CkGzZ3OEhw/JIHKNeN9lbEoyj302PgnRiIqO07duh5J364t3YLCrL97bqFhNokgYuYZ9U2+1bm5oe1D/XA2CQ1rbgCRr8wucGX5WIulIUG3rNdlwEecf6Ibnvd9+FsR2uGdn7H9d36qeA58djXBIOXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL1PR11MB5224.namprd11.prod.outlook.com (2603:10b6:208:30a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 07:29:16 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 07:29:14 +0000
Date: Tue, 4 Jun 2024 15:28:57 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Chunxin Zang <spring.cxz@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Chunxin Zang
	<zangchunxin@lixiang.com>, Chen Yang <yangchen11@lixiang.com>,
	<linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>, <mingo@redhat.com>, <peterz@infradead.org>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
	<jameshongleiwang@126.com>, <efault@gmx.de>, <kprateek.nayak@amd.com>,
	<zhouchunhua@lixiang.com>, Chunxin Zang <spring.cxz@gmail.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2] sched/fair: Reschedule the cfs_rq when current is
 ineligible
Message-ID: <202406041514.1051ae19-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240529141806.16029-1-spring.cxz@gmail.com>
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL1PR11MB5224:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e4bdc4-7793-4fb2-37b5-08dc846808d5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?r7Sh0+++DJ9ib5MZxQ95pOfzce0QfjaXEuVKT1+86M6X0neN6k7v9UMX8a?=
 =?iso-8859-1?Q?ClgGpuMNyTzywFeW/wChbfGiddKq2oImIlonM8oR5r+wpuB7uSeCmbh/oY?=
 =?iso-8859-1?Q?gEiqUPQ9RlXBmxORYe9Nj5ppYITGvF+mwhtSv4uA33DHnhs4lKjaZNyD5r?=
 =?iso-8859-1?Q?G6doDH3LgKneqVLVcBBP+qsV1A+y/WMh6XROG/LWgyz0PQUXJ0svM2w9Pc?=
 =?iso-8859-1?Q?B3YSdjX6yq7pGcBpdG/jsNciRDDB4ledm8/PyWluatgbvCr6HOAFNwz+bx?=
 =?iso-8859-1?Q?uJcwvd+2JSG8qj7PV2CMrOBltc6o1OH/l7jj5cFdSqRooQ8XSsSJAiRMSs?=
 =?iso-8859-1?Q?chTArN74UR3NRywNoBFGWhN7Ravg9Woqxw2xqDi4giUO0I2IJ0Kpq3H9uH?=
 =?iso-8859-1?Q?4x/cLeSFjd8r/X4s7YP/AZxqOU11C3YU34Y9l4rksEcr9AY/A7ANl7UegC?=
 =?iso-8859-1?Q?r4SqxQpoS69YkZtkbM18NH1adQKPxABwCzBGmeyjY1Xc6JaJzzmouGwwpd?=
 =?iso-8859-1?Q?LqweY2tjAkIXnY2s2BiLXUDDshMtolbZmCuoWcKprk+d7Prfkf6KTSg5zz?=
 =?iso-8859-1?Q?HR87UQDrO05/gAB8mhLGMV/+gnhoh9SwUgZVUSCIwfjEsMtAT2s8/Ns3XO?=
 =?iso-8859-1?Q?5OBumxRgL6nSB28uoj6b0A5ThykCYpBEe5qA8r4w3US+NxP6kW88iia5N7?=
 =?iso-8859-1?Q?hgjhushXhFz89I7hTLOgBHtPMU06rcr9DjtPfK95qHxeo36ZGDMeAxlLQ0?=
 =?iso-8859-1?Q?i2i76358Q+tuK/u14lg3RklHt1SqZ+5QYF4zgOi8E37wswmRDtdQYKzwKW?=
 =?iso-8859-1?Q?7o6HDRa0WQR3aReEecwavPnV1Nqkw1X3lW73fO+CWit7b92hMGlAOc9gaA?=
 =?iso-8859-1?Q?MWPUHBasPCVmxbqqkNqxcipatMyDxs2+vAc8YONaOX9ZyFR3uBVN0w5LVY?=
 =?iso-8859-1?Q?KPUOpICDVr3OFCAlXN39gChRB6Gw0+Fct1r+njFmgeLYT7Qx6jUOLp1F28?=
 =?iso-8859-1?Q?Q6f2ploV3nw01+ls4+FvAJZmo3QxeHedYKwtbpkI79qqyFo1GnfZBqSOzX?=
 =?iso-8859-1?Q?nk8KQ7NqU4OM6pzy0XtHfxxrU16tW998ifTwQOIZvmNKnvX5XeNRGQBAOK?=
 =?iso-8859-1?Q?dCtcBNGb2XXgF4om0mNqI5IJtj5Dw9HQvoFAbQAMNTxMWA+pyHtcTCRJ3z?=
 =?iso-8859-1?Q?OvcFwgQLbpd6pvTuuASxrp1K06VWB0KSB7fjzzzxp/klxEkriyk1/qh16d?=
 =?iso-8859-1?Q?adWXcH1JsDni1xmpIaCetduQtBD+msIUkc8v/mTds=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?hJxrzG6E/F77yQmafDFVLCqzh4Ea7HFudB/ZfWm3C+EHK5p15PulsjUiRm?=
 =?iso-8859-1?Q?Eu0sfaoOSZyY0IE8rN32vjAT6GMZlM1/GURuqtn17osOqllF46El4q3kBF?=
 =?iso-8859-1?Q?/jG7u8wopOGhhPfGaF/xPJZcjZS6rp2ADDTocTlR5cCfvrxyasghgTl7Eo?=
 =?iso-8859-1?Q?sjvzCq4kynEvcXc453B/RfAuUF64IMZFUWxjg8rzvTmaBKmZty1OMyBVf5?=
 =?iso-8859-1?Q?hrSRx99LXuNVW/G4LeITkh3DGCBwW31icVJ5zql+AB4sQX7xeK7kZxxtKV?=
 =?iso-8859-1?Q?NzNNE+hUqu1v4u3gOg0aoIp96lbVwVnMo/e7hJ+UAKo5whsb2RkBB84Jpk?=
 =?iso-8859-1?Q?g343WgyxaAGbDiugsYUHAGo0BTwT3zIuTQtcrkpanKNh1GNQqwK3eUSdnv?=
 =?iso-8859-1?Q?nzoUCPhmEMfNWITQ36WbdkRziw4rmiOlLK7hyBz7LuheJH3l+6JnWkCxFz?=
 =?iso-8859-1?Q?lmBeC1cwHQCrbXnxoaHU+V410vYH4C2k3OjBKpKCid/dHADEpdBhCMFsl8?=
 =?iso-8859-1?Q?0k0V0hoJaccZ1cu2yCJoWKMglr2WebWr7VNqApps1eHuZjsQGnXf04KuQW?=
 =?iso-8859-1?Q?BpdcOBkW7GzKhyh9zMsQYWNQEK10kuEVt3++TVwLn420q1RnpBzd4blXaI?=
 =?iso-8859-1?Q?h2iNYjkuQha+suFoLrZ97YPev1U1QFDXeyxcylfiomWq+HhrYNWfnPmvoA?=
 =?iso-8859-1?Q?bIkpxcH8ALOvCMEDJ/Jm4VD4c5OhkNwTivmdjeAltDODLSpznjzo1k5nuX?=
 =?iso-8859-1?Q?JQl2C3nQbr1ACXtC3CF/dJ9x0I9PnUwKg3YNPZnZ5IWv42KWWdbOwJ3X0D?=
 =?iso-8859-1?Q?Zf7DvAeBFEpO3entdM1GdvBChiO9w6cr8A+BKqpnMalxopp0sSNkrfiyG9?=
 =?iso-8859-1?Q?sdWdDwVhN06rDniaTQWGeAFcYwPEAJa+ovteBZQ1myi9hdNbvz36TEKrPf?=
 =?iso-8859-1?Q?67GFYRKX3K2sbpXxL2EcWQCxCuFgJn4yaJDjgVAL9ejmSea3K9jdxfaVnH?=
 =?iso-8859-1?Q?ZGFqaNFjNCm9XSVvdW2WGrlzMkZAGOW17OsVGcrV+WbC+uA6kEltDDJkIb?=
 =?iso-8859-1?Q?PL4BH1K+z+0+x3rUfmv83WlNX0porjZ1qbGNlLsZ1sj7Rm0+KmN+Pcw96X?=
 =?iso-8859-1?Q?AqN8YuWZNY4nMGA96yYxJOB7kzdZANTJfWXraAroRFdJoud/t2J9OPawPz?=
 =?iso-8859-1?Q?CoRrkAbQP59fO9EGjlK+5doIiKEW6Tl65fmaDwjtfGILSB4dpqrXemoKnY?=
 =?iso-8859-1?Q?UEF1LOvJTqiNdxIi6PMz+dq/GwRL/GTJirCSMTls2LVekL4xuB7LFiE17q?=
 =?iso-8859-1?Q?7B0gWFsv2Cn+V7Ioppka8Wf5fPaGGqobRuRXMWEal/+NucP0umkrbyd/1s?=
 =?iso-8859-1?Q?+VxsfqsCHKJsX24lJ3OdXtlfWtc/Z1K0AUO6ihIhLqMBQN0DUdP7RZDn0I?=
 =?iso-8859-1?Q?PpIASbDp6WOHo6cy2Q45KExgewSrQDb+yX5L+0P0uHugMPcRM/3QDi1I7A?=
 =?iso-8859-1?Q?/m9E/zwwUtLDfDJRefaewsKDJpusERst4qGy2pxRi8UP/dO2o6wqW+BKyl?=
 =?iso-8859-1?Q?NeaxBU0yD745ra/uKdEEzB0iacqTHR+tcOaCS7H4CxBQ+YOCuvxuUlfkjH?=
 =?iso-8859-1?Q?nWV/Z1nKSvXfjOy8BIe02LblTyjG9YrLKIi39gmWBamMOfNd2mV1VPig?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e4bdc4-7793-4fb2-37b5-08dc846808d5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 07:29:14.8284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRR44m1MKeTGlYsPKcXnpWyuXMO1CC60duIdvna0oLGiAK8FNfvUVL5TuFLvlklfaa8IRAf7SnfQWDDrw4Xavg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5224
X-OriginatorOrg: intel.com



Hello,

just like we reported for v1
https://lore.kernel.org/all/202405291359.3f662525-oliver.sang@intel.com/
we also noticed both improvments and regressions occur on different testcases
for this v2. just FYI.


kernel test robot noticed a -7.5% regression of netperf.Throughput_Mbps on:


commit: e2ee0a922a6a2a8377dc66435c944a643c560af9 ("[PATCH v2] sched/fair: Reschedule the cfs_rq when current is ineligible")
url: https://github.com/intel-lab-lkp/linux/commits/Chunxin-Zang/sched-fair-Reschedule-the-cfs_rq-when-current-is-ineligible/20240529-222209
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 402de7fc880fef055bc984957454b532987e9ad0
patch link: https://lore.kernel.org/all/20240529141806.16029-1-spring.cxz@gmail.com/
patch subject: [PATCH v2] sched/fair: Reschedule the cfs_rq when current is ineligible

testcase: netperf
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 200%
	cluster: cs-localhost
	send_size: 10K
	test: TCP_SENDFILE
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | dbench: dbench.throughput_MB/s -6.5% regression                                                    |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | disk=1HDD                                                                                          |
|                  | fs2=nfs                                                                                            |
|                  | fs=btrfs                                                                                           |
|                  | nr_threads=100%                                                                                    |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.memfd.ops_per_sec 16.3% improvement                                           |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory          |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | nr_threads=100%                                                                                    |
|                  | test=memfd                                                                                         |
|                  | testtime=60s                                                                                       |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | stream: stream.triad_bandwidth_MBps 24.3% improvement                                              |
| test machine     | 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory     |
| test parameters  | array_size=10000000                                                                                |
|                  | cpufreq_governor=performance                                                                       |
|                  | iterations=10x                                                                                     |
|                  | loop=100                                                                                           |
|                  | nr_threads=100%                                                                                    |
|                  | omp=true                                                                                           |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min 44.9% improvement                                                          |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory         |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | disk=1BRD_48G                                                                                      |
|                  | fs=xfs                                                                                             |
|                  | load=600                                                                                           |
|                  | test=sync_disk_rw                                                                                  |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_process_ops -10.4% regression                                     |
| test machine     | 104 threads 2 sockets (Skylake) with 192G memory                                                   |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | mode=process                                                                                       |
|                  | nr_task=100%                                                                                       |
|                  | test=mmap1                                                                                         |
+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | kbuild: kbuild.user_time_per_iteration 2.7% regression                                             |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory |
| test parameters  | build_kconfig=allyesconfig                                                                         |
|                  | cpufreq_governor=performance                                                                       |
|                  | disk=1HDD                                                                                          |
|                  | fs=ext4                                                                                            |
|                  | nr_task=200%                                                                                       |
|                  | runtime=300s                                                                                       |
|                  | target=vmlinux                                                                                     |
+------------------+----------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406041514.1051ae19-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240604/202406041514.1051ae19-oliver.sang@intel.com

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/send_size/tbox_group/test/testcase:
  cs-localhost/gcc-13/performance/ipv4/x86_64-rhel-8.3/200%/debian-12-x86_64-20240206.cgz/300s/10K/lkp-icl-2sp2/TCP_SENDFILE/netperf

commit: 
  402de7fc88 ("sched: Fix spelling in comments")
  e2ee0a922a ("sched/fair: Reschedule the cfs_rq when current is ineligible")

402de7fc880fef05 e2ee0a922a6a2a8377dc66435c9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      3.34            +0.4        3.71        mpstat.cpu.all.usr%
   1164932 ±  3%     +19.9%    1396604 ±  4%  proc-vmstat.pgfree
   5390040           +42.6%    7687714        vmstat.system.cs
    176647            +6.2%     187604        vmstat.system.in
      9553            -7.5%       8837        netperf.ThroughputBoth_Mbps
   2445627            -7.5%    2262330        netperf.ThroughputBoth_total_Mbps
      9553            -7.5%       8837        netperf.Throughput_Mbps
   2445627            -7.5%    2262330        netperf.Throughput_total_Mbps
 7.999e+08           +45.7%  1.165e+09        netperf.time.involuntary_context_switches
      8054            -3.0%       7812        netperf.time.percent_of_cpu_this_job_got
     23304            -2.9%      22617        netperf.time.system_time
    993.63            -3.4%     960.09        netperf.time.user_time
  17299500           -91.9%    1403037 ±  3%  netperf.time.voluntary_context_switches
 8.956e+09            -7.5%  8.285e+09        netperf.workload
   5.4e+10            +1.1%  5.461e+10        perf-stat.i.branch-instructions
      0.64            +0.1        0.70        perf-stat.i.branch-miss-rate%
  3.36e+08           +11.7%  3.753e+08        perf-stat.i.branch-misses
 6.621e+08            -4.0%  6.353e+08        perf-stat.i.cache-references
   5418772           +42.6%    7728129        perf-stat.i.context-switches
      1.20            -1.2%       1.18        perf-stat.i.cpi
    609.63 ± 15%     +33.3%     812.50 ± 12%  perf-stat.i.cpu-migrations
 2.725e+11            +1.3%   2.76e+11        perf-stat.i.instructions
      0.84            +1.2%       0.85        perf-stat.i.ipc
     42.33           +42.6%      60.37        perf-stat.i.metric.K/sec
      0.62            +0.1        0.69        perf-stat.overall.branch-miss-rate%
      1.20            -1.2%       1.19        perf-stat.overall.cpi
      0.83            +1.2%       0.84        perf-stat.overall.ipc
      9191            +9.4%      10059        perf-stat.overall.path-length
 5.382e+10            +1.1%  5.443e+10        perf-stat.ps.branch-instructions
 3.348e+08           +11.7%   3.74e+08        perf-stat.ps.branch-misses
 6.601e+08            -4.0%  6.335e+08        perf-stat.ps.cache-references
   5399491           +42.7%    7703899        perf-stat.ps.context-switches
    605.58 ± 15%     +32.8%     804.38 ± 12%  perf-stat.ps.cpu-migrations
 2.716e+11            +1.3%  2.751e+11        perf-stat.ps.instructions
 8.232e+13            +1.2%  8.334e+13        perf-stat.total.instructions
  13368528 ±  4%      +5.7%   14136697 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.min
      3.58 ±  3%     +38.0%       4.94 ±  3%  sched_debug.cfs_rq:/.h_nr_running.max
      0.64 ±  7%     +24.7%       0.79 ±  3%  sched_debug.cfs_rq:/.h_nr_running.stddev
      9.80 ±219%  +3.6e+05%      35044 ± 57%  sched_debug.cfs_rq:/.left_deadline.avg
      1222 ±219%  +3.3e+05%    3990027 ± 58%  sched_debug.cfs_rq:/.left_deadline.max
    107.66 ±219%  +3.4e+05%     365640 ± 56%  sched_debug.cfs_rq:/.left_deadline.stddev
      9.76 ±220%  +3.6e+05%      35044 ± 57%  sched_debug.cfs_rq:/.left_vruntime.avg
      1216 ±220%  +3.3e+05%    3990021 ± 58%  sched_debug.cfs_rq:/.left_vruntime.max
    107.15 ±220%  +3.4e+05%     365638 ± 56%  sched_debug.cfs_rq:/.left_vruntime.stddev
      3.47 ±  4%     +20.0%       4.17 ±  9%  sched_debug.cfs_rq:/.load_avg.min
  13368528 ±  4%      +5.7%   14136697 ±  3%  sched_debug.cfs_rq:/.min_vruntime.min
      9.76 ±220%  +3.6e+05%      35044 ± 57%  sched_debug.cfs_rq:/.right_vruntime.avg
      1216 ±220%  +3.3e+05%    3990021 ± 58%  sched_debug.cfs_rq:/.right_vruntime.max
    107.15 ±220%  +3.4e+05%     365638 ± 56%  sched_debug.cfs_rq:/.right_vruntime.stddev
    549.31 ± 10%     -16.1%     461.06 ± 13%  sched_debug.cfs_rq:/.runnable_avg.stddev
      1393 ±  2%     +10.2%       1534        sched_debug.cfs_rq:/.util_est.avg
      2468           +14.4%       2822 ±  2%  sched_debug.cfs_rq:/.util_est.max
      1655 ± 20%     -37.5%       1035 ±  8%  sched_debug.cpu.clock_task.stddev
      3.61 ±  3%     +36.9%       4.94 ±  3%  sched_debug.cpu.nr_running.max
      0.64 ±  9%     +23.3%       0.79 ±  4%  sched_debug.cpu.nr_running.stddev
   6335013           +41.5%    8965642        sched_debug.cpu.nr_switches.avg
  11132807 ±  3%      -6.7%   10381974        sched_debug.cpu.nr_switches.max
   2186258 ± 39%    +257.6%    7817491 ±  3%  sched_debug.cpu.nr_switches.min
   2371333 ± 31%     -75.0%     593670 ± 36%  sched_debug.cpu.nr_switches.stddev
      0.00 ± 47%  +72147.8%       0.54 ± 80%  sched_debug.rt_rq:.rt_time.avg
      0.10 ± 47%  +72137.4%      68.83 ± 80%  sched_debug.rt_rq:.rt_time.max
      0.01 ± 47%  +72137.3%       6.06 ± 80%  sched_debug.rt_rq:.rt_time.stddev
     38.25            -3.3       34.92        perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.splice_to_socket.direct_splice_actor
     64.17            -2.8       61.39        perf-profile.calltrace.cycles-pp.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendfile.sendfile_tcp_stream
     11.11            -2.7        8.37        perf-profile.calltrace.cycles-pp.tcp_wmem_schedule.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.splice_to_socket
     10.98            -2.7        8.25        perf-profile.calltrace.cycles-pp.__sk_mem_schedule.tcp_wmem_schedule.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
     10.87            -2.7        8.14        perf-profile.calltrace.cycles-pp.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_wmem_schedule.tcp_sendmsg_locked.tcp_sendmsg
     62.39            -2.7       59.66        perf-profile.calltrace.cycles-pp.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendfile
     58.83            -2.5       56.34        perf-profile.calltrace.cycles-pp.do_splice_direct.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     70.99            -2.5       68.51        perf-profile.calltrace.cycles-pp.sendfile_tcp_stream.main
     58.57            -2.5       56.10        perf-profile.calltrace.cycles-pp.splice_direct_to_actor.do_splice_direct.do_sendfile.__x64_sys_sendfile64.do_syscall_64
     69.00            -2.4       66.60        perf-profile.calltrace.cycles-pp.sendfile.sendfile_tcp_stream.main
     66.23            -2.3       63.96        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendfile.sendfile_tcp_stream.main
     66.02            -2.3       63.76        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendfile.sendfile_tcp_stream.main
     49.02            -1.8       47.19        perf-profile.calltrace.cycles-pp.direct_splice_actor.splice_direct_to_actor.do_splice_direct.do_sendfile.__x64_sys_sendfile64
     48.58            -1.8       46.76        perf-profile.calltrace.cycles-pp.splice_to_socket.direct_splice_actor.splice_direct_to_actor.do_splice_direct.do_sendfile
     44.56            -1.6       42.98        perf-profile.calltrace.cycles-pp.sock_sendmsg.splice_to_socket.direct_splice_actor.splice_direct_to_actor.do_splice_direct
     42.83            -1.5       41.29        perf-profile.calltrace.cycles-pp.tcp_sendmsg.sock_sendmsg.splice_to_socket.direct_splice_actor.splice_direct_to_actor
     11.54            -1.5       10.02        perf-profile.calltrace.cycles-pp.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.splice_to_socket
     10.03            -1.3        8.70        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      4.47            -1.3        3.20        perf-profile.calltrace.cycles-pp.mem_cgroup_charge_skmem.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_wmem_schedule.tcp_sendmsg_locked
      9.18            -1.2        7.95        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg
      8.62            -1.2        7.45        perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked
      2.21 ±  2%      -0.7        1.47 ±  3%  perf-profile.calltrace.cycles-pp.try_charge_memcg.mem_cgroup_charge_skmem.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_wmem_schedule
      2.04 ±  2%      -0.7        1.34 ±  4%  perf-profile.calltrace.cycles-pp.page_counter_try_charge.try_charge_memcg.mem_cgroup_charge_skmem.__sk_mem_raise_allocated.__sk_mem_schedule
      2.23 ±  2%      -0.6        1.59 ±  2%  perf-profile.calltrace.cycles-pp.mem_cgroup_charge_skmem.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_try_rmem_schedule.tcp_data_queue
     98.20            -0.6       97.61        perf-profile.calltrace.cycles-pp.main
      7.84            -0.6        7.27        perf-profile.calltrace.cycles-pp.filemap_splice_read.splice_direct_to_actor.do_splice_direct.do_sendfile.__x64_sys_sendfile64
      1.86 ±  3%      -0.6        1.31 ±  4%  perf-profile.calltrace.cycles-pp.try_charge_memcg.mem_cgroup_charge_skmem.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_try_rmem_schedule
      1.87 ±  5%      -0.5        1.36 ±  3%  perf-profile.calltrace.cycles-pp.__mod_memcg_state.mem_cgroup_charge_skmem.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_wmem_schedule
      3.20            -0.5        2.72 ±  6%  perf-profile.calltrace.cycles-pp.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_try_rmem_schedule.tcp_data_queue.tcp_rcv_established
     14.30            -0.5       13.84        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
     14.16            -0.4       13.72        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      5.44            -0.4        5.04        perf-profile.calltrace.cycles-pp.skb_splice_from_iter.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.splice_to_socket
      3.22            -0.4        2.84        perf-profile.calltrace.cycles-pp.__sk_mem_schedule.tcp_try_rmem_schedule.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv
      3.26            -0.4        2.89        perf-profile.calltrace.cycles-pp.tcp_try_rmem_schedule.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
     10.72            -0.3       10.38        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
      1.59            -0.3        1.30        perf-profile.calltrace.cycles-pp.__sk_mem_reduce_allocated.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      0.87            -0.3        0.58        perf-profile.calltrace.cycles-pp.skb_attempt_defer_free.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      0.82            -0.3        0.54        perf-profile.calltrace.cycles-pp.skb_release_data.skb_attempt_defer_free.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      1.44            -0.3        1.17        perf-profile.calltrace.cycles-pp.mem_cgroup_uncharge_skmem.__sk_mem_reduce_allocated.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      0.77 ±  3%      -0.2        0.56 ±  3%  perf-profile.calltrace.cycles-pp.drain_stock.mem_cgroup_uncharge_skmem.__sk_mem_reduce_allocated.tcp_recvmsg_locked.tcp_recvmsg
      0.77 ±  2%      -0.2        0.56 ±  3%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.drain_stock.mem_cgroup_uncharge_skmem.__sk_mem_reduce_allocated.tcp_recvmsg_locked
      2.60            -0.2        2.39        perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_splice_read.splice_direct_to_actor.do_splice_direct.do_sendfile
      2.28            -0.2        2.09        perf-profile.calltrace.cycles-pp.filemap_get_read_batch.filemap_get_pages.filemap_splice_read.splice_direct_to_actor.do_splice_direct
      1.64            -0.2        1.44        perf-profile.calltrace.cycles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
      1.19            -0.2        1.01        perf-profile.calltrace.cycles-pp.__sk_mem_reduce_allocated.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv
      1.76            -0.2        1.59        perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      1.68            -0.2        1.53        perf-profile.calltrace.cycles-pp.skb_append_pagefrags.skb_splice_from_iter.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      1.08            -0.1        0.93        perf-profile.calltrace.cycles-pp.mem_cgroup_uncharge_skmem.__sk_mem_reduce_allocated.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established
      1.94            -0.1        1.81        perf-profile.calltrace.cycles-pp.iov_iter_extract_pages.skb_splice_from_iter.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      1.63            -0.1        1.50        perf-profile.calltrace.cycles-pp.splice_folio_into_pipe.filemap_splice_read.splice_direct_to_actor.do_splice_direct.do_sendfile
      0.69            -0.1        0.58        perf-profile.calltrace.cycles-pp.tcp_event_new_data_sent.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      0.98            -0.1        0.88        perf-profile.calltrace.cycles-pp.page_cache_pipe_buf_release.splice_to_socket.direct_splice_actor.splice_direct_to_actor.do_splice_direct
      1.02            -0.1        0.93        perf-profile.calltrace.cycles-pp.folios_put_refs.filemap_splice_read.splice_direct_to_actor.do_splice_direct.do_sendfile
      1.11            -0.1        1.03        perf-profile.calltrace.cycles-pp.rw_verify_area.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.78 ±  2%      -0.1        0.72 ±  2%  perf-profile.calltrace.cycles-pp.drain_stock.mem_cgroup_uncharge_skmem.__sk_mem_reduce_allocated.tcp_clean_rtx_queue.tcp_ack
      0.82            -0.1        0.76        perf-profile.calltrace.cycles-pp.security_file_permission.rw_verify_area.do_sendfile.__x64_sys_sendfile64.do_syscall_64
      0.78 ±  2%      -0.1        0.71 ±  2%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.drain_stock.mem_cgroup_uncharge_skmem.__sk_mem_reduce_allocated.tcp_clean_rtx_queue
      1.44            -0.1        1.38        perf-profile.calltrace.cycles-pp.clear_bhb_loop.sendfile.sendfile_tcp_stream.main
      0.76            -0.1        0.70        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.sendfile.sendfile_tcp_stream.main
      1.80            -0.1        1.74        perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked
      2.20            -0.1        2.14        perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
      1.06 ±  2%      -0.1        1.00 ±  2%  perf-profile.calltrace.cycles-pp.tcp_send_mss.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.splice_to_socket
      0.70            -0.1        0.64        perf-profile.calltrace.cycles-pp.ktime_get.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg
      0.60            -0.1        0.55        perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify_area.do_sendfile.__x64_sys_sendfile64
      0.73            -0.0        0.68        perf-profile.calltrace.cycles-pp.iov_iter_advance.iov_iter_extract_pages.skb_splice_from_iter.tcp_sendmsg_locked.tcp_sendmsg
      0.66            -0.0        0.61        perf-profile.calltrace.cycles-pp.__fdget.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.81            -0.0        0.76        perf-profile.calltrace.cycles-pp._copy_from_user.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendfile
      0.86            -0.0        0.82        perf-profile.calltrace.cycles-pp.touch_atime.splice_direct_to_actor.do_splice_direct.do_sendfile.__x64_sys_sendfile64
      0.67            -0.0        0.62        perf-profile.calltrace.cycles-pp.touch_atime.filemap_splice_read.splice_direct_to_actor.do_splice_direct.do_sendfile
      0.62            -0.0        0.58        perf-profile.calltrace.cycles-pp.__fsnotify_parent.do_sendfile.__x64_sys_sendfile64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.72            -0.0        0.68        perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.splice_direct_to_actor.do_splice_direct.do_sendfile
      0.58            -0.0        0.54        perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.filemap_splice_read.splice_direct_to_actor.do_splice_direct
      1.19            -0.0        1.16        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      0.60            -0.0        0.58        perf-profile.calltrace.cycles-pp.netperf_sendfile.sendfile_tcp_stream.main
      0.72            -0.0        0.70        perf-profile.calltrace.cycles-pp.security_socket_sendmsg.sock_sendmsg.splice_to_socket.direct_splice_actor.splice_direct_to_actor
     10.89            +0.2       11.08        perf-profile.calltrace.cycles-pp.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
      0.97            +0.3        1.24        perf-profile.calltrace.cycles-pp.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      0.59            +0.3        0.85        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.process_requests
     11.10            +0.3       11.37        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
     11.15            +0.3       11.43        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      0.76            +0.3        1.05        perf-profile.calltrace.cycles-pp.sendfile
      0.52            +0.3        0.81        perf-profile.calltrace.cycles-pp.__schedule.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.42 ± 44%      +0.3        0.72        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_node_noprof.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg
      0.68            +0.3        0.98        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.wait_woken
      0.54            +0.3        0.85        perf-profile.calltrace.cycles-pp.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendfile
      1.72            +0.3        2.03        perf-profile.calltrace.cycles-pp.tcp_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.splice_to_socket
      0.74            +0.3        1.07        perf-profile.calltrace.cycles-pp.recv
     12.09            +0.4       12.48        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.handle_softirqs
     12.47            +0.5       12.93        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.handle_softirqs.do_softirq
     12.54            +0.5       13.01        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip
      1.30            +0.5        1.82        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendfile.sendfile_tcp_stream
     12.78            +0.5       13.32        perf-profile.calltrace.cycles-pp.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
     12.32            +0.5       12.86        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit
      3.44            +0.6        3.99        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked
      0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
      0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
      0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendfile
      0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recv
      0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendfile
      3.54            +0.6        4.13        perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked.tcp_recvmsg
     13.43            +0.7       14.09        perf-profile.calltrace.cycles-pp.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
      0.61            +0.7        1.28        perf-profile.calltrace.cycles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
      1.34            +0.7        2.02        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established
     13.58            +0.7       14.27        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit
      3.80            +0.7        4.50        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      0.00            +0.7        0.70        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.__wake_up_common.__wake_up_sync_key.sock_def_readable
     13.71            +0.7       14.43        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb
      0.77            +0.7        1.50        perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
      1.46            +0.7        2.20        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv
      4.06            +0.8        4.86        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      1.63            +0.8        2.45        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
      1.64            +0.8        2.46        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
      1.36 ±  3%      +1.0        2.40        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_sync_key.sock_def_readable.tcp_data_queue.tcp_rcv_established
      1.47 ±  2%      +1.1        2.52        perf-profile.calltrace.cycles-pp.__wake_up_sync_key.sock_def_readable.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv
      1.57 ±  2%      +1.1        2.66        perf-profile.calltrace.cycles-pp.sock_def_readable.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
      2.97            +1.2        4.14        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked
      5.18            +1.2        6.42        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      5.32            +1.2        6.56        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.splice_to_socket
      3.24            +1.3        4.52        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg
      1.90            +1.3        3.18        perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg
      1.94            +1.3        3.23        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg
      1.67            +1.4        3.03        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.wait_woken.sk_wait_data
     25.62            +1.4       27.02        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.process_requests
      1.73            +1.4        3.12        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      1.83            +1.4        3.27        perf-profile.calltrace.cycles-pp.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
      1.93            +1.5        3.41        perf-profile.calltrace.cycles-pp.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      0.76 ±  3%      +1.5        2.25        perf-profile.calltrace.cycles-pp.try_to_wake_up.__wake_up_common.__wake_up_sync_key.sock_def_readable.tcp_data_queue
     24.44            +1.5       25.99        perf-profile.calltrace.cycles-pp.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
      2.26            +1.6        3.89        perf-profile.calltrace.cycles-pp.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
     26.32            +1.7       28.01        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.process_requests.spawn_child
     26.35            +1.7       28.05        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recv.process_requests.spawn_child.accept_connection
     24.81            +1.7       26.51        perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      4.04            +1.8        5.79        perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
     24.93            +1.8       26.70        perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
      3.54            +1.8        5.34        perf-profile.calltrace.cycles-pp.release_sock.tcp_sendmsg.sock_sendmsg.splice_to_socket.direct_splice_actor
     25.08            +1.8       26.89        perf-profile.calltrace.cycles-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     26.85            +1.8       28.68        perf-profile.calltrace.cycles-pp.recv.process_requests.spawn_child.accept_connection.accept_connections
      2.96            +1.8        4.80        perf-profile.calltrace.cycles-pp.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg.splice_to_socket
     27.11            +1.9       29.00        perf-profile.calltrace.cycles-pp.accept_connection.accept_connections.main
     27.11            +1.9       29.00        perf-profile.calltrace.cycles-pp.accept_connections.main
     27.11            +1.9       29.00        perf-profile.calltrace.cycles-pp.process_requests.spawn_child.accept_connection.accept_connections.main
     27.11            +1.9       29.00        perf-profile.calltrace.cycles-pp.spawn_child.accept_connection.accept_connections.main
     25.57            +1.9       27.51        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
     15.21            -3.4       11.83        perf-profile.children.cycles-pp.__sk_mem_raise_allocated
     15.34            -3.4       11.97        perf-profile.children.cycles-pp.__sk_mem_schedule
     38.57            -3.3       35.29        perf-profile.children.cycles-pp.tcp_sendmsg_locked
     11.16            -2.7        8.42        perf-profile.children.cycles-pp.tcp_wmem_schedule
     64.54            -2.7       61.87        perf-profile.children.cycles-pp.__x64_sys_sendfile64
     62.84            -2.6       60.23        perf-profile.children.cycles-pp.do_sendfile
     71.12            -2.4       68.68        perf-profile.children.cycles-pp.sendfile_tcp_stream
     59.16            -2.4       56.78        perf-profile.children.cycles-pp.do_splice_direct
     58.92            -2.4       56.55        perf-profile.children.cycles-pp.splice_direct_to_actor
     70.42            -2.1       68.31        perf-profile.children.cycles-pp.sendfile
     49.08            -1.7       47.34        perf-profile.children.cycles-pp.splice_to_socket
     49.32            -1.7       47.60        perf-profile.children.cycles-pp.direct_splice_actor
      7.42            -1.7        5.71        perf-profile.children.cycles-pp.mem_cgroup_charge_skmem
     44.88            -1.5       43.42        perf-profile.children.cycles-pp.sock_sendmsg
     43.20            -1.4       41.76        perf-profile.children.cycles-pp.tcp_sendmsg
      4.29 ±  2%      -1.1        3.14 ±  3%  perf-profile.children.cycles-pp.try_charge_memcg
      3.28 ±  5%      -0.7        2.63 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_state
      3.92            -0.6        3.29        perf-profile.children.cycles-pp.tcp_try_rmem_schedule
      2.11 ±  2%      -0.6        1.48 ±  4%  perf-profile.children.cycles-pp.page_counter_try_charge
     98.31            -0.6       97.70        perf-profile.children.cycles-pp.main
      8.04            -0.6        7.46        perf-profile.children.cycles-pp.filemap_splice_read
     14.26            -0.5       13.80        perf-profile.children.cycles-pp.__skb_datagram_iter
     14.30            -0.5       13.86        perf-profile.children.cycles-pp.skb_copy_datagram_iter
      5.63            -0.4        5.22        perf-profile.children.cycles-pp.skb_splice_from_iter
     10.77            -0.3       10.42        perf-profile.children.cycles-pp._copy_to_iter
      0.88            -0.3        0.59        perf-profile.children.cycles-pp.skb_attempt_defer_free
      2.63            -0.2        2.42        perf-profile.children.cycles-pp.filemap_get_pages
     93.38            -0.2       93.19        perf-profile.children.cycles-pp.do_syscall_64
      2.33            -0.2        2.13        perf-profile.children.cycles-pp.filemap_get_read_batch
      2.98            -0.2        2.81        perf-profile.children.cycles-pp.__sk_mem_reduce_allocated
      1.73            -0.2        1.58        perf-profile.children.cycles-pp.skb_append_pagefrags
      2.72            -0.1        2.58        perf-profile.children.cycles-pp.mem_cgroup_uncharge_skmem
      2.06            -0.1        1.93        perf-profile.children.cycles-pp.iov_iter_extract_pages
      1.68            -0.1        1.55        perf-profile.children.cycles-pp.splice_folio_into_pipe
      1.02            -0.1        0.92        perf-profile.children.cycles-pp.page_cache_pipe_buf_release
      0.25            -0.1        0.15 ±  2%  perf-profile.children.cycles-pp.__slab_free
      1.58 ±  2%      -0.1        1.49 ±  2%  perf-profile.children.cycles-pp.drain_stock
      1.59            -0.1        1.50        perf-profile.children.cycles-pp.touch_atime
      0.39 ±  8%      -0.1        0.30 ± 10%  perf-profile.children.cycles-pp.propagate_protected_usage
      1.04            -0.1        0.95        perf-profile.children.cycles-pp.folios_put_refs
      1.56 ±  2%      -0.1        1.47 ±  3%  perf-profile.children.cycles-pp.page_counter_uncharge
      1.42            -0.1        1.33        perf-profile.children.cycles-pp.atime_needs_update
      1.17            -0.1        1.09        perf-profile.children.cycles-pp.rw_verify_area
      0.26            -0.1        0.19        perf-profile.children.cycles-pp.__tcp_select_window
      0.91            -0.1        0.84        perf-profile.children.cycles-pp.security_file_permission
      2.27            -0.1        2.21        perf-profile.children.cycles-pp.simple_copy_to_iter
      0.68            -0.1        0.62        perf-profile.children.cycles-pp.apparmor_file_permission
      1.09 ±  2%      -0.1        1.03 ±  2%  perf-profile.children.cycles-pp.tcp_send_mss
      2.12            -0.1        2.06        perf-profile.children.cycles-pp.__check_object_size
      0.78            -0.1        0.73        perf-profile.children.cycles-pp.iov_iter_advance
      0.88            -0.1        0.83        perf-profile.children.cycles-pp._copy_from_user
      0.22            -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.tcp_check_space
      0.64            -0.0        0.59        perf-profile.children.cycles-pp.current_time
      0.64            -0.0        0.60        perf-profile.children.cycles-pp.__fsnotify_parent
      0.21            -0.0        0.17        perf-profile.children.cycles-pp.tcp_rbtree_insert
      0.88            -0.0        0.84        perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.32            -0.0        1.28        perf-profile.children.cycles-pp.check_heap_object
      0.84            -0.0        0.81        perf-profile.children.cycles-pp.tcp_event_new_data_sent
      0.18 ±  2%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.__tcp_ack_snd_check
      0.38            -0.0        0.36 ±  2%  perf-profile.children.cycles-pp.xas_load
      0.38            -0.0        0.35 ±  2%  perf-profile.children.cycles-pp.page_cache_pipe_buf_confirm
      0.71            -0.0        0.68        perf-profile.children.cycles-pp.netperf_sendfile
      0.27            -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.10            -0.0        0.08        perf-profile.children.cycles-pp.__tcp_cleanup_rbuf
      0.30            -0.0        0.29        perf-profile.children.cycles-pp.tcp_tso_segs
      0.26 ±  2%      -0.0        0.24        perf-profile.children.cycles-pp.aa_file_perm
      0.11 ±  3%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.run_builtin
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.tcp_downgrade_zcopy_pure
      0.40            -0.0        0.39        perf-profile.children.cycles-pp.rcu_all_qs
      0.19 ±  2%      -0.0        0.18        perf-profile.children.cycles-pp.xas_start
      0.18            -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.tcp_queue_rcv
      0.08 ±  4%      -0.0        0.07        perf-profile.children.cycles-pp.rb_insert_color
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.write
      0.12            -0.0        0.11        perf-profile.children.cycles-pp.demo_interval_tick
      0.12            -0.0        0.11        perf-profile.children.cycles-pp.make_vfsuid
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.__build_skb_around
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.neigh_hh_output
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.rb_erase
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.skb_network_protocol
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.detach_if_pending
      0.08            +0.0        0.09        perf-profile.children.cycles-pp.__copy_skb_header
      0.12            +0.0        0.13        perf-profile.children.cycles-pp.netif_skb_features
      0.16            +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.__refill_stock
      0.09            +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.ip_skb_dst_mtu
      0.05            +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.task_tick_fair
      0.08            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.sock_put
      0.61            +0.0        0.62        perf-profile.children.cycles-pp.__put_user_8
      0.07 ±  6%      +0.0        0.09        perf-profile.children.cycles-pp.tcp_event_data_recv
      0.09 ±  5%      +0.0        0.11        perf-profile.children.cycles-pp.tcp_inbound_hash
      0.06            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.add_wait_queue
      0.21            +0.0        0.23        perf-profile.children.cycles-pp.ip_rcv_core
      0.16 ±  2%      +0.0        0.18        perf-profile.children.cycles-pp.x64_sys_call
      0.12            +0.0        0.14 ±  2%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.23 ±  2%      +0.0        0.25        perf-profile.children.cycles-pp.inet_sendmsg
      0.05            +0.0        0.07        perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.05            +0.0        0.07        perf-profile.children.cycles-pp.remove_wait_queue
      0.06            +0.0        0.08        perf-profile.children.cycles-pp.__calc_delta
      0.11            +0.0        0.13        perf-profile.children.cycles-pp.ip_send_check
      0.07            +0.0        0.09        perf-profile.children.cycles-pp.place_entity
      0.07            +0.0        0.09        perf-profile.children.cycles-pp.tcp_ack_update_rtt
      0.60            +0.0        0.62        perf-profile.children.cycles-pp.__mod_timer
      0.27            +0.0        0.29        perf-profile.children.cycles-pp.tcp_rcv_space_adjust
      0.64            +0.0        0.66        perf-profile.children.cycles-pp.sk_reset_timer
      0.15 ±  2%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.__ip_finish_output
      0.10 ±  4%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.sched_tick
      0.08            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.05 ±  7%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.tcp_add_backlog
      0.16 ±  4%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.sk_filter_trim_cap
      0.47            +0.0        0.50        perf-profile.children.cycles-pp.tcp_schedule_loss_probe
      0.21            +0.0        0.24        perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.58            +0.0        0.61        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.11 ±  6%      +0.0        0.14 ±  8%  perf-profile.children.cycles-pp.__sk_dst_check
      0.08            +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.inet_ehashfn
      0.08            +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.tcp_v4_fill_cb
      0.16            +0.0        0.19        perf-profile.children.cycles-pp.bpf_skops_write_hdr_opt
      0.12 ±  3%      +0.0        0.15        perf-profile.children.cycles-pp.tcp_wfree
      0.12            +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.57            +0.0        0.60        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.19            +0.0        0.22        perf-profile.children.cycles-pp.__ip_local_out
      0.04 ± 44%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.blkcg_maybe_throttle_current
      0.23 ±  2%      +0.0        0.26        perf-profile.children.cycles-pp.validate_xmit_skb
      0.28            +0.0        0.31        perf-profile.children.cycles-pp.__netif_receive_skb_core
      0.09 ±  5%      +0.0        0.12        perf-profile.children.cycles-pp.__raise_softirq_irqoff
      0.10 ±  9%      +0.0        0.14 ±  9%  perf-profile.children.cycles-pp.ipv4_dst_check
      0.26 ±  4%      +0.0        0.29        perf-profile.children.cycles-pp.ip_output
      0.09            +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.20 ±  6%      +0.0        0.23 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.06 ± 45%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.cpuacct_charge
      0.07 ±  5%      +0.0        0.11        perf-profile.children.cycles-pp.mem_cgroup_handle_over_high
      0.22            +0.0        0.26        perf-profile.children.cycles-pp.ip_local_out
      0.11            +0.0        0.15        perf-profile.children.cycles-pp.avg_vruntime
      0.10 ±  3%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.update_min_vruntime
      0.07 ±  7%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.vruntime_eligible
      0.10 ±  3%      +0.0        0.14        perf-profile.children.cycles-pp.update_curr_se
      0.22 ±  6%      +0.0        0.27 ±  5%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.13 ±  3%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.update_rq_clock
      0.10 ±  4%      +0.0        0.15        perf-profile.children.cycles-pp.__get_user_8
      0.24 ±  6%      +0.0        0.28 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.09 ±  5%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.__enqueue_entity
      0.09            +0.1        0.14 ±  4%  perf-profile.children.cycles-pp.finish_task_switch
      0.18 ±  2%      +0.1        0.23        perf-profile.children.cycles-pp.recv_tcp_stream
      0.10 ±  4%      +0.1        0.15        perf-profile.children.cycles-pp.__dequeue_entity
      0.11 ±  4%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.update_cfs_group
      0.28 ±  6%      +0.1        0.33 ±  5%  perf-profile.children.cycles-pp.ip_rcv_finish_core
      0.30            +0.1        0.36        perf-profile.children.cycles-pp.kmalloc_reserve
      0.38 ±  4%      +0.1        0.44 ±  5%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.tcp_rtt_estimator
      0.13 ±  3%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.rseq_get_rseq_cs
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.select_idle_cpu
      0.39 ±  4%      +0.1        0.45 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__rb_insert_augmented
      0.16            +0.1        0.22        perf-profile.children.cycles-pp.os_xsave
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.resched_curr
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.tcp_grow_window
      0.20 ±  2%      +0.1        0.26        perf-profile.children.cycles-pp.sockfd_lookup_light
      0.46 ±  2%      +0.1        0.52        perf-profile.children.cycles-pp.tcp_mstamp_refresh
      0.14            +0.1        0.20        perf-profile.children.cycles-pp.rseq_update_cpu_node_id
      0.42 ±  4%      +0.1        0.48 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.29            +0.1        0.36        perf-profile.children.cycles-pp.reweight_entity
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.raw_local_deliver
      0.29 ±  2%      +0.1        0.36        perf-profile.children.cycles-pp.native_sched_clock
      0.22 ±  3%      +0.1        0.29 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.46 ±  4%      +0.1        0.52 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.dequeue_task
      0.58 ±  2%      +0.1        0.65 ±  2%  perf-profile.children.cycles-pp.ip_rcv
      0.33            +0.1        0.40        perf-profile.children.cycles-pp.sched_clock
      0.14 ± 28%      +0.1        0.22 ± 18%  perf-profile.children.cycles-pp.select_idle_sibling
      0.44            +0.1        0.52        perf-profile.children.cycles-pp.irqtime_account_irq
      0.36            +0.1        0.44        perf-profile.children.cycles-pp.enqueue_to_backlog
      0.38            +0.1        0.46        perf-profile.children.cycles-pp.sched_clock_cpu
      0.24            +0.1        0.32        perf-profile.children.cycles-pp.__switch_to_asm
      0.21            +0.1        0.29        perf-profile.children.cycles-pp.__tcp_send_ack
      0.19 ±  3%      +0.1        0.28        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.21 ±  2%      +0.1        0.30        perf-profile.children.cycles-pp.__update_load_avg_se
      0.39            +0.1        0.48        perf-profile.children.cycles-pp.netif_rx_internal
      0.41            +0.1        0.50        perf-profile.children.cycles-pp.__netif_rx
      0.22 ±  3%      +0.1        0.33 ±  2%  perf-profile.children.cycles-pp.___perf_sw_event
      0.24 ±  2%      +0.1        0.35        perf-profile.children.cycles-pp.rseq_ip_fixup
      0.22 ± 18%      +0.1        0.33 ± 12%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.27            +0.1        0.39        perf-profile.children.cycles-pp.__switch_to
      6.47            +0.1        6.60        perf-profile.children.cycles-pp.tcp_data_queue
      0.25 ± 14%      +0.1        0.38 ± 10%  perf-profile.children.cycles-pp.select_task_rq
      0.13 ±  3%      +0.1        0.26        perf-profile.children.cycles-pp.check_preempt_wakeup_fair
      0.33 ±  2%      +0.1        0.47        perf-profile.children.cycles-pp.dequeue_entity
      0.28            +0.1        0.42        perf-profile.children.cycles-pp.set_next_entity
      0.28            +0.1        0.42        perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.20 ±  2%      +0.1        0.34        perf-profile.children.cycles-pp.put_prev_entity
      0.41            +0.2        0.56        perf-profile.children.cycles-pp.enqueue_entity
      0.18 ±  2%      +0.2        0.34        perf-profile.children.cycles-pp.wakeup_preempt
      0.36            +0.2        0.52        perf-profile.children.cycles-pp.switch_fpu_return
      0.50 ±  4%      +0.2        0.68        perf-profile.children.cycles-pp.update_curr
      0.24            +0.2        0.42        perf-profile.children.cycles-pp.pick_eevdf
      0.39            +0.2        0.57        perf-profile.children.cycles-pp.prepare_task_switch
      0.43            +0.2        0.62        perf-profile.children.cycles-pp.__rseq_handle_notify_resume
     10.94            +0.2       11.14        perf-profile.children.cycles-pp.tcp_v4_rcv
      0.97            +0.2        1.17        perf-profile.children.cycles-pp.loopback_xmit
      1.06            +0.2        1.27        perf-profile.children.cycles-pp.dev_hard_start_xmit
      0.46            +0.3        0.71        perf-profile.children.cycles-pp.__kfree_skb
      0.60            +0.3        0.86        perf-profile.children.cycles-pp.update_load_avg
      0.76            +0.3        1.02        perf-profile.children.cycles-pp.enqueue_task_fair
      0.71            +0.3        1.00        perf-profile.children.cycles-pp.dequeue_task_fair
     11.14            +0.3       11.42        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     11.17            +0.3       11.46        perf-profile.children.cycles-pp.ip_local_deliver_finish
      0.94            +0.3        1.27        perf-profile.children.cycles-pp.kmem_cache_alloc_node_noprof
      0.73            +0.3        1.07        perf-profile.children.cycles-pp.switch_mm_irqs_off
      1.84            +0.4        2.19        perf-profile.children.cycles-pp.tcp_stream_alloc_skb
      1.28            +0.4        1.67        perf-profile.children.cycles-pp.__alloc_skb
     12.11            +0.4       12.52        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
      1.61            +0.4        2.02        perf-profile.children.cycles-pp.__cond_resched
      0.97            +0.4        1.42        perf-profile.children.cycles-pp.ttwu_do_activate
     12.51            +0.5       12.97        perf-profile.children.cycles-pp.process_backlog
     12.57            +0.5       13.04        perf-profile.children.cycles-pp.__napi_poll
      2.29            +0.5        2.77        perf-profile.children.cycles-pp.tcp_clean_rtx_queue
      0.84            +0.5        1.34        perf-profile.children.cycles-pp.pick_next_task_fair
     12.82            +0.5       13.35        perf-profile.children.cycles-pp.net_rx_action
     18.52            +0.6       19.11        perf-profile.children.cycles-pp.tcp_write_xmit
      2.83            +0.6        3.44        perf-profile.children.cycles-pp.tcp_ack
      1.63 ±  3%      +0.6        2.28        perf-profile.children.cycles-pp.try_to_wake_up
      1.76 ±  2%      +0.7        2.42        perf-profile.children.cycles-pp.__wake_up_common
     13.49            +0.7       14.17        perf-profile.children.cycles-pp.handle_softirqs
      1.85 ±  2%      +0.7        2.54        perf-profile.children.cycles-pp.__wake_up_sync_key
     13.63            +0.7       14.33        perf-profile.children.cycles-pp.do_softirq
      1.96 ±  2%      +0.7        2.66        perf-profile.children.cycles-pp.sock_def_readable
     13.99            +0.7       14.72        perf-profile.children.cycles-pp.__local_bh_enable_ip
      2.17            +0.9        3.04        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      2.33            +1.0        3.29        perf-profile.children.cycles-pp.schedule_timeout
      2.43            +1.0        3.42        perf-profile.children.cycles-pp.wait_woken
     15.82            +1.1       16.93        perf-profile.children.cycles-pp.__dev_queue_xmit
     24.86            +1.2       26.02        perf-profile.children.cycles-pp.tcp_recvmsg_locked
     16.25            +1.2       17.43        perf-profile.children.cycles-pp.ip_finish_output2
      2.68            +1.2        3.91        perf-profile.children.cycles-pp.sk_wait_data
      2.98            +1.3        4.28        perf-profile.children.cycles-pp.schedule
     25.22            +1.3       26.54        perf-profile.children.cycles-pp.tcp_recvmsg
     11.50            +1.3       12.83        perf-profile.children.cycles-pp.tcp_v4_do_rcv
     17.35            +1.4       18.70        perf-profile.children.cycles-pp.__ip_queue_xmit
     11.06            +1.4       12.41        perf-profile.children.cycles-pp.tcp_rcv_established
     25.33            +1.4       26.70        perf-profile.children.cycles-pp.inet_recvmsg
     25.48            +1.4       26.90        perf-profile.children.cycles-pp.sock_recvmsg
     18.93            +1.5       20.44        perf-profile.children.cycles-pp.__tcp_transmit_skb
     25.98            +1.5       27.52        perf-profile.children.cycles-pp.__sys_recvfrom
     26.03            +1.6       27.60        perf-profile.children.cycles-pp.__x64_sys_recvfrom
      3.58            +1.7        5.26        perf-profile.children.cycles-pp.__schedule
     27.11            +1.9       29.00        perf-profile.children.cycles-pp.accept_connection
     27.11            +1.9       29.00        perf-profile.children.cycles-pp.accept_connections
     27.11            +1.9       29.00        perf-profile.children.cycles-pp.process_requests
     27.11            +1.9       29.00        perf-profile.children.cycles-pp.spawn_child
      3.86            +2.0        5.83        perf-profile.children.cycles-pp.release_sock
      3.08            +2.0        5.06        perf-profile.children.cycles-pp.__release_sock
      7.02            +2.1        9.16        perf-profile.children.cycles-pp.__tcp_push_pending_frames
     27.70            +2.2       29.88        perf-profile.children.cycles-pp.recv
      7.88            -1.6        6.26        perf-profile.self.cycles-pp.__sk_mem_raise_allocated
      2.92 ±  5%      -0.7        2.26 ±  3%  perf-profile.self.cycles-pp.__mod_memcg_state
      1.89 ±  2%      -0.6        1.33 ±  3%  perf-profile.self.cycles-pp.page_counter_try_charge
      2.12 ±  2%      -0.5        1.60 ±  3%  perf-profile.self.cycles-pp.try_charge_memcg
     10.68            -0.3       10.36        perf-profile.self.cycles-pp._copy_to_iter
      1.95            -0.2        1.78        perf-profile.self.cycles-pp.filemap_get_read_batch
      1.64            -0.1        1.48        perf-profile.self.cycles-pp.skb_append_pagefrags
      2.69            -0.1        2.54        perf-profile.self.cycles-pp.splice_to_socket
      1.98            -0.1        1.84        perf-profile.self.cycles-pp.skb_splice_from_iter
      1.60            -0.1        1.47        perf-profile.self.cycles-pp.splice_folio_into_pipe
      0.97            -0.1        0.87        perf-profile.self.cycles-pp.page_cache_pipe_buf_release
      1.39            -0.1        1.30        perf-profile.self.cycles-pp.filemap_splice_read
      0.39 ±  8%      -0.1        0.30 ± 10%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.24 ±  2%      -0.1        0.14 ±  3%  perf-profile.self.cycles-pp.__slab_free
      1.02            -0.1        0.93        perf-profile.self.cycles-pp.folios_put_refs
      1.26            -0.1        1.18        perf-profile.self.cycles-pp.iov_iter_extract_pages
      0.25            -0.1        0.18        perf-profile.self.cycles-pp.__tcp_select_window
      1.24            -0.1        1.17        perf-profile.self.cycles-pp.do_sendfile
      1.28            -0.1        1.22        perf-profile.self.cycles-pp.tcp_sendmsg_locked
      0.86            -0.1        0.81        perf-profile.self.cycles-pp._copy_from_user
      0.72            -0.1        0.67        perf-profile.self.cycles-pp.iov_iter_advance
      0.21 ±  2%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.tcp_rbtree_insert
      0.62            -0.0        0.58        perf-profile.self.cycles-pp.__fsnotify_parent
      0.93            -0.0        0.89        perf-profile.self.cycles-pp.skb_release_data
      0.40 ±  2%      -0.0        0.36 ±  2%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.62            -0.0        0.59        perf-profile.self.cycles-pp.netperf_sendfile
      0.73            -0.0        0.70        perf-profile.self.cycles-pp.sock_sendmsg
      0.97            -0.0        0.94        perf-profile.self.cycles-pp.__skb_datagram_iter
      0.26            -0.0        0.23 ±  2%  perf-profile.self.cycles-pp.__sk_mem_reduce_allocated
      0.38            -0.0        0.36        perf-profile.self.cycles-pp.tcp_current_mss
      0.60            -0.0        0.57        perf-profile.self.cycles-pp.atime_needs_update
      0.42            -0.0        0.39        perf-profile.self.cycles-pp.current_time
      0.32            -0.0        0.29        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.51            -0.0        0.49        perf-profile.self.cycles-pp.check_heap_object
      0.31            -0.0        0.29        perf-profile.self.cycles-pp.page_cache_pipe_buf_confirm
      0.22            -0.0        0.20        perf-profile.self.cycles-pp.folio_mark_accessed
      0.26            -0.0        0.24        perf-profile.self.cycles-pp.security_file_permission
      0.28            -0.0        0.27        perf-profile.self.cycles-pp.tcp_tso_segs
      0.20            -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.simple_copy_to_iter
      0.25            -0.0        0.24 ±  2%  perf-profile.self.cycles-pp.rw_verify_area
      0.61            -0.0        0.60        perf-profile.self.cycles-pp.sendfile
      0.18 ±  2%      -0.0        0.17        perf-profile.self.cycles-pp.tcp_send_mss
      0.21 ±  2%      -0.0        0.20        perf-profile.self.cycles-pp.aa_file_perm
      0.14 ±  3%      -0.0        0.13 ±  2%  perf-profile.self.cycles-pp.do_splice_read
      0.30            -0.0        0.29        perf-profile.self.cycles-pp.filemap_get_pages
      0.31            -0.0        0.30        perf-profile.self.cycles-pp.rcu_all_qs
      0.08            -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.rb_insert_color
      0.19            -0.0        0.18        perf-profile.self.cycles-pp.xas_load
      0.09            -0.0        0.08        perf-profile.self.cycles-pp.make_vfsgid
      0.09            -0.0        0.08        perf-profile.self.cycles-pp.make_vfsuid
      0.16            -0.0        0.15        perf-profile.self.cycles-pp.security_socket_sendmsg
      0.10            +0.0        0.11        perf-profile.self.cycles-pp.validate_xmit_skb
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.__netif_receive_skb_one_core
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.__sk_dst_check
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.sched_clock_cpu
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.tcp_mstamp_refresh
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.tcp_inbound_hash
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.__ip_finish_output
      0.15            +0.0        0.16        perf-profile.self.cycles-pp.__refill_stock
      0.08            +0.0        0.09        perf-profile.self.cycles-pp.sock_from_file
      0.05            +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.eth_type_trans
      0.07            +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.tcp_event_data_recv
      0.08            +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__ip_local_out
      0.09 ±  4%      +0.0        0.10        perf-profile.self.cycles-pp.dev_hard_start_xmit
      0.15 ±  3%      +0.0        0.16        perf-profile.self.cycles-pp.x64_sys_call
      0.06            +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.detach_if_pending
      0.52            +0.0        0.53        perf-profile.self.cycles-pp.__cond_resched
      0.20 ±  2%      +0.0        0.22        perf-profile.self.cycles-pp.ip_rcv_core
      0.08 ±  5%      +0.0        0.10        perf-profile.self.cycles-pp.ip_skb_dst_mtu
      0.23            +0.0        0.25        perf-profile.self.cycles-pp.__mod_timer
      0.16            +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.inet_sendmsg
      0.06            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__calc_delta
      0.06            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__napi_poll
      0.10 ±  5%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.ip_protocol_deliver_rcu
      0.14 ±  3%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.tcp_schedule_loss_probe
      0.10 ±  3%      +0.0        0.12        perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.10 ±  3%      +0.0        0.12        perf-profile.self.cycles-pp.ip_send_check
      0.05 ±  8%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__tcp_ack_snd_check
      0.15 ±  3%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.do_softirq
      0.07 ±  5%      +0.0        0.09        perf-profile.self.cycles-pp.update_rq_clock_task
      0.05            +0.0        0.07        perf-profile.self.cycles-pp.__rseq_handle_notify_resume
      0.05            +0.0        0.07        perf-profile.self.cycles-pp.set_next_entity
      0.32            +0.0        0.34 ±  2%  perf-profile.self.cycles-pp.__x64_sys_sendfile64
      0.08            +0.0        0.10        perf-profile.self.cycles-pp.inet_ehashfn
      0.41            +0.0        0.43        perf-profile.self.cycles-pp.do_syscall_64
      0.25            +0.0        0.27        perf-profile.self.cycles-pp.mem_cgroup_uncharge_skmem
      0.56            +0.0        0.58        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.40            +0.0        0.42        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.20 ±  2%      +0.0        0.23 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.08 ±  6%      +0.0        0.10        perf-profile.self.cycles-pp.tcp_v4_fill_cb
      0.17            +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.ip_output
      0.08            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.10 ±  8%      +0.0        0.12 ±  8%  perf-profile.self.cycles-pp.ipv4_dst_check
      0.12 ±  4%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.recv
      0.05            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__x64_sys_recvfrom
      0.03 ± 70%      +0.0        0.06        perf-profile.self.cycles-pp.kmalloc_reserve
      0.07 ±  6%      +0.0        0.10        perf-profile.self.cycles-pp.sock_recvmsg
      0.12 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.tcp_wfree
      0.15            +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.bpf_skops_write_hdr_opt
      0.13 ±  3%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.enqueue_to_backlog
      0.08            +0.0        0.11        perf-profile.self.cycles-pp.__raise_softirq_irqoff
      0.06 ±  6%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.06            +0.0        0.09        perf-profile.self.cycles-pp.dequeue_entity
      0.07            +0.0        0.10        perf-profile.self.cycles-pp.switch_fpu_return
      0.10 ±  3%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.tcp_v4_do_rcv
      0.07 ±  5%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.finish_task_switch
      0.07            +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.06 ±  6%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.schedule
      0.33            +0.0        0.36        perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.28            +0.0        0.31        perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.06            +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.enqueue_entity
      0.19            +0.0        0.22        perf-profile.self.cycles-pp.process_backlog
      0.06 ±  6%      +0.0        0.09        perf-profile.self.cycles-pp.vruntime_eligible
      0.11            +0.0        0.14 ±  2%  perf-profile.self.cycles-pp.reweight_entity
      0.15 ±  2%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.17            +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.tcp_rcv_established
      0.09 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.update_min_vruntime
      0.03 ± 70%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.07            +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.mem_cgroup_handle_over_high
      0.08 ±  5%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.06 ± 45%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.cpuacct_charge
      0.15 ±  3%      +0.0        0.19        perf-profile.self.cycles-pp.recv_tcp_stream
      0.08 ±  4%      +0.0        0.12        perf-profile.self.cycles-pp.try_to_wake_up
      0.08 ±  4%      +0.0        0.12        perf-profile.self.cycles-pp.update_curr_se
      0.09 ±  4%      +0.0        0.13        perf-profile.self.cycles-pp.wait_woken
      0.10 ±  3%      +0.0        0.14        perf-profile.self.cycles-pp.avg_vruntime
      0.08 ±  6%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__dequeue_entity
      0.14 ±  2%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.tcp_recvmsg
      0.31            +0.0        0.35        perf-profile.self.cycles-pp.__ip_queue_xmit
      0.09 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.schedule_timeout
      0.02 ± 99%      +0.0        0.07        perf-profile.self.cycles-pp.blkcg_maybe_throttle_current
      0.11 ±  4%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.sk_wait_data
      0.24            +0.0        0.29        perf-profile.self.cycles-pp.__alloc_skb
      0.28            +0.0        0.32        perf-profile.self.cycles-pp.loopback_xmit
      0.10            +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.__get_user_8
      0.09            +0.1        0.14        perf-profile.self.cycles-pp.__enqueue_entity
      0.11            +0.1        0.16        perf-profile.self.cycles-pp.inet_recvmsg
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__rb_insert_augmented
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__tcp_cleanup_rbuf
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.resched_curr
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.select_task_rq
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.tcp_rcv_space_adjust
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.tcp_rtt_estimator
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.validate_xmit_xfrm
      0.10 ±  4%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.update_cfs_group
      0.27 ±  5%      +0.1        0.32 ±  5%  perf-profile.self.cycles-pp.ip_rcv_finish_core
      0.21            +0.1        0.26        perf-profile.self.cycles-pp.net_rx_action
      0.22 ±  2%      +0.1        0.27        perf-profile.self.cycles-pp.tcp_clean_rtx_queue
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.raw_local_deliver
      0.30            +0.1        0.36        perf-profile.self.cycles-pp.tcp_v4_rcv
      0.23            +0.1        0.29        perf-profile.self.cycles-pp.handle_softirqs
      0.14 ±  2%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.rseq_update_cpu_node_id
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.__release_sock
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.rseq_ip_fixup
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.tcp_grow_window
      0.16 ±  2%      +0.1        0.22        perf-profile.self.cycles-pp.os_xsave
      0.17 ±  6%      +0.1        0.23        perf-profile.self.cycles-pp.update_curr
      0.38 ±  2%      +0.1        0.45 ±  2%  perf-profile.self.cycles-pp.ip_finish_output2
      0.28 ±  2%      +0.1        0.35        perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.dequeue_task
      0.26            +0.1        0.33        perf-profile.self.cycles-pp.__sys_recvfrom
      0.21 ±  2%      +0.1        0.28        perf-profile.self.cycles-pp._raw_spin_lock
      0.28            +0.1        0.35        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.14            +0.1        0.21        perf-profile.self.cycles-pp.pick_next_task_fair
      0.80            +0.1        0.88        perf-profile.self.cycles-pp.__tcp_transmit_skb
      0.19 ±  2%      +0.1        0.27        perf-profile.self.cycles-pp.__update_load_avg_se
      0.42            +0.1        0.49        perf-profile.self.cycles-pp.tcp_ack
      0.24            +0.1        0.32        perf-profile.self.cycles-pp.__switch_to_asm
      0.31            +0.1        0.39        perf-profile.self.cycles-pp.kmem_cache_free
      0.18 ±  3%      +0.1        0.26 ±  2%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.16 ±  2%      +0.1        0.25        perf-profile.self.cycles-pp.prepare_task_switch
      0.20 ±  3%      +0.1        0.28 ±  3%  perf-profile.self.cycles-pp.___perf_sw_event
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.check_preempt_wakeup_fair
      0.21            +0.1        0.31        perf-profile.self.cycles-pp.update_load_avg
      0.41            +0.1        0.51        perf-profile.self.cycles-pp.tcp_recvmsg_locked
      0.50            +0.1        0.60        perf-profile.self.cycles-pp.kmem_cache_alloc_node_noprof
      0.26            +0.1        0.37        perf-profile.self.cycles-pp.__switch_to
      0.28 ±  2%      +0.1        0.42        perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.17 ±  2%      +0.1        0.32        perf-profile.self.cycles-pp.pick_eevdf
      0.42 ±  2%      +0.2        0.60        perf-profile.self.cycles-pp.__schedule
      0.72            +0.3        1.05        perf-profile.self.cycles-pp.switch_mm_irqs_off


***************************************************************************************************
lkp-csl-2sp3: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/nr_threads/rootfs/tbox_group/testcase:
  gcc-13/performance/1HDD/nfs/btrfs/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-csl-2sp3/dbench

commit: 
  402de7fc88 ("sched: Fix spelling in comments")
  e2ee0a922a ("sched/fair: Reschedule the cfs_rq when current is ineligible")

402de7fc880fef05 e2ee0a922a6a2a8377dc66435c9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    237176 ±  7%     -28.7%     169098 ±  2%  meminfo.Mapped
    159.50 ± 66%    +329.6%     685.20 ± 68%  numa-vmstat.node1.nr_dirtied
     66733 ±  3%     -12.7%      58283        vmstat.system.in
      0.21 ±  2%      -0.0        0.18 ±  3%  mpstat.cpu.all.irq%
      3.90 ±  3%      -0.6        3.26        mpstat.cpu.all.soft%
      0.60 ±203%    +800.0%       5.40 ± 73%  sched_debug.cfs_rq:/.runnable_avg.min
      0.30 ±213%   +1583.3%       5.05 ± 77%  sched_debug.cfs_rq:/.util_avg.min
    360473 ± 10%     -23.4%     276238 ±  6%  sched_debug.cpu.avg_idle.stddev
    389.20 ±  6%     -25.9%     288.40 ±  4%  perf-c2c.DRAM.local
      4949 ±  9%     +16.7%       5776 ±  4%  perf-c2c.DRAM.remote
      8635 ±  3%     -12.6%       7544 ±  3%  perf-c2c.HITM.local
      3963 ±  9%     +15.9%       4595 ±  4%  perf-c2c.HITM.remote
     35.35 ±  8%     -64.1%      12.70 ±  8%  dbench.max_latency
     35.35 ±  8%     -64.1%      12.70 ±  8%  dbench.max_latency_harmonic_mean
    212.89            -6.5%     199.14        dbench.throughput_MB/s
    212.89            -6.5%     199.14        dbench.throughput_MB/s_harmonic_mean
     17023 ± 12%     +53.4%      26117        dbench.time.involuntary_context_switches
    114662            -4.7%     109219        dbench.time.minor_page_faults
    244.68            +2.4%     250.48        dbench.time.user_time
  30003746            -6.4%   28075820        dbench.time.voluntary_context_switches
    282969 ±  4%      -6.2%     265530 ±  2%  proc-vmstat.nr_active_anon
     59985 ±  7%     -28.3%      42979 ±  2%  proc-vmstat.nr_mapped
     26918            -2.0%      26390        proc-vmstat.nr_slab_reclaimable
     88407            -7.9%      81453        proc-vmstat.nr_slab_unreclaimable
    282969 ±  4%      -6.2%     265530 ±  2%  proc-vmstat.nr_zone_active_anon
  28594377            -7.9%   26346328        proc-vmstat.numa_hit
  28481941            -7.8%   26249337        proc-vmstat.numa_local
     33252 ± 19%    +162.1%      87140 ± 13%  proc-vmstat.pgactivate
  30247477            -9.4%   27414535        proc-vmstat.pgalloc_normal
  29597564            -9.5%   26791797        proc-vmstat.pgfree
      3.37 ±  3%     +24.6%       4.20        perf-stat.i.MPKI
     25.62 ±  3%      +3.6       29.21        perf-stat.i.cache-miss-rate%
 1.106e+08 ±  3%     +21.2%  1.341e+08        perf-stat.i.cache-misses
 4.296e+08 ±  2%      +6.8%  4.586e+08        perf-stat.i.cache-references
      1.98            +3.9%       2.06        perf-stat.i.cpi
    182078 ±  4%     +26.0%     229499        perf-stat.i.cpu-migrations
    632.11 ±  5%     -22.3%     491.02        perf-stat.i.cycles-between-cache-misses
      0.51            -3.9%       0.49        perf-stat.i.ipc
    591.86 ±  2%     -33.8%     391.83 ± 50%  perf-stat.overall.cycles-between-cache-misses
      0.51           -23.2%       0.39 ± 50%  perf-stat.overall.ipc
 2.111e+12           -23.3%   1.62e+12 ± 50%  perf-stat.total.instructions



***************************************************************************************************
lkp-icl-2sp7: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/memfd/stress-ng/60s

commit: 
  402de7fc88 ("sched: Fix spelling in comments")
  e2ee0a922a ("sched/fair: Reschedule the cfs_rq when current is ineligible")

402de7fc880fef05 e2ee0a922a6a2a8377dc66435c9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     36062 ±  5%     -14.0%      31010 ±  2%  cpuidle..usage
      4042 ±  5%    +398.2%      20141 ±  2%  vmstat.system.cs
      0.01 ± 72%      +0.0        0.02 ±  9%  mpstat.cpu.all.iowait%
      2.31            -2.2        0.14 ±  5%  mpstat.cpu.all.soft%
  73789672           +14.8%   84716176        numa-numastat.node0.local_node
  73832662           +14.8%   84764335        numa-numastat.node0.numa_hit
  76238116           +11.1%   84689987        numa-numastat.node1.local_node
  76266663           +11.1%   84748882        numa-numastat.node1.numa_hit
     31700           -11.1%      28189        stress-ng.memfd.nanosecs_per_memfd_create_call
    139500           +16.3%     162299        stress-ng.memfd.ops
      2324           +16.3%       2704        stress-ng.memfd.ops_per_sec
    106944 ±  8%    +457.9%     596631 ±  2%  stress-ng.time.involuntary_context_switches
 1.428e+08           +16.3%  1.662e+08        stress-ng.time.minor_page_faults
     55.32           +17.9%      65.22        stress-ng.time.user_time
    160156 ±  6%     -35.0%     104171 ± 10%  numa-meminfo.node0.SUnreclaim
    227326 ± 10%     -27.9%     163968 ± 14%  numa-meminfo.node0.Slab
    162779 ±  8%     +45.6%     237012 ±  7%  numa-meminfo.node1.Active
    162769 ±  8%     +45.6%     236996 ±  7%  numa-meminfo.node1.Active(anon)
    149751 ±  9%     -35.1%      97155 ± 11%  numa-meminfo.node1.SUnreclaim
    317358 ±  5%     +29.2%     410166 ± 11%  numa-meminfo.node1.Shmem
    219365 ±  9%     -35.2%     142218 ± 17%  numa-meminfo.node1.Slab
    192413 ±  5%     +32.5%     254873 ±  3%  meminfo.Active
    192381 ±  5%     +32.5%     254841 ±  3%  meminfo.Active(anon)
    678002 ±  2%      -9.1%     616100 ±  4%  meminfo.AnonPages
    137119           -23.5%     104865        meminfo.KReclaimable
    137119           -23.5%     104865        meminfo.SReclaimable
    309291 ±  2%     -34.9%     201443        meminfo.SUnreclaim
    458272 ±  3%     +14.8%     526038 ±  2%  meminfo.Shmem
    446411 ±  2%     -31.4%     306308        meminfo.Slab
     41084 ±  8%     -36.4%      26144 ± 10%  numa-vmstat.node0.nr_slab_unreclaimable
  73881178           +14.9%   84853492        numa-vmstat.node0.numa_hit
  73838188           +14.9%   84805335        numa-vmstat.node0.numa_local
     41870 ±  8%     +38.4%      57951 ±  7%  numa-vmstat.node1.nr_active_anon
     79475 ±  6%     +28.1%     101838 ± 11%  numa-vmstat.node1.nr_shmem
     38446 ±  7%     -36.6%      24360 ± 11%  numa-vmstat.node1.nr_slab_unreclaimable
     41870 ±  8%     +38.4%      57951 ±  7%  numa-vmstat.node1.nr_zone_active_anon
  76315342           +11.2%   84828985        numa-vmstat.node1.numa_hit
  76286795           +11.1%   84770091        numa-vmstat.node1.numa_local
     41008 ± 11%     +55.7%      63860 ± 12%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      7.00 ±  4%    +133.3%      16.33 ± 30%  sched_debug.cfs_rq:/.load_avg.min
     41003 ± 11%     +55.7%      63860 ± 12%  sched_debug.cfs_rq:/.min_vruntime.stddev
     16.52 ± 39%     -51.6%       7.99 ± 64%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
     16.52 ± 39%     -51.6%       7.99 ± 64%  sched_debug.cfs_rq:/.removed.util_avg.avg
    199.90 ±  7%     -18.8%     162.35 ±  5%  sched_debug.cfs_rq:/.util_avg.stddev
      3785 ±  3%    +202.7%      11458        sched_debug.cpu.nr_switches.avg
     18169 ± 11%     +52.5%      27700 ± 21%  sched_debug.cpu.nr_switches.max
      1101 ± 16%    +664.8%       8425 ±  2%  sched_debug.cpu.nr_switches.min
     48115 ±  5%     +28.7%      61939 ±  3%  proc-vmstat.nr_active_anon
    169890 ±  2%     -10.3%     152369 ±  4%  proc-vmstat.nr_anon_pages
    884771            +1.9%     901447        proc-vmstat.nr_file_pages
    233312 ±  2%      -6.3%     218711 ±  3%  proc-vmstat.nr_inactive_anon
     58092 ±  2%      +6.7%      61996 ±  3%  proc-vmstat.nr_mapped
    113782 ±  3%     +14.7%     130462 ±  2%  proc-vmstat.nr_shmem
     34106           -23.1%      26214        proc-vmstat.nr_slab_reclaimable
     77371 ±  2%     -34.8%      50478        proc-vmstat.nr_slab_unreclaimable
     48115 ±  5%     +28.7%      61939 ±  3%  proc-vmstat.nr_zone_active_anon
    233312 ±  2%      -6.3%     218711 ±  3%  proc-vmstat.nr_zone_inactive_anon
 1.501e+08           +12.6%  1.691e+08        proc-vmstat.numa_hit
 1.501e+08           +12.6%   1.69e+08        proc-vmstat.numa_local
    115231 ±  8%     +13.0%     130198        proc-vmstat.pgactivate
 1.624e+08            +6.3%  1.726e+08        proc-vmstat.pgalloc_normal
 1.434e+08           +15.9%  1.662e+08        proc-vmstat.pgfault
 1.618e+08            +6.4%  1.721e+08        proc-vmstat.pgfree
      3.61            -8.4%       3.31        perf-stat.i.MPKI
 1.075e+10            +9.7%  1.179e+10        perf-stat.i.branch-instructions
      0.54 ±  9%      -0.1        0.45 ±  4%  perf-stat.i.branch-miss-rate%
     70.80            -9.4       61.39        perf-stat.i.cache-miss-rate%
 2.599e+08           +16.5%  3.028e+08        perf-stat.i.cache-references
      4011 ±  5%    +414.3%      20630 ±  2%  perf-stat.i.context-switches
      3.75            -8.7%       3.43        perf-stat.i.cpi
    142.79           +31.3%     187.45 ±  7%  perf-stat.i.cpu-migrations
 5.108e+10           +10.3%  5.633e+10        perf-stat.i.instructions
      0.27 ±  2%      +8.7%       0.30        perf-stat.i.ipc
     73.02           +16.9%      85.40        perf-stat.i.metric.K/sec
   2339769           +16.8%    2733066        perf-stat.i.minor-faults
   2339769           +16.8%    2733067        perf-stat.i.page-faults
      3.61            -8.7%       3.29        perf-stat.overall.MPKI
      0.52 ±  2%      -0.1        0.46 ±  4%  perf-stat.overall.branch-miss-rate%
     70.91            -9.6       61.30        perf-stat.overall.cache-miss-rate%
      3.79            -8.9%       3.45        perf-stat.overall.cpi
      0.26            +9.8%       0.29        perf-stat.overall.ipc
 1.057e+10            +9.8%  1.161e+10        perf-stat.ps.branch-instructions
 2.555e+08           +16.6%   2.98e+08        perf-stat.ps.cache-references
      3919 ±  5%    +417.4%      20278 ±  2%  perf-stat.ps.context-switches
    140.57           +30.4%     183.31 ±  7%  perf-stat.ps.cpu-migrations
 5.022e+10           +10.4%  5.544e+10        perf-stat.ps.instructions
   2300288           +16.9%    2689253        perf-stat.ps.minor-faults
   2300289           +16.9%    2689253        perf-stat.ps.page-faults
 3.091e+12            +9.8%  3.392e+12        perf-stat.total.instructions
     12.22 ±  3%      -3.6        8.58 ±  6%  perf-profile.calltrace.cycles-pp.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.27 ±  3%      -3.6        8.64 ±  5%  perf-profile.calltrace.cycles-pp.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     12.32 ±  3%      -3.6        8.70 ±  5%  perf-profile.calltrace.cycles-pp.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     12.38 ±  3%      -3.6        8.76 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fallocate64
     12.36 ±  3%      -3.6        8.74 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     12.58 ±  3%      -3.6        9.00 ±  5%  perf-profile.calltrace.cycles-pp.fallocate64
      6.96 ±  4%      -2.3        4.63 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs
      7.28 ±  4%      -2.3        4.98 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.shmem_undo_range
     33.23            -2.1       31.11        perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.task_work_run
     27.02            -2.1       24.92        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.evict.__dentry_kill.dput
     27.28            -2.1       25.20        perf-profile.calltrace.cycles-pp._raw_spin_lock.evict.__dentry_kill.dput.__fput
      4.56 ±  4%      -2.0        2.57 ± 10%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
      4.74 ±  4%      -2.0        2.77 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain
      4.80 ±  4%      -2.0        2.84 ±  8%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.shmem_undo_range.shmem_fallocate
      4.75 ±  4%      -2.0        2.78 ±  9%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.zap_page_range_single
      4.96 ±  4%      -1.9        3.01 ±  8%  perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.shmem_undo_range.shmem_fallocate.vfs_fallocate
      5.49 ±  3%      -1.9        3.56 ±  7%  perf-profile.calltrace.cycles-pp.folios_put_refs.shmem_undo_range.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate
      5.49 ±  3%      -1.9        3.57 ±  7%  perf-profile.calltrace.cycles-pp.lru_add_drain.zap_page_range_single.unmap_mapping_range.shmem_fallocate.vfs_fallocate
      5.48 ±  3%      -1.9        3.56 ±  7%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.zap_page_range_single.unmap_mapping_range
      5.49 ±  3%      -1.9        3.57 ±  7%  perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.zap_page_range_single.unmap_mapping_range.shmem_fallocate
      5.95 ±  3%      -1.9        4.09 ±  6%  perf-profile.calltrace.cycles-pp.shmem_undo_range.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      6.00 ±  3%      -1.8        4.17 ±  6%  perf-profile.calltrace.cycles-pp.zap_page_range_single.unmap_mapping_range.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate
     34.48            -1.8       32.65        perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.task_work_run.syscall_exit_to_user_mode
      6.04 ±  3%      -1.8        4.22 ±  6%  perf-profile.calltrace.cycles-pp.unmap_mapping_range.shmem_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
     34.56            -1.8       32.74        perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.syscall_exit_to_user_mode.do_syscall_64
     35.00            -1.8       33.23        perf-profile.calltrace.cycles-pp.__fput.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35.32            -1.8       33.56        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     35.32            -1.8       33.56        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
     35.32            -1.8       33.57        perf-profile.calltrace.cycles-pp.syscall
     35.15            -1.8       33.40        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     35.15            -1.7       33.40        perf-profile.calltrace.cycles-pp.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      0.59 ± 11%      -0.3        0.34 ± 70%  perf-profile.calltrace.cycles-pp.__mark_inode_dirty.generic_update_time.touch_atime.shmem_mmap.mmap_region
      1.10            -0.2        0.95        perf-profile.calltrace.cycles-pp.shmem_add_to_page_cache.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault.__do_fault
      0.60 ± 10%      -0.1        0.52        perf-profile.calltrace.cycles-pp.generic_update_time.touch_atime.shmem_mmap.mmap_region.do_mmap
      1.14            -0.1        1.09        perf-profile.calltrace.cycles-pp.alloc_inode.new_inode.__shmem_get_inode.__shmem_file_setup.__do_sys_memfd_create
      1.11            -0.0        1.07        perf-profile.calltrace.cycles-pp.xas_find.find_lock_entries.shmem_undo_range.shmem_evict_inode.evict
      0.70            -0.0        0.68        perf-profile.calltrace.cycles-pp.shmem_file_llseek.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      1.34            +0.1        1.40        perf-profile.calltrace.cycles-pp.llseek
      0.55 ±  2%      +0.1        0.62        perf-profile.calltrace.cycles-pp.notify_change.do_truncate.do_ftruncate.__x64_sys_ftruncate.do_syscall_64
      0.80 ±  2%      +0.1        0.86        perf-profile.calltrace.cycles-pp.do_truncate.do_ftruncate.__x64_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.52            +0.1        0.60        perf-profile.calltrace.cycles-pp.alloc_empty_file.alloc_file_pseudo.__shmem_file_setup.__do_sys_memfd_create.do_syscall_64
      0.56            +0.1        0.64        perf-profile.calltrace.cycles-pp.truncate_inode_folio.shmem_undo_range.shmem_evict_inode.evict.__dentry_kill
      0.59            +0.1        0.70        perf-profile.calltrace.cycles-pp.clear_nlink.__shmem_file_setup.__do_sys_memfd_create.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.64            +0.1        0.75        perf-profile.calltrace.cycles-pp.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.54            +0.1        0.67        perf-profile.calltrace.cycles-pp.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      1.05            +0.2        1.20        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
      1.49            +0.2        1.64        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      1.06            +0.2        1.22        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
      1.17            +0.2        1.33        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      1.10            +0.2        1.26        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      1.36 ±  2%      +0.2        1.53        perf-profile.calltrace.cycles-pp.do_ftruncate.__x64_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
      1.46 ±  2%      +0.2        1.65        perf-profile.calltrace.cycles-pp.__x64_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
      1.49 ±  2%      +0.2        1.68        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ftruncate64
      1.48 ±  2%      +0.2        1.67        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
      0.83 ±  3%      +0.2        1.03        perf-profile.calltrace.cycles-pp.__destroy_inode.destroy_inode.__dentry_kill.dput.__fput
      0.83 ±  3%      +0.2        1.04        perf-profile.calltrace.cycles-pp.destroy_inode.__dentry_kill.dput.__fput.task_work_run
      1.57 ±  2%      +0.2        1.78        perf-profile.calltrace.cycles-pp.ftruncate64
      0.56            +0.2        0.77        perf-profile.calltrace.cycles-pp.inode_init_always.alloc_inode.new_inode.__shmem_get_inode.__shmem_file_setup
      1.31            +0.2        1.53        perf-profile.calltrace.cycles-pp.alloc_file_pseudo.__shmem_file_setup.__do_sys_memfd_create.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.96            +0.2        1.18        perf-profile.calltrace.cycles-pp.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      3.28            +0.3        3.58        perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      2.41            +0.3        2.74        perf-profile.calltrace.cycles-pp.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault
      0.17 ±141%      +0.4        0.53 ±  2%  perf-profile.calltrace.cycles-pp.__mem_cgroup_uncharge_folios.folios_put_refs.shmem_undo_range.shmem_evict_inode.evict
      2.84            +0.4        3.22        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      3.75            +0.4        4.13        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.68            +0.4        2.06        perf-profile.calltrace.cycles-pp.clear_page_erms.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault
      3.02            +0.4        3.41        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.07            +0.4        3.46        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      3.07            +0.4        3.46        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      3.09            +0.4        3.48        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      3.10            +0.4        3.49        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
      3.93            +0.4        4.33        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      3.99            +0.4        4.40        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      3.97            +0.4        4.38        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      4.00            +0.4        4.41        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
      3.20            +0.4        3.61        perf-profile.calltrace.cycles-pp.__munmap
      4.33            +0.5        4.80        perf-profile.calltrace.cycles-pp.__mmap
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.file_init_path.alloc_file_pseudo.__shmem_file_setup.__do_sys_memfd_create.do_syscall_64
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.filemap_remove_folio.truncate_inode_folio.shmem_undo_range.shmem_evict_inode.evict
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.stress_memfd_child
      0.00            +0.5        0.53        perf-profile.calltrace.cycles-pp.unmap_page_range.zap_page_range_single.unmap_mapping_range.shmem_fallocate.vfs_fallocate
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs
      0.00            +0.6        0.60 ±  3%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_noprof.alloc_pages_mpol_noprof.shmem_alloc_folio.shmem_alloc_and_add_folio
      0.00            +0.7        0.71 ±  2%  perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp
      0.00            +0.8        0.77 ±  2%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault
      0.00            +0.8        0.85 ±  2%  perf-profile.calltrace.cycles-pp.shmem_alloc_folio.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_fault.__do_fault
      0.00            +0.9        0.93        perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs
      6.66            +1.2        7.87        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fault.__do_fault.do_fault.__handle_mm_fault
      6.74            +1.2        7.96        perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault
      6.77            +1.2        8.01        perf-profile.calltrace.cycles-pp.__do_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      7.45            +1.3        8.78        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.63 ±  9%      +1.3        1.97        perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
      7.66            +1.4        9.04        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      7.95            +1.4        9.38        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_memfd_child
      8.37            +1.5        9.87        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.stress_memfd_child
      8.40            +1.5        9.91        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.stress_memfd_child
      9.69            +1.7       11.43        perf-profile.calltrace.cycles-pp.stress_memfd_child
     10.09            +1.8       11.92        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.stress_memfd_child
      0.89 ±  9%      +1.9        2.74        perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn
      0.90 ±  9%      +1.9        2.78        perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread
      0.90 ±  9%      +1.9        2.80        perf-profile.calltrace.cycles-pp.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      0.90 ±  9%      +1.9        2.80        perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.94 ±  8%      +1.9        2.87        perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      0.94 ±  8%      +1.9        2.87        perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      0.94 ±  8%      +1.9        2.87        perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      0.90 ±  9%      +1.9        2.83        perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     64.51            -6.5       58.04        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     12.04 ±  4%      -4.3        7.78 ±  8%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     12.21 ±  3%      -4.1        8.15 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     87.27            -4.0       83.26        perf-profile.children.cycles-pp.do_syscall_64
     87.36            -4.0       83.36        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     12.22 ±  3%      -3.6        8.58 ±  6%  perf-profile.children.cycles-pp.shmem_fallocate
     12.27 ±  3%      -3.6        8.64 ±  5%  perf-profile.children.cycles-pp.vfs_fallocate
     12.33 ±  3%      -3.6        8.70 ±  5%  perf-profile.children.cycles-pp.__x64_sys_fallocate
     12.62 ±  3%      -3.6        9.04 ±  5%  perf-profile.children.cycles-pp.fallocate64
      7.65 ±  3%      -2.2        5.41 ±  7%  perf-profile.children.cycles-pp.__page_cache_release
     54.34            -2.1       52.19        perf-profile.children.cycles-pp._raw_spin_lock
      9.07 ±  3%      -2.1        6.92 ±  6%  perf-profile.children.cycles-pp.folios_put_refs
     33.52            -2.1       31.39        perf-profile.children.cycles-pp.evict
     11.42 ±  2%      -2.0        9.46 ±  4%  perf-profile.children.cycles-pp.shmem_undo_range
      5.49 ±  3%      -1.9        3.56 ±  7%  perf-profile.children.cycles-pp.folio_batch_move_lru
      5.52 ±  3%      -1.9        3.60 ±  7%  perf-profile.children.cycles-pp.lru_add_drain
      5.53 ±  3%      -1.9        3.61 ±  7%  perf-profile.children.cycles-pp.lru_add_drain_cpu
     34.78            -1.8       32.94        perf-profile.children.cycles-pp.__dentry_kill
      6.01 ±  3%      -1.8        4.17 ±  6%  perf-profile.children.cycles-pp.zap_page_range_single
     34.86            -1.8       33.03        perf-profile.children.cycles-pp.dput
      6.05 ±  3%      -1.8        4.22 ±  6%  perf-profile.children.cycles-pp.unmap_mapping_range
     35.31            -1.8       33.54        perf-profile.children.cycles-pp.__fput
     35.32            -1.8       33.57        perf-profile.children.cycles-pp.syscall
     35.16            -1.7       33.41        perf-profile.children.cycles-pp.task_work_run
     35.24            -1.7       33.51        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.61 ±  5%      -1.5        0.12 ±  3%  perf-profile.children.cycles-pp.irq_exit_rcu
      2.02 ±  4%      -1.4        0.58 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      2.05 ±  4%      -1.4        0.62 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.10            -0.7        0.36        perf-profile.children.cycles-pp.allocate_slab
      1.00            -0.7        0.29        perf-profile.children.cycles-pp.shuffle_freelist
      1.28            -0.7        0.62        perf-profile.children.cycles-pp.___slab_alloc
      0.86            -0.6        0.24 ±  2%  perf-profile.children.cycles-pp.setup_object
      1.22            -0.5        0.72        perf-profile.children.cycles-pp.kmem_cache_alloc_lru_noprof
      0.58            -0.3        0.32        perf-profile.children.cycles-pp.shmem_alloc_inode
      0.53 ±  2%      -0.3        0.26        perf-profile.children.cycles-pp.xas_alloc
      0.55            -0.3        0.29        perf-profile.children.cycles-pp.xas_expand
      0.36 ±  2%      -0.3        0.10 ±  4%  perf-profile.children.cycles-pp.inode_init_once
      0.64            -0.2        0.40        perf-profile.children.cycles-pp.xas_create
      0.93            -0.2        0.75        perf-profile.children.cycles-pp.xas_store
      0.24 ±  3%      -0.2        0.06 ±  7%  perf-profile.children.cycles-pp.radix_tree_node_ctor
      1.12            -0.2        0.97        perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.41 ± 16%      -0.1        0.32 ±  3%  perf-profile.children.cycles-pp.locked_inode_to_wb_and_lock_list
      0.61 ± 10%      -0.1        0.52 ±  2%  perf-profile.children.cycles-pp.generic_update_time
      0.59 ± 10%      -0.1        0.51        perf-profile.children.cycles-pp.__mark_inode_dirty
      0.11 ±  5%      -0.1        0.05        perf-profile.children.cycles-pp.__init_rwsem
      1.15            -0.1        1.10        perf-profile.children.cycles-pp.alloc_inode
      0.54            -0.0        0.49 ±  2%  perf-profile.children.cycles-pp.down_write
      1.30            -0.0        1.26        perf-profile.children.cycles-pp.xas_find
      0.24 ±  2%      -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      1.21            -0.0        1.18        perf-profile.children.cycles-pp.__slab_free
      0.41            -0.0        0.38        perf-profile.children.cycles-pp.vm_area_alloc
      0.71            -0.0        0.69        perf-profile.children.cycles-pp.shmem_file_llseek
      0.06 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.userfaultfd_unmap_prep
      0.07            -0.0        0.06        perf-profile.children.cycles-pp._raw_read_lock
      0.08            -0.0        0.07        perf-profile.children.cycles-pp.dnotify_flush
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.error_entry
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.folio_add_lru
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.up_read
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.folio_mark_accessed
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.__dquot_free_space
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.mas_prev_node
      0.08            +0.0        0.09        perf-profile.children.cycles-pp.shmem_inode_unacct_blocks
      0.18 ±  2%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.can_modify_mm
      0.11 ±  3%      +0.0        0.12        perf-profile.children.cycles-pp._compound_head
      0.11            +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.apparmor_mmap_file
      0.20            +0.0        0.21        perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.08 ±  4%      +0.0        0.09        perf-profile.children.cycles-pp.mas_ascend
      0.06 ±  6%      +0.0        0.07        perf-profile.children.cycles-pp.mas_data_end
      0.07            +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.fput
      0.09            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.mas_pop_node
      0.07 ±  7%      +0.0        0.08        perf-profile.children.cycles-pp.folio_unlock
      0.06 ±  6%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.handle_pte_fault
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.sched_tick
      0.37            +0.0        0.39        perf-profile.children.cycles-pp.mapping_seek_hole_data
      0.10 ±  3%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.rcu_all_qs
      0.13 ±  2%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.refill_obj_stock
      0.05            +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.iput
      0.11 ±  4%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.try_charge_memcg
      0.08 ±  5%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.mas_next_slot
      0.13 ±  3%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.security_mmap_file
      0.08 ±  7%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.uncharge_folio
      0.14 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.__memcpy
      0.19 ±  2%      +0.0        0.21        perf-profile.children.cycles-pp.shmem_setattr
      0.10 ±  4%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.10 ±  4%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.truncate_cleanup_folio
      0.13 ±  2%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.__count_memcg_events
      0.08            +0.0        0.10 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.20 ±  2%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.xas_start
      0.17 ±  2%      +0.0        0.19 ±  3%  perf-profile.children.cycles-pp.__vfs_getxattr
      0.18 ±  2%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.cap_inode_need_killpriv
      0.13 ±  3%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.folio_add_file_rmap_ptes
      0.13 ±  2%      +0.0        0.15        perf-profile.children.cycles-pp.shmem_recalc_inode
      0.13 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.mas_push_data
      0.13            +0.0        0.15        perf-profile.children.cycles-pp.mas_topiary_replace
      0.05            +0.0        0.07 ±  8%  perf-profile.children.cycles-pp.mas_nomem
      0.11 ±  3%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.mas_prev_slot
      0.35 ±  2%      +0.0        0.37        perf-profile.children.cycles-pp.xas_load
      0.14 ±  2%      +0.0        0.16        perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.13 ±  3%      +0.0        0.15        perf-profile.children.cycles-pp.filemap_get_entry
      0.20 ±  2%      +0.0        0.23 ±  2%  perf-profile.children.cycles-pp.security_inode_need_killpriv
      0.17 ±  4%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.d_instantiate
      0.10            +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.file_remove_privs_flags
      0.14 ±  3%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.__dquot_alloc_space
      0.13 ±  2%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.xas_clear_mark
      0.15 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.17 ±  2%      +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.18 ±  2%      +0.0        0.21        perf-profile.children.cycles-pp.set_pte_range
      0.40            +0.0        0.42        perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.13            +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.mab_mas_cp
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.file_modified
      0.03 ± 70%      +0.0        0.06        perf-profile.children.cycles-pp.folio_mark_dirty
      0.17            +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.20 ±  4%      +0.0        0.23 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.17 ±  2%      +0.0        0.20        perf-profile.children.cycles-pp.__mod_node_page_state
      0.19 ±  2%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.filemap_unaccount_folio
      0.15            +0.0        0.18        perf-profile.children.cycles-pp.fsnotify_grab_connector
      0.20 ±  2%      +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.15            +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.19            +0.0        0.22        perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      0.14            +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.inode_set_ctime_current
      0.16 ±  3%      +0.0        0.19        perf-profile.children.cycles-pp.free_unref_folios
      0.17 ±  2%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.24            +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.20 ±  2%      +0.0        0.24        perf-profile.children.cycles-pp.tlb_flush_mmu
      0.11 ±  4%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.__srcu_read_lock
      0.16 ±  3%      +0.0        0.19        perf-profile.children.cycles-pp.fsnotify_destroy_marks
      0.08 ±  5%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.mas_destroy
      0.21 ±  2%      +0.0        0.24 ±  2%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.20 ±  2%      +0.0        0.24        perf-profile.children.cycles-pp.tlb_flush_rmap_batch
      0.16 ±  3%      +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.__put_partials
      0.21            +0.0        0.25        perf-profile.children.cycles-pp.tlb_flush_rmaps
      0.22 ±  2%      +0.0        0.26        perf-profile.children.cycles-pp.mas_rev_awalk
      0.24            +0.0        0.28        perf-profile.children.cycles-pp.__mod_lruvec_state
      0.36            +0.0        0.40        perf-profile.children.cycles-pp.lru_add_fn
      0.14 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__d_alloc
      0.18 ±  2%      +0.0        0.22        perf-profile.children.cycles-pp.dentry_unlink_inode
      0.24 ±  3%      +0.0        0.29 ±  2%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.30            +0.0        0.34 ±  2%  perf-profile.children.cycles-pp.fault_dirty_shared_page
      0.20 ±  3%      +0.0        0.25        perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.26 ±  2%      +0.0        0.30        perf-profile.children.cycles-pp.mas_find
      0.22 ±  3%      +0.0        0.27        perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.25            +0.0        0.29        perf-profile.children.cycles-pp.mas_split
      0.25 ±  2%      +0.0        0.29        perf-profile.children.cycles-pp.security_file_free
      0.23 ±  2%      +0.0        0.28        perf-profile.children.cycles-pp.___perf_sw_event
      0.33            +0.0        0.38        perf-profile.children.cycles-pp.zap_present_ptes
      0.02 ±141%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.kmem_cache_free_bulk
      0.16 ±  4%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.d_alloc_pseudo
      0.42 ±  2%      +0.0        0.47        perf-profile.children.cycles-pp.__call_rcu_common
      0.27 ±  2%      +0.0        0.32        perf-profile.children.cycles-pp.__perf_sw_event
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.filemap_free_folio
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.folio_mapping
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.mas_update_gap
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.x64_sys_call
      0.28            +0.1        0.34        perf-profile.children.cycles-pp.mas_empty_area_rev
      0.27            +0.1        0.32        perf-profile.children.cycles-pp.mas_wr_bnode
      0.25            +0.1        0.30        perf-profile.children.cycles-pp.security_file_alloc
      0.34            +0.1        0.39        perf-profile.children.cycles-pp.init_file
      0.36            +0.1        0.41        perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.35            +0.1        0.40        perf-profile.children.cycles-pp.finish_fault
      0.70 ±  6%      +0.1        0.75 ±  2%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.26            +0.1        0.31        perf-profile.children.cycles-pp.shmem_inode_acct_blocks
      0.20 ±  2%      +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.simple_inode_init_ts
      0.33 ±  2%      +0.1        0.39        perf-profile.children.cycles-pp.inode_init_owner
      0.32            +0.1        0.37        perf-profile.children.cycles-pp.mas_spanning_rebalance
      0.21 ±  2%      +0.1        0.27        perf-profile.children.cycles-pp.mas_preallocate
      0.75 ±  6%      +0.1        0.81 ±  2%  perf-profile.children.cycles-pp.uncharge_batch
      0.32 ±  3%      +0.1        0.38 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.41            +0.1        0.47        perf-profile.children.cycles-pp.perf_event_mmap_event
      0.28 ±  3%      +0.1        0.35 ±  2%  perf-profile.children.cycles-pp.mas_walk
      0.38            +0.1        0.45        perf-profile.children.cycles-pp.mod_objcg_state
      0.32            +0.1        0.39        perf-profile.children.cycles-pp.inode_wait_for_writeback
      0.80            +0.1        0.86        perf-profile.children.cycles-pp.do_truncate
      0.42            +0.1        0.49        perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.42            +0.1        0.48        perf-profile.children.cycles-pp.perf_event_mmap
      0.39            +0.1        0.46        perf-profile.children.cycles-pp.native_irq_return_iret
      0.56 ±  2%      +0.1        0.63        perf-profile.children.cycles-pp.notify_change
      0.38            +0.1        0.44        perf-profile.children.cycles-pp.vm_unmapped_area
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__schedule
      0.55            +0.1        0.62        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.45            +0.1        0.52        perf-profile.children.cycles-pp.flush_tlb_func
      0.46            +0.1        0.53        perf-profile.children.cycles-pp.clear_bhb_loop
      0.53            +0.1        0.60        perf-profile.children.cycles-pp.alloc_empty_file
      0.52            +0.1        0.60        perf-profile.children.cycles-pp.flush_tlb_mm_range
      1.41            +0.1        1.49        perf-profile.children.cycles-pp.llseek
      0.43            +0.1        0.51        perf-profile.children.cycles-pp.errseq_sample
      0.40            +0.1        0.48        perf-profile.children.cycles-pp.shmem_get_unmapped_area
      0.40            +0.1        0.47        perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown_vmflags
      0.77            +0.1        0.85        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.44            +0.1        0.52        perf-profile.children.cycles-pp.file_init_path
      0.42            +0.1        0.50        perf-profile.children.cycles-pp.__get_unmapped_area
      0.90 ±  5%      +0.1        0.98 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.26            +0.1        0.34        perf-profile.children.cycles-pp.__cond_resched
      0.45            +0.1        0.53        perf-profile.children.cycles-pp.sync_regs
      0.12            +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.security_inode_alloc
      0.52            +0.1        0.61        perf-profile.children.cycles-pp.__filemap_remove_folio
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.get_partial_node
      0.46            +0.1        0.56        perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.54            +0.1        0.63        perf-profile.children.cycles-pp.mas_wr_node_store
      0.66            +0.1        0.76        perf-profile.children.cycles-pp.mas_wr_store_entry
      0.63            +0.1        0.73        perf-profile.children.cycles-pp.filemap_remove_folio
      0.60            +0.1        0.70        perf-profile.children.cycles-pp.clear_nlink
      0.64            +0.1        0.75        perf-profile.children.cycles-pp.mas_store_prealloc
      0.38 ±  3%      +0.1        0.48        perf-profile.children.cycles-pp.common_perm_cond
      0.38 ±  3%      +0.1        0.49        perf-profile.children.cycles-pp.security_file_truncate
      0.24 ±  2%      +0.1        0.36        perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      0.62            +0.1        0.74        perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.26            +0.1        0.36        perf-profile.children.cycles-pp.kmem_cache_alloc_bulk_noprof
      0.66            +0.1        0.77        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.39 ±  3%      +0.1        0.51        perf-profile.children.cycles-pp.atime_needs_update
      0.77            +0.1        0.90        perf-profile.children.cycles-pp.truncate_inode_folio
      0.36            +0.1        0.48        perf-profile.children.cycles-pp.mas_alloc_nodes
      0.08 ±  5%      +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.__free_one_page
      0.54            +0.1        0.67        perf-profile.children.cycles-pp.mas_wr_spanning_store
      0.21 ±  3%      +0.1        0.35 ±  3%  perf-profile.children.cycles-pp.free_unref_page
      0.19 ±  2%      +0.1        0.34 ±  3%  perf-profile.children.cycles-pp.free_pcppages_bulk
      1.49            +0.2        1.64        perf-profile.children.cycles-pp.unmap_region
      0.24 ±  3%      +0.2        0.40 ±  2%  perf-profile.children.cycles-pp.free_unref_page_commit
      1.18            +0.2        1.34        perf-profile.children.cycles-pp.unmap_vmas
      1.36 ±  2%      +0.2        1.54        perf-profile.children.cycles-pp.do_ftruncate
      1.46 ±  2%      +0.2        1.65        perf-profile.children.cycles-pp.__x64_sys_ftruncate
      0.57            +0.2        0.77        perf-profile.children.cycles-pp.inode_init_always
      0.84 ±  3%      +0.2        1.05        perf-profile.children.cycles-pp.__destroy_inode
      0.84 ±  3%      +0.2        1.05        perf-profile.children.cycles-pp.destroy_inode
      1.59 ±  2%      +0.2        1.80        perf-profile.children.cycles-pp.ftruncate64
      0.96            +0.2        1.18        perf-profile.children.cycles-pp.mas_store_gfp
      1.47            +0.2        1.69        perf-profile.children.cycles-pp.zap_pte_range
      1.31            +0.2        1.54        perf-profile.children.cycles-pp.alloc_file_pseudo
      1.50            +0.2        1.72        perf-profile.children.cycles-pp.zap_pmd_range
      1.55            +0.2        1.79        perf-profile.children.cycles-pp.unmap_page_range
      0.10 ±  5%      +0.3        0.38 ±  4%  perf-profile.children.cycles-pp.rmqueue_bulk
      2.28            +0.3        2.57        perf-profile.children.cycles-pp.kmem_cache_free
      0.13 ±  3%      +0.3        0.42 ±  3%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      3.29            +0.3        3.59        perf-profile.children.cycles-pp.mmap_region
      0.23 ±  3%      +0.3        0.54 ±  3%  perf-profile.children.cycles-pp.rmqueue
      2.43            +0.3        2.76        perf-profile.children.cycles-pp.shmem_alloc_and_add_folio
      0.36            +0.3        0.69 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      2.48            +0.3        2.82        perf-profile.children.cycles-pp.rcu_do_batch
      0.47            +0.4        0.82 ±  2%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.49            +0.4        0.86 ±  2%  perf-profile.children.cycles-pp.shmem_alloc_folio
      2.85            +0.4        3.23        perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.44            +0.4        0.82 ±  2%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      3.76            +0.4        4.14        perf-profile.children.cycles-pp.do_mmap
      2.49            +0.4        2.88        perf-profile.children.cycles-pp.rcu_core
      3.07            +0.4        3.46        perf-profile.children.cycles-pp.__x64_sys_munmap
      3.07            +0.4        3.46        perf-profile.children.cycles-pp.__vm_munmap
      1.70            +0.4        2.10        perf-profile.children.cycles-pp.clear_page_erms
      3.94            +0.4        4.34        perf-profile.children.cycles-pp.vm_mmap_pgoff
      3.13            +0.4        3.54        perf-profile.children.cycles-pp.do_vmi_munmap
      3.97            +0.4        4.38        perf-profile.children.cycles-pp.ksys_mmap_pgoff
      2.50            +0.4        2.92        perf-profile.children.cycles-pp.handle_softirqs
      3.21            +0.4        3.63        perf-profile.children.cycles-pp.__munmap
      4.35            +0.5        4.82        perf-profile.children.cycles-pp.__mmap
      6.69            +1.2        7.90        perf-profile.children.cycles-pp.shmem_get_folio_gfp
      6.74            +1.2        7.96        perf-profile.children.cycles-pp.shmem_fault
      6.78            +1.2        8.02        perf-profile.children.cycles-pp.__do_fault
      7.47            +1.3        8.80        perf-profile.children.cycles-pp.do_fault
      7.68            +1.4        9.08        perf-profile.children.cycles-pp.__handle_mm_fault
      7.97            +1.4        9.42        perf-profile.children.cycles-pp.handle_mm_fault
      8.39            +1.5        9.91        perf-profile.children.cycles-pp.do_user_addr_fault
      8.42            +1.5        9.94        perf-profile.children.cycles-pp.exc_page_fault
      9.77            +1.8       11.54        perf-profile.children.cycles-pp.asm_exc_page_fault
     10.55            +1.9       12.44        perf-profile.children.cycles-pp.stress_memfd_child
      0.90 ±  9%      +1.9        2.80        perf-profile.children.cycles-pp.run_ksoftirqd
      0.94 ±  8%      +1.9        2.87        perf-profile.children.cycles-pp.kthread
      0.94 ±  8%      +1.9        2.87        perf-profile.children.cycles-pp.ret_from_fork
      0.94 ±  8%      +1.9        2.87        perf-profile.children.cycles-pp.ret_from_fork_asm
      0.90 ±  9%      +1.9        2.83        perf-profile.children.cycles-pp.smpboot_thread_fn
     63.09            -5.4       57.74        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.26 ±  2%      -0.2        0.07 ±  5%  perf-profile.self.cycles-pp.inode_init_once
      0.24 ±  2%      -0.2        0.06 ±  7%  perf-profile.self.cycles-pp.radix_tree_node_ctor
      0.20 ±  3%      -0.1        0.06        perf-profile.self.cycles-pp.setup_object
      0.19            -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.shuffle_freelist
      0.10 ±  7%      -0.1        0.05        perf-profile.self.cycles-pp.__init_rwsem
      0.50            -0.0        0.45 ±  2%  perf-profile.self.cycles-pp.down_write
      0.19            -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.shmem_file_llseek
      0.14 ±  3%      -0.0        0.13 ±  5%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.08            -0.0        0.07        perf-profile.self.cycles-pp.dnotify_flush
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.userfaultfd_unmap_prep
      0.10            +0.0        0.11        perf-profile.self.cycles-pp._compound_head
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.__pte_offset_map
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.fput
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.mas_next_slot
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.mas_prev_slot
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.mas_push_data
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.unmap_page_range
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.__d_instantiate
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.__mod_lruvec_state
      0.09            +0.0        0.10        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.folio_unlock
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.free_unref_folios
      0.05            +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.mas_data_end
      0.07            +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.08 ±  4%      +0.0        0.09        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.06            +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.fault_dirty_shared_page
      0.06 ±  6%      +0.0        0.07        perf-profile.self.cycles-pp.rmqueue
      0.07            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.mas_ascend
      0.11 ±  4%      +0.0        0.12        perf-profile.self.cycles-pp.perf_event_mmap_output
      0.07 ±  7%      +0.0        0.08        perf-profile.self.cycles-pp.folio_mark_accessed
      0.09 ±  4%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.xas_create
      0.09 ±  5%      +0.0        0.10        perf-profile.self.cycles-pp.do_syscall_64
      0.09 ±  5%      +0.0        0.10        perf-profile.self.cycles-pp.mas_pop_node
      0.07 ±  6%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__alloc_pages_noprof
      0.09            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.mas_spanning_rebalance
      0.14            +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.mmap_region
      0.18 ±  2%      +0.0        0.19        perf-profile.self.cycles-pp.xas_start
      0.14 ±  3%      +0.0        0.16        perf-profile.self.cycles-pp.__fdget
      0.09            +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.handle_mm_fault
      0.10 ±  4%      +0.0        0.12        perf-profile.self.cycles-pp.shmem_add_to_page_cache
      0.08            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.llseek
      0.19 ±  3%      +0.0        0.21        perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.14 ±  5%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.zap_pte_range
      0.07            +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.rcu_all_qs
      0.11            +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.shmem_undo_range
      0.12 ±  3%      +0.0        0.14 ±  4%  perf-profile.self.cycles-pp.__memcpy
      0.10            +0.0        0.12        perf-profile.self.cycles-pp.mab_mas_cp
      0.09            +0.0        0.11        perf-profile.self.cycles-pp.mas_topiary_replace
      0.08 ±  4%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.__dquot_alloc_space
      0.11            +0.0        0.13        perf-profile.self.cycles-pp.zap_present_ptes
      0.13 ±  4%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.06            +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.kmem_cache_alloc_lru_noprof
      0.16 ±  3%      +0.0        0.19        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.14 ±  3%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.___slab_alloc
      0.16            +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.15 ±  3%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.16 ±  2%      +0.0        0.19 ±  2%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.26            +0.0        0.29        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.11 ±  3%      +0.0        0.14 ±  2%  perf-profile.self.cycles-pp.xas_clear_mark
      0.14 ±  3%      +0.0        0.17        perf-profile.self.cycles-pp.__handle_mm_fault
      0.13            +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.09            +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.simple_inode_init_ts
      0.23 ±  2%      +0.0        0.26        perf-profile.self.cycles-pp.mapping_seek_hole_data
      0.11            +0.0        0.14        perf-profile.self.cycles-pp.__srcu_read_lock
      0.15            +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.__cond_resched
      0.18 ±  2%      +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.mas_rev_awalk
      0.11 ±  4%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.inode_set_ctime_current
      0.23            +0.0        0.26        perf-profile.self.cycles-pp.find_lock_entries
      0.19 ±  2%      +0.0        0.23        perf-profile.self.cycles-pp.___perf_sw_event
      0.22 ±  2%      +0.0        0.26        perf-profile.self.cycles-pp.__call_rcu_common
      0.16 ±  3%      +0.0        0.19        perf-profile.self.cycles-pp.xas_store
      0.34            +0.0        0.37 ±  2%  perf-profile.self.cycles-pp.folios_put_refs
      0.22 ±  2%      +0.0        0.26 ±  2%  perf-profile.self.cycles-pp.mas_wr_node_store
      0.32 ±  2%      +0.0        0.36        perf-profile.self.cycles-pp.mod_objcg_state
      0.10            +0.0        0.14        perf-profile.self.cycles-pp.get_page_from_freelist
      0.22 ±  2%      +0.0        0.26        perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.24 ±  3%      +0.0        0.29 ±  2%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.32 ±  3%      +0.0        0.37        perf-profile.self.cycles-pp.notify_change
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.finish_fault
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.mem_cgroup_commit_charge
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.truncate_cleanup_folio
      0.68 ±  6%      +0.1        0.73 ±  2%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.35 ±  2%      +0.1        0.40        perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.32            +0.1        0.38        perf-profile.self.cycles-pp.inode_init_owner
      0.32 ±  2%      +0.1        0.38 ±  2%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.19            +0.1        0.25 ±  2%  perf-profile.self.cycles-pp.kmem_cache_free
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.rcu_do_batch
      0.20            +0.1        0.26 ±  2%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.28 ±  3%      +0.1        0.34 ±  2%  perf-profile.self.cycles-pp.mas_walk
      0.42            +0.1        0.48        perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.39            +0.1        0.46        perf-profile.self.cycles-pp.native_irq_return_iret
      0.46            +0.1        0.52 ±  2%  perf-profile.self.cycles-pp.clear_bhb_loop
      0.36            +0.1        0.42        perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.56 ±  3%      +0.1        0.63 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.get_partial_node
      0.45            +0.1        0.53        perf-profile.self.cycles-pp.sync_regs
      0.42            +0.1        0.50        perf-profile.self.cycles-pp.errseq_sample
      0.07 ±  5%      +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.18 ±  2%      +0.1        0.29 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.42            +0.1        0.53        perf-profile.self.cycles-pp.inode_init_always
      0.37 ±  3%      +0.1        0.48        perf-profile.self.cycles-pp.common_perm_cond
      0.59            +0.1        0.70        perf-profile.self.cycles-pp.clear_nlink
      0.37 ±  3%      +0.1        0.50        perf-profile.self.cycles-pp.atime_needs_update
      0.08            +0.1        0.21 ±  3%  perf-profile.self.cycles-pp.__free_one_page
      0.07 ±  5%      +0.1        0.20        perf-profile.self.cycles-pp.__kmem_cache_alloc_bulk
      1.15            +0.2        1.35        perf-profile.self.cycles-pp.stress_memfd_child
      0.64 ±  3%      +0.2        0.84        perf-profile.self.cycles-pp.__destroy_inode
      1.39            +0.3        1.64        perf-profile.self.cycles-pp._raw_spin_lock
      1.68            +0.4        2.09        perf-profile.self.cycles-pp.clear_page_erms
      2.39            +0.5        2.86        perf-profile.self.cycles-pp.shmem_get_folio_gfp



***************************************************************************************************
lkp-ivb-2ep2: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory
=========================================================================================
array_size/compiler/cpufreq_governor/iterations/kconfig/loop/nr_threads/omp/rootfs/tbox_group/testcase:
  10000000/gcc-13/performance/10x/x86_64-rhel-8.3/100/100%/true/debian-12-x86_64-20240206.cgz/lkp-ivb-2ep2/stream

commit: 
  402de7fc88 ("sched: Fix spelling in comments")
  e2ee0a922a ("sched/fair: Reschedule the cfs_rq when current is ineligible")

402de7fc880fef05 e2ee0a922a6a2a8377dc66435c9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     55656           -51.4%      27074 ±  3%  cpuidle..usage
    241551 ±  2%      -8.5%     220928        meminfo.AnonHugePages
    131792 ±  6%     -18.6%     107291 ±  8%  numa-meminfo.node0.AnonHugePages
     12972 ±110%    +151.6%      32632 ± 40%  numa-numastat.node1.other_node
     12972 ±110%    +151.6%      32632 ± 40%  numa-vmstat.node1.numa_other
     63.58           -11.9%      56.03        uptime.boot
     43.53            -8.3%      39.90        vmstat.procs.r
      4579           -29.7%       3221        vmstat.system.cs
     45596            -4.6%      43505        vmstat.system.in
      6.41 ±  3%      +1.6        8.05 ±  9%  mpstat.cpu.all.idle%
      0.49            +0.1        0.57        mpstat.cpu.all.irq%
      0.63            +0.1        0.73        mpstat.cpu.all.sys%
     18.50 ± 21%     -49.5%       9.33 ± 33%  mpstat.max_utilization.seconds
    214750            -2.2%     210071        proc-vmstat.nr_anon_pages
    214849            -2.2%     210168        proc-vmstat.nr_inactive_anon
    214849            -2.2%     210168        proc-vmstat.nr_zone_inactive_anon
    231926 ±  2%      -5.7%     218605 ±  3%  proc-vmstat.numa_hit
      1149            -1.1%       1136        proc-vmstat.numa_huge_pte_updates
    182191 ±  2%      -7.3%     168901 ±  3%  proc-vmstat.numa_local
    263520 ±  7%     -18.9%     213661 ±  7%  proc-vmstat.numa_pages_migrated
   1254523            -5.0%    1191907        proc-vmstat.pgalloc_normal
    186524 ±  4%     -11.7%     164742 ±  4%  proc-vmstat.pgfault
    263520 ±  7%     -18.9%     213661 ±  7%  proc-vmstat.pgmigrate_success
     11176 ±  7%     -26.7%       8197 ±  7%  proc-vmstat.pgreuse
     46510 ±  3%     +30.9%      60867        stream.add_bandwidth_MBps
     45320 ±  2%     +33.7%      60603 ±  2%  stream.add_bandwidth_MBps_harmonicMean
     40274 ±  3%     +44.3%      58108        stream.copy_bandwidth_MBps
     38575 ±  3%     +49.3%      57575 ±  2%  stream.copy_bandwidth_MBps_harmonicMean
     36282 ±  6%     +46.7%      53230 ±  2%  stream.scale_bandwidth_MBps
     35030 ±  5%     +50.2%      52625 ±  2%  stream.scale_bandwidth_MBps_harmonicMean
     25.69           -30.4%      17.87        stream.time.elapsed_time
     25.69           -30.4%      17.87        stream.time.elapsed_time.max
     12254          +107.9%      25472 ±  2%  stream.time.involuntary_context_switches
     24651 ±  5%      -9.0%      22441 ±  2%  stream.time.minor_page_faults
      1167           -30.9%     806.50        stream.time.user_time
     39787           -96.1%       1532 ±  9%  stream.time.voluntary_context_switches
     50469 ±  5%     +24.3%      62714        stream.triad_bandwidth_MBps
     49431 ±  5%     +26.5%      62521        stream.triad_bandwidth_MBps_harmonicMean
      4.21           +68.4%       7.09        perf-stat.i.MPKI
 8.566e+09           -24.2%  6.491e+09        perf-stat.i.branch-instructions
      0.69            +0.2        0.89        perf-stat.i.branch-miss-rate%
 1.493e+08           +41.4%  2.112e+08        perf-stat.i.cache-misses
 3.114e+08           +40.1%  4.363e+08        perf-stat.i.cache-references
      4411           -36.5%       2801        perf-stat.i.context-switches
      3.84           +16.6%       4.48        perf-stat.i.cpi
 1.364e+11            -2.1%  1.336e+11        perf-stat.i.cpu-cycles
    364.73           -59.1%     149.26 ±  4%  perf-stat.i.cpu-migrations
    922.65           -28.4%     660.92        perf-stat.i.cycles-between-cache-misses
  3.49e+10           -16.3%  2.922e+10        perf-stat.i.instructions
      0.29            -7.0%       0.27        perf-stat.i.ipc
      0.09 ± 53%    +387.7%       0.45 ± 40%  perf-stat.i.major-faults
      5897 ±  6%     +20.0%       7077 ±  4%  perf-stat.i.minor-faults
      5897 ±  6%     +20.0%       7077 ±  4%  perf-stat.i.page-faults
      4.28           +68.9%       7.23        perf-stat.overall.MPKI
      0.59            +0.2        0.79        perf-stat.overall.branch-miss-rate%
     47.95            +0.4       48.40        perf-stat.overall.cache-miss-rate%
      3.91           +17.0%       4.57        perf-stat.overall.cpi
    913.32           -30.7%     632.59        perf-stat.overall.cycles-between-cache-misses
      0.26           -14.5%       0.22        perf-stat.overall.ipc
 8.239e+09           -25.4%  6.148e+09        perf-stat.ps.branch-instructions
 1.437e+08           +39.3%  2.001e+08        perf-stat.ps.cache-misses
 2.996e+08           +38.0%  4.133e+08        perf-stat.ps.cache-references
      4240           -37.5%       2649        perf-stat.ps.context-switches
     46177            -1.5%      45469        perf-stat.ps.cpu-clock
 1.312e+11            -3.6%  1.265e+11        perf-stat.ps.cpu-cycles
    350.71           -59.8%     141.15 ±  4%  perf-stat.ps.cpu-migrations
 3.357e+10           -17.6%  2.768e+10        perf-stat.ps.instructions
      0.09 ± 53%    +380.5%       0.43 ± 40%  perf-stat.ps.major-faults
      5648 ±  6%     +18.1%       6673 ±  4%  perf-stat.ps.minor-faults
      5649 ±  6%     +18.1%       6674 ±  4%  perf-stat.ps.page-faults
     46177            -1.5%      45469        perf-stat.ps.task-clock
 8.823e+11           -40.3%  5.265e+11 ±  2%  perf-stat.total.instructions
     51.07 ± 13%      -9.7       41.34 ± 15%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +1.4        1.38 ± 21%  perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_lsr.wait_for_xmitr.serial8250_console_write.console_flush_all
      0.00            +1.9        1.94 ± 29%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +1.9        1.94 ± 29%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +2.0        1.96 ± 21%  perf-profile.calltrace.cycles-pp.wait_for_lsr.wait_for_xmitr.serial8250_console_write.console_flush_all.console_unlock
      0.00            +2.0        1.96 ± 21%  perf-profile.calltrace.cycles-pp.wait_for_xmitr.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit
      0.00            +2.1        2.12 ± 30%  perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record.perf_c2c__record
      0.00            +2.1        2.12 ± 30%  perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.__cmd_record.cmd_record.perf_c2c__record.run_builtin
      0.00            +2.1        2.15 ± 28%  perf-profile.calltrace.cycles-pp.__cmd_record.cmd_record.perf_c2c__record.run_builtin.main
      0.00            +2.1        2.15 ± 28%  perf-profile.calltrace.cycles-pp.cmd_record.perf_c2c__record.run_builtin.main
      0.00            +2.1        2.15 ± 28%  perf-profile.calltrace.cycles-pp.perf_c2c__record.run_builtin.main
      0.00            +4.2        4.18 ± 59%  perf-profile.calltrace.cycles-pp.delay_tsc.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock
      0.00            +8.6        8.65 ± 58%  perf-profile.calltrace.cycles-pp.io_serial_in.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock
      0.00           +13.0       12.98 ± 53%  perf-profile.calltrace.cycles-pp.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit
      0.00           +13.1       13.05 ± 54%  perf-profile.calltrace.cycles-pp.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write
      0.00           +13.1       13.05 ± 54%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write
      0.00           +13.1       13.05 ± 54%  perf-profile.calltrace.cycles-pp.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit
      3.10 ± 32%     +15.8       18.87 ± 55%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.23 ±223%     +16.3       16.55 ± 67%  perf-profile.calltrace.cycles-pp.write
      0.00           +16.4       16.43 ± 67%  perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.vfs_write.ksys_write.do_syscall_64
      0.00           +16.4       16.43 ± 67%  perf-profile.calltrace.cycles-pp.devkmsg_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +16.4       16.43 ± 67%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00           +16.4       16.43 ± 67%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00           +16.4       16.43 ± 67%  perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write.ksys_write
      0.00           +16.5       16.46 ± 68%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     51.07 ± 13%      -9.7       41.34 ± 15%  perf-profile.children.cycles-pp.intel_idle
      0.00            +2.1        2.14 ± 27%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.00            +2.1        2.15 ± 28%  perf-profile.children.cycles-pp.perf_c2c__record
      0.63 ±148%      +2.2        2.79 ± 22%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.63 ±148%      +2.2        2.79 ± 22%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.00            +4.9        4.86 ± 53%  perf-profile.children.cycles-pp.delay_tsc
      0.00           +10.2       10.18 ± 49%  perf-profile.children.cycles-pp.io_serial_in
      0.00           +15.1       15.12 ± 46%  perf-profile.children.cycles-pp.wait_for_lsr
      0.00           +15.5       15.46 ± 47%  perf-profile.children.cycles-pp.console_flush_all
      0.00           +15.5       15.46 ± 47%  perf-profile.children.cycles-pp.console_unlock
      0.00           +15.5       15.46 ± 47%  perf-profile.children.cycles-pp.serial8250_console_write
      3.10 ± 32%     +16.0       19.08 ± 55%  perf-profile.children.cycles-pp.vfs_write
      3.10 ± 32%     +16.1       19.18 ± 54%  perf-profile.children.cycles-pp.ksys_write
      3.33 ± 21%     +16.1       19.43 ± 53%  perf-profile.children.cycles-pp.write
      0.00           +16.4       16.43 ± 67%  perf-profile.children.cycles-pp.devkmsg_emit
      0.00           +16.4       16.43 ± 67%  perf-profile.children.cycles-pp.devkmsg_write
      0.00           +21.0       21.00 ± 57%  perf-profile.children.cycles-pp.vprintk_emit
     51.07 ± 13%      -9.7       41.34 ± 15%  perf-profile.self.cycles-pp.intel_idle
      0.00            +4.9        4.86 ± 53%  perf-profile.self.cycles-pp.delay_tsc
      0.00           +10.2       10.18 ± 49%  perf-profile.self.cycles-pp.io_serial_in



***************************************************************************************************
lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase:
  gcc-13/performance/1BRD_48G/xfs/x86_64-rhel-8.3/600/debian-12-x86_64-20240206.cgz/lkp-icl-2sp2/sync_disk_rw/aim7

commit: 
  402de7fc88 ("sched: Fix spelling in comments")
  e2ee0a922a ("sched/fair: Reschedule the cfs_rq when current is ineligible")

402de7fc880fef05 e2ee0a922a6a2a8377dc66435c9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 4.038e+09           +36.4%  5.509e+09        cpuidle..time
     28.04           +84.3%      51.68        iostat.cpu.idle
     71.29           -33.3%      47.56        iostat.cpu.system
     39335 ±  2%     +36.8%      53800        numa-meminfo.node0.Dirty
     38515           +38.0%      53165        numa-meminfo.node1.Dirty
     24872           -10.2%      22341        perf-c2c.HITM.local
     37779            -7.9%      34802        perf-c2c.HITM.total
    172.51           -19.7%     138.47 ±  2%  uptime.boot
     10661 ±  3%     +16.1%      12377 ±  3%  uptime.idle
   1385108 ±  3%     -11.7%    1222989 ±  3%  meminfo.Active
   1385072 ±  3%     -11.7%    1222957 ±  3%  meminfo.Active(anon)
     78232           +36.7%     106945        meminfo.Dirty
   1564998 ±  3%     -10.3%    1403834 ±  2%  meminfo.Shmem
      9881           +36.7%      13504        numa-vmstat.node0.nr_dirty
      9882           +36.6%      13503        numa-vmstat.node0.nr_zone_write_pending
      9841           +35.2%      13300        numa-vmstat.node1.nr_dirty
      9841           +35.1%      13299        numa-vmstat.node1.nr_zone_write_pending
     28.07           +84.2%      51.70        vmstat.cpu.id
   1203741           +39.3%    1677310        vmstat.io.bo
    125.86 ±  9%     -51.4%      61.16 ± 11%  vmstat.procs.r
    686139           +13.9%     781764        vmstat.system.cs
    416927            +2.8%     428732        vmstat.system.in
     26.93           +23.6       50.51        mpstat.cpu.all.idle%
      1.18            -0.3        0.90        mpstat.cpu.all.irq%
      0.09            -0.0        0.08        mpstat.cpu.all.soft%
     71.13           -23.4       47.75        mpstat.cpu.all.sys%
      0.58 ±  2%      +0.1        0.69 ±  3%  mpstat.cpu.all.usr%
     82.61           -26.9%      60.38        mpstat.max_utilization_pct
     31255           +44.9%      45277        aim7.jobs-per-min
    115.23           -31.0%      79.56        aim7.time.elapsed_time
    115.23           -31.0%      79.56        aim7.time.elapsed_time.max
   1850161           -23.4%    1417169        aim7.time.involuntary_context_switches
     59936            -7.7%      55310        aim7.time.minor_page_faults
      8891           -38.9%       5434        aim7.time.percent_of_cpu_this_job_got
     10223           -57.8%       4310        aim7.time.system_time
     22.91           -39.9%      13.78        aim7.time.user_time
  50675628           -34.8%   33016373        aim7.time.voluntary_context_switches
    346088 ±  3%     -11.6%     305932 ±  3%  proc-vmstat.nr_active_anon
     19476           +37.4%      26755        proc-vmstat.nr_dirty
   1244911            -3.5%    1201345        proc-vmstat.nr_file_pages
     69355            -5.5%      65536        proc-vmstat.nr_inactive_file
    391192 ±  3%     -10.2%     351367 ±  2%  proc-vmstat.nr_shmem
     33493            -1.5%      33006        proc-vmstat.nr_slab_reclaimable
    346088 ±  3%     -11.6%     305932 ±  3%  proc-vmstat.nr_zone_active_anon
     69355            -5.5%      65536        proc-vmstat.nr_zone_inactive_file
     19476           +37.4%      26755        proc-vmstat.nr_zone_write_pending
    370445 ±  2%     -21.6%     290297 ± 11%  proc-vmstat.pgactivate
    805543 ±  2%      -6.2%     755499 ±  3%  proc-vmstat.pgfault
 1.427e+08            -2.8%  1.386e+08        proc-vmstat.pgpgout
      1.48           +36.1%       2.01        perf-stat.i.MPKI
 1.279e+10           -24.5%  9.656e+09        perf-stat.i.branch-instructions
      0.98            +0.4        1.38        perf-stat.i.branch-miss-rate%
  68553060           +12.0%   76770003        perf-stat.i.branch-misses
     21.86            -0.8       21.09        perf-stat.i.cache-miss-rate%
 1.005e+08            +6.3%  1.068e+08        perf-stat.i.cache-misses
 4.417e+08            +8.7%  4.803e+08        perf-stat.i.cache-references
    706888           +13.3%     800993        perf-stat.i.context-switches
      3.60           -15.6%       3.04        perf-stat.i.cpi
 2.454e+11           -34.9%  1.598e+11        perf-stat.i.cpu-cycles
    161769           -35.3%     104648        perf-stat.i.cpu-migrations
      2489           -33.5%       1656 ±  2%  perf-stat.i.cycles-between-cache-misses
 6.336e+10           -25.0%  4.754e+10        perf-stat.i.instructions
      0.37           +22.9%       0.45        perf-stat.i.ipc
      5527 ±  5%     +51.3%       8364 ±  6%  perf-stat.i.minor-faults
      5528 ±  5%     +51.3%       8366 ±  6%  perf-stat.i.page-faults
      1.57           +43.1%       2.24        perf-stat.overall.MPKI
      0.53            +0.3        0.79        perf-stat.overall.branch-miss-rate%
     22.67            -0.5       22.17        perf-stat.overall.cache-miss-rate%
      3.86           -13.1%       3.35        perf-stat.overall.cpi
      2461           -39.3%       1494        perf-stat.overall.cycles-between-cache-misses
      0.26           +15.1%       0.30        perf-stat.overall.ipc
 1.278e+10           -25.1%  9.576e+09        perf-stat.ps.branch-instructions
  67535443           +12.1%   75680006        perf-stat.ps.branch-misses
  99195552            +6.6%  1.057e+08        perf-stat.ps.cache-misses
 4.376e+08            +8.9%  4.767e+08        perf-stat.ps.cache-references
    694093           +14.0%     791128        perf-stat.ps.context-switches
 2.442e+11           -35.3%   1.58e+11        perf-stat.ps.cpu-cycles
    158091           -34.8%     103012        perf-stat.ps.cpu-migrations
 6.331e+10           -25.5%  4.714e+10        perf-stat.ps.instructions
      6422 ±  2%     +34.5%       8639 ±  4%  perf-stat.ps.minor-faults
      6423 ±  2%     +34.5%       8641 ±  4%  perf-stat.ps.page-faults
 7.373e+12           -48.3%  3.813e+12        perf-stat.total.instructions
   2100119           -58.1%     879962        sched_debug.cfs_rq:/.avg_vruntime.avg
   2334573 ±  2%     -52.7%    1103489 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.max
   1878975 ±  4%     -56.0%     826327 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.min
     53237 ± 10%     -44.6%      29510 ± 19%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      1.00 ± 28%     -62.5%       0.38 ±  9%  sched_debug.cfs_rq:/.h_nr_running.avg
      1.59 ± 42%     -64.0%       0.57 ±  7%  sched_debug.cfs_rq:/.h_nr_running.stddev
     43604 ± 55%     -76.9%      10078 ± 73%  sched_debug.cfs_rq:/.left_deadline.avg
   2108976           -59.0%     864267 ±  3%  sched_debug.cfs_rq:/.left_deadline.max
    285696 ± 29%     -69.1%      88188 ± 30%  sched_debug.cfs_rq:/.left_deadline.stddev
     43603 ± 55%     -76.9%      10077 ± 73%  sched_debug.cfs_rq:/.left_vruntime.avg
   2108894           -59.0%     864179 ±  3%  sched_debug.cfs_rq:/.left_vruntime.max
    285683 ± 29%     -69.1%      88178 ± 30%  sched_debug.cfs_rq:/.left_vruntime.stddev
    375718 ±109%     -65.1%     131150 ±131%  sched_debug.cfs_rq:/.load.avg
   2100120           -58.1%     879962        sched_debug.cfs_rq:/.min_vruntime.avg
   2334573 ±  2%     -52.7%    1103489 ±  6%  sched_debug.cfs_rq:/.min_vruntime.max
   1878975 ±  4%     -56.0%     826327 ±  2%  sched_debug.cfs_rq:/.min_vruntime.min
     53236 ± 10%     -44.6%      29510 ± 19%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.46 ±  3%     -35.1%       0.30 ±  6%  sched_debug.cfs_rq:/.nr_running.avg
     43603 ± 55%     -76.9%      10077 ± 73%  sched_debug.cfs_rq:/.right_vruntime.avg
   2108894           -59.0%     864179 ±  3%  sched_debug.cfs_rq:/.right_vruntime.max
    285683 ± 29%     -69.1%      88178 ± 30%  sched_debug.cfs_rq:/.right_vruntime.stddev
    988.95 ± 10%     -50.5%     489.95 ±  4%  sched_debug.cfs_rq:/.runnable_avg.avg
      5545 ± 44%     -76.2%       1321 ±  7%  sched_debug.cfs_rq:/.runnable_avg.max
    673.56 ± 31%     -61.8%     256.98 ±  3%  sched_debug.cfs_rq:/.runnable_avg.stddev
    552.01 ±  4%     -30.9%     381.55 ±  4%  sched_debug.cfs_rq:/.util_avg.avg
      2984 ± 36%     -62.6%       1117 ±  7%  sched_debug.cfs_rq:/.util_avg.max
    400.04 ± 23%     -44.1%     223.75 ±  3%  sched_debug.cfs_rq:/.util_avg.stddev
    398.92 ± 32%     -83.4%      66.12 ± 10%  sched_debug.cfs_rq:/.util_est.avg
      5604 ± 55%     -88.4%     649.58 ± 10%  sched_debug.cfs_rq:/.util_est.max
    646.07 ± 45%     -82.4%     113.43 ± 11%  sched_debug.cfs_rq:/.util_est.stddev
    122307 ±  2%     +32.2%     161741 ±  8%  sched_debug.cpu.avg_idle.stddev
      1840 ±  2%     -32.2%       1247 ±  7%  sched_debug.cpu.curr->pid.avg
      1376 ±  5%     +11.7%       1537 ±  2%  sched_debug.cpu.curr->pid.stddev
      1.00 ± 29%     -62.3%       0.38 ±  9%  sched_debug.cpu.nr_running.avg
      1.60 ± 41%     -63.0%       0.59 ±  6%  sched_debug.cpu.nr_running.stddev
    142004           +23.6%     175574        sched_debug.cpu.nr_switches.avg
    171420           +19.3%     204478        sched_debug.cpu.nr_switches.max
      5110 ±  9%     +25.6%       6420 ± 11%  sched_debug.cpu.nr_switches.stddev
      1.61 ± 18%     +28.9%       2.08 ±  6%  sched_debug.cpu.nr_uninterruptible.avg
      2185 ± 30%     -55.6%     970.25 ± 48%  sched_debug.cpu.nr_uninterruptible.max
    -11652           -69.9%      -3504        sched_debug.cpu.nr_uninterruptible.min
      1560 ± 17%     -66.2%     527.53 ± 19%  sched_debug.cpu.nr_uninterruptible.stddev
     75.45           -12.8       62.63        perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq
     88.74           -11.7       77.04        perf-profile.calltrace.cycles-pp.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write.vfs_write
     90.97           -10.6       80.38        perf-profile.calltrace.cycles-pp.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write.vfs_write.ksys_write
     77.13            -9.3       67.79        perf-profile.calltrace.cycles-pp.__mutex_lock.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force_seq
     82.80            -8.9       73.87        perf-profile.calltrace.cycles-pp.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write
     80.40            -8.5       71.94        perf-profile.calltrace.cycles-pp.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync
     94.19            -4.9       89.34        perf-profile.calltrace.cycles-pp.xfs_file_fsync.xfs_file_buffered_write.vfs_write.ksys_write.do_syscall_64
     96.26            -4.2       92.06        perf-profile.calltrace.cycles-pp.xfs_file_buffered_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     96.35            -4.1       92.23        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     96.36            -4.1       92.26        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     96.55            -4.0       92.50        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     96.55            -4.0       92.51        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     96.71            -4.0       92.76        perf-profile.calltrace.cycles-pp.write
      3.40 ±  2%      -1.6        1.82        perf-profile.calltrace.cycles-pp.remove_wait_queue.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write
      3.39 ±  2%      -1.6        1.81        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.remove_wait_queue.xlog_cil_force_seq.xfs_log_force_seq
      3.40 ±  2%      -1.6        1.82        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.remove_wait_queue.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync
      2.11 ±  4%      -1.2        0.89 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync
      2.14 ±  4%      -1.2        0.92 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write
      2.30 ±  3%      -0.5        1.81        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force_seq
      2.36 ±  3%      -0.5        1.88        perf-profile.calltrace.cycles-pp._raw_spin_lock.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force_seq.xfs_file_fsync
      0.98            -0.2        0.76        perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_vn_update_time.kiocb_modified.xfs_file_write_checks.xfs_file_buffered_write
      0.91            -0.2        0.70        perf-profile.calltrace.cycles-pp.xlog_cil_commit.__xfs_trans_commit.xfs_vn_update_time.kiocb_modified.xfs_file_write_checks
      1.26            -0.2        1.09 ±  2%  perf-profile.calltrace.cycles-pp.xfs_vn_update_time.kiocb_modified.xfs_file_write_checks.xfs_file_buffered_write.vfs_write
      1.28            -0.2        1.13        perf-profile.calltrace.cycles-pp.kiocb_modified.xfs_file_write_checks.xfs_file_buffered_write.vfs_write.ksys_write
      1.31            -0.1        1.17        perf-profile.calltrace.cycles-pp.xfs_file_write_checks.xfs_file_buffered_write.vfs_write.ksys_write.do_syscall_64
      0.97            +0.1        1.02        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.osq_lock.__mutex_lock.__flush_workqueue.xlog_cil_push_now
      0.84            +0.1        0.89        perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.95            +0.1        1.00        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.osq_lock.__mutex_lock.__flush_workqueue
      0.86            +0.1        0.92        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.osq_lock
      0.87            +0.1        0.92        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.osq_lock.__mutex_lock
      0.83            +0.1        0.88        perf-profile.calltrace.cycles-pp.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.81            +0.1        0.87        perf-profile.calltrace.cycles-pp.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.63 ±  3%      +0.1        1.74 ±  3%  perf-profile.calltrace.cycles-pp.sched_balance_newidle.pick_next_task_fair.__schedule.schedule.schedule_timeout
      2.09 ±  2%      +0.1        2.24 ±  2%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now
      2.08 ±  2%      +0.1        2.22 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.__wait_for_common.__flush_workqueue
      2.11 ±  2%      +0.2        2.27 ±  2%  perf-profile.calltrace.cycles-pp.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq
      2.16 ±  2%      +0.2        2.33 ±  2%  perf-profile.calltrace.cycles-pp.__wait_for_common.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force_seq
      0.96 ±  3%      +0.2        1.20 ±  3%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle
      1.05 ±  3%      +0.3        1.30 ±  3%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle.pick_next_task_fair
      1.06 ±  2%      +0.3        1.32 ±  3%  perf-profile.calltrace.cycles-pp.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle.pick_next_task_fair.__schedule
      1.11            +0.4        1.48        perf-profile.calltrace.cycles-pp.mutex_spin_on_owner.__mutex_lock.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_iomap_write_unwritten.xfs_end_ioend.xfs_end_io.process_one_work
      0.00            +0.5        0.53        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      0.00            +0.6        0.55        perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
      0.55            +0.6        1.16        perf-profile.calltrace.cycles-pp.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write.ksys_write
      0.00            +0.7        0.70        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.00            +0.7        0.73 ±  2%  perf-profile.calltrace.cycles-pp.sched_balance_newidle.pick_next_task_fair.__schedule.schedule.schedule_preempt_disabled
      0.00            +0.7        0.74 ±  2%  perf-profile.calltrace.cycles-pp.__mutex_unlock_slowpath.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq.xfs_log_force_seq
      0.71            +0.8        1.46        perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write.ksys_write.do_syscall_64
      0.00            +0.8        0.76        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_preempt_disabled.__mutex_lock
      1.80 ±  2%      +0.8        2.56 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.remove_wait_queue.xlog_wait_on_iclog.xfs_log_force_seq
      1.80 ±  2%      +0.8        2.57 ±  2%  perf-profile.calltrace.cycles-pp.remove_wait_queue.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write
      1.80 ±  2%      +0.8        2.57 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.remove_wait_queue.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync
      1.56 ±  3%      +0.8        2.34 ±  2%  perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_newidle.pick_next_task_fair.__schedule.schedule
      0.00            +0.8        0.82 ±  8%  perf-profile.calltrace.cycles-pp.sb_clear_inode_writeback.__folio_end_writeback.folio_end_writeback.iomap_finish_ioend.iomap_finish_ioends
      0.00            +0.9        0.93 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_preempt_disabled.__mutex_lock.__flush_workqueue
      0.00            +0.9        0.93        perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.__mutex_lock.__flush_workqueue.xlog_cil_push_now
      0.00            +0.9        0.94 ±  2%  perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.__mutex_lock.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq
      2.04 ±  2%      +1.0        3.00 ±  2%  perf-profile.calltrace.cycles-pp.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync.xfs_file_buffered_write.vfs_write
      0.00            +1.0        0.99        perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.08 ±223%      +1.0        1.13        perf-profile.calltrace.cycles-pp.xfs_iomap_write_unwritten.xfs_end_ioend.xfs_end_io.process_one_work.worker_thread
      0.00            +1.1        1.10 ±  4%  perf-profile.calltrace.cycles-pp.__folio_end_writeback.folio_end_writeback.iomap_finish_ioend.iomap_finish_ioends.xfs_end_ioend
      0.81            +1.1        1.93        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.82            +1.2        1.98        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.83            +1.2        1.99        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +1.3        1.32 ±  3%  perf-profile.calltrace.cycles-pp.folio_end_writeback.iomap_finish_ioend.iomap_finish_ioends.xfs_end_ioend.xfs_end_io
      0.00            +1.3        1.34 ±  3%  perf-profile.calltrace.cycles-pp.iomap_finish_ioend.iomap_finish_ioends.xfs_end_ioend.xfs_end_io.process_one_work
      0.00            +1.3        1.34 ±  3%  perf-profile.calltrace.cycles-pp.iomap_finish_ioends.xfs_end_ioend.xfs_end_io.process_one_work.worker_thread
      1.14            +1.5        2.61        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.92            +1.6        2.48 ±  2%  perf-profile.calltrace.cycles-pp.xfs_end_ioend.xfs_end_io.process_one_work.worker_thread.kthread
      0.92            +1.6        2.49 ±  2%  perf-profile.calltrace.cycles-pp.xfs_end_io.process_one_work.worker_thread.kthread.ret_from_fork
      0.74 ±  2%      +1.7        2.44 ±  9%  perf-profile.calltrace.cycles-pp.sb_clear_inode_writeback.__folio_end_writeback.folio_end_writeback.iomap_finish_ioend.__submit_bio
      1.36            +1.7        3.08        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.37            +1.7        3.08        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      1.37            +1.7        3.08        perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      1.39            +1.7        3.13        perf-profile.calltrace.cycles-pp.common_startup_64
      0.69            +1.8        2.51        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      1.44            +1.8        3.29        perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.54            +2.0        3.49        perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.55            +2.0        3.51        perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      1.55            +2.0        3.51        perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      1.55            +2.0        3.51        perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      0.87 ±  2%      +2.2        3.04 ±  9%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.sb_mark_inode_writeback.__folio_start_writeback.iomap_writepage_map
      1.04            +2.2        3.23 ±  5%  perf-profile.calltrace.cycles-pp.__folio_end_writeback.folio_end_writeback.iomap_finish_ioend.__submit_bio.__submit_bio_noacct
      0.91 ±  3%      +2.2        3.15 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.sb_mark_inode_writeback.__folio_start_writeback.iomap_writepage_map.iomap_writepages
      0.92 ±  3%      +2.2        3.16 ±  9%  perf-profile.calltrace.cycles-pp.sb_mark_inode_writeback.__folio_start_writeback.iomap_writepage_map.iomap_writepages.xfs_vm_writepages
      1.10            +2.3        3.41 ±  5%  perf-profile.calltrace.cycles-pp.folio_end_writeback.iomap_finish_ioend.__submit_bio.__submit_bio_noacct.iomap_submit_ioend
      1.12            +2.3        3.44 ±  5%  perf-profile.calltrace.cycles-pp.iomap_finish_ioend.__submit_bio.__submit_bio_noacct.iomap_submit_ioend.iomap_writepages
      1.02 ±  2%      +2.4        3.42 ±  9%  perf-profile.calltrace.cycles-pp.__folio_start_writeback.iomap_writepage_map.iomap_writepages.xfs_vm_writepages.do_writepages
      0.70 ±  2%      +2.4        3.10 ±  9%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.sb_clear_inode_writeback.__folio_end_writeback.folio_end_writeback
      0.00            +2.4        2.42 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__mutex_lock.__flush_workqueue.xlog_cil_push_now
      0.00            +2.5        2.50 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__mutex_lock.__flush_workqueue.xlog_cil_push_now.xlog_cil_force_seq
      0.73 ±  2%      +2.5        3.23 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.sb_clear_inode_writeback.__folio_end_writeback.folio_end_writeback.iomap_finish_ioend
      1.17 ±  2%      +2.6        3.72 ±  8%  perf-profile.calltrace.cycles-pp.iomap_writepage_map.iomap_writepages.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc
      1.51            +2.7        4.20 ±  4%  perf-profile.calltrace.cycles-pp.__submit_bio.__submit_bio_noacct.iomap_submit_ioend.iomap_writepages.xfs_vm_writepages
      1.51            +2.7        4.21 ±  3%  perf-profile.calltrace.cycles-pp.__submit_bio_noacct.iomap_submit_ioend.iomap_writepages.xfs_vm_writepages.do_writepages
      1.54            +2.7        4.26 ±  4%  perf-profile.calltrace.cycles-pp.iomap_submit_ioend.iomap_writepages.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc
      2.83            +5.4        8.26 ±  5%  perf-profile.calltrace.cycles-pp.iomap_writepages.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
      2.84            +5.4        8.28 ±  5%  perf-profile.calltrace.cycles-pp.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range
      2.85            +5.4        8.30 ±  5%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync
      2.88            +5.5        8.34 ±  5%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync.xfs_file_buffered_write
      2.88            +5.5        8.36 ±  5%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync.xfs_file_buffered_write.vfs_write
      3.00            +5.6        8.62 ±  5%  perf-profile.calltrace.cycles-pp.file_write_and_wait_range.xfs_file_fsync.xfs_file_buffered_write.vfs_write.ksys_write
     75.49           -12.8       62.66        perf-profile.children.cycles-pp.osq_lock
     88.74           -11.7       77.04        perf-profile.children.cycles-pp.xlog_cil_force_seq
     90.97           -10.6       80.39        perf-profile.children.cycles-pp.xfs_log_force_seq
     77.14            -9.3       67.79        perf-profile.children.cycles-pp.__mutex_lock
     82.80            -8.9       73.87        perf-profile.children.cycles-pp.xlog_cil_push_now
     80.41            -8.5       71.94        perf-profile.children.cycles-pp.__flush_workqueue
     94.19            -4.9       89.34        perf-profile.children.cycles-pp.xfs_file_fsync
     96.26            -4.2       92.06        perf-profile.children.cycles-pp.xfs_file_buffered_write
     96.38            -4.1       92.26        perf-profile.children.cycles-pp.vfs_write
     96.39            -4.1       92.29        perf-profile.children.cycles-pp.ksys_write
     96.77            -3.9       92.83        perf-profile.children.cycles-pp.write
     96.72            -3.9       92.80        perf-profile.children.cycles-pp.do_syscall_64
     96.73            -3.9       92.82        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      5.30            -0.7        4.58        perf-profile.children.cycles-pp.remove_wait_queue
      1.26            -0.2        1.09 ±  2%  perf-profile.children.cycles-pp.xfs_vn_update_time
      0.41 ±  3%      -0.2        0.25 ±  5%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      1.28            -0.2        1.13 ±  2%  perf-profile.children.cycles-pp.kiocb_modified
      1.31            -0.1        1.18        perf-profile.children.cycles-pp.xfs_file_write_checks
      0.50 ±  2%      -0.1        0.38 ±  3%  perf-profile.children.cycles-pp.down_read
      0.32 ±  6%      -0.1        0.26 ±  2%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.10            -0.0        0.08        perf-profile.children.cycles-pp.activate_task
      0.16            -0.0        0.14        perf-profile.children.cycles-pp.detach_tasks
      0.08 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.xfs_iextents_copy
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.task_h_load
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.xfs_inode_to_log_dinode
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.mutex_unlock
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.sched_balance_domains
      0.20 ±  2%      +0.0        0.21        perf-profile.children.cycles-pp.sched_tick
      0.05            +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.update_min_vruntime
      0.09            +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.05 ±  7%      +0.0        0.07        perf-profile.children.cycles-pp.task_work_run
      0.05 ±  7%      +0.0        0.07        perf-profile.children.cycles-pp.xlog_grant_push_ail
      0.05            +0.0        0.07        perf-profile.children.cycles-pp.task_mm_cid_work
      0.06            +0.0        0.08        perf-profile.children.cycles-pp.xlog_cil_set_ctx_write_state
      0.06            +0.0        0.08        perf-profile.children.cycles-pp.xlog_cil_write_commit_record
      0.05            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.sync_disk_rw
      0.08            +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.07 ±  5%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.04 ± 45%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.xlog_grant_push_threshold
      0.06            +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.finish_task_switch
      0.05 ±  7%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.xlog_space_left
      0.05 ±  8%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.20 ±  2%      +0.0        0.23 ±  2%  perf-profile.children.cycles-pp.update_curr
      0.06 ±  6%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.native_sched_clock
      0.06            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__switch_to_asm
      0.05            +0.0        0.08        perf-profile.children.cycles-pp.___perf_sw_event
      0.05            +0.0        0.08        perf-profile.children.cycles-pp.__switch_to
      0.05            +0.0        0.08        perf-profile.children.cycles-pp.set_next_entity
      0.05            +0.0        0.08        perf-profile.children.cycles-pp.xlog_write_get_more_iclog_space
      0.06 ±  6%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.06            +0.0        0.09        perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.06            +0.0        0.09        perf-profile.children.cycles-pp.sched_clock
      0.05            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.llist_add_batch
      0.05            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.xlog_write_partial
      0.07            +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.06 ±  8%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.xlog_cil_alloc_shadow_bufs
      0.07 ±  5%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.xlog_state_clean_iclog
      0.06            +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.mutex_lock
      0.08 ±  6%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.available_idle_cpu
      0.05 ±  7%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.06 ±  9%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.blkdev_issue_flush
      0.03 ± 70%      +0.0        0.07        perf-profile.children.cycles-pp.kfree
      0.36            +0.0        0.39 ±  2%  perf-profile.children.cycles-pp.kick_ilb
      0.05 ±  7%      +0.0        0.09        perf-profile.children.cycles-pp.xa_load
      0.07            +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__memcpy
      0.07            +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.xfs_trans_committed_bulk
      0.11            +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.05            +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.xfs_iext_lookup_extent
      0.18 ±  2%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.06 ±  9%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.xlog_state_release_iclog
      0.10            +0.0        0.15        perf-profile.children.cycles-pp.update_rq_clock
      0.06            +0.1        0.11        perf-profile.children.cycles-pp.wakeup_preempt
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__fdget_pos
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__slab_free
      0.00            +0.1        0.05        perf-profile.children.cycles-pp._find_next_bit
      0.05            +0.1        0.10        perf-profile.children.cycles-pp.clockevents_program_event
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.fault_in_readable
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.llist_reverse_order
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.osq_unlock
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.rw_verify_area
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.up_read
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.zero_user_segments
      0.05            +0.1        0.10 ±  3%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.rest_init
      0.09 ±  5%      +0.1        0.14 ±  2%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.select_idle_core
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.start_kernel
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.xfs_log_space_wake
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.fprop_reflect_period_percpu
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.mempool_alloc_noprof
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.14 ±  3%      +0.1        0.19        perf-profile.children.cycles-pp.handle_softirqs
      0.05            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.xfs_btree_read_buf_block
      0.06 ±  6%      +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.__cond_resched
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.evict
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.kmem_cache_free
      0.22 ±  2%      +0.1        0.28        perf-profile.children.cycles-pp.xlog_cil_insert_format_items
      0.05            +0.1        0.11        perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.05            +0.1        0.11        perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__dentry_kill
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      0.00            +0.1        0.06        perf-profile.children.cycles-pp._nohz_idle_balance
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.dput
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.ksys_lseek
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.perf_tp_event
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.submit_bio_wait
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.xas_find_marked
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.xfs_cil_prepare_item
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.xfs_defer_finish
      0.02 ± 99%      +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.bio_alloc_bioset
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.memset_orig
      0.16 ±  2%      +0.1        0.22        perf-profile.children.cycles-pp.select_idle_sibling
      0.11 ±  3%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.prepare_task_switch
      0.10            +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.15 ±  2%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.47            +0.1        0.54        perf-profile.children.cycles-pp.complete
      0.13 ±  5%      +0.1        0.20 ±  3%  perf-profile.children.cycles-pp.xlog_grant_add_space
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.down_write
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.xfs_ilock
      0.13            +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.__wake_up
      0.12            +0.1        0.19 ±  2%  perf-profile.children.cycles-pp.select_idle_cpu
      0.12 ±  3%      +0.1        0.19 ±  3%  perf-profile.children.cycles-pp.sched_balance_find_src_rq
      0.11 ±  4%      +0.1        0.18        perf-profile.children.cycles-pp.xlog_cil_committed
      0.11 ±  4%      +0.1        0.18        perf-profile.children.cycles-pp.xlog_cil_process_committed
      0.06            +0.1        0.13 ±  2%  perf-profile.children.cycles-pp.__folio_mark_dirty
      0.09 ±  4%      +0.1        0.16        perf-profile.children.cycles-pp.xas_load
      0.06 ±  8%      +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.xfs_btree_lookup_get_block
      0.06 ±  8%      +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.xfs_trans_read_buf_map
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.__fput
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.filemap_get_folios_tag
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.xfs_defer_finish_noroll
      0.11 ±  3%      +0.1        0.18 ±  3%  perf-profile.children.cycles-pp.cpu_util
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.__close
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.__x64_sys_close
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.resched_curr
      0.25            +0.1        0.32        perf-profile.children.cycles-pp.select_task_rq_fair
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.xfs_bunmapi_range
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.xfs_inactive_truncate
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.xfs_itruncate_extents_flags
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.xfs_iunlock
      0.01 ±223%      +0.1        0.08        perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.02 ±141%      +0.1        0.09        perf-profile.children.cycles-pp.clear_bhb_loop
      0.24 ±  3%      +0.1        0.32 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.24            +0.1        0.31        perf-profile.children.cycles-pp.nohz_balance_exit_idle
      0.09            +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.refresh_cpu_vm_stats
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.__fprop_add_percpu
      0.09 ±  4%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.llseek
      0.27            +0.1        0.35        perf-profile.children.cycles-pp.select_task_rq
      0.32 ±  2%      +0.1        0.40        perf-profile.children.cycles-pp.xlog_cil_insert_items
      0.08 ±  4%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.filemap_get_entry
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      1.12            +0.1        1.20        perf-profile.children.cycles-pp.xlog_cil_commit
      0.07            +0.1        0.15        perf-profile.children.cycles-pp.io_schedule
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.xfs_buf_get_map
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.xfs_inactive
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.xfs_inodegc_worker
      0.06 ±  6%      +0.1        0.14 ±  2%  perf-profile.children.cycles-pp.xfs_map_blocks
      0.06 ±  9%      +0.1        0.14        perf-profile.children.cycles-pp.xfs_trans_alloc_inode
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.__iomap_write_begin
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.queue_delayed_work_on
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.xfs_buf_read_map
      0.02 ±141%      +0.1        0.10 ±  3%  perf-profile.children.cycles-pp.tick_nohz_restart_sched_tick
      0.18 ±  7%      +0.1        0.27        perf-profile.children.cycles-pp.xfs_log_ticket_ungrant
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.ktime_get
      0.08 ±  4%      +0.1        0.17        perf-profile.children.cycles-pp.filemap_dirty_folio
      0.01 ±223%      +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.folio_account_dirtied
      0.17            +0.1        0.26        perf-profile.children.cycles-pp.xlog_write
      0.01 ±223%      +0.1        0.10 ±  3%  perf-profile.children.cycles-pp.folio_clear_dirty_for_io
      0.07            +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.kick_pool
      0.36            +0.1        0.46        perf-profile.children.cycles-pp.update_load_avg
      0.23 ±  2%      +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.wake_up_q
      0.23 ±  3%      +0.1        0.32 ±  2%  perf-profile.children.cycles-pp._find_next_and_bit
      0.09            +0.1        0.19        perf-profile.children.cycles-pp.folio_wait_bit_common
      0.08 ±  4%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.menu_select
      0.09            +0.1        0.19        perf-profile.children.cycles-pp.folio_wait_writeback
      0.43            +0.1        0.53        perf-profile.children.cycles-pp.enqueue_task_fair
      0.40            +0.1        0.50        perf-profile.children.cycles-pp.dequeue_task_fair
      0.09            +0.1        0.19        perf-profile.children.cycles-pp.queue_work_on
      0.09 ±  5%      +0.1        0.19        perf-profile.children.cycles-pp.__queue_work
      0.08 ±  5%      +0.1        0.19 ±  2%  perf-profile.children.cycles-pp.wake_page_function
      0.28            +0.1        0.38        perf-profile.children.cycles-pp.xlog_cil_push_work
      0.08 ±  6%      +0.1        0.18 ±  4%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.11 ±  4%      +0.1        0.22        perf-profile.children.cycles-pp.xfs_buffered_write_iomap_begin
      0.18 ±  2%      +0.1        0.29        perf-profile.children.cycles-pp.xlog_state_do_callback
      0.24 ±  5%      +0.1        0.34 ±  2%  perf-profile.children.cycles-pp.xfs_log_reserve
      0.36            +0.1        0.47        perf-profile.children.cycles-pp.nohz_balancer_kick
      0.18 ±  2%      +0.1        0.29        perf-profile.children.cycles-pp.xlog_state_do_iclog_callbacks
      0.09 ±  4%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.xfs_btree_lookup
      0.09 ±  4%      +0.1        0.20        perf-profile.children.cycles-pp.writeback_get_folio
      0.25 ±  4%      +0.1        0.36 ±  2%  perf-profile.children.cycles-pp.xfs_trans_reserve
      0.19            +0.1        0.30        perf-profile.children.cycles-pp.xlog_ioend_work
      0.31            +0.1        0.42        perf-profile.children.cycles-pp.enqueue_entity
      1.22            +0.1        1.34        perf-profile.children.cycles-pp.__xfs_trans_commit
      0.10 ±  4%      +0.1        0.21        perf-profile.children.cycles-pp.folio_wake_bit
      0.28 ±  5%      +0.1        0.40 ±  2%  perf-profile.children.cycles-pp.xfs_trans_alloc
      0.27            +0.1        0.39        perf-profile.children.cycles-pp.dequeue_entity
      0.10 ±  4%      +0.1        0.22        perf-profile.children.cycles-pp.xfs_end_bio
      0.11            +0.1        0.24        perf-profile.children.cycles-pp.__filemap_fdatawait_range
      0.13 ±  2%      +0.1        0.26 ±  3%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.14 ±  3%      +0.1        0.28        perf-profile.children.cycles-pp.iomap_iter
      0.09 ±  7%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.12 ±  3%      +0.1        0.26        perf-profile.children.cycles-pp.writeback_iter
      0.12 ±  3%      +0.1        0.26        perf-profile.children.cycles-pp.iomap_set_range_uptodate
      0.14 ±  3%      +0.1        0.28 ±  2%  perf-profile.children.cycles-pp.schedule_idle
      0.13 ±  2%      +0.2        0.28 ±  2%  perf-profile.children.cycles-pp.iomap_writepage_map_blocks
      0.21            +0.2        0.36        perf-profile.children.cycles-pp.__wake_up_common
      0.18 ±  2%      +0.2        0.33        perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      0.21 ±  9%      +0.2        0.36 ±  7%  perf-profile.children.cycles-pp.xlog_force_lsn
      0.18 ±  2%      +0.2        0.33        perf-profile.children.cycles-pp.tick_nohz_stop_tick
      2.12 ±  2%      +0.2        2.28 ±  2%  perf-profile.children.cycles-pp.schedule_timeout
      2.17 ±  2%      +0.2        2.34 ±  2%  perf-profile.children.cycles-pp.__wait_for_common
      1.04            +0.2        1.21        perf-profile.children.cycles-pp.tick_nohz_handler
      1.04            +0.2        1.22        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.35            +0.2        0.52        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.17 ±  2%      +0.2        0.34        perf-profile.children.cycles-pp.flush_workqueue_prep_pwqs
      1.01            +0.2        1.18        perf-profile.children.cycles-pp.update_process_times
      0.27 ±  2%      +0.2        0.45 ±  4%  perf-profile.children.cycles-pp.idle_cpu
      0.45            +0.2        0.64        perf-profile.children.cycles-pp.ttwu_do_activate
      0.18 ±  2%      +0.2        0.37 ±  2%  perf-profile.children.cycles-pp.iomap_write_begin
      0.22 ±  2%      +0.2        0.42        perf-profile.children.cycles-pp.copy_to_brd
      0.17 ±  2%      +0.2        0.36        perf-profile.children.cycles-pp.xfs_bmap_add_extent_unwritten_real
      1.09            +0.2        1.28        perf-profile.children.cycles-pp.hrtimer_interrupt
      1.10            +0.2        1.30        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.18 ±  2%      +0.2        0.38        perf-profile.children.cycles-pp.xfs_bmapi_convert_unwritten
      0.42            +0.2        0.63        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.43            +0.2        0.65        perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.20 ±  2%      +0.2        0.43        perf-profile.children.cycles-pp.iomap_write_end
      0.29 ±  8%      +0.2        0.52        perf-profile.children.cycles-pp.brd_submit_bio
      1.22            +0.2        1.46        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.21 ±  3%      +0.2        0.45        perf-profile.children.cycles-pp.xfs_bmapi_write
      1.26            +0.3        1.54        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.52            +0.3        0.84        perf-profile.children.cycles-pp.sysvec_call_function_single
      0.87            +0.4        1.23        perf-profile.children.cycles-pp.try_to_wake_up
      1.11            +0.4        1.48        perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.29            +0.4        0.74 ±  2%  perf-profile.children.cycles-pp.__mutex_unlock_slowpath
      0.56            +0.6        1.16        perf-profile.children.cycles-pp.iomap_write_iter
      0.50            +0.6        1.13        perf-profile.children.cycles-pp.xfs_iomap_write_unwritten
      0.40            +0.7        1.12        perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.71            +0.8        1.47        perf-profile.children.cycles-pp.iomap_file_buffered_write
      0.92            +0.9        1.77        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      1.46 ±  3%      +0.9        2.34 ±  3%  perf-profile.children.cycles-pp.update_sg_lb_stats
      2.32 ±  3%      +0.9        3.21 ±  2%  perf-profile.children.cycles-pp.sched_balance_rq
      0.42            +0.9        1.34 ±  3%  perf-profile.children.cycles-pp.iomap_finish_ioends
      1.54 ±  3%      +0.9        2.47 ±  3%  perf-profile.children.cycles-pp.update_sd_lb_stats
      1.56 ±  3%      +0.9        2.49 ±  3%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      2.41 ±  2%      +0.9        3.36 ±  2%  perf-profile.children.cycles-pp.sched_balance_newidle
      2.51 ±  2%      +1.0        3.52 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      5.58 ±  2%      +1.0        6.59 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      2.10 ±  2%      +1.0        3.12 ±  2%  perf-profile.children.cycles-pp.xlog_wait_on_iclog
      0.82            +1.1        1.97        perf-profile.children.cycles-pp.acpi_safe_halt
      0.82            +1.2        1.97        perf-profile.children.cycles-pp.acpi_idle_enter
      0.84            +1.2        2.02        perf-profile.children.cycles-pp.cpuidle_enter_state
      0.85            +1.2        2.03        perf-profile.children.cycles-pp.cpuidle_enter
      3.22 ±  2%      +1.3        4.50 ±  2%  perf-profile.children.cycles-pp.schedule
      3.34 ±  2%      +1.4        4.76        perf-profile.children.cycles-pp.__schedule
      1.16            +1.5        2.66        perf-profile.children.cycles-pp.cpuidle_idle_call
      0.92            +1.6        2.48 ±  2%  perf-profile.children.cycles-pp.xfs_end_ioend
      0.92            +1.6        2.49 ±  2%  perf-profile.children.cycles-pp.xfs_end_io
      1.37            +1.7        3.08        perf-profile.children.cycles-pp.start_secondary
      1.39            +1.7        3.13        perf-profile.children.cycles-pp.common_startup_64
      1.39            +1.7        3.13        perf-profile.children.cycles-pp.cpu_startup_entry
      1.38            +1.7        3.13        perf-profile.children.cycles-pp.do_idle
      1.44            +1.8        3.29        perf-profile.children.cycles-pp.process_one_work
      1.54            +2.0        3.49        perf-profile.children.cycles-pp.worker_thread
      1.55            +2.0        3.51        perf-profile.children.cycles-pp.kthread
      1.55            +2.0        3.51        perf-profile.children.cycles-pp.ret_from_fork
      1.55            +2.0        3.51        perf-profile.children.cycles-pp.ret_from_fork_asm
      0.92 ±  3%      +2.2        3.16 ±  9%  perf-profile.children.cycles-pp.sb_mark_inode_writeback
      0.95 ±  2%      +2.3        3.25 ±  9%  perf-profile.children.cycles-pp.sb_clear_inode_writeback
      1.03 ±  2%      +2.4        3.43 ±  9%  perf-profile.children.cycles-pp.__folio_start_writeback
      1.17 ±  2%      +2.6        3.74 ±  8%  perf-profile.children.cycles-pp.iomap_writepage_map
      1.54            +2.7        4.26 ±  3%  perf-profile.children.cycles-pp.__submit_bio
      1.55            +2.7        4.27 ±  3%  perf-profile.children.cycles-pp.__submit_bio_noacct
      1.54            +2.7        4.26 ±  3%  perf-profile.children.cycles-pp.iomap_submit_ioend
      1.35            +3.0        4.34 ±  5%  perf-profile.children.cycles-pp.__folio_end_writeback
      1.51            +3.2        4.73 ±  4%  perf-profile.children.cycles-pp.folio_end_writeback
      1.53            +3.2        4.78 ±  4%  perf-profile.children.cycles-pp.iomap_finish_ioend
      7.60            +4.3       11.94 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     12.54            +4.7       17.23 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      2.83            +5.4        8.26 ±  5%  perf-profile.children.cycles-pp.iomap_writepages
      2.84            +5.4        8.28 ±  5%  perf-profile.children.cycles-pp.xfs_vm_writepages
      2.85            +5.4        8.30 ±  5%  perf-profile.children.cycles-pp.do_writepages
      2.88            +5.5        8.34 ±  5%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
      2.88            +5.5        8.36 ±  5%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
      3.00            +5.6        8.62 ±  5%  perf-profile.children.cycles-pp.file_write_and_wait_range
     74.34           -12.8       61.56        perf-profile.self.cycles-pp.osq_lock
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.task_h_load
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.dequeue_task_fair
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.update_min_vruntime
      0.06            +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.update_curr
      0.06 ±  9%      +0.0        0.07        perf-profile.self.cycles-pp.update_rq_clock_task
      0.08 ±  4%      +0.0        0.10        perf-profile.self.cycles-pp.__update_load_avg_se
      0.05            +0.0        0.07        perf-profile.self.cycles-pp.enqueue_task_fair
      0.08            +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.10 ±  3%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.xlog_cil_insert_items
      0.05 ±  7%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.xlog_space_left
      0.05 ±  8%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.08            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.down_read
      0.06            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__switch_to_asm
      0.05 ±  8%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.native_sched_clock
      0.04 ± 44%      +0.0        0.07        perf-profile.self.cycles-pp.___perf_sw_event
      0.05            +0.0        0.08        perf-profile.self.cycles-pp.__switch_to
      0.13 ±  3%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.nohz_balancer_kick
      0.15            +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.update_load_avg
      0.05            +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.llist_add_batch
      0.05            +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.vfs_write
      0.06 ±  7%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.06 ±  9%      +0.0        0.09        perf-profile.self.cycles-pp.enqueue_entity
      0.07            +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.available_idle_cpu
      0.24 ±  2%      +0.0        0.27        perf-profile.self.cycles-pp.kick_ilb
      0.05 ±  7%      +0.0        0.09 ±  9%  perf-profile.self.cycles-pp.mutex_lock
      0.07            +0.0        0.11        perf-profile.self.cycles-pp.__memcpy
      0.07            +0.0        0.11        perf-profile.self.cycles-pp.update_rq_clock
      0.07 ±  5%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.prepare_task_switch
      0.05            +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.xfs_iext_lookup_extent
      0.10 ±  4%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.07 ±  7%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.refresh_cpu_vm_stats
      0.05 ±  7%      +0.1        0.10 ±  3%  perf-profile.self.cycles-pp.filemap_get_entry
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__slab_free
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.fault_in_readable
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.kmem_cache_free
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.llist_reverse_order
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.osq_unlock
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.try_to_wake_up
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.up_read
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.xfs_log_space_wake
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.xlog_cil_commit
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.dequeue_entity
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.fprop_reflect_period_percpu
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.xas_find_marked
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.sched_balance_rq
      0.07 ±  5%      +0.1        0.13 ±  2%  perf-profile.self.cycles-pp.xas_load
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.10 ±  3%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.sched_balance_find_src_rq
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.__cond_resched
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.memset_orig
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.task_mm_cid_work
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.01 ±223%      +0.1        0.07        perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.08 ±  6%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.flush_workqueue_prep_pwqs
      0.13 ±  5%      +0.1        0.19 ±  3%  perf-profile.self.cycles-pp.xlog_grant_add_space
      0.10 ±  3%      +0.1        0.16 ±  4%  perf-profile.self.cycles-pp.cpu_util
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.write
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.select_idle_cpu
      0.05 ±  8%      +0.1        0.12 ±  5%  perf-profile.self.cycles-pp.__folio_end_writeback
      0.14 ±  6%      +0.1        0.21        perf-profile.self.cycles-pp.xfs_log_ticket_ungrant
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.resched_curr
      0.03 ± 70%      +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.__folio_start_writeback
      0.24            +0.1        0.31        perf-profile.self.cycles-pp.nohz_balance_exit_idle
      0.10 ±  5%      +0.1        0.17 ±  3%  perf-profile.self.cycles-pp.__mutex_lock
      0.00            +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.menu_select
      0.12            +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.__schedule
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.21 ±  4%      +0.1        0.30 ±  3%  perf-profile.self.cycles-pp._find_next_and_bit
      0.00            +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.queue_delayed_work_on
      0.01 ±223%      +0.1        0.09        perf-profile.self.cycles-pp.clear_bhb_loop
      0.06 ±  6%      +0.1        0.15 ±  4%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.06 ±  7%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.folio_end_writeback
      0.14 ±  2%      +0.1        0.26        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.08 ±  8%      +0.1        0.21        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.12            +0.1        0.25        perf-profile.self.cycles-pp.iomap_set_range_uptodate
      0.25 ±  2%      +0.2        0.42 ±  3%  perf-profile.self.cycles-pp.idle_cpu
      0.21            +0.2        0.40        perf-profile.self.cycles-pp.copy_to_brd
      0.39            +0.3        0.66 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.33 ±  2%      +0.4        0.68        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.10            +0.4        1.46        perf-profile.self.cycles-pp.mutex_spin_on_owner
      1.04 ±  3%      +0.6        1.61 ±  2%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.43            +0.6        1.05        perf-profile.self.cycles-pp.acpi_safe_halt
     12.49            +4.7       17.19 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/mmap1/will-it-scale

commit: 
  402de7fc88 ("sched: Fix spelling in comments")
  e2ee0a922a ("sched/fair: Reschedule the cfs_rq when current is ineligible")

402de7fc880fef05 e2ee0a922a6a2a8377dc66435c9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    116.48            -9.3%     105.60        vmstat.procs.r
      7173           -38.7%       4400 ± 12%  vmstat.system.cs
      0.44            -0.1        0.38        mpstat.cpu.all.irq%
     21.43            -2.3       19.12        mpstat.cpu.all.soft%
      9.26            -1.3        8.01        mpstat.cpu.all.usr%
   7030913           -10.4%    6299496        will-it-scale.104.processes
     67604           -10.4%      60571        will-it-scale.per_process_ops
   7030913           -10.4%    6299496        will-it-scale.workload
    325069 ±  7%    +170.4%     878887 ± 34%  meminfo.Active
    325037 ±  7%    +170.4%     878855 ± 34%  meminfo.Active(anon)
    500784           -16.8%     416503        meminfo.SUnreclaim
    604687           -13.9%     520677        meminfo.Slab
  1.48e+08           -47.8%   77344847        numa-numastat.node0.local_node
 1.481e+08           -47.7%   77411924        numa-numastat.node0.numa_hit
 1.554e+08           -49.5%   78446032        numa-numastat.node1.local_node
 1.555e+08           -49.5%   78496265        numa-numastat.node1.numa_hit
    684.83 ± 10%     +57.1%       1076 ±  8%  perf-c2c.DRAM.remote
      7077 ±  9%     +57.8%      11165        perf-c2c.HITM.local
    440.33 ± 11%     +59.6%     702.83 ±  9%  perf-c2c.HITM.remote
      7518 ±  9%     +57.9%      11868        perf-c2c.HITM.total
    259506 ±  6%     -14.7%     221296 ±  7%  numa-meminfo.node0.SUnreclaim
    322806 ±  7%     -14.3%     276805 ± 12%  numa-meminfo.node0.Slab
    317662 ±  8%    +161.5%     830799 ± 40%  numa-meminfo.node1.Active
    317652 ±  8%    +161.5%     830783 ± 40%  numa-meminfo.node1.Active(anon)
    244836 ±  5%     -20.6%     194289 ±  7%  numa-meminfo.node1.SUnreclaim
     64793 ±  6%     -14.5%      55394 ±  7%  numa-vmstat.node0.nr_slab_unreclaimable
 1.481e+08           -47.7%   77411719        numa-vmstat.node0.numa_hit
  1.48e+08           -47.8%   77344641        numa-vmstat.node0.numa_local
     79589 ±  8%    +161.1%     207810 ± 40%  numa-vmstat.node1.nr_active_anon
     64769 ±  7%     -24.9%      48616 ±  7%  numa-vmstat.node1.nr_slab_unreclaimable
     79589 ±  8%    +161.1%     207810 ± 40%  numa-vmstat.node1.nr_zone_active_anon
 1.555e+08           -49.5%   78495767        numa-vmstat.node1.numa_hit
 1.554e+08           -49.5%   78445534        numa-vmstat.node1.numa_local
     81309 ±  7%    +170.6%     220055 ± 34%  proc-vmstat.nr_active_anon
   1231133 ±  3%      +4.3%    1284018        proc-vmstat.nr_file_pages
    462903 ±  8%     +11.4%     515789        proc-vmstat.nr_shmem
    125903           -17.7%     103666        proc-vmstat.nr_slab_unreclaimable
     81309 ±  7%    +170.6%     220055 ± 34%  proc-vmstat.nr_zone_active_anon
 3.035e+08           -48.6%  1.559e+08        proc-vmstat.numa_hit
 3.034e+08           -48.7%  1.558e+08        proc-vmstat.numa_local
     90171          +401.8%     452480 ± 35%  proc-vmstat.pgactivate
 5.907e+08           -48.1%  3.067e+08        proc-vmstat.pgalloc_normal
   1036969            +3.0%    1068399        proc-vmstat.pgfault
 5.897e+08           -48.2%  3.055e+08        proc-vmstat.pgfree
      1.96           -18.8%       1.59        perf-stat.i.MPKI
  3.09e+10            -9.6%  2.794e+10        perf-stat.i.branch-instructions
      0.69            +0.0        0.73        perf-stat.i.branch-miss-rate%
   2.1e+08            -4.4%  2.008e+08        perf-stat.i.branch-misses
     61.40           -16.3       45.09        perf-stat.i.cache-miss-rate%
 3.107e+08           -26.9%  2.272e+08        perf-stat.i.cache-misses
      7151           -38.9%       4369 ± 12%  perf-stat.i.context-switches
      1.76           +13.2%       2.00        perf-stat.i.cpi
 2.792e+11            +2.0%  2.849e+11        perf-stat.i.cpu-cycles
    216.35            +9.9%     237.86 ±  3%  perf-stat.i.cpu-migrations
    898.44           +39.5%       1253        perf-stat.i.cycles-between-cache-misses
 1.581e+11            -9.9%  1.425e+11        perf-stat.i.instructions
      0.57           -11.6%       0.50        perf-stat.i.ipc
      3240            +3.2%       3345        perf-stat.i.minor-faults
      3241            +3.2%       3345        perf-stat.i.page-faults
      1.97           -18.8%       1.59        perf-stat.overall.MPKI
      0.68            +0.0        0.72        perf-stat.overall.branch-miss-rate%
     61.49           -16.3       45.15        perf-stat.overall.cache-miss-rate%
      1.77           +13.2%       2.00        perf-stat.overall.cpi
    898.37           +39.5%       1253        perf-stat.overall.cycles-between-cache-misses
      0.57           -11.7%       0.50        perf-stat.overall.ipc
 3.079e+10            -9.6%  2.785e+10        perf-stat.ps.branch-instructions
 2.092e+08            -4.4%      2e+08        perf-stat.ps.branch-misses
 3.097e+08           -26.9%  2.266e+08        perf-stat.ps.cache-misses
      7124           -38.9%       4352 ± 12%  perf-stat.ps.context-switches
 2.783e+11            +2.0%  2.839e+11        perf-stat.ps.cpu-cycles
    215.46            +9.9%     236.72 ±  3%  perf-stat.ps.cpu-migrations
 1.576e+11            -9.9%   1.42e+11        perf-stat.ps.instructions
      3221            +3.3%       3326        perf-stat.ps.minor-faults
      3221            +3.3%       3326        perf-stat.ps.page-faults
 4.775e+13           -10.1%  4.294e+13        perf-stat.total.instructions
    160361 ±  8%     -18.9%     130119 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      2.72 ±  2%     -28.6%       1.94 ±  4%  sched_debug.cfs_rq:/.h_nr_running.max
      0.36 ±  8%     -41.3%       0.21 ±  7%  sched_debug.cfs_rq:/.h_nr_running.stddev
   1377313 ± 27%     -91.6%     116337 ± 91%  sched_debug.cfs_rq:/.left_deadline.avg
   3796901 ± 12%     -76.8%     882366 ± 76%  sched_debug.cfs_rq:/.left_deadline.stddev
   1377297 ± 27%     -91.6%     116335 ± 91%  sched_debug.cfs_rq:/.left_vruntime.avg
   3796854 ± 12%     -76.8%     882354 ± 76%  sched_debug.cfs_rq:/.left_vruntime.stddev
     96021 ± 23%     -83.7%      15681 ± 35%  sched_debug.cfs_rq:/.load.avg
   1006635 ±  8%     -51.8%     485189 ± 57%  sched_debug.cfs_rq:/.load.max
    255965 ± 12%     -78.3%      55585 ± 66%  sched_debug.cfs_rq:/.load.stddev
     63.03 ±  9%     -88.2%       7.44        sched_debug.cfs_rq:/.load_avg.min
    160360 ±  8%     -18.9%     130119 ±  3%  sched_debug.cfs_rq:/.min_vruntime.stddev
      1.94 ±  4%     -25.7%       1.44 ± 18%  sched_debug.cfs_rq:/.nr_running.max
      0.29 ± 11%     -63.5%       0.11 ± 36%  sched_debug.cfs_rq:/.nr_running.stddev
   1377297 ± 27%     -91.6%     116335 ± 91%  sched_debug.cfs_rq:/.right_vruntime.avg
   3796855 ± 12%     -76.8%     882354 ± 76%  sched_debug.cfs_rq:/.right_vruntime.stddev
      1042           -12.2%     914.80        sched_debug.cfs_rq:/.runnable_avg.avg
      1977 ±  2%     -12.0%       1739 ±  6%  sched_debug.cfs_rq:/.runnable_avg.max
    161.50 ±  7%     -18.3%     131.95 ± 12%  sched_debug.cfs_rq:/.runnable_avg.stddev
    728.58 ±  4%     +13.0%     823.42 ±  3%  sched_debug.cfs_rq:/.util_est.avg
     19.03 ±  5%     -40.3%      11.35 ±  7%  sched_debug.cpu.clock.stddev
    841.52 ±  2%    +251.7%       2959 ± 26%  sched_debug.cpu.clock_task.stddev
    215.08 ± 30%    +588.2%       1480 ± 58%  sched_debug.cpu.curr->pid.min
      1117 ±  9%     -45.7%     606.60 ± 13%  sched_debug.cpu.curr->pid.stddev
      0.00 ± 30%     -29.1%       0.00 ±  4%  sched_debug.cpu.next_balance.stddev
      2.72 ±  2%     -28.6%       1.94 ±  4%  sched_debug.cpu.nr_running.max
      0.36 ±  7%     -41.1%       0.21 ±  8%  sched_debug.cpu.nr_running.stddev
     11340           -34.2%       7456 ±  7%  sched_debug.cpu.nr_switches.avg
      8336           -59.8%       3353 ± 13%  sched_debug.cpu.nr_switches.min
      2404 ±  5%     +72.9%       4156 ± 21%  sched_debug.cpu.nr_switches.stddev
     26.28 ± 13%     -24.6%      19.81 ± 15%  sched_debug.cpu.nr_uninterruptible.max
      7.01 ± 10%     -24.3%       5.30 ±  7%  sched_debug.cpu.nr_uninterruptible.stddev
     14.64           -11.9        2.71 ± 75%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn
     14.70           -11.9        2.78 ± 75%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     14.70           -11.9        2.78 ± 75%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     14.70           -11.9        2.78 ± 75%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     14.65           -11.9        2.75 ± 75%  perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread
     14.67           -11.9        2.78 ± 75%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     14.66           -11.9        2.77 ± 76%  perf-profile.calltrace.cycles-pp.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
     14.66           -11.9        2.77 ± 76%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     12.69           -10.4        2.27 ± 75%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
      8.64            -6.3        2.36 ± 23%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs
      5.90 ±  4%      -4.6        1.26 ± 25%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core
      5.79 ±  4%      -4.5        1.25 ± 25%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__slab_free.kmem_cache_free.rcu_do_batch
      3.03            -1.5        1.57 ± 43%  perf-profile.calltrace.cycles-pp.__put_partials.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs
     10.07            -0.9        9.13 ±  2%  perf-profile.calltrace.cycles-pp.mas_wr_bnode.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff
     12.52            -0.9       11.60 ±  2%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      8.45            -0.8        7.69 ±  2%  perf-profile.calltrace.cycles-pp.mas_split.mas_wr_bnode.mas_store_prealloc.mmap_region.do_mmap
      9.50            -0.7        8.80 ±  2%  perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      9.07            -0.7        8.41 ±  2%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      6.62            -0.6        6.05 ±  2%  perf-profile.calltrace.cycles-pp.mas_spanning_rebalance.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
     11.38            -0.5       10.85 ±  2%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      7.91            -0.5        7.40 ±  2%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
      0.96            -0.5        0.47 ± 44%  perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes
      4.92            -0.4        4.49 ±  2%  perf-profile.calltrace.cycles-pp.__cond_resched.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
      3.03            -0.3        2.74        perf-profile.calltrace.cycles-pp.__get_unmapped_area.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.07            -0.3        1.80        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__mmap
      2.36            -0.3        2.09 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap.vm_mmap_pgoff
      2.73            -0.3        2.45 ±  3%  perf-profile.calltrace.cycles-pp.vm_area_alloc.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      2.71            -0.3        2.44        perf-profile.calltrace.cycles-pp.thp_get_unmapped_area_vmflags.__get_unmapped_area.do_mmap.vm_mmap_pgoff.do_syscall_64
      2.04            -0.3        1.78        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__munmap
      2.50            -0.3        2.24        perf-profile.calltrace.cycles-pp.arch_get_unmapped_area_topdown_vmflags.thp_get_unmapped_area_vmflags.__get_unmapped_area.do_mmap.vm_mmap_pgoff
      2.16            -0.2        1.94 ±  2%  perf-profile.calltrace.cycles-pp.vm_unmapped_area.arch_get_unmapped_area_topdown_vmflags.thp_get_unmapped_area_vmflags.__get_unmapped_area.do_mmap
      1.86            -0.2        1.66 ±  2%  perf-profile.calltrace.cycles-pp.free_pgd_range.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      1.65            -0.2        1.46        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__munmap
      1.65            -0.2        1.47        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__mmap
      1.69            -0.2        1.50 ±  2%  perf-profile.calltrace.cycles-pp.free_p4d_range.free_pgd_range.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      1.30            -0.2        1.13 ±  3%  perf-profile.calltrace.cycles-pp.mab_mas_cp.mas_spanning_rebalance.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap
      1.51            -0.2        1.34 ±  2%  perf-profile.calltrace.cycles-pp.free_pud_range.free_p4d_range.free_pgd_range.unmap_region.do_vmi_align_munmap
      2.65            -0.2        2.49 ±  2%  perf-profile.calltrace.cycles-pp.perf_event_mmap.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      2.47            -0.2        2.31 ±  2%  perf-profile.calltrace.cycles-pp.mas_topiary_replace.mas_spanning_rebalance.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap
      1.64            -0.2        1.48 ±  2%  perf-profile.calltrace.cycles-pp.mast_fill_bnode.mas_split.mas_wr_bnode.mas_store_prealloc.mmap_region
      2.37            -0.2        2.22 ±  2%  perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.mmap_region.do_mmap.vm_mmap_pgoff
      2.22            -0.1        2.07 ±  3%  perf-profile.calltrace.cycles-pp.mas_topiary_replace.mas_split.mas_wr_bnode.mas_store_prealloc.mmap_region
      0.56            -0.1        0.44 ± 44%  perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff
      0.99            -0.1        0.87 ±  2%  perf-profile.calltrace.cycles-pp.mas_store_b_node.mas_wr_bnode.mas_store_prealloc.mmap_region.do_mmap
      1.11            -0.1        1.01 ±  2%  perf-profile.calltrace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.mmap_region
      1.61            -0.1        1.50 ±  2%  perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.mmap_region.do_mmap
      0.83            -0.1        0.73 ±  3%  perf-profile.calltrace.cycles-pp.mas_push_data.mas_split.mas_wr_bnode.mas_store_prealloc.mmap_region
      0.98            -0.1        0.88 ±  2%  perf-profile.calltrace.cycles-pp.mas_split_final_node.mas_split.mas_wr_bnode.mas_store_prealloc.mmap_region
      0.76            -0.1        0.66        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__mmap
      1.24            -0.1        1.14        perf-profile.calltrace.cycles-pp.mas_empty_area_rev.vm_unmapped_area.arch_get_unmapped_area_topdown_vmflags.thp_get_unmapped_area_vmflags.__get_unmapped_area
      0.72            -0.1        0.63 ±  3%  perf-profile.calltrace.cycles-pp.mas_pop_node.mas_split.mas_wr_bnode.mas_store_prealloc.mmap_region
      0.75            -0.1        0.66        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__munmap
      0.92            -0.1        0.84 ±  2%  perf-profile.calltrace.cycles-pp.rcu_all_qs.__cond_resched.zap_pmd_range.unmap_page_range.unmap_vmas
      0.81            -0.1        0.73 ±  2%  perf-profile.calltrace.cycles-pp.mab_mas_cp.mast_split_data.mas_split.mas_wr_bnode.mas_store_prealloc
      0.74            -0.1        0.67 ±  2%  perf-profile.calltrace.cycles-pp.mas_mab_cp.mas_store_b_node.mas_wr_bnode.mas_store_prealloc.mmap_region
      0.90            -0.1        0.84        perf-profile.calltrace.cycles-pp.mas_rev_awalk.mas_empty_area_rev.vm_unmapped_area.arch_get_unmapped_area_topdown_vmflags.thp_get_unmapped_area_vmflags
      0.99            -0.1        0.93 ±  2%  perf-profile.calltrace.cycles-pp.mast_split_data.mas_split.mas_wr_bnode.mas_store_prealloc.mmap_region
      0.76            -0.1        0.70 ±  2%  perf-profile.calltrace.cycles-pp.can_modify_mm.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      0.54            +0.3        0.84 ± 14%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__put_partials.kmem_cache_free
      0.54 ±  2%      +0.3        0.85 ± 14%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__put_partials.kmem_cache_free.mas_destroy
      0.54            +0.3        0.85 ± 14%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.__put_partials.kmem_cache_free.mas_destroy.mas_nomem
      0.64            +0.4        1.02        perf-profile.calltrace.cycles-pp.kmem_cache_free.mas_destroy.mas_store_prealloc.mmap_region.do_mmap
      0.84            +0.5        1.30 ±  2%  perf-profile.calltrace.cycles-pp.mas_destroy.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff
      0.00            +0.5        0.52 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__put_partials.kmem_cache_free.mas_destroy.mas_store_prealloc
      0.00            +0.6        0.55 ±  4%  perf-profile.calltrace.cycles-pp.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      0.00            +0.6        0.56 ±  5%  perf-profile.calltrace.cycles-pp.__cmd_record
      0.00            +0.6        0.56 ±  5%  perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.__cmd_record
      0.00            +0.6        0.56 ±  5%  perf-profile.calltrace.cycles-pp.record__finish_output.__cmd_record
      0.00            +0.6        0.62        perf-profile.calltrace.cycles-pp.__put_partials.kmem_cache_free.mas_destroy.mas_store_prealloc.mmap_region
      0.00            +0.7        0.68 ± 12%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__munmap
      0.26 ±100%      +0.7        0.94 ± 13%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__put_partials.kmem_cache_free_bulk
      0.00            +0.7        0.68 ± 12%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.__munmap
      0.26 ±100%      +0.7        0.95 ± 13%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.__put_partials.kmem_cache_free_bulk.mas_destroy.mas_nomem
      0.26 ±100%      +0.7        0.95 ± 13%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__put_partials.kmem_cache_free_bulk.mas_destroy
      0.65 ±  3%      +1.0        1.62 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.get_partial_node.get_any_partial.___slab_alloc
      0.66 ±  3%      +1.0        1.62 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.get_partial_node.get_any_partial.___slab_alloc.__kmem_cache_alloc_bulk
      0.80 ± 33%      +1.0        1.78 ± 13%  perf-profile.calltrace.cycles-pp.handle_softirqs.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__put_partials
     27.29            +1.4       28.69 ±  2%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      1.10 ±  3%      +1.5        2.58 ±  4%  perf-profile.calltrace.cycles-pp.get_any_partial.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes
      0.97 ±  3%      +1.5        2.49 ±  4%  perf-profile.calltrace.cycles-pp.get_partial_node.get_any_partial.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk_noprof
     23.87            +1.7       25.56 ±  2%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.42 ±  2%      +1.7        3.16 ± 13%  perf-profile.calltrace.cycles-pp.handle_softirqs.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.get_partial_node
      1.42 ±  2%      +1.7        3.16 ± 13%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.get_partial_node.___slab_alloc
      1.43 ±  2%      +1.8        3.19 ± 13%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.get_partial_node.___slab_alloc.__kmem_cache_alloc_bulk
      1.43 ±  2%      +1.8        3.20 ± 13%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.get_partial_node.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk_noprof
      1.08            +2.2        3.32        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__put_partials.kmem_cache_free.mas_destroy.mas_nomem
      1.76            +2.3        4.01        perf-profile.calltrace.cycles-pp.kmem_cache_free.mas_destroy.mas_nomem.mas_store_gfp.do_vmi_align_munmap
      1.53            +2.4        3.97        perf-profile.calltrace.cycles-pp.__put_partials.kmem_cache_free.mas_destroy.mas_nomem.mas_store_gfp
      1.01            +2.5        3.51 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__put_partials.kmem_cache_free_bulk.mas_destroy
      1.02            +2.5        3.54 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__put_partials.kmem_cache_free_bulk.mas_destroy.mas_nomem
      1.06            +2.7        3.80        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__put_partials.kmem_cache_free.mas_destroy
      1.44            +2.8        4.28        perf-profile.calltrace.cycles-pp.__put_partials.kmem_cache_free_bulk.mas_destroy.mas_nomem.mas_store_gfp
      2.39            +2.9        5.28        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.mmap_region.do_mmap.vm_mmap_pgoff
      2.96            +2.9        5.86        perf-profile.calltrace.cycles-pp.mas_preallocate.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64
      1.19            +2.9        4.11        perf-profile.calltrace.cycles-pp.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate
      1.80            +2.9        4.72        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate.mmap_region.do_mmap
      1.51            +3.0        4.49        perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
      2.55            +3.0        5.55        perf-profile.calltrace.cycles-pp.kmem_cache_free_bulk.mas_destroy.mas_nomem.mas_store_gfp.do_vmi_align_munmap
      1.23 ±  2%      +4.4        5.64 ± 27%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs.irq_exit_rcu
      2.22 ± 11%      +4.9        7.08 ± 23%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.irq_exit_rcu.sysvec_apic_timer_interrupt
      2.22 ± 11%      +4.9        7.10 ± 23%  perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      5.01            +5.6       10.58        perf-profile.calltrace.cycles-pp.mas_destroy.mas_nomem.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
      5.09            +5.6       10.67        perf-profile.calltrace.cycles-pp.mas_nomem.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
     18.03            +7.1       25.14        perf-profile.calltrace.cycles-pp.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      3.32            +7.8       11.13 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.get_partial_node.___slab_alloc.__kmem_cache_alloc_bulk
      7.20            +7.8       15.03        perf-profile.calltrace.cycles-pp.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_wr_spanning_store
      3.36            +7.9       11.24 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.get_partial_node.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk_noprof
      8.41            +8.0       16.38        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
      7.97            +8.0       15.97        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap
      7.82            +8.0       15.85        perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_wr_spanning_store.mas_store_gfp
      5.30            +9.7       14.97        perf-profile.calltrace.cycles-pp.get_partial_node.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes
     48.63           +10.9       59.56        perf-profile.calltrace.cycles-pp.__munmap
     43.23           +11.3       54.53        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     41.43           +11.4       52.78        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     41.39           +11.4       52.75        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     40.75           +11.4       52.18        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     42.05           +11.5       53.50        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     39.37           +11.6       50.92        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     23.84           +12.6       36.48        perf-profile.calltrace.cycles-pp.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
     14.70           -11.8        2.86 ± 70%  perf-profile.children.cycles-pp.ret_from_fork
     14.70           -11.8        2.86 ± 70%  perf-profile.children.cycles-pp.ret_from_fork_asm
     14.70           -11.8        2.86 ± 70%  perf-profile.children.cycles-pp.kthread
     14.67           -11.8        2.86 ± 70%  perf-profile.children.cycles-pp.smpboot_thread_fn
     14.66           -11.8        2.85 ± 70%  perf-profile.children.cycles-pp.run_ksoftirqd
     24.53            -5.2       19.38        perf-profile.children.cycles-pp.rcu_do_batch
     24.55            -5.1       19.44        perf-profile.children.cycles-pp.rcu_core
     24.56            -5.1       19.48        perf-profile.children.cycles-pp.handle_softirqs
     13.82            -4.2        9.62 ±  3%  perf-profile.children.cycles-pp.__slab_free
      3.16 ±  3%      -2.7        0.44 ±  6%  perf-profile.children.cycles-pp.free_unref_page
      3.11 ±  3%      -2.7        0.41 ±  6%  perf-profile.children.cycles-pp.free_unref_page_commit
      3.06 ±  3%      -2.7        0.40 ±  6%  perf-profile.children.cycles-pp.free_pcppages_bulk
     24.64            -2.2       22.46        perf-profile.children.cycles-pp.kmem_cache_free
     10.08            -0.9        9.14 ±  2%  perf-profile.children.cycles-pp.mas_wr_bnode
     12.54            -0.9       11.62 ±  2%  perf-profile.children.cycles-pp.unmap_region
      8.50            -0.8        7.74 ±  2%  perf-profile.children.cycles-pp.mas_split
      9.52            -0.7        8.82 ±  2%  perf-profile.children.cycles-pp.unmap_vmas
      9.10            -0.7        8.44 ±  2%  perf-profile.children.cycles-pp.unmap_page_range
      8.55            -0.6        7.93 ±  2%  perf-profile.children.cycles-pp.zap_pmd_range
      6.68            -0.6        6.09 ±  2%  perf-profile.children.cycles-pp.mas_spanning_rebalance
      1.31            -0.6        0.73 ±  6%  perf-profile.children.cycles-pp.allocate_slab
      4.15            -0.5        3.61        perf-profile.children.cycles-pp.syscall_return_via_sysret
     11.39            -0.5       10.86 ±  2%  perf-profile.children.cycles-pp.mas_store_prealloc
      5.68            -0.5        5.18 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      0.87            -0.4        0.44 ±  5%  perf-profile.children.cycles-pp.shuffle_freelist
      3.54            -0.4        3.13        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      4.70            -0.3        4.39 ±  2%  perf-profile.children.cycles-pp.mas_topiary_replace
      3.06            -0.3        2.76        perf-profile.children.cycles-pp.__get_unmapped_area
      3.10            -0.3        2.80 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      2.66            -0.3        2.36 ±  2%  perf-profile.children.cycles-pp.mab_mas_cp
      1.91            -0.3        1.62        perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.52            -0.3        1.24        perf-profile.children.cycles-pp.rcu_cblist_dequeue
      2.74            -0.3        2.46 ±  3%  perf-profile.children.cycles-pp.vm_area_alloc
      2.72            -0.3        2.44        perf-profile.children.cycles-pp.thp_get_unmapped_area_vmflags
      2.51            -0.3        2.25        perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown_vmflags
      3.27            -0.3        3.01 ±  2%  perf-profile.children.cycles-pp.mas_find
      2.17            -0.2        1.95        perf-profile.children.cycles-pp.vm_unmapped_area
      1.98            -0.2        1.77 ±  2%  perf-profile.children.cycles-pp.mas_mab_cp
      1.87            -0.2        1.66 ±  2%  perf-profile.children.cycles-pp.free_pgd_range
      0.39            -0.2        0.20 ±  6%  perf-profile.children.cycles-pp.setup_object
      1.48            -0.2        1.29 ±  2%  perf-profile.children.cycles-pp.mas_store_b_node
      1.70            -0.2        1.51 ±  2%  perf-profile.children.cycles-pp.free_p4d_range
      1.46            -0.2        1.28        perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      1.51            -0.2        1.34 ±  2%  perf-profile.children.cycles-pp.free_pud_range
      2.66            -0.2        2.50 ±  2%  perf-profile.children.cycles-pp.perf_event_mmap
      1.66            -0.2        1.50 ±  2%  perf-profile.children.cycles-pp.mast_fill_bnode
      2.41            -0.2        2.26 ±  2%  perf-profile.children.cycles-pp.perf_event_mmap_event
      1.38            -0.2        1.23        perf-profile.children.cycles-pp.rcu_all_qs
      1.72            -0.1        1.58 ±  2%  perf-profile.children.cycles-pp.mas_walk
      1.46            -0.1        1.32 ±  2%  perf-profile.children.cycles-pp.mas_pop_node
      0.53            -0.1        0.42 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.84            -0.1        0.73 ±  3%  perf-profile.children.cycles-pp.mas_push_data
      0.97            -0.1        0.86 ±  3%  perf-profile.children.cycles-pp.memcpy_orig
      1.62            -0.1        1.52 ±  2%  perf-profile.children.cycles-pp.perf_iterate_sb
      1.12            -0.1        1.01 ±  2%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.98            -0.1        0.88 ±  3%  perf-profile.children.cycles-pp.mas_split_final_node
      0.17            -0.1        0.07 ±  9%  perf-profile.children.cycles-pp.__free_one_page
      1.27            -0.1        1.18        perf-profile.children.cycles-pp.mas_empty_area_rev
      0.34 ±  2%      -0.1        0.25 ±  8%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.72            -0.1        0.64 ±  3%  perf-profile.children.cycles-pp.mas_next_slot
      0.30            -0.1        0.23 ±  9%  perf-profile.children.cycles-pp.get_page_from_freelist
      1.60            -0.1        1.53 ±  2%  perf-profile.children.cycles-pp.can_modify_mm
      0.92            -0.1        0.84        perf-profile.children.cycles-pp.mas_rev_awalk
      0.39            -0.1        0.32 ±  2%  perf-profile.children.cycles-pp.mas_next_sibling
      0.11 ±  4%      -0.1        0.04 ± 44%  perf-profile.children.cycles-pp.discard_slab
      0.44            -0.1        0.38        perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      1.00            -0.1        0.94 ±  2%  perf-profile.children.cycles-pp.mast_split_data
      0.67            -0.1        0.61 ±  3%  perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.64            -0.1        0.58 ±  2%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.36            -0.0        0.31 ±  3%  perf-profile.children.cycles-pp.mtree_range_walk
      0.10 ±  3%      -0.0        0.05        perf-profile.children.cycles-pp.strlen
      0.17 ±  4%      -0.0        0.12        perf-profile.children.cycles-pp.vm_get_page_prot
      0.42            -0.0        0.37        perf-profile.children.cycles-pp.mas_wr_walk
      0.34 ±  2%      -0.0        0.30 ±  2%  perf-profile.children.cycles-pp.mas_ascend
      0.66            -0.0        0.62 ±  2%  perf-profile.children.cycles-pp.mas_prev_slot
      0.12            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.mas_wr_end_piv
      0.39 ±  2%      -0.0        0.36 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.69            -0.0        0.66        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.39 ±  2%      -0.0        0.36        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.15 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.tlb_gather_mmu
      0.34 ±  2%      -0.0        0.31 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.10            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.x64_sys_call
      0.09 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.unmap_single_vma
      0.25            -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.mas_prev
      0.28 ±  3%      -0.0        0.25        perf-profile.children.cycles-pp.tick_nohz_handler
      0.20            -0.0        0.17 ±  9%  perf-profile.children.cycles-pp.rmqueue
      0.36            -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.down_write
      0.37            -0.0        0.35 ±  3%  perf-profile.children.cycles-pp.userfaultfd_unmap_complete
      0.13            -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.downgrade_write
      0.22 ±  2%      -0.0        0.19 ±  3%  perf-profile.children.cycles-pp.vma_set_page_prot
      0.25            -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.25 ±  2%      -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.34            -0.0        0.32 ±  2%  perf-profile.children.cycles-pp.down_write_killable
      0.24            -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.20 ±  2%      -0.0        0.18 ±  4%  perf-profile.children.cycles-pp.lru_add_drain
      0.23            -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.mas_prev_range
      0.26 ±  2%      -0.0        0.25        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.20 ±  3%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.security_mmap_addr
      0.13 ±  3%      -0.0        0.11        perf-profile.children.cycles-pp.kfree
      0.13 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.cap_mmap_addr
      0.09            -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.mas_wr_store_setup
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.strnlen
      0.42            +0.0        0.45        perf-profile.children.cycles-pp.free_pgtables
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.munmap@plt
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.unlink_file_vma
      0.12 ±  4%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.put_cpu_partial
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.06            +0.1        0.12        perf-profile.children.cycles-pp.mas_node_count_gfp
      0.04 ± 82%      +0.1        0.11 ± 36%  perf-profile.children.cycles-pp.perf_session__deliver_event
      0.06 ± 56%      +0.1        0.13 ± 36%  perf-profile.children.cycles-pp.__ordered_events__flush
      0.06 ± 56%      +0.1        0.13 ± 36%  perf-profile.children.cycles-pp.perf_session__process_user_event
      0.50 ±  2%      +0.1        0.60 ±  4%  perf-profile.children.cycles-pp.__cmd_record
      0.46 ±  3%      +0.1        0.56 ±  4%  perf-profile.children.cycles-pp.reader__read_event
      0.46 ±  3%      +0.1        0.56 ±  5%  perf-profile.children.cycles-pp.perf_session__process_events
      0.46 ±  3%      +0.1        0.56 ±  5%  perf-profile.children.cycles-pp.record__finish_output
      1.27 ±  2%      +1.3        2.60 ±  4%  perf-profile.children.cycles-pp.get_any_partial
     27.30            +1.4       28.71 ±  2%  perf-profile.children.cycles-pp.do_mmap
     23.97            +1.7       25.66 ±  2%  perf-profile.children.cycles-pp.mmap_region
      2.99            +2.9        5.90        perf-profile.children.cycles-pp.mas_preallocate
      2.57            +3.0        5.58        perf-profile.children.cycles-pp.kmem_cache_free_bulk
      5.11            +5.6       10.69        perf-profile.children.cycles-pp.mas_nomem
      5.86            +6.0       11.90        perf-profile.children.cycles-pp.mas_destroy
      8.62            +6.5       15.09        perf-profile.children.cycles-pp.__put_partials
     10.32            +6.7       17.00 ± 12%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     10.28            +6.7       16.97 ± 12%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      9.91            +6.7       16.64 ± 13%  perf-profile.children.cycles-pp.irq_exit_rcu
     18.05            +7.1       25.16        perf-profile.children.cycles-pp.mas_wr_spanning_store
      8.93           +10.6       19.54        perf-profile.children.cycles-pp.___slab_alloc
     21.72           +10.7       32.41        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     21.34           +10.7       32.06        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     10.83           +10.9       21.69        perf-profile.children.cycles-pp.mas_alloc_nodes
      9.83           +10.9       20.74        perf-profile.children.cycles-pp.kmem_cache_alloc_bulk_noprof
     48.77           +10.9       59.69        perf-profile.children.cycles-pp.__munmap
      9.34           +11.0       20.34        perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      6.43           +11.1       17.50        perf-profile.children.cycles-pp.get_partial_node
     41.42           +11.4       52.77        perf-profile.children.cycles-pp.__vm_munmap
     41.44           +11.4       52.80        perf-profile.children.cycles-pp.__x64_sys_munmap
     42.31           +11.4       53.70        perf-profile.children.cycles-pp.do_vmi_munmap
     39.46           +11.5       51.00        perf-profile.children.cycles-pp.do_vmi_align_munmap
     73.85           +12.5       86.37 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     23.89           +12.6       36.52        perf-profile.children.cycles-pp.mas_store_gfp
     71.49           +12.8       84.31 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
      4.77            -0.8        4.02        perf-profile.self.cycles-pp.__slab_free
      3.86            -0.6        3.28        perf-profile.self.cycles-pp.zap_pmd_range
      3.57            -0.5        3.04        perf-profile.self.cycles-pp.__cond_resched
      4.14            -0.5        3.60        perf-profile.self.cycles-pp.syscall_return_via_sysret
      3.04            -0.5        2.56        perf-profile.self.cycles-pp.mas_topiary_replace
      3.51            -0.4        3.10        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.64            -0.4        0.26 ±  4%  perf-profile.self.cycles-pp.shuffle_freelist
      1.98            -0.4        1.62        perf-profile.self.cycles-pp.mab_mas_cp
      2.40            -0.3        2.09        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.50            -0.3        1.22        perf-profile.self.cycles-pp.rcu_cblist_dequeue
      1.40            -0.3        1.14        perf-profile.self.cycles-pp.mas_mab_cp
      1.68            -0.3        1.42        perf-profile.self.cycles-pp.entry_SYSCALL_64
      1.42            -0.3        1.16        perf-profile.self.cycles-pp.mas_wr_spanning_store
      1.38            -0.3        1.12        perf-profile.self.cycles-pp.free_pud_range
      1.50            -0.2        1.26        perf-profile.self.cycles-pp.mas_walk
      1.32            -0.2        1.10        perf-profile.self.cycles-pp.mas_pop_node
      1.93            -0.2        1.74        perf-profile.self.cycles-pp.kmem_cache_free
      1.15            -0.2        0.97        perf-profile.self.cycles-pp.mas_spanning_rebalance
      1.02            -0.2        0.84        perf-profile.self.cycles-pp.perf_event_mmap_output
      0.92            -0.2        0.76        perf-profile.self.cycles-pp.rcu_all_qs
      0.86            -0.2        0.70        perf-profile.self.cycles-pp.memcpy_orig
      0.89            -0.2        0.74        perf-profile.self.cycles-pp.mas_split
      0.83            -0.1        0.69        perf-profile.self.cycles-pp.mast_fill_bnode
      1.15            -0.1        1.02        perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.76            -0.1        0.63        perf-profile.self.cycles-pp.mas_rev_awalk
      0.62            -0.1        0.50        perf-profile.self.cycles-pp.mas_next_slot
      0.90            -0.1        0.78        perf-profile.self.cycles-pp.mas_find
      0.60            -0.1        0.50 ±  2%  perf-profile.self.cycles-pp.mas_leaf_max_gap
      0.81            -0.1        0.71        perf-profile.self.cycles-pp.do_vmi_align_munmap
      0.37            -0.1        0.27 ±  2%  perf-profile.self.cycles-pp.vm_unmapped_area
      0.16            -0.1        0.07 ±  5%  perf-profile.self.cycles-pp.__free_one_page
      0.53            -0.1        0.44        perf-profile.self.cycles-pp.mas_wr_bnode
      0.60            -0.1        0.51 ±  2%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.37 ±  2%      -0.1        0.28 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc_bulk_noprof
      0.60            -0.1        0.52        perf-profile.self.cycles-pp.mas_prev_slot
      0.32            -0.1        0.24 ±  2%  perf-profile.self.cycles-pp.mas_store_b_node
      0.11            -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.discard_slab
      0.24 ±  2%      -0.1        0.17        perf-profile.self.cycles-pp.mas_next_sibling
      0.13 ±  2%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.setup_object
      0.77            -0.1        0.69        perf-profile.self.cycles-pp.mmap_region
      0.44            -0.1        0.38        perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.36            -0.1        0.29        perf-profile.self.cycles-pp.mas_wr_walk
      0.31            -0.1        0.25        perf-profile.self.cycles-pp.mtree_range_walk
      0.40 ±  2%      -0.1        0.34 ±  2%  perf-profile.self.cycles-pp.mas_push_data
      0.14 ±  2%      -0.1        0.08        perf-profile.self.cycles-pp.get_any_partial
      0.38            -0.1        0.32        perf-profile.self.cycles-pp.do_syscall_64
      0.30            -0.1        0.24        perf-profile.self.cycles-pp.mas_ascend
      0.32            -0.1        0.26 ±  2%  perf-profile.self.cycles-pp.mas_alloc_nodes
      0.42            -0.1        0.37        perf-profile.self.cycles-pp.unmap_page_range
      0.28            -0.1        0.23 ±  2%  perf-profile.self.cycles-pp.arch_get_unmapped_area_topdown_vmflags
      0.25 ±  2%      -0.1        0.20 ±  2%  perf-profile.self.cycles-pp.__vm_munmap
      0.35            -0.1        0.30        perf-profile.self.cycles-pp.mas_store_gfp
      0.17 ±  2%      -0.1        0.12 ±  4%  perf-profile.self.cycles-pp.mas_prev
      0.40 ±  3%      -0.1        0.34 ±  2%  perf-profile.self.cycles-pp.vm_area_free_rcu_cb
      0.15 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.vm_get_page_prot
      0.32 ±  2%      -0.0        0.27        perf-profile.self.cycles-pp.userfaultfd_unmap_complete
      0.18 ±  3%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.mas_split_final_node
      0.08            -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.34 ±  2%      -0.0        0.30        perf-profile.self.cycles-pp.kmem_cache_free_bulk
      0.51            -0.0        0.46        perf-profile.self.cycles-pp.mas_wr_walk_index
      0.32            -0.0        0.28 ±  2%  perf-profile.self.cycles-pp.mas_empty_area_rev
      0.29            -0.0        0.25        perf-profile.self.cycles-pp.mas_wr_store_entry
      0.24            -0.0        0.20        perf-profile.self.cycles-pp.unmap_region
      0.38            -0.0        0.35        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.41 ±  2%      -0.0        0.38        perf-profile.self.cycles-pp.build_detached_freelist
      0.19            -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.unmap_vmas
      0.45 ±  2%      -0.0        0.42        perf-profile.self.cycles-pp.perf_iterate_sb
      0.09 ±  5%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.mas_wr_end_piv
      0.14 ±  2%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.tlb_gather_mmu
      0.27            -0.0        0.23 ±  2%  perf-profile.self.cycles-pp.security_mmap_file
      0.19 ±  2%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.25 ±  2%      -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.up_write
      0.21 ±  3%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.25            -0.0        0.22        perf-profile.self.cycles-pp.__munmap
      0.21 ±  3%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.down_write
      0.22 ±  2%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.perf_event_mmap
      0.15 ±  2%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.mas_prev_range
      0.12 ±  3%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.downgrade_write
      0.08 ±  4%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.unmap_single_vma
      0.25            -0.0        0.22        perf-profile.self.cycles-pp.__mmap
      0.43            -0.0        0.40        perf-profile.self.cycles-pp.can_modify_mm
      0.08 ±  5%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.x64_sys_call
      0.34            -0.0        0.32        perf-profile.self.cycles-pp.perf_event_mmap_event
      0.23            -0.0        0.20        perf-profile.self.cycles-pp.vm_mmap_pgoff
      0.15 ±  3%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.lru_add_drain_cpu
      0.19            -0.0        0.16 ±  4%  perf-profile.self.cycles-pp.cap_vm_enough_memory
      0.14 ±  3%      -0.0        0.12        perf-profile.self.cycles-pp.__get_unmapped_area
      0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.mas_store_prealloc
      0.13 ±  2%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.vma_set_page_prot
      0.25 ±  2%      -0.0        0.23 ±  2%  perf-profile.self.cycles-pp.do_vmi_munmap
      0.16 ±  2%      -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.free_p4d_range
      0.15 ±  3%      -0.0        0.13        perf-profile.self.cycles-pp.free_pgd_range
      0.38            -0.0        0.36        perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.17 ±  2%      -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.down_write_killable
      0.11 ±  3%      -0.0        0.09        perf-profile.self.cycles-pp.cap_mmap_addr
      0.13            -0.0        0.11        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.12            -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.sized_strscpy
      0.16            -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.thp_get_unmapped_area_vmflags
      0.30            -0.0        0.28 ±  2%  perf-profile.self.cycles-pp.mas_preallocate
      0.10 ±  3%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.kfree
      0.22 ±  2%      -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.mt_free_rcu
      0.08 ±  6%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.testcase
      0.07            -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.mas_wr_store_setup
      0.12 ±  4%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.ima_file_mmap
      0.09 ±  4%      -0.0        0.08        perf-profile.self.cycles-pp.may_expand_vm
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.ksys_mmap_pgoff
      0.05            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.mas_node_count_gfp
      0.11            +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.put_cpu_partial
      0.91            +0.1        0.99        perf-profile.self.cycles-pp.___slab_alloc
      0.17 ±  2%      +0.1        0.30        perf-profile.self.cycles-pp.__put_partials
      0.79            +0.2        0.98        perf-profile.self.cycles-pp.__kmem_cache_alloc_bulk
      0.22 ±  3%      +0.4        0.57 ±  3%  perf-profile.self.cycles-pp.get_partial_node
     21.34           +10.7       32.06        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-csl-2sp3: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
=========================================================================================
build_kconfig/compiler/cpufreq_governor/disk/fs/kconfig/nr_task/rootfs/runtime/target/tbox_group/testcase:
  allyesconfig/gcc-13/performance/1HDD/ext4/x86_64-rhel-8.3/200%/debian-12-x86_64-20240206.cgz/300s/vmlinux/lkp-csl-2sp3/kbuild

commit: 
  402de7fc88 ("sched: Fix spelling in comments")
  e2ee0a922a ("sched/fair: Reschedule the cfs_rq when current is ineligible")

402de7fc880fef05 e2ee0a922a6a2a8377dc66435c9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    153.83 ± 12%     +29.9%     199.83 ± 10%  perf-c2c.HITM.remote
     22923          +168.0%      61427        vmstat.system.cs
     37.91            -1.6%      37.28        iostat.cpu.idle
     58.08            +1.1%      58.72        iostat.cpu.user
      0.00 ±  6%      +0.0        0.00 ± 25%  mpstat.cpu.all.iowait%
      0.07            -0.0        0.06        mpstat.cpu.all.soft%
    535449           +12.9%     604407        meminfo.Active
    527913           +13.1%     596880        meminfo.Active(anon)
    551555           +13.4%     625513        meminfo.Shmem
     10446 ±  8%     +23.8%      12936 ± 12%  sched_debug.cfs_rq:/.load.avg
    604834 ±  3%      +9.7%     663784 ±  6%  sched_debug.cpu.avg_idle.avg
    107052 ±  2%    +163.5%     282121 ±  2%  sched_debug.cpu.nr_switches.avg
    126834 ±  3%    +137.0%     300619 ±  2%  sched_debug.cpu.nr_switches.max
     97443 ±  2%    +172.0%     265007 ±  2%  sched_debug.cpu.nr_switches.min
      0.01 ± 35%     -80.9%       0.00 ±114%  sched_debug.cpu.nr_uninterruptible.avg
    109.85 ±  8%     -18.8%      89.19 ± 13%  sched_debug.cpu.nr_uninterruptible.max
    132091           +13.0%     149241        proc-vmstat.nr_active_anon
     24591            +8.7%      26726        proc-vmstat.nr_mapped
    137974           +13.4%     156458        proc-vmstat.nr_shmem
    132091           +13.0%     149241        proc-vmstat.nr_zone_active_anon
    205035 ±  2%     +11.6%     228812 ±  9%  proc-vmstat.numa_hint_faults_local
    210232            +7.0%     224885        proc-vmstat.numa_huge_pte_updates
 1.081e+08            +6.9%  1.156e+08        proc-vmstat.numa_pte_updates
    782895            +1.6%     795473        proc-vmstat.pgactivate
    688.87            +1.7%     700.70        kbuild.buildtime_per_iteration
    688.87            +1.7%     700.70        kbuild.real_time_per_iteration
      2326            +1.3%       2357        kbuild.sys_time_per_iteration
    695.12            +1.7%     706.98        kbuild.time.elapsed_time
    695.12            +1.7%     706.98        kbuild.time.elapsed_time.max
  10541259          +245.4%   36405253        kbuild.time.involuntary_context_switches
      2328            +1.3%       2359        kbuild.time.system_time
     38862            +2.7%      39907        kbuild.time.user_time
   3677194           +20.5%    4430873        kbuild.time.voluntary_context_switches
     38858            +2.7%      39902        kbuild.user_time_per_iteration
 2.957e+10            -1.3%  2.918e+10        perf-stat.i.branch-instructions
      2.19            +0.1        2.28        perf-stat.i.branch-miss-rate%
 7.918e+08            +3.2%  8.175e+08        perf-stat.i.branch-misses
     43.95            -1.8       42.13        perf-stat.i.cache-miss-rate%
 3.305e+08            +4.4%  3.451e+08        perf-stat.i.cache-misses
 9.203e+08           +12.6%  1.036e+09        perf-stat.i.cache-references
     22739          +168.8%      61127        perf-stat.i.context-switches
 1.652e+11            +1.3%  1.673e+11        perf-stat.i.cpu-cycles
    659.77            -1.9%     647.24        perf-stat.i.cpu-migrations
 1.354e+11            -1.3%  1.337e+11        perf-stat.i.instructions
      0.96            -1.8%       0.94        perf-stat.i.ipc
      8.90            +3.5%       9.21        perf-stat.i.metric.K/sec
    430092            -1.4%     424194        perf-stat.i.minor-faults
    430095            -1.4%     424198        perf-stat.i.page-faults
      2.44            +5.8%       2.58        perf-stat.overall.MPKI
      2.68            +0.1        2.80        perf-stat.overall.branch-miss-rate%
     35.90            -2.6       33.30        perf-stat.overall.cache-miss-rate%
      1.22            +2.6%       1.25        perf-stat.overall.cpi
    499.93            -3.0%     485.10        perf-stat.overall.cycles-between-cache-misses
      0.82            -2.6%       0.80        perf-stat.overall.ipc
  2.98e+10            -1.6%  2.934e+10        perf-stat.ps.branch-instructions
 7.984e+08            +3.0%  8.221e+08        perf-stat.ps.branch-misses
  3.33e+08            +4.1%  3.469e+08        perf-stat.ps.cache-misses
 9.278e+08           +12.3%  1.042e+09        perf-stat.ps.cache-references
     22908          +168.3%      61464        perf-stat.ps.context-switches
 1.665e+11            +1.1%  1.683e+11        perf-stat.ps.cpu-cycles
    663.70            -2.1%     649.73        perf-stat.ps.cpu-migrations
 1.365e+11            -1.5%  1.344e+11        perf-stat.ps.instructions
    433251            -1.6%     426310        perf-stat.ps.minor-faults
    433254            -1.6%     426315        perf-stat.ps.page-faults
      0.26 ±  2%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.38 ±  2%      -0.0        0.36 ±  2%  perf-profile.children.cycles-pp.do_execveat_common
      0.12 ±  6%      -0.0        0.09 ±  6%  perf-profile.children.cycles-pp.update_cfs_group
      0.38 ±  2%      -0.0        0.36 ±  3%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.24 ±  3%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.bprm_execve
      0.24 ±  3%      -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.copy_page
      0.17 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.___perf_sw_event
      0.04 ± 44%      +0.0        0.06        perf-profile.children.cycles-pp.__wake_up_common
      0.12 ±  3%      +0.0        0.14 ±  4%  perf-profile.children.cycles-pp.update_curr
      0.07 ±  6%      +0.0        0.09 ± 11%  perf-profile.children.cycles-pp.pipe_read
      0.06 ±  8%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.try_to_wake_up
      0.16 ±  4%      +0.0        0.19 ±  3%  perf-profile.children.cycles-pp.update_load_avg
      0.03 ± 70%      +0.0        0.08 ±  9%  perf-profile.children.cycles-pp.ktime_get
      0.15 ± 10%      +0.0        0.19 ± 12%  perf-profile.children.cycles-pp.export_symbol
      0.04 ± 44%      +0.0        0.09 ±  6%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.set_next_entity
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.rseq_get_rseq_cs
      0.06 ±  7%      +0.1        0.12 ±  5%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.10 ±  6%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.switch_fpu_return
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__get_user_8
      0.01 ±223%      +0.1        0.07 ±  9%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.08 ± 10%      +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.10 ±  7%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.ret_from_fork
      0.10 ±  8%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.kthread
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.prepare_task_switch
      0.07 ±  5%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.25 ±  3%      +0.3        0.50 ±  3%  perf-profile.children.cycles-pp.__schedule
      0.24 ±  4%      +0.3        0.50 ±  2%  perf-profile.children.cycles-pp.schedule
      2.38 ±  2%      +0.3        2.67 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.34 ±  4%      +0.3        0.68 ±  4%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.12 ±  6%      -0.0        0.09 ± 10%  perf-profile.self.cycles-pp.update_cfs_group
      0.05            +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.update_curr
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.__get_user_8
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.ktime_get
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.__schedule



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



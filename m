Return-Path: <linux-kernel+bounces-170608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FBC8BD9A9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 05:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19A31C219D9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A12D3FBA2;
	Tue,  7 May 2024 03:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HANE/nFb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB02015C9
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 03:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715051856; cv=fail; b=gio1AH5JNiqVjylMMpfGR36aSiyBxst+NWG3xXpj8aG0k/wgfPnP99xFr0k88AzApB8WWaGoHIcyEv2FMifM8KlBV4D1EqsxPg0XGQt5AEAQqEfUu0P2CaoZqBLR2yYm8L2AA9ggLjmhy4kYlqzm3B7S6HLgTviBUb705eOgNw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715051856; c=relaxed/simple;
	bh=XuIHemuWecb8MHftgFWPPcmngVDBAiev1jO5Rin6FD8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o9CWc6+XKfpJLIwvi6A76kmayM4Kr8CqpYTq1XloX7nm1e0fqZQujlAtIlUOT09CAU4aSQ14iEjxVFU+X4VpGI5uU0Wco0RFPrSRZvu7Y0q4RzepQ4C6amiGsVHhbv6tRTzNfVtaVqNsHPKlfxb9qvlUO+42vzSO2JyAjqoF6h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HANE/nFb; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715051854; x=1746587854;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=XuIHemuWecb8MHftgFWPPcmngVDBAiev1jO5Rin6FD8=;
  b=HANE/nFb4eZMdGqFE05ORp+eCmW0vCJvpmSjNAPenmmnTXUXXNxvTtKq
   yzGvTeFnJnyjEVh8Ba3EIYi6uCWV2sBnTMYmQxYYvytHIJ200BFW1IuyU
   liPJ6EgSLx54IMvito5tKt/to0z1ejAoN3YtsvTdv5W1NXVR6vzdMACWL
   z2e9V10ay75ZMi1FRW0SgvF6AGvKDXIWShUeBklvGLZGmcXOdHqlH7dVi
   VdnojJ8Y2VmxZazY/HBzfqu+gFvMXNoEAtHhpGlbN8HH6F8+ozX5wAPTM
   w8VHBuJK4ZNA7lGo/cWYRbt/jNYPjAnSBrJXQercPi/HNh/PdkZozS3l1
   w==;
X-CSE-ConnectionGUID: qttkRR4DTlWA9zIU1bd6mA==
X-CSE-MsgGUID: 7XYAQTDRRZKG92WnjuhxCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="28297846"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="28297846"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 20:17:34 -0700
X-CSE-ConnectionGUID: nbQXc5X7Q6eZxRwdWdZbNQ==
X-CSE-MsgGUID: frVTg78LQpKi2tqkbN9mZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="65819626"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 May 2024 20:17:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 20:17:32 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 20:17:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 20:17:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 20:17:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXD9vu29GkdWqb1LRaxlIKRK+Dcc1sGWqvt9GEoT8QxNPMlxdiWAvfS/UBZSmOUF/RABa3ktKxwL6pXff8QFSyqVM1sFl9L+HHfkexxIHTm8Epr7tSVlmLHdsxKmRsMBUZakL6UCPBx8iHFrXb7ynHp9ScGbvWeyW7j2nhkbw8S2xaC270P7jGDpp2JJ0dBSmzzWY138fpEg5TB2SLx5L8Ff/wWiN0P4Z5lfPgVZG/GKkMnQqJ+rj0GPgWcft3gh+/7Kp+jgtFsQgrJVH9jsmjN2SCMF2rQxuiT+TljWA76gMmvMNTsEz9D6Zp9dsMtYasLjN7gU9ybsZ5Q5HugB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AszLkt3KFwFZ5iCEBH6X+yoZNYkemNJc5hAnkyXic90=;
 b=GIwb62tfI0d4r5Lpk6h3jSLGCwXRsJuDiNwAa5pkvHrt/n7yQewXU936FBHq4GXdiWGwPSL3/LbNzukzP1sGnj0npcTys7LmjnK57mR4slYlf+m3bsNkEZqXdmILR4ZIGxZnjKaiVySYVO77yYoLTPHhbDbgeUVdGY5BURLmKZgcGyh2P4XKG5ABphPKjC8ESlTtDUsoodipMe3iOzSGYDGe/iqZnQFa5EFuEK8/eGvlZctzXRVqMIiI1sYDyXJ+zzgPSHnOLBqxvGpzWuhYYTlejA5vzKWM9RyWOT5mPB1fsGGfO/6Mq2G8HtrTPBj/FNmcLD0/Yg8gMCIeHrlWbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by CY5PR11MB6319.namprd11.prod.outlook.com (2603:10b6:930:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 03:17:30 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 03:17:30 +0000
Date: Tue, 7 May 2024 11:17:25 +0800
From: kernel test robot <yujie.liu@intel.com>
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
	<linux-kernel@vger.kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <x86@kernel.org>,
	<dave.hansen@linux.intel.com>, <tglx@linutronix.de>, <mingo@kernel.org>,
	<keith.lucas@oracle.com>, <aruna.ramakrishna@oracle.com>
Subject: Re: [PATCH v3 4/4] selftests/mm: Add new testcases for pkeys
Message-ID: <202404271128.ERrCledH-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240425180542.1042933-5-aruna.ramakrishna@oracle.com>
X-ClientProxiedBy: SG3P274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::33)
 To SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|CY5PR11MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 48234166-e651-45b8-2048-08dc6e443a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OJRH38c86FmrZB//1UzoeSnyThKyMlcbROQ6ISd4W5DBfRT4VBY5qElVhzHz?=
 =?us-ascii?Q?/pkEQZsKiV3eOXZtw3NmyZGnOrRMua3NYYcVY25AVcv8vxsBK5wakpzATfz2?=
 =?us-ascii?Q?/RZNBDSn6ETVk/DbkKEHyuIlU4m5lbdlP9a6Yt6Bj5b0DR4jf7o6wYonrGne?=
 =?us-ascii?Q?Ergd3UZw7ts3bLEAjGatIJhXnaqReQWWh9wg2rAhLRMxcsPIBFOL4x3BbBRr?=
 =?us-ascii?Q?hT/OOyKldCwhbfi0tAmDfnXQzhm/kL3eDuUGqBm5eE7a5nKQNa6h194DaW7V?=
 =?us-ascii?Q?8EOVvCRR8hmSQHEiT6Cw+nxZB/kL+Q41eg6GyzOiKEwdyxUCwKdKSe4qsRKW?=
 =?us-ascii?Q?s1lWp7Bh9jpWg6PsfZFOcmyKDo3fyp9KX9H+wXD4v0x4NqIhB/XSruPwlEGj?=
 =?us-ascii?Q?Hd3xAfucft698ssmJzcF5xd38p+wFhl4miFqTZ0q3MXsmwKbGcQXJC6tytD1?=
 =?us-ascii?Q?xKe4gSa25Sv+EZsMgL14bCwPSbqP9LzJtxWOVNaqubBCTnL4PmWIyG9CUB2x?=
 =?us-ascii?Q?X+K7TfsDQqmpm8EkOowBmvw0/sfKWIK0MVM1ezsNz7jcFuYNUXaIWYJZiBj1?=
 =?us-ascii?Q?Tlj7fZmf2QHQVg1Z5tL0icvS753zP7MHnKmdEmUtfOCiOETPi8OxgNFmp1Qa?=
 =?us-ascii?Q?e96spyvi/4gQN/x9QgZqNpkgGxsyVgSEQ7scg00U2TaxUYSzQ58tRJpuY3zm?=
 =?us-ascii?Q?3lRddbb3qxAnbyEu9cfhL3Hko8DNsQBa1uMFfknBz4DnI4uSYHBjo+ns2anY?=
 =?us-ascii?Q?ahXxRUAQpFp17V9kqul5P7QDPGTTCnXOdA2e3q6yFqYmTg72W/nfIZCSi7yq?=
 =?us-ascii?Q?EXAXlGB1UCwC3Avbg/HBVK5Y1rkPY8/LIPimOSdPvn62BjigCofhDbC7+rTn?=
 =?us-ascii?Q?CWLg6c2uD52ulgiAzU5ySinToAOWEuGTHG60UiAMpynNq3R9CRrWUYfgfxFd?=
 =?us-ascii?Q?u44g1Ay4+ec5dXa1u0vBOSdpqL8W/PLCQK2tetyoK2yC+79vKMZkYQkgwUSm?=
 =?us-ascii?Q?ExMluxR77byTbWIEmmft1CHuGboMezm4OPnSl0s/a3GrH2hAOUUv9rza9fxg?=
 =?us-ascii?Q?D6PtJxFnZTP1w3vn/Nw1OCFh2KnZSR44PGzGr3oRWJlSMFtO7e4iVPer40hy?=
 =?us-ascii?Q?xIK9y07NVKPJsZTc6I10i+u83BKUVy+oncu5MmKxMrwjMqNI64jtczPB+Cen?=
 =?us-ascii?Q?+jnJuISPN8nbmSWXMDNSN4NWV53avnkJYVKpcib3cm0k7tTTSMEcsSZbVuU?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BaqzfdWewIvywUy7M/rheeXuRATmJDo9QA28jjY/AF6mE6Fqp2EFjjkczL+K?=
 =?us-ascii?Q?cCs/fX/ucqmonTmfhOXwgDhPwNY3n7Xd5dyM478j4SfP202IzrumFQBR1V81?=
 =?us-ascii?Q?Axjl6l5+E7QSyv4fWHPXxcrT7UTIzurx4hgIbzcqxBw5Fga6ugVvmbvrIutf?=
 =?us-ascii?Q?fVKaBO0/0Vpk2chogzJg9HAlfrTTwraaAf5LPQRa6g1Woe7VljOFmCrBytu+?=
 =?us-ascii?Q?JJH+zcIW39UL3xmt9W+rulIfE9Hdwq6cSkHhLW/IfnpSnkxwaQMUDD7/DdMU?=
 =?us-ascii?Q?hS7Gd8YzjzNbTwN2G7PGe7qWRNSs12Q/E82EI7SQ630hVBnolvGQhdojAzbF?=
 =?us-ascii?Q?5PZdQKO4yfi0o1TL4yedtkl7/Xi95FyFVwNjbDSDQRBMOEPGZz2J7k4mwmwG?=
 =?us-ascii?Q?R+tYAk3NZxE3gSdX0HBCJY6nl52NaFnp+56oxiYMaXx6aGQB85cKKOtHJS3j?=
 =?us-ascii?Q?4Cfz07H/NDRkL4Otp3mUy+j+cixXHMuFVN0cTAeusu7qSw4CRiVNisnAShQu?=
 =?us-ascii?Q?yaGOYDDBdIB5zCFVABsQ/g88Iuyis/AEOCpr/OHMXPYT47t5yvdbQpAWLtlT?=
 =?us-ascii?Q?ckNad0f/wKIZlFHq0M/DQXv3IgtL0PtEz6r9oiyCprpQFbCLU/O9ab2eBN8G?=
 =?us-ascii?Q?e8IzL+tCefgDqs6mE5oPynHFse4BsWkiW4Dwa6QX8Fb2XJ5WhsC8+GqbFbZm?=
 =?us-ascii?Q?s1Mf2OdD70gRYFR0c/dyHgo/vfS3SP+b8xELEqa2md/oYaOIwUm5G3FGsiui?=
 =?us-ascii?Q?v1mdGe1JekULMFOGuAsP0w86iQbcb1X8H2CZOx2GW421KaMYI9AdTl96OJQN?=
 =?us-ascii?Q?WvExV2CT5aVYr/txdeEnNoPfwUL+qmAMPjTo24Wj/pyuF8ClwieMM1w63cTt?=
 =?us-ascii?Q?18v1y6blbZ2VQ3aZ9tc22WJQkgCCUwerzIqjjCBP+nlHFWwKMIrauq1T/9ou?=
 =?us-ascii?Q?wKbFDqO/mucdNTp7ewOOeQ6yMYTccKeI4JEg4dcj/3B/VgZkrBk1jcku6nyq?=
 =?us-ascii?Q?5EQ8zn6HNN9KFllQU8iPeHiSvtkEbdDDPGoRwUpXqJsWKsP8evhdQC3bqRkt?=
 =?us-ascii?Q?251r2rRlZjgKY7INcJQiwrXOYL71PssZtorWeNXeaMnYFgdwcwWmjbhmteoH?=
 =?us-ascii?Q?hYpeqa3agRc2AW3ZmPL2xlZ9UFHWfTnrP9qIMcBeHsOBg3iiyq0s3VOKAY1K?=
 =?us-ascii?Q?oIZ2xJmq5e14T0/6Br2vuREV5P9FO5DnpoI0CJVl3NaKEIaukTVgr/UdgC8I?=
 =?us-ascii?Q?uTF5k6QB/1E1lFi1b/pJKGe2z5dmrge/rHTzmW8kDVW6UHgtc3hVgqCZOXh9?=
 =?us-ascii?Q?t04+R4YXDuK6LOkpNJ+ihobU0n9rblWQu0OqVk4n/LcxrI0/Hu7Any1iI/QP?=
 =?us-ascii?Q?U1g/NcvXchyZ4UjrcV2nBBVgkmuSo39jYorWbLIYpJXFWWttoDXGqGMlxSCo?=
 =?us-ascii?Q?W07p6vuGkVITrJZw+VjS6jMFDtMVCL9zfyXxD5msNns+uE5pwCJwlMVAnUyi?=
 =?us-ascii?Q?eh1ge3ozWrICFO5c1aUo8AX40+9InK6juRdwUGf9ifreuOtGZee3Isy7z1HV?=
 =?us-ascii?Q?5XRcrSjqYg34ZBiR7KjRAuHaW9NkdeWeAGChsq0g?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48234166-e651-45b8-2048-08dc6e443a6c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 03:17:30.1620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KznICM80cOVTIn6OyAWKordCOGnr+wqUO14zL3VHEPpB4BFLw2PTtyyNC9XwAE6lo+/04dqE2tdJAv2Erc74Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6319
X-OriginatorOrg: intel.com

Hi Aruna,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on akpm-mm/mm-everything tip/master linus/master v6.9-rc5]
[cannot apply to tip/auto-latest next-20240426]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aruna-Ramakrishna/x86-pkeys-Signal-handling-function-interface-changes-to-accept-PKRU-as-a-parameter/20240426-020800
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20240425180542.1042933-5-aruna.ramakrishna%40oracle.com
patch subject: [PATCH v3 4/4] selftests/mm: Add new testcases for pkeys

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202404271128.ERrCledH-lkp@intel.com/

All errors:

linux/tools/testing/selftests/mm$ make
..
gcc -Wall -I /root/linux/tools/testing/selftests/../../..  -isystem /root/linux/tools/testing/selftests/../../../usr/include -no-pie  -m32 -mxsave  pkey_sighandler_tests.c vm_util.c thp_settings.c -lrt -lpthread -lm -lrt -ldl -lm -o /root/linux/tools/testing/selftests/mm/pkey_sighandler_tests_32
pkey_sighandler_tests.c: In function 'sigsegv_handler':
pkey_sighandler_tests.c:38:23: error: the register specified for 'r10' cannot be accessed by the current target
   38 |         register long r10 asm("r10") = a4;
      |                       ^~~
pkey_sighandler_tests.c:39:23: error: the register specified for 'r8' cannot be accessed by the current target
   39 |         register long r8 asm("r8") = a5;
      |                       ^~
pkey_sighandler_tests.c:40:23: error: the register specified for 'r9' cannot be accessed by the current target
   40 |         register long r9 asm("r9") = a6;
      |                       ^~
In function 'syscall_raw',
    inlined from 'sigsegv_handler' at pkey_sighandler_tests.c:58:2:
pkey_sighandler_tests.c:41:9: error: the register 'r11' cannot be clobbered in 'asm' for the current target
   41 |         asm volatile ("syscall"
      |         ^~~
pkey_sighandler_tests.c: In function 'thread_segv_maperr_ptr':
pkey_sighandler_tests.c:38:23: error: the register specified for 'r10' cannot be accessed by the current target
   38 |         register long r10 asm("r10") = a4;
      |                       ^~~
pkey_sighandler_tests.c:39:23: error: the register specified for 'r8' cannot be accessed by the current target
   39 |         register long r8 asm("r8") = a5;
      |                       ^~
pkey_sighandler_tests.c:40:23: error: the register specified for 'r9' cannot be accessed by the current target
   40 |         register long r9 asm("r9") = a6;
      |                       ^~
pkey_sighandler_tests.c:38:23: error: the register specified for 'r10' cannot be accessed by the current target
   38 |         register long r10 asm("r10") = a4;
      |                       ^~~
pkey_sighandler_tests.c:39:23: error: the register specified for 'r8' cannot be accessed by the current target
   39 |         register long r8 asm("r8") = a5;
      |                       ^~
pkey_sighandler_tests.c:40:23: error: the register specified for 'r9' cannot be accessed by the current target
   40 |         register long r9 asm("r9") = a6;
      |                       ^~
In function 'syscall_raw',
    inlined from 'thread_segv_maperr_ptr' at pkey_sighandler_tests.c:100:9:
pkey_sighandler_tests.c:41:9: error: the register 'r11' cannot be clobbered in 'asm' for the current target
   41 |         asm volatile ("syscall"
      |         ^~~
In function 'syscall_raw',
    inlined from 'thread_segv_maperr_ptr' at pkey_sighandler_tests.c:107:2:
pkey_sighandler_tests.c:41:9: error: the register 'r11' cannot be clobbered in 'asm' for the current target
   41 |         asm volatile ("syscall"
      |         ^~~
pkey_sighandler_tests.c: In function 'test_sigsegv_handler_with_different_pkey_for_stack':
pkey_sighandler_tests.c:38:23: error: the register specified for 'r10' cannot be accessed by the current target
   38 |         register long r10 asm("r10") = a4;
      |                       ^~~
pkey_sighandler_tests.c:39:23: error: the register specified for 'r8' cannot be accessed by the current target
   39 |         register long r8 asm("r8") = a5;
      |                       ^~
pkey_sighandler_tests.c:40:23: error: the register specified for 'r9' cannot be accessed by the current target
   40 |         register long r9 asm("r9") = a6;
      |                       ^~
pkey_sighandler_tests.c:38:23: error: the register specified for 'r10' cannot be accessed by the current target
   38 |         register long r10 asm("r10") = a4;
      |                       ^~~
pkey_sighandler_tests.c:39:23: error: the register specified for 'r8' cannot be accessed by the current target
   39 |         register long r8 asm("r8") = a5;
      |                       ^~
pkey_sighandler_tests.c:40:23: error: the register specified for 'r9' cannot be accessed by the current target
   40 |         register long r9 asm("r9") = a6;
      |                       ^~
In function 'syscall_raw',
    inlined from 'test_sigsegv_handler_with_different_pkey_for_stack' at pkey_sighandler_tests.c:233:13:
pkey_sighandler_tests.c:41:9: error: the register 'r11' cannot be clobbered in 'asm' for the current target
   41 |         asm volatile ("syscall"
      |         ^~~
In function 'syscall_raw',
    inlined from 'test_sigsegv_handler_with_different_pkey_for_stack' at pkey_sighandler_tests.c:247:3:
pkey_sighandler_tests.c:41:9: error: the register 'r11' cannot be clobbered in 'asm' for the current target
   41 |         asm volatile ("syscall"
      |         ^~~
make: *** [Makefile:146: /root/linux/tools/testing/selftests/mm/pkey_sighandler_tests_32] Error 1


linux/tools/testing/selftests/mm$ make LLVM=1
..
clang --target=x86_64-linux-gnu -fintegrated-as -Wall -I /root/linux/tools/testing/selftests/../../..  -isystem /root/linux/tools/testing/selftests/../../../usr/include -no-pie  -m32 -mxsave  pkey_sighandler_tests.c vm_util.c thp_settings.c -lrt -lpthread -lm -lrt -ldl -lm -o /root/linux/tools/testing/selftests/mm/pkey_sighandler_tests_32
pkey_sighandler_tests.c:41:16: error: couldn't allocate input reg for constraint '{r10}'
   41 |         asm volatile ("syscall"
      |                       ^
pkey_sighandler_tests.c:41:16: error: couldn't allocate input reg for constraint '{r10}'
pkey_sighandler_tests.c:41:16: error: couldn't allocate input reg for constraint '{r10}'
pkey_sighandler_tests.c:41:16: error: couldn't allocate input reg for constraint '{r10}'
pkey_sighandler_tests.c:41:16: error: couldn't allocate input reg for constraint '{r10}'
5 errors generated.
make: *** [Makefile:146: /root/linux/tools/testing/selftests/mm/pkey_sighandler_tests_32] Error 1


vim +41 tools/testing/selftests/mm/pkey_sighandler_tests.c

6b81215d7e8a34 Aruna Ramakrishna 2024-04-25  33  
6b81215d7e8a34 Aruna Ramakrishna 2024-04-25  34  static inline __attribute__((always_inline)) long
6b81215d7e8a34 Aruna Ramakrishna 2024-04-25  35  syscall_raw(long n, long a1, long a2, long a3, long a4, long a5, long a6)
6b81215d7e8a34 Aruna Ramakrishna 2024-04-25  36  {
6b81215d7e8a34 Aruna Ramakrishna 2024-04-25  37  	unsigned long ret;
6b81215d7e8a34 Aruna Ramakrishna 2024-04-25  38  	register long r10 asm("r10") = a4;
6b81215d7e8a34 Aruna Ramakrishna 2024-04-25  39  	register long r8 asm("r8") = a5;
6b81215d7e8a34 Aruna Ramakrishna 2024-04-25  40  	register long r9 asm("r9") = a6;
6b81215d7e8a34 Aruna Ramakrishna 2024-04-25 @41  	asm volatile ("syscall"
6b81215d7e8a34 Aruna Ramakrishna 2024-04-25  42  		      : "=a"(ret)
6b81215d7e8a34 Aruna Ramakrishna 2024-04-25  43  		      : "a"(n), "D"(a1), "S"(a2), "d"(a3), "r"(r10), "r"(r8), "r"(r9)
6b81215d7e8a34 Aruna Ramakrishna 2024-04-25  44  		      : "rcx", "r11", "memory");
6b81215d7e8a34 Aruna Ramakrishna 2024-04-25  45  	return ret;
6b81215d7e8a34 Aruna Ramakrishna 2024-04-25  46  }
6b81215d7e8a34 Aruna Ramakrishna 2024-04-25  47  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



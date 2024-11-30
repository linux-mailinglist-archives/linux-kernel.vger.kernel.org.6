Return-Path: <linux-kernel+bounces-426128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C92DA9DEF46
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 09:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4EE9B217BE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 08:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82CE14831D;
	Sat, 30 Nov 2024 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQK9DVNi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948C7143890
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 08:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732954047; cv=fail; b=OeYLXMnVpjhJteER0soxcpmEVtm8qOemOXaY34Me2zcdgxrkXKNBb+kiw7ZnM+EFwUcoM/bNCdHBYR78NoS8Q5yB9dd7Xi0JtJ3+/V99aRhshqdsgd8ttXE4wBAEYs0Tz2h+0ahHLlyLNA5WUjOsOFP3Z3gbmDcFjvMoJS7fmPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732954047; c=relaxed/simple;
	bh=18+0p7GXjxXPH7/QRG91rZ22g8ThG+hTOzL3zX04P2E=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=uG5w4OcJSp1LNUGNldkpefi6p/TZw5+34s0Twr8THTtV8HOhWB00nZvXmgEHuCHuEbrSyx7LdsLImwjI3im9a1TTseNicL8kTkhKtyz/BeWUkryrSm++ofvsPWgDM0LlTSceD5RftmtEJbs5p3YBIoq7X+1G5MSjrZRaS9SsDBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQK9DVNi; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732954044; x=1764490044;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=18+0p7GXjxXPH7/QRG91rZ22g8ThG+hTOzL3zX04P2E=;
  b=ZQK9DVNiufMFlCEupHZoezNaZiG7HCt5Wo/ELFTLt2VF3QGbsxl3Ruoi
   2+FH02QoMkva4pd+ATADDHpsrSRJkB3hbz2Lk6iUVxx1Db2KZv6FBdcZN
   9wpv10dlmc1yIUaLyvZjNNj960VXyq9H2DHDHY9DkVRfiA+F9gv4a5XES
   Gsv90UTljwQL7r7PKOr1ryG24CLocfnJ/kTf6mtjEqaD6r/mX4AM7vegt
   wn1LRENu/fDr4oIBRpqNfYj1QvbNm9AsL4fdW9SWcCT0wF+dnOxNTV4VY
   DFua1TnnI+lv1o+Fbz4prUBtemgwcPySkvrpH5FR1ikk/Ml/r2vgvE42V
   Q==;
X-CSE-ConnectionGUID: ZDWC8ZazTLO427z5S/Wkgg==
X-CSE-MsgGUID: GlqywfXwQ1OjyUD7OjlzJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="50692749"
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="50692749"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 00:07:24 -0800
X-CSE-ConnectionGUID: 2ktbVeQxREqYPCSferQrrg==
X-CSE-MsgGUID: HLoZ6aJSSOK6pOSBcfW82A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="92742887"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2024 00:07:24 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 30 Nov 2024 00:07:23 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 30 Nov 2024 00:07:23 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 30 Nov 2024 00:07:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRL0esB2hsgTzp9nXI4d4rnal74Vthc9QgpOt9KN1bQAZPiMYOYT/xHAMvC/GIh9T/tudpSQGJ95jK+q0zXXTmG1t5GMiuQ5Qg19wvUwWVxbuupiN2Ishub+VDFiK89ogyLkzJnuFP54nlW5cdv3shXSwmC2ava/vBAJFJz58vkoB7E2S57EtZ/FrIVokY/Eo5yOY7qBCMTUxbnHp1kz1P7/sQqbJLZ+4WMrDB2ljieFtM1Dk4izfU7TJQA+sOELMjY4T/5SXRMGhbFToKCQ9wYBq2JfeXVYOYM3+2+1i6eYqumgOobvT6M/bYkxjTb2eT8cXeUicUxgskXFzikMlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwxVM4Set8f6UiyTq6NaJCv2abemQxKXnqfR35+56A4=;
 b=JHqnsSb8d9VsyCD5AnVZ+yK+IekTec1URuwMUpQTsU9DTOdcRFA//anH4f/SgPlf8ME7j9olxyXhQmXleaxQw+FzSJ4vQcgzUEa6DxD57qoe7Xzj6gdnHr9QblyunjI8Ng+VxIpnsfTIHy6ig+2q1+US1NDAgDbyiUxMPASBKFzors7lOm35fbfi4tKaoHBEJjI05QFAimBoUzTh6gAaX54Xot0ZUheLL+ECzpBHbmsyxC75LXvlE58/BxBgCAK0iNlKE/Lmv5MxbsD98JVdaIdBHi7wGuB0DBy9rlN4QGCIfnt+nqkgNf5Kvg67uV/fBNzauH4FXP1Xf0vq5jXGqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV8PR11MB8723.namprd11.prod.outlook.com (2603:10b6:408:1f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Sat, 30 Nov
 2024 08:07:20 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8207.014; Sat, 30 Nov 2024
 08:07:19 +0000
Date: Sat, 30 Nov 2024 16:07:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Rik van Riel <riel@surriel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, <oliver.sang@intel.com>
Subject: [linus:master] [x86/mm/tlb]  7e33001b8b:
 will-it-scale.per_thread_ops 20.7% improvement
Message-ID: <202411301528.342383d8-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0079.apcprd02.prod.outlook.com
 (2603:1096:4:90::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV8PR11MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 94bcad6c-28fa-4b91-a036-08dd111602d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?7PiwWyfN9LsxStJQc7awMlSoVn5N9IVTBFLVMACcx9iAkkzUUBQhx55Ucz?=
 =?iso-8859-1?Q?pbB4OIPrNhmHeWgRKjwybH1cyjcuJI/7g2rhnJPy+xZgq03k1BPV433X40?=
 =?iso-8859-1?Q?Voa4CwMNz4aQ1/wz+2gMPuDt0ZlBBAuMMJjB9AWtS97rWjrYcqEsBHjdG+?=
 =?iso-8859-1?Q?ctxC7w53pKXFi2Zl+mKUX3Vi2egZNDlaeH4P0MuQN2qWltG7jDUdANnZLK?=
 =?iso-8859-1?Q?hnBrdMO+yTPyvXXaPGydTfMk6ADIwD/8YI3frTp7QtjnEepynEcbYFsFA2?=
 =?iso-8859-1?Q?hKePfa+s0mpFS5NPBLn1Ae0bYFaaD2SryGOxtBanuhTzTgjfHdl/JRWXad?=
 =?iso-8859-1?Q?phMIhBlNGlIAUVrU/gLIoWK3zauNX/Z17ruj4i4G08yBSWMzBJLqh0GHm/?=
 =?iso-8859-1?Q?t8OrWsi7hMBeKFO+u8/h5XJM5LA3QTyq/yZYN/dEB031k721dKy/5WcLYQ?=
 =?iso-8859-1?Q?ts4oDA/dk2ss0YeoYP4feqaBrZZqh0Yg8cvP4XnGeonfLRgw2SypKlCTRu?=
 =?iso-8859-1?Q?Kdw574ZOvvKdw/TVoEe7qIS2T5DMbGQcyP9dfSU0rM36fmHeKzI/Mq8d/5?=
 =?iso-8859-1?Q?tleXvtRTmTFW5r06kF/ypX5FR1Fv8rqwiynWtLcHsNc+tbWfZ7lYIFXzF8?=
 =?iso-8859-1?Q?PzwkzkrbxGu2ufUOWHmP0o2bBJsa7iO16xUqQekf6qSIP/EL31SvRdWpT5?=
 =?iso-8859-1?Q?L6DbgMy7CPMQ86n3j144L8480lSDv7vhq6NuJmEOKRS72ImtAq1HmP1DaE?=
 =?iso-8859-1?Q?6/4YnWcfgzzIiwdFVU4dKDVG80ksxDiFIK/1l51u2Zy4/uu0SutbJT5W3H?=
 =?iso-8859-1?Q?DqREacbvwL9snpVIlSDX51091w6jel10uBhMj73WrKfGFRhCmVxw8UuFmJ?=
 =?iso-8859-1?Q?KMPiL+io+AyP0H2pbrj5/2vsT3UTXhcVjEXPwPnikGquI9/VX2uYBJjH68?=
 =?iso-8859-1?Q?zgzJ4EF3aucLV5DuKDJAXUq9X5bWZyJn+7kTP1CKlWrnXmq5o4Cn59mC56?=
 =?iso-8859-1?Q?Do6pt7XQEIrMiBjaOiCouhuMC55gcMZcsjMy9Imn5sVfZIYWFksQVHSfqX?=
 =?iso-8859-1?Q?wLCqVuRav79CHpmiEbp9lpEr4sANbyqDqWgtvOMQ9SKZawmTSU2anWCtZL?=
 =?iso-8859-1?Q?czlTM3XgApTcPunaIAgy/3oNj6BLLf0/LR9DGzyfNhf36OEk/0JPx76gED?=
 =?iso-8859-1?Q?a9pYC0Q/qY8TFpHw5onHMMeBFVCK1OJLQpbUMkHwGI8aAE7ULc5TntsE/I?=
 =?iso-8859-1?Q?xR+/KRUc8sfNyHCDOsSepyf1rXZe5GspDUujL3sHmWz930mMnApfxO3ff3?=
 =?iso-8859-1?Q?+DSzsEseL/JUIjhw4JXZ7yDCqUm0I/+TSGwdj+Oxyh+B74IMCqJPzvUDQx?=
 =?iso-8859-1?Q?o63DjHSLSG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ddL7oCiC80gL1lZ469uOnCG/jiDyBzTpBGrKivvxe38VLYjTGUFenpjBj0?=
 =?iso-8859-1?Q?qW04Gg758ev4LYUGa9NxtF7fO+DQEEfDl1xdq0QR93MBaSLrNAuuii5FJV?=
 =?iso-8859-1?Q?5zrhaGB40pEJf8YiWBlY5KYoeqw5JBxH07zPbTg3P3lSFKRPPcKYE3poFY?=
 =?iso-8859-1?Q?XNwa3D0dKlNkNMKBbOVOGQL2PGkHMQqEKgRIP7iOe08PiGDh6cX514DxND?=
 =?iso-8859-1?Q?AhJqaV0o8BcrrYT0oq4Eb2aaiOz/i3D6jn8SnEtmUa7nNrTUGjB7LUAj/7?=
 =?iso-8859-1?Q?FBxXdYBRmCuv1U0OiRX7yhqdcv5ndq2aTvRoF7yg7uqYqZMcKRs0640q0U?=
 =?iso-8859-1?Q?TIxPJzcEuKXyvhQ4n0UEAexT5ucU/bfYxN0NIUUUYhlZ/Q74rKxhahm/KS?=
 =?iso-8859-1?Q?aGVDuPbEBjS5N8JvN1l774oI9UZUidkBOncKJ8BciWnFm/MXZspapX8ze3?=
 =?iso-8859-1?Q?RgyIU7VcUFv2v0fkF9ohQaDdjPw4HOCTckuNCYFvZRARBW2ytaLCRz920Z?=
 =?iso-8859-1?Q?dcA5KoZkESHPmJrmONWMh63UV0r1QfxZzs6f7F1Y0gKvpcGKmFmLnSuDP9?=
 =?iso-8859-1?Q?88UFeWCwiGLs18hh061zBxu5oQQ3TG7r0eXMbMAfOTl1VnuYHLzmV+scgS?=
 =?iso-8859-1?Q?8s7hexm55LCJyHUty2JzKjzHLk3l9VWCrPEDtHnoRxSHaqamSczpEkcLdo?=
 =?iso-8859-1?Q?b0I0BENAs26Plylbw3dhdCMXUBodKjiEAwpoR7Rl4FR5lONKvHqsHTLlgr?=
 =?iso-8859-1?Q?eKTOU7dURQkTek9T0ukkkb+cBQg1gOtkfM/0Xq8Nb3RmD702STVhuXrA6n?=
 =?iso-8859-1?Q?5JPtY3fSqyiuCCnBxu2iNPT5Rr89EEClOpTcTsj/6mhPASEI7nvVACAn1x?=
 =?iso-8859-1?Q?zT16YR7sGNy/neaXU3hv2lwEB+nHWBhzFRYFoKF4p1smUV0LXKd1LyIdfQ?=
 =?iso-8859-1?Q?har/wHzTzebTrSwN3oT6I91p576l7H0/Q4aljOePqpEG64SdL5u3VXy2y0?=
 =?iso-8859-1?Q?PAkB3GUr+MooeqAy77zMHKzoqo4WRVbjwfLW4OYU2Lt6Jv75gKsb0SGt0S?=
 =?iso-8859-1?Q?CVzFuP3QVS6X7ieZy1eoyQn+0iAvo1VUs5IUBMbJ02/UO5ShB5WWwQnQw7?=
 =?iso-8859-1?Q?+wjXwe5L5AIR2qWa/rNISfgiK+Rxy+vY3qybRy0Vfm3NXps4W0BdNp41mr?=
 =?iso-8859-1?Q?9BF/EBthlOmm+6fg8xAiYIg9x7Cedq/z7ORXb9PZg5gXz4hpjF/V1Rauni?=
 =?iso-8859-1?Q?MMPK8FemxF2M/xOF7MvscAtGve7j6jX5ZkCPo/uISz2xHj7t2CvnfMlZ/W?=
 =?iso-8859-1?Q?5Ye5x8RjRNpANeLIkqOI97UkqJFDKqIZ43sRtMIb0VhSwc1/9cV3mdr5NM?=
 =?iso-8859-1?Q?mgMj9EAjj8I2texyhxncWjBf++eWem0IN1LxeIACtU8FTU8c+n+Ey/0nzQ?=
 =?iso-8859-1?Q?34Z2zQ9xp9j1EZfTD7yU9UgyTP4MRpONAgXfNAU+L2wtoVS93ZdHGprJPP?=
 =?iso-8859-1?Q?p363WstEAE/kBDuG4j7A4NrSOGCqg8h/rvadLQptVs+kGrjTHLBmqtx1GN?=
 =?iso-8859-1?Q?lrZWCw7YrgWDi1eA1BajiMrKiOfNp4ViALwcckoVw5MIJAMz5SPxleujI7?=
 =?iso-8859-1?Q?KOM+fAHfZUUYnpnP5kC2Mfo3N55o9YA5gwBVWaz4LvUnEAYjMYT1sF3g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bcad6c-28fa-4b91-a036-08dd111602d1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 08:07:19.3815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3IfhTM66Sypj/GE+K3sxS7yOfcOBUwEKClA1UmbN7Maqx+OG9ewM2qbAkGGouJUPD4xVMZY2M04WZF0mlEYDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8723
X-OriginatorOrg: intel.com



Hello,

in this test, we don't have CONFIG_DEBUG_VM.
# CONFIG_DEBUG_VM is not set

below report is just FYI.


kernel test robot noticed a 20.7% improvement of will-it-scale.per_thread_ops on:


commit: 7e33001b8b9a78062679e0fdf5b0842a49063135 ("x86/mm/tlb: Put cpumask_test_cpu() check in switch_mm_irqs_off() under CONFIG_DEBUG_VM")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 100%
	mode: thread
	test: context_switch1
	cpufreq_governor: performance


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241130/202411301528.342383d8-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/thread/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/context_switch1/will-it-scale

commit: 
  abe949ce0f ("Merge tag 'v6.12-rc7' into x86/mm, to pick up fixes before applying new patches")
  7e33001b8b ("x86/mm/tlb: Put cpumask_test_cpu() check in switch_mm_irqs_off() under CONFIG_DEBUG_VM")

abe949ce0f9be943 7e33001b8b9a78062679e0fdf5b 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     28.28 ±  5%      +4.7       32.96 ±  2%  mpstat.cpu.all.usr%
     68316 ± 45%     -43.0%      38971 ± 63%  numa-numastat.node0.other_node
     68316 ± 45%     -43.0%      38971 ± 63%  numa-vmstat.node0.numa_other
      0.01 ± 72%    +140.0%       0.01 ± 18%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
  16400085 ±  5%     +22.8%   20143765 ±  2%  vmstat.system.cs
  17103848           +20.7%   20638715        will-it-scale.104.threads
    164459           +20.7%     198448        will-it-scale.per_thread_ops
  17103848           +20.7%   20638715        will-it-scale.workload
    384.50 ± 28%     -67.6%     124.60 ± 36%  perf-c2c.DRAM.local
      1068 ±  8%     -77.7%     238.40 ± 29%  perf-c2c.DRAM.remote
      8314 ±  8%     -50.2%       4139 ± 30%  perf-c2c.HITM.local
      8446 ±  8%     -49.1%       4297 ± 28%  perf-c2c.HITM.total
      0.21 ±  8%     -23.3%       0.16 ±  6%  sched_debug.cfs_rq:/.h_nr_running.stddev
     10757 ± 18%     -15.3%       9106 ±  7%  sched_debug.cfs_rq:/.load.avg
      0.83           +52.0%       1.27 ± 13%  sched_debug.cpu.nr_running.min
      0.24 ±  4%     -41.3%       0.14 ± 11%  sched_debug.cpu.nr_running.stddev
  24327344           +20.3%   29272455        sched_debug.cpu.nr_switches.avg
  25987818           +14.9%   29865135        sched_debug.cpu.nr_switches.max
  21699605 ±  3%     +21.5%   26368088        sched_debug.cpu.nr_switches.min
   1360372 ± 13%     -58.0%     571428 ± 41%  sched_debug.cpu.nr_switches.stddev
     22.94 ± 11%     -32.0%      15.60 ± 25%  sched_debug.cpu.nr_uninterruptible.max
      0.35 ± 26%     -43.3%       0.20 ± 39%  perf-stat.i.MPKI
 1.888e+10 ±  5%     +21.0%  2.286e+10 ±  2%  perf-stat.i.branch-instructions
 2.648e+08 ±  5%     +24.1%  3.287e+08 ±  2%  perf-stat.i.branch-misses
  26642185 ± 15%     -28.3%   19102179 ± 24%  perf-stat.i.cache-misses
 1.078e+08 ± 10%     -28.1%   77522633 ± 17%  perf-stat.i.cache-references
  16520503 ±  5%     +22.9%   20296309 ±  2%  perf-stat.i.context-switches
      2.99           -16.4%       2.50        perf-stat.i.cpi
     10422 ± 10%     +57.2%      16379 ± 37%  perf-stat.i.cycles-between-cache-misses
   9.4e+10 ±  5%     +21.2%  1.139e+11 ±  2%  perf-stat.i.instructions
      0.34           +18.6%       0.40        perf-stat.i.ipc
    158.85 ±  5%     +22.9%     195.15 ±  2%  perf-stat.i.metric.K/sec
      0.28 ± 12%     -40.7%       0.17 ± 24%  perf-stat.overall.MPKI
      1.40            +0.0        1.44        perf-stat.overall.branch-miss-rate%
      2.98           -16.6%       2.49        perf-stat.overall.cpi
     10679 ± 10%     +51.1%      16135 ± 34%  perf-stat.overall.cycles-between-cache-misses
      0.34           +19.9%       0.40        perf-stat.overall.ipc
   1710303            -1.5%    1684995        perf-stat.overall.path-length
 1.882e+10 ±  5%     +21.0%  2.278e+10 ±  2%  perf-stat.ps.branch-instructions
 2.639e+08 ±  5%     +24.2%  3.277e+08 ±  2%  perf-stat.ps.branch-misses
  26554647 ± 15%     -28.3%   19035653 ± 24%  perf-stat.ps.cache-misses
 1.074e+08 ± 10%     -28.0%   77345133 ± 17%  perf-stat.ps.cache-references
  16466063 ±  5%     +22.9%   20230564 ±  2%  perf-stat.ps.context-switches
 9.369e+10 ±  5%     +21.2%  1.135e+11 ±  2%  perf-stat.ps.instructions
 2.925e+13           +18.9%  3.478e+13        perf-stat.total.instructions
     10.59 ±  5%      -6.1        4.44 ±  3%  perf-profile.calltrace.cycles-pp.__switch_to_asm.read
      9.09 ±  5%      -5.5        3.55 ±  3%  perf-profile.calltrace.cycles-pp.__switch_to_asm.write
      6.14 ±  2%      -1.0        5.11        perf-profile.calltrace.cycles-pp.__schedule.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.30            -1.0        5.30        perf-profile.calltrace.cycles-pp.schedule.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     10.11            -0.6        9.49        perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
     10.30            -0.6        9.74        perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
      8.56            -0.5        8.04        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.81            +0.1        0.93        perf-profile.calltrace.cycles-pp.switch_fpu_return.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.60            +0.1        0.72        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read.ksys_read
      0.79            +0.1        0.93        perf-profile.calltrace.cycles-pp.fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.54 ±  4%      +0.1        0.68        perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule.pipe_read.vfs_read
      0.73 ±  2%      +0.2        0.89        perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.68 ±  2%      +0.2        0.84        perf-profile.calltrace.cycles-pp._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write.ksys_write
      0.66 ±  2%      +0.2        0.83        perf-profile.calltrace.cycles-pp.__rseq_handle_notify_resume.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.79            +0.2        0.96        perf-profile.calltrace.cycles-pp.fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.67            +0.2        0.85        perf-profile.calltrace.cycles-pp.prepare_to_wait_event.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.52 ±  2%      +0.2        0.71        perf-profile.calltrace.cycles-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.82 ±  3%      +0.2        1.03 ±  3%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_entities.dequeue_task_fair.__schedule
      0.97 ±  2%      +0.2        1.20        perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.95 ±  2%      +0.2        1.20 ±  2%  perf-profile.calltrace.cycles-pp.__rseq_handle_notify_resume.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.77 ±  3%      +0.2        1.01 ±  2%  perf-profile.calltrace.cycles-pp.requeue_delayed_entity.enqueue_task.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.78 ±  4%      +0.2        1.03 ±  3%  perf-profile.calltrace.cycles-pp.update_curr.check_preempt_wakeup_fair.wakeup_preempt.try_to_wake_up.autoremove_wake_function
      1.17            +0.2        1.42        perf-profile.calltrace.cycles-pp.switch_fpu_return.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.66 ±  2%      +0.3        0.93        perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.pipe_read.vfs_read.ksys_read
      1.60            +0.3        1.87        perf-profile.calltrace.cycles-pp.restore_fpregs_from_fpstate.switch_fpu_return.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.92            +0.3        2.19 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_entities.dequeue_task_fair.__schedule.schedule.pipe_read
      0.83 ±  2%      +0.3        1.14        perf-profile.calltrace.cycles-pp.touch_atime.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.15            +0.3        2.47 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_read.vfs_read
      1.08 ±  3%      +0.3        1.41        perf-profile.calltrace.cycles-pp.enqueue_task.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
      1.60 ±  2%      +0.3        1.94 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_entities.dequeue_task_fair.__schedule.schedule
      1.58 ±  2%      +0.4        2.00        perf-profile.calltrace.cycles-pp.put_prev_entity.pick_next_task_fair.__pick_next_task.__schedule.schedule
      1.06 ± 23%      +0.4        1.49        perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__pick_next_task.__schedule.schedule
      1.85 ±  2%      +0.4        2.30        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
      1.36 ±  3%      +0.5        1.83        perf-profile.calltrace.cycles-pp.check_preempt_wakeup_fair.wakeup_preempt.try_to_wake_up.autoremove_wake_function.__wake_up_common
      2.01            +0.5        2.48        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      0.08 ±223%      +0.5        0.59        perf-profile.calltrace.cycles-pp.prepare_task_switch.__schedule.schedule.syscall_exit_to_user_mode.do_syscall_64
      0.08 ±223%      +0.5        0.59        perf-profile.calltrace.cycles-pp.update_load_avg.dequeue_entity.dequeue_entities.dequeue_task_fair.__schedule
      1.36 ±  3%      +0.5        1.87        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.read
      1.28 ± 16%      +0.5        1.80 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.write
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.os_xsave.read
      2.42 ±  2%      +0.5        2.95        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule.syscall_exit_to_user_mode
      1.56 ±  3%      +0.5        2.11        perf-profile.calltrace.cycles-pp.wakeup_preempt.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
      1.82 ±  2%      +0.5        2.37        perf-profile.calltrace.cycles-pp.pick_task_fair.pick_next_task_fair.__pick_next_task.__schedule.schedule
      2.55 ±  2%      +0.6        3.10        perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule.syscall_exit_to_user_mode.do_syscall_64
      0.00            +0.6        0.55 ±  2%  perf-profile.calltrace.cycles-pp.pick_eevdf.pick_task_fair.pick_next_task_fair.__pick_next_task.__schedule
      0.62 ±  2%      +0.7        1.28        perf-profile.calltrace.cycles-pp.rseq_ip_fixup.__rseq_handle_notify_resume.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.88            +0.7        3.58        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      4.66 ±  2%      +0.8        5.43        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.write
     14.94            +0.8       15.76        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.82 ±  2%      +0.8        3.66        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule.pipe_read
      4.45 ±  6%      +0.9        5.31 ±  6%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.pipe_write
      2.97 ±  2%      +0.9        3.85        perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule.pipe_read.vfs_read
      4.88 ±  2%      +0.9        5.77        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.read
      4.70 ±  6%      +1.0        5.66 ±  5%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.pipe_write.vfs_write
      6.10            +1.0        7.08        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.read
      4.87 ±  6%      +1.0        5.89 ±  5%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_sync_key.pipe_write.vfs_write.ksys_write
      6.16            +1.1        7.21        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.write
     15.81            +1.1       16.87        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      5.28 ±  5%      +1.1        6.38 ±  5%  perf-profile.calltrace.cycles-pp.__wake_up_sync_key.pipe_write.vfs_write.ksys_write.do_syscall_64
     17.09            +1.4       18.47        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      8.48 ±  4%      +2.0       10.52 ±  2%  perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.18 ±  3%      +2.2       11.36 ±  2%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     19.80 ±  2%      +2.2       22.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     20.67            +2.4       23.05        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     10.43 ±  3%      +2.5       12.90 ±  2%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     23.09            +2.8       25.89        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     24.12            +3.0       27.11        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     19.71 ±  5%     -11.6        8.12 ±  3%  perf-profile.children.cycles-pp.__switch_to_asm
      4.83 ±  6%      -4.8        0.06        perf-profile.children.cycles-pp.switch_mm_irqs_off
     16.33            -1.6       14.71        perf-profile.children.cycles-pp.__schedule
     16.61            -1.6       15.04        perf-profile.children.cycles-pp.schedule
      0.43 ±  6%      -0.3        0.12 ± 22%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.54 ±  3%      -0.2        0.35 ±  7%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.18 ±  7%      -0.1        0.03 ± 82%  perf-profile.children.cycles-pp.enqueue_entity
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.init_wait_entry
      0.06 ±  7%      +0.0        0.08        perf-profile.children.cycles-pp.security_file_permission
      0.05 ±  8%      +0.0        0.07        perf-profile.children.cycles-pp.__x64_sys_read
      0.08 ±  5%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__x64_sys_write
      0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.kill_fasync
      0.11 ±  6%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.dequeue_task
      0.04 ± 44%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.psi_account_irqtime
      0.05 ±  8%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.timestamp_truncate
      0.10 ±  3%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.resched_curr
      0.08 ±  5%      +0.0        0.11        perf-profile.children.cycles-pp.mem_cgroup_handle_over_high
      0.16 ±  4%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__calc_delta
      0.09            +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.blkcg_maybe_throttle_current
      0.05 ±  7%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.raw_spin_rq_unlock
      0.37 ±  3%      +0.0        0.40 ±  2%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.15 ±  2%      +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.14 ±  6%      +0.0        0.18 ±  6%  perf-profile.children.cycles-pp.dl_scaled_delta_exec
      0.11 ±  3%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.pick_next_task
      0.12 ±  9%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.01 ±223%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.rcu_note_context_switch
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.write@plt
      0.16 ±  2%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.finish_wait
      0.24 ±  3%      +0.1        0.29 ±  2%  perf-profile.children.cycles-pp.testcase
      0.36 ±  2%      +0.1        0.42 ±  2%  perf-profile.children.cycles-pp.avg_vruntime
      0.26 ±  3%      +0.1        0.32 ±  3%  perf-profile.children.cycles-pp.x64_sys_call
      0.33 ±  2%      +0.1        0.39        perf-profile.children.cycles-pp.__dequeue_entity
      0.27            +0.1        0.33        perf-profile.children.cycles-pp.__put_user_8
      0.15 ±  3%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.25            +0.1        0.31 ±  2%  perf-profile.children.cycles-pp.update_curr_se
      0.22 ±  3%      +0.1        0.29 ±  5%  perf-profile.children.cycles-pp.inode_needs_update_time
      0.31            +0.1        0.39 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.31 ±  5%      +0.1        0.39 ±  6%  perf-profile.children.cycles-pp.update_curr_dl_se
      0.35 ±  2%      +0.1        0.42        perf-profile.children.cycles-pp.rep_movs_alternative
      1.45            +0.1        1.53        perf-profile.children.cycles-pp.enqueue_task
      0.16 ±  2%      +0.1        0.24 ±  2%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.27 ±  3%      +0.1        0.36 ±  4%  perf-profile.children.cycles-pp.file_update_time
      0.32            +0.1        0.41        perf-profile.children.cycles-pp.update_min_vruntime
      0.36 ±  2%      +0.1        0.45        perf-profile.children.cycles-pp.anon_pipe_buf_release
      0.33 ±  4%      +0.1        0.41        perf-profile.children.cycles-pp.rw_verify_area
      0.29 ±  3%      +0.1        0.38 ±  3%  perf-profile.children.cycles-pp.native_sched_clock
      0.36 ±  3%      +0.1        0.45 ±  2%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.32 ±  3%      +0.1        0.41 ±  2%  perf-profile.children.cycles-pp.sched_clock
      0.23 ±  4%      +0.1        0.33        perf-profile.children.cycles-pp.rcu_all_qs
      0.35 ±  3%      +0.1        0.45 ±  3%  perf-profile.children.cycles-pp.update_entity_lag
      0.37 ±  2%      +0.1        0.48 ±  2%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.50 ±  2%      +0.1        0.61        perf-profile.children.cycles-pp.mutex_unlock
      0.44 ±  2%      +0.1        0.56        perf-profile.children.cycles-pp.___perf_sw_event
      0.45 ±  2%      +0.1        0.57        perf-profile.children.cycles-pp.__get_user_8
      0.50            +0.1        0.62        perf-profile.children.cycles-pp.rseq_update_cpu_node_id
      0.26 ±  4%      +0.1        0.39        perf-profile.children.cycles-pp.current_time
      0.46 ±  3%      +0.1        0.59 ±  4%  perf-profile.children.cycles-pp.update_rq_clock
      0.64 ±  2%      +0.1        0.78        perf-profile.children.cycles-pp._copy_to_iter
      0.80 ±  3%      +0.1        0.93        perf-profile.children.cycles-pp.__update_load_avg_se
      0.55 ±  2%      +0.1        0.69        perf-profile.children.cycles-pp.rseq_get_rseq_cs
      0.42 ±  2%      +0.1        0.57 ±  2%  perf-profile.children.cycles-pp.vruntime_eligible
      0.67            +0.2        0.82        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.45 ±  2%      +0.2        0.60        perf-profile.children.cycles-pp.fput
      0.46 ±  2%      +0.2        0.62        perf-profile.children.cycles-pp.__enqueue_entity
      0.74 ±  2%      +0.2        0.91        perf-profile.children.cycles-pp.copy_page_to_iter
      0.73 ±  2%      +0.2        0.90        perf-profile.children.cycles-pp._copy_from_iter
      0.78 ±  2%      +0.2        0.96        perf-profile.children.cycles-pp.os_xsave
      0.40 ±  2%      +0.2        0.58        perf-profile.children.cycles-pp.__cond_resched
      0.68            +0.2        0.86        perf-profile.children.cycles-pp.prepare_to_wait_event
      0.36 ±  3%      +0.2        0.56 ±  2%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.91            +0.2        1.14        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.98 ±  2%      +0.2        1.22        perf-profile.children.cycles-pp.copy_page_from_iter
      0.77 ±  2%      +0.2        1.02 ±  2%  perf-profile.children.cycles-pp.requeue_delayed_entity
      1.04 ±  2%      +0.3        1.29        perf-profile.children.cycles-pp.rseq_ip_fixup
      1.02 ±  3%      +0.3        1.28        perf-profile.children.cycles-pp.prepare_task_switch
      1.60            +0.3        1.88        perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      1.93            +0.3        2.20 ±  2%  perf-profile.children.cycles-pp.dequeue_entities
      0.68 ±  3%      +0.3        0.96        perf-profile.children.cycles-pp.atime_needs_update
      1.28 ±  2%      +0.3        1.56        perf-profile.children.cycles-pp.set_next_entity
      1.60            +0.3        1.91        perf-profile.children.cycles-pp.fdget_pos
      0.84 ±  2%      +0.3        1.15        perf-profile.children.cycles-pp.touch_atime
      2.16            +0.3        2.48 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
      1.64 ±  2%      +0.3        1.98 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
      1.07 ±  2%      +0.3        1.42        perf-profile.children.cycles-pp.pick_eevdf
      0.82 ±  2%      +0.4        1.18        perf-profile.children.cycles-pp.__switch_to
      0.88            +0.4        1.23        perf-profile.children.cycles-pp.mutex_lock
      1.98            +0.4        2.35        perf-profile.children.cycles-pp.switch_fpu_return
      1.64 ±  2%      +0.4        2.05        perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      1.65 ±  2%      +0.4        2.08        perf-profile.children.cycles-pp.put_prev_entity
      1.42 ±  2%      +0.4        1.86 ±  2%  perf-profile.children.cycles-pp.check_preempt_wakeup_fair
      2.46            +0.5        2.91        perf-profile.children.cycles-pp.update_load_avg
      1.64 ±  2%      +0.5        2.13        perf-profile.children.cycles-pp.wakeup_preempt
      1.64 ±  2%      +0.5        2.14        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      1.90 ±  2%      +0.6        2.46        perf-profile.children.cycles-pp.pick_task_fair
      2.68 ±  2%      +0.6        3.31        perf-profile.children.cycles-pp.update_curr
     15.07            +0.9       15.92        perf-profile.children.cycles-pp.pipe_read
      4.50 ±  6%      +0.9        5.38 ±  6%  perf-profile.children.cycles-pp.try_to_wake_up
      4.71 ±  6%      +1.0        5.67 ±  5%  perf-profile.children.cycles-pp.autoremove_wake_function
      4.88 ±  6%      +1.0        5.90 ±  5%  perf-profile.children.cycles-pp.__wake_up_common
     15.83            +1.1       16.89        perf-profile.children.cycles-pp.vfs_read
      5.29 ±  5%      +1.1        6.39 ±  5%  perf-profile.children.cycles-pp.__wake_up_sync_key
      4.97            +1.3        6.31        perf-profile.children.cycles-pp.entry_SYSCALL_64
      5.38 ±  2%      +1.4        6.77        perf-profile.children.cycles-pp.pick_next_task_fair
     17.15            +1.4       18.57        perf-profile.children.cycles-pp.ksys_read
      5.53 ±  2%      +1.4        6.97        perf-profile.children.cycles-pp.__pick_next_task
     10.36 ±  3%      +1.8       12.16        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      8.53 ±  4%      +2.0       10.58 ±  2%  perf-profile.children.cycles-pp.pipe_write
     12.35            +2.0       14.40        perf-profile.children.cycles-pp.syscall_return_via_sysret
      9.22 ±  3%      +2.2       11.40 ±  2%  perf-profile.children.cycles-pp.vfs_write
     10.50 ±  3%      +2.5       12.98 ±  2%  perf-profile.children.cycles-pp.ksys_write
     40.54            +4.6       45.15        perf-profile.children.cycles-pp.do_syscall_64
     47.48            +5.8       53.33        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     19.70 ±  5%     -11.6        8.10 ±  3%  perf-profile.self.cycles-pp.__switch_to_asm
      4.83 ±  6%      -4.8        0.05 ±  9%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.__set_next_task_fair
      0.07 ±  5%      +0.0        0.08        perf-profile.self.cycles-pp.kill_fasync
      0.06            +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.security_file_permission
      0.10 ±  4%      +0.0        0.12        perf-profile.self.cycles-pp.dequeue_task
      0.09 ±  4%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__wake_up_sync_key
      0.16 ±  3%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.__calc_delta
      0.16 ±  2%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.dequeue_entities
      0.05 ±  8%      +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.timestamp_truncate
      0.08 ±  5%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.mem_cgroup_handle_over_high
      0.24 ±  3%      +0.0        0.26 ±  2%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.resched_curr
      0.09 ±  8%      +0.0        0.11 ± 13%  perf-profile.self.cycles-pp.update_rq_clock
      0.07 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.blkcg_maybe_throttle_current
      0.10 ±  3%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.rseq_get_rseq_cs
      0.04 ± 45%      +0.0        0.07        perf-profile.self.cycles-pp.requeue_delayed_entity
      0.03 ± 70%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.file_update_time
      0.10 ±  4%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.13 ±  4%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.enqueue_task
      0.34 ±  3%      +0.0        0.37 ±  2%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.21 ±  2%      +0.0        0.24        perf-profile.self.cycles-pp.dequeue_entity
      0.15 ±  2%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.11 ±  6%      +0.0        0.14 ±  2%  perf-profile.self.cycles-pp.__rseq_handle_notify_resume
      0.13 ±  7%      +0.0        0.17 ±  4%  perf-profile.self.cycles-pp.dl_scaled_delta_exec
      0.02 ± 99%      +0.0        0.06        perf-profile.self.cycles-pp.psi_account_irqtime
      0.12 ±  4%      +0.0        0.15        perf-profile.self.cycles-pp.wakeup_preempt
      0.18 ±  5%      +0.0        0.21 ±  8%  perf-profile.self.cycles-pp.update_curr_dl_se
      0.10            +0.0        0.14 ±  2%  perf-profile.self.cycles-pp.pick_next_task
      0.14 ±  5%      +0.0        0.18 ±  3%  perf-profile.self.cycles-pp.touch_atime
      0.13 ±  3%      +0.0        0.17 ±  7%  perf-profile.self.cycles-pp.inode_needs_update_time
      0.22 ±  4%      +0.0        0.26 ±  2%  perf-profile.self.cycles-pp.testcase
      0.11 ±  9%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.16 ±  3%      +0.0        0.21 ±  2%  perf-profile.self.cycles-pp.__pick_next_task
      0.01 ±223%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.28 ±  2%      +0.0        0.33        perf-profile.self.cycles-pp.__dequeue_entity
      0.24 ±  2%      +0.0        0.29 ±  2%  perf-profile.self.cycles-pp.x64_sys_call
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.update_entity_lag
      0.20 ±  2%      +0.1        0.26        perf-profile.self.cycles-pp.put_prev_entity
      0.20 ±  3%      +0.1        0.25        perf-profile.self.cycles-pp.finish_task_switch
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.finish_wait
      0.22 ±  3%      +0.1        0.28 ±  2%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.28 ±  3%      +0.1        0.33 ±  2%  perf-profile.self.cycles-pp.rep_movs_alternative
      0.22 ±  3%      +0.1        0.28        perf-profile.self.cycles-pp.rseq_ip_fixup
      0.23 ±  2%      +0.1        0.28 ±  2%  perf-profile.self.cycles-pp.update_curr_se
      0.36 ±  2%      +0.1        0.41 ±  3%  perf-profile.self.cycles-pp.avg_vruntime
      0.24 ±  2%      +0.1        0.30        perf-profile.self.cycles-pp.set_next_entity
      0.13 ±  2%      +0.1        0.19        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.25 ±  2%      +0.1        0.31 ±  2%  perf-profile.self.cycles-pp.copy_page_from_iter
      0.26 ±  2%      +0.1        0.32        perf-profile.self.cycles-pp.__put_user_8
      0.19 ±  3%      +0.1        0.25        perf-profile.self.cycles-pp.autoremove_wake_function
      0.26 ±  2%      +0.1        0.33        perf-profile.self.cycles-pp.schedule
      0.17 ±  4%      +0.1        0.23 ±  2%  perf-profile.self.cycles-pp.__wake_up_common
      0.01 ±223%      +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.raw_spin_rq_unlock
      0.14 ±  3%      +0.1        0.21        perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.18 ±  2%      +0.1        0.25        perf-profile.self.cycles-pp.__cond_resched
      0.30 ±  2%      +0.1        0.37        perf-profile.self.cycles-pp.update_min_vruntime
      0.25 ±  5%      +0.1        0.32        perf-profile.self.cycles-pp.rw_verify_area
      0.53 ±  3%      +0.1        0.61        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.28            +0.1        0.36        perf-profile.self.cycles-pp.ksys_write
      0.30 ±  2%      +0.1        0.38 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.18 ±  4%      +0.1        0.26 ±  2%  perf-profile.self.cycles-pp.current_time
      0.33 ±  8%      +0.1        0.41 ±  6%  perf-profile.self.cycles-pp.try_to_wake_up
      0.28 ±  4%      +0.1        0.37 ±  3%  perf-profile.self.cycles-pp.native_sched_clock
      0.35            +0.1        0.44        perf-profile.self.cycles-pp.anon_pipe_buf_release
      0.32 ±  3%      +0.1        0.41        perf-profile.self.cycles-pp.check_preempt_wakeup_fair
      0.20 ±  5%      +0.1        0.30 ±  2%  perf-profile.self.cycles-pp.rcu_all_qs
      0.47            +0.1        0.57        perf-profile.self.cycles-pp._copy_to_iter
      0.38 ±  2%      +0.1        0.49 ±  2%  perf-profile.self.cycles-pp.___perf_sw_event
      0.47 ±  2%      +0.1        0.57        perf-profile.self.cycles-pp.mutex_unlock
      0.38 ±  2%      +0.1        0.48 ±  3%  perf-profile.self.cycles-pp.switch_fpu_return
      0.37 ±  2%      +0.1        0.47        perf-profile.self.cycles-pp.prepare_to_wait_event
      0.36 ±  3%      +0.1        0.48        perf-profile.self.cycles-pp.fput
      0.44 ±  2%      +0.1        0.55        perf-profile.self.cycles-pp.__get_user_8
      0.59 ±  2%      +0.1        0.71        perf-profile.self.cycles-pp.vfs_write
      0.49 ±  2%      +0.1        0.61        perf-profile.self.cycles-pp.rseq_update_cpu_node_id
      0.59 ±  3%      +0.1        0.72        perf-profile.self.cycles-pp.pick_next_task_fair
      0.77 ±  2%      +0.1        0.90        perf-profile.self.cycles-pp.__update_load_avg_se
      0.39 ±  2%      +0.1        0.52        perf-profile.self.cycles-pp.vruntime_eligible
      0.50 ±  3%      +0.1        0.63        perf-profile.self.cycles-pp.vfs_read
      0.38 ±  2%      +0.1        0.52 ±  2%  perf-profile.self.cycles-pp.atime_needs_update
      0.50 ±  4%      +0.1        0.64        perf-profile.self.cycles-pp.pick_task_fair
      0.62            +0.1        0.76        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.56 ±  3%      +0.1        0.71        perf-profile.self.cycles-pp.prepare_task_switch
      0.62 ±  2%      +0.1        0.76        perf-profile.self.cycles-pp._copy_from_iter
      0.45 ±  2%      +0.1        0.60        perf-profile.self.cycles-pp.__enqueue_entity
      0.36 ±  2%      +0.2        0.52        perf-profile.self.cycles-pp.ksys_read
      0.98 ±  2%      +0.2        1.15        perf-profile.self.cycles-pp.update_load_avg
      0.78 ±  2%      +0.2        0.95        perf-profile.self.cycles-pp.os_xsave
      0.36 ±  3%      +0.2        0.56 ±  2%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.53 ±  2%      +0.2        0.74        perf-profile.self.cycles-pp.mutex_lock
      0.67 ±  2%      +0.2        0.89 ±  2%  perf-profile.self.cycles-pp.pick_eevdf
      0.72 ±  2%      +0.2        0.94        perf-profile.self.cycles-pp.__switch_to
      0.88 ±  2%      +0.2        1.11        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.11 ±  2%      +0.3        1.37        perf-profile.self.cycles-pp.update_curr
      1.60            +0.3        1.87        perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      1.30            +0.3        1.58        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.08            +0.3        1.39        perf-profile.self.cycles-pp.pipe_read
      1.59            +0.3        1.90        perf-profile.self.cycles-pp.fdget_pos
      1.32 ±  2%      +0.4        1.74 ±  2%  perf-profile.self.cycles-pp.pipe_write
      0.92 ±  2%      +0.4        1.34 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      1.16 ±  4%      +0.7        1.82 ±  3%  perf-profile.self.cycles-pp.__schedule
      4.43            +1.2        5.64        perf-profile.self.cycles-pp.entry_SYSCALL_64
      7.03            +1.3        8.28        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
     10.28 ±  3%      +1.8       12.05        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
     12.22            +2.0       14.25        perf-profile.self.cycles-pp.syscall_return_via_sysret




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



Return-Path: <linux-kernel+bounces-207252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58811901481
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 07:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B266B210EB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 05:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90166FC19;
	Sun,  9 Jun 2024 05:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TXRugNb+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAD6E56A
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 05:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717910410; cv=fail; b=nJFM4zBhl29FPHVx4rIUve3fbvlN4SQCOWboF/JS4hv3U1jVdd7y9Ps6zhggpRCieiZqD76iUzw1O2jEcGBBevUldKw1NWL/9fPa1ukF6CWFDg+y3+8CDih0UeQ4fBCDQ3jKI6wLjgEs/FDXe3cex5MC+2jGnSJDentwKbj4QsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717910410; c=relaxed/simple;
	bh=XCn3Zjp3344SCByJIXcK5f4snJqsJUrWljnnWI6tjXQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CGntJrqODEH62afVx5LQ0uz56QT6a6HcmEWaCqK4aK5SPDURKHr00WpRS9/M8uBQZRucWBfeDb2u44Y6VRMtjCtj0I2IG7EBEbIgX0cBQMEJ4oB7GJb6vqQaK8pFmCYgUFSltxdFq/n0AemJ8tgVQby8a1eqFbenHzpiaUdac68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TXRugNb+; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717910408; x=1749446408;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XCn3Zjp3344SCByJIXcK5f4snJqsJUrWljnnWI6tjXQ=;
  b=TXRugNb+VQho7Xzovy6IuuqZDW9Bt0pSnIKm9mortZKO3q2KcGAhnN1D
   rZaQhf2mQeJyDQ+x4Pe5uLMK8iBdTw7NEoC4l7UzqiJrBk/26LKymZFTr
   Jlgb1TVZydHu5SnvLwrrfLpleztxNO0C6TlKDkaFIhNA9EILgbuH8fTtj
   e4nGSvC15puhI72fuWKoSGE0sCRINVzJ+bpP2qi+jJjzzr6icrmmC8Z/A
   PE+djYgvvIB2mbTmEZk1h+XxiVQg+7emakzj/sHepABUW7nzsnDlvFrgv
   UB8rJh+lRFb7onU717daGvh4NldXuN0BSUiPminhjJMJdya/x+ZojekkF
   g==;
X-CSE-ConnectionGUID: 9QK7C9F2TpOxtOPX9Ky5fw==
X-CSE-MsgGUID: hfT9Z2mMTMCjALQQEc+/Yw==
X-IronPort-AV: E=McAfee;i="6600,9927,11097"; a="25168014"
X-IronPort-AV: E=Sophos;i="6.08,224,1712646000"; 
   d="scan'208";a="25168014"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2024 22:20:08 -0700
X-CSE-ConnectionGUID: 3+4QDELFSS25aOa0x+dq+A==
X-CSE-MsgGUID: bgWQC4RgRj2+0LnjUnaLUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,224,1712646000"; 
   d="scan'208";a="38665912"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jun 2024 22:20:06 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 8 Jun 2024 22:20:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 8 Jun 2024 22:20:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 8 Jun 2024 22:20:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 8 Jun 2024 22:20:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WddZ5oAv1VBv3X1SnHBUco7q5FhbCXUrLKOncJLTWZ86a2CADwgAlwjuXpeUl3USkVvr6juQJiG3J1WpTgvB06S9ZAaop39iQuxfRYoK39sWItsH47LpH8EN8X/TlKihUIh5Nqfc2lWyqTznDJqk2uXuIZ8ILnJ5jOo0fmalR3+kXkikfslealRlAkfvWhgSuSkhTeWZpdbtQilOSdJsQQ4h477vdwhGWYEqNrMwZ+6oLQPVZsB7XZ/gaN9cleil0XqKqEmFIHC7CE0EVrszDET14XdoAgDpiZLy7YPEyKTid/+zeLbtJZ0e0sFu2tJe/pmDC3C7tE15nw44IoLChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQ8Tz75Rd1ApSvk+OQLbBHqsxwUkGDSchHwQkjEtsHA=;
 b=R9A8o/y94JOEvUoMowRAVGnfJ915iiglucRAtfr2OyLLWJvXJrUGT1XhSRESWiR7UXnP2JgAwJEHTVpi00TOsvahkoeBP7Sty4SabkCm6KCs6ZadW71UETZHkQP1R2m7aaw6vus7pF50MZj/wyXlqomvg3JL6UDF+JS+9W4Gv9vntvg25gAWXZkm8RhyFer0Q9t3iDeszq6VlsGYZUzws1uWK9Mlsi6aPtcvxmYOkBj/pLQUr7XCbklcFcVsAGXyby06uSlJPPGWwPNxjEt4eEvVkdF58jOkF24YdLim7AUmiCkPtfviuNi0b4H67YdioinZXYff9Ix3SmMgZmfvGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
 by DM4PR11MB6360.namprd11.prod.outlook.com (2603:10b6:8:bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Sun, 9 Jun
 2024 05:20:03 +0000
Received: from SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::c2dd:7cf8:6008:b690]) by SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::c2dd:7cf8:6008:b690%5]) with mapi id 15.20.7633.036; Sun, 9 Jun 2024
 05:20:02 +0000
Date: Sun, 9 Jun 2024 13:19:53 +0800
From: Philip Li <philip.li@intel.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
CC: kernel test robot <lkp@intel.com>, "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:85.11-94.6: Warning
 (graph_child_address): /soc/video@10830000/ports/port@1: graph node has
 single child node 'endpoint@0', #address-cells/#size-cells are not necessary
Message-ID: <ZmU7ebk5vWv+fBT2@rli9-mobl>
References: <202406081329.snoMrZsJ-lkp@intel.com>
 <TY3PR01MB113468C94F2ED383F5EB883A986C42@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB113468C94F2ED383F5EB883A986C42@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3230:EE_|DM4PR11MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f511ee-58a6-45c5-6ee8-08dc8843d0a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|220923002;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E3g5cv10HZ+C6/rPMTocQOGY9XpnKp6qG36UgmGLCoHCGk6YFxJNGBfCtTKW?=
 =?us-ascii?Q?0gVzKvzm60EbivEdnBadRbPusUkH3wFsqZVFXzJg5ftAz8oHV0HZzjLozOzJ?=
 =?us-ascii?Q?si03CJijKrLW7Ot9zBaJ9my1VIELA1mh/LXI94sgRMymdJQ1o9ldSrK2S6dP?=
 =?us-ascii?Q?6G64DJA5WEtUHUnQt6Uw3Q8REGFVLb91y/KCP9BiKrKocszRkIZL52eR/HUI?=
 =?us-ascii?Q?NRWWdDPcY+8SviFr7XK9lFe91Q/z5xY+b21aZgXd1uMjQhmQTX6ORQBnZ9Io?=
 =?us-ascii?Q?gynDXbmiFBIxrXDycjCS4jrq+2tkHI5WG+RBWMjjrL31bLG2d8cHoLB7FFwL?=
 =?us-ascii?Q?HBHsTj4Ee51MT7Yrf491AjYpbOcQGnYseKuuQceFfBg7dHszuZ3V0+S0OPbY?=
 =?us-ascii?Q?P0oFuyeRxeNAwC+9AUAzQ0EJ29Rnv+QrYqjU1TsqGxyBT4KXJvOJyFtV+V5D?=
 =?us-ascii?Q?r85lwrM4RSHEHyOFtMAgA1DeaOUwzZ828xBLMiN+26so/vgLc+Se7OJsVHpM?=
 =?us-ascii?Q?qWYExQT8w1o7l96/QdHYRGlYCZxmP2LVQJTByxU62oEleZFHXd5RFWNR/aUx?=
 =?us-ascii?Q?Oc4EmkaXAW/02/ONQc+src4bgBs79HMSgPHjf7eaRZNtkvLfOPDdsWgSfHw4?=
 =?us-ascii?Q?gIhQyWDtSMSId073VLFXg/wqPk1eJxSWnkJdhFMT5JPVODXfNECkcw4vRG3I?=
 =?us-ascii?Q?5bhNhn27C8RujnecXy28ywxW8SgIotXkz0MFWKqqo5MakfZbLpIkjh99gRVx?=
 =?us-ascii?Q?/P7uOQJZaC2jEeHl6tOS5Q/Pt7mqPCblRJICtgJNiJQMzFr0m323RTe9aii0?=
 =?us-ascii?Q?Dv0LdP0WYnP/2zWgQygxgw1OplS8xtX7IA5INbQyygtLrEY1tF1PsvFbp0ot?=
 =?us-ascii?Q?yMXtC54/UaqgseGWMrZDxjOUQ6nueYtz66/Qh7kQLJoN1oLBh8MosLVpCnwL?=
 =?us-ascii?Q?7Elsd7ywGQ5cavav68CveN3ahfg+jKrBtJzQu8ITYbnxc1as4ipTokYb52Bo?=
 =?us-ascii?Q?ynh59mLrXnHLSITJi6mfnvWUZcObJ6S2N7Rq1Gf9iGS4UNCMqIS9Tbycy+81?=
 =?us-ascii?Q?/R3yYxRH9Y0GgiG9VPgeUhWjCm0ADXKxw4idWV+jUW2nsOR1ZpAWSpsj3RXr?=
 =?us-ascii?Q?c/zAZ3UPQah0dWWxjZqZlh9fJjSASuOiDFbfpIg51SG5AQI0SflmeucwJjv1?=
 =?us-ascii?Q?wc+nhzDcZ5CkWZrPsWkbpV+9273djUjZ5bET3iYfyKBVQ7YM0LuAdNZS4di/?=
 =?us-ascii?Q?nGo7SIQhPTbQwO1Lpewww3Ho2BR/3habBHdfkfC/MW5PhX4+Ydw91g8gXswS?=
 =?us-ascii?Q?E8MdpB2PhYFt7kegSjd9RWv0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/l5VON+m3DQAUhhIx+Eud6/WLsBuS5wXp46SnIgnU+WIbn6OfF71C57N1FYQ?=
 =?us-ascii?Q?U9hCQtTk+YZ8bsLjGmidZTZuxv6LuK0nLBTVA3kN8ftBFscoA+SINjSm0U/W?=
 =?us-ascii?Q?Eq4BPH/mttPBW0mHuie6Ll7yZbLJ0YYuxoMNg4Vf5r5WYnD2bDvoHJ16J+Qf?=
 =?us-ascii?Q?dNPXIJEM6WetZsauV1Y+kpMoufTzlMnK7V+4BteEUEO2OGozTq9YCKQr23id?=
 =?us-ascii?Q?4utfGJteCh3g3BZimQ2j7KgeM7pzwTJrMuPvfVZ9/pCHLwCSjFK2VCNUU33Y?=
 =?us-ascii?Q?lCR/0I+8gGhxohD/4uhJciP61M7zZ6cnKRadJWAAI1N42WrjyPzE0i7WfKpt?=
 =?us-ascii?Q?ZltANV62r9Mmmtk5TwZ2T8KPMYZtVD6oSzErTzSmiThUR0XxFpQmgX+vDgcL?=
 =?us-ascii?Q?xinwFnO9Ty1t+Z/9qt6RceVMNqjuiqBz9Eakmm91hc2F+Bbl+1TbWqTR7hQM?=
 =?us-ascii?Q?dBDeysJwGW3Z5aSUZ7NYxJmX5ne+rxvfh97k3ufhi1UHlu9SukSFavbNQFIq?=
 =?us-ascii?Q?O5cQHZNjg8hcLHM5NzlKZsiSAL/L802u4M+HcmkpC0YlVIy6JQSMOXpPAMuk?=
 =?us-ascii?Q?46sgM3vxCvw5JcBaeQqQWN0w/76b9UdCrHFncCmoUPJ0ZLhzqPmHuuvVVPF8?=
 =?us-ascii?Q?aiGQPYcWNR7eDiXqiANZOdLbX+Fjij9AaYOqUkTAOMcGDQn5cNyMIkw+LZbQ?=
 =?us-ascii?Q?zfr0OQXSS/wV5MfSdB6kCREE6SIPRXC3iwY0+qIJHY2VoS2e5LYRsAp8PDob?=
 =?us-ascii?Q?9ZBNoLLSJ6diqk5xx2IifkwZz8LfecsS1r2FqPU5cSe8/JG17SQYXi48OgRs?=
 =?us-ascii?Q?2vWex4CH2yDnFhvKm0KjhO1D51hrUfyJNUnA7elcy+765lrZInXw6zc953XK?=
 =?us-ascii?Q?zrdpazidkwkOIQPY410JmsryweUp1zx81JK6amJ5HEQuWGmNw6iYUQDqbMx9?=
 =?us-ascii?Q?LH4tQAzjLsxrk5NnpdQVGUINnIxY8QfJbvSW3Ia9kdEXdtjWXxBLTW5spTPq?=
 =?us-ascii?Q?+TtrRnvk5+BXWvbSxcNisYiXknix7yGlTzoeFskYRUi1Q8Gjc4+K2VjNVqvc?=
 =?us-ascii?Q?GzUspTpADXGUSss+CPNvIF5s1T+8YgdOgGrV/x47DciD0+8Q4VLETeDhWd7m?=
 =?us-ascii?Q?JAf5qRcHJMbSfERWs0XhvVU9mD7nl6Hncvv+TTu4Aqkw8zvkRLWnByQklnWU?=
 =?us-ascii?Q?YWddmhAowTqKslFHoWOoW2yXME4UQpmmLcrxVC1VX+dMzWacSypbj/sY5QJ/?=
 =?us-ascii?Q?gHOP+K8AHKM82SrQz+sfeoFwlNePcrw5HmQbekeOvWDyj9KtZw+eezFEAAIW?=
 =?us-ascii?Q?UohG5yPhsMtSOuQupzfzmfRWqtHimhSOW0o7VWqeJfvjOtz5Q1MhCmc8CPcX?=
 =?us-ascii?Q?oufu9DARmRgxRgAObWXGqTv3oKqXGNoJvlhbg5LXMg4e1kE+Jnf9MfXM3NCX?=
 =?us-ascii?Q?KBqKxmTvTMdv/xntFvFn6JJKkDWrozrsavVJwXd9cQVIY9tj5T+M8VijPAgX?=
 =?us-ascii?Q?gVOsjdiVvTd8yo4pd3aIf6J3GwQGWTwji26n5jt82xgChF3B4IRawfcCgkm6?=
 =?us-ascii?Q?mjRBCtAk+/hQ5tEiI/KUBtVNhljyBhuuJwY5jPNZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f511ee-58a6-45c5-6ee8-08dc8843d0a8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2024 05:20:02.7596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fu3iXAcyzm/dPPpFvp+HdZQcyCEqe6T7blILT+Rn+EAdC352TmXIdhT/ZUSMbIeFloxHxwBi5EA3Xw/yfkjKUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6360
X-OriginatorOrg: intel.com

On Sat, Jun 08, 2024 at 08:42:56AM +0000, Biju Das wrote:
> Hi All,
> 
> > -----Original Message-----
> > From: kernel test robot <lkp@intel.com>
> > Sent: Saturday, June 8, 2024 6:37 AM
> > To: Biju Das <biju.das.jz@bp.renesas.com>
> > Cc: oe-kbuild-all@lists.linux.dev; linux-kernel@vger.kernel.org; Geert Uytterhoeven
> > <geert+renesas@glider.be>
> > Subject: arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:85.11-94.6: Warning (graph_child_address):
> > /soc/video@10830000/ports/port@1: graph node has single child node 'endpoint@0', #address-
> > cells/#size-cells are not necessary
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   dc772f8237f9b0c9ea3f34d0dc4a57d1f6a5070d
> > commit: 971c17f879352adc719ff215e0769f8e0a49d7c4 arm64: dts: renesas: r9a07g043u: Add CSI and CRU
> > nodes
> > date:   4 months ago
> > compiler: aarch64-linux-gcc (GCC) 13.2.0 reproduce (this is a W=1 build):
> > (https://download.01.org/0day-ci/archive/20240608/202406081329.snoMrZsJ-lkp@intel.com/reproduce)
> 
> As per this,
> dasb@ree-du1sdd5:~/lkp-tests$ mkdir build_dir && cp config build_dir/.config
> cp: cannot stat 'config': No such file or directory

sorry, looks this is confusing to "cp config build_dir/.config" as there's no .config
for this case. We will fix the reproduce step.

> 
> So I have generated .config and copied as config
> 
> Than I got the the below issue,
> COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-13.2.0 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
> -bash: /data/dasb/lkp-tests/kbuild/make.cross: No such file or directory

Is it possible the lkp-tests is not up to date? the make.cross code was uploaded
recently.

> 
> Can you please provide the details how to get this tool chain?
> 
> So that I can reproduce and fix the issue in same environment.

You can try below steps (without the cp .config)

$ mkdir build_dir
$ COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-13.2.0 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
$ COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-13.2.0 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

Or you can ignore the full make, just do below after make olddefconfig

$ COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-13.2.0 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash dtbs_check

e.g.

$ COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-13.2.0 ~/upstream/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash dtbs_check 2>&1 | grep 'arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:85.11-94.6'
../arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:85.11-94.6: Warning (graph_child_address): /soc/video@10830000/ports/port@1: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary

Thanks

> 
> Cheers,
> Biju
> 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of the same
> > patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes:
> > | https://lore.kernel.org/oe-kbuild-all/202406081329.snoMrZsJ-lkp@intel.
> > | com/
> > 
> > dtcheck warnings: (new ones prefixed by >>)
> > >> arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:85.11-94.6: Warning
> > >> (graph_child_address): /soc/video@10830000/ports/port@1: graph node
> > >> has single child node 'endpoint@0', #address-cells/#size-cells are
> > >> not necessary
> > >> arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:120.11-129.6: Warning
> > >> (graph_child_address): /soc/csi2@10830400/ports/port@1: graph node
> > >> has single child node 'endpoint@0', #address-cells/#size-cells are
> > >> not necessary
> > 
> > vim +85 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
> > 
> >     60
> >     61	&soc {
> >     62		interrupt-parent = <&gic>;
> >     63
> >     64		cru: video@10830000 {
> >     65			compatible = "renesas,r9a07g043-cru", "renesas,rzg2l-cru";
> >     66			reg = <0 0x10830000 0 0x400>;
> >     67			clocks = <&cpg CPG_MOD R9A07G043_CRU_VCLK>,
> >     68				 <&cpg CPG_MOD R9A07G043_CRU_PCLK>,
> >     69				 <&cpg CPG_MOD R9A07G043_CRU_ACLK>;
> >     70			clock-names = "video", "apb", "axi";
> >     71			interrupts = <SOC_PERIPHERAL_IRQ(167) IRQ_TYPE_LEVEL_HIGH>,
> >     72				     <SOC_PERIPHERAL_IRQ(168) IRQ_TYPE_LEVEL_HIGH>,
> >     73				     <SOC_PERIPHERAL_IRQ(169) IRQ_TYPE_LEVEL_HIGH>;
> >     74			interrupt-names = "image_conv", "image_conv_err", "axi_mst_err";
> >     75			resets = <&cpg R9A07G043_CRU_PRESETN>,
> >     76				 <&cpg R9A07G043_CRU_ARESETN>;
> >     77			reset-names = "presetn", "aresetn";
> >     78			power-domains = <&cpg>;
> >     79			status = "disabled";
> >     80
> >     81			ports {
> >     82				#address-cells = <1>;
> >     83				#size-cells = <0>;
> >     84
> >   > 85				port@1 {
> >     86					#address-cells = <1>;
> >     87					#size-cells = <0>;
> >     88
> >     89					reg = <1>;
> >     90					crucsi2: endpoint@0 {
> >     91						reg = <0>;
> >     92						remote-endpoint = <&csi2cru>;
> >     93					};
> >     94				};
> >     95			};
> >     96		};
> >     97
> >     98		csi2: csi2@10830400 {
> >     99			compatible = "renesas,r9a07g043-csi2", "renesas,rzg2l-csi2";
> >    100			reg = <0 0x10830400 0 0xfc00>;
> >    101			interrupts = <SOC_PERIPHERAL_IRQ(166) IRQ_TYPE_LEVEL_HIGH>;
> >    102			clocks = <&cpg CPG_MOD R9A07G043_CRU_SYSCLK>,
> >    103				 <&cpg CPG_MOD R9A07G043_CRU_VCLK>,
> >    104				 <&cpg CPG_MOD R9A07G043_CRU_PCLK>;
> >    105			clock-names = "system", "video", "apb";
> >    106			resets = <&cpg R9A07G043_CRU_PRESETN>,
> >    107				 <&cpg R9A07G043_CRU_CMN_RSTB>;
> >    108			reset-names = "presetn", "cmn-rstb";
> >    109			power-domains = <&cpg>;
> >    110			status = "disabled";
> >    111
> >    112			ports {
> >    113				#address-cells = <1>;
> >    114				#size-cells = <0>;
> >    115
> >    116				port@0 {
> >    117					reg = <0>;
> >    118				};
> >    119
> >  > 120				port@1 {
> >    121					#address-cells = <1>;
> >    122					#size-cells = <0>;
> >    123					reg = <1>;
> >    124
> >    125					csi2cru: endpoint@0 {
> >    126						reg = <0>;
> >    127						remote-endpoint = <&crucsi2>;
> >    128					};
> >    129				};
> >    130			};
> >    131		};
> >    132
> >    133		irqc: interrupt-controller@110a0000 {
> >    134			compatible = "renesas,r9a07g043u-irqc",
> >    135				     "renesas,rzg2l-irqc";
> >    136			reg = <0 0x110a0000 0 0x10000>;
> >    137			#interrupt-cells = <2>;
> >    138			#address-cells = <0>;
> >    139			interrupt-controller;
> >    140			interrupts = <SOC_PERIPHERAL_IRQ(0) IRQ_TYPE_LEVEL_HIGH>,
> >    141				     <SOC_PERIPHERAL_IRQ(1) IRQ_TYPE_LEVEL_HIGH>,
> >    142				     <SOC_PERIPHERAL_IRQ(2) IRQ_TYPE_LEVEL_HIGH>,
> >    143				     <SOC_PERIPHERAL_IRQ(3) IRQ_TYPE_LEVEL_HIGH>,
> >    144				     <SOC_PERIPHERAL_IRQ(4) IRQ_TYPE_LEVEL_HIGH>,
> >    145				     <SOC_PERIPHERAL_IRQ(5) IRQ_TYPE_LEVEL_HIGH>,
> >    146				     <SOC_PERIPHERAL_IRQ(6) IRQ_TYPE_LEVEL_HIGH>,
> >    147				     <SOC_PERIPHERAL_IRQ(7) IRQ_TYPE_LEVEL_HIGH>,
> >    148				     <SOC_PERIPHERAL_IRQ(8) IRQ_TYPE_LEVEL_HIGH>,
> >    149				     <SOC_PERIPHERAL_IRQ(444) IRQ_TYPE_LEVEL_HIGH>,
> >    150				     <SOC_PERIPHERAL_IRQ(445) IRQ_TYPE_LEVEL_HIGH>,
> >    151				     <SOC_PERIPHERAL_IRQ(446) IRQ_TYPE_LEVEL_HIGH>,
> >    152				     <SOC_PERIPHERAL_IRQ(447) IRQ_TYPE_LEVEL_HIGH>,
> >    153				     <SOC_PERIPHERAL_IRQ(448) IRQ_TYPE_LEVEL_HIGH>,
> >    154				     <SOC_PERIPHERAL_IRQ(449) IRQ_TYPE_LEVEL_HIGH>,
> >    155				     <SOC_PERIPHERAL_IRQ(450) IRQ_TYPE_LEVEL_HIGH>,
> >    156				     <SOC_PERIPHERAL_IRQ(451) IRQ_TYPE_LEVEL_HIGH>,
> >    157				     <SOC_PERIPHERAL_IRQ(452) IRQ_TYPE_LEVEL_HIGH>,
> >    158				     <SOC_PERIPHERAL_IRQ(453) IRQ_TYPE_LEVEL_HIGH>,
> >    159				     <SOC_PERIPHERAL_IRQ(454) IRQ_TYPE_LEVEL_HIGH>,
> >    160				     <SOC_PERIPHERAL_IRQ(455) IRQ_TYPE_LEVEL_HIGH>,
> >    161				     <SOC_PERIPHERAL_IRQ(456) IRQ_TYPE_LEVEL_HIGH>,
> >    162				     <SOC_PERIPHERAL_IRQ(457) IRQ_TYPE_LEVEL_HIGH>,
> >    163				     <SOC_PERIPHERAL_IRQ(458) IRQ_TYPE_LEVEL_HIGH>,
> >    164				     <SOC_PERIPHERAL_IRQ(459) IRQ_TYPE_LEVEL_HIGH>,
> >    165				     <SOC_PERIPHERAL_IRQ(460) IRQ_TYPE_LEVEL_HIGH>,
> >    166				     <SOC_PERIPHERAL_IRQ(461) IRQ_TYPE_LEVEL_HIGH>,
> >    167				     <SOC_PERIPHERAL_IRQ(462) IRQ_TYPE_LEVEL_HIGH>,
> >    168				     <SOC_PERIPHERAL_IRQ(463) IRQ_TYPE_LEVEL_HIGH>,
> >    169				     <SOC_PERIPHERAL_IRQ(464) IRQ_TYPE_LEVEL_HIGH>,
> >    170				     <SOC_PERIPHERAL_IRQ(465) IRQ_TYPE_LEVEL_HIGH>,
> >    171				     <SOC_PERIPHERAL_IRQ(466) IRQ_TYPE_LEVEL_HIGH>,
> >    172				     <SOC_PERIPHERAL_IRQ(467) IRQ_TYPE_LEVEL_HIGH>,
> >    173				     <SOC_PERIPHERAL_IRQ(468) IRQ_TYPE_LEVEL_HIGH>,
> >    174				     <SOC_PERIPHERAL_IRQ(469) IRQ_TYPE_LEVEL_HIGH>,
> >    175				     <SOC_PERIPHERAL_IRQ(470) IRQ_TYPE_LEVEL_HIGH>,
> >    176				     <SOC_PERIPHERAL_IRQ(471) IRQ_TYPE_LEVEL_HIGH>,
> >    177				     <SOC_PERIPHERAL_IRQ(472) IRQ_TYPE_LEVEL_HIGH>,
> >    178				     <SOC_PERIPHERAL_IRQ(473) IRQ_TYPE_LEVEL_HIGH>,
> >    179				     <SOC_PERIPHERAL_IRQ(474) IRQ_TYPE_LEVEL_HIGH>,
> >    180				     <SOC_PERIPHERAL_IRQ(475) IRQ_TYPE_LEVEL_HIGH>,
> >    181				     <SOC_PERIPHERAL_IRQ(25) IRQ_TYPE_EDGE_RISING>;
> >    182			interrupt-names = "nmi",
> >    183					  "irq0", "irq1", "irq2", "irq3",
> >    184					  "irq4", "irq5", "irq6", "irq7",
> >    185					  "tint0", "tint1", "tint2", "tint3",
> >    186					  "tint4", "tint5", "tint6", "tint7",
> >    187					  "tint8", "tint9", "tint10", "tint11",
> >    188					  "tint12", "tint13", "tint14", "tint15",
> >    189					  "tint16", "tint17", "tint18", "tint19",
> >    190					  "tint20", "tint21", "tint22", "tint23",
> >    191					  "tint24", "tint25", "tint26", "tint27",
> >    192					  "tint28", "tint29", "tint30", "tint31",
> >    193					  "bus-err";
> >    194			clocks = <&cpg CPG_MOD R9A07G043_IA55_CLK>,
> >    195				<&cpg CPG_MOD R9A07G043_IA55_PCLK>;
> >    196			clock-names = "clk", "pclk";
> >    197			power-domains = <&cpg>;
> >    198			resets = <&cpg R9A07G043_IA55_RESETN>;
> >    199		};
> >    200
> >    201		gic: interrupt-controller@11900000 {
> >    202			compatible = "arm,gic-v3";
> >    203			#interrupt-cells = <3>;
> >    204			#address-cells = <0>;
> >    205			interrupt-controller;
> >    206			reg = <0x0 0x11900000 0 0x40000>,
> >    207			      <0x0 0x11940000 0 0x60000>;
> >    208			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
> >    209		};
> >    210	};
> >    211
> > 
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 


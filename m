Return-Path: <linux-kernel+bounces-260570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB2993AB05
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D471C20C06
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C00818B1A;
	Wed, 24 Jul 2024 02:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k/WwQkLH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB00914295
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787354; cv=fail; b=f7Rx5Df8/KQsp/N49TCa0z5nrjE5z5zqNJu0ywjWmf227BiwgNgUE3zVTG2gMbbZvVmFL8Syyw8WI3NWTcIHxZe8zjrUJcRWNq9kanc+Th0sR8AEspr70Yk3soehrJnibBzE9yE0Xlj1qKDAzU5hZKwcPb49LgObiSBHkDzn33Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787354; c=relaxed/simple;
	bh=pmsAXy+ecJMrSFQ2KoRPx7wiskiZ5y+j762Ixugc0U8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K4ygw6zx4rF4hp0AapJveQ9VT/2jusmNTAWNhLAAR4xnJu1Mxc33/5CaoYgHMcjvq4oG8Jk45ZIveo+k1RpiUlhOPyjCSTkRZAY8LTuSMHGZquV81J01VEvJydLzWuTHfR3EWd22vnOJpXxjflCmaRqpgnHxSqamo3ThZoXumX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k/WwQkLH; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721787353; x=1753323353;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pmsAXy+ecJMrSFQ2KoRPx7wiskiZ5y+j762Ixugc0U8=;
  b=k/WwQkLHgkNKVIumkXlQSR4zb8GN8nqZZSwvj9YkWl3O9HDP/XqlSxci
   1+NcJkCZhSNb8F4dZVVlvbsKx43ezFMDwqB83M1XBsTSDGO3qhVdBjI1R
   dCRFa3z2h0p2tg81SV/dWnUIjak2lwK0HJytdjJ0yM59vZR/z21rQaEcU
   08dUReUS+2OTi9QenSlC8c2bfiYE0bN1xc7jvzr9OOaklMm2nMP5jMIZv
   Oq9UV8MSvtKRw3HloViYeDVWGJxShh4YABsm9dJp7nDD/IrHGuEvVDE+9
   85sGoCrbyLI17yQSzx2Efk4urCBXKijZfssqaztj2D45YJIkkIAZfzX9s
   g==;
X-CSE-ConnectionGUID: MBlyO/C6TgKiBIAvdHO5nw==
X-CSE-MsgGUID: nX7OFTakS2KPN9YkVDLKGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19294167"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="19294167"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 19:15:53 -0700
X-CSE-ConnectionGUID: jIqalADESW6kO36DiD30aA==
X-CSE-MsgGUID: GJ+yAfeETRyOzRAsQoOKNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="52324345"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jul 2024 19:15:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 19:15:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 19:15:52 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 19:15:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R01OYBLZZQ+0jCevbUqxUbLoCEofN8eBEQ7IuXtfWzYNsOCynjF9Qvvc2y7LkB5kVsWwfCAVrs3poa8HmLYg7Zx8qz7wopyhwIyyETAR8RZMVLUd662NXQ92nzwlJJLqB08RwezMslHyPCAmU8yFFNLcmDVm8FgHwDDnGW2gQ7DWMDchPfkBDXk7GfYr35ZO+d8Fff0daKIo4E7alsJ0G+MfX7TuDB0djM6Z7JcPxsPzAzi64DaUbidrnYbGABICk9z6uh0uJmyWYDWn8jb5XuyMFiV/V5LLRGoR+BscEiV670PUoXRqNmAW85xA1cQKHZ+3SWZrVzys4Gj02UJVig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aurxyYrULEszEFB4wrRMDmB3auahxZY9soXH78uIIk=;
 b=ssZKAqalpvZJgTpKCgpbBBIcZSsVqt1TlpF609JMsJFzVgtrfavRMr4MlhNBfIDx0mhnLeoMkPGf5GHgiN9cMeRRxvGGs8OPVNA4+Frv+qJ8zaGWVw0jF9bkid5wQIIydmJA60oz/GbKx53MtiPD3HF86mOBzNju3711/Ir3Ujhfj1GSCuTd5atWz5I0BkvUEWmSMDWVwKLE33mh4GnAUnme37opablQ6zqjuEUXVI6Q8/yxFpkftRe1Elk2gnogIcD/nbE6W39S8joeeqJ8SFdpNhyQW3xB+xFA/eZmX5BqIMaNtJNEX6BCT9MafceDSjH3GGF3Y6420Kvv0rMOxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.28; Wed, 24 Jul 2024 02:15:49 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7784.013; Wed, 24 Jul 2024
 02:15:49 +0000
Date: Wed, 24 Jul 2024 10:15:40 +0800
From: Philip Li <philip.li@intel.com>
To: Matthew Wilcox <willy@infradead.org>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: fs/reiserfs/inode.o: warning: objtool:
 reiserfs_write_folio+0x394: unreachable instruction
Message-ID: <ZqBjzC1Zlfd3zG4P@rli9-mobl>
References: <202407240856.rcNo0xl1-lkp@intel.com>
 <ZqBSy1-kmS28JVH8@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZqBSy1-kmS28JVH8@casper.infradead.org>
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6039:EE_|PH8PR11MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 200b132e-5001-41da-2e35-08dcab868900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6L+BxZm66wgIAz01OLM76Z6FzcdsPjrV81EcMmakWNAva6LFmpbDW/Cnki3k?=
 =?us-ascii?Q?qVM+vqxMYpP1VCTbyTO0XvnViRQx3gKWnkCnTeVYRYbeJ1fGNm/2HsXbLAsX?=
 =?us-ascii?Q?8gmXSfI6Hlzm3ldjSmq2Uy0ad5t+3cF1rPdRAr5NDb+pAm4icyVIiJiAkKns?=
 =?us-ascii?Q?dlQYGVEThqWmu8Gkgq/28PhgUnfWbMCDpYxX5zLRAibkmWPXbSEiVRmTz3M2?=
 =?us-ascii?Q?DSy4L5Cdk3lKcISqfyMyM6GNP1TYKYXr06SZHWmWrT8WC8gJegRMQ95wStdI?=
 =?us-ascii?Q?h777aUG425xArxEGe/+bXxh+4o3/eLGCtC5uEbl2Zs0+bWrAsYWIDUbtTQ7G?=
 =?us-ascii?Q?/ToNT2Y5ADOmLyMIgVIdxQaof+lBuf33wqcfAppOclwKwzMP2EMPOWwPtQvz?=
 =?us-ascii?Q?zSe0vmRA0lPZ1juDqtLBDjdJbk7HyoA4x81hHTMsP/JI5p9rLJsSiX+GA8UU?=
 =?us-ascii?Q?cuDYQ/pBqsqyg5HyiN++RJrSAb+i6qa2DaVH600CLJzJpw/zZxw8H3zq3epv?=
 =?us-ascii?Q?KzbHcTCe1fROANSVESS9dilH6ImtM34vfQRXmTNlaOwZfuhd2YePetef/7Jv?=
 =?us-ascii?Q?JcrqRzWqfJ4nLHnt40tl7K11KQl+E5Exn5y3fNLwpDVhkYm5N/+OLx7CDjkD?=
 =?us-ascii?Q?sK0GrPPxrbQKC7Ei3EUEcWNqRDEJZwThCjzh39GDwqKR3beS22SsxPnq2lcs?=
 =?us-ascii?Q?ry5Z1JPtT+UHVPZHCMD4XPZF5NGwe5N/LY57AfopWBInUMh52FfOYmlI/UQP?=
 =?us-ascii?Q?qvPxjgwk6x/0Km+l941ViUIcQo9EMOMWVuNPOPRWMiIzzb18c8u8BM18tDrH?=
 =?us-ascii?Q?F47Wo5ZXPtcOqMkr6fqTdMcueABh6CVLeflcC+uucbzgxDIbW4KtB3zljiEo?=
 =?us-ascii?Q?8Moy7T4sZftF75XAIWUIIiF0n1yEFhwhuhwJui6mXlor4mdYIzGsSx8Q1PAr?=
 =?us-ascii?Q?8tWQ2XgqGNhHCp3iYJt0dIuSAFD3oIv7qOKaoJWsrJXtOcDsFm1o6aC8uWar?=
 =?us-ascii?Q?gjXONq58Ip+GKzXd/Ox7RUPYKwxtqsfIgFvMYpsPxIj5qv/r4vu+Caa7Bg1/?=
 =?us-ascii?Q?uB/gt5m2tk0lslDDpy0Thtxq+7BT6jHq7w1plBycglidCmN4kHiyjG2zQV74?=
 =?us-ascii?Q?u4G1YDMREWbfJL/GXk1Ns/fY1RQ2unjR2OL0PlQrDobJa4rX8xUjvqbSRcuI?=
 =?us-ascii?Q?NYq0BEAwV2JcZEbXWAJBpZ1RILU9eK2I6EzUak926+puzVv6KiX9pHEvYOOq?=
 =?us-ascii?Q?Y/DzGfNSnA1pz9rtVjlsPxJpGiXO4Kvw/b77X6pUOiRSgKk1v+K0C1bycPNv?=
 =?us-ascii?Q?LtQIgssJedXnK/gxEB3iITGf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lG0cye5jej1qrynD5j2ScYQ2l8Diw3C4T2CpWnyrWB0zgYWbYMTxeOHVBRN0?=
 =?us-ascii?Q?bPw9brGtaGhfXfKEpv/rqn94VgC0y7Zy2LcOV+r4qnuihc3dR7AGuKt6kz6F?=
 =?us-ascii?Q?eAI2ZeHnP3OQ0Zkwz8KDxwSBKygXPiW9N3DFxNGab3GoX163IFeoO/fpIFMf?=
 =?us-ascii?Q?7nax+MsU41iu368qhzbaV7/UflW6UGtLxF8BYTwBbF1wcpf/n5XheMfWmTvN?=
 =?us-ascii?Q?HBKWhYWS+4Oj2YOrY8MQtzhmjc1prIMAHo3IO94ky6/wFUTcL7aq5AyQYdcf?=
 =?us-ascii?Q?Nydxrz9+p2qfl4DQfRyS18FUCCWZ3QGs6s8qReJ3rOOiDhM55iMJ6G6UGzDq?=
 =?us-ascii?Q?XXq1Irbdm9WBlUD+t/Cen/ioNGJFMrQ3SdKYdegOSm3FnVCxHYqzy2xntv8o?=
 =?us-ascii?Q?rpQgdnqzSsujJzbToEM1AaozVdc76Z/T10vJanlbhWOE/sUnK+OaeFRn/fDA?=
 =?us-ascii?Q?7s9+OD9w2iqscHYeJuT1kyJ/kYCY2C3DJYvtLIeMdmnPBOlvxyytp1vlz2JP?=
 =?us-ascii?Q?foD2kis3RtzyPiGBr15fJvSgSo947ZClEyEarIEW+rEBmruS+8kT1TJojjqQ?=
 =?us-ascii?Q?OttYGYsuvl7+0cNKumSrr3qb7vVXKpPT/wIQ02Aqtv2MPIgYLufgpBdZZEon?=
 =?us-ascii?Q?VTJ6tk/AiAj8R/XGHi3sE+Btu/5PdObf8bBiLNWmvwr3WAz9+0lrKmwUvjoY?=
 =?us-ascii?Q?HkzNaapzCoba/GRF0TBJXLglGU85DKqnyL7L7sqMOcmGK9LvHiP0z+0m1LUn?=
 =?us-ascii?Q?CneqL9M1QKVElaicWj6tYkQjLIEc/HSC5upiiA61ZKRZKsixqfPImby5FMBv?=
 =?us-ascii?Q?C9SYNFUetVZ1/3t961mqgGSzdCt42CByyRUlPKY0A7ab19cpVYho2b4Thu0r?=
 =?us-ascii?Q?byTZRibMqDtSV+6j8iRTT95lad/MtxG+SyxdKka6qsvHFf8s0pwHfJIAgevn?=
 =?us-ascii?Q?UM6mK6heFmDipp/ilyHnhhwBrcBRCaCRhzH+dE/Tg6XpjUeIULDR6b/Bh2KN?=
 =?us-ascii?Q?2rqOJ+ofPBqmxeZXl2w8nar3If5ptHn2pSN5vMn3gjXNBOuUSv9safpMJDHm?=
 =?us-ascii?Q?UtELt1K/wk+YbPyVv2ZbRIlz9Hr2F64nkh/VOgoub2SdUyxAr2T25AgMTQh8?=
 =?us-ascii?Q?ZmQGNM+K8/pIW3JMwRbVxHO+6Fq4YIoYTqsNBpAa3aw1XDZJudorEMnU0TW5?=
 =?us-ascii?Q?bmGTUS95wBXHUdOM2kPQ0bjXdTLXMYQvhLpfja34HdnhAQteRi3jMk8csHq7?=
 =?us-ascii?Q?8gSZ0bwpkqdkiFDZKoTqTrrzbzWUVmR2RPPyLLth+PtStED5y9rhtshtgX23?=
 =?us-ascii?Q?wPbcmAwJ4LpGq4VLECwDO8Je1Rj35Ld+FS4rwP3NL1sHaWIQVYQLSh0DBbUP?=
 =?us-ascii?Q?g3wpbciWSaewUWebVGGCMCDfBTrm3YvHV68ygzzXg6MdYH3EEvJTm80E34BG?=
 =?us-ascii?Q?KLl9V/aRBaRULMvyISVeBqLt/WZpUtgJHn7XtasRYZrhQsubiGB4D6qQiY2W?=
 =?us-ascii?Q?s6LZfl3YDVErfzr9AK91e78itq04YzSyi7+3WZadWaDtpGgxg+rz2IkwHDL3?=
 =?us-ascii?Q?uWn+pCMzyLaX9Vi1e8R9nolqT35CpGIyAa4gQXNE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 200b132e-5001-41da-2e35-08dcab868900
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 02:15:49.5038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61zjq5utByjxpEiDsqpMC1HVucM8uYB2bJhnqf+vNXdgBjpQhDeEQnnuOkZn4Cia2zf47U1xNdV3twCkSU5ASg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8107
X-OriginatorOrg: intel.com

On Wed, Jul 24, 2024 at 02:03:07AM +0100, Matthew Wilcox wrote:
> On Wed, Jul 24, 2024 at 08:56:24AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   5ad7ff8738b8bd238ca899df08badb1f61bcc39e
> > commit: 4f8cf60ac18bee62e8c58654a300eb44b96caf09 reiserfs: Convert to writepages
> > date:   3 months ago
> > config: loongarch-randconfig-001-20240722 (https://download.01.org/0day-ci/archive/20240724/202407240856.rcNo0xl1-lkp@intel.com/config)
> > compiler: loongarch64-linux-gcc (GCC) 14.1.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240724/202407240856.rcNo0xl1-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202407240856.rcNo0xl1-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    fs/reiserfs/inode.o: warning: objtool: restart_transaction+0x38: unreachable instruction
> >    fs/reiserfs/inode.o: warning: objtool: reiserfs_write_begin+0x90: unreachable instruction
> >    fs/reiserfs/inode.o: warning: objtool: __reiserfs_write_begin+0x88: unreachable instruction
> > >> fs/reiserfs/inode.o: warning: objtool: reiserfs_write_folio+0x394: unreachable instruction
> >    fs/reiserfs/inode.o: warning: objtool: reiserfs_new_inode+0x8c: unreachable instruction
> 
> I don't care.  I doubt anyone cares.  Either about loongarch or
> reiserfs.

Sorry, kindly ignore this report which could be related to tool chain upgrade to
loongarch64-linux-gcc (GCC) 14.1.0.

We will further check whether the issue can be reproduced on gcc-13.

> 


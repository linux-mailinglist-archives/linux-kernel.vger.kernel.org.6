Return-Path: <linux-kernel+bounces-446445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67D19F2464
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 15:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174521658B1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23C61917C2;
	Sun, 15 Dec 2024 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MvxVMkv+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD54218C932
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734272875; cv=fail; b=S6WDlllt4d2T6PPMAc3yeAdI0TnQrPpl7ha/Ph2Cn0k8ekjHdLXu8YWkOy1vhifLFdOAbFZD2VxMgtZuwXKkBKQBKfdutpRmzZIrqEML+BctyqHT1HwXA/3licDpvusAf9zGEitz/Zko+6RcUtly7t+xUoAK4omp3kwXkEmXqvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734272875; c=relaxed/simple;
	bh=xDCq6YvNwQYepDqAEZjKP8aWWxhed+ZZbDCBDH67Hk0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G8l96pXTW4yswK4xHlhYCa3vNeEt93NV2s8G6DZDmY91E5qu74ZLmPJRs/KfFKYexkrCWOBCqL2vJ8t4UHMj/LJnxPGb+3vl6HEvYHzW1YMFdCscr2Yi5XDs9is5xfcSF3QmPkNBGcZy4mlpFJXn+dYzBsht0TwF2xxXC+bnZ+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MvxVMkv+; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734272874; x=1765808874;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xDCq6YvNwQYepDqAEZjKP8aWWxhed+ZZbDCBDH67Hk0=;
  b=MvxVMkv+MjLV46ntLgq7hTn0ctY3A9h0tuUfQxqspnLHSfl5JWQdbn5i
   0GRO5TH5lMc5QoIkZDP8fIyDvVOJ+82Re1wr0Sgs/7/E5mhp9IpNflOle
   UKcyzoJXE6drdzhe75H2FaJjwkKGucnzjF6UHsq5VhJ+JzCG5il+t2KhV
   n/t0CmEHX9c9Oz+1dwU4zktxWXFN+ESGWuP5hspOL5ygAvruXSJ6fDZTm
   Gd71HHicEXMOa0HZi3hO3MGhW8sxfwZSttMiioljvRh1jJEWtfHYk92lm
   gy81KZDiBIyObQyDCyp3S9/d0Fs8BVM38vM+jgN0DGx2oUTyBD7WTag8E
   A==;
X-CSE-ConnectionGUID: KA4ybh42QraGuTi6O9HSZA==
X-CSE-MsgGUID: 2Gw1UtIKR8ueZGn32XYR4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11286"; a="52185290"
X-IronPort-AV: E=Sophos;i="6.12,236,1728975600"; 
   d="scan'208";a="52185290"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 06:27:51 -0800
X-CSE-ConnectionGUID: HZ2KOyvSQCaRasy1k3EwOQ==
X-CSE-MsgGUID: Yun6ShTST7iCNhlJXAuFSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,236,1728975600"; 
   d="scan'208";a="97204341"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2024 06:27:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 15 Dec 2024 06:27:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 15 Dec 2024 06:27:50 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 15 Dec 2024 06:27:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrbJNSaWc2H1Fd26Uh4sjQR2JVCFjub1OAMHuiAmqb64Mh6kpYiWZ5ulR0BcIkNCs+3fjkxRzaHJfVzGv7w1+RgBaPkR+G4Y2Hpr8Hs/C9PAxA9gQ2Pru5p2QHU7pvRW8FKs5/YSJy+Wj4VVADPI3X3DkKSOpAB0pVCN7Aq5ySdPkom6HW4XyQu/P7ZK1yhfFDETLppCZb2kHgfbxFTCCxPvmRugg4E1c+N22nHrwcOyTgVO5V3F2MilU0NGkBxVyMluSBN8qitNTyw/nrGEBshceSlfIKl0NBeqolb2UP93isLFnZXJr3BLmZX2vdAjGMS/4IC38lZ0a+pOiWYQmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLnKAU4IAavFb7xl6L8eDPd0CDZAGGYEYJrxiEAaasc=;
 b=ydGGT9hhcXtO/qPd7K7OoONBqYuAVC6mvNnfS4aR/CyITlBn5ZnCb3PQtc953uRT3xcS5g4F0P39zBIlUhHVkoXONcjCetQ/TUoqOpjZuV5atocIQ312FKr4esGE9Zm7O7XtC9L7QdvqnhEitXoc52ge1YWHdXJ5SNjfnEcNafLFX2Ph66+j44I1y22CFVPANK5NcgKCdgLejz7DOrcg4mtAoX4lq8qkTLSlyBkEAskv8n2sipv+uB0dI5YI5k9jPQ3Sp/Ho/R0da3IKYHaYDi4mdi5t1oZfUTduuKsdcgO0Dg5aCOpJjPVPiYhuN/zqqBdeHs1s7Y/z+q84ScOZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by SN7PR11MB7640.namprd11.prod.outlook.com (2603:10b6:806:341::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Sun, 15 Dec
 2024 14:27:30 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%7]) with mapi id 15.20.8251.015; Sun, 15 Dec 2024
 14:27:30 +0000
Date: Sun, 15 Dec 2024 22:27:22 +0800
From: Philip Li <philip.li@intel.com>
To: kernel test robot <lkp@intel.com>
CC: Kees Cook <keescook@chromium.org>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: arch/x86/lib/usercopy_64.c:29: warning: Function parameter or
 struct member 'addr' not described in 'clean_cache_range'
Message-ID: <Z17nSh5XhsL3DBBz@rli9-mobl>
References: <202412151701.yujios7D-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202412151701.yujios7D-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|SN7PR11MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f44d6d4-b32a-4b02-11e8-08dd1d149b40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nLi1e0Xa1HbgGJ35gBL5gxBFyz4s5F7WZ5FbVM561cCQRK2pBflSNtZ9Z/XZ?=
 =?us-ascii?Q?FhXZXvtIKCaDcI1s/9GvL3/n5FQyL74jrGjrujIaxni+/wa17QaqEhJuSF0J?=
 =?us-ascii?Q?ugyuw2C2FwkPT7jt/MaD1YcmvFYJ/TIqgtrEPp13t4FrOOyETMnGj7S3oot7?=
 =?us-ascii?Q?byK9cBwHOao+687ftQuXDpCBDDt3urIDM6kBeDR+oE75QNObsZUBtmd3AczL?=
 =?us-ascii?Q?9yQxY03/U37VCf1f2rVrA4DYb33aTJsF17cvTRBuGbliFrjDKpTBB5dMBdHj?=
 =?us-ascii?Q?It7gQxWYaG407C7rynPxi98FzUoFNMZaWs2gmz4bs7foWqAAkiGnWhTX8Glo?=
 =?us-ascii?Q?IhTOpYH5IqveK/GFTBArwnKO2BmQo5oJjyr8AHIpW2Hb3Lab7LirswEqwTgm?=
 =?us-ascii?Q?wntyZFFpv1KqTX51rGbNcRH3Ivls3gD5jz0/4bhKTVt1aE02Ib9gz++qbhjo?=
 =?us-ascii?Q?cGsYSCciPBFqg5d7p+WObevSh5PtbYtw9hcqIPRxIQfsDgHLnUq3uWGLL3Qg?=
 =?us-ascii?Q?VdWZ6Wo08hjFVo5G6VKl0X0FoHBmeiOw9Mzchug4an6y+5l966KB58QZSiEf?=
 =?us-ascii?Q?mGY3TNr/RGMkBqZCOsU3LFVxWM+h6j2X0WgSNLLKXRNWefLLlZCufGaJXbOV?=
 =?us-ascii?Q?xYO+hbYSI8re/SvfQnk/lgeAnG3bVoWjK4Smk5jrP4IuKok07+DFSq/3qFdq?=
 =?us-ascii?Q?YK2N4wgwBL4gk9WrlgEfPoT00rmgpotWEXi7j09EHmk70x1ZN/7vhfQqURSF?=
 =?us-ascii?Q?tqOlkIhg22RmsjFyZI+prqzNGCTVENYf4fcZpg2gBTpr1ToEbtamA09TWAzY?=
 =?us-ascii?Q?bmAb/8slqE9QeJ73gdJMFy1Ja6XnFAid6AP0nn/Dp7/qlssk9qbjnIcCEqR1?=
 =?us-ascii?Q?6TviP6mZ7tE2+BVdXCrMbG2ZfmMbuJHBNH7zQJh0LUuFNcuWkSf6l3rfAt/X?=
 =?us-ascii?Q?rrFPZyObFXJqk0gtDaxE24nQwJAAbNqFINhNwkfCjUKn4zdZleq0yomNB6Wb?=
 =?us-ascii?Q?Y7OYa2z1ffkdsH3HAKh3D1RkLm0Ntj8gWSuHMbgMfrSjGD8BoB0mti2pfCHM?=
 =?us-ascii?Q?8i9K+o+7ThUtQvP/0mnsSdP0A/a8OX6DUWl8bNvHlKx85toUjiCEa8ar87p7?=
 =?us-ascii?Q?u+LHGpJCsKcQTwwHIL6je0uJuGpH5y8oIFyllCRgzY2t5SGy2yw3DjfzKU3v?=
 =?us-ascii?Q?25nd1DzTHHZqfyb4rrLzGkR+iwTkyksBIbtDEB++J1kHf3gnG2qX6hR8ND+Q?=
 =?us-ascii?Q?AD2N9YrUj5YxxJH7uIDKgwODzgFxB9tqGjs6daENEJOIk5btKCsQgVW/nEm2?=
 =?us-ascii?Q?Kv4gFWdgJ9q9ohJW68Tf5v67M1fIrKgOv0drwWwm+/zpXQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n8RvjSCZMkklPbehxxHk08qqNhyqb9loMIjM1FS8Vmw2duaFDbfexwilrkJS?=
 =?us-ascii?Q?XcWzW02iwvIAb81W3pHvAshn9uiU9NdVtHRYML/tfbPIhnYXPFKOGowldc/J?=
 =?us-ascii?Q?AKlQF3ywb/2fEqMFQ18CUg1NrNN69e64WIxYmW8x7coBFRYfSSdWwUfitKbC?=
 =?us-ascii?Q?FtgOVTSQULfvEDBgV9jUNLRLTK9vH/SWj9cPCMhM959XxYMt/maBFhrVr0t0?=
 =?us-ascii?Q?GalhtOy+RLOEq0d6RGNIXwC2cAJyAyYUuLIgdRaDM9a8Hrevapvef5P1C9eL?=
 =?us-ascii?Q?vbltK8MBp05ViWFPWjmwyAONG3yKIyEXEUsr7M8QeTXy9egOL4Xqc3xM8IqS?=
 =?us-ascii?Q?/zf3oksiWO2dZDNuadouYlwCZUfkjOH8hwtIeifrJ/9n7HVBjzMOulmxNVIn?=
 =?us-ascii?Q?bwj3a1UkQlnyeQckczb7F7r9lYD1omQa7dk85yyVqpQFdkisriiVHSur87dj?=
 =?us-ascii?Q?Wtr+d3QI6eg6VX8FhlIARIvBrKZ4Z/VtAanGTdWLTAGsiIuO9/aWBFpR9x2R?=
 =?us-ascii?Q?hAJLHbkoifzICyAvl2uZNcy1wqpr/Fa0lhbIQ6ArVwN6pKz1/HmS4kkOayg6?=
 =?us-ascii?Q?2uhinuhNOh24GqpTX0MrYhx7tybhHjILsOIjXQeC4UMs3AF6ZuUeLRUroZmQ?=
 =?us-ascii?Q?SMQV2M9A3biEGluMy7slXlbkNPCqLemlRBL1eiwoD1weO+CLfmR/0DZvB9AZ?=
 =?us-ascii?Q?rHIoeNgIGTgBrQqQCf/iJLd4wf4pl3mYnG8+ih+ciuZeD4Lw7vMjjSNa4AqT?=
 =?us-ascii?Q?l+f++9/ikisFtPHfP8bTZfLgItX6i/g838v4++txfhpDdaNJZzT0YYCO3yi9?=
 =?us-ascii?Q?fTc8EWM3O4b84XXqkwy2wHDjV8jZFiyIixC6FC9GNLY5beYpvT59nbxkpYHm?=
 =?us-ascii?Q?LGaPRTLixLjn28Bt/0ZQWz9g044OQ52u1KTr8FIkelcysQ3u5pLbqsvthXnA?=
 =?us-ascii?Q?pH/Fx9+AS7WiofaYjotNa+5T9lgMx3FYB+w5vC6rJ/GRctiWZiV4F1QN6C0L?=
 =?us-ascii?Q?BRObZ4iZVO6QX6sIQm9ntvwCzwO3PqxgxW3P2oUud93t8U4XUM0IOeLt1VeJ?=
 =?us-ascii?Q?2VV85WWHpbG9OOBLF26zrXd/k1ws1M7t0VoRGO+/0uhe69CZE+NTHvjqHV1n?=
 =?us-ascii?Q?ghKX4pdf4vaya6OES0RGj/Hw9XKjqynLMSR8BClYqWz+kzGgEb/gxh3+O+ej?=
 =?us-ascii?Q?BRin0Aklzdri6/FX4lglqMLnrdGPDu56HTxoS+7dHAl6DBKPUn32ydERspyq?=
 =?us-ascii?Q?NMlUbta11MRWKWD4PCW/LEQyrfv75sJqvKRAxXK3wGe5R+qWShP9XJ4Jq7Gt?=
 =?us-ascii?Q?vnnQO1+X+lr4TteQM/RN+X+/1FCnKLKN9EeMNJp4572f6e3yNUv39Ko0eF2S?=
 =?us-ascii?Q?NQ7nOajYLpHy0ySd2BaA+67NUUUzy/zzZu7Fp9RpJE9e3P5QBCA621sbYxRl?=
 =?us-ascii?Q?qNLbRfM/UwJ9JuxXRuznYKU+yXE86jwul7FiHUlXXWtAWr0PJLNq/L6ZqQMj?=
 =?us-ascii?Q?upbcnEr+7c4G1fJXBN5s0T2R5EvbIyMITntvFFzfZqz3sbOthOeLLZPgDwqZ?=
 =?us-ascii?Q?2Nul89Bc2HaofaAS5QJRew4gi6oD1Gt+N8+PREJu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f44d6d4-b32a-4b02-11e8-08dd1d149b40
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2024 14:27:29.9751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NC/ep239s3q9XtGU4shmZiaeulXXtQOta/TqD6S+tnWw+pi1acvo1EA5a63gUlLtUNmWDpmd/MZPDxhmN2Faug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7640
X-OriginatorOrg: intel.com

On Sun, Dec 15, 2024 at 05:38:45PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   2d8308bf5b67dff50262d8a9260a50113b3628c6
> commit: 0c3ebff535956d2718594dc90aa9cc87521ec9fd scripts: kernel-doc: Clarify missing struct member description
> date:   1 year ago
> config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20241215/202412151701.yujios7D-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241215/202412151701.yujios7D-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202412151701.yujios7D-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):

Sorry, kindly ignore this, the commit is not the actual cause of
the issue.

> 
> >> arch/x86/lib/usercopy_64.c:29: warning: Function parameter or struct member 'addr' not described in 'clean_cache_range'
>    arch/x86/lib/usercopy_64.c:29: warning: Excess function parameter 'vaddr' description in 'clean_cache_range'
> --
> >> kernel/reboot.c:226: warning: Function parameter or struct member 'cmd' not described in 'do_kernel_restart'
> >> kernel/reboot.c:952: warning: Function parameter or struct member 'poweroff_delay_ms' not described in 'hw_failure_emergency_poweroff'
> --
> >> arch/x86/mm/pgtable.c:650: warning: Function parameter or struct member 'reserve' not described in 'reserve_top_address'
> >> arch/x86/mm/pgtable.c:699: warning: Function parameter or struct member 'p4d' not described in 'p4d_set_huge'
> >> arch/x86/mm/pgtable.c:699: warning: Function parameter or struct member 'addr' not described in 'p4d_set_huge'
> >> arch/x86/mm/pgtable.c:699: warning: Function parameter or struct member 'prot' not described in 'p4d_set_huge'
> >> arch/x86/mm/pgtable.c:709: warning: Function parameter or struct member 'p4d' not described in 'p4d_clear_huge'
> >> arch/x86/mm/pgtable.c:726: warning: Function parameter or struct member 'pud' not described in 'pud_set_huge'
> >> arch/x86/mm/pgtable.c:726: warning: Function parameter or struct member 'addr' not described in 'pud_set_huge'
> >> arch/x86/mm/pgtable.c:726: warning: Function parameter or struct member 'prot' not described in 'pud_set_huge'
> >> arch/x86/mm/pgtable.c:752: warning: Function parameter or struct member 'pmd' not described in 'pmd_set_huge'
> >> arch/x86/mm/pgtable.c:752: warning: Function parameter or struct member 'addr' not described in 'pmd_set_huge'
> >> arch/x86/mm/pgtable.c:752: warning: Function parameter or struct member 'prot' not described in 'pmd_set_huge'
> >> arch/x86/mm/pgtable.c:779: warning: Function parameter or struct member 'pud' not described in 'pud_clear_huge'
> >> arch/x86/mm/pgtable.c:794: warning: Function parameter or struct member 'pmd' not described in 'pmd_clear_huge'
> --
> >> arch/x86/kernel/apic/apic.c:2170: warning: Function parameter or struct member 'spurious_interrupt' not described in 'DEFINE_IDTENTRY_IRQ'
>    arch/x86/kernel/apic/apic.c:2170: warning: expecting prototype for spurious_interrupt(). Prototype was for DEFINE_IDTENTRY_IRQ() instead
> --
> >> arch/x86/mm/pat/memtype.c:710: warning: Function parameter or struct member 'pfn' not described in 'pat_pfn_immune_to_uc_mtrr'
> --
> >> kernel/time/tick-broadcast.c:1026: warning: Function parameter or struct member 'bc' not described in 'tick_broadcast_setup_oneshot'
> >> kernel/time/tick-broadcast.c:1026: warning: Function parameter or struct member 'from_periodic' not described in 'tick_broadcast_setup_oneshot'
> 
> 
> vim +29 arch/x86/lib/usercopy_64.c
> 
> ^1da177e4c3f415 arch/x86_64/lib/usercopy.c Linus Torvalds 2005-04-16  13  
> ^1da177e4c3f415 arch/x86_64/lib/usercopy.c Linus Torvalds 2005-04-16  14  /*
> ^1da177e4c3f415 arch/x86_64/lib/usercopy.c Linus Torvalds 2005-04-16  15   * Zero Userspace
> ^1da177e4c3f415 arch/x86_64/lib/usercopy.c Linus Torvalds 2005-04-16  16   */
> ^1da177e4c3f415 arch/x86_64/lib/usercopy.c Linus Torvalds 2005-04-16  17  
> 0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  18  #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
> 0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  19  /**
> 0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  20   * clean_cache_range - write back a cache range with CLWB
> 0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  21   * @vaddr:	virtual start address
> 0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  22   * @size:	number of bytes to write back
> 0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  23   *
> 0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  24   * Write back a cache range using the CLWB (cache line write back)
> 0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  25   * instruction. Note that @size is internally rounded up to be cache
> 0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  26   * line size aligned.
> 0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  27   */
> 0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  28  static void clean_cache_range(void *addr, size_t size)
> 0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29 @29  {
> 0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  30  	u16 x86_clflush_size = boot_cpu_data.x86_clflush_size;
> 0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  31  	unsigned long clflush_mask = x86_clflush_size - 1;
> 0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  32  	void *vend = addr + size;
> 0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  33  	void *p;
> 0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  34  
> 0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  35  	for (p = (void *)((unsigned long)addr & ~clflush_mask);
> 0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  36  	     p < vend; p += x86_clflush_size)
> 0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  37  		clwb(p);
> 0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  38  }
> 0aed55af88345b5 arch/x86/lib/usercopy_64.c Dan Williams   2017-05-29  39  
> 
> :::::: The code at line 29 was first introduced by commit
> :::::: 0aed55af88345b5d673240f90e671d79662fb01e x86, uaccess: introduce copy_from_iter_flushcache for pmem / cache-bypass operations
> 
> :::::: TO: Dan Williams <dan.j.williams@intel.com>
> :::::: CC: Dan Williams <dan.j.williams@intel.com>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


Return-Path: <linux-kernel+bounces-573279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E3BA6D52D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740641892A88
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745E8257AFE;
	Mon, 24 Mar 2025 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f5uT7qR7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5D0257443
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801853; cv=fail; b=NuYABJwVXzXwhCtimr+0wu8SKwihK1fAqVX/wrwG207vgybdYHp1BLWHLCSR6XCoMuplwi/xjFjnTQNPNlS6eqTZzfUlWzLHTB76eayHcHZDn5L++zrdAtBKJSOd0S6ubFXWaqGxKtTTtv6vUpcE+4o2ErwBwAxSaRG1Uq1Z4vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801853; c=relaxed/simple;
	bh=SBgehmMPy1hXEdtNObwEwR6VObyjt/0xcsrcFv8yKJs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P6gynDYnwcvcQyuUwDauXNajkxIdgNVyB499Iqsi1Ge4rnuUzBESUFHHA/QK9Qvy+9EIP8hI4zlQJXLbDJEgnD+e+HphDhKtH9NKEC9TERW/SEMu2xjzObOyRyffswIJzFSdcKhZ+RXjm362h8fABFX12odm6J9qmOrQNI2aS4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f5uT7qR7; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742801852; x=1774337852;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=SBgehmMPy1hXEdtNObwEwR6VObyjt/0xcsrcFv8yKJs=;
  b=f5uT7qR7IS5qh0ZODbq9jUUxoRoPwrONvtO+cxLZzdNA42gsL40SBofk
   qbR3sPWE6kKpc33ZwYUWVAlx7vY7ntyeuEuh08DShcowmt34Pw/SANMxg
   cOjxCeCTXszjNBnWjk+nvWpTuC5ULh6U7YWDRNp3l5xfMlge4Et8Uph3V
   hrBgf771Uc207iZkVbAIEvJDv3naLsm0hyYD5ULufEG8WcsZ8+brHl9RP
   1EpMa3cDGui4wt6vdI/L5CV0YwUpVPAkuwDRMciFeiH0WLGUKcmLxbcTh
   2aiWZPy0WGZs8HGlZEhkBntZFrZeZAE6xwxjOouuLUE/MttX5OWhDy+L2
   A==;
X-CSE-ConnectionGUID: 7IwD27HlQVamLdHUBfh23A==
X-CSE-MsgGUID: Z/vbi2DvTIenz9xv+mZTwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="61383090"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="61383090"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 00:37:31 -0700
X-CSE-ConnectionGUID: Q0gbh0CpR8ib8/yzZqR/ug==
X-CSE-MsgGUID: wBlwaMnPTY6reZLrR6WMwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="123684101"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 00:37:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Mar 2025 00:37:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Mar 2025 00:37:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Mar 2025 00:37:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jE5F0kwncnUwH2qkbyhOZAlnsReo1WtEOOlb8kup8+/Hxxp4QH2p0WHplYxbKVcaYtpYF2M2XXWGVzZq7lWW4bucCGOkpxhhVM9HTFJUEinW/ptUSgsSG7VklHXC3XhFTrCkj8YWT2MOR2DQ1GIsYtGw14aj7ksIgpFtY/c2jKErbMgY09CSHUdTDzgjo5edOY7NbCXNuaRTLg9o52SCFPD+j0ukEqjnNALH9iNSv0NowpBQtezuhGanXL67WHt4zMm2cRvDZRhQfaU70jR6G/E72RwoRBuGCqEm3KKaA5B0QJN68AWjbY+7Mygs7TgwORZv1TR1wHUrA//CUJUSeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYoSHmIT4qA3Nhqmr4VXgBWccsU+6FMJH0wy6XulL3M=;
 b=kEXqy2O3kJJHdqjVLG+SoRJ+1DxFVqU09+CchAJgnaax/kTe21N3kYm0Yf77dJR0M3emmywhCRNs5dMkV+1ehxQn3rHlTtHyBuJjkfALb+yfqCoRUKscZyRb979VI0Du+mZXjFj4hF8nBeLEU9zGhPS3p6IVOcPkICc5oxmxaHzTSPdLeXgzssqsUpH9myZqEESsJfhbkiDIJ43sUDk268EfowhIhaPUB2UC+ukvoHFGR7Si3dMAHU7AXlWBFiPDxOYj8DMmkLDea7qumXw1on1BwvKxecDAAomXf2adi1Ja93yvgm93EnvfF/UrbyWEm+2hLeW1NDvZiw3v7rjqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB7940.namprd11.prod.outlook.com (2603:10b6:610:130::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 07:37:28 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 07:37:27 +0000
Date: Mon, 24 Mar 2025 15:37:17 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Andrew
 Cooper" <andrew.cooper3@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, "John
 Ogness" <john.ogness@linutronix.de>, <x86@kernel.org>,
	<x86-cpuid@lists.linux.dev>, "Ahmed S. Darwish" <darwi@linutronix.de>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v3 22/29] x86/cpu: Use consolidated leaf 0x2 descriptor
 table
Message-ID: <202503241523.6b53646b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250319122137.4004-23-darwi@linutronix.de>
X-ClientProxiedBy: SG2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::15)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c6ebe5-7e8b-4ba9-6c57-08dd6aa6ba35
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lU0hTQG1L0El/0uNpDbMjHAp7gAKZD9h7sUQyaYcsIORR1w/3MVFXj99lT+U?=
 =?us-ascii?Q?6XAwZDJ6cnsJj5uN5P2Je/qF1nBK3QyB5DRN1ScTabjO4a2SQyGeLf4LYiTS?=
 =?us-ascii?Q?OFajE9+WDEx7Byvr/QAOqNNuOLVdhlk4ng476mSPjPZYPmxa7Aohfj8BnEC1?=
 =?us-ascii?Q?cHoEs96RwAGp0s/j6Fs908v1DZ+4lKiM7YqXB8OhtNpQocTJLsbxDWD9TH/6?=
 =?us-ascii?Q?5iZ0s3hRtehAPThgra2otpt6hqSKRW0uiNBMQA9/PDkxe6UkdwTc1gXbLSwt?=
 =?us-ascii?Q?gHjwqOtv1wEfCDWrkt0EMyCWPaSh8PrGZWeRWaC5mGPc3qDwLbzzeEuBmgyG?=
 =?us-ascii?Q?bwTScv6+/8Nnpm0wZ0CyqLxxRciLnEpeP5joyCPBYsDMTzyuyZ96QOSZYDAU?=
 =?us-ascii?Q?0m9xPz2QiB5lJKD6nL8Uls0ggoaHKO+HjHuX1h/KynM0eYNMjfai5NikndW8?=
 =?us-ascii?Q?Xv9Vn1ZTdh+YdItOm6IHMUuwViBooG/QHLOtfV0kQsPHiAD6TdMHl++nF/Y4?=
 =?us-ascii?Q?VFt5yPw6betpSI+spawHy1kKE70NEDUieu2fil9u1WM2mcOEz5ZWaXJo3y/D?=
 =?us-ascii?Q?oMvl2LqqpwJdlbUmqU454VY4yD5d3BYOpVA+LsJZG4chDKuW5z/8iZekKEV5?=
 =?us-ascii?Q?lU+oMLXsbItPX22qDJ2EvNoP3Ji78iFQ8zuVlqWaAphPcpc7rqkNVa3remu5?=
 =?us-ascii?Q?4zHlqsvNsFsyYzKmrjHl0yYtdST9CCnWzJKqP2eKX+JboVyNbJjipfgGFxBa?=
 =?us-ascii?Q?6jt7VNMhC0MOBgx1NM2JCd7gChN+Qq9Qule9S4qQBYwtBOXD7Hb+SVRp6Z3E?=
 =?us-ascii?Q?tW4rcZRtjCeBZVL7hsecfuBQ7eNUEToFc6EjKegEfCmRJFmQHtNpQfuZZTck?=
 =?us-ascii?Q?Qs276f2Uq42IkHNTd0eAWdgEe+Rv+OQeWpAauYe7H1nW7vnpy+oRfQQyGaC3?=
 =?us-ascii?Q?vp9lR28w2D3LqkzC8DcFcixZNIKIi0rsIGLUZb1RSUu2v9kep0OJdP+1YSxJ?=
 =?us-ascii?Q?UvHrNjaUiAUexfsm7dlvSWfLrEe6FSiyNyN0cw8ensnIJ3qLDF6DELRMC8eE?=
 =?us-ascii?Q?Ufu9qglIPQHbDqERGP3el6Mafy2Jd0wXNGgC55Twkh/njNKei/9LbNVPL2dU?=
 =?us-ascii?Q?AqHB/KLUhLbxdGsjN1J+6FvDBEsmFNCXfwxSN7jRfab9jW7flEKJst+Pw08t?=
 =?us-ascii?Q?K8TansnM+GbXffJhcdRzqTrFInu7fON2liW+AiD4TvUnVRxxyGP1HXN8f0T9?=
 =?us-ascii?Q?KYqUzwqy1Z7Ga0oMFRJZzkk8W1Vqkx0S6zNkdoKYqR6KHAgFywE9mitnLtDt?=
 =?us-ascii?Q?76SyadBVuxjUVKR2BfM8m91D6V4orNG09xWsgCGW6o0ADQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tgHAyKm7S4uCT0chtfHuPt7F+bZ+Xf3h0PZ9Nx3d5F2QG/oXDdzMTBonCz9W?=
 =?us-ascii?Q?7aMY31i3MGEWvMUDupYtQgDQxjVmqq2AIY9BjDHXDFEhzEg8Ww+9IeC+T6KN?=
 =?us-ascii?Q?L5DCqinvp+vfj3xQ6ljy44oFuI1Zhrr9fCq2PBEB96snc67CQ3gx9ZVHWs2D?=
 =?us-ascii?Q?fqjO86SoZ79nlzZ3fhxMdYp/g48S3UDfGI0yUfu4kMo87srHohLRkD4Rr7h0?=
 =?us-ascii?Q?WVHkCOFvCK1KMt4OLsc91nE2OJU2qcp0cQ31QWh41c3vXUUskQzX6o7DWJnX?=
 =?us-ascii?Q?4VdqMXu/6rNHZMVC2Mh+LSsGwoMpEI3frgiE9sC44G/dSw2VC5pG+52/2KjQ?=
 =?us-ascii?Q?e65Nhjgs+YrdR5C+jUmJu7EdbRohNanjeL+lToCJIy5hv7PCXXOghQk6d5EQ?=
 =?us-ascii?Q?OIGJ7SGDU4Po7BLBz2y/7ydXqu5FN0fnZZYAjsJA5IgHtyT+up6Ajh708FPH?=
 =?us-ascii?Q?cRHbNkv/e18rXxp0rHHWT9V6VnU2/zZIrVRdQLkLM3rwM+M5TFfUlaF5FhtU?=
 =?us-ascii?Q?ptHoPEETeL+q6FW86qZmqEsXP7So7uqSBLkEHZY/UqiSyBLA7x3NCpuqac69?=
 =?us-ascii?Q?oDGkCqc3JvSeRc00aRZKbvNtvVp6oJ7s6RRyF2p1Mq/ecf/jE9wh/nnwS82u?=
 =?us-ascii?Q?DFT3ndbofaTlqdSQR2sEMKpTo4N9HIau0gl6umcJEHjG0Lk/OJVSNmcTAiVH?=
 =?us-ascii?Q?qu2phzqAtRnk4j1kaNjTK05O8kw7YZ2KcmabsMrm0zvwgyhoJzePbwdSOVeD?=
 =?us-ascii?Q?7i2tuPGN+CaqAI5RcEYySERNlYRINVgsLWYaV0J5IhIMtr5WY8ikrHnaE7/D?=
 =?us-ascii?Q?qIoy52tJNNHFWD1uLGXbAB1+755NTLpglqIx3xUYohQ0cy5Q67XyorKD3rUa?=
 =?us-ascii?Q?szIOVLD1EVRzRY1/mnsjjDhxITQd7s5Yau8HWWHh5jqGQGip85tDwzaOaqZI?=
 =?us-ascii?Q?snRRRclnYANPAOntw9dCR/xtQj9T5qmV9gsqC/SdiUZQQOR6f8AICfO+IcqS?=
 =?us-ascii?Q?n9mA16a2vbf8zCih5LGqkkeWJXt7qnexII+lqocYvuI9ldykI1ZB8v3bciuf?=
 =?us-ascii?Q?K72Fy0+Qi8OjbuW+xEqzs3i37X+hujIgZ0D3iUdjGrHno0HV2tcFi8bOWk8R?=
 =?us-ascii?Q?o5WqF2UlOP0TCD9IeoYdCgcUGUh4oRs/6xYJ+Em9EkyDFstqdRyp0w8vOCZ1?=
 =?us-ascii?Q?bb+IBU+GO/2WERlwAVF4FDfFMwiYwV4WnUycXPPdPTK9JR9RHv3qgu3hZzLu?=
 =?us-ascii?Q?nHqVyXAJjN6Bnelyd107JNGO0KTskW2BID1TVtYhLrSsLxZcvbUHz2p2Mwlo?=
 =?us-ascii?Q?fWXR7tcsb5ipCvt7qkhSFgp7Uh7IKgXJVPyxNOvOiWOtCbPDI/rsJuSiCs1v?=
 =?us-ascii?Q?+vWmOSqCGe8Tl0xD5N1M4QNXtUduhYmGINntecJaEpAKb2gdeIJ5kQRwS03T?=
 =?us-ascii?Q?EwZftLbtOBL/iW7yUgBmECOY1Pj5aeXTmHRNi3QI4mUZU1DlpJOCOpB/k5Qe?=
 =?us-ascii?Q?rNWxDNfTlS+1Xs9mnPM5+VC+ZNsxq2ivW1+o6wD2m4sK4BjEv3HyeIq3UhLX?=
 =?us-ascii?Q?ut5QrO4KOuoqCtgwG43/QSgbeywQy5Q8O6ktrdWJamDY7XlPigctwDbPYHzn?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c6ebe5-7e8b-4ba9-6c57-08dd6aa6ba35
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 07:37:27.8799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n41E34JjlXGkxTQ+kRJ1Op/bO9jauZ8jz7qhM3IctD1utKeneHzKOUn1hMycaYdQbfyVbF9rriGm6agSlYR3hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7940
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:stack-out-of-bounds_in_intel_detect_tlb" on:

commit: e114ca069e278f250be2b7bc49b2679dc5da4a95 ("[PATCH v3 22/29] x86/cpu: Use consolidated leaf 0x2 descriptor table")
url: https://github.com/intel-lab-lkp/linux/commits/Ahmed-S-Darwish/x86-cpu-Remove-leaf-0x2-parsing-loop/20250319-203156
patch link: https://lore.kernel.org/all/20250319122137.4004-23-darwi@linutronix.de/
patch subject: [PATCH v3 22/29] x86/cpu: Use consolidated leaf 0x2 descriptor table

in testcase: boot

config: x86_64-rhel-9.4-kselftests
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------------+------------+------------+
|                                                   | bf82706005 | e114ca069e |
+---------------------------------------------------+------------+------------+
| BUG:KASAN:stack-out-of-bounds_in_intel_detect_tlb | 0          | 12         |
+---------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503241523.6b53646b-lkp@intel.com


[ 5.001760][ T0] BUG: KASAN: stack-out-of-bounds in intel_detect_tlb (arch/x86/kernel/cpu/intel.c:698 arch/x86/kernel/cpu/intel.c:688) 
[    5.001760][    T0] Read of size 1 at addr ffffffff8a607e80 by task swapper/0/0
[    5.001760][    T0]
[    5.001760][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.14.0-rc5-00152-ge114ca069e27 #1
[    5.001760][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    5.001760][    T0] Call Trace:
[    5.001760][    T0]  <TASK>
[ 5.001760][ T0] dump_stack_lvl (lib/dump_stack.c:124) 
[ 5.001760][ T0] print_address_description+0x2c/0x3f0 
[ 5.001760][ T0] ? intel_detect_tlb (arch/x86/kernel/cpu/intel.c:698 arch/x86/kernel/cpu/intel.c:688) 
[ 5.001760][ T0] print_report (mm/kasan/report.c:522) 
[ 5.001760][ T0] ? kasan_addr_to_slab (mm/kasan/common.c:37) 
[ 5.001760][ T0] ? intel_detect_tlb (arch/x86/kernel/cpu/intel.c:698 arch/x86/kernel/cpu/intel.c:688) 
[ 5.001760][ T0] kasan_report (mm/kasan/report.c:636) 
[ 5.001760][ T0] ? intel_detect_tlb (arch/x86/kernel/cpu/intel.c:698 arch/x86/kernel/cpu/intel.c:688) 
[ 5.001760][ T0] intel_detect_tlb (arch/x86/kernel/cpu/intel.c:698 arch/x86/kernel/cpu/intel.c:688) 
[ 5.001760][ T0] ? __pfx_intel_detect_tlb (arch/x86/kernel/cpu/intel.c:689) 
[ 5.001760][ T0] ? numa_add_cpu (include/linux/nodemask.h:272 (discriminator 2) mm/numa_emulation.c:560 (discriminator 2)) 
[ 5.001760][ T0] arch_cpu_finalize_init (arch/x86/kernel/cpu/common.c:862 arch/x86/kernel/cpu/common.c:1999 arch/x86/kernel/cpu/common.c:2409) 
[ 5.001760][ T0] start_kernel (init/main.c:1067) 
[ 5.001760][ T0] x86_64_start_reservations (arch/x86/kernel/head64.c:503) 
[ 5.001760][ T0] x86_64_start_kernel (arch/x86/kernel/head64.c:445 (discriminator 17)) 
[ 5.001760][ T0] ? soft_restart_cpu (arch/x86/kernel/head_64.S:459) 
[ 5.001760][ T0] common_startup_64 (arch/x86/kernel/head_64.S:421) 
[    5.001760][    T0]  </TASK>
[    5.001760][    T0]
[    5.001760][    T0] The buggy address belongs to stack of task swapper/0/0
[    5.001760][    T0]  and is located at offset 48 in frame:
[ 5.001760][ T0] intel_detect_tlb (arch/x86/kernel/cpu/intel.c:689) 
[    5.001760][    T0]
[    5.001760][    T0] This frame has 1 object:
[    5.001760][    T0]  [32, 48) 'regs'
[    5.001760][    T0]
[    5.001760][    T0] The buggy address belongs to the physical page:
[    5.001760][    T0] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1ab407
[    5.001760][    T0] flags: 0x17ffffc0002000(reserved|node=0|zone=2|lastcpupid=0x1fffff)
[    5.001760][    T0] raw: 0017ffffc0002000 ffffea0006ad01c8 ffffea0006ad01c8 0000000000000000
[    5.001760][    T0] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[    5.001760][    T0] page dumped because: kasan: bad access detected
[    5.001760][    T0]
[    5.001760][    T0] Memory state around the buggy address:
[    5.001760][    T0]  ffffffff8a607d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.001760][    T0]  ffffffff8a607e00: 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00
[    5.001760][    T0] >ffffffff8a607e80: f3 f3 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.001760][    T0]                    ^
[    5.001760][    T0]  ffffffff8a607f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.001760][    T0]  ffffffff8a607f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.001760][    T0] ==================================================================
[    5.001775][    T0] Disabling lock debugging due to kernel taint


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250324/202503241523.6b53646b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



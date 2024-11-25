Return-Path: <linux-kernel+bounces-421207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7FE9D87FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE505291062
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633F61AF0DA;
	Mon, 25 Nov 2024 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4T8ni+9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9CE1AF0C5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732544971; cv=fail; b=iDZgmP90XDdjOf+5FJlX9wLIYgZs9fs+JkvYtqzxHW0HxWzTD0gyeDSqISijQhYrKxKC4AzY2zZBpIJaScK6GugXf4KfBFUndFIjkIe8kj/1f/79wGFZvJNzF7qLHENjTHVMgC+y2Cw1C+qGUkGtYFQEeeWC0pSnwbFYFj1/7l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732544971; c=relaxed/simple;
	bh=BPt8/sSyNOQlrgUetGci5dMSQ8CMsTbfU8cBcKdCi+M=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=rcKZlR0c9mlfQ5nHjSGBnGZ8dq7wHWLvZeF4cxOERk2RnQOi44fit4ZuZp+pU7GPBVHn6e1+fykILE7ySykXxhshXpX3LGKDrydUB7LNKgrCzXYutxYNTGO1q4Hz6mUihCJX02Ql6l721ONi5YbViOsCZai2D0IH8GzJrRbciKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4T8ni+9; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732544968; x=1764080968;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BPt8/sSyNOQlrgUetGci5dMSQ8CMsTbfU8cBcKdCi+M=;
  b=H4T8ni+9EnviA4qwBc1FnKx0JZk4+Q/LKtCNERNAucYmGTtwZgMVmjTk
   Y2df3TDn59AJfTAsQO5VGWnZkgMHKjQPRG6+l8QWTaMpr+McDaJM/DJNg
   g5h2vAeXluSdh0D9HT+lF1w24dTNB+dbXFHWbiYMr6dWQptTiwZC6zwn+
   /OdsVdRZZKGRv8MoN/ywK2VaEu3/0VzWNxQPdlM7IW32FRPKrMgFfHnLc
   VgzSBQGlNiFZjZ09BFR9zrhLMhgSkZXTDUA4JCE/x7dimMvRm2aYLWYtj
   vlgy9pndy9YG0LIluUTOhq9h2m7p6pG41yD4Tvw+7AMJQViJOBBcKU12A
   Q==;
X-CSE-ConnectionGUID: ViMZcdurTXOdkNbZOua++g==
X-CSE-MsgGUID: o9CRtFRYQuePFqKRs70h8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="58063139"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="58063139"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 06:29:28 -0800
X-CSE-ConnectionGUID: tKvdIxvBQTSnvYQmtr6g+A==
X-CSE-MsgGUID: A1OwTzrISv2ETKY94rX6dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="128804615"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Nov 2024 06:29:27 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 25 Nov 2024 06:29:26 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 25 Nov 2024 06:29:26 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 06:29:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2WCpjgGPsk1+986lS13vw++3/TC7h+GSAogLE/BzMANEBQawu8oz+eWWU9brmSue+QwoijEbJQ4TBOKK5xO112H1woRdghSKvCFPi7but/VszL5aMXG7Oraq7ST2/gVBN4hf1JEXbM+FZDB8+ZS1KOQRoYpClBgxJ3WW18SmXRaZFQi7HOVcISVxCBAAQK8CAT4MkBt6k29HgA2nH9eLsPepJmkNH7u0G7AeP/CIMJnZRK/fiZ7ARZivFRZkQVZoPPnzjuT0JyvpgYMitv6nJJfBr0qK4yy+gL4JLtMc1Ho4k6X7Nhk4nmprNMEzsYch04lmrjCBqStQOHLQ/1bkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKZf+Y5vaxIoW/G+67RRTf7hWgrIWkvP0gohm9PaGJ0=;
 b=Uoji4P3IaubFwKoflqQfsG3zmLbdxsXORwtfe0RfMJd+awkcrmVMShbCrJVSnUfuhEnMtnO4vVM6B8Ui3DpZFjm76f9bk6jAzBkYob+SxxbWOrQjAg7J9S3QF0sdWgrkwfFrdPvl4qiZbU5PZ4J2P8Tafce28GkoJYKr4S2FUNikU1Hw2rXRZnq2hzT+l38Pet9MmlIODaE2h86X0ZItlJLfyg4PZplTVTyQpYtvw4cXYoUB5u7epB3TMmO9wtop9mirwYRsBuc2y4dpsPH7uDELjdt3GgQgsYqsHKm6caqo6c55TGMlGRLax6h03JIGXLOfZE7ZBlhTgAbGE/guHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB8105.namprd11.prod.outlook.com (2603:10b6:510:254::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Mon, 25 Nov
 2024 14:29:18 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 14:29:18 +0000
Date: Mon, 25 Nov 2024 22:29:09 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, <oliver.sang@intel.com>
Subject: [linus:master] [sched, x86]  476e8583ca:
 WARNING:at_kernel/rcu/update.c:#torture_sched_setaffinity
Message-ID: <202411252253.e39d77c6-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: bf06d648-4926-4793-3fe6-08dd0d5d8ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h836qcbCnIsvCXvjNas5gA+97lVODKJAdmtrV4lO/6CmNMQF0ccbzLEPNxj1?=
 =?us-ascii?Q?1LzoIVBQafbmNUXxwQ7nihft7JB1H77B+mS3J3udlSSnwZz/XRToAbgvLe8r?=
 =?us-ascii?Q?StYT5cPcf4juueKzHJoi/Ugwblew+VDsWJ1OCn3211aFOJ/XtyL0z/e9kXjG?=
 =?us-ascii?Q?sd5117/45elFfLkfw0C+CiWjM3h9rT8zhESz/kU/0/97bLqd49XptTYb6brz?=
 =?us-ascii?Q?r8YcjmIl51k4Zx02fVv3wD8a3lMLKBqoZGaRXVyU72GjYvB0shv+mFX6ivHL?=
 =?us-ascii?Q?oDzdAuLADRHoORKknPyl1hlTBJ4Y2bgf2C92T6jgCqGMdquKnNH0vw7/b+H0?=
 =?us-ascii?Q?6yCapNuSkMUj0kD4Lg1XxPrvtUMK1pPG435HpNzt9gR9Nrh6nBJsGP6hmrUT?=
 =?us-ascii?Q?qZDHSTKgbV+ZgwcoB2lA6IZ0SWb2u+RnBkpdDqr0rL0462CjdVhFy6p5BFNH?=
 =?us-ascii?Q?jQBhbz7myrs4BwwxgxJ0qFxEl1rze3gjIJMIy/4P2wcs6l8DjCKQv1ktjAjt?=
 =?us-ascii?Q?I83BYVZ2fyUjzmx/x5liGAjQ21KFF8Tqh2RLDJyMCwqXbMO4nMdLa9s4QwAn?=
 =?us-ascii?Q?x/76vmy2EWV2uKx1hsFqlmhviPPn2pZedSEJzmz+0y3108RG6icnk8JY2B+r?=
 =?us-ascii?Q?fuQCWFPNNQyUXUG2yaaE5X3wDW9cz1Ckef1ixCjVKeHF+kZ7hh2BOFE2ZCLK?=
 =?us-ascii?Q?XE/hXyzvfotYjVj87sNtIG8BDx56cGx7SeE68hi/0aGul2Fo3VajEWGReQyO?=
 =?us-ascii?Q?UE1I3lQub1y0GFZ1f/o8vwCHHVVfOoMOYVfWHadum+eaAGXKG2G9k4ytHHG9?=
 =?us-ascii?Q?1EaaCIfalZF/i5y1LJNopNt1XA99VwyBansijP8QVpJfVBKQnCyu2isg69/7?=
 =?us-ascii?Q?VKdvToxTcvFyXKluGC2FlNPNZ1IuHH0H/gDafDwHbzDSRpCoxZTwa+YOjLO2?=
 =?us-ascii?Q?kMGKvhIoVsJ4v5wFFCMD8+58N1EKgDjaUNyGRQ/cobFFSo9+G3EU2071ZkWk?=
 =?us-ascii?Q?/K8YXyhWOXhGAOhei0eNj9GccpKsBEQWo8Lib4cN5Xj/WgRZSmuI8mefG9IA?=
 =?us-ascii?Q?Nu2K8suU9C02VEXgP7I+gZGEQDEFVEjnhSg4v51wKd0FQR/KSoMpFpNvylWm?=
 =?us-ascii?Q?Rhn+su+AWA9kYUALf7J4fxUnrFYilZ4H8OYCfCso3Nq4nCVEYO7Hvl/hUQB6?=
 =?us-ascii?Q?MEXNpDftRlVdgN04yAQuH2a68MM2Uwoo1jKqkBJWKgn7WNB1Aeol+nRr5xpj?=
 =?us-ascii?Q?AJwxQBsAcu5vykFm/+4a8u/+aiNY7+socVZ1/a/kaMippkw0mROEjA4jlx+p?=
 =?us-ascii?Q?mdJFwI/GNbNY6hKPPv6Ngenr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QolmuOr1S6yTQEEw7gzo7GRMbMiwAQTbrCQuM+PkwysIjzXIzIVKG+cE7eV5?=
 =?us-ascii?Q?9OprtCKWXYe+kSKYdGTlwgV0E7nQgmncUlJzefpJoWYkDL3t0kPBBjPmJ0GU?=
 =?us-ascii?Q?xeVcPDF/2urLqBiU9RukBiwxFJ54v1SPzhY1jg+LDdGy34oBsjBNfWmTSYmn?=
 =?us-ascii?Q?1gZ7fKzWXc/gxF2/41ZffGSz9H9iGHsbAgj4yt2dhoC0DOyTEWh+00rkKi1E?=
 =?us-ascii?Q?HF7TTLfmaCKqKxli+cokVcm5YVzfkKFn8ZonFgfuJP7ONFWrh3zOpM+o4tI8?=
 =?us-ascii?Q?JuQbwKTv2KGcuqXwL+6Xj7aS/EURv+h1ARvu6pn+SGrfHthe7JJzBZxAkTA3?=
 =?us-ascii?Q?iUMl6FM1Llykx7Vst9Gboqi9cC/spNVbiPqcltEk/0ZvBE7VSDO3VtTG9Twk?=
 =?us-ascii?Q?wH8BPgTEqwHX1i2uJ2dI0iM6JNAbDo3idGkua74tupLCh5TPO11ERNCWaduX?=
 =?us-ascii?Q?06lG488N/PAUKfKnJr7Qg9JmH6FJRMDSJb7SvCj7azxHhwek06nNoYUA15cc?=
 =?us-ascii?Q?ISsq7CD2DZTpIohf58RHxLfkaii6TKbH9q8YFYWuF2UwLERg9olvoKFnWK5G?=
 =?us-ascii?Q?+JbqF6xzkI4v01LshDED8g4JYssMXRI4p6ysV2csPl6oPRHMrBihtqbIgXST?=
 =?us-ascii?Q?LvKCPnNZuC1MqWkl2Na7cA6Y4JaroFJN44zLr1o2R0s9fcJzk+yRt7+MheeN?=
 =?us-ascii?Q?PmcFrFJybpwFvzgylfeorpk4T52MMo8831Nc6p7/wdQl0x0laTaDXMTsTIQo?=
 =?us-ascii?Q?h9SvgnNstKPsba+BXJwtZzb4vwWoSmONmfXN8Z5q6XtSAPtovKPX872R1rnE?=
 =?us-ascii?Q?8zPhbK9shXkynrn/sDvNF1+9jSI+1WsEg0lwhmotDEB8HnQaIEYQQudtPMJL?=
 =?us-ascii?Q?PaYAfv+RqFNm7O8Us32j2I1/rq+xz6+53r/IxI8DpcC6+Q0vYEQiImaG90+9?=
 =?us-ascii?Q?t7QqkvtklYf3k3Tv7oqp1yYbEnV5CdCANaz4wAN1/aySc5Qmv8Nl0kTmnviG?=
 =?us-ascii?Q?2LmvZEuKE5jE4ULlmHlcu4kPHZPRbgSlTax0GtUGQZt39qK5xOGJPaEkNyAP?=
 =?us-ascii?Q?pS0DMu1EFKiU3sJeqTz8z3BOiX8F0PJXE/FRuwXwbTx+UHd8f/U9qRuvC6T1?=
 =?us-ascii?Q?Ru7953/U+gV/MZ+nLalswSoMwrCrKR5WWNc1UF28NK6zVd/+EiJk1IlUgskD?=
 =?us-ascii?Q?QjZAWOuyIzIZXu0IibPCk/pe7PKwpiXWkL24cbOw32c1Yff0PBJsv35BzU9L?=
 =?us-ascii?Q?RG4vPX4rEH7zoIqfmzsMwdqZG5SHo5+lsdBFz0KCNbP1U3UxLG/Ao4D1tzv1?=
 =?us-ascii?Q?ek6p43f2+9hGpjCmDJnFXpQKnA0H188AovGlK83YheTkuzR62b8WETu5dslC?=
 =?us-ascii?Q?qawFQsFh61+0aaHY5eEu4cpAMSyan6Q3bJ5OzKQcucUXIU9alacxK34XMRD/?=
 =?us-ascii?Q?iGc93fkvSAu2KvvBBlQ1IjwRsKA3XDzgN5qnsoZalga1UbmNiX3iqx4laz6E?=
 =?us-ascii?Q?PsRyutGoPMHUhc/FwN1Fe7fQDxypVOKV2ZjTui1Wg8efAHHDQBlVCWns8HrE?=
 =?us-ascii?Q?PSws5a88jb8D7yECXnP28+OEXMuiF57boiztZ2xWs97ousebfU7pw7Fws/KC?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf06d648-4926-4793-3fe6-08dd0d5d8ba5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 14:29:18.4337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiF93WgXAj7EMmNyPatNjdYmsVZjc88dFxwPkv/4KZBO3ULV2pFh6nui1upUeW7OuyGuUyobIOAv8kWqIjUrMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8105
X-OriginatorOrg: intel.com



Hello,


by this commit, we see the config has below diff:

--- /pkg/linux/x86_64-randconfig-161-20241120/gcc-12/35772d627b55cc7fb4f33bae57c564a25b3121a9/.config   2024-11-22 17:03:32.458344665 +0800
+++ /pkg/linux/x86_64-randconfig-161-20241120/gcc-12/476e8583ca16eecec0a3a28b6ee7130f4e369389/.config   2024-11-22 17:02:59.440805587 +0800
@@ -121,9 +121,11 @@ CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
 # end of BPF subsystem

 CONFIG_PREEMPT_BUILD=y
-CONFIG_PREEMPT_NONE=y
+CONFIG_ARCH_HAS_PREEMPT_LAZY=y
+# CONFIG_PREEMPT_NONE is not set
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_PREEMPT_LAZY=y
 # CONFIG_PREEMPT_RT is not set
 CONFIG_PREEMPT_COUNT=y
 CONFIG_PREEMPTION=y


and we observed the issue does not always happen, but with high rate:

35772d627b55cc7f 476e8583ca16eecec0a3a28b6ee
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :47          70%          33:48    dmesg.RIP:torture_sched_setaffinity
           :47          70%          33:48    dmesg.WARNING:at_kernel/rcu/update.c:#torture_sched_setaffinity


below is full report FYI.


kernel test robot noticed "WARNING:at_kernel/rcu/update.c:#torture_sched_setaffinity" on:

commit: 476e8583ca16eecec0a3a28b6ee7130f4e369389 ("sched, x86: Enable Lazy preemption")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      fc39fb56917bb3cb53e99560ca3612a84456ada2]
[test failed on linux-next/master decc701f41d07481893fdea942c0ac6b226e84cd]

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: trivial



config: x86_64-randconfig-161-20241120
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202411252253.e39d77c6-lkp@intel.com


[  150.797530][  T445] ------------[ cut here ]------------
[  150.797915][  T445] torture_sched_setaffinity: sched_setaffinity(445) returned -22
[ 150.798353][ T445] WARNING: CPU: 0 PID: 445 at kernel/rcu/update.c:535 torture_sched_setaffinity (kernel/rcu/update.c:535 (discriminator 3)) 
[  150.798909][  T445] Modules linked in: rcutorture torture ipmi_devintf ipmi_msghandler joydev crc32c_intel polyval_clmulni sha512_ssse3 sha256_ssse3 psmouse pcspkr input_leds led_class evdev drm drm_panel_orientation_quirks efi_pstore i2c_core dmi_sysfs qemu_fw_cfg aesni_intel nhc_udp nhc_routing nhc_mobility nhc_hop nhc_fragment nhc_dest
[  150.800845][  T445] CPU: 0 UID: 0 PID: 445 Comm: rcu_torture_wri Tainted: G        W          6.12.0-rc4-00032-g476e8583ca16 #1 2d4e54818569ec14d7868b657e3682f49dc47408
[  150.801671][  T445] Tainted: [W]=WARN
[  150.801886][  T445] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 150.802444][ T445] RIP: 0010:torture_sched_setaffinity (kernel/rcu/update.c:535 (discriminator 3)) 
[ 150.802909][ T445] Code: 11 06 00 75 e7 89 c1 48 89 45 f0 c6 05 9e 73 11 06 01 90 48 c7 c6 a0 07 0e 85 44 89 e2 48 c7 c7 00 d9 0d 85 e8 88 86 e0 ff 90 <0f> 0b 90 90 48 8b 45 f0 4c 8b 65 f8 c9 48 98 31 d2 31 c9 31 f6 31
All code
========
   0:	11 06                	adc    %eax,(%rsi)
   2:	00 75 e7             	add    %dh,-0x19(%rbp)
   5:	89 c1                	mov    %eax,%ecx
   7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   b:	c6 05 9e 73 11 06 01 	movb   $0x1,0x611739e(%rip)        # 0x61173b0
  12:	90                   	nop
  13:	48 c7 c6 a0 07 0e 85 	mov    $0xffffffff850e07a0,%rsi
  1a:	44 89 e2             	mov    %r12d,%edx
  1d:	48 c7 c7 00 d9 0d 85 	mov    $0xffffffff850dd900,%rdi
  24:	e8 88 86 e0 ff       	call   0xffffffffffe086b1
  29:	90                   	nop
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  32:	4c 8b 65 f8          	mov    -0x8(%rbp),%r12
  36:	c9                   	leave
  37:	48 98                	cltq
  39:	31 d2                	xor    %edx,%edx
  3b:	31 c9                	xor    %ecx,%ecx
  3d:	31 f6                	xor    %esi,%esi
  3f:	31                   	.byte 0x31

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	90                   	nop
   3:	90                   	nop
   4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   8:	4c 8b 65 f8          	mov    -0x8(%rbp),%r12
   c:	c9                   	leave
   d:	48 98                	cltq
   f:	31 d2                	xor    %edx,%edx
  11:	31 c9                	xor    %ecx,%ecx
  13:	31 f6                	xor    %esi,%esi
  15:	31                   	.byte 0x31
[  150.803951][  T445] RSP: 0018:ffffc90001d0fc50 EFLAGS: 00010246
[  150.804295][  T445] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[  150.804738][  T445] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  150.805173][  T445] RBP: ffffc90001d0fc60 R08: 0000000000000000 R09: 0000000000000000
[  150.805664][  T445] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000001bd
[  150.806126][  T445] R13: ffffed10298bc638 R14: dffffc0000000000 R15: ffff88814c5e2c00
[  150.806567][  T445] FS:  0000000000000000(0000) GS:ffff8883aee00000(0000) knlGS:0000000000000000
[  150.807061][  T445] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  150.807425][  T445] CR2: 00007fd03312b000 CR3: 0000000101aa7000 CR4: 00000000000406f0
[  150.807863][  T445] Call Trace:
[  150.808055][  T445]  <TASK>
[ 150.808230][ T445] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 150.808482][ T445] ? __warn (kernel/panic.c:748) 
[ 150.808722][ T445] ? torture_sched_setaffinity (kernel/rcu/update.c:535 (discriminator 3)) 
[ 150.809050][ T445] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 150.809325][ T445] ? handle_bug (arch/x86/kernel/traps.c:285) 
[ 150.809631][ T445] ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discriminator 1)) 
[ 150.809907][ T445] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 150.810206][ T445] ? torture_sched_setaffinity (kernel/rcu/update.c:535 (discriminator 3)) 
[ 150.810536][ T445] synchronize_rcu_trivial (kernel/rcu/rcutorture.c:837) rcutorture
[ 150.811100][ T445] ? debug_smp_processor_id (lib/smp_processor_id.c:61) 
[ 150.811407][ T445] ? rcu_torture_read_exit (kernel/rcu/rcutorture.c:832) rcutorture
[ 150.811996][ T445] do_rtws_sync+0x395/0x6e0 rcutorture
[ 150.812579][ T445] ? srcu_read_delay (kernel/rcu/rcutorture.c:1328) rcutorture
[ 150.813133][ T445] ? preempt_count_sub (kernel/sched/core.c:5867 kernel/sched/core.c:5863 kernel/sched/core.c:5885) 
[ 150.813443][ T445] ? delay_tsc (arch/x86/include/asm/preempt.h:103 arch/x86/lib/delay.c:96) 
[ 150.813697][ T445] rcu_torture_writer (kernel/rcu/rcutorture.c:1578) rcutorture
[ 150.814240][ T445] ? __kthread_parkme (include/linux/instrumented.h:68 include/asm-generic/bitops/instrumented-non-atomic.h:141 kernel/kthread.c:280) 
[ 150.814524][ T445] ? reacquire_held_locks (kernel/locking/lockdep.c:5476) 
[ 150.814841][ T445] ? rcu_torture_fwd_prog_cr (kernel/rcu/rcutorture.c:1364) rcutorture
[ 150.815419][ T445] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/preempt.h:103 include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194) 
[ 150.815756][ T445] ? __kthread_parkme (include/linux/instrumented.h:68 include/asm-generic/bitops/instrumented-non-atomic.h:141 kernel/kthread.c:280) 
[ 150.816076][ T445] ? __kasan_check_read (mm/kasan/shadow.c:32) 
[ 150.816368][ T445] ? __kthread_parkme (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/kthread.c:280) 
[ 150.816648][ T445] ? trace_preempt_on (kernel/trace/trace_preemptirq.c:105) 
[ 150.816936][ T445] ? rcu_torture_fwd_prog_cr (kernel/rcu/rcutorture.c:1364) rcutorture
[ 150.817541][ T445] kthread (kernel/kthread.c:389) 
[ 150.817780][ T445] ? trace_sched_kthread_stop_ret (kernel/kthread.c:342) 
[ 150.818127][ T445] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 150.818382][ T445] ? trace_sched_kthread_stop_ret (kernel/kthread.c:342) 
[ 150.818730][ T445] ret_from_fork_asm (arch/x86/entry/entry_64.S:254) 
[  150.819022][  T445]  </TASK>
[  150.819201][  T445] irq event stamp: 230151
[ 150.819484][ T445] hardirqs last enabled at (230163): __up_console_sem (arch/x86/include/asm/irqflags.h:42 (discriminator 1) arch/x86/include/asm/irqflags.h:97 (discriminator 1) arch/x86/include/asm/irqflags.h:155 (discriminator 1) kernel/printk/printk.c:344 (discriminator 1)) 
[ 150.820008][ T445] hardirqs last disabled at (230172): __up_console_sem (kernel/printk/printk.c:342 (discriminator 1)) 
[ 150.820529][ T445] softirqs last enabled at (229700): handle_softirqs (arch/x86/include/asm/preempt.h:26 kernel/softirq.c:401 kernel/softirq.c:582) 
[ 150.821054][ T445] softirqs last disabled at (229651): irq_exit_rcu (kernel/softirq.c:589 kernel/softirq.c:428 kernel/softirq.c:637 kernel/softirq.c:627 kernel/softirq.c:649) 
[  150.821585][  T445] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241125/202411252253.e39d77c6-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



Return-Path: <linux-kernel+bounces-576667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A42A712BB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F7C18980FB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEC919AA5D;
	Wed, 26 Mar 2025 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mkbNyLee"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C4627456
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978114; cv=fail; b=kNKDPRy3jH4EjkFNacVWnksgan5O+Vm2eOvtXBMLYDy3HYv/Eo7hJvyxep2BIfzcTzNV9GJwI9F6bQ2n0ddiTq7eoiXUXrflVXn0+zr/GdMRCoRkGfZpA7il5Wda/lNwAOGJHisdfDl0tvCzXE3sXnfqoujgpUfGf9bbbOWYoKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978114; c=relaxed/simple;
	bh=rdKQcpbQj1cAkF0Pd1z1ziI3H96XXmUXDuz72oQfFR4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B1AznL8ecrPD5214KzlLzyYvZoy7+wQmiRSaktZrB8a4xArw/oI3QbeilAmJO3hc0Ehz5pdBIJF6/zXRSX0/rzKgrPVIFtFfrzy2o9vY9x8GseAobSd90nF03f61UYs1rIO+v2VcYkQIR7TV9bir1oy7uEjGJp8GKUMyyiXqYf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mkbNyLee; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742978113; x=1774514113;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rdKQcpbQj1cAkF0Pd1z1ziI3H96XXmUXDuz72oQfFR4=;
  b=mkbNyLeeeMK1QAHp8d70O/HWhKKp4f8i0PjbK0JZPZ3RYA48LpED4zIP
   +819HDpLiVxyEdZ/2/+KxKVual69gqxuzqCf7c9gsYdeEhUb4Jl4be8j3
   c0h4D7PZZX4WqunZ7i+Ey1sEi+lMtO88W+RQuJiXucOg6bagU+/bjFHIp
   cAZMF0UuKt8axYcvQ6EXYP1TDwd4mZNS8F7Xc1YAjUQYPLaEDeyXTKEWj
   Xxii/2+izB1zyoSzxqBVg/9H+Oa4sq3tWEYfZZRiM8CMPYv/vb5MM3TEW
   yAd6iuSi7GWMV/AYxebEIZTJ3KUpVrI5H2ZQlH5Ze6Atg2PWPXt4TfiqT
   w==;
X-CSE-ConnectionGUID: fbDF40ViQcO9Q1m2J/tEiw==
X-CSE-MsgGUID: Ju6YU2WhQ5yTpIt3j8RK8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="43406502"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="43406502"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 01:35:12 -0700
X-CSE-ConnectionGUID: Ml+7/K3dRa6MY00ioJ4AcA==
X-CSE-MsgGUID: F3j6credToqCxGKT2TDxEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="161887179"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 01:35:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Mar 2025 01:35:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 01:35:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 01:35:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arOMG7MzhjsPO++0nHkSmtwpeUo3OcJmjaQf3+CLCN2PfzjK1YKzPCav0kuvSh664zhu6o96x7u0E2M3TQ21DuOmzWlQi5gcwhqBK9svE1zDj+OOhJmwVLVKd/2yeiuWpy2eB5b6X2AkOWr8OwOKObaASpl06uXoRLtOLAwHpQ+qLDQWlcPYpzo9mlNlqfa2weQbdZzm6/36lFXhyeAJkB5bGm9bER31kpATYECXlF5AaMmbuc68/jdxLYOfi9m0d+W81P06pWOxwP0eZq5cjNp9WMVXv8VK8o+hnHVGAeR5ISN6T2XY7VenN3KAklwJsBgMGb/ek9GTHRQo1TGOTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYUEcwhXyw54GdSP4gCdO6ep9QdfpJn46GurTxZGtyk=;
 b=BuMf53RLiw7kMflcJVcpuwcUqwHHJiuTdtBMrx6zjPBbJkmUrHSKqIERMKYE7+nHKcVphoYa+OlyG5uaJvsLmDpaAcIJxhmRch2vLgab3qmNu47WcbSgN91P0fwpzX7a9dUTqrADah87yteeQqzcoCJ5zFG6q15QdV6lAzRV8psWcAVIWGCEtRTiaNHrhc8GsfsZ806RywTDtbl+4ctw0iA7GVBR9yqXFnMpK2rC9cK6WwE+BYA0GDO31ImnLDPS6bw6tfH2YWqf3fnXxOKb5C3x7H1h62zlXzDvQHhvuZ5UuZifJWU4OfG09qeQ7tQ1ozA559y/0mZ2eEQEoSo8IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by CY8PR11MB7133.namprd11.prod.outlook.com (2603:10b6:930:63::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 08:34:28 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%5]) with mapi id 15.20.8534.042; Wed, 26 Mar 2025
 08:34:28 +0000
Date: Wed, 26 Mar 2025 16:34:20 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<colinmitchell@google.com>
Subject: Re: [PATCH v2a 4/6] x86/microcode/intel: Implement staging handler
Message-ID: <Z+O8DK5NZJL43Nt6@intel.com>
References: <b01224ee-c935-4b08-a76f-5dc49341182d@intel.com>
 <20250321211909.13927-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250321211909.13927-1-chang.seok.bae@intel.com>
X-ClientProxiedBy: SG2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:3:17::13) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|CY8PR11MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: cb28ccda-eac5-4815-206a-08dd6c4105c1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WLwySIkDQOMtXjG0kyZbPNxm3gc1xkmGiqLM/YWTv4mEG/Dv5UY5E8LS9GSD?=
 =?us-ascii?Q?w5WkP2DoorNxFaeAtRKVZfPyfLjCjWwt4wcZsHw1SgraoskDp7P64gjKabH4?=
 =?us-ascii?Q?wOiCV+TJdQCEXjv4rvKwl6SXgNujGqg0agUqYw6KcfoMP7ngVbfZsuYIYX0d?=
 =?us-ascii?Q?upN/zx85Rsx00ejhFReX50pnu4oK18IAzoDw4ZuTnwQJx5m7/HapBm2eFrvj?=
 =?us-ascii?Q?H+FlwRbA3I0jler30Xn88Zurc2U02jaoCseQt+E/sVDLuSRSxqxagse7ohaJ?=
 =?us-ascii?Q?Ucr0nx1cVPGE8vheWzoJRZF2m50r7wNNTIS2SfTmjFJeOEnaw5S2L0Kn33uf?=
 =?us-ascii?Q?Ffm5A8egjwDp6fjtgCWZfGq8jYr+JFV9Q1UD+jNkaUSyg4nQQTAAVmCE9/BR?=
 =?us-ascii?Q?a15YbNFEckhZzEMy8Mw0laBZ98duii5jQy3cEk3/Tk6kDsLhOKnL93c84gco?=
 =?us-ascii?Q?Y0UQo7F3Bq8nDuDbB8eLxN1vhxaAvKEFFA5S3Mhlc3zZXe49sbkrrD9gJ6NH?=
 =?us-ascii?Q?xMKZ9JWVO2oe7RJMJk7juSuPzBTTWxeXStTPgWHsgpNgJK4b3PMjd9JwxR3J?=
 =?us-ascii?Q?CDKC8vy4OO3rwxNMUr2BYL217Ei4wquYzwqOjkDkhd9Qan5tsv/7qMW9nDB7?=
 =?us-ascii?Q?ht8UWS54/YV/pkItYVU1cKHuy0Zpk0uudPsAURkiwemhlkYxbj9H6soHIYc+?=
 =?us-ascii?Q?TjFkOJz2QqcbPQz5EeTHMfPO/xTNE9V+jMmMSWMXNMvlf4uVFMfcjX1vpBO3?=
 =?us-ascii?Q?iGrGza9TC5rYTnkuLO741PsOx409lsBby0g5yDEyI4C0R3/L3rKI+zaZksAf?=
 =?us-ascii?Q?vz+PRATrJV7DYJcNg7hIDv5O/7hHl/M09Zn+I+5ZCp0m7gQSiMaP/E7+HaVE?=
 =?us-ascii?Q?JPSulPwbwvu0AbpWU1XzLQ65ic5+ZkNLDQ2tGFBvTHJKGl1LoocM/n4tYYWf?=
 =?us-ascii?Q?0gMmyrJ1maOSRbO6jXRSVsTUUHOvTDsct5Ni+0qcIskzdg2idXdGUKZ7jY+c?=
 =?us-ascii?Q?w1cvXXbpYZoNWh8mC/rGqd4QnpC20QZJwuDQ6Say4Ayx5S0tmOH+iz2687Ur?=
 =?us-ascii?Q?otXfUkYVmpOdP5WRybFGfjF++yQHOAnJBsfwRwGHLd/Idu2gIz7O3UHHvNVf?=
 =?us-ascii?Q?QEZaH9pDxOxEmDYaZn1qVx/u1TsXL50HCExG9x9Mlicm02Uu01E/euj55NVP?=
 =?us-ascii?Q?pbfv4J1UVT7Qkxr42TIhRVh4JJZAVviYv2mpiMkWm8b5XMixbJF1BbRiyUGp?=
 =?us-ascii?Q?z7QBHGFUXykei9cT+Alj3UauDZz73Rbie6h29ZTK2TlfVkKdSw8/oSUxDLP6?=
 =?us-ascii?Q?ChpMOTkegz5L/OF/qrdTOt/RdktP8Jxgk2IqCixRVqZh8IFKNBzYOCzkvddP?=
 =?us-ascii?Q?7GG5Qmy8IBaAY8cu4CJpwS0XRz/T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jUhY3u8z+c7j3R0JS6XcwrmTErxFelFH2eRz+8VwcAz6zAFtp5+O2E0uFUo5?=
 =?us-ascii?Q?lmHgNItheomjgZ/ONlgFdss3VyUzcvAV2GXsL5M4rD1IdAiuGY29ECakx37b?=
 =?us-ascii?Q?CgaBqrqFfYqRCR17w4J2WTzRvyDq23w2R/+6JSrYDmC+s2Of7IjbJ1eLIcPR?=
 =?us-ascii?Q?jAG09d6mSvXIXEipyhTP1LhFh//sSbuH3MPgRuQaYpcgYbEvWNRLOi1PB3fL?=
 =?us-ascii?Q?js/ASue/EjChyn/PzhYWO8XGFcw2erBkHglUeIhPjVGwrEK39enrXpqW/hNK?=
 =?us-ascii?Q?G/tHVefnPuUCQtO+iMGS3Rme0ex9jGLGOeLMbTSIN2/0oemdKmNvJ6KsCzt7?=
 =?us-ascii?Q?GCis/FqnTh9y73cD95lw7QRZGZ0zyj3gck18V5aIJQ4W6E4XHk83/5fF2Ohy?=
 =?us-ascii?Q?rwtbtDH9IPoLjp4bsCjl+iVJcCA9tmdXCmpQwxsVLLaiM4hSXT6S03IDBsBu?=
 =?us-ascii?Q?X+46ZhrvoSJF8S7a8xyt+lwa/AmZ8HxpHrYvNIkj4ZDe841qPXevZkz0vOvI?=
 =?us-ascii?Q?TnUDQuU0+h9AmALT+Tkh0eL3WUbrIxJ6Ko8hL+oiES62Bp5m19clhyP1BKHx?=
 =?us-ascii?Q?MHE65NR89PkC2aRD3pQB7V/bUS14hhoAzvuOW4bFqsXlx9ltN9Dykj0rcwoF?=
 =?us-ascii?Q?Gmwohl174WZ4+a0Uwos3pc51dqbGB8HcwkavYZgcJ0pURVhRdb61jGRCXDSN?=
 =?us-ascii?Q?uiSFK3edQNXYVkU2VWYFHhZEu4QS0JcayX4p0jjFrCtAlEBBe5T0sg9fgELQ?=
 =?us-ascii?Q?3jDU5hZrG5HNddF2FlEtYOLW31GPl+FwqDlkoaZt9NZam5dmEVSw76DU/Eun?=
 =?us-ascii?Q?DEURNp6mGaiRjjvS/kn500wxKz+bnuYnFKoa/6pBJunKmm8zmx/TX0YZeClu?=
 =?us-ascii?Q?nf3K3kkGosWWvv0rZ0HKvNVLYBSYQEDQVPsWNjjAuyJWw8yU6/mgSppPntrO?=
 =?us-ascii?Q?pXnSOZngwJUXZ1OmYHdJE32JrzieXoZbvtvX2EntI1ZZyxWGBh6LN0yhwlFk?=
 =?us-ascii?Q?6Ep6QVibroCGcX8PIT+ar4B734oJWYz9V5HGN0WCqLrxjSgIan+5JHy3FiNd?=
 =?us-ascii?Q?y9RLfoB01BFZXDZ6zELtR5o8r4GkeL+kQ88M4H5VIZuRwQtc3h8mnttT5juk?=
 =?us-ascii?Q?6CpINCen45dIsbiG7F1ftt+suRSmjRQsmCrnKmOoFSgGltgQVkKQ48YLLEj4?=
 =?us-ascii?Q?R0/+ah3UHaoNzE6zZbHX59VA72AaK8rQ7/evz2fTZzOSo/l8rEiNYM4HmllA?=
 =?us-ascii?Q?8a225Wey6afZ4+kTAn9xfP2wDooWlUkf0mJ82zDv04ZV3bQbjbuxYSPLqRzf?=
 =?us-ascii?Q?0ecV3CD7quN9voKQMUt13Vj0vnMjfrxEf3bDhv/g4xnC793F+SNvRzoMCj45?=
 =?us-ascii?Q?hRmg+TMc/4SN9JOMZpqg/DLlMHC/l9JshteMyrF3ZGsnVSupEZz+xbOM7ZRV?=
 =?us-ascii?Q?9TubxoNpDphexfwxaF+uyubmoc+N3+UK901S9zUFfky+tb1yZSi2GvPsHg7A?=
 =?us-ascii?Q?uX2zmvgCtW6jU7054ko4L5Zs5yVQ1jM/OcV2MzwN1CY4M/xs+8ypUD2bRk6n?=
 =?us-ascii?Q?6TQ2t7jzL7figCZn646z8r7Nr9uPXFUnVESAenUo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb28ccda-eac5-4815-206a-08dd6c4105c1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 08:34:28.4258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LBHj1XHjuAUtj5i5v9AH2iLipl4KWpfrRsnirktnIFuogCK3LvIg+TQSvtEzug9HkmQu/PJfasBRSsKXAs2XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7133
X-OriginatorOrg: intel.com

> /*
>- * Handle the staging process using the mailbox MMIO interface.
>- * Return the result state.
>+ * Prepare for a new microcode transfer by resetting hardware and
>+ * initializing software states.
>+ */
>+static void init_stage(struct staging_state *ss)
>+{
>+	ss->ucode_ptr = ucode_patch_late;
>+	ss->ucode_len = get_totalsize(&ucode_patch_late->hdr);
>+
>+	/* Reset tracking variables */
>+	ss->offset = 0;
>+	ss->bytes_sent = 0;

Nit: no need to reset them, as

>+	struct staging_state ss = {};

in do_stage() will zero the whole structure.

>+/*
>+ * Handle the staging process using the mailbox MMIO interface. The
>+ * microcode image is transferred in chunks until completion. Return the
>+ * result state.
>  */
> static enum ucode_state do_stage(u64 mmio_pa)
> {
>-	pr_debug_once("Staging implementation is pending.\n");
>-	return UCODE_ERROR;
>+	struct staging_state ss = {};
>+
>+	ss.mmio_base = ioremap(mmio_pa, MBOX_REG_NUM * MBOX_REG_SIZE);
>+	if (WARN_ON_ONCE(!ss.mmio_base))
>+		return UCODE_ERROR;
>+
>+	init_stage(&ss);
>+
>+	/* Perform the staging process while within the retry limit */
>+	while (!is_stage_complete(ss.offset) && can_send_next_chunk(&ss)) {
>+		/* Send a chunk of microcode each time: */
>+		if (!send_data_chunk(&ss))
>+			break;
>+		/*
>+		 * Then, ask the hardware which piece of the image it
>+		 * needs next. The same piece may be sent more than once.
>+		 */
>+		if (!fetch_next_offset(&ss))
>+			break;

why send_data_chunk() and fetch_next_offset() return a boolean instead of
an error or ucode_state?

Using the return value to indicate just success or failure, while relying
on another variable to report detailed error/state, seems a bit clumsy to
me.

>+	}
>+
>+	iounmap(ss.mmio_base);
>+	return ss.state;
> }
> 
> static void stage_microcode(void)
>-- 
>2.45.2
>


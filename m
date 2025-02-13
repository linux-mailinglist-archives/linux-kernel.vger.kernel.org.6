Return-Path: <linux-kernel+bounces-512699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6DCA33CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C880E3A1BB4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EAC20E30A;
	Thu, 13 Feb 2025 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HcH6ThC6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207602063D2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739442694; cv=fail; b=m7G1gtmjbb0gU6LUnpnCoc6nb1Yt7Qa8ex590Mzsp00DKPpXbA5rifBzpHnpw+2674wpsOiA7kxy5wcXTDtgXIZOa9191USmDsaeQ6Z8SD8Sk07dte1qMxL7KoJa9sZ1sjNc8VMj5ylZbjGzJZVtsKGG0uto4Q6vELYi5813zKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739442694; c=relaxed/simple;
	bh=SNoFRvNDQ44lZ1DVRo5tPzilHjsHwTkxjgit4TklWk8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=L4LKzi2aHu8L88TR9K1IeNteCUoODhvr8fQpeV41U1j51Um3gXfDXPTK42X7uwitcR9iNmAFo4d0cboCRnRLwcpkENjLk86MfSJMzc/XLRKlT8/D+Ruh75ANuJv1IGI+IyunZ/bun7Iidy0kAKjdPVEVZyRL/92vG+2mzusIj8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HcH6ThC6; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739442691; x=1770978691;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SNoFRvNDQ44lZ1DVRo5tPzilHjsHwTkxjgit4TklWk8=;
  b=HcH6ThC6RpPehtjJzDgbrKCJmjMMyHqM7OGwXyNH1XgwQMUzkgeCsWqm
   DSPxjnIdBPKtY8tzDz2+8CcAoqd4+rURtfcCqMYXVp9DuvM9cdwt48ZKa
   jjSI1IG0GSrjj/3dVxy1gY48n3vw1XLY4iUUuRlnkhVW0ZQzeL8hm1plp
   meOXAo7tv7tjGxzWYDEDAM2Q+oAkwmX53MO36gQnhE5fQ2tqdo4m2V/Zb
   EpcgPQqYzHuDKA5m915wiBB/n7EtDPjB19O1pxwWGmQE4MUBWtBOxqUmF
   4xroaJGkIh3vll31y9OA8OxZbNUQ9cqlA3wNofjEgX8xtcEDSxlCWiUQx
   w==;
X-CSE-ConnectionGUID: vfOh/ZaUQg+tEYF1taXPoA==
X-CSE-MsgGUID: RB/dfIUkS6eOOdn36LbpLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="40398907"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40398907"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 02:31:30 -0800
X-CSE-ConnectionGUID: XibepaI9SoGrd49nkBx1fA==
X-CSE-MsgGUID: 9ccqBK7pS3yKQnfF4gXkQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="143942421"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 02:31:30 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 02:31:29 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 02:31:29 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 02:31:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWYq/E9MVR2I0sk6/NiRhYatGG1sufDkj8iudWLtw+lNCdSHwi+dbQpb4gt3mCkuD3Oi8eApqc9V2zlWcWseu2eHAUXCsE/aPXXmTbGzzj7hctlXjbb5jkNANbbY1wH+DeOUOtgM1JQ9iRnMCPMC2eyhuSq1GhvSh9xqGeuDoS0sY8QHsx4oInrbiYFqydGK2RCNb5uTr+VSyV20RjKNdySqMwd0zPhF7Yxuy/1iUw2BPllKUSDIpClV/ADO6Qx6Qlb7Z3X3HCutd6DtH6uYilr74Md5yrDBRDxycQDajB+/SK+6gaO3AMHqIGb/5v0tj9qxW2ZAWespo0XwZcO+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=en/AJbOrxcNI5ProPh6jKo718R9X2sLdNJAbUPFZxhw=;
 b=WGpuLimzkSCVJrioQU2HyZ8qIqXwb8zkwZ6OFgTSX9bZ1sEdEcyOkxE26xHxeM5jO9I01ZzwYMLXC0smmA2hSU6BKX/J6XFaZiNFOZpYuHWWb93WiGauC8GHuXmwbDCAdyFu7Qc4aABPHanJcMCDlmRNj+w936PMilLuICNyexGjK2ACmXHJWTiQufcZQJ0lZsQJ9JubWGoWvYfb/Dw4iLi7OVp45u8J6GGH8CcbsvxZRwPp5B/T0xtbMnC5u7/ATm3uem7wmxQqLsOl7KnYidcSpfITOhwZJHNvsBWxwqiu31P90Zwk86pr/MCZ7MJSmIcnqgv9KeRCxJtIPUAucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Thu, 13 Feb
 2025 10:31:26 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 10:31:25 +0000
Date: Thu, 13 Feb 2025 18:31:17 +0800
From: kernel test robot <lkp@intel.com>
To: Joel Stanley <joel@jms.id.au>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi:808.18-815.6: Warning
 (unit_address_vs_reg):
 /ahb/apb/fsi@1e79b000/cfam@0,0/hub@3400/cfam@2,0/sbefifo@2400/occ: node has
 a reg or ranges property, but no unit name
Message-ID: <Z63J9Tp8h+uSJ4hl@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|IA1PR11MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f334ecb-95ed-479d-346b-08dd4c1990ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|220923002;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZVPkXVtAIMaqc40Y5cYXsxbed92cYk137yKcLYJidSY0+uk5+kq89E2CsXpe?=
 =?us-ascii?Q?HfH/08UqWfxQ/jFD4UESncHP3QkdHxpVMjMn1U3exnuRS+KX7Mu2ips44uD9?=
 =?us-ascii?Q?efPyV5cLIoeCdjNFjoDaLsKOvO/J4quxS4BTUmD8E5ryZLBXJFp9o6lGyb+l?=
 =?us-ascii?Q?3eI7WnBRZXiFby+E891fGKbCg6wzt8Nb0q4ZmUaIvNG2eJmTv+EajBznX6Gq?=
 =?us-ascii?Q?haPNGkawg5AMbGZ7///Am1yMuj+OqKwyyu9UQiH8aF6V8JgOSNT+SSN/YRSr?=
 =?us-ascii?Q?1DHehjS1YvR/aT4ktSGGcYF0w5VAlT0UCML3qkvjynjLtrSk3UkvU3YtqIXV?=
 =?us-ascii?Q?qhTvVik/6+ug2OdpYmlnmZANpwtCkLqy5Ckj/avXyDLfQCdXIqEelf8394dd?=
 =?us-ascii?Q?1AFFIOqlKD+s6is2t4UxSjB5ElS8mn4seSmvLhRJSatY9VsPQv0XNzta1os6?=
 =?us-ascii?Q?bOyoh3FRKqD4TMtMTZ3IM3cLNb40I8s3n5L+Y9qlOPgi/deUSLP5NAE3AeC8?=
 =?us-ascii?Q?LP8nHXS/fi5I/cBWRhiLn9nM7FcNsIFBkar4wq9846uglMBk5FQoPjVm776q?=
 =?us-ascii?Q?yH0xHJvKc8M98ph2wFXGSVi7+oLkGhhzIvHEszfgfNHRd9LO624QzTJwCjIB?=
 =?us-ascii?Q?rY2RVf+XwzBH/VoIoBbYajP0d/vRnpShp8qUqlr5qFEiccoKJvY4fCRpb631?=
 =?us-ascii?Q?jX8cBTiFFm+XEBfu8LxrA+/dhiXZeIV8F8Yt51xDJ7XZfQTGnW0Lbutt+Xp7?=
 =?us-ascii?Q?gO4GOaeCh3jpHVrRiJkS5LZHNXKOW9d7D9mNxkUhACaGx5h6fOX50W/CQn/3?=
 =?us-ascii?Q?JZPUjhFmCGdevwjqZr3v0fxzdoqu2xLSW9ImJWvmTKr+H9+ynZjzrqbNPvLS?=
 =?us-ascii?Q?GW4Q6rGegxN2KcT39vKWGPv/4XDvvoPme6V2Y8kg4mW5F7nmXLss+GX7B7Df?=
 =?us-ascii?Q?BLOs5xN4ihKP9uT+we5U62ukXSHl4oda0uzrZBYPjeAdEVrxsjV80SkeMaeQ?=
 =?us-ascii?Q?oZricBJqGhipif1ICAPkuGwCtI10nVFfHOfr+Q6ZZ2vKo/ShowJjcQqaMtd4?=
 =?us-ascii?Q?GrBaLTC0ZONO8XraOHWCC0IdS+2ZA0L3SSR12q2Bat9SGvRu+Q5ZVi0o6sKi?=
 =?us-ascii?Q?Y+i1oCAN8ZkFZLj7jjamwH/oBNoyNu9MHOojbjIiYLNypxPvZEZ9fifs5RYE?=
 =?us-ascii?Q?CRGK55CzqBd1gOlIzDZo/1yu6ZMNeGWQkicIW6yUd70ec67tF7v38MUKsn6L?=
 =?us-ascii?Q?H4fUJFCRhS8Va57RMpGVNGzI3muGGl3zIhfg5YYZ0FPjnXIMKWxXB/fKn9lO?=
 =?us-ascii?Q?RGRVUFCyi5qzm9d/nqqIivvcCFi6bRYB4sLq8OWKZjHZNfmEkNyz3GyyHVZH?=
 =?us-ascii?Q?Vuhoo0njfjrkLoOhLiklg/0MINZiMktzLPxXV2zN8WkESyG6rQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PUVKhei0w3tlf2y8Ez8oU1OhBkHEvsM2vaJhGvGiRH+W0Apd9V3hNSwRXg9Y?=
 =?us-ascii?Q?tqPtdhp4ouztqTDPLcxQ7NXrBfySEyFLrk0djOPvWc8WaskG0If2Z9eOGuGu?=
 =?us-ascii?Q?R1NhFMtXK7N9rUa4P2zsegMRsXc6EaV+ljugI9vdfuWgMu8wbT8H8gkKn+hr?=
 =?us-ascii?Q?8ixiL4mLSgFj3nHrB0Ypo+ijGImI1bsrZdM7FIPAoPzjaxbEL3sUuUS9hI2d?=
 =?us-ascii?Q?FPhgo0N40x2Np+4tWDDU81RLRLvYraDnqcGE6Q4DOXwKHEd+e2LoG6U7pH0C?=
 =?us-ascii?Q?oN/VNT/p/4mJ9IRtiW0lsAssg3gcnSBEnAq8t7xCL5z0xrIFdumlHdpCp55l?=
 =?us-ascii?Q?w1syzm0n/SDP7fcPk6qE3teqvqab2sXmGSejx8X07juByll03KYWn5JaAEWm?=
 =?us-ascii?Q?w49dfQIVn/GdAeIfH/3fmOwh4QqMTjTt/lAWMdX9PQ7eqW8d3yRPPInhc1JP?=
 =?us-ascii?Q?ePpmZPQRxsbM5u/wTD763aFuZvgAKOdGnOcElBxTGsUlOJxRR3tZf+grBeno?=
 =?us-ascii?Q?jM/1e8MqGQqWS72OBDReINE01cCXWKrPeos9rlQei4MkNi5uFIEImloHXI02?=
 =?us-ascii?Q?k+b+D0xnRsD8exechxGtoVZoL54J5nfXCd709JJV8HHPZFjnjyk3uaM2P8I4?=
 =?us-ascii?Q?takL43InSn4pXdj3xEKdXLh07WN9f/rOhIGZuAFz19lKRSE6y7LTVmM0rS/f?=
 =?us-ascii?Q?RsZnJwQuVlfNHHTJ5JJyLKEGqnRnd4v/O9yqQHNHF5Qh/NlL0TIXxsj7IIbF?=
 =?us-ascii?Q?ZUlW/k34T4/EHJmr8qGMJWadxoTs6XlBSxKWkDElICzje+G0ZMhCZVkkVE+W?=
 =?us-ascii?Q?IOX1jbIvghx3q6DNEG0aZRcuB3mJ4sL8ORVN+G6+DiHzyOMZ9UTqWvCJ2yi0?=
 =?us-ascii?Q?N3kUrq8wgwtYbJqx05zB6WxeQ8gRrkixecXpY3jHJ8JhrqB+rNCs+IET9W4J?=
 =?us-ascii?Q?UOQZipX0jSGSERQUgPpSc6lbXwBDR5iBCcyUfLTp1FVTZjVCFR22CLl8JNVN?=
 =?us-ascii?Q?p+zMxaL2DuBCIMCmB2ar1V2WdCvZt7ZABQii4gzXdanPdpWuJ+JBx//17AXl?=
 =?us-ascii?Q?iyfjTfGOL9PkGzBW8Z5r4qe0UCswayAD6E961OatLwjBDIeB71uAnE7YzJql?=
 =?us-ascii?Q?cu4q3Nt34zr8BrbnItPHJyNRcjhMqtaj+YrmHtsein03mwto+bNsrrRxI3UO?=
 =?us-ascii?Q?yUXtaZBYrKMLJmt9Z5YDd9wvvdRYtbah/yKiOYdT848Rp16VGNwp0QrLdFZ6?=
 =?us-ascii?Q?L4p7xSPOApw/1c7aHjwc6qsp0CJ18c2ZWnCJkhRECBPScYP1vBPKwBuk+7DW?=
 =?us-ascii?Q?pJPsZ3ST4Ktc3Cdb+527ALJjGrf20f/d2YO6lgVwycglMYtSKDPDXi2EG6x+?=
 =?us-ascii?Q?lXhLl8U0ivtdhVXDNVyhoOmURp4bTFp+GqvmXXmiV3pcUeh6G+Z739btONOG?=
 =?us-ascii?Q?QI0yOopfUM5k1sA0hSEx8iIdPl2/0sVwq34+R4WAjLMvOk7GZxI+ZWdzn1SW?=
 =?us-ascii?Q?Jd8JkqH2bxp/tBtKgEYKgQMQ6hY9jha28mWxgSzpd8Xm48uYykYXVQKR3Jp7?=
 =?us-ascii?Q?tqVXW4ySU7hvkLR0XAFkXIvtQwtDhq8EuYM6O/H0MiV5PpSI7IV8Mo1GBO5U?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f334ecb-95ed-479d-346b-08dd4c1990ea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 10:31:25.1965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJazYuT8wjmq+6C6Ir1BaODMYPhM3OBU4dUKTuHOz3/bVKcXwpKavBIvljaS4F7Pma7+RZt2bosXjMU20NYtvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6241
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4dc1d1bec89864d8076e5ab314f86f46442bfb02
commit: 71354f7702c3b46f992c9f25c12af10123b76266 ARM: dts: aspeed: rainier: Reorganise FSI description
date:   1 year, 6 months ago
:::::: branch date: 11 hours ago
:::::: commit date: 1 year, 6 months ago
config: arm-randconfig-004-20230928 (https://download.01.org/0day-ci/archive/20250213/202502131648.Ra7ca3pO-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250213/202502131648.Ra7ca3pO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202502131648.Ra7ca3pO-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi:157.18-164.6: Warning (unit_address_vs_reg): /ahb/apb/fsi@1e79b000/cfam@0,0/sbefifo@2400/occ: node has a reg or ranges property, but no unit name
   arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi:322.18-329.6: Warning (unit_address_vs_reg): /ahb/apb/fsi@1e79b000/cfam@0,0/hub@3400/cfam@1,0/sbefifo@2400/occ: node has a reg or ranges property, but no unit name
>> arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi:808.18-815.6: Warning (unit_address_vs_reg): /ahb/apb/fsi@1e79b000/cfam@0,0/hub@3400/cfam@2,0/sbefifo@2400/occ: node has a reg or ranges property, but no unit name
   arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi:1181.18-1188.6: Warning (unit_address_vs_reg): /ahb/apb/fsi@1e79b000/cfam@0,0/hub@3400/cfam@3,0/sbefifo@2400/occ: node has a reg or ranges property, but no unit name

vim +808 arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi

fa9d3b8be23d02 Eddie James 2023-08-09   453  
fa9d3b8be23d02 Eddie James 2023-08-09   454  &fsi_hub0 {
fa9d3b8be23d02 Eddie James 2023-08-09   455  	cfam@2,0 {
fa9d3b8be23d02 Eddie James 2023-08-09   456  		reg = <2 0>;
fa9d3b8be23d02 Eddie James 2023-08-09   457  		#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   458  		#size-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   459  		chip-id = <2>;
fa9d3b8be23d02 Eddie James 2023-08-09   460  
fa9d3b8be23d02 Eddie James 2023-08-09   461  		scom@1000 {
fa9d3b8be23d02 Eddie James 2023-08-09   462  			compatible = "ibm,fsi2pib";
fa9d3b8be23d02 Eddie James 2023-08-09   463  			reg = <0x1000 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   464  		};
fa9d3b8be23d02 Eddie James 2023-08-09   465  
fa9d3b8be23d02 Eddie James 2023-08-09   466  		i2c@1800 {
fa9d3b8be23d02 Eddie James 2023-08-09   467  			compatible = "ibm,fsi-i2c-master";
fa9d3b8be23d02 Eddie James 2023-08-09   468  			reg = <0x1800 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   469  			#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   470  			#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   471  
fa9d3b8be23d02 Eddie James 2023-08-09   472  			cfam2_i2c0: i2c-bus@0 {
fa9d3b8be23d02 Eddie James 2023-08-09   473  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   474  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   475  				reg = <0>;	/* OM01 */
fa9d3b8be23d02 Eddie James 2023-08-09   476  
fa9d3b8be23d02 Eddie James 2023-08-09   477  				i2cr@20 {
fa9d3b8be23d02 Eddie James 2023-08-09   478  					compatible = "ibm,i2cr-fsi-master";
fa9d3b8be23d02 Eddie James 2023-08-09   479  					reg = <0x20>;
fa9d3b8be23d02 Eddie James 2023-08-09   480  					#address-cells = <2>;
fa9d3b8be23d02 Eddie James 2023-08-09   481  					#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   482  
fa9d3b8be23d02 Eddie James 2023-08-09   483  					cfam@0,0 {
fa9d3b8be23d02 Eddie James 2023-08-09   484  						reg = <0 0>;
fa9d3b8be23d02 Eddie James 2023-08-09   485  						#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   486  						#size-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   487  						chip-id = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   488  
fa9d3b8be23d02 Eddie James 2023-08-09   489  						scom300: scom@1000 {
fa9d3b8be23d02 Eddie James 2023-08-09   490  							compatible = "ibm,i2cr-scom";
fa9d3b8be23d02 Eddie James 2023-08-09   491  							reg = <0x1000 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   492  						};
fa9d3b8be23d02 Eddie James 2023-08-09   493  
fa9d3b8be23d02 Eddie James 2023-08-09   494  						sbefifo300: sbefifo@2400 {
fa9d3b8be23d02 Eddie James 2023-08-09   495  							compatible = "ibm,p9-sbefifo";
fa9d3b8be23d02 Eddie James 2023-08-09   496  							reg = <0x2400 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   497  							#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   498  							#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   499  						};
fa9d3b8be23d02 Eddie James 2023-08-09   500  					};
fa9d3b8be23d02 Eddie James 2023-08-09   501  				};
fa9d3b8be23d02 Eddie James 2023-08-09   502  			};
fa9d3b8be23d02 Eddie James 2023-08-09   503  
fa9d3b8be23d02 Eddie James 2023-08-09   504  			cfam2_i2c1: i2c-bus@1 {
fa9d3b8be23d02 Eddie James 2023-08-09   505  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   506  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   507  				reg = <1>;	/* OM23 */
fa9d3b8be23d02 Eddie James 2023-08-09   508  
fa9d3b8be23d02 Eddie James 2023-08-09   509  				i2cr@20 {
fa9d3b8be23d02 Eddie James 2023-08-09   510  					compatible = "ibm,i2cr-fsi-master";
fa9d3b8be23d02 Eddie James 2023-08-09   511  					reg = <0x20>;
fa9d3b8be23d02 Eddie James 2023-08-09   512  					#address-cells = <2>;
fa9d3b8be23d02 Eddie James 2023-08-09   513  					#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   514  
fa9d3b8be23d02 Eddie James 2023-08-09   515  					cfam@0,0 {
fa9d3b8be23d02 Eddie James 2023-08-09   516  						reg = <0 0>;
fa9d3b8be23d02 Eddie James 2023-08-09   517  						#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   518  						#size-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   519  						chip-id = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   520  
fa9d3b8be23d02 Eddie James 2023-08-09   521  						scom301: scom@1000 {
fa9d3b8be23d02 Eddie James 2023-08-09   522  							compatible = "ibm,i2cr-scom";
fa9d3b8be23d02 Eddie James 2023-08-09   523  							reg = <0x1000 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   524  						};
fa9d3b8be23d02 Eddie James 2023-08-09   525  
fa9d3b8be23d02 Eddie James 2023-08-09   526  						sbefifo301: sbefifo@2400 {
fa9d3b8be23d02 Eddie James 2023-08-09   527  							compatible = "ibm,p9-sbefifo";
fa9d3b8be23d02 Eddie James 2023-08-09   528  							reg = <0x2400 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   529  							#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   530  							#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   531  						};
fa9d3b8be23d02 Eddie James 2023-08-09   532  					};
fa9d3b8be23d02 Eddie James 2023-08-09   533  				};
fa9d3b8be23d02 Eddie James 2023-08-09   534  			};
fa9d3b8be23d02 Eddie James 2023-08-09   535  
fa9d3b8be23d02 Eddie James 2023-08-09   536  			cfam2_i2c10: i2c-bus@a {
fa9d3b8be23d02 Eddie James 2023-08-09   537  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   538  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   539  				reg = <10>;	/* OP3A */
fa9d3b8be23d02 Eddie James 2023-08-09   540  
fa9d3b8be23d02 Eddie James 2023-08-09   541  				i2cr@20 {
fa9d3b8be23d02 Eddie James 2023-08-09   542  					compatible = "ibm,i2cr-fsi-master";
fa9d3b8be23d02 Eddie James 2023-08-09   543  					reg = <0x20>;
fa9d3b8be23d02 Eddie James 2023-08-09   544  					#address-cells = <2>;
fa9d3b8be23d02 Eddie James 2023-08-09   545  					#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   546  
fa9d3b8be23d02 Eddie James 2023-08-09   547  					cfam@0,0 {
fa9d3b8be23d02 Eddie James 2023-08-09   548  						reg = <0 0>;
fa9d3b8be23d02 Eddie James 2023-08-09   549  						#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   550  						#size-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   551  						chip-id = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   552  
fa9d3b8be23d02 Eddie James 2023-08-09   553  						scom310: scom@1000 {
fa9d3b8be23d02 Eddie James 2023-08-09   554  							compatible = "ibm,i2cr-scom";
fa9d3b8be23d02 Eddie James 2023-08-09   555  							reg = <0x1000 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   556  						};
fa9d3b8be23d02 Eddie James 2023-08-09   557  
fa9d3b8be23d02 Eddie James 2023-08-09   558  						sbefifo310: sbefifo@2400 {
fa9d3b8be23d02 Eddie James 2023-08-09   559  							compatible = "ibm,p9-sbefifo";
fa9d3b8be23d02 Eddie James 2023-08-09   560  							reg = <0x2400 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   561  							#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   562  							#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   563  						};
fa9d3b8be23d02 Eddie James 2023-08-09   564  					};
fa9d3b8be23d02 Eddie James 2023-08-09   565  				};
fa9d3b8be23d02 Eddie James 2023-08-09   566  			};
fa9d3b8be23d02 Eddie James 2023-08-09   567  
fa9d3b8be23d02 Eddie James 2023-08-09   568  			cfam2_i2c11: i2c-bus@b {
fa9d3b8be23d02 Eddie James 2023-08-09   569  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   570  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   571  				reg = <11>;	/* OP3B */
fa9d3b8be23d02 Eddie James 2023-08-09   572  
fa9d3b8be23d02 Eddie James 2023-08-09   573  				i2cr@20 {
fa9d3b8be23d02 Eddie James 2023-08-09   574  					compatible = "ibm,i2cr-fsi-master";
fa9d3b8be23d02 Eddie James 2023-08-09   575  					reg = <0x20>;
fa9d3b8be23d02 Eddie James 2023-08-09   576  					#address-cells = <2>;
fa9d3b8be23d02 Eddie James 2023-08-09   577  					#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   578  
fa9d3b8be23d02 Eddie James 2023-08-09   579  					cfam@0,0 {
fa9d3b8be23d02 Eddie James 2023-08-09   580  						reg = <0 0>;
fa9d3b8be23d02 Eddie James 2023-08-09   581  						#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   582  						#size-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   583  						chip-id = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   584  
fa9d3b8be23d02 Eddie James 2023-08-09   585  						scom311: scom@1000 {
fa9d3b8be23d02 Eddie James 2023-08-09   586  							compatible = "ibm,i2cr-scom";
fa9d3b8be23d02 Eddie James 2023-08-09   587  							reg = <0x1000 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   588  						};
fa9d3b8be23d02 Eddie James 2023-08-09   589  
fa9d3b8be23d02 Eddie James 2023-08-09   590  						sbefifo311: sbefifo@2400 {
fa9d3b8be23d02 Eddie James 2023-08-09   591  							compatible = "ibm,p9-sbefifo";
fa9d3b8be23d02 Eddie James 2023-08-09   592  							reg = <0x2400 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   593  							#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   594  							#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   595  						};
fa9d3b8be23d02 Eddie James 2023-08-09   596  					};
fa9d3b8be23d02 Eddie James 2023-08-09   597  				};
fa9d3b8be23d02 Eddie James 2023-08-09   598  			};
fa9d3b8be23d02 Eddie James 2023-08-09   599  
fa9d3b8be23d02 Eddie James 2023-08-09   600  			cfam2_i2c12: i2c-bus@c {
fa9d3b8be23d02 Eddie James 2023-08-09   601  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   602  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   603  				reg = <12>;	/* OP4A */
fa9d3b8be23d02 Eddie James 2023-08-09   604  
fa9d3b8be23d02 Eddie James 2023-08-09   605  				i2cr@20 {
fa9d3b8be23d02 Eddie James 2023-08-09   606  					compatible = "ibm,i2cr-fsi-master";
fa9d3b8be23d02 Eddie James 2023-08-09   607  					reg = <0x20>;
fa9d3b8be23d02 Eddie James 2023-08-09   608  					#address-cells = <2>;
fa9d3b8be23d02 Eddie James 2023-08-09   609  					#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   610  
fa9d3b8be23d02 Eddie James 2023-08-09   611  					cfam@0,0 {
fa9d3b8be23d02 Eddie James 2023-08-09   612  						reg = <0 0>;
fa9d3b8be23d02 Eddie James 2023-08-09   613  						#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   614  						#size-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   615  						chip-id = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   616  
fa9d3b8be23d02 Eddie James 2023-08-09   617  						scom312: scom@1000 {
fa9d3b8be23d02 Eddie James 2023-08-09   618  							compatible = "ibm,i2cr-scom";
fa9d3b8be23d02 Eddie James 2023-08-09   619  							reg = <0x1000 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   620  						};
fa9d3b8be23d02 Eddie James 2023-08-09   621  
fa9d3b8be23d02 Eddie James 2023-08-09   622  						sbefifo312: sbefifo@2400 {
fa9d3b8be23d02 Eddie James 2023-08-09   623  							compatible = "ibm,p9-sbefifo";
fa9d3b8be23d02 Eddie James 2023-08-09   624  							reg = <0x2400 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   625  							#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   626  							#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   627  						};
fa9d3b8be23d02 Eddie James 2023-08-09   628  					};
fa9d3b8be23d02 Eddie James 2023-08-09   629  				};
fa9d3b8be23d02 Eddie James 2023-08-09   630  			};
fa9d3b8be23d02 Eddie James 2023-08-09   631  
fa9d3b8be23d02 Eddie James 2023-08-09   632  			cfam2_i2c13: i2c-bus@d {
fa9d3b8be23d02 Eddie James 2023-08-09   633  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   634  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   635  				reg = <13>;	/* OP4B */
fa9d3b8be23d02 Eddie James 2023-08-09   636  
fa9d3b8be23d02 Eddie James 2023-08-09   637  				i2cr@20 {
fa9d3b8be23d02 Eddie James 2023-08-09   638  					compatible = "ibm,i2cr-fsi-master";
fa9d3b8be23d02 Eddie James 2023-08-09   639  					reg = <0x20>;
fa9d3b8be23d02 Eddie James 2023-08-09   640  					#address-cells = <2>;
fa9d3b8be23d02 Eddie James 2023-08-09   641  					#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   642  
fa9d3b8be23d02 Eddie James 2023-08-09   643  					cfam@0,0 {
fa9d3b8be23d02 Eddie James 2023-08-09   644  						reg = <0 0>;
fa9d3b8be23d02 Eddie James 2023-08-09   645  						#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   646  						#size-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   647  						chip-id = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   648  
fa9d3b8be23d02 Eddie James 2023-08-09   649  						scom313: scom@1000 {
fa9d3b8be23d02 Eddie James 2023-08-09   650  							compatible = "ibm,i2cr-scom";
fa9d3b8be23d02 Eddie James 2023-08-09   651  							reg = <0x1000 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   652  						};
fa9d3b8be23d02 Eddie James 2023-08-09   653  
fa9d3b8be23d02 Eddie James 2023-08-09   654  						sbefifo313: sbefifo@2400 {
fa9d3b8be23d02 Eddie James 2023-08-09   655  							compatible = "ibm,p9-sbefifo";
fa9d3b8be23d02 Eddie James 2023-08-09   656  							reg = <0x2400 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   657  							#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   658  							#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   659  						};
fa9d3b8be23d02 Eddie James 2023-08-09   660  					};
fa9d3b8be23d02 Eddie James 2023-08-09   661  				};
fa9d3b8be23d02 Eddie James 2023-08-09   662  			};
fa9d3b8be23d02 Eddie James 2023-08-09   663  
fa9d3b8be23d02 Eddie James 2023-08-09   664  			cfam2_i2c14: i2c-bus@e {
fa9d3b8be23d02 Eddie James 2023-08-09   665  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   666  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   667  				reg = <14>;	/* OP5A */
fa9d3b8be23d02 Eddie James 2023-08-09   668  
fa9d3b8be23d02 Eddie James 2023-08-09   669  				i2cr@20 {
fa9d3b8be23d02 Eddie James 2023-08-09   670  					compatible = "ibm,i2cr-fsi-master";
fa9d3b8be23d02 Eddie James 2023-08-09   671  					reg = <0x20>;
fa9d3b8be23d02 Eddie James 2023-08-09   672  					#address-cells = <2>;
fa9d3b8be23d02 Eddie James 2023-08-09   673  					#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   674  
fa9d3b8be23d02 Eddie James 2023-08-09   675  					cfam@0,0 {
fa9d3b8be23d02 Eddie James 2023-08-09   676  						reg = <0 0>;
fa9d3b8be23d02 Eddie James 2023-08-09   677  						#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   678  						#size-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   679  						chip-id = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   680  
fa9d3b8be23d02 Eddie James 2023-08-09   681  						scom314: scom@1000 {
fa9d3b8be23d02 Eddie James 2023-08-09   682  							compatible = "ibm,i2cr-scom";
fa9d3b8be23d02 Eddie James 2023-08-09   683  							reg = <0x1000 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   684  						};
fa9d3b8be23d02 Eddie James 2023-08-09   685  
fa9d3b8be23d02 Eddie James 2023-08-09   686  						sbefifo314: sbefifo@2400 {
fa9d3b8be23d02 Eddie James 2023-08-09   687  							compatible = "ibm,p9-sbefifo";
fa9d3b8be23d02 Eddie James 2023-08-09   688  							reg = <0x2400 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   689  							#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   690  							#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   691  						};
fa9d3b8be23d02 Eddie James 2023-08-09   692  					};
fa9d3b8be23d02 Eddie James 2023-08-09   693  				};
fa9d3b8be23d02 Eddie James 2023-08-09   694  			};
fa9d3b8be23d02 Eddie James 2023-08-09   695  
fa9d3b8be23d02 Eddie James 2023-08-09   696  			cfam2_i2c15: i2c-bus@f {
fa9d3b8be23d02 Eddie James 2023-08-09   697  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   698  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   699  				reg = <15>;	/* OP5B */
fa9d3b8be23d02 Eddie James 2023-08-09   700  
fa9d3b8be23d02 Eddie James 2023-08-09   701  				i2cr@20 {
fa9d3b8be23d02 Eddie James 2023-08-09   702  					compatible = "ibm,i2cr-fsi-master";
fa9d3b8be23d02 Eddie James 2023-08-09   703  					reg = <0x20>;
fa9d3b8be23d02 Eddie James 2023-08-09   704  					#address-cells = <2>;
fa9d3b8be23d02 Eddie James 2023-08-09   705  					#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   706  
fa9d3b8be23d02 Eddie James 2023-08-09   707  					cfam@0,0 {
fa9d3b8be23d02 Eddie James 2023-08-09   708  						reg = <0 0>;
fa9d3b8be23d02 Eddie James 2023-08-09   709  						#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   710  						#size-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   711  						chip-id = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   712  
fa9d3b8be23d02 Eddie James 2023-08-09   713  						scom315: scom@1000 {
fa9d3b8be23d02 Eddie James 2023-08-09   714  							compatible = "ibm,i2cr-scom";
fa9d3b8be23d02 Eddie James 2023-08-09   715  							reg = <0x1000 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   716  						};
fa9d3b8be23d02 Eddie James 2023-08-09   717  
fa9d3b8be23d02 Eddie James 2023-08-09   718  						sbefifo315: sbefifo@2400 {
fa9d3b8be23d02 Eddie James 2023-08-09   719  							compatible = "ibm,p9-sbefifo";
fa9d3b8be23d02 Eddie James 2023-08-09   720  							reg = <0x2400 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   721  							#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   722  							#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   723  						};
fa9d3b8be23d02 Eddie James 2023-08-09   724  					};
fa9d3b8be23d02 Eddie James 2023-08-09   725  				};
fa9d3b8be23d02 Eddie James 2023-08-09   726  			};
fa9d3b8be23d02 Eddie James 2023-08-09   727  		};
fa9d3b8be23d02 Eddie James 2023-08-09   728  
fa9d3b8be23d02 Eddie James 2023-08-09   729  		fsi2spi@1c00 {
fa9d3b8be23d02 Eddie James 2023-08-09   730  			compatible = "ibm,fsi2spi";
fa9d3b8be23d02 Eddie James 2023-08-09   731  			reg = <0x1c00 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   732  			#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   733  			#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   734  
fa9d3b8be23d02 Eddie James 2023-08-09   735  			cfam2_spi0: spi@0 {
fa9d3b8be23d02 Eddie James 2023-08-09   736  				reg = <0x0>;
fa9d3b8be23d02 Eddie James 2023-08-09   737  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   738  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   739  
fa9d3b8be23d02 Eddie James 2023-08-09   740  				eeprom@0 {
fa9d3b8be23d02 Eddie James 2023-08-09   741  					at25,byte-len = <0x80000>;
fa9d3b8be23d02 Eddie James 2023-08-09   742  					at25,addr-mode = <4>;
fa9d3b8be23d02 Eddie James 2023-08-09   743  					at25,page-size = <256>;
fa9d3b8be23d02 Eddie James 2023-08-09   744  
fa9d3b8be23d02 Eddie James 2023-08-09   745  					compatible = "atmel,at25";
fa9d3b8be23d02 Eddie James 2023-08-09   746  					reg = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   747  					spi-max-frequency = <1000000>;
fa9d3b8be23d02 Eddie James 2023-08-09   748  				};
fa9d3b8be23d02 Eddie James 2023-08-09   749  			};
fa9d3b8be23d02 Eddie James 2023-08-09   750  
fa9d3b8be23d02 Eddie James 2023-08-09   751  			cfam2_spi1: spi@20 {
fa9d3b8be23d02 Eddie James 2023-08-09   752  				reg = <0x20>;
fa9d3b8be23d02 Eddie James 2023-08-09   753  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   754  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   755  
fa9d3b8be23d02 Eddie James 2023-08-09   756  				eeprom@0 {
fa9d3b8be23d02 Eddie James 2023-08-09   757  					at25,byte-len = <0x80000>;
fa9d3b8be23d02 Eddie James 2023-08-09   758  					at25,addr-mode = <4>;
fa9d3b8be23d02 Eddie James 2023-08-09   759  					at25,page-size = <256>;
fa9d3b8be23d02 Eddie James 2023-08-09   760  
fa9d3b8be23d02 Eddie James 2023-08-09   761  					compatible = "atmel,at25";
fa9d3b8be23d02 Eddie James 2023-08-09   762  					reg = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   763  					spi-max-frequency = <1000000>;
fa9d3b8be23d02 Eddie James 2023-08-09   764  				};
fa9d3b8be23d02 Eddie James 2023-08-09   765  			};
fa9d3b8be23d02 Eddie James 2023-08-09   766  
fa9d3b8be23d02 Eddie James 2023-08-09   767  			cfam2_spi2: spi@40 {
fa9d3b8be23d02 Eddie James 2023-08-09   768  				reg = <0x40>;
fa9d3b8be23d02 Eddie James 2023-08-09   769  				compatible =  "ibm,fsi2spi";
fa9d3b8be23d02 Eddie James 2023-08-09   770  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   771  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   772  
fa9d3b8be23d02 Eddie James 2023-08-09   773  				eeprom@0 {
fa9d3b8be23d02 Eddie James 2023-08-09   774  					at25,byte-len = <0x80000>;
fa9d3b8be23d02 Eddie James 2023-08-09   775  					at25,addr-mode = <4>;
fa9d3b8be23d02 Eddie James 2023-08-09   776  					at25,page-size = <256>;
fa9d3b8be23d02 Eddie James 2023-08-09   777  
fa9d3b8be23d02 Eddie James 2023-08-09   778  					compatible = "atmel,at25";
fa9d3b8be23d02 Eddie James 2023-08-09   779  					reg = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   780  					spi-max-frequency = <1000000>;
fa9d3b8be23d02 Eddie James 2023-08-09   781  				};
fa9d3b8be23d02 Eddie James 2023-08-09   782  			};
fa9d3b8be23d02 Eddie James 2023-08-09   783  
fa9d3b8be23d02 Eddie James 2023-08-09   784  			cfam2_spi3: spi@60 {
fa9d3b8be23d02 Eddie James 2023-08-09   785  				reg = <0x60>;
fa9d3b8be23d02 Eddie James 2023-08-09   786  				compatible =  "ibm,fsi2spi";
fa9d3b8be23d02 Eddie James 2023-08-09   787  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   788  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   789  
fa9d3b8be23d02 Eddie James 2023-08-09   790  				eeprom@0 {
fa9d3b8be23d02 Eddie James 2023-08-09   791  					at25,byte-len = <0x80000>;
fa9d3b8be23d02 Eddie James 2023-08-09   792  					at25,addr-mode = <4>;
fa9d3b8be23d02 Eddie James 2023-08-09   793  					at25,page-size = <256>;
fa9d3b8be23d02 Eddie James 2023-08-09   794  
fa9d3b8be23d02 Eddie James 2023-08-09   795  					compatible = "atmel,at25";
fa9d3b8be23d02 Eddie James 2023-08-09   796  					reg = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   797  					spi-max-frequency = <1000000>;
fa9d3b8be23d02 Eddie James 2023-08-09   798  				};
fa9d3b8be23d02 Eddie James 2023-08-09   799  			};
fa9d3b8be23d02 Eddie James 2023-08-09   800  		};
fa9d3b8be23d02 Eddie James 2023-08-09   801  
fa9d3b8be23d02 Eddie James 2023-08-09   802  		sbefifo@2400 {
fa9d3b8be23d02 Eddie James 2023-08-09   803  			compatible = "ibm,p9-sbefifo";
fa9d3b8be23d02 Eddie James 2023-08-09   804  			reg = <0x2400 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   805  			#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   806  			#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   807  
fa9d3b8be23d02 Eddie James 2023-08-09  @808  			fsi_occ2: occ {
fa9d3b8be23d02 Eddie James 2023-08-09   809  				compatible = "ibm,p10-occ";
fa9d3b8be23d02 Eddie James 2023-08-09   810  
fa9d3b8be23d02 Eddie James 2023-08-09   811  				occ-hwmon {
fa9d3b8be23d02 Eddie James 2023-08-09   812  					compatible = "ibm,p10-occ-hwmon";
fa9d3b8be23d02 Eddie James 2023-08-09   813  					ibm,no-poll-on-init;
fa9d3b8be23d02 Eddie James 2023-08-09   814  				};
fa9d3b8be23d02 Eddie James 2023-08-09   815  			};
fa9d3b8be23d02 Eddie James 2023-08-09   816  		};
fa9d3b8be23d02 Eddie James 2023-08-09   817  
fa9d3b8be23d02 Eddie James 2023-08-09   818  		fsi_hub2: hub@3400 {
fa9d3b8be23d02 Eddie James 2023-08-09   819  			compatible = "fsi-master-hub";
fa9d3b8be23d02 Eddie James 2023-08-09   820  			reg = <0x3400 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   821  			#address-cells = <2>;
fa9d3b8be23d02 Eddie James 2023-08-09   822  			#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   823  
fa9d3b8be23d02 Eddie James 2023-08-09   824  			no-scan-on-init;
fa9d3b8be23d02 Eddie James 2023-08-09   825  		};
fa9d3b8be23d02 Eddie James 2023-08-09   826  	};
fa9d3b8be23d02 Eddie James 2023-08-09   827  
fa9d3b8be23d02 Eddie James 2023-08-09   828  	cfam@3,0 {
fa9d3b8be23d02 Eddie James 2023-08-09   829  		reg = <3 0>;
fa9d3b8be23d02 Eddie James 2023-08-09   830  		#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   831  		#size-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   832  		chip-id = <3>;
fa9d3b8be23d02 Eddie James 2023-08-09   833  
fa9d3b8be23d02 Eddie James 2023-08-09   834  		scom@1000 {
fa9d3b8be23d02 Eddie James 2023-08-09   835  			compatible = "ibm,fsi2pib";
fa9d3b8be23d02 Eddie James 2023-08-09   836  			reg = <0x1000 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   837  		};
fa9d3b8be23d02 Eddie James 2023-08-09   838  
fa9d3b8be23d02 Eddie James 2023-08-09   839  		i2c@1800 {
fa9d3b8be23d02 Eddie James 2023-08-09   840  			compatible = "ibm,fsi-i2c-master";
fa9d3b8be23d02 Eddie James 2023-08-09   841  			reg = <0x1800 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   842  			#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   843  			#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   844  
fa9d3b8be23d02 Eddie James 2023-08-09   845  			cfam3_i2c2: i2c-bus@2 {
fa9d3b8be23d02 Eddie James 2023-08-09   846  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   847  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   848  				reg = <2>;	/* OM45 */
fa9d3b8be23d02 Eddie James 2023-08-09   849  
fa9d3b8be23d02 Eddie James 2023-08-09   850  				i2cr@20 {
fa9d3b8be23d02 Eddie James 2023-08-09   851  					compatible = "ibm,i2cr-fsi-master";
fa9d3b8be23d02 Eddie James 2023-08-09   852  					reg = <0x20>;
fa9d3b8be23d02 Eddie James 2023-08-09   853  					#address-cells = <2>;
fa9d3b8be23d02 Eddie James 2023-08-09   854  					#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   855  
fa9d3b8be23d02 Eddie James 2023-08-09   856  					cfam@0,0 {
fa9d3b8be23d02 Eddie James 2023-08-09   857  						reg = <0 0>;
fa9d3b8be23d02 Eddie James 2023-08-09   858  						#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   859  						#size-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   860  						chip-id = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   861  
fa9d3b8be23d02 Eddie James 2023-08-09   862  						scom402: scom@1000 {
fa9d3b8be23d02 Eddie James 2023-08-09   863  							compatible = "ibm,i2cr-scom";
fa9d3b8be23d02 Eddie James 2023-08-09   864  							reg = <0x1000 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   865  						};
fa9d3b8be23d02 Eddie James 2023-08-09   866  
fa9d3b8be23d02 Eddie James 2023-08-09   867  						sbefifo402: sbefifo@2400 {
fa9d3b8be23d02 Eddie James 2023-08-09   868  							compatible = "ibm,p9-sbefifo";
fa9d3b8be23d02 Eddie James 2023-08-09   869  							reg = <0x2400 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   870  							#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   871  							#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   872  						};
fa9d3b8be23d02 Eddie James 2023-08-09   873  					};
fa9d3b8be23d02 Eddie James 2023-08-09   874  				};
fa9d3b8be23d02 Eddie James 2023-08-09   875  			};
fa9d3b8be23d02 Eddie James 2023-08-09   876  
fa9d3b8be23d02 Eddie James 2023-08-09   877  			cfam3_i2c3: i2c-bus@3 {
fa9d3b8be23d02 Eddie James 2023-08-09   878  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   879  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   880  				reg = <3>;	/* OM67 */
fa9d3b8be23d02 Eddie James 2023-08-09   881  
fa9d3b8be23d02 Eddie James 2023-08-09   882  				i2cr@20 {
fa9d3b8be23d02 Eddie James 2023-08-09   883  					compatible = "ibm,i2cr-fsi-master";
fa9d3b8be23d02 Eddie James 2023-08-09   884  					reg = <0x20>;
fa9d3b8be23d02 Eddie James 2023-08-09   885  					#address-cells = <2>;
fa9d3b8be23d02 Eddie James 2023-08-09   886  					#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   887  
fa9d3b8be23d02 Eddie James 2023-08-09   888  					cfam@0,0 {
fa9d3b8be23d02 Eddie James 2023-08-09   889  						reg = <0 0>;
fa9d3b8be23d02 Eddie James 2023-08-09   890  						#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   891  						#size-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   892  						chip-id = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   893  
fa9d3b8be23d02 Eddie James 2023-08-09   894  						scom403: scom@1000 {
fa9d3b8be23d02 Eddie James 2023-08-09   895  							compatible = "ibm,i2cr-scom";
fa9d3b8be23d02 Eddie James 2023-08-09   896  							reg = <0x1000 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   897  						};
fa9d3b8be23d02 Eddie James 2023-08-09   898  
fa9d3b8be23d02 Eddie James 2023-08-09   899  						sbefifo403: sbefifo@2400 {
fa9d3b8be23d02 Eddie James 2023-08-09   900  							compatible = "ibm,p9-sbefifo";
fa9d3b8be23d02 Eddie James 2023-08-09   901  							reg = <0x2400 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   902  							#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   903  							#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   904  						};
fa9d3b8be23d02 Eddie James 2023-08-09   905  					};
fa9d3b8be23d02 Eddie James 2023-08-09   906  				};
fa9d3b8be23d02 Eddie James 2023-08-09   907  			};
fa9d3b8be23d02 Eddie James 2023-08-09   908  
fa9d3b8be23d02 Eddie James 2023-08-09   909  			cfam3_i2c10: i2c-bus@a {
fa9d3b8be23d02 Eddie James 2023-08-09   910  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   911  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   912  				reg = <10>;	/* OP3A */
fa9d3b8be23d02 Eddie James 2023-08-09   913  
fa9d3b8be23d02 Eddie James 2023-08-09   914  				i2cr@20 {
fa9d3b8be23d02 Eddie James 2023-08-09   915  					compatible = "ibm,i2cr-fsi-master";
fa9d3b8be23d02 Eddie James 2023-08-09   916  					reg = <0x20>;
fa9d3b8be23d02 Eddie James 2023-08-09   917  					#address-cells = <2>;
fa9d3b8be23d02 Eddie James 2023-08-09   918  					#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   919  
fa9d3b8be23d02 Eddie James 2023-08-09   920  					cfam@0,0 {
fa9d3b8be23d02 Eddie James 2023-08-09   921  						reg = <0 0>;
fa9d3b8be23d02 Eddie James 2023-08-09   922  						#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   923  						#size-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   924  						chip-id = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   925  
fa9d3b8be23d02 Eddie James 2023-08-09   926  						scom410: scom@1000 {
fa9d3b8be23d02 Eddie James 2023-08-09   927  							compatible = "ibm,i2cr-scom";
fa9d3b8be23d02 Eddie James 2023-08-09   928  							reg = <0x1000 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   929  						};
fa9d3b8be23d02 Eddie James 2023-08-09   930  
fa9d3b8be23d02 Eddie James 2023-08-09   931  						sbefifo410: sbefifo@2400 {
fa9d3b8be23d02 Eddie James 2023-08-09   932  							compatible = "ibm,p9-sbefifo";
fa9d3b8be23d02 Eddie James 2023-08-09   933  							reg = <0x2400 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   934  							#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   935  							#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   936  						};
fa9d3b8be23d02 Eddie James 2023-08-09   937  					};
fa9d3b8be23d02 Eddie James 2023-08-09   938  				};
fa9d3b8be23d02 Eddie James 2023-08-09   939  			};
fa9d3b8be23d02 Eddie James 2023-08-09   940  
fa9d3b8be23d02 Eddie James 2023-08-09   941  			cfam3_i2c11: i2c-bus@b {
fa9d3b8be23d02 Eddie James 2023-08-09   942  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   943  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   944  				reg = <11>;	/* OP3B */
fa9d3b8be23d02 Eddie James 2023-08-09   945  
fa9d3b8be23d02 Eddie James 2023-08-09   946  				i2cr@20 {
fa9d3b8be23d02 Eddie James 2023-08-09   947  					compatible = "ibm,i2cr-fsi-master";
fa9d3b8be23d02 Eddie James 2023-08-09   948  					reg = <0x20>;
fa9d3b8be23d02 Eddie James 2023-08-09   949  					#address-cells = <2>;
fa9d3b8be23d02 Eddie James 2023-08-09   950  					#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   951  
fa9d3b8be23d02 Eddie James 2023-08-09   952  					cfam@0,0 {
fa9d3b8be23d02 Eddie James 2023-08-09   953  						reg = <0 0>;
fa9d3b8be23d02 Eddie James 2023-08-09   954  						#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   955  						#size-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   956  						chip-id = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   957  
fa9d3b8be23d02 Eddie James 2023-08-09   958  						scom411: scom@1000 {
fa9d3b8be23d02 Eddie James 2023-08-09   959  							compatible = "ibm,i2cr-scom";
fa9d3b8be23d02 Eddie James 2023-08-09   960  							reg = <0x1000 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   961  						};
fa9d3b8be23d02 Eddie James 2023-08-09   962  
fa9d3b8be23d02 Eddie James 2023-08-09   963  						sbefifo411: sbefifo@2400 {
fa9d3b8be23d02 Eddie James 2023-08-09   964  							compatible = "ibm,p9-sbefifo";
fa9d3b8be23d02 Eddie James 2023-08-09   965  							reg = <0x2400 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   966  							#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   967  							#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   968  						};
fa9d3b8be23d02 Eddie James 2023-08-09   969  					};
fa9d3b8be23d02 Eddie James 2023-08-09   970  				};
fa9d3b8be23d02 Eddie James 2023-08-09   971  			};
fa9d3b8be23d02 Eddie James 2023-08-09   972  
fa9d3b8be23d02 Eddie James 2023-08-09   973  			cfam3_i2c14: i2c-bus@e {
fa9d3b8be23d02 Eddie James 2023-08-09   974  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   975  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   976  				reg = <14>;	/* OP5A */
fa9d3b8be23d02 Eddie James 2023-08-09   977  
fa9d3b8be23d02 Eddie James 2023-08-09   978  				i2cr@20 {
fa9d3b8be23d02 Eddie James 2023-08-09   979  					compatible = "ibm,i2cr-fsi-master";
fa9d3b8be23d02 Eddie James 2023-08-09   980  					reg = <0x20>;
fa9d3b8be23d02 Eddie James 2023-08-09   981  					#address-cells = <2>;
fa9d3b8be23d02 Eddie James 2023-08-09   982  					#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   983  
fa9d3b8be23d02 Eddie James 2023-08-09   984  					cfam@0,0 {
fa9d3b8be23d02 Eddie James 2023-08-09   985  						reg = <0 0>;
fa9d3b8be23d02 Eddie James 2023-08-09   986  						#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   987  						#size-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   988  						chip-id = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09   989  
fa9d3b8be23d02 Eddie James 2023-08-09   990  						scom414: scom@1000 {
fa9d3b8be23d02 Eddie James 2023-08-09   991  							compatible = "ibm,i2cr-scom";
fa9d3b8be23d02 Eddie James 2023-08-09   992  							reg = <0x1000 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   993  						};
fa9d3b8be23d02 Eddie James 2023-08-09   994  
fa9d3b8be23d02 Eddie James 2023-08-09   995  						sbefifo414: sbefifo@2400 {
fa9d3b8be23d02 Eddie James 2023-08-09   996  							compatible = "ibm,p9-sbefifo";
fa9d3b8be23d02 Eddie James 2023-08-09   997  							reg = <0x2400 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09   998  							#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09   999  							#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1000  						};
fa9d3b8be23d02 Eddie James 2023-08-09  1001  					};
fa9d3b8be23d02 Eddie James 2023-08-09  1002  				};
fa9d3b8be23d02 Eddie James 2023-08-09  1003  			};
fa9d3b8be23d02 Eddie James 2023-08-09  1004  
fa9d3b8be23d02 Eddie James 2023-08-09  1005  			cfam3_i2c15: i2c-bus@f {
fa9d3b8be23d02 Eddie James 2023-08-09  1006  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09  1007  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1008  				reg = <15>;	/* OP5B */
fa9d3b8be23d02 Eddie James 2023-08-09  1009  
fa9d3b8be23d02 Eddie James 2023-08-09  1010  				i2cr@20 {
fa9d3b8be23d02 Eddie James 2023-08-09  1011  					compatible = "ibm,i2cr-fsi-master";
fa9d3b8be23d02 Eddie James 2023-08-09  1012  					reg = <0x20>;
fa9d3b8be23d02 Eddie James 2023-08-09  1013  					#address-cells = <2>;
fa9d3b8be23d02 Eddie James 2023-08-09  1014  					#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1015  
fa9d3b8be23d02 Eddie James 2023-08-09  1016  					cfam@0,0 {
fa9d3b8be23d02 Eddie James 2023-08-09  1017  						reg = <0 0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1018  						#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09  1019  						#size-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09  1020  						chip-id = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1021  
fa9d3b8be23d02 Eddie James 2023-08-09  1022  						scom415: scom@1000 {
fa9d3b8be23d02 Eddie James 2023-08-09  1023  							compatible = "ibm,i2cr-scom";
fa9d3b8be23d02 Eddie James 2023-08-09  1024  							reg = <0x1000 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09  1025  						};
fa9d3b8be23d02 Eddie James 2023-08-09  1026  
fa9d3b8be23d02 Eddie James 2023-08-09  1027  						sbefifo415: sbefifo@2400 {
fa9d3b8be23d02 Eddie James 2023-08-09  1028  							compatible = "ibm,p9-sbefifo";
fa9d3b8be23d02 Eddie James 2023-08-09  1029  							reg = <0x2400 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09  1030  							#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09  1031  							#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1032  						};
fa9d3b8be23d02 Eddie James 2023-08-09  1033  					};
fa9d3b8be23d02 Eddie James 2023-08-09  1034  				};
fa9d3b8be23d02 Eddie James 2023-08-09  1035  			};
fa9d3b8be23d02 Eddie James 2023-08-09  1036  
fa9d3b8be23d02 Eddie James 2023-08-09  1037  			cfam3_i2c16: i2c-bus@10 {
fa9d3b8be23d02 Eddie James 2023-08-09  1038  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09  1039  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1040  				reg = <16>;	/* OP6A */
fa9d3b8be23d02 Eddie James 2023-08-09  1041  
fa9d3b8be23d02 Eddie James 2023-08-09  1042  				i2cr@20 {
fa9d3b8be23d02 Eddie James 2023-08-09  1043  					compatible = "ibm,i2cr-fsi-master";
fa9d3b8be23d02 Eddie James 2023-08-09  1044  					reg = <0x20>;
fa9d3b8be23d02 Eddie James 2023-08-09  1045  					#address-cells = <2>;
fa9d3b8be23d02 Eddie James 2023-08-09  1046  					#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1047  
fa9d3b8be23d02 Eddie James 2023-08-09  1048  					cfam@0,0 {
fa9d3b8be23d02 Eddie James 2023-08-09  1049  						reg = <0 0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1050  						#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09  1051  						#size-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09  1052  						chip-id = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1053  
fa9d3b8be23d02 Eddie James 2023-08-09  1054  						scom416: scom@1000 {
fa9d3b8be23d02 Eddie James 2023-08-09  1055  							compatible = "ibm,i2cr-scom";
fa9d3b8be23d02 Eddie James 2023-08-09  1056  							reg = <0x1000 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09  1057  						};
fa9d3b8be23d02 Eddie James 2023-08-09  1058  
fa9d3b8be23d02 Eddie James 2023-08-09  1059  						sbefifo416: sbefifo@2400 {
fa9d3b8be23d02 Eddie James 2023-08-09  1060  							compatible = "ibm,p9-sbefifo";
fa9d3b8be23d02 Eddie James 2023-08-09  1061  							reg = <0x2400 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09  1062  							#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09  1063  							#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1064  						};
fa9d3b8be23d02 Eddie James 2023-08-09  1065  					};
fa9d3b8be23d02 Eddie James 2023-08-09  1066  				};
fa9d3b8be23d02 Eddie James 2023-08-09  1067  			};
fa9d3b8be23d02 Eddie James 2023-08-09  1068  
fa9d3b8be23d02 Eddie James 2023-08-09  1069  			cfam3_i2c17: i2c-bus@11 {
fa9d3b8be23d02 Eddie James 2023-08-09  1070  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09  1071  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1072  				reg = <17>;	/* OP6B */
fa9d3b8be23d02 Eddie James 2023-08-09  1073  
fa9d3b8be23d02 Eddie James 2023-08-09  1074  				i2cr@20 {
fa9d3b8be23d02 Eddie James 2023-08-09  1075  					compatible = "ibm,i2cr-fsi-master";
fa9d3b8be23d02 Eddie James 2023-08-09  1076  					reg = <0x20>;
fa9d3b8be23d02 Eddie James 2023-08-09  1077  					#address-cells = <2>;
fa9d3b8be23d02 Eddie James 2023-08-09  1078  					#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1079  
fa9d3b8be23d02 Eddie James 2023-08-09  1080  					cfam@0,0 {
fa9d3b8be23d02 Eddie James 2023-08-09  1081  						reg = <0 0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1082  						#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09  1083  						#size-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09  1084  						chip-id = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1085  
fa9d3b8be23d02 Eddie James 2023-08-09  1086  						scom417: scom@1000 {
fa9d3b8be23d02 Eddie James 2023-08-09  1087  							compatible = "ibm,i2cr-scom";
fa9d3b8be23d02 Eddie James 2023-08-09  1088  							reg = <0x1000 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09  1089  						};
fa9d3b8be23d02 Eddie James 2023-08-09  1090  
fa9d3b8be23d02 Eddie James 2023-08-09  1091  						sbefifo417: sbefifo@2400 {
fa9d3b8be23d02 Eddie James 2023-08-09  1092  							compatible = "ibm,p9-sbefifo";
fa9d3b8be23d02 Eddie James 2023-08-09  1093  							reg = <0x2400 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09  1094  							#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09  1095  							#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1096  						};
fa9d3b8be23d02 Eddie James 2023-08-09  1097  					};
fa9d3b8be23d02 Eddie James 2023-08-09  1098  				};
fa9d3b8be23d02 Eddie James 2023-08-09  1099  			};
fa9d3b8be23d02 Eddie James 2023-08-09  1100  		};
fa9d3b8be23d02 Eddie James 2023-08-09  1101  
fa9d3b8be23d02 Eddie James 2023-08-09  1102  		fsi2spi@1c00 {
fa9d3b8be23d02 Eddie James 2023-08-09  1103  			compatible = "ibm,fsi2spi";
fa9d3b8be23d02 Eddie James 2023-08-09  1104  			reg = <0x1c00 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09  1105  			#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09  1106  			#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1107  
fa9d3b8be23d02 Eddie James 2023-08-09  1108  			cfam3_spi0: spi@0 {
fa9d3b8be23d02 Eddie James 2023-08-09  1109  				reg = <0x0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1110  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09  1111  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1112  
fa9d3b8be23d02 Eddie James 2023-08-09  1113  				eeprom@0 {
fa9d3b8be23d02 Eddie James 2023-08-09  1114  					at25,byte-len = <0x80000>;
fa9d3b8be23d02 Eddie James 2023-08-09  1115  					at25,addr-mode = <4>;
fa9d3b8be23d02 Eddie James 2023-08-09  1116  					at25,page-size = <256>;
fa9d3b8be23d02 Eddie James 2023-08-09  1117  
fa9d3b8be23d02 Eddie James 2023-08-09  1118  					compatible = "atmel,at25";
fa9d3b8be23d02 Eddie James 2023-08-09  1119  					reg = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1120  					spi-max-frequency = <1000000>;
fa9d3b8be23d02 Eddie James 2023-08-09  1121  				};
fa9d3b8be23d02 Eddie James 2023-08-09  1122  			};
fa9d3b8be23d02 Eddie James 2023-08-09  1123  
fa9d3b8be23d02 Eddie James 2023-08-09  1124  			cfam3_spi1: spi@20 {
fa9d3b8be23d02 Eddie James 2023-08-09  1125  				reg = <0x20>;
fa9d3b8be23d02 Eddie James 2023-08-09  1126  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09  1127  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1128  
fa9d3b8be23d02 Eddie James 2023-08-09  1129  				eeprom@0 {
fa9d3b8be23d02 Eddie James 2023-08-09  1130  					at25,byte-len = <0x80000>;
fa9d3b8be23d02 Eddie James 2023-08-09  1131  					at25,addr-mode = <4>;
fa9d3b8be23d02 Eddie James 2023-08-09  1132  					at25,page-size = <256>;
fa9d3b8be23d02 Eddie James 2023-08-09  1133  
fa9d3b8be23d02 Eddie James 2023-08-09  1134  					compatible = "atmel,at25";
fa9d3b8be23d02 Eddie James 2023-08-09  1135  					reg = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1136  					spi-max-frequency = <1000000>;
fa9d3b8be23d02 Eddie James 2023-08-09  1137  				};
fa9d3b8be23d02 Eddie James 2023-08-09  1138  			};
fa9d3b8be23d02 Eddie James 2023-08-09  1139  
fa9d3b8be23d02 Eddie James 2023-08-09  1140  			cfam3_spi2: spi@40 {
fa9d3b8be23d02 Eddie James 2023-08-09  1141  				reg = <0x40>;
fa9d3b8be23d02 Eddie James 2023-08-09  1142  				compatible =  "ibm,fsi2spi";
fa9d3b8be23d02 Eddie James 2023-08-09  1143  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09  1144  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1145  
fa9d3b8be23d02 Eddie James 2023-08-09  1146  				eeprom@0 {
fa9d3b8be23d02 Eddie James 2023-08-09  1147  					at25,byte-len = <0x80000>;
fa9d3b8be23d02 Eddie James 2023-08-09  1148  					at25,addr-mode = <4>;
fa9d3b8be23d02 Eddie James 2023-08-09  1149  					at25,page-size = <256>;
fa9d3b8be23d02 Eddie James 2023-08-09  1150  
fa9d3b8be23d02 Eddie James 2023-08-09  1151  					compatible = "atmel,at25";
fa9d3b8be23d02 Eddie James 2023-08-09  1152  					reg = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1153  					spi-max-frequency = <1000000>;
fa9d3b8be23d02 Eddie James 2023-08-09  1154  				};
fa9d3b8be23d02 Eddie James 2023-08-09  1155  			};
fa9d3b8be23d02 Eddie James 2023-08-09  1156  
fa9d3b8be23d02 Eddie James 2023-08-09  1157  			cfam3_spi3: spi@60 {
fa9d3b8be23d02 Eddie James 2023-08-09  1158  				reg = <0x60>;
fa9d3b8be23d02 Eddie James 2023-08-09  1159  				compatible =  "ibm,fsi2spi";
fa9d3b8be23d02 Eddie James 2023-08-09  1160  				#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09  1161  				#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1162  
fa9d3b8be23d02 Eddie James 2023-08-09  1163  				eeprom@0 {
fa9d3b8be23d02 Eddie James 2023-08-09  1164  					at25,byte-len = <0x80000>;
fa9d3b8be23d02 Eddie James 2023-08-09  1165  					at25,addr-mode = <4>;
fa9d3b8be23d02 Eddie James 2023-08-09  1166  					at25,page-size = <256>;
fa9d3b8be23d02 Eddie James 2023-08-09  1167  
fa9d3b8be23d02 Eddie James 2023-08-09  1168  					compatible = "atmel,at25";
fa9d3b8be23d02 Eddie James 2023-08-09  1169  					reg = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1170  					spi-max-frequency = <1000000>;
fa9d3b8be23d02 Eddie James 2023-08-09  1171  				};
fa9d3b8be23d02 Eddie James 2023-08-09  1172  			};
fa9d3b8be23d02 Eddie James 2023-08-09  1173  		};
fa9d3b8be23d02 Eddie James 2023-08-09  1174  
fa9d3b8be23d02 Eddie James 2023-08-09  1175  		sbefifo@2400 {
fa9d3b8be23d02 Eddie James 2023-08-09  1176  			compatible = "ibm,p9-sbefifo";
fa9d3b8be23d02 Eddie James 2023-08-09  1177  			reg = <0x2400 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09  1178  			#address-cells = <1>;
fa9d3b8be23d02 Eddie James 2023-08-09  1179  			#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1180  
fa9d3b8be23d02 Eddie James 2023-08-09  1181  			fsi_occ3: occ {
fa9d3b8be23d02 Eddie James 2023-08-09  1182  				compatible = "ibm,p10-occ";
fa9d3b8be23d02 Eddie James 2023-08-09  1183  
fa9d3b8be23d02 Eddie James 2023-08-09  1184  				occ-hwmon {
fa9d3b8be23d02 Eddie James 2023-08-09  1185  					compatible = "ibm,p10-occ-hwmon";
fa9d3b8be23d02 Eddie James 2023-08-09  1186  					ibm,no-poll-on-init;
fa9d3b8be23d02 Eddie James 2023-08-09  1187  				};
fa9d3b8be23d02 Eddie James 2023-08-09  1188  			};
fa9d3b8be23d02 Eddie James 2023-08-09  1189  		};
fa9d3b8be23d02 Eddie James 2023-08-09  1190  
fa9d3b8be23d02 Eddie James 2023-08-09  1191  		fsi_hub3: hub@3400 {
fa9d3b8be23d02 Eddie James 2023-08-09  1192  			compatible = "fsi-master-hub";
fa9d3b8be23d02 Eddie James 2023-08-09  1193  			reg = <0x3400 0x400>;
fa9d3b8be23d02 Eddie James 2023-08-09  1194  			#address-cells = <2>;
fa9d3b8be23d02 Eddie James 2023-08-09  1195  			#size-cells = <0>;
fa9d3b8be23d02 Eddie James 2023-08-09  1196  
fa9d3b8be23d02 Eddie James 2023-08-09  1197  			no-scan-on-init;
fa9d3b8be23d02 Eddie James 2023-08-09  1198  		};
fa9d3b8be23d02 Eddie James 2023-08-09  1199  	};
fa9d3b8be23d02 Eddie James 2023-08-09  1200  };
fa9d3b8be23d02 Eddie James 2023-08-09  1201  

:::::: The code at line 808 was first introduced by commit
:::::: fa9d3b8be23d02f22f7476c2df2c7aa6e67fb115 ARM: dts: aspeed: Add P10 FSI descriptions

:::::: TO: Eddie James <eajames@linux.ibm.com>
:::::: CC: Joel Stanley <joel@jms.id.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



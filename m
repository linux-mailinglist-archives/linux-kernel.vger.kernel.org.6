Return-Path: <linux-kernel+bounces-562294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB714A6220F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 00:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1FCA421985
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D2A1F4701;
	Fri, 14 Mar 2025 23:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FuGVsrZ1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ED81A316D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 23:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741995761; cv=fail; b=dvxZoUQK+20bAojIxZ/PK5n5pvIi7h4I1jBORMG1nGRTEJ0zyLbParC84InGWfWtgCdp+nRZAZmLH30ZKR5oqW7aelsy80rkoeF8lX0ckdtKGCwmIzhpi0DQJO5CBkGLZB3uM4xPaqqwV1/GvGVCPakCmUfPsDLxqdeQW7envls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741995761; c=relaxed/simple;
	bh=AyqGt5kEh+AqKQZiJadZAeyxLMgOfQ41ekIsKcuQTY4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fKk+sjgEnF/2mjxRDyk1b//tEzShIZhNNqALMCyF1B4ECAtAcyfzv4ipUqehE0jnCgnJogpEsbUzsBM69/LokfDFwGbrVzyUXjd538nj4sLfyiiQ6ghXArodM6DrnpqeDLpAEmPaDzUhzeUH7Vf2zQ/w+w2JpjSDdIqIxVMLjr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FuGVsrZ1; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741995760; x=1773531760;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AyqGt5kEh+AqKQZiJadZAeyxLMgOfQ41ekIsKcuQTY4=;
  b=FuGVsrZ1eTpRDVhBmsbsz1lG3huv43Ra5JnIszO7pYiZHHzFBVOQ7pkr
   01isnCt85G7O9I2NTzq6WlA8iiueYDY8PsVqocv+EjrAKsJPxDrrGY8g6
   ijvmDIa9Vq23XZ97+6icGt6Xe/YrWi1wuWdzTsS4r0g9xN4XwIttJQc8I
   0OI4syLIi1b0Wo4QqypA/taRZLwc53clTY6q2RaJPXhakQ+D4qlV5/shn
   ZPshKis2fnJHCxyxjC0KcD2nEaRaL3tXzjHg7zwnMt7IwFy0b84G0EMzf
   MsCGDIdigb6PlD4Km3U3KvuVHglEs1MFRp55wPT4Lequ6fle550h+JxzI
   Q==;
X-CSE-ConnectionGUID: PNfSmU6hSAqh1tCgSpH2QA==
X-CSE-MsgGUID: 1UownMsxQwaw997Rh0rg+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="43266182"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43266182"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 16:42:39 -0700
X-CSE-ConnectionGUID: Cj6DOBNIQsGL2f1KnVRbLg==
X-CSE-MsgGUID: Sjf2WeYASVubggaEM0qvUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="122143953"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 16:42:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 16:42:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 16:42:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 16:42:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTvPqiFWyQCkmKJmfmI+lRkAS5aZPNSrhknnYnIDHtOAmk/xGXeAG+iyPzg+F0UBJHVk5gtQGlTs+jomnPTMUPqIfb+UW/d2/ZIlorkfCnLgpqPRhHfMhstsE7CGGgXWlZNKCURBljXsgDI3dlw9qGkNllwJm4Lawi50O/xIExFYZo9qxulHn3hYkoh+VG0hwUrT5mvaaluvK25s7aP55VSDjLmLMMlCKJo2JRaf4rR+IPcA81szytUjiD77GQ+XGtImElvssm3Ye3XKIJdUbjKsaR9vZ+LkxqfJG2VWqLo/B14rnJ6+Nn3x9s9YQsq1wuHhw9NaAqcjQzdagbGSsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEmxThSKhKZi56/v5De+2HRiolgEbsK6zR5H/lAUsKc=;
 b=YJr1/Tmh3yjRsAwP1NKfGAjPUfAGJfDYroBoR/Nse+KGPtuOsFrwpFFGv1C3kwx3i/hrfWLgq9H8Uia1aDZ1SFVfPIPgMjiuvWSd1n6YSuBW998aEA81vULrjbrI7amSMe/1YT6rIJPwAqohu5W+U51Px4W8VokuFvxkiTplJWop/mnGtkeVhG/CKedkp7wIH7/DV1tbXnwtLmTMp5W4G8LwuJ6AbTC0Ko9ji7Y6zHNOT+8Ta6DeGcf1gAuLaD0vWzzE8Vc5byiwpP+ekedHIjTekA/faqXLmYnZNt3svneVv/XCGFH7nbaYk5GbiALxEAquNN8SiHo0HrLR/x2Ngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB8064.namprd11.prod.outlook.com (2603:10b6:510:253::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 23:42:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 23:42:34 +0000
Date: Fri, 14 Mar 2025 16:42:31 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Gladkov <legion@kernel.org>, <x86@kernel.org>
CC: "Alexey Gladkov (Intel)" <legion@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>, Alexey Gladkov
	<alexey.gladkov@intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel
	<jroedel@suse.de>, Juergen Gross <jgross@suse.com>, "Kirill A . Shutemov"
	<kirill.shutemov@linux.intel.com>, <Larry.Dewey@amd.com>, Nikunj A Dadhania
	<nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFC PATCH v1 1/3] x86/tdx: Make TDX metadata available via SYSFS
Message-ID: <67d4bee77313a_12e31294c7@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1741952958.git.legion@kernel.org>
 <ddbf49381eb5d1779e218e022ffc144db5da003e.1741952958.git.legion@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ddbf49381eb5d1779e218e022ffc144db5da003e.1741952958.git.legion@kernel.org>
X-ClientProxiedBy: MW4PR03CA0302.namprd03.prod.outlook.com
 (2603:10b6:303:dd::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: e420a3b7-a94f-47ba-edcb-08dd6351e52b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S7nsmWszx2W6AbWqn/9DIDJb21VAD1ZSx/1J8hTmOEMb1yRons4v9d35fS1K?=
 =?us-ascii?Q?ePHIiVjVzkrXTT4sJSTUq++ar8C2HlK6ERz6qbb5rNXHV6j5tZlxlno3OUHX?=
 =?us-ascii?Q?jNo6IJbGOu2uxW67ICy9RYJaCCDAaOvdKpmHvgjT7fn096YVznFOQgH8b8sc?=
 =?us-ascii?Q?W4WjJFqyiCpqyHDKDuCJM6McUML2c7GDAFmazAcRYzuoMYDFVhQiKPEhRXsI?=
 =?us-ascii?Q?Lrh8+wBfX+8gpkTdS1S/PN4kzbsgdWbnE3wQLy5h7uITf+3/lARLv3LvcE2U?=
 =?us-ascii?Q?y1UNACblqyEBZPKwjgDNm8qGVhPLsFOGp/bvIIulHuuSE0RKK2m9kmAto13K?=
 =?us-ascii?Q?Le5Ev5W0rcNht/XQPZisjYepth4T5G2jYDAK11dKk3WUKUUXzldHtcRDP4al?=
 =?us-ascii?Q?QgN55WVbJoIOCN4q40YD8uMleYVL0lsgnbfzUtNKo+nL54W8ae4YuLdLk+kd?=
 =?us-ascii?Q?bX8VYYEmRCTNIE5u+9xA4O0Z+dP/pXVIwd1pafM9W/VypZUm3zD5/59jOWgR?=
 =?us-ascii?Q?Zi+bm/j2+c8evX2MpkQSCFlGpbk8MKcDAjdq4SyU3UKL6IEySVuIxfTRnwsx?=
 =?us-ascii?Q?GpYJK2oL1a2dFJKZ3KNSK3P+EyPPQ2s9K9sVXADaMwqXo6WSa3e8/VkvC7MX?=
 =?us-ascii?Q?6XMbgnTfEOtbuJguYuV3dwJ2laY6spmufE+aseXJ9Om8lhbdvp5YQguGDfJv?=
 =?us-ascii?Q?7ETO4dUszE3W1Hh31phNxHb3scNxQulfQrXWsj+hKwgv7nDr5+8G6v6xYXJj?=
 =?us-ascii?Q?HuG1rW4U4dl4KgOGApnsTwPSOuxSdeapkLFcvYsyEaJj3eh9k5OFlI+toZD4?=
 =?us-ascii?Q?HppoXOjyAo8GNqX/d8x7d/qApO9ZQmWnhWZBy8Uea6H8FpeiKCJFBaIv+dKG?=
 =?us-ascii?Q?iz5l9+5AHFNS3osYZHmWXeOSOSyhaNDug7jchwOpOBXzGzWj4NT7U2qLwsiA?=
 =?us-ascii?Q?h5wM6zXvu4GFF00r+IUr2Tb3OLIpEC1Ubhw8g0FJ3mX7PvShEvQlYLfuB+11?=
 =?us-ascii?Q?DuBi/ETnQn3Jg91Z0FVhMaZOIgbI7WQVl5xGqBaf2yqv5ENcvcFdv9JjSIaE?=
 =?us-ascii?Q?6G4AwenHH4utk2u+3J5Mq9w0twz2yBZeiMmUxG0mKrN8RJY6mhwXrxm0uUDd?=
 =?us-ascii?Q?f/k7SPCPz6+4VohhITae1zDrrJ1ySGALu4BOIUTxgYKg/IkdgWyftW1Pr6xI?=
 =?us-ascii?Q?noGpLit9KrS06Kxa914s1A/S+GZhEDOnjmu2f48E3CzmEQj0WG+3ZMjJXX+F?=
 =?us-ascii?Q?nyTO53RZz4eQ6QsotizZ9G3qByvHi8dEhY+GC1Q7WIv/tYhpi8aOcJ6oH2Z/?=
 =?us-ascii?Q?LkVu6uBisLLyNoW2EVA2qgdQTN+ol4QcGHE0/vnYwILasDRhETwPZMTyjX3e?=
 =?us-ascii?Q?9h5e2FqAW8E0pldL4uOYVxYERusW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?94vFKKUFMtukU3ukOhOpMwrvuvsbOqM1PCh8QHLYxmMDjZBLc6YLJJGzdqnY?=
 =?us-ascii?Q?E61CrwkscitTVq1LHL8DnMgN27snjTaZ7LU2VHzKzZywgGSrMTRs83jQRFI1?=
 =?us-ascii?Q?wSG6ZF+6g9SWdk/hFMv53Isahhn1UdNC1i2QtAQGVaWVeS0GuyrNjguYRZ3E?=
 =?us-ascii?Q?hwNCaV2l75w7VRq4nibaXJe/2EeR1YLUOVy4Sin740swguJ5aICz+mDLj85+?=
 =?us-ascii?Q?GQZMUfLZ/8BC6wBXOWCrkYBXZ4qf/oz56jVPpvK11iKRHsOAKz5UgcTPrzKO?=
 =?us-ascii?Q?WttwZoa3LAElELHb1GgBP/wXcsdB36EdTCk89tIOdN8cvTBnzy+cb1yQZ/2n?=
 =?us-ascii?Q?CGWLL5Hvu3s8MqMYN20cIgRj6CAMDf6xdPlKlVjQyTr/UrJq/U0b3rJ+v+EB?=
 =?us-ascii?Q?otdmRZ5H1Zx2KDplY4V2CsYaexdLDkydWhGOwaiuIxLkWLPw5Ic+wt4rOtgd?=
 =?us-ascii?Q?c+6tzPAVSwlRF1KbcxwWYIwv4MXpOyse5nvworerqETjDFfhWnrEuutGot65?=
 =?us-ascii?Q?R8oP6VKlz9dhI/gzw/8qEyTgwT3Dt1O3cikdgDNSZdDi8PxwNDil0gawm9ov?=
 =?us-ascii?Q?l0Qy21KSTxJ2xNrC0aeG7+JCAgO8NNtjbDK1o1N2gO6LXtgRh5MnGsJWlExU?=
 =?us-ascii?Q?bIyGWi2/HbBUYtNjPynZPYm3+WWTZWPi9gWKmXFBTq++JSioOGysHOBVzwQp?=
 =?us-ascii?Q?SIpNr3cp/mytsrVSp0/7fQ1iDCJeSi+uRYCBvEO9uORf3JKegYTGyZZJhOoD?=
 =?us-ascii?Q?fdsKHlMvz6j279GrSL5D+nSCCkjDz6X2CruzW1ADhnKUVqjO/6evB6sAl2FE?=
 =?us-ascii?Q?NMiJlz5dz+4bDp+f35HClLmhBp5pDpMNl6ob/U4AxqOB2wq3b60fyjVy/gGc?=
 =?us-ascii?Q?B6EILpn0v+mvu6CN0kn/sD3SObp0wb2GfoT+0yaj93Uxt11AMf1inQRCcsb9?=
 =?us-ascii?Q?51+sB4qfGHJAxNApjw9/8qS0c1J9elbAsHBMiN/d9aTUy++w43qwvXkXCD6C?=
 =?us-ascii?Q?Ty36yCRw1/7VUjoXx8MPk/TBfNYS+Qpg3nllMkwh3Wgc+M0GUyWyXb8IBIWG?=
 =?us-ascii?Q?Ust6ZvJ8SZeAul+9PoH19xGmufo5ao64+g2nXeioKWxaKw3SMoKLsV23Tp9A?=
 =?us-ascii?Q?1IE5xvtK3IXWFMQGjgtRb4LRWgDg9uPpYfONLzvFpr8B6pfrpVes/jwS+KkU?=
 =?us-ascii?Q?y8/ovR16YvjwieGI2Z2vc8wsN8kxlt74AnVSEE1f+2cCzInmcI4qeHjaqrfv?=
 =?us-ascii?Q?hlwJb5DHZ+JAuA8MK1IvoVkriUzBLCqzT/l0QdmLaf9BfnkOEHrfrjyM2990?=
 =?us-ascii?Q?T1CV0kLxm0okzWBCmrDlYD4e9YAwocb7dQRvLA/EaYT9W2hFkoZhZghFpFwn?=
 =?us-ascii?Q?p5doJAlRNTB4F/r+mrskngU7U/3xBsMtfcdxVeuBa22Ers9g6Sfnmk4BTAu6?=
 =?us-ascii?Q?UzJHsuOaOmIDSZeeRokQgZaNSrEltIKu28AcbwyCqPRLfwnYoM3qqx9rwqa4?=
 =?us-ascii?Q?3DRjNcxLp5cb8bZkwOoKC8ZgP1vKDf6il9kUb1r3ZURYKYP+2NW8bmNX7vf1?=
 =?us-ascii?Q?/84R1birbcVImpjwdwss2CIZQzP4voW5A0sJTe2jJIPHuiq/3So+arXJpoaq?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e420a3b7-a94f-47ba-edcb-08dd6351e52b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 23:42:34.6594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJzX2RWsIQTKd5PH8uI2zs76x+j0Uk6MvzKnhuZbDPWzg1woJIzg41lvoG9fOtuOhF/8zAA4Q+wtqbqXxvAMwIPV+0YzvvitfKRb4xhtTag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8064
X-OriginatorOrg: intel.com

Alexey Gladkov wrote:
> From: "Alexey Gladkov (Intel)" <legion@kernel.org>
> 
> Expose the TDX module information to userspace. The version information
> is valuable for debugging, as knowing the exact module version can help
> reproduce TDX-related issues.
> 
> Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
> ---
>  arch/x86/Kconfig                  |  1 +
>  arch/x86/include/asm/shared/tdx.h |  2 +
>  arch/x86/include/asm/tdx.h        | 12 +++++
>  arch/x86/virt/vmx/tdx/tdx.c       | 74 +++++++++++++++++++++++++++++++
>  4 files changed, 89 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index be2c311f5118..516f3539d0c7 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1986,6 +1986,7 @@ config INTEL_TDX_HOST
>  	depends on CONTIG_ALLOC
>  	depends on !KEXEC_CORE
>  	depends on X86_MCE
> +	select SYS_HYPERVISOR
>  	help
>  	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
>  	  host and certain physical attacks.  This option enables necessary TDX
> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> index 606d93a1cbac..92ee9dfb21e7 100644
> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -18,6 +18,8 @@
>  #define TDG_MEM_PAGE_ACCEPT		6
>  #define TDG_VM_RD			7
>  #define TDG_VM_WR			8
> +/* TDG_SYS_RD is available since TDX module version 1.5 and later. */
> +#define TDG_SYS_RD			11
>  
>  /* TDX attributes */
>  #define TDX_ATTR_DEBUG_BIT		0
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index e6b003fe7f5e..95d748bc8464 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -31,6 +31,18 @@
>  #define TDX_SUCCESS		0ULL
>  #define TDX_RND_NO_ENTROPY	0x8000020300000000ULL
>  
> +/*
> + * TDX metadata base field id, used by TDCALL TDG.SYS.RD
> + * See TDX ABI Spec Global Metadata Fields
> + */
> +#define TDX_SYS_MINOR_FID		0x0800000100000003ULL
> +#define TDX_SYS_MAJOR_FID		0x0800000100000004ULL
> +#define TDX_SYS_UPDATE_FID		0x0800000100000005ULL
> +#define TDX_SYS_INTERNAL_FID		0x0800000100000006ULL
> +#define TDX_SYS_BUILD_DATE_FID		0x8800000200000001ULL
> +#define TDX_SYS_BUILD_NUM_FID		0x8800000100000002ULL
> +#define TDX_SYS_FEATURES0_FID		0x0A00000300000008ULL
> +
>  #ifndef __ASSEMBLY__
>  
>  #include <uapi/asm/mce.h>
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index f5e2a937c1e7..89378e2a1f66 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1869,3 +1869,77 @@ u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page)
>  	return seamcall(TDH_PHYMEM_PAGE_WBINVD, &args);
>  }
>  EXPORT_SYMBOL_GPL(tdh_phymem_page_wbinvd_hkid);
> +
> +#ifdef CONFIG_SYSFS
> +#define TDX_SYSFS_ATTR(_field, _name, fmt)				\
> +static ssize_t _name ## _show(						\
> +	struct kobject *kobj, struct kobj_attribute *attr, char *buf)	\
> +{									\
> +	u64 value = 0;							\
> +	read_sys_metadata_field(_field, &value);			\
> +	return sprintf(buf, fmt, value);				\
> +}									\
> +static struct kobj_attribute _name ## _attr = __ATTR_RO(_name)
> +
> +TDX_SYSFS_ATTR(TDX_SYS_MINOR_FID, minor, "%lld\n");
> +TDX_SYSFS_ATTR(TDX_SYS_MAJOR_FID, major, "%lld\n");
> +TDX_SYSFS_ATTR(TDX_SYS_UPDATE_FID, update, "%lld\n");
> +TDX_SYSFS_ATTR(TDX_SYS_BUILD_NUM_FID, build_num, "%lld\n");
> +TDX_SYSFS_ATTR(TDX_SYS_BUILD_DATE_FID, build_date, "%lld\n");
> +TDX_SYSFS_ATTR(TDX_SYS_FEATURES0_FID, features0, "%llx\n");
> +
> +static struct attribute *version_attrs[] = {
> +	&minor_attr.attr,
> +	&major_attr.attr,
> +	&update_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group version_attr_group = {
> +	.name = "version",
> +	.attrs = version_attrs,
> +};
> +
> +static struct attribute *properties_attrs[] = {
> +	&build_num_attr.attr,
> +	&build_date_attr.attr,
> +	&features0_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group properties_attr_group = {
> +	.name = "properties",
> +	.attrs = properties_attrs,
> +};
> +
> +__init static int tdh_sysfs_init(void)
> +{
> +	struct kobject *tdx_kobj;
> +	int ret;
> +
> +	if (!hypervisor_kobj)
> +		return -ENOMEM;
> +
> +	tdx_kobj = kobject_create_and_add("tdx", hypervisor_kobj);

So this "/sys/hypervisor" proposal is clearly unaware of some other
discussions that have been happening around sysfs ABI for TEE Security
Managers like the PSP or TDX Module [1]. That PCI/TSM series discusses
the motivation for a bus/class + device model, not just raw hand-crafted
kobjects.

My other concern for hand-crafted kobjects is that it also destroys the
relationship with other existing objects. A /sys/hypervisor/$technology
is awkward when ABI like Documentation/ABI/testing/sysfs-driver-ccp
already exists.

So, no, I am not on board with this proposal. There are already patches
in flight to have TDX create a 'struct device' object that plays a
similar role as the PSP device object. For any potential common
attributes across vendors the proposal is that be handled via a typical
sysfs class device construction that links back to the $technology
device. That "tsm" class device is present in the PCI/TSM series [1].

[1]: http://lore.kernel.org/174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com


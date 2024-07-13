Return-Path: <linux-kernel+bounces-251404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D003E930487
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 10:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF18FB22C0D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 08:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F554503A;
	Sat, 13 Jul 2024 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1B3MRzU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD63AC36
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720859027; cv=fail; b=VFBR+U3WgR+Gvy0xAQJJnmoWxQZJwonf9tRhTVfPwZ+h47m90WcXkHAo17TFjvUL4Kx9Vf7TrdqSAuZtKFkHJd8zCm6+TqK3iitVZFmpZskBf9ycZEmSqJzBjEDhigcz6/m7Yn0rHUlcjdEOPmArAaPkxmESwpnBCFfOPnVRdZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720859027; c=relaxed/simple;
	bh=VR16tFnSVfBEMmipB/BkI5v84ZS88YyPcYszUJRV8+E=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=WrHx9hotu7gwRI/DK0cOMmPkVNeud+OwmANB3vfk2yfmCKh98sRxYmpfhcWSHvXLjusDh20RakUleSB0zBSty/g+qwoaLr/hjOj6P+pyXW8ulXZbRLX2pX9pW5jFLQy0+nrMenxlAp5c4YZyCsX0Zh8cFICmzvdbEaTopl/YpO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1B3MRzU; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720859026; x=1752395026;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VR16tFnSVfBEMmipB/BkI5v84ZS88YyPcYszUJRV8+E=;
  b=Q1B3MRzU4+458WA+w4YuIGvXDN7uohEikQr+EgpsWVqZ6PKpI+CgHtHE
   EmFcVpENyIQkm9R6euaXdR7hQ+Ujphq95dvCHtyIerOggmU1IxxVX5+rf
   Bw+qH48je5uIg1Y5jt8mQQTnGKeVEWThv9cwLwzOuJqZsTD98Ew8obYWF
   M7fFCAVG2gkWyHK23AVgCXobXsiYIY6IcEX7g61D5ffASJBdxk4jR0EKN
   wjTgbKXbTu3ueHIA+1So4IsLM2ug6sZI1/RzTTMt0sTwbYpC1ShA7Id9h
   Df8Hxobl4wBREtV/dRUaCa59sP+hTDDrW1gmtdOBIw6HiBCyld4vrecwj
   g==;
X-CSE-ConnectionGUID: 7hjwye1cR0K313sj2z5P0g==
X-CSE-MsgGUID: ZqH/LYn+STCSZV7tmtj0eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="29711666"
X-IronPort-AV: E=Sophos;i="6.09,205,1716274800"; 
   d="scan'208";a="29711666"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2024 01:23:46 -0700
X-CSE-ConnectionGUID: IPIZQX6lScONtd5zDCbMzg==
X-CSE-MsgGUID: qpiCKJWYQzGVTG/xH5BA2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,205,1716274800"; 
   d="scan'208";a="53703046"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jul 2024 01:23:46 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 13 Jul 2024 01:23:44 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 13 Jul 2024 01:23:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 13 Jul 2024 01:23:44 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 13 Jul 2024 01:23:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyfUEfPI79h+NI3jF5gvHrRqUy6ma5REG+wdnFuirysC1n9ukovtfGQoDkTZ/bTecPknsqxQ+fK9FMxgyx4y3vVkl8hxvSSyaNbSuyHJOQxLr19lz5o0Bnymd/edVnp670Kd9g0ZTETJLSb8NwhxPHLA+uaTsSycVWfFQw1NOPabR8zyswHkB9nkmngo8zlwYKcaScKMtKQDeoV0xJyJsUC/hFe9LujRU/vKhmzjoBeahvoQHyHpfpuZssNUxvhJgVsPlzcJ/QIN7EKSbf3qpc39g/qGjZtiC001kA+im/AJv7PuBPqrW+VWo6aaY4Ow+thBHDb3a/TPnj5cqIznQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mRypw71ZYgjUy8WsCvYD3JvHQgL7TSwBEIi403vpZU=;
 b=krCYeTLET94uI13cSmuBYRmNvytZ3kwhT7eEx3Wa8/UcdV13OwkACNBCxRQ7HUlgBsoEO2nFNHclh+9rz7YY+Q7x/kzzB/hj+VlKBo6A9AzsQyd9keiS2qTQSzBqZ2jG3/kLmkhkw/qs709XgsGhGkyhgGmjLyYk5c3AasJ5lfxgCH/GX2gXnPZW27a1qTJQSdLoijyxpcrA+Ba1UUZCsn/j1pu7sMYX44dosxand/9tYQkf3ra04MeC61R1G9r9TlxULlLI57wK3XuTCCBIaYTXPYsgDfDxLQAetDkLpcbN/5hNct2ryz34annBCL7H/5lpkp6xSNbyjFQp17xA4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 DS0PR11MB8018.namprd11.prod.outlook.com (2603:10b6:8:116::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.32; Sat, 13 Jul 2024 08:23:37 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7762.020; Sat, 13 Jul 2024
 08:23:37 +0000
Date: Sat, 13 Jul 2024 16:23:30 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Bjorn
 Andersson" <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dtb: pmic@0:
 mpps@a000:mpp4-state: 'oneOf' conditional failed, one must be fixed:
Message-ID: <ZpI5gtTA76qlXamH@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6039:EE_|DS0PR11MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e707351-2d0e-444b-be1e-08dca31517b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|220923002;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?blDBt6XlPAnIbyzfR6b+/f3U5aUBSYdEm03buqFBdsN7KVlvUL7LMgwuhzJ1?=
 =?us-ascii?Q?9cbVXvYR5qwECBa2Z3FRkcL4zmHjP7+Wru2c3JaP0A25SUnODtAgTjProing?=
 =?us-ascii?Q?26e3nZ8UF8Bl02RcgjkHM15a2QR1f6LDEgR9DcTyZ6xslil1X9ro281KJkKj?=
 =?us-ascii?Q?TDZ2Y8WohvtiBh2EJjZqGE4mdSWDBd+d4RVXGsyNuvKpcJsUP6nBuh0FyJM4?=
 =?us-ascii?Q?CPQ2rVo1KW2WN1kLkfyWwkwiCTKgfnMM+Nvam3KN7Ug37/0oDVFZ/eBg8BPH?=
 =?us-ascii?Q?S8WqV7Ypy/qSuqrGpFf1KfrwtWVe11t4lBe1OBwvtvgA4fe/BJZhUD9/EngL?=
 =?us-ascii?Q?JtPuMWjpvWVnb7IafGZsy1f2L393R8x0w5vp4OXuvXROfW6QTdT/2vmh8K5q?=
 =?us-ascii?Q?S5HB4zCCQrKVijKTVs9GD17U3nDc2hSychULOg2qVbjh8R3GQYAE89G+K33n?=
 =?us-ascii?Q?gizP8Og9y80sFiWrFdx/x/e5TEx5Y4AaKlQ4F5nYO7ych+yMpbYSv9aVGBtN?=
 =?us-ascii?Q?/WrNfTVrj4DUqJDepptmTaVJ+0A3ssJdHKyuf2pz10eHfGA9qoJgOyNmb9tV?=
 =?us-ascii?Q?9qKAi43+I1l5HNt9nisWt4KyNINppu4+aVXzHfINpnhVUw2CCTmuH+KMtRNr?=
 =?us-ascii?Q?tKIQAr2UtjHCkARsiHX/STJ4AsWuBTydycVwUbH8rUq6YTRdDDYdpr3pN6n9?=
 =?us-ascii?Q?0TY1dvVcl449doHu75F+QG3FIn57CQKpF7Bk+faGYX9fo0iLnH+wnCMoH1Ln?=
 =?us-ascii?Q?1TiyySt41xcXFYeHadxw4CitFjnMDPtpo52YW3RX5JZWmHtkTHya341eybpy?=
 =?us-ascii?Q?EsA3OmrEHes+JreWTRuN1nGwCaOsv1R4eA1oLgkcJrNIb5xli33ZWLDtGc6D?=
 =?us-ascii?Q?txlj4N70FtI6FsNS/Izgdb/ohd52lXAzrcl3XLeQREA+ihpEYcNY+lmlNhgb?=
 =?us-ascii?Q?ESPIBV2Vh7V269Jr6iPOpILxVgXcKrYd+FFB2krqEJSirpoXcROawsD5tatF?=
 =?us-ascii?Q?J6IgmW3kn6qyYLLAAixJQm6Q2McpVNP7nwkEn1KLqZn9hpK1m3iR+wyYcSJx?=
 =?us-ascii?Q?7CqlUBpGpbCZnNR7Li2HVT5TPjxIzlejEu+aOzONlr44Hf/y4WLZunwC8tNI?=
 =?us-ascii?Q?CsU9ICbAVripIVjpdcFidIrFj3SWQUGBoNyObT8YmsgCtbeDFaUU7VUhn2bj?=
 =?us-ascii?Q?SSa1dVXqyQjqUFxMkZV/tjVg4F5OkeT9ojDeRz77yW4WAPcEdJy7fx4v0PZF?=
 =?us-ascii?Q?FEhYNNhtcAqc2rms4mdgRNjooogeeR4Vs2KKjwL2AZl9FX/rV4cG+bg44/6n?=
 =?us-ascii?Q?Lvfd91Q1b7kBPWMz7TV/gM+WkO+aFFWH76/R2GYsOfAQf2es5h8TQz9so+Wu?=
 =?us-ascii?Q?7iSkV8Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O5SlrJL4p7AvmB75CLbedQRKz8WilaJPKJSj5rylV74YzQoZNFr5K2zNZCUV?=
 =?us-ascii?Q?nnx6xFvGPXCX/aHfSzdrKemb73O+jqsG6d06dRKwDdbdmor2YPahvD6zyVnj?=
 =?us-ascii?Q?dXh6ugdefu+vQfgtVl/xJvi4pJQOeq/2uBzL3GW6iwngRP+zyOQ2RYBUYU8v?=
 =?us-ascii?Q?Lq/P1ucASkwOQvwHzxbe9WouWr1HJ35shficNdE9fioXl5bODq/dGOFANYm9?=
 =?us-ascii?Q?XDw6QjS/Z8DM5EVWKBXSbKbnKl9kuuRhJvUibzluJKdRMB/m73Ckd9nCVOw3?=
 =?us-ascii?Q?Hvy/kpKaUGD/bP3WNrAdJ3taKeYCyfVcgGd5RriZoFozBg0NnkHEo9lcKxvZ?=
 =?us-ascii?Q?CXdB5ZmpmlwahPYLq1+AsfKdEwL4+tGwmrA4q2Kpp3CxQm8NfGTuz7E0wjKt?=
 =?us-ascii?Q?+EhPGpSM+wFXIwUUO2BiyMgUFDGmWRr+6UDsS70XSAoyHCutid/Pr4hHdT0X?=
 =?us-ascii?Q?RtzdeInUJXIShmCo8Q1+bL31HKDJpcDLWyJiapruKZochNtAdqcTF+JRPPhM?=
 =?us-ascii?Q?ca0Dl2eGCcgipBUY2w4loC+Bjdsp7UA1aTns1y/QBcmP6fzKQMoKHJX8XVcu?=
 =?us-ascii?Q?3xHqVs0MPQ/wE/1pwfIDX0NcEE2Bxdyglty3TMX2yw5qd/5h05q1x96Fbvcc?=
 =?us-ascii?Q?LxnN26PndOUtMeyMs5V61EPUy0hnHMNUbiI2RxCPcv7xwrFxi8YAMzeS5so2?=
 =?us-ascii?Q?++z058gUizp8Rw4cDexEAyk2yicVXNV5hupzSLIoCQifUvPVI50xf5qfkLd0?=
 =?us-ascii?Q?hX5eEOh1Bm8wXu3rn9SveiTBruJH/xPsxKQ6Fl2mNyiW6D+xAAKtLErlCd+M?=
 =?us-ascii?Q?M955h0kXMMYrE0NQBFCjfXjfFDEce/GvSYfaLlSS0kbQHj4LKm14S9nh5lnd?=
 =?us-ascii?Q?udyyHK0JcG1z6RDmhGQG7TGbv2IfVuOEzcLF4KvEiA2xWoqp+DfjzihwM4lc?=
 =?us-ascii?Q?wwQMRn7Z8YOcCeJjO/ydyPue56/UhbQxFLGJVTHne+rjtm2ZE7wsMjFJPI5Y?=
 =?us-ascii?Q?9NPAtsReS4mQH1wyb6QKai5IqJaRM7Womw1la5CU/xlbIMs2mqTrR7ulcoof?=
 =?us-ascii?Q?m8amTIDVQv4HSucOWWkXBkUPl54Iu9SiHrmwJ2BDcu5FNE3rknAtgDh6skL+?=
 =?us-ascii?Q?0sLWl7/z4vANvh/hy2CTuQJv55eVPyy4ReM3zEVHxODi8Y/jflyU03NgvxZh?=
 =?us-ascii?Q?KuSIWSHqf9RY+EE8dNOE+43zNFR1LbMetoQgZfoCvARB1AIa2NHLfvgXOCgw?=
 =?us-ascii?Q?bUObYoMKmFd+S04t735elMqGoqnB+L66Q1WljCzAai185thFoVUwgAy2BQGo?=
 =?us-ascii?Q?9X3WdVBMublYeRRsV8kEVi2f+y8yM4+FG3r1f8LjaNghDZRFYxzdwsqunsi9?=
 =?us-ascii?Q?UyjZ3R5vFDQZoxhZ439cWT4aW+2UrH0ntGKXGNmZ9b0HpL+5AE3EM1EtKWPb?=
 =?us-ascii?Q?/Uhka7IQQpynSq5PsVWZSDcDHoOOI3l+euW+boW8y+k5PUId6++61PbqPe+T?=
 =?us-ascii?Q?tmaKCMf7eczYUY4nQbNqMArNoDDa/gzU+rF7jSnnwl2AwaShAxypbpDw+gv4?=
 =?us-ascii?Q?gy8747lXf62Y9IAU625B7qZBirUO/8c9cJTTs+dt8TG5EL5nkwUM8FAoN5Oe?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e707351-2d0e-444b-be1e-08dca31517b8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2024 08:23:36.9967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycN5lvV2dIFz9mybrCXRSOZs9BMbFLnAGyoNyS3oJN9Rx0o19gEkZVLqz3EcWE+76UBDV9iLA5xPeXu0e1DMkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8018
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   43db1e03c086ed20cc75808d3f45e780ec4ca26e
commit: 27da4fd325c371e1ddbb4fc46629e2caf8f73f07 arm64: dts: qcom: msm8939-longcheer-l9100: Add initial device tree
date:   10 months ago
:::::: branch date: 16 hours ago
:::::: commit date: 10 months ago
config: arm64-randconfig-051-20240712 (https://download.01.org/0day-ci/archive/20240712/202407122204.QzyMtObH-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
dtschema version: 2024.6.dev4+g23441a4
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240712/202407122204.QzyMtObH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202407122204.QzyMtObH-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/qcom/msm8939.dtsi:475.26-478.6: Warning (unique_unit_address_if_enabled): /soc@0/qfprom@5c000/s6-p1@a1: duplicate unit-address (also used in node /soc@0/qfprom@5c000/s6-p2@a1)
   arch/arm64/boot/dts/qcom/msm8939.dtsi:495.26-498.6: Warning (unique_unit_address_if_enabled): /soc@0/qfprom@5c000/s8-p1@a4: duplicate unit-address (also used in node /soc@0/qfprom@5c000/s8-p2@a4)
   arch/arm64/boot/dts/qcom/msm8939.dtsi:520.24-523.6: Warning (unique_unit_address_if_enabled): /soc@0/qfprom@5c000/mode@d0: duplicate unit-address (also used in node /soc@0/qfprom@5c000/s0-p1@d0)
   arch/arm64/boot/dts/qcom/msm8939.dtsi:530.26-533.6: Warning (unique_unit_address_if_enabled): /soc@0/qfprom@5c000/s0-p1@d1: duplicate unit-address (also used in node /soc@0/qfprom@5c000/s1-p1@d1)
   arch/arm64/boot/dts/qcom/msm8939.dtsi:550.26-553.6: Warning (unique_unit_address_if_enabled): /soc@0/qfprom@5c000/s2-p2@d4: duplicate unit-address (also used in node /soc@0/qfprom@5c000/s3-p1@d4)
   arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dtb: iommu@1f08000: clocks: [[31, 129], [31, 140], [31, 175]] is too long
   	from schema $id: http://devicetree.org/schemas/iommu/qcom,iommu.yaml#
   arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dtb: iommu@1f08000: clock-names: ['iface', 'bus', 'tbu'] is too long
   	from schema $id: http://devicetree.org/schemas/iommu/qcom,iommu.yaml#
>> arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dtb: pmic@0: mpps@a000:mpp4-state: 'oneOf' conditional failed, one must be fixed:
   	'function', 'output-low', 'pins', 'power-source', 'qcom,dtest' do not match any of the regexes: '-pins$', 'pinctrl-[0-9]+'
   	[1] is not of type 'integer'
   	[1] is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml#
>> arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dtb: mpps@a000: mpp4-state: 'oneOf' conditional failed, one must be fixed:
   	'function', 'output-low', 'pins', 'power-source', 'qcom,dtest' do not match any of the regexes: '-pins$', 'pinctrl-[0-9]+'
   	[1] is not of type 'integer'
   	[1] is not one of [1, 2, 3, 4]
   	from schema $id: http://devicetree.org/schemas/pinctrl/qcom,pmic-mpp.yaml#
   arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dtb: pmic@1: audio-codec@f000: 'clock-names', 'clocks', 'reg-names' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml#
   arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dtb: audio-codec@f000: 'clock-names', 'clocks', 'reg-names' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/sound/qcom,pm8916-wcd-analog-codec.yaml#
   arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dtb: /soc@0/audio-codec@771c000: failed to match any schema with compatible: ['qcom,msm8916-wcd-digital-codec']
   arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dtb: /usb-id: failed to match any schema with compatible: ['linux,extcon-usb-gpio']

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



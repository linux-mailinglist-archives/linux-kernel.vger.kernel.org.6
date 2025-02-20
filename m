Return-Path: <linux-kernel+bounces-524503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9968EA3E3D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C355A7A4E41
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED859214803;
	Thu, 20 Feb 2025 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OezzlFB9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC85520F09D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076140; cv=fail; b=ISoCfH+lRUZcH3cdAL0T+4qoLX6v72TgzieWJKRkoQQ4mWzwNrv6eVtoBDki10FqVQmCMZBlxxFbQxDWZP3909KhrGcg73kCLRY6SoNO35Bi+nNUm77INZFo0/u8CIsarqd3isxFjIusEfw/RpvxzGberQOWfKCi3GM9Ypo+sT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076140; c=relaxed/simple;
	bh=084FswAo4r5UAsliqzICh3eax5RVo/zlUxJ1GrWJT3Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aJl3DeUNRp3u3JixW6lmkK90Pwwj6Y6dfjQt0445TGsgIA6G5H/WLquPNQ+KYl54OgBIH/0UVAB82J+PRAGTTrU7j9oYDkVOevhoM2MAQf3t0SFpZDm+Wd05nF0+HFBGlYWD0b0dkrP2KwbqXczzDQgq/EMeHTNmtnoUbMtQZ+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OezzlFB9; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740076138; x=1771612138;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=084FswAo4r5UAsliqzICh3eax5RVo/zlUxJ1GrWJT3Y=;
  b=OezzlFB9YDL4AdJ4Qb35qxIIHaEVYbVc+oDyYjk9V5bh2khcs5aJw6a1
   Rfcu8Rk08dzMHuCpg7Vka2lp0vRxMFov25vZfhieepp3R3v+T6nEhPA7G
   C+2JJ2oy2HxCDY7yYlyS9OBm6tomXERJU8fpumsZmao9FlgAdJLe/HlIL
   XUIdwaGwamFwHg6k3CQvyKhSnrN5zjgbl8+aFASAGH97SbZgJOkn+yJTe
   c+dAA8YOb/wryGk/EsLard/DKsA5Yp6Ovra9qwBqRDXi11ZOtDO369Ji0
   6ba+Tf+4FE2ag5i4RbZidllTVEN+8zPUdbjLTMmrgOISAIHY1zlZ4MhDb
   A==;
X-CSE-ConnectionGUID: dvBm4ZgpSfWYMw7F6iQGfw==
X-CSE-MsgGUID: KyxSSSlRQ6mxEzeJ1f7gVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="28472645"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="28472645"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 10:28:56 -0800
X-CSE-ConnectionGUID: 7IvQUnOuTmiDEyy8notrYA==
X-CSE-MsgGUID: WQySIZgjRGe2hmQ63iX5OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120362492"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 10:28:57 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 10:28:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 10:28:56 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 10:28:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGj9LU2n2feO8BBeHe5RzqPAP8JN8ztoLiv/E1WLrG/yIQnw1jnMcbGgz2G38OTlpxX4UnNX5ixV9BlgiocgY9qLaX22bpHLrD3uIhaIUilicj6zHUjqcXXYZ8A2cyvFhVfto7Zpysl8H/yXvUJ6JV76UMSaQQnvOI+gtHYLfuVzCTlAqpJesyGS2guVrC52msnYgGFKpi+Q7lVZu7RqfGawFzCLW3DjRigprJVfwzM2661kiM95ssUfeMP3uEr+d2l2phUXo10Kmv9bCQHvoFAcfwP+1JduXqTvg1y+Tc5kQCXCLFSEO7iat7ETZY7Db5+JH+A9H6Owp40ychSJDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=084FswAo4r5UAsliqzICh3eax5RVo/zlUxJ1GrWJT3Y=;
 b=nIERfjI7XUZokC/pK0x0djhWG03lJX40PPce228snCK9gF+bQG6U8wpIIGS4Aobro0u0bvgjB1U3ud7WADqyfi6vrTxYSRKRfjFfjknXrXQ8OUhAWVevO9G/bz2plaIEUJ13CM1tox69ObEidIG6zTcUbnDvzKWUmkXGFZ00YjbHZgsiXT3BZcjNJVZMNfcH2qQTm2SivFhuI6EyVktjzbfNBa1sRKC0mZsksOybflPvQdUdnye+HcJ1j+Nuc8UL0yx0dY6fE2B3zVzbeFhc4GOoqMmXaiMBjERLVUk32f6y9UAy6nzayYl/f752orfriSSM6QSElFNDTJqvBAzX0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7572.namprd11.prod.outlook.com (2603:10b6:510:27b::13)
 by SA3PR11MB8047.namprd11.prod.outlook.com (2603:10b6:806:2fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 18:28:21 +0000
Received: from PH7PR11MB7572.namprd11.prod.outlook.com
 ([fe80::16f9:b81c:54a0:76ac]) by PH7PR11MB7572.namprd11.prod.outlook.com
 ([fe80::16f9:b81c:54a0:76ac%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 18:28:21 +0000
From: "Constable, Scott D" <scott.d.constable@intel.com>
To: "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>, Peter Zijlstra
	<peterz@infradead.org>, "x86@kernel.org" <x86@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Milburn,
 Alyssa" <alyssa.milburn@intel.com>, "joao@overdrivepizza.com"
	<joao@overdrivepizza.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"jose.marchesi@oracle.com" <jose.marchesi@oracle.com>, "hjl.tools@gmail.com"
	<hjl.tools@gmail.com>, "ndesaulniers@google.com" <ndesaulniers@google.com>,
	"samitolvanen@google.com" <samitolvanen@google.com>, "nathan@kernel.org"
	<nathan@kernel.org>, "ojeda@kernel.org" <ojeda@kernel.org>, "kees@kernel.org"
	<kees@kernel.org>, "alexei.starovoitov@gmail.com"
	<alexei.starovoitov@gmail.com>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"jmill@asu.edu" <jmill@asu.edu>
Subject: RE: [PATCH v3 05/10] x86/ibt: Optimize FineIBT sequence
Thread-Topic: [PATCH v3 05/10] x86/ibt: Optimize FineIBT sequence
Thread-Index: AQHbgu9MR1zxxLU+HUCuPMYyFSVNBbNO3coAgADuIEA=
Date: Thu, 20 Feb 2025 18:28:21 +0000
Message-ID: <PH7PR11MB75720F8E94AF9E7FA05FC663BBC42@PH7PR11MB7572.namprd11.prod.outlook.com>
References: <20250219162107.880673196@infradead.org>
 <20250219163514.791951626@infradead.org>
 <0302239b-e787-43e1-accd-e9904de56782@citrix.com>
In-Reply-To: <0302239b-e787-43e1-accd-e9904de56782@citrix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7572:EE_|SA3PR11MB8047:EE_
x-ms-office365-filtering-correlation-id: 62a02b6a-b5f0-4910-a555-08dd51dc5ae0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?OF2K6RWKqO5v/nJCDlHNc9I4B1kIT6LxotJjJt5CFt9rqU++4+hbHDSjJa?=
 =?iso-8859-1?Q?TPSpPIo0H0V7ULlXjmjImIDNPyxdfmHtrbmvWn5xpMwb1YLdQZkZi/3VNK?=
 =?iso-8859-1?Q?8XiovZO2GEXBiCUWtOdYPXQ+5IACKd5WDsSnPhgujCH26bojRMIkg8XtC1?=
 =?iso-8859-1?Q?0nD1wfUbohW6gqbctX9R+1upmtlG4bxU3m1IPFxQjF7imal37PUKZ8fn7Q?=
 =?iso-8859-1?Q?yMmSzG2fLxR+A5XrBgXyVIj5PisMZPndgb9w7R10yRKWu9ZpBDAR6pL0p6?=
 =?iso-8859-1?Q?IBCQLidAl+xXSkKkiypM5Nw4d5YVwstQY524YuFDqj32ohxnpeBkbvwPBT?=
 =?iso-8859-1?Q?HJqrdHPXlaHXCTdPRYUU7YRVAwGefBKojMDvpNFWYJZWPkyZAvDux5TDgT?=
 =?iso-8859-1?Q?NXy3bclcW6R8Ty5K5YW9T7YmHr2S9TkaayJvD+2lP83rSv/pmdid1JnqMa?=
 =?iso-8859-1?Q?jJHLLTcQzSl7Grl2njRAM0iYqUAT4rj09DLzv4SyuQzz7C/eui7hoprrsi?=
 =?iso-8859-1?Q?cSnDmITqekBEO1/6RuofKlvST1D4GcXiW3isx1vJ+vhLmX7gAs4ShaO4ni?=
 =?iso-8859-1?Q?KZhVpjs4Lt9pgSR6wBOu6ELAW7/6dFz89hWT6yT4d8M7VXjjJwEP9pblxj?=
 =?iso-8859-1?Q?z3un40xD+PdliPQaDDhTSMYJ2u5t8CTYomk1rgcdKqS26sM7EaB28bMN2K?=
 =?iso-8859-1?Q?p/Hh86cTPwWmg2jaLm6Ge7cHsfkOXKD4dwas7/1CYhBVapc+jftXsKhG/r?=
 =?iso-8859-1?Q?gpfZz+2jAqM3gGnyaWPhSNm/v3KdWQugMWFN71kkc9S1XG2WEb2NVPT4zP?=
 =?iso-8859-1?Q?4dXYMZy5paBVugjUVcrDZ8wE/mpmae6Eo4ht8g1o0eJ0I0XXfslv0lkT3k?=
 =?iso-8859-1?Q?NQCOppku5N1XwrSJPTHkse/3o0LAKp3Uv9YCaUL8I8kT2qPNDVQF4T9hDQ?=
 =?iso-8859-1?Q?jFrW9S5uOL+WKq2YlMajRZMGmDPXuNSc6ktIm3sEKz4vEnb/zwnkPs0RJZ?=
 =?iso-8859-1?Q?kyx/d1FUuGpvqU64ly7i0Zc+FLsjSzbFtTHf7V/qYSd+//pKNxXmCxZb9v?=
 =?iso-8859-1?Q?aMDri2FrlgjNIKWG3bG3OQbWhZ8oD8d0GipBLb5F6cNp+5cQc+mJbaCTfd?=
 =?iso-8859-1?Q?5CLrqftOWLVZkfBYHLsdp+rUQAshJFU/GxWJ6ln43hkacf8oJmPplJFYWx?=
 =?iso-8859-1?Q?EYZyjofEP1aPO31mD9OBNTD7s10ZW/EmI7TS9Ymcz06hT69WCEafaIe869?=
 =?iso-8859-1?Q?qA0IBDrDC5ZRKfOJS2QuRFxFf3XGGTSTgeoYjvlDg6EcFV2VR/4bl66M/Z?=
 =?iso-8859-1?Q?lP3cvTwXJ5m+I/0V/kIAVFb6+s6IkkJh4NoNWrtnaKNjBr6p7ujfDqcm3g?=
 =?iso-8859-1?Q?OEVqFFTpB5hWBTWncOG2PgoVcAVpizN2VLwwDGRegY+aJ0w7D1GI70zeR4?=
 =?iso-8859-1?Q?rP5YaqJLvIxhjcR5N5hKmD1+uwun86gCIxvOQXqJW32eoP/FPZkxd9D9K8?=
 =?iso-8859-1?Q?JCeFknQiMRB2XLQpPOXLWM?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7572.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2tcsTMim+jje5eZ3ci4vsWWFDA4/w7K95BdfWZSCc5mqNvh7vSh/CasDx9?=
 =?iso-8859-1?Q?4k1qKVF488XhBsxB/PiIesKxADE+/IJ8a+rwosLxDZBFCyw2v46MAIwKer?=
 =?iso-8859-1?Q?LcE708LSwYBxOMhZVdNU8AvzoXq23wjZYqfafjcWz4LohjlMAB/Kk8gV0R?=
 =?iso-8859-1?Q?BBhVMJoD6e0tYl9gLgzUD0i1cDYYVoFgbpinfnOunChLlN3dJb8GoljrbN?=
 =?iso-8859-1?Q?ymsc0cAz590V5Ke+v1di391/TPB2JAj5BN873gNmXOUFWyM2LUAH1L4kJd?=
 =?iso-8859-1?Q?v2lrd26K8JSkGseclV7TVI+ELwhH4A2RpoJ6FYPtCip5qV5iz6qiRhoGED?=
 =?iso-8859-1?Q?s9O4OZdkAk9VAdQaQO9QUjg73sUlRdDff9ygUg4jkfcbOFvE7JwGMBcubn?=
 =?iso-8859-1?Q?lT4gJvnWasMLYv/8J1Qd1toOdIIsjRDEh8RHxz9Lenbv0tF6/37pKjTJO3?=
 =?iso-8859-1?Q?j3+I4vFBXRI6jZ6fEONi1+nQZZuynUUXvzcCJJ0X2bX+3pJbxfQzLAdC05?=
 =?iso-8859-1?Q?p1duFEx/ZDmStd7cGN3xMQIvFbwdpj+Bb6JWGyoVz1qowQyQSBSnNlJZu2?=
 =?iso-8859-1?Q?r/fRYcSaKX1/fkkNo2QgVtz4U+qF8YHZHjpxRIYCcprnBYZh8TXqRfdazX?=
 =?iso-8859-1?Q?jKm99lQkXHP3eF45vcjtZ5e1Y5GCfWpBx+C2sDLghBilsJzlDNqMWqfWOK?=
 =?iso-8859-1?Q?8U1uiHs1HYJptn45pgyMJ77i1zt5qqfg20Pn7Wvbaompx9sNEvHHQ2MDAT?=
 =?iso-8859-1?Q?pXiBJ7pMp6kh5A/8cs18lszEGLDt2/svNP6OoV96oT7QbTM1duzIiUZ7yQ?=
 =?iso-8859-1?Q?WSg3p0FNFreFihpuzh4RbKaJGMf2rc2UrcRonad08LENCjBq+mPHL6YHvy?=
 =?iso-8859-1?Q?1lt9IuEEkbOI8mAVduWLlsKUULM+bKhq0Si79gEDCf9S5Vf9OhANYn7VnD?=
 =?iso-8859-1?Q?XEtklT3Ak7gDtBOMYlDt1L2eZACjop18uM8p9S+q2GHXPYPIUKvUFwoAIS?=
 =?iso-8859-1?Q?QmBafrNy0PEsIiBEhOLM6uMDnIecj8ikAGBf2cD0uNhyYonlSr+G5BNTTn?=
 =?iso-8859-1?Q?lQ0OZsyYV8vA/7V/+mP1c4ft/l1WVnVG2Masyx8wAX7Xs8ayi7BzDzv5Nj?=
 =?iso-8859-1?Q?LqhyP/HrFH8bB/pdl35jLedqKfHAiJYokLLF86zcrcV3hx6ZevuJwVCL2O?=
 =?iso-8859-1?Q?9dCO+NBDWBzR/skvezpTreoufZj8xpLtODIlLNrcSMPVKD7eqYm5V01IJn?=
 =?iso-8859-1?Q?4otc1UgXHToj5M0cgY4fKMLX1MRUXSxhG7c5+DORKBdzZW6z1H5n5bLxad?=
 =?iso-8859-1?Q?yrV777bZsltHJZsQnuSwyV7uaD9THS4wGnbY9h/WRyEYHrKJPdb7nkd4kj?=
 =?iso-8859-1?Q?UVTFoIyT+z4MHxpdAbwP46pI2jAU8ql1W8+lu7Q5ZwSxvmMpNp6N3+6Pg1?=
 =?iso-8859-1?Q?+La4M9yiBI/mKrYRtltBBT32JXtHMi1dkAcJm+3SEmpfuZh1mkwmVXKuXg?=
 =?iso-8859-1?Q?U5/qGS0W8hpeQjwFWHFUx5gE+n3bB/WdIFArn6DvxSD78A0+APApAr7eW/?=
 =?iso-8859-1?Q?LE/TTd3uPSNVMREfmzZXlnE2/7hYtk1a9pxg6sL8iwNJleUieG/iAXt2Ms?=
 =?iso-8859-1?Q?xZEHc8RoEMEZVVUsuS/G+gX80ANYG45jGVd/+g8WTGU6wfxO4JtdIUEQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7572.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a02b6a-b5f0-4910-a555-08dd51dc5ae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 18:28:21.5348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qqnjANHDZz5QgT48P8Zym3KCHD0ZUYyw0ZSWra4xJ32dS2z3XaJgmwLj3kpYwhq0PYBawcaN1MAjFaUDRNjz6tK39S2hvwu3lTNtEQ1qEDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8047
X-OriginatorOrg: intel.com

Hi Andrew,

I can elaborate, if only "a bit." Your intuition about branches is pretty a=
ccurate, and the difference between taken vs. not-taken should, on average,=
 be marginal. I can quote from Intel's software optimization manual: "Condi=
tional branches that are never taken do not consume BTB resources." Additio=
nally, there are some more subtle reasons that not-taken branches can be pr=
eferable--these vary by microarchitecture.

Regards,

Scott Constable

-----Original Message-----
From: Andrew Cooper <andrew.cooper3@citrix.com>=20
Sent: Wednesday, February 19, 2025 9:15 AM
To: Peter Zijlstra <peterz@infradead.org>; x86@kernel.org
Cc: linux-kernel@vger.kernel.org; Milburn, Alyssa <alyssa.milburn@intel.com=
>; Constable, Scott D <scott.d.constable@intel.com>; joao@overdrivepizza.co=
m; jpoimboe@kernel.org; jose.marchesi@oracle.com; hjl.tools@gmail.com; ndes=
aulniers@google.com; samitolvanen@google.com; nathan@kernel.org; ojeda@kern=
el.org; kees@kernel.org; alexei.starovoitov@gmail.com; mhiramat@kernel.org;=
 jmill@asu.edu
Subject: Re: [PATCH v3 05/10] x86/ibt: Optimize FineIBT sequence

On 19/02/2025 4:21 pm, Peter Zijlstra wrote:
> Scott notes that non-taken branches are faster. Abuse overlapping code=20
> that traps instead of explicit UD2 instructions.
>
> And LEA does not modify flags and will have less dependencies.
>
> Suggested-by: Scott Constable <scott.d.constable@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Can we get a bit more info on this "non-taken branches are faster" ?

For modern cores which have branch prediction pre-decode, a branch unknown =
to the predictor will behave as non-taken until the Jcc executes[1].

Something size of Linux is surely going to exceed the branch predictor capa=
city, so it's perhaps fair to say that there's a reasonable chance to miss =
in the predictor.

But, for a branch known to the predictor, taken branches ought to be bubble=
-less these days.=A0 At least, this is what the marketing material claims.

And, this doesn't account for branches which alias in the predictor and end=
 up with a wrong prediction.

~Andrew

[1] Yes, I know RWC has the reintroduced 0xee prefix with the decode restee=
r.


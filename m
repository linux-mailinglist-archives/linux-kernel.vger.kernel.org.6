Return-Path: <linux-kernel+bounces-513724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF69A34DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89EDD188C4F1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FA1245008;
	Thu, 13 Feb 2025 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8vO7ieA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA1928A2D5;
	Thu, 13 Feb 2025 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472044; cv=fail; b=IR8gzxQsHZgINXPWdDuxRe06cicboUMZUItyatYTkPo8TGkq5MtkDl9OEY8t/1ScqZr4AJzaA8q/rP+ugmr8qSIAeGuBrpCG2pijRQcy6hPfnbDF/E7WDkz6EalwX6ocKNrub3TcN6EYUEm1Zk/SjB+GQB52LrCBAD1yG8d93BQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472044; c=relaxed/simple;
	bh=gCLh/lP4xtP9YmNBSdhIMDBZErQC5i92nTgolLI0SxI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kuo0m7XmHbzskVaOyR9Q5OxSpwfyCkgrfCNGkMhL5YaRQMIgwvutuFxD6NL7rZEjP+ek/CMjk7cryekB7WJXU9pJ95TRUzpjzCuNFgNIMTt4Ln+8zqmR5JaObYvph0KbEyIDlJCoxRyvV/XUrMmuiaUQtsvt5axNPI6SzftxRno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8vO7ieA; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739472043; x=1771008043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gCLh/lP4xtP9YmNBSdhIMDBZErQC5i92nTgolLI0SxI=;
  b=E8vO7ieADTx7nB6ZflqksIeAHVFFOmS8x97uXX7QLbqoTZtYaH9xnR5n
   JgFE5tosON4r0+57jiwC/OPviASDnb2BwYPB3oHabDorQNihhZo3TJqX3
   drzVfpGYvtHMjXEpc6BMvu/Rb3sn6miFbrzS6z0uN10mYZPZbnlzU55Nw
   orbAZPxLSl1+j/zoibLrPQVpbSR01JDB1v+fXFM3sp7kJVYQWvW8PPstp
   E1uiLsuVUtM2C+4Mt8APCyMwV/XhN+/oCzNBFY1GXc/etKI7chC7NMqoT
   APqspy9rBEahaXPjXQ2vaJ7gKsIsOrxyzBYMTSA50eydSK9u0hoyTaWxx
   A==;
X-CSE-ConnectionGUID: gLL47yd1TSyg/H1qg2eewg==
X-CSE-MsgGUID: mYB5JHoFSzmUziZBYh1bqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40317796"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40317796"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 10:40:42 -0800
X-CSE-ConnectionGUID: hR4naPKBRwCHf3I1/R5+dg==
X-CSE-MsgGUID: YQfFyGi7R5e4vZrhg22Z4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113410723"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 10:40:41 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 10:40:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Feb 2025 10:40:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 10:40:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPT5aPjkARHPWeE12GY0RgibNxnxekD5Otndtjzt2ge3wgt8dUlpfOlOGYcYW+iU3+DWjEX5BB8gHojgiMcD9yShAkVNQQl6oJtrNtG6P1SMCoLMM5kYac0GI1xadR2NydMcI0OIeyB8EAQc3TGI9Pcwti1ncXVzREqRk13AaUp0wVA1Jko4Tm2Fj3Sgngzr++x8Gwy2r5MERFbe1BCVYMMi0PuqGSS+yu8xoEJVsikGcBSxpHXJ4ZHm/SAzQy8Z8Mx8puJH7wrZSaHsD0zhwoelAXBgmPkX8zappu5FL2uHCSwJDaRNeVn3daiGKQMHiN33MfIM5gvHGBl8biKDPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCLh/lP4xtP9YmNBSdhIMDBZErQC5i92nTgolLI0SxI=;
 b=WWzBUHnk6tflLAvHpso+xyB1blUYofa0ufZcP5BQ58wpiwKnFYhyt9xdbZqsNgW00phzVuOEIni+3jWZzBGvFDVarkdBV/dEM/XkhLfDydcX+pGgrvTUR2rXHdxaXMgnl8XFElJNjE7MrPTieR1Cy9UeqG7VNcUyjQnyIlDyd1bIv8q3lQR2EA9qdFlqN5hoYcVX+1RFb2MlhRBaCu1IZulTcWo09aokcclbE273IPlTi64amOUqfBEpg50qf6StpIAe9RX6Koo3phDx4fpYX6GhzwcWrK8wi3ZNWBwd6DWju8zXFh68+c8aRNzuaL6wzxYrWqeZgRqQwJ21IG5j2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH0PR11MB5265.namprd11.prod.outlook.com (2603:10b6:610:e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 18:39:52 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 18:39:52 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Dave Martin <Dave.Martin@arm.com>, "Moger, Babu" <babu.moger@amd.com>
CC: "peternewman@google.com" <peternewman@google.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "Chatre, Reinette" <reinette.chatre@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "thuth@redhat.com" <thuth@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "xiongwei.song@windriver.com"
	<xiongwei.song@windriver.com>, "pawan.kumar.gupta@linux.intel.com"
	<pawan.kumar.gupta@linux.intel.com>, "daniel.sneddon@linux.intel.com"
	<daniel.sneddon@linux.intel.com>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "perry.yuan@amd.com" <perry.yuan@amd.com>,
	"sandipan.das@amd.com" <sandipan.das@amd.com>, "Huang, Kai"
	<kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "Li, Xin3" <xin3.li@intel.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"ebiggers@google.com" <ebiggers@google.com>, "mario.limonciello@amd.com"
	<mario.limonciello@amd.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Eranian,
 Stephane" <eranian@google.com>
Subject: RE: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Thread-Topic: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Thread-Index: AQHbbQsur7YXoEmn/USrZUfWgYnla7NEEeSAgAF6IoCAACEegIAABB+Q
Date: Thu, 13 Feb 2025 18:39:52 +0000
Message-ID: <SJ1PR11MB6083759CCE59FF2FE931471EFCFF2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <5e9a5b3e-793c-4873-a1d2-33b62614ec31@amd.com>
 <Z643WdXYARTADSBy@e133380.arm.com>
In-Reply-To: <Z643WdXYARTADSBy@e133380.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH0PR11MB5265:EE_
x-ms-office365-filtering-correlation-id: 65bd2672-e7d3-4da4-1e85-08dd4c5dcd90
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?VXuGvtqns9sl5M6IVcWJhp6j8KhZ1qJOTpY/RBfaU3bDM/47vkvIJtP4/zi4?=
 =?us-ascii?Q?4X3NlLfishWpqeOLl4Y8aOr3EBtslm4iD6/JTvQ1Mk7rkLz2pPqOuUfDFVDJ?=
 =?us-ascii?Q?efITNQB5XIGVBEol3krChJNj+9dJOSOgweRbOXgV8FZEr6NLxlEgoXujsR77?=
 =?us-ascii?Q?TQ6E5f95M+DJI51qdx5U3dmtdnZYFw81pRJTMFu355N4Oo/cLtNln7Se9Jgx?=
 =?us-ascii?Q?cxWnCKLNilYi7cxjYarrhuZ/Uz38h8kXklbHuj2ge6OysUKD/ICRaKTzZ1vO?=
 =?us-ascii?Q?zeN/xauDL4YVpfnKEtkq70XkNtfxWVz/4CUtd4Kfozq+jCEeT9fdYDMP9jIt?=
 =?us-ascii?Q?oIlfnau+6Ny9whuGajUieer4nHm3ShTJ1pasy0mwAzmGQzBMa03SdYfmZO3d?=
 =?us-ascii?Q?x45r6PR0LOmW48NPiz43MIrOn8deQZ08AZ5qU62rmmKiKLOAKuYFuKaLgU3p?=
 =?us-ascii?Q?8/cKfHQFhzl51F44v1XV0NKXzzLlKxbEHdnNzZSLdFQ4uMBbAcIwQRGWk9Ty?=
 =?us-ascii?Q?qJ/SKmWSGT2JLTLkjZ2ueKJV3l4ii3+SHIfYzbuowqmKuVH8WoZBo5dg88Xa?=
 =?us-ascii?Q?uq0Dmr9bD9FMz4kQ0iEYtienBhJ/v9ZiHwEh7rXAIAsEnE+fJnm6FgwSZ+Vs?=
 =?us-ascii?Q?rD0KCZ/0035mKpmRzm6TFIxICaAJLT86Deqv1TlJwyB/H+TdMIW6VrhK47AO?=
 =?us-ascii?Q?tHdjfal9BRXtC0QRqphT/02ik3s9YP3GvFIeqSZJwcdIxYCKskcqgSf3xjyR?=
 =?us-ascii?Q?EagBA3Um30mJ//zQBabMsA7avz5XHre6ty3u3in1p6gbcE2JChENuM9F6u+o?=
 =?us-ascii?Q?ArFU73WY/IHEJBnDtL1v+35YcAVsQt/daDWTQOp7B7ytC/k+E8U4GVLbHspe?=
 =?us-ascii?Q?X9LkgdP95gVs4XcjDStcRCsHH5w8v99II6/iOG6zpbWqYuv8dlJW13Gabq8M?=
 =?us-ascii?Q?qqFlwLlbgG6Yc1d9HUtoft8bkX05rc3z7hvT7imCpcppT+jIiQHZsGjfCpgc?=
 =?us-ascii?Q?D+bssw4xEyXLgPynqblJfBnt4DimFREigOw+O720Wm8hRqqQdGqUF2TIctLk?=
 =?us-ascii?Q?3G7BKhmADffS0Fjl5+bQRiRMdi8cBHVLJVTKj5LB6z4cgiS5Aj2jYecwANE9?=
 =?us-ascii?Q?u9yOvqbGvpJSA7J07IOCtAGKuVBrPaaCBihRltW2PVYaYDxXqiv+lReKgT30?=
 =?us-ascii?Q?oeQhu2bw3AmxZP3+jO6RnPILZyPKo8DCWhb1k9L2QWowqVi9m6ciR2iHReT4?=
 =?us-ascii?Q?MHbynPU4MsaJ1/Ls7YEpBz40yCCrGNxW0wy6+h8MUx74hjpINUiJm2m9VnwB?=
 =?us-ascii?Q?pBKUost/Q/80yXX+m7RovKWjimNFzmx50OEsbxQk3WIyMBRgzOMYEAdg0VPH?=
 =?us-ascii?Q?ucWaWCua+6CqpiMnqQTBmA6JY+OjugQGU6vXQQ6Ofn0FdHPRQ3kdHsrOrn4g?=
 =?us-ascii?Q?03VMPuEyQa/5P8BIZeH0SawSBxBK+O7+?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?imrBDmehuzBweCXJQ8IhHfzZ3BJp+lwn/t8bNCxdTNTzWAD4XQZUoSco3Hup?=
 =?us-ascii?Q?xFW/JQxxV9u4t9jTMuBHwL++XdAqqSy2Ki+fPJSZrSBpiogVmO2cisIMJlUV?=
 =?us-ascii?Q?LQXZeW5XiE0eghnWYEdMR64ES91OJnmdQyUHpEToLLtzVIGSSrPydGsAqIqH?=
 =?us-ascii?Q?cMI02Yd7pXLTh8gE2jidKKP0rV69smbnbr4EuEdgehI3vuP0XqOtbMGqU3LJ?=
 =?us-ascii?Q?aUj38Gc6x3jcqoV5T3aeWVaoi8dl9TpN3+E8Vbl2dRECMZxam5xes+DzAWC4?=
 =?us-ascii?Q?up6BJ+GeM/kX8gQB+VwBmLdEQ5OyJhzpAYrEUQfaQfBjxDqBULLXPQsvW/9j?=
 =?us-ascii?Q?lwU86E5rTBQfniUBvlKj72f6a2L+yABCvO7wpnRs9+SH55s8wQBqOK7/lst+?=
 =?us-ascii?Q?utmyU0NlMAfk9fHY5SClSU3Ys4pBZZvF0GWb1gZZzI5yTbj9839t5oKNVFY5?=
 =?us-ascii?Q?RgLp4SC4f21W0uuoGnN6uJHqFapEyy07Qj/nZnOg+zl506TSO2cG7KSYfl9A?=
 =?us-ascii?Q?CHffIKqiwhIp+q2NbUeyfqK6Thm9YCy6+LERxXlCC2ELr0Jb+sLEYWsqPcTN?=
 =?us-ascii?Q?ETVfdbpP988MwNfk/biFb3/dFJ0MFHlYnje8rnJnrvo1d8WPOIMYMm3brXxj?=
 =?us-ascii?Q?Xz1PP1kF/8MUe6Rj28VJ3tslpfxB4D+Zukoo0e2XJ62CZWhPuxrWp5s3uriK?=
 =?us-ascii?Q?lUTgsAGenpZSTjINtKZEqXEUwEZYF7germ4JTc1lLPcHslgzKbOrggL25Zrc?=
 =?us-ascii?Q?cvRdd3CAFlerTG/PtaVgdWSM5Bax6udafOJo6ds3sCkqh6WvxYlFZOJ9tCVk?=
 =?us-ascii?Q?oqV2v8EPzlwPLzKyoFBdm7AzQB1ZgbEsxKzFgfKHpk8YXCb5vKWx3EXGbuIO?=
 =?us-ascii?Q?E07T/A148/kSa+bvNggQA/AWsQPn9qL/hdbYUq/vwhvsrGaKhCaeMxrEiPYd?=
 =?us-ascii?Q?0Z/Oh1lrlisEbw8YMSDIeUQBgfwK5Xe5w+KJNQzpojskebmCtENDaCVvEzrr?=
 =?us-ascii?Q?0o056jYpEqq5YXHstFygvjcdlegO00h5/rvUVy2VosDmAZwTx7HHO1oDjEy6?=
 =?us-ascii?Q?VIFsiAuijrT8I+Ii4eDAcoPAX16bBCyLpjDQExyiNmCD1juyOcSQPqDyr8m7?=
 =?us-ascii?Q?dRSAWtNj4dOLqCAzCYthWd3a7RrzklCA3xJ2HzbZ7YlKrlvDO1dXtgaR0IBw?=
 =?us-ascii?Q?VdnKiTRECD7hn7G0n+b9Sq18IYhbQGIANyTHNHlwGB6ZTNbkjPcLYtDQ0Xbp?=
 =?us-ascii?Q?r73nSpwNexwGlKhZlSzde16mVp6BJsL7dToJI1lcWHm2JVy+/ekIYuUuPfSy?=
 =?us-ascii?Q?K91m57KeBe9+9xBpo12o14JbWjAGUf43QTkxcR5RRQD52b3pWHF0wskhF9mu?=
 =?us-ascii?Q?TKsWhyLwLIAoHry10fqHH8q0+3VTL4Q5jQDMEe/hhNgVdXvDrrB42nC8DV/O?=
 =?us-ascii?Q?IcCKVQLFCD+kUh/Ojx0DS+gsnCk2/TIG3MFEKwjZLtE5pOQ/CFsMPWJWuzVQ?=
 =?us-ascii?Q?u5hq4X+C7DZh27+8EMugf9m59d7XT3yFfdUlTCk3Wo8ownkRRU++VBdLfflY?=
 =?us-ascii?Q?OBxk13GIa23D6Xvll2GrDd5THaMAkbY/AtJSJ7hW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bd2672-e7d3-4da4-1e85-08dd4c5dcd90
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 18:39:52.0365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xg8RNTjJi2TWIuyJG2c9mRKtkBZmfMt0P33mXHDsz89PSY6BQuvu7TtUvZ3xo21hFyHeGO06Mfe7JNyRFmIAgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5265
X-OriginatorOrg: intel.com

> Yes, although there is some hard-to-avoid fuzz about the precise
> meaning of "local" and "total".

Things are only getting fuzzier with mixed DDR and CXL memory.

> As Reinette pointed out, there is the also the possibility of adding
> new named events other than "local" and "total" if we find that some
> kinds of event don't fit these categories.

Not just new names, new scopes too. Patches coming later this year
that would present:

$ cd sys/fs/resctrl
$ cat mon_data/mon_PKG_00/llc_stalls
779762866739

I.e. a way to cheaply collect some "perf" like events across
all CPUs on a package that executed jobs with a specific RMID.

Of course this can be done with perf today, but the cost to collect
this data from heavily multi-threaded workloads that context switch
rapidly is very high.

-Tony


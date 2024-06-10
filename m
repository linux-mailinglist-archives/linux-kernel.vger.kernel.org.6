Return-Path: <linux-kernel+bounces-208844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE729029D6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71122282E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF35B405E6;
	Mon, 10 Jun 2024 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dvh7dlkM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25161D52B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050662; cv=fail; b=W5WoZfWbg6eflczOBzcuYhEnGJ0282NzKt0fguEwCd5gUutepYlvZUj1XstDCu7qLo/LdV1KPAWT8tJR9sKhJrB5pNDpCKrBj0XJ2FL8JY8vjRbhgbWZwfCpe3lG0e/urrSC4rGFyRNVqx7cmiyD7Ofp6v1Ap6PaOGkxIVoTj3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050662; c=relaxed/simple;
	bh=gsKXiphc0gackuNkIwAksR5xJSsYAIQfkq0/6HFyIk4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m5Bg2K0NiWYFfYwyVRUlf3tklcZcvTr/9rOhE4yy/xud252HuRxT8iYH24XgzZajqSAqAgucl2xhIgAw4CTHrVNnHPCExCDil07bPDDGPvZ9dO/6ghQnEDLcNlJNuTp/e6DJ0ZHfo/JVai7c5BTCXwradZWCC2NnEzxZtxbuko4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dvh7dlkM; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718050661; x=1749586661;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=gsKXiphc0gackuNkIwAksR5xJSsYAIQfkq0/6HFyIk4=;
  b=Dvh7dlkMf3Hh9sMiCWnQbhwQkwg4wZIH7fB1zIShR8i1vG5tT9cScvke
   owiLZBjhcIAPDi435w3RODHJiX7FzqO+9dZnKA9pB2lJZAng7Yr+jr2+4
   Xg/hVSQSCJAFXojfxR86UqdV6wUDm/y43I9r3esRyH1NxUykDNj/1DyNP
   kWB6SPMn544b0Jv1XdFy06ydNrT9iNUpUPG1ap4ZvWSrUZ/9jz1yXfRea
   NVUz58JUUKTr6s5Is4lOtIWACEtnzxswVePTKa+YP8vCZrbCrxIUxA/Lg
   dM0wGwqfmgcg8CtVdS067C3RawHz674L/i94JQRaKFqkmQ/aL7uHlzVJP
   A==;
X-CSE-ConnectionGUID: pTcGHtBDR9SJMsYQWfE85A==
X-CSE-MsgGUID: bCibHbQUQ4itVMx6gVBF+w==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14858768"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="14858768"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 13:17:40 -0700
X-CSE-ConnectionGUID: IecCBAW+QfOC/GpjbVd5dw==
X-CSE-MsgGUID: IenzOJPOQ5m5zVf1dDQEvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39091518"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jun 2024 13:17:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 13:17:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 13:17:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 13:17:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiZu9D6onXQmfC5+xj3ncIKb1gyFpL3JLBupEhIPNWjClhr+aob7+0DLvg3EOQHJXDXFtLZt/k56C/NkWZPZZ8bWrg8GdpKt498laE9QSX+LxA/ME0JCw81vn5Ae6os737cC6Qz+hxHjOxZ1a9jyflJ8kHxB+Dx0Ef8Zv9m44+F4C6EFFTUgsLQ15LuB/5JHxcmyOklhSZFc7i8qwcoc8SKeVIbMU6EEkvw5qNPsBv7uFmjUDKg8sauY+HR8K+DCaLiIogvssKrmkpSrlbSyHlIkwgeVcg+3Q91pEniD6a32lyGlvr7TgdM5ku+Xx/KS/9x7PG3kgmXblW+bCT9PPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=US0Os+gMMTrTgdSc66E4q+CPEmnfTiWOxk28rVXw4g8=;
 b=M15rlViIVjr43zbV4eQUzaRGgAz8lHRI/aOO7F1vSPKnu9r8trygoIO6KHtokpRfC5r+w2H31tIsPfVNqR1tJQGiRaGgU3OP+CMO4du1WmtgQIfb3P7NMo2aCQheAacTJGd4GjU2/QtUrOiEzTa81Azobuy3OpZuLQXZhTDs8QuP/WrQybJqCbC5PfSbyZcyirHNMN+Zrl9Pzz+Q4ckd7iR0VNBS5TgOC2ObXPqFe2Vpkbq9h1yC0FSeuU378VuB2ok9Qmdy7u/fgi1raCRU9za50eep6OMKh7WDlFm9tXZCrSU8gt+5LEjsQBLQ4L4sXzx1Bsoxqw0Pfbw1vU2HSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2854.namprd11.prod.outlook.com (2603:10b6:a02:c9::12)
 by DM4PR11MB6430.namprd11.prod.outlook.com (2603:10b6:8:b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 20:17:36 +0000
Received: from BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42]) by BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42%5]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 20:17:36 +0000
Date: Mon, 10 Jun 2024 16:17:34 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: =?iso-8859-1?Q?Jos=E9?= Roberto de Souza <jose.souza@intel.com>
CC: <linux-kernel@vger.kernel.org>, <intel-xe@lists.freedesktop.org>,
	"Jonathan Cavitt" <jonathan.cavitt@intel.com>
Subject: Re: [PATCH v5 2/2] drm/xe: Increase devcoredump timeout
Message-ID: <ZmdfXmPKE177-Rfo@intel.com>
References: <20240610161133.156566-1-jose.souza@intel.com>
 <20240610161133.156566-2-jose.souza@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610161133.156566-2-jose.souza@intel.com>
X-ClientProxiedBy: BYAPR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::40) To BYAPR11MB2854.namprd11.prod.outlook.com
 (2603:10b6:a02:c9::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2854:EE_|DM4PR11MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b7da65-432e-49ff-f63c-08dc898a5ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?5la37/b+RSFuL7OI50haPfV0GJC7RIBRBcNuSe+Hcg/AGAYfvxDclapZeR?=
 =?iso-8859-1?Q?N0NWNvVPfvw0DaDpEoZiHdrgGuoW9dt+mtW71yEimzrYflR67a7xGzH4S2?=
 =?iso-8859-1?Q?xtRoKegdOqyXz/mhlyAneGLRYPoafWKQdHSDqm7iq+BX4byK5zP62usO5X?=
 =?iso-8859-1?Q?f/Fs3U+tM5OTrA9zBZc9F0syuQszyB8pNyYKTKLVhwPB61UhqsjS1LP+84?=
 =?iso-8859-1?Q?k06iKmtBamdLSD5rfyHehKpBgGgSEnerRGn/AOBC/SwdX9pu739WMcyLZ/?=
 =?iso-8859-1?Q?0oTMljuAF/lsQuPWWCeB52i8rEqpyd22zgyUBurZrIxutuFCc2wEjbSNmQ?=
 =?iso-8859-1?Q?NQZ0jD5grRBB6iTa3XzWax5W9Zncixsd5cg/uj4fyFuYWZoTrx3xlGhy2e?=
 =?iso-8859-1?Q?2vJkEHUQFKn3OvL2+EQE/toVGk0NveES4Xd47W8N6HYE4cKuHz8oAnVERI?=
 =?iso-8859-1?Q?9sEvCORn0S1ynevulvJap/dS4+ym4iP1TFWGpt+l3jb7bqfER3byKJjAM2?=
 =?iso-8859-1?Q?oUQFBWzmXpgs72qqxS1qfFVBLdM1UaCZW7RDRQ/WPr5kbP7ECXSOugiL5h?=
 =?iso-8859-1?Q?44EPfWUj/Z5eADWT51dFd7G4E9zSbtYFT5+XTeNbmOgUd5P9r+cmnWNYiO?=
 =?iso-8859-1?Q?f+q691Povftqo6DT8EaIEkJQgWoo+lEloYZ+ZQqZg+lN5dQSfa62S0EN9q?=
 =?iso-8859-1?Q?SLS0z0LjARTCUUlcBPZXffYrGZ7rTR5FKJ0FN0+lzTxuXPxULy78HHTCos?=
 =?iso-8859-1?Q?c35qjpgCYgGlJnbe0Kyrfhv774Nc6UHS9/1RI51/cGRn5/cCvX9AlUNSPo?=
 =?iso-8859-1?Q?nXbI0wXFr0U2szCXSWDwQ8pDw1g7W+571rKQvGot5wHKK1eCYEE5sP2jZd?=
 =?iso-8859-1?Q?dzqoZSpljaeKcwZYmOoEn99X/YLuyZHEze6ABA9lsB67TA7ZEeKqpacdbd?=
 =?iso-8859-1?Q?Rqhg6Snte1SITuFeRgGvAKmqyDdY5Z+l7qxrZWZqKQ3ezP5cB/uP9MPC6i?=
 =?iso-8859-1?Q?tnGG1T0rPM8tgP0dYtpO6iPu66Ds83IAjnzdcU4xcq86c4FTUUdAe1IdzC?=
 =?iso-8859-1?Q?mzPpbJxACajx99MqfzO2WUZ218rrkbr52jz91ZCH379Kz5ChQf98BBpr3e?=
 =?iso-8859-1?Q?cVuh2i3PKqrJN5nw8gP2OsGxLTwLOhrblvpj20axSYThNH5Jtwcv8M/Hlw?=
 =?iso-8859-1?Q?gwZ6rxVe28okkjL0YgiiKstRNOFI0bUKoJKpmr6Thsy8IAeul4sFeINMZ0?=
 =?iso-8859-1?Q?ZVJ0s1IXQW8+F61LLpRuqvoQmd8/hz1cydpLI/yo1gOiZcI7MFaDPiSBaD?=
 =?iso-8859-1?Q?mDOd4jm4PfBKMRazpSTaUnkk8XLJEcPL+57UgYtab0x27/Lo/kYpkjPfCL?=
 =?iso-8859-1?Q?/ikD2Yj3vr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2854.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kKEO2AA67/rCKULgjDfntYxQ/lUHfXP9aX0SYMbErtlyrVk5FSO8hcDd04?=
 =?iso-8859-1?Q?yQrngUAwTrcOqe2cLhrVDLo3mlRbJhHJ/OKiS2Wv4zAbagGUTMwXSHqF+i?=
 =?iso-8859-1?Q?AGMwWAgC8OIcaCeq26szKwfRZhGAjUSB/kRPAntgDbwHZsr/vWxniaT5NK?=
 =?iso-8859-1?Q?P3WSLIYSUAkd142oZ0xP5HqBgbJglPrTIaCNYS0Uzy6fTymn5rmSxV3HaR?=
 =?iso-8859-1?Q?bjJA2ZQVDqoawBcCG1eFwD7VBGuPdz03ThdEd2LIfmzfYILS9F16VcLIYM?=
 =?iso-8859-1?Q?fv0IeRnXR8DlLJTxTChIvKRybF3Tij+dVUIu/ZKeuaWSSymCmtt8lUIQCJ?=
 =?iso-8859-1?Q?OYkLw5VXTB6/Uc8quWJZcPDDDaTmGGo8XU7Zia4HdCJ7gVKi5o2x7LAL28?=
 =?iso-8859-1?Q?zpbYbLFkMo1yNSYwiBYlSxV7Jnbj8nuHvnsVZrM98ES9bOmtTjHAihFebo?=
 =?iso-8859-1?Q?8GU6yHXCdZtoSjulkevNreGijTtqna4WUC7JOhuOS4y2WV8u4f7kqKKeYK?=
 =?iso-8859-1?Q?KFVxHHpTWp7QgoZ2b8mzy67pc56n6ukvjG4ENrr4D1yl5VBAUlGdDVr745?=
 =?iso-8859-1?Q?O3NQ7dMZ2GUgYrNM8agelqCXBJao+BkQvAbo2aB9OvOuhj7HLh5dGo3/LR?=
 =?iso-8859-1?Q?vihUmpGLnF/0oFM1h9gGtqSZHlg39yzywz6fRKGRfZZh7S6JfOvgR8wFZx?=
 =?iso-8859-1?Q?I6ry1VG9Zwskxm2Uz7LbiJiCkDZajZzPpuJNMItIADe+RwOTzFqzeAmLC/?=
 =?iso-8859-1?Q?VULKrXTsbfHgJ8jy7z0my5jhaWGta5f03lq9iDR6AvLrvBybW5Vz27TJeG?=
 =?iso-8859-1?Q?RGtBTQqB5jLRWkpnJ2DAP5AcpjCkrtJYgJz6KvQI/sdWzBcZIV3RrrMJy1?=
 =?iso-8859-1?Q?8Fw04723oIxscCYU0QsOL7Zn51HBR3GvOiWinZKxan+IF5Igiwb5noumCu?=
 =?iso-8859-1?Q?x2OO3VxFrnPd8qz+D6F0kot+WelSrkofpWjtLB88AFcqYxmnX1B+Rkddc3?=
 =?iso-8859-1?Q?yi5uJmMKzfR/gCvZCsYV8C1GGZajpl/Ksu0a464GvofBOMQFHsOh/hBpnO?=
 =?iso-8859-1?Q?LU+AfL3gEJ3JRi3vjdSxSO69sW805aWB1Xk+dTdEQSmCsHKyNCWrZL9sYm?=
 =?iso-8859-1?Q?IqxMdyZTFMZXJPARv0EQqX5AeGDHBxQrk3bwdLG0tD5hPJM644btXJpckb?=
 =?iso-8859-1?Q?QISp+z9VCghf+vVJCMJ97COeyldmYkXD/wMMYdhqvHKOcAhgafyMAVZwbR?=
 =?iso-8859-1?Q?10Cj2UovoI7859NZoYwMSg0tCl0fKRvGkFR7nImvtQ7w0j1sHXdz6/xbtX?=
 =?iso-8859-1?Q?jYpubclGa/J5l2vKO+jf+XCY90/Mx8kSacHRClW5p81LinC17quleyDxjW?=
 =?iso-8859-1?Q?7b/Ldno633YJIh39pbn4nzyQREOf/mhikLgaWlxyZZzLDBoUZAHkMldfJl?=
 =?iso-8859-1?Q?puB9P8PrGgWCsZCnfJtxfB2f0XZXtOlqOHtwsLF1zpwSlEZbpVEZ5itjKn?=
 =?iso-8859-1?Q?fI/bakkqKQXAQykIFB2Cg47nNrpLfTgqTf9/qmsYcTBUvMgMOeNs7VGc7V?=
 =?iso-8859-1?Q?Kl5HnvNjNAYH5x/W/HzPMMTUIXfojhIoBoJkFaOwP78p3x8HegqgK11BPY?=
 =?iso-8859-1?Q?7PIy6WN37J3+/nDfsdY0YBNfGVh3BAW1ms?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b7da65-432e-49ff-f63c-08dc898a5ea9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2854.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 20:17:36.8564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlX+LFlYeycXqg8ZJNNtfyrSoLRoqUCHNF2sOlxwjAYFpwcHyyvzFJQPomqLqbf6CMaQ84qKb9cm8P8fU36l1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6430
X-OriginatorOrg: intel.com

On Mon, Jun 10, 2024 at 09:11:33AM -0700, José Roberto de Souza wrote:
> 5 minutes is too short for a regular user to search and understand
> what he needs to do to report capture devcoredump and report a bug to
> us, so here increasing this timeout to 1 hour.
> 
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Acked-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_devcoredump.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
> index d7f2d19a77c10..62c2b10fbf1d2 100644
> --- a/drivers/gpu/drm/xe/xe_devcoredump.c
> +++ b/drivers/gpu/drm/xe/xe_devcoredump.c
> @@ -53,6 +53,9 @@
>  
>  #ifdef CONFIG_DEV_COREDUMP
>  
> +/* 1 hour timeout */
> +#define XE_COREDUMP_TIMEOUT_JIFFIES (60 * 60 * HZ)

o.O! 1h?!
we should likely already add a config option for that.
but anyway, let's move with that and adjust as we go.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> +
>  static struct xe_device *coredump_to_xe(const struct xe_devcoredump *coredump)
>  {
>  	return container_of(coredump, struct xe_device, devcoredump);
> @@ -247,8 +250,9 @@ void xe_devcoredump(struct xe_sched_job *job)
>  	drm_info(&xe->drm, "Check your /sys/class/drm/card%d/device/devcoredump/data\n",
>  		 xe->drm.primary->index);
>  
> -	dev_coredumpm(xe->drm.dev, THIS_MODULE, coredump, 0, GFP_KERNEL,
> -		      xe_devcoredump_read, xe_devcoredump_free);
> +	dev_coredumpm_timeout(xe->drm.dev, THIS_MODULE, coredump, 0, GFP_KERNEL,
> +			      xe_devcoredump_read, xe_devcoredump_free,
> +			      XE_COREDUMP_TIMEOUT_JIFFIES);
>  }
>  
>  static void xe_driver_devcoredump_fini(void *arg)
> -- 
> 2.45.2
> 


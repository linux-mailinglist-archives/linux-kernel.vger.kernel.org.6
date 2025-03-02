Return-Path: <linux-kernel+bounces-540513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EC1A4B190
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 13:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6338188CC97
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 12:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D31E1BD9DD;
	Sun,  2 Mar 2025 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D2lQODd7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF3011CA9
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740918671; cv=fail; b=SIS98paIdgR/Ubrpog2CAdXeBPO3H9M8kKZrsw14Ai3eSIBqti6fghqF+EsfHauXrAri61w4Gi4kBY8KdgbtYXT/8SyoVgV8Kh3CZzotDf2doLoxMfr3Cp0MmgIlcjNxZbCHI/hFbgJUm9DQfW/kDEhxLBO5y97LMgD4dtkZJS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740918671; c=relaxed/simple;
	bh=COnjPiB25oWjdFaGLkDs/Bo0awV7q2jIeubcTlqQcq8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=t60TWyLyGejNSaZWf6pdVwtCosY+jMW1X9Ao4wUrTRsplf+O9UpMQxQagoIp+tNGE3bDpEewqMx1tCHxgqKIpdU8uusoe17d+dcl5rcIqgjMW4oDNkIeWWh4YcVQaG6cU7V8wW3MWvzsmiZkqubFJT3p0TlB8luxsKMHWrk7W9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D2lQODd7; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740918667; x=1772454667;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=COnjPiB25oWjdFaGLkDs/Bo0awV7q2jIeubcTlqQcq8=;
  b=D2lQODd7LVdv5hs+xS39FnE9taY9RTNQd0IDxqQYyjzg3JtEKkaPWCEi
   lwRZTD3tgNKfLTjx9681N6t7kl007MwBus0AiVAjOe1T6lDlZzhZu/nLs
   34jxtUIOA/qYYyP0jXg1I+xE6/BrL+Hvxb0HUimsC8T24fQXQMgAq+b2l
   Ky0wLhmJasJM4UC1Q50k9BWPdlGqaVJx16f+qTYH5KgtarCHwBxf1zUyG
   P3twgPWbdMng0kLMr1jrE0mjX70IUHt6w7JeP4jXABXdsYJxnnpbelrs8
   eeDbSaPwh3RLmuHukvtYGKq+ElPzr3GZvzXYJ3tFnRi9MfCc5m05eSWEH
   w==;
X-CSE-ConnectionGUID: qn1S2KMkRsawIgwrczGHKw==
X-CSE-MsgGUID: bYIEEQ0aR0SgOWRynWcV4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="41922170"
X-IronPort-AV: E=Sophos;i="6.13,327,1732608000"; 
   d="scan'208";a="41922170"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 04:31:06 -0800
X-CSE-ConnectionGUID: iHTkYBMoRz+QVHMBAcVR4Q==
X-CSE-MsgGUID: pk4V96fMReyRj52FBzfcFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,327,1732608000"; 
   d="scan'208";a="117756794"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 04:31:06 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 2 Mar 2025 04:31:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 2 Mar 2025 04:31:05 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 2 Mar 2025 04:31:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HF8xxa+Y+RxCuP+fNPiSodIfiukiVKULGaI8sJEaRJiZq0MEiUHqaJKvxOBjAu7s49HAahp2eNcRMuF8odi+WnJmnhUlkuK/I9DJYTC5sed/XDzkkAmimBuPYWmAyjunDNor9rFQcR0pbz46zppeO+QxCmhDpNjy595JCTQYZhBretIiL7/qjxZAveaClxGv1mhrmjQLMbdNOLQ0CCa9Tv7P+BarIXdmPBlN2BMmLygTJT00nnK6WUkT5U9SasU412mvJsRGc3G2lXT01jpRBe3URds/RSoMRVCxQTF4X4lJWRgKjXDlRtTMq78gkGUW63NAeJEN4aSrQAa9Tf/jKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNblqDf6r60IT7fn2UMhF6G0MmCtTRK3rkceU1eju/s=;
 b=JYDvxs7Euyb0vPN3BlMKEK3xi2UFccWN/vnaIrNlcbCEzRqkv7pW3yQwjWM9NBfe2Zn6ABwVTWfpL1usheVvQw6nkIIJeLdoRLmrc8jCh2MZeJJ4iqy4cCbf+YZFBSJpvS/x0r3mwEBZikP2Hp8lfCjoia8qb2UrSHGq+CR/pOBQ2o41dz6tLzIoxNuL2gKTJk9xJtP5+/Z407SslKIMzZVeMS7ij7GoQrF/rTUHhoCCr1YoFDX+l/AtjCBxlOzLzTqG36ytYw7A+FHazgPtL5eiSEPZf7qDkJVg134p2bWLeT/89MJm97q/AyuWdzjzGW/DBXzgovC1z/5YkaJV9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by DM4PR11MB5996.namprd11.prod.outlook.com (2603:10b6:8:5f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Sun, 2 Mar
 2025 12:30:56 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%6]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 12:30:56 +0000
Date: Sun, 2 Mar 2025 20:30:47 +0800
From: kernel test robot <lkp@intel.com>
To: Niklas =?iso-8859-1?Q?S=F6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Geert
 Uytterhoeven" <geert+renesas@glider.be>
Subject: arch/arm64/boot/dts/renesas/r8a779h0.dtsi:956.12-966.7: Warning
 (graph_child_address): /soc/video@e6ef0000/ports/port@2: graph node has
 single child node 'endpoint@0', #address-cells/#size-cells are not necessary
Message-ID: <Z8RPd7GUcE2/OWe4@rli9-mobl>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|DM4PR11MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 06466740-fb38-4f9a-1be9-08dd5986142e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|220923002;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?id3iur34MYKt4GB1L+RF/omRUeraizPL8sXSG7k1lJH/0VUkGIUTwtc0+q?=
 =?iso-8859-1?Q?kQCzUc/uDWhRn0O8ROL3uZL8TAHdJyH6nMux3zbIwXrhzXMxCwSid+sGW3?=
 =?iso-8859-1?Q?9+9qBWywf9WodYIZWW+ClkjS31D/rNtyvteUupNEFtZv4hikj+SVo5H4cN?=
 =?iso-8859-1?Q?bLcDGlqyr2kUUoeC4ku1KDN8b5Iy5MndFQ3QWnxpd7ytd+NTJkm6dJIqvJ?=
 =?iso-8859-1?Q?Cf5MSWR/66Y0lheXrTBxb/6kXuiFvBhJ7fF6lauwyLUM9l8HWZ4FWA3DKT?=
 =?iso-8859-1?Q?k1RwyqUs2SafGKlFueU9pxiGuOQyRFPuvYJQsy1MtHDG8erAdY1Av+f59d?=
 =?iso-8859-1?Q?s+HCU+7zgItJPuWzkYWZES/10HvpDhgbby7OrF4SxHhypV5naGHVt4MmH+?=
 =?iso-8859-1?Q?yIInxm/r+eplp1yQ2z8QKEzn2OSaGMgud4xxm9s46PMrQayCcODUfl6Uik?=
 =?iso-8859-1?Q?bo/6IEdwjX8xtik3Od7jaP8Sww6kNOseeVvSeIj4Y1ihzBBMmpQgVD565h?=
 =?iso-8859-1?Q?76a4nmKaE09FXpWw2bxN82uq2mDsYGNGLgtoA1ZGnIf8oL8sk/dCqFCp+U?=
 =?iso-8859-1?Q?qqUhBr9QixIvz33yVJuG8RwWujCBjw6GDaD4sTOGpOmNK9WsIbHHkLSanC?=
 =?iso-8859-1?Q?3Dq67Fjbt+SYgfX0SWqgPzWuJhkpfEGBqSyE6bXEyYyGtioEexv9WefQ+e?=
 =?iso-8859-1?Q?yu+oMrKYCdxSH+8ySsUgLM/A9qyeCjgmfy1R+/rVcFL1Lxn5Kha/7Pd3j+?=
 =?iso-8859-1?Q?a8X+E4hF6kjDHXGLlstA1okn6kK8FCnB1kw/2MqibiK7xYQUg6UDqjl6zf?=
 =?iso-8859-1?Q?H8fomOrPpCJ2oumWPGyBnd67XG6JVTPu48C6jx+IsqS/bdF33QQvlSV9YT?=
 =?iso-8859-1?Q?iOrJ5bGZlX7CJBab2wKyYXqRAK1zcvNPKAg4mdszlqNTpK/aQOXQAAcF5x?=
 =?iso-8859-1?Q?3A4ATYBPOoTnLxCpfxXUAc/g8wmkP6ueTtN5LuTFRVIKHrIPdwLFEr9mob?=
 =?iso-8859-1?Q?iOdAzqitkQwF8c7MDhHjM4ozPiYyorBzVd0zyQS6q65IkyT64+RN/JePkG?=
 =?iso-8859-1?Q?EvHa5mhFbUwa8Hc6uYMNQoB0PnCl0flA7Dn0Kz0jzwqqJE6Thvy3eowjui?=
 =?iso-8859-1?Q?A33aNka59oGcRvn6gaPxRLujn4DmfJ1Jrn/17XTDviwkKZ0FoCrQwkUOZ4?=
 =?iso-8859-1?Q?fLL0saa8RcF+xl6U5D167v7WTwZb371dFqHA7tckNxNLug7dufsF8deRO/?=
 =?iso-8859-1?Q?qTrRKYS1ZKFVRoktnze4eV82e9WH5PqraFQsI6GB9LnsE3MTnoJVnGUhop?=
 =?iso-8859-1?Q?AzYOWpMjM/sQpzy1GQ9b5qJG3nxWXbyDV9nX19k5KW4ZXye7PCGTE4gSIL?=
 =?iso-8859-1?Q?q03iJMEYVNxtq4GFfO9bSYOTtZERYhWBmYZmsmPPdk6RiFEyqzf7gBsceW?=
 =?iso-8859-1?Q?+WgTlwcYTYSH/vgYxa+r6h3wjT1/kbHkUU0uPA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?RVxSOoRB84dsW7Z0wbMBvux58u7kjbi3LdgJdl+JI7KA1va3KhSWPW0nAQ?=
 =?iso-8859-1?Q?po/B1hoHO75ALXn3tXLOrI5zEX4TdBw7Riig5VMhQrlT3Xy434/5Sc5Tn/?=
 =?iso-8859-1?Q?ndlS7g9VR9s1jL3np2Xcr3A1M7yyfbLKe904/f31sR7JvzhB+UMkJsYE0V?=
 =?iso-8859-1?Q?DMZ6Y7CXvn8Y5zsb/sVeVF1UT+LTInJe82OxbHcQx7lovtlbf2mozD/6rb?=
 =?iso-8859-1?Q?s5U3rlLCzJeMIDp3m/Cpo9wCyu5lkxuOQ1cvFgl8/SwqB9zo3Iho2ZlrcI?=
 =?iso-8859-1?Q?zu63lvZVnjd1IkIT0/jh3tcDTXwWpYGoqJ3CyEaseN+GzV2FyOY6ypRkqa?=
 =?iso-8859-1?Q?YE6NmrA9cXvhykB8AG7oqF3ghaDeQe8gKFYJTrQdcw/FbgkyT5jCQCHT3x?=
 =?iso-8859-1?Q?D8Cvnb2m0JxeP64ah8MrfQU9hOL2G2IUGzO7FDPtmtF8Bg/EJ6X3jcs8lO?=
 =?iso-8859-1?Q?f2FJL86C1zxLy/zKgEN9vVpBROCd9VjbzRf4QongRm7DahlatvWiFG1p45?=
 =?iso-8859-1?Q?jd41CFX9omeJ6s/1PrU8Rb3NjSQ+KDlw5v5x599rATlRf+aw1yh114xRhq?=
 =?iso-8859-1?Q?SMFagOO4LsRTa0A0TeOTxq6aqiKEo6NXpONRYZYphleg5vsvVQ7yU37Dpk?=
 =?iso-8859-1?Q?x7SrcGJ9eu9F6M2b4f0ffKe7CVIb+LKtLcHYDcHm3CZePIPEtjmTXevjrE?=
 =?iso-8859-1?Q?Ext+6c/s3cJlAJiIR1puoKbjujRmvU/ZHsPYVQUhGhZIBQIRLzOCxAjhRs?=
 =?iso-8859-1?Q?IGtsXpLj3W4FHpnld5YWdXTaSmmLSu24qmA9aoVGyWra7IWW3MqFu8VIPQ?=
 =?iso-8859-1?Q?oIje3buVlpHgEpOoQKrGgWv8i+cFqJ/h3g3cXw8SEmG/oPGDApbhHsfTfN?=
 =?iso-8859-1?Q?Y6+6wEKh+ehwICDnZdWnntFofRXkdMdSzlH8HOrTCf1wYmga51FE/HqDtr?=
 =?iso-8859-1?Q?2oGsokTsOliK03CdYky0QtoMEPZP4hM5JC+L3I/ZYTV6KkHpbRBxL0c0as?=
 =?iso-8859-1?Q?wsLgj/HxF0g1r20S5uZNGcba0+3nkzogSzRcKJUp9a14TzxTMr5piAayhK?=
 =?iso-8859-1?Q?TL4ockWXXNi87a0el3aLiL6mQQ1bjoH2YbCh0OaZ0tiAxmy06RPg9lybiN?=
 =?iso-8859-1?Q?XvtMBQvmHNaOkgmT5tdJh4S9KyYpEKHbUUpgB74adzLNHpBzHJXKHw9ZiJ?=
 =?iso-8859-1?Q?3N5sSfDMSTdwpZRxTpVnNF8dHN9BEsXVRVbmlnFUabPc4xwSWxHhNRxbbq?=
 =?iso-8859-1?Q?85YT3frammNCy4GvQ5UGvA0KlXuwttPT1bbfPAGyD8yf6SLs+tyxeVaS23?=
 =?iso-8859-1?Q?PGK/B5ncoklc/WWa2gXXLZdM8X3BhlnJdk1SQLGGNzAX0RxKIwgRGKr9uw?=
 =?iso-8859-1?Q?4DgjaUvB4RXfxGVa9NY5ufOX7HbKc82/02DWDvEd2BDgfhiWf1eB9VRMgJ?=
 =?iso-8859-1?Q?ami2lT7IRj99ChSHNoA038MAwXUQ55I0rOOv0E0/nnRv82Tqdj4suAtHZD?=
 =?iso-8859-1?Q?+DWBfjQZIREJ/EFTfBv7QXfLW1EhC2pjPpdCK3yeypdvPArFy+KSWcsLYE?=
 =?iso-8859-1?Q?sJH/x1Ujd5K3+7z4fALPfrXLAGWx/MJs7tvSt12skjN4RkRGdK4tO7+IwM?=
 =?iso-8859-1?Q?rx71NjQ7kZKz7FZxNz9wMkfjysebLt2Ejy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06466740-fb38-4f9a-1be9-08dd5986142e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 12:30:56.2721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxdbNNu/W7xSHmwc+o9iZq4W2r0P4T5JdnlxjenhLmd+nJrWtNYM1AEBp0SZ0BpOf3qeE5uKRBxmyxufRTZJ5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5996
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ece144f151ac7bf8bb5b98f7d4aeeda7a2eed02a
commit: 2bb78d9fb7c997f13309838600eead88cc99e96b arm64: dts: renesas: r8a779h0: Add video capture nodes
date:   9 months ago
:::::: branch date: 10 hours ago
:::::: commit date: 9 months ago
config: arm64-randconfig-001-20241212 (https://download.01.org/0day-ci/archive/20250302/202503021730.xd67LAcw-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503021730.xd67LAcw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202503021730.xd67LAcw-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm64/boot/dts/renesas/r8a779h0.dtsi:956.12-966.7: Warning (graph_child_address): /soc/video@e6ef0000/ports/port@2: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
>> arch/arm64/boot/dts/renesas/r8a779h0.dtsi:984.12-994.7: Warning (graph_child_address): /soc/video@e6ef1000/ports/port@2: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
>> arch/arm64/boot/dts/renesas/r8a779h0.dtsi:1012.12-1022.7: Warning (graph_child_address): /soc/video@e6ef2000/ports/port@2: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
>> arch/arm64/boot/dts/renesas/r8a779h0.dtsi:1040.12-1050.7: Warning (graph_child_address): /soc/video@e6ef3000/ports/port@2: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
>> arch/arm64/boot/dts/renesas/r8a779h0.dtsi:1068.12-1078.7: Warning (graph_child_address): /soc/video@e6ef4000/ports/port@2: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
>> arch/arm64/boot/dts/renesas/r8a779h0.dtsi:1096.12-1106.7: Warning (graph_child_address): /soc/video@e6ef5000/ports/port@2: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
>> arch/arm64/boot/dts/renesas/r8a779h0.dtsi:1124.12-1134.7: Warning (graph_child_address): /soc/video@e6ef6000/ports/port@2: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
>> arch/arm64/boot/dts/renesas/r8a779h0.dtsi:1152.12-1162.7: Warning (graph_child_address): /soc/video@e6ef7000/ports/port@2: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary
>> arch/arm64/boot/dts/renesas/r8a779h0.dtsi:1668.12-1678.7: Warning (graph_child_address): /soc/isp@fed00000/ports/port@0: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary

vim +956 arch/arm64/boot/dts/renesas/r8a779h0.dtsi

227ec979581047 Hai Pham           2024-01-25    11  
227ec979581047 Hai Pham           2024-01-25    12  / {
227ec979581047 Hai Pham           2024-01-25    13  	compatible = "renesas,r8a779h0";
227ec979581047 Hai Pham           2024-01-25    14  	#address-cells = <2>;
227ec979581047 Hai Pham           2024-01-25    15  	#size-cells = <2>;
227ec979581047 Hai Pham           2024-01-25    16  
6bd8b0bc444eae Duy Nguyen         2024-02-01    17  	cluster0_opp: opp-table-0 {
6bd8b0bc444eae Duy Nguyen         2024-02-01    18  		compatible = "operating-points-v2";
6bd8b0bc444eae Duy Nguyen         2024-02-01    19  		opp-shared;
6bd8b0bc444eae Duy Nguyen         2024-02-01    20  
6bd8b0bc444eae Duy Nguyen         2024-02-01    21  		opp-500000000 {
6bd8b0bc444eae Duy Nguyen         2024-02-01    22  			opp-hz = /bits/ 64 <500000000>;
6bd8b0bc444eae Duy Nguyen         2024-02-01    23  			opp-microvolt = <825000>;
6bd8b0bc444eae Duy Nguyen         2024-02-01    24  			clock-latency-ns = <500000>;
6bd8b0bc444eae Duy Nguyen         2024-02-01    25  		};
6bd8b0bc444eae Duy Nguyen         2024-02-01    26  		opp-1000000000 {
6bd8b0bc444eae Duy Nguyen         2024-02-01    27  			opp-hz = /bits/ 64 <1000000000>;
6bd8b0bc444eae Duy Nguyen         2024-02-01    28  			opp-microvolt = <825000>;
6bd8b0bc444eae Duy Nguyen         2024-02-01    29  			clock-latency-ns = <500000>;
6bd8b0bc444eae Duy Nguyen         2024-02-01    30  		};
6bd8b0bc444eae Duy Nguyen         2024-02-01    31  	};
6bd8b0bc444eae Duy Nguyen         2024-02-01    32  
227ec979581047 Hai Pham           2024-01-25    33  	cpus {
227ec979581047 Hai Pham           2024-01-25    34  		#address-cells = <1>;
227ec979581047 Hai Pham           2024-01-25    35  		#size-cells = <0>;
227ec979581047 Hai Pham           2024-01-25    36  
5db13ece46d694 Duy Nguyen         2024-02-01    37  		cpu-map {
5db13ece46d694 Duy Nguyen         2024-02-01    38  			cluster0 {
5db13ece46d694 Duy Nguyen         2024-02-01    39  				core0 {
5db13ece46d694 Duy Nguyen         2024-02-01    40  					cpu = <&a76_0>;
5db13ece46d694 Duy Nguyen         2024-02-01    41  				};
5db13ece46d694 Duy Nguyen         2024-02-01    42  				core1 {
5db13ece46d694 Duy Nguyen         2024-02-01    43  					cpu = <&a76_1>;
5db13ece46d694 Duy Nguyen         2024-02-01    44  				};
5db13ece46d694 Duy Nguyen         2024-02-01    45  				core2 {
5db13ece46d694 Duy Nguyen         2024-02-01    46  					cpu = <&a76_2>;
5db13ece46d694 Duy Nguyen         2024-02-01    47  				};
5db13ece46d694 Duy Nguyen         2024-02-01    48  				core3 {
5db13ece46d694 Duy Nguyen         2024-02-01    49  					cpu = <&a76_3>;
5db13ece46d694 Duy Nguyen         2024-02-01    50  				};
5db13ece46d694 Duy Nguyen         2024-02-01    51  			};
5db13ece46d694 Duy Nguyen         2024-02-01    52  		};
5db13ece46d694 Duy Nguyen         2024-02-01    53  
227ec979581047 Hai Pham           2024-01-25    54  		a76_0: cpu@0 {
227ec979581047 Hai Pham           2024-01-25    55  			compatible = "arm,cortex-a76";
227ec979581047 Hai Pham           2024-01-25    56  			reg = <0>;
227ec979581047 Hai Pham           2024-01-25    57  			device_type = "cpu";
227ec979581047 Hai Pham           2024-01-25    58  			power-domains = <&sysc R8A779H0_PD_A1E0D0C0>;
20a942d60b3471 Duy Nguyen         2024-02-01    59  			next-level-cache = <&L3_CA76>;
5db13ece46d694 Duy Nguyen         2024-02-01    60  			enable-method = "psci";
ad761924be2b33 Duy Nguyen         2024-02-01    61  			cpu-idle-states = <&CPU_SLEEP_0>;
4c1fd23a220dcc Duy Nguyen         2024-02-01    62  			clocks = <&cpg CPG_CORE R8A779H0_CLK_ZC0>;
6bd8b0bc444eae Duy Nguyen         2024-02-01    63  			operating-points-v2 = <&cluster0_opp>;
5db13ece46d694 Duy Nguyen         2024-02-01    64  		};
5db13ece46d694 Duy Nguyen         2024-02-01    65  
5db13ece46d694 Duy Nguyen         2024-02-01    66  		a76_1: cpu@100 {
5db13ece46d694 Duy Nguyen         2024-02-01    67  			compatible = "arm,cortex-a76";
5db13ece46d694 Duy Nguyen         2024-02-01    68  			reg = <0x100>;
5db13ece46d694 Duy Nguyen         2024-02-01    69  			device_type = "cpu";
5db13ece46d694 Duy Nguyen         2024-02-01    70  			power-domains = <&sysc R8A779H0_PD_A1E0D0C1>;
5db13ece46d694 Duy Nguyen         2024-02-01    71  			next-level-cache = <&L3_CA76>;
5db13ece46d694 Duy Nguyen         2024-02-01    72  			enable-method = "psci";
ad761924be2b33 Duy Nguyen         2024-02-01    73  			cpu-idle-states = <&CPU_SLEEP_0>;
4c1fd23a220dcc Duy Nguyen         2024-02-01    74  			clocks = <&cpg CPG_CORE R8A779H0_CLK_ZC1>;
6bd8b0bc444eae Duy Nguyen         2024-02-01    75  			operating-points-v2 = <&cluster0_opp>;
5db13ece46d694 Duy Nguyen         2024-02-01    76  		};
5db13ece46d694 Duy Nguyen         2024-02-01    77  
5db13ece46d694 Duy Nguyen         2024-02-01    78  		a76_2: cpu@200 {
5db13ece46d694 Duy Nguyen         2024-02-01    79  			compatible = "arm,cortex-a76";
5db13ece46d694 Duy Nguyen         2024-02-01    80  			reg = <0x200>;
5db13ece46d694 Duy Nguyen         2024-02-01    81  			device_type = "cpu";
5db13ece46d694 Duy Nguyen         2024-02-01    82  			power-domains = <&sysc R8A779H0_PD_A1E0D0C2>;
5db13ece46d694 Duy Nguyen         2024-02-01    83  			next-level-cache = <&L3_CA76>;
5db13ece46d694 Duy Nguyen         2024-02-01    84  			enable-method = "psci";
ad761924be2b33 Duy Nguyen         2024-02-01    85  			cpu-idle-states = <&CPU_SLEEP_0>;
4c1fd23a220dcc Duy Nguyen         2024-02-01    86  			clocks = <&cpg CPG_CORE R8A779H0_CLK_ZC2>;
6bd8b0bc444eae Duy Nguyen         2024-02-01    87  			operating-points-v2 = <&cluster0_opp>;
5db13ece46d694 Duy Nguyen         2024-02-01    88  		};
5db13ece46d694 Duy Nguyen         2024-02-01    89  
5db13ece46d694 Duy Nguyen         2024-02-01    90  		a76_3: cpu@300 {
5db13ece46d694 Duy Nguyen         2024-02-01    91  			compatible = "arm,cortex-a76";
5db13ece46d694 Duy Nguyen         2024-02-01    92  			reg = <0x300>;
5db13ece46d694 Duy Nguyen         2024-02-01    93  			device_type = "cpu";
5db13ece46d694 Duy Nguyen         2024-02-01    94  			power-domains = <&sysc R8A779H0_PD_A1E0D0C3>;
5db13ece46d694 Duy Nguyen         2024-02-01    95  			next-level-cache = <&L3_CA76>;
5db13ece46d694 Duy Nguyen         2024-02-01    96  			enable-method = "psci";
ad761924be2b33 Duy Nguyen         2024-02-01    97  			cpu-idle-states = <&CPU_SLEEP_0>;
4c1fd23a220dcc Duy Nguyen         2024-02-01    98  			clocks = <&cpg CPG_CORE R8A779H0_CLK_ZC3>;
6bd8b0bc444eae Duy Nguyen         2024-02-01    99  			operating-points-v2 = <&cluster0_opp>;
ad761924be2b33 Duy Nguyen         2024-02-01   100  		};
ad761924be2b33 Duy Nguyen         2024-02-01   101  
ad761924be2b33 Duy Nguyen         2024-02-01   102  		idle-states {
ad761924be2b33 Duy Nguyen         2024-02-01   103  			entry-method = "psci";
ad761924be2b33 Duy Nguyen         2024-02-01   104  
ad761924be2b33 Duy Nguyen         2024-02-01   105  			CPU_SLEEP_0: cpu-sleep-0 {
ad761924be2b33 Duy Nguyen         2024-02-01   106  				compatible = "arm,idle-state";
ad761924be2b33 Duy Nguyen         2024-02-01   107  				arm,psci-suspend-param = <0x0010000>;
ad761924be2b33 Duy Nguyen         2024-02-01   108  				local-timer-stop;
ad761924be2b33 Duy Nguyen         2024-02-01   109  				entry-latency-us = <400>;
ad761924be2b33 Duy Nguyen         2024-02-01   110  				exit-latency-us = <500>;
ad761924be2b33 Duy Nguyen         2024-02-01   111  				min-residency-us = <4000>;
ad761924be2b33 Duy Nguyen         2024-02-01   112  			};
20a942d60b3471 Duy Nguyen         2024-02-01   113  		};
20a942d60b3471 Duy Nguyen         2024-02-01   114  
20a942d60b3471 Duy Nguyen         2024-02-01   115  		L3_CA76: cache-controller {
20a942d60b3471 Duy Nguyen         2024-02-01   116  			compatible = "cache";
20a942d60b3471 Duy Nguyen         2024-02-01   117  			power-domains = <&sysc R8A779H0_PD_A2E0D0>;
20a942d60b3471 Duy Nguyen         2024-02-01   118  			cache-unified;
20a942d60b3471 Duy Nguyen         2024-02-01   119  			cache-level = <3>;
227ec979581047 Hai Pham           2024-01-25   120  		};
227ec979581047 Hai Pham           2024-01-25   121  	};
227ec979581047 Hai Pham           2024-01-25   122  
227ec979581047 Hai Pham           2024-01-25   123  	extal_clk: extal-clk {
227ec979581047 Hai Pham           2024-01-25   124  		compatible = "fixed-clock";
227ec979581047 Hai Pham           2024-01-25   125  		#clock-cells = <0>;
227ec979581047 Hai Pham           2024-01-25   126  		/* This value must be overridden by the board */
227ec979581047 Hai Pham           2024-01-25   127  		clock-frequency = <0>;
227ec979581047 Hai Pham           2024-01-25   128  	};
227ec979581047 Hai Pham           2024-01-25   129  
227ec979581047 Hai Pham           2024-01-25   130  	extalr_clk: extalr-clk {
227ec979581047 Hai Pham           2024-01-25   131  		compatible = "fixed-clock";
227ec979581047 Hai Pham           2024-01-25   132  		#clock-cells = <0>;
227ec979581047 Hai Pham           2024-01-25   133  		/* This value must be overridden by the board */
227ec979581047 Hai Pham           2024-01-25   134  		clock-frequency = <0>;
227ec979581047 Hai Pham           2024-01-25   135  	};
227ec979581047 Hai Pham           2024-01-25   136  
227ec979581047 Hai Pham           2024-01-25   137  	pmu-a76 {
227ec979581047 Hai Pham           2024-01-25   138  		compatible = "arm,cortex-a76-pmu";
227ec979581047 Hai Pham           2024-01-25   139  		interrupts-extended = <&gic GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
227ec979581047 Hai Pham           2024-01-25   140  	};
227ec979581047 Hai Pham           2024-01-25   141  
5db13ece46d694 Duy Nguyen         2024-02-01   142  	psci {
5db13ece46d694 Duy Nguyen         2024-02-01   143  		compatible = "arm,psci-1.0", "arm,psci-0.2";
5db13ece46d694 Duy Nguyen         2024-02-01   144  		method = "smc";
5db13ece46d694 Duy Nguyen         2024-02-01   145  	};
5db13ece46d694 Duy Nguyen         2024-02-01   146  
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   147  	/* External SCIF clocks - to be overridden by boards that provide them */
227ec979581047 Hai Pham           2024-01-25   148  	scif_clk: scif-clk {
227ec979581047 Hai Pham           2024-01-25   149  		compatible = "fixed-clock";
227ec979581047 Hai Pham           2024-01-25   150  		#clock-cells = <0>;
227ec979581047 Hai Pham           2024-01-25   151  		clock-frequency = <0>;
227ec979581047 Hai Pham           2024-01-25   152  	};
227ec979581047 Hai Pham           2024-01-25   153  
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   154  	scif_clk2: scif-clk2 {
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   155  		compatible = "fixed-clock";
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   156  		#clock-cells = <0>;
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   157  		clock-frequency = <0>;
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   158  	};
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   159  
227ec979581047 Hai Pham           2024-01-25   160  	soc: soc {
227ec979581047 Hai Pham           2024-01-25   161  		compatible = "simple-bus";
227ec979581047 Hai Pham           2024-01-25   162  		interrupt-parent = <&gic>;
227ec979581047 Hai Pham           2024-01-25   163  		#address-cells = <2>;
227ec979581047 Hai Pham           2024-01-25   164  		#size-cells = <2>;
227ec979581047 Hai Pham           2024-01-25   165  		ranges;
227ec979581047 Hai Pham           2024-01-25   166  
10c353c7a289a5 Minh Le            2024-02-01   167  		rwdt: watchdog@e6020000 {
10c353c7a289a5 Minh Le            2024-02-01   168  			compatible = "renesas,r8a779h0-wdt",
10c353c7a289a5 Minh Le            2024-02-01   169  				     "renesas,rcar-gen4-wdt";
10c353c7a289a5 Minh Le            2024-02-01   170  			reg = <0 0xe6020000 0 0x0c>;
10c353c7a289a5 Minh Le            2024-02-01   171  			interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>;
10c353c7a289a5 Minh Le            2024-02-01   172  			clocks = <&cpg CPG_MOD 907>;
10c353c7a289a5 Minh Le            2024-02-01   173  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
10c353c7a289a5 Minh Le            2024-02-01   174  			resets = <&cpg 907>;
10c353c7a289a5 Minh Le            2024-02-01   175  			status = "disabled";
10c353c7a289a5 Minh Le            2024-02-01   176  		};
10c353c7a289a5 Minh Le            2024-02-01   177  
9a1442efd1f271 Hai Pham           2024-01-26   178  		pfc: pinctrl@e6050000 {
9a1442efd1f271 Hai Pham           2024-01-26   179  			compatible = "renesas,pfc-r8a779h0";
9a1442efd1f271 Hai Pham           2024-01-26   180  			reg = <0 0xe6050000 0 0x16c>, <0 0xe6050800 0 0x16c>,
9a1442efd1f271 Hai Pham           2024-01-26   181  			      <0 0xe6058000 0 0x16c>, <0 0xe6058800 0 0x16c>,
9a1442efd1f271 Hai Pham           2024-01-26   182  			      <0 0xe6060000 0 0x16c>, <0 0xe6060800 0 0x16c>,
9a1442efd1f271 Hai Pham           2024-01-26   183  			      <0 0xe6061000 0 0x16c>, <0 0xe6061800 0 0x16c>;
9a1442efd1f271 Hai Pham           2024-01-26   184  		};
9a1442efd1f271 Hai Pham           2024-01-26   185  
93e28f88710b2c Cong Dang          2024-02-01   186  		gpio0: gpio@e6050180 {
93e28f88710b2c Cong Dang          2024-02-01   187  			compatible = "renesas,gpio-r8a779h0",
93e28f88710b2c Cong Dang          2024-02-01   188  				     "renesas,rcar-gen4-gpio";
93e28f88710b2c Cong Dang          2024-02-01   189  			reg = <0 0xe6050180 0 0x54>;
93e28f88710b2c Cong Dang          2024-02-01   190  			interrupts = <GIC_SPI 619 IRQ_TYPE_LEVEL_HIGH>;
93e28f88710b2c Cong Dang          2024-02-01   191  			#gpio-cells = <2>;
93e28f88710b2c Cong Dang          2024-02-01   192  			gpio-controller;
93e28f88710b2c Cong Dang          2024-02-01   193  			gpio-ranges = <&pfc 0 0 19>;
93e28f88710b2c Cong Dang          2024-02-01   194  			#interrupt-cells = <2>;
93e28f88710b2c Cong Dang          2024-02-01   195  			interrupt-controller;
93e28f88710b2c Cong Dang          2024-02-01   196  			clocks = <&cpg CPG_MOD 915>;
93e28f88710b2c Cong Dang          2024-02-01   197  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
93e28f88710b2c Cong Dang          2024-02-01   198  			resets = <&cpg 915>;
93e28f88710b2c Cong Dang          2024-02-01   199  		};
93e28f88710b2c Cong Dang          2024-02-01   200  
93e28f88710b2c Cong Dang          2024-02-01   201  		gpio1: gpio@e6050980 {
93e28f88710b2c Cong Dang          2024-02-01   202  			compatible = "renesas,gpio-r8a779h0",
93e28f88710b2c Cong Dang          2024-02-01   203  				     "renesas,rcar-gen4-gpio";
93e28f88710b2c Cong Dang          2024-02-01   204  			reg = <0 0xe6050980 0 0x54>;
93e28f88710b2c Cong Dang          2024-02-01   205  			interrupts = <GIC_SPI 623 IRQ_TYPE_LEVEL_HIGH>;
93e28f88710b2c Cong Dang          2024-02-01   206  			#gpio-cells = <2>;
93e28f88710b2c Cong Dang          2024-02-01   207  			gpio-controller;
93e28f88710b2c Cong Dang          2024-02-01   208  			gpio-ranges = <&pfc 0 32 30>;
93e28f88710b2c Cong Dang          2024-02-01   209  			#interrupt-cells = <2>;
93e28f88710b2c Cong Dang          2024-02-01   210  			interrupt-controller;
93e28f88710b2c Cong Dang          2024-02-01   211  			clocks = <&cpg CPG_MOD 915>;
93e28f88710b2c Cong Dang          2024-02-01   212  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
93e28f88710b2c Cong Dang          2024-02-01   213  			resets = <&cpg 915>;
93e28f88710b2c Cong Dang          2024-02-01   214  		};
93e28f88710b2c Cong Dang          2024-02-01   215  
93e28f88710b2c Cong Dang          2024-02-01   216  		gpio2: gpio@e6058180 {
93e28f88710b2c Cong Dang          2024-02-01   217  			compatible = "renesas,gpio-r8a779h0",
93e28f88710b2c Cong Dang          2024-02-01   218  				     "renesas,rcar-gen4-gpio";
93e28f88710b2c Cong Dang          2024-02-01   219  			reg = <0 0xe6058180 0 0x54>;
93e28f88710b2c Cong Dang          2024-02-01   220  			interrupts = <GIC_SPI 627 IRQ_TYPE_LEVEL_HIGH>;
93e28f88710b2c Cong Dang          2024-02-01   221  			#gpio-cells = <2>;
93e28f88710b2c Cong Dang          2024-02-01   222  			gpio-controller;
93e28f88710b2c Cong Dang          2024-02-01   223  			gpio-ranges = <&pfc 0 64 20>;
93e28f88710b2c Cong Dang          2024-02-01   224  			#interrupt-cells = <2>;
93e28f88710b2c Cong Dang          2024-02-01   225  			interrupt-controller;
93e28f88710b2c Cong Dang          2024-02-01   226  			clocks = <&cpg CPG_MOD 916>;
93e28f88710b2c Cong Dang          2024-02-01   227  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
93e28f88710b2c Cong Dang          2024-02-01   228  			resets = <&cpg 916>;
93e28f88710b2c Cong Dang          2024-02-01   229  		};
93e28f88710b2c Cong Dang          2024-02-01   230  
93e28f88710b2c Cong Dang          2024-02-01   231  		gpio3: gpio@e6058980 {
93e28f88710b2c Cong Dang          2024-02-01   232  			compatible = "renesas,gpio-r8a779h0",
93e28f88710b2c Cong Dang          2024-02-01   233  				     "renesas,rcar-gen4-gpio";
93e28f88710b2c Cong Dang          2024-02-01   234  			reg = <0 0xe6058980 0 0x54>;
93e28f88710b2c Cong Dang          2024-02-01   235  			interrupts = <GIC_SPI 631 IRQ_TYPE_LEVEL_HIGH>;
93e28f88710b2c Cong Dang          2024-02-01   236  			#gpio-cells = <2>;
93e28f88710b2c Cong Dang          2024-02-01   237  			gpio-controller;
93e28f88710b2c Cong Dang          2024-02-01   238  			gpio-ranges = <&pfc 0 96 32>;
93e28f88710b2c Cong Dang          2024-02-01   239  			#interrupt-cells = <2>;
93e28f88710b2c Cong Dang          2024-02-01   240  			interrupt-controller;
93e28f88710b2c Cong Dang          2024-02-01   241  			clocks = <&cpg CPG_MOD 916>;
93e28f88710b2c Cong Dang          2024-02-01   242  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
93e28f88710b2c Cong Dang          2024-02-01   243  			resets = <&cpg 916>;
93e28f88710b2c Cong Dang          2024-02-01   244  		};
93e28f88710b2c Cong Dang          2024-02-01   245  
93e28f88710b2c Cong Dang          2024-02-01   246  		gpio4: gpio@e6060180 {
93e28f88710b2c Cong Dang          2024-02-01   247  			compatible = "renesas,gpio-r8a779h0",
93e28f88710b2c Cong Dang          2024-02-01   248  				     "renesas,rcar-gen4-gpio";
93e28f88710b2c Cong Dang          2024-02-01   249  			reg = <0 0xe6060180 0 0x54>;
93e28f88710b2c Cong Dang          2024-02-01   250  			interrupts = <GIC_SPI 635 IRQ_TYPE_LEVEL_HIGH>;
93e28f88710b2c Cong Dang          2024-02-01   251  			#gpio-cells = <2>;
93e28f88710b2c Cong Dang          2024-02-01   252  			gpio-controller;
93e28f88710b2c Cong Dang          2024-02-01   253  			gpio-ranges = <&pfc 0 128 25>;
93e28f88710b2c Cong Dang          2024-02-01   254  			#interrupt-cells = <2>;
93e28f88710b2c Cong Dang          2024-02-01   255  			interrupt-controller;
93e28f88710b2c Cong Dang          2024-02-01   256  			clocks = <&cpg CPG_MOD 917>;
93e28f88710b2c Cong Dang          2024-02-01   257  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
93e28f88710b2c Cong Dang          2024-02-01   258  			resets = <&cpg 917>;
93e28f88710b2c Cong Dang          2024-02-01   259  		};
93e28f88710b2c Cong Dang          2024-02-01   260  
93e28f88710b2c Cong Dang          2024-02-01   261  		gpio5: gpio@e6060980 {
93e28f88710b2c Cong Dang          2024-02-01   262  			compatible = "renesas,gpio-r8a779h0",
93e28f88710b2c Cong Dang          2024-02-01   263  				     "renesas,rcar-gen4-gpio";
93e28f88710b2c Cong Dang          2024-02-01   264  			reg = <0 0xe6060980 0 0x54>;
93e28f88710b2c Cong Dang          2024-02-01   265  			interrupts = <GIC_SPI 639 IRQ_TYPE_LEVEL_HIGH>;
93e28f88710b2c Cong Dang          2024-02-01   266  			#gpio-cells = <2>;
93e28f88710b2c Cong Dang          2024-02-01   267  			gpio-controller;
93e28f88710b2c Cong Dang          2024-02-01   268  			gpio-ranges = <&pfc 0 160 21>;
93e28f88710b2c Cong Dang          2024-02-01   269  			#interrupt-cells = <2>;
93e28f88710b2c Cong Dang          2024-02-01   270  			interrupt-controller;
93e28f88710b2c Cong Dang          2024-02-01   271  			clocks = <&cpg CPG_MOD 917>;
93e28f88710b2c Cong Dang          2024-02-01   272  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
93e28f88710b2c Cong Dang          2024-02-01   273  			resets = <&cpg 917>;
93e28f88710b2c Cong Dang          2024-02-01   274  		};
93e28f88710b2c Cong Dang          2024-02-01   275  
93e28f88710b2c Cong Dang          2024-02-01   276  		gpio6: gpio@e6061180 {
93e28f88710b2c Cong Dang          2024-02-01   277  			compatible = "renesas,gpio-r8a779h0",
93e28f88710b2c Cong Dang          2024-02-01   278  				     "renesas,rcar-gen4-gpio";
93e28f88710b2c Cong Dang          2024-02-01   279  			reg = <0 0xe6061180 0 0x54>;
93e28f88710b2c Cong Dang          2024-02-01   280  			interrupts = <GIC_SPI 643 IRQ_TYPE_LEVEL_HIGH>;
93e28f88710b2c Cong Dang          2024-02-01   281  			#gpio-cells = <2>;
93e28f88710b2c Cong Dang          2024-02-01   282  			gpio-controller;
93e28f88710b2c Cong Dang          2024-02-01   283  			gpio-ranges = <&pfc 0 192 21>;
93e28f88710b2c Cong Dang          2024-02-01   284  			#interrupt-cells = <2>;
93e28f88710b2c Cong Dang          2024-02-01   285  			interrupt-controller;
93e28f88710b2c Cong Dang          2024-02-01   286  			clocks = <&cpg CPG_MOD 917>;
93e28f88710b2c Cong Dang          2024-02-01   287  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
93e28f88710b2c Cong Dang          2024-02-01   288  			resets = <&cpg 917>;
93e28f88710b2c Cong Dang          2024-02-01   289  		};
93e28f88710b2c Cong Dang          2024-02-01   290  
93e28f88710b2c Cong Dang          2024-02-01   291  		gpio7: gpio@e6061980 {
93e28f88710b2c Cong Dang          2024-02-01   292  			compatible = "renesas,gpio-r8a779h0",
93e28f88710b2c Cong Dang          2024-02-01   293  				     "renesas,rcar-gen4-gpio";
93e28f88710b2c Cong Dang          2024-02-01   294  			reg = <0 0xe6061980 0 0x54>;
93e28f88710b2c Cong Dang          2024-02-01   295  			interrupts = <GIC_SPI 647 IRQ_TYPE_LEVEL_HIGH>;
93e28f88710b2c Cong Dang          2024-02-01   296  			#gpio-cells = <2>;
93e28f88710b2c Cong Dang          2024-02-01   297  			gpio-controller;
93e28f88710b2c Cong Dang          2024-02-01   298  			gpio-ranges = <&pfc 0 224 21>;
93e28f88710b2c Cong Dang          2024-02-01   299  			#interrupt-cells = <2>;
93e28f88710b2c Cong Dang          2024-02-01   300  			interrupt-controller;
93e28f88710b2c Cong Dang          2024-02-01   301  			clocks = <&cpg CPG_MOD 917>;
93e28f88710b2c Cong Dang          2024-02-01   302  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
93e28f88710b2c Cong Dang          2024-02-01   303  			resets = <&cpg 917>;
93e28f88710b2c Cong Dang          2024-02-01   304  		};
93e28f88710b2c Cong Dang          2024-02-01   305  
1552e6ab5ee5e6 Thanh Quan         2024-04-02   306  		cmt0: timer@e60f0000 {
1552e6ab5ee5e6 Thanh Quan         2024-04-02   307  			compatible = "renesas,r8a779h0-cmt0",
1552e6ab5ee5e6 Thanh Quan         2024-04-02   308  				     "renesas,rcar-gen4-cmt0";
1552e6ab5ee5e6 Thanh Quan         2024-04-02   309  			reg = <0 0xe60f0000 0 0x1004>;
1552e6ab5ee5e6 Thanh Quan         2024-04-02   310  			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
1552e6ab5ee5e6 Thanh Quan         2024-04-02   311  				     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>;
1552e6ab5ee5e6 Thanh Quan         2024-04-02   312  			clocks = <&cpg CPG_MOD 910>;
1552e6ab5ee5e6 Thanh Quan         2024-04-02   313  			clock-names = "fck";
1552e6ab5ee5e6 Thanh Quan         2024-04-02   314  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
1552e6ab5ee5e6 Thanh Quan         2024-04-02   315  			resets = <&cpg 910>;
1552e6ab5ee5e6 Thanh Quan         2024-04-02   316  			status = "disabled";
1552e6ab5ee5e6 Thanh Quan         2024-04-02   317  		};
1552e6ab5ee5e6 Thanh Quan         2024-04-02   318  
1552e6ab5ee5e6 Thanh Quan         2024-04-02   319  		cmt1: timer@e6130000 {
1552e6ab5ee5e6 Thanh Quan         2024-04-02   320  			compatible = "renesas,r8a779h0-cmt1",
1552e6ab5ee5e6 Thanh Quan         2024-04-02   321  				     "renesas,rcar-gen4-cmt1";
1552e6ab5ee5e6 Thanh Quan         2024-04-02   322  			reg = <0 0xe6130000 0 0x1004>;
1552e6ab5ee5e6 Thanh Quan         2024-04-02   323  			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
1552e6ab5ee5e6 Thanh Quan         2024-04-02   324  				     <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>,
1552e6ab5ee5e6 Thanh Quan         2024-04-02   325  				     <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
1552e6ab5ee5e6 Thanh Quan         2024-04-02   326  				     <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
1552e6ab5ee5e6 Thanh Quan         2024-04-02   327  				     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
1552e6ab5ee5e6 Thanh Quan         2024-04-02   328  				     <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>,
1552e6ab5ee5e6 Thanh Quan         2024-04-02   329  				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
1552e6ab5ee5e6 Thanh Quan         2024-04-02   330  				     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>;
1552e6ab5ee5e6 Thanh Quan         2024-04-02   331  			clocks = <&cpg CPG_MOD 911>;
1552e6ab5ee5e6 Thanh Quan         2024-04-02   332  			clock-names = "fck";
1552e6ab5ee5e6 Thanh Quan         2024-04-02   333  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
1552e6ab5ee5e6 Thanh Quan         2024-04-02   334  			resets = <&cpg 911>;
1552e6ab5ee5e6 Thanh Quan         2024-04-02   335  			status = "disabled";
1552e6ab5ee5e6 Thanh Quan         2024-04-02   336  		};
1552e6ab5ee5e6 Thanh Quan         2024-04-02   337  
1552e6ab5ee5e6 Thanh Quan         2024-04-02   338  		cmt2: timer@e6140000 {
1552e6ab5ee5e6 Thanh Quan         2024-04-02   339  			compatible = "renesas,r8a779h0-cmt1",
1552e6ab5ee5e6 Thanh Quan         2024-04-02   340  				     "renesas,rcar-gen4-cmt1";
1552e6ab5ee5e6 Thanh Quan         2024-04-02   341  			reg = <0 0xe6140000 0 0x1004>;
1552e6ab5ee5e6 Thanh Quan         2024-04-02   342  			interrupts = <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>,
1552e6ab5ee5e6 Thanh Quan         2024-04-02   343  				     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
1552e6ab5ee5e6 Thanh Quan         2024-04-02   344  				     <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>,
1552e6ab5ee5e6 Thanh Quan         2024-04-02   345  				     <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>,
1552e6ab5ee5e6 Thanh Quan         2024-04-02   346  				     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
1552e6ab5ee5e6 Thanh Quan         2024-04-02   347  				     <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
1552e6ab5ee5e6 Thanh Quan         2024-04-02   348  				     <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>,
1552e6ab5ee5e6 Thanh Quan         2024-04-02   349  				     <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>;
1552e6ab5ee5e6 Thanh Quan         2024-04-02   350  			clocks = <&cpg CPG_MOD 912>;
1552e6ab5ee5e6 Thanh Quan         2024-04-02   351  			clock-names = "fck";
1552e6ab5ee5e6 Thanh Quan         2024-04-02   352  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
1552e6ab5ee5e6 Thanh Quan         2024-04-02   353  			resets = <&cpg 912>;
1552e6ab5ee5e6 Thanh Quan         2024-04-02   354  			status = "disabled";
1552e6ab5ee5e6 Thanh Quan         2024-04-02   355  		};
1552e6ab5ee5e6 Thanh Quan         2024-04-02   356  
1552e6ab5ee5e6 Thanh Quan         2024-04-02   357  		cmt3: timer@e6148000 {
1552e6ab5ee5e6 Thanh Quan         2024-04-02   358  			compatible = "renesas,r8a779h0-cmt1",
1552e6ab5ee5e6 Thanh Quan         2024-04-02   359  				     "renesas,rcar-gen4-cmt1";
1552e6ab5ee5e6 Thanh Quan         2024-04-02   360  			reg = <0 0xe6148000 0 0x1004>;
1552e6ab5ee5e6 Thanh Quan         2024-04-02   361  			interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
1552e6ab5ee5e6 Thanh Quan         2024-04-02   362  				     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
1552e6ab5ee5e6 Thanh Quan         2024-04-02   363  				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
1552e6ab5ee5e6 Thanh Quan         2024-04-02   364  				     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
1552e6ab5ee5e6 Thanh Quan         2024-04-02   365  				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
1552e6ab5ee5e6 Thanh Quan         2024-04-02   366  				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
1552e6ab5ee5e6 Thanh Quan         2024-04-02   367  				     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
1552e6ab5ee5e6 Thanh Quan         2024-04-02   368  				     <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
1552e6ab5ee5e6 Thanh Quan         2024-04-02   369  			clocks = <&cpg CPG_MOD 913>;
1552e6ab5ee5e6 Thanh Quan         2024-04-02   370  			clock-names = "fck";
1552e6ab5ee5e6 Thanh Quan         2024-04-02   371  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
1552e6ab5ee5e6 Thanh Quan         2024-04-02   372  			resets = <&cpg 913>;
1552e6ab5ee5e6 Thanh Quan         2024-04-02   373  			status = "disabled";
1552e6ab5ee5e6 Thanh Quan         2024-04-02   374  		};
1552e6ab5ee5e6 Thanh Quan         2024-04-02   375  
227ec979581047 Hai Pham           2024-01-25   376  		cpg: clock-controller@e6150000 {
227ec979581047 Hai Pham           2024-01-25   377  			compatible = "renesas,r8a779h0-cpg-mssr";
227ec979581047 Hai Pham           2024-01-25   378  			reg = <0 0xe6150000 0 0x4000>;
227ec979581047 Hai Pham           2024-01-25   379  			clocks = <&extal_clk>, <&extalr_clk>;
227ec979581047 Hai Pham           2024-01-25   380  			clock-names = "extal", "extalr";
227ec979581047 Hai Pham           2024-01-25   381  			#clock-cells = <2>;
227ec979581047 Hai Pham           2024-01-25   382  			#power-domain-cells = <0>;
227ec979581047 Hai Pham           2024-01-25   383  			#reset-cells = <1>;
227ec979581047 Hai Pham           2024-01-25   384  		};
227ec979581047 Hai Pham           2024-01-25   385  
227ec979581047 Hai Pham           2024-01-25   386  		rst: reset-controller@e6160000 {
227ec979581047 Hai Pham           2024-01-25   387  			compatible = "renesas,r8a779h0-rst";
227ec979581047 Hai Pham           2024-01-25   388  			reg = <0 0xe6160000 0 0x4000>;
227ec979581047 Hai Pham           2024-01-25   389  		};
227ec979581047 Hai Pham           2024-01-25   390  
227ec979581047 Hai Pham           2024-01-25   391  		sysc: system-controller@e6180000 {
227ec979581047 Hai Pham           2024-01-25   392  			compatible = "renesas,r8a779h0-sysc";
227ec979581047 Hai Pham           2024-01-25   393  			reg = <0 0xe6180000 0 0x4000>;
227ec979581047 Hai Pham           2024-01-25   394  			#power-domain-cells = <1>;
227ec979581047 Hai Pham           2024-01-25   395  		};
227ec979581047 Hai Pham           2024-01-25   396  
e4caa0ba29e235 Duy Nguyen         2024-03-06   397  		tsc: thermal@e6198000 {
e4caa0ba29e235 Duy Nguyen         2024-03-06   398  			compatible = "renesas,r8a779h0-thermal";
e4caa0ba29e235 Duy Nguyen         2024-03-06   399  			reg = <0 0xe6198000 0 0x200>,
e4caa0ba29e235 Duy Nguyen         2024-03-06   400  			      <0 0xe61a0000 0 0x200>;
e4caa0ba29e235 Duy Nguyen         2024-03-06   401  			clocks = <&cpg CPG_MOD 919>;
e4caa0ba29e235 Duy Nguyen         2024-03-06   402  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
e4caa0ba29e235 Duy Nguyen         2024-03-06   403  			resets = <&cpg 919>;
e4caa0ba29e235 Duy Nguyen         2024-03-06   404  			#thermal-sensor-cells = <1>;
e4caa0ba29e235 Duy Nguyen         2024-03-06   405  		};
e4caa0ba29e235 Duy Nguyen         2024-03-06   406  
d28970ddd1b89e Geert Uytterhoeven 2024-04-16   407  		intc_ex: interrupt-controller@e61c0000 {
d28970ddd1b89e Geert Uytterhoeven 2024-04-16   408  			compatible = "renesas,intc-ex-r8a779h0", "renesas,irqc";
d28970ddd1b89e Geert Uytterhoeven 2024-04-16   409  			#interrupt-cells = <2>;
d28970ddd1b89e Geert Uytterhoeven 2024-04-16   410  			interrupt-controller;
d28970ddd1b89e Geert Uytterhoeven 2024-04-16   411  			reg = <0 0xe61c0000 0 0x200>;
d28970ddd1b89e Geert Uytterhoeven 2024-04-16   412  			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
d28970ddd1b89e Geert Uytterhoeven 2024-04-16   413  				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
d28970ddd1b89e Geert Uytterhoeven 2024-04-16   414  				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
d28970ddd1b89e Geert Uytterhoeven 2024-04-16   415  				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
d28970ddd1b89e Geert Uytterhoeven 2024-04-16   416  				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
d28970ddd1b89e Geert Uytterhoeven 2024-04-16   417  				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
d28970ddd1b89e Geert Uytterhoeven 2024-04-16   418  			clocks = <&cpg CPG_MOD 611>;
d28970ddd1b89e Geert Uytterhoeven 2024-04-16   419  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
d28970ddd1b89e Geert Uytterhoeven 2024-04-16   420  			resets = <&cpg 611>;
d28970ddd1b89e Geert Uytterhoeven 2024-04-16   421  		};
d28970ddd1b89e Geert Uytterhoeven 2024-04-16   422  
fdaf6a67806d14 Thanh Quan         2024-04-02   423  		tmu0: timer@e61e0000 {
fdaf6a67806d14 Thanh Quan         2024-04-02   424  			compatible = "renesas,tmu-r8a779h0", "renesas,tmu";
fdaf6a67806d14 Thanh Quan         2024-04-02   425  			reg = <0 0xe61e0000 0 0x30>;
fdaf6a67806d14 Thanh Quan         2024-04-02   426  			interrupts = <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH>,
fdaf6a67806d14 Thanh Quan         2024-04-02   427  				     <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>,
fdaf6a67806d14 Thanh Quan         2024-04-02   428  				     <GIC_SPI 291 IRQ_TYPE_LEVEL_HIGH>;
fdaf6a67806d14 Thanh Quan         2024-04-02   429  			interrupt-names = "tuni0", "tuni1", "tuni2";
fdaf6a67806d14 Thanh Quan         2024-04-02   430  			clocks = <&cpg CPG_MOD 713>;
fdaf6a67806d14 Thanh Quan         2024-04-02   431  			clock-names = "fck";
fdaf6a67806d14 Thanh Quan         2024-04-02   432  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
fdaf6a67806d14 Thanh Quan         2024-04-02   433  			resets = <&cpg 713>;
fdaf6a67806d14 Thanh Quan         2024-04-02   434  			status = "disabled";
fdaf6a67806d14 Thanh Quan         2024-04-02   435  		};
fdaf6a67806d14 Thanh Quan         2024-04-02   436  
fdaf6a67806d14 Thanh Quan         2024-04-02   437  		tmu1: timer@e6fc0000 {
fdaf6a67806d14 Thanh Quan         2024-04-02   438  			compatible = "renesas,tmu-r8a779h0", "renesas,tmu";
fdaf6a67806d14 Thanh Quan         2024-04-02   439  			reg = <0 0xe6fc0000 0 0x30>;
fdaf6a67806d14 Thanh Quan         2024-04-02   440  			interrupts = <GIC_SPI 292 IRQ_TYPE_LEVEL_HIGH>,
fdaf6a67806d14 Thanh Quan         2024-04-02   441  				     <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH>,
fdaf6a67806d14 Thanh Quan         2024-04-02   442  				     <GIC_SPI 294 IRQ_TYPE_LEVEL_HIGH>,
fdaf6a67806d14 Thanh Quan         2024-04-02   443  				     <GIC_SPI 295 IRQ_TYPE_LEVEL_HIGH>;
fdaf6a67806d14 Thanh Quan         2024-04-02   444  			interrupt-names = "tuni0", "tuni1", "tuni2", "ticpi2";
fdaf6a67806d14 Thanh Quan         2024-04-02   445  			clocks = <&cpg CPG_MOD 714>;
fdaf6a67806d14 Thanh Quan         2024-04-02   446  			clock-names = "fck";
fdaf6a67806d14 Thanh Quan         2024-04-02   447  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
fdaf6a67806d14 Thanh Quan         2024-04-02   448  			resets = <&cpg 714>;
fdaf6a67806d14 Thanh Quan         2024-04-02   449  			status = "disabled";
fdaf6a67806d14 Thanh Quan         2024-04-02   450  		};
fdaf6a67806d14 Thanh Quan         2024-04-02   451  
fdaf6a67806d14 Thanh Quan         2024-04-02   452  		tmu2: timer@e6fd0000 {
fdaf6a67806d14 Thanh Quan         2024-04-02   453  			compatible = "renesas,tmu-r8a779h0", "renesas,tmu";
fdaf6a67806d14 Thanh Quan         2024-04-02   454  			reg = <0 0xe6fd0000 0 0x30>;
fdaf6a67806d14 Thanh Quan         2024-04-02   455  			interrupts = <GIC_SPI 296 IRQ_TYPE_LEVEL_HIGH>,
fdaf6a67806d14 Thanh Quan         2024-04-02   456  				     <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>,
fdaf6a67806d14 Thanh Quan         2024-04-02   457  				     <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>,
fdaf6a67806d14 Thanh Quan         2024-04-02   458  				     <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
fdaf6a67806d14 Thanh Quan         2024-04-02   459  			interrupt-names = "tuni0", "tuni1", "tuni2", "ticpi2";
fdaf6a67806d14 Thanh Quan         2024-04-02   460  			clocks = <&cpg CPG_MOD 715>;
fdaf6a67806d14 Thanh Quan         2024-04-02   461  			clock-names = "fck";
fdaf6a67806d14 Thanh Quan         2024-04-02   462  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
fdaf6a67806d14 Thanh Quan         2024-04-02   463  			resets = <&cpg 715>;
fdaf6a67806d14 Thanh Quan         2024-04-02   464  			status = "disabled";
fdaf6a67806d14 Thanh Quan         2024-04-02   465  		};
fdaf6a67806d14 Thanh Quan         2024-04-02   466  
fdaf6a67806d14 Thanh Quan         2024-04-02   467  		tmu3: timer@e6fe0000 {
fdaf6a67806d14 Thanh Quan         2024-04-02   468  			compatible = "renesas,tmu-r8a779h0", "renesas,tmu";
fdaf6a67806d14 Thanh Quan         2024-04-02   469  			reg = <0 0xe6fe0000 0 0x30>;
fdaf6a67806d14 Thanh Quan         2024-04-02   470  			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>,
fdaf6a67806d14 Thanh Quan         2024-04-02   471  				     <GIC_SPI 301 IRQ_TYPE_LEVEL_HIGH>,
fdaf6a67806d14 Thanh Quan         2024-04-02   472  				     <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
fdaf6a67806d14 Thanh Quan         2024-04-02   473  				     <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH>;
fdaf6a67806d14 Thanh Quan         2024-04-02   474  			interrupt-names = "tuni0", "tuni1", "tuni2", "ticpi2";
fdaf6a67806d14 Thanh Quan         2024-04-02   475  			clocks = <&cpg CPG_MOD 716>;
fdaf6a67806d14 Thanh Quan         2024-04-02   476  			clock-names = "fck";
fdaf6a67806d14 Thanh Quan         2024-04-02   477  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
fdaf6a67806d14 Thanh Quan         2024-04-02   478  			resets = <&cpg 716>;
fdaf6a67806d14 Thanh Quan         2024-04-02   479  			status = "disabled";
fdaf6a67806d14 Thanh Quan         2024-04-02   480  		};
fdaf6a67806d14 Thanh Quan         2024-04-02   481  
fdaf6a67806d14 Thanh Quan         2024-04-02   482  		tmu4: timer@ffc00000 {
fdaf6a67806d14 Thanh Quan         2024-04-02   483  			compatible = "renesas,tmu-r8a779h0", "renesas,tmu";
fdaf6a67806d14 Thanh Quan         2024-04-02   484  			reg = <0 0xffc00000 0 0x30>;
fdaf6a67806d14 Thanh Quan         2024-04-02   485  			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
fdaf6a67806d14 Thanh Quan         2024-04-02   486  				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
fdaf6a67806d14 Thanh Quan         2024-04-02   487  				     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
fdaf6a67806d14 Thanh Quan         2024-04-02   488  				     <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
fdaf6a67806d14 Thanh Quan         2024-04-02   489  			interrupt-names = "tuni0", "tuni1", "tuni2", "ticpi2";
fdaf6a67806d14 Thanh Quan         2024-04-02   490  			clocks = <&cpg CPG_MOD 717>;
fdaf6a67806d14 Thanh Quan         2024-04-02   491  			clock-names = "fck";
fdaf6a67806d14 Thanh Quan         2024-04-02   492  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
fdaf6a67806d14 Thanh Quan         2024-04-02   493  			resets = <&cpg 717>;
fdaf6a67806d14 Thanh Quan         2024-04-02   494  			status = "disabled";
fdaf6a67806d14 Thanh Quan         2024-04-02   495  		};
fdaf6a67806d14 Thanh Quan         2024-04-02   496  
e3e7a865c4c7aa Hai Pham           2024-02-01   497  		i2c0: i2c@e6500000 {
e3e7a865c4c7aa Hai Pham           2024-02-01   498  			compatible = "renesas,i2c-r8a779h0",
e3e7a865c4c7aa Hai Pham           2024-02-01   499  				     "renesas,rcar-gen4-i2c";
e3e7a865c4c7aa Hai Pham           2024-02-01   500  			reg = <0 0xe6500000 0 0x40>;
e3e7a865c4c7aa Hai Pham           2024-02-01   501  			interrupts = <GIC_SPI 610 IRQ_TYPE_LEVEL_HIGH>;
e3e7a865c4c7aa Hai Pham           2024-02-01   502  			clocks = <&cpg CPG_MOD 518>;
e3e7a865c4c7aa Hai Pham           2024-02-01   503  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
e3e7a865c4c7aa Hai Pham           2024-02-01   504  			resets = <&cpg 518>;
7a7db3d1d7942a Geert Uytterhoeven 2024-02-14   505  			dmas = <&dmac1 0x91>, <&dmac1 0x90>,
7a7db3d1d7942a Geert Uytterhoeven 2024-02-14   506  			       <&dmac2 0x91>, <&dmac2 0x90>;
7a7db3d1d7942a Geert Uytterhoeven 2024-02-14   507  			dma-names = "tx", "rx", "tx", "rx";
e3e7a865c4c7aa Hai Pham           2024-02-01   508  			i2c-scl-internal-delay-ns = <110>;
e3e7a865c4c7aa Hai Pham           2024-02-01   509  			#address-cells = <1>;
e3e7a865c4c7aa Hai Pham           2024-02-01   510  			#size-cells = <0>;
e3e7a865c4c7aa Hai Pham           2024-02-01   511  			status = "disabled";
e3e7a865c4c7aa Hai Pham           2024-02-01   512  		};
e3e7a865c4c7aa Hai Pham           2024-02-01   513  
e3e7a865c4c7aa Hai Pham           2024-02-01   514  		i2c1: i2c@e6508000 {
e3e7a865c4c7aa Hai Pham           2024-02-01   515  			compatible = "renesas,i2c-r8a779h0",
e3e7a865c4c7aa Hai Pham           2024-02-01   516  				     "renesas,rcar-gen4-i2c";
e3e7a865c4c7aa Hai Pham           2024-02-01   517  			reg = <0 0xe6508000 0 0x40>;
e3e7a865c4c7aa Hai Pham           2024-02-01   518  			interrupts = <GIC_SPI 611 IRQ_TYPE_LEVEL_HIGH>;
e3e7a865c4c7aa Hai Pham           2024-02-01   519  			clocks = <&cpg CPG_MOD 519>;
e3e7a865c4c7aa Hai Pham           2024-02-01   520  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
e3e7a865c4c7aa Hai Pham           2024-02-01   521  			resets = <&cpg 519>;
7a7db3d1d7942a Geert Uytterhoeven 2024-02-14   522  			dmas = <&dmac1 0x93>, <&dmac1 0x92>,
7a7db3d1d7942a Geert Uytterhoeven 2024-02-14   523  			       <&dmac2 0x93>, <&dmac2 0x92>;
7a7db3d1d7942a Geert Uytterhoeven 2024-02-14   524  			dma-names = "tx", "rx", "tx", "rx";
e3e7a865c4c7aa Hai Pham           2024-02-01   525  			i2c-scl-internal-delay-ns = <110>;
e3e7a865c4c7aa Hai Pham           2024-02-01   526  			#address-cells = <1>;
e3e7a865c4c7aa Hai Pham           2024-02-01   527  			#size-cells = <0>;
e3e7a865c4c7aa Hai Pham           2024-02-01   528  			status = "disabled";
e3e7a865c4c7aa Hai Pham           2024-02-01   529  		};
e3e7a865c4c7aa Hai Pham           2024-02-01   530  
e3e7a865c4c7aa Hai Pham           2024-02-01   531  		i2c2: i2c@e6510000 {
e3e7a865c4c7aa Hai Pham           2024-02-01   532  			compatible = "renesas,i2c-r8a779h0",
e3e7a865c4c7aa Hai Pham           2024-02-01   533  				     "renesas,rcar-gen4-i2c";
e3e7a865c4c7aa Hai Pham           2024-02-01   534  			reg = <0 0xe6510000 0 0x40>;
e3e7a865c4c7aa Hai Pham           2024-02-01   535  			interrupts = <GIC_SPI 612 IRQ_TYPE_LEVEL_HIGH>;
e3e7a865c4c7aa Hai Pham           2024-02-01   536  			clocks = <&cpg CPG_MOD 520>;
e3e7a865c4c7aa Hai Pham           2024-02-01   537  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
e3e7a865c4c7aa Hai Pham           2024-02-01   538  			resets = <&cpg 520>;
7a7db3d1d7942a Geert Uytterhoeven 2024-02-14   539  			dmas = <&dmac1 0x95>, <&dmac1 0x94>,
7a7db3d1d7942a Geert Uytterhoeven 2024-02-14   540  			       <&dmac2 0x95>, <&dmac2 0x94>;
7a7db3d1d7942a Geert Uytterhoeven 2024-02-14   541  			dma-names = "tx", "rx", "tx", "rx";
e3e7a865c4c7aa Hai Pham           2024-02-01   542  			i2c-scl-internal-delay-ns = <110>;
e3e7a865c4c7aa Hai Pham           2024-02-01   543  			#address-cells = <1>;
e3e7a865c4c7aa Hai Pham           2024-02-01   544  			#size-cells = <0>;
e3e7a865c4c7aa Hai Pham           2024-02-01   545  			status = "disabled";
e3e7a865c4c7aa Hai Pham           2024-02-01   546  		};
e3e7a865c4c7aa Hai Pham           2024-02-01   547  
e3e7a865c4c7aa Hai Pham           2024-02-01   548  		i2c3: i2c@e66d0000 {
e3e7a865c4c7aa Hai Pham           2024-02-01   549  			compatible = "renesas,i2c-r8a779h0",
e3e7a865c4c7aa Hai Pham           2024-02-01   550  				     "renesas,rcar-gen4-i2c";
e3e7a865c4c7aa Hai Pham           2024-02-01   551  			reg = <0 0xe66d0000 0 0x40>;
e3e7a865c4c7aa Hai Pham           2024-02-01   552  			interrupts = <GIC_SPI 613 IRQ_TYPE_LEVEL_HIGH>;
e3e7a865c4c7aa Hai Pham           2024-02-01   553  			clocks = <&cpg CPG_MOD 521>;
e3e7a865c4c7aa Hai Pham           2024-02-01   554  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
e3e7a865c4c7aa Hai Pham           2024-02-01   555  			resets = <&cpg 521>;
7a7db3d1d7942a Geert Uytterhoeven 2024-02-14   556  			dmas = <&dmac1 0x97>, <&dmac1 0x96>,
7a7db3d1d7942a Geert Uytterhoeven 2024-02-14   557  			       <&dmac2 0x97>, <&dmac2 0x96>;
7a7db3d1d7942a Geert Uytterhoeven 2024-02-14   558  			dma-names = "tx", "rx", "tx", "rx";
e3e7a865c4c7aa Hai Pham           2024-02-01   559  			i2c-scl-internal-delay-ns = <110>;
e3e7a865c4c7aa Hai Pham           2024-02-01   560  			#address-cells = <1>;
e3e7a865c4c7aa Hai Pham           2024-02-01   561  			#size-cells = <0>;
e3e7a865c4c7aa Hai Pham           2024-02-01   562  			status = "disabled";
e3e7a865c4c7aa Hai Pham           2024-02-01   563  		};
e3e7a865c4c7aa Hai Pham           2024-02-01   564  
227ec979581047 Hai Pham           2024-01-25   565  		hscif0: serial@e6540000 {
227ec979581047 Hai Pham           2024-01-25   566  			compatible = "renesas,hscif-r8a779h0",
227ec979581047 Hai Pham           2024-01-25   567  				     "renesas,rcar-gen4-hscif", "renesas,hscif";
227ec979581047 Hai Pham           2024-01-25   568  			reg = <0 0xe6540000 0 0x60>;
227ec979581047 Hai Pham           2024-01-25   569  			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
227ec979581047 Hai Pham           2024-01-25   570  			clocks = <&cpg CPG_MOD 514>,
227ec979581047 Hai Pham           2024-01-25   571  				 <&cpg CPG_CORE R8A779H0_CLK_SASYNCPERD1>,
227ec979581047 Hai Pham           2024-01-25   572  				 <&scif_clk>;
227ec979581047 Hai Pham           2024-01-25   573  			clock-names = "fck", "brg_int", "scif_clk";
227ec979581047 Hai Pham           2024-01-25   574  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
227ec979581047 Hai Pham           2024-01-25   575  			resets = <&cpg 514>;
7a7db3d1d7942a Geert Uytterhoeven 2024-02-14   576  			dmas = <&dmac1 0x31>, <&dmac1 0x30>,
7a7db3d1d7942a Geert Uytterhoeven 2024-02-14   577  			       <&dmac2 0x31>, <&dmac2 0x30>;
7a7db3d1d7942a Geert Uytterhoeven 2024-02-14   578  			dma-names = "tx", "rx", "tx", "rx";
227ec979581047 Hai Pham           2024-01-25   579  			status = "disabled";
227ec979581047 Hai Pham           2024-01-25   580  		};
227ec979581047 Hai Pham           2024-01-25   581  
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   582  		hscif1: serial@e6550000 {
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   583  			compatible = "renesas,hscif-r8a779h0",
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   584  				     "renesas,rcar-gen4-hscif", "renesas,hscif";
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   585  			reg = <0 0xe6550000 0 0x60>;
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   586  			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   587  			clocks = <&cpg CPG_MOD 515>,
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   588  				 <&cpg CPG_CORE R8A779H0_CLK_SASYNCPERD1>,
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   589  				 <&scif_clk>;
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   590  			clock-names = "fck", "brg_int", "scif_clk";
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   591  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   592  			resets = <&cpg 515>;
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   593  			dmas = <&dmac1 0x33>, <&dmac1 0x32>,
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   594  			       <&dmac2 0x33>, <&dmac2 0x32>;
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   595  			dma-names = "tx", "rx", "tx", "rx";
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   596  			status = "disabled";
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   597  		};
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   598  
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   599  		hscif2: serial@e6560000 {
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   600  			compatible = "renesas,hscif-r8a779h0",
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   601  				     "renesas,rcar-gen4-hscif", "renesas,hscif";
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   602  			reg = <0 0xe6560000 0 0x60>;
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   603  			interrupts = <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   604  			clocks = <&cpg CPG_MOD 516>,
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   605  				 <&cpg CPG_CORE R8A779H0_CLK_SASYNCPERD1>,
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   606  				 <&scif_clk2>;
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   607  			clock-names = "fck", "brg_int", "scif_clk";
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   608  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   609  			resets = <&cpg 516>;
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   610  			dmas = <&dmac1 0x35>, <&dmac1 0x34>,
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   611  			       <&dmac2 0x35>, <&dmac2 0x34>;
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   612  			dma-names = "tx", "rx", "tx", "rx";
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   613  			status = "disabled";
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   614  		};
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   615  
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   616  		hscif3: serial@e66a0000 {
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   617  			compatible = "renesas,hscif-r8a779h0",
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   618  				     "renesas,rcar-gen4-hscif", "renesas,hscif";
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   619  			reg = <0 0xe66a0000 0 0x60>;
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   620  			interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   621  			clocks = <&cpg CPG_MOD 517>,
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   622  				 <&cpg CPG_CORE R8A779H0_CLK_SASYNCPERD1>,
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   623  				 <&scif_clk>;
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   624  			clock-names = "fck", "brg_int", "scif_clk";
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   625  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   626  			resets = <&cpg 517>;
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   627  			dmas = <&dmac1 0x37>, <&dmac1 0x36>,
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   628  			       <&dmac2 0x37>, <&dmac2 0x36>;
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   629  			dma-names = "tx", "rx", "tx", "rx";
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   630  			status = "disabled";
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   631  		};
3cdce0b531fbf6 Geert Uytterhoeven 2024-03-12   632  
243066ecc0f114 Thanh Quan         2024-02-11   633  		avb0: ethernet@e6800000 {
243066ecc0f114 Thanh Quan         2024-02-11   634  			compatible = "renesas,etheravb-r8a779h0",
243066ecc0f114 Thanh Quan         2024-02-11   635  				     "renesas,etheravb-rcar-gen4";
243066ecc0f114 Thanh Quan         2024-02-11   636  			reg = <0 0xe6800000 0 0x1000>;
243066ecc0f114 Thanh Quan         2024-02-11   637  			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   638  				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   639  				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   640  				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   641  				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   642  				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   643  				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   644  				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   645  				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   646  				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   647  				     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   648  				     <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   649  				     <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   650  				     <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   651  				     <GIC_SPI 349 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   652  				     <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   653  				     <GIC_SPI 351 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   654  				     <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   655  				     <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   656  				     <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   657  				     <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   658  				     <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   659  				     <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   660  				     <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   661  				     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
243066ecc0f114 Thanh Quan         2024-02-11   662  			interrupt-names = "ch0", "ch1", "ch2", "ch3",
243066ecc0f114 Thanh Quan         2024-02-11   663  					  "ch4", "ch5", "ch6", "ch7",
243066ecc0f114 Thanh Quan         2024-02-11   664  					  "ch8", "ch9", "ch10", "ch11",
243066ecc0f114 Thanh Quan         2024-02-11   665  					  "ch12", "ch13", "ch14", "ch15",
243066ecc0f114 Thanh Quan         2024-02-11   666  					  "ch16", "ch17", "ch18", "ch19",
243066ecc0f114 Thanh Quan         2024-02-11   667  					  "ch20", "ch21", "ch22", "ch23",
243066ecc0f114 Thanh Quan         2024-02-11   668  					  "ch24";
243066ecc0f114 Thanh Quan         2024-02-11   669  			clocks = <&cpg CPG_MOD 211>;
243066ecc0f114 Thanh Quan         2024-02-11   670  			clock-names = "fck";
243066ecc0f114 Thanh Quan         2024-02-11   671  			power-domains = <&sysc R8A779H0_PD_C4>;
243066ecc0f114 Thanh Quan         2024-02-11   672  			resets = <&cpg 211>;
243066ecc0f114 Thanh Quan         2024-02-11   673  			phy-mode = "rgmii";
243066ecc0f114 Thanh Quan         2024-02-11   674  			rx-internal-delay-ps = <0>;
243066ecc0f114 Thanh Quan         2024-02-11   675  			tx-internal-delay-ps = <0>;
f026b6426603d2 Geert Uytterhoeven 2024-04-19   676  			iommus = <&ipmmu_hc 0>;
243066ecc0f114 Thanh Quan         2024-02-11   677  			#address-cells = <1>;
243066ecc0f114 Thanh Quan         2024-02-11   678  			#size-cells = <0>;
243066ecc0f114 Thanh Quan         2024-02-11   679  			status = "disabled";
243066ecc0f114 Thanh Quan         2024-02-11   680  		};
243066ecc0f114 Thanh Quan         2024-02-11   681  
243066ecc0f114 Thanh Quan         2024-02-11   682  		avb1: ethernet@e6810000 {
243066ecc0f114 Thanh Quan         2024-02-11   683  			compatible = "renesas,etheravb-r8a779h0",
243066ecc0f114 Thanh Quan         2024-02-11   684  				     "renesas,etheravb-rcar-gen4";
243066ecc0f114 Thanh Quan         2024-02-11   685  			reg = <0 0xe6810000 0 0x1000>;
243066ecc0f114 Thanh Quan         2024-02-11   686  			interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   687  				     <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   688  				     <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   689  				     <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   690  				     <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   691  				     <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   692  				     <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   693  				     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   694  				     <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   695  				     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   696  				     <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   697  				     <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   698  				     <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   699  				     <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   700  				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   701  				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   702  				     <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   703  				     <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   704  				     <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   705  				     <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   706  				     <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   707  				     <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   708  				     <GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   709  				     <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   710  				     <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>;
243066ecc0f114 Thanh Quan         2024-02-11   711  			interrupt-names = "ch0", "ch1", "ch2", "ch3",
243066ecc0f114 Thanh Quan         2024-02-11   712  					  "ch4", "ch5", "ch6", "ch7",
243066ecc0f114 Thanh Quan         2024-02-11   713  					  "ch8", "ch9", "ch10", "ch11",
243066ecc0f114 Thanh Quan         2024-02-11   714  					  "ch12", "ch13", "ch14", "ch15",
243066ecc0f114 Thanh Quan         2024-02-11   715  					  "ch16", "ch17", "ch18", "ch19",
243066ecc0f114 Thanh Quan         2024-02-11   716  					  "ch20", "ch21", "ch22", "ch23",
243066ecc0f114 Thanh Quan         2024-02-11   717  					  "ch24";
243066ecc0f114 Thanh Quan         2024-02-11   718  			clocks = <&cpg CPG_MOD 212>;
243066ecc0f114 Thanh Quan         2024-02-11   719  			clock-names = "fck";
243066ecc0f114 Thanh Quan         2024-02-11   720  			power-domains = <&sysc R8A779H0_PD_C4>;
243066ecc0f114 Thanh Quan         2024-02-11   721  			resets = <&cpg 212>;
243066ecc0f114 Thanh Quan         2024-02-11   722  			phy-mode = "rgmii";
243066ecc0f114 Thanh Quan         2024-02-11   723  			rx-internal-delay-ps = <0>;
243066ecc0f114 Thanh Quan         2024-02-11   724  			tx-internal-delay-ps = <0>;
243066ecc0f114 Thanh Quan         2024-02-11   725  			#address-cells = <1>;
243066ecc0f114 Thanh Quan         2024-02-11   726  			#size-cells = <0>;
243066ecc0f114 Thanh Quan         2024-02-11   727  			status = "disabled";
243066ecc0f114 Thanh Quan         2024-02-11   728  		};
243066ecc0f114 Thanh Quan         2024-02-11   729  
243066ecc0f114 Thanh Quan         2024-02-11   730  		avb2: ethernet@e6820000 {
243066ecc0f114 Thanh Quan         2024-02-11   731  			compatible = "renesas,etheravb-r8a779h0",
243066ecc0f114 Thanh Quan         2024-02-11   732  				     "renesas,etheravb-rcar-gen4";
243066ecc0f114 Thanh Quan         2024-02-11   733  			reg = <0 0xe6820000 0 0x1000>;
243066ecc0f114 Thanh Quan         2024-02-11   734  			interrupts = <GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   735  				     <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   736  				     <GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   737  				     <GIC_SPI 388 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   738  				     <GIC_SPI 389 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   739  				     <GIC_SPI 390 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   740  				     <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   741  				     <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   742  				     <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   743  				     <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   744  				     <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   745  				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   746  				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   747  				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   748  				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   749  				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   750  				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   751  				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   752  				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   753  				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   754  				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   755  				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   756  				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   757  				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
243066ecc0f114 Thanh Quan         2024-02-11   758  				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>;
243066ecc0f114 Thanh Quan         2024-02-11   759  			interrupt-names = "ch0", "ch1", "ch2", "ch3",
243066ecc0f114 Thanh Quan         2024-02-11   760  					  "ch4", "ch5", "ch6", "ch7",
243066ecc0f114 Thanh Quan         2024-02-11   761  					  "ch8", "ch9", "ch10", "ch11",
243066ecc0f114 Thanh Quan         2024-02-11   762  					  "ch12", "ch13", "ch14", "ch15",
243066ecc0f114 Thanh Quan         2024-02-11   763  					  "ch16", "ch17", "ch18", "ch19",
243066ecc0f114 Thanh Quan         2024-02-11   764  					  "ch20", "ch21", "ch22", "ch23",
243066ecc0f114 Thanh Quan         2024-02-11   765  					  "ch24";
243066ecc0f114 Thanh Quan         2024-02-11   766  			clocks = <&cpg CPG_MOD 213>;
243066ecc0f114 Thanh Quan         2024-02-11   767  			clock-names = "fck";
243066ecc0f114 Thanh Quan         2024-02-11   768  			power-domains = <&sysc R8A779H0_PD_C4>;
243066ecc0f114 Thanh Quan         2024-02-11   769  			resets = <&cpg 213>;
243066ecc0f114 Thanh Quan         2024-02-11   770  			phy-mode = "rgmii";
243066ecc0f114 Thanh Quan         2024-02-11   771  			rx-internal-delay-ps = <0>;
243066ecc0f114 Thanh Quan         2024-02-11   772  			tx-internal-delay-ps = <0>;
243066ecc0f114 Thanh Quan         2024-02-11   773  			#address-cells = <1>;
243066ecc0f114 Thanh Quan         2024-02-11   774  			#size-cells = <0>;
243066ecc0f114 Thanh Quan         2024-02-11   775  			status = "disabled";
243066ecc0f114 Thanh Quan         2024-02-11   776  		};
243066ecc0f114 Thanh Quan         2024-02-11   777  
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   778  		scif0: serial@e6e60000 {
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   779  			compatible = "renesas,scif-r8a779h0",
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   780  				     "renesas,rcar-gen4-scif", "renesas,scif";
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   781  			reg = <0 0xe6e60000 0 64>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   782  			interrupts = <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   783  			clocks = <&cpg CPG_MOD 702>,
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   784  				 <&cpg CPG_CORE R8A779H0_CLK_SASYNCPERD1>,
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   785  				 <&scif_clk>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   786  			clock-names = "fck", "brg_int", "scif_clk";
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   787  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   788  			resets = <&cpg 702>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   789  			dmas = <&dmac1 0x51>, <&dmac1 0x50>,
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   790  			       <&dmac2 0x51>, <&dmac2 0x50>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   791  			dma-names = "tx", "rx", "tx", "rx";
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   792  			status = "disabled";
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   793  		};
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   794  
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   795  		scif1: serial@e6e68000 {
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   796  			compatible = "renesas,scif-r8a779h0",
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   797  				     "renesas,rcar-gen4-scif", "renesas,scif";
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   798  			reg = <0 0xe6e68000 0 64>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   799  			interrupts = <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   800  			clocks = <&cpg CPG_MOD 703>,
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   801  				 <&cpg CPG_CORE R8A779H0_CLK_SASYNCPERD1>,
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   802  				 <&scif_clk>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   803  			clock-names = "fck", "brg_int", "scif_clk";
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   804  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   805  			resets = <&cpg 703>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   806  			dmas = <&dmac1 0x53>, <&dmac1 0x52>,
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   807  			       <&dmac2 0x53>, <&dmac2 0x52>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   808  			dma-names = "tx", "rx", "tx", "rx";
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   809  			status = "disabled";
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   810  		};
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   811  
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   812  		scif3: serial@e6c50000 {
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   813  			compatible = "renesas,scif-r8a779h0",
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   814  				     "renesas,rcar-gen4-scif", "renesas,scif";
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   815  			reg = <0 0xe6c50000 0 64>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   816  			interrupts = <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   817  			clocks = <&cpg CPG_MOD 704>,
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   818  				 <&cpg CPG_CORE R8A779H0_CLK_SASYNCPERD1>,
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   819  				 <&scif_clk>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   820  			clock-names = "fck", "brg_int", "scif_clk";
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   821  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   822  			resets = <&cpg 704>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   823  			dmas = <&dmac1 0x57>, <&dmac1 0x56>,
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   824  			       <&dmac2 0x57>, <&dmac2 0x56>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   825  			dma-names = "tx", "rx", "tx", "rx";
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   826  			status = "disabled";
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   827  		};
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   828  
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   829  		scif4: serial@e6c40000 {
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   830  			compatible = "renesas,scif-r8a779h0",
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   831  				     "renesas,rcar-gen4-scif", "renesas,scif";
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   832  			reg = <0 0xe6c40000 0 64>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   833  			interrupts = <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   834  			clocks = <&cpg CPG_MOD 705>,
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   835  				 <&cpg CPG_CORE R8A779H0_CLK_SASYNCPERD1>,
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   836  				 <&scif_clk2>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   837  			clock-names = "fck", "brg_int", "scif_clk";
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   838  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   839  			resets = <&cpg 705>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   840  			dmas = <&dmac1 0x59>, <&dmac1 0x58>,
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   841  			       <&dmac2 0x59>, <&dmac2 0x58>;
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   842  			dma-names = "tx", "rx", "tx", "rx";
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   843  			status = "disabled";
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   844  		};
0833ec2fc4b1f0 Geert Uytterhoeven 2024-03-12   845  
a6e140f174366e Thanh Quan         2024-04-16   846  		msiof0: spi@e6e90000 {
a6e140f174366e Thanh Quan         2024-04-16   847  			compatible = "renesas,msiof-r8a779h0",
a6e140f174366e Thanh Quan         2024-04-16   848  				     "renesas,rcar-gen4-msiof";
a6e140f174366e Thanh Quan         2024-04-16   849  			reg = <0 0xe6e90000 0 0x0064>;
a6e140f174366e Thanh Quan         2024-04-16   850  			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
a6e140f174366e Thanh Quan         2024-04-16   851  			clocks = <&cpg CPG_MOD 618>;
a6e140f174366e Thanh Quan         2024-04-16   852  			dmas = <&dmac1 0x41>, <&dmac1 0x40>,
a6e140f174366e Thanh Quan         2024-04-16   853  			       <&dmac2 0x41>, <&dmac2 0x40>;
a6e140f174366e Thanh Quan         2024-04-16   854  			dma-names = "tx", "rx", "tx", "rx";
a6e140f174366e Thanh Quan         2024-04-16   855  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
a6e140f174366e Thanh Quan         2024-04-16   856  			resets = <&cpg 618>;
a6e140f174366e Thanh Quan         2024-04-16   857  			#address-cells = <1>;
a6e140f174366e Thanh Quan         2024-04-16   858  			#size-cells = <0>;
a6e140f174366e Thanh Quan         2024-04-16   859  			status = "disabled";
a6e140f174366e Thanh Quan         2024-04-16   860  		};
a6e140f174366e Thanh Quan         2024-04-16   861  
a6e140f174366e Thanh Quan         2024-04-16   862  		msiof1: spi@e6ea0000 {
a6e140f174366e Thanh Quan         2024-04-16   863  			compatible = "renesas,msiof-r8a779h0",
a6e140f174366e Thanh Quan         2024-04-16   864  				     "renesas,rcar-gen4-msiof";
a6e140f174366e Thanh Quan         2024-04-16   865  			reg = <0 0xe6ea0000 0 0x0064>;
a6e140f174366e Thanh Quan         2024-04-16   866  			interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
a6e140f174366e Thanh Quan         2024-04-16   867  			clocks = <&cpg CPG_MOD 619>;
a6e140f174366e Thanh Quan         2024-04-16   868  			dmas = <&dmac1 0x43>, <&dmac1 0x42>,
a6e140f174366e Thanh Quan         2024-04-16   869  			       <&dmac2 0x43>, <&dmac2 0x42>;
a6e140f174366e Thanh Quan         2024-04-16   870  			dma-names = "tx", "rx", "tx", "rx";
a6e140f174366e Thanh Quan         2024-04-16   871  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
a6e140f174366e Thanh Quan         2024-04-16   872  			resets = <&cpg 619>;
a6e140f174366e Thanh Quan         2024-04-16   873  			#address-cells = <1>;
a6e140f174366e Thanh Quan         2024-04-16   874  			#size-cells = <0>;
a6e140f174366e Thanh Quan         2024-04-16   875  			status = "disabled";
a6e140f174366e Thanh Quan         2024-04-16   876  		};
a6e140f174366e Thanh Quan         2024-04-16   877  
a6e140f174366e Thanh Quan         2024-04-16   878  		msiof2: spi@e6c00000 {
a6e140f174366e Thanh Quan         2024-04-16   879  			compatible = "renesas,msiof-r8a779h0",
a6e140f174366e Thanh Quan         2024-04-16   880  				     "renesas,rcar-gen4-msiof";
a6e140f174366e Thanh Quan         2024-04-16   881  			reg = <0 0xe6c00000 0 0x0064>;
a6e140f174366e Thanh Quan         2024-04-16   882  			interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
a6e140f174366e Thanh Quan         2024-04-16   883  			clocks = <&cpg CPG_MOD 620>;
a6e140f174366e Thanh Quan         2024-04-16   884  			dmas = <&dmac1 0x45>, <&dmac1 0x44>,
a6e140f174366e Thanh Quan         2024-04-16   885  			       <&dmac2 0x45>, <&dmac2 0x44>;
a6e140f174366e Thanh Quan         2024-04-16   886  			dma-names = "tx", "rx", "tx", "rx";
a6e140f174366e Thanh Quan         2024-04-16   887  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
a6e140f174366e Thanh Quan         2024-04-16   888  			resets = <&cpg 620>;
a6e140f174366e Thanh Quan         2024-04-16   889  			#address-cells = <1>;
a6e140f174366e Thanh Quan         2024-04-16   890  			#size-cells = <0>;
a6e140f174366e Thanh Quan         2024-04-16   891  			status = "disabled";
a6e140f174366e Thanh Quan         2024-04-16   892  		};
a6e140f174366e Thanh Quan         2024-04-16   893  
a6e140f174366e Thanh Quan         2024-04-16   894  		msiof3: spi@e6c10000 {
a6e140f174366e Thanh Quan         2024-04-16   895  			compatible = "renesas,msiof-r8a779h0",
a6e140f174366e Thanh Quan         2024-04-16   896  				     "renesas,rcar-gen4-msiof";
a6e140f174366e Thanh Quan         2024-04-16   897  			reg = <0 0xe6c10000 0 0x0064>;
a6e140f174366e Thanh Quan         2024-04-16   898  			interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
a6e140f174366e Thanh Quan         2024-04-16   899  			clocks = <&cpg CPG_MOD 621>;
a6e140f174366e Thanh Quan         2024-04-16   900  			dmas = <&dmac1 0x47>, <&dmac1 0x46>,
a6e140f174366e Thanh Quan         2024-04-16   901  			       <&dmac2 0x47>, <&dmac2 0x46>;
a6e140f174366e Thanh Quan         2024-04-16   902  			dma-names = "tx", "rx", "tx", "rx";
a6e140f174366e Thanh Quan         2024-04-16   903  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
a6e140f174366e Thanh Quan         2024-04-16   904  			resets = <&cpg 621>;
a6e140f174366e Thanh Quan         2024-04-16   905  			#address-cells = <1>;
a6e140f174366e Thanh Quan         2024-04-16   906  			#size-cells = <0>;
a6e140f174366e Thanh Quan         2024-04-16   907  			status = "disabled";
a6e140f174366e Thanh Quan         2024-04-16   908  		};
a6e140f174366e Thanh Quan         2024-04-16   909  
a6e140f174366e Thanh Quan         2024-04-16   910  		msiof4: spi@e6c20000 {
a6e140f174366e Thanh Quan         2024-04-16   911  			compatible = "renesas,msiof-r8a779h0",
a6e140f174366e Thanh Quan         2024-04-16   912  				     "renesas,rcar-gen4-msiof";
a6e140f174366e Thanh Quan         2024-04-16   913  			reg = <0 0xe6c20000 0 0x0064>;
a6e140f174366e Thanh Quan         2024-04-16   914  			interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
a6e140f174366e Thanh Quan         2024-04-16   915  			clocks = <&cpg CPG_MOD 622>;
a6e140f174366e Thanh Quan         2024-04-16   916  			dmas = <&dmac1 0x49>, <&dmac1 0x48>,
a6e140f174366e Thanh Quan         2024-04-16   917  			       <&dmac2 0x49>, <&dmac2 0x48>;
a6e140f174366e Thanh Quan         2024-04-16   918  			dma-names = "tx", "rx", "tx", "rx";
a6e140f174366e Thanh Quan         2024-04-16   919  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
a6e140f174366e Thanh Quan         2024-04-16   920  			resets = <&cpg 622>;
a6e140f174366e Thanh Quan         2024-04-16   921  			#address-cells = <1>;
a6e140f174366e Thanh Quan         2024-04-16   922  			#size-cells = <0>;
a6e140f174366e Thanh Quan         2024-04-16   923  			status = "disabled";
a6e140f174366e Thanh Quan         2024-04-16   924  		};
a6e140f174366e Thanh Quan         2024-04-16   925  
a6e140f174366e Thanh Quan         2024-04-16   926  		msiof5: spi@e6c28000 {
a6e140f174366e Thanh Quan         2024-04-16   927  			compatible = "renesas,msiof-r8a779h0",
a6e140f174366e Thanh Quan         2024-04-16   928  				     "renesas,rcar-gen4-msiof";
a6e140f174366e Thanh Quan         2024-04-16   929  			reg = <0 0xe6c28000 0 0x0064>;
a6e140f174366e Thanh Quan         2024-04-16   930  			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>;
a6e140f174366e Thanh Quan         2024-04-16   931  			clocks = <&cpg CPG_MOD 623>;
a6e140f174366e Thanh Quan         2024-04-16   932  			dmas = <&dmac1 0x4b>, <&dmac1 0x4a>,
a6e140f174366e Thanh Quan         2024-04-16   933  			       <&dmac2 0x4b>, <&dmac2 0x4a>;
a6e140f174366e Thanh Quan         2024-04-16   934  			dma-names = "tx", "rx", "tx", "rx";
a6e140f174366e Thanh Quan         2024-04-16   935  			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
a6e140f174366e Thanh Quan         2024-04-16   936  			resets = <&cpg 623>;
a6e140f174366e Thanh Quan         2024-04-16   937  			#address-cells = <1>;
a6e140f174366e Thanh Quan         2024-04-16   938  			#size-cells = <0>;
a6e140f174366e Thanh Quan         2024-04-16   939  			status = "disabled";
a6e140f174366e Thanh Quan         2024-04-16   940  		};
a6e140f174366e Thanh Quan         2024-04-16   941  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   942  		vin00: video@e6ef0000 {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   943  			compatible = "renesas,vin-r8a779h0";
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   944  			reg = <0 0xe6ef0000 0 0x1000>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   945  			interrupts = <GIC_SPI 529 IRQ_TYPE_LEVEL_HIGH>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   946  			clocks = <&cpg CPG_MOD 730>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   947  			power-domains = <&sysc R8A779H0_PD_C4>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   948  			resets = <&cpg 730>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   949  			renesas,id = <0>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   950  			status = "disabled";
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   951  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   952  			ports {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   953  				#address-cells = <1>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   954  				#size-cells = <0>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   955  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  @956  				port@2 {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   957  					#address-cells = <1>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   958  					#size-cells = <0>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   959  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   960  					reg = <2>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   961  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   962  					vin00isp0: endpoint@0 {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   963  						reg = <0>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   964  						remote-endpoint = <&isp0vin00>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   965  					};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   966  				};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   967  			};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   968  		};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   969  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   970  		vin01: video@e6ef1000 {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   971  			compatible = "renesas,vin-r8a779h0";
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   972  			reg = <0 0xe6ef1000 0 0x1000>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   973  			interrupts = <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   974  			clocks = <&cpg CPG_MOD 731>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   975  			power-domains = <&sysc R8A779H0_PD_C4>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   976  			resets = <&cpg 731>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   977  			renesas,id = <1>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   978  			status = "disabled";
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   979  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   980  			ports {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   981  				#address-cells = <1>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   982  				#size-cells = <0>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   983  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  @984  				port@2 {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   985  					#address-cells = <1>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   986  					#size-cells = <0>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   987  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   988  					reg = <2>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   989  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   990  					vin01isp0: endpoint@0 {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   991  						reg = <0>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   992  						remote-endpoint = <&isp0vin01>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   993  					};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   994  				};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   995  			};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   996  		};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   997  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   998  		vin02: video@e6ef2000 {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27   999  			compatible = "renesas,vin-r8a779h0";
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1000  			reg = <0 0xe6ef2000 0 0x1000>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1001  			interrupts = <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1002  			clocks = <&cpg CPG_MOD 800>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1003  			power-domains = <&sysc R8A779H0_PD_C4>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1004  			resets = <&cpg 800>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1005  			renesas,id = <2>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1006  			status = "disabled";
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1007  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1008  			ports {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1009  				#address-cells = <1>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1010  				#size-cells = <0>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1011  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27 @1012  				port@2 {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1013  					#address-cells = <1>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1014  					#size-cells = <0>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1015  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1016  					reg = <2>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1017  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1018  					vin02isp0: endpoint@0 {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1019  						reg = <0>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1020  						remote-endpoint = <&isp0vin02>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1021  					};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1022  				};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1023  			};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1024  		};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1025  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1026  		vin03: video@e6ef3000 {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1027  			compatible = "renesas,vin-r8a779h0";
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1028  			reg = <0 0xe6ef3000 0 0x1000>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1029  			interrupts = <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1030  			clocks = <&cpg CPG_MOD 801>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1031  			power-domains = <&sysc R8A779H0_PD_C4>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1032  			resets = <&cpg 801>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1033  			renesas,id = <3>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1034  			status = "disabled";
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1035  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1036  			ports {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1037  				#address-cells = <1>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1038  				#size-cells = <0>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1039  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27 @1040  				port@2 {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1041  					#address-cells = <1>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1042  					#size-cells = <0>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1043  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1044  					reg = <2>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1045  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1046  					vin03isp0: endpoint@0 {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1047  						reg = <0>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1048  						remote-endpoint = <&isp0vin03>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1049  					};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1050  				};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1051  			};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1052  		};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1053  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1054  		vin04: video@e6ef4000 {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1055  			compatible = "renesas,vin-r8a779h0";
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1056  			reg = <0 0xe6ef4000 0 0x1000>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1057  			interrupts = <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1058  			clocks = <&cpg CPG_MOD 802>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1059  			power-domains = <&sysc R8A779H0_PD_C4>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1060  			resets = <&cpg 802>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1061  			renesas,id = <4>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1062  			status = "disabled";
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1063  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1064  			ports {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1065  				#address-cells = <1>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1066  				#size-cells = <0>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1067  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27 @1068  				port@2 {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1069  					#address-cells = <1>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1070  					#size-cells = <0>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1071  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1072  					reg = <2>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1073  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1074  					vin04isp0: endpoint@0 {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1075  						reg = <0>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1076  						remote-endpoint = <&isp0vin04>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1077  					};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1078  				};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1079  			};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1080  		};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1081  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1082  		vin05: video@e6ef5000 {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1083  			compatible = "renesas,vin-r8a779h0";
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1084  			reg = <0 0xe6ef5000 0 0x1000>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1085  			interrupts = <GIC_SPI 534 IRQ_TYPE_LEVEL_HIGH>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1086  			clocks = <&cpg CPG_MOD 803>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1087  			power-domains = <&sysc R8A779H0_PD_C4>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1088  			resets = <&cpg 803>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1089  			renesas,id = <5>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1090  			status = "disabled";
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1091  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1092  			ports {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1093  				#address-cells = <1>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1094  				#size-cells = <0>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1095  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27 @1096  				port@2 {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1097  					#address-cells = <1>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1098  					#size-cells = <0>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1099  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1100  					reg = <2>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1101  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1102  					vin05isp0: endpoint@0 {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1103  						reg = <0>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1104  						remote-endpoint = <&isp0vin05>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1105  					};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1106  				};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1107  			};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1108  		};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1109  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1110  		vin06: video@e6ef6000 {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1111  			compatible = "renesas,vin-r8a779h0";
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1112  			reg = <0 0xe6ef6000 0 0x1000>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1113  			interrupts = <GIC_SPI 535 IRQ_TYPE_LEVEL_HIGH>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1114  			clocks = <&cpg CPG_MOD 804>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1115  			power-domains = <&sysc R8A779H0_PD_C4>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1116  			resets = <&cpg 804>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1117  			renesas,id = <6>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1118  			status = "disabled";
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1119  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1120  			ports {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1121  				#address-cells = <1>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1122  				#size-cells = <0>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1123  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27 @1124  				port@2 {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1125  					#address-cells = <1>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1126  					#size-cells = <0>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1127  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1128  					reg = <2>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1129  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1130  					vin06isp0: endpoint@0 {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1131  						reg = <0>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1132  						remote-endpoint = <&isp0vin06>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1133  					};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1134  				};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1135  			};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1136  		};
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1137  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1138  		vin07: video@e6ef7000 {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1139  			compatible = "renesas,vin-r8a779h0";
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1140  			reg = <0 0xe6ef7000 0 0x1000>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1141  			interrupts = <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1142  			clocks = <&cpg CPG_MOD 805>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1143  			power-domains = <&sysc R8A779H0_PD_C4>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1144  			resets = <&cpg 805>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1145  			renesas,id = <7>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1146  			status = "disabled";
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1147  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1148  			ports {
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1149  				#address-cells = <1>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1150  				#size-cells = <0>;
2bb78d9fb7c997 Niklas Söderlund   2024-05-27  1151  
2bb78d9fb7c997 Niklas Söderlund   2024-05-27 @1152  				port@2 {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



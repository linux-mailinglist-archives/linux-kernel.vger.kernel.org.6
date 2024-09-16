Return-Path: <linux-kernel+bounces-330325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C405C979C90
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28D59B22A92
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3F24E1CA;
	Mon, 16 Sep 2024 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RNhlOJYS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F28213B5B3
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726474335; cv=fail; b=jX+rtXBcoGGENNFT0/Gk+zuxg0LmD9jTtt5HK53xgwzq2Qmma16kxzNvLNjAqI9L2QwOh0SNdLCO+ztFwc5sopEi+qns7xhPOGNkrBC9CIwsli+sEr8ZAtsCPstv1Cd2XKo0yNguTfmDPP9JsJXkNXERYH08GOJfxo2PqzzcRv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726474335; c=relaxed/simple;
	bh=oFzt7lN/3Ir6QuV2O3bsL4ZQzVCKfXprLnrNCnsi3+o=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ieCrEwWVv/LFx7Z9NhR4CHk+7vXGO6rNv3KGLOXk1sQrCHV7EGabBCTLcdS1htHnje8NvlYfgAVLJnpGEFvj7+4RyoGGCGQLSZcce//5Wvwd7qrPaybQpNm2E41KpqI/Wzd4yCjOY8h09SH1PmQLtNKuLVuqAl/sqyzepe/ENoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RNhlOJYS; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726474333; x=1758010333;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=oFzt7lN/3Ir6QuV2O3bsL4ZQzVCKfXprLnrNCnsi3+o=;
  b=RNhlOJYSoZHU2yYfuf45gPtfN1WIgzH7s/dxLPweZNgfaJj/0NWxQO/T
   lgzanXli0YtJrvuODyC4u9dXUtYL3lQUWrdW72n+ZkvtF3Gw1gpupB2XN
   WU3cS39nt78n9hGmNv81lj1ybA3krWlCAABMkUkNzLsQFeruYjgb/o4mw
   OSBzgT2f70mq0WFD2pZu9qWu67nI/lz36UpH575SPXzvKy4rOH/z4jXi8
   YVhiSI11szjZHeh0/vKS9649H88bCSklU8lKzv2qkbPBjnA5HTZkG7yHu
   BCRNPp+tueNFhRtjEWWKKaopV6ujg1Wq++uzjGXqMzv2V//c/LEN25s8W
   Q==;
X-CSE-ConnectionGUID: qch/L/HoTjGI0VOMR6Ee0g==
X-CSE-MsgGUID: +94rxVHRQ8ixbDMT4l6P/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="29079785"
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="29079785"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 01:12:12 -0700
X-CSE-ConnectionGUID: WVwXGiHrRRisdpys46hzMA==
X-CSE-MsgGUID: hgwzPTR0Tri3iV2JqvIQ9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="99482599"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Sep 2024 01:12:13 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 01:12:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Sep 2024 01:12:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 01:12:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7MNkKuL26NjS3GaEYXH9n6tbbLuGHDJsuZHyT3RvqDpZDmIa2gP1rhAFXF5fdjBuAdydF/7/+BSf1RSznPMLCh9VFiGwR8gqmfeqI4g9eQYK62qr+cWBx44OJhnY28RGCFvsCG0Rpc6He7gJv+DM6vhxQv7WS68IYCryeVdgSe1mMgdmZkmehi4jEIHL8mEaPZWbS1Z0nFUmd41GTDSVZhbGjQJqnpO0p45B2IlEK5qs31Azur2uovwUer8x4bv3u6WNqyb1TtK3atrOdkzx5zoqCm7cIWSiBEuuVQCueIWo5OoF13eFvdGT6mEVmBv9cibY83gL8HGJbmpo2QdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+GKzFuNvqU0leZVlI2MgQJSJHly/7569mn/8AJCVq4=;
 b=wzYnoYSWo8vX6QDf0o+5z3m9zHMkv3Swm9hGFbLh9b6Z2epRv04Tmn8BK+v12yn+iKRP5RBU8ls3W5G/6NK0++GDta7de/hw9NOqIuU9DNDsDuoSduH3TjVmYD6eHrPN6/rziFBzMrEF60rb+r3Sg4qsyCFOJVUzmuzPhOiDVj5AJS4WvMShVNzsPSJg97YUyp56xxspkaciSR/u8MB55fwCSRTCxX65tWMur0OcVNERtlV8F+nlSzh8uKyv/htzZw7KTrR9odnvpdDVhl0k8ykaw/M8c+/aor1WGCuSrJxIb2IWslMCcf8ZQrnGiY9/nAg/suPOlKZhZStvx3J/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB5783.namprd11.prod.outlook.com (2603:10b6:510:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 08:12:03 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 08:12:03 +0000
Date: Mon, 16 Sep 2024 16:11:48 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Mark Brown <broonie@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Bert Karwatzki <spasswolf@web.de>, Jeff Xu
	<jeffxu@chromium.org>, Jiri Olsa <olsajiri@gmail.com>, Kees Cook
	<kees@kernel.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox
	<willy@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, Paul Moore
	<paul@paul-moore.com>, Sidhartha Kumar <sidhartha.kumar@oracle.com>, "Suren
 Baghdasaryan" <surenb@google.com>, <linux-kernel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [mm]  cc8cb3697a:  stress-ng.pkey.ops_per_sec
 4.4% improvement
Message-ID: <202409161559.af0a1b99-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f7680a4-37c8-4d2c-5c1e-08dcd6273efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?oRP18e8WMT2DzwFS0TGHeOugr9/z3Vg0XE4XAVCTSkKqC8feYSzxiC/Crs?=
 =?iso-8859-1?Q?tV1VBPu2rzGFitvdWWLMXoxaDggyWuoPbQj3xve0tTgEY0mCEZJe48kfs/?=
 =?iso-8859-1?Q?Gz/sYdH5oMfptqq3LfdzvTH8foFFXyFCmC3fRVrrz9fQ9m/Hk52wAKJztq?=
 =?iso-8859-1?Q?4a6fXxvBV9rvpjWjYKyvmjyP55A+NrZ1FfE2jg/pUJZ/V/Y4Tx8EgdXMCQ?=
 =?iso-8859-1?Q?2Nuiy1s7eTd+Jg/Kyo45is4Jqn1I/bJJMnuXm1/fOSGGS4xhOKa673eQNi?=
 =?iso-8859-1?Q?tlofUhuMfM+4eFqB8tMcFytwR8i3XIHpizC25Xobjuf4Gr1RGjFmEwC/xX?=
 =?iso-8859-1?Q?rxGIcerXt6PKRx37OShi3kHEOJGEmUAFqHU31WHye595xFKkU03BrQffE+?=
 =?iso-8859-1?Q?YH5UmdGRnD3OKuztpYZat/KDHtg6tCmoxUopEmt9kgMly/8ZjRj1JwNWkD?=
 =?iso-8859-1?Q?McO+UYNO/BV1jcvrWVTwyLqmqAUv2XlKfWThoB5nY7+46nLC7DF1Fryjy1?=
 =?iso-8859-1?Q?uouI8xlBFgJu9zZsUOrrb4rp63DK0TvsC8zpfhRPNa9o7+sieOPomt3ycn?=
 =?iso-8859-1?Q?5fzbxrnR1wi+0vwFHY/3IbDnQGfhxZsBOgEtvmNVYtaV47uRZTz7x6+nDG?=
 =?iso-8859-1?Q?2Fj732jW1vOcwFgvTW4J7K/+dbuC1jv8oyA12Y0IZSBRPZRmXVeoaJAWef?=
 =?iso-8859-1?Q?k63GSxmrC0Eq7R07EvwB4zFrMKVl3KxwXMoyOM9G0TFBTIIwvC/9aTYDpb?=
 =?iso-8859-1?Q?kybBN9NU0d5Cqi12lESdaMYu1VlXbB6G7/k6h1bknKlTx8H0/edMOPErPk?=
 =?iso-8859-1?Q?gKs8ivkIcwyJCgKLBksyIieyHLR08hf6jZlCVLPALm7jtTlijof1cZ78Zs?=
 =?iso-8859-1?Q?/E76ekCZy2O1/DfS7PrR/9e09+mvGivAUI4HjA5bPqzC50qcxEmjZDPdEY?=
 =?iso-8859-1?Q?SbN8xuHDEKwQiKbgoHKCE05GOFVlNQsVnQASEj2un6fHhXteo9b1P+JxC6?=
 =?iso-8859-1?Q?g+5gdlyTzWCokVF0QrTXx1JU2GyjNDNycvst4wracigTsQOkjlmfhtD3Dk?=
 =?iso-8859-1?Q?oN1oR7cR2iI8Utxd55SteD0ScUR98JEsw0D3Ve5Ppuk1P3899njOqVzAwn?=
 =?iso-8859-1?Q?NtAXO3hONsVzyVs4M/94Sq6D0Tdy9aRQIXAf83SYv+AEbiif+DAxHRUpuD?=
 =?iso-8859-1?Q?EoIwBrs9jSjeVT65Ha2CsnikGNvCb28AdwbnYs5ZHmT6bfbIxggaNdqJ3I?=
 =?iso-8859-1?Q?x5UVqjgOLahcskZlQcYc03K6XHm+Ks0LHunsuF/NuCs4tyhJfQw9CLSE8Y?=
 =?iso-8859-1?Q?eMGGHGHLpsilrjCtWzKOjbNTILek5+UYehJ4Oc+SqZE6r9pweDiVvGRHA0?=
 =?iso-8859-1?Q?49WmdgG3LFPPgfrQPjB7SxrDcakUfd0zZ0bkk3hqN7vxib/BUY/hY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?7p+wme6sGA6EI0iypeYuiqpeb9L/Oq4t8jaKNgH+B+2qKzPOlfeKZmG0jq?=
 =?iso-8859-1?Q?JQqbL5yD+iORqEdciI39XdKsl3xgZJnB5UdXr1n1lYarbiUmUxs/gCYqAe?=
 =?iso-8859-1?Q?qU3Cr66eK9pNM6jnvQ9XINT2sjdTdZDMQZMqaUtxZX14cK2QvihSEDxepi?=
 =?iso-8859-1?Q?3ZmeckwDizDSxt+3pkLEGFvGFY1NMI0Fdn8XCWgdYVeVFv9mWHaQIkH5vw?=
 =?iso-8859-1?Q?tFKbp9yF1IRiIxygwYXnRlmHJueDS/6Ig4KbLJHj6It4eGN/yA8ctCv8tU?=
 =?iso-8859-1?Q?BMqm6Dv8pMUB0Jd6fxRWQj4R2HNny9eFtPn92rW7/GoMSn8iSLI+PRGXkB?=
 =?iso-8859-1?Q?+L7/e0vU3/FwoUQeBFMCkcJ5bfjrOKBePfjKrBqmil+Z54vnaciKCmZS+7?=
 =?iso-8859-1?Q?XNv5a/tGFPNmp7+lXL6mClCvCnILvlR/PPnpXDYyAhRNX4sWWeHoVB7jTz?=
 =?iso-8859-1?Q?pyx9VhuA//RbSQly27++27q/i7sdUmJjf9Rx+AXkjrFm9XTeoVXtO7kCvq?=
 =?iso-8859-1?Q?kR6th6G9Kp+ohhQkhrMil7hYb5yWUobPD8UWFp1naxKhXaYtzDMhDj1X/R?=
 =?iso-8859-1?Q?hNztNR5DEBRZHd8woiFMhGkaDw94wCwtDvGpGXlUTrf9GTcyGwNtWxU+D5?=
 =?iso-8859-1?Q?l45INSQQRL+uQA/5LbAXD+XKsmi9IBeYmVH3JOJ18nduj5heZMmqKL5c4C?=
 =?iso-8859-1?Q?SD2bnV8Pb92UwlfAnlGOurPRCpPtfctqFgNNFPMuY5NlzJ5l2WziNv+1tc?=
 =?iso-8859-1?Q?zmzScLwkTugaXi/UoWmE3ubN3yK9XjmCv7GibCxDyTZkqUtwSFtr3EOMtw?=
 =?iso-8859-1?Q?7R0NV3bC+xg3YV9tJVJWiIpomRYuDR5/QZ10tknHJlQMn+mwiS5iCpkRyF?=
 =?iso-8859-1?Q?7RtEMjcIRHnOJsNxtfGHmitPkTE7ry451kG/IZSO35y0ZRRuvid02/oL0o?=
 =?iso-8859-1?Q?Giu9Vg5QpwUWEHUvs51HiQFDkQx9POjCjpcHQtXv7dvsBB918DQ8qOjHwZ?=
 =?iso-8859-1?Q?iKKR41FxUp947INyQif5/v0eEmNvOcsDFMwLleImvsZT0k3OjjOn30wjw4?=
 =?iso-8859-1?Q?LCPfnDH5PY0A08XbSHH1WXSc6QKzZZwmqUEgaLa2cD3RVWYCSDlI0CJGRE?=
 =?iso-8859-1?Q?75Zh960oW3G8yIvMg7sUizj46qYjil0dNJnv3Z+T1yZWT36BHLD97xU/DX?=
 =?iso-8859-1?Q?QQbUs5B9BqK6Hr9NjghZHV63VZW9Yi6hbzbo4Ujq2KibZx3f1VRvCfMD47?=
 =?iso-8859-1?Q?Y7SIkYTwg8I6OpqzRVvUAjuJwRUeG5L3G6QzGKqlgy/cvojTW05iqrJ2TS?=
 =?iso-8859-1?Q?pGpGZF1SJpRm/XoA8S8v+RpEkrbJhQ/TWcZdXxoAMqXjHAIrPQE4YVWHWl?=
 =?iso-8859-1?Q?OlrzwPCWEiQEgVIcqCf4ukIzTbtcoikGA9kZpMJLZgOJoC7qA25eohPxC3?=
 =?iso-8859-1?Q?IuwL2CcQER5zbtPalABuOETg44+OrtQFdHgSSeqLQuD+Ss7H8gQ4QnFtA4?=
 =?iso-8859-1?Q?3LwzHtQscsEQ6AA6sp+NkW4RMcCZbjM2oBGxT2Ef4RCZEvxw/VO/Mb8bR8?=
 =?iso-8859-1?Q?oPaw+zLNvVR5bhdBkfgpx83+XvJVf7ixvHL7PZv4T/B+U4+RIHn+/CqTAl?=
 =?iso-8859-1?Q?mO3/5uaAzvMDWVSr8UPDVivhrnziUpKTOaalMCGSroiYvWZ/09aNgoVw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7680a4-37c8-4d2c-5c1e-08dcd6273efd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 08:12:03.0767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D52genBc3FRRVf6Z5Z62tSE5BGfuSOas6W3qCjFpnh28QMxdg/2lsMl5b7Yoo/DjCiaKianksZMJrkFi0+x47Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5783
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 4.4% improvement of stress-ng.pkey.ops_per_sec on:


commit: cc8cb3697a8d8eabe1fb9acb8768b11c1ab607d8 ("mm: refactor vma_merge() into modify-only vma_merge_existing_range()")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: pkey
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240916/202409161559.af0a1b99-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/pkey/stress-ng/60s

commit: 
  65e0aa64df ("mm: introduce commit_merge(), abstracting final commit of merge")
  cc8cb3697a ("mm: refactor vma_merge() into modify-only vma_merge_existing_range()")

65e0aa64df916861 cc8cb3697a8d8eabe1fb9acb876 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    159916 ±  5%     +14.9%     183809 ± 10%  meminfo.DirectMap4k
     15.42 ± 23%     +46.5%      22.58 ± 17%  sched_debug.cpu.nr_uninterruptible.max
 2.158e+08            +4.4%  2.253e+08        stress-ng.pkey.ops
   3596484            +4.4%    3755565        stress-ng.pkey.ops_per_sec
    196.30            +4.9%     205.86        stress-ng.time.user_time
  25782400            +3.4%   26666903        proc-vmstat.numa_hit
  25707363            +3.5%   26600006        proc-vmstat.numa_local
  44223158            +3.4%   45721027        proc-vmstat.pgalloc_normal
  39763569            +3.5%   41151044        proc-vmstat.pgfree
 3.568e+10            +1.4%  3.619e+10        perf-stat.i.branch-instructions
  87058419 ±  2%      +3.1%   89795461        perf-stat.i.branch-misses
 1.482e+08            +2.7%  1.521e+08        perf-stat.i.cache-references
      1854            -2.2%       1813        perf-stat.i.cycles-between-cache-misses
  1.68e+11            +1.1%  1.699e+11        perf-stat.i.instructions
      0.64            +1.8%       0.65        perf-stat.overall.MPKI
      1812            -2.5%       1766        perf-stat.overall.cycles-between-cache-misses
 1.045e+08            +2.6%  1.073e+08        perf-stat.ps.cache-misses
 1.446e+08            +2.8%  1.486e+08        perf-stat.ps.cache-references
     25.66 ±116%     -96.6%       0.86 ±168%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
      9.35 ± 40%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_anon_vmas.vma_complete.vma_merge
      9.63 ± 36%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vma_merge.constprop.0
      3.87 ± 38%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vma_prepare.vma_merge.constprop
     10.81 ± 36%     -76.2%       2.57 ±142%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.do_mprotect_pkey.__x64_sys_pkey_mprotect.do_syscall_64
      3.74 ± 55%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.khugepaged.kthread.ret_from_fork.ret_from_fork_asm
      2.32 ± 34%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_merge
      1.32 ±104%     -80.1%       0.26 ±221%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     19.81 ±188%     -99.3%       0.14 ±142%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.39 ± 57%     -81.6%       0.07 ±153%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
    180.87 ±203%     -99.1%       1.55 ±153%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.36 ±108%     -96.5%       0.01 ±187%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      1.44 ± 19%     -85.8%       0.20 ±171%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
     40.94 ±115%     -99.8%       0.10 ±143%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    112.73 ±118%     -98.9%       1.19 ±142%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
    335.83 ± 29%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.unlink_anon_vmas.vma_complete.vma_merge
    301.19 ± 35%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.vma_merge.constprop.0
     22.34 ± 98%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.vma_prepare.vma_merge.constprop
    473.14 ± 21%     -76.2%     112.54 ±144%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.do_mprotect_pkey.__x64_sys_pkey_mprotect.do_syscall_64
      6.84 ± 51%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.khugepaged.kthread.ret_from_fork.ret_from_fork_asm
      7.07 ± 72%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_merge
      0.42 ±147%     -98.1%       0.01 ±141%  perf-sched.sch_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      2373 ± 40%     -78.6%     507.50 ±152%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.70 ±111%     -96.7%       0.06 ±212%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      1309 ± 77%     -99.6%       5.06 ±165%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2745 ± 25%     -81.5%     507.97 ±152%  perf-sched.total_sch_delay.max.ms
     10044 ±  4%     -74.3%       2576 ±141%  perf-sched.total_wait_and_delay.count.ms
      6234 ± 21%     -77.2%       1421 ±141%  perf-sched.total_wait_and_delay.max.ms
     18.71 ± 40%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.unlink_anon_vmas.vma_complete.vma_merge
     19.26 ± 36%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.vma_merge.constprop.0
     21.62 ± 36%     -76.2%       5.15 ±142%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write_killable.do_mprotect_pkey.__x64_sys_pkey_mprotect.do_syscall_64
    885.96 ± 42%     -79.1%     185.28 ±142%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    144.50 ± 24%     -86.4%      19.67 ±145%  perf-sched.wait_and_delay.count.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
    131.83 ±  9%     -73.7%      34.67 ±141%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    159.83 ±  8%     -75.8%      38.67 ±144%  perf-sched.wait_and_delay.count.__cond_resched.change_pmd_range.isra.0.change_pud_range
    227.83 ±  9%     -77.0%      52.33 ±141%  perf-sched.wait_and_delay.count.__cond_resched.change_pud_range.isra.0.change_protection_range
     75.00 ±  8%     -71.6%      21.33 ±143%  perf-sched.wait_and_delay.count.__cond_resched.down_write.__x64_sys_pkey_free.do_syscall_64.entry_SYSCALL_64_after_hwframe
     82.00 ±  9%     -76.4%      19.33 ±141%  perf-sched.wait_and_delay.count.__cond_resched.down_write.anon_vma_clone.__split_vma.vma_modify
    412.67 ±  7%     -82.6%      71.83 ±141%  perf-sched.wait_and_delay.count.__cond_resched.down_write.mprotect_fixup.do_mprotect_pkey.__x64_sys_pkey_mprotect
    125.83 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.down_write.unlink_anon_vmas.vma_complete.vma_merge
     86.83 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.down_write.vma_merge.constprop.0
    225.33 ±  7%     -76.1%      53.83 ±142%  perf-sched.wait_and_delay.count.__cond_resched.down_write_killable.do_mprotect_pkey.__x64_sys_pkey_mprotect.do_syscall_64
    314.67 ± 31%     -87.1%      40.50 ±142%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
    118.17 ± 12%     -80.0%      23.67 ±143%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
    206.50 ±  8%     -77.2%      47.17 ±141%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vma_modify
     76.33 ± 23%     -90.6%       7.17 ±223%  perf-sched.wait_and_delay.count.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
     45.33 ± 21%     -83.1%       7.67 ±148%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    626.00 ± 66%     -92.6%      46.17 ±142%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     10.33 ± 14%     -83.9%       1.67 ±223%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     54.17 ± 27%     -70.2%      16.17 ±141%  perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      1976 ±  7%     -77.3%     447.67 ±141%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1760 ± 10%     -74.8%     443.33 ±147%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    195.50 ±  9%     -75.9%      47.17 ±141%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    671.66 ± 29%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.unlink_anon_vmas.vma_complete.vma_merge
    602.38 ± 35%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.vma_merge.constprop.0
    946.28 ± 21%     -76.2%     225.08 ±144%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_write_killable.do_mprotect_pkey.__x64_sys_pkey_mprotect.do_syscall_64
      4225 ± 39%     -75.8%       1022 ±141%  perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      2837 ± 31%     -88.2%     334.64 ±223%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      4535 ± 33%     -74.1%       1173 ±143%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     25.66 ±116%     -96.6%       0.86 ±168%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
      9.36 ± 40%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_anon_vmas.vma_complete.vma_merge
      9.63 ± 36%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_merge.constprop.0
      3.87 ± 38%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_prepare.vma_merge.constprop
     10.81 ± 36%     -76.2%       2.57 ±142%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.do_mprotect_pkey.__x64_sys_pkey_mprotect.do_syscall_64
      2.32 ± 34%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_merge
    286.97 ±115%     -99.8%       0.71 ±182%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.39 ± 57%     -81.6%       0.07 ±153%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
    705.09 ± 56%     -73.9%     183.73 ±142%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    112.73 ±118%     -98.9%       1.19 ±142%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
    335.83 ± 29%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.unlink_anon_vmas.vma_complete.vma_merge
    301.19 ± 35%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_merge.constprop.0
     22.34 ± 98%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_prepare.vma_merge.constprop
    473.14 ± 21%     -76.2%     112.54 ±144%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.do_mprotect_pkey.__x64_sys_pkey_mprotect.do_syscall_64
      7.07 ± 72%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_merge
    835.83 ±107%     -99.8%       1.31 ±200%  perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1536 ± 83%     -77.9%     339.71 ±141%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      2836 ± 31%     -88.2%     334.51 ±223%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



Return-Path: <linux-kernel+bounces-530655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD03A43642
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 227EE7A90E0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AE5256C80;
	Tue, 25 Feb 2025 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2yVcfbk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FDB189F36
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469100; cv=fail; b=JUZ4zjOyke50ASXOGGu+8TPtTmE1r3yi9XaJX1p2zN/JpEPAUGWiPTo14zTXyPvKzO8V9YrQUr+3V2DAMSHYateVQv8DAnvwYDRGytxKOo9fLBrLHqb90lUQorw/PXvkt0rGbGgneEdhubb0bg53EoWYTSGekHyWxQCTD+Imt+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469100; c=relaxed/simple;
	bh=SEGJhmSlidY0wg6eAHw+F4B/9tyRLlZS0DBDWMkMRoM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kBkv3YAKPbe90d9GYIio00NVyI22LUvDV6BEZmkzFlwg2tgwwNypvtpAT2hgXN4RcANcD5HHXpLka8sizzy031hi+Sx3RX4UrSktNtlIMcfcqruWO1BnfuDr37y6oUmFYLtu2Ey8gwW9lZkYH8mHYfmxXrmwO1SS2nSc2EFWQRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2yVcfbk; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740469099; x=1772005099;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SEGJhmSlidY0wg6eAHw+F4B/9tyRLlZS0DBDWMkMRoM=;
  b=G2yVcfbkcUAFP7MS/Fh5LYoB8Fz4b0BDbNE4yZKom/a/iAtmJqGIxiyU
   ugGFb/4CAkQ6L7iRxWrpuv6xA4idgfOsFzRKlYRkgk0lS2cX7Ccggf8NV
   E9z8gsdSQCp86852+zrx589Oc/3NdIPj2uRYEIqxVbwtUmerl1Ay7cTtw
   SzfomG4zCeN6Q59ECX0rL/0WDBlxcyCN+/0+EswrBUp3j/p6hBht3PkaY
   pl/O3q+QVsTv04o8eng58+RWZhS9aeIMimaQQW5eyk84Hvvv1rj6zaPSc
   5EYPLVp8TU0cWCgVVxDza3vIIRaDvUIYpcrZloPBeScLnc9jfeghT3IR4
   Q==;
X-CSE-ConnectionGUID: sKKdD/9tRUime8FC8X9Kgg==
X-CSE-MsgGUID: 8ZrBK329SnWYPZPHI7aBvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41389254"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="41389254"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 23:38:17 -0800
X-CSE-ConnectionGUID: WuMCj4KETpuhLeKthjyY7A==
X-CSE-MsgGUID: D9GZFM0+SVCNyzQjZ6lNjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147198071"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 23:38:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 24 Feb 2025 23:37:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 24 Feb 2025 23:37:56 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 23:37:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8Et3nhKvsF5SDv7HA0Vh4mGouLwSLlIB0x3T+63ULYOPJ2AN3ggz4/u1a3HmIOxTedGYc1pSo6dFS0QeHd8zPTAz85cA7jijIlwDEw0JYtB9gi4VXAM1V85A3GnZoI1UoQsln10ViJkym+BbPuIbc/GkiaYhxRpIa+8M7TzUsydOBhM+Hn2lDcyN2xadx7eNDnkQn5riGF0hUX9LjJhyWmWbgdP/dlZL8rl5QFPSLtQZXTKUrgUmrzIlWyipfCTBbrPZ3bGVS01Yl+uphk5ZGCR2EXAcgdt9Z0Y8tzn6YYQtetx1Df8zpA7l3zkYVL1fqPRQoPAKHr3+Bh2rlwFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zl7VouWZ5ACqyjGMrNs23SxHUXxr0+jBeecFyXmqtNk=;
 b=zK55eFxBpI4aByCpMSAB/8abLzlDbA7CiWXtE9ZQC7FxKPejYoMeuOClQbBz1VUH6t7WrNfoDbfICy97pKUV2roFxj8r3cwMfZMAVDn6p8Md0usL9dMb+WxmfhXdnUzYlDoYa147PfRgcOpqiToWkyfiv7REVrrKwpT7yeyQw/f+pp50bTb2RDWUu3ksI7Tyj7V4rjN/zrA7OWVqt3ALWujiRSM00Z/q4r8c79xbHMrdRrPqvEJW1Kc6V8NfrSsCU1ATli2saLXXX25+kZEc8RBNEs2vCe5P3hTZpFkigBr1RJZnhG1phTyjuIXvQvSa2iD4sqCneQ8yy3/10FX5Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV1PR11MB8842.namprd11.prod.outlook.com (2603:10b6:408:2b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 07:37:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 07:37:54 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 05/12] iommu/vt-d: Move PRI enablement in probe path
Thread-Topic: [PATCH v2 05/12] iommu/vt-d: Move PRI enablement in probe path
Thread-Index: AQHbhntLxH0wTjKJfUOAWp0K2tk7oLNXoU0Q
Date: Tue, 25 Feb 2025 07:37:53 +0000
Message-ID: <BN9PR11MB527693E12F3AE890697C00608CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
 <20250224051627.2956304-6-baolu.lu@linux.intel.com>
In-Reply-To: <20250224051627.2956304-6-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV1PR11MB8842:EE_
x-ms-office365-filtering-correlation-id: e872816a-6180-419a-ce9d-08dd556f50b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?LikFEaZUTsp/01AVheY6CKnGGg2op26T/DMoquMwueoq3HvR1ZSvLcgUq4G+?=
 =?us-ascii?Q?25ocwCdYqeNn4Qc0UxuAZn0K/k6nAnTqESvWgC+0meCHfaMeCC78FXEEhfG3?=
 =?us-ascii?Q?3hMtkfEgGYCq9LLNS0r+OZVl5DEeHeXF4u4i7e6v0aM2j28vGIX9IkLFkuPr?=
 =?us-ascii?Q?bg1zMNq71kgaKN7NRmKiKuunkcEASVe1RUw4sGPOVUDXsnHEOgQlHcYMy7Lt?=
 =?us-ascii?Q?tAF13uhz3duAhIgwj2wnzU1v3QQWW9vRAKN1jjPcdvmCaPhSRTNavn2dAfAT?=
 =?us-ascii?Q?z1LY9QUDiSmfyKeHRdCH4MUW8E3gw8/EUhp7U20lIZfuwLTROkJdF9WyzMeQ?=
 =?us-ascii?Q?45YJPU4U8tPMKPyKKxU/+ZVzJOMasWui0gGTZXR8WS6hsZ0OOdge+0R3fCLt?=
 =?us-ascii?Q?BzHxrmykBl1KJ6RUbWvIq4cbuRiNaIg0N9QunjojzhbM+ivuQXEQAbQrwmLf?=
 =?us-ascii?Q?StLLyjS6lWE2aMlcu4cqVAHl1qUAz3fY5fhSiluhg5SOHhj05W6VBJI1G2vP?=
 =?us-ascii?Q?Fkjp138du622Udu3KIf7IVpiAU0kR9s7EkL86t5akJDTrW+OEMEdW/HMfHtp?=
 =?us-ascii?Q?j7I42WrgHPYx6Ca/wvRjDm9XlmI9rmAeJMWk0T66opoUDEC0rnRHMyup63WR?=
 =?us-ascii?Q?HFGRhw0zGIPAy/AYuJ9BO2EITiMS6zHpvYxV2tffMVj3fgY4AMZbDmP6rBJM?=
 =?us-ascii?Q?FljzB8YQgnbmj5zsseE3U1HGHLhSIiRl0bOLQO/4C0a8V7ZNLOpW1JRINBvL?=
 =?us-ascii?Q?zUGQo92Qo133vrjcsEU2NvozOMNW0rAI6lDaLObVSdoinwDcPT0QyNaKByQT?=
 =?us-ascii?Q?74L3K69IFUw+ANmpPIeYKfN4sOlZvRJk4T5DE6z6Xv5aH/6D35LzWmDmQ/oR?=
 =?us-ascii?Q?kvIJgcqZjpnARq5PSE9kA5FYbtQ9lwHeDyWDtTvW7ZKXCmKkopZy0x5E+g6T?=
 =?us-ascii?Q?rAXdcoSSO5b1ucQjQo2UVPnt0mQudHrhRQUTe7ejY0SKR2C/UoIPHB2/C0Jq?=
 =?us-ascii?Q?TH0HtL16G4YIv27fo+RaCx89Q35JwBfai/IiCZA3EXi/9t1ak9Pi5nzEr1tg?=
 =?us-ascii?Q?p04FXdBJ/Za+RbTLRj20mFmgmpHcb2QXteYLSlI/z0LpVZHaCl8vHB7FaZp4?=
 =?us-ascii?Q?5/QmIlB3xf+0DJCnnykD5w109OM/Tsp8euG1EUr1aqJSzMw6MjcAUkOBBDF4?=
 =?us-ascii?Q?H1sbvCQm/0J0r8WOKY1vRQ4gQDfXO2896m3sMHAnD1JKuase1G76bhDl3FtG?=
 =?us-ascii?Q?j0ayCFcRAmV1jIIASfaO3q6vqXasD/b6LPcRXpCj/RubF6Cz3fiv+ZPbe+VZ?=
 =?us-ascii?Q?/SO4U7zIakP8B52vgKSHyjveVPa//NJXL+K1GGe2eio5h47lXYpcwfrm2UgW?=
 =?us-ascii?Q?iWwaxcF2SJ0sWdirsKCIC7JOXf/V0kCorNZSpLkW+xvhwBoYSy6soXE7jfHZ?=
 =?us-ascii?Q?trmfA0ELZKTM7ck0T7VY/dxxM3aFscG5?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?afh1faN69EjS7Opsb1o1O7LUFu+YXffPpeKb770ewBrWTCA0XdM5hbqm2eAX?=
 =?us-ascii?Q?JIe+66c4BwAe1nHWBIyZArIEVBQdBTYESMgSvL1M4e7OQIQ+stoXAUy2VdWC?=
 =?us-ascii?Q?py8eKvu6M0KKVVRxZjPoORXURnjEAE4M4Cqw5uMCm6ER4V/MYgsgIWTmTqcq?=
 =?us-ascii?Q?+5YUGmIlhbu2WmoXi3gNhMT9PH9tw2IuzbxgrQrypex2JlOUliJMdV8oIspN?=
 =?us-ascii?Q?HD53OW922NP3us1GF+Q/bdPk7Z+DnYCFkp9u/utokX+sNEHvlsDwZOcP3Czg?=
 =?us-ascii?Q?ld/hJEryDPausT3HK7ecN9FJpGl0X84WC4hEP1CndysaP5zb4OwnUyxZAIw2?=
 =?us-ascii?Q?QhLQOUVYx6S7Kw8kUuI1khxvd4TqeeY3j29+5Ic8M/olK3nqkKhrg3adoAne?=
 =?us-ascii?Q?DCu085gjBuS3o0bFTjVaKlJ3xugol8xG+krGx542zx+nwTfpNp5fi2MuTh++?=
 =?us-ascii?Q?R2oFaXBsDdI0w02uXeu+dt1UDpkfw3ZNBNVaD7puOFaUIrXfzG25b05qc2jL?=
 =?us-ascii?Q?BFjoW9sE8IuptASmpKzxnO9wQgZjn2KvXJa1ZkxxU6yUTsuNfnsqrVIs+xo7?=
 =?us-ascii?Q?IqxjqTvcF1gxiNRjTN1f/Fzqc7eQF8ppOfHUHq1YQ5W1mWYy6V6vY+qzPvKL?=
 =?us-ascii?Q?HusilxrzCsW4rcRcBiJJ/yUWH7l9uqTMD1IJaYpfXcOOybaZMOWMgZIVT2cI?=
 =?us-ascii?Q?sx4W1vpXJE98sqnikZUKlxHWHaRaS3fPpgo+Wk4eR4s3wuo7YA2YhZg8n5nU?=
 =?us-ascii?Q?OEWZ+6FAg5Qy3xvS+PecXAEMLB6mUjMXdJt4Sw5wT1cna8rlHLVzZpd7s6+7?=
 =?us-ascii?Q?mMl247xd42BLMAIj7TbunIRlTtWj2EK3gF1vs9xXbi97Yqp5hcfnNBJDdxN9?=
 =?us-ascii?Q?B5rfOg5tKHJy6WmEYyhbemthZlKQ1v1mUxBX+n/ZXcFKjHxTNuGpG8cWEyVS?=
 =?us-ascii?Q?V+gZqWFlz0Qc4wXv8cWiOM2h8/0dsGZDtHBo0P8dm32o7tUpJKvlWG9qx1DW?=
 =?us-ascii?Q?WN9RBQnCn6M37IDm4GoHupUk8dSt60I6RlrkOHPjToHyzBLBtGoMZO+GasZL?=
 =?us-ascii?Q?Gim1hh7VAJodbrZxPRhxhjhEuBFqDFS1myaC1r3PwCH15UOLtatBT2MMPWsR?=
 =?us-ascii?Q?f4/gkjJVzXcdXAS0x5eqeDqkEy2TumrlHLdjnytUbF6DWHQC3joI3icWgPc2?=
 =?us-ascii?Q?LgZh/c5JsYQ8F+QoKQlOfulrDh5xOd3It4ixeFl0CNDgDVxyTPLk1825P7UJ?=
 =?us-ascii?Q?o3wJ5GztSvqHan5jxuPlx4XBI2tIIQBjLyppYQtBgRiEyCcCSokCNZdve6rx?=
 =?us-ascii?Q?hi+zCaPu99sJtwC2+A4IGEUSR+/l+uXukTNjuDsPCkPM1lAHcLVAsANHCMDp?=
 =?us-ascii?Q?RNtU6mxqNE5s1Jsz1vTzGBcFX4NcYe49R3ZkhyHsAcpQfx/kmijXSdk+bGQE?=
 =?us-ascii?Q?0mqvZiNGH8rZuLa4Mk/FdoPrB3fxztf0Eg08Ge7NTt2xLxkKlu0LKSv39M//?=
 =?us-ascii?Q?sEmlA4SctUFyD4CzZq+FFi3DYatbZEo1is4aG5Y1WuYZwcQO4EeriOQfinob?=
 =?us-ascii?Q?DeyMpoBQS2p2nzLa9qxLSDYMeaD4a+YQ0Kn/4QGG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e872816a-6180-419a-ce9d-08dd556f50b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 07:37:54.0085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uxjptqHfeAZNa+5Q6mCKMEMxXydvmdQXWaXapKVP9O04JCxeTrAnhDiRdAE9Sbg8adS6lwJKoZ2MZhQBbqoI/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8842
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, February 24, 2025 1:16 PM
>
> @@ -3743,6 +3743,16 @@ static struct iommu_device
> *intel_iommu_probe_device(struct device *dev)
>  			else
>  				info->ats_enabled =3D 1;
>  		}
> +
> +		if (info->ats_enabled && info->pri_supported) {
> +			/* PASID is required in PRG Response Message. */
> +			if (info->pasid_enabled
> || !pci_prg_resp_pasid_required(pdev)) {

this should be:

	if (!info->pasid_enabled || pci_prg_resp_pasid_required(pdev))


> @@ -3761,6 +3771,13 @@ static void intel_iommu_release_device(struct
> device *dev)
>  	struct device_domain_info *info =3D dev_iommu_priv_get(dev);
>  	struct intel_iommu *iommu =3D info->iommu;
>=20
> +	WARN_ON(info->iopf_refcount);

call iopf_queue_remove_device() in this case?

> +void intel_iommu_disable_iopf(struct device *dev)
> +{
> +	struct device_domain_info *info =3D dev_iommu_priv_get(dev);
> +	struct intel_iommu *iommu =3D info->iommu;
> +
> +	if (WARN_ON(!info->pri_enabled))
> +		return;

also warn on !info->iopf_refcount


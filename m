Return-Path: <linux-kernel+bounces-291385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F29D8956171
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22EF41C213DF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2484113C81B;
	Mon, 19 Aug 2024 03:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TB8AUSZm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140C13C3F2;
	Mon, 19 Aug 2024 03:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724038084; cv=fail; b=ixOxS5Sb5I91Bsc9jUAyyAe/DgegIduMSRp7/3uR56+j2VOre7HWfnD/yjSCwz+QQ1y0uARDG/NJ9WvN3l4gncZ2Rj0MmVR4wHqBDFt8aLBZeb4yb0K5opEZ4OoT8Cpg2rOiopP8xLFNyJeKeMdz7FcqbCz4JgNSzI4OF9XSGCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724038084; c=relaxed/simple;
	bh=ew76mVRC99aEykIj2qVYJsvDdlSFmeXdSxDRYCCO1jQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bt9w4rmubl7d58ZUflWVP2pCDlulZtiVgMTT9CjbBu1T4OIJH0C2JM4F/yOJhU5IpkCmk3K/+fm7CYPhsxOLbu61R/9jcW2f2S2z2aqsJKCRKFY9ehKztje7GXdyra3m8yU4JwBXsSgclFjztStkVVrCVt9ChatBhXB3JPiSTF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TB8AUSZm; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724038082; x=1755574082;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ew76mVRC99aEykIj2qVYJsvDdlSFmeXdSxDRYCCO1jQ=;
  b=TB8AUSZmFjyzvN+HJoAStICejyX38EUt/Xg5l03yJTAbknjDV0dnD/Sv
   3W8W+n2OYupN1gKKpjMel8+gP5C6eQTzYcBm3+Wq2K+Ma2yEJt/aSnM0x
   OUnPmoCm9FwGDAfj9uQW3qWVxdVAUMaQcRmu2b7rgrEp8YSFQNH1FZqeM
   Aw9d7XMdEmVVzW2k0oL/q9sxrN6aYsL5pnshbst6b4Jtlgvz/9puo9Dt6
   ZpWME7GlvmUlgfBIE3C+CqkSynL/nk/Kv88oy5bvJopNq9E/8R9XlkkcL
   y+8zlas70JAGnIbj9/ZbMFpksawgXnQ5Vw3G6Hsw4nTpH4XfX+u/xm9Bd
   g==;
X-CSE-ConnectionGUID: lAT65gGSQlmKqzahMt4QDA==
X-CSE-MsgGUID: 29OkLr2FRhurDE/Fmn+BMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22142525"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22142525"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 20:28:01 -0700
X-CSE-ConnectionGUID: EmmYiF/GSNGtWnYDHGyPkw==
X-CSE-MsgGUID: jqiD3yGaSp+GnZ+TPBpZNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60284752"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Aug 2024 20:28:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 Aug 2024 20:28:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 Aug 2024 20:27:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 18 Aug 2024 20:27:59 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 18 Aug 2024 20:27:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r88PFE0sk26ckKocd5xu2XjV70iyeccDuekFSQCHtjkydhcad4zz0RdBqt8TIZ4jnV5Dn6y5oqp/EPv0UnjleGZSCMWy6jf99PfKG4fqXGExLbt9OnJnSkURn9rUGmShsxmJVqG/BqsGOcFMNWiXdxbCtLZnIvjcl35anyl8cOvPD/iF3484iJnMtjXA0e3A4TJOZVg44Y6ztu56nRyiF2+BaocbWqiydFG2oH1pquniWzVdMsvoJEL2uLyxsFmM5ZKA3hUKR58/nX+7AYZoBQ4ycFi0rpBsBnO97BBv4YQaDc+a6z2u6s5SKEenoNgPIpBJJfj6vWXdLOKEo7slpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPeIHcQdL6mul3VQ01T8QGhvxfLEbfdAFY2HwvIQVdo=;
 b=xX0DDsU+RjFklUuXdE8EpgOW+e0y7Bneo8HquOk3hlvj8reZiBqVU7ytZntL1SsUzxPf+Sm/rYNjHgYeoX8tVGur1d+9O5V/3PYob01E9qwtwkv1kQDe19hpG68FDBajWPOXyWZ2LqNe3QbsVu09AVLZLD72cuyG63F390nSiehPw07xfX2Xv5U0P3BXRaw0wP7MDyMxeKPARmN/8NRAX8GWHEOvKw94ljheboxb0fbM8KproEGFAmdlYQvfnTJz5Du6uz2F6aVz6IBPm+NHuUPu+bocr6y8dDgW1B/eipitjsA2OEmzNnNK99a5XRAACs0xbKg0Pyuagq0UBRcQeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com (2603:10b6:a03:53e::10)
 by CH3PR11MB7763.namprd11.prod.outlook.com (2603:10b6:610:145::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Mon, 19 Aug
 2024 03:27:57 +0000
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::4053:18a0:f95:3b9c]) by SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::4053:18a0:f95:3b9c%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 03:27:57 +0000
From: "Liao, Bard" <bard.liao@intel.com>
To: Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>
CC: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>
Subject: RE: [PATCH] soundwire: add lane field in sdw_port_runtime
Thread-Topic: [PATCH] soundwire: add lane field in sdw_port_runtime
Thread-Index: AQHa58c+ez4+gaVN0k+Z1/Bhv6rQVbIsrtGAgAFKUWA=
Date: Mon, 19 Aug 2024 03:27:57 +0000
Message-ID: <SJ2PR11MB8424B8BE29B1B40EE2F608DEFF8C2@SJ2PR11MB8424.namprd11.prod.outlook.com>
References: <20240806060930.10433-1-yung-chuan.liao@linux.intel.com>
 <ZsGg4c7Nc0jiyGgK@vaman>
In-Reply-To: <ZsGg4c7Nc0jiyGgK@vaman>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8424:EE_|CH3PR11MB7763:EE_
x-ms-office365-filtering-correlation-id: b1ffd48d-8333-4499-9a6c-08dcbffeeb52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?9kqTCW3VDrLm0XtP4HhAh3FcVcdWIKD5nvLrJcl8WADSxYYTavjOGzYSc8uk?=
 =?us-ascii?Q?EnVl2htRWdL1G0bvNwvj+lqjT6LPgu9R9tztQOwKNiK8HJqvG32/NX0a/Cn7?=
 =?us-ascii?Q?B6gR9uSICYoiUUfFAEMHBROEfFLMDoDajjI2GOq4IvELtoJYMOOqulxYZrjz?=
 =?us-ascii?Q?ezA/GoH866L9LmA9fAfmr2nw9l0ihkA2qYPsYjJo/KRYg9DBRPtwyA0yDoMp?=
 =?us-ascii?Q?lHDcD9Bb++wmsAb7FeqzEOSqnVUQrmgoxZvkF7xCebMeV2wJgLmxwbi2IrY+?=
 =?us-ascii?Q?zhpLp0p/TsYNSoAp6zrkjjtsMMbF+8E/2P3eX0g23kV1jbbbdBvMPvRPlZfP?=
 =?us-ascii?Q?vpxDLhIhuPXc8hnp1t8uRxbUsjGbiMlBgVl7GqG7y2sbqRGBn0zjgiTQ6Der?=
 =?us-ascii?Q?OXaBIqL2HjlVK3SYFZe/xeUBBK1/KmV9rPCLHIakJ4k4wQEpcVfe6xIpmlVY?=
 =?us-ascii?Q?HymDcoU/i2XlWYbYf6L47O5lGRv/I2Ab+mWMjjmIXKkO4Gmd+d1TLZy6kDaV?=
 =?us-ascii?Q?sisqJF+snswkk+N4vdPkbRIRPHr2XRukoov3k9SZKQ/F0p3HU7pZjn01k5E6?=
 =?us-ascii?Q?YG1RUIXCw2YBQMCdS6ifHd9LX5RpOmZWeD+k5zUmGmxL9gDEB1AizwCvL1t1?=
 =?us-ascii?Q?IBPlZzxRbjNeesdCBh1ZKt0JdSC9u4C58FVOXo+8xRV6/+x0pmdgejNKmjX9?=
 =?us-ascii?Q?9PXnj3T1aKwtCWwoXtZUbwjSvyblxxE656sxys/aokX5hvrjeQE0WkY/9PY8?=
 =?us-ascii?Q?H/Sdt+A3n5odjvhhS4Zcqmub9b1HES1n6HH88NOToFAO79U78fdYwX/J8Hml?=
 =?us-ascii?Q?HMGEJ7corLO3owmJ8blh5TDgCd2NaLWUTG/UjlORk+VbVurcRoHVMK/UTMde?=
 =?us-ascii?Q?4nwDwivhjxJ5bKlCNr677Rbg4KViH7u5X2tC1wHODxMGS9ltWDyyQ4XgRUQW?=
 =?us-ascii?Q?HwBJkXFGrXG4rr4I7az+QdPVP5CKVvtI+SFo6sza05kcfuFhJ6X3+DWl+9la?=
 =?us-ascii?Q?rCzVP1N99WqP4vAAxFV0S2fS6h3cyec83UUhcmQkqxf0ENwrJLp0Lia7Es4k?=
 =?us-ascii?Q?AENadd6Z4HUkY1wiRxrB0JJM2XQHivkzMkiwlvBzfmQVdAsYNCX+7Ze+9plF?=
 =?us-ascii?Q?uJONkOVstrBFYEHcxjnKhdz+1SqyTi4mLsHqDYfglXInhpu5qYuw8XGMtnjy?=
 =?us-ascii?Q?BlczyWx/qgQiWXNJRqa0helHdWdz2X+tuvp98k43ORt8NQ4E2Rg0s/CldE6+?=
 =?us-ascii?Q?N8dUTpVkj95FoVoqFveVyFRB00enozts3WZxB5eIOXaFk86BnkOSf5xrELxs?=
 =?us-ascii?Q?rWZoTsFytKRWvzhCteAFQgSmAoxjrrtgsQmfH87eCHzDxMgbjl46nboYTmbq?=
 =?us-ascii?Q?cudkoGcZjACt4OvUUB+F98i7JEYiyVfyhvZSD/BQhU1IRX2yoQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?51kmZW15HUTTuP5T5d8PlCaKwCrnPQxJTQ5IJw7oe7ZNv5JKEO0WScxFi4Oq?=
 =?us-ascii?Q?KDnk+k5snn5QKrxhocwHboCok1nIfOG+YYmg7XxU9Oj9nT/CjA7RQglXuN5o?=
 =?us-ascii?Q?hUvAyGivNHTmbWqT5/zmnIvhXCxxrGv326B87ccgKuOxjbgvySYeCyjL9Il2?=
 =?us-ascii?Q?83oNELEOMsgYCDUJveEeVbfnVatDN2xp5Tkls6VWC5xXR/n+qndKtDSWfAIY?=
 =?us-ascii?Q?5yUogMpoYoJSZ2duFWVwgJ102RKtuMbaoBrdJPqqeZpL/MFXXgTC3S5GOz4C?=
 =?us-ascii?Q?H6LJs/La0i3L7ELPYTMAqfmnfCBsqq3Ffx9g/+wBj/WnLrHdDSFDpdnOT4Wf?=
 =?us-ascii?Q?f6078lnaWVWEO8WNUfBLu+ygQ3KCDaHCC2j4yQfZeaRbtDM4vhOxEf2bITZQ?=
 =?us-ascii?Q?/jYfcxfmUQ6dIDJ6bG7dYJKsCw/UggQ/rOJVvfge1IDJGlxjZkMybWzfeqsH?=
 =?us-ascii?Q?F+mehBB7pYro0cmTovdFuM57dbP1XGf5wDxXtESWYMSwzmW5LkCrDf0O9UxR?=
 =?us-ascii?Q?g9l2iMWIM/sfyDZK24AyF9HZ669Y9hr/FwiIhLvFQng7PJJUylFE/lKXr+5r?=
 =?us-ascii?Q?CtjJzIHLiTlPMEWuus/HbcLVzJm9cWcVglldoG6OghFPKpFdkux/tzuLUGUo?=
 =?us-ascii?Q?I1ealBAMyxlAZl/NQXhG/I0S/0NlxFYXiHMcAOQLXerfRkkRblo396awXsfN?=
 =?us-ascii?Q?jBtpKZYYkNJ+/vIsoKkpFKvJa3w+de6UDxhoB7xXpTLu35ZsSpkVkw/wIRiY?=
 =?us-ascii?Q?TnYnLkTNVy3D0PrsTP/PpEJgXxOsGpT9SBvgUSiVmxWmoYQQjdNAE2BgeX1X?=
 =?us-ascii?Q?0/LPifxiW76hFk6LfznVR4iLGHfaZp50/0Zq4dnwkUsqBEWvIkWpZFDai1SZ?=
 =?us-ascii?Q?PdD/+w3i66UNRV9D0T8QKp9hJU6Sx3DmS82WxNdOYnOAtE6jCB1Qcg8x/bcR?=
 =?us-ascii?Q?94Z3Q37BC7dAnEl3LdpTSwiX2hIq7eV0n2o8JOE8+RsrJ04ckqYP6WWJJSOX?=
 =?us-ascii?Q?227wBjDKxV2D2u1hXmj5QvMUtGQahibY7LiknAjsnXde/+IZaNQtSWsmblZJ?=
 =?us-ascii?Q?1bgl3yhKX8pZHST/7R+pe2WPyvGgqui/ae7qppD8brbgCkY5mNBsivJOoQMA?=
 =?us-ascii?Q?BJeenzFTq4nX9jr4G3UbK/Cn+l/xA3QE3Ev5lJ+Wpqwa8/d0Dg8UvKlRRZ+Y?=
 =?us-ascii?Q?YY4j6qAiX2SFpaRoz6HB/IajCFG1f7eLTia01VMX6+r2jm5mR1BonESXfD8g?=
 =?us-ascii?Q?whMBeb1v7pngCdZnn4oLp26c+1cgo1DNcsCvEAcYMYA7k/vp8+AlcEJzbzrS?=
 =?us-ascii?Q?/F2IVFyHYc7+HzZsSK8Jn1JkYCZboDG6yjvTOGJ3XfiKt+dSHz+ZJp4+cC3B?=
 =?us-ascii?Q?eAdlLH0HXy60wmUZrlRhvRA1k2kIEQ9QwNXh2IZIh7RqFmrK5oz2J6+lw+pL?=
 =?us-ascii?Q?kPxAR94cTKMk0+2k+7oY2OM1nH2ZCcuZfdrLsvaK2E0FoAzqvl9L0MSh57D5?=
 =?us-ascii?Q?upKzDiJ9fVC1oE40Br0Iinc1Qmeb3Jpn1egsbk0H4sOc6lux+g952epp2plk?=
 =?us-ascii?Q?9kVVVhN4LC+ef7oYYeA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ffd48d-8333-4499-9a6c-08dcbffeeb52
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 03:27:57.0343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z3AkLBOxhCvRG34LOuS1xzivK3hqmUxPUtOGDE5K2CcJq73R3kY83MLKCUM8RjZHRiQqxKOCes0O9+08sL742A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7763
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Sunday, August 18, 2024 3:21 PM
> To: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: linux-sound@vger.kernel.org; linux-kernel@vger.kernel.org; pierre-
> louis.bossart@linux.intel.com; Liao, Bard <bard.liao@intel.com>
> Subject: Re: [PATCH] soundwire: add lane field in sdw_port_runtime
>=20
> On 06-08-24, 14:09, Bard Liao wrote:
> > Currently, lane_ctrl is always 0. Add a lane field in sdw_port_runtime
> > to indicate the data lane of the data port.
> > They are 0 by default.
>=20
> Use of the lane? also missing setting of lane variable, dont see in this
> patch so we are passing garbage? It might work as structure is kzalloced
> but I dont think we should be implicit, programming makes sense

Yes, p_rt is allocated by 	kzalloc. This patch is a preparation of
SouldWire multi-lane support. We will set the lane variable in
the follow-up patch later.

>=20
>=20
> >
> > Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > ---
> >  drivers/soundwire/amd_manager.c                  | 2 +-
> >  drivers/soundwire/bus.h                          | 2 ++
> >  drivers/soundwire/generic_bandwidth_allocation.c | 4 ++--
> >  3 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/soundwire/amd_manager.c
> b/drivers/soundwire/amd_manager.c
> > index 0d01849c3586..babb580f3124 100644
> > --- a/drivers/soundwire/amd_manager.c
> > +++ b/drivers/soundwire/amd_manager.c
> > @@ -410,7 +410,7 @@ static int amd_sdw_compute_params(struct
> sdw_bus *bus)
> >  			sdw_fill_xport_params(&p_rt->transport_params,
> p_rt->num,
> >  					      false, SDW_BLK_GRP_CNT_1,
> sample_int,
> >  					      port_bo, port_bo >> 8, hstart,
> hstop,
> > -					      SDW_BLK_PKG_PER_PORT, 0x0);
> > +					      SDW_BLK_PKG_PER_PORT, p_rt-
> >lane);
> >
> >  			sdw_fill_port_params(&p_rt->port_params,
> >  					     p_rt->num, bps,
> > diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> > index fda6b24ac2da..ff03b97f1d8b 100644
> > --- a/drivers/soundwire/bus.h
> > +++ b/drivers/soundwire/bus.h
> > @@ -90,6 +90,7 @@ int sdw_find_col_index(int col);
> >   * @transport_params: Transport parameters
> >   * @port_params: Port parameters
> >   * @port_node: List node for Master or Slave port_list
> > + * @lane: Which lane is used
> >   *
> >   * SoundWire spec has no mention of ports for Master interface but the
> >   * concept is logically extended.
> > @@ -100,6 +101,7 @@ struct sdw_port_runtime {
> >  	struct sdw_transport_params transport_params;
> >  	struct sdw_port_params port_params;
> >  	struct list_head port_node;
> > +	unsigned int lane;
> >  };
> >
> >  /**
> > diff --git a/drivers/soundwire/generic_bandwidth_allocation.c
> b/drivers/soundwire/generic_bandwidth_allocation.c
> > index b9316207c3ab..abf9b85daa52 100644
> > --- a/drivers/soundwire/generic_bandwidth_allocation.c
> > +++ b/drivers/soundwire/generic_bandwidth_allocation.c
> > @@ -56,7 +56,7 @@ void sdw_compute_slave_ports(struct
> sdw_master_runtime *m_rt,
> >  					      sample_int, port_bo, port_bo >> 8,
> >  					      t_data->hstart,
> >  					      t_data->hstop,
> > -					      SDW_BLK_PKG_PER_PORT, 0x0);
> > +					      SDW_BLK_PKG_PER_PORT, p_rt-
> >lane);
> >
> >  			sdw_fill_port_params(&p_rt->port_params,
> >  					     p_rt->num, bps,
> > @@ -109,7 +109,7 @@ static void sdw_compute_master_ports(struct
> sdw_master_runtime *m_rt,
> >  		sdw_fill_xport_params(&p_rt->transport_params, p_rt->num,
> >  				      false, SDW_BLK_GRP_CNT_1, sample_int,
> >  				      *port_bo, (*port_bo) >> 8, hstart, hstop,
> > -				      SDW_BLK_PKG_PER_PORT, 0x0);
> > +				      SDW_BLK_PKG_PER_PORT, p_rt->lane);
> >
> >  		sdw_fill_port_params(&p_rt->port_params,
> >  				     p_rt->num, bps,
> > --
> > 2.43.0
>=20
> --
> ~Vinod


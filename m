Return-Path: <linux-kernel+bounces-516992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58ADAA37AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2F016CB8A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B64B1714B4;
	Mon, 17 Feb 2025 05:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bsWKRvBu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AFE81720;
	Mon, 17 Feb 2025 05:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739768653; cv=fail; b=HrUCGXsTcN7omvaFgaGH+OWzQtnLzisi13nhIf+AhZXmb1A9SgMMhUTaMz2WOXkDVa258GAdscvFr1AWoWNrFUVl5CQkaYhxkW7KYTUJzkE55pvafm1zH4aDBA3j4tO2fGkD2eQBdT4TsUrHqdQXOiodpMfhTvzcL/+uukgM0RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739768653; c=relaxed/simple;
	bh=hgvF0Jt0d1F9JR5RHs2Xx+q4RT6EO8iRAnFUVqZVFs4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kKNeH1BNk2PdgfNa/oCgpqkHe3WDTNCQkIc7FPu0nIJMcFwJnPunMX+OMifhV0Z+ptqhwQRhubtFgl4NqQj+vc36g2Qgbamur7nTVGG1R+CUX+oMJ+DSRGzbN1SA/CVz9UDVPSs+mfUNNjsSTr+QJTJASo96Z+wGclQp6G4zqr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bsWKRvBu; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739768651; x=1771304651;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=hgvF0Jt0d1F9JR5RHs2Xx+q4RT6EO8iRAnFUVqZVFs4=;
  b=bsWKRvBubxlZfaB0qgTT4L94bv5otHS3wBES+V2/Eh8tnZLheYhN/NU6
   UWac6WEONbUMu1ge4EH5tVci/vIY8H6ddJSvqZYm7v7Pqn+1jM2LXZOL8
   LhcJ8iFDzlVzhtJnoBp00yTuZxRtozj287CS1/ILhNLNjoU9OYcjJlalL
   QVaGP0KrslvH+0ndS90KSYhjLqraeVBr9PRm7SHrzXrkLOr6HOPOGkdCW
   H2DRJOOdBDjVLoesK6n5RV9BnoZ/zVUHJfR0fhFyr4nOjjF9olZRLW3Lj
   4eIvUU3JIZ8/2PUGD/IExmAc6DESUZZb/yDtL+GGRZgMxLwcZLK88r3gT
   w==;
X-CSE-ConnectionGUID: 5/S61h2YQsiJepRSbbId+g==
X-CSE-MsgGUID: 6X3AkiJXTumdY693eO1K5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51866059"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51866059"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 21:04:10 -0800
X-CSE-ConnectionGUID: rl7eEYi3SG+c3dFtF5BXDg==
X-CSE-MsgGUID: U+YX26lBRPuWfWyP2QeiCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="114525778"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 21:04:09 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 16 Feb 2025 21:04:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 16 Feb 2025 21:04:08 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 16 Feb 2025 21:04:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZG7t6TW/cKc8CsSf9pKSfuPe6fdPq3X1vGIdHbTRZucPHV7TF5iklxJ4VYnEyLHxwtbC7dzz0OgFFltbrFcgU7W9l7h1I1HpBOrg3q8iLeIl0/zDSEE7Fc5igcD17qJMICyOD6yblX5/1dpk+yWPuRQLbdJd1nQqZwaqTHLNyAxPLQKmighWbaCorukvYKXPOXSvje4wYspBa5qmlFMQzPuvRoHc8C9EpB2xxtYJDx/MMYqS4cNCq+W71CAfDckMZCz1HVTgz2uB9O/4I3K4puwY3SIylc5iKhU1VVrPEFOf8tex9iQdwsQD3dG03Gh6GLQAMI9S6KwLY8QQkAEAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiN7QGPcGVY9f2LOzDzPCZOl6Kwd0mXOwUhVMJG+oRU=;
 b=QZ9AHIfycaet0a5VrCWXDBCTQGwiLlxjra0wiC7V0qkgYtFrIQcn+rwCv5eWsX/jM49zY33hWHwJ9xN2JNMuKUVEbLWP65tPVy/XR6U0Wv5YtKndQzgnpcpyyLLtKCR1UrECkKKHdwMafuunOBGO9UmHIy/oMmMKJ+HZJu6IvdPJdAYSbeMeI+b3lFEWtOdeCtwCUzYer4/uwVBQU5CXOnsD7piivjGkwfUoSMXG18Q/xfo7VQ+KmFPLmuGbo3hcrnU9vhsIB9CDduw5liUgeWkafCNjwu5PIcNjBY2rojo4O0hq/tHoA8hhRQWbBmJPsrH2d2Zy/rExBAp6VRoWSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6031.namprd11.prod.outlook.com (2603:10b6:510:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 05:04:00 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 05:04:00 +0000
Date: Mon, 17 Feb 2025 13:03:49 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Cryolitia PukNgae via B4 Relay <devnull+Cryolitia.gmail.com@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, Jean Delvare <jdelvare@suse.com>, "Guenter
 Roeck" <linux@roeck-us.net>, Cryolitia PukNgae <Cryolitia@gmail.com>,
	"Jonathan Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>, Celeste Liu
	<CoelacanthusHex@gmail.com>, Yao Zi <ziyao@disroot.org>, Derek John Clark
	<derekjohn.clark@gmail.com>, Marcin =?utf-8?Q?Str=C4=85gowski?=
	<marcin@stragowski.com>, someone5678 <someone5678.dev@gmail.com>, "Justin
 Weiss" <justin@justinweiss.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v5 1/2] hwmon: add GPD devices sensor driver
Message-ID: <202502171113.9faaae-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250211-gpd_fan-v5-1-608f4255f0e1@gmail.com>
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: df7ff442-b41e-4816-5b09-08dd4f107dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Whzq2ETUYTNKs0yCuxNW1LqQIL1X4lTWvMetylq/nWluCS3cY189QcH4UcR2?=
 =?us-ascii?Q?SuE6QnNw4nGOTTJKgJpLh6dre6KABD4n4ZqVBAi9KI9Qbw3wNchdbVr/gI+x?=
 =?us-ascii?Q?jgyOnFbuO8KZP7qTcYovd95YRXaPHVt80tGAx2GlH3ACWhlSWyObPywGYtPM?=
 =?us-ascii?Q?qXiOn120b7Ejn+4Y1yu7kpNDGiWZ+OTANb71DVuVIBcmhidPTJNwEqzy2sK8?=
 =?us-ascii?Q?ezMSUYcQ2Pcj+gVESMTY+UDdFTZ6bB4SegFVtZXO44lV+HQjRDmrSNYvYiPH?=
 =?us-ascii?Q?gHzrzYsHZ44KSBAbeF8khA45y+roMQncLyu3KtgE8SAXx+o+J3wuj+Mb4eFW?=
 =?us-ascii?Q?VrpSQPvmRQIaJhnHcCmQonjGtqHISsYLRpMVIeog3xd5DnRvLPQuJO5UwcNw?=
 =?us-ascii?Q?wRz1zROJgvmXR5Unt+28l3Kx7xPvPG6Rm9SrfPNhLHL931Wo3i4PwK0DxNQu?=
 =?us-ascii?Q?NYkS482z3wD+jIqUYcX7VfunswC6FmA69am+Dqj6pw2fj7bKANoK/wrPpg8N?=
 =?us-ascii?Q?d5prRY2+uqH3MzegwtVEEJJAl3Ra+E73YRa8KgLandbJLUuN910MkJQ0kV5i?=
 =?us-ascii?Q?+YPhAY4cl1bBQRKENTzSjODxzA6lB0Vkq80XIouAYJ8v+qnEbYKRGSYSHsfu?=
 =?us-ascii?Q?tpcMwvD/ASJ7wNV8cDYAP23+7MDisirB/uxwWgvnjFGFMMIOJxVmOeI3PgqT?=
 =?us-ascii?Q?+XGTk7hgDFIHgueQk7zYBWEEcnqH1xdfEL94BkVEjHd26FKb0fjf4g6g5DDi?=
 =?us-ascii?Q?EKBY1f50Jk9CMZ1s8Adc5zKw/iDegm/5OpJfiBkR6D04N5yyhDw8npwvURKI?=
 =?us-ascii?Q?IW2qkdpVqzKdEjolGUFgaW9tnuLYpadInO3L673vui1OH5SjMBl/C+IHpVVE?=
 =?us-ascii?Q?ryBf68QRW1AbsDTS17TDW8KKtKs5yE9TJfusY3rVBeMK8Jj6T/mJ+LEaFGlF?=
 =?us-ascii?Q?9CSn7yZiG0raLrKymgio+n7Qdn+Hmjf7xG0dnt1OwwWMI5rxbQztBw8u7N62?=
 =?us-ascii?Q?aGaUn4BNxyUFLWFWEk59WsBbuxHUDaqUlsmY4t8ARYsTMQ9GbSY8D7gF06MM?=
 =?us-ascii?Q?arfx6LnVP1r9QxabCxSyBF5ZcEnGD4cjUQh+AgUcoisd+zxSCXdmzGQyJosa?=
 =?us-ascii?Q?qqvURGGG/64aY8MCpyMtTJVT1q+VGM1XBlFeFqPBwlVczcS7PcsDi9W7efdS?=
 =?us-ascii?Q?nBuiEDBMo8QI8MTUiBcIkGQTFq73nkDtVzueH9Vce7hq+tSdEaYxC/chP6Tu?=
 =?us-ascii?Q?yA7PzGRlDkzi9GyVmnGxl+4wFoHZR51x1Ia4+dDAlTnjKKFcu3tGThUEJz7N?=
 =?us-ascii?Q?SJKIlt/DakM9s4mwTVmwDHYnHUyaxHFFd+qZ69sRMSM/rA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?APmaVaSGRQqj05LZhmku0NiWuGRbRBcIroB/cA2FgUTkXJkb2xoRfdVnphC0?=
 =?us-ascii?Q?KYp0CdaUjYyYloYiO2KfIZqWC/6MJjppym9QpLiKwRxMhyN4kjKgCNfEO3og?=
 =?us-ascii?Q?tkDOih+S95vy8Q6oLvXOYbKjQ1WaciR1MxQFUTGh2O85dsJsph5qjrk/Rsyj?=
 =?us-ascii?Q?Ndr4hrmd7TBMmhKIC7FmK0+wWp+GvEjLkiKEQSUwpdUP+UikCGeWZHGb4cdG?=
 =?us-ascii?Q?v6GabsDhk6yt0IMa7wNPzNagZzwP9aim0pfsvrTIEQmHsyRxHOP8fUz8UOHV?=
 =?us-ascii?Q?1OvMUmWOXzig+bpMnmyM7MHAJgzMXpS7/VfZaM3y9lrRuLdduS+6PGjDBLlK?=
 =?us-ascii?Q?ee77j53rcKfuhy9UH3MjJtZSD3ye7pN+/yfMhexavX9a8OdMHUdboqCqqPUg?=
 =?us-ascii?Q?w2Vz+6zH99lIJbrswNweby2RT8KM4U/edp4OiBgVcxCDiT+BVNdrE9mauHhE?=
 =?us-ascii?Q?78iKkSRPW9H2jxbUQz7xQr7Wh8eye4iW00HEWxVy7p6iaTnPPzdXKaHjV7la?=
 =?us-ascii?Q?QvbWO9ZvmvmdPBIMkqyNhWL6pbQ0pHec+c6//Zx4Asd6Tynei/zNyVqal9Hw?=
 =?us-ascii?Q?DAo7JO/UYxTFRaI4/NLlEcuIehpJXY44np+ki7XmSNMsvSBzDvCGp5toemYU?=
 =?us-ascii?Q?eT+fUA2lBwMuUJd+FijeeXqgcVZSgcUrt+1uJ6D+46zWCrGY+ram2Zi7AhLI?=
 =?us-ascii?Q?6OIlsThnQDBN7d8LtHI8VmmxMErgXCu/WadYNfUA/IxcsvK8AFM0Sg7Zgnqb?=
 =?us-ascii?Q?FpovuAz439h++jx1kZMwF1LrmQRGvQSgpgI+xwQMXCTQsg55aEHMhnMLelGl?=
 =?us-ascii?Q?OvDIjx/yAlpenmCGsDg/6A7nj3yjmVzVfBYA4UOxd9Cu0p2UwSaHoh5ifJET?=
 =?us-ascii?Q?i3YWVRGFyGmFHcaWZaQ67i/IQGGbS2yh2W5PMyKBcHbBUauHvyG8KnPDMMmV?=
 =?us-ascii?Q?jHR2Ls6AwGu6ABteJa38BlxIxPYnCqq45ZJ3RPP2OqZnJ5Av+Gz3ncA8+LhA?=
 =?us-ascii?Q?dbENxNUCM+wbFsClOCTskJ6rzFeFh0fj8Yq0dtQ4kqJ3yaC6mh4OdRMywoPm?=
 =?us-ascii?Q?pvvG+MAELRjXrtzwD777ZrBwz5hEovoqiFsrNXwn6aang2gNN/JiVGoUQCH8?=
 =?us-ascii?Q?BSSPS8E/bg9CA5XDLFzQLSZ4zPniwAt1wBvzz0X3Acc4PaQbgUGo7rC5/KEm?=
 =?us-ascii?Q?j+Jhmm30iw/6A9We/1lNnKfuvdqF8K1wSgfzdEcpJ5ND3U3LNia/I2PTsM/T?=
 =?us-ascii?Q?PxyMbGZPQCPheyC7/HBv+1+RI+fPbzx1RxXUMeC8Vj6B0O3V6zVp3PfBAJRd?=
 =?us-ascii?Q?/7/iHv0LGQHuqnLpXuAkl0ugo7zAh9xD4bmeuNZdYoWQEXfl/quW9XnK2Psv?=
 =?us-ascii?Q?pcnahghWRXNHBQtDq0wSmTiuB/LlGEM9wl1xi4kalx3RSfjkiOjjJFImT9jL?=
 =?us-ascii?Q?sQGD3s4DYRQm937ZWXmnHJXOnUBRqWPFE4fWa8jb1d8Y8h31Z1lIie3NYiHV?=
 =?us-ascii?Q?4YDOT8UIhsU07ozu/BzdQuej7awFNWjMMjLXDFHDwouYPFSbB9LZttFKWPdo?=
 =?us-ascii?Q?j6+iq+FdjP/dlDKD9ZcphjkQSh9sr0YL2O67zR6Bnsv/E50vQiqWguQaVeK/?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df7ff442-b41e-4816-5b09-08dd4f107dda
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 05:04:00.7183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JP5bx5YBjAj2ao4w5SachHJDxQTmh2wTaKGm/+0loamJKBZBEJu1i6LSTIsioSJGA/D2ZbuUddtpCbq6wUbZpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6031
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]PREEMPT_KASAN" on:

commit: 143d683070d6cedc02b6406f98f21bd5ffed8a70 ("[PATCH v5 1/2] hwmon: add GPD devices sensor driver")
url: https://github.com/intel-lab-lkp/linux/commits/Cryolitia-PukNgae-via-B4-Relay/hwmon-add-GPD-devices-sensor-driver/20250211-150418
patch link: https://lore.kernel.org/all/20250211-gpd_fan-v5-1-608f4255f0e1@gmail.com/
patch subject: [PATCH v5 1/2] hwmon: add GPD devices sensor driver

in testcase: boot

config: x86_64-randconfig-004-20250215
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------------------------------------+-------+------------+
|                                                                                      | v6.13 | 143d683070 |
+--------------------------------------------------------------------------------------+-------+------------+
| boot_successes                                                                       | 12    | 0          |
| boot_failures                                                                        | 0     | 12         |
| Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]PREEMPT_KASAN | 0     | 12         |
| KASAN:null-ptr-deref_in_range[#-#]                                                   | 0     | 12         |
| RIP:gpd_fan_init                                                                     | 0     | 12         |
| Kernel_panic-not_syncing:Fatal_exception                                             | 0     | 12         |
+--------------------------------------------------------------------------------------+-------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202502171113.9faaae-lkp@intel.com


[   24.206559][    T1] pps_ldisc: PPS line discipline registered
[   24.221748][    T1] Driver for 1-wire Dallas network protocol.
[   24.228882][    T1] usbcore: registered new interface driver DS9490R
[   24.241341][    T1] applesmc: supported laptop not found!
[   24.245457][    T1] applesmc: driver init failed (ret=-19)!
[   24.253994][    T1] Oops: general protection fault, probably for non-canonical address 0xdffffc000000002a: 0000 [#1] PREEMPT KASAN
[   24.255395][    T1] KASAN: null-ptr-deref in range [0x0000000000000150-0x0000000000000157]
[   24.255395][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper Tainted: G                T  6.13.0-00001-g143d683070d6 #1
[   24.255395][    T1] Tainted: [T]=RANDSTRUCT
[   24.255395][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 24.255395][ T1] RIP: 0010:gpd_fan_init (kbuild/src/consumer/drivers/hwmon/gpd-fan.c:568) 
[ 24.255395][ T1] Code: c5 08 eb b2 48 c7 c7 40 16 90 87 e8 49 ea b6 f9 48 8d b8 50 01 00 00 49 89 c5 b8 ff ff 37 00 48 c1 e0 2a 48 89 fa 48 c1 ea 03 <80> 3c 02 00 74 05 e8 a7 5d e9 f5 4d 8b bd 50 01 00 00 b8 ed ff ff
All code
========
   0:	c5 08 eb             	(bad)
   3:	b2 48                	mov    $0x48,%dl
   5:	c7 c7 40 16 90 87    	mov    $0x87901640,%edi
   b:	e8 49 ea b6 f9       	call   0xfffffffff9b6ea59
  10:	48 8d b8 50 01 00 00 	lea    0x150(%rax),%rdi
  17:	49 89 c5             	mov    %rax,%r13
  1a:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
  1f:	48 c1 e0 2a          	shl    $0x2a,%rax
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)		<-- trapping instruction
  2e:	74 05                	je     0x35
  30:	e8 a7 5d e9 f5       	call   0xfffffffff5e95ddc
  35:	4d 8b bd 50 01 00 00 	mov    0x150(%r13),%r15
  3c:	b8                   	.byte 0xb8
  3d:	ed                   	in     (%dx),%eax
  3e:	ff                   	(bad)
  3f:	ff                   	.byte 0xff

Code starting with the faulting instruction
===========================================
   0:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   4:	74 05                	je     0xb
   6:	e8 a7 5d e9 f5       	call   0xfffffffff5e95db2
   b:	4d 8b bd 50 01 00 00 	mov    0x150(%r13),%r15
  12:	b8                   	.byte 0xb8
  13:	ed                   	in     (%dx),%eax
  14:	ff                   	(bad)
  15:	ff                   	.byte 0xff
[   24.255395][    T1] RSP: 0018:ffffc9000001fcd8 EFLAGS: 00010202
[   24.255395][    T1] RAX: dffffc0000000000 RBX: 1ffff92000003f9c RCX: ffffffff8c800034
[   24.255395][    T1] RDX: 000000000000002a RSI: 0000000000000001 RDI: 0000000000000150
[   24.255395][    T1] RBP: ffffc9000001fd88 R08: 0000000e56910ec6 R09: 0000000e56910ec6
[   24.255395][    T1] R10: fffffbfff130e5ad R11: ffffffff8261d8e0 R12: ffffc9000001fd60
[   24.255395][    T1] R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000000
[   24.255395][    T1] FS:  0000000000000000(0000) GS:ffffffff8890a000(0000) knlGS:0000000000000000
[   24.255395][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.255395][    T1] CR2: 00007fd5127dc480 CR3: 00000000088d4000 CR4: 00000000000406b0
[   24.255395][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   24.255395][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   24.255395][    T1] Call Trace:
[   24.255395][    T1]  <TASK>
[ 24.255395][ T1] ? show_regs (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:479) 
[ 24.255395][ T1] ? __die_body (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:421) 
[ 24.255395][ T1] ? die_addr (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:455) 
[ 24.255395][ T1] ? exc_general_protection (kbuild/src/consumer/arch/x86/kernel/traps.c:751 kbuild/src/consumer/arch/x86/kernel/traps.c:693) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250217/202502171113.9faaae-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



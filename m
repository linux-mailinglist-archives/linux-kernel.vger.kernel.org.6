Return-Path: <linux-kernel+bounces-208842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB499029D0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58051C230F9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A74446B4;
	Mon, 10 Jun 2024 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z52vC9jF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AA018C36
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050577; cv=fail; b=pdKNrgN380CX+yQ3STzBefF97wNhWzEO7229jM88u3Rvr6QV1y/Ncybav76I0Kowt0Cd20Fq7x0vAMoN93hdnM78BiODrkqdbV3BmbUa3JJ3p5UZMsbLJQGoscpk4MTAvAGbDbb1QXIdqwKVzmemVlFzsepJMAHl87SxuhP6ujk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050577; c=relaxed/simple;
	bh=XSZDZ+V/jW8PuY4VGx/NSle+vonB5xyb5SmF93jbxR8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HSgXUhSf/oKxqgbohH0nhpw7xpJmgBy+mP5UKX01wcyWXarbMbqmAWtcFhvpwzc6Zmj/QRBydpLk+KUc+8bGhn4VjpNoPvobQNrGxIYCU5HRSyaXzP5/N1qKM7+/CgR6cZJBwdTZKod+WZK96YpZ8FPXGNM/AVcTL+AncHhQErA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z52vC9jF; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718050574; x=1749586574;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=XSZDZ+V/jW8PuY4VGx/NSle+vonB5xyb5SmF93jbxR8=;
  b=Z52vC9jFwpswkzF0RlkPvrCONuhpnPAy9h6HFM6ilf8NWNs3C3nAB2Gg
   2YUF9JsPcBHzv/GpFRU67frCxzkP0k3/69H2zzMOGaWmhF0UUsUPXM6Fr
   YmTDq8hjKrcAN90sRiBNJxI2PRVyE2Xj3wv3S+zFSRFh1SgyfXw/XenNe
   aOevg4RsKIcc/xmpQej0x+RUrKONjhHoQly1uMQJl2oonQ6Wdd3hFIbzp
   lfrLfu3MIM8Qmi28djM8Snkhk0J1UiwGrlyCgdkafofr2BQL9QLcQsWd8
   CMU1E3fenEirMrs96+avQJIui4MclhSeFLApzV8sM8IC87dqbgswoa+aW
   g==;
X-CSE-ConnectionGUID: I2HoesKSRBeWfbltoaUfGw==
X-CSE-MsgGUID: EKZiJYtaQpewXPJa1DXP9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18561302"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="18561302"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 13:16:14 -0700
X-CSE-ConnectionGUID: hk99vTkJQ+2ERSd2vOpvBw==
X-CSE-MsgGUID: vNclPZa5QLqCrX7GQr9eag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39168621"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jun 2024 13:16:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 13:16:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 13:16:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 13:16:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGY7JXMDPCd+2zrWyfq4vhIUMnj1sWTjDIqy18nYoR4bVNm4Mm6m+V84yetdmsB3z44RCSp/NOZgaxF5/kVEE7niNqLrVKbaEU8A9CL2hiNA8Up0It4WlGKTNEyCVmld0n2R+U6Hq+7B3m6eKcKU3PB0k7PvbilVB9Hf0UVhLfn55BEky9tOy6YC1m0B35tHSBHWIap9RJRLsT1RWbL70B2OuZ3luy4Ufqd0fE/TJT3eB+NRQo8azcxMSxjhpZTQ0esnp7A0HhSmyBC705VBvNKmwXtVM4JCSXEE+OnHjTLtzh7TMkKWkSw6dtALeYlKedUiWvzKflOAKX10eu10bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6w8fycQtZw05jkTkJJQ4KAN1yVUeFtN27LO1//jh3h8=;
 b=VpH64oiI1Kn4PgOkGPNLIOGbH5g1R8GmYgUM0SLtv9nDe0S4GCI+opUbfBU4As/Ttpi8zmOq7tWao0pcmdQ+owQGDTz4LS1gS3nXgePVZM3X8hCHCxshg7ZN1I2XLTQnyHbxdcHeQHd/w5fU5Qtsj/gH3RzzamKeILOQBk8Pckx9I044M3L6k4v/FfE09KS+Tqa3uqGI/SsO2tDkwrXhWX4lhTMLBWXz40gos5XUqkHmtZlsZYntVch5WSJU+y+NeJ16eG4FGVxKcb4AmZ4907sJeO3r+arJxR2+QEE4w+Jl1I3ry5HS8lj57u/WqLn7q1RMVHXvQbmku1IsG5c5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2854.namprd11.prod.outlook.com (2603:10b6:a02:c9::12)
 by DS0PR11MB6445.namprd11.prod.outlook.com (2603:10b6:8:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 20:16:10 +0000
Received: from BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42]) by BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42%5]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 20:16:10 +0000
Date: Mon, 10 Jun 2024 16:16:08 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: =?iso-8859-1?Q?Jos=E9?= Roberto de Souza <jose.souza@intel.com>
CC: <linux-kernel@vger.kernel.org>, <intel-xe@lists.freedesktop.org>, "Mukesh
 Ojha" <quic_mojha@quicinc.com>, Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>
Subject: Re: [PATCH v5 1/2] devcoredump: Add dev_coredumpm_timeout()
Message-ID: <ZmdfCDCQSZIsAWOQ@intel.com>
References: <20240610161133.156566-1-jose.souza@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610161133.156566-1-jose.souza@intel.com>
X-ClientProxiedBy: BYAPR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::24) To BYAPR11MB2854.namprd11.prod.outlook.com
 (2603:10b6:a02:c9::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2854:EE_|DS0PR11MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea00fe7-c912-4442-b61d-08dc898a2b60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?69Rs8P8AkPPbZiHZzbkDB7YjE9C56bh0TTk5u6sDxO9HxXVj+8uVhuUdfX?=
 =?iso-8859-1?Q?qmej19VRcDMfLdc8BSdGd6nz6N+3JR362JYeHqcEGmuObTgs/B7vt60NMm?=
 =?iso-8859-1?Q?ZqatuDe1PD6QmhCo2F12WH1nZ3skoc7bUHNjyomv3htDKwcoj6QKYezYsJ?=
 =?iso-8859-1?Q?8OfqKIr9dmAPo2/qcePF0Tls2CYOkJ7UmbNxQInN32cPwGBzvxk6nlrIpx?=
 =?iso-8859-1?Q?f5UEUkzbwcruKTKGfXu71G0+D+br9Th3fbkgirW6BXQh6xcDwpNS4J4h0U?=
 =?iso-8859-1?Q?scnhkZhQKfkvbdj8yM6XCD09KAq0VOg/vvUNRMic/N6U7dHYw9HsV2jRi4?=
 =?iso-8859-1?Q?I6z8WlH1tdmQM32ctpKXmhJODtEnC/irNejggTsakFL94Ibj9dTe4FhYVX?=
 =?iso-8859-1?Q?VhUMoTUXIfeyM2p1BukuwkUxcX3HCIOMP7DUrI7WkiSFNnxB9zghTpVQd9?=
 =?iso-8859-1?Q?NxOJdxe7MP4aataJgJqfmUBlQ0AYiwO4RUgWaN90Ut4w2ez/DF5bp+hzMl?=
 =?iso-8859-1?Q?DZwJTBLNN5Bm6e47u9LfWfdWe8HP2IytVVtfaxYhGW3Oyp0on//bmcs7mC?=
 =?iso-8859-1?Q?93aAiADIbaUUdPR4cmkWQbYbkrQoCUus7GRJbhMqRIbUhdK/E2q/Dd3UOk?=
 =?iso-8859-1?Q?tPOEowUeAlMR61XG55HFKtt0mhEwhPVoghCs252UJUIWi+fT+CyAIvIJvZ?=
 =?iso-8859-1?Q?fAUsPYtun/urQBgeLXTsmKdMG5Vt50J/lCZfOh17tFp6OcMg4Exqg13fRf?=
 =?iso-8859-1?Q?ONXeG8Yg3RGO1RIOLGJu8/qpPL0vTuLMdV7AxZe0tLAFr/gu86O0sRoyMF?=
 =?iso-8859-1?Q?Wg9onPbm0SWhHHeQE6YIP4mq6yvlKtwNTI+5iL/9pqPF/ylDwwadaA7t98?=
 =?iso-8859-1?Q?Loyl1z7CSxtZwYjS5m2wx+c7K7COoId4aoG1HmlpnGhpWz935Bg4L8JPAA?=
 =?iso-8859-1?Q?YOUHeZ3J6iWVqUtLsxonGNvKdFWmDCMB7iqdR/7rJ4jOI+wtIXjrATfCHo?=
 =?iso-8859-1?Q?C3frBY4kWc2IhUwGkh5BsOnSD0oz23e20yuwXUE3zw4kkAs687c3cuziMh?=
 =?iso-8859-1?Q?IbKPPduR9lyg5VQcnKF/hQknerw8FZrZEKtDrUudiJKd26nip9EmgcXLrZ?=
 =?iso-8859-1?Q?B1skORgrWlQ+9pVBS/Z8wEwgH3RgLOWRxlfOclQ/0kvHmTgeSh+sPe6nao?=
 =?iso-8859-1?Q?A9ZTczQGZc0zg1U1is1QiMUBCDBnMaE79dxHD7Zh+bGGRHTm8IB+WfIzA9?=
 =?iso-8859-1?Q?a1HtSKNYEcgrJGI8m3gRm9BQnS5PgGKGaZC/p/SDE8r5GXS64SDrdgqnyL?=
 =?iso-8859-1?Q?O4Z6iIT3y/tigMcY6x4AnESRiywWlQ/iEuIIrXrlchFY3qs9IS0fWGAerX?=
 =?iso-8859-1?Q?tQRw+q+KgC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2854.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QWEYPY//o4XXqsD7KZd24Pl6MEUM0sJ9d3zUPyVAVKs9WZiWbsxfVP1jQw?=
 =?iso-8859-1?Q?dlfgkgmhqC3ZNC7qj4RmpcNNMvcXNG+hHao1GII/mo0CrDMX8qnIKk0cC0?=
 =?iso-8859-1?Q?qxiE71C4LfXb7kxPTO/Prkym9pgU2zBGZW91CumvOiO9Q5KD3PwfqmlC/Y?=
 =?iso-8859-1?Q?0mi0KAKvr5y9aKtDYPmW3otdol3q4hKGF31Pe5vZ5QgiGSxwXLgXdgkaCM?=
 =?iso-8859-1?Q?nqDYGrQ0D1lWCx2Hj5fEJcajylgVVtfHD/0FN+EJx6J4MfPMzyqk9PszcU?=
 =?iso-8859-1?Q?iTw9vcU7KXMvGStuBqT6JHmUoTZkaSACow2jYtV7m0sPvmSamCduff6h/E?=
 =?iso-8859-1?Q?o5L4ITOU14vQCLMZ7qdJCuVq6V/llWd3DuTC+iq+1cSCw9N99gSEbfvEyg?=
 =?iso-8859-1?Q?rbnpeTccq8KULhKHF7fYaIozDTpfxU8mWwCP4Zml449l9oBDoa3i0YhnFM?=
 =?iso-8859-1?Q?ZJaIV2+OoF7v3BacAJrOuJkSaXGyedMx6boJVVrxuftHGB9EW9Rcu1t/v/?=
 =?iso-8859-1?Q?kDBL1q3G24TdV7q8TBxAOAu4Og0boSda56vX7zRmVNBD3sf+6NQ3G9sdKS?=
 =?iso-8859-1?Q?t5fL7IaKNoZlViWZgjV1Pt/OugqzY2RAza9tKQlaqoxFsxJ7UFBxMhguJf?=
 =?iso-8859-1?Q?t8gQ28IeWF5OsIvuQknanVLhIy0tauiEzINFOahfQRvMfOy8qMl7sq/gRu?=
 =?iso-8859-1?Q?vZTO8GMH53BI9dd4ZspGX4HI2NVakgoapJ62lR7fMJiIuYScylsDvXr8zP?=
 =?iso-8859-1?Q?NTIPQOE34bxQDnh5QgjBZ9eN/5sr3MneUqYa1IrfG4rG3jBV6wZHpztx4J?=
 =?iso-8859-1?Q?r9eU8t3Ze0V2l3DwQfothdRgkqve9bdhX6CGhTeGs4hRCVL2qIuhDhB49z?=
 =?iso-8859-1?Q?s+TqBVACWgHzaMRZWETkuJMfMV5TasfF6BP3ZVt4Ji2MCXKRAJUv9wARYM?=
 =?iso-8859-1?Q?mdSNj6OSStkca1dTGQ1ahqBd/k3Musctofpt+tMowqrhMsFk69cabtHFCr?=
 =?iso-8859-1?Q?BL1ZGwkfXh3/qiW9B03NiMyP26JZ/Ekg+KGegTHml7tX58TkRI/MTD4bZw?=
 =?iso-8859-1?Q?agSVVd3RsBTHS4dw0DGtHC8uG4/OoymetDrCYQ7gbGNH3YJI2eshX2pzTq?=
 =?iso-8859-1?Q?TtVSVj0GJKETs4OgMYoGtB0y5B0zzDpMuLZ8EBeVXQrfAMQakrW1df8V3D?=
 =?iso-8859-1?Q?xM8x9M2CnDnACWr7nPED8y87Qe0WyUTodH0gkHr+T5OoET9t4/rGLlzHgC?=
 =?iso-8859-1?Q?W1zyMJZkNd4J/1C8sOI54PhaX2NeB9YT8QVhdXAfcY5yD7JIVOC1/i+eH/?=
 =?iso-8859-1?Q?wtZSWc7G6XToOgP8qv6b6ry5nHkPtKuJ8Ri2zvigkgBDRqwx78KJFVPDDx?=
 =?iso-8859-1?Q?WhGQHxbtYYU/YmTxQIjYLIIY9gufNB3Scx3uunKlvXkh+dR35kaDqsH5Bg?=
 =?iso-8859-1?Q?3533dvZia9ksQ8oSRxPAKbUsVwgXosyLFSp4cO1XE48n4OjocV3By9vZCO?=
 =?iso-8859-1?Q?jwRkTdqFnjI2OAeepK7DGw5iJr3yaep8B2WB8Q02lsxMcqFC/j58u0MvAx?=
 =?iso-8859-1?Q?06Sq5F7Zk4UxhTjRhvdtaGhwxDMkW7NZoNtBGrQshnfB+ZOenZ5JE+qW/B?=
 =?iso-8859-1?Q?zMn+QXifi3H6yRts0k/DuSE9YugHFQhvd/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea00fe7-c912-4442-b61d-08dc898a2b60
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2854.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 20:16:10.8011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/9ZxaLFOlLHhT0JVrwoVikLLgSIHIuT0KQkGehRO4lTTCJrhiZ9PTsnQLthfNxxHNMU+naJE9bK75bWaTXFlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6445
X-OriginatorOrg: intel.com

On Mon, Jun 10, 2024 at 09:11:32AM -0700, José Roberto de Souza wrote:
> Add function to set a custom coredump timeout.
> 
> For Xe driver usage, current 5 minutes timeout may be too short for
> users to search and understand what needs to be done to capture
> coredump to report bugs.
> 
> We have plans to automate(distribute a udev script) it but at the end
> will be up to distros and users to pack it so having a option to
> increase the timeout is a safer option.
> 
> v2:
> - replace dev_coredump_timeout_set() by dev_coredumpm_timeout() (Mukesh)
> 
> v3:
> - make dev_coredumpm() static inline (Johannes)
> 
> v5:
> - rename DEVCOREDUMP_TIMEOUT -> DEVCD_TIMEOUT to avoid redefinition
> in include/net/bluetooth/coredump.h
> 
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> Cc: Mukesh Ojha <quic_mojha@quicinc.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Acked-by: Jonathan Cavitt <jonathan.cavitt@intel.com>

Jonathan, also ack to merge this through drm-next flow?

> Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
> ---
>  drivers/base/devcoredump.c  | 23 ++++++++--------
>  include/linux/devcoredump.h | 54 ++++++++++++++++++++++++++++---------
>  2 files changed, 54 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> index 82aeb09b3d1b5..c795edad1b969 100644
> --- a/drivers/base/devcoredump.c
> +++ b/drivers/base/devcoredump.c
> @@ -18,9 +18,6 @@ static struct class devcd_class;
>  /* global disable flag, for security purposes */
>  static bool devcd_disabled;
>  
> -/* if data isn't read by userspace after 5 minutes then delete it */
> -#define DEVCD_TIMEOUT	(HZ * 60 * 5)
> -
>  struct devcd_entry {
>  	struct device devcd_dev;
>  	void *data;
> @@ -328,7 +325,8 @@ void dev_coredump_put(struct device *dev)
>  EXPORT_SYMBOL_GPL(dev_coredump_put);
>  
>  /**
> - * dev_coredumpm - create device coredump with read/free methods
> + * dev_coredumpm_timeout - create device coredump with read/free methods with a
> + * custom timeout.
>   * @dev: the struct device for the crashed device
>   * @owner: the module that contains the read/free functions, use %THIS_MODULE
>   * @data: data cookie for the @read/@free functions
> @@ -336,17 +334,20 @@ EXPORT_SYMBOL_GPL(dev_coredump_put);
>   * @gfp: allocation flags
>   * @read: function to read from the given buffer
>   * @free: function to free the given buffer
> + * @timeout: time in jiffies to remove coredump
>   *
>   * Creates a new device coredump for the given device. If a previous one hasn't
>   * been read yet, the new coredump is discarded. The data lifetime is determined
>   * by the device coredump framework and when it is no longer needed the @free
>   * function will be called to free the data.
>   */
> -void dev_coredumpm(struct device *dev, struct module *owner,
> -		   void *data, size_t datalen, gfp_t gfp,
> -		   ssize_t (*read)(char *buffer, loff_t offset, size_t count,
> -				   void *data, size_t datalen),
> -		   void (*free)(void *data))
> +void dev_coredumpm_timeout(struct device *dev, struct module *owner,
> +			   void *data, size_t datalen, gfp_t gfp,
> +			   ssize_t (*read)(char *buffer, loff_t offset,
> +					   size_t count, void *data,
> +					   size_t datalen),
> +			   void (*free)(void *data),
> +			   unsigned long timeout)
>  {
>  	static atomic_t devcd_count = ATOMIC_INIT(0);
>  	struct devcd_entry *devcd;
> @@ -403,7 +404,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>  	dev_set_uevent_suppress(&devcd->devcd_dev, false);
>  	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
>  	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
> -	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
> +	schedule_delayed_work(&devcd->del_wk, timeout);
>  	mutex_unlock(&devcd->mutex);
>  	return;
>   put_device:
> @@ -414,7 +415,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>   free:
>  	free(data);
>  }
> -EXPORT_SYMBOL_GPL(dev_coredumpm);
> +EXPORT_SYMBOL_GPL(dev_coredumpm_timeout);
>  
>  /**
>   * dev_coredumpsg - create device coredump that uses scatterlist as data
> diff --git a/include/linux/devcoredump.h b/include/linux/devcoredump.h
> index c8f7eb6cc1915..e3de1e545a4a5 100644
> --- a/include/linux/devcoredump.h
> +++ b/include/linux/devcoredump.h
> @@ -12,6 +12,9 @@
>  #include <linux/scatterlist.h>
>  #include <linux/slab.h>
>  
> +/* if data isn't read by userspace after 5 minutes then delete it */
> +#define DEVCD_TIMEOUT	(HZ * 60 * 5)
> +
>  /*
>   * _devcd_free_sgtable - free all the memory of the given scatterlist table
>   * (i.e. both pages and scatterlist instances)
> @@ -50,16 +53,17 @@ static inline void _devcd_free_sgtable(struct scatterlist *table)
>  	kfree(delete_iter);
>  }
>  
> -
>  #ifdef CONFIG_DEV_COREDUMP
>  void dev_coredumpv(struct device *dev, void *data, size_t datalen,
>  		   gfp_t gfp);
>  
> -void dev_coredumpm(struct device *dev, struct module *owner,
> -		   void *data, size_t datalen, gfp_t gfp,
> -		   ssize_t (*read)(char *buffer, loff_t offset, size_t count,
> -				   void *data, size_t datalen),
> -		   void (*free)(void *data));
> +void dev_coredumpm_timeout(struct device *dev, struct module *owner,
> +			   void *data, size_t datalen, gfp_t gfp,
> +			   ssize_t (*read)(char *buffer, loff_t offset,
> +					   size_t count, void *data,
> +					   size_t datalen),
> +			   void (*free)(void *data),
> +			   unsigned long timeout);
>  
>  void dev_coredumpsg(struct device *dev, struct scatterlist *table,
>  		    size_t datalen, gfp_t gfp);
> @@ -72,12 +76,13 @@ static inline void dev_coredumpv(struct device *dev, void *data,
>  	vfree(data);
>  }
>  
> -static inline void
> -dev_coredumpm(struct device *dev, struct module *owner,
> -	      void *data, size_t datalen, gfp_t gfp,
> -	      ssize_t (*read)(char *buffer, loff_t offset, size_t count,
> -			      void *data, size_t datalen),
> -	      void (*free)(void *data))
> +void dev_coredumpm_timeout(struct device *dev, struct module *owner,
> +			   void *data, size_t datalen, gfp_t gfp,
> +			   ssize_t (*read)(char *buffer, loff_t offset,
> +					   size_t count, void *data,
> +					   size_t datalen),
> +			   void (*free)(void *data),
> +			   unsigned long timeout)
>  {
>  	free(data);
>  }
> @@ -92,4 +97,29 @@ static inline void dev_coredump_put(struct device *dev)
>  }
>  #endif /* CONFIG_DEV_COREDUMP */
>  
> +/**
> + * dev_coredumpm - create device coredump with read/free methods
> + * @dev: the struct device for the crashed device
> + * @owner: the module that contains the read/free functions, use %THIS_MODULE
> + * @data: data cookie for the @read/@free functions
> + * @datalen: length of the data
> + * @gfp: allocation flags
> + * @read: function to read from the given buffer
> + * @free: function to free the given buffer
> + *
> + * Creates a new device coredump for the given device. If a previous one hasn't
> + * been read yet, the new coredump is discarded. The data lifetime is determined
> + * by the device coredump framework and when it is no longer needed the @free
> + * function will be called to free the data.
> + */
> +static inline void dev_coredumpm(struct device *dev, struct module *owner,
> +				 void *data, size_t datalen, gfp_t gfp,
> +				 ssize_t (*read)(char *buffer, loff_t offset, size_t count,
> +						 void *data, size_t datalen),
> +				void (*free)(void *data))
> +{
> +	dev_coredumpm_timeout(dev, owner, data, datalen, gfp, read, free,
> +			      DEVCD_TIMEOUT);
> +}
> +
>  #endif /* __DEVCOREDUMP_H */
> -- 
> 2.45.2
> 


Return-Path: <linux-kernel+bounces-395654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88309BC11C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD4A28287D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F37D1FDF8A;
	Mon,  4 Nov 2024 22:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AxAMzMU2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CABA17583
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 22:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730761004; cv=fail; b=iYGccKB+CNV3tYC+kery3aXZytzW5xXYG9auqYKDDFQO0wmaS/y0GMT/gtBO/+d/bns31H4uPNv47ezXoer9wi0KpNF9XerVUq5YRCy3xf44dJ0zdNwndkmYTQ18hfgcn+x79XWZk2yt4Sqe/LiD+2rX1xuzmQ0PbIAw8RpOh5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730761004; c=relaxed/simple;
	bh=D/Rz5TeuVM+eMHHQBJLa6qmHhX+EoRLRP/TlKIjHQec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N+7jEnTG07mYhrq5OKybjDV9z5pg5uoF3tFRX/z+fT2s6PiL6oSe51tZPPLGvzYnxAYtxao7w7lcs43VhPqP93xGMhd6jmWiVvW/MrKriYr66zaJKrw2Eq8nGmCwAZuRGCv7TQ6gzgYmM6IVX6MD+aIttTs3QmnfHpEqAqPpiyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AxAMzMU2; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730761003; x=1762297003;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D/Rz5TeuVM+eMHHQBJLa6qmHhX+EoRLRP/TlKIjHQec=;
  b=AxAMzMU28PT5atrkX7mB+SH9rm7swF+l09piaJTiAEaddCmRnBHCec+S
   2MH0NorZXBSaUg+0Mj/5D1PghydpMoVTSuPwoc4v1kgP5LE7rQV9kty+y
   hMC6CNnKooYoG6FfF52qA5XNHXZsR1serY9w50AQsy0agu+CzG1vvSu3C
   TcS0vguHgZizC+ylUkiKYVgaL11qBQP7HmIsEXeKsa2VkLsy88FC39YSe
   sNQWoe+bZrNm5FlVmYzkkQH59NUdXcSCou2AyzKbcZcqq5zXTjhHqmEfC
   vUatI0IxwkKUH97ofne/zj0Mck62GhsB5coBrrlXYwERy66Cyv3G8R8ls
   w==;
X-CSE-ConnectionGUID: tRBi9drJQYqCV064TNM69w==
X-CSE-MsgGUID: MHmG9N/oTAC4culTKtydDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="33319827"
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="33319827"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 14:56:42 -0800
X-CSE-ConnectionGUID: pElyx1JrQ/SnswVTEzITUQ==
X-CSE-MsgGUID: vulnPYTjRaug8yCR/sdIgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="88312760"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 14:56:42 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 14:56:41 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 14:56:41 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 14:56:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lipLpqVtnqwGfcHjDqjVd6NnAjpIKREk7Gz8lx2299forRakPQbs5HYTm/OPhUPWSKxvQc0OwlT0SMkD9N+7ol+AquB23bIXwMNXDAiJWxMldu7ppZ99viZxT/1jVYHwlP0Z7AVD6EUaipC2BLeEolx/Ko5CfxDYD4iZ4sVJKjtK9fACx1nKqOiFzfuKak3F5rt6AeqmGZFoCmtnHt7j72tOqJUMgcO3Pvs1uhZhHczgqxsztqwkb5L3xy6twkfv8kXkySY84DBLm8LMLLjGwHXkQ0PjAPQ8VEzMTu6lYX4WANPIQve6UmRjviu8yJSjzjZHLaRheWDwhN2Og3MlzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/Rz5TeuVM+eMHHQBJLa6qmHhX+EoRLRP/TlKIjHQec=;
 b=Pmq+qcpPGFFfDWxHS2uCYqrQ/hXnpDGXpqS5O7OaS+QjA60ZmJe4TlN+a72pKxp5T6FOJH8LAa0Ep+2IxYpmlpVHG9VwC7oOnCr62jXQA4ZkCVKodRVr/Fte6KkhL+oOc2xCRKCvlPTMywRMYJQI/HnOsW80rmOP/+WhanCJ1xuoZIf1le+nIxX/hCtSZ70ijf+ukaibETI0SZxfVWRiWEXMb64Xer4oHRHx89vx2vja5O0Q9PzwLQfDA0rIKlqX63GZGYJr07lNmVoRmhOfti+Ia3QjbHIRispGbQC/McUJ/192iNzEVa2aISnmazyQb9x6j1JIFD2o82r9exBY4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB6783.namprd11.prod.outlook.com (2603:10b6:806:25f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 22:56:33 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%3]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 22:56:32 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Yu, Fenghua" <fenghua.yu@intel.com>, Peter Newman
	<peternewman@google.com>, "Chatre, Reinette" <reinette.chatre@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, "Babu
 Moger" <babu.moger@amd.com>, James Morse <james.morse@arm.com>, "Martin
 Kletzander" <nert.pinx@gmail.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Eranian,
 Stephane" <eranian@google.com>
Subject: RE: [PATCH 2/2] x86/resctrl: Don't workqueue local event counter
 reads
Thread-Topic: [PATCH 2/2] x86/resctrl: Don't workqueue local event counter
 reads
Thread-Index: AQHbK6DbACO0R1VGa0C5nUIcf/5WR7KnvKiAgAAEErA=
Date: Mon, 4 Nov 2024 22:56:32 +0000
Message-ID: <SJ1PR11MB608357ED39FA4FA1C85C6DB2FC512@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241031142553.3963058-1-peternewman@google.com>
 <20241031142553.3963058-2-peternewman@google.com>
 <b3a52af9-e298-7baa-19b3-8931d03731d1@intel.com>
In-Reply-To: <b3a52af9-e298-7baa-19b3-8931d03731d1@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB6783:EE_
x-ms-office365-filtering-correlation-id: 3e019e2a-bfa8-48fe-319d-08dcfd23ed6b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cnRITGs3akVublY5U1ltbXp1cWFIb3c5ZXgvK3pkZE9Jc0pEYnVrd0V4bkds?=
 =?utf-8?B?NDVYTXo0TzRXcytreFcwcElkdjdKb0dpc2ZOYWdPYWlWTU9NYXA3ZE1tbWVZ?=
 =?utf-8?B?SDhpQzh2cW9PUWdNSGJhQjU4blc0N2lUOTg0cHhyUEhzOWk2Rk1BdU80aGtF?=
 =?utf-8?B?SHZxNW5ySVc3ZDUxMFo1Mmo3M09GL0IzS2lHZzdLaVY0U3BxWlIwQUgzNmNm?=
 =?utf-8?B?b1pEcVc0U1NjT2JyK2xBeHVNRlNMbjkyVWdFbWZsZXo2c0hDLzY3OGhaOXg5?=
 =?utf-8?B?eTBjV2N6aHFUeXFyckNEbkt1OFZYa0lpRU1scERhb1RLQkRpdGZiVHo1d2Zq?=
 =?utf-8?B?Vy9vK1FzNzhmS1ZXVFU4d2dYbFg5TlFWQXpDTWJ3SEhOOERlU3JWOUtFRDZG?=
 =?utf-8?B?S0xFd1RqaDhJL0xJb0Y1UTF1VGJXakpaY1JZVFZLY1g2VkRoRWd0eEFiN3Bu?=
 =?utf-8?B?dVN1VWJHUVJGTHJ3QnRJME5Wdis0UVFkc3JzdVAvcE5FVVh4U0ZacTA2MXhN?=
 =?utf-8?B?S0ozazhxZXBoaURvT0Vldm45T3Q5OEhEeHBnYlZocDhOWnhaaXo2dUdPUlNu?=
 =?utf-8?B?akdGeDg1UnVlU0VSNlE1cVd4TUk2cFAxMTAySVlRM2o1YWpJQThFQ3c5ajNr?=
 =?utf-8?B?dUpTZFlKc2xSTlRhYU9sd2w5dVZab09BOXdiZzIrTnFiS2ExZDVJRDR6cWw0?=
 =?utf-8?B?TkZSNGQxOGwxRHZ0cUN0cDVteEdKSjFjTVloNndyM1N5YlRJMllsNDZjNjZB?=
 =?utf-8?B?Uzh5TFZKWmNrM2toemNKVlMvbjJscnVKQnBpTVE2T2RMQXJEWDZzdzl2RjBU?=
 =?utf-8?B?cXpRSWJYRG5IUktOMS9Cc0JSa1JVVmVPVGRMZ1luVXFTR0NYM1h4QUJCQVN3?=
 =?utf-8?B?Nk96VHpjYmpmelcyZkJPWWZIQVRsdjRXaWlMaElVUDMzSFViRldjVmhkYTEy?=
 =?utf-8?B?aDFWTzRUVGdNYi91RHN1dUxMTjFuT2dRTFdxYVdSNStBcWRiVk1hYWNnZmNm?=
 =?utf-8?B?VlZnZmJxa3U5UXJuRm5EM0xwM1A3VDE1SG1VL1FGbk9xWEdPLy9zc3RSeGFR?=
 =?utf-8?B?RFZDUWdLYmtub05uZGxOOVhOVGRMYXI3YjBiTFNwMWhkS282dXcwamd1d1A0?=
 =?utf-8?B?cjQwQ21iZVpIM25rT0dYM2xGUGlFZW5JSVhJK2ltOHBEbFlENDB0cjIxSVVi?=
 =?utf-8?B?WithYUNTS1E0TnRmbVhvaVRDWkpTempRdldwQkEveGYweU12LzhxVW4vRW8x?=
 =?utf-8?B?MHR5aFdibnZzNGFKZEY2bjE3elZscGFjeUcwYzErYm9pZENtSTRsRjM3dVZP?=
 =?utf-8?B?cGdMTFB0aTNscHp3dWgyMkJoTURrdUZYb2RQVWsyckpUdnUxU1JZcjlYakVL?=
 =?utf-8?B?V0wrNEs1MkxXTkRNcENQOGgrRTdzTEVMZFNzSG1BY0liM090WWlyNEk1MjdF?=
 =?utf-8?B?MUZiZHd4d2xUQ1F2c3RIQTA0bzNHK1FFcVVLS3l0WFJFR3NMZHd6eXJxbWxa?=
 =?utf-8?B?Nk8yd0ZMU3R3ZzRNM3FPWFU0SkJQSytRMnowMkpxNFE3QW45TnIrSTJydjIy?=
 =?utf-8?B?amtueHFuSzhBVG1wd1ZDZGJSUzdia1RuNU5iZ2NwSDN2dnpMQ1M0MXNTa0Fa?=
 =?utf-8?B?aG0zcTdNalUwTldkQkdlL28xeEFza1I1RGVaQzR6emhMZlJST05YblVSU1Np?=
 =?utf-8?B?eWNma3B4SlNBUXk4dVk1TkdFeUJISFJMNjF0MFhQRFBjQmF1akZsWkEzQWVl?=
 =?utf-8?B?UWprNmFTWElHZTdNSkg3NEFCOU56RkVQQkp0cWt6d0hyODFaL3dHc21jdDZy?=
 =?utf-8?Q?fN27lcWdsVHhFiZaoWHccjNiFbj2MFMRyiR4M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGtGNUFCZU1FeDNwQnhRa0FNdXBza2VoZURiODNyRnFkNzN4MGVtUXNXOEk3?=
 =?utf-8?B?dnVOcGtnUGtzWDR1ZWZpMnlVaXhsUG5CZUwzdjdETzZHcVpBNWNST2dlZzJW?=
 =?utf-8?B?ZUp3TDJDY3lJbEk1b3pYRnY0YTUzNGZpSTBWL0oxQVQxVVpEWFhFNnFnWGJV?=
 =?utf-8?B?TWxZR1VGakowNHV4SWc0MHEwb2VvWVhuNGNBcXdiRWI4ak12WldWZHZYL0xU?=
 =?utf-8?B?Y2l1dWhpRVVXZnpFYk5JY2E5d0xJd1lxMHoxRVlLdUhWOHJLb1c4eTUvYlVI?=
 =?utf-8?B?QU9hYXJuK1pramtvKzlQN09UWEZhK3ArSXFRYUpPMld0OERwM0xLY0xGem1a?=
 =?utf-8?B?QzU0V3hQVVVPenJoWE1rSXhjeFN1QzdmYjZaR1dQd0xoSG5EQm9DWFVwa0I2?=
 =?utf-8?B?TEZtSFZaSlpxbURkRUhISHBodnhDS0FoQXQ3allzc1dqVnZIdjI5TXgvbE1v?=
 =?utf-8?B?T1ZJRVBKUng3TVpRM2s1QjhyQkhuSmo3WmlZV2tTcThaWXNyMnpOY08wSlB6?=
 =?utf-8?B?NTVSWERVTWRuUUhGbURQUTVTLzRjckdPTEduTlY0Qmg0WVZhLzhmQXBnRjQ4?=
 =?utf-8?B?SncvSlZKZnpmcE5uNXZwZldQQzB3Qzh3ckpUUnNramd6bGlJYW1CM1QvdFcz?=
 =?utf-8?B?ZmZTUEx1OXhGNnNoUU9ZMEM2UzdvZmVKcCswYVV3TEt6YVJveHZJWjlKVGoz?=
 =?utf-8?B?NnRCYmNIVGMxdGs1eG9nUXRDTzBJOUx0QnBQbVdLaTQya24xVWxrVjUxLzBN?=
 =?utf-8?B?OHpTeXpRSXdHakZSd2pNMnBNakJqeGlMTnlpTkFzZW9zVzAzSHFhdTd1ZEFO?=
 =?utf-8?B?NUtSVHhSNzVCQmRaa1dERnZxNnRRN1dEdlBmSDdGUlI5UWZMcS8ydktkQVMw?=
 =?utf-8?B?dnA4Zlh1SzV4MUU1QXpScWZ5cTNKSWNSM1VQWFlKMjhQdm4zYXpuYWE3UGg3?=
 =?utf-8?B?YUhqd3VmRWh2VHZGSjdIcGIxcWdpYWtwT3FOMGNHTWd1aDdabmNhYldxd0ZK?=
 =?utf-8?B?WnNCZXlsYjJUL0JIcGFISGNQM25SSjBGdFVmc0Y5VFNVa0Y0TFBSNVFDcDJj?=
 =?utf-8?B?SlNYV0RJcDlQZHZVdHdwRDBNYS9PUTlwV3AxQWlOcnkvTXBkMXJEUnU0YVZB?=
 =?utf-8?B?cXh6Wngvd1VSWStqdVN2bEJJaHlKR3FqS0hpV2RsanVYVmdDUnZ6KzdaTUVj?=
 =?utf-8?B?bVViZGlFVGxKaVNpUXJycmdiUXhtK09QVHRCN2hQNXlrZEV5bC9MNnNncnVW?=
 =?utf-8?B?bURtQ3ZvZDdUZ1ZDWnp5RmRKaStHbzRrczhIUlVWQ2VCMnZFMEZHNGQyRisz?=
 =?utf-8?B?ZUZSelAxTU1zeW93SHdFQVRxMlpKSGtmcWhxdHFYelNmWEVCTVNIMWJtUFEv?=
 =?utf-8?B?bUtDY2FqaE5NZEIyaFJPVTcwZ08zSS90bU1xTThBWFhSSlh5WFlKaWloSG5D?=
 =?utf-8?B?dzloL3g5OUk4aDQrRTJpL0thS1hpNWNDaEFvZmMxcnBlSzZwVldQVk9UU0R6?=
 =?utf-8?B?N1RTVW12bXgzblNvQXpaN2Y4SERMaHFZK1RFQTBIWTNIRUtvOVFVOHVCR2kv?=
 =?utf-8?B?Qm5KSWNoNEdFYVFwL2xLTzIyN3ZIYVVZc0V3YUcyTXdsUjRMN3ZieGFjUXpX?=
 =?utf-8?B?dExpRUJJS3gxazNDbWNmSlE1bnVPazBzQ3Yya2VOU2RZeXd0YlhqTHJsc0RU?=
 =?utf-8?B?UFJhS2wyMlRLWXpqNGMwdUdSOEIxSEtOK2g2Wmppd2pJWXlaQ0VNdUh6MVZJ?=
 =?utf-8?B?Mmo1SVRwVmpIVlBDN2tDQzM3dElkVHhqbi9KS0NuZmZqWVY2K09EY2pjMFFX?=
 =?utf-8?B?ZmlqNVh6YkFIZytJcjB3RWJ5OHFVWDFFcXhzaWppcHUxeExXZWdtTXYrMWc2?=
 =?utf-8?B?eUloQkZEQ3Y2L21ueHp0c01EYkM0VmwvejVpNG1wVzYzbm54Y2dqMmtoNlY2?=
 =?utf-8?B?TmRjTnF1MW1qTnpzaTRKUFBGczF4MVI5NDRTSWxYZEk4L2ZPMkhPWGVLWXp2?=
 =?utf-8?B?NGQ3cFNxNVJlNEtjTnZ5VzNmUWozdkE0SHpheTdiV1lYMzdNRFRwK1Q5SDBY?=
 =?utf-8?B?blBhcHJSa3ZJNDRwcWNka3dRZnVBeGpVcVRodXlHbzZPYWdTYUNJT3dTcHN1?=
 =?utf-8?Q?uzpPcjepXGffHc4dWNIcZIqx3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e019e2a-bfa8-48fe-319d-08dcfd23ed6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 22:56:32.8115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qtJFgkmKvP81tK/24sBChNIxMPsxV/YEr9Ir6kkM1W0W58fdLOfQ9tn7jZtFtkdNYTNWDjkmlzefUdu67wDbIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6783
X-OriginatorOrg: intel.com

PiAgIAljcHUgPSBjcHVtYXNrX2FueV9ob3VzZWtlZXBpbmcoY3B1bWFzaywgUkVTQ1RSTF9QSUNL
X0FOWV9DUFUpOw0KDQpUbyBhIGxhcmdlIGRlZ3JlZSBQZXRlcidzIGlzIHdvcmtpbmcgYXJvdW5k
IGluZWZmaWNpZW5jeSBpbiB0aGlzIGhvdXNla2VlcGluZw0KY2FsbC4NCg0KQ29kZSBtYXkgYmUg
cnVubmluZyBvbiBhIHN1aXRhYmxlIENQVSBmcm9tIHRoZSBkb21haW4gY3B1bWFzaywgYnV0IHRo
aXMNCmNhbGwgd2lsbCB2ZXJ5IGxpa2VseSBwaWNrIHRoZSBmaXJzdCBDUFUgaW4gdGhhdCBtYXNr
LCByYXRoZXIgdGhhbiB0aGUgY3VycmVudCBvbmUuDQoNCkZyb20gdGhhdCBwb2ludCBpdCdzIGFs
bCBkb3duaGlsbCB1bmxlc3MgeW91IGFyZSBsdWNreSBlbm91Z2ggdGhhdCB0aGUgZmlyc3QNCkNQ
VSBpcyBhIHRpY2tfbm9oel9mdWxsX2NwdSgpIG9uZSBhbmQgeW91IHRha2UgdGhlDQoNCglzbXBf
Y2FsbF9mdW5jdGlvbl9hbnkoY3B1bWFzaywgbW9uX2V2ZW50X2NvdW50LCByciwgMSk7DQoNCnBh
dGguIEl0IHNlZW1zIHRoYXQgb24gbWFueSBzeXN0ZW1zIHlvdSdsbCB0YWtlIHRoZQ0KDQoJc21w
X2NhbGxfb25fY3B1KGNwdSwgc21wX21vbl9ldmVudF9jb3VudCwgcnIsIGZhbHNlKTsNCg0KcGF0
aCBhbmQgbWFrZSBhIHBvaW50bGVzcyBJUEkgdG8gZ2V0IHRoZSBkYXRhLg0KDQotVG9ueQ0K


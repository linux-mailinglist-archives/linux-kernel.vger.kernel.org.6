Return-Path: <linux-kernel+bounces-209169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 112FC902E30
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378B41C21F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A81810A1C;
	Tue, 11 Jun 2024 02:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ifS0okyA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFF1AD21
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718071487; cv=fail; b=cEj/P06KsRCpYxWX1JKaJOVDcEAEvv2MthDTxZA27E60qCyT6XsaIZfyFn4J0ayurodQlzNZLXQTMwuKz9W+KxAazEx12Xb9WtJH7a3Mll1h/lCkHGOcLYxg5P4TwK/Zy6CTBG9ywnDFPdBc+ldaLuqqh5sV3bVEHVvsUFA8TAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718071487; c=relaxed/simple;
	bh=fQSy6llC6Bp84BA8tXq0Q0OynTdOJ68728IQJRZ/d4s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EZv0ulErOQ53N3tct2DCeBw67sfIEC41TSp9/WrjDQwYBAMQXF3S8/e5qU1u3TU1+VLWI7a7av4q/SSAPoqdl2gZrcIfjdrEjylcd/NFH3dV11dGzcsND5yVmG9QkAwv7+gWQ2+aitkENrFHOYcPMRJ96PMpLXxWkGjdmcP4ri4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ifS0okyA; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718071486; x=1749607486;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=fQSy6llC6Bp84BA8tXq0Q0OynTdOJ68728IQJRZ/d4s=;
  b=ifS0okyAW40oSylQ6viECvU3nAgkC+8JwjqXCxrPEFwpsQf2yBeKFDRh
   eTL8Ehh5eqpbmpA0XHN0H9/I3T0Ds8dzUO6QKPZh5PrcwtqllSO66oycQ
   2nNwH3xqbwCQxeR7u8OlRaI/RJ1akw9aUT2MCve+2eQHDkrwKLQFsKr7D
   P+Lh0b9ExKmzGxyh4L875TC+AQPEv3F6Fpo41zmBgOw3KRI86CcPxHtsn
   uWAt0q9mSNaiH7H6bqcUWH8OPxmPADOOP2TaiggY/UgcNRRSzMA5DDfB3
   2/AuYtb2dhUJVst7GQNm0tBE/vtObfhUdpb8nAAVk7kOOl312Sx9WOpHF
   g==;
X-CSE-ConnectionGUID: lI8yeZk3RBqbH2WfNFAoDA==
X-CSE-MsgGUID: aN4sVhtHTIu44pZwmy4E+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="40160427"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="40160427"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 19:04:45 -0700
X-CSE-ConnectionGUID: 49O7dlPIRiu0xMRFuC4Vwg==
X-CSE-MsgGUID: AL7SzU7OTCuFH3C5xXSgbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43825657"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jun 2024 19:04:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 19:04:44 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 19:04:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 19:04:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 19:04:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Osp4179BtvQksqnX8M6ND1iVo2bbFY1WxZwlspSMvjR6kYrt1bEMnX5aCFJymv9B0m5aZquB/apw8KgxAdJIhAZlc+eSPK5oFmsou7+R5vUdqQOp6RilVmbO6ImRXYbgeSvQ0hMEmk2wXHQy/QqfN/OXxsy8YXyWX4prFrZaqJELVkmeHJXtctvq0Y4RtE/JDIzADycbUU+ER/zAUeXOuzcx5TELuuw0z2Vsnjqny8Eevh9txuGchprI4xcAKNmuKUmWKACCRJxdj2RU2gdCuOwA7m7MGCso7rewXHF/iYRSvv5q2et69uG9R4i+OL4BIQmzmEBD96V8aRQ7FPMHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTZl4SEzg6IXK/LL0oNGifSKNpaaK8NHlx3IVJAYZM4=;
 b=mhZ+OYzqH2F7Zg6TSxCzaHwUbGYqHd8MVgHfsvItRJqCVGk3gcQ7arKSXiLzS/eTOZomeizZ29KY+7Cu5BjlOQ6Rgh+6Rnf+qqfFvesd/D5Uvx6xB8No1IFw3Ww9eI+HkKSECoqIkfoV7hNtxyaGfamY1/Fk7evNbsk3sanxIcSuspW8eiWXzqJ/EKjdZpCn+6Zq8SlnjsvvD3swA8ozFroAKFf+LKboVs/cOzLMovCk8vJ6qN/Rz+cuxR3U7skjBHJTyhlM4azojxmKPnvDl1BQgHjalxRnIE4WV6AQG6QoSDtzT7u/U3RiCi2pWQsfVRoxGS3knWT0vNpPYkXAkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SA1PR11MB6944.namprd11.prod.outlook.com (2603:10b6:806:2bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 02:04:21 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%6]) with mapi id 15.20.7633.021; Tue, 11 Jun 2024
 02:04:20 +0000
Date: Tue, 11 Jun 2024 10:03:21 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <linux-kernel@vger.kernel.org>,
	Xiangfei Ma <xiangfeix.ma@intel.com>
Subject: Re: [PATCH 1/2] nVMX: Ensure host's PAT is loaded at the end of all
 VMX tests
Message-ID: <Zmewac7teXzOs5i2@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20240605224527.2907272-1-seanjc@google.com>
 <20240605224527.2907272-2-seanjc@google.com>
 <ZmerKzEHlIwne5ka@yzhao56-desk.sh.intel.com>
 <ZmesywdpFG3qDIkZ@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZmesywdpFG3qDIkZ@google.com>
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SA1PR11MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: a07e89e6-20a4-4536-0867-08dc89bacebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JJdQRI2+OHdQGgq8cOYMJ9ATRmrC0OFce6mbHnVVk8Eo/ski9rc00Cevphp+?=
 =?us-ascii?Q?DZFJyxheFi3+spXy6qMaU6XA5/S89OR8g7lJtDDRtKWvck0llWGyB+kKTG4S?=
 =?us-ascii?Q?CV9C5vlCF/tQOpyD7jRbzO7BrJUye5OUmz1urKP4UpnalJtWXQ1LSsJM2i4c?=
 =?us-ascii?Q?J5gEwFNC/Emh/JEkmtcRqr2kYkXwQg+DTqJ9mwheVxap3f1tFzTP1JwCUBzj?=
 =?us-ascii?Q?JbXNWj96VoKU03ITBzESl+gb4q5Wa/bCyhN0LaXMTI6l+Wgi7IlC3eOECVvG?=
 =?us-ascii?Q?M3Xh5XqhWbf+ItvHmC+dRIP57Qs0dCOhnPEc7/JMWwCM3KL2mS0kNPcqeeTH?=
 =?us-ascii?Q?kVchsVjfCGyNHx8DobKsbvPl7/hIDudZQ6alyru1kvRkfotx/dBLkK/FopED?=
 =?us-ascii?Q?ow3UiNRO707U0c9GF2JBv4YU4seKB4diwqMkYV4LBx6U1uBJL4utBF3odDSk?=
 =?us-ascii?Q?Vk5eRueE8+Z0ZzIywdPQ1qIm3qOBDwbBzqsPX+l5sXxlNKHZDbZ2PZ1A7JQ1?=
 =?us-ascii?Q?ozE3Kpe9vlem73ABdaQOYuEoCO7iEc7uyXJFFimmze/o57WwFcBgq6BLwhYR?=
 =?us-ascii?Q?MJg7txXQkvACuUq541N0xSXQwMTjkE/Ah3jSKdvsvJK+LhsTU0J8oDw3YaHN?=
 =?us-ascii?Q?As7oFyfkQNA4AfOSbyZt+22TtM0DP+EuBMcArZQdIXNVRpIxa0CRQlf+EDqE?=
 =?us-ascii?Q?cwM6kJb0H0lYpQESeMFcVBEZOCOgQSEumjpVSkaQ4TEzSNnLd5bXeD91zGWR?=
 =?us-ascii?Q?RE5wsX4ErNLLQV0zNYrJvv1uMEFBfY8d7Swys+COJgDYWpIhCQEXF6y9wNr8?=
 =?us-ascii?Q?zpjlPTplQmbXVdnx3pimyeEf3T+vVNynCMoQfSDIMzPrxQ86jN0ioZRvrtPW?=
 =?us-ascii?Q?f/hri3GW51So37JZv5TCmXfVCZVqj8OypoXQ4CuMdWXgLwAjMev0OaHOn7vs?=
 =?us-ascii?Q?yE3FChMpJ1upKiCCl8uxP93ffnzYwaZog81PAFdKan4WZnOjUDFHHRhiO7qU?=
 =?us-ascii?Q?x2KNzsDHxYSTHkMFElKAKrDA0FeraKwAoMn2Q8tMi5F4rRWusGYMicS5UqHo?=
 =?us-ascii?Q?FgBqXyG8Tbp8PqY1KtGyz1EC5HYTyNVOwFFkfhVxfd/1tvRwoY6fsfaqoLZC?=
 =?us-ascii?Q?A7cYSMkx9Eswj644GZNCSx0aBYOetoGV/v+lR3tInQ5sKHuLWwwffse/qX9M?=
 =?us-ascii?Q?xoxb/lYbc8gRpvz8x59k6LF+sWnEXEYXpec2UskHCEDHdcFqOi7EDh5QI6Uz?=
 =?us-ascii?Q?FxBbv9R8soWJCMKHAVJNOZS+vWnXAKaug8D2rcRym5+UAKsWFWTaLOJg8NGl?=
 =?us-ascii?Q?wF0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QvVDlUdyp1IG/AqG62QDDrWfoiMyUo/F6INdHDS0pEjDdEWujeebiW+G8AEJ?=
 =?us-ascii?Q?y8qxiMAkvMeJ9u/ae502vAsUHFqvqZrRvo7MDJW+OLZZKJlP1GKW9qJ3Cclp?=
 =?us-ascii?Q?HMhOjVsDiFQFVv2MIXRo1mFPQIUc1ZpDaZLCIrOYB43lWB05nLxLK4xT5zNu?=
 =?us-ascii?Q?LHB8pKDsrXkk5VWZOQfRCVYsRJSfIMv+n//gWNj0/Cmv/PTWeMSmn4UfafyA?=
 =?us-ascii?Q?x4jfnDVGQVwJJBgr7ZJB7AC9HT67EVfVHgxBlUe309UQpX3eryY55VehxuIb?=
 =?us-ascii?Q?AiT6W4y+Y7NtxG/6Y8lDWk0YMC+ALRAKOs/JAntgxoFIiBAawDvg7je89+5w?=
 =?us-ascii?Q?M1kzCjgqiTc12VyltSI5FsascfS3u+jhn6j+37FkeNTB+nSSg1z1wdiUKrCc?=
 =?us-ascii?Q?vcckbczOxaTNr3unTqdXfsUlqJ5buNQNeZWnLk5UKazSNgP2SB0f0g5GbJt4?=
 =?us-ascii?Q?0tQC0AS+6MfhYyDWF/FiNghn8vZ+rSiUm9LgpAntJ2etTUuUZgpHy/piUjPa?=
 =?us-ascii?Q?14WkJ0V09poff+KiresUsv35vOZmv31Aj6btbqC2kgTFrNetMdaXGdUbpRl1?=
 =?us-ascii?Q?0omgppc98+E0gb3tXFB9YJtm7Cjx3ydGloT0wm8V5IyTaLNbXfcq5jipTZ8T?=
 =?us-ascii?Q?h5JQmoTXjdpumzcrvWsC/LqDuhlrjeRNygZu1Cu9UXaTSe4+SWRxU/jNSUD8?=
 =?us-ascii?Q?Iiy/GOvxEXQMJQCUZuyoHVIrLvpHRdnH5XzooIncJLz7aOF5jzIWWsdXDNBO?=
 =?us-ascii?Q?e7BUrWH+ML3XWFGj0EkmrigqnTAxVSwAwZF7Ar7SIdyQUo4ZXHCWulw4LIYU?=
 =?us-ascii?Q?iss2TftJ3ZhrKHjQD/3CchPWFch82AXy5T8e32XjS0y90IbxYV5zLm0aF7pA?=
 =?us-ascii?Q?uixXyqMF8GyIMzmvAe+tvUysJLVszf0yxaa4GqaOKQRRho5Qm3+WzJ7wVL7W?=
 =?us-ascii?Q?lK4rIlP3TvD6zZtxx9lBGjIIqceoOWm9gAdlcIzVPqoV3b9oy8PdjhxtB5aW?=
 =?us-ascii?Q?IUSh5CuGHrOBMDI9Ve0ymqZlxhMRgOhUB7Y35oIkQ2CvHILP5BbFkY0KZl3U?=
 =?us-ascii?Q?+2IT4H2CI3oWQXl5EnaHTrX97dS+1Cs+U4+a0YyUcjlxqAAz1YiCOt9ACMw6?=
 =?us-ascii?Q?TLShugA1m9/fOWR0F53MwmbisFB7BMqhadln/aIQIt5Pjegn3SqOpmT8PvdZ?=
 =?us-ascii?Q?mCzc+ZsRJDrg8ZAstZtwpC1UlF3e4UMOHXSbn6u1vtoZPHZn81ZIY/1wOosm?=
 =?us-ascii?Q?6XvYTb2n47AfZigWlPMjxb6NHpeyVrFqV5yzL+C68gwxXP1aMOWb16rUpFIx?=
 =?us-ascii?Q?awImthlbaLM3MkYgDbgqsE8WB0n+sk9LUydNZWYLpLIKiQdxCtPylu7I5bjK?=
 =?us-ascii?Q?LUntTCj9mEfGci9uv6UJEssubOjWCN/aqcLI/d3fUAD1PWoasCmS3W5f3CrP?=
 =?us-ascii?Q?NaoJMuEqBPl+/PLekvEL6u8CojgkiHWVx2FAMUFfcA5Su5EAxVKbTmC1SPzr?=
 =?us-ascii?Q?yB1wjO6gnZHclAgUpxMG4PGAy9W84riat8mAXQioJrSNbhc82OGEuHnHfPLn?=
 =?us-ascii?Q?zT2Cd78J4zGU2kxofMrw4KIBSWVbxdXGxDzh+a/O?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a07e89e6-20a4-4536-0867-08dc89bacebd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 02:04:20.6448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvuvmObsshy7sQGaYvm8TQgDadYDlnqXXQXE5V+Fd8S0S7Ct8sYDFVyVZMIa0hVCjjVgpL7Z6hmbjJs1mwvgFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6944
X-OriginatorOrg: intel.com

On Mon, Jun 10, 2024 at 06:47:55PM -0700, Sean Christopherson wrote:
> On Tue, Jun 11, 2024, Yan Zhao wrote:
> > On Wed, Jun 05, 2024 at 03:45:26PM -0700, Sean Christopherson wrote:
> > > @@ -7274,6 +7275,8 @@ static void test_pat(u32 field, const char * field_name, u32 ctrl_field,
> > >  					error = 0;
> > >  
> > >  				test_vmx_vmlaunch(error);
> > > +				wrmsr(MSR_IA32_CR_PAT, pat_msr_saved);
> > > +
> > >  				report_prefix_pop();
> > >  
> > >  			} else {	// GUEST_PAT
> > 
> > Is it possible that ENT_LOAD_PAT of GUEST_PAT is tested when there's no support of
> > EXI_LOAD_PAT of HOST_PAT?
> > Then
> > 	wrmsr(MSR_IA32_CR_PAT, pat_msr_saved);
> > is also required in this case?
> 
> Heh, in theory, yeah, a nested setup could create such a monstrosity.  It's easy
> enough to handle, so I guess why not?  Though I'm tempted to assert instead,
> because practically speaking this code will never be hit, and thus never validated.
> 
> diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
> index 2063ee90..ffe7064c 100644
> --- a/x86/vmx_tests.c
> +++ b/x86/vmx_tests.c
> @@ -7288,6 +7288,9 @@ static void test_pat(u32 field, const char * field_name, u32 ctrl_field,
>                                 error = (i == 0x2 || i == 0x3 || i >= 0x8);
>                                 test_guest_state("ENT_LOAD_PAT enabled", !!error,
>                                                  val, "GUEST_PAT");
> +
> +                               if (!(ctrl_exit_rev.clr & EXI_LOAD_PAT))
> +                                       wrmsr(MSR_IA32_CR_PAT, pat_msr_saved);
>                         }
>  
>                 }
Tested passed with EXI_LOAD_PAT intentionally cleared in ctrl_exit_rev.clr.

Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>



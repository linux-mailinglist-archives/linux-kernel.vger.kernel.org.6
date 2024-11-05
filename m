Return-Path: <linux-kernel+bounces-395887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CAD9BC480
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36081C213B4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E4E18E750;
	Tue,  5 Nov 2024 05:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjyfbwIr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F3629D05
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730782867; cv=fail; b=aMotKFg4Al59VbNF9138P7ms77/D/hP773CNNR5ZuDL0RlUf+mdC8i1GDIBPL5GSvqJwK1SdZd+TXJujwXZQuEGUsuvFCqVfRC+iyXy1t7xkYC0GYGGOr4o7Rk8KaAnM+ilQYiOjQcRJ/x7RZ6PboYKntINSCSz6s63NJNzu2rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730782867; c=relaxed/simple;
	bh=aRSf275jCytXc+6pcKp0Y0o73LdqwZlaraGCBphpN4Y=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=jMlwcMLyf9XU08lqGv8l6Oh+6HtfzOcNA7+oyJNc3SMQ7TzwilNlmui/xhK4q+rtjMtNMhzmML58S34Z3mnMYGYipX/4z4xL0YHoOs5t357BRygsGAjknp7Lx6rDxmsuqw/sOizs7pl7HQF1uAxzE44MGgM9HKCKZUwNxsJ/IVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjyfbwIr; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730782866; x=1762318866;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aRSf275jCytXc+6pcKp0Y0o73LdqwZlaraGCBphpN4Y=;
  b=jjyfbwIrF2ywUG9GyfwwMFzWrCBx8f69JlLUpY+gH0JgASJfYMbqkuMx
   OtG8jNzFkSZp5PwqELCtBMRNVmPFTds1K5F8SwFaALJO4ZYmPHkA2rlh9
   tBYhMvlLmb8adBYQwgUOisVXhD3MUmwtulAgBp+gQOtS82QBEnRal/Ilj
   86WL35vQeyzUfGzlpldsCP+pZJluA7AjOur8Ksze3yLKbh76k2vOv7MpO
   OVNcDesSwgWOgBoB8YSLF7Sz6DHz23L+94w/rCWN7C9+2kANyT/OVCqCm
   0qcw3zdKxcPWhZEjH7WWHFF4Px3+nU45+m5pCOehkwPezi22DNt/UknsS
   Q==;
X-CSE-ConnectionGUID: uTD45O34SPGNJZirTK3rgQ==
X-CSE-MsgGUID: m75I54bYQnywiRgBbjGRaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30464615"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30464615"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 21:01:06 -0800
X-CSE-ConnectionGUID: s31Mj8S8Q+ixtyAMAB7stA==
X-CSE-MsgGUID: UO+6J+o/TZ2sONv1KRvrug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="88626775"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 21:01:06 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 21:01:05 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 21:01:05 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 21:01:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnVcWTG0tKx6riIP0BlUrtY1F5or1SSvicLmNEiJny12zJGmeIb8R+jntf6QdYGcdH29Uj8OTobGemEXDPvOn3p4x0CQR79Xv0VaHWvZyYN0oS5EhxELu5XOXvMCZfveMsbAOb9kf+nOFJFfFvekUDoyI0o9jxq+xEvPlDoKnQv9gPXOeiV7qwpd/j3tcYsIBJ6ygnjReqpJVv3DWZPdZJEbBJ5rvpxKk2N9ahcQ1leUOiBZwwmHV5nTQFkjfmvZ/KhIEZDJ5Jo1QVt3yzNKMcOv0ArhvK2SSq7hW8n3mhyeQPgGRvBP6CyLgtw7xDWMnlVLlgA8IPM+EYaxGHxt4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nXYC3ZcKm98WjJDaU7NbV7WPPDXlHZCL922561ZYpE=;
 b=Iqvr4xhk5TFKQsxjbEtBzZ3HsjO8GRi6L13Ll3fLqrZHcJvhsSrK/taVwRp4Nr84hAgQwGANcuxvu1MMslw5ZnZ8zBQpdZjNLY1yV48SqyzIZs4Z1M61azjOQNVEtFfOLn5Gfo3SiabOzrvHodKAgtA/lKr72BX0OFlpHlUf2Ls0pV3YzvQWum2qsXLb580VUre2NhTNvg2CIyBF+iCo0xtRs5zA6JkbB2RsNNnhpDZ6TNUnDN5ln6cvnOrp0Ui/JsP8pTaNz6OoV6nVt8dPEa0qFQ97Qx4Da/kRN2d29p6iHOW32n3DBaOcyy7zmm+BgNSYKmt4J65rpGI10qbOSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6657.namprd11.prod.outlook.com (2603:10b6:510:1c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 05:01:01 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 05:01:01 +0000
Date: Tue, 5 Nov 2024 13:00:53 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Frederic Weisbecker
	<frederic@kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [paulmckrcu:dev.2024.11.01a] [rcutorture] 622baf5d79:
 WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]
Message-ID: <202411051012.f9224879-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:4:91::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 8446ab1c-6f23-4e61-2d6c-08dcfd56d83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jP5jsOmVZ9LrvSgDEX4hNsf1ytrq+DgCclOJ7PtCs1dTUDULnj5B7c5Pdm7c?=
 =?us-ascii?Q?YYAYZUYgYQEjHOdcsBQlPEWhYQOhThWpevNn2TMReXk//EwKa2g+q55ZDhTr?=
 =?us-ascii?Q?dldRk2eZaYjkYBrEYR7hJ39z5gdKi+utlQbwxA1UqDhhgakfhjbBtjpuAycU?=
 =?us-ascii?Q?3ys5YLb2UTKQhg8ZzRrGEsHywxvf/ZtYW3vHcnVrN49s3IDg6rZsO5mC7Az0?=
 =?us-ascii?Q?riFOYIlUTYyWTwvAWO/bkUjasXvM4lm6q09ssGWPve1YqlSQk6DkhdXlZAj+?=
 =?us-ascii?Q?DLhC2ZiW/++pNNE0TmPf2gtbR8OoOPC2qX6vINfixxd5UCDVgTLuiSpfXKx9?=
 =?us-ascii?Q?eIGGtHOng70cekZXGdPp92K6MGb24zNJZ2LbKzrAXscHjx8RcFxLRo6GEhHm?=
 =?us-ascii?Q?A0x+yfGUqLRr9AkN/kLmJwiSyNqlVCogfbZCtitksRu+lN/pcY5/HWt//xEX?=
 =?us-ascii?Q?84LE4DZYtU9bO80M+EZLH59ILBnFaipWyBjBzvNb8OusCkImpLi3bNgI9y0T?=
 =?us-ascii?Q?7gp1NAjvOBSWFu5gP7obqB3Lczxc5RQ369xcEagMEF4tJialiVbyKJiNWzs5?=
 =?us-ascii?Q?fOB4zyAwVRBfVGpDyVRIMG+7g5kmSX1qzVs946sBCuN2VmBHBtLOCdWVdEc2?=
 =?us-ascii?Q?O5mra60o67fQMx/gAJ/4Sg1yf4Pr/0l6Z/ZkmPva6nbUmJd23kPnC1WZPwNv?=
 =?us-ascii?Q?upj7gkD0PTSBiBICtqc+xck0x9W7sQI3NBurjMg53CG1KfpsRrwQrpgnUTip?=
 =?us-ascii?Q?1DDxCohtjIievaK9atpoNB8LtvnT334VG6ud4LxEke61074ZD4F9TnT6txNr?=
 =?us-ascii?Q?rv8fovgyAozWUhBJ9rKgFRxKdfDKu7f5esI2X2j51IvWDefjzrHTacLgLmM7?=
 =?us-ascii?Q?z0U/FSCTOhrC7X0a9lTH5/7iyBTKTD85spe9UJcNonkHpAc1IiOHZ8s3QM7i?=
 =?us-ascii?Q?XEPG/aBjzHDJRtcL84C0o0AA9F4GIpvLVVxrESluOKhCNYyHZOq82j4RovH0?=
 =?us-ascii?Q?N9C7TDFGwc566qE/G72/yG7mgJUQCfWNnVpaO0IwQ8gychmf4Zn2yfTkRvqF?=
 =?us-ascii?Q?HTexShadscWRGeuQqHKFqlA6ynzGTNHpXcysCl+QwrcVGV9mtp9RIXS66Ari?=
 =?us-ascii?Q?B8rahowHZB6NUzTusAszA0jr6zq7ouwK5wVxyExlkvfes2zUxTTZbDWwE9uk?=
 =?us-ascii?Q?F2YZDBOnpH5eJXRyImhjrOnIagdzDLakL5VJ6/6HQ8iEkcKTU7VYhuqkhK7s?=
 =?us-ascii?Q?B9I3x76Y4O9EK+85jsZcHSdzEFsML0g21csfVCbHKw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?miBylH/+QqLDSJ93TLcUE3GfLkJ4x/9axUL2/iLxfYx09XDxouw9HgOPtCFn?=
 =?us-ascii?Q?vEG3ef0lAN5rHSpXi7SJpXhmbmzOYYgj6DaUwIzPlbeZ/J0jsN4CQQPOz9To?=
 =?us-ascii?Q?d/x54iZaGeY+XL2vdZSmJt78DjpqUJUlOZQ6Tf6fRMB3cJ6zI91gRj0L6JWw?=
 =?us-ascii?Q?WjFY8qqxeGrSnVUWUpOGj8aT2S9fuXueOmM/rNenxAcIpUVNodpYZBdB+rSP?=
 =?us-ascii?Q?/R+UzYo73mjSLuaZY2lm/OYI9TCqQ417/e4ddqkIdZN/Gc+XfTekeZMxqHXK?=
 =?us-ascii?Q?mPnf4KBpUfmEZ3qJ1z2d9dIjjPoFUuFHaorg3iBT1hDwxkoNQTKhRiL54EGi?=
 =?us-ascii?Q?I2yeLnawvlMAe2vKoNBOXPI4qHMWdq1Qkcs7D9E2lkfWn6nW6QhCqRDb1v8f?=
 =?us-ascii?Q?k41iBf1c6AAhLgyEf7EkLiAK5wqhmVYbG++uxXfzm6+DKJW69OpOB39SALl1?=
 =?us-ascii?Q?/PZIzSrQmsKPswK0IuG6pAQmQNuBkqUj9SROh9+9yWSpmyCZ9xpYpM8PtlvE?=
 =?us-ascii?Q?HAyhOk3hWeWMLnFrOZ8jMMU0gSSe5sgJ8jmf0caip8NOgtZ9PCi/mwSAMDrj?=
 =?us-ascii?Q?cJ/GMTFUxWMWH2NMEeZ1oFX1UzH7LYNqqyLP6YtAWk/yBHJF3ZdnJUJh8whk?=
 =?us-ascii?Q?UF2i97V1TDRFX4aPfNfFVB4wOfGv7BCX7r81G/w6X/NH/CEejVC+XIYzm74n?=
 =?us-ascii?Q?AkLhytjGr0RJYKB9Gmv9XL4BtpB1OJV7kM10ixL2DWMxZ3snVFLPDzaeOPr7?=
 =?us-ascii?Q?raneaqtvUh5o+N15DxsGIdZ3nrnA4ZgKPBhAYnDVnuM4UXayePbMtpKGr5w5?=
 =?us-ascii?Q?CxE6g9y8Di/qwE+z7yPRovPIaaOjLFhhyVReH4qHjP4JHxIyehDieewRD8XE?=
 =?us-ascii?Q?5BKaUsLBeJzRaxv0ftVbpn2F3GFUTJeyNrCwZSH7/5GBOyS2IPp6L6Q2wVl8?=
 =?us-ascii?Q?99QYyIpER4cESUc3a/Uug8tLoNHowWPFRXmiedPUtRMba+f1hLUkGC0afhMk?=
 =?us-ascii?Q?tVdGC6soqdSjUoEtEljp1RwMWAeEyOEUmgIaVa3+wlGUfRNpxr8J5IymAddA?=
 =?us-ascii?Q?dAPPqytL8C88oWQPziyCn2iHf1N/Csy8jj4KGjjk3m/jftMUZEhSCs6PnVo6?=
 =?us-ascii?Q?yckXhFmB7NfPuXIEE9fJ9Z02wwBsd9jj2HQ7x+n5aad5RE7rcSkvBsMI7EiO?=
 =?us-ascii?Q?vE2+0dcSLQL/l59fG+HM921I/sQ1wCleFaHtdarD/TFMH0ee9vyZtuXgG/mp?=
 =?us-ascii?Q?jDwZ+sG9JcfI1DnuXRiDzEqqPIUo7r1D5Zs9OjfH6ojufWtFSCWtPDtyQxGy?=
 =?us-ascii?Q?9nOarWqgGdWZxWfCu4dpbhqSsL5K6tQVz+BLdGtgY3N/k8O2PblrjFC2gvGE?=
 =?us-ascii?Q?rjFRZTJSHibymGLNQxPpttE9eQeP8F9sDcSTebq0BV6SfYQzNMynU8pEHJdH?=
 =?us-ascii?Q?PC36HKkSnQjPaNaCiUd6ACq5NkoPiQ8wyBPOe5YY6aHyUMVAO5i5LerPrSOE?=
 =?us-ascii?Q?qD94OW8eJDVKI/drtvn/j34Jo4e68T9tgksrY+Gk3iW4qN40sWoPitaeWE3x?=
 =?us-ascii?Q?5KnyiWqnrAF9LTOm4qKQjRV0CHjMHQ/dxi1CXLl8vXNwvGhcBEReNmqF5JYs?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8446ab1c-6f23-4e61-2d6c-08dcfd56d83b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 05:01:01.8504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGFRWK/SkS+Hb9NamOIs93XDqkCOyZ6HXfXj7E+L96X4EOUAD1Xb909zKRRSjGSA7Z8SeDqucjAxf8Ku9xz1SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6657
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]" on:

commit: 622baf5d79169496973d50fc43636469e6af02b7 ("rcutorture: Make rcutorture_one_extend() check reader state")
https://github.com/paulmckrcu/linux dev.2024.11.01a

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: default
	torture_type: srcu



config: i386-randconfig-061-20241103
compiler: gcc-12
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202411051012.f9224879-lkp@intel.com



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241105/202411051012.f9224879-lkp@intel.com



[   94.499370][  T628] ------------[ cut here ]------------
[   94.504179][  T628] rcutorture_one_extend_check before change: Current 0x20  To add 0x20  To remove 0x0
[   94.505405][  T628] WARNING: CPU: 0 PID: 628 at kernel/rcu/rcutorture.c:1876 rcutorture_one_extend_check+0x1ff/0x2ba [rcutorture]
[   94.507176][  T628] Modules linked in: rcutorture(+) torture ata_generic ata_piix mousedev sg intel_agp libata serio_raw intel_gtt agpgart i2c_piix4 rtc_cmos fuse autofs4
[   94.508995][  T628] CPU: 0 UID: 0 PID: 628 Comm: rcu_torture_rea Not tainted 6.12.0-rc2-00086-g622baf5d7916 #1
[   94.510118][  T628] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   94.521987][  T628] EIP: rcutorture_one_extend_check+0x1ff/0x2ba [rcutorture]
[   94.522990][  T628] Code: 00 00 00 80 3d 9c 84 2c f0 00 75 bd c6 05 9c 84 2c f0 01 57 56 53 68 9b 00 2d f0 68 40 1e 2d f0 68 a9 00 2d f0 e8 82 22 db d0 <0f> 0b 83 c4 18 eb 98 31 c0 89 45 f0 80 3d 9b 84 2c f0 00 75 23 c6
[   94.525121][  T628] EAX: 00000053 EBX: 00000020 ECX: 00000002 EDX: 00000002
[   94.525898][  T628] ESI: 00000020 EDI: 00000000 EBP: c77c3dc0 ESP: c77c3d8c
[   94.526758][  T628] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
[   94.527733][  T628] CR0: 80050033 CR2: b7248000 CR3: 07bc8000 CR4: 000406d0
[   94.528515][  T628] Call Trace:
[   94.528885][  T628]  ? show_regs+0x61/0x67
[   94.529424][  T628]  ? rcutorture_one_extend_check+0x1ff/0x2ba [rcutorture]
[   94.530342][  T628]  ? __warn+0x9e/0x151
[   94.530852][  T628]  ? report_bug+0x120/0x19d
[   94.531398][  T628]  ? rcutorture_one_extend_check+0x1ff/0x2ba [rcutorture]
[   94.536465][  T628]  ? exc_overflow+0x37/0x37
[   94.537098][  T628]  ? handle_bug+0x3d/0x58
[   94.537683][  T628]  ? exc_invalid_op+0x24/0x60
[   94.538224][  T628]  ? handle_exception+0x133/0x133
[   94.538880][  T628]  ? exc_overflow+0x37/0x37
[   94.539408][  T628]  ? rcutorture_one_extend_check+0x1ff/0x2ba [rcutorture]
[   94.540399][  T628]  ? exc_overflow+0x37/0x37
[   94.540940][  T628]  ? rcutorture_one_extend_check+0x1ff/0x2ba [rcutorture]
[   94.541903][  T628]  rcutorture_one_extend+0x39e/0x3a7 [rcutorture]
[   94.542657][  T628]  rcu_torture_one_read+0x7e/0x4d3 [rcutorture]
[   94.543218][  T614] srcu-torture: Creating torture_shuffle task
[   94.543494][  T628]  ? __lock_acquire+0x684/0x72e
[   94.544510][  T630] srcu-torture: rcu_torture_stats task started
[   94.545082][  T628]  rcu_torture_reader+0xb7/0x16a [rcutorture]
[   94.559381][  T614] srcu-torture: Creating torture_stutter task
[   94.559414][  T640] srcu-torture: torture_shuffle task started
[   94.567377][  T614] srcu-torture: Creating rcu_torture_fwd_prog task
[   94.567413][  T641] srcu-torture: torture_stutter task started
[   94.567748][  T614] srcu-torture: Creating rcu_torture_read_exit task
[   94.567772][  T646] srcu-torture: rcu_torture_fwd_progress task started
[   94.568324][  T647] srcu-torture: rcu_torture_read_exit: Start of test
[   94.568329][  T647] srcu-torture: rcu_torture_read_exit: Start of episode
[   94.587605][  T628]  ? rcu_torture_one_read+0x4d3/0x4d3 [rcutorture]
[   94.588336][  T628]  kthread+0xe9/0xee
[   94.588796][  T628]  ? rcu_torture_cleanup+0x750/0x750 [rcutorture]
[   94.589492][  T628]  ? list_del_init+0x21/0x21
[   94.590015][  T628]  ret_from_fork+0x19/0x2c
[   94.590524][  T628]  ? list_del_init+0x21/0x21
[   94.591142][  T628]  ret_from_fork_asm+0x12/0x18
[   94.598922][  T221] 2024-11-04 17:44:01 sleep 300
[   94.598941][  T221] 
[   94.601820][  T628]  entry_INT80_32+0x125/0x125
[   94.602363][  T628] irq event stamp: 621
[   94.602906][  T628] hardirqs last  enabled at (639): [<c10c43dc>] __up_console_sem+0x59/0x69
[   94.603896][  T628] hardirqs last disabled at (646): [<c10c43c3>] __up_console_sem+0x40/0x69
[   94.604836][  T628] softirqs last  enabled at (636): [<c1067d80>] handle_softirqs+0x2fb/0x326
[   94.605797][  T628] softirqs last disabled at (629): [<c1b1071a>] __do_softirq+0xa/0xc
[   94.613261][  T628] ---[ end trace 0000000000000000 ]---



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



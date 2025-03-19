Return-Path: <linux-kernel+bounces-568449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931B0A6959D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467E03A1CF0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B681E32B9;
	Wed, 19 Mar 2025 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WO5Xh9b2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFED1CAA70
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403537; cv=fail; b=cOuCL+E3iwNrhP9DpW2zQB4nskMqxZ4G1msGd6CaUNbkUcLYPFj5ufBGWpscXB18DxHoVwvbmqYU8Ixor4amBRi9TXTeEfmx3ouGrRhN71WVBDnXuusA8Z82N5J7y3DMAoCCX2P6ehVt6ZT7vwFMT40V/P1Volp6ySsIatjKXes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403537; c=relaxed/simple;
	bh=UWgF9wMS0exR0UQ49lC4WYp7CrP3+X//+gcnQkn4WXg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kOVbkHFvdXw+Unlsr4z+zN7WEzK7JTQBC5OJ3+NoFTzXTFUPaImRIJzUd4TmCSslDq/x6MTXSXOTKlpyrWIqHjvtH9d4CeAUtn9m5/99I4ayyvq+ki9jhl67lYKV7DMk0BHrfqAclX+oFSUHoW75qcNvvxnTsIWju7Yk/54EB+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WO5Xh9b2; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742403536; x=1773939536;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UWgF9wMS0exR0UQ49lC4WYp7CrP3+X//+gcnQkn4WXg=;
  b=WO5Xh9b2XgYw1zrq+k2UkcX1jUKJnORF4LrRyqXS6XDOuKx0s9YPXD4g
   TlllF3509UAXWmIwtGXYYqpt/1a1/ZO+sIyG8rl0Vfy2b/iO/9KSoCEHi
   Ruf1eT8W2X7Plg3NqHxmOdhWqPuo0+AOpXLWSe+W4bAIXq20YmJOQ92oV
   L7Nzgusr4gBS2pHrTgvdrVzOc3gaCKUZWRx3RGDRxrGys7EN4M21jAt2d
   09ibtwN7oorfWyPxUYcF5RrIhzAsZGku58i7DtXNBoxtgwMZyD/7w4C5s
   G/C5THqs/aA/SDI8O4YDecizcR2Au5at8wmialLKG8JIlOcU5pzgQVi26
   w==;
X-CSE-ConnectionGUID: Kx4ssmegQeGQP0Dhz+85Sw==
X-CSE-MsgGUID: vLNEEedjQMe44qPBFwD6NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="54983086"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="54983086"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 09:58:55 -0700
X-CSE-ConnectionGUID: 2z7dJ+qhRMKC9rerWp4gqA==
X-CSE-MsgGUID: alkeUxuxSyqDFKmBrLcqYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="145900224"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2025 09:58:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Mar 2025 09:58:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 09:58:54 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 09:58:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqLsYERF7Dh6AdgDk7NhPMVBEwRG6FthBCnHR58ipQvllcR1HQcwfApw57oI28r4nJZT2GCbVZMuId/VJeKepi2XuKi8ZgXQPdLsEVgbS6liMHY8ocuq8mv0d2baOdUURuLwcDz4qYCHFdR6H3Q91JbXJXzbqAXq6oxY6tbd2h9qN/vtwtg+AKFI7HJ2gP7p5Qa78yz6qAGdYf9uop3qUyshgV557r2NeQRNfXa/0oGFyvGITGy2WLACWGZPAy8m7nP7Yzn4ynlCZUZO+XsQXb+rlBAqt7ApkB4PzlhJFvJv5Awrthv7tRUrHPsXaLXgKw2Q4G/DAqSd9WmdgSncyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CG4W5wptfFhkmJGGZNDxVciI8uiXx3HGk0Sg1prS2jA=;
 b=OCRMeAC/I0f10fMRBZUUFniVpcFENrGUo9qIbpdqZfTepeY92gtlkoJ7N7J+2w4+l1I3S8+c6/rQusvHV7i/Lkepg60Ylzo2gLD24+YbpYbT+Ulca/UDEkx6dotEHI/ZHNWkGKpC3WndmdrnTLZOJAc0U1aUDZDTakpj/3U5CaXZiKAoCW8dKICobGLSWz1yA6pSPkqMpUjdi4RYztyP7HCxFNJP5yEuGfs8hATNyO2vLQbmZDacEYFySRuMCa8AVErbJ79TcaTZ2rKK0neQtdx4jtRS7XZk9Z0Yxi6ZRDwLRBiUEkTMu7dwVQEXECq92pFV2zmDozkJpc+qOfBY/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4838.namprd11.prod.outlook.com (2603:10b6:510:40::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 16:58:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 16:58:46 +0000
Date: Wed, 19 Mar 2025 09:58:43 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Joerg Roedel <jroedel@suse.de>
CC: Alexey Gladkov <legion@kernel.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>, Alexey Gladkov
	<alexey.gladkov@intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Juergen Gross
	<jgross@suse.com>, <Larry.Dewey@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFC PATCH v1 1/3] x86/tdx: Make TDX metadata available via SYSFS
Message-ID: <67daf7c37b2f0_201f0294a4@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1741952958.git.legion@kernel.org>
 <ddbf49381eb5d1779e218e022ffc144db5da003e.1741952958.git.legion@kernel.org>
 <67d4bee77313a_12e31294c7@dwillia2-xfh.jf.intel.com.notmuch>
 <nvnjhx235xbsrnq3t6zbkgogsdizbigrlgqyx6muyj6k2g34gq@zzn6bqvoha45>
 <67d8cde71e75b_201f0294a@dwillia2-xfh.jf.intel.com.notmuch>
 <iiqa3m57jrqlyy7qmydf7klkub7bqbn7gqjh2te2fyp6un3dk3@qik6uuao7dlb>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <iiqa3m57jrqlyy7qmydf7klkub7bqbn7gqjh2te2fyp6un3dk3@qik6uuao7dlb>
X-ClientProxiedBy: MW4PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:303:6a::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4838:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c87360-ccf0-4866-06e8-08dd67074fee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iCQ4+n0tijZfNfTeIcdtGJnd9LErzcMO8LEC4niXCKLUdV/6FDMQ1uGmz6R/?=
 =?us-ascii?Q?e1s9QG7tgrfzC/47lzxrMhiAKH+PnG7RyonvgY1HJ3WknArDAD8yz3VYKX9C?=
 =?us-ascii?Q?NO0DVW5M/8eWl098rqaIoeTWD4RrVu6jsiscNZUPpQJQkELkYUh5Ztsze9h6?=
 =?us-ascii?Q?z8FzHc28aXPP3L27JS+BfrFdk3ePD9XP1774yTyZA5qSXqM8PQriWBVZbfj3?=
 =?us-ascii?Q?AoHWy+c1aRgDBXcYgKQ8A+9+OKCsld7w1LIQBjgjG17VbSEIk7POvddUIQag?=
 =?us-ascii?Q?ZSMQ/iGEp39rOLhk1Lfcaw9eAuc9rYE6+tjN9knwIh4eiyDSEELyU5dsHz1l?=
 =?us-ascii?Q?QawXsTN7QT8+6TKal9ZrP7PSJl0UWsnenKTEc4aAokGSUFYU/P3TeyYZntbb?=
 =?us-ascii?Q?OqSmgRgf6wGJCQMKxULw6ftgzj/wreCftgx7J56J7z3yVNUkmQCJPKc4RIh2?=
 =?us-ascii?Q?UIX/frpZs95UKLQiCw+aorpvOehcUojzoHTEw6Fo7DKN90Nro2wFiwt6vMSs?=
 =?us-ascii?Q?XsbCHOkNTh46nE+0LMRiw43B03W4vB9Z2YidiQD/47dZKzlc3HqKBFuclMGd?=
 =?us-ascii?Q?2525Wfmpxps8q9iTfFfWhPKfAfSkE87up3KqlByP6AQL0ADoi9aR0C36W7LF?=
 =?us-ascii?Q?R4UAqm3od3TpvOuufcV4L3JuFmMIcpyaUlNF3UxvZu/iRS9PGjPR9yV5cFcy?=
 =?us-ascii?Q?Nzfc86aA+N9+njL0iajvybJp8k3aSFKoEO3IhWZDv0g6Z542yhXRQ6VqcyAJ?=
 =?us-ascii?Q?yWQE/7vnh9/vUm7rdBmOtYEk0KITX3Hrm+KQDVJiLgyjeWiXVtz9GOiRZ9P/?=
 =?us-ascii?Q?YJ1o9QpQ5BeSIMx2/eOj1HxwX/onMFf50r+npMyG7R+IFpQj21qEZn6jM8mV?=
 =?us-ascii?Q?Rgut8VS4E4y6M0QV1p6Ocs027iRE0BZljUmomQthAV89JkneFmNBPWgkytC7?=
 =?us-ascii?Q?/jZtzb/jd6b3i9rpLFhtsTaelkLzwLwfUwv37Uzgwx6uww+lqa9vzY6rfMWn?=
 =?us-ascii?Q?iQoqNT65WHk46ZS7fq4MSP8omb1iUt8FJMhIcZ+gmdAFEghuh2Dl2Db/qyVu?=
 =?us-ascii?Q?IBCLE+4YB3n4SAHXtfefibxE4yvlnrQUaWaGnpkzcNtcDerV6ldkYseAoaUO?=
 =?us-ascii?Q?qEuMoDyIF8rVfNEGELNhvELMa6pYE1rVXyOhLuHPFRuvvxilyZQiEm7cOciv?=
 =?us-ascii?Q?VWVuzg8miZ+io61NPNdAAzl7Cyq3aYeuXcSCNJNQU/fDaZobqSRPM4DcJAdi?=
 =?us-ascii?Q?F9cMAlszgqMFiCxxTXKtBNRrexhoSv1LhZ9uRAnF6gZadZrR9gBk3aVO3fk0?=
 =?us-ascii?Q?GoEGFsr+Zga6gTYM736ILDvsVCAEx3jhs+u9IQByPHWUzCnzkVMZuTaSMnWm?=
 =?us-ascii?Q?8vO98OeKMUFFW38AZ+5U0yhN2E1A?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KTxKEQS+uopnG1X1B62QwXevDluo4uLW1tRDq113oOYFoqw2NGoDkb31mfR1?=
 =?us-ascii?Q?zizgaOry4wPw+QtK95i96OiAt27cbgZpjdeaFBHFMNfoX+pe6wWJbqdgDgk8?=
 =?us-ascii?Q?uc4MsYmlSWD+5NpBNKpwOVze+NXBizVE6mlNaNfdIlRXg1FAftWDhSL29Siu?=
 =?us-ascii?Q?y+qF3rkOGSwRhDMklWkVrUte/2Mq1gyZdHjtEj8ksJQ5sG/JgJGJx7SCKxaA?=
 =?us-ascii?Q?x5ULIgiiGDWS5PhYMEJhVMtV/GP9Xve385Qn2wS72mpwbKmKujPmfhF6hHar?=
 =?us-ascii?Q?5nUYIP8oakGRoCxIdXtrjVW/Kw6PsBJMWDtoiBZYVTntEdMYNx/rHBUqDX31?=
 =?us-ascii?Q?GU53/cgPI/CfCciPhLt19wfmAR0IOhe74Eo1s0TCwb8I8EJ7tsosY6RykUy2?=
 =?us-ascii?Q?PWvseflAYELvRfSyL8rsxCO1scoqZfSNAxmN3UR8fNLHEwx7tSnVv4G2mxDh?=
 =?us-ascii?Q?yYQba8/W4V6usabHJ8xq839ouQHGZZkF1H78l8q5YMOb6yBuIDbKB8+72x12?=
 =?us-ascii?Q?lBGI1xsv0t8tv0xVPw6SRYYfTjjPdU50yAptjnw/lgUm8UY3zDc5uS769b9v?=
 =?us-ascii?Q?nTQke7kHLPGeCMcaMr7Hj24EPDWpqxNwt/aDJATCmoQUybXKyOMmaqWMVRqu?=
 =?us-ascii?Q?YAtIOew8KcIkboKS7xM4QNFdKv8m+3iHAZfTlVEYGS1xAqfgg2xrSJA3yLWj?=
 =?us-ascii?Q?dLlmeVLPPyk7PPvbmMy2ZDq9J+J/2yI60Cjb69J1NXc8yBLkE7vul732Q98W?=
 =?us-ascii?Q?L2freZBpHl1pBWUf0icTmmiyyucsIGJJ+AQIugLODba+u7GYON3d9Rs3v8BF?=
 =?us-ascii?Q?KtBktMGpgIlMJQOiSMnhhuqmmd42B5S4UvguoQI5tDYkNVwuSNjtcrzRrnOR?=
 =?us-ascii?Q?hyE9NtGY2H+M39kNd8D1l0v1QCkTIQ31bUOXaDB/pVV4oyRmnBAlfswfHEKZ?=
 =?us-ascii?Q?aWk9WDXLa3RW6wNGJ5nE3vJmi4LF4upjRYzCHLRoxInXUYTYMJMXEc3oRXAy?=
 =?us-ascii?Q?6duJV1gyXe6XrerAMhN+NsaUaI65ZveKAY0MaqsXU2b+460ZukRdyoYr7cVR?=
 =?us-ascii?Q?8+AOYpMBvlW8vENr1/mB7czTrbQ57nf/UOp3luryTARkitNSQnaCkEEcvsR3?=
 =?us-ascii?Q?v8sRP70DQT7WEhMmqGXMXzJ/lMZvWb0NdlkBwO3CQUXUWOZsovjcQZhLiJRw?=
 =?us-ascii?Q?TKh8AwYOMSYCtN1rsKYNjK0AB7BtY0Yc7uCeuRKHG2EIEwOd8BvvIDT06P/S?=
 =?us-ascii?Q?IoesP/mnrpNvTg1CIW4F4myi23MkWRswabP00aRDT9eVaxbwLYGS2lKOdjRa?=
 =?us-ascii?Q?OmLGtVEpOruCr1HsFlWa878+gFkMKqqojrsou4PaVlVED8MXvoGrvJXRs6pH?=
 =?us-ascii?Q?mOCP1Tg+nxX/R0ofX1JRlqpHXiBJiDHOEhCn5m2bAYH+zpyhTihrFsiSvUfi?=
 =?us-ascii?Q?iW9puWJ4HHQkJ8snC4L3OgPmpWG/5htZrHAWAL6S8gvMhI18opSJNYan3cxI?=
 =?us-ascii?Q?aieD5j4Nm0aNj3QYF9RnQ5rJhzjCAWQXZUYkUH2klCexfRa9Ju8AZl/V6+iv?=
 =?us-ascii?Q?k1vRqMANi6zRigZp3XmntGQjTrskifTU8ptoGkLkZR2mtmMPfuJvx5A6FI9z?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c87360-ccf0-4866-06e8-08dd67074fee
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 16:58:46.2166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1+bqRmiC2/NFVevou8/G51VZfn1GxIlf1D/OP0RnudaMH0YdLX5zGRsMUNQ+ucgPbbtPxbIFJsJTDqasV7eiO35TjMWnEp3KmTz/G3Thfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4838
X-OriginatorOrg: intel.com

Kirill A . Shutemov wrote:
[..]
> > > Dan, could you elaborate on what is actual proposal? I am not sure I
> > > understand what 'struct device' can have info on TDX module version be
> > > attached to it.
> > 
> > Confused, you do not understand that devices can have sysfs attributes?
> 
> I didn't understand what device it would be in TDX case.

Oh, *which* device, now I understand the disconnect.

> > Documentation/ABI/testing/sysfs-driver-ccp describes a device object and
> > sysfs attributes for SEV-SNP firmware status.
> > 
> > For TDX, the proposal is to create virtual device to stand in for the
> > lack of a PCI device that fills the same role as AMD PSP.
> 
> Okay, I got it.
> 
> Do you see a problem having the same interface for both host and guest?
> We obviously need indication what level we are running on.

While I see no problem with /sys/devices/virtual/tdx appearing in both
host and guest, that needs to be reconciled with the fact that both
SEV-SNP and TDX created misc devices in the guest.

As for conveying level, the configs-tsm (soon to be renamed
configs-tsm-report) ABI already conveys the level for SEV-SNP if you are
talking about VMPL. 

> > With the expectation that all TSM technolgies (SEV-SNP, TDX, CCA, etc)
> > register a device, udev rules can trigger off a common class device
> > uevent. That proposal is detailed here [1]:
> > 
> > [1]: http://lore.kernel.org/174107247268.1288555.9365605713564715054.stgit@dwillia2-xfh.jf.intel.com
> 
> Joerg, what do you think? How does it fit your ideas for SEV-SNP?

As I noted, both technologies currently register guest misc devices, so
natural place for some simple guest side vendor-specific sysfs
attributes would be via the @groups property of 'struct miscdevice'.
Otherwise, the proposal for cross-vendor TSM sysfs interface is via a
/sys/class/tsm device. For now I only have patches for the host side of
that for generically conveying which PCI devices are consuming link
encryption resources in the platform TSM.


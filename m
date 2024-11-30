Return-Path: <linux-kernel+bounces-426125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BBF9DEF3E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 08:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1A81637BE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 07:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6673148838;
	Sat, 30 Nov 2024 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBn+OnGM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19101448F2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 07:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732952446; cv=fail; b=QaOWe2A5gNk8YK335bPHs3y0vrgPXzaht0DgYDyj2NJddhRHnC5n3q4PCkG+XX7qYpNqNAQKD24TnJgIb2lJy+vGUsdBYKoHma/sWph9o1my1L7v/oWXJdFUdOniJjvP6qXABN8i8vcuWgIIMJv08ZrCjoPzZwTovGf5b9bSznk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732952446; c=relaxed/simple;
	bh=83EyWn89uFzWl70ROlZ+GxhWKLDK8PHRYiwdqMZVzOo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=VcefIFxi9kub0ii908+gPER9WwEDt6fKILkXPSNi3Xjg5qB+Nyk+PSHyhgmE3VjSAEgVR/+A1C0MVQz1P7Y9BmnexQ/YDqGpBHeybBlmn5tA+BiqxzcfNcv7SWkBZDsFXEZszkXmX1XnOWuZjNalzkpA2YP94rDZCA8D+K9/dTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBn+OnGM; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732952443; x=1764488443;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=83EyWn89uFzWl70ROlZ+GxhWKLDK8PHRYiwdqMZVzOo=;
  b=cBn+OnGM13Y4vx90CtxejlrNPAbKx/PGbvUBX30JBhtc6qnr4YSx3BrQ
   Mal7Ex4yCIAa0VtdfCcQ2qDOWXxVhp2MJI8Pw2GL54++J+X5m09Ns2R8M
   lAsKz4V8/PA2bW2QYQW9n5r28XUZKK5R2QG5EIj2CqebrOBEHyRVWHEyl
   n35/I+GoVT73tjBnDNM6PjMuBVIURWrS0pTKjaKA3eb8zrNObwVVumuj9
   M7V+czXyoIN5it5v+JV5SiRpAAVCKWtb4w1lzCAQ3fbsjL7k17X58Sabr
   CBfI3s55t4cqGVL0hPzJNrRuCX26dwjsib/I2Dvpz1ZDlSF2gB6fKXDeJ
   g==;
X-CSE-ConnectionGUID: ye2iAsYxSKakm+EaE25RkA==
X-CSE-MsgGUID: ZYvHhBJyTgGyLZKm/hIwSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="44541697"
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="44541697"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 23:40:43 -0800
X-CSE-ConnectionGUID: L8kaovmFRIKrOxoQsg/YUQ==
X-CSE-MsgGUID: 4qQ0lBm4Q5Oa6fyh9FYRcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="97683139"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2024 23:40:42 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 29 Nov 2024 23:40:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 29 Nov 2024 23:40:41 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 29 Nov 2024 23:40:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZlWKuPfYbJAsqbV2vEKdjc6o3gXNJ9UQpcE6hS+9gA+DOjAaTOZ2moklS0ZYuhUUXfjCXukzHZPgW6vGC13Ou4XHewZJa4Y68UI9OdPTCoy3lyvlhqX0wnODqJLPbrmq7GI8joiSQGnAgTSn8E553Ujdh6Qw3NmflJCXjefSvbrm1ZZ8aUAUjVWsazPTavwNS7l5ybsax6Y6+XIC4ybZLzYQ5m6KedQzgBga7AC4Ei5jrorApIsjkwHp/8RC5MO2j6c/x8uyWIaXrtSQK3icLtr7cUecLzqN8DPUKzKn8kKTwf+gYXm2LqTGzEuXrEXwlKRt6t2jFBYtlHg1hUCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mINC7JQYB+oV7cJqQ1wf4AuI85OlHmPDaQYk4DMYbDw=;
 b=tUcozseu51/vyLeEdpHCUUnx9tdcOoj3YbOXTJaTZKtdDhHabtI5sG1hgwg2S2aIfJocDz+uM/Bot5U7StfdwozMNXVnYCmcUS06V6KDIBox1i1haMRG6058RJIO4PCFtxMk3mxt0JYhPI8Dr1ZpZnFEaBgWygCm7XCc6Ukq+QlPHnwVUJ+myK3TfgsjrtpI6fDKl1IVqWtPI4CuuFhKyvhcgNde1zjaRWGX7nlSx0uprT6MEgzwJCsUdJSJTIXtYV9kirpBEI5/CS6gSJ7Anhe4ohHCR5N5kMECT8A98fcPnT54oxM/vF/4ha85Of0x+ITFnqX/s8wxj0e4XIFibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB6715.namprd11.prod.outlook.com (2603:10b6:303:20e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Sat, 30 Nov
 2024 07:40:33 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8207.014; Sat, 30 Nov 2024
 07:40:33 +0000
Date: Sat, 30 Nov 2024 15:40:22 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [timekeeping]  82214756d3:
 stress-ng.clock.ops_per_sec 28.8% improvement
Message-ID: <202411301531.f512e533-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: d104d4e4-2cdb-4348-c332-08dd11124538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?f94VOzdUVnVcf3xJx90D90tfS5Q4ZK8QrvfBR5gphErfDGPDO/1nWgodrC?=
 =?iso-8859-1?Q?pxHsItNBhzB0TFcmrRBWE//x+3xTrA3tisLnIRcD/yV96s4jghOuFfbh81?=
 =?iso-8859-1?Q?O7GbRRe7N3XIzWW+R6ggwbPicSAtgYqzTHmwvXAv3L9LRzK84B135DeNjq?=
 =?iso-8859-1?Q?ftSqw2CiO82H0sELPI5CtfH7rghSyRjq93RLMa7ENUc3zL5DQm+4tyGsHE?=
 =?iso-8859-1?Q?eC994YhFlgy56/+SlFMhOe6nDK29NrpzTXBOmwNrF2EkvtARSmw0jD4bhZ?=
 =?iso-8859-1?Q?6mNcJYshTxOuHxp6dej5wrdTFMhT8Q5fC3FDzwNRMl1JLu6s2AxpfUISrV?=
 =?iso-8859-1?Q?XrhFZlmLhfdLTO3fM5aPJPyAKunFBuEalfAKIJXKRuCXGLofjOk4KzunRV?=
 =?iso-8859-1?Q?+8TOlAHHQvrqOUYD+fwuaXNKb+kIsdjctI3u00cKS8ZuxBwT4u3w/KKKaS?=
 =?iso-8859-1?Q?8ivGciNZH3YNeKvYxGEnLsvtFl2Yc1mfunMrr61Hl09EbZFOcJcOGPfKcr?=
 =?iso-8859-1?Q?jWY2RdU3CMDbuLcFXEPQ240YdEG4HbFtNkaPSXg+oQWkxLr6jCgJPg87fN?=
 =?iso-8859-1?Q?eelB5cJDgoMFaB4YRsxTeqo9mEZ5c+ZfPepXgC2IA8/lz2JfsSkrmel6OP?=
 =?iso-8859-1?Q?dNfKHAHAnUSNAECOA4vNdlVs+zNFEavPnpYHyAb/m6p1ERffbB3cI5caoL?=
 =?iso-8859-1?Q?rDWV6tgCfcpfoL9B7wmhFCT6mFdRbB+TiW3REXId14g9wgYjpifAS4x0mR?=
 =?iso-8859-1?Q?SwbHc1F8uQy5vQeuE3Bucp8ZIFHVFLM6eyDJ/3+h+VIbiLQ4gXpW1aCMUw?=
 =?iso-8859-1?Q?EXovUMxVxJAItgidn55BM55KwhVY1qwhya0higev/opjqdie9K77ux2w03?=
 =?iso-8859-1?Q?MkBDGakK81pTweo7wNXLzoWPDxLZ8vLCpVy0e9Uwx00JzFsHuxCwPc/NJV?=
 =?iso-8859-1?Q?8PljBbnPLvN4TU5KwqZx8gYq/gQICrkhSv+27UOkX5/XFnBVzBa0te/oj7?=
 =?iso-8859-1?Q?GNn+NIej25UklYVqfv1BY6tpbMZjR3uumEhAT27YcejqBdwOlZsg9akRZf?=
 =?iso-8859-1?Q?NECSevlmZ4AVRwvn0VLPyUewTkHUj2ZxDqUwm7KhLJt9ISZiVMjpAZe0pQ?=
 =?iso-8859-1?Q?H3NdifeSOKI/H669pkvsDzbuUf8cSRi1XbG+GwCAtYqUm/bkDlL+8s4Rn3?=
 =?iso-8859-1?Q?5C2zZsC26Zuq5j1S47dzcaxEr+yP/cXK913qH58ceKrwws0Mu35KF3v8X8?=
 =?iso-8859-1?Q?wayeU69pDZ7nAMfFvnMJCkMLcgVvYPjtP+bCca3bjeTiWrqW3m99eNoW3q?=
 =?iso-8859-1?Q?Ae4eZjipgi4wIFlXm5N2dVjKDv+nthqX/fYmFKKNRnNcsfv9kHHiG8EyQX?=
 =?iso-8859-1?Q?I89fSxifEg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Hv30Wnj6Cg4qZnmoemqBoMLl6iUiDm9Q14Rmc+zu44kTkZnodi2EeeWQs9?=
 =?iso-8859-1?Q?KS/wuHNqb/EIc1R+ci+xT4PSQmSHlmG4d1C2g7MgGIGT1D/pUnyOdbGdoc?=
 =?iso-8859-1?Q?eG/hlgeY9fYHF5J1Sv7H45uta5l8yIS6yf6XDVtGTeLlyxeXiGQq7+P7q9?=
 =?iso-8859-1?Q?gJhYJVo3Dlg0FbIOUFpKLO1i9jpEVy4zFZJMd2S30Dzs3y9XLsCco9BQlH?=
 =?iso-8859-1?Q?sykv1gANDBDHTbE6N1gFEdcc8s+FWUfkSt5RiLQVJwPAhD9IBfhuLlgQfo?=
 =?iso-8859-1?Q?6/BRbJgH0G+0e1PFtsAFvehyTLSV+ts548umlzlkjfpZMuTcMKKrDegHtG?=
 =?iso-8859-1?Q?AjGZDMopkuUltiKLN2YP1WWmFlt3Iqzt1NQ3HP4SVNlDGagxSAzxfAhJsN?=
 =?iso-8859-1?Q?TdJQIR/P3Qo5iK5DgP7lpnsvno3WUTm1QBcXolC5r6sqijAmWQ6Ri60Dz1?=
 =?iso-8859-1?Q?nltEmTeMoNcFte6JNqwGBwvUQH08BZFxqpGTz1k6+LWDbPVSMZYsp88l4m?=
 =?iso-8859-1?Q?/wie3rxj1TySA7gG0ChVWIhU9We9aFEQ6OH01VriorskBlYPda0yRTKROy?=
 =?iso-8859-1?Q?cOJbfijiRXc84FrmYPaWdxkz8rBDOMttcUcorpZCVkTZs/27N6xrMrMogX?=
 =?iso-8859-1?Q?2lWNf/DDyYuH++wkcujPy22KnVKbjB68xSwwjdSJO3hb6vdCQY/9afgNSg?=
 =?iso-8859-1?Q?c+RNrsSdfoMvR2YGR0hQtVE8bucz4CrYij9nCiVKTpMviyFEdbymfJ5EKJ?=
 =?iso-8859-1?Q?ySmyOr4xWCe58csUhbRKY1RK2eocL+MXFTgzKs4xsvphxX7msvjdg0qPj9?=
 =?iso-8859-1?Q?Jx1W8SumkGFQkCI50J2jWEaKroQUf5d5HyeDYzxZI86q9wApL4XyrDFUSF?=
 =?iso-8859-1?Q?ZjH7K2kZmtGJoePcOJtrfVVXNIisaVnyljP1kYpC08cLBnJfkLRb6hAY10?=
 =?iso-8859-1?Q?IRb7IPjftR7PMCiUFsgqsnxGX27nPtvvLmZRsAFhLeKtz2ypPVZrkYnVV8?=
 =?iso-8859-1?Q?Crc03RxR7rieA1Sw0t+zzEn5dpWK1WmCe8456KsdQ+OeKixmr9spCMXqvO?=
 =?iso-8859-1?Q?j0EyYxYyyjuViSvJHU5M4Go/DE3WnTS4gEoIOsFJx2d3Naa49RXt30QgyX?=
 =?iso-8859-1?Q?aXnUIY8E+61GEUPam1xP65meB7XeTNBVfh2HJcqZm6qwQdYgX8z3ZM77YC?=
 =?iso-8859-1?Q?X23JY/osQkYMc4VFITMyzWw6zY0iFQcPQG8jW+UWU6v0AV2OiPzdkM2Z9z?=
 =?iso-8859-1?Q?kCtCkF4pJU5NwGS9Vyh4UMrv4hKFZBY/nKHsCIQtB5WHDyBGC5RiXyviBL?=
 =?iso-8859-1?Q?LpQM/yYfKGwEMn5nnvgz8OKLPz+jaxVtV0o2lz/+UEq+yqHoWSshK6PJE6?=
 =?iso-8859-1?Q?46Gh59O2YDbabm0OPGcNs4DBYGzo2keqFtyGVTj04Qq13Qqqi1iIOhsSDl?=
 =?iso-8859-1?Q?Rd99nQ0R0pKWIYF7Krhh1Toe0uZTln6VlMDJIwPFrUYno88sHTNZ4cS8za?=
 =?iso-8859-1?Q?MvySZEreiOU1LP7VPecCk/Y7yyts1ybmDxwuyt3iW1qOPXx3neJINVNdfe?=
 =?iso-8859-1?Q?daHWN5oQt/HZBAZ/2Tro3ytrjMXizx/BVBzn0InvGQ7fMiqpoMQ9OEYq6v?=
 =?iso-8859-1?Q?SnnvRcuZoxGzyhKzWJr6ZKB0bRdiwghw0RCfAHnI/DFCqF5C7PY/sXfQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d104d4e4-2cdb-4348-c332-08dd11124538
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 07:40:33.0529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ik9veYbiabfvWZtDkjkWks/cuksYnJLF46DU4FOhTCxjMz6hPCgKlB9T1bdQYZNgOimHZarbjocHUzsN1yBzFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6715
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 28.8% improvement of stress-ng.clock.ops_per_sec on:


commit: 82214756d35f48056fe36aa4d95a22e44a3b2619 ("timekeeping: Rework timekeeping_inject_offset() to use shadow_timekeeper")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: stress-ng
config: x86_64-rhel-8.3
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: clock
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241130/202411301531.f512e533-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/clock/stress-ng/60s

commit: 
  bba9898ef3 ("timekeeping: Rework do_settimeofday64() to use shadow_timekeeper")
  82214756d3 ("timekeeping: Rework timekeeping_inject_offset() to use shadow_timekeeper")

bba9898ef399667b 82214756d35f48056fe36aa4d95 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      3067           +12.8%       3460        uptime.idle
 1.056e+09 ±  3%     +37.3%  1.449e+09        cpuidle..time
   7772160           +49.3%   11600856 ±  2%  cpuidle..usage
     25.91 ±  3%     +10.0       35.96        mpstat.cpu.all.idle%
      3.06            -0.6        2.44 ±  3%  mpstat.cpu.all.irq%
     69.09            -9.6       59.47        mpstat.cpu.all.sys%
   2012634 ±  7%     +33.1%    2678130 ±  5%  numa-meminfo.node1.Active
   2012617 ±  7%     +33.1%    2678106 ±  5%  numa-meminfo.node1.Active(anon)
   2071058 ±  7%     +32.5%    2743264 ±  6%  numa-meminfo.node1.Shmem
    597595 ±  7%     +19.2%     712550 ± 11%  numa-numastat.node0.local_node
   1280160 ±  3%     +27.1%    1627483 ±  5%  numa-numastat.node1.local_node
   1305030 ±  3%     +28.1%    1671677 ±  4%  numa-numastat.node1.numa_hit
     34795            -9.5%      31487        perf-c2c.DRAM.remote
     46924           -13.5%      40571        perf-c2c.HITM.local
     72215           -11.8%      63674        perf-c2c.HITM.total
     28.18 ±  3%     +34.5%      37.89        vmstat.cpu.id
     45.46           -12.4%      39.81 ±  3%  vmstat.procs.r
    835329           +31.9%    1101737        vmstat.system.cs
    601872           +23.0%     740296        vmstat.system.in
   2235678           +25.4%    2803044        meminfo.Active
   2235627           +25.4%    2802995        meminfo.Active(anon)
   5410792           +10.4%    5971765        meminfo.Cached
   3709764           +15.2%    4275228        meminfo.Committed_AS
    392866           +20.1%     471820        meminfo.Mapped
   2360321           +23.8%    2921290        meminfo.Shmem
    597194 ±  7%     +19.3%     712413 ± 11%  numa-vmstat.node0.numa_local
    502850 ±  7%     +33.2%     670045 ±  5%  numa-vmstat.node1.nr_active_anon
    517583 ±  7%     +32.6%     686453 ±  6%  numa-vmstat.node1.nr_shmem
    502850 ±  7%     +33.2%     670045 ±  5%  numa-vmstat.node1.nr_zone_active_anon
   1304611 ±  3%     +28.1%    1671220 ±  4%  numa-vmstat.node1.numa_hit
   1279740 ±  3%     +27.1%    1627027 ±  5%  numa-vmstat.node1.numa_local
  10192156           +28.8%   13127859        stress-ng.clock.ops
    169868           +28.8%     218795        stress-ng.clock.ops_per_sec
    130298           +14.2%     148738 ±  5%  stress-ng.time.involuntary_context_switches
      4434           -14.7%       3780        stress-ng.time.percent_of_cpu_this_job_got
      2638           -15.1%       2239        stress-ng.time.system_time
     25.28           +24.2%      31.40        stress-ng.time.user_time
  26252857           +30.7%   34325021        stress-ng.time.voluntary_context_switches
    559206           +25.4%     701106        proc-vmstat.nr_active_anon
   1353051           +10.4%    1493336        proc-vmstat.nr_file_pages
     98897           +20.0%     118656        proc-vmstat.nr_mapped
    590432           +23.8%     730716        proc-vmstat.nr_shmem
     24899            +2.0%      25391        proc-vmstat.nr_slab_reclaimable
    559206           +25.4%     701106        proc-vmstat.nr_zone_active_anon
   1945504           +23.8%    2407643        proc-vmstat.numa_hit
   1879297           +24.6%    2341423        proc-vmstat.numa_local
    153996 ±  2%      -5.6%     145449 ±  2%  proc-vmstat.pgactivate
   2869847           +32.2%    3793437 ±  2%  proc-vmstat.pgalloc_normal
   2009378           +36.1%    2735053 ±  2%  proc-vmstat.pgfree
   7757806 ±  7%     +65.7%   12857728 ± 15%  sched_debug.cfs_rq:/.avg_vruntime.avg
  21364416 ± 14%     +46.0%   31192087 ± 17%  sched_debug.cfs_rq:/.avg_vruntime.max
   3975477 ± 13%     +51.5%    6023669 ± 22%  sched_debug.cfs_rq:/.avg_vruntime.stddev
   7757806 ±  7%     +65.7%   12857728 ± 15%  sched_debug.cfs_rq:/.min_vruntime.avg
  21364416 ± 14%     +46.0%   31192087 ± 17%  sched_debug.cfs_rq:/.min_vruntime.max
   3975477 ± 13%     +51.5%    6023669 ± 22%  sched_debug.cfs_rq:/.min_vruntime.stddev
    589.25 ±  2%      -8.6%     538.40 ±  2%  sched_debug.cfs_rq:/.runnable_avg.avg
    587.66 ±  2%      -8.7%     536.70 ±  2%  sched_debug.cfs_rq:/.util_avg.avg
     19320 ± 11%     -51.2%       9422 ± 82%  sched_debug.cpu.max_idle_balance_cost.stddev
    409578           +30.4%     534187        sched_debug.cpu.nr_switches.avg
    438354 ±  2%     +30.9%     574016        sched_debug.cpu.nr_switches.max
    360095           +33.2%     479705 ±  2%  sched_debug.cpu.nr_switches.min
    -35.08           +29.2%     -45.33        sched_debug.cpu.nr_uninterruptible.min
      1.97           +22.7%       2.42 ±  2%  perf-stat.i.MPKI
  9.89e+09            +3.2%  1.021e+10        perf-stat.i.branch-instructions
      0.84            +0.1        0.92 ±  2%  perf-stat.i.branch-miss-rate%
  82669640           +12.5%   93033480        perf-stat.i.branch-misses
     30.86            +1.7       32.52        perf-stat.i.cache-miss-rate%
  93692203           +25.1%  1.172e+08 ±  2%  perf-stat.i.cache-misses
 3.029e+08           +18.7%  3.596e+08 ±  2%  perf-stat.i.cache-references
    870393           +31.2%    1141692        perf-stat.i.context-switches
      3.71           -15.6%       3.13        perf-stat.i.cpi
 1.749e+11           -13.7%   1.51e+11        perf-stat.i.cpu-cycles
      2987           +12.7%       3366 ±  2%  perf-stat.i.cpu-migrations
      1872           -30.9%       1293 ±  2%  perf-stat.i.cycles-between-cache-misses
 4.756e+10            +2.7%  4.885e+10        perf-stat.i.instructions
      0.28           +18.0%       0.33        perf-stat.i.ipc
     13.63           +30.9%      17.84        perf-stat.i.metric.K/sec
      1.97           +21.7%       2.40 ±  2%  perf-stat.overall.MPKI
      0.83            +0.1        0.91 ±  2%  perf-stat.overall.branch-miss-rate%
     30.90            +1.7       32.57        perf-stat.overall.cache-miss-rate%
      3.68           -16.0%       3.09        perf-stat.overall.cpi
      1867           -30.9%       1290 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.27           +19.0%       0.32        perf-stat.overall.ipc
 9.712e+09            +3.0%  1.001e+10        perf-stat.ps.branch-instructions
  80944599           +12.5%   91101993        perf-stat.ps.branch-misses
  92074969           +24.8%  1.149e+08 ±  2%  perf-stat.ps.cache-misses
 2.979e+08           +18.5%  3.529e+08 ±  2%  perf-stat.ps.cache-references
    855366           +30.9%    1119872        perf-stat.ps.context-switches
  1.72e+11           -13.8%  1.482e+11        perf-stat.ps.cpu-cycles
      2938           +12.4%       3303 ±  2%  perf-stat.ps.cpu-migrations
 4.671e+10            +2.6%   4.79e+10        perf-stat.ps.instructions
  2.89e+12            +1.7%   2.94e+12        perf-stat.total.instructions
      0.01 ± 28%     -36.7%       0.00 ± 11%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.simple_recursive_removal.debugfs_remove.ptp_release
      0.01 ± 17%     -37.5%       0.00 ± 14%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.start_creating.part.0
      0.01 ± 33%     -47.4%       0.00 ± 14%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.simple_recursive_removal.debugfs_remove.ptp_release
      0.00 ± 11%     -25.9%       0.00 ± 14%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc.d_alloc_parallel
      0.00 ± 11%     -33.3%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.alloc_inode.new_inode.__debugfs_create_file
      0.00 ±  7%     -37.9%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.do_timer_create.__x64_sys_timer_create.do_syscall_64
      0.01 ± 34%     -38.7%       0.00 ± 11%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.security_file_alloc.init_file.alloc_empty_file
      0.00 ± 14%     -31.0%       0.00 ± 14%  perf-sched.sch_delay.avg.ms.__cond_resched.shrink_dcache_parent.d_invalidate.simple_recursive_removal.debugfs_remove
      0.09 ± 43%     -67.3%       0.03 ± 47%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01           -33.3%       0.00        perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ±  4%     -36.2%       0.01        perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep_timens.__x64_sys_clock_nanosleep
      0.03 ± 25%     -26.2%       0.02 ± 15%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.00           -33.3%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.simple_recursive_removal
      0.00           -38.9%       0.00 ± 20%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.start_creating.part
      0.02 ±  9%     -18.3%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ±  5%     -18.2%       0.01        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01           -30.6%       0.00 ±  8%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.02 ±  2%     -20.0%       0.01 ±  3%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.42 ± 27%     -32.5%       0.28 ±  2%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_node_noprof.alloc_cpumask_var_node.clock_was_set.timekeeping_inject_offset
      0.20 ± 74%     -58.8%       0.08 ±129%  perf-sched.sch_delay.max.ms.__cond_resched.dput.simple_recursive_removal.debugfs_remove.ptp_release
      0.02 ± 22%     -58.3%       0.01 ± 22%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_lru_noprof.alloc_inode.new_inode.__debugfs_create_file
      0.01 ± 22%     -45.2%       0.01 ± 19%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.do_timer_create.__x64_sys_timer_create.do_syscall_64
      0.36 ±  6%     -31.4%       0.24 ± 41%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.32 ± 34%     -67.2%       0.10 ± 76%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.35 ±  8%     -20.5%       0.28 ±  7%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      0.01 ±  6%     -35.1%       0.00        perf-sched.total_sch_delay.average.ms
      0.60           -20.9%       0.48        perf-sched.total_wait_and_delay.average.ms
   1969020           +28.8%    2536194        perf-sched.total_wait_and_delay.count.ms
      0.60           -20.7%       0.47        perf-sched.total_wait_time.average.ms
      0.02 ±  2%     -34.7%       0.01 ±  2%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep_timens.__x64_sys_clock_nanosleep
     39.25 ±  3%     -19.7%      31.53        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     41.11 ±  2%     -21.3%      32.36        perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    829752           +27.5%    1057785        perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    821797           +27.6%    1048633        perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep_timens.__x64_sys_clock_nanosleep
    130785 ±  3%     +40.0%     183127        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.simple_recursive_removal
    149550 ±  3%     +35.1%     201968 ±  2%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.start_creating.part
     15608 ±  3%     +25.9%      19649        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      8725           +23.9%      10806        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     72.18 ± 26%     -38.1%      44.67 ± 17%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±  8%     -27.7%       0.01 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.__dentry_kill.dput.debugfs_remove.ptp_release
      0.01 ±  6%     -22.2%       0.01 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_cpumask_var_node.clock_was_set.timekeeping_inject_offset
      0.01 ± 10%     -28.8%       0.01 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.get_clock_desc.pc_clock_gettime.__x64_sys_clock_gettime
      0.01 ± 16%     -30.2%       0.01 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.simple_recursive_removal.debugfs_remove.ptp_release
      0.01 ± 20%     -40.3%       0.01 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.dput.simple_recursive_removal.debugfs_remove.ptp_release
      0.01 ± 24%     -35.1%       0.01 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.01 ±  7%     -25.0%       0.01        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.alloc_inode.new_inode.__debugfs_create_file
      0.01 ±  6%     -20.5%       0.01 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.do_timer_create.__x64_sys_timer_create.do_syscall_64
      0.01 ± 17%     -27.1%       0.01 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.getname_flags.part.0
      0.01 ±  7%     -28.3%       0.01 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.shrink_dcache_parent.d_invalidate.simple_recursive_removal.debugfs_remove
      0.01           -33.3%       0.01        perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep_timens.__x64_sys_clock_nanosleep
      0.06 ±  3%     +11.6%       0.07 ±  2%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.start_creating.part
     39.24 ±  3%     -19.7%      31.52        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     41.09 ±  2%     -21.3%      32.35        perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ± 12%     -36.9%       0.01 ± 21%  perf-sched.wait_time.max.ms.__cond_resched.__dentry_kill.dput.debugfs_remove.ptp_release
      0.42 ± 27%     -32.9%       0.28 ±  2%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_node_noprof.alloc_cpumask_var_node.clock_was_set.timekeeping_inject_offset
      0.20 ± 74%     -57.5%       0.08 ±121%  perf-sched.wait_time.max.ms.__cond_resched.dput.simple_recursive_removal.debugfs_remove.ptp_release
      0.02 ± 17%     -36.4%       0.01 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_lru_noprof.alloc_inode.new_inode.__debugfs_create_file
      0.02 ± 15%     -36.0%       0.01 ± 16%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.do_timer_create.__x64_sys_timer_create.do_syscall_64
      0.02 ± 37%     -43.4%       0.01 ± 25%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.security_file_alloc.init_file.alloc_empty_file
     72.15 ± 26%     -38.1%      44.65 ± 17%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     27.27            -2.4       24.90 ±  4%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.simple_recursive_removal
     27.27            -2.4       24.92 ±  4%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.start_creating
     28.18            -2.3       25.93 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.simple_recursive_removal.debugfs_remove
     28.17            -2.2       25.94 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.start_creating.debugfs_create_dir
     28.49            -2.2       26.28 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.simple_recursive_removal.debugfs_remove.ptp_release
     28.54            -2.2       26.35 ±  4%  perf-profile.calltrace.cycles-pp.down_write.simple_recursive_removal.debugfs_remove.ptp_release.posix_clock_release
     28.48            -2.2       26.30 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.start_creating.debugfs_create_dir.ptp_open
     28.59            -2.1       26.46 ±  3%  perf-profile.calltrace.cycles-pp.down_write.start_creating.debugfs_create_dir.ptp_open.posix_clock_open
     28.90            -1.9       26.97 ±  3%  perf-profile.calltrace.cycles-pp.start_creating.debugfs_create_dir.ptp_open.posix_clock_open.chrdev_open
     31.47            -1.9       29.54 ±  3%  perf-profile.calltrace.cycles-pp.simple_recursive_removal.debugfs_remove.ptp_release.posix_clock_release.__fput
     29.79            -1.9       27.88 ±  3%  perf-profile.calltrace.cycles-pp.debugfs_create_dir.ptp_open.posix_clock_open.chrdev_open.do_dentry_open
     30.89            -1.7       29.15 ±  3%  perf-profile.calltrace.cycles-pp.ptp_open.posix_clock_open.chrdev_open.do_dentry_open.vfs_open
     31.85            -1.7       30.12 ±  3%  perf-profile.calltrace.cycles-pp.debugfs_remove.ptp_release.posix_clock_release.__fput.__x64_sys_close
     31.00            -1.7       29.32 ±  3%  perf-profile.calltrace.cycles-pp.posix_clock_open.chrdev_open.do_dentry_open.vfs_open.do_open
      8.52            -1.7        6.84 ±  7%  perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.clock_was_set.timekeeping_inject_offset.do_adjtimex.__do_sys_clock_adjtime
     31.07            -1.6       29.42 ±  3%  perf-profile.calltrace.cycles-pp.chrdev_open.do_dentry_open.vfs_open.do_open.path_openat
     31.10            -1.6       29.46 ±  3%  perf-profile.calltrace.cycles-pp.do_dentry_open.vfs_open.do_open.path_openat.do_filp_open
     31.11            -1.6       29.48 ±  3%  perf-profile.calltrace.cycles-pp.vfs_open.do_open.path_openat.do_filp_open.do_sys_openat2
     31.20            -1.6       29.61 ±  3%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
     32.31            -1.4       30.88 ±  2%  perf-profile.calltrace.cycles-pp.ptp_release.posix_clock_release.__fput.__x64_sys_close.do_syscall_64
     32.38            -1.4       31.00 ±  2%  perf-profile.calltrace.cycles-pp.posix_clock_release.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     32.48            -1.3       31.13 ±  2%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     32.52            -1.3       31.19 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     32.55            -1.3       31.23 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     32.55            -1.3       31.23 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
     32.58            -1.3       31.29 ±  2%  perf-profile.calltrace.cycles-pp.__close
     31.65            -1.2       30.41 ±  2%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
     31.66            -1.2       30.42 ±  2%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     31.72            -1.2       30.51 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     31.71            -1.2       30.50 ±  2%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     31.74            -1.2       30.55 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     31.75            -1.2       30.55 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
     31.80            -1.2       30.62 ±  2%  perf-profile.calltrace.cycles-pp.open64
      1.29            -0.7        0.63 ±  6%  perf-profile.calltrace.cycles-pp.inode_set_ctime_current.simple_recursive_removal.debugfs_remove.ptp_release.posix_clock_release
      1.28            -0.7        0.62 ±  6%  perf-profile.calltrace.cycles-pp.ktime_get_coarse_real_ts64.inode_set_ctime_current.simple_recursive_removal.debugfs_remove.ptp_release
      3.11            -0.6        2.52 ±  5%  perf-profile.calltrace.cycles-pp.__x64_sys_clock_gettime.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      1.92            -0.4        1.50 ±  9%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.clock_was_set.timekeeping_inject_offset.do_adjtimex
      3.51            -0.4        3.11 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      3.57            -0.4        3.20 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
      0.56            -0.3        0.27 ±100%  perf-profile.calltrace.cycles-pp.enqueue_dl_entity.dl_server_start.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
      0.56            -0.3        0.27 ±100%  perf-profile.calltrace.cycles-pp.dl_server_start.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup
      0.72            -0.3        0.45 ± 44%  perf-profile.calltrace.cycles-pp.__x64_sys_timer_gettime.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_gettime
      1.82            -0.3        1.54 ±  7%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch
      1.84            -0.3        1.58 ±  7%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule
      1.89            -0.2        1.64 ±  7%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule.schedule_idle
      0.85            -0.2        0.62 ±  4%  perf-profile.calltrace.cycles-pp.do_timer_settime.__x64_sys_timer_settime.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_settime
      2.06            -0.2        1.83 ±  6%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      1.97            -0.2        1.75 ±  7%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule.schedule_idle.do_idle
      0.92            -0.2        0.71 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_timer_settime.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_settime
      0.94            -0.2        0.74 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.timer_settime
      0.93            -0.2        0.73 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_settime
      0.75            -0.2        0.56 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_gettime
      0.75            -0.2        0.56 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.timer_gettime
      1.00            -0.2        0.82 ±  4%  perf-profile.calltrace.cycles-pp.timer_settime
      0.82            -0.2        0.67 ±  4%  perf-profile.calltrace.cycles-pp.timer_gettime
      0.62 ±  2%      +0.1        0.70        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.80            +0.1        0.87 ±  5%  perf-profile.calltrace.cycles-pp.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1.22 ±  2%      +0.2        1.40        perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.78 ±  2%      +0.2        1.02        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      0.88            +0.3        1.14        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      0.60            +0.3        0.86 ±  4%  perf-profile.calltrace.cycles-pp.add_device_randomness.do_adjtimex.__do_sys_clock_adjtime.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.58            +0.3        0.86 ±  3%  perf-profile.calltrace.cycles-pp.do_timer_create.__x64_sys_timer_create.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_create
      0.62            +0.3        0.92 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_timer_create.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_create
      0.64            +0.3        0.95 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_create
      0.64            +0.3        0.95 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.timer_create
      0.72            +0.3        1.07 ±  3%  perf-profile.calltrace.cycles-pp.timer_create
      0.69            +0.4        1.12 ±  6%  perf-profile.calltrace.cycles-pp.mntput_no_expire.simple_recursive_removal.debugfs_remove.ptp_release.posix_clock_release
      0.86            +0.4        1.29 ±  2%  perf-profile.calltrace.cycles-pp.igb_rd32.igb_ptp_gettimex_82580.pc_clock_gettime.__x64_sys_clock_gettime.do_syscall_64
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.00            +0.5        0.52 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.timer_delete
      0.00            +0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.mnt_get_count.mntput_no_expire.simple_recursive_removal.debugfs_remove.ptp_release
      1.74 ±  2%      +0.6        2.31        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +0.6        0.57 ±  5%  perf-profile.calltrace.cycles-pp.mntput_no_expire.ptp_release.posix_clock_release.__fput.__x64_sys_close
      0.00            +0.6        0.61 ±  2%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.syscall
      0.00            +0.6        0.62 ±  3%  perf-profile.calltrace.cycles-pp.timer_delete
      1.87 ±  2%      +0.6        2.51        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      1.88 ±  2%      +0.6        2.52        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      5.08            +0.7        5.74 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      5.10            +0.7        5.77 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      5.10            +0.7        5.77 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      1.94 ±  2%      +0.7        2.62        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      5.18            +0.7        5.86 ±  2%  perf-profile.calltrace.cycles-pp.common_startup_64
      0.00            +0.7        0.69 ± 10%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.igb_ptp_gettimex_82580.pc_clock_gettime.__x64_sys_clock_gettime
      0.00            +0.7        0.74 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.igb_ptp_gettimex_82580.pc_clock_gettime.__x64_sys_clock_gettime.do_syscall_64
      1.26            +0.8        2.08 ±  4%  perf-profile.calltrace.cycles-pp.igb_ptp_gettimex_82580.pc_clock_gettime.__x64_sys_clock_gettime.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.33            +0.9        2.20 ±  4%  perf-profile.calltrace.cycles-pp.pc_clock_gettime.__x64_sys_clock_gettime.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_gettime
      1.34            +0.9        2.21 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_clock_gettime.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_gettime
      1.34            +0.9        2.22 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_gettime
      1.34            +0.9        2.22 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.clock_gettime
      1.37            +0.9        2.26 ±  4%  perf-profile.calltrace.cycles-pp.clock_gettime
      4.42            +1.0        5.41 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.clock_was_set.timekeeping_inject_offset.do_adjtimex.__do_sys_clock_adjtime
     54.55            -4.7       49.82 ±  4%  perf-profile.children.cycles-pp.osq_lock
     56.36            -4.5       51.87 ±  4%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
     56.97            -4.4       52.59 ±  4%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     57.20            -4.3       52.92 ±  4%  perf-profile.children.cycles-pp.down_write
      9.52            -2.1        7.45 ±  7%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
     31.47            -1.9       29.54 ±  3%  perf-profile.children.cycles-pp.simple_recursive_removal
     29.79            -1.9       27.88 ±  3%  perf-profile.children.cycles-pp.debugfs_create_dir
     92.38            -1.8       90.55        perf-profile.children.cycles-pp.do_syscall_64
     29.18            -1.8       27.40 ±  3%  perf-profile.children.cycles-pp.start_creating
     92.59            -1.7       90.84        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     30.89            -1.7       29.15 ±  3%  perf-profile.children.cycles-pp.ptp_open
     31.85            -1.7       30.12 ±  3%  perf-profile.children.cycles-pp.debugfs_remove
     31.00            -1.7       29.32 ±  3%  perf-profile.children.cycles-pp.posix_clock_open
     31.07            -1.6       29.42 ±  3%  perf-profile.children.cycles-pp.chrdev_open
     31.10            -1.6       29.47 ±  3%  perf-profile.children.cycles-pp.do_dentry_open
     31.11            -1.6       29.48 ±  3%  perf-profile.children.cycles-pp.vfs_open
     31.20            -1.6       29.61 ±  3%  perf-profile.children.cycles-pp.do_open
     32.31            -1.4       30.88 ±  2%  perf-profile.children.cycles-pp.ptp_release
     32.38            -1.4       31.00 ±  2%  perf-profile.children.cycles-pp.posix_clock_release
      4.10            -1.4        2.73 ±  5%  perf-profile.children.cycles-pp.ktime_get
     32.48            -1.3       31.13 ±  2%  perf-profile.children.cycles-pp.__fput
     32.52            -1.3       31.19 ±  2%  perf-profile.children.cycles-pp.__x64_sys_close
     32.59            -1.3       31.30 ±  2%  perf-profile.children.cycles-pp.__close
      2.57            -1.3        1.31 ±  6%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
     31.65            -1.2       30.42 ±  2%  perf-profile.children.cycles-pp.path_openat
     31.66            -1.2       30.43 ±  2%  perf-profile.children.cycles-pp.do_filp_open
     31.72            -1.2       30.52 ±  2%  perf-profile.children.cycles-pp.do_sys_openat2
     31.72            -1.2       30.52 ±  2%  perf-profile.children.cycles-pp.__x64_sys_openat
     31.80            -1.2       30.63 ±  2%  perf-profile.children.cycles-pp.open64
      2.11            -1.0        1.06 ±  6%  perf-profile.children.cycles-pp.inode_set_ctime_current
      0.82            -0.4        0.43 ±  5%  perf-profile.children.cycles-pp.simple_inode_init_ts
      0.79            -0.3        0.45 ±  6%  perf-profile.children.cycles-pp.ktime_get_real_ts64
      0.72            -0.3        0.42 ±  5%  perf-profile.children.cycles-pp.common_hrtimer_arm
      0.63            -0.3        0.33 ±  5%  perf-profile.children.cycles-pp.posix_get_realtime_timespec
      0.75            -0.3        0.47 ±  5%  perf-profile.children.cycles-pp.common_timer_set
      1.96            -0.3        1.70 ±  5%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      2.94            -0.3        2.68 ±  5%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.60            -0.2        0.35 ±  5%  perf-profile.children.cycles-pp.common_timer_get
      0.86            -0.2        0.62 ±  4%  perf-profile.children.cycles-pp.do_timer_settime
      2.98            -0.2        2.74 ±  5%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.68            -0.2        0.46 ±  5%  perf-profile.children.cycles-pp.do_timer_gettime
      0.92            -0.2        0.71 ±  4%  perf-profile.children.cycles-pp.__x64_sys_timer_settime
      2.20            -0.2        2.01 ±  6%  perf-profile.children.cycles-pp.finish_task_switch
      3.53            -0.2        3.33 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.73            -0.2        0.53 ±  4%  perf-profile.children.cycles-pp.__x64_sys_timer_gettime
      0.46            -0.2        0.27 ±  5%  perf-profile.children.cycles-pp.posix_get_realtime_coarse
      0.92            -0.2        0.74 ±  5%  perf-profile.children.cycles-pp.clockevents_program_event
      1.15            -0.2        0.98 ±  6%  perf-profile.children.cycles-pp.dl_server_stop
      1.01            -0.2        0.85 ±  4%  perf-profile.children.cycles-pp.timer_settime
      0.52            -0.2        0.35 ±  3%  perf-profile.children.cycles-pp.timekeeping_update
      0.84            -0.2        0.68 ±  6%  perf-profile.children.cycles-pp.ktime_get_with_offset
      0.84            -0.1        0.69 ±  4%  perf-profile.children.cycles-pp.timer_gettime
      0.83            -0.1        0.70 ±  5%  perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      0.54            -0.1        0.42 ±  5%  perf-profile.children.cycles-pp.posix_get_tai_timespec
      0.39            -0.1        0.30 ±  6%  perf-profile.children.cycles-pp.ktime_get_ts64
      1.09            -0.1        1.00 ±  5%  perf-profile.children.cycles-pp.enqueue_dl_entity
      0.87            -0.1        0.78 ±  6%  perf-profile.children.cycles-pp.start_dl_timer
      0.35 ±  2%      -0.1        0.26 ±  2%  perf-profile.children.cycles-pp.tick_irq_enter
      0.40            -0.1        0.32 ±  6%  perf-profile.children.cycles-pp.posix_get_monotonic_timespec
      0.36 ±  2%      -0.1        0.28        perf-profile.children.cycles-pp.irq_enter_rcu
      1.10            -0.1        1.01 ±  5%  perf-profile.children.cycles-pp.dl_server_start
      0.34            -0.1        0.29 ±  5%  perf-profile.children.cycles-pp.ktime_get_raw_ts64
      0.36            -0.0        0.31 ±  6%  perf-profile.children.cycles-pp.posix_get_monotonic_raw
      0.33 ±  2%      -0.0        0.30 ±  6%  perf-profile.children.cycles-pp.posix_get_boottime_timespec
      0.16 ±  2%      -0.0        0.13 ±  8%  perf-profile.children.cycles-pp.retrigger_next_event
      0.11 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.timekeeping_forward_now
      0.07 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.notifier_call_chain
      0.06 ±  8%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__do_adjtimex
      0.15 ±  4%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.05            +0.0        0.07        perf-profile.children.cycles-pp.__update_load_avg_se
      0.05            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.___perf_sw_event
      0.05            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.05            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.kobject_get
      0.05            +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.dentry_unlink_inode
      0.05            +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.native_apic_msr_eoi
      0.05            +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.security_file_alloc
      0.04 ± 44%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.update_cfs_group
      0.05            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.d_instantiate
      0.06 ±  9%      +0.0        0.08        perf-profile.children.cycles-pp.kmem_cache_free_bulk
      0.06 ±  9%      +0.0        0.08        perf-profile.children.cycles-pp.kvfree_call_rcu
      0.06 ±  9%      +0.0        0.08        perf-profile.children.cycles-pp.kvfree_rcu_bulk
      0.70            +0.0        0.72        perf-profile.children.cycles-pp.sysvec_call_function_single
      0.06 ±  8%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.fsnotify_grab_connector
      0.05            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.get_itimerspec64
      0.06 ±  9%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.kfree_rcu_work
      0.06 ±  6%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.process_one_work
      0.05            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.terminate_walk
      0.04 ± 44%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.04 ± 44%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.timerqueue_del
      0.05 ±  8%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.apparmor_capable
      0.06 ±  9%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.07            +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.task_rq_lock
      0.06 ±  6%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__switch_to_asm
      0.07 ±  7%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.05            +0.0        0.08 ±  7%  perf-profile.children.cycles-pp.do_dec_rlimit_put_ucounts
      0.05            +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.generic_permission
      0.05 ±  8%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.init_file
      0.06            +0.0        0.09 ±  6%  perf-profile.children.cycles-pp.fsnotify_destroy_marks
      0.06            +0.0        0.09 ±  6%  perf-profile.children.cycles-pp.security_capable
      0.09 ±  5%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.worker_thread
      0.06 ±  6%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.capable
      0.06            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.set_next_entity
      0.08            +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.hrtimer_active
      0.07 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.set_next_task_fair
      0.06 ±  9%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.kobject_put
      0.02 ± 99%      +0.0        0.06        perf-profile.children.cycles-pp.__x64_sys_clock_settime
      0.02 ± 99%      +0.0        0.06        perf-profile.children.cycles-pp.nohz_run_idle_balance
      0.07            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.sigqueue_free
      0.08            +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.07 ±  6%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.07 ±  7%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.thread_group_cputime
      0.08            +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__x64_sys_poll
      0.07 ±  6%      +0.0        0.11        perf-profile.children.cycles-pp.do_sys_poll
      0.07 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.posix_cpu_timer_set
      0.08 ±  4%      +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.08 ±  4%      +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.03 ± 70%      +0.0        0.07        perf-profile.children.cycles-pp.complete_walk
      0.03 ± 70%      +0.0        0.07        perf-profile.children.cycles-pp.try_to_unlazy
      0.02 ± 99%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__srcu_read_lock
      0.07            +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.cpu_clock_sample_group
      0.08            +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.timerqueue_add
      0.08 ±  6%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__switch_to
      0.08            +0.0        0.12        perf-profile.children.cycles-pp.prepare_task_switch
      0.08 ±  4%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.sched_clock
      0.14 ±  3%      +0.0        0.18 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.08 ±  4%      +0.0        0.12        perf-profile.children.cycles-pp.native_sched_clock
      0.08 ±  4%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__call_rcu_common
      0.09 ±  5%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__lock_timer
      0.06            +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__slab_free
      0.10            +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.x64_sys_call
      0.51            +0.0        0.55        perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.09            +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.d_invalidate
      0.10            +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.08 ±  5%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.sprintf
      0.10 ±  5%      +0.0        0.14 ±  7%  perf-profile.children.cycles-pp.sched_balance_rq
      0.02 ± 99%      +0.0        0.07 ±  8%  perf-profile.children.cycles-pp.timerfd_clock_was_set
      0.08            +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.vsnprintf
      0.08 ±  4%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.update_rq_clock
      0.09            +0.0        0.14 ±  5%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.09 ±  5%      +0.0        0.14        perf-profile.children.cycles-pp.sched_clock_cpu
      0.09            +0.0        0.14 ±  4%  perf-profile.children.cycles-pp.__d_alloc
      0.10            +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.__kmalloc_cache_noprof
      0.08 ±  6%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.wake_q_add
      0.06 ±  8%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.alloc_cpumask_var_node
      0.09 ±  5%      +0.0        0.14 ±  5%  perf-profile.children.cycles-pp.alloc_empty_file
      0.02 ± 99%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.12 ±  4%      +0.0        0.16 ±  5%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.39            +0.0        0.44 ±  6%  perf-profile.children.cycles-pp.smp_call_function_many_cond
      0.07 ±  5%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.inode_init_always
      0.11 ±  3%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.01 ±223%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.cpus_read_lock
      0.03 ± 70%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.get_clock_desc
      0.11            +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.mod_objcg_state
      0.02 ±141%      +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.llist_reverse_order
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.lookup_fast
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.rb_erase
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.resched_curr
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.security_inode_alloc
      0.06 ±  8%      +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.09 ±  4%      +0.1        0.14 ±  4%  perf-profile.children.cycles-pp.inc_rlimit_get_ucounts
      0.08 ±  4%      +0.1        0.13 ±  9%  perf-profile.children.cycles-pp.inode_permission
      0.10            +0.1        0.15 ±  2%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.posix_cpu_timer_get
      0.02 ±141%      +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.simple_lookup
      0.11 ±  7%      +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.poll_idle
      0.01 ±223%      +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.09 ±  5%      +0.1        0.14        perf-profile.children.cycles-pp.rwsem_mark_wake
      0.07 ±  5%      +0.1        0.12 ±  7%  perf-profile.children.cycles-pp.down_read
      0.08 ±  6%      +0.1        0.13 ±  4%  perf-profile.children.cycles-pp.__cond_resched
      0.10 ±  4%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.memset_orig
      0.12            +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.__remove_hrtimer
      0.08 ±  4%      +0.1        0.14 ±  6%  perf-profile.children.cycles-pp.lockref_get
      0.12 ±  3%      +0.1        0.18 ±  3%  perf-profile.children.cycles-pp.stress_clock
      0.13            +0.1        0.19 ±  4%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.clock_settime
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.update_fast_timekeeper
      0.01 ±223%      +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__legitimize_path
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.get_timespec64
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.memcg_list_lru_alloc
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.put_itimerspec64
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.do_poll
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.idle_cpu
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.menu_select
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.01 ±223%      +0.1        0.07 ±  8%  perf-profile.children.cycles-pp.up_read
      0.16 ±  2%      +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.update_curr
      0.13 ±  3%      +0.1        0.20 ±  4%  perf-profile.children.cycles-pp.timer_getoverrun
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.pc_clock_getres
      0.13 ±  3%      +0.1        0.19        perf-profile.children.cycles-pp.__poll
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__d_add
      0.13 ±  2%      +0.1        0.19 ±  7%  perf-profile.children.cycles-pp.__destroy_inode
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.get_nohz_timer_target
      0.13 ±  5%      +0.1        0.20 ±  7%  perf-profile.children.cycles-pp.destroy_inode
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.___slab_alloc
      0.16 ±  2%      +0.1        0.23 ±  3%  perf-profile.children.cycles-pp.update_load_avg
      0.12 ±  4%      +0.1        0.19 ±  5%  perf-profile.children.cycles-pp.lockref_put_return
      0.14 ±  2%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.__sigqueue_alloc
      0.15 ±  3%      +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.d_alloc
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.__kmalloc_node_noprof
      0.07 ±  5%      +0.1        0.15 ± 20%  perf-profile.children.cycles-pp.osq_unlock
      0.00            +0.1        0.08 ±  9%  perf-profile.children.cycles-pp.lookup_mnt
      0.06            +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.step_into
      0.15            +0.1        0.23 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru_noprof
      0.31            +0.1        0.39        perf-profile.children.cycles-pp.__irq_exit_rcu
      0.17 ±  2%      +0.1        0.25 ±  2%  perf-profile.children.cycles-pp.enqueue_entity
      0.15            +0.1        0.23 ±  4%  perf-profile.children.cycles-pp.kthread
      0.20            +0.1        0.28 ±  3%  perf-profile.children.cycles-pp.cpu_clock_sample
      0.16 ±  3%      +0.1        0.25 ±  3%  perf-profile.children.cycles-pp.__x64_sys_clock_getres
      0.15            +0.1        0.24 ±  5%  perf-profile.children.cycles-pp.ret_from_fork
      0.15            +0.1        0.24 ±  5%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.10 ±  3%      +0.1        0.19 ±  7%  perf-profile.children.cycles-pp.link_path_walk
      0.15 ±  5%      +0.1        0.24 ±  4%  perf-profile.children.cycles-pp.alloc_inode
      0.17 ±  2%      +0.1        0.26 ±  4%  perf-profile.children.cycles-pp.evict
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.__traverse_mounts
      0.20 ±  2%      +0.1        0.30 ±  3%  perf-profile.children.cycles-pp._find_next_bit
      0.23            +0.1        0.33 ±  3%  perf-profile.children.cycles-pp.posix_cpu_clock_get
      0.22 ±  2%      +0.1        0.32 ±  5%  perf-profile.children.cycles-pp.posix_timer_unhash_and_free
      0.20            +0.1        0.30 ±  4%  perf-profile.children.cycles-pp.put_timespec64
      0.17 ±  2%      +0.1        0.27 ±  4%  perf-profile.children.cycles-pp.rcu_do_batch
      0.24 ±  2%      +0.1        0.34 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.22            +0.1        0.32 ±  3%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.22 ±  2%      +0.1        0.33 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
      0.20            +0.1        0.30 ±  3%  perf-profile.children.cycles-pp.rcu_core
      0.40            +0.1        0.50 ±  4%  perf-profile.children.cycles-pp.wake_up_q
      1.72            +0.1        1.83 ±  4%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.20            +0.1        0.31 ±  2%  perf-profile.children.cycles-pp._copy_from_user
      0.32            +0.1        0.42 ±  2%  perf-profile.children.cycles-pp.handle_softirqs
      0.25            +0.1        0.36 ±  3%  perf-profile.children.cycles-pp.task_sched_runtime
      0.22 ±  2%      +0.1        0.33 ±  3%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.26 ±  2%      +0.1        0.37 ±  3%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.20 ±  2%      +0.1        0.32 ±  4%  perf-profile.children.cycles-pp.kmem_cache_free
      1.08            +0.1        1.19 ±  5%  perf-profile.children.cycles-pp.hrtimer_wakeup
      0.23            +0.1        0.34 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.22 ±  2%      +0.1        0.35 ±  5%  perf-profile.children.cycles-pp.new_inode
      0.24 ±  2%      +0.1        0.37 ±  4%  perf-profile.children.cycles-pp._copy_to_user
      0.25            +0.1        0.38 ±  3%  perf-profile.children.cycles-pp.blake2s_compress
      0.18 ±  5%      +0.1        0.31 ± 10%  perf-profile.children.cycles-pp.simple_release_fs
      0.26            +0.1        0.40 ±  3%  perf-profile.children.cycles-pp.__lookup_slow
      1.41            +0.1        1.56 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.30            +0.1        0.44 ±  2%  perf-profile.children.cycles-pp.blake2s_update
      0.31            +0.2        0.46 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.34            +0.2        0.50 ±  4%  perf-profile.children.cycles-pp.__x64_sys_timer_delete
      0.18            +0.2        0.34 ±  6%  perf-profile.children.cycles-pp.path_init
      0.55            +0.2        0.72 ±  3%  perf-profile.children.cycles-pp.rwsem_wake
      0.37 ±  2%      +0.2        0.56 ±  2%  perf-profile.children.cycles-pp.lookup_one_len
      0.22            +0.2        0.40 ±  7%  perf-profile.children.cycles-pp.simple_pin_fs
      0.44            +0.2        0.64 ±  3%  perf-profile.children.cycles-pp.timer_delete
      0.40 ±  2%      +0.2        0.60 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.46            +0.2        1.66 ±  5%  perf-profile.children.cycles-pp.try_to_wake_up
      0.42            +0.2        0.63 ±  3%  perf-profile.children.cycles-pp.read_tsc
      0.64            +0.2        0.88        perf-profile.children.cycles-pp.up_write
      1.02            +0.3        1.27        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.50            +0.3        0.76 ±  3%  perf-profile.children.cycles-pp.__dentry_kill
      0.60            +0.3        0.86 ±  4%  perf-profile.children.cycles-pp.add_device_randomness
      0.55            +0.3        0.82 ±  3%  perf-profile.children.cycles-pp.mnt_get_count
      0.58            +0.3        0.86 ±  3%  perf-profile.children.cycles-pp.do_timer_create
      0.62            +0.3        0.92 ±  2%  perf-profile.children.cycles-pp.__x64_sys_timer_create
      0.64            +0.3        0.99 ±  4%  perf-profile.children.cycles-pp.dput
      0.78            +0.3        1.13        perf-profile.children.cycles-pp.clear_bhb_loop
      0.74            +0.4        1.09 ±  3%  perf-profile.children.cycles-pp.timer_create
      0.86            +0.4        1.29 ±  2%  perf-profile.children.cycles-pp.igb_rd32
      0.00            +0.5        0.47 ±  3%  perf-profile.children.cycles-pp.timekeeping_update_from_shadow
      1.77 ±  2%      +0.6        2.34        perf-profile.children.cycles-pp.acpi_safe_halt
      1.77            +0.6        2.34        perf-profile.children.cycles-pp.acpi_idle_enter
      1.90 ±  2%      +0.6        2.55        perf-profile.children.cycles-pp.cpuidle_enter_state
      1.91 ±  2%      +0.6        2.56        perf-profile.children.cycles-pp.cpuidle_enter
      1.05            +0.6        1.70 ±  5%  perf-profile.children.cycles-pp.mntput_no_expire
      5.10            +0.7        5.77 ±  2%  perf-profile.children.cycles-pp.start_secondary
      5.17            +0.7        5.85 ±  2%  perf-profile.children.cycles-pp.do_idle
      5.18            +0.7        5.86 ±  2%  perf-profile.children.cycles-pp.common_startup_64
      5.18            +0.7        5.86 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
      1.98 ±  2%      +0.7        2.66        perf-profile.children.cycles-pp.cpuidle_idle_call
      1.26            +0.8        2.08 ±  5%  perf-profile.children.cycles-pp.igb_ptp_gettimex_82580
      1.33            +0.9        2.20 ±  4%  perf-profile.children.cycles-pp.pc_clock_gettime
      1.37            +0.9        2.26 ±  4%  perf-profile.children.cycles-pp.clock_gettime
      1.70            +1.0        2.69 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock
      7.58            +1.5        9.06 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     54.17            -4.6       49.53 ±  4%  perf-profile.self.cycles-pp.osq_lock
      9.23            -2.2        7.02 ±  7%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      4.02            -1.4        2.61 ±  5%  perf-profile.self.cycles-pp.ktime_get
      2.55            -1.2        1.30 ±  6%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.76            -0.3        0.43 ±  5%  perf-profile.self.cycles-pp.ktime_get_real_ts64
      0.82            -0.2        0.65 ±  6%  perf-profile.self.cycles-pp.ktime_get_with_offset
      0.14 ±  3%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.timekeeping_inject_offset
      0.38            -0.1        0.28 ±  6%  perf-profile.self.cycles-pp.ktime_get_ts64
      0.33            -0.1        0.28 ±  5%  perf-profile.self.cycles-pp.ktime_get_raw_ts64
      0.11            -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.timekeeping_forward_now
      0.05 ±  7%      +0.0        0.07 ±  8%  perf-profile.self.cycles-pp.__do_adjtimex
      0.05 ±  8%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__lock_timer
      0.05            +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.kobject_get
      0.04 ± 44%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.05            +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.generic_permission
      0.05            +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.kmem_cache_free
      0.05            +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.native_apic_msr_eoi
      0.05            +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.update_curr
      0.06 ±  6%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.update_load_avg
      0.05            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__x64_sys_clock_gettime
      0.05            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.do_dec_rlimit_put_ucounts
      0.06 ±  9%      +0.0        0.08 ±  7%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.06            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.clock_adjtime
      0.07 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.06 ±  8%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__switch_to_asm
      0.05            +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.apparmor_capable
      0.07 ±  6%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.07 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.07            +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.try_to_wake_up
      0.05            +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.timerqueue_add
      0.06 ±  9%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.kobject_put
      0.07            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.d_alloc_parallel
      0.09            +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.x64_sys_call
      0.08 ±  6%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.native_sched_clock
      0.08 ±  5%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.08 ±  6%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.__switch_to
      0.08 ±  6%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.hrtimer_active
      0.06            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.06            +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.__slab_free
      0.10            +0.0        0.14 ±  4%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.09 ±  5%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.08 ±  5%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.09            +0.0        0.13 ±  5%  perf-profile.self.cycles-pp.mod_objcg_state
      0.10            +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.02 ±141%      +0.0        0.06        perf-profile.self.cycles-pp.update_cfs_group
      0.11 ±  3%      +0.0        0.16 ±  5%  perf-profile.self.cycles-pp.finish_task_switch
      0.09 ±  4%      +0.0        0.14 ±  4%  perf-profile.self.cycles-pp.stress_clock
      0.10            +0.0        0.15 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.02 ± 99%      +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.09 ±  5%      +0.0        0.14 ± 11%  perf-profile.self.cycles-pp.__destroy_inode
      0.06 ±  7%      +0.1        0.11 ±  8%  perf-profile.self.cycles-pp.down_read
      0.09            +0.1        0.14 ±  4%  perf-profile.self.cycles-pp.inc_rlimit_get_ucounts
      0.08 ±  6%      +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.wake_q_add
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__call_rcu_common
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__x64_sys_clock_getres
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.blake2s_update
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.dequeue_entity
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.llist_reverse_order
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.resched_curr
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.update_rq_clock
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.__kmalloc_node_noprof
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.inode_init_always
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.07 ±  5%      +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.__do_sys_clock_adjtime
      0.01 ±223%      +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.02 ±141%      +0.1        0.07        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.do_adjtimex
      0.01 ±223%      +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.__srcu_read_lock
      0.08 ±  4%      +0.1        0.14 ±  5%  perf-profile.self.cycles-pp.lockref_get
      0.10 ±  3%      +0.1        0.16 ±  4%  perf-profile.self.cycles-pp.memset_orig
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.ptp_open
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.update_fast_timekeeper
      0.12 ±  3%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.___perf_sw_event
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.__hrtimer_start_range_ns
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.enqueue_entity
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.enqueue_task_fair
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.kvfree_call_rcu
      0.13 ±  3%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.__schedule
      0.02 ± 99%      +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.__cond_resched
      0.11 ±  3%      +0.1        0.17 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.01 ±223%      +0.1        0.07        perf-profile.self.cycles-pp.hrtimer_start_range_ns
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.09 ± 10%      +0.1        0.15 ± 10%  perf-profile.self.cycles-pp.up_write
      0.00            +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.lookup_mnt
      0.08 ±  5%      +0.1        0.15 ±  4%  perf-profile.self.cycles-pp.mntput_no_expire
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.up_read
      0.12 ±  4%      +0.1        0.18 ±  6%  perf-profile.self.cycles-pp.lockref_put_return
      0.16            +0.1        0.23 ±  3%  perf-profile.self.cycles-pp.do_timer_create
      0.07 ±  5%      +0.1        0.14 ± 19%  perf-profile.self.cycles-pp.osq_unlock
      0.15            +0.1        0.22 ±  3%  perf-profile.self.cycles-pp._find_next_bit
      0.20 ±  2%      +0.1        0.29 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.18 ±  2%      +0.1        0.27 ±  3%  perf-profile.self.cycles-pp.do_syscall_64
      0.22            +0.1        0.32 ± 14%  perf-profile.self.cycles-pp.down_write
      0.21 ±  2%      +0.1        0.31 ±  3%  perf-profile.self.cycles-pp.syscall
      0.19            +0.1        0.29 ±  2%  perf-profile.self.cycles-pp._copy_from_user
      0.00            +0.1        0.12        perf-profile.self.cycles-pp.timekeeping_update_from_shadow
      0.24            +0.1        0.36 ±  4%  perf-profile.self.cycles-pp._copy_to_user
      0.25            +0.1        0.38 ±  3%  perf-profile.self.cycles-pp.blake2s_compress
      0.30            +0.1        0.44 ±  2%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.16            +0.1        0.31 ±  5%  perf-profile.self.cycles-pp.path_init
      0.41            +0.2        0.61 ±  3%  perf-profile.self.cycles-pp.read_tsc
      0.44            +0.2        0.65 ±  2%  perf-profile.self.cycles-pp.mnt_get_count
      0.77            +0.3        1.11        perf-profile.self.cycles-pp.clear_bhb_loop
      0.58 ±  2%      +0.4        1.01 ±  2%  perf-profile.self.cycles-pp.acpi_safe_halt
      0.86            +0.4        1.29 ±  2%  perf-profile.self.cycles-pp.igb_rd32
      1.04            +0.4        1.48 ±  3%  perf-profile.self.cycles-pp.clock_was_set
      0.86            +0.5        1.32 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      3.26            +1.8        5.06 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



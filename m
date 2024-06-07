Return-Path: <linux-kernel+bounces-205256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C37498FFA0C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4272E1F24A45
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 02:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4438182D8;
	Fri,  7 Jun 2024 02:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mo5pbH7M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F44A171BB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 02:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717727915; cv=fail; b=pZV2A9kYELuBN8mGgzeykbWgq/b/MVm6em0J9VonOEzHrYXxjQ2NaF6GnlhtCrCdmufZl1LXfxr5gfG90BGLpj0sAtoGVXmlD+n3gPFpO8mH/f8ppVoVF1xM0M3qbedvSvdOwY7U23uJSJCVsjcs8HO400FzQflYZQ9YU0O0Eb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717727915; c=relaxed/simple;
	bh=L/wjGgyHphkTRBBPz/6FBdKPq1XDt5bnBd18l+VwxPY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RJmRNE0DG2QsmNO+Kw38V3j4GQrKbH5WzUyxVpqLAbCbNae0RlCdetVRXzUMHM+YFy28xTcFWW6Q6nj/x6b62lfQaO+tGjRavcly067qpRq45zNfuTDrA51/YgH4yZFjdUKjEVGgGAMwL+mCbib1xhLoRlURRNqnGb1JwFq+n0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mo5pbH7M; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717727914; x=1749263914;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=L/wjGgyHphkTRBBPz/6FBdKPq1XDt5bnBd18l+VwxPY=;
  b=mo5pbH7M/h2aSXzOcDZv/UtI8cAgMOxsl5Vw9qHov5/V1PD8XkfFi+1A
   MnrWoQ7nzf7o2zGY+VnD3euOm4X1I0FravmxIp3wlx0gKHw1eQUjmivqY
   HLMpIgkqkrROkPJKLRf7tJSGf5ZjhfOFgokdJCZQdKT7sYORAFzXvf3Ik
   gPhsQfBpkqXx4Uvfh+8m8qfPBfyC1Aoqno7eJv1/DWRvO0O958mpoYH1S
   EtXTkfFARh2vTRKhJD05fT3DQFNbL349m0eZojrOlFs1EYDUvUdEDpMF2
   Hn3aCGnAGlNY2tbHNwlnjw9q2Z+YE3kWyxnc60zuTINPxN5tYC5Iq69If
   g==;
X-CSE-ConnectionGUID: 4fAWjv+ASta/uSxSruAM/g==
X-CSE-MsgGUID: M4drsVUXTuGgUvEi+O/laQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="18284505"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="18284505"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 19:38:33 -0700
X-CSE-ConnectionGUID: D46ikauhToiAMQtG34ZsJg==
X-CSE-MsgGUID: 730f0VnrTKS9hBmLMvhTyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="42747760"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Jun 2024 19:38:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 19:38:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 6 Jun 2024 19:38:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Jun 2024 19:38:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8suw0URFaaSU+EQd2gPHKOqsrHPKy3y198XPK4qylExVebQlfM+equeG4uJeu+t+oY74ZTiR0mXlK5xkY1tmKdmE3U+HS/NlK0VG75ZtD76NlEwyVUIZYb0nAi8xHdV3aTc4inXMkJ0/I8S5UKavCGAcMdKvqzayr48TU2zRL1a1TJU4boozyrKw2LR7hF8AGsBnF66FPV2msFqk683FVILi76n3LXCmecy5gGeqK8k+nuZXslMVKAeawytROirMYjx8zAYFQPSubsTEUJGOnoSwAK4iPO2nQjwuOqNqkIbi0J199KcOjTII+ka135zejYDxhrxNj3UAM/Se/EZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdGk5xPTPPp35QZpfHnBHte+Vgg8h/Nlt4UBpxcgRP8=;
 b=jrFWJUJXL7HgBKhOQQdNG6i/djTDwCsW42W7BNUTec5uM7moSl56GZ9LtKiHTVxHsIM54AhgqGHvFaYAn1n7H8QtzYjR+OQmOye2IKGVqdrOT6Sqh7Ytj1/KDUmGvRcmmlzalcPdvATKTqzKxHnSf2H+ZzQ1MJuBLHqhqmvIxuyjwr/ggi0f5S5cDDXztA7prYrhWqvSq7ydZ0SH2zxvjSHqZ9cOWg1he3DBRjn/bPP6shk8f4Q/V3KU+CprYCRrEe+BAxBcIrc7ey0p/JAC/ip6CvOAuVXDkhl+++AnN+9S0QhC0oPU2So1Fyd1PJy2mzZbPXNuAhPvSctt4xmbow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SN7PR11MB6993.namprd11.prod.outlook.com (2603:10b6:806:2ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 7 Jun
 2024 02:38:29 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 02:38:29 +0000
Date: Fri, 7 Jun 2024 10:38:14 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Chunxin Zang <spring.cxz@gmail.com>
CC: K Prateek Nayak <kprateek.nayak@amd.com>, <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<yangchen11@lixiang.com>, Jerry Zhou <zhouchunhua@lixiang.com>, Chunxin Zang
	<zangchunxin@lixiang.com>, Balakumaran Kannan <kumaran.4353@gmail.com>, "Mike
 Galbraith" <efault@gmx.de>
Subject: Re: [PATCH] sched/fair: Reschedule the cfs_rq when current is
 ineligible
Message-ID: <ZmJylkNFg7EFgPmZ@chenyu5-mobl2>
References: <20240524134011.270861-1-spring.cxz@gmail.com>
 <ZlCyhDspcZQhxlNk@chenyu5-mobl2>
 <06649B84-DA1D-4360-B0C4-79C81A34BC08@gmail.com>
 <cf8fdb86-194b-34c4-f5e8-dd7ddc56d8d9@amd.com>
 <ZmCeBwNO2t2ikrcm@chenyu5-mobl2>
 <CF70ED2D-2566-4CA7-A9BB-E8536F353797@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CF70ED2D-2566-4CA7-A9BB-E8536F353797@gmail.com>
X-ClientProxiedBy: SGBP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::18)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SN7PR11MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: b21a7952-3aba-4d63-0e56-08dc869aea31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGJyYlM1eE9ReGMvUmgwK0VGaTdtbC9scUhYd0RLdlZLQXZicy8rS2NubTZ6?=
 =?utf-8?B?dWl1NmJMaUtlT3E4ZDEva3BwS2QrM2YyNmVzbHdRT3JRNktwazFaL21OUmpM?=
 =?utf-8?B?Z05KSmVNT3krWURMcTFRZEdBcjYvRjd0THIzTk1TdGhydGRDZlpsZzNLWFM5?=
 =?utf-8?B?cUJvcFBsVGRnTjk0QjBpdzN6RzcvNUdNNTJ3Y0R0R2tuVXcxWVY0a2Z6WUZ0?=
 =?utf-8?B?dXA1VWVTRW1VRnUvL0RQUlNKTm16MG5QTTFiR0xMQTJxRDlIc0lqZ1ZqNlBQ?=
 =?utf-8?B?TDVDdHZXeUE3K2Nrd0xRVGtnbmJKZUJYUTVVR3V1czBPekI4SGFMWHNaeFZo?=
 =?utf-8?B?WXUvNEpaYVhnSTBhQWs5Y21ZZWhaZ01Najk1WDZMSFU2ZWZRTCs4VHgxSkV0?=
 =?utf-8?B?dGhFai8wVHhCa1poT0pkcFB0Zi84V2YwVGFac0QzNE9zYzRyK1VMK1lyMVBu?=
 =?utf-8?B?YkVZR1doRkpDcmt2d2hPa0lkZzhKUkx4ajV1TlEydVZpKzlxeG9VbCtJMFoz?=
 =?utf-8?B?YTNHcnFNbnM0WVVIWUtJbmZoTjB1MnlLbkFFWU9EcDBXQWVDZUdEcnVCOHZB?=
 =?utf-8?B?SDI3QUpjQnpQa3RDL0NWUy9Dcld6c2l1NGFmVGdkNVIwcjlTbVNBRzFqVWVo?=
 =?utf-8?B?K2Rxc2dzWUZnZ2I2YTUvbFlib3o3dVhhc0tVWWFyRUY3L0RwY2ZPL0lHVVdj?=
 =?utf-8?B?QzJEOUc1aUhvdEsrcjhtUkIwaXJVUkFGc2dwc09yQUcrS0drZjkzVWRSZExN?=
 =?utf-8?B?blFLVTVpTmN2T1dqYTU2MWF4WHhBbXVqODdqTWJ5a2V5c1kwRmlVOHQxS3Y5?=
 =?utf-8?B?ZHF6aXcraDUrYzZJdVhVb0N3ZDRGQmVpMi9PWVprWVBYMXd1Mm1MeHpnd2Zo?=
 =?utf-8?B?OG9iS2hOV28rWkZCVDJoWmtJYXo0WXhsbUZuQjQvYnh3QnEyakZpbkVPei95?=
 =?utf-8?B?cTJSZFpNRVFmYktSZ0k4Z0lEOHFVaDBJK0hpcWV3UHRaYW0wZ05lb2JHZ21t?=
 =?utf-8?B?amgyUHI0ZFpWUnBZUkJaUGlvLzVaUDdaOWtweVFBKzdhUnRqTGt3UFM1ZmxB?=
 =?utf-8?B?NmRSYXF2Z1MzWDBEK1k1eXdxME0zQTVUMmY3QWtXcE50YkZ0akpZbHpQSVF5?=
 =?utf-8?B?endPdHhRVXFzU0x1c05SaUQ4eGtPU0RUV0s5bGU3RzkzNjltY2FUbjI4QjVm?=
 =?utf-8?B?dEIwSERhaTIyME5KWW1YQk5ESHhuRjVtWmk0UXF3dG1WQ1BzbG5sU2xmbzVp?=
 =?utf-8?B?czY3cmdkV0hEMnJONXF1MjFleU4zTDIrbDlKSnNlS1hwMUxQeHpHVWl1cmt6?=
 =?utf-8?B?QzlOVmRWOGpiYms4bVdvY1Fna0o0bnVJZlJ5dnBvMzFFNHhwbllyczlQQ015?=
 =?utf-8?B?K05FN3dKdk14ZVcrNnFtSUxaOEFVWlB3S3BQWk9xbXUvckN1S0VOa3dxWjBV?=
 =?utf-8?B?L042K2g2d2FXcmQyT2dDSUF6SWk1TTN1L01nb01YekRBWTMzamJ4V3hHbzd4?=
 =?utf-8?B?cEE2dzI1OCtab3FBNGo0b3AyVFphbjVlalhOQVRtWGwvQm40NWtRNmxBa0s1?=
 =?utf-8?B?eVliQ1hoTnFvSFpPVXlwMzZIaG12MGJTaDBJZVdrZ25IOGlPbndmRlJnVHJk?=
 =?utf-8?B?Sm84TWFuQmQ5WHkyaVpKT0lSbHBzVS83QW5tUUduNEtxMGZuZi9lS1NiTWF3?=
 =?utf-8?B?Ykk3VzNxUGtUZTRITGxab2g4N0JkMVg5eXhjdGxzeGlrMGlsc1ZZdW5FKzFV?=
 =?utf-8?Q?jhJeCeGSzzqxLF+/9tPR1h7Iotjv4Yh/CkGcHUK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0d6MmhUT0N1UURGMWhqazg2MGdCMmtSVDlBRmpIQTV5ZkE5cGdHcENwN0Fs?=
 =?utf-8?B?bXRiYmY0aG92Nmk5N2M0VjdXOEY2aTdaalJyMDZFdjdSUFdZR1hhV0xvdXhp?=
 =?utf-8?B?VkNkT0YvNVplMStoc05QelpxbTlna0NLQlRScC9iNlRFK0lwSGtYMUtQL3dG?=
 =?utf-8?B?VXE5MStqUE84WFJtZzlOdlIyS2IvTHdJZlhwOWRRMjVwTURBSWl5aUMyOHhM?=
 =?utf-8?B?V0dXWGhGTXZHZEFxU0E4MnQvUmNRU1VTUUpnUHJFaityUE5mUXE3OTZ3Qis2?=
 =?utf-8?B?ZzRJNDNaanNzMmVnN1lRYXFrQXZZMVF5S2FIWXhoM0djMGovdGw1bnFHSVVG?=
 =?utf-8?B?YWllWlhVSWFCeEVXKzVVL0FvYjlCbk92SjNmeldRd0RJdjJoVDQwVzduVXlH?=
 =?utf-8?B?aTJ4OC8xVEZZM3JtWGZtZkFVd2dDSG04WW4zcmtWVzcwVGZFMDJkcmVvQXY1?=
 =?utf-8?B?N3ZhUi9qc1MwQis1eWJ2Q2x1TEJMZnpKbmhGekprSXlRQ1dZUGl0bkV2L291?=
 =?utf-8?B?Zmd4NmFiOWt5UHdrRy9aY0hrWXczM3p3bTlEOStvR0J2OTZCTkd3bVV0L2Iw?=
 =?utf-8?B?M0xEcW9QNWEzU2Y1dk9DQWNCSWZ0dVJGbWU5VXJoKzV4MTlIdlhiQVJlY0xq?=
 =?utf-8?B?SUl6amRCemdWV1NrbVNYdE1nSHhCMWVNK1NEc3lVN0RKbnFxa0pwQ3I0dkdq?=
 =?utf-8?B?em9iZVRmYXlIYWVZZmhSYzZOcEx4V0c1Y2pjdHR3ZHN6a2V3d0U3Mk1WNWQ3?=
 =?utf-8?B?N0phOXpFN0I4UWowTkE5Tk9yRXNIQkVpTG4wQmpITDdXQkVrSXVQTjlEVXkx?=
 =?utf-8?B?R3JxT1lEb2pldUdxb1AyUUR5R3FQSzh6UEZGeDlzUWg4TWNSTU51b3lYMVpN?=
 =?utf-8?B?ZWZaSUVtSmZsY3BxRjFmbWo4RXI2UUVjZS83MUF4NVdzcUJFOHpDZ3RWd3hY?=
 =?utf-8?B?ZTZwbFgzNTJwMWpkekN3a2pySG5URUFlRW1FbXR0dUlKZmR4a1U4SVdoa2tR?=
 =?utf-8?B?b0VmWjY4Yk9uK2xVR2hUcVFzM0dTQzNaZkFaYnNtdGJMNEMrdFE2ZmtIcE1Y?=
 =?utf-8?B?TTU4VFByNmtDZTFXdC8zb3hNN0RLYWYwZWtBYmVkYzZ4UUVjZlFoRUhIQ3Nm?=
 =?utf-8?B?ektIS3hpMmpVSTcrc0kzTXV2OHZpYWVuWE1odmNpWHUvQlRPcUlRVTRMZERY?=
 =?utf-8?B?YWxQL0ExaUFZVXJJY1lPTjZFRE5PN1c2U1gwNFlKaEVBNFVTamhrblBXYkhm?=
 =?utf-8?B?YU90MmF0NFFBTk5VUUl1OXpsV2IyT2tLcDJnSTdjbUVqaDVWNTZLZC82eVov?=
 =?utf-8?B?bW82SkdDQk9XZGJ2RWsrTGZXdWlBSlQyMXIwWmVnNG05eHdaZ0ZZVS9kR2FI?=
 =?utf-8?B?Z1BTUG9xSXhibVR5aHRTSnlVRGNVSkcyekJEcGhrdmNLMjFkVzdkbTMvRFBX?=
 =?utf-8?B?NkZ5dTcrTkhUV3RwTW9tYmM3RHFqdzZZQysyMktZMU0vNXFWUXViKzUwaWFZ?=
 =?utf-8?B?dHc0UmZrZmVpVTNqZnFCQ1lFdXBJcFdzTGVFVlVIZFJGK1E0bFFoYUJsYjJO?=
 =?utf-8?B?VmNJcHZTSDdEUkIvSEdWS2xxQTBPOWp4L1Rkb0JOaEo3aW5PUFdDMjNhNXpU?=
 =?utf-8?B?YmtDdGRxRGc3M2hocHh4akpmalI4MjFPL0Z6L014QmpRK0JEOXJudUxUTlJx?=
 =?utf-8?B?V2RhSmFhYkJ2b1NiOTUranQ1L0JiQnI5bEVuVnRyRHNVVkxUWE5NQ2hTdnd6?=
 =?utf-8?B?ZFpscjYzai9FM25CTzNkU3FkbWpOaDRkVjRPK24vQXJjcDhTZTIvTUY0eDRG?=
 =?utf-8?B?clZHcWFJVG0wanY4WEZVSmRIeCt4VVltZTBzM3gxZ2twOGFDbWJsZnZ5cFlp?=
 =?utf-8?B?MzZobFdMb1BoejJQSVZ3Zk5MaEZ2cXRZcEVDb0RkNW1HcFo5L21kMUJYMk1V?=
 =?utf-8?B?ZFBwWWJSYlQ0VDRaU05ldk1tV2ZCWlNtbzRLZEp2WlBxdkFjSkc2UFg0alNW?=
 =?utf-8?B?L092QndOREJpbVF5Mlk4Vm01ajNYN3pFVStJb1IzVUpVTm0zK1hFaFNHaG5z?=
 =?utf-8?B?d3dFVWpTc0dqdFBRZ3lmeUxmQTNkWXRuOWl6WUlJR2g5VmVmOTlOOGRYVm9l?=
 =?utf-8?Q?k+/a8I2l7l83uRXRNPJiXCqMm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b21a7952-3aba-4d63-0e56-08dc869aea31
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 02:38:29.4425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wp6xhFDT01SUmsFBHBomOnuzhBkxHOiRoh+0X+QfTVCQyNoMCXCh/2nzP3CiUldHWuAFEXPQz3xgcDOy6WxhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6993
X-OriginatorOrg: intel.com

On 2024-06-06 at 09:46:53 +0800, Chunxin Zang wrote:
> 
> 
> > On Jun 6, 2024, at 01:19, Chen Yu <yu.c.chen@intel.com> wrote:
> > 
> > 
> > Sorry for the late reply and thanks for help clarify this. Yes, this is
> > what my previous concern was:
> > 1. It does not consider the cgroup and does not check preemption in the same
> >   level which is covered by find_matching_se().
> > 2. The if (!entity_eligible(cfs_rq, se)) for current is redundant because
> >   later pick_eevdf() will check the eligible of current anyway. But
> >   as pointed out by Chunxi, his concern is the double-traverse of the rb-tree,
> >   I just wonder if we could leverage the cfs_rq->next to store the next
> >   candidate, so it can be picked directly in the 2nd pick as a fast path?
> >   Something like below untested:
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 8a5b1ae0aa55..f716646d595e 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8349,7 +8349,7 @@ static void set_next_buddy(struct sched_entity *se)
> > static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int wake_flags)
> > {
> >        struct task_struct *curr = rq->curr;
> > -       struct sched_entity *se = &curr->se, *pse = &p->se;
> > +       struct sched_entity *se = &curr->se, *pse = &p->se, *next;
> >        struct cfs_rq *cfs_rq = task_cfs_rq(curr);
> >        int cse_is_idle, pse_is_idle;
> > 
> > @@ -8415,7 +8415,11 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
> >        /*
> >         * XXX pick_eevdf(cfs_rq) != se ?
> >         */
> > -       if (pick_eevdf(cfs_rq) == pse)
> > +       next = pick_eevdf(cfs_rq);
> > +       if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && next)
> > +               set_next_buddy(next);
> > +
> > +       if (next == pse)
> >                goto preempt;
> > 
> >        return;
> > 
> > 
> > thanks,
> > Chenyu
> 
> Hi Chen
> 
> First of all, thank you for your patient response. Regarding the issue of avoiding traversing
> the RB-tree twice, I initially had two methods in mind. 
> 1. Cache the optimal result so that it can be used directly during the second pick_eevdf operation.
>   This idea is similar to the one you proposed this time. 
> 2. Avoid the pick_eevdf operation as much as possible within 'check_preempt_wakeup_fair.' 
>   Because I believe that 'checking whether preemption is necessary' and 'finding the optimal
>   process to schedule' are two different things.

I agree, and it seems that in current eevdf implementation the former relies on the latter.

> 'check_preempt_wakeup_fair' is not just to
>   check if the newly awakened process should preempt the current process; it can also serve
>   as an opportunity to check whether any other processes should preempt the current one,
>   thereby improving the real-time performance of the scheduler. Although now in pick_eevdf,
>   the legitimacy of 'curr' is also evaluated, if the result returned is not the awakened process,
>   then the current process will still not be preempted.

I thought Mike has proposed a patch to deal with this scenario you mentioned above:
https://lore.kernel.org/lkml/e17d3d90440997b970067fe9eaf088903c65f41d.camel@gmx.de/

And I suppose you are refering to increase the preemption chance on current rather than reducing
the invoke of pick_eevdf() in check_preempt_wakeup_fair().

> Therefore, I posted the v2 PATCH. 
>   The implementation of v2 PATCH might express this point more clearly. 
> https://lore.kernel.org/lkml/20240529141806.16029-1-spring.cxz@gmail.com/T/
>

Let me take a look at it and do some tests.
 
> I previously implemented and tested both of these methods, and the test results showed that
> method 2 had somewhat more obvious benefits. Therefore, I submitted method 2. Now that I
> think about it, perhaps method 1 could also be viable at the same time. :)
>

Actually I found that, even without any changes, if we enabled sched feature NEXT_BUDDY, the
wakeup latency/request latency are both reduced. The following is the schbench result on a
240 CPUs system:

NO_NEXT_BUDDY
Wakeup Latencies percentiles (usec) runtime 100 (s) (1698990 total samples)
        50.0th: 6          (429125 samples)
        90.0th: 14         (682355 samples)
      * 99.0th: 29         (126695 samples)
        99.9th: 529        (14603 samples)
        min=1, max=4741
Request Latencies percentiles (usec) runtime 100 (s) (1702523 total samples)
        50.0th: 14992      (550939 samples)
        90.0th: 15376      (668687 samples)
      * 99.0th: 15600      (128111 samples)
        99.9th: 15888      (11238 samples)
        min=3528, max=31677
RPS percentiles (requests) runtime 100 (s) (101 total samples)
        20.0th: 16864      (31 samples)
      * 50.0th: 16928      (26 samples)
        90.0th: 17248      (36 samples)
        min=16615, max=20041
average rps: 17025.23

NEXT_BUDDY
Wakeup Latencies percentiles (usec) runtime 100 (s) (1653564 total samples)
        50.0th: 5          (376845 samples)
        90.0th: 12         (632075 samples)
      * 99.0th: 24         (114398 samples)
        99.9th: 105        (13737 samples)
        min=1, max=7428
Request Latencies percentiles (usec) runtime 100 (s) (1657268 total samples)
        50.0th: 14480      (524763 samples)
        90.0th: 15216      (647982 samples)
      * 99.0th: 15472      (130730 samples)
        99.9th: 15728      (13980 samples)
        min=3542, max=34805
RPS percentiles (requests) runtime 100 (s) (101 total samples)
        20.0th: 16544      (62 samples)
      * 50.0th: 16544      (0 samples)
        90.0th: 16608      (37 samples)
        min=16470, max=16648
average rps: 16572.68

So I think NEXT_BUDDY has more or less reduced the rb-tree scan.

thanks,
Chenyu


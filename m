Return-Path: <linux-kernel+bounces-214336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C233C9082DF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 06:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E68A1F22EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 04:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D0A146597;
	Fri, 14 Jun 2024 04:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdJfB2Ao"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3190D26AF1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 04:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718338476; cv=fail; b=jp3bqaElDo06bQnXPsvFBD65F5XjQhSwDj9gG971hNNrXe/Ky+ZPVNTWNYwdu/oID1u5Zh62+U8Xer3U+91fgtqtzxjHKaABL3KaUm5fOXoiN+ujvGjdB1G1Mojbf6v1xOEowJPJR7uiq1zJTbpObaSbK9/+HhvzWSci4nwX5KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718338476; c=relaxed/simple;
	bh=zKiVsMBWOC4nVaIRC48LldFibJBdlLuaTk9Z1sFGSgc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gXUZAWvNiW064Hn5olmAK5dQHg76N4Q5Br0zBX7D1lS6wcpEaBws5mvxdEbIdc9pGX+C79A8S0yQpNNdPoaUhSUwQL5xNc1spmGJP6hk2p+1cVzRWt1MiOau6+ioVYOlv1jFIQpy92QG8ohgH+b+a5aKW9vGXY665OpvMlTOyG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdJfB2Ao; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718338475; x=1749874475;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=zKiVsMBWOC4nVaIRC48LldFibJBdlLuaTk9Z1sFGSgc=;
  b=MdJfB2Ao1FhHMKQzaSImJz+owFPbgEnKjuwP1GEz2XeLsqR6sO1AAS0H
   8z6LviBIS2VJLf79SWeXPY0YNXdGPBhtpCmqG71cbfEopjs47//t0DazW
   k8tayuGiCQTTknMRkOPPQKRnRlw+NPMZkqKiwciA7DDDK/yjlHR97+XXv
   2Xjk+EoHfuY/TQ1lqaBXsy5ICBicLDntYc+rtxzTU6hvpPnk8oNQm1fZe
   4DNoEoMur6SFzcuKOjsODxxn2SyotIA/yB7KzpGSHh85ge1vyYeDjb1Jy
   hHpM8gYQuX2Wf69+LFu4LsQ64Ep183rXTrOGWtVlRIQjuwrp3NPZDUATx
   Q==;
X-CSE-ConnectionGUID: NXSAoyFVTWeoB0iOuNucCA==
X-CSE-MsgGUID: WOoc4kgpSp+4geFMrNF1HQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="40620525"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40620525"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 21:14:33 -0700
X-CSE-ConnectionGUID: MaiAOFtqRrqkYNvU5GD/LA==
X-CSE-MsgGUID: Ec002ki5SsWO8JzjeKFPXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="45289701"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 21:14:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 21:14:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 21:14:32 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 21:14:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAvU/OH0toRDyrGrjRkjvZJjhKPgDJfdo7fcVqqP8M0nQeZhrJGK4urAO+H/P2SLWEtEccSmqGaB3UenuUyr/9VvfBQWmabRUm1IFc0KHWLVmPAIQY95dNkZlYiM/+4G1wsMeJYqePtTGL+FqPnIG/OOR1HVn+QPsyhS66qpFF7ePk2eTy/p0li2y5c2PKOrJ6K8TEceUAQfDbx96BXbgqUnQxINNqNcguJ3ZgbSwk4mG23yDJVN/WcVSINukR8iFaZm/8yEAmAe0ARfBqonktrKl8gEAW9CsYvg+GbTo5HMInjnEAde0LQsLnCzivaxO1KL1CIyI6eNYgm+GrHC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1ELH2sJi0ZbSTSTjbsl1RXtW7OR0JR0TdUDGoVhR1E=;
 b=U/IGoU4umHceX3ISTN5Q1x8sTajwosQVyRo+alkY7HsX2u2U2k8to1INgW+hh2W1gVV8QRFDY1SzDWQWctyJCNZsLUIuX5rJoPU5JGNLsS2zHwaFKxG+djjtJD2FrgpfpzoJ9Nj1WG/OSKfasQVBOZxvBrvIbaXXWfgblk2Nzg5ggLmFg+DMkc17dvX55PE/Di8C63zpQhQiqrB5VzLuV8/vQcUStAJRA669qy/de90vi76IRuMgFv2J8RJIShzf65JZ9E80X7e6ZyrHHm5WHBf+V3k6tETNP2qvTQt0D7eL02UgRFg2/iYs4AwXq8lAlcGhQpnI4px9rHo5L5l7Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS7PR11MB6176.namprd11.prod.outlook.com (2603:10b6:8:98::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.37; Fri, 14 Jun 2024 04:14:30 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.7633.036; Fri, 14 Jun 2024
 04:14:30 +0000
Date: Fri, 14 Jun 2024 12:14:15 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Chunxin Zang <spring.cxz@gmail.com>, Honglei Wang
	<jameshongleiwang@126.com>, <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, Mike Galbraith <efault@gmx.de>,
	<linux-kernel@vger.kernel.org>, <yangchen11@lixiang.com>, Jerry Zhou
	<zhouchunhua@lixiang.com>, Chunxin Zang <zangchunxin@lixiang.com>
Subject: Re: [PATCH v2] sched/fair: Reschedule the cfs_rq when current is
 ineligible
Message-ID: <ZmvDl80DQRvtOkoh@chenyu5-mobl2>
References: <20240529141806.16029-1-spring.cxz@gmail.com>
 <ZmKVjmuC4kGrUH5V@chenyu5-mobl2>
 <2E6EB0D6-D913-4205-B7DD-35EF4FA25667@gmail.com>
 <Zmrd2hwqHB8RQjqB@chenyu5-mobl2>
 <112FECA8-5D21-406F-814C-ACBE63351CBB@gmail.com>
 <ZmryuDqw2fEhHNni@chenyu5-mobl2>
 <9d83771f-3d12-25f0-c3f8-70dd7942e9ce@amd.com>
 <4c285c36-6893-c0c4-1061-0d7e16445e9d@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c285c36-6893-c0c4-1061-0d7e16445e9d@amd.com>
X-ClientProxiedBy: SG2P153CA0025.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::12)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS7PR11MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: da3000b2-5b93-4be7-4d79-08dc8c287cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?lNZBfDchEu6TOnYLx30hFvgEqOPEaVgIUPoQCuDhLAHU9HX45ruh84MrAf?=
 =?iso-8859-1?Q?G2hgGKMND74rryNFxuCaZ1wgzl3IoWTyJDwVdeFPRUNAr6JWCdtwRG7vzk?=
 =?iso-8859-1?Q?FAdz7DseT19pwCn88o5gXRNKoMV2pAd6oZKS5TZSVJI1SThIgvlBonU7Wg?=
 =?iso-8859-1?Q?jXAa0gQFsZQ2t3yf6AB/t441XcMo7EH9sQF6RrSv1qdOSkZGdws6X33ndc?=
 =?iso-8859-1?Q?B6zOvnD9gK+K+Sy7A64ZWdrnTw+reZPllMNXjOoOzlEZxl3ythgd2zhrxd?=
 =?iso-8859-1?Q?sQgZzmNNUccWI4OMBu53yJZsoeWrZYTd2a/XBDF+iuAklFgZFVLkLfTrtR?=
 =?iso-8859-1?Q?dkCybG8D0UqV5sGcCZoDeIzQs4qSayj5hzTIqy/mzC/cGhGlMHF6cEF3S4?=
 =?iso-8859-1?Q?tt3+KCl2lu4XbWXwIAVIHyVlwOViQxiUsIQF4TYFTlIQH1QbtLdZojIfXk?=
 =?iso-8859-1?Q?xlm/xp58Ld/NfEs4jmlugqVrg3Y69NIVpgtvIlFAaArFuVd6HwPRpQsMuV?=
 =?iso-8859-1?Q?F7HdnM77N4Su+ZCQqE/lJ/3lidGgV/YoJPZbPsnku/TFt4E7CwYSSuXGWB?=
 =?iso-8859-1?Q?uuzy/os/ZP2/A3iZDvNqoK+VOu4dKEy5NWVIJO9lRX78Rxi4RtBtoiRmvn?=
 =?iso-8859-1?Q?/uNkJdSz4qah2wNi3bdGDsLdkwFQndGSbWG6bqJ5T0aVKMErLNga6SIWvu?=
 =?iso-8859-1?Q?QsicxnsmQ6COefPmN41FVp0VwE6EEAk5k9/X7vpt6+r4sPZS4F06zcZvaK?=
 =?iso-8859-1?Q?XPGE6AAhuOsOhIgC73S+vUXlML5ulEdJcfyXhj270m7K5x6gfTosfW3p7c?=
 =?iso-8859-1?Q?LP5LDbdayOzA1XD9vzT4h9LahSEBoRHYCYV+su7c8DhcdfcDkKnRX7YRcW?=
 =?iso-8859-1?Q?qqs1rR1sbexO149FoJ9dmo+aLhjw5656xgFiv9V+sfMy+Efjh42mHzFjjW?=
 =?iso-8859-1?Q?WlPB6wf62ZBWuHfnV7e2Cyyfq6U5wj1kvL3B9C62ZMZkNPMytpofqFeqIa?=
 =?iso-8859-1?Q?0rkQ3T1m8H63kSVBcR697Jq3+vUH1IbXIQr+ZClVMZvUl71gNHjE7R2/+4?=
 =?iso-8859-1?Q?9tRcJQ9Rfs+wPNCtxaQZwUFg0SpJ909puDSobidnMXxUSTedAyCQS9mwfm?=
 =?iso-8859-1?Q?qIxmEjoFP0R9G+/PSq1HOuVsbUfhIZVLG/jkrYkW2c4VUlI/lBo2RXfNCE?=
 =?iso-8859-1?Q?oyJqAyRJUYeDGbqbBSiUsvFHa2riVgTHspoC2IqM1HEnfTjy25B1chE4yK?=
 =?iso-8859-1?Q?XuJdSGXRhW3LN56Hk4WqHhFEuE28uagCaSTXSucVIzXnWzhNPUvcAJl2Pr?=
 =?iso-8859-1?Q?cQa05zSRMM9H3g3PB3nFvQjkeyROfuodbQI+Enm0oQTSs2c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gXGkeqUYDzCGURF7vLCU51ZW/U6hD+cralQSIGMsB69gVaQc/1aoWXl/ez?=
 =?iso-8859-1?Q?aJu/2NffKVUNBhreI5ShEONdQOgg8kPPVIiTa7Zrocik+PG6oKnf5W5d1A?=
 =?iso-8859-1?Q?lYMJVpKvfs0CW+bX7oGqW1BZ/CuBiDo7eicKcgxg2jnRSPlXtkP8YQS6+E?=
 =?iso-8859-1?Q?031BhJ8T/MmRv/T4uE/Hy2KrH4cTBueqEO+nLkFiV1k9AEdQo64QmCdIOS?=
 =?iso-8859-1?Q?gj7xuO5N2Wq5xUWmIO1J9bA0s5bWptXgU9ry240vNv7fnUYD5x/7zcx+LV?=
 =?iso-8859-1?Q?kIETNJN1kVHz0VRIovGXiITtYBE0uRDFQhkAjLjjHC1KabJFv7ZM5KcL50?=
 =?iso-8859-1?Q?iy6NZ5SMoUDzWeNs+0u9jb4nAeBU6uvreca5FogOm7tv48hWkPK0g/IisL?=
 =?iso-8859-1?Q?8dc5xCdB0ypXLWP48UpzcIUF9c3+5ySWoeVy6WnSAkaQgHLmhB8b8Ekt5w?=
 =?iso-8859-1?Q?oGU6FdBJQtw0h4r2TiS8kbB3kn4Ip5EC0dGl1ShA4z7JKvuuS6npLfc6zs?=
 =?iso-8859-1?Q?JF50j6pav6/+Dn4ef2oO8MRsrkMLI2VCfUconObzcrljIIfi6VYo2Ehrsm?=
 =?iso-8859-1?Q?HFjdyvRFVyZwbf4TBLtIvtZvHuqF7zKtw5izC+ze5kABqJ4fjKtG3mBPD6?=
 =?iso-8859-1?Q?U2UnT0MwxXHQzYz+kc0JspmC/JRKQ09L4xEkO/hoyhqpU28JRzpxFQ5Ksq?=
 =?iso-8859-1?Q?4n8RrmCVz264bvIq5YnUbm+keAH2RbdeTpw2buSXNZM4mwrplbinpYojoo?=
 =?iso-8859-1?Q?HJs8NsY0VCK02hj3dQpXeE05tIW//rWVjFbisahYIV67wNIfwaDNmFaAgQ?=
 =?iso-8859-1?Q?Rr5/VNwh7SF5DiC1JrOMQ7zza7eHnjD6ZMaTcC8iDMfssevx8n+zdS7xXj?=
 =?iso-8859-1?Q?kPxqjGizufzLLfFq/ph3cpqu89Zplx/NnqgDzUQo54+XpmlzX0ASS3B4E8?=
 =?iso-8859-1?Q?31ZgqKfFjp57gH9nBeEeL7pr8OoJz0ZHt43sZuLfjDwEiVbRV+GpuYZWrf?=
 =?iso-8859-1?Q?+I2fdhNv2JtK34VXjMAKVqFm8VW1oaDFQ592VBMtUC/PaBspm0SIq8F7Uw?=
 =?iso-8859-1?Q?8IXxxwOGwEcbyMIsN8kk/nQGFk0uWVKVhi1+JBFGd7dWp84EV/36LKgvuO?=
 =?iso-8859-1?Q?JlfXCoRcaKPoL0Y6h7JLZ0rmmLlK4rK9YtTF89xELdbXdAHhPmBPWwSKBd?=
 =?iso-8859-1?Q?6aZROfeV6YLgLOCQZ8t0h9ClHue02cGPDb27rVmLyJd6ePFJMMa/A+8g0V?=
 =?iso-8859-1?Q?nqwSOUxY8Z1fZ5e5+Fq3BRHH1mT899Na2YhfWl2WiVPV4V0fxHvUsY3uXy?=
 =?iso-8859-1?Q?IZH59YcStFIe/+PAClx6Q7Ocm6HPYjkVnHDY9mdKWfb2L/MnruJfQcSERo?=
 =?iso-8859-1?Q?10/gJcSPgmnJqMrrtyPi0s3yIjAHAuOE7qBgxWgSDc/8nUlxJMhqnxgrqW?=
 =?iso-8859-1?Q?9dep+/WxEr/JBjIHIuJcqO8MgwCxOIr2tzHrR9CRn8hPHORX4FzBUZu48x?=
 =?iso-8859-1?Q?ROV+donlGNepogJg8jlTmEqHDULk55puQxARbFAUFJd3PNV6vGE40J1cnC?=
 =?iso-8859-1?Q?5Z9zQLv7lK9w0T3gmGqquM2nJh6Xd8wMrD0N80OkHQ40pNTNtL9glTDyiG?=
 =?iso-8859-1?Q?uwcPpdVmf43HaMPJK9VgX5MNloYppwrxR/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da3000b2-5b93-4be7-4d79-08dc8c287cd7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 04:14:30.2096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpzJfV/6DnGJ7EvOJaXV6S/5Q7MxO/IwmBaJg9FBSrDY7i9YzVyMbT4Q6aaWl9sgr+RqPySvfvRo/Nm1d8CEmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6176
X-OriginatorOrg: intel.com

Hi Prateek,

On 2024-06-14 at 08:46:54 +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> > > +static bool check_curr_preempt(struct cfs_rq *cfs_rq, struct
> > > sched_entity *curr)
> > > +{
> > > +    if (sched_feat(RUN_TO_PARITY) || cfs_rq->nr_running <= 1 ||
> > > +        !entity_eligible(cfs_rq, curr))
> > 
> > Shouldn't this return false if "entity_eligible(cfs_rq, curr)" returns
> > true since curr is still vruntime eligible on cfs_rq?
> > 
> > Would it better to have check_curr_preempt() as follows:
> > 
> >      if (sched_feat(RUN_TO_PARITY) || cfs_rq->nr_running <= 1)
> >          return false;
> > 
> >      return entity_eligible(cfs_rq, curr);
> 
> The above return should have been:
> 
> 	return !entity_eligible(cfs_rq, curr);
> 
> Which returns true once curr is not vruntime eligible on cfs_rq.
> Sorry for the oversight.
>

Yes, you are right, thanks for catching this.

thanks,
Chenyu 


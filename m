Return-Path: <linux-kernel+bounces-434217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304D69E6367
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFEF1168A65
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D835A1A269;
	Fri,  6 Dec 2024 01:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i63KMPSd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E594D1BC3C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 01:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733448670; cv=fail; b=o5oPPAniEIrh2nIHPqchYEPYqn4eOGBK9FES3Iq+/h4WlE58TY7LPs5J1crWbtcMeR3OiswLQ9czAX+kW+/cR029aE3DTtEs0zAVT8bSkUhZG5nUOVXoO5rbnhcLBtf0DMxfduUOJe25hmzKQqEe5l+a9V0XWZBCUgvqkmfvGzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733448670; c=relaxed/simple;
	bh=wi+L34QPp7W3xNsl9oTLEEubyNfSb0ALgjJhfpuEMZU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LZlTOQaqdlumXcjA/iTpcV3qnXZI9kyaFtzzj3vjDV5+fWgBfPfCnYL/FyC3kVbSNAjIrFv65RGhCmBDuwQQGYt6xXMTkgHVktJRsOXDiuyisD0SUhLkpOAYNIDuzHu7xtQZ+Y0lbhp93jDdlCyMiu0lrjMR0UWUKw6F0QFxy/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i63KMPSd; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733448664; x=1764984664;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=wi+L34QPp7W3xNsl9oTLEEubyNfSb0ALgjJhfpuEMZU=;
  b=i63KMPSdLKyXyXpqQQH6AwcKHSFqJOtyzX8pOnCi+LuXzUBR+8kWXfg2
   gGLVURUK1SHHZHYkwJhe6w5piM9HKV4Q7hhUtZ6LKorF1dLbBtwpar0o0
   STpaA0IUZSg9c2/H27WEuGJ7R4Da9KIMqjQq+z6Obv5YN0cUChA3tYcpx
   KNQ9uzzuw+E01UxXDywQGty7MHiYIC+BQyxwbuNw2o8eRLPBGFGpZEMpg
   bDPpFyIv8MxRRRrbPYN1yrzf2vS4IOxAf9wdCnE77Ns7IMVVLdXVdfJ7l
   9fRZU/YxW3/WRj17XuebadIhieXvDbpMfyMnu3eXH0uPMZWcKHg1IoqNT
   w==;
X-CSE-ConnectionGUID: IToKx/wDS0aNq2DMwAmiVg==
X-CSE-MsgGUID: dmFkqkcXR8WAwXUQdsde1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33526159"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="33526159"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 17:31:02 -0800
X-CSE-ConnectionGUID: 1k+/cEVXR8m3PzTjnEafMg==
X-CSE-MsgGUID: aXu8Fcl5QJKC+UHc5ByM4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="94742175"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 17:31:02 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 17:31:01 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 17:31:01 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 17:31:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/6LjD0ZHKyM0Qv28oSOfs7Zff2tImqXDcsDV5dyOr4o+jQUzgEWOcofHnVDWwSsrFxkgWtO7IbRYi+EpdsazZP7Mbs+AhGaETUd4WHtXyEeeO0ywfE/2YS+JsL0NVBsfWfXeCXEc2SQHEXj2QU9/8UsM+SbupgQChTWfVGHMxvn6QnsWydTk7o1Tq7qlmxGEprdOIgt796wPx/uhmF1VnXG/pYbg4D/IlYiZSWDrwE0rKZLhY8Ou+e6t2QUgWY8AtxW17mhcRndOFx//DjDXihKXVuH5Cs8uvlxUTX5Gn00PObt2e28jSzAn21pUgVtPHOCw1EtgXyzkoNEifQVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEn2EWuEi7Evbb2q1EWvzVSOqf3CJgN6wNQXGwWQupI=;
 b=da1MPOmVCKg0cidU8M58sYZRwF7u+iNf5NmsFr+n33mT1ozfqKVXPD/Zi3OvsD1WRsPdx2SXa4/hhVqd62OWQXBHMFnuzJah3rg/OkskUbuiEt46v7nbyU8dHV6KchYNJ8Bpb7xFF/z+RuXgi0JdiwZS/aq+uYJu/qeNdPk1S8asUKiVITnlxekoSTtgnpsVdrXc+c2vUpARiq5inYcd0gTwSC2jF+H/kmDhdnleqxemdlop5bmjo2aDg/tbvsnQVo8PiCCY2y+IIgmjYa0jmqlKtyEj4hiSw0ZDO+koNSkOh8yWx4qkbtsfOL8bXHRRJBWOYzbfcOWS9IRzokl9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6660.namprd11.prod.outlook.com (2603:10b6:510:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Fri, 6 Dec
 2024 01:30:56 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 01:30:55 +0000
Date: Fri, 6 Dec 2024 09:30:45 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Rik van Riel <riel@surriel.com>
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	<oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Dave Hansen
	<dave.hansen@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v4] x86,mm: only trim the mm_cpumask once a second
Message-ID: <Z1JTxQzs4iBN6i5A@xsang-OptiPlex-9020>
References: <202411282207.6bd28eae-lkp@intel.com>
 <20241202194358.59089122@fangorn>
 <Z1BV7NG/Qp0BNw3Y@xsang-OptiPlex-9020>
 <20241204115634.28964c62@fangorn>
 <43835b8c-53cd-428f-a46f-554bfa5c2cdd@efficios.com>
 <20241204210316.612ee573@fangorn>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241204210316.612ee573@fangorn>
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: 084529a0-d490-4b38-565d-08dd1595a0c5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?umGvcPwtMoAXchWN4BxN9elfDaQLNxZ54UrxFKos1Y5MIPjUS2jTzNRgsU?=
 =?iso-8859-1?Q?PdMyZiYyQ6wknwNB5jRgSN0C9AeLXwGCZU7y5fcxpS7+QNJtYg9esfSyDD?=
 =?iso-8859-1?Q?MLIGUuRBRjR1rI+EHGG8t3PesHe0sJN81tClGNj0docrj+zwZiZOM0gm62?=
 =?iso-8859-1?Q?inqXczSkFZhl6oSfrpAXfU/CoH+IkCP8m7fPH1hVQq43mnqxq7CRxuv93E?=
 =?iso-8859-1?Q?aZeLPm6UEr8RbGt9Mf9ij/70k+2XI1KIvgYJVLRFEdaTJwElK0TlhxHPZG?=
 =?iso-8859-1?Q?5xhT4U1ZC5EwQh/x7D+tpZj/eRDW6l2u809ECY5G4qdhkRNAhPMSHoLDMF?=
 =?iso-8859-1?Q?JhZgi93ogDTp5jGzUbYT8mpf7LXRLeyqXw4Gts+Uc+5fv23Ze9dIvKDcbm?=
 =?iso-8859-1?Q?jhCJnXPIUDfTgfsKPa7D1Zjvl8/g99+g3Qe+JLqU9wmzK7J8b4WxhDuCUK?=
 =?iso-8859-1?Q?zHxfKvRj2ULzJnEagyTJy4U8AMtCKqkm8qtWNwqLDkow8kmhp7jXW4dwMQ?=
 =?iso-8859-1?Q?nNpAfcl3BUllxZlCxuT2HkywMiYmBkolmYNIFF2NjJGAquiHryDicEEe6P?=
 =?iso-8859-1?Q?4u6wYPLy5sc6ptOfmt+/ACLWVN5593q0yCsBgi/t4rylSmKRXOTlyYpDMq?=
 =?iso-8859-1?Q?nCms7zRSdP8FPuczPamE/aTuhx1WN80ttaAV7BYN6Gel0AX9AnLIKnHjWP?=
 =?iso-8859-1?Q?IMv2vFc+Fu3Or1NoeocUi2YGMxowwZuFpJWoKs3QaC/iShmq0ggjU7unK4?=
 =?iso-8859-1?Q?NTrPj9MEINWSYAScZ4dwsJ0lAc4UOBMSS7M76QcOKscD35kiO2bNGGOwY2?=
 =?iso-8859-1?Q?3kXifCxQuY016in7YSCBmD7ZLKuZN/z8xuyWhcEvHjyWkNRr0I5viwgR7B?=
 =?iso-8859-1?Q?f2GZIq2d33yaS9FrMbXbtxO2caj/mg3yq5Qvri5BBJvg+5wSGctHU9HC5f?=
 =?iso-8859-1?Q?gkWh1K4ZRP+T3qZsdzE45B/nYcnibkn54ypzj1XdP49BrcBjJqPWrobOQH?=
 =?iso-8859-1?Q?Z6mUacC/nddteq8lnKXwuGpPwr4NyDG1E39zJfPHWwFkVPReQfOPb1JWsx?=
 =?iso-8859-1?Q?j6Q0c+HUXZGP6VIgfqC4ZzaldEsUjgck+ucpxIKK9OOAeuE8QxBXTiyWye?=
 =?iso-8859-1?Q?q2/64UsDQYlUK8hl5zk2QaYebd4lRDP6c6J5wIccYs6ct/v331dZL01Z0l?=
 =?iso-8859-1?Q?x/QE7vFE8lNS396wHjhN84l86reVsDUaBTR455SyeXCizCBVjnZCKKfgQE?=
 =?iso-8859-1?Q?iK+cFRpZxbm36+y17v3uX9PIjL/nzcbg4eWnilIO/b8xGN9Iu5w9YjJ9A+?=
 =?iso-8859-1?Q?8+dyXqGl7iJ+fMVRgP4TtO6Ny21MGikzLi+ZJUvtUFCSP2RiDCYNVbaVhn?=
 =?iso-8859-1?Q?3/pEbjt1ea/iiDyHWP2DcW6MTBHRknIV64roAYQEdpTncTki4lZN8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yThstH1UYNbF0IOeZP5EK2N0NEmKvtmrF6UhLW5mbIvOyK0z+/DygwiywM?=
 =?iso-8859-1?Q?NixdE4opMl37Fvw6C1JJ4q6gPGFowSAerK9SgZhkqzCooyFHR1NFBtGLY7?=
 =?iso-8859-1?Q?41I6W4ei9OjTgMjngKjTmYcpxu+cVKu7vpZ2Tfa/d8afA3oG2StKRLEMd3?=
 =?iso-8859-1?Q?KRmWHFhQZH6Cao5F6na3Ap0mx7cs83Eo0cCef20rhuJo8tdIeMepD4KN4n?=
 =?iso-8859-1?Q?G7snjIGAjw7jk4uA6eGit7WITedzrAdfS62S3uGylrXyM298SKVKgZDDhD?=
 =?iso-8859-1?Q?9gFsdAXKjS1b4fgT3x0rMtE6fhVcVQnZqEKsmycBrNN4bqjqhf0/nGP19C?=
 =?iso-8859-1?Q?2I40Si7j9kk9Vciicm+O8Z/E2F1QJbGyT8PCeOb8YiRzuGrgT9ZgBjJ0bs?=
 =?iso-8859-1?Q?afCiobNpPo2PNbJ/mcQIg1uq+1IYbiRsQU+gEqEcS2vn0JI5tie+HssWX0?=
 =?iso-8859-1?Q?xTTCqncE1LdZwin+s4Wg4R6J1GnXXGgP0rqLGELSFMIgcgaOX33xwW+Jst?=
 =?iso-8859-1?Q?Cr6QqiUb++8kzI9ef6E12OARDAxCcyyrE2XPHzQy1jRfKtXk6sWwfTqwnU?=
 =?iso-8859-1?Q?o4s8fTyJCxAZ/Pg6WFCUWAxGkJxsIKZ4pf3nsy/wgmHxhxMZo0MOp/iYpd?=
 =?iso-8859-1?Q?Kd2SXrwzzh+WQQyL/bRaxfcrPI4rgAt5CLhcu2n3MHnaZ19jL8b/LfiUSk?=
 =?iso-8859-1?Q?esxo3B/jDmNr6Gv76QmhQoD+mezygAMOGv3LubVjHGjun7Xm3mO5gg/CNV?=
 =?iso-8859-1?Q?I5H/Jb0EHma9nKA679uPRHpwHKyxqMUI/0K6ioKJ0qLZickXYc5ykwVPlr?=
 =?iso-8859-1?Q?tmMsLu2DHTqeiwLGr65In7dRopf3G5aoVhPFaMQkrqABC+fZB5ZEM85b93?=
 =?iso-8859-1?Q?W50h2gpAUmjTkM2AUtJPOQ8ewOzqIZ2Ola0FD2xPBZMgRdjKc4WQ6Zz/4H?=
 =?iso-8859-1?Q?gycDKa2vhpib8EIZLlXf8J2iSzbBCrWs9uz3GWT1mn++U3rmRrma/SfFro?=
 =?iso-8859-1?Q?UvZyXS8oAp6V7DspBJEZQQYVbUzjKSoQR/RlENrBVh8Drx+t8EKxYLciTc?=
 =?iso-8859-1?Q?Se2IPZ5BRF/XjvBD1QQxMyKzNK6l1uryXrtlZcakT9g2OUK++YFOkvgDBd?=
 =?iso-8859-1?Q?pXop4bFXgwXM7s5fTwdxx965qEN7JxujL0N85Yk7Q3LNhoIZPuf28feOlo?=
 =?iso-8859-1?Q?YNJqiC0j9UnYq0Q+dGUw1J2O6Yt+a7e8Rguu1PMZ8tCqvcvGI8Ejo9eYuE?=
 =?iso-8859-1?Q?odeYqZDRi+hpVA3RW3MM3y16uSfzgavB5/ii+HtV67XddVFqjvLKDTqZpl?=
 =?iso-8859-1?Q?ZOM8OvMxV87WZfhObPCOFFbgWU2y7oMlOJdajCOVwVL9ZlNxyId4tvoeJs?=
 =?iso-8859-1?Q?jGTfboEq6iKo+wpmA9HlaOfM1qWs1HAly0CB3syBRvKzwyKh7n1fYeA31X?=
 =?iso-8859-1?Q?iWyp5G/xraSwa0uT5wQK3Gb09Mw0KbB6W19bPSuBydCzWqHPIJuwEp1n3g?=
 =?iso-8859-1?Q?8+FeQ7OLK9kd1ATPXe/SB505ZSyyKA7ctHnOtS/LC2xBf9VHAJujxr525p?=
 =?iso-8859-1?Q?DR/sBZNS5XGhH+Zmvw6XiztEXYdG1G8hlWnEljSQU0/UolEZYeuukqYGr3?=
 =?iso-8859-1?Q?wqLBOC33saUv2lNQryw/CeVV63d8FnU4oZxUUhY9CJxx1V3ltLH7WyNw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 084529a0-d490-4b38-565d-08dd1595a0c5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 01:30:55.7150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AD/05+hAwnOoexihWfm3bhipnp0DfysarZsCSnbznXevyXauQSGWnwaqg41DxSCEII7hEWI/4cWBS35ypxVkZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6660
X-OriginatorOrg: intel.com

hi, Rik van Riel,

On Wed, Dec 04, 2024 at 09:03:16PM -0500, Rik van Riel wrote:
> On Wed, 4 Dec 2024 15:19:46 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > AFAIU this should_trim_cpumask can be called from many cpus
> > concurrently for a given mm, so we'd want READ_ONCE/WRITE_ONCE
> > on the next_trim_cpumask.
> 
> Here is v4, which is identical to v3 except for READ_ONCE/WRITE_ONCE.
> 
> Looking forward to the test bot results, since the hardware I have
> available does not seem to behave in quite the same way :)

thanks for waiting our results!

however, it's sorry to say we didn't see the regression recovered by this v4
patch, for both tests.

our bot still apply this patch upon 2815a56e4b725 as below.

* 852ff7f2f791a x86,mm: only trim the mm_cpumask once a second   <--- v4
* 2815a56e4b725 (tip/x86/mm) x86/mm/tlb: Add tracepoint for TLB flush IPI to stale CPU
* 209954cbc7d0c x86/mm/tlb: Update mm_cpumask lazily
* 7e33001b8b9a7 x86/mm/tlb: Put cpumask_test_cpu() check in switch_mm_irqs_off() under CONFIG_DEBUG_VM


for will-it-scale (full comparison is in [1])

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/thread/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/tlb_flush2/will-it-scale

commit:
  7e33001b8b ("x86/mm/tlb: Put cpumask_test_cpu() check in switch_mm_irqs_off() under CONFIG_DEBUG_VM")
  209954cbc7 ("x86/mm/tlb: Update mm_cpumask lazily")
  2815a56e4b ("x86/mm/tlb: Add tracepoint for TLB flush IPI to stale CPU")
  852ff7f2f7 ("x86,mm: only trim the mm_cpumask once a second")

7e33001b8b9a7806 209954cbc7d0ce1a190fc725d20 2815a56e4b7252a836969f5674e 852ff7f2f791aadd04317d1a53f
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
      7276           -13.2%       6315           -13.0%       6328           -14.9%       6191        will-it-scale.per_thread_ops


for vm-scalability (full comparison is in [2])
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_ssd/nr_task/priority/rootfs/runtime/tbox_group/test/testcase/thp_defrag/thp_enabled:
  gcc-12/performance/x86_64-rhel-9.4/1/32/1/debian-12-x86_64-20240206.cgz/300/lkp-icl-2sp4/swap-w-seq-mt/vm-scalability/always/never

commit:
  7e33001b8b ("x86/mm/tlb: Put cpumask_test_cpu() check in switch_mm_irqs_off() under CONFIG_DEBUG_VM")
  209954cbc7 ("x86/mm/tlb: Update mm_cpumask lazily")
  2815a56e4b ("x86/mm/tlb: Add tracepoint for TLB flush IPI to stale CPU")
  852ff7f2f7 ("x86,mm: only trim the mm_cpumask once a second")

7e33001b8b9a7806 209954cbc7d0ce1a190fc725d20 2815a56e4b7252a836969f5674e 852ff7f2f791aadd04317d1a53f
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
     38311 ±  5%     -40.8%      22667           -41.1%      22583 ±  2%     -41.3%      22494        vm-scalability.median
   1234132 ±  4%     -40.7%     732265           -40.8%     730989 ±  3%     -40.9%     729108        vm-scalability.throughput



[1]
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/thread/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/tlb_flush2/will-it-scale

commit:
  7e33001b8b ("x86/mm/tlb: Put cpumask_test_cpu() check in switch_mm_irqs_off() under CONFIG_DEBUG_VM")
  209954cbc7 ("x86/mm/tlb: Update mm_cpumask lazily")
  2815a56e4b ("x86/mm/tlb: Add tracepoint for TLB flush IPI to stale CPU")
  852ff7f2f7 ("x86,mm: only trim the mm_cpumask once a second")

7e33001b8b9a7806 209954cbc7d0ce1a190fc725d20 2815a56e4b7252a836969f5674e 852ff7f2f791aadd04317d1a53f
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
      3743 ±  6%      -9.6%       3383 ± 10%      -2.0%       3669 ±  6%      -4.9%       3561 ± 11%  numa-meminfo.node1.PageTables
     18158 ±  2%      -9.9%      16367 ±  2%     -12.6%      15874           -14.9%      15449        uptime.idle
     36.77            -1.2%      36.34            -1.3%      36.28            -0.9%      36.42        boot-time.boot
      3503            -1.3%       3458            -1.5%       3452            -1.0%       3467        boot-time.idle
 1.421e+10            -9.6%  1.284e+10 ±  2%     -11.4%  1.259e+10           -14.2%  1.219e+10        cpuidle..time
 2.595e+08           -12.9%   2.26e+08           -13.2%  2.251e+08           -18.7%  2.109e+08 ±  2%  cpuidle..usage
     20954 ± 17%     -17.0%      17391 ±  2%     -14.2%      17979 ± 12%     -17.6%      17255        perf-c2c.DRAM.remote
     18165 ± 17%     -17.7%      14957 ±  2%     -15.1%      15413 ± 12%     -18.7%      14774        perf-c2c.HITM.remote
     44864 ± 17%     -15.4%      37953           -12.4%      39320 ± 12%     -15.9%      37727        perf-c2c.HITM.total
     44.91            -9.3%      40.74           -10.5%      40.20           -12.5%      39.29        vmstat.cpu.id
    695438            -8.1%     638790            -7.4%     644221            -8.5%     636573        vmstat.system.cs
   4553480            -3.5%    4393928            -2.6%    4436365            -4.0%    4371742        vmstat.system.in
     44.57            -4.3       40.31            -4.7       39.83            -5.7       38.86        mpstat.cpu.all.idle%
      9.85            +6.1       15.94            +6.3       16.17            +7.6       17.41        mpstat.cpu.all.irq%
      0.10            +0.0        0.12            +0.0        0.13            +0.0        0.12        mpstat.cpu.all.soft%
      2.34 ±  2%      -0.3        2.02            -0.3        2.06            -0.3        2.03        mpstat.cpu.all.usr%
 1.139e+08 ±  2%     -14.5%   97376097 ±  3%     -12.7%   99390724 ±  3%     -13.3%   98785729 ±  3%  numa-numastat.node0.local_node
 1.139e+08 ±  2%     -14.5%   97404595 ±  3%     -12.7%   99439249 ±  3%     -13.2%   98835438 ±  3%  numa-numastat.node0.numa_hit
 1.146e+08           -11.6%  1.013e+08 ±  2%     -13.0%   99664033 ±  3%     -16.3%   95955617 ±  3%  numa-numastat.node1.local_node
 1.146e+08           -11.6%  1.013e+08 ±  2%     -13.0%   99724983 ±  3%     -16.3%   96015424 ±  3%  numa-numastat.node1.numa_hit
    756738           -13.2%     656838           -13.0%     658224           -14.9%     643961        will-it-scale.104.threads
     43.82            -9.5%      39.67            -9.6%      39.62           -11.8%      38.64        will-it-scale.104.threads_idle
      7276           -13.2%       6315           -13.0%       6328           -14.9%       6191        will-it-scale.per_thread_ops
    756738           -13.2%     656838           -13.0%     658224           -14.9%     643961        will-it-scale.workload
 1.139e+08 ±  2%     -14.5%   97404162 ±  3%     -12.7%   99438988 ±  3%     -13.2%   98835133 ±  3%  numa-vmstat.node0.numa_hit
 1.139e+08 ±  2%     -14.5%   97375664 ±  3%     -12.7%   99390464 ±  3%     -13.3%   98785428 ±  3%  numa-vmstat.node0.numa_local
    936.25 ±  6%      -9.7%     845.81 ± 10%      -2.0%     917.10 ±  6%      -4.9%     890.29 ± 11%  numa-vmstat.node1.nr_page_table_pages
 1.146e+08           -11.6%  1.013e+08 ±  2%     -13.0%   99724221 ±  3%     -16.3%   96014486 ±  3%  numa-vmstat.node1.numa_hit
 1.146e+08           -11.6%  1.012e+08 ±  2%     -13.0%   99663271 ±  3%     -16.3%   95954678 ±  3%  numa-vmstat.node1.numa_local
      0.17 ±  5%     -14.8%       0.14 ± 11%      -9.2%       0.15 ±  6%      -9.6%       0.15 ±  9%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__vm_munmap
      0.13 ±  5%     -17.0%       0.11 ±  9%     -11.2%       0.11 ±  8%     -14.9%       0.11 ± 14%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
     41283 ±  5%     +22.8%      50696 ± 13%     +13.2%      46723 ±  7%     +14.6%      47323 ± 11%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__vm_munmap
      8372 ± 13%     +22.1%      10221 ±  9%     +18.0%       9882 ±  8%     +26.4%      10587 ± 16%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
      0.16 ±  5%     -15.3%       0.14 ± 12%      -9.6%       0.14 ±  6%     -10.2%       0.14 ± 10%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__vm_munmap
      0.12 ±  6%     -17.5%       0.10 ±  8%     -11.9%       0.11 ±  8%     -15.9%       0.10 ± 14%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
  35873620 ± 30%     -22.4%   27821786 ± 33%     -40.9%   21206791 ± 26%     -19.3%   28944541 ± 12%  sched_debug.cfs_rq:/.avg_vruntime.max
      3.14 ±  4%     +27.4%       4.00 ±  6%     +21.1%       3.80 ± 12%     +26.4%       3.97 ±  9%  sched_debug.cfs_rq:/.load_avg.min
  35873620 ± 30%     -22.4%   27821786 ± 33%     -40.9%   21206791 ± 26%     -19.3%   28944541 ± 12%  sched_debug.cfs_rq:/.min_vruntime.max
     82954 ±  8%      +9.9%      91143 ±  7%      +9.2%      90574 ±  7%     +16.9%      96981 ±  5%  sched_debug.cpu.avg_idle.min
      1598 ±  3%     +53.8%       2458 ± 16%     +50.1%       2398 ± 12%     +93.2%       3087 ±  8%  sched_debug.cpu.clock_task.stddev
   1005828            -7.9%     925907            -7.9%     926693            -9.1%     914560        sched_debug.cpu.nr_switches.avg
    958802            -8.9%     873208            -8.8%     874819           -10.7%     856154        sched_debug.cpu.nr_switches.min
    432388 ±  2%      -2.1%     423334            -1.7%     425005            -2.0%     423845        proc-vmstat.nr_active_anon
    261209 ±  3%      -3.7%     251458            -2.9%     253702 ±  2%      -3.3%     252550        proc-vmstat.nr_shmem
    105930            +0.2%     106091            -0.0%     105903            -2.2%     103599        proc-vmstat.nr_slab_unreclaimable
    432388 ±  2%      -2.1%     423334            -1.7%     425005            -2.0%     423845        proc-vmstat.nr_zone_active_anon
 2.286e+08           -13.1%  1.987e+08           -12.9%  1.992e+08           -14.8%  1.947e+08        proc-vmstat.numa_hit
 2.285e+08           -13.1%  1.986e+08           -12.9%   1.99e+08           -14.8%  1.946e+08        proc-vmstat.numa_local
 2.287e+08           -13.0%  1.988e+08           -12.9%  1.993e+08           -14.8%  1.948e+08        proc-vmstat.pgalloc_normal
 4.559e+08           -13.1%  3.962e+08           -12.9%  3.971e+08           -14.8%  3.882e+08        proc-vmstat.pgfault
 2.283e+08           -13.1%  1.985e+08           -12.9%  1.989e+08           -14.8%  1.945e+08        proc-vmstat.pgfree
      5.74            -5.3%       5.43            -3.1%       5.56 ±  2%      -6.0%       5.39 ±  2%  perf-stat.i.MPKI
 5.392e+09            -6.9%  5.019e+09            -5.7%  5.084e+09            -6.4%  5.049e+09        perf-stat.i.branch-instructions
      2.80            +0.0        2.83            +0.0        2.83            +0.0        2.85        perf-stat.i.branch-miss-rate%
 1.509e+08            -5.8%  1.421e+08            -4.4%  1.443e+08            -4.2%  1.445e+08        perf-stat.i.branch-misses
     24.36            -1.4       22.92            -1.1       23.28            -1.8       22.61        perf-stat.i.cache-miss-rate%
 1.538e+08           -12.1%  1.351e+08            -9.2%  1.396e+08 ±  2%     -12.7%  1.343e+08 ±  2%  perf-stat.i.cache-misses
 6.321e+08            -6.4%  5.915e+08            -4.4%  6.041e+08            -5.2%  5.993e+08        perf-stat.i.cache-references
    702183            -8.3%     644080            -7.6%     648563            -8.7%     641354        perf-stat.i.context-switches
      6.24           +19.0%       7.42           +18.9%       7.42           +21.8%       7.60        perf-stat.i.cpi
 1.672e+11           +10.1%  1.841e+11           +10.9%  1.854e+11           +12.8%  1.886e+11        perf-stat.i.cpu-cycles
    550.50            +2.6%     565.02            +3.0%     566.88            +4.6%     575.75        perf-stat.i.cpu-migrations
      1085           +25.0%       1356           +22.1%       1325 ±  2%     +29.1%       1401 ±  2%  perf-stat.i.cycles-between-cache-misses
 2.683e+10            -7.0%  2.494e+10            -5.8%  2.528e+10            -6.4%  2.511e+10        perf-stat.i.instructions
      0.17           -14.7%       0.14 ±  2%     -15.0%       0.14           -17.1%       0.14        perf-stat.i.ipc
      0.00 ±141%    +265.0%       0.00 ± 33%    +348.2%       0.00 ± 78%    +451.7%       0.01 ± 59%  perf-stat.i.major-faults
     35.60           -12.2%      31.27           -11.5%      31.52           -13.2%      30.91        perf-stat.i.metric.K/sec
   1500379           -13.1%    1304071           -12.4%    1314966           -14.3%    1286573        perf-stat.i.minor-faults
   1500379           -13.1%    1304071           -12.4%    1314966           -14.3%    1286573        perf-stat.i.page-faults
      2.33 ± 44%      +0.5        2.83            +0.5        2.84            +0.5        2.86        perf-stat.overall.branch-miss-rate%
      5.19 ± 44%     +42.2%       7.37           +41.3%       7.33           +44.7%       7.51        perf-stat.overall.cpi
    905.91 ± 44%     +50.4%       1362           +46.7%       1328 ±  2%     +55.1%       1405 ±  2%  perf-stat.overall.cycles-between-cache-misses
   8967486 ± 44%     +28.7%   11541403           +29.1%   11576850           +30.9%   11738346        perf-stat.overall.path-length
 1.387e+11 ± 44%     +32.2%  1.835e+11           +33.2%  1.848e+11           +35.5%   1.88e+11        perf-stat.ps.cpu-cycles
    457.08 ± 44%     +23.1%     562.85           +23.6%     564.75           +25.5%     573.58        perf-stat.ps.cpu-migrations
     70.53            -6.7       63.83            -6.8       63.71            -6.8       63.78        perf-profile.calltrace.cycles-pp.__madvise
     68.82            -6.4       62.40            -6.5       62.29            -6.5       62.35        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
     68.63            -6.4       62.23            -6.5       62.12            -6.4       62.18        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     68.38            -6.4       62.02            -6.5       61.92            -6.4       61.97        perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     68.36            -6.4       62.01            -6.5       61.90            -6.4       61.95        perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     54.54            -3.9       50.68            -3.7       50.80            -3.5       51.02        perf-profile.calltrace.cycles-pp.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
     54.49            -3.8       50.64            -3.7       50.76            -3.5       50.98        perf-profile.calltrace.cycles-pp.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
     20.77            -3.8       16.93 ±  2%      -3.7       17.07            -3.8       16.93        perf-profile.calltrace.cycles-pp.llist_add_batch.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu
     48.74            -3.8       44.99            -3.7       45.00            -3.6       45.17        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise
     42.51            -3.4       39.15            -3.3       39.18            -3.3       39.21        perf-profile.calltrace.cycles-pp.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single
     42.90            -3.4       39.54            -3.3       39.56            -3.3       39.59        perf-profile.calltrace.cycles-pp.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior
     43.33            -3.3       40.07            -3.2       40.12            -3.1       40.21        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior.do_madvise
     12.96            -2.3       10.63 ±  3%      -2.6       10.40 ±  2%      -2.7       10.23 ±  3%  perf-profile.calltrace.cycles-pp.down_read.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.32            -2.2       10.12 ±  3%      -2.4        9.91 ±  2%      -2.6        9.74 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.do_madvise.__x64_sys_madvise.do_syscall_64
      9.65 ±  2%      -1.9        7.75 ±  3%      -2.2        7.49 ±  2%      -2.3        7.33 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.rwsem_down_read_slowpath.down_read.do_madvise.__x64_sys_madvise
      9.46 ±  2%      -1.9        7.57 ±  3%      -2.1        7.33 ±  2%      -2.3        7.17 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.rwsem_down_read_slowpath.down_read.do_madvise
      6.54 ±  2%      -1.5        5.08 ±  2%      -1.5        5.03 ±  4%      -1.6        4.95 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      6.29            -1.1        5.16            -1.0        5.28 ±  2%      -1.1        5.22 ±  3%  perf-profile.calltrace.cycles-pp.testcase
      4.34            -0.9        3.41 ±  2%      -0.9        3.45 ±  2%      -0.9        3.40        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.llist_add_batch.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range
      3.94            -0.9        3.07 ±  2%      -0.8        3.11 ±  2%      -0.9        3.06        perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.llist_add_batch.smp_call_function_many_cond.on_each_cpu_cond_mask
      3.79            -0.8        2.95 ±  2%      -0.8        2.99 ±  2%      -0.8        2.95        perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.llist_add_batch.smp_call_function_many_cond
      3.74            -0.8        2.91 ±  2%      -0.8        2.95 ±  2%      -0.8        2.91        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.llist_add_batch
      4.88 ±  2%      -0.8        4.11 ±  3%      -0.7        4.13 ±  3%      -0.8        4.06 ±  3%  perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.28 ±  2%      -0.8        0.52            -0.8        0.45 ± 39%      -1.0        0.31 ± 81%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      4.63            -0.7        3.92            -0.7        3.94            -0.7        3.91        perf-profile.calltrace.cycles-pp.llist_reverse_order.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function
      3.82            -0.7        3.13            -0.6        3.24 ±  4%      -0.6        3.19 ±  5%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
      3.34 ±  2%      -0.6        2.72 ±  2%      -0.5        2.83 ±  5%      -0.6        2.78 ±  6%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
      3.23 ±  2%      -0.6        2.63 ±  2%      -0.5        2.75 ±  5%      -0.5        2.70 ±  6%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      0.68            -0.6        0.10 ±200%      -0.5        0.21 ±122%      -0.4        0.31 ± 81%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.rwsem_down_read_slowpath.down_read.do_madvise.__x64_sys_madvise
      5.07            -0.4        4.67 ±  2%      -0.4        4.63 ±  2%      -0.4        4.71        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior.do_madvise
      5.05            -0.4        4.65 ±  2%      -0.4        4.61 ±  2%      -0.4        4.69        perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior
      3.31            -0.4        2.92            -0.4        2.94            -0.4        2.94        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.smp_call_function_many_cond
      3.48            -0.4        3.09            -0.4        3.11            -0.4        3.11        perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range
      3.35            -0.4        2.96            -0.4        2.98            -0.4        2.97        perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.smp_call_function_many_cond.on_each_cpu_cond_mask
      3.82            -0.4        3.44            -0.4        3.46            -0.4        3.46        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu
      4.88            -0.4        4.51 ±  2%      -0.4        4.47 ±  2%      -0.3        4.56        perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.zap_page_range_single
      2.13            -0.3        1.84            -0.3        1.84            -0.3        1.85        perf-profile.calltrace.cycles-pp.default_send_IPI_mask_sequence_phys.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu
      1.64            -0.3        1.38 ±  2%      -0.2        1.44 ±  5%      -0.2        1.44 ±  4%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      1.38            -0.2        1.16            -0.2        1.16            -0.2        1.15        perf-profile.calltrace.cycles-pp.__irqentry_text_end.testcase
      1.40            -0.2        1.18            -0.2        1.23 ±  5%      -0.2        1.24 ±  5%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.89 ±  6%      -0.2        0.69 ±  9%      -0.2        0.74 ± 10%      -0.2        0.70 ± 15%  perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      3.23 ±  2%      -0.2        3.06            -0.2        3.03 ±  3%      -0.1        3.09        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu
      1.13            -0.2        0.97 ±  3%      -0.1        0.99 ±  2%      -0.1        1.00 ±  2%  perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      2.92 ±  2%      -0.1        2.79            -0.2        2.77 ±  3%      -0.1        2.83        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
      2.85 ±  2%      -0.1        2.74            -0.1        2.71 ±  3%      -0.1        2.78        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache
      2.74 ±  2%      -0.1        2.64            -0.1        2.61 ±  3%      -0.1        2.67        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs
      0.69            -0.1        0.60            -0.1        0.61            -0.1        0.60        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
      0.69            -0.1        0.60            -0.1        0.61            -0.1        0.60        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      0.70            -0.1        0.60            -0.1        0.61            -0.1        0.61        perf-profile.calltrace.cycles-pp.__munmap
      0.69            -0.1        0.60            -0.1        0.61            -0.1        0.60        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      0.68            -0.1        0.60            -0.1        0.61            -0.1        0.60        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      0.62 ±  3%      -0.1        0.54            -0.0        0.58 ±  6%      -0.1        0.56 ±  7%  perf-profile.calltrace.cycles-pp.unmap_page_range.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise
      0.88 ±  2%      -0.1        0.82 ±  2%      -0.1        0.82 ±  3%      -0.0        0.83 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu
      0.81 ±  2%      -0.1        0.75 ±  2%      -0.1        0.75 ±  3%      -0.0        0.76 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
      1.48            -0.1        1.43            -0.0        1.47 ±  2%      -0.0        1.46        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read
      0.77 ±  2%      -0.1        0.72 ±  3%      -0.1        0.72 ±  3%      -0.0        0.74 ±  2%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.folios_put_refs
      0.78 ±  2%      -0.1        0.73 ±  2%      -0.1        0.73 ±  3%      -0.0        0.74 ±  2%  perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.folios_put_refs.free_pages_and_swap_cache
      1.48            -0.0        1.43            -0.0        1.47 ±  2%      -0.0        1.46        perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.do_madvise
      1.48            -0.0        1.43            -0.0        1.47 ±  2%      -0.0        1.47        perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.do_madvise.__x64_sys_madvise
      0.83 ±  2%      -0.0        0.79 ±  3%      -0.0        0.79 ±  3%      -0.0        0.82 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.zap_page_range_single
      0.51            +0.0        0.56            +0.0        0.55            +0.0        0.55        perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.54            +0.1        0.64 ±  3%      +0.1        0.65            +0.1        0.64 ±  3%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      0.43 ± 44%      +0.1        0.53 ±  3%      +0.1        0.55 ±  3%      +0.1        0.56 ±  2%  perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath
      0.60 ±  2%      +0.1        0.72 ±  3%      +0.1        0.73            +0.1        0.73 ±  3%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      4.47            +0.1        4.61 ±  2%      +0.1        4.62 ±  3%      +0.3        4.73        perf-profile.calltrace.cycles-pp.lru_add_drain.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise
      4.47            +0.1        4.61 ±  2%      +0.1        4.61 ±  3%      +0.3        4.73        perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.zap_page_range_single.madvise_vma_behavior.do_madvise
      4.39            +0.1        4.54 ±  2%      +0.2        4.54 ±  3%      +0.3        4.66        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.zap_page_range_single.madvise_vma_behavior
      2.98            +0.2        3.21 ±  2%      +0.2        3.22 ±  3%      +0.3        3.30        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.zap_page_range_single
      2.90 ±  2%      +0.2        3.15 ±  2%      +0.2        3.15 ±  3%      +0.3        3.24        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain
      2.81 ±  2%      +0.2        3.06 ±  2%      +0.2        3.06 ±  3%      +0.3        3.14        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
      0.72 ±  2%      +0.6        1.29 ±  2%      +0.6        1.36 ±  3%      +0.7        1.37 ±  5%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.70 ±  2%      +0.6        1.28 ±  2%      +0.6        1.35 ±  3%      +0.7        1.36 ±  5%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.6        0.63 ±  2%      +0.7        0.67 ±  4%      +0.7        0.66 ±  7%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule_idle.do_idle.cpu_startup_entry
      9.12            +1.0       10.12            +1.0       10.08            +0.9       10.06        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.70 ±  2%      +1.4        2.06 ±  4%      +1.4        2.11 ±  3%      +1.4        2.11 ±  3%  perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.intel_idle_irq.cpuidle_enter_state.cpuidle_enter
      0.61 ±  2%      +1.4        2.00 ±  4%      +1.4        2.05 ±  3%      +1.4        2.05 ±  3%  perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.intel_idle_irq.cpuidle_enter_state
      0.60 ±  2%      +1.4        1.99 ±  4%      +1.4        2.04 ±  3%      +1.4        2.04 ±  3%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.intel_idle_irq
     19.23            +7.0       26.22            +6.9       26.15            +7.0       26.19        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     19.34            +7.0       26.36            +7.0       26.30            +7.0       26.32        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     20.03            +7.2       27.19            +7.1       27.11            +7.1       27.13        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     21.50            +7.9       29.39            +7.9       29.39            +7.9       29.40        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     21.51            +7.9       29.40            +7.9       29.40            +7.9       29.41        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     21.51            +7.9       29.40            +7.9       29.40            +7.9       29.41        perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     21.72            +8.0       29.70            +8.0       29.69            +8.0       29.68        perf-profile.calltrace.cycles-pp.common_startup_64
      1.04            +8.2        9.20 ±  2%      +8.1        9.19 ±  2%      +8.3        9.37 ±  2%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.cpuidle_enter_state
      1.05            +8.2        9.23 ±  2%      +8.2        9.22 ±  2%      +8.3        9.40 ±  2%  perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.cpuidle_enter_state.cpuidle_enter
      1.17            +8.2        9.38 ±  2%      +8.2        9.36 ±  2%      +8.4        9.55 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.28            +8.2        9.51 ±  2%      +8.2        9.49 ±  2%      +8.4        9.68 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.91            +9.3       11.17            +9.3       11.23            +9.5       11.40 ±  2%  perf-profile.calltrace.cycles-pp.flush_tlb_func.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function
     70.58            -6.7       63.87            -6.8       63.75            -6.8       63.82        perf-profile.children.cycles-pp.__madvise
     69.89            -6.5       63.37            -6.6       63.26            -6.6       63.33        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     69.68            -6.5       63.20            -6.6       63.10            -6.5       63.16        perf-profile.children.cycles-pp.do_syscall_64
     68.38            -6.4       62.02            -6.5       61.92            -6.4       61.97        perf-profile.children.cycles-pp.__x64_sys_madvise
     68.37            -6.4       62.01            -6.5       61.91            -6.4       61.95        perf-profile.children.cycles-pp.do_madvise
     21.28            -3.9       17.39 ±  2%      -3.8       17.52            -3.9       17.39        perf-profile.children.cycles-pp.llist_add_batch
     54.54            -3.9       50.68            -3.7       50.80            -3.5       51.02        perf-profile.children.cycles-pp.madvise_vma_behavior
     54.50            -3.8       50.65            -3.7       50.77            -3.5       50.99        perf-profile.children.cycles-pp.zap_page_range_single
     48.89            -3.8       45.11            -3.8       45.12            -3.6       45.29        perf-profile.children.cycles-pp.tlb_finish_mmu
     43.03            -3.4       39.65            -3.4       39.67            -3.3       39.70        perf-profile.children.cycles-pp.smp_call_function_many_cond
     43.03            -3.4       39.65            -3.4       39.67            -3.3       39.70        perf-profile.children.cycles-pp.on_each_cpu_cond_mask
     43.48            -3.3       40.19            -3.2       40.24            -3.1       40.33        perf-profile.children.cycles-pp.flush_tlb_mm_range
      8.38 ±  2%      -2.4        5.97 ±  2%      -2.4        5.95 ±  3%      -2.6        5.82 ±  4%  perf-profile.children.cycles-pp.intel_idle_irq
     12.98            -2.3       10.64 ±  3%      -2.6       10.40 ±  2%      -2.7       10.24 ±  3%  perf-profile.children.cycles-pp.down_read
     12.41            -2.2       10.19 ±  3%      -2.4        9.97 ±  2%      -2.6        9.81 ±  2%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      9.72 ±  2%      -1.9        7.81 ±  3%      -2.2        7.55 ±  2%      -2.3        7.39 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irq
     15.12            -1.7       13.38 ±  2%      -2.0       13.10 ±  2%      -2.0       13.09 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      8.04            -1.4        6.63            -1.4        6.68            -1.4        6.66        perf-profile.children.cycles-pp.llist_reverse_order
      6.87            -1.2        5.64            -1.1        5.76 ±  2%      -1.2        5.70 ±  2%  perf-profile.children.cycles-pp.testcase
      4.16            -0.7        3.41            -0.6        3.52 ±  4%      -0.7        3.48 ±  4%  perf-profile.children.cycles-pp.asm_exc_page_fault
      3.34 ±  2%      -0.6        2.73 ±  2%      -0.5        2.84 ±  5%      -0.6        2.79 ±  6%  perf-profile.children.cycles-pp.exc_page_fault
      3.30 ±  2%      -0.6        2.69 ±  2%      -0.5        2.80 ±  5%      -0.5        2.76 ±  6%  perf-profile.children.cycles-pp.do_user_addr_fault
      5.07            -0.4        4.67 ±  2%      -0.4        4.63 ±  2%      -0.4        4.71        perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      5.05            -0.4        4.66 ±  2%      -0.4        4.61 ±  2%      -0.4        4.70        perf-profile.children.cycles-pp.free_pages_and_swap_cache
      5.06            -0.4        4.67 ±  2%      -0.4        4.63 ±  2%      -0.3        4.71        perf-profile.children.cycles-pp.folios_put_refs
      2.22            -0.3        1.92            -0.3        1.92            -0.3        1.92        perf-profile.children.cycles-pp.default_send_IPI_mask_sequence_phys
      1.65            -0.3        1.39 ±  2%      -0.2        1.45 ±  5%      -0.2        1.45 ±  4%  perf-profile.children.cycles-pp.handle_mm_fault
      1.44            -0.2        1.20            -0.2        1.20            -0.2        1.19        perf-profile.children.cycles-pp.__irqentry_text_end
      1.41            -0.2        1.19 ±  2%      -0.2        1.25 ±  5%      -0.2        1.25 ±  5%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.90 ±  6%      -0.2        0.70 ±  9%      -0.2        0.75 ±  9%      -0.2        0.71 ± 15%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      1.23            -0.2        1.05            -0.2        1.05            -0.2        1.05        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      3.24            -0.2        3.06            -0.2        3.03 ±  3%      -0.1        3.10        perf-profile.children.cycles-pp.__page_cache_release
      1.14            -0.2        0.98 ±  3%      -0.1        1.00 ±  2%      -0.1        1.01 ±  2%  perf-profile.children.cycles-pp.do_anonymous_page
      0.26 ±  5%      -0.1        0.12 ±  8%      -0.2        0.11 ± 12%      -0.2        0.10 ± 13%  perf-profile.children.cycles-pp.poll_idle
      0.79            -0.1        0.66            -0.1        0.67 ±  2%      -0.1        0.66        perf-profile.children.cycles-pp.error_entry
      0.62 ±  3%      -0.1        0.49 ±  8%      -0.1        0.49 ±  5%      -0.1        0.48 ±  5%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.45 ±  8%      -0.1        0.33 ± 16%      -0.1        0.39 ± 21%      -0.1        0.38 ± 28%  perf-profile.children.cycles-pp.mas_walk
      0.88            -0.1        0.76            -0.1        0.76            -0.1        0.77        perf-profile.children.cycles-pp.native_irq_return_iret
      0.54 ±  3%      -0.1        0.42 ±  5%      -0.1        0.42 ±  3%      -0.1        0.42 ±  4%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.50 ±  3%      -0.1        0.39 ±  4%      -0.1        0.39 ±  3%      -0.1        0.39 ±  4%  perf-profile.children.cycles-pp.page_counter_cancel
      0.54 ±  3%      -0.1        0.43 ±  6%      -0.1        0.43 ±  5%      -0.1        0.42 ±  5%  perf-profile.children.cycles-pp.uncharge_batch
      0.55 ±  2%      -0.1        0.45 ±  3%      -0.1        0.44 ±  2%      -0.1        0.44 ±  2%  perf-profile.children.cycles-pp.up_read
      0.70            -0.1        0.60            -0.1        0.61            -0.1        0.61        perf-profile.children.cycles-pp.__munmap
      0.69            -0.1        0.60            -0.1        0.61            -0.1        0.60        perf-profile.children.cycles-pp.__vm_munmap
      0.69            -0.1        0.60            -0.1        0.61            -0.1        0.60        perf-profile.children.cycles-pp.__x64_sys_munmap
      0.67 ±  3%      -0.1        0.58            -0.1        0.62 ±  6%      -0.1        0.60 ±  7%  perf-profile.children.cycles-pp.unmap_page_range
      0.52 ±  2%      -0.1        0.44 ±  4%      -0.1        0.45 ±  3%      -0.1        0.45 ±  2%  perf-profile.children.cycles-pp.alloc_anon_folio
      0.57            -0.1        0.50 ±  4%      -0.1        0.52 ±  4%      -0.1        0.52 ±  4%  perf-profile.children.cycles-pp.zap_pmd_range
      0.54            -0.1        0.48 ±  2%      -0.1        0.49            -0.1        0.48        perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.54            -0.1        0.48 ±  2%      -0.1        0.49            -0.1        0.48        perf-profile.children.cycles-pp.do_vmi_munmap
      0.38 ±  2%      -0.1        0.32            -0.1        0.32 ±  2%      -0.1        0.31 ±  2%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.53 ±  3%      -0.1        0.47 ±  4%      -0.0        0.49 ±  5%      -0.0        0.48 ±  4%  perf-profile.children.cycles-pp.zap_pte_range
      1.51            -0.1        1.45            -0.0        1.50 ±  2%      -0.0        1.49        perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.52 ±  2%      -0.1        0.47 ±  2%      -0.1        0.47            -0.1        0.47        perf-profile.children.cycles-pp.vms_complete_munmap_vmas
      0.48            -0.1        0.42            -0.1        0.42            -0.0        0.42        perf-profile.children.cycles-pp.native_flush_tlb_local
      0.31 ±  2%      -0.1        0.26            -0.0        0.26 ±  2%      -0.1        0.25 ±  2%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.27 ±  5%      -0.1        0.22 ±  8%      -0.0        0.23 ±  8%      -0.0        0.22 ±  7%  perf-profile.children.cycles-pp.tlb_gather_mmu
      0.31 ±  2%      -0.1        0.26 ±  2%      -0.0        0.27            -0.1        0.26 ±  2%  perf-profile.children.cycles-pp.folio_alloc_mpol_noprof
      0.34            -0.1        0.29 ±  2%      -0.1        0.29 ±  2%      -0.1        0.29 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.51            -0.1        1.46            -0.0        1.50 ±  2%      -0.0        1.50        perf-profile.children.cycles-pp.schedule
      0.32            -0.0        0.27            -0.0        0.28            -0.1        0.27        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.50            -0.0        0.45            -0.0        0.45 ±  2%      -0.0        0.45        perf-profile.children.cycles-pp.dequeue_task_fair
      0.40            -0.0        0.35 ±  2%      -0.0        0.36 ±  2%      -0.0        0.35        perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.48            -0.0        0.43            -0.0        0.43            -0.0        0.44        perf-profile.children.cycles-pp.dequeue_entities
      0.28 ±  2%      -0.0        0.24 ±  2%      -0.0        0.24 ±  2%      -0.0        0.23 ±  3%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.28            -0.0        0.24 ±  4%      -0.0        0.24 ±  3%      -0.0        0.24 ±  3%  perf-profile.children.cycles-pp.lru_gen_del_folio
      0.24 ±  5%      -0.0        0.20 ±  7%      -0.0        0.22 ± 13%      -0.0        0.21 ± 17%  perf-profile.children.cycles-pp.find_vma_prev
      0.22 ±  3%      -0.0        0.18 ±  4%      -0.0        0.18 ±  3%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.__perf_sw_event
      0.32            -0.0        0.28            -0.0        0.28 ±  2%      -0.0        0.28        perf-profile.children.cycles-pp.irqtime_account_irq
      0.24 ±  4%      -0.0        0.20 ±  7%      -0.0        0.19 ±  6%      -0.0        0.20 ±  6%  perf-profile.children.cycles-pp.down_read_trylock
      0.19 ±  3%      -0.0        0.15 ±  3%      -0.0        0.16 ±  3%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.vms_clear_ptes
      0.14 ±  9%      -0.0        0.10 ±  8%      -0.0        0.11 ± 12%      -0.0        0.10 ± 13%  perf-profile.children.cycles-pp.flush_tlb_batched_pending
      0.22            -0.0        0.19 ±  2%      -0.0        0.18 ±  2%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.24            -0.0        0.20 ±  3%      -0.0        0.20 ±  2%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.sync_regs
      0.21 ±  2%      -0.0        0.18 ±  4%      -0.0        0.18 ±  3%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.___perf_sw_event
      0.23 ±  3%      -0.0        0.19 ±  2%      -0.0        0.20 ±  3%      -0.0        0.19 ±  3%  perf-profile.children.cycles-pp.down_write_killable
      0.29            -0.0        0.26            -0.0        0.26            -0.0        0.26        perf-profile.children.cycles-pp.dequeue_entity
      0.22 ±  3%      -0.0        0.19 ±  2%      -0.0        0.19 ±  2%      -0.0        0.19 ±  4%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.06            -0.0        0.03 ± 81%      -0.0        0.05            -0.0        0.03 ± 81%  perf-profile.children.cycles-pp.__cond_resched
      0.29 ±  2%      -0.0        0.26 ±  2%      -0.0        0.25 ±  8%      -0.0        0.27 ±  2%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.27            -0.0        0.24 ±  4%      -0.0        0.24 ±  2%      -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.lru_gen_add_folio
      0.09 ±  4%      -0.0        0.06 ±  6%      -0.0        0.07 ±  7%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
      0.23 ±  2%      -0.0        0.20 ±  2%      -0.0        0.20 ±  2%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.20 ±  2%      -0.0        0.18 ±  2%      -0.0        0.17 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.native_sched_clock
      0.15 ±  4%      -0.0        0.12 ±  3%      -0.0        0.13 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.rwsem_mark_wake
      0.33 ±  2%      -0.0        0.31            -0.0        0.31            -0.0        0.31 ±  2%  perf-profile.children.cycles-pp.downgrade_write
      0.14 ±  4%      -0.0        0.12 ±  3%      -0.0        0.12 ±  3%      -0.0        0.12        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.14 ±  7%      -0.0        0.12 ± 16%      -0.0        0.12 ± 14%      -0.0        0.12 ±  9%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.34            -0.0        0.32 ±  3%      -0.0        0.32 ±  2%      -0.0        0.32 ±  2%  perf-profile.children.cycles-pp.lru_add
      0.42 ±  2%      -0.0        0.40 ±  2%      -0.0        0.40 ±  2%      -0.0        0.40        perf-profile.children.cycles-pp.try_to_wake_up
      0.25            -0.0        0.23            -0.0        0.22 ±  8%      -0.0        0.23 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.12 ±  6%      -0.0        0.10 ±  9%      -0.0        0.10 ± 10%      -0.0        0.10 ±  6%  perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.20 ±  2%      -0.0        0.17 ±  2%      -0.0        0.17 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.sched_clock
      0.37            -0.0        0.35            -0.0        0.35 ±  3%      -0.0        0.35 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.14 ±  3%      -0.0        0.12 ±  3%      -0.0        0.12 ±  2%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.update_curr
      0.13 ±  5%      -0.0        0.11 ±  3%      -0.0        0.11 ±  2%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      0.11            -0.0        0.09 ±  4%      -0.0        0.09 ±  4%      -0.0        0.09 ±  3%  perf-profile.children.cycles-pp.clear_page_erms
      0.15            -0.0        0.13 ±  3%      -0.0        0.14 ±  2%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.14 ±  3%      -0.0        0.13 ±  3%      -0.0        0.13 ± 15%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.ktime_get
      0.10 ±  4%      -0.0        0.08 ± 13%      -0.0        0.08 ± 11%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.__folio_mod_stat
      0.43            -0.0        0.41            -0.0        0.41 ±  2%      -0.0        0.42 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.22 ±  2%      -0.0        0.20            -0.0        0.20 ±  2%      -0.0        0.19        perf-profile.children.cycles-pp.enqueue_entity
      0.18 ±  2%      -0.0        0.16 ±  2%      -0.0        0.16 ±  3%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.update_load_avg
      0.14 ±  2%      -0.0        0.12 ±  3%      -0.0        0.13 ±  2%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      0.12 ±  3%      -0.0        0.10 ±  4%      -0.0        0.11 ±  4%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.10 ±  3%      -0.0        0.09 ±  4%      -0.0        0.09 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.free_unref_folios
      0.19 ±  2%      -0.0        0.18            -0.0        0.18 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.08 ±  6%      -0.0        0.06 ±  7%      -0.0        0.06 ±  4%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.rmqueue
      0.07 ±  7%      -0.0        0.05 ±  9%      -0.0        0.05 ±  4%      -0.0        0.05 ±  5%  perf-profile.children.cycles-pp.get_nohz_timer_target
      0.09            -0.0        0.08 ±  5%      -0.0        0.07 ±  6%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.read_tsc
      0.14 ±  3%      -0.0        0.12 ±  3%      -0.0        0.12 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.idle_cpu
      0.08 ±  5%      -0.0        0.07 ±  6%      -0.0        0.08 ±  6%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.prepare_task_switch
      0.06 ±  7%      -0.0        0.05 ±  9%      -0.0        0.05 ± 29%      -0.0        0.05 ± 37%  perf-profile.children.cycles-pp.mm_cid_get
      0.07            -0.0        0.06            -0.0        0.06 ±  4%      -0.0        0.06        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.07            -0.0        0.06            -0.0        0.06 ±  7%      -0.0        0.06        perf-profile.children.cycles-pp.native_apic_mem_eoi
      0.09 ±  5%      -0.0        0.08 ±  5%      -0.0        0.07 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.06            -0.0        0.05 ±  7%      -0.0        0.05            -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.16 ±  2%      +0.0        0.18 ±  4%      +0.0        0.18 ±  2%      +0.0        0.19        perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.05 ±  8%      +0.0        0.07 ±  5%      +0.0        0.07 ±  4%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__switch_to
      0.10 ±  3%      +0.0        0.11 ±  4%      +0.0        0.12 ±  5%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.hrtimer_try_to_cancel
      0.67 ±  3%      +0.0        0.69 ±  2%      +0.0        0.70 ±  2%      +0.0        0.72 ±  2%  perf-profile.children.cycles-pp.__pick_next_task
      0.50            +0.0        0.52            +0.0        0.53 ±  2%      +0.0        0.54        perf-profile.children.cycles-pp.__irq_exit_rcu
      0.66            +0.0        0.68            +0.0        0.69            +0.0        0.70        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.62 ±  2%      +0.0        0.64 ±  2%      +0.0        0.65 ±  2%      +0.1        0.67 ±  3%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.11 ±  3%      +0.0        0.14 ±  5%      +0.0        0.13 ±  4%      +0.0        0.14        perf-profile.children.cycles-pp.start_dl_timer
      0.05            +0.0        0.08 ±  6%      +0.0        0.09 ±  5%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.task_contending
      0.47 ±  3%      +0.0        0.50 ±  2%      +0.0        0.51 ±  3%      +0.0        0.52 ±  3%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.45 ±  3%      +0.0        0.48 ±  3%      +0.0        0.49 ±  3%      +0.1        0.50 ±  3%  perf-profile.children.cycles-pp.sched_balance_rq
      0.03 ± 70%      +0.0        0.07            +0.0        0.07 ±  5%      +0.0        0.07        perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.52            +0.0        0.56            +0.0        0.55            +0.0        0.55        perf-profile.children.cycles-pp.menu_select
      0.19 ±  5%      +0.0        0.23            +0.1        0.24 ±  3%      +0.1        0.24 ±  2%  perf-profile.children.cycles-pp.handle_softirqs
      0.18 ±  2%      +0.0        0.22 ±  3%      +0.0        0.22 ±  2%      +0.1        0.23 ±  2%  perf-profile.children.cycles-pp.enqueue_dl_entity
      0.18 ±  3%      +0.1        0.23            +0.1        0.23            +0.1        0.24 ±  2%  perf-profile.children.cycles-pp.dl_server_start
      0.11 ±  3%      +0.1        0.16 ±  2%      +0.1        0.17 ±  3%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.46            +0.1        0.52            +0.1        0.51            +0.1        0.52        perf-profile.children.cycles-pp.enqueue_task_fair
      0.00            +0.1        0.06            +0.1        0.06 ±  6%      +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.call_cpuidle
      0.47            +0.1        0.53            +0.1        0.53            +0.1        0.53        perf-profile.children.cycles-pp.enqueue_task
      0.48            +0.1        0.55            +0.1        0.54            +0.1        0.54        perf-profile.children.cycles-pp.ttwu_do_activate
      0.62            +0.1        0.70 ±  4%      +0.1        0.70 ±  2%      +0.1        0.70        perf-profile.children.cycles-pp._find_next_bit
      0.18 ±  2%      +0.1        0.26            +0.1        0.27 ±  3%      +0.1        0.28 ±  5%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.20            +0.1        0.28 ±  3%      +0.1        0.29 ±  3%      +0.1        0.29 ±  5%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.64            +0.1        0.72            +0.1        0.72            +0.1        0.71        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.22            +0.1        0.30            +0.1        0.31 ±  3%      +0.1        0.32 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.21 ±  2%      +0.1        0.30 ±  8%      +0.1        0.28 ±  8%      +0.1        0.27 ±  8%  perf-profile.children.cycles-pp.rest_init
      0.21 ±  2%      +0.1        0.30 ±  8%      +0.1        0.28 ±  8%      +0.1        0.27 ±  8%  perf-profile.children.cycles-pp.start_kernel
      0.21 ±  2%      +0.1        0.30 ±  8%      +0.1        0.28 ±  8%      +0.1        0.27 ±  8%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.21 ±  2%      +0.1        0.30 ±  8%      +0.1        0.28 ±  8%      +0.1        0.27 ±  8%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.10 ±  3%      +0.1        0.20 ±  2%      +0.1        0.20 ±  2%      +0.1        0.20 ±  4%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.00            +0.1        0.10 ±  7%      +0.1        0.11 ±  5%      +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.__bitmap_and
      0.06 ±  6%      +0.1        0.16 ±  4%      +0.1        0.16 ±  2%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.48            +0.1        0.58 ±  2%      +0.1        0.58 ±  2%      +0.1        0.58        perf-profile.children.cycles-pp._raw_spin_lock
      0.16 ±  3%      +0.1        0.28            +0.1        0.28 ±  2%      +0.1        0.28 ±  3%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.61            +0.1        0.73 ±  3%      +0.1        0.74            +0.1        0.74 ±  3%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      4.49            +0.1        4.62 ±  2%      +0.1        4.63 ±  3%      +0.3        4.74        perf-profile.children.cycles-pp.lru_add_drain
      4.48            +0.1        4.62 ±  2%      +0.1        4.62 ±  3%      +0.3        4.74        perf-profile.children.cycles-pp.lru_add_drain_cpu
      4.45            +0.1        4.59 ±  2%      +0.2        4.60 ±  3%      +0.3        4.72        perf-profile.children.cycles-pp.folio_batch_move_lru
      0.28 ±  2%      +0.1        0.42 ±  4%      +0.2        0.46 ±  4%      +0.2        0.45 ±  6%  perf-profile.children.cycles-pp.finish_task_switch
      0.00            +0.2        0.15 ±  3%      +0.2        0.15 ±  5%      +0.2        0.16 ±  3%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.00            +0.2        0.16 ±  3%      +0.2        0.16 ±  5%      +0.2        0.16 ±  4%  perf-profile.children.cycles-pp.ct_idle_exit
      0.02 ± 99%      +0.2        0.24 ±  2%      +0.2        0.24 ±  4%      +0.2        0.25 ±  4%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      5.84 ±  2%      +0.3        6.09            +0.2        6.07 ±  3%      +0.4        6.23        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.37 ±  4%      +0.4        0.73 ±  2%      +0.4        0.78 ±  3%      +0.4        0.76 ±  6%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      2.22            +0.5        2.76            +0.6        2.86 ±  2%      +0.6        2.86 ±  3%  perf-profile.children.cycles-pp.__schedule
      0.73 ±  2%      +0.6        1.31 ±  2%      +0.6        1.38 ±  3%      +0.7        1.38 ±  5%  perf-profile.children.cycles-pp.schedule_idle
      9.24            +1.0       10.25            +1.0       10.21            +0.9       10.18        perf-profile.children.cycles-pp.intel_idle
     18.85            +6.3       25.12            +6.4       25.25            +6.5       25.36        perf-profile.children.cycles-pp.asm_sysvec_call_function
     19.52            +7.1       26.62            +7.0       26.53            +7.0       26.56        perf-profile.children.cycles-pp.cpuidle_enter_state
     19.53            +7.1       26.63            +7.0       26.55            +7.0       26.57        perf-profile.children.cycles-pp.cpuidle_enter
     20.22            +7.2       27.47            +7.2       27.38            +7.2       27.39        perf-profile.children.cycles-pp.cpuidle_idle_call
     14.43            +7.8       22.23            +8.0       22.41            +8.1       22.56        perf-profile.children.cycles-pp.sysvec_call_function
     13.73            +7.9       21.59            +8.0       21.77            +8.2       21.93        perf-profile.children.cycles-pp.__sysvec_call_function
     21.51            +7.9       29.40            +7.9       29.40            +7.9       29.41        perf-profile.children.cycles-pp.start_secondary
     21.72            +8.0       29.69            +8.0       29.68            +8.0       29.68        perf-profile.children.cycles-pp.do_idle
     21.72            +8.0       29.70            +8.0       29.69            +8.0       29.68        perf-profile.children.cycles-pp.common_startup_64
     21.72            +8.0       29.70            +8.0       29.69            +8.0       29.68        perf-profile.children.cycles-pp.cpu_startup_entry
     14.36            +8.1       22.42            +8.2       22.61            +8.4       22.78        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      3.58            +9.4       12.97            +9.5       13.09            +9.7       13.27 ±  2%  perf-profile.children.cycles-pp.flush_tlb_func
      7.43 ±  2%      -3.8        3.66            -3.8        3.58 ±  4%      -4.0        3.47 ±  7%  perf-profile.self.cycles-pp.intel_idle_irq
     16.93            -2.9       13.99 ±  2%      -2.9       14.07            -2.9       13.99        perf-profile.self.cycles-pp.llist_add_batch
     15.11            -1.7       13.38 ±  2%      -2.0       13.09 ±  2%      -2.0       13.08 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      8.01            -1.4        6.57            -1.4        6.62            -1.4        6.59        perf-profile.self.cycles-pp.llist_reverse_order
      1.44            -0.2        1.19            -0.2        1.20            -0.2        1.19        perf-profile.self.cycles-pp.__irqentry_text_end
      1.69            -0.2        1.50            -0.2        1.51            -0.2        1.51        perf-profile.self.cycles-pp.default_send_IPI_mask_sequence_phys
      0.24 ±  6%      -0.1        0.10 ± 10%      -0.2        0.09 ± 15%      -0.2        0.08 ± 16%  perf-profile.self.cycles-pp.poll_idle
      0.78            -0.1        0.66            -0.1        0.66 ±  2%      -0.1        0.66        perf-profile.self.cycles-pp.error_entry
      0.87            -0.1        0.76            -0.1        0.76            -0.1        0.76        perf-profile.self.cycles-pp.native_irq_return_iret
      0.65 ±  2%      -0.1        0.54 ±  2%      -0.1        0.53            -0.1        0.54        perf-profile.self.cycles-pp.testcase
      0.46 ±  2%      -0.1        0.37 ±  5%      -0.1        0.35 ±  3%      -0.1        0.35 ±  5%  perf-profile.self.cycles-pp.down_read
      0.38 ±  8%      -0.1        0.29 ± 16%      -0.1        0.33 ± 21%      -0.1        0.32 ± 28%  perf-profile.self.cycles-pp.mas_walk
      0.41 ±  3%      -0.1        0.32 ±  4%      -0.1        0.32 ±  3%      -0.1        0.32 ±  4%  perf-profile.self.cycles-pp.page_counter_cancel
      0.32 ± 12%      -0.1        0.24 ±  4%      -0.0        0.28 ± 14%      -0.1        0.25 ± 20%  perf-profile.self.cycles-pp.zap_page_range_single
      0.46 ±  2%      -0.1        0.38 ±  3%      -0.1        0.37 ±  3%      -0.1        0.37 ±  3%  perf-profile.self.cycles-pp.up_read
      0.28 ±  5%      -0.1        0.21 ±  5%      -0.1        0.22 ±  6%      -0.1        0.20 ±  6%  perf-profile.self.cycles-pp.tlb_finish_mmu
      0.56            -0.1        0.49 ±  2%      -0.1        0.48 ±  2%      -0.1        0.48 ±  2%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.32 ± 11%      -0.1        0.25 ± 16%      -0.0        0.27 ± 11%      -0.1        0.23 ± 16%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.30 ±  2%      -0.1        0.24            -0.1        0.22 ±  2%      -0.1        0.22 ±  3%  perf-profile.self.cycles-pp.menu_select
      0.33 ±  6%      -0.1        0.27 ±  7%      -0.0        0.28 ±  6%      +0.0        0.35 ±  8%  perf-profile.self.cycles-pp.flush_tlb_mm_range
      0.46            -0.1        0.41            -0.0        0.42 ±  2%      -0.0        0.42 ±  2%  perf-profile.self.cycles-pp.native_flush_tlb_local
      0.34            -0.1        0.29 ±  2%      -0.1        0.28 ±  2%      -0.1        0.28 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.32            -0.0        0.27            -0.0        0.28            -0.1        0.27 ±  2%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.18 ±  9%      -0.0        0.13 ± 12%      -0.0        0.16 ± 28%      -0.0        0.15 ± 35%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.22 ±  5%      -0.0        0.18 ±  7%      -0.0        0.20 ±  8%      -0.0        0.19 ±  8%  perf-profile.self.cycles-pp.tlb_gather_mmu
      0.24            -0.0        0.20 ±  3%      -0.0        0.20 ±  2%      -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.sync_regs
      0.12 ±  9%      -0.0        0.08 ±  9%      -0.0        0.09 ± 13%      -0.0        0.09 ± 14%  perf-profile.self.cycles-pp.flush_tlb_batched_pending
      0.14 ±  4%      -0.0        0.11 ±  9%      -0.0        0.12 ±  8%      -0.0        0.11 ±  9%  perf-profile.self.cycles-pp.do_madvise
      0.22 ±  2%      -0.0        0.18 ±  2%      -0.0        0.18 ±  3%      -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.lru_gen_del_folio
      0.21 ±  2%      -0.0        0.17 ±  4%      -0.0        0.17 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.13 ±  7%      -0.0        0.10 ±  6%      -0.0        0.11 ± 10%      -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.folio_lruvec_lock_irqsave
      0.19 ±  4%      -0.0        0.17 ±  6%      -0.0        0.16 ±  7%      -0.0        0.16 ±  6%  perf-profile.self.cycles-pp.down_read_trylock
      0.09 ±  5%      -0.0        0.06            -0.0        0.06 ±  6%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.20 ±  3%      -0.0        0.17            -0.0        0.17 ±  2%      -0.0        0.17        perf-profile.self.cycles-pp.native_sched_clock
      0.13 ±  4%      -0.0        0.10 ±  4%      -0.0        0.11 ±  4%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.15 ±  2%      -0.0        0.13 ±  3%      -0.0        0.13 ±  4%      -0.0        0.13 ±  4%  perf-profile.self.cycles-pp.___perf_sw_event
      0.11 ±  4%      -0.0        0.08 ±  5%      -0.0        0.08 ±  4%      -0.0        0.08 ±  3%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.22 ±  2%      -0.0        0.20 ±  5%      -0.0        0.20 ±  3%      -0.0        0.20 ±  3%  perf-profile.self.cycles-pp.lru_gen_add_folio
      0.19 ±  3%      -0.0        0.17 ±  4%      -0.0        0.17 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.22            -0.0        0.20 ±  3%      -0.0        0.20 ±  2%      -0.0        0.20        perf-profile.self.cycles-pp.folios_put_refs
      0.14 ±  3%      -0.0        0.12 ±  3%      -0.0        0.12 ±  3%      -0.0        0.12        perf-profile.self.cycles-pp.irqtime_account_irq
      0.09 ±  5%      -0.0        0.07            -0.0        0.07 ±  4%      -0.0        0.07        perf-profile.self.cycles-pp.__madvise
      0.12 ±  4%      -0.0        0.10            -0.0        0.10 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.rwsem_mark_wake
      0.20 ±  4%      -0.0        0.19 ±  4%      -0.0        0.18 ±  3%      -0.0        0.18 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.09 ±  5%      -0.0        0.07 ±  6%      -0.0        0.07 ±  4%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.read_tsc
      0.09            -0.0        0.08 ±  5%      -0.0        0.07 ±  5%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.clear_page_erms
      0.07            -0.0        0.06 ±  6%      -0.0        0.06            -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.native_apic_mem_eoi
      0.06 ±  7%      -0.0        0.05 ±  9%      -0.0        0.05 ± 29%      -0.0        0.05 ± 37%  perf-profile.self.cycles-pp.mm_cid_get
      0.10            -0.0        0.09            -0.0        0.09 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.asm_sysvec_call_function
      0.06            -0.0        0.05            -0.0        0.05 ±  8%      -0.0        0.05 ±  9%  perf-profile.self.cycles-pp.handle_mm_fault
      0.06            -0.0        0.05 ±  7%      -0.0        0.05            -0.0        0.04 ± 33%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.05 ±  7%      +0.0        0.07 ±  5%      +0.0        0.07 ±  3%      +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__switch_to
      0.17 ±  3%      +0.0        0.19 ±  2%      +0.0        0.19 ±  2%      +0.0        0.19 ±  2%  perf-profile.self.cycles-pp.cpuidle_enter_state
      2.10            +0.0        2.14            +0.1        2.17            +0.1        2.19        perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.06            +0.1        0.11 ±  3%      +0.1        0.12 ±  4%      +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.02 ±141%      +0.1        0.07 ±  5%      +0.1        0.07 ±  6%      +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.do_idle
      0.00            +0.1        0.06 ±  6%      +0.1        0.06 ±  9%      +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.call_cpuidle
      0.48            +0.1        0.56 ±  4%      +0.1        0.57 ±  2%      +0.1        0.57 ±  2%  perf-profile.self.cycles-pp._find_next_bit
      0.00            +0.1        0.09 ±  5%      +0.1        0.10 ±  6%      +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__bitmap_and
      0.38 ±  3%      +0.1        0.49 ±  2%      +0.1        0.49 ±  2%      +0.1        0.49 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.28            +0.1        0.39 ±  3%      +0.1        0.38 ±  2%      +0.1        0.40 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.01 ±223%      +0.2        0.24 ±  3%      +0.2        0.24 ±  3%      +0.2        0.25 ±  4%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.36 ±  4%      +0.4        0.73 ±  2%      +0.4        0.77 ±  3%      +0.4        0.76 ±  6%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      9.24            +1.0       10.25            +1.0       10.21            +0.9       10.18        perf-profile.self.cycles-pp.intel_idle
     15.13            +1.2       16.34            +1.1       16.20            +1.3       16.39        perf-profile.self.cycles-pp.smp_call_function_many_cond
      3.07            +9.5       12.52            +9.6       12.63            +9.7       12.82 ±  2%  perf-profile.self.cycles-pp.flush_tlb_func



[2]

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_ssd/nr_task/priority/rootfs/runtime/tbox_group/test/testcase/thp_defrag/thp_enabled:
  gcc-12/performance/x86_64-rhel-9.4/1/32/1/debian-12-x86_64-20240206.cgz/300/lkp-icl-2sp4/swap-w-seq-mt/vm-scalability/always/never

commit:
  7e33001b8b ("x86/mm/tlb: Put cpumask_test_cpu() check in switch_mm_irqs_off() under CONFIG_DEBUG_VM")
  209954cbc7 ("x86/mm/tlb: Update mm_cpumask lazily")
  2815a56e4b ("x86/mm/tlb: Add tracepoint for TLB flush IPI to stale CPU")
  852ff7f2f7 ("x86,mm: only trim the mm_cpumask once a second")

7e33001b8b9a7806 209954cbc7d0ce1a190fc725d20 2815a56e4b7252a836969f5674e 852ff7f2f791aadd04317d1a53f
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
    368.00 ±114%    +237.8%       1243 ± 32%    +253.5%       1300 ± 22%    +230.3%       1215 ± 22%  perf-c2c.HITM.remote
 3.016e+10 ±  5%     +23.7%  3.732e+10           +23.3%  3.717e+10           +22.4%  3.693e+10        cpuidle..time
   2394210 ±  5%   +1598.8%   40671711         +1582.1%   40273563         +1588.4%   40423635        cpuidle..usage
    280.01 ±  3%     +24.8%     349.50           +24.2%     347.79           +23.4%     345.66        uptime.boot
     27411 ±  3%     +21.2%      33234           +20.4%      32994           +19.4%      32716        uptime.idle
     73.97            -2.3%      72.29            -2.5%      72.14            -2.7%      71.96        iostat.cpu.idle
     23.61            -7.6%      21.82            -7.4%      21.87            -6.8%      22.00        iostat.cpu.iowait
      2.11 ±  2%    +169.7%       5.68 ±  4%    +174.3%       5.78 ±  2%    +176.2%       5.82 ±  2%  iostat.cpu.system
      0.26 ±  3%      -0.0        0.23 ±  2%      -0.0        0.23 ±  2%      -0.0        0.23        mpstat.cpu.all.irq%
      0.08            -0.0        0.04 ±  4%      -0.0        0.04 ±  8%      -0.0        0.04 ±  4%  mpstat.cpu.all.soft%
      1.78 ±  2%      +3.7        5.45 ±  4%      +3.8        5.55 ±  2%      +3.8        5.58 ±  2%  mpstat.cpu.all.sys%
      0.31 ±  7%      -0.1        0.21 ±  5%      -0.1        0.21 ±  4%      -0.1        0.21        mpstat.cpu.all.usr%
  16661751 ± 42%     -59.8%    6694161 ± 70%     -29.8%   11689134 ± 53%     -43.1%    9474687 ± 66%  numa-numastat.node0.numa_miss
  16734663 ± 41%     -59.5%    6770170 ± 69%     -29.9%   11733904 ± 53%     -43.0%    9533441 ± 66%  numa-numastat.node0.other_node
  26857269 ± 23%     -60.2%   10694204 ± 50%     -39.9%   16138920 ± 41%     -47.7%   14040582 ± 47%  numa-numastat.node1.local_node
  16665351 ± 42%     -59.8%    6694094 ± 70%     -29.9%   11678532 ± 53%     -43.3%    9441584 ± 66%  numa-numastat.node1.numa_foreign
  26918278 ± 23%     -60.1%   10751098 ± 49%     -39.8%   16205404 ± 41%     -47.6%   14114601 ± 47%  numa-numastat.node1.numa_hit
    368.92 ± 36%     -55.2%     165.39 ± 74%     -25.3%     275.44 ± 51%     -47.2%     194.83 ± 54%  vmstat.io.bi
    409795           -51.0%     200717 ±  3%     -51.3%     199570 ±  7%     -51.4%     199148 ±  5%  vmstat.io.bo
      4.14 ±  7%    +100.0%       8.28 ±  6%    +108.5%       8.63 ±  3%    +110.8%       8.72 ±  4%  vmstat.procs.r
    359.98 ± 37%     -56.0%     158.48 ± 77%     -25.4%     268.51 ± 52%     -47.8%     187.86 ± 56%  vmstat.swap.si
    409786           -51.0%     200710 ±  3%     -51.3%     199563 ±  7%     -51.4%     199142 ±  5%  vmstat.swap.so
      5382           -28.9%       3825 ±  2%     -29.6%       3788 ±  3%     -29.6%       3791 ±  2%  vmstat.system.cs
    339018 ±  2%     -33.0%     227081 ±  3%     -32.6%     228406           -32.2%     229751        vmstat.system.in
  54162177 ± 11%     -32.5%   36537092 ± 17%     -21.5%   42515388 ± 26%     -29.1%   38427326 ± 29%  meminfo.Active
  54162037 ± 11%     -32.5%   36536947 ± 17%     -21.5%   42515235 ± 26%     -29.1%   38427028 ± 29%  meminfo.Active(anon)
  66576747 ±  9%     +24.3%   82748036 ±  9%     +16.2%   77343432 ± 14%     +23.9%   82492139 ± 13%  meminfo.Inactive
  66575517 ±  9%     +24.3%   82746881 ±  9%     +16.2%   77342282 ± 14%     +23.9%   82490802 ± 13%  meminfo.Inactive(anon)
    333831           -11.8%     294280           -11.6%     295003 ±  2%     -11.0%     297103        meminfo.PageTables
     33487 ±  3%    +199.2%     100210 ± 26%    +184.1%      95125 ± 12%    +196.7%      99362 ± 11%  meminfo.Shmem
 1.627e+08           +11.4%  1.812e+08           +11.5%  1.814e+08           +11.5%  1.814e+08        meminfo.SwapFree
      1644 ± 11%     -41.9%     955.75 ± 10%     -41.9%     954.97 ± 10%     -42.4%     947.74 ± 13%  meminfo.Writeback
    239.68 ±  5%     +28.4%     307.63           +28.4%     307.85           +28.4%     307.77        time.elapsed_time
    239.68 ±  5%     +28.4%     307.63           +28.4%     307.85           +28.4%     307.77        time.elapsed_time.max
      6297 ±  5%     +60.9%      10134           +63.0%      10265           +63.5%      10295        time.involuntary_context_switches
  62687446           -24.8%   47163918 ±  2%     -24.9%   47061196 ±  3%     -25.1%   46934963        time.minor_page_faults
    224.00 ±  3%    +166.7%     597.33 ±  3%    +170.7%     606.31 ±  2%    +170.7%     606.40 ±  2%  time.percent_of_cpu_this_job_got
    474.22 ±  3%    +276.7%       1786 ±  3%    +282.9%       1815 ±  2%    +282.9%       1815 ±  2%  time.system_time
     63.58           -17.2%      52.64 ±  3%     -17.8%      52.24 ±  5%     -18.4%      51.86 ±  3%  time.user_time
    347556 ±  6%     -26.4%     255772 ±  5%     -28.1%     249724 ±  5%     -28.4%     248893 ±  5%  time.voluntary_context_switches
    155577 ±  2%      -7.2%     144386 ±  3%      -9.3%     141161 ±  2%      -7.6%     143717 ±  2%  numa-meminfo.node0.PageTables
     12758 ±  8%    +171.6%      34650 ± 68%    +117.5%      27743 ± 38%    +122.3%      28364 ± 32%  numa-meminfo.node0.Shmem
  31281633 ±  6%     -37.6%   19515816 ± 25%     -36.1%   19979648 ± 27%     -42.1%   18122110 ± 25%  numa-meminfo.node1.Active
  31281573 ±  6%     -37.6%   19515752 ± 25%     -36.1%   19979597 ± 27%     -42.1%   18122082 ± 25%  numa-meminfo.node1.Active(anon)
  28059820 ±  5%     +40.6%   39461616 ± 15%     +44.6%   40576407 ± 14%     +50.4%   42208234 ± 12%  numa-meminfo.node1.Inactive
  28059215 ±  5%     +40.6%   39461201 ± 15%     +44.6%   40575754 ± 14%     +50.4%   42207926 ± 12%  numa-meminfo.node1.Inactive(anon)
    178279           -16.5%     148899 ±  2%     -14.1%     153180 ±  3%     -14.4%     152652 ±  2%  numa-meminfo.node1.PageTables
     20873 ±  7%    +215.2%      65784 ± 13%    +225.2%      67888 ±  5%    +243.6%      71729 ±  9%  numa-meminfo.node1.Shmem
     32068 ± 55%     -54.9%      14471 ± 69%     -22.1%      24988 ± 58%     -46.4%      17195 ± 65%  numa-meminfo.node1.SwapCached
      1296 ±  6%     -49.8%     650.40 ±  9%     -50.0%     647.65 ± 10%     -50.5%     641.72 ± 14%  numa-meminfo.node1.Writeback
     38311 ±  5%     -40.8%      22667           -41.1%      22583 ±  2%     -41.3%      22494        vm-scalability.median
   1234132 ±  4%     -40.7%     732265           -40.8%     730989 ±  3%     -40.9%     729108        vm-scalability.throughput
    239.68 ±  5%     +28.4%     307.63           +28.4%     307.85           +28.4%     307.77        vm-scalability.time.elapsed_time
    239.68 ±  5%     +28.4%     307.63           +28.4%     307.85           +28.4%     307.77        vm-scalability.time.elapsed_time.max
      6297 ±  5%     +60.9%      10134           +63.0%      10265           +63.5%      10295        vm-scalability.time.involuntary_context_switches
  62687446           -24.8%   47163918 ±  2%     -24.9%   47061196 ±  3%     -25.1%   46934963        vm-scalability.time.minor_page_faults
    224.00 ±  3%    +166.7%     597.33 ±  3%    +170.7%     606.31 ±  2%    +170.7%     606.40 ±  2%  vm-scalability.time.percent_of_cpu_this_job_got
    474.22 ±  3%    +276.7%       1786 ±  3%    +282.9%       1815 ±  2%    +282.9%       1815 ±  2%  vm-scalability.time.system_time
     63.58           -17.2%      52.64 ±  3%     -17.8%      52.24 ±  5%     -18.4%      51.86 ±  3%  vm-scalability.time.user_time
    347556 ±  6%     -26.4%     255772 ±  5%     -28.1%     249724 ±  5%     -28.4%     248893 ±  5%  vm-scalability.time.voluntary_context_switches
 2.821e+08           -22.0%    2.2e+08           -22.2%  2.196e+08 ±  2%     -22.3%  2.191e+08        vm-scalability.workload
     38829 ±  2%      -7.3%      35978 ±  3%      -9.5%      35150 ±  3%      -7.8%      35819 ±  2%  numa-vmstat.node0.nr_page_table_pages
      3197 ±  8%    +172.3%       8706 ± 67%    +117.4%       6953 ± 37%    +121.9%       7095 ± 32%  numa-vmstat.node0.nr_shmem
   4670410 ±  6%     -22.0%    3641951 ±  8%     -27.6%    3382558 ±  4%     -29.1%    3313347 ±  7%  numa-vmstat.node0.nr_vmscan_write
   9127776 ±  5%     -21.5%    7169554 ±  5%     -25.3%    6819419 ±  4%     -26.6%    6702778 ±  7%  numa-vmstat.node0.nr_written
  16661751 ± 42%     -59.8%    6694161 ± 70%     -29.8%   11689134 ± 53%     -43.1%    9474687 ± 66%  numa-vmstat.node0.numa_miss
  16734663 ± 41%     -59.5%    6770170 ± 69%     -29.9%   11733904 ± 53%     -43.0%    9533441 ± 66%  numa-vmstat.node0.numa_other
   7829198 ±  6%     -36.9%    4941489 ± 24%     -35.9%    5014994 ± 27%     -42.1%    4531460 ± 25%  numa-vmstat.node1.nr_active_anon
    718935 ± 14%     +53.9%    1106567 ± 31%     +32.7%     954186 ± 37%     +15.6%     830825 ± 13%  numa-vmstat.node1.nr_free_pages
   6977014 ±  5%     +39.1%    9704494 ± 15%     +44.1%   10053122 ± 14%     +50.5%   10503788 ± 12%  numa-vmstat.node1.nr_inactive_anon
     44508 ±  2%     -16.6%      37117 ±  2%     -14.3%      38152 ±  3%     -14.5%      38046 ±  2%  numa-vmstat.node1.nr_page_table_pages
      5222 ±  8%    +218.1%      16612 ± 13%    +225.6%      17003 ±  5%    +243.9%      17957 ±  9%  numa-vmstat.node1.nr_shmem
      8026 ± 55%     -55.0%       3611 ± 69%     -22.4%       6228 ± 58%     -46.6%       4289 ± 65%  numa-vmstat.node1.nr_swapcached
   8007802 ±  6%     -47.6%    4196794 ±  7%     -46.6%    4278458 ±  8%     -47.8%    4179885 ±  6%  numa-vmstat.node1.nr_vmscan_write
    352.06 ±  7%     -50.7%     173.73 ± 16%     -54.4%     160.39 ± 16%     -54.8%     158.99 ± 15%  numa-vmstat.node1.nr_writeback
  15775556 ±  6%     -45.5%    8590752 ±  5%     -44.3%    8782043 ±  9%     -44.4%    8775781 ±  4%  numa-vmstat.node1.nr_written
   7829176 ±  6%     -36.9%    4941484 ± 24%     -35.9%    5014989 ± 27%     -42.1%    4531456 ± 25%  numa-vmstat.node1.nr_zone_active_anon
   6977031 ±  5%     +39.1%    9704497 ± 15%     +44.1%   10053126 ± 14%     +50.5%   10503791 ± 12%  numa-vmstat.node1.nr_zone_inactive_anon
    346.80 ±  7%     -49.9%     173.73 ± 16%     -53.9%     159.98 ± 16%     -54.1%     159.14 ± 15%  numa-vmstat.node1.nr_zone_write_pending
  16665351 ± 42%     -59.8%    6694094 ± 70%     -29.9%   11678532 ± 53%     -43.3%    9441584 ± 66%  numa-vmstat.node1.numa_foreign
  26917054 ± 23%     -60.1%   10749940 ± 49%     -39.8%   16204771 ± 41%     -47.6%   14113544 ± 47%  numa-vmstat.node1.numa_hit
  26856045 ± 23%     -60.2%   10693045 ± 50%     -39.9%   16138287 ± 41%     -47.7%   14039526 ± 47%  numa-vmstat.node1.numa_local
    427.78 ± 20%     +93.8%     828.91 ± 64%     +36.8%     585.39 ± 15%     +25.7%     537.74 ± 15%  sched_debug.cfs_rq:/.load_avg.max
     13.46 ± 23%     -63.0%       4.98 ± 47%     -50.7%       6.64 ± 46%     -56.0%       5.92 ± 43%  sched_debug.cfs_rq:/.removed.load_avg.avg
     59.42 ± 17%     -48.6%      30.57 ± 34%     -42.0%      34.44 ± 23%     -43.9%      33.35 ± 32%  sched_debug.cfs_rq:/.removed.load_avg.stddev
    152.11 ± 26%     -36.2%      96.98 ± 50%     -35.2%      98.50 ± 14%     -28.0%     109.46 ± 31%  sched_debug.cfs_rq:/.removed.runnable_avg.max
    152.11 ± 26%     -36.3%      96.87 ± 50%     -35.3%      98.34 ± 15%     -28.1%     109.40 ± 31%  sched_debug.cfs_rq:/.removed.util_avg.max
     81.74 ± 14%     +11.4%      91.02 ±  5%     +24.1%     101.46 ±  8%     +19.8%      97.92 ±  5%  sched_debug.cfs_rq:/.runnable_avg.avg
    114.05 ± 16%     +23.9%     141.35 ±  2%     +31.5%     150.02 ±  5%     +29.2%     147.38 ±  4%  sched_debug.cfs_rq:/.runnable_avg.stddev
     81.31 ± 14%     +11.5%      90.70 ±  5%     +24.2%     100.99 ±  8%     +19.9%      97.52 ±  5%  sched_debug.cfs_rq:/.util_avg.avg
    113.70 ± 16%     +23.9%     140.92 ±  2%     +31.5%     149.52 ±  5%     +29.3%     147.02 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
     10.59 ± 25%    +131.9%      24.56 ± 10%    +142.6%      25.70 ± 29%    +142.5%      25.69 ± 12%  sched_debug.cfs_rq:/.util_est.avg
     49.96 ± 28%     +71.7%      85.76 ±  5%     +77.0%      88.41 ± 16%     +86.3%      93.05 ±  8%  sched_debug.cfs_rq:/.util_est.stddev
    130266 ± 19%     +38.9%     180973 ±  8%     +28.9%     167881 ±  7%     +29.6%     168787 ±  8%  sched_debug.cpu.clock.avg
    130457 ± 19%     +38.9%     181208 ±  8%     +28.9%     168141 ±  7%     +29.5%     169004 ±  7%  sched_debug.cpu.clock.max
    130028 ± 19%     +38.9%     180638 ±  8%     +28.8%     167497 ±  7%     +29.6%     168482 ±  8%  sched_debug.cpu.clock.min
    129816 ± 19%     +39.0%     180459 ±  8%     +29.0%     167404 ±  7%     +29.6%     168307 ±  8%  sched_debug.cpu.clock_task.avg
    130389 ± 19%     +38.9%     181122 ±  8%     +28.9%     168056 ±  7%     +29.6%     168923 ±  7%  sched_debug.cpu.clock_task.max
    121562 ± 20%     +40.5%     170799 ±  8%     +29.8%     157738 ±  8%     +30.5%     158608 ±  8%  sched_debug.cpu.clock_task.min
    573.18 ± 25%     +47.9%     847.53 ±  8%     +28.1%     734.25 ± 11%     +27.2%     728.81 ± 15%  sched_debug.cpu.nr_switches.min
      0.15 ± 11%      +8.3%       0.17 ± 11%     +15.9%       0.18 ± 15%     +20.3%       0.18 ±  7%  sched_debug.cpu.nr_uninterruptible.avg
      4.07 ± 14%     +43.8%       5.86 ±  5%     +41.2%       5.75 ± 10%     +42.1%       5.79 ±  9%  sched_debug.cpu.nr_uninterruptible.stddev
    130026 ± 19%     +38.9%     180621 ±  8%     +28.8%     167481 ±  7%     +29.6%     168466 ±  8%  sched_debug.cpu_clk
    129318 ± 19%     +39.1%     179912 ±  8%     +29.0%     166774 ±  7%     +29.7%     167759 ±  8%  sched_debug.ktime
    130797 ± 19%     +38.7%     181392 ±  8%     +28.6%     168261 ±  7%     +29.4%     169239 ±  8%  sched_debug.sched_clk
    191035 ±  7%     -29.3%     135009 ±  4%     -29.8%     134046 ±  8%     -29.9%     133825 ±  4%  proc-vmstat.allocstall_movable
      3850 ± 11%     +78.5%       6872 ± 12%     +69.7%       6532 ± 10%     +76.3%       6786 ± 10%  proc-vmstat.allocstall_normal
  13525554 ± 10%     -32.5%    9125751 ± 17%     -21.4%   10625542 ± 26%     -29.1%    9588171 ± 29%  proc-vmstat.nr_active_anon
  16631565 ±  8%     +23.8%   20588362 ±  9%     +15.8%   19252926 ± 14%     +23.8%   20585579 ± 13%  proc-vmstat.nr_inactive_anon
     83457           -12.1%      73319           -11.8%      73637 ±  2%     -11.2%      74151        proc-vmstat.nr_page_table_pages
      8392 ±  3%    +198.4%      25047 ± 26%    +184.6%      23884 ± 12%    +196.1%      24854 ± 10%  proc-vmstat.nr_shmem
     79380            -0.4%      79057            -0.3%      79108            -5.1%      75299        proc-vmstat.nr_slab_unreclaimable
  12629057 ±  5%     -39.1%    7691618 ±  5%     -39.8%    7607004 ±  5%     -41.2%    7422326 ±  5%  proc-vmstat.nr_vmscan_write
    440.92 ± 10%     -42.0%     255.71 ± 15%     -46.9%     234.18 ± 13%     -43.9%     247.16 ± 15%  proc-vmstat.nr_writeback
  24903332 ±  5%     -36.7%   15760306 ±  4%     -37.4%   15601462 ±  7%     -37.8%   15478560 ±  5%  proc-vmstat.nr_written
  13525564 ± 10%     -32.5%    9125755 ± 17%     -21.4%   10625546 ± 26%     -29.1%    9588177 ± 29%  proc-vmstat.nr_zone_active_anon
  16631569 ±  8%     +23.8%   20588365 ±  9%     +15.8%   19252929 ± 14%     +23.8%   20585582 ± 13%  proc-vmstat.nr_zone_inactive_anon
    443.01 ± 10%     -42.0%     257.00 ± 16%     -47.0%     234.79 ± 13%     -43.4%     250.68 ± 14%  proc-vmstat.nr_zone_write_pending
  24485570 ±  3%     -15.4%   20714438 ±  3%     -15.2%   20753649 ±  3%     -16.4%   20472331 ±  3%  proc-vmstat.numa_foreign
  39260606 ±  2%     -30.1%   27457969 ±  4%     -30.4%   27338587 ±  6%     -30.0%   27473772 ±  2%  proc-vmstat.numa_hit
  39098081 ±  2%     -30.1%   27325222 ±  4%     -30.4%   27205934 ±  6%     -30.1%   27340944 ±  2%  proc-vmstat.numa_local
  24482446 ±  3%     -15.5%   20696329 ±  3%     -15.2%   20764313 ±  3%     -16.1%   20537690 ±  3%  proc-vmstat.numa_miss
  24643161 ±  3%     -15.5%   20828939 ±  3%     -15.2%   20886221 ±  3%     -16.3%   20637029 ±  3%  proc-vmstat.numa_other
   7478080 ± 19%    +140.2%   17959948 ±  8%    +149.2%   18637853 ± 14%    +149.0%   18622062 ± 11%  proc-vmstat.numa_pte_updates
  63140512           -24.7%   47553512           -24.7%   47523846 ±  3%     -25.0%   47327605 ±  2%  proc-vmstat.pgalloc_normal
  63461017           -24.5%   47896127 ±  2%     -24.7%   47801824 ±  3%     -24.9%   47669279        proc-vmstat.pgfault
  64134373           -24.6%   48331932 ±  2%     -25.1%   48010799 ±  3%     -25.2%   47988257        proc-vmstat.pgfree
      2796 ± 78%     -70.9%     815.00 ± 50%     -57.0%       1202 ± 64%     -72.0%     782.30 ± 64%  proc-vmstat.pgmigrate_fail
  99615377 ±  5%     -36.7%   63043276 ±  4%     -37.4%   62407899 ±  7%     -37.8%   61916291 ±  5%  proc-vmstat.pgpgout
     34932 ±  3%      -7.8%      32198 ±  2%      -8.1%      32104 ±  3%      -8.9%      31826 ±  2%  proc-vmstat.pgreuse
  21507042 ±  5%     -36.0%   13775181 ±  4%     -36.7%   13623024 ±  7%     -37.3%   13487008 ±  5%  proc-vmstat.pgrotated
  58427243 ± 10%     -43.5%   32993860 ± 12%     -39.1%   35582889 ± 16%     -42.7%   33494232 ± 18%  proc-vmstat.pgscan_anon
  44324880 ± 10%     -37.2%   27839440 ± 10%     -34.2%   29186311 ± 14%     -36.9%   27972671 ± 15%  proc-vmstat.pgscan_direct
  14102763 ± 23%     -63.4%    5154838 ± 27%     -54.6%    6396957 ± 40%     -60.8%    5521838 ± 35%  proc-vmstat.pgscan_kswapd
      2666 ± 88%     -90.7%     248.33 ±137%     -78.1%     583.38 ± 97%     -83.3%     446.20 ±124%  proc-vmstat.pgskip_normal
  24911061 ±  5%     -36.7%   15767491 ±  4%     -37.3%   15611299 ±  7%     -37.8%   15487227 ±  5%  proc-vmstat.pgsteal_anon
  17074863 ±  8%     -25.3%   12754191 ±  5%     -26.2%   12608140 ±  7%     -26.4%   12564844 ±  4%  proc-vmstat.pgsteal_direct
   7836517 ±  8%     -61.5%    3013661 ±  7%     -61.7%    3003472 ±  8%     -62.7%    2922611 ± 11%  proc-vmstat.pgsteal_kswapd
  24903332 ±  5%     -36.7%   15760306 ±  4%     -37.4%   15601462 ±  7%     -37.8%   15478560 ±  5%  proc-vmstat.pswpout
     78185 ± 27%     -82.8%      13463 ± 52%     -74.5%      19910 ± 68%     -71.3%      22474 ± 49%  proc-vmstat.workingset_nodereclaim
      1.85 ±  4%     -31.7%       1.26           -32.9%       1.24 ±  2%     -34.2%       1.22 ±  2%  perf-stat.i.MPKI
 1.992e+09 ±  3%     -18.9%  1.615e+09 ±  2%     -17.6%  1.641e+09 ±  2%     -17.0%  1.653e+09        perf-stat.i.branch-instructions
      0.93 ±  6%      +0.6        1.55 ±  3%      +0.6        1.55 ±  3%      +0.6        1.54 ±  2%  perf-stat.i.branch-miss-rate%
  14377927 ± 11%     +29.7%   18645141 ±  5%     +33.1%   19132687           +34.0%   19271478        perf-stat.i.branch-misses
     13.97 ±  3%      -9.0        4.95            -9.0        4.98 ±  2%      -9.0        4.92 ±  2%  perf-stat.i.cache-miss-rate%
  15782867 ±  3%     -34.3%   10364434 ±  2%     -33.6%   10475081 ±  2%     -33.7%   10458719 ±  2%  perf-stat.i.cache-misses
  79049148           +92.6%  1.522e+08 ±  2%     +93.5%   1.53e+08           +94.1%  1.534e+08 ±  2%  perf-stat.i.cache-references
      5344           -29.2%       3783 ±  2%     -29.8%       3752 ±  3%     -29.8%       3750 ±  2%  perf-stat.i.context-switches
      1.31 ±  2%    +316.3%       5.46 ±  3%    +317.0%       5.47 ±  3%    +319.5%       5.50 ±  2%  perf-stat.i.cpi
 8.392e+09 ±  3%    +197.0%  2.492e+10 ±  3%    +201.9%  2.534e+10 ±  2%    +204.2%  2.553e+10 ±  2%  perf-stat.i.cpu-cycles
    150.26           +14.1%     171.44 ±  3%     +15.3%     173.26 ±  4%     +15.4%     173.37 ±  3%  perf-stat.i.cpu-migrations
    737.89 ±  5%    +500.7%       4432 ±  4%    +514.1%       4531 ±  3%    +529.4%       4644 ±  3%  perf-stat.i.cycles-between-cache-misses
 7.732e+09 ±  3%     -17.2%  6.405e+09 ±  2%     -15.9%  6.502e+09 ±  2%     -15.3%  6.551e+09        perf-stat.i.instructions
      0.80           -69.8%       0.24 ±  5%     -69.9%       0.24 ±  3%     -70.5%       0.24 ±  2%  perf-stat.i.ipc
     23.75 ± 27%     -52.9%      11.19 ± 69%     -23.7%      18.12 ± 42%     -39.8%      14.31 ± 47%  perf-stat.i.major-faults
      2.55 ±  8%     -38.4%       1.57 ±  4%     -36.8%       1.61 ±  2%     -36.3%       1.62        perf-stat.i.metric.K/sec
    265295 ±  5%     -42.5%     152670 ±  2%     -41.6%     155041 ±  3%     -41.4%     155453        perf-stat.i.minor-faults
    265319 ±  5%     -42.5%     152681 ±  2%     -41.6%     155059 ±  3%     -41.4%     155468        perf-stat.i.page-faults
      2.04 ±  2%     -20.6%       1.62 ±  2%     -21.2%       1.61           -21.9%       1.59 ±  2%  perf-stat.overall.MPKI
      0.72 ± 12%      +0.4        1.15 ±  4%      +0.4        1.17 ±  2%      +0.4        1.17        perf-stat.overall.branch-miss-rate%
     19.95 ±  2%     -13.1        6.84           -13.1        6.82 ±  2%     -13.2        6.79 ±  2%  perf-stat.overall.cache-miss-rate%
      1.09 ±  2%    +257.6%       3.88 ±  3%    +260.0%       3.91 ±  3%    +259.9%       3.91 ±  2%  perf-stat.overall.cpi
    532.42 ±  2%    +350.1%       2396 ±  4%    +356.9%       2432 ±  3%    +360.8%       2453 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.92           -72.0%       0.26 ±  4%     -72.2%       0.26 ±  3%     -72.2%       0.26 ±  2%  perf-stat.overall.ipc
      6551 ±  2%     +38.5%       9072           +39.5%       9138           +40.0%       9171        perf-stat.overall.path-length
 1.982e+09 ±  3%     -18.5%  1.616e+09           -17.8%  1.629e+09 ±  2%     -17.2%  1.641e+09        perf-stat.ps.branch-instructions
  14325844 ± 11%     +29.7%   18584702 ±  5%     +33.0%   19054101           +33.9%   19184930        perf-stat.ps.branch-misses
  15697779 ±  3%     -33.9%   10379452 ±  2%     -33.8%   10385651 ±  2%     -33.9%   10369490 ±  2%  perf-stat.ps.cache-misses
  78678984           +93.0%  1.518e+08 ±  2%     +93.7%  1.524e+08           +94.3%  1.528e+08 ±  2%  perf-stat.ps.cache-references
      5321           -29.1%       3771 ±  2%     -29.7%       3740 ±  3%     -29.8%       3737 ±  2%  perf-stat.ps.context-switches
 8.355e+09 ±  3%    +197.6%  2.487e+10 ±  3%    +202.1%  2.524e+10 ±  2%    +204.3%  2.543e+10 ±  2%  perf-stat.ps.cpu-cycles
    149.59           +14.2%     170.85 ±  3%     +15.4%     172.66 ±  4%     +15.5%     172.78 ±  3%  perf-stat.ps.cpu-migrations
 7.693e+09 ±  3%     -16.8%  6.404e+09           -16.0%  6.459e+09 ±  2%     -15.4%  6.507e+09        perf-stat.ps.instructions
     23.73 ± 27%     -52.9%      11.18 ± 69%     -23.5%      18.15 ± 43%     -39.7%      14.31 ± 48%  perf-stat.ps.major-faults
    263785 ±  5%     -41.9%     153177           -41.8%     153437 ±  3%     -41.7%     153864        perf-stat.ps.minor-faults
    263809 ±  5%     -41.9%     153188           -41.8%     153455 ±  3%     -41.7%     153879        perf-stat.ps.page-faults
 1.848e+12 ±  2%      +8.0%  1.995e+12            +8.5%  2.006e+12            +8.7%  2.009e+12        perf-stat.total.instructions
      0.09 ±  3%    +316.6%       0.37 ±135%    +154.1%       0.22 ±143%    +255.1%       0.31 ±151%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.11 ± 13%     -45.7%       0.06 ± 83%     -51.4%       0.05 ±105%     -62.6%       0.04 ±118%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.folio_alloc_swap.add_to_swap.shrink_folio_list
      0.04 ± 15%     -34.4%       0.02 ± 16%     -38.3%       0.02 ± 44%     -34.9%       0.02 ± 26%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.05 ± 17%    +600.7%       0.34 ±172%    +199.1%       0.15 ±192%    +905.3%       0.49 ±255%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ± 26%   +2198.6%       0.27 ±152%  +15606.1%       1.83 ±182%    +681.7%       0.09 ± 28%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.06 ±  8%     +41.6%       0.09 ± 17%     +34.7%       0.09 ± 16%     +31.1%       0.08 ± 18%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.07 ±  8%     +36.7%       0.10 ± 15%     +16.9%       0.08 ± 12%    +225.8%       0.23 ±182%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ±  4%      -5.6%       0.01 ± 29%      +6.8%       0.01 ± 91%     -21.7%       0.01 ± 16%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.18 ± 45%  +14663.2%     173.84 ±219%   +5633.0%      67.51 ±366%   +9459.9%     112.57 ±271%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.16 ±  7%     +81.8%       0.29 ± 22%   +7048.0%      11.56 ±377%     +37.8%       0.22 ± 16%  perf-sched.sch_delay.max.ms.__cond_resched.mempool_alloc_noprof.bio_alloc_bioset.__swap_writepage.swap_writepage
      0.13 ± 13%     -55.3%       0.06 ± 83%     -55.6%       0.06 ±104%     -65.7%       0.04 ±116%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.folio_alloc_swap.add_to_swap.shrink_folio_list
      0.10 ± 23%     +14.1%       0.12 ± 65%     +56.1%       0.16 ± 53%    +102.9%       0.21 ± 25%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.18 ± 11%   +8754.6%      15.60 ±219%   +3486.4%       6.32 ±370%  +21811.5%      38.60 ±297%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.35 ±107%   +2644.1%     256.70 ±154%   +1144.2%     116.39 ±206%    +667.0%      71.75 ±138%  perf-sched.sch_delay.max.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
      0.15 ± 25%    +100.0%       0.31 ± 52%     +78.6%       0.27 ± 25%    +146.6%       0.38 ± 72%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.17 ± 10%     +74.6%       0.30 ± 15%     +48.4%       0.26 ± 16%   +3855.3%       6.83 ±288%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.16 ± 12%    +391.4%       0.80 ±148%  +11691.7%      19.20 ±272%   +7032.4%      11.61 ±155%  perf-sched.sch_delay.max.ms.schedule_timeout.io_schedule_timeout.mempool_alloc_noprof.bio_alloc_bioset
      0.11 ± 94%   +1386.1%       1.62 ± 66%   +2315.9%       2.63 ±235%    +971.1%       1.17 ± 75%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.15 ± 18%     +45.5%       0.22 ± 13%     +42.4%       0.22 ± 19%     +46.8%       0.22 ± 21%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
     87.69 ±  2%     +57.5%     138.09 ±  4%     +64.0%     143.78 ±  6%     +69.1%     148.27 ±  5%  perf-sched.total_wait_and_delay.average.ms
     87.52 ±  2%     +57.6%     137.91 ±  4%     +64.1%     143.59 ±  6%     +69.3%     148.15 ±  5%  perf-sched.total_wait_time.average.ms
      5.16 ±  8%     +20.1%       6.20 ± 15%      +9.7%       5.66 ± 14%     +26.9%       6.54 ± 13%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      7.23 ±142%    +493.8%      42.93 ± 11%    +581.8%      49.29 ± 12%    +581.8%      49.29 ± 14%  perf-sched.wait_and_delay.avg.ms.__cond_resched.mempool_alloc_noprof.bio_alloc_bioset.__swap_writepage.swap_writepage
     89.03 ± 56%     -97.9%       1.83 ±152%     -89.9%       9.00 ±166%     -93.5%       5.80 ± 69%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.__folio_lock_or_retry.do_swap_page
     21.44 ±  3%     +88.0%      40.32 ±  7%    +102.6%      43.43 ±  7%     +99.2%      42.71 ±  5%  perf-sched.wait_and_delay.avg.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
    383.35 ±  3%      +8.2%     414.60 ±  3%      +6.6%     408.50 ±  3%     +10.1%     422.07 ±  4%  perf-sched.wait_and_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
     40.29 ± 34%    +602.5%     283.08 ± 58%    +804.7%     364.55 ± 27%    +691.2%     318.81 ± 28%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.06          -100.0%       0.00          -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    338.75 ± 23%     -65.9%     115.54 ± 72%     -59.4%     137.63 ± 81%     -41.1%     199.64 ± 55%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     20.91 ±  4%     +64.7%      34.43 ±  6%     +80.9%      37.82 ±  8%     +75.6%      36.71 ±  5%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.io_schedule_timeout.mempool_alloc_noprof.bio_alloc_bioset
      5.97 ±  8%     -27.5%       4.33           -26.1%       4.42 ±  3%     -25.8%       4.43 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    527.31 ±  2%     +20.9%     637.26 ± 10%     +18.4%     624.19 ±  5%     +22.5%     645.76 ±  8%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    159.81 ±  2%     +78.2%     284.75 ±  9%     +76.7%     282.46 ± 11%     +83.8%     293.80 ± 12%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    640.33 ± 11%     +33.5%     854.67 ± 16%     +25.1%     800.88 ± 17%     +56.1%     999.80 ± 31%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     26.83 ±141%    +777.6%     235.50 ± 20%    +724.8%     221.31 ± 21%    +886.8%     264.80 ± 33%  perf-sched.wait_and_delay.count.__cond_resched.mempool_alloc_noprof.bio_alloc_bioset.__swap_writepage.swap_writepage
      5.00           +43.3%       7.17 ± 12%     +33.8%       6.69 ± 15%     +58.0%       7.90 ± 32%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      7206 ±  4%     -28.5%       5149 ± 12%     -40.5%       4290 ± 14%     -25.6%       5361 ± 35%  perf-sched.wait_and_delay.count.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
      8.67 ± 10%     +38.5%      12.00 ± 16%     +29.8%      11.25 ± 18%     +61.5%      14.00 ± 33%  perf-sched.wait_and_delay.count.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
    160.17 ± 10%    -100.0%       0.00          -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    112.17 ± 33%    +279.8%     426.00 ± 13%    +241.2%     382.69 ± 26%    +339.2%     492.60 ± 49%  perf-sched.wait_and_delay.count.schedule_timeout.io_schedule_timeout.mempool_alloc_noprof.bio_alloc_bioset
    639.00 ± 11%    +120.6%       1409 ± 18%     +97.7%       1263 ± 16%    +141.3%       1542 ± 35%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     15.52 ±141%   +4400.0%     698.48 ± 63%   +5577.1%     881.17 ± 46%   +5092.6%     805.97 ± 58%  perf-sched.wait_and_delay.max.ms.__cond_resched.mempool_alloc_noprof.bio_alloc_bioset.__swap_writepage.swap_writepage
      3425 ± 44%     -99.4%      22.13 ±141%     -92.9%     243.04 ±282%     -97.5%      84.27 ±127%  perf-sched.wait_and_delay.max.ms.io_schedule.folio_wait_bit_common.__folio_lock_or_retry.do_swap_page
      1212 ±  4%     +81.2%       2197 ± 12%    +100.1%       2426 ± 23%    +172.1%       3300 ± 76%  perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      6.49 ± 46%    -100.0%       0.00          -100.0%       0.00          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     59.14 ± 24%    +280.8%     225.17 ±153%    +178.2%     164.54 ±133%     +72.1%     101.75 ± 23%  perf-sched.wait_and_delay.max.ms.schedule_timeout.io_schedule_timeout.mempool_alloc_noprof.bio_alloc_bioset
     81.27 ± 26%     -60.3%      32.25 ± 60%      -6.6%      75.94 ± 87%     -27.1%      59.23 ± 48%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      3448 ± 12%     +48.4%       5119 ± 23%     +31.3%       4528 ± 22%     +55.0%       5346 ± 33%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      5.07 ±  8%     +15.0%       5.83 ±  9%      +7.2%       5.44 ± 10%     +22.9%       6.23 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     21.71 ±  7%     +97.3%      42.83 ± 11%    +126.1%      49.07 ± 12%    +126.6%      49.19 ± 15%  perf-sched.wait_time.avg.ms.__cond_resched.mempool_alloc_noprof.bio_alloc_bioset.__swap_writepage.swap_writepage
     23.06 ± 17%     +47.2%      33.94 ± 51%     +96.9%      45.41 ± 33%     +83.6%      42.33 ± 17%  perf-sched.wait_time.avg.ms.__cond_resched.rmap_walk_anon.try_to_unmap.shrink_folio_list.evict_folios
      6.41 ± 96%    +426.5%      33.77 ± 20%    +449.5%      35.25 ± 21%    +449.5%      35.25 ± 37%  perf-sched.wait_time.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      9.59 ± 52%    +792.6%      85.58 ± 27%    +958.8%     101.51 ± 22%    +875.0%      93.48 ± 24%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     88.96 ± 56%     -90.5%       8.44 ± 53%     -80.2%      17.61 ±113%     -89.0%       9.76 ± 37%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.__folio_lock_or_retry.do_swap_page
     21.33 ±  3%     +88.1%      40.12 ±  6%    +102.3%      43.16 ±  7%     +99.5%      42.56 ±  5%  perf-sched.wait_time.avg.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
    383.33 ±  3%      +8.2%     414.58 ±  3%      +6.6%     408.48 ±  3%     +10.1%     422.05 ±  4%  perf-sched.wait_time.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
     20.96 ± 16%     +67.9%      35.18 ± 50%    +121.1%      46.33 ± 46%    +111.4%      44.29 ± 23%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
     40.28 ± 34%    +602.1%     282.81 ± 59%    +800.4%     362.72 ± 27%    +691.2%     318.72 ± 28%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.97           -16.8%       3.30 ±  3%     -12.8%       3.46 ± 10%     -11.9%       3.50 ±  5%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    338.69 ± 23%     -54.8%     153.25 ± 23%     -47.4%     178.01 ± 38%     -33.6%     224.74 ± 30%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     22.02 ± 23%    +462.9%     123.94 ± 26%    +370.4%     103.58 ± 20%    +430.7%     116.84 ± 30%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     20.81 ±  4%     +65.0%      34.33 ±  6%     +80.8%      37.63 ±  9%     +75.8%      36.58 ±  5%  perf-sched.wait_time.avg.ms.schedule_timeout.io_schedule_timeout.mempool_alloc_noprof.bio_alloc_bioset
      5.87 ±  8%     -28.1%       4.22           -26.8%       4.29 ±  3%     -26.3%       4.33 ±  3%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    527.30 ±  2%     +20.9%     637.25 ± 10%     +18.4%     624.18 ±  5%     +22.5%     645.75 ±  8%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    159.22 ±  2%     +78.8%     284.72 ±  9%     +77.4%     282.42 ± 11%     +84.5%     293.76 ± 12%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     42.83 ±  9%   +1530.6%     698.38 ± 63%   +1957.2%     881.10 ± 46%   +1781.5%     805.85 ± 58%  perf-sched.wait_time.max.ms.__cond_resched.mempool_alloc_noprof.bio_alloc_bioset.__swap_writepage.swap_writepage
     12.83 ± 82%    +344.6%      57.05 ± 10%    +364.9%      59.65 ± 14%    +437.6%      68.98 ± 42%  perf-sched.wait_time.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
    124.59 ± 77%    +333.7%     540.35 ± 31%    +480.6%     723.45 ± 41%    +647.9%     931.82 ± 57%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35.21 ± 27%     +27.5%      44.90 ± 49%     +62.6%      57.25 ± 54%     +62.0%      57.03 ± 20%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      1212 ±  4%     +81.2%       2197 ± 12%    +100.1%       2426 ± 23%    +172.1%       3299 ± 76%  perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    220.10 ± 74%    +283.8%     844.67 ± 11%    +239.2%     746.66 ± 33%    +262.0%     796.72 ± 31%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     59.03 ± 24%    +281.3%     225.09 ±154%    +163.3%     155.44 ±142%     +72.2%     101.64 ± 24%  perf-sched.wait_time.max.ms.schedule_timeout.io_schedule_timeout.mempool_alloc_noprof.bio_alloc_bioset
     81.17 ± 26%     -60.4%      32.15 ± 60%     -22.6%      62.82 ± 78%     -27.2%      59.11 ± 48%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      3385 ± 10%     +51.2%       5119 ± 23%     +33.7%       4528 ± 22%     +57.9%       5346 ± 33%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     79.77           -10.1       69.65           -10.8       69.01 ±  3%     -10.3       69.43 ±  3%  perf-profile.calltrace.cycles-pp.do_access
     77.33            -7.8       69.51            -8.4       68.90 ±  3%      -8.0       69.31 ±  3%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
      7.43 ±  2%      -6.8        0.66 ± 13%      -6.8        0.66 ±  6%      -6.8        0.67 ±  4%  perf-profile.calltrace.cycles-pp.add_to_swap.shrink_folio_list.evict_folios.try_to_shrink_lruvec.shrink_one
      6.76 ±  5%      -5.8        0.95 ±  5%      -5.8        0.97 ±  4%      -5.9        0.90 ±  4%  perf-profile.calltrace.cycles-pp.llist_add_batch.smp_call_function_many_cond.on_each_cpu_cond_mask.arch_tlbbatch_flush.try_to_unmap_flush_dirty
      6.24 ±  2%      -5.7        0.58 ± 12%      -5.7        0.58 ±  7%      -5.6        0.59 ±  4%  perf-profile.calltrace.cycles-pp.folio_alloc_swap.add_to_swap.shrink_folio_list.evict_folios.try_to_shrink_lruvec
      5.73 ±  4%      -5.6        0.17 ±141%      -5.5        0.23 ±113%      -5.5        0.26 ±100%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.smp_call_function_many_cond.on_each_cpu_cond_mask.arch_tlbbatch_flush.try_to_unmap_flush_dirty
     74.64            -5.4       69.25            -6.0       68.69 ±  3%      -5.5       69.11 ±  3%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
     74.54            -5.3       69.25            -5.9       68.69 ±  3%      -5.4       69.10 ±  3%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
      5.79 ±  3%      -5.2        0.55 ± 11%      -5.2        0.56 ±  7%      -5.2        0.57 ±  4%  perf-profile.calltrace.cycles-pp.__mem_cgroup_try_charge_swap.folio_alloc_swap.add_to_swap.shrink_folio_list.evict_folios
      5.51 ±  4%      -5.1        0.37 ± 72%      -5.4        0.10 ±208%      -5.5        0.05 ±299%  perf-profile.calltrace.cycles-pp.do_rw_once
     73.45            -4.3       69.17            -4.8       68.63 ±  3%      -4.4       69.04 ±  3%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
      3.92 ±  2%      -3.5        0.44 ± 44%      -3.7        0.26 ±100%      -3.7        0.22 ±122%  perf-profile.calltrace.cycles-pp.default_send_IPI_mask_sequence_phys.smp_call_function_many_cond.on_each_cpu_cond_mask.arch_tlbbatch_flush.try_to_unmap_flush_dirty
     72.77            -2.9       69.91            -3.2       69.54 ±  3%      -2.8       69.97 ±  3%  perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     74.31            -1.9       72.37            -1.6       72.73            -1.8       72.54 ±  2%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.4        0.42 ± 72%      +0.7        0.71 ± 33%      +0.7        0.73 ± 17%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.4        0.43 ± 72%      +0.7        0.71 ± 34%      +0.7        0.73 ± 17%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      0.00            +0.4        0.43 ± 72%      +0.7        0.71 ± 34%      +0.7        0.73 ± 17%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      0.00            +0.5        0.46 ± 72%      +0.8        0.82 ± 23%      +0.8        0.79 ± 19%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      0.00            +0.5        0.46 ± 72%      +0.8        0.82 ± 23%      +0.8        0.79 ± 19%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
      0.00            +0.6        0.59 ±  7%      +0.6        0.57 ±  5%      +0.6        0.57 ±  6%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +0.7        0.66 ±  5%      +0.6        0.63 ±  6%      +0.6        0.62 ±  3%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.cpuidle_enter_state
      0.00            +0.7        0.69 ±  5%      +0.7        0.66 ±  5%      +0.7        0.65 ±  4%  perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.cpuidle_enter_state.cpuidle_enter
      0.00            +0.8        0.81 ± 26%      +0.7        0.75 ± 23%      +0.8        0.83 ± 13%  perf-profile.calltrace.cycles-pp.handle_mm_fault.__get_user_pages.get_user_pages_remote.get_arg_page.copy_string_kernel
      0.00            +0.8        0.81 ± 26%      +0.7        0.75 ± 22%      +0.8        0.83 ± 13%  perf-profile.calltrace.cycles-pp.__get_user_pages.get_user_pages_remote.get_arg_page.copy_string_kernel.do_execveat_common
      0.00            +0.8        0.81 ± 26%      +0.7        0.75 ± 22%      +0.8        0.83 ± 13%  perf-profile.calltrace.cycles-pp.copy_string_kernel.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.8        0.81 ± 26%      +0.7        0.75 ± 22%      +0.8        0.83 ± 13%  perf-profile.calltrace.cycles-pp.get_arg_page.copy_string_kernel.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.00            +0.8        0.81 ± 26%      +0.7        0.75 ± 22%      +0.8        0.83 ± 13%  perf-profile.calltrace.cycles-pp.get_user_pages_remote.get_arg_page.copy_string_kernel.do_execveat_common.__x64_sys_execve
      0.00            +0.8        0.81 ± 12%      +1.0        0.95 ± 20%      +0.9        0.92 ± 44%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.00            +0.8        0.81 ± 12%      +1.0        0.95 ± 20%      +0.9        0.92 ± 44%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      0.00            +0.8        0.81 ± 12%      +1.0        0.95 ± 20%      +0.9        0.92 ± 44%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      0.00            +0.8        0.81 ± 12%      +1.0        0.95 ± 19%      +0.9        0.92 ± 44%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.9        0.95 ± 19%      +1.3        1.26 ± 17%      +1.2        1.20 ± 16%  perf-profile.calltrace.cycles-pp._Fork
      0.08 ±223%      +1.0        1.06 ± 12%      +1.0        1.06 ± 20%      +1.0        1.09 ± 26%  perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.wp_page_copy
      0.08 ±223%      +1.0        1.06 ± 12%      +1.0        1.06 ± 20%      +1.0        1.09 ± 26%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.wp_page_copy.__handle_mm_fault
      0.08 ±223%      +1.0        1.06 ± 12%      +1.0        1.06 ± 20%      +1.0        1.09 ± 26%  perf-profile.calltrace.cycles-pp.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.wp_page_copy.__handle_mm_fault.handle_mm_fault
      0.08 ±223%      +1.0        1.06 ± 12%      +1.0        1.06 ± 20%      +1.0        1.09 ± 26%  perf-profile.calltrace.cycles-pp.vma_alloc_folio_noprof.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.09 ±223%      +1.0        1.06 ± 12%      +1.0        1.06 ± 20%      +1.0        1.09 ± 26%  perf-profile.calltrace.cycles-pp.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.00            +1.3        1.26 ±  7%      +1.2        1.21 ±  4%      +1.2        1.21 ±  6%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +1.4        1.36 ± 30%      +1.2        1.18 ± 35%      +1.3        1.33 ± 20%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.__get_user_pages.get_user_pages_remote.get_arg_page
      0.00            +1.6        1.64 ±  6%      +1.5        1.55 ±  5%      +1.5        1.54 ±  5%  perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.21 ± 46%      +2.0        3.22 ± 29%      +2.7        3.94 ± 34%      +2.2        3.40 ± 29%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      1.20 ± 46%      +2.0        3.22 ± 29%      +2.7        3.94 ± 34%      +2.2        3.40 ± 29%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      1.20 ± 46%      +2.0        3.22 ± 29%      +2.7        3.94 ± 34%      +2.2        3.40 ± 29%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.18 ± 47%      +2.0        3.22 ± 29%      +2.8        3.93 ± 34%      +2.2        3.39 ± 29%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +2.1        2.09 ±  7%      +2.0        1.97 ±  5%      +1.9        1.95 ±  4%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.30 ±100%      +2.2        2.48 ± 11%      +2.3        2.65 ± 13%      +2.4        2.69 ± 14%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.30 ±100%      +2.2        2.48 ± 11%      +2.3        2.65 ± 13%      +2.4        2.69 ± 14%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.30 ±100%      +2.2        2.48 ± 11%      +2.3        2.65 ± 13%      +2.4        2.69 ± 14%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.30 ±100%      +2.2        2.48 ± 11%      +2.3        2.65 ± 13%      +2.4        2.69 ± 14%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      0.30 ±100%      +2.2        2.48 ± 11%      +2.4        2.65 ± 13%      +2.4        2.69 ± 14%  perf-profile.calltrace.cycles-pp.execve
     67.34            +2.3       69.67            +1.8       69.15 ±  2%      +2.2       69.57 ±  2%  perf-profile.calltrace.cycles-pp.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault
     67.27            +2.4       69.67            +1.9       69.14 ±  2%      +2.3       69.57 ±  2%  perf-profile.calltrace.cycles-pp.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page.__handle_mm_fault
     67.22            +2.4       69.66            +1.9       69.13 ±  2%      +2.3       69.56 ±  2%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page
     67.12            +2.5       69.64            +2.0       69.13 ±  2%      +2.4       69.55 ±  2%  perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.alloc_anon_folio
      5.78            +3.1        8.85 ±  6%      +3.3        9.10 ±  3%      +3.4        9.17 ±  4%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      5.78            +3.1        8.85 ±  6%      +3.3        9.10 ±  3%      +3.4        9.17 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      5.78            +3.1        8.85 ±  6%      +3.3        9.10 ±  3%      +3.4        9.17 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      2.21 ±  6%      +3.2        5.36 ± 11%      +2.9        5.07 ±  6%      +2.8        5.01 ±  5%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      4.87            +3.7        8.62 ±  6%      +4.0        8.84 ±  3%      +4.1        8.97 ±  4%  perf-profile.calltrace.cycles-pp.balance_pgdat.kswapd.kthread.ret_from_fork.ret_from_fork_asm
      4.87            +3.7        8.62 ±  6%      +4.0        8.84 ±  3%      +4.1        8.97 ±  4%  perf-profile.calltrace.cycles-pp.kswapd.kthread.ret_from_fork.ret_from_fork_asm
      4.87            +3.7        8.62 ±  6%      +4.0        8.84 ±  3%      +4.1        8.97 ±  4%  perf-profile.calltrace.cycles-pp.shrink_many.shrink_node.balance_pgdat.kswapd.kthread
      4.87            +3.7        8.62 ±  6%      +4.0        8.84 ±  3%      +4.1        8.97 ±  4%  perf-profile.calltrace.cycles-pp.shrink_node.balance_pgdat.kswapd.kthread.ret_from_fork
      4.87            +3.7        8.62 ±  6%      +4.0        8.84 ±  3%      +4.1        8.97 ±  4%  perf-profile.calltrace.cycles-pp.shrink_one.shrink_many.shrink_node.balance_pgdat.kswapd
      4.87            +3.8        8.62 ±  6%      +4.0        8.84 ±  3%      +4.1        8.97 ±  4%  perf-profile.calltrace.cycles-pp.try_to_shrink_lruvec.shrink_one.shrink_many.shrink_node.balance_pgdat
     66.53            +4.1       70.63            +3.6       70.13 ±  2%      +4.1       70.63 ±  2%  perf-profile.calltrace.cycles-pp.__alloc_pages_slowpath.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
      6.72 ±  2%      +4.5       11.21 ±  9%      +3.9       10.60 ±  4%      +3.8       10.50 ±  5%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      6.72 ±  2%      +4.5       11.21 ±  9%      +3.9       10.60 ±  4%      +3.8       10.50 ±  5%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      6.72 ±  2%      +4.5       11.20 ±  9%      +3.9       10.59 ±  4%      +3.8       10.50 ±  5%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      6.94 ±  2%      +4.6       11.50 ±  9%      +4.0       10.90 ±  4%      +3.8       10.78 ±  5%  perf-profile.calltrace.cycles-pp.common_startup_64
      3.57 ±  2%      +5.1        8.64 ±  9%      +4.6        8.16 ±  5%      +4.5        8.08 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      3.65 ±  2%      +5.5        9.14 ±  9%      +5.0        8.62 ±  5%      +4.9        8.54 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      4.52 ±  2%      +6.3       10.82 ±  8%      +5.7       10.24 ±  5%      +5.6       10.15 ±  5%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     64.31            +6.9       71.18            +7.3       71.57            +7.1       71.43 ±  2%  perf-profile.calltrace.cycles-pp.try_to_free_pages.__alloc_pages_slowpath.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof
     64.17            +7.4       71.56            +8.2       72.39            +8.2       72.40        perf-profile.calltrace.cycles-pp.do_try_to_free_pages.try_to_free_pages.__alloc_pages_slowpath.__alloc_pages_noprof.alloc_pages_mpol_noprof
     64.15            +7.4       71.56            +8.3       72.42            +8.3       72.40        perf-profile.calltrace.cycles-pp.shrink_node.do_try_to_free_pages.try_to_free_pages.__alloc_pages_slowpath.__alloc_pages_noprof
     62.53            +9.0       71.48            +9.8       72.37            +9.8       72.35        perf-profile.calltrace.cycles-pp.shrink_many.shrink_node.do_try_to_free_pages.try_to_free_pages.__alloc_pages_slowpath
     62.50            +9.0       71.48            +9.9       72.37            +9.8       72.35        perf-profile.calltrace.cycles-pp.shrink_one.shrink_many.shrink_node.do_try_to_free_pages.try_to_free_pages
     62.03            +9.4       71.45           +10.3       72.34           +10.3       72.32        perf-profile.calltrace.cycles-pp.try_to_shrink_lruvec.shrink_one.shrink_many.shrink_node.do_try_to_free_pages
     66.79           +13.3       80.06           +14.4       81.18           +14.5       81.29        perf-profile.calltrace.cycles-pp.evict_folios.try_to_shrink_lruvec.shrink_one.shrink_many.shrink_node
     63.11           +16.6       79.70           +17.9       81.02           +18.0       81.13        perf-profile.calltrace.cycles-pp.shrink_folio_list.evict_folios.try_to_shrink_lruvec.shrink_one.shrink_many
     42.45 ±  2%     +35.3       77.74 ±  2%     +36.9       79.33           +37.0       79.46        perf-profile.calltrace.cycles-pp.try_to_unmap_flush_dirty.shrink_folio_list.evict_folios.try_to_shrink_lruvec.shrink_one
     42.43 ±  2%     +35.3       77.74 ±  2%     +36.9       79.33           +37.0       79.45        perf-profile.calltrace.cycles-pp.arch_tlbbatch_flush.try_to_unmap_flush_dirty.shrink_folio_list.evict_folios.try_to_shrink_lruvec
     42.34 ±  2%     +35.4       77.73 ±  2%     +37.0       79.32           +37.1       79.45        perf-profile.calltrace.cycles-pp.on_each_cpu_cond_mask.arch_tlbbatch_flush.try_to_unmap_flush_dirty.shrink_folio_list.evict_folios
     41.73 ±  2%     +35.9       77.58 ±  2%     +37.4       79.18           +37.6       79.30        perf-profile.calltrace.cycles-pp.smp_call_function_many_cond.on_each_cpu_cond_mask.arch_tlbbatch_flush.try_to_unmap_flush_dirty.shrink_folio_list
     15.56 ±  2%     -12.5        3.03 ±  4%     -12.6        2.94 ±  2%     -12.6        2.91 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_call_function
     80.28           -10.4       69.87           -11.1       69.17 ±  3%     -10.7       69.60 ±  3%  perf-profile.children.cycles-pp.do_access
     11.47 ±  4%     -10.1        1.37 ±  4%     -10.1        1.35 ±  3%     -10.1        1.35 ±  2%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
     10.79 ±  4%      -9.5        1.32 ±  4%      -9.5        1.31 ±  3%      -9.5        1.31 ±  3%  perf-profile.children.cycles-pp.__sysvec_call_function
     11.76 ±  3%      -9.4        2.34 ±  3%      -9.5        2.28 ±  3%      -9.5        2.26 ±  2%  perf-profile.children.cycles-pp.sysvec_call_function
      8.04 ±  2%      -7.2        0.79 ± 11%      -7.2        0.80 ±  5%      -7.2        0.80 ±  2%  perf-profile.children.cycles-pp.add_to_swap
      7.85 ±  4%      -6.7        1.19 ±  7%      -6.6        1.24 ±  2%      -6.7        1.14 ±  2%  perf-profile.children.cycles-pp.llist_add_batch
      6.84 ±  2%      -6.2        0.69 ±  9%      -6.1        0.70 ±  5%      -6.1        0.71 ±  3%  perf-profile.children.cycles-pp.folio_alloc_swap
      6.38 ±  2%      -5.7        0.65 ±  8%      -5.7        0.67 ±  6%      -5.7        0.68 ±  3%  perf-profile.children.cycles-pp.__mem_cgroup_try_charge_swap
      5.83 ±  7%      -5.3        0.57 ± 50%      -5.4        0.44 ±  3%      -5.4        0.45 ±  6%  perf-profile.children.cycles-pp.rmap_walk_anon
      5.72 ±  4%      -5.1        0.62 ± 15%      -5.2        0.48 ± 17%      -5.2        0.49 ± 18%  perf-profile.children.cycles-pp.do_rw_once
      5.03 ±  6%      -4.6        0.47 ±  4%      -4.6        0.46 ±  4%      -4.6        0.44 ±  3%  perf-profile.children.cycles-pp.flush_tlb_func
      4.76 ±  4%      -4.3        0.41 ±143%      -4.6        0.15 ± 11%      -4.6        0.15 ± 12%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      4.83 ±  2%      -4.1        0.73 ±  3%      -4.1        0.72 ±  3%      -4.1        0.72 ±  3%  perf-profile.children.cycles-pp.default_send_IPI_mask_sequence_phys
      4.27 ±  7%      -3.9        0.34 ±  9%      -3.9        0.32 ±  4%      -3.9        0.33 ±  5%  perf-profile.children.cycles-pp.try_to_unmap
      4.31 ±  3%      -3.9        0.40 ± 17%      -4.0        0.34 ±  4%      -4.0        0.35 ±  6%  perf-profile.children.cycles-pp.pageout
      4.46 ±  2%      -3.8        0.64 ±  4%      -3.8        0.65 ±  4%      -3.8        0.66 ±  4%  perf-profile.children.cycles-pp.llist_reverse_order
     78.01            -3.6       74.42            -3.4       74.60            -3.6       74.39        perf-profile.children.cycles-pp.asm_exc_page_fault
      3.88 ±  8%      -3.6        0.30 ±  6%      -3.6        0.29 ±  4%      -3.6        0.30 ±  6%  perf-profile.children.cycles-pp.try_to_unmap_one
      3.94 ±  3%      -3.6        0.37 ± 17%      -3.6        0.32 ±  5%      -3.6        0.32 ±  6%  perf-profile.children.cycles-pp.swap_writepage
      3.10 ±  4%      -2.7        0.36 ± 77%      -2.9        0.24 ±  6%      -2.9        0.24 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     73.30            -2.3       70.98            -2.8       70.49 ±  2%      -2.3       70.98 ±  2%  perf-profile.children.cycles-pp.do_anonymous_page
      2.48 ±  6%      -2.3        0.19 ± 10%      -2.3        0.16 ± 10%      -2.3        0.16 ± 10%  perf-profile.children.cycles-pp.get_page_from_freelist
      2.36 ±  7%      -2.1        0.25 ± 20%      -2.1        0.25 ±  8%      -2.1        0.24 ±  7%  perf-profile.children.cycles-pp.swap_cgroup_record
      2.31 ±  3%      -2.1        0.25 ±  5%      -2.0        0.27 ±  6%      -2.0        0.27 ±  4%  perf-profile.children.cycles-pp.page_counter_try_charge
      2.39            -2.1        0.34 ±  5%      -2.1        0.31 ±  6%      -2.1        0.31 ±  5%  perf-profile.children.cycles-pp.native_irq_return_iret
      2.26 ±  5%      -2.0        0.25 ±115%      -2.2        0.10 ±  7%      -2.2        0.10 ± 10%  perf-profile.children.cycles-pp.folio_batch_move_lru
     76.12            -2.0       74.16            -1.7       74.39            -1.9       74.18        perf-profile.children.cycles-pp.exc_page_fault
     76.08            -1.9       74.15            -1.7       74.38            -1.9       74.18        perf-profile.children.cycles-pp.do_user_addr_fault
      2.20 ±  4%      -1.9        0.34 ± 12%      -1.9        0.29 ±  9%      -1.9        0.29 ± 12%  perf-profile.children.cycles-pp._raw_spin_lock
      1.85 ±  3%      -1.8        0.09 ± 10%      -1.8        0.09 ±  7%      -1.8        0.09 ±  9%  perf-profile.children.cycles-pp.native_flush_tlb_local
      2.09 ±  2%      -1.7        0.36 ± 23%      -1.8        0.32 ±  8%      -1.8        0.31 ±  6%  perf-profile.children.cycles-pp.handle_softirqs
      1.76 ±  6%      -1.5        0.22 ±  8%      -1.6        0.17 ± 17%      -1.6        0.17 ± 20%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      1.78 ±  8%      -1.5        0.25 ±103%      -1.6        0.13 ±  6%      -1.6        0.14 ±  8%  perf-profile.children.cycles-pp.folio_referenced
      1.68 ±  3%      -1.5        0.19 ± 36%      -1.5        0.15 ±  6%      -1.5        0.15 ±  4%  perf-profile.children.cycles-pp.blk_complete_reqs
      1.57 ±  6%      -1.5        0.12 ± 31%      -1.5        0.09 ±  7%      -1.5        0.09 ±  7%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      1.54 ± 15%      -1.4        0.11 ±  8%      -1.4        0.12 ±  6%      -1.4        0.12 ±  5%  perf-profile.children.cycles-pp.set_tlb_ubc_flush_pending
      1.61 ±  3%      -1.4        0.18 ± 34%      -1.5        0.14 ±  6%      -1.5        0.15 ±  5%  perf-profile.children.cycles-pp.scsi_end_request
      1.61 ±  3%      -1.4        0.18 ± 34%      -1.5        0.14 ±  6%      -1.5        0.15 ±  5%  perf-profile.children.cycles-pp.scsi_io_completion
      1.57 ±  4%      -1.4        0.16 ± 11%      -1.4        0.13 ± 12%      -1.4        0.13 ± 16%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      1.48 ±  4%      -1.3        0.16 ± 35%      -1.4        0.13 ±  6%      -1.4        0.13 ±  4%  perf-profile.children.cycles-pp.blk_update_request
      1.44 ±  8%      -1.3        0.13 ± 12%      -1.3        0.12 ±  8%      -1.3        0.12 ±  7%  perf-profile.children.cycles-pp.__swap_writepage
      1.38 ±  7%      -1.3        0.08 ± 40%      -1.3        0.07 ± 11%      -1.3        0.07 ± 11%  perf-profile.children.cycles-pp.__remove_mapping
      1.33 ±  6%      -1.3        0.07 ± 40%      -1.3        0.05 ± 28%      -1.3        0.06 ± 11%  perf-profile.children.cycles-pp.do_softirq
      1.32 ± 11%      -1.2        0.08 ±  6%      -1.3        0.07 ±  8%      -1.3        0.06 ± 15%  perf-profile.children.cycles-pp.rmqueue
      1.34 ± 11%      -1.2        0.12 ± 15%      -1.2        0.09 ±  9%      -1.2        0.09 ± 14%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      1.43 ±  7%      -1.2        0.23 ±106%      -1.3        0.10 ±  8%      -1.3        0.11 ± 10%  perf-profile.children.cycles-pp.__folio_batch_add_and_move
      1.18 ± 12%      -1.1        0.06 ±  7%      -1.1        0.06 ± 10%      -1.1        0.06 ± 11%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      1.25 ±  4%      -1.1        0.14 ± 50%      -1.1        0.11 ±  6%      -1.1        0.11 ±  4%  perf-profile.children.cycles-pp.isolate_folios
      1.24 ±  4%      -1.1        0.14 ± 48%      -1.1        0.11 ±  6%      -1.1        0.11 ±  4%  perf-profile.children.cycles-pp.scan_folios
      1.19 ±  6%      -1.1        0.12 ± 10%      -1.1        0.11 ± 12%      -1.1        0.11 ± 16%  perf-profile.children.cycles-pp.try_charge_memcg
      1.12 ± 13%      -1.1        0.06 ±  9%      -1.1        0.04 ± 58%      -1.1        0.05 ± 35%  perf-profile.children.cycles-pp.rmqueue_bulk
      1.18 ±  4%      -1.1        0.12 ± 25%      -1.1        0.10 ±  8%      -1.1        0.10 ±  7%  perf-profile.children.cycles-pp.submit_bio_noacct_nocheck
      1.25 ±  9%      -1.0        0.20 ±122%      -1.2        0.09 ±  9%      -1.2        0.10 ±  9%  perf-profile.children.cycles-pp.folio_referenced_one
      1.14 ±  7%      -1.0        0.11 ±  6%      -1.0        0.11 ±  9%      -1.0        0.12 ±  8%  perf-profile.children.cycles-pp.mem_cgroup_id_get_online
      1.13 ±  3%      -1.0        0.12 ± 42%      -1.0        0.10 ±  6%      -1.0        0.10 ±  5%  perf-profile.children.cycles-pp.end_swap_bio_write
      1.08 ±  5%      -1.0        0.09 ± 22%      -1.0        0.09 ±  9%      -1.0        0.08 ±  9%  perf-profile.children.cycles-pp.add_to_swap_cache
      1.10 ±  3%      -1.0        0.12 ± 43%      -1.0        0.09 ±  6%      -1.0        0.10 ±  5%  perf-profile.children.cycles-pp.folio_end_writeback
      1.09 ±  4%      -1.0        0.11 ± 26%      -1.0        0.09 ±  7%      -1.0        0.10 ±  6%  perf-profile.children.cycles-pp.__submit_bio
      1.06 ±  4%      -1.0        0.11 ± 24%      -1.0        0.09 ±  7%      -1.0        0.10 ±  7%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      1.04 ±  6%      -0.9        0.12 ±  6%      -0.9        0.12 ±  7%      -0.9        0.12 ±  6%  perf-profile.children.cycles-pp._find_next_bit
      1.00 ±  2%      -0.9        0.11 ± 47%      -0.9        0.09 ±  7%      -0.9        0.09 ±  7%  perf-profile.children.cycles-pp.isolate_folio
      0.96 ± 12%      -0.9        0.08 ± 34%      -0.9        0.06 ± 10%      -0.9        0.06 ± 11%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.94 ±  3%      -0.9        0.08 ± 38%      -0.9        0.07 ± 12%      -0.9        0.07 ± 19%  perf-profile.children.cycles-pp.page_vma_mapped_walk
      1.28 ±  9%      -0.8        0.46 ± 15%      -0.9        0.43 ±  5%      -0.9        0.42 ±  6%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.95 ±  4%      -0.8        0.15 ± 17%      -0.8        0.13 ±  8%      -0.8        0.13 ±  8%  perf-profile.children.cycles-pp.__schedule
      0.85 ±  3%      -0.7        0.13 ±  8%      -0.7        0.11 ±  9%      -0.7        0.12 ± 11%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.75 ±  4%      -0.7        0.08 ± 17%      -0.7        0.06 ± 14%      -0.7        0.06 ± 15%  perf-profile.children.cycles-pp.sync_regs
      1.16 ±  4%      -0.6        0.52 ±  3%      -0.7        0.50 ±  5%      -0.7        0.51 ±  6%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.70 ±  4%      -0.6        0.08 ± 61%      -0.6        0.06 ± 10%      -0.6        0.06 ± 14%  perf-profile.children.cycles-pp.lru_gen_del_folio
      0.70 ±  5%      -0.6        0.08 ± 52%      -0.6        0.06 ±  9%      -0.6        0.05 ± 35%  perf-profile.children.cycles-pp.lru_gen_add_folio
      0.66 ±  8%      -0.6        0.05 ± 48%      -0.6        0.05 ± 26%      -0.6        0.04 ± 50%  perf-profile.children.cycles-pp.__folio_start_writeback
      1.08 ±  4%      -0.6        0.47 ±  3%      -0.6        0.46 ±  5%      -0.6        0.46 ±  5%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.69 ±  7%      -0.6        0.11 ± 18%      -0.6        0.10 ±  8%      -0.6        0.10 ± 10%  perf-profile.children.cycles-pp.schedule
      0.75 ±  6%      -0.6        0.18 ± 19%      -0.5        0.21 ± 60%      -0.6        0.16 ± 15%  perf-profile.children.cycles-pp.worker_thread
      0.65 ± 11%      -0.5        0.10 ± 20%      -0.6        0.09 ± 12%      -0.6        0.10 ±  8%  perf-profile.children.cycles-pp.__drain_all_pages
      0.64 ±  4%      -0.5        0.11 ±  6%      -0.5        0.10 ±  9%      -0.5        0.10 ±  9%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.64 ± 16%      -0.5        0.12 ± 25%      -0.5        0.11 ± 10%      -0.5        0.11 ±  8%  perf-profile.children.cycles-pp.asm_common_interrupt
      0.64 ± 16%      -0.5        0.12 ± 25%      -0.5        0.11 ± 10%      -0.5        0.11 ±  8%  perf-profile.children.cycles-pp.common_interrupt
      0.54 ±  6%      -0.5        0.04 ± 75%      -0.5        0.04 ± 58%      -0.5        0.04 ± 50%  perf-profile.children.cycles-pp.blk_mq_sched_dispatch_requests
      0.54 ±  6%      -0.5        0.04 ± 75%      -0.5        0.04 ± 58%      -0.5        0.04 ± 50%  perf-profile.children.cycles-pp.__blk_mq_sched_dispatch_requests
      0.53 ±  6%      -0.5        0.04 ± 73%      -0.5        0.04 ± 58%      -0.5        0.04 ± 50%  perf-profile.children.cycles-pp.__blk_mq_do_dispatch_sched
      0.56 ± 12%      -0.5        0.07 ± 23%      -0.5        0.07 ± 15%      -0.5        0.07 ± 10%  perf-profile.children.cycles-pp.drain_pages_zone
      0.54 ±  4%      -0.5        0.06 ± 19%      -0.5        0.05 ± 10%      -0.5        0.05 ± 34%  perf-profile.children.cycles-pp.__blk_flush_plug
      0.52 ±  7%      -0.5        0.03 ± 70%      -0.5        0.00            -0.5        0.02 ±153%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.54 ±  4%      -0.5        0.06 ± 19%      -0.5        0.05 ± 10%      -0.5        0.05 ± 34%  perf-profile.children.cycles-pp.blk_mq_flush_plug_list
      0.54 ±  3%      -0.5        0.06 ± 19%      -0.5        0.05 ± 28%      -0.5        0.04 ± 50%  perf-profile.children.cycles-pp.blk_mq_dispatch_plug_list
      0.51 ± 10%      -0.4        0.08 ± 24%      -0.4        0.07 ± 13%      -0.4        0.07 ±  9%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.45 ±  5%      -0.4        0.04 ± 75%      -0.4        0.01 ±173%      -0.4        0.03 ± 82%  perf-profile.children.cycles-pp.__rq_qos_throttle
      0.49 ±  7%      -0.4        0.08 ± 17%      -0.4        0.07 ± 11%      -0.4        0.07 ±  8%  perf-profile.children.cycles-pp.__pick_next_task
      0.62 ±  4%      -0.4        0.22 ±  8%      -0.4        0.22 ±  6%      -0.4        0.22 ±  6%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.44 ±  5%      -0.4        0.04 ± 75%      -0.4        0.01 ±173%      -0.4        0.03 ±100%  perf-profile.children.cycles-pp.wbt_wait
      0.42 ±  6%      -0.4        0.04 ± 75%      -0.4        0.01 ±264%      -0.4        0.02 ±123%  perf-profile.children.cycles-pp.rq_qos_wait
      0.42 ±  5%      -0.4        0.04 ± 45%      -0.4        0.03 ± 77%      -0.4        0.03 ± 82%  perf-profile.children.cycles-pp.bio_alloc_bioset
      0.66 ±  3%      -0.3        0.31 ±  3%      -0.4        0.31 ±  5%      -0.3        0.32 ±  5%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.65 ±  3%      -0.3        0.31 ±  3%      -0.3        0.31 ±  5%      -0.3        0.32 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.48 ±  3%      -0.3        0.15 ±  8%      -0.3        0.15 ±  5%      -0.3        0.15 ±  7%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.40 ± 10%      -0.3        0.06 ± 17%      -0.3        0.05 ± 39%      -0.3        0.05 ±  9%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.46 ±  6%      -0.3        0.14 ± 23%      -0.3        0.17 ± 73%      -0.3        0.12 ± 19%  perf-profile.children.cycles-pp.process_one_work
      0.44 ±  6%      -0.3        0.12 ± 15%      -0.3        0.12 ±  4%      -0.3        0.12 ±  6%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
      0.38 ± 10%      -0.3        0.06 ± 19%      -0.3        0.06 ± 11%      -0.3        0.06 ± 10%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.56 ±  3%      -0.3        0.24 ±  4%      -0.3        0.24 ±  5%      -0.3        0.25 ±  5%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.42 ± 10%      -0.3        0.11 ± 13%      -0.3        0.10 ±  7%      -0.3        0.10 ± 10%  perf-profile.children.cycles-pp.sched_balance_rq
      0.42 ±  4%      -0.3        0.12 ±  7%      -0.3        0.12 ±  5%      -0.3        0.12 ±  8%  perf-profile.children.cycles-pp.sched_clock
      0.45 ±  6%      -0.3        0.16 ± 13%      -0.3        0.15 ±  5%      -0.3        0.15 ±  6%  perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      0.37 ±  9%      -0.3        0.09 ± 12%      -0.3        0.09 ±  8%      -0.3        0.08 ±  9%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.50 ±  3%      -0.3        0.23 ±  3%      -0.3        0.22 ±  4%      -0.3        0.23 ±  5%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.36 ±  8%      -0.3        0.09 ± 13%      -0.3        0.08 ±  9%      -0.3        0.08 ± 10%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.31 ±  8%      -0.3        0.04 ± 71%      -0.3        0.06 ± 11%      -0.3        0.00        perf-profile.children.cycles-pp.tlb_is_not_lazy
      0.33 ± 11%      -0.3        0.08 ± 15%      -0.3        0.08 ± 10%      -0.3        0.08 ± 13%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.44 ±  4%      -0.2        0.20 ±  4%      -0.2        0.19 ±  5%      -0.2        0.20 ±  5%  perf-profile.children.cycles-pp.update_process_times
      0.30 ±  7%      -0.2        0.07 ± 10%      -0.2        0.07 ± 12%      -0.2        0.07 ± 10%  perf-profile.children.cycles-pp.error_entry
      0.29 ±  4%      -0.2        0.09 ±  5%      -0.2        0.08 ±  7%      -0.2        0.08 ± 13%  perf-profile.children.cycles-pp.irq_work_run_list
      0.39 ±  6%      -0.2        0.19 ±  3%      -0.2        0.19 ±  7%      -0.2        0.18 ±  7%  perf-profile.children.cycles-pp.native_sched_clock
      0.28 ±  5%      -0.2        0.09 ±  5%      -0.2        0.08 ±  7%      -0.2        0.08 ± 13%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.28 ±  5%      -0.2        0.09 ±  5%      -0.2        0.08 ±  7%      -0.2        0.08 ± 13%  perf-profile.children.cycles-pp._printk
      0.28 ±  5%      -0.2        0.09 ±  5%      -0.2        0.08 ±  7%      -0.2        0.08 ± 13%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.28 ±  5%      -0.2        0.09 ±  5%      -0.2        0.08 ±  7%      -0.2        0.08 ± 13%  perf-profile.children.cycles-pp.irq_work_run
      0.28 ±  5%      -0.2        0.09 ±  5%      -0.2        0.08 ±  7%      -0.2        0.08 ± 13%  perf-profile.children.cycles-pp.irq_work_single
      0.28 ±  5%      -0.2        0.09 ±  5%      -0.2        0.08 ±  7%      -0.2        0.08 ± 13%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.28 ±  5%      -0.2        0.09 ± 10%      -0.2        0.11 ± 88%      -0.2        0.09 ± 15%  perf-profile.children.cycles-pp.console_flush_all
      0.28 ±  5%      -0.2        0.09 ± 10%      -0.2        0.11 ± 88%      -0.2        0.09 ± 15%  perf-profile.children.cycles-pp.console_unlock
      0.28 ±  5%      -0.2        0.09 ± 10%      -0.2        0.11 ± 88%      -0.2        0.09 ± 15%  perf-profile.children.cycles-pp.vprintk_emit
      0.28 ±  4%      -0.2        0.09 ±  7%      -0.2        0.11 ± 86%      -0.2        0.08 ± 15%  perf-profile.children.cycles-pp.serial8250_console_write
      0.28 ±  5%      -0.2        0.09 ±  9%      -0.2        0.10 ± 77%      -0.2        0.08 ± 14%  perf-profile.children.cycles-pp.wait_for_lsr
      0.23 ± 15%      -0.2        0.06 ± 65%      -0.2        0.04 ± 83%      -0.2        0.02 ±127%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.24 ±  7%      -0.2        0.08 ± 13%      -0.1        0.11 ±115%      -0.2        0.08 ± 14%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      0.24 ±  7%      -0.2        0.08 ± 13%      -0.1        0.11 ±115%      -0.2        0.08 ± 14%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      0.24 ±  7%      -0.2        0.08 ± 13%      -0.1        0.11 ±115%      -0.2        0.08 ± 14%  perf-profile.children.cycles-pp.drm_fbdev_shmem_helper_fb_dirty
      0.24 ±  7%      -0.2        0.08 ± 11%      -0.1        0.11 ±115%      -0.2        0.08 ± 14%  perf-profile.children.cycles-pp.drm_atomic_commit
      0.24 ±  7%      -0.2        0.08 ± 11%      -0.1        0.11 ±115%      -0.2        0.08 ± 14%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      0.24 ±  7%      -0.2        0.08 ± 11%      -0.1        0.11 ±115%      -0.2        0.08 ± 14%  perf-profile.children.cycles-pp.ast_mode_config_helper_atomic_commit_tail
      0.24 ±  7%      -0.2        0.08 ± 11%      -0.1        0.11 ±115%      -0.2        0.08 ± 14%  perf-profile.children.cycles-pp.ast_primary_plane_helper_atomic_update
      0.24 ±  7%      -0.2        0.08 ± 11%      -0.1        0.11 ±115%      -0.2        0.08 ± 14%  perf-profile.children.cycles-pp.commit_tail
      0.24 ±  7%      -0.2        0.08 ± 11%      -0.1        0.11 ±115%      -0.2        0.08 ± 14%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      0.24 ±  7%      -0.2        0.08 ± 11%      -0.1        0.11 ±115%      -0.2        0.08 ± 14%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail
      0.24 ±  7%      -0.2        0.08 ± 11%      -0.1        0.11 ±115%      -0.2        0.08 ± 14%  perf-profile.children.cycles-pp.drm_fb_memcpy
      0.23 ±  8%      -0.2        0.08 ± 11%      -0.1        0.11 ±113%      -0.2        0.08 ± 14%  perf-profile.children.cycles-pp.memcpy_toio
      0.19 ± 11%      -0.1        0.06 ± 13%      -0.1        0.07 ±105%      -0.1        0.04 ± 51%  perf-profile.children.cycles-pp.io_serial_in
      0.19 ±  7%      -0.1        0.06 ± 98%      -0.1        0.06 ±133%      -0.1        0.08 ±114%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.20 ± 10%      -0.1        0.12 ±  6%      -0.1        0.11 ±  9%      -0.1        0.11 ±  5%  perf-profile.children.cycles-pp.sched_tick
      0.11 ± 13%      -0.0        0.06 ± 11%      -0.0        0.06 ± 13%      -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.sched_balance_domains
      0.10 ±  4%      -0.0        0.06 ± 13%      -0.1        0.05 ± 27%      -0.1        0.05 ±  7%  perf-profile.children.cycles-pp.sched_core_idle_cpu
      0.14 ±  5%      -0.0        0.09 ±  7%      -0.1        0.09 ±  9%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.irqentry_enter
      0.09 ± 14%      -0.0        0.06 ±  9%      -0.0        0.05 ± 27%      -0.0        0.04 ± 51%  perf-profile.children.cycles-pp.clockevents_program_event
      0.09 ± 11%      -0.0        0.06 ±  9%      -0.0        0.06 ± 13%      -0.0        0.06 ± 10%  perf-profile.children.cycles-pp.task_tick_fair
      0.12 ± 14%      -0.0        0.10 ± 14%      -0.0        0.10 ± 24%      -0.0        0.09 ± 17%  perf-profile.children.cycles-pp._nohz_idle_balance
      0.00            +0.0        0.00            +0.0        0.00            +0.1        0.12 ±  5%  perf-profile.children.cycles-pp.should_flush_tlb
      0.03 ± 70%      +0.0        0.08 ± 11%      +0.0        0.08 ±  6%      +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.read_tsc
      0.00            +0.0        0.05 ± 45%      +0.1        0.06 ± 12%      +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.menu_reflect
      0.00            +0.1        0.06 ±  6%      +0.1        0.06 ± 10%      +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.00            +0.1        0.06 ± 14%      +0.1        0.06 ±  8%      +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.ct_kernel_exit
      0.00            +0.1        0.06 ± 14%      +0.1        0.06 ±  7%      +0.1        0.06 ± 12%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.00            +0.1        0.06 ±  7%      +0.1        0.06 ±  9%      +0.1        0.06 ± 10%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.00            +0.1        0.07 ±  7%      +0.1        0.07 ±  9%      +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.tmigr_cpu_new_timer
      0.00            +0.1        0.07 ± 10%      +0.1        0.07 ±  9%      +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.irq_work_needs_cpu
      0.00            +0.1        0.08 ± 11%      +0.1        0.08 ±  8%      +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.get_cpu_device
      0.15 ± 35%      +0.1        0.24 ± 62%      +0.2        0.36 ± 35%      +0.2        0.33 ± 25%  perf-profile.children.cycles-pp.alloc_bprm
      0.21 ±  9%      +0.1        0.29 ± 10%      +0.1        0.30 ± 21%      +0.1        0.28 ± 15%  perf-profile.children.cycles-pp.rest_init
      0.21 ±  9%      +0.1        0.29 ± 10%      +0.1        0.30 ± 21%      +0.1        0.28 ± 15%  perf-profile.children.cycles-pp.start_kernel
      0.21 ±  9%      +0.1        0.29 ± 10%      +0.1        0.30 ± 21%      +0.1        0.28 ± 15%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.21 ±  9%      +0.1        0.29 ± 10%      +0.1        0.30 ± 21%      +0.1        0.28 ± 15%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.00            +0.1        0.09 ± 13%      +0.1        0.08 ± 10%      +0.1        0.09 ± 10%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.00            +0.1        0.09 ± 18%      +0.1        0.09 ± 12%      +0.1        0.09 ± 13%  perf-profile.children.cycles-pp.intel_idle_irq
      0.01 ±223%      +0.1        0.10 ± 32%      +0.1        0.10 ± 72%      +0.1        0.10 ± 64%  perf-profile.children.cycles-pp.load_elf_interp
      0.00            +0.1        0.10 ± 12%      +0.1        0.09 ±  9%      +0.1        0.09 ±  9%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.00            +0.1        0.10 ± 15%      +0.1        0.10 ±  9%      +0.1        0.09 ±  8%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.12 ±  9%      +0.1        0.22 ±  8%      +0.1        0.21 ±  5%      +0.1        0.21 ±  7%  perf-profile.children.cycles-pp.ktime_get
      0.00            +0.1        0.10 ±  7%      +0.1        0.10 ± 10%      +0.1        0.10 ±  6%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.00            +0.1        0.11 ± 15%      +0.1        0.10 ± 10%      +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.00            +0.1        0.11 ± 14%      +0.1        0.10 ±  8%      +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.01 ±223%      +0.1        0.14 ± 47%      +0.1        0.09 ± 63%      +0.0        0.05 ± 90%  perf-profile.children.cycles-pp._IO_setvbuf
      0.00            +0.1        0.13 ±  9%      +0.1        0.12 ±  9%      +0.1        0.12 ±  8%  perf-profile.children.cycles-pp.ct_idle_exit
      0.01 ±223%      +0.1        0.14 ± 83%      +0.1        0.11 ± 64%      +0.1        0.14 ± 63%  perf-profile.children.cycles-pp._copy_to_iter
      0.01 ±223%      +0.1        0.15 ±  8%      +0.1        0.13 ±  6%      +0.1        0.13 ±  8%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.02 ±142%      +0.1        0.16 ±  8%      +0.1        0.15 ±  6%      +0.1        0.15 ±  7%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.01 ±223%      +0.2        0.16 ± 40%      +0.1        0.14 ± 62%      +0.1        0.14 ± 49%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.01 ±223%      +0.2        0.16 ± 40%      +0.1        0.14 ± 62%      +0.1        0.14 ± 49%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.08 ± 41%      +0.2        0.23 ± 24%      +0.2        0.27 ± 49%      +0.2        0.32 ± 71%  perf-profile.children.cycles-pp.write
      0.01 ±223%      +0.2        0.16 ± 39%      +0.2        0.16 ± 59%      +0.1        0.14 ± 40%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.16 ± 34%      +0.2        0.32 ± 53%      +0.3        0.47 ± 32%      +0.3        0.45 ± 25%  perf-profile.children.cycles-pp.mm_init
      0.16 ± 36%      +0.2        0.32 ± 53%      +0.3        0.47 ± 32%      +0.3        0.45 ± 26%  perf-profile.children.cycles-pp.pgd_alloc
      0.07 ± 63%      +0.2        0.23 ± 24%      +0.2        0.26 ± 50%      +0.3        0.32 ± 71%  perf-profile.children.cycles-pp.ksys_write
      0.06 ± 60%      +0.2        0.23 ± 24%      +0.2        0.26 ± 51%      +0.3        0.32 ± 71%  perf-profile.children.cycles-pp.vfs_write
      0.00            +0.2        0.17 ± 33%      +0.3        0.26 ± 33%      +0.2        0.23 ± 33%  perf-profile.children.cycles-pp.copy_p4d_range
      0.00            +0.2        0.17 ± 33%      +0.3        0.26 ± 33%      +0.2        0.23 ± 33%  perf-profile.children.cycles-pp.copy_page_range
      0.00            +0.2        0.18 ± 32%      +0.3        0.27 ± 32%      +0.2        0.24 ± 33%  perf-profile.children.cycles-pp.dup_mmap
      0.12 ± 15%      +0.2        0.30 ±  6%      +0.2        0.29 ±  5%      +0.2        0.29 ±  8%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.00            +0.2        0.18 ± 38%      +0.2        0.20 ± 44%      +0.2        0.20 ± 48%  perf-profile.children.cycles-pp.__do_fault
      0.00            +0.2        0.18 ± 14%      +0.2        0.23 ± 55%      +0.2        0.16 ± 26%  perf-profile.children.cycles-pp.__pmd_alloc
      0.01 ±223%      +0.2        0.20 ± 36%      +0.3        0.33 ± 34%      +0.2        0.23 ± 38%  perf-profile.children.cycles-pp.__libc_fork
      0.02 ±141%      +0.2        0.21 ±130%      +0.2        0.24 ±156%      +0.5        0.50 ±124%  perf-profile.children.cycles-pp.__cmd_record
      0.04 ± 72%      +0.2        0.27 ± 30%      +0.3        0.38 ± 20%      +0.3        0.36 ± 33%  perf-profile.children.cycles-pp.dup_mm
      0.07 ± 16%      +0.2        0.30 ± 13%      +0.2        0.30 ± 33%      +0.2        0.27 ± 43%  perf-profile.children.cycles-pp.elf_load
      0.05 ± 82%      +0.3        0.31 ± 44%      +0.4        0.40 ± 27%      +0.3        0.37 ± 31%  perf-profile.children.cycles-pp.schedule_tail
      0.15 ± 16%      +0.3        0.41 ± 17%      +0.3        0.41 ± 36%      +0.3        0.42 ± 28%  perf-profile.children.cycles-pp.__vfork
      0.14 ± 17%      +0.3        0.41 ± 17%      +0.3        0.41 ± 36%      +0.3        0.42 ± 28%  perf-profile.children.cycles-pp.__x64_sys_vfork
      0.03 ±101%      +0.3        0.30 ± 13%      +0.3        0.30 ± 33%      +0.2        0.27 ± 44%  perf-profile.children.cycles-pp.rep_stos_alternative
      0.04 ± 71%      +0.3        0.32 ± 19%      +0.3        0.31 ± 15%      +0.3        0.30 ± 15%  perf-profile.children.cycles-pp.poll_idle
      0.01 ±223%      +0.3        0.29 ± 30%      +0.3        0.29 ± 22%      +0.3        0.32 ± 17%  perf-profile.children.cycles-pp.___kmalloc_large_node
      0.01 ±223%      +0.3        0.29 ± 30%      +0.3        0.29 ± 22%      +0.3        0.32 ± 17%  perf-profile.children.cycles-pp.__kmalloc_large_node_noprof
      0.01 ±223%      +0.3        0.29 ± 30%      +0.3        0.30 ± 22%      +0.3        0.32 ± 17%  perf-profile.children.cycles-pp.__kmalloc_node_noprof
      0.04 ±112%      +0.3        0.32 ± 41%      +0.4        0.40 ± 27%      +0.3        0.37 ± 28%  perf-profile.children.cycles-pp.__put_user_4
      0.12 ± 26%      +0.3        0.42 ± 17%      +0.3        0.46 ± 27%      +0.4        0.51 ± 25%  perf-profile.children.cycles-pp.alloc_pages_bulk_noprof
      0.09 ± 28%      +0.3        0.40 ± 37%      +0.5        0.60 ± 46%      +0.6        0.68 ± 44%  perf-profile.children.cycles-pp.__p4d_alloc
      0.09 ± 28%      +0.3        0.40 ± 37%      +0.5        0.60 ± 46%      +0.6        0.68 ± 44%  perf-profile.children.cycles-pp.get_zeroed_page_noprof
      0.10 ± 21%      +0.3        0.43 ± 39%      +0.4        0.45 ± 32%      +0.4        0.52 ± 28%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.10 ± 19%      +0.3        0.43 ± 39%      +0.4        0.45 ± 32%      +0.4        0.52 ± 28%  perf-profile.children.cycles-pp.do_sys_openat2
      0.01 ±223%      +0.3        0.34 ± 26%      +0.4        0.36 ± 24%      +0.4        0.38 ± 23%  perf-profile.children.cycles-pp.__kvmalloc_node_noprof
      0.01 ±223%      +0.3        0.34 ± 26%      +0.4        0.36 ± 24%      +0.4        0.38 ± 23%  perf-profile.children.cycles-pp.single_open_size
      0.09 ± 22%      +0.3        0.43 ± 39%      +0.4        0.45 ± 32%      +0.4        0.52 ± 28%  perf-profile.children.cycles-pp.do_filp_open
      0.09 ± 22%      +0.3        0.43 ± 39%      +0.4        0.45 ± 32%      +0.4        0.52 ± 28%  perf-profile.children.cycles-pp.path_openat
      0.12 ±  6%      +0.3        0.47 ±  8%      +0.3        0.44 ±  6%      +0.3        0.44 ±  7%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.04 ± 45%      +0.3        0.39 ± 34%      +0.4        0.41 ± 27%      +0.4        0.41 ± 29%  perf-profile.children.cycles-pp.perf_evlist__poll
      0.04 ± 45%      +0.3        0.39 ± 34%      +0.4        0.41 ± 27%      +0.4        0.41 ± 28%  perf-profile.children.cycles-pp.perf_evlist__poll_thread
      0.04 ± 44%      +0.4        0.39 ± 34%      +0.4        0.42 ± 27%      +0.4        0.41 ± 28%  perf-profile.children.cycles-pp.perf_poll
      0.04 ± 45%      +0.4        0.40 ± 33%      +0.4        0.42 ± 27%      +0.4        0.42 ± 28%  perf-profile.children.cycles-pp.do_poll
      0.04 ± 45%      +0.4        0.40 ± 33%      +0.4        0.42 ± 27%      +0.4        0.42 ± 28%  perf-profile.children.cycles-pp.__x64_sys_poll
      0.04 ± 45%      +0.4        0.40 ± 33%      +0.4        0.42 ± 27%      +0.4        0.42 ± 28%  perf-profile.children.cycles-pp.do_sys_poll
      0.04 ± 45%      +0.4        0.40 ± 33%      +0.4        0.43 ± 27%      +0.4        0.42 ± 28%  perf-profile.children.cycles-pp.__poll
      0.02 ±141%      +0.4        0.38 ± 32%      +0.4        0.39 ± 25%      +0.4        0.46 ± 23%  perf-profile.children.cycles-pp.vfs_open
      0.02 ±141%      +0.4        0.38 ± 32%      +0.4        0.39 ± 25%      +0.4        0.46 ± 23%  perf-profile.children.cycles-pp.do_open
      0.07 ± 14%      +0.4        0.44 ±  9%      +0.3        0.42 ±  6%      +0.3        0.41 ±  7%  perf-profile.children.cycles-pp.tick_irq_enter
      0.01 ±223%      +0.4        0.38 ± 32%      +0.4        0.39 ± 25%      +0.4        0.46 ± 23%  perf-profile.children.cycles-pp.do_dentry_open
      0.02 ±141%      +0.4        0.39 ± 34%      +0.4        0.41 ± 28%      +0.4        0.41 ± 29%  perf-profile.children.cycles-pp.__pollwait
      0.10 ± 11%      +0.4        0.47 ±  7%      +0.4        0.46 ±  5%      +0.4        0.46 ±  6%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.04 ± 72%      +0.4        0.43 ± 10%      +0.5        0.55 ± 32%      +0.6        0.64 ± 45%  perf-profile.children.cycles-pp.alloc_new_pud
      0.22 ± 21%      +0.4        0.62 ±  7%      +0.3        0.56 ± 26%      +0.4        0.59 ± 28%  perf-profile.children.cycles-pp.do_pte_missing
      0.06 ± 51%      +0.4        0.47 ± 15%      +0.5        0.60 ± 29%      +0.6        0.67 ± 42%  perf-profile.children.cycles-pp.setup_arg_pages
      0.01 ±223%      +0.4        0.42 ± 40%      +0.4        0.44 ± 32%      +0.5        0.52 ± 29%  perf-profile.children.cycles-pp.open64
      0.06 ± 50%      +0.4        0.47 ± 15%      +0.5        0.60 ± 30%      +0.6        0.67 ± 42%  perf-profile.children.cycles-pp.relocate_vma_down
      0.05 ± 73%      +0.4        0.47 ± 15%      +0.6        0.60 ± 30%      +0.6        0.66 ± 42%  perf-profile.children.cycles-pp.move_page_tables
      0.14 ± 10%      +0.5        0.61 ±  7%      +0.4        0.58 ±  5%      +0.4        0.58 ±  6%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.10 ± 13%      +0.5        0.56 ± 23%      +0.6        0.74 ± 23%      +0.6        0.73 ± 17%  perf-profile.children.cycles-pp.__do_sys_clone
      0.21 ± 26%      +0.5        0.74 ± 29%      +0.7        0.92 ± 18%      +0.7        0.87 ± 17%  perf-profile.children.cycles-pp.get_free_pages_noprof
      0.16 ± 17%      +0.5        0.69 ± 13%      +0.6        0.76 ± 24%      +0.6        0.78 ± 13%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.16 ± 18%      +0.5        0.70 ± 15%      +0.6        0.77 ± 24%      +0.6        0.79 ± 13%  perf-profile.children.cycles-pp.dup_task_struct
      0.08 ± 41%      +0.5        0.62 ± 19%      +0.5        0.58 ± 26%      +0.5        0.56 ± 47%  perf-profile.children.cycles-pp.copy_strings
      0.15 ± 20%      +0.6        0.73 ± 16%      +0.7        0.81 ± 24%      +0.7        0.84 ± 14%  perf-profile.children.cycles-pp.__vmalloc_area_node
      0.16 ± 17%      +0.6        0.74 ± 15%      +0.7        0.82 ± 24%      +0.7        0.85 ± 13%  perf-profile.children.cycles-pp.__vmalloc_node_range_noprof
      0.19 ± 19%      +0.6        0.81 ± 12%      +0.8        0.96 ± 19%      +0.8        0.97 ± 32%  perf-profile.children.cycles-pp.bprm_execve
      0.18 ± 20%      +0.6        0.81 ± 12%      +0.8        0.95 ± 20%      +0.8        0.97 ± 33%  perf-profile.children.cycles-pp.exec_binprm
      0.18 ± 20%      +0.6        0.81 ± 12%      +0.8        0.95 ± 20%      +0.8        0.97 ± 33%  perf-profile.children.cycles-pp.search_binary_handler
      0.18 ± 21%      +0.6        0.81 ± 12%      +0.8        0.95 ± 20%      +0.8        0.97 ± 33%  perf-profile.children.cycles-pp.load_elf_binary
      0.10 ± 54%      +0.7        0.81 ± 26%      +0.6        0.75 ± 22%      +0.7        0.83 ± 13%  perf-profile.children.cycles-pp.copy_string_kernel
      0.44 ±141%      +0.7        1.15 ±100%      +1.4        1.87 ± 71%      +0.8        1.21 ± 83%  perf-profile.children.cycles-pp.do_swap_page
      0.24 ± 10%      +0.7        0.98 ± 15%      +0.9        1.15 ± 18%      +0.9        1.15 ± 17%  perf-profile.children.cycles-pp.kernel_clone
      0.23 ± 12%      +0.7        0.98 ± 15%      +0.9        1.15 ± 18%      +0.9        1.15 ± 17%  perf-profile.children.cycles-pp.copy_process
      0.16 ± 22%      +0.8        0.95 ± 19%      +1.1        1.26 ± 17%      +1.0        1.20 ± 16%  perf-profile.children.cycles-pp._Fork
      0.09 ± 28%      +0.9        0.96 ± 16%      +0.8        0.89 ± 19%      +0.9        0.98 ± 20%  perf-profile.children.cycles-pp.__pud_alloc
      0.32 ±  8%      +0.9        1.27 ±  7%      +0.9        1.23 ±  4%      +0.9        1.22 ±  6%  perf-profile.children.cycles-pp.menu_select
      0.18 ± 38%      +1.3        1.43 ± 20%      +1.2        1.33 ± 19%      +1.2        1.38 ± 14%  perf-profile.children.cycles-pp.get_arg_page
      0.18 ± 37%      +1.3        1.43 ± 20%      +1.2        1.33 ± 19%      +1.2        1.38 ± 14%  perf-profile.children.cycles-pp.__get_user_pages
      0.18 ± 37%      +1.3        1.43 ± 20%      +1.2        1.33 ± 19%      +1.2        1.38 ± 14%  perf-profile.children.cycles-pp.get_user_pages_remote
      0.39 ± 43%      +1.4        1.82 ±  8%      +1.5        1.93 ± 13%      +1.4        1.81 ± 15%  perf-profile.children.cycles-pp.wp_page_copy
      0.53 ± 14%      +1.9        2.48 ± 11%      +2.1        2.65 ± 13%      +2.2        2.69 ± 14%  perf-profile.children.cycles-pp.execve
      0.53 ± 15%      +1.9        2.48 ± 11%      +2.1        2.65 ± 13%      +2.2        2.69 ± 14%  perf-profile.children.cycles-pp.do_execveat_common
      0.53 ± 15%      +1.9        2.48 ± 11%      +2.1        2.65 ± 13%      +2.2        2.69 ± 14%  perf-profile.children.cycles-pp.__x64_sys_execve
      5.78            +3.1        8.85 ±  6%      +3.3        9.10 ±  3%      +3.4        9.17 ±  4%  perf-profile.children.cycles-pp.kthread
      2.28 ±  5%      +3.2        5.48 ± 11%      +2.9        5.20 ±  6%      +2.8        5.12 ±  5%  perf-profile.children.cycles-pp.intel_idle
      5.84            +3.3        9.16 ±  7%      +3.7        9.50 ±  3%      +3.7        9.54 ±  4%  perf-profile.children.cycles-pp.ret_from_fork
      5.84            +3.4        9.20 ±  6%      +3.7        9.54 ±  3%      +3.7        9.58 ±  4%  perf-profile.children.cycles-pp.ret_from_fork_asm
      1.46 ±  7%      +3.5        4.97 ±  8%      +3.9        5.32 ± 11%      +4.0        5.50 ± 11%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.46 ±  7%      +3.5        4.97 ±  8%      +3.9        5.32 ± 11%      +4.0        5.50 ± 11%  perf-profile.children.cycles-pp.do_syscall_64
      4.87            +3.7        8.62 ±  6%      +4.0        8.84 ±  3%      +4.1        8.97 ±  4%  perf-profile.children.cycles-pp.balance_pgdat
      4.87            +3.7        8.62 ±  6%      +4.0        8.84 ±  3%      +4.1        8.97 ±  4%  perf-profile.children.cycles-pp.kswapd
     68.16            +4.2       72.34            +3.7       71.89 ±  2%      +4.0       72.20 ±  2%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      6.72 ±  2%      +4.5       11.21 ±  9%      +3.9       10.60 ±  4%      +3.8       10.50 ±  5%  perf-profile.children.cycles-pp.start_secondary
      6.94 ±  2%      +4.6       11.50 ±  9%      +4.0       10.90 ±  4%      +3.8       10.78 ±  5%  perf-profile.children.cycles-pp.common_startup_64
      6.94 ±  2%      +4.6       11.50 ±  9%      +4.0       10.90 ±  4%      +3.8       10.78 ±  5%  perf-profile.children.cycles-pp.cpu_startup_entry
      6.93 ±  2%      +4.6       11.50 ±  9%      +4.0       10.90 ±  4%      +3.9       10.78 ±  5%  perf-profile.children.cycles-pp.do_idle
     68.51            +5.0       73.50            +5.2       73.70            +5.0       73.46        perf-profile.children.cycles-pp.folio_alloc_mpol_noprof
      3.78            +5.5        9.32 ±  9%      +5.0        8.82 ±  5%      +4.9        8.70 ±  5%  perf-profile.children.cycles-pp.cpuidle_enter_state
      3.80            +5.6        9.39 ±  9%      +5.1        8.87 ±  5%      +5.0        8.76 ±  5%  perf-profile.children.cycles-pp.cpuidle_enter
      4.70            +6.4       11.09 ±  8%      +5.8       10.52 ±  4%      +5.7       10.40 ±  5%  perf-profile.children.cycles-pp.cpuidle_idle_call
     69.40            +7.4       76.85            +8.2       77.62            +8.1       77.54        perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
     69.44            +8.1       77.55            +8.9       78.37            +8.9       78.36        perf-profile.children.cycles-pp.__alloc_pages_noprof
     68.72            +8.7       77.46            +9.6       78.30            +9.6       78.30        perf-profile.children.cycles-pp.__alloc_pages_slowpath
     65.97           +11.3       77.23           +12.1       78.09           +12.1       78.09        perf-profile.children.cycles-pp.try_to_free_pages
     65.66           +11.5       77.18           +12.4       78.05           +12.4       78.05        perf-profile.children.cycles-pp.do_try_to_free_pages
     70.51           +15.3       85.80           +16.4       86.90           +16.5       87.02        perf-profile.children.cycles-pp.shrink_node
     68.95           +16.8       85.72           +17.9       86.84           +18.0       86.97        perf-profile.children.cycles-pp.shrink_many
     68.92           +16.8       85.71           +17.9       86.83           +18.0       86.96        perf-profile.children.cycles-pp.shrink_one
     68.42           +17.3       85.68           +18.4       86.80           +18.5       86.94        perf-profile.children.cycles-pp.try_to_shrink_lruvec
     68.37           +17.3       85.67           +18.4       86.80           +18.6       86.93        perf-profile.children.cycles-pp.evict_folios
     64.64           +20.7       85.30 ±  2%     +22.0       86.63           +22.1       86.76        perf-profile.children.cycles-pp.shrink_folio_list
     43.46           +39.8       83.30 ±  2%     +41.4       84.85           +41.5       84.97        perf-profile.children.cycles-pp.try_to_unmap_flush_dirty
     43.44           +39.9       83.30 ±  2%     +41.4       84.85           +41.5       84.97        perf-profile.children.cycles-pp.arch_tlbbatch_flush
     43.35           +40.0       83.33 ±  2%     +41.5       84.87           +41.6       84.99        perf-profile.children.cycles-pp.on_each_cpu_cond_mask
     43.34           +40.0       83.33 ±  2%     +41.5       84.87           +41.6       84.99        perf-profile.children.cycles-pp.smp_call_function_many_cond
      5.95 ±  4%      -4.9        1.04 ±  7%      -4.9        1.08 ±  2%      -5.0        1.00 ±  2%  perf-profile.self.cycles-pp.llist_add_batch
      4.70 ±  4%      -4.3        0.41 ±142%      -4.6        0.15 ± 11%      -4.6        0.15 ± 11%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      4.45 ±  2%      -3.8        0.64 ±  4%      -3.8        0.65 ±  4%      -3.8        0.66 ±  4%  perf-profile.self.cycles-pp.llist_reverse_order
      4.31 ±  5%      -3.8        0.53 ± 14%      -3.9        0.40 ± 16%      -3.9        0.42 ± 19%  perf-profile.self.cycles-pp.do_rw_once
      3.65 ±  2%      -3.0        0.66 ±  4%      -3.0        0.65 ±  3%      -3.0        0.65 ±  4%  perf-profile.self.cycles-pp.default_send_IPI_mask_sequence_phys
      3.14 ±  9%      -2.8        0.36 ±  4%      -2.8        0.36 ±  4%      -2.8        0.35 ±  2%  perf-profile.self.cycles-pp.flush_tlb_func
      2.56 ±  5%      -2.3        0.30 ± 16%      -2.3        0.23 ± 18%      -2.3        0.24 ± 15%  perf-profile.self.cycles-pp.do_access
      2.35 ±  4%      -2.1        0.27 ±  6%      -2.1        0.26 ±  5%      -2.1        0.26 ±  3%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      2.39            -2.1        0.34 ±  5%      -2.1        0.31 ±  6%      -2.1        0.31 ±  5%  perf-profile.self.cycles-pp.native_irq_return_iret
      1.83 ±  3%      -1.7        0.09 ± 10%      -1.7        0.09 ±  7%      -1.7        0.09 ± 10%  perf-profile.self.cycles-pp.native_flush_tlb_local
      1.92 ±  3%      -1.7        0.24 ±  4%      -1.7        0.25 ±  7%      -1.7        0.26 ±  3%  perf-profile.self.cycles-pp.page_counter_try_charge
      1.69 ±  4%      -1.4        0.31 ± 11%      -1.4        0.26 ±  9%      -1.4        0.26 ± 12%  perf-profile.self.cycles-pp._raw_spin_lock
      1.12 ± 14%      -1.0        0.10 ±  6%      -1.0        0.10 ±  7%      -1.0        0.10 ±  5%  perf-profile.self.cycles-pp.set_tlb_ubc_flush_pending
      0.99 ±  6%      -0.9        0.10 ± 10%      -0.9        0.09 ±  8%      -0.9        0.09 ±  9%  perf-profile.self.cycles-pp.try_to_unmap_one
      0.98 ±  7%      -0.9        0.12 ± 11%      -0.9        0.10 ± 16%      -0.9        0.10 ± 13%  perf-profile.self.cycles-pp.try_charge_memcg
      0.94 ±  5%      -0.8        0.10 ±  4%      -0.8        0.11 ±  8%      -0.8        0.11 ±  5%  perf-profile.self.cycles-pp.mem_cgroup_id_get_online
      0.75 ± 13%      -0.7        0.07 ± 34%      -0.7        0.04 ± 57%      -0.7        0.04 ± 66%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.74 ±  4%      -0.7        0.08 ± 17%      -0.7        0.06 ± 14%      -0.7        0.06 ± 15%  perf-profile.self.cycles-pp.sync_regs
      0.75 ±  5%      -0.7        0.09 ± 27%      -0.7        0.07 ± 11%      -0.7        0.07 ±  7%  perf-profile.self.cycles-pp.shrink_folio_list
      0.76 ±  9%      -0.7        0.10 ±  9%      -0.7        0.10 ±  7%      -0.7        0.10 ±  7%  perf-profile.self.cycles-pp._find_next_bit
      0.63 ±  3%      -0.6        0.07 ± 16%      -0.6        0.06 ± 10%      -0.6        0.06 ±  9%  perf-profile.self.cycles-pp.swap_writepage
      0.57 ±  9%      -0.5        0.04 ± 72%      -0.5        0.02 ±100%      -0.5        0.03 ±100%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.47 ±  7%      -0.4        0.02 ± 99%      -0.5        0.02 ±129%      -0.5        0.01 ±300%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.56 ±  4%      -0.4        0.13 ±  5%      -0.4        0.13 ±  6%      -0.4        0.13 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.48 ±  6%      -0.4        0.05 ±  7%      -0.4        0.06 ± 26%      -0.4        0.06 ± 11%  perf-profile.self.cycles-pp.swap_cgroup_record
      0.45 ±  6%      -0.4        0.04 ±115%      -0.4        0.00            -0.4        0.00        perf-profile.self.cycles-pp.lru_gen_add_folio
      0.46 ±  2%      -0.4        0.05 ± 90%      -0.4        0.01 ±173%      -0.4        0.02 ±152%  perf-profile.self.cycles-pp.lru_gen_del_folio
      0.40 ±  6%      -0.4        0.04 ± 71%      -0.4        0.01 ±173%      -0.4        0.02 ±152%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.38 ±  3%      -0.3        0.04 ± 45%      -0.4        0.00 ±387%      -0.4        0.00        perf-profile.self.cycles-pp.do_anonymous_page
      0.28 ±  8%      -0.2        0.07 ± 12%      -0.2        0.07 ± 11%      -0.2        0.06 ± 10%  perf-profile.self.cycles-pp.error_entry
      0.38 ±  6%      -0.2        0.19 ±  5%      -0.2        0.18 ±  6%      -0.2        0.18 ±  7%  perf-profile.self.cycles-pp.native_sched_clock
      0.25 ± 10%      -0.2        0.06 ± 13%      -0.2        0.05 ± 28%      -0.2        0.05 ± 35%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.23 ±  7%      -0.1        0.08 ± 10%      -0.1        0.10 ±113%      -0.2        0.08 ± 13%  perf-profile.self.cycles-pp.memcpy_toio
      0.19 ± 11%      -0.1        0.06 ± 13%      -0.1        0.07 ±105%      -0.1        0.04 ± 51%  perf-profile.self.cycles-pp.io_serial_in
      0.16 ±  8%      -0.1        0.06 ± 17%      -0.1        0.06 ±  6%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp.asm_sysvec_call_function
      0.11 ± 11%      -0.1        0.04 ± 44%      -0.1        0.01 ±173%      -0.1        0.01 ±300%  perf-profile.self.cycles-pp.irqentry_enter
      0.17 ±  8%      -0.1        0.10 ±  8%      -0.1        0.10 ±  8%      -0.1        0.10 ±  9%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.09 ±  7%      -0.0        0.05 ±  8%      -0.0        0.05 ± 38%      -0.0        0.05 ± 34%  perf-profile.self.cycles-pp.sched_core_idle_cpu
      0.00            +0.0        0.00            +0.0        0.00            +0.1        0.10 ±  6%  perf-profile.self.cycles-pp.should_flush_tlb
      0.03 ± 70%      +0.0        0.08 ±  6%      +0.0        0.08 ±  7%      +0.0        0.07 ± 10%  perf-profile.self.cycles-pp.read_tsc
      0.00            +0.1        0.05 ± 49%      +0.1        0.06 ± 15%      +0.1        0.05 ± 34%  perf-profile.self.cycles-pp.intel_idle_irq
      0.00            +0.1        0.05 ±  8%      +0.0        0.04 ± 48%      +0.0        0.04 ± 51%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.00            +0.1        0.06 ± 11%      +0.1        0.06 ±  9%      +0.1        0.06 ±  5%  perf-profile.self.cycles-pp.tick_nohz_stop_tick
      0.00            +0.1        0.06 ± 14%      +0.1        0.06 ±  8%      +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.cpuidle_enter
      0.00            +0.1        0.06 ± 14%      +0.1        0.06 ±  8%      +0.1        0.06 ± 12%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.07 ± 12%      +0.1        0.14 ± 11%      +0.1        0.13 ±  8%      +0.1        0.13 ±  6%  perf-profile.self.cycles-pp.ktime_get
      0.00            +0.1        0.06 ± 11%      +0.1        0.06 ±  9%      +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.irq_work_needs_cpu
      0.00            +0.1        0.07 ± 11%      +0.1        0.06 ± 10%      +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.1        0.07 ± 13%      +0.1        0.06 ± 13%      +0.1        0.06 ± 12%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.00            +0.1        0.07 ± 10%      +0.1        0.07 ±  9%      +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.00            +0.1        0.08 ± 10%      +0.1        0.08 ±  9%      +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.get_cpu_device
      0.00            +0.1        0.09 ±  4%      +0.1        0.09 ±  9%      +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.tick_irq_enter
      0.01 ±223%      +0.1        0.10 ±  9%      +0.1        0.10 ±  9%      +0.1        0.10 ±  9%  perf-profile.self.cycles-pp.__get_next_timer_interrupt
      0.00            +0.1        0.10 ± 11%      +0.1        0.09 ±  9%      +0.1        0.09 ±  6%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.00            +0.1        0.10 ±  9%      +0.1        0.10 ±  8%      +0.1        0.10 ±  6%  perf-profile.self.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.02 ± 99%      +0.3        0.30 ± 19%      +0.3        0.30 ± 14%      +0.3        0.29 ± 14%  perf-profile.self.cycles-pp.poll_idle
      0.13 ±  8%      +0.4        0.50 ±  8%      +0.4        0.49 ±  4%      +0.3        0.48 ±  6%  perf-profile.self.cycles-pp.menu_select
      0.11 ± 13%      +0.6        0.69 ±  9%      +0.5        0.64 ±  4%      +0.5        0.63 ±  5%  perf-profile.self.cycles-pp.cpuidle_enter_state
      2.28 ±  5%      +3.2        5.48 ± 11%      +2.9        5.20 ±  6%      +2.8        5.12 ±  5%  perf-profile.self.cycles-pp.intel_idle
     24.40           +56.1       80.53 ±  2%     +57.6       82.01           +57.8       82.17        perf-profile.self.cycles-pp.smp_call_function_many_cond



> 
> ---8<---
> 
> From 49af9b203e971d00c87b2d020f48602936870576 Mon Sep 17 00:00:00 2001
> From: Rik van Riel <riel@fb.com>
> Date: Mon, 2 Dec 2024 09:57:31 -0800
> Subject: [PATCH] x86,mm: only trim the mm_cpumask once a second
> 
> Setting and clearing CPU bits in the mm_cpumask is only ever done
> by the CPU itself, from the context switch code or the TLB flush
> code.
> 
> Synchronization is handled by switch_mm_irqs_off blocking interrupts.
> 
> Sending TLB flush IPIs to CPUs that are in the mm_cpumask, but no
> longer running the program causes a regression in the will-it-scale
> tlbflush2 test. This test is contrived, but a large regression here
> might cause a small regression in some real world workload.
> 
> Instead of always sending IPIs to CPUs that are in the mm_cpumask,
> but no longer running the program, send these IPIs only once a second.
> 
> The rest of the time we can skip over CPUs where the loaded_mm is
> different from the target mm.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Reported-by: kernel test roboto <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202411282207.6bd28eae-lkp@intel.com/
> ---
>  arch/x86/include/asm/mmu.h         |  2 ++
>  arch/x86/include/asm/mmu_context.h |  1 +
>  arch/x86/include/asm/tlbflush.h    |  1 +
>  arch/x86/mm/tlb.c                  | 35 +++++++++++++++++++++++++++---
>  4 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
> index ce4677b8b735..3b496cdcb74b 100644
> --- a/arch/x86/include/asm/mmu.h
> +++ b/arch/x86/include/asm/mmu.h
> @@ -37,6 +37,8 @@ typedef struct {
>  	 */
>  	atomic64_t tlb_gen;
>  
> +	unsigned long next_trim_cpumask;
> +
>  #ifdef CONFIG_MODIFY_LDT_SYSCALL
>  	struct rw_semaphore	ldt_usr_sem;
>  	struct ldt_struct	*ldt;
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> index 2886cb668d7f..795fdd53bd0a 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -151,6 +151,7 @@ static inline int init_new_context(struct task_struct *tsk,
>  
>  	mm->context.ctx_id = atomic64_inc_return(&last_mm_ctx_id);
>  	atomic64_set(&mm->context.tlb_gen, 0);
> +	mm->context.next_trim_cpumask = jiffies + HZ;
>  
>  #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
>  	if (cpu_feature_enabled(X86_FEATURE_OSPKE)) {
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index 69e79fff41b8..02fc2aa06e9e 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -222,6 +222,7 @@ struct flush_tlb_info {
>  	unsigned int		initiating_cpu;
>  	u8			stride_shift;
>  	u8			freed_tables;
> +	u8			trim_cpumask;
>  };
>  
>  void flush_tlb_local(void);
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 1aac4fa90d3d..0507a6773a37 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -892,9 +892,36 @@ static void flush_tlb_func(void *info)
>  			nr_invalidate);
>  }
>  
> -static bool tlb_is_not_lazy(int cpu, void *data)
> +static bool should_flush_tlb(int cpu, void *data)
>  {
> -	return !per_cpu(cpu_tlbstate_shared.is_lazy, cpu);
> +	struct flush_tlb_info *info = data;
> +
> +	/* Lazy TLB will get flushed at the next context switch. */
> +	if (per_cpu(cpu_tlbstate_shared.is_lazy, cpu))
> +		return false;
> +
> +	/* No mm means kernel memory flush. */
> +	if (!info->mm)
> +		return true;
> +
> +	/* The target mm is loaded, and the CPU is not lazy. */
> +	if (per_cpu(cpu_tlbstate.loaded_mm, cpu) == info->mm)
> +		return true;
> +
> +	/* In cpumask, but not the loaded mm? Periodically remove by flushing. */
> +	if (info->trim_cpumask)
> +		return true;
> +
> +	return false;
> +}
> +
> +static bool should_trim_cpumask(struct mm_struct *mm)
> +{
> +	if (time_after(jiffies, READ_ONCE(mm->context.next_trim_cpumask))) {
> +		WRITE_ONCE(mm->context.next_trim_cpumask, jiffies + HZ);
> +		return true;
> +	}
> +	return false;
>  }
>  
>  DEFINE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared);
> @@ -928,7 +955,7 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
>  	if (info->freed_tables)
>  		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
>  	else
> -		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func,
> +		on_each_cpu_cond_mask(should_flush_tlb, flush_tlb_func,
>  				(void *)info, 1, cpumask);
>  }
>  
> @@ -979,6 +1006,7 @@ static struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
>  	info->freed_tables	= freed_tables;
>  	info->new_tlb_gen	= new_tlb_gen;
>  	info->initiating_cpu	= smp_processor_id();
> +	info->trim_cpumask	= 0;
>  
>  	return info;
>  }
> @@ -1021,6 +1049,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>  	 * flush_tlb_func_local() directly in this case.
>  	 */
>  	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids) {
> +		info->trim_cpumask = should_trim_cpumask(mm);
>  		flush_tlb_multi(mm_cpumask(mm), info);
>  	} else if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
>  		lockdep_assert_irqs_enabled();
> -- 
> 2.47.0
> 
> 
> 


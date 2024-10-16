Return-Path: <linux-kernel+bounces-366953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0086C99FCA7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B70B1C2465D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ED114A630;
	Wed, 16 Oct 2024 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="espuS4/I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647C71448E3
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729036818; cv=fail; b=rRPo1BNM0AeyygZYdwtRgeiFM8OHIvPACeoUlcMIRiqMWab0QimAbklAXiT0PgP7mTAh0AVCNZcGmrlE9Nt+49MZe+HYLb/54kD1GeJe7gzeAwkZMkeN5xzhw3slM93eNUtvnxGOzCS02TR9OHd6GEw9gmg/A5QZkakwRTgtbmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729036818; c=relaxed/simple;
	bh=kfp2wLisexsEB9MBnRXUB5p/KoC5ijejx6TAb8ZLlv0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=niZvTvMXrjeMx8gUBYOIPpqWfwLllZM/UGsQnX3eps7RgLJ/GtnXp7kUGZjadzy82f0Iev9TTxwpTuhiszfd9ToDViX+AvyZJ58htX2uQ0E34RzrGWFgRCNtLlGaVmafDTE8fzWbUHEOS0g5WwHb+E4a6RKXqTgOpYK/bngfAGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=espuS4/I; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729036817; x=1760572817;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kfp2wLisexsEB9MBnRXUB5p/KoC5ijejx6TAb8ZLlv0=;
  b=espuS4/I55HTGQ9161M6mC+lcAPHYketrlqLatj5y12B5pS2E7RACiuV
   ycGjJaHrUtApB+p6lERz5un1znFmZb6YgPgcABRV6nAqhkHMlFbu4UrBd
   r5NBkwttTz9xgYSRcWKUxGZEGjEFA6rYWEDm6CxoGU0ZXgBiq8x7/tFGn
   cMrFTH0N/hdKLC4zwTm8obHufYKWk3sWjfNXvj4pS0PMh4UtPWP25Fvw5
   Q4dh1KpZ0Qi1m9pbBGxT4J0v/B/CERBjIKzVwkYvyYxN42JM2+fLQSwek
   UQ3mswsIMMsiwCi1seK//ZK1h7ncYzTClRP31NV1xX9uKqTt9B8UOuuHK
   g==;
X-CSE-ConnectionGUID: 2Oh0Q5l0Qvq579HdwN1bwA==
X-CSE-MsgGUID: dH5Y/GcFRJO4KrE3vhe59g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51000742"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51000742"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 17:00:16 -0700
X-CSE-ConnectionGUID: QtepHMjqQImO5O+vXIZGQw==
X-CSE-MsgGUID: G3E6MyncQ7CSch2159epog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="115500091"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 17:00:16 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 17:00:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 17:00:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 17:00:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUpldyKezIBJk3t168i+fJE5kgtAlGyHSaQgW3aDd3j6PIRWBPBAhRlX+4Gir3Mhla1cjMZCWxQux5h3gbd1TaXM6yIk/LekUV8e1HIAHjgXA0474Sl4wbW6uI/xlIA0SsVxA+h9UkzJVCGcMTOvfePojETAbol5p5+5x7jWkkNsTBzYmxcg5W7t26+TKPBkLiKOfs9CMCWbKFsJMggRG28GpgspFn+gOMuF967cLli0e4DPzwbth/c33eKTv7np4E4CZ68aWIutA25nezZWdII/4mI0FvwW7Y92dhO9Rxcoc2HdgG5+nuRAW5xaojLvFXcozmn9xs0BzHLUWZGbYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPZy4Y3QDP7U8QKWKZs/N98LGwTbdPqWry2iwa/Haeg=;
 b=mT+dnDpiyJ2vaLeM46FtJOUOEnmOmrCid857AtixeW8oVnvBTOopRWCQzUgMxsJcAnmsszOHGDwtDlolzPqnrx+v/QprXdCERAH/A2cl9ahMzUVpr1mqyAJtSDu39X87qMVvJA7qfFmPPOoeuC/M04n17r2SJuocW0T1J9lONOpVepnxeKKd6ty5AKGTsWtjyDFl4vLlHnHTxZEbqz1SYXx4g+Pl585RlmI6wlh3x61giATQWkYQjFvzUR+hvuNNHqlwuePXrlVwbGQks/fpXYWfHysShyWMeZVgRUSAMW1j2xzY5ewy9wkmHCH0g925lQ39vKmAsMmVtulKaNMHiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5021.namprd11.prod.outlook.com (2603:10b6:a03:2dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 00:00:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 00:00:12 +0000
Date: Tue, 15 Oct 2024 17:00:09 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, "Nathan
 Chancellor" <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH] resource: Remove dependency on SPARSEMEM from
 GET_FREE_REGION
Message-ID: <670f0209ab155_3ee2294c2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241015051554.294734-1-ying.huang@intel.com>
 <942d18c3-f9a8-482e-a166-c7c9d6fb28d7@redhat.com>
 <878qup94jb.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <3450df1e-dcb2-495a-8fe4-0a6e096429fd@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3450df1e-dcb2-495a-8fe4-0a6e096429fd@redhat.com>
X-ClientProxiedBy: SJ0PR03CA0281.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5021:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b7cf02-e5b4-48c4-6462-08dced758187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TXvuZDmI1UCZSM27A/hjBiUKbQCFZvZ/LXblPNvtE2n2j8HohIzhY9mftHI8?=
 =?us-ascii?Q?n8QWkClMQlmWyB3yRjivS7rRzA71caAJ3oDfPI6SI5+9Q5z1jAPXViygqjAt?=
 =?us-ascii?Q?P0AW67s8K5PPOWbKkfPSlyC1vMt0pNsial6mIWeEdOlN+xpEdy5Nb1kaR1s+?=
 =?us-ascii?Q?ZE9/yJLxZJ5ihWVoM2m7Vqm5ER6gS70i/iHd15AsbmiSnrmc8SebyuI7o4jF?=
 =?us-ascii?Q?AfVprf0zvUO/8LjP4+nZOP0mUTGdJLT9VL2AEW3JeHKjclrRVzacZKcGJgB4?=
 =?us-ascii?Q?Uj+9N0kKxGmhr/W1BJm7QC2JI+n9mr7lCH3bijTw19KPuNP3s9u44F7+u6Be?=
 =?us-ascii?Q?QoCijhd5RC5Za1StbGv1MFDFK6L8ad3uk0XEH0ZaAz4zQV9QBtNrVp1joLNy?=
 =?us-ascii?Q?3oHdzVrU5Jci/jlIVXKV/jkFlCsp8y9Inq7UtGrfYXgX3wYOb7xjZ8i8xrFr?=
 =?us-ascii?Q?zjIGoafE3DSpyBcDtG5g4GRMW9nrFjF05DwmtwgrWLWQ9rNLBl5RXhWUU5VD?=
 =?us-ascii?Q?Len+3spvHubMyUgup/AB98jsqxY49zf8NlRfwsobnOac/d47TZz3db1dk7Re?=
 =?us-ascii?Q?USwk4t04vAXEyIMoQzqREgslCx8GgjWF1kpiTcuH+0iHcm1et6JVIhn4jP4e?=
 =?us-ascii?Q?igy16apoacPDETMHCBtpihCunRbzDf4DfZ5dYfb8VwjHriUzbxlAETjfrASy?=
 =?us-ascii?Q?0Pnv58HerScMuikW8qMtLRowBtTs3IgnjFCe42cjLXUSVqmBtUZCRYbb6C7Z?=
 =?us-ascii?Q?ESNRhsXdnfcbM+XB/xJD7HdZsYaT69yeVZtGDHkEQu30auHlgU1cFZtpFVWL?=
 =?us-ascii?Q?xO1vlZF7TJ29IlXaqHHCdCVWO5GiJ3gm/d2qj9Lo0Iv3AntsEJ0jTI6pE/nC?=
 =?us-ascii?Q?GSY6pjdr/wKM7H+F2SZBtG88x3PHhsxHifreaDqvPnqIvkqJP2c4ZXAuDwhQ?=
 =?us-ascii?Q?cGQRuuzdBjsGsd3harz4FtDtQyAEpsEj/gqHSAt4p1pWrL+y7U2UgxBXh/Mc?=
 =?us-ascii?Q?aucF6wzsaXbD/AiQ5jTT4gsTkSHisJggleMyyVLd9zauyOtSFEGPsVm6pR+9?=
 =?us-ascii?Q?WtRHp/T4KR94T+AS8zcKprs9Jf0n4Ol3R6g2kBrH9Xi2I6mDc7VRVHX7Ip1O?=
 =?us-ascii?Q?vM7vLgsYCET6zhaD9uP2kkVrgoTC7b1iLGwpkMultEr4Q9n3S7hgFRmZ/SLV?=
 =?us-ascii?Q?+7WoFqX6iVx0Cz0J4/sU5K8+YcoWhDsHonGJNWtJUuO8cqmJJYloh+YLThAH?=
 =?us-ascii?Q?ndfYP/qwkWtD1vdvi5dtpPYvj3Tug5rrPq5usx21bXfafvuS4w1FlwbA9fot?=
 =?us-ascii?Q?uVA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QLssXNbHDpHvlHawihzNMXGjIrB/tfBMGXlXEof4OnxXEvqGo0Dosqd15RZc?=
 =?us-ascii?Q?aTVbFp0+OMIWa4Y46nSpoVumkpW8izZcdYB/6CH7Kc6/TOyIbJxMcty/HMfn?=
 =?us-ascii?Q?aaiK7PrTzyOnCo+T65JU0jKEZvBdtJgySvZORZSJblyMMRETG9FvLtBD+IPz?=
 =?us-ascii?Q?reiJqB31iH517kr6ULbbvORmvrDdRlHzAvL9ULXTSyLRX4GwfWT//5MEuk8Z?=
 =?us-ascii?Q?bhPSiLOjDsZzlAOs/FfeKZ4cAlu70GPOGZ7IChvGwUJuBwV9cWeGakmjMriz?=
 =?us-ascii?Q?gtw4cga2/D+wj5iri/zkC8JKY180fdZz1m6OF9hZTtfybsoxOD7+51WxRo2E?=
 =?us-ascii?Q?8caeW7bPzk3D1Pat7wkXX5QzNIitlk9A/1o68aQH/fl5DzSIQascMkye6Qw0?=
 =?us-ascii?Q?IKHkBllzg6ZVmYw8WpInV9HsQnL9+9mwX7Sr0R1f3eYixLQAbYDiapQAXUv/?=
 =?us-ascii?Q?CUadvQxFABBBNqPm+bbB6IsLZQpUt3ebl+NNB5MVS3zeEEnNqxpLq1hbKUO5?=
 =?us-ascii?Q?tWHK9u+b05n+aDOy8lHlTBdwgo5JS1OjotRnn013+DL5/eIswRDXfXYLsqht?=
 =?us-ascii?Q?U+hR1Qw0jyN1m3BGRIGmyxLIvboPdZtV2U6pu+Ewpyhh9ebZIKAVV8E0UmYU?=
 =?us-ascii?Q?RUEnyyeAD+pnEQf3Ynn6PM8KcK0IgEaxqA7uL5xTHLF+vLKSpOBw2sS0QwOc?=
 =?us-ascii?Q?T2jxa4QzUuak4M/RwN6bHydHga7qPSM5QQC78QrAN9RRBpekPGA6poTrMNB/?=
 =?us-ascii?Q?MWTBqVjoRpa65J59MN+i2z5tgCvFxwHa4PP8afebtcn3p12IXuUw7Otnu+42?=
 =?us-ascii?Q?ZjFGe7u9IRaPNp1d7oHjr4YhXvyCTno7GE2WxiJWrfACqgikpu9CZklkaqkK?=
 =?us-ascii?Q?RbCD6FZUiOdzWuH9DWWhVt0c2kT6LOoA9WEjfCZ8Zrd37dl80mfv8drzed25?=
 =?us-ascii?Q?vb3unZNb3kqls4ptptsZcI0hkq/HzF7iSWwuFgxOIFJ9B9ytVvrjz4DZvxyk?=
 =?us-ascii?Q?X2eIk4OXM91ozyDf2YMX9m0lR9JrZNlVlbvi8+VMvDQjyyelbnY/HnoyfbTG?=
 =?us-ascii?Q?2MDc2G0BOyqwQ5x66pBcirGrYk258Ib5PjMPjgVUemCij9B5VFFn6oedtANw?=
 =?us-ascii?Q?JRwhGYRtjg7Ycail/WbgYKv1cXFGmSdIRWRvmDu836AbffGJZrb56XXBG1yo?=
 =?us-ascii?Q?eKE9/+m08G8xhPMRESHr7hYLf8MeYyCb6FQc0WSGaau1WMIdtOHwPu74A5QI?=
 =?us-ascii?Q?aO0PrMHxGKmE7UA+7R9QPeXJEZPlQdILKyVC8fV0jXXaHT4Pq4HCYNsmqELx?=
 =?us-ascii?Q?BqClDP/lMAUPnsfq5qbEibNZdgpgKu6ODvQCgynnrBCD0Qx5Sac5u2fTWdOb?=
 =?us-ascii?Q?fkY+mf7PfjTJdwP1WGnxYjMVJqSnHMLEkSVlOnvxFeK81aZpB9m51vGBovUS?=
 =?us-ascii?Q?vAbJZiBnYcozKF0WPJboB+rCWKet5hpQbazzyN7a6S24KjsGTcrrW0fbui1r?=
 =?us-ascii?Q?nyEk0B9i7FD2ww2g5f8gE/CgSv3jIBFk3nOT4ftDcOCMJIaAnKrgZGmil2aU?=
 =?us-ascii?Q?OWaVlI19pP3okePAYrie+AHQoBsGbBDwN4Vh6KpqNxtvdosuDMFkMX6qEstI?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b7cf02-e5b4-48c4-6462-08dced758187
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 00:00:12.1602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhCnj1vnkMdJLBsBOfP/7Pwqi6IrKxPMz/HAw4rDnjW85DRikvpmUj5BQAqldepoypVVYXMAnUpBmkhryUrJ5PzixIjPyA1T0StcmmUjwUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5021
X-OriginatorOrg: intel.com

David Hildenbrand wrote:
> On 15.10.24 10:03, Huang, Ying wrote:
> > Hi, David,
> > 
> > David Hildenbrand <david@redhat.com> writes:
> > 
> >> On 15.10.24 07:15, Huang Ying wrote:
> >>> We want to use the functions configured via GET_FREE_REGION in
> >>> resource kunit tests.  However, GET_FREE_REGION depends on SPARSEMEM.
> >>> This makes resource kunit tests cannot be built on some architectures
> >>> lacking SPARSEMEM.  In fact, these functions doesn't depend on
> >>> SPARSEMEM now.  So, remove dependency on SPARSEMEM from
> >>> GET_FREE_REGION.
> >>> Link:
> >>> https://lore.kernel.org/lkml/20240922225041.603186-1-linux@roeck-us.net/
> >>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> >>> Tested-by: Guenter Roeck <linux@roeck-us.net>
> >>> Cc: Nathan Chancellor <nathan@kernel.org>
> >>> Cc: Arnd Bergmann <arnd@arndb.de>
> >>> Cc: Dan Williams <dan.j.williams@intel.com>
> >>> Cc: David Hildenbrand <david@redhat.com>
> >>> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> >>> ---
> >>>    mm/Kconfig | 1 -
> >>>    1 file changed, 1 deletion(-)
> >>> diff --git a/mm/Kconfig b/mm/Kconfig
> >>> index 4c9f5ea13271..33fa51d608dc 100644
> >>> --- a/mm/Kconfig
> >>> +++ b/mm/Kconfig
> >>> @@ -1085,7 +1085,6 @@ config HMM_MIRROR
> >>>    	depends on MMU
> >>>      config GET_FREE_REGION
> >>> -	depends on SPARSEMEM
> >>>    	bool
> >>>      config DEVICE_PRIVATE
> >>
> >> Added by
> >>
> >> commit 14b80582c43e4f550acfd93c2b2cadbe36ea0874
> >> Author: Dan Williams <dan.j.williams@intel.com>
> >> Date:   Fri May 20 13:41:24 2022 -0700
> >>
> >>      resource: Introduce alloc_free_mem_region()
> >>
> >> @Dan, any insight why that dependency was added?
> > 
> > Dan has explain it some what in the following email,
> > 
> > https://lore.kernel.org/lkml/66f5abd431dce_964f2294b9@dwillia2-xfh.jf.intel.com.notmuch/
> > 
> > This is reachable from the "Link:" tag in the patch.
> 
> That should be part of the patch description then :)

That Link: does not really describe the history though...

The description I would add is:

---

When get_free_mem_region() was introduced the only consumers were those
looking to pass the address range to memremap_pages(). That address
range needed to be mindful of the maximum addressable platform physical
address which at the time only SPARSMEM defined via MAX_PHYSMEM_BITS.

Given that memremap_pages() also depended on SPARSEMEM via ZONE_DEVICE,
it was easier to just depend on that definition than invent a general
MAX_PHYSMEM_BITS concept outside of SPARSEMEM.

Turns out that decision was buggy and did not account for KASAN
consumption of physical address space. That problem was resolved
recently with commit ea72ce5da228 ("x86/kaslr: Expose and use the end of
the physical memory address space"), and GET_FREE_REGION dropped its
MAX_PHYSMEM_BITS dependency.

Then commit 99185c10d5d9 ("resource, kunit: add test case for
region_intersects()"), went ahead and fixed up the only remaining
dependency on SPARSEMEM which was usage of the PA_SECTION_SHIFT macro
for setting the default alignment. A PAGE_SIZE fallback is fine in the
SPARSEMEM=n case.

With those build dependencies gone GET_FREE_REGION no longer depends on
SPARSEMEM.


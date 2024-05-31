Return-Path: <linux-kernel+bounces-196467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73358D5CA7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1B3287379
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716AB81AB7;
	Fri, 31 May 2024 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tk5LWur9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB3E78C7F
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717143860; cv=fail; b=O5NnmV9d2fO2GteCsyg9YSLTvfn+cPZ/qwji0/3EOOB/fBjlL47YIHxMxJdCVGw4MDIaKEkZ3rwzDmf401QR/frlkH52rtX3DVOwWvYDRmoP16Us/cDjy7jQzCEqDGrUvuVwjsOpMH8UTJOvIWPrymPKkhTZHCPdifXDLDyMD7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717143860; c=relaxed/simple;
	bh=3J/GxCVhgO1o4TG9FMICoffs8+Zd/dt/6YmNSktFdJg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=uBc78l2tX87aktuDQYUKRyImLf5u1QUhMm6rGeNtwTtSqYciyqWRKzCPGMiTrFR1u3y/bpmxfn6zO8BrZxIcLNwPup0HSGNEmMbe/B9LfOHhNgLgzORK0Qp1rTgIq/xnvZMdISeonuigUdx4xrqYKT8fVlXgstNC8782vTjzQTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tk5LWur9; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717143858; x=1748679858;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3J/GxCVhgO1o4TG9FMICoffs8+Zd/dt/6YmNSktFdJg=;
  b=Tk5LWur9MxTNypXTD1G5GEIMmhZmjh4plE6Cs3lFkyl2qHJx5xDXULzg
   kncbzt0LQNtefkdUcYHsmSBn9LoAmjdz/H6VRwxlSML5TCzL5R1XrDctv
   hPOTB1jSqaJZOMrUi2YzrKSq1dQyuu4Fbi/VFx+ED/lVYF6o7fKSv2/YX
   /7yxSa6/lm6S2UAvFs9aQxef98Z7r16B8vXe87QbqknZxnSfaK1q/fAPu
   bMCRUjZA46QFkHFDbobx00Bta2Zsy32YgsEFSrO1FWEHdaAOcRd0BsmEI
   uZG3pa8oFRFYyWvkTOsrRDVz0HRyhCBpOhzyR/fIkIlpgQ6vspS5AoWOg
   g==;
X-CSE-ConnectionGUID: NeD9mV55RCmLLMmnYS7D4A==
X-CSE-MsgGUID: /qV1wuiRT0uS24V4ipu7Kg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31172894"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="31172894"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 01:24:17 -0700
X-CSE-ConnectionGUID: h506HqYcStGxiRyxETQLxA==
X-CSE-MsgGUID: ggpcbI7jQsSYDV+23z1Z+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="40538609"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 May 2024 01:24:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 01:24:16 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 01:24:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 31 May 2024 01:24:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 31 May 2024 01:24:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdX3s3pxit1NW4DTY1lDzO4MEam1VgrAoKRCODh3RTLUqDWhZaKCarZBQAI/9meHPdS5e2tR1NRHferw/k9G37oN/Kk64ltyU8xamCFkupibJaZtZR7X/31cZfpz+5ac6pPg/3jPwsaldv58q6M+ZidvPRKP2vnJxoq8bm/Zt2AcMbdBeWcgf77xRNeJkrVC9gNIXq8bAHTkzmsFa1ysHj/EURBgtS6xYPXsv0Eth9BRmr1y/i8lwCy+xVacBli9+nqzcKDGlCg7kLoWPubqM+upmflapOSbV7NrWzwopgUjpeSArHVzhXzyKNnSehC3fEve6XpfsLXIerQy+qmiBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Myh3t6JP+OJsSfRHt4pqAxrf7q9N0W3GbC+/S7y7NQ=;
 b=i+wsfgbzIFrDGDimoa4628I/yZ6ruZlLuXedziTprt2LYnuy5RgeR+StwtsvocZPTB7zwYGWXTvnorck4F1vaQLMPEXpcBerdKlV25WvE5MfczXS9MKGUUNd+GD4hfecJib3gx2Ydylzn6PKjRWb++xML5cr+J0BhJ8NauIWXp7R4bwCk2kQd3v+rq3lCyvisjAJQi8Umhd4k/dGfsdemJQcPrtoeAwwSZUeNIPXrH4c3NoIk0/rHBiwyCc++tjpJjHfHUiDe/5CAwo0tyYJXubP5PYEyAFiV7pVcKhjSOPc+1uBRc542BKLWetMygdCAPI7JHsTd8CL3lmShuT5mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB8586.namprd11.prod.outlook.com (2603:10b6:a03:56e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Fri, 31 May
 2024 08:24:14 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7611.025; Fri, 31 May 2024
 08:24:13 +0000
Date: Fri, 31 May 2024 16:24:05 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Rik van Riel <riel@surriel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Yang Shi <shy828301@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, Christopher Lameter <cl@linux.com>,
	<linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [linus:master] [mm]  efa7df3e3b:
 kernel_BUG_at_include/linux/page_ref.h
Message-ID: <202405311534.86cd4043-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TYCP286CA0080.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: 68645c24-ed62-4645-fc9d-08dc814b0d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AihHHq97/mkGdNDepJZBmyAL39moitW9mhtj0bY0qyqpjiLRQK0o78G+FPOO?=
 =?us-ascii?Q?/zevSJ+gwDiI6EnvgxXkSHwP/AqHNNvYGbJEXOQOXpUTy4HXhZXR8rvjjioA?=
 =?us-ascii?Q?8S9yLwRPnlhrpMouzNXBcqODIjm5v5Fv3CyxzIBAQRJpbK0gBKB3YGufSVLm?=
 =?us-ascii?Q?+aT4w3tmOAb/OFyasQP+rLu+EVNb53birMJvw5MmitbWr3Zdx1va+LF/ntf+?=
 =?us-ascii?Q?W5y+fhSn3uJvT3QGLNqJR2ediAu13NfWqeMv4kMkhESJ/PxWq0iv666vBe9H?=
 =?us-ascii?Q?U4Rm7OPyZjPeFf5v14EDsSGlJYxXgdK3tHIqnBFaYRHI5AcaiW6stsFYheuR?=
 =?us-ascii?Q?MGM9UiAOuHGss29dTegq/3fUry/mEKcXxE008ATlkz1ubExSxEKv4y6MPnuY?=
 =?us-ascii?Q?kNRSZHZ07t3KA4qmhUf026sLlGLHV5GtQkwkouKk3RDfuBR+0MdA5sMiuTbw?=
 =?us-ascii?Q?XBHkHGzId7+oc5xPvGhMtKCJX/wB3zs6Ch8tbINurgTUhxcTlzcBlI0amB28?=
 =?us-ascii?Q?049s0lXa/pR/WfO4B0t1guuuw6Z7Iebi1qaFMLAoNGaoI2oUV05201db/sO1?=
 =?us-ascii?Q?szFj/SBAoGsZYCZ3LyBouD3U1w58JrDHe9SThAbC4jlvM4dUCSCJGutCm0hW?=
 =?us-ascii?Q?p0wyM7YN74an3uNTyZNfDv4ReTKR6FRZtfBQwNhCV91L2Ync6HoyBOZhW4gG?=
 =?us-ascii?Q?/2jG5tsZcAJ2/eOWFZxU+H4phogPKjdi3FzSi4HhGsMHs2cpEbTBP/CUOEhl?=
 =?us-ascii?Q?vvbxoXypLhmzIwAMqopQWUiFLclxza3VcPqlu8gA3h8HfibRRrfmgeytqMjY?=
 =?us-ascii?Q?xNkKB/ocBiwHZE1GjZNSCdUAGO6CmBzIwgJ7V5u3c5OVsQhdzZblPfaGFt5d?=
 =?us-ascii?Q?WVd4bPzCnGPDEH9p2UwBcORMiNqongYqNoUBCS/bNd0/RBX5DlK/9bbIip9A?=
 =?us-ascii?Q?8houeDDcVVS8+PRmnELdVt2c2Cc6M9TSJsC9W8pD0c85KNa97zHJ3Jg5miIM?=
 =?us-ascii?Q?xYLAYo37p3aQvkwyHCPX7mzylRg+/ud38tKrbc5Jz1P2pGBWzSUFGZJEOXiy?=
 =?us-ascii?Q?qDf+Kf0hHxRkZ/YYMEx0cj2HI0+ElbaLhJj6KGv6ha4DmdThvVyCmY15NN11?=
 =?us-ascii?Q?9Ce0xtBjvOAmegQbhEHWWqorDL3iERdiaU2uC2qElnI1ALSDxvSQPEXlSqtA?=
 =?us-ascii?Q?IO13EZ3HASSjuvafZZWuCObaW6Xy4Vcr9X7jhoDEbXuWbxlXo/BR6AJyu0s?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dsm/rIn1L4qEFje/osPmttbwALzhLYY47Vpfcu/oc32i0ZGCBjMm4keySSSs?=
 =?us-ascii?Q?uLFleI+d/TnBF7VvIKzA+dQXZqdaSVhQgQjBDGbJBMbyDhjuN2oKAo1yUO69?=
 =?us-ascii?Q?ewlcj4AOLzEIEJIpFPcUGsKJK6VPjw5zNxBOruh/gkaCuWyP8P71acIj6CEF?=
 =?us-ascii?Q?eU9uPT6VBUY2i+WSFZBQl3RxAplFBEfL+d/noOD55ZuBaHkxXX9GwgYmbROK?=
 =?us-ascii?Q?SY/tJOLnu+RhtXj3VFAPNYghcz0IUUJX36UJ3Ktom5u/1nnGQM/30WZNZ1La?=
 =?us-ascii?Q?m9JqMIZKtR2/ADgqjcvs5gvIcog1SGKKCmTPy1s81TfW+UfPqAI6L2lHzy41?=
 =?us-ascii?Q?8K3kLaXlZKrDzSvFmvOEJFrtsKWYE8vusCaZDY8ajzzeE3YiTcifsw8/xBRn?=
 =?us-ascii?Q?SUFv2DWxRu8W2Q8X8WuxhdXAj3CcR6IdQqhXqOIL0cXsJIP3PfRrPPRniKho?=
 =?us-ascii?Q?NxmHL4mtIfjSLiXWUfTFYu+8kalPzpfOlKAw7+RQNc4lPFQshTWai3MRoHlz?=
 =?us-ascii?Q?cfGfrp4v06huF+3KPWlgPb8ieO2TXUYywhccoDTpRyBpk5fI9/teDH9NQjnx?=
 =?us-ascii?Q?QPjTteYRS5pYPAxPT4KfUnc4A+YV+beZo1aAkKpTUmjWSggEwVDDRqre8zMh?=
 =?us-ascii?Q?AlsbSO2ohUonrc7v5XMczobv//c8w/RKdWp6RH4MuOXUnAh/mrdu8Jp8SCKj?=
 =?us-ascii?Q?qpO/ZGTfMe4nEvrMmrlOZKh9YhwtiJaUACCC6JJ66uCGEeVV7/VKhvssa2YO?=
 =?us-ascii?Q?mn3GqS3JWby2ncg6tt0FH06Kx9BOT2m9XlPvY6V477tOQ7/PiLXO+LpRRBMM?=
 =?us-ascii?Q?skNcFO+0PCAkiZ/jLoqe5egS79K4KobltBh4ZMuVhSttXE2ETWUzgJSsgcxG?=
 =?us-ascii?Q?kYcNe5dX8i8LAtGmuI8wgVGWxKGFjfFObpYvcGYwGPw3p38ACpe1YjoOqGcc?=
 =?us-ascii?Q?apKadbpZ7F6lGn/Juj8uJE+eBi4vxjGahSt83NQWRvAP3GultQSxox5Ir/mT?=
 =?us-ascii?Q?aaAvE0dYoPSvCdENLOcPjZNFxMJv/cTiX6oscjsooVu5YsYMrCL5VmjF3zpu?=
 =?us-ascii?Q?VDCpe76TgH4gxBN5AtjFTZj4WxtZhCZMkMZQY+pSJI2T/7wt1IwsiW731l3g?=
 =?us-ascii?Q?dYsE6uliLmNS25Ul/QmtP5o4VKjH740WNOo4kLYjkqdAsNADszNX61IqJ2e1?=
 =?us-ascii?Q?tc5o78HZMr4485eVr3vk9ffUsNrCGhtfL6v0aPmEd1zHq17VdTvV5bbGz+gg?=
 =?us-ascii?Q?xpDQitBNMZgVpC4m1e/AdfTi6+QRVDFylanDf4+kU8NnZkkTPlci8XSQZpj8?=
 =?us-ascii?Q?4MSgA4+fnmZLmxbJtpgB0c5ENCLdnViGAZQ/zq8fsNDPg4uVgoQfdqN5mEsn?=
 =?us-ascii?Q?Hiaa5k7CSKg4eEUaP2teixf2ThXOJNv5wNBRSJ/CnHRmoGG8eb/gehUoWKRC?=
 =?us-ascii?Q?h2YaXHl4YH5QvgNTe3hAkxiXX0FbQMestphriZuTEhdPjokjQe4sioc4Uq0m?=
 =?us-ascii?Q?q8yONdpX667bnq0COytXUH5ECgXY+aDjN83p86rFqcxmhHA9vp8gw1O20BI3?=
 =?us-ascii?Q?tYSiy7/Kn2HS6+CxNXicTP27wBSYSKCSQ2SD6znXNhafOs9auivfNfhAINDO?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68645c24-ed62-4645-fc9d-08dc814b0d75
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 08:24:13.0379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29iEEFsz9qQ+0CZ92S46ENiflXy2msqDfDlsoSQTZ/EomOeH7BH50e5kUNPiXq2vx88h1DszJwJlqfBnXpqa6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8586
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_include/linux/page_ref.h" on:

commit: efa7df3e3bb5da8e6abbe37727417f32a37fba47 ("mm: align larger anonymous mappings on THP boundaries")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      e0cce98fe279b64f4a7d81b7f5c3a23d80b92fbc]
[test failed on linux-next/master 6dc544b66971c7f9909ff038b62149105272d26a]

in testcase: trinity
version: trinity-x86_64-6a17c218-1_20240527
with following parameters:

	runtime: 300s
	group: group-00
	nr_groups: 5



compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


we noticed the issue does not always happen. 34 times out of 50 runs as below.
the parent is clean.

1803d0c5ee1a3bbe efa7df3e3bb5da8e6abbe377274
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :50          68%          34:50    dmesg.Kernel_panic-not_syncing:Fatal_exception
           :50          68%          34:50    dmesg.RIP:try_get_folio
           :50          68%          34:50    dmesg.invalid_opcode:#[##]
           :50          68%          34:50    dmesg.kernel_BUG_at_include/linux/page_ref.h



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405311534.86cd4043-lkp@intel.com


[  275.267158][ T4335] ------------[ cut here ]------------
[  275.267949][ T4335] kernel BUG at include/linux/page_ref.h:275!
[  275.268526][ T4335] invalid opcode: 0000 [#1] KASAN PTI
[  275.269001][ T4335] CPU: 0 PID: 4335 Comm: trinity-c3 Not tainted 6.7.0-rc4-00061-gefa7df3e3bb5 #1
[  275.269787][ T4335] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 275.270679][ T4335] RIP: 0010:try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3)) 
[ 275.271159][ T4335] Code: c3 cc cc cc cc 44 89 e6 48 89 df e8 e4 54 11 00 eb ae 90 0f 0b 90 31 db eb d5 9c 58 0f 1f 40 00 f6 c4 02 0f 84 46 ff ff ff 90 <0f> 0b 48 c7 c6 a0 54 d2 87 48 89 df e8 a9 e9 ff ff 90 0f 0b be 04
All code
========
   0:	c3                   	ret
   1:	cc                   	int3
   2:	cc                   	int3
   3:	cc                   	int3
   4:	cc                   	int3
   5:	44 89 e6             	mov    %r12d,%esi
   8:	48 89 df             	mov    %rbx,%rdi
   b:	e8 e4 54 11 00       	call   0x1154f4
  10:	eb ae                	jmp    0xffffffffffffffc0
  12:	90                   	nop
  13:	0f 0b                	ud2
  15:	90                   	nop
  16:	31 db                	xor    %ebx,%ebx
  18:	eb d5                	jmp    0xffffffffffffffef
  1a:	9c                   	pushf
  1b:	58                   	pop    %rax
  1c:	0f 1f 40 00          	nopl   0x0(%rax)
  20:	f6 c4 02             	test   $0x2,%ah
  23:	0f 84 46 ff ff ff    	je     0xffffffffffffff6f
  29:	90                   	nop
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 c7 c6 a0 54 d2 87 	mov    $0xffffffff87d254a0,%rsi
  33:	48 89 df             	mov    %rbx,%rdi
  36:	e8 a9 e9 ff ff       	call   0xffffffffffffe9e4
  3b:	90                   	nop
  3c:	0f 0b                	ud2
  3e:	be                   	.byte 0xbe
  3f:	04                   	.byte 0x4

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	48 c7 c6 a0 54 d2 87 	mov    $0xffffffff87d254a0,%rsi
   9:	48 89 df             	mov    %rbx,%rdi
   c:	e8 a9 e9 ff ff       	call   0xffffffffffffe9ba
  11:	90                   	nop
  12:	0f 0b                	ud2
  14:	be                   	.byte 0xbe
  15:	04                   	.byte 0x4
[  275.272813][ T4335] RSP: 0018:ffffc90005dcf650 EFLAGS: 00010202
[  275.273346][ T4335] RAX: 0000000000000246 RBX: ffffea00066e0000 RCX: 0000000000000000
[  275.274032][ T4335] RDX: fffff94000cdc007 RSI: 0000000000000004 RDI: ffffea00066e0034
[  275.274719][ T4335] RBP: ffffea00066e0000 R08: 0000000000000000 R09: fffff94000cdc006
[  275.275404][ T4335] R10: ffffea00066e0037 R11: 0000000000000000 R12: 0000000000000136
[  275.276106][ T4335] R13: ffffea00066e0034 R14: dffffc0000000000 R15: ffffea00066e0008
[  275.276790][ T4335] FS:  00007fa2f9b61740(0000) GS:ffffffff89d0d000(0000) knlGS:0000000000000000
[  275.277570][ T4335] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  275.278143][ T4335] CR2: 00007fa2f6c00000 CR3: 0000000134b04000 CR4: 00000000000406f0
[  275.278833][ T4335] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  275.279521][ T4335] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  275.280201][ T4335] Call Trace:
[  275.280499][ T4335]  <TASK>
[ 275.280751][ T4335] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447) 
[ 275.281087][ T4335] ? do_trap (arch/x86/kernel/traps.c:112 arch/x86/kernel/traps.c:153) 
[ 275.281463][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3)) 
[ 275.281884][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3)) 
[ 275.282300][ T4335] ? do_error_trap (arch/x86/kernel/traps.c:174) 
[ 275.282711][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3)) 
[ 275.283129][ T4335] ? handle_invalid_op (arch/x86/kernel/traps.c:212) 
[ 275.283561][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3)) 
[ 275.283990][ T4335] ? exc_invalid_op (arch/x86/kernel/traps.c:264) 
[ 275.284415][ T4335] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 275.284859][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3)) 
[ 275.285278][ T4335] try_grab_folio (mm/gup.c:148) 
[ 275.285684][ T4335] __get_user_pages (mm/gup.c:1297 (discriminator 1)) 
[ 275.286111][ T4335] ? __pfx___get_user_pages (mm/gup.c:1188) 
[ 275.286579][ T4335] ? __pfx_validate_chain (kernel/locking/lockdep.c:3825) 
[ 275.287034][ T4335] ? mark_lock (kernel/locking/lockdep.c:4656 (discriminator 1)) 
[ 275.287416][ T4335] __gup_longterm_locked (mm/gup.c:1509 mm/gup.c:2209) 
[ 275.288192][ T4335] ? __pfx___gup_longterm_locked (mm/gup.c:2204) 
[ 275.288697][ T4335] ? __pfx_lock_acquire (kernel/locking/lockdep.c:5722) 
[ 275.289135][ T4335] ? __pfx___might_resched (kernel/sched/core.c:10106) 
[ 275.289595][ T4335] pin_user_pages_remote (mm/gup.c:3350) 
[ 275.290041][ T4335] ? __pfx_pin_user_pages_remote (mm/gup.c:3350) 
[ 275.290545][ T4335] ? find_held_lock (kernel/locking/lockdep.c:5244 (discriminator 1)) 
[ 275.290961][ T4335] ? mm_access (kernel/fork.c:1573) 
[ 275.291353][ T4335] process_vm_rw_single_vec+0x142/0x360 
[ 275.291900][ T4335] ? __pfx_process_vm_rw_single_vec+0x10/0x10 
[ 275.292471][ T4335] ? mm_access (kernel/fork.c:1573) 
[ 275.292859][ T4335] process_vm_rw_core+0x272/0x4e0 
[ 275.293384][ T4335] ? hlock_class (arch/x86/include/asm/bitops.h:227 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/locking/lockdep.c:228) 
[ 275.293780][ T4335] ? __pfx_process_vm_rw_core+0x10/0x10 
[ 275.294350][ T4335] process_vm_rw (mm/process_vm_access.c:284) 
[ 275.294748][ T4335] ? __pfx_process_vm_rw (mm/process_vm_access.c:259) 
[ 275.295197][ T4335] ? __task_pid_nr_ns (include/linux/rcupdate.h:306 (discriminator 1) include/linux/rcupdate.h:780 (discriminator 1) kernel/pid.c:504 (discriminator 1)) 
[ 275.295634][ T4335] __x64_sys_process_vm_readv (mm/process_vm_access.c:291) 
[ 275.296139][ T4335] ? syscall_enter_from_user_mode (kernel/entry/common.c:94 kernel/entry/common.c:112) 
[ 275.296642][ T4335] do_syscall_64 (arch/x86/entry/common.c:51 (discriminator 1) arch/x86/entry/common.c:82 (discriminator 1)) 
[ 275.297032][ T4335] ? __task_pid_nr_ns (include/linux/rcupdate.h:306 (discriminator 1) include/linux/rcupdate.h:780 (discriminator 1) kernel/pid.c:504 (discriminator 1)) 
[ 275.297470][ T4335] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4300 kernel/locking/lockdep.c:4359) 
[ 275.297988][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97) 
[ 275.298389][ T4335] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4300 kernel/locking/lockdep.c:4359) 
[ 275.298906][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97) 
[ 275.299304][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97) 
[ 275.299703][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97) 
[ 275.300115][ T4335] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[  275.300622][ T4335] RIP: 0033:0x7fa2f9c65719
[ 275.301011][ T4335] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
All code
========
   0:	08 89 e8 5b 5d c3    	or     %cl,-0x3ca2a418(%rcx)
   6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   d:	00 00 00 
  10:	90                   	nop
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06f1
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06c7
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240531/202405311534.86cd4043-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



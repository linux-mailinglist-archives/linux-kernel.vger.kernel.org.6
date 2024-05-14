Return-Path: <linux-kernel+bounces-178843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5481F8C588D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2701F22579
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19F517EB8F;
	Tue, 14 May 2024 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ez3xfyVM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5694C1448C3
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715699713; cv=fail; b=bJjQC5UFNo0y5HS8dkpROKfsMj4Clb9qFl6MiNTOopYFyUFI/0xNsKR9dKlQQ+S7pdhsQphOHazQgqdR/zI/4UXU4W+hDM0AHEeEdQTyyAnfVfKamO6JsfNviaMFYoP7owFPkxnGc768wQ/eW99FK/nWqW2jaqAIgcgqAS9O9Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715699713; c=relaxed/simple;
	bh=6y5OdKx5KqFq6FjCpzTR/NLc5t4X5gRfrCkpdOyq1Xs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aPI5rhYXzeoJpEU77hl0lSnhVOfUagxjB7KqT+EbhN/F6UrdtcfyOMPT15AaxCXYLRiZyJyVblY2DsIh3svxPuvaGZTc21/781CJdCeeFD6bzneOo6CTJrDcn0DTP7VoLXafju8PKL7O2cwoeK2Nd0o6ldyCfd6MnoWIusMCaMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ez3xfyVM; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715699712; x=1747235712;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6y5OdKx5KqFq6FjCpzTR/NLc5t4X5gRfrCkpdOyq1Xs=;
  b=ez3xfyVMJ81/AZRt59Oe3Cj6BLiBNUKAR75w/BEmPzcG95/ZkGl8L9jd
   bw0JUK6ix0t7WNaPGFxEhri0vDmD+7sHT1FScLXTniTJjUekMjmBXThmi
   5nHhXo+DThw0z4lliQDjNX97qeK2akZqjZMT16Dn2+W5uXu116Sn+EHyL
   JrLhl543kP6poQ0qMyF/twtbn+m88wHmVUTVEs9zQBR9DxCJryHS0XPf+
   cSj4xIO96Hd0sGQxthasliljue27/3/oaD8QoOYmk7eGMixz4qTtQZie8
   xHBx35oGkO7RbvB1lk/cXqTFm4YeaMr+gtA+3WmFMsDcAhRjWAKnSkNSS
   g==;
X-CSE-ConnectionGUID: QdZU6qc8SxiSJP7brKYXPw==
X-CSE-MsgGUID: ONmNnD9hQ3K2Z/zLFdXEKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="22290508"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="22290508"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 08:15:12 -0700
X-CSE-ConnectionGUID: iyrEtydwSr2rsysGSH5E2g==
X-CSE-MsgGUID: J30Tv6BaSPqdV5GYva7aXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="35482588"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 08:15:11 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 08:15:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 08:15:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 08:15:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHxdz9xe7ddmNoufY2w0YIms2WEVHGO3y+WYmfZH2Xu601kU2NQ7j8b+Efb6v/q76QGtlZAWsXyayrzlCdVKMyQ9sL47YzpHFrq//hgYL5nIQDIvfnRK3FZL3hOm0jxMAUi7joCmeP9v6ToBtAGLuyGFDEqCHQOCdeARuldFgh8xswrGxDieAzWCnaqMjC/+TmromxP5RY7w2nkh7vx4UILdyilNvxyd0Of7UJSoTUDwNhZRG/sQLNpW2Xw7zKAqGr/31VxJcmDuN/96Qu7C4sNu/lGqPep2nvpf1w5QXmbZdQEHMQfo3VAMAyagn40KALldfG0ciblX8/glqIAChw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iFd1n63bTI1PDudqYCD541IEWfUYClnH7H8x11UfNY=;
 b=eQ7dVw/ckxxE411cOQN6aFfU8BdNmUyH5GG1Hq0JICqYjnbvpox8fkJIBulTDhhQph1UunEuVl55zJqj8bU2ctgIWfSLzQsNQcFSIDuyb8o3OObvfNZe9tLMlrZolfrHOFlBVpdP6SXkNAnSpxgwSnv2AduFsJsgnz0weH5tmO3TK7XAQa16r2j0qf6DYh6XICXvRnNcl5CqdWRTeuZR+U1jdDSO4asNcgdNWRJJPsOHi3g5Mfa8Fc3lRCH5wJj/EOu7HjzWCf/QbMVeuOLQLvE6fpxCqObYTIPoMN6YDXc3CP7RPqh7jEQXdApFZHjpT3F7/n+49fDYEqc/j33Wfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 IA1PR11MB6244.namprd11.prod.outlook.com (2603:10b6:208:3e6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Tue, 14 May 2024 15:15:06 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 15:15:06 +0000
Date: Tue, 14 May 2024 23:14:53 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
CC: Swapnil Sapkal <swapnil.sapkal@amd.com>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <peterz@infradead.org>, <torvalds@linux-foundation.org>,
	<juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
	<mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
	<vincent.guittot@linaro.org>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>
Subject: Re: [RESEND][PATCH v3 1/1] sched: Report the different kinds of
 imbalances in /proc/schedstat
Message-ID: <ZkN/7Wo4qVRmFQBU@chenyu5-mobl2>
References: <20240514044445.1409976-1-swapnil.sapkal@amd.com>
 <20240514044445.1409976-2-swapnil.sapkal@amd.com>
 <ZkNHshuGhY6nBGmJ@chenyu5-mobl2>
 <e942abce-97ec-4bf1-8220-55bfed18c265@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e942abce-97ec-4bf1-8220-55bfed18c265@linux.ibm.com>
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|IA1PR11MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9f381f-cf93-4818-a7ce-08dc7428a33a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gtbZgAo+RcOfLSgl36IsFakPhC3BNvnt/g5H3zn5A6oQBGME5wLkozRTkSPk?=
 =?us-ascii?Q?iWz374kW0eRg6sEQYRfwkTobsR9z79hNz0KVTwlHrClnQTDYPiYfTPh9PvLm?=
 =?us-ascii?Q?DAFXFutIUGaGt2egwil39rzweMUNwATlcY8uFsFh2YT18/hkd0Qszynh+0UM?=
 =?us-ascii?Q?IA37/RR/O0Ms9lRmvWqGH3+V1+CGJ8FkrSUzoo2ORStw8JhRlaaDzkr9+bXw?=
 =?us-ascii?Q?4+pbxCgRJI+hiJvugWqV2KDVqaHdV59Oa4HSuZUD3BQzUUYH+tQuT9sGEo4s?=
 =?us-ascii?Q?Y9G6Q1RyRCtiM+O4NY4pzrCSqJqyNhNi4WHhnynO9OdBakPHlWFTHZBR8+sM?=
 =?us-ascii?Q?2If53vuPNAqKf+0/JgAnILj21mHbBB46Had4eI+ab8xb2FuA7/CLtAumUJAI?=
 =?us-ascii?Q?xf3mpO7Kl6D183iEJUiM81tMz/iMfTPtT5obTCoiEWfiLUTYQsj9EAjMPmay?=
 =?us-ascii?Q?22oMd/O3vtQjXgUhv2Y7EreOrlCAOekOn5E1TQA5kWK7KlL0NHLVqJhvoC6q?=
 =?us-ascii?Q?O9e831zTXUOzPJl1HTJWXQ7S3r8Zk2vFUKRE4VIaXzQJAz/5ahhhJnaQmU+4?=
 =?us-ascii?Q?aAjuEMBRX8pwj6ZSqZFnOLdZa7mSuFYwOkFwOB09JoorlMNAWhAGImwBFFwW?=
 =?us-ascii?Q?n/tzsCc5uKNkoYBiJVCVpqb9vhE4Ze9POHeiGxx48SHYJ+s9hzNpAGwERWKO?=
 =?us-ascii?Q?qvUNNcf+LeZODNtdWR0qNconUGv1Vi6O3d6t3vZBgwTVFsErhVxuQpexdwEf?=
 =?us-ascii?Q?ok+WQAIFzIIaciBJezxQ2I1/t3Vgji6p78Omx8xqGKJr2vUdjRz+xTdhfJDW?=
 =?us-ascii?Q?CKdo6uXRRHPbmk3IZiXN8wMMULTgPoh/9ccmzDKS2KATSgIWki55kweUqcwW?=
 =?us-ascii?Q?jYl25vkXeLEN04BncTwtrYZ8LEowCn+Bp0ktFl3UE5/DT3kfs/xRbh2fvRia?=
 =?us-ascii?Q?aP11GsmljRMcvpRxnmxivdAHmdXez5MR3sQCv9V0D02a+ul5m1G6lCDvPPUl?=
 =?us-ascii?Q?r3xhSw6IPuGc5TyiJKaMzq3ciJaPUYMxFNwwGS95pUutCOEBK5fub/2uXanE?=
 =?us-ascii?Q?DWDEBzma3bUmSHLj5fppLVm83CmhP5PxmDwF41ryt1GUdfLpiL+sYYzgOe+m?=
 =?us-ascii?Q?/2anuNwM4Tzqf/NGHBETAaa8iKs9vMdlMrOZUSIFOD8AIhNiIB4xesVWpch2?=
 =?us-ascii?Q?2+f+go3bb1VxpTswpZLf5A4UY6QcFLpBj2jLNGknVbbTeh0tYtfJMuwVuvBu?=
 =?us-ascii?Q?CiBrScQkMC6EKgX5HlQUbFVAKI1Q0Gv6LayevDsoXg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DIS/iKzdyWAG0tQBnMwFRBjfvwujoAbSYMj3qLPKMvOY14WM1MobSAmJ/NnF?=
 =?us-ascii?Q?cn4SGVBo6nqiRDsN7KWh/IQNgzGgAmTZKBPLQt20sFP8HIPr2igK4g9SSND3?=
 =?us-ascii?Q?40/ruLa8weIdk35WUOGJn8KayjlK0mbnE8TjeU7MIQjvnFk4Qxzg2Gaa3YHk?=
 =?us-ascii?Q?33TczrynmlUxIZ0KPIb/8yXD+a6uIbLYISoncNmEaSK6gUzEULpwKTbAuMgG?=
 =?us-ascii?Q?eXMNo2mCQ9PYPmy4y24AliwI6b5nyxvXKG/g4AY8WtEcax+3ILeZLDcW+pVp?=
 =?us-ascii?Q?RgUMzWB/mAtcPhBXK6lQZfRI2/zdYZyPG9tcYZ9+6fU32klG7X31/z02m2e3?=
 =?us-ascii?Q?rtW2Y5LfJ+2Ipz+RtAWYKFtC1qHivWYIpxqA+SkCY7kgG/aqyd3/GTCJm8Jf?=
 =?us-ascii?Q?y0TfXjQdhG/fBBhlOh3FEUw45PRktsox5ErrLj1kaZ3g8mN0/gOsPvUMcxUl?=
 =?us-ascii?Q?3mWJjgNl32I0fwLkzn92+oqmJAjj3YhQGWNQCIDWUVUyqb7epBEzC1tWy3KR?=
 =?us-ascii?Q?KOyA7WwBcU9ONo/cZCnncZ1lMyhfrpjVOcUG2GMwMFZh+u9fOfC/q6dG/dVK?=
 =?us-ascii?Q?OF2eR112RT4w7F1U4h5wpVIvcJ9cu+34qJnWKTciYGmmFe/rEhYOuu4xiRkd?=
 =?us-ascii?Q?wK4oAlJTkokPX1cCiCSf2OdX0T3b/zIS46PasG2kiFLl+9H1ApnzkXNjcc0i?=
 =?us-ascii?Q?syH1XWYk3EafANYTssZL6LlfjGGixFMmHrFXnNrmZycNOR3qAaIlDSqwiu14?=
 =?us-ascii?Q?ilAZ3tqO/aN3LWC6oSLPFrqRFaDqWjBwDHkpWJwEpmcK9Y/4HW7azJcCyhNq?=
 =?us-ascii?Q?E/AllOb71GLUz6xdQJd21RAo2lVv0V0pZEeTTWoR3GZFBiZngdBCfgAWgWZr?=
 =?us-ascii?Q?hul2a3/f1NIP15eV5Jk0JV7fgrANRe9aNun1AfiBqYu1NZAps680AhrLM26+?=
 =?us-ascii?Q?O5VjT+BFMJMCkghzxtImYYuahCTVYB7gt6G/KNj4EVv9uxiD4ga1R1obVis+?=
 =?us-ascii?Q?Sa8iNxz365NrLN+Txkw/FfY5QB4Rw4J1AruwGRriyCZMfHfuklAeQOvK8t5o?=
 =?us-ascii?Q?ukX7p7edd1TSih1V/5bPl1fhOn2Znee+Ygz0NkA8eZf9sviKTJAI2vx7aG4I?=
 =?us-ascii?Q?LRqk583QanlL5RpkEDSccCQ+bYCVnyQdv3wBiSPakkz5k00SXKTQiXdoS8KT?=
 =?us-ascii?Q?MC0RSmk7gnArLzyIus2h0TiNL0I2RG2EJni2F9IN4MV/i/aerL/nTy1Zd8Kl?=
 =?us-ascii?Q?tKA7bZyR6/AOSDqBtFPflJVNP5bQ2D2DvODJWazXeD7H/qnePQcG+Zehtp7a?=
 =?us-ascii?Q?KY/T01b/OqnQvE1C84aDX/pSA7ZC5yqXCwsnT/tULw7TRXu/plxvd6Uiu4/d?=
 =?us-ascii?Q?KpdIXI5O4AJ4T1w6ecNhMlgCD8nejJLrx6Ck4hTw6o2nVkE9dHbAOoShI5w0?=
 =?us-ascii?Q?QvLj3MpDRCOUGKX6dfPGyvlK3ZaUMYBfywRVM1udcIUpnUZ9fQnhe5IwiydN?=
 =?us-ascii?Q?QGQXqeDDLatoHW5WsrBzBx2B8YrTErKKIam9PBVm3f0goAP4ZeDEewHDztln?=
 =?us-ascii?Q?s+qnNBpJVecyo4OM5vzIQtwrGWPHkmtX0cOdfK4r?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9f381f-cf93-4818-a7ce-08dc7428a33a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 15:15:06.7298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwRd3C9eUcgZXphmiIV2foFzfcim5lC/te688Rr1BULqU2xv8u5OhoB/cbOGjFZ7kAMc2QdV8kWC4id3FVK7Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6244
X-OriginatorOrg: intel.com

On 2024-05-14 at 19:53:58 +0530, Shrikanth Hegde wrote:
> 
> 
> On 5/14/24 4:44 PM, Chen Yu wrote:
> > On 2024-05-14 at 04:44:45 +0000, Swapnil Sapkal wrote:
> 
> It's been increased already as part of below commit 
> 
> commit 11b0bfa5d463b17cac5bf6b94fea4921713530c3
> Author: Ingo Molnar <mingo@kernel.org>
> Date:   Fri Mar 8 11:58:55 2024 +0100
> 
>     sched/debug: Increase SCHEDSTAT_VERSION to 16
>     
>     We changed the order of definitions within 'enum cpu_idle_type',
>     which changed the order of [CPU_MAX_IDLE_TYPES] columns in
>     show_schedstat().
> 
>

I see, so it has been increased due to commit 38d707c54df4, and current patch
is accomany with that.

thanks,
Chenyu 


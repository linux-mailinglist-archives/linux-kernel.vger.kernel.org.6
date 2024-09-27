Return-Path: <linux-kernel+bounces-341897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14929887EC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A640282107
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43171C1722;
	Fri, 27 Sep 2024 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWtlfIiv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164D5A2D;
	Fri, 27 Sep 2024 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449657; cv=fail; b=EXkojSR7mUE2Bq7Fs89TrxaqeRQaHPE4InQF2qMZIbbWNBu0SrD5HXYoP1tw4DqIgYbCctbX2LRmBGGgC1dlzg3J9r5KG4mtG34Zgrf4ovHjNvF/IOWC0FgZgwNAkK+22CAEEMTxlAov7WbOj6hmjjS5udet5FdOdWtXC/Bs2tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449657; c=relaxed/simple;
	bh=pwXL+6aPVXOfVbFVtIfOjhtPoTm3mCl/sjf2CRXk7cw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ls95OnobvfEW6t/lDW2kj2tBB9z8P1xLvK/6hFsRKQlqAqHWuT5KLjj99pxUIMo2OBF9Zmhie1nRuop4WARv/BZ/vW09SaN/7TK/9zXADXg0ENOOQ5Jyj7xjh4bKiqA1F8SNfO7KrlHwe8bSmP/QATiXiwWmlw/WRlMcHg4RA5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWtlfIiv; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727449656; x=1758985656;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pwXL+6aPVXOfVbFVtIfOjhtPoTm3mCl/sjf2CRXk7cw=;
  b=jWtlfIivyRzLy93FVO/l3U5fLsbicK6xNSPjiTvVGbKOf35/Gu+KZTZS
   7z8X4CJiv8sLnfFiFG3qYk+yJGis4Ts+kbV21qkKSbqKidADuImZ437IM
   MnYp+RQgTXgB+Q9cRsraXF65Q/Zi0Yv+CVwnyGN+/bCob/AKc4OtKANJO
   nmdNbslPgeakhj/sSP5R3ZDSLfr0KWw8LOH4rJ72u9RFnFj9cNLGjW6B5
   uGt+dJAPjKlSFAdaUkPaIi3UT6UkVw1bzJaMkaTBqHgHSEqwPb/5Ei2Zy
   rr3iMGq3GneAb4/gb+Ty53z+QvA/FlSN4l71UBWkqaWSmz6FKBL/WSr2z
   w==;
X-CSE-ConnectionGUID: cQrFZmD8SDanOrGFum0ucA==
X-CSE-MsgGUID: AgEHzMBKSi6+xmHGX+ykoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="37981177"
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="37981177"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 08:07:35 -0700
X-CSE-ConnectionGUID: mGxHsi9FQ8CsrSzxuBsBEw==
X-CSE-MsgGUID: +k0xloYbTYyQhvfxcbZPnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="77390989"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2024 08:07:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 08:07:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 08:07:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 27 Sep 2024 08:07:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Sep 2024 08:07:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZB/VxEbFh57Ey8d9LsvvWwM1kpl2fMI1HdqxK7C4QK1oKwMkRf3Md3VMlCwMfXmx6v4+yrGgttfXczsTMVyXmwEK/kr5YOJ8XlZskAWkhrK3Che8f2A09H0ANF/KNijNP+0xmUaSy9knol4W/bavTt7HRWTc/T4E4BfdliMeCKusTTk0aymlOo81MYSJxb4hUSSaq16S3HZuaMdCqX3rOtWsxzb6reTds9UxEcA0o4bNudiRV88ygRPUJ5cu+9CXFMaF/jpAebU24giZ5k2HOObrM3KBU+bh1sDoPBrlhkFOso3rOH9gkqYPkVK6hHbNo4vB+/PEZGRjSCXoHctPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwmoL++wopb2MGTMp6pjGEcKjGpx1dkVNfVEjBpB2bU=;
 b=MAXgj3+Xi6CsCX8VwNx25253OqRL6oP0k/quzwqvJ32/8/KHZF85ZJukK2DmcW9uZRjYnyt9o+y0ClguMHCt8HROrXdL43JNxliRbrZLQsMOtYIU3utEfqmIcbtgN2AEmiScIm1T1ZuTydCcjVtPRMYAXAhgUVhYD8iDNJjc2IXesSmGZdIm371cA1bVJLoGLtGULH6u0zgTIAsS+1XT0W5JFDWAB/uTym2NBQFU+vwFbK8d7svONotHJ1DF+t7geKzUBHZz4tv0X8T/KuKebAx/us/CmY33alAmIbp232jPt0sD56ra7u5pvzR0PhKd3YWYElvhFVVCFX1z0qm9RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB7302.namprd11.prod.outlook.com (2603:10b6:8:109::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 15:07:29 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8005.020; Fri, 27 Sep 2024
 15:07:29 +0000
Message-ID: <b38c93bf-4650-45d1-9aca-8b4c4d425886@intel.com>
Date: Fri, 27 Sep 2024 08:07:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 20/24] x86/resctrl: Introduce the interface to switch
 between monitor modes
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1725488488.git.babu.moger@amd.com>
 <812a04c41c66824a212c2dbd30697fe0cad71523.1725488488.git.babu.moger@amd.com>
 <b84fee44-d52b-45c3-8664-b2215074bea9@intel.com>
 <773d02ba-64d0-4c03-968e-f303ffefc4dd@amd.com>
 <0812e4ff-d8d9-4356-bf20-7d20170e9813@intel.com>
 <6df77680-6541-3d77-0680-1d67abdae0c7@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <6df77680-6541-3d77-0680-1d67abdae0c7@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:303:8c::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b8d689-8989-4d60-6d8c-08dcdf061ab8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDNlNFFxbDUrMXdpaSs1WFlWOU5zd245azM5QmQvRElkUytUa2ErL0QzUUVY?=
 =?utf-8?B?cjNaSjF3SkJSTlVEZjFoZFZGZkNweG9oYlZKeWJnNElTLzBBeWgxaVFiL0s4?=
 =?utf-8?B?dnFnd2FNR01kb0x5aTJZcG5lOThhZ0FnVHo5dnF2UWhBVklLanJ2anF6dHF6?=
 =?utf-8?B?YVFiOHQyeFJoME81Q25ENlh3TEErbTRsMzdZamdKUkxkaDBac1dzdUdMYmZ6?=
 =?utf-8?B?Tmw0bUJWUXo1RTMwVkdNRWx6L2EzZFY0aUI5cWVaVXB5RVF1VFBBQVp1OVFZ?=
 =?utf-8?B?Y0lZR2xhU1V6bzdXb2pYY1VpOEkzM24rbmRzbVlyenU0T0UyUzNFTm90emtj?=
 =?utf-8?B?cktGOHJ4SDZ4WGRhMWJ1cjdsSXNNVzhwa1FBSWRhL3IrUzlsNTJLMHVWOEcw?=
 =?utf-8?B?anBzanNxNXRuZ1lnQ2w3Vk9vdVpuSmZ2dkhSSXVRcEFhSmc2ZmdYRFVrYTFu?=
 =?utf-8?B?ZHdpMHBvZnlXa1JVeFZaSXhpbkZTcWQwbzNxZFp1OGhQeitvaTVPRVQ3amJq?=
 =?utf-8?B?dkZEUFNKQU5VK2Z0Y0YyRjhUY2luNE1JNVJ5Y0V0dFNXTmtIcmY1WThtK0hT?=
 =?utf-8?B?czBsSkxUODZIL1Z5bURIODZ5RWovVjVHVkVyb2F2WFcxZWsxQ2hFaWd2dXdh?=
 =?utf-8?B?RUtRaTA5Q2w3U0plWkV2QU52L3RCR1E5TzJrOU5TNlkrMEFIcitPWHRlQVFZ?=
 =?utf-8?B?aDVOVURHWGJKOUVUVzFBS3FhUVcvVnFsZFpnUFFQK01ULzhpbmFZOFdDNzg5?=
 =?utf-8?B?SUI3N1N5NVVRMElJRTRiS0dUdEx2dFBWbFdMeUZ4a1ZYMGgybVJkQUF5SDJV?=
 =?utf-8?B?em0zZzJDWkF3eS9OcVdSeFR6Rzl2TCtVVVVUTlFUTEViRmJ1TTQxZlpuVG91?=
 =?utf-8?B?UklLd3NRNTBBT1lJM1FzQ0hkMHo1S2EzY1dwRE5RVHJEekl6aHYvMUt1U3lp?=
 =?utf-8?B?cVJGWFlKR0tvYlJNUUQwSjdSQzFVeSt2eC9qRkNMdEowWUR5UFM5RXRoTE9s?=
 =?utf-8?B?OUFWQ2wxLzJwc0Jrem5ic1hJekFKcG1PLzE0bEgxS3pwMWpNbkpQRTVsVm9P?=
 =?utf-8?B?dVpLOUpTWTRjNnpOSmRhblVVTUdUN3dqMk5CU05IUkVWU1Frb2ptZWZtR0ww?=
 =?utf-8?B?ajc3eGUwZ21qMWUzUDZTSjFXRjNySFdjRzNsQWNwNTZOUW1wYXJGRytTczVV?=
 =?utf-8?B?SUdUdm4ralVkajhLOTRkM2Q0ZEJLanhZU0dPOUtvS2prUnQ1WTczMGkrWUpi?=
 =?utf-8?B?d01tS0ZkeDVKb0E5aGt2cnFDKytSMWJMZmVDUVJURzk2Nkc1Vmo3T1kvK0FG?=
 =?utf-8?B?am5IUnA3aVgvTjNJSk95dytMMUtIYmZNRW53NDQzWUhPcFA2MWJXc3ZjSDd3?=
 =?utf-8?B?YjA0blhXTjFuY081WjZWbW9aQUtEWkhpbzhOZHg0NitHMU94dlJlT3ZaRWZy?=
 =?utf-8?B?QVNScmxoV3owdHZ4YmphNVVTejhHb3BGekdxdWhCak1nTVJrcFM4UVNhRWJF?=
 =?utf-8?B?dnNMWEh6bk54bnhuVUVDUG1rMnZUYnMxUnMrUUpqWTlWZGJTME03Zmg5UU5j?=
 =?utf-8?B?bEFqaDZsSUNxWjdKWTFhRlMzWXJHUHIzZDY4QVJiandRZnJuYTlJT0JrSXln?=
 =?utf-8?B?MWswcGJIZ09oTU51b0NXeWFoUG1RMXR4WllHTHA1NDRmeGI1NURkWkJtaXVq?=
 =?utf-8?B?OU9xV0tUL0V0a291TGF5UlcyWVJZMGpQR003dGFoclZxYm9sUDgvdGpRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXYzYTZ6UmVrSllhT0UwYzFKaENkWkpEalRSOExxL0g3R25IVnNhdVJDSW52?=
 =?utf-8?B?TG1EMytQd1ZocnhTR2JxeXpyK2ExcmZ6cHRpQmdUV0xWYnk0S0RCaTZpTkt0?=
 =?utf-8?B?OHc4amFocTBGdno5eTJKTHQ1N3UrelZFWWRENzkrbmp4YzNaajlHR3RQanFj?=
 =?utf-8?B?UTdreFUyaVZtQUFWa1Rxa3lSS2VjUllydmloL1B6KzJOOEJnU3RsS2NFZVgy?=
 =?utf-8?B?bTJ1Q2w4VklJL2ovRG02TER0a1ZEenBkUCtSbWVtazhpbjNVMVJaaExiTnVX?=
 =?utf-8?B?TERKNXh0b2xsa2RuSEw0Ync2bi84M3V5cWZNdFpMMHNURjhXSW5aRzRuTDVE?=
 =?utf-8?B?ciswc01TQ2pKNVErcDh1NS85Mnl6dTgrNGhxVHdhbTJaemdndThucVkrazQr?=
 =?utf-8?B?TFRrM2dqa3FwRlZPL3BCN0ExWDJPZVNLaUdQRjdIT2pzSm5aK2JYektrOWlk?=
 =?utf-8?B?cm0yQW92eXh6Y2pMSk1qanpFeGlIbXZXSTB4MjdaaXE4OUEzSyt5bDhzdVJS?=
 =?utf-8?B?WHp3WVBOUzdQVVNLTTZtL0NLd0tUWlByYjZFWmNwVjhNeDZqaCt5VzV5c1hE?=
 =?utf-8?B?Y3NjemtJRk5TUWNhNUpzaDRUU0RsUkVlT3VtYnFBVlZ0Q0dUYTV6UkI4WUNq?=
 =?utf-8?B?RGo0V25CVTZEYlcwWVRFL2M4TW9JOEVRbk5WRnJRd0loaU14cVFWcms1RzlH?=
 =?utf-8?B?aUN1OFgwNEovd1owYmZkcWNwZ2FjOFltSTZOQkd0ampRV3dSd2FQMjI1VEln?=
 =?utf-8?B?emlrQkJhSkYrcXFvanVkS2l3SS81NzZBODkySVJZWEtFTWVvVE1ydXVVejMw?=
 =?utf-8?B?a1ZFdHMxQ1dmSHk4L2F5em1zMDNaREJWN3dsRjZUYWVrQjdnWDlJMnVXOCsr?=
 =?utf-8?B?VHJHTzFWeDNjT2FqSU9hNTZlMTVjRlFrSm1SOUZMelh0eFE5Ri9Kejc0WGEw?=
 =?utf-8?B?aTVhZ1BEalVaTENXeXpKSGU4YjVmQmltK1hkRGdtaHRFMktGc1RJMVA5MFEw?=
 =?utf-8?B?U0RKSW04em5OQzNsc3lEWktMVjErOHZ2UnJWN2VMOWdadHNlYzBYdHlRQ1BW?=
 =?utf-8?B?Z0srdVAyVlBWWGFyaFI5dS9JbjNKdzlieHlQVlExRWJlWEJKenVTNXdtc3Zn?=
 =?utf-8?B?NGptUHhCSUptQWlJYmhiOWRCRGw3T2FtVmEzZmVoRjNuTXZyYVJvWDNQdEtn?=
 =?utf-8?B?aExReHVuM2FwQ1RIcDVDQTF1cGRZM2NTd3FGUkltMnovN3pXcVdBbjdzRWZ4?=
 =?utf-8?B?c1hkME55ajFsMU9wZDZKaTBrcExZMlgrNFcybG9UTVdVQWYxdks1MEZROGFl?=
 =?utf-8?B?RWtiSkllLzFJRDBneUFHZ0R2aU1lMzh3Uzd2My9ZSEVZTHBqeVZuVHp0VDR2?=
 =?utf-8?B?WkdDcWFrZWM5Rkw5QWlYWW9pUThMeW1PZy91dVdtNjd3dnlTSDJOMWFkT1NH?=
 =?utf-8?B?b241UWJFdVlxcUJMWURmZjFEaWp5SzJiRlBIOVJ0SngrL1VnaDBSNlJiV1BB?=
 =?utf-8?B?dEpEQjRqWnlCQmRadHRxMm8rY3VKR0psN2dnUGtmOCtoZ2cwa0Y3SmxwcDVJ?=
 =?utf-8?B?ZnJySDdlcGFSSHQ4SXhPZE9EdUo3bDVhUmdhc2M3c2xad1VScm15bHFnbGt1?=
 =?utf-8?B?MGxISXJ5Vm9leHlvVDJPQU54WCt4M2M5U3psU2FiclhPb3JEQlc5MG1pTXZC?=
 =?utf-8?B?VUtJTmxDWm94eDBqVHFHbWFpbTRMdUVXQksxeFc0U3pwK1FrOUNmQ0RkeHJV?=
 =?utf-8?B?Z2tnaHhoeTY5RkVpVGNtN2xWWEdYQ3JBYkM4OGh0MGIvUmtsK2FpRmppbkFr?=
 =?utf-8?B?Umk5ckFNSzYvODdLOFlsdDR3ZUVCT2cxODFXZmdFZGtmVE5zQmlSb1dlalg5?=
 =?utf-8?B?UUQ0V2U0ejE1c0s0RHFQeVhPVmtBZk1Dcm50ejQwcGZCcUhWNS9rbUU3VHR2?=
 =?utf-8?B?a3F4d3hoMlJUVG1DSzRMNkF1OE1aRG9kdTdoWE9NV2xpVFVTdExFN0pkcWk4?=
 =?utf-8?B?dGVvLzhKNWFqRnNtUXplN1FsZ3ZyaXpYTC82N00va0JjdFZxc3hiRWJpRUZh?=
 =?utf-8?B?MmZCVENTZUQ4dTlMTFdrOXN4UnA1RzhlT3lMOXMxUXBLV2x0bEcwV1lDK2tZ?=
 =?utf-8?B?RXpjMVRyOEZWZVhPWGh3TTQrS2FkeUk0SlM1T1B1eUp3OFhXV3lUb3NaQld2?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b8d689-8989-4d60-6d8c-08dcdf061ab8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 15:07:29.2071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaPCGzCVwlGhBntwL9Q6g5KdNmSI9D2O46m0lNrGjKRnoF/7AJxpE8e/kHBQzvkq1OgV5eGZuk+9oJtddH9F5ENXRbhJpWdFw0CuVF+Hzq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7302
X-OriginatorOrg: intel.com

Hi Babu,

On 9/27/24 6:26 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 9/26/2024 8:51 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 9/26/24 12:39 PM, Moger, Babu wrote:
>>> On 9/19/24 12:38, Reinette Chatre wrote:
>>>> On 9/4/24 3:21 PM, Babu Moger wrote:
>>
>>>>> +      ::
>>>>> +
>>>>> +        # echo  "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>>>> +
>>>>> +    The MBM event counters will reset when mbm_assign_mode is changed. Moving to
>>>>
>>>> "will reset" -> "may reset"? Please also be clear on what is meant with "MBM event counter".
>>>
>>> It "will reset".
>>>
>>
>> I understand that this is true for the ABMC implementation. My goal with making this vague is
>> to not have this reset set in stone if some other implementation behaves differently.
> 
> ok.
>>
>>>> Note that "counter" has a very specific meaning in this work and after considering that
>>>> it is not clear if "MBM event counter will reset" means that the counters are no longer
>>>> assigned or if it means that the counts associated with events will be reset.
>>>
>>> How about
>>>
>>> "The MBM event counters(mbm_total_bytes and mbm_local_bytes) associated
>>> with the event will reset when mbm_assign_mode is changed."
>>
>> In the docs "mbm_total_bytes" and "mbm_local_bytes" are termed "events" ... maybe
>> "The MBM events (mbm_total_bytes and/or mbm_local_bytes) associated
>> counters may reset when mbm_assign_mode is changed."?
> 
> Sure.
> 

Please do not just copy the text because I made a mistake with the grammar.
"The MBM events (mbm_total_bytes and/or mbm_local_bytes) associated with
counters may reset when mbm_assign_mode is changed."?

Reinette


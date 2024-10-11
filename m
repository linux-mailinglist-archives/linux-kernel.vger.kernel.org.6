Return-Path: <linux-kernel+bounces-360562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA13999CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A64B21EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9152219D89E;
	Fri, 11 Oct 2024 06:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwvatbaz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8F111187
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728628281; cv=fail; b=UxyyPG6DJGewsGyYne+IJjEHPUxdL8zGw76+mDvhKqvld9UlC+SNKyzCiMs3ctChmYKtx5CrpgZKz0fQ/6YsMLbVwdhfBIlcQvrcKqxdl52qyteRLhnBWmOpkeapAb6cN/Neg9fVrI6+nQNdhuy4Gtrr5qUpLxi6tfWuN730QYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728628281; c=relaxed/simple;
	bh=C65KLxty8IYX3zo78d3/0Tymf5OmDpNT/gdr1XbalKU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=iW9qX/Now3s/sq3Uon/6rGXYlvyMaGdpP4lzXzf8WQPQBD+v5Z3jZVs4NW2xw6iRa+cnqrgPCOlcpe2Y8nozmWfhwayj9IwhI1oN6V8FWStKbVeU3DXnMMssY1wNjH1M59XhL+y4EZChQKsLv1b7c1pF6/ZJ4zx5OORv73FtGAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwvatbaz; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728628280; x=1760164280;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C65KLxty8IYX3zo78d3/0Tymf5OmDpNT/gdr1XbalKU=;
  b=gwvatbazwfAyv9cgL+PUV1w3t1nippbjWxC5ZIB+xDhZ8QvkGa33iKxl
   A5aQ3pMWIufE8Sm9V/GwYdI6pXCgxyK/Sq3zKCT6jrI+V3O8ITbgRmqpH
   /XseMfkqYdpkkQ1a+/nCXhxfcFYDZGVUVJ0evHO6iTpwWeLUQWZATYN5y
   mtJ/cScYjd/kRvFHbS2otenT2p3kBsyvXAR4vTMCiB5Y2Ws2TF4Yo/Z54
   U12+arei0xk8CSsS9/jxEOMTdnOyiv48zeN4F+KezZaHCLQZ8bwT/sDcQ
   Vli7+Y8KH+rnE1Evl2tDiWy3JFH9gVTHq4oe15sRWlYCPlskmihXK9krF
   A==;
X-CSE-ConnectionGUID: hWxsifCvTbeWJolmTizELQ==
X-CSE-MsgGUID: a0BApuV0RIqVzC/P5+RCdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="39410460"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="39410460"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 23:31:17 -0700
X-CSE-ConnectionGUID: LBy5uQViQS2NsGoohF5fYg==
X-CSE-MsgGUID: WHPmZQpFTJGVT/R6q5NXHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="77297443"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2024 23:31:17 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 23:31:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 23:31:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 23:31:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 10 Oct 2024 23:31:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 23:31:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0hdqjx4o4bd+kDR29gDYf7IA0zepl6TIIbz8P2dw87nE1Kw15qdpJLlmQqImH/VhMtiVAJyBR237B6gGeiB3uvuTthS0tV/ocbpN9U8sA5NshJA45zuO8ptcITfsaXeT85vNuEIX2qr8vAnJpuP/VYX/Qe4p3Ekk9lZ2C2Ge4aL80BXY2kYu5KMTRdLtmZJKqdxbaclEWDQrTvJkguV2cEVGsnThueLfwSdR7Q9vQdA64HDY6/LNhQoqsepfDJkrk7n1zTshi6XfBoZqJIl4ftkk/crN3/Ih4TRSvThnF1IvQugsvBnrBUedvxt8py4346EGXRr5PF/PTQyiiipTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRbxErv9Pu70JQY7xI66rr++KqgS5KvGHPuoR7r80ZA=;
 b=Ix3sWbE8ae8LGBlsRGc7y9hLoT8ffldv/iFafT+MEz9mTbq3WC6YqM2Vc3TpYyZl2Vn1LAttwz9kx3P7nJZDBL1L27o6HWVh9C+Ha4htOKcpAg1QQgGCcmQOILDnbFlO67PrqiCf6XExAC+5cQBUC3dqcbtuqkBArtBfPi4qiNKBdgW1p9qstl7vuo9cj6gtEnaWH8z9u6UKRGK+/jYC0n6Ck6US752wzTLgM7dClt6ucJNS96dqGR53OSixLIMbhKbEODHULWo+SoVvZ3e11YOm57DOV+CNrF0ME036WE/a7o8xLN8bD7O2F4TxVQHicOl6Yv84A/2zdSJNhaNcZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN6PR11MB8218.namprd11.prod.outlook.com (2603:10b6:208:47c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 06:31:11 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 06:31:11 +0000
Date: Fri, 11 Oct 2024 14:30:50 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mike Rapoport <rppt@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "Andreas
 Larsson" <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, "Ard
 Biesheuvel" <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov
	<bp@alien8.de>, Brian Cain <bcain@quicinc.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	Christoph Hellwig <hch@infradead.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Dinh Nguyen <dinguyen@kernel.org>, "Geert
 Uytterhoeven" <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, "Helge
 Deller" <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, "John Paul
 Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, Kent Overstreet
	<kent.overstreet@linux.dev>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Matt Turner <mattst88@gmail.com>,
	"Max Filippov" <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
	"Michal Simek" <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>, "Richard
 Weinberger" <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Song Liu
	<song@kernel.org>, Stafford Horne <shorne@gmail.com>, Steven Rostedt
	<rostedt@goodmis.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [x86/module]  6661cae1aa:
 WARNING:at_arch/x86/mm/pat/set_memory.c:#__cpa_process_fault
Message-ID: <202410111408.8fe6f604-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGAP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::17)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN6PR11MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: d8724e88-fea8-4eba-9a50-08dce9be4c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a3eVb9IgwxFrvsiYLHm8aOM+76V/+zojYGpjxbZzTAaEeR0soAvJUqBMpNXB?=
 =?us-ascii?Q?ZnrjGfFm7UIK9+Ng2E9S1cjJN2aevKBnoc8EGJTY5kIt202M+zDGHsLPEUMf?=
 =?us-ascii?Q?2iY9vnKfNm0cxb6YZPhtCuFzDIEQqzHAlodLugeh7XrYRKy00zIfeiGDJm0d?=
 =?us-ascii?Q?EHF7xM1CW/fpTHxKpgYuZx1maYGC0a4AZDI9vBD/90obrGtomNQOzi61POeL?=
 =?us-ascii?Q?Y7C5VqkpK7lEqIU2yg+JX+qxGr+9LUd1xMQOGKIPoJBF8fJxetl2qXOB9P3m?=
 =?us-ascii?Q?d8u39205jcgyYgKnY8n3LufA0Ev7WQscCIW+I1/cTqbIf4ngCs8PPvpLo73j?=
 =?us-ascii?Q?D0PTQ7nJD8oC0Atx7gedetjQMQRLEkWTVmcSMyOO0z8kPabAcbF/d9NWXsbh?=
 =?us-ascii?Q?keJd4x+se63ngGMeaP8/MHFk8XxYhcSsxHSXzf8D3RsJN0n43zQY/abKJKiv?=
 =?us-ascii?Q?EyVOnkorcmtHOUKecoyL//yjXqLvqSJvO1tTm1iUbEBZS7I6HZtoRTNemEXd?=
 =?us-ascii?Q?Ib4BpyKy3M+6gezSmdUnxUijILwP0IB4l/xUfv0Loct0sVhbSnus9AW5Utsz?=
 =?us-ascii?Q?tWpsmEhNcOi2b+exMAbzu+uj8QybynrRQ+M5WXkLZIej/BmZGXORwfqZ00KB?=
 =?us-ascii?Q?X9FraOZkpuVK0tcLLEgr9E9hkCLvpRW/p1SmWkC0FlUiVZrTXlOu8rbt3VVD?=
 =?us-ascii?Q?hLOcbqzcGopSX8ZH8w9bpCznFqwM21fl4j+w90RDIn3TI/GwU5yiXYJvEoME?=
 =?us-ascii?Q?X/cSSv5FRkCaEeLgcHomAHG6JpxkFjYR9UEFwbvDfXkzHL+2LusiK2am8r63?=
 =?us-ascii?Q?L/4jfYG30ju+2yoJWDGGMoBiihMy8jjgpeWu1EJDnE5QIlnrP42e9b3JQ3YR?=
 =?us-ascii?Q?FWR33GG1N3xzKfw9K4/+cOhUZjJAPPNBkTJNU80Zl9DpOQv9/ddJA7p9MOmJ?=
 =?us-ascii?Q?QwkxjHkLaSeES7IUb81ZZRtmhO6UkMC5MnE+3PEDelntE3UJB4XeSaq0sGWO?=
 =?us-ascii?Q?mPr60+9gnuefPTGM4VLP9ag5t4U4QZEqISOSZsj8bJo0GJTdCSlmzpbD7LmZ?=
 =?us-ascii?Q?Z38I0rOEPB4jTx2nFkwZCeNCR/OBRhwHvwqGUzcNvDhzGlz1GHRcJwJFjHmv?=
 =?us-ascii?Q?xE2chJRVIRZI0YDEdY5ug+JWxCCAoONP6YMCNOA0G/UkybkDFuMCHBaiPxw5?=
 =?us-ascii?Q?UIhVJ2bndsjA4mc5uneU66kpjH/VEEJmBIxK5NS0F84RcrBABeOMwpyvuas?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yw+jDhZhT022Pn8Ue8T6VH3ohXsV+XHxHl6Y5FuuqhY+/TWGuJGGS4zhy8OD?=
 =?us-ascii?Q?VK96tzXHejhtXh05+et9F1IO4YbToeibiztZYIro4rA2JqAiZuJ6HhwPnplr?=
 =?us-ascii?Q?x1nLDv4OOMDfHG2bLQN7Ur1+bHcxCPV88K61tI+9XR/FOgXeby4yfyVacxTe?=
 =?us-ascii?Q?YJZ3mKy5NtJEY5geZFLWhWEW0y3X0a8eMnp7pWCLBHNr09HhQjrLkfzMaRhQ?=
 =?us-ascii?Q?+CoEZW/k/51W4oEgx3OT+72oaXqMaYhNb85OGq4dIO+9Qxa9JzIBQHf/omNt?=
 =?us-ascii?Q?5MUG/tQQQ4VteWeXX62Gj/qomISjFQJXguQImGS8N3c327hBzW3W06uZJo4u?=
 =?us-ascii?Q?/t4gxj/gjmYz1BG8+rQZPpVPTNwAnQtUAIGaVI+ycosM0Mp8SJhVvf0ZC8Iy?=
 =?us-ascii?Q?bQmP2CuM/IAyEmLvVxtAsmldJwl7zmML3hjb2pLf3/Rdt7/nz9MSSduxOe+W?=
 =?us-ascii?Q?EU52lWys2y6MoqvdZuCd2AQv/8hipXCy+IR7Zl5PXRVH3d3Z7dxBjfH26bkj?=
 =?us-ascii?Q?Hul+SX83YxCBZpRbmO9LZJaX0xe+9saLu0SwkZMHvHJjc59lypwO56PWQn6T?=
 =?us-ascii?Q?Mcb7PCqy546e0AQ5D9ta1NqZomW+gZkUYIOwW81YexF9K4eonxgqvl8smvN+?=
 =?us-ascii?Q?u6l6Na01+zMLrcv1rAnnE/5g3nlP6CVI4evSLmKlU+eEkwbY1O+E4k/NhrFx?=
 =?us-ascii?Q?W5s6xsFN6GUPZ44GPPT24UmzCC/vOCqM+Lm5zipdMfxS/eC5bz8hETy+DKEa?=
 =?us-ascii?Q?wpfsnW6xPDq+4Kd1q2mCMZVTUrwle9YXnPzRf/LdnDM3aBB0LcZsnz44NUlr?=
 =?us-ascii?Q?mW4AE7fYutfeL51aRgW4tvYJ6O82IBhDTaKVIGrSnGff8WWzYLuQRmCBrsOc?=
 =?us-ascii?Q?/uD4onmwc7ICdc44tQDrE+PmLI+QHiR/AL1t3gr+ycM8ynjoY2aJoJDngV2W?=
 =?us-ascii?Q?gWwRvsqyBUN5xGUrKZAG8UvGv98mKBt/MgHVyzF/nNPib3AZPHPqWQ3J4SZm?=
 =?us-ascii?Q?SGGnzI4XQERE7Ck6COKyifgo1FsVrhcfWTK30cFtqpdDAxTJrupuYq2dY6ud?=
 =?us-ascii?Q?kt0ge6q0IuUAnbTg7xX0HldFQWHea5xN8nFFPmMHeZEid5YRzitCEyXvpdP0?=
 =?us-ascii?Q?2hpe6kHW1ihQWwpFVaLbuJUTTFrTa/AXOgc88EVBVafaSUudNz9xcRlClgjH?=
 =?us-ascii?Q?a8BJ+vl6K8tvV4wcMikxx1Z1sL2IStvVgOzKCq7jOXBFaqyjxrMp0IItQylK?=
 =?us-ascii?Q?s5bAklWJjtTR/voq/BZxdwDOImPp9iExWek9V8lAWZRckWgvc+p/YyHjXKMX?=
 =?us-ascii?Q?G1G2TW++zlnX54mHHqakgpV9kf1k0D8W/Nrl+f92o4dUK1H/Xsf000i/bYYq?=
 =?us-ascii?Q?vupAxcKVGAWmc9uhMHl50zrmDvKBFTCmJPtgPJa+6mJ9rxlpdKgjdJr1mzVK?=
 =?us-ascii?Q?6GI3yYst/jUR6YKuZzDVQh+U9FqsWTm7FpaUPBhMInkZofNg3NZu1QD1iE+e?=
 =?us-ascii?Q?RzQJ7k1zyxVd6j3WiWydEtcI/Ga0CErd1xL/5qj3rACGKV/kjEV5hYbMSX4f?=
 =?us-ascii?Q?jXvcrFqHCn4u3KrGaLDwg9ZHw2rB5GWvMP4jYxnEoRc17d8qyg4lwXgvtisg?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8724e88-fea8-4eba-9a50-08dce9be4c2b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 06:31:11.3892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qb+tsxyiwsbs/SOm4NiTRLgJWDvZ8XcvpeTdDTtVBNVIwo7/hq9aJDzwEH2qKE/mtZsya8JK3GwQYd8BGqJURA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8218
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_arch/x86/mm/pat/set_memory.c:#__cpa_process_fault" on:

commit: 6661cae1aa66d826b7ecd7044d0d76c66c015266 ("x86/module: enable ROX caches for module text")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 0cca97bf23640ff68a6e8a74e9b6659fdc27f48c]

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------------+------------+------------+
|                                                              | d44c348582 | 6661cae1aa |
+--------------------------------------------------------------+------------+------------+
| WARNING:at_arch/x86/mm/pat/set_memory.c:#__cpa_process_fault | 0          | 6          |
| EIP:__cpa_process_fault                                      | 0          | 6          |
+--------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410111408.8fe6f604-lkp@intel.com


[    8.158938][   T98] ------------[ cut here ]------------
[    8.161035][   T98] CPA: called for zero pte. vaddr = 0 cpa->vaddr = 0
[ 8.163217][ T98] WARNING: CPU: 0 PID: 98 at arch/x86/mm/pat/set_memory.c:1620 __cpa_process_fault (arch/x86/mm/pat/set_memory.c:1620 arch/x86/mm/pat/set_memory.c:1583) 
[    8.166598][   T98] Modules linked in:
[    8.167997][   T98] CPU: 0 UID: 0 PID: 98 Comm: udevd Not tainted 6.12.0-rc2-00142-g6661cae1aa66 #1
[    8.170966][   T98] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 8.174383][ T98] EIP: __cpa_process_fault (arch/x86/mm/pat/set_memory.c:1620 arch/x86/mm/pat/set_memory.c:1583) 
[ 8.176288][ T98] Code: d8 51 89 f9 e8 39 fb ff ff 83 c4 0c 85 c0 0f 89 95 fe ff ff e9 60 fe ff ff 8b 03 ff 30 ff 75 e8 68 e0 05 ff c1 e8 7c a8 00 00 <0f> 0b c7 45 ec f2 ff ff ff 83 c4 0c e9 fb fc ff ff 8d 76 00 55 89
All code
========
   0:	d8 51 89             	fcoms  -0x77(%rcx)
   3:	f9                   	stc
   4:	e8 39 fb ff ff       	call   0xfffffffffffffb42
   9:	83 c4 0c             	add    $0xc,%esp
   c:	85 c0                	test   %eax,%eax
   e:	0f 89 95 fe ff ff    	jns    0xfffffffffffffea9
  14:	e9 60 fe ff ff       	jmp    0xfffffffffffffe79
  19:	8b 03                	mov    (%rbx),%eax
  1b:	ff 30                	push   (%rax)
  1d:	ff 75 e8             	push   -0x18(%rbp)
  20:	68 e0 05 ff c1       	push   $0xffffffffc1ff05e0
  25:	e8 7c a8 00 00       	call   0xa8a6
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	c7 45 ec f2 ff ff ff 	movl   $0xfffffff2,-0x14(%rbp)
  33:	83 c4 0c             	add    $0xc,%esp
  36:	e9 fb fc ff ff       	jmp    0xfffffffffffffd36
  3b:	8d 76 00             	lea    0x0(%rsi),%esi
  3e:	55                   	push   %rbp
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	c7 45 ec f2 ff ff ff 	movl   $0xfffffff2,-0x14(%rbp)
   9:	83 c4 0c             	add    $0xc,%esp
   c:	e9 fb fc ff ff       	jmp    0xfffffffffffffd0c
  11:	8d 76 00             	lea    0x0(%rsi),%esi
  14:	55                   	push   %rbp
  15:	89                   	.byte 0x89
[    8.182574][   T98] EAX: 00000032 EBX: edb81db0 ECX: 0000021d EDX: 00000000
[    8.185016][   T98] ESI: edb81d4a EDI: 00000000 EBP: edb81d30 ESP: edb81cf8
[    8.187433][   T98] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010202
[    8.190182][   T98] CR0: 80050033 CR2: b7c8e548 CR3: 2db88000 CR4: 00040690
[    8.192564][   T98] Call Trace:
[ 8.193877][ T98] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 8.195475][ T98] ? __cpa_process_fault (arch/x86/mm/pat/set_memory.c:1620 arch/x86/mm/pat/set_memory.c:1583) 
[ 8.197352][ T98] ? __warn (kernel/panic.c:748) 
[ 8.198883][ T98] ? __cpa_process_fault (arch/x86/mm/pat/set_memory.c:1620 arch/x86/mm/pat/set_memory.c:1583) 
[ 8.200760][ T98] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
[ 8.202456][ T98] ? __cpa_process_fault (arch/x86/mm/pat/set_memory.c:1620 arch/x86/mm/pat/set_memory.c:1583) 
[ 8.204259][ T98] ? exc_overflow (arch/x86/kernel/traps.c:301) 
[ 8.205893][ T98] ? handle_bug (arch/x86/kernel/traps.c:260) 
[ 8.207451][ T98] ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discriminator 1)) 
[ 8.209215][ T98] ? handle_exception (arch/x86/entry/entry_32.S:1047) 
[ 8.210933][ T98] ? exc_overflow (arch/x86/kernel/traps.c:301) 
[ 8.212585][ T98] ? __cpa_process_fault (arch/x86/mm/pat/set_memory.c:1620 arch/x86/mm/pat/set_memory.c:1583) 
[ 8.214504][ T98] ? exc_overflow (arch/x86/kernel/traps.c:301) 
[ 8.216170][ T98] ? __cpa_process_fault (arch/x86/mm/pat/set_memory.c:1620 arch/x86/mm/pat/set_memory.c:1583) 
[ 8.218077][ T98] ? __change_page_attr_set_clr (arch/x86/mm/pat/set_memory.c:1808) 
[ 8.220025][ T98] __change_page_attr (arch/x86/mm/pat/set_memory.c:1644) 
[ 8.221883][ T98] __change_page_attr_set_clr (arch/x86/mm/pat/set_memory.c:1808) 
[ 8.223837][ T98] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:63) 
[ 8.225669][ T98] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:97 arch/x86/include/asm/irqflags.h:155 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 8.227684][ T98] ? page_address (mm/highmem.c:778) 
[ 8.229415][ T98] set_direct_map_valid_noflush (arch/x86/mm/pat/set_memory.c:2453) 
[ 8.231211][ T98] execmem_set_direct_map_valid (mm/execmem.c:53) 
[ 8.233327][ T98] execmem_alloc (mm/execmem.c:263 mm/execmem.c:291 mm/execmem.c:335 mm/execmem.c:357) 
[ 8.234958][ T98] move_module (kernel/module/main.c:1220 kernel/module/main.c:2291) 
[ 8.236569][ T98] layout_and_allocate+0xe7/0x160 
[ 8.238634][ T98] load_module (kernel/module/main.c:2955) 
[ 8.240229][ T98] init_module_from_file (kernel/module/main.c:3262) 
[ 8.242074][ T98] idempotent_init_module (kernel/module/main.c:3196 kernel/module/main.c:3274) 
[ 8.243946][ T98] __ia32_sys_finit_module (include/linux/file.h:68 kernel/module/main.c:3301 kernel/module/main.c:3283 kernel/module/main.c:3283) 
[ 8.245807][ T98] ia32_sys_call (arch/x86/entry/syscall_32.c:44) 
[ 8.247342][ T98] do_int80_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:339) 
[ 8.249008][ T98] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[    8.250662][   T98] EIP: 0xb7dc0222
[ 8.252022][ T98] Code: 06 89 8a f0 02 00 00 c3 55 57 56 53 8b 6c 24 2c 8b 7c 24 28 8b 74 24 24 8b 54 24 20 8b 4c 24 1c 8b 5c 24 18 8b 44 24 14 cd 80 <5b> 5e 5f 5d 3d 01 f0 ff ff 0f 83 8f b5 f3 ff c3 66 90 66 90 66 90
All code
========
   0:	06                   	(bad)
   1:	89 8a f0 02 00 00    	mov    %ecx,0x2f0(%rdx)
   7:	c3                   	ret
   8:	55                   	push   %rbp
   9:	57                   	push   %rdi
   a:	56                   	push   %rsi
   b:	53                   	push   %rbx
   c:	8b 6c 24 2c          	mov    0x2c(%rsp),%ebp
  10:	8b 7c 24 28          	mov    0x28(%rsp),%edi
  14:	8b 74 24 24          	mov    0x24(%rsp),%esi
  18:	8b 54 24 20          	mov    0x20(%rsp),%edx
  1c:	8b 4c 24 1c          	mov    0x1c(%rsp),%ecx
  20:	8b 5c 24 18          	mov    0x18(%rsp),%ebx
  24:	8b 44 24 14          	mov    0x14(%rsp),%eax
  28:	cd 80                	int    $0x80
  2a:*	5b                   	pop    %rbx		<-- trapping instruction
  2b:	5e                   	pop    %rsi
  2c:	5f                   	pop    %rdi
  2d:	5d                   	pop    %rbp
  2e:	3d 01 f0 ff ff       	cmp    $0xfffff001,%eax
  33:	0f 83 8f b5 f3 ff    	jae    0xfffffffffff3b5c8
  39:	c3                   	ret
  3a:	66 90                	xchg   %ax,%ax
  3c:	66 90                	xchg   %ax,%ax
  3e:	66 90                	xchg   %ax,%ax

Code starting with the faulting instruction
===========================================
   0:	5b                   	pop    %rbx
   1:	5e                   	pop    %rsi
   2:	5f                   	pop    %rdi
   3:	5d                   	pop    %rbp
   4:	3d 01 f0 ff ff       	cmp    $0xfffff001,%eax
   9:	0f 83 8f b5 f3 ff    	jae    0xfffffffffff3b59e
   f:	c3                   	ret
  10:	66 90                	xchg   %ax,%ax
  12:	66 90                	xchg   %ax,%ax
  14:	66 90                	xchg   %ax,%ax


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241011/202410111408.8fe6f604-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



Return-Path: <linux-kernel+bounces-418094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F178C9D5D11
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838D71F21D04
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B971DDC2C;
	Fri, 22 Nov 2024 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KvX7qnXh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C910B67F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270326; cv=fail; b=t+9L9/LZfy7YQKoNK/+cAsPjOnpOZ5kVC3JDP+VIWPUY1FAwIPfyYywwUg8Tk+rk87M3dpvlJ76Zt0SpWZ/pNVMPJiv12l7gn5ipdMN1I88nZTNaj1fdq954PCrTPRu28qnO+A/3ZJ9u1n9LWMFpEjSXgfQtBzqeML/dtf/16pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270326; c=relaxed/simple;
	bh=jfZ3VWWAjbltPu5AlBtD7JfnMYMHqOet7ufDqA3EJMs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=YEYYFvPlNb0wedN/OoqEWCEObOsgzDs7DGAx6VxI66xvX4JCOPrgO/ILmAxZpyd+jx69+NpSaCrBd/qUTeIw4NooiQm6AEYwF6+4rjhN6HXacMZnwP0tj8cJ1/Qkhtls4oTEKkk1Tg6ZxRzEGE6yGMoxn3qWx8vCPSpkQLm9ASw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KvX7qnXh; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732270325; x=1763806325;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jfZ3VWWAjbltPu5AlBtD7JfnMYMHqOet7ufDqA3EJMs=;
  b=KvX7qnXhy4UWWS57S7be9or+HohbB/8YQH2Jns0xeBR+H0YOT/cnZGaF
   uKsryDVKue8Q3cxkqiPsxRHst8RsGzl1hlQnLp52/MCZbTk7fWQ9j/GJO
   wfYRui8tSOh5ECUHajjFYW+GQKVOWYS8TNB+LBWjwbQrV3KV8ryLRgdIJ
   WLPAiiHcUwJPNzv6P/NQ7gtGXPpTOWtJ841aSEzz5z+e1ZzOKo29ifTyl
   5QZqAQEjQb20IPtDiMtLh93u+a8dgOAwK/Le/Mqa94iQVU92u1gPOxR2K
   I9TrXCbVFY4l6+dEO3Ulbk1/Pl3rYsdDFfgSwbye6H4T6iiS7pNAL21lm
   g==;
X-CSE-ConnectionGUID: +LxlFlCsRDuydENkOGCjjQ==
X-CSE-MsgGUID: sE0ahcK7QVe0U7tFgD0pJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="43816875"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="43816875"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 02:12:04 -0800
X-CSE-ConnectionGUID: UyE+635pT2m5tvxP6AbZJg==
X-CSE-MsgGUID: WEe7ojIyTIKQcycFmq+hUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="90953277"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2024 02:12:05 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 22 Nov 2024 02:12:04 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 22 Nov 2024 02:12:04 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 02:12:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pd0WPaLkTZBo4lwFYx2NQ+SD7Z9kj7hyYKsT48BPop+OnzvC9qMLKGABQ15CI8B8rEKHiJV2uTdPHCX0/p8LS+VaJ+cu54t57GNQD98hEUeCDb0ig1OEHwrXUaX++fH1tODzp3vZUbrIEI4v1Z9PE4XKwbvqx0Wxv35xgQoNQcMW8Vd5f4pRmBtcpaJijbYuvWhMbU6dzly6oKtd0WevfizshT+V7xlvEMi/x7hJUr82d9qijFBf4CMdyvQgz5VCI3oK71jMPuhdjW7J3YtJamdfhAiLNig5oH/xYZXRPYj0A1AgUBBUcxkxQ+tWx/uODNFw52yc5pDp/7LNgzz+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAwL2pYbx44v0e6+c+pWUqUl+udSv1k+gQRQaxhttX8=;
 b=gvH2MD/4jujI8LnAOWHDtIpkLS1Z7zGr44xm2PYb+rAfnt4nQ8XOOXpsxz6s4rmp3Y+tv2eTiY5sDNYXYf80Mf15KCteb2PK0biBXnogf6kTMhtUV812vQ+ATj60DdKsb1pvlQg7PIqBl2SMGAJicyWP4ikr1rM/qR5IdepqdNymOCbecPwjLpF8hXxAuL8lNBu8esbj+zDx416r9UQ+KyHfY5w0D+7nlRjK3nB+UDkAyl+xeqzyQvw9D581UFxo4KFx//lkCNXEi953CoeKpWQMGyLm7nqwcqkX6DWp82UnHpDKQKU7U0aa4qCDrq/cJnM6MgRY1le0i9//bcHJxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB7176.namprd11.prod.outlook.com (2603:10b6:208:418::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 10:12:01 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8158.024; Fri, 22 Nov 2024
 10:12:01 +0000
Date: Fri, 22 Nov 2024 18:11:51 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Paul Moore <paul@paul-moore.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	John Johansen <john.johansen@canonical.com>, <tomoyo-dev-en@lists.osdn.me>,
	<tomoyo-users-en@lists.osdn.me>, <tomoyo-dev@lists.osdn.me>,
	<tomoyo-users@lists.osdn.me>, <oliver.sang@intel.com>
Subject: [linus:master] [tomoyo]  c5e3cdbf2a: Kernel_panic-not_syncing:STOP
Message-ID: <202411221744.1a298e1e-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: d8177d4d-ada7-4c65-852c-08dd0ade1b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ho1MfQYvE1lRWUvz508En6n/sgDdWP0dsvWPBFayXOMrxBGy/iiBoYLtbjID?=
 =?us-ascii?Q?g/QJTSl1qBEWa2v0kD5hqR2dzKf1BwBAKnriGGmrrwzNSdILJKVzM1TegOgh?=
 =?us-ascii?Q?GKdKXIdPsIhuAZCZwrO9etPP1si9qxV5SyvHz/QnIhhNADtIQnAoeBW9NwSa?=
 =?us-ascii?Q?a2IZns6qJr6pBeV0lUKqMFqecBKmSw/1w5Dw6M2ezeJ6GqybkuszW3TWlMBh?=
 =?us-ascii?Q?5LE3Sny2/kwLLfSBRVz4KihdB+juw1ikaXv/+GfsF2TyF1pb7RLpmkUJniCL?=
 =?us-ascii?Q?0PdAGbR074W2iRmQvmcFYLaKolcrzqHnUWw8+nIKV7XTP9nch2H6nyvPwnUk?=
 =?us-ascii?Q?Q/vIyjTSi1Lmk4Z5XQ3f/Fn8+S7BbpPW6TG/i7IN2hLQFojj9oN0f61VJKCY?=
 =?us-ascii?Q?9XeqAeMvD8/Bew1rqwv48ZTiANryAqTxSN0xuu5aSyckwGgQXbNDkifS75hc?=
 =?us-ascii?Q?KgffYkxcToShTS99TaC4eCsv/xi6e6ME2GqKKVCnnd6GmngW0CVP3vX7l4hx?=
 =?us-ascii?Q?A835Y4fL84dkQai2wfIb3RpywX6oAC8O1GTG3AMLW+160IwVx3QKiR6PyjEd?=
 =?us-ascii?Q?qZ875rktyebJw4DyQ0T688mJ2+flv7j/P9i/hOX81OcWCXoF7xwQsj78v0+s?=
 =?us-ascii?Q?oSLWVWnf5SG20oMxoMONo6kk+7eSv65y43GOZGmh1k8tRV6cSxjUX6iH5Chn?=
 =?us-ascii?Q?5yAOF4ffGwBeicWALjc/vYM+x4V6ATfiKMraTAvuvX3PdY81u3PyzskngHYd?=
 =?us-ascii?Q?tLWgW3QysOQ4oixaIT/sg/BgD19supDm7/MCnYZEi4nibyZlDjeXYDVmLkVR?=
 =?us-ascii?Q?JQIjNJ3Gp7vr2bSzEstL5V6WUbAleZ38CS3ip0oE8yhaTHxrFF7DPiW8Lwfg?=
 =?us-ascii?Q?fRY21sx4wkgpc/J7gvCtL/D21vi0JT+cn9jt4scN2nogBXQuneSfzjuNiUiG?=
 =?us-ascii?Q?U1Q9Raa8fzSOLqmoI66cl+R5ivWi9gOPCbPZCWpZrj12MPOZi31Ci+/ae+BR?=
 =?us-ascii?Q?uMZTFdBSJAebAgPg81m0rV2Oh+UexdkLg5kpqeMqeLdN7sreq1/JGycAVu3N?=
 =?us-ascii?Q?Z0ebHYcu1VbnYp70PW91HvSIBsR7i6xyjOPywJca+0U/VLrHjR8+9c2Pv8zf?=
 =?us-ascii?Q?AlGOKgVoaHtevKNY46yaYTW/osRkTpwXd9Mlro6ZNqyMYp0WN9szFzJYTsGr?=
 =?us-ascii?Q?LM2f4w2Epqrt19OwQ3CmbMshpzd3KBCpFU9gvqGSyrYYC7h0cYStCvwAKfIw?=
 =?us-ascii?Q?i9gtGeKqhanzVk6+SSb23oQY1riB47aIzzD+V33qcQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LbamXjqEUCA/d5hyBWEv+j09KlE5nBAAnofoSS/qm6E6CESepUr+X1XraiNS?=
 =?us-ascii?Q?yHhN4CBwTaaXDN5y3J/G5wHLS1JHFUFbcgK71S0yuv3lvCM82s6MUVozddub?=
 =?us-ascii?Q?m92us9oqXJ0wMbs4UwK+QgaFtdX4RNVRq+PbuEyGYpHqB1ByceX7rXRgI7Zg?=
 =?us-ascii?Q?LNK3OOObCQp1NC+wKDEddBTyZg+SyKquCV6vpZoQSR8Gj6OWrpD2G5ujCg+v?=
 =?us-ascii?Q?mObZK5/eRxQKWk1pZiYtqjj/qfkjn4LesPChpKtLMTrQ+sbYQ122GVHzaTeM?=
 =?us-ascii?Q?6ZR4saDoZDgbG58/sh/gpk4dZwVTl25ZgptRyeeUh07T4NEIVoQTVV2S7ZO/?=
 =?us-ascii?Q?Dnkq+rmTdlZnK3Ri/b1XlEuuF54TJcsb/KCxyBIlUc9YKs8OHJMt7Q3W/qGx?=
 =?us-ascii?Q?b/D57rr+znFKVnzDrcxa3jaPjw1rtqPBS+WtB7L/W6GSIECnPcCxuv1WMoqS?=
 =?us-ascii?Q?/50P1/47xy0MMhzsOm1UYWlaor/AuAI9s5wplgokIFXVvPXJiN8fSmuCT1NB?=
 =?us-ascii?Q?g+Dap40damIwTrxqHpzdwVaqZJ5lLXoi35W1YEcuE9vPhbFJxa1tlFhrzlxk?=
 =?us-ascii?Q?nmrmNg4pW/DpFKVHfoNxNb3CRj9pvCtRWolmK3pgjiGMjgTCWisMTsY8TVS2?=
 =?us-ascii?Q?XJE/2lmmgIgotezGXrqftYqQT4TciH79twUNsbKmtmK3IQZiqLXUw2cEQ+Vl?=
 =?us-ascii?Q?e3e2vTeedsIKPhIUeCsxRNpvzv/za3vrnMhdv1FBshR/0HLfIB3Qzv0etJzv?=
 =?us-ascii?Q?LfPgAttg7vQjoAoCQOnwkrKsMQzOQjYmZqKkd7x+rZ/cczwbIdzRZpbiB56Z?=
 =?us-ascii?Q?nb6rYVFzRprems46iNhbIK5fEALX1AeZiAEbjizv/1mv8K0SidDelXdSkCGx?=
 =?us-ascii?Q?tfSuROwQynj0GnILg/3+EdIQ6LDM0J0c/SFifhd+n+qrfQIjqO3aLrIilGMJ?=
 =?us-ascii?Q?1fm5MywQyRa7ugbS8cs1EU6OxTuqxZP26mnl4/97Pj6LSfKjh/rG0Ol07S6t?=
 =?us-ascii?Q?9/XPlE2sA70wpx8OlFubVVguKUbMMT/mCqSKcqK71TSrssq7Y7ENglDt1YGg?=
 =?us-ascii?Q?nFT3+hWoE9R5Vyv2kAX5whh9loP53SIbGObx+Q25K06lTeOBp7Mhot4lUPPi?=
 =?us-ascii?Q?RiG0odcYVyHlLRJsW2cTr5LlWms0rbF7uLOdYsWMBO944qyxKNNUuGadWqjW?=
 =?us-ascii?Q?P3509gJk9hNw93ke1HzEvrwl9T2I0G66MWB8SyIqR7WZZ9xLyU+Q2VxVhPm1?=
 =?us-ascii?Q?eHSSw2XPZ/xgONUTxN/QH56s/XDAnSNqHnzQuxMf6pw5llKOHIgD6AtDw2i1?=
 =?us-ascii?Q?mm+Sd6R3VldBAoixgPk/gjiNaFR1HSOERBVXUj6gcS+rt5ne0q3+lE+GD5z9?=
 =?us-ascii?Q?aUWXVui+r2RC6aFCx0wzH26AjE2izaZbwnRsPW8bDFXm52cP3VPDyfO/3Fyu?=
 =?us-ascii?Q?iN0mRce7+GmglGFUkXrWyvWU7ChM/ASkeel8V/jbX7ZxysRfuqJqIf1mqi2H?=
 =?us-ascii?Q?1LXCd42Mi6CjPB66Tvho942hvQCsmmBVnfihFAiUzmiOerETrL3SO8OKZjan?=
 =?us-ascii?Q?1H/MCd6QXlqWQU4+gVdRgNtMqc7i5+Dagx0bNQcaPVzMvP74uy2ZdP4KFSdP?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8177d4d-ada7-4c65-852c-08dd0ade1b07
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 10:12:00.9735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvUpe5OFxC61L8IajqZ4GkBY5vEMWJSXc4ZjsCj9SG1aWRNOSxhZuU5YKeDqZBFjUmZ5uV0K7LTbxCaeZs6iMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7176
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "Kernel_panic-not_syncing:STOP" on:

commit: c5e3cdbf2afedef77b64229fd0aed693abf0a0c4 ("tomoyo: revert CONFIG_SECURITY_TOMOYO_LKM support")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      bf9aa14fc523d2763fc9a10672a709224e8fcaf4]
[test failed on linux-next/master ac24e26aa08fe026804f678599f805eb13374a5d]

in testcase: boot

config: i386-randconfig-005-20241118
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------+-----------+------------+
|                               | v6.12-rc1 | c5e3cdbf2a |
+-------------------------------+-----------+------------+
| boot_successes                | 27        | 0          |
| boot_failures                 | 0         | 18         |
| Kernel_panic-not_syncing:STOP | 0         | 18         |
+-------------------------------+-----------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202411221744.1a298e1e-lkp@intel.com


[    4.932564][    T1] netfs: FS-Cache loaded
[    4.934326][    T1] TOMOYO: 2.6.0
[    4.935572][    T1] Profile 0 (used by '<kernel>') is not defined.
[    4.937654][    T1] Userland tools for TOMOYO 2.6 must be installed and policy must be initialized.
[    4.940603][    T1] Please see https://tomoyo.sourceforge.net/2.6/ for more information.
[    4.943192][    T1] Kernel panic - not syncing: STOP!
[    4.944582][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper Tainted: G                T  6.12.0-rc1-00001-gc5e3cdbf2afe #1
[    4.944582][    T1] Tainted: [T]=RANDSTRUCT
[    4.944582][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    4.944582][    T1] Call Trace:
[ 4.944582][ T1] dump_stack_lvl (kbuild/src/consumer/lib/dump_stack.c:124) 
[ 4.944582][ T1] dump_stack (kbuild/src/consumer/lib/dump_stack.c:130) 
[ 4.944582][ T1] panic (kbuild/src/consumer/kernel/panic.c:354) 
[ 4.944582][ T1] tomoyo_check_profile (kbuild/src/consumer/security/tomoyo/common.c:2785 (discriminator 1)) 
[ 4.944582][ T1] ? lock_release (kbuild/src/consumer/kernel/locking/lockdep.c:467 kbuild/src/consumer/kernel/locking/lockdep.c:5848) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241122/202411221744.1a298e1e-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



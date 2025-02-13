Return-Path: <linux-kernel+bounces-512297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EE7A3373B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B873A612F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 05:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DF22066EA;
	Thu, 13 Feb 2025 05:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dV3TkeU4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B66205E0B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 05:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739424448; cv=fail; b=ajWfvZb7fBHpiC1R7SgouvH984YwSKA90mE3PYqCE05/bXujKjB4BVkGyG5CaU154kaCrlLG4lie9p1acyrqbgFKTU2SZZ8jTAZ54zJdv3MLW6lIm5sF4kL6atLIAFRPZi+kxX6qWq10fLTc4x2f3ShIokOCB5FLW7NM/ZjOtXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739424448; c=relaxed/simple;
	bh=XpO+hW+Ig0Qv+ojI8Zew/WR4bvjNGQ1KSdj402WCTGU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=HvG6FqT8wNIOOdhyQ+m3PWNut5APLJ+1IbzXH0YRDTtapEvIVA1ZzWIgNhf1U0YowPhbA3c4bbLz+QKK/K922IEP4eFy648kNnOjEmDt10D19tG5VBdvLXRwXDp7pS8EokCRapqC5a0+4XxhojH/0XhPaxJb4dSPEoIhi/FYJos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dV3TkeU4; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739424446; x=1770960446;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XpO+hW+Ig0Qv+ojI8Zew/WR4bvjNGQ1KSdj402WCTGU=;
  b=dV3TkeU4DrXNQbpkLotEh3tLI32vDLOulC1ePp4XJCIIyEQJqgrAgFnr
   ftwDnR7+Tcx8qzZHIJ3wP42aILhUrlPiOrnFKp70rLz8f/XqtVSgU6HQh
   GWhiilCCA8E2UGV7vBLaRGKNCvxvbpvEwM3mcWzIiKZF0ewlq82RVEI89
   Dp22fjX5g2KqFvbmgLjIOZ2lgsKeJk5g1wYywikDA3Wz/pofwtOLTwg6G
   VHYHsO1FMbyJslxZG5EVA1KGnsl28FMMq+ckd6WCxQUUcsng6zNpnITXp
   VuDXXWhMG+rat5HPCjf5fjxluqPYLmf7Ynroc/QQ38Jo/tvJNtnNXlKHf
   Q==;
X-CSE-ConnectionGUID: 9To68ReVSEm3L0Xdq8ljMA==
X-CSE-MsgGUID: p9jrq+OLRlaV3oknb8RVSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="43764428"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="43764428"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 21:27:25 -0800
X-CSE-ConnectionGUID: Wge2hLaYQh2K5AZyMhPTpA==
X-CSE-MsgGUID: kK/ep5gRRRaDGCJILF7K2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="112895553"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 21:27:25 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 21:27:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Feb 2025 21:27:24 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 21:27:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPIbSKoUWGb96MaD7px8ESZwVhsebD4RUdIEqHPFy56wuYcUcdW8bcAeLrY+nOlDhAQUIH/mInjsklrB79HyZD/hoCocYabVWc2AfZbnZ8H3n+U1FSfG2fV7ILfuV9mumj5lE2McpI90jh4qdy75es8yuBaq/JIOuCpkcVOBcGY6mywlW+xOIdUU+X+3w+5mWn7c2McgHLlCDXYKUktLHGAlUFdGRxb/93ZHc524E2TV3W1IHqKzfmDkBcq5uyJbCkPCSdCxc8ZO2u4l1HmIDAn9mzF/vLA+tbhySRKnCqPlkRMntn6qm3CfBrqV+K7epaC5GLDwd2N/eV+l40kmTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3Lzw6girqgHCaC4xjA+lrUSaDXdrgTM1vyWDFtLxtU=;
 b=HV62w2vrjEsPaeQu0GjDCyjUl2zFHio7xa/turOVOtf0ZD/MQOJFTbPcC7XgUkCT9T4dIj5PT8DzlwQYTlbF6NGAv9P2hah+9TnHOk25RABDAf8WjT554BgODAB4lgpHtpMLwSxw/wEiEaNmzZh+P5Tbma9YMUuj5hCrE5JJFGawKDUowZrQi8fQeCDT4ME5HvojZaNV0QLx4n3RduUGJw+VsCOfECgLuhkFSNmKgfa3AfGADc/9vOpKTjLTJlhMDVoKWXJgUoYiHkVbq9dNoyg2hFw4epD/27amNLuFK70JJxGYL03kq+BcmfSiglHfTcHWEagt1UHXrC6YYKxw4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by IA0PR11MB7742.namprd11.prod.outlook.com (2603:10b6:208:403::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 05:27:21 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 05:27:21 +0000
Date: Thu, 13 Feb 2025 13:27:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "Sudeep
 Holla" <sudeep.holla@arm.com>
Subject: arch/arm/boot/dts/arm/integratorap-im-pd1.dts:57.28-64.4: Warning
 (simple_bus_reg): /bus@c0000000/bus@c0000000/clock-uart: missing or empty
 reg/ranges property
Message-ID: <Z62CrlYrRpK6kZlJ@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|IA0PR11MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8afda0-211e-44df-f7a2-08dd4bef1692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|220923002;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AZPz/DSqlf0mO12P/SB2rllCnB5fnwPbD10EMV22yi1bAcZaw98J3LzKHqyj?=
 =?us-ascii?Q?232DRzQJuJlvzxw9AjSClZdd2TXWXvbKQcIBlcz4BwOhHdvmDri84YZnUM7z?=
 =?us-ascii?Q?B1Ctz5fFny6zbl63NuVDI7Oselwbk4XCJHCbGNxnNQ6QHNrpjALYlgcJaoRV?=
 =?us-ascii?Q?HI1Cpipb8a/c6a2FcrQX3WUypnmWCWvG/swEpSkMbA0uHJVGmq2cNLZfPWbn?=
 =?us-ascii?Q?MWX8DytN/z8XQKg4MU4zKvml2TESjShFi7LUs1jf8/L1+ddggMMWo/DFV24r?=
 =?us-ascii?Q?y1zaiPo6pKgPOaqLRbklW3f6Ui4nNpfBKnKNXiFbdJ3rr4XfPfSibk/kfoTw?=
 =?us-ascii?Q?tOcp3J6csq6HvpZiSyE/fSWNKpSxh6kZUmJl+MPPD2xAXORwM7n95bJHSq6p?=
 =?us-ascii?Q?DIo6PS6J6Zj0fqDCa6GoWmE6Q+qR1UUhWsEKU5Hnpa5zhTH1lVY7MZZWeZMn?=
 =?us-ascii?Q?UKvEw0AGfBOUdT8KHgqNsTlY54lR7rm/mXWliCxFn6V2Bx9cf3c0GiPGmjWV?=
 =?us-ascii?Q?X2bYWbA5lYoGcg8XpDIzeqNT7MKmdHX7pUb7hL8zzK/KS55JASaqkzaxTIbY?=
 =?us-ascii?Q?Nntzc4/myuVapHrjRIBWH63Kn2Djrzo+zlysxupOpvFfRKkhM4+2NOFbAhTb?=
 =?us-ascii?Q?LypizFVyDCBjq4qWnl2690MggSHF4sPXObUbLVd28NBNO3VtzgbgoXrskD/2?=
 =?us-ascii?Q?at9EF/5nrsiAOC9pPz+lcS3cxbxvCyOZIWVWqfk/tT0mnTG/kEMruTh0BnHH?=
 =?us-ascii?Q?R7Sr0Nt8z+N5nFnk8X7rMJnxqSFrh6mcYH9+FhDrQv3tEBGq8ushfXNSyMVl?=
 =?us-ascii?Q?B1h7JUCME8lbYSUnrlzxX/K9N6Mb6INMhRCYt2gg6dDnp6bwqAvmC+2/sRfT?=
 =?us-ascii?Q?rspw8WQo3yQLuocFEw8ys3+H4ytKNgm347y7IdbdWnZUkmk/u96JdKto32O5?=
 =?us-ascii?Q?AfNfwynPBHUJugAkscKSuZHaiK2rt0E2kI7boWy/t5HlbRwar2IrY8TaFiji?=
 =?us-ascii?Q?VGLevx5zDnRYpyAMrTHhfKYEndcBeIMK4iu7i9q8a3DTmz9yYRBPyXBbMQJJ?=
 =?us-ascii?Q?6eurq+0+XU0PQLJsdzLkCahrVOqfu1VerAxwji93HoDM8sshoxX4BcjwZr9D?=
 =?us-ascii?Q?Nuxu5IUHC+syTwEVH6LV6aEd8d3fhYU3IgpBYM2FkcwTVdiDZfzF3HaokBQr?=
 =?us-ascii?Q?typb9g/REzJ4Wx+zZAlcro00j1PLxLAX5L4hrhUOYPPABy0asYvzJU20wUuu?=
 =?us-ascii?Q?EQgTniL2YwridtitbZr4Mv9rB8mmuJDeitAdKXotrCA062OUV4n5zet2qsOn?=
 =?us-ascii?Q?B3eACl+x1wxoM9uS0ELcHrobbcfN5mcl9R4Vrgh6VvcOGx3u6ny0TVAO+PuD?=
 =?us-ascii?Q?VCjkGII3d8p1IfNGbLZ+Yhp8RIOQFwLpiphT01d7ryf1OJYidg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZLFk9fW+UI19e5APK95VlrN+cjKLX0B+HZke2q6P0YsjVw38Jc3GyMXlGMqv?=
 =?us-ascii?Q?xGpypq2maZjOW78UxN9qSC/k4MLgTO+2BPXb2b2dFQ5L2iyvwnrbzOkAS/cF?=
 =?us-ascii?Q?aSCnLvlQxeKu8dqdV44uTXSXY3eI5dhqZQ9ljeh2g0OZJLstYOjAWpIASUUK?=
 =?us-ascii?Q?eLXiYvNVw9uaGI72jKGhMJZ0uP1R1e4arp8kyhkqYC3D1FlsLwKG8cLZT7hm?=
 =?us-ascii?Q?mzlZYFZuCq6sz/XY/nrRR5pou4tVdyrgMIiK2yr8cutv0z1U8VzO2DSMSrHV?=
 =?us-ascii?Q?DyxpS1YpKzEB0F9r5ky/EQNanIaOGBLnW/t31OTRbMxxka/4jeHejVQ4MCb9?=
 =?us-ascii?Q?Cd07SDpnh9m/BThIzeHxb1LzGfPIXa9lcSja1VFSvX38k4D6snXUvqAcrX7Y?=
 =?us-ascii?Q?vrzgnuSTahNKOHmwolIAyGvXrxcHSP3eHENVFy0DiBKNc33WkwGgeN8vXudt?=
 =?us-ascii?Q?qRd8K0NqVKtBeV9pDjq/4LtKIt1QB7lr5Huo9NfFjicwbO9MIwSfSO141KVU?=
 =?us-ascii?Q?b+sMTp2kGFzF9/2oFsW2bZ/gLSgsVJ4w9Pr4NreeOLitbFGRM2HAZScjH4N+?=
 =?us-ascii?Q?MpyOT5fZmURiXe0ItEtwkLQpIEDvT6YHsJr/j4E6fyAW78NJl1a6sAywcpAA?=
 =?us-ascii?Q?PqavzjLa65YigWEDTgB6oyJnIKB+8nfLDZyiFNtWnG4uEU/PRDfn0SszNi42?=
 =?us-ascii?Q?Tip1hcKS8Lqpx2+ocIEECwPYOf9xZ/X0hOQx5E9SGBkLRO5vsFlU0Sd65tUI?=
 =?us-ascii?Q?3Sc8iJwDnzPjOdhluhAxNt3kdvkc2atXBbe6iDlDJ0H39SBHGc/2YNgFhcv+?=
 =?us-ascii?Q?cWKqI5gttrLCZxy2zFqPNZXWS+ONGD0JYxjiCicdff11/EAn9InvYiogzabp?=
 =?us-ascii?Q?bqbpAUL17N21KOQptsSNFFVevgIXOtacdkWTa4ZcshhuPO9o496yjtqclkmm?=
 =?us-ascii?Q?XiCkxIkn6/nYdxaI11X/BzhUqqBbbms9oe0gfRczl3VdN+tm/yzoT1h8+/D/?=
 =?us-ascii?Q?8IzXalECdRoftBs8UyPnqpOUChXHmdGH68HEwidEyZhT0j4dinZYGO6kOXoh?=
 =?us-ascii?Q?AA9bG4AaQCP05llhD4+u43HFt7xTxBn5VYt5sSofN79XBazt4UohDK07TIlm?=
 =?us-ascii?Q?MOkcKQjxYfRzzaZ4il54k2PJhpixofY2e864k8xw53PA6kTqXz3U+lgKBLsm?=
 =?us-ascii?Q?B2Msp33gSA+Wi09nKphirJ6P8VXBX8R9r4loVlR/SRGit3RtdPMWJUaA7gZt?=
 =?us-ascii?Q?5OivCsscC1XKr5Iy4r8h80eqj0me1pU1OagMOt57raGBgEuJjslz1tSXgqxz?=
 =?us-ascii?Q?vFNm0PYk7gyANgC/75PaQ++mhN7ZQerIuOP7dQH/+h8UiA99aw5ZOEbivvXP?=
 =?us-ascii?Q?fuGvH0R3SMwFLyN5Ferw7cWWOlnicE6KHs80ewflyVNtKZrKgtvbZdkmbu7U?=
 =?us-ascii?Q?z0KBYKMSVpWt+WUjHG/EjLdiD0m02rcwaajuH4hDYu60+vKrOLRn4UyB+JrV?=
 =?us-ascii?Q?EDWtLKYL6PqnWbbaqJ+C8ll4mVOl9WmtwuFEWZseLH7szeA/1iVOrw4HZUot?=
 =?us-ascii?Q?3FAtfsJVw3JdLr4wsbYLS/ygY1OLdVJIGOOlwSM6DXMRHocDxb2kdwpscTNb?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8afda0-211e-44df-f7a2-08dd4bef1692
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 05:27:20.9887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IdYaFY/pfd1bY8nAt0vzpBpgbwN6xWhCz5oyNAwJhXjVEu895BdZRoaXkyBg5QgzteeCNv0dwY5f257GVelVVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7742
X-OriginatorOrg: intel.com

Hi Rob,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   69b54314c975f4dfd3a29d6b9211ab68fff46682
commit: 04f08ef291d4b8d76f8d198bf2929ad43b96eecf arm/arm64: dts: arm: Use generic clock and regulator nodenames
date:   7 months ago
:::::: branch date: 3 hours ago
:::::: commit date: 7 months ago
config: arm-randconfig-r013-20230520 (https://download.01.org/0day-ci/archive/20250210/202502100541.WPdpf1m0-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250210/202502100541.WPdpf1m0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202502100541.WPdpf1m0-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm/boot/dts/arm/integratorap-im-pd1.dts:251.3-14: Warning (dma_ranges_format): /bus@c0000000/bus@c0000000/display@1000000:dma-ranges: empty "dma-ranges" property but its #address-cells (2) differs from /bus@c0000000/bus@c0000000 (1)
   arch/arm/boot/dts/arm/integrator.dtsi:10.9-13.4: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
   arch/arm/boot/dts/arm/integratorap.dts:103.9-132.4: Warning (unit_address_vs_reg): /syscon: node has a reg or ranges property, but no unit name
   arch/arm/boot/dts/arm/integratorap-im-pd1.dts:91.12-96.5: Warning (unit_address_vs_reg): /bus@c0000000/bus@c0000000/gpio_keys/button@0: node has a unit name, but no reg or ranges property
   arch/arm/boot/dts/arm/integratorap-im-pd1.dts:97.12-102.5: Warning (unit_address_vs_reg): /bus@c0000000/bus@c0000000/gpio_keys/button@1: node has a unit name, but no reg or ranges property
   arch/arm/boot/dts/arm/integratorap-im-pd1.dts:103.12-108.5: Warning (unit_address_vs_reg): /bus@c0000000/bus@c0000000/gpio_keys/button@2: node has a unit name, but no reg or ranges property
   arch/arm/boot/dts/arm/integratorap-im-pd1.dts:109.12-114.5: Warning (unit_address_vs_reg): /bus@c0000000/bus@c0000000/gpio_keys/button@3: node has a unit name, but no reg or ranges property
   arch/arm/boot/dts/arm/integratorap-im-pd1.dts:115.12-120.5: Warning (unit_address_vs_reg): /bus@c0000000/bus@c0000000/gpio_keys/button@4: node has a unit name, but no reg or ranges property
   arch/arm/boot/dts/arm/integratorap-im-pd1.dts:121.12-126.5: Warning (unit_address_vs_reg): /bus@c0000000/bus@c0000000/gpio_keys/button@5: node has a unit name, but no reg or ranges property
   arch/arm/boot/dts/arm/integratorap-im-pd1.dts:253.10-262.5: Warning (unit_address_vs_reg): /bus@c0000000/bus@c0000000/display@1000000/port@0: node has a unit name, but no reg or ranges property
>> arch/arm/boot/dts/arm/integratorap-im-pd1.dts:57.28-64.4: Warning (simple_bus_reg): /bus@c0000000/bus@c0000000/clock-uart: missing or empty reg/ranges property
>> arch/arm/boot/dts/arm/integratorap-im-pd1.dts:67.26-74.4: Warning (simple_bus_reg): /bus@c0000000/bus@c0000000/clock-ssp: missing or empty reg/ranges property
   arch/arm/boot/dts/arm/integratorap-im-pd1.dts:77.23-83.4: Warning (simple_bus_reg): /bus@c0000000/bus@c0000000/regulator: missing or empty reg/ranges property
   arch/arm/boot/dts/arm/integratorap-im-pd1.dts:86.12-127.4: Warning (simple_bus_reg): /bus@c0000000/bus@c0000000/gpio_keys: missing or empty reg/ranges property
   arch/arm/boot/dts/arm/integratorap-im-pd1.dts:130.9-151.4: Warning (simple_bus_reg): /bus@c0000000/bus@c0000000/bridge: missing or empty reg/ranges property
   arch/arm/boot/dts/arm/integratorap-im-pd1.dts:153.6-162.4: Warning (simple_bus_reg): /bus@c0000000/bus@c0000000/vga: missing or empty reg/ranges property
   arch/arm/boot/dts/arm/integratorap-im-pd1.dts:86.12-127.4: Warning (avoid_unnecessary_addr_size): /bus@c0000000/bus@c0000000/gpio_keys: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm/boot/dts/arm/integratorap.dts:50.10-53.4: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
   arch/arm/boot/dts/arm/integratorap.dts:50.10-53.4: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
   arch/arm/boot/dts/arm/integratorap-im-pd1.dts:253.10-262.5: Warning (graph_child_address): /bus@c0000000/bus@c0000000/display@1000000/port@0: graph node has single child node 'endpoint@0', #address-cells/#size-cells are not necessary

vim +57 arch/arm/boot/dts/arm/integratorap-im-pd1.dts

d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  26  
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  27  &lm0 {
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  28  	syscon@0 {
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  29  		compatible = "arm,im-pd1-syscon", "syscon";
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  30  		reg = <0x00000000 0x1000>;
2d3de197a81886 arch/arm/boot/dts/integratorap-im-pd1.dts     Rob Herring       2021-10-25  31  		ranges;
2d3de197a81886 arch/arm/boot/dts/integratorap-im-pd1.dts     Rob Herring       2021-10-25  32  		#address-cells = <1>;
2d3de197a81886 arch/arm/boot/dts/integratorap-im-pd1.dts     Rob Herring       2021-10-25  33  		#size-cells = <1>;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  34  
2d3de197a81886 arch/arm/boot/dts/integratorap-im-pd1.dts     Rob Herring       2021-10-25  35  		vco1: clock-controller@0 {
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  36  			compatible = "arm,impd1-vco1";
2d3de197a81886 arch/arm/boot/dts/integratorap-im-pd1.dts     Rob Herring       2021-10-25  37  			reg = <0x00 0x04>;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  38  			#clock-cells = <0>;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  39  			lock-offset = <0x08>;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  40  			vco-offset = <0x00>;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  41  			clocks = <&sysclk>;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  42  			clock-output-names = "IM-PD1-VCO1";
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  43  		};
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  44  
2d3de197a81886 arch/arm/boot/dts/integratorap-im-pd1.dts     Rob Herring       2021-10-25  45  		vco2: clock-controller@4 {
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  46  			compatible = "arm,impd1-vco2";
2d3de197a81886 arch/arm/boot/dts/integratorap-im-pd1.dts     Rob Herring       2021-10-25  47  			reg = <0x04 0x04>;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  48  			#clock-cells = <0>;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  49  			lock-offset = <0x08>;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  50  			vco-offset = <0x04>;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  51  			clocks = <&sysclk>;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  52  			clock-output-names = "IM-PD1-VCO2";
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  53  		};
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  54  	};
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  55  
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  56  	/* Also used for the Smart Card Interface SCI */
04f08ef291d4b8 arch/arm/boot/dts/arm/integratorap-im-pd1.dts Rob Herring (Arm  2024-06-30 @57) 	impd1_uartclk: clock-uart {
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  58  		compatible = "fixed-factor-clock";
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  59  		#clock-cells = <0>;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  60  		clock-div = <4>;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  61  		clock-mult = <1>;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  62  		clocks = <&vco2>;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  63  		clock-output-names = "VCO2_DIV4";
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  64  	};
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  65  
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  66  	/* For the SSP the clock is divided by 64 */
04f08ef291d4b8 arch/arm/boot/dts/arm/integratorap-im-pd1.dts Rob Herring (Arm  2024-06-30 @67) 	impd1_sspclk: clock-ssp {
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  68  		compatible = "fixed-factor-clock";
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  69  		#clock-cells = <0>;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  70  		clock-div = <64>;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  71  		clock-mult = <1>;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  72  		clocks = <&vco2>;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  73  		clock-output-names = "VCO2_DIV64";
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  74  	};
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  75  
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  76  	/* Fixed regulator for the MMC */
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  77  	impd1_3v3: regulator {
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  78  		compatible = "regulator-fixed";
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  79  		regulator-name = "3V3";
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  80  		regulator-min-microvolt = <3300000>;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  81  		regulator-max-microvolt = <3300000>;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  82  		regulator-always-on;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  83  	};
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  84  
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  85  	/* Push buttons on the IM-PD1 */
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  86  	gpio_keys {
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  87  		compatible = "gpio-keys";
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  88  		#address-cells = <1>;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  89  		#size-cells = <0>;
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13  90  
d67ef24adf3c3f arch/arm/boot/dts/integratorap-im-pd1.dts     Linus Walleij     2020-02-13 @91  		button@0 {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



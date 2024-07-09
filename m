Return-Path: <linux-kernel+bounces-245310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A51EB92B104
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F00EFB224AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8137413D880;
	Tue,  9 Jul 2024 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHE5Qyz0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4A11DA303;
	Tue,  9 Jul 2024 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720509768; cv=fail; b=ZPvUkD15SFuvt5MjYf80t+KWQbafUW85VOTZn+81I7vHgXrbADVeqwtQLXq5wGAsMdUbpsPNYoAj5aiWazd17gFY+kl+kKKAqkBW57z+EZIpLYjmGKjs7To6fDC+I/4fE9YBhl+vzVT7kLnZuj/qWP0AqOwTAHWy135SeSMy+3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720509768; c=relaxed/simple;
	bh=qWTZVVbCfBNf9q/xnbb+bUQ2A3/GsjZA+Ix5pLUcfII=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=qMiwe5R4r9K6vQ9N6mMSwHVwSgZHtUtPeYSwvkUIvG8S/8ShCJg7/2QUWE120NvnQpSXidVbdZCcuZw/PPXysC1M4RSBZeOh8tO8AUyt3eyzA2OfoLJL0oIYJhbaJbvwK2F1bfghFZEN3mJPMwphNuRfgkXzZyypBR++wxg5fns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHE5Qyz0; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720509767; x=1752045767;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qWTZVVbCfBNf9q/xnbb+bUQ2A3/GsjZA+Ix5pLUcfII=;
  b=FHE5Qyz0MyoGcA6zTqPEHO7UqnmoJlFbSq7mDfSe5ApT3TZOS29TKKhW
   CalDsIei0YWkUZSuaZB60ZBcm9ap2vszx+JFuguwaQ/Xl7i8JNMxDCdUw
   Gyq6owcGevxieW9hliiCPL2AKDQJf0bhqDfI2Xjv5YrovkvVx3i+uuxQP
   VzVJfogq5gL6liF0pDcQb2uXgFxk223LUJgEg2crSb5vxRT51rS5LvMcT
   LQ0Lyzp7tvE2j/4zjrSxyKsF5SRTrFbj2mRVYn17yq29K2eLDPvTXyyG/
   d2xJ4tMrq+aVZW1jdjAsFTCE/f/z58hdyQD1sG76MsLIajUHFUOcHzh9o
   Q==;
X-CSE-ConnectionGUID: 9P5Rp2XMSdWOCZjKUQ5hSQ==
X-CSE-MsgGUID: df81Oq8VSkO4dPErsGsnTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="29141540"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="29141540"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 00:22:46 -0700
X-CSE-ConnectionGUID: +X4Ze6LSRWaQl1hrQtiA/g==
X-CSE-MsgGUID: rhKbn3k2Q6ifjeVvw613Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="52941018"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 00:22:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 00:22:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 00:22:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 00:22:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeyIbV3BHOr7jmUm2WGfcDAiQMT9QReUD2fAikRQrw18pA0IUr7yQMJMP2mslsNFN6zxAyCYMn7wApBHdWSLvsXPlRu3q3HbbrzADCUi3rkeD4p8P2BkpqgY4axQggO2IaC+p9ZSgD9m6Qh5J/DImz9DylN+s4DuG2lh091I4R0uke32A2e37vtDVnEz9nmvWyu3U+FfZoxG8VIxJ8vmUKvOdNoxp3jqJB94pIYnn50MNu2rTb+WnqQF+5ZIpL12mY65g2bxg2YWtUXNaoBX9WASt7F/MIkY/dqAsCYzdTH3TqUVBCruMnFRtosMXgFl/YkCEJRRVtvlhdyAzclb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMR3VqE/zxFJK28RK3iMbPYfhMSrrUaM2Hles4dpBwY=;
 b=a0yAcHfkerBCbqyaSl9fpTwymS8BqTxRCMBZizIC8yeNdxeOZY7y5tL5NZNTOfWacbnLODRiqUA3LTJ7FCCFM7lLkw2meo2MVvJ6ApywMrLDyRCTvp6by706zvujdojWtipG2wUIKHikrMtOCPUTfuOd289KeSXoHUzJeCDJIbT6DgHXnLQDSML2d+pXPDms3BS0GHRFiDhJWvASXYczDPk0FfoLN2VEYk0Uf1AuYsdE7oEOGqNBEybp8/r4VB0xxJMWY5xi3Rgi2B4j3Kok1KrXfvmgJPdyBfRDwhzSHoZLF+B6AYvyANbiTruxoYRIMu0aWJmeFcZBkD2FyoYh0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 07:22:40 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 07:22:40 +0000
Date: Tue, 9 Jul 2024 15:22:29 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, "Qais
 Yousef" <qyousef@layalina.io>, <linux-doc@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [sched/pelt]  97450eb909:
 INFO:task_blocked_for_more_than#seconds
Message-ID: <202407091527.bb0be229-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW3PR11MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a4e970c-3fc3-48d6-9529-08dc9fe7eaa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nJ8JecKzM3WPKKineBXXxmtATvFzbkseEaBtkdre0Vgcnbfg8w/uZabXbmV+?=
 =?us-ascii?Q?oJzVIsvDJY88PoISAwO2ZjerI6RCN4kRRPVdIpBbCyvUMvqGeyhbARpRJi1P?=
 =?us-ascii?Q?YywdzNgS7S12sUCy1zYTPTSEVdZCjkxu4H2pbN0ijqUwqcAThJn9VJACdN7t?=
 =?us-ascii?Q?tXUm0ewuUO0rRT3SCbkW/SCE+BvlQcifjGLUAbYRqV51gM6BRGx39IeL/uci?=
 =?us-ascii?Q?hmLkgV876Hb7V8sSv5pmPV7HaessLXyo9CUm0CJG7iLMEputLuzBWlqoQj+5?=
 =?us-ascii?Q?HzEyZ14JBTpZJixAilREVRXl5CuMkbQG25693mF3JRW2Gcxza1tFUocVp/tO?=
 =?us-ascii?Q?XJQoVER3GqUF5kqj2iI6CNBPdTSF0MEPEbkc+5o1Ro7B6AOMW9Yg2oZ7R4Qw?=
 =?us-ascii?Q?LDR1mGSONILLNyJBPUF8NvKh2o4ZAI1KijuwcdtyL8/4OhzlhB+hnWsC8E12?=
 =?us-ascii?Q?SvjvS/RDRwQnE3+pAsswgGv5erfjqZUCfUdKZh6j+J4LnuIELaJadm8gbwuX?=
 =?us-ascii?Q?vfURoZ0+M6j7ni0yEbUPrePQZ3HmV5gFsKgUnVKXwqeLGgFbZY0tmsNYlJd0?=
 =?us-ascii?Q?R+x4B9p9y2CYPlxo8y46OI4r3ImA0fSXXtzduVNZ29jDW8G3AljM18lUcGLO?=
 =?us-ascii?Q?nHSIPMQoIKPbK3VdNkAVcseAxsbugP/M79DFs6gAM09r1ITd5jCmxZfjqr9E?=
 =?us-ascii?Q?Iaf6EoBl7iti9xtTJUahPG6mMphE8FzidM0vINYoAEJIrQV3IE4EpNASUI6E?=
 =?us-ascii?Q?nDnj3ufDY56GPyR6hN7P4w4dds6GpghYfv0WIlueRh5joU5WtPjg3ycYC/fu?=
 =?us-ascii?Q?zeGlFF3CVMBGauZ1MaJtGx9KN0sUv2qDCy1TdSGl4YCFTO9MaeY42vBeTfdz?=
 =?us-ascii?Q?agzZdwybk772YiE9WwtZKiL/M8TUM7pEWLFR5Yd+mXvgkHYfDT9FowZfyxgC?=
 =?us-ascii?Q?nT8XxuhC1qmpDsYLb6Uq5TkToElZCNFMYkS4ziwLTEN8IBPLYJWKc81F/OZS?=
 =?us-ascii?Q?2diQpaoAvn2uzRa/ATnwShXrItM9f8CX4fPv99cOoGQhBFntKtzRDbbqvszt?=
 =?us-ascii?Q?Hmgva8+kVlO8Ml+SaI/1T9qEaZzz50pC8ftePMF6004COfoyDCNyJvkr9p/p?=
 =?us-ascii?Q?iNsqKroA42rL+tEaCmbKmejIY8sqk44Hb31ci0rkCJaKhsCP3QcMAZc96b/M?=
 =?us-ascii?Q?EAr//7u5GoWD87RiwNgN36xpzaVrMStHfjN9ijLpitD8/XqRwocCVA8M/ASj?=
 =?us-ascii?Q?3WDh2ef0YOXYpWj/e7IRicmcvetsQ54W8maf5vj4vs4MBX1M4/880g8lu9r8?=
 =?us-ascii?Q?S75nQ4N0OGCHZkE2TowfSXP+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?khdE18WTTfuRruSXN1OtsdHAhKpX65bZjwaxUDmEG9paGpH2GVVpMoZ8wNdE?=
 =?us-ascii?Q?Fl8YYO0B+PRLy32C6juMBz8W9MRcXaaxEtl9CoeANCSdORPQR5TuALc7yk0k?=
 =?us-ascii?Q?KTJ6C94tmbFHMxpASq2qV3RQPJlxIj0U5e1CP2/iFS51QpnPB9uN9FGXHVNk?=
 =?us-ascii?Q?ajQjN4XdrmAIE5cucQkMZYyrgtsgKE3+QmxpSmmHJS0sqNTa5E85QhX7PboB?=
 =?us-ascii?Q?cbJCYKNYH8mRHBQu4kh+WYEe8ZWT5Y/qJ/9ntAibE3OJd3FhRyAaQei9XAod?=
 =?us-ascii?Q?UZWIlPbB9JWdRIPfsj8N6oWsB4DXnu+fMAhAylVopJssRACIEijL1hV46R9h?=
 =?us-ascii?Q?KBi9U+E/UDT9hRtKLGX9PwCu5QmFoZ904bzMAKyzUIw6b/O6EpLRv7/1y4gS?=
 =?us-ascii?Q?Cjd/MM5ZitQz0NqxJ9SPJN4I4CJPr4iXbpNv0QpXuxsBreyHAVF8mvW3cn5L?=
 =?us-ascii?Q?zby/dbrLrvd12qPnEQ61M8+l7AlFcEypYTjilKrpY11me1tqdX8hH0GkyuYV?=
 =?us-ascii?Q?ww+LlgmJn6QnGOlKHV++7Ndvy+re5tec1317kyjlEcx+WGKfnZaXJrRvumif?=
 =?us-ascii?Q?CzVutLh4SXCJHYUbqF72jVWae+QAnZ1UZxAkjD5mQGNCLQLLulY9wqrtGlhM?=
 =?us-ascii?Q?fAo8gy/wBMhlRRRNt54Qcw0u1qCvH4U0YvhVA4sF6yzUrd8YAwT2pf70QEE2?=
 =?us-ascii?Q?BcKsdjnO2Fee5/R0DI7aQYbTdaTW6YeetZMsEcvUn2+O2/IW9CDW7eqN2bOy?=
 =?us-ascii?Q?Q01zdgiGfatLaBiQOvOKxDbK7UEFgTyEjrvxhrcsl8QjjygXXCUkg3dKnD3M?=
 =?us-ascii?Q?VzIzE7tJs26Pf2yCYYOdEWq4aycdoHm5/7Yb+JyEFIZaxaRLPMeVRAalvcPj?=
 =?us-ascii?Q?9XdIPZZ28+VeA8s3C34W2b/yaJo21QYnxP1GON3+yLIcNPcwb9IcpVtRB6Ey?=
 =?us-ascii?Q?nGvV5vOA0RxPlb13nqSkwIez0HJ0LX5e1JSXmEolAYQg/eNvNLXGh8VgQO7R?=
 =?us-ascii?Q?CkSoj7juDom/GHD+vsVxgUafNOZRWK42dv6SSjM8sYZhCf2CxS3JkLXZxgRq?=
 =?us-ascii?Q?T6JuqlXPNr5U7fMLPpV85SOZf7ZHo0driRGWWaZGzIedp86mirxkeM6gFehL?=
 =?us-ascii?Q?XB5NiB3jq9QnK2lSZeAkJ7R9dNvgLodOlW8caRGmlgGH2Oc+l/DF346++9hI?=
 =?us-ascii?Q?Qk0B/xnnUcSUe+BUk+zDulUmYq3jwLu2ZzQBZAoufUPursZDJ0k66SCYVOoc?=
 =?us-ascii?Q?pYddQ55DTBsECxASjMUJjhsr9sLNkmnRm3YyzSXCA+mWTKYvou4yLkZKBQTi?=
 =?us-ascii?Q?IBhwqVxAJ0bydRx7AFTyqLjZYQAhdRVj+BpO1v5WcEuDDreYcibFb2i/5weZ?=
 =?us-ascii?Q?Q5WN8sLr7RQ63sVbEF8SRokCyzetm4+L1Lgtq8xFI722fYCm/pRcPMpfAsGk?=
 =?us-ascii?Q?EODyE0AxQLznBPgINPUsvYxiEt6Gheb+nEOZYKCPNlUvgjBaH4l4OlnMdqqG?=
 =?us-ascii?Q?cxx4Smnma8Dszk0J40A+Ng1GqC3RE5aHJWPtu5adcJs9tdF/djbZiLiq43JK?=
 =?us-ascii?Q?QJEjlgP+KBeCYG0tBd9AUYUddQ9gzeJG/EjUTlkMsuNQN70qgnFztpyFUIkT?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4e970c-3fc3-48d6-9529-08dc9fe7eaa7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 07:22:40.6124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsrVtwmbc0BB8WFEoFv/yWRZNGpK1lSyTPWxEr1FcCD3/xVCHlFQdWfsEqA6nZsiVjRmCw0wd9a84kxgblYEWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4522
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "INFO:task_blocked_for_more_than#seconds" on:

commit: 97450eb909658573dcacc1063b06d3d08642c0c1 ("sched/pelt: Remove shift of thermal clock")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      22f902dfc51eb3602ff9b505ac3980f6ff77b1df]
[test failed on linux-next/master 0b58e108042b0ed28a71cd7edf5175999955b233]

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: tasks



compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


we noticed the issue is random, 86 times out of 500 runs as below, while
keeping clean on parent.


d4dbc991714eefcb 97450eb909658573dcacc1063b0
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :500         17%          86:500   dmesg.INFO:task_blocked_for_more_than#seconds



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407091527.bb0be229-lkp@intel.com


[  996.963402][   T17] INFO: task swapper:1 blocked for more than 491 seconds.
[  996.973637][   T17]       Tainted: G        W          6.9.0-rc1-00051-g97450eb90965 #1
[  996.983009][   T17] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  996.992369][   T17] task:swapper         state:D stack:5680  pid:1     tgid:1     ppid:0      flags:0x00004000
[  997.003585][   T17] Call Trace:
[ 997.022071][ T17] __schedule (kernel/sched/core.c:5412 kernel/sched/core.c:6746) 
[ 997.032795][ T17] ? schedule (kernel/sched/core.c:6804 kernel/sched/core.c:6837) 
[ 997.051350][ T17] schedule (arch/x86/include/asm/preempt.h:84 (discriminator 13) kernel/sched/core.c:6824 (discriminator 13) kernel/sched/core.c:6838 (discriminator 13)) 
[ 997.061394][ T17] async_synchronize_cookie_domain (kernel/async.c:317 (discriminator 9) kernel/async.c:310 (discriminator 9)) 
[ 997.071656][ T17] ? add_wait_queue (kernel/sched/wait.c:383) 
[ 997.084201][ T17] wait_for_initramfs (init/initramfs.c:757) 
[ 997.093158][ T17] ? do_header (init/initramfs.c:761) 
[ 997.104204][ T17] populate_rootfs (init/initramfs.c:768) 
[ 997.113736][ T17] do_one_initcall (init/main.c:1238) 
[ 997.122668][ T17] ? parameq (kernel/params.c:90 (discriminator 1) kernel/params.c:99 (discriminator 1)) 
[ 997.133272][ T17] ? rdinit_setup (init/main.c:1286) 
[ 997.142176][ T17] ? parse_args (kernel/params.c:142 (discriminator 1) kernel/params.c:186 (discriminator 1)) 
[ 997.172210][ T17] ? do_initcalls (init/main.c:1298 init/main.c:1316) 
[ 997.183570][ T17] do_initcalls (init/main.c:1299 (discriminator 1) init/main.c:1316 (discriminator 1)) 
[ 997.194241][ T17] ? rest_init (init/main.c:1429) 
[ 997.204290][ T17] kernel_init_freeable (init/main.c:1552) 
[ 997.214432][ T17] kernel_init (init/main.c:1439) 
[ 997.223979][ T17] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 997.232870][ T17] ? rest_init (init/main.c:1429) 
[ 997.244227][ T17] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 997.254412][ T17] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[  997.831274][   T17]
[  997.831274][   T17] Showing all locks held in the system:
[  997.840770][   T17] 4 locks held by kworker/u4:1/16:
[  997.844292][   T17] 1 lock held by khungtaskd/17:
[ 997.853205][ T17] #0: c26e50c8 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks (kernel/locking/lockdep.c:6612) 
[  997.880625][   T17]
[  997.883881][   T17] =============================================
[  997.883881][   T17]
BUG: kernel hang in boot stage



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240709/202407091527.bb0be229-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



Return-Path: <linux-kernel+bounces-418088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DDF9D5CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2661F22D62
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B033D1D9688;
	Fri, 22 Nov 2024 10:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3Yj5hX8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2789B67F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270103; cv=fail; b=loosjiFGhKWve25MTTkw63onfMrLZFcIlDY8QOeNw6EIHQjecY40GhZFK6ZH2Amc4zpcY4i/FBrwhD57rolzeydFxBPp442hiwcDAHI9S2dnGKE7MIGtp8zeI3zcnicWBtnLam54o/zCs1M0r75xULNrrlHsvrTPze5Q5Vg8TQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270103; c=relaxed/simple;
	bh=2jc2ojqXo4Z7weleBIu7UvXBg9uIQK5rrX1njRdUW+k=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gpjKQXooXL0J9Pnjyk6WBcnN4jzJ7rIGg1j5du42OGtuYgsJmSpydt1YLTxQ+OMRhLzzYpEkgoqqlxqlvgEKG53jVI9RlspOAT4lLZI8630dlU+yBKISyO+couV6RKHZnFm09rpr5sAglLaCR0bAq0lbtFYdZ2wRNPyHkgVzlp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3Yj5hX8; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732270101; x=1763806101;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=2jc2ojqXo4Z7weleBIu7UvXBg9uIQK5rrX1njRdUW+k=;
  b=Q3Yj5hX8sMsGQ/ShEq3ZGnt90QjDJb78rYf1DiOWoa9WEH1yoXR0XAfk
   ED5jXlYQ2+n+3zjaU5VDD+VY7V73HcKRxdO4o9gE+H6Nsu9h1w5vNVdkE
   ZHsdQ06dBCNBfVDSsaat/U0OeovpVo6xVdcEXp5wxFIy5898rqfo3OQOx
   oM80ugGuAMzcZAjvd+Gw/qfmcumVEyFFA5l4CkiMrCjBCuRACgL/mOxJT
   gmIohJaUNSZGQMQCjL7b35vCAmtFKwVQyGZxn4XML157/MSsrN8RyWhV3
   cUezN6dv4i/dn5hTaZngBvMdwRmG6+rNK58yRMUU+Jt1xcfhoTyHPrrQt
   A==;
X-CSE-ConnectionGUID: 8hzOKUjITuSsJ6ijq2Aq8g==
X-CSE-MsgGUID: zgcJntMdTu+sAQ7HunibSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32359161"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="32359161"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 02:08:20 -0800
X-CSE-ConnectionGUID: 0SzJt1zPRuyXI+07bho20w==
X-CSE-MsgGUID: qcTXK1bxS6+e3GPFPFFG1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="90952012"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2024 02:08:20 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 22 Nov 2024 02:08:19 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 22 Nov 2024 02:08:19 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 02:08:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0Ym+o/WNvM+1hk1crACedX80Wr7jtk+wE/HGu78PcGfXrWvHqRdGfFPXZUCSdWN9nEgjUK4W4dGniHsKDhrLljI+VMWcw4btI4agbuqleHbAwFvRhFZIJmihPAx1G6R+T4ZkLGrhhp3MK4zNGDbHhVA4x0IeifYE7nJvMfC3cBlPH5D18j9SA9i19mGvunyJbn1m7thkCTjPiAzTxnE7Qi1ERYy6bzF/n2WYBSD4+g6BFAdDrHzmwqyIq535yNsEcWCtLcu60FYpZsZqouQTYP51JtxdOc9Oq7ojk9iKdbC1Bw342qOxSnobHGlccZhM8T/aTK0l3opZPkb8193tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qLClOSYK6vr11MJx9ltLk1EVXOndQ2iEjLa1BnnznM=;
 b=K4lPr4uyPGZP1hgKPj8AqQOrNn8m/zM1G3BvbmZNtIfUyDLe9Yq7PFWSk30Iz4syepXPCW7Y8nOlIzv1qzOUSQUdt9ZsQIuMuyEn0YF4lWXHdEeAyj6zLPHRAJZaqEZMpzHzKtaRn/RUKDTt9vGhLdS/iQSKm8OWSdG8Oi5gQNS8SlqEJrTBzhXBgmkeWFQ+eXJwFYsQ91FkGd22YSCOXvr5D0dhAUkx0/BWUi3TNpHPgtTn1GZLMZIkXUtFoUPcR/tdaFMig+6bDJImP7kBOQfmYJDaJ4ydejhcBM5NTTAEmjcAMsvvKWOlgh+UF7xrPEl3rwrXRSjO9ECSJM+UrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB7176.namprd11.prod.outlook.com (2603:10b6:208:418::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 10:08:16 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8158.024; Fri, 22 Nov 2024
 10:08:16 +0000
Date: Fri, 22 Nov 2024 18:08:03 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, =?iso-8859-1?Q?Andr=E9?= Almeida
	<andrealmeid@igalia.com>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
	<juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, <oliver.sang@intel.com>
Subject: Re: [RFC PATCH v3 5/9] futex: Track the futex hash bucket.
Message-ID: <202411221706.c9d399d3-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241115172035.795842-6-bigeasy@linutronix.de>
X-ClientProxiedBy: SG2PR06CA0196.apcprd06.prod.outlook.com (2603:1096:4:1::28)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbc60f3-b820-4f39-7fae-08dd0add94f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zo9vX0fdgBGvcSGNNwRuio7A69G69ReVuqvX2cgOi5IVyeC8/z/GH1oq1UPL?=
 =?us-ascii?Q?C/y2Tzbmxv2TONCpefUMwMf2R4d2omAZcsRZimPAXmUkB+50VHvEG0wxnfNh?=
 =?us-ascii?Q?+I35j+O+sRPkObLETSPgBPk2vhuUp6/sJaRXkO/oaf6o+zFWf0+g1Z//lfkF?=
 =?us-ascii?Q?DB5ZPdn0s736Xq+Bl8lK/WJjG70LOVU0hKeIjCYjhJJAFYqFkxtzxfr6oBk2?=
 =?us-ascii?Q?g7sFKjW9gvOv7wvvc6UStKvaEaMfNJH8rIcPl/Wx/wWLRNVqNvxFp0HIyMIe?=
 =?us-ascii?Q?bVFd7bB5vYBIcUL7UKveW9CBFO8V/oJQNHvcxgU3nptpePzsS1Moj10DvWhN?=
 =?us-ascii?Q?8n0c2T4sV2RIlO22mH95ifyo0yBqQHwJc8b5iCJBlGcykk1hVDmLACAFSeAX?=
 =?us-ascii?Q?qwBrE9XNK+n26J5C8NMRYD7MslwfhVVrK4veJ1JyzwT3ss14cETYCUtetZ0p?=
 =?us-ascii?Q?FGGv7M9Q4cyXcFNk4oZmBOna5kT7jSbJi9au4oS1vvUfbbxtxpgTf5ebktn1?=
 =?us-ascii?Q?WuucyiTdVtyBaYNjFTNkZFgSsKVwUcuup5XbnfKTBj3mq2pjgQz/F2LKynRa?=
 =?us-ascii?Q?jxST0oXLlSkCepUSfi+Tbd+4NS0DGZ7kZaJIu/RhlpkhCd3rBLeYY47A/xFq?=
 =?us-ascii?Q?lOlCkuTy+LWGkgmjhO0efemV5i9fyD2rqMtNckIuNEc6t3T4pv4KHcArw5EC?=
 =?us-ascii?Q?w9yfb9SZtkctelkV6Fef9ywbOFs8GP4Qc/iH88DCSllzpeHd5/ZeuHGaIYVd?=
 =?us-ascii?Q?0eSFPjEdch7aBp5bsQajL1TFDMQDLSFFhnHp8mLK6rh21LPQsTBR4esGfFsW?=
 =?us-ascii?Q?479TiwXqB80X6RcCSN45anCdbB/qmq+HB8OgwEBQ2xUK8ORIzIMePBBRh+uR?=
 =?us-ascii?Q?vVO6jOuvEVmkU+FKXAXPEK94tywFD831ztUcFl6QUz1DX7uFWvJgxFtezCyJ?=
 =?us-ascii?Q?7XSPKqQsTjGYzXnbyWt0bGX/Yw6BWKY2yf6Im7/tmxz7os9a6FLi6PVFnUyJ?=
 =?us-ascii?Q?EP4f7krYQem1DkG2rTKG5uWekwtOJyCrNI1gg9F9wpHvBdr/Rb2HoT6Tl+Cx?=
 =?us-ascii?Q?eA4nceIvGr3ao2NQ6gR6S5+IScIg4ws+ILde0AlPzXDd1/3mN11ki5IL36Tk?=
 =?us-ascii?Q?9QINA175WT5x7tKYk1HY0Ade7A4QcBpTmSBLTD/Phyq3rIH89QuptZ1HmHJL?=
 =?us-ascii?Q?3mMf8/LvYlmvNfiy4DZTC0bIzccJiWnXiyjFiHjJnzp9pnr8IvWZkU6CguAb?=
 =?us-ascii?Q?ElJoeO556y3YerZfQsixcjogTXDs2XJK34IVykEyvg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ilEGZ3Sdz2ucxwYl3cFsno9NAyoAQGwDNUZvDCJPCdc1yeztblmRirQuR9oZ?=
 =?us-ascii?Q?HPtK9ZbthL8Gx87bYaO4PDROWpvtqpBru+AycEPn0rhD8JTlGXbNlDC2dnjr?=
 =?us-ascii?Q?K3ec7l1kW6WAKhTZA7DAqQtOtpGvuPzxEc19ns7sJ2DnMHk/ZUAK9Ih8pt2b?=
 =?us-ascii?Q?Z5rAyj32C78RDmhC6XSbSTxeoNDNMDgrz6BNfgewEOXfiMh//BTg4Ep4krLZ?=
 =?us-ascii?Q?XU0/k/6Fmecc9n9qOhJTQFApf5ebR6Pviohnmij/aXoy/QHRsZwkCX8SPdoa?=
 =?us-ascii?Q?SULLccQltmog8Aa7GT619YVfTyChj3zjh9wvr0LbXLbKSv661+6i5ucdorJs?=
 =?us-ascii?Q?LpBi3NLQQQ0cBe81XnUB6q+4RrSpSoBNuIZXXSQQBut6l6qNQK41t3Qvmj1C?=
 =?us-ascii?Q?+9dRGSFydLjI6UAELmORmo28fwVovkcgHWNzF2NhV7h4xqum0D/B3xAjizu0?=
 =?us-ascii?Q?OPVkRUHbPbcZeIj6DaHuBHupujRjWZlyxnB7Z8MXTIz08Lyg3c+auYYgZfJm?=
 =?us-ascii?Q?6llLKjvK+uwVnf2osvkwW9l8ZO5C7XKw7cZWgivKXVq8yCrCnsfsihDEN4WR?=
 =?us-ascii?Q?EgK1bZx/p2cxuA7wIHT8Vzg/HrxyYmcTKteMxgP4Y3uAtequO1zDd50RLthS?=
 =?us-ascii?Q?FWC+M2pH2j7z3A9lS5TsPzUpr1HibSXkhZ1TJBUsQKa/0v4WUpyw9RlEAi2c?=
 =?us-ascii?Q?ScuYpEmxSvkvjD4SaahvNzxebRddlSWhQHSFPp612DwBVLyyKZM2X9eo0lYN?=
 =?us-ascii?Q?lcLpYAM8zUYHwYyECiOW8glDYarHAOKUU32THGq9hF87e8Rqp8OJYlKgidE9?=
 =?us-ascii?Q?g9zLO8UYGqOwmv/CWNC32DFzNMxcqHjwbNAcKJ6TsKhoPRvGe9QMWLbyfWM3?=
 =?us-ascii?Q?yKQjz23UyODRaaCZLTR9F9y+8UOfeymBPZe+gv5MI92VXf/ksz/LRvgK+B42?=
 =?us-ascii?Q?NaWWSiMclwZJZEsOa9tokOu1a0VlXV5yh0kjEhXSx0wF2cQ58VWdnfZTBwAX?=
 =?us-ascii?Q?tRAPjNKSIlkFBvxCwiAt9RAjfHpTWQ6odZdYCMlDu+Q//DN2PzQhvEUmN9Ow?=
 =?us-ascii?Q?Wkze2LKKZhg0y64xLe2uq/188WHnJXkqpG/kFjgaSztAYCGw8tb/OLbXP9hR?=
 =?us-ascii?Q?ryKXLNJsVLdUg59RUkeVG7hWPXnDSqOf7I3CoRDTRGfVvQd/loVKwGrNvrpv?=
 =?us-ascii?Q?igofxVvuwmnK2cME/pd3AiAxuwLhIkQTYFrnpeZYAktptaIC34LxS/+JzUcV?=
 =?us-ascii?Q?aAObiXIGKq6D+xTvuUHxvreJ1gvKsXIQ9xJujCdXKkSQ8o7TU43Nw2tRzn1P?=
 =?us-ascii?Q?ULef26rQ1YkvsoF3LEjYEyCVAHdChBGxiOGckw7RNaCQrtKt/ZEPr/3qYJZ7?=
 =?us-ascii?Q?j100qsHiQLQGV9UAlBSfMOIPvP3KAPpEbbNe2KR0ORQ2b/GDXr/8Hbt2NrQG?=
 =?us-ascii?Q?fqGyYkKNY0CVUk22PScnnEJ+XHjID7wMQAYO+31Td5CzG3g5pT8wlqKD0amQ?=
 =?us-ascii?Q?iI34TJ5BrpbjtJbcHbnHsM3wMG6AmcOEaV+3nBpw9ZwROBfU4IGFzxqsQYx4?=
 =?us-ascii?Q?vvDD4SKtoIBwLiBZG7Y/qsGvw+HlhUOZY9EzDQvnoQfiHamGsZ0Ff5porpWn?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbc60f3-b820-4f39-7fae-08dd0add94f7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 10:08:16.3522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1/eWdZyhCM6292jEP+xdqr8708pcKMVJphjCx4YOSVM1HNHTeebLiGNDBYk3jjwFAZdThmhllGIjZibFMO5ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7176
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_lib/rcuref.c:#rcuref_put_slowpath" on:

commit: 85bef61dcb6b15e3f68893e8bb8178f38ef4e58d ("[RFC PATCH v3 5/9] futex: Track the futex hash bucket.")
url: https://github.com/intel-lab-lkp/linux/commits/Sebastian-Andrzej-Siewior/futex-Create-helper-function-to-initialize-a-hash-slot/20241116-230708
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 3b49a347d751553b1d1be69c8619ae2e85fdc28d
patch link: https://lore.kernel.org/all/20241115172035.795842-6-bigeasy@linutronix.de/
patch subject: [RFC PATCH v3 5/9] futex: Track the futex hash bucket.

in testcase: boot

config: i386-randconfig-006-20241118
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------+------------+------------+
|                                              | 4e12d1b5d7 | 85bef61dcb |
+----------------------------------------------+------------+------------+
| boot_successes                               | 12         | 0          |
| boot_failures                                | 0          | 13         |
| BUG:unable_to_handle_page_fault_for_address  | 0          | 13         |
| Oops                                         | 0          | 13         |
| EIP:futex_hash_priv_put                      | 0          | 13         |
| Kernel_panic-not_syncing:Fatal_exception     | 0          | 13         |
| WARNING:at_lib/rcuref.c:#rcuref_put_slowpath | 0          | 4          |
| EIP:rcuref_put_slowpath                      | 0          | 4          |
+----------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202411221706.c9d399d3-lkp@intel.com


[    9.626353][    T1] ------------[ cut here ]------------
[    9.626688][    T1] rcuref - imbalanced put()
[ 9.626712][ T1] WARNING: CPU: 0 PID: 1 at lib/rcuref.c:267 rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 13)) 
[    9.627382][    T1] Modules linked in:
[    9.627583][    T1] CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted 6.12.0-rc2-00034-g85bef61dcb6b #1
[    9.628038][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 9.628551][ T1] EIP: rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 13)) 
[ 9.628854][ T1] Code: 00 b8 10 32 20 b2 6a 00 e8 cf 85 e4 ff 31 c9 ba 01 00 00 00 b8 f8 31 20 b2 6a 01 e8 bc 85 e4 ff 68 95 3c c7 b1 e8 d0 e9 d1 ff <0f> 0b 6a 01 31 c9 ba 01 00 00 00 b8 e0 31 20 b2 e8 9d 85 e4 ff 31
All code
========
   0:	00 b8 10 32 20 b2    	add    %bh,-0x4ddfcdf0(%rax)
   6:	6a 00                	push   $0x0
   8:	e8 cf 85 e4 ff       	call   0xffffffffffe485dc
   d:	31 c9                	xor    %ecx,%ecx
   f:	ba 01 00 00 00       	mov    $0x1,%edx
  14:	b8 f8 31 20 b2       	mov    $0xb22031f8,%eax
  19:	6a 01                	push   $0x1
  1b:	e8 bc 85 e4 ff       	call   0xffffffffffe485dc
  20:	68 95 3c c7 b1       	push   $0xffffffffb1c73c95
  25:	e8 d0 e9 d1 ff       	call   0xffffffffffd1e9fa
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	6a 01                	push   $0x1
  2e:	31 c9                	xor    %ecx,%ecx
  30:	ba 01 00 00 00       	mov    $0x1,%edx
  35:	b8 e0 31 20 b2       	mov    $0xb22031e0,%eax
  3a:	e8 9d 85 e4 ff       	call   0xffffffffffe485dc
  3f:	31                   	.byte 0x31

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	6a 01                	push   $0x1
   4:	31 c9                	xor    %ecx,%ecx
   6:	ba 01 00 00 00       	mov    $0x1,%edx
   b:	b8 e0 31 20 b2       	mov    $0xb22031e0,%eax
  10:	e8 9d 85 e4 ff       	call   0xffffffffffe485b2
  15:	31                   	.byte 0x31
[    9.629828][    T1] EAX: 00000000 EBX: cccccc01 ECX: 00000000 EDX: 00000000
[    9.630176][    T1] ESI: ec030980 EDI: b0219f04 EBP: b0219ec0 ESP: b0219eac
[    9.630523][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210246
[    9.630906][    T1] CR0: 80050033 CR2: a7be1f90 CR3: 03786000 CR4: 00040690
[    9.631261][    T1] Call Trace:
[ 9.631431][ T1] ? show_regs (arch/x86/kernel/dumpstack.c:479 arch/x86/kernel/dumpstack.c:465) 
[ 9.631648][ T1] ? rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 13)) 
[ 9.631912][ T1] ? __warn (kernel/panic.c:748) 
[ 9.632117][ T1] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
[ 9.632345][ T1] ? rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 13)) 
[ 9.632609][ T1] ? exc_overflow (arch/x86/kernel/traps.c:301) 
[ 9.632858][ T1] ? handle_bug (arch/x86/kernel/traps.c:285) 
[ 9.633081][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discriminator 1)) 
[ 9.637527][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1054) 
[ 9.637796][ T1] ? add_chain_block (kernel/locking/lockdep.c:3439) 
[ 9.638033][ T1] ? exc_overflow (arch/x86/kernel/traps.c:301) 
[ 9.638297][ T1] ? rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 13)) 
[ 9.638562][ T1] ? exc_overflow (arch/x86/kernel/traps.c:301) 
[ 9.638786][ T1] ? rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 13)) 
[ 9.639047][ T1] futex_hash_priv_put (arch/x86/include/asm/preempt.h:84 include/linux/rcuref.h:151 kernel/futex/core.c:164) 
[ 9.639301][ T1] futex_hash_put (kernel/futex/core.c:177) 
[ 9.639525][ T1] futex_wake (kernel/futex/waitwake.c:180) 
[ 9.639740][ T1] do_futex (kernel/futex/syscalls.c:107) 
[ 9.639945][ T1] __ia32_sys_futex_time32 (kernel/futex/syscalls.c:509 kernel/futex/syscalls.c:492 kernel/futex/syscalls.c:492) 
[ 9.640212][ T1] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-006-20241118/./arch/x86/include/generated/asm/syscalls_32.h:241) 
[ 9.640450][ T1] __do_fast_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:386) 
[ 9.640779][ T1] do_fast_syscall_32 (arch/x86/entry/common.c:411) 
[ 9.641032][ T1] do_SYSENTER_32 (arch/x86/entry/common.c:450) 
[ 9.641267][ T1] entry_SYSENTER_32 (arch/x86/entry/entry_32.S:836) 
[    9.641504][    T1] EIP: 0xa7f1556d
[ 9.641687][ T1] Code: c4 01 10 03 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
All code
========
   0:	c4 01 10 03          	(bad)
   4:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
   8:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b87411
   e:	10 06                	adc    %al,(%rsi)
  10:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
  14:	10 07                	adc    %al,(%rdi)
  16:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
  1a:	10 08                	adc    %cl,(%rax)
  1c:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
  2a:*	5d                   	pop    %rbp		<-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d 76 00             	lea    0x0(%rsi),%esi
  35:	58                   	pop    %rax
  36:	b8 77 00 00 00       	mov    $0x77,%eax
  3b:	cd 80                	int    $0x80
  3d:	90                   	nop
  3e:	8d                   	.byte 0x8d
  3f:	76                   	.byte 0x76

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	ret
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	8d 76 00             	lea    0x0(%rsi),%esi
   b:	58                   	pop    %rax
   c:	b8 77 00 00 00       	mov    $0x77,%eax
  11:	cd 80                	int    $0x80
  13:	90                   	nop
  14:	8d                   	.byte 0x8d
  15:	76                   	.byte 0x76
[    9.642620][    T1] EAX: ffffffda EBX: a7bfaa6c ECX: 00000081 EDX: 7fffffff
[    9.642963][    T1] ESI: 00000000 EDI: a7630000 EBP: 000000f0 ESP: af90bad0
[    9.643313][    T1] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200246
[    9.643690][    T1] irq event stamp: 113183
[ 9.643903][ T1] hardirqs last enabled at (113191): __up_console_sem (arch/x86/include/asm/irqflags.h:42 (discriminator 1) arch/x86/include/asm/irqflags.h:97 (discriminator 1) arch/x86/include/asm/irqflags.h:155 (discriminator 1) kernel/printk/printk.c:344 (discriminator 1)) 
[ 9.644340][ T1] hardirqs last disabled at (113198): __up_console_sem (kernel/printk/printk.c:342 (discriminator 1)) 
[ 9.644898][ T1] softirqs last enabled at (113010): handle_softirqs (kernel/softirq.c:401 kernel/softirq.c:582) 
[ 9.645347][ T1] softirqs last disabled at (113005): __do_softirq (kernel/softirq.c:589) 
[    9.645752][    T1] ---[ end trace 0000000000000000 ]---
[    9.662794][    T1] systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.
[    9.664914][    T1] systemd[1]: Failed to find module 'autofs4'


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241122/202411221706.c9d399d3-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



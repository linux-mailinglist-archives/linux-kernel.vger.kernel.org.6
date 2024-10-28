Return-Path: <linux-kernel+bounces-386016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702A89B3E19
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BDE6282DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2771F4294;
	Mon, 28 Oct 2024 22:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fx9tsnxb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7A21EBFFA
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730156283; cv=fail; b=RaYyBlACXOBhTlY1YDWMBcG6ORlcysEW9mXJxrzV3VTeYc1rc830KNOGtGhSPtbln+7weXFJr/48mq536QR8YQshThRGE4oKKIlMW4Rb8+cBjnMWt66/RqNI0S42guNcG45n2dt6uW7I/NUYAVhsJwXs6hQZ49yp8Qi5UtxE7W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730156283; c=relaxed/simple;
	bh=671qtkr0Yej1aWOF4VzRUlP7WxfB+YFDwJaoqbxELKw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p220Tn5Hf19lVJufYckuSGAKmURG08/6SIWxR1wb9diZGC/J6k8+8iPU1kOBY2E2dPVgl9ek1Avk+kCfNjR2SJhzCIAUokS4frU/byhXYkUycSBTe7Z4+ViQINIEc5WvlHHJQjSbpu39bd/+QECFRZXwCkNHzH7CWEZXqyOxlpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fx9tsnxb; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730156281; x=1761692281;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=671qtkr0Yej1aWOF4VzRUlP7WxfB+YFDwJaoqbxELKw=;
  b=fx9tsnxbkJ0uRctBnz/yrGrcgLOeCkQJz5m6X0H3T5BbYY8LAPvPiPq6
   BG1mIKLJVBMAR5trYy3eggJiIZ/dpVh4pRg1jnZqR0/AuSCaJB55xD1c8
   OCVwNPmJYS3M983ZRsdl60UUWac7w+904khFZxuxkY/TRhS0Ez1+4gOMb
   TkMebrRCIa39Uaq1h0s6mD+bCO+N5VLT9jKCymnLhPOIbjARccLwGF/SV
   wqIzlhowZVAi132w562Oj+OZovPaJ1D8skOWCibbdlYc4HlZcp3PKntjS
   /jXKvDNAVaOEjVkECksbyGr6B4DNc6i9d5Miyy+1HUotn+gVUbcgakqNF
   Q==;
X-CSE-ConnectionGUID: 1k+6E2qAS/Sm021hyocYvA==
X-CSE-MsgGUID: 3UmI4KtgQDS8BDhiI7W56w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33470656"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33470656"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 15:58:01 -0700
X-CSE-ConnectionGUID: WYPgcBKESVuL6Z1ZxjbP4A==
X-CSE-MsgGUID: 3YXmEsguQZWS9z0sbZf8qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="82179772"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Oct 2024 15:58:01 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 28 Oct 2024 15:58:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 28 Oct 2024 15:58:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Oct 2024 15:58:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVSztW+zZzq/zEMoFos7cf64Sb7IDdfEXlQS3GqrH9ta3i9deGdF4jb03sFjhukX3kMIAHa0W2Uv6x+ah0AU9nwqhoyWvDEDmcDRFjoxivLIQtEnqAPINABfFlP3MMrig6xSdq1zb8lPVoQaorjdeRZgP2j6XAxSShMJigXhKE1LqVH0VNp360qKq++AuCo5HKKJQAyGO4WSQAHjSLrWvChIqmkHBsC5E4wZYRjJgNILU8fNbAAd6pbW2gfBivuCNenTw/cqLSTZKISYR7WKSJknLs8dCnNXB9TdkXVpm+hpauU8t3hMCREg9oOADnwPgOIWhYYTsg+0f/sx2owUBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTZNmGO+5VineYB3R78+9Dx7DYOi7wxzG3gg5K9VZmY=;
 b=T54jDKba7AQKPsRaAGLXK0ENxE8avDOaMPMIq5zi877LSYrY8VGY3OwUsUg3zf3jA9HQiBOozvgrVO8RTXb/w+4AVns533PMrWveYyQSVrtJSatwx3MmFr68oLmFl1RoPMIIJAIGONpSwVfr00fyx6OrTyhmGJiyxBVTkkgYiJgfnAMI5i/BUQ3L553pgNC6gEPQapDdyXB7LMQ2ilKBkr5J/WDp4ocET3FSek1VcfTYiEn7saGvUiVq96f0GPKDUrys0XhX4rijesWOdCxyWntB57zZ++LyLlRKDtjDJS4QgKm5+5TQrzEU0K5D8qRM40UoQySS+QTffVN/RtmeuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV8PR11MB8608.namprd11.prod.outlook.com (2603:10b6:408:1f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.28; Mon, 28 Oct
 2024 22:57:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8093.018; Mon, 28 Oct 2024
 22:57:57 +0000
Date: Mon, 28 Oct 2024 15:57:55 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>, Dan Williams
	<dan.j.williams@intel.com>, <gregkh@linuxfoundation.org>
CC: <rafael.j.wysocki@intel.com>, <tj@kernel.org>,
	<linux-kernel@vger.kernel.org>, <regressions@lists.linux.dev>
Subject: Re: [PATCH v2] driver core: Fix userspace expectations of
 uevent_show() as a probe barrier
Message-ID: <672016f35ed5d_bc69d2946a@dwillia2-xfh.jf.intel.com.notmuch>
References: <172790598832.1168608.4519484276671503678.stgit@dwillia2-xfh.jf.intel.com>
 <67047c516045d_964fe294b1@dwillia2-xfh.jf.intel.com.notmuch>
 <42dfef93-eb8a-458b-b76b-b7de9077d0af@leemhuis.info>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <42dfef93-eb8a-458b-b76b-b7de9077d0af@leemhuis.info>
X-ClientProxiedBy: MW2PR16CA0009.namprd16.prod.outlook.com (2603:10b6:907::22)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV8PR11MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: c372772c-6129-4db3-c324-08dcf7a3f70e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/b9yXtX/95NOU7bFKrfw6rB0NVyFJ1lqZMb8zNWIN37+HQOmSxDNJAAFK7H6?=
 =?us-ascii?Q?XZjOsV1u9z/DcfB5+xL9YASFofkowwIDX3SayIy/u9azLnZtuXCdLBC61Sq4?=
 =?us-ascii?Q?QJjZqc6Z9aT+vDiD0ipQ3fkmc0nTTBxpmKG65RQT4GajybdkVWd2PZcsfB2+?=
 =?us-ascii?Q?zBcHeD97tTO2uceuAqfZkZwfJyffdhF9MHIfx+GtwSbJ711ymT0GD0IqWeaR?=
 =?us-ascii?Q?tXEXiwqHgBS6rHI6343Kmf86zJfV3vzRXtwHC7dRzlhPJsknhE16xY4hXBoE?=
 =?us-ascii?Q?EYYRuW0LNF/w7j1gW+8CBN/SVyIAClwbGELT0UjZUhuvgAK+vlh97upsfmb6?=
 =?us-ascii?Q?5pAi7mPMsAO/Hkw6MfysFl3yewHT55p5mxGegEZgS9NgnKjHyitCrAAoGCU9?=
 =?us-ascii?Q?EZtJWldpYBWhhf9FdXP8MAtqbgRUBc2dvxV5/5tlq4Q2N8mCMOLkSQLFNC2S?=
 =?us-ascii?Q?Elw/ybRBVAFvSkYRwY36mNLIdy0G4WWWgEIFGhwUBkF7mYhHTMS+kjQmxupA?=
 =?us-ascii?Q?9ERyE+Oi2M+W/YtORYrT/nPuAURixSnSLoePkd+cjmwnWub7xCx3Ew7XYlRN?=
 =?us-ascii?Q?/P2h+/Kp2RyTzEm8ZHmj5nNrvjlYa+iiD4tmbvWPdxjFi2YzeBaAUYS1o5l9?=
 =?us-ascii?Q?2O7zi1pyMvJtD15fHMKVSZq79ARYnwl0Kh+C6lU+fdlcMFDnezCAXjPp/RkZ?=
 =?us-ascii?Q?8etdnY9HIrc6dqD+cfz9S+t8EMhj95z8pvJxYmnQCxbrA8usNUoYMZuI3Bq1?=
 =?us-ascii?Q?xQLM40G+0++uZgErfOOpj17yDefkbYUfxpDRR3D6KPeQVjNil5L0nVxmWGq9?=
 =?us-ascii?Q?NLvaNQihFKm/jRbPUz32Xs7y1LIQWPjbDdfZP4Cw1g1EZ81KR/H+rlRdoGDP?=
 =?us-ascii?Q?NGM+Ft+AWhCf9LgE42lEPXztoGWLI7dpH19S/TtdPPfKX0tmPgp+l6n8Qome?=
 =?us-ascii?Q?3OoG+fuB80XW2uP1CJ4sRLqrMqwvBimCKgy1yYU/6sOgwz8TY28cCfujK6yi?=
 =?us-ascii?Q?ID2afUOLw3RdQbsIoA1v2DocED5QKlRV9CfLg6EPFfi5STTH7kSmIboPYcSH?=
 =?us-ascii?Q?OUi+rT/lzPIsNQl1TWo1A3GDnXdy2WzCO/r1J/R5COXoCKg/EJRdUNbs+VSl?=
 =?us-ascii?Q?q9NEe4TjNlN1n06ZI+/nW9tjsavNcG28neqoFucuc57VUZ6u/ztcFMKq93I8?=
 =?us-ascii?Q?2fbDUoLz5bqxdib5RpDk/JjWxjMs6pVqSHB+pwMq5QQbytxCVfV3Pxa/uu6W?=
 =?us-ascii?Q?204t5A4q9nFi5ts8M6FCHsda9nZRHDNC0tALgcJD1QEDq/Kl3hRY/rMHtJgI?=
 =?us-ascii?Q?eVa1q0ZtVb2tx6ZMOx6nSuA3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TOeUoh5/uarTvqYj0xXg9s7mUJ4yR7364SXVw8s+sChVz7esOPMi5ngtt1CQ?=
 =?us-ascii?Q?3dwLK/NWtlfnlon3XLWLGcCaNd5AMV4CjDikOyo/T/M0Xr4Ofz6mYqXySGtE?=
 =?us-ascii?Q?EmgliHkeIdO7LFsljZpri8L95494QNIP+LfrBDFFuKlyP06XSFCE1kswUixM?=
 =?us-ascii?Q?8bQCFhic6RdfqpePZCKjjqc/ocAk+ctWQ83JM83Uei98TtQMPC7lJiNomq/o?=
 =?us-ascii?Q?oKq16UDy8QddMP2fD1FJTAu/QZAHA1yF8U1fSgpgqDjbKj1ZBFuJkIUC1Fu2?=
 =?us-ascii?Q?lt0+62nHFenDpFMscBqS7WcXKDOr9hpoItX8mWaY68sANJ/pA3JPfmPVCZdr?=
 =?us-ascii?Q?HKJ859QpVpZddswIun0p8xo5fbyAA91CrnsK5+vbWRpouXpeBm/X2wmuXYFj?=
 =?us-ascii?Q?H3gE18yJB0uyP9o5fypbfaePpIWf43Zs67E7E1+piYEQuA3LFEnclT7IErMQ?=
 =?us-ascii?Q?i9rk2Of+4NOE0V2b8J6Cr5arkTQfh6uwEvvENRwsr7mY956ydUEvE9HAuhtW?=
 =?us-ascii?Q?knO7mMLojQug5Z4w7aKcF8z9P4QN9foHp5gm6Ewo+P4KmvfaGSstfTl/GCLV?=
 =?us-ascii?Q?1msj6VFbf6dZwGrtNCBKEQReDLVB1cWfISS89DKqCQMBpTpHnYYj+/4s1pCv?=
 =?us-ascii?Q?H0AuVshThutXpCaKjtXKutkGVMNdtwsqxJ2CltJVR03q7JeZlDWpIyjvnOHa?=
 =?us-ascii?Q?JHdB7TUT+DckloHiGhNatUKa21mlOwqdLEqaDwBrTjTro3M0Ec6niQPx8Mh3?=
 =?us-ascii?Q?e0jsHaYCD8OkXtg1rV6u21q8eiyaU3yK7peLlCQJAD9F4JVYIGrY8e8plOU3?=
 =?us-ascii?Q?aRXnAG7gll3Qnrquac7tN4ddM4I3Xms2f9A0aP7sbztT/cxUk8bZ42vA6yyX?=
 =?us-ascii?Q?6TOaYe2OYrt2P1MjIhVxrQ5nE7cVNk4ibiEwuLBIppX3tFIziXrLj/4Vf4kT?=
 =?us-ascii?Q?GCDcvLroOmHrd0yHZXeKsEuLp9zj6Tf/hb0eyxEqluBY+TP4q5g/1HGuzfv1?=
 =?us-ascii?Q?U10P54xmWU8EGY71E7rswPsmlduncHWkNG1m7jXjC7s0jevlloPg1Xc2/ISm?=
 =?us-ascii?Q?cZjB4XaYmsk6WydDIS2frFVuqtKaG2GJsmnWfTfMLvtmvf8moGUuxxQ5bblb?=
 =?us-ascii?Q?IK2C1qSGTwdi6Y1y06jKgRFuiZvpv9Umtk902xks4E5JwbGAxGEkgCaw266b?=
 =?us-ascii?Q?8yt9YvySXdQw3Fb+ntoWA6X+ohVKaIbOiQZjf3xZq++PncQMdiB8S89O6Ovd?=
 =?us-ascii?Q?052q/u8fg1dK827aG+3rdJPAMF29jkpJwYX1wl8A79xI17FVnbSkLQE8P7By?=
 =?us-ascii?Q?ZU8R+Hy0OIteaq89Ahs3WSDAn1NOVqf55V1ySdD+qf8xQokCJZZzz19LwMOc?=
 =?us-ascii?Q?yElqITeAcU0acOdAJRWwN/IpA0wCr1r0gEiEpXS8MtibgiD7lpRibR49UbNP?=
 =?us-ascii?Q?FNCOZMEuIoSu/gfCALoz2lQGwxTrnXx7kUnAxOP5pzVFpLEesXZbOfUSjPQQ?=
 =?us-ascii?Q?3WMiC+UYUvo2/cboWBVpsEuzb35pdhMOcygvjldDdcbB17XsAE5okW0XJuYz?=
 =?us-ascii?Q?FYijC06CRmNguBft/wn5ysUzI7oYluS9xqyGx8THaMN3hpQt70FhfzU+MuCD?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c372772c-6129-4db3-c324-08dcf7a3f70e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 22:57:57.8074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fgMxDue5/d8V28yIXaJ9xbBBCdUUSxYMlEHJxh0fn7k84LpZ0sRM5aN10AHbFoT9+F8yZ643m8RvtvCzTbkpIqYbIqP+mcFtR8yewB35E0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8608
X-OriginatorOrg: intel.com

Thorsten Leemhuis wrote:
> On 08.10.24 02:26, Dan Williams wrote:
> > Dan Williams wrote:
> >> Changes since v1 [1]:
> >> - Move the new "locked" infrastructure to private header files to make
> >>   it clear it is not approved for general usage (Greg)
> > 
> > Greg, per the 0day report and further testing I am missing something
> > subtle in using kernfs open files to pin device objects. So hold off on
> > this for now until I can get that root caused. If someone else can spot
> > what I missed feel free to chime in, but otherwise I will circle back.
> > 
> > If I don't get back to this before -rc6 I think the theoretical deadlock
> > that would be re-introduced by a revert of 15fffc6a5624 would be
> > preferable to this reported regression. I am not aware of any reports of
> > that deadlock triggering in practice.
> Was there any progress? If not: given that Linus prefers to have things
> fixed by -rc6 I wonder if now would be a good time to get the revert on
> track for a merge later this week.

Revert 15fffc6a5624 ("driver core: Fix uevent_show() vs driver detach
race"), which reintroduces a theoretical lockdep splat, is my preference
at this point.

Even if I had a new version of this replacement patch in hand today I
would still want it to be v6.13 material, not v6.12-rc. It deserves a
full kernel cycle soak time to shake out issues before release.


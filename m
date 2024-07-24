Return-Path: <linux-kernel+bounces-261158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6CA93B35E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0E21F227CC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886BD15B10B;
	Wed, 24 Jul 2024 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mALA2bsn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29854155739
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721833819; cv=fail; b=Ncl0Aan8XRUsHoHtlHTl12tZ1ieu00CWaUQZHG0i6l6DXTDKSZ5LKBTyEaFC36as7+Jyl/+9EwfrP0Vk4M1j0mtisu0xp76A96Hcu4GSQo+TntU8ZQrjGjg8Uwz51cAJ3fi8cr/qF2TNnTpTqN+LJBuuoxCQDo0n6DOpptPZsiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721833819; c=relaxed/simple;
	bh=qL1tw9h1MJR6UTzw/QNSSw0J7trJ/21jwqBiuTspr+8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nq9QEfQwM+K0CtytCmOpC3pZ3ZeRcwA1fLRA+fNNgr7bFzp4UP7+NTZg+/kaM8gNsbyV49EORUmJxiYcp6gPhNTtO8UmRI4snqvMvk/TzmL0xw8K2gmSMBBu1WmaWnSa6MEUNGhi8pfSrhISPA5Namj/E8tUiekkeSQCHP3zYSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mALA2bsn; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721833817; x=1753369817;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qL1tw9h1MJR6UTzw/QNSSw0J7trJ/21jwqBiuTspr+8=;
  b=mALA2bsnCsg4Qs2yYGObqDl4wbH4yFJ+tUJPEQNA3GqMXmsGEDxCdmzK
   G+Do4mbMk4LlpMZyQ8cuUX7ZMhCpfwR5edZBp9iIhcOdwMVB5nGE4WFNs
   5tCipuxNwDtdvwQOOxqGF8zsGeTVk6VxJd31y79RxM1amSspX5amdk4pT
   f3f4t7uaT0yDGU4N138qT+iy6RIZSGeBmGXYkqwPotjMdEm/33jKgWq74
   0n2J5AuEQx2Ph8yFI7zWyLPAicdAl9VnvM2mJ0QLbA2VngQR1Q13vNJo1
   rAajCHcT5E0kvB5Wuv70VzsRwCwtqnN1wVyWhgZ2OSxhJnxtI7Oby8DXf
   A==;
X-CSE-ConnectionGUID: LVC2xozvTgeM5SFH4mTnmg==
X-CSE-MsgGUID: oBvx0lgRQOCdMqSGQZGong==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19132036"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="19132036"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 08:10:16 -0700
X-CSE-ConnectionGUID: Mh17c5WIQkCD4YjSzhE1Og==
X-CSE-MsgGUID: cPDjkCrYSLWa902VBeVi6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="56933695"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jul 2024 08:10:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 08:10:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 08:10:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 24 Jul 2024 08:10:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 08:10:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tl/dEgyTQ/9RxUzOjRfIc+7ZreHA++GWNQdM5WJDBzkrEtYZ8zuzrGz1Z3NKmulFZkB2YTY471EyyzutXHsD4ttcwvdB9M4ehAMzXgDmGvyyUsOVdZbqnOwpxVYBaTB/V6c9tz/FFlYjwWFs2Ubc7CeEh8RmZsKlkXd+NHBDv4eihAnXaogM5r7BBgPh8fdGSGoP1NOwViyY5OIaCgwQ574N88oJDB7pIIDOio2Pw8m3Xk0bVDYu+neSQBKicO4JiNvb/D6a8mlidlvWL7wWmtsIjOLc+GRPge5ysG1BjWRBP0lFqjG9ws2aitts5b85DfnWrLEc/3CnEwUYLhw1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZfJhR3d+6AYf3IuHj5cCTxOQKu/A/LI3eAYC2pl3BA=;
 b=sSICL67m6e87ItAcZ7A4CoXLiPe+ae/m64zICUHffHEoynr9w57vKxtgxk7ziHPb2X2MuCjHnOf1AzEBOn+7FDzwqzTfs9PO3bvirBieWsBi+nZHKa8KX2w5i5P8LtkXI3ubAyf6X3hvYsfCOFbKvNhm8oMhysBwuUqmHbn8N33BCdiCLiNpZIOpnVyjZVUeVTWeNNjkimNQkTFJF3dgcobFhmbASTkUVOJ5d5ZDyPJVcJPFEjRwYeFNnNKGfcsyc4OpThBZrc0nH0X2Tn2D+Sn25DaFdrc8V853Es2F0CpCYn5E9WEjKDrhQdFC1JlHTNy5YGREcIGow0GTdwtEIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SJ0PR11MB4781.namprd11.prod.outlook.com (2603:10b6:a03:2d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 24 Jul
 2024 15:10:13 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7784.013; Wed, 24 Jul 2024
 15:10:13 +0000
Date: Wed, 24 Jul 2024 23:09:56 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, Vincent Guittot
	<vincent.guittot@linaro.org>
CC: Vincent Guittot <vincent.guittot@linaro.org>, kernel test robot
	<oliver.sang@intel.com>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Lukasz Luba
	<lukasz.luba@arm.com>, Qais Yousef <qyousef@layalina.io>, Yujie Liu
	<yujie.liu@intel.com>
Subject: Re: [linus:master] [sched/pelt] 97450eb909:
 INFO:task_blocked_for_more_than#seconds
Message-ID: <ZqEZRBnbwLBjyJCE@chenyu5-mobl2>
References: <202407091527.bb0be229-lkp@intel.com>
 <CAKfTPtBMdLRN8WVUmvXXZQK5fE_rZEFJenujrxpqWYAQ7b-jBw@mail.gmail.com>
 <ZpFcz7s+R7ay77Js@chenyu5-mobl2>
 <5e97cfda-48e1-4a7d-ba66-33751463e98d@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5e97cfda-48e1-4a7d-ba66-33751463e98d@arm.com>
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SJ0PR11MB4781:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1d2f3a-a946-4a92-9fa5-08dcabf2b79c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QNSaNwAHAVgKSmGoRyQrWiublL4kOvTTAc3Y27xZDVa3L1zCmhnuVcWHsrrT?=
 =?us-ascii?Q?X//NQh0JHqGllfcTA3zGn3kIXPDCjOZH9q8xMKn7r8xWD9mLkHI9BxTQKch+?=
 =?us-ascii?Q?lz4nDkIVoEvsvIio190gq2uTzlOS8IVSdQg+tQlxXZ/9KJyb7qONYaTnP37R?=
 =?us-ascii?Q?VAC4yAUIIxI+Cm6u5Z39kqll7x3kUMdTXhNY13nEhQEr1WtAjrv1+NAHRIyA?=
 =?us-ascii?Q?gVTf4y5hLIv4vq0I0LXfCeSmG8ER2GTNOVgxhgznwZAQa2jjHdgSW46spssr?=
 =?us-ascii?Q?6QuieX3usDz1yNSvw3644yfODrHIZKvWg89m0fLyisnR1obJgDB0aLZpZ3Mq?=
 =?us-ascii?Q?eqqQMHWUPzM22RdmS6tMp0aPx1y9tK10/ffnKN10djVKPg11odYYUo9PnhV5?=
 =?us-ascii?Q?W2WCKrwUw++pXkExjCzSAGBouZEKOry0rPXmpJTKouFdqQVq27TXwf9XkGzT?=
 =?us-ascii?Q?a+Ss3STM2F6z+5IvseaP6dP4EjhS25j8h5kf3qIE9hrBEBa+kIAJvNieRCxH?=
 =?us-ascii?Q?MS3Z5cW9+xc5d3Op1PLd2Js0epCfars5hdAcUUGhwrEieA2nAe+EOPOB+qde?=
 =?us-ascii?Q?pIV0xFIz+q+9dCuf0mJwBLKTm8HsbqMw7FR24DGu6C0diuCpm01YcJbFycNf?=
 =?us-ascii?Q?okEGcXIyiQg7T2kIq1hlgQ1F+ZqvWOtZpNxvbm0UYYaiN3DhuKtCSB9iGIu5?=
 =?us-ascii?Q?fMNMohuQujAl7OFaZDZntEcbUMi5E1rhNTI5/+VYmQkkkPTphGWG/6BDGg5s?=
 =?us-ascii?Q?j+ugv6vECjdDVD3F9O5bmkkYUfmmF1M1puAkogFl4b1LbXK2cJHbj4gz42c6?=
 =?us-ascii?Q?U5cOlGvgGUEToAjzNdHX0xllp5oWIQwqDK+fIHGPfGCMIcwKbGaAuOFf7sn8?=
 =?us-ascii?Q?jQR3Lnc1FAoyAxXvBlYKTSeMNptSa5eT0FGI7isYkhkYnlHzlo5FCobhbts+?=
 =?us-ascii?Q?ZUobEr4XhdQrD5dfnmd7MWYOlBBDfa+nvvMeVf/3KYGPmNm5rSmTQeeUGc8I?=
 =?us-ascii?Q?UBnv+u49oE21Dm+/rY+YedPAS29GO6IYRxE7wLye9SZcYWGMPPhmZqx8vHFl?=
 =?us-ascii?Q?3yidu4IpKPDAZwa7OSw+DUMkwGw88mYoKKLfoSz9YdT5K0XoHq1kGEIhcTjA?=
 =?us-ascii?Q?A5uFg6n+eqBVz9PysSA/w6EGTRpC/J29NvQ66pA/F6MqgquKlEsWeG8cAFtU?=
 =?us-ascii?Q?nOSvdmtO5Q15+UNY9zfyrlC+bGoEC4a4CCydAcX8hw48AxDdtaovY4J0Wg/o?=
 =?us-ascii?Q?cidbtW1e57opxGtxUp7qR3wD8XxSVCPUDYx1jiZFZrILXuVdjIHFwrHifG9q?=
 =?us-ascii?Q?yvVw9/JDCEWNlQ8CnCW/doAcHr3KA6Wgil6djVd3PWowqw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a0BZ1y1Z+Fkxy9ZmwivlH/ebBj1E9ZJCTdaLm+afP7rSX4DrAFWFDadmWise?=
 =?us-ascii?Q?H5/l4PSdO9DaQWcCixqaosKQW3UhO8CVrR0LvOeNymMnYlrzi2DLWE2gJOUb?=
 =?us-ascii?Q?Nu61XNlCm+qLpKQt4Ep9exweXXEl5f6viIiPOBSC69Ija2MC/cAliq5X6DA6?=
 =?us-ascii?Q?5GhJEV7lmL6aZSF3binQpeRapGTL3gaA+JOgc315R5k87CroSH/CJ+aHitGz?=
 =?us-ascii?Q?oR5dXXBEYBFcBJt1ZvXsuPyxtjiktluLhZgSOwd1YfAfzkYPHE81kYOh12/D?=
 =?us-ascii?Q?X3W/0EdTSxX7oAh0MGe5ls7GqCT2bKRdzW9HPDfGnh1FiZO1rdhfl2z04tAW?=
 =?us-ascii?Q?tOxe2bJv8fVAHfyYKbQ86H1wCZ+swIbqa/+W1OYaYKtPJxcA4tUzfsiNX9PO?=
 =?us-ascii?Q?TomqYf1fSIO1vIVGJQNioj2nU3oXigtOf2McNuCTy6YvhcjffJjrSCoMv5VN?=
 =?us-ascii?Q?emjh6BIr9104bidfdeCxTKdKQ7PMAas3WM91TEZ4qLi5hr7lUAr7krlhUbyO?=
 =?us-ascii?Q?v+XMUfkBcolAAnrkrjn/c9abiLvVvKYJl12CMBWQWKI0CXfIkbi2WWw8zSII?=
 =?us-ascii?Q?KkqxO4mFbq9rwJYT5R5eMK0nEOMxpLDO6+7++9QJX012IRydlXdE+y/23OYG?=
 =?us-ascii?Q?jc6ehjmCT8E3/UMqHpAEMZdk4xq5Bs1lDRHtg2jBfOFoFqvAl243iraAvx7I?=
 =?us-ascii?Q?2Htg+5MGaxpiMX5HX7IkzS3tGFBhVQ642UamSpxI+Udn0Ir5/lvHAYfrAFfZ?=
 =?us-ascii?Q?iiIIdu+FzWShTC+EdZcP8gMLoMNEITirnO36lndQ75h1P6qxKQ/4CrcNVmnz?=
 =?us-ascii?Q?s9aujdK4+gWobuKhCpq01u9DYxEMPl1pnXrfquqZNAR3GNZCLxFm7q9kxArI?=
 =?us-ascii?Q?FOohcEWhOSWqJThkA5jIS9AuCfUgai+tC9p8VvPKV7pjDUGp3M5XGCvnD5wt?=
 =?us-ascii?Q?f92wsqpRwDoUjOFgGAefVQ8qXHHNhdM+g7o64EjnRefASexjfEiPVNbBGHVL?=
 =?us-ascii?Q?miymGF1q4cCXiiJFLP03GbrNhQjGxw/CRvO/kI/7cKho0/ZQwkNGAAET1UtM?=
 =?us-ascii?Q?GVcUEyxsOheXEbN+hRKJBJ7LS6mt6yksAgVM8euI+Kn2rQFRdYOgJAKehY/5?=
 =?us-ascii?Q?TrpmW/pRxm6EUoD+dIoEhIjLt4wjORfGnsIZAZWxnYcAmojM5k7Tv+fFfksa?=
 =?us-ascii?Q?ty2FT94UYzjAsvHJED5OR8sB9cP/rYo9X2fGx3AYpFC4Vjv1YzT89mK3o+/t?=
 =?us-ascii?Q?52r60uE3eQuTswFUM4h/qpNjg0VTjzV8+ZF4onK58j8sFnN0Zgd4/SL0XoqL?=
 =?us-ascii?Q?USrijtt9mNASalWWap/GP9LIQ01PsYs0tlbE5pzOvOLFuTHMi+Fs960Us9nu?=
 =?us-ascii?Q?SyjySXGTy+HbK0Q59pxgYp3iqEnnKFxWv/Gcx+kzNc1yYYnYv7taq4+srxQO?=
 =?us-ascii?Q?T0w3eV0DEYxYX2RdYm5mBRCwLZK82ToyQ+d23qPQIHW38J2ktHzd9HiWSPnP?=
 =?us-ascii?Q?W5rZ1rdGeHTTGm/S/OmqtxhzYMmlxHqlOny2SqvO9iOS7fIloeBxNpfMTyo0?=
 =?us-ascii?Q?e4iZGkQeE5o62LLigtqbBZIw7111HGTyDlC5eCgY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1d2f3a-a946-4a92-9fa5-08dcabf2b79c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 15:10:13.1918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AthljLeUAtnrJy16KFupETFzvInWPxxuk6xJN9Vw132mwZzC5v6WQx1PdnTFnvm72XzY4j9LOPmVfJ+UnubYyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4781
X-OriginatorOrg: intel.com

Hi Dietmar,

On 2024-07-24 at 13:34:31 +0200, Dietmar Eggemann wrote:
> On 12/07/2024 18:41, Chen Yu wrote:
> > On 2024-07-09 at 12:03:42 +0200, Vincent Guittot wrote:
> >> On Tue, 9 Jul 2024 at 09:22, kernel test robot <oliver.sang@intel.com> wrote:
> >>>
> >>> Hello,
> >>>
> >>> kernel test robot noticed "INFO:task_blocked_for_more_than#seconds" on:
> >>>
> >>> commit: 97450eb909658573dcacc1063b06d3d08642c0c1 ("sched/pelt: Remove shift of thermal clock")
> >>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >>
> >> First, I'm surprised that an Intel platform is impacted by this patch
> >> because Intel doesn't use it AFAIK.
> >> Then, this patch mainly remove a right shift i.e.:
> >> instead of:
> >>   return rq_clock_task(rq) >> sched_hw_decay_shift
> >> we are now doing:
> >>   return rq_clock_task(rq)
> >>
> >> Could it be a false positive ?
> > 
> > Before trying to reproduce it locally, one question is that, should we use
> > rq_clock_task(rq) in __update_blocked_others() rather than 'now', which is
> > actually calculated by rq_clock_pelt(rq)? 
> > 
> > thanks,
> > Chenyu
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d34f6d5b11b5..17ec0c51b29d 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9432,7 +9432,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
> >  
> >  	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
> >  		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> > -		  update_hw_load_avg(now, rq, hw_pressure) |
> > +		  update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure) |
> >  		  update_irq_load_avg(rq, 0);
> >  
> >  	if (others_have_blocked(rq))
> 
> Yes, update_hw_load_avg() should be driven entirely by
> rq_clock_task(rq). But IMHO this PELT signal is only used on some arm64
> platforms. So you won't detect any misbehavior running your tests on Intel.

Yes, on Intel platform the arch_scale_hw_pressure() should return 0. Unfortunately
I could not reproduce the issue locally.

Since the commit replace rq_clock_task() with rq_clock_pelt() in __update_blocked_others(),
while keeps it rq_clock_task() in sched_tick(), I wonder if the following
code would cause inconsistence in ___update_load_sum():

u64 delta = now - sa->last_update_time

'now' could be calculated by rq_clock_pelt(), and last_update_time was
calculated by rq_clock_task(), and usually the former chases after the
latter, it cause a very large 'delta' and bring unexpected behavior.


thanks,
Chenyu


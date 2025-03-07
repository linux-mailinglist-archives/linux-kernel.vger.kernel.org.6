Return-Path: <linux-kernel+bounces-550455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D87A55FC4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4851B1893ADC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75A51474A9;
	Fri,  7 Mar 2025 05:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c/7hlkxw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A9F664C6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 05:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741323978; cv=fail; b=obBhcFE5ouZAcMx1mvs3XzTXiZBnNNgTCONAslJYq+G3qeFdr/l5AwYcZDW6sE1QDUvnuLq6seDBfgwdSMnkhMjdPsT8M93YLK96zkLR6OhKW6ExfotgztUplUjOWZmQRCaLcp+x/5ygR1oESShE/GNFTDcbXd4ezvZK4+uDXtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741323978; c=relaxed/simple;
	bh=1v+kbtG89bJ2nRjjQ6AiYLtTCAKMNLi2t235jV6YP2Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f8q1Hh/kQXrW+O9AxwxD5QoBdvaEy1jwDbsPnajJ1ttPyPjYMbdGHbUBsXYa+CHPx0kxObw36kF/erguFJtjfAgUW6WqAHCIEfCmckRlSg04Uuf05NlZPWMapqMZwEzjAiLhjhqZ5itt06+42NieH6GFPre0etIUO5reCsY3la4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/7hlkxw; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741323976; x=1772859976;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1v+kbtG89bJ2nRjjQ6AiYLtTCAKMNLi2t235jV6YP2Y=;
  b=c/7hlkxwYIzPhWFoQgLfGpchJbsWulaxAivx/WsF353xT1Oi426mJcmO
   s/rQ2YpTaI+Iq+0Nvs04SHwQqXDcbGWxEpT1MR4EFXFmXQvd7PZxoyUmM
   +CQCHozdUmLsrFKyGyZmyuBCKgbsRrI+m6P9UqcLWiob15fMRkLIodn5V
   yIpNhIoLq2nx3ILgGmml3aCrp+9uf/bqshjEArx5Cj3vf6VbaLtxicFnC
   prcVBklozCcNrOUvHZqOnMC4I2hySLxYcgWbF3s3+1CU03Lqv/oH2QdIg
   /CKi9ZwCeZUTUzs/2iQyH2tLX0t76jwClWW7qB0t5WR52ZWoxTKG1YkO9
   g==;
X-CSE-ConnectionGUID: c8W26DP0QSWoflE0uxde4w==
X-CSE-MsgGUID: qeBGsXS9SMuOEk9f1LS7nQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="41617218"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="41617218"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 21:06:15 -0800
X-CSE-ConnectionGUID: Zgd9/NErSPi2d7KyZImz5g==
X-CSE-MsgGUID: 77q44rdQSBWEcOlVkPf8sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150167326"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2025 21:06:15 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Mar 2025 21:06:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Mar 2025 21:06:14 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 21:06:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cozyHZZoMv5be9n6T5e+ESSFESsTKjfQ150381GTmaRC2DHo6Vn01sI3V+zqT/w2NJXJoP6LhlEEGxrkaZefHgM+pL6mXCF0SVmoxf5U1ZqaiVraTyjt1d7bjzawDO5TjOt3pZ89v5W+Gzr3t1CTBPKtV7mmGRD7uhnx15x2yzDfCkLkVXNew7tCBb9IOerc+rxGdo/RTxsuENJnOl86YDRGZjaAH1iqTrprgYSDONx87POxcfgfqElYYVkOwyL19iFisb+uvDmQdLgpVm2siJ0LhLlk2C54AkfH/BoYUCKddOoRhwfvongaIo+b9iBhA7knZhezH/DFQtj5jbSk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvLwKwgGSwdF2LOPoj/M+CRu7k4XTdncUSqIHvppRm8=;
 b=eB7dcAmUZQoAw+kr5U9rXfYjD7ZJG7guL+6WCJvZ4p3Lvpuzv/Pou3HhNH9o3agWTa11VIupDZCv0BfpOQJIN6eHEKsOv14OBSMMjkR7ZET8yigmNqVKhC9jpfrAFL9++XnNQygPJGl6YVeY1vMoqNbdvAxk04UX6A2Q0nCUCldZalpAKiqNI0oNtn0szKOuq9JLhXSnK1XsCS4IUP0b4jc89FI6BlrS+LQqphfahhJs+0o9jNOJ1nIhhLatmGEh06ItyAb7KIO6mBRpSt8kLs3cWvoa7780ubuNqkAaCE3EHEyZFywW7C6jJuFFchZwwFPeyOmlnMZmBOl76f/+/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7734.namprd11.prod.outlook.com (2603:10b6:8:df::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Fri, 7 Mar 2025 05:05:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 05:05:38 +0000
Message-ID: <563fefd3-fee8-481b-8cd9-c6feb7683a21@intel.com>
Date: Thu, 6 Mar 2025 21:05:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 41/49] x86/resctrl: Move the filesystem bits to headers
 visible to fs/resctrl
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, <fenghuay@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-42-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20250228195913.24895-42-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0004.namprd21.prod.outlook.com
 (2603:10b6:302:1::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 18380587-9912-4983-0e1c-08dd5d35b382
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVVaSlJPODJ1dmtBeW1PYjIrU2dCVkJUQm1RR09xbnN5ZVFYcWVQcnZ4R2J4?=
 =?utf-8?B?NGJWMEFkUU1kcWQyeHUzTzVTT3k5UWJDVFdtK1MwdURoWFlyTUNHdWI0Z1dw?=
 =?utf-8?B?ZnRXWWJ6S0ZsVWJDYldiSWpnd1dZcVZOdG9jMGNaRm15eW1tTm43Q05JY25E?=
 =?utf-8?B?Z0orV2RXeHZ6SHdqSVljNll5MkFkaEl5cEQ3UUNiYy9KTGk3M2RPRWxWOHlh?=
 =?utf-8?B?SldUTTZVZFAvSnpoMUIvWlNvdUhWZGpzTDhjcE5TVTJnVlo5SkJDcmtRbzQz?=
 =?utf-8?B?N1ZwbG5YR3RDTnJBU1AyQUE4NjgvVXhob0RBTzM0K1A4amFidTMzVXlYcXph?=
 =?utf-8?B?V0FFdFhYQms5MUM1ZWJ4ckdhVWFnbkhPRDRHTkllM0svYm9XbU9UV2hrSWJL?=
 =?utf-8?B?YzdrQ0tvUVNxZUFxZHhjMU1xVDhwOGFrTTRxZVhxc1BiR05IbVdramtnbUFD?=
 =?utf-8?B?MFZWbG1FeERmNnMzVHI5bXdqSVNmWXhMSUYxT0QxWHhidjVIa3pyVmxYTWRK?=
 =?utf-8?B?aExyUUZhVGJCWFRUcS9NazRIOGhHdW9HRmJNQ01BRTE3RWdQWmx5NlFQbVBv?=
 =?utf-8?B?RXJXSWovWDNTcnF4Qi9lcStCakNkZ04wcGUyaDI0azlva0RsSHBjSzVYNGR2?=
 =?utf-8?B?V2ZxVm9HUm1pSXRMQVhER1BOT2JMdGNnOEJDQWV0TTZLZXZnSU1qcWQ3K0V3?=
 =?utf-8?B?WlJnR2Q0S1A1cVJwS2JjemE2QXVEVVNvQk0vdzRlSDBRYXQwZXRzL3ZJdXk1?=
 =?utf-8?B?cUZYcTRHcHdGVVNtWHErd1FSUU40RmU1MGZYSG5ZN0NlMGgvUEgyMEgzYnMy?=
 =?utf-8?B?cStJVVYwSWQraEFDelFJdnQrN0lHd2NnZ3JHaVVmWU4zRVdQN2UzWS9ydTFj?=
 =?utf-8?B?QTdMUlNwR2ZQSzVvNU16Rnd3YWRvZldIOFRmaG5adHhydE5NVTQra0RsSm1N?=
 =?utf-8?B?cjRCMmZjM1A0M0tFeVVlUmpDbGFBT01aVnVCcG85S09lbHlvSjNMUkhTSW9N?=
 =?utf-8?B?dDFoU212enhOZXA5S2NDM1RISFJCZjRMUTdmMyszdkk4TWRvWFk2QnhtUVAy?=
 =?utf-8?B?TUhEdVQyRVhaRDk5Q0tGWjNQc0lGcmY5N2FvaFNnSWNHL2lrK3h1ZWhwSU9v?=
 =?utf-8?B?ZE0yeVJkdkRYZHNTQnpVNzV3NTBuU3RndGMya2k2US9NYVB2c2RuMHIxbG5P?=
 =?utf-8?B?b1pVeWwvR0pKRnpMRmVia0g5QUNWYk1vZHIxNVlyZFRUTVFEamo5cG9VN1Vz?=
 =?utf-8?B?THF1d0k4a2JDd0Nha1gycGhkQVVpOXJKT2lqKy9Ib2FjTnc5M1FVek1BU1NB?=
 =?utf-8?B?THpxU2g4SGJWUDY5YVUrbnlJMHRGZC9vVGZYSkhDekZMSEcxbUJGRlBTZDFV?=
 =?utf-8?B?dUliNDgvVWFvUDBQNjNIMXluSkFrZlllQUQzMUV1djdiRng4bFRuK08vZHlW?=
 =?utf-8?B?WHRrVVJqZGw0MUUwUmgwWUNJY3RMMTh6UmFGOTZVR2wzTDRDaStMTHZKazh0?=
 =?utf-8?B?RFVjMzZPU0xGR0crYWZpVndQTkg3QkIzcWk1YmJMOGo0UGljbGd2MlZTYWsw?=
 =?utf-8?B?WmlpVzhlVitDU0JYZnNSMHBCOTdRL1FRalJNNEhSQ2k0MHBYRlpiY0dCR0ph?=
 =?utf-8?B?ZWlqTmhvZEhFZGJhaHJ2NEZsUE5uT1RtVVhJZTNEa2R3bnhJUGFDY0VuZVJS?=
 =?utf-8?B?K0hNbzJodHhjSjVPcC93bmZoSk02RGdUZHE4dGNBbW9EaWNFSnE0K3pNeFly?=
 =?utf-8?B?eStEdnErVnNTQnVTQ2kzeFBWWldBUWw5NFNrcTdRZTdTMDhSdk9lS1JHb0Qr?=
 =?utf-8?B?QXJNK2U0T0RpdkhjRkpqZkxVS3BUY01aa2dyYXVxNUMzYnZoaGdCWlpTazdx?=
 =?utf-8?Q?x/yHNLD/myby3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVNiNWI5TzM1cktHR2NFeE56ZFFXTDdnYk5vSW05eXdZZ05Ja050VWlkdzEz?=
 =?utf-8?B?SjBENGIwckg1VHdodjRtdnBQTit2NmYrVjlxekZ0aFRkYXdZSU5YcG8xYkRs?=
 =?utf-8?B?bFFjeWs1cGJUbkdoWVVGZDZndHlqNjZTQWplNGtNWkhRMXg3ZUZ0L0hqRWx5?=
 =?utf-8?B?cGFWZlNkeEFDZm9Lc2NjWGx5NzB1bHF4cnI0RE9YNWlmTXVvSCtlOUxYQnpt?=
 =?utf-8?B?Z3drUlhSZk9hZUVud284K1pkRnBhR1lyL2ZNbENnZE1xYWs5WThSYkdhQWJZ?=
 =?utf-8?B?SXJ2dnp6THBkRktsSDMxTExCYUtZRk5Tckovc2RRT0tyVUVpb2lWajNiUVdT?=
 =?utf-8?B?Mnd1QUJrNHJaS0xKUlg0NmVoNzdhdGVIbEdBakU0eXZHREhiQ3lBdlJpWWlQ?=
 =?utf-8?B?ME5FaDRsM25oN1cwa21hNk5WYWxSWEFvVEVVWnRjQ2VlQ0M5K3JyamlJbG4y?=
 =?utf-8?B?Nnk1MVc3Ni9vQVo5ZWZqYVVJbXh6RTlQODZydCtQTm43encxRk43Wkd0K3pj?=
 =?utf-8?B?Q2FHa1IxR3lhN1FpS2xsWmdXR2xRZ2NGbGFhOE1yN2JWNlJXT2pBQkYwelJE?=
 =?utf-8?B?aHpMYmxhUUJJVU90M0YvMzNmbldEbklHdnVBMEUvTFRBaDBJWU1wMlZxVkQ3?=
 =?utf-8?B?Uy9RcXNRUE9USkVtOHFlbFBTRmhFWHI4ZEJIeXM2Ym9qYlBocnlxb3lnL05x?=
 =?utf-8?B?OEk2T2ZuQVVYQ1B0aitiaXhnZXVSOTZoUVBkemlsdnRCREZiczVxVzU4ZWxa?=
 =?utf-8?B?REUzS0xwTHZjY0NERWFJTEJLZi9ndUFhR05YSGx5SlAzZHpSTnZVbmV5MUph?=
 =?utf-8?B?b0lTVHREV1hTempjWnptQXhzRStrYm1lOHZJbzRwVGxWSlpCdGR1c05XL0pn?=
 =?utf-8?B?UldpRjNUanMvd3M5d1VTQlYxRDhwblJ5STVBUmg4NEs5TkpQYXJkc2VRZGhC?=
 =?utf-8?B?VG1oR3dvQm5ma1VVdFhUbXYvMUhuVjROSlVSRVR5MUxFd3E0UVVBK1Jub1Fz?=
 =?utf-8?B?SWJoTFBYa0tTSVphMFpVZCtKalNERXZoaTg2Z2wzb2xOazlHUCt5UFgwSEpP?=
 =?utf-8?B?WG9aYzVnVGlwQUliUmg0UkRnaXlwRTF4b29MV2xmK2kwdXFCQmJwM1g5dGhR?=
 =?utf-8?B?czNtQ2ZQbFh1dVVmcDZOVEhWcjFUb2JjM2JWS3czQ25wRHA1MkdSWDJwaGtW?=
 =?utf-8?B?RmxNb25JdG5EN0dxK1M2K3V6VnFwUmVLaERZTjQ4ckY5Tk1ZVXBtVWVoT3Za?=
 =?utf-8?B?MS83dUR3bCtKYTBtcHdNaUM2cU9LSDE3NFFnNWxtY2pNUDdwaUpCaFFOS2dS?=
 =?utf-8?B?ZGthNlVrOVBuQVVKcFBvUWVVdk9aRlhmODU0bW45cjJERlBaWHNVZ3pBekMr?=
 =?utf-8?B?RmF5Sm5TenhlVGFYSXF3amFmdENGcUt5RUNpWUw2K2JtbEhTeUt5ajg4b0lt?=
 =?utf-8?B?OVhwcGd1NzBJOXh6Zll0aGFNRjRWeWI2VFlycDRPbUJuOFB3aVRTVmNFdkhG?=
 =?utf-8?B?OUppTHRkN0RVOU9Ea3dZRlhyQjdwcVVDY0d6ZXJGWjA3SU9YSllvdmk4WXlV?=
 =?utf-8?B?NnRJUXBBRzZmdG1Jb3ExS0pSblM1YkYvM1hlY05iNWUrUFFGenNYSThJd1hT?=
 =?utf-8?B?UkUrZm9ESzlPcHJBY21zeTQzUmsrVm5CZEJ2cnRiNXoySnllekdLbEJGbElI?=
 =?utf-8?B?SG4yZkFGSWFuTDNlclFqZTYvd1B3cXN4YS9iWENhODFSdnNPVzhubE9HWURJ?=
 =?utf-8?B?Y1NZb2g1VGlUSFdYbGJTQXBsVXhzVGtVbGZidjFoUnJiUzlDdWIzTFBHVjZB?=
 =?utf-8?B?czUrTUNZWHNxVTUyRWE4UFpwcDI3ekVsb1ZzVS9saHQzL0tWUkRRL0NLOCtR?=
 =?utf-8?B?K01HdUNXQm5CT0wycUY4Z0UyNXQ2enNsRFRuaVNPTEptRVFFOHhhSGg4RkRw?=
 =?utf-8?B?WFNIQlBkZTdnTklnRm4vUDFFRnFGa3ZEOCtXYVFKSUFhbEprU1RXcmRqZlFP?=
 =?utf-8?B?QzRNN1MveWtpblVvZHdzVDU4QVZnZzBtVVVxTVpobUlsbE12T2llTWx0MmYx?=
 =?utf-8?B?TDFpQUJOSnp5dEVYVDJoaXVWYlRVbitRVjlaR3hyZG50OWd1YUhXSFNqZyti?=
 =?utf-8?B?REFrRkJLUmN2R05nSkFaQys4aWNTNkNXclV1bHVsMHUxM09TRWcxTUN5UjZC?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18380587-9912-4983-0e1c-08dd5d35b382
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 05:05:38.4116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2iPrjHrCY3TzGKH8svj2DZNmTakEsBPGkMsIEz+oqmz3yQyBFEnPDxGwIlNPwPBMhpBqadbl72dPsHyX6dOHNFcxvQmNFUK5yQ54qm/EDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7734
X-OriginatorOrg: intel.com

Hi James,

On 2/28/25 11:59 AM, James Morse wrote:
> Once the filesystem parts of resctrl move to fs/resctrl, it cannot rely
> on definitions in x86's internal.h.
> 
> Move definitions in internal.h that need to be shared between the
> filesystem and architecture code to header files that fs/resctrl can
> include.
> 
> Doing this separately means the filesystem code only moves between files
> of the same name, instead of having these changes mixed in too.
> 
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette



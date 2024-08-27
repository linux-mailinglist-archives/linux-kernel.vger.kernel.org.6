Return-Path: <linux-kernel+bounces-302943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970E1960559
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7962811D3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7DB198A34;
	Tue, 27 Aug 2024 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kbifdpgh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CED76056
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750269; cv=fail; b=W4qlnHa97l1LU5fT+dJtXsiT/NsaBAgPdp4NsW3KKNHp5GxtiRrUQDXobC71jCZWnM3ZrUoVlYeDXpJWfn7yP80hPNQNN0axkCbJvIqQHNQS5OntNE43nzTxqN/mTdaCnGQAX5Imw8gCIAY+PyI4QxdMQY3xFY5e8Achu166BZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750269; c=relaxed/simple;
	bh=8LgNCY9bj9LOFnvpMoSjqAwneJogZZi0zJZNa1GVbI0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mtXxxMyETYLqXoWKrlUd8gNMIkaeTEt2Xyk/T4/DyCh2ERk97m1m4ppuAR9SlErNjLm8YTMcFOnXfR9xz4kfkq1Z8Nnlx14cb6c2DZbuDg6DrWPjTORzCWSGcvMe8Gzpndv2F/s6kXZ2hswq1VR/BheIk0oZB7otMTvIneNdltE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kbifdpgh; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724750266; x=1756286266;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8LgNCY9bj9LOFnvpMoSjqAwneJogZZi0zJZNa1GVbI0=;
  b=KbifdpghIxyGBv2I+8Ivqzo9vPhtGguihwSfxdQkl5jfRGuGYo1XUP78
   b2lsqy1XJ9PcoBDO1yMVZvuURN39ug5PWSpxvfhD5SoJINp7+irIEgjau
   DPUcJbQzeKGbb8xNP6QCzZSAde3IXlDnAbBhXDPDjokUGdRC/wVvc6ba3
   sd1d8/xDjiFVn0H4PsWruZfp/pr9GQrgDms4ZHgK0VcT9LcB6Ml8IW9a4
   /3Ye0bs44Ww6fn2Ufq/9N89j7kkcTKudaRTitI06OHxVkytzSl1BiN0IH
   zbqKAr5xNPTGaJtzUrcmEE6zeZZylQWGyO+3qJNVkBP1H1ZujrddYWXu0
   g==;
X-CSE-ConnectionGUID: 6IeZzbq4TB6beci47NDpUw==
X-CSE-MsgGUID: nqwBjVi3SYWLjJ1519MjWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23394161"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23394161"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 02:17:46 -0700
X-CSE-ConnectionGUID: hW2rTGdPS/e76C6hGBOi9g==
X-CSE-MsgGUID: 36YkCZjsQEugKJhOumuotA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="100307095"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 02:17:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 02:17:45 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 02:17:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 02:17:45 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 02:17:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hK9Z+yoqW5S3FwSqllCCG5S+yNkp7zONz3ENom7KcmdSNXL3JISphXmbwegZ8Up/DbZ2JFb211/hF1wakfJFwaNOBZL1gKWd8ocxAkoMoRF2SLqWfXDNCTgSg9M+meByv1jENFa/jR6m2hyUCoVEvlBBLXJDD2wYISreecyO9GDYLWIvsbco8ZeP++Yqd3jhXUBOqZ46cmvX7cQLl2Gxk7MUfFpgMmFwLo+oFIpIndK0rB9R9NRrgkVJLabpyUzGep79Tol7/xXpq82+YJmwF9gYAXxra/FCDTkzc9haSo3OMRxjzP2VNLbYrKyK7vD/dKewZTvxSK0nqgA4DruJag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwNtsfKkkpljtaa0lR61FcQbw1P5Tsx5WQ52c7uPra8=;
 b=fNp7wW+reg4aJZBcT8SUrXYkbbOPmjDElxlIfyQXClGtvyey30c3DTG2yXhsH5hC6TEcFJiJ2w/SHWRTdS7uuyY9OtDaJyfuvgLhwYWl80yqUMI4joFwbgbxRmuVqxdVjVzbevYrqXF4icWcSWagUFbU24edjBmjkGWgiggFrRegzb7XL/DGD6w5OhV39dwSgxusJHCOrODXFRXi1TSxfpdoxVRahHTZSKtZzSsyn//+I1lgGUQEG6VtNrUGes6QI/gZbAdMRoRiwGLgBIrsJJbC5bUrzUR/MhpZk82M/Z46IVxsHH9QciI/OcTlY9GkO9F6RzopIKuxIrucz07lCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SN7PR11MB6969.namprd11.prod.outlook.com (2603:10b6:806:2a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 09:17:37 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 09:17:35 +0000
Date: Tue, 27 Aug 2024 17:17:20 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <mingo@redhat.com>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kprateek.nayak@amd.com>, <wuyun.abel@bytedance.com>,
	<youssefesmat@chromium.org>, <tglx@linutronix.de>, <efault@gmx.de>,
	<tim.c.chen@intel.com>
Subject: Re: [PATCH 12/24] sched/fair: Prepare exit/cleanup paths for
 delayed_dequeue
Message-ID: <Zs2ZoAcUsZMX2B/I@chenyu5-mobl2>
References: <20240727102732.960974693@infradead.org>
 <20240727105029.631948434@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240727105029.631948434@infradead.org>
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SN7PR11MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 424afd0b-b6a2-4304-d2ce-08dcc67916a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hJ3MlKtqrN2i7G4GLR9quJwKURpIGvHnRswt/8LWSNIkQugY7DcNIi/5oQkp?=
 =?us-ascii?Q?+mPF/j6GA2qR/S3PpYxba1QNGBw9QEW237sv/EHNXkkNC7+GeKZsE8vtUpw6?=
 =?us-ascii?Q?mJJUxBUGKjq+8/627MY2gVTemeijGV4MZ8Nnckeah2ZGoQFrzq6lWMizZABl?=
 =?us-ascii?Q?lJqPVR5CQ/yPdx7ZJ6O0LNH4HEgCx/ggz7ojncObtcA57t0tRihvraPdZmoF?=
 =?us-ascii?Q?zf8KodoaTHKH86Bav2U32KVvsWhmsF7MQSbYrXgS4JtIW2swrm9TKyu6xWPB?=
 =?us-ascii?Q?oVMZ5Hh7W7JcLTjYVAHUsQnKi6Vh2Pp4RqQoLTlGKpoCQsAiDAOGhPkBCY4V?=
 =?us-ascii?Q?SySb+5LGw7V2rFAvid3YcpghH1yq2tjHdEIFk879lLlKt5GlZHauv9gbxuYx?=
 =?us-ascii?Q?8Mm6+fTj84kqxhBinCTYOqvUthXU7tpnJGXM8MS7DlutO+/TieJapnHjm3lY?=
 =?us-ascii?Q?HvW4LX7oh4EC9FRSVokTSvUJy0gGBtO9aUO3Xs2+pSs7Y2/X2OkeUMOvDqY0?=
 =?us-ascii?Q?/3eG/F/RDovy5gJD1FQDeWVxxEEo2RcWX2ygjBTsZazMSoAo4tK+KkM8ap+g?=
 =?us-ascii?Q?7JDXvTj5X/8OdIOB4NVW9ZjpXS1qSiTmigymdDijm8C/useAOA8zUUliRBaI?=
 =?us-ascii?Q?q+4hjnOQQvniLrVxl6z0A/+UB1jIdyeJCKX+DTb+la+u5+ciSpBQow+f8ix+?=
 =?us-ascii?Q?Ec9dxhi19v9CjijQ0XStUQ13Xs5hkMtjOeneWXpTu0+v+SeEz1FoElD4JlQk?=
 =?us-ascii?Q?W86qRmsSgw4BWUtfEJEWfNIo+2IBKVxqBU18nhMb/fPfRn+nO/H1h2TuzCAc?=
 =?us-ascii?Q?5JeTGj8raO22+QnDKn6UAJ76rB9/3g7dxq4SFx5Ngw1gYoHJCHqgeXyl7TOx?=
 =?us-ascii?Q?+dkYrubhkf8kF8RBMdJ9JohtgeKVKfVLNHk5URcJdtuJtUIALqgjJM58vCQr?=
 =?us-ascii?Q?M04j6FjgswYXvk0eDI4HeKBdeqc+I8qt79dR+9fwDrd7uBuHdyRUEu5w0B/m?=
 =?us-ascii?Q?dTNHCfoXcqZKyd40Qjqjgs4yjPz7TNNhUhOSOLdxNPDVPJZXoz+dxyItkoty?=
 =?us-ascii?Q?8g/lJVo6n9XbwukPjmSLUW13HbyV4QmSy8xhdYucJKmE3edESDp49u/Bitdk?=
 =?us-ascii?Q?3nEVaUzboa9f0VdRiHTKZW2J/HXVuubjT6ZQod+XeW+APZDYwVg96uM8iHcx?=
 =?us-ascii?Q?kr/7vFGUcfSs0dEqxLxXqvS6xGD2XSkUnAl9oOuGScIobKJCFc3wv0rQ2GJp?=
 =?us-ascii?Q?ihMummUUdIfUa5g2dvt0k/V02wCwTj9W9YUWcyIzvz5bc2toeQLvv0+9JCNk?=
 =?us-ascii?Q?XxOFlrzjK+VxlJEazmMEHDZr1o6Z7rAytVwsPcg6lLSQThmEeSamgdJatPkp?=
 =?us-ascii?Q?KbgNHkM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z0SqiWemi7R6nMiw6IPVTCYjJ3EjoSBLLlJXE992HR2tQ4TrG5TtCUe6hx1N?=
 =?us-ascii?Q?d/xRkSE/QY6DuDCLE9cV58D+sqY9YTjr+jdmsTDJV4FkjNGL6Nwcis8xitFQ?=
 =?us-ascii?Q?PQ8vICnoaJjWMLt8b1/Z6TdqprweGoe0yt0EZ/avapYPixxD1j9qBpT+txzJ?=
 =?us-ascii?Q?+tDoj7n7BfZ5FfN1mdkqGtI5OACM5ekAeiw0gYYn5fDc5sBYIo5b1kTZatsI?=
 =?us-ascii?Q?pCGNi85egmOK9Nd6jhCYbuYNJXnD6C8hff8aRW/P+cVMlBxUnpVU8MOXTi6Y?=
 =?us-ascii?Q?TEtSHc8AihJzQSwnCba5M26EesdJ2nXsKv2iWmN2MeUjakXBQROtYOdVWI4/?=
 =?us-ascii?Q?Bpat+ln7I9yZVQ7QVSgjSUwJw/Whk6ngVQJFq3Rp9B2D6Bx2MlH6mAVjvPxj?=
 =?us-ascii?Q?Z3ApqEk2t5cqoZfxiCyK5FGwbsZZzLOz7U86jfdUa6rzzN58bjs5Ko66utIp?=
 =?us-ascii?Q?QRvghrAYTzYWpQPX7uFiSZnHskkszrC1Ok/GejJA1u7QGKzgZ4kbeNDGoAeA?=
 =?us-ascii?Q?w818nol9t28BhjmhGN5Tpq+6thbBlpdDXfvjK2d2+UkghVILR8qgF3HR5pUv?=
 =?us-ascii?Q?dPwRSnEACrTXAiVccw45ALfASU/Xxpy2IgHi+qEzZN4w7BXIDr9xQjbxpQVa?=
 =?us-ascii?Q?o2V7XTjDvuQcvAXbfoxq5II8BacUfvQSFE91cIiN4C9q1+Q9ZaGqKjdeDLXG?=
 =?us-ascii?Q?DmENW82TT6PfIKCyPXiFTLFEg9YbOpGbbpWJ6pvQmmK3POHGHSyJPTpOPSOh?=
 =?us-ascii?Q?PI0oOBRZT1DeVid1Yg6zg9AvtZKF2Unor1lDQvbjaYrbcoI6JoQ9HZHuvzAx?=
 =?us-ascii?Q?lboDjN65mjzXmJaOrZ55XrjPzAlKr+3nDtP6QI7AXERW1nmmBabLIJx0dHIf?=
 =?us-ascii?Q?lYZ62AMJ7x69RpgnIgRYy4Hjse3MpZ8EtlhWTKoG/dbVhcytIY55ECGjXFgH?=
 =?us-ascii?Q?Y8pNSLTnTmSg8BhasT+OiYrffquLzhdYXxOCTIgwQ7Z1M1CSgCcXAhkiYNiA?=
 =?us-ascii?Q?I3q0jAdhb5URrJJj99uwAD+tHVdIOI4r78dWSFwoQ6tSb6JjLROStRuozGRS?=
 =?us-ascii?Q?GFhM/ug9caQvLc1Ye5PeU/e5Pl1EmCaHwOGTGvtktwUIJX/Tp8uqrrF2EYjf?=
 =?us-ascii?Q?FiCpNOBXg44fH65HL2o3abAindtLz2YUI2Afr3qAs43u2OAVvYXXNFWyUhv6?=
 =?us-ascii?Q?Sm9R+9f8ypLjtr491RxOMnNtrMwZUm6rwvj9alHmpjouHg1PUwWPqgaVeA8z?=
 =?us-ascii?Q?ynxnjWRqta6I0D8kde5D+DxcftsHFCiLkuhbEW2wI6s1Tl77WhoXct4Pai0b?=
 =?us-ascii?Q?FDJFKeS6Gaj2d/yvXbiI/yezoHvrt5uvIArUu00e/zF9BjDfuMiCi6siDA3B?=
 =?us-ascii?Q?pL3/dDc/mPy3KyKfbRO+SQRz3zcIDH08sdI50I8zCqKItwOXuNXpdsitoZJ7?=
 =?us-ascii?Q?9BsmKkoVOa4RitlwW+Ki4U6XByOrHJKCf2lU2s2W/O3y5uQJ9Gi8TuygQ7Vx?=
 =?us-ascii?Q?J0MOe+eSxdusbD5RwK5RW1BcA7Mnqz9gNwHN1nMTFgfvHuFegEPJe/z8Iv3v?=
 =?us-ascii?Q?yuFiWmmwdjUpHwtE4yZVeFZnCOS69tQ5Yln/hlmg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 424afd0b-b6a2-4304-d2ce-08dcc67916a4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 09:17:35.4775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whaoi47ckoKIdZlQ/v0s72QxEPB7XU5bLtgKESq4o262QWe2OV/YH0PAgAiKLqnY+v5tFUd6J+co6t4LK4NRuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6969
X-OriginatorOrg: intel.com

On 2024-07-27 at 12:27:44 +0200, Peter Zijlstra wrote:
> When dequeue_task() is delayed it becomes possible to exit a task (or
> cgroup) that is still enqueued. Ensure things are dequeued before
> freeing.
> 
> NOTE: switched_from_fair() causes spurious wakeups due to clearing
> sched_delayed after enqueueing a task in another class that should've
> been dequeued. This *should* be harmless.
>

It might bring some expected behavior in some corner cases reported here:
https://lore.kernel.org/lkml/202408161619.9ed8b83e-lkp@intel.com/
As the block task might return from schedule() with TASK_INTERRUPTIBLE.

We cooked a patch to workaround it(as below).

thanks,
Chenyu
 
From 9251b25073d43aeac04a6ee69b590fbfa1b8e1a5 Mon Sep 17 00:00:00 2001
From: Chen Yu <yu.c.chen@intel.com>
Date: Mon, 26 Aug 2024 22:16:38 +0800
Subject: [PATCH] sched/eevdf: Dequeue the delayed task when changing its
 schedule policy

[Problem Statement]
The following warning was reported:

 do not call blocking ops when !TASK_RUNNING; state=1 set at kthread_worker_fn (kernel/kthread.c:?)
 WARNING: CPU: 1 PID: 674 at kernel/sched/core.c:8469 __might_sleep

 handle_bug
 exc_invalid_op
 asm_exc_invalid_op
 __might_sleep
 __might_sleep
 kthread_worker_fn
 kthread_worker_fn
 kthread
 __cfi_kthread_worker_fn
 ret_from_fork
 __cfi_kthread
 ret_from_fork_asm

[Symptom]
kthread_worker_fn()
  ...
repeat:
  set_current_state(TASK_INTERRUPTIBLE);
  ...
  if (work) { // false
    __set_current_state(TASK_RUNNING);
    ...
  } else if (!freezing(current)) {
    schedule();
    // after schedule, the state is still *TASK_INTERRUPTIBLE*
  }

  try_to_freeze()
    might_sleep() <--- trigger the warning

[Analysis]
The question is after schedule(), the state remains TASK_INTERRUPTIBLE
rather than TASK_RUNNING. The short answer is, someone has incorrectly
picked the TASK_INTERRUPTIBLE task from the tree. The scenario is described
below, and all steps happen on 1 CPU:

time
 |
 |
 |
 v

  kthread_worker_fn()   <--- t1
    set_current_state(TASK_INTERRUPTIBLE)
      schedule()
        block_task(t1)
          dequeue_entity(t1)
            t1->sched_delayed = 1

        t2 = pick_next_task()
          put_prev_task(t1)
            enqueue_entity(t1)  <--- TASK_INTERRUPTIBLE in the tree

  t1 switches to t2

  erofs_init_percpu_worker()    <--- t2
    sched_set_fifo_low(t1)
      sched_setscheduler_nocheck(t1)

        __sched_setscheduler(t1)
          t1->sched_class = &rt_sched_class

          check_class_changed(t1)
            switched_from_fair(t1)
              t1->sched_delayed = 0 <--- gotcha

              ** from now on, t1 in the tree is TASK_INTERRUPTIBLE **
              ** and sched_delayed = 0 **

          preempt_enable()
            preempt_schedule()
              t1 = pick_next_task() <--- because sched_delayed = 0, eligible

  t2 switches back to t1, now t1 is TASK_INTERRUPTIBLE.

The cause is, switched_from_fair() incorrectly clear the sched_delayed
flag and confuse the pick_next_task() that it thinks a delayed task is a
eligible task(without dequeue it).

[Proposal]
In the __sched_setscheduler() when trying to change the policy of that
delayed task, do not re-enqueue the delayed task thus to avoid being
picked again. The side effect that, the delayed task can not wait for
its 0-vlag time to be dequeued, but its effect should be neglect.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202408161619.9ed8b83e-lkp@intel.com
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/syscalls.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 4fae3cf25a3a..10859536e509 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -818,7 +818,8 @@ int __sched_setscheduler(struct task_struct *p,
 		if (oldprio < p->prio)
 			queue_flags |= ENQUEUE_HEAD;
 
-		enqueue_task(rq, p, queue_flags);
+		if (!p->se.sched_delayed)
+			enqueue_task(rq, p, queue_flags);
 	}
 	if (running)
 		set_next_task(rq, p);
-- 
2.25.1



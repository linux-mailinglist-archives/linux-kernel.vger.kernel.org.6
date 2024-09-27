Return-Path: <linux-kernel+bounces-341359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30BF987EFE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE7C281BB7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 06:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828EB179647;
	Fri, 27 Sep 2024 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="baAYrfza"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2A4179652
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 06:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727420201; cv=fail; b=hhELt+txCiWcwxoN9DoJvRfkLBEMJJJ6Gl6PwkAI2Njnpea0ovfeMtSG+ja0Jkd7ToGEE6SXKBW/+bKP6V83Vxcx6gu04b6Jgvn/lqVya/EnqEhfc8JlpjoWUnroIwtfLkzhV4Lo0sv/9V2ZdNRdlLQ92kEsLQE1FhGoEOx2CKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727420201; c=relaxed/simple;
	bh=6MpUKYwCfZ3w6ZSsXWzizMcCe8HQk26DzM2UbdlQ+0E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b5hPNJRKfAjVsFEGxmj5QaPiC3I33oVkD6t/7Nx+ZXFQ382Vb4JNEuzV/JGMxJQm7U9BwECG0qRl8jQr8sOS1mjhnpQEGVmd3NBnA/8Tp+YsXdc8Ky8yV7HpWgqgchNr6qKGJaLv57/tCu9TolOdUhHzv8w5wihHw99lRUl16pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=baAYrfza; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727420200; x=1758956200;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6MpUKYwCfZ3w6ZSsXWzizMcCe8HQk26DzM2UbdlQ+0E=;
  b=baAYrfza4Kd15C9NeBC3dn04/l7VJUsuJRzT49zvBikrfSfhbCsoeuyA
   DEl5Lq/SQAIIyYREu/jM7RK+P2PoOxM7lCewV53ouP6bs1xbfKZpMdkGc
   QpRJzGoxJLR+ziZSpuebjC4Ur/Y2gVpsZU7G7KV4x19JODeLYqeR06z1r
   5xrDwFClWlm/jiNiDQPD0tHV6SfDNNLrGh22zqpaqIoBI3F2SutcNyx2T
   9lPSaqBPT4nBiPlTafffzCtR89y/Qjhdv8mOotgsLvNo7iDDZVkkVo9wD
   lsxQt33wRdW37mYQxmp8IhePZpBGvLO+ikv/huniN+iZ2wZUzoCn/xGVP
   g==;
X-CSE-ConnectionGUID: 1G74hDLIRKKjzBdtdKVbyA==
X-CSE-MsgGUID: vUXIAEtRRGOYBd0Pl/jeJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26357305"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="26357305"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 23:56:39 -0700
X-CSE-ConnectionGUID: xFlww93SRI+wUWXPPPQm5g==
X-CSE-MsgGUID: BiVNccdxTROZWu+alPABGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="76807804"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 23:56:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 23:56:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 23:56:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 23:56:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 23:56:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlcaU2SQiwBl1I5NjV1gp8IRIL8fJRxjaSD73FTpdvN/Fw4CWfLK5WyGl/ZTuHEULiQt3oyJZLR4RNwL8MewuHkJrVTHjVtRH02W8pN97SoBKfEnoP2duXN2SMELClONk6gvFpJIr0Lq0LrmBY7g3A9rQLS7C05Xqm+5aBkiV1SUvslqHQ5GxdcH36jSVBspEh5dc39BatPMCe3BU7OQVoJY04a24AsDERHRgiY0PwbS6vPu3W6WT4NliN3hIzeoyLlh7Dg/cmT4QlDp4QvQKvQxR4XWoajwfhm8sovrg7ovW9CuxqItR+DUSMzUQyYZ0Lmlv3jhKRwptU1bKutM7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEkZ67Q6RbkknWOeIyNm/8yYMbnV4fmSW2yJCRtkjmw=;
 b=apP/n7SAO8xB8dL28v50RAtKapgO+9uxMop6CV+W7I3bZMfMptGZaxKEQZs5iMlnG5vGb3wyZ0BVrmXo/80h5VWJhzeDc+Qbl9E50xyIei27Ze0GBdVTr4XH9MZ9756TsTrvVxIwA8MOZ8avJDUDlG6uHFHceJcmB5zrzv2aas4q1bj8GrF7aGM7S8TlhALcniW3LWtDxnGC2MQvd8cwscWfbxCJddI7GQoymw1lGmdAVe02urwIkiQ+EcPl+DpJh9eCtrKanUU4XkRzBnO+JlmmBNLcHp+YUI3Lbi33QlrhqHPiqGqsdvUSJOYG2k4gsgoAhmwzE5nHdB3WHIK45A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DM6PR11MB4641.namprd11.prod.outlook.com (2603:10b6:5:2a9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.22; Fri, 27 Sep 2024 06:56:35 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 06:56:35 +0000
Date: Fri, 27 Sep 2024 14:56:18 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Honglei Wang <jameshongleiwang@126.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>, Chunxin Zang
	<zangchunxin@lixiang.com>, <linux-kernel@vger.kernel.org>, Chen Yu
	<yu.chen.surf@gmail.com>, kernel test robot <oliver.sang@intel.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>
Subject: Re: [PATCH v2] sched/eevdf: Fix wakeup-preempt by checking
 cfs_rq->nr_running
Message-ID: <ZvZXEqNLcJxq+8Aw@chenyu5-mobl2>
References: <20240925085440.358138-1-yu.c.chen@intel.com>
 <fea9b64f-4ede-475d-8788-73bce88b2e3a@126.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fea9b64f-4ede-475d-8788-73bce88b2e3a@126.com>
X-ClientProxiedBy: MA1P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::18) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DM6PR11MB4641:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9e2983-40a8-4f57-0e90-08dcdec186e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4hCzFR1ukhqZBYSC+Ani8vq0MmgqQOfXpipZFLEIRLi+BzuXD8Zs7TamP79f?=
 =?us-ascii?Q?XELZzNiGE3ip/vzaDJjdSQExfUD0mqrU3wOGeEFIws2el5t5Bu/J9U9F2vOY?=
 =?us-ascii?Q?bhEf8xJh6qJARQz9w3WS+2U40MUjRfsHajXx3QixlIW7eHQ7rM9DCLWPjj6S?=
 =?us-ascii?Q?srVCRVmtFaYGWPxLCxtPvZWpOFpat/Col8D30gJ9bqrlaAdf+ZrujlAV41XV?=
 =?us-ascii?Q?LjjeT9KDLOmg+js4xPY0uxT1nj16uHdbw3qkV/uyrKlzARntnL8BvMhDMxS2?=
 =?us-ascii?Q?zh5v7xbB+3ysf/GfmqaIvDh+/5P5HNF4O/38KCOWMg8EKGHWKVjbiqwxfGB0?=
 =?us-ascii?Q?kKdiWSs6oB5+YfI92ciGIRn4o2lI+y+FojYOGwLZYrYG4I0nNAktQi6bdUVH?=
 =?us-ascii?Q?yx8fA9R31/DpWT5nVTpUo85zhtLGW+q+PEriAV0IloCe1+rkWaAN+/hGkOX6?=
 =?us-ascii?Q?vxLLyzNxFFhdR50PRKtqFRXFWtw5CSdu7e8pgQYEe0NYpa4E+Mizi8D8SiD7?=
 =?us-ascii?Q?R8aJzVC5Dg1hXjZ3+3V5ANMebvbvHm8BwTGSKWoBlFOLnnoXG38+567b0q0O?=
 =?us-ascii?Q?6VWfvK0k1KkG5fNbQrEERp5SIovGHK2n1ms+6EuOizOVJpHiGy5DQxcjv3mB?=
 =?us-ascii?Q?WmcqurhLTDRFBncBdFx4h/X8vm34aBYzXEJyWvxPVLNgn+oKeXhFMsWc25rt?=
 =?us-ascii?Q?ZoN26CGnltYwHx/AaI2mth3so5U8QqpvfzwkOaHpWOYMFV0tBK1KyM2P0VCA?=
 =?us-ascii?Q?zm3HNaPxrCxYXToEr1zHmzdWZM6ATTF6blP4ss1B5sAt32oKyowPlBOlDlHW?=
 =?us-ascii?Q?8KefdSsvz05Ew761vn8EtnmDSN8ac2a+DWAOeN/2If4zgoIRb2lDBuqUsJ5g?=
 =?us-ascii?Q?3g86u5lz9RnVWl9BRxCEXcssGJ9XnfeaB0OyMypgE4iewpVD/hfWgjr9tdJ0?=
 =?us-ascii?Q?x6A9G1+QXaljo68I0JBTfztnKrJ9UDdK7lDFRu3b1CKwB/UdbiYgL7zkVDov?=
 =?us-ascii?Q?KiI4p6MD5ZtrKRsKY5TaQS+J81QMsPaeK90RAj/4AagDB7X5ddvpouRuZqUk?=
 =?us-ascii?Q?DHi+uT16rMcg8EtUuyf3UOZDirQ4Kxb0bxPKtwM3CNZeRW3Os9u2+yapjyrz?=
 =?us-ascii?Q?yk7L9EK75fhgPgcBom9DzS9bd1LWnLCRt4ZrC2zE3iILnFJw7FPfUoqPK8uF?=
 =?us-ascii?Q?2cv1ufAHRkXEK7SdOihd/04M3RX/MkKEvzBpcgWJMWUhPgDS+9wyxiP/K0ex?=
 =?us-ascii?Q?2rU2lPrvwRteoh5ch4yTOv837VcCNfBhu5P0BaSw2SUFJIPddFty36tH53Zw?=
 =?us-ascii?Q?pubiSEYRXe3IVuOYQ7rnhaywYEyu5LnzMXySq8WGH1/D9HNLkSoJVIGenlPy?=
 =?us-ascii?Q?StgcbLc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Zu0Y+g4G2FwuEK9rKIBMbg4WFN3On/lDpOhzAgqUJsLKBq3W5YHk33d++8b?=
 =?us-ascii?Q?KpnoLdtleTYm23znhXSCiMcRLMNql43lfCeJ7/TBkDUbTZvJXFCw50cA4gma?=
 =?us-ascii?Q?6+mjpKr5/MBXYOxp1LZf2XTC2imtbYIRIY0YRxuV5AoAgjfhgkKxbZqG250K?=
 =?us-ascii?Q?mHUrKvGl16yAhLNIpIpQxAb0PVaI3IxHk6K+s5wr0CtWGKTvwzGM/EQweHiM?=
 =?us-ascii?Q?hkCheMMGloqUH/+i65xNVCYfyvIqkah0vv7TAPxzT/8KN+ae5lIfMN4ocakX?=
 =?us-ascii?Q?k+NUlzQNTwOWqSz9gox/bPxNWVwAOj1ZJ9DdPLuiJjhmb1i9WRMJCiGTIbwT?=
 =?us-ascii?Q?aVREq0zK6UlXqQd5fOpV2f5aC1me1JEca7pDTSv7uTVcPPTLcrnFC+YQEuRm?=
 =?us-ascii?Q?b0Y7/0T5gm7PjtUCta0M8H0G812op66XJSnlCCOSkzzg8x8fKvz0kn0A5Zin?=
 =?us-ascii?Q?ttHEJ1GFS5y1NkV0KvONm85Kqb9r1DLXwmg3Y8iOZ5PzYLSwbF+J1J+4XNgU?=
 =?us-ascii?Q?kF6ccZCQO0QKca8+wilZN7TP85i62G49OVzGB6qX6QPHSHxlxSog2zGi69X7?=
 =?us-ascii?Q?QNpWqnhUwmLlzzqHUgTXn1voJoaouFDg00uVgjyWEgKTNpjy7qP3hm4kb90K?=
 =?us-ascii?Q?lkCJRAtfJ4utUpCB++65Qx7+HWlqp/9CzwvMSC3EficTBRxwFyb3g0ZttZdx?=
 =?us-ascii?Q?GjbxCPC5ikKgdstQUJVPoAWKq9RVFT9J1S6qOeN7bnldX99E9EQoX9WivC4s?=
 =?us-ascii?Q?4gIKvHMVWBvYYKxH9jnQ1uJ9+tQZoSsctH3Gz5A5WwxlUPNxy31m5pgwqGKQ?=
 =?us-ascii?Q?FZozGTltS+4sFEd8gFyd8BYAbP8M+SliycIosNmG4lwzw48ThNpu8K392Sn0?=
 =?us-ascii?Q?J/h1B65zFVomSm9IN0hsYaST04CiHwlZz0pHr5Y4EdzXLCpKwBrG85YKLcyH?=
 =?us-ascii?Q?C6IYXm5TmyvkTAG1eNXgc/X6Un18Cq4A2qK7Bx0UM5cHHRd563dkq2joLdAB?=
 =?us-ascii?Q?L93tx5iOA+yFOAZ+pUwEpq/73KaIKQzV0gugO3WCY53R15xqiaxxQiXHf75Z?=
 =?us-ascii?Q?hLqhk7hYxtHlyJEYeNfonXWbrneIkAwFlnIgHMRuIU1KqngT+l25b0+aQuN4?=
 =?us-ascii?Q?YsooE7oGUX3PqyTIFTm4ittaglaKG/gdZitzhycA+dhr9gwGN1pKATg+3DZo?=
 =?us-ascii?Q?avuj0FlU59XR1BdzXUUX9diyMAMglNsDwtVm4MoiGq+PsuPF7ePSkjFntbh/?=
 =?us-ascii?Q?AFNC+5LsScyhIgpNZXov1/x9DnAJTK+0YwN6IThX2BIX+KpoAzZ5ObgZKvSp?=
 =?us-ascii?Q?VfMjCe0nGEShUTDpRlglnH/5ijWKV7nyDds83vkAcKEJnzEqM4EpCJzP2za1?=
 =?us-ascii?Q?lBar4xjckehBd1m27DFJh0GAviYrbxtch8kWZ0XXBILoDbh+C/+7W1nBQhnS?=
 =?us-ascii?Q?x8GZRVbuaZ/zQgjvyjApihYPcObBrBYudGx8YUjTSvRx9723MZvQ1V/gdCcO?=
 =?us-ascii?Q?0G8SvB+KDHcsquPW5nHpSuqW9Gw4A+XVStS3eJp969XoWCEvMEFX7N0X+oWP?=
 =?us-ascii?Q?jqddQqNeBKeNS+ZocQYQPt+CLUHqjGFyOaUyvdyz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9e2983-40a8-4f57-0e90-08dcdec186e2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 06:56:35.4810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWC3Uv5DnUzWsZohBNf5ARdfYOmdRGiUDnEeRNmXMfV4KknBES0RGsOQy9brPQ6zD67/UdVQyvAFKBcfgJEVOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4641
X-OriginatorOrg: intel.com

Hello Honglei,

On 2024-09-27 at 09:54:28 +0800, Honglei Wang wrote:
> 
> 
> On 2024/9/25 16:54, Chen Yu wrote:
> > Commit 85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")
> > introduced a mechanism that a wakee with shorter slice could preempt
> > the current running task. It also lower the bar for the current task
> > to be preempted, by checking the rq->nr_running instead of cfs_rq->nr_running
> > when the current task has ran out of time slice. But there is a scenario
> > that is problematic. Say, if there is 1 cfs task and 1 rt task, before
> > 85e511df3cec, update_deadline() will not trigger a reschedule, and after
> > 85e511df3cec, since rq->nr_running is 2 and resched is true, a resched_curr()
> > would happen.
> > 
> > Some workloads (like the hackbench reported by lkp) do not like
> > over-scheduling. We can see that the preemption rate has been
> > increased by 2.2%:
> > 
> > 1.654e+08            +2.2%   1.69e+08        hackbench.time.involuntary_context_switches
> > 
> > Restore its previous check criterion.
> > 
> > Fixes: 85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202409231416.9403c2e9-oliver.sang@intel.com
> > Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> > Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> > v1->v2:
> >      Check cfs_rq->nr_running instead of rq->nr_running(K Prateek Nayak)
> > ---
> >   kernel/sched/fair.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 225b31aaee55..53a351b18740 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -1247,7 +1247,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
> >   	account_cfs_rq_runtime(cfs_rq, delta_exec);
> > -	if (rq->nr_running == 1)
> > +	if (cfs_rq->nr_running == 1)
> >   		return;
> Hi Yu,
> 
> I'm wondering if commit 85e511df3cec wants to give more chances to do
> resched just in case there are 'short slices' tasks ready in the other cfs
> hierarchy.
> Does something like rq->cfs->nr_running == 1 make more sense? But
> maybe it helps less than 'cfs_rq->nr_running == 1' in this hackbench case.
> 

Thanks for taking a look.

It could be possible that Peter wanted the short tasks to preempt other quickly.
If I understand correctly, when we say preemption, we usually consider two
tasks which are in the same cfs_rq(level). For example, check_preempt_wakeup_fair()
iterates the hierarchy from down-up until the current task and the wakee are in the
same level via find_matching_se(&se, &pse), then check if the wakee can preempt the
current. This should be consistent with the tick preemption in update_curr(). And
whether the short task should preempt the current is checked by
update_curr() -> did_preempt_short(), rather than checking the cfs_rq->nr_running/nr_h_running
I suppose.

Thanks,
Chenyu


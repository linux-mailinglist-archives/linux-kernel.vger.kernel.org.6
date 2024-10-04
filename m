Return-Path: <linux-kernel+bounces-350187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FB9990135
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 253DCB271D1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188721553AB;
	Fri,  4 Oct 2024 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBftOXhS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F96E137903
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037714; cv=fail; b=SnfZhHtH8DRnzq5yuDJjYC/9SFE1t1ePUAM6vN+PXjVHZrKLDjJEH6LeGsmHAEbmnw+kv0jb1V4k1jWOplUusLrT2l5WuDTBUGoIVBYUr0KvPQK79IBsP9V9ocdNkLnhNRSilhjIKld9MMpviJtoUqlrVNaEJhWXYXr0xJwlgJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037714; c=relaxed/simple;
	bh=mNVnqqOLW8ZPiZKizKBv1IcuXixCiXNo3mvjSQSeYCc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=alsZ96spxr9h6AIFKC9gz2Rb9yzGUG/cxWtVkd6mu4AGsP8gRwLm2zd+eHLd6SCxuo5kC5eWcKCGrJsQKKb3uLF9W8/iDVUtlER8Yk9vnvRx8rFRCiIOia4dRJA1lSnbI8kyNmLevq1AvTiKMgdb6/HOgpl5aRZ2OVQGBRvqphY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBftOXhS; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728037713; x=1759573713;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mNVnqqOLW8ZPiZKizKBv1IcuXixCiXNo3mvjSQSeYCc=;
  b=aBftOXhS9nxG3OeIgWMMhD+wOp3om4GhPaiMfNHCYlKp7H4cIJnEBpCU
   nTCVmZk1GirHqoskDpcUuvmIFgRoUC3AXfK4cGEH4dk3ZtsgwMrhOVCAy
   USvRvv0+Mjf+xJ8rYVRoV+llmk7NbhTvvrSknnd3644A37A+zWPepzeIj
   +Jw2rORX4VSkqn/oKbJygeJfmIXcrbyy7fKbXgoH180RJyEc6d4W6950p
   re9p/s+LBbkB8Q30ysGuxqtL1ExFzjCyHluRpVdrodVLM7OdTcwne70Fc
   cOK4FUWAhW6H4LF3DmuI24EdAf4d5GB/3dMNg0J74Q8ZIVE9ZGQ0kg59o
   A==;
X-CSE-ConnectionGUID: ZTEhoPegRvqBDPk1OtwbSA==
X-CSE-MsgGUID: hCe8TqIPSkeA2h1jBIKLXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="31051903"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="31051903"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 03:28:32 -0700
X-CSE-ConnectionGUID: ZNqBzDppTGyo1pG8kr7Bow==
X-CSE-MsgGUID: o/PvG45CTtWbKL1uxdQ4Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74493957"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 03:28:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 03:28:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 03:28:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 03:28:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMPtj2c7IPPo9ArC45YZuFy4Bm7IXUKPoncSoeK5y+01s1cFjt9FkqHKhhSuP/kq/jXjfvZoLVjBU0F8rJ5x1msMbhF1kxU4tZFryMaSOmjyLXz2kg+LixBILib9/a7TbDfLYmcQRqlt8qo6yNx/52QEvpmfe7J5ExNnzTZ1oz9x483zNgWEr2/kEj2gmYfWi8lAABNcPaVDONLuhfVb4mX7ww0fHNpXbQNMi1+gmZH61DDfYP5neKdtdgskhPFb6MuNwTS6BcSdweJmMiNTd/9BH/Yd8tyDkWCcBTeOJ4X9ZmyDp5kXkvqGi0TrnjBNxpqKnTdseFMTMF+q9972ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fq0mMuNtSGHuc6SdW1Z6Sm0XdSzuQ88zXNqMvn/nbIs=;
 b=o33uPoHdDBoVfRXHeAOa7Dbw5WnPG/pO6P+kg9vjDG34Lw3ze0euKYa/JiaIBc1XQFGYrFVAknJG4PVsQpZ+VynH2XLG7iXu+lKjF/KQsih28dNTl1YQtd2ME3+uTYyEvPFOcSQFnqx3X+f0znKtAEquBh/fh2Vh7a37dqMTu3YVKYnqo+uIxABFad7wSMxSPs/SO9XrxD6iGPyeIr5ZTyzZq6al+wMS6of0V68vI/NRkxDIUzDaqdLMwg0uinCcgNu9LSJRlXXzqvMhFyyIhRMd8+M37OuotoXLd9pTwe4j7c1wpPf0WX79S0f1NEB+QYDmC/ekzoUNVthmNzzrsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH7PR11MB6007.namprd11.prod.outlook.com (2603:10b6:510:1e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 10:28:27 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508%4]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 10:28:27 +0000
Date: Fri, 4 Oct 2024 18:28:13 +0800
From: Feng Tang <feng.tang@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: Marco Elver <elver@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, "David
 Rientjes" <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>, Shuah Khan
	<skhan@linuxfoundation.org>, David Gow <davidgow@google.com>, "Danilo
 Krummrich" <dakr@kernel.org>, Alexander Potapenko <glider@google.com>,
	"Andrey Ryabinin" <ryabinin.a.a@gmail.com>, Dmitry Vyukov
	<dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 0/5] mm/slub: Improve data handling of krealloc() when
 orig_size is enabled
Message-ID: <Zv/DPUKwJxMakVJz@feng-clx.sh.intel.com>
References: <20240911064535.557650-1-feng.tang@intel.com>
 <d3dd32ba-2866-40ce-ad2b-a147dcd2bf86@suse.cz>
 <CANpmjNM5XjwwSc8WrDE9=FGmSScftYrbsvC+db+82GaMPiQqvQ@mail.gmail.com>
 <49ef066d-d001-411e-8db7-f064bdc2104c@suse.cz>
 <2382d6e1-7719-4bf9-8a4a-1e2c32ee7c9f@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2382d6e1-7719-4bf9-8a4a-1e2c32ee7c9f@suse.cz>
X-ClientProxiedBy: SG2PR04CA0166.apcprd04.prod.outlook.com (2603:1096:4::28)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH7PR11MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: f44d50cb-721e-4955-51ab-08dce45f48e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ODraKh8AWhNRMIHu9ecSI1ee9tBhUWuWQ83XopE63743Wh89WM+bojUB66Ly?=
 =?us-ascii?Q?nD5Ueig/0hsDHOEpIk2QSEp7LvXn3smBM4Ug7yj01cLb1kkiZlkY/Onvu3is?=
 =?us-ascii?Q?kX786Cx9mmptp/7mIV/oykDyRdwx/mOwFgayPnuJUvJs6wMUE76d6k+GyDKa?=
 =?us-ascii?Q?BONJkRa7nRQpL3yCehIhijlMB1dpJLHm8aMbXNBDA2GFJyZ94E7PWwI85yYA?=
 =?us-ascii?Q?ACONakQap9EHbvy9I3MB9IkK/zwQsnE/sahq/VZXUqfsK5DFIclTx/eXMf5v?=
 =?us-ascii?Q?jKrqtIOvRNkHhivBUMUrIgxtM92oyOz5uh36KalRdjSGT2AXpBSE3865AdKq?=
 =?us-ascii?Q?vx0EAtP1AyDecBdVUKPaIkTMmwyH8oUJ2/oz2UOkd+lErtj8VAjjuY97voq1?=
 =?us-ascii?Q?1LMGeqcGQNjr0SNPL/uPn22dTGnMyzCVAz8M35FaMwZggoS3XkTKmP95jXb8?=
 =?us-ascii?Q?iLlJGZo9l0p+s053O4OAl/Ok8aAnz7W6rs63IKsjsGQPCRfQRWexAH30hdaK?=
 =?us-ascii?Q?XCxCOZT5AV650Zay2+Npw7dS3Xr5xP2ulteWpqbTtASOQ5NAPKTOD7fCL3pw?=
 =?us-ascii?Q?EbIu34Jj12I0DB2Oj8v7eSDa+cG4sURemPl1xejCkxP9tqARcZJPylsZGaWp?=
 =?us-ascii?Q?8kNLLcrPyGnu7GG9oEuzrD5HF85E2GeYiMALoRBlRCG6EmOQA4vtO84iIll5?=
 =?us-ascii?Q?NEefjuiw+rzq88NqdGXpc7d6KMSMRZ1ijMWd+obXEKBi+SKlFs/+WVVJLJks?=
 =?us-ascii?Q?of0fpz4dEMOWrMhf5QzepIorvPkg2/qFgiiGQme5LxKOAdD/DHMKVyB1fXoF?=
 =?us-ascii?Q?aWzmYGHlV70XAtKVBmtLam61LHZpbG1RYuIqWVprTRm/+ZipP56bVszZRjIK?=
 =?us-ascii?Q?l2wTr8JOYwncJE9Lsl/6m1x25v+WTMbotgg3m7nos92QT8Obb3xHQ4jOPLdo?=
 =?us-ascii?Q?/vbuibDIpHw5MKun7yrwzki1Q4ZExRD5dwwP5Z085dqGpVGhm47aPyCD2VKq?=
 =?us-ascii?Q?0H+QtYiYEKRy67sF492UoTP0DnJz7mGOH8EdXov9uBO+zvgv7BR5unhMZ1ta?=
 =?us-ascii?Q?5UYEdJGV9I3aW0vlIOygjZdms5b5JwA57k8bCvIjPfZqarDc85j4Fg8rM0my?=
 =?us-ascii?Q?xPBSlsKrRZUdt5dYDM2qcAUjUKj8QS4bkCez6lSe38ZZNqLC5Yd2l/1rzhj4?=
 =?us-ascii?Q?iqxmR1hL1qZM9B3Dqsk38YHM0YQUfK8LXLlGL30u6RRyp5ZJ4qi5py21aIhj?=
 =?us-ascii?Q?knjAUt8ChSy5X6/WZDIaJRGYMPX6dRJ04kvu98H6hw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ZMUgVru5ajH25SFt8VYeg/M8hOdkNi3PLU/REf/81dCpqcIL3nLPWLlwdag?=
 =?us-ascii?Q?mnkkhvkxEKHfzeX7il6CuJLsGQsxry0YbVTKVMt/M9FgeegGpomUpZEgfNML?=
 =?us-ascii?Q?9aE3l4qicGV0FEXr9z8tbSaGItEq4EO48hNxqUWF/xVdyLAbFQs5Dd7MU3rW?=
 =?us-ascii?Q?AuTae8OV0V9t+RD5y52YM65bksqRxD5mxo/3zhjlK7OGVHoI0gPvi9BetVxC?=
 =?us-ascii?Q?INWMj4sgHl8sAAOn9qu2jWcNf0V4AGxShlDaPwWWUSP13O+tGIgj3qNo2nJG?=
 =?us-ascii?Q?2HENkVIMTt30bpkbS+ZAbPvwjwmImkVEUR5s+4DoQRkX/L2eNj4QJcrg8vD1?=
 =?us-ascii?Q?sKN17xtD+Hyobx2t/8KHPgaLFRM0oYgAPsTCUjhjAiajLimKfdmkzN/rIGuQ?=
 =?us-ascii?Q?Xe0ehxb/mUexXtVWaWXYcQTQ+8sx3dN7GFID+0QXHC7HK2rxODKr1m01Xagr?=
 =?us-ascii?Q?kyPwU2vAHJ5YCV3NKNurNwkizkbtUddITbhJImsNWEcLYaYI8xvutz7wXlcb?=
 =?us-ascii?Q?3+rCuBM0lZL8y5UnvOoe2dVxR5mAfS7rRKsHMGvLyjgEkA8RiOxxvJwk/YlL?=
 =?us-ascii?Q?FTgmemEOMO4/b9jGb41g3+u3tGR5Z6GcXHMiF1axcyngVPXOavSDcEOMMSvC?=
 =?us-ascii?Q?2Vobbn6F68uFWT4a+c7aASHxeZMH39YcrobsJQiIg+lpE5xtChzcG2bmM5av?=
 =?us-ascii?Q?arm90m8K4KPohWYlSBpIxip244sATinK/5rXD8e/kepoE2L0CI836qeo1Dzh?=
 =?us-ascii?Q?S6jiJmKp/CX9Avrc9xMpRIi866NKHqzg52EAJYd+kFdKZxFTG0BSNw61FxLJ?=
 =?us-ascii?Q?uTRvSuOZfFzkuA0gqN80Hoz9Uu82r7wf21EGgSF7x+Zr1IOQJ9wdryH+zhoq?=
 =?us-ascii?Q?qN43dx4oCnbOtUWpE3l5YdHxviR4xLm4YstetBnbFRcKsng7h+o60/X9kIn0?=
 =?us-ascii?Q?m9wo6Lg7u+9kHqeI3k1MiSEo/hIMvdOjIzeoY07Mgi3pGZGtePak2zIjcT+f?=
 =?us-ascii?Q?4i+oRCDha4nK9oTrZVsdg3fpjjqODEuawZq1R12JzN/IGBArPcJhuuu9+FF7?=
 =?us-ascii?Q?UNInQ2u4LQOC4vYmCen6dWwgukpXLKY89oYsUQO/hUlNu4Q+L1PQg/JfJ5o3?=
 =?us-ascii?Q?o4LzOf8Svj6mYYiaS5PF1bu1STG536+zI9ZNj8RUipPSlqAxSS4UlyzZ4b3c?=
 =?us-ascii?Q?D9CyzrDfIzIYwUcRT6rQnbLiBFfQaaH/7QCgb+bzt+zyw8+uaoVTlvpLMil9?=
 =?us-ascii?Q?L44Obkz7ILcX/bdUkD7ALMnb0O0JhqDcuwxlhM3Ettnh42xuAKaLr+HFxZQk?=
 =?us-ascii?Q?VwFb4gS7MaLYdYffWRhXEfQvCYRrOHp9Jbgo2qG8eXvkw+v3WZSlB8vkYQ+j?=
 =?us-ascii?Q?j6QF5T7VhtCiPcE3sLqo8k4kQjzMOtzbV+i7ThieWr2B3uun1nfrf5/jh1VV?=
 =?us-ascii?Q?YczZvQo6dXVXWauAnEkt9T23h89JgeXkq0nN7m7Hh//6kZxoXJEcYXVDULsF?=
 =?us-ascii?Q?vVPl3FJa8CIf4wHnNrtjB5u7A+1lpcApS7X109z6DCagXR4hq1kXVxlXtBUG?=
 =?us-ascii?Q?JxG0aEv8UDZAw4/zwR4DVXtv/RFD37X+ZrFx3x8+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f44d50cb-721e-4955-51ab-08dce45f48e1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 10:28:27.6370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKc/0z0u5SWZX6ix2DFJA3JJWcWW2l1ff+iq1paPocZ91PIqJJ8Qj6c4B7AY+qTuHwIcI9oyDb/fbzgXSbSzmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6007
X-OriginatorOrg: intel.com

On Fri, Oct 04, 2024 at 05:52:10PM +0800, Vlastimil Babka wrote:
> On 10/4/24 11:18, Vlastimil Babka wrote:
> > On 10/4/24 08:44, Marco Elver wrote:
> > 
> > I think it's commit d0a38fad51cc7 doing in __do_krealloc()
> > 
> > -               ks = ksize(p);
> > +
> > +               s = virt_to_cache(p);
> > +               orig_size = get_orig_size(s, (void *)p);
> > +               ks = s->object_size;
> > 
> > so for kfence objects we don't get their actual allocation size but the
> > potentially larger bucket size?
> > 
> > I guess we could do:
> > 
> > ks = kfence_ksize(p) ?: s->object_size;
> > 
> > ?
> 
> Hmm this probably is not the whole story, we also have:
> 
> -               memcpy(ret, kasan_reset_tag(p), ks);
> +               if (orig_size)
> +                       memcpy(ret, kasan_reset_tag(p), orig_size);
> 
> orig_size for kfence will be again s->object_size so the memcpy might be a
> (read) buffer overflow from a kfence allocation.
> 
> I think get_orig_size() should perhaps return kfence_ksize(p) for kfence
> allocations, in addition to the change above.
> 
> Or alternatively we don't change get_orig_size() (in a different commit) at
> all, but __do_krealloc() will have an "if is_kfence_address()" that sets
> both orig_size and ks to kfence_ksize(p) appropriately. That might be easier
> to follow.
> 
> But either way means rewriting 2 commits. I think it's indeed better to drop
> the series now from -next and submit a v3.

Yes, we can revert now. Sorry for the inconvenience.

Thanks,
Feng


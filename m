Return-Path: <linux-kernel+bounces-520913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD73A3B106
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 06:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2DCA173CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 05:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4CD1B85D0;
	Wed, 19 Feb 2025 05:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQ3p8Y1B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B88A934
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739943998; cv=fail; b=TOcyaNOBei4DWLaetE9kQYb+tPtKOaxKjikRa55dO+ggq8KdhlrIlqpcARO4a8FpDeTezKQoTjM2Ijg1gkeBWHMbdXQuisM3SyKwGT34rMj2a2H4KHWvWbXXZObYPDihlhrSVrXU1wbGUT7QJB8s5274CMpgnyztKUkv+uMOPpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739943998; c=relaxed/simple;
	bh=RRU30VN7WdM8DtzULQf0EcZlMR7IdOSP+uLfqNoKfgQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=d8VkafcmMhoN/exJPnuhed3gVtflhBoJ17blP/j0yvLsFn/yXPErCnogDX7v3dKLYC7rlrA3S94gqY2G/Y/DWgvE0lrIcjK3hF4x9K+A0HdUXnRRESlZ7Ee1kKOUXOwioBc2XPRJKOEdKUhG2AnYI9mPrUL7cI8RE5go1NH9xYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QQ3p8Y1B; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739943994; x=1771479994;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=RRU30VN7WdM8DtzULQf0EcZlMR7IdOSP+uLfqNoKfgQ=;
  b=QQ3p8Y1BIctoEbJ2ySCrtyU5+jIsqVfHFmiGDrTHtPAt8PE55u4KoQUp
   4ZKNWJjV2aelRiZfrp9JYRqm4TkvXUM85PF1+xC1FERlRQp2pOhejC3jn
   Z74f4hzTHIbwvXCnDIlXjjFf9VHjEOmWAgKDnl+c5PLjr2GQs06AFjLwB
   avj1NDmxW6BDRUSj1MxXK0Pl+0ThrdFavKW/FsJ/xnwjAitj3FGvJolp6
   +1CizDH9QgSPYzvUmkV9Y9k1R3gs+Nk376neuTmUxFlNDLTFzEoSu5r0y
   t/Ziwh+ypjPCDC5G+BzHuALKrb1FQT/hWEspTqdfqS+Z1Hw0YNrgZiAZ+
   g==;
X-CSE-ConnectionGUID: QlDVnlE9SgWnMXhxJrJOsQ==
X-CSE-MsgGUID: CuMnYeeyRT6PwUrFbB1DKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="39855211"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="39855211"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 21:46:34 -0800
X-CSE-ConnectionGUID: zQNjZq7pSv2sODQWxpiP7g==
X-CSE-MsgGUID: qU6EkVQgSQe+BAQdY85QLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114469183"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2025 21:46:34 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Feb 2025 21:46:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 21:46:33 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 21:46:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BaDcjLOifX6X+Dcr3mFZxoSc3Q3T0kxfcLHzf/28zjsf8y3HDMvbidAqdxIFxbiyviNGk3xrOH6GtoGiXE6BAcWE73RAWgXvOEpm2Yf67Z9BB8wmDX8Jm5ZQxbmDRYnVyatMsJjXCs/x26/i62jJqSf3wKEV5IeT95m2sL1gnWjwl1CmRul5k2V4nsDTR2UQX5OKezY0CK6fV9zP7gEasjuvsgEmNXo479f4RvDyioMYt9n8hMHre+RnTdGM5Ex9Vv1UlYSJ5rwJGA91qPcxv29puSi3F6eXpi9GHtfE/TWarBhb2AQF+NsUTA2Oi2BOwdMprcvxNkmhNWb6w+rNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVuXJMLXxWEbUqMLfAYUibBrOMUuFpg+NPxTpoJJFPo=;
 b=qkD7qmgatXbnYqwT79/PCqGA0qsE7qhoUlb3P66OceRaPQZ/70gCrVcsrNhFCWrjI7EhUt0V0qhqdLHFsdoctevwHtbkDZyEOi5E5X0qRgayHU0XbSZE+bjfTgTNgkzyfp5GByMF1DiMtRY5NNbDQiKfeB/yIOEmuRnee4vn/rNnhx6nFt65JRhS5LmRryZhbClkTu0qzu/4+GKptx0p5zn/UGbw0kkW4NYVtGtVHTDJNsioE9cvI02CNZC9XYvUdtLcSJmHE2WKt0yxusT2Ivp6juVnRSaOR/oZJ4gdvNr8Srb0WZFn0UUQPjOXAxsWROt5ALrLf3fZg9g7YQBlPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BN9PR11MB5292.namprd11.prod.outlook.com (2603:10b6:408:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 05:46:30 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8445.019; Wed, 19 Feb 2025
 05:46:30 +0000
Date: Wed, 19 Feb 2025 13:46:21 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [pid]  7903f907a2: stress-ng.pthread.ops_per_sec
 23.4% improvement
Message-ID: <202502191317.d0050992-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BN9PR11MB5292:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ac12ea-c554-49ae-acf8-08dd50a8c236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?z+XAsKxVdbvnAtzg86p8vFC89xfWVn8jvV2zRuU5I6sDZtaEa9jo0aZ57i?=
 =?iso-8859-1?Q?aSiMumHTUw8EofHrnlx6rWgPjB1xSQiLQZKTEQSS4SWGIMuA82F6z2HTvg?=
 =?iso-8859-1?Q?fc9m8rpakDY6ciUXGdhvlaKUmZc/TZ/ZZ7Ub19GX44gNR15LgfbSTkTwtH?=
 =?iso-8859-1?Q?GWlmEo903D3Kcyexw1siZCz5+8rCpdmda1UWI6cDdFMZA9lU0p/TYBWggg?=
 =?iso-8859-1?Q?E9eAPI3L66pMAJgoPAnTPHhmzG3fmKI2gYqNNmk4g5xg4p54OjiN0SM/z1?=
 =?iso-8859-1?Q?rQf9XJvBZD17UTvYlESOBiIkIG4GffpmYhyts1yayjjuQd5lHpZLbjxflk?=
 =?iso-8859-1?Q?CxZi3A/5exnkTpeA1aEK0OhYpZHOwi+P5jL3QNEO48UU42tMSN1xZFtgGI?=
 =?iso-8859-1?Q?YCro6mKxykSa0gnJagwcJSjL5p92BlHDFqZSvFDLhmMYZLzd96JtwbeXQS?=
 =?iso-8859-1?Q?+icGI4nCAg32oy16Oy/KRkSsrxL8sQnKzZhTxOZtrlI0PUg4uLRs3q5XUE?=
 =?iso-8859-1?Q?c7o1JykgX4cDTwrcHvG1khz2X2QI+znoLc41Te+gmwuMEdpCgcOFXcPgoq?=
 =?iso-8859-1?Q?xX1d9yGG8O0xWXqNeDUvpRbi3U7KbRKcjZJQimS+4WoXtv4gg35NlBfD1s?=
 =?iso-8859-1?Q?ixBSkSUE3YsitGVmp9MJW5tuaKhAMviOTF20hNIFVjcY4oc72siW2lZIGu?=
 =?iso-8859-1?Q?fJNKCwlCfCqr4vk3F4aK1IDpAFawQp4bOItxKAZPl18z7ZwqgSZdxVhVoo?=
 =?iso-8859-1?Q?50TxzCP+epDYkOzgYX/VwN4U4TkrynSHPJq9JwoJnP1ZH9IVTLav/oAHUD?=
 =?iso-8859-1?Q?qjgYgnlND7zm8o179IR59xK9NIq30+nZe5Be3goQ+ins/22T58XHmIiUUD?=
 =?iso-8859-1?Q?oqsPN9wPOc59os7JvMjpBydjJ28Z7+jSsgHeNC/EH/0Emkb3qSedxmWukT?=
 =?iso-8859-1?Q?wJLp3U+JFcBvefLjepQUioKzHHB4XQPt+XTqmR165stKla0ozXKBZ7QQsb?=
 =?iso-8859-1?Q?IdwXcllZ1TgJsDYW+JWyCWWTa3kxgDcqd7KfiXGcTMbiWealFKcsN/HRf4?=
 =?iso-8859-1?Q?sRpzzObcWa08YOWbuSuvC2TCyZM4LwPaVxJJEzfxn2wR+DqWZqCL/yfw8i?=
 =?iso-8859-1?Q?41PVi31AeXHO+NTOwkOSQxKJlqh80kbnUBnPCJAU5B2QyCKQXRrjCqKiWL?=
 =?iso-8859-1?Q?4ZgrYt+Tog+CQR+cbSjR1ciZfKppa8jqtTOjaoi2TEIfzPu0qq/6pXnV9t?=
 =?iso-8859-1?Q?yC/ZRydw9l0CSL3xtX3fDYHR1uqcsSKwhalSqstUWpX5isDMHZjcllYPsq?=
 =?iso-8859-1?Q?7VdbzX14J1mSqBx8JBK+lWkS8/NwDImH/Q+1T3z4ke3zlFZm0W/WjXShEK?=
 =?iso-8859-1?Q?Ma0Tvn1RhFhjd6ZLCe+LiitB0Sey5bFA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?xURLuGIB/zCKX8fl3axeDvBoRyYp/+z1tzXPsy92Qnw0IV2Q6gw2PDRaFl?=
 =?iso-8859-1?Q?nVknO0XpEyk+ox+Z5jN59acRSihdpmlV2wEiXtwG6wUGc79VLjJdcefayd?=
 =?iso-8859-1?Q?AqD50yPJrItIV7kHx+kK3f5tJQ3GDl3VJAfxqyN3YEqHhWEojideIM62y+?=
 =?iso-8859-1?Q?o/EQSYFRddLxBjg00x7oG4B8E6PSueivykOiCs+iHikq8gsX28K69uKtI+?=
 =?iso-8859-1?Q?RyUIPhc3Km6wmb6V5zIRlxFzTkh/woJMN72XoNe3X7ORTZ44MzrDDcW8zq?=
 =?iso-8859-1?Q?yj1PYsoK/I1t+8+SVwWv+AfroLwBZ+OR1KWyEiHlTSXPBoyeCfHliIDAhb?=
 =?iso-8859-1?Q?tGJZXkaZEf8oMqYUcIRVHrii2yqow5j6A8JpFB2NaMWgs+2q/EjN5QwNZ7?=
 =?iso-8859-1?Q?WmbhgoyCYoNrIKFAr7r8wh8gIgjBpgfoah+UVIsFqCrg6M4Ui3Y5l/FSeX?=
 =?iso-8859-1?Q?5EGxKc9oUuVTf6wzLtczzdWrqXDi2RauFlnz8uZ1xjKw5eOqrRQpbw0LZp?=
 =?iso-8859-1?Q?wb1V5O3uhIwkxrDoN0CSghrx3b3wEr4eosOSsS4VfJESLyv5eGz+MkMrBI?=
 =?iso-8859-1?Q?BT0AEoH2bKd7YdVglv+wEkAtuS1wEtS4bDFQ1KJ2CVPzRwZ/Yi1yxFsJBQ?=
 =?iso-8859-1?Q?PHeD8mpbfEFGQjeKJ3Vzhr7AQxIVMjRiLjWyF5tRL/mNg0nLeayr/Yw+be?=
 =?iso-8859-1?Q?snDq5+XXwFpP6Tw4EZ7UyYm+8QY9rCMbKdxE4XzYaBUaQIfcU62uaC3KoZ?=
 =?iso-8859-1?Q?MAi2mg89PDy4pbtyqFtJCjl2PV6jnS4Se2sIMrL3tf1TERzgegjptwcfvW?=
 =?iso-8859-1?Q?DxeRtyhIZeb82KC8gqfRQO/D45N0SEMqWRHmngoAmmmSq5MDQnjW3Y1khT?=
 =?iso-8859-1?Q?ZfGVp02VtHJECzrAUVW3S9Jfwc6aP6C51SEMB3f5THnyJD0n48SFlHciFr?=
 =?iso-8859-1?Q?fmX2lFLAojwtCfJ3s/QW7h76i2YNv4pWfsKY0/KN0Q2T8ZHi51mRkPBuxO?=
 =?iso-8859-1?Q?lcHJ7YPIrBW1TN+WYC9hZVswr0n8Jsl9hqzAlt9Ta7z5KQUzO78cCcviTW?=
 =?iso-8859-1?Q?beq1VkZ4Wp8iRKSl5RKwzvqDRR2JMittoqqfy/PnrUeT2ppt3z7RWnyRUo?=
 =?iso-8859-1?Q?rqG+Q3lAYTIEkhe5Po4Ha8OIvaWPnF3hP+lN4JSeudEzhMwKaZU3UFm63R?=
 =?iso-8859-1?Q?rkEYjcSG8Sn7e4F80n2GgLFegvxCKmx2UeG83OW/Zh52w3Kyr74XWLWUC1?=
 =?iso-8859-1?Q?5mHzntVmkoqqaAuFCXQemGi6n9YlAVA263lhIm41AqQwDNQi4UIQDA5r0Z?=
 =?iso-8859-1?Q?8dobyEsLU3lwB1HZI7PGVyAU5Id008VSIsSSuxYZ27rlatAvn7OLp75ac1?=
 =?iso-8859-1?Q?xIqVyXPgkUvsm414vN9j0rASDbAfGtbL5DnkjiJuYtiNsxY04PkduRKQ80?=
 =?iso-8859-1?Q?crcE19iLmDa4PSoJ+NHSBO7ZprEnKWqCff2uz58duZRjyKz02n3CU7WNxG?=
 =?iso-8859-1?Q?9oooUVLoq+K7gtlbM/djIebuuF7jDrqh43BcaPJBjFACK2tt30dmDQHNlW?=
 =?iso-8859-1?Q?DiLyDmJvukn4L+9ZoV2u0arCmhAnamf5RBpTwS0wDUd74vPmQc5+QJmYye?=
 =?iso-8859-1?Q?bpOroaXtay+SSrX77oABNbidEXF3XG1DMHfp6P7xhVaV3td36/spSYVA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ac12ea-c554-49ae-acf8-08dd50a8c236
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 05:46:30.2941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qp9fwWyYiAx0SWx0HyJEobDL2o3Gfga6ME8ay3DhXsqzskbyecuwtCGEVtyI348QOVSUsXc6OZCwObDOwjrjDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5292
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 23.4% improvement of stress-ng.pthread.ops_per_sec on:


commit: 7903f907a226058ed99f86e9924e082aea57fc45 ("pid: perform free_pid() calls outside of tasklist_lock")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master


testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: pthread
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.vfork.ops_per_sec 28.7% improvement                                    |
| test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory |
| test parameters  | cpufreq_governor=performance                                                                |
|                  | nr_threads=100%                                                                             |
|                  | test=vfork                                                                                  |
|                  | testtime=60s                                                                                |
+------------------+---------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250219/202502191317.d0050992-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/pthread/stress-ng/60s

commit: 
  74198dc206 ("pid: sprinkle tasklist_lock asserts")
  7903f907a2 ("pid: perform free_pid() calls outside of tasklist_lock")

74198dc2067b2aa1 7903f907a226058ed99f86e9924 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 5.953e+08 ±  9%     +82.9%  1.089e+09 ±  3%  cpuidle..time
   3067781 ± 17%    +281.8%   11714061 ±  4%  cpuidle..usage
   3156621 ±  7%     -11.8%    2783051 ±  7%  numa-meminfo.node0.AnonPages
    315502 ±  4%     -11.0%     280901 ±  4%  numa-meminfo.node1.PageTables
      2119 ±  4%     -59.4%     861.38 ±  3%  vmstat.procs.r
    695158           +37.7%     957064        vmstat.system.cs
    786439           +58.8%    1248633        vmstat.system.in
    918265           -31.9%     625741 ± 31%  meminfo.AnonHugePages
   9498433 ±  3%     +13.6%   10786868 ±  3%  meminfo.Cached
 1.188e+09           -11.7%  1.049e+09        meminfo.Committed_AS
   5970512 ±  6%     +21.6%    7258946 ±  4%  meminfo.Shmem
      4.38 ± 11%      +3.8        8.20 ±  3%  mpstat.cpu.all.idle%
      0.47            +0.2        0.67        mpstat.cpu.all.irq%
      0.37 ±  6%      +0.4        0.76 ±  5%  mpstat.cpu.all.soft%
      1.47            +0.3        1.82        mpstat.cpu.all.usr%
  39409396           +21.1%   47737561 ±  2%  numa-numastat.node0.local_node
  39517687           +21.1%   47862366 ±  2%  numa-numastat.node0.numa_hit
  39678016           +22.2%   48499008 ±  2%  numa-numastat.node1.local_node
  39806349           +22.1%   48619579 ±  2%  numa-numastat.node1.numa_hit
     11111 ± 20%     +86.8%      20750 ± 10%  perf-c2c.DRAM.local
      8594 ± 16%     +25.6%      10797 ±  7%  perf-c2c.DRAM.remote
     14151 ± 18%    +100.2%      28336 ±  9%  perf-c2c.HITM.local
      3853 ± 16%     +40.3%       5404 ±  7%  perf-c2c.HITM.remote
     18004 ± 18%     +87.4%      33740 ±  9%  perf-c2c.HITM.total
    785387 ±  8%     -10.5%     702556 ±  7%  numa-vmstat.node0.nr_anon_pages
  39519842           +20.9%   47789798 ±  2%  numa-vmstat.node0.numa_hit
  39411551           +20.9%   47665001 ±  2%  numa-vmstat.node0.numa_local
     78603 ±  3%      -9.8%      70878 ±  5%  numa-vmstat.node1.nr_page_table_pages
  39804028           +22.0%   48541084 ±  2%  numa-vmstat.node1.numa_hit
  39675696           +22.0%   48420524 ±  2%  numa-vmstat.node1.numa_local
    304344 ±  7%     -66.2%     102730 ±  5%  stress-ng.pthread.nanosecs_to_start_a_pthread
  10003318           +23.2%   12323193        stress-ng.pthread.ops
    166143           +23.4%     204943        stress-ng.pthread.ops_per_sec
   4793153           +19.3%    5716581        stress-ng.time.involuntary_context_switches
  21587233           +23.1%   26564025        stress-ng.time.minor_page_faults
     13184           +11.2%      14659        stress-ng.time.percent_of_cpu_this_job_got
      7880           +10.4%       8702        stress-ng.time.system_time
    105.74           +51.1%     159.78        stress-ng.time.user_time
  23363531           +24.5%   29091883        stress-ng.time.voluntary_context_switches
   3104817 ±  2%      +7.0%    3322678 ±  2%  proc-vmstat.nr_active_anon
   1610889            -6.3%    1509476 ±  3%  proc-vmstat.nr_anon_pages
    447.53           -31.7%     305.57 ± 31%  proc-vmstat.nr_anon_transparent_hugepages
   2380189 ±  3%     +13.4%    2699415 ±  3%  proc-vmstat.nr_file_pages
   1794253            -3.7%    1727492        proc-vmstat.nr_kernel_stack
    154819            -9.1%     140710        proc-vmstat.nr_page_table_pages
   1498207 ±  5%     +21.3%    1817432 ±  4%  proc-vmstat.nr_shmem
     47516            +2.5%      48728        proc-vmstat.nr_slab_reclaimable
   3104817 ±  2%      +7.0%    3322678 ±  2%  proc-vmstat.nr_zone_active_anon
    550885 ± 15%     +69.4%     932960 ± 11%  proc-vmstat.numa_hint_faults
    293967 ± 27%     +95.8%     575443 ± 19%  proc-vmstat.numa_hint_faults_local
  79375488           +21.6%   96482937        proc-vmstat.numa_hit
  79138861           +21.6%   96237560        proc-vmstat.numa_local
    330580 ±  9%     +27.1%     420192 ±  5%  proc-vmstat.numa_pages_migrated
    808808 ± 11%     +43.0%    1156712 ±  9%  proc-vmstat.numa_pte_updates
  83384617           +26.0%   1.05e+08        proc-vmstat.pgalloc_normal
  22326472           +22.9%   27448052        proc-vmstat.pgfault
  80530234           +26.2%  1.017e+08        proc-vmstat.pgfree
    330580 ±  9%     +27.1%     420192 ±  5%  proc-vmstat.pgmigrate_success
    261994 ±  8%     +39.8%     366207 ±  7%  proc-vmstat.pgreuse
   4612194 ±  2%     +62.7%    7503881        sched_debug.cfs_rq:/.avg_vruntime.avg
   5440180 ± 13%     +85.6%   10099394 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.max
    501155 ± 64%    +329.5%    2152678 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      2.13 ±  9%     -47.3%       1.12 ± 18%  sched_debug.cfs_rq:/.h_nr_queued.avg
     44.33 ± 10%     -55.6%      19.67 ± 47%  sched_debug.cfs_rq:/.h_nr_queued.max
      5.09 ±  5%     -53.8%       2.35 ± 26%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      2.09 ±  9%     -47.9%       1.09 ± 19%  sched_debug.cfs_rq:/.h_nr_runnable.avg
     44.25 ± 10%     -55.7%      19.58 ± 47%  sched_debug.cfs_rq:/.h_nr_runnable.max
      5.05 ±  5%     -54.2%       2.31 ± 27%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
   5340703 ± 12%     +85.8%    9925031 ±  2%  sched_debug.cfs_rq:/.left_deadline.max
   2202572 ±  2%     +55.2%    3417743 ±  9%  sched_debug.cfs_rq:/.left_deadline.stddev
   5340659 ± 12%     +85.8%    9924585 ±  2%  sched_debug.cfs_rq:/.left_vruntime.max
   2202531 ±  2%     +55.2%    3417686 ±  9%  sched_debug.cfs_rq:/.left_vruntime.stddev
    313473 ±  6%     -24.8%     235882 ± 22%  sched_debug.cfs_rq:/.load.avg
   4612199 ±  2%     +62.7%    7503887        sched_debug.cfs_rq:/.min_vruntime.avg
   5440184 ± 13%     +85.6%   10099394 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
    501154 ± 64%    +329.5%    2152680 ±  6%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.60 ±  6%     -19.5%       0.49 ± 13%  sched_debug.cfs_rq:/.nr_queued.avg
   5340667 ± 12%     +85.8%    9924585 ±  2%  sched_debug.cfs_rq:/.right_vruntime.max
   2202534 ±  2%     +55.2%    3417691 ±  9%  sched_debug.cfs_rq:/.right_vruntime.stddev
    364.26 ±  3%     +16.6%     424.72 ±  2%  sched_debug.cfs_rq:/.util_avg.avg
      1206 ± 23%     +53.8%       1856 ± 26%  sched_debug.cfs_rq:/.util_est.max
    209.57 ±  9%     +27.9%     268.09 ± 11%  sched_debug.cfs_rq:/.util_est.stddev
    360185 ±  5%     +68.1%     605388 ± 15%  sched_debug.cpu.curr->pid.avg
    401600 ±  3%    +120.0%     883327 ±  5%  sched_debug.cpu.curr->pid.stddev
      2.13 ± 10%     -47.0%       1.13 ± 18%  sched_debug.cpu.nr_running.avg
     44.25 ± 10%     -55.6%      19.67 ± 47%  sched_debug.cpu.nr_running.max
      5.08 ±  5%     -53.8%       2.35 ± 25%  sched_debug.cpu.nr_running.stddev
     98005           +37.5%     134753        sched_debug.cpu.nr_switches.avg
    178454 ±  8%    +106.9%     369189 ±  4%  sched_debug.cpu.nr_switches.max
     16050 ± 34%    +376.0%      76393 ±  3%  sched_debug.cpu.nr_switches.stddev
      3.76           +13.7%       4.27        perf-stat.i.MPKI
 1.873e+10            +6.2%  1.989e+10        perf-stat.i.branch-instructions
      0.61            +0.1        0.69        perf-stat.i.branch-miss-rate%
 1.096e+08           +21.8%  1.335e+08        perf-stat.i.branch-misses
     40.32            -2.7       37.62        perf-stat.i.cache-miss-rate%
 3.087e+08           +22.7%  3.787e+08        perf-stat.i.cache-misses
 7.635e+08           +31.5%  1.004e+09        perf-stat.i.cache-references
    712864           +38.1%     984398        perf-stat.i.context-switches
      7.63           -10.6%       6.82        perf-stat.i.cpi
 6.279e+11            -3.7%  6.047e+11        perf-stat.i.cpu-cycles
      2027           -21.4%       1593        perf-stat.i.cycles-between-cache-misses
 8.232e+10            +7.9%  8.881e+10        perf-stat.i.instructions
      0.14           +10.8%       0.15        perf-stat.i.ipc
      8.13           +26.5%      10.29        perf-stat.i.metric.K/sec
    369735           +22.0%     450981        perf-stat.i.minor-faults
    532034           +22.5%     651748        perf-stat.i.page-faults
      3.76           +13.3%       4.26        perf-stat.overall.MPKI
      0.58            +0.1        0.67        perf-stat.overall.branch-miss-rate%
     40.43            -2.7       37.76        perf-stat.overall.cache-miss-rate%
      7.66           -11.4%       6.79        perf-stat.overall.cpi
      2038           -21.8%       1594        perf-stat.overall.cycles-between-cache-misses
      0.13           +12.8%       0.15        perf-stat.overall.ipc
 1.821e+10            +7.3%  1.954e+10        perf-stat.ps.branch-instructions
 1.057e+08           +23.2%  1.302e+08        perf-stat.ps.branch-misses
 3.007e+08           +23.6%  3.717e+08        perf-stat.ps.cache-misses
 7.438e+08           +32.4%  9.845e+08        perf-stat.ps.cache-references
    696299           +38.7%     965478        perf-stat.ps.context-switches
 6.131e+11            -3.4%  5.925e+11        perf-stat.ps.cpu-cycles
     8e+10            +9.0%  8.724e+10        perf-stat.ps.instructions
    356195           +23.6%     440270        perf-stat.ps.minor-faults
    514755           +23.8%     637135        perf-stat.ps.page-faults
 4.867e+12            +9.3%  5.319e+12        perf-stat.total.instructions
     74.42 ± 44%     -60.3       14.16 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     74.41 ± 44%     -60.3       14.16 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     46.44 ± 44%     -41.7        4.73 ±223%  perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
     46.44 ± 44%     -41.7        4.73 ±223%  perf-profile.calltrace.cycles-pp.__x64_sys_exit.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
     46.43 ± 44%     -41.7        4.72 ±223%  perf-profile.calltrace.cycles-pp.do_exit.__x64_sys_exit.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
     45.72 ± 44%     -41.2        4.50 ±223%  perf-profile.calltrace.cycles-pp.exit_notify.do_exit.__x64_sys_exit.x64_sys_call.do_syscall_64
     23.46 ± 44%     -23.5        0.00        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.exit_notify.do_exit.__x64_sys_exit.x64_sys_call
     23.34 ± 44%     -23.3        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.exit_notify.do_exit.__x64_sys_exit
     23.33 ± 45%     -23.3        0.00        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.copy_process.kernel_clone.__do_sys_clone3.do_syscall_64
     23.24 ± 45%     -23.2        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.copy_process.kernel_clone.__do_sys_clone3
     21.68 ± 44%     -21.7        0.00        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.release_task.exit_notify.do_exit.__x64_sys_exit
     21.54 ± 44%     -21.5        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.release_task.exit_notify.do_exit
     27.26 ± 45%     -18.0        9.26 ±223%  perf-profile.calltrace.cycles-pp.__do_sys_clone3.do_syscall_64.entry_SYSCALL_64_after_hwframe
     27.26 ± 45%     -18.0        9.26 ±223%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone3.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.09 ± 44%     -17.6        4.45 ±223%  perf-profile.calltrace.cycles-pp.release_task.exit_notify.do_exit.__x64_sys_exit.x64_sys_call
     26.16 ± 45%     -17.2        8.99 ±223%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone3.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.24 ± 47%      -3.9        1.38 ±223%  perf-profile.calltrace.cycles-pp.__madvise
      5.24 ± 47%      -3.9        1.38 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      5.24 ± 47%      -3.9        1.38 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
      5.24 ± 47%      -3.9        1.38 ±223%  perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      5.24 ± 47%      -3.9        1.38 ±223%  perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      5.18 ± 47%      -3.8        1.37 ±223%  perf-profile.calltrace.cycles-pp.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.18 ± 47%      -3.8        1.36 ±223%  perf-profile.calltrace.cycles-pp.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
      5.08 ± 47%      -3.7        1.34 ±223%  perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior.do_madvise
      5.08 ± 47%      -3.7        1.34 ±223%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise
      5.07 ± 47%      -3.7        1.34 ±223%  perf-profile.calltrace.cycles-pp.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior
      5.06 ± 47%      -3.7        1.33 ±223%  perf-profile.calltrace.cycles-pp.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single
     68.48 ± 44%     -68.4        0.09 ±223%  perf-profile.children.cycles-pp.queued_write_lock_slowpath
     81.41 ± 44%     -65.4       16.02 ±223%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     81.40 ± 44%     -65.4       16.01 ±223%  perf-profile.children.cycles-pp.do_syscall_64
     70.40 ± 44%     -57.1       13.32 ±223%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     46.45 ± 44%     -41.7        4.73 ±223%  perf-profile.children.cycles-pp.x64_sys_call
     46.44 ± 44%     -41.7        4.73 ±223%  perf-profile.children.cycles-pp.do_exit
     46.44 ± 44%     -41.7        4.73 ±223%  perf-profile.children.cycles-pp.__x64_sys_exit
     45.74 ± 44%     -41.2        4.50 ±223%  perf-profile.children.cycles-pp.exit_notify
     27.26 ± 45%     -18.0        9.26 ±223%  perf-profile.children.cycles-pp.__do_sys_clone3
     27.26 ± 45%     -18.0        9.26 ±223%  perf-profile.children.cycles-pp.kernel_clone
     22.11 ± 44%     -17.7        4.45 ±223%  perf-profile.children.cycles-pp.release_task
     26.18 ± 45%     -17.2        8.99 ±223%  perf-profile.children.cycles-pp.copy_process
      5.38 ± 47%      -4.0        1.38 ±223%  perf-profile.children.cycles-pp.tlb_finish_mmu
      5.30 ± 47%      -3.9        1.36 ±223%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      5.30 ± 47%      -3.9        1.36 ±223%  perf-profile.children.cycles-pp.smp_call_function_many_cond
      5.30 ± 47%      -3.9        1.37 ±223%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      5.25 ± 47%      -3.9        1.38 ±223%  perf-profile.children.cycles-pp.__madvise
      5.24 ± 47%      -3.9        1.38 ±223%  perf-profile.children.cycles-pp.__x64_sys_madvise
      5.24 ± 47%      -3.9        1.38 ±223%  perf-profile.children.cycles-pp.do_madvise
      5.18 ± 47%      -3.8        1.37 ±223%  perf-profile.children.cycles-pp.madvise_vma_behavior
      5.18 ± 47%      -3.8        1.36 ±223%  perf-profile.children.cycles-pp.zap_page_range_single
     70.39 ± 44%     -57.1       13.32 ±223%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      5.16 ± 47%      -3.9        1.30 ±223%  perf-profile.self.cycles-pp.smp_call_function_many_cond


***************************************************************************************************
lkp-spr-2sp4: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/vfork/stress-ng/60s

commit: 
  74198dc206 ("pid: sprinkle tasklist_lock asserts")
  7903f907a2 ("pid: perform free_pid() calls outside of tasklist_lock")

74198dc2067b2aa1 7903f907a226058ed99f86e9924 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   6562366 ±  8%     +37.0%    8993652 ± 10%  cpuidle..usage
      0.29            +0.1        0.39        mpstat.cpu.all.soft%
    486692           +31.8%     641303        vmstat.system.cs
    506323            +4.8%     530409        vmstat.system.in
   4004574 ±  3%      +8.7%    4353640 ±  3%  meminfo.Active
   4004574 ±  3%      +8.7%    4353640 ±  3%  meminfo.Active(anon)
   2657761 ±  6%     +15.5%    3069404 ±  5%  meminfo.Shmem
   3257759 ± 11%     +14.3%    3724594 ±  7%  numa-meminfo.node1.Active
   3257759 ± 11%     +14.3%    3724594 ±  7%  numa-meminfo.node1.Active(anon)
   2492828 ±  9%     +21.0%    3017306 ±  6%  numa-meminfo.node1.Shmem
   9063611 ±  2%     +36.5%   12368884 ±  9%  numa-numastat.node0.local_node
   9220375 ±  2%     +35.7%   12513653 ±  9%  numa-numastat.node0.numa_hit
  10168176           +28.3%   13044773        numa-numastat.node1.local_node
  10243149           +28.2%   13131946        numa-numastat.node1.numa_hit
      5700 ±  8%     +47.9%       8432 ± 11%  perf-c2c.DRAM.remote
     14297 ±  7%     +42.5%      20373 ± 12%  perf-c2c.HITM.local
      3624 ±  8%     +54.4%       5597 ± 11%  perf-c2c.HITM.remote
     17922 ±  7%     +44.9%      25970 ± 12%  perf-c2c.HITM.total
     51838 ± 45%     -56.5%      22543 ±105%  numa-vmstat.node0.nr_mapped
   9221619 ±  2%     +35.2%   12469913 ±  9%  numa-vmstat.node0.numa_hit
   9064856 ±  2%     +36.0%   12325144 ± 10%  numa-vmstat.node0.numa_local
    623443 ±  9%     +20.6%     752138 ±  6%  numa-vmstat.node1.nr_shmem
  10243633           +27.8%   13088671        numa-vmstat.node1.numa_hit
  10168660           +27.9%   13001498        numa-vmstat.node1.numa_local
   1378378           +18.3%    1630343        stress-ng.time.involuntary_context_switches
     10647            -3.1%      10321        stress-ng.time.system_time
      1838           +13.8%       2092        stress-ng.time.user_time
  16431508           +30.8%   21498222        stress-ng.time.voluntary_context_switches
   8890752           +28.7%   11442483        stress-ng.vfork.ops
    148177           +28.7%     190706        stress-ng.vfork.ops_per_sec
   1000826 ±  3%      +8.9%    1090125 ±  3%  proc-vmstat.nr_active_anon
   1545626 ±  2%      +6.8%    1650840 ±  2%  proc-vmstat.nr_file_pages
    120475            +2.9%     124024        proc-vmstat.nr_mapped
    663632 ±  6%     +15.9%     768846 ±  5%  proc-vmstat.nr_shmem
   1000826 ±  3%      +8.9%    1090125 ±  3%  proc-vmstat.nr_zone_active_anon
  19510114           +31.5%   25647538 ±  4%  proc-vmstat.numa_hit
  19278378           +31.8%   25415597 ±  4%  proc-vmstat.numa_local
  22280233           +32.9%   29608930 ±  4%  proc-vmstat.pgalloc_normal
  20644303           +35.1%   27885848 ±  4%  proc-vmstat.pgfree
      1.03           +18.9%       1.22 ±  2%  perf-stat.i.MPKI
 1.703e+10            +6.2%  1.809e+10        perf-stat.i.branch-instructions
      0.53 ±  2%      +0.1        0.59 ±  4%  perf-stat.i.branch-miss-rate%
  88001361 ±  3%     +17.3%  1.032e+08 ±  5%  perf-stat.i.branch-misses
  74412375           +27.9%   95182974        perf-stat.i.cache-misses
 7.674e+08 ±  3%     +26.4%  9.698e+08 ±  4%  perf-stat.i.cache-references
    503132           +32.0%     664329        perf-stat.i.context-switches
      8.49            -7.5%       7.85        perf-stat.i.cpi
    112807 ±  2%     +23.7%     139583 ±  5%  perf-stat.i.cpu-migrations
      8617           -23.1%       6627        perf-stat.i.cycles-between-cache-misses
 7.368e+10            +7.4%  7.917e+10        perf-stat.i.instructions
      0.12            +8.3%       0.13        perf-stat.i.ipc
      2.25           +31.7%       2.97        perf-stat.i.metric.K/sec
      1.02           +18.9%       1.21        perf-stat.overall.MPKI
      0.50 ±  2%      +0.1        0.56 ±  3%  perf-stat.overall.branch-miss-rate%
      8.55            -7.5%       7.91        perf-stat.overall.cpi
      8374           -22.2%       6517        perf-stat.overall.cycles-between-cache-misses
      0.12            +8.1%       0.13        perf-stat.overall.ipc
 1.655e+10            +6.2%  1.758e+10        perf-stat.ps.branch-instructions
  82996740 ±  3%     +17.8%   97762479 ±  5%  perf-stat.ps.branch-misses
  73065238           +27.7%   93297913        perf-stat.ps.cache-misses
 7.509e+08 ±  3%     +26.3%  9.487e+08 ±  4%  perf-stat.ps.cache-references
    491567           +32.0%     649035        perf-stat.ps.context-switches
    110242 ±  2%     +23.6%     136250 ±  4%  perf-stat.ps.cpu-migrations
 7.159e+10            +7.4%   7.69e+10        perf-stat.ps.instructions
     11850 ±  2%      +6.0%      12559 ±  3%  perf-stat.ps.minor-faults
     11850 ±  2%      +6.0%      12559 ±  3%  perf-stat.ps.page-faults
 4.334e+12            +8.1%  4.684e+12        perf-stat.total.instructions
      0.55 ± 10%     -29.3%       0.39 ± 13%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_cache_node_noprof.__get_vm_area_node.__vmalloc_node_range_noprof.alloc_thread_stack_node
      0.80 ±  3%     -31.4%       0.55 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_node_noprof.__vmalloc_area_node.__vmalloc_node_range_noprof.alloc_thread_stack_node
      0.94 ±  3%     -31.1%       0.65 ±  2%  perf-sched.sch_delay.avg.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range_noprof.alloc_thread_stack_node.dup_task_struct
      0.30 ±  2%     -14.5%       0.26 ±  4%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.37           -28.9%       0.27        perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.81 ± 12%     -28.8%       0.58 ± 10%  perf-sched.sch_delay.avg.ms.__cond_resched.alloc_pages_bulk_noprof.__vmalloc_area_node.__vmalloc_node_range_noprof.alloc_thread_stack_node
      0.76 ±  4%     -43.4%       0.43 ±  3%  perf-sched.sch_delay.avg.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
      0.42 ± 16%     -45.4%       0.23 ± 15%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.dup_task_struct.copy_process.kernel_clone
      0.81           -38.6%       0.50 ±  5%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_pid.copy_process.kernel_clone
      0.92           -31.7%       0.63 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.copy_fs_struct.copy_process.kernel_clone
      0.87 ±  3%     -33.4%       0.58 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.copy_sighand.copy_process.kernel_clone
      0.86 ±  8%     -32.5%       0.58 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.copy_signal.copy_process.kernel_clone
      0.96 ±  5%     -36.0%       0.61 ±  4%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.dup_fd.copy_process.kernel_clone
      0.85           -38.0%       0.53 ±  3%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.prepare_creds.copy_creds.copy_process
      0.34 ± 33%     -57.1%       0.15 ± 82%  perf-sched.sch_delay.avg.ms.__cond_resched.kvfree_rcu_drain_ready.kfree_rcu_monitor.process_one_work.worker_thread
      0.04 ±  3%     -20.9%       0.04 ±  6%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.17 ±  9%     -31.5%       0.11 ± 16%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.23           -18.1%       0.19        perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.30           -20.7%       0.24 ±  2%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.10 ±  6%     -18.2%       0.08 ±  5%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.ret_from_fork_asm.[unknown].[unknown]
      0.13           -18.4%       0.11 ±  2%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.64 ± 33%     -34.6%       1.07 ± 20%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.dup_task_struct.copy_process.kernel_clone
      0.43 ± 28%     -41.7%       0.25 ± 31%  perf-sched.sch_delay.max.ms.__cond_resched.mmput.exit_mm.do_exit.__x64_sys_exit
      0.78 ± 19%     -42.2%       0.45 ± 25%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.13           -20.3%       0.10        perf-sched.total_sch_delay.average.ms
     59.45 ± 12%     -21.3%      46.77 ±  9%  perf-sched.total_sch_delay.max.ms
      2.32           -18.5%       1.89        perf-sched.total_wait_and_delay.average.ms
   1656374           +26.0%    2087010        perf-sched.total_wait_and_delay.count.ms
      2.20           -18.4%       1.79        perf-sched.total_wait_time.average.ms
      0.90           -26.7%       0.66        perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
     20.62 ±  6%     -43.0%      11.74 ±  2%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.17 ±  2%     -18.4%       0.14 ±  5%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     60.43 ± 19%     +76.4%     106.62 ± 33%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.65           -18.1%       0.53        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     56.03 ±  3%     -45.1%      30.75 ±  2%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.89 ±  3%     -17.5%       0.73 ±  7%  perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     10.82           -15.3%       9.17        perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     33654            -9.5%      30471        perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      1689 ±  8%    +168.2%       4529 ±  8%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     59.50 ±  6%     +39.5%      83.00 ± 11%  perf-sched.wait_and_delay.count.__cond_resched.vunmap_p4d_range.__vunmap_range_noflush.remove_vm_area.vfree
    675414           +24.7%     842197        perf-sched.wait_and_delay.count.do_task_dead.do_exit.__x64_sys_exit.x64_sys_call.do_syscall_64
     69934 ±  4%     +46.4%     102383 ±  6%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1118 ± 19%     -36.7%     708.00 ± 28%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
    652564           +25.8%     821118        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     36347 ±  3%     +89.4%      68847 ±  2%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     62439           +16.9%      72971        perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    104431           +18.2%     123395        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      3.18 ±183%     -87.1%       0.41 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_cache_node_noprof.__get_vm_area_node.__vmalloc_node_range_noprof.alloc_thread_stack_node
      0.83 ±  3%     -30.1%       0.58 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_node_noprof.__vmalloc_area_node.__vmalloc_node_range_noprof.alloc_thread_stack_node
      1.28 ± 57%     -47.5%       0.67 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range_noprof.alloc_thread_stack_node.dup_task_struct
      0.52           -25.1%       0.39        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.85 ± 12%     -34.9%       0.55 ± 17%  perf-sched.wait_time.avg.ms.__cond_resched.alloc_pages_bulk_noprof.__vmalloc_area_node.__vmalloc_node_range_noprof.alloc_thread_stack_node
      0.80 ±  5%     -37.6%       0.50        perf-sched.wait_time.avg.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
      0.79 ± 26%     -37.0%       0.50 ± 19%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range_noprof
      0.51 ±  9%     -42.1%       0.30 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.dup_task_struct.copy_process.kernel_clone
      0.94           -31.8%       0.64 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.copy_fs_struct.copy_process.kernel_clone
      0.90 ±  2%     -32.1%       0.61 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.copy_sighand.copy_process.kernel_clone
      0.89 ±  8%     -31.4%       0.61 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.copy_signal.copy_process.kernel_clone
      0.96 ±  2%     -33.2%       0.64 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.dup_fd.copy_process.kernel_clone
      0.88           -34.6%       0.57 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.prepare_creds.copy_creds.copy_process
     20.58 ±  6%     -43.1%      11.71 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.13 ±  3%     -17.6%       0.11 ±  4%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     60.37 ± 19%     +76.5%     106.54 ± 33%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.41           -17.9%       0.34        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     55.91 ±  3%     -45.2%      30.65 ±  2%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.58 ±  6%     -15.8%       0.49 ± 11%  perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     10.69           -15.3%       9.06        perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.25           -23.3%       0.96 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.alloc_pages_bulk_noprof.__vmalloc_area_node.__vmalloc_node_range_noprof.alloc_thread_stack_node
      1.65 ± 34%     -34.4%       1.08 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.dup_task_struct.copy_process.kernel_clone
     44.32 ± 19%     -26.5%      32.59 ± 11%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



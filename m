Return-Path: <linux-kernel+bounces-343288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DB2989933
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 04:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B851C21661
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 02:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0625B17C61;
	Mon, 30 Sep 2024 02:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iMW5bdgu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CD353AC
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 02:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727662911; cv=fail; b=CpvaY2H+zLtZiMkmoqfu2JZ5K9lgD3Dl4H7mTinkngGmNIYNHsijHxnEY+5X2NIhkGQ2WLAxukZnC3EWAImIUG3buRjjwoRhHKUK5mlyE9VQO/FklPCK8xEJxMNUlBWhlbaC4WDI51yWW/vT5i/OjROQw2ZRdN3rO8UREqUELOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727662911; c=relaxed/simple;
	bh=5o2eRUrfu1N1pE5/qtTBwCai3DnG37tfLE5AUhEK+WA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=kmEavyQIxIcxRN/5MkfGUCucZlm4LxcOe+yACG0YrP3AAfsT8/Q4IdDZK+jIiZa7xeUlc8m7xeb+XdQr438pzE/ze7z/6dIlgSuQhpDjF7Csd2RqIDyPb283FpZV42AcS8CMK5VPakgDxsg3p3Dmke/q6sBzBS9TnnfrGj8xJMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iMW5bdgu; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727662909; x=1759198909;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=5o2eRUrfu1N1pE5/qtTBwCai3DnG37tfLE5AUhEK+WA=;
  b=iMW5bdguIX27p/bCKW9UmDhkvjsTdsW1IVFD47mrdKH3eb75SqktYguj
   3P5FM6Ae7F1wOtm/tDQUnA+7/EEpezlqg6zh+xj/PYCfSQk2mlm8z4dQa
   FSpFNdspRodREtnI75vSZLQ2qHPi21XA4MDyI3URrSzsQXI/n5R4el36w
   gi1k0ycxmcrt/afcW87VZbW2GUnnwbXlqXWujW7vgRovx6fyofF4lUcDe
   iF9ve9GnMQaQCQfUaaPlIflroDL+20PRTrMH0t6k9rahbzWMVr9U+nJKj
   99AB4s1FeYWdv36+nErXAZtQ7RfiMPyk2MT4GqRtgUYIfwrJTSrfFjM6M
   w==;
X-CSE-ConnectionGUID: RdX2Kfq6T6em5pG5PUSfsQ==
X-CSE-MsgGUID: aKiyt3TIQje2at60BlHmQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="14357056"
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="14357056"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 19:21:45 -0700
X-CSE-ConnectionGUID: PUsH+DM1SBaoycncVKNtsQ==
X-CSE-MsgGUID: D+1gg+f+RhSvPwD3O0BoSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="103933178"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2024 19:21:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 19:21:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 29 Sep 2024 19:21:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 29 Sep 2024 19:21:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BskSWEMbDpaA8aHVzxI+24HiiBuE7BmV/e/UfTDIAOp+sgWa0Vq1CXBTkzQz79cN2RL2l5KU62jFMa5v5o9xLEbD5c7OqGF5y1loIlHyhL/f+P05zEn9VCSwO7ppW9YcfaHUU204ebz0rXTyc4XzZwzxqWZe+tOxhfA07xT0hmC+ih2WC6hDAAWcV/jtibRjOl8xZvOZlPhg6fRdMe/8dbqQBa3irOm+ZDXze0TUopV55S7HLlQ6EHhbr36jlvjpGUZMN4lsHmD7amKtxz65XIHrsh3klD0zSz5obuTcbxQyPHzmXuI9BGcAu22HDu2JFBdD8gg1ZuJrtwmbyoV8BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhTD58rlJz9hJZGNC0DmIUH9Kz09Cb1DUl7HvC1TP3w=;
 b=VhdSh2RQB6S7rBCK3tdo5qNbnqOBjrGwK5lVqOJATL3ZGOAAgvi+f5JmZXJ9Z/S26cWDFWf/64c3xC+nbWsy/bua408RvDAL7VCMgZpTGsVl/kvUEWWX/rKpDM6T7sxuC1aeRFvjMaukJW8m0Miq4ypipqT9+PLupQ8wEzPs7ilWZNeMFoNtXwcF0cSy10froubwvlH36mmnBiLbA9nTsYhvg5p5k995tAOfT+f4sMHv6f6F1tGvY0QUKr1A+NvlD5CQRLd7xhqUHSo70PQUH4eHNOPTst80wkzlMQ3IDW89cHuIRMSc6xHnl/PwlYyEVs61uQqaSigRYCX2PGR0Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6382.namprd11.prod.outlook.com (2603:10b6:8:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 02:21:41 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 02:21:41 +0000
Date: Mon, 30 Sep 2024 10:21:27 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
	<vbabka@suse.cz>, Bert Karwatzki <spasswolf@web.de>, Jeff Xu
	<jeffxu@chromium.org>, Jiri Olsa <olsajiri@gmail.com>, Kees Cook
	<kees@kernel.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox
	<willy@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, Paul Moore
	<paul@paul-moore.com>, Sidhartha Kumar <sidhartha.kumar@oracle.com>, "Suren
 Baghdasaryan" <surenb@google.com>, <linux-mm@kvack.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [mm]  cacded5e42:  aim9.brk_test.ops_per_sec -5.0%
 regression
Message-ID: <202409301043.629bea78-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0131.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::35) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 73dd8d70-a410-41f8-c95d-08dce0f69eed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?lS0rmZwzfXMNxGIuiABqnXtxusjOXT1AZSrOhtmPsWWAks1XmJzwhWGlAm?=
 =?iso-8859-1?Q?JX41EwaKRyd6gkZpxRsacMIZsWNpb5R9YWHwl3XaGkORKN5xNNSgkmHLBD?=
 =?iso-8859-1?Q?ghY1RRHduxvMYEG0LTopJilCqN541ESF6/fB3hiuzsG51uoRpN3vrhehZW?=
 =?iso-8859-1?Q?GRgbYbA7DUi6sQ5DwQVIApgzO6AuInzjUJhTH+9o8HfONHVvBDmTZx9Bkl?=
 =?iso-8859-1?Q?t5tlu0RmCoAYBA8v/TJ5t/jf2RpsU1He9epMnZUarwbD5/v2wke1jNH14F?=
 =?iso-8859-1?Q?L7goCQFdVXJpYNITXJlcAahmnYlK1/ahZPwviP1B0bD8XSejaOv6qpoXnj?=
 =?iso-8859-1?Q?gcVdjpRnsZvoq3MEla6KR6Rj4MvrqiHKMYAN+mWsjEVPio64nD4Q53EKKR?=
 =?iso-8859-1?Q?ttF5GDNd/h1OLzlDjynXG+kFPkUmNdLGPEe4HKDYQeCqHvIXrJZSH6Hqmf?=
 =?iso-8859-1?Q?W3OVhIk9F+Cas45/x4XQh6ICbbgCpHmyYpHOwrHlzv8xJZGdIdhwgtse7Y?=
 =?iso-8859-1?Q?UaegQOistWzrvfWXWCgVC0JrMrK/y8ectIn44Zlc4yMHhN8GMzFtTX/YIf?=
 =?iso-8859-1?Q?ekD2aQq2wjcbbRPcltOPj+5Kcc6sH/OCs0qbPx0l7r8dM+yHZp4G78/NY9?=
 =?iso-8859-1?Q?iI5qA3Gmwe1dU0eP+q1Wgs4jluaaPtOnDNe4RI4kB4fFmeVg/s+M6NJoss?=
 =?iso-8859-1?Q?vX6+SF7rq37CGsANztJXBxchtI3Pry2EYQyP5VIuzfxNGEzi/IKKOq/cdy?=
 =?iso-8859-1?Q?lNPHoNDxl0hhY4dwlgIptscbYikqRz6CO1FCvsBm8ji0fstB6Dtr+1ym+K?=
 =?iso-8859-1?Q?QRKVVW0O2k16NMVGRv5RxpWyOqG4xglnvIQNP4XXivQB/JwhP29xX55HhY?=
 =?iso-8859-1?Q?ouzEnm0nNazy4jm9UMePODgZhYAsgExTmZxfhvA+bA6PS7qCgq+3yR9l6j?=
 =?iso-8859-1?Q?cZIPqhcMz+Z0RS35SHU0YC/hpngSl97rf2FQB6ZIyCWO+/5Jq60SNRCOM1?=
 =?iso-8859-1?Q?HOeXSrdyNk4wUodj4SEI+ece0jRktwy0iCOHzRFUgkg5NBLg/k57aHizh3?=
 =?iso-8859-1?Q?nZ3FvlnEgd5mZq/hWK0GFBqMPLunwHuYpBcykcEAHbI/RbJRojy+aDl8dh?=
 =?iso-8859-1?Q?qCnjeEI5ddBpaXT0GDTohnGlUEJ6n6HKkgBADbewzaWn9DVRIhV0cHsQ/Y?=
 =?iso-8859-1?Q?BUiNiy5Xgds581frX7mpNxWYLOpSdF1t3JMTzq59RS0kxO3C/P55AWTbzt?=
 =?iso-8859-1?Q?e98D4uqUSYdMXdH9gAdNKt7JXetgZ5AQxVMnIWwr1xhLanMGWlJibWOrqD?=
 =?iso-8859-1?Q?H0Tk0VmKxphNBP6fWHBOjSO4qE5jN8fT9pkKq2YkUU92/pQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ifSMkxBkzmKsgSqpxpVw5ItIH6jvwO2k1+SaefyyWyOGIh2XZkQv9nHJOM?=
 =?iso-8859-1?Q?ESBXxPtooT/ezVDida2PQnlMwn+Bcm1GYWGtvM1RgE4i4gfg+ElcaORrPv?=
 =?iso-8859-1?Q?UOGhuv4sFXzswDJaEyDaVEKaS6wR8krnO40MvLOjBPsihkn1MUP3Ws7sLQ?=
 =?iso-8859-1?Q?rH6j/WSzlnHM1kNAgQUc3np753U/+Czs84wqwmSt0sMPc44waD6+QjBKEa?=
 =?iso-8859-1?Q?i+T4lWzeg93Cj8NFIgQSG5vzoYtwj3zDB9x7EZ7ftQ6jEMK6sV0ZTQHcfp?=
 =?iso-8859-1?Q?mlGLR4Oa9LsUhs7TupCIyOFhiF6HaxGyoV/REbOmsmhLc4ObzGkYaItcBV?=
 =?iso-8859-1?Q?1DOjrt74w69/kxYpEfs3m6K9YL0I87S/WV4npzpSD3+M5hMep/d0RB8PGh?=
 =?iso-8859-1?Q?4OSHS8qOwDHh/4EMpmWTsHsm7Hhss78IiIszmzeeitTCFkGpTVWPnp7MGa?=
 =?iso-8859-1?Q?c34E8lHga7dYJx82II5u9bb7SYc2bQIX58MDk+c1CYUKdnkT//o/0RcYic?=
 =?iso-8859-1?Q?EYNmYhC7x3sSbzR2MvQ5vQWI+Wgqy4a5TYB+WtKvEtNzmcEaStpkMq6spe?=
 =?iso-8859-1?Q?/qBtEFQ3vEI2W2pSB+ikuEpjBH8KCQ1XOt5bqrpTxW/E118GLOB266ngaY?=
 =?iso-8859-1?Q?Hj9wjWp0vMdUiOz3M28BnHwjAaCP6QvuUML9i7UbebUnbeNW1wC7Ry8Wb/?=
 =?iso-8859-1?Q?VQ/ZuCLiHjc95/PY/EnhQCZP4cwT7ZPfJ1ztLHxZPiu++RWXuoySFGL0JE?=
 =?iso-8859-1?Q?SDl02tILP43co/DCXZi2yq83gvKKK7FBVjELgEkCJId0oAIkv0IMw5sq2E?=
 =?iso-8859-1?Q?pgxtGVWi+3wx6InYmsdia5UwtBp5J9xQETB8/dlgXWP4rhai9J0KdM/HJb?=
 =?iso-8859-1?Q?ehEYWgSCVeu6KLMgjHyOTRehxqjyySjk7VuDOqpqV7txcY16DOFoWleKHH?=
 =?iso-8859-1?Q?JNwizcxZ25E2MffwGEtju9fpi/xqvD7zyGw7gGbaehOIzeTRczr61EfVlR?=
 =?iso-8859-1?Q?M7sSPcLx0H1VUDH0ETjyk92hrW+HtSpDrKbkAOXmSAo+IV3XPd+cTq/H9l?=
 =?iso-8859-1?Q?d1dmCa8iFtP7HUZexdytjfT1l+yPFENs3xjDwkNWPBEzf97ax09ZMgu9l5?=
 =?iso-8859-1?Q?qoPJQtEVwu1tiVl6ckw5ZkJb4HpmuKI2YcdsscWPNYHUR5WJXSz/VDMk9s?=
 =?iso-8859-1?Q?hc49QBxkg63ytDcR7RgnGQDSsVKqQR4RYQ0sQNrh+1M5oNfOJFP2ZVpdel?=
 =?iso-8859-1?Q?E2LAd9abmb9GCZuCRLvMmbuyA3J0A8B5ihhCyfArMKi7PJwbkNYkgpdkFp?=
 =?iso-8859-1?Q?c8JZOV/drs6o29k+f7Zq19BKuu20cmslziXi4Rq/u4asEWp8E18HiGbR5l?=
 =?iso-8859-1?Q?KXI9B8mwNJFfsO4c+O0WzzPNAGR963zXps7zErjfXlnAj+cQsLOK1bP7L7?=
 =?iso-8859-1?Q?gtxM7+0pF5BBfYXqbBNXWzFppZzx5vmBWUx+3pHPxaHB+Jv+PRQ3soNa9z?=
 =?iso-8859-1?Q?CXHA7Kg1KiqAsQREdVMUBY7eM4kzsum82Y0e8jAwbU0cPWP6HPvbApKcOJ?=
 =?iso-8859-1?Q?sfhrSgVmoQjNCPaIblZIzZBfAbqjEWwPIMVsrIr5vjTp7Tvhm9TTSbpiHZ?=
 =?iso-8859-1?Q?teaqcoXWP/XMYyW7Vm1TYYxb29QqekeeUCgf/rudMow0Glav0T47sQQw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73dd8d70-a410-41f8-c95d-08dce0f69eed
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 02:21:41.5761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b30sxE5+MLKSQfvbAgtFGcRdVB+JQe8zlhEXZQP/WcI30dvbmLYoOQPDR1cODli0dO8oZOHAPQwlPJ9bodOeIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6382
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -5.0% regression of aim9.brk_test.ops_per_sec on:


commit: cacded5e42b9609b07b22d80c10f0076d439f7d1 ("mm: avoid using vma_merge() for new VMAs")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: aim9
test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory
parameters:

	testtime: 300s
	test: brk_test
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409301043.629bea78-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240930/202409301043.629bea78-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-ivb-2ep2/brk_test/aim9/300s

commit: 
  fc21959f74 ("mm: abstract vma_expand() to use vma_merge_struct")
  cacded5e42 ("mm: avoid using vma_merge() for new VMAs")

fc21959f74bc1138 cacded5e42b9609b07b22d80c10 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1322908            -5.0%    1256536        aim9.brk_test.ops_per_sec
    201.54            +2.9%     207.44        aim9.time.system_time
     97.58            -6.0%      91.75        aim9.time.user_time
      0.04 ± 82%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
      0.10 ± 60%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
      0.04 ± 82%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
      0.10 ± 60%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
  8.33e+08            +3.9%  8.654e+08        perf-stat.i.branch-instructions
      1.15            -0.1        1.09        perf-stat.i.branch-miss-rate%
  12964626            -1.9%   12711922        perf-stat.i.branch-misses
      1.11            -7.4%       1.03        perf-stat.i.cpi
 3.943e+09            +6.0%   4.18e+09        perf-stat.i.instructions
      0.91            +7.9%       0.98        perf-stat.i.ipc
      0.29 ±  2%      -9.1%       0.27 ±  4%  perf-stat.overall.MPKI
      1.56            -0.1        1.47        perf-stat.overall.branch-miss-rate%
      1.08            -6.8%       1.01        perf-stat.overall.cpi
      0.92            +7.2%       0.99        perf-stat.overall.ipc
 8.303e+08            +3.9%  8.627e+08        perf-stat.ps.branch-instructions
  12931205            -2.0%   12678170        perf-stat.ps.branch-misses
  3.93e+09            +6.0%  4.167e+09        perf-stat.ps.instructions
 1.184e+12            +6.1%  1.256e+12        perf-stat.total.instructions
      7.16 ±  2%      -0.4        6.76 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.brk
      5.72 ±  2%      -0.4        5.35 ±  3%  perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64
      6.13 ±  2%      -0.3        5.84 ±  3%  perf-profile.calltrace.cycles-pp.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.83 ± 11%      -0.1        0.71 ±  5%  perf-profile.calltrace.cycles-pp.__vm_enough_memory.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.58 ±  5%  perf-profile.calltrace.cycles-pp.mas_leaf_max_gap.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range
     16.73 ±  2%      +0.6       17.34        perf-profile.calltrace.cycles-pp.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +0.7        0.66 ±  6%  perf-profile.calltrace.cycles-pp.mas_wr_store_type.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags
     24.21            +0.7       24.90        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
     23.33            +0.7       24.05 ±  2%  perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +0.8        0.82 ±  4%  perf-profile.calltrace.cycles-pp.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +0.9        0.87 ±  5%  perf-profile.calltrace.cycles-pp.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
      0.00            +1.1        1.07 ±  9%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +1.1        1.10 ±  6%  perf-profile.calltrace.cycles-pp.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +2.3        2.26 ±  5%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +7.6        7.56 ±  3%  perf-profile.calltrace.cycles-pp.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
      0.00            +8.6        8.62 ±  4%  perf-profile.calltrace.cycles-pp.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.74 ±  2%      -0.4        7.30 ±  4%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      5.81 ±  2%      -0.4        5.43 ±  3%  perf-profile.children.cycles-pp.perf_event_mmap_event
      6.18 ±  2%      -0.3        5.88 ±  3%  perf-profile.children.cycles-pp.perf_event_mmap
      3.93            -0.2        3.73 ±  3%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.22 ± 29%      -0.1        0.08 ± 17%  perf-profile.children.cycles-pp.may_expand_vm
      0.96 ±  3%      -0.1        0.83 ±  4%  perf-profile.children.cycles-pp.vma_complete
      0.61 ± 14%      -0.1        0.52 ±  7%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.15 ±  7%      -0.1        0.08 ± 20%  perf-profile.children.cycles-pp.brk_test
      0.08 ± 11%      +0.0        0.12 ± 14%  perf-profile.children.cycles-pp.mas_prev_setup
      0.17 ± 12%      +0.1        0.27 ± 10%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.00            +0.2        0.15 ± 11%  perf-profile.children.cycles-pp.mas_next_range
      0.19 ±  8%      +0.2        0.38 ± 10%  perf-profile.children.cycles-pp.mas_next_slot
      0.34 ± 17%      +0.3        0.64 ±  6%  perf-profile.children.cycles-pp.mas_prev_slot
     23.40            +0.7       24.12 ±  2%  perf-profile.children.cycles-pp.__do_sys_brk
      0.00            +7.6        7.59 ±  3%  perf-profile.children.cycles-pp.vma_expand
      0.00            +8.7        8.66 ±  4%  perf-profile.children.cycles-pp.vma_merge_new_range
      1.61 ± 10%      -0.9        0.69 ±  8%  perf-profile.self.cycles-pp.do_brk_flags
      7.64 ±  2%      -0.4        7.20 ±  4%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.22 ± 30%      -0.1        0.08 ± 17%  perf-profile.self.cycles-pp.may_expand_vm
      0.57 ± 15%      -0.1        0.46 ±  6%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.15 ±  7%      -0.1        0.08 ± 20%  perf-profile.self.cycles-pp.brk_test
      0.20 ±  5%      -0.0        0.18 ±  4%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      0.07 ± 18%      +0.0        0.10 ± 18%  perf-profile.self.cycles-pp.mas_prev_setup
      0.00            +0.1        0.09 ± 12%  perf-profile.self.cycles-pp.mas_next_range
      0.36 ±  8%      +0.1        0.45 ±  6%  perf-profile.self.cycles-pp.perf_event_mmap
      0.15 ± 13%      +0.1        0.25 ± 14%  perf-profile.self.cycles-pp.mas_wr_store_entry
      0.17 ± 11%      +0.2        0.37 ± 11%  perf-profile.self.cycles-pp.mas_next_slot
      0.34 ± 17%      +0.3        0.64 ±  6%  perf-profile.self.cycles-pp.mas_prev_slot
      0.00            +0.3        0.33 ±  5%  perf-profile.self.cycles-pp.vma_merge_new_range
      0.00            +0.8        0.81 ±  9%  perf-profile.self.cycles-pp.vma_expand




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



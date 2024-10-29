Return-Path: <linux-kernel+bounces-387930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E769B5817
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CDE91C24952
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3DB21018F;
	Tue, 29 Oct 2024 23:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HSVsQwjF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FC820CCCA;
	Tue, 29 Oct 2024 23:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246086; cv=fail; b=KS+yGkB4bDc9N4vsAMUV3G3Hi8gtUvqf76TsKqtQfeAd48zFvnS0C08Un9EO7hfAaWLhyy7j/ky7i3i9fzXC4r5Iy1s8T3Ph7xYRiqP4UktpfADcGUNgFNlQ00FL5YgljQNJ97nsCeNnKCEPqDGyRYv2oImj8jDaw0MLiL/Dqak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246086; c=relaxed/simple;
	bh=u+5YFbUaY/tHvQ2qp31wVIzwl9QoFx3ur9qb0jboJbQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WZDAVGGYi23GssWGius3KYhG7srCT0bk1jxVDx4rquAfBxHA8EDAwALRcronFfr2u2+SRzHpVPuBmYqID5q9ZoE2R07z6qJfCMlMv2nX6vkbIW8C5TrZOg/xIJKEBJjYp2bxOmgzXZAaN09RSG+uJwerLq4426P86k/tLYLTu/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HSVsQwjF; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730246085; x=1761782085;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u+5YFbUaY/tHvQ2qp31wVIzwl9QoFx3ur9qb0jboJbQ=;
  b=HSVsQwjFyWUvF32ysTDJ5QBz8CnGC5NUO6EydJU+E6Ee0okUZVcQv09v
   azeEl8PzGBt+ja1TePE+EXBpXHJFdQbQFl/+R609Hp6Rw3NBAPLvCCz2V
   o3zOIRP1dIYJfwNyl34/meI+MhF5G5m+E2q5pOW3sTDHrFQlE1dqH/wUO
   P0DFDSW4n1MwqQTV1OlgoiSXAqmfqmGjvbS70FvmqHYqqJxiuiP1fLIwm
   jCxfoITGQXxD46M8nHHd2bZ3JdDWXUkD/8OZ53W3/x2Qfpi9GjIADvDr8
   xt9n1c4AnpEQO6WhhISqQIMIXJilhRpaF9DSiVbmltq3imVLQ78XHUpNu
   g==;
X-CSE-ConnectionGUID: zC2OGxLUSgKHYahyxFyyzA==
X-CSE-MsgGUID: 17pCYBaaTC2ChFPFf47d7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29369352"
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="29369352"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 16:54:43 -0700
X-CSE-ConnectionGUID: BB6+lFK2T9qzguzmf9nu1A==
X-CSE-MsgGUID: XQ9DteoMRfi5dr8ZCtgF1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="82204200"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 16:54:37 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 16:54:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 16:54:36 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 16:54:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGzhKoM51ZHsf0F2kJuzQ3r79KumKG575AdD80d+LRFSbSj85SY2xmtaPve7lF1e1FKd7U3cvJwIsaKMgtOBOToNDxiIelxTE2ypO0Od5eUYjgx8zRA2dAS+jJErjdkau3c/OTHCruSfb9Abs/TEi0L1IhoOwYzSxZDOe2FTRAx4tTfRbnbXgY9kA2MGxIA8wD1ya7K0sPp1rGvxJrQRZqoT/1k/YaN02u8fnAamb+mZxk6yaRD8mtM2C1R2shO5Wd/9d+27wEUFKTKEyveoWUYIe4Nr9dkreRJFdQwbuwN3YaVJ4UsYCaHprIG24FOH5sidfvVRxtt+WFsf4XlVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCnmNoX5Kbuknv55y1NMte6IMmPcnO+X0gatiHz5p8g=;
 b=YqUbXaDX8ohtnM7qA0XS/aUzSkQ0DrRRESbeW+fXvLuW7V9Zr7zhnbYk6RNJz5Xf5yxCaOKizE+h/WbcZPu8NAGSyKtK56CkGRrH2dfAYmp0TiXot9vmbUeskHw8p7Eg05T0QbbT1bJIG1ya4I5DbTzJ/oXx4s1yhlgJQmJn1ehXOYZMrB+8x1V29j66ldlHXd1luKfWs1wSPKY6nwYSGDYr6LxAhmTmJH6VLFEmffdBlqi7MEu9uPykis1Taz/O0cie83KL7KlXjheoBsrz3s/wJCBazlns4wdXoNcYcCtEUw+YPz8LHYkatraYhLR2UP+shsCbyWy0+1heSgWmsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB5972.namprd11.prod.outlook.com (2603:10b6:8:5f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.25; Tue, 29 Oct 2024 23:54:28 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8093.025; Tue, 29 Oct 2024
 23:54:28 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Babu Moger <babu.moger@amd.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "thuth@redhat.com" <thuth@redhat.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "xiongwei.song@windriver.com"
	<xiongwei.song@windriver.com>, "pawan.kumar.gupta@linux.intel.com"
	<pawan.kumar.gupta@linux.intel.com>, "daniel.sneddon@linux.intel.com"
	<daniel.sneddon@linux.intel.com>, "perry.yuan@amd.com" <perry.yuan@amd.com>,
	"sandipan.das@amd.com" <sandipan.das@amd.com>, "Huang, Kai"
	<kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "Joseph, Jithu"
	<jithu.joseph@intel.com>, "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
	"Li, Xin3" <xin3.li@intel.com>, "ebiggers@google.com" <ebiggers@google.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"mario.limonciello@amd.com" <mario.limonciello@amd.com>,
	"james.morse@arm.com" <james.morse@arm.com>, "tan.shaopeng@fujitsu.com"
	<tan.shaopeng@fujitsu.com>, "vikas.shivappa@linux.intel.com"
	<vikas.shivappa@linux.intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "peternewman@google.com"
	<peternewman@google.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, "Eranian, Stephane" <eranian@google.com>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>
Subject: RE: [PATCH v9 17/26] x86/resctrl: Implement
 resctrl_arch_config_cntr() to assign a counter with ABMC
Thread-Topic: [PATCH v9 17/26] x86/resctrl: Implement
 resctrl_arch_config_cntr() to assign a counter with ABMC
Thread-Index: AQHbKlnO1JDAYuQMD0iWPNh4UJ4ctrKeZiaA
Date: Tue, 29 Oct 2024 23:54:28 +0000
Message-ID: <SJ1PR11MB6083BDFA959067B4BF62B478FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <a3c2bdf2153882cc955b80b7d0fcdf7af3d09eb3.1730244116.git.babu.moger@amd.com>
In-Reply-To: <a3c2bdf2153882cc955b80b7d0fcdf7af3d09eb3.1730244116.git.babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB5972:EE_
x-ms-office365-filtering-correlation-id: 3acf0cd0-ebb8-4a50-69d2-08dcf875067a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?BzZhpBMcjrsL/QQ8HpyRyVB/BeHQTRhV2WWFqcky/VBIF2Yjf8cYCYXtleHz?=
 =?us-ascii?Q?pPSljQ/swAhl4iBLzFwVUKMArdrByJLFx5iPX/QleUX2xaSaytMD8weoJN9n?=
 =?us-ascii?Q?iRPv8k9WrqC6W1okoMxc8+KTziRVD66RLZS2dD/D7eIScyW4o8rTREchbqAe?=
 =?us-ascii?Q?5i3lj/jA/Z58MmwJuognEvbOK1U3rllw13hmvZBpaY/HISBM776JXPV20sDf?=
 =?us-ascii?Q?UDuv0pZluhVgQW67EkMeY/R+uNuTxnOFjcEUFDvoVqpgxS9JD1TLCSPUsqBs?=
 =?us-ascii?Q?A2PzrTUyTRGsdhKTLrDwSQMqN2jqp50R22OPxGZxPnZxB6+Kx74kjJGrv8io?=
 =?us-ascii?Q?KXkcRoO5i/wS6T5AWxpW7/W4/JnBpyaWb8OP5/o26ixLOGZyHDmfFiVoWxG/?=
 =?us-ascii?Q?sRrVBgIdcgGoVwIOGMZBLlGjhHEeFTF4twTfLyvwxp18NJEhslBqKIpKvsGM?=
 =?us-ascii?Q?hz1ahmRhEFll6I9oYkwxMW+xualpd5x9/FQuwsmhN6jQJQM6f9JBFiUKmg8k?=
 =?us-ascii?Q?aZnigFLOB+T23JfQjrubfcqVewC2HiL3n/M4pZu1VWfd0Fckrw3epmwRvbch?=
 =?us-ascii?Q?JkGbeJK2VMrHMveseveRAu0VSVzHa93ergdhyLxkM0+vtvhYEfgXQDUcqarQ?=
 =?us-ascii?Q?eBT/BGDqPleVV3VaD4VcDHZqA33d4F3fJvsz9jwDDzU971HVZdp2L6NXSGGK?=
 =?us-ascii?Q?ObV83+WBqg1NvI2Qa2kRGXNZrHKg3NbfqwIi1JBBGVp5Ae7RqfDkVbQS/KZj?=
 =?us-ascii?Q?9rWIZ/rmvUhuKqUsGjTqM7fcJn0i2JbYm+BQtiD1kZ+9syNT6c7khMmFcadK?=
 =?us-ascii?Q?7iaDm+rU241TozRbXflIn0MM1bbq9G5RctKlUWkt1i/TJ/z/cfcccOEvK9wV?=
 =?us-ascii?Q?4TazHaP0EfpzQm7Wv4Osh8+Rga7m4K5lsRvSzz3Z8M9IuJHIiDRoXeqjWRN0?=
 =?us-ascii?Q?D1qSQaVPlnhnTh6HJhrQNfPsmZvw/H5gjMo4QGN6IAw+phm94iNkDDbgcRWL?=
 =?us-ascii?Q?KSESAZ52CvJrvveXc9Si+kfKcTLnL+EWiayqDFsHpPFE5Kp0RpSmO5JDHbqS?=
 =?us-ascii?Q?wf4buZluF7LrkyS0I3Tc0u+0ZvJxMNgadGqk9jO+DimAxboD8DTmTeNi5DR7?=
 =?us-ascii?Q?x7gXP0iB2JlQ9uhi+waDzhDKxWDBqvpeklHzH/+cPIIIYJjDnzmcP9kQ/3xM?=
 =?us-ascii?Q?dgyvxME1HFnRfk798aSGLIwGRx5VP2ByYNJJpY2HcPgNZ/lS7WGNlwjf4DYZ?=
 =?us-ascii?Q?hP7jJFsoBfdnoDATrvRm6oHniK7uzoaG3WOkmukaP2p4fUUWq3L1pxhbJf51?=
 =?us-ascii?Q?SvlJqmsv1qwQ9NagDvvpBSM2QAeQqjhgoP9OsH4h2bla0VjQFbR9wwDo5nMJ?=
 =?us-ascii?Q?wl863D8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FLNWiETR+dhcLhd9Y7000BIFgxGIs9sa7bRQhOjAVGFLqlcVuuY2658hhJG1?=
 =?us-ascii?Q?32fLys85tQ2GyiOeUYsKM1EKmyZZgOkL6YQMd9E0Qf72eh6QyjEuMtrkWaU8?=
 =?us-ascii?Q?aD/sC6JHM4P/2av/Yk8PrJcOQ/EM0IPC7S8wrtHsODF/GVhJ7qkYIPOAD3b4?=
 =?us-ascii?Q?pr8fFv1bp99QNfN+GaTnGVQGRXZAmlH2YoXlw5TsPMxfBIFcTZ+FTFBsZyJZ?=
 =?us-ascii?Q?YbJ0bumozwjusGGcDYIl8oi09nwzPvHDkjboVs/ObXlbnYH4f4rdbNqm/uL0?=
 =?us-ascii?Q?1ib/T7Dq+MQlh17FeF7r/haZDxojFkKzhH4sia+jkhXvO+aM5rbQ/L6vkpqv?=
 =?us-ascii?Q?WLbvrZ/jBkhMRxaD8cgBXeygTafNg28gdRmZfZPLq34Tm6eLteU6XExtpb5I?=
 =?us-ascii?Q?wUjHFyi08E1A5wgSKUZ8FD2hsXxs3eWhpdLGQKr3dC3XTVQEaHXXy0vyzj5M?=
 =?us-ascii?Q?ynNhGvr4a42tUheu9KrGfSuaa+1BRwZfTPZpeD6/EoPYgYvHwvY1ufJCyLFh?=
 =?us-ascii?Q?awbIy0S2LzBOWoNioBJR8LboZV4PSa0g0oz6YBGZs7SFuNbCdc5VBlrPz00S?=
 =?us-ascii?Q?HNcGU6Gmg8QRsBJ+mm6byZG8xvxIvQDu8EEBbVzWXiWsSe5Xn3PV50rJ3KBT?=
 =?us-ascii?Q?ZtVbDVunBetlMSyL+WAombPq+TeOlg6BfHgfocjJXew+n+Q3BZQW9Q3Tuk/Y?=
 =?us-ascii?Q?Mnwe1Glvdk3SC3sMjc1qjU3JKNsE0PQiE+nQPQmDhBhoE3w8NOnQs+UMCMNE?=
 =?us-ascii?Q?PcRbIUn4WZe6vpNL8VikiBaTixp7t7Z0Ek6RicjfDqMhER+TMVEwzX02vOIw?=
 =?us-ascii?Q?20HO0kAQ+2EKCHGwT51mNP0k0snDWl6K7D1a5bz0l3DNT0CVQ+hjzz8EMM5z?=
 =?us-ascii?Q?zzgBC+zn721ot06dcOnCllti9e0WvrB4wXizeya/xFcFeTypswmz/F6a5jFA?=
 =?us-ascii?Q?mog3u3hrIUQ5lr4wPgL2cKIkWC/Mr0UlzMSCk30hvxdS2saES1FT/6thj7WX?=
 =?us-ascii?Q?YGQUol7y9OQvSoFyrZrIgA/dMFllMcHg5JJTvfjn2Q5YoxAjHFJFsG4CvLEP?=
 =?us-ascii?Q?X8BfDzQqzuuqWi6hd5wddDQ30eZmZcH02zP8hMoMzUzHpEvV38GaJfbrBoJq?=
 =?us-ascii?Q?LB/zMdtP/YkBsoCwKmi3NnadBRk2APX1vBciNHn/VcuUeA/C3I3UW83SjUhs?=
 =?us-ascii?Q?qcXPwj9ZXq+Yx0oYmJRRCiEU7yYgVQInqLZH/4YyiUbkTzFSCkAkfwV1qcLK?=
 =?us-ascii?Q?DcbEUZ1PeuOIxp549MPsUyMY34PWL6s653Wh5ad66IZHZvFEUKxT62v5GA0N?=
 =?us-ascii?Q?5taJnr04yQ5smgk0y+vH1YLJETUg1fgbJUEiZD2DENsn2HftBOzbk6EllHYq?=
 =?us-ascii?Q?DT7m2CiiLlKOUzPkuGAQwucewsEGeGpxzfE+Y1F0BfnFvZlHuhj+URigESPr?=
 =?us-ascii?Q?PPwE7+6+m3ZFWslNDrwoL1kQ8AxD9ifPCE7k9S9dyTEXgg58ze7VKCjUQXC7?=
 =?us-ascii?Q?vu6bVltmilgHvNRTFYqg9ZYx2hK1ywNcb9SILdtBsTTHQkznBloiObjGZkA5?=
 =?us-ascii?Q?Hx/PGBw3Z8Lmf41diXmb8h13IVtJQqlC08OH61Cq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acf0cd0-ebb8-4a50-69d2-08dcf875067a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 23:54:28.3077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KoL+/ii2uCKQIfSLlTzK9kwU8WWsL/9VTzjZ5YJrLZb33e7PavmfaOITAT+MpxwjvJ87FGmiOLl533MXTTV37A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5972
X-OriginatorOrg: intel.com

> +int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_doma=
in *d,
> +                          enum resctrl_event_id evtid, u32 rmid, u32 clo=
sid,
> +                          u32 cntr_id, bool assign)
> +{
> +     struct rdt_hw_mon_domain *hw_dom =3D resctrl_to_arch_mon_dom(d);
> +     union l3_qos_abmc_cfg abmc_cfg =3D { 0 };
> +     struct arch_mbm_state *arch_mbm;
> +
> +     abmc_cfg.split.cfg_en =3D 1;
> +     abmc_cfg.split.cntr_en =3D assign ? 1 : 0;
> +     abmc_cfg.split.cntr_id =3D cntr_id;
> +     abmc_cfg.split.bw_src =3D rmid;
> +
> +     /* Update the event configuration from the domain */
> +     if (evtid =3D=3D QOS_L3_MBM_TOTAL_EVENT_ID) {
> +             abmc_cfg.split.bw_type =3D hw_dom->mbm_total_cfg;
> +             arch_mbm =3D &hw_dom->arch_mbm_total[rmid];
> +     } else {
> +             abmc_cfg.split.bw_type =3D hw_dom->mbm_local_cfg;
> +             arch_mbm =3D &hw_dom->arch_mbm_local[rmid];
> +     }
> +
> +     smp_call_function_any(&d->hdr.cpu_mask, resctrl_abmc_config_one_amd=
,
> +                           &abmc_cfg, 1);
> +
> +     return 0;
> +}

Compiling with W=3D1:

warning: variable 'arch_mbm' set but not used [-Wunused-but-set-variable]

[still not used by patch 26]

-Tony


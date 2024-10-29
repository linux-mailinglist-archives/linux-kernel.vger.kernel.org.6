Return-Path: <linux-kernel+bounces-387933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2F39B581D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9F2AB22A49
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108A520C00B;
	Tue, 29 Oct 2024 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xz2NWR/i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425E1207A1B;
	Tue, 29 Oct 2024 23:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246272; cv=fail; b=eQkPnI2OLXtnHvSxAzpXPBhozmgZXmTIEB7c5Ju7YcmBgXelA6r5AnLYuqj++BQ5pzUMHV9tUB2us/JAAa6nM11wnz2DLD6sJUBAzbNokEUQOd0u3vHUDGmzEEtlAzMo1wziA+bAeS712TlSU5CrPJk/kK/OpVofak+6/ZpNA/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246272; c=relaxed/simple;
	bh=bYftIy++/D+9EE2+YaEQtxgOIl3M0po5s/jF7OrnWeE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aj1FoFSlbTADSu1kA/rUujKwQhO3pfcBys6GQyJ+EXBvm3Zp4IZmuWq6OE6vpMdpF6agIZYJmCqJIx+nW2GYmcuWEq5oPzN1FWc0mY9zxEhhK7PiXbejb/ejQMjxxQ5YnzaRjVIvwAsLHRiaSPhBackfCQFKwjAqyiosrSLP2zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xz2NWR/i; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730246271; x=1761782271;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bYftIy++/D+9EE2+YaEQtxgOIl3M0po5s/jF7OrnWeE=;
  b=Xz2NWR/iP1cPs6WzpFEU8JgM8qSHHUswFI8kAQvc5lLFS10EWXzj9/jY
   0asYH3dcAMenzV8Uq2nf7oq82wIfnLtTPVwFmmXbZJATkOZErKJFfLunz
   Dfs8jhZfNPTOebvH6MhR980lwI7nu3HZcIK0Mjz38oQOlN3VeO9FILMGG
   bZCOIWHUjmVDQGtH9GBmBGzntqQSvwro/n6bzBhWkP9jcYgUlWlggubti
   p0ZJzT0vqqTqrbqtkCoGbVv1NrJt37B3aNxx1mzK6fFCCuTwx3DM4DkPE
   2KohF4Rgn3nQbqfy9ri82LoefQtGrjsbh/VbWWQ4X76BP74KBJoZm39tY
   Q==;
X-CSE-ConnectionGUID: G2OB0O4CT92Zb9i80qFeKA==
X-CSE-MsgGUID: 3dCLootTR9C6tkwr4xSDvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30068482"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30068482"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 16:57:50 -0700
X-CSE-ConnectionGUID: qc0qyviBQBucb9sB8A9ycA==
X-CSE-MsgGUID: Yr5Sd1DNT366raed0eUHfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="112964412"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 16:57:48 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 16:57:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 16:57:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 16:57:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvk2Bs93IdlDtacwBJsr2RakRbY7xh88C/jkqH7tWBsnrciVGQEPpIOKKVqghoP3bdmqojm8YWgO73VqX2EHlzLShRC2WvP+XcQW7LtFaVS9tflGGSq5q+jenU3WUoGfwi241HTPVPnG4c3rIXC3BEP98c4pqJzVKJIR8V5MOLsnBtjS7hht+Fr7PvGdxbUm/++1WW+aoOasddPf+8eWP5ovasu29+p16YBbN5p2Rw1pD5nHvOFk3xAspIepQU+kzbyMM9HBmdUiOHpbTuWDUzHMOTAhe73r3wKRSkCM0V0zcdzk3/7cuJwJcYul4zmav20m+JEHC6/ZRJnGOz5vYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYftIy++/D+9EE2+YaEQtxgOIl3M0po5s/jF7OrnWeE=;
 b=ZuO5D2Wk7San4CbUD6xlCu6oH3dU3gbjxLpAPpgSHbeDv4vMB+86SV/vOYmBLXMZ3L4kYS+35L+obvBWlVBPUTu+uIMtOxZnzAJKXP/tUXdSLrSE40Ywc1wakgbN33v3QfdNulUtyPnYZ2D3ZQoAYMELeZ6FInE9NMIZ6dIWuSkbCegieU1ix4mKYBYE6RtzswmOzviUmyqR3MsrfBGGfNfYNiOGZB40PG/gRLEajVLcXDC+4do8h0vcbKFmlgKkMGqOT8C1FXv9YMibYQVQtcdet4vcfnG2CyUena62drU6JhsEsLocHiNSNfRy17HOkj0vQgn6mYw0sNdNpqjGLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB5972.namprd11.prod.outlook.com (2603:10b6:8:5f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.25; Tue, 29 Oct 2024 23:57:44 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8093.025; Tue, 29 Oct 2024
 23:57:44 +0000
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
Subject: RE: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
Thread-Topic: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
Thread-Index: AQHbKlm1EGhgg+VAbE6VjPoeShJya7KeZ6/A
Date: Tue, 29 Oct 2024 23:57:44 +0000
Message-ID: <SJ1PR11MB6083AAE9ACC5EEC584E503E1FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <265f3700ac0c0d33703806fdc3d096b08c992efc.1730244116.git.babu.moger@amd.com>
In-Reply-To: <265f3700ac0c0d33703806fdc3d096b08c992efc.1730244116.git.babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB5972:EE_
x-ms-office365-filtering-correlation-id: 0bc10848-9abc-417c-41bb-08dcf8757b9a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jMp1sYJeVx+K+dS/SgLVRou5zIDWu6RRRvdmfpLhG9Lgw4N9nNksKR6acxbQ?=
 =?us-ascii?Q?o8+ftaYbsrUJ4oGlI12vOQsE0jMSb6MzG+BamaYfkTRagHWJQkodrgKrqO5U?=
 =?us-ascii?Q?1IdMt9YnjWfyq0vdQGHV/fIkFRzQGHaCwcs6RekzedpVEA6uBO3it9NsKLMh?=
 =?us-ascii?Q?nhAKnjnqCdOWQxbKsi4xnacgaUYoLsWY3EyyWNuORJCldBpc5GkOdSkW9o0p?=
 =?us-ascii?Q?nG+eMilszYvP7idkEwFXrN3ReEPlWChe649T1RsPGLbnAl0TFTOt001XbrLZ?=
 =?us-ascii?Q?ri/rkQdknqJZaqxF5I4GvM0vk0SbBFgssJYXn92e2RxhP1i2R6jqfpkjwOrM?=
 =?us-ascii?Q?MQgUN3lr6R9JTV9mERF9mQmaJrC0I6EjP+SzTZhNLh9tWHRSJ9CCRuq/l3d9?=
 =?us-ascii?Q?voZSWeYCr9NDSTLVDqYU4nx26wL4vz5tptGoMEs7MzNEGSYwKfEByCn9MMrl?=
 =?us-ascii?Q?UVsgb8dfAFrQPDhrqy25AACCD6k/w+0U+K9dd36cy2+nMmr7ubATa/P+tj0u?=
 =?us-ascii?Q?MG80chsU1YtG+4n/8K8/PJ/LFIBEUurCT+SlBoYRFtrUsJCgaNreRpfKVcva?=
 =?us-ascii?Q?hb2AdE7+rYKuWky8SXK6AQIHLXUU3rCeA8mMkqP4X3rB1J9JCKK+6iikS1ug?=
 =?us-ascii?Q?8H3hz6/ttlhvZ3ABDSoGoQxIWLuWWkPx7T+JBM/8tkDAb377GjJLV4AdurBG?=
 =?us-ascii?Q?YplTD0OXJPPTzTUODkYlh/AZ+mOd+MHXfJx+Xe/bbHt5KlB37MX7cYOGrH4P?=
 =?us-ascii?Q?6m6W2EPIgzRXF3Ar03TexhAQxmWoVjfat5a0kvCdl55XhRPvGROa46hCp9SZ?=
 =?us-ascii?Q?y8dBdTSzQRhoyAblDf9RbndfbRLxqj32ebzWndIEiIFfxYnHwnc/9nJhOCTL?=
 =?us-ascii?Q?aAXnwG2/OeYdLkfwunWBSCouMVCAdydudQyzAK2B/f8TP7pkyT0uKiwtdbFa?=
 =?us-ascii?Q?0/tWU2BHh2TdJWeGM9WDuhHEU2Q4ZGqIWP2vBTh5mkYuKZm77QqRrB8pqZZf?=
 =?us-ascii?Q?ZCtBTk2INnvOyRlGF/OCGEjmGdbG4tV9DJcwjkuNs18E9j1GCyqMGg4gNEml?=
 =?us-ascii?Q?RmIG3tqyxjR9SgEFiJybP+qXz5oR/NW/u2RAIw67k4sX6AIykEpijiMWEduZ?=
 =?us-ascii?Q?qKfX8SH0Cd+0dnJOEWGbJrRuo1g3V5ejI8Ww8qWeUbXU0rdq1vDVWNhgYWwe?=
 =?us-ascii?Q?nCo0JHSKWCXDGjVjl7t0XJCVCXrM3ve59DnHNrLcUEJvnwHy48q9WtRxj53Y?=
 =?us-ascii?Q?1rAmBTp2xo7o+AT23t1A6Ljz5EqbyVPkzUjdvPFa3b+3JtQ9buYekzFzPjjQ?=
 =?us-ascii?Q?rPBP3bMhH3n23+qhqORWgeu3hJcHpAESs/lGIts6tLxgbqlhfksps0vOcrER?=
 =?us-ascii?Q?Vc8QOeM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g9YLR0lrl+W4qMWhGikzOXE6fiu96afLsQRRILjpzzL4JclY6xSIG8HrX1YT?=
 =?us-ascii?Q?YoAp3W2MEsoShSA6GAV1zM9zuj8A6E3cNb4gblNJE2q9V+mNwVHQHT0nVV8+?=
 =?us-ascii?Q?4ghaB71vr54jYIQZbrCJ5QMxSaEecPAX8IFsryiNT8igWN1sIhd2j5b3oVOk?=
 =?us-ascii?Q?H6JWyJ4idSUQ7CsyoTWZaaogvpiOQvwaPLz96DP2Jg75GTPVZ0jgTWjsZgZB?=
 =?us-ascii?Q?s6DjAnMY0Jtw/7vJ+Gtk2OoVyMdfVs8jXphN+lVJJwHJ98jRhmjC0W+EXY9e?=
 =?us-ascii?Q?BZylJ0ayJlqTcUenM4e8bt7LnfIhTMLLAXi9jSuDLd8vrlFvMPQSCdBUa/13?=
 =?us-ascii?Q?wAMxKYhraWXp52WcL0+/K1PRFAtW5vgrLlo52788Kygqk8FaCTCUgdlQK4eT?=
 =?us-ascii?Q?VmD2xdUxQqO45AOt5W3YI/LUSktZKsdd7xnOODzLZ0VcFfoAcOFB1cRJZOgK?=
 =?us-ascii?Q?plwTZnzC7ozEHDX71nhmjVLGJkwVmzJlSX9Hrio8DTfsFAw6/EPHr6mKXwrW?=
 =?us-ascii?Q?5uWJwmCoAGI6WQoUpmapadiE3kP83R5+8O2FKOqnPW7GjBKa375AjR8aCcWf?=
 =?us-ascii?Q?i3LnNsU4s6XSfYGrwTwIsaWB3ZpuWUBelUM5LSa7jxdDl6VIddNEStjDsrYY?=
 =?us-ascii?Q?2Io+z1aqY+eo0rzD7ePUSLpnF4zksGKfP3iHlsy2ViPPRUvStLKJPgui+/hl?=
 =?us-ascii?Q?JAwvzR7c/1YWto3faotvy4TwTtquiNpbFdD0M+jL9HMcp5DhuufrOmmpx4BJ?=
 =?us-ascii?Q?eg/Wsw4q3UO2QEaU+BvzNmOF9Y3hgr6z8Xy6DI2a+D2JE8qeMhwhaiKLVPKB?=
 =?us-ascii?Q?VXcTYzzAPRXLPz9AogPiuTj2q24Uj1GbhhqybNcMlAmFJ5P9ej/nepr/qzSE?=
 =?us-ascii?Q?ilCkRzieST3PbtvmUS/d4jbgRG09g9jJ8a+sjZrUGo3IPaBehbIwHGj+Yw4i?=
 =?us-ascii?Q?sMNvl/2o2Li6iAfAo0b0Gbo5S1vdh9LnvKb+aVPSvHj2MNhy+/ty/qnfPnX1?=
 =?us-ascii?Q?lo01vfRlGbsVWul8A2fU4URpP++3UVzz2utNlh6MXJ2hJT6a/gS040U0jL7k?=
 =?us-ascii?Q?KHxdlRl/dCBsAIuwp1eiKq+cWcliAYdtkrZKQB7XCYZsOpN0RBf/1MdWUSo1?=
 =?us-ascii?Q?UF0L20k/0E7rdOAQYns1AgTvgaFSt0KhPFyBnmDTvikBSpKhqkLlusvdN8wJ?=
 =?us-ascii?Q?qZu9waWo4vFAtx50J5jj8Z836upO6Vcb5zpi8eZi1XY9KHgiW3JDBD7y1ErW?=
 =?us-ascii?Q?tfSf67tnJdOsErFTcWoBRIGJqbjBXhQrPgfk5IOPfgk9Lo21stt5rniCA0Nr?=
 =?us-ascii?Q?Db9zQeJl0/sbStsfw4/JmmI7G49Mn3uYyRfN+EtRZxrFpZKFr7MOaLOnTyLH?=
 =?us-ascii?Q?nP+gvVYo4M8P2Cdkyo7Z35bbzQu5uZ143pmUOwIL/etdTDPBEqD+OrvLj12J?=
 =?us-ascii?Q?JpSif0QNpE+pxmPzhzytPXxfm36oedMwuc5mnOwtjJBAvVR+cX4Zj6CR4Apg?=
 =?us-ascii?Q?iMUgVzvXtMASEVfgJHTkFr9IIgWCxRzuZenJJlfRQBWC0DFogUSlVE8LQWdG?=
 =?us-ascii?Q?ynh0tN5XF8gYi0JJ1ItcPhrqvEGN/sliXSjjttOs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc10848-9abc-417c-41bb-08dcf8757b9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 23:57:44.8202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /2m8NH7uhMzpTQP55Yt3HJ+gshJ9FMjxayAZRzaj1TXbkwJG7U6j104kf6/HNaszm/pJ2tpe/vtZqhuZmUOalg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5972
X-OriginatorOrg: intel.com

> Provide the interface to display the number of free monitoring counters
> available for assignment in each doamin when mbm_cntr_assign is supported=
.

s/doamin/domain/

-Tony


Return-Path: <linux-kernel+bounces-513665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D87A34D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C221891C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2114C245B07;
	Thu, 13 Feb 2025 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VbdbpKG8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C6245AF6;
	Thu, 13 Feb 2025 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470106; cv=fail; b=EaK5Fke4nA0L6ffM/6WIO3nYBXrHcbQkxdiRymJ1jNXMBiAwHfWVg58mtPl2homtHQQ6hhS9Fibq/vQMOWkYawzCMcP+XUWQImjTE3Ak7F7vLZWSC5RSbOiPyi0QFanwPBU3VMFNn955iiICabSVfXtf3/bnAuwpHfD/WycIjNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470106; c=relaxed/simple;
	bh=S3h03yoIyKaQ4YthSi+fV6k0xtQENbBqW/ozRT3r8SU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jds8BF1TgnKvgAXTAr4YtWlt0ckskixqtHOdzXFcdRCWGcpyhUSX666XNDeg6DBFN3d558FJ6FIx568ajIafOBi8you6gEPe6HmjNbWe4Y2j/Hd+e/uCiP6RVZKtAVQXn8MpDeNrrdR/Wu6i6UdJFfyLt5jknbGSJl50eK9wCAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VbdbpKG8; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739470104; x=1771006104;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S3h03yoIyKaQ4YthSi+fV6k0xtQENbBqW/ozRT3r8SU=;
  b=VbdbpKG89aWyNs2R7w0ja0mb3Ot00bIXndXFmeh8AiCDiAnolXjoUvYG
   0Nx18huvyV0eF9fhpMYxlhfWP+8ynGvg8DRbzAjBlY2lKNOEZzLlGTcHh
   a4AryPIWTkkKmfcFjWBXxlgwUs4gpx40vTNgEmt8LgpJCp383EWThK40U
   YTammocTwHVum0ZpXPpKpjBldZj5h1NKvggHozgMY2Bm6QUZSo/1PCcyM
   uQkchFdTU7OloFPfJgzs+BAiTfYKT3z5uQr8w8vq2ZCuM5SdK4IgNX9vU
   3BavOjDJiU4xk4IZtqj0SX5TK5OOXzpfpcDS9Q+k/21wXe/tYG0dsbtVw
   Q==;
X-CSE-ConnectionGUID: 0+l9uPULR72DA/rMa8vlGA==
X-CSE-MsgGUID: bxqJvPclSCWRGGV2zWrBOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="51175485"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="51175485"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 10:08:23 -0800
X-CSE-ConnectionGUID: GDswKShnTQS+aczB+c5eMw==
X-CSE-MsgGUID: tNa86MN9Q/W5BwAcLubQHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113714786"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 10:08:23 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 13 Feb 2025 10:08:22 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Feb 2025 10:08:22 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 10:08:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmGr4M1YaK+8+SageP65w04mr2Zlz4BuRAsT2f7inlGXz8xlx9M4c3K7QdI4Fx7bCJRc/euJ9PsfgpC9xLWpC9/q4FNhxvthik7y7z7l89UytdKC62R5Ps4JNfZJ3mBMUvsoM25qkzYpyGoKrCoxLfKtAz+vmKxJfXnzI/E9znYzB5CqDOs26q0K+bOOLvQja5/jCEQf/p5MsWn9/GddnjLKDyf9tj8fku1fXmS0B1lqa8ZEcWlB0hdB8JW0wF2avZtSXgx7TbDsqPwDRCrWGMnmDTiAmgDXWskrP7UCdSQsCZBdDDQTWkj4ZcWePQkP/6uupqLtMsP/Zc4P24jtYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dqgX0IHrabBpS0xusIj68PSiu6VtFw5PFejkPXyz+o=;
 b=l+0l2WQE5JcE/i1xWurz686Fm73SpIYVJKRpuMvn/E2tPlEo/5GTzitXcLczx1uFrod4nJkqmb+UIrWjKl/LQqRFXpPDZe2S6So/0O5+AvYbRRopg+i0u9fADxrehrDRxVwSSJuRewJUXTMDxFI7iI4e1Rlia5WXEi5u7fdY+5mhw8cZCi1aKc+GVYZ8rWUrpFsT4EhuVF0r/pOBXXvMYf8/wBx+U1t4hXnbTJFXuJVpRSjynS47qKT7oCfYWw/KRiILAcHFgaJcHhs2IXbRdjUkuMmOFkki6ZSzy/tHcdjabdhaszm7lWtyJpgMnmlaqwW2pp+cb4Z7NcjYKMjBdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BN9PR11MB5292.namprd11.prod.outlook.com (2603:10b6:408:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Thu, 13 Feb
 2025 18:08:18 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 18:08:18 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Dave Martin <Dave.Martin@arm.com>, "Moger, Babu" <babu.moger@amd.com>
CC: Peter Newman <peternewman@google.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"fenghua.yu@intel.com" <fenghua.yu@intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "thuth@redhat.com" <thuth@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "xiongwei.song@windriver.com"
	<xiongwei.song@windriver.com>, "pawan.kumar.gupta@linux.intel.com"
	<pawan.kumar.gupta@linux.intel.com>, "daniel.sneddon@linux.intel.com"
	<daniel.sneddon@linux.intel.com>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "perry.yuan@amd.com" <perry.yuan@amd.com>,
	"sandipan.das@amd.com" <sandipan.das@amd.com>, "Huang, Kai"
	<kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "Li, Xin3" <xin3.li@intel.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"ebiggers@google.com" <ebiggers@google.com>, "mario.limonciello@amd.com"
	<mario.limonciello@amd.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Eranian,
 Stephane" <eranian@google.com>
Subject: RE: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Thread-Topic: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Thread-Index: AQHbbQsur7YXoEmn/USrZUfWgYnla7M1vROAgABjEICAD4WxAIAAApCA
Date: Thu, 13 Feb 2025 18:08:18 +0000
Message-ID: <SJ1PR11MB608379C6C7EF9FB706BCA211FCFF2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <CALPaoCgiZ=tZE_BF2XzeYMRG84x4+kGKfhHWj2Uo=Cre_B_6Vg@mail.gmail.com>
 <7a87b18c-cfba-4edd-946b-dd2831f56633@amd.com>
 <Z64xNm7GrXuVj3gv@e133380.arm.com>
In-Reply-To: <Z64xNm7GrXuVj3gv@e133380.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BN9PR11MB5292:EE_
x-ms-office365-filtering-correlation-id: f5ce10a0-01a2-41f9-8327-08dd4c5964d7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?h+2fnv5mTbB9T8cVEIKk2flJqSIuDbZpiOGafrZnEuJkX9WsflPoMtsALle0?=
 =?us-ascii?Q?lP/Otala8nd0sk0mU+yLvMr3NV8y/7sbWhY3m6MpY5mZI7m6jW+bNkggs1KU?=
 =?us-ascii?Q?JifKCWYzL7RUjkPd34SJCDiI9m+oJkuB0LKUN3MPFmkMC0oUshnMWUI0BvN5?=
 =?us-ascii?Q?rGejPy/ZLfB3OBp+IFqDugy9v8hX4uVAYJ89PatX4j6sYwxd7L5DK0h26Z/m?=
 =?us-ascii?Q?QZd9gQ0ONrslVsJW8htTbmS+xZjLeStnekIIxCrhinm53YCv8kwxHkhv1bn8?=
 =?us-ascii?Q?2Rh/DeDUYvDSYZpvShThm3brvMScYcor+uGHU+YjkZtxc2DPWK/pbz0xUavj?=
 =?us-ascii?Q?dbeTOThPqdRSwuVZH7PgVwd5TWxEvYYXxm5VusUhqSDgH6mvR3np2WfPjoJD?=
 =?us-ascii?Q?L6IwxejfimQnZRl/iO/mUMi/+GJvuXWqEb2JDOXIYszhnlbrEyajJCgmf0I/?=
 =?us-ascii?Q?s2Hr9M+bRAIuDocxrhWKl7CO+LLyUKx8bTSy4fsee8T9QnatKpvbcLQPNTNt?=
 =?us-ascii?Q?EGmpdoLcrKXEM9eHpIF84cNYjirkgVKVeL4A+qHPm9JAZekotDeD7bmA9A1L?=
 =?us-ascii?Q?y8toYVJcgMXSHjoTXImUrir02vlKnl5RiJjh8xYtz8t5Az0HzXPLTsom4irm?=
 =?us-ascii?Q?bM4eDcDM3dT7bW1/yy0Hwp73ILaMUftXHM8F6QEv9/RGvIHEmNdDQuk3vLJP?=
 =?us-ascii?Q?03hDSCEqxYNAFsU34BjiyrTh7Hji8a4eSINg7zwffnDR3+ev74dzhTS3O703?=
 =?us-ascii?Q?J8sJtST7kOppFLZfmGBn0m2i4YDSRQL6YUVolmlbxbyx63VLtgOngzgjmxTY?=
 =?us-ascii?Q?/bAnO/58lFm0R8gwjdz26S1pJI/uzLawmN6UmqGt6KPB+aVOtvsQOEw5h80d?=
 =?us-ascii?Q?ShtAkAeSxivqYXV8jezGzjtMJZ5q6FiKXF8Jp/mqixkamRV/lDei3UzMFBgm?=
 =?us-ascii?Q?kcuH3PVyvVQYvRybUJnBE5lYlQ48XqcPEuvUwImWlGMBzQG6QoAFcpWryh/9?=
 =?us-ascii?Q?xRal+GBe/hpSZvE9YD2o396g49SBZ1jVRE8pwpP4AelSaI783J1+xjLqRaKh?=
 =?us-ascii?Q?0Nd54wtQp1lHocmPIKFJ2nKhoAP3yNokJFdlF4dyvFUZAsriS8NYfX6tcjfy?=
 =?us-ascii?Q?dPppP00B69D5HZkkiZORtXLiLjDagR/3LP1BozbFDt/96xyw+l5LdleyUCOP?=
 =?us-ascii?Q?V204VJf5OOfx1DVSZ5JDggIoulXuBmMhUtjsTsHv5xHf4W6UpVayvf+M0QN9?=
 =?us-ascii?Q?SeCXCdSzSBrGb++0+W1q2zdemt4E82cftljxyyiuw34vSEbppYjUR58riLun?=
 =?us-ascii?Q?BeSyDI/A60NV/Q3IhT0cx8XwhWrvPoKZmb+U+hQuGcJR/d8gPYInEW7KeVtZ?=
 =?us-ascii?Q?ymz+UiXuRoiKgqb77uNfLQknoYkNLK4+zv/baYJ5KoA1LO8XjshhGV9e+9Gu?=
 =?us-ascii?Q?+Veq9HXolJGTlbvkvPLAh2DEs8tt+B+J?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ffApwuzWgAaEvYVmOnr+8xujBzVPdihG9OAMsp4lBWwY6+VAgKlVwl/aPxQh?=
 =?us-ascii?Q?nqjOe+t3V127WNQuC3o+KURSUjzmR1YHhHnfp9JeFK8elGz1HPrIlCvXAYWl?=
 =?us-ascii?Q?2Brhg/AGS8UoDTe8dsM9FmfhFZxXJ2frk9mWosoQkVVsNxwuVqwmCwwRdhhi?=
 =?us-ascii?Q?eVHsl4D9EqfGNJcSh0vxJ7zyLckPvInlqGr9lksww1ZAg+9/F13nJ+hPPwe/?=
 =?us-ascii?Q?IJENW8rAoaHaNFImZWpRMaD6nnZ6WcLduj4+4CjYJR8RrgLm2T/z4e+4k4NZ?=
 =?us-ascii?Q?Bgm4PJwGrlrkHgYlBZu+29IY7BNH1T/7b+WKM1DDAv3BaoFQhQnOHI8f4UFi?=
 =?us-ascii?Q?9DKYFbYyHW7kyYrMbdJfP79zZNbTDLskgoxz9GP3+S02djgMCJnw8oIqyoY6?=
 =?us-ascii?Q?AfEEKbEojvzs+DWy4u1idkCt3GPQsZMBcME0qkllhUt65+we+JkIJ+HwNlQb?=
 =?us-ascii?Q?icT8ckzgblZReuAW6PRaaTRfwbefe7hqKustd9/VEPAZ4SXhkREg4w4Nxkna?=
 =?us-ascii?Q?st3tbTEKH6ZOP6U//ZhSuYr6lyqbHqYl+pzquYAcXIyyXJlRnXuvCNSYw8O5?=
 =?us-ascii?Q?K2b+pccMGHfZ4TlO5BeldroNVK95kH+wWDoS1zPYg5Ftj+kimXk7K9DjyWKt?=
 =?us-ascii?Q?6tkm+Ilq0SsEZMZcKtqBmpsZ1zpnfSe1AHC/pLtox3Nti6Hr9UarFb1JVkPD?=
 =?us-ascii?Q?gjy4a8m3nkEAuohUJbBNOjQ2lWaxQqzqdJC550kqJNdkJ8F4g9M1dj5cnn+M?=
 =?us-ascii?Q?fG9kZOzmPrp4EEazQcNsKdUgYu0JYNMTlVYAhR8W7i9F24g1mqBO49IKh1T0?=
 =?us-ascii?Q?4sJ+tj7PCwvCwH6oTosuMnC7UNqCr3YRNDrSmS0cSTkLXXNGeXUG/hzBfmLZ?=
 =?us-ascii?Q?deo7vPwwL14UsfHd7zk8ZV4POJqeVT1xrcD8sIyO2gcBrsreiH4wUXgrjs8Y?=
 =?us-ascii?Q?sbdJBlY8EBIzQi1gFKxNTkIDEK/6SoVJq0vzbWl1oj0105Yc3kvUEAD7qDYi?=
 =?us-ascii?Q?mPHbO3AmHzbT2cn98cHKBb+kDOw7vBgzQMXFRRooDMXCXbg+HN0M5/eBH1to?=
 =?us-ascii?Q?4o0QEKfWG/p5sasBGbkkiZ+9Wapx2LGlGJRl3SLv34Iu73ymh1uwLtXm3kNp?=
 =?us-ascii?Q?BCs8AEBx39HJ2IA/dtO43ODt66ziJKm2S+u/gI0htnxBZXf4zl682SUsd1e/?=
 =?us-ascii?Q?Ua9oeKYkxbqeKVFOmkgao51qyvh1H5AlHWCLhUXhS8M3cV2CwwYoGJodzW2y?=
 =?us-ascii?Q?mdrHBFQfhAOfHiotbOs9hMHhs1jelZ8++wtq3g5imugf3LxuKcbRpPZKyIDD?=
 =?us-ascii?Q?QZjOk5YbV561xYFBWAL4bL+FQPYE032O/03uRj8NoBggZOLtD4vUYDAVjc7Q?=
 =?us-ascii?Q?G+P7q3aEO0wp+Y7ghLnkVSYinWZrbbEbLDEKfUCVqMrAXKhlvr8KklfK/46r?=
 =?us-ascii?Q?Bx3aWDyX8P5jHcAuVI60rGyLxx1B4ZHDF40euRLFnrFs6ecGRGrtyLOHgnTX?=
 =?us-ascii?Q?qIh3gsDVr2yIx+FCqFBlXyZDSL7cEfbeytcUbzDkyzOCcDXyTjtxtEX973U8?=
 =?us-ascii?Q?A07mCtiOBXzDfGyuv1H1HPY9zdp6PcwjdAQ+g8Te?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ce10a0-01a2-41f9-8327-08dd4c5964d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 18:08:18.3870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NlI8TM4IFW8CYAubQjGVX9nzLBTBay116LxGJVEFXRfgipib1ZJrkQwTV0j9IdyAt/eKONT5JMwaVMIjFEr2IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5292
X-OriginatorOrg: intel.com

> Playing devil's advocate, I wonder whether there is a point beyond
> which it would be better to have an interface to hand over some of the
> counters to perf?
>
> The logic for round-robin scheduling of events onto counters, dealing
> with overflows etc. has already been invented over there, and it's
> fiddly to get right.  Ideally resctrl wouldn't have its own special
> implementation of that kind of stuff.
>
> (Said my someone who has never tried to hack up an uncore event source
> in perf.)

Initial implementation on Intel RDT tried to use perf ... it all went badly=
 and
was reverted.

There are some very un-perf-like properties that we couldn't find a
workaround for at the time.

E.g.

1) Cache occupancy counters. These change even when your workload
isn't running (downward due to evictions).

2) Counters based on RMIDs show the aggregated values from multiple
CPUs as tasks are scheduled on cores.

But maybe you meant "don't let resctrl use all those counters" ... hand som=
e
of them to perf to use in some other way?

-Tony


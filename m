Return-Path: <linux-kernel+bounces-361864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C40E599AE10
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE1F28557C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC471D14FD;
	Fri, 11 Oct 2024 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6gOHKs3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D41F193436;
	Fri, 11 Oct 2024 21:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728682457; cv=fail; b=rGTP8T1blWe87kFhghtBI2nmSue8jRBkukJx+yOZ52ouJOCkmEAc6AvU4MUz+34sYB/Yvg0FvpriZ/vKBmW8oz90lJtVuDDlbwYOMzUwYwEZf7woSKSW+pA45ws8t3UizRweB70GyDGuMpDLKUBFMZVI66uBUphaPm2oXDqNX/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728682457; c=relaxed/simple;
	bh=2cixJZmxJHyNuHBs1tMYBiEy4mVI5rRMS99D7WyViv8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=onvWbqF+YNJwCErxVKfib9H4XrTmbRlyzKgtlLa7DtG2+9BS7QDQHkcHj0wpmSK9c4kSV1MocvqFD7k+rxAEU+DGA3STaQGLzuWzOHRTYrbnEQwfRZ91EDgn9KNKUljR1NfDCYFXhfmIMCCV3aQzbhyG29GMVa+ZHZpB3w9HAOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6gOHKs3; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728682455; x=1760218455;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2cixJZmxJHyNuHBs1tMYBiEy4mVI5rRMS99D7WyViv8=;
  b=j6gOHKs3KCoZ7yYV8XUe765PS/TmG/iuvLKGdyxZqU0A6cA9n1/VnQiv
   hLEj5BS/PiLIgXrOW3ip0u5DqWjv9svgTPXAPXEHo0RXXhn1mT5ijvoE3
   8gBxX9thzqNnhgxJ43N+nj2Q6JzHuyMoB3yZu9kzarLOKssj2xbpsfhaJ
   QjSHs2VKolf4APMmg9BMPPFkCsugQzAsLtbG+78hAWWCY9QO6XSTxOz0a
   5JDLNrgJax2Ouh5UBhDg05APLtZLnh5+4RnJIoA8lDlOsKJof+gknAViJ
   kA1mf2soy3oudzOuk3xRXwo/gUwsmWxN84tjBDEoUaknY+uyYfj0nPN52
   Q==;
X-CSE-ConnectionGUID: ubNLxbWaTZ2mhpWgEvfLLg==
X-CSE-MsgGUID: iWkyCluTSAS11Oo3cv2yEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28185760"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="28185760"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 14:33:59 -0700
X-CSE-ConnectionGUID: f5AYp0ZsRa+y1g4UO8TwUg==
X-CSE-MsgGUID: bYRJJnH0R2uAK3Q2iJtfEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="81582995"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 14:33:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 14:33:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 14:33:57 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 14:33:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+XyDCBuOYfS9lxSTzauscfoF9nCso1nXkWfVvg61pZojwq5LDu1TRzrSPCrE/AfeGSk05IUJYDaPT9nlqN9CCwSLXx7Sli3WruDwucRP6zM0mJFqAVxPZRN9OCSZ1IGUqZnOwxDRzvvscoltqPBGuf4O1bSuGCxkXQpkJzSlC+x0InEU4lvZK6IiUyeVXBiRk6CuL9PE5kn3kOWHCuyDCfB1on/3Ag6dsIZvN745vgDOlrmiKohOCHlX93Ed5gIZSzrpTa4gmq+50oGpWz6nM3SR/I/hKdoM5brkYb24PfMbvMK1bwJQ2ANiW1cYk7MCLIXKtvMAP+nBrhIS/25RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cixJZmxJHyNuHBs1tMYBiEy4mVI5rRMS99D7WyViv8=;
 b=JTgowPSH0cxK1n+gR1JUM990HET4ECtfvlMa3DkiCCg2E8x/4+n5UyH9pUo1rSOaWtI7TFZg/TGFcImFJJv07yb4tqa8MCTFXmzx7/G5yjan/meyJHQBf6Vjga03bef5fvYxNkBEKURFoWZfn89Y0/Vbh0ubfcmY3uHvKP/DnGAhf7PgKuLvuq/n0fVIzev+C3xlmM4Y4rRGykgx4A2qlBlV3MRinx3OxnsyB1Law6Ua6GUdlmH7vE5xhyzNCiFA3gf08jozToF4RbHEtaB5vAPLHcA8/lCYRfshcIjhima3aemWxtepIFDQCjVqTm0ehzLh5j75sfPdlWFVuJH3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ2PR11MB8513.namprd11.prod.outlook.com (2603:10b6:a03:56e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.28; Fri, 11 Oct
 2024 21:33:50 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 21:33:50 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "babu.moger@amd.com" <babu.moger@amd.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "rdunlap@infradead.org"
	<rdunlap@infradead.org>, "tj@kernel.org" <tj@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "yanjiewtw@gmail.com"
	<yanjiewtw@gmail.com>, "kim.phillips@amd.com" <kim.phillips@amd.com>,
	"lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>, "seanjc@google.com"
	<seanjc@google.com>, "jmattson@google.com" <jmattson@google.com>,
	"leitao@debian.org" <leitao@debian.org>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "Joseph,
 Jithu" <jithu.joseph@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "sandipan.das@amd.com"
	<sandipan.das@amd.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "peternewman@google.com"
	<peternewman@google.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Eranian, Stephane" <eranian@google.com>,
	"james.morse@arm.com" <james.morse@arm.com>
Subject: RE: [PATCH v8 19/25] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
Thread-Topic: [PATCH v8 19/25] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
Thread-Index: AQHbHCMZy8Wwr2V7rU+ufFFthG2iObKCDytg
Date: Fri, 11 Oct 2024 21:33:50 +0000
Message-ID: <SJ1PR11MB60838F3FFF40AE2718ED7833FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <ce07d802260f537b24b3affec57c2d2e65023709.1728495588.git.babu.moger@amd.com>
 <ZwldvDBjEA3TSw2k@agluck-desk3.sc.intel.com>
 <541d6c15-ed5f-8794-506c-8fa4065ca170@amd.com>
In-Reply-To: <541d6c15-ed5f-8794-506c-8fa4065ca170@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ2PR11MB8513:EE_
x-ms-office365-filtering-correlation-id: b7138f86-57a9-4610-ff89-08dcea3c6578
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YUxYUjNlN0t6em9GUGMyVzhaS0RPQnZ4NFZhRWZ0T1Jsd2l1TGlBZ1NEUWRi?=
 =?utf-8?B?OTZSVnNuc05xblRLdnZyeTlkWG5qYjUyQTFkT1VEWFlQZHpEbnQvaStKN2FU?=
 =?utf-8?B?UjUyRUR1a0szNDhydWxiTFJnRFdZSHIyL0ZZbnRKK3NMZ0J1eVlqaGdIYnBr?=
 =?utf-8?B?MDZYbUUyRjkyRE1HSVg3VXdhV2VHRFB3S2hiYzJFUm9LSTJhK3h0aEpLYy9w?=
 =?utf-8?B?VlBOeU1YZGhKWUJyd1dvdDhsTTFiVEQvL3AvdURzUzFkaGVTOXFZNi8yM1lu?=
 =?utf-8?B?OVQvM1psZnRzVS9EVjBaeXBRYVVZMlJwdmZDOGFQY1NaMEZReS9aOEE1Nmdj?=
 =?utf-8?B?S2IyWU4wUGJWTThIVGluZTZYRG0vWEVoSXlMblVnRnp1L3JSczNGVlMyTE1N?=
 =?utf-8?B?T2laaFZDVVVTekp4VnBCS3g0eVQ2eCtEclFCMXlSODhSMkE2L0VPcGF4Wmdi?=
 =?utf-8?B?c2VBRFNEKzR1QmJWQUllYTkwa3gyVk5LdjArWFY0NXdSQWR6SkhKbnJBQURa?=
 =?utf-8?B?RUZEQjg4OXgzL3ZtNEdDc1QrSDlFWkNTSEN0eFJrVGI2MjhFTmIvSVh6WG0w?=
 =?utf-8?B?OGVseUJVS3lTUGNXdk5jUHcrUTd6ZXY2OUdTQmFxZXlTMi9JVUJrWmpvRmFr?=
 =?utf-8?B?a0U0M2VBbENHU2RKZG9LVEVNL2ZNa09qVDZNNThNVjUzejZkWnRPN0lmL3ZQ?=
 =?utf-8?B?Q3pBQXFPL3BKMW1ZN00wRDhrNDlUY2lUeGRLTi9yRG1ibnZ4V3NPNVNkQmNx?=
 =?utf-8?B?d0NNZFJxV3lFa1BVZHd0MGZWcFJxVDRYVFNITDhuRm8xL3VmYXE2ejFpNVlO?=
 =?utf-8?B?ckZMQmRCV1kyNjBiWC9GaC8xdWRyV3g3TFJBUFpaUDdETEFidjAvZ014M2JN?=
 =?utf-8?B?OFViRlhRWkQxSGR3RUNFMlYvT0VmQ0t3ZjhiMS8rNmxMcG9xdjJpNXZoYTU4?=
 =?utf-8?B?R0FlMkM4bVExditTZnc5NjBud3BDTmUxRWk1ZFBBZk9YbUNwenQ4alBKVDhm?=
 =?utf-8?B?LytKYmNERFBvZytnK2srczZGbkgraE11NENqcm5HZjJxRVhWTktEZE4zVzVn?=
 =?utf-8?B?TEdXNTEzajQwMmpiZlV6UWVFcWFqT2hEa0t1Sk51aDhvOVk4QjQyaXRXanIr?=
 =?utf-8?B?YTVlRldoQW9IdGdnMkgrSWlOT3lTRWFXZDBrL09xaXVTUGN5WUtFMnlVdHlT?=
 =?utf-8?B?RDB1Vkk2ZVV0aTNTRU4rOFI5TzI1RjBMckxpU0c4MXoyaUkwSDAxeU5EODcy?=
 =?utf-8?B?UkpUWlUxQmtoeHZBQTJnRVdSeGx4bCtYVWlkb2czZ0NCTGVWQVJ3aElvUmVS?=
 =?utf-8?B?elV4UGdvWVRNcFNMcnRUbGhBQlZpZzJsOTl4VHQ5WjZyYnhpTU9yaGtZaUxv?=
 =?utf-8?B?aDI4OVpwVXF3RnpVc2NqL2JPd3lrZEJ0WmpJYkJqZTU0cE1qa3NyWkdFcTZE?=
 =?utf-8?B?UVpPQjRFSXhuQ3pTWVlxZUJOVjNnVHE1UEVNem9XUkxUT2o1WW5xZUJVVENa?=
 =?utf-8?B?UHBwSTdTaUpVQmREV3BmRlNXa1VRZlZhQlZrbjFmcmNyZWtaQm83OU5CdURv?=
 =?utf-8?B?dS9PeW5hUW9DMWtVY3pob3c5dmZtN3hpRkRrS3VVSWFVMS9EYW5pbjAweDNx?=
 =?utf-8?B?MEFhQjJCTDlRUGRiSWFYZHErK3ZnTXhyck42ZE5XajFiMUFkRHpwUVNsb1c5?=
 =?utf-8?B?aFE2eXlFR3AxSzRINHBVMWszM0hnWGdOZDRLNmxDdkQ1RXFMajRuN1lzNEYv?=
 =?utf-8?B?dTVBb001eU1pVG9QaUo2Q2pNZ04xTjBPR3RRNVBLZUJiQVVHK1NnRWNHNVlB?=
 =?utf-8?B?eFpLSmVmL0VjR1hOcjMvZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1h5Tk5xUElZUWNqRHhNRmZuYTJ2SSswN24rT0YyMi80Qzg2STFWMGdMQjRI?=
 =?utf-8?B?bVZybEFoYVZVcG9ZOGQ4Ni9Vb0FxN0U3TldGQkNYZlp5amVhQjg2SkFYNlVk?=
 =?utf-8?B?UWpKVEJPOGhCdzVpZ0RVaTVOdzF3NDZxNFhCVU9rVWYvdTc3NEZCODRpU25r?=
 =?utf-8?B?UE9zSW5idGVvQit5UXNTbmZDckd1YjY2ZDhnb0FOVzY0WW5RMVBIUlpMai9Z?=
 =?utf-8?B?cEZjaUVPdmVJbFlxTVJsRWtyS2ZveG5VeUVSZUF1M1crdHZKVWY4RnJ1bHBH?=
 =?utf-8?B?MGpIOS9xQ1k0c3VkZndhZTcyeXZ1ZnBrc1c1QXRpUUFPNkUzb1hocDNLUUFh?=
 =?utf-8?B?QXFjTURwL0RSQmYxSFdWS24wYS8vRHNLRzh3NDhQTEU4TnlDa0ErTmlWTzUr?=
 =?utf-8?B?RzNPR0tlQ0NOUHRreEUwN0VrbDhLeFhtaFpSSndXZCsvaFRpV2tSdDJ6SzdF?=
 =?utf-8?B?WFJsVENqSG9WOVdWYnpiTnRlb3dGd2gvOE44d0pWeXY3dmFrdXVydWE2ZFRj?=
 =?utf-8?B?OUlCQy95cEZ6OXVBWlRTUUZvckI4Z2c3T0FFdHZUMVQrTlY2ZEhnbnFIWGVt?=
 =?utf-8?B?bG83Q0NxNjhUUDJWR2tUb1hwaUU0QTdpcFN3ZjJhSWVYUkQ0ZHlVbTFXRm9i?=
 =?utf-8?B?RGhSZThmTTlMeExGSng5ZVROc2lYNXJoTFN4V080czdTN09uUkprai9Sditx?=
 =?utf-8?B?MG96OVNiY09QNnFxVXhDRzViMnRiZnc0U0VyNjNZTlFHVEZNT3kvYkdmdjFB?=
 =?utf-8?B?NVBYQVM2Mll6OVdzRWpjUUNRcXFoQzczK2JhOFNEaFppVDBMOS9TM2sxdCsr?=
 =?utf-8?B?czUxTkVxZXl4QitRK2l6ZDBWczFIZDJTRlRycXA5a1FwMlZiUHZPdTltN2hX?=
 =?utf-8?B?MUtNMmNqR1NJcCtROXBFQ1FQdGhxQVpMa0tQUmhyNlUxWk1zMEt4elZmdlBM?=
 =?utf-8?B?bUU2MVE1NFd6R1hheDg4aGE1WXdoMFhhckNCQmxOVlV6aFptZUdGL1ZNWjFi?=
 =?utf-8?B?NEFQSldCNjh5a1ZOaEVMaC96WUJJOW1wWlZlNWNkYVZyTU5tZWxmaDdEVmFU?=
 =?utf-8?B?bU05VmNveUQrdkpsVm1QUEZ6RWN4TDJKSXR1YVRoZnVxTE1yZGZzeit4cnZY?=
 =?utf-8?B?bFRISjB6M0ZoK3dTTFU0TkVqTUpjWGhzVkpmMVZXL1Zza3pBRnZYSEtJVi9m?=
 =?utf-8?B?ZmZDNXNwQTJVR0hsaS8zWFhjcjdmRUtDQWhSRi9jR1Z6TnhIdFUyN21pWTZy?=
 =?utf-8?B?ZUdVY0ZubE9ISm1ZNllWMkM1Z2VDaVR1Ny9BNVZpRUFNaUI0dUdINUR5MWEw?=
 =?utf-8?B?b09wa2ErblpnQlFVcGtaT21xazlkQ0ZLVWxZdGtlSUJCSGdySkRxUGN6ZmJu?=
 =?utf-8?B?MlgwOU51WXpuN090alprY3NGQUdBQUdqS0U1MG5yRFhDWFhLQU5FYXNiLzlP?=
 =?utf-8?B?L2ZwSzlycndRTHlRS0FIYnl5Q25Tb09zclY2REtXa2ZRK2hBUG5Cc3V5TmIw?=
 =?utf-8?B?Vm5mMUQ5QjZZWnZMczdlcmpRbkdHQWdDY2pxVitIVlZ6ZzM1RnR3dlFzeU05?=
 =?utf-8?B?MU1URXQ4ZmtDZEt5V293TzllSjJqbDRHOHhxLzgrOFl2VytLNnpFSmNSeGZ4?=
 =?utf-8?B?QkFqTXRPNE4wdzVZVEJmQklDN0VSa29jUjlqRTBGYTE2ZXZRdDdRK1I1QTlm?=
 =?utf-8?B?NXREVlFUZzhVNnNTK2NjNWtGSURYMkFUTm5jdkszeFhhV3d3VTdqbmRzS0FV?=
 =?utf-8?B?bkN6SWJjNzBzRCtxTk9XUXdoTXE0UW5nb3NObGttdWNibkVOR1VMYzVrQWJD?=
 =?utf-8?B?eHEvY2xGMFp6LzhzaUFXbHRIQUZZaklDOTBLNExlZzhwRE1VdkIwblplVHZN?=
 =?utf-8?B?dUhRK2hzMEZNdC9xalhYTnJDd1BkRldHcCs2TjJDdlRhODRNSnZsNWdqdWFp?=
 =?utf-8?B?c1NtaTlIRnlreW55bEpJRnQrSlNFREt3Zm1oaklSb2oxSCtWNmpDTEZ1N2Ew?=
 =?utf-8?B?bkdpVUZDdUhxMHVjc3dzTkIrNjNGL0x5MDlkTS9JMnA3dENlZEZBaS9FdzRZ?=
 =?utf-8?B?KzhSRGVSYUlPYkNydnZmbEVoNHhQRUM5UWVIMzJ0N1pPZjh2NVBqTDVHVEpN?=
 =?utf-8?Q?up+s8oRg/Kw3oZ9SsCCSH3UmQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7138f86-57a9-4610-ff89-08dcea3c6578
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 21:33:50.0780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2u5sKhD/T2qkTF3jT8qeg2c7MugNOwpQp48LgGP+POGz6XHcrnoKL2tbRLXnhbkbAdcEJj/0D0Mjo4ztkgIcVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8513
X-OriginatorOrg: intel.com

PiA+PiArc3RhdGljIGludCByZHRncm91cF9hc3NpZ25fY250cnMoc3RydWN0IHJkdGdyb3VwICpy
ZHRncnApDQo+ID4+ICt7DQo+ID4+ICsgIHN0cnVjdCByZHRfcmVzb3VyY2UgKnIgPSAmcmR0X3Jl
c291cmNlc19hbGxbUkRUX1JFU09VUkNFX0wzXS5yX3Jlc2N0cmw7DQo+ID4+ICsgIGludCByZXQg
PSAwOw0KPiA+PiArDQo+ID4+ICsgIGlmICghcmVzY3RybF9hcmNoX21ibV9jbnRyX2Fzc2lnbl9l
bmFibGVkKHIpKQ0KPiA+PiArICAgICAgICAgIHJldHVybiAwOw0KPiA+PiArDQo+ID4+ICsgIGlm
IChpc19tYm1fdG90YWxfZW5hYmxlZCgpKQ0KPiA+PiArICAgICAgICAgIHJldCA9IHJkdGdyb3Vw
X2Fzc2lnbl9jbnRyX2V2ZW50KHIsIHJkdGdycCwgTlVMTCwgUU9TX0wzX01CTV9UT1RBTF9FVkVO
VF9JRCk7DQoNCkNvbnNpZGVyIHRoYXQgdGhpcyBjYWxsIGZhaWxzLiAicmV0IiBpbmRpY2F0ZXMg
ZmFpbHVyZSB0byBhbGxvY2F0ZS4NCg0KPiA+PiArDQo+ID4+ICsgIGlmICghcmV0ICYmIGlzX21i
bV9sb2NhbF9lbmFibGVkKCkpDQo+ID4+ICsgICAgICAgICAgcmV0ID0gcmR0Z3JvdXBfYXNzaWdu
X2NudHJfZXZlbnQociwgcmR0Z3JwLCBOVUxMLCBRT1NfTDNfTUJNX0xPQ0FMX0VWRU5UX0lEKTsN
Cg0KTm93IHRoaXMgY2FsbCBzdWNjZWVkcy4gVGhlIGZhaWx1cmUgb2YgdGhlIHByZXZpb3VzIGNh
bGwgaXMgZm9yZ290dGVuIGFzICJyZXQiIGlzDQpvdmVyd3JpdHRlbiB3aXRoIHRoZSBzdWNjZXNz
IGNvZGUuDQoNCj4gPg0KPiA+IFRoaXMgb3ZlcndyaXRlcyB0aGUgdmFsdWUgZnJvbSBhbGxvY2F0
aW5nIHRoZSBjb3VudGVyIGZvciB0b3RhbCBldmVudC4NCj4NCj4gVG90YWwgZXZlbnQgYW5kIGxv
Y2FsIGV2ZW50cyBoYXZlIHR3byBkaWZmZXJlbnQgaW5kZXhlcy4NCj4gQ2FuIHlvdSBwbGVhc2Ug
ZWxhYm9yYXRlPw0KDQpTZWUgY29tbWVudHMgYWJvdmUuICBJZiB5b3Ugd2FudCBhIHJldHVybiBj
b2RlIHlvdSBuZWVkDQoNCglpbnQgcmV0X2xvY2FsID0gMCwgcmV0X3RvdGFsID0gMDsNCg0KCWlm
IChpc19tYm1fdG90YWxfZW5hYmxlZCgpKQ0KCQlyZXRfdG90YWwgPSByZHRncm91cF9hc3NpZ25f
Y250cl9ldmVudChyLCByZHRncnAsIE5VTEwsIFFPU19MM19NQk1fVE9UQUxfRVZFTlRfSUQpOw0K
CWlmICghcmV0ICYmIGlzX21ibV9sb2NhbF9lbmFibGVkKCkpDQoJCXJldF9sb2NhbCA9IHJkdGdy
b3VwX2Fzc2lnbl9jbnRyX2V2ZW50KHIsIHJkdGdycCwgTlVMTCwgUU9TX0wzX01CTV9MT0NBTF9F
VkVOVF9JRCk7DQoNCg0KCXJldHVybiBzb21lX2Z1bmN0aW9uIG9mIHJldF9sb2NhbCBhbmQgcmV0
X3RvdGFsOw0KDQpOb3Qgc3VyZSBpZiB5b3Ugd2FudCB0byBzYXkgc3VjY2VzcyBvbmx5IGlmIGJv
dGggb2YgdGhlc2UgY2FsbHMgc3VjY2VlZGVkLiBPciBtYXliZSBpZiBlaXRoZXIgd29ya2VkPw0K
DQpCdXQgaXQgYWxsIHNlZW1zIGNvbXBsaWNhdGVkIHNpbmNlIGNhbGxlcnMgZG9uJ3QgaGF2ZSB0
byB0YWtlIGFueSBkaWZmZXJlbnQgYWN0aW9uIGRlcGVuZGluZyBvbiB3aGV0aGVyIGFsbG9jYXRp
b24gb2YgYSBjb3VudGVyIHN1Y2NlZWRzIG9yIGZhaWxzLg0KDQotVG9ueQ0KDQoNCgkNCg==


Return-Path: <linux-kernel+bounces-438843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A909EA72B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 05:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71871664F7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 04:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD0512BF02;
	Tue, 10 Dec 2024 04:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDjZRTg/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2371BDF58
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 04:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733804675; cv=fail; b=n7+C7dhUB0iVFBiuoDGQViK2GcSYaE93YadjVRLWHj5E2Gc+B3S0uhw9Or293dqAqtjsHU5vb2ENKwV7g3AAFCwJEScMLK7LN+M1x2GF3EjMQzWKgZjfGEEfC5EftGb3I9Dg3ZFY27vE0Hi7+Y6AlAd1MFKV+KOBEzmZVUdaV5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733804675; c=relaxed/simple;
	bh=Rtz6lq3PAzzfcJUeu0tHXnIu88dTU8D6t09T09RVvOU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ue7YGyg2+rtmH6gDTbIFT3pPTShMO2Oxkv3koi5rH8huj/CRVL92EpIesv385ABmrsl7JkCyTCc+nQVJKTs/LKQJ9RkNgLTI1fAAfe79/DUqmACRCYIIgvpJfF/icneWkQ7ZegfLu+2dTYrsfcvxRZUFQtiugRIL5pzEzEzSy/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDjZRTg/; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733804673; x=1765340673;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Rtz6lq3PAzzfcJUeu0tHXnIu88dTU8D6t09T09RVvOU=;
  b=dDjZRTg/A4fYqOZR5LjRwROZzemXasO5sVZbC7apD+2wtCWJQBx7zN71
   JoKSbhTaky6LG6oR7qxoxu3o+QP5DZAKA1d7Ur6OrlWBq2yW4Z84pdWwl
   kamcCzuM4tW/feXu26dScRtKiKYgfg/aUTnaUD1cK0qko3biJzOu9eMXe
   WB8iZVlhwIajhoNKe76f9EYiFIFSfN3+9JEDlhm5Jhi9g7Zb3nMCXGj7F
   +jTR/xSc3wxlQWSxAfkxQ/zHX31R1Lsqhfwu+lKKAo5PHbSPxzg88a9aq
   59iycV8TclIVHhL6wwK+UibLBxVbL/N/5MsZtj025MdIJyG/GPvzxB4uH
   Q==;
X-CSE-ConnectionGUID: ilGnUwmpSXqzDLRVvQkRmg==
X-CSE-MsgGUID: Wd/yus8MTi23pRbk49LR6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="37816037"
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="37816037"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 20:24:32 -0800
X-CSE-ConnectionGUID: mrCzcs6TR4qUJjC3v8V0Fw==
X-CSE-MsgGUID: lVlemg4BSgq6ieoVed3j7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="118527251"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Dec 2024 20:24:31 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Dec 2024 20:24:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 20:24:31 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 20:24:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igLRU949ClXqWUv9BfdKLRP64OatmXu+u4rye1ANEmWLZRMYC5rjas5y1CI8YAC0UHYhcu1YGT5/oxOaxdreREpvzQWP71Bo5Q9k0QPF6VCRaVjkFEv0H0d1sXax76qZw/89W4gr93XY4kAJJm0MvMvupp6rJ1KH0Y3hzfW2+dx5LMVZPXLyvCOJUEBlVpizyeLvZK1Zv1Wjn9r83mzoPzxMQD9H+HrEpPfUsYZ1qkZ7ILDfdHWA5sdXEtY9EOCGxuPa/JaDr+qxyHZo7mpZ/Ed04kG0pih9fPryXoUD8EgJDrmNCADyLNNy/JPbSJvvfPCksmOOAQdbc8vW8Gom2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rtz6lq3PAzzfcJUeu0tHXnIu88dTU8D6t09T09RVvOU=;
 b=cq6MUiQXEhlwXRWtRo2yleOAOV22J1M7CGFFPawTw/iKZivvwzzb1mA1izruL/sqYVFl2Y7kQUu5uXp20cpBFSKISHxILw5JxZIjgc0qeuSUYxNVAJCweT8tV68REy9TfR/5jLqzWgP38m57slBWetXgwdxKxZZDutTEFW7eY1py/G5oeSUoQcr6VvVtnphiOia3UW9yW21xy4WT1SnE3RyTCGvl+Il43QEZNf5ix7CJa3JB3rm+90qHSYIOUuYptl7u6MiQ3P5t8tLeOotAMhfbgxgZiSbHyFTznEqr5WUI7hkQgoMYAa+A6DxZFbqVKRiwazXM1c1nP8NdvIvmCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ2PR11MB7598.namprd11.prod.outlook.com (2603:10b6:a03:4c6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 04:24:22 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.8207.017; Tue, 10 Dec 2024
 04:24:22 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>
CC: "Yamahata, Isaku" <isaku.yamahata@intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Edgecombe,
 Rick P" <rick.p.edgecombe@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v8 8.2/9] x86/virt/tdx: Reduce TDMR's reserved areas by
 using CMRs to find memory holes
Thread-Topic: [PATCH v8 8.2/9] x86/virt/tdx: Reduce TDMR's reserved areas by
 using CMRs to find memory holes
Thread-Index: AQHbSgauk8tDTyGydk+95/xr5jtt27LehpMAgAA7QoCAAAWsgIAAGzGA
Date: Tue, 10 Dec 2024 04:24:22 +0000
Message-ID: <5bbdf95daad0fd5178b50eb50ba95eb6de801c29.camel@intel.com>
References: <23bb421e9bf5443a823e163fb2d899760d9f14a3.1731498635.git.kai.huang@intel.com>
	 <20241209065016.242359-1-kai.huang@intel.com>
	 <78a359f8-5a0c-463c-b886-ff4165b395d2@intel.com>
	 <83df85a3b318e6578628692ce0d28b9cf736061e.camel@intel.com>
	 <6757aba1e072f_3e0fe294a5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <6757aba1e072f_3e0fe294a5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.2 (3.54.2-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ2PR11MB7598:EE_
x-ms-office365-filtering-correlation-id: 4ef8fa6d-4b70-44d2-1baf-08dd18d285d5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?bHNwTHY1NWlrQkFUeWVKVDVYa0d1Q3dqbFh2OElWOUo3ZUtqbjdLcUpJZlF3?=
 =?utf-8?B?YWpueEFtZTFJdkdlaURMUnJQYkV4N1JKUjdzc0FSVllsTVIyZENXUVd1bUdZ?=
 =?utf-8?B?RGc5cnpydDJNend4WUFMZmoyeGoxbXQ5SVdsOW1pampoRVRRMlhDZlUwc2Qr?=
 =?utf-8?B?MFhFTGZUMFUrU1JwMWszZURvcjRpNEljR1ZWa3ByaGY2dlFoWGpQYmZ1NkFq?=
 =?utf-8?B?aC9KRjhod0ZHdXpjMlJ2R2xYTndPazRacFo3WnMwYUUyeFVGRFEzRk9iYVov?=
 =?utf-8?B?TDFJWEJ3QzZIMTB3dUR2Lzh1UEI3UHJncVFEaXhZL0hIUGFHaC9CZjFOR1Zr?=
 =?utf-8?B?NU4wMklGcUZIUmM1QXdzVVBlR0JYZXdKSVRvMENNYjNJQmpyRFh1OVd3VnR2?=
 =?utf-8?B?YnRnaERiQTlPZnd5bGZxdEtnaHpiay81aytBcGNVTk9OT3VMSG5PTENEKys2?=
 =?utf-8?B?OFZLcHpJY2RUVzlKNXdNMWIxYXl2dEhIYUhoU2piTnlTTWZEQ0NZQWR2NXR2?=
 =?utf-8?B?Y3ltVHF5bUVCVzcwWkIyY241RnB4QW1rM2dSZjh1RWVxdVpqRkJKcmU0dkhy?=
 =?utf-8?B?ZXk0K1RKOVpsUVZUaXBLMDlxdjJvVEdYMHZkanAvaTV2aXA2NU1qWEFmelZu?=
 =?utf-8?B?QksvRVBIWXgyVTJhalpoUXhqNnM2cnZqZkxDMDhUMnhSWXZ2c2dzRGQyZjZL?=
 =?utf-8?B?SUNUdW1ORTlTOUZlVm9SK0llY2phd2pRR3ZpWEhJUE9kcXpCR1g3ZitnQ0RN?=
 =?utf-8?B?M2FmeXhCTk5LU3ZjWkFBdmJpR2ZXM2JMNnpJdVM2MkZlMHk0dDkwL0JpRnp2?=
 =?utf-8?B?NWpOME1zUlQ3ZVFUVGpFWmEzbGhqalBXYllCQm1sNFVISitYdk9XblR1bTVx?=
 =?utf-8?B?QlVTNjFKTXpmYTNZVFFjaWNXTFplak1oWUpLWTY5Z3gxNHUzakpTeXFraVpo?=
 =?utf-8?B?NXExKzFuTWIvTG1lYzZVNW9JZW15c1BNalRyVDQvQVlibE42YXVDcnp0cTJv?=
 =?utf-8?B?NDNaUFJyWUpncExhZXBJQkRlZUdmUWQ2eXNvS0N0eFNxUWVHTmh4aFhyNXow?=
 =?utf-8?B?Y2FEN1B0ZVFDbnRWUEIrZUhudGx6MXNFUFNqRzFFNGhlWmF4cHRNMi80cnNE?=
 =?utf-8?B?KzFxU3BQUVlpZUVkRzNocTFLem1kNHlDTHFUNmlpckJLVnVQdzlrRXplSFU2?=
 =?utf-8?B?a3ppUXZmL2haalRLR2ljc2dMcGpoMlgrSHVyaFRweXBXSjFKZ1B0cDJCK0I4?=
 =?utf-8?B?VWN1VG50YXJoczg3N1lNSEdpWHJrNnNZVlZxam5LbW1kK29tdFFIdmhNMGww?=
 =?utf-8?B?blc4ek44clYydFV3cGp6by9FMU9UR3Z4M2J4UU84bHZvVms4ZHBmMWR5SkRy?=
 =?utf-8?B?Y3R2dUJWR1VkQWhrVzFndEsvUnlZUzdiSVAzVjBMK29zelM2V0Q2K1RSZHFn?=
 =?utf-8?B?eGR0WmJ1WkNhdHhlM0lmaUdaZ2Y3eEdpZUpWZkE3UDJVNkhpN044QzNTUlN3?=
 =?utf-8?B?UWZyeEpVU0t6MEJEeGtTNHJKeEQ4VEtBcm9tZXlFTXhUMURXMFU0bEpsem41?=
 =?utf-8?B?bGlwdmpjQVFVS21ab3FrNlVXdzJZR3RsR0RxcjZKMVU2WjBWaDA1UjEwakFv?=
 =?utf-8?B?Zit5UGNYRXd5NlVncFFKYlMwQW00RVFVS3hYZWdDOFZsaVZVWVUvaUtkRjdt?=
 =?utf-8?B?c1dGTkpnanRRU05QSlJWeFdHZ2ZDV0YxbzRsSFVnSGJqd01OT2hHalZxMFhG?=
 =?utf-8?B?OTI1NURzSFJWNVd2WVc4YnBUYWFtbE1qK3VCMjJXbEVaK1cvZU1rV1VkMmE2?=
 =?utf-8?B?REl4Y3JUU1ZURW9BS1hiWlF1dXEyZUZDelJBc2pzWElQM2pwK2Y3Q0xSQjNB?=
 =?utf-8?B?VjJJbkN1YVNrZmE1VGNPMWI5Z2hZd1lpbyswSkJXRmFKd3duRnc2TmxiTVYy?=
 =?utf-8?Q?It65dly5O+8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDhodFozd2xTelZpWnQwcGRac1pPaXF1c0VKNjF5eEV3aFhpNW5OOENQVm9L?=
 =?utf-8?B?TncwNzUzSURQSjFmRmExNmNRVHFYeGRpRDVuOXV3bWNlb004SW00SUVURVl0?=
 =?utf-8?B?end5dUxFVEtvcHJwWmcvMFZXeitGZUhLenluNUZkbm43dWVKMzVOVjU1Z2lC?=
 =?utf-8?B?ZllPcVFCdmhDR0lyRnhiNHBsUGpJb3RKY1dwa2RGMlJjcnZQNzdSMkRFRWx6?=
 =?utf-8?B?VkNoMHQwL1h5VDFzVVprczRWWExzcG83aWM5SllSVmV6eU5iQ0ViVVlIQ28v?=
 =?utf-8?B?bmxGbWFUdytaWk96RjhZdjgvaTI3Mzh2eFdRUmhXalU4cXhJbDBrOXpFQnJl?=
 =?utf-8?B?YTFrMnZHWVBpU2J0Z29hZ3NnbHRKZTZHVGg3aWtTVXZQd1lsaXpXc1BOOG5B?=
 =?utf-8?B?Zno1YnVYSDNUR0FtWGlVcFM3d3UrMmxOZS84L1lrSERjWWt2MSsrc3d1RlBu?=
 =?utf-8?B?THFid3YxVjBuamhCaTRSQjIxbE14a3owZHNiR2hhdTg5anQ4VlhBeFNxWDYw?=
 =?utf-8?B?KzRFY0QyVEN3S0xNMTFIS2xVTjEydDZSYXBYNXFEdExBQWxIRVFOQmw5VDBl?=
 =?utf-8?B?ejEvZS9ISlhqVUhvbDEzL3Ewa0VqSUs4M2dmMExmWTdGb1A2bXZ3VzJ2c3V6?=
 =?utf-8?B?ZUhCWkdkMm0rd2xzT00zVHNYcTM4VFdwS2w5a2g1aHRMNG9mbzR0VTlTUlNk?=
 =?utf-8?B?SStJdWRQVUYyV2FoMU5CTWVLc2NsYjY2bXBaRXZ0aWxiY2R1U3JGdnFoSy9Y?=
 =?utf-8?B?cS9LY1NhWFFGL1lhRGt3WG81WHlNWEpmL1BxZWNFMDFSZnRnZDdPcEhuVnlV?=
 =?utf-8?B?akdXblVwZ0c3Y0J6NnlyQTBkVkNDWVFXc3FjY2dBdUhnTFZ6ZFhGYUxxUk9U?=
 =?utf-8?B?RER1dVowYjIvRkpNdXZZY2ZMRk1TNzZVZGNmU29nM1VMb1U0REtTZDBQZHln?=
 =?utf-8?B?OXlSREkrRDlQMENYWVZ0WW44N3JTWmRWM3Q3S2NCRmkrTlQ2cVJIb01yNFNF?=
 =?utf-8?B?d3R3MXdvSUFaYVgvODlxbDEzRU1ZOUkzeDFFRlptN2MxRUMwem9FSWljc2xa?=
 =?utf-8?B?bWlWRHNWSkZOTWF2ckZRWFI2WkJ2c2JMRXJqU2U1TUNpU01uNmZ3SndxaWZu?=
 =?utf-8?B?ejlzQUNYZHQ0SlRvaThlNjBkZnE0dmd6TVBaR29ZT3ErNllKaCtwVDV2bkcv?=
 =?utf-8?B?RmdkemJkOEpUSnNtZEhvUHVqRUVBS1RadzB2ejhXMjlKbFZiN1R1ZS9oWDJH?=
 =?utf-8?B?cWNCTFpoU1R0dmJzRUdBenlRcVhkeEdkZWhPNzR5Zi9EYTFwak5IQnk0Undi?=
 =?utf-8?B?THpPWGZqK0JweHJKUll3Z2lpaXR4UGVXOU9CTHdwK3NNb1JlSlZhcHlhNUdU?=
 =?utf-8?B?UVBVR1pFWDBZa2pFZklnYVV4MVNWTmdnclRzL09zTGNlZmczaDFJZ2dqVGNG?=
 =?utf-8?B?aExTS3JTeGo5YjV1TmtTMlhWSnBCQytEd3NFK2twbUpWaFdXeFVkdjFBRmIw?=
 =?utf-8?B?RitTdUxEQzcvM3pPQ3lzUFlXaUFSSml0V0hVVGNENWkwS2NJZ3NxSWVqU0lY?=
 =?utf-8?B?VGZEZFg3M3hjdWJBZlRsYUdSenhWR1BSUlpkWUFaenpOc21mbUZuYUxLN1JW?=
 =?utf-8?B?K29QQkZ6MGJkY3BWb2w2MlNnZ1lPM3hHeEF4WUpYOW5iSzVwODU0emlUUGJQ?=
 =?utf-8?B?VGFQLzROcTZYMUlZcXZQcTJlbUxvUXEyV3RrTWM1aWo0c0lIazF2WU9GWVJk?=
 =?utf-8?B?YW1ldzdpRG1UZFhVdUtrbTgvL21RZ0xITXNzVVNYMTAwOWpSdCtyOVpQZkxn?=
 =?utf-8?B?QkpvN2dwWFFRRjFKSzlCcGtScXNtb2w4ZXBodVhNOU5ydjkzcWoyRlJodWJW?=
 =?utf-8?B?a0IwZ0ZUb3FUa0ZRaTgxcWZxRkZwZ2NWRzB6WlorV3Iwc1ZDTDRlbVUxTWNF?=
 =?utf-8?B?Q2JZeHRkc1l0UDRHOXNHckZydVhxbUhpUnhNS1dOVWxzazNNanZ3am9SNGE2?=
 =?utf-8?B?WjBQYXFmenZzaEJlQThuc08xcmpBc0RoWWZhMU1HUXNKRWlUZm9MdFhGSUYv?=
 =?utf-8?B?MnNtVlJvbTRpMXZIMG9BWWx0OXQzOGxaaW4xa0ZCaHV4OHJMbnFHRmsvdjFS?=
 =?utf-8?B?TjNESmY5NkRlWEFuRktOdTAvb25ZWlpLQ3o2ZTA3Rys0a1ZHZCs3M2FuQkNX?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11FD17C9DB83F84688FAE3896BBB4B7D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef8fa6d-4b70-44d2-1baf-08dd18d285d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 04:24:22.3485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6PnIo2gJCWRnXViriOZErMCM2K6hKqnAAWB1d2JzxtcDHKpyalEJCiga6Zbf2Rq0gOQmGOc+YLG253y+jPqwhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7598
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTEyLTA5IGF0IDE4OjQ2IC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IEh1YW5nLCBLYWkgd3JvdGU6DQo+IFsuLl0NCj4gPiA+IFNvIGluIHRoZSBlbmQsIEkgYnV5IHRo
YXQgdGhlIENNUidzIGhhdmUgc29tZXRoaW5nIHRvIG9mZmVyIGhlcmUuIEJ1dCBJDQo+ID4gPiB0
aGluayB0aGF0ICJ3aHkiIEkgbWVudGlvbmVkIGFib3ZlIGNhc3RzIGRvdWJ0IG9uIHdoZXRoZXIN
Cj4gPiA+IGZvcl9lYWNoX21lbV9wZm5fcmFuZ2UoKSBpcyB0aGUgcmlnaHQgcHJpbWl0aXZlIG9u
IHdoaWNoIHRvIGJ1aWxkIHRoZQ0KPiA+ID4gVERYIG1lbWJsb2NrcyBpbiB0aGUgZmlyc3QgcGxh
Y2UuDQo+ID4gDQo+ID4gV2UgY2FuIGNoYW5nZSB0byBqdXN0IHVzZSBDTVJzIGFzIFREWCBtZW1v
cnkgYmxvY2tzLCBpLmUuLCBhbHdheXMgY292ZXIgYWxsIENNUnMNCj4gPiBpbiBURE1ScywgYnV0
IHRoaXMgd2lsbCBoYXZlIG11Y2ggd2lkZXIgaW1wYWN0Lg0KPiA+IA0KPiA+IFRoZSBtYWluIGNv
bmNlcm4gaXMgdGhlIFBBTVQgYWxsb2NhdGlvbjogUEFNVCBpcyBhbGxvY2F0ZWQgZnJvbSBwYWdl
IGFsbG9jYXRvciwNCj4gPiBidXQgdGhlIENNUnMgLS0gdGhlIFJBTSBhcyBkZWZpbmVkIGJ5IHRo
ZSBwbGF0Zm9ybSBhbmQgdGhlIFREWCBtb2R1bGUgLSAtIGNhbg0KPiA+IGNvdmVyIG1vcmUsIGFu
ZCBzb21ldGltZXMgbXVjaCBtb3JlLCByZWdpb25zIHRoYW4gdGhlIHJlZ2lvbnMgZW5kIHVwIHRv
IHRoZSBwYWdlDQo+ID4gYWxsb2NhdG9yLg0KPiA+IA0KPiA+IEUuZy4sIHRvZGF5IHdlIGNhbiB1
c2UgJ21lbW1hcD0nIHRvIHJlc2VydmUgcGFydCBvZiBtZW1vcnkgZm9yIG90aGVyIHB1cnBvc2Uu
IA0KPiA+IEFuZCBpbiB0aGUgZnV0dXJlIENNUnMgbWF5IGNvdmVyIENYTCBtZW1vcnkgcmVnaW9u
cyB3aGljaCBjb3VsZCBiZSBtdWNoIGxhcmdlcg0KPiA+IElJVUMuDQo+IA0KPiBQbGVhc2UgZG8g
bm90IHBvaW50IHRvIG1lbW1hcD0gYXMgYSByZWFzb24gdG8gY29tcGxpY2F0ZSB0aGUgVERYDQo+
IGluaXRpYWxpemF0aW9uLiBtZW1tYXA9IGlzIGEgZGVidWcgLyBleHBlcnQgZmVhdHVyZSB3aGVy
ZSB0aGUgdXNlciBnZXRzDQo+IHRvIGtlZXAgYWxsIHRoZSBwaWVjZXMgaWYgdGhleSBnZXQgaXQg
d3JvbmcuDQo+IA0KPiBQbGVhc2UgZG8gbm90IHBvaW50IHRvIHRoZW9yZXRpY2FsIENYTCBmdXR1
cmVzIGFzIGEgcmVhc29uIG5vdCB0byBkbyB0aGUNCj4gcmlnaHQgdGhpbmcgaW4gVERYIGluaXRp
YWxpemF0aW9uLiBUaGUgQ1hMIFRFRSBTZWN1cml0eSBQcm90b2NvbCBtYWtlcw0KPiBDWEwgbWVt
b3J5IGluZGlzdGluZ3Vpc2hhYmxlIGZyb20gRERSLiBJdCBpcyBsYXllcmluZyB2aW9sYXRpb24g
Zm9yIFREWA0KPiBtb2R1bGUgaW5pdGlhbGl6YXRpb24gdG8gYWRkIGNvbXBsZXhpdHkgYW5kIHBv
bGljeSBhc3N1bXB0aW9ucyBhcyBpZiBpdA0KPiBrbm93cyBiZXR0ZXIgdGhhbiB0aGUgcHVibGlz
aGVkIENNUnMgd2hhdCBtZW1vcnkgcmVzb3VyY2VzIGFyZSBhdmFpbGFibGUNCj4gaW4gdGhlIHBs
YXRmb3JtLg0KDQpPSy4gIFRoYW5rcyBmb3IgYWxsIHRoZSBmZWVkYmFjay4NCg0KPiANCj4gUGxl
YXNlIGRyb3AgbXkgcmV2aWV3ZWQtYnkgb24gdGhpcyBwYXRjaCB1bnRpbCB3ZSBoYXZlIGEgc29s
dXRpb24gYW5kIGENCj4gc2ltcGxlIHN0b3J5IGZvciB0aGUgcmVjZW50bHkgZGlzY292ZXJlZCBw
cm9ibGVtcyB0aGF0IENNUiBlbnVtZXJhdGlvbg0KPiBzb2x2ZXMuIFRoaXMgaW5jbHVkZXMgcmVz
ZXJ2ZS1hcmVhIHBvcHVsYXRpb24gYW5kIGRpc2FtYmlndWF0aW5nDQo+IHJlc2VydmUtYXJlYSBl
bnVtZXJhdGlvbiBmcm9tIGxhdGUtdG8tb25saW5lIG1lbW9yeSByZXNvdXJjZXMuDQoNCk9LLiAg
SSB3b3VsZCBsaWtlIHRvIGdldCB0aGUgc29sdXRpb24gYWdyZWVkLiAgSUlVQyB5b3UgcHJlZmVy
IHRvIGp1c3QgdXNpbmcNCkNNUnMgdG8gYnVpbGQgVERYLXVzYWJsZSBtZW1vcnkgcmVnaW9ucyB3
aGVuIGNvbnN0cnVjdGluZyBURE1Scy4gIFBsZWFzZSBsZXQgbWUNCmtub3cgaWYgSSBoYXZlIG1p
c3VuZGVyc3RhbmRpbmcuDQoNCkhpIERhdmUsDQoNClBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3Ug
YXJlIE9LIHdpdGggdGhpcyBzb2x1dGlvbj8NCg0K


Return-Path: <linux-kernel+bounces-398645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9FD9BF415
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083061F22E3C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E556206E69;
	Wed,  6 Nov 2024 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SANfCmaC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62A4206946
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730913172; cv=fail; b=fzhExpObKWixtsaem+84H1GbOaDG8Q3lGWU8zKUpUOZJX7K0MEj7vD+O0p3S0DzOz+5fW9EfCY4x629wF3xwiYiR+2ahuXJIxqbQGuBkxJCt+kM9M4K3G4oG4UsKej1G7acSjA2JFVTqgGHEWuWm9bCaBGBvgs/mjB+Z6t5cQk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730913172; c=relaxed/simple;
	bh=WqhR4rnILCo/DezxGpEer8FvUhGwyQ5ByWms371w9BQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kS54S1rrsq5h4D0hZeu2OanQoJDwHTT+21L6rJMWrvm1X5ojjXy6bBEc2lEO5aLENqQLT8gDLi+RO0Jw5LQxoop862b3DAi6YMK+hxD0fSwlH2/1uXCl/X1PqCrWrAPpGhFrRiNnT+/yYHyk7M1eoFF/AF697DGCEF/TwVQBX20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SANfCmaC; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730913169; x=1762449169;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WqhR4rnILCo/DezxGpEer8FvUhGwyQ5ByWms371w9BQ=;
  b=SANfCmaCaHw4AC5wPNKp89Qcs289Dw6luhugQx7m8XQEKn9SfNDNEIYx
   KkP5QATAfyfDsZK7CDp4rTws12FetPuYaNDr7QgC4I3g44jueL+xn9Oui
   OrfluJA7/jECgCtmahJ81sR/Dj6mIRn4g+CtzVSdcvhD2zUPiSLBg5pb1
   oRC1coJRB48KJbECbbVZLuEVo+Sljeqz4FdC1MGAvgSHPZ3xhU7+FoAGg
   mhYOSunKlUSuFTQOg3Pwo/6et4a0znaPKiAHjJ8Q47TnyCxHFoqjQuAMo
   PDLqHt7mXBAyoXmKGJ8L6io2l8B6D/mcwZ8Nh30FJaUSZKco5nVyRAKYu
   g==;
X-CSE-ConnectionGUID: lux2Lm9+RoWUZmIwVUXUoA==
X-CSE-MsgGUID: BVgA4ZlxSjygY8rwZ+Ndjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30882644"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30882644"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 09:12:42 -0800
X-CSE-ConnectionGUID: aetpn17cTXGZoSqzAPu0fw==
X-CSE-MsgGUID: F6dZ2DH9RNGmFwGW6eq6ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="84820725"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2024 09:12:43 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 6 Nov 2024 09:12:43 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 6 Nov 2024 09:12:43 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 09:12:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQiqeQIsjp0uEBjbFDORrSPwJD9Gpuhro+WFYtz/picMMN6vJYdIin3N2RiXOEvzk3JwCT4qrPqYkGcwB/mC1NNQEPQCUr6myCkZCLNYxkRQivofkEWPVtty+Ojf7CQgZZ6rxKAbPZPTD2pdgVkZ90iWA2n1zAdITNXF3d6P99dF8EJxs8ZYvYhcK1LqCGK6GryvdMYQ6+dKwjtjKGoKvAtKdU/k1tm+y4Nhrz9CVwD2TbCK7CTYpvw9+BRLP3VNpN7rE+aXENVBeQc+EKM5JaZSgYcMSO48a2VS64k/un4lgDVsS/vdTC1jwkD7tspTP6cAYHHK1Txr2FFckn2DBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqhR4rnILCo/DezxGpEer8FvUhGwyQ5ByWms371w9BQ=;
 b=eQOEWdI9QhywTFf4wgYoVgLY0dhnrIiG6HZ8E4ZkhbAKLY2lqjSRo8QSh7Th1pyjT1cUkgP+RUntyjzZF2z1W++UH8xQaciGR4WYxRxwsn3UepMnrxGlwEzd0gKXrj+sOs0U0QLmgQbpXllOwyyhcVRvV/NixKGlnmoDAFWR+2SuNVCta8lbQREExyMDgPKneFcbeGyJ5YzkhKL7eonoxHyBfb/4NFWTkuirafsPF7xVzvrtu+ENiN+IKd3pzyr0rAyt5PI48hyY4KTHCPI4d9tCxMZUewlPgy9RvIEceGIdT9rfmTqspB6CYuzB1Qq0I3VJBy9/ARNgdyociOL49A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB8226.namprd11.prod.outlook.com (2603:10b6:8:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.33; Wed, 6 Nov
 2024 17:12:39 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%3]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 17:12:39 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Peter Newman <peternewman@google.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Babu Moger
	<babu.moger@amd.com>, James Morse <james.morse@arm.com>, Martin Kletzander
	<nert.pinx@gmail.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Eranian,
 Stephane" <eranian@google.com>
Subject: RE: [PATCH 2/2] x86/resctrl: Don't workqueue local event counter
 reads
Thread-Topic: [PATCH 2/2] x86/resctrl: Don't workqueue local event counter
 reads
Thread-Index: AQHbK6DbACO0R1VGa0C5nUIcf/5WR7KnvKiAgADW1ICAAMfagIAAA9UQgAAK+oCAAJ8UgIAAfHxw
Date: Wed, 6 Nov 2024 17:12:38 +0000
Message-ID: <SJ1PR11MB608302AB52A300B9C21E4AA9FC532@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241031142553.3963058-1-peternewman@google.com>
 <20241031142553.3963058-2-peternewman@google.com>
 <b3a52af9-e298-7baa-19b3-8931d03731d1@intel.com>
 <CALPaoCgc13hS64mSWvn6zYQWwVKzcyF8xueWsaP62ZZJiv+nog@mail.gmail.com>
 <4e2f31bf-1035-40a6-b16d-081d6e45ead8@intel.com>
 <SJ1PR11MB6083D1B48E48BBE797ACF21FFC522@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <5ec7a1c1-43b1-4c18-9ba5-5cf4c42ba3f1@intel.com>
 <CALPaoCjyAHAkKJAx3FL3Lze2KkWxDWFDaMyNFPRwuh0Y4Vzz2w@mail.gmail.com>
In-Reply-To: <CALPaoCjyAHAkKJAx3FL3Lze2KkWxDWFDaMyNFPRwuh0Y4Vzz2w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB8226:EE_
x-ms-office365-filtering-correlation-id: 03aad5ee-ded6-42fe-4b21-08dcfe86378c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QXRCaVVMc0U3ZEJxZ0dtV1V3N2RMOFFoenMwV3ZWNXo2MFR3OTkxV3IrY3Rw?=
 =?utf-8?B?YU04bnYyWUlvd3ZjcTVJTnVLRVZFYWVuTHoyb2c2THFNWE9GcngwRCt3b05F?=
 =?utf-8?B?SURTdDMxMjBEa25RZ1pxSVgxNjN5aWZPUW1ZNE5oVVdHZmphKzFDeXNHUzZF?=
 =?utf-8?B?NjNSMEpQVkNoc0IyWmxDOFAzR3ZxeUxVbkRucEhqTDRlWGtZaWRKTjNkNFJF?=
 =?utf-8?B?NXBRMGtGUXJkclN1dTRjY09EYzdHQ2ZFK2xwcHo1cnVSbElicmtzSWpldWNn?=
 =?utf-8?B?NklmZU1HckJ5aDFUS3lneFBaZ1U2VitZRkZFZzdLb05ydU5LZDA5MFV5ZWFm?=
 =?utf-8?B?M1I4c3B0OUNYR1U3UnR3VHJKMDljOHdvSURWOFNGUEY0NGcrYU5idHZuaHVi?=
 =?utf-8?B?YXVlRnRWbEkrSWlFZ1B2QUV0UnZ6S2hScWtSOWVtYkNOMVRMK0hWd01NMjhp?=
 =?utf-8?B?anF3SDhNa2tWV001KzZhWkNCLzk4OVlKeUtsemFxa1lJTjNSeDcyNVlyZWRQ?=
 =?utf-8?B?bnhBc0lUYlZSWjh4VURmd2xFOUs3ZmQwOC9tZGY4NjZEOGJnZkxxaFg2RXpa?=
 =?utf-8?B?SmVoMDBqK0dJbSs0MWV4QmlrUTIzQ1pWQjNsUlU2Z2dyZE1FMTlEeTRaVk5U?=
 =?utf-8?B?L0tITjgrcUkrVmlldE5WS3YxaHdhbUZSTzZsR1JJZXdpT3ZlSm16R1BlQkRL?=
 =?utf-8?B?bmlaZXFhUGl4eGpnV2d2NTIxYW9lTW4vOHRteXFFWmlQaUc0eVJBQXdWdEY0?=
 =?utf-8?B?OVpINGxZcG9kWlpXRDlVcHNwa0Irem1LT01lc3NiS3JuTFNEdFBFbHNlVVZi?=
 =?utf-8?B?YmhNNGVXdUI0N3k5VndVYUQ2VzdacXRyQnNhcnBob3JmNitVQm9KOVdQUmwv?=
 =?utf-8?B?ODg2YlEyUG1VcHBRWU5sOHc2alZOOUJWU2xBQ0NuS2JtR3lWa1NqTjBPcUg3?=
 =?utf-8?B?ZmVKODVVZ25RT0FXZ0cxak16cnhJbmhzMWsrVUZYZEd5OUJqRUswYXhJWDZw?=
 =?utf-8?B?d01DRURSOWxrajZDY2Vhc2JiVlE4aENPelpmcGIwYWpxUDVlUkRHRHFxakp2?=
 =?utf-8?B?ang1emF0VEI0RzFuT05TaVRNcmV4ZzRTeE0rV3B3RzNEWmo1cW9Va2EvbkxM?=
 =?utf-8?B?VDhSc2dMWFV1aVgrUXdhSEhkRUVHb2ZjcUdtME9KYUZ6R2FEbnVHRmlRQlZI?=
 =?utf-8?B?S1lEVUFQbGNuSnMyT2ZRSmMxQXhDRVFDRkdFWm5uU0w3aXlBWXJ6OU52ejFG?=
 =?utf-8?B?UmpiMzVlMDNIdm8zb0VFMEpMazRjaW9hOFpDa1BJd3UvSG4ya2hvUkFsNVJm?=
 =?utf-8?B?UG5aSVN6YjF1YXlwNVRhWk5RTm9ZME5ET0FrRXdMRjlieTVHVldjeSsxTHFo?=
 =?utf-8?B?cWwyNXpwbldzV0g3YS9yc1NCbnNwTTFrYk9PRGJzN0R4elRSci8zNW5EajNE?=
 =?utf-8?B?TER5RUp2NHVJdlZ1cmlUQzVXSGhJVzZwS0xSL2VObFloKzNPZjloV1h6RkZ0?=
 =?utf-8?B?WlljdC9iN2MzNnQ2OEtoVXpacEcvVXo1TStRYlBiWXRCcWJSbGZDS1p2ME1l?=
 =?utf-8?B?Z0dvaE1mZGNGU3d3bllQeDhhSDJLL051Wlp1Mis2UGx3Q3RmbFQweW5VMEM3?=
 =?utf-8?B?YjM3M3hPTVI1WlJvNkNaRVM1SUZmMmxmTU9YQmNxWXFCU0tLcWR1SjQ0Zk0y?=
 =?utf-8?B?WjIwbkJrY0c4VnIzSU5sSG9zekpmUzhTc3VsTGFaTkN5dXlyeG5iRmsyak5h?=
 =?utf-8?B?b2hPM2d2NndncU82cGRTRnF2b1lHUHdGYkQzSTJxSm1kT1ZaaXA2K1VtYncv?=
 =?utf-8?Q?KfFHTKHSuRWtMkj+2m4vzwfyVzw6X6MPv60vs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0JkaHZ4eHQ1SkxINys0clFyZGRyRmVRbG1TUnpBNS9paUZ3c1ZLdE1odUtU?=
 =?utf-8?B?cXhaTjNDRyt5aVdSYzdxc3IvOVFRdGt6bktucnI0S3FWVnB1ZFdROURWMGFM?=
 =?utf-8?B?TjA3MmJhcWo2VURWNnhuakpjVmhJbnphK1FLQStkQmEydUZBblA0aGtGUGpW?=
 =?utf-8?B?QzZtam54OEEycml3QW1JemhtOXAwdmlHeXhoSmorNDJ1UWFDb21WVG1TdmtE?=
 =?utf-8?B?THZ3SEkzNEF3TjBhN3FReXNnRlY3VVM1cHRFUFI1bzVyWW1aVEpJdE1PN3Y1?=
 =?utf-8?B?UFM4WWx4TmpzcFc4Yk5XMHJTbzNFRUpjaklJV0R6Sm5ZZzVVM2c2c3pQV1Vm?=
 =?utf-8?B?UWFZeEE2WjV4U0thbnRoZCtLb29Jb1BPSUdZS1krbnRNOUIwV0JHU2I1T1NB?=
 =?utf-8?B?YThrcUV6SHErWWZEVyt5WVFIZU15TDRHU1RvemxjWDNIUnQ1dlBnb2E1S01l?=
 =?utf-8?B?N1hVN0tIeTgvS1E0REd2b2JDWm4xdkp2Z2pIcDJmVXZlZkY4eGprMUxnRHdn?=
 =?utf-8?B?TEZwMGlnckpCbEREa1BHWWlFQVViTzI4YkVUMlJKSXpYaEZRZmJsanNhNDdK?=
 =?utf-8?B?L1hGaC9LUGZIaWNhRGJ3NEczQzNJVkQ1TWlrcERoOWZNRFlZQitmS1VLemZl?=
 =?utf-8?B?NWc2R2hWWTdUZnJhWW5ISEpzT2hnenpkLzFIT1NSZXhDcHlad0oybkpLdjBO?=
 =?utf-8?B?TFp6aXpOTmpsdUtlQmE4T09FZFYvdy9LUVg3dDZ6THJFbnQ2bCt3SloxMWNI?=
 =?utf-8?B?UWJ5Wmdkc2hneWtkNWxQUVA0eXVmQ2VsR29ud3ljaG5uL3ZmcFdJaXJNbis1?=
 =?utf-8?B?ZmtKR1NhNWRJTHJweld6R2dsbzB0MnZ2WUVSR0RrY2xsL3YvMXB3aW5jRldy?=
 =?utf-8?B?SHFSdWpCYmdBR0dHdUZhQlB4YmNJUE40VklsUm5hY3JqbWltOFRHNWZXTUM4?=
 =?utf-8?B?aC9RSGdqYWh2dW1vcHlPNFpzSUlaWnYyeXNQTWtwSkpvcWE0OEVqQjZ6OFYy?=
 =?utf-8?B?YlhEZ0Yxd1EwSi9lTnlDdVloZlNuNkxJejRLUm9SeThRbVNMNzVlUlZuck4x?=
 =?utf-8?B?RkVMbTZKS1puRmg1Qjh0blZSZlJXbWdjaGtSSU5yV3I5K1AxSDU5RjJ2dEo3?=
 =?utf-8?B?TkhON2preWJzQmRVWGhIYVd6REFYUkZDMGxKak14TUlHRU5IaTF3ckM3VlVv?=
 =?utf-8?B?UXdGVEpiZVdIMlhlU1cwTVEwV3Y1QTRlYVFsRHhDcXl1Sk1NMCsxSjFxQmtG?=
 =?utf-8?B?ZHE1ZXN3akZ2TmhuK3RnQXRiWWovZ2ZieVcxUjNCN3lUZjNtYXVWRlBOV3dM?=
 =?utf-8?B?MndUbCtHNEM5alJpeDhqY3dMOXVhY2ZDd1UrL244eTdiRHFEeVlsbkJXSlZ0?=
 =?utf-8?B?NWNSd1RRQjV6NVQzNkFXUGExWmNvNi9uTzFXbGJaSWZpNitSV2ZCMUJ0QllL?=
 =?utf-8?B?cUFNNjVHREFpVE43U082RmNIU3Z0R0x2emY3cktzbldxVEJyREhTcmFudkJp?=
 =?utf-8?B?VGRGRWdUR3pIY0NhdW44V01ZRFphWDdtZVBobVArTEZsbjV0Q3BzWURzWExl?=
 =?utf-8?B?ekRTamNVcHd6ZHM0NFRxbVBNc1VoVC9LRUtrMDlpSE80azlhZi9ud2dqUk5G?=
 =?utf-8?B?S3QrbGl5NkRIRXdONUhHazZIbG5GZURVNitGejZPR3J3RFlFRjUxUi9xbVVn?=
 =?utf-8?B?NFZZWjVZQk9UYUJ1VzVGTUJqTEgzbGlSZ2I0dWFsK25hUTlOaVVrYkd5SFEx?=
 =?utf-8?B?dkx0TVdGeHQzZjRUR1dxSEs1SHF5VXlacytvTERFOFlrY0hNQWg2eW05M3d5?=
 =?utf-8?B?QmNSOG9MSm52ZUlEVVZ3a2M3dE5rSEVJVHU5MFQzSnM2Lzl5SVMraWFpWHFC?=
 =?utf-8?B?ZitUbXJjWXJ0ZkUzWkRQYTFBOWZ2WklLU3AvRk5UdzdWa3JsYWZ0VThJY3Zu?=
 =?utf-8?B?TzhwTjVMdUpKS2R0cFpHdk54L0FqajBlU2l5bXF0cDk1cUxLS0pkSkRIc1pO?=
 =?utf-8?B?bWhVQXRDNE9wK08rSDQ2SnJyb25GenFoUGozUmdaUjhVVTFRaFltZURVVkJP?=
 =?utf-8?B?My9qZU0xYTExeXg4UmxNUEVQRHl0SVhTQzA5N0o3ZmVwV0pjVDlLTzR6dDJI?=
 =?utf-8?Q?S7wY4Ufa2IpdF5IWhEBjUqXu9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 03aad5ee-ded6-42fe-4b21-08dcfe86378c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 17:12:39.0316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z8SrgZ07nm/dJe7QbQdhzEVGQoMX+U/GfHN9pePXKRGlzlWv5/gGQ/4wf0MyMdWvHjeTSMIfckS6qeJ3cQ2S/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8226
X-OriginatorOrg: intel.com

PiBBcyBhIHJlZnJlc2hlciwgdGhlIG9yaWdpbmFsIGlzc3VlIHRoYXQgbGVkIHRvIHRoaXMgc2l0
dWF0aW9uIHdhcyBob3cNCj4gYW4gTVBBTSBDU1UgKGNhY2hlIG9jY3VwYW5jeSkgbW9uaXRvciBj
YW4gYmUgaW5zdGFsbGVkIGluIHJlc3BvbnNlIHRvDQo+IGEgcmVhZCByZXF1ZXN0LiBUaGUgbnVt
YmVyIG9mIG1vbml0b3JzIGlzIHVzdWFsbHkgc21hbGwgKG9yIGp1c3QgMSksDQo+IHNvIHRoZXkg
bmVlZCB0byBiZSBmcmVxdWVudGx5IGluc3RhbGxlZCwgdGhlcmUgY2FuIGJlIGFjY2VzcyBpc3N1
ZXMNCj4gZGVwZW5kaW5nIG9uIHdoYXQgQ1BVIHdhbnRzIHRvIHJlYWQgd2hpY2ggZG9tYWluLCBh
bmQgaW5zdGFsbGluZyBhDQo+IG1vbml0b3IgaXMgYSBzbG93IG9wZXJhdGlvbiB0aGF0IHJlcXVp
cmVzIHdhaXRpbmcuDQoNCk1heWJlIHRoZSBBUk0gaW1wbGVtZW50YXRpb24gc2hvdWxkIGFkb3B0
IGEgc2ltaWxhciBhcHByb2FjaCB0bw0KQmFidSdzIEFCTUMgcGF0Y2hlcyBhbmQgcHJvdmlkZSBh
biBleHBsaWNpdCBtZWNoYW5pc20gdG8gYmluZCBhDQpoL3cgY291bnRlciB0byBhbiBpbnN0YW5j
ZSBvZiBhIG1vbml0b3IgZXZlbnQuIEJpbmRpbmcgb24gZGVtYW5kDQp3aGVuIGEgdXNlciByZWFk
cyBhbiBldmVudCBmaWxlIHNlZW1zIGF3a3dhcmQgZm9yIHVzZXJzLiBFc3BlY2lhbGx5DQpvZiB0
aGUgbnVtYmVyIG9mIGNvdW50ZXJzIGlzID4xLCBidXQgdW5rbm93bi4NCg0KLVRvbnkNCg==


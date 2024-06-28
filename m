Return-Path: <linux-kernel+bounces-234534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CF491C7A8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75141C261F5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284EB78C64;
	Fri, 28 Jun 2024 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kllTCsxK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561AD7710F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 20:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608314; cv=fail; b=VvF8Vci5f4l0YZbRArW0Uj3xcm5Bw0PaDmXXs+8zrT8Toy0YZgLPzYlyxCb8szt+VvXHkT9Tjnz6yqlu+qWxGi1nxTPhvylwscia2c8yU5iAEEIsZtQjDrhrDgvSnHRSevmxT5f7rK8+ckqlZGQHvF6Kll+XvxAzABuwk/Q4dJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608314; c=relaxed/simple;
	bh=9RKWCrbGm4KRhPIESHw5gStPi1AvYIzp5gwDlGZvjio=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I3XbfcMOeZrCiegpAu3V2f20HlneoAGNU48HwjTc+6YnlsStsQA0vef80n5Hbk0KYtN2QR3xhGM+vMH5Ov5vwa713Hn6tnE4QoN9P2BFjNIPvt0spbTHZ0BXasTglrlMRExV5pQl17iTrpfk50evtgf9CwCR7AvdcPiJnhkaeIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kllTCsxK; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719608311; x=1751144311;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9RKWCrbGm4KRhPIESHw5gStPi1AvYIzp5gwDlGZvjio=;
  b=kllTCsxKqRG4OTOl/QNImGjPuJ604a2EC2gnICKro8hFZMEgg+MsUk+S
   v5NCBwPi2/osr6vK8OKGB6hn5rh+M/Qb5OZLRRuIHX36C+Q7Zt4fxxRdv
   lgLrXqE1lx9UOCxW6X5yuyBByOmt5QriacJX7AEJEazgK/mON0F5/Q646
   m2wARd6jOx8RG1w/0J/NWEsfnra6zJDlMvn7NKP65Y/gZm2wcNSYRtAoC
   s4gIc7FLjvOBcj7UoBhkVHMv5fxToe5F5ha9Fv/Uzd+jnLf9MO73vMnJL
   OwCp94Koz7xm+RFxbS/n7fHBtbTbXEywLLbPToW0N2u8QWwA+tE1NZewx
   g==;
X-CSE-ConnectionGUID: aQJlxGJjTq2SWcqLu9sLrw==
X-CSE-MsgGUID: XawQR74ORT2+uDLgf30+TQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="17027826"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="17027826"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 13:58:30 -0700
X-CSE-ConnectionGUID: TyCZvRIBSMu/IyBSnmpFiA==
X-CSE-MsgGUID: 1ilEkRbrTzKjxuCaDt5CnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="49322796"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 13:58:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 13:58:30 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 13:58:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 13:58:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 13:58:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzoCqpEYF9bz2bLW5pk2RhIIDaq8fy7H+vOYgjFbMFXqbF7+5e/zmgpKos/4S1FOmsJKRXELDKryBGWw3ELdptDlRTYymrdhuRFEbAVwv8ozVbQVIreBudNDTXclLxYWiHQSjtF2OgR1TgNuunsVQahOl4dWUddg0XmjoMOPLYO2A+BX/KyQrZHGJGZ9GybPzO2xjYw4RM+u3meHXkjvjRIzDbFTkkqElBAUiQevu6Hvmru7qZJgLSb6z7oqgumhm6XQfjNqlLB0diCNXUHeWHcU5VA2RPhbeLOYFIMlFMB/rBg3GAk/65dxVQ+JVCUwcNH+dg3T2UbnBtotaAvb5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RKWCrbGm4KRhPIESHw5gStPi1AvYIzp5gwDlGZvjio=;
 b=J5xntLDA6zo65+/PrcRribZuMC+/0KOYOrcUjqycoRcQbN+H/qgHehwqJiWGBNhh1IIjzm5QEAjNYsgY2mPk6lfZPeFJDMQL4o4lxhjyeFKsr6mVwK02iCKOU6KNiY/aMoSNu123ucqQY/kYmD2NXuq+u3Mz/Vibng13vDoHxLF/2kMpP5WhMjaHm1hClNes+zO+MVF30XfjAdZdb/O7j7MmeiMVi3WCSzWEFGZm3ndyzWOO8aOX4e8goZ7o/SRq3+7/i6zJv8gW91PdEw7Zn2XVdzgOD5daicCl8mXAL21x7wUtryQ3j68MdHC4uxHz06jgrlQvavsrC7ldaw6jBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ2PR11MB7618.namprd11.prod.outlook.com (2603:10b6:a03:4cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 20:58:25 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 20:58:25 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "Ashish.Kalra@amd.com"
	<Ashish.Kalra@amd.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "luto@kernel.org" <luto@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de"
	<bp@alien8.de>
CC: "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>,
	"mhklinux@outlook.com" <mhklinux@outlook.com>, "Rodel, Jorg"
	<jroedel@suse.de>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"peterx@redhat.com" <peterx@redhat.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH] x86/mm: fix lookup_address() to handle physical memory
 holes in direct mapping
Thread-Topic: [PATCH] x86/mm: fix lookup_address() to handle physical memory
 holes in direct mapping
Thread-Index: AQHayZ0272Rw0HaOX0+/vmpf14Hnz7HdqJoA
Date: Fri, 28 Jun 2024 20:58:24 +0000
Message-ID: <fcb19e22678d126f9c4223d1e80f8c7d27e22692.camel@intel.com>
References: <20240628205229.193800-1-Ashish.Kalra@amd.com>
In-Reply-To: <20240628205229.193800-1-Ashish.Kalra@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ2PR11MB7618:EE_
x-ms-office365-filtering-correlation-id: 715d07bf-c4bf-45be-5e1c-08dc97b50d69
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eUE0ZUt5R1p1N2o3K2RJTXJzVndUdnF6MGNVaUg0eUl4TitWdXNZMmpZRjRp?=
 =?utf-8?B?WjBKSGdBOHl1QjRVTTROWFR2cVBvUmZMdlNPYk1tcks2RkQ3bWFSaG14aS9S?=
 =?utf-8?B?bkJIM0tpTnY5d3Rtemc3Q0NjU2owencxblQ5T0VxS3RxUGN1bFp2OEJobXFF?=
 =?utf-8?B?ck5ZWGs2TWFYdzdDS1ZNYVh4QUVwcUxzcERycEc1dm9LSEQ1QmsvMGl3bEZZ?=
 =?utf-8?B?ZlFCOWQ0UFQyOTN0VnJwS3JSQmU5VEpjZnJ3MEtOOWdVZElwT2JudjNzNjRL?=
 =?utf-8?B?ZUV1QnZ0eUsrV3NYQlF2b0tnLzdZQUZaVUthSjBYTmNqaCt0clpOY3dhQks0?=
 =?utf-8?B?R0JGUC9wOCtIVGZybW9lVHRQOEp2OWRWeEYyOVJVbkNKZThWSm5admdteFpw?=
 =?utf-8?B?VVdSZTNnSTBqUVVRc0kvUGRZaTQwR0V1VDJxZzFxSThlU1U4OG1yRlQrYmhK?=
 =?utf-8?B?RmtDRzVscUNWSkFNK280Ly9KWU15bE5WbGNGRzBIVkhOTDIzZ3p4VVdZYlNm?=
 =?utf-8?B?VFNEeTZ1ZUx2MG80M1hydTlYd2xKcmFhYjM4YUh5bi9SV3QvS3Jhcko5UUJW?=
 =?utf-8?B?REIyZlEyZ1p4N011WVRVQmJibTdhdDhNNE1meE5hRGx2V1B5YnUrd2d2TzBL?=
 =?utf-8?B?dVF0bjV0eWVaRjVlZVg3ekNhWnQ2YmU3aHUzRWhULzc3U0pSbU9JTGZSL3pm?=
 =?utf-8?B?SVB0Sit1ZFpUVzdBZ05FNUYrZmNUSjVNYjJ1c1ljSkdYcEhrZzU3cGpzZzJ4?=
 =?utf-8?B?bm9WcXF4NWtyajc1cGdOK0I0b1gzQmRxUjk0YldrbVJocm5XN09GbFJRYTR4?=
 =?utf-8?B?dWs2d0lRUlpmTHgxZUZNZXVwSUxIYnBuekdHUGFVemZZbXZiSjcxYzEzMG94?=
 =?utf-8?B?TEdFOXZwNHcybi82NHMwUWtyOFFJRmpLK1lBdXBVSTlDV2g3bDV4N1VxcUxB?=
 =?utf-8?B?a1JBNkdRODFjZTludTFOeVR0UEVRM1dEREpvOXk4NDd4RWxRWUMzenp1U1Q2?=
 =?utf-8?B?eCtzV3dCNUVhMHEwZ3ZuVlFKWmdpS1dDRFpPbFM4UWZEUzBaUnkzc0xZYnQ0?=
 =?utf-8?B?WmxvaUE0enozSXl3dXB3OHBVcFhEQ3doZDhUMGRyenBhd1JqUVVHbXF6eXhX?=
 =?utf-8?B?ZExqdVUyZGM4TTNnVVNpZG9pbHNCcU9URksrZlMxamhLOENCbEFDZHFCRHlr?=
 =?utf-8?B?elJxSDQxV2dCaFEwNVdGWTFxU3Yxdm8zYnVNMTNTL0d0Z0d3eU5rcnhWUWg5?=
 =?utf-8?B?YWxQU1NDR3Myckw3dUxDNWFTaWZzUVF0T3h0R1VKMmZudlBXQWlRMHpSOTZl?=
 =?utf-8?B?ZHdPenZSM1dhSU1MTWVtenczaFlmbDZKUWVVS3dlVHRsYmFCUTRTbHprZ1ZC?=
 =?utf-8?B?TGp0dGR4Y3R6UDNuVkpEUUVvYTNRY0xrWkVOV3RjZG90ZVAzVjFFRTdKOVpE?=
 =?utf-8?B?QUhmVy9PQlQxUUJvdWhBS2lMaGJFVmVkMndNU3pQLzZxR1dDeDd2OG14dmpI?=
 =?utf-8?B?Qi9XdUQvd09CaWU3V2pkWmRqc0crL1V5bjQ5SUxVT2hvNGQzK0h1a2NVaTBY?=
 =?utf-8?B?UFhFWDZudXQ0NGJnOWppR2hlanpDUURtNnQ4cGw4dGorU3FkVVNSWUlSUkgv?=
 =?utf-8?B?M2R4b0hnWlhNNFVKRGh6R2hPOXEvTlYrMm04VHdxMEFkWDZUYUFtY0tBcFZv?=
 =?utf-8?B?NmdJZDdFaHUxSlA5eWhXY0xPL3UweGRXQjZ4SllLZXovM2pLbUJPNC9FMTVV?=
 =?utf-8?B?N2c2dXFBVmVhSHBTd3FBMWRQay8zUUJLMCtTOVhFSURZL2V2Yi9LWHFCVVFX?=
 =?utf-8?B?OVZFeHJWWXE2RUdiZitjSkQxK1g4S1ZsTHM0bEdNS25ueGlBTXRiazVXZUZE?=
 =?utf-8?B?VitzL1I0WktQM2JKWWVmaG1OS3lQN2dzTUszMlJiTXlsZ0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zjkxd2srUDlJU0haemg1MGozMHZuekNLcDdFcVNRYjdvTDFRWXlxWm1iWG5S?=
 =?utf-8?B?UU9ORjM5REJ6cVlzelJTa0FzZmgvWERBUWJuOUdocHM2T2piU050V25QeVdr?=
 =?utf-8?B?TVErQVJWMjFUQkx4bGJRaUtTN2JNVEQrWnl1eDVBMFhydjFpdDJYbldxNjUx?=
 =?utf-8?B?bG54WldNdG40RVNUQ1pRZHBrUjY1TU9CNmNtQ2lxSWlWdTkwZzI3VjZnb2Rx?=
 =?utf-8?B?Uy9Qc3U2QWRJaGRvMXpQd2k5Lyt6eEVYV2RZUzhNV2FMcFJjQldXaUdoNDRl?=
 =?utf-8?B?eGwwcWlQU0E0WlFsZURKb0xJUm0xRTA1MGw1eFA4SjFMQnpCdnA2UE1Zanlu?=
 =?utf-8?B?ZDE0K1VEN2t1L2xOYnFORlJSZDdhSEVLTFFQNlkxdGV4QVk3M1F1K09aekVn?=
 =?utf-8?B?dVJGUTJ0Zm1aRTFDWUY4T1M1Z3JmOG4xZnJ3cDBBaEpJT25nT3JkYTJHTjJI?=
 =?utf-8?B?UWc0RTl2dlhqelZWMjc4ZDg4OVlRNzRDR0QxUEJjN0cyc0hvNFdOZFVzUGVS?=
 =?utf-8?B?YU9pOHE0MDlVNnArdHdMMjdpUVZrUHJvZ1FGby9kajIzNjNMdGVaQW94eVNZ?=
 =?utf-8?B?emMyVG0zbC90d0MxU2VvcmY1d2R3OFhQNjBPSXVrSUJzaEhQQzJycTBFZFRJ?=
 =?utf-8?B?NUtlSUxka3libm9hN2kvdXlGVEdBOThhclQ0UjVhY3FGS1lZTDFENndaN3Fz?=
 =?utf-8?B?WXdoWW9aNkxhTVNxVVpTY1JVa2NVMnFoT1pWWjZkTmxkb2dhdTV3eUFnM2gz?=
 =?utf-8?B?amJacWtOZG56ZzFyQXhHWXZSMlpBcC9JOWpFKzkwQnlTSkQzVkZLYjVZcmk3?=
 =?utf-8?B?a1B0Yy9LdVVFOEkwZzdITlVtYytUckt2T2dUajRUdlB6bUFaQlpWd3J5eXdT?=
 =?utf-8?B?RXdkTVdVcE4zWHdRZ21ib3BoRHV4WDhXTEdFQUs0UTNWNTIvRHlMZktOelVp?=
 =?utf-8?B?SmpBVVA5dkhZRmpCcnpFWUxRNU1ZZWo5U3RQWEZ6c05vYWMxRkZPVEJuV094?=
 =?utf-8?B?TkUwbHNQNkQ2OW5UVjgzNWQ2K2p6OWdoQnNQdGI1YmZTNGorRXJnTFc0eHQ2?=
 =?utf-8?B?UE1zVnI0MEU1R25jbWR5NFRHQjRXVUpDcy9KNHBLWEFNekF0ZUtJUGo1Q25K?=
 =?utf-8?B?MXNCTFFBOFdhSDJWZFdLTmQ5WGtMb0pJRlFLUXJzM3NLZU82RHI0U2NGaVpB?=
 =?utf-8?B?RFNudXM2dlFMMm9zQ3pEV2pqRVBLeUFmK1I0K0NoTjd3ZmtKSUw4V1A4aGdT?=
 =?utf-8?B?OC9XV3VBS0dVNkVwNWFycG0reEFJYkQ0YlRleTd1MW94SGw4OUxxMHNrZ1Fj?=
 =?utf-8?B?SG05bkVvaUgzVDJoVmFhcE5RTkdMdElDZHhQNHhEY3RpZVdaRzljdHI3SjVK?=
 =?utf-8?B?ZzViVnB1UjZWeDJGV0Q0YXM4WXlVeDRyWHFRRWg2ODdpR2hOdGNsMlVKL0Ja?=
 =?utf-8?B?azlRc1ZoN0pnZHEyWDd3TjRESUpzczF0MHRsLzVnd1JKNjRKUnZxMCtINWVC?=
 =?utf-8?B?ellWTFlYRGk3c0NvQ2JXMGhOQjNDc0MzNUM1cXZqSnJFQXduclZEdUxMb3VN?=
 =?utf-8?B?SUtIZEhrcXBFSFAyTENhS2tBaHdUaXhHQUJLcHBCVXNaQ2VaTUZyR0dwOG9k?=
 =?utf-8?B?U0Y0WWM0L3JmSG5lbk4rSmt2SEZYVmgwR093aWFVcXM2UHZkeHNyZXlSM3E3?=
 =?utf-8?B?dUg1MjhmeFo1Z2xESGJGaUR6eDVrNE03bzVIMGdnZmlDWG9pWGdTNWc5T1FC?=
 =?utf-8?B?cEQ5djJLRDN5d2dQcVFqSzJTY0V2clI2UXZ3NjFJOXJGN2o4SHNsVmxGWXhI?=
 =?utf-8?B?NVNDVnRIMmgvMnk4ejdvQ0g1VUtyazdOWEhSZkVRRTV1ZEJuOVdReGNBNEMv?=
 =?utf-8?B?aXd6R1c2YU1GdEptYnU4S3V3ZjlXcGhzcHRwSVNrWk5ib0hxaHVsWUY0UTQ0?=
 =?utf-8?B?SDlnU0JlOE1XYm16WStaT1NtMFdyeW9KSzdGTkE2L1NiMFV2SDRucW55TE5S?=
 =?utf-8?B?TlRPcWZDSzFvcmg2SXdvZDJrTm51VlNPZ2p6bVVJcTd6V2ZiRjViY2hpN3Nn?=
 =?utf-8?B?QVVlU1FMVWN0N3IzeDFiMkJEN2RBS0NUVHJxekx4ZjgybllSQVRkeDBQVUJm?=
 =?utf-8?B?K0NnSXZGV01FbVdYMklldUxtdjg4Wi82ZThkaUg4SUovSE9ZWWxrVEMrUmM1?=
 =?utf-8?Q?knpxxPU5fLP65c1987EVuaE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F00CA9EE1F4A44FB90440EA916392C5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 715d07bf-c4bf-45be-5e1c-08dc97b50d69
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 20:58:24.9573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VFLwsHBddwHqEo0Xna/RWx5sh9Cqyb7zIcRHZu6qRD4nrxHoSAfPXAR43YiHCVOt1NDeudyase/DWXW0y7rdLwb63Qj4X7qASRsQielC3mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7618
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA2LTI4IGF0IDIwOjUyICswMDAwLCBBc2hpc2ggS2FscmEgd3JvdGU6Cj4g
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL3BhdC9zZXRfbWVtb3J5LmMgYi9hcmNoL3g4Ni9tbS9w
YXQvc2V0X21lbW9yeS5jCj4gaW5kZXggNDQzYTk3ZTUxNWMwLi5iZThiNWJmM2JjM2YgMTAwNjQ0
Cj4gLS0tIGEvYXJjaC94ODYvbW0vcGF0L3NldF9tZW1vcnkuYwo+ICsrKyBiL2FyY2gveDg2L21t
L3BhdC9zZXRfbWVtb3J5LmMKPiBAQCAtNjcyLDYgKzY3Miw3IEBAIHB0ZV90ICpsb29rdXBfYWRk
cmVzc19pbl9wZ2RfYXR0cihwZ2RfdCAqcGdkLCB1bnNpZ25lZAo+IGxvbmcgYWRkcmVzcywKPiDC
oMKgwqDCoMKgwqDCoMKgcDRkX3QgKnA0ZDsKPiDCoMKgwqDCoMKgwqDCoMKgcHVkX3QgKnB1ZDsK
PiDCoMKgwqDCoMKgwqDCoMKgcG1kX3QgKnBtZDsKPiArwqDCoMKgwqDCoMKgwqBwdGVfdCAqcHRl
Owo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoCpsZXZlbCA9IFBHX0xFVkVMXzI1NlQ7Cj4gwqDCoMKg
wqDCoMKgwqDCoCpueCA9IGZhbHNlOwo+IEBAIC03MTcsNyArNzE4LDExIEBAIHB0ZV90ICpsb29r
dXBfYWRkcmVzc19pbl9wZ2RfYXR0cihwZ2RfdCAqcGdkLCB1bnNpZ25lZAo+IGxvbmcgYWRkcmVz
cywKPiDCoMKgwqDCoMKgwqDCoMKgKm54IHw9IHBtZF9mbGFncygqcG1kKSAmIF9QQUdFX05YOwo+
IMKgwqDCoMKgwqDCoMKgwqAqcncgJj0gcG1kX2ZsYWdzKCpwbWQpICYgX1BBR0VfUlc7Cj4gwqAK
PiAtwqDCoMKgwqDCoMKgwqByZXR1cm4gcHRlX29mZnNldF9rZXJuZWwocG1kLCBhZGRyZXNzKTsK
PiArwqDCoMKgwqDCoMKgwqBwdGUgPSBwdGVfb2Zmc2V0X2tlcm5lbChwbWQsIGFkZHJlc3MpOwo+
ICvCoMKgwqDCoMKgwqDCoGlmIChwdGVfbm9uZSgqcHRlKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmV0dXJuIE5VTEw7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBwdGU7
CgpUaGUgb3RoZXIgbGV2ZWxzIGNoZWNrIGZvciBwWFhfbm9uZSgpIGJlZm9yZSBhZGp1c3Rpbmcg
KmxldmVsLiBOb3Qgc3VyZSB3aGF0IHRoZQplZmZlY3Qgd291bGQgYmUsIGJ1dCBJIHRoaW5rIGl0
IHNob3VsZCBiZSB0aGUgc2FtZSBiZWhhdmlvciBmb3IgYWxsLgo=


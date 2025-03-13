Return-Path: <linux-kernel+bounces-560466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4400A604A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5AE16D832
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FCD1F8BCC;
	Thu, 13 Mar 2025 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5c5uPEb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8891B4247
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 22:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741906080; cv=fail; b=dPsg8B440hVKbfy+KKLZ5K9TS2GjILjCygokT2ksAyf1WyW/kx8zr9YWd3c477szGFCm60+zaXqalxvZxWVCdCFqaU/fQ6eMchwPBHfp8gQVX/Yabc7b2gZ3XmsCd9niPZGJBzEYslL9OfkyZ9vxM1FZsdGy/0KpNEs3IIXjvo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741906080; c=relaxed/simple;
	bh=ktCIprP3J496aCtMlSoqIjWaWab3SVm2bJH8SThtrgI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GTjxDvE3SVTQd9Ft54Wpad0ThEMQclhOuiZR4Fg8ac56KANF5y2VSKLrxXUuWZ814pQWSwkR4fV/ByPMyr+8xytzGmV11M4YsBj4O65gEmBQvN9wyrLJGMrlovS6rukTdpIT2/f8g+1bsnTAK8YgMBZB591JH9hOf7uAtSlAsHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h5c5uPEb; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741906079; x=1773442079;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ktCIprP3J496aCtMlSoqIjWaWab3SVm2bJH8SThtrgI=;
  b=h5c5uPEbujum6uuqkk0RRk0Mzl1VX9B24WJ70UW9W5nFviviLfNnWpYE
   +yg/cBiaCCgpo0D+0bA30jJijQ0asqvnMpBpQtIAzlbICbyQVAoEQxKHs
   g5l6GMmBjnx6zW3irqY+gNdKHOiiDCR/eKrlVDhE9VsSAHg++22EMNZCP
   /ty7Y0stBTHTfo96O+4Pwshr0osgEe5iBGMdnwx3X9VSrv1/tzjtGkg9f
   CikimMdmjzAazxW5GuCi8DtGgeGNmLe7ezii3QBDSWOx3v0I6FgM/Q1xU
   9NrJpNKqHvql6fW4lDPU1c8PLQFArTkbDE6WJfACmHGeU3JRs3wZ+Fo/a
   w==;
X-CSE-ConnectionGUID: 1o1euVsIR+SCLV79Hv+lHQ==
X-CSE-MsgGUID: 9YHVZJppSPe+DampLDsdCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="54039608"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="54039608"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:47:58 -0700
X-CSE-ConnectionGUID: QwmusnPUR4q4m2ibDYjA6g==
X-CSE-MsgGUID: RN8bwujrRVCt054bDQM8vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121084450"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:47:58 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 13 Mar 2025 15:47:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Mar 2025 15:47:57 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 15:47:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3BOmTJ6hS9tZg3mGAl5fluEuGNhDd8J9ZSAfRGFx8n+i8Kerz02ZgzUQjR69bTlo+szh2V2YWumMlgNwD4n74PhbpXbjhhGisOoYgluGxC94f5CVu0jUWFw+gbolJzjelc2ipj7MnZKxgLz/Pv35+rYI8SydWD51SLJF7gJp0Wc+72t2swTuVyRn/gUgVBJBoN0om6V0bins01POTP4ZhWpiEkJRZRlOTN93+6aSWaEJDsBKO9uMUCTX8APMZbc3o+O/ssQBxBKt09QqFXCBIXF4aYfouba0QM0LBdbDaD5Y1vcPwRw7LVadxQEItbBSBznR6UdZFvuJGvsmG9h0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktCIprP3J496aCtMlSoqIjWaWab3SVm2bJH8SThtrgI=;
 b=CBbX2hCdmb7Jykxgwx6N9Ll7g4S9Jc/f966vIRJw3WscqmlzB3MHUKbpxM8SIoZ10Lvhplv2S2fGPteGlBmC/il6v1/oGUBw6zU6ZgXYenEsgfQPuqNPd0N8onFIwrmKzV7dQoHwVy20KarW5YAyfMwYX/2UZ/nEygsDAjsEVPOr6xtp8JuynAUNfrWU7yEQKRz2aroIZbasKhTjT1/oiCB0w8ARwhg8ApJnyf6ijzbzqkYtzptzTmgeV9mfw6EskvRn8AEwRwRuHRYAInNZTixDWhvMa4zQyz3Jzvh6k0BezMNxHjywMk5jf11PZU1e50Tdoldiw6lTkzSmnumqLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 22:47:38 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 22:47:38 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Huang, Kai" <kai.huang@intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>
CC: "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"x86@kernel.org" <x86@kernel.org>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "bhe@redhat.com"
	<bhe@redhat.com>, "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>
Subject: Re: [RFC PATCH 3/5] x86/kexec: Disable kexec/kdump on platforms with
 TDX partial write erratum
Thread-Topic: [RFC PATCH 3/5] x86/kexec: Disable kexec/kdump on platforms with
 TDX partial write erratum
Thread-Index: AQHbk0LJuXFYy0Gh0U6rXIUsBiIijrNwJfcAgAAZYwCAARH4AIAAV+KAgAAEGYA=
Date: Thu, 13 Mar 2025 22:47:38 +0000
Message-ID: <e7b259b0a986f3cf1578b000f9113933ef80a324.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
	 <408103f145360dfa04a41bc836ca2c724f29deb0.1741778537.git.kai.huang@intel.com>
	 <4ac689506269e907774806a484e15171b04ffc63.camel@intel.com>
	 <e1b3da33446178861ca34e61675f184b439101e2.camel@intel.com>
	 <5e736c6d7794b8642d020350e302ead0d6ca13ae.camel@intel.com>
	 <da02e1d5a489526770ec737eac41237226cdb5cd.camel@intel.com>
In-Reply-To: <da02e1d5a489526770ec737eac41237226cdb5cd.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ0PR11MB4831:EE_
x-ms-office365-filtering-correlation-id: 71950cd0-2f6f-46b3-1ba0-08dd62810e5c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S1BUTzRoZTBFTzkwa1dwMStYUlFIUlYrNWZxMVlCMmozN0dzdFd4NDg2UUtH?=
 =?utf-8?B?OGgwa0xRN2orUFRFekdBSCtBUTROeUc1WDMyR3JFcDBEUHRkWjJpSk0rdzFa?=
 =?utf-8?B?Um1tZlcyNUxiSmNZelZNZitabVdiMDJWaVgzRDZnV2VRTWtYUVFyL2lwb0pq?=
 =?utf-8?B?TWhzK1g4SXEyQXJUdW9vcmp2ZWE0NXVzclNHQ2xEeGY0eGFmc1pESVh3UTBr?=
 =?utf-8?B?SzBoMlhEWno0ak8vZmU2YVdzckVjZ2lYNUpvVEdnUTFVOE94cThMdVFJSjdC?=
 =?utf-8?B?MnJuZ1ArbmV1OHhGNXBHSVljTVc3b0xzNmFnempPbmZCUHBha0pWR1d1KzN5?=
 =?utf-8?B?dFFpMHBJaGFORVV3YUlmb3dIS21ucUlrVzFDYUhOK2VCQTA1YXFRdWsyL1Fq?=
 =?utf-8?B?UEREY1hjanhVSTNpZWNlY0JyOWozN3NmWVUyK1NvUU5wNXRxV1RGNWRvWFN4?=
 =?utf-8?B?TWhJZzFJcUd4NTcrcFdhSUU1SWJZYXdUUnZ3QWE0LzRjdXNFc2Z1c0lZTzhI?=
 =?utf-8?B?cDAySm1LQzVMcmplZjVpSzNBbWxMZ1ljSVYrU1gybmhyMVR2NHZPMkN4Znl6?=
 =?utf-8?B?MjB5TXhkUzhGQ3VuT0NNU1o1Mm9kdXpiYXY0eHpOK1dpcEFncmIyUndhRFMx?=
 =?utf-8?B?VWpKT0V1TGFlbms5a2VzRTlhazZRL0tSZmF1V3BjeUdRUkdxTlRWeUlac1BL?=
 =?utf-8?B?cFZnaW40UDEzc0p5bTlNb3ZocmJ3MS9WZlcyNitrVDVPTDkzdThLbVFHVzZt?=
 =?utf-8?B?SHk0TVlpcWVYeXlqcDJjQTdLczZuYTMvVTk4azV6NHlIVmYvU0pjZmF3WEwr?=
 =?utf-8?B?UHJpS0ZudEMwUVhzdVJBbUtUQW5NS0NQRDBUcFY3RjNkOFZDOVhMaUkwbFkr?=
 =?utf-8?B?RlpkdkFXOWhBTk93aGYyUUdpTkJISUF6Z1Btb3BuUzFBMmhQaEJDQ2dsdEF2?=
 =?utf-8?B?YnNXaXErRXZQdnBSeS9oeUVlQ0dZbUF5WVUrZk83aXNvUXVzUDQ2TkVsR2Z6?=
 =?utf-8?B?QnlDTmpCNWVhVUdPTCtIcVVMcnVPdWt4eCt0UUV1cjd0MDRBWlBrTnpodHNX?=
 =?utf-8?B?ZTQvRmJsRTkvN0pvZFE2SU4xR3hwYkI2V2s1K2h0TWlqZHFYb005TjVQTThJ?=
 =?utf-8?B?ejVPdW5YYWx5QlNDM2Q2K1V5bVFYdGdhekFxN1JITS9uRTVJVnJpQzRpKzZE?=
 =?utf-8?B?VU1yODUyZG50MC9weENTUGxZaGVaOW5Fa3labmZ0YlRjT3BsSlplR1dXT2ti?=
 =?utf-8?B?dXdISDh6VkFrMzNDYWtGTTV1amJSeDhPelZ1N0FKa3dYZk9BbGRDaEZMbmNK?=
 =?utf-8?B?TWJJSXU3VDlaRklVSE9PU3FnaVhmZzVvMTRtQUdKTGVNV3p4bVB2dXcxU3dp?=
 =?utf-8?B?elVvUXg1ZG5QdEg1QlcxeCtGL3ZJYWpVMXYrOVlJS2FadkhlSjRVV1R0WFor?=
 =?utf-8?B?dHJFa3JHQVB5U29iVTBQRVhJOTd4djUyQVFFS3pKMmlWZVhKZlNUeWdsZksz?=
 =?utf-8?B?REErMnNYbFgrUWt6VGQ1QkVtSU9ZenY4c2k1RlowOVhHMGgrS2hiYjU5NkRa?=
 =?utf-8?B?elM0bWgzdUY0RkJtZUpJL1N2WC81bVRodjN2Y09JWlRwbWdYWmZ0ckMzRTJG?=
 =?utf-8?B?YXg3UHZnM245QlZUV280c2pSbGtDM2FvN0RwMVlGMzNjK2xFbG9qM1A5enBJ?=
 =?utf-8?B?UEMzZWw2OXNTRnU2SGNzS1VWc1ZWOGlkV0ZkSzBqWkFmYUxTa0U0TFRGcGVy?=
 =?utf-8?B?amgxS3dSQjFoTE5jZmhGS090ZGE0QzdhZnhwUFhvZ0huUVV6QkNOT0JBMVRK?=
 =?utf-8?B?R3FvUkJyeDRqS0RzVGRFRFJ0VFVFNkt4SE1iVGc3aFc2Wm9CdUNOb3UvSDdu?=
 =?utf-8?B?bU9pZTRsdWUxMDYxSzJrNk53aENKK1dJcUdRM0ZmQW1wQ0dHWVlrbUhCcmlK?=
 =?utf-8?Q?JEMPSpslXMYfz5UR8I+5YMJSO9o15tGn?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWdyc1ZjdWxtc2g4a3htZk90Ri9tMk5qMVJ4ai9hSXE1N0pLd2taQkNUMWhw?=
 =?utf-8?B?SGpSRkpVSDV1cGJDSDdRa0dCN0lzYXIvakk3UzZ4WWZROTZ0NWFBTURURy92?=
 =?utf-8?B?ZW9iQXJZajQ1RXRCK2ZNSDFKbmovWkwvUTYyVVJMeWVJdGdNMEwvTzNzOStW?=
 =?utf-8?B?TzFjY0wzTWZSMWpwaVNvcmpSeWRhSExzaU9hRlRNT001MGNzM1pPRUJRVkFk?=
 =?utf-8?B?djZpdGZQMnNsUUFyZnBOb3J6QWp5UEZrVC9EZE50MEdDLyt1TU1jUjJBUzlv?=
 =?utf-8?B?Tjc3V05wSTRJY1N6UElERU0vdHV5eC9TTEdyQTR5MFBzMU10M0NnMnBsVFFp?=
 =?utf-8?B?S3ZiQ1VuUGd2U1lLMitscmo5RVpnVk5mZ3RjVHJzaDBPRVU0ZkVUaU85NWdD?=
 =?utf-8?B?ODJPZi9HWkNodjFHZVRTZUZZUTZvWFhpZjBSY0l0bFdIU3pRcUVTeExKK2NB?=
 =?utf-8?B?UE1sZndpNVpiTUJMMXk5V28reDhHaktsQVZEWEY5dm9vL1Z6NzFoazRBNExp?=
 =?utf-8?B?U1hWVkQwN1RWUFA4Q0s2aUwvck52OGRqcEtuZ0grb2srRUFqMm9DRGFMNkls?=
 =?utf-8?B?TFU1WWpvQlY2bU45Q0FsUUNuTnpSVnV5UHNROStJREs2aXN2YlN6Q2grSFF2?=
 =?utf-8?B?YlltRER6U2ZJS3dXdmh1b0RBSzY4Slc1c0R3eGhFaHNmZGZDbzAvOWozZGRX?=
 =?utf-8?B?MExQNmgyOUdkUWFzY2I2R2pTMlhqd2J6cE8zdExKallrdUhMckJNbHRIK0sy?=
 =?utf-8?B?dlV2SXVIUytWUG1OT1hnNm96S1YrRUorS3JrUkJ2cDdRd3AwZ1ZHTGpBaS91?=
 =?utf-8?B?cVZ1QTd4UUtxdzc3YUVpU0lpT0pFSjVkZVpjRWdObXpkUUs3VUNuUHM5Z3Yy?=
 =?utf-8?B?aW9wRHAzRXVDRjRyclJhLzNtekhOSUxwZ3dNdGVTL29Pd2cwTG5JWWhxVkVx?=
 =?utf-8?B?NW5kdkVpeDRTVWJtN2RQRzVVekFtTk8rZG52U2NBY2ZTa09SMDlEbFJuQzBH?=
 =?utf-8?B?aGtSZjRZK292bGFOYm81UGJYT3I4MzZRWk1nQi9XL3F1emNLa1BLQmtrR0pH?=
 =?utf-8?B?Tk1EMGxzcENyWUVwQ3JIWW1NM0JidnFsSUNiczZiem8yMTJlWnBLa0J2cjVw?=
 =?utf-8?B?SWJiTkZXVk42RElub0k2ZDcvSHdUSGJBUHlJQ0tyZ1pTMnNwaHp1ZDZvVUZQ?=
 =?utf-8?B?V05kcC9UcXl3QWVqUUExUllkb0NkT0h5c04zUW5KUjZvMVpYdUZQVlVtdDlr?=
 =?utf-8?B?NDVENVBMT2lhRXNPQVlVcHd2RVZLMVZVcFVyUEM3V3A0TjN5OEhCN0tzMmZq?=
 =?utf-8?B?ZFVtbUE3dVhmMTV6YWtITE9MM2F1aGsrK3V6WDRDU2h5amFyNm1SRUJoUzcx?=
 =?utf-8?B?L0ROd1puLy9tMkhyY1o3Q1lKeFpoS3ovaVFNaEpleEF4di81S1BKVTFHMXFD?=
 =?utf-8?B?M1dEa0w5eEtqQXFjZVBHamVsOGFDUnMrVEVPTUFUVDhxcmtLSWdJelZadnZJ?=
 =?utf-8?B?dnBad3UrejBrengxbjJwVE1ORllHQjFuK3NGYUwybWI5V0p6a09zYTMxd2Fz?=
 =?utf-8?B?OWVtQk9PN2xJK296a21kSEJGOU03RmxPc0ZlUUE0elZ4ZU5yay90d1ZUR1Rp?=
 =?utf-8?B?VU5nbks5NHZ2K2l1bit1U0dEcUlVMFlBRGYwR2tyQ2hnRDhtVkUvcHc4R3FQ?=
 =?utf-8?B?UzFsK2Ntclg4b0VSMzhxRnNXZEMzUmpTMnZiVWFtSEp5Z1llL1VPdDh2dEx0?=
 =?utf-8?B?ZjZLRlJrajJ3eTZsUkxFYUNFK1Rvbis5UkVrUnBOY25qa3YrMUdiNVRLNDha?=
 =?utf-8?B?VlJXdStkZENzM2tZamVTVm1kR01lVGNHbmRxVFB3WXErbkVzNUdtWGhiNzdX?=
 =?utf-8?B?QysySjRZZzl6M1hJR2pxcm1VdlZMZjVVRnJnSWpyZUtGTGxTWnlBMzkxNXdx?=
 =?utf-8?B?S1l2UWpCellzaU4wWUI4SUxXS09wRkVKcGtTbDIxYmJFZ21RM1FwZWVJbURL?=
 =?utf-8?B?L0taTHdTYVJJdU1RVWlKU1ljZDh4TnIzanhtdG1uNkVPRFZxZWdGQXZia295?=
 =?utf-8?B?UWE5bFZ5amphcHZybG9kbnZTYkZlZ244cnhVQ2p0R0VZOE9YVW1rcUtyUW9m?=
 =?utf-8?B?UGZKN0J0ZTMyejhDVFZ0R2p4czZ6Uk5HNGxQck9CL0RBbG5aY3hVTHYrK2ZK?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C84BE63F9771484EBB86CDCD163C905D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71950cd0-2f6f-46b3-1ba0-08dd62810e5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 22:47:38.7450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ZDYQ2YCbfUkc5mr885Ln36kMhm13RZbZD42QPDRn1NFUqbP5Nkkp2xG+0aChp8kr1jzYhBsoTtSRnDlCPFGs7vAONVFrli2xYkQsuMKQcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4831
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTAzLTEzIGF0IDIyOjMyICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+
ID4gDQo+ID4gPiBXZSBjYW4gYWRkIGEga2VybmVsIHBhcmFtZXRlciAndGR4X2hvc3Q9e29ufG9m
Zn0nIGFuZCBza2lwIGFsbCBURFggY29kZQ0KPiA+ID4gKHRodXMNCj4gPiA+IG5vDQo+ID4gPiBl
cnJhdHVtIGRldGVjdGlvbikgd2hlbiBpdCBpcyBvZmYuwqAgSSBzdXBwb3NlIGl0IHdpbGwgYmUg
dXNlZnVsIGluIGdlbmVyYWwNCj4gPiA+IGFueXdheSBldmVuIHcvbyB0aGUgY29udGV4dCBvZiBr
ZXhlYy4NCj4gPiANCj4gPiBXaGF0IGV4YWN0bHkgYXJlIHlvdSB0aGlua2luZz8gQWRkIGEgdGR4
X2hvc3QgcGFyYW1ldGVyLCBidXQgd2hhdCBpcyB0aGUNCj4gPiBkZWZhdWx0DQo+ID4gYmVoYXZp
b3I/IFdoZW4gdGR4X2hvc3Q9b24gd2l0aCB0aGUgZXJyYXRhLCBrZXhlYyBtdXN0IHN0aWxsIGJl
IGRpc2FibGVkLA0KPiA+IHJpZ2h0Pw0KPiA+IEJldHRlciB0byByZXR1cm4gYW4gZXJyb3IsIHRo
YW4gcHJvY2VlZCBhbmQgY3Jhc2guDQo+IA0KPiBUaGUgZGVmYXVsdCBiZWhhdmlvdXIgaXMgdGR4
X2hvc3Q9b2ZmIGluIG9yZGVyIHRvIG5vdCBkaXNydXB0IGtleGVjL2tkdW1wDQo+IGJlaGF2aW91
ciBvbiB0aGUgVERYIHBsYXRmb3JtcyB3aXRoIGVycmF0dW0uwqAgVGhlIGRpc3Ryb3Mgd2lsbCBi
ZSBhYmxlIHRvIHNoaXANCj4ga2VybmVscyB3aXRoIGJvdGggQ09ORklHX0tFWEVDX0NPUkUgYW5k
IENPTkZJR19JTlRFTF9URFhfSE9TVCBvbiwgYW5kIG5vDQo+IHZpc2libGUNCj4gaW1wYWN0IHRv
IHRoZSB1c2VyIHdobyBkb2Vzbid0IGNhcmUgYWJvdXQgVERYLg0KPiANCj4gSWYgdGhlIHVzZXIg
aXMgaW50ZXJlc3RlZCBpbiBURFgsIHRkeF9ob3N0PW9uIG11c3QgYmUgc2V0IGluIHRoZSBrZXJu
ZWwNCj4gY29tbWFuZA0KPiBsaW5lLCBidXQgaW4gdGhpcyBjYXNlIHVzZXIgaXMgZXhwZWN0ZWQg
dG8ga25vdyBrZXhlYy9rZHVtcCBjYW4gb25seSB3b3JrDQo+IG5vcm1hbGx5IGlmIHRoZSBURFgg
cGxhdGZvcm0gZG9lc24ndCBoYXZlIHRoZSBlcnJhdHVtIC0tIGtleGVjL2tkdW1wIGFyZQ0KPiBk
aXNhYmxlZCBpZiB0aGUgcGxhdGZvcm0gaGFzIHRoZSBlcnJhdHVtLg0KDQpTbyB0aGlzIHdpbGwg
c3dpdGNoIGFsbCBvZiBURFggdG8gYmUgZGVmYXVsdCBvZmYgdGhlbiwgdW5sZXNzIHRoZSBrZXJu
ZWwgZ2V0cyBhDQpwYXJhbWV0ZXIgc2V0LiBJbiB3aGljaCBjYXNlIHdlIGNvdWxkIGFsc28ganVz
dCB1bmxvY2sgdGhlIEtjb25maWcgd2l0aCBqdXN0IG9uZQ0Kc21hbGwgY2hhbmdlLiBURFggYW5k
IGtleGVjIHdvdWxkIHN0aWxsIG11dHVhbGx5IGV4Y2x1c2l2ZSwgYnV0IGp1c3QgYXQgcnVudGlt
ZS4NCldlIHNob3VsZCB0cnkgdG8gZmxhZyBQYW9sbyBhbmQgc2VlIHdoYXQgaGUgdGhpbmtzLg0K
DQpPciBpcyB0aGUgcHJvcG9zYWwgdG8gb25seSBiZSBkZWZhdWx0IHRkeF9ob3N0PW9mZiBvbiB0
aGUgZXJyYXRhIHBsYXRmb3Jtcz8gQW5kDQp0ZHhfaG9zdD1vbiBvdGhlcndpc2U/DQoNCkl0IHNl
ZW1zIGxpa2UgdGhpcyBzZXJpZXMgaXMgY2xvc2UgdGhvdWdoLCBhbmQgd291bGQgcHJvYmFibHkg
YmUgd2FudGVkIHNvb25lcg0KdGhhbiBsYXRlci4NCg0KDQoNCg==


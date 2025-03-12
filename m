Return-Path: <linux-kernel+bounces-558597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EECA5E861
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367A617BC81
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1CE1F1536;
	Wed, 12 Mar 2025 23:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nMPw8brD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBD11EF389
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741822053; cv=fail; b=JXxt5F44pwq1GCcSIUEmkVaRHpljXmFicLWEXRnW6+/Z85ZZLqvZ3Z+W0DZEMWsk90X3rsRTdmfV2bSvr2zS0Y1v0/8tcn2g8NTRg8tyWs3Dmb83fR9pEF2hROsGNlHMsIa9o4STHQxg6Se27E3ilL5Hu/2O9+WOo5g8RRsF/dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741822053; c=relaxed/simple;
	bh=5vWXAN/ErRuA+5ovgd6cGuaIf9/525HAUaCD8PA/Q3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l/K5vTnIOYwxZOwotBl6ZcSrNeAdAladzKP41av7Eq2J5Wuh+uoQ+HK7RFskZIQ2tJjz4T2unlw9VuyXihaN+lMDz79IEwd8oGxVA885lBc0M766776bIUpzwhi+jCuIGfaZROx9J9eN1ZYChGcLjdg15JOVa429pJVfdGG9ej4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nMPw8brD; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741822052; x=1773358052;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5vWXAN/ErRuA+5ovgd6cGuaIf9/525HAUaCD8PA/Q3o=;
  b=nMPw8brDetjnSg+Aw9M259YECSigIqeJ7C47JLIL5DAbb0ONoolvvXIe
   oxp+hURyZV658zDfv7g08S9HD+uxDzwTLaRDzPoYWCO5NZbvQFU4JvZ4V
   yCxqnt5T0eacCSYimpPUrT/mBojr7DNjkhOJYaqduMMLF4CgcXQQFdD1o
   SAvLICQcILj8Kfbn15nkvYC/M2nQ419w8hhy8kmd0lxh61fjIARh/LIo1
   vk4kTIU7Ds4rJhf4CQQud2cLSQt+mg2kRY2mXgjpG4g6VYBVwVXpXc8No
   vahQIONLYk/pu9WIMvf8BDepOZ0eR0Tv4dfEq4OTZGOM3eZqY3W3Q5QO9
   A==;
X-CSE-ConnectionGUID: Ii2SWRC+Sh2be1/oT7qqHA==
X-CSE-MsgGUID: I2AoKV7CR2GSFH0aNIcKxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="46703080"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="46703080"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 16:27:31 -0700
X-CSE-ConnectionGUID: SdvIEzUxSNKRDyN9tW9svw==
X-CSE-MsgGUID: 9xH0WueCRdyOhhiPvw8T6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="120493065"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 16:27:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Mar 2025 16:27:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 16:27:30 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 16:27:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYV4+bUa9KIapReh4Fbit7j2BtwIEZlgU0e8opwBa5bbrARqVJRNKZbDFOHE2i7PJrCXD25SRdSU8fkj7jfVCYkpn3739z/spZ5IrC8iiFvzisE2FZ1aGFGdXcF3w7Mda+rnqXlJq4EGLgCBMNn7H6sYyf2Y9Mr/oYIQPC128rRNUigZE/vPAkHHCboGT+llCmuUx/mz1b7JmeWxaasCNDnAoAvGEGPUy8DjIRIhQojum3KxCRiAShZQte4U2KLvW/DWWHpfYnklfWRskT6gruCsmc4DOU1XrRtSxK6mDvuENenIie4++agYxVmhAxufKSlbcVJU12Gn/qQtFdYq7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vWXAN/ErRuA+5ovgd6cGuaIf9/525HAUaCD8PA/Q3o=;
 b=TiOxXe81DGDc3pjXZoH9eNw09O3XXg2bz3DqydipHnl9svg4+U2k8K69Qc/QWD/iO5mzWZ3/yiJOrghccvgR5AiH+I/4mS+I2X3mSeNZH0jajJ8qyjrjIEcsNR6sWKEkxYoSEEk7Hc1F7H+3JXgd7YufKxZyCo6tH+Ww44q9Z+ssewKIEaaKEj+1mGw23rIaj/LYwTpGxo6HxsiyPeO5re1d5NHXNMmg0ToGAU8ABkga0aYFusy3I415tN0k+NGaPgpbMctLsKWkrA/QCjk2PiYODRPBZ4SbpwTaGPhg5BmTEQPLIhqchLxJ7sSY6+X0eID07jO0fFj6rGRmDX6Xaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13)
 by BL1PR11MB6052.namprd11.prod.outlook.com (2603:10b6:208:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 23:27:00 +0000
Received: from LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::d099:e70d:142b:c07d]) by LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::d099:e70d:142b:c07d%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 23:27:00 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Huang, Kai" <kai.huang@intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>
CC: "nik.borisov@suse.com" <nik.borisov@suse.com>, "bhe@redhat.com"
	<bhe@redhat.com>, "seanjc@google.com" <seanjc@google.com>, "x86@kernel.org"
	<x86@kernel.org>, "sagis@google.com" <sagis@google.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "Chatre, Reinette" <reinette.chatre@intel.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 3/5] x86/kexec: Disable kexec/kdump on platforms with
 TDX partial write erratum
Thread-Topic: [RFC PATCH 3/5] x86/kexec: Disable kexec/kdump on platforms with
 TDX partial write erratum
Thread-Index: AQHbk0LJuXFYy0Gh0U6rXIUsBiIijrNwJfcA
Date: Wed, 12 Mar 2025 23:27:00 +0000
Message-ID: <4ac689506269e907774806a484e15171b04ffc63.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
	 <408103f145360dfa04a41bc836ca2c724f29deb0.1741778537.git.kai.huang@intel.com>
In-Reply-To: <408103f145360dfa04a41bc836ca2c724f29deb0.1741778537.git.kai.huang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB5976:EE_|BL1PR11MB6052:EE_
x-ms-office365-filtering-correlation-id: a418eb2d-dadd-442c-e905-08dd61bd636c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cnBjZDhzbXJ2enlKZXJjWWFKRlNkYW42ZmtZSFFuS29BYXNLamtRbkZ2WnVm?=
 =?utf-8?B?dDNycjYyS3hIdFRXbHg1cElLa2hicmU4WU5UeDlGK0FmeEpKSDB4RkViU3V2?=
 =?utf-8?B?OWFEQ0dYSXpJeStwRWIxNE9iUWhYVjhhdjA4UHZ3aGF0YnRBRmJMZW9VRmpP?=
 =?utf-8?B?ZFVJTCt6dDl1K0hZUllGTjJOMWwzSkdaUnMxWUNGN2JGek9aYTYraXJiMkJV?=
 =?utf-8?B?M3hkSzE3dkpMaERQTWNMVEgzUk9PUUZFbTVVRXV1NG83T1QvVWhvaGFqb1M5?=
 =?utf-8?B?czVHWlI5SzhTdmVIZjRHNmk2UkNJb2lDdVFkVTl0NXMwdWpKTWViMXk4NWtz?=
 =?utf-8?B?RXpmUUs4WmdRdjU4dHZ5d0FJZlppT2gyeGJsa3JicmtLNC9XcXJpZVdMajkv?=
 =?utf-8?B?bkVnNHIwcVYzNFJ5UENnaU9WQjBrYVY2QjFkZGxkdFZ3M2l3dkN2aHdoSlM5?=
 =?utf-8?B?Mk14ZHF6bG5kZ21qeUJCeFEwRjJydExwYmllbGtiTG1leGpFcnpTZDdGQmZh?=
 =?utf-8?B?UmFIOFRHUXMyQi93dGY2cHo2aHh4MFhsMTBINVd4ZERORjhzT1NmcW82L1FQ?=
 =?utf-8?B?YnpkNXhNbkR1VEFjUTB3OWRLT2ZKWnFaaEgwZ0krRzlEaFZ3YTBDVWpvb0dq?=
 =?utf-8?B?VUQvbmUzVXBYY3VSZzFKZDR0WDVlOWpOR1ErSkp6YXB6WGpzQ1hoOVBGYmpx?=
 =?utf-8?B?a0daQWVORHVyaWh2b25VSXM4V0czc0VWZkRCY3FQV2lQRkZZYVRlS1FlYzhI?=
 =?utf-8?B?eFJtaEowT3FlaElaTWFLNkt6UkQ3akJDQ1lNQUVvN0V5VFdnOU1PN0Yrb1VW?=
 =?utf-8?B?aTFRQlJBWmYxSEZhdzM0L0g5anJoZ1RDQTJzZ1JiOGN3SUhrZHkzYlpSUmZY?=
 =?utf-8?B?RURKQW5KL3liMUZOWldMYkpQTFlrMSs3ZDZWUlNsOS9YUHl3QVVhMzFiS2tR?=
 =?utf-8?B?VzZuQ0hFNVIrYnY2SS8wTGx1S3VLTVlPaFBsZHJPQ2J1cWRGU2ZxckkzTHlN?=
 =?utf-8?B?cHF3SVA1eEhqZTNvcnI1SlErSGVpVVdPUUxISmdjUjh5NDh2WXRsZk5yRTdI?=
 =?utf-8?B?dVpvRTI0Q1NhVFFVbGcveUdpVFB1OUVzcDMwUm1ML2VIUkxWZWtXY1hEWTgv?=
 =?utf-8?B?SjNGYkdIc3ErMGlsTjRzRzBIa3JjcVNSS05aZWxOWm1VY2FqWmo1UFpRblpF?=
 =?utf-8?B?dE9wRnJoWVJvcDR6YkhtdmV3V00zMGZqOUYwY1VDcU9pcXU0TmRpMkJQYm9Q?=
 =?utf-8?B?MTBxWjRFY2hEV2FkdDBzUEpUYzIrSnY2MlYxSVhZeEIycFJ5RHR4ZU1BQk91?=
 =?utf-8?B?WDBCOXRYeHl6aTNTbXlBL3F4SHJsSUVpc1AvbmNvY2ZVcXFVT041ckVrM2RC?=
 =?utf-8?B?UnVYUGZnR1FrdWJ5NStxSW1WNEV5b25aNjJaT0dpckxqVkRpUWdlQmN1SUlu?=
 =?utf-8?B?NG8wRW44d2QxOUxOYXNheFZzZldwQzNOQ25tLzEvdkhKK3dLSStJdmhhYTR6?=
 =?utf-8?B?V1NOdytRNGlPMzF3MGZtOGRoUVRkaWpHWC9yT3lsTTAyQ1YxdExjRFFsaXB0?=
 =?utf-8?B?cFEvY1ZOdlJ2UWR3NGE2L1REY0ttSkJrRVNTTEVEWVFRR0QyaFJwNU9oSnZY?=
 =?utf-8?B?YUhTQ25jU2xLRFV0R000bS9VVTVTNlFZNmZwb3hXWUlXczNQbmVEcTFVR2l5?=
 =?utf-8?B?RnV1Rm9lY2pPa2N6alFPekpabm05dzduakRXc2NWaGc5SVcvZHlqSDA4Njh2?=
 =?utf-8?B?aHhWYURIQVNBcVpreHpXV2puTFd1MGYwQmxOMUdiS0RsY2JEUCsrTEMwcU5l?=
 =?utf-8?B?VzcxY0RZZ2JIODdwVXZFY3Fna1plQlZ0L2Z6ejF2UWt2SU9BMDJzRkpmL3Mr?=
 =?utf-8?B?Z3lWZ3FxMHdNQk0rNUlxaUdZY1lVY3pjTXZ6ZjhidjdEdG5pUk96VDNkbHVT?=
 =?utf-8?Q?ac/ezOoG70RQzklD2gOfAljp8oBBhZCG?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB5976.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUpXbDdudGpRQm9NT1dEY0o0U0xzVUpNeEJveEd1THZNYTBVOVh2VlpPNDNZ?=
 =?utf-8?B?dElWYTVJQkQrZ0VSOGtZRjR6WmQweE1kN2VDak0xbGwzUEpyd0NxK0twbUpZ?=
 =?utf-8?B?YWRpVDdGbHlvU0ZVdHRTU0c5UWhzczlDbmo1elhLM3EwdWhsU2xaaE83aHVs?=
 =?utf-8?B?dVlIWktMd1lyMVlrbVBTU3VvdU80VEY3M0Vyclp3cVI4S2c5K1BtNC9JOXZh?=
 =?utf-8?B?cGVjVnhRN09LZHV2ZkYxaE5qWjB4YXRGbERKd2VNaDF1VjNUNXdyYzVUL2tK?=
 =?utf-8?B?RjhSOUZaZ0EraWI0NnEyNHNsZDhZZ1RBclMvNWtJVFluTXAzYlVkNCtrTjVS?=
 =?utf-8?B?a1hsTld1cm5Ic0tsT0xvWnpHODdNS0pzYnQ4YVdib1o1bytKMDIydTVqQ2E4?=
 =?utf-8?B?NDVNMDRCUmhkdW9ROWo3eGs1TW5CV3dMTVJtczRqR01VSW1NbVNoWDd4LzYy?=
 =?utf-8?B?UjZWTWs0NWJEa2Q4Yk5FUnN5UHM4ejd5aUduMEpXc3FZWWJNWldDcHo0dDNV?=
 =?utf-8?B?VnR3c000ay9aVEgxRXYxbGY4V0RhRHRRVmt4ejBuaWVxTWhFSEJKdlE2NG1N?=
 =?utf-8?B?TlJHZGd6QVRlbTdVeitZdkp3ekt1S2VBU2N4RVZCRHBzVS9BRWJMUlpjTEJC?=
 =?utf-8?B?V01hNWk3dk1CN25aNk5td3FNd0VueXpHeVBJM0x6SlYzeTJaR3k4d0IweVdj?=
 =?utf-8?B?ZktFc3N3MkRERFhsVFNwdjEwdHRQS1ZOZlhwRGhIcGk0WXRPTFF6SkV3T2FC?=
 =?utf-8?B?b3hyc1FrcnNXYWlMdmpYbDZmZ08xY2FWc0x0QW55YlgrTkFlbGc5MjVxeHRL?=
 =?utf-8?B?ZWdNT1d2cjZWZkFEN1JJSndHY1RaekpiOFBJZ0FDb256dE5PbFo3cVdsV1Bq?=
 =?utf-8?B?UXJYVnh6eS9ualZkcTR1VVoyNS96TEVudjlJd2hVZlhZYjRkMG5xR3Z5T3lJ?=
 =?utf-8?B?WXBCUlpoenBGa2RHTmg0cThydWtBdjFsdkVaQThNQ1hyTWNDeGtSOU5HcVNu?=
 =?utf-8?B?a1B2YlBweTZzeXVlajBBbm0xZDQvbURXMU44azVFblZzM1E0WnZDaTRlK1lt?=
 =?utf-8?B?aFNDY2tHeFVDczVpQ0pRbWNFNVFOTUVVNTFKWVp0QmlnZU9zZU5PU3lMNkZR?=
 =?utf-8?B?a0JIMTlvSThNR09XdzZOWWkyVzEwemN6SUt5ZWhsak41bUNjbUtTODlMSC81?=
 =?utf-8?B?UURjcnprL3Q5Q0NtaDZSQ0trdWhzclVoY0tmYUtFU3h0S0xUSFJ6eEs2dWFl?=
 =?utf-8?B?cXl0TVR0MmVnbytRaitiWE45d2FLSnpkOWZ2alN1SVFuc1RpeFhyS2Zyb3lp?=
 =?utf-8?B?WVVXbWtiRVVtZFR1TnVlNDJYaXlSTngxV3pwZ3FVNHh6TkdQbjgxcTN3Zk9U?=
 =?utf-8?B?c3g4c2hCQzE3aHF3RWt1TUZ0WkdNbDc4dlNhaWkreldza2krcjMvalNFNk1z?=
 =?utf-8?B?NHUrR09yVTBabFhHdkJnUjJEcHp6bDVGOENmUUwwN3VLWmJOdTRUSnFyWnov?=
 =?utf-8?B?cjZKNmtnWGdzK2gwSHpwcGhDa1BGTlpYMjFZMDFGM2Q4TWcvS0llRlhJcTFm?=
 =?utf-8?B?THBXblNFai9BMW9LVDVCYy93WEtLRHp3RFlSMGh0NEM1T2lZckV2MDYzaERx?=
 =?utf-8?B?dm1Db084M2txZU1oR1k4UmZaWWRVdXAwZXkwWVRsY1hFWHpiOVVFYnlpamlE?=
 =?utf-8?B?RGpZSmZQYnJkSGQ3d3hCSWxqM2lEYnBYUEl3Y1k1K0NDcVFCVksySEhaVnpm?=
 =?utf-8?B?R0hLVWZQRGdxUXpPOE5WaEN4VGV3ZFhDaTBsbFVqRllHNGlFaTM3SWJzVWh3?=
 =?utf-8?B?VzhuWnVwN0I1YXVGUWp6WTZwengyeURWbi9RUWhlNGplTlNINWJqMktBUkcy?=
 =?utf-8?B?c2Ewd1pMS3FoWFZYd2FMclJZQUxYRUR6MlIyT2xxN3YwUTVVbFNGaVo0RDZE?=
 =?utf-8?B?aysyVDFOcUlsU3BzWEkvak95ZFhJVE5ITlk4WjVDUkhEN3VjdEVjMVpkdlZO?=
 =?utf-8?B?Y3hkYnNVT0J5d0s4dkYxRXE0bThJbzF2TkViYjF0Nm1NL3MvRlRGNGNLcE1o?=
 =?utf-8?B?UEI5VGFCb1ZMSzJrcXZhZDl2Z25KZFhnRXBja2dMVXlVV3UxTFNDcERJbjJo?=
 =?utf-8?B?QWRoTmQ0TjVHYXRsMDluUGlGZDdoQXdWb0hlSDZxY3p6MHNJY0pUeUIvRnBJ?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B4D8221B70C144493D0CCE3064724CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB5976.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a418eb2d-dadd-442c-e905-08dd61bd636c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 23:27:00.0986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V7IB9YsnTLRoE9VMs/AorSCH9PbPfmql3EY6IIouoyITKwo2S+4aEczitOe11Aayyr9OYNj6bXBhX/s7/ofcarCN0IDCU9Z7Esostlix1Uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6052
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTAzLTEzIGF0IDAwOjM0ICsxMzAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+IFRo
ZSBpbXBhY3QgdG8gdXNlcnNwYWNlIGlzIHRoZSB1c2VycyB3aWxsIGdldCBhbiBlcnJvciB3aGVu
IGxvYWRpbmcgdGhlDQo+IGtleGVjL2tkdW1wIGtlcm5lbCBpbWFnZToNCj4gDQo+IMKgIGtleGVj
X2xvYWQgZmFpbGVkOiBPcGVyYXRpb24gbm90IHN1cHBvcnRlZA0KPiANCj4gVGhpcyBtaWdodCBi
ZSBjb25mdXNpbmcgdG8gdGhlIHVzZXJzLCB0aHVzIGFsc28gcHJpbnQgdGhlIHJlYXNvbiBpbiB0
aGUNCj4gZG1lc2c6DQo+IA0KPiDCoCBbLi5dIGtleGVjOiBub3QgYWxsb3dlZCBvbiBwbGF0Zm9y
bSB3aXRoIHRkeF9wd19tY2UgYnVnLg0KDQpDb250aW51aW5nIGFuIGludGVybmFsIGRpc2N1c3Np
b24uLi4gQSBwcm9ibGVtIHdpdGggdGhlIHBsYW4gdG8gbW9yZSBzaW1wbHkNCnN0YXJ0IHN1cHBv
cnQgZm9yIGtleGVjIGJ5IG5vdCBzdXBwb3J0aW5nIHRoZSBlcnJhdGEgcGxhdGZvcm1zIGlzIHRo
YXQgd2hlbg0KdGhlc2UgcGxhdGZvcm1zIGNvbmZpZ3VyZSBURFggdGhleSB3aWxsIGxvc2Uga2V4
ZWMgYnkgZGVmYXVsdC4NCg0KUHJvYmFibHkgYSBiZXR0ZXIgZGVmYXVsdCBmb3IgYSBsb3Qgb2Yg
a2VybmVscyB3b3VsZCBiZSB0byBoYXZlIGtleGVjIHdvcmsgYnkNCmRlZmF1bHQsIGFuZCByZXF1
aXJlIG9wdC1pbiB0byB1c2UgVERYIChhbmQgbG9zZSBrZXhlYykuIE9uZSBpZGVhIHdhcyBhIGtl
cm5lbA0KcGFyYW1ldGVyIGJlIHJlcXVpcmVkIHRvIGVuYWJsZSBURFggb24gdGhvc2UgcGxhdGZv
cm1zLiBCdXQgdGhlbiB3ZSBhcmUgc3RhcnRpbmcNCnRvIGFkZCBjb21wbGV4aXR5IHRvIGF2b2lk
IG90aGVyIGNvbXBsZXhpdHkgKHRoZSBlcnJhdGEgcGxhdGZvcm0ga2V4ZWMgc3VwcG9ydCkuDQoN
ClN0aWxsLCBpdCBtYXkgYmUgYSBuZXQgd2luIG9uIGNvbXBsZXhpdHkuDQo=


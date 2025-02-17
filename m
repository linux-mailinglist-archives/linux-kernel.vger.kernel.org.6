Return-Path: <linux-kernel+bounces-517422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C918A3807C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DFFC3AF50F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B891217657;
	Mon, 17 Feb 2025 10:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPcifcyi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7D1216E2B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789100; cv=fail; b=d9ZMEE1K34yZnl/n6mA87jL4BPd1aAnuMoDh7NPAiM6YC+H2iSAAyfPck2lC3aBWaHAiM5gtARq10m9kJvxcOWbKMoRbE/nvvgV3LfIccpbSH1OBabrR0KeyjNqIdXGn15XMDw2odCYJXvlcfyAog4GzUugz4IgcnJbJSFZzK28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789100; c=relaxed/simple;
	bh=uEHE2+vIQ4bY5TK848QibVnvq5V97750jPw9TznX0wc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NAmk0/eZe3ssOVQTufXNbxgWvXy5N/cWT/BPSel7uDQVuvPaKmvFdHxMSN25i2xuOLZBRlUSOqoRs6twX+02CTw3dVC0UAKc7tu4OXofN4mPmgsKDKyK0vWoslOh3tAQIFDoYj6FB8ZPGBVrfxoqatHJ1Gx/cSfzllwL1E5gx1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WPcifcyi; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739789098; x=1771325098;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uEHE2+vIQ4bY5TK848QibVnvq5V97750jPw9TznX0wc=;
  b=WPcifcyi5/NIPZ8PJ+3+JTXUaEMGkuHS3euax59Ne+gzJv7VXm2g1Xka
   JWTfiVcDcRV86tXGSMFkAPqzGde2uK2y/U5L9akQT6vQ+wNrf9csB8Wcs
   KHzTkqEMIPwFzLSLW686tn5GBxqOl1Bma+BVoTVTdc39rxgvpYgf8JF2J
   W8cyxuZBuWxYmtIXerldiBa36t68N1O3yyG3DsUzCHqsFJQDkT3kTtzES
   OoTZVBG+yrbviEAqDartt9xQXZmfu5tt/UPgkj+4qbfutuzbD09H1sqdL
   u+w8YroOAfo1GTTpYdpEb/Hjga2Emq6uJTHdkeqXdu/NNvHzju0RnvFR6
   w==;
X-CSE-ConnectionGUID: 1ZmX1u2QRA6lkaTpUStx+A==
X-CSE-MsgGUID: L1iiUIbgTxy1Qo3qPfv31w==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="57872618"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="57872618"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 02:44:57 -0800
X-CSE-ConnectionGUID: IdaiO1t3QQ6lkEo/f5gGhg==
X-CSE-MsgGUID: YyuLgLkdQSK81irVps00Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="113960086"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Feb 2025 02:44:58 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Feb 2025 02:44:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 02:44:56 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 02:44:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtWFteyFc6iXf2Oc9pqOL98UTicelR9n+InDRmDIj2yS2Kypyyf+DgBRmjEwcP6+1cfl+M6pjuIp/SdnGKtzKEmNN5166LXmvstlqPMVg12g/UF7+2BNu1jpFyeeK2Kxeh8tNKe6UTk1tIirQBmdES2s1zswdwoVQ4FjPF11u4LN6i72QjZYCk46LI+3gnLIY9p1STTeOPICq9/WBxwuVfxCslGEeYrcgLkfkwSKgNS2d8F2+jQj2VYAbNbLGgEThkongjg5zGEEyta3sbc6FTZdayZ2ioZ2U0HtiFKYsvbCKJQphzX4EJnwrNVm72qentjNp526HE76AV07UuZ0lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEHE2+vIQ4bY5TK848QibVnvq5V97750jPw9TznX0wc=;
 b=lq0Y4G120uVu2buC2hCJ2Wdm/4x7T95WXe1wO8mCAAkmq/aUtBXEtfVEQDf0U/9iJjv1lgTefrKdaD1NfHKCkuy4+vAxa5jsEYGJeeaMz/KFC7s5bJVFOAQ9083CZR/fKKMQVJJyP6AIvP0ynjonnDyeyVuACs/GgqXA15RklFHsmjhjUOeun9kTzKS0+lo6qgjMnhsgpokzyxP5HoR2wwJxUUvrOXjg6/Y7BBqgEHXfzP1M1UMh9qK/+Rm+PBg5XZXVayjW0CUts1MfO1utjU0EAFxdBPqXFH1Kx97DG5IN9jK60eKbVl2N9vYwynHjrGU7dgkGdHKpkgfWmBja0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY8PR11MB7923.namprd11.prod.outlook.com (2603:10b6:930:7e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 10:44:49 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%6]) with mapi id 15.20.8445.013; Mon, 17 Feb 2025
 10:44:49 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "Xing, Cedric" <cedric.xing@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>
CC: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] tsm: Add TVM Measurement Register support
Thread-Topic: [PATCH 1/4] tsm: Add TVM Measurement Register support
Thread-Index: AQHbfb5LZmaygLxduk2rGgH+KWhmWLNKpziAgACvLoA=
Date: Mon, 17 Feb 2025 10:44:49 +0000
Message-ID: <e9a0953921530a6ec058b8236e45d2f4217d9c0e.camel@intel.com>
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
	 <20250212-tdx-rtmr-v1-1-9795dc49e132@intel.com>
	 <828df2dd-a099-4146-96fe-0915cfa2e4b5@intel.com>
In-Reply-To: <828df2dd-a099-4146-96fe-0915cfa2e4b5@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CY8PR11MB7923:EE_
x-ms-office365-filtering-correlation-id: 8950afda-e558-47d8-d48c-08dd4f401a2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V29oNmNYRXBiN3ZTMzZ2SG95T0cvRWlKc1pTc0E3QXhBaFh1YUxjT1VBZWpJ?=
 =?utf-8?B?aFdML05LdVFUd0NHVzJtcXhsRHVka3F4clRsY08rY1VIU1JvMGZKVDd4NWFS?=
 =?utf-8?B?YkcyNzdzQjZNc1ZjNlNDUDJSa3ZsVmQxTGpyZ1Y2OUc4NnVqZ3pwOGJnK2k4?=
 =?utf-8?B?MWRrei9qOGJuM05XREtSU1dTMGhhSVF4dWlWWDNrMm5md0VaZ2x6SUptS2xZ?=
 =?utf-8?B?dURMaU9mNTY3eHYxdWtNYlNRN1dsd0c4OVdTaVVjQWNiZmRESThCQ0llVitD?=
 =?utf-8?B?NVNUVmRtWGZJejRqd09BK3l5YVVIdjRBWlI4d0hobmlMVFV6dmJmZVFaKzhK?=
 =?utf-8?B?alkxbzQ4WFNPQ29mbWt6SWt0dGtpczBDLzBpeWxYS2NXa2QrY2Y2dVRVeDFC?=
 =?utf-8?B?MFl0eVNLdDEyNms1dkR2OEtCVzZtZVh1dG5YOUIwZ2YxUWZhMkFjdm00WkxS?=
 =?utf-8?B?Q3NXcmoydHFaUVVJbEFjcWdOUUNhK3dyQzMzMC9RcTRiTUpZUGRNMGtrYXJM?=
 =?utf-8?B?Z1Q2T1djNjdxZU5hYVV2TExqUUdHTTNlK1piUVNhZkdyNGxLQUtWS2trUVlU?=
 =?utf-8?B?QjVia2hLdDR2amw4SUFicXZvdVhhS01DNDE1Qy95eHBoVTF0RXZnYytSMmxw?=
 =?utf-8?B?VTN0d3hHbjlreVlBQVIzRW82eUI2Q3RoaVI2Y0dMSjIyWEExUlBvNGk4S1FK?=
 =?utf-8?B?S2NWbmZZNGh0bFZUTFAwYm54SUcyN0FyY29NNjBnNWFFWUU4S0NyYjgwOFUz?=
 =?utf-8?B?SFFkUTFlUTU2R29KZGxFaWJUc1Z2QnY1d1grcEtRV1JRSUFDbHArMHVoTGpk?=
 =?utf-8?B?VC9saHVEdi90dnFlZ2hwOVFPUzBnTXlmN1JFcUdiVXRvSjl1b0RvQ3luYWIx?=
 =?utf-8?B?THNmZGJobzQwaUJheGVwUm1WZUVOZnlJcmV5Kzk4Um9iKzBCR3FjdUpvYlJW?=
 =?utf-8?B?M0kxY2dkQXdwSm9VaUVDdnNCa1VadmRpOUxTSExNRmFIS2twRmdNQWFLaDRz?=
 =?utf-8?B?bVM2cGJHdk9halNpSHRRNnZaWVVmaDQwRE53cktWQnVrTUxDYzIwaTM2MlpB?=
 =?utf-8?B?OE8vRmZ2NE0xN3o3ZGFjQTV0QXlhc3BMR2tkb01kUExrRVFIdkw3MWxwWlA4?=
 =?utf-8?B?NktoeGI0dFFtd0lEdk9kcFRYYW4vOHhGVkFUMi9lTXlIdHllYTJyVjllZDBq?=
 =?utf-8?B?Z3BBWlBWUUoyYmpuTmRpUjdTUkh6bDc5aUFUSWI5THppdDRzRnJsOGUxVzRw?=
 =?utf-8?B?NUl6blZyTDdMTmdWZnRrVmR4NEZ3VlhuSGM2SFVrc1E1MXhsb1lhVTBVR1VK?=
 =?utf-8?B?SVdOM3l5cTIrRk1HQ245UlJJU1lwSmxMcmIxVXc5RHVPNStvMS8vSUFBdlRO?=
 =?utf-8?B?NEFWTVJOVXF2Unk0T0svME1jTXkrdVlLZjVaQ1QwU2s0Z2JBeUxvOWt5YTQv?=
 =?utf-8?B?SmJ0OFAycGhWUXRQRU9XWG5USE5PMG84NzBzQ0VYSEtOVTY0eWh5SnhMRnF0?=
 =?utf-8?B?bkpXNlhFL2xSd1JOUy9HNUduRFRHWXQwV0NQTGZLTVliWXdxYzFENU9RZjhG?=
 =?utf-8?B?aDViRFNSdnBqZ1MwRXNjYWlJNVM1YTE0N1RxUE1ZVFY4NGtRU1pqYVlSY3dS?=
 =?utf-8?B?V24xVnlsU0lzeFVwUWlYUktOUFhXR3EwRmJ3TFcyMVJzaFp5eGJhU25BR1Ar?=
 =?utf-8?B?YXBIOGpiU2Zqc1A0YUlIZHYveEo1aVNSbTVEaFA3VGJjT2ZGTTJ5WHBKTUNN?=
 =?utf-8?B?anNoZTBsb0FtVEdwSjRXMExoSFdYRFpBc1hhUkk3bms0dUFGR1E1RExGckpZ?=
 =?utf-8?B?dHB2ZWhMNVJrbzhOcXUxNm5CdzdjN0lHM3RvMUpUcGhkVnM1dVc5L0w1d2xn?=
 =?utf-8?B?MWp5bkZwTnc0U0JVMWd6bE5RODlqdTRMYnZ3bnJsR1ZlOUt4dlVzUFNCMXR3?=
 =?utf-8?B?dU94OGVqWU1qdzBzbzRUTWp4eHpCd2xjMG1mODByenRqY3RiZ3ErL0ZSeXdz?=
 =?utf-8?B?UkVaclFVaUd3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWhyZHBvTG9md3dEdGIvQkV2TS9ST1JOekdua2ZsS1crUzdaUVZEcGFnb05R?=
 =?utf-8?B?WWgrUG5VVU4zRERlNWtoN3hiUnphNDMvVWRHNWw3YWdqVjRyYXV0Y091OEdO?=
 =?utf-8?B?RG5UZGdPZnN5Rm82QWNZR1ozZTJiQ2ZwRmg0Ui9HbkJYb1FUbmpKall0ZkpV?=
 =?utf-8?B?VS82QTExbkZqQUtuTTZXd3kxMzROZG11czZwbXNJU0hUZllhb0ViVFh1Vkg2?=
 =?utf-8?B?TlVSVVhRKzl1N09DZGJ2ekxpZjIzK20vc2NHbWR1M3RuSlB4WlE5aTB0YVdh?=
 =?utf-8?B?TUVjVEhab0tvMTN6MlUrNytVR0taaWtVOUNsbEkzcW5LWklLMit2QU9nb254?=
 =?utf-8?B?NUh4dUthV2RJRDNPdnE4Y2xNUDQ2djZSRXArVzMrcTUxRXlCSm1udTZQTFR3?=
 =?utf-8?B?RStRQjBwQkxXRmhYMHJrVWpVWElKVVk1N1ArcU5abE9LS2FhRjhHRkt0dCsy?=
 =?utf-8?B?OFBGYm96Z2lRdyszY01qN2pvTnVvcEkzdjhsUHQ5Q1ViVEFLRXVjMHUzekl6?=
 =?utf-8?B?d0RaSlZUOStXNjRNblNtRVlPdk1sbGl1TXJQMHNqNHF3NEw4U2FCUURLeUJB?=
 =?utf-8?B?VjJLaXlPZlZJYnpLMTRQSnp3dEJxTm1hR1U1M1NqV3JJWnFVUWt0THczanpB?=
 =?utf-8?B?VEZER1BVcFJXUk81TE0wM1VUaTZjTlN3UDBSREs1NlBMaXg3T0x0TWRIOTh1?=
 =?utf-8?B?QnVLMmJtamZpQTlVV0RFRE5yWnF5ZzIxSFI4STUwc2JWeTRNaE5oMXc5dFR2?=
 =?utf-8?B?aG5wanNFdjJNMzZlQk1BMHkrSXVsTlhYNFN5QURqV3FnSXQ2OXZreDZvQ0NN?=
 =?utf-8?B?L0JkaDljRnp4aHd2ZXRtVzdIcnI1bjNwUjhjRjFGZDMydGZQVzRaeVVjVFVM?=
 =?utf-8?B?SXRMc1pHT0xQRmdOcUJVZWswT1NFS3EvRTltYmZaSU1pYUJpMUlSL1ZFSGJK?=
 =?utf-8?B?bFhjZ2FJZ0hIQzFlOU1lMmtMeEd4Skh6MUZ6U1FycXBPbUxEZXlBV24rU0tR?=
 =?utf-8?B?YnVEa0NWWEIrVmNnZWFvaDloVGZPdDV6d1RqVVZvZi9wRVBKaVpzdHAxaVdw?=
 =?utf-8?B?aGV0dUVOcmxISXo3TGNETnBreDFVODlUZFZqYndacTkycFJucFpuSWE3bjU5?=
 =?utf-8?B?K0F6a0lLVHJEYm96MHdqT1FKQmdSZlhoUWo4NkNnMSs2SXBjNlhtcUV2a0pY?=
 =?utf-8?B?SjBTV2J1ckU0Tktaa0dHWXlFSG5XZm0wNU45b0QxTFZORFhhbzl1NXZrdy9o?=
 =?utf-8?B?TE9yTDQ0ay9pVjRYUmsrdlRLdmx4VFRBZ2lWb3N6OGxuTnVKVlZINFpaeUVv?=
 =?utf-8?B?U1RnbHY1U2l2V2E3TlovSHRYRVpsRSttbldEOGVSN2U5bWQ0dFRsM2ZSenUr?=
 =?utf-8?B?VUdVcVRBdXJSS3dRTTNWVkZMZHhpQ1RCMHMybFEvVWp2Y09NMjJqaE1LMzU1?=
 =?utf-8?B?bkRhZ2M1a0tNS0JYU21kSU83MVlZUkpuV1AzbGxHVjhIbWwxWG9LWC9hdHAy?=
 =?utf-8?B?eDV2OEJEQVBPS2FHQWgxbUtJM1ZtQ25YNWl3QTRXck5DOU85RmU2bWNCZm8v?=
 =?utf-8?B?dVFhaGVnMlFGVVBFUHM2bG5oWCt4K3Y5aVdVM3lEYzN3UEtjM1BOUWRDRlJ1?=
 =?utf-8?B?ZkZFY0RXRjArVVdSalhkQWZzeFY0TGZuanJEdGk3dVdXeGxkcCtsdE1rLzNw?=
 =?utf-8?B?bGlFb2ZIaFpRTWs5SjNMREEzZEZlUmo0OENvaEs2QzBGT1VTVjVXZGFabzRI?=
 =?utf-8?B?VXQ2VXBoeW9aS01TNFA1d0lKVUxCNGZ4UVltMWFLaDMzYjFBeVpZa0xyaWtz?=
 =?utf-8?B?MGl6d1hQVGQrWktZNitQRkVYWDBySUtVbHN1Z29seVlsN3djcW8raGpGYVJV?=
 =?utf-8?B?VGFaR3lPMzZLZTVWWTZUV05ESHZXRG9HSS9CUXBwRi9tR3Z2ZTZldGUxczJo?=
 =?utf-8?B?Mm45bUovZjV0NUo1bjFYOU9sQ3VNSU1QMjFVVmF0RGhtSk8zWlozVEpYdU53?=
 =?utf-8?B?VzV0ZkRNMHFtejVRam9aVnBudllycEZ6b2szazZlNkw1OFRlTTFKTDBPaWlV?=
 =?utf-8?B?dmNhU2w4STBkdTBTc0VybzMrNnVEYWppNEQ1ckUzZ0tVaHRWcm5PRmlibUpi?=
 =?utf-8?Q?8ORdOaLi0PWf6k70Up75tAu6I?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2906FDEB7E648D4392D864D7F4E2FBD6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8950afda-e558-47d8-d48c-08dd4f401a2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 10:44:49.1697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4rbJGDk03OR3lyd2U7UOrYzlur9eih3pqDpc3ZRHKd1hU5tM+Tf4ubkBi94q6iQBwpsL0RFPBKbb1KCEN2eHNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7923
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTAyLTE3IGF0IDEzOjE3ICsxMzAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBI
aSBDZWRyaWMsDQo+IA0KPiBbLi4uXQ0KPiANCj4gPiArc3RhdGljIHNzaXplX3QgdG1yX2RpZ2Vz
dF9yZWFkKHN0cnVjdCBmaWxlICpmaWxwLCBzdHJ1Y3Qga29iamVjdCAqa29iaiwgc3RydWN0IGJp
bl9hdHRyaWJ1dGUgKmF0dHIsDQo+ID4gKwkJCSAgICAgICBjaGFyICpwYWdlLCBsb2ZmX3Qgb2Zm
LCBzaXplX3QgY291bnQpDQo+IA0KPiBCZXR0ZXIgdG8gcmVuYW1lICdwYWdlJyB0byAnYnVmZmVy
Jz8NCj4gDQo+IFNpbmNlIHBhZ2Ugbm9ybWFsbHkgaW1wbGllcyA0S0IgYWxpZ25tZW50IGJ1dCBJ
IGRvbid0IHNlZSB3ZSBuZWVkIHRoZSANCj4gYWxpZ25tZW50IGhlcmUuDQo+IA0KPiA+ICt7DQo+
ID4gKwljb25zdCBzdHJ1Y3QgdHNtX21lYXN1cmVtZW50X3JlZ2lzdGVyICptcjsNCj4gPiArCXN0
cnVjdCB0bXJfcHJvdmlkZXIgKnB2ZDsNCj4gPiArCWludCByYzsNCj4gPiArDQo+ID4gKwlpZiAo
b2ZmIDwgMCB8fCBvZmYgPiBhdHRyLT5zaXplKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+
ICsNCj4gPiArCWNvdW50ID0gbWluKGNvdW50LCBhdHRyLT5zaXplIC0gKHNpemVfdClvZmYpOw0K
PiA+ICsJaWYgKCFjb3VudCkNCj4gPiArCQlyZXR1cm4gY291bnQ7DQo+ID4gKw0KPiA+ICsJbXIg
PSAodHlwZW9mKG1yKSlhdHRyLT5wcml2YXRlOw0KPiA+ICsJcHZkID0gdG1yX21yX3RvX3Byb3Zp
ZGVyKG1yLCBrb2JqKTsNCj4gPiArCXJjID0gZG93bl9yZWFkX2ludGVycnVwdGlibGUoJnB2ZC0+
cndzZW0pOw0KPiA+ICsJaWYgKHJjKQ0KPiA+ICsJCXJldHVybiByYzsNCj4gPiArDQo+ID4gKwlp
ZiAoKG1yLT5tcl9mbGFncyAmIFRTTV9NUl9GX0wpICYmICFwdmQtPmluX3N5bmMpIHsNCj4gPiAr
CQl1cF9yZWFkKCZwdmQtPnJ3c2VtKTsNCj4gPiArDQo+ID4gKwkJcmMgPSBkb3duX3dyaXRlX2tp
bGxhYmxlKCZwdmQtPnJ3c2VtKTsNCj4gPiArCQlpZiAocmMpDQo+ID4gKwkJCXJldHVybiByYzsN
Cj4gPiArDQo+ID4gKwkJaWYgKCFwdmQtPmluX3N5bmMpIHsNCj4gPiArCQkJcmMgPSB0bXJfY2Fs
bF9yZWZyZXNoKHB2ZCwgbXIpOw0KPiA+ICsJCQlwdmQtPmluX3N5bmMgPSAhcmM7DQo+ID4gKwkJ
fQ0KPiA+ICsNCj4gPiArCQlkb3duZ3JhZGVfd3JpdGUoJnB2ZC0+cndzZW0pOw0KPiA+ICsJfQ0K
PiA+ICsNCj4gPiArCWlmICghcmMpDQo+ID4gKwkJbWVtY3B5KHBhZ2UsIG1yLT5tcl92YWx1ZSAr
IG9mZiwgY291bnQpOw0KPiA+ICsNCj4gPiArCXVwX3JlYWQoJnB2ZC0+cndzZW0pOw0KPiA+ICsJ
cmV0dXJuIHJjID86IGNvdW50Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3NpemVfdCB0
bXJfZGlnZXN0X3dyaXRlKHN0cnVjdCBmaWxlICpmaWxwLCBzdHJ1Y3Qga29iamVjdCAqa29iaiwg
c3RydWN0IGJpbl9hdHRyaWJ1dGUgKmF0dHIsDQo+ID4gKwkJCQljaGFyICpwYWdlLCBsb2ZmX3Qg
b2ZmLCBzaXplX3QgY291bnQpDQo+ID4gK3sNCj4gPiArCWNvbnN0IHN0cnVjdCB0c21fbWVhc3Vy
ZW1lbnRfcmVnaXN0ZXIgKm1yOw0KPiA+ICsJc3RydWN0IHRtcl9wcm92aWRlciAqcHZkOw0KPiA+
ICsJc3NpemVfdCByYzsNCj4gPiArDQo+ID4gKwlpZiAob2ZmICE9IDAgfHwgY291bnQgIT0gYXR0
ci0+c2l6ZSkNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKwltciA9ICh0eXBl
b2YobXIpKWF0dHItPnByaXZhdGU7DQo+ID4gKwlwdmQgPSB0bXJfbXJfdG9fcHJvdmlkZXIobXIs
IGtvYmopOw0KPiA+ICsJcmMgPSBkb3duX3dyaXRlX2tpbGxhYmxlKCZwdmQtPnJ3c2VtKTsNCj4g
PiArCWlmIChyYykNCj4gPiArCQlyZXR1cm4gcmM7DQo+ID4gKw0KPiA+ICsJaWYgKG1yLT5tcl9m
bGFncyAmIFRTTV9NUl9GX1gpDQo+ID4gKwkJcmMgPSB0bXJfY2FsbF9leHRlbmQocHZkLCBtciwg
cGFnZSk7DQo+ID4gKwllbHNlDQo+ID4gKwkJbWVtY3B5KG1yLT5tcl92YWx1ZSwgcGFnZSwgY291
bnQpOw0KPiA+ICsNCj4gPiArCWlmICghcmMpDQo+ID4gKwkJcHZkLT5pbl9zeW5jID0gZmFsc2U7
DQo+ID4gKw0KPiA+ICsJdXBfd3JpdGUoJnB2ZC0+cndzZW0pOw0KPiA+ICsJcmV0dXJuIHJjID86
IGNvdW50Ow0KPiA+ICt9DQo+IA0KPiBUaGUgbG9naWMgYXJvdW5kIHVzaW5nIHB2ZC0+aW5fc3lu
YyBpcyBraW5kYSBjb21wbGljYXRlZC4gIE1SIG9wZXJhdGlvbnMgDQo+IHNlZW0gbGlrZSBhIGNs
YXNzaWMgcmVhZGVyL3dyaXRlciBjb250ZW50aW9uIHByb2JsZW0gYW5kIEkgYW0gbm90IHN1cmUg
DQo+IHdoeSBwdmQtPmluX3N5bmMgaXMgbmVlZGVkLiAgQ291bGQgeW91IGhlbHAgdG8gY2xhcmlm
eT8NCj4gDQo+IFsuLi5dDQoNClsuLi5dDQoNCj4gPiANCj4gPiArI2RlZmluZSBUU01fTVJfKG1y
LCBoYXNoKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXA0KPiA+ICsJLm1yX25hbWUgPSAjbXIsIC5tcl9zaXplID0gaGFzaCMjX0RJR0VT
VF9TSVpFLCAubXJfaGFzaCA9IEhBU0hfQUxHT18jI2hhc2gsIFwNCj4gPiArCS5tcl9mbGFncyA9
IFRTTV9NUl9GX1INCj4gPiArDQo+ID4gKy8qKg0KPiA+ICsgKiBzdHJ1Y3QgdHNtX21lYXN1cmVt
ZW50IC0gZGVmaW5lIENDIHNwZWNpZmljIE1ScyBhbmQgbWV0aG9kcyBmb3IgdXBkYXRpbmcgdGhl
bQ0KPiA+ICsgKiBAbmFtZTogbmFtZSBvZiB0aGUgbWVhc3VyZW1lbnQgcHJvdmlkZXINCj4gPiAr
ICogQG1yczogYXJyYXkgb2YgTVIgZGVmaW5pdGlvbnMgZW5kaW5nIHdpdGggbXJfbmFtZSBzZXQg
dG8gJU5VTEwNCj4gPiArICogQHJlZnJlc2g6IGludm9rZWQgdG8gdXBkYXRlIHRoZSBzcGVjaWZp
ZWQgTVINCj4gPiArICogQGV4dGVuZDogaW52b2tlZCB0byBleHRlbmQgdGhlIHNwZWNpZmllZCBN
UiB3aXRoIG1yX3NpemUgYnl0ZXMNCj4gPiArICovDQo+ID4gK3N0cnVjdCB0c21fbWVhc3VyZW1l
bnQgew0KPiA+ICsJY29uc3QgY2hhciAqbmFtZTsNCj4gPiArCWNvbnN0IHN0cnVjdCB0c21fbWVh
c3VyZW1lbnRfcmVnaXN0ZXIgKm1yczsNCj4gPiArCWludCAoKnJlZnJlc2gpKHN0cnVjdCB0c21f
bWVhc3VyZW1lbnQgKnRtciwgY29uc3Qgc3RydWN0IHRzbV9tZWFzdXJlbWVudF9yZWdpc3RlciAq
bXIpOw0KPiA+ICsJaW50ICgqZXh0ZW5kKShzdHJ1Y3QgdHNtX21lYXN1cmVtZW50ICp0bXIsIGNv
bnN0IHN0cnVjdCB0c21fbWVhc3VyZW1lbnRfcmVnaXN0ZXIgKm1yLA0KPiA+ICsJCSAgICAgIGNv
bnN0IHU4ICpkYXRhKTsNCj4gPiArfTsNCj4gDQo+ICBGcm9tIHRoZSBkZXNjcmlwdGlvbiBhYm92
ZSwgSSBkb24ndCBxdWl0ZSBmb2xsb3cgd2hhdCBkb2VzIC0+cmVmcmVzaCgpIA0KPiBkbyBleGFj
dGx5LiAgQ291bGQgeW91IGNsYXJpZnkgd2h5IHdlIG5lZWQgaXQ/DQo+IA0KDQpBZnRlciByZWFk
aW5nIHBhdGNoIDQsIEkgZmlndXJlZCBvdXQgdGhlIHB1cnBvc2Ugb2YgdGhlIHB2ZC0+aW5fc3lu
YyBhbmQgdGhlDQpyZWZyZXNoKCkgbXlzZWxmOg0KDQpFYWNoIGNhbGwgb2YgLT5leHRlbmQoKSB3
aWxsIHVwZGF0ZSB0aGUgdmFsdWUgb2YgdGhlIE1SLCBidXQgb25seSBpbiB0aGUNCmhhcmR3YXJl
L2Zpcm13YXJlLiAgVGhlIE1SIHZhbHVlIG1haW50YWluZWQgYnkgdGhlIGtlcm5lbCBpcyB1bmNo
YW5nZWQgc28gaXQNCndpbGwgYmUgb3V0LW9mLWRhdGUgYWZ0ZXIgdGhlIC0+ZXh0ZW5kKCkuICBU
aGVyZWZvcmUgdGhlIGtlcm5lbCBuZWVkcyB0byBrZWVwDQp0aGVtIHN5bmNlZCBmaXJzdCB3aGVu
IHVzZXJzcGFjZSByZWFkcyB0aGUgTVIsIHVzaW5nIHRoZSAtPnJlZnJlc2goKS4NCg0KSXQncyBh
bHNvIGZlYXNpYmxlIHRvIGFsd2F5cyBzeW5jL3JlZnJlc2ggYWZ0ZXIgZWFjaCBleHRlbmQoKSwg
ZWxpbWluYXRpbmcgdGhlDQpwdmQtPmluX3N5bmMgbG9naWMgY29tcGxldGVseSwgYnV0IGl0J3Mg
bm90IGRlc2lyZWQgLS0gYmVjYXVzZSB0aGUgc3luYw0Kb3BlcmF0aW9uIHRhbGtzIHRvIHRoZSBo
YXJkd2FyZS9maXJtd2FyZSB0aHVzIGNvdWxkIGJlIHRpbWUtY29uc3VtaW5nLCBhbmQgd2UgaW4N
CmdlbmVyYWwgb25seSBuZWVkcyB0byBzeW5jIGJlZm9yZSByZWFkaW5nIHRoZSB2YWx1ZSB0byB0
aGUgdXNlcnNwYWNlLiAgRS5nLiwNCnRoaXMgc2F2ZXMgYSBsb3Qgb2Ygc3luYyBvcGVyYXRpb24g
aWYgdXNlcnNwYWNlIGV4dGVuZHMgdGhlIE1SIG11bHRpLXRpbWVzIHdpdGgNCmxhcmdlIGNodW5r
IG9mIGRhdGEgYW5kIHRoZW4gcmVhZHMgdGhlIGZpbmFsIHZhbHVlIG9uY2UuDQoNClNvIHRoZSBw
dmQtPmluX3N5bmMgbG9naWMgc2VlbXMgdXNlZnVsIHRvIG1lLCBidXQgSSB0aGluayBpdCB3b3Vs
ZCBiZSBiZXR0ZXIgdG8NCmEgY29tbWVudCB0byBleHBsYWluIHRoaXMgaW4gYm90aCB0bXJfZGln
ZXN0X3JlYWQoKSBhbmQgdG1yX2RpZ2VzdF93cml0ZSgpLiANCkUuZy4sIHNvbWV0aGluZyBsaWtl
IGJlbG93IGJlZm9yZSB0aGUgY29kZSB3aGljaCBjaGVja3MgcHZkLT5pbl9zeW5jIGluIHRoZQ0K
dG1yX2RpZ2VzdF9yZWFkKCk/DQoNCgkvKg0KCSAqIEVhY2ggd3JpdGUtYW5kLWV4dGVuZCB0byB0
aGUgTVIgd2lsbCB1cGRhdGUgdGhlIE1SLCBidXQgb25seSBpbg0KCSAqIFRTTSBoYXJkd2FyZS9m
aXJtd2FyZSwgbGVhdmluZyB0aGUgTVIgdmFsdWUgbWFpbnRhaW5lZCBieSB0aGUga2VybmVsDQoJ
ICogb3V0LW9mLWRhdGUuICBTeW5jIE1SIHZhbHVlIGluIFRTTSBoYXJkd2FyZS9maXJtd2FyZSB0
byB0aGUga2VybmVswqANCgkgKiBiZWZvcmUgcmV0dXJuaW5nIHRvIHRoZSB1c2Vyc3BhY2UgaW4g
dGhpcyBjYXNlLg0KCSAqLw0KCWlmICgobXItPm1yX2ZsYWdzICYgVFNNX01SX0ZfTCkgJiYgIXB2
ZC0+aW5fc3luYykgew0KCQkuLi4NCg0KVGhlIGRlc2NyaXB0aW9uIG9mIHRoZSByZWZyZXNoKCkg
Y2FsbGJhY2sgaXMgYWxzbyBub3QgY2xlYXIgdG8gbWUuICBQZXJoYXBzDQpzb21ldGhpbmcgbGlr
ZSBiZWxvdz8NCg0KCS8qDQoJICogLi4uDQoJICogQHJlZnJlc2g6IHN5bmMgTVIgdmFsdWUgaW4g
VFNNIGhhcmR3YXJlL2Zpcm13YXJlIHRvIHRoZSBrZXJuZWwNCmJ1ZmZlcg0KCSAqIC4uLg0KCSAq
Lw0KDQoJDQoJICAgDQo=


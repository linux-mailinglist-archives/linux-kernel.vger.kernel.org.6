Return-Path: <linux-kernel+bounces-190026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA528CF888
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30AD1C210D9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 04:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B764FDF44;
	Mon, 27 May 2024 04:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DzcLiLTm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EFFC152;
	Mon, 27 May 2024 04:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716785321; cv=fail; b=MP9e4nS0ygrMFeD7BNTrqq74GSrbuSRtlqP2vHkp+Sn87vBD1jjacpCHG/3vCZS4vLeweD/LEqugZcxwxntTQewdahlc1snbnXjJd67udNfKFW/OqKRL9/fXzGfxWUs/O6Q05a2sAaboYTuwVH8OCwZk2vTt9SZ1OGxuRjBWa2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716785321; c=relaxed/simple;
	bh=2g5AvC2JoI7VfFiOkjBD1JFQq3uX9wdYiOpou2i6aTs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=anSqQ2PI44IeSMrbTdSdnNEm6mJCvpYDEu1OFGKINwA5bDPvdTF71ON2pnhagYTd8Yw1gWvEqOSe58EsFMw8YN5CNWeAgzjn8WR0ACkn/+nido5daiJD6kk3Dito9JcbhqMmK/eAeDias19x/a9e+vR0XqLQzIdqE9Okwe7aCZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DzcLiLTm; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716785319; x=1748321319;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2g5AvC2JoI7VfFiOkjBD1JFQq3uX9wdYiOpou2i6aTs=;
  b=DzcLiLTmzkqqO6fV0Uwu6Wcps22qScSyGEVTQHnxfkW8cAaT6rD6AEPq
   oG1dNZ/mAU78VKWnnHydCiowhp3G8HMBjZpNxnaQwnDlEVEXZndRJ3gqt
   25bpbtS8Za8brX3atq/ATLTZ5Opu2urPTX+H9pFUxN3gw3P0bsDbNbsjL
   5D7uxqZTBXI94/BCBBq0KUtbtYseaErvTmDyC39khrvNNoCqGDCe+woKq
   0vk6Xx4umLmj2fcGtsQZCD2Rc8UaCHAH0qZOZoWcrTIhadH1OUCnKbl8J
   AMX3qaQuDXrprelkPAmJR5D9EDgwlk1QV4BWuiTBUxqtCZ9QqKE+e6R3L
   Q==;
X-CSE-ConnectionGUID: c7qAaEn/R1WD6mAetxvf0w==
X-CSE-MsgGUID: xpwN0wVOREC7h4iWN8p4Yw==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13201967"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="13201967"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 21:48:39 -0700
X-CSE-ConnectionGUID: 5eiwbc3pSkm/E93DVwCeBw==
X-CSE-MsgGUID: gkDYEqKRTvS/RIG4Qe4N8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="34720250"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 May 2024 21:48:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 21:48:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 26 May 2024 21:48:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 26 May 2024 21:48:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDamiQCiVfNeejzOBwIN5yixwCdFdPpujgK7lMRHBM9ZCD5GLd+dl2j8CPBAH8bPFjIecsyHGQ0G1dzqaG2Z7SZTWGiuamf6Z7/DAFZ+mQo3nt4BSIT48JnA9abv+yJVMmzTJ5JXrN7L+78SgjuMzDv7b91t2YI+07pLdO03IOsWmlo+0AoyAtlbLIEhaqlvV2f1v//E9AChUWdCVM9AVzdsFVFh4XZuy7wa03/d5+wH340hMoLVS3Nl2tGQan3E25y1uQrjxOZUiGFM7GLi04zlY8oiJfF0zLa54dXuNb4n0w5WyKun2SDLG67dgovHouAtGt12fKjO7K9C9Q74Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2g5AvC2JoI7VfFiOkjBD1JFQq3uX9wdYiOpou2i6aTs=;
 b=icJjlqMN4gOmeJnt5qAq9JoFCVkDKy6QeFrY28mq02RCd8uwHgvAwMK746vGbFlCJXSxsfYmE/pzYKR1xFf5mg2tBgpQh/HCt8hTio7kRFthiFl965Q0geDoamJfTKaP+dGzMuuOgY4iCpGF0IexAPQsaJZkHtOTFer4HInBYYEj/MtCm1d7aIenxKsduimnUyLXGv3OtCZiJ9JO/Dl4R0rEAeE+GdT+Xb0vbO/XlkIkjrxR2xmSWct69vqrwEkY1vApfnmSBLHPQ1Fwb+uS0d6pfyEQvB94XGvrx4BfCzwxwVs0ZUmIR7hx8GRuWA0kptpVvGxceU8yBJX+ar19tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by PH8PR11MB8287.namprd11.prod.outlook.com (2603:10b6:510:1c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Mon, 27 May
 2024 04:48:35 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 04:48:35 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, Kan
 Liang <kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v9 4/7] perf stat: Plugin retire_lat value from
 sampled data to evsel
Thread-Topic: [RFC PATCH v9 4/7] perf stat: Plugin retire_lat value from
 sampled data to evsel
Thread-Index: AQHaq6XqeAzJWhj1iUuPm3r3rsuQorGnCbGAgAAIESCAAsR1gIAAstmA
Date: Mon, 27 May 2024 04:48:35 +0000
Message-ID: <CO6PR11MB56354541D05AF770C79837B4EEF02@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240521173952.3397644-1-weilin.wang@intel.com>
 <20240521173952.3397644-5-weilin.wang@intel.com>
 <CAM9d7cjob_tfgN+rMRrh=0SV56+z32CmP34BRY1eoFv48RVocg@mail.gmail.com>
 <CO6PR11MB563589ED3FC7126A6B27EB22EEF52@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7cjz0P=vrSr8yU=xMYhQ5XFT9A+K-WG9E+LyNzYWC-JhwA@mail.gmail.com>
In-Reply-To: <CAM9d7cjz0P=vrSr8yU=xMYhQ5XFT9A+K-WG9E+LyNzYWC-JhwA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|PH8PR11MB8287:EE_
x-ms-office365-filtering-correlation-id: 81a2f047-994d-4caf-cd0c-08dc7e084495
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?L2pnNldZMkNnVGtadThPS3VPTGdlaEczdmtGbnpKZmpyaUpsbElrUFpVTzhu?=
 =?utf-8?B?MFA3Y1BrRmh5ekRrUHkrN0s0b2d5Q2taajZ1Q3pyUVltam9VWUN6aEowOFRl?=
 =?utf-8?B?K2VZZGRiaEhuWHdXR0dLMkFodUdLMlZEZ1BRTktvVitvNmdGRC9ua0NLUTJh?=
 =?utf-8?B?UlNrbEZ1ODAwN0lFU0E0MWVuVXVjVXk3T1dqV3JxN3JFRkNYZktPSy9Ya0hY?=
 =?utf-8?B?cHZFTmgxNGRMNW1IejY3REU2bUdqSFRZR1RJcXBMd0o2VmZSbVQ5RlhqMXJa?=
 =?utf-8?B?SmNwVS9iWDJmSTU3cW1TWlZEN05NZ1hwRk9SanJGd1Vna0Vrek1oaDBEZy8z?=
 =?utf-8?B?NUtJT2R1ai92dXhBMXIraUtzNS9Ra1BENkZHdGRFY2dmRFZSWkdVbk83MkpZ?=
 =?utf-8?B?RldEVXp4UGUvdytuVG91c2pDWDB5alZNeTVtTCsxUGxSb3ltemkyaTBJeTJt?=
 =?utf-8?B?SEpHVTl4U3d3RWxqcFI5NHNhWENtVjhYcnVjeEg1c0NzYVZxVVVoOS9ENjJM?=
 =?utf-8?B?NzR3NXpzb0JhVkdQMktMekRXWTBMUjBVMktxVHlNN3Z6enMyczdncGcxRndK?=
 =?utf-8?B?eENKZUVITmxQOXFOT2VPVHlHMmlSVStMcU9MRitZY3V3bUgwRlF2WEZKNW5Q?=
 =?utf-8?B?VU9TZDNBYUdsSmF4NXE2N0dPaXIvY3VmeW1rOHRYMzgwTDkyNmIwUnVwWDNj?=
 =?utf-8?B?bW93VnE5WFdDbWs4b0dEUnhOb2dGeVZJTllTUnFrbWxZR25JSmt1bWFaOG9S?=
 =?utf-8?B?MUVZeHNEQ29yNGNFYmtVWDIyV2VnWDF6QUcrZ3VSeERQRFhlRWpYVVMreG5E?=
 =?utf-8?B?VnFXSWtMNEw0anhOODhLeHN4UVFLUG9LV2NNSTZ1NDFXODVnbWpFVnp0V3Zx?=
 =?utf-8?B?STY3VVBNTkJWcThUZ0hhaWx4YlY1TjI1MWhlRzJQQ3g1TW9aeGg3NVR1ZjF5?=
 =?utf-8?B?YmFLQ0xsR2dic3B4dWdDVmVHejQvbWppaEwyVEI1cXBmUjQrRndzQzJrdzdW?=
 =?utf-8?B?ZXJCMUxSOWo0Mm1XclFmMnZOeHlHaTUxaDZDYmlKbmFUTC96bENRTUxyZVNJ?=
 =?utf-8?B?UHlVLzRLWGxnU0VNeVdwdmZqbDEvK0tlUEx1d2tyLzdIMTZQdzg4djd0elhY?=
 =?utf-8?B?VUhFVnRHdkthN1RIbVJBaTVySC9sanFjWnJRNTc5TTk3R2xDeS8zQnFMcEFx?=
 =?utf-8?B?aW52R1Jld29VNnNyeC9nc0Q3dVZCRDJTQjRVdmRLVHlDK2hCUzNsT1o3SWdk?=
 =?utf-8?B?V2hYYTB0NmtzYXFQdVpPaVZEclk3REttSUI0aXBidHdYWTZiL3VmVHgvc2RY?=
 =?utf-8?B?OEVkQTZ6V1ZMdVRVOUI5dDh4NkN3dWUzNUl0L294dXJ6TmFRTGdIWVhONzlD?=
 =?utf-8?B?YzBBT2Y1c1pSRTE3K2IralZPeEpHY1dFdS9KUGhqL243eW51cndhUDlUTGg4?=
 =?utf-8?B?U21DdkRTeVNnSk9ETU1XNERSd29hTk0wTTBuL2F4bzZhc2U5bUdlYnNMdEZM?=
 =?utf-8?B?cG1TQlNXWkhwaWdwbTRpUTIzNTVIdmNrUUNoM0c2cmRoM2hvbXdIR3ZsTHQz?=
 =?utf-8?B?RzR4NG1MdkFBd1pscDJPZFp2RGQrTkJBcy95Ri9XZ0FaV2kvZEI5VUdVQzll?=
 =?utf-8?B?bnZpYm0rSWl4akxTdFU0eDY2VmR6N0lQeUJxY0crYnoxRkhuZW1zREhJZmgy?=
 =?utf-8?B?QXdMMEY1c1ByZ3d6STJIdnM4aVJ2Zm9XTisxQmx0a0JQdUUwNEhwQWxPMHJx?=
 =?utf-8?B?dHhSd0FjRkpobDE1ZTF3aUFCc3BZNW12UUZPU0dVcS9rS0lvb2Y4di9XYWl6?=
 =?utf-8?B?Z3ppRnFXNTQ3eExQNDFMUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3Bzd2NNTnZMMGNMaEw0QXEvWkxtckl3WnJRbitmNzc2Qy9ka25RcWdYZkRV?=
 =?utf-8?B?c3JFUXIrc3FiT3BTcms2Yk1USkxBOFRqdnFNMzJheGJvNkVzNGtGbzNCVVRy?=
 =?utf-8?B?UWN5czlLV1ZJSjRVaGJBMEJjcVo5ZVRmOHlRRlJ2UXhQQ1BjQ292amJvdlFC?=
 =?utf-8?B?MURhRTFrY3FoVkIyc213TTVFcGZPVmhEQTBmWG9wRy9nTnZtazJWamhNZlht?=
 =?utf-8?B?ZlNZZVhvd1JuYTRFK2Q3bWgzMUtBbGJYSlNENDVRa09OdGwxMm5pSlBEMFNG?=
 =?utf-8?B?V3ZDM1VIaUJncFkvNE9rZ3BNRzg0WkdtMUhiUDNpWFJ5Y0ZjQkE5KzB5b2Zq?=
 =?utf-8?B?L0t0ZVRVVGxwRmViVnowbWJhS3lQdXErOHpRWnRRemprN2gzU3NUa1VKZno2?=
 =?utf-8?B?YWk0TG1QZ3Y0dVZLK240S0hkaDc5VktzcVFCQmdnQkQxc3g5SnlrM0lLckNr?=
 =?utf-8?B?UXByM3JWSStPaGhEMkQzN05SLy9pMkNpRFcvNmxZbzdVTlp3dzFabWtyOTlP?=
 =?utf-8?B?OHhXNU1rTmpWQWRjb0pCMmtwTFZGNUlNakJyQXAwbUo1V1JCWW1oWlRqZWZB?=
 =?utf-8?B?RnFXS0haTWF2TXp2UFNDZHdKd0hSSlJiS1pVQ0o0K01qMUtkNDRwT2JTM2NJ?=
 =?utf-8?B?NTFKZWUyNkIyOFl6V0pFRzdKVzVja1BhR3lodmtPUy9MRFIxYk9TM0QydE1a?=
 =?utf-8?B?OXR0RUdEVjJrUXladU53UmYzejBreXo3SEdXOGpxZ2VnUUZaTjNqVU45Kzdl?=
 =?utf-8?B?QXpvTkRVOWJkcEFqdEt2WWV2UlROcHlTUmxQd1JCd3o3MTc4NTJHUHdib090?=
 =?utf-8?B?a0JMWjFpeXBBT3VqZVdpWDd4OHc5dTdkUStYS2J2QUk0QUJwMFYyRjB0VVE5?=
 =?utf-8?B?aVQwWDBObGRVUUQ4VDBkY2VBcHozbUFrWUEzcjNqQTJmV29JS3JCWE1tcHRt?=
 =?utf-8?B?RSt6N1RYNkRMRUJ6R21EZVhDYkpVOXZlRFlwRk9uWlFXczk2M2ZLd1lHekNH?=
 =?utf-8?B?bERENVloWlpmNmEzb2Eyc0hPUlNqRi8wS1pQYldRazBzY1FkOGZ5MzJXbkp1?=
 =?utf-8?B?VXh5clhPWGI0UDNVQkVpSHQwWTFiZ0hjOFUxZTRBR3JnVjI2VFgybEYwd3Ir?=
 =?utf-8?B?bXFNSzVZVkRSRGUrOFBnaFRjaDRFQk9LV2wxNGd5clRWbWNRK1RudWxPMjBB?=
 =?utf-8?B?OTI5WGZmVGNvQWFHRWU4c0lpT0R4UHlOVUxnN3ArbmhWbUNNYTc3M3FiTlVB?=
 =?utf-8?B?dHdDSXBhVzNOWG9ST0dnWTNmeWZqZHJUTDZhUXliNTQweW9YNjUyNmd4bkVI?=
 =?utf-8?B?dEpxSFFjN3p5V1RDUDRBcW5NTEdKRnkxZ2d4N0c0NHZpalRTcW1vV0hJMmVv?=
 =?utf-8?B?bGhmZWVyQnFBOGR2cFNZczRqaU8rYzVmZ3dicnMvcHRaSVlYank1aHJsVUZx?=
 =?utf-8?B?ckdCQWpCZHJ1MC8rTmNiZHNESGV4T2JaMzJkVkVUZGpQZDA2ZFUxRWhZZ0E1?=
 =?utf-8?B?aGNwQ29WN05pb2Vnd0c2dVpqb21nS2Exa3cydjlycXRVY2tqRTNpNWlSeDM3?=
 =?utf-8?B?c0pmK3Y4dHNjWFdqUGV0c3NFSnpIeGxKSEsyZW5hUm16bFpraWl4MU5TRkdu?=
 =?utf-8?B?YmNnaDNyZzRMcEJYRitDK0pUS2dpRk4vTTdwcFNvcW05ZGlaWk1ER1dicWtH?=
 =?utf-8?B?TFVsZlFCalRxbmxyQUx4NDNZQS81ZFRPR25Ib01WTUwxZDhOcUtZOWNhY2hq?=
 =?utf-8?B?cHVFcVNpdVdzNHNtWkcyMmlpeVRCQjgxZVlmejFkM0pNblYxY2krQVBpUXhm?=
 =?utf-8?B?Q2R6eVhzTkJXcm8wQjBQQ2JZd2thMHBGQU5LSHQ4UVFvcW5xdlp0NW9JMkJX?=
 =?utf-8?B?QTQ4YkJyMEJ5elNjM1lCRU9ESjMxUzdrNnpoa1JMMVRneHhsOTE2bmY4ZGdu?=
 =?utf-8?B?U01NYmRHSU9hdGMwcHZzKzExRi9ubGZSdWw1Tjl6OGYzS0ZQTTc3Y2FZVWtu?=
 =?utf-8?B?ZWU5YmhBRWNBMFE5Tmk5REZFQ3RKUEVCWjJoTUtsamtwWmRoWGY4MGJmZEYr?=
 =?utf-8?B?V0V1WDN3WkllVExwbEttekJpSGNnZzFhRG5MYzY2SkU1WkI0YXYrRk9VcG5S?=
 =?utf-8?Q?fdPARo271XQ7izXfFY37vCQwm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a2f047-994d-4caf-cd0c-08dc7e084495
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 04:48:35.4662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gLsHiUfU4AJmtK15udlcceQ9qxXotTf4xqLw4kXY7yrPTEXXtLlMPEr7qYmewux9A73NjwUQhV5uSN4IRwZiDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8287
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBTdW5kYXksIE1heSAyNiwgMjAyNCAxMTowMiBB
TQ0KPiBUbzogV2FuZywgV2VpbGluIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+DQo+IENjOiBJYW4g
Um9nZXJzIDxpcm9nZXJzQGdvb2dsZS5jb20+OyBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8NCj4g
PGFjbWVAa2VybmVsLm9yZz47IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47
IEluZ28gTW9sbmFyDQo+IDxtaW5nb0ByZWRoYXQuY29tPjsgQWxleGFuZGVyIFNoaXNoa2luDQo+
IDxhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tPjsgSmlyaSBPbHNhIDxqb2xzYUBr
ZXJuZWwub3JnPjsgSHVudGVyLA0KPiBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsg
S2FuIExpYW5nIDxrYW4ubGlhbmdAbGludXguaW50ZWwuY29tPjsNCj4gbGludXgtcGVyZi11c2Vy
c0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFRheWxvciwg
UGVycnkNCj4gPHBlcnJ5LnRheWxvckBpbnRlbC5jb20+OyBBbHQsIFNhbWFudGhhIDxzYW1hbnRo
YS5hbHRAaW50ZWwuY29tPjsgQmlnZ2VycywNCj4gQ2FsZWIgPGNhbGViLmJpZ2dlcnNAaW50ZWwu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2OSA0LzddIHBlcmYgc3RhdDogUGx1Z2lu
IHJldGlyZV9sYXQgdmFsdWUgZnJvbSBzYW1wbGVkDQo+IGRhdGEgdG8gZXZzZWwNCj4gDQo+IE9u
IEZyaSwgTWF5IDI0LCAyMDI0IGF0IDQ6NTLigK9QTSBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5n
QGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogTmFtaHl1bmcgS2ltIDxuYW1oeXVuZ0BrZXJuZWwu
b3JnPg0KPiA+ID4gU2VudDogRnJpZGF5LCBNYXkgMjQsIDIwMjQgNDoxNyBQTQ0KPiA+ID4gVG86
IFdhbmcsIFdlaWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+ID4gQ2M6IElhbiBSb2dl
cnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT47IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbw0KPiA+ID4g
PGFjbWVAa2VybmVsLm9yZz47IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47
IEluZ28gTW9sbmFyDQo+ID4gPiA8bWluZ29AcmVkaGF0LmNvbT47IEFsZXhhbmRlciBTaGlzaGtp
bg0KPiA+ID4gPGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+OyBKaXJpIE9sc2Eg
PGpvbHNhQGtlcm5lbC5vcmc+OyBIdW50ZXIsDQo+ID4gPiBBZHJpYW4gPGFkcmlhbi5odW50ZXJA
aW50ZWwuY29tPjsgS2FuIExpYW5nIDxrYW4ubGlhbmdAbGludXguaW50ZWwuY29tPjsNCj4gPiA+
IGxpbnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBUYXlsb3IsDQo+IFBlcnJ5DQo+ID4gPiA8cGVycnkudGF5bG9yQGludGVsLmNvbT47
IEFsdCwgU2FtYW50aGEgPHNhbWFudGhhLmFsdEBpbnRlbC5jb20+Ow0KPiBCaWdnZXJzLA0KPiA+
ID4gQ2FsZWIgPGNhbGViLmJpZ2dlcnNAaW50ZWwuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtS
RkMgUEFUQ0ggdjkgNC83XSBwZXJmIHN0YXQ6IFBsdWdpbiByZXRpcmVfbGF0IHZhbHVlIGZyb20N
Cj4gc2FtcGxlZA0KPiA+ID4gZGF0YSB0byBldnNlbA0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgTWF5
IDIxLCAyMDI0IGF0IDEwOjQw4oCvQU0gPHdlaWxpbi53YW5nQGludGVsLmNvbT4gd3JvdGU6DQo+
ID4gPiA+DQo+ID4gPiA+IEZyb206IFdlaWxpbiBXYW5nIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+
DQo+ID4gPiA+DQo+ID4gPiA+IEluIGN1cnJlbnQgOlIgcGFyc2luZyBpbXBsZW1lbnRhdGlvbiwg
dGhlIHBhcnNlciB3b3VsZCByZWNvZ25pemUgZXZlbnRzDQo+ID4gPiB3aXRoDQo+ID4gPiA+IHJl
dGlyZV9sYXRlbmN5IG1vZGlmaWVyIGFuZCBpbnNlcnQgdGhlbSBpbnRvIHRoZSBldmxpc3QgbGlr
ZSBhIG5vcm1hbCBldmVudC4NCj4gPiA+ID4gSWRlYWxseSwgd2UgbmVlZCB0byBhdm9pZCBjb3Vu
dGluZyB0aGVzZSBldmVudHMuDQo+ID4gPiA+DQo+ID4gPiA+IEluIHRoaXMgY29tbWl0LCBhdCB0
aGUgdGltZSB3aGVuIGEgcmV0aXJlX2xhdGVuY3kgZXZzZWwgaXMgcmVhZCwgc2V0IHRoZQ0KPiBy
ZXRpcmUNCj4gPiA+ID4gbGF0ZW5jeSB2YWx1ZSBwcm9jZXNzZWQgZnJvbSB0aGUgc2FtcGxlZCBk
YXRhIHRvIGNvdW50IHZhbHVlLiBUaGlzDQo+IHNhbXBsZWQNCj4gPiA+ID4gcmV0aXJlIGxhdGVu
Y3kgdmFsdWUgd2lsbCBiZSB1c2VkIGZvciBtZXRyaWMgY2FsY3VsYXRpb24gYW5kIGZpbmFsIGV2
ZW50DQo+IGNvdW50DQo+ID4gPiA+IHByaW50IG91dC4NCj4gPiA+DQo+ID4gPiBJJ20gY29uZnVz
ZWQuICBEbyB5b3UgbWVhbiB5b3UgZG9uJ3QgY291bnQgdGhlIGV2ZW50IHdpdGggJ1InIG1vZGlm
aWVyDQo+ID4gPiAody8gcGVyZiBzdGF0KSBhbmQganVzdCBwcmludCB0aGUgKGF2ZXJhZ2UpIHJl
dGlyZSBsYXRlbmN5IChmcm9tIHBlcmYgcmVjb3JkKT8NCj4gPg0KPiA+IEluIG1ldHJpYyBmb3Jt
dWxhcywgZXZlbnQgd2l0aG91dCAnUicgbW9kaWZpZXIgaXMgaW5jbHVkZWQgYXMgYSBub3JtYWwg
ZXZlbnQNCj4gYWxyZWFkeS4NCj4gPiBTbyB3ZSBkb24ndCBuZWVkIHRvIGNvdW50IHRoZSBldmVu
dCB0aGF0IHdpdGggJ1InIG1vZGlmaWVyLiBUaGV5IG9ubHkgbmVlZCB0bw0KPiBiZQ0KPiA+IHNh
bXBsZWQuDQo+IA0KPiBPaCwgeW91IGhhdmUgdGhlIGV2ZW50IGluIHRoZSBtZXRyaWMgZXhwcmVz
c2lvbiB0d2ljZS4gIEkgdGhvdWdodCBvZiBvbmUuDQo+IFRoZW4gSUlVQyB0aGUgbWV0cmljIGxv
b2tzIHNvbWV0aGluZyBsaWtlIHRoaXMuDQo+IA0KPiAgIG15ZXZlbnQxICsgKG15ZXZlbnQyICog
bXlldmVudDE6UikNCj4gDQo+IEkgdGhpbmsgeW91J2xsIGhhdmUgMiBteWV2ZW50MSBpbiBwZXJm
IHN0YXQgYW5kIDEgaW4gcGVyZiByZWNvcmQsIHJpZ2h0Pw0KPiBCdXQgdGhlIHNlY29uZCBvbmUg
aW4gcGVyZiBzdGF0IGlzIG5ldmVyIHVzZWQgYW5kIHRoZSB2YWx1ZSBpcyB1cGRhdGVkDQo+IGZy
b20gcGVyZiByZWNvcmQuDQo+IA0KPiBUaGVuIHdlIGNhbiBzaW1wbHkgcmVtb3ZlIHRoZSBldmVu
dCBmcm9tIHRoZSBldmxpc3QgKG9yIHJlcGxhY2UgaXQgd2l0aA0KPiBhIGR1bW15KSB0byByZWR1
Y2UgdGhlIG92ZXJoZWFkcyAob2Ygb3BlbiBhbmQgcmVhZCkuDQoNClllcywgeW91IGFyZSByaWdo
dC4gSWRlYWxseSwgd2Ugd2FudCB0byBub3QgZG8gdGhlIGV4dHJhIGNvdW50aW5nIG9uIHRoZSA6
UiBldmVudC4NCkF0IHRoZSBzYW1lIHRpbWUsIEkgdGhpbmsgSWFuIGFsc28gd2FudHMgdG8gcmV1
c2UgY29kZSBpbiBldnNlbCBmb3IgdGhlIDpSIGV2ZW50cywgDQpzbyB0aGF0IHdlIGRvbid0IG5l
ZWQgc3BlY2lhbCBjb2RlIHRvIGhhbmRsZSByZXRpcmVfbGF0ZW5jeSB2YWx1ZSBwcmludG91dCBh
bmQgDQptZXRyaWMgY2FsY3VsYXRpb24uIFRoZXJlZm9yZSwgSSB0aGluayB3ZSBuZWVkIHRvIGtl
ZXAgcmV0aXJlX2xhdGVuY3kgZXZlbnRzIGluDQpldmxpc3QgYW5kIHNldCBwcm9jZXNzZWQgcmV0
aXJlX2xhdGVuY3kgdmFsdWVzIHRvIHRoZSBldnNlbC4gDQoNCklmIHdlIHJlcGxhY2UgaXQgd2l0
aCBhIGR1bW15IGZvciBvcGVuIGFuZCByZWFkIGFuZCB0aGVuIHNldCByZXRpcmVfbGF0ZW5jeSAN
CnZhbHVlIHRvIGl0IGxhdGVyLCB3aWxsIGl0IHN0aWxsIGJlIHVzZWQgaW4gbWV0cmljIGNhbGN1
bGF0aW9uIGFuZCBwcmludG91dD8NCg0KVGhhbmtzLA0KV2VpbGluDQoNCj4gDQo+ID4NCj4gPiA+
DQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFdlaWxpbiBXYW5nIDx3ZWlsaW4ud2Fu
Z0BpbnRlbC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgdG9vbHMvcGVyZi9hcmNoL3g4Ni91
dGlsL2V2bGlzdC5jIHwgIDYgKysrKysNCj4gPiA+ID4gIHRvb2xzL3BlcmYvdXRpbC9ldnNlbC5j
ICAgICAgICAgICB8IDQ0DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+
ID4gIHRvb2xzL3BlcmYvdXRpbC9ldnNlbC5oICAgICAgICAgICB8ICA1ICsrKysNCj4gPiA+ID4g
IDMgZmlsZXMgY2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZm
IC0tZ2l0IGEvdG9vbHMvcGVyZi9hcmNoL3g4Ni91dGlsL2V2bGlzdC5jDQo+ID4gPiBiL3Rvb2xz
L3BlcmYvYXJjaC94ODYvdXRpbC9ldmxpc3QuYw0KPiA+ID4gPiBpbmRleCBiMWNlMGM1MmQ4OGQu
LmNlYmRkNDgzMTQ5ZSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvdG9vbHMvcGVyZi9hcmNoL3g4Ni91
dGlsL2V2bGlzdC5jDQo+ID4gPiA+ICsrKyBiL3Rvb2xzL3BlcmYvYXJjaC94ODYvdXRpbC9ldmxp
c3QuYw0KPiA+ID4gPiBAQCAtODksNiArODksMTIgQEAgaW50IGFyY2hfZXZsaXN0X19jbXAoY29u
c3Qgc3RydWN0IGV2c2VsICpsaHMsIGNvbnN0DQo+ID4gPiBzdHJ1Y3QgZXZzZWwgKnJocykNCj4g
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDE7DQo+ID4gPiA+ICAgICAgICAg
fQ0KPiA+ID4gPg0KPiA+ID4gPiArICAgICAgIC8qIFJldGlyZSBsYXRlbmN5IGV2ZW50IHNob3Vs
ZCBub3QgYmUgZ3JvdXAgbGVhZGVyKi8NCj4gPiA+DQo+ID4gPiBIbW0uLiB3aHk/DQo+ID4gQmVj
YXVzZSB3ZSBkb24ndCB3YW50IHRvIGNvdW50IHRoZW0uIE1ha2UgdGhlbSB0aGUgZ3JvdXAgbGVh
ZGVyIHdvdWxkDQo+IG5vdCB3b3JrLg0KPiANCj4gSSBkb24ndCB1bmRlcnN0YW5kLiAgWW91J2xs
IHJlYWQgdGhlIGV2ZW50IHJlZ2FyZGxlc3Mgb2YgYmVpbmcgYQ0KPiBsZWFkZXIgb3Igbm90Lg0K
PiANCj4gPg0KPiA+ID4NCj4gPiA+ID4gKyAgICAgICBpZiAobGhzLT5yZXRpcmVfbGF0ICYmICFy
aHMtPnJldGlyZV9sYXQpDQo+ID4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gMTsNCj4gPiA+
ID4gKyAgICAgICBpZiAoIWxocy0+cmV0aXJlX2xhdCAmJiByaHMtPnJldGlyZV9sYXQpDQo+ID4g
PiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLTE7DQo+ID4gPiA+ICsNCj4gPiA+ID4gICAgICAg
ICAvKiBEZWZhdWx0IG9yZGVyaW5nIGJ5IGluc2VydGlvbiBpbmRleC4gKi8NCj4gPiA+ID4gICAg
ICAgICByZXR1cm4gbGhzLT5jb3JlLmlkeCAtIHJocy0+Y29yZS5pZHg7DQo+ID4gPiA+ICB9DQo+
ID4gPiA+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL3V0aWwvZXZzZWwuYyBiL3Rvb2xzL3BlcmYv
dXRpbC9ldnNlbC5jDQo+ID4gPiA+IGluZGV4IGEwYThhZWU3ZDZiOS4uNGQ3MDAzMzhmYzk5IDEw
MDY0NA0KPiA+ID4gPiAtLS0gYS90b29scy9wZXJmL3V0aWwvZXZzZWwuYw0KPiA+ID4gPiArKysg
Yi90b29scy9wZXJmL3V0aWwvZXZzZWwuYw0KPiA+ID4gPiBAQCAtNTgsNiArNTgsNyBAQA0KPiA+
ID4gPiAgI2luY2x1ZGUgPGludGVybmFsL3h5YXJyYXkuaD4NCj4gPiA+ID4gICNpbmNsdWRlIDxp
bnRlcm5hbC9saWIuaD4NCj4gPiA+ID4gICNpbmNsdWRlIDxpbnRlcm5hbC90aHJlYWRtYXAuaD4N
Cj4gPiA+ID4gKyNpbmNsdWRlICJ1dGlsL2ludGVsLXRwZWJzLmgiDQo+ID4gPiA+DQo+ID4gPiA+
ICAjaW5jbHVkZSA8bGludXgvY3R5cGUuaD4NCj4gPiA+ID4NCj4gPiA+ID4gQEAgLTE1MjMsNiAr
MTUyNCw0MCBAQCBzdGF0aWMgaW50IGV2c2VsX19yZWFkX29uZShzdHJ1Y3QgZXZzZWwNCj4gKmV2
c2VsLA0KPiA+ID4gaW50IGNwdV9tYXBfaWR4LCBpbnQgdGhyZWFkKQ0KPiA+ID4gPiAgICAgICAg
IHJldHVybiBwZXJmX2V2c2VsX19yZWFkKCZldnNlbC0+Y29yZSwgY3B1X21hcF9pZHgsIHRocmVh
ZCwgY291bnQpOw0KPiA+ID4gPiAgfQ0KPiA+ID4gPg0KPiA+ID4gPiArc3RhdGljIGludCBldnNl
bF9fc2V0X3JldGlyZV9sYXQoc3RydWN0IGV2c2VsICpldnNlbCwgaW50IGNwdV9tYXBfaWR4LCBp
bnQNCj4gPiA+IHRocmVhZCkNCj4gPiA+ID4gK3sNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgcGVy
Zl9jb3VudHNfdmFsdWVzICpjb3VudDsNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgdHBlYnNfcmV0
aXJlX2xhdCAqdDsNCj4gPiA+ID4gKyAgICAgICBib29sIGZvdW5kID0gZmFsc2U7DQo+ID4gPiA+
ICsgICAgICAgX191NjQgdmFsOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgY291bnQgPSBw
ZXJmX2NvdW50cyhldnNlbC0+Y291bnRzLCBjcHVfbWFwX2lkeCwgdGhyZWFkKTsNCj4gPiA+ID4g
Kw0KPiA+ID4gPiArICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnkodCwgJnRwZWJzX3Jlc3VsdHMs
IG5kKSB7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBpZiAoIXN0cmNtcCh0LT50cGVic19uYW1l
LCBldnNlbC0+bmFtZSkpIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZm91bmQg
PSB0cnVlOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiA+ID4g
KyAgICAgICAgICAgICAgIH0NCj4gPiA+ID4gKyAgICAgICB9DQo+ID4gPiA+ICsNCj4gPiA+ID4g
KyAgICAgICBpZiAoIWZvdW5kKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC0xOw0K
PiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgLyoNCj4gPiA+ID4gKyAgICAgICAgKiBPbmx5IHNl
dCByZXRpcmVfbGF0ZW5jeSB2YWx1ZSB0byB0aGUgZmlyc3QgQ1BVIGFuZCB0aHJlYWQuDQo+ID4g
PiA+ICsgICAgICAgICovDQo+ID4gPiA+ICsgICAgICAgaWYgKGNwdV9tYXBfaWR4ID09IDAgJiYg
dGhyZWFkID09IDApDQo+ID4gPiA+ICsgICAgICAgICAgICAgICB2YWwgPSB0LT52YWw7DQo+ID4g
PiA+ICsgICAgICAgZWxzZQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgdmFsID0gMDsNCj4gPiA+
ID4gKw0KPiA+ID4gPiArICAgICAgIGNvdW50LT52YWwgPSB2YWw7DQo+ID4gPiA+ICsgICAgICAg
LyogU2V0IGVuYSBhbmQgcnVuIHRvIG5vbi16ZXJvICovDQo+ID4gPiA+ICsgICAgICAgY291bnQt
PmVuYSA9IGNvdW50LT5ydW4gPSAxOw0KPiA+ID4gPiArICAgICAgIGNvdW50LT5sb3N0ID0gMDsN
Cj4gPiA+DQo+ID4gPiBTbyBoZXJlIGl0IHNlZW1zIHlvdSBkaXNjYXJkIHRoZSBhY3R1YWwgY291
bnQgb2YgdGhlIGV2ZW50cw0KPiA+ID4gYW5kIHJlcGxhY2UgaXQgd2l0aCB0aGUgcmV0aXJlIGxh
dGVuY3kuICBUaGF0IG1lYW5zIHlvdSBkb24ndA0KPiA+ID4gbmVlZCB0byBvcGVuIHRoZSBldmVu
dCBpbiBwZXJmIHN0YXQsIGFuZCBwcm9iYWJseSBqdXN0IGhhdmUgYQ0KPiA+ID4gcGxhY2Vob2xk
ZXIsIHJpZ2h0Pw0KPiA+ID4NCj4gPiA+IEJ0dywgSSB0aGluayBpdCdzIGJldHRlciB0byBtb3Zl
IHRoaXMgbG9naWMgdG8gaW50ZWwtdHBlYnMuYyBmaWxlIGFuZA0KPiA+ID4gcmVuYW1lIHRvIHRw
ZWJzX3NldF9yZXRpcmVfbGF0KCkuDQo+ID4NCj4gPiBJYW4gd2FudHMgdGhpcyB0byBiZSBoZXJl
IGFuZCBhbHNvIHN1Z2dlc3RlZCBtZSB0byByZW5hbWUgdGhpcyBmdW5jdGlvbiB0bw0KPiA+IGV2
c2VsX19yZWFkX3JldGlyZV9sYXQoKS4gSSdtIG9rIHdpdGggZWl0aGVyIHdheS4NCj4gDQo+IEkg
dGhpbmsgaXQncyBiZXR0ZXIgdG8gaGF2ZSB0aGUgdHBlYnMgbG9naWMgdG9nZXRoZXIuDQo+IA0K
PiBUaGFua3MsDQo+IE5hbWh5dW5nDQo+IA0KPiA+DQo+ID4gPg0KPiA+ID4NCj4gPiA+ID4gKyAg
ICAgICByZXR1cm4gMDsNCj4gPiA+ID4gK30NCj4gPiA+ID4gKw0KPiA+ID4gPiAgc3RhdGljIHZv
aWQgZXZzZWxfX3NldF9jb3VudChzdHJ1Y3QgZXZzZWwgKmNvdW50ZXIsIGludCBjcHVfbWFwX2lk
eCwgaW50DQo+ID4gPiB0aHJlYWQsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdTY0IHZhbCwgdTY0IGVuYSwgdTY0IHJ1biwgdTY0IGxvc3QpDQo+ID4gPiA+ICB7DQo+ID4g
PiA+IEBAIC0xNTMwLDYgKzE1NjUsMTIgQEAgc3RhdGljIHZvaWQgZXZzZWxfX3NldF9jb3VudChz
dHJ1Y3QgZXZzZWwNCj4gPiA+ICpjb3VudGVyLCBpbnQgY3B1X21hcF9pZHgsIGludCB0aHJlYWQs
DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgY291bnQgPSBwZXJmX2NvdW50cyhjb3VudGVyLT5j
b3VudHMsIGNwdV9tYXBfaWR4LCB0aHJlYWQpOw0KPiA+ID4gPg0KPiA+ID4gPiArICAgICAgIGlm
IChjb3VudGVyLT5yZXRpcmVfbGF0KSB7DQo+ID4gPg0KPiA+ID4gaWYgKGV2c2VsX19pc19yZXRp
cmVfbGF0KGNvdW50ZXIpKSA/DQo+ID4gPg0KPiA+ID4NCj4gPiA+ID4gKyAgICAgICAgICAgICAg
IGV2c2VsX19zZXRfcmV0aXJlX2xhdChjb3VudGVyLCBjcHVfbWFwX2lkeCwgdGhyZWFkKTsNCj4g
PiA+ID4gKyAgICAgICAgICAgICAgIHBlcmZfY291bnRzX19zZXRfbG9hZGVkKGNvdW50ZXItPmNv
dW50cywgY3B1X21hcF9pZHgsDQo+IHRocmVhZCwNCj4gPiA+IHRydWUpOw0KPiA+ID4gPiArICAg
ICAgICAgICAgICAgcmV0dXJuOw0KPiA+ID4gPiArICAgICAgIH0NCj4gPiA+ID4gKw0KPiA+ID4g
PiAgICAgICAgIGNvdW50LT52YWwgICAgPSB2YWw7DQo+ID4gPiA+ICAgICAgICAgY291bnQtPmVu
YSAgICA9IGVuYTsNCj4gPiA+ID4gICAgICAgICBjb3VudC0+cnVuICAgID0gcnVuOw0KPiA+ID4g
PiBAQCAtMTc3OCw2ICsxODE5LDkgQEAgaW50IGV2c2VsX19yZWFkX2NvdW50ZXIoc3RydWN0IGV2
c2VsICpldnNlbCwNCj4gaW50DQo+ID4gPiBjcHVfbWFwX2lkeCwgaW50IHRocmVhZCkNCj4gPiA+
ID4gICAgICAgICBpZiAoZXZzZWxfX2lzX3Rvb2woZXZzZWwpKQ0KPiA+ID4gPiAgICAgICAgICAg
ICAgICAgcmV0dXJuIGV2c2VsX19yZWFkX3Rvb2woZXZzZWwsIGNwdV9tYXBfaWR4LCB0aHJlYWQp
Ow0KPiA+ID4gPg0KPiA+ID4gPiArICAgICAgIGlmIChldnNlbF9faXNfcmV0aXJlX2xhdChldnNl
bCkpDQo+ID4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gZXZzZWxfX3NldF9yZXRpcmVfbGF0
KGV2c2VsLCBjcHVfbWFwX2lkeCwgdGhyZWFkKTsNCj4gPiA+ID4gKw0KPiA+ID4NCj4gPiA+IEkn
bSBub3Qgc3VyZSBpZiBpdCB3b3JrcyB3ZWxsIHdpdGggZ3JvdXAgZXZlbnQuICBQcm9iYWJseSB0
aGF0J3MNCj4gPiA+IHdoeSB5b3Ugd2FudGVkIHRvIHByZXZlbnQgZ3JvdXAgbGVhZGVycy4gIEJ1
dCBJIGd1ZXNzIHlvdQ0KPiA+ID4gY2FuIGp1c3QgY2hlY2sgdGhpcyBhZnRlciB0aGUgUEVSRl9G
T1JNQVRfR1JPVVAsIG5vPw0KPiA+ID4NCj4gPiA+IFRoYW5rcywNCj4gPiA+IE5hbWh5dW5nDQo+
ID4gPg0KPiA+ID4NCj4gPiA+ID4gICAgICAgICBpZiAoZXZzZWwtPmNvcmUuYXR0ci5yZWFkX2Zv
cm1hdCAmIFBFUkZfRk9STUFUX0dST1VQKQ0KPiA+ID4gPiAgICAgICAgICAgICAgICAgcmV0dXJu
IGV2c2VsX19yZWFkX2dyb3VwKGV2c2VsLCBjcHVfbWFwX2lkeCwgdGhyZWFkKTsNCj4gPiA+ID4N
Cj4gPiA+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC9ldnNlbC5oIGIvdG9vbHMvcGVy
Zi91dGlsL2V2c2VsLmgNCj4gPiA+ID4gaW5kZXggYmQ4ZTg0OTU0ZTM0Li5hYWY1NzIzMTdlOTIg
MTAwNjQ0DQo+ID4gPiA+IC0tLSBhL3Rvb2xzL3BlcmYvdXRpbC9ldnNlbC5oDQo+ID4gPiA+ICsr
KyBiL3Rvb2xzL3BlcmYvdXRpbC9ldnNlbC5oDQo+ID4gPiA+IEBAIC0zMDMsNiArMzAzLDExIEBA
IHN0YXRpYyBpbmxpbmUgYm9vbCBldnNlbF9faXNfdG9vbChjb25zdCBzdHJ1Y3QNCj4gZXZzZWwN
Cj4gPiA+ICpldnNlbCkNCj4gPiA+ID4gICAgICAgICByZXR1cm4gZXZzZWwtPnRvb2xfZXZlbnQg
IT0gUEVSRl9UT09MX05PTkU7DQo+ID4gPiA+ICB9DQo+ID4gPiA+DQo+ID4gPiA+ICtzdGF0aWMg
aW5saW5lIGJvb2wgZXZzZWxfX2lzX3JldGlyZV9sYXQoY29uc3Qgc3RydWN0IGV2c2VsICpldnNl
bCkNCj4gPiA+ID4gK3sNCj4gPiA+ID4gKyAgICAgICByZXR1cm4gZXZzZWwtPnJldGlyZV9sYXQ7
DQo+ID4gPiA+ICt9DQo+ID4gPiA+ICsNCj4gPiA+ID4gIGNvbnN0IGNoYXIgKmV2c2VsX19ncm91
cF9uYW1lKHN0cnVjdCBldnNlbCAqZXZzZWwpOw0KPiA+ID4gPiAgaW50IGV2c2VsX19ncm91cF9k
ZXNjKHN0cnVjdCBldnNlbCAqZXZzZWwsIGNoYXIgKmJ1Ziwgc2l6ZV90IHNpemUpOw0KPiA+ID4g
Pg0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjQzLjANCj4gPiA+ID4NCg==


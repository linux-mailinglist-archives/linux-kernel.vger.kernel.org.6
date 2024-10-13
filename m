Return-Path: <linux-kernel+bounces-362829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A6F99B9B1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 16:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50181F21327
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 14:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E9A1448DF;
	Sun, 13 Oct 2024 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+WNkYhk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE69513D61B
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728829354; cv=fail; b=Pd5ivdWvXdQUwVQBkqCt2UsvfOzGGqx3ID0j8uu1/tuktRZUPOR2rt4diUr3lXLrOyh8uMgOrnrv3Ciu8O8QDEUx8ArTRNZa2M9CCtgxIL+DBzjMsBnCzB3gpYFl9CydpG7yni6Mj24A4DN5ntP6FhwAHlvW+b6xFcXnWZh0IN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728829354; c=relaxed/simple;
	bh=1M4xZ4XRYed4WPgThV/OvR9MqEUVRZlvzfz6htoIPC0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FocwpyMG+PoGgwKq/Mv2KS89sSrR4JqRm9ei0/C8CNLkMWZmrXwwsZMuQQVr5SbScgTWSr09fseFxHz4InQ9i1kKFTal/7dAothopZxh+5mzfy48Lub/FtnxJvPHMB1Md9jmYzR8CAGSC21HJQdoUNk02HkJetjMgEPBoj7xd4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+WNkYhk; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728829352; x=1760365352;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1M4xZ4XRYed4WPgThV/OvR9MqEUVRZlvzfz6htoIPC0=;
  b=h+WNkYhkI7vzbH7K0eTWIKIYqjlvOtsQ+ddiAa4Dhm2zC9+8cp+oj+Ha
   Jlt4LvEgugP3SKuJJ/oBa2uv9vK+0fhdcYHT4jo4ZMoOVrqOT8nPCl18V
   gELhJfOysd+H6HSfRwyfPE6gdONC0hM+cOXVASG3Oc32YJaHcFKlSlOYv
   T2bkTpezdK+lUyuJTM5niWAdiD/d8FI31WzpUPoNY74EkRq6q5EwNmEiK
   e6v+tAR/1PLTaekTt1mwIa7maYLcvPbR79TpC+6ZddNNBZSNy2CSk9ob3
   +6RQzDJgx1xLnbSbYNh+OafS/fCjNtCD+L4ZvtVlkDlSy1ntIybv5zuyO
   w==;
X-CSE-ConnectionGUID: D6CUQHeiS4uu2apN3OnNBA==
X-CSE-MsgGUID: W5GJzo1MStClbvWmxLBpzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39297123"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39297123"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 07:22:31 -0700
X-CSE-ConnectionGUID: nPPUHx44TyGYD8H+2IA7Zw==
X-CSE-MsgGUID: E13ep8/2RfuORAN017of7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,201,1725346800"; 
   d="scan'208";a="77356885"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2024 07:22:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 13 Oct 2024 07:22:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 13 Oct 2024 07:22:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 13 Oct 2024 07:22:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 13 Oct 2024 07:22:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYoCehWMAq0UzX68A1r6PV/0rkto8KGQ//Hk8vccd7YMaCYyDeZBFYJHS9lfH544XYGPIGoOoDrppT/RqFGjbL9gryUr3wjVnx7TdkFMIKRiRZO3VEIB/JhlSd4nyf1B4QoTxEjqdAumjgMY3TDSE2spgWg5IKDDSLQ932zVYXgmf8ofA001ONU0p3LO+W/dg/FdiCEJs3ofTNYrAD0EzzAhfDJpDKBeSNDthzAAQE385yigTWcZz+I3tEZOVUP6ET/dGpQIbuTKLjJ1W2iMLlo00VrcS5zN3ToFWTp0EDYgnJIMlVep/WPzayUA8VaMffk1sU3DFrScFoUy0aQG9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1M4xZ4XRYed4WPgThV/OvR9MqEUVRZlvzfz6htoIPC0=;
 b=r+dBaTVkjD9/s4eADNiFAzr4we93jD45zWauGdCORW7sXMm8/ad2qYtu3tZ/4ghrm63dkhbiyIF9QLIjapkPEZKIKgGEkW7tV1XSNcpYVR8Pw8YNVIkcy3cIw+tnAEc1kaugY8Shho7jTLhb/BI3a3cpiMjjS5KZ4wDR6tB0lxbUgfuRNPpU8uQt2k3iW9aiUDoJ0rvRlO2iO1UlG08xE+EIWatbOhL9LtnHj2xc/p0KvAArlayEQCx2T849B/2AkYzpvNQCMiFy0oEMlOQSmBpCicvVR4n8NkaVtHaSqBT84DtR1eINteJgqMiTplM/2E0/EDNHFw7ZnQLGEplGwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SN7PR11MB6898.namprd11.prod.outlook.com (2603:10b6:806:2a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Sun, 13 Oct
 2024 14:22:27 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%5]) with mapi id 15.20.8048.020; Sun, 13 Oct 2024
 14:22:27 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Weil, Oren jer" <oren.jer.weil@intel.com>, Tomas Winkler
	<tomasw@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next] mei: use kvmalloc for read buffer
Thread-Topic: [char-misc-next] mei: use kvmalloc for read buffer
Thread-Index: AQHbHWhGw6lk2l+i/kCbXkW342aN97KEmAAAgAAeWGA=
Date: Sun, 13 Oct 2024 14:22:27 +0000
Message-ID: <CY5PR11MB63665F42CE8EDCD3D48D2A27ED7B2@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20241013115314.1290051-1-alexander.usyskin@intel.com>
 <2024101343-proposal-gatherer-8c43@gregkh>
In-Reply-To: <2024101343-proposal-gatherer-8c43@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|SN7PR11MB6898:EE_
x-ms-office365-filtering-correlation-id: d6c3a55b-ede0-44cb-4fce-08dceb9276e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T2VqdUV5Mm4rVitDRGU2RUlLdjlma3RVazliSm5ZS0kya2wvTHpPNWMzNmhN?=
 =?utf-8?B?UFR2WmNnaFplanVmZlExRGdqU2FNUnAwZ21EUzg5YU5HdFNqdTJmdzZkeGZt?=
 =?utf-8?B?Sk41Nm1YQUJrUWoxYm1sbFJOWFZKYmlpeFlEb2QxNzIydHVIYWcrNjdRVU1s?=
 =?utf-8?B?VkNvajFmMnhLWURzT1RuUVBnQTNEUklRcHJSSW1ZdEc4eVlXNldWWjhuQjdq?=
 =?utf-8?B?S1ZydEF1b3pWM20vcCtaWGlQNHpvalFYWGgyZFYrWmlVTTFzcTVGNWh0RHBz?=
 =?utf-8?B?VzIxVy9jRXFxb0NwdjFJUGYrdEdQM3B4eUhlUUtla29BVktpV3Rmb1E0R05G?=
 =?utf-8?B?cjZXR2s2TDhuL2tkamRNMk94dy85bjdUOVl3U2htVmcxNUpxajM3UjJaMVZI?=
 =?utf-8?B?dUFrV3I4dzdiUzlpaVNGaW1QTFZWTDBtVUQ5LzAwMFkxSzlJVlJzRzYrZlZC?=
 =?utf-8?B?RFBGckVWd0dtemhnVmE4Kzltd28wWCs2KzF3c3RFdnZWU2Jsem0ybUp6UFo2?=
 =?utf-8?B?bE1YOVJXQ21KUFU1aDVjc1orQXYzUmRxR1h5TTZhckp5b0VyTkVDa3ZSczNJ?=
 =?utf-8?B?aEUwaHAxNHhodXY5bFpNcHpDNHBYdExoSEpGbmkrelVramdWTTVrOHBGWnhn?=
 =?utf-8?B?N2N2c09xdGRwVzZpdk8ydG5MVW5WWm1KaGkzNUVudVVOUUlCdlJTRVVNM1Iy?=
 =?utf-8?B?M3ZWdUJnNkxNa3N6eXRxdDNWa2lKZVhrUHhUdnl1SmpCbUpnZmdLRlp5aVov?=
 =?utf-8?B?MktqdUh0em9mR0t2QisxMWtkV2tjVHdZcGJiN1ZXZkwvKzFiSUhYZFd5Yjhv?=
 =?utf-8?B?UWhrT1R6WCtmQThsNlBuNHRZV0FPc01LWWNnZ0gwcXAvNlZoa09lZTMvUlpN?=
 =?utf-8?B?QmdNVWd5V0ZtT20zdHBNSVhLQkRmdzRJUmtKYklZa3JtRkgwcUpZVlFWQ1ZQ?=
 =?utf-8?B?NzVpV0s3QjRNdVMrU3kzYSs3TWh0SDlhSDk2azVWbXUwMW9ITlRhY0hPUnRG?=
 =?utf-8?B?THpiSVlKN0pWeHA2NW14K2hiY0RDa0VlZC84NHVoR0t6ZVl5bGlCUEtlaW9R?=
 =?utf-8?B?MGNBWEZUa0puTGdleWlUT0FmSTd1clRDVXZvY3lqMlJlVkZXK0FGa2Q1RmZ5?=
 =?utf-8?B?dm5vcXFzdkdHVzJqV3Z4anZTSHZ1K1I0eERsVitVQUVkc1RzR3p1Q1dKUUFh?=
 =?utf-8?B?a00yL2hScTN1NXdtRFRGSTRmT3RQbXFNUWR5djN3T1F0KzVxWFh4YlMxdjhj?=
 =?utf-8?B?a2lLQzBTK3NLdXovSXlBRTByclkreFVKZGJScUZWOGNXL3J5QjhacXpqcUxp?=
 =?utf-8?B?OU05SVZxdU1DaytUN2hHUzlJL3JUa25Wc202MFlrbk9BRS9YWkNZMXIwNTFJ?=
 =?utf-8?B?WUZJTlNWbUlaRlh3MUcvdUc0OVQ0RjROcGEwVTQvNm9HbExIYXRKQ3B5R2dr?=
 =?utf-8?B?dklCNmdaU1FFZGVzSWZBeS9salRxS0taZHdIenNBWXd5b3VMdER4MmdTSVNU?=
 =?utf-8?B?Y1VaUERpYkxPMmkrRE1TdWR2bklnMWRMckhyRStuMkJjWjd0TnJJL2JVSjNz?=
 =?utf-8?B?bjg2cmVjczkreHNMSDhBZmNyVWVYVjFXU2lJeVdIUU04bmhUV0Exenluak5I?=
 =?utf-8?B?Vmh6dXQ2OTNRNmplang3SWZlcTBRY3ZROTd0R3kwbzBHZzlKR0gwUVJJTUI3?=
 =?utf-8?B?dXFmbGR2L3ZZNzZIUUVoaTErYjgydm9JN1ZBTzc0MHlSM2R6ZEdKTVIwTndQ?=
 =?utf-8?B?MTRDeXN4WnZSMHZoMGxqMm1TTGJDRTVqNE9YK2czRFQxK0JwcG1Jbk1GaE4y?=
 =?utf-8?B?UVk2cGJVM3J1bTZ5RHhjQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1R3KzdyZWpYd2lsY3VHVmRYaUo1TmFVUEM5TnUyZHBaSFVLRzhLU1JaeDNw?=
 =?utf-8?B?Mmx4S3QxTGZkT2kvcXZGQndobHUveEFSaHhETlpEak4vVTFXaWRaWWYrWWR4?=
 =?utf-8?B?YzFBMXNOQ0VIaFpKOFVQUVp1UG8wN1JwYXFFdUlEYitNdHdsVU1JVUdDQjR3?=
 =?utf-8?B?YW82d3dYbkpPNjJWc0tpYlRqek9aMi9RZkRJbVhkVkJXU3JTdlpJakh3TU40?=
 =?utf-8?B?aGRXZHNKTXdIb0RIQkhicVZWbDJiVTZ1VHgxdno3WFg1Z3U2OFV3VVpmUW1V?=
 =?utf-8?B?VXB5ODdMdncwczJwT1J0NlZsQ013YytxOHVubXJLUE90WHVMTGgvK1R3TXd6?=
 =?utf-8?B?Vmp2Wk9TSEJmRUVYR1h3WmJLei8xOUVyVTlSWEVEaWYwa0ozS3ZnaHk0WDRZ?=
 =?utf-8?B?OWtqNEtVZXBXbHVYVnEwNE0yTG5Zek9DUCtrdENqUlA0dDlwK0tsZUxjM1Jr?=
 =?utf-8?B?SUhXeWxVRXg4MTJDMktTcGpzS1REOVFRek0rVENsNmhiSFJTcGhFeEtsZ3JC?=
 =?utf-8?B?WnBmbHJRUFN4WG1mNnJLTXg0Tkc0ckhlT2FMUGkrWUZHbXY5S1JwblFVU1Ry?=
 =?utf-8?B?V0xkR0dieWVNK2pXVFZMVTcyaWN2SGFnNkQ3ZmRrVW9UcUlkbEFwZEhlMTBP?=
 =?utf-8?B?dkdXcUxGaVF2aGhkTm5IMjlqa3JqQW1uNzZ6NUJQazNXb3l3akkxL1FzUGxY?=
 =?utf-8?B?V3lvMWJWanVVa0hmSVhZQ1MwVXB4NGtFNGlGZVpsdXA2MU01bUh5RXBrdk0v?=
 =?utf-8?B?YS9YdjRINjIvWjJZSUcxWUNNd0svczJDdldqQlNPTnBtMVlrd0ZMcy9rME1C?=
 =?utf-8?B?UjVTTkZRRFdlUExzdUMvZHEwNWErR3N0NmZwT1pKZGdpMHBRV0d0NWladVNq?=
 =?utf-8?B?UWlrSzRURlJPUjQrQ1pob0xSQk9aekhKQWtEczJmWjhCSFg2VzBSVlhFbkZS?=
 =?utf-8?B?ZGdaMWptUmpwekFZekVuM0ZtWmJHTG9ua0gzUDUyaXZxeTloZnNiRG8vYzgv?=
 =?utf-8?B?SEJITXVkNmtKODkwZHJIN3ZETDY3Z05tOFBwYm05TDd5UmNaUjN4dFNGMzdB?=
 =?utf-8?B?TWNEbTg4aGE5YzM5d3RiUGk1R2hHREsvM0NFK2FadW1RVmZVZ2xJeElUeTA3?=
 =?utf-8?B?ekFqck8zcGhDcGxkVFYxUmtvWG9weDZhbXhWT0dnQ3R2QTNoMlpNYzRJWUdK?=
 =?utf-8?B?b2ZyS3ZxMjlrMytFOVFDQmN4S2lud04xd2Vxb3Q3THVXak9lYUdVRkpPcFZ4?=
 =?utf-8?B?eGVoNnZDb0EwdFNHUjlVbGdHRy9xaHhzNlh3cWp0RmZNYWFibGloN1hYNTRp?=
 =?utf-8?B?N0llNWpzalkwV3pzWjk1Wlc1cXpwSVdQWlBsQTZQQzd0bzBCZXFBRDhvdkh3?=
 =?utf-8?B?MUJHSkVnWkxQTjlYeE43bFR1OFMvUWhSajZDQXkrYTR2VVZnQm1DaFFQYmtk?=
 =?utf-8?B?cXlqTEYvSTkrNTB3YzZlejBmMTBubS9MMXdQY05ocmZhNWx0NW1idGNMUEdJ?=
 =?utf-8?B?R3JaV0FGVHQxNmJaeTUwVWRxSDgrSHpBVHgxRm1Hc25hM0NFdFJKTEdGT3I2?=
 =?utf-8?B?Wm1NQ3B2TGxmNUdJOEl4aUppZWZRa0FpSVRvemdiZDNYUTZFRVpiRzhHODdV?=
 =?utf-8?B?MU5mWW81SHJkTVBTVXRYR0F1NVlBb0RnZ0dQUGZlblNWWFdSWTBlYzNYTEJa?=
 =?utf-8?B?ajBnSDA3S2x4UlIxNlk2ZEpramVxSVhad1cwc01zU1dkNmlsQktRK0p5aG9W?=
 =?utf-8?B?WGJqeEx0eW9GQmMzRXlqU1BIMEg0WEJKSFJvbjREam1EazNLeVE2ZmE2Q044?=
 =?utf-8?B?K1l3alYzb05KM3hnOUNEMXIxMWdVRDc1dDM5KzB0cHpVWDFEdzVyUzRaem1Y?=
 =?utf-8?B?MVlzdGI3OWUxZnFkM01JdHRjdXI4VEQwbFE1b2NRazJ4dkdva1o1T0o1V0s5?=
 =?utf-8?B?Z0hpdkpZL3FBcGxvcjFVbU1FUFFJdHhZUUdQbWN4MEZhMFpkUTN1bitCcWpF?=
 =?utf-8?B?UklaYnBtbHYwcFBDMTRrODFSVTQ4ZlA0TmVCZENtRXNxcVVWS3VLSmtIdVRv?=
 =?utf-8?B?RDh6RDNTVmxFTEQxUmtFWkorZlBjbTBVZ0IzRzV4eGpUZnByRmY4YU5ZQjZO?=
 =?utf-8?B?N1JHNGZUVDZ2K3F2LzNFelhiekJkN29ubTJGdWJZNEs1U29Da3A1bHk1OU5H?=
 =?utf-8?B?K3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c3a55b-ede0-44cb-4fce-08dceb9276e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2024 14:22:27.1896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nM40za3uXiBg/v6w6w1o+5iQUKpIdXfiVpaE53w19CwwQHTuUxLLi939MljqtvJZJ8s87V+87NsPqig688V1YEmgh7FKoG+WbLwrbsfgJaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6898
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4g
PGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiBTZW50OiBTdW5kYXksIE9jdG9iZXIgMTMs
IDIwMjQgMzoxNCBQTQ0KPiBUbzogVXN5c2tpbiwgQWxleGFuZGVyIDxhbGV4YW5kZXIudXN5c2tp
bkBpbnRlbC5jb20+DQo+IENjOiBXZWlsLCBPcmVuIGplciA8b3Jlbi5qZXIud2VpbEBpbnRlbC5j
b20+OyBUb21hcyBXaW5rbGVyDQo+IDx0b21hc3dAZ21haWwuY29tPjsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW2NoYXItbWlzYy1uZXh0XSBtZWk6IHVzZSBr
dm1hbGxvYyBmb3IgcmVhZCBidWZmZXINCj4gDQo+IE9uIFN1biwgT2N0IDEzLCAyMDI0IGF0IDAy
OjUzOjE0UE0gKzAzMDAsIEFsZXhhbmRlciBVc3lza2luIHdyb3RlOg0KPiA+IFJlYWQgYnVmZmVy
IGlzIGFsbG9jYXRlZCBhY2NvcmRpbmcgdG8gbWF4IG1lc3NhZ2Ugc2l6ZSwNCj4gPiByZXBvcnRl
ZCBieSB0aGUgZmlybXdhcmUgYW5kIG1heSByZWFjaCA2NEsgaW4gc3lzdGVtcw0KPiA+IHdpdGgg
cHhwIGNsaWVudC4NCj4gPiBDb250aWd1b3VzIDY0ayBhbGxvY2F0aW9uIG1heSBmYWlsIHVuZGVy
IG1lbW9yeSBwcmVzc3VyZS4NCj4gPiBSZWFkIGJ1ZmZlciBpcyB1c2VkIGFzIGluLWRyaXZlciBt
ZXNzYWdlIHN0b3JhZ2UgYW5kDQo+ID4gbm90IHJlcXVpcmVkIHRvIGJlIGNvbnRpZ3VvdXMuDQo+
ID4gVXNlIGt2bWFsbG9jIHRvIGFsbG93IGtlcm5lbCB0byBhbGxvY2F0ZSBub24tY29udGlndW91
cw0KPiA+IG1lbW9yeSBpbiB0aGlzIGNhc2UuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4
YW5kZXIgVXN5c2tpbiA8YWxleGFuZGVyLnVzeXNraW5AaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL21pc2MvbWVpL2NsaWVudC5jIHwgNCArKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBXaGF0IGFib3V0IHRoaXMg
dGhyZWFkOg0KPiAJaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwODEzMDg0NTQyLjI5
MjEzMDAtMS0NCj4gcm9oaWFnYXJAY2hyb21pdW0ub3JnLw0KPiANCj4gTm8gYXR0cmlidXRpb24g
Zm9yIHRoZSByZXBvcnRlcj8gIERvZXMgaXQgc29sdmUgdGhlaXIgcHJvYmxlbT8NCj4gDQpUaGlz
IHBhdGNoIGlzIGEgcmVzdWx0IGZyb20gbm9uLXB1YmxpYyBidWcgcmVwb3J0IG9uIENocm9tZU9T
Lg0KVGhlaXIgc3ltcHRvbXMgYXJlIG5vdCB0aGUgc2FtZSBhcyBpbiB0aGUgdGhyZWFkIGFib3Zl
Lg0KQnV0LCBhcyB5b3UgcmlnaHRseSBwb2ludCBvdXQsIHRoaXMgcGF0Y2ggc2hvdWxkIGFsc28g
Zml4IGFib3ZlIHByb2JsZW0uDQpJJ2xsIGFkZCBhdHRyaWJ1dGlvbiBpbiB2Mi4NCg0KPiBBbmQg
d2h5IHN1Y2ggYSBzaG9ydCBsaW5lLWxlbmd0aCBpbiB0aGUgY2hhbmdlbG9nPw0KSSd2ZSB0cmll
ZCB0byBzcGxpdCBsb2dpY2FsbHkgd2l0aCBub3QgcGFzc2luZyA3NSBjaGFyYWN0ZXJzLg0KV2ls
bCB0cnkgdG8gcmUtc2h1ZmZsZSBpbiB2Mi4NCg0KPiANCj4gQWxzbywgd2hlcmUgaXMgdGhpcyBt
ZW1vcnkgcHJlc3N1cmUgY29taW5nIGZyb20sIHdoYXQgaXMgdGhlIHJvb3QgY2F1c2UNCj4gYW5k
IHdoYXQgY29tbWl0IGRvZXMgdGhpcyBmaXg/ICBTdGFibGUgYmFja3BvcnRzIG5lZWRlZD8gIEFu
eXRoaW5nIGVsc2U/DQo+IA0KVGhlIENocm9tZU9TIGlzIGV4dHJlbWVseSBzaG9ydCBvbiBtZW1v
cnkgYnkgZGVzaWduIGFuZCBjYW4gdHJpZ2dlcg0KdGhpcyBzaXR1YXRpb24gdmVyeSBlYXNpbHku
DQpJIGRvIG5vdCB0aGluayB0aGF0IHRoaXMgcGF0Y2ggZml4ZXMgYW55IGNvbW1pdCAtIHRoZSBw
cm9ibGVtYXRpYyBjb2RlIGV4aXN0cw0KZnJvbSB0aGUgZWFybGllc3QgdmVyc2lvbnMgb2YgdGhp
cyBkcml2ZXIuDQpBcyB0aGlzIHByb2JsZW0gcmVwcm9kdWNlZCBvbmx5IG9uIENocm9tZU9TIEkg
YmVsaWV2ZSB0aGF0IG5vIG5lZWQNCmluIHdpZGUgYmFja3BvcnQsIHRoZSBDaHJvbWVPUyBjYW4g
Y2hlcnJ5LXBpY2sgdGhlIHBhdGNoLg0KRnJvbSB5b3VyIGV4cGVyaWVuY2UsIGlzIHRoaXMgdGhl
IHJpZ2h0IHN0cmF0ZWd5PyANCg0KPiBBbmQgd2hvIGluc2lkZSBJbnRlbCByZXZpZXdlZCB0aGlz
IGJlZm9yZSBzZW5kaW5nIHRoaXMgb3V0PyAgV2h5IGFyZQ0KPiB0aGV5IG5vdCBjcmVkaXRlZCBo
ZXJlIHByb3Blcmx5Pw0KPiANCk15IGJhZCwgbG9zdCB0aGUgdGVzdGVkLWJ5IHRhZyBpbiBwYXRj
aCBwcmVwYXJhdGlvbnMuDQpXaWxsIGFkZCBpbiB2Mi4NCg0KPiB0aGFua3MsDQo+IA0KPiBncmVn
IGstaA0KDQotIC0gDQpUaGFua3MsDQpTYXNoYQ0KDQoNCg==


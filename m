Return-Path: <linux-kernel+bounces-291807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADEE956737
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94281F229C4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA3015C15F;
	Mon, 19 Aug 2024 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fvV3bZyR"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013004.outbound.protection.outlook.com [52.101.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EF31802B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060363; cv=fail; b=uuDn2sHGM39PnSoNR2tx7Op2qMlLuhLUql09cLbIvz+pdXOHNa+lhGl2dxq3lcf7VfjMUunCos8fF+Ym0yhT/nQcdaDjAa2vRoTRcq8oiss+seL+Kh1hQL6mSBP5zwxBOuKtFpCvnalxSFS8D9FbfLbA0ichZOFJaNwaosi1NNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060363; c=relaxed/simple;
	bh=te5Vu08ZMJ7GZmOyoImI5N+AoOcJwdTOnkMgB25KwJI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Iqmt97BHWV1U6SRe+t1DXNIHQp/MTW80PM2c9JaSegM4oFxMi0I8vxpRFWad5ECorNWbXSalAVbRGKFqk9gGHDKle9uDRRJweEjVNvef5V+JushHT8UCXYCSKrBv3iytLhLl5L+Ih6Y+Td5KO3dawWCjo7kccFoTtZzY4pgm1SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fvV3bZyR; arc=fail smtp.client-ip=52.101.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFuxn7qHvUO4uLQyhvxe5BU7AIe6qLy9CH+Surui/aLuwrUOvJ6j0IHW95w86N2AuhmpkQS8bzi2DIVNvAS1Mkz2vW5PIWJulTnmabwB56Pa4/rzztihPl8YNyVg6YvU967KcJiWgdusgAdE+Okp/Dd/dZL8BwJXEeX3AzDb02coibR60iJ2HUoIkQBZBkOGHf9gQ1VB98qA+pgikQIBkafgxvbg78D4nWseU3ctY8BUAOhlxzzpwbc+HFnKgjslSHE2ma1+KUNunhc6IDyVjS5HKiRFkTcBl281DDAaihSa9gythLXgjZQZBkZX4KmV7mVO2t0dXzGcBAwgyAJ/Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=te5Vu08ZMJ7GZmOyoImI5N+AoOcJwdTOnkMgB25KwJI=;
 b=BduCi5XVgP9H0KH8xQSiRiI1jTlhNlZBn2VWF4houRoq9S53uB6qlp5QYk1VVMsr0MfSx4KYFS08tWY2OXXVF6li9Z9DdSPubsHgStrEqY+nYQgH0qqGthG8n6EC9KBYJBBT3i7n+DUN2wtsik+9BIoCSCWMemfo4erIGcTRm2xaO//SM42uvc9DuYwTkMoCgnuxxToULvmpkpXAMKedx9jmC05etjAlrTlgjz7DDIyRGQ9Tv51FMLw8nr35witJqeI9jxWHDj87u+0vO74YgxKdyqZPDUAerw96sjci+g/7FUzSy7IGHn88cK8+mlx3CKR3wcL2VBzq6Brqj5CLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=te5Vu08ZMJ7GZmOyoImI5N+AoOcJwdTOnkMgB25KwJI=;
 b=fvV3bZyRdFPr2IapCfLDqS/EwpVaCOYTHs5+coqn5YCUDGVn2vaMv1Tzi9EPJsjevSFjA6/uWrckUWYXciwJwN9hi5fL7eXAyolVz5QQkJXQW+euykVd/LQomCzD3qOw6lWvH/Y9KiOVsiIrTmpCo0ShR3hNI4o2PIV4+/7/vu2hsaHFwbqCpJZw4i+MIhPkLFT0gQHOdTLzB5LHWWWAAPd7viwEocTcWlobq/MWPBO+JJt/+2X0CNI0Zuhq28NihwaKz7DQHma7/+dukeKMpSX7CG0+09LSW6Qzg6Q5H6nkKKNzHStPDj4q6tqhXbLNlWNDwBkS57tn9fnjSgPYxg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7241.eurprd04.prod.outlook.com (2603:10a6:102:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 09:39:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 09:39:17 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: "nicolas.bouchinet@clip-os.org" <nicolas.bouchinet@clip-os.org>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, "vbabka@suse.cz"
	<vbabka@suse.cz>, Christoph Lameter <cl@linux.com>, Pekka Enberg
	<penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim
	<iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Roman
 Gushchin <roman.gushchin@linux.dev>, Marco Elver <elver@google.com>, Andrey
 Konovalov <andreyknvl@gmail.com>, "open list:SLAB ALLOCATOR"
	<linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] mm, slub: avoid zeroing kmalloc redzone
Thread-Topic: [RFC] mm, slub: avoid zeroing kmalloc redzone
Thread-Index: AQHa8gGWinar1Pei+U6GeY3CGBokXrIuTpkAgAABMHA=
Date: Mon, 19 Aug 2024 09:39:16 +0000
Message-ID:
 <PAXPR04MB845979EA35B856D10A017BEA888C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240819064115.385086-1-peng.fan@oss.nxp.com>
 <CAB=+i9Rqp93+V4r6deAjKCmQE+h4QAXqU3S=ZdbiuYOqMwY_3g@mail.gmail.com>
In-Reply-To:
 <CAB=+i9Rqp93+V4r6deAjKCmQE+h4QAXqU3S=ZdbiuYOqMwY_3g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PR3PR04MB7241:EE_
x-ms-office365-filtering-correlation-id: 53107368-b2bf-4bf0-d4a0-08dcc032cb33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NmsxSUhLcVUzai9RTHZRY3g5MHpRZ1Q2RjNOcUs1cGJXZUVabEVOaU5VTTdn?=
 =?utf-8?B?b24zemtIUXFncHFHQWlBcWtMVHpZenNnSkF3eVhzRXRqYnJmS21nOEQwNVBI?=
 =?utf-8?B?c09EZHlsTSthamsyZlVtTFJ5akVESm05d0ZaWnBHZmZJL0hBVGMxZllpbExy?=
 =?utf-8?B?emQ5MjBDVURaSjlPREIwSDk2Q1lrMk54N0hqTGpobDRaQzcvbVVwbklweXEx?=
 =?utf-8?B?TFBsMmdXSTZZcFVHU1RKTWxnZU9SL0kvR0p2UVBONElVWC91UDFLdW1KYjE2?=
 =?utf-8?B?VmYxMHBGcVppbDkvMU85c1VhaVlTV21KRnp4c0YyMXNCb1V3cWczNllnRjIv?=
 =?utf-8?B?Wnk3U0dKK25RZC9tNURRNWdDTW1sSHZOYUpkdFFydzNRUkRaL0NFcnAyaGtB?=
 =?utf-8?B?cmQ4a2NUbENwREZ0UDVSSGxTMityVGdBbGxKanpWb09tTFdLdldLSWZCRjJZ?=
 =?utf-8?B?RmdOYkJQSGZUUnczQWZVZzJVQkpOU2JLYmRuL3BMS09zclRTU2RVdklMY0RQ?=
 =?utf-8?B?Qnk5SlFudmwrVjFYRGNMc0Z2bzhOZ05HQ3B4R1IyNUdudTNLaGcwOXFhM0Zq?=
 =?utf-8?B?clpmcmJrN05jV1doMFdRM0hCTDNQbHhOd1FLUHpGR05BVlBpc3NHSG5EbXFZ?=
 =?utf-8?B?dCtiLzlFc3JLT2cvUmttTm5HYTJ4SUNCTG5Ea25JVWRWcjVvaGNEblQ0MlVK?=
 =?utf-8?B?d0hVY0ZwR1QvcTB6NWFveldFcnk4SCt1TlVIYUhnRGpIZGxYc0tlMnE1VWtC?=
 =?utf-8?B?UU96WDBXVTNyN21MRm9GQkd0TjJuTzF1Q2J4T0p1UTR5L3g3N0RTdG1jU1VP?=
 =?utf-8?B?RndsaWJhZTJhRXhxRFNhWFAyWEFsZTY1eWF3bm1zbzZMZjdoK0MzUXp4SUVs?=
 =?utf-8?B?Q1VFRHZ4Mi9BM2Fwb0lvaTBTaFlRYldTdU81ZzBUM3RaS0JaZ21tNnFreGlr?=
 =?utf-8?B?ZDI3b2p1S1AyS0hHS095MFIrck9jbTZ1Nkp1ZTFJMmxTejlXNUZsdUJmU0hH?=
 =?utf-8?B?SzFDNEpSTVY1WG5Ya3Jmc3pJYU9YUEhUdVhTd3dxOGVSRHJTcVNqeDh3UEUr?=
 =?utf-8?B?VlBtMk5mTWxTTzhrRmhCV3V0bUlIajlwUEc4Z0xQRnlCSkYzTC8vSHZCdnMr?=
 =?utf-8?B?NTgzMVdXSXhkMzZreWRNOHN4amVpTGlNNVlUaVpNYlJkSW83dEJ4SlZHeklC?=
 =?utf-8?B?VjZ1RDhJeDJPZWJLR3FncTFSL2NHdFFobi92YnlrOTA1T3FTOGJseWF1YnhT?=
 =?utf-8?B?anRUUU9TRm42TXdydzRneXBqa1o2Q3pyb3BORktXRnJybUJmaHd3VHM0YStG?=
 =?utf-8?B?R2hmU3RxUEFCUlIyb3d6Q2VocUkwS2xKZjI0bFZkbWJITGRjVEVyU1hKczFH?=
 =?utf-8?B?OGZwV1BCeDdubU5DWWYwOEprS2VVVE1DaE0vSmNVWXNxRHZCYmkxemg5NzZV?=
 =?utf-8?B?YXpNR0pxSkRneXFkQ00yLy9FRG1oeU9KTmVOTmxXR20rVDNnK1ZzMzhFQnQv?=
 =?utf-8?B?REp3cEVyZUNVdXlGclpWV3JhZnhBaWFWdFJHNlJrdTBwbUpJL0hZWUx4NWZZ?=
 =?utf-8?B?NHF2UzM2Ujk5WkE5Wm4wNStjWXlIVXR3bGY1Q3NHQnlrUzdlRHlSYVNjcHBh?=
 =?utf-8?B?N0wyVnZNWXQyRmVCOVNFbGYzUC9ha2U1TWNXWUc2STEzLzcvL21hOHg4MGR2?=
 =?utf-8?B?TlhSdFNqZTg4OFYyVSs3QUdidndwTjN1MTl5dFg1UngyWk52WXhFZTZRWjRI?=
 =?utf-8?B?M2MxRnhEalJEMEVJdEw0TWhZUUVQTUE0bnh0TENFL0RwK1ltNENJVHpSbUg5?=
 =?utf-8?B?MFJZRFpsbnpKem5kdkZtdkhrZlo3SjJ5RFFXUGFhRVFQL3dqQWVEbktNNmpu?=
 =?utf-8?B?eE1wYnZpVkFvOVZ2NlAzaWowRkdUOE1HdTlpRzBtbUExbEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a2EwdEc3WllMMXlPMi81YTNTVEtiWEFpWXpQN0FVMmdUOFdlOXJSOWluVHFk?=
 =?utf-8?B?R2orOFl2YVhqSXcwY0xJL09ZZkludFlWWGUxRXdCSGtPL3d5cXNDZDFBbUVY?=
 =?utf-8?B?cXRBT0hIbUVKUGp4dHlnendHeWwwM1U3VXpFTVIzNGFxSU1NMzM5aVRyejYw?=
 =?utf-8?B?OGZINTduamxpTERvLzJjTk15NDZWZ3k2SEhud2hJa201QjJZKzFGZ0gzNUk4?=
 =?utf-8?B?eTVEbmcxdzVsUDBtYTR1T1I3cmw3Wk9BbXA4K0hjQzYyQzdPSEtHQzZzajUr?=
 =?utf-8?B?UmR6MW1uei96bFIwVGdIQkRPS2VXL1hjYWljOUovcEZPODEwQ1J4ZmsyVU1q?=
 =?utf-8?B?RnlKL0RVa3R5aUhYd2ZKSCs0Uy95aEJvUCtPUldzWERoMnh6dG5TKzNYUU9r?=
 =?utf-8?B?TjJITDByUXk0cmVnOHpab2MrWjlUNk41TWc5V2Y5M2R4Q3dwZ1NnUVRNb2pM?=
 =?utf-8?B?ZE43QmowM0NvSjlydHJKRWhrT01QMkVzd0xWUDh6WVBqWm9IaEc1SjVJOWJW?=
 =?utf-8?B?MW5kOHdyQkNEZVQ1SytVRWtsZ3BsK2hGLzlMcmRXWmVmNUw4MGV3VGpxWmdu?=
 =?utf-8?B?d0ZiRHg1WG5Rc0M5S1NZUmMrRlZOWFFsZUw2aEFzWjBSM0k5eWF0WCtxT1Vj?=
 =?utf-8?B?cE4xS0hRbTAwSnptK2prY1Q4OStodWFoMTdobmVGQklxN1Rsbmgrdkl6V3VL?=
 =?utf-8?B?am54eHRqUVBNbGV1VWtRTFBGOHlJbTV6SFRFTkpRZnBJT2V1MzVQSHcyb3lz?=
 =?utf-8?B?VHVsWllCWmk0cFYyUUhCL29hRjVKNzhjM1RFMGhDcS9kNjNhZlQxTmtYQ0lV?=
 =?utf-8?B?azRNTDN5eXhaMlVaTTloS1ZOL3FLWTVueXlRNGI4dDlleXMrcU53NDBLc1VK?=
 =?utf-8?B?UEVpLzd3a1JBTlVvc0NsK2lpVER2N1RYbFAxYnFGSmZJOEJqWmxzMzdkMlYy?=
 =?utf-8?B?bm9CTnBNRjZqUFIvSzk3WnlVWmJadjV1MkFsdVp5aEJGeks1dXRLYmJ3bmpq?=
 =?utf-8?B?Y3pXQWZ5NkZML0VsTGFTeHc2Y3ZMYlVya3MvRk43YnNZT3F4cENleEZEV0x6?=
 =?utf-8?B?QmZIQTFTbE1RV3FzL25PN3haV0FlSTM4ZDI1NXh1ZXJ5WjJ2eHZHUGVyMFBu?=
 =?utf-8?B?Zzg5eW5ySlVBaGExSWRUT1ZpeTgzQm80MFcwY2YzZE1xTDBUVElCeEMweG9H?=
 =?utf-8?B?MHdYSlY3VGpqM0k2ZmYvSnpDdDlidjNZSWlBdFRDaGpYS2dkRm85L3pJaDdB?=
 =?utf-8?B?aFg3dGI0dTF1RzlmQStaT2tBVUVZMFp2YTRtV1RlYVhGYVFwWVJia3hhZlZG?=
 =?utf-8?B?WFJGN3BwTVEyem5Dejk1QnkreTRFMXlBWHNuODVSbFBScTZrRHhBMkpCZ3dY?=
 =?utf-8?B?d2pxTkxxR0tCM0NTT3cyQ1NWbnFoeENGTTVVWGg1TkQwVWMzS2dYVmxRZXlC?=
 =?utf-8?B?VnU4blc3K01lMHQ3QklFQVFhc3I4MDRDMDE1S0N2V1JlQ2lFbmYwbGpRdnVl?=
 =?utf-8?B?VmJ2MjdCR253Tjh2dnZXTGY0WlAyVlgzb2tHVmdpWEpqSk5PR0hZSlVZVEd6?=
 =?utf-8?B?RHRkTzdvYVRIY2F1RzhwM05HTXZMdHVlRTVvT0hhamRqeDlqOGo2SXlsYmFt?=
 =?utf-8?B?TGpZZkF4MVVrU20zSzdQRWxxMzdRMzIyMVNpM2w3YjRVYUZoUlRGV3FnNE9m?=
 =?utf-8?B?WDROQTY3ZGxra0VxK2VnVWNxWTZXZ3BCZzVEdWpEYkk5UDRvSVZ3Q1lGY29D?=
 =?utf-8?B?UlRwUGFua0xCTGFheEpVdEd1Vk12djlrais1WjVDWlBIUUZOeWx1V3FScXRw?=
 =?utf-8?B?TElhVytWNVZGdjJPR0ZXK3oyeTYybm53TDAzMnR3WWVTb0szWldHQXBMWVM0?=
 =?utf-8?B?TThBNUVSREhSeUVMN1RYTmxHZ21Famx4UWF6YnhnYU9oblFZUi9XcW44RWVO?=
 =?utf-8?B?RmFQU0ZaSmNIMmVZSFJzbHg3eG9raFpKbFJER0ZDS2FMdmRNUDZqUG9YNkVr?=
 =?utf-8?B?NTdjR2ZHUE50am9QSnVyc21KNHQwaWcrU2xJVVJsRzJXMGx3S2ZuR21vUnkr?=
 =?utf-8?B?R0JaQmhNWHREdlM0NzFBRWtiL3V0bmpzTlBKRldGQ1prak1Tb0VXMCt3TnFp?=
 =?utf-8?Q?cPMI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53107368-b2bf-4bf0-d4a0-08dcc032cb33
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 09:39:16.9423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7a7XuyyjAnb3jqXXG/SvLuFXpVtaDOEJDLuI238e+NG3RbGF5NBlqbtS53Q73l6uan+srDy4JxB8j0KzK9Aw5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7241

SGkgSHllb25nZ29uLA0KDQpUaGFua3MgZm9yIHlvdXIgcXVpY2sgcmVwbHkuDQoNCj4gU3ViamVj
dDogUmU6IFtSRkNdIG1tLCBzbHViOiBhdm9pZCB6ZXJvaW5nIGttYWxsb2MgcmVkem9uZQ0KPiAN
Cj4gT24gTW9uLCBBdWcgMTksIDIwMjQgYXQgMzozMuKAr1BNIFBlbmcgRmFuIChPU1MpDQo+IDxw
ZW5nLmZhbkBvc3MubnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBQZW5nIEZhbiA8cGVu
Zy5mYW5AbnhwLmNvbT4NCj4gPg0KPiA+IFdpdGggInNsdWJfZGVidWc9RlVaIGluaXRfb25fZnJl
ZT0xIGxvZ2xldmVsPTciIHNldCBpbiBib290YXJncyBhbmQNCj4gPiBDT05GSUdfU0xBQl9GUkVF
TElTVF9IQVJERU5FRCBpcyBzZXQuIFRoZXJlIGlzIGtlcm5lbCBkdW1wOg0KPiA+IFsgICAgMC4w
MDAwMDBdDQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQ0KPiA9PT09PT09PT09PT09PT09PQ0KPiA+IFsgICAgMC4wMDAwMDBdIEJV
RyBrbWFsbG9jLTggKE5vdCB0YWludGVkKToga21hbGxvYyBSZWR6b25lDQo+IG92ZXJ3cml0dGVu
DQo+ID4gWyAgICAwLjAwMDAwMF0gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiBbICAgIDAuMDAw
MDAwXQ0KPiA+IFsgICAgMC4wMDAwMDBdIDB4ZmZmZjAwMDAxMDAzMjg1OC0weGZmZmYwMDAwMTAw
MzI4NWYNCj4gQG9mZnNldD0yMTM2LiBGaXJzdCBieXRlIDB4MCBpbnN0ZWFkIG9mIDB4Y2MNCj4g
PiBbICAgIDAuMDAwMDAwXSBGSVgga21hbGxvYy04OiBSZXN0b3Jpbmcga21hbGxvYyBSZWR6b25l
DQo+IDB4ZmZmZjAwMDAxMDAzMjg1OC0weGZmZmYwMDAwMTAwMzI4NWY9MHhjYw0KPiA+IFsgICAg
MC4wMDAwMDBdIFNsYWIgMHhmZmZmZmRmZmMwNDAwYzgwIG9iamVjdHM9MzYgdXNlZD0yMw0KPiBm
cD0weGZmZmYwMDAwMTAwMzJhMTgNCj4gZmxhZ3M9MHgzZmZmZTAwMDAwMDAyMDAod29ya2luZ3Nl
dHxub2RlPTB8em9uZT0wfGxhc3RjcHVwaWQ9MHgxZg0KPiBmZmYpDQo+ID4gWyAgICAwLjAwMDAw
MF0gT2JqZWN0IDB4ZmZmZjAwMDAxMDAzMjg1OCBAb2Zmc2V0PTIxMzYNCj4gZnA9MHhmZmZmMDAw
MDEwMDMyOGM4DQo+ID4gWyAgICAwLjAwMDAwMF0NCj4gPiBbICAgIDAuMDAwMDAwXSBSZWR6b25l
ICBmZmZmMDAwMDEwMDMyODUwOiBjYyBjYyBjYyBjYyBjYyBjYyBjYw0KPiBjYyAgICAgICAgICAg
ICAgICAgICAgICAgICAgLi4uLi4uLi4NCj4gPiBbICAgIDAuMDAwMDAwXSBPYmplY3QgICBmZmZm
MDAwMDEwMDMyODU4OiBjYyBjYyBjYyBjYyBjYyBjYyBjYw0KPiBjYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgLi4uLi4uLi4NCj4gPiBbICAgIDAuMDAwMDAwXSBSZWR6b25lICBmZmZmMDAwMDEw
MDMyODYwOiBjYyBjYyBjYyBjYyBjYyBjYyBjYw0KPiBjYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgLi4uLi4uLi4NCj4gPiBbICAgIDAuMDAwMDAwXSBQYWRkaW5nICBmZmZmMDAwMDEwMDMyOGI0
OiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KPiAwMCAwMCAwMCAwMCAgICAgICAgICAgICAgLi4u
Li4uLi4uLi4uDQo+ID4gWyAgICAwLjAwMDAwMF0gQ1BVOiAwIFVJRDogMCBQSUQ6IDAgQ29tbTog
c3dhcHBlci8wIE5vdCB0YWludGVkDQo+IDYuMTEuMC1yYzMtbmV4dC0yMDI0MDgxNC0wMDAwNC1n
NjE4NDRjNTVjM2Y0ICMxNDQNCj4gPiBbICAgIDAuMDAwMDAwXSBIYXJkd2FyZSBuYW1lOiBOWFAg
aS5NWDk1IDE5WDE5IGJvYXJkIChEVCkNCj4gPiBbICAgIDAuMDAwMDAwXSBDYWxsIHRyYWNlOg0K
PiA+IFsgICAgMC4wMDAwMDBdICBkdW1wX2JhY2t0cmFjZSsweDkwLzB4ZTgNCj4gPiBbICAgIDAu
MDAwMDAwXSAgc2hvd19zdGFjaysweDE4LzB4MjQNCj4gPiBbICAgIDAuMDAwMDAwXSAgZHVtcF9z
dGFja19sdmwrMHg3NC8weDhjDQo+ID4gWyAgICAwLjAwMDAwMF0gIGR1bXBfc3RhY2srMHgxOC8w
eDI0DQo+ID4gWyAgICAwLjAwMDAwMF0gIHByaW50X3RyYWlsZXIrMHgxNTAvMHgyMTgNCj4gPiBb
ICAgIDAuMDAwMDAwXSAgY2hlY2tfb2JqZWN0KzB4ZTQvMHg0NTQNCj4gPiBbICAgIDAuMDAwMDAw
XSAgZnJlZV90b19wYXJ0aWFsX2xpc3QrMHgyZjgvMHg1ZWMNCj4gPg0KPiA+IEl0IGlzIGJlY2F1
c2UgdGhlIGttYWxsb2MgcmVkem9uZSBhcmVhIGlzIGNsZWFyZWQgb3Igb3JpZ19zaXplIGlzDQo+
ID4gY2xlYXJlZC4NCj4gDQo+IFNldHRpbmcgb3JpZ19zaXplIHRyZWF0cyB0aGUgd2FzdGVkIHNw
YWNlIChvYmplY3Rfc2l6ZSAtIG9yaWdfc2l6ZSkgYXMNCj4gcmVkem9uZXMuIChpbiBjaGVja19v
YmplY3QoKSkgV2hlbiBvcmlnX3NpemUgaXMgc2V0IHRvIHplcm8sIHRoZSBlbnRpcmUNCj4gb2Jq
ZWN0IGlzIHBlcmNlaXZlZCBhcyBhIHJlZHpvbmUuDQo+IENvdWxkIHlvdSBlbGFib3JhdGUgdGhl
IGV4cGxhbmF0aW9uIGluIHRoZSBkZXNjcmlwdGlvbj8NCg0KUXVvdGUgeW91ciByZXBseSBoZXJl
LiBIb3BlIHRoZSBmb2xsb3dpbmcgaXMgZ29vZDoNCiINCldpdGggY29tbWl0IDk0NmZhMGRiZjJk
OA0KKCJtbS9zbHViOiBleHRlbmQgcmVkem9uZSBjaGVjayB0byBleHRyYSBhbGxvY2F0ZWQga21h
bGxvYyBzcGFjZSB0aGFuIHJlcXVlc3RlZCIpLA0Kc2V0dGluZyBvcmlnX3NpemUgdHJlYXRzIHRo
ZSB3YXN0ZWQgc3BhY2UgKG9iamVjdF9zaXplIC0gb3JpZ19zaXplKSBhcw0KcmVkem9uZXMuIEJ1
dCAoaW4gY2hlY2tfb2JqZWN0KCkpIFdoZW4gb3JpZ19zaXplIGlzIHNldCB0byB6ZXJvLCB0aGUg
ZW50aXJlDQpvYmplY3QgaXMgcGVyY2VpdmVkIGFzIGEgcmVkem9uZS4gVG8gYSB2YWxpZCBhbGxv
Y2F0ZWQga21hbGxvYyBzcGFjZSwNCndoZW4gaW5pdF9vbl9mcmVlPTEsIHRoZSB3YXN0ZWQgc3Bh
Y2UgYW5kIHRoZSBvcmlnX3NpemUgc2hvdWxkDQpub3QgYmUgY2xlYXJlZCB0byAwLCBvdGhlcndp
c2UgdGhlcmUgd2lsbCBiZSBrZXJuZWwgZHVtcDoNCg0KW2tlcm5lbCBkdW1wIGhlcmVdDQoNClRv
IGFkZHJlc3MgdGhlIGlzc3VlLCB1c2Ugb3JpZ19zaXplIHRvIGNsZWFyIHRoZSB1c2VkIGFyZWEu
IEFuZCByZXN0b3JlDQp0aGUgdmFsdWUgb2Ygb3JpZ19zaXplIGFmdGVyIGNsZWFyIHRoZSByZW1h
aW5pbmcgYXJlYS4NCiINCg0KPiANCj4gPiBXaGVuIHMtPm9iamVjdF9zaXplIGlzIGxhcmdlciB0
aGFuIG9yaWdfc2l6ZSwganVzdCBjbGVhciB0aGUgb3JpZ19zaXplDQo+ID4gYXJlYS4gQW5kIHJl
c3RvcmUgdGhlIHZhbHVlIG9mIG9yaWdfc2l6ZS4NCj4gPg0KPiA+IEZpeGVzOiBkNTdhOTY0ZTA5
YzIgKCJrYXNhbiwgbW06IGludGVncmF0ZSBzbGFiIGluaXRfb25fZnJlZSB3aXRoDQo+ID4gSFdf
VEFHUyIpDQo+IA0KPiBJIHRoaW5rIHRoZSBwcm9wZXIgJ0ZpeGVzJyBjb21taXQgc2hvdWxkIGJl
IDk0NmZhMGRiZjJkOCAoIm1tL3NsdWI6DQo+IGV4dGVuZCByZWR6b25lIGNoZWNrIHRvIGV4dHJh
IGFsbG9jYXRlZCBrbWFsbG9jIHNwYWNlIHRoYW4gcmVxdWVzdGVkIikNCj4gYmVjYXVzZSBpdCBp
cyB0aGUgY29tbWl0IHRoYXQgZXh0ZW5kcyByZWR6b25lIGNoZWNrLCBidXQgZGlkIG5vdA0KPiBh
ZGRyZXNzIGluaXRfb25fZnJlZT0xIGNhc2UuDQoNClllYWguIEkgd2lsbCBjb3JyZWN0IGluIHYy
Lg0KDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0K
PiA+IC0tLQ0KPiA+ICBtbS9zbHViLmMgfCAxMiArKysrKysrKysrLS0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvbW0vc2x1Yi5jIGIvbW0vc2x1Yi5jDQo+ID4gaW5kZXggOTRmNWE0MTQzODI1Li5kMDM5
NTdkMTViYmYgMTAwNjQ0DQo+ID4gLS0tIGEvbW0vc2x1Yi5jDQo+ID4gKysrIGIvbW0vc2x1Yi5j
DQo+ID4gQEAgLTIyODIsMTQgKzIyODIsMjIgQEAgYm9vbCBzbGFiX2ZyZWVfaG9vayhzdHJ1Y3QN
Cj4ga21lbV9jYWNoZSAqcywgdm9pZCAqeCwgYm9vbCBpbml0LA0KPiA+ICAgICAgICAgICovDQo+
ID4gICAgICAgICBpZiAodW5saWtlbHkoaW5pdCkpIHsNCj4gPiAgICAgICAgICAgICAgICAgaW50
IHJzaXplOw0KPiA+IC0gICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgaW51c2U7DQo+ID4gKyAg
ICAgICAgICAgICAgIHVuc2lnbmVkIGludCBpbnVzZSwgb3JpZ19zaXplOw0KPiA+DQo+ID4gICAg
ICAgICAgICAgICAgIGludXNlID0gZ2V0X2luZm9fZW5kKHMpOw0KPiA+ICsgICAgICAgICAgICAg
ICBvcmlnX3NpemUgPSBnZXRfb3JpZ19zaXplKHMsIHgpOw0KPiA+ICAgICAgICAgICAgICAgICBp
ZiAoIWthc2FuX2hhc19pbnRlZ3JhdGVkX2luaXQoKSkNCj4gPiAtICAgICAgICAgICAgICAgICAg
ICAgICBtZW1zZXQoa2FzYW5fcmVzZXRfdGFnKHgpLCAwLCBzLT5vYmplY3Rfc2l6ZSk7DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgbWVtc2V0KGthc2FuX3Jlc2V0X3RhZyh4KSwgMCwNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcy0+b2JqZWN0X3NpemUgPiBvcmlnX3Np
emUgPyBvcmlnX3NpemUNCj4gPiArIDogcy0+b2JqZWN0X3NpemUpOw0KPiANCj4gdGhlIHNpemUg
Y2FuIHNpbXBseSBiZSBvcmlnX3NpemUsIGFzIG9yaWdfc2l6ZSByZXR1cm5zIG9iamVjdF9zaXpl
IHdoZW4gaXQNCj4gaXMgbm90IGVuYWJsZWQgYW5kIG9yaWdfc2l6ZSBjYW4gbmV2ZXIgYmUgYmln
Z2VyIHRoYW4gb2JqZWN0X3NpemUuDQoNCkZpeCBpbiB2MjogIm1lbXNldChrYXNhbl9yZXNldF90
YWcoeCksIDAsIG9yaWcpOyINCg0KPiANCj4gPiAgICAgICAgICAgICAgICAgcnNpemUgPSAocy0+
ZmxhZ3MgJiBTTEFCX1JFRF9aT05FKSA/IHMtPnJlZF9sZWZ0X3BhZCA6IDA7DQo+ID4gICAgICAg
ICAgICAgICAgIG1lbXNldCgoY2hhciAqKWthc2FuX3Jlc2V0X3RhZyh4KSArIGludXNlLCAwLA0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgcy0+c2l6ZSAtIGludXNlIC0gcnNpemUpOw0KPiA+
ICsgICAgICAgICAgICAgICAvKg0KPiA+ICsgICAgICAgICAgICAgICAgKiBSZXN0b3JlIG9yaWdf
c2l6ZSwgb3RoZXJ3aXplIGttYWxsb2MgcmVkem9uZSBvdmVyd3JpdHRlbg0KPiA+ICsgICAgICAg
ICAgICAgICAgKiB3b3VsZCBiZSByZXBvcnRlZA0KPiA+ICsgICAgICAgICAgICAgICAgKi8NCj4g
PiArICAgICAgICAgICAgICAgc2V0X29yaWdfc2l6ZShzLCB4LCBvcmlnX3NpemUpOw0KDQpUaGFu
a3MgZm9yIGhlbHAgcmV2aWV3aW5nLg0KDQpUaGFua3MsDQpQZW5nLg0K


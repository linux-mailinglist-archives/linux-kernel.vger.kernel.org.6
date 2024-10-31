Return-Path: <linux-kernel+bounces-390256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FC69B7791
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 719D5B25F73
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4AD194C65;
	Thu, 31 Oct 2024 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="OrxEQj7j"
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3625F131BDD;
	Thu, 31 Oct 2024 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367230; cv=fail; b=pX/DtDKnU+SM5+WcUaFnDqwdby2k3d5Mm4VjQ1FeaPTQ6SX5sGlrIqy+lRnixGSlnvOcETOVr9Ji1CBWWswbvnyO5cSiNr0WYRrcKVJhWc+djxZ7fd/QHuRF9eXaciZA8U9bSEgazwBK9vahN2qNgCjYf2PNp3p1VnLiherZpx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367230; c=relaxed/simple;
	bh=odirOFD/doXhbKFsPU/bxrXZ0WAeMTY8B13NlJDnb4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uBw0F9aSeF3Ybew43QrWv7OT9Jq/lRKKsyLNIQy1944HbX+FwIcN7vbl30eOMy/XtsD6Q5L4R0axEtWWJ63+e4CTzesopYeZJrJQGYsSRBlFUVtSBfjslzVQ2Nl7xx80HOaZ5XtD63kv83l9AbtjHRN1FgPkSh/AE164F/Njf+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=OrxEQj7j; arc=fail smtp.client-ip=68.232.159.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1730367228; x=1761903228;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=odirOFD/doXhbKFsPU/bxrXZ0WAeMTY8B13NlJDnb4I=;
  b=OrxEQj7jw2e1m3aUEO9M9VMxgSf+61kJehK+StBle39lLUvHbv9OQlIX
   d57ftWgjihNUgtyqTcjqGI2FTNUtqzbMqYAY+uvga+/jdbgI/RqV1dnyH
   GR1snuGSQGMvgCxnYdAq4HojluRl8AkwxWND5cTsxtz69fKP41WrHFVzu
   Ku++BjS4x0zoBRMiWBXkUnVDeIOTblufxBPHCGpufUlLbjEOLHrd8uzmS
   dyuDUdaVpsOF2WfoAqhitCXs+AG+r+TfH/R95dRufn6Kn+lKR25ngih/2
   3zGEdF95MkU2VSbKYyDgaK9IY1GbUkpED4vaxXspPmaKfiP9YHq69SGnc
   g==;
X-CSE-ConnectionGUID: JahGn+mRT2eClL+Btug24w==
X-CSE-MsgGUID: 37DVrOzMQfOlIlLy5++hZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="135456190"
X-IronPort-AV: E=Sophos;i="6.11,247,1725289200"; 
   d="scan'208";a="135456190"
Received: from mail-japaneastazlp17010001.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.1])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 18:33:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDFnjC70VgsiPhpdbE2mlP2R5xxxeEvAz5UZxWCbucVwMIXu+SCHDd3XrIY9GPa6UuNQW9c5VSVj/Sskn1w3P09AlQGTj8REBRJ7fxoP8pfgvkyHihmBwjci9Nf+gkQ3yxJcctgT5RYrL8WPeN6a/j8Nd/dl1a7RThm/7cbVNUjoTLQP5P3d+Wp+mtAxDtUbZe0Eo6Dzs58ZsXR3sQXKpQ5Bzsj/uNuL4zS/aR47+Z3DX/TZqWtToHG7/RePTxnbQ7UtJlybDsnwrvB0aor4GU34yaObndseDx/Nu/UByptQ/sygIsZLdq4rh3MJKD956NPaKGH8XkrKUlsyKnk9LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odirOFD/doXhbKFsPU/bxrXZ0WAeMTY8B13NlJDnb4I=;
 b=WgVGLw5y8aI4QHbuFIH5dkSu+NYLbYJv64kPFDGcNYtboJ2wCRArf6XRZHF2UKz+YmYx1ILM/PHDNUEEB3SvaoEIk0CZz3xi6pqQb+9lpKmux5+RGb+tdYD+kxoa+3WbUR6XbG+9MRcc7dd93Vhr3zjihNg5A04B9GjOkBmJXg+J2GS0mZPTip6PjHCxIGXYEWLZe+TvmNZSDf79mG7TY/ehxeG9UaK+BFlftg3sWcVTuZ5EFic51DJiHaVfjbTe0YFn18PoLtu9T2CnP69Nz9HkfX5nD2FbKgQhaVsqmfEF5eYrhcUvY+3qLykYdnULs7jvMjrK9lYtQ2cQIPt/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS9PR01MB12405.jpnprd01.prod.outlook.com (2603:1096:604:2e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 09:33:34 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%7]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 09:33:34 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Huaisheng Ye <huaisheng.ye@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pei.p.jia@intel.com" <pei.p.jia@intel.com>
Subject: Re: [PATCH] [RFC] cxl/region: Fix region creation for greater than x2
 switches
Thread-Topic: [PATCH] [RFC] cxl/region: Fix region creation for greater than
 x2 switches
Thread-Index: AQHbKEYAvwAIVAYCJEGZNG9ufcBR5rKgn1uA
Date: Thu, 31 Oct 2024 09:33:34 +0000
Message-ID: <80415a29-14dd-4108-aa02-4b0b5e1f2baf@fujitsu.com>
References: <20241027075717.3714821-1-huaisheng.ye@intel.com>
In-Reply-To: <20241027075717.3714821-1-huaisheng.ye@intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS9PR01MB12405:EE_
x-ms-office365-filtering-correlation-id: 377a8935-6ace-4eac-6104-08dcf98f1769
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?aUtzYWFhbnZPL1BmWm1vVzArVElkT09DcUV2MytJVEMrNU1KWE45WmR4R0ta?=
 =?utf-8?B?bHlTeldPaUhXd252UCtEOHN5YWpPYmNsaURMeGhXK0pEekZVVkRBUXNxY2Y0?=
 =?utf-8?B?S3NtQkxIVWYyb0NOZTFIeVlmZTRSSFNub3loSUxFWFVWZHQxMTlIQi8reVlM?=
 =?utf-8?B?ZUFpVkErRVBnQ3pzOGpUbWkwU0NvYmp0eUdGNHpBTUJSR2I5RWhKTGtlNTUz?=
 =?utf-8?B?V0JSSUIvOTg1cHp6MmhxRDRYaWhuSmNrZlFmVHgzbW9RSkRhaWdmZTkzWHFU?=
 =?utf-8?B?NFllUmxBVHZwb1h1Wm9nUHpRNjh2YUs1RHdUdmpIR3Rkdll5d1RDYjVGQUpD?=
 =?utf-8?B?L09SOFRRdUdaWGk1cHAxYXN5VkNZL3I4NXVDbHM3aHNPTjVjRzkzVkU0SGRk?=
 =?utf-8?B?TGhBUEtEa3ppQjRzdllSMHFmUFZUYkJHaUVIbGxOclNpc1ZITGZidi9ZUGhE?=
 =?utf-8?B?SG0rM2ExcFphNnB5dlc0eis4WVVGZDY2UjUxNzRxYk4zSXJ3bVYwNzV4RDl1?=
 =?utf-8?B?bG5rbHBwb3lZaWxHRmhIc0hVWHdaT0ltU2QycFpFTWlvdzYzaEtEbVhGcURH?=
 =?utf-8?B?bnd1VzY5ekZPR0EvMWVMa2I0VkZpYkpZSWFZU0puUUlkOVBuMlU2SlVKOFpY?=
 =?utf-8?B?em9qMFMzdDNMaWpwcllqSEF4dWQ4bjYzTVpPQ0dxLzNGSERodGx5WUloUTRl?=
 =?utf-8?B?ZDNjZUpPUEtqTzFOd2xjU0NRM25sRG15ZTNtSmJIb3lsaVFvVkh0ODZ4MGw1?=
 =?utf-8?B?Mm5Ma1BFTzlRK3cyYXRSNGYrU1Nxa1pVQXZsMlM2d0pyOUp5MjR2RlZIMW9v?=
 =?utf-8?B?Uk5naXRETXN4VWcwTEMva1QvNXNjTk1mK1NCbTUxOS9qNTRPWCswdktSVnhi?=
 =?utf-8?B?YlpjczlnTGRDZHE2dHhId0NYeGZXMUJqK3FJZ0tjeVoyUElrbXhlQVhHc3F1?=
 =?utf-8?B?eUxSbC9ONXFvLzN4T2xDeWdPQkJYWm9zY3d5akpWYjF2S2pMWTREU2RBMW9H?=
 =?utf-8?B?Q2pQWmJHZ3NxY0NHa2V5U295YWtBZUZqdnhZNXQyYWdvTlhCdzZoYVRpYkFq?=
 =?utf-8?B?V1NUQURxUENqUktqN3hBYTMyQW1FRWFQbTQ3eXNwZzVhaWZBZ1R0KzhhQXhP?=
 =?utf-8?B?cjEvRFNiUWhuNWRZZ09VaVRVbnQzSlJKaG14NGxpcjNsd1V4Witab0lYamxz?=
 =?utf-8?B?ZmIyNUMwc2dUYjBTZ1VnaFplSmRzUnRCUUFKTVMyeUkydy9jUlROSGR0OW1h?=
 =?utf-8?B?bDdUalFDd1Radk4zN09SdUNKUnNsd01oeG14NTl1dHBkZXhUYUhRM0p4SmpV?=
 =?utf-8?B?YnlDZ1dzVWFYbGRndHZESFVtSzRNSFkwWVRFWmdCbW5KYXFlMmRUamNUYTVo?=
 =?utf-8?B?alpxZitxYTNlY0xvRm5jcFFxVmRLK2taR1RBUHAxSkFPeXNYbW52V3YrMTll?=
 =?utf-8?B?SDQzYUNVV3RwSHBVZms0YzZrTWh4OVVmQjUyZzMyZk1haVVwV3RNMWJNM28y?=
 =?utf-8?B?SU1PeTZpWTYxS0luanV0Z2hETVpuaVpOTVlJWG4wNjJSbFlSWHBoZlo3dGJO?=
 =?utf-8?B?UjNZV09NaTFIdW9lUHNndm0yMHV1WnhYSEpyWCtQMGt4SnJVOUNZc0R4N1h5?=
 =?utf-8?B?R1FIWmF1K0xPUG82TlQwM0QvR1hZYkpWSUNUTDRkTWcreHNUcDVVVHJWZUxv?=
 =?utf-8?B?Wm91UTNoVVF1OUdyMlB6bzdhNUtUakdIL0pVZ1dqNm9VbVU3VEJVSHh3OWZO?=
 =?utf-8?B?ZXlPT2R2S2M5TnlFNjRPWnA0L3ZsS1I2WGV0ZUpsa1B5MDI4QlNjcnMxU0Z0?=
 =?utf-8?B?enk2ZmZ3aElnQTNMQjlpUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVhFcFFYUkNiSHFqMkt4RFUwd3RtQ0Zwak81a0YxZmpncE14YkxiVnpLWEdV?=
 =?utf-8?B?WnFMRlVLN0FUeEdBOU9VSHVyenRnL2dqcy93UnIrR2JWaDZOOTVUZW9RTUR3?=
 =?utf-8?B?bEFnUVFRVnYyODl6M0kwUitZYnpEd2RieE5SVDlkYnE5cVJtOVlLQ0U5aXdE?=
 =?utf-8?B?K3dDYlM5dlBpaDc5czgxd1NrSXlPZEw5d1pBaUx3WGRNQ3BTRXdYb3JhTWNM?=
 =?utf-8?B?R2c3QWl1ekhybGQrbzlMMWN2d1lJVXU0ZXRaUjNnbkZuazFZSU1XamJhbmMz?=
 =?utf-8?B?bzYzdHFUUzFXMnRzRkFLbXF4bEE5V0tvVDhacWx1S2g0aU13RjVGcWNlTTRt?=
 =?utf-8?B?NFpSUE1MQkZoSXJmcithbEJhMkxYN2l1aWt0Q1ExMzJydHh3ZjVFbW45YzVp?=
 =?utf-8?B?MzJPckpuNk1MVGVPQi92aUo1VmQ5YU1paDJ5NGpSWFJHRktSRXEzWEpkWjNG?=
 =?utf-8?B?d1dQRGZRZ3JKY3dOOXhXQXpHZXdFbUgrWWxoWFh2WjhxcDdkTjdoSFNmTm9k?=
 =?utf-8?B?eWRnc2FCb1JQdXBKSlJTSDhZM1BzSDFJQW1mdlpCVWY0OTIva1AxMFpnRWsz?=
 =?utf-8?B?V0c1YWdCVjVEaFBTTDVVWEhaakUxNWJJT2VQT1UxZ1BBbkttdWVVM2xEQWZS?=
 =?utf-8?B?cnp6ZTNXdjlDMEFraFB3NTFVdmxSalNzelh4Z2d2dHgybC92bWY2dmM0czda?=
 =?utf-8?B?QkVRdUR4bVhrSWxlVWdxOUtjTUlXcVNRTEFkYzJSangrdU1sNmZNN3FPY0ZH?=
 =?utf-8?B?TXFPN2NpS3pGSDlqR0FxY2hkWkN3azVkd2c5QVJTanJySXUzZDZxMnRpTEpr?=
 =?utf-8?B?ZGFOYVFuanVoZ0I5Q0p6VTh3a0VhN0UvT1hjU2pyUHoyM0VadEV2MG96UVlH?=
 =?utf-8?B?NGtDMlMvYWViSFVDR2xhWDhWL0JxS2t1ODhTZnZwQ2Mrelp5VEJ6MjR2eFNF?=
 =?utf-8?B?ZTlmUE5qOGFxdThTSzV5dmo3UGo0T2VaV3pYRGNMR2cxNFp1djlnQlg4a1Z5?=
 =?utf-8?B?S2VvSVhPNjFFNzJuMUMxZFVwOHdjVXJTSEorc0VVc21pMkhKV1VTa1l0by9k?=
 =?utf-8?B?RkRUd2NTd01JOUtOV283MUx0R3Y3eDIvUDFlelIycjIyWEtNb1ZRKy9LRGlj?=
 =?utf-8?B?anpqa3A2TDdPS2ZnREt3SlJzRHgxZlBFUHBwcmxWTU1hQk5NVWF6eHNENEg1?=
 =?utf-8?B?TGNMYVFGMnBoc1RnK1U0Z1B1K1M0Y3V5S1Z1bTl0ZTRkYUtLN2pZY1JrZU16?=
 =?utf-8?B?UGh2QUQrYW9IRmVJR1VpeTAxSVAyZ2lzTit5azBNYzJaTWxKSUxxdmw2VlAz?=
 =?utf-8?B?QlBBaEViaS9WQmJDYTdSSExUUitLYnYxK1MvRmlyOUM2NDJ2c2FFdThYYkI5?=
 =?utf-8?B?VTJyVEJOZkJIblV0YWVmWnFob0d2eXJFQjk1eXgwVXVoMnQ4c1Y2cFl0MVAy?=
 =?utf-8?B?T1k2UE1HZVFueWo5OTVqb1I3d2hoVE12VzAxWTFndlBGNVZ2UUU5K1VKZGgr?=
 =?utf-8?B?NGZJT2Z0cWNPTnlrMUhRTlVVRkNHUG5aN2pOd09tOTJKd09YcFlTNG4xblhx?=
 =?utf-8?B?ZFlvYlVkalNxRDl2Y1QxTjh2M1JUOU0zVDRrcHc1SDFYQ3Q5Um41Qk5WRm54?=
 =?utf-8?B?ZEk4QUhsMnM5bkI2Rzd5dDRCdElNaXV6c2xoUW9lbGhsV2xjSDVEVEpkVFRr?=
 =?utf-8?B?eUpDeEJMWDVHUU1YMUZpSFJ0L1RydzRXTWc3bEw5Tis3enRZQnlWMDltcWRJ?=
 =?utf-8?B?Y3NROXRnQWMrSFhSMFErQmtBTUJWZmNKMTFybVprbzQ2UTBIcUYxYW01aTNJ?=
 =?utf-8?B?SlplaTRNT0JkZ0RtNkc0dDc0Q1l1THNUcnpXM01YWDZIWXJ6V0pBRHpxSngw?=
 =?utf-8?B?SHRpR1Y3eHlLT3MzUlFhWXBIT3lXN1RoNk8wWnpQcm0wMlJ4SmFMNytGZDdz?=
 =?utf-8?B?Rk5RaFRCR0J6Nkcrcm9oSm1MaUIzclRwQ3dBS2VpR284Uyt4aHZwb2xVdHVK?=
 =?utf-8?B?SlJhSUFENzVyNmNmNHBGRCtJSjVXOWxQS2tLY1FlNVIxMDRlUWo0d1lrMi9N?=
 =?utf-8?B?cUsxZmU1dkkrWEk0L0k0dmtXMWgyKzV5TlprU3hPa1JuRHFJNTZ5eEUySXV6?=
 =?utf-8?B?WkZRbHF2TzRVeVA2NEx6WEcwNFJ1K3A0QjVTTS9nZkRHTWJNUFh0QzZaMkg2?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C81B6339718CF8469606AAF33B64C540@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	thtIpmzmKDivkwUCG2lJRkTY1bZ3qsF3no+MHBqe45SeuONpzPHRJKLUs/H+4qVdFQInoIH6xD92Cy3chhwSiNO5GP1Ca6JSWm1LGXCtzK7pJCkd1hiM0AsqkAFHpOy3RGGrsPWkTFkNRDIeXURy0MLOQyodbcoH9S3yl7kA/td5N7DWaeY3zfN2ljd0cOuuZVSYTI8ST1HWW27+Ro7gV009BDbHED3W1bmnKECLxXxIwaIb1lrhFDY2wU9+a6NONmscjXGQtXlsRsOOSB+IK3aJJLwnUcd+uNnSR3+ohcx4KM/RfH7tM84ubloRabCw1h0zJ6NK+q29T2w8/smJwXTBver/EDX7Uxik6pQxlXctCetIHQkmczmI5D7koWzpg4V33ynXNQnlahF1I+Tzn/DfD7rVqVvAKHG1Uk35kzfpyizCbtc2Ra+VRmn74PP1iTp062CbWNpdWZ90rmWrVWlhM+RUISoUdV6nriM7jqNn8aLjSoqzLM7eWhnmn69o1LJI598MkkMr7tzc+FglDNuP9rkJ5ofJW3ZrHM9n5WW+gm8FSASVrXiGyH3SNEK/oUFMJOtJzy4hw3amMsg3cQF6zefSxwJYRubBezkQ6yE0zPvJTIwwSgLvmMBx3gM/
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377a8935-6ace-4eac-6104-08dcf98f1769
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 09:33:34.8014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leyiIC/vk6mxsWgxf46z+eMEBXFtqf6KVHvQnEWP/SRISWJgYU6RWV0pYxYDuocj+jtQvsBq8gufAjV/gYcOHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12405

DQoNCk9uIDI3LzEwLzIwMjQgMTU6NTcsIEh1YWlzaGVuZyBZZSB3cm90ZToNCj4gVGhlIGN4bF9w
b3J0X3NldHVwX3RhcmdldHMoKSBhbGdvcml0aG0gZmFpbHMgdG8gaWRlbnRpZnkgdmFsaWQgdGFy
Z2V0IGxpc3QNCj4gb3JkZXJpbmcgaW4gdGhlIHByZXNlbmNlIG9mIDQtd2F5IGFuZCBhYm92ZSBz
d2l0Y2hlcyByZXN1bHRpbmcgaW4NCj4gJ2N4bCBjcmVhdGUtcmVnaW9uJyBmYWlsdXJlcyBvZiB0
aGUgZm9ybToNCj4gDQo+ICAgICMgY3hsIGNyZWF0ZS1yZWdpb24gLWQgZGVjb2RlcjAuMCAtZyAx
MDI0IC1zIDJHIC10IHJhbSAtdyA4IC1tIG1lbTQgbWVtMSBtZW02IG1lbTMgbWVtMiBtZW01IG1l
bTcgbWVtMA0KPiAgICBjeGwgcmVnaW9uOiBjcmVhdGVfcmVnaW9uOiByZWdpb24wOiBmYWlsZWQg
dG8gc2V0IHRhcmdldDcgdG8gbWVtMA0KPiAgICBjeGwgcmVnaW9uOiBjbWRfY3JlYXRlX3JlZ2lv
bjogY3JlYXRlZCAwIHJlZ2lvbnMNCj4gDQo+ICAgIFtrZXJuZWwgZGVidWcgbWVzc2FnZV0NCj4g
ICAgY2hlY2tfbGFzdF9wZWVyOjEyMTM6IGN4bCByZWdpb24wOiBwY2kwMDAwOjBjOnBvcnQxOiBj
YW5ub3QgaG9zdCBtZW02OmRlY29kZXI3LjAgYXQgMg0KPiAgICBidXNfcmVtb3ZlX2RldmljZTo1
NzQ6IGJ1czogJ2N4bCc6IHJlbW92ZSBkZXZpY2UgcmVnaW9uMA0KPiANCj4gUUVNVSBjYW4gY3Jl
YXRlIHRoaXMgZmFpbGluZyB0b3BvbG9neToNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IEFDUEkwMDE3OjAwIFtyb290MF0NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICBIQl8wIFtwb3J0MV0NCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgIC8gICAgICAgICAgICAgXA0KPiAgICAgICAgICAgICAgICAgICAgICAgUlBfMCAg
ICAgICAgICAgICBSUF8xDQo+ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAg
ICAgfA0KPiAgICAgICAgICAgICAgICAgIFVTUCBbcG9ydDJdICAgICAgICAgICBVU1AgW3BvcnQz
XQ0KPiAgICAgICAgICAgICAgLyAgICAvICAgIFwgICAgXCAgICAgICAgLyAgIC8gICAgXCAgICBc
DQo+ICAgICAgICAgICAgRFNQICAgRFNQICAgRFNQICAgRFNQICAgRFNQICBEU1AgICBEU1AgIERT
UA0KPiAgICAgICAgICAgICB8ICAgICB8ICAgICB8ICAgICB8ICAgICB8ICAgIHwgICAgIHwgICAg
fA0KPiAgICAgICAgICAgIG1lbTQgIG1lbTYgIG1lbTIgIG1lbTcgIG1lbTEgbWVtMyAgbWVtNSAg
bWVtMA0KPiAgIFBvczogICAgICAwICAgICAyICAgICA0ICAgICA2ICAgICAxICAgIDMgICAgIDUg
ICAgNw0KDQpZZWFoLCBJIHRyaWVkIHRoaXMgdG9wb2xvZ3kgbG9uZyBsb25nIGFnbywgaXQgZGlk
bid0IHdvcmsuIEF0IHRoYXQgdGltZSwgSSB0aG91Z2h0IGl0DQptaWdodCBiZSBqdXN0IGxpa2Ug
dGhhdC4gVW50aWwgcmVjZW50bHkgdGhhdCBJIHNhdyB0aGlzIFsxXSBpbiBzZWN0aW9uDQoyLjEz
LjE1LjEgUmVnaW9uIFNwYW5uaW5nIDIgSEIgUm9vdCBQb3J0cyBFeGFtcGxlIENvbmZpZ3VyYXRp
b24gQ2hlY2tzDQoNCkkgb25jZSB0cmllZCB0byB1bmRlcnN0YW5kIHdoeSB0aGUgY29kZSB1c2Vk
ICJkaXN0YW5jZSIgdG8gZGV0ZXJtaW5lIHRoZSBvcmRlciBvZiB0aGUgdGFyZ2V0LA0KYnV0IGlu
IHRoZSBlbmQsIEkgc3RpbGwgY291bGRuJ3QgZmlndXJlIGl0IG91dCAoYW5kIEkgc3RpbGwgZG9u
J3QgdW5kZXJzdGFuZCBpdCBub3cpLg0KSUlSQywgbmVpdGhlciB0aGUgQ1hMIHNwZWMgbm9yIHRo
aXMgZG9jdW1lbnQgbWVudGlvbmVkIHRoZSBrZXl3b3JkICJkaXN0YW5jZSIgYXQgYWxsLg0KDQpb
MV0gaHR0cHM6Ly9jZHJkdjItcHVibGljLmludGVsLmNvbS82NDM4MDUvNjQzODA1X0NYTF9NZW1v
cnlfRGV2aWNlX1NXX0d1aWRlX1JldjFfMS5wZGYNCg0KQW55d2F5LCBtYW55IHRoYW5rcy4NCkkg
dHJpZWQgdGhpcyBwYXRjaCwgaXQgd29ya3MgZm9yIG1lLg0KDQpUZXN0ZWQtYnk6IExpIFpoaWpp
YW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCg0KDQo+IA0KPiAgIEhCOiBIb3N0IEJyaWRnZQ0K
PiAgIFJQOiBSb290IFBvcnQNCj4gICBVU1A6IFVwc3RyZWFtIFBvcnQNCj4gICBEU1A6IERvd25z
dHJlYW0gUG9ydA0KPiANCj4gLi4ud2l0aCB0aGUgZm9sbG93aW5nIGNvbW1hbmQgc3RlcHM6DQo+
IA0KPiAkIHFlbXUtc3lzdGVtLXg4Nl82NCAtbWFjaGluZSBxMzUsY3hsPW9uLGFjY2VsPXRjZyAg
XA0KPiAgICAgICAgICAtc21wIGNwdXM9OCBcDQo+ICAgICAgICAgIC1tIDhHIFwNCj4gICAgICAg
ICAgLWhkYSAvaG9tZS93b3JrL3ZtLWltYWdlcy9jZW50b3Mtc3RyZWFtOC0wMi5xY293MiBcDQo+
ICAgICAgICAgIC1vYmplY3QgbWVtb3J5LWJhY2tlbmQtcmFtLHNpemU9NEcsaWQ9bTAgXA0KPiAg
ICAgICAgICAtb2JqZWN0IG1lbW9yeS1iYWNrZW5kLXJhbSxzaXplPTRHLGlkPW0xIFwNCj4gICAg
ICAgICAgLW9iamVjdCBtZW1vcnktYmFja2VuZC1yYW0sc2l6ZT0yRyxpZD1jeGwtbWVtMCBcDQo+
ICAgICAgICAgIC1vYmplY3QgbWVtb3J5LWJhY2tlbmQtcmFtLHNpemU9MkcsaWQ9Y3hsLW1lbTEg
XA0KPiAgICAgICAgICAtb2JqZWN0IG1lbW9yeS1iYWNrZW5kLXJhbSxzaXplPTJHLGlkPWN4bC1t
ZW0yIFwNCj4gICAgICAgICAgLW9iamVjdCBtZW1vcnktYmFja2VuZC1yYW0sc2l6ZT0yRyxpZD1j
eGwtbWVtMyBcDQo+ICAgICAgICAgIC1vYmplY3QgbWVtb3J5LWJhY2tlbmQtcmFtLHNpemU9Mkcs
aWQ9Y3hsLW1lbTQgXA0KPiAgICAgICAgICAtb2JqZWN0IG1lbW9yeS1iYWNrZW5kLXJhbSxzaXpl
PTJHLGlkPWN4bC1tZW01IFwNCj4gICAgICAgICAgLW9iamVjdCBtZW1vcnktYmFja2VuZC1yYW0s
c2l6ZT0yRyxpZD1jeGwtbWVtNiBcDQo+ICAgICAgICAgIC1vYmplY3QgbWVtb3J5LWJhY2tlbmQt
cmFtLHNpemU9MkcsaWQ9Y3hsLW1lbTcgXA0KPiAgICAgICAgICAtbnVtYSBub2RlLG1lbWRldj1t
MCxjcHVzPTAtMyxub2RlaWQ9MCBcDQo+ICAgICAgICAgIC1udW1hIG5vZGUsbWVtZGV2PW0xLGNw
dXM9NC03LG5vZGVpZD0xIFwNCj4gICAgICAgICAgLW5ldGRldiB1c2VyLGlkPW5ldDAsaG9zdGZ3
ZD10Y3A6OjIyMjItOjIyIFwNCj4gICAgICAgICAgLWRldmljZSB2aXJ0aW8tbmV0LXBjaSxuZXRk
ZXY9bmV0MCBcDQo+ICAgICAgICAgIC1kZXZpY2UgcHhiLWN4bCxidXNfbnI9MTIsYnVzPXBjaWUu
MCxpZD1jeGwuMSBcDQo+ICAgICAgICAgIC1kZXZpY2UgY3hsLXJwLHBvcnQ9MCxidXM9Y3hsLjEs
aWQ9cm9vdF9wb3J0MCxjaGFzc2lzPTAsc2xvdD0wIFwNCj4gICAgICAgICAgLWRldmljZSBjeGwt
cnAscG9ydD0xLGJ1cz1jeGwuMSxpZD1yb290X3BvcnQxLGNoYXNzaXM9MCxzbG90PTEgXA0KPiAg
ICAgICAgICAtZGV2aWNlIGN4bC11cHN0cmVhbSxidXM9cm9vdF9wb3J0MCxpZD11czAgXA0KPiAg
ICAgICAgICAtZGV2aWNlIGN4bC1kb3duc3RyZWFtLHBvcnQ9MCxidXM9dXMwLGlkPXN3cG9ydDAs
Y2hhc3Npcz0wLHNsb3Q9NCBcDQo+ICAgICAgICAgIC1kZXZpY2UgY3hsLXR5cGUzLGJ1cz1zd3Bv
cnQwLHZvbGF0aWxlLW1lbWRldj1jeGwtbWVtMCxpZD1jeGwtdm1lbTAgXA0KPiAgICAgICAgICAt
ZGV2aWNlIGN4bC1kb3duc3RyZWFtLHBvcnQ9MSxidXM9dXMwLGlkPXN3cG9ydDEsY2hhc3Npcz0w
LHNsb3Q9NSBcDQo+ICAgICAgICAgIC1kZXZpY2UgY3hsLXR5cGUzLGJ1cz1zd3BvcnQxLHZvbGF0
aWxlLW1lbWRldj1jeGwtbWVtMSxpZD1jeGwtdm1lbTEgXA0KPiAgICAgICAgICAtZGV2aWNlIGN4
bC1kb3duc3RyZWFtLHBvcnQ9MixidXM9dXMwLGlkPXN3cG9ydDIsY2hhc3Npcz0wLHNsb3Q9NiBc
DQo+ICAgICAgICAgIC1kZXZpY2UgY3hsLXR5cGUzLGJ1cz1zd3BvcnQyLHZvbGF0aWxlLW1lbWRl
dj1jeGwtbWVtMixpZD1jeGwtdm1lbTIgXA0KPiAgICAgICAgICAtZGV2aWNlIGN4bC1kb3duc3Ry
ZWFtLHBvcnQ9MyxidXM9dXMwLGlkPXN3cG9ydDMsY2hhc3Npcz0wLHNsb3Q9NyBcDQo+ICAgICAg
ICAgIC1kZXZpY2UgY3hsLXR5cGUzLGJ1cz1zd3BvcnQzLHZvbGF0aWxlLW1lbWRldj1jeGwtbWVt
MyxpZD1jeGwtdm1lbTMgXA0KPiAgICAgICAgICAtZGV2aWNlIGN4bC11cHN0cmVhbSxidXM9cm9v
dF9wb3J0MSxpZD11czEgXA0KPiAgICAgICAgICAtZGV2aWNlIGN4bC1kb3duc3RyZWFtLHBvcnQ9
NCxidXM9dXMxLGlkPXN3cG9ydDQsY2hhc3Npcz0wLHNsb3Q9OCBcDQo+ICAgICAgICAgIC1kZXZp
Y2UgY3hsLXR5cGUzLGJ1cz1zd3BvcnQ0LHZvbGF0aWxlLW1lbWRldj1jeGwtbWVtNCxpZD1jeGwt
dm1lbTQgXA0KPiAgICAgICAgICAtZGV2aWNlIGN4bC1kb3duc3RyZWFtLHBvcnQ9NSxidXM9dXMx
LGlkPXN3cG9ydDUsY2hhc3Npcz0wLHNsb3Q9OSBcDQo+ICAgICAgICAgIC1kZXZpY2UgY3hsLXR5
cGUzLGJ1cz1zd3BvcnQ1LHZvbGF0aWxlLW1lbWRldj1jeGwtbWVtNSxpZD1jeGwtdm1lbTUgXA0K
PiAgICAgICAgICAtZGV2aWNlIGN4bC1kb3duc3RyZWFtLHBvcnQ9NixidXM9dXMxLGlkPXN3cG9y
dDYsY2hhc3Npcz0wLHNsb3Q9MTAgXA0KPiAgICAgICAgICAtZGV2aWNlIGN4bC10eXBlMyxidXM9
c3dwb3J0Nix2b2xhdGlsZS1tZW1kZXY9Y3hsLW1lbTYsaWQ9Y3hsLXZtZW02IFwNCj4gICAgICAg
ICAgLWRldmljZSBjeGwtZG93bnN0cmVhbSxwb3J0PTcsYnVzPXVzMSxpZD1zd3BvcnQ3LGNoYXNz
aXM9MCxzbG90PTExIFwNCj4gICAgICAgICAgLWRldmljZSBjeGwtdHlwZTMsYnVzPXN3cG9ydDcs
dm9sYXRpbGUtbWVtZGV2PWN4bC1tZW03LGlkPWN4bC12bWVtNyBcDQo+ICAgICAgICAgIC1NIGN4
bC1mbXcuMC50YXJnZXRzLjA9Y3hsLjEsY3hsLWZtdy4wLnNpemU9MzJHICYNCj4gDQo+IEluIEd1
ZXN0IE9TOg0KPiAjIGN4bCBjcmVhdGUtcmVnaW9uIC1kIGRlY29kZXIwLjAgLWcgMTAyNCAtcyAy
RyAtdCByYW0gLXcgOCAtbSBtZW00IG1lbTEgbWVtNiBtZW0zIG1lbTIgbWVtNSBtZW03IG1lbTAN
Cj4gDQo+IEZpeCB0aGUgbWV0aG9kIHRvIGNhbGN1bGF0ZSBAZGlzdGFuY2UgYnkgaXRlcmF0aXZl
bGV5IG11bHRpcGx5aW5nIHRoZSBudW1iZXIgb2YgdGFyZ2V0cyBwZXIgc3dpdGNoIHBvcnQuIFRo
aXMgYWxzbyBmb2xsb3dzIHRoZSBhbGdvcml0aG0gcmVjb21tZW5kZWQgaGVyZSBbMV0uDQo+IA0K
PiBGaXhlczogMjdiM2Y4ZDEzODMwICgiY3hsL3JlZ2lvbjogUHJvZ3JhbSB0YXJnZXQgbGlzdHMi
KQ0KPiBMaW5rOiBodHRwOi8vbG9yZS5rZXJuZWwub3JnLzY1Mzg4MjRiNTIzNDlfNzI1ODMyOTQ2
NkBkd2lsbGlhMi14ZmguamYuaW50ZWwuY29tLm5vdG11Y2ggWzFdDQo+IFNpZ25lZC1vZmYtYnk6
IEh1YWlzaGVuZyBZZSA8aHVhaXNoZW5nLnllQGludGVsLmNvbT4NCj4gDQo+IC0tLQ0KPiAgIGRy
aXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMgfCAxOSArKysrKysrKysrKystLS0tLS0tDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYyBiL2RyaXZlcnMvY3hsL2NvcmUvcmVn
aW9uLmMNCj4gaW5kZXggZTcwMWU0YjA0MDMyLi45ZTIyNmEyOTNmNDUgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMNCj4gKysrIGIvZHJpdmVycy9jeGwvY29yZS9yZWdp
b24uYw0KPiBAQCAtMTI4OCw2ICsxMjg4LDcgQEAgc3RhdGljIGludCBjeGxfcG9ydF9zZXR1cF90
YXJnZXRzKHN0cnVjdCBjeGxfcG9ydCAqcG9ydCwNCj4gICAJc3RydWN0IGN4bF9yZWdpb25fcGFy
YW1zICpwID0gJmN4bHItPnBhcmFtczsNCj4gICAJc3RydWN0IGN4bF9kZWNvZGVyICpjeGxkID0g
Y3hsX3JyLT5kZWNvZGVyOw0KPiAgIAlzdHJ1Y3QgY3hsX3N3aXRjaF9kZWNvZGVyICpjeGxzZDsN
Cj4gKwlzdHJ1Y3QgY3hsX3BvcnQgKml0ZXIgPSBwb3J0Ow0KPiAgIAl1MTYgZWlnLCBwZWlnOw0K
PiAgIAl1OCBlaXcsIHBlaXc7DQo+ICAgDQo+IEBAIC0xMzA0LDE2ICsxMzA1LDIwIEBAIHN0YXRp
YyBpbnQgY3hsX3BvcnRfc2V0dXBfdGFyZ2V0cyhzdHJ1Y3QgY3hsX3BvcnQgKnBvcnQsDQo+ICAg
DQo+ICAgCWN4bHNkID0gdG9fY3hsX3N3aXRjaF9kZWNvZGVyKCZjeGxkLT5kZXYpOw0KPiAgIAlp
ZiAoY3hsX3JyLT5ucl90YXJnZXRzX3NldCkgew0KPiAtCQlpbnQgaSwgZGlzdGFuY2U7DQo+ICsJ
CWludCBpLCBkaXN0YW5jZSA9IDE7DQo+ICsJCXN0cnVjdCBjeGxfcmVnaW9uX3JlZiAqY3hsX3Jy
X2l0ZXI7DQo+ICAgDQo+ICAgCQkvKg0KPiAtCQkgKiBQYXNzdGhyb3VnaCBkZWNvZGVycyBpbXBv
c2Ugbm8gZGlzdGFuY2UgcmVxdWlyZW1lbnRzIGJldHdlZW4NCj4gLQkJICogcGVlcnMNCj4gKwkJ
ICogR2V0IGRpc3RhbmNlIGZyb20gdGhlIG51bWJlciBvZiBkaXN0aW5jdCB0YXJnZXRzIGluIHJl
Z2lvbidzDQo+ICsJCSAqIGludGVyZXN0IGFuZCB0aGUgYW5jZXN0cmFsIG5yX3RhcmdldHMuDQo+
ICAgCQkgKi8NCj4gLQkJaWYgKGN4bF9yci0+bnJfdGFyZ2V0cyA9PSAxKQ0KPiAtCQkJZGlzdGFu
Y2UgPSAwOw0KPiAtCQllbHNlDQo+IC0JCQlkaXN0YW5jZSA9IHAtPm5yX3RhcmdldHMgLyBjeGxf
cnItPm5yX3RhcmdldHM7DQo+ICsJCWRvIHsNCj4gKwkJCWN4bF9ycl9pdGVyID0gY3hsX3JyX2xv
YWQoaXRlciwgY3hscik7DQo+ICsJCQlkaXN0YW5jZSAqPSBjeGxfcnJfaXRlci0+bnJfdGFyZ2V0
czsNCj4gKwkJCWl0ZXIgPSB0b19jeGxfcG9ydChpdGVyLT5kZXYucGFyZW50KTsNCj4gKwkJfSB3
aGlsZSAoIWlzX2N4bF9yb290KGl0ZXIpKTsNCj4gKwkJZGlzdGFuY2UgKj0gY3hscmQtPmN4bHNk
LmN4bGQuaW50ZXJsZWF2ZV93YXlzOw0KPiArDQo+ICAgCQlmb3IgKGkgPSAwOyBpIDwgY3hsX3Jy
LT5ucl90YXJnZXRzX3NldDsgaSsrKQ0KPiAgIAkJCWlmIChlcC0+ZHBvcnQgPT0gY3hsc2QtPnRh
cmdldFtpXSkgew0KPiAgIAkJCQlyYyA9IGNoZWNrX2xhc3RfcGVlcihjeGxlZCwgZXAsIGN4bF9y
ciw=


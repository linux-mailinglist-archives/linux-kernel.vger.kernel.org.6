Return-Path: <linux-kernel+bounces-212573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C399E906374
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29273B232A4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 05:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599EC132131;
	Thu, 13 Jun 2024 05:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DMjpb7eh"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2089.outbound.protection.outlook.com [40.107.13.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0B93BBF2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 05:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718256777; cv=fail; b=i4jeBQ1FfSXI7WeqjaF52xkLP9pDoI+RuZVMHNrezFZDxWZfLLzOHDZHczo+SXDAKOSZSvMSP+S5xAAtO9m8jsVqHonzwReTHy/s59gCzeJLRru29zXyA+KJ7woN+3/ox0zqcrrx7Uz0p67BvhF5MdGHzX4pGNfSdAIGsrp0D1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718256777; c=relaxed/simple;
	bh=s6BDmorLdFijSUweSXfuKZWrvrVzrBbVgILLLzV0Z1o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q46xJjum6myBWvcCY4yLwIpoadYzD+MaXIvzap16RgjOwN8+ZZLKwL0N0LwrCkeC+oPUOeEwAZewV/PHRmI+ej9XgeQCcGuC98lQ444m/qSCiLtKyflpwNX20qa1Sp8q1l7NMb/IIih8i+/OEt8SFWl1B7VjenAAYGJoozVXGg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DMjpb7eh; arc=fail smtp.client-ip=40.107.13.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVhdzF55yHYS97xhWjhZzMpcFwYMbhB/Ge1VO/O/v0NEbbcUGqttSYb5iXnMpUEh7v3qt6kCeWmo2W4zPPk4K9OQjCkD2r0dbp5NcsjCGKTebzLVWUrMSrK9IBNG2qF58qj1C/bFA5PQBT3BWIMEtOx3slW2TdIH+35PVdT67ykcMyEjUoeZ61D2H7Xb2jVQpe9xkmkV7LrLuG6avn+STgg4J1GoO16odljhaNBD1AB2Tzh2SOJM1Dck1G5WSbVTFeQkhnn/wBdv19jhiR89uISKwuh5AOdHFfRc/KseQKDFgy9LPkmlmK32Wi0mIR9V9tSCaQzkFtgsrFY9FiZPxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uprvjU+VfBF2EEMP1vmIBCDvrZaLvtq0dChMVN+f6zc=;
 b=YKJHRA79xkNzArUTcRgj2GYxmLU/LdNV95A1/JAh9WMFhEE10SJrUJ4kny2X6q1F+MdEBtrZFmce0GLkzhCU8+KCiDdhFLUWrgV7k0TlJV6JaxJEvU9GfDfQWv7dXiMwYW6RHvGeALLJ/4MH1FaCnaNtYN2VLz4kaSS66JsObm162l+QpQ4ZXpYs8gVxn3rEQbg4Isq+ieIJ1qKdMelxBrGqhiGuMtb10w2Fo33UZ2nFR/NzIdUBTL8gmmnRskfCE2HSf8+RMGIsdczE1BHbn9Mpgp5g4+ahpES2k0IJBoPf6xGRTRBOOvTAjmiZoQ1G7FaXmEg1qMn93KLl731YfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uprvjU+VfBF2EEMP1vmIBCDvrZaLvtq0dChMVN+f6zc=;
 b=DMjpb7ehcxGaHoG66uRl8n9lKP4z//4VaxXWF/Q6XP/bMBqNJrybxFsGFMe0IMIcY9F3yIh5khAPK9cocC7skIjrLWdElmOyF91PdNeGALslpov9gN6LgREn3rap343vJKkoNFwbXKTHcD3Op47dvDIDVT0/bQ+4ASaneQxp29E=
Received: from AS1PR04MB9559.eurprd04.prod.outlook.com (2603:10a6:20b:483::21)
 by AM9PR04MB8306.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 05:32:52 +0000
Received: from AS1PR04MB9559.eurprd04.prod.outlook.com
 ([fe80::4fdc:8a62:6d92:3123]) by AS1PR04MB9559.eurprd04.prod.outlook.com
 ([fe80::4fdc:8a62:6d92:3123%3]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 05:32:52 +0000
From: Zhai He <zhai.he@nxp.com>
To: Barry Song <baohua@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Zhipeng Wang
	<zhipeng.wang_1@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, Christoph
 Hellwig <hch@lst.de>
Subject: RE: [EXT] Re: [PATCH v2] Supports to use the default CMA when the
 device-specified CMA memory is not enough.
Thread-Topic: [EXT] Re: [PATCH v2] Supports to use the default CMA when the
 device-specified CMA memory is not enough.
Thread-Index: AQHavKBGxUJQI1jHm0WeihrG1yRS87HEeMkAgAAvWICAAE1E8IAAFNsAgAAdaCA=
Date: Thu, 13 Jun 2024 05:32:52 +0000
Message-ID:
 <AS1PR04MB955915A33F184E141BCD69A2EAC12@AS1PR04MB9559.eurprd04.prod.outlook.com>
References: <20240612081216.1319089-1-zhai.he@nxp.com>
 <20240612114748.bf5983b50634f23d674bc749@linux-foundation.org>
 <CAGsJ_4wsAh8C08PXutYZx9xV3rLRwLG-E6Mq-JgoSO5LA1ns=A@mail.gmail.com>
 <AS1PR04MB9559D82F720BC9A64077186AEAC12@AS1PR04MB9559.eurprd04.prod.outlook.com>
 <CAGsJ_4zGRnGhn1zA1=H+TgqL8z59_Dy7x7YVKsKY0wRFt4tu9w@mail.gmail.com>
In-Reply-To:
 <CAGsJ_4zGRnGhn1zA1=H+TgqL8z59_Dy7x7YVKsKY0wRFt4tu9w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR04MB9559:EE_|AM9PR04MB8306:EE_
x-ms-office365-filtering-correlation-id: 25b5006f-ef99-469a-449c-08dc8b6a450a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info:
 =?utf-8?B?NHF6TUY0TXYzYzlkcFZMNDEya0xwbTV2M0lhTGRNSDREamFXa3ZMMmhsM3Uy?=
 =?utf-8?B?QU9naVQ0aXh4bXNWVHR3SlhZdlFRNmdnRGJuZHgvV3Nma0Rod2UvZzhILzJR?=
 =?utf-8?B?U3JnZGhUR2J2TkpDYk9GQUd2MlVra1YvZGpUcTJ0UmovZ2ExcU8rRHQ2VTM1?=
 =?utf-8?B?NG40a2RyR1YwSHh6dExDaEVzemtld0pxbWJnK05UMEZONGxQNDMrVkxRb2lO?=
 =?utf-8?B?SUZFcFNjdGt2Zmh0UkV2VjU2UXhPcmpSRlVRdGZRejRiK3liWDEzWGtCTmFY?=
 =?utf-8?B?ZUt5cWVwZUI5ZGttK05Sd3VBcDJRQkpPUndVMU5VTUNPdFpselE4Wnd2Z1VS?=
 =?utf-8?B?alhZQ1BiWG95Ny84NDBHVlhFVFN0bzVkMXNuZnhWT2pQT1B4WFd0TjIxSlhE?=
 =?utf-8?B?cHJvTVZGMUdLdUphQWswaDJkYThlZzdZTUdtNHhieDhWR2RUZ3ZEVkxGWFZJ?=
 =?utf-8?B?b0tjWFgrTkIwRHZhelRKa043ZWJTQk81Tm9Rem92TVkzNjZ5eHVMZ2dYTTVM?=
 =?utf-8?B?SWZtcTNJVlliRkIvelA4Z2p6ZnlqUjBmeVZ4M3RoR05neWlSdVdlSS9CbG9v?=
 =?utf-8?B?Ym9QM3ZSTXoySzJjcWRlRjBQOENUZjVLeFpmcE9FQWs2am1oa2oya2QxSXF4?=
 =?utf-8?B?NFh3UHpLeFYyWTZjdGFINjhsMGtnQ01sRjFKcy94aUVHQXRPMldDbGZSZisx?=
 =?utf-8?B?QXp4eE9iWUJ0ZmhWVDJRNjI0Rk1jaXd3c1lRS2g5cWJNTkxTNjI3STc5aUcz?=
 =?utf-8?B?NnRPL3BJczVNcEFNdWp6NDF2TUZuZVdVL3U0Z0NweVZNbkdEdW5qR0xFRlAw?=
 =?utf-8?B?V0V1RUJWSTc3Z1VSWkN3SUdJSnZkN3JBL2NBbEpZcThmVytmZzAxSjhYQUhy?=
 =?utf-8?B?dGhnRlhkL2dxdVBGbC9TUW1kMHdzRjkvUGs3SDVLWUxnenJhUk1jc1hVSmV4?=
 =?utf-8?B?KzN1UEdUK0s5RVV6cTFwZFR0V1NoR0RWSHhjb3VwUGN5ZHVPVnBQU1AreERy?=
 =?utf-8?B?MmUySmVDVEFmM0l2SGdsZThnZ0pIVWpYUWQxeXlpUHFqUk1tZDNGeTF6OXNx?=
 =?utf-8?B?R0ZwTHp0ekhBa0FzV3NFU3hKWWIvaVZsbDR3Y2YyZU1mbHNIOXZaYlRSVDZH?=
 =?utf-8?B?V3didGE4b2JyU2FlUmpMWlZXMkFqRXpWTS9OdEZhRWtOSTlEY3Jpc3ZwSm1F?=
 =?utf-8?B?bnAvQm5SY0ovanFVTjRvVHBZSlVuWk1RekhWcEt4VUt3M0YwUW5KR1E3ZVdE?=
 =?utf-8?B?K2hpUFM1TzlJM0c5WGtBNUhEdTZ5OGVjelpvczZZZkN4Tm5OWGpNb01Ga0ph?=
 =?utf-8?B?MFZVSGZucVlhcG9BcmJzdFo4Q2w5NzRmbEs2YzRycFhTaWIzWnpVcDZnL1pq?=
 =?utf-8?B?M3BxUDBMalFkOW12OUFNUEJGU0VoVnFpMmNqS28xdElmNFpSK0d1U0lqMlN3?=
 =?utf-8?B?eDlBWjJ5WUpSTUtUYnBWSDNJNi93bWxycmN2U1hJY0wvOWhRMDZRQi9yV0hm?=
 =?utf-8?B?NThiVlcwZXFBMTZMVnRMYVRSNmNteExydHBLWmo5ZjFSY0ZUZ21aR0laUEJS?=
 =?utf-8?B?dkpscXNYOFp6WkNJVTYvMkRraXEwNVM2NWZ1NXdJeFRPdzNmOW53My96MDU4?=
 =?utf-8?B?aDVGc21EYmd1UkhHeXYrcmtiZS9LZmRlZXVqQzVqS2xkdE44RFhEb1haa3Ay?=
 =?utf-8?B?L0hhMmJBM1lNWS9yZ1daSkY4LzUwaXo2L3RhSDQyNkZPcVJwWlpqY1FZMHVv?=
 =?utf-8?B?YWViYlAwcDV4bHFiT1VtQ0V2WjlqNG1wVHVTZGE2QndZcGNhbnZUWnBVTUU3?=
 =?utf-8?B?SG53ckl2WjlwVnBxYXFFMWI5QnVmY2lpYUo3bHpNWnJhQUQxaWRQNllISEk1?=
 =?utf-8?Q?H4CNCpJ2KlJIs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9559.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WjRvQ25yUU52VjVzTEF6bjkzbk9FRlNXN2ZGY3dkb0ljRzlyY204L3dOWm5K?=
 =?utf-8?B?Y1ZjMEMybWErbE1HTnlURURwNEh3VmxPRmYyc0htaDhicVRwT0swN3RreWl1?=
 =?utf-8?B?MEIySnJOalo3MjBTZG11WGJNN3EzWHhNR0NFc09Cdzg0S3dadXdxQ05zQkwr?=
 =?utf-8?B?NndjUldOdU5yQmFoWkNqbGV1TjNoQU94MkZFNjRkNUVLK1VlRzRma2dOdFJR?=
 =?utf-8?B?T0x0VGc2OG5Rd3NIaWcxbGFEUDkrWXNEdlR4VVBiVWd3RTVhV2pvREk5VzMr?=
 =?utf-8?B?dUg4WTBmNHpuZ21qcmR2YlFaZ0U3QnlVRFpFTnNsZHFJQTZaaVNlcTB2ZXlw?=
 =?utf-8?B?bUcxazVySzJEZlVCaTVWQWpYTjBWd3NBQ0I4NERZT3BXVjlycGdBV3VRZ3Ns?=
 =?utf-8?B?L083dEpmQ25nSis1eGRvRlozRkZzV2t6L3FobDdhTi9YaUFMUHlMb21YNkZs?=
 =?utf-8?B?dndMVjROSklFbGJyK05sQ2Q4SDNVR1p2a3RkOE1EanRiVXRFNmZ1WTFtUFJ1?=
 =?utf-8?B?a05vZktQWjdWa1c5NTZCRW5CbW44T1pmckZ6bUNEa09kTXFaNzFDejRDNUw2?=
 =?utf-8?B?b3l2YUcwUmoycTdpVUZqZ2dHeDhEYVBGbWlwWmRJS3R4SE1SS2d6dVFRZnFw?=
 =?utf-8?B?M3RFbmlLQnVpWWFnOG9CTzAyWUtpMmw3KytOWTk4dmlWd240VlpyL0VrcTFX?=
 =?utf-8?B?QVhURWg5WnJKczVla2JXVlo2VTY0YWQremEwb1NJMmgzZGdtQ3k1bWV3T3gy?=
 =?utf-8?B?a0sreFBDVHVDeDdOS084eENxR3Vyd0RQaHZROUdzbTlvM2czWHAvc0FjWWpB?=
 =?utf-8?B?SkJWVW8wYUVrV2pvZmQyNHlvU2xJd3FMVldHZTU3R0hFNVBnSDVwV0g2dkg5?=
 =?utf-8?B?SEcwYjFqMGdFYmdhcWlIMENqNHlYcmpIYUFlYmRteHFLMGhkVEpwcUF4Rkcv?=
 =?utf-8?B?VUxyRzlWSldkNWVmT3VXbm5iRlBPdFpiRENrVm5XUTZBSllSM0hwNys2dFIw?=
 =?utf-8?B?UWthNTNJak1LMWNFcHlsbjN6REpJYVdVWDVteHlFRlZ1Z0pYNjd0L0FEZ2NE?=
 =?utf-8?B?YzQrYnd6MmRSUzd3SFphV3VnZ2hlQktvczYyc2JSUS9HQWtTbUg1dGI0bStP?=
 =?utf-8?B?dnQ1b3ozS2lSZHNKRkczZ3cwTDRxTEk5RmU1TU5pbk14Mk1yYUpXbkZxc2lr?=
 =?utf-8?B?Y2drVm9pZ0RCNmVEKzlHYkJ6c0ViQjN4M2c2VHE2dHNyOUVWZktOVzc4dzF0?=
 =?utf-8?B?U0FPSXZsSGxSWTdEN2ZZMEFTcFAzUUZKV2VFcUZPUGdweVhLYzM5b2JUU2lK?=
 =?utf-8?B?ODh6dkdia0NwdDBaclJxMGVveWs0L3lDWG4wemJvazByZWM1VGNnT0NiMzAw?=
 =?utf-8?B?cm81V1N6SHhuc2ZyNldldnQ2UVhqMlBYdnNKNE5vaFphbWRSNHdmZ2p5M3lX?=
 =?utf-8?B?TFJiZXgwUVJrYkl2akZHYVEwcGo5c3VTZmRUWG15VVlITjgwM2NGQjd0UkNI?=
 =?utf-8?B?ZitvNEZWeGVvdnE3SGIyRnJSbEhSVTBubDFjMjRhR1hiUHdRVmdoN1ZrZUUr?=
 =?utf-8?B?Y1lmZlRpakp5MHhUbk0zNjZ0TFA1cHg2K0h4ZlJ5VnJuVTVXdkZ5OWJYSm5i?=
 =?utf-8?B?WHlSRVBIdHU5WG1IK3pjajBlVUl5QllnM2FMa1NIbFM0UXhaWWlVZ2Z2REJG?=
 =?utf-8?B?ME1YQTZLMDlMdFFmWFdyMGYyaWx6a1c5SW04OTNMQitaQk5VNmlUTmo0bjVx?=
 =?utf-8?B?dzB6UGlrYlI5MHhNQlJpcm1JT1VIZ2hMTUJZd1NIVDU1QjFjd0plNWFlTVdX?=
 =?utf-8?B?b0xKOFoxbnpldUZZU08yd291N0pmWWtMNFlLNmJ3KzM1N2hBSlQ4V0dXWEx0?=
 =?utf-8?B?a3pRR1dHb2RvN1ZZeGJqY1pkRjVZaWpFOEdCMURaa0xxQ3ZGaFlRT0tHcEhU?=
 =?utf-8?B?RklxZFB2cld1UHo2eHFYcWhlMW5hdHJ5cHQ4Q3ZodEg4KzdlZkc3VWQ0KzJO?=
 =?utf-8?B?VnB2TWRJWjEvZEpKZS9wanR0RW9jQ3NmT29DVlVXaXNxa2h5bFd5cFdCK0Ny?=
 =?utf-8?B?bDRxR1NYVUxNM2J1RDUzd3ZnbG5Ha1hFSmoySmNXb3MyZHFqZmlhbFhXcWdw?=
 =?utf-8?Q?VrH4=3D?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_019C_01DABD96.2EEE8AA0"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9559.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b5006f-ef99-469a-449c-08dc8b6a450a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 05:32:52.0833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a9frQCWynu5X833XFQ4oVPC61bJuNUKdUUrKABmMkqAuOsaN6HqKKFPmmBRqNUO3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8306

------=_NextPart_000_019C_01DABD96.2EEE8AA0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Barry Song <baohua@kernel.org>
> Sent: Thursday, June 13, 2024 11:28 AM
> To: Zhai He <zhai.he@nxp.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>; sboyd@kernel.org;
> linux-mm@kvack.org; linux-kernel@vger.kernel.org; Zhipeng Wang
> <zhipeng.wang_1@nxp.com>; Jindong Yue <jindong.yue@nxp.com>; Christoph
> Hellwig <hch@lst.de>
> Subject: Re: [EXT] Re: [PATCH v2] Supports to use the default CMA when =
the
> device-specified CMA memory is not enough.
>=20
> Caution: This is an external email. Please take care when clicking =
links or
> opening attachments. When in doubt, report the message using the =
'Report this
> email' button
>=20
>=20
> On Thu, Jun 13, 2024 at 2:34=E2=80=AFPM Zhai He <zhai.he@nxp.com> =
wrote:
> >
> > > -----Original Message-----
> > > From: Barry Song <baohua@kernel.org>
> > > Sent: Thursday, June 13, 2024 5:37 AM
> > > To: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Zhai He <zhai.he@nxp.com>; sboyd@kernel.org; =
linux-mm@kvack.org;
> > > linux-kernel@vger.kernel.org; stable@vger.kernel.org; Zhipeng Wang
> > > <zhipeng.wang_1@nxp.com>; Jindong Yue <jindong.yue@nxp.com>;
> > > Christoph Hellwig <hch@lst.de>
> > > Subject: [EXT] Re: [PATCH v2] Supports to use the default CMA when
> > > the device-specified CMA memory is not enough.
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the 'Report this email' button
> > >
> > >
> > > On Thu, Jun 13, 2024 at 6:47=E2=80=AFAM Andrew Morton
> > > <akpm@linux-foundation.org>
> > > wrote:
> > > >
> > > > On Wed, 12 Jun 2024 16:12:16 +0800 "zhai.he" <zhai.he@nxp.com>
> wrote:
> > > >
> > > > > From: He Zhai <zhai.he@nxp.com>
> > > >
> > > > (cc Barry & Christoph)
> > > >
> > > > What was your reason for adding cc:stable to the email headers?
> > > > Does this address some serious problem?  If so, please fully
> > > > describe that problem.
> > > >
> > > > > In the current code logic, if the device-specified CMA memory
> > > > > allocation fails, memory will not be allocated from the =
default CMA area.
> > > > > This patch will use the default cma region when the device's
> > > > > specified CMA is not enough.
> > > > >
> > > > > In addition, the log level of allocation failure is changed to =
debug.
> > > > > Because these logs will be printed when memory allocation from
> > > > > the device specified CMA fails, but if the allocation fails, =
it
> > > > > will be allocated from the default cma area. It can easily =
mislead
> developers'
> > > > > judgment.
> > >
> > > I am not convinced that this patch is correct. If device-specific
> > > CMA is too small, why not increase it in the device tree?
> > > Conversely, if the default CMA size is too large, why not reduce =
it
> > > via the cmdline?  CMA offers all kinds of flexible configuration =
options based
> on users=E2=80=99 needs.
> > >
> > > One significant benefit of device-specific CMA is that it helps
> > > decrease fragmentation in the common CMA pool. While many devices
> > > allocate memory from the same pool, they have different memory
> > > requirements in terms of sizes and alignments. Occasions of memory
> > > allocation and release can lead to situations where the CMA pool =
has
> > > enough free space, yet someone fails to obtain contiguous memory =
from it.
> > >
> > > This patch entirely negates the advantage we gain from =
device-specific CMA.
> > > My point is that instead of modifying the core code, please =
consider
> > > correcting your device tree or cmdline configurations.
> > >
> > Because we enabled secure heap to support widevine DRM, and secure
> > heap requires security configuration, its starting address cannot be
> > specified arbitrarily, which causes the default CMA to be reduced. =
So we
> reduced the CMA, but in order to avoid the impact of reducing the CMA, =
we
> used a multi-segment CMA and gave one segment to the VPU.
> >
> > However, under our memory configuration, the device-specific CMA is =
not
> enough to support the VPU decoding high-resolution code streams, so =
this patch
> is added so that the VPU can work properly.
> > Thanks.
>=20
> I don=E2=80=99t quite understand what you are saying. Why =
can=E2=80=99t you increase VPU=E2=80=99s
> CMA size?
Thanks for your quick reply.
Because we added a secure heap to support Widevine DRM, this heap =
requires hardware protection, so its starting address cannot be =
specified arbitrarily. This causes the secure heap to occupy part of the =
default CMA, and the default CMA is therefore reduced, so in order to =
avoid default CMA Shrinking introduces other problems. We added a =
specific CMA area for the VPU. However, due to the large size of the =
secure heap and default CMA, There is no remaining memory available to =
increase specific CMA for VPU.

> It seems you mean that only in some corner cases do you need a large =
CMA, but
> most of the time, you don=E2=80=99t need it to be this big? So you =
have to "borrow"
> memory from the
> default CMA. but why not move that portion from the default CMA to =
your
> VPU=E2=80=99s CMA?
>=20
This is a method, but because for VPU, the continuous memory size =
allocated by the driver is based on the video stream, we cannot =
determine the maximum size of memory required by the VPU. This makes it =
impossible for us to determine the size of the specific CMA assigned to =
the VPU. Thanks.
> Thanks
> Barry

------=_NextPart_000_019C_01DABD96.2EEE8AA0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIhTTCCBaIw
ggOKoAMCAQICCE4Rpu+H69FRMA0GCSqGSIb3DQEBCwUAMGUxIjAgBgNVBAMMGU5YUCBJbnRlcm5h
bCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJ
RWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0yMzA0MjEwNjQzNDVaFw0yODA0MTkwNjQzNDVaMIG2
MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQ
IEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmS
JomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTEL
MAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAWrnSkYP60A8wj4AO
kATDjnbdgLv6waFfyXE/hvatdWz2YYtb1YSRi5/wXW+Pz8rsTmSj7iusI+FcLP8WEaMVLn4sEIQY
NI8KJUCz21tsIArYs0hMKEUFeCq3mxTJfPqzdj9CExJBlZ5vWS4er8eJI8U8kZrt4CoY7De0FdJh
35Pi5QGzUFmFuaLgXfV1N5yukTzEhqz36kODoSRw+eDHH9YqbzefzEHK9d93TNiLaVlln42O0qaI
MmxK1aNcZx+nQkFsF/VrV9M9iLGA+Qb/MFmR20MJAU5kRGkJ2/QzgVQM3Nlmp/bF/3HWOJ2j2mpg
axvzxHNN+5rSNvkG2vSpAgMBAAGjggECMIH/MFIGCCsGAQUFBwEBBEYwRDBCBggrBgEFBQcwAoY2
aHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFBJbnRlcm5hbFBvbGljeUNBRzIuY2VyMB0G
A1UdDgQWBBRYlWDuTnTvZSKqve0ZqSt6jhedBzASBgNVHRMBAf8ECDAGAQH/AgEAMEUGA1UdHwQ+
MDwwOqA4oDaGNGh0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEludGVybmFsUG9saWN5Q0FH
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
MqAfBgorBgEEAYI3FAIDoBEMD3poYWkuaGVAbnhwLmNvbYEPemhhaS5oZUBueHAuY29tMB0GA1Ud
DgQWBBRnNp0/tSrFNJlgS+ZRdCT+c5yRQDAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6jhed
BzCCAUYGA1UdHwSCAT0wggE5MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRlcnBy
aXNlJTIwQ0ElMjA1LENOPW5sYW1zcGtpMDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2Vy
dmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9j
ZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9u
UG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Jshi9o
dHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsGAQUF
BwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBD
QSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNv
bmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVj
dENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtp
Lm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNlcjANBgkqhkiG9w0BAQsFAAOCAQEA
ggGwWe/YcZgJiMbIhUsSO/bYD09itDFnYO+uQqGwvPalRuHk3rA6pXfNb4DoA+gFZLgVDHNul0YA
oS8u+LYHUwXe/tP1HZvoInRRnUjPCP7o3uoQFcX2Ay0pVz3AoByHaFAqF3zCCsAdDhTksMPZu2eQ
oapJc06m3ZaIBpjT6aVZOXnRFVcHUjaMAZrpm2jqv3jJt58kP0dRsCrfKUkeTflak885rGuUypZC
j9tjOii+7/qAsUR/JqMZADUo2cD+PvCwHZRPpj0x1b5Ain8/3mRDTCaa7mMOUApMdd7De9fNjosF
LLTdnTiUXO+gnVgwXLvMOhuHTI6aWS+Z9pD1tTCCCDgwggcgoAMCAQICEy0AC58oXPwK6O6UsbsA
AQALnygwDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJ
BgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQI
DA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhw
MRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yNDAyMjcwMTIyMzNaFw0yNjAy
MjYwMTIyMzNaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMw
EQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAkNOMRYwFAYDVQQLEw1N
YW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGY2NDU5ODCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOFpbP807BLOCF4Zt9RudYkITj3hHgHYcWcIYUiT
PmR5wym2ussl7jezDSHHlEvPmzhgdSx/PVPpYcv80hjMDHFw3aoV0qyOU+W/pOT2oCL/7S/fHWUe
2Sahoup+MvYXycNdoONBohwwdCcWt71fxvxzsCq0XtnkUdgoTXFlZb53vhD3rAHvP/QhY8jLGvMa
I/xK5kFNYIC5EBH5m+atfPB7qERZIUU9nCacRfJVAZpkK0j8L1YBjG28Xm9OcDdgQAsOVRFdkFxk
3YVjHiSmGfDmd8QdvPJrlIDb/mdVXR/FGSl95J16mkithq2e3DBNOJtWrxxj3XDkmXpr9iAUGpEC
AwEAAaOCBFcwggRTMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRVhu2FOILrmUua
klY/heaKboS14X4CAWQCAUEwEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/BAQDAgUgMAwG
A1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZIhvcNAQkPBIGG
MIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBGTAL
BglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4GCCqGSIb3DQMC
AgIAgDAOBggqhkiG9w0DBAICAgAwUQYJKwYBBAGCNxkCBEQwQqBABgorBgEEAYI3GQIBoDIEMFMt
MS01LTIxLTE5MTUyMDcwMTMtMjYxNTA0MDM2OC0zMDc2OTI5NDU4LTk0NzgwMjA7BgNVHREENDAy
oB8GCisGAQQBgjcUAgOgEQwPemhhaS5oZUBueHAuY29tgQ96aGFpLmhlQG54cC5jb20wHQYDVR0O
BBYEFDrgyxq3zDcnhNi/Mb2VXLlr7Mn3MB8GA1UdIwQYMBaAFFiVYO5OdO9lIqq97RmpK3qOF50H
MIIBRgYDVR0fBIIBPTCCATkwggE1oIIBMaCCAS2GgchsZGFwOi8vL0NOPU5YUCUyMEVudGVycHJp
c2UlMjBDQSUyMDUsQ049bmxhbXNwa2kwMDA1LENOPUNEUCxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2
aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPXdiaSxEQz1ueHAsREM9Y29tP2Nl
cnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Q
b2ludIYvaHR0cDovL253dy5wa2kubnhwLmNvbS9jcmwvTlhQRW50ZXJwcmlzZUNBNS5jcmyGL2h0
dHA6Ly93d3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3JsMIIBEAYIKwYBBQUH
AQEEggECMIH/MIG7BggrBgEFBQcwAoaBrmxkYXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENB
JTIwNSxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29u
ZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0
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

------=_NextPart_000_019C_01DABD96.2EEE8AA0--


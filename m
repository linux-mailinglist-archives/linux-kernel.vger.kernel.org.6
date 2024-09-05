Return-Path: <linux-kernel+bounces-316483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D431A96D02C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058B51C22C57
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88DF193068;
	Thu,  5 Sep 2024 07:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R33Ofylx"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6F8192D79;
	Thu,  5 Sep 2024 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520474; cv=fail; b=Bo4OIBKMvydWhgK4jJXf++5QbRWIC78CuuQuxqoh8YcbLCNvWHFKDH1S8sNqpu8qrEafTQ21akpdFLSlk5VdtlRJIKt8JyoOflxXPLOTT5v9DvbjdU6F+MrCgLMNOMat4u+Yc+gTv9bCfWPCQkiU/jPeNOd09ROaEQ+q/eDqP/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520474; c=relaxed/simple;
	bh=YvXG+fVygIo5JzSVgS3IyihGyoxvURUVAreXp8XFDqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RjZpGpRBvh7D6BA1TjLU1FIBlolC2/9icrsmb/OXRN59B6Cgi6VbC05kfbggZ+tm0HHn3VmttYnAi7z9Rr9jOhCe465r8VGZDE5oe61CY56nOrgZ0c/NUtG8IJRuw+jVyOWlXJIkr6+0cy2gS+aG60sP/KOZkt2vuYuYMsqhO3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R33Ofylx; arc=fail smtp.client-ip=52.101.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhFmYCkKjzI7UJrZkvgZ/JVoW1xkE/rU81tXhiw+p9HcUesDmY0xBYOzcPN/GoLB4zEcNAV6TRN4pNx6270CdoJX47MyRi9FWLEWUXsmUbB1yoD6oVfuOtyoy57ceFrlZ0N9xNnNIw9ZLNJUNlPab3GgbJk+HAhBqaM/6Km/6FpNbcDzA9bbwkITyZmwjkkg5ZXojRpKj/bE7M9PaCcydPop0TBib/hCJgjn06ej7L5ySSjyI08xS7Hde6qHfDy+JB2XZZOVR9RfK/IXH7+jmQMTjPhAfcN8R7maJmyWT9pSN8h0kIsUqm7jrUxjP+EbKcak+k6MQFSkLe28hkK9EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvXG+fVygIo5JzSVgS3IyihGyoxvURUVAreXp8XFDqI=;
 b=LFcmnQ1/hrqtELenWpfmOOS0V+cJ7oPHPA+0rHs4GNgJk6eTs4IgzClwMeXZZYWHyeemr5+TzD/WIR1TzSI0XHLkqtDtc8HKXUq4upwJWa4AmGjtY9I9Gn6cGUwyIvMGcNNRcjiHRNNhCxB00SOA98nLltIrBukf85mVe9M2MkmjYIRWQKVLEiKY4dO5B8wOh5BEfmSFQm/zr1uiRc3lLZQWiBMHIYktvo1uRs34lZabQbO0aRmKJVnaPunhl9+idx3jG1gyRnEwTEeofEpxFLpKbszgOBwVIP3e0gxGcmZ2pV7hp9XEl3G3i+rg207esXDlIDKOUZOy67OqWQgqVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvXG+fVygIo5JzSVgS3IyihGyoxvURUVAreXp8XFDqI=;
 b=R33Ofylx/UIr68YVROyGUtOSMnBvFubKnNwYuGxMKXncjcxuZbdUZyX1t0Qi079tM8hZ2LCb67tbycXhH6zPwWV+ouYZ8W3t7/bUAJ1hMKsnWpt2SMd1LYgZ5N9odeySQYBgVhkrHX2hdEqhSYzicaPCnhdpFH9x/3+INRVgpEeAMlZsoCPd2u3a9Dk6hE3f6gYdOmKCEs38jOEOveOHOE8fFqDDXu0QW4NSilnAK8in7iu30ujKRi0uhy2mJv5F9+/iV5V2BHK4ufcJaycT86OYnBpSXUyTErUtcpXff+twEOoMvQuJlYgEcBpbtSeXqrv+H6IK6/PajXypQnyojg==
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by AM8PR04MB7203.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 07:14:28 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 07:14:27 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"abelvesa@kernel.org" <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v2 2/3] dt-bindings: clock: nxp,imx95-blk-ctl: Add
 compatible string for i.MX95 HSIO BLK CTRL
Thread-Topic: [PATCH v2 2/3] dt-bindings: clock: nxp,imx95-blk-ctl: Add
 compatible string for i.MX95 HSIO BLK CTRL
Thread-Index: AQHa/z6nTeG8S6pziUqADV462RrA8bJIv7gAgAAH/oA=
Date: Thu, 5 Sep 2024 07:14:27 +0000
Message-ID:
 <DU2PR04MB86779E996120C51A5C7372C58C9D2@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <1725503468-22105-1-git-send-email-hongxing.zhu@nxp.com>
 <1725503468-22105-3-git-send-email-hongxing.zhu@nxp.com>
 <e24uioplsxa4iu5m2ecn7apkpkmz3lukfyypngmsmp27ikxnbc@4cwxk2hoeo2r>
In-Reply-To: <e24uioplsxa4iu5m2ecn7apkpkmz3lukfyypngmsmp27ikxnbc@4cwxk2hoeo2r>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8677:EE_|AM8PR04MB7203:EE_
x-ms-office365-filtering-correlation-id: 5d60682b-3e07-401b-edb4-08dccd7a60da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MmxzZHRNTEx5bVFtTFZRdWdsVXB1N2NZckZHeWFFTWkwVThyOWhUdXVFTWtG?=
 =?utf-8?B?eHE2eG5HOHlJdUpIZ3ZiQmJMS3FtNTI1eGQvQlM5dkRDdHc1dkJDMHNmN2Ja?=
 =?utf-8?B?dk5JZDJ3aW41cTdFemk1a2c0WVRhR0JGUmFZRjBTVnZXdmxRdGtMWUJxSFRM?=
 =?utf-8?B?Y2lpTkdBS2R2MTNFZEk5blpaK1VhamJNM3lQOEJCTHE1a0k3cFh4cjh6KzM5?=
 =?utf-8?B?K2pNczdGKzZTb0g4NFNIek5sc2VmWXhBRjhqVWdtS0VNNTBhM2lyVmM3eUpv?=
 =?utf-8?B?OGNMVE1tYU9pKzNOb0VISmtoano0QXJlK0YwM1NnS2VwbGFzVHgvWkt1QTFk?=
 =?utf-8?B?UzY1TWp6b3hqdkRMYVJVRlprbVMzZVhvNGtMdlpLOS9PMHFzcThDc29JOEpL?=
 =?utf-8?B?b053OEgwMkFWVHl5VlFKNExHZGVsRFFrVE50Y05KaGM3MU9DTzdqUmpkVTR6?=
 =?utf-8?B?anFBYWUzK3krODlSVzhFb25VY2dOUGdpb0pZUEdiT2hmY2hiYTZ6S05xUGc0?=
 =?utf-8?B?b2c1b3IyNHowQzBOU1Zka3dzanMxZ1hleHI3VTNBVVNZWk1kRUlNakljK1NO?=
 =?utf-8?B?UVB1MDlTQ24ybDFXL25mY2VnYlo2TG1jWGJSbFNBK3gvdDEwU0VjdllOUlBE?=
 =?utf-8?B?SGlQL29uOXgzdlVHWWRQM0VlVUo1SFBvdllzN0FnTjk3aUovM3lsN2Vudk15?=
 =?utf-8?B?NytRQmViUEwxdzNqdWxGS1kvdmxteS84NEg2THQ3U0hrdFJKbERtOU15aVVU?=
 =?utf-8?B?K1JraTZ6UjR0aWs1a3RPWjB5YThqOGgvSmN3dXF0LzN2NDg4a0hHV0pVWDVY?=
 =?utf-8?B?RHhpL1ZlVURNMlJxZnphSCtoMnpuWHB4WW1RRUp3QUtxSFNUQjkyUy9Fc0c5?=
 =?utf-8?B?NmhvU2twSjN4aVVqell3WXMyU24rQzB1VWhFNnh3c2hzTmpFVXBoR1I0RzV4?=
 =?utf-8?B?TkxGTXJXSXJUbGNHU1hTanp4UVZpRHNPSCtZNG5zdmpXdEtzMjVXZkhQQmlj?=
 =?utf-8?B?cmh4NENLZ0lvMTlMTlBFRW1MK2I2RHphUlgwSzh6OTZQWmxudEVoZHFzazJw?=
 =?utf-8?B?NFBSRDdZM2s4V3NmWUt4VE5PWVc5RDhyV1RveVVtajVtQ0hnOWhIeklsZlUw?=
 =?utf-8?B?K1A0dmRQemdTbERjT2VFR1ByajJ0YWVkY2dZSkt3U3BwcEVDQmk2TG0zSXlp?=
 =?utf-8?B?RmtibnppVDdDdGlFU3BGWlZpbTJDZjJ4ZmFQbWx3Z0Z5N2dHdlMzU0NiYVJt?=
 =?utf-8?B?YlNBQmFaeVV0VmNxM0I3dW9meTk5SDJlTTRSSElyaTlTV2FJZDA1cXFsa1lL?=
 =?utf-8?B?WmlqQWJRdkxLUzBQT1h1VTh6ejAvTmNIcCs0VWw0dkdmcmxFQ3BtUlVZaHJx?=
 =?utf-8?B?WXdTQ1FsUm5MRmVzVjFicVRYQVUxOWxINFpXRnoyTGVxd3ZiYUd1TDlFelh0?=
 =?utf-8?B?NkI3d1VsZ0Vmd245WFVxWmdkOTlRTzNBbHMvaEl4cGN4RG9qemxibzEvcmds?=
 =?utf-8?B?eVNWdFJEZnhQTlNqVk1ITmRBYVdCQlorZVFnN1RhcDNJVnZuejZkVU8wdlVQ?=
 =?utf-8?B?djFkbEo0eWdwTzZ4UXl0bFRjMm9aWGlWUnpGc3V2NXZPeHQ4aHFvVk15Uzh2?=
 =?utf-8?B?eTJtRUgrSlhsOXhrNnc2OElyN05TUVdEcE4rYzllVjNQSC8vSjNVUGNqcWMr?=
 =?utf-8?B?c1pVT1dzY2R6UjIvSDdzcUdZS0lDTkg3bnVMN3BZdHZkc0M1Y1lWaWRXaTk2?=
 =?utf-8?B?Q2NBZTZiekRoeU16MzNPY2JJNWo1TC82RDh4Z2I3L2owMnl2bWVNZVc5TGU0?=
 =?utf-8?B?Kzh1anJJdXRKNDJTNHh4TEdJaGkwZjJ6dk5sblVHeGY0VGxpalNnN0E5WGVw?=
 =?utf-8?B?em1zTjNobDE1STJ4NUFPNURyK0lSaFUxdU5IdWZvOGRVZlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUxSSnpLS2piTlBLSWZyNHZ2T0ZLUUI2SVNuanJqaHZGN3c3WVRkV2RsRkw4?=
 =?utf-8?B?VmtNU1ZEbFBuWDVEbGppSU1GOWVNUldPWTZmWnRtMWRQYTZWMTBmNGZvazhk?=
 =?utf-8?B?aEJpM1l3QWNDY3JxY1UweW8zblhCeS9mZ29teEpNTzYzTVFSazV5WWluT2FI?=
 =?utf-8?B?WU1FdGdYanE3QnJITUhZRWdNQ0lRMmpBVHNtaTZ5WlpiUFRyOVFJWU4yRGN6?=
 =?utf-8?B?eTkrYmtpVHZYM3Jla1RiUmoxZE94L1FzNHNuaFBraU1jVEt3Z1N0aTNxTmNO?=
 =?utf-8?B?RkxmMWo0UEM2WnFUR2l4cDNYZi9FOXVRSTVhSTdnamhPbkhpWkY0aXdBckk3?=
 =?utf-8?B?TXJ2aXZyNkRESXM5Rk1NS3Q1TkdmOUxUQmJFYmZnYXdoOE54YTlUSXhVK3Bl?=
 =?utf-8?B?UG4vd0ZUUDRDaFhRRk11RDE5a3VNYTBRR004RjBvUHhzK3pKTVZhcVFZY2lI?=
 =?utf-8?B?RWM0VExZejR0SmtwSS9pWDcxVXUwMitSNGM5UDJuQWx5bmN2U0JwWW1UdTlI?=
 =?utf-8?B?T0d6NlJFSTJmYlFKd2NHM2wzMzlCNGtOa0graUZ2RU5NbHowKzBuYUxRVFpF?=
 =?utf-8?B?WTE5N3AyaTNhOEdPeTFNYWplcnhDaXhldTBiTTVFZFNjemtYNThVNTVTbVdr?=
 =?utf-8?B?SVJEUzgxak5lNU5BSEpGWTlFZWNMTkNvV1M1OElJY3ZOUFpYY3BTQUxacXRh?=
 =?utf-8?B?ZDIvZSt2bnVRaWVReU1YQVpDZTNna3EwcUNyajRBcXFXZ2ZZcEkxSDRYN3d2?=
 =?utf-8?B?Q1o5bzhXTFRQZzA3UXdhS0xMZ2t6ME9GWlB2VVdzdkh2bHJ4STB2cDlzTFNX?=
 =?utf-8?B?eU9kQUpnSUNEZEk0ZXFWZTFGN3pSZGg4RGY0QWFJVmNiUEY5Mm45Z3V2SVBD?=
 =?utf-8?B?NmpxYnRsd2VXcUV5djllYnhTbEtFTmxvdTh0bGp5UGEyVSt0TjRUM3ZNSWJG?=
 =?utf-8?B?Q1puZEFaTS9LclRwL2tkVkExb0dGM3V4R01ZSEtqcS9sazJIb0ZmUldNL0d1?=
 =?utf-8?B?Snllb2F5TWdheFliRFhLMFZJMnNzRElRdVNCZnNFMWNXUjRKYzR3bkYrZUJQ?=
 =?utf-8?B?VFVMQnRmY3dSSVdqVzR0amxzTDlKWnVEY25yYmhyOVBGdEs2NkFnR3Q1TjJQ?=
 =?utf-8?B?clRKTHh5VjAyWSs5MXBVcWVEYVkxZGR1TVh2cWwyd2NXNVUzUzEvSUJYTXRu?=
 =?utf-8?B?Y1RSK3RXSUVnK0RhcGZyU2FiNndIVmNCTXpBaFZZeWk3RmU2STlLeWVKTDdy?=
 =?utf-8?B?TVFrZWhnVDBSa0Zsb1U3MnR3M2E0bkY4VjBOWk50NTdFSlloeTVJZHRBK3Vz?=
 =?utf-8?B?VjFIOWlkcHZyRC9MNmJhb0F4MWpkN2x1ZzdiRWRGZkt1YjlhNkJER1FwUFJB?=
 =?utf-8?B?dVpad0dyaWVaQ29ZNVNiTlVyM2RublhNdHljam1sYkw1b1FwcC94M3BCaFlM?=
 =?utf-8?B?ejI0MUVaMnpFZitDQ0toWnlEc2EvR1cxc0JGZVJERWFhcDBHTE9HamU3ZUJQ?=
 =?utf-8?B?MEhHbnA5TWxjMzdrRzhWNC92cklDZEx0cXFVYlhVcGdMK3d1OEZLc3BRSUNp?=
 =?utf-8?B?OU5ockVBWW1yZHhSS0ZFS0pEdGV3azdkcExuUGJwWGF6Q0FBTjEzUlZCQlpP?=
 =?utf-8?B?d0RRbTAydzlUdjlYcG9LZGxuNFQvV0ZXS25naElKTGhpN2ZHWnlXc1ZmTWV0?=
 =?utf-8?B?cEd4STlWNm1BdXRlSUxna05jZjNEaWRTNWhXcXJNK011dXN1WnR4ck9tUmFm?=
 =?utf-8?B?Zk4xK0xqd0FzdUxJQ3BkamdvUFcyVnQ4UHhrUGZTL1Z4Tmc5MVFPV3c2bFd2?=
 =?utf-8?B?K29Oa3lsT1ZLMGhZTURCZHhrNVByeW1LcENyR1k4dFAwY0xvc2s0NVFQU0pt?=
 =?utf-8?B?NjMwSFQ5L1RIb0ovS3FpRFV0TEorVy9UZmw1S2JTUkZXYURxRjdTREt5UUpB?=
 =?utf-8?B?c0dUSTZXQWwzSCtoeDg4Zk5TMzdKdlBUbHFWWEZFdG9EYk45eEFWVUFHQW1k?=
 =?utf-8?B?VGlpcTlJQXpTVE5SSDBhdFVnWVdQNVV2alMyd0lpbHV0U0pmNFF1TStrL1pV?=
 =?utf-8?B?TzNjOG14VnVSd3JmRGJhOWpLeDcvUkhjNnRjZlUrN0RZV0pUeVVJU2tKcWxN?=
 =?utf-8?Q?CsTN/dnKEKEQ8OELYqQjYdMOT?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8677.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d60682b-3e07-401b-edb4-08dccd7a60da
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 07:14:27.4064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yFgk4tcVqTAeeAnDk9sOpkaoMM+QFyIjEGUFtJEexcoF7pQWSRNhk7AJs6k40IWmyaXbprtGjXcNI4w0305USA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7203

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTlubQ55pyINeaXpSAxNDo0NQ0KPiBUbzog
SG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IHJvYmhAa2VybmVsLm9y
Zzsga3J6aytkdEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOw0KPiBhYmVsdmVzYUBr
ZXJuZWwub3JnOyBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47DQo+IG10dXJxdWV0dGVAYmF5
bGlicmUuY29tOyBzYm95ZEBrZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhh
dWVyQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGlt
eEBsaXN0cy5saW51eC5kZXY7IGtlcm5lbEBwZW5ndXRyb25peC5kZQ0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYyIDIvM10gZHQtYmluZGluZ3M6IGNsb2NrOiBueHAsaW14OTUtYmxrLWN0bDogQWRk
IGNvbXBhdGlibGUNCj4gc3RyaW5nIGZvciBpLk1YOTUgSFNJTyBCTEsgQ1RSTA0KPiANCj4gT24g
VGh1LCBTZXAgMDUsIDIwMjQgYXQgMTA6MzE6MDdBTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6
DQo+ID4gQWRkIGNvbXBhdGlibGUgc3RyaW5nICJueHAsaW14OTUtaHNpby1ibGstY3RsIiBmb3Ig
aS5NWDk1Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpo
dUBueHAuY29tPg0KPiA+IC0tLQ0KPiANCj4gVGhpcyBvbmUgaGVyZSBpcyBzbyB0cml2aWFsLCB5
b3UgY2FuIHNxdWFzaCBib3RoIHBhdGNoZXMuDQo+IA0KPiBBY2tlZC1ieTogS3J6eXN6dG9mIEtv
emxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KT2theSwgSWYgeW91IGRv
bid0IG1pbmQsIEkgd2lsbCBzcXVhc2ggdGhlIGZpcnN0IHR3byBwYXRjaGVzIGludG8gb25lLg0K
VGhhbmtzIGEgbG90IGZvciB5b3VyIHJldmlldy4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpo
dQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K


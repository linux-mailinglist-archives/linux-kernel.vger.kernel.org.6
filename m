Return-Path: <linux-kernel+bounces-291741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E16956634
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E100285A48
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23F015C132;
	Mon, 19 Aug 2024 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZeTEwCtr"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010007.outbound.protection.outlook.com [52.101.128.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BEF15B98E;
	Mon, 19 Aug 2024 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058022; cv=fail; b=MB7UMaMBDLhbmcMgKYEEBL1bTdDtv/FwNIvvtN6v6F51/wyy3SzQvSTBu+EbKWyvRuYC29uDYyAkWoqm0NIEYyFVLSOc76ZuglZV5FRr5H7mvtILNwsZUIxHKQCA+OcnGIPlouZb0GMl105GUUve9EqkrKTRqBVAcHGZt+hpHhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058022; c=relaxed/simple;
	bh=huYgos6VsnkEslVMRHzv94Fz0HJFYgkz0mVU89qrpGg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dU8wd6UTis1N8wUM8oaWahu0wp45FCNZLm2JjEEGerGRp7UNYdxEc6sC1E70NPwi4q0JFR220GWAq5gcC5uTFbs5AhOuNl9IDnxeag40WDekoE+sMPPL13JeArLefi/kbvAcPHg/D0Zyjdb5HQzIqXhH9ITRhYUFN5lc1LD3gYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZeTEwCtr; arc=fail smtp.client-ip=52.101.128.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6I7yXud+fpovB24/958AI8pg29X0ff4wU3aaiW54wYE8xPs+msDTuW28IwoNSHZ6QK259LNYalis3h4R2sagt8KU8kmyBZ1J2cG6FUFCP8FF91a2FiuVbkSXR4IAd6SnXxhBWSdpkmmwKQOD2A68kfJhHL58SjIVs0aeQKUiN2GGe+n9Kdn0G1bpRqssgW5E5NqcLdm31++egi9RB5bckhi21iJhhkqbprH93bHGbUsOwmPcTTUAyzO0R5PqYGKep8ADo/ujt5tQ4CRigZcONK9tWEpz7yIeni5Yf7RRgXCjcFeVUwRjNfyC9mVDCZU5l/Fhppr9hjNSU25bE/E+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huYgos6VsnkEslVMRHzv94Fz0HJFYgkz0mVU89qrpGg=;
 b=ZNoQtPWhS23BzSwLVpJMhRCxsjyYBVmhRTvWRLecdzZHlc4J/jrycyeJrEjB55l3O5WbZScweG8KbdOBoMvfxXWUOy+SzajBCA2HUktukVsk65vN+uhxKjnVlbK8kMi5NQJkcGkW32ngajxtyivMwnZAFdPqaY7hJkWtxOgprrIqzv8dafqRrqGMOXcYgdcTTGSMYpK14Fhs32bS3tpLFbcezb6iKqlQsHDiwyWsc34PhvwjsN2ORZDFo17eo3Y3pg4p8Rg2XN/ITQlZdeRoi9JGUrDa3hei1vF/krjQTUFg/nmYLwC+jKCnvDbCSO5ig9e/tBkNhw55QRbRbCObsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huYgos6VsnkEslVMRHzv94Fz0HJFYgkz0mVU89qrpGg=;
 b=ZeTEwCtr3HMwuIqUezqIP20Tz7XjaCwJKhm66KuGl4i6q/01H+6XR5W/zCj3z9/eNFH7Bj6DuBcCxghciqjDlqhpiPBE56ryrjYHkXl9uw1UxmszMxDClsrLsXfKOMZRuKSq28i9rsaA6cnDeVk3g9i9ykDgMLXzjC5nkU7hER+y2QttVYKLcgDvE+WZzbeUCNuH4dmG0TxDnnL/CMNK1byb8gi5dEaEtra+3XTft6NCBktcUMZDBbvKb+kRwXiKfpFE+ZTrb/yRIAN0u0LHcbubBBuXwKJfO9dEsc4O4oGYiIqJb+zyL3O5AuiMVinS2w/+rttdyp6Sww2UfLjJbA==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by SEZPR06MB6599.apcprd06.prod.outlook.com (2603:1096:101:17e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 09:00:13 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 09:00:13 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"quic_prashk@quicinc.com" <quic_prashk@quicinc.com>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject:
 =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSCB2MV0gdXNiOiBnYWRnZXQ6IHVfc2Vy?=
 =?utf-8?Q?ial:_check_Null_pointer_in_EP_callback?=
Thread-Topic:
 =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjFdIHVzYjogZ2FkZ2V0OiB1X3NlcmlhbDogY2hl?=
 =?utf-8?Q?ck_Null_pointer_in_EP_callback?=
Thread-Index:
 AdrvzihtFNSOcxRwTAOIHI6tveAOMAABV00AAACqLAAAAoTOwAAAUcYAAAD4WnAAAUYXgAAAwgzwAIjopbAAAJpGAAAAFMjQAABYSwAAABYTYA==
Date: Mon, 19 Aug 2024 09:00:13 +0000
Message-ID:
 <TYUPR06MB62175889B121F542869856E4D28C2@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB62177737F0054278B489962BD2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024081608-punch-coherent-d29e@gregkh>
 <CAOf5uwnsgcJjp1=RLa7qx9ScQY5rZvwX-Zu6BOqxBBhBCz+CFQ@mail.gmail.com>
 <TYUPR06MB62177BCD4AB43C19E38990D3D2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <CAOf5uwm65Cw-V+td_=6QAGUF+Uisueqcm0z=1zFaNTisAJnSFQ@mail.gmail.com>
 <TYUPR06MB6217877B31A08356241CAB38D2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024081652-unify-unlucky-28d2@gregkh>
 <TYUPR06MB6217D1798DBC41C7DB2A1DEDD2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <TYUPR06MB6217AEF9DD73C9424C7C1D07D28C2@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <CAOf5uwmdf+Vxes6+BQyghbiKByVC_i1RhmTE81_iix99U7HMmA@mail.gmail.com>
 <TYUPR06MB62171FA07658FE6500DB855FD28C2@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <CAOf5uwk-De+dCaL-xZMByFoMoxD7X1_KnOriq1MKAz5s+mOFiw@mail.gmail.com>
In-Reply-To:
 <CAOf5uwk-De+dCaL-xZMByFoMoxD7X1_KnOriq1MKAz5s+mOFiw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|SEZPR06MB6599:EE_
x-ms-office365-filtering-correlation-id: 1c1c9886-950b-4c70-1fae-08dcc02d5665
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SVZzRjVybS9jTjgrSjR6QWVkN1VWcEVXazk1clRsNlhydVorNmR3cnVicTU4?=
 =?utf-8?B?NVVGazNselBwNGlPcHNURHJRaS9YR2FkMmhacjhNelpmN1FGdC96R29EUWMz?=
 =?utf-8?B?SC9NUEMwajJlMHg1a2FoNWdDRVY5aFk0ZUtTNndtMS81U3cwRmtUWGg5ZW5x?=
 =?utf-8?B?VTJ2YkdwRzlxY2Uxb2VJQkl4TkFRbXpCdHI3TWVjMkdnQWxaMVZQQzIxRGVl?=
 =?utf-8?B?WjVxZkRHTC9NWGVUcHRCV3lmM3lJN0NmaUkvMVdnSWJiKzd1WjVJekpZN0lT?=
 =?utf-8?B?Z0Y3U0lRdlpuVmcrKzlpbjFzMmFVQzdsc0k2citKSW9KUDJuL2R0c0gvRXpW?=
 =?utf-8?B?WmFwVnpKQUJsRG9XdmxQcDV2VDNDUm5jQWhZclZiaDlGOU9QamJJcklVTHFa?=
 =?utf-8?B?K2hlVVpic2tLSXM4UStreVlscDRoYXdXYTV3cExpRVdUUHdFSFZRUmdvS1pR?=
 =?utf-8?B?Y0h3a3hWQ3ZqTWdlb0Q5ZEQrckpZZGxob0hoUW54c3hCeTNjS09XQ05yYmlI?=
 =?utf-8?B?YUlxMytZWkRWeEZtS0EwUG5WTFRqVEVQOCtMUElpdVVZRWFvZFhuY3BnY3dU?=
 =?utf-8?B?TU0vbXgveFNZSEY5b2s5SjI2REo3QjRFa3N6RXFDT2lkVnpTZU8wVDM5S1NL?=
 =?utf-8?B?Z3BNeUZwdk0rVFVDNXNpSXhoU3UvRHRxQTZQZ2xTQmxBWUxwVkQzZlVvbTVi?=
 =?utf-8?B?N1B2c1pITW53MzFJNGY5eHFFV3Y5TEpIaDVJSzNsQ25oWHdFOURSMHBGcnNQ?=
 =?utf-8?B?bzlpQzFSZlBmL2VlOFFpSUd1QUZ5TE5zNDMyd2JBcXA0QTlVTGRGeHN4Y01E?=
 =?utf-8?B?VHJqSWFtd0w5ck9CTEowNFhRTTRtS2NOaWF1VTdzMHBxL3BaNVhpWXFYaWY0?=
 =?utf-8?B?bWxMTDlsRkh4V2xET3JlUTNEb0xNWDhFV08yVlpmMXhNajNVcjEzOVZWaHdZ?=
 =?utf-8?B?RFAvZnAvTERqQkVlQS9zdmZrRWVOeklGaDdlQ1lYL0pneDVoZDZEUkNrVjRE?=
 =?utf-8?B?ak1RUDlIZm1kVVNhSE5WYjVPTURHRi9vQ2ZZT3dzRndSRGlYZ0dXa0ppdTJH?=
 =?utf-8?B?UnFMdFJVU1puMjhQQXFMK1dVenNRQ0IvSk1pSUlaaitWZ3N6M0xPUHFtcHVm?=
 =?utf-8?B?Ym9LN1doaUtJRXQzY09nMjFEWXJmOVVlZWpFYlkzVC8rOEdaNVFiVnNhQ2NM?=
 =?utf-8?B?VS9QT3J6R1JRVUJmUzZocFdUMDRFMFhVcjlQbVBzekJUZUdrQ2FyRE83M21x?=
 =?utf-8?B?Rnl1cjJzMUx2Wk5jQXY5dlpxVHlYUHhneGg0akxDSE4zb0c3ajcvNjRIRFli?=
 =?utf-8?B?cmpRamUzVGJrN2NUQjRGMHRVcDhKV3V6Nm9jdFh0d2kzOWRPRkdNSXpxVTBV?=
 =?utf-8?B?WUxJWWRyc21UNm5WNU9ZSFJ2Rk0ya2UyQlV4aXBzMGYzUUxrQml3R2cyWEVa?=
 =?utf-8?B?VHFWZG53WGFSaEp0czlpYzdlNlZEbjZhaDF3Rk1abWVDdFhZL3dLMkUxalB5?=
 =?utf-8?B?QjBqbGRZcmlGOWRsNXgwaU1xS2YwaEpNSVVsUEx3TGR6WE8vS2JMVWZNamdn?=
 =?utf-8?B?RThueWM1aEZZZDVOOVBlYmpOSm5NbnNTcHhBbjdhRjY1eVJkU2dpMGhXc21w?=
 =?utf-8?B?aWFQYW1QcWo2eEl4OTFnQjFnNEpkKzNOaTdYWDNMWDNrTEtTWVRxeTFDZkpj?=
 =?utf-8?B?U2ZzNkdqSVJxTzR4Wk1HcXlVdVdXRGhWcitUL3h6SEVpWWRJNTVLN1lERjVH?=
 =?utf-8?B?TGptWFRaK21WYmgvVVNkam54NVd4cWlveUNsRy9EdGFGTEplelJqVTI2dnNS?=
 =?utf-8?B?SUcxUVc0bDJxc29saE9RVEVkbFJOVnA3clV5bkRDOGpHMURIVjhUYXVtZnRV?=
 =?utf-8?B?aGdqQ0VLSGRKdUM3UXUyNXYxWTM5VE9EbnZxcXliTnFKekE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGtLQlVJZFFKME5vOHVVNWNGd0h1NCtUWEsweHp0UmlDd3FtemdhbndZUTUy?=
 =?utf-8?B?b010UzNUR0pqM3YySXN3dVBtSWc0S3Z3ZFREZ1ZURzJJNzZHMTNPMytxR3cr?=
 =?utf-8?B?dkdpeHJlRkRnZ1FIY2FNTXNVQWIweDBWMVBxMGhjSlQ3cTVjSHMrOW1FMmdW?=
 =?utf-8?B?V0hHRUJWazljUTJqemNHcmlEVllEMDBLZkUyOU5ISjcreHF0UlVZZ2JoaUxx?=
 =?utf-8?B?RkZydFowbkJCbU1rSnN5cUhoTUlJRHFOUnpuODBhenZabnQyK1lCQzlPcXlh?=
 =?utf-8?B?S0h6L0loVVZTNC9RUzYrdllqWjk0Q2tvaUR3RTBZcU8yL1JUZmpFWkVPWDRj?=
 =?utf-8?B?ZVJuYWkzOEdXMkpqMkdwMkRZUjdPRXdFSmJDVlR1M2J1U3k0RElaUEpUSWhh?=
 =?utf-8?B?b2wrZFNJYUJXRnVEb1lZRFFCL0VjZ1EwN1RaWm9yOXQxZDdzdFM1eFNjWUtH?=
 =?utf-8?B?SXNKMGdTd2tLdzliMUNJblVoNUNubzFoRjlHWEEzSU8vVWE4YlZicUNHTWNu?=
 =?utf-8?B?eEdzQkVZZFpVNm1zSXBzN0lWRXM2SUtBeEJxSjBxWmNzcjFVYzNYaGtzTkhq?=
 =?utf-8?B?d2tuazRMR25WYXNPSktLVkZEMGZ1YzZkd0NoTCtZL2RTUHpkdU5HZDQvQUtP?=
 =?utf-8?B?MVgzRGt1dWtXeDRPVmo2K1lYR2Z2QVBtaFgvQkFaTzEzY3hHV0dUYTZ6SDJp?=
 =?utf-8?B?ejdLOGoyd0owRmkxOXJMMXpSbG1XUDlrQXdnTDBUTlNnZkxudHFwa2J2eGZM?=
 =?utf-8?B?dzRRWnZTRExPRWtOL2V2VzdnQVhUMkhpdzkyMEtlNWpCYXdRMHV0Wk1iL083?=
 =?utf-8?B?enppZnB0WStWaS9ZN04yN2EvOWNRem5HSllaRlVQMXp0NFFOY25BTU1CZmRa?=
 =?utf-8?B?Mk56Nm1OMTM2c2d4cXZucUNrQVZLczRZdWI0NXo4dk1teUNuSkJGV0ZQSjIy?=
 =?utf-8?B?Zk0zdHNBMTgzLzZCS1gzeFdKN2VUSzBxMTUzY2tsNGRFejcvZnNJN05QdzRZ?=
 =?utf-8?B?TU5Od0tZNTJWaVBkL28xcVR6NTNRZ0Jxcm9vUTdacGV2eTdBM3lTV1lwMlVa?=
 =?utf-8?B?L2UzQ0NJOGZwSmhaM1pNamVvbmpyVWdsczdTd0JNQUdNOEpBdURMaFhOOThq?=
 =?utf-8?B?V0Y3Qlcvc1RmMzNjd2VqNzZteGxBTTR2SzNUSzZPU3BsbVI1Yk1zVXJ1L1Nv?=
 =?utf-8?B?Q3BjM0wxNytZd0liWkF2ZjJLT3lHM1lrZWdpRnFRVnpKQldNbmFwVExNQWJ1?=
 =?utf-8?B?STBzWGh4bGZ0RmE3ZXRibmdkQW9uaFpSb1MrSFdXekZUc1NLZE9wcHNvc3Fv?=
 =?utf-8?B?WG42QXB0ckg5cUp1OGNhK0ZXQk9SQTNMbjhmQktnYkM4dE5VV2ROVG1JajQv?=
 =?utf-8?B?RzRXeFdDOWNFMVpzQWVpWFp3Z0VKMmhNTjZoUThwS2V6bWpITHlqclF1VFJj?=
 =?utf-8?B?T01nZ29pQ0k5ZHpJR1Zwak15SHc0Wk1weFp2cXlBSjBhUFZ6NjhRSUg1c2FQ?=
 =?utf-8?B?ODRBZWVrSGliWFdJTWk1Wm5HQ2Y5emVTYWF6UzRMNXJMSE81N1hXanFQZllv?=
 =?utf-8?B?U0gyN1Y2VnZobU1sS01HeG5pL0RrdUx6S2grN0FIRXNYcm96aUIrT3Z2VHd3?=
 =?utf-8?B?ajAvSGRxY004cm85SDVFY3RzSEg2cVNOcXNQR0V3REFIb1o1dnMrUEM3Q0Uw?=
 =?utf-8?B?WVVNakRHN2V6TGhpUE85U2xZc1c4Qi9vNzAxVzdkQXI2by91RFZsTWY3UnJI?=
 =?utf-8?B?bXVzdlo0UTc3SHFybEIvTTZVSDM5QXp0OFhmM3ppTER1dlE1akM3UXZ5aVRI?=
 =?utf-8?B?QlZ1Vm1YdmlIdGpZREJwbGVrajFkZ2pxVU0vZUtqV3dSK2MzaFFxcXkveHNi?=
 =?utf-8?B?MFNZUTIrWlMyUmZxN3VoU245bWt2aU5qTnQyMklFVGtmaUoyUG9OR3ZjMlBG?=
 =?utf-8?B?d0x2bHo1eDNZbkpxRThocmVPejRCTzZuL2ZZMDlFaXFqOENpbnU4TEZBcUNn?=
 =?utf-8?B?NXJxZnRoTE5MamZnSnArb3JxS0xTV2tMSWlxdzNLRFQwVElySXU0aDBpSXhu?=
 =?utf-8?B?WFN5aGFmYlN5RDlycTUzS3FNbzU0VXRhV3N5bjFHaVhxcHd5UHEwbzF4RVFp?=
 =?utf-8?Q?2Dso=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6217.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1c9886-950b-4c70-1fae-08dcc02d5665
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 09:00:13.5184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gqoBZmnqhP49DQ/IhfiYQ3OZvJ6E8eHXSbCGQvZnKcvSnupWLOc4Ncsm7YEGIbCiMmdYLW9TeOJkuk2KNUHKeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6599

SGVsbG8gbGludXggY29tbXVuaXR5IGV4cGVydDoNCg0KPj4gPj4gPj5JIHRoaW5rIHRoaXMgaGFz
IGJlZW4gcmVwb3J0ZWQgcHJldmlvdXNseSwgYW5kIGRpZmZlcmVudCBwYXRjaGVzIGhhdmUgYmVl
biBwcm9wb3NlZCwgaGF2ZSB5b3Ugc2VhcmNoZWQgdGhlIGFyY2hpdmVzPw0KPj4gPj4gPiBJIGhh
dmVuJ3Qgc2VlbiB0aGUgcGF0Y2ggZ2l2ZW4gYmVsb3cgYmVmb3JlLCBJIHdpbGwgcmVhZCBpdCBj
YXJlZnVsbHkuDQo+PiA+PiA+IEkgc2VhcmNoZWQgZm9yIExpbnV4IG1haW5saW5lIGNvbW1pdHMg
YmVmb3JlIHN1Ym1pdHRpbmcsIGJ1dCBJIG9ubHkgY29tcGFyZWQgdGhlbSBhY2NvcmRpbmcgdG8g
dGhlIGNyYXNoIHN0YWNrIGluZm9ybWF0aW9uIGFuZCBkaWQgbm90IG5vdGljZSB0aGUgZm9sbG93
aW5nIGNvbW1pdC4NCj4+ID4+ICBJIGNoZWNrZWQgdGhlIHN0YWNrIHRyYWNlIGFnYWluLiBUaGUg
cHJvYmxlbSB3ZSBlbmNvdW50ZXJlZCBzZWVtcyBkaWZmZXJlbnQgZnJvbSB0aGUgcHJvYmxlbSBy
ZXBvcnRlZCBpbiB0aGUgbGluayBiZWxvdywgYW5kIHRoZXkgYXJlIG5vdCBjYXVzZWQgYnkgdGhl
IHNhbWUgcmVhc29uLg0KPj4gPj4NCj4+DQo+PiA+RGlkIHlvdSBhcHBseSB0aGUgcGF0Y2g/IGFz
IHN1Z2dlc3RlZCwgaXMgdGhlIHRlc3QgbW92aW5nIGZyb20gb25lIGdhZGdldCB0byB0aGUgb3Ro
ZXI/DQo+PiAgV2UgYXBwbHkgdGhlIHBhdGNoIGludG8ga2VybmVsIDUuMTUgYW5kIHJhbiBhIHN0
cmVzcyB0ZXN0LCBhbmQgdGhlIHByb2JsZW0gZGlkIG5vdCByZWN1ci4NCg0KPkl0IG1lYW5zIHRo
YXQgZG9lcyBub3QgaGFwcGVuIGFnYWluPw0KIFllcy4NCg0KPj4gIENvbm5lY3QgdGhlIHBob25l
IHRvIHRoZSBQQyB2aWEgYSBVU0IgY2FibGUgYW5kIHJ1biB0aGUgbW9ua2V5IHRlc3QgKHJ1biBh
biBhcGsgYW5kIGNsaWNrIG9uIGl0IGF0IHdpbGwgb24gdGhlIHBob25lIGludGVyZmFjZSkuDQoN
Cj5ZZXMgSSBrbm93IGJ1dCB0aGlzIG1vbmtleSB0ZXN0IGlzIHJ1bm5pbmcgYSBzdHJlc3MgdGVz
dCBtb3ZpbmcgZnJvbSB1c2Igc3RvcmFnZSwgdG8gb3RoZXIgY29uZmlnZnMgcmlnaHQ/DQogRnJv
bSB0aGUgY3Jhc2ggaW5mb3JtYXRpb24sIGl0IGNhbiBiZSBzZWVuIHRoYXQgdGhlIHN3aXRjaCBp
cyBmcm9tIG10cCBtb2RlIHRvIHZpdm8gaW5kdXN0cmlhbCBtb2RlIHBvcnQgKGFkYitkaWFnK2Nz
ZXJfdHR5K2dzZXJfdHR5K3JtbmV0KQ0KDQpUaGFua3MNCg==


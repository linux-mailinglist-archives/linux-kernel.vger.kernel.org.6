Return-Path: <linux-kernel+bounces-263348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 946D493D4C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04272B2300D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857F83D69;
	Fri, 26 Jul 2024 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="pI6UR9z5"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010071.outbound.protection.outlook.com [52.101.229.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263A317E9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722002767; cv=fail; b=bf2rMkA2ELHTlotDNco50E+V0h46iNXdjIq+OrRfL/TaWSZdup87KbhipCIVibokpDcuL+BNuVrBwlqtogdAtbjUZtQ6LogmlP3p5q/7oo7Opu0By+b0tsvWue0IazakwCHxvP1vg9Nhc74WwAr982O6C7qJLaNl/TH75c69QGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722002767; c=relaxed/simple;
	bh=B/KSEbDijW3AiGnqKmmPdfdedvr0/c3DsWbEefNOFgY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A/9l2tuIbarlKZiuXchHa8g3z1dcokkrbCgaoHZqG/KqZlHITNemo2qa2yrwRMANB5IQaYee2E+2AiJiCb8wnEmuYaCIdWYGYc+pLRZzOga2SR5+mBwd8g4bn5s0zc8r9qejB+ZUBnmeAIpRWN8IfjQgs7P1OGu07pUf7FOM29k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=pI6UR9z5; arc=fail smtp.client-ip=52.101.229.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIAqiFpAFKB1cYe8Ki53iyKqbStPC621F0cwY23pymZFOujCWOzH1u1Gs610SNdTXNm3Em95lhqM7lrWpugVIMWKnBUUGrk/LYVJGHN8tYDVs1CAD6gO1l5g/cGbupIbgvmBsIq/BTR8CDA7/oP/XE4vZSfq/ng2Hcl3J2egzEb+axxIVjq5GA5/jorGDR3Kk0pea+TiL+rMz06ktiKyScQPLq+XMk45sAAFidObWHckUIapv1P5V+/O0wZJ0QkeuZJ10ILO6LgCuoOw3ss43mcIAzKgEgPX+rEtNvSO1EpUvR/DC5sZuaRo7ljjjF72B0wPs1Jj74jtQlYxHBeiuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/KSEbDijW3AiGnqKmmPdfdedvr0/c3DsWbEefNOFgY=;
 b=bYFWE4RROSOerHEzeiz4VJ3/JcSs1LZjaGums7/2oEqRbkWwYKJYAZ9w4vbiNGBN8S4n/6JX/CggQ9rnrgo3rcpXZ7bsjmEtK+M4wZZTSUiQF3720ZvjGIF/xdYm8K5qC1zYgw5I1uZq1GET5CugjW9t5ak2oV9DBQtffqT9J1XxE1Zeqa5Ngux3plsOQ5A5ZOFEXw4n35u7XWdT7cCXB+ZzbmofvjGqKwFiKPbIfU1gS5xXrdaYcImEa/jY30yk8FTqjPpPb2nd09vPb4htl+rWAOIakJwpduc2D6HwugWw9loPw7b1Vt7CDkov6pmy4836E+hcaxoSNw6J49dKtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/KSEbDijW3AiGnqKmmPdfdedvr0/c3DsWbEefNOFgY=;
 b=pI6UR9z5FFOhftQbZlCmOEpyQ8q+njmo+wTSqV9d/7RI1EAgK5g0rvClhjK9uSMm7DIf0MCwQWU8WabEqf+LK0hZB7I3NMhDC2I2sfGd10frwpXIv1lc8fR8Rw1qLaZ7a1O7PHWe/34rf9uM0uAKNAvZ7g4JxXq44Z+8zNUjQT8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB10230.jpnprd01.prod.outlook.com (2603:1096:400:1ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Fri, 26 Jul
 2024 14:06:00 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.7784.029; Fri, 26 Jul 2024
 14:05:52 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>
Subject: RE: [PATCH] regulator: Further restrict RZG2L USB VBCTRL regulator
 dependencies
Thread-Topic: [PATCH] regulator: Further restrict RZG2L USB VBCTRL regulator
 dependencies
Thread-Index: AQHa32K5B1UkfS85S06Nx2zgfkMBQrIJCsJA
Date: Fri, 26 Jul 2024 14:05:52 +0000
Message-ID:
 <TY3PR01MB11346BC381DF5469C5E2195CF86B42@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240726-regulator-restrict-rzg2l-v1-1-640e508896e2@kernel.org>
In-Reply-To: <20240726-regulator-restrict-rzg2l-v1-1-640e508896e2@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB10230:EE_
x-ms-office365-filtering-correlation-id: e24fcd78-426f-4e09-e5f4-08dcad7c0f2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2grYVZkQlBvQy8vaThzNVhvT2hiUDJ5a1ZuZFR4STNLS09LMFlDZlBTZENF?=
 =?utf-8?B?WmpFQ0xLUmtuVHdlNEt2SEVsV3kyOTlGY2ZocDY0NXQ5QlFSVkRZV3NCTmFJ?=
 =?utf-8?B?aWJQUWNEYmNIa0d2ZnNOSytqK2pNSUVEVGhEQ2p0M25lRVU1MlhES2RGNm9M?=
 =?utf-8?B?SG9yVmxEeDVMUHJjZHVUL2ZYdzZaMWt2V2hZblNSQ2tURWt1WVdzWC9IbTVX?=
 =?utf-8?B?UGFtdEYrR3ZkWW5GeW1FNFB4a2VobnhEd3JxUWV0bFZyMkNFQ2ZTY0I0bDhu?=
 =?utf-8?B?bEF3MjNBa2lVT1BIRk9MZEpVT080NGx5TlpieEdBMDY1MitzVU5iTERQWENW?=
 =?utf-8?B?eDFYcVZUUTdKalB1WHM4K3FVYlhGeE1hTlRjdzEwVDNKT1ZpZW9GU3FPQkZS?=
 =?utf-8?B?a0JFSnNtOExHVVp5QThKNEthaVlDTm9SOG94VXJlYU5kOGJuNXBtNUx6U3hn?=
 =?utf-8?B?VUpKTXB1RTlqL3ZnZkJnTFZmMGw3OFRHcCtWNEcvalZvWWRtbXFIL2VGREFR?=
 =?utf-8?B?MkpoQlF6bmtrbFZaaDdaM1NWNElKdDNCSGZLL3hoaTFKcTg3b2IrQzcvWmJO?=
 =?utf-8?B?Vyt2YWttdUJxS3ZrdElaY1FNRlNQa09CeEMzV3E0Q1VPRUlGOUdrQ3cwcjdV?=
 =?utf-8?B?WnVXZ0Z2V09BVVRiVkRxQXhZbTAzL2dTd0NaU2VQeEhrRmdSMjJoOWtEMDND?=
 =?utf-8?B?cnBMaUNCV0p6NHNoZU9lM1BKeXhZNDNnbHNYYWNrYmFiSm1XZHhqZjg2YXZl?=
 =?utf-8?B?aGxRajc5V0JLUnZuOXh3QU04bEZtc1NMWGREeFU4Z084aXArOE01WDZQVG9n?=
 =?utf-8?B?aE1zNFR3L2d6Qk1yWVU4Vy95MndMYmMzc1VOOEsxdUF0SHEvWFBTOWh4dFNU?=
 =?utf-8?B?TXhyYS9JNVp1Z0ppbk1zd3VUWXN6bTNGOFRyM0VDbWFrcWlISXVUcFpmcHFt?=
 =?utf-8?B?U2dvdHVHUS9DRkgyQzFJWTc1K3BnWjlSS1F4TkY0NjlVWUxLRHcyd1ZvSjkr?=
 =?utf-8?B?cHBWUnlBR3VxT0xUWVR6MnVyTXBRelQzaXpCMHVyMTRCVklaL2NIOWMwUDkv?=
 =?utf-8?B?VmpZdkJuWmp3VmtkZUFSUmZDdjErOEhHMlFhZEMrMU85dmpZbFFwWUNsK0xO?=
 =?utf-8?B?MmM2Y2g1QlZ6c29FRkdNMEFJak0yT1pJemVsTklXMkF1WVlVcTNVNEgwQlkw?=
 =?utf-8?B?UWU0eVhwMitFK0gxeFdaa2kxWW1keHN6VVBtVmNkUzQrT0lzcER2RStCejFQ?=
 =?utf-8?B?cjNvL2ZnQ0lSVktoQVovNDdXRHhGQSthSE0vNmpjOGxBdGpLZi9VR0tRemFI?=
 =?utf-8?B?d0VyYVZiVXJmR0V1S296dkdDTVpuNDk5cWNNYVRrd1RSOWhvM0VJR2xnRVc4?=
 =?utf-8?B?WGtJNnhNVGRWbXQyUTZ5dFU3SzVheTQvQ3BQSUJHSnVUdXAwaVZXTGJRUXZX?=
 =?utf-8?B?ZDlrSk5ZSk9DOFFrTFgrZHpzK0tXY2treEE0Q2x4SEJTTjU1emJaei8yM2Vt?=
 =?utf-8?B?VGJNaWtPOW9FQUMva21keWFnQThJQXZsemtTbmEzYzh6dG80Q2swM1FoQldC?=
 =?utf-8?B?QlViQWJzOCtMSDY0MEZyR1o4djRDbjZzakVsVll1UGtQdWRDRkpORGtoTlNj?=
 =?utf-8?B?ZzFhTE93eEtMU3FnSXRQM1NrYzhQYkJQUmh4dnJhcnBKSStTVXdlekZqemw3?=
 =?utf-8?B?M21ra1pKZzVXSVRFZTNEV2xlaVcxT1ZnVjQ2eEl1VDRvL2hHSkdzeWFSb1NO?=
 =?utf-8?B?VGpja1JBZjIyNkovblZGeWg4U1NXaFN2QXVicE5DU2NMOUovWmo5bE5qZFE0?=
 =?utf-8?B?WEFibmFtYzM1NFlSVlg2R1hQWTR3cURTcERHN3Z3Yjczc2U2MlhNUXNDejE0?=
 =?utf-8?B?dEF1T2gvUnFhMnhXSHNvMXJoQ25QR2hGOWh2dkMwT0kyV1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWFZc0E0YVh4bm9Cd2s1MTRhNXNBaUJ0S2lpN08vVHFIa1VKQmVIdTlpQmg5?=
 =?utf-8?B?ZDh3TkxPRnZiMC8yM3V0bUpNWXhzYldveFUwWks2NDI3U1U2TFZnU2N1R2RS?=
 =?utf-8?B?OWJ0MmxuREJVd3ZGN0RqcXZKQkdDSHNmRVdPd0pSNm5sc01qVmUrZENMTmtj?=
 =?utf-8?B?bkg3VUxnaWM5UjZIdGc3YXlQelZJS2lGL3VEYVE0T1ArUFFFcHlVdTRTM1di?=
 =?utf-8?B?V293V0JoeURBbjE4Z2NBeTZ5ck1haFRuYnl0UmRYUWhYUUdNajl4TDhBYnRC?=
 =?utf-8?B?TTNZUm5MYVF4N0ZFTmJFNmJwbHpMOWprVk9vQWVuNjBWRjBMRVlicmJyZ3Vh?=
 =?utf-8?B?SEpkQitsTlByb3RmbWhQaHl2cmR2T1I1UktSd1A5VHMvZTZ2cFMveEVwUjA2?=
 =?utf-8?B?T29vUDVOZ0dpODAwckxqSDFHWVZKZGxZY0JBRGQxbXh5emV1bFYwSmkvU1Fv?=
 =?utf-8?B?c0hXRXpYbjF4cDU2MnZZMlRMRGFsd2F0ajF6S1hTMG9CREdFTiszbkNhRU1o?=
 =?utf-8?B?VWw0WGZOMUdDNDE0aWlJSDZqZGNIZjZqTE9HamM4UE0wbGxTNGhITTQxQ08w?=
 =?utf-8?B?SVdhNndPcmNCSmVPczJXdmdFaWFDdCszbXZlVkJhTCtxSkpidWZHSlBwbmsz?=
 =?utf-8?B?WlVuZGl5Yk9ONlJXN1FIZURtUXc3SjlYQmhGYWw1RXcvVk5kNG5TT1JCZjUr?=
 =?utf-8?B?ZVl0N0ZGTzBiWm5sZ3BUYTNGSXg5emlCVVZYazBQWFlFL2JBWFAvL3RsSVpJ?=
 =?utf-8?B?L2o4R1JrakU2N0NkODZhNEZVKzllamhiSUhTbGRpcTd3NVlMMGZKMnhSSmJN?=
 =?utf-8?B?ZEtlcnFIYnVUNkEzakJUdFBzZ0VYU0s4RzB1VkQ1NjZ4czI5MUVBOG9lNjhV?=
 =?utf-8?B?cU1XSTNqNnk1cjlJaUh5dW56am1EdC9DN0drS2tUZGRZcjV5YWd6YzNubWxT?=
 =?utf-8?B?aTRCR2FTaWxFZk5CbzBZWkZ1T2RFZytwWU5EelRPbEFMOXhLM1ByZ0x2R3BU?=
 =?utf-8?B?ZERpUjBmZHlzYWgxMzJoTXd2QnJZTnJRcys1TU5ua25wNVAzVjVraVYwWHBu?=
 =?utf-8?B?eG9CVTd5SXBGcnJpcWtwLy84akpEVXBBZnNKcW85YWtqL1ZjcDlRcCtFSDNm?=
 =?utf-8?B?QzJTWHdtQkFEUHdRc2lDcjNOQjZtM2lJNzVWcWY3NTNmaFhMelpra2NnaStD?=
 =?utf-8?B?RDN0OVJVZEIreGpnYkg5N2FLRExlQmF3KzJ0SGJKbG4ra09yRGgxcFhNdllV?=
 =?utf-8?B?Rk5MWGxpNTZkK1ZzMGJDZk94eWhsNTI1ZXFVZEtiNnp1M3JEcmdxbW1VWEdW?=
 =?utf-8?B?aEpCcms3cUhpUm9OQVJqa1laQTR1dzNoK3AzK1FuampMNjhUN3VaRTZWV2hx?=
 =?utf-8?B?eVpPTzBKTFZ2MEdpTVVWY0tXdm9CRHhRMElxSitpVDJOdmU2OHA2OVI3Umhv?=
 =?utf-8?B?QmZEVFMrYXE3NW1kSE8rOGw3V3NOblZ2SGx3M2lqNHQ2Rm1uVHZKTW8yamVJ?=
 =?utf-8?B?WG1KVU5oN1N0NXBwckIwc3NRQ2YvU0tzbDRQT2lPcWMxTmo3Y0ozdzBDNzMr?=
 =?utf-8?B?Tk9tOVEyUkJWcy9yakVOZUk0SU9OdlJvcnAva0FDSDY0UHE0OWV5NmR5a2ZI?=
 =?utf-8?B?NW9DR1d5TlY4SThNcFpROVRtOEhuQjdsUFI4Y0IwMlFBUzRGY3JrNjRXQWZz?=
 =?utf-8?B?MXhTYjZ2aHRoU3pHY2xMMmNkQ2Z3a3lSQkZSTEI3WUk2d011U0x2QjhxUk81?=
 =?utf-8?B?NjNXelJ0cTlqbTZ3NHpUYUpQc0xaU1FXcEJ0TVR1SmQ2K2lCNUFJNkRwWkFH?=
 =?utf-8?B?NklmR3I4WXlZMXRvWlBQTng2RDRoNDFHenRnZFB1SWdMSEIxNmZjcXlBZVh6?=
 =?utf-8?B?M2hocDJMb00yejFMM1RmenpGV0h0TE53Nkp2MHVMTEQySmFvem1KNTdMQnJK?=
 =?utf-8?B?ODlBNW9HaG9Ici9rNGZCa1NpdjZUZ0FONEYwc0NjWFBIQ2ZwTFBjWDNRdEVw?=
 =?utf-8?B?WG4vRGt5VnBxQVRyZmpKYXhJUmo1ZTFLSG8zL29iMm1GcVlWdDcrWDNxR3dZ?=
 =?utf-8?B?ZWJaVThZWDhLTHFVYzZmQXNDdFRzdllMOTFndjZkZjIyMlRJUk51TnZTazlH?=
 =?utf-8?B?bVZpMUVMMFNTSUJNWUtQdHpEdzluTzdtRVMzN1NEOHlkeFdLZW0zVDhmSkFm?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24fcd78-426f-4e09-e5f4-08dcad7c0f2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 14:05:52.1638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K8lQccf46cJOMXnhQFiaPKCaBm43cGqAwGsp25tNnAQxPe0g+orrnFe5H3MgXPkwqBwdOnCxWcarVuUQH6DPB/3Jy5dd0Je5pKjr18CHh+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10230

SGkgTWFyayBCcm93biwNCg0KVGhhbmtzIGZvciB0aGUgcGF0Y2guDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPg0K
PiBTZW50OiBGcmlkYXksIEp1bHkgMjYsIDIwMjQgMjo1MCBQTQ0KPiBTdWJqZWN0OiBbUEFUQ0hd
IHJlZ3VsYXRvcjogRnVydGhlciByZXN0cmljdCBSWkcyTCBVU0IgVkJDVFJMIHJlZ3VsYXRvciBk
ZXBlbmRlbmNpZXMNCj4gDQo+IFNpbmNlIHRoZSByZWd1bGF0b3IgY2FuJ3QgYmUgdXNlZCB3aXRo
b3V0IHRoZSBVU0IgY29udHJvbGxlciBhbHNvIHRpZ2h0ZW4gdGhlIGRlcGVuZGVuY3kgdG8gbWF0
Y2gsIGFzDQo+IHdlbGwgYXMgdGhlIGRlZmF1bHQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJr
IEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+DQoNClJldmlld2VkLWJ5OiBCaWp1IERhcyA8Ymlq
dS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQoNCkNoZWVycywNCkJpanUNCg0KPiAtLS0NCj4gIGRy
aXZlcnMvcmVndWxhdG9yL0tjb25maWcgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3JlZ3Vs
YXRvci9LY29uZmlnIGIvZHJpdmVycy9yZWd1bGF0b3IvS2NvbmZpZyBpbmRleCA1YmU0NDYwNmFj
MTUuLjU1NjBkYzRkYjk4Ng0KPiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9yZWd1bGF0b3IvS2Nv
bmZpZw0KPiArKysgYi9kcml2ZXJzL3JlZ3VsYXRvci9LY29uZmlnDQo+IEBAIC0xNjM2LDcgKzE2
MzYsNyBAQCBjb25maWcgUkVHVUxBVE9SX1VOSVBISUVSDQo+IA0KPiAgY29uZmlnIFJFR1VMQVRP
Ul9SWkcyTF9WQkNUUkwNCj4gIAl0cmlzdGF0ZSAiUmVuZXNhcyBSWi9HMkwgVVNCIFZCVVMgcmVn
dWxhdG9yIGRyaXZlciINCj4gLQlkZXBlbmRzIG9uIEFSQ0hfUlpHMkwgfHwgQ09NUElMRV9URVNU
DQo+ICsJZGVwZW5kcyBvbiBSRVNFVF9SWkcyTF9VU0JQSFlfQ1RSTCB8fCBDT01QSUxFX1RFU1QN
Cj4gIAlkZXBlbmRzIG9uIE9GDQo+ICAJc2VsZWN0IFJFR01BUF9NTUlPDQo+ICAJZGVmYXVsdCBS
RVNFVF9SWkcyTF9VU0JQSFlfQ1RSTA0KPiANCj4gLS0tDQo+IGJhc2UtY29tbWl0OiA3MTY0MTIy
ZTI1YjE4ODA2ZjVkY2U2OGM4YTBiZGFhOWU0ZjkwMmE1DQo+IGNoYW5nZS1pZDogMjAyNDA3MjYt
cmVndWxhdG9yLXJlc3RyaWN0LXJ6ZzJsLTA4NGY1NjJlZTM0NQ0KPiANCj4gQmVzdCByZWdhcmRz
LA0KPiAtLQ0KPiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+DQoNCg==


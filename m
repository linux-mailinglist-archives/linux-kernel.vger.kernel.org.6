Return-Path: <linux-kernel+bounces-386472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BE99B43E6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4561C22177
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D640203711;
	Tue, 29 Oct 2024 08:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="TWnF0YCC"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2090.outbound.protection.outlook.com [40.92.62.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E922203702
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189456; cv=fail; b=ISSR/NZFkS6R66nCaO67PlK74dJRQWuueHcG9kURotFAci6BZaU4J8EuKuVQDcFUpVgdM4EkOlHxQPKb7Z0D8pB5ipizj48KojHxOeox0ttE7u3ZCR0FUQkX1K0GkdubWGSlIU3teaUZEjmyofKWNsdrszKEDuGFM0+zscr8+Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189456; c=relaxed/simple;
	bh=zIW+6ryMgaBOwWaNzycbcOHs0kgPKmpQ0Xl+cM2GKfo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W1A53a8zVO2ygtVqtgfB7qCTgNzGjN0xWLiRWOgMzMQzPKu66XpxbcNwh4Sv/v6ar1TnjFX7qE6zLfTBpxI7vaLre5Pbuaa2Fo7v9Ki4D8Acy5RcLUOVP+RY/Nt184PoKLsqDmdwexC0sSje59NCo8N2BRhm7kmNvvc3pl2I8Po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=TWnF0YCC; arc=fail smtp.client-ip=40.92.62.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCtoi0yEQ3wV731CJTykk5tPpNjvVw8ue3tdKJizVijnDtnsvieEyCBwtjn86WW6Wl7CHeBtowlt4zJEIFZJBV1UdEoP7NJBhnLQGQrUdFVK3raGA4V6CPKKXfjKghKiyef1lG9wk0R49LOD3+M+LViP5PE+y2bOtlD1kfS8gOUd92jCn4IxIXeaUzI5Pa9msSKm0Xo5gC51gxxc3o2qMIcvhL//96omnx6WPfKdJmJIMA0i6Aoxdc1LMwd93LaZ+YWMQi7wCaprrHM/xcPEECHo3dCDVrzgjzYsdOfIWWfkco8LXJSRgDPpmI0pvBdZy9eIiekvhy4q0s8FT8UFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcDNrAG6NJkFIH3iwRZ5AUl73ORSSO+/L29ONananJI=;
 b=UF4dJWAOIN5NjnsIw5oFQYo5KHrlHGWQCjUD+QNzCiXonDLZPpCIhatK+XijAgSFLTJqbC8QZRNq492aH0BKhZ7m7P5M6HJmWxee7AMK3JNwyLLH66mHVIiAhaBW+YzhYRF8gI/b6NC8/R/E782Pu92yNl8oMamVPCRvX7MZ/iqDWvewcWyo0T0L4qojlW/DLfrK6HVMpC5xtKwQYfiWXm1EajdPtA//gs6bLDIcb/xTfmdxLl2qCnLkKisDcEBtKxO6eMoz577lawkWvYIHdvnanDnVPajJ7K1LSDsvAyNOIFBCk2CWLVH7zfDMIsZR4PTCeQkYvpj+M9Q2tWSDug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcDNrAG6NJkFIH3iwRZ5AUl73ORSSO+/L29ONananJI=;
 b=TWnF0YCCLsbjbsAzTkDDDQ9WWMFNB7adtcxpi+TPU5DWxkfkX983PNr2++Ic6N2UtaJFP5mlEcwsvGtMB6QJlYfudmFlun2wHepBACCFzQsRf2Hu/7Pbb2tMycD5X/nnAtnWodGzMvxggXd/ZeltOcYsO1ZCG1DMm9t3jBIv11LkyPF59zHmmvZh4IUe/yI/cHK6x39mdnXLCME3Nw6mPo6gd9lK7joOEmAiNPuNcumpDwdF4SUnoiTZQsv9tF5k9XrQStq+XGzjDHnchSyAj3wc/pJSfvXA7O1e5vPU4H5Q90OHgm4uTmA+xhpcI9w82WG5TqWhTig9pi2ipNigeg==
Received: from MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:159::11)
 by SYYP282MB0911.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:73::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17; Tue, 29 Oct
 2024 08:10:50 +0000
Received: from MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f65e:52a:9bfb:525f]) by MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f65e:52a:9bfb:525f%4]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 08:10:50 +0000
From: Ryder Wang <rydercoding@hotmail.com>
To: Waqar Hameed <waqar.hameed@axis.com>, Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>, Sascha Hauer <s.hauer@pengutronix.de>
CC: "kernel@axis.com" <kernel@axis.com>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ubifs: Fix use-after-free in ubifs_tnc_end_commit
Thread-Topic: [PATCH RFC] ubifs: Fix use-after-free in ubifs_tnc_end_commit
Thread-Index: AQHbGydq3UGpSRV3ek+T5tpnLt8T+rKdeqgF
Date: Tue, 29 Oct 2024 08:10:50 +0000
Message-ID:
 <MEYP282MB316412B08A32373E5ED9B896BF4B2@MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM>
References:
 <1225b9b5bbf5278e5ae512177712915f1bc0aebf.1728570925.git.waqar.hameed@axis.com>
In-Reply-To:
 <1225b9b5bbf5278e5ae512177712915f1bc0aebf.1728570925.git.waqar.hameed@axis.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYP282MB3164:EE_|SYYP282MB0911:EE_
x-ms-office365-filtering-correlation-id: 2dbf20b1-4006-40c6-ad25-08dcf7f1337f
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|15080799006|7092599003|461199028|8062599003|15030799003|8060799006|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 92RpEKHdeEztnFw+QL4VQRRS8ecuplxGZzmxNcNo1WDIEEQfU+3lyTQ8ZldKg11J2SASy6C3vpPer8ipVpQWKUxnGid2pSF4hyHbvG/XQEJD+L3WSYGvMp3WUbXuFr1y/BVgjFOlw2E5gU++zdiOduhZGQ7vho9R48yzjMSwO7kzGZHNsd1YbbpZPh595cbWenQeOzRqhv0Xye9Iy+s8FkPc+LK+K3hO5TqqP0kaKo9i0W8itjt5MoZ3tWiECSHEReOB4y0faRaKs+RXKssoeR4oNqdmAdtoqal01JaE0wxH0fsdUHhbcEVkgaEGVDIZIorFyF/6g8zpMtePQk7AwukPVO83BuADzGTcpF3H7Nnl7r1O9GRZrMhG6Cbx34IlvK22uqe0pCU501v7Xv8JcMlGh8pUDiIp7slsD92F58wb0zmwEwFFIgrL5GR4RMRgZSZ2tk6NSlncl6arhjYtW2U76pxkx0p2RUGvhUJd2lbgiGc4xKJqgL7AwjAMEPFXmqbNjaat1bMfDXBP0iPQNrLFbvZoEkPvQnzzorA2yDq0u17bx8wJxcWeoHRBRJO7y54gufqN2zstvGYfhHUpfulRUKNyQyBUgoBxlVmsxWwcCVb7Z1RB0lXI6LNHPI1J4+I734nbmelReZQTTLJ5klilC2lhqd5+MoCW7/aDzXudx0SDB4upr8NlgaGWA/YDI3OIR5B/a5rrVAPxHaY4AhsR/xojzsvRAqLg8vEAKDbHY/rX0/pPxt4UKCWv2FpgOJLlY56e3BVuG3lZsdk5ww==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?lbqrKLr37kXwngekjm84f1smGG2Hx7AduxZ6ya35wx0kw5K/TTX1hFZO4t?=
 =?iso-8859-1?Q?JnpCssRHa9mNNo2LuKRZ+k0NNf3dc8Jij5Q8JlR40dXAnUrELnLEFQCcNf?=
 =?iso-8859-1?Q?0MORK6hxQ+CokWj8GqJXH31vAUjoa5WlgkEDsKFLDhoTx5UY6zgz0/yX9A?=
 =?iso-8859-1?Q?zACjoC5h6dw0U4+ZrA5mXCCR+ZlFkaBDYTi2UOuFwb3hHIJkvxKVwiCjs8?=
 =?iso-8859-1?Q?47/RxbNr+i4FDG4UewXtOJ9BGOOYq7i1CQIPMNKxlfrOPmi4nfnLuB0nK5?=
 =?iso-8859-1?Q?oxHnc9I/4SXux452FVUZJGowS4/EDHTDAqUDlFoB8mgQKzhZ1UaqdfIJus?=
 =?iso-8859-1?Q?l/8BDiy4+f4GPvproq3bb4SerEExMLv0UdHK0NGvYx9Zt2mKHhWQC2r/9J?=
 =?iso-8859-1?Q?KlEZnlUhHvS3VZlXfooL5OceIaDLtz1ItJk56aTKlBdyKYI6pNTCStNNkZ?=
 =?iso-8859-1?Q?gj4xjGiqx2ODqa7ecx2aBX1oR3qbWy/48YG070RwVOf2gOeq3CKXczWllj?=
 =?iso-8859-1?Q?SKERcM2gt18ycvawpZsVfamFKfqzszMteTKDUFegWevBdX8NlPoZJ2kpnN?=
 =?iso-8859-1?Q?EvIVLB2dhloWwVOSEvj1mcXLwG4Sd1qjsb9EJ4mcOFoSP4WwDnqXEJgHXI?=
 =?iso-8859-1?Q?jfpx2NdgsFR9YjXQDhDLPLzGbS8mdc6GZUGcKc7/lwHuaPN+8JJ9H5TTt5?=
 =?iso-8859-1?Q?w6KlPjhf0PEpQOFfWDfAv1WLhw/90OoxPVPE8fb4YeMC/lnah9X2zp2EVO?=
 =?iso-8859-1?Q?K+GSioMQ273xTqlcUfaqWZ2g4xJ5xneJ/eFgact2yx06UlBfe3xKFB/HtL?=
 =?iso-8859-1?Q?OcZoLzdvOVT9+ZmgQczQjwswASqWnCvQdij39K0WnuQ6HGfOvnqZF1CaBG?=
 =?iso-8859-1?Q?XwdPbz7HePpuVrFJV1eJP65CA8pO9GKV8F3eEo2B5UmlMzOotkQEAZHwh4?=
 =?iso-8859-1?Q?rCninyChkI46ahKDO2Dztd/JAKhuqJ6/7TeQWy2o2xV6hAZbwGLtBcY2+o?=
 =?iso-8859-1?Q?OPG95tfW2rcATcPOJJlJoxU/GoPdtvs5X/r7xkmFOS65FehcTdlP1SASH9?=
 =?iso-8859-1?Q?nwS8SUtWMYrHgS4Mg/nHon/imHGgT2ZZ20TY/6ixdKLvT8F71wlxCOrjP2?=
 =?iso-8859-1?Q?7sIaJ2oP/qC5GEflwy4t90P3+itNMOsnfo8k5ut0DeT5/9/6gD9tsmclhA?=
 =?iso-8859-1?Q?1dMfo7gH6hcLVC3/xsLUAXl05xlpukkSCdzLF5kpnYR9JK5WtFJiWsO3+C?=
 =?iso-8859-1?Q?2GTdnJk7g7DPF1IXFiPd2Zpd8S3nn9tqWptzDMju4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-722bc.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbf20b1-4006-40c6-ad25-08dcf7f1337f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 08:10:50.2646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYYP282MB0911

I just have some interesting finding.=0A=
=0A=
The code of the function write_index() has a race condition bug. c->enext i=
s used in write_index(), but it is NOT protected by c->tnc_mutex. So there =
must be SOME race condition problem. I believe some znode may be corrupted =
or misread if 2 kernel tasks are operating the same znode concurrently.=0A=
=0A=
The code comment of struct ubifs_info below indicates that c->enext must be=
 protected by c->tnc_mutex.=0A=
---------------------------------------------------------------------------=
-----------------------=0A=
 * @tnc_mutex: protects the Tree Node Cache (TNC), @zroot, @cnext, @enext, =
and=0A=
 *             @calc_idx_sz=0A=
---------------------------------------------------------------------------=
-----------------------=0A=
=0A=
That's why I don't think this patch can fully fix this issue because the ra=
ce condition is still there.=0A=


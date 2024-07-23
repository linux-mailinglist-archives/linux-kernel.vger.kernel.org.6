Return-Path: <linux-kernel+bounces-260031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7093F93A1C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F95282F59
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C836E15381C;
	Tue, 23 Jul 2024 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="J7ca3obn"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B72C152792;
	Tue, 23 Jul 2024 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742089; cv=fail; b=tRhRfjTq9QVgG8+i7iLp03wXbn6qEinYPJfPdxFeHxV+Hu56So4Qf/8qpy6LS9JS7qz3vt/O5/J2E40u9u5uehZD8aLzPQIMQGHy8Vb6eJDxiCMyT4J7rWg5ZPPWl5qynW3bl3StD8PP7N3hGTTyf2qt1WWOoNz/UCI97P/dLPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742089; c=relaxed/simple;
	bh=KTS9g4AwtVVNqYgMqv/bPYiFvflCpGYfgqQYJcVFYSQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TKdA0Cg95dkjLfkNBlP7TUIUvTJUax25H4JiZHfvmrT6KYJ9z0jg/NXidAIL+xlil+J26BzVLoeqfowmCp1/QjPyr1GHKiOIos3AgLyxHRr6X7crEE5RQdy6TD/FH7EBdJHn5I1VhMhEC6cMRW1Q3p8icPiC8n9hEnLtMzL0dok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=st.com; spf=pass smtp.mailfrom=st.com; dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b=J7ca3obn; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NBvsOv025870;
	Tue, 23 Jul 2024 15:41:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	STMicroelectronics; bh=KTS9g4AwtVVNqYgMqv/bPYiFvflCpGYfgqQYJcVFY
	SQ=; b=J7ca3obn6ttz3w8uYaCUscA7aDN7wZNDNbgzlKhQTlXGnlgQ4PvrdaR2Z
	M62SDtCLhrqdf3mm9xRyAkhMomjOJ39p3Q4GEn3OQn5kK2x5Q8V5OEMjm+ISIVLR
	ceB9uV1UeDk39w0cmiAPyhvIzpiJupsLZe1xOnX6yNeyjtgICc7kvljxCQCLTK69
	N0LvMJAQM7CCoaqC6RMorR5HVsMwrlbIZoFypHj/4AApRI0OmUQBPSbGsru2i5x6
	pENmHTkRQ9Ys1jTuj5lpQi+xru+9a14PKkAhz4jrvthue+8jXaOtEySS0R5Ap1SJ
	1mtMHOOPz4K55u0XL5TTcZGp9lYjA==
Received: from eur03-vi1-obe.outbound.protection.outlook.com (mail-vi1eur03lp2109.outbound.protection.outlook.com [104.47.30.109])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40gr6j0n2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 15:41:06 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAYqbA70PWowj6B1Zv40W3oz8MDtCCEICRN0Xp7ZMB9OIhFCeG7TTS/GWoVWS7Tvco3mIAQ1RHkXIRA9ogZA94sL7W7OCN2BoSHG6IQNyg/m1ydNM2op30LNQN9+74r8onJfp+B1fykHRnp8nyRqfAnmqzigZ2F3P5Oi1JpVsVS7C2lF30OsLatxWyGvRZaotP75Zm+1RKfuAqRzP5pdADK23JjzfTOYSuSzIKekn5RONHgU0Wvyiee2/JpjdeRccS3/OTArHshQWzjcgk0XLTyC7IZWQCx97GLLWSSSNTiFnohPN2AztWE4fhhdzhT+Elz4vkm6vxlxpCYtiAkXyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTS9g4AwtVVNqYgMqv/bPYiFvflCpGYfgqQYJcVFYSQ=;
 b=oYYdyuuXTnlfnmAnpLdRKz0Y2GlZyRt00gXf0AJJeOaJEAgJ4rcx6bLKPV9U1KyQK+iaZOBLuKtdiDPmO5wwzYexhowaETNIe+PmcRbTAUWxxanx2SOwzeG0RakwsBhaOFbxbMpzReT7v8QsuDtuJySPt9KkrMeb0TDfJILZCyx+fnifQydyWNi9H3YwxFAA3W9j0OssalIowz17xplNerFZvwZ5LFR3FkSOgqm3Z7+/wiQW8ywyFB8FTFUJzni1msMZSYmgzOBtpidGa6KXobjdaPuffjr3MzpsdQjVoPKH4lLNiRm2vXE4hez/raLxKQlHmyPECrj/yoB3RkGE6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:157::13)
 by DU0PR10MB6827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Tue, 23 Jul
 2024 13:41:04 +0000
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6004:1d1:46c2:e67c]) by PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6004:1d1:46c2:e67c%6]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 13:41:04 +0000
From: Etienne CARRIERE <etienne.carriere@st.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>
CC: "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>,
        "peng.fan@oss.nxp.com" <peng.fan@oss.nxp.com>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "quic_sibis@quicinc.com"
	<quic_sibis@quicinc.com>,
        "quic_nkela@quicinc.com" <quic_nkela@quicinc.com>,
        "ptosi@google.com" <ptosi@google.com>,
        "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>,
        "souvik.chakravarty@arm.com"
	<souvik.chakravarty@arm.com>
Subject: Re: [PATCH v2 4/8] firmware: arm_scmi: Make MBOX transport a
 standalone driver
Thread-Topic: [PATCH v2 4/8] firmware: arm_scmi: Make MBOX transport a
 standalone driver
Thread-Index: AQHa0u8lRQx8FsF4PkWEhz6Bko1+qbIEGDlT
Date: Tue, 23 Jul 2024 13:41:04 +0000
Message-ID:
 <PAXPR10MB46879DC8AB435367E0D3C251FDA92@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
References: <20240710173153.4060457-1-cristian.marussi@arm.com>
 <20240710173153.4060457-5-cristian.marussi@arm.com>
In-Reply-To: <20240710173153.4060457-5-cristian.marussi@arm.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Enabled=True;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SetDate=2024-07-23T13:41:04.094Z;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Name=None
 (Unclassified);MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_ContentBits=0;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB4687:EE_|DU0PR10MB6827:EE_
x-ms-office365-filtering-correlation-id: f865ddf3-a39c-4113-aa27-08dcab1d192b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?5XLa25B8aQmtxqPolwxKgnJug75j620IXp/l5Nvclgr4b+w8/NIUE59j3J?=
 =?iso-8859-1?Q?LZdZm5UoQo9FmG5QregiXOCr9Z71XaYfa6/IsIC0gTeL3A4dUhGaQioBZ/?=
 =?iso-8859-1?Q?SS40ZtIfK4ANZVPQcr64jS2DlC3ctLCeU7FhD3EkKWSAuToICza9PtG2it?=
 =?iso-8859-1?Q?KDewhZXwJFs3SuX64uIJlqQ6ADRWkoVZ1isAHQrHhFmxx2QeaxKaTXRdkF?=
 =?iso-8859-1?Q?gCGgJtMf1oMOM+/fqNKaaQvksxN0KA0ORaURKRKytMsjU+RVY7AnH/5iZ+?=
 =?iso-8859-1?Q?qg+edj7naQGiriuOoFBahUYkqc1G1e0KVssPvYkRtr/dBFtSCxt2yBRsRt?=
 =?iso-8859-1?Q?jyYqz+gADcm2TsVBqH3q0jICGHonHUVsoUgolM3DeHj49oVFSGStZkl2gw?=
 =?iso-8859-1?Q?kLQiYGNckaVdWejnVJ9pWyUXcS7PQePGnS0+E4GEuwiJaS34QSpBbr0eBg?=
 =?iso-8859-1?Q?dACvhR0jXGkmQR/xY1rlBBB5E26pdFjwY4RdCgetUX/e02yWPCWcO5mbfk?=
 =?iso-8859-1?Q?iYJs61HPwD1/TPRtik9zA13R35tM6xF0iqa5IqGJ/cXljMRgi4Lcg5l91K?=
 =?iso-8859-1?Q?4Uj7Z9I6PRskdss3XhQh+KAJboONU6Vsz52K8ePI3kPQ9VZejjFPYDoCK+?=
 =?iso-8859-1?Q?QOmU5Yry+64a6fxmM+MXrprRQtd1p3Rta15MP71nTWs6AqcYJtPRb/4ISi?=
 =?iso-8859-1?Q?0Ohz32CsYmsLnzgHVxgZ44OOtx4pmrjMi/dvJYh43UkIZ5lh52h2qn1YI9?=
 =?iso-8859-1?Q?+zDje95rbasch5k3GStz5SAj4psTJ8vNPN64+kMhc4kguBpGkmv4SQHolX?=
 =?iso-8859-1?Q?cND3I56JEd2WSp6Yuwo1lplDtRj9qWwaQ/+8arRwhZPe5SQXGElSLT4Lwj?=
 =?iso-8859-1?Q?zRJx8pBqCbsMJCtDFPTetpAjtZcBQo8H785oyMGasBj4/YknsYoVT9iG1g?=
 =?iso-8859-1?Q?e6tqD/0djUWewg6JGO25uK/TweiPsqizi1c9SZNDnyUameFxWyM+cBDnis?=
 =?iso-8859-1?Q?xg6q+qJNHO/K9V6+NAaGA8vyoTe8JQ6l3ZhgKK4gRxDk1VVpT0zIlltLqH?=
 =?iso-8859-1?Q?ieWh09Ds6zpsxKJjo8/cIhG7VGjJvmHMAbVijyLNWEhfm8NWA2x81yHOCE?=
 =?iso-8859-1?Q?3rSn+n9bSobfqfATnMibd3jK4k6MN9LHwnjwK8H/UnRSWfYWZ1D4AXU184?=
 =?iso-8859-1?Q?txnFR3wBtPh96bpD3/6q5vVb79prArXBhlyNkW8ciCt7kXY01/cw3u/dgO?=
 =?iso-8859-1?Q?BbMgPsjAluVMiWJIHztWXJzSREE31AosrHhc7uge8LvqSC/X577aFMypu9?=
 =?iso-8859-1?Q?UHRaqiZ3cq/6NWgl6iiwKZo0vwFxCRLojKU2ImgtOnjLl0YPb+gCPaWiJn?=
 =?iso-8859-1?Q?wuCbYWXEXFTRAKccU8M0/coomiqiLv2PXgKqkPQH4feo57g9j4hw8iBtso?=
 =?iso-8859-1?Q?hZUsTf+kWlfPqzOBz7rZpjF/JmtfqZwxl4Anrw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?nT61MSpFwa7JK7FCS3A8vfy9vk9scVGTXQ+NiAWOZSYGeZy28yfFm3WfSF?=
 =?iso-8859-1?Q?RmAMwIeXglIpegBZmmmuGeRGtJ7U/ZXTR6pnU3t3tcmra1NlauHFGFc4t2?=
 =?iso-8859-1?Q?HTTd6HK5RK0luKldZ7fcBF1L89byVVYcPbU4EY9NPEw+m+YVIq49AuD1K8?=
 =?iso-8859-1?Q?07U9rbTXodhKHTUxPbUKpzqWtJFegLc+xs3uMh1qc9LucgRPxEJmxvgIij?=
 =?iso-8859-1?Q?e309a/3vnp0cDrQTy9xqsX32EXoUZVBftDMuBBOm/qtooBCk/7aZ87vtzw?=
 =?iso-8859-1?Q?5Urtzz73cAU9MP1PaWf0m1RHh9ErzvbbgDiWnXcFjvhH7nyhv963icSWeH?=
 =?iso-8859-1?Q?26qf/wOgSuU3btvpFA9+EQ6u/qvjSITDE2Q9EJRA+OrZChi8jgF+LXzjCs?=
 =?iso-8859-1?Q?DeUDMA+mAmxvDFi/kNS1rnhJEgs8RHjCdQ/AkpyhEXwQAgmUAbj5+aDetI?=
 =?iso-8859-1?Q?6MgKklkx5vedgcZz9QgrD2trvAFLcAJQwstZZCX9TGwQ1QPWHPr8HgEPF+?=
 =?iso-8859-1?Q?R0WbEaNQmnC8pbnw9GmFMFVC5Ecmg1jruNE+fiUu8iRvZc2WFH0VabwR8x?=
 =?iso-8859-1?Q?6AmbN47L1xh8lv/t4Efy/ke/HYwV2A73ui1gjwHeevnhswclessO7ZTsBC?=
 =?iso-8859-1?Q?VTsTuJxTrXfU6foDJJ9Nt4p/S2VopOa4pc2wBXM21RysDMm2i40wzfvTMF?=
 =?iso-8859-1?Q?4I7Wn4OaVNuRnrnb1HQyERTQVosD/iZW1BvTB5z+pPnGDS4aVS1+ykNEYu?=
 =?iso-8859-1?Q?4MOTNd2MJl16Pz2vuE56mBVDO0kREtFxAmJZMhZ/K//PMM5Oa0vJ5xZkEs?=
 =?iso-8859-1?Q?pHdldxKp2DTR/UGUsTOvDIIl9H+k2y1A1dzCR32055aQGUZbCcu0WaXrf5?=
 =?iso-8859-1?Q?T5soEVv9I/WjIzhf6UTpc6Pcx68R14+vv0g/BdBpVQ+Snbwj5UgUzW5KZo?=
 =?iso-8859-1?Q?HjX8B2NqPi9jYFU3OuW++SF/YNcJTmBiciniToSEL3/RI06eE4rXokNddA?=
 =?iso-8859-1?Q?UiIN4RyoOWHOzHKV9zKsH0rQhSxpwws3X9Jw35xFyvEJSBdZsMhByG13nm?=
 =?iso-8859-1?Q?HlcZVqLF/fem3r5Cx8cvrKiIadSLhtLU2xtTjadB8qumFfwvPvHj97LCUo?=
 =?iso-8859-1?Q?5yeZSREetS8JDMIL2ROtelqouA7bUhbg92TnC/6JGVEuhlnqXrdCfAnqwS?=
 =?iso-8859-1?Q?rq7qnJmn4YngQ5PRhC5yR04kVqmvr+2ipdyZM23DtkCFtKGGsQL4UJBMde?=
 =?iso-8859-1?Q?cukkeDx0Gi6/nm6YQackEuqUI0nqbeqalnJJYNamoroPHUls7EIWzFnVMS?=
 =?iso-8859-1?Q?0sXJJK/TLM9uW7bmzQb944pvBpDpbAcMp0Efgw+Y3JCftZFaY+I2Zsoq3r?=
 =?iso-8859-1?Q?C/Kiin5gXp/KF+J5zQot82h/kqnMnBG84TtCPf7czSX4bAvwp9bnnlbgwM?=
 =?iso-8859-1?Q?dTr+8LPvsWzKLsASETAm5zrxiIGT1dJ3i9tgDWLXEUX3EB0Q9KyLaX/8Ql?=
 =?iso-8859-1?Q?PHto9B4ONKLyvuV40yyDM1MjlbstSkkVeMO0ZF1kxHQs1gzsHNMVZrZ4DW?=
 =?iso-8859-1?Q?v9EctmgBWuccqrvTk6bElHd3eFSSJMQ2piSWl9YRsBGKoORkTT1BM5et9Z?=
 =?iso-8859-1?Q?WYR/g6j7tDFVz9HbPB8cwdWzUJ75XLzIW8?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f865ddf3-a39c-4113-aa27-08dcab1d192b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 13:41:04.3880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NiiUSvfgkNccPGWdDj79/ZvrELRpECLcut00G4rc5P3EFUCHglGhOS05D2DVNTbgSByOBTGWhmo8GTVcZQBLTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6827
X-Proofpoint-ORIG-GUID: Xr91KRCepMq9F1wIjldHcgcazbK6fS3l
X-Proofpoint-GUID: Xr91KRCepMq9F1wIjldHcgcazbK6fS3l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_02,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407230097

Hi Cristian,=0A=
=0A=
On Wednesday, July 10, 2024, Cristian Marussi wrote:=0A=
> Make SCMI mailbox transport a standalne driver that can be optionally=0A=
> loaded as a module.=0A=
>=A0=0A=
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>=0A=
> ---=0A=
> =A0drivers/firmware/arm_scmi/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 | =A04 +-=0A=
> =A0drivers/firmware/arm_scmi/Makefile =A0 =A0 =A0 =A0 =A0 =A0| =A03 +-=0A=
> =A0drivers/firmware/arm_scmi/common.h =A0 =A0 =A0 =A0 =A0 =A0| =A03 --=0A=
> =A0drivers/firmware/arm_scmi/driver.c =A0 =A0 =A0 =A0 =A0 =A0| =A03 --=0A=
> =A0.../{mailbox.c =3D> scmi_transport_mailbox.c} =A0 | 44 +++++++++++++--=
----=0A=
> =A05 files changed, 36 insertions(+), 21 deletions(-)=0A=
> =A0rename drivers/firmware/arm_scmi/{mailbox.c =3D> scmi_transport_mailbo=
x.c} (88%)=0A=
>=A0=0A=
> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scm=
i/Kconfig=0A=
> index aa5842be19b2..135e34aefd70 100644=0A=
> --- a/drivers/firmware/arm_scmi/Kconfig=0A=
> +++ b/drivers/firmware/arm_scmi/Kconfig=0A=
> @@ -75,7 +75,7 @@ config ARM_SCMI_HAVE_MSG=0A=
> =A0 =A0 =A0 =A0 =A0 =A0available.=0A=
> =A0=0A=
> =A0config ARM_SCMI_TRANSPORT_MAILBOX=0A=
> - =A0 =A0 =A0 bool "SCMI transport based on Mailbox"=0A=
> + =A0 =A0 =A0 tristate "SCMI transport based on Mailbox"=0A=
> =A0 =A0 =A0 =A0 =A0depends on MAILBOX=0A=
> =A0 =A0 =A0 =A0 =A0select ARM_SCMI_HAVE_TRANSPORT=0A=
> =A0 =A0 =A0 =A0 =A0select ARM_SCMI_HAVE_SHMEM=0A=
> @@ -85,6 +85,8 @@ config ARM_SCMI_TRANSPORT_MAILBOX=0A=
> =A0=0A=
> =A0 =A0 =A0 =A0 =A0 =A0If you want the ARM SCMI PROTOCOL stack to include=
 support for a=0A=
> =A0 =A0 =A0 =A0 =A0 =A0transport based on mailboxes, answer Y.=0A=
> + =A0 =A0 =A0 =A0 This driver can also be built as a module. =A0If so, th=
e module=0A=
=0A=
Nitpicking: replace the 2 space char before "if so," with a single one?=0A=
Applies also to patch 5/8, 6/8 and 7/8.=0A=
=0A=
Other wise LGTM , but my comment on patch 3/8 that would affect=0A=
use of DEFINE_SCMI_TRANSPORT_DRIVER() in patch 5 to 7.=0A=
=0A=
=0A=
br,=0A=
etienne=0A=
=0A=
> + =A0 =A0 =A0 =A0 will be called scmi_transport_mailbox.=0A=
> =A0=0A=
> =A0config ARM_SCMI_TRANSPORT_OPTEE=0A=
> =A0 =A0 =A0 =A0 =A0bool "SCMI transport based on OP-TEE service"=0A=
> (snip)=


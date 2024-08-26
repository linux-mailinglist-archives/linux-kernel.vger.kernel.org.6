Return-Path: <linux-kernel+bounces-300715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A48895E780
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6481C21000
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 04:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2999F450EE;
	Mon, 26 Aug 2024 04:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="YYnV5Sf7"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020082.outbound.protection.outlook.com [52.101.128.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C552E419
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 04:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724644966; cv=fail; b=OfpgVfnr0VeN+99AXp/Rz0NY6+Jz9RNEq3eMiee/RNVm2wp8DTjkI27NBOiC0Gfy4jkMKYnY32ZEHvHhUgpu4wn4DpIqWIIUz1V/1aaZ9u7K2lHwVpMuEpG8LFbfJEUKQ6I9H+LkdwS869hlr8BhqHfH4oS8GFBh242PgsUmEWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724644966; c=relaxed/simple;
	bh=Y7BjIWjbq5wh6DH6CX3RJuKET0NWxxfbiznQz6EpEMQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BcuP+uO/93SxsHxDY7HFcSV+mmu/3NDMgiiGjppAqyiTb5Td0WDBK0IzVz1pwV3pRBfVD86LE45dTCSDdZf3gETubUlJtrG3mGeDakl40hfFpMR7XCvViv3DgZOjvGEHt8CAk3cJlZyHgpTQIZApt6y53VBYzr8mmSE5OvZGg1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=YYnV5Sf7; arc=fail smtp.client-ip=52.101.128.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vm8+buEU+spOwPoBkjsQncqgnGYSwk3wf3rlNWEx7JRxl3L2Y3nJ8uM1aiVRdlwR23bTXVnhTL037T5M/m++RZgD6tvmcLDsnDOzYXg1CQ7SanPS8ozwOWS//lv8FUVbXFSZy6U2cG+ripoEvPmglCKRvvOk8GsrSZqeeMfe1hoKjhkVBnlseuWmm5HVaz3Y3UuZ4qDFY8N0U0toBYaGap25ORfrcRI8+VKN62qlNVbQIzFyx8T7U+8LdpdbBO1D/HL+jVjaNl45dz1HTL26S0DlYW9nUWnU/xbR49vvET+bzHoolii7O3iTx3rGyWiBZSCyD86HMC8GV0VlKnpsdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7BjIWjbq5wh6DH6CX3RJuKET0NWxxfbiznQz6EpEMQ=;
 b=UcrSYCiYEYGA+Vmb0DDkUbRH413NF3PP9Ao/h4E81Rk/2kwIhiFeIjECQTHjAQoaOtHVQb8QlxXPOepEkUDZqlEEHkon08KubqjwRBbnurWVFtOnaqr6IWYarpFH12BkpYOix3ZO6tT9ciDbpzB+EMRtMCyoIJt4XlVIkaQTLjonJ3C7nlPd430C9tEYJo/6J6ntae4UU+DpjAF21QU8X61f/5SKp+AIkHTD4m5Pfs6+uXMpmisKmEFEZTJ7vWf3tv8Z/jA4XotQL+huKGLqQh1awwoV0QggSUIy2ywGuaXpaw2PXZzwhU/YSk0MOjepsBxsjM0mAkBEJhEfhXkuVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7BjIWjbq5wh6DH6CX3RJuKET0NWxxfbiznQz6EpEMQ=;
 b=YYnV5Sf7OeB82elP85aM/uLDQ9H84nmg9GaULmbUPsBvOtI7v8ROiENsoWKa4WbVZ5SpvjsRbB+Os0JkEO+YlVRbE4QKqvEx1h2E2sGonZ7aRKRhi5qmzo+QR1APAvJ21zNXUOGMMqLiAPOKv1icbXzttQFm3LaoIuWX50pc3LMchDuSOqqnYiTqqukIejCFBSNV6zTsshK8S+MzmC8RK+78qApZfAPeUVizKmSBnaaPEUdZC14Fwag/4aPRk5XJCu6MWX2kqaV7o3dsSTSJ4jBxhpkB8Yc1wojwPaIoL17bLiGRuV7qVzTOR+TuEnXPO8aiIlHKs1bqEcSutzWxLA==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by JH0PR06MB6535.apcprd06.prod.outlook.com (2603:1096:990:34::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 04:02:38 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::814e:819a:7d52:7448]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::814e:819a:7d52:7448%6]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 04:02:36 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] i3c/master: cmd_v1: Fix the rule for getting i3c mode
Thread-Topic: [PATCH v1] i3c/master: cmd_v1: Fix the rule for getting i3c mode
Thread-Index: AQHa92luFhaBtkW4zkim60IDu6KoKLI46okH
Date: Mon, 26 Aug 2024 04:02:36 +0000
Message-ID:
 <OSQPR06MB7252463A7C81BF18811DB6EC8B8B2@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20240826033821.175591-1-billy_tsai@aspeedtech.com>
In-Reply-To: <20240826033821.175591-1-billy_tsai@aspeedtech.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|JH0PR06MB6535:EE_
x-ms-office365-filtering-correlation-id: dbf8d73b-296e-43d1-1d64-08dcc583ebeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?+46fWiH1BRji+56B/nthaG79ZOobUcabqTBRwsHx71n5TkqTNMI9zQF5K9?=
 =?iso-8859-1?Q?eMNNiBHsRtdIU3EuND8GIZvSD1NP2cPAwiNRIhge0uz1thwgwMWY27zGsa?=
 =?iso-8859-1?Q?OAdMsZlpop1sJr3Svq0RUyBAcH4+ObnytmvEskpFOYhRPchk+AEbe0bMli?=
 =?iso-8859-1?Q?uBtez1OCZ51l2SOxIIrRi3TVy13xgdiQqnx/MmxFGwuoFUvxpQpOplabLE?=
 =?iso-8859-1?Q?kZQ3FDTXwiTLKOSWutV39f3H+H5jInPqh5xITTssQOxv3C3LWMylIA+jez?=
 =?iso-8859-1?Q?852Kb1cG8HL9PmnAp17nmEfCqODT0eKu+zhfOaZVNVJnW+zcLyGSlZ7QJr?=
 =?iso-8859-1?Q?EAf0C1sxhFRwKNHbtfhqsdCwOfgHug/XZQdWhx0WB5j8Qc7kYvwqVMhZon?=
 =?iso-8859-1?Q?3sMfejIEe8i/WJEqvUHm78VVt1pmtYHq9NnwalcmNrfm5bR0/kX6/AxeGy?=
 =?iso-8859-1?Q?YUweAkSQQa7EGjhsb0iPJrH7mptVf69cgHz6i6FQoCi673TL3sUPl6sruR?=
 =?iso-8859-1?Q?ssPqgD1b0Whom7V9CiHT509bKeGRiDAl5mvnZhRjtmodKVNr0la60Dmk7A?=
 =?iso-8859-1?Q?6ckonaK8hL3LcdP+ccdjNGIlZzZ/f0MShGzixifvjz+tcLM8jFYTuOpjOK?=
 =?iso-8859-1?Q?qtaCLIrnvzRoIlXYYQyVmeYoadFz4P6WFUYPTKQz1mumLu1kC/m2vQMVY2?=
 =?iso-8859-1?Q?kqdKLSo/a7WSl65alUwBt3g/yWLqvcMqbCd2OKM75opDZ91aqdFrO4Bnm9?=
 =?iso-8859-1?Q?PAJQLp3J+vQdBrY57biwgmFa5kfRVsJId5xowJbFy3kAhsIP4bg7RkjoLc?=
 =?iso-8859-1?Q?D0OBL/WotRGjaAfUaIGVc0j0u3bYKAKY+pzWBruNq7RVKwGwrTsTsYw3jP?=
 =?iso-8859-1?Q?UZItc3u1MLlVEfytFg+SY9npivJyjwRbwjdsTskDjmIa6vO5bmKcyv+iPK?=
 =?iso-8859-1?Q?wr4yqJGLvIsHDIV9x4/jx0yPnSmuhiVgLuxtJfuuyj7e5td81DoKRi8tmU?=
 =?iso-8859-1?Q?epcax7RR4giT8KezCzIQFGKwehdwrvM+qw4Z/JQ4UgTte6nJBp7E+yXL0p?=
 =?iso-8859-1?Q?F2HXnAf3FirTc7Qyh2s5efR01s/2dTF1rjkGNuR5qJE0jc5QJfvTTEqL5N?=
 =?iso-8859-1?Q?Ax3aqTdkdUQHIRCYY3wZqDejYPUWqVvPovKE0TOcpX1d2jDeoZ0N1SnYMu?=
 =?iso-8859-1?Q?0v/T6n3LW6ReTqrOrA0fCX3RHy8Lq5RlEzm1zeFtb4bqJg9oDRowBPN2+t?=
 =?iso-8859-1?Q?+jkzqxrnvk3Jq4w7MuscXdL8DTocK6HvwroyZz0D24XJfZJBn4RIp3gYOR?=
 =?iso-8859-1?Q?NBMre/9W/PCjGbQUiuLZwu3q36WLMf/pUq1CO6zN3Hn/qehgiY4WAUaJMF?=
 =?iso-8859-1?Q?Q2LJabjKSWfwjTmU2USXmZ/zJw1iJj/Vkh73brTy8gGIBLIuDtHgX1oeBk?=
 =?iso-8859-1?Q?ETWGXy2i0ZxUZQYfbm5yCE7MKVy7g9o+9/qToQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?45gnaIdWqJNNSQbhBGdmAG7zDU+VCa7WnfvftRJWw8cfa59kt5mYloPVaD?=
 =?iso-8859-1?Q?+TTa39KnfqWJRnWyb8ujcZisp5ivYckrA/3adVpvnrZbfuAAuKXajxFhXz?=
 =?iso-8859-1?Q?SiaucA03OMbuJXtno439knKpm4JG6e2jAXcqJTkQxya2pBPJ106uEddHUi?=
 =?iso-8859-1?Q?KHaS61ACURDuf9KudrhRVqHx6rAIYZZ4h+Lvt9JwYGjhgr/XW+SghYQEl9?=
 =?iso-8859-1?Q?NDD+qJpvRyi5XgtHCOhsO23qhsdBRq4cDFuvISJStLPgs7tl8cy54g3VbX?=
 =?iso-8859-1?Q?m66cV9SH791rS5bhJnNX2VubY4nbMPDDMsnm8sKQglmeDpEGhBdPKHa4mE?=
 =?iso-8859-1?Q?Dig49mXcFeCTApd3DEaoXKW+KvauVvG998UyQzA30hb1XoiPX3Yp4hlL7F?=
 =?iso-8859-1?Q?v+0AzfRfufIGKKMkkQymMZ0fYD0HWoZ5Vu20M7dwlB+spTt4WWQpa+AH1M?=
 =?iso-8859-1?Q?/3VNGwc+PL35+lcSAqBLsm5qYNgU1LhK0WkZiP2BWDoBMKz4Fati2W6tGx?=
 =?iso-8859-1?Q?hP7CKPx76tEsaBNV3sCStdJ/POGN2NWGieZt3wrQlzhd/EjNQ0HGj1UYF8?=
 =?iso-8859-1?Q?b6uPHnHoqdG/fNv+f8651dQrc/e9Zorw7k6mSB76PMTuWHGlX1yIsT/pIW?=
 =?iso-8859-1?Q?AMJ3yo2HhXZnoPS4YSr26hpTVl68xofPErVggi34YNkcNSBwqRrBmJ96EN?=
 =?iso-8859-1?Q?jc5LDHwBZ6zWKlwBlql2Z/SG2/No3VsUcB6Mx8Bj83vqnHHaZetaNeqpXr?=
 =?iso-8859-1?Q?SDdCubhJWvpyzBkqjIqqFxKz8P8A6G2FRRPARsmKFPIIjtNdIHgVr7sz86?=
 =?iso-8859-1?Q?rgpat8aa2Bcg0cwrSmDR/nyzYsyRamc5/XwKiRfgURWegrtl1epYnNdM+s?=
 =?iso-8859-1?Q?0/L2gdHDVPee0RzEYdlvmFNlCCVsiPSjFACZgE05eea4j44S84zUaQKMp3?=
 =?iso-8859-1?Q?MhJIri6VSO89smke+hpXflrdAyGTzW5wj+7zzwh3fmaGAj6rjYA3JmAVIH?=
 =?iso-8859-1?Q?o4EjXsW4/h4vCV6aluYxi3ojRdgF9Hz7C/ilSfCUaLVKW0AgCjtlkKVoVl?=
 =?iso-8859-1?Q?ueMyDLOXmkKyI7inmxG/HHLjCntN8XpiZkjsN5a2GzRLe2O9X7nHTGLxs1?=
 =?iso-8859-1?Q?LuxCwfG4Qepf3FPMiZgDviclov9KoZ0bVAyyfVRhHYuZ0ZPP0drBYqRSBY?=
 =?iso-8859-1?Q?ENsUb5XlSiDtu5SX/VNAC7AzGWv6hSbZHAn+N/pswE9Riq7XsH9KRXYhbV?=
 =?iso-8859-1?Q?xVEsapgEG7BOXqyYk/DR1zEoV0zDFyu+P8hsdCDues3kwLfIyKWMtgy61R?=
 =?iso-8859-1?Q?RVWWwDWmnwmd1Gkt2I4Ung92PU/YZAJlnZEPIDRhH0r8FIaDblESPECTih?=
 =?iso-8859-1?Q?zXyPY5zjyVLsSDobudpbHzyyfzXvZ+XQ8H8Hp+4nxTd7O7fqTXvLblzRKu?=
 =?iso-8859-1?Q?qjvZe4KSgn1Uu+BzZI3OWvQG1PzBiaTNvdFqgT5sM+rItm0eFhDuJ6F6uj?=
 =?iso-8859-1?Q?RHpILusazJxi5Mu4OHCHGvQOh38uUX+Tnd3gj7nrmiWpReiJSmyogXWUSN?=
 =?iso-8859-1?Q?lN6OVQ5VCybYOXiVVyMzks2HCTz5URDuuqWj0JoOl+vvQR3Ib8FrakT0Y3?=
 =?iso-8859-1?Q?3Dy8ad4xjfUwHiHy3qAPfatMVFNqRak2JH?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR06MB7252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf8d73b-296e-43d1-1d64-08dcc583ebeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 04:02:36.9007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ed0n+dMl2i2nRw6GJhk1+eAX8KpsWfbQ6FXrLpeAkXYDvCHiy5r1XBuZhGIk5yV8dykNyiGo3VJdvFoBA9iTZtUa9B9maqxG8ATJYQ3rKI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6535

> Based on the I3C TCRI specification, the rules for determining the I3C=0A=
> mode are as follows:=0A=
> I3C SCL rate > 8MHz: use SDR0, with a maximum data rate of 8MHz=0A=
> I3C SCL rate > 6MHz: use SDR1, with a maximum data rate of 6MHz=0A=
> I3C SCL rate > 4MHz: use SDR2, with a maximum data rate of 4MHz=0A=
> I3C SCL rate > 2MHz: use SDR3, with a maximum data rate of 2MHz=0A=
> Otherwise, use SDR4=0A=
=0A=
Sorry, the description of the commit message is wrong.=0A=
I will change it to =0A=
I3C SCL rate > 8MHz: use SDR0, as SDR1 has a maximum data rate of 8MHz=0A=
I3C SCL rate > 6MHz: use SDR1, as SDR2 has a maximum data rate of 8MHz=0A=
I3C SCL rate > 4MHz: use SDR2, as SDR3 has a maximum data rate of 8MHz=0A=
I3C SCL rate > 2MHz: use SDR3, as SDR4 has a maximum data rate of 8MHz=0A=
I3C SCL rate <=3D 2MHz: use SDR4=0A=
and send the v2 patch=


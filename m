Return-Path: <linux-kernel+bounces-425881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D22F9DEC22
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16AE9163B91
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9773B19E7D0;
	Fri, 29 Nov 2024 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PWxACFuV"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010014.outbound.protection.outlook.com [52.103.43.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CE1208CA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732905382; cv=fail; b=cGGKG+gqJNVZthWyA1074RTYCJREzNomdEiYMoq0bBeQNF7i2iDUN11X9Vb5X7xEjvFE+aT3N1UXq+6zCb0XX+e/Pajke1gAbvt3V4RQ2ed0ig62wbLmIBTNJioM8zJOVXnrtnp4WBCwiIAsfHDz/Ps4mp6xctUCOgyGw4UyXPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732905382; c=relaxed/simple;
	bh=GjBQqVRE7q9pNsxIubZuq/TeF9e20eYD6Xxj2EaHHwU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AY9uira4SBiVw2GjzZeXnimb2IXSGW2obA0ufHB8NRfHfRXttO9lTEQA4U2kjkC5DUPkus7J41Ih+ZIiiHZ3fonLJmKCS/lKbwhmHd29vw92WutcjwPTczMsNFOubBCqcSIUp3LHay5tXZUg0MyF6AzV1omYcUPCldyPTm9cPog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PWxACFuV; arc=fail smtp.client-ip=52.103.43.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7Sa9JAGdqtue3ywq753vntlZGkjZFt5cjanJJQ6LO3q10lXMsaqV8PaEl5Km6L6Ktje4zhhF+DtzAim4VGYHDnwkXPBP3DI4zG//1Lrg37ifHiiqrGCfq5hGOK8mMHCNLUOTGw4blZnw+3G8g2u3eXef5zK6MBtKJdmz48YbPfCd7J03llDVefuFv9UrWx0VB/8K6dzSmfhL8PmbOFjJuMCUzUr4YmIOrp+BXvQz2L0GW0tKp2Fd0xJcsV+hF2fcT+gqSjEMyrYysxWIuRTIwlZ5EfbSlN8flfGMJKGnjCHfPmGV9q4QCY40/ZzSyHgQYfI+jn5lw53Txwh7BReWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjBQqVRE7q9pNsxIubZuq/TeF9e20eYD6Xxj2EaHHwU=;
 b=kwqKeWE1GH6OC8cySf/acbrTFMxlZRLTu3CQy87ghSCy+E44xHrNZIdTeEtrbPhARpStNN4xA7oMuZcFGThaJIioLyb5UEkyd/BicY5BzblqcgEG/JaWXGjaMG76v94ZYchAp3Wy22n4p6w+KEVfg31n4mlnR6EiypnRaUp450BcCfWVIb83fnqyyRg3awgas9w6t0kBt/xIGNjaZ5/IzJJ7npt5cOfSy7KDqoxhmKin5IiXEu2Ou5u/5ql+ezOywtdv2DhFCdhQ+uEsK52tHXN1A5Neh6YRsX81ajBxn1/IQjbQF0+G5dmH3c9LNybmn3RoLRNX3QTRM3W2L9R+zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjBQqVRE7q9pNsxIubZuq/TeF9e20eYD6Xxj2EaHHwU=;
 b=PWxACFuV2yHFwKpvaq4wOuSM54gffbdepVqkNJW84Ill12rU5XtDY0T4kVHQYC2mO9ffcXndXYIQl3Cx6VKK85Lb3lWRQbwp1E6mcHb5TBpBvU7uRY9ehrK1TzJODSx+CxvAfDdLKr9qGMwOXEzJWqQUOkKACEb7tQOEmn0YYSf58e18LGLcGAj/vVZBOTZMouuYyBfLMgAPhj+98lrKQE64vox3ewCxuAHQcs/nIyXHSH4nNCHHQjqR3w6oKkZOn/mgCR/O+NWzYDmDVqeL7hVuthJp+5cY26c2Sw0fOaOb8G2vKEpndlAe4sV7aDbjkP2rqCnIRyfNChSb164Euw==
Received: from TYWPR01MB8838.jpnprd01.prod.outlook.com (2603:1096:400:17c::6)
 by OSZPR01MB6986.jpnprd01.prod.outlook.com (2603:1096:604:13a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Fri, 29 Nov
 2024 18:36:17 +0000
Received: from TYWPR01MB8838.jpnprd01.prod.outlook.com
 ([fe80::5a53:4db3:7b07:7cb5]) by TYWPR01MB8838.jpnprd01.prod.outlook.com
 ([fe80::5a53:4db3:7b07:7cb5%6]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 18:36:17 +0000
From: Yiyang Wu <ToolmanP@outlook.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: unsubscribe linux-kernel
Thread-Topic: unsubscribe linux-kernel
Thread-Index: AQHbQo2MwCh71Ahc+k27M/SPxPHujw==
Date: Fri, 29 Nov 2024 18:36:17 +0000
Message-ID:
 <TYWPR01MB88389DCA8E8A3AA99920CB44D62A2@TYWPR01MB8838.jpnprd01.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8838:EE_|OSZPR01MB6986:EE_
x-ms-office365-filtering-correlation-id: 075949f8-b93d-4aae-e09f-08dd10a4b62c
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|461199028|15030799003|8060799006|15080799006|7092599003|19110799003|3412199025|440099028|102099032|56899033|2406899039;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?XPgNi257/QP+7MK7x4z8doazJmFFK+yMQ+EJsWiyTpEgYWd1MuZ5gNZs0x?=
 =?iso-8859-1?Q?CUQbRiOjCBFBNHf24kwwJQ3P0T8BoFXsAIHlm6GAw8PXukIhvKEUmOZK5Z?=
 =?iso-8859-1?Q?mmtfp3xlCOfXwg/c4WqzsBMt9uYe0XJTVWC0KEnOxQyGKBfs7NR5gP5HIb?=
 =?iso-8859-1?Q?G4j5DtQISdp0AOMFw/HWTlLaBEpG8pniscdjYYMuiHJVpi2MBOgmSYTJKY?=
 =?iso-8859-1?Q?kCtCPxFdAXI4ODpUI3SqMbpIt1domcVvLQOiky4YF4/2S+srwKhZbWdTBR?=
 =?iso-8859-1?Q?c0PHOAa6w+MusCwWa26ko+Scw5q5we1hEdlHfkuAclvJA+UoDHRBpdkhmX?=
 =?iso-8859-1?Q?TGXK2q9t1XJjSt/abwSuVXRVP5za597jr9SRjQyac0Dt53wl1InT3km8Q2?=
 =?iso-8859-1?Q?H8qN587wOyT9yHYheOh2O1ut7tJg4CcmbzDe1X4L01j24kLhRIDOQNqzU7?=
 =?iso-8859-1?Q?5Fl+BLJ3odLdeh02fSDa7cCW9GZ+Ew+RBphY6v/Rd787hVsGRBdyccSSgy?=
 =?iso-8859-1?Q?YvyPGAkUZqrDaDaFgCb/PNft2QH8dxfppF50KOLv45vic6L8kc2Sfwj6Gf?=
 =?iso-8859-1?Q?BVBlZwJ4BbZrku3MJ25K/EH576sBwBoWCGc/2HEjfQF4A+jeeFRp03c5i1?=
 =?iso-8859-1?Q?bPi48lMzEkYVsGPACIpkAsm46uldx2K2EhXxg+dzbvzUVJsgusLIxp+L02?=
 =?iso-8859-1?Q?XoblpBGb98MYSyvtFnD3Z2rPebt9SVljMTuIJ1iO4hHh0smE3EiBCfOR3T?=
 =?iso-8859-1?Q?B7eGVRk/+o1k7KzOJOFR218MOhTHinP7Q0fCWkzhvH2tZwS2CFnuHt7wUY?=
 =?iso-8859-1?Q?/socdkVDoZ75xEERXh+0TVJyFb1C4SZShKHWQCi2SWuv9/m4G4yAUMLk2U?=
 =?iso-8859-1?Q?Z34JwauRHEAe64/yWFqoeh/68J2H0qFxsCoihRurpZGb8eWIOhGbc4kO+e?=
 =?iso-8859-1?Q?oZF5OD5U0luG4Qykxoe7Gkf2PxopDJJN2lF9ibMN60nuWN/MoRPE9uxV7I?=
 =?iso-8859-1?Q?JZWEz662p/e6g1K38wKIYqw/fWGGoD8k/i+S7AneChMZLMpOb9EPrsdoqv?=
 =?iso-8859-1?Q?s0VJh4hJbhVaav2mgnRthODeM3MGsQp3GTaqRd8mznJT?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+HCzjSpUQpZ/lxbFL3GI/BcfQa88FJSz1n36E5TEM9crYJ2/lONFdxSUdM?=
 =?iso-8859-1?Q?mdfOK+S/HyEVZNnZRDc8VFi02QXXqrxKesko8V32oYjImxPqcn530kj070?=
 =?iso-8859-1?Q?PsKxmueI4KBnnop2hndlw+zMQJZyochUWbNkja3hU8a5giQvAEonnVvGcE?=
 =?iso-8859-1?Q?7q44+Noqe5OMW1EXP9RWOOMjgXKcOzf/cipZGDpjwA7pqzr50nUsVQ30V0?=
 =?iso-8859-1?Q?4UXfSfZzMDIcpUYnr1ZbpJ5VHC/fiKnwY3sSgWpqgvLm7vB0dRyPKvZNgk?=
 =?iso-8859-1?Q?qvYT75X56AuOmjXVjVMcQPe2gZkdWquwdDl8jIEx1AbMzQ/mkoamv8X1UT?=
 =?iso-8859-1?Q?O6NiYxaz7noV0sjNwkEZiQ3JvTKQz4/1DHoZF7ynmiNH9uJj4H5PF6MwK9?=
 =?iso-8859-1?Q?h24rIq4sEihmJhnpATrUYdhFHjowXdaQYhm8SyIBuMATeFqjPFJLoSFlNI?=
 =?iso-8859-1?Q?LJ5fPXKnmJh3a6EusBRrbYEjcXuaxK9AB3h5Z/l7HLPIM+Dpjq9WMMdwA5?=
 =?iso-8859-1?Q?hQchENJYDb1nO/xkCmYzQNsWpACtv1jCXFJilWmtdjCKK1ff93G6g0eR6B?=
 =?iso-8859-1?Q?1wVqI4I19adNgzbvFfPb44zOBREl7JculZpvOZPK4nFchUAjuArJj/lDhJ?=
 =?iso-8859-1?Q?cmbclzVoO41WEKRcnaCx1UIRFGnnWO15Wcn3TF/QP771BqvZQKiOzZNPgx?=
 =?iso-8859-1?Q?W9q/DaUR/F1OuxMhVDisqw1dMUgdAYwiTWyrOtO9Rk4e+pIOwHLHWmPtfo?=
 =?iso-8859-1?Q?TWFiSR8I2gqJaIrJNTQn+EoGGrk+f21FU0RkOfsYXBo27ykiuMQv429GLC?=
 =?iso-8859-1?Q?J5HJV+mOFCvVVMmK7K49VXJtAyWBL0xs3hobezUNHc84KEsmv6GwLpbfR0?=
 =?iso-8859-1?Q?+Q3fEDAN/keBDTcp8UA4X8kRN99Lb2HMnf/dku4YEtH0Kb8D8ti5XjlfFq?=
 =?iso-8859-1?Q?Kil/bxzREw6S9VgvwkojMJLzSLF+u4uxbjY42sc3T3kBZE9Cc0PjPSB+5F?=
 =?iso-8859-1?Q?toNYlKwdwtVYjcxSjGBv5sS9sa7WpL+kCX8k8ldFFvZ02CZlF86rbWBRKx?=
 =?iso-8859-1?Q?4h7er8KRrCp3zFznt/pF2nhkRZOOiP+7DENxqsfYw1gejySnGVloZr7qQQ?=
 =?iso-8859-1?Q?b+403uHR8GGbRu4ZSsWFfbtJnDMcgqMddYenFQStatQ2329l9WCnDwRzZS?=
 =?iso-8859-1?Q?0LrrSyx1UCtUslF+cN/8ZLtxQ+7V0rEcZ/0IXEEL50grbUx5eni4IrsuEO?=
 =?iso-8859-1?Q?VqRYSn9izowOjUKU1KfQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8838.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 075949f8-b93d-4aae-e09f-08dd10a4b62c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 18:36:17.3404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6986

unsubscribe linux-kernel=


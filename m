Return-Path: <linux-kernel+bounces-249216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C8792E897
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46649B263D9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A06815DBC6;
	Thu, 11 Jul 2024 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OaDLAy1V"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010062.outbound.protection.outlook.com [52.101.69.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E00B155C95;
	Thu, 11 Jul 2024 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702584; cv=fail; b=PaBJsTI2DojXbu/AVMNmePwJmbRw49ijkueDEBZCTQL9iX/s0Yame8jf1tu6Cvngg1ohzcCMjROjGw28m91IDqua7Fgx6L3uGM4Zv15s1KpH6HTy6pbMo3l03UFut75LxEjb/xm7/cDECKq+Kxe4DVbnSsbsFDbwAY/e7YLG0cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702584; c=relaxed/simple;
	bh=gpEToaJKFDzIzDewaKjerhdWOkkvYDIwSfqjUpCSApY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X96eLYoxKE+mTOkj26sepgrjwLeYDwBVk3vUbh+DL41fXII/0TjIS0J9RtGe2MaSo9gBm0sdU2GofW2fN2THr+IptLKFXuj/SCSSaq+8UgrNh9GTJxEsKXe520h7uLefsNRe7u25Ahd7nEaTImosjw0Tnrlo/0SOET7BAs3YjHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OaDLAy1V; arc=fail smtp.client-ip=52.101.69.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjQM2ZoXVjjEPDwalbAkE5c5YZjg6wlk0ki5t+9SuKDBGaSjniFa12x2oNJNs5biDPw9lds5MgtzABEj7gZFA4uX9e62xcSP5TMlwpJ7Sl3Nm5fFM16Lq8GoLdp05vH+eI0s3L2ur4olrafARR4jZU8XNC0bIAVdnVD+AXx0VJWeSF3MoyiBRYKSF3UB6bBfx4Iac6RHnGXQ00szI6DybpanB9Y2URIqfGMNTUN7k+lQr9vkkHOl9Ty5QzUUme2mQ/cIi7Ax2T/62m3Enz704QDI5VC3lY45nuAVtC36v7dknFC6vVf9G+NAmriTGuQS0kyu5b89khzcU+Y26jS+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpEToaJKFDzIzDewaKjerhdWOkkvYDIwSfqjUpCSApY=;
 b=KgnYNJJGHFDyFw8w+FaEbIB1kHsXsw3yIfwDL9clUnPvfKBmsQamXPi/7xkppr7BbHvMNUTQJm/Dk63doadyUoCLg5rr/HkYkSUEitHbWq7R2kGVTvlNT7mpIx85cQJCBIN+RvIIpAG5268JzlAkuDf2B0gCdVDiNmCNNEzGs1+i5uWlgBtQ4t4ziKQ4TN2v0ch9XwES3BG0OU7foidtqEUGXwmJjYI/UfqINmhNWDoCd857D8PQgq3VylFq2HZyq+gRS+ZDyL5yObJKHzbDfBp5dbKxIKQsvWJQmadtUsusFwUBL5nwofZWSUgi9Khkri+PjgSt+/g5ClutVz6O2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpEToaJKFDzIzDewaKjerhdWOkkvYDIwSfqjUpCSApY=;
 b=OaDLAy1VpnASlv0I0emxjCDDluAiG2y1KlmiOq1HuSCt6OjCkrvWpMXWxqr1N5nZYLzczKsyHcdE7uA/JXmLdiJUrHO0d6FkN/rd9/4teGx2qxnT2TyjrW98CHdNRgEof7yeYJuXOAxv3ZVB68PE0h4vplRis2+PH7KEX1YLkOs=
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 12:56:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 12:56:19 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>
CC: "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "etienne.carriere@st.com"
	<etienne.carriere@st.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"michal.simek@amd.com" <michal.simek@amd.com>, "quic_sibis@quicinc.com"
	<quic_sibis@quicinc.com>, "quic_nkela@quicinc.com" <quic_nkela@quicinc.com>,
	"ptosi@google.com" <ptosi@google.com>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>, "souvik.chakravarty@arm.com"
	<souvik.chakravarty@arm.com>
Subject: RE: [PATCH v2 4/8] firmware: arm_scmi: Make MBOX transport a
 standalone driver
Thread-Topic: [PATCH v2 4/8] firmware: arm_scmi: Make MBOX transport a
 standalone driver
Thread-Index: AQHa0u8n5m5t0bMOpEyFe5oQhP5Q77HxfVkQ
Date: Thu, 11 Jul 2024 12:56:19 +0000
Message-ID:
 <PAXPR04MB845948EFA26E4F25D0BE310F88A52@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240710173153.4060457-1-cristian.marussi@arm.com>
 <20240710173153.4060457-5-cristian.marussi@arm.com>
In-Reply-To: <20240710173153.4060457-5-cristian.marussi@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAWPR04MB9837:EE_
x-ms-office365-filtering-correlation-id: 2ad25c68-52d0-4bf1-6407-08dca1a8dbc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zfZlv4X8JiqVlQ6+v3tIHpx6h0tKVszvWqroe3pgQ+cqjVS5XUU6jonECoc2?=
 =?us-ascii?Q?SvEkzvK8yXobcRFtjjgwLSOIq1AQrCeBxRQN56J8QU2Y5lAJMfu/MDot9LD3?=
 =?us-ascii?Q?4t/0QH8fRIP0zvdAfNCdZH8VglbULXy/t16FWJ0Mp5nocqk5qDPmokWjl+SU?=
 =?us-ascii?Q?9agLSvYPULsxCZaT4d2b1IWnliePpA0+0mbdnZ4EePBZ+AbDIlHVZUQ3gHMW?=
 =?us-ascii?Q?j8Zu/c4cFrHF8CvLWMcjM7ivBcoK1XbAgWarLN+xBY1a8dUcW5Ww/rDAJ2oh?=
 =?us-ascii?Q?So0o7ROkQRaL8zZ4nCRItY6DFzbvwT0aMmI3e1bHUUtYaMQR5c73zAqRkXu3?=
 =?us-ascii?Q?uOSk8Va4V+pbDYxh0rOZuXnd0o5BW4K87YMRvE2GHZezBJ1wPUf6fWMSwjp5?=
 =?us-ascii?Q?wZNn77oXeflWLQe2pPUdMR2oMjWIjDDV8ivse8wKjn+aSTT9RMFjLJyrWn3l?=
 =?us-ascii?Q?j8fGCtXjkij3Oy15X0SvtONBt2w2kmxMzvaLIIFloLYLHM369AM3qeRrqgDH?=
 =?us-ascii?Q?PUOcnqG4+ixDWmRb1bgV3jrpE2/EtIx8TdvYrURO61ESGI5Ha5D9uaH8a6OL?=
 =?us-ascii?Q?JFybdVtxsd6NS0CrRW6zksJHaneUa2lzBv5r51bA93IsCQZsxV3SaupxyCfm?=
 =?us-ascii?Q?BFKHLs7I7380y+G14Sb7A8sDwyUpb1K+/2WactlVoiV7Ws3hvEBUXJDB88Tn?=
 =?us-ascii?Q?tMszzaiNsNB/ht14u4h+nhZmjmIDbz4Lge9bq2EeLZaidHiErZvsMKZoNmYy?=
 =?us-ascii?Q?6e5Mko3V8TqJ9b8YfAGnowA3ulqyG30ppGBLkOJcBv8sU5zn5yR8ey6EVkaL?=
 =?us-ascii?Q?Fj7IE8n34PkQ3gEHFU7RVr/FEbCH+TVXdGlTz1PFDcnlQt385/l1UNfRSSci?=
 =?us-ascii?Q?sD6ceyL8S0f+XlzN/HplPFG2P+8Iudd2H/7O7YGLSrm2f0MdLQG9m0tZF3A9?=
 =?us-ascii?Q?z4TmLfKAL9f+cXjb9Br0wJ4WP6iK2rGBVCYjymmD3/Lz1ZjEoZ5QT+rCkvEV?=
 =?us-ascii?Q?dr3xr2tBrSe71Zpj9AHsSkYTfFT8zTLNaQ1QBUX1F6j+V/EfxayI4i0FLm5+?=
 =?us-ascii?Q?ukEFR8MUolRyJ+eHUSUsRGxatskTl2AY9Z2oRPTc6hZm+gGu4laPvDUtW9p+?=
 =?us-ascii?Q?nloItLUCvmghZE6mv4z45Idr+jMgehaKSz6LgCo3iZDjLSycY7y/Z9RftMXg?=
 =?us-ascii?Q?9nbKWpdqDcvfYO2vVxVwPdvr01g6fa+nkgFjPRyJCRs1vn3rmIFStVO01Qlg?=
 =?us-ascii?Q?cRPSChwo99CD7Jk8n/bFP9fvNR75LDaJvGYlTTls+t6QDv9OuoqFgTH8MXSw?=
 =?us-ascii?Q?n/Lz1PBdbh3LjFoF/xMITrOPG/19cY1h6CPUIIh5L2mfRjSo5jsKpo9yxHUE?=
 =?us-ascii?Q?ti+1slBedbThAoaS9Nxl3hIo1/zKwukqnBUxiCgjymvQciSI3A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HZe0FrNCoJ+FxM8NoLhwv6beKIhuCL0aXlco61IOZyCHPvxNw2rRGUNSKRbn?=
 =?us-ascii?Q?zn+VmCJY9i1K3/jAajoZbSm+ONSGgnOkyFmzaBBMldQK450kx6AKyln4WzN2?=
 =?us-ascii?Q?xFfhAR/zP02gWJVWa9+hId5mLGcn0V+hHi5VNQigqiVH214cNGkW5C4Lxfad?=
 =?us-ascii?Q?STshuKoJvNXlGQSIJac/hW2HhgN6xFmYkMN8gr3WNE+FZfnWFjy+cPU8lcnG?=
 =?us-ascii?Q?7UBulkLqKLdos8BtdRZ+zKcfap9aMg88coD12luvuEQ3O3ua162riK6pphJU?=
 =?us-ascii?Q?TsLx7n33RqfwNig7dRcOvDRWlnet2d7BYyBKyJjuYHLHx80eb9JFb58wAR54?=
 =?us-ascii?Q?0SsYZt+ss4G7RhlY8661l6jOKORtXdFE+VW62m+6Zm0I4PkKeGzZ9R2zryNi?=
 =?us-ascii?Q?5zO0DbTLyCEEuYkq9EbQlTODqCzdPs0H4rUSofQhi5ASelchgWC+JCOHFClT?=
 =?us-ascii?Q?2faA+BWTtjsCweyXk02FzCjYgkowyeD6ragzdXOi5QYGnandPE+h1E4TSbb6?=
 =?us-ascii?Q?FWDE/WU2+jrkgbVutkZQktET5Ujvz0BcHJKaUhCKwjrnR3PzwUHzdmfW9/78?=
 =?us-ascii?Q?SwzJyQG0//0kj/NR/BIPgvFdh8ZEUgOaPBPkzHMlheCV4PnU0ljT4xYD/5Un?=
 =?us-ascii?Q?MFlgQt2v6blwpUd8/4u12DbCzM72pzBK7dKuAglIcbhqiEj0h6xpHf0Gmoeg?=
 =?us-ascii?Q?bFsi/+SKLAqyeBprzX2rIIXE43D3Rtm8meyxC3Epcd6NUmed2PzdrulPfssl?=
 =?us-ascii?Q?Sku88ug64mYm2O0vpriLi5KgWsJKu77Go08n4d0YtjV47fIrUqefSe8tCmF3?=
 =?us-ascii?Q?Qx/WqzKwkT6VmAZ9n6pFyrv2Fg7VHvGloyaqXjzNMyq+Ijx+pdy9yb+y3IWd?=
 =?us-ascii?Q?sK05ocljaIVhvNnW7chb8FbqyMdlC0sbXl+pkv9AEnWz2L5QNv1eStEW8ViZ?=
 =?us-ascii?Q?ACg+rym+jr4DdlNM/BAXFbNkkijViQsW3BzGHToQUBRdKCmcVOIi6Lj7PvOO?=
 =?us-ascii?Q?WSOn3ZR8P7tgyyD0jdrsfrfxj65GAW/udyR84ZVxPmR5dEi1J7yBp7EoV+Cg?=
 =?us-ascii?Q?aV7eTAozs6HtYlaME4PghMIHlPAEs9Rg6ZoXyg9HBpBF3FJIDHr8Lowh4wcg?=
 =?us-ascii?Q?TvhETTVkrkwZsAxod4QWG/+dzfUsJ1vCtiuPoh5rDFZ8p+dLN92TAiyc2gSk?=
 =?us-ascii?Q?J4ADhdkeQ3pGhthyOYn2ZnsWXqRAX1fhV2Tw3GiOHISltzDetB+RaOU2mqgF?=
 =?us-ascii?Q?ZgcyPQWfv3fpxDhROOkN1DLrg1emktOxjtWomGL4f5+Yizr7HbdeuV0nZ/Ix?=
 =?us-ascii?Q?nUISU7Jk4yDo+OyHAwio5GUEoMSTI+xa9zurHoE2X3foRWHAJDNm6kveQjFl?=
 =?us-ascii?Q?ozhCB3x4t8VhqvrlACUJ/Ggchqia5+rQ8Nt8Qde0PLHs4qcPfzysQPOLfFuQ?=
 =?us-ascii?Q?wZVyZVv3W1QCc8x/Q5yjDNCOA+lFu/uRy4tjDkCtJYG85ePcDbK7Jx9xpB9o?=
 =?us-ascii?Q?TzS9j85wfGV9koZWRQj5Bh08rzy3pz/Zita2FYSS6w8+p+aXAu2dRch1hJ6a?=
 =?us-ascii?Q?5Jb53y+Uoi4AnbRTbCU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad25c68-52d0-4bf1-6407-08dca1a8dbc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 12:56:19.2845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HxzCnk/8F8RfrAXvHcHBE5wCO/Bv+wZHQlR/LIPZ17HT+1ZIaMLjoOCt/d6bEbsai2liWWdMCQwiAaYDG5MzfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

> Subject: [PATCH v2 4/8] firmware: arm_scmi: Make MBOX transport a
> standalone driver
>=20
> Make SCMI mailbox transport a standalne driver that can be optionally
> loaded as a module.
>=20
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>


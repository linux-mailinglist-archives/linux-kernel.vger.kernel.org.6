Return-Path: <linux-kernel+bounces-557835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A5FA5DE62
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1652189A08B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BD324A071;
	Wed, 12 Mar 2025 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IyqbgdRQ"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866672417E4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787534; cv=fail; b=ZBc05LDImBgB2oTCW0G+AP/Qvawp3Vz+pqUXjn6rHbCqnXj4SUc8puCOY77SvPas/yB/KZ4JsQksZFbRARPKVFvV/o2hTTzHKUV6dxVmkauJDWXOi7ovShfG1t/l5Jt8rw08FMZtY2H3AkJlino9nmjxVuso50eEFl0Yg7Cflcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787534; c=relaxed/simple;
	bh=+6ayLR/64we29zh8+qJsQ3uFga61IlQz655RUHKzDlY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UKBI9kyRSjbF0H02yoijcABSfRPtLYg35VQiMzd8OO/8/q5+IA5bnJtmELZlz8kmVKGhrHlqLFPOBLAFxUgUy6hMKuOE1uIP/8NXvgtRlj1EjuN11u0t0QN5edjCD1zoCVilCSj26BmhcNBq4Q5fsZD/2R/7sQI6vpI54qqq1OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IyqbgdRQ; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqU6cg0SajGqeBZTTWaDgyQacrWJXXuYaqLYzB4507A4yfaTyEjmuHskoIKyDC2405IJnvSxl0octhFkUcFcCYRta1M6ZHCoGKe60ql12eyuYvx3DbfKxqbVAK9vyyRHemUz8SHMG5X04cbYes9XBLQwyNbMFoRg/6PaQ0/uPL08xRt0HZHHkKxbJa9U/yGGki2qQYNggmsYPb31rT1vbFIyr2BpzAxD8sgQZWJzuII/l33nLJY6iUje3gNxS2zeUDmST7ONjTfv2G0numGvcALay503If7Zgh0sQcZrXJBxEXgnwfEY/nUb41M9R852hTihIi8p5XTNANcmhegn3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptKxYXZ9V6t+walnV6mmeqBGvyOCcRLPafZVyz2Yx+M=;
 b=QrhRAlg59zI2M1bDNvbvePbn8NDjgq/lNp6m+TJfajpt04j5uYQmBjEOPpCNYAthkDf2wns/bWjS0qaxDZUwx/Ns+eK82e8Kv1PM3bmJcqaUogfbsOymoEV+XKTx5MGRueoHFAT6KuurSRZDRaJdh6gaOqQ0WCiLlHNhEb5Qc4hPZXkDdbiJPRxtDwLSz4/GqzLdE+teqQcdRdCtKDAfMoufe4zeDXjQ99s4hCD8spLlY1UIoReT//zZyrdsABproCVaYSBA7Fa+AEtVCaYgtElifEh+/39k7izuBXzXmoYTTMlcPtRJLgsAJCUTqk5qUs/QKzU68AS1YEMsM23SBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptKxYXZ9V6t+walnV6mmeqBGvyOCcRLPafZVyz2Yx+M=;
 b=IyqbgdRQn7svKUxk7XDQAmrEHDMhjIOau55GiM3o+cuKqpFp3K8pLjVPGfCZn3LA9UcYEqNTGPdGSOwU3HeKtWCSVJWUPs3WX2khNHyuCaAG3G2gZqWnxBReqI+H1i83tqSIwqiz1OPoRru9MYmAUb2QGK0/03bkAwvtHAboGi9UCljCx+pIlB3RrCfyHeX9TJ9EwrSAQ66VeTDa9Qrp4kFAPIuWnZL/SdFXoD64cmEJV5R/ys/wz+wJk1kkXAxDNV3pmWvcrQvugiFCbcubgZ/qWGpuz8FZ+wyRS1QjfQ3dRFCNzj88zizj9OT1BM1CQeGjPBuONJKaMi7pxBqmBA==
Received: from VI1PR04MB10049.eurprd04.prod.outlook.com
 (2603:10a6:800:1db::17) by AS8PR04MB7672.eurprd04.prod.outlook.com
 (2603:10a6:20b:23e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 13:52:06 +0000
Received: from VI1PR04MB10049.eurprd04.prod.outlook.com
 ([fe80::d09c:4c82:e871:17ee]) by VI1PR04MB10049.eurprd04.prod.outlook.com
 ([fe80::d09c:4c82:e871:17ee%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 13:52:06 +0000
From: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rvmanjumce@gmail.com" <rvmanjumce@gmail.com>
Subject: RE: [PATCH] driver: svc-i3c-master: Kernel panic issue fixed
Thread-Topic: [PATCH] driver: svc-i3c-master: Kernel panic issue fixed
Thread-Index:
 AQHbhmrgLz9oTBo3ckmGrUVlGQqbF7Nc48qAgAjnVUCAAIGuAIABWKqwgAA17oCAB8MCIA==
Date: Wed, 12 Mar 2025 13:52:05 +0000
Message-ID:
 <VI1PR04MB10049251835D1D5C953CBE6CA8FD02@VI1PR04MB10049.eurprd04.prod.outlook.com>
References: <20250224031754.1001101-1-manjunatha.venkatesh@nxp.com>
 <Z8Ha+T9Vc8Bhz25A@lizhi-Precision-Tower-5810>
 <VI1PR04MB100498A9CFBB48DF250CC73B98FCA2@VI1PR04MB10049.eurprd04.prod.outlook.com>
 <Z8m/zE9JvyiNq1HG@lizhi-Precision-Tower-5810>
 <VI1PR04MB10049E260B10FD83E57B2DCB78FD52@VI1PR04MB10049.eurprd04.prod.outlook.com>
 <Z8sOKZSjHeeP2mY5@lizhi-Precision-Tower-5810>
In-Reply-To: <Z8sOKZSjHeeP2mY5@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB10049:EE_|AS8PR04MB7672:EE_
x-ms-office365-filtering-correlation-id: 34220fe3-e83c-4718-b138-08dd616d1351
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oxqCiZzS5sAousg90t+DNFqif2OCCIXKdAyPgoGz+cCBdv/e1HKCut9Ga0hN?=
 =?us-ascii?Q?9o1TZuN0lt7okNZF3XYaKqflsbe/QiQ2p4GlAFmDew6xa5V++Vp5wPC04zcZ?=
 =?us-ascii?Q?tpgH3hdJIX4voNV1feHiI/ppHOj/6cWNxajHrYaRoQNqBGN/Odq2g16HpzLW?=
 =?us-ascii?Q?AZ+USE06SoJWhqOEcVcxcLcW+zTZdCzlxrI+pb3LPicS8SzZvHpZPb7p84Ve?=
 =?us-ascii?Q?kv773xNNljvd2sD9qZu7+3s1wLzNaqBNuCDzXXKW2kq93pgE0Zo/57A8df76?=
 =?us-ascii?Q?Euzdwq6za5Kzr3GrvB62bT7jK+AXzf/t5qmDBbaDsy061aNtRaEWGbmqkzmI?=
 =?us-ascii?Q?5rLYpcRlf5tz17rjuL30hkO7UU1LQg+mBmAB0bbErE5M/hiejSpogViACo1T?=
 =?us-ascii?Q?K1M731uNstitMGhamkWwx5UEwoUDofQs4xWisJFVuuDJhv3iFsRSpgNNFxm+?=
 =?us-ascii?Q?A5JNR1HOH+qOHDMaHgoBJa4KoGVwuC9ef3gQdfHSvsvsvDByqaTvNFYNLGr3?=
 =?us-ascii?Q?t6L0zwBFRqANbTZueodmV/A0vXcAcjuDihZLA/RZKecrlffRHYiuZvl7jEw4?=
 =?us-ascii?Q?P+J/y/7nJqtp2W8q4X8nbpYEY9ZMQIxZYqir13T7kInNL92Z8n6nXGZBJOtG?=
 =?us-ascii?Q?0nm8yyb3a68tPo7yDnmprlqofmYmY5FKJxP7t0SWZ60tWkRwFUXLU3htmDbh?=
 =?us-ascii?Q?Ix2sRes5jk8S3HNjy55PGKolWp7Pl+G0KDoTMcrdRpflh/qdpaw/qkTWRooZ?=
 =?us-ascii?Q?Y7UDw0TBuT8BaqzBUm2VJ0PX3JRfmB9n2UQ+6nLQBCOtG0udGWsBwUTFIz1E?=
 =?us-ascii?Q?OnCcGq8YYttuVpSbWkAPSwxzY9UBhbewNw45U6+c+MvJv6vvDAQSrYmUfJtV?=
 =?us-ascii?Q?acj4TVw4fZV8KadxrVxvB5rnNt0HLQT4mESJNvZI0cdgEcz9CLhY6Skn2d93?=
 =?us-ascii?Q?PnFqAaDWwABcWfQ5RTi66FPT1oq1dNnUvZY1nu3GJmbCbB7A2IOPuwGdTXbj?=
 =?us-ascii?Q?SVsnRXDc42JtBKeYn/MF2j5bqabPIwZEkjB3MtB644sYrZ/3R3w1sVoNhYRa?=
 =?us-ascii?Q?kKuIvEIS/f0Jtc8JOV3FwmkCdMFcejTXOrdPIA0qxXDxmgwyWDRHCqhbDGlH?=
 =?us-ascii?Q?u8kpG+CvCW6AFsrQ7PA9gu+r/kVgDv4TA6LKexolQMlEncfhaKWSu7XiTRDw?=
 =?us-ascii?Q?WzXJBw/WqGZIVt0prQJOpwCPHB9n7dTpS4DhTXYVEwgpMRrXTWFXQgSMxSBU?=
 =?us-ascii?Q?wSH7F2KMST6GYHhbJgviZZuDYFXf/jHOqlmMGnDy593gDK8qD9jPQiVvIl4H?=
 =?us-ascii?Q?HhgYOxn8QODysTtbTL25d/liykbnbVHDuQ0r1HgjQPEUOE8NUyDDcUnSEodr?=
 =?us-ascii?Q?O/SZgMRNx5NzzDh33hd5YPmVsv8nwivqXSZNZMQTEAE9Ii6r16zQ8WmAUgJF?=
 =?us-ascii?Q?6yxl6gnItDPeLq0PIEl2gI+M5CpUyN0b?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10049.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bZ7jMO12UryRCuFFLk9b3EqYogiNwNh0+lQ42imAP2vlUstjU2cCdBCpOAiC?=
 =?us-ascii?Q?uqLxy4i1wU2WAkBrz/geJ853qL21Qe5d9K1YAyq9D4Q7fUt6Tde6hxWB3fK1?=
 =?us-ascii?Q?hzORh4quzAG/zkZ1nYk3jxcT+s6vTHt94SuCR7HY7BX2p9J83b+xAIzZXCb9?=
 =?us-ascii?Q?Dah/v7C92d54McVku/f+i19tCEdrS+sc8aPgFOzMsegbqWFmOjy4Kq/Iod15?=
 =?us-ascii?Q?Oddh4Mikyy+5uPN60ZT6yny28Bwxmjs92LFkiI09xMkWBwHKklJ2qB8eeKEQ?=
 =?us-ascii?Q?Ai5IOpQLAKMXjDqhQAPWiYuoBiYn2tzjD1Rj1yFaKr7gcIjPX6wU+4b4vV4J?=
 =?us-ascii?Q?IPe+wdHD7I8W4zc63ofMxsKvsMaF9381CchMRDxDknzI4fozyrbJ7jugO4l8?=
 =?us-ascii?Q?JIE3H3Q+VzaVFqxR1OtO7mJRZ4vccFqpZgo7IE13XXCJXJyEmPtQq4Rq1eyb?=
 =?us-ascii?Q?H0wldnoZ/VXd7MAYBvtkS0nD8sd9GWvQOybpYIF8wdVjkYRU9gnL9k7ihICU?=
 =?us-ascii?Q?Qaoq2wr2SkqJuh+yNQ7mnyoiz/Qphud5SPKjEITRA5lM+7zz9vfwUpCFdSXo?=
 =?us-ascii?Q?3EnALABOgmHAGDf1yPHdaFRRdPwQKOhjDHTTvxNOw2D24+gq1c1UrcDlBG6z?=
 =?us-ascii?Q?HpStrrI/5sxtlztafrNDUP66pwmQTKzlU988XiYcwjcN6dfw+T+5LvBaAeLY?=
 =?us-ascii?Q?FuyBQ3NPo0QGPN2EZkJm0hiHurM5Yr/pWpop734wYXSe2JkdJrcC23WCKp7P?=
 =?us-ascii?Q?MDrR0IKHPD2tkNBDgMmq5u1VrrOglWTj6neO/LUs01CZ4gSn0X55mM6zlbuM?=
 =?us-ascii?Q?9vGcT8hY82/PbAyj5A6lkikdifZXuJpLZbbfrTGHfil0f4YtwgDapvIJJWRy?=
 =?us-ascii?Q?U2O3rAR3tBBX9VIo28rQJLrbw/e5sF1BmV561j5d5scggj64WG62E9TduASQ?=
 =?us-ascii?Q?wY0PIBRwa/1B/ag1gr0iDnZ3e0j9sEfDPpmuC9388Z3vzMR1b8wBJ7MsIMdB?=
 =?us-ascii?Q?tq6e9BOaBe5oQa7whe4IzEgu1vBaaR8P+Y7RGO18OImMxbkbXdJ4AnBSdBTh?=
 =?us-ascii?Q?c8Ss8DzYTH6qLd09HHzrmZLK8f17gGd0ZchJ4TbiIC38lgeTXb0+JXUpNw9F?=
 =?us-ascii?Q?NtCn4fI0HsNZ7u5y2EF5yTm7tKH2y30O2fxxoZQF4kcP28lp5T86OpVzFH/m?=
 =?us-ascii?Q?nv2J2CG05a2SpHDkx63UDUVLE0V8D8azubJPIv4EXDukiH7t2iRKs6b1v7Z0?=
 =?us-ascii?Q?WA4ifncnEhU/W7XgKoAqT8WdR2xwa/sSvKXS/aOaNkOZO/Dl+i9arTy73yfv?=
 =?us-ascii?Q?lh2yOgJIpFTfz1p2xfvVQ3rhP/VrcpOuH8kBlQPorS+6fJUjYtrRPnRumwsH?=
 =?us-ascii?Q?gTZiF5u2BEFgCowPWjP9ow8Yhx1sSohp+zExt5uIcJnOUNBHm7FQx99DZmqy?=
 =?us-ascii?Q?CxdBVwRDnrsfGdlaC5zlXW3YAxTSQFDOVf4kZNDiMATs+KCy6iS1P2nDoUWj?=
 =?us-ascii?Q?2zZEdpQBlH+Ku99oQpptqmX0EI/DaHKb10rWHHBKZINrNHmD1qMJoJ4/QkYl?=
 =?us-ascii?Q?Rz5m8jNmLLY94UVKo172mXaVWqLDhZwh1gVqKPPXsE2TCRHF9hBenjbeIqKJ?=
 =?us-ascii?Q?Lw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10049.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34220fe3-e83c-4718-b138-08dd616d1351
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 13:52:05.9722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6JQNdE75N3KxoP+Q+cBD7dv8nRQOmiyx2DdGPLEivlyD67l4lSdekidmumKjaRBw44jQc57ys9MZ+nA43B9htMLFy3KK6RYD+AUyY02u8g8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7672



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Friday, March 7, 2025 8:48 PM
> To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org; linux-
> kernel@vger.kernel.org; rvmanjumce@gmail.com
> Subject: Re: [PATCH] driver: svc-i3c-master: Kernel panic issue fixed
>=20
> On Fri, Mar 07, 2025 at 12:34:53PM +0000, Manjunatha Venkatesh wrote:
> >
> >
> > > -----Original Message-----
> > > From: Frank Li <frank.li@nxp.com>
> > > Sent: Thursday, March 6, 2025 9:01 PM
> > > To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> > > Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> > > alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org; linux-
> > > kernel@vger.kernel.org; rvmanjumce@gmail.com
> > > Subject: Re: [PATCH] driver: svc-i3c-master: Kernel panic issue
> > > fixed
> > >
> > > On Thu, Mar 06, 2025 at 08:31:29AM +0000, Manjunatha Venkatesh
> wrote:
> > > > Hi Frank,
> > > >
> > > > Please find my inline comments.
> > > >
> > > > Regards,
> > > > Manju
> > >
> > > Avoid top post for linux kernel mail list.
> > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Frank Li <frank.li@nxp.com>
> > > > > Sent: Friday, February 28, 2025 9:19 PM
> > > > > To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> > > > > Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> > > > > alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org;
> > > > > linux- kernel@vger.kernel.org; rvmanjumce@gmail.com
> > > > > Subject: Re: [PATCH] driver: svc-i3c-master: Kernel panic issue
> > > > > fixed
> > > > >
> > > > > Subject should be "Fix read from unreadable memory at
> > > > > svc_i3c_master_ibi_work()"
> > > > > Or like below pattern:
> > > > > 	Do ... to fix ...
> > > > >
> > > > [Manjunatha Venkatesh] Tittle updated as per the review comment.
> > > > > On Mon, Feb 24, 2025 at 08:47:54AM +0530, Manjunatha Venkatesh
> > > wrote:
> > > > > > I3C Master driver svc-i3c-master
> > > > >
> > > > > Needn't this line.
> > > > >
> > > > [Manjunatha Venkatesh] Removed this line and submitted the new
> > > > patch
> > > > > >
> > > > > > As part of I3C driver probing sequence for particular device
> > > > > > instance, While adding to queue it is trying to access ibi
> > > > > > variable of dev which is not yet initialized causing "Unable
> > > > > > to handle kernel read from unreadable memory" resulting in kern=
el
> panic.
> > > > >
> > > > > Can you provide more detail information why/how this happen?
> > > > > which varible read cause this problem?
> > > > >
> > > > [Manjunatha Venkatesh] : Below is the sequence where this issue
> > > happened.
> > > > 1. During boot up sequence IBI is received at host  from the slave
> > > > device
> > > before requesting for IBI, Usually will request IBI by calling
> > > i3c_device_request_ibi() during probe of slave driver.
> > > > 2. Since master code trying to access IBI Variable for the
> > > > particular device
> > > instance before actually it initialized by slave driver, due to this
> > > randomly accessing the address and causing kernel panic.
> > > > 3. i3c_device_request_ibi() function invoked by the slave driver
> > > >where dev- ibi =3D ibi; assigned as part of function call
> i3c_dev_request_ibi_locked().
> > > > 4. But when IBI request sent by slave device, master code  trying
> > > >to access
> > > this variable before its initialized due to this race condition
> > > situation kernel panic happened.
> > >
> > > Write above reproduce steps to commit message.
> > >
> > [Manjunatha Venkatesh] : Next commit will update this description.
> > > I think it is common problem for i3c framework.
> > >
> > > You'd better change i3c_master_queue_ibi()
> > >
> > > void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct
> > > i3c_ibi_slot *slot) {
> > > 	if (!slot)
> > > 		return;
> > >
> > >         atomic_inc(&dev->ibi->pending_ibis);
> > >         queue_work(dev->ibi->wq, &slot->work); }
> > >
> > [Manjunatha Venkatesh] : Actual issue we have faced with respect to 'de=
v-
> >ibi' variable.
>=20
> How about
> if (!dev->ibi || !slot) {
> 	dev_warning("...");
> 	return;
> }
>=20
> Frank
>=20
> > Pointer variable 'slot' is with respect IBI received from slave device =
context
> and 'dev->ibi' is with respect to initialization of slave driver these 2 =
are
> asynchronous events.
> > dev->ibi =3D ibi; is initialized at i3c_dev_request_ibi_locked(), this =
is invoked as
> part of slave driver IBI init sequence, this is what we want to check bef=
ore
> processing the IBI request from the Slave device.
> > master->ibi.slots[i] this is where all device ibi instance list are sav=
ed, so here
> our slave driver init IBI stored with respect dev->ibi index.
> > So adding 'if (!slot)' will not help to resolve this issue.
>=20
>=20
> Please wrap around at 80 char to read easily.
>=20
[Manjunatha Venkatesh] : I have corrected in the submitted patch.
Please ignore patch version 3 there were some typo in the description, subm=
itted patch version4.
Consider Patch version4 for review.=20
>=20
> >
> > > Frank
> > > >
> > > >
> > > > > Need fix tags and cc stable.
> > > > >
> > > > [Manjunatha Venkatesh] : fix tags and cc stable updated in the
> > > > commit
> > > message.
> > > >
> > [Manjunatha Venkatesh] : Last commit message missed to update fix tags
> and cc stable.
> > Will update that information as part of next commit message.
> > > > > Frank
> > > > > >
> > > > > > Signed-off-by: Manjunatha Venkatesh
> > > <manjunatha.venkatesh@nxp.com>
> > > > > > ---
> > > > > >  drivers/i3c/master/svc-i3c-master.c | 7 +++++--
> > > > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/i3c/master/svc-i3c-master.c
> > > > > > b/drivers/i3c/master/svc-i3c-master.c
> > > > > > index d6057d8c7dec..98c4d2e5cd8d 100644
> > > > > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > > > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > > > > @@ -534,8 +534,11 @@ static void
> > > > > > svc_i3c_master_ibi_work(struct
> > > > > work_struct *work)
> > > > > >  	switch (ibitype) {
> > > > > >  	case SVC_I3C_MSTATUS_IBITYPE_IBI:
> > > > > >  		if (dev) {
> > > > > > -			i3c_master_queue_ibi(dev, master-
> >ibi.tbq_slot);
> > > > > > -			master->ibi.tbq_slot =3D NULL;
> > > > > > +			data =3D i3c_dev_get_master_data(dev);
> > > > > > +			if (master->ibi.slots[data->ibi]) {
> > > > > > +				i3c_master_queue_ibi(dev, master-
> > > > > >ibi.tbq_slot);
> > > > > > +				master->ibi.tbq_slot =3D NULL;
> > > > > > +			}
> > > > > >  		}
> > > > > >  		svc_i3c_master_emit_stop(master);
> > > > > >  		break;
> > > > > > --
> > > > > > 2.46.1
> > > > > >
> > > > > >
> > > > > > --
> > > > > > linux-i3c mailing list
> > > > > > linux-i3c@lists.infradead.org
> > > > > > http://lists.infradead.org/mailman/listinfo/linux-i3c


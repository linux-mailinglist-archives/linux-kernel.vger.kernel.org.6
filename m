Return-Path: <linux-kernel+bounces-316186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9831F96CC5B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13578B23997
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2652BE4A;
	Thu,  5 Sep 2024 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cIiyUah2"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011042.outbound.protection.outlook.com [52.101.70.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB732107
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 01:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725500829; cv=fail; b=BRxpZXYdaZtR9A06nCOTNPG0RJClF9Tak3b7AKb40AHz/bBBNzMy9UDHqUecKAc6tBDW878rbI9V5gjwThCOlrjC1ysQcsq0rMeOjf+FDuqoxdcdiFd3GrI5hTDJqEzxX8J2+CwlzIInY0sUykFGQTtjirnEhkg2wQEXy+x3m2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725500829; c=relaxed/simple;
	bh=HR+y5SxGFEGBxNQKcENoNGHgmw23ojhTaU3+uDyczcU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NC0xiio6uFt+cr53nBZFnJ/cnpCRPAiL7aR6XxHF3o90p35+TqYlNU3BbsTkmyRLmSO4ywm9m1N9TaJDmriDB52APy23VKhuhWt5PekcQ1/4FmsN7gp8iu/ZpWjErlWw0KrB2H+cirrwMjI2JjTEtCRpMOC15zsJVeqdEoVAnAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cIiyUah2; arc=fail smtp.client-ip=52.101.70.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kS6mhVrxcHUZVaj+R+KzW8ygxj7UWpCy5mTdSf7qqFqnHdHIqVJExsSXvzgBq071/66mc379DQe2JnxER28LToapqP+mggACRs9Q12H7ViFCeot2mskMEt/mmJW+7tPMBJPpL5krrQuUjNP8EdIt70dM+E9WCY+gnzACngBmtFd0ArQG0sKQq5ll+L5PfznuMljizg5XrUOxcL/l4f7fMt+4F/pjfTtblUrdcowVo1pZYD/CUgnF8ciSCFFSBhyTJ2kTH7bqXVGYLrza534A0tgWLxWSczs4BP002g7+Y0NAeY2Fzpg17wL2V+u7Tl8+AF/VFym+8SaWW4+qe+aJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iY63M5jhSMs7PKWOhOppoW31FkgUXuwQ4jBOJlgFDbw=;
 b=DQo98Dwo03dZBE627/bEtoqL1YSOXP2jqrJ5dy0QPMw3WVJMjWULDwXsYSJdlqqMF2zMjQ5082b62Yo30X6dZuYWG5KE5TBlqTwFrvDjo93pUi8quEa5TkZvd0KMprlp8GOISkdKkA+QqJixCWZ9MYt0aKdyOCdynVGz9IMJF6TpdOPGCrnj7W58CtCy572evraf4Mh+w0dvfkDVVx7oZHlcxsLN7Zebf1DsD+dZ9cVEBpJrsTxGm1510dJDf8bK9xoQ3LMqojB/QPGW3RpRnW0Sv1gN9B+k2KVb2US3ZBSdNQCEqEHjOsTm5nWsM5clnH+UG9peyef7NBX4pfsEjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iY63M5jhSMs7PKWOhOppoW31FkgUXuwQ4jBOJlgFDbw=;
 b=cIiyUah2hecI4HN4HnhQnd6lSgTb7UZHP1R17MeiApARMkKGibCRAx1YIWmx1cTZov3REr5i7tMgksSOuSrlTxFlIPzy3Qihy4UIeeHvmRvoEW1n7S8H454x9AbT0LEttkpnJ8NLc3weZ+/5V4T/FGSWA/iP6A5WjbL4rAMXIK0WnIX8moziTlbu9bRU8tuvUNSf+5eoktMl7IM9hCTpygwd5CVaU8C06qJSNnHXdxdkmIhQ+aI+3NrYC8q/rxIjtDFtxUutNWpJF4FHkeY8s8FH0g+gl93bjgqRtT92CCTcvv9pkInTU4ZFRlSTH/sYjx6R52rrqyVl9HlqmGfCWg==
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AS8PR04MB9173.eurprd04.prod.outlook.com (2603:10a6:20b:448::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 01:47:04 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb%4]) with mapi id 15.20.7918.019; Thu, 5 Sep 2024
 01:47:03 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Frank Li <frank.li@nxp.com>, Miquel Raynal <miquel.raynal@bootlin.com>
CC: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v3] i3c: master: support to adjust first broadcast address
 speed
Thread-Topic: [PATCH v3] i3c: master: support to adjust first broadcast
 address speed
Thread-Index: AQHa/v3D3jJS11ZZzkKC05nZ3O9zOLJIagUg
Date: Thu, 5 Sep 2024 01:47:03 +0000
Message-ID:
 <VI1PR04MB5005B62A894346ECDDA70384E89D2@VI1PR04MB5005.eurprd04.prod.outlook.com>
References: <20240826050957.1881563-1-carlos.song@nxp.com>
 <20240826101323.746b617c@xps-13>
 <ZtiwBUDaVgL9Ejr+@lizhi-Precision-Tower-5810>
In-Reply-To: <ZtiwBUDaVgL9Ejr+@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5005:EE_|AS8PR04MB9173:EE_
x-ms-office365-filtering-correlation-id: 5f70131a-6690-4c7c-da3b-08dccd4ca408
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?30JOwi7lEi/8HrPzDHqFRBzBncD1XjqCF+Y6OF6mSUf3v/M2otwrUjvVuB?=
 =?iso-8859-1?Q?Q0EK9LEk7JI0wu1MF9IMOReS+O8lnED368fJtPp7iDLLLIpXJ+GgV9U/fR?=
 =?iso-8859-1?Q?dREo08Y+APynDUSGU0KwQFjMrL3A20mu15XVTru8OHknFMkv230FSY8lzq?=
 =?iso-8859-1?Q?ExoRIJto9iEg5Vnf71C9qdrZNiwLI5fpA0frvxca0OExEaEr9UNONosbuk?=
 =?iso-8859-1?Q?FjcvaU6nXf1KmjAgeEchnSvTGBxuySkAt/ATjkqi+vcFu0u8/J0kggFFop?=
 =?iso-8859-1?Q?khGu+mfDwrh4MT3KEJq217HmlrX8taS1JqAW7X79yepnqEtAyaAcmZ0x4l?=
 =?iso-8859-1?Q?v9pGbM4u+ls0YNbXGdi/X+JE4eeOQ/8DrBTjv3c2LbLB0Ewhdw9I+GBAAz?=
 =?iso-8859-1?Q?Qv/rZN0uVQb+dVoOwHpfFALzMXEfkWHh9wHHRP0R6PfiNG+UclEVvYJFdk?=
 =?iso-8859-1?Q?wrQOI/OOf1qnf/1PBdT+iNClFJjQjyUfsnvjpzpKkrxJSvhFIVVieMoaaR?=
 =?iso-8859-1?Q?IHC7y9Ps4BB4feJhi8ryAfQaZEXWJczvF0RKaX0vbg1uN8iTAc/IM5+MKi?=
 =?iso-8859-1?Q?wX/aG48IQV4Hmhj9kgg6wJ1IM69JhRW1W32luDMb7K3KNTceRid7+SfR5U?=
 =?iso-8859-1?Q?/MSc3y4DoFp/LgqBioWIdGfJZIvhPOcYsnkZ9nSkiZ1vSXwXyXNPjMLICK?=
 =?iso-8859-1?Q?MJQP42fZO5VzriKKOHOigaMAdzSCzvBj5s7eyEYbxGzxyHT5VIQl9nDPRO?=
 =?iso-8859-1?Q?4k9Vr7AWN4jlz02t91pwt7fEfhEAlEudeUp5tB9pwDhcYd/LrKTTPN111F?=
 =?iso-8859-1?Q?ShSaFB4h2hveANMv3pDXr8Ro+GHVQAtK5JyUg0XZhz7U8EApUddx4TaAUa?=
 =?iso-8859-1?Q?XPA/JMaXWFOjYlwJsS9sWMEAuCTgoPxY8pfNOkC1jKeTX6CMYC4azRGoHP?=
 =?iso-8859-1?Q?etfMkmyORLoSRmspFPaxTzy9dA4/HyZ1YQFwtEYopNXhjlw+HdIX50wor0?=
 =?iso-8859-1?Q?MyzTjM93Lt5gauuw2MCm1AciztqXF6ynimajoqIqaCMQh1a+Rs3sFwa9+N?=
 =?iso-8859-1?Q?oI+wjENfa3Fyup8v3ATuBduDbRFTmMudkxugVlY8spbKxezij0meNnKpnb?=
 =?iso-8859-1?Q?msoj57+b5JmMIcyDh0edsjpyffv5N1YVBgX3NGBI6crrHvwQDGrCY+veHF?=
 =?iso-8859-1?Q?Frsh+y8KoofdMzW5RwO1O/Tw5fSsC11Zau8cmKwH8O9zFlD5tLj6X/ch2z?=
 =?iso-8859-1?Q?Wxv1lpwJqlJ2nWf0Xmc37rhu9mho3J1ddeXJZIdD+knaz2H/WxwDPM5o9Q?=
 =?iso-8859-1?Q?nYz1rS4XwsLwvxcPrA+tOFKB5rnzboOq7zdjIEcwrdyHoHQwmF+ha4IEct?=
 =?iso-8859-1?Q?r43HzWVfh0hyVZgQsr7RloJnnF285pIPrMdbNcBEA+whhcHwDemC1HUIVD?=
 =?iso-8859-1?Q?e0k8tvZn7hEQ9SC77RdgcnhkORZByW6XjQeDZA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?F8okqWgzjFdKE7xu30g/5/UyxH8xOd/w9b5Xnni3GnQsdCsy16mmdRgYen?=
 =?iso-8859-1?Q?hoxr/+GEt2hiBMK0bsTKMMZ6JAwjfQeynFU4hAiMV6wOHU8o7fZhTolCZ3?=
 =?iso-8859-1?Q?h5yVSPGXiSgeYiqZeNMGgXZF30SslTr7bwh1QVyygpf0Hpg1XlOpZNcXSg?=
 =?iso-8859-1?Q?bxk3svVoj+bCq75hNyYeX2kyM+Imnb2pXtlKNIDj/hUvJVcnYDwxLmBG1X?=
 =?iso-8859-1?Q?4zqc7vjDDdwTHRWDz5qKhmsvXm8DIC3De85+ouKs931ZQt+I1FUSwXgQBT?=
 =?iso-8859-1?Q?VxIacHNQC9KSsXE70QwF6xxzChNE9r9HGM0ujvBUdD7NchuiACZMApcx1z?=
 =?iso-8859-1?Q?Q/9usyoAVeiVZSnEVcho7Hx5pRt1QsPs9J5vApAlU6QHKRmhahj82PojNB?=
 =?iso-8859-1?Q?5OdU3eVaQg8T/4Pc0QbxEjL5gJ37YdiITi+0J6eke028BJK3pomvxtuF2T?=
 =?iso-8859-1?Q?R2dTDBJXvcix9O4hLKJzOMuVz+rbNlVijACT4TfFmaAnGD9KyClnbWV1vZ?=
 =?iso-8859-1?Q?OD3k1dMTs/+86xjlaR0fi7FVYBCEiBS3GHs4ZBoxoIvBwpv8p4l5GS2Ybc?=
 =?iso-8859-1?Q?quNJgS5DZyk9hgyqb0ZdXGch4rvNaFh4KJNEYUYjoPshCmOePmZdj7SBAS?=
 =?iso-8859-1?Q?xtJI5SalIQECrI4m3Td/KK868+M27l/6FyWK+8luQyKjDlg1PLOea29cVV?=
 =?iso-8859-1?Q?RiN11mvNu6mZ592B/l03wz5kHAo5uXYh8KEregx0FDivVHMf64B0PkfwCw?=
 =?iso-8859-1?Q?rVz98ee0l5x9ubUtRbLLBufm9COZmiC47I+20Bzs8+R25B7xSFNX+icTUC?=
 =?iso-8859-1?Q?zq8kBzX83Y2NlKcPRBdJCKFtWy1yjyQRDHgmfCvqBpXL64bLLj5DR2tcj+?=
 =?iso-8859-1?Q?3mQd6bIHsiSldbyJx71LOOHvMJz2cJ0iTsjAV1haMivaqPAtcS8N7buDDx?=
 =?iso-8859-1?Q?9w9KgTCzV6WuShmSyci6zUkxMX9vnDW4sQd35flyyO5oG8DpK0og6WkSpp?=
 =?iso-8859-1?Q?er3LntNNLSUfvzuEae4SVit8kalgrUWDkjJns3LMJQuK6Mquheoi4R8UM5?=
 =?iso-8859-1?Q?OemLAF2t/7XwuUh32y86W4xDmT11cVQRP6eBrag6QnNYeFk4V5C44uBLhH?=
 =?iso-8859-1?Q?Ix7qkoC9M1ThDWuHwgMTlpDyPgLKQEQa/RwWyvAK4P2qAlmmGJVVyXg6dB?=
 =?iso-8859-1?Q?6nempqqt/WZHZB9WOrRYq7+2qvXt+o8aFyByIxYI/tC6lsW+5ud4no92Mq?=
 =?iso-8859-1?Q?yR1JGZ4CQhi6+f2b0vE6zVPNFxhNhuN6Locks7/CV7+l0g4TEb4HbqDFFg?=
 =?iso-8859-1?Q?fuKji/v9uAph3w7t2oP0UbnCoNd3QVlvIXecne08obuc8+2MMkZNiKjUQF?=
 =?iso-8859-1?Q?EhL87HusvhLh3eFOt+LY4ogL6XDM9HfVtZPNj+EBQ0Ym4ZyWEFhUvpkfzI?=
 =?iso-8859-1?Q?2BtfTouKSdo8ShlqibpEaSFBvEMa1FkiKKrODx+789Zkn6/LTEG2eghbqW?=
 =?iso-8859-1?Q?NgF0jWc+H4HbY2+Zh2dBnjNEKJcrFC718Gz0EDwY5JZ4Y2nYsN31nPPzyh?=
 =?iso-8859-1?Q?v0Mh1PV9dYwO7WCYdUpwi3KcfBTlsmW0+d+pePYBu+3rhxqTKjlRz5hGbj?=
 =?iso-8859-1?Q?6oajK5cpWaAyo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f70131a-6690-4c7c-da3b-08dccd4ca408
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 01:47:03.2971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C7ACJBRhjU7SmDlf58YCaZQUHx8ltxCyL2s9qhsIUXDL+m0gV3p+dnRe3/DRU/Zk+w8MYAfsqIFrE/JzlC3ZVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9173



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Thursday, September 5, 2024 3:08 AM
> To: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Carlos Song <carlos.song@nxp.com>; alexandre.belloni@bootlin.com;
> linux-i3c@lists.infradead.org; linux-kernel@vger.kernel.org; imx@lists.li=
nux.dev;
> dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH v3] i3c: master: support to adjust first broadcast ad=
dress
> speed
>=20
> On Mon, Aug 26, 2024 at 10:13:23AM +0200, Miquel Raynal wrote:
> > Hi Carlos,
> >
> > carlos.song@nxp.com wrote on Mon, 26 Aug 2024 13:09:57 +0800:
> >
> > > From: Carlos Song <carlos.song@nxp.com>
> > >
>=20
> carlos:
>=20
> 	I just realize you missed sent out svc implement.
>=20
> https://lore.kernel.org/linux-i3c/20240807061306.3143528-2-carlos.song@nx=
p.
> com/T/#u
>=20
> 	Suppose both patches should send out together.
>=20
> Frank
>=20

Sorry for this. I will send both again together.

> > > According to I3C spec 6.2 Timing Specification, the Open Drain High
> > > Period of SCL Clock timing for first broadcast address should be
> > > adjusted to 200ns at least. I3C device working as i2c device will
> > > see the broadcast to close its Spike Filter then change to work at
> > > I3C mode. After that I3C open drain SCL high level should be adjusted=
 back.
> > >
> > > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> >
> > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >
> > Frank, did you test it with eg. the Silvaco master?
> >
> > Thanks,
> > Miqu=E8l
> >
> > --
> > linux-i3c mailing list
> > linux-i3c@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-i3c


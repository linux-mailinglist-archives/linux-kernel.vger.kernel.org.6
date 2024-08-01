Return-Path: <linux-kernel+bounces-270597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3E49441EA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5131C2281A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900C713C818;
	Thu,  1 Aug 2024 03:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a0C3X3Ru"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926CF171CD;
	Thu,  1 Aug 2024 03:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722483343; cv=fail; b=guXygDBUr4le1z5dT+bu67FNF6HgZMmAVLgnQJTEWP9/9scV6cAOLsL1PRpNjY6iGz9F0HTIG34W1hq+OSG0Stup+nuv9M9j+aEU8s8qtv74BIB97BO812j1Ayg25Ehr2qaxL7zRU0b05UvHQ7V7NQzcLZwP0i9JEDsnFRJzcjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722483343; c=relaxed/simple;
	bh=VDD/5PM4Do2b5NyQUA1nq/HfZiGuUngsOEriKV/N/NA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MKUIsktZegKAggtrKFo0mcB18A39zfo3wYmObWjdx82sfs6wt5k6Db6yxmc2cMvUusCH/Ye4g78wDsPxq3sD/xhPPd1J2edtnsWZrGZM1z6gN/qIoMOWM0UXHnFEiMRlLD6TA4MAUwINO5nl1ubsGi1lWXJ2ecAMqEwJRyTLIdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a0C3X3Ru; arc=fail smtp.client-ip=40.107.20.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKLLZezcy62shv4R9OGDVbuq/8c4VFG5Etuo6LyImLduR2VwmOu9Vuu4hPCHeuXk6KXUpCLXyFuyF6TM613Y5rRFx/GHjEqpNbriRPOd3a5LY72Hs14TW2BZnoGym2FFORsJEtZsvkvdEwdevl/Hpj1Hb7eIj984Ba5ctI05rHDHwHaSI+2vQ0GoNI9OKCk3Eecdo/B7xGUeqU0K/LpiWo0ttpXVOqAoWOIQgov4xdLP0a6UkGvaJiTrv/H+SNTCTKEKLsohG+1cTR1DgAhE04Vr869EYLzFkFmMwUQu0ZaGS+DttS0SsiZT1XBagjxuQPiwz+kUvT+oZbQ1Mlfqng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQzjbPhRWPR+ni5Tcru0lAS6XJV5RcuIYucqmPu72nw=;
 b=hHcr+O4MfEtuF4H+c8Jg2J03Fo3U7yWu1zeHSlcdCPXrmJspVZE/B7WlQ2zc5fQOJE0QHOjphp3sEmgYOLLKvr2Ig6/cGyWoKbARm4p1EU05+B7JzOMAR82PnY/mxaEcuX31avQ1y46aF5UKszsi4gyyEpiyed5tyv9orOfSvrRk118YQG40iyuRc6ja/k3yLV4x6R/SHjP1i0Xwq6DAOscp6T80wsydMimtgnBXr03Y7gE/ATiQonj6+5LV45LR91M/h4UbTJlSWROR/HSjavVYf9PIyBGdYfSxHV8Wg3bzCnHFrwBTd9AtEvo2N5U8A0x6tsDT6Ff/qUWVDmCkJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQzjbPhRWPR+ni5Tcru0lAS6XJV5RcuIYucqmPu72nw=;
 b=a0C3X3RuML2jOeHvj/luXLhKZOzg4Pbb/zyzrkL/hDTi3LuI84w+hQCSul4if00uquSwdXaqnWp7NQMnvg7hlwrBmNA+SW+j4E0b990vy/dAhs1D/fVx2Iugqdt1cpe5Xv+sUi7EKnMdKFQp5xhLg4HhVg0oeN+uWVxsFhi8c+QKG9f/9Nm0dPynNCjvt9AlPYRBovKLGYo6WEhQe8dDZ/ygjuMUzlXD0tYL1VEBqGSoe9XWtnfMzzOvSjOo42FJgVF6QaKICmqiSxEPXoMuCPz0rTelAAZcRt8UUpLzZ4xtR4XnLTOs021jMmn5FsSt0ey/uoGHHsB8tmexvN+oYg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9641.eurprd04.prod.outlook.com (2603:10a6:102:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 03:35:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 1 Aug 2024
 03:35:37 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, Dhruva Gole <d-gole@ti.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "cristian.marussi@arm.com"
	<cristian.marussi@arm.com>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>
Subject: RE: [PATCH V2] clk: scmi: add is_prepared hook
Thread-Topic: [PATCH V2] clk: scmi: add is_prepared hook
Thread-Index: AQHa31vjRpx98ao0GkSXG1OyjyB5SLIJB2aAgAAOagCACLMCQA==
Date: Thu, 1 Aug 2024 03:35:37 +0000
Message-ID:
 <PAXPR04MB845938597DBD50DE1D1C0A1088B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240726131007.1651996-1-peng.fan@oss.nxp.com>
 <20240726135231.hhzp3dqgx64e6kiw@dhruva> <ZqO2Nn7Wofs_wfkQ@bogus>
In-Reply-To: <ZqO2Nn7Wofs_wfkQ@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB9641:EE_
x-ms-office365-filtering-correlation-id: 44c9ad43-1be6-4482-9eb0-08dcb1db0292
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4IrD7vaR98h5IVdwbwc8/VYJXuawe2aHnl189n8u90fao5OAR7787ox7F/jM?=
 =?us-ascii?Q?ipE01I7MpZ90vIwxwdiJ4rA7CQ5hWob8x96DH64KE3ofHIXMlrFkA8hZzfNo?=
 =?us-ascii?Q?6naeHkqaNIDDuCPXh/XR10lISKo+mr9Xq2x2bV6WKgdZteroIx664usP5DVv?=
 =?us-ascii?Q?zJGbe2CBO02WDiR1/XxGFd3he1caPXo12axDeS4rO4KkPUk8qlKfWlxvU1NC?=
 =?us-ascii?Q?8/ZHsBG8U/dwnL/wzkyoQpWeN7JTG4bV3cBVBZfOvcyDjqHebYO60Okid8h1?=
 =?us-ascii?Q?g87lDJ6+CvLe9PTP0rOiiHm7wo6RVAVC5rAbRjg3HF4m5C2hQPxgyeeyKoLE?=
 =?us-ascii?Q?peOF7SAaRLoyPNl60gKgzVWiboqotiZjQRM1OE9hD5Nr9dbT/zzKor9rDHHv?=
 =?us-ascii?Q?8RHFoSb2wDAmR0kJyz6W+PwyP+C2tLsmPH/0D2GYKUEcsbBNxTjutK6V1tkB?=
 =?us-ascii?Q?y1SHno4NAiHa5A7DOdQaLKHEFXqxUkS10s2cAGqJataZJk0GMtAUaD+F+tbh?=
 =?us-ascii?Q?HXuQQbL12+IKEI2/ivKYtDrn6kn/8i3ieSL6dLJju1cAOtuOgPGQXI+EN+78?=
 =?us-ascii?Q?l0yn+nkdoEA5EWEhJMERR/CROGXNQAg3DDDNzP29coC4y7NbRbTeBoW376Y9?=
 =?us-ascii?Q?X1WfcXWK/E+iEAwO0nmSooH6BW8RhvMACn6lcv899b5DHZ23TT3oEzc8jnqI?=
 =?us-ascii?Q?rrzdxIwE1viLLEgrSRt+rNl4IFzjKk7SFZI9sxEA+jQ9Dlm2YXGsVDHQrzhG?=
 =?us-ascii?Q?jWgKPhag3xRTU59trnZge+qPXYefyBrK+kWfmjHtkz+MzlkdxKhWtYWd0rPz?=
 =?us-ascii?Q?NBZkYyPdC6tsZz4+N8a6sw8TK6640EgskLzU4N2uzx6c0G9QjpeZhdbXsmHZ?=
 =?us-ascii?Q?ppDXY27fmayFsjTxJiiZRMKMdrumgCTpyBkj9OnOuk1M5IVFG1aNs3Hxj0K2?=
 =?us-ascii?Q?XOBy80msbKkegITO9JbuKusKhUd1dnkFoJpDNj8SeJEdJPKEGKntJqAe49CT?=
 =?us-ascii?Q?LwE0ESp7UbWnNw83p6/aVHXe3b5U2qXElgmp44WvkjHaxJ6n2op65ETz1e+s?=
 =?us-ascii?Q?l+n1YxJ+TMOBaYelZsxYLWdwbXz2xTEUzxbJoVKimD9LU3bV+AKe1izaodpP?=
 =?us-ascii?Q?s/wPW1nLrMEOooE1PuJJVJpFvW5cmWjStuyPtF7IcFkM8PSDvVrk2UcaAZhm?=
 =?us-ascii?Q?9pr2+y6YVrPBOeR9tPhD8glUy8/szxb+KqOdsWfRXD6QsH7odZ74gVN7xBlu?=
 =?us-ascii?Q?OJzF45haEUbyaFQgC0LBBAqHlIE+w8rAsIpSXs7nTJgs459/kg6lCcn7hl9o?=
 =?us-ascii?Q?UG0zf1s5xHfSCkiLeeQ/f2nFK6uEcn51qMmruFtPwqHvg7K48GRK2VaUTXvk?=
 =?us-ascii?Q?W15u11PVzFQgr1tIh5xoiMZfpXRE/XvQV8iE6irAMZNwpmRH/A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sXvsP2yXkFc1SABJWeeWqyn3pSEi5LVKdJrPCKM7BV82MjDN0MxAMFt0qZai?=
 =?us-ascii?Q?/1oiUwYHnvVzRA2rW4YsXVwaVcCV3qx6PhB0xs+PLv2S+GRyaSv4FYMGpR/N?=
 =?us-ascii?Q?ZaMMjU0ootvWuMwbij353ZJ1iehXFjOcdMzbYG6BQ+ZU6ANmT4fk9tvnjGEM?=
 =?us-ascii?Q?0EVaQeeLhiC6FyaMA20dPnOILrXn5AZv0/s4RfIgEtIBuAFn6RiX2XlG++y8?=
 =?us-ascii?Q?111ob4TVHWkVjxsR70YEhsCT/NtPqXLtHrSwZN9Skr6BbXrjY06HBdDwaPOx?=
 =?us-ascii?Q?2jxA7yVXIxGndL9OdKiekdbEjZyIzfaYIQ3ffFrbHcaXRmBAsL3EVcAab3ux?=
 =?us-ascii?Q?ViG4hAj3V+iufnqoCjB0e2VOdSgKKKqlVBNhh/YPYS0ax+Auav6qo4J83JP2?=
 =?us-ascii?Q?IAJKfMxqQZSyPD8Jyt3ubZ6eVFgZMLFdLXBZ1lcbqv4a3eR+HNIihZ5YocK/?=
 =?us-ascii?Q?VeWn3t+vVuMg34Ihl/k8NIAW8CjreBd2KLyC+gAw4fTg8hKDHVvB1bE4deKB?=
 =?us-ascii?Q?I7J5INBXGtT6a1bm5HLriC9ngFVbjifFyj6dwvFFMJPv/8stCOVHIe+eiR6o?=
 =?us-ascii?Q?krhMiU4cFyppvhSjDTjibtclDEX8qxScxfiDWMcwY4K6mKOX8/dNtHqE2Aaj?=
 =?us-ascii?Q?xXO7F0VN1tPp2Hfl4OhGPSFy04Tn6Rs7EmRv7XxHmHyWSgX5BzCH8FuqVoGU?=
 =?us-ascii?Q?W+RUCsb6fmHcj3DuZbuH6zUuHw/k21h2NETQzrku9SvrgUn+591t1lcdfXkk?=
 =?us-ascii?Q?ZA1KiWP0viEgUiiUbBZOQA7s56pAECoNH/aS9JEZTagqyDBpD5frt3fBRWwd?=
 =?us-ascii?Q?swPQY6dIvkWceGiOLHvi6gFMm1LGjsRml2onufmzSnN1TEE1OAm0ESzPFFnS?=
 =?us-ascii?Q?+85dUgfllevpHMBfZ/XOjAkV104IEURRnH1/hrJXRyJ9N2d+mXVJnInEoLut?=
 =?us-ascii?Q?NN1d7moE5+DaRniVcz17cnxaIsau+NCOAGtTFGShVU2Ooc3sFmWoMPyXpTB4?=
 =?us-ascii?Q?8P1nT+7mh8QHwgojxWC74B5FziKzxcLWxS/i0zmA3JT2bC0p9Tw0XtJaKnNR?=
 =?us-ascii?Q?CSXoqvZUalg3chByu+baCJiLPmaE86JtzWIZF1/b+jPtRSFjQek6L/lppvaQ?=
 =?us-ascii?Q?0vwutkY2IyO0SmZZSI8MP69XvM5OIJI+2Oad1wOpceE13SfT3CiHCkdZuro9?=
 =?us-ascii?Q?KpZeK9BDw+X9EsvuFnd7vBmKnLyJh1/YmSzohIASQAzqZGQXR8jwUbPEkE+L?=
 =?us-ascii?Q?w30GW9Vi5ys2BL4lSxl2kvHVE8kC9ki39w/BNHZxkAbDzRfjJN++UJgRnz+Z?=
 =?us-ascii?Q?DHtppL0v3Bfs0x5dp6MO3NJvQ0RNAVH7hQ9kz2kG26v7iU0JufEh1XOJaxit?=
 =?us-ascii?Q?XBFVYEqeKaa1qPLX9G+V50tmEbr7WfAuSBa5kgFKSmBT0IYxR6mweU3s6eHm?=
 =?us-ascii?Q?SBTGb9HtiJEc1VrTnTILxAP7e1x+jvLvUBPmSUDw4shHP+xgjE+V0TrzTPn5?=
 =?us-ascii?Q?SdwChasyGbtrtCW/YTWlB1ItzsPHQeZyzq7Gy0pHnoWLorjc2PSXn0oA3Z8Y?=
 =?us-ascii?Q?7Z0PS+vUZKSeqH6Difc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c9ad43-1be6-4482-9eb0-08dcb1db0292
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 03:35:37.8581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c4QtATnFGP5neDIWpUMOIwmqGL0UOrBZYURwngMe1tIdPKencfRfPvKCHDKNWdbTsoyKkx4ZdBWTuComJ1ISew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9641

Hi Sudeep, Dhruva,

> Subject: Re: [PATCH V2] clk: scmi: add is_prepared hook
>=20
> On Fri, Jul 26, 2024 at 07:22:31PM +0530, Dhruva Gole wrote:
> > On Jul 26, 2024 at 21:10:07 +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Some clks maybe default enabled by hardware, so add is_prepared
> hook
> > > for non-atomic clk_ops to get the status of the clk. Then when
> > > disabling unused clks, those unused clks but default hardware on
> > > clks could be in off state to save power.
> >
> > Just a nit - reword the commit message as:
> > Then when disabling the unused clocks, they can be simply turned
> OFF
> > to save power.
> >
>=20
> Ah this was what it meant. I couldn't parse the original text and was
> about to ask.
>=20
> > Also if you can make it still verbose, explain when you expect this
> > disabling of unused clks to take place exactly? During boot?  Driver
> probe sequence?
> > or By some user commands?
> >
>=20
> Agreed. Being little more verbose here would be beneficial IMO.
>=20

I will use below in V3:
"
Some clocks maybe default enabled by hardwar. For clocks that not=20
have users, they will be left in hardware default state, because prepare
count and enable count is zero,if there is no is_prepared hook to get
the hardware state. So add is_prepared hook to detect the hardware
state. Then when disabling the unused clocks, they can be simply
turned OFF to save power during kernel boot.
"

I will post out v3 in later next week, waiting to see any more comments.

Thanks,
Peng.

> --
> Regards,
> Sudeep


Return-Path: <linux-kernel+bounces-366978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C80499FD27
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96977B24EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCED125B9;
	Wed, 16 Oct 2024 00:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="hydxlyO0"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2133.outbound.protection.outlook.com [40.107.117.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626B35221;
	Wed, 16 Oct 2024 00:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729038671; cv=fail; b=nKvmxdzbdXjrBPBRsW/Fyvp+Lk1oloGXV4Bmtp/KGdV8x85zERifeZaTAjAWqRg0bzT5hbvdD0vmAcVOuoOaix/vwmdETYsj6LDKFdvLjRZSmO9MjDI9F4Y2HNTdeuaWKc2GWUTaWlQFWeE5vFm/TLi5mKBeOjUrwyS/93YY7YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729038671; c=relaxed/simple;
	bh=ox01bKb/5F49mozSqq/EWPliPBkCKENOlwWjzTO1VPQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d62pwS4kJxaXKukd9V8wH1GT4FAMJFpRLugrwKqlU7SX9BklphYYIIZ2qTZh8tRrUksy7MY4mjz/pzNrfFVZwWlb7UKrBYavf/JXC/BznbMQFkeqkxFSFyFqNQr76lhKJBjPqsI/hKij1y4H/ZeeCVwLzULs0463NS6L6tcoK3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=hydxlyO0; arc=fail smtp.client-ip=40.107.117.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjgFLi0RhdNA3uKRI3XL10LgWG5e9lcd8DF0GTbhBUSfoEPm6bpismTX2ZaYw3pNVZWYqGbxaRJmTOiXlRR95yiRoaZ9TITgoAdHCh5C/AZXrnIELHBgggCa5dStduJW7ZGEwBKT7EO6HGzM6z5rrJaNiJjsLVPEge/v4uskc5PYBh/kpSKn3apBTP2kmbw7EPHzWRe5eYywBuA9YvwjvjfT3DIU0pF3GISqhkT48gSwk+lmgTT71TFKBViSup0hws/Z2M8Smp6+m2h4kM3a3l75cO5awcmubpXVPVsLLMS8NDfW4njE3KNAugekUpek805RHWSfCu8plEqt7Zvzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qnri8jAS4EIWdq78ETJtkPbCSZZgCOhbg9f5LtHldE=;
 b=SudVYUldNMclIWXOSWjxJGt80Nka/VErmZ6b7oDmL+D5z5R9q1/DmfAFG9YoMvB8usyrCAOguCXDCxwuesaI+oa+JfC9T6cdsM/9xnW14JWun5l8+TIJWxiqcVq2yNIb8itRiO8ALE3THzpw30In13DVrRtAg4oDh7dI6QcxUVJN2ktUpEmNydXEXGlrBI0Ibr7i1+MOfG2IH25hhMMVTgRm+oBAcO6WX76TLBMzJVOHOB4kjsxWp3kaMoLKPtiexI3pirgLXaed1d2i3Hd7BziFnTHVJpFtahjIeRouQLSGtlrLmYdrgW839ms87U7ZQ9N2lg/NTZixdedavrgOfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qnri8jAS4EIWdq78ETJtkPbCSZZgCOhbg9f5LtHldE=;
 b=hydxlyO0xxM2XXNBPVPN5SPrbkK5ggip422OA62LJnboXi4gBEzvXjP2fSH/Lg0lLUBCibdgq+jTpR/CYkUl9wrdVqTjZx6L4d6cSWqGiUoqAHKD2ri32Cmp0r6PYgjlMKa2mlpnHob/nat4rDXbtfxkROG3NOTggngU2jiGjVYYf7akvNxmfYP81fLkggkoDswQgq+cBrw9L6kEkVz0WBZ+S/CzTZIscsOUoRgjzgzU13IFrXCiVAkUOfn+EuYPwiSAOyi/WAvvCOrIcUok/gRS/o261mtwu7S/xs69PUl6oG1RzdzefjisxGWwT65XLF2C2Sar6m/I3lz5B7BIow==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by SEYPR06MB7071.apcprd06.prod.outlook.com (2603:1096:101:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 00:31:01 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 00:31:01 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Thomas Gleixner <tglx@linutronix.de>, Markus Elfring
	<Markus.Elfring@web.de>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
Thread-Topic: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
Thread-Index: AQHbGkKMCnGgBPvFn0OoVljQ1X0eJrJ+WgAAgAoHtgCAAC64UA==
Date: Wed, 16 Oct 2024 00:31:00 +0000
Message-ID:
 <PSAPR06MB49496AB83001EDA4A51F263189462@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20241009115813.2908803-3-kevin_chen@aspeedtech.com>
 <f65dd139-1021-47d6-93a1-1477d6b4ca1d@web.de> <874j5ddow1.ffs@tglx>
In-Reply-To: <874j5ddow1.ffs@tglx>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|SEYPR06MB7071:EE_
x-ms-office365-filtering-correlation-id: 806d8504-da2b-404c-1674-08dced79cfb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?enJbVDl6xntyPzjPWp6wjWkDecNRO9llm1WlK4plw6+3yyT2iG+wOWGPFxqn?=
 =?us-ascii?Q?mLNLVTXmJQH9Tim/1pqvxKv/CgERTfsro656E2n4y8cU4fO/23Se13U3Jx9m?=
 =?us-ascii?Q?+799nOpY9QHgyFVnKaB2xS2AKfa2NlWSYK6w0htwa87ELu6f+gH2MIUZ+Zay?=
 =?us-ascii?Q?gklAbQTJCwScl44Mdg1zXBtKDQA17OvuSnccuxi1qNMwoURl7369ByWKQIMU?=
 =?us-ascii?Q?3A6oD6rS7NqY3SWajfuMpg0T58UAoVo3dLPRGl2Sjvxk2mS+kTd+y/LazJmM?=
 =?us-ascii?Q?yf4vYzhX6G4F75rpQWTyENvuiblBBqgterxnG2dmoYVyfHRFspcMSlPBmdFC?=
 =?us-ascii?Q?KCkY9hL9GRsrqZHjI71raQZyPp1ga+zNYvgIRsksOglwWu0jHZhnfmOlID4P?=
 =?us-ascii?Q?ifDOQDfPTAVn2EsmFnvTq8cTf0816V2vkyi7vrfEp5DCxoEmdCdQ24BluwnQ?=
 =?us-ascii?Q?6+/ICxwQRPiEfNkYfR+ouDYGW+eN43XAHQsao8i6qzBSZl3G9anSciIMz72A?=
 =?us-ascii?Q?msPSl6nF0ocoNGEYiC/5ZgNfYZ/gIBnQqMEa+C840I/mR2+ZQq6qmOwzRsBa?=
 =?us-ascii?Q?cqdc7WJETJ3GYd8OrC+WbpM4fDWBZet04SHNeC1AalMN/blJf8tvgWjcSlvM?=
 =?us-ascii?Q?StWgUBFJOdEB33l/rl0w0QrBBfEzCu7J6QcReo2WKe9SI29S9EmPQPlfI7li?=
 =?us-ascii?Q?hr1pznDhy+wk9RaOvafM9CRWztmovsLcvoEdILPnbtJDCB6u3n67DVH7i6BA?=
 =?us-ascii?Q?0a9jFRMJdLWXwpjWvP00jqQsxa+h23e8V05WXC18jMw2cUwiRghdP3v9XwUe?=
 =?us-ascii?Q?8HcBhrVt9xAO5RoQEvtA115U/KKMOoIc6KvMgb39TDscdiFXY1r8Nsdp0pts?=
 =?us-ascii?Q?FkoyonGT6vfHO4s54pSjN8RkWgRRM7Sf/8iaFsC6nw1VwwEowqp4mX5pFeD4?=
 =?us-ascii?Q?IpdNxoUI9pz3E9v0JsBfeH60IYDuhPIgWc1Bl77qAyl3TzUacHnlGb+Kumrz?=
 =?us-ascii?Q?B7bkcHZoeCmbdDDyYnDVVmdZOtM4qMyYo8PwMOzRhuWjTeqZhFfkeG4sRi+6?=
 =?us-ascii?Q?Ba9pqB6giFvcmdRBXUrZ+O0JwEKXqQ2pU7yhc27MBbOEPNDYqeR0bCVQ0eol?=
 =?us-ascii?Q?5Tv3Tkd6Yo6rF54+uUo25WmNhET6wLcMynoJtuQ77X8qTO4oi5fT0lhYN0hu?=
 =?us-ascii?Q?gX1RRukA7o5ZtiFLyxzmCoXuWcMx3JwiUQ0qXPd3I4WyCwkN6pcPa1/yNL5p?=
 =?us-ascii?Q?G3sf2dZ7xMtvGFq7+Om/+TylznrCgIlNe8ngr3lSAIVqI3puQ27K2G9KPjTk?=
 =?us-ascii?Q?6hk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LfBdiGvUPjXShtKmflFohlwH2OVCpd92Y3UqvgFeEOO7uCNyBg/bg/PKvjmL?=
 =?us-ascii?Q?v5Ve1gsX7owdAKFW25ebh7ovZaAp0BDOV2wxKRm/yASPUA8i3XRsEuW2dkIf?=
 =?us-ascii?Q?OK9YQrUU+yxBVCr0gAOTrDDDiTG5Xn9gSvjfWsw18ciwA3R5oV2WHq1pcNGT?=
 =?us-ascii?Q?w5oC76ohpPwBWsMxofzo/VPhm4vfieCA1JcBs1J1zmtlTIVNRpQQi6iKtFUK?=
 =?us-ascii?Q?nJsedUMZSk+0ouU+ZpmjYKb5mFH/Vy0yaZCCuJ6uszsBExO2+wSIB0hIhJV6?=
 =?us-ascii?Q?Mqd1kbXHIa9qNAOT5NcssPceWRCkJjt8tFJojEGiywur1zn30XBndF1XEEPT?=
 =?us-ascii?Q?0t69VFgyAML163ucIBJrUPa2avZhlb7WRKu9omUV0Dh+yWHn7D3FoobqLMrg?=
 =?us-ascii?Q?tLshXKYR2wSwNfl+eHPe9Wu8GuZtDd/exsNxZLI2iAvMqR27fqrz1j6zUmWF?=
 =?us-ascii?Q?tUzNPgSfW1rAzhPn8eOh/pMappz0qcZZEkHq0/SdmKwGgXnf4Tpy7+6bvmak?=
 =?us-ascii?Q?Pzek1MyG70FmM6/AKVkfn7AXiIAW0CV04tkioHOPBO5BcIRBBx/8MmdRGm4m?=
 =?us-ascii?Q?FVKd3Go45k/JJg+P/nFqxCE/5e3diiFwHFP79d+d1jdniNKVd+gWngtQcJdF?=
 =?us-ascii?Q?JXYzFNaTjapuB/z1UbAay3aqfeF/zXEa6xf0qYjTsSjaTsPPQ6DUOUihV3h8?=
 =?us-ascii?Q?4gL+NiFI8iML4uRtwHVFB9+AdOk+xsyAX1XgPu1q+Cydf9V5RaTQjqRlfqVx?=
 =?us-ascii?Q?3LWbkjy2f+YgAqTKczVifjHPWokfFW8l63QTdPqE3hquY5kFO98XqZ56Zz+P?=
 =?us-ascii?Q?I/88spYJ7I2IxvU+XDEGFNjdg9AqnBhFJopQq0N0RvwqsRjCheGxIp1k+ZpO?=
 =?us-ascii?Q?AYwyWWDZoeSW7vMOYP5ZJ/yxx9nrB3Jlaoq+iaEhSSHrkrppjUvE9pbxOfb9?=
 =?us-ascii?Q?on5aFzs1k4bng8KMh7+6cUn/UXoOjjk5er2etNFfnOvnYejzrYQq0oKD91O5?=
 =?us-ascii?Q?Tr6GMQ6F2P3WlE7Fp24QZN4zS43ctbls6hPcVtieUm5nH+UjugSdYVLCGQSB?=
 =?us-ascii?Q?3jhWp01qTf+x9af2893k26pt3Lk2R0iKwfrWY5OUfKouVw4+BGcDHN4al/pl?=
 =?us-ascii?Q?0/z8jIhGiFuaSFTf/OjUyUXgXxTKbBi1GRcRlvEURYBbypFc6yVmQurd3TVU?=
 =?us-ascii?Q?Xc33yzBaMuyDpXgnE+R3DJx2CZ+7wwsVunnNwOBZ/srVLs7Y/d43MVAVGp7g?=
 =?us-ascii?Q?JJug6jDfjZqSfZRgJPKKidLywpA+Ip8KYP0znoOIt4zwoXlVpP1FIs/WnnXQ?=
 =?us-ascii?Q?sxOC1Sd2NTb8wJ4Fgu1VzcHItZfAOnbHoW20PTM80m8M0tHkRQYb44Lntwl/?=
 =?us-ascii?Q?dtrBmuwsa/vcimLZ4FD2qXVNYWCPRSBH3jTl6XdVxjis2rfc9HLtG4jtokWM?=
 =?us-ascii?Q?V2n8rL20TbIOvsEo4NuXej1HbS7CxlyuuOuc9dhn8i+4A52AVprW+UTwNel8?=
 =?us-ascii?Q?kqQ+nZfNrtPwgnEZ8RoMzEt2Nv3n57DbYtwzZtg0xghkCTBZtZD0MdFXLUxs?=
 =?us-ascii?Q?kVXRCITfy55h6KjEGk92dbujKxMl6QxJ4QoU+kUP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4949.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806d8504-da2b-404c-1674-08dced79cfb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 00:31:01.0641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jvPDJgibKJ76R7ADn1X6w39aSizE3Hvi9n8nSQYVrE3/krODCXwIKFZ6YSqbKCfcCgkG70wfGShmOWoBTv51DuDp2uU3/3hRfGOST6pJ8zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB7071

> >> +
> >> +	chained_irq_enter(chip, desc);
> >
> > Would you become interested to collaborate with another scoped guard
> > for this programming interface?
>=20
> Collaborate in which way? What are you collaborating on?
>=20
> You are merely asking people to do work which you think is useful. You ca=
n do
> that, but that does not make it useful.
>=20
> Making a guard variant of chained_irq_enter/exit needs some thought and a
> general plan for cleaning the whole chained irq usage up. It's on the cle=
anup
> list already with quite some other items.
>=20
> We are not adhoc adding a guard variant because guards are hip right now.
> And no this does not need a scoped variant ever.
>=20
> guards are not the panacea for everything.
>=20
> > https://elixir.bootlin.com/linux/v6.12-rc2/source/include/linux/irqchi
> > p/chained_irq.h#L13
>=20
> Please refrain from these silly links. People know to find the functions =
on their
> own.
>=20
> Kevin, please update the change log, add your SOB and move the local
> variables (unsigned long bit, status;) into the scoped_guard() zone.
OK. I will do this change.

>=20
> Leave chained_irq_enter/exit() alone and resubmit.
OK. I will send the v4 patch with chained_irq_enter/exit() alone.

Thanks a lot.

>=20
> Thanks,
>=20
>         tglx


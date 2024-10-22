Return-Path: <linux-kernel+bounces-375694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB789A9978
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F069B22078
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50675145B3E;
	Tue, 22 Oct 2024 06:10:57 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2133.outbound.protection.outlook.com [40.107.239.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62A9145A07;
	Tue, 22 Oct 2024 06:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577455; cv=fail; b=a7UhbPJBftoUQ9Irezan8Lahlf8awH/BE3q+WFszMnHaRdnjvek3/X6X8Y1G6I6Pi+th3oWZ8qHjw6GyPV/F0HFQqZfDnMbeVsYWH1wE8hOekTsPkTjrEoGX/Wud5X+dulvmGUXpi8dIRbxrhdhDnKMDr00eteMJ0G2rwavUGJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577455; c=relaxed/simple;
	bh=AlnmKg9bVTyGED/nm1K+Du9P7/ogzgZrYDa8Y/v2wgc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M5rEruhYxEMnNyz3Sn0hQwHtcaFY3CI0KinAl3NAPfKb70yDGbprmQtbqDOPeEhwV0pdNLUFnVmM/rJHgbB3vC/qp9K+A8SAXKIZT4JfMzBLT0iUxlbWXhT6X5pSz+dpaMGAckcaHPDtr6v9jpxdkQsI1yOLnJbXoEuKvQmLw5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IboKJQGPxhEDcqqiOGvM8Oc2GU1FwuXJC5/9Bax/qyoG4t9SceXMdtwQGbDLNgKHExbIhJxor2eGKlVMWM9EsJgUlF7ptwcnn5puSz3rkuAOPffyD/rcS6z/fiWDtbs1gF+mhZ/Ac87HchQ9x+0qJRr4HJpqjTqAiBidjx6UgqHg6EhXJBEqn1ux71C5867aHcmKh/REd0pV/EI5qn3Ex2l3lFbH/lbhAnLt1oR7PQTQlUJPMCbacqtrGuFt3w/9e9ZlOkKULqnfwxm75Atkn5m9cWwcC8j57vyCCyJZBsv0b97s6u02M0Jagk73m/e7/FcYrnQt2DFgUgzTqalUuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlnmKg9bVTyGED/nm1K+Du9P7/ogzgZrYDa8Y/v2wgc=;
 b=mO41aNmY6dUA8tC3JsDrb5yTeiEE0wTAtURQ0+/NejYCbCnedjXfxvE2Qfr0hQA+h9dEnkPkIRkSpCSnsoGAqV7nBFLJc1mrFl1D4pXTehhHlFtE4F1CMtDaJJi7wIH8tc6zq1P6Zzs+OM5OEW5Cka6ul8soSuZu8Qfyf7uCZRtPDCfYJW5XA9JkAlgM4a9u+Oei94cESuURvAjMy5UhqyZ/YLp3xBCZndEzDPCukvDdfF5OW72HaGs7+eZ5LPsKlqUfWPBcPkVtlNCSwWVCB3m6IOik1eO7XRfx/ypU6M3ioSGKql4nR7RjL7agDBDgBes94eU02IEeCAnzN5fM6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a1::5)
 by PN3P287MB1701.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:19c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 06:10:48 +0000
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::12a8:c951:3e4b:5a8a]) by PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::12a8:c951:3e4b:5a8a%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 06:10:48 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: "shawnguo@kernel.org" <shawnguo@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, Joao Paulo Goncalves
	<joao.goncalves@toradex.com>, Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Michael Walle
	<mwalle@kernel.org>, Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>, Gregor Herburger
	<gregor.herburger@ew.tq-group.com>, Max Merchel
	<Max.Merchel@ew.tq-group.com>, Tim Harvey <tharvey@gateworks.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mp: Add Boundary Device Nitrogen8MP
 Universal SMARC Carrier Board
Thread-Topic: [PATCH 1/2] arm64: dts: imx8mp: Add Boundary Device Nitrogen8MP
 Universal SMARC Carrier Board
Thread-Index: AQHbIT2o/Z5SaRrDNUyw8YrBkzrWc7KSTd5H
Date: Tue, 22 Oct 2024 06:10:48 +0000
Message-ID:
 <PN3P287MB117175E59D28C8DDA6DCDE21F24C2@PN3P287MB1171.INDP287.PROD.OUTLOOK.COM>
References: <20241018091023.29286-1-bhavin.sharma@siliconsignals.io>
 <20241018091023.29286-2-bhavin.sharma@siliconsignals.io>
In-Reply-To: <20241018091023.29286-2-bhavin.sharma@siliconsignals.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1171:EE_|PN3P287MB1701:EE_
x-ms-office365-filtering-correlation-id: c8448e62-bbf8-4abd-0f70-08dcf2604632
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?NgNUjNs/bRclteINkTUWjkV7+U3Ilpn8epsrdBavpYfhaoLnyuepkOmKNJ?=
 =?iso-8859-1?Q?u49A+Y87av9lHktkt0n1lMIUNySpH7P5Qj+7FuDsYF5ytWnAFWSvIzAn4D?=
 =?iso-8859-1?Q?cvyl4HHE2OLnNpZscm2OPrN+w6NeUJ2ScI+1qRztC5gWfhZmGtjtMdnO8E?=
 =?iso-8859-1?Q?zZ8q9VrZjDFdpQ23kzCiijLD9Bxuj5jQ/ijFkv1WAQ4I/k1c6cG9LxxHRR?=
 =?iso-8859-1?Q?SJ32tTHdXdes0duHcTPWywGpAZXczUT675l5eCUpQfWS70Jpef/rXqF1xV?=
 =?iso-8859-1?Q?6Q6kYUUMYCX5IfvOITkvww1ifvVdaK4MGGkK/Hhvds9XGPKzMoYdzfsW1X?=
 =?iso-8859-1?Q?TZxJmmhhLeQTcB8Ryf7YFNtbqHKjpGgCwzCV23MteXd2PqEw0BLazcJSGh?=
 =?iso-8859-1?Q?4zu7cDwvNdSuDjoVJq33V/uD/JSk3UAt1g12W5ZGmmxQD06ABur75FNOm2?=
 =?iso-8859-1?Q?kV/mFKO+FOYr1ZcsJgGhLiFbP4MFrb9yvnmg7B9XniqUNFAzGb5PxmqUwe?=
 =?iso-8859-1?Q?YWjx9xWAjI9VBZbrL3OS1397eOEfvdSbyy0ux9KJNnLf8WiC9gOoEILG19?=
 =?iso-8859-1?Q?J1eqbMZoYhJriYJsZboIQQpHKeRbrjWKrvcfCQXd08bAf+dgKE4N0zAdv7?=
 =?iso-8859-1?Q?hUkc2i+zDm13tnjL88UFe8yll71yj8NrYI66Ox+K3xsPOWy0zQrjNBzWDg?=
 =?iso-8859-1?Q?8Y78uGoegMf+aQCxNKgZtyF+tTQRf/OXyYGKJShRIpWAfVYkwg4TbMs7W6?=
 =?iso-8859-1?Q?TWLRIUyIA8WjfwL8mgi360o55E2dYGtlWCKneWD/h56O6RPWGhAnykIW2d?=
 =?iso-8859-1?Q?9s2ms1MTU8meOxN/Bwtaqj+cz8dEs6BX9DcKtBJA30LKRedIo2MWUpDTKy?=
 =?iso-8859-1?Q?i2hGaNdGziq/HXDImnJbBpaeyMAokNPM2hlQfdx0jKtBwMjOEBCQsZO/Cz?=
 =?iso-8859-1?Q?ki7A5IcER9xpSuwd0v9zjxH5DVbSgKbU/Df3WGYHnTf9RI/1dTx5j2I65O?=
 =?iso-8859-1?Q?eGnEemXu1EYIiJIgtKU62jVYytJHTWYsrcejew07MxqkvcOzQb2wqshctS?=
 =?iso-8859-1?Q?+4jj0Sli2PcyoGix7UUTL20ikVM3wg9XlRl5uibJ4b2MfxGo+TRqAG4ua5?=
 =?iso-8859-1?Q?vSp4J54/nu/PaOvtJRom31ppqO3r4wH14GDtXWECkxag31l2PMUVmYK27V?=
 =?iso-8859-1?Q?uQ9HqAsE3+k2YEn1MarW7wLVH01z/q5wSLgEcmqphnjN2g9zFp3ZXvYRNR?=
 =?iso-8859-1?Q?jPnf+Wqc9lyOiK6rOempH2iOnRlbKat7yNKWmHL8lFZGhUJQCUvnnkRbzu?=
 =?iso-8859-1?Q?VLgWzN7tpLbunqpAaw1nKqsEJBoB5Vl03U/YX3Qp7hpj4R4TE19dfllkyO?=
 =?iso-8859-1?Q?rF1DCTcHUVq//Q4uZkYthZmAhS/QnlFso9SQAfvMQsE0wdFuQ//wE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1171.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3DcF++QnzbySJL0hpni6fowMWifDCZ2r44zHiqxKy/otMacPzWXS4pX/gE?=
 =?iso-8859-1?Q?5mqV1zM6pUtUUK4kuftu5PswW8xW3Vsq47XHKkCJl5OwpaoJJkUPx5NWns?=
 =?iso-8859-1?Q?UabeRurFIptcKcayrkppEWMThXWKA1fo0mzodozVcYsgq3Eh/96EN1hshA?=
 =?iso-8859-1?Q?a3R58schEYp/MGIKrAWkFPdIkE3ZaVAI/Rds87RPhe7riIaI930D5b3t2l?=
 =?iso-8859-1?Q?iN31zA1ze9JPVpuLxiKM24eqf8JqcvRnnknf9CJDwa5227qhcOPk2tf2Yv?=
 =?iso-8859-1?Q?akhFTdKcorabjRZCFJg462/oxZEQt7qdxltMwKOuaVfl2OqjH9KAd97lV3?=
 =?iso-8859-1?Q?pcoPtm4xQKcMtpOs13IVSp7MBKcqBQqqW3rgyZKPPkk7Ae82vc9/HsKooj?=
 =?iso-8859-1?Q?2Pvn0gITF50SnsB9Ff5MPG+a2TdjFK3koPS+9MLzt7wQgrzlK3h6BG5mAV?=
 =?iso-8859-1?Q?xYm3i/qIqurFG5ILbIoXCG+FsBM0cMGA66Ic9O+TrNnpHX6zsslcyaqrsU?=
 =?iso-8859-1?Q?BBLnPg+4Ht+3vYwlMbBAXwe6yrNzTMYHyWyLhbGkyVEvKtb6TuCO/Qy781?=
 =?iso-8859-1?Q?v+m+ArYF6tFbfNpO43xVts+A3TTgQk3hXUpgwBsYC1wi3msvxov/M4Ts6s?=
 =?iso-8859-1?Q?SwDRKbJpgz5AoDKYcOadj8TXXFA7gJf4+r7yTN3RNkCnsi4XHxA1Rms8yZ?=
 =?iso-8859-1?Q?2MKb/pbxxUdyCzyScVIpUzVp13tZAdHH9YSzp6iUUVgaPumbPGrhM8+e7d?=
 =?iso-8859-1?Q?jZdx+AhYlFa31fs1wzvsnhzoSuuWE/HB41eTeuuqC+PeQqNhZhLs5905Gk?=
 =?iso-8859-1?Q?5jrXn5ibUZgyiIExc4ppY1CRXKe8eLDm2DWdLb1yO/4SrcMkvIhvO0FTbc?=
 =?iso-8859-1?Q?L7c1mkJTcuoFCQqswrxIZS6YpLlHdFRTvIUZPs0gZw7a50xnB07Df0qx6c?=
 =?iso-8859-1?Q?vFOXYeWhm0A3WL2SwTcmUBsI1cqsiTQ9/M22IQ1VM9LlzIqktzu7UMm3Pn?=
 =?iso-8859-1?Q?4MR4Ysr93+WEYGvcmwAH1w80JrGAgoyT8pi/S8+gXJsyNWowOhtorryAFw?=
 =?iso-8859-1?Q?6lbZpUe5BJFO9D0NQbo52Q2gRnBIA1738H4ByzULIdVKizod6OEYA4FLW5?=
 =?iso-8859-1?Q?TT9IjBwHMJbUXg0gzFwM2hWp+ZlUqS+KQFPaOwejNRm9gH1+hCgTfPbCOS?=
 =?iso-8859-1?Q?7zQQtt372Cu7drL4Acd4ZtPqcXAn1EraN103YaydgWArg0NJGOESuZOnbt?=
 =?iso-8859-1?Q?Ppyt3VQYEAk6FO9UlwJ3i0AcX4NScXhyU3Ngw/zcTUkdlh4UIM5O01qpH1?=
 =?iso-8859-1?Q?TFxDDNXFJLPz5H2M+MqYPdFbJNeZQ9WVGDb02GPikw2WX27Y6RSjCg2AHC?=
 =?iso-8859-1?Q?1ui4KqcPjGbjwkbNzwrqa+8pwirXL8aLGd+xLGPjhVXQbwegdPSTL5rcu9?=
 =?iso-8859-1?Q?XguUolL0CfFH7DgYgRZCQIW/buWH2SPYNg+xORmOB+HxA2yJzFMpnAaR7W?=
 =?iso-8859-1?Q?w8PKYxil6rhlNlvGuJO5VJ1frvJJi5NtO+u6cys935cNcDHe0ZEZTyFurJ?=
 =?iso-8859-1?Q?IFZRZrBhQklPCU83yk4KPh7ZuV6pZg9gEPqfzHtEDa5G6MQPw6hxARwNuB?=
 =?iso-8859-1?Q?h6wOqL+/yINQc5C6J7Mf2YEUGCSgphyQEFgxBMbpum8YHQS34QDz8w1w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c8448e62-bbf8-4abd-0f70-08dcf2604632
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 06:10:48.7787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LzxJRYxaU7jf75RvO79CYhVDV7T55RiWXpVZcXLbSHUEnV4Swr3OOErWUriDeXp9PJeNvivaSQAjtmHQmXVxX9ZHD2i+uQnwFeOryEqvpjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1701

=0A=
Hi everyone,=0A=
=0A=
>Adds the DTSI file for the Nitrogen8MP SMARC System on Module which=0A=
>is delivered with the Nitrogen8MP Universal SMARC Carrier Board.=0A=
>=0A=
>Initial support includes:=0A=
>- Serial console=0A=
>- eMMC=0A=
>- SD card=0A=
=0A=
Any comments ?=0A=
=0A=
Best Regards=0A=
Bhavin=0A=
=0A=
>Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>=0A=
>---=0A=
=A0>arch/arm64/boot/dts/freescale/Makefile=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +=
=0A=
=A0>.../freescale/imx8mp-nitrogen-smarc-som.dtsi=A0 | 349 +++++++++++++++++=
+=0A=
=A0>.../imx8mp-nitrogen-smarc-universal-board.dts |=A0 17 +=0A=
=A0>3 files changed, 367 insertions(+)=0A=
=A0>create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-=
som.dtsi=0A=
=A0>create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-=
universal-board.dts=0A=
=0A=
=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0Bhavin Sharma=0A=
Sent:=A0Friday, October 18, 2024 2:41 PM=0A=
To:=A0shawnguo@kernel.org <shawnguo@kernel.org>; krzk+dt@kernel.org <krzk+d=
t@kernel.org>; robh@kernel.org <robh@kernel.org>=0A=
Cc:=A0Bhavin Sharma <bhavin.sharma@siliconsignals.io>; Conor Dooley <conor+=
dt@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel T=
eam <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Peng Fan <=
peng.fan@nxp.com>; Joao Paulo Goncalves <joao.goncalves@toradex.com>; Hiago=
 De Franco <hiago.franco@toradex.com>; Hugo Villeneuve <hvilleneuve@dimonof=
f.com>; Michael Walle <mwalle@kernel.org>; Alexander Stein <alexander.stein=
@ew.tq-group.com>; Mathieu Othacehe <m.othacehe@gmail.com>; Gregor Herburge=
r <gregor.herburger@ew.tq-group.com>; Max Merchel <Max.Merchel@ew.tq-group.=
com>; Tim Harvey <tharvey@gateworks.com>; devicetree@vger.kernel.org <devic=
etree@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.ker=
nel.org>; imx@lists.linux.dev <imx@lists.linux.dev>; linux-arm-kernel@lists=
.infradead.org <linux-arm-kernel@lists.infradead.org>=0A=
Subject:=A0[PATCH 1/2] arm64: dts: imx8mp: Add Boundary Device Nitrogen8MP =
Universal SMARC Carrier Board=0A=
=A0=0A=
Adds the DTSI file for the Nitrogen8MP SMARC System on Module which=0A=
is delivered with the Nitrogen8MP Universal SMARC Carrier Board.=0A=
=0A=
Initial support includes:=0A=
- Serial console=0A=
- eMMC=0A=
- SD card=0A=
=0A=
Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>=0A=
---=0A=
=A0arch/arm64/boot/dts/freescale/Makefile=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +=
=0A=
=A0.../freescale/imx8mp-nitrogen-smarc-som.dtsi=A0 | 349 ++++++++++++++++++=
=0A=
=A0.../imx8mp-nitrogen-smarc-universal-board.dts |=A0 17 +=0A=
=A03 files changed, 367 insertions(+)=0A=
=A0create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-s=
om.dtsi=0A=
=A0create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-u=
niversal-board.dts=0A=
=0A=
diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/f=
reescale/Makefile=0A=
index 9d3df8b218a2..c7f4cf51dc14 100644=0A=
--- a/arch/arm64/boot/dts/freescale/Makefile=0A=
+++ b/arch/arm64/boot/dts/freescale/Makefile=0A=
@@ -173,6 +173,7 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-evk.dtb=0A=
=A0dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-icore-mx8mp-edimm2.2.dtb=0A=
=A0dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-msc-sm2s-ep1.dtb=0A=
=A0dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-navqp.dtb=0A=
+dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-nitrogen-smarc-universal-board.dtb=0A=
=A0dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-phyboard-pollux-rdk.dtb=0A=
=A0imx8mp-phyboard-pollux-rdk-no-eth-dtbs +=3D imx8mp-phyboard-pollux-rdk.d=
tb imx8mp-phycore-no-eth.dtbo=0A=
=A0dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-phyboard-pollux-rdk-no-eth.dtb=0A=
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-som.dtsi b=
/arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-som.dtsi=0A=
new file mode 100644=0A=
index 000000000000..89f820ddad54=0A=
--- /dev/null=0A=
+++ b/arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-som.dtsi=0A=
@@ -0,0 +1,349 @@=0A=
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)=0A=
+/*=0A=
+ * Copyright 2023 Boundary Devices=0A=
+ * Copyright 2024 Silicon Signals Pvt. Ltd.=0A=
+ *=0A=
+ * Author : Bhavin Sharma <bhavin.sharma@siliconsignals.io>=0A=
+ */=0A=
+=0A=
+/dts-v1/;=0A=
+=0A=
+#include <dt-bindings/leds/common.h>=0A=
+#include "imx8mp.dtsi"=0A=
+=0A=
+/ {=0A=
+=A0=A0=A0=A0=A0=A0=A0 model =3D "Boundary Device Nitrogen8MP SMARC SoM";=
=0A=
+=A0=A0=A0=A0=A0=A0=A0 compatible =3D "boundary,imx8mp-nitrogen-smarc-som",=
 "fsl,imx8mp";=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 chosen {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 stdout-path =3D &uart2;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=A0=A0=A0=A0=A0=A0=0A=
+=A0=A0=A0=A0=A0=A0 leds {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "gpio-leds";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pinctrl-names =3D "default";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pinctrl-0 =3D <&pinctrl_gpio_le=
d>;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 led-0 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 functio=
n =3D LED_FUNCTION_POWER;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gpios =
=3D <&gpio1 10 GPIO_ACTIVE_HIGH>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 linux,d=
efault-trigger =3D "heartbeat";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 reg_usdhc2_vmmc: regulator-usdhc2-vmmc {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "regulator-fixed=
";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 regulator-name =3D "VSD_3V3";=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 regulator-min-microvolt =3D <33=
00000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 regulator-max-microvolt =3D <33=
00000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gpios =3D <&gpio2 19 GPIO_ACTIV=
E_HIGH>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enable-active-high;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+};=0A=
+=0A=
+&A53_0 {=0A=
+=A0=A0=A0=A0=A0=A0=A0 cpu-supply =3D <&buck2>;=0A=
+};=0A=
+=0A=
+&A53_1 {=0A=
+=A0=A0=A0=A0=A0=A0=A0 cpu-supply =3D <&buck2>;=0A=
+};=0A=
+=0A=
+&A53_2 {=0A=
+=A0=A0=A0=A0=A0=A0=A0 cpu-supply =3D <&buck2>;=0A=
+};=0A=
+=0A=
+&A53_3 {=0A=
+=A0=A0=A0=A0=A0=A0=A0 cpu-supply =3D <&buck2>;=0A=
+};=0A=
+=0A=
+&i2c1 {=0A=
+=A0=A0=A0=A0=A0=A0=A0 clock-frequency =3D <400000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-names =3D "default";=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-0 =3D <&pinctrl_i2c1>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 status =3D "okay";=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0 pmic@25 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "nxp,pca9450c=
";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D <0x25>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pinctrl-names =3D "default";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pinctrl-0 =3D <&pinctrl_pmic>;=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 interrupt-parent =3D <&gpio1>;=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 interrupts =3D <14 IRQ_TYPE_LEV=
EL_LOW>;=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 regulators {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 buck=
1: BUCK1 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-name =3D "BUCK1";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-min-microvolt =3D <600000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-max-microvolt =3D <2187500>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-boot-on;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-always-on;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-ramp-delay =3D <3125>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=
=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 buck=
2: BUCK2 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-name =3D "BUCK2";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-min-microvolt =3D <600000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-max-microvolt =3D <2187500>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-boot-on;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-always-on;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-ramp-delay =3D <3125>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 nxp,dvs-run-voltage =3D <950000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 nxp,dvs-standby-voltage =3D <850000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=
=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 buck=
4: BUCK4 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-name =3D "BUCK4";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-min-microvolt =3D <600000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-max-microvolt =3D <3400000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-boot-on;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-always-on;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=
=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 buck=
5: BUCK5 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-name =3D "BUCK5";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-min-microvolt =3D <600000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-max-microvolt =3D <3400000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-boot-on;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-always-on;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=
=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 buck=
6: BUCK6 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-name =3D "BUCK6";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-min-microvolt =3D <600000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-max-microvolt =3D <3400000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-boot-on;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-always-on;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=
=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ldo1=
: LDO1 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-name =3D "LDO1";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-min-microvolt =3D <1600000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-max-microvolt =3D <3300000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-boot-on;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-always-on;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=
=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ldo2=
: LDO2 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-name =3D "LDO2";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-min-microvolt =3D <800000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-max-microvolt =3D <1150000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-boot-on;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-always-on;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=
=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ldo3=
: LDO3 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-name =3D "LDO3";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-min-microvolt =3D <800000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-max-microvolt =3D <3300000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-boot-on;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-always-on;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=
=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ldo4=
: LDO4 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-name =3D "LDO4";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-min-microvolt =3D <800000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-max-microvolt =3D <3300000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-boot-on;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-always-on;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=
=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ldo5=
: LDO5 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-name =3D "LDO5";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-min-microvolt =3D <1800000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-max-microvolt =3D <3300000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-boot-on;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regulator-always-on;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
+=A0=A0=A0=A0=A0=A0=A0 };=0A=
+};=0A=
+=0A=
+&i2c6 {=0A=
+=A0=A0=A0=A0=A0=A0=A0 clock-frequency =3D <100000>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-names =3D "default";=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-0 =3D <&pinctrl_i2c6>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 status =3D "okay";=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 mcp23018: gpio@20 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D "microchip,mcp23=
018";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gpio-controller;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #gpio-cells =3D <0x2>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D <0x20>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 interrupts-extended =3D <&gpio4=
 22 IRQ_TYPE_LEVEL_LOW>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 interrupt-controller;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #interrupt-cells =3D <0x2>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 microchip,irq-mirror;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pinctrl-names =3D "default";=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pinctrl-0 =3D <&pinctrl_mcp2301=
8>;=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reset-gpios =3D <&gpio4 27 GPIO=
_ACTIVE_LOW>;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+};=0A=
+=0A=
+/* Console */=0A=
+&uart2 {=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-names =3D "default";=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-0 =3D <&pinctrl_uart2>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 status =3D "okay";=0A=
+};=0A=
+=0A=
+/* eMMC */=0A=
+&usdhc1 {=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-names =3D "default", "state_100mhz", "state_=
200mhz";=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-0 =3D <&pinctrl_usdhc1>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-1 =3D <&pinctrl_usdhc1_100mhz>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-2 =3D <&pinctrl_usdhc1_200mhz>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 bus-width =3D <8>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 non-removable;=0A=
+=A0=A0=A0=A0=A0=A0=A0 status =3D "okay";=0A=
+};=0A=
+=0A=
+/* SD-card */=0A=
+&usdhc2 {=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-names =3D "default", "state_100mhz", "state_=
200mhz";=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-0 =3D <&pinctrl_usdhc2>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-1 =3D <&pinctrl_usdhc2_100mhz>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-2 =3D <&pinctrl_usdhc2_200mhz>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 cd-gpios =3D <&gpio2 12 GPIO_ACTIVE_LOW>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 vmmc-supply =3D <&reg_usdhc2_vmmc>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 bus-width =3D <4>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 status =3D "okay";=0A=
+};=0A=
+=0A=
+&wdog1 {=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-names =3D "default";=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl-0 =3D <&pinctrl_wdog>;=0A=
+=A0=A0=A0=A0=A0=A0=A0 fsl,ext-reset-output;=0A=
+=A0=A0=A0=A0=A0=A0=A0 status =3D "okay";=0A=
+};=0A=
+=A0=A0=A0=A0=A0=A0=0A=
+&iomuxc {=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl_gpio_led: gpioledgrp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MP_I=
OMUXC_GPIO1_IO10__GPIO1_IO10=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 0x19=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=A0=A0=A0=A0=A0=A0=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl_i2c1: i2c1grp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MP_I=
OMUXC_I2C1_SCL__I2C1_SCL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x400001c3=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MP_I=
OMUXC_I2C1_SDA__I2C1_SDA=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x400001c3=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl_i2c6: i2c6grp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MP_I=
OMUXC_SAI5_RXFS__I2C6_SCL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x400001c3=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MP_I=
OMUXC_SAI5_RXC__I2C6_SDA=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x400001c3=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=A0=A0=A0=A0=A0=A0=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl_mcp23018: mcp23018grp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SAI2_RXC__GPIO4_IO22=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1c0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SAI2_MCLK__GPIO4_IO27=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x100=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=A0=A0=A0=A0=A0=A0=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl_pmic: pmicgrp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MP_I=
OMUXC_GPIO1_IO14__GPIO1_IO14=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1c0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl_uart2: uart2grp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MP_I=
OMUXC_UART2_RXD__UART2_DCE_RX=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x40=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MP_I=
OMUXC_UART2_TXD__UART2_DCE_TX=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x40=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=A0=A0=A0=A0=A0=A0=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl_usdhc1: usdhc1grp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_CLK__USDHC1_CLK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x10=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_CMD__USDHC1_CMD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x150=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA0__USDHC1_DATA0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x150=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA1__USDHC1_DATA1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x150=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA2__USDHC1_DATA2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x150=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA3__USDHC1_DATA3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x150=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA4__USDHC1_DATA4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x150=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA5__USDHC1_DATA5=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x150=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA6__USDHC1_DATA6=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x150=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA7__USDHC1_DATA7=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x150=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_STROBE__USDHC1_STROBE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x10=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_RESET_B__USDHC1_RESET_B=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x140=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_CLK__USDHC1_CLK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x14=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_CMD__USDHC1_CMD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x154=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA0__USDHC1_DATA0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x154=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA1__USDHC1_DATA1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x154=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA2__USDHC1_DATA2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x154=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA3__USDHC1_DATA3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x154=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA4__USDHC1_DATA4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x154=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA5__USDHC1_DATA5=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x154=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA6__USDHC1_DATA6=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x154=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA7__USDHC1_DATA7=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x154=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_STROBE__USDHC1_STROBE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x14=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_CLK__USDHC1_CLK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x12=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_CMD__USDHC1_CMD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x152=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA0__USDHC1_DATA0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x152=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA1__USDHC1_DATA1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x152=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA2__USDHC1_DATA2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x152=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA3__USDHC1_DATA3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x152=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA4__USDHC1_DATA4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x152=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA5__USDHC1_DATA5=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x152=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA6__USDHC1_DATA6=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x152=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_DATA7__USDHC1_DATA7=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x152=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD1_STROBE__USDHC1_STROBE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x12=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl_usdhc2: usdhc2grp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD2_CLK__USDHC2_CLK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x190=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD2_CMD__USDHC2_CMD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD2_DATA0__USDHC2_DATA0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD2_DATA1__USDHC2_DATA1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD2_DATA2__USDHC2_DATA2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD2_DATA3__USDHC2_DATA3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD2_CLK__USDHC2_CLK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x194=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD2_CMD__USDHC2_CMD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d4=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD2_DATA0__USDHC2_DATA0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d4=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD2_DATA1__USDHC2_DATA1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d4=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD2_DATA2__USDHC2_DATA2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d4=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD2_DATA3__USDHC2_DATA3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d4=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0=A0 pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD2_CLK__USDHC2_CLK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x196=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD2_CMD__USDHC2_CMD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d6=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD2_DATA0__USDHC2_DATA0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d6=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD2_DATA1__USDHC2_DATA1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d6=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD2_DATA2__USDHC2_DATA2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d6=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8M=
P_IOMUXC_SD2_DATA3__USDHC2_DATA3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1d6=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+=0A=
+=A0=A0=A0=A0=A0=A0 pinctrl_wdog: wdoggrp {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fsl,pins =3D <=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 MX8MP_I=
OMUXC_GPIO1_IO02__WDOG1_WDOG_B=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x140=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 >;=0A=
+=A0=A0=A0=A0=A0=A0 };=0A=
+};=0A=
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-universal-=
board.dts b/arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-universal-b=
oard.dts=0A=
new file mode 100644=0A=
index 000000000000..4a08fa38dcde=0A=
--- /dev/null=0A=
+++ b/arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-universal-board.d=
ts=0A=
@@ -0,0 +1,17 @@=0A=
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)=0A=
+/*=0A=
+ * Copyright 2023 Boundary Devices=0A=
+ * Copyright 2024 Silicon Signals Pvt. Ltd.=0A=
+ *=0A=
+ * Author : Bhavin Sharma <bhavin.sharma@siliconsignals.io>=0A=
+ */=0A=
+=0A=
+/dts-v1/;=0A=
+=0A=
+#include "imx8mp-nitrogen-smarc-som.dtsi"=0A=
+=0A=
+/ {=0A=
+=A0=A0=A0=A0=A0=A0 model =3D "Boundary Device Nitrogen8MP Universal SMARC =
Carrier Board";=0A=
+=A0=A0=A0=A0=A0=A0 compatible =3D "boundary,imx8mp-nitrogen-smarc-universa=
l-board",=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "bounda=
ry,imx8mp-nitrogen-smarc-som", "fsl,imx8mp";=0A=
+};=0A=
--=0A=
2.43.0=0A=


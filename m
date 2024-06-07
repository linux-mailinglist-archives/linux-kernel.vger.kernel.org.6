Return-Path: <linux-kernel+bounces-205220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4BD8FF998
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 03:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A52A1C20750
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDDA10799;
	Fri,  7 Jun 2024 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TyWlCwbx"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2046.outbound.protection.outlook.com [40.107.103.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618E3846F;
	Fri,  7 Jun 2024 01:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717724027; cv=fail; b=RcWVP1aEVsK021lnbQYt+qQhNBauABioG6ZnE1/PoWovwqPhmqOQawKwwMK6LeUpIJtzrWMdPuSok6kiRWmmJTxP75sLGvBn+/8dJqsxW74O9njggiyVqq/5F8gjAO/8ylVmaTJaR4Hrdt77eye0l1k0rmRCuoec8/S1uODmIBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717724027; c=relaxed/simple;
	bh=/+WP0+Lgz4Rxvs2rvbaS4MIsfBFnHSU3jfduttjbf2g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NI79K1+6naGsC8ZMx3SBGZqA3sVTu84BIjzNaRxt/uUJCkWAm/LOHU4qjTmDvhefU/uHJuQe5j3EDQOzhKjZEkvWKv+3z+ERIMWWj18W46ic+ZedxDMu0xdQqSg7uSxaMVxV/cy/PfhDAQt9sfTZEPOy9aYwhU6VNo7u92cDdw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TyWlCwbx; arc=fail smtp.client-ip=40.107.103.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSs/KpTrNoxitauISu+Xy58OwUQZLxRWhGlSmW75V6UugbWGWM6pw1we0d21qHY0qaXMmNeow1H982HG7ijIZ4UxRk7X2nGPwAt1t+clyf18T7c+ti4chenKAYNFnLjS4mreAHFjprx6hesiBtXwhL65mk7c0ofsx6pi0ETAvNzW+KIiSbiJMN3QQt7ctL4NPu8pBFAY3pe+U5/oKxir/uYysCU74OSscOD9eJla7HyGnIIab5y9Q2wZUHZxKCImr/UhFjZ7Z8sW0nXKwbsdxhFHEdL4kJbgLUqM3xs1mZVuqVSKqBRMNr04Kh4j+4LP1R8M4l0E2vtXPVY88CHT0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+WP0+Lgz4Rxvs2rvbaS4MIsfBFnHSU3jfduttjbf2g=;
 b=lTfpi9XTIbIwbXzHpSpXwG4WLrG1gai+bw+nWLiK5obsyfa/Xgi8TVhOBDLWefvfLdUE37x2UzqVHX+3ytJsAxO1pIxMXIfiYouOr0uXO+05yaG0sI2gtreV6MIK05GfaUpoQd3+h6s2bJcAw1Kevf1vKV2z85kgzrNzJOkziYM8fGxmoQ2hzBjEuTfTEEeCTUFPtEXVPXGtjGLnZX8GsQ77eL83SCQMom9Lz2IXrpZx6a9Dl9rv8Fnf03nHGE0iP+Q6tZ5oQwsbfyV8sB86PgZHAqzRDfC1rdbLuO1JI7qqpEm+0pPP0K+5l19ce0Y2cA25Oumxh1YGs2yUPEkOzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+WP0+Lgz4Rxvs2rvbaS4MIsfBFnHSU3jfduttjbf2g=;
 b=TyWlCwbxsraVYlF8sio/Uybi/SAqVD5IaEgQ0wVL0ea9UQmtbcnTF0Q68U9z4s6SzAoiaTFXRX6Ngve0jHfHRT0T13T2+nmCXl0thwVKxi0IyRic+z1ucD7fCVZnRWbLbEhqC0Uht+LKUbdTlDv6WY20OgE25KOwx7n7xldCknw=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by GVXPR04MB10451.eurprd04.prod.outlook.com (2603:10a6:150:1ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 01:33:42 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 01:33:42 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Aisheng Dong <aisheng.dong@nxp.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH 4/7] arm64: dts: imx8qm-mek: add pwm and i2c in lvds
 subsystem
Thread-Topic: [PATCH 4/7] arm64: dts: imx8qm-mek: add pwm and i2c in lvds
 subsystem
Thread-Index: AQHauEIZBRhtBJ20BEa2si0Iu3rpF7G7hNQw
Date: Fri, 7 Jun 2024 01:33:42 +0000
Message-ID:
 <AM6PR04MB5941C904711D7F5638707CCD88FB2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com>
 <20240606-imx8qm-dts-usb-v1-4-565721b64f25@nxp.com>
In-Reply-To: <20240606-imx8qm-dts-usb-v1-4-565721b64f25@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|GVXPR04MB10451:EE_
x-ms-office365-filtering-correlation-id: c7ec21dc-885e-42c2-5c0b-08dc8691dd6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|376005|7416005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?V0M0TGNTRHE3WmxmdDdWbjRnVGpSU3UyREpCZzBoZ1Yyd3RETFdNQkFmd1Uy?=
 =?utf-8?B?SFV2ZndORGJxRVBpOHptT2ZLLy9yT3dRcG1HTWdJT2hrSWJvZUIraThGWDBY?=
 =?utf-8?B?SXZpcEp2Sm5wRXpSZVVMbjdhUjFBaDZoYTFKQW5nOFk0M0x1OFhFYW9TQnpm?=
 =?utf-8?B?ekw0SVRIcEpGUUJnUGNWSGJOYlBmK3ZiRC9qbksvTXREdTZ6bFVXSnBaSGRS?=
 =?utf-8?B?RDhac1VGcWFqbTlMNkZSS1NyZXZxZnRTSmdmMFBUQmZYZVRoMTBabVNVeFdw?=
 =?utf-8?B?ck5PSUVLT1BPU0thRG8yVkRrdGFOVStqb2VrcHVmb2MzenJ6UE1PalRwdnpR?=
 =?utf-8?B?cVI4azVoNVN6RTJ6bnZJcDZGbTZOaXgvaHlnVDM3UXhoanlBbFlldDFDNGdp?=
 =?utf-8?B?ei9zR3NzMUg2WklOa2JWT2pCbEJpekxYcXBCeTBWTWtabWlCOXhqUVpiWnVy?=
 =?utf-8?B?K0Z1TU1kenJjRlh6bzBBUFRlVzZKNHo2bU9teFJsdGhqR294dG51RC9tVWtF?=
 =?utf-8?B?UUg4RDFNY2ZzSVJWL1hoZjlDU0NKa1ZmMmU1TUdVcytBRndwbXZyQVBUY2Fw?=
 =?utf-8?B?VUdrQ3R2SUovMmJyOTFZQk8zWWx0c1BMYnk4QmZOZFRpV3laWDIzUVluUUI4?=
 =?utf-8?B?U2psU3RhUlRSV3V5STJUUDlIclVFZGEyenlHYUVkM0tpU2ZrUmZUbkdmQ2J5?=
 =?utf-8?B?RGE4K0g3MnoyQjR2YnZuOGtSVXJPM0wxV2lKWWJvYlJrOGdGdFhsLzhpOW5V?=
 =?utf-8?B?MVBuSnBSdTB6OUJzVkVvaEZId3hGcVg4Qm5ldXNQdjdaak5LTkdSTFVKOW8v?=
 =?utf-8?B?bGNIbFlhUkdPN0NSc0d6Yy9qNWlESS85Tkc2UnZoYXZyVzYyaEJwOHliWEFk?=
 =?utf-8?B?MnIyblJibTE4ZUJTZG9MenFzM3FTaXJnK21YU0hPZGdxTmc1dTEyci81dGVM?=
 =?utf-8?B?SlBnN2FMWVpzSlZPOWVXVmhYRngzRDBvU2VQeTZhVW9sb0E3SVp1VlBuQkQ5?=
 =?utf-8?B?b29ITU5SVU1JQ09Ha2d3NjV4S1V0ejVVRWpmQjR5KzlUbXlpd0tJYUR0Q1E4?=
 =?utf-8?B?MUpneVQ4MzFSRXJpa3AyMXNUUVhWejJnUWNsQ0M1RUdBSUZzV0FnV1ZRQUNH?=
 =?utf-8?B?Sm9WZ09pdEh5dnF4M3VUemJBU2lvQmVKQlNIcFBHRjdrRzZUbmJWMGtuQU5O?=
 =?utf-8?B?WTdiZWRpM2p6N1F5ektaN0dxUnp1L1IrSzdZdkdsMlh6N29TWjd2eDVlbk1n?=
 =?utf-8?B?aUNPWko4KzZiNU0zU3YzWTcxeVlDdTBVV0s4c1huU2RLZFFuUVJDL0ptQnZF?=
 =?utf-8?B?YnhjMjcwYklkaVpVT2tPdk9aUS90aCtpaFlrUjZUemlaMXR0aml4UGFCM2Z3?=
 =?utf-8?B?M011Z2V4aFZlNE5wNzhMTVhGb0ZheXhJb0ZCUHBDaGJzNDJEdG5NVTZMNUFr?=
 =?utf-8?B?RWtQUk9aODJLUkVZVWN5d0NPdlVXY0RQMW5tREhOa2tROHBTV0xUamJNcmxE?=
 =?utf-8?B?d2EwakhGMGhJRzhEemJnOVpsTTRueGo3WERTWGpNUFRtcTZYT1pYS3VMbEZp?=
 =?utf-8?B?Y0lPVWJ0cS83R2VzNlBOanJqYVRNT1JoNGxOUG5IRlZTTkR1NUU1M2g4aWlq?=
 =?utf-8?B?Yk5FQWRRS1lZUlFCeXZXUmhuc1pnaUUzMHlwMkp0MXdhcXJlSlY4cGd6dHpZ?=
 =?utf-8?B?SGp1K0wydDdSMHJyeDBhWUhzZi83MWVlZkI0MFdPa0IxTjc2enRuT0ROaFR6?=
 =?utf-8?B?ck91azB2aXZOKzhuWG5RcEZPdm9pWlYyUlZicVhNUS9WSmk4Wjhock5qdVBW?=
 =?utf-8?Q?f4QtIuQ22voG4AnZ8ibMWCeBITGPt7pB/oxdA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QzRNU0lrTWFJWHJ6eHFGWEVnemRQQU42UG1tUTFBUUR2b2JLa3hNVldieUZ0?=
 =?utf-8?B?cUE4SnBmK3lmaDJGU3kyN09vNTVvTC9kRkppU3d0ZWROY002OEJVeU9RZlli?=
 =?utf-8?B?b3lpT0d4cGtQWFpVMCs4K3ZscjlVcnRoMHlhQUR6Wm1xVVVZcTQ5dDFoMUE4?=
 =?utf-8?B?VXZzUEJVdmN4VWx4S25NSFI1SVRpK044M3RMVlNTK0pBVndkU3ZLY2VrL0Rx?=
 =?utf-8?B?WjFrUjZLZDd5dzdldmZSdTBQaVRoN2VZMzJVdE9BYlA5Yys5R1pTMU45aEhI?=
 =?utf-8?B?REs0TFJKcUEvMVlKTiswZUhFTktieVRnUGRneWpVc3JHWUxjNFphSHFsejFu?=
 =?utf-8?B?cEMvWW5kVzQzL2RBVTdzeGtFV2Y2ZHNTblhNY1IwUWswdElFbmg0eTNqZ21E?=
 =?utf-8?B?YlhoajhGZ2VLZXRCek9ZZlZVd2FndG5ESmd5OVA2c085ZGdtS0d0ZFpNdFgv?=
 =?utf-8?B?aFdRa2pTVXhPUjJ3TkhwT0ZDNTdCbVY0N3htVnRMdHpqMU1nbHVIUlRuRUVh?=
 =?utf-8?B?RGJlaS94c0t1Rm14UGNxREo5SEFNU1IxVm5BcjdvMHFIN1BCRHRrVllzVXlS?=
 =?utf-8?B?V0JTQjh2dVZiZjg5OGl4dU1aYi9JOHJ0SU04ZzluTHRtRnVzU3pqd1Q4WUtC?=
 =?utf-8?B?ekVYMjc1ZkpDN05GVHpWVnQwcERiaFpkdFY2cU9uUmVReFlaUVR5YmlxVUo1?=
 =?utf-8?B?N1c4eUdnWGdXRzY2OEpORmI5ZmZudFlxTkxVcVhCM2J6L1JKamtjc3g0SmhY?=
 =?utf-8?B?M3Z5NzR3SEU4VDVaMXcxeWdlTzc0VmdOZXRmM3pUMlQ0U0thMGw3OFFmTmZL?=
 =?utf-8?B?MGkwaEdtRGVUQUw5TSthTFUyLzF1UkFpM0VXdG5LQWZONFpoOVEzLzdUZmdT?=
 =?utf-8?B?MHBpUkgrOHdXZlcxVXBWa1pMaEZSbXd1Y2UyNXJwR2I3QVNaY04zSWNLdDNS?=
 =?utf-8?B?ZWNNVjEvKzYvLy81NDRxZzhDTE5DRm94WTg2OHJOWlFHdFlRYkhVVld2RTlD?=
 =?utf-8?B?UmZsdCtrcXMwMTI0ZS9vdGk1eDNscTJPWVRNSnljYjB2QVZFUG8wbTdqUzk4?=
 =?utf-8?B?VzZ1OVJFWC9TendINlUrNjJvM010MEoxS2k4eWJQejNXMkFHd2FoNmZaYW1Q?=
 =?utf-8?B?dUUyYkl3bjRxSFo0M1ZXMmJoV1pORWJPMnRmVVFleGZPZnF4WlV5Z1dXSldX?=
 =?utf-8?B?bnNjVm51R3FmUzlyM2xQcDFBbWhmVXFiZGlLY0FUNnhTeU5sYmROMnZCV2VE?=
 =?utf-8?B?TnZ5Zm5rcCtUM1BCcHJhdFV4RWk5aHVldHdYUmgrZ2wzZjdaODVaSGRRc0Nw?=
 =?utf-8?B?SWxwcWlTZ2VGcVNsUTRsWjRGN09adjNvNDdZc1lSOHEvY2I1dVM5UWp1bWNO?=
 =?utf-8?B?c1g0UkVXd2dIdkVnaHd4YmoxUUJQbnFMMWZPb3MxQ3h6ZVJpMHFsZlBNdG9B?=
 =?utf-8?B?ekU0YmxtNFlhZnVhZVRaQStaV0F0d2lpYmlPbGdsOTJTaUR3cmkra25kRzZZ?=
 =?utf-8?B?cjh2TEdIdW1WS0d2VE5sR2h1UytYU3daZGozY1hHd1B4K3FmdXpOcmxCUnpt?=
 =?utf-8?B?eHo4L012VFBCdjUrZGNmNWtTUUhnS1pXWlJZb2t0SldMWmZWbXRrUDRDRk1y?=
 =?utf-8?B?OFlZemxGNWlzOXd6REY2OGpETU40T0tlM2lFdGFvY2trdC9OZDhiUzlSSWVD?=
 =?utf-8?B?bVR3ZUNQSE9UYW0wZ2ZYWFBuNXJZU3ZoaDNTQ0R2Sm9FRnZDL2xHRUFKWU5U?=
 =?utf-8?B?a3lyZ05WekVaZ05rMk1vMzNHdWJzQ0p3Y2NjVml0Q3dUSXM0bXNHZGtBMkM4?=
 =?utf-8?B?aHdBMUk3enFkU2FUUk9wS3J6MWNZZ0lhR0tXUFVhWHdNRlNlS0JBTEU5WElB?=
 =?utf-8?B?QjVvb2V4MCtCTzZudjB3bDdNYVRaamRWTUc5dWQwdUN2U2JLeGc3NUJ6bnRh?=
 =?utf-8?B?NHZwdWEyelc1SkxtZjN2TlVtSlp1ZUFoY3dWelFvTnlRd0JWaWNrQWphOEFB?=
 =?utf-8?B?cUxJVGlkQjlPV3oyQndRbGUvb3NVNnc0dVhQR2d4blRLVkwvTnVMTXQyWHlB?=
 =?utf-8?B?MVhVeFpyVEVZblQreURsWVI4ZS8wbThscmZ0R2ZPQnViczZ4U0NKTkhZSFJK?=
 =?utf-8?Q?kR1U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ec21dc-885e-42c2-5c0b-08dc8691dd6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 01:33:42.2303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e0/ljO64FoxwFJNok6ZG91knNfLV2zfd28/L9ODP6y9Mo5IVWiXTcKzKwU1YQo6bXHfg4+qVBsR9iFN8TIPHqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10451

PiBTdWJqZWN0OiBbUEFUQ0ggNC83XSBhcm02NDogZHRzOiBpbXg4cW0tbWVrOiBhZGQgcHdtIGFu
ZCBpMmMgaW4gbHZkcw0KPiBzdWJzeXN0ZW0NCj4gDQo+IEFkZCBwd21bMCwxXSBhbmQgaTJjWzAs
MV0gaW4gbHZkcyBzdWJzeXN0ZW0uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBGcmFuayBMaSA8RnJh
bmsuTGlAbnhwLmNvbT4NCj4gLS0tDQpSZXZpZXdlZC1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54
cC5jb20+DQo=


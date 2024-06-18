Return-Path: <linux-kernel+bounces-218559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B6E90C1D8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 04:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5382835DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956A11CD35;
	Tue, 18 Jun 2024 02:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pxVngsFA"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417C018B1A;
	Tue, 18 Jun 2024 02:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718677554; cv=fail; b=ZmZykMrLhSvgz1kVH2aqPuHWHp5Gk/KmaKH3fPTGf/NkzKHlco3ejI+WnQHaJiLzVOJbZoYSQyC+Xu3iYgTDcB5noHuoxUdj8Rgm6ol8nR1MoUspj4yPVYC/hz58f4S6Ty0cnOk3gtnRmFy6RINnZaSAoLrBOXM0xMNYCu6CUUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718677554; c=relaxed/simple;
	bh=Z4u7g6H0loCznCnxXDrFH/BlXisD14f9Wvieum1RFxA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nhUtRTN07VwbYNLnNE0CHkods5fSh7I4syGHtv6C9W3HScnJeH0JIexrDYHHo3FZzi8eKFchTpIDQhMu4CIzifdrQKA+e2UWK2qt4nZbkzjyALNNb66yVCNv0aSfcrvi2I6nRqOMp6ffc6pwM9hQccNvD07ksmrENtBR3pcVqVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pxVngsFA; arc=fail smtp.client-ip=40.107.20.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNe4c9XSd7kirp1gFbqHaZ/ZY/k+sshuHKCmis8bp96m99RbR4Q6eKq5aj/r+0Ztjw8VClusG56iEqHel7RayiJww9i3j7SPdFIVFUIizO4HLoxMIfYwquRBL4ltQeK8gCg6b1pLJ9unD/OKvhDCaSm5ndUsawEH/UuAoAx7Sd8HLw9jSHCJvErjHXwOS4w+vtUdHux4UnVFfenXFPzxMTpQ7/pkLqC0hoLAOte3DYjNHr4oxNxVG+kv1rYgUU1apU8eDZ9DILghpu53+IWzc2m5PNXWL/jydx/4ZVpoOo7DZgsFmMKCtKzYlLUUskbv9NpA1IZG5vilPSBa4Dufag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4u7g6H0loCznCnxXDrFH/BlXisD14f9Wvieum1RFxA=;
 b=G02WlwYJvzOGhVC2Gpxo/8LN4sEn+aOw0R3B/0Mc6hBdC/Xp9GObRhpeuOT6XjcUf1DPMg3NuU6W72eoQq4jpmutzTM2VV2ustWZPU1Kt1oBdcsjQFgk2PT6Fh4shfXzTt1V6s/0KpG0Hdb1ea0XwVlavdDwfzgabi1w4Fb6Td4AEQHbwWYSixIKKRz3FhIiEtG7aB2IGRGQRX0N6RZ6LUuaHsGYGHB8kDyTktGKY+OnjaHO3uLADo4kRAeZcv6E4snVHXoyviLa5HVv1WxCLujrS211YMb5baTSoV15+7ip0aH7wOjkTCouL4ukiuNkET6y9hbLzzTjOTUZDpSvPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4u7g6H0loCznCnxXDrFH/BlXisD14f9Wvieum1RFxA=;
 b=pxVngsFAcABuutL7KXEyXcvDvPvDpnC9vzdQowQmnGietLBsyda68sVxUwCcyGSKDxJZB53+P2MniGrjLT8hBVCrSXP4ApRd36GshueWSmRU6BXfIAhdLIS0Qtt5pIuL/DmP5EfzhXNDJLttQvcm2YX0FuV9R9uzeDCnxTaNgL4=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by GV1PR04MB10536.eurprd04.prod.outlook.com (2603:10a6:150:208::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 02:25:49 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 02:25:47 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Shawn Guo <shawnguo2@yeah.net>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, "open list:OPEN
 FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] arm64: dts: imx93-11x11-evk: reoder lpi2c2 and
 lpi2c3 label
Thread-Topic: [EXT] Re: [PATCH] arm64: dts: imx93-11x11-evk: reoder lpi2c2 and
 lpi2c3 label
Thread-Index: AQHaobMeAPh2QWLOpUu1jfYzeEmw77HIqWoAgAReynA=
Date: Tue, 18 Jun 2024 02:25:47 +0000
Message-ID:
 <AS4PR04MB93864091DAEECD32D6B65113E1CE2@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20240509015709.3668405-1-joy.zou@nxp.com>
 <Zm1D8CsF/ggZtQzs@dragon>
In-Reply-To: <Zm1D8CsF/ggZtQzs@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|GV1PR04MB10536:EE_
x-ms-office365-filtering-correlation-id: 44b8b394-6dcb-4c72-0feb-08dc8f3df69e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|1800799021|366013|7416011|376011|38070700015;
x-microsoft-antispam-message-info:
 =?gb2312?B?bDNkSFlDL2FwdGJoN3RDZ2FQcTNEUi9RSVBnZWIwWmNxMVljOTUrM01udU1V?=
 =?gb2312?B?dGJ2UHYyNjZHenZSaHRwam13cFRNQ3F2ZEdNeE5OV0UvZjBjaHdtL0hpTVph?=
 =?gb2312?B?b2Q3YVRsbkdFWmxQVXNoMVZQNjVhdXdrbHNHTVpyQUR5bG9yZmlFRExtd1Ro?=
 =?gb2312?B?TVp5ajhZQ0xab0piMytYQTdUcExFR01GbHc2ekFGUU9DZlFhVXZvMUQzZDA1?=
 =?gb2312?B?clpmZU1uNElSeTh5NFhMc3Nac2MrU202cFowdmcrTytMamJTZVZXUkFHSWhO?=
 =?gb2312?B?cklhK2pUWnFGZC9uamthR3NUcExVZ1pjcjM0eG9RMjV5dit6a01zbXZQMEVR?=
 =?gb2312?B?T1FiMUM0eUpqS1ZJemJZRi91Mkg3UjY4ejhEMFhPK25lNXlDZmFjdU9tUFdp?=
 =?gb2312?B?MUIwbS9HZ0JCSCtVb3IvM0lsVkZhc1Y1RXBMQklWOWcycGJKMHJsOWY4enJr?=
 =?gb2312?B?WTgzVGduRVhlaXdPMjRJRWtmUlVVdHROY2EzYzR4TlBVZU41Y0thVzVudjNJ?=
 =?gb2312?B?N2VXeHVGZWtJdy95YWhPcUpJNnlRVHpLOWJEaWwrS3lOOUlWOUNNMjhHMEpy?=
 =?gb2312?B?NVBrUlJ3Z3NpYnJSVlorVnBIWnZNVXR3ZDJkalMxdUxZN2RmdzEweFptMEto?=
 =?gb2312?B?dCtVNWFXL1I3WFZIc2t5bk5IRnJEZ05GbU5pVFpqdUpBMnpsMWlVcTRyeXp0?=
 =?gb2312?B?Ty9JVzNWTlB3QU80K1o5U0FhZFVmS2VIKy9RUG5XY29CSUNnL0JlZ0FWZjFU?=
 =?gb2312?B?UU1MYlZualN4Qklxdjhkb1dFcDV3dmJmUXVGUzQ3alRoZHlFaXUxUWJiSEtY?=
 =?gb2312?B?cU9JTkQvWDBzOXBmelUvV05VdnVFNFh5cEZPOVZjQy9xU0tLVXptRUlCUnlF?=
 =?gb2312?B?YUtQQ0RFTEdoMlpIRVNNZjhJNFQ2M203UFhUMmwwdy9WTWlFK0p4YUFBaFpT?=
 =?gb2312?B?S0ZaWHEweHl6TW5BWUpkY21INEZDdlZBK0RPdkUzVjFoMjVaQjV1V0l6eGQw?=
 =?gb2312?B?c29XUExZY01qK2Q5bW1IdmVGZlkzRis0eFV6b2N5TVpTQzYzaHB5Q2lTVnph?=
 =?gb2312?B?RXFJaUYxaFhoT0x0STBOWk52YmRUYkJud2VFa1FoUmk3YTVvTGpkVHRqTjdN?=
 =?gb2312?B?RnVua0ZuY3Z5dmdVaU5vTUpNSTNOc3NjREZpSjdlT1BuVnZ2S2ZJVTc0end2?=
 =?gb2312?B?VzFpUHhiMDgxalEyN2JrTHg5cUhPQ3lBdlVDVlAwcmZMOSt0M1Z2eDgyeVVt?=
 =?gb2312?B?SnYrMXBFRS8zMGVCbUNkQmlqWThaR0JoQzF6Mm9IcDZYd2lwSXJobWtjZ29K?=
 =?gb2312?B?QllHV004dE9JU0tzMFdvaktIN0szekZGZlN1bloyZm90L1NWbW92STZ4aVB3?=
 =?gb2312?B?dTNnVEtWTzRMZklXV3B2cTB0RGdoSmoyR1U2MFRHVEwzYW1XbkpENzBMbzdU?=
 =?gb2312?B?K29peGJpU0VEa21LSGpkbFArOHpKV3lYOEs3NXkrTUcyTURQUlZWVHpWblBv?=
 =?gb2312?B?dVhDR0QzaXZIcXFkdUR6L1Y0UHJOZ1pIbXVyK2M4YTZzL0grd1puaHhmbkla?=
 =?gb2312?B?d0RXaWNaVTkzTmIyQStGU3htSkpKU0lMb2dWU0VzT2ozcTJWZUdtemc1bHFF?=
 =?gb2312?B?TGc3UWdqZEt5Z1d6NkxFNWpCUTFyVFB6QzFndmFPSWgzVlNMMWpnUWE0MUh3?=
 =?gb2312?B?Q1ZNeVQwTERYUUs0cEtHL2NhT3Ftcm1CMG1YVERRdlZhN0JmQWFzRXFZYUFw?=
 =?gb2312?B?YVZGRjNPbHRhcFFIdGpYVEQxSjBHMm13OFcwTDBlUWJKNExoWmtDRjBWSjVr?=
 =?gb2312?Q?NhsKwnBEMjm5hpDFr+Q22O3wJW88y7RzsJM58=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?NThWSEVRQ0ZoSStIUmZIVFBOSEU4ZUc2RW41aURFSzJaUGdTdC9XeTN1ZHBU?=
 =?gb2312?B?emJqTHJlM2dhY2dhZFI1Q0pDUGY0YmJ4RmNySmZoeGU4OGVYdzRPUzFYQWtx?=
 =?gb2312?B?UXFiQVdkWW5ZK2FBT095TzZ0VDVjQzgrQUhZaE5rcy9ra1FkajA4YU85NlBa?=
 =?gb2312?B?TGIwOFFvVXJCcWZJQlQ2aHpPbFUrb0p6SzJ1Rm1HMk9CbFlWVFBhOGJSeEJt?=
 =?gb2312?B?aUlDbTZJclRWMEdldUtta29TSDNybThkUFM0RUJSY0pSRXN6ck1CM1RZWDFv?=
 =?gb2312?B?V1NIS0ZxTTFRYjhGZ3FqRVBUTFZqK0tlVUlrRHl2bmFVMjh1ZTBweWJ5Y2ow?=
 =?gb2312?B?MmVVRUZrVVNxOUZRUU5tZnZpd1VrRG9heFM5S3JOV1dTQW5MRnFtV3d6eEpX?=
 =?gb2312?B?NUQ4aFo4dzBIU1grSGVDMkltSEJnbkZKYkVidkIvU09ObUlDUlBETXA4UUpC?=
 =?gb2312?B?WDhwZ29MS1piZU50eHhJcWdLOUVZbnluNTRQR1ZNbkxrV0NPbEdNZzlJeTZS?=
 =?gb2312?B?a2tHSTJjU0taSHBVSGRuQ21JdmpHY3NLU0lGMWdsUUpqUERIVzFORVNjVFVL?=
 =?gb2312?B?YkNPK0Y3c3NRdkZYWmhsQTc2NDVsaEwrcHJIU3p4d3pVS1NVLzlrdG9zV1gy?=
 =?gb2312?B?NTYremVoOGNEU3l0WGZSaHozN1FpUHp4SGZiMUo4S2hkV1gzSzJYaWowTHQz?=
 =?gb2312?B?UXRPVi9RdEFrV0hkSkFzY21DM1AwTHcxTENqN2VYYWFSbkFVZmJYTDQwM3Z0?=
 =?gb2312?B?UDY0Y285aUVhMHRpc0lGNElVYVJjSjVqRnFMQWlhN1JUbUZvemh6SSt5d0tI?=
 =?gb2312?B?V0JaNWozd0tSR2J2bTNvcUtrbUpMcE91cWVSckE1RVllM05sdFFIV3pDanZI?=
 =?gb2312?B?eVg1WTRRcUxJTE9UUm1XcVFhMVU0UEpkTTJlSktQb2h0aFZXUlFyaTFZUVdl?=
 =?gb2312?B?dkpQeTBWUkpnNFNsSURLeDBPelh3Yms0akRmc3hWSTBOejR0TGpnUFVmNmVZ?=
 =?gb2312?B?NVJyblRpc2RmN0lOTGdCWTlaNlN2eGtIMnN4NHBlTjVIQTZGTmNEN2hSTW8y?=
 =?gb2312?B?OWVibG5FNmpUUngwMU5EVDRlVktlMEx3NWNwaDVhWVNMUE9JZFQ0YzZVVm96?=
 =?gb2312?B?WmpWZWZQS3p5SG54UjhUbVdRdFcvYXdkaHdRNmJyVjd2ajRwb0NubnhPN0k2?=
 =?gb2312?B?RnhQR3RxUWhlYXBDQllkUVc4SzVRUHJ6VElXZ2hkc0ZCMHdlUkdJcUcyL29R?=
 =?gb2312?B?b1JTWUJZdVFpY3lUWldyMXlrc2JjR3diWW1OVkpkN3VmYWZhUVJlTVcreEhY?=
 =?gb2312?B?NnlWaVU4dVQ3dTREZHBCaWxzaXByK2x1djBJWUJ1bFNZVzhydXRxWjFvdjV5?=
 =?gb2312?B?ZHN3bGdqY0RMWW44OFowaG9Ma1BVblhPOGtDdjMya2tkVGNianZiZWJNNDZ3?=
 =?gb2312?B?TUFqRnhxVmFDdUF0ZWJSVkRQWWxGMnFsUDNWQVc3MmhaNE8yeGovd3ZHNmJM?=
 =?gb2312?B?blpjZUtZQmRydVEzYWFpWnYvUHdSY3FRZW5tQzlmaXREWS9EbWNPc1FsVU9u?=
 =?gb2312?B?NlVoOFdRd29ScDEvd3lxSjA2SGpyU1JsWUluekwreGwzQ1BheVhuNkcweVlQ?=
 =?gb2312?B?b2pURjJHcW5INms1N0tBZU1xL1FiczNzL1ZoWmNlMW5xWTBKaFpQYWk0N0Rw?=
 =?gb2312?B?R2NRZFhxSXlmdXQ0SFlOZHMwMlNSbFdpSjAxRFRaSnNOcmFMb2J3VUJnak02?=
 =?gb2312?B?VStBTEx5MEpiQXZLaG0xemIzamxtOUszTXZHMHp1V3NtY0Z5NkJ0MXBCQXJa?=
 =?gb2312?B?dHVpRUVnL0dBditGTG4vYUtKSVU2VGdCbUJzaDFQNVNOTlAvQTEyRlhocnps?=
 =?gb2312?B?a2hnS25xUzg1Ni9ZRWN2dUtRd1c2NmVlemJ2aFArM2lqVGdhNHIzVC9ZSUJK?=
 =?gb2312?B?OGxDQjF2ZFhwOXpQZFB0bFEvUk5BQVBCazNMVndmN05JVDdHU2VYRGlUakRE?=
 =?gb2312?B?RUVvcDhwYVdRYUN3QUtJRi9EcTdqbnVRR3NDUStRQ3gzTkl5Vjd4VWQwTEc1?=
 =?gb2312?B?TDZ2eWc5YXBITFJPR29UWnBLS1gyZXR2ZmthQzcrTm0zaW5FRUN5dnIwTGxF?=
 =?gb2312?Q?0CPE=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b8b394-6dcb-4c72-0feb-08dc8f3df69e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 02:25:47.2959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lr3a3qVGoeMTcseGksh2q/PWfGIs57DXoJYAFqtyO53ORH97Di0qSBKRhhE+7/0a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10536

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNoYXduIEd1byA8c2hhd25n
dW8yQHllYWgubmV0Pg0KPiBTZW50OiAyMDI0xOo21MIxNcjVIDE1OjM0DQo+IFRvOiBKb3kgWm91
IDxqb3kuem91QG54cC5jb20+DQo+IENjOiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsg
S3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5
IDxjb25vcitkdEBrZXJuZWwub3JnPjsgU2hhd24gR3VvDQo+IDxzaGF3bmd1b0BrZXJuZWwub3Jn
PjsgU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsNCj4gUGVuZ3V0cm9uaXgg
S2VybmVsIFRlYW0gPGtlcm5lbEBwZW5ndXRyb25peC5kZT47IEZhYmlvIEVzdGV2YW0NCj4gPGZl
c3RldmFtQGdtYWlsLmNvbT47IG9wZW4gbGlzdDpPUEVOIEZJUk1XQVJFIEFORCBGTEFUVEVORUQg
REVWSUNFDQo+IFRSRUUgQklORElOR1MgPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgb3Bl
biBsaXN0OkFSTS9GUkVFU0NBTEUgSU1YDQo+IC8gTVhDIEFSTSBBUkNISVRFQ1RVUkUgPGlteEBs
aXN0cy5saW51eC5kZXY+OyBtb2RlcmF0ZWQNCj4gbGlzdDpBUk0vRlJFRVNDQUxFIElNWCAvIE1Y
QyBBUk0gQVJDSElURUNUVVJFDQo+IDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc+OyBvcGVuIGxpc3QNCj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1Ympl
Y3Q6IFtFWFRdIFJlOiBbUEFUQ0hdIGFybTY0OiBkdHM6IGlteDkzLTExeDExLWV2azogcmVvZGVy
IGxwaTJjMiBhbmQNCj4gbHBpMmMzIGxhYmVsDQo+IA0KPiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4
dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4g
b3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVz
aW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMgZW1haWwnIGJ1dHRvbg0KPiANCj4gDQo+IE9uIFRodSwg
TWF5IDA5LCAyMDI0IGF0IDA5OjU3OjA4QU0gKzA4MDAsIEpveSBab3Ugd3JvdGU6DQo+ID4gUmVv
cmRlciBscGkyYzIgYW5kIGxwaTJjMyBsYWJlbCBpbiBhbHBoYWJldGljYWwgb3JkZXIuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBKb3kgWm91IDxqb3kuem91QG54cC5jb20+DQo+ID4gLS0tDQo+
ID4gIC4uLi9ib290L2R0cy9mcmVlc2NhbGUvaW14OTMtMTF4MTEtZXZrLmR0cyAgICB8IDIxNyAr
KysrKysrKystLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEwNSBpbnNlcnRpb25zKCsp
LCAxMTIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OTMtMTF4MTEtZXZrLmR0cw0KPiA+IGIvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OTMtMTF4MTEtZXZrLmR0cw0KPiA+IGluZGV4IGQ0MDBkODVmNDJh
OS4uNmJlMWViOTIwYzAyIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDkzLTExeDExLWV2ay5kdHMNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg5My0xMXgxMS1ldmsuZHRzDQo+ID4gICZscGkyYzMgew0KPiA+ICAgICAg
ICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+
IEBAIC0xMTMsNiArMjExLDEzIEBAICZscGkyYzMgew0KPiA+ICAgICAgIHBpbmN0cmwtMCA9IDwm
cGluY3RybF9scGkyYzM+Ow0KPiA+ICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gPg0KPiA+ICsg
ICAgIHBjZjIxMzE6IHJ0Y0A1MyB7DQo+ID4gKyAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm54
cCxwY2YyMTMxIjsNCj4gPiArICAgICAgICAgICAgIHJlZyA9IDwweDUzPjsNCj4gPiArICAgICAg
ICAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8JnBjYWw2NTI0PjsNCj4gPiArICAgICAgICAgICAg
IGludGVycnVwdHMgPSA8MSBJUlFfVFlQRV9FREdFX0ZBTExJTkc+Ow0KPiA+ICsgICAgIH07DQo+
ID4gKw0KPiA+ICAgICAgIHB0bjUxMTA6IHRjcGNANTAgew0KPiANCj4gVGhlIGNoaWxkIGRldmlj
ZXMgd2l0aCBAdW5pdC1hZGRyZXNzIHNob3VsZCBiZSBvcmRlciBpbiB0aGUgdW5pdC1hZGRyZXNz
Lg0KPiANCj4gU2hhd24NClRoYW5rcyBmb3IgeW91ciBjb21tZW50cyENCldpbGwgbW9kaWZ5IHRo
ZSBjaGlsZCBkZXZpY2Ugb3JkZXIuDQpCUg0KSm95IFpvdQ0K


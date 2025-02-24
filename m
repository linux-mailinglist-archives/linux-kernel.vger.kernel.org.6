Return-Path: <linux-kernel+bounces-528332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C14FA41667
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53CE01704BE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EEF194C61;
	Mon, 24 Feb 2025 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b="mgZivzgq"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11021133.outbound.protection.outlook.com [52.101.65.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD55F1BC3C;
	Mon, 24 Feb 2025 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740382769; cv=fail; b=VO8VMPTRlZLIxX0iyfMtp5yjqFhz8mpIT0B/Gm9z40niZHIFHM65dcmyzcbDvY6ZD7qbhMBDYsvgx08Dp0aMK8zddB16/If/3xbUb6Zyp5iQXEq8aPwDHMKG08f/7oQYLOe39N7ktAJ1U1gJNRe7ZlIXgn7iVGBMO7Mfi2n6H3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740382769; c=relaxed/simple;
	bh=fPWw8exq+68fsFbdh1v0858SyRxzO172yvk7tKbjRyw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BuT6bCCQuSQSSYFgTDCXychY7LH94UrfKznrW8cruUvCmd2ODD+pzPPr+/OYwfu0G/EhD3dl3O1m21QDxNj6FuNT3BoPy5OXQnAIDvypzD7m1FN9wN8Uy/99IdFHPIqVTfxW+CjjUBz54jmNuS5+CrXwM1DdybJ5w2syjkVlN5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com; spf=pass smtp.mailfrom=gocontroll.com; dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b=mgZivzgq; arc=fail smtp.client-ip=52.101.65.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gocontroll.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGv8O6fj76jIE9p/IOjCSh5161d0A1KI3wP0n0t5LB+zn60Da+osHSgcQxAXGhxLKpOBW/ewdV93QPJt5wvJl3En/vN6XfpKf+8m0TTzAjEW3VA6SpApGef14WAAssEbBWlcXfsmOXLUwRqQ2ilLxk8hM7vA+1lelP0SiXYfqO8556Xlo5eL1dxSJCCPk8RYBY7iXcs7P6kCzQW50MH4pX8KsMmz8436j0wC3bk5PzqGfU4nLgg/AamsHsZlNi/6fzLTXPxxbX0r6aitpt8V5C2pbzQ0XXfTIXiDXz43EYPOSz3WuvqMwfzBIa5uJerklM/rJWv+3fg0CwQKntdJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPWw8exq+68fsFbdh1v0858SyRxzO172yvk7tKbjRyw=;
 b=s6nCzrC3qL8iutkENLmX5UFZESdnpqhB2IQhlUzHkh/rSlAvGBm6QA5dVhILO4QYrzCw08gadv2bIqoEbBxqfW6hItUGAaX//WyTtz0E8Fh9ZjAKWxJZiDP0Ay7Lu56yXBYDsJ0daYi67BY5DIii8jZwKk+fiucyWq97PGYeFOxK0zZFSexi0bMu3w0Noym+rt8bWO1PCOUgTtW68Y8EjcqXVdyEcxfcaODAq9lu+IrERQj0Irb2D+F3Mxtt/TDdSrRdWid72WLLe3lmHReLebYnJWDhebNMhXoynVhhbF3hYXQRvzZ6mTEDG7GVz+UAnTPI9Fh8Ex5pYHju7YIqoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gocontroll.com; dmarc=pass action=none
 header.from=gocontroll.com; dkim=pass header.d=gocontroll.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gocontrollcom.onmicrosoft.com; s=selector1-gocontrollcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPWw8exq+68fsFbdh1v0858SyRxzO172yvk7tKbjRyw=;
 b=mgZivzgqhbMBU21OplN9hAGMkpyYPMQ1KCeMTO/AvCI/bpe2pydlv6n7dRs0jkFtyQ0zMPSfCyfm6oI1dE69o3XxvJHBGfbBF73uSy1Papfobczq0Kq12yhQRDbq6peW8IOnLnwhCeo5Q/uc54A6AYYwwfOiInQ93QJdtHEErdFbXfOAn6AtPLPRJB/KJolegPxifqgtaypX50erDq6a62YFfYL0VzexGPZvCHV+ER+U6ymNATUR+M/Uvm5pnbBDLAKZ5l5ws2/AJ6tL3I6f3d+0VP18pTpDxeXBuKeFD4tFGEyl57Aq5IMR13s6LAGkH/jTy11jOhygYe5Baw/X5Q==
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16)
 by AM7PR04MB6918.eurprd04.prod.outlook.com (2603:10a6:20b:10c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 07:39:21 +0000
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f]) by PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 07:39:20 +0000
From: Maud Spierings | GOcontroll <maudspierings@gocontroll.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] arm64: dts: imx8mm: Add pinctrl config definitions
Thread-Topic: [PATCH v2 1/2] arm64: dts: imx8mm: Add pinctrl config
 definitions
Thread-Index: AQHbgeCdoXMRnYTeVEyu8OaPwsUhLbNUtzoAgAFhb9g=
Date: Mon, 24 Feb 2025 07:39:20 +0000
Message-ID:
 <PA4PR04MB76309B97A0044049F5841C8AC5C02@PA4PR04MB7630.eurprd04.prod.outlook.com>
References: <20250218-pinctrl_defines-v2-0-c554cad0e1d2@gocontroll.com>
 <20250218-pinctrl_defines-v2-1-c554cad0e1d2@gocontroll.com>
 <20250223-messy-silent-tuatara-68f2e7@krzk-bin>
In-Reply-To: <20250223-messy-silent-tuatara-68f2e7@krzk-bin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gocontroll.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB7630:EE_|AM7PR04MB6918:EE_
x-ms-office365-filtering-correlation-id: 8adb3ed3-3504-4d89-ba93-08dd54a659e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?fO30cCSaiAURxW7cRkA1CMDTIMZsmWGmNnbv4CSnX8tdpSWZ0YZIEuT/Cl?=
 =?iso-8859-1?Q?q3fI/Ws3/WsCClnPgFeQewawOnYoem4fkzMAqSnYx51g2q7jS73R3LslQ9?=
 =?iso-8859-1?Q?ztI+mSIfhUjQP7Vu82jR/w8TZo54sCHy2wcI0hu9JPP7F8hla/L8IZPmBG?=
 =?iso-8859-1?Q?8XVUdPsx8QQH27bSDDjMjp0E+H3QXRCg2G2uQ8HqFp2XKdQrs4Znxqa9nW?=
 =?iso-8859-1?Q?jbhedyE8jHbFjJEvVIaUGzsvtcwFCwUcUXEv+ZFjaiDjmIhVKeM2RKdAAg?=
 =?iso-8859-1?Q?u3mc82GZl9hgMxbs+qUiYs2qvJn70UsFF7w0+Lnt/SIVVwJoY3mTstfgwN?=
 =?iso-8859-1?Q?eygHWkrJqOmEQtBplfcZdtu/nbNoN4w30m0VH1ds/s5yeBRoER/nx1OOac?=
 =?iso-8859-1?Q?N4TtppDr5wDzn4yMqlZxE7WE5ZcOq5o2+RxO8+08njd/o8KSQyCjhxUv/o?=
 =?iso-8859-1?Q?lKuR1HURdBVDrd1dgvxk3MeldjtpQuMDocDTd/DtIXYUPO6WZsMOBPG1Ql?=
 =?iso-8859-1?Q?+7yf41duSC6TaTgALbWr+e6OT9ejPRpBygWYuFrrhIARmfZg4jHO/R7tFs?=
 =?iso-8859-1?Q?/w1YQeqOrCPd38+6D9NpTFMXm9IuKJ5/I37vMNBm8xrBBJOTRXjm6U6DmC?=
 =?iso-8859-1?Q?3CKzYfJwt/MMC/GufVV0V815XtYWLEbcHWQS9VwXa/CcdAV7UGseggmBG4?=
 =?iso-8859-1?Q?D3PZjkYTc7ICpX/BuBYqkuWXMXWYHi7t91AT4BfwXVj4tpaQP6lGZ7fxm7?=
 =?iso-8859-1?Q?HB4cnrLcYPY2BvtIEP6zG2HS5lKnR8vRlKAxZy5lI9Ejsn5u93lkn4+cW2?=
 =?iso-8859-1?Q?NJZPiLF0P1iCoK8CU37ektBfxglrahE4gpHaEjv+b3gHiIuP0WT9Uy5n5J?=
 =?iso-8859-1?Q?8t1jg6LLoQXhHiqTk95wcWVNprJu4aAp6n4GX/siFQNvjyGVl6PdIrqAap?=
 =?iso-8859-1?Q?lUW2RA+lNAfx3gN6rEa/csMFO85gnjDyybXi26ooO8rjlqB/6Kmm04SP8j?=
 =?iso-8859-1?Q?W0pmq7l6tiUr3dPZSu5ZDk2fxnBjryuN6ucc5vp+nYvBeSzPBYIfwor3F4?=
 =?iso-8859-1?Q?0N0wiKzIOkC80FFdPw7QTSM0NDJXdV2a7Jiwl1nTzYdgjIiWJExEChQ6VY?=
 =?iso-8859-1?Q?/E0q/8svz09B3x1K+XCkz5J0ockz0N1+/mKCHxMFRwW3oX9D89qKXe3uma?=
 =?iso-8859-1?Q?Kz4XNEFXMTBOpwBHXtd8AkYZzy8xU+bm+riPAnebc6VOgEDBsX196nQ1pC?=
 =?iso-8859-1?Q?96ov6L1zx/lKRTFcFF9wz/LewwmJjL6w5JL68sRAcT6NJ/mlbHnTZx/r5k?=
 =?iso-8859-1?Q?51xNZHMS601X8JucJZPJRsNuTRw2HuA/X7ShEGOHa9vH37oGmFTTQn+TtV?=
 =?iso-8859-1?Q?6tLqNhelep6UUXKTfuOdOPeW6BD4sP9zjVDWTJoddPY1Gey60vhYdd56T/?=
 =?iso-8859-1?Q?GwJqAgXeG5flyJtmiP420DcKYOGmQ19587Drgqo3QytwKRPdR1s1E8hS3w?=
 =?iso-8859-1?Q?8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?BnyOc+T4UMSkEAlIuedQjx8QNu9h/lpxYZE5TsfMVDVHQ8/w5GR+0Zojzq?=
 =?iso-8859-1?Q?VBkownAx6bxVpQ0k/k7436YtBXl5jlCMYINtfvDuW/rvcqlkXepOZN6C3u?=
 =?iso-8859-1?Q?dKnQzNgcRXicIEs9yK23xLK7tpC6mVj1ANVNie0W+8WDvaVas0dwiJQLzn?=
 =?iso-8859-1?Q?XMHpzJb3PZYM1YI7/H0jCsLaKe49eCjzcNUXM/pUxvKgPWcY7H/eVwEB3X?=
 =?iso-8859-1?Q?cH2x8asYrl+wu/+kSyu7bZJhogErWgFfi9HxA9cRZhKGvIFYQ65jHbmItI?=
 =?iso-8859-1?Q?oV6a23+EHsfDw9s+PlYaWHMN0/ZKEZmd/LAuxJUntDRKun9kOrbpYlMmMr?=
 =?iso-8859-1?Q?6ML1u4e1mB3CvArZIhO+Pm9sT3XvyjvrbaALzZQhluj8Av8CA7a5Hum0rZ?=
 =?iso-8859-1?Q?65D9KLTFNwtX35gbcQCyirhjPwzCQsdoWMjeKIsJeW4LMTmfzPFxmAz8oN?=
 =?iso-8859-1?Q?mcepuvqRhTlGaSlPj326ogfrDgAS7S0Y6IyXl0yrqF0RCMzYEwGfwNzNVH?=
 =?iso-8859-1?Q?f3iXdN8TJBiaIkpENBDA/aMiqsBPGQoSTrRUb8zu7Y2O0YmdUBAdW/G7Cp?=
 =?iso-8859-1?Q?VJkDj5EKgJWLkQJGM1emoDJeJMgBEdcKIIG//HITjeXfWhgh1edypwFcp8?=
 =?iso-8859-1?Q?IORuzywu5fw9lSfVHdwSBc2X8w/vWLUdksjBdx6FASMBXiaeVd+li3SFOu?=
 =?iso-8859-1?Q?9U8NV5JF8XpSHCqpLTf3AtQkfmIoBFQGmz4hwLclbMbk6k3SITtsILDuJk?=
 =?iso-8859-1?Q?+1Mtx//oEA6v0u594uKUeyuUanu6jA8mhT12Kpyjl6bso/CiZbTpbh+GAk?=
 =?iso-8859-1?Q?P2ZIh8RWb3ZsxCuMIdo5Em8MLRY/Ff/OMeuUAvzZVZqPwxhX9Rh/w1Tdrr?=
 =?iso-8859-1?Q?1WSxWQc18J1EuFtlxLax0rAWike5XZ9EX4EZsdbnLbGYcdIIiKPJp5oyuS?=
 =?iso-8859-1?Q?FhWHntwo+qf9qFMWqXXo4CovypISw3XSghFUv+8rNt85s+ZhDn/1kLlzGr?=
 =?iso-8859-1?Q?4fOTkG3Q2G5rYhRMUpGoWiwOyeFFSaQa3JztSyku4u+YcOmHL70Qaf80wM?=
 =?iso-8859-1?Q?CwK4pk7kut4dxYiKxyOtvw5TmGINIq9/IiATWqHYXtzVBg8OtJarcDx8hV?=
 =?iso-8859-1?Q?ilQ9U5r7XYfpMBOUavIa50SU33aHX6C6eXuFTlgiUSKLq04ue0aeShXMq8?=
 =?iso-8859-1?Q?sNdaYWHmetWcTgAn0Hy/7nFkEVSmh2/2ooTDj18XH1QeMpneB6kWpi/Wk7?=
 =?iso-8859-1?Q?InnJLTD1sV5rK+TL7o4q7pzvFbRKfw2Bh4HwnXQuCge9sQ6PP89w09DlIG?=
 =?iso-8859-1?Q?h92crGEjdIr3AkaCrq804QbGRCEGEdKNx+nYmOvxym7HYUWUQkZx6Y065q?=
 =?iso-8859-1?Q?olYo6xBBmzzEsjJjTflqYA/3vvxgr/0OgGImwI/sVz58zkAgC1HX6AIqcj?=
 =?iso-8859-1?Q?Xu2cqmCW+uMbt9lLlkoEmxwixFOuo63vni4RbVhi7Kf+27CivVd+GXPu7k?=
 =?iso-8859-1?Q?IL6pRZ4hPqHDFJBe4Vd1R7zQrY74JGRoQCQ3D2BiBw4aydZa9cmtLMa14f?=
 =?iso-8859-1?Q?DaRrAC+Iu51ep+R6hQZOLN3xCMU479bqtXDKakBHzoWrT7fyMMTof5vtg1?=
 =?iso-8859-1?Q?WGoH4lva4tc61fJz7euIl2Ghhsc7gTyHlXEZjUfKgrog34qc6NqxTgn7dm?=
 =?iso-8859-1?Q?GzosZadx/+gMIDqV/XNpYIsWwV+sLyzs6xzacO65oB2ADEkfstbfXZoDGi?=
 =?iso-8859-1?Q?Y5kw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: gocontroll.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adb3ed3-3504-4d89-ba93-08dd54a659e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 07:39:20.5960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4c8512ff-bac0-4d26-919a-ee6a4cecfc9d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 35wpNJ3iLnnnUYsj+qCgkfnW1W+bhxy4V3aXMtiQHXE1SYUwhK4tOkBH0SslOhJDTQMe1PWSnatXjKoJx2zbxtvUOUwk9mXJ4G78gQReNiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6918

From:=A0Krzysztof Kozlowski <krzk@kernel.org>=0A=
Sent:=A0Sunday, February 23, 2025 11:27 AM=0A=
=A0=0A=
>On Tue, Feb 18, 2025 at 09:39:16AM +0100, Maud Spierings wrote:=0A=
>> Currently to configure each IOMUXC_SW_PAD_CTL_PAD the raw value of this=
=0A=
>> register is written in the dts, these values are not obvious. Add define=
s=0A=
>> which describe the fields of this register which can be or-ed together t=
o=0A=
>> produce readable settings.=0A=
>>=0A=
>> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>=0A=
>> ---=0A=
>>=A0 arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h | 27 +++++++++++++++++=
+++++++++=0A=
>>=A0 1 file changed, 27 insertions(+)=0A=
>>=0A=
=0A=
>Why are you adding defines which have no users? This is just dead code.=0A=
=0A=
I will be sending more patches in the near future that will use these bindi=
ngs, the total stack of patches is starting to grow though so I'm trying to=
 spread it out in multiple easy to manage bits.=0A=
It is also a bit of a test if I can continue using these defines as I plan,=
 or if that will not be accepted and I should instead revert to using raw h=
ex values.=0A=
=0A=
If this is a problem then I will keep it in the larger patchset that is to =
come.=0A=
=0A=
Kind regards,=0A=
Maud=0A=


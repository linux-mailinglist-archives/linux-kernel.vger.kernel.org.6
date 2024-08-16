Return-Path: <linux-kernel+bounces-289547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F359954761
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 707B0B21169
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B4A198A32;
	Fri, 16 Aug 2024 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mwjJWZGF"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013016.outbound.protection.outlook.com [52.101.67.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BEA817;
	Fri, 16 Aug 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806152; cv=fail; b=PiSNvCkSLETcG4nn953MDqkIw8NW2eooU7FQG5Beu+tTDYzWtDQbIn0YcJW6rY+65kgTfUoeWQXHmQjTCYfG5hPx8TFHRjPtajazPQyeUgbltrrlMObM/ogyKA0Q+YcuyJI6cYgWbXV5s5ryM2PQNGvnyVUfhTNH6bd8L8qYN5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806152; c=relaxed/simple;
	bh=amRhJABwkPtC5YDL5eVlTOqrboRhMg0BdrLTW/dRDuU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MILACA3TDy/FfWOqk/PEyUFqmtUjXQK95i91gQcPAR8wEYoRJW0DE0ohOiHg5f7nLwT79ExxVV6xa3h/Lxqd50MYlTnv0t4cH4Bp7UhBTdxVJtZdCBv2fyKUs5SV1v1LL9XHLq6fm+Yfg1gUbnZ++Z7ezCmr8zbkdHPa++y3x0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mwjJWZGF; arc=fail smtp.client-ip=52.101.67.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blHqc1pqVpJEZkltiJ43Y0yMwTKiLDYLNqpKeXz0xUTijN6uOLZMroHltINwWP1uWyOSkjD9jHAOU9Sz4QxWXBoVBIFsfPMXfOhaxNDgcnzV87KCllJnANosTBuoh7xxTB9ZzZOMESdGKs8Q8mVoKExquKF5GHzc/U+p53ybzUSh245PwxDTPXYb0hc9rz+dVDnJdo5y4xNZNBE2Ov9Xqt56vaUUrx7yDjGfNcjtL2VS8v3rVfrtNjnAyAxWLzTkc/ecW1DNKKzb95rDae/Noxs2nhwK3jO3PdmYrOKXW0Ub90hxPhqclz4nvP6Ygfr9gkrsDvxiCPlRoGjmLsxFug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//Wjc6uWO03FOy+tOru+Ag7BBr7ZC2bHS9arbsf24Ls=;
 b=YV2bnV9fHP1boAALvxUFTIC6im8Vvf/KlWQCNtLRw2gRTPNy946FNnkHmflqGacvIgQE6irM49xIM1JS2rJL7zz6fZK/JKIMZ0Bxoz0QaUlCeaY4dDPal7aBmMuHEFj29kAEByZaYcs5W4l28i5x1PoBnKZzjd+34mw5nrU3zEOHYwHpsHtAUxe4Welgj+GK764wL6SxVQcYFAQeR7Q9h/TcdKe/r1DkbmpjzvaRr2vcNsHhg+W9gx4wC4JYRtKuGGWT8IK4v0sAew1sjWWG2BVLOD0qpOw43L5pMyExlHVk92S4rCEMI6Fml4yBrEdn7a7ARPrT+iDp8227G1RcjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//Wjc6uWO03FOy+tOru+Ag7BBr7ZC2bHS9arbsf24Ls=;
 b=mwjJWZGFPLhx7jc4d7cooxnwRH1qmcDx7lpCz6S3f4+At0mNMoaKNjRp0ffxmHarocdr+lxiKRcC4eAZP+4L6TnoPtIICmt3+/p8PSmCiz7mvNZFZQ5yuW+ObEBkjZRHD9a4HJnqparreusCFJG0ZBQIDaC++QFxbgQpzeEMAn64tlGn1/EqLVHqgvExSr5QLdkQqUGgFtN73XssvzKq6y5pZIFFhwjzKh6T+DovhaofhZZQvzY6TKSa+1PWgg40ohHRHRyqReAfJTU8XA9SKYIZ04TWKoRAhBRWjvyzHpfpe4yKpwDtOpTZprygn6JrcaClvYZNmUHcdgwMxNkZ+w==
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by VI1PR04MB9953.eurprd04.prod.outlook.com (2603:10a6:800:1d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 11:02:27 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%2]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 11:02:26 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio
 Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v6 5/5] firmware: imx: adds miscdev
Thread-Topic: [EXT] Re: [PATCH v6 5/5] firmware: imx: adds miscdev
Thread-Index: AQHa2/NcuiznhUStfE6qn0+OVrPkAbIEXw0AgADp6iCAGVVjgIAAHXuwgAsjzsA=
Date: Fri, 16 Aug 2024 11:02:26 +0000
Message-ID:
 <AM9PR04MB86042B8CAFCF7D7474BB0DCC95812@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com>
 <20240722-imx-se-if-v6-5-ee26a87b824a@nxp.com>
 <Zp-8MPdWdAhGG9de@pengutronix.de>
 <AM9PR04MB860410277C8329271E12963F95B92@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <ZrXAv79KFCSyB3U_@pengutronix.de>
 <AM9PR04MB8604068373E25AAA99641F0895BA2@AM9PR04MB8604.eurprd04.prod.outlook.com>
In-Reply-To:
 <AM9PR04MB8604068373E25AAA99641F0895BA2@AM9PR04MB8604.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|VI1PR04MB9953:EE_
x-ms-office365-filtering-correlation-id: 77175695-3f0d-414e-0336-08dcbde2ea1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nZScMzfgjCix0ZI90VpbuMmesMzXELabbf/ch7OPVtGuTk+yCDsdVb422JNy?=
 =?us-ascii?Q?GRDiQF3AtlFlqS5bUpYCRsjBjrqQsiF2ULlvCfZmIQ4k2aAYEMElvoVNqUOm?=
 =?us-ascii?Q?y2fwb+rWaVnL1gJQQcuYIb3GpRxSKJTMClBXZnHCX4MCibvdNou3mPBvm6hZ?=
 =?us-ascii?Q?Y8DgGnNz7lK5NdeSsTNt4/BtztVBZgQrc91JktRpBrbhh7XZr+Mcoj1SYvwH?=
 =?us-ascii?Q?tey9nnegFSmiQLdvEi4S+Ve2V5+lKkgCd1TuACw6ZJrSwWvKs1XMTiYNWBsK?=
 =?us-ascii?Q?4lCkaY8QpncVPazs+RgPS9R5i4ybxd8qiHX1tCc0iRpBrq9RzPcMY5LaBtaE?=
 =?us-ascii?Q?HPioDQeGlvcI0AO1o2vOnyt6yWu9I4a3gcXNLCb+p9sY9RicVzPzqXfsx0wZ?=
 =?us-ascii?Q?aNdhYGVTFwIKUt8smAjE0ven2H4fLazzIHsB+4Q7ie/AnHd+YrSu6EeCUGms?=
 =?us-ascii?Q?3JfI2nshVGfllWtS4psEAyOEhQAPCIqXPAhosCRY+V8hBXF9p2y/c7q8fl1z?=
 =?us-ascii?Q?+e1WQM3A85dDVTLmtcMYcPC5uF9p7b7mYuf30oQc2ItVUgJRGkwu8vI4olEc?=
 =?us-ascii?Q?J5Qxv4wBCqa5MAziv3FiYqCjeP79u0APrHmjgH1gXNbF3XZn6qklsvlfHsWq?=
 =?us-ascii?Q?hcodh6cEfFhcBtiu+2dmJTJ/HllKK0JrzTSezfTa1sh+sNQlCAiVdJStW5j1?=
 =?us-ascii?Q?o6eRmHZls62HoeR5wdBMNCajhzOLHbwQgRcz5T80hi7i+K4ry/TQeyfDPCsl?=
 =?us-ascii?Q?o0Ox9YmOWzwTj2V1Bvu7CDMDNz6vfqoR5gcpuCM9Zs3ltJJBPzbAeZOrFemL?=
 =?us-ascii?Q?+jLekPLwyc/TzoOdZjakPf2XSvsJxYPCN4Z4OIIPrV51aGojnMCOOHqTMtcx?=
 =?us-ascii?Q?zOZsDvAkej/eU6HUHe0aerbOZU7mhfFjjN8sp32E3nwTVRFvleUHD8l//xEB?=
 =?us-ascii?Q?QLKXIk/EmEgpWLNomsj89Y/DRzzeHCdFnJzG0pxVZU3lH3kbDQMOcAf3JJka?=
 =?us-ascii?Q?lh0MG6LidS/MjuRpewcGQwo+KXV09NF4t4/uRP1k7d4AgrBj2iJ4qUJwqXEc?=
 =?us-ascii?Q?tySbupSX9beqfEcnYYFhG3KjTLBsIZzqWFtGRCt7TCrhuvJv12Fcq5dDWxRM?=
 =?us-ascii?Q?aOfiEZmOo7H9iziNXipcjA2rsiwSvhLUHsHuAFGmCDZLw9PhJuJXY55ulQIF?=
 =?us-ascii?Q?1xk+31j1Kp/DakcSJHI+xDLb++5ChRUHhYwv6iwl0QwHqq0xGJBGiHbR89qM?=
 =?us-ascii?Q?EVFlm/o7VEDBiw2o2C7wnzgM2tj60zswLCZywwy0pQsNu4JYw3GENGW19zjh?=
 =?us-ascii?Q?Lpb/baiOL/C+sBr2QEWmLFGVuAzMik3zLeWsjaApLYyJA3wdE4x6w7z9+mz0?=
 =?us-ascii?Q?kNfkA7iBw4loOdEMaLXf850Mn+foxAArh1E7FQMESRF6rvRT+A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jxHckoU4L5pTWdM2x7E9CEwd/qFEVc2gbEsDlPUKV2CCMi+7GHSujJ3Ema+w?=
 =?us-ascii?Q?/0MzLVMyv63U1RrUNoj8hTJWCRN6Lzxv8TLQpRBRHeSxAbuI3WmPSU5QJBLk?=
 =?us-ascii?Q?Wl+rNpOJRBknm9WTNlUDrI6ChfzTqvSEKZRLnKInzsRUdvfTNefnLzwVCpG4?=
 =?us-ascii?Q?OZpSXs9w/Jg67TkISh/E9Ur6WC9S/xdsgCrKZxw4eBW9Aa4VVqHj11WS68rB?=
 =?us-ascii?Q?auggvVqOZJmOgJM3+Q4T9B6Z4puN8vRV2Y9pOcLrTrsbvqpinB3ifJt/1G1P?=
 =?us-ascii?Q?caSFVK0XRHZgjdK9op7tc9Qt1rcM9y/hJ3rAQEktsQ6IlOlNZPOlzKxe+aZK?=
 =?us-ascii?Q?1UD6rR6QIUOpk+ph9VnGeGlMB2L6fj5Moal/zmIL9YZEjvPSExhegPsme/Nq?=
 =?us-ascii?Q?+ja58pi6S2U3crauKxpV62xq/WiQ4ssFH+RIhT9y/YRma+jsfv6KogrgBIJl?=
 =?us-ascii?Q?2Jp43IxmbP7rLNLN7VLc7fTpYsYAZm7OoiEQrwRnu996saqkSui+zyvD9aAM?=
 =?us-ascii?Q?rtB1kG2bjO68OMePEPRxQ/lmhFH85UNo6tGF2cTEzTCdgBpOTB60g+cgEYrp?=
 =?us-ascii?Q?A37FpqGLyq09lnjcgcm/6znhp4D00D5Kx+aGTwNbSkuKn6686+QXDkTI607A?=
 =?us-ascii?Q?qA2Iz40bv+ED2q918ozwHyA02It4mQFbagE2mhM4zXUDJGexP77+0aEXazzJ?=
 =?us-ascii?Q?yp8bSBiWZy9EYrYwfrni9D3Cf8qsP5DtvfKR17q18cJvJ6WqHv0EscpaIBjO?=
 =?us-ascii?Q?t3kCao2PXsTMouGtk865c3pq0Xmdhsn3gL/U4Jdy5Ovf2/fsdZgkKO3Oc/ju?=
 =?us-ascii?Q?dMsosSgmrMU3PLmXp3OMmIBuHGQlJi215UH3rXar+L7R1xqY9j9I9PFrs6oh?=
 =?us-ascii?Q?Mags9enq7mh8u53dI0rn6t8NyB0y1XfT0z9TZDtAsqlyepf1Cphzsya+F0MR?=
 =?us-ascii?Q?W4XE3sw+8NtU4ap3Fz0fCRtpXnuHZwISyFLMNUIKCNSwUMOG0tdnoU8dAEng?=
 =?us-ascii?Q?s6+UmFIRbbJrrJf0+Pc8OYeue/WcVW2qAlTCHV+J3kvh2RY/vH+6DQmLdHPP?=
 =?us-ascii?Q?Gqi7l9i0vu3udKMZVQqfVVeJE4kZlY/zZyqTKJfm5DjM4jmvGJeHaBxVREJ4?=
 =?us-ascii?Q?gUXZpOTpWRRMAXBiC7qNvryyTGMrt6WW1qa0qS0mz/2ilmMHV90AkXwXGMX5?=
 =?us-ascii?Q?J1LQ4MuFMpHYduvawYHT7wzXDioekMMahFrr44nvYDg9z9wNTj303Y4MZDjP?=
 =?us-ascii?Q?BFwoaN/s7ZcQS4DA5sHo5j/Cib0yL8SF1OftdqvP5naUFUtEFplUSWOT8O/9?=
 =?us-ascii?Q?1ESFh1w7eRH29IArR0KH836i6u9wYqg8w9Fpjvv3GtqNkebCmGa+HmjgplIB?=
 =?us-ascii?Q?MWxfuZR7Y6edd4k6KnluEUSEGasMhgI2VCq7z5OL2WVy/iVkBuahL6Bb9zg0?=
 =?us-ascii?Q?l/jnKifdlO+X4dcY7lr//H54f4MpS90JbQS30F+gGcPWkA52RxRlNewGxoyq?=
 =?us-ascii?Q?ROeWmfns/sSCeE0oBM94tLaGCQKbvOyXT01paZIZ42wk2kTpgCV8SGwlw69+?=
 =?us-ascii?Q?gV7C1WceGajYDkrtShl79UBVvUvAZ3P9+uIwR42f?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77175695-3f0d-414e-0336-08dcbde2ea1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 11:02:26.7335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qljC1V2K0gHe8dwBWF7LS6emDQ0DnKQMdlSbxkUFhs0xaM4jU0xeiwzjGtNTJkPvePwGA7ILcTue51ZsLghzYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9953

Hi Sascha,

Thanks for the detail review.
Please find the comments in-line.

In our last one to one discussion, there is a specific input to have a comm=
on function "ele_msg_send_rcv( prv, tx_msg, rx_msg)" for:
- Userspace IOCTL
- Kernel message exchange.

As discussed, will try to get back to you with my analysis over it.

Thanks.
Pankaj

> -----Original Message-----
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Friday, August 9, 2024 12:40 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;=20
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley=20
> <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Pengutronix=20
> Kernel Team <kernel@pengutronix.de>; Fabio Estevam=20
> <festevam@gmail.com>; Rob Herring <robh+dt@kernel.org>; linux-=20
> doc@vger.kernel.org; linux-kernel@vger.kernel.org;=20
> devicetree@vger.kernel.org; imx@lists.linux.dev; linux-arm-=20
> kernel@lists.infradead.org
> Subject: Re: [EXT] Re: [PATCH v6 5/5] firmware: imx: adds miscdev
>=20
> Caution: This is an external email. Please take care when clicking=20
> links or opening attachments. When in doubt, report the message using=20
> the 'Report this email' button
>=20
>=20
> On Thu, Aug 08, 2024 at 10:49:33AM +0000, Pankaj Gupta wrote:
> > > > +     if (tx_msg->header.tag !=3D priv->cmd_tag) {
> > > > +             err =3D -EINVAL;
> > > > +             goto exit;
> > > > +     }
> > > > +
> > > > +     guard(mutex)(&priv->se_if_cmd_lock);
> > > > +     priv->waiting_rsp_dev =3D dev_ctx;
> > > > +     dev_ctx->temp_resp_size =3D cmd_snd_rcv_rsp_info.rx_buf_sz;
> > > > +
> > > > +     /* Device Context that is assigned to be a
> > > > +      * FW's command receiver, has pre-allocated buffer.
> > > > +      */
> > > > +     if (dev_ctx !=3D priv->cmd_receiver_dev)
> > > > +             dev_ctx->temp_resp =3D rx_msg;
> > > > +
> > > > +     err =3D ele_miscdev_msg_send(dev_ctx,
> > > > +                                tx_msg,
> > > > +                                cmd_snd_rcv_rsp_info.tx_buf_sz);
> > > > +     if (err < 0)
> > > > +             goto exit;
> > > > +
> > > > +     cmd_snd_rcv_rsp_info.tx_buf_sz =3D err;
> > > > +
> > > > +     err =3D ele_miscdev_msg_rcv(dev_ctx,
> > > > +                               cmd_snd_rcv_rsp_info.rx_buf,
> > > > +                               cmd_snd_rcv_rsp_info.rx_buf_sz);
> > >
> > > Ok, here you now have serialized sending and receiving messages,
> > >
> > > With this you no longer need priv->waiting_rsp_dev,=20
> > > dev_ctx->temp_resp and dev_ctx->temp_resp_size. Drop these for=20
> > > further
> cleanup.
> >
> > It is very much needed.
> > - priv->waiting_rsp_dev, help identify in the callback function that:
> >       - the message is targeted for dev_ctx(user space) or dev(kernel s=
pace).
> >       - the message is targeted for for which dev_ctx.
> > - dev_ctx->temp_resp, this buffer pointer is needed, to receive the=20
> > message
> received in call back.
> > - dev_ctx->temp_resp_size, is needed to compare the size of=20
> > in-coming
> message.
> >
> > All the three are needed in callback function.
>=20
> I think you should throw away ele_miscdev_msg_send() and
> ele_miscdev_msg_rcv() and instead use ele_msg_send_rcv() instead.
>=20

Both the API(s):  ele_miscdev_msg_send() & ele_miscdev_msg_rcv()are needed.
- fops_read API, calls the ele_miscdev_msg_send(), &
- fops_write API, calls the ele_miscdev_msg_rcv()

> This driver contains a whole lot of unneeded complexity up to the=20
> point where it's not clear what this driver is actually trying to archiev=
e.
>=20
> Please let's do a step back and try to find out the actual usecases.
>=20
> What I have found out so far is:
>=20
> 1) We can send one message to the ELE and each message is expected to get
>    one response from the ELE.

For each message,  it is not as simple as to get one response, without any =
other message exchange.
Why?
- In order to deliver the response to that message, FW could be exchanging =
multiple message with its slave called NVM-daemon running at Userspace.
- Once enough information is collected from its slave, to prepare the respo=
nse. It will send the message response.

> 2) We are not allowed to send another message to the ELE while there is a
>    message in flight that hasn't got a response.

Here "We" means Userspace application sending the command message on a part=
icular MU.

In the case where ELE can receive message over two MU(s), another userspace=
 application can send another command message, via different MU.

Hence there can be two command message in flight at a time, via two differe=
nt MU(s).

> 3) Both Kernel and userspace shall be able to send commands and receive
>    its responses.
Yes.

> 4) The ELE is able to send a command itself. Is this true?
No, rather ELE can send command to its slave, running as a NVM-daemon at us=
erspace.

> Does this command need a response?=20
Yes.

> Can we continue sending commands to the ELE
>    while the ELE waits for the response to the command?

No. "We" (Application that acts as the command sender, over one MU), the mu=
tex-command-lock is taken by the first command. Hence if "We" tries to send=
 the second command, the lock is not freed to be acquired.

At this state, ELE can send command to its slave and can wait for the respo=
nse from its slave.
After collecting information from its slave, ELE will prepare the response =
to the command sent by "We", to send the response.
After the response is received by "We", the mutex-command-lock is freed.

>=20
>=20
> 1) and 2) is covered by ele_msg_send_rcv(). 3) is covered by
> ele_msg_send_rcv() as well, it can be called directly by kernel code=20
> or via an ioctl from userspace.
>=20
> 4) is the most unclear point for me, but 1) 2) and 3) seems straight=20
> forward and should be solvable with significantly reduced code size.
>=20
> Am I missing any features that you need as well?

Yes.  As explained above with each bullet. There is a ELE's slave-daemon ru=
nning at the userspace, with which ELE exchange messages.
Now, it must be clear why?
	Both the API(s):  ele_miscdev_msg_send() & ele_miscdev_msg_rcv()are needed=
.
>=20
>=20
> >
> > >
> > > > +}
> > > > +
> > > > +static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
> > > > +                             u64 arg) {
> > > > +     struct se_if_priv *priv =3D dev_get_drvdata(dev_ctx->dev);
> > > > +     struct se_if_node_info *if_node_info;
> > > > +     struct se_ioctl_get_if_info info;
> > > > +     int err =3D 0;
> > > > +
> > > > +     if_node_info =3D (struct se_if_node_info *)priv->info;
> > > > +
> > > > +     info.se_if_id =3D if_node_info->se_if_id;
> > > > +     info.interrupt_idx =3D 0;
> > > > +     info.tz =3D 0;
> > > > +     info.did =3D if_node_info->se_if_did;
> > > > +     info.cmd_tag =3D if_node_info->cmd_tag;
> > > > +     info.rsp_tag =3D if_node_info->rsp_tag;
> > > > +     info.success_tag =3D if_node_info->success_tag;
> > > > +     info.base_api_ver =3D if_node_info->base_api_ver;
> > > > +     info.fw_api_ver =3D if_node_info->fw_api_ver;
> > >
> > > This really shouldn't be here. You pass cmd_tag and rsp_tag to=20
> > > userspace just to guide userspace how to construct a message.
> > >
> > > This shows that the messages should be constructed in the Kernel=20
> > > rather than in userspace. Just pass the message content from=20
> > > userspace to the kernel and let the kernel build the message on=20
> > > the sender
> side.
> >
> > This will help collecting user-space application logs, with correct tag=
s.
> > This is already used by the customers, for debug.
>=20
> I don't bother that you provide this information to userspace. My=20
> point is that it shouldn't be needed by userspace to assemble the=20
> packets that are sent back to the kernel.
>=20
> Really the packet encapsulation should be done in the kernel and=20
> userspace shouldn't be bothered with it.
Packet encapsulation cannot be removed from the userspace.

Only, userspace knows that the current API, that is sent, belongs to which =
set of API(s):
- Set of API(s) supported by FW code.
- Set of API(s) supported by ROM Code.

Only thing that can be saved is the encapsulating command tag for "We" and =
response tag for ELE's slave.

>=20
> >
> > >
> > > > +/* IOCTL entry point of a character device */ static long=20
> > > > +se_ioctl(struct file *fp, unsigned int cmd, unsigned long arg) {
> > > > +     struct se_if_device_ctx *dev_ctx =3D container_of(fp->private=
_data,
> > > > +                                                     struct se_if_=
device_ctx,
> > > > +                                                     miscdev);
> > > > +     struct se_if_priv *se_if_priv =3D dev_ctx->priv;
> > > > +     int err =3D -EINVAL;
> > > > +
> > > > +     /* Prevent race during change of device context */
> > > > +     if (down_interruptible(&dev_ctx->fops_lock))
> > > > +             return -EBUSY;
> > > > +
> > > > +     switch (cmd) {
> > > > +     case SE_IOCTL_ENABLE_CMD_RCV:
> > > > +             if (!se_if_priv->cmd_receiver_dev) {
> > > > +                     err =3D 0;
> > > > +                     se_if_priv->cmd_receiver_dev =3D dev_ctx;
> > > > +                     dev_ctx->temp_resp =3D=20
> > > > + kzalloc(MAX_NVM_MSG_LEN,
> > > GFP_KERNEL);
> > > > +                     if (!dev_ctx->temp_resp)
> > > > +                             err =3D -ENOMEM;
> > > > +             }
> > >
> > > cmd_receiver_dev isn't locked by anything, still it can be=20
> > > accessed by different userspace processes.
> >
> > It is not accessed by different Userspace processes. It is a slave to F=
W.
> > FW interacts with it when FW receive a command to do any action,=20
> > from
> userspace.
> > Hence, it will be executed under command-lock.
>=20
> When two userspace programs have a device instance open, then nothing=20
> prevents them from calling this ioctl at the same time. You do a
>=20
>         if (!se_if_priv->cmd_receiver_dev)
>                 se_if_priv->cmd_receiver_dev =3D dev_ctx;
>=20
> which is executed by two threads simultaneously. It's one of the most=20
> classic scenarios that need locking.

This IOCTL is not to be called by user-application.
It is to be called by one application(called ELE's Slave NVM-Daemon) implem=
ented as part of secure-enclave library code-base.
This case will never be occurring.

I will update the SE-DEV text file against this ioctl.

>=20
> Sascha
>=20
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.
> pengutronix.de%2F&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7Ca46d
> d4dd6a0542c2848608dcb842477e%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C638587842010417199%7CUnknown%7CTWFpbGZsb3d8
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C0%7C%7C%7C&sdata=3DmslWc%2F%2Bp4PKtth3htkmdAJ0xHFh5MlCkcj
> %2FKNw7Tg5U%3D&reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|


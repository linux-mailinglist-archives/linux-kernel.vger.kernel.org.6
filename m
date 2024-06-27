Return-Path: <linux-kernel+bounces-231739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFB6919D1E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 04:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75541C2181B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 02:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0362279F0;
	Thu, 27 Jun 2024 02:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rfC10Slm"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2066.outbound.protection.outlook.com [40.107.241.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BB35223;
	Thu, 27 Jun 2024 02:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719453930; cv=fail; b=giL4BDsJN1Fp5gESUBHXGGalCqWB1eC55PFC9tNQpcJO2nZ3kiw+nDgaqYpXNtFG6Mp+Z9042qBf//EzSfEN5rvqS0OxzT7Xt7t/+U2uxIKH+fggBPgGnSKCoMYNXiS9dx4bIQWt6WxHO5rDugUnH8rQ8TXc58TZTTk5Nhh0+IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719453930; c=relaxed/simple;
	bh=6l09U0epJfH+OvKUjRlb3+XnpZmXC0De99hgv6dFGUc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K1PSi8chuN+Wu7xaNjcEOLD+ODA2q9fvb9/rNZNrQIWkhD6H4BOfKg1sGhPIKiIp03VMgB+b684s0xxnur8LXAfCyqgsBXIdZSNvW/1YGuZImZqc9rAZu2kxxEYllyUS24+qh8pmxMO3dTqtQQnpZpKamvjr4XA4xPo64If1f3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rfC10Slm; arc=fail smtp.client-ip=40.107.241.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmgpMDKIZNFAcjdVx46ZRRBdrshAzUiS1XDQBFkblnzlCNp3K0NR7dD6ON9BsF5OzueDYrAmhsaa7QmHW5dMV1lsTnHdrDDxQ/qbOWa8uIUH2OOMXOlt+EVys/Kgzj/DsmhO4XByCp2rYNUbSz17ixp3g/LQAoCKWMt+xBV1ssysYKVCvmMse2+YmyEeP565duWLQQ+2JM2vEpsCjoTaoFfVPmO53CTANv8a3pm1ImnEEbp41ow9vGZV/cgmuKpIm5tZ6FffJbG3+ft27/6NFBI5B+S2fAHMwuX5fzd1I2SqiD3yS0XP7hU8CKWzUN4FGT0hXqD3hSFWdSgRFtWQUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6l09U0epJfH+OvKUjRlb3+XnpZmXC0De99hgv6dFGUc=;
 b=ahzEFfNhpBWKPVhR+CsPsQc9Xxz2YsV0MjPvbaohy33DssHy0UAGfWl2F50vliKlKviNbPRdL/UV7oPAR/nPv3qX397PI5ahVaGTcRN+vME+RtzIIpEGltu1oZOVwf6VoC2okHyRNhSTfk18z7vcuKOCF8GOF/QwSme05kmsmf1xGItXHaku2NEbB7fna0Cd7qksNitlvtaJ9S/oxZFAXJuI55truOws9w6jONZTUFOsSSyZ77MSm6k6oPvMNxaqNNw8ha0Ma9SaDP8GJ03xNyODVTOypXZOzU/XYVN5H+oFahYdslKtqBkF4HS8qv4BbQ+xLr5IpRRSK4MDG8I3nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6l09U0epJfH+OvKUjRlb3+XnpZmXC0De99hgv6dFGUc=;
 b=rfC10SlmWItBKPV4/naaRgC/yREL5Hh5BJlBmWllxbkyjCgGmFPY0y7vKvvWaF3CvRkqy5TCm4IVX8+vfeZTF19rZtcZyV91Do1XKbOK21k3ghaUDdOjMiASOHhDqFnVr8PY5Z+AMFvZC0agWFSGHA5DD7vcDgC4+eDN9E+FKb4=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PR3PR04MB7420.eurprd04.prod.outlook.com (2603:10a6:102:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 02:05:25 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 02:05:24 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] firmware: arm_scmi: create scmi devices for protocols
 that not have of_node
Thread-Topic: [PATCH 0/2] firmware: arm_scmi: create scmi devices for
 protocols that not have of_node
Thread-Index: AQHax5UBcF+q3A99YkaqiEgHA2XENrHZ4faAgAD7fNA=
Date: Thu, 27 Jun 2024 02:05:24 +0000
Message-ID:
 <AM6PR04MB594123EFC17B31CE469503B688D72@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240626-scmi-driver-v1-0-f16d777e004a@nxp.com>
 <Znv1p3FDiPSUNmBM@pluto>
In-Reply-To: <Znv1p3FDiPSUNmBM@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|PR3PR04MB7420:EE_
x-ms-office365-filtering-correlation-id: 93f8261a-8587-48a5-bd96-08dc964d9ba5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NI0VU5VMIhY1ytt25XrFhFpo44Re8MvWtZrHpReFgMZc7DuqT9bhh+APcM5E?=
 =?us-ascii?Q?uYScHv1Zxg6J3yjrHH/nIp/wEU8tfSEZpOC64bOGEumCp0O11QHhqbYZa2XB?=
 =?us-ascii?Q?qmKATNwxTDwd9L4y61LCBkF5LdyOvePmCx6DEwWqnr842Fc+cm28YaV2O/Un?=
 =?us-ascii?Q?N052imOHkAESbC8XRfnKxmuznW8WLKd5US9gaVpyWs4bfJIoxpiUhrXSVU7E?=
 =?us-ascii?Q?O8UjEQ5tXszjEWCSibFmItPND90uUyqoenAXktVS9WaohSe2SdUO8soyJ0ub?=
 =?us-ascii?Q?9S5T7hQzTwK1BETW3LbM9i8NatNCkNI/cjjmW9WnSu5dYJBXHbgvoiIdlxu/?=
 =?us-ascii?Q?Y89+XTyTQWRCJ0gVjDraw0tvJNBBu2fSqAJSB9pajlW/5pYR+vVvIsw0ENCD?=
 =?us-ascii?Q?drUuVwcsYzcECLFA1MqP20Smz1HLTbTJ8RAto4eY6o4tSPTpGU0z2tXRJFCd?=
 =?us-ascii?Q?giSkkRnv9ZkAW9GeL5L3equWv1LUay/tSsdHkJr0MupW+wxtWxiVvCj970BJ?=
 =?us-ascii?Q?9Zn/dpSyeDMmaHgjCjBel2wMAQs19q0sGe8fIzF6ejxGB0Xd/HFt94jXT5Qw?=
 =?us-ascii?Q?kAmMmcbhG10jAQaQsZlmvx18CuJ8Q7dXcYqf5iMLjQAr7BLiTHI+66xyWKY/?=
 =?us-ascii?Q?cnUy/8N5fT67iysfwmdrjq8QXe5ceE3RvxcXxR3yc7+ec9FlKywzo4ygiz5O?=
 =?us-ascii?Q?ojR+zLO4ArLju1loeAozd7mClsAGV21SDXP5f2g63ad3u1NE22gPj/QGcdID?=
 =?us-ascii?Q?3qQzi58dBqs0CEk3OBq1u7KR/8AU0eqiYR/qHuzMw+mLDFxw4/qBCOEk6Iw2?=
 =?us-ascii?Q?aX1Lgo8tKIlry8zOtmdKCbSnsEhJuJ7QmBQYEHkjpPqtoEFOxrUzkgoeyOJR?=
 =?us-ascii?Q?5TPsue2IKPzX3Q/0ZW5k6ddFazdLca01bpHkTOIjJSPLAwnPNz7izc8YB7kM?=
 =?us-ascii?Q?UBuyySd1hf61FH9dNVSn9hqPYy1Y/OVMjyD/oHHgPVm9iUr394kXQ7uJ4JXh?=
 =?us-ascii?Q?r7T8+USHBC+3wI7DRAanRwyJkraZ5ZJp8aBcCMkDb5JCGOoSal5R5sFRkgGV?=
 =?us-ascii?Q?BwQCRrJ/gumsXLBKIAXlw/Ng6JCxIpVnX4YdlsilfBuLgJ6o/y2c9g4foe/S?=
 =?us-ascii?Q?Y9tOvHOvuDiLhLAoobo4hE6xNqLmy1t+0QyAztGxQRPqMhFVV1UQNDv5SKgI?=
 =?us-ascii?Q?iwd93mdWcYcrqEzU92h16LDAJ0fYYTO7a13XzwOxwuQU/cFhunVwA7YUa0O+?=
 =?us-ascii?Q?dWSljIOiX23Oxbha5lyW+hpuuqH+1IiSQp9tVMSNHhhCywRQfW/yc6cO9D1J?=
 =?us-ascii?Q?vs9fnVo/q8mBK/k78f9/37f1iev2u5U+hxO6XTtqnPRm4bVsmsHXnLgPyofu?=
 =?us-ascii?Q?aTTkh9zSjzQ4jmQE9bmhBozPQf7mgv/cMDxza8DKIhsppisHLw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qCbRqboID3ezfpoDp9ET3Ub0IUg61A5tbdWKje6aOIubWoAHnrQ2YXVqDkOI?=
 =?us-ascii?Q?FBqOF7zHkHAft0lF2RlUSLojY463bRbuj/DBX4DTRweFxG8+GK06SquhKi+9?=
 =?us-ascii?Q?mRxz7BYJ9bbX4GR/Ah2PZD55rHy7EWQxO9JKOFR+jLTbkmEpkoQhAwAALa/G?=
 =?us-ascii?Q?S+BDa7bqNDfQS+qCJaRLqPrwNohgPA9xp6P8g14ZK+e2y28T9exzotGZgcCv?=
 =?us-ascii?Q?wenNdTqnuiZQx66h/gmHzIVbcZU18LP0PitdLwy9ZDTzb8LuKUGvlUGz5kCw?=
 =?us-ascii?Q?fYbacCeLPt9QqNBh9cOh7MaVue5i1RDgVRNMPfmE9HOXV3wcja7rbbKd+MJC?=
 =?us-ascii?Q?7Dd21DCF8cVTp7vmuTHPQxn7ilt4qKM23U86ZRtU36/QnWbZcW1AGHQmY22a?=
 =?us-ascii?Q?kaF52VVwnHa9sMHQIwsn3ZXmIxGaAh6HvzVbSRTcHJaOPya0qVcV0zJ4LP6o?=
 =?us-ascii?Q?vuWQRSXII655EEKh80SMOMoK9b7wpxUWaSm0WReL7fNqvrZB+iDg0lEF/asb?=
 =?us-ascii?Q?SWv8pWiU/QabkrUlj1FD9ZWWCynN1afbcAz6nH6Ud9ii//da84DngIxDufcc?=
 =?us-ascii?Q?TQ0J/eWtyylON1pO6Va4N4USGJl3WWu4qHT0a9klfrhDpHSwffbxHzqFkszK?=
 =?us-ascii?Q?riPSZ3QJ0BL0oFe+UZ36buwreaaTehmIwTk0GINB9QVBrI1+dr6NSTejI79d?=
 =?us-ascii?Q?qDWVFpO5jx+FpupVVvDrQtVjK4b/XJ7X2cn0hEQpXvyQxF1bNHcGG08cDkNp?=
 =?us-ascii?Q?2EJwgNzRK+iFMszATUGD9Fvf610zX3tI3eyjx3m22CxWb5sdEDxNkVJVRyM1?=
 =?us-ascii?Q?fKuxMjqt8flMXXsjG7N1H6CzYd22njpKHYn7D8AVZ2ZXZlCgtWjaf2W3AnUX?=
 =?us-ascii?Q?ebVtSQ/I1ozUmmK+dj4PLEPctsKskyg9BaaKEbOzPLhzkQ8Xhk/jXiUBvdJ8?=
 =?us-ascii?Q?l0VmKQd4Zl5DZ8drt2r5Knf9GjHZrmy5i1bGjkACO8OpMdjsxOOFmu7lP0x6?=
 =?us-ascii?Q?G7fUwtQDkjUC0A4VewoBx1kB79qaugtT9/T4bPo0U0zQLJxqc3FYwItC+Mpw?=
 =?us-ascii?Q?vyTNwVCjTKFxJ26OtmXw0+7rCepBZMwNbmBUqMYB4W6E11M1ocwFpNWL7XjT?=
 =?us-ascii?Q?w+SlPW1nCUuvgkfdosjAPN+QMZh4eldsMf/+T9BbLHUaz5LnjeKokWc0lMag?=
 =?us-ascii?Q?EuW3sf+3UPI7md+Hn+vP0kBKsLLh8v6JPVQX1nA5mp0mJo8gkNTKQOkNPWCd?=
 =?us-ascii?Q?TZSQPy9Q2V6V+N02Slr4yphe155g7HTLT/YCRam32vYcN2gBFFtD/XHVZWwv?=
 =?us-ascii?Q?VFqNZY6hjQUBTHhw0SlALzUDiBSeD3mbsaj1hfwzNOtnoxX4dcDh3sGUBgoh?=
 =?us-ascii?Q?I5UX9sdfBGgQamtEi8W17UtsEu0nuAAFOG+4cf8dQZnjktSLs+3Jg4XtCGIW?=
 =?us-ascii?Q?QDs109My3gXPKG/8aDdiB1z2Nrel8IgN9kLquPbmv+W+axJKzVki1i7s+ZCp?=
 =?us-ascii?Q?n3Yd0X9u5z5KSq2wsKXBUvEmtUx6qqnekU8eqlG3lFOaqE4JaS5BATmyWvoH?=
 =?us-ascii?Q?Gn1mRdvwLIBshsbKNIQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f8261a-8587-48a5-bd96-08dc964d9ba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 02:05:24.7143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A776CjTrd2c6vbkxnoVs6uTlHMDlnUQb7CAShZG5hMvFVWs20PFDq4yhsTRACL6Fe/vWmm7rGOmw9tg+28OWkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7420

> Subject: Re: [PATCH 0/2] firmware: arm_scmi: create scmi devices for
> protocols that not have of_node
>=20
> On Wed, Jun 26, 2024 at 02:58:38PM +0800, Peng Fan (OSS) wrote:
> > Per
>=20
> Hi,
>=20

...
> > rved=3D0 If a node has its own channel, the of_node is still needed.
> >
> > i.MX95 SCMI firmware not have dedicated channel for 0x12, and no
> need
> > of_node. This patchset is to support protocol 0x12 without the
> > procotol node in device tree.
> >
>=20
> With this patch you change a bit of the core logic to allow for protocols
> not explicitly described in the DT to be instantiated, and you use a
> static builtin array to list such protocols...so any future change or any
> downstream vendor protocols that want to use this, we will have to
> patch and extend such protocols[] array.

Just recheck this again, we might address with iterate
rdev->id_table->protocol_id, just as scmi_device_create.

Regards,
Peng.

>=20
> Moreover, if anyone DO want to use a per-protocol channel in the
> future on some of these protocols, it will work fine with your solution
> on the code side, BUT you will still have anyway a DT binding check
> error when you try to add that 0x12 node to contain a channel
> description, right ?
> ... because in that case you will have re-added a (supposedly) empty
> protocol node in order to containn the channels definitions and that
> wont be yaml-compliant, am I right ?
>=20
> IOW this solves your issue in the immediate, while adding complexity
> to the core code and changing the core behaviour around protocols,
> but it wont stand any future addition or different usage.
>=20
> For these reasons, I still think that the cleanest solution is to just le=
t
> protocol nodes to exist even if not referenced anywhere from the DT
> (your original patch to add protocol0x12 I think) simply because we
> allow per-protocol channel definitions and so any empty unreferenced
> protocol node could be needed in the future for this reason.
>=20
> In this way we'll also keep treating protocols in an uniform way.
>=20
> Just my opinion, though, I'll settle with what is finally decided anyway.
>=20
> Thank
> Cristian



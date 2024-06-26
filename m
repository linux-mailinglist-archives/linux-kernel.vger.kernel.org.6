Return-Path: <linux-kernel+bounces-230664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A2791802D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9704D286033
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C711802A8;
	Wed, 26 Jun 2024 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qLY64s+Z"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694AC139D04;
	Wed, 26 Jun 2024 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402632; cv=fail; b=DY/M/8G5sisDDV+n0EBaUpYY3H2rtVtukD0v7+/BJb7v6Ju6PtzApj6t2hGITiEcx/3w63f/RMsc9pq19YtnpLoCp+8ghlMWNKGI6gsIGKDlNegpBAJX6OAL7OuMWKdu3TmYGmEcW0Ty0tIL7XVKZmM2NdWnS+rFuRMPo8N+8TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402632; c=relaxed/simple;
	bh=y9ETlnqpDNiHmToMnmkYmfZkQ2+wpqSWcHUd7QeLw8o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oph5EcW7mMTmEedpUwxUP2KlNtJs/93VtwCf75eDaeYiMfu8iMrAbSbtK3i+RKNtEbToHCR2YPX6bXalHhbdD077ZDTBSJf6ia8hhZNuVfK5tQOhct/MrHGEuk8st18Oz+25o1K6jekRoaJGxvtUFBTIGFuM4yVOtcC3mhsdRhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qLY64s+Z; arc=fail smtp.client-ip=40.107.104.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7WmHItSRZIBB3Ysb/gVf/o+SSwR/hUyeg2JyA76Jqint2X2XPhDEQiJWpXVZwk80qdfwYfRM/5mQgmazXbxZdqTwV+NJM+5i8EPpNbbqhjlztJRUyvKrzEtv6YyHOyBxuiaWg9cRiYUcoSJpqK9RW9mDGDbMbyqWwUJkQXKbwiD4bETRuvnTeNcuLz8hbS/IKA3f788JxgpofM0HCAICjwN22XT/0KJQotGFOPBq76HEBQ4sfWqc9gIoSP+SXxtCc5rcSXpRyHVZZCtgy+RW/VeKjOfPxQ8TryqjAtHYMLAQKGwEkYnnSx6qEmHufuechEvV7qqEOEelblrvT338Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9ETlnqpDNiHmToMnmkYmfZkQ2+wpqSWcHUd7QeLw8o=;
 b=dNHWcDEeUPn5up/SbnR4+u6MOkna9PnjNt6DZzhmA1QQFRXYoQSExkdyPr+X7eyi1AAaufX/g2IkhZijcic/0MgBUiqtisDU9kh8F1lcaH0niKjJpduFQgec8ony6n/02lsPd1/mVUFHGPX8Nka+pUxaBEaEX3yjyUQYgEtjEFu8uQ8XsGHhdyvZ9iMLQkOhUt5elSHZ8iXlfiQ7epBU7FpJS2CxXx4LTdzUrXo4bo9OWl8Y7Ghc3BOclDusYoRq6BbtCnrve4TpehjqPys7qiRG9br0JsmLpHlHfRn5qJVMd57h1tAiPDUFvVomc8DH+gPD52UP38egaaLECsHD2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9ETlnqpDNiHmToMnmkYmfZkQ2+wpqSWcHUd7QeLw8o=;
 b=qLY64s+ZFKeBbrAMevKPfzmgCw1Vd20AJD2pu6WDtsK0l84pnNh8PXfrng21J00pZLwOf0So/TZ+Mzgru1RSevAsvQcnZ1MUoafQyzBPrndGn7CMQgI96iuancq04a7q1EKdEM3XZvz5dyu55AAktLiM6wRE4IyW94JsLrVEKWY=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by AS8PR04MB8467.eurprd04.prod.outlook.com (2603:10a6:20b:34a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 11:50:27 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 11:50:27 +0000
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
Thread-Index: AQHax5UBcF+q3A99YkaqiEgHA2XENrHZ4faAgAALgTA=
Date: Wed, 26 Jun 2024 11:50:26 +0000
Message-ID:
 <AM6PR04MB5941549618EEC4A7890D9DF488D62@AM6PR04MB5941.eurprd04.prod.outlook.com>
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
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|AS8PR04MB8467:EE_
x-ms-office365-filtering-correlation-id: 48eb4d44-31b6-4325-3a94-08dc95d62bd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|376012|1800799022|366014|38070700016;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bcF1p2yqKOrQoTQVYAbhk+K80cjl/EZSJWhDEqOfgk+GYDOs3vOYHhCQ5YGE?=
 =?us-ascii?Q?OYqp7b2QxKHyebJY+R2WxGaJ14J2zPzYvK7Mp4Iz0nFd0slJNXhn1siB3kV+?=
 =?us-ascii?Q?S3hXx+ZRNy5ZrrCpFYgIJ8G8mg+iGGQolfC2NXFGGwpQ50uwtpCasVBST/Mi?=
 =?us-ascii?Q?uEuxr2K15Hd2PL7UoFztOnVnIz+GEg4sHKDoR/koUgxl/JIcwBJQFxSP0xDl?=
 =?us-ascii?Q?ce4PAm2EvqFsBNsiUhsuRlLkRwbTdgQlWWpunyMZkRx9bjkf4uNu2Tqwj3o9?=
 =?us-ascii?Q?E+PYaBIljCo3fC0gTQ8pMyObGbIbRNwwUh2PZWcYn5F6UgyhGwuffaZzLeca?=
 =?us-ascii?Q?gvjFc4JN5B5LDVq3dd9tC+Ccffs9I3ki/QvmfvHbGpTfVlxDyUMLs/V54t9o?=
 =?us-ascii?Q?CoxVw3Rb4WCr0G/5Bjb/1EU/uKtqzKvLMb38yB4Uk0jDJaGPbK39DU3Wkneo?=
 =?us-ascii?Q?EmXF56xNv64U+uzK+xqSu6LXO94Y5+yQpDvH7PdGdBkPoIhhtQBRKkbE3DxJ?=
 =?us-ascii?Q?x1puJJbdEG9dB5SOWSnMjPzg620bWDQbtm+6To0yjx6JUzYeqQUJdRxtSWGQ?=
 =?us-ascii?Q?+xEQeD3qnLEY0AVd8nY9tgWyDWN7mnGgzgc64fOX7SZyE/fvwdhvFjtLtBj0?=
 =?us-ascii?Q?tTBD4Rj7qSNmJ/KvpGClnmB7jqt56ekS3MdHn9pDdJhpxv5UdJ4OC5QyiKFn?=
 =?us-ascii?Q?kradEfnD6wlEiVOdPwSwHh1JRv5qLLxJAuW2yDZdDcsC6T1NPKF6d9H3jMyK?=
 =?us-ascii?Q?Og3bH8cuupL+dxzOigvZ+mYNpOSTuQ8Mu4oxNyFoLQM14nOsz12T19fl1Byh?=
 =?us-ascii?Q?dJt0W7HEYpf5MNzmjZW5vb+slp+isbOVwEslTNa4PNZFRqCP6jUEigoiScPf?=
 =?us-ascii?Q?3ks7mmPU9QnsKsM04UDX1i/xpC+Hzt9C0m+9FpFH4jLBEXutFmsndZtBDet0?=
 =?us-ascii?Q?OcqSwqn1bOIA/QEyjkX40+BuacKtd1wyEnLYAIrMqUbxKzDxfHM//Jylxrw1?=
 =?us-ascii?Q?28LmPLdZNFn/yThjwuTF/Ki7KHjJKBV7dr6rPKgbXAM39V6obHtIHgiyx6er?=
 =?us-ascii?Q?RTqeSSaxSeeQ8oenX2ofS5sF3bjtxBVxQVaR6yArJzRyL4WoN4J5N4S7E+/X?=
 =?us-ascii?Q?PbH6v1GerRF8nlTOFppnoPNdsVwJdPLQlkTFCS1sSMl9LePBTfc8PseOEY33?=
 =?us-ascii?Q?8gPZ4zICWNYbtF8KAxs5x5eyHHzTDAVbZiOQZe8sE9v/it84Pc7zvOh/kF5S?=
 =?us-ascii?Q?a9If+OKeMGBP1jIVdYfHvcKyAcxvjUHmcZKvFI9xVYaETcMQG1Z9Kne6qrPi?=
 =?us-ascii?Q?d5penYOBHbk2dMFlirWWu/8e?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(376012)(1800799022)(366014)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?k4wC2buBs0x256cdQplV6MyvHZuXZHZqBSSMieqJYCPS+7VhRMlNevTQePh2?=
 =?us-ascii?Q?d2NnDaK3M9EaNBgI1R1qf/EQmnKQwWsxExYxYnvpN/5nV6uNq7OkPAfSApnu?=
 =?us-ascii?Q?LsuEdXYutpM6jT6JswsAbAz7iRaWiozqIW+uyYW2HklhyvTP0PDQMJRETRnB?=
 =?us-ascii?Q?6xmWwt61LtA4Ii+rqhvuEoVCPcISsVrA2FqB7bZfAta1vZDlu78KA5LXZ84z?=
 =?us-ascii?Q?gGCz4nM7D5pSPt1FMV9opi4o1huwGkKn/hjKZnxr6WP1N5feIlP3LNV0Bgpj?=
 =?us-ascii?Q?+dqQVdYwGUaZe3oOdvcEvgG5AZfffSXUYPICP6m0SQzME3dMNnyHyD3ecv5n?=
 =?us-ascii?Q?iFI7q7ujxcWsbiLZDfHnyKennUU+9biz0Sc+6iBmAsPy7/Vl8u0IxKnlVelA?=
 =?us-ascii?Q?fqG99eYKC9/nTpbRi6mUbFMJuB5X0XFq2zRE2d5amSMZfU3z5Qbnw88tk7gY?=
 =?us-ascii?Q?IFC/KWi8ohBuL6ctMIVuMXzoMuCoKca21Uykz7VAgn9qo2Z6YC0oeJ+A39dt?=
 =?us-ascii?Q?/DSy08CH3SfYrQW69Y3ftG1oj62kCFQ3mkBWm/Mp7PYPOijfYm+2ovGPjs31?=
 =?us-ascii?Q?twX9CMR61aUQAa9S3PrxEhoPAuuBoVzlSbMdU61hB+Mni5iT5ucadRIP0ntC?=
 =?us-ascii?Q?Lu+XZHfSz4s/YbFkyMcST56bfSExiNj/MpJRVpdXH9ROxJzZxtQfQSDBvNMw?=
 =?us-ascii?Q?lt4oVV+GQg/eI0f+jxJ5YGwgGldbFW/BakNviBqnt1oo8Z1Z9Vrw7HLD7TKj?=
 =?us-ascii?Q?Pg9AOwhl3jvTnfDgyMlUGHtvSk+Y6YfS8IqbTTSdD9m5LwBj0ctbNr1SQYYs?=
 =?us-ascii?Q?Go7fWxO5l6FwJe1YfRQkYwlf+kdfbbGay3xw4WonqViSe8uNJBJtkPZ5LP7H?=
 =?us-ascii?Q?/MzlB2WlFTomdbYCnd5tyMhq4M06MI2sSEhWvwXZWzts//axfSDIp7M8xQMB?=
 =?us-ascii?Q?sVp0MJzS8B1x4I14NVWqbTEq+ACZc+3XqlYI2b76FgLts3KUM6YHzJ5EL7QI?=
 =?us-ascii?Q?QzkCkzew8r3BZfcsOSJEs8G1VLIfOzG6/GH2VKlzt/VjlV+6cawBvJM3UZPP?=
 =?us-ascii?Q?OZl8gyDTauiuK2ZvUk1Ot8p5YWc6JTxtXs/H9/HUGpDlAPGoSgDSDjcZU9kw?=
 =?us-ascii?Q?yLrIpSzXrGcxlSdz4BO/ZePlBDb4PijydtcN1V5mq1ymf8VDd6UwF80sqrjx?=
 =?us-ascii?Q?pkPn3TdLdCZMrwzhXVL/l6uN7EZ0gRwtWhhmQBRnECUMiK2NwqOrmMedUu6M?=
 =?us-ascii?Q?8N8lENxljBHPrWDkLLXHws7+oTgOFf6fMGNpT20A7MFAUODTLRM0S76riE6w?=
 =?us-ascii?Q?/1a+SL46bSAEsIwSzwN/XkSIOsuBOg0KsWENbupEYW6bNTdup3k0HE6YG1vg?=
 =?us-ascii?Q?xnfTWnXjqfFnlNAnow37wnF5c82l4Lc1ES85CfYqBTSROOiyU0pfeUSwrlhX?=
 =?us-ascii?Q?cV8rviygcjtG8ACfRQz9l2a73K4A0H53wMH508QvdRWLHBi+p80L0E/k2/wl?=
 =?us-ascii?Q?htVGlPiQpHgbpZAxZiQqizWLVcL3qrM2U6P9W6wcs30eNEjHBNNO6RQryPxE?=
 =?us-ascii?Q?6dFMpZVZ7VmFOhSL5AQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 48eb4d44-31b6-4325-3a94-08dc95d62bd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 11:50:27.0094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wAGmKjnJ4NEI56RiY8sjzwKFNGnRLXXGFeagZ6c4/sGp5tJe/DgxmZs6y/gvjFrrIU1C2IATB+WlaLDxO+EkOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8467

Hi Cristian,

> Subject: Re: [PATCH 0/2] firmware: arm_scmi: create scmi devices for
> protocols that not have of_node
>=20
> On Wed, Jun 26, 2024 at 02:58:38PM +0800, Peng Fan (OSS) wrote:
> > Per
>=20
> Hi,
>=20
> >

...
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
>=20
> Moreover, if anyone DO want to use a per-protocol channel in the
> future on some of these protocols, it will work fine with your solution
> on the code side, BUT you will still have anyway a DT binding check
> error when you try to add that 0x12 node to contain a channel
> description, right ?

Right.

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

You mean this one [1], right?

I could rebase and send out it again.

>=20
> In this way we'll also keep treating protocols in an uniform way.
>=20
> Just my opinion, though, I'll settle with what is finally decided anyway.

From reading the previous discussion as listed in cover letter,
I thought there was an agreement that for non consumers, no per
protocol channel node, we should not add it in device tree.
But indeed binding is needed in case the channel has its own channel.

This patchset could be dropped if Sudeep and you both agree with [1]
=20
[1]
https://lore.kernel.org/all/20240226130243.3820915-1-peng.fan@oss.nxp.com/

Thanks,
Peng.
>=20
> Thank
> Cristian



Return-Path: <linux-kernel+bounces-237122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8967691EBB1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 02:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098E31F22C12
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 00:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C958264D;
	Tue,  2 Jul 2024 00:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NPU/Jsj1"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37917801;
	Tue,  2 Jul 2024 00:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719878662; cv=fail; b=BMs1cLuWn2TBxLqm4NkT6oY1sB870drMxMEAqmYyECiHu0hKOjkcl2ILLU+1JO53hOJyH8LqVH7aHIkbomBNsCXmxFyZoCcc4lXF9rXBCbmZP475hJXrFPsjVa3Y0G5NI/X9jmjRG5KSwr0iFMYriRKfsqR3LFXkBYD0MnxNq+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719878662; c=relaxed/simple;
	bh=/oBSBySmWSwhhutsJM3BRBjvKGXMkcChtVOUkMYrfwA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JpkmsPL+M0o9PtXxKOWWdie7D2bLpmXn//L86izczpF/56uFrvuGDmyNp618q3wcWeirnGBcgCsoKUdlv9lXo8B5THzCL3Jgn+dnDmv5agDSoCd5PmjlzIzyKxwl9Q4GoaAPKOKWFZXSQHSoy1fJQwjUwO/u5BQ4yx0dX1B5baw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NPU/Jsj1; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1UelrS3MhXpsA0qX32HidSzyrwHylH5/MDeRizoCqU/wXsgS/UkpsSxGqzx3DK1Z2t9GJg0DTuCeranwUDUMSSq2iRttkP+BWgFYMay0ogBscEW4pNZOjLKKKrOO+RISVUMb/+3sdKBoF2dMgg8MQ6TbRcMwCNNQFDxEqnkxRBLzP7kwS61yOYcWAXgAvVU/ZRPa73Uyzh8YzVhAeVEBoANfJkNOfkGX0qpXfxMQrg61FVW0PBdeDYRZl+rJ1xU5em+xKY5+6m9IDXsd/+TaTCNVdC8esrQN4XD3159XLzlk93kLsTvKrb8rhdzlM+JcSH+RekKIF17/26lBA9PVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oBSBySmWSwhhutsJM3BRBjvKGXMkcChtVOUkMYrfwA=;
 b=obqmjsga8nHCu6DnQy89OCEKZ76GtkRTkGdJMBOLoh6BHhCpJOjK5H6jqQZR9WSsuMXdDOoeyExseAxNbG7GnU4aRtaSD+h0pHuFS30NSWw7s49UkJofl+/bpTRIcd/WzJe+n9h5ZanK6IGDnVYLJCzXRt8rvGDXf7qywGcRx6UdcwA9vhNTt4vUvDKGBQNKHsdKral1inefUd8d/vUQiEYlMBcMo8spW+0WX7U64MorYL7F91Z5LwRy74yA4kkmfIusaJxFzme75q725gl7+1Z9V9PILlhPXGlfUWCKr3vOYrZjIqpBo/AoF2QCquZX0NzmfMQ43QKeCxVLTKI2uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oBSBySmWSwhhutsJM3BRBjvKGXMkcChtVOUkMYrfwA=;
 b=NPU/Jsj1It+fKpR+2XF6xFOFi6Dr/aMUT0Hq83cnPfDdic7C8jWl7p0nXqyJ/UqDYwNFuTwzba4iUJE/bdJy0k88I883PkRd/bKNZP9zKyTr7z4POVqSbhz1m5QXAWpjuvv32z+gylELOPx4sNvK8fQkrsSaM7h58Fa2IzMl4Ic=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DB9PR04MB8364.eurprd04.prod.outlook.com (2603:10a6:10:24c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Tue, 2 Jul
 2024 00:04:17 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 00:04:17 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>
Subject: RE: [PATCH] firmware: arm_scmi: introduce setup_shmem_iomap
Thread-Topic: [PATCH] firmware: arm_scmi: introduce setup_shmem_iomap
Thread-Index: AQHay2G/TGM5oYtS5ki29tu623x227Hh4Z2AgACuFJA=
Date: Tue, 2 Jul 2024 00:04:17 +0000
Message-ID:
 <AM6PR04MB59419D30E1A5A6E2B8CB2F5D88DC2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240701030143.2327844-1-peng.fan@oss.nxp.com>
 <ZoKxucvEQwNNj6oQ@pluto>
In-Reply-To: <ZoKxucvEQwNNj6oQ@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|DB9PR04MB8364:EE_
x-ms-office365-filtering-correlation-id: fed9f683-357f-47d9-345b-08dc9a2a83e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1dhztbdbX5mkmHQCi5FFvAS9DnkSFCJsw9N6Ww4JiRn+OYUvKoDBgpnZzZA3?=
 =?us-ascii?Q?xDfrDGkJAcYGmY/oz/V3S5Hv+83n0ZZ7sdvKt06ePFz9NgznXIgEIDm8+HHa?=
 =?us-ascii?Q?GWhocuzNxCplSZOgL0vijnVm+y632832/SYWG55z6fdjFhfe5lEvxXdjWcsb?=
 =?us-ascii?Q?0OtFfjJdfTVJJ181hCoVgH8rmWetfMbjynKNtD5iJqTtfNHe/M5Xj1NlYVDm?=
 =?us-ascii?Q?ICgyFuffAVNyyfrakUlTNvU0e8/TAgVoKcQmXMH3F3rNHfZaAvPRrl3ur5Wx?=
 =?us-ascii?Q?sDKkNvDcqk8KpmKuERPBrNYxUIqlXcMeKPj2IVIgrVPjCG933Lkiz4p0gkry?=
 =?us-ascii?Q?0K3OLrI8zxrf0qv25bEqNkgCp4t7OqW12bOF3+pNNC8fYiTPDPJ3H0P4s8YF?=
 =?us-ascii?Q?DbcsAwr+42IsJCy3es5Ahtmq0JPqSKqigxJzihuVa8/+KeSi8h0srlm+MTan?=
 =?us-ascii?Q?gQ4FE0a3f7enZLxObBylOLaNvv9PxPG0+RVmdiBBw1S1Tmazc62jgsaVZf9Z?=
 =?us-ascii?Q?VO4gvWSsyQCPDS5ZupicTDrEOhlCGUzxYAGq3QExGUvBqNJXG0zv+Nqhitfa?=
 =?us-ascii?Q?STwgakzYeeg6zaksA45EBC+rbZXEijRg2BYgRcdY9lOuPKTdsf1I4RkbttGk?=
 =?us-ascii?Q?kPiQILtcch5d7uSzgGvE6iUkzVGqJovtr5+pvCYk4+a2BIMqjY8rsirNIduy?=
 =?us-ascii?Q?PkLI4IqUEj6EdbXrto7qFWzZL3KYmQcWDFyKa/jWqFtTCKqrwtASpoBkMLPn?=
 =?us-ascii?Q?5rJ6yivIPyzkJB3dY+R9RUzN4G9MBVVBkXmvi2HraaklXWax3NRDP48kqTFN?=
 =?us-ascii?Q?fiBdkvCqISpA9jbz6qCnW7/tZZPO2ziEaPvVuCyUwBB/KovJtK2NbvstkOwq?=
 =?us-ascii?Q?Vt5AaJXfvbuDAV/zP0vROxhb7qr+HkMXvrMkjb8v5sort58tAO/J6LhGztkI?=
 =?us-ascii?Q?THkdLZkoT/1icqBAtuJFfxE2WjslHSn329cN6rb2MbGhU6QlrZZEPELCErkQ?=
 =?us-ascii?Q?qjktq7IFJJB42NWZ8BWUwz4Oj6H/1j26UsBHeQ1bSOoQXNhhV0ZuhraDg3/r?=
 =?us-ascii?Q?CF7wUJoXY89YyVslFW/mskjFq9FrRZVbZVza6VI/RBl+MNUpPJyk/57q+NpW?=
 =?us-ascii?Q?hYBzqQ4719nLP+PAXKmUSDyL1FAEsK0YuDOSAL/p8/tRPbMLSZUF4lTuqv/4?=
 =?us-ascii?Q?MNenMWeZlaV6haTiVnJPA1dP9uN/3SjTDxU5voWRaA/DZ3gaYQmpYHXfttRX?=
 =?us-ascii?Q?wqjx1+gKzi2OlSNL8RO4dqkkY4qU4r85JIYfw1ymREgf4BDryAsLthHZFXGo?=
 =?us-ascii?Q?X75Mjq+ZRQv8aYbUs1sYJm2cJsWvUuAZh0Hj4necpA7S7M8v84An1SYauxlq?=
 =?us-ascii?Q?C3brfAFiIkiZwB2BGLt9DEWrOLYNlVgjJUrAdmgxgTFQbCEz2A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?m63y5DZcbJSFEcVd5XDgVxM8PFGi0DkOaXdYk1xzX2ogBPuuyn3sT0ILl9oK?=
 =?us-ascii?Q?32+UihQGxx2bKck+nvYG8Y2MexXZxx95usSl14A/gAyuGvIG87Afj+Stkk8h?=
 =?us-ascii?Q?fA9QTbQVMoR/928MGuNbYgQvDdh0FqtBmE2C0Jfcu2xlpcSzfiDoL2a5cVkb?=
 =?us-ascii?Q?kOupx1SEcLEMwG8Uouf+2KwoBQGGQxrxjXqHOa685envdh8N3SEhA9qjq/qf?=
 =?us-ascii?Q?X1Cd7Y0f9S8T6Lk/7UZenWtnAWqIvdUbQZr0qdAL4k3FRUR8HYjvcHsCwxRG?=
 =?us-ascii?Q?Ahk2C7SXKrXOTqrvTx2jUTxZ0CahrhJiE4+ze2yei/cT4t8NPt8+jnWvWqLI?=
 =?us-ascii?Q?h+9zPMdBToQ98I31lITwOj/lJRUjzI5nUbzueWTm/Fu7Pzm7gXNVHtT+W224?=
 =?us-ascii?Q?M/1TqbILHY3eD1+/d8tCD2PfoYacqNwrJc7O0/C6yuK19J/GChdzEwT1Qrmr?=
 =?us-ascii?Q?2WSPrfcNW5brBCgW8Y1Nhyb6g2mCQF02WNz5UkamPgOaG/56sLNkX0CbXyla?=
 =?us-ascii?Q?JhsMmttikPOXVOMGlKB1M5ZPH7IWfKVO04MGAupBitneaL+f8IqRao7pXXG2?=
 =?us-ascii?Q?deV/IA0j4ZwHpCHtSTOkzrGv4Lr4WNimbrG33kxgEQpKzFb5UAglRGA6D16F?=
 =?us-ascii?Q?PrTKkf4PGQITo6vJzLCMrZg5rguYCOkZBdZLFSAK4rlMFpZUPpC0B6UXZqTX?=
 =?us-ascii?Q?laPYVQ4GTRBWDNYSdtpkGx9FtTmvW0+eYy9o7R2/usuzEII1T1Z4yFcXe30c?=
 =?us-ascii?Q?IyY9DdJWOpeeoFyMzvj3WFe/YZdmTwNTMxLEBLxy6ayg2/bkgnKOY6DduLuP?=
 =?us-ascii?Q?PJyMB1M2M1Ls/bvQsq6MqDJhCk7vmtv0Y0p1S4UxnUENL9mf63d0pClf/yN/?=
 =?us-ascii?Q?NU7tZ1GENJH/Gbsjf3qTJmT12Oel8ERdSYs/s8EdBBqK8QDz9uhcf7K+egeN?=
 =?us-ascii?Q?h8MinxxVGErRWBlO2biy2SP8K512ClyC5nN1oVAq7FTZx0KBiuLubPLxLDCH?=
 =?us-ascii?Q?w7grUtckdWXgMI4OMMFsbuAeYgMR1fW/rQNr+6500WKp9bFIok9PYGf8lIKx?=
 =?us-ascii?Q?ypFQVYEWKKVbMBuQlLF5I20vCwU2h6QSbJNXfJN0qlJz8VZAr9TQ0VgKH/WV?=
 =?us-ascii?Q?XR9P9RIGKpLBwX65Xn1lpdufHmsLwvzlM9cKCoALamNcqGA9m+rLMnai3MZ4?=
 =?us-ascii?Q?wpdy85AhNMysKWbA3cYv1z6r25Op4dRsdtIdS7vndmdQ3rHX6YycHwU/HBDt?=
 =?us-ascii?Q?AE+lgey2hTWSCV0xL1HmLS8M4lRD/fkCcv3u34TgE81JlDMIKlUw2g0XMg5n?=
 =?us-ascii?Q?yItXD3NXQTC5ldg5rTTAwq2SiU1SKov4WBjgW0SD2rR1WptxNw2xStb8Hve/?=
 =?us-ascii?Q?nZcsBSbKsifLJ2P10omT2CHkhYyXF7IofAs+QWMbnrRudTQJpn2b/tuxD8NI?=
 =?us-ascii?Q?X4M3UtrFx3eQoAtVyxh2H9mTvpzvYPy2xR+H+VIUL8SM13x5lDCDuAxWDJA/?=
 =?us-ascii?Q?8pp1yodFiRXAi+K5zM+tsGij3BXDSRr2fW3a5w+MbHMhA6ND85fNxOtQJYJS?=
 =?us-ascii?Q?QQ0q7vA5fDjn4lE2Gr4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fed9f683-357f-47d9-345b-08dc9a2a83e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 00:04:17.1564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 68YjQXDeBgDgIq0dwQ0cno2oeSvrQvcPQpF7P8gPtl9Zw+nJJN4i5KFjIhP9p7KO67hTAmkYfNf9XVO5Tw3LKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8364

> Subject: Re: [PATCH] firmware: arm_scmi: introduce
> setup_shmem_iomap
>=20
> On Mon, Jul 01, 2024 at 11:01:43AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > To get the address of shmem could be generalized by introducing
> > setup_shmem_iomap. Then the duplicated code in mailbox.c and
> optee.c
> > could be dropped.
> >
>=20
> Hi Peng,
>=20
> thanks for doing this cleanup, it is certainly needed.
>=20
> Since I am in the middle of a rework/reshape of the whole SCMI stack
> at the transport layer, I will pick up this patch of yours and integrate =
in
> my transports-rework related series in order to avoid clashes with all of
> my refactoring

No problem, it is good that you include it in your patchset.

Thanks,
Peng.

 ... O_o (hopefully later this week I will post
> something...)
>=20
> Thanks,
> Cristian


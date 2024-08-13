Return-Path: <linux-kernel+bounces-284923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E0C9506E6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197EB1F21894
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CA619CD18;
	Tue, 13 Aug 2024 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="izfhRvhg"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012039.outbound.protection.outlook.com [52.101.66.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8836C199E93;
	Tue, 13 Aug 2024 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723557155; cv=fail; b=H8DSaB/Yna6ZFA5RDggsL98Ylr3/9aqNeyQGjQ15jGw+srqRrv0RFjEs2FxIe5Txg1qW3gijGUpS9NW33CnQm6XE37o6m6LF/XOc5hp0sSQ/Sj8SGKEZWXoHmPyuVB8H5aLElOK04Ni2K44B3A3q0SETiDBCOYLCbZlBcr8+emY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723557155; c=relaxed/simple;
	bh=Imv9OnURB1mJtehaibbQyWaO0CeTtLJEa/YmVwAFVCw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f8FB4PWk8/9pWY3mg2AY7XoRAYf3xZtnXA+jiKwFDp8PaWJwAhrFLRIimPq4LDwgQlcd1R6F4/iqoTxZ5j85gyJDsJ4BAcjko/rHQtFpj2/tP0Z1vrErvzPIwqWc0STRo0kigw+HyUFspyX9tDUOp9Kn552RKF/WWuAl04giBuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=izfhRvhg; arc=fail smtp.client-ip=52.101.66.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InbghBXMXr4aV87+RiHbpkD/Xd4VGcZT66pXcw564+N5x8/5PikTqgYC/g3hseic+rvM30AgB1+RXisJSG4pc2YBiZ8VpT6XFNZTLA56dqhCADoSCLdlLZwPlXBvpb/rfjCRXnDKwZAr2hxT++HLNnFcdC5UAdzzGJLmPB96Dy15+kwUnGpQosg5x3etwl5YaefjGL1ohC3O65zGTgEpCPo6ToRcjd6qR0EjPOHQFoRgy4ebv7yxezdBjqOHcn7i4JPwx98H3UZKhCYxT/rJlVgBtNQ8Z2LYIxGUyrJY7QvhOu5eGinQI+fE283qtZtkkB2CfSLq3Sx0t0WvOTISNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7JoMfF7UYVRzgd5Okgc5QY8fRNLSAANSkZPDJAlqvw=;
 b=NAZ8AlBUdbjzyLi1D0r6Cfu7xuL/tLM28b6ApvKPklvOvFLjP5/Sa3PAHOeug/SNEZ/y/YgXdD7U+1JMAXYga2hDzu4uO8C9DhCrPEEAbQyCjuw13+zfVv5risTR1exxhBPH16SUsRG0mYkpfnR1puUXNIdQXd8EME/k7NiNSk5Hr7mXM5SouPIdbqX4qcYrxlnSC9YU1WWtZA3qpz5frC3gY5IORxo0R9sAIEe6LromBYHMlKRXCLHzimV65J8V/jpjVCeWYt8raKTTCwDpLWdFYMaqb+pWhjIPWwlV2Im07y6lUsd1h+qygUUlG9hjZt+g7BRNpCc6PXID0OEoXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7JoMfF7UYVRzgd5Okgc5QY8fRNLSAANSkZPDJAlqvw=;
 b=izfhRvhgzABzPoGRE/YcDkczUlTrs26mQXGqhx4d4Ea9KaEz+ykKy0nHniXa3dybr9yvQXhrjpbcj5pn9Bnh81Eaq/jUa9Oqc0aGRmG3m9DgjEdabcuRTNBha/6hggH7B7r60vLvrV4YIvIShOyaHX+qfuN5W+3nNclMoMdgULRJ5tGjr5nKfvrV5TgCC2gUnrBeCq5La2FR0qoaDZQ2piyX4mmDbAGnLPXGp4KoZ6gjPMryS61ZijNMcvEiXVNmh+fKbzEwB5Qtzg4+dm76guUGz+vXjkJLs8H3L/aK7S7ixWbfO/1XY3Wc4KITdbg7qKLuMH0+2sv0/5QebFjj6g==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8204.eurprd04.prod.outlook.com (2603:10a6:10:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 13:52:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 13:52:30 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: Dhruva Gole <d-gole@ti.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"saravanak@google.com" <saravanak@google.com>, "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>
Subject: RE: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode for scmi
 cpufreq
Thread-Topic: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode for scmi
 cpufreq
Thread-Index: AQHa4YQqp/DPlb92g0GK3FOKE5oYXbIk+n+AgAAWN+CAADhmgIAAAK7Q
Date: Tue, 13 Aug 2024 13:52:30 +0000
Message-ID:
 <PAXPR04MB8459B2CF515DC89DE98A1B7C88862@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240729070325.2065286-1-peng.fan@oss.nxp.com>
 <20240813085703.zz6ltcxmrrbdgt77@lcpd911>
 <PAXPR04MB84597171A959F40CD9A77C7B88862@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Zrth0Ypog2TXBlxf@pluto>
In-Reply-To: <Zrth0Ypog2TXBlxf@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB9PR04MB8204:EE_
x-ms-office365-filtering-correlation-id: cf6811b6-a42c-499f-7b38-08dcbb9f2ca8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CACpZ9R/A7Vb4DH9iOFrZEVqTRcA9yqSw3JyhCQkR0yd5sB5u0B4cUYIzfBl?=
 =?us-ascii?Q?MK9QP2wkeT1lWYi5+qlQ4UMhwuOA1mCjwbEDZlEOofI+Acw2IyxT/XbXNOSX?=
 =?us-ascii?Q?Ok9ZzdciqWGIfvK/NIxcGXwO6+VLdkpXsh/MR1KJoRTBGxzsUj+Shb+Mzc7e?=
 =?us-ascii?Q?3PG8pECTWnZkG4Da1Shw55zVfAqzg9Jz25a9u7Bch7AqAuNV3YEziWhONeDW?=
 =?us-ascii?Q?AQjhg/c+srV4vWV2tboCOnR7Rl7bZvxSw7vufFUPgUswXpMs43XwXJ9lO+DA?=
 =?us-ascii?Q?L8GvW5Y451kSdYFki4VoTZyRDxwW1t91H12zE0uQI8742nAxVhEEp3mPLtGC?=
 =?us-ascii?Q?llIl/9NESYZ/L1z2e0p8SsG4+9t6Nn1un+IdJWCUG57uFBlvC8ngAhd0W0xd?=
 =?us-ascii?Q?A9/MieXgn0lDU75XsqdhzvADfGN+5wzm8QzUb0LqrFQNMz1e3HEyRJyjM6my?=
 =?us-ascii?Q?SYgeOtyRrFX9kz74FFr+Fc9JBA4A/uhlau/kRIhXWOUjQeBzwr5l8RXrGArq?=
 =?us-ascii?Q?dc6NJ9cbhfG/tDbUuO9lgZK/QwhpU1mQ8mBVoNbCGd1v82RUPVDvrl73usS1?=
 =?us-ascii?Q?JBTP2ur6lE1d1qgN/6y6LwZhiFlWzNwTVRdREiaYGkrXyK8t/DEQ4kw9jABI?=
 =?us-ascii?Q?fHLEsdn5a5+7y9/Nv9rIYQUmL+1F8pbgj6Ew9y/hs+pNnxD+/QeFIlSSlAs5?=
 =?us-ascii?Q?/ZlqwJ3UmK73mBd8rLbJrT1T8GtCxs0e/2F1+Rd8J6twRqLRtLdsyVhtOwxW?=
 =?us-ascii?Q?5NFNavOrndu7YXh14Ks2a6jlUa/hgWFuo1zQKPBjked4750pfqTo9LzTJuJO?=
 =?us-ascii?Q?xx68Hj9b17z+j84V+mUzI2hvm26Ndwim2k2sNS/p31U4jnABQE1O5g/pf6qB?=
 =?us-ascii?Q?mUoSpbg/LRpFjqEvp40BIu+zlOI/Y1+J5VqPsG0EMiMajDK3KaexKKAd4V21?=
 =?us-ascii?Q?RNbLfvxWKRCYmW/NBLyz49/FuO9nLhF1/pZOEhPptkZ2MQ8HeNg/QlYuEghs?=
 =?us-ascii?Q?fjrpJYBn8h/TToJYH2EinM+A/QQU1BhWxgHxIb4P4YjOv70KL80bZzt8YwOU?=
 =?us-ascii?Q?v7rWT6IH2N11W0ratwC251JWKXoibpG/NDgjc1hIRnnrSxsPRNZSg30v+l53?=
 =?us-ascii?Q?67A9BIel67TdT8WoV8cPcLy6HdrwXexHCL5HFXfjvJrq20eLxHIK8K2ryII0?=
 =?us-ascii?Q?pXTNuvE30+oW5rNkEi06GCNclozJpAJGCNTh0mfk89zSsL+gf83wG5gLz6qr?=
 =?us-ascii?Q?VNRN9quaY4T6X8gHaEx/JQNtt7lSEqTiw4k2ufDO8nT6ccx6drYXjSMj7wK9?=
 =?us-ascii?Q?STFBcC+8DARi5Be+Y/rDqkHP0fq8ypKSUW5hUaFlZ5QK/DNgTDq18YGD/APU?=
 =?us-ascii?Q?qGPUrZ5E87SCAezh6ZoqlySuhbqJFEnFrVYXwzAVfrkU2DUgyQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AfClGIKiDCZ6KsKF/CSoaVJDHewKnCRyIw25/lMBR8CNZPEvYhAkT1OSoa30?=
 =?us-ascii?Q?RPCKWMwaPmgzC6TGyr3ibKnib4ftBxVH+4Mj/la1ckBqS1UVX9xW4VQZ7PO7?=
 =?us-ascii?Q?VSXhjk7NaGsetq364JJuah9XVs2CixC8sU/nApjmLW6wRSVwbw1Z5cVXiT05?=
 =?us-ascii?Q?e2+etVQZCDZvPKRQI2ipTRZss+ZWjyhQOuEjxfAwEHao1t/U2Ch4k69g4cYC?=
 =?us-ascii?Q?eEqeXIoAGrPpLWAQ9/HTL8qTB9wsm7+c5+fvMEo2XhCiRdqLWfBhIK/JZFFt?=
 =?us-ascii?Q?y+gHqn0SDHRzPhhvRGKRjgVauvMJa5r7sqtuJnzzEPLkQpReBKjO+UEDkZ6A?=
 =?us-ascii?Q?P50DfCa308CfvKH915VWcvAWfI2irBHfIUklZb9W2zGeZMg7tBoNSFhTBuvJ?=
 =?us-ascii?Q?tQbxrdynwvjpN9d6xPputsltp3hqdWI1aSrHNoqhQKj3c+Mnu+4eNJ/QjBEE?=
 =?us-ascii?Q?uUsx10jBLhiYQrSVOEpFnfkYRTLTfT6qRBd8KsPkouZXBplCEQPXrwecHD78?=
 =?us-ascii?Q?J2ECjuSva+TFsLRmai9E/n8Iaiw6ygPGH/sOsUzlC7rT5N+nhIEUrMIgZ0Zo?=
 =?us-ascii?Q?tKYPEaClJjaPNJPTY9+6YjR2h0cxNpBt4KbrXGPRiXGhfODwkel+My+MCYvL?=
 =?us-ascii?Q?UyttMLBietAamqblgXTt4oE/l+Dcr1oDuSrs5jd/MvPVbkYEy9C8NozQj0i8?=
 =?us-ascii?Q?t8MXSRru4ogQNwa5u3z4g88fQUCSV5CrVOXSOZY1mhP+hvioZjAziAfBYBil?=
 =?us-ascii?Q?8GZ5GxUt8EPeXwQNF8JCBE5xUvOHp1bZEDxPE3ZhuAjRivVlDhANdaGEjKHz?=
 =?us-ascii?Q?bsbxVcZ5wkDrSdzzr62NcfD5erb5gRcd2yNaaOJLtOWRBCOkA6VwdWeoQUBi?=
 =?us-ascii?Q?CN5+1ozLoZbSJbomHWvtND7zLbHlXJOWhNReitQGXPUwcnUPly6FAgi2VApm?=
 =?us-ascii?Q?dS/lgOXJw67zZ2jZ4gOOgJ7wwk+i2tDUIc5Jl5Lj1Pmu/q1xUQvlQk+mRY3I?=
 =?us-ascii?Q?QGxxTNuFkUUk5bmDzuPtjFmFUfipgXUSRxFaRpKt/CKelqMr2BBNom4VFiH+?=
 =?us-ascii?Q?up1SxNwCNPlcjYYd6Pkggoiz0s5TjP4EGNSRxYWtfw6j1j2mV+BXMtDtewQ4?=
 =?us-ascii?Q?T3BC1QJbYGGWF7S3hXRorsty6+qAGiIjvv4g6c6x2W3slBqYmLvkevMQiVE6?=
 =?us-ascii?Q?v9q1WA39obPaplu2goPKHjAav6F0iqVbbfJ91Xjw8CHNKeqN8gF9RoFyG/jP?=
 =?us-ascii?Q?9Zt8nj0fA+BnYNyL/F/WddcYo/DYD2+Pp+6aivR6besdz3yi4QPRErtDCN00?=
 =?us-ascii?Q?Td50VxSlbCm1zi78HVZ4dJjmMt/U3aBN8FK8S/7s0DGK478GghcjzSQpr4yW?=
 =?us-ascii?Q?/CZOFiPFdPg2AylYDn1EoRttkO1D89hkH/VGS+B7I9H0OxeFMRA/cHywztns?=
 =?us-ascii?Q?bDhoMn1P31eHYcWbq1GALk0w3ZYdYf+Vvfu0M3aB1ifeN6fV87lHpfLGkkY0?=
 =?us-ascii?Q?1JhPAelW57a74Zgm+Af1PPviGsAD7EeRSP3qshkJ6mvAxksHdfbh3PifqafU?=
 =?us-ascii?Q?/M+Hq20Bg2vEqPwiqkE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6811b6-a42c-499f-7b38-08dcbb9f2ca8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 13:52:30.2917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MyTeYvAld9vTyxzwVlnjIfK/bYOPXfY5D7JHspguCdUaHJoZ18P3Chvi2lDb9FlOfLZOiw+eu/VkVYJ9yuPZLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8204

> Subject: Re: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode
> for scmi cpufreq
>=20
> On Tue, Aug 13, 2024 at 10:25:31AM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH V2] firmware: arm_scmi: bus: bypass set
> fwnode
> > > for scmi cpufreq
> > >
> > > On Jul 29, 2024 at 15:03:25 +0800, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > Two drivers scmi_cpufreq.c and scmi_perf_domain.c both use
> > > > SCMI_PROTCOL_PERF protocol, but with different name, so two
> scmi
> > > > devices will be created. But the fwnode->dev could only point to
> > > > one
> > > device.
> > > >
> > > > If scmi cpufreq device created earlier, the fwnode->dev will point
> > > > to the scmi cpufreq device. Then the fw_devlink will link
> > > > performance domain user device(consumer) to the scmi cpufreq
> device(supplier).
> > > > But actually the performance domain user device, such as GPU,
> > > should
> > > > use the scmi perf device as supplier. Also if 'cpufreq.off=3D1' in
> > > > bootargs, the GPU driver will defer probe always, because of the
> > > > scmi cpufreq
> > >
> > > The commit message itself seems very specific to some platform to
> me.
> > > What about platforms that don't atall have a GPU? Why would
> they
> > > care about this?
> >
> > It is a generic issue if a platform has performance domain to serve
> > scmi cpufreq and device performance level.
> >
> > >
> > > > device not ready.
> > > >
> > > > Because for cpufreq, no need use fw_devlink. So bypass setting
> > > fwnode
> > > > for scmi cpufreq device.
> > > >
> > > > Fixes: 96da4a99ce50 ("firmware: arm_scmi: Set fwnode for the
> > > > scmi_device")
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >
> > > > V2:
> > > >  Use A!=3DB to replace !(A =3D=3D B)
> > > >  Add fixes tag
> > > >  This might be a workaround, but since this is a fix, it is simple
> > > > for backporting.
> > >
> > > More than a workaround, it feels like a HACK to me.
> > >
> > > >
> > > > V1:
> > > >
> > > >
> > > >
> > > >  drivers/firmware/arm_scmi/bus.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/firmware/arm_scmi/bus.c
> > > > b/drivers/firmware/arm_scmi/bus.c index
> > > 96b2e5f9a8ef..be91a82e0cda
> > > > 100644
> > > > --- a/drivers/firmware/arm_scmi/bus.c
> > > > +++ b/drivers/firmware/arm_scmi/bus.c
> > > > @@ -395,7 +395,8 @@ __scmi_device_create(struct
> device_node
> > > *np, struct device *parent,
> > > >  	scmi_dev->id =3D id;
> > > >  	scmi_dev->protocol_id =3D protocol;
> > > >  	scmi_dev->dev.parent =3D parent;
> > > > -	device_set_node(&scmi_dev->dev, of_fwnode_handle(np));
> > > > +	if ((protocol !=3D SCMI_PROTOCOL_PERF) || strcmp(name,
> > > "cpufreq"))
> > > > +		device_set_node(&scmi_dev->dev,
> > > of_fwnode_handle(np));
> > >
> > > I kind of disagree with the idea here to be specific about the
> > > PROTOCOL_PERF or cpufreq. This is a generic arm scmi bus driver
> right?
> > > Why bring in specific code into a bus driver? We will never fix the
> > > actual root cause of the issue this way.
> >
> > The root cause is fwnode devlink only supports one fwnode, one
> device.
> > 1:1 match. But current arm scmi driver use one fwnode for two
> devices.
> >
> > If your platform has scmi cpufreq and scmi device performance
> domain,
> > you might see that some devices are consumer of scmi cpufreq, but
> > actually they should be consumer of scmi device performance
> domain.
> >
> > I not have a good idea that this is fw devlink design that only allows
> > 1 fwnode has 1 device or not. If yes, that arm scmi should be fixed.
> > If not, fw devlink should be updated.
> >
> > The current patch is the simplest method for stable tree fixes as I
> > could work out.
>=20
> So this is the same root cause at the end of the issues you had with
> IMX pinctrl coexistence...i.e. the SCMI stack creates scmi devices that
> embeds the protocol node, BUT since you can have multiple
> device/drivers doing different things on different resources within the
> same protocol you can end with 2 devices having the same embedded
> device_node, since we dont really have anything else to use as
> device_node, I rigth ?

I think, yes. And you remind me that with PINCTRL_SCMI and
CONFIG_PINCTRL_IMX_SCMI both enabled, the scmi pinctrl node
will only take one to set the fwnode device pointer depends on
the order to run __scmi_device_create.

So not only perf, pinctrl also has issue here, fwnode devlink will
not work properly for pinctrl/perf.

Regards,
Peng.

>=20
> Thanks,
> Cristian


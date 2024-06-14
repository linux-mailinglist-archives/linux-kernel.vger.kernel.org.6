Return-Path: <linux-kernel+bounces-214812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65424908A64
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 252D2B22FB1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D6619539C;
	Fri, 14 Jun 2024 10:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YL6wn7a7"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4421922C1;
	Fri, 14 Jun 2024 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361998; cv=fail; b=SoFaDDoPj3PWHhuq2k2VwFiJF2uZpsTJ22TdL+jGpa8LRzSzjZMJf/gitL8t3olKWQs01HQ9MZBvzlorxERyORllPf2Xx2xELFho37siVaK89FlZq32yoWP2j3iNBT2Wch3O35dlhQEUve8efaQj+j5NuugwwdpOFqYlA2/b7fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361998; c=relaxed/simple;
	bh=Zk2MUkjk5WfwsfsbgMjm+kdMkLFNDEkMykSVYHqHQtw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kj0YyHZH2AYDJPimes6V7UhsM21KHpRfu0jYKATWsR8Wq9gWj3OXKyIolU8xqy/HUziYPiJ8QoFeYrJAxnjR4teO478DbhB9C4voQ+LcfSJhqwUOqtrKHEFQa8Y1ac3Vp72z0My87KfxpeIVndGhQpNgC5nT6FFoLzF9WGqq7rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YL6wn7a7; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GY8wFffaR3MQr7EkFeu5MSXViyQa5b7tTzFPQxGvPYUiafqN+H6sN/nfnwP8PqC40OvZuxoW+lOgH00faL5tDCyu/D2x8TzCrWc0KG/1DpqeNHGrXDZDVnv4BfLh0Ni+zj1MLddRzUITit1xgADhZUyNV/8GL9bufG1WwGeCstr1W/cEDlpikYyvsVKYaPPkc5yfeVO8enoDWx/obrXubtgFz8Nws2ZjgR7x30UdQwa28+pCfHburinKBA+p0o+56JUVvTbarQorM+qiRhLBf87yxgRDpOlFOc/yCUtMcgjnK4e7u0EE+N72j0D/cNfF4eg0Bb3W5nLtYnkLn0cDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zk2MUkjk5WfwsfsbgMjm+kdMkLFNDEkMykSVYHqHQtw=;
 b=frHTHaW5TNVHqx4zq3/+keqPaV4R1gsBhzFyu+8qmpyzUfGz8Y9I/uj0lfj/g3bYeISNrESnfh7ooiaHh8z8zTecRun2ngjUhM5aBoiV9hQ9SnM6smuIZKtzFWHLLjQNlqtCckphHzgZ6rvCPDp5p7NM5cYT8FRMlN4hircC5nbbhQwdziKCK9Bp9qi4zdBMhx1Mw8f6kTyRjzK2jnI+p5fbtVoGABSlfeOdLuTYTq/8gqcCC0FJha6ylxG4fnQQQ8h6HJy0wCZ9lRQ8GxWbAUQsZ2nVA/ddhWq8IP3gKWybU0KG7GzoGwJvS6KfA+sYhVv4WF8+rpZMB2BcLtqCGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zk2MUkjk5WfwsfsbgMjm+kdMkLFNDEkMykSVYHqHQtw=;
 b=YL6wn7a7u7zWuW3AYWPu7RoE773N26rT6CKOTIRuxB7DcHNVc00EhMeigNbSiuk5qSDsmUNg44JHoc+XLrIO6fjEstSCxy/2SsdLaFEYNq78rLh0x/14bF7MqMnXm+hxdvzS6RZrw06Z2R8jRJILu5dsr2/GYFQi3Owhi6DAqEVcwrBGAN6A5gD+xPU6qhX4OXdDGXG6XvtHt+I4iDviMUoVOIaXyKZI0iCVM1gcwvaTZ+VLD+clJXJ0iEy9XtbB67hvR50eagiCRX8RJQ8bwNDNvMoC+LoguhMrJNcSrgOXuwm2BddRJ6oa1FNMJZ90rc9KutYisE7zoNShQoexhQ==
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 10:46:33 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::bc87:6c1b:cadb:67a]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::bc87:6c1b:cadb:67a%5]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 10:46:33 +0000
From: Shravan Ramani <shravankr@nvidia.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Hans de Goede <hdegoede@redhat.com>, Vadim Pasternak <vadimp@nvidia.com>,
	David Thompson <davthompson@nvidia.com>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] platform/mellanox: mlxbf-pmc: Add support for
 64-bit counters and cycle count
Thread-Topic: [PATCH v2 2/4] platform/mellanox: mlxbf-pmc: Add support for
 64-bit counters and cycle count
Thread-Index:
 AQHaqqzUCe6HwhimrEuniPTiRFYZCLGq/5cAgArnmkiADGGYgIAAY9rNgAEyJQCAA1IGFA==
Date: Fri, 14 Jun 2024 10:46:33 +0000
Message-ID:
 <DM4PR12MB5136181FEDCFFDD15C6AA1C2C0C22@DM4PR12MB5136.namprd12.prod.outlook.com>
References: <cover.1716205838.git.shravankr@nvidia.com>
 <ce077a0db5d4afdbcc63a635fece9793aaae055f.1716205838.git.shravankr@nvidia.com>
 <70d3c0af-8bf6-2e33-074d-5b1719a5674f@linux.intel.com>
 <DM4PR12MB513695D2BE98AA46A95B4C60C0FF2@DM4PR12MB5136.namprd12.prod.outlook.com>
 <33f25d4f-386c-6df6-344d-8b7aa011e69c@linux.intel.com>
 <DM4PR12MB5136EAD83A50869388E96FF3C0C72@DM4PR12MB5136.namprd12.prod.outlook.com>
 <370b5e44-cf92-21af-8c01-dbb208bf323f@linux.intel.com>
In-Reply-To: <370b5e44-cf92-21af-8c01-dbb208bf323f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5136:EE_|CH3PR12MB7593:EE_
x-ms-office365-filtering-correlation-id: da7058c0-d175-4554-9c62-08dc8c5f41c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Rq72Xp5Jycl7JmkYW7lNJo5ppCCbV5Jl5xUfAkBH0KSg2JZcY4WchtI6w8?=
 =?iso-8859-1?Q?V20XHLR9MwcyyxEzlQ6bDEQi/+o/vPXXg8vUhxs8yKaZInEqJ/YdGmgCdj?=
 =?iso-8859-1?Q?H/8zYCSLNz9fLaz4kKZV0wmUdQVxpr3yeQJHwzl8gyUPu0ncKyJgKCpUEt?=
 =?iso-8859-1?Q?fve7yrhu+1rArrPE3q10SJry8c1llMdIAUHmiVsxu0Q90RDBK1ySTv0Oy4?=
 =?iso-8859-1?Q?IsoJEd6pyUlic98ZDohci3TSyZn9YcUiIR2eINva/BQUsUj3k4MqzHmQUe?=
 =?iso-8859-1?Q?73LWtHuWFJ3L60IOIF/igYwULNIn+3WZzpbgZc+km3zgausz2vCf9Hsmmo?=
 =?iso-8859-1?Q?bvVJ3VNYuem5ZLEFclXbDB2I7DyEDhIgwMJfM3Hop587VitfbRvmb6KOx+?=
 =?iso-8859-1?Q?7h9M7EfSCmnrVrmTk74LAhenujDFiTaWRRMJ+YlOdGNpyFecGcAPWdEBZQ?=
 =?iso-8859-1?Q?/n+jU1zLXqWvJcDmvPHdc6FKkn4w0NZMYsQYTyypHjt5Kf3GW3lB5bV/Jh?=
 =?iso-8859-1?Q?MeTel1q5WOO5Gx5eniHr/fS0GwDLbW3NPQFx+LdPx678ArHV5Uw7hEFQFx?=
 =?iso-8859-1?Q?o1/anyQ+xN/LITOUbyUV8fAAqbhHx0BPgFhsLwE4ylUK2t/oN7+fSY645T?=
 =?iso-8859-1?Q?8Zr8HjAxPNeN3P29wtpooa1Lmx65Rx3xIZrBErtpnqCDgrYfn5Q/9C+d6w?=
 =?iso-8859-1?Q?w+rGD/mz0mzVb8qiHt19EDGcudUBfdeZ2cx+8Xeq30SmcR7p3STAQWDySP?=
 =?iso-8859-1?Q?5Ssy5nt7a4gK2NPTEfRRsdc/W66dvdBHnVE6+sH8w3PRcoqMmnBpqD382P?=
 =?iso-8859-1?Q?uJ9NpzQHvuqpDqc3dT5kjD6S4FRtULTO0UTtVHgNCORF1IyDrPvUDwbebK?=
 =?iso-8859-1?Q?q741Vggn3Bc4UAmJ521bW5MbM5cDlE4kS3Aa1iQswI6j/h7hIFK/jJG0qP?=
 =?iso-8859-1?Q?w5bmS35RDSJQCvOLq5ElGcvwpKcLPlsMKj3mrI2bpVB74MkXRTMO9si1JC?=
 =?iso-8859-1?Q?XDl2Rrl0C0S9G1uCMbDlfuo22E41T3cbkmuy0pulUXU5coLN9fI5NWlbaa?=
 =?iso-8859-1?Q?UKWG9BnhMQduz3PigItu9og8Sv+2gbe4QwFrF3M0KoL/qVRUxTKIC48DAE?=
 =?iso-8859-1?Q?QCzQoMBgg2Y6Uxg0wy57pRiCFVr1J6ERyHKTWg/Q87R7qHrVqQK3CrL+A0?=
 =?iso-8859-1?Q?MpVzpgSt58NMOladhTbFgmb24nDpc6Xbvoq4BdMgwF73TRR7+gDQV6vPaD?=
 =?iso-8859-1?Q?oWn3XbpaljdNELmpnCJUDXmR5N55z/6qS5t79dLB16VxPpyqFpguv4cVl0?=
 =?iso-8859-1?Q?TNdBqYdD9p9uOGtL/YfNluBwbAAGaErQbwSI9EIAM9GoyLZGs/+pdtFNh5?=
 =?iso-8859-1?Q?K2oi2gchwKFoDUr9ZRcn6OT4XztY7EHnRNFpCptFXYs+v6GOyCY98=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?uCJe4xLqjgZO/vkZxklncgRmRJBjnG9lhvGtYX4TBNpXk/lPo8GAn95EX7?=
 =?iso-8859-1?Q?yIly0zRO1QgCNK68ROMvNpbzOXZn8Td1t61SSU61uLuOaGFhgzINwANQMm?=
 =?iso-8859-1?Q?nYORzGqKsk5/R/4IurNzfGly/jgcCXKi0bDKI23S/NgXbb8BmkcS+uKVzC?=
 =?iso-8859-1?Q?oRgyURwQaeZ58m0YUmaYdaTX6OhULQ6xc4QJ0aixyvF4VaCQgaeQlZX3es?=
 =?iso-8859-1?Q?bl0NsDBoxC4cEMz4wlZuSrujjMIgOXf/Rt5ELFKePqeW+ChYMz94ETUKD/?=
 =?iso-8859-1?Q?NXC/0WC4BkroUbxU47pgzF+raqYKQ/jYRZ6X1LA7hKyP3J5YpkrgIh8HAJ?=
 =?iso-8859-1?Q?ZG9Bznv2TO0ZXEyKSh8jh+lEtRkBEjV44yed7CeWO53TQyxhj488vtvRAC?=
 =?iso-8859-1?Q?fkuXuPzNobpCCXx39prOotTYBfJIqdYqvcI6SPoGcFqTtSBTZ4KkO2mzHf?=
 =?iso-8859-1?Q?25uGcAnIzoYfAf2j/Gg+M7xAoorN+nNr9vyQgJJ/6qSzyRErGWS/X9aPWS?=
 =?iso-8859-1?Q?FCEP1K0GrVt6/5yvechvKyRPZpxE39IQlcXwYS1q5otSINgWZ1dZ3Qt9+/?=
 =?iso-8859-1?Q?0Y2LOCHYx6/qtgWvsu2b7g0IPIdCdCCqaHscc/MP1UWebDexzBs/pPK594?=
 =?iso-8859-1?Q?y+qaONSvttNntnOOCurZBonBSekrDu1mj+u18yTWXz5JGDZpmKzL9HU9CC?=
 =?iso-8859-1?Q?gFzCJSvJWXT+4dh4sbtNEXdRj5LQqmWYuJcW+bGovVzZ/7M5vJDVNK+GTz?=
 =?iso-8859-1?Q?xygB4x4WKGWjrzdsbX6GpM2tpbzQx8gyY4k0U9RsXsADx82kJVeCMdM260?=
 =?iso-8859-1?Q?jMA2f0q/4tovYyKYY6EqDlRiy/iJKFd5GtezePf8DjyBSsZlLwhCEw5A9H?=
 =?iso-8859-1?Q?gy9mIqM7YQdhSHoro97O9SOp8i8gjP4pV9jG2aO9eSHsv6FYrDDnJHedHw?=
 =?iso-8859-1?Q?5VhkB9BBDF0gCV25BPchc7qy2pSJPnSfk0e9jBUBCNG+Mq4hOZG6M0Czgq?=
 =?iso-8859-1?Q?ibMLwIX1QDnPc5YneS+H+uKEvDgyZIrWO/zeUBGpmbfGQvxMQkFKPBRm1r?=
 =?iso-8859-1?Q?3vHm5Z6vRHgyqvaS6JQpb8Bw69UWQeJSP4MxWSE8yH4eo+scVrOSeHBVLi?=
 =?iso-8859-1?Q?UjA1BjJ3eI2tLMwGOFmcSFmHv/cirGtJJbQu24BY3a9ZkhbNSzeFkP7JUw?=
 =?iso-8859-1?Q?XeV4nxUeWE/4buhuZeT0pxAEdqHP3QxHOTQha0VB+elGMQ5mQjbyTg9Ngb?=
 =?iso-8859-1?Q?Rpff2njuH+WVDlTmTmG+k0KVZf1tcSJ13VRDUX83YgYDXaG0LXgdh1rECl?=
 =?iso-8859-1?Q?glgzzuo2xSpc+4p2AA9yPeP2jnSW9DjvR3R+1Biu9IVM0cX9a8EXnyYYzm?=
 =?iso-8859-1?Q?XFsVLyk95PgakJUoBX5mJ6/ngK8+E0RWs4kHPQeydpuEa9KnBs6IDgmRAK?=
 =?iso-8859-1?Q?GFM1pSQihkjAyFTXbgwlxL09g5n/aR/MWUvg22TrZ4vzHE4+Tir4KIZLbx?=
 =?iso-8859-1?Q?WX9S6WzYCkh7uwzhzDgs3gczt9vRVvCmmb0fdsxe5P/1PjLMgeMS2gPY5g?=
 =?iso-8859-1?Q?FStfUAy3WeiuUSfRPoUoPTruhpfOWmLNzNO31LFnAKltzDiju+7bLRv2el?=
 =?iso-8859-1?Q?Y9hzpRVCdKfYaXoFmUGi7iPdpK9RPz0NYx?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da7058c0-d175-4554-9c62-08dc8c5f41c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 10:46:33.2584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Tw4mlLieyAqnTGu+NlZT1S451M/qAQwuB91TDR1dbBiysrkgkAJ5Wxv/zkAiHSmRMQSrKbSZuJOp6whaPvwvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593

=0A=
> This does nothing to answer my question. Where in the kernel, there's an=
=0A=
> example where a 64-bit counter for BlueField platform is presented as 2=
=0A=
> 32-bit counters? If there isn't any examples in the kernel, your statemen=
t=0A=
> about consistency within the platform doesn't hold water, quoted (again)=
=0A=
> here for clarity what I'm refering to:=0A=
>=0A=
> "The other interfaces follow this approach of having lower and upper=0A=
> 32-bits separately in each counter, and the tools expect the same.=0A=
> Hence the driver follows this approach to keep things consistent across=
=0A=
> the BlueField platform."=0A=
>=0A=
> Where I can find those "other interfaces" that already follow this=0A=
> convention?=0A=
=0A=
Ah, I think I misunderstood the question and went on elaborating the=0A=
same thing, apologies. The other interfaces are not part of the kernel.=0A=
They are part of the BlueField Software Package, which also contains=0A=
the tools that put together the performance metrics.=0A=
My thinking was that since this is a platform driver and is used along=0A=
with the BlueField Software Package, consistency with the tools which=0A=
were developed following the same convention could be considered,=0A=
as long as the driver is not doing something non-standard, of course.=0A=
I can change the driver handling to present 64-bit data if you insist.=0A=
=0A=
Thanks,=0A=
Shravan=0A=


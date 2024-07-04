Return-Path: <linux-kernel+bounces-240899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4655927453
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4290F1F23611
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C53B1ABCAF;
	Thu,  4 Jul 2024 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="frpBmhDA"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012049.outbound.protection.outlook.com [52.101.66.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A76A1A0AED;
	Thu,  4 Jul 2024 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720090008; cv=fail; b=dgcaFs4W5SeNU8qfO0aYzOBo/Za9OKur4PQXCaplg8q/GxMkkiQ+SpZelS5Y7Fgxt/4mMxZvD6f6l6nABrgntziYq9jdeXZXbEjKwFTPyCgLKdtbsE3uipvgxERPzxi6La0on6oR0HkCLMkil506b0PFzgPpD1RQEIvfd3sc/fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720090008; c=relaxed/simple;
	bh=d5GcFinWVQIihJS0il/nlL2egMvitKD62txv5D4CDdM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ip1ITMErzWTgHREyrxVv2G16+P2MgOiMzIdjp7xQgIZ1wBQUu6OhOyez+GzDS/9N2Rsf/b9s4lwo7j82ZfmxX8F/GZP3Yr4uQabiS5WkFfB+UlONpMLYNzC1XIqb+BtKxkIWoPmEpXdW0FVmYU6JzK7ScK+BO6L6OebqArPfVXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=frpBmhDA; arc=fail smtp.client-ip=52.101.66.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmVrwV9sUFVg80cSFoS949d1eH8vYSkeXylwOQcUyNUfXoJgOwErnEy/35kUpYmtGHe/BO/cDfC3HSILGfxW68yUydu5QDU07C8S3fFrogCF0nmmtBtkJbAdEUgjKgF0lxNjAwUf3ZASDWKq8noP+eniGpBjLyTM7s8A3wSfpuR8a7zHm7Y0YmTKJFz1OW95RRCVdomOURm6xiaWCrRQd6IlqofLtcpYwGRheFCUDno+iDA5CL9NdOCiBb/5v4F0LDDOMpVxC+B2+Zm/CDB2WdqHSjaKkmoQdP/xHTYi+basSUj/KGe0+5GyvS8UGJJf+ZtHVM7jSB5IPqvjpTvbRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5GcFinWVQIihJS0il/nlL2egMvitKD62txv5D4CDdM=;
 b=lHL7isRgUB1zl4/AGeh0AwuQxFTkxGecs6n+bEquMMQ2MJIoIJhU5sa6I0jDOxDNG0JtQdNPBipqYqwEEFfeL+wbPpwPcFU84SykARVrzGnNxv1z5D6iRaN/yOo7ecxYZ+N2ODHXPMjVZCmtXYWLFMADm4SFqO3RHuQiqvL5mn4Yz68aAb23suqgjX7u6tQivsSY2f+Z8JHuVOCco40c6DvQKxnm7d5KC79h4tKRnFtCgXI23T+7Z1y0lHKZ9BrfSM2hF/McPCNc8exYl+CDPO41YXumoQZFQGWKWH7jpgxYHtgxmnQ4rHf8CBVbIgyXmGg3WFv13bDl2gxwSiBUlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5GcFinWVQIihJS0il/nlL2egMvitKD62txv5D4CDdM=;
 b=frpBmhDAR2h7DWKLC/n99kRut1HdSTvHOqog+2c4eOOwnhbEGvel4xYDeZMAnZbDV31MtOI2BHrCEbDCz9FFsHPf8vbck/+skb5Ckl1b+QyniGZbEY1P+tu4qm+UB6IJHUy6B4vtOB/7exNVcFEVZ5QJimpl6qzykR6NaKHP8oE=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by GVXPR04MB10450.eurprd04.prod.outlook.com (2603:10a6:150:1e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 10:46:42 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 10:46:42 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: "cristian.marussi@arm.com" <cristian.marussi@arm.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>
Subject: RE: [PATCH RESEND] dt-bindings: firmware: arm,scmi: support system
 power protocol
Thread-Topic: [PATCH RESEND] dt-bindings: firmware: arm,scmi: support system
 power protocol
Thread-Index: AQHayQZ1IfM9c75gwUa881/OgdwbCrHmazqAgAAAwWA=
Date: Thu, 4 Jul 2024 10:46:42 +0000
Message-ID:
 <AM6PR04MB59419639315434DBFF2F13B688DE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240628030309.1162012-1-peng.fan@oss.nxp.com>
 <ZoZ8Mxjv9cIzivtk@bogus>
In-Reply-To: <ZoZ8Mxjv9cIzivtk@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|GVXPR04MB10450:EE_
x-ms-office365-filtering-correlation-id: cd6d29e2-8dea-4e28-1669-08dc9c16979c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1nkRtvL7P11dsmtOep83K2zK1AumGR9nAPUyEDVM+aBlwURAp226BW0LUB4c?=
 =?us-ascii?Q?woHZZ3ExR5QZYTlko6CQk5dDi+EmQW9LbQOUz2f8AFv3/rmASQwWZxIRhm70?=
 =?us-ascii?Q?wNMgWmnwu5aoqLu53MjQ6tZ31Yu/tbfmsPAoFSEQdApcHFOYdEKXuYXojWJe?=
 =?us-ascii?Q?ahJvURvahLIgw+dTvz/jg7E/iielKGl94mP7DWjk0jSLEIHaWgDt7FSs+yOH?=
 =?us-ascii?Q?Fa1HmRjNPWc3otRVpz99KjnS3NQ7VDPKgQpuPnOHHq9LwHJp7ZicaxQOAfCT?=
 =?us-ascii?Q?l0CGfQ1zXUtRQ232q+RJIA1KCay3CgcR1yuffJrpsEDkJVJxEsOc57NxzxNw?=
 =?us-ascii?Q?/at+TcD6ug7MK9qc/lZMm8gcEqFhavWx8MhayJOI98SJNHbWgfEc1o8hKDqh?=
 =?us-ascii?Q?zYi5Mg2wKqJX1LEIaD2x3e/w9AVfxhG711s7FbcVMnc+l/rQao6cCSB14jHT?=
 =?us-ascii?Q?KKSdR3djnLaINJcFeqPWKWtnG6rESsQOEXmWCJj4BmsYdearUvm54pgSa7fe?=
 =?us-ascii?Q?3wMbt38BnWV6mg+fF2KqnXkrYdYYChCWsz6CuqKN04ht7viF81k82VFxGk/8?=
 =?us-ascii?Q?HoAsWrVYoun90BBArbdAk+RyfgHFUu68DmQ7mB3/csKrVQqkOLgc1SZtO4Nq?=
 =?us-ascii?Q?nTtxr630JHc2RubmsMb9f1AvbEBoozK7/hW1ryQ+qzhOfDkPjySk2oVWw095?=
 =?us-ascii?Q?J7CjCmddNCKwaDhhYYWhITcat09+EXf2HHyEfr1t+lalnunEo6DAtRZLtXTY?=
 =?us-ascii?Q?bZwKocedO4v1Mielenq/24EenBfTfKdJqiC+6JbvdO6GhJriUqqDGCbqrQPt?=
 =?us-ascii?Q?ap6WKxNh3zmIsyUKli+pKNsy9Qn6jiyGlhLbdKqg06a4yQAfMdVbHiM88naj?=
 =?us-ascii?Q?sjSOTSHrSNe4Es/yXohgzrWfLtzWk17q5BUjlgW+QVMfGslBYaAK93SoYT5X?=
 =?us-ascii?Q?KsQXObsRuVrEgxJDwnmyiag1v4kN0nZOuD0rDO5BGAFNpUYl80idwWp7rioR?=
 =?us-ascii?Q?o2eQ2zC7UYsOPmOPCghke8PhkalBEuMEJa5sGIqqZEcYlkNmxCuMedc2RBsG?=
 =?us-ascii?Q?/MukePRcJ1szJmV3ESHpILFDNhXUU0Eh4/hzFjpBHqg8MPVXnFYDt2Z9DiGd?=
 =?us-ascii?Q?I+X1rewQ4f5/Tyd1ZCOcV7FySEQqLwMl+i9e20I/DlAz7e6iw1DQe351sQTz?=
 =?us-ascii?Q?PMyowdfPz4dIDwbCmIj1YcxvU2aDSAL+/oP86N4YYdkc4pXkZeufP0k9RX/y?=
 =?us-ascii?Q?LHbB2gs3m4sBhwjesWNNpRq/LNA4qAsCKOkCz+G/fAw5Qkb0VZ7NqChMylMk?=
 =?us-ascii?Q?N9PhNJDO81e474CYUkdyonXoJvo6mTWCVCJYklz+7XvyQ/zl/QVEna9VC19F?=
 =?us-ascii?Q?MWxQQnY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PURU8t4T9JfjQyz+HVzPYJGXEj4r9p+utPvFPp+dEjU5NNJ58GgfaZQDbZIu?=
 =?us-ascii?Q?mk9GpUFuUULisiTqhytc5uq4lxyZVQ9oDFK7bvkE3cyj+qKfqo5Dcb6M6kXa?=
 =?us-ascii?Q?Q48BrIN4W6HJhakxbeOJpdlFEkSTPF4ZiO8byG24eRNScnWani8LerZBo/5O?=
 =?us-ascii?Q?MbQp1M7LOPtMzvwlnGMbkaL9eRUbnNVc12hf0SmYlznI2RZ4CHiSlCOQu+0f?=
 =?us-ascii?Q?iWGRS2U6OOmHpMUppFovQaMxVonfy3uPRuSygK3aG/5aTBdtuRSCa9n4Q6MD?=
 =?us-ascii?Q?emsOK8Pj81Laph4A/qOQxC5n65UDh/g517viBczRXec7u3EsOMR3H2F46MPf?=
 =?us-ascii?Q?TeEoUdUb1hbUBIL35+6USSh0ecKmBcmtJ9KiiTSMZNWuJYVa3kNZ9ZjMOuxg?=
 =?us-ascii?Q?CnEeE185zhHXuetFalvTcHFKN9jSZdeqwsh6YVlrw+FyisiGxMR0S41ww4Sn?=
 =?us-ascii?Q?gkYWgfUzhDWbRllmyc698pMyQPUiyDA0Uluj+cp8Cg+KZGTo+EQwuPBajxQh?=
 =?us-ascii?Q?Z1Ns6B7cQDmTzL4HQxD9/FyuiqSWhc958p0kecBZj64bYvdouP8ydKi+Nx/E?=
 =?us-ascii?Q?WtVOjOOOlwBh5kKYNLksbmyy9ut+Emtwrg7zo24J8fuubYba4Guri6wyzBiO?=
 =?us-ascii?Q?SWBK3ZRFd2xTidw0sQHDQfK9Gh5U09tSnp0hcILL3CxEqJdzzTHWyp/yDrXo?=
 =?us-ascii?Q?lHBeOpcCcs2cEBRHQN3qX9/x5NfWIghbv/ZJ8wh1MEeoHe1BDTH/899kQCu4?=
 =?us-ascii?Q?lJeD8+Pd/wPALkV/VhiKSYNhMMs5JCXCgU1t6fGjjPwopTx1ctkhFsRfJj+k?=
 =?us-ascii?Q?Zx1ddqd/eZGAbV82azTNfzQC02o5qIFmrphRthCHPXxA6BVkevqjXZEaNhQq?=
 =?us-ascii?Q?0Y0fmEEd4o7iAZmRTtXDmV0oE3tFNPaG4Yx+yWSCuvRBJBvQZGUXpRd7x8GH?=
 =?us-ascii?Q?NVNcOcgjF9WngQnPsTmHcaz+E2bzvdrjO3MUWI5MKGXL9HdNpB31JM2HA7Ed?=
 =?us-ascii?Q?LFsykHAuUcfVjQ/wSoB7RoCozrAFs+lhogLe0PylfKXNKUUJanmX4UTI5NVg?=
 =?us-ascii?Q?kbEI6iO3DTmYEAVpq041s2VFwi7urf5V1UxzhwrF8frtoysNJu4KsSEbnP3M?=
 =?us-ascii?Q?TsV411wlycKD60L9hdW99FGPLqW3BwxIKDTQWESihKoXeFJ3dSILoGSIIyqB?=
 =?us-ascii?Q?6rMlJPT7FAGjBorcwZp9EOBhm1plHvRiOudHSYg34+2Z8Nsx1io2dY4/Z8Xj?=
 =?us-ascii?Q?hjsS8BaTmAIT8C5B0xt+CX3pqJoX81nGawLWRwEzsE7MoRnAwOSb1ggawXmK?=
 =?us-ascii?Q?uygMHRasJaAmfLlBJCoOgFA3frCXJN2izpR3NKiB9XvQYxqz0V/kJlWPd3uQ?=
 =?us-ascii?Q?EXsstrfjrAMEq1hu6CjKlP8rE6ZwYaPXusu9YkUtmpK8Lt9j8T3ItSbpOlH4?=
 =?us-ascii?Q?wVvr3RRFRDXvPix3HJaRHCapKsgcKNud6FJpiO+kzIPklOsmUvAiCAcpYZ1V?=
 =?us-ascii?Q?aU4AEC1VG0cxMgubKdqU4aURKekslk5zTc8pRym/ENs1UWI9z+OQKNpfrrgk?=
 =?us-ascii?Q?cuzLI5Y2wTXBThz+YNw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6d29e2-8dea-4e28-1669-08dc9c16979c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 10:46:42.6402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E1OatR3eXQEOrV1wxEc488Q7CZsAlx3iC9vWa/oKL+L/kFAnDl8u+PgKiO2mI/86QXrlgMmTofwmZwqdDC0Gvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10450

> Subject: Re: [PATCH RESEND] dt-bindings: firmware: arm,scmi: support
> system power protocol
>=20
> On Fri, Jun 28, 2024 at 11:03:09AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add SCMI System Power Protocol bindings, and the protocol id is
> 0x12.
> >
>=20
> I think we must have this node only if it has dedicated channel or any
> other required property.

I posted a patchset to support nodes not in device tree. And=20
Cristian gave some comments:
https://lore.kernel.org/all/Znv1p3FDiPSUNmBM@pluto/

i.MX95 no need dedicated channel for this node, but others may
have. So I repost this patch, and with this binding change,
the dtbs_check could pass for i.MX95 dts.

Thanks,
Peng.
>=20
> --
> Regards,
> Sudeep


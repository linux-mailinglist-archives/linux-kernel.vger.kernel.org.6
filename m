Return-Path: <linux-kernel+bounces-245994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A6F92BC77
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F26AB24F5D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F194158D84;
	Tue,  9 Jul 2024 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IdxzND+z"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04F4198831;
	Tue,  9 Jul 2024 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533954; cv=fail; b=kjiwlrNOZgyMo44O/07nnRhhDEUaW83enLIwZ4vB9sA2z4sdWEEJZUBIiTiN5o9H6dEzOEieyHptR8TUvGwN7PP2aNbaIMCoz0+DHpE/QAFHA0AYZB4fqk1q47hqBsepGc2WH7luKus0dQRlE1v2LII06uLley+i8dRZ0ih8tvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533954; c=relaxed/simple;
	bh=sVsAXqoeiUcci00etpqMp0Na+XOKEUtmfqkBTJ/F5mM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JPyEoGsw6VwQKyb7bwEBSBE/1FIDnpVYD1duw7nWZfGo0phCcr1m7wJHc70XPWiAEVtsFC1P9gaBkiWsurG8MBWwFzhdJGFJBqXum2eh52sIB+4qJ+mY4JipKbdfejAiBA3TazbEBejGvqWhoFylLUTpFxWIOSJaIraddUH2STA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IdxzND+z; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGgTp9BbkeKsAc/j1qqTBO3vDBcVIhxeLt2WZOfGQg0DzVFPAoVToG9bf3hFIsZlXMdLoje9InPvak+cy0KrPkXKOxCPSaKG4neMuegtnsXP9jUhjXW+yCONTXpBHzku4c3tMPchCPTUgyG2x6DipEFVb9VvH/Br6ccVxyZ1vTJM6srF+szojBJr2JB+3N/xShZNjUNEKCplJkT9XMX42v471SWma0t3tNDwSzwuGyPCLJWpr9GmCY7jt+4TD85BKgimmK5ZqKtH6iaqEyOrZDdNW30MOyTiqX7TAC/agGM7CM887eKv1DRgvOKGjyQuK7cMLgR5Cvnj1B9QbY+h/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86LrIviUEq9x99808cq/hAGFER849GvQ8XLDjrrA77k=;
 b=PgMlAQCpOciGmDPo9qiRpVPyeT0ZEEGoMpYe7uqhakidG10XugBaun0+xXzY26OSDF3c7Fy9tndoz4u2csCkMVW/ipK6O2Bcz5LcUaChJXecOUv/r3cUOruJPy5+3FIAZXpLHUlFJbDFSl/szPsf7Y2MZKseTGO+RBSeh2Dcfatf9cZgrrqylmfHsL+4Ynu79xqA+oOK5zeYCI0O9WGCdtrXoOZfJ8lbAKT834/o0AHQqGRH1ILHjnAg0q9fw38w/ULUtsvcLreZ6rZasCvK1raPiZ5rzDCsMp+za3UPy4t3mUNe3ByKlhZA3TPGSE+3831oV4U0GbUfUqFBPkOB8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86LrIviUEq9x99808cq/hAGFER849GvQ8XLDjrrA77k=;
 b=IdxzND+zP5OoRachyCaykD/0/MeDqLoT1n0oYiJdGToKSb+OaY/2pfa6aDpjnG9XxhCQ7pR18qDGlRs/npYZLJ/Dss0U+IBWyZXM5RViQG4ZsLY4vCqfNUi/m1TOV+a518VBcTniMEKNU+iWHhkVlWX4iImGIjcJ+6CCQSdHkqY=
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7986.eurprd04.prod.outlook.com (2603:10a6:20b:245::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 14:05:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 14:05:49 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi: introduce
 property mbox-rx-timeout-ms
Thread-Topic: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi: introduce
 property mbox-rx-timeout-ms
Thread-Index:
 AQHazPZCUnP/ehpH2Em9HKMSjtmmz7HmYioAgAAAeBCAAAFAgIAAHstggAAa2gCAAKEogIAFtSQAgAGDmfA=
Date: Tue, 9 Jul 2024 14:05:49 +0000
Message-ID:
 <PAXPR04MB8459F6F0F9530F2138C4E00688DB2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240703031715.379815-1-peng.fan@oss.nxp.com>
 <ZoZ7NCSaG0YRK-60@bogus>
 <AM6PR04MB5941A61736496B9850A3B52C88DE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <ZoZ8pfi5KZZGY1wd@bogus>
 <AM6PR04MB5941F61DFB15AFDA384C153A88DE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <ZoatADKjBfpRCeLz@pluto>
 <AM6PR04MB594199822CE1944DCE3F86D888DE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <Zov94i6FVShbVFee@pluto>
In-Reply-To: <Zov94i6FVShbVFee@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM8PR04MB7986:EE_
x-ms-office365-filtering-correlation-id: a564f032-314a-4ecd-920f-08dca0203c94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3VZWlJhDDYcYgCssh4EFY/liHBKWNmMa8Ee9S1dWW7d5k7ABN1qSBvuJuesn?=
 =?us-ascii?Q?8YY6HDeY8VK06Otmp9yXvM2nqirIBq8xPRZ49sqNRYyIS2ZtqfrSS0BeSu+v?=
 =?us-ascii?Q?jPDlSHlPmTibVMdHCsPCohnOdRRecVCWCNYXJgqMmYiP1CjshdOFtpVM4Ass?=
 =?us-ascii?Q?zaechj/JiEVW2LqmwZ6AJcQnMKCFCWawXsJF2lIaDB2T2PpNSvwxE8c9Q3IK?=
 =?us-ascii?Q?Wa3cCmmRVykxht+YGbf/ltg+nm08STp6CvwF6MjmbnRtpKkR2tlqY2trr139?=
 =?us-ascii?Q?9wcB/tFULQVY0FT9tGl4FVFXweWp09el1EdkWT486TOa+a473CQPmWNJ0F4c?=
 =?us-ascii?Q?dWxBoaPiRnWbkrm2SXcNChDR1xcImQBvkhmP9ZW7DitVmqwQBOWdYFFM+Vgz?=
 =?us-ascii?Q?NijlhRBO3heASqPd8LwyIqqI68W3fQzuFTssKibEdKTIrNZ7/Q6QZF/FO+Ha?=
 =?us-ascii?Q?VNibryoUoozi1//qtxB45EPIB49G8qxNuD/j+q5n4OcVpBpsrr3sjH3xl69k?=
 =?us-ascii?Q?rjUFP1AHSONX6/89c4b7N20iV+1Xr3lu1V+GBlgp8u4V+X36C8L070n9g8K8?=
 =?us-ascii?Q?IB+dvywOo7PJgC642Rapn8EjP/2Y2qBAzxvKeoeWgd+HvA1cEHqJVunQ0OWV?=
 =?us-ascii?Q?JvrwZqpPvwFE9cC17/gRo/D94yQQ6XCAVrbWchcRW7rl+UNuZNvr3wZJmvfu?=
 =?us-ascii?Q?k5XmphScSmvjhw96MCb2oUhj+mXRtCY/c2SO9yqflAssEcg/FRiYZocPrfz+?=
 =?us-ascii?Q?MXFeHK9oGlXlLrRpJKSP9pYFIZXf9MA0HtIn9wsFo57MXuZergS66uScQMmf?=
 =?us-ascii?Q?KNwZUN7HLY5IITDpd8ltQq5jUwSNar8l3tkxQTk856mxNNxbvoJelfatolbq?=
 =?us-ascii?Q?7JlV3bSr4LkEnJ+30/TgJ2TUD+EoG5OrFWcrTyjrlZNuYAceNjOBpXh4PGVy?=
 =?us-ascii?Q?vPu5MsPkEItova45xouVeViaAcx94IeRTC9wo8P+rq/DSGZXszNUu7E6emcr?=
 =?us-ascii?Q?crc7MznyNTentaD1x4vuwhtvIS9HykZqSn9FaFPHDbpyhHKrXucoqc6AjLYQ?=
 =?us-ascii?Q?dRlxp6JlZlJu0WhFMjCi10DoWwposi0oA0baIDAPkj3gTxYKRDvfPxtLsUKg?=
 =?us-ascii?Q?DSVmUEQhpfnT2g/Tv72wstBdxJTImFHpH8djvKtuVKmmTc36ZqNs7Pv2muoS?=
 =?us-ascii?Q?YVBxxcv+ooYL9LeET9+jRmyZoOGk4OezQYVYtw9oSQEkjSuzwCgBKtBvLUTK?=
 =?us-ascii?Q?f+rnv8mpKAiS7J4i51kh9O2dDck10/gwfBPAumHjFp8I0ofne2dUnFFS1UFw?=
 =?us-ascii?Q?/xX1Cyrb/GxXUu9Z1CQrOEfSG+1mxdmtZBnZ1Uzbsnvp8cOT/uhDuhdaIh+h?=
 =?us-ascii?Q?7QXzOm4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?x/sZV0aVLRj8S28DnFFFNXJQl0liW0s2ByVixeZrnlaJ33AlvWiMw7eioc0+?=
 =?us-ascii?Q?WIcbkdqoIqIhWuaIM+7yPa/PgyHRsUt0HoVC9cabSBO24btWBHVOr8OD/m9v?=
 =?us-ascii?Q?qE3db7uvJ7wEh3sfF35HsEg6SXGqTIMz2EGeSD9UINCa7LnyIY4cScHEm0nq?=
 =?us-ascii?Q?tKm0uYKpWFMtPccvg+ZHcHSnKd1MWfvAr2J9tVcbIk9feOZr7Z9hsyPKaxFL?=
 =?us-ascii?Q?0ShgjKrUDuMRrS4ibSd8BxCkV3Ttjlk6Csoldjr0nemk+/uGpdEwb5QbpqqY?=
 =?us-ascii?Q?7pBqyGK9sCYBP73nQnyjO2poEWg8JSuED9nerCEBpeKBgkNV3uw+i5/BpqUu?=
 =?us-ascii?Q?J3CUWaxe8pV6NILG9S4yEaRJx0/QPvbhYaN2AgpYFTIw1jZO4IAyM8DzPEJ4?=
 =?us-ascii?Q?1v1ILwLRQz2NkMOL8zU9UKCoppKW52sSy212nX3NUimNcrr+bYXE5tZ9f83E?=
 =?us-ascii?Q?Ik91/NYY+2CQBvNROQR5n4PC6RsIWTag/2XnW7pTrm13+KNu3LXnpFD6x1TB?=
 =?us-ascii?Q?yXL+z3bxFTOTcbp41MWYmG88PpFI6sjd0QTNbzPITOQ+QfjPkxXVFDSlYZQw?=
 =?us-ascii?Q?H0KlPL2OhaUsbM8fByxWezd1fcavppeMUNW5PZtdpxc22WmpyKRsI1ED04l/?=
 =?us-ascii?Q?6k2pRdetubJ2FzWyrnKeF7eu1KZc+gBE43F3eMdnsLH5lBC8MEm1yYl0MwW6?=
 =?us-ascii?Q?azT+9zsYqQAMb4oZISo8tzzI8ijkR+J2WAobaeshA9Gl20zf76ziz9QMfIgu?=
 =?us-ascii?Q?VX3l2KmNCsOeRT/Ebf6mkoMdFbGHQDntAovEIU3wrGhaUwoqVZc0D7mEk7tX?=
 =?us-ascii?Q?EXSnMBppr7vbyEITU17QZAgSsGmPX8r14KGTeovE6yDffhrDVdvEhZAH+BWP?=
 =?us-ascii?Q?5iGe4JBwp8daHKIXUS57WE5X8fiCbIEztlvrA3IAsLRXySt9nQrvQwel/i3Q?=
 =?us-ascii?Q?jZAndm3tuQ9dKoNq0QdJXsDP448dI/M55tQyidYlWFnPMkMXXJHrycWElKbt?=
 =?us-ascii?Q?/A+5zxBkS6hcEYigXWTB5fz2akXfcJwjhaAZPQwPJvxUfr5+8F/VoDrCiW5Y?=
 =?us-ascii?Q?YJLlffqcGrPWtlbW4LU0V4aF09XV1g8Hy34X1SfMyo3EJctFSvrfUwFXHRwv?=
 =?us-ascii?Q?GF8if/EhddWN6Ds03r8xoQQ4eVXYukwPpyXn62tC30HrpQ5KaHlEPXtPkDHA?=
 =?us-ascii?Q?Dhi+VwjA/L7bVF/bWLmiyBgotnP3rUg0wLZrjbwwYsNa0/L0Ipuam2diapS9?=
 =?us-ascii?Q?qbcg0CzwHkFH4NjwTcRyx0/36l27a6OK2dZOHeySgM2yxsC0nnMg1Oddwgcb?=
 =?us-ascii?Q?RUGRMjGf5p/CPHc3FrSujg7AIJeCK3BPMhq0JJEjSvFAhaqcc1Eq9xzGVd2C?=
 =?us-ascii?Q?/ze6hSQqSNs1rboEaociKaN2pTUsuQnqVDqTgHUVjlQTHovca7RrxyiV2uNH?=
 =?us-ascii?Q?sFCsWl2fDen62d7fTPDyl+Pqkz55Mo5miXBFId+DA4eqiZzSBafBpjNPpcxa?=
 =?us-ascii?Q?fPo2iEDucSO6fA0rTi08oqFliyqeAcIaB+bP1fz1COyRNRiefRpLNyJ2wOJB?=
 =?us-ascii?Q?cm/Y6ZtuGw04kBAp88M=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a564f032-314a-4ecd-920f-08dca0203c94
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 14:05:49.4920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UwJV0V6PU82dejMZ2t51XMy5sct+F8C4ZUmaVNlQJtj34b7xvmtSDqQoxOQmyYr7WNLSeWnYviY4/sHZaUmtMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7986

> Subject: Re: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi: introduce
> property mbox-rx-timeout-ms
>=20
> On Thu, Jul 04, 2024 at 11:48:31PM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi:
> > > introduce property mbox-rx-timeout-ms
> > >
> > > On Thu, Jul 04, 2024 at 12:33:09PM +0000, Peng Fan wrote:
> > > > > Subject: Re: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi:
> > > > > introduce property mbox-rx-timeout-ms
> > > > >
> > > > > On Thu, Jul 04, 2024 at 10:39:53AM +0000, Peng Fan wrote:
> > > > > > > Subject: Re: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi:
> > > > > > > introduce property mbox-rx-timeout-ms
> > > > > > >
> > > > > > > On Wed, Jul 03, 2024 at 11:17:14AM +0800, Peng Fan (OSS)
> > > wrote:
> > > > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > > > >
> > > > > > > > System Controller Management Interface(SCMI) firmwares
> > > might
> > > > > > > have
> > > > > > > > different designs by SCMI firmware developers. So the
> > > maximum
> > > > > > > receive
> > > > > > > > channel timeout value might also varies in the various
> designs.
> > > > > > > >
> > > > > > > > So introduce property mbox-rx-timeout-ms to let each
> > > platform
> > > > > > > > could set its own timeout value in device tree.
> > > > > > > >
> > > > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > V2:
> > > > > > > >  Drop defaults, update description.
> > > > > > > >
> > > > > > > >
> Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > | 6
> > > > > > > ++++++
> > > > > > > >  1 file changed, 6 insertions(+)
> > > > > > > >
> > > > > > > > diff --git
> > > > > > >
> a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > > > > >
> > > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > > > > > index ebf384e76df1..dcac0b36c76f 100644
> > > > > > > > ---
> > > > > a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > > > > > +++
> > > > > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > > > > > @@ -121,6 +121,12 @@ properties:
> > > > > > > >        atomic mode of operation, even if requested.
> > > > > > > >      default: 0
> > > > > > > >
> > > > > > > > +  max-rx-timeout-ms:
> > > > > > > > +    description:
> > > > > > > > +      An optional time value, expressed in milliseconds,
> > > > > > > > + representing
> > > > > > > the
> > > > > > > > +      mailbox maximum timeout value for receive channel.
> > > > > > > > + The value
> > > > > > > should
> > > > > > > > +      be a non-zero value if set.
> > > > > > > > +
> > > > > > >
> > > > > > > IIRC, you had the min and max constraint in the earlier
> response.
> > > > > > > You need to have rushed and posted another version before
> I
> > > > > > > could respond with my preference.
> > > > > > >
> > > > > > > So there is no rush, these are v6.12 material. Take time for
> > > > > > > respining and give some time for the review.
> > > > > >
> > > > > > Sure. I just not sure what the maximum should be set, so I
> > > > > > drop the minimum and maximum from my previous email.
> > > > > >
> > > > >
> > > > > Worst case we can just have min constraint to indicate it must
> > > > > be
> > > > > non- zero value as you have mentioned above and drop that
> > > statement
> > > > > as it becomes explicit with the constraint.
> > > >
> > > > I'll use below in v3:
> > > >   max-rx-timeout-ms:
> > > >     description:
> > > >       An optional time value, expressed in milliseconds,
> > > > representing
> > > the
> > > >       mailbox maximum timeout value for receive channel. The
> value
> > > should
> > > >       be a non-zero value if set.
> > > >     minimum: 1
> > > >
> > > > Put the binding away, when you have time, please check whether
> the
> > > > driver changes are good or not.
> > > > BTW, since our Android team is waiting for this patchset got R-b
> > > > or A-b, then the patches could be accepted by Google common
> > > > kernel,
> > > we
> > > > could support GKI in our release which is soon in near days. So I
> > > > am being pushed :)
> > >
> > > Hi Peng,
> > >
> > > once the bindings are accepted I wanted to fold also this series of
> > > yours in my transport rework series.
> >
> > No problem, feel free to take it into your series, I will post out V3
> > later(wait if Sudeep is ok with I add minimum 1 or not), but v3 2/2
> > should be same as v2 2/2.
> >
>=20
> Still not taken in transport rework V1, but not forgotten :D=09

No problem. just posted out v3. Only binding change to add minimum,
no more changes.

https://lore.kernel.org/all/20240709140957.3171255-1-peng.fan@oss.nxp.com/#=
t

Regards,
Peng.

>=20
> Thanks,
> Cristian


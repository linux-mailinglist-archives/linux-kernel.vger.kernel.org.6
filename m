Return-Path: <linux-kernel+bounces-207302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A026901548
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 11:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04FC281634
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 09:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DCE1CD39;
	Sun,  9 Jun 2024 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="qWa+ojXA"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2074.outbound.protection.outlook.com [40.107.114.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5AF5258
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717924612; cv=fail; b=awcIjNvP+njn05CXcjInRHxmMCB+PRuNMfQ1BCl1nCDWi3OnCs3KK6RLcdmRkgAZgiV98qw30q++f8jEi2zyoAJoQ748Awente9wdngufVUCmPR5nEDqWGzAMVdJnMkICaYdzWcAFapW1DNjyo5/zHoY4rRWvRza9+X4XAM17GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717924612; c=relaxed/simple;
	bh=dgcPQMi0t1/WUBMDGRI2i6U81tr8EPXmy8JtIynaMGg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=axe3zuRAYkHZLxfT/PVxDCIYRXtR4cggzURVXouou6HRO1dfV1hhWTJ6zjXUpzdkjYmdQWDyI8b5GRSTxAkOI82k0omuqMzdtqAvmyrIXpUyyCuSeY5ZvNEZLmGYK736p2P6zPZ6+/b25Wyr3Kw0zgfdTXFAP6cPGiHfcq9T1Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=qWa+ojXA; arc=fail smtp.client-ip=40.107.114.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTOwIv6thnRItnx8KjclSoPkyI3PYJeJTS0yhc5rbWNGU31Zrm3BTjeB+bwk9aLAbABi6tbQWZm9PvQbeKcItUBPCn0cKBNBYZ6BlkHEUX7okdM1gw7jXpquSZMlmaRxNNqtbTpCZONbisbJrBuAwegZaSvjOkuN/5MJiAjttS10bWSnFXPvx0oqVa/orq88Ppq6uqnPbOg0cmWJKwYvWAYzLEmx0JJOelcysxP16lmiw7UxlGfYOkc9zR2t8BVo0JqmVhtG8MGhc3r/u740Om1snsH0ATOZqJ0HUFxJyozzYlT9PkyM23+TfIfNmo0iDh0GoBCMF6i8Pl4imh1CiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOqQn5qm6I+l0kcoZoh2aWLsTjyfIBisSl7X59Ei7TA=;
 b=g6+Gxb4EXSJCVx+ZaGb0F3XRKYCgIRNdkbUD+ATeumEaxMOduO0DuZQ+WTKjDL+EcCtDC4I5k91JsguoYWP0+qhBGyYbQ5qHK2fWwu9Zx8hYBlX/HmDwGDCFpz7W54J9O0WvYGOcfB47w61AMstqmpHr/sVG8pi+5oley0TVB/rNl5M7jwDiWymhKECrDlloEqzXvKNnvJhM/ILgWYFuGSk9J+QEpS9a3gznNxZJAfXQLtlnGOsqKkAzTwM4RpLjiopZURbPC3t4a/vzlkhw65QwE8ObywAHJgwpa8A8MA7cLlhGmpgXX2ckOPFKS5Vaqdkdb00dMJLmS4yltt9now==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOqQn5qm6I+l0kcoZoh2aWLsTjyfIBisSl7X59Ei7TA=;
 b=qWa+ojXAiAzs0RYJ6Dl9zdYLrD7eVUs2fll2S9bYQrUvSwpw8SS81WBkJzPFnr9QQkLzhds3iZA5JKk7ovnIqo9JChwQm72WAaWNL+rjqN1isLzrPQE8jExw7pEB49KNjCsLYIB2j49k3F4zWGCK6PPBCARS7yl+Y6XIi1l5qos=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYBPR01MB5328.jpnprd01.prod.outlook.com (2603:1096:404:801f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Sun, 9 Jun
 2024 09:16:46 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.7633.036; Sun, 9 Jun 2024
 09:16:42 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Philip Li <philip.li@intel.com>
CC: kernel test robot <lkp@intel.com>, "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Subject: RE: arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:85.11-94.6: Warning
 (graph_child_address): /soc/video@10830000/ports/port@1: graph node has
 single child node 'endpoint@0', #address-cells/#size-cells are not necessary
Thread-Topic: arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:85.11-94.6: Warning
 (graph_child_address): /soc/video@10830000/ports/port@1: graph node has
 single child node 'endpoint@0', #address-cells/#size-cells are not necessary
Thread-Index: AQHauWXuNNufcFVNdEChjApJ0f0KZLG9jE4QgAFaN4CAAEC08A==
Date: Sun, 9 Jun 2024 09:16:42 +0000
Message-ID:
 <TY3PR01MB11346322B694FFDDBB2716CDA86C52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <202406081329.snoMrZsJ-lkp@intel.com>
 <TY3PR01MB113468C94F2ED383F5EB883A986C42@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <ZmU7ebk5vWv+fBT2@rli9-mobl>
In-Reply-To: <ZmU7ebk5vWv+fBT2@rli9-mobl>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYBPR01MB5328:EE_
x-ms-office365-filtering-correlation-id: fa669616-55c5-4ee5-e368-08dc8864e088
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|376005|1800799015|38070700009|220923002;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AtuoUYtlX+DAUJFvo87yz8501XzFr2j+2wU6prtHRn/L7nz8NThfVWgjw+FY?=
 =?us-ascii?Q?ppu7MVW0gJNsuGURZBpMQTLPnMZ96ykkZ/F+eSXbWQHvB3mOw1ChuTJaPK7Q?=
 =?us-ascii?Q?BWpYV4/eDHLxmSvikaLtH+PoZU/v4SPP+i5YWrhDiAOnjsxtG+Ws7cSmCxjS?=
 =?us-ascii?Q?XYDM0JgwpR6RC75tKfoVFXbML7HwYXnCyFmqWXEJS9XX3g1IEfs8/15fSAVS?=
 =?us-ascii?Q?ucGPiU5jOCwFovQCV2u9Jj3YYfUVOBwRzmGVVoJD9ML2WfVtp3pce8tF9qbx?=
 =?us-ascii?Q?9e3sSqfLzAAB9WWVdEvWfdkG/ArvrO9SSiaXd9BRlU1ZnJMuGKlePGj2ZL74?=
 =?us-ascii?Q?Iyc0ooQCveZDj6mdqdzAdSEezIcfJSu4NgXK4VIIjfevnr+5K3J2BHE897Wm?=
 =?us-ascii?Q?RhOX8/pylEct6sSbrT73eFcwOWyaQrasTzCGxA+dNcncwYOjjhcG84K6EMYB?=
 =?us-ascii?Q?az7MnvnSAfHCEowxO8fettRHyJgBnGFbHsVNeA079gQAqSQo6RSGSnWvMV9r?=
 =?us-ascii?Q?w7eucU49xmsslDP9lZ69hyre6bHWbvCcZmDtUAm0FkFKeMNlhjGFr+GO8MMz?=
 =?us-ascii?Q?15XjqOeJYWhNhNMYeutxyO9LRX4yMhh7ZeAB8d0aWc+jDRiI9vZqxhhrtHFx?=
 =?us-ascii?Q?Z5jZatgz1FLSRmlRF7JqE6EQh4oUW1zW2y8234qbR10vdPdvtkl4jK9WYN2t?=
 =?us-ascii?Q?yQnmmGpJO0QxCK7CYxI5SoAUifuNGd78h9CfoHGNb4/RVMbWy2BpHG04tJFh?=
 =?us-ascii?Q?ZRahPmUPqLFeHGuAK3+IbTHRG9WMHrxD97+Dj6CinswybD5P7OiqUMZhuOQw?=
 =?us-ascii?Q?ZxU9ncZRDBQvd8MHchnNunirbc6KdhmzK7TTs5H8kSGSqfGsHMihEvsEpCy2?=
 =?us-ascii?Q?Ym8v0gTZN1fhCv2B9hqOkp0yB5zlSETssTRyGvkr0lEAGHxyJkmDsGBms+8A?=
 =?us-ascii?Q?OAhKl5nDL6E6rJqmNvwrkmIy4bniklPxKWIaiiyAJw261KkpKAyz06IqI4xw?=
 =?us-ascii?Q?VZ2/hmomqvjlTdE20Jv38E67qn0R6qf3x+if2RbRQqZ4rsaSyBLwZvHivjxC?=
 =?us-ascii?Q?Zkt+39Ku8Z+2rFFAeC9sYsAZod5pTrFS8UISWATyZL5zojoM+WffxX2Aq7cd?=
 =?us-ascii?Q?B+zieWSTfH14DBj4esJqqrWYQS1fRa5tV3ZicLGGUJVGrSalv7m+TyLYupVv?=
 =?us-ascii?Q?LTBlLZlIidC96iqMDjk4UkgIe4/0uEvz3+VE5CaKuSAftZ13SL8EVM16S8MZ?=
 =?us-ascii?Q?RXE2uwqLiZTfPYQd6gGl7GIFm0hSZFMUmuxY/616qSfAZxOfp+HcjggmBw7z?=
 =?us-ascii?Q?TP0wl20u/o6IXsEcRoPaNduhc9HEA3pyILBg4/G3/weMhA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009)(220923002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1I7NyjcDuBiiz+QTsQZmtKlyLMxi0/6PZhu7qG7oTbQoHZAM1q6fEiOb/Eh+?=
 =?us-ascii?Q?WTMyQsoMr6zRi9htsQ21yiNDvugDbzW/WgYgSEHaspQPFSjW2JMl2A5CA8lt?=
 =?us-ascii?Q?od6vvvw2L7qKppoXdqNPrydGOOs3awJ4m/eIT/IeV65YKcM0G/CeeiiKzjgU?=
 =?us-ascii?Q?XmNGNcVMNPHhIJdzML2A/C06MEOg7aY48kp7jIrdkmBU5w+hYS0nyHvIL9hF?=
 =?us-ascii?Q?hd5lcnVsbu4Uq/000vssf32l+7Loilpp3aqRU3IY7iqPxVwH9AyziLrF30l5?=
 =?us-ascii?Q?ANrIYCIh97L3Eqs97R6JU6303CAVv7Yd3F6OX+W23csebCprM557xfgZ6MFo?=
 =?us-ascii?Q?PTLCPrZZDC+AuKrt6JHQYn9K5lKEl480702c3X1PiH1jswjmXZMtngmHy57W?=
 =?us-ascii?Q?cSjozBQcGNTN+XZlO0BpvQsmmbTx5gsVtniahWV0yY5Oi3bnOvack3ySpbKp?=
 =?us-ascii?Q?9cBai5ISkngDg3hNMjQlmz+Bsg6AQ03pkfmzQhbfPR9qBHPV8GJxX+msFpdx?=
 =?us-ascii?Q?B6Ln2jApIrmg23B+l8/tEAXBh+x6mDlrRn9DQG8MGErLj2EnhsrrrWkipSaP?=
 =?us-ascii?Q?/ixieA7ToVckuLDgiv5BCb2e3ZB+4ODUHSXbDPr8ZSAGUH6NYvr3TezAiX1g?=
 =?us-ascii?Q?w0ZDW2V045pSsKlLbmHs57vLIEYJ+7NK1yH+RmYQ/U6Vpc38XlbW3N31W8FU?=
 =?us-ascii?Q?nEZudCoexMPzzZ8/BZlLxf2Rmzeorw6yt5jRPaXdCOvW8O+I3qH5F0dAdrgH?=
 =?us-ascii?Q?KKyPOOm1dgPtghAEQSDFTErj6dA6AXG9KajOS+lTBFsf84dsKlDluMGX+46e?=
 =?us-ascii?Q?BDY7Vp14NFauLG95/2CEslv4TgiNw45cA5wSIbZIDttNlLct+1ymRS5vAOGz?=
 =?us-ascii?Q?h8rMnrvjWBbzhOLEpMHmAcj3O9AvCS+KOMJV/p2UaXpD2ZD2lXZKGNS7oERy?=
 =?us-ascii?Q?V4JtyaUcAWWfbd9Ge8oV0uzfzGnPhR7Jg511TZzQV11rrF2SW9r8ArfwOV6H?=
 =?us-ascii?Q?8G8YeE3VJG4qsCVHf359yvSNCH/qqiunARQWsGolWwRtYdipEr2bVo6hB+Pj?=
 =?us-ascii?Q?RpJgFJcabo71FSLPa8CX8Bu0yBdpKPFda+n6g8JWrC00l5fJZlzQYYPUlEDt?=
 =?us-ascii?Q?7HEpNs4xuFcSrhPWP0ytz5LoGhhglmCnUScivEsLd/XM60wgEBbeCCqQgPOr?=
 =?us-ascii?Q?lPKnKGY21Iw8/crJhpy12ge4/UCWYXwSB582RqMAOFoqNg58Bu/o8w61mPuY?=
 =?us-ascii?Q?33CpaY+oasHY0ZjVd74xWFUFDucr7IOuBGtQBeEj6vMBN8a580YnhzPhtInd?=
 =?us-ascii?Q?BmbHjGA27p4GTe3woKQyQnp5I4lVg9VjCSsh7u8pnelRWVjijwxqsMXtNO3X?=
 =?us-ascii?Q?zGlc2ey96QBv7V1PhFBG5eteTP1iRiaGWYlEPQd64FmNFFKTh8KB/YW0VR5e?=
 =?us-ascii?Q?7WeaN4aIZW6fUtgSzEcNmyf1gkZqpzrstlNVaympiftI8j4w48CBr65NFqZF?=
 =?us-ascii?Q?4lUI0Y9mCLg6XNnQ8WF5Ra90yZHLNJhNB2JEFDtNt2/MsclS7WinZraSoYGz?=
 =?us-ascii?Q?czpG09j9IaK9fdtWr4qbBMYV1qCXTdiqDmgOVfLbgP88D1lkF9A3wc8p5d15?=
 =?us-ascii?Q?Pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa669616-55c5-4ee5-e368-08dc8864e088
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2024 09:16:42.4418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tBWQOL1tsiXQgPhZVyeUQAaPRX7Kt0ejl3x7k+oK4E15PS9L9zmOT8Rws/L4N16hWaiA2xC94k9dFbes0nxzKdLZ90eHjkKxwWDwMzzGMh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5328

Hi Philip Li,

Thanks for the feedback.

> -----Original Message-----
> From: Philip Li <philip.li@intel.com>
> Sent: Sunday, June 9, 2024 6:20 AM
> Subject: Re: arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:85.11-94.6: Warn=
ing (graph_child_address):
> /soc/video@10830000/ports/port@1: graph node has single child node 'endpo=
int@0', #address-
> cells/#size-cells are not necessary
>=20
> On Sat, Jun 08, 2024 at 08:42:56AM +0000, Biju Das wrote:
> > Hi All,
> >
> > > -----Original Message-----
> > > From: kernel test robot <lkp@intel.com>
> > > Sent: Saturday, June 8, 2024 6:37 AM
> > > To: Biju Das <biju.das.jz@bp.renesas.com>
> > > Cc: oe-kbuild-all@lists.linux.dev; linux-kernel@vger.kernel.org;
> > > Geert Uytterhoeven <geert+renesas@glider.be>
> > > Subject: arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:85.11-94.6: Warn=
ing (graph_child_address):
> > > /soc/video@10830000/ports/port@1: graph node has single child node
> > > 'endpoint@0', #address- cells/#size-cells are not necessary
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git master
> > > head:   dc772f8237f9b0c9ea3f34d0dc4a57d1f6a5070d
> > > commit: 971c17f879352adc719ff215e0769f8e0a49d7c4 arm64: dts:
> > > renesas: r9a07g043u: Add CSI and CRU nodes
> > > date:   4 months ago
> > > compiler: aarch64-linux-gcc (GCC) 13.2.0 reproduce (this is a W=3D1 b=
uild):
> > > (https://download.01.org/0day-ci/archive/20240608/202406081329.snoMr
> > > ZsJ-lkp@intel.com/reproduce)
> >
> > As per this,
> > dasb@ree-du1sdd5:~/lkp-tests$ mkdir build_dir && cp config
> > build_dir/.config
> > cp: cannot stat 'config': No such file or directory
>=20
> sorry, looks this is confusing to "cp config build_dir/.config" as there'=
s no .config for this
> case. We will fix the reproduce step.

OK.

>=20
> >
> > So I have generated .config and copied as config
> >
> > Than I got the the below issue,
> > COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-13.2.0
> > ~/lkp-tests/kbuild/make.cross W=3D1 O=3Dbuild_dir ARCH=3Darm64 olddefco=
nfig
> > -bash: /data/dasb/lkp-tests/kbuild/make.cross: No such file or
> > directory
>=20
> Is it possible the lkp-tests is not up to date? the make.cross code was u=
ploaded recently.

Yes, lkp-tests are not up to date with the master branch with respect to br=
anch created using steps to reproduce
instruction.

So manually copied the below files from master branch.

cp ~/lkp-tests/kbuild/make.cross_bk ~/lkp-tests/kbuild/make.cross
cp /data/dasb/lkp-tests/kbuild/kbuild.sh_bk /data/dasb/lkp-tests/kbuild/kbu=
ild.shs
cp -rf /data/dasb/lkp-tests/kbuild-bk/etc/  /data/dasb/lkp-tests/kbuild/

>=20
> >
> > Can you please provide the details how to get this tool chain?
> >
> > So that I can reproduce and fix the issue in same environment.
>=20
> You can try below steps (without the cp .config)
>=20
> $ mkdir build_dir
> $ COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-13.2.0 ~/lkp-tests/kb=
uild/make.cross W=3D1
> O=3Dbuild_dir ARCH=3Darm64 olddefconfig $ COMPILER_INSTALL_PATH=3D$HOME/0=
day COMPILER=3Dgcc-13.2.0 ~/lkp-
> tests/kbuild/make.cross W=3D1 O=3Dbuild_dir ARCH=3Darm64 SHELL=3D/bin/bas=
h

I can reproduce the issue now with lkp-tests environment

../arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:85.11-94.6: Warning (graph_c=
hild_address): /soc/video@10830000/ports/port@1: graph node has single chil=
d node 'endpoint@0', #address-cells/#size-cells are not necessary
../arch/arm64/boot/dts/renesas/r9a07g043u.dtsi:120.11-129.6: Warning (graph=
_child_address): /soc/csi2@10830400/ports/port@1: graph node has single chi=
ld node 'endpoint@0', #address-cells/#size-cells are not necessary

Cheers,
Biju


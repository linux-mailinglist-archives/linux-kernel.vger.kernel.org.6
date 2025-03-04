Return-Path: <linux-kernel+bounces-543265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E57E7A4D398
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1087F16D7DE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B0A1F4611;
	Tue,  4 Mar 2025 06:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q8Y/dhzz"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4A517C7CA;
	Tue,  4 Mar 2025 06:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068947; cv=fail; b=QP3KqEDFjZF+kqM5Gg0MjE5EGdbDQdMDov0KluD31+OTzjxgeAPbPl6ym/qGgozifqo+/utTFY1Ahd1hnKW66KRz+QBfrReSyKIh7kbeb7kdRqluna78TTi2sDmSTv7sSCoCkdBxJqfpEjtRQ1AnnSC2GP4IoeqZFak+5eYznqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068947; c=relaxed/simple;
	bh=8PNqcPo8U+cGnVeNx5du30GiFZixFI+HQIW1Pv8f/mY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m+vOSnKEGsdfzzwdZCaCNx2xzudHhVhfJcCax/APsqfOQIasiXixxqRonsanPWGU2crYDDlIqbEviRs1Gz9qeCisxGVVq92sD1dSgx4ORulOs9MiphEuxNDJz7dhflJd0sBilk90cq5zF3IuNqFHEUdDORA15yZCkETaCEhDJmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q8Y/dhzz; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1ng07aN46V+bB3yiusOBbB0fL2tRNhSy+juMcwJCpAbdAtQcu578RtvUhn5Qtv/2Uqh4h4op/HesCw0ba8FRNz02adypxJgKZWXCpNc+micIu+jE3Oiju4HtBa9CRtmSgDo1PbLErA1WKk463gQWLvHbF4sYSwGmA2vgOzsdDXVEZvyWm/OVtDBSXQLWJXzitiO1AKQIGnnuaJM2GwI9uUZai1hTgNGALZ15RVImu2PdglUSvTWYfCNwkuB0JCuncZFcyCQvBP0skmASKEfJNZQS4aCX4DKHV3ENLQYU9wla2Wc6+YByiVrjUJjcUPw2n+MfVcGwNaNs40ftaYOPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLR4Vo9RSp1GAWyZgtLG/KXjdluzPtmgcZqqYSLlN60=;
 b=U5uwXyp94wrjaph7UHW8mUydsts/afcoO3tstPOK2EnyoH6K8jRwkPfsuh3pcyw3i9FyMp8qa23KfOS2wFgz3XvdF0qgTlbnTi8uG/39Zfc00BuqqNkN1Pe0P2vZlLNHo4y1KTiDGSAIiyWjjbJyvxWKYhUSm0R0fgQAQYmyvwPhcBWvRZpmH7su5qqESY08m/cSJj9YA/+EVXju8PiZl7GCCLHgGD6ojoZgxiaGmcaHGjNIvZJqWhgcNKv7Gvml0G2pfhtYULKFb/dnX0cEAvWNjRmw5x68JzJqL3SLxRpqJ/lxDJatU1qrYfDfUwlJ9J4gKu+GktSkjQJ+MXSlUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLR4Vo9RSp1GAWyZgtLG/KXjdluzPtmgcZqqYSLlN60=;
 b=Q8Y/dhzz5retgnr8i9PRI/w+1CZMVT0yHowOeDu/Wco8bOBK5e2UggA5bEr9Ts2RGMmS/HyF9bsEt5+pYVEDZauzuvYAmX1J+mzAbjcSwdy+Zb/RRIFVJNmAgTJ9rytbufiUN7T739UGK+CQYWomNrpl4ZTvgNJq73TTQ7eu7nQ=
Received: from LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21)
 by SJ2PR12MB7867.namprd12.prod.outlook.com (2603:10b6:a03:4cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 06:15:42 +0000
Received: from LV8PR12MB9206.namprd12.prod.outlook.com
 ([fe80::5447:387a:c920:8a4a]) by LV8PR12MB9206.namprd12.prod.outlook.com
 ([fe80::5447:387a:c920:8a4a%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 06:15:42 +0000
From: "Jain, Ronak" <ronak.jain@amd.com>
To: Rob Herring <robh@kernel.org>
CC: "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "Simek, Michal" <michal.simek@amd.com>, "Manne, Nava
 kishore" <nava.kishore.manne@amd.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] dt-bindings: firmware: xilinx: Add conditional
 pinctrl schema
Thread-Topic: [PATCH 2/3] dt-bindings: firmware: xilinx: Add conditional
 pinctrl schema
Thread-Index: AQHbeKKktzakC2pjxUKURYxGjWc/ybNCrZ0AgAJyC8CACw5/gIARD0Cw
Date: Tue, 4 Mar 2025 06:15:42 +0000
Message-ID:
 <LV8PR12MB9206C4FBC2C8675274FB1BCB86C82@LV8PR12MB9206.namprd12.prod.outlook.com>
References: <20250206142244.2553237-1-ronak.jain@amd.com>
 <20250206142244.2553237-3-ronak.jain@amd.com>
 <20250211215354.GA1244436-robh@kernel.org>
 <LV8PR12MB9206BA2BC6BBBA184B3E2FCD86FF2@LV8PR12MB9206.namprd12.prod.outlook.com>
 <LV8PR12MB9206B51A38A82F5A1730DA3486C42@LV8PR12MB9206.namprd12.prod.outlook.com>
In-Reply-To:
 <LV8PR12MB9206B51A38A82F5A1730DA3486C42@LV8PR12MB9206.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: robh@kernel.org
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=539fdae5-978c-475d-a29f-1ee20c5a6419;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-20T12:05:20Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR12MB9206:EE_|SJ2PR12MB7867:EE_
x-ms-office365-filtering-correlation-id: b11b0187-9f44-4cf7-a4b0-08dd5ae3fe3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?J1HSHoCPIRGie78ys8BLj5wDtFIObEND7X7VoPqGK6z0BxHBabwnjL6/j6fe?=
 =?us-ascii?Q?CWPWWHy8SG6FiO3ZafJ6yJy+58MbnJuotYqBkyzhmH9N9BEzMXn6OfZPlM4Z?=
 =?us-ascii?Q?bXc46wcoCFtRO/dW8xw7lz8Mw2RVCg/kd1iBP94FOt0z47BibwT9VjBVQL3W?=
 =?us-ascii?Q?4g0cmmLMXhvtcyCYmN28h70EG/qMvc401MaA70QWhQF0CtSu7CisITX6XTNV?=
 =?us-ascii?Q?c0EU4Bqh1mG8LZPrg1oUYTPRR+XlvyfmSAPiiTwJit3oOSffkSj7wwy0pZ3O?=
 =?us-ascii?Q?QZY0NeBaFOQZYNSEGEp4yqa64ea6j5hD8DaD4eO0rvCnBPrCxfemN5E/dYFK?=
 =?us-ascii?Q?hHwObrEdcOExpBTVIqK3wJtkILllmsHWIq1G1slc6oIR8y4MU1uKYgb58e3/?=
 =?us-ascii?Q?4GwIxgO0BdpJ8CW2isZMDFnrEsWxXLY0efJEMjoYC5JvvkJjRbZH+n2RdLaa?=
 =?us-ascii?Q?TqhfhSQNN2uKurBmuKi9e23+yncQiOZmiH1T5dKI5nLsqqh7C53cfsyGfWxk?=
 =?us-ascii?Q?vVpQXytS2seIBegAPfUx6MMz+oltBgNrm8vJcE9c+fc4HuuhiN0poUl2Muy5?=
 =?us-ascii?Q?4G8pTnxWHSFaVT57fbK6eKF11AmYISvan0zMGXa7xu81zVHN3H1TPOzEqT6F?=
 =?us-ascii?Q?e7uTsdOinz4lF0rTRdl1dWsY7oVJH/UgwmmiGMvn8xPjimNgK6s9kUPFyIXc?=
 =?us-ascii?Q?zXR2yMTJ7ghlY6FYtUDFK6vMBgZI+U7btXxGuIF5QG0G1mExTfopGWQPPJcl?=
 =?us-ascii?Q?zBLQX3jYu+4iLan1Z5HydhQvuheFAddyt2WWyKic8Nde+k4PKby/hBJLmDMF?=
 =?us-ascii?Q?MCDU7kVKpcdZH5FT6a0/Wy5JAlqmtPtm3Fgqw0nwqit7VtnAwcIvbDyTJPLR?=
 =?us-ascii?Q?cgvitFrQwn1fJv1o0WtNVKFWq/+BdRMzabAh3qf1Zf4h2INpu5C9prfPo1wI?=
 =?us-ascii?Q?BF8lORfcRMl6SudUyAZIBeV3TCP/xz/XQpIjW6NijiKVjn+27cKqFTxX9++G?=
 =?us-ascii?Q?IJoIc9/rcp6H8DLCLpCEbl3hPs6nEX4GKX8w9h84L8z3t36/6xrj8YtR2XPg?=
 =?us-ascii?Q?oi3xncN1vl1mRn8qWMtA/AAsffaEQNbjAPB/eGHdbFCkoV1hi2MNYD5uJ/5F?=
 =?us-ascii?Q?iMzxUrtWPHuujy2arOiWlvXSLadyGQ2Kfqpdw6uJuFvK+iQ265VzSkT5+RrW?=
 =?us-ascii?Q?7QRvm8jduEQpOxmge0ET8IQpXVOcROBsuDwitzC9lmlvCJ93H0q4peIdf4nx?=
 =?us-ascii?Q?toUzD9XbJzn6ZA0VCyvncuGU1HDSROo6JpjpzaiSRjnR2EpbzkLCTboXAlCY?=
 =?us-ascii?Q?MjBUSKdikMC8m8cVFq6UBDi+r8dv58aRJcyH+bKJ+5+RAHwWq4jdqEHikwyu?=
 =?us-ascii?Q?zqGLMsWzB1+9yAqNAGmMWfOBbVQaazOwhkMfzbislpVQD+NFNsgEqNJkcNcl?=
 =?us-ascii?Q?hpl32/Qlv63EoZmVKsS2R99IIoEpw+x/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9206.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NBk8P/rh3l559igwSmx2F7Z0pbt0xNf5LgnwrBG0FuGfyEMKIBq0e+2vP4zT?=
 =?us-ascii?Q?StUTz2IP66/mgQ2059izPFAP9hkHuIo8piCDGL4zOzDTQ3c9hz7LFMWCEGFO?=
 =?us-ascii?Q?9jcMwN1o2C1c8y5MVqDRT0jzjvhLH6bl18GkP14dTTGv2s7lzglYuHPyU17T?=
 =?us-ascii?Q?dabayToZ3gWNXh9BGy2vvKLbjYD6l8TlFWOFI4mqfj6B2m3GeNYX0po/AtdS?=
 =?us-ascii?Q?HE5zF7Nxj2tZRqxeyoXeR420N7dRu1B3wWgoONDTuIBHvngW4SMO20MQOKEE?=
 =?us-ascii?Q?jISsE11DYqpTmyJ96W2Ip4O0JaGeJQPqzVZoAEoUoy/YGQsElkJz/+cAgPYc?=
 =?us-ascii?Q?GsN6X660BbxUFemh+EhV21dUqC6TvGTKli0vi9D84VSX2keZMvvK5J6susTp?=
 =?us-ascii?Q?HnEyhRkkVygc74SzOA2wT0oSvQdL7IPBomLjh1KT60RwoMQLrnzwlSfuN56i?=
 =?us-ascii?Q?R82cdD0y7NqjKFOsHI8c+LWmImic/aXyeQdMjTr1L2pppUq/9fYFME1JMiXG?=
 =?us-ascii?Q?DzMMsXkLX8GtF/57z4bzq/D63bNJe4ZqXgHpLDybpOEZ7Ux1R5/9qw2/O0YR?=
 =?us-ascii?Q?Eibp8xfMbAMvYA1A28/yXG4o5KC1NrnDN3BFAVnQmB8q2tqGdjpFauA6hxiV?=
 =?us-ascii?Q?mcUD+9AcXgZ3G49sMgehAD7VofWfFF9Zw76AsXn8f/mik0Iyadi6lrTw3G+R?=
 =?us-ascii?Q?hD6llTxzPo4+lJPlj+Wva6i3stjNGfCrfq1sP5pbYHE+va/q8SDi1ibsEKVY?=
 =?us-ascii?Q?t5RebHCBWCn1PKpSG0jYLOBMsC6Er+CfTLCg45rN2rKjlvbFnWiE3IspibdL?=
 =?us-ascii?Q?/nHtk2RDBvi3hyryahwtLCSCnCxiF6DWSAEoMnvPvJ+51PAqAMOHI3MUujK8?=
 =?us-ascii?Q?dWdgme3cjXXTsVaKiggF1Uf01cN5D7wnmzTIu0WRetieaXq79TfQQ24nEI40?=
 =?us-ascii?Q?sp8NCwH1bS2VY2c5sKjidCmDACD/xPZ9r4BiwYMs4e7IOsoXgzKVmdbjFOJ2?=
 =?us-ascii?Q?mS24n+aR5MBtn+xaK9CydVcykuWLkLG517UxXUK4JajsdZt2LA57pK6GEU62?=
 =?us-ascii?Q?VaqznDLbVeauQ7p5U0xEIP7eHOtkUl8SYPbKcxemILAb9VJ7sqH9vVlbTrDg?=
 =?us-ascii?Q?ZNgl0j/iWK/PypWRTxgWVWnQOeelqDssj4kqGF2/KVhQzqQ1arXrhWbMMNYj?=
 =?us-ascii?Q?xwB1js9w2J1UlK3GruqI75akzr5+igTg73nnoeOaNRu6uLuNouE1HnT7hTBz?=
 =?us-ascii?Q?FhnJ/H7dMTCtGQeYpo8So4QY1V6lK/XjJzxEFXhiEHm5b/zH3q+Mp3ssvcQM?=
 =?us-ascii?Q?7VS+jOFEDxi63oh57C1xrq8PsewHCvYdWksi6vs0F+yB/eCp3KhVqPYbzDH+?=
 =?us-ascii?Q?IqD0BhDSm8eKuPB+o7nLdRpDvjdDY8sHTh58ERol3ryy7ZKIeGqxx1Jgl9ru?=
 =?us-ascii?Q?Lm6i9enWp+cf0Df5zF/N0qWXVx8KHCStAwo/9a1VZhloTV5dF4D28wpshweO?=
 =?us-ascii?Q?T6BGqEGbBMNDU0Ju3P7teE+VnjtNcp4MRkim0rfv28l+S50+dXrnbWv0t+w4?=
 =?us-ascii?Q?tgMYZx54ed3VT8UV6Sw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9206.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11b0187-9f44-4cf7-a4b0-08dd5ae3fe3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 06:15:42.5922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RTVQb+DC3oCWroYWpTyqwILo58ClPAC7TCF6RYzPjuEh8eNb7BAle0O9x28jVQj4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7867

[AMD Official Use Only - AMD Internal Distribution Only]

Hi @Rob Herring,

Did you get a moment to go through the queries I asked for?

Thanks,
Ronak

> -----Original Message-----
> From: Jain, Ronak
> Sent: Thursday, February 20, 2025 5:48 PM
> To: Rob Herring <robh@kernel.org>
> Cc: krzk+dt@kernel.org; conor+dt@kernel.org; Simek, Michal
> <michal.simek@amd.com>; Manne, Nava kishore
> <nava.kishore.manne@amd.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH 2/3] dt-bindings: firmware: xilinx: Add conditional p=
inctrl
> schema
>
> Hi Rob,
>
> > -----Original Message-----
> > From: Jain, Ronak
> > Sent: Thursday, February 13, 2025 4:46 PM
> > To: Rob Herring <robh@kernel.org>
> > Cc: krzk+dt@kernel.org; conor+dt@kernel.org; Simek, Michal
> > <michal.simek@amd.com>; Manne, Nava kishore
> > <nava.kishore.manne@amd.com>; devicetree@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH 2/3] dt-bindings: firmware: xilinx: Add conditional
> pinctrl
> > schema
> >
> > Hi Rob,
> >
> > > -----Original Message-----
> > > From: Rob Herring <robh@kernel.org>
> > > Sent: Wednesday, February 12, 2025 3:24 AM
> > > To: Jain, Ronak <ronak.jain@amd.com>
> > > Cc: krzk+dt@kernel.org; conor+dt@kernel.org; Simek, Michal
> > > <michal.simek@amd.com>; Manne, Nava kishore
> > > <nava.kishore.manne@amd.com>; devicetree@vger.kernel.org; linux-
> arm-
> > > kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH 2/3] dt-bindings: firmware: xilinx: Add condition=
al
> pinctrl
> > > schema
> > >
> > > On Thu, Feb 06, 2025 at 06:22:43AM -0800, Ronak Jain wrote:
> > > > Updates the Device Tree bindings for Xilinx firmware by introducing
> > > > conditional schema references for the pinctrl node.
> > > >
> > > > Previously, the pinctrl node directly referenced
> > > > xlnx,zynqmp-pinctrl.yaml. However, this patch modifies the schema t=
o
> > > > conditionally apply the correct pinctrl schema based on the compati=
ble
> > > > property. Specifically:
> > > > - If compatible contains "xlnx,zynqmp-pinctrl", reference
> > > >   xlnx,zynqmp-pinctrl.yaml.
> > > > - If compatible contains "xlnx,versal-pinctrl", reference
> > > >   xlnx,versal-pinctrl.yaml.
> > > >
> > > > Additionally, an example entry for "xlnx,versal-pinctrl" has been
> > > > added under the examples section.
> > > >
> > > > Signed-off-by: Ronak Jain <ronak.jain@amd.com>
> > > > ---
> > > >  .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 20
> ++++++++++++++++++-
> > > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git
> a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
> > > firmware.yaml
> b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
> > > firmware.yaml
> > > > index 2b72fb9d3c22..d50438b0fca8 100644
> > > > --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp=
-
> > > firmware.yaml
> > > > +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp=
-
> > > firmware.yaml
> > > > @@ -76,7 +76,6 @@ properties:
> > > >      type: object
> > > >
> > > >    pinctrl:
> > > > -    $ref: /schemas/pinctrl/xlnx,zynqmp-pinctrl.yaml#
> > > >      description: The pinctrl node provides access to pinconfig and
> pincontrol
> > > >        functionality available in firmware.
> > > >      type: object
> > > > @@ -106,6 +105,21 @@ properties:
> > > >      type: object
> > > >      deprecated: true
> > > >
> > > > +allOf:
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            const: xlnx,zynqmp-firmware
> > > > +    then:
> > > > +      properties:
> > > > +        pinctrl:
> > > > +          $ref: /schemas/pinctrl/xlnx,zynqmp-pinctrl.yaml#
> > > > +    else:
> > > > +      properties:
> > > > +        pinctrl:
> > > > +          $ref: /schemas/pinctrl/xlnx,versal-pinctrl.yaml#
> > >
> > > The somewhat preferred way to do this would be to do this in the top
> > > level:
> > >
> > > pinctrl:
> > >   type: object
> > >   additionalProperties: true
> > >   properties:
> > >     compatible:
> > >       contains:
> > >         enum:
> > >           - xlnx,zynqmp-pinctrl
> > >           - xlnx,versal-pinctrl
> > >   required:
> > >     - compatible
> > >
> > > Otherwise, the pinctrl schema ends up being applied twice.
> >
> > Thanks for the patch review and inputs. I'll update and send the next
> version.
> >
>
> In your suggested code, the schema allows either xlnx,zynqmp-pinctrl or
> xlnx,versal-pinctrl on any platform, which is incorrect. This means that =
if a
> user mistakenly assigns xlnx,versal-pinctrl to a ZynqMP platform or
> xlnx,zynqmp-pinctrl to a Versal platform, the wrong reference will be use=
d,
> but no error is reported. The dt-binding check still passes instead of fl=
agging
> this as an issue.
>
> By using a conditional schema, we can enforce platform-specific compatibi=
lity,
> ensuring that the correct compatible string is used for the corresponding
> platform. This would also generate an error if an incorrect compatible st=
ring is
> provided, preventing misconfigurations.
>
> Please let me know your thoughts.
>
> Thanks,
> Ronak
>
> > Thanks,
> > Ronak
> > >
> > > > +
> > > >  required:
> > > >    - compatible
> > > >
> > > > @@ -164,6 +178,10 @@ examples:
> > > >          compatible =3D "xlnx,versal-fpga";
> > > >        };
> > > >
> > > > +      pinctrl {
> > > > +        compatible =3D "xlnx,versal-pinctrl";
> > > > +      };
> > > > +
> > > >        xlnx_aes: zynqmp-aes {
> > > >          compatible =3D "xlnx,zynqmp-aes";
> > > >        };
> > > > --
> > > > 2.34.1
> > > >


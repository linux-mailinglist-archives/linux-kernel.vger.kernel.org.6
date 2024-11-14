Return-Path: <linux-kernel+bounces-409490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DEE9C8D83
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722E9282884
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B15F13A86C;
	Thu, 14 Nov 2024 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AwMXQ9nA"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041CF3FB3B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731596521; cv=fail; b=gp537hKFFEvlerQ7/m7xpDPPrNnz1k6+Emyfx2kRi6Va7dKI6L4YJ/+tu/hR5Xsmvqd/8Ajy/FB0gSNiLNZ3mSmaDGvdAmSjutengAeW9XDcvmEJ+B7VNef8F/sSoE2a4I2S/xItU/e4m6/YCiAMyVV8tgYELkPeoiq7giiHviw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731596521; c=relaxed/simple;
	bh=Jdv+J338SS0D5TmWMJG1oLqyiun9AXgv+DhT2BdL1iU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=owAKACklkDH+x2S/n5XcxesSvV7h3kweaOwSuzyckWvQ9QZTrUPZNwrr9W8urQTMnsMZBqdbAXJPN5JU7Ph0bePl911GIB7VSjhGtS1OlsRs+IWqOOvwKbg9O1JJRQaGlNBVO9UMGmpnf401WXaEBpqJqc5QsmihxjaSrhuBzXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AwMXQ9nA; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/T2uHmlOsVZFFlgSjuerAkDMlll4wW0wUyCg/I7OJFFEw2YdlQDqHIgON1urhMi8TF6vxIOGGPLPRavqYORE1ZV/cJwtJZrEb6aRJDoq0ihI+P4m9cRpsf5nURhoVcdFTcWCHUH+EVp0Lfk9LU+PtAhYwDJ8e+PPv8Nz0RB9V+diFzvAVPE698Fb57pKK47V7uttGvI1vOvZqZJYQPzFHx7+/NN71dJGd24KSh02RkO78eGGRQP6vbsRBVTs8N1qekv+ab+b9HuopxxCgG9u1cwlHWN03tc6Ec5zb/ZXK63RJ8Kf/E1vD3a0W8QmpAaT88TyuuVYqDNkNlm8zDHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xm8vXwNMDf00qAWHLBwYOO4qwuLkQnPh99k9YDjTUF8=;
 b=Jo9JH8EoG10x9D+IgCT6lQ2V00BlQhiK6J7kSz2EVUu2Cof6UQXurBEjWRDjtRbUxjUAMj0ZPYtZtArjpyZiMI6YGlKHF/s35wqgac6ucu8yi9xGgdTpUQEdqjbTBU53alU9PzAD+3/rndZM8HGfwVlh4ocNTMpg8rKGaiIeY1LCW7C4qBKGwxlEo6w3oovRxRUCkTB4F2D1lKTSAPQmwAXI6+a2uAtH6QWxoFPPzEYRHRmRQx2P9eYM//zUib0brZMmhnj8C0P5Yd3oeKeuzdZMb5baK+CTIfuDmfCrx/4IcZhyOW5xtBJgLO6DCrUWpqmqWwfJ+HjfosX3BnddBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xm8vXwNMDf00qAWHLBwYOO4qwuLkQnPh99k9YDjTUF8=;
 b=AwMXQ9nAPQYwA/ffsyusE1Yd9kGkGrEsijzudftw/E7SuJcEGg5VAFeOOT/O5MtDHvxZNklxmKFBcfDPZgdDomhSPFOB1AV7819P3zRqmxqP7Hi8QfwLRj8AF1S8iB1srvPHaQ2dfbslzYBmrV71q/ltNJj0Z5ulqEU+hbt1o/Q=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 15:01:54 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%6]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 15:01:54 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 04/35] x86/bugs: Restructure mds mitigation
Thread-Topic: [PATCH v2 04/35] x86/bugs: Restructure mds mitigation
Thread-Index: AQHbNkHS40luWOvIm0OfwnZLvShTuLK236NQ
Date: Thu, 14 Nov 2024 15:01:54 +0000
Message-ID:
 <LV3PR12MB9265C416BD54AC3203389553945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20241105215455.359471-1-david.kaplan@amd.com>
 <20241105215455.359471-5-david.kaplan@amd.com>
 <20241114030343.ewjeiyisjycjlxpo@desk>
In-Reply-To: <20241114030343.ewjeiyisjycjlxpo@desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f6671cd7-7f3a-4a4b-9313-c9c393a351a0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-14T15:01:25Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|SN7PR12MB6958:EE_
x-ms-office365-filtering-correlation-id: 7c8e0e8f-fe77-4e8d-ab79-08dd04bd4701
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?J4OhzD9TIYePcwsRS0D8uETpiASTkXPzpPzMMhsHByLSWjVK4+VIR9kGdVRL?=
 =?us-ascii?Q?mzZV9pxC/y8X7QCgvv6JTzQ+DI0R3AaPXOmqLIuh8nNc9iJ0jaj1y76wQner?=
 =?us-ascii?Q?klC3Ha0LyDIP2tt5sgL1FnmB4weXnyU8W3faUyjYLFxQOMAhkvTxe5RZSH+k?=
 =?us-ascii?Q?ERHkY9t23uLoqUwXVwFMyE+WKpASN0UPpt1OeWgALmrl4yVo17HDZZo2N0SU?=
 =?us-ascii?Q?/F6eyqphvWhPtk67cSD0OX7c94wD1mhgEz/xT7KWnWAwqcTe4GUatkczcV1t?=
 =?us-ascii?Q?2nMWNlcoMwEGF1grulPiNjJZ3ElmLsp2sMZI9+8ebY5MaLYsLu7gDleaLvps?=
 =?us-ascii?Q?JNvOmsWu/+MK+USGuUGGpNVJtg9Ipg5rAV4cvCqSwULDM2isEAkL6wfTCysP?=
 =?us-ascii?Q?9OsDcKQptWnVkLUSnfmWb1rspi5fLxUt1sxp0pbW3Bo64Fy/Yk+tZQL/cw15?=
 =?us-ascii?Q?ziOA3nYFMNim5OMHXE7qI9yS8FREhS9oxz0vEMeYIO7V88Dou4sDQtu4GQme?=
 =?us-ascii?Q?eFXzdNK+sRf/myca5oYYuCgs6KHa5JZ9l9bam8Y6Tbpf3QHXPQwsKRYVi+Xm?=
 =?us-ascii?Q?dAhIM33P69et/Sqr6k0Rmvddg16cOXxoNxl1e6huruyT3yZrgO3SYPbYmoF6?=
 =?us-ascii?Q?TBKxvFyFMo98B+CedUJ/oURYD7aN8pybMPloB6FkZ6JCPbVxQRggIcSF3it9?=
 =?us-ascii?Q?XK7TByvthtxfQjmP7GiGpWohL3Nomc4ZpvgErhunHjGVAKTF2WOA0JUphnaM?=
 =?us-ascii?Q?L3Y8nUBrj9c/mdiDpI9bkOTSfQjoIdW26JrL+FwbeXg+J3QmSV6qCs4vAjq+?=
 =?us-ascii?Q?HGsuG6Q0uke8Myz+BGcaHL+xx08M1gUi8yaynaMk7zIvBVxgjKjVIWix2riX?=
 =?us-ascii?Q?WSAiaxKp/E7UoX1kkDfBgVmdVjD4QVF43Q0Wa6H/tmalrKEA7IfSa1XnBdN6?=
 =?us-ascii?Q?hOdQVjg5Op8FIJYc2jvRbwmkZlQuWFgEC+8caHMRxb59N1CL/gQ5EUEan9FI?=
 =?us-ascii?Q?ZSIB865abhcM87ucG82pnPR8vwVUNawQJ6pETZ0n0r6R6w6jgyjRBs8t37Ko?=
 =?us-ascii?Q?4Kc/tAhu7hNsBw1Hr7uMJ7u4Chq/Wu0LtvfrFD8Abow1L4Ir2puVSGQfDAr/?=
 =?us-ascii?Q?Ugk+A1NHq3xSv49Pj0U6Rj080y+77KrnY3i2XKO+el2pTWB5lQQneiIvQQg4?=
 =?us-ascii?Q?csdvBCMlFBze+gDPcCIEC/0jK4Jqov70JypmQ+coG94BnweQdgkQWNnbqmzC?=
 =?us-ascii?Q?zLTdFFZxY19KlEpjbzoZm0QtIGJcBNOxATKs9pewWcx9j6o/XpQp1mv+A1hw?=
 =?us-ascii?Q?LZaBdh1UT3OF7cDZqyXMShVpHHaEKZQPb5gGLL9tkFJq+lguNAd0qm4gbMjT?=
 =?us-ascii?Q?QfCO3yM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MdYdW2alM1G+QWq0c5L4F6jXxp9BB8JLp6iHpqp2dZ/Fg14AbtkwOqDKlzx9?=
 =?us-ascii?Q?C/pUIgE0+medbz/RRQ+9fAE+99CXm6R9fDSbbBwRZ47RmL49EK7cxLHMOvVC?=
 =?us-ascii?Q?jsV/ChkT97KCjadZKF0H0dIRcguq399jCMTXZ/CqYp/nkvAdCmksulnh5LhB?=
 =?us-ascii?Q?/D4godvd7gHac+P3G/k4vquIiOyP/e8n/TPj/7T7aTXFZu9r3GBZNAl+0b/b?=
 =?us-ascii?Q?Y5DGdD7/Q3wSsq4V0yLNUAIcGCVA1PH/ZuNjgc/m75uaVGmjYraRrfbJ0vWp?=
 =?us-ascii?Q?iYS1CKftju0W5rtOcTYqzgLRRT60fWrgUPRuYt3vZ+XgA6f7HPdy6C48sITM?=
 =?us-ascii?Q?91SxzQgdPP7onyxVQgjkwccIeeRfweTFKAJst7edFtR1ok0DE9Up3HUOvzzZ?=
 =?us-ascii?Q?+EyD/62lx3pUy+Evyem+9MF8tNrrUoESEmOii+fR5BxXD26vGEB2WPnsidOi?=
 =?us-ascii?Q?i1/ymQuMAjNM1yNVaY21te1L+duY/xBpbJYBzgpB9n/XxLfDu0DikSZfEGA5?=
 =?us-ascii?Q?TkAcG9WvrBLLXpQAfQaJ7rAGtMKO0pDHJEykcA1HIAevpL7mEgrYkHDnnW7u?=
 =?us-ascii?Q?/+obRy8/9eIR40oGR3MqP14wvArF2wOPyqgvTtYEPR1POyF4x3oRN0DLlA0M?=
 =?us-ascii?Q?7T02T4C1BTWU3d1n5bLBsPWh2yL9AeOrLxo87CsGhetHmf3TyJIZHMAoj3Wn?=
 =?us-ascii?Q?UWxk5KI4rDKWNbtCS5C3Nl8XSDjPBj4IOIneqtVbnNeevv4G7nLhHbJ3VF+q?=
 =?us-ascii?Q?zr+/ckJbjV6RZOjBnoqMkPudKjATd6FRa7bSMRg4wxgChF9LMs9IwLxbn70v?=
 =?us-ascii?Q?8phZbMajXt/9Fy6PUyXeAF/riXgkXBDDVZYWP20Fb6ftYkF4n0JrrC1adD/K?=
 =?us-ascii?Q?2udZo/2sDKfYNFSLJqVyYl8E+MEBd6j2h073QrNvccaR5iqL8pj6k7wr0ocM?=
 =?us-ascii?Q?98qa0cxihc0LXMOX8q2GfoGDHIBQ1EBqZb+vEGIXVMQG1Gn6J3uz6ZlAxxq3?=
 =?us-ascii?Q?doTiuIovJWY9VsRR3v/Frzt2x+y6sXh1EtYBkCUJx5+SuvJVSUWnj4iUoii9?=
 =?us-ascii?Q?JQ3EymrGpo/41KS7ZXTv2fzzJbC7YuMdl2CmPNdrM+fmEOjYUHHp9hZZGIwq?=
 =?us-ascii?Q?Xv6cI5YCYEpA8E2T80PBIBujdg2VD6CS0Ys4M2PpqFCoPxO32kw+A0sub2xv?=
 =?us-ascii?Q?vipWKivJcukRnoNq1D0XyV0zKd4OKwdx14S/bHH3n0cBoAzTnmXw8xj6OH6k?=
 =?us-ascii?Q?OccpJdYF9krlJPzyuQ+P9xxoGmUVA2QQ8aeEMV63w9oPplBLLKaZPkN4XGk/?=
 =?us-ascii?Q?025rgP1JbXASeasycs48XeD677nREniOLTr3rPDe44xPo+jUeunUzpN7UCO3?=
 =?us-ascii?Q?sbdPiyCGfV4onY1GPe66M1C0nPXbJDTgPo1Yrb6pPhVVM4EOh0OFVVP/B/9t?=
 =?us-ascii?Q?fyCLtp6dRcuUlLSDeHs6kGz+WmCMzHpBPbXXZmNxOLNWjWzCiWTCbGeBAfwg?=
 =?us-ascii?Q?vdPeyVLBip0bS6nskt3I3G/X+W3e/nAe6yjXBROWe3tDmrhZMXqhe7NhpsPc?=
 =?us-ascii?Q?5ApDyJWf4EdS0/OlBeU=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8e0e8f-fe77-4e8d-ab79-08dd04bd4701
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 15:01:54.2715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2UaNfIFNPw/wY/3K4yEQn/GSzuGHZ0flQHygQouEN2Le2vTFnwfb/fJiT4vsQC0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Sent: Wednesday, November 13, 2024 9:04 PM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>;=
 Peter
> Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; In=
go
> Molnar <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>;
> x86@kernel.org; H . Peter Anvin <hpa@zytor.com>; linux-kernel@vger.kernel=
.org
> Subject: Re: [PATCH v2 04/35] x86/bugs: Restructure mds mitigation
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Tue, Nov 05, 2024 at 03:54:24PM -0600, David Kaplan wrote:
> > @@ -277,12 +304,19 @@ enum rfds_mitigations {  static enum
> > rfds_mitigations rfds_mitigation __ro_after_init =3D
> >       IS_ENABLED(CONFIG_MITIGATION_RFDS) ? RFDS_MITIGATION_AUTO
> :
> > RFDS_MITIGATION_OFF;
> >
> > +/* Return TRUE if any VERW-based mitigation is enabled. */ static
> > +bool __init mitigate_any_verw(void)
>
> s/mitigate_any_verw/verw_enabled/ ?

Ok

>
> > +{
> > +     return (mds_mitigation !=3D MDS_MITIGATION_OFF ||
> > +             taa_mitigation !=3D TAA_MITIGATION_OFF ||
>
> TAA_MITIGATION_TSX_DISABLED does not require VERW, this should be:
>
>                 taa_mitigation !=3D TAA_MITIGATION_OFF ||
>                 taa_mitigation !=3D TAA_MITIGATION_TSX_DISABLED ||
>
> > +             mmio_mitigation !=3D MMIO_MITIGATION_OFF ||
> > +             rfds_mitigation !=3D RFDS_MITIGATION_OFF); }

Good catch, will fix

--David Kaplan


Return-Path: <linux-kernel+bounces-409733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB069C90A4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859D8281569
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77E4188587;
	Thu, 14 Nov 2024 17:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CnSuVK1/"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D7D17BA6
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604672; cv=fail; b=sogCQXXG5953u4SS5SBzWCp4+0ViH9Cb4jvdff3wZd+V8+wjaw/X0piYLBmLgV1H25xSS1E7t+EjnCAFSKrqr+RaFfu9FnSkCiCMiduVrQRY2fWEL5A1J4/nZILgsftW3ANSXdN/vez3rUcPkZzGEXBL0xLhk/VN6w/Jg3qZ/Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604672; c=relaxed/simple;
	bh=0FeBloFESjcrklfI5FmaAZlg0EB3Q9EGh6Q883nGNIk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=di8gu5r5Vl2PwlSR8NJZyXGVSe/cmHK7lbQzFClwKkRPMp4qun3DGEDf8WDSkJM9SVVr5O1YhcYv2a7pL6OM0eM5DahIyPh5r8n8R+TEH7khxg6FGt2cQPF9B/Gr4oFRAV3MwMApTYH1PVaNJry5u7KHoTaUmnGerjwI2PoUDJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CnSuVK1/; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsrYTV+AXTT3LrtlFUsbJlWzKug0F/P3wihWTmIKfCIxyRI3dbhuUK1B+G9r/rxMzE/c/Uh1qVa65DEqX9oKq3cBeS1CmHRDryrkEWyOFeeA8wFtKpSMrPFvg2iaN2eL7gI/ZTYNWkfORyjptRGaQ52cJziVCrjaJ0/e4uefRpMWHDW/C2iQHfGuwU1R8kFcROJUsDPPyQLt3qToXvX3VOL+ha5WxCNSbaAvqNkY1cc6NxaaBaaY042xV377S9esPlFFIFlTm6DWNR+NEcn0Y1+LBKPP3Eouw2Z/IaWOXtey0M4oAEprsQUnKdS7gEPsJqKpYb33/ChBj4PkOHXFfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wdSXUHqzft9Qo2pYpIG3aFS9qI3DtGgGUNHl8j6fIo=;
 b=N036cv4nAqoTxgtJf5L7goHhqQfmGH/wo8hgUc+MX7lQqPkunbN51emPRxkU9cjvAGlntyEfr9i3z0+sHm7TmzMAt9DOQqisiNgVqDcBFsiT/fAld+KY1P6nUCCfmLF4vVQ/Dgu+uxQJ8re+ZPVsmOPlrFq+L7JsZhEzzrXwfyB1TAm8ar68z33Bk65D3Y2EnGAf1pQUA0Go36TZvMDStWNyd1FPg5CfZ6QZUDUeaqDeWHFztBbc35UcdYee3y1fGl5E0c21iu6E2iuqTLtKiqSDJjbrj9+rMNrFHSebtpDyVGDo/nOFCxIAcNaUa3AoGWYIQv/A4hiYxqu0i8+fsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wdSXUHqzft9Qo2pYpIG3aFS9qI3DtGgGUNHl8j6fIo=;
 b=CnSuVK1/JGNOsXqC5FqIc6rED5xsi4f4OB39iKORWzP1woBWgw43NYNhP2s6idWCZYRkEf7usF/1U0aBSwQGrU9GW73CgBhCkCS5PmdGQNNAB9NJ9FZrvo91xXU/PnhgPv68b8JIz5AJo7Eh1GehlKRrFL+0MjD786F5KnwkkVY=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by BN5PR12MB9462.namprd12.prod.outlook.com (2603:10b6:408:2ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Thu, 14 Nov
 2024 17:17:48 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%6]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 17:17:48 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 03/35] x86/bugs: Add AUTO mitigations for
 mds/taa/mmio/rfds
Thread-Topic: [PATCH v2 03/35] x86/bugs: Add AUTO mitigations for
 mds/taa/mmio/rfds
Thread-Index: AQHbNjywIA/H+otxtk2Qbt3DGqgFdbK23m4AgAAmVoCAAADwUA==
Date: Thu, 14 Nov 2024 17:17:48 +0000
Message-ID:
 <LV3PR12MB92652472998B1312D27F2E0C945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20241105215455.359471-1-david.kaplan@amd.com>
 <20241105215455.359471-4-david.kaplan@amd.com>
 <20241114022654.qr35ebyspjh4zayj@desk>
 <LV3PR12MB92654DE00F67C170DE47B575945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20241114171411.om2djgzbmrkxj2ph@desk>
In-Reply-To: <20241114171411.om2djgzbmrkxj2ph@desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=01627a70-3e0e-489d-8d70-c4c0a2bbb8ba;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-14T17:17:32Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|BN5PR12MB9462:EE_
x-ms-office365-filtering-correlation-id: d809f5a7-ad4a-4bf7-3bb8-08dd04d04318
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?G+uLkCMqRaLXPLhXO+r9hDNr5cpdP6GJ7/DH/d5cMyivG1oJ5gvzWbFI5+bn?=
 =?us-ascii?Q?k3/5t74Rqg1V62/BFPhxmuDpKIPZVqZnLsCzg6iHxGhI4QbyA5RMIfQVWOeq?=
 =?us-ascii?Q?LMa+5XaV9HwFeplLaIg5kueiRA5VMY5kHkqouK7KjKMgVIHwntCpbzSGdJ0j?=
 =?us-ascii?Q?9mNCrBaCqPHkjhJixuUMkTpL58q8u2tHBsrQ2C1RksQ3+gVn8bt9Hcic+C1a?=
 =?us-ascii?Q?2rkvMC0Eu4r3yr5aAVXou4PJ5lJ5lktiGUj/bSQr7amSKSZViNHKoe0Xbavd?=
 =?us-ascii?Q?BScaxynLaQl3mUQeze/eiZEo71PmxF3EAvL8FLqYq4/YS5U85I/JgBbw+GV4?=
 =?us-ascii?Q?COvv6DkSEI/+nP9zj1IpNu9dixDHikmXNuCNcn1KQ6qZTCZuw419twyaOxcH?=
 =?us-ascii?Q?LUhPjhUm3ybiTOf6d70PyNyYX/mVXLlynCfOx7L6c06LjykRoZi1fOznTT9Q?=
 =?us-ascii?Q?9OgXwh82PW3X/J5xvdg6I03B2FPYDnrDSUf6x/cn2UbK4FsSKzx3uMBScDPC?=
 =?us-ascii?Q?2/mIYrlqAgxdios8exNF72oaZ/247b75V12eaX4LVEHr3VnwRSP3HXGsBqK8?=
 =?us-ascii?Q?9L+IIIi5hwGAvYMiv/6kQOClFOg+/jTdTcMISlhwkLXWqWBh5xfwx8z8R047?=
 =?us-ascii?Q?7jlzCkRYzYind8c1BIAtFC/mnLRuFs7MHS2EPkgaR9PX4jLiUWxhNFmXvr0H?=
 =?us-ascii?Q?mCdlwMBwLdIi3//ArwWIJ/HmLDTM7O0cf7eayZwdCC75uIOsAh6rVmQQrE8J?=
 =?us-ascii?Q?zidkDi8rk4NSfaNi81pySDU/yjN8yfg4genKRotNmtGRfd+zrUJjc2LkXMBV?=
 =?us-ascii?Q?wrUykPW1fnEV1h1MYVZJuNiPY5yW5v0aI8arikSMrbPhojwlxoQP3d+G97IV?=
 =?us-ascii?Q?U2qGn2dwiRSnwBUI3wVLwuxKgjYfZK5Kzd4xEzqm/cDCNgX7rjBxTYV3KI6Q?=
 =?us-ascii?Q?bIViPzSVx0BT0INN9nToaRgHqwdKKBpDa+W+bVetCrH6lR5N0CokuRIjl+mH?=
 =?us-ascii?Q?hPbAa4RqHc2qONgwP2JOE5iH/1w3Ll/IiRMJ/hjqF3R73qt/Kw+pcIT7VOLD?=
 =?us-ascii?Q?HlGACIv15sAGTTMKMQ8D6Sn6/LwdVXP7DtBCEPYEXB72Jt0YVtuAPHF+IWdU?=
 =?us-ascii?Q?D2q5wmIEFPQcSXA6JP9jxCSIteZB6ItWXMyP1xyV2sqqSjT160ywCwSqR4zy?=
 =?us-ascii?Q?99x97A7pKN7pdjhHEY8wRrGeTLrEoNzN2ZKtK/Piq2SDJVsxYDFm6jx/+9Mc?=
 =?us-ascii?Q?4FQXwyUgTrjAvqQljXZSGZfTFIcsJ7f60fuIHCiets3Z4ZYWDzonOASmw4SA?=
 =?us-ascii?Q?eoeXcx79mL+fpYqn2Z0YKKc75Mb3MgBzCqjCvgAmx2xZlHFB/GsduxUSvtnA?=
 =?us-ascii?Q?SxnPNNE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?smOcB/TaA9ziBpeNHUumSCr5xAmCT/AyAEqpQeWpuUrSatDKKyIaSAp36AmJ?=
 =?us-ascii?Q?Bx3hM4Cg0j0jjS/L+qXmCMrQpH5AJsDrs5rYdtgEsnrFuoKs/K4cpO/uxNaP?=
 =?us-ascii?Q?/n0bHyUAcoEv8nXgZcyxLg7qvItWC+7Q79swgFErVCe6mDeFe/3K4eqVQwbj?=
 =?us-ascii?Q?URwb4L/xIt3C/shc2Lg8EuYMCCvtFlODBoJXm+kx0QcdHp0oKwQWgAca9SZW?=
 =?us-ascii?Q?9E/YeY5it5z2pislx21ONEhWz1aEVJTqKf5YA+nokZ5yyhNwUgS8y+giuk9/?=
 =?us-ascii?Q?fWiFWKC0sKs0BiBSpRv8P7GoXZSN+K6DSzbxQgW+BwfvVuZF9mx2D85RQUfA?=
 =?us-ascii?Q?MhPOO1zloSLNzIYf4GmenyMQv+ZeFrgQdhUIhpdQ36kZ0GNWGkvEiK0HgOB6?=
 =?us-ascii?Q?9Onl6XdjX6qMAP+qLtZoPs07GZXtnecaftvoUc5KDRdlcnk/POpMXlHl3fBM?=
 =?us-ascii?Q?O3AjusH8k6t84z9YEHLF4sTIeryhNpxyhTeYwCR96FcuShhY7y/KRDptwhB3?=
 =?us-ascii?Q?XPsiZcaTgO39ZBttrIENR0SivIJmlXwzucGyuCKdCGM0LzZp9y5d3Ksjg8I9?=
 =?us-ascii?Q?1O7d+UymVc0+dXHUFdGJ9ZHnCH9Wdfw+eFcRfSGTzwgzrBDkrZpxjul5Jy1v?=
 =?us-ascii?Q?tN5YF5/IQvs3e8c1/I3JLBJJC9TZQ148hLRcM1BRrcGATDS8Gj/qGlPsLg8g?=
 =?us-ascii?Q?kPnhW5wZWaSEZ5DVjD2tL2byV05uFXn1NGg6pmBGSJ45N99kK3l++YoWX/FM?=
 =?us-ascii?Q?qZZ0oKFbBEZnGbdStArOpYB84f4fXjPlvQOSROdUdk2ImuOp48IpcJ+G20us?=
 =?us-ascii?Q?z4so6QPTT9xyaSUAVGQ015DXOOG7GsVU+pfrYD/Oc27UgQjPdGI8XU8QE9SW?=
 =?us-ascii?Q?ALSo+op7YCGy0zTHuNjhDp/FbjomcHcrr0d2a1sW0zArRDO0HukB7yqP3BNV?=
 =?us-ascii?Q?XJLXx14DqclYYEEzo8vTjekeHSnMTiACcO2wj/8kWsyO7e3JSGPMXlhCu0gg?=
 =?us-ascii?Q?+ocQTeLeoNWON+oQ8eG2cn+gWuRmi+ZxzwcDKo4aApoFXBOZ2M+QE3YWD0QJ?=
 =?us-ascii?Q?nxPXRdQ+H62cIzIrU2pG0sVchdjv9SeWLDXTn1sLAYoUYbJJ6EbTEbGfrfHe?=
 =?us-ascii?Q?hxxE1g5LDgR6L/6ZALzF8XB8j4BTphpVwUOK8CTHKtMCyn87xD/r++Oq8l3l?=
 =?us-ascii?Q?b9K/doSKPGFn5bGBiRtNQe5caerj0co21YdodaX/q2+gCdMM3yMxPi7V2U8J?=
 =?us-ascii?Q?vbMDyBU+0+/6CwBES0myoHTA1OYSJ9LYbzN1NW4WxzBVeVTqy6z8FCT+Ghv3?=
 =?us-ascii?Q?D6kSPBF72JsOsgtmnR6AXXraEgc5AuJjm8fqUWDSgUXM7X/MEzpVM93Ate5H?=
 =?us-ascii?Q?Bmq/2VyMJ/42T1JO5Tk6BUxAAKRuy5BVTPMSP7+M4AOrCpVcWborY/CbTLUt?=
 =?us-ascii?Q?O+7AX/63Q7/LYC+17vI7SVBRyTNy3gbhOSb4nGKZJte8yPbvnDnk0c5bfiMq?=
 =?us-ascii?Q?0tVA9kkPYi1NxT7zbTvVaD8/gFzWrc55YoJMYHHHhAqn3QpO/xGmr8GOLjLd?=
 =?us-ascii?Q?OH8hhjcMqDuUx/2AlQ0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d809f5a7-ad4a-4bf7-3bb8-08dd04d04318
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 17:17:48.1681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EcH7tIOb/ziGJB+tpo6VisVA2uIHN/O3KBwE0UlIAGdLmUl9ckXpv2kKmSLwI2PS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9462

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Sent: Thursday, November 14, 2024 11:14 AM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>;=
 Peter
> Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; In=
go
> Molnar <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>;
> x86@kernel.org; H . Peter Anvin <hpa@zytor.com>; linux-kernel@vger.kernel=
.org
> Subject: Re: [PATCH v2 03/35] x86/bugs: Add AUTO mitigations for
> mds/taa/mmio/rfds
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Thu, Nov 14, 2024 at 02:59:34PM +0000, Kaplan, David wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > > -----Original Message-----
> > > From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > > Sent: Wednesday, November 13, 2024 8:27 PM
> > > To: Kaplan, David <David.Kaplan@amd.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov
> > > <bp@alien8.de>; Peter Zijlstra <peterz@infradead.org>; Josh
> > > Poimboeuf <jpoimboe@kernel.org>; Ingo Molnar <mingo@redhat.com>;
> > > Dave Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter
> > > Anvin <hpa@zytor.com>; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH v2 03/35] x86/bugs: Add AUTO mitigations for
> > > mds/taa/mmio/rfds
> > >
> > > Caution: This message originated from an External Source. Use proper
> > > caution when opening attachments, clicking links, or responding.
> > >
> > >
> > > On Tue, Nov 05, 2024 at 03:54:23PM -0600, David Kaplan wrote:
> > > > @@ -1995,6 +2004,7 @@ void cpu_bugs_smt_update(void)
> > > >               update_mds_branch_idle();
> > > >               break;
> > > >       case MDS_MITIGATION_OFF:
> > > > +     case MDS_MITIGATION_AUTO:
> > >
> > > This implies AUTO and OFF are similar, which is counter intuitive.
> > > While mitigation selection code ...
> > >
> > > > +     if (mds_mitigation =3D=3D MDS_MITIGATION_AUTO)
> > > > +             mds_mitigation =3D MDS_MITIGATION_FULL;
> > > > +
> > >
> > > ... indicates that AUTO is equivalent to FULL. So, I think AUTO
> > > should be handled the same way as FULL in cpu_bugs_smt_update() as we=
ll.
> > >
> > > Same for TAA and MMIO below.
> > >
> >
> > The mitigation is never actually AUTO by the time we call
> > cpu_bugs_smt_update(), since this happens after cpu_select_mitigations(=
).
> > I had to add the case statement here so the switch statement was
> > complete, but this case will never be hit.
> >
> > Should I put a comment here about that?  Or is a default case the
> > better way to handle this?
>
> My suggestion would be to treat AUTO as FULL, and move it up with FULL:
>
>          switch (mds_mitigation) {
>          case MDS_MITIGATION_FULL:
> +        case MDS_MITIGATION_AUTO:
>          case MDS_MITIGATION_VMWERV:
>                  if (sched_smt_active() && !boot_cpu_has(X86_BUG_MSBDS_ON=
LY))
>                          pr_warn_once(MDS_MSG_SMT);
>                  update_mds_branch_idle();
>                  break;
>          case MDS_MITIGATION_OFF:
>                  break;
>          }

Ok, I can do that

Thanks --David Kaplan


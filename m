Return-Path: <linux-kernel+bounces-241270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB72392793E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED361C238E3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C961B1413;
	Thu,  4 Jul 2024 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fV7/gnRD"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2111.outbound.protection.outlook.com [40.107.92.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FB01B1207
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104534; cv=fail; b=Sk1NW6kYakvwfHk4ycmOR9XQ+AtW/HqcjMFp7AEUNfoBzmI0tj3fPpFkTQHtsI5ROMQycQSgl34dMorHoOlggLSiIuVlXdtoLhimfXfJuGsIKTFEuly6PWR5m2IhpAo/y1Yjmir1BgEo/2y7SqNRiD+MfmU7l/y+ByvQjRvtRqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104534; c=relaxed/simple;
	bh=g5yyE802K709ue9hQXrvkB518nYZIa7ZWr4uWw4cj5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CBdtCTq9vFmeF//vOi7ZVygiOVqKzX42oP/nwAI5kJq5I7GtBQ9vw+2KgGOALxs/aR0lnHm9QBSYlbI9jpKnLZA/78gI+dx7AbjTWmZOni4DWKu7ACGc3NrjKA8VNrhAA7NjGEiCua15gyDjof5nJxyyJxxAHlvU1gW6V76nKHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=fV7/gnRD; arc=fail smtp.client-ip=40.107.92.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YifxAZLN4atoh5KKokbDGxzU/X5L27rmAuXp0TwafT5ashIN0iDYUF8XjUTjhH0oKlLRElB9XnjGFvMU9HIAzbKHue0Bm3YNqdMkfN/Wrsz+l9CVrmwKouo06qsr9Dml/roqs0ovylPZ0pQCbfPD+v43uNQbLp5ohWiFsxkKecQdZgR2Yxx1VOKKy1dJ/yQ48gncq3FzT9DVwGZnMdIY0m3aoDKG56OvayoSarUwFwnwGAMzbUbaD6FFs1tNB4GmdapXR/B7Z4Elrw3NUx9EXCGVPlxAIQOXbV5Ad6H+zB/8/Gk9Efh4SV0qe8mh/sL6H1Mu/iGS/7vYHyEksqeIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHd9MdqDM/spPGUI5WzLoK2DoAoLJ+6u3C61zSyStaQ=;
 b=WeaJP7QqKlZ2LYHz1l9a0+Q372G7vpqku8+vwVza/kiyRCZSt2m+ZcaU0C5vXfK/xdLLA9Tq5FWH0VX/sxtwhByX1A9giJg++ddcvqHW4tLYs7ScP24NiwyMsGMxk9zR9nWOFQnkjYNUBOrF67UjiUWqff8RZ8TRDrT6anqzZcpOhyQWwNwFT8nKvp4RlmQ/1WDBnJ96ek9xOoDOxY3ThdeC9kL6QA6T84Rf/ovIpska15JPyOG4YsPOw5unrHIU/tTZfeXSKxWbjTf4iwd0moXlBlhF6KJbN2OXJYcr8L54Mzzkr88GsfBISbIJHeddMf8D3Ae8Z1ZygvEp3a+ULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHd9MdqDM/spPGUI5WzLoK2DoAoLJ+6u3C61zSyStaQ=;
 b=fV7/gnRDM3EerFhBIKQFB/AkY+mtxlX+SbGolJ2HuK8TAPgTtzbLU1YQCIg5H3x3B0TOk2m6z7V9Fk8oeYaK6TtXn11sl2qCLo8YA1OJk6fjobL/amCvr1uWmkxuR7sT9bZ2rF66uL81J8FB8FfwZA4SsFCfixC5qRjDiSsmCWY=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by DS7PR21MB3774.namprd21.prod.outlook.com (2603:10b6:8:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.11; Thu, 4 Jul
 2024 14:48:49 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%5]) with mapi id 15.20.7762.005; Thu, 4 Jul 2024
 14:48:49 +0000
From: Dexuan Cui <decui@microsoft.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Michael
 Kelley <mikelley@microsoft.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Kai Huang
	<kai.huang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/tdx: Fix crash on kexec
Thread-Topic: [PATCH] x86/tdx: Fix crash on kexec
Thread-Index: AQHayi08OouzMdQ9yk6RhWa7zn+1QrHfHynwgAAFCYCABj7PgIABRYeAgAAEEjA=
Date: Thu, 4 Jul 2024 14:48:49 +0000
Message-ID:
 <SA1PR21MB131745AD18D9E91D2ACA1964BFDE2@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <20240629130621.1671544-1-kirill.shutemov@linux.intel.com>
 <20240629135933.GAZoATRVAubo7ZDdKB@fat_crate.local>
 <poxeykijyqrz5hxrey46s6hh2qd6byirbevwuwec2gtbfq266c@npegk7sn3ot7>
 <SA1PR21MB1317A2E38083B300256AD5F1BFD12@SA1PR21MB1317.namprd21.prod.outlook.com>
 <20240629194103.GCZoBjTzC4m9a9yw1k@fat_crate.local>
 <SA1PR21MB1317B5850E4274CC31EDFBF8BFDD2@SA1PR21MB1317.namprd21.prod.outlook.com>
 <nx7jjplwvtmxsq675omsi5hc5oxceiffpmkqx754azuv7ee2zh@7fttse2hssti>
In-Reply-To: <nx7jjplwvtmxsq675omsi5hc5oxceiffpmkqx754azuv7ee2zh@7fttse2hssti>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2a2a8649-d80a-47d4-af43-64a9a084f741;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-04T14:43:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|DS7PR21MB3774:EE_
x-ms-office365-filtering-correlation-id: 2dc6bf8e-842d-4b11-12f5-08dc9c386a67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EwQv0/RlIUBz7xy1wifqIrFEMe9gi9fwRe7fiNaLhKJReU9nTK1WWAYeulgm?=
 =?us-ascii?Q?Wb262cAlMA+LGYQU6DYV8YuPNq9wfZVs3dC9MS2GxRnL0n/qV0dKOgMvSwy1?=
 =?us-ascii?Q?A4I8/Wm3El2WMvuceMKTy1VPF7RkFNYdOuRmruqmIUMVS+f+hj2KeXBbF+mV?=
 =?us-ascii?Q?InDU1Lz2U61fkkgPfP4I1EKD1Lze87pyoi8wpwFJnSQd9O5erufV7aXrHcaH?=
 =?us-ascii?Q?3ulHrr9rt6ih2Gyrv7CBrcsqWA+W/iEy/AY3wkHrVh5Ec4veDDEzqsmcxDlg?=
 =?us-ascii?Q?RC7yteph8GBQpkzVO4TsTbTxlMcalogZMfYHp+pYl+Xn1H4knjVjwCFIgwps?=
 =?us-ascii?Q?dWNlEr0jIDpq1JAu4Lrek89cvPm3j663Hy1DZ41JKQGFPQndVt3JPWqu4JCe?=
 =?us-ascii?Q?f31vz5dVXMEibDEYp+0iLUAHecYI57xmILRLtSGiUTU+QKCWv+aJ9eBpLo7Y?=
 =?us-ascii?Q?MEwLw2mT8bGPM1vnJKGqEnT85PkXLjR7o4xq/ce09Zk2630RESUZIafv0t8v?=
 =?us-ascii?Q?1hkQJV0equj8aXebBwm8VkcMOt/KUUwNO4EY0ttpb5z8X7DNJhO2rIdmN5rw?=
 =?us-ascii?Q?XaJ+uJWMydlzzfqjKnrhya0U74G6Ld0KF9Q/aqZ2HE6D1ljiHS4MB49Un8dQ?=
 =?us-ascii?Q?GudBij9KXW8hY7POvVefGaZSxU717KTwgO2MVGEyh+40GkqjNnuzFchgLCnu?=
 =?us-ascii?Q?4WOYuNuSvxxesFX7LJbDHylxj9h+1HEuTd0poSy0NbXZGTwYlIdbvIPA8n4R?=
 =?us-ascii?Q?doW8DNG+KUOUWOgN+6MwINpakiKNiyXGM7MDo7AaIJlvxRNcphops310SK85?=
 =?us-ascii?Q?DdgRwvCSVs21ABN08w8J2wzVIKUtQaC7Rzrx7Zn29G3LPGQthXBcgxKAMWsy?=
 =?us-ascii?Q?RO7zKtVVbCaFlpxLysVyeR7CqJVnGx6hHpunds83OI7Ditm0dToFH/GxfLrD?=
 =?us-ascii?Q?H6JHYHLLRR64yLyOnzGhvWZFFxAfEGl7+YqMp7GdCYTqSo++/mx1woaRQ1Vw?=
 =?us-ascii?Q?b7pnjUwKUW8//fwqkMFBBIzr0Mt4LjiSCUKijO5XLK9Is561CZ9mGGtE/amn?=
 =?us-ascii?Q?XF0JcU2U2MhJel48bsqtTnlAm7O3q+K2FDPo+eR5TG5TeFAZ+KNhKZx5Lq3D?=
 =?us-ascii?Q?uJWbE2IDsZ0rF/ya6W/rug+pJoir0cqB2tZ1jKmIrvjI/SSySH9BdO2p6Z5h?=
 =?us-ascii?Q?eAHJOieFd80yy2fYbfHIFfg8XjqGZnUKH9JHYwMiwYLyxKs+Db2TuHZ9sPX1?=
 =?us-ascii?Q?iLnDAVoQfAjs6T6696cdf2bOwnhj+yUogUPgtwT50PgakylTjN7IPRKqV1b8?=
 =?us-ascii?Q?OSvsX9Ui17dLAHzyUlydt6RvuB0cWIEttGi+ke3Ylgo2VkhUbYsUVwuEj6Na?=
 =?us-ascii?Q?UIoX3nBC9r5hvyjMvpNHgM+2dEYU/lrZJaauQgZO87vXwm0+PA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RxG3p89auw5MSN4/dODjfbKYvxUZcUFMRm87uF9Srfw2e4zoAHr+b7YnnFK8?=
 =?us-ascii?Q?f+C2GAZeCm/xIEQEbXoP99oDEgKVEfTDaXfkz0PcrpUZqbtLQLExP1/WNqDH?=
 =?us-ascii?Q?XPXFIxQkk5gUdU5OfXlZEu3mEeP1VMJOGiFYgSVJgyZ1YUhz0zlh5T0iZxWM?=
 =?us-ascii?Q?CbzuZBcocpmsGgNfDt5sUwBbka0WVhfohDemx++qq2wTzQepa1bK+elkrVUZ?=
 =?us-ascii?Q?IOgz72ukeErvXGGgMMxiafABKQ/NYH03wbp1pocPtEBaAxPTae7KIrI/i9l3?=
 =?us-ascii?Q?4BzfvmxZwKVlhxwtxq23hA71PbWxHlV9BLj9QwdHfpymhQSs99XN14CGweHa?=
 =?us-ascii?Q?k5t6qkavATQgYl1M/2evAtbseczOqogBgnyZkPsfL5ux8B9usNZQKYC0EQhs?=
 =?us-ascii?Q?aZgWtAenOsSj2W8z8PWEcK05UAXSdopk2nk++PfHFfkKcv1i32aDfjLqcCB7?=
 =?us-ascii?Q?a2CTeURdLlse3z/nr9h13pIMiuTluaMwMJKy3k0mKzlpIpUjLo/lX1ec+kRl?=
 =?us-ascii?Q?tlQVDERDSvm7MdQ2P2OJITLb0D8IbXaWjzpXau4BHLJ/J0LIFXzzB5Af2Rrc?=
 =?us-ascii?Q?leuaix1ljbzrZgtsTdi8XnmuxwJsmJc1QGCLg09cR+F+JRYZ2hNoz+n8O/5f?=
 =?us-ascii?Q?zBgjQ6G/IB+/Ym9IycKNnIZHMh/ZDbtd4syn5/gm675DfAyXkLPs+sO0Bwl9?=
 =?us-ascii?Q?x/Gd7HzF+Ad4Hls+gKnXfPe6kb2ViFj/E5dwrxLcmpFOkGJhhHR0KNVT2z+O?=
 =?us-ascii?Q?LFDSGJmyh3dTuqeEAZN2/DhFaPiEMOOvWJsdNqHjeRrS9s/HHZX9+Oj3j8XU?=
 =?us-ascii?Q?hiG9F81+Rs4pU3QK/7/kba6GC1olRNsbfphu9+kyDsopiAv8GqmNXrir/2Al?=
 =?us-ascii?Q?G/0didhL+4fsIBgOFBo89t/kIbXX3sPFpg5JCA6rn7vDxAesXX8cOt6d9qHQ?=
 =?us-ascii?Q?Aq+1XE1gzfupH7GkYBQqdfspX+BcctpUw2ipxgdV6GNWES+pEum0E5bkb9LL?=
 =?us-ascii?Q?B84MMr4rbnZZBlaNUaHcWNhvy6f8HdfVBbwb9UlicaPvypKlOi3TImsUKYmg?=
 =?us-ascii?Q?UrndhhG8HZ8WHdc0IbvYj3Rp+6LArI1KKavsuM2b6EyAcXeDJnXfGYAomHd7?=
 =?us-ascii?Q?8TQUfwnnM60qGrG+/sjzXyhcWbnNa0fJCKgY6YjHLQh5gkr+q6IlQDOQN5/y?=
 =?us-ascii?Q?ESOavdN4WE3+3uQvInV5GIyQpMNheuWNoR0FJ0yyXwfh4+In/OZGJ9bR8dc4?=
 =?us-ascii?Q?WzTApyFxM8uhuc1c/PyKP++ixYnf9PluXdd9wh8rZKbvJI6tYH/07GdFKGre?=
 =?us-ascii?Q?FpD9yFK3nDE1OxPhvhS6w5W4puypV0cgGnU+frEGHaDDCxdilFGucSu40Sr3?=
 =?us-ascii?Q?z5g1vHEfOXMx8YibCyPuLk3k+jXXcm69TECdKgfFiISjndcU3bDgbthZSgiK?=
 =?us-ascii?Q?spVMwfeCPFgHLMQa/m5RrIo1bA+z4lBCtbOtJHXko1zoCm+317G1Y3Xxtsmo?=
 =?us-ascii?Q?TtjYTsVaxppbbDwyvfPC5yGGv8aj9EkZ0huWXPW4a8xYuKeYsTarfzcdH/3O?=
 =?us-ascii?Q?86dtB7vk11MARXCiI0Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1317.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc6bf8e-842d-4b11-12f5-08dc9c386a67
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 14:48:49.6782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AbNZCWGbWxrzjtKqoJ5FALEteGoz/m0bay0vqQcbK6Tw2j4GZjYA1zhBmZ/zAtAtny1XNYDS7bCs5MAJmgepXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3774

> From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > [...]
> > Hi Kirill, Dave,
> > Do you think if it's a good idea if I post a new patch that combines
> >     e1b8ac3aae58 ("x86/tdx: Support vmalloc() for
> > tdx_enc_status_changed()")
> > and
> >     your patch "[PATCH] x86/tdx: Fix crash on kexec"?
>=20
> Yeah, IIUC, that's what Borislav wanted. After proper testing.
>=20
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

Hi Kirill, =20
I tested the 2 patches for a Linux VM on Hyper-V and all worked fine.

When you finish testing, please let me know so that I can post
a combined patch; alternatively, it would be better if you can help post
a combined patch.

Thanks,
Dexuan


Return-Path: <linux-kernel+bounces-403926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F329C3CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4546C1C21652
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A854188915;
	Mon, 11 Nov 2024 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jBeiArPu"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948D318594A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731323406; cv=fail; b=LarVO2J7/607D4aZFhLLBGAOd4lxHRx1kc1WBcxEHBqqfUn+nZMwGDxWbZzzZv5/8apjI4JwWTDhpVFqTC2vRm+ew4W3uiLUMPp+x0GFMvzsuLTs6l2+JY5GESSAUpH1ubMFaavu0fnoyUszz3OP165Ukcstv6J3pe9gQsi+wK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731323406; c=relaxed/simple;
	bh=+gwxI8Ybu6PNGM61ZjXLV7mjhinSz+hrRosUcVaT/PE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JCE89xfmu+sblRKVl/nNaSO5dj53mOi6nbX8kjBP/9oQAifUQff6DegE0YYYtsctlYq2/ptnCoMr1oaYbLHzm2AF3pnr2y+6Zqg6iqJ5eqiAA5HbUw9ttPNe3i6xJpkppxCdMI9rogAgztDfpVpcJPMkAtlkw4bzwEUBkRBZVn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jBeiArPu; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBL7O9xyfJ/Z41QAf9QmYhTG00JXWJMrsujoSdO2a5Ak9b0xU30H992fPfyJMQpMvTzoiWVMTRNt2dUHyD5Y7q4FEE171cBRQkcCs8qO8XTUCvrzcPwjd0WJpwyoQfaMjTX4SW3q4sH9UvPuk7e+EobUk3Kk7GEKQM+Ij2PQH6w7ApSrl9aXOfxOsYfUl29rgYp3bW4+/e+z0+H3+dPZZaUHhIbJcd6KUerC6MeZfeJ+Y4ls2fC8nrXip72ydJENpHs1+EcjTovP6E2Re4EHmm+o+LOz0Tvw7MHDELe3CSUtpNe/noz5oF3DoRLOU/AhMLN1fHYwuZS4EgoMkZExhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKBJpaHI6vnGIX2wOab6zDrsSAr1Pwwt9uityXoNA/0=;
 b=IMsUI3zGs4bggOMYBAK3i3V5V/ubUWr22ouSmAcGikFsFXZy5L81piuKmJ03qITlYPOyrlNRs441v1rkljiedBnlICh8M3jsYk4Nf49XHfakReN90wOXASyUg8gJYAjzPxSZ9COeE7SPeaofoi7nrMpLoXT0M6pyd9mtTr1DhJnJ0z6E95pBkusnA97v7Y13MHBxKkDrg7ZAoR8BF0CToGkBMH4TMQ4hKKarpeiryGUo/ZawIJuSfTpyaq6xG4eFmDwn2P7E5YRZedodi0YSycU0LoBTZoX7rTNG+V+gyswS/KYsfoISXK5/Cd0L4t/LzwQZ4NZ3w+yqkBVwF12e7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKBJpaHI6vnGIX2wOab6zDrsSAr1Pwwt9uityXoNA/0=;
 b=jBeiArPu9LOMbuwCTIS6U7mlMXq7ixhnWZ1Lwh34nygnp/tlvf7//n2/odXGy/KR4Yh2QT56C8ub5oojn4+NNg+Xs3q6RkUTGxDt+v8vJuy9qU8jp7x3iGVRvQkwcxuDBHgz8uDyp4bWqwgu1iiHu66OSn+mpqquM1mh1cRxhlc=
Received: from BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11)
 by PH7PR12MB9126.namprd12.prod.outlook.com (2603:10b6:510:2f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 11:10:00 +0000
Received: from BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::d4a:9dd1:afd9:1c70]) by BL1PR12MB5333.namprd12.prod.outlook.com
 ([fe80::d4a:9dd1:afd9:1c70%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 11:10:00 +0000
From: "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
To: Arnd Bergmann <arnd@kernel.org>, "Gupta, Nipun" <Nipun.Gupta@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, Andrew Donnellan
	<ajd@linux.ibm.com>, =?iso-8859-2?Q?Thomas_Wei=DFschuh?=
	<linux@weissschuh.net>
CC: Arnd Bergmann <arnd@arndb.de>, "Gangurde, Abhijit"
	<abhijit.gangurde@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>, Rob
 Herring <robh@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>
Subject: RE: [PATCH] cdx: constify bin_attribute callback
Thread-Topic: [PATCH] cdx: constify bin_attribute callback
Thread-Index: AQHbNCUtkONrmEN68Ee3ffrn4GE8MLKx6zDA
Date: Mon, 11 Nov 2024 11:09:59 +0000
Message-ID:
 <BL1PR12MB53338C794BD98BFAE5F64B489D582@BL1PR12MB5333.namprd12.prod.outlook.com>
References: <20241111103333.3355250-1-arnd@kernel.org>
In-Reply-To: <20241111103333.3355250-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ActionId=b3f2abca-e884-4793-8b2b-c309d0b1b8f6;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ContentBits=0;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Enabled=true;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Method=Privileged;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Name=Third
 Party_New;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SetDate=2024-11-11T11:07:47Z;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5333:EE_|PH7PR12MB9126:EE_
x-ms-office365-filtering-correlation-id: 37285eef-0ad3-49d1-f6b7-08dd0241622f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?gAwMlXL6NquwbZpGhsf4dqyUvBTCI84udsQNhc86z9vQ7NEsfNuN+z0vBM?=
 =?iso-8859-2?Q?PzqCr7mF5HqOy7NSZKM5Mxn+oNFxNgXmG0M04BpPRlmD6uAusDCXgFLjeL?=
 =?iso-8859-2?Q?H+monYWks1eXtkWl3qsb/uoBHr7eJZCh0cwCOFYJsLfOdKz5gf6ZSQ4Rwh?=
 =?iso-8859-2?Q?2hlbZNCgxYBgszeOL+pHPbCJ2Fc/Zq+M4r0Br/qzRT7bQQj2cbHL3DNT5v?=
 =?iso-8859-2?Q?rC5E48fIC3h14cPT4DrdbhhsT0gNK9Hi5DqU3ae6jHgqRYn3fgLqCGZRw9?=
 =?iso-8859-2?Q?oNGR5swxD+MEx3ApbxI4bt045vC9W1TWX2AC5tlLGqh8zkrBlX2A0J5byO?=
 =?iso-8859-2?Q?AuwvhEJp2MzSAz1tFLFeZTynMA02V12Xb9FnfkKfVB6u4+vZ4xMP4Zof1g?=
 =?iso-8859-2?Q?ifxv3rmF1TN+fwNTNI070FxB5k442Xa0YC3VTESdJfy1oYJAvGDz4xLEqr?=
 =?iso-8859-2?Q?JGABxmUVoRtwoJt4q7aSJi6P8utVu5B5cMmScuuKVB/rN74H0fkt5xOboz?=
 =?iso-8859-2?Q?bVCQWeJBb2b6R3WJ0ica84pdeKG7zS6aMnuwswOpzZutrMzYgswJBRYo3D?=
 =?iso-8859-2?Q?sQRVDVcg5N4wMZdUDLDtJdgSrqFaF9PtyT0goS5vblZcZNtXgmUjVxpbwq?=
 =?iso-8859-2?Q?h2sP4OwzQtmd/CbAJLu7P5ogbbOrsKWTxb+cdcjAWvGnjowLhVl7YMS5S9?=
 =?iso-8859-2?Q?QnJeWg94CLm/mH+7iJYqmd733O7RTLm22OvNbr0r8uz0oyGBjzYOG5/5EB?=
 =?iso-8859-2?Q?rBz8FY7huss1hccBNdYY7sBewy4erBuzBNPIk2ldUTAwxYEhuYs3pxPkKw?=
 =?iso-8859-2?Q?+f00pBR7grQxkjGEoPqPmVzYFjLqRJ3A8D7O8LgWCml5G6jsiUiJ+QU77t?=
 =?iso-8859-2?Q?JwJ2zSjirAZaviHKISlfFFuSG0p0srJl3bWT2QqsZ7SHm5FPadpJ8n4QJU?=
 =?iso-8859-2?Q?WXfHSuZPRmirIQFHYohIfRSMgSLxD44/Q3OuNaiVO7f08RZ5WX1GIdwBle?=
 =?iso-8859-2?Q?OtLniwT8f9/d3BQFmL9wyGlocKfas6VXGKuQB1M27VuKMMA77NEEyeR7vP?=
 =?iso-8859-2?Q?WbXACV1kNq64Y+FDrVWWrxSI0IsNJxxh1/8Nzn0imUHhEiSYO6axKXRcu8?=
 =?iso-8859-2?Q?AROUsqFrcf4oGG9vXFkjWBSZ7gg33RRFJGjYo4bsWM7rueUrmzFZDMGAba?=
 =?iso-8859-2?Q?wUHmZPNb30BAhcZb/Mp5acP5zxoxFjsXjyMAexJtwdG88TevRZ6viSlaS7?=
 =?iso-8859-2?Q?+qH0sCYBrqe13HIZbhiVeXf5siBQc3UoaAfbx1wN31/caCJqlqgZZib4Yu?=
 =?iso-8859-2?Q?0yoc6GucmitvxGFBq+OcJ0/Nm7X0m6iNQncNqb+On9QjT6qzQMBxeojftK?=
 =?iso-8859-2?Q?qNB1btFwFH8lpHKU6xQbtgdKAbe+fV8AnP0USCHSyYuwGmRm5EdvI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?uo+poPbfDBRttf6rPZo3FeZPuGL7B4AF8qLY5L/F/lkbiFkjdSLLV1oP+H?=
 =?iso-8859-2?Q?m4GzFUwUbX71yUeUbFwPeIJmQEzbLbYWprkjUvmUbDF+2bX5rg1F+m60/l?=
 =?iso-8859-2?Q?nMYf5ILiQhMIUnON3s6xH3O0oJLTr/5lsCV4M4bUEDf5TVmxw3PKLqaHbW?=
 =?iso-8859-2?Q?lUs6BGrBJDYfw8W3ctHG7IN3AFoMX8mrOP8PJG/rK72C4tC4Jbz8SMxSZJ?=
 =?iso-8859-2?Q?+PB8OdeoJLzRdBMuhZ3V4hi1vamd94A7e70unU8Vp0qN/IUNSqUHRxyi3y?=
 =?iso-8859-2?Q?Uhb6zFT3TxSLUKPmCE90sfAoWrh5kKKc5Rz+A0h1HkOahRufRgrIDVGIGU?=
 =?iso-8859-2?Q?gYhU9b3shyRI3Dyb/EbfAuyMLbEx3F9IBbzVKLn89j0F44zHqlRKovzEmV?=
 =?iso-8859-2?Q?JYPy/G0O9geI4UI1wj7xQdW3J6GXvGqVPmdkOvXK+MSi7tY+0FHwYI6AQC?=
 =?iso-8859-2?Q?evn7huT7Ly8yW+CGiQDVHnxqrzQoTnuh3DppYTAhBszrCf69lqn7qiugIv?=
 =?iso-8859-2?Q?8cGMFmkuoxv3qHMlkcGlBCkIO8DqgdyAWM0OQhgrm2leU3zqSYofThjItG?=
 =?iso-8859-2?Q?wnU1K3AsEfXtA8TacmgbQ7uppXkK+flOk3abtfQ92k1Or1c/h1gaG0LfaT?=
 =?iso-8859-2?Q?7WamexqLKR6+9uP2JaK2GomxPosC4eHR7RQNGPExdMIQwBfdXJc7iSW5J1?=
 =?iso-8859-2?Q?d2dchDwbgDCHiO52WsvgBQ/v7DhvDl22dZMhTAxFnTINThWOq9PaGpr/Qv?=
 =?iso-8859-2?Q?YLNvNd1jX8h9OsjDpLb9otgLiuIZ4B515WLokRhWUR6BtgvtUGl/Au0Lot?=
 =?iso-8859-2?Q?iI427GCPp7AiZlfh9u3gTGRYndOxqQclT/yNQJe/Am1jOsIcF4qK92sklg?=
 =?iso-8859-2?Q?PoZNey9jXqTrc+JHL3Ds6INIkmFJOd19AfXmEuXFlk4e8h3ZDwUXhVQw3E?=
 =?iso-8859-2?Q?ok3bffRf4M2SEmqwt9fTwbZLXBIoygN520eIwHqpACQQ6E+Zk9WYRPpZSC?=
 =?iso-8859-2?Q?SH08GxbScx0gpqMnyc0Ik+sLuze797SXs4MFcyzp7jg8HEJoflUGYIC5JN?=
 =?iso-8859-2?Q?+BGPELUzdxpylrNDAiELkG0IUYRa6vqyBjV2CUS6ZNpf4/uv/wysEXvnA2?=
 =?iso-8859-2?Q?EdLOSOHpY5TPy1ZrSMNLp/IGKtfhvZk+roY7qPFFzBPjBeOnBvEJFaAe17?=
 =?iso-8859-2?Q?djLOxX4fGPdx9gcYWZkbagMeJ7NPBHcgMEAX03LJDPhhMejw+e7B0k8qCn?=
 =?iso-8859-2?Q?tiUwSPRNV2YKnBlukQc1jJBa9a9a/GwY7taA3L7ao6nxa79Nm5FMypRFpA?=
 =?iso-8859-2?Q?0sKHtWiPSX0q1DSP1BeJYNpIJ/8DAB4qrvTT2mGm1cqxQsHy5KMgm0HEeF?=
 =?iso-8859-2?Q?V/T98gQdKmhUyBwdf3aNmLmyjUTMFxLdJ93f8gp0K8F2U8YWTl5S2yqtDP?=
 =?iso-8859-2?Q?dElFmS07kWCuH//Fvz0uBF6kDUS04N/Lm3nTjpWjip2OUVCvwlx24tLacp?=
 =?iso-8859-2?Q?91KuUZJXqSvbeJYHHK8KNUCnF9yWiHCIXAzAoWs0mXFGEUjHRbmfNht05w?=
 =?iso-8859-2?Q?x28uWzqBsHi8ug/UXrJ/xvFShbtLQXIn7gp+YAF7w9oDTwGq1SNZXaNKL9?=
 =?iso-8859-2?Q?p/5syZFNgBaNk=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37285eef-0ad3-49d1-f6b7-08dd0241622f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 11:09:59.9861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZiOUzVy/a+sRAB92C0hpLlbzykMK1x62IbjgBt7A46clZWOcqbYpPrC5P8AGwtuj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> This one was missed in the treewide conversion:
>=20
> drivers/cdx/cdx.c: In function 'cdx_create_res_attr':
> drivers/cdx/cdx.c:773:24: error: assignment to 'int (*)(struct file *, st=
ruct kobject *,
> const struct bin_attribute *, struct vm_area_struct *)' from incompatible=
 pointer type
> 'int (*)(struct file *, struct kobject *, struct bin_attribute *, struct =
vm_area_struct *)' [-
> Wincompatible-pointer-types]
>   773 |         res_attr->mmap =3D cdx_mmap_resource;
>       |                        ^
>=20
> Fixes: 94a20fb9af16 ("sysfs: treewide: constify attribute callback of
> bin_attribute::mmap()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cdx/cdx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
This change is already sent by Nathan here=20
https://lore.kernel.org/all/20241107-sysfs-const-mmap-fix-cdx-v1-1-2ed9b7cd=
5f8b@kernel.org/


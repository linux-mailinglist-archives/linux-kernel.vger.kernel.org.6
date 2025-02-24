Return-Path: <linux-kernel+bounces-529853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5165EA42BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8DAB188AF3A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB593266190;
	Mon, 24 Feb 2025 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="0EfQDBDQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="BIcUmkqn"
Received: from mx0a-00273201.pphosted.com (mx0a-00273201.pphosted.com [208.84.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059DE25A2D9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422609; cv=fail; b=ngrt2nkjbhusRJMgg+GbrmfdY3IGTI+9Anss03diWndiM0P8CQiYXsgMjTvti2NI2y6NDmCi2BxgCtOfJ+R4ecehOo1gF+hIxWIjcDaoUxJTwgHAmcIbBhKu6+BGrjtvfLV227InmZUnQVtSSHuQyUoVzgowwJhMV2ahckMLV4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422609; c=relaxed/simple;
	bh=WmkB68XW5QgMbfwB37a2mCL5o74IdpBA5vblYYoUiY0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i3vzrTDtwn/UfrwEKgrqD465G9tZrT+Lh8f5c8eg0qvG9d+7e0LXtFgRNPSF+uiIlQO9g/z2didk8+hZpdBV4+N5QPuB70GsdZDi9TgJzyDZVT52seB6QZRiqDp1+zg+BXzJTvwd4EdXvOx7ndaBN0XFRxEC1asuGAQ+np8qoq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=0EfQDBDQ; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=BIcUmkqn reason="key not found in DNS"; arc=fail smtp.client-ip=208.84.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108156.ppops.net [127.0.0.1])
	by mx0a-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBZw2u010281;
	Mon, 24 Feb 2025 10:42:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=DR7E2gJxKNyEH/Cag/zBzbChkG+6y3L8dXai6TiL+mg=; b=0EfQ
	DBDQlsxxON3QFP+RZPgLeMVOplM9TZaPQlb+5HYoIJNdeBHhOv6X6qRwlxUrHIT7
	CSeaOt5uAg0Md/4x9h8gW0JBH/bd7jx+1yH1Id+0CNZP3HO5t70ibBWgp7Flm/4B
	qZaz1K6M1q/wrc6PqtkRw30eTesQqpMDX9iZZwNARB2fNRh9fKMCa0luALaJsMiW
	B4VQc3X+tqNLWOmh6yYbjuncGA4pyqgFBZLBQmLZbicun0Qfy4fSiROYO04vXrlg
	MA6j9WCtrAqetfKdmHlhTJBELgOLu/JZ0Q09qccE/dlmwpZrBWOwHoW2jx2F/1IC
	lB3e+lZAseTBICjlEA==
Received: from bl0pr05cu006.outbound.protection.outlook.com (mail-BL0PR05CU006.outbound1701.protection.outlook.com [40.93.2.11])
	by mx0a-00273201.pphosted.com (PPS) with ESMTPS id 44yefnv3bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 10:42:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0/370w3V0Fynrq3HyxEgwBF5LmiWmEqLrA8YjtVXpeGIvYNwRFl8KC3saASI0QGqXT/Cligjn5GPZSXh14l+MGxeuSGG6cKpQo4zeN1sT0i8ZlJms+r1GyDIUkQ9nGKLxt9L+WO9UVRpJ6Rv/cgx6tXdRynF3Dxy7ATI63O0lTXKBQvuugeSEjY/U57MqTCzY4TgJ4dQf8JCMrE5UR+3NRYDeaAJTamIP7oanXTMIpWtG0J3RSkBtovEaw15eTpgt/PVBjNihw0iFLP704qU0u5htaDnfh3j6Fiqvdlt/0o25/GzSlWF6FLRY4dnjmo56wl2ub5blx5FaLmzc7rFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DR7E2gJxKNyEH/Cag/zBzbChkG+6y3L8dXai6TiL+mg=;
 b=TwlRWMvdh/u4RmNaS9RQULkrJLDAIt5T7YbWP6O1YzEToRFiSQ+FwkurmNmaeaqpDsZjDxRsKtj5RkDt5w9e4+rKIGzbvvXgCMemobvbag7qYZeIC4/LPsYZdROreluHM+wLWni+/o03d+X/39w6PZyle6fEHP9ajX39fB4XTbAO8/ujvlsoRVrpoR6oAPz1dPFgCdju05vRENChumS7GmLlNKXqdOA75h7lkVPSeXTtwUtBu1su8K3lErHzHZlEUb2sTyFB5VE/g9g1E+fOhSCbvkcXfC47afJChTqwuIE5EUqbWoqYN3012Q1cT4ty7q791SOJIdpatcoSp0W9FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR7E2gJxKNyEH/Cag/zBzbChkG+6y3L8dXai6TiL+mg=;
 b=BIcUmkqngeLkK0cxg5EVkGWaYW6ibXzlnpAyhkoWRdhO1rPS+JkWvhV3HV81VVqJgSrl6kv4f+Ie6DkZYlCeBly3EXdR4yKPQQ06Upx/Ej/THhivaUB8DJtBO+LAxcTg7IOkdDFVJw6uhFeR13o1z9aluGRT94sb4Cqjpbjn4WA=
Received: from BN7PR05MB5796.namprd05.prod.outlook.com (2603:10b6:408:e::26)
 by PH0PR05MB8190.namprd05.prod.outlook.com (2603:10b6:510:bf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 18:42:49 +0000
Received: from BN7PR05MB5796.namprd05.prod.outlook.com
 ([fe80::d0f3:44b4:a5b7:7753]) by BN7PR05MB5796.namprd05.prod.outlook.com
 ([fe80::d0f3:44b4:a5b7:7753%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 18:42:49 +0000
From: Brian Mak <makb@juniper.net>
To: Arnd Bergmann <arnd@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@redhat.com>,
        Peter Xu
	<peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard
	<jhubbard@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>,
        Vivek
 Kasireddy <vivek.kasireddy@intel.com>,
        Yang Shi
	<yang@os.amperecomputing.com>,
        Christophe Leroy
	<christophe.leroy@csgroup.eu>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: unhide get_dump_page() function
Thread-Topic: [PATCH] mm: unhide get_dump_page() function
Thread-Index: AQHbhs6JUzjdQDb4HEK58RkZdmu+LbNWyiMA
Date: Mon, 24 Feb 2025 18:42:49 +0000
Message-ID: <6EA7241F-A4B0-400C-B338-C375512727B5@juniper.net>
References: <20250224151225.3637934-1-arnd@kernel.org>
In-Reply-To: <20250224151225.3637934-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR05MB5796:EE_|PH0PR05MB8190:EE_
x-ms-office365-filtering-correlation-id: efd0e63d-5506-43fd-8762-08dd550309a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kZDXlwgVHmztHyos+S28njS3T8YzSexSsutL1QTyzlZBFmhEHg2BdLHIiBSL?=
 =?us-ascii?Q?qwrUXJQtAdAfy2wmjlpKSR4QFk+Jjz7StzgLrdKmwJd5wxPLS/Z1guWgrdzs?=
 =?us-ascii?Q?kUV0R8JbXTcvivYHrwE5gWu6yPfFx6HFCGSTpy2gCmHvSWqjIufrAENCYUvb?=
 =?us-ascii?Q?Z49NRcSoCbkT9uvxtB65rsvsYpjg1Q8B/yD3k5C0wfhjK4ejCpy9KGCIE3iQ?=
 =?us-ascii?Q?SOp3UOuxlv1UVegkZZ0Nzc7mdllXYNVoEyYMl57P0HoprJhtyWNDnFhOoYHz?=
 =?us-ascii?Q?s3ejuUUwvPg/1yzrBTL2oC7nnBSsKspa+0Jn4sYNjCGLx4nKUoOrX0W04+Uw?=
 =?us-ascii?Q?kbf0rGsucuXIRj3FbhqEjBVxpESQDJMqTYnOFqqBi2aJy1oxMmc7L+hW75jQ?=
 =?us-ascii?Q?ABzG8ulc4VniH4X7YPJErO6S4ojAfl6de7dd7yjnKYyaOwiw8MRq5TMxi4Dk?=
 =?us-ascii?Q?PKibEiB4gbOxtdJP6Us1w2NHn1ep2mnyNi65cDm0S2/n81XMHi/lzfe2d4TZ?=
 =?us-ascii?Q?xfn1f2g1tD7dSn5t1ZrwFz5BTzz7bqMvdOD/s9EcIhph8lV8YfYH0kKZ7QX5?=
 =?us-ascii?Q?5KXyJAnVr4xkLNE0GzAlDwT1hUTaVupjZn6vNnT7nGRRNoyPaH/C1B/vfSHK?=
 =?us-ascii?Q?Btx1rkXxVn099wibGTb7FZAFfW1SZjC4m3z6o3M9mwPfMHGVKRugr3wwn868?=
 =?us-ascii?Q?9iESwSYKhrm/mlxDT/htRQgpwnya5QRkewdnDyM2Y9VbKrtzUdBrrPAnyc3X?=
 =?us-ascii?Q?EvAHawNipOGiJ80/tA8+Qu4FsyylXk63oEpOWgrEEXlD7gVsu6K+j9iaLcfC?=
 =?us-ascii?Q?juR4rn8aHdLa8Os06DGmKeg3pUc+Yq586n+vKHJ17F6s50T+47VkPUb0v/0I?=
 =?us-ascii?Q?tlMNRuOo54En/MuiN6LQVEfulAtlo/ne7eUWwJrw0qRObrH4e28FAZo+MUvk?=
 =?us-ascii?Q?WjXEK1kO2h53mxfAYJFEgJ+11m9dNSvcoXQnBBdpYlVkVyX9bocaC5886IZG?=
 =?us-ascii?Q?sAjlaBmhTvsQCSHlgK+v0F5OWC6LpeeAnYRO0fUSddhdRRAflB7LL3SpwxfA?=
 =?us-ascii?Q?mBc0fGQYnxrTj8uus4+NITh5TViTCPo5CsPUEPv45rJqkrY22k2sj3N0xb8/?=
 =?us-ascii?Q?4/G7inj7mygFvvQ8N5CimuqZOfonPRzJiY+9PMWrvSY//ejWco6wZArYmJK6?=
 =?us-ascii?Q?531ZXo2ZzksAoUesGI46qdpIjTO93JnTsn5iT7ztdvzATrSL2vUlAeyX6Ulz?=
 =?us-ascii?Q?pmC8BmjoI0ehmNNMLI2ydnhMyJ7Qc88/jg43FDnhFQwxpbGP1lUyKVg+IwG+?=
 =?us-ascii?Q?IuBeKpMoVMW7yP7iYXoNO1kpBhGYcxFe6Xo6z6VaZPgBh67uYw74RsN+c5dF?=
 =?us-ascii?Q?SfiLFhlbQY+USB/i8w3l91EwsYMqy9I+O3LhX1shEOdaJAe8OYcxOVAjgyhE?=
 =?us-ascii?Q?ybpoy3dxegATP9CoaF31cnRsJO9gv2n9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR05MB5796.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?X/rlilVb8tptqDnaaFmxj6xteI4opFVz17rKruP42QjkosCh7xH01kH0wi4l?=
 =?us-ascii?Q?zXYfX8LSXQgUDkF3D6lfqELeB/jjx8fAYmSmO7NdrKcLCVITlOgvjcrcamQW?=
 =?us-ascii?Q?Pdgl3EDNBe/3Qdo97canBXIwM+Pn8AKOu9E8a4YhAUZdIzFi3ssI6Vi0k9l9?=
 =?us-ascii?Q?xpjGTqI2JHocv58TcnmTCB0UhGS3qTgNBmm5KUMg75lOZRC0NK9VxxB94yB5?=
 =?us-ascii?Q?15MLk9IhEFK5cqqVNnYZK/m+Mc9pioS5QprIneuKtumDhTqHnqDJm/MX7x1X?=
 =?us-ascii?Q?6SxOabNxxpWdTnyHYXrwABqv0IH03gCHTc8bV2ERHr+zXLGtaox3/bTWSzyt?=
 =?us-ascii?Q?M4JbzKs9saZxF6oifdlyKf0xHTSMG8DdGmn29V+Z3iwpYUu/53vn2XITZeXW?=
 =?us-ascii?Q?V7vSNRIcDbT6cwXwzyiKbE7quV/C9x88goGyxYMT4s+EruISIrm0iNAB84Zc?=
 =?us-ascii?Q?ZqX1+85kVDi1LxpFniIYK/qpaqFx693oqbWH0/3585cDJRcAX/Fw9A2Mur9/?=
 =?us-ascii?Q?+xaoCTcApPnCQiatSgrWNK9VvnX7FE/4Tl+LsWGOVRwY57/wP2+I9euijuXl?=
 =?us-ascii?Q?064CDbeDd/t0iOMXMvc7e0Nq2qU4jb/dTOXElOtMr5KMdtXpVN1CjRwdwIZd?=
 =?us-ascii?Q?pqqjQlSQJP/EAzk66I13Y+kBiPItpw8NWVa694gQacivSqTPyQX4Zm+2t13k?=
 =?us-ascii?Q?o5Yu1bcIbcfU8MozUA72hNDrRdPNB0DJXzYVCgHr8J+0lhWGFdDMBVo71zpN?=
 =?us-ascii?Q?W2z91kGMjS4Z/af3I7lQ7xfcnD2gdKAhCYXOEA5FpRNMigMe2N2TEA03NivF?=
 =?us-ascii?Q?7usMJtgIf/zt7sJ9/uX16w3I+h2I/gFKnvFZw8LEUyA151grh1ofJXZVTDEg?=
 =?us-ascii?Q?5pSAnduBQWLfqw1hMGjQ8bRcijNjNM52kNYhw5B3SoaK/AaKs6z6f+Ofiy+I?=
 =?us-ascii?Q?dh3IzEbJYBPdTu+CrYbTE8BGZKq4qUx8xaM7Bmvl/xoa2PHCd2dHLaI0Tf75?=
 =?us-ascii?Q?4XbUSkTfw8uZJjJLK+AKtVC2LiTCil4Vf6VR122rBmql7+pZWaVH9rREbaz9?=
 =?us-ascii?Q?IFK632ZIrSOz0s0yNun0SmSlva7tW3u+OfycjwAB2mwESpfcQl8OJifz02/+?=
 =?us-ascii?Q?Od+PlhC0QGWvsRbYD9FmorFs+z0BG1ZRuM2vTaFn1/opYSD6+LkwV0OtnWqn?=
 =?us-ascii?Q?ZfNM7qgtLapBArN8InBci6GDxL2zTu5WZgUnC3NaJThG5LfGTjViwaFgHluz?=
 =?us-ascii?Q?pOvH/k1w4Y8QgU1AIK1JR/qEsRn7i8r9A1UkRANq2LKhx20F+Gg3oM/2T10m?=
 =?us-ascii?Q?UG4uZ+FPmk4L471FrpsGWpkuCotkoGmnOgLmOxguqQJHvsSqh80F5fTcJfai?=
 =?us-ascii?Q?neyVOoxz/2k1Z+wlZ0XalgYTNOn0FqvMC5VZlPH85UasG2qp4e61VX5aLU/1?=
 =?us-ascii?Q?SS2WDlkq5qUDfzTAOGZh41dAbFVjaU3NsPYWkiv0i2Z7corei10MAN5QFeZC?=
 =?us-ascii?Q?3khrtUuc2RrKjxWxTtn73wt8pVvIjv15e6UdjokC1utdaAYUHTkuGPFnTUcD?=
 =?us-ascii?Q?fr5tGD0fZMq5/QzfgMgkdkO1j4sYyL5crRYZmfdq?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F46082182A599846A7A7A34B82804610@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR05MB5796.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd0e63d-5506-43fd-8762-08dd550309a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 18:42:49.0996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s406vcoJfkxC/UlAQTUpN+HbJwOjmVmP//YrHfEIL3J6u1xGky4fLx5qv6pYLUtaafZU140WE57xFYUNxka5Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8190
X-Proofpoint-ORIG-GUID: BJYyZtJywjx6LfJ5hnRZPMCCAoErNw_k
X-Proofpoint-GUID: BJYyZtJywjx6LfJ5hnRZPMCCAoErNw_k
X-Authority-Analysis: v=2.4 cv=d6gPyQjE c=1 sm=1 tr=0 ts=67bcbdaf cx=c_pps a=XJbScVYJ+YTk0JuXi+vtpg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=rhJc5-LppCAA:10
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=JNUQPAuAIVO3bTlgzGMA:9 a=CjuIK1q_8ugA:10 a=VYcpXjmDHnEIALPoEwzu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502240122

On Feb 24, 2025, at 7:12 AM, Arnd Bergmann <arnd@kernel.org> wrote:

> The definition of get_dump_page() is guarded by CONFIG_ELF_CORE, but
> the caller has now moved into a function that is built based on
> CONFIG_COREDUMP, which leads to a possible link failure:
>=20
> ld.lld-21: error: undefined symbol: get_dump_page
>>>> referenced by coredump.c
>>>>              fs/coredump.o:(dump_vma_snapshot) in archive vmlinux.a

Kernel test robot reported this issue yesterday here:
https://lore.kernel.org/oe-kbuild-all/202502231914.ROOVWMZN-lkp@intel.com/
https://lore.kernel.org/oe-kbuild-all/202502231818.fP8cuxmf-lkp@intel.com/

> Change the #ifdef block around the definition to match the caller.
> In practice there is very little difference, as setting COREDUMP
> but not ELF_CORE is not useful.

Good catch! I wonder if we should guard the sparse dump size calculation
logic from the get_dump_page() caller behind CONFIG_ELF_CORE instead
though. I guess the question becomes, will we ever have a non-ELF core
dump format that won't skip zero pages?

Anyway, I'm fine with this fix as-is.


Return-Path: <linux-kernel+bounces-352349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEE3991DEA
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 12:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76C6282950
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 10:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE93173346;
	Sun,  6 Oct 2024 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="hMw97rDc"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46D213E898
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728211493; cv=fail; b=YTlIqpRykaziRuAwosaKGCSJW5sCxqkieADds5ME0Km48d2yq33X4EPbZHDhUesqsDwwFBfPT3rohxQ2Uk17jZ4wqsVDt+vV8R98JR7wNdaVDqfGWWbxnL2/pi3l9+XZsT+Yr5vhbrM+utJpwsnzhPqNJUfQuN+jmzkEzpZ8LCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728211493; c=relaxed/simple;
	bh=XQ4jPyt5+XPl4NMRfpxTWI3ko+PHppAau/kmj/l5TpQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bx/0GXsVHXzU4qjPnXOZCLf0CCE2gKdMt+loNo3+2t2uz03SBSVTvbO/3wd1M1Q5UluD9NwpYt8ebfJwLab5svrKuNKaf4C6eEGkTg0fezhmLH5d6pl6DpsJ3mwZ5Rml9voI70F+zEVe6S0pki/DjQl4oR9tFHtWbH34Uog+HqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=pass (1024-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=hMw97rDc; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhAVCxg674jiCfcLdMfjqOZfJPo6ofBqQr4lbJC0UE0cV7DFgBbvajT5GFrOQ9PhzmZWLrgeN4OFbYaX3ZMXblWjD+UGbb6MkDbG68R1Rkhw6XirebCfdGklSDo6LwQ50k1PSK+mFb2CDOlPKh/2koSQ87Ql7JUiaEHHFQssoIgCLolvgC59ph3lZZmIZz4/dFVoNntQY3IlZ6WVBcZbMJDF1RpqpwYulrg7U1xwUSk87GXQV2oCetk72IORxHT1kKEIPnpNMKN0BUUnQcwsU2bOQVkXS7k173P8p8RM4kD/fVoFKy+WwzgjM3Q9rhyQBa+asSygukDE17B3di/jfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQ4jPyt5+XPl4NMRfpxTWI3ko+PHppAau/kmj/l5TpQ=;
 b=nuyeLR62SjSchg562+h16iQMmrem8wFCnZ2UQnV1jkWmcYPilh6zdesGgT7EiGSS3mzpr9ooUnXsDB8LJkbha+fnbXveaCfKIsJGXA88MkF/0pYKgQwb6azZxrIvyXg8T+YcUkWDZ+KZrayjJqkKbvYAHcUMQEdVXR4jT6vT8S679mb84XeFMM7Nz4bOTLgmErbE6YH9M4SBoIKrjp13o9SrAACux/NREEsbO/Ccp62zmPiI/skpjJgJNU+I+th2qAWyIwqMutBy44gVz9TL84KsTDwQ6NUJXgAMlOZXYQbItU/YvWwZbOv0+UYCa5lhZ+zZAXxMijKlRVzKYyWpUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mobileye.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ4jPyt5+XPl4NMRfpxTWI3ko+PHppAau/kmj/l5TpQ=;
 b=hMw97rDcC+p1yfC1l9UpBLDawUvZ7etyRCaMAlbyXHhAX5Cl2x20T2Zvhz+Q6LI+AdbshAvliLdh7hPhnzf6SeaC5opaRkojwiNYfrNSk4uvOqb7etFVJANH50X8I7JqsTSM1Mlah/K7hG8OqKFrbEaaIXfboR1a9kEXYjpCBWQ=
Received: from VI1PR09MB2333.eurprd09.prod.outlook.com (2603:10a6:803:82::16)
 by AM8PR09MB5399.eurprd09.prod.outlook.com (2603:10a6:20b:329::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sun, 6 Oct
 2024 10:44:48 +0000
Received: from VI1PR09MB2333.eurprd09.prod.outlook.com
 ([fe80::fef9:cf7b:cbc2:d3b7]) by VI1PR09MB2333.eurprd09.prod.outlook.com
 ([fe80::fef9:cf7b:cbc2:d3b7%4]) with mapi id 15.20.8026.016; Sun, 6 Oct 2024
 10:44:47 +0000
From: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
To: Alexandre Ghiti <alex@ghiti.fr>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
CC: Andrew Morton <akpm@linux-foundation.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] riscv: make ZONE_DMA32 optional
Thread-Topic: [PATCH] riscv: make ZONE_DMA32 optional
Thread-Index: AQHa+HVuldY7EPjBp0OcGqR5BRwxW7JwTNYAgAl6fLY=
Date: Sun, 6 Oct 2024 10:44:47 +0000
Message-ID:
 <VI1PR09MB2333FEC324AA0B3E5F1D7F98947C2@VI1PR09MB2333.eurprd09.prod.outlook.com>
References: <20240827113611.537302-1-vladimir.kondratiev@mobileye.com>
 <e8f6ed93-d47c-4c07-963c-8f16f498abed@ghiti.fr>
In-Reply-To: <e8f6ed93-d47c-4c07-963c-8f16f498abed@ghiti.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mobileye.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR09MB2333:EE_|AM8PR09MB5399:EE_
x-ms-office365-filtering-correlation-id: 2cee973b-051b-4e1a-3e32-08dce5f3e5dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?rNgqgzfgIe095+DxsHS6BrfOFo7TwLAuh2sNnAxf6I7NH1s2/y5utPNEJj?=
 =?iso-8859-1?Q?n3X4VjbuRjTpP51BWjMFQl1/EMYF7rZsqONwi9j92icVy7OE1wa47g19Ib?=
 =?iso-8859-1?Q?huzQnV4pty4KF8/4OPTmXJ6A4nlNaqDnneInpZ7+nE/6HuvrxCiyiBfyyz?=
 =?iso-8859-1?Q?uuJ2ayEckyU7wStJDaf/XW1DJMLZRkbVTD5XwPYgcBwBdINUKMlZFMYLVS?=
 =?iso-8859-1?Q?dwK32XxLVU4GBPlmXnGqNFBtn2K8zh7JwEBaTH8nAMxx+p+mdzHWwCxwJZ?=
 =?iso-8859-1?Q?Se6Uil//QxbmPvW/PUnZSQ+mdbGB3oqLJk5voVsSg+D9LkLPFzqaQaPwI3?=
 =?iso-8859-1?Q?GJTRs8gEvCK7uqpDfD6mOPDRYyxoiWaJ8ObaXD0SK9Eb2yRJKtKfoMTHUG?=
 =?iso-8859-1?Q?PD+rOYa1NsDwBl4IegBBCeTEmHuYteSCPAKpLPTvxwYNenOrkVxlQYYIop?=
 =?iso-8859-1?Q?eySq6tJu+3F2OCJ6GlLf83771h0UqA/VRCnAyHkq01CI4pnWSgMLRZE7hH?=
 =?iso-8859-1?Q?WqVd4rnKR8NxQw2gOn7S0gHuqgnVpIVp4vbZXSiL/w7LWEF6LIhJM4SM8a?=
 =?iso-8859-1?Q?wBWRlrAr45vy8r5RFAaU8Qw+tb/RFjBoONmv51UIVFkWeweWDkCiBMKzG+?=
 =?iso-8859-1?Q?L2lHbYTtM80jEKH0dfaoQD8/fHIEq+s7C0v8DB8Pf7ehtm9ONOLX/ODbAU?=
 =?iso-8859-1?Q?Rtfv0fRLwIw+OQKLjZcrlhNZ7eIvv6WK2k+QWwKJjkyIbGbA+sDqcS7vXD?=
 =?iso-8859-1?Q?tu0varuerrhoH15MGfusxEwhr/0tNGBDl23P8IXOtl0IX7ld5MYnUu7qps?=
 =?iso-8859-1?Q?7jPYVVnsZKF9H7GuUtUJkVfxrlBtP3xkpFHUHR7bBGb4/wJG8uTLkkc/uD?=
 =?iso-8859-1?Q?cVUCt68s36h7VOhYGd1j+/Smn5gc3tRb9cbsVSl6dK0g4NNexT/MwhZsKv?=
 =?iso-8859-1?Q?kQPCRErY6kGaKOMyRPwSJhCdx8sWskNyLJ39wKhCIf2t3IUHYXxqXqsx5y?=
 =?iso-8859-1?Q?0idZutXeV9OXzt6IY7QZIjO4B+fGcy2jiq4mBi5WJuQiZd1DpOD99ZzcCM?=
 =?iso-8859-1?Q?fW/CUY3u8zCRUmjl+L7OB2/if5+vsGrLzcPlmKC1xR2XSqg2ftwYSNQS8A?=
 =?iso-8859-1?Q?3zcL4UvZglC7QouwA5FN3VyYF49UJPnqD4Oe+yCzKWtDs9YUTa/4kAPFYv?=
 =?iso-8859-1?Q?mm34Pyx4+BeCoMPEjGeYy6nMkM7ejgzLx+sBxjQngFSuthRYIZdqzJezRX?=
 =?iso-8859-1?Q?MKTYd9jDsL+1ht5JghW1pRu5j8tBTOkkUu6ftjU4HxMYsFL4IX4ezHmla9?=
 =?iso-8859-1?Q?eGS+Fl1d79YJvsNnHhdjb1tsBFHEqI0B9LRB2sFYDasUSsbt7ccenhE7Lj?=
 =?iso-8859-1?Q?54lOcM6MoAxuqvxT741PYRGjy4Iaewvg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR09MB2333.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?smhse+MB7QkMUMpIy0eo6AGcbvmxQql5Br57mC/v9eRDfPSLUpIBwRk0AP?=
 =?iso-8859-1?Q?44CGM4ftsE2ESeuo4RyRTLhUOmyVqZWx2cheQyROfZXZV6kFrYY6t8emmj?=
 =?iso-8859-1?Q?YRJ+Zv08uifR5FAghkX6DEadO55YIkCKBi7xhdqXO1EKksBdqVqWTX0LEr?=
 =?iso-8859-1?Q?NpkQNAzeiKiVpZA4OEozovXBSmfPbeY1buwAYoKyBnPDUAK509c7D/oAbk?=
 =?iso-8859-1?Q?lI2tJpbQGJzZf9SItVW/6hS/ug83TCKC7ya6J2Yw4/9ZSfK1lRN+bJLStf?=
 =?iso-8859-1?Q?p+fbd38jWqIL2ENSNyF8zZ/DoaayNEVgnDjIiB2Bys6xokBZGGnGGAQLi4?=
 =?iso-8859-1?Q?v08MKoBbCtFrzZFKcuMOCScOoHSITo83QSVwkePvzwQ+Z1TCpQHhaE8otl?=
 =?iso-8859-1?Q?nDJ/C5u4EPpteN/e8DsgRgCjKUcIL8WIBjwE4J5IV7OmflQr4cNv6JE7rg?=
 =?iso-8859-1?Q?plNWciehfeyF4Uk4oFvkC9wemW2BIrhU5tvO2YdKvEjokoC8DFwU8YidCt?=
 =?iso-8859-1?Q?tqZ9chNfJmpeGWhK+9falLcyTDP2JCd6oJ9LuVRDa+aqHvmrO9RaisAbJd?=
 =?iso-8859-1?Q?R8asJMrmvQlIEObQDLIOI3y1o2Y8reVPWN9mHwhcIK4Nw2T3q87dOEWmpa?=
 =?iso-8859-1?Q?fpkRA3Qqx6/5A8nY2zF5/jstBtCvQoX5W8EBvHtFnnxvWG5rwOgBXZZzrQ?=
 =?iso-8859-1?Q?KzR8uBJT3NaF7m3PT6ZX54Bm4xzDyLS3u3ayJzpgjjBzXcfEfsTrFUK/mq?=
 =?iso-8859-1?Q?/N7pZCJTguL73KGIa+uLO3EO5rtVHDUVEgcLZytGrN5ZzeXVEVxIkUctNh?=
 =?iso-8859-1?Q?6zY9M0TY/5Z6yGWK/JX5Nz/vAmSkwVpWPet4h+uaOMI52PzQkIs19Xl8c7?=
 =?iso-8859-1?Q?et1gyK8UNzpSJRKcZARVvRIFxzl8VbuWYyrraFJM7FsxjOOvedfHT3vQXa?=
 =?iso-8859-1?Q?KpMWc6jAlkJBx3uMbOGgARRnLtj7U/0HXJZiScG18xpUuwlVVosQWoTXNi?=
 =?iso-8859-1?Q?yVegRZUmkqbRkwDLfIchgQLg7/31b0rl2fJMboIaDCw9+ImsLXg3ZG5QJX?=
 =?iso-8859-1?Q?OI0A3sd8NMdP9e+ZfqcV656YCsr+DjyiqUo+S5wnWUDc0fZX1M1rZABt1s?=
 =?iso-8859-1?Q?og4JNnqzZFMNKk0oX0f5mgK6+hdeh6pqNqQ7KXCbYMdMSoSrVm5VQ0ovz4?=
 =?iso-8859-1?Q?9qj10crQLmLXGwTmSKdAnx5NzGp/2gl7aB+zvBXIGXz3XYtBgL8s7wnTOC?=
 =?iso-8859-1?Q?7RxIH1dmvk1nGqDW+cAOinPsNkrxw9JXZdifaF0kq81EbAt2/1QPFKL360?=
 =?iso-8859-1?Q?wvtWTvJbJYJiSOiaNYLgrYjbl0WDYDQDK+nR0+PXbUMtyIKyyKtdoSN/Vt?=
 =?iso-8859-1?Q?DByDD+HB+GrGP5rQX7LiSV9d1wWTE7Jrk+3Au0LxiEGV6rya7oNAQvYFFc?=
 =?iso-8859-1?Q?DQmu6zRysagAqqRNTyXYI0E2CyatViVrQ9jRjHAJehpL8klkVc37z+FWW9?=
 =?iso-8859-1?Q?Y+fiq6jQ/3UBrckLpM4JAAqYU6GMoLSaOmebXM9ikvmMg6MwAfQbT9awOa?=
 =?iso-8859-1?Q?M32uvzUUyhbEc/JqyP0vr3bjk/cQ7jHq4l2g7edhhHbBS79/SkM9gDlXDX?=
 =?iso-8859-1?Q?g3J5ydmxnJWHibl3HJeNgBYQQeuEIOw0ko?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: mobileye.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB2333.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cee973b-051b-4e1a-3e32-08dce5f3e5dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2024 10:44:47.5755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7eH1AnLg/Ce7GldulKee0QstVpIeF9fAaAyZjWc+PlUkREqBXXQDsZIizCfgfKvlyEBPtzJpjhuO2FGwu935Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR09MB5399

>I'm wondering how distro kernels will deal with that since some=0A=
>platforms will need the ZONE_DMA32 and some others will break when=0A=
>enabled as you have shown.=0A=
=0A=
I agree platforms with no ZONE_DMA32 is non-portable,=0A=
to address this I will add dependency on NONPORTABLE and re-submit=0A=
shortly. Thanks for pointing that.=0A=
=0A=
>Is there a way to make it optional at runtime instead?=0A=
Unfortunately no, or at least I see no way to do so=0A=
=0A=
Thanks, Vladimir=


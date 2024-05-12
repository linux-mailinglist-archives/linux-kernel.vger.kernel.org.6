Return-Path: <linux-kernel+bounces-176791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459888C34F8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 06:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500B11C20A01
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 04:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB90CA62;
	Sun, 12 May 2024 04:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b="G3jg7ck1"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2113.outbound.protection.outlook.com [40.107.20.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487BFC2E9
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 04:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715486862; cv=fail; b=eccXpSs4lKbe/AgqL9rNT/YNNVe2ugOejYpMT9038pnPgpkwD7cSRn876+kblWyd+40B/Qq5AgEfD9eZsqkmFlAVhmqrKuKTOr8QDBYKxDAsEBd3WYcQCfy2MsZrwBm9AVwwk0K9xqVrAoztGNFiGGEvx4+LYwPRlyJAXqih184=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715486862; c=relaxed/simple;
	bh=NMDz1CgKM55Vy6eBbkP2hbNpn2tFTFuPaKOuOIyfNJM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ujMZo2GYvZiRaEbqILj3K4VuuufohTgwKbEqYb5fu3GMkwg+vZJVWmx3hrGPtl2NsIfFQPuwFfqnn+/RtFBp4jNayonqr6DZLdKKjUF7cQp2SYqWHfiWWpbTUSnhgny4U9GDw5Y9GtqYautiPa+zvgN9ueYI8DN/3HMFzJFnFGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it; spf=pass smtp.mailfrom=santannapisa.it; dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b=G3jg7ck1; arc=fail smtp.client-ip=40.107.20.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=santannapisa.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/APHsaQXDke2oUmTkYepHY+KQwlQEirCULrkkBLfwbYxid8DuPUHT6KbI7pGvJ3nG7ACz0WaimNppAp6J9e2K0PPifdFfeELYPsKlBs198p8WYhb31/CqR18uMOl55VKlXOn5g8Sc0nt8PNgngTZn3yYMySCeh56UvM1FTmVJJa9dqlWJXRvUJ17cpVuRgwqpdSF9mxtKNFp38AmR87Jzoob/JFTiUqdEXYHcoyJw8To3izb1c1gydkVyPL9sQ7Hx34qd48cWnQc6aq4tctrjDwmvZ21ikD1Khi7zpcXJFq6PVssYPb+IQ6UlTuPlJkYAAqerWw2j9m/EvT/UdYHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMDz1CgKM55Vy6eBbkP2hbNpn2tFTFuPaKOuOIyfNJM=;
 b=YzoozginubsMMZBC0bR1reBqxE+HjNc8NJG8/ZLN288oTsvtnBt08FKuOEa0Aj0FF6MGQnZXH/CT63uV1FfEJxFuS3o6epC7/9GH1wFP0TqMbUBu9Gq3TnhxxwhhINAXG6k27sNDXbQV7hKLaqv6UeSWbAFUd1TVsBvwaTndlo3WicVU9aKcxOoGqpb9hOFzoftPPLCzmIRvxE8FS1zlLsDFboXABeSyguNMr5AbttOUlMHUny9PVzm2gGtU/Tt7fd7xb3Sgk/6qGft0T+FLXWGs5MIftqUDNYe8n5qWzR/uJ0pGsWN7KyzzjdeR4aVlmjGvXi14aFr9M8aYDvZXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMDz1CgKM55Vy6eBbkP2hbNpn2tFTFuPaKOuOIyfNJM=;
 b=G3jg7ck1gIba9DkJ/7irpwpi2Ckz4FpqKwWF0E+oumIGSfNFMcpBDFYlNOW9oc2MRlNybJFttpgGiWyHF2C4r6RsQ9Xsl6kNxCb1eqdLhAV1lp522fXeSo9MxEh/tG64c/irsRnloloc8044caL54oluVIfHUokm4IFaiQWcS5Y=
Received: from DB6PR03MB3109.eurprd03.prod.outlook.com (2603:10a6:6:36::30) by
 DBBPR03MB7131.eurprd03.prod.outlook.com (2603:10a6:10:1f4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21; Sun, 12 May 2024 04:07:35 +0000
Received: from DB6PR03MB3109.eurprd03.prod.outlook.com
 ([fe80::2f0e:5d1c:af40:b510]) by DB6PR03MB3109.eurprd03.prod.outlook.com
 ([fe80::2f0e:5d1c:af40:b510%2]) with mapi id 15.20.7544.036; Sun, 12 May 2024
 04:07:35 +0000
From: Remo Andreoli <Remo.Andreoli@santannapisa.it>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RT-Cloud 2024 - The third International Workshop on Real-Time Cloud
 Systems (Extended submission deadline: 16th May)
Thread-Topic: RT-Cloud 2024 - The third International Workshop on Real-Time
 Cloud Systems (Extended submission deadline: 16th May)
Thread-Index: AQHapCFQYLNBUij/lkGva6YrrGNjabGS+q0sgAAAhluAAABMbw==
Date: Sun, 12 May 2024 04:07:35 +0000
Message-ID:
 <DB6PR03MB31092BFEA07904C3570F5E20E7E12@DB6PR03MB3109.eurprd03.prod.outlook.com>
References:
 <DB6PR03MB310909DD2065C7C65AF0ABD4E7E12@DB6PR03MB3109.eurprd03.prod.outlook.com>
 <DB6PR03MB3109A4B998D67923422CA515E7E12@DB6PR03MB3109.eurprd03.prod.outlook.com>
 <DB6PR03MB3109F319AC45E84B378560C0E7E12@DB6PR03MB3109.eurprd03.prod.outlook.com>
 <DB6PR03MB310998EFF51082D702A82C92E7E12@DB6PR03MB3109.eurprd03.prod.outlook.com>
In-Reply-To:
 <DB6PR03MB310998EFF51082D702A82C92E7E12@DB6PR03MB3109.eurprd03.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6PR03MB3109:EE_|DBBPR03MB7131:EE_
x-ms-office365-filtering-correlation-id: 59e491f0-069f-4fcb-b587-08dc72390e25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?JIUpoyMJxs/YsQqVNFkI2Is0UzqykscpeZFM8ybSkcHkl/QjzKhGsrPzlr?=
 =?iso-8859-1?Q?NguEsje051P8CgZjOfYkACjjQpGaG9sn+XmC+x+CzB7rz/CilIiz6yS4Vz?=
 =?iso-8859-1?Q?RlXSbuanTpF5t8bQW4zumELxWTGTIcpc884CMn1AmliyOG6G7D9Dj8wkc5?=
 =?iso-8859-1?Q?znaxVVNFKbXM7aKt3uQAfrY5DJvvcq9VCiCjIQ1AfgJkh/OsV6FMw9Urs/?=
 =?iso-8859-1?Q?DyXTSisp7ccSRs0J2bKEKNzpq2ItshXbmCOZwYdtlafzL2NUZu2ccQxTiB?=
 =?iso-8859-1?Q?YaIzNFMfo2ybVZ+sAKG5P9qt5feveHjgFLjrLfHGbznDWKeao3cbC6Vzej?=
 =?iso-8859-1?Q?A5CIobGLJv8zVFVjEDWRjBOeXFuZksSYBFX8LjaQWNAozHVWB8J2AwTT1g?=
 =?iso-8859-1?Q?PQpzrsf+0p2g/9+jRJ+hqkkcw0RrDGL3E4DgSb7H+2s5vayNIoT1wUJbGx?=
 =?iso-8859-1?Q?l1Et1mDvPgue/nT7hir9TfnZvsdOCAujyXgk/bmH2HtT2xcAxkUW/A+uvg?=
 =?iso-8859-1?Q?QTVP/p7dpex5p6AMXFkTHWZayS7MEa5Jsk2SBrn/G49NIY8G4Z96H7tXkz?=
 =?iso-8859-1?Q?DJC3RUOL7cy9HcmDcum/gLKXR/J2Q35EUEN9QTVvV3u+GSybMCjGi1VaRW?=
 =?iso-8859-1?Q?LWESK6jRbReY2h3LjF8qbyaDK9MYQ8Mx7H0fLpy7dIygaKHSZopSKnGyKi?=
 =?iso-8859-1?Q?lRtrXSBWO95Vc/UzewZCAiKW9V0LvZL6RRad1iuFAX1oGsb3pzmxm3vigw?=
 =?iso-8859-1?Q?dRpbk4fjbiP7urVhnuTQ5blBKk0nPgb1qMpi9jvcrMUx479vnlQaXV4WA6?=
 =?iso-8859-1?Q?C4GEjg63If0IvMhiHr7miYv0e2YjM5KvBsWaQ9QxMPlmxyZwHH5m8FkXns?=
 =?iso-8859-1?Q?0OYh6uXsIVjpJUXJYt1EGJx1xd5JB8MeKcolRWI0gDShn/TXWBAE706swX?=
 =?iso-8859-1?Q?OtDGiqEavO21Qcm+G2esOTAgh8jH2mdNzgYPODRMJkz6zNQghPkLSnlieZ?=
 =?iso-8859-1?Q?WZFcS86L8dQ0UGRBiW1pozRujj0aBtmPZNGDK++B1RW5JAb9pIpIjldTz2?=
 =?iso-8859-1?Q?bpFcxFBQ12W8mdzHd5woEYKU6ujwTsxBQYcJFwjoWFvDY/1BbheqmdOyLW?=
 =?iso-8859-1?Q?FqopE13f/j73IO+QhA9jXSNrTL1ooB2qsGcbJtII/xuHncWSsNcZdQZ8ZY?=
 =?iso-8859-1?Q?JAueOwe3d7c12FiJl1LT4rTA7cnfl6GwlJqr6QWhUMFLXfep02CH2EIlDc?=
 =?iso-8859-1?Q?brYWE/Gv/YDNwRHicc9EvZDhyd0nuRZsloS4k/zoIE1MQ43ydeVdGyIu8E?=
 =?iso-8859-1?Q?wbfrGwAM3nG4Gf+ugR9Z7k4vDg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR03MB3109.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CFAb1AFHcezw/dRgYJy3Yz4/PbGyvI/Jr6QzCq7q5PB+MUMVB6RkG/pY4O?=
 =?iso-8859-1?Q?Rvst0vb48NN26ARNX0l/tU4yH8iln9aix1VLFbmV2FJSrn6/YrZgdoCVJ4?=
 =?iso-8859-1?Q?PmjYUCaDjh1u7x23W+CxpEUU37wEaJWfE1y6MJxZ/dtNKdXro+lthh1oy8?=
 =?iso-8859-1?Q?HV1QJOBQivvO9RRE/AsHFWhDbnXdV+KjdhgeRDA2xRksAH/3Wr4/hgkH9w?=
 =?iso-8859-1?Q?xx5yxpGekjxlxOQTBdEio0DaMxazgRNNBXYenWqtz8dFz6veU1Inkg/C/m?=
 =?iso-8859-1?Q?/CbOjlSEcG5HjuCMMBtNZuwz8fCisLHVL62oER3H5l7+5V7nk3q+PMA8CV?=
 =?iso-8859-1?Q?y2FjuKzyq3k9iFp2l42gnVMl2qvMfcY+ohKvEcv7AtGYSMf6A6hSuA/+j+?=
 =?iso-8859-1?Q?9ct6wr7SAnHejcIe1iKJ7NzOw2eii4uFLGWL8UdscIolnPxyXeOygpHMu+?=
 =?iso-8859-1?Q?dKqQ3ECMxvi9BAZ29sDr/VM7vVur5WdwupGhkWHOWDM3Hmn4ez7NN9H18j?=
 =?iso-8859-1?Q?i5tXYMaxPzVqHkXeQasahi+N3pLD9h94lVsj5V5qgS0c2o+5eAmwR+TIJU?=
 =?iso-8859-1?Q?g79CX/0TTgytpLKxRWl69CKOzt7l2CDciMasKKYO+xhWIDByDZsNv4ZcsP?=
 =?iso-8859-1?Q?rD822JjCVfC3stXQRaRFxmwDnTV4z8gW1OiinwsGIkwWn8/fv3G1v3z9QR?=
 =?iso-8859-1?Q?dax+D0q3TW4Qm8dzTdO/6Tugw3mRCmh/34L/y3ZJEgXpYAsxEHUAuCnBZy?=
 =?iso-8859-1?Q?SFo/o/ENbhmBP13RxuhQiS9MnxFcGB9dzhs7nOJCJxkOItQfbmTIH0PTkC?=
 =?iso-8859-1?Q?9KhMDX68Sficc3sNgNBm8ZLk0Gr6GPb1T7SZomK3tFRrfxHAec5x8OJi/i?=
 =?iso-8859-1?Q?vBIlrYpx+wU2cYwfsoprHaNeHaU/1Z6m+NkVT3hvKu0efUwxjCvCP8q9PU?=
 =?iso-8859-1?Q?wBC6DdUYZ6KkZ0LqB3vbzGjjCK0tjSQG888/V5Ejzw3/KljxVw7VmvYpDG?=
 =?iso-8859-1?Q?0X8l2NeHF60LtlSzZnqoit9+wyTffmn52a9bDMnJYrlCSx6ZYMJar8qXu8?=
 =?iso-8859-1?Q?gDmJ2SlrxQlHtx9unOKjEXlpnfIq+hpDasTCcrnT5ZAwLCl5qr2zXoVXPf?=
 =?iso-8859-1?Q?gQln5wDQZuzU8cHHnkOzsdFg5C5WDkpXccE8Z3uKRwRmkD3endcljaAWYX?=
 =?iso-8859-1?Q?0iRQDl4jF3JACsEsUYfZsOz9iU3kyRjAw7QCvOas0vUCTiCqz9YD5xku5X?=
 =?iso-8859-1?Q?nRtipmBX6jVsj/Iqi9qmHq4/EtsaUok/DaoiwpMtEJRU4adAcsewT5PDiH?=
 =?iso-8859-1?Q?R2CFsnmEwi8W7C7BCT+vZQNCB0jZ+NqAyOzCKE2/FDHOZ5I7DFZ8naV+aM?=
 =?iso-8859-1?Q?rNXAghr5RuNBhN6TDCmfEk9h0SYdZoHVMX1ZXiQth/VjNLSd6cky7tcYrW?=
 =?iso-8859-1?Q?ieoebGUHVdICyWuJx1V65Si+S4iOYLMvRsoPOr5wh44kgNRavPd5dN6r8p?=
 =?iso-8859-1?Q?hF+/XdzVwLf+lW2Tib6E9xrIfToGgTUCkvkRCuxjH2xihj+aVZszaDcPCI?=
 =?iso-8859-1?Q?JRoBj+vXd+xtxTnFCJjo7WJmbOAljSTz6vo9UctRQEox1uB23xOKIhIe7h?=
 =?iso-8859-1?Q?fZ+IChxGm9ymTH/E8tZqBkzOXHdpFklXB5AFCh6GIltxx6NiuE9UhiSA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR03MB3109.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e491f0-069f-4fcb-b587-08dc72390e25
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2024 04:07:35.5792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHxnkMdX+xXTPwWRWoZD0xQqCB6Ij1joewrRMf82/p+II18QRnWs8CqJXKD3owWGjEaKZWcd3VZJ4Qm5yL4u3hWE5DVN9nhLwp8UjfkKL10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7131

=A0=A0=A0=0A=
---------------------------------------------------------------------------=
-----=0A=
=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0The third International Workshop on=
=0A=
=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Real-Time Cloud Systems=
=0A=
=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (RT-Cloud 2024)=
=0A=
=0A=
=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 www.ecrts.org/rt-cloud-2024/=
=0A=
---------------------------------------------------------------------------=
-----=0A=
=0A=
While most cloud services operate on a best-effort basis and provide no=0A=
timing guarantees, there is a growing interest in cloud technologies for=0A=
industrial and critical applications. Edge computing is a recent paradigm=
=0A=
that brings processing and storage resources closer to the user. As a=0A=
result, it provides benefits such as low latency and high bandwidth while=
=0A=
still providing the benefits of cloud computing, making it lucrative for=0A=
low-latency, real-time / safety-critical applications. However, a higher=0A=
degree of determinism is desired for cloud and edge technologies to be=0A=
fully embraced by the real-time / safety-critical industry. This calls=0A=
for new techniques and methodologies to design predictable and reliable=0A=
cloud/edge technologies and applications.=0A=
=0A=
The 3rd International Workshop on Real-Time Cloud Systems (RT-Cloud) aims=
=0A=
to bring together industrial and academic researchers and become a forum=0A=
for discussing topics (including ideas, open and upcoming challenges, use=
=0A=
cases, initiatives, calls to action, and projects, regulations and=0A=
standards, future research directions, etc.) related to real-time cloud/=0A=
edge/fog computing and virtualization techniques. This year, the workshop=
=0A=
will have a focus on industrial cloud use cases. The workshop also=0A=
welcomes short and full papers that consider:=0A=
=0A=
- New technologies, innovative approaches/ideas, including work-in-progress=
=0A=
- Open problems and upcoming challenges=0A=
- Regulations and standards=0A=
- Demos and tutorials, especially, for open-source projects=0A=
- Call to actions=0A=
- Experimental reports on existing technologies, including negative ones=0A=
=0A=
Original full and short papers on all aspects of real-time/safety-critical=
=0A=
cloud/edge/fog and virtualization are welcome. Researchers are encouraged=
=0A=
(but not limited) to submit papers regarding the following:=0A=
=0A=
1. Use cases and applications for RT-cloud=0A=
- Use of cloud computing principles to improve performance/safety/=0A=
security in existing real-time systems/use cases=0A=
- Real-time cloud and edge applications=0A=
-- Industrial use cases and requirements=0A=
-- Experiments and experiences with RT-cloud=0A=
-- Real-time / safety-critical applications as a cloud-based service=0A=
-- Real-time extension to existing cloud-computing technologies=0A=
-- Decomposition between the edge, fog, and cloud=0A=
=0A=
2. Virtualization and cloud computing technologies/models for RT-cloud=0A=
- Development Operations (DevOps) for RT-cloud=0A=
- Deterministic hypervisors and cloud execution environments, including=0A=
containers and WASM=0A=
- Real-time Saas, Paas, Iaas, and XaaS (anything as a service model)=0A=
- Execution and deployment models for RT-Cloud, including=0A=
serverless computing=0A=
- Microservices Architectures for real-time system=0A=
- Modeling of network and cloud, execution stacks, and applications=0A=
- Adaptive SLAs for RT-cloud=0A=
=0A=
=0A=
3. Resource management (including monitoring, scheduling) and=0A=
orchestration for RT-cloud=0A=
-- Predictable orchestration and cloud operation=0A=
-- Tools and techniques for resource sharing and isolation=0A=
-- End-to-end resource management and scheduling in edge-cloud continuum=0A=
-- Co-scheduling of virtual network and compute resources=0A=
-- Edge-cloud-IoT continuum and interaction/interfacing=0A=
-- QoS mechanisms and isolation guarantees=0A=
-- Autonomous monitoring systems=0A=
=0A=
4. Safety and Security for RT-cloud=0A=
- Assurance in RT-cloud, deterministic scaling, fail-over, migration, etc.=
=0A=
- Trusted RT-Cloud/edge environment=0A=
-- Considering security and privacy together with safety=0A=
=0A=
---------------------------------------------------------------------------=
-----=0A=
=0A=
IMPORTANT DATES=0A=
=0A=
=A0=A0Submission deadline: =A0 =A0 =A0 =A0 May =A016, 2024 (AoE)=0A=
=A0=A0Notification of Acceptance: =A0June 6, 2024=0A=
=A0=A0RT-Cloud Workshop: =A0 =A0 =A0 =A0 =A0 July 9, 2024=0A=
=A0=A0ECRTS 2024: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0July 9-12, 2024=0A=
=A0=A0=0A=
---------------------------------------------------------------------------=
-----=0A=
=0A=
SUBMISSION INSTRUCTIONS=0A=
=0A=
Manuscripts must present original work. They must be written in English,=0A=
using the IEEE format, and submitted through easychair. There are no strict=
=0A=
rules about the number of pages, but the recommended length for full papers=
=0A=
is 6 to 8 pages, and for short papers is 3-4 pages.=0A=
=0A=
Submission link: https://easychair.org/conferences/?conf=3Drtcloud2024=0A=
=0A=
All submissions will be reviewed by the technical program committee members=
,=0A=
and accepted papers will be included in the workshop proceedings, which wil=
l=0A=
be available online on the workshop website. Papers will not be assigned a=
=0A=
DOI to enable authors to submit a full/extended paper later on to a=0A=
conference or a journal. For every accepted paper, at least one author is=
=0A=
expected to register for the workshop and present the paper.=0A=
=0A=
---------------------------------------------------------------------------=
-----=0A=
=0A=
WORKSHOP CHAIRS=0A=
=0A=
- Johan Eker (Lund University/Ericsson)=0A=
- Luca Abeni (Scuola Superiore Sant'Anna - luca.abeni@santannapisa.it)=0A=
- Gautam Gala (University of Kaiserslautern-Landau - gala@eit.uni-kl.de)=0A=
PUBLICITY CHAIR=A0=0A=
=0A=
- Remo Andreoli (Scuola Superiore Sant'Anna - remo.andreoli@santannapisa.it=
)=


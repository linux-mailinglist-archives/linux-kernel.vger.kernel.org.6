Return-Path: <linux-kernel+bounces-217390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4901790AF17
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B903B1F26D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE9A197A96;
	Mon, 17 Jun 2024 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="vBe5uQUh"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58121E480
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630443; cv=fail; b=JaC+nTSjY+9Kt+TmOf2XeMjdbKckxUIF+6xUdP4bvSRu2c/ALv6u2ENHqQQN7mAHKCZEs0UExjON8gb/rUmITeX4bZdmktplI1i5MxxBD2RcEk6JBSfkJNsg1zso1Wr8BO5CBnsDjQhLoMeF+ccJo02J8f6IzdhGqRtT1YkfVjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630443; c=relaxed/simple;
	bh=JqO1mrg2ev2sZpAlOIMIG/x+Dy/9NS5CY3YbDQBMfmM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tNgiYFCRXahwR/VXRgzADPLcM4JwQFrG2+gWu05gXxRzSDI7wWzN5JYhTHdh4bG/09cTt5nf6DzjfWww3HUUHsB6ISMJyF3K8A4dRG5PRnJCa0DxqTbZfH4c0aVcj+q4CuQQIp0+feEbnoi/hMbnh+ZCECQXMP0yNZgkxZZazUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=vBe5uQUh; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HBE1mh017441;
	Mon, 17 Jun 2024 05:55:59 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ysafh5257-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 05:55:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLokZjyHWIXTB7YuCeWjN67sgxgIyN3GYz4y37xK3XwGayoW90XzAVWzL/00Aub4w1TnkhqMZE5eJI5v/78/uE+G1nA6EXnr9fPaCcWhGTEayIB94NyBuOqrIZDRidwEXtXMRxltnuXgJkYDb7wulfZLi4pC3bSxOTfchxDwooIcvb7EpYfmBl5B/G8DmgUJ6Ue7hqofa15c6SChaxpa/fu6yij6qy7Pqgk3Wt6spdCiNVe/rt7+PxdE1KHLLNCp88rcKrZElIwyPmJOnmo45f2ZcnYnaccAX8EzWh5X6GCHUe+SwyyXIJvuz0JJi2UUE9hUMJ+I2C85+6MpmJOoLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwidQ+CSMfrAW6BJw6M7Ut/E2getZxETkKDKjYl2rrs=;
 b=LIjc4mQ8nQBsCGsbdaBSo9l2qeGdNfCFk4Uo9jetCaGNTe0sdishB38HUcLQ0kRjxWBdjWUoqJy6gNlLTrRv9Dm7+f1qDy6EgMPEL2FY0qOdaZfdgfNHYgV9aqMSPqq4smecOTkMugj5GiSlbo5defHsPEJB32XthjBTa8D0WY5ZRG7Dkj+RNyx3Dn4KupWjs4FMYJTerSGvzJXih8ZuzeeN18TU1Ou2FqonLBalNsBscIvUqKoOGncNxBa4JiNL4VGg5+H/OuispwbbWvynGQruiEnjm3O0NgnG36IpkLEPdAXaSfDYVbayHRUDBLhMbLKbwqd+ZofKPV8wmfLCQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwidQ+CSMfrAW6BJw6M7Ut/E2getZxETkKDKjYl2rrs=;
 b=vBe5uQUhRHa6DnBFaVGvtpIo5cYLIJYA0L0an+oPUjHrmdQX5k60+VC+qfOtFFA8q7aJ4kYO/4CwSM1hJIKvRZFbwamDLlp5btzJYD11zdiVV8Vnlu1BqumAR22/vXMOT6XAhnAmFi5SBrJ2gfhQb0wQ9EiVkqXHJnzHvspPMj4=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by BL1PR18MB4166.namprd18.prod.outlook.com (2603:10b6:208:313::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 12:55:55 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b%7]) with mapi id 15.20.7677.027; Mon, 17 Jun 2024
 12:55:54 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Jerin Jacob <jerinj@marvell.com>, Srujana Challa <schalla@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v7 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Topic: [EXTERNAL] Re: [PATCH v7 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Index: AQHaqqXUeJduCBvv+0e3+QVunpJsgbG32TAAgAAF9zCAAyjT4IACojEAgA5onMA=
Date: Mon, 17 Jun 2024 12:55:54 +0000
Message-ID: 
 <MW4PR18MB5244E888BB8195D94A6E2EC2A6CD2@MW4PR18MB5244.namprd18.prod.outlook.com>
References: <2024042950-refurbish-duckbill-77b4@gregkh>
 <20240520110630.2568767-1-vattunuru@marvell.com>
 <2024060412-amulet-unflawed-f37a@gregkh>
 <SJ0PR18MB52462AA2A9F15103D5198CC5A6F82@SJ0PR18MB5246.namprd18.prod.outlook.com>
 <MW4PR18MB524422223AC92181942C75E2A6FA2@MW4PR18MB5244.namprd18.prod.outlook.com>
 <4a4b1675-3244-4032-ae64-82ca8872288f@app.fastmail.com>
In-Reply-To: <4a4b1675-3244-4032-ae64-82ca8872288f@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|BL1PR18MB4166:EE_
x-ms-office365-filtering-correlation-id: ca8ee96c-9073-491d-077b-08dc8eccd336
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?y3fe+tJGQvTBziLhJSFwWNm8CIhAozeNpeVfb2cELbsF1/82IVIy7gzYpvoy?=
 =?us-ascii?Q?D2VpeiiUGvvYvsZARE2W73xm5G/GmwzYp+XQccaqRyh5oMpLs7O25LMKA95i?=
 =?us-ascii?Q?GwAiKQtMIQJPHhW7VMC60vuBa/Qh2yPvUUkrAXWOtJhHJY9pAiMFKdS7ioo3?=
 =?us-ascii?Q?bwTKN078AB14MUgx2sZYOUioHArdq/rJ0NBxxqCsrfP4NSxDo8Z91CdSHEjo?=
 =?us-ascii?Q?Gr+aDXXWfg4WdiQVoJCLNOTES9yvrDp7kdvm/yQR/uZWXk+EjJn997qlIJIV?=
 =?us-ascii?Q?Gm6boyn3Ufb2YwNIek/pUTtm2NRa5xAhYhBX4fOtB/EoQKozmVjFShBstsVY?=
 =?us-ascii?Q?KrmfwyuwwIrtg16k2wULWgVUKTI5hM4l/y5nDs8RLuYCJvHrvRmueJYTnXy+?=
 =?us-ascii?Q?b7t0aqzudIQ0N0tCK8kPPZstH2I5b9ZIbYwbbS/cOZPRzh1x/IATg6eYfllY?=
 =?us-ascii?Q?TOJ1E9xvkY9pKWOXMTSwIZLI+9Kl1D1VsRXblRf64XM6ed59a9G6W/aunBfp?=
 =?us-ascii?Q?FiSXjx5tjQ2rsaTds0gUQ0xSxj/+w2zz9dBOO0a6WBzK8OF8q7EvXsb4NC8Q?=
 =?us-ascii?Q?HYAPh6MSeVUNp5HDXyLv2W827UUGGNFjlOT6g08KUxH7d97oOdeXhX64qYsA?=
 =?us-ascii?Q?/DcXqHpeSRUoiuGcRAe0KGQoi4Vfc6n33v3xomhtuvdfhi+kNKh2ZzLdRNh9?=
 =?us-ascii?Q?+dLuY+2+lAz228N9P8Q3amfdk8JcfmHZDDO8rXv4inrv8b5rErUy9oTcXXY6?=
 =?us-ascii?Q?stVQaFqg8es4f8FIBvlf/gjSFgMGR/iJHlK2ainBztnztxvHqdyCoTS8YUvf?=
 =?us-ascii?Q?l3hxFWHeGiZRzRJe6Hp0eDUNjVpUTQWeDRVSbr/juaGDyr7rE4w7b1eDW0V3?=
 =?us-ascii?Q?jbBw/48LPhj+EkoApupyF99BoX5guKVjw1u1Fbw4ZczA+Ee+wFtLlVc1umDD?=
 =?us-ascii?Q?FzAv9lVaeczz6e1COmHQR5/3lN8tl31ofPU72aAQuNrt9ShkIQqBBuHPk6v5?=
 =?us-ascii?Q?gvWNp/qWYSlHc4HRwiDy75yCaBacNG9tfKzSQ5gU5RaHsDIuft6MCApcsUys?=
 =?us-ascii?Q?e7UC+SQvGB97f9Q8YteJLhGABQKczVM2YUPnAWTDQCt04REw3VA5dxAo+XBc?=
 =?us-ascii?Q?1PRMysSRFK75C76QWUi/aGBs5O/A0jns3RaqPub/WjHuqEQK8m7bNJFWN1NT?=
 =?us-ascii?Q?/28nSwPWmlATj0MYvn9esmvpsPYvVEasoSv6/F5RssWDTxy8msWEtlxTho9U?=
 =?us-ascii?Q?VTi+EnHdx2Cla/LtOD6TcEGZMs2z0OGoiVw3pRX1oNrgwgSYDTKjCvURaIVp?=
 =?us-ascii?Q?8hFjPt/6HsGA6ZTG2Ow8suSekVLAmYU7sxBL//e19+vKygrN/NaG/PcYkX7j?=
 =?us-ascii?Q?HdmdVcA=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ZonSNRiKs0z76pMtdlbBWysmBZAEXdbcC/AAUUO3hbf6dko727y/szAfxJ6Y?=
 =?us-ascii?Q?W+IxfvlTvmn8V5ppTzJI4bVQk/+RAzKbm0q/fsRZScWZvRxCddeIQ+tsr6Jb?=
 =?us-ascii?Q?UpchNZ0/YaZ6Nu1Ve9CQQancGGpx8/wsgvRFYMJQucHkA5WQFxNKzm5f8R7c?=
 =?us-ascii?Q?tHnBwE+XR5L/tzR6uzq1Hn8WqIMqv0oa3vKwoEWzUl0iee3tfHdenTN1zlZ1?=
 =?us-ascii?Q?jV3Rdms5VQY2h5hzVM5tmsAmFBeZeyQwR6gxDy6y2dhBxtHvM6iWE3CzB+JU?=
 =?us-ascii?Q?ZgwLcspjSgsGug3s3ia/L+76s78/TyDR/GwhHZLj763sG67uQAHGBt8SpIaI?=
 =?us-ascii?Q?qBmqyiYlfUMAveURzfVjJ7giuZF+MqFVIQH0wDhvwbbZt8qe1gazBLwE3KNM?=
 =?us-ascii?Q?BQPQ1b6qoj5SN7nHLIw6x6DgOM01KjaZQBPVO+RJCzoT7Y3G7Xo53po13QJY?=
 =?us-ascii?Q?ehz5s0xsR+MnjQ+aW2ckNqLsJZiR95KNdwR+JFfS4vW+wvqWgsa7hWU8Qsk+?=
 =?us-ascii?Q?YccOXjPst+DBCmM2H77/kQb6TA/0QFvsBcqHsCu5G67B5lkG44o2YTg0v9jU?=
 =?us-ascii?Q?Co9EPw7V0/5fvTu47Xp9ve/0Btgchxza0Bn20YIF1Ehc2qDiXrkTlqtgflhy?=
 =?us-ascii?Q?nVKFmj8sf4gGVBofijYEszo6JRNwNKA9+dWl2JZ+EdUNJ0Xgm9V8HOo52DQR?=
 =?us-ascii?Q?eXjEEC1Xq22nI17vKS7OJENLR0y/5aBIhfY9+2VlIDpgcyEohlpus1L5LkoX?=
 =?us-ascii?Q?Sbn0MeQ67cE0S94E0V9Gn8dkL6/kNqdNkafO11AE7sB/dk1zkR1Nh6jHUOXI?=
 =?us-ascii?Q?CtnXmReRCTLv6HT9MfVXtwlLXEdCr1wD+EeWTe0Rp9W7Q7YkHhcCbcJhxA7N?=
 =?us-ascii?Q?vfqdK01+OdLER9RUKhIytC4D2IcGmWwXcz9V2XyLXw4R4kHUSD5wxP/DywO9?=
 =?us-ascii?Q?kIE02GHVzodZcyYlGIFQEIfsd8C/OFN3YA/japghrCHxaqqmwopmV2yBnvNY?=
 =?us-ascii?Q?z4JYj2lIbRk9HPaVF6yiyOHImIt2nRjBLN3Xf89hCjmLBs1GWHpZq4wwi5wn?=
 =?us-ascii?Q?2Ha4I74Ksad/4eM8PFPD8t4eWK8wHX2MjsRU6sRBAr6lR2F4sTBaSVkWrUpu?=
 =?us-ascii?Q?lf/vZGFkidplYJ7Zh3yLK2vw3Z3veLcamkTxn/gHIRwmhu2WSPZANOzgC8Sp?=
 =?us-ascii?Q?DisWvA5RL8aqbC16dpAiogYyvEoZi3MgEhQToBlJzz3EjzSJB2GqJbeJmvSj?=
 =?us-ascii?Q?1vaQBnFTcNqtjUuSHKgSZKFf6cWvnwObkI6043t0MKR7x9yKLaslz8939dKl?=
 =?us-ascii?Q?enPZ+rUdnlQfqWfmCFAFBPai1vBkkrl9GkIQC2yzopeI4ne5QpE2FSC53m9P?=
 =?us-ascii?Q?b9NmtVnP0W1RhCsiE1hIR3XBfFBTz7UJfnCTcqElJ7diyoHDxVwWmw6ARplV?=
 =?us-ascii?Q?1kLwQEqNa8CVY47oSea+ver5zFtRfEclWnTK9IVv/40X2azjXNco0qOMxXrn?=
 =?us-ascii?Q?fOfZ8Y+WUV3lv0dR93I5s8NabJUBxVHJDPiYG3Slj3UlJWcwtpeELOnaB3Cv?=
 =?us-ascii?Q?Wx2+vDZeq8ZVkFlOW1+MXXiFa85oDiyAm8Sxc2h1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5244.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8ee96c-9073-491d-077b-08dc8eccd336
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 12:55:54.7452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AUuzBHN9NOdeBzn06TPuc2k4jj/SDyUZ7Ytfrv8fu2ByVAFzWb1cUEnJ0RsLNUURzjMD3WwjHy6LdlWDzrNvKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4166
X-Proofpoint-ORIG-GUID: wdsRr3k1X84jL3Jh9znAW4gBohFEhKxb
X-Proofpoint-GUID: wdsRr3k1X84jL3Jh9znAW4gBohFEhKxb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_11,2024-06-17_01,2024-05-17_01



> -----Original Message-----
> From: Arnd Bergmann <arnd@arndb.de>
> Sent: Saturday, June 8, 2024 2:12 PM
> To: Vamsi Krishna Attunuru <vattunuru@marvell.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>
> Cc: Jerin Jacob <jerinj@marvell.com>; Srujana Challa <schalla@marvell.com=
>;
> linux-kernel@vger.kernel.org
> Subject: Re: [EXTERNAL] Re: [PATCH v7 1/1] misc: mrvl-cn10k-dpi: add
> Octeon CN10K DPI administrative driver
>=20
> On Thu, Jun 6, 2024, at 18:42, Vamsi Krishna Attunuru wrote:
> >> -----Original Message-----
> >> > -----Original Message-----
>=20
> >> > The ifdef is cute, but not correct, sorry.  Please use bit shifts
> >> > to handle this properly without any #ifdef needed at all.
> >> >
> >> Ack, will fix it next version. Thanks for the suggestion.
> >>
> >
> > Hi Greg, the ARM64 cores on the Octeon CN10K hardware platform always
> > run in LE mode and this CN10K DPI PF driver is only supported on
> > Octeon CN10K platforms as the DPI PF device is an onboard PCIe device.
> > Can I remove the BE format and only define the LE format for the
> > dpi_mbox_message structure?, other HW device drivers of Octeon CN10K
> > platform also only support LE format.
>=20
> Isn't this a regular Neoverse-N2 core? That means the hardware does
> support big-endian in principle, though it's usually only used in VM gues=
ts,
> not on bare bare metal and the driver is fairly safe.
>=20
> In general, I would always suggest writing portable code, as you never kn=
ow
> who is going to copy from your driver into something else. Writing this
> portably is not that hard or less readable than using bit fields.
>=20
 Yes Arnd, understood your point. I am thing le64_get_bits() would solve th=
e problem here. Can you please confirm.?, I will avoid bit fields and use m=
ask scheme to extract the fields.

Thanks=20
Vamsi



>       Arnd


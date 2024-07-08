Return-Path: <linux-kernel+bounces-244913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8BB92AB64
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E481F22C45
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E291014EC53;
	Mon,  8 Jul 2024 21:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b="bovOKVjM"
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B28C12E75
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.148.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720474899; cv=fail; b=Dg59dkSpWsFWQKGCGuHcZYm0cdK3QnPBStCb2erYjEYD5qPe6nYjOcXwwBu+8f54jWR28TNU4JjpeE1GVSCLTvKgzpdiTt6eQYPd0ztfn9b9PQvZ9lgMqGLP8MvcBQB5wHF8Va13gTdXVLFWP01tddR/O13xOCSv9N8mnmSFebA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720474899; c=relaxed/simple;
	bh=S6WSuFVRoXASMaSRS7JK1Bc9nwRxB/TJUZ0blg4KOA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d3JjUnbhniY4qTfjSXX32Y7mTcU2/vHMSvxiFAEvBUoB3amaqhVOSKzIDQ2DABAqBqGGz37mLBEKkJtgllVWpfY36EyqDfdUqZ/ngfRTMk3r7nnekZetNViQcYKotPd3g0z+IrQCsS3Jf6EuhJklhIZrSBDv3oKYzgfmXEk3wTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com; spf=pass smtp.mailfrom=lenovo.com; dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b=bovOKVjM; arc=fail smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenovo.com
Received: from pps.filterd (m0355085.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468DWVWK000917;
	Mon, 8 Jul 2024 13:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM202306;
	 bh=1sPlnB8ht0Ub1UAV3k6ACvaMmTxD9d+dSQT/PRqoGLA=; b=bovOKVjMCQrd
	mQhbFYXlheRS5ttIC/3c2HGK4AZF4gOfyMkaYc2Vdv5C0G708lkRDMeJVBZwx9tT
	mHZXYxNu/2PR3vbb13hcPYrd+NH//+ywIOvAL/cF1aW8BU4yeQw/re9OEMbVhAIY
	Ng/mwBgrnr6ncoI9W40j06AWaQP/2ABCDrP8lDLEwK/YE5T6DuQhjJo6IB9G0EE6
	/pE9CQyXT1NOPLhjCZG2iTt/q3xo3Dx+uphZLIcmWuZVuX2XnZ8FPfwp3shc/rvY
	fpC82D28HTTQYpP5sQ2LxAav9JG+q4+EW1hgLD0jJSzoi7pWYdoS/3mbS1ifezHf
	0xSFXDosmA==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2040.outbound.protection.outlook.com [104.47.110.40])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 407meft4jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 13:39:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkT/n21jmnfgXKR4kb96HKIT414HbQODFXTEtLULsN9sZfUg/a2YTSmnZ5ieFUJPIPvNBRZZioElEaZxSyti/cKj3FrHmbmM8twjQRoRHzuojbwvirtnOW1Thh2Lv6bIkmTsrdhq5YdLP1NlGvrmARx09IMCR/Kses1JkLIU5+9gakANKEpLrmr+T6q2QRhu/JsxADY7FmIda/wfWA/sK+UmmZcijQlWdpxaMYd9zDMhruFXCKK7rEqJTnMGPi9c9uhe9KNcMm1/BWwgQDQpMADh2nBo81VMIq/+YHyipNDLVpGiZRmnubqk4ga6DfIIPS1zuWmVOi3xvI82XYSY4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sPlnB8ht0Ub1UAV3k6ACvaMmTxD9d+dSQT/PRqoGLA=;
 b=hVqS4fe20Hw/rSL6KNTgLAENpPxlGC1UZA4Us6qzbMTsUItFIhmmRX5fp004gf8TWBex3CIJAPEKKBrDKpH75onFwcIvbEy2mwNdOUjQIsOzk55lpCyDgKDLU5dlJgnmSEHMy5IIEFbPSaRQANIF8C6XOwioht45W+zq17eMvgfgEG/wG/7uwTbhz6bUsaViwjWuHQ9Z0wovcQxDvZAMfY05NSPbN6bVukgt4mzvNkR5lqlv91uEGjDV/5Ohbm5f4S7Xdiaq9t8JWej2ePqE92PZH1l5MUYIPneXeExlKTfulV2lA0jFnjrP++3LdYKabCjJYkgZTYWtAEeGYiv9vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from TYZPR03MB6192.apcprd03.prod.outlook.com (2603:1096:400:130::9)
 by TYZPR03MB8614.apcprd03.prod.outlook.com (2603:1096:405:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 13:39:57 +0000
Received: from TYZPR03MB6192.apcprd03.prod.outlook.com
 ([fe80::54ac:ace0:dab9:cf27]) by TYZPR03MB6192.apcprd03.prod.outlook.com
 ([fe80::54ac:ace0:dab9:cf27%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 13:39:57 +0000
From: Adrian Huang12 <ahuang12@lenovo.com>
To: Uladzislau Rezki <urezki@gmail.com>,
        Adrian Huang
	<adrianhuang0701@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig
	<hch@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiwei JW10 Sun
	<sunjw10@lenovo.com>
Subject: RE: [External] Re: [PATCH 1/1] mm/vmalloc: Add preempt point in
 purge_vmap_node() when enabling kasan
Thread-Topic: [External] Re: [PATCH 1/1] mm/vmalloc: Add preempt point in
 purge_vmap_node() when enabling kasan
Thread-Index: AQHazvEibLVY0u/ZyEqO+9IiidqC3LHs2RQw
Date: Mon, 8 Jul 2024 13:39:57 +0000
Message-ID: 
 <TYZPR03MB619290520C6552B540870C32B3DA2@TYZPR03MB6192.apcprd03.prod.outlook.com>
References: <20240705130808.1581-1-ahuang12@lenovo.com>
 <ZogS_04dP5LlRlXN@pc636>
In-Reply-To: <ZogS_04dP5LlRlXN@pc636>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6192:EE_|TYZPR03MB8614:EE_
x-ms-office365-filtering-correlation-id: cd6a1d9d-fd01-4240-83b4-08dc9f537507
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?OiALOs4lIa1BLhyIJv+3M3ZH1cgXicR7pupWNlbsFv7GsNLqU6ww6hgeS7dN?=
 =?us-ascii?Q?wPGtP0M/3Ia7qTbgntL2h5TjGKxc6YyBSC1ZByVBJV/R2APcX9vauhfzepkv?=
 =?us-ascii?Q?9ATH2Rrk4m9R8V3kIuTPyNXcsTgQNrlEvIdT/LiJFLF0fl0AkN2bzzaGm96p?=
 =?us-ascii?Q?uXbGidMq9J59X0u6fp7sZil+m3LE1SMM9/xU68pe86tSgF+XX62vbbEM4z69?=
 =?us-ascii?Q?GoJZdJEbUCLqmNrZO+BTsXadOWIOLxx2gXdIp/F6QI6LtnzFBjtRsBpLOinv?=
 =?us-ascii?Q?XO0CPE4g9ZVQbykobQmuXbNzjF+AsZ0oyp7JCBHEImeGHwog8WtkPc//2GEy?=
 =?us-ascii?Q?Z1KRXx2USKrDnBMx2tZ0Vw0tz+X2M8sk/8EdYRUjwWKeOT0HeSv4+bqyi6IA?=
 =?us-ascii?Q?pXXXpg2fkkWU1jG4wtw1KBPwSyse78TivrHezhWsqyhY9u06rUvAklQWcKnV?=
 =?us-ascii?Q?mP60Bk8zw5hAASixenMXEsfX4D4+eBWZ2CMZ2h5bOw7Z8O7GEn1LFGtcEnUM?=
 =?us-ascii?Q?vs8xhU6KRA0DBM7aOGvJZJq+/QOJAMJBS5WykrK8DB9+4ZPMWySlWwaNVdor?=
 =?us-ascii?Q?Mh+i9f5XmPRekQjMo1jsueJzQgmg+C1KzviAT5tVFjzShreys/VWQGLqGCYW?=
 =?us-ascii?Q?jk7pd+ijt7xiJb62gP9C5EpsS/HJ0KlRWGnDBScDDLXJ5D0hMrd+IQEwZGGX?=
 =?us-ascii?Q?pX6Mp9EXNQUK/vlrPt0QHjrxdX5qSaBwP13XI7JqVrkjq7pQFIPvFIOlfKuM?=
 =?us-ascii?Q?lxeIOG4q80x0F6UkFTpt3RvLeeH1y1ll+m+GtknhqUFULD95G7B2tBIb0ODY?=
 =?us-ascii?Q?g7Kn5b4FaxI8uSnbaSMUPiZYonAnX95DEiHddrCAhS41S1io/F4K/ICO4ovu?=
 =?us-ascii?Q?B2NViJC975Q8JCTjU+uGBdUW8+dHgSJat+CERrvFHhylcoOoAl0LyU/AyXkC?=
 =?us-ascii?Q?N0N8hOs6T6Q76+DTHsAXb78MCWVUW7Dwh7hvbBU9lNCSLS2iwIRkhJ6Qt/We?=
 =?us-ascii?Q?aRkseyaEfqGU0KWAhRLSVpd7ZeqGkMol8J1CNM3RfsHxUkS1vZGct9xogsLs?=
 =?us-ascii?Q?tGlyFSG1Sp8X71qBGTeE0lpz+3GEdjvT2ORBKc004N8CIw6d/0dI3IkS6Kur?=
 =?us-ascii?Q?GplCJFmnd9oFz7odUI381xzQyQImIR8f1j4U9kded6N3BCuq/1xU85oYaRJX?=
 =?us-ascii?Q?lRjyMx4r5wNN5CoaUq6WDTBF2ryTAKrgxAP11WQzfBl7UYU8z7Cgh/UI2PNV?=
 =?us-ascii?Q?BshanUD4odCOrrMvAGpoP/vg41OH/dyXu0RBms6/8RHAje27KqbKjvDRdGtn?=
 =?us-ascii?Q?C1mZ9sY+9R8iBdiU28vjfal/RGHOyjZ0DY0+mkFy8l/feTnhkU2sML81RmX6?=
 =?us-ascii?Q?7MQuNmvZCJ4zBwG7F9x+MPFaSGszoM/T3cW8yaHL6g69BZkigg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6192.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Y2+NC9saDB7sWommNJCNF4l0RD7Xray7YdDVfQEFJ7I7xhYwzJrgj9k1Ro0c?=
 =?us-ascii?Q?rNLqot31XfNRDC8Sdq7XcV/gelOwKDuaMSUTQWv1qQTyFI8YTMOi9vxbfbRN?=
 =?us-ascii?Q?fIbmD9CSF3sqKehswdc6tYqXxKBrx0QkQ2vBuYyMRGdLp6kL76ZCT/Db/55E?=
 =?us-ascii?Q?HJnjDrhGwAQCAsDXAkEecKnkgmwR8wS8XF02sjyp5YFABtm4i838TlBiEwky?=
 =?us-ascii?Q?IArZg/pI6culfzKp7v+2ggOY36Olb9CQn/V4m1lpgw6/biGe30L0U63M8irs?=
 =?us-ascii?Q?vMw7u5HcCfyxTMtP4MGxwc8AO7eZlqCcuA5GivCmqSCMHm5gFlBEAiutoUz2?=
 =?us-ascii?Q?Lri8bAeiaeWLVZA/S+suTEZBtVXfemWQuBhXjyZwMMckCDJj/FYRi7yOYYoU?=
 =?us-ascii?Q?kelhIpUD7xbC2lBKZ4gHh//T72zRXP/WgFfWnbNJxvwubTWVL7zixEvzm2VH?=
 =?us-ascii?Q?yQjQgQYm5gMFcm/+HQK0aG/oPU0YIQzcNVbcKyqu9pj07tV8g20iP1tGEvKg?=
 =?us-ascii?Q?1JKNNwcni7YiQFsBv4GoCeXhXGoyYYAZuTexBSnmKlUSj0ggXJeH/x4zAvXA?=
 =?us-ascii?Q?ByeX++zwcwB+TU0cLktIfKjoMv2HzV2FkpzUfWd7y2EGMWpMn6a4VLjURR0B?=
 =?us-ascii?Q?gt/BTwI583rOVOh/Po0TVZGH6Czfy6BGDxHiDefFCaMiGm81OaOLREeQp7CO?=
 =?us-ascii?Q?A5yHMcjF/8DDA+cyuhM5GovjjDDh8AAExY6kMt06z9q1iDdHMTdip2trsrDL?=
 =?us-ascii?Q?8Lt5fxJ0tWwCzybMDZYo5tiqstSqRwMHE/zC/+eBDUy5oF8V15JKKBesFYG8?=
 =?us-ascii?Q?IdvLASM16b3uJg4r3oeW/OG6fJi1jbkAqj00QO2rXLIeN/R67sZHgoKLVD0z?=
 =?us-ascii?Q?9F0vpPGuHQrzLYd2AGSRvqLiAqZ7whVOrZ88G9f8l2yFS7rUWdogFnw8ui1s?=
 =?us-ascii?Q?w2QHriZYdTflY1bw9pnoyyZeyQ1sJExZXZtziZnKtPmr9IkBS9Xlyg2RdGiK?=
 =?us-ascii?Q?oZILDZP3JhWepCfIz2YxbJgNGH8mjWQprhJUgridEX4UubndwnRdkgwjtF1H?=
 =?us-ascii?Q?Ixaf9uwaxjChMWUwRAHM/0FMC+oxwtiYfQJGkYwYyupRhE7yCzkYx0LG8hKy?=
 =?us-ascii?Q?OKyTGCesu2dt132iNuObJRJA4KrQ0KWmAldPfEpJc3L99MdSAd/Lp+Gobwm0?=
 =?us-ascii?Q?Q1jEzFo5loeqNs6w1S5qF9HH1RKlf6imv1FhlESf3QkmW/iNYubucO5Zvi1v?=
 =?us-ascii?Q?a4+JUB3dyuLKsG0zAk8lZLkIGdg6QhYikpJEheK9WHM1mWWkx4r7F+/hXwpn?=
 =?us-ascii?Q?MH1OH4ap6FQ9Po2WKAb4gAOpcYLbbWYzU/suNr3iV8pz5QBEiattNUqPvETc?=
 =?us-ascii?Q?WmsAaLdOtXzhg3OSyzQNJ+2/X9FtryNfIMI5yuxh7ePjjOyjsqf/WpxxC6QH?=
 =?us-ascii?Q?Jhu+HbLPxhnjP8goSsaNHwzbZqyT15qPP9d2p5w5hlm+sjRC25GlgxHIOOE9?=
 =?us-ascii?Q?g2X6hWpkK8FGXoMvDPFhG7IX8JL685bbsDL4grOPekuig4HkozZzzQcZREg4?=
 =?us-ascii?Q?J8aCLaPsRiGmEHiEk/vHc7J8TCRiJHwaELzLY0AP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6192.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6a1d9d-fd01-4240-83b4-08dc9f537507
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 13:39:57.3965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CB92EOiVmCoLUfHL8rHLfHmFM+teaGnUHacgnjpm+sNH9+WXH3qtMzp5ddZ5Atj2X4gmevNwWZ5S+ihKGVLEoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8614
X-Proofpoint-ORIG-GUID: 7NE1WTLxPqMfPT3n3rSeEAhYzGGZfiyT
X-Proofpoint-GUID: 7NE1WTLxPqMfPT3n3rSeEAhYzGGZfiyT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=-20 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080101

Hi,

> Could you please test it:
>=20
> <snip>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c index 03b82fb8ecd3..6dc204b8495a
> 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2190,10 +2190,12 @@ static void purge_vmap_node(struct work_struct
> *work)  {
>  	struct vmap_node *vn =3D container_of(work,
>  		struct vmap_node, purge_work);
> +	unsigned long resched_threshold;
>  	struct vmap_area *va, *n_va;
>  	LIST_HEAD(local_list);
>=20
>  	vn->nr_purged =3D 0;
> +	resched_threshold =3D lazy_max_pages() << 1;
>=20
>  	list_for_each_entry_safe(va, n_va, &vn->purge_list, list) {
>  		unsigned long nr =3D (va->va_end - va->va_start) >> PAGE_SHIFT; @@
> -2210,6 +2212,9 @@ static void purge_vmap_node(struct work_struct *work)
>  		atomic_long_sub(nr, &vmap_lazy_nr);
>  		vn->nr_purged++;
>=20
> +		if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
> +			cond_resched();
> +
>  		if (is_vn_id_valid(vn_id) && !vn->skip_populate)
>  			if (node_pool_add_va(vn, va))
>  				continue;
> <snip>

This patch can fix the issue. Feel free to add my tested-by.
Tested-by: Adrian Huang <ahuang12@lenovo.com>

-- Adrian


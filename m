Return-Path: <linux-kernel+bounces-352355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 068DE991DFB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 12:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2943E1C21018
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 10:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F941741D0;
	Sun,  6 Oct 2024 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="p5CQynDX"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618EC158543
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728212145; cv=fail; b=unKklZOC3rNFBGX0HogmzqDiabkeq+d9jVRKSncNJo/mShbALKBVOIl6N9dV5MF32OfVJ4wTc0oy/v10+yLH1wKb9uyCOP59lp3qJYCsBDc2DBQrQqZmnsEWpkhFfIFudzdhJ/9PDre2QlGiOdpXmD2NXDMxZcxcJPvoA8Tbvrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728212145; c=relaxed/simple;
	bh=v6bTDWeFADH8IH48rOy01N36P73J2deQ/Z2BZHr9bHc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=txfA56O9EXxTam5ia+eACxJzOKGsaZv9d8Ye3kamByeNJ2rb+LzanSZkMhWJX+7iJyfAqpN16n5t8yqMdaIpw90799PziflGkpN/msgJESNDTg1h7vI2Yz4znpINYDf3vlzJX0kw4dy1Iowz+7d4Iu3cJpIopsBGi21MWBfjUuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=pass (1024-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=p5CQynDX; arc=fail smtp.client-ip=40.107.21.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDFqpQE93tSNbNdFBxaCJUzz8P2BUXj5P6gsD7fvfr5/k7Wf5mfulllL/4YnPflOgLSPkcME1Yq5lAAWcx7pTVWmifxXgt0VY93PnmBKbckAtp5xTSY+2sCk9dOhZmf1Prw2DjKHTFPUgoevSsxO53pIkSkxXsWNKgY0glZqw9DlCcxgdKcbNLln46/4zPDIO39kYrbIuhNY5X9G8H9tKhXQqmN7K0gB414yz95QbuVM1MARV7zRhD/Lp/9FVv8hg9jtr4CH+dhfoskLHIRWK27mpdVA3TI3wMagQpqDlm9NrbUTYgcPFtOzQgGeUX5903sGd4U4PTFD351JaUdRrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgd9VeI1GVUZZHkwrf8vGsLP4B+rq22WZxyu0cbBIAQ=;
 b=Bb7Cdcv5X3TIMaI6txiRNNDC5zdcyc/XdWgEa42vG/Zfr7aLnrGfrp6CJJVc00O598xpcHMEX1TMRnGS5Be7dFTvpZFOKVKP/b2BfSc6aN7xVhPSa0hzIcdZYUa513x9vz7dwrf8/ZZSlIbP1PPnLjGpeyhn09K7ZF8HZAV05dcTxJmKQ04NMcnbxJeJkGOH+zVRFZaZTOVrKoCLBR5LblRJjI2Jj+kjmGFcZGxPpKdW/mk+Zzw5J8951OvetCR2kOyWhfTSkbSOX59qU4ODlNbaAlp21I5FBZ4YBF8+8CYsrG7ZFOuTu8MYx5M7F92V8Ghz4YKrcj/Ii5yobg8Fbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mobileye.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgd9VeI1GVUZZHkwrf8vGsLP4B+rq22WZxyu0cbBIAQ=;
 b=p5CQynDX8UDc+sSnhtRlz4WrSEJA2SAos0hD+h7jYFu8XwM3IQAjogHiHULFEYKwqhxINyqtVgQsoNETML+fJ69EKzrvwog/1tk51WZ3tfw0HyWWZVQ7uHaO+j2bYByJ+TdtU0fOeVZhX28JAMJ6qPU80oyEScjQNUKb/Bjg3Gg=
Received: from VI1PR09MB2333.eurprd09.prod.outlook.com (2603:10a6:803:82::16)
 by AS4PR09MB5734.eurprd09.prod.outlook.com (2603:10a6:20b:4cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sun, 6 Oct
 2024 10:55:39 +0000
Received: from VI1PR09MB2333.eurprd09.prod.outlook.com
 ([fe80::fef9:cf7b:cbc2:d3b7]) by VI1PR09MB2333.eurprd09.prod.outlook.com
 ([fe80::fef9:cf7b:cbc2:d3b7%4]) with mapi id 15.20.8026.016; Sun, 6 Oct 2024
 10:55:39 +0000
From: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
To: Alexandre Ghiti <alex@ghiti.fr>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
CC: Andrew Morton <akpm@linux-foundation.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v1] riscv: make ZONE_DMA32 optional
Thread-Topic: [PATCH v1] riscv: make ZONE_DMA32 optional
Thread-Index: AQHbF95IdP/goVPehEObmdWyR1OJkA==
Date: Sun, 6 Oct 2024 10:55:39 +0000
Message-ID:
 <VI1PR09MB233370D7BD8553E7891EF46F947C2@VI1PR09MB2333.eurprd09.prod.outlook.com>
References: <20240827113611.537302-1-vladimir.kondratiev@mobileye.com>
 <e8f6ed93-d47c-4c07-963c-8f16f498abed@ghiti.fr>
 <VI1PR09MB2333FEC324AA0B3E5F1D7F98947C2@VI1PR09MB2333.eurprd09.prod.outlook.com>
In-Reply-To:
 <VI1PR09MB2333FEC324AA0B3E5F1D7F98947C2@VI1PR09MB2333.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mobileye.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR09MB2333:EE_|AS4PR09MB5734:EE_
x-ms-office365-filtering-correlation-id: 1894ec26-abae-469b-a560-08dce5f56a91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Piddzzrs9+92a8qkMEo6zIv1NZ8FVAZQvdvmW6CmFWj0P4ZQQJpT3unkPS?=
 =?iso-8859-1?Q?Bc8DJompTLT7V1ulhR5JHYU4JfvRKr0U98MVoBDUWDyzzc/ExPsXTtl988?=
 =?iso-8859-1?Q?ZlFwNttpWWoIAXzW3SRIFDkU49NG01IrNCkuxfLJTHv1fH5yobQ++QcNR3?=
 =?iso-8859-1?Q?2wUoyNcM83+ZGgJl0q8NBb0aQA5IA75MfqfXNkLG+lGDFkRupREc4XhA/9?=
 =?iso-8859-1?Q?DDCKjdE+es3HM2yolokvniPUe1/SHOcxJm/QDdl3fMpFFSU/+XvhemsPk2?=
 =?iso-8859-1?Q?yNhr6tbY5i8oyCYkQuXGcEBetZSJAgSEUNzo+QfGiaY8iKqjc3btYWMsuO?=
 =?iso-8859-1?Q?GJj+qHPg+qV1PrRyn99cEO9qCMeqJAC3i8x0GyOZjP95xGmijiSeKcLN+Z?=
 =?iso-8859-1?Q?X4W2Ee+yEV2dyL39J+U2ev8odI5GC9ReB5C0Ws9Uia3wFUiRj8sWXdinPF?=
 =?iso-8859-1?Q?hdJ5eWhMJpu1nYSTm36m31XulBd76LqqZ6fUNnX+qqcP7o+NaoGbsy8YC9?=
 =?iso-8859-1?Q?1IKbowzOj/7hvSgwf8C/H16LTfsgSXmmDFZrvbz7Y34i6fn0E3xSyRsIUi?=
 =?iso-8859-1?Q?3KV98DPb/4uwl+eQvRmBldHvH/TybnHk63M6yroEdhZ4B7jIlBOHV+u3Kw?=
 =?iso-8859-1?Q?dMOHk8sqUU5uSln2gOzodomr3m6rcwmNbDuE0Nyw3A0GI0HTtfgU+dj34P?=
 =?iso-8859-1?Q?RmhLqjMJSfeRRxzCFZb5SbBuu6qs2IC1xe87R7IHvzZ0IMAAh9mJ4z/zA1?=
 =?iso-8859-1?Q?uZsqoYw4QJSrBkft59XPXY8t6EK/eb65c3xpC4YJJaTQxSz3xbKbS/uE4n?=
 =?iso-8859-1?Q?qs3CHSOUjHU+SLDPoKlQU2iK0yETjsQeEdiDO3iDcS8Mdr0uvPsq9ZoRFX?=
 =?iso-8859-1?Q?6KxYMxfI1drMJaf29+DSHNXR/ePbjbtuTg0InioHZFVYZltPP+Q1WJCZ86?=
 =?iso-8859-1?Q?MPmjx/I5SvOJz4pMYDypw5UOKHdHSU7HOSUVHuk5g7yLNO2ME8ECiu3nu4?=
 =?iso-8859-1?Q?EYBDx43/2a0DiEmo/wroJD5IO9ha2IuBm0EReTsk2A+m6+nrao8bv2QTUx?=
 =?iso-8859-1?Q?La5qMkcCUKj7jaHy/1GQRMIYyJ5TsJokv+CwTPZpvgjEj/xJoIy73swwIE?=
 =?iso-8859-1?Q?PMfxFwA5Nsl9csak2UR1fitzdkHDtesHe+/TWXRDPlG8IpZpeABM+cSjZZ?=
 =?iso-8859-1?Q?Nmvlmnks6fd5+eNfjQ4ili7jtEzJkg0jqBrgzUyYOsbSw7Aw5L9guVjsWb?=
 =?iso-8859-1?Q?4fORlZSrewDNyjFG+SWufcJGY25H8pUiIKKC2fdCWS+pvk4epE2DccVeiT?=
 =?iso-8859-1?Q?83a/vNrPkLvoDxPY2F1nr04Et/D+o5aDp71VfsY0I4G8o57hASInblG3P+?=
 =?iso-8859-1?Q?auVoY/+JgZ8Qz/W0QyRXGIa9hI7CAlDQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR09MB2333.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5wov9iAlQzFeQEPnxjLp95+kEowmwN8Du38bjUZy0rQoKNYjj30qlNFT2Q?=
 =?iso-8859-1?Q?rffXISmWxURpDu19w48Njx4N51CSzzzi5ClNtyU9ANx+iIXOcbsz0sqAwU?=
 =?iso-8859-1?Q?B7dRwAIvEEbVuaGuVxEIZ8R2R4Y8i/z6KmVPzaWaiBukRGhn3hN01SHn4u?=
 =?iso-8859-1?Q?xZcYMUDLh8KU6hSgrs53cUOadT82lAfr0J5Mg4wHsNshiI3oDyPtQ884Kn?=
 =?iso-8859-1?Q?SGJ0XbrQFCGaRKstS6b3SLiDBze35Dz8Vaf4cK3VXbrY3Z4IXFMQBNuqsL?=
 =?iso-8859-1?Q?a4u51uPZ6pcZ+98j0JwqHCtmpwF5AtfESYf2AxlhfFYlFXuj2Fa6GcW0Jw?=
 =?iso-8859-1?Q?fww+Yf85GvITrjNhbtb2Bdn5kj9HLthdqviX2/KuDmf18XuMDCHkTTXMo9?=
 =?iso-8859-1?Q?zJv1itknMEaEGgz1GWsnwSaj7ysU8ZcWMmjpjgZLq6BRSOJpWZ2Fp5OXD4?=
 =?iso-8859-1?Q?LSo8dH3JkwkYlKp3sgQNaE3pTKJDFnRzt/H1FRsKLlVd7tBWlBbDIbHtcx?=
 =?iso-8859-1?Q?s4JezuMfmUMUijjYuN2BQ4WcgLqRARFHW/1vQASxA9iHAuZbdDC9/k47lq?=
 =?iso-8859-1?Q?jFkfdcNVatpGO5Fk4YOlXybphpTEWG8KF1nzQHFkX7UeCoZctudvknTyv3?=
 =?iso-8859-1?Q?QrRo8gdojDbfoLO3PKUZULZv08UYqQrn5Ta3zBppCSayBDF1162teWEX3v?=
 =?iso-8859-1?Q?djzprODUSMUR68M8FBvVdz0uMSMGsVAHdM4jm0rew8+cECCw8bdLpL3zcY?=
 =?iso-8859-1?Q?6eJ5Vys81XHur25Tn5aTK/I3M6fggS4KKG/WjPuhfoM1w48/QcrG8mfq/R?=
 =?iso-8859-1?Q?8Wc85cjlOWRM5m96tRK6O4NtHJ7qGnfWkIY0ofSSgcCfCNYSdFfxl9T6aN?=
 =?iso-8859-1?Q?Wnf6fhVLh9fvLHNdzR/D428D1rN5zDY2sgYlmOepshhAoSwX4sQKmco54a?=
 =?iso-8859-1?Q?Z46D/haIHJ9o7stgG/RSpn0orcQRYE+EabivfgWr2qO3T++rKbMHD/jYjM?=
 =?iso-8859-1?Q?pZ0ULjcIyOpx5hpfeMg2QEXxPRZowbE1fmt9LbMQlEf+Bf2RovpzuY+Xlq?=
 =?iso-8859-1?Q?AOpAEa1YbTEeR3rk9sSjJjixPRAmCPtqiLKvhcrBQJgzL/rxd9H6jCt8UY?=
 =?iso-8859-1?Q?pyL3Cofj2+pRsaJaQljxIk1yCFBX1IXQ2v8mTOPeCyuEMGEaleDLXKOsdq?=
 =?iso-8859-1?Q?ivSiTcm79oaGkDxYLvi3fHHVIcMvR+yag7Wquzs6SGN488M10BO3wSDnPE?=
 =?iso-8859-1?Q?15Goi3FJTGvGWuOktAaZog5muXUeEhhNzEAenQ7XXHChdmPxmChva3sqNW?=
 =?iso-8859-1?Q?LZLVcISXGm5G4nZol03w/BiiI93r7/ie/+BCQwSQVJgu/bAMQ0FOXVtoeC?=
 =?iso-8859-1?Q?fcTLwA+WDfzT2OEblkxtuwNufMrZ3XQZo9Z3eNXsPakm1aKXgI9ugygpAQ?=
 =?iso-8859-1?Q?flY5a4q0o94UVG/zlCOeh7ogqnJUngOuIzMooR0wQtNxoWLOsGehZ3vD6a?=
 =?iso-8859-1?Q?P/26AV/9+YU+ibBJ65nqAriYQCXptYLXJOaUnQzSm9+zjHKhY4IYPvPvPb?=
 =?iso-8859-1?Q?IcsPnB4Bs+53OpC8aumTdXMcPTGs+v/Ujch3MYn5Y7F0Ck3F7LH5+Pamu0?=
 =?iso-8859-1?Q?HarhrD6Uc18u8iZmnZ/RzCri5dbsxNdsI+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1894ec26-abae-469b-a560-08dce5f56a91
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2024 10:55:39.6863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zFGaLeuyWrq5D2Sp9ySXQAyN0V1JXDSkT5mUuOp+wntdGENdVeWgvXdK/I2DqZV9ASzYzmNjfWTe8+ihto8r8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR09MB5734

It is not necessary any RISCV platform has ZONE_DMA32.=0A=
Platforms that not support ZONE_DMA32 should set=0A=
CONFIG_NONPORTABLE because lack of ZONE_DMA32=0A=
makes such platform non-portable indeed=0A=
=0A=
Example - if platform has no DRAM in [0..4G] region,=0A=
it will report failure like below each boot.=0A=
=0A=
[    0.088709] swapper/0: page allocation failure: order:7, mode:0xcc4(GFP_=
KERNEL|GFP_DMA32), nodemask=3D(null),cpuset=3D/=0A=
[    0.088832] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc5 =
#30=0A=
[    0.088864] Call Trace:=0A=
[    0.088869] [<ffffffff800059f2>] dump_backtrace+0x1c/0x24=0A=
[    0.088910] [<ffffffff805f328c>] show_stack+0x2c/0x38=0A=
[    0.088957] [<ffffffff805fd800>] dump_stack_lvl+0x52/0x74=0A=
[    0.088987] [<ffffffff805fd836>] dump_stack+0x14/0x1c=0A=
[    0.089010] [<ffffffff801a23a8>] warn_alloc+0xf4/0x176=0A=
[    0.089041] [<ffffffff801a3052>] __alloc_pages_noprof+0xc28/0xcb4=0A=
[    0.089067] [<ffffffff80086eda>] atomic_pool_expand+0x62/0x1f8=0A=
[    0.089090] [<ffffffff8080d674>] __dma_atomic_pool_init+0x46/0x9e=0A=
[    0.089115] [<ffffffff8080d762>] dma_atomic_pool_init+0x96/0x11c=0A=
[    0.089139] [<ffffffff80002146>] do_one_initcall+0x5c/0x1b2=0A=
[    0.089158] [<ffffffff8080127c>] kernel_init_freeable+0x214/0x274=0A=
[    0.089190] [<ffffffff805fefd8>] kernel_init+0x1e/0x10a=0A=
[    0.089209] [<ffffffff8060748a>] ret_from_fork+0xe/0x1c=0A=
=0A=
Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>=0A=
---=0A=
 arch/riscv/Kconfig | 3 ++-=0A=
 mm/Kconfig         | 2 +-=0A=
 2 files changed, 3 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig=0A=
index 0f37596a7707..417c6051b679 100644=0A=
--- a/arch/riscv/Kconfig=0A=
+++ b/arch/riscv/Kconfig=0A=
@@ -51,6 +51,7 @@ config RISCV=0A=
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST=0A=
 	select ARCH_HAS_UBSAN=0A=
 	select ARCH_HAS_VDSO_DATA=0A=
+	select ARCH_HAS_ZONE_DMA_SET if 64BIT && NONPORTABLE=0A=
 	select ARCH_KEEP_MEMBLOCK if ACPI=0A=
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU=0A=
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX=0A=
@@ -208,7 +209,7 @@ config RISCV=0A=
 	select TRACE_IRQFLAGS_SUPPORT=0A=
 	select UACCESS_MEMCPY if !MMU=0A=
 	select USER_STACKTRACE_SUPPORT=0A=
-	select ZONE_DMA32 if 64BIT=0A=
+	select ZONE_DMA32 if 64BIT && !NONPORTABLE=0A=
 =0A=
 config RUSTC_SUPPORTS_RISCV=0A=
 	def_bool y=0A=
diff --git a/mm/Kconfig b/mm/Kconfig=0A=
index 4c9f5ea13271..f96f812193a4 100644=0A=
--- a/mm/Kconfig=0A=
+++ b/mm/Kconfig=0A=
@@ -1057,7 +1057,7 @@ config ZONE_DMA=0A=
 config ZONE_DMA32=0A=
 	bool "Support DMA32 zone" if ARCH_HAS_ZONE_DMA_SET=0A=
 	depends on !X86_32=0A=
-	default y if ARM64=0A=
+	default y if ARM64 || (RISCV && 64BIT)=0A=
 =0A=
 config ZONE_DEVICE=0A=
 	bool "Device memory (pmem, HMM, etc...) hotplug support"=0A=
-- =0A=
2.43.0=0A=


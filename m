Return-Path: <linux-kernel+bounces-363024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA6099BCE4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19B1281625
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 00:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6A95672;
	Mon, 14 Oct 2024 00:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="EU+hVKVU"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2133.outbound.protection.outlook.com [40.107.117.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC260C2C9;
	Mon, 14 Oct 2024 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728865037; cv=fail; b=QtULrLtla2P+++WoWI2oelp5CQPKDOvaaaRczRh6ppSyeHfQwV49p1N5dpoyL0fmZ6E9FSYUuDMWH/ocPAGdJ32cReFxGxxzy98VqPX8cthRYRZm9Jv9SEx7ksFeRvQLBB5huoujv8Ir21aIRr/yAs5xibXYMthJmFtR8v5cMUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728865037; c=relaxed/simple;
	bh=0hXORSX90PA6Rlihp6e8p40mKIAz22TUMUFQjlJ4g3s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vGjH5JTOX7jMGNDsKrubgrtfkLNmQ3+9JXjwqYV4ntkhm9fiT6CGN1DGZ9O+I3pm5wLINRBfBQOPy0aoll9dIWTOTV2hgEq+QWEFyeQvYMXPCywIA/vCIDPDc98Pb+P9XUQMDxiirOogN033f+RvKocfZoj3jsYcBKg58mjnmgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=EU+hVKVU; arc=fail smtp.client-ip=40.107.117.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmOuR6yjwhcrG8M3APwKTC+l4uPhFwme/TdtQt0Fr2eW3BNZ8chEqPkjqUepyJ6d0C82VmzexYxKjSyx2dq9SAOmojIhxnsd4a0xBqUO4tGhz35oKrWl94uingK3xr+OLz8qN/SljZO2PderDOqicZZx7cQlD+4/ZiYez74dPrQmN3qM642X7ftJWY57pZVm+Q4KE9jQoi5HJzTBtYeePwSpepIJXq/NgRhIhFaLG5DQtx1zkRcduQGseS8RIKPPL+jxa1gMFODleEdPjQ/cyj83S16yE01a0HuRgJI0NpnfiTvKWn8rtm9pCEJpVDlF9reGruteNt8g2RmJOXDiqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thP95kHS7gHAxdKa6+C7kKQjgmXtKrkJ8qkOxwk8nMU=;
 b=ul3CFqHgVzMRB61JPV/4Hsk9YlQpuUwU+15Ot4tZ67e7GXQZbXmFQ1Ysv/b8Q7ygb2ngPprYUxUytieZUt+JWDlKdVZDdllMv3XXAQiNfNMpGUfMHKgrgb/mr26ewRppYP6iJFjH2zWCIES1iHb1xil/+DZuWTS4kTzgLAY+yTqp3k4raabkl/0sA+oXkZmVsaV1X+BeBQILOe6P1p4b6PBkZeeSV0dMhacA0eEAsW3bT3KKtyvpwzDV5P92B5MYxk+vDS2jclzqFdJHsL9Yy505PzHKjlQMFv6ostHt2LVClbtuA3EWCO9rkD3K2O6ut9rFjPrJjSoVyb5mzJe2mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thP95kHS7gHAxdKa6+C7kKQjgmXtKrkJ8qkOxwk8nMU=;
 b=EU+hVKVUIyhKRMeAW2RNsCuoEIu5i+bSVsh+so0BCkOYHOseb3DRUvAQzk6l+bDSS+ERN8FTwA2ZMrRFn7adWxodiPCxj9SrfXqCWBIHd9keKgbjXhvR0f+E5yA6ZAIYLoP86yovsdLW2wCYcoOrWrtPcff7tZT1Is/pB33xjfS98Xmi45P3ZISQdtZUrSqbpJphE/2ATEN4iglFB8FawDDRssJ/f0HBfokOlH5pVkWQPbRazUc6CirU2g3Ysswz15ro3XPAmtB7XzvFpZmdEphy0GrmC4aj5JPKb6RLXC3NpHDJxzwpo0OGbBoaRzjhdPHI4kObjK50nIVHBY/p6g==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by KL1PR06MB6071.apcprd06.prod.outlook.com (2603:1096:820:ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.15; Mon, 14 Oct
 2024 00:17:06 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%5]) with mapi id 15.20.8069.009; Mon, 14 Oct 2024
 00:17:05 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
Thread-Topic: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
Thread-Index: AQHbGkKMCnGgBPvFn0OoVljQ1X0eJrKBiCQAgAPgAAA=
Date: Mon, 14 Oct 2024 00:17:05 +0000
Message-ID:
 <PSAPR06MB494904BAC3F09133E3E0121189442@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20241009115813.2908803-1-kevin_chen@aspeedtech.com>
 <20241009115813.2908803-3-kevin_chen@aspeedtech.com>
 <37525238-c9f8-4f0e-b4e5-4e2f05fab775@stanley.mountain>
In-Reply-To: <37525238-c9f8-4f0e-b4e5-4e2f05fab775@stanley.mountain>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|KL1PR06MB6071:EE_
x-ms-office365-filtering-correlation-id: b99c3506-512a-46be-45f5-08dcebe58903
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ie5rZByGUx8gmwB5t5x5Zb8ddx2aJo3Dz2GVC2huvP1j0RnvSDJ4aqxdYpwA?=
 =?us-ascii?Q?SsT/RcY7+FfOxqs+nv+noyM0Q2zy5BI50scW+Y2UPn0nWEZCA+jhzexgTymP?=
 =?us-ascii?Q?nzJQiugEm51y9fnbaIG5FzqzKz92B9DJijNkHHTS3YzmdpcJaa21SHLNh/bv?=
 =?us-ascii?Q?8RjO79VHclUT28e/AItpMoW4hTYIlTSVPHsyFDeQHIFFNo04ch2ehyjcJdCz?=
 =?us-ascii?Q?MGEyJdGjPZB1Q1vSJyNocna+UkVdtgu67sf5UuQEwDxexCAbNEEqwcMDoDT+?=
 =?us-ascii?Q?YiOVO5ZbcglcglsrTsb/q1lAxZmJYtuSD08S5xpwWnHt8Y0/58WfAuBd3GpQ?=
 =?us-ascii?Q?pSA38Kv0ixTZZwZ0nQWptN4ClUGwFldpy1KQ9dmfL8zAVHQ0BtIBQH8NKl11?=
 =?us-ascii?Q?Y8CBe6z36vztDyk0898Au7HNlPHCAOdU2gciVo/5xbuweNysoyM3hkb48PeA?=
 =?us-ascii?Q?aFyYWYI0u2d1NHh0uUJ7NNr6Xlu2SBkSaA0TupIRXJEXDJDnHyIM68avePPF?=
 =?us-ascii?Q?+MbKUvWlkCTMyikY/HyB9RPWw6kool0eymcdYfvMu15MDN3jg5q+X4p25Yq2?=
 =?us-ascii?Q?nrG7XZsbCba5tyrIOTsOiPEBtljOF9sZ8aALrJ6zTsmtU6JBWIygHnlDQAGH?=
 =?us-ascii?Q?XMSEEdZA77BoLQzxzj1uJB8/d33EOnhzTlITX3LS83QAKpEYa1FCFPgmqPWW?=
 =?us-ascii?Q?L8hrMgAorRgR/dq8kUEFtASQObSqMYKEgqnPFL1nyxzUHQ7YgbgAB92TKJ9z?=
 =?us-ascii?Q?aHpRNlhTt0/uOikKzQHWNImZ012azNIKsN5Lf6z+5JWmHoJCgiM0KJTjZ2wO?=
 =?us-ascii?Q?T4Bp1KoMhbLvVCCrfR67fM+PyvqXfYLqQQ8ra/q0piRNE/KqkHRWAFhr7b2U?=
 =?us-ascii?Q?mv06MwnqEkGZtc9tN2HVsqVK8PP2xY1FgOiRi174nmAyCc700DVZ38u0s242?=
 =?us-ascii?Q?dLuU6M5y7vIfr4dB83PDwZUfhhk+6IdoQ1Wo0XuDFUd5o0aNZS2gwyjqsFvV?=
 =?us-ascii?Q?EUZpmOo4LvT89BxTBjIfvEQOcDC0U7YmhcRpJaD0lcGBoyZFw59bfxJWDJZR?=
 =?us-ascii?Q?opLMrpnuyGTcgpLOt9y8issGHXJ7L0a+Bh5zoHzmuyBF4jsqechpFrSAE13L?=
 =?us-ascii?Q?rhxZYdz//SCnTfvUPHwqPNvFihJm2fRzAY7IUw8mho4WikWSYsRwwz+V7ezX?=
 =?us-ascii?Q?pD/LwL30UGa4x17tSvosjanELdVpOBNDdZq1AqjWnuQAvFAqRnEsHZY7+AIy?=
 =?us-ascii?Q?Pp6v/91PilwbsxgHLmtbAyD5uhVfXDI5dRmFnGRIVqDw0vcYRdBcRqS3tLnD?=
 =?us-ascii?Q?q/nLVvTY+Fwo9gD5vorf4GGZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JmKlUuEipmaIXqz+ZEOecpbNJ0tDoXeeBu9wNSDHLQMwSWrlp3U/bUeIShvy?=
 =?us-ascii?Q?Rla+p0mhSRVKk/jrsuCcPPS1BIDev5hwCT8TWV8YtOwq6Hm+MZL0v85fbGPN?=
 =?us-ascii?Q?e9qtlsizF/izEx/DbgVaxftTIeatR1UvqZIH6I1gMpxHK71EzDYB3tHYvSXH?=
 =?us-ascii?Q?grC3UyM/gaHVekcDyIvXdHM4Ge+xhFheIIIevjqpwq1FGHAcJdU9x1SiWQbj?=
 =?us-ascii?Q?PK9fpmWhY8yy0Etz03FIOhSXRINTlCb2o56D2ZvgElrqhtBtHt6RQ7MHDTyV?=
 =?us-ascii?Q?XL377uuUpTr69DUGtTNuhG9/r8b9AGqScSnTO57uM19E9oKf1I/EVEQ7C7w5?=
 =?us-ascii?Q?jcbl21Bnc6eX4XUM5MV/5UQXaaTEHV+nNoPPgqSNAtLWWguueLLCNq9QONLc?=
 =?us-ascii?Q?w5GnmACMKaxSM1Zeu52xcKSm6snFrJN6PHhq5g2HYeN/mAL9StU+J2ePG5h8?=
 =?us-ascii?Q?wJ4AbP3M/xs5V4TZFv3d6G+htLeXIMnBO8Pi/yLZ79aIRRMBnc9Ty9G7Z54l?=
 =?us-ascii?Q?JI2caJme3FlfHdNFoyBhb/WN0aelzt+uOMa1FqFz2KIlV7kQFZ2UewX97cYN?=
 =?us-ascii?Q?BjjN1Ac2FiF5jlcJE5icOlVUY8benzVaDFT2s/8DFP99YNWz1lKY1/Tfditk?=
 =?us-ascii?Q?r0MXFomdHN8QPS70oR2rDcELZVf+L/DbkYOfsei3rFDzKAwgcFU7vY9Jk7+a?=
 =?us-ascii?Q?0pr7NxuPp2bHh9dbNVQm+BOBsaU9aiLc7VQCUMJCac5Kpj3uAxZ2Jgs/x/vq?=
 =?us-ascii?Q?jobfkWThh3Ema7G02pCwm/1qnXZO7W1g5/BZ0DjowABpB1ai1Kel+5jcZYpy?=
 =?us-ascii?Q?YsHviyoWSsMrDQznikUSfzIG9SYGvbqsMY2agpcTebNjyk0Q4mTezpC1355g?=
 =?us-ascii?Q?zJe6R5EcTDSWn1ldiU5QIExwyLRyKy7AppPkMr8etBxeALm1/7diOgeK2Hzm?=
 =?us-ascii?Q?yRXcxQJUrxeY44c8eJLsCWoyS3ymiu6Qx5mriiF/29jrMku4+UEDytm3URpg?=
 =?us-ascii?Q?1eTpMYuli8dRM9J7+sUxmpx9s1YS7D88QSxrC3zQVCDRgXWRS6OGl0g1IfF2?=
 =?us-ascii?Q?Yxez9wZ1I6kWwukJyAgtlBzEeBpjMVc5iGXE2vIQtqjNGtm3dCnLIdh7PAmi?=
 =?us-ascii?Q?RJ69wIgmZdgeO/7yqv6fE9m4DF649MF8TOZZ2K2A5Zg1tcx7TY28RS9gNJJS?=
 =?us-ascii?Q?2mUuw59G+OeXXBBLLQLy0cAlMdMJwpAaRGNQfzxVhktuMF4+gRZRGqEJkQd7?=
 =?us-ascii?Q?MwmJJkEu0DdsKrncQCFIqTEs7lH65d1dl8MeXMuhs6VIKs7BmIkWM+3zYtPD?=
 =?us-ascii?Q?FdOid7QqR+fZwYpG/dK3EuEMXR1sZEOCcq2TEMUgrMwprHJKDuXfxxasmk/0?=
 =?us-ascii?Q?4aMtb4DqJ4Cw+EitpmRT+IVIj+hAYrxacQ3/NoV9DRdWE6yaKi+0Si8ZZJYA?=
 =?us-ascii?Q?L3A3TxL4q/fXxBCuLZyakPhPZSoPzlvYcKgJhizE3puQJStIPZFmCYI54s8U?=
 =?us-ascii?Q?mPc4X248emp4kRK6xxwuw9cghuni5pXwD/pEFvOnnxZALk73i0W9+CGFBVqy?=
 =?us-ascii?Q?HPJJGlm9NinQu1+xDrRqXqYDIPIle+JullgpCVdx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4949.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99c3506-512a-46be-45f5-08dcebe58903
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 00:17:05.7951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tHCpSmdXB9x+9zPd7OuXlV9kFD9+nphe+8HIHDAlgkI5Gg3IIpYsDpfqLK5Re1OL06rC9+wX1I1rtqNs4giDpma5iY9G+w1nMzjbev2Dy64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6071

> > +static int __init aspeed_intc_ic_of_init(struct device_node *node,
> > +					 struct device_node *parent)
> > +{
> > +	struct aspeed_intc_ic *intc_ic;
> > +	int ret =3D 0;
> > +	int irq, i;
> > +
> > +	intc_ic =3D kzalloc(sizeof(*intc_ic), GFP_KERNEL);
> > +	if (!intc_ic)
> > +		return -ENOMEM;
> > +
> > +	intc_ic->base =3D of_iomap(node, 0);
> > +	if (!intc_ic->base) {
> > +		pr_err("Failed to iomap intc_ic base\n");
> > +		ret =3D -ENOMEM;
> > +		goto err_free_ic;
> > +	}
> > +	writel(0xffffffff, intc_ic->base + INTC_INT_STATUS_REG);
> > +	writel(0x0, intc_ic->base + INTC_INT_ENABLE_REG);
> > +
> > +	intc_ic->irq_domain =3D irq_domain_add_linear(node, 32,
> > +						    &aspeed_intc_ic_irq_domain_ops, intc_ic);
> > +	if (!intc_ic->irq_domain) {
> > +		ret =3D -ENOMEM;
> > +		goto err_iounmap;
> > +	}
> > +
> > +	raw_spin_lock_init(&intc_ic->gic_lock);
> > +	raw_spin_lock_init(&intc_ic->intc_lock);
> > +
> > +	/* Check all the irq numbers valid. If not, unmaps all the base and f=
rees
> the data. */
> > +	for (i =3D 0; i < of_irq_count(node); i++) {
> > +		irq =3D irq_of_parse_and_map(node, i);
> > +		if (!irq) {
> > +			pr_err("Failed to get irq number\n");
> > +			ret =3D -EINVAL;
> > +			goto err_iounmap;
> > +		}
> > +	}
> > +
> > +	for (i =3D 0; i < of_irq_count(node); i++) {
> > +		irq =3D irq_of_parse_and_map(node, i);
> > +			irq_set_chained_handler_and_data(irq,
> aspeed_intc_ic_irq_handler, intc_ic);
>=20
> There is an extra tab on this line.
OK. Fixed. Thanks a lot.

>=20
> regards,
> dan carpenter
>=20
> > +	}
> > +
> > +	return 0;
>=20



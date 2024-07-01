Return-Path: <linux-kernel+bounces-236173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC5491DE69
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAFD728455F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696661422CF;
	Mon,  1 Jul 2024 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttcontrol.com header.i=@ttcontrol.com header.b="HnvMjm4p"
Received: from mx07-0061a602.pphosted.com (mx07-0061a602.pphosted.com [143.55.144.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0541A36126
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 11:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=143.55.144.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719834869; cv=fail; b=HLJzlqoQYRVT/KN7OxZwfGoOcOntSR2OX9ZnQL8OOda0b0xooTd7RDSWSAdtJEr6crYUOhCP3L8bn9BUo6jmrtFM7PQgj9YViglDy29b4JvTwt1u87/YQhXA7Oy6bWOZWaDcgnu6sK05iDHJtHQnmL6v/C/ZVxM+bJMRjwoJeJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719834869; c=relaxed/simple;
	bh=YSDX19+jRJG8mXAAaJMbouk78w9btpCXrPqNtKivsHc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DtKamuEMN++P108G1dN2mCDCCGfDusNn0p6ER1jD0Xcf/fMVrKDHAfm5g4i+J1W1IjsCmraEoxwlA/viITsCdvDQyZI3cRZzKGFV+4pm5eXanscO2lI28LQUf0b9rnZ/rtlV41dEaNsvp/LKUvZxPpGf1jcvNvKODOqx69Ikl0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttcontrol.com; spf=pass smtp.mailfrom=ttcontrol.com; dkim=pass (2048-bit key) header.d=ttcontrol.com header.i=@ttcontrol.com header.b=HnvMjm4p; arc=fail smtp.client-ip=143.55.144.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttcontrol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttcontrol.com
Received: from pps.filterd (m0278995.ppops.net [127.0.0.1])
	by mx07-0061a602.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4613Ss6J025878
	for <linux-kernel@vger.kernel.org>; Mon, 1 Jul 2024 11:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ttcontrol.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2021; bh=094RjCJEXEdWDaMUf1qUU9aSH9
	e7Mxb7+GawWagx8yw=; b=HnvMjm4pizuoQCdxSRMiYdJTSRtjrWET7s7cWBQ5Yy
	Jk+sCTJOm4TYR7nmKK7a97dXFApPo2sNw/YzUnAOTGnSHR4l46JT+WImqNeniAPU
	WAmKEFGgC2ujmcXhA6pMPxz8e9vSn08QtvSVfrF/aam6l2vQzNKKimZAxwee3339
	Tqk+2KYzEkKQ3+3ZPcWu+k8a/l9mL+ma0X4vn05gIUbMkB11UtPjwKD1ybOjE65M
	eF/fzPbb5aNulUplSiy8rBwPQtDX3edYOiYxcLjbR4SZraqNBnBun6hPyOfIgmRe
	Jh07pYiliWqc6dPaD/Dw9hlmNc934r9efluAAqIWHgsg==
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
	by mx07-0061a602.pphosted.com (PPS) with ESMTPS id 4027c8a6yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 11:54:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f076eOOvJl/p6buWl1XWXLgRqq46tuh+HylUkPxwdRSCwAebHV4azshhjwFVtCiKEgMp6Yh7y+AtPXEhdYsgZQt8Wkc4qzSNvN5GspTLtyNGvtME8qqllxwdmAqkQGcxk0YKAp2pwOxgTO5hGQF3js4DWms7g6Lq9rldynDKyqzqnlVCZdZ0zuI9Yu9+MNr0Af+OpjbrGko0qkdbJv1dPvQlZ4IXClmve3REo8xHqw7DSuA9P8YRyqE1JlUzJovsgaS/8cKI7RAVKoo2JtBUyIGpxs3e40aiy/V4aTKlUJc/D2vQ3r7bQzndelRkSp7CKrzjvleuKzgaw3bSY2zDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=094RjCJEXEdWDaMUf1qUU9aSH9e7Mxb7+GawWagx8yw=;
 b=NfCg5zoQQEY287CwwE8ssYpPQmIw495yIW8DJrooFW5IOGPvarm/DdZ00UDht4kYI6M/zDa/WUVar8CoWT2hK3qPq8En0+Mpc7a0z9f+hgKcKbc9dsoxBAv7uR0qiqqfOdP0VFF3nAqNWk643RB4Vy8ZoKswBoxjV+hTI533/5z9pu1QqakOqIV80ezL0Saz1NoswomM3mDks1mf5duXazBOZSX4TwF6E+XCkR+3BeyVOs6qIGJThFgcKhM+9DZAGp7aa0VPiUlvOV8Yu2RXtPqMSkcC12N0MMiTrhBpMH1KPCltDFGYTM68EhTAD9qP4t8UgM9H7us78ccHQTNfoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ttcontrol.com; dmarc=pass action=none
 header.from=ttcontrol.com; dkim=pass header.d=ttcontrol.com; arc=none
Received: from DU0PR01MB9382.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:32d::6) by DB9PR01MB9295.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:364::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 11:54:13 +0000
Received: from DU0PR01MB9382.eurprd01.prod.exchangelabs.com
 ([fe80::c41d:dc9b:3f97:1ae1]) by DU0PR01MB9382.eurprd01.prod.exchangelabs.com
 ([fe80::c41d:dc9b:3f97:1ae1%6]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 11:54:13 +0000
From: Diogo Manuel Pais Silva <diogo.pais@ttcontrol.com>
To: "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "peng.fan@nxp.com"
	<peng.fan@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org"
	<shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com"
	<festevam@gmail.com>,
        "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "EMC: linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] clk: imx8qxp: Defer instead of failing probe
Thread-Topic: [PATCH] clk: imx8qxp: Defer instead of failing probe
Thread-Index: AdrLqtcnJw5WiRwIS5yj3rdrX17wMw==
Date: Mon, 1 Jul 2024 11:54:13 +0000
Message-ID: 
 <DU0PR01MB93828B0E6808E33C608BC0E29DD32@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_48ac2777-9b6c-4bb5-936f-abd66d5117c3_ActionId=0780da09-e070-467a-9fca-39c6d5ee4255;MSIP_Label_48ac2777-9b6c-4bb5-936f-abd66d5117c3_ContentBits=0;MSIP_Label_48ac2777-9b6c-4bb5-936f-abd66d5117c3_Enabled=true;MSIP_Label_48ac2777-9b6c-4bb5-936f-abd66d5117c3_Method=Standard;MSIP_Label_48ac2777-9b6c-4bb5-936f-abd66d5117c3_Name=TTControl-Internal;MSIP_Label_48ac2777-9b6c-4bb5-936f-abd66d5117c3_SetDate=2024-07-01T11:34:07Z;MSIP_Label_48ac2777-9b6c-4bb5-936f-abd66d5117c3_SiteId=5638dc0c-ffa2-418f-8078-70f739ff781f;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR01MB9382:EE_|DB9PR01MB9295:EE_
x-ms-office365-filtering-correlation-id: 7c5813cd-e9a9-4045-6e50-08dc99c486e5
x-ld-processed: 5638dc0c-ffa2-418f-8078-70f739ff781f,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?NNnmtyTxnpAbBqOeHwJYvs/1deOpvPvkujrCEskraoHO9hqNy4704jgIfsWC?=
 =?us-ascii?Q?eHKiiVk6OoWVDKNimeDqFkfV46MOjpnVN3WQKy/OP7DSmMfkQDI0Z6GoTGg1?=
 =?us-ascii?Q?V83wiygFMQEjfRU6WTyvppBRbwG5iCKUeYL3TZgOBQi3u8r6Y70VL38VP+vB?=
 =?us-ascii?Q?ppkTOMeTfx0w+m9NACSqoLPTFT3tdC96Q9Em0AGaOP/jFDTSlJxdWSkMblQ+?=
 =?us-ascii?Q?ZqlCBYXsP0QnkAc6WPGQI1whKxCuA9o6HKDux+J6FZOh3o6yuRqlQhiex5zQ?=
 =?us-ascii?Q?geTVsE/j33VEk4IkBHGVglQZF5WUuwZKKOa2hsF51y7r4ndVxWrBG1UALDV1?=
 =?us-ascii?Q?xcwUDjuRWOTU53vnS+ETVBsxxuih7lWB4QPORTy6BrJqn6wPEViwgxzFGoP3?=
 =?us-ascii?Q?QqbaeF5vqbraiL2i32kMN1OlpN0oU5wjDdxM48ClcrIza3W/y7fJKF8epXDB?=
 =?us-ascii?Q?h+zjPr49BZLlDsjdYMpj1b2y28hQ4bqXpZ9mLtQMmYMyL6NAtPv3QBMGV3Y+?=
 =?us-ascii?Q?LZpNkoRU9m2cjbsQui0QwqZWR2KhsMq3fyqe1J6fWDyeD13/j+E4+eFv7tJy?=
 =?us-ascii?Q?ZaI0GNb93xhAQFKKcevT8eV06seqvnzrSkTu67JK2p6YNtA/vVDnXvGrM6z8?=
 =?us-ascii?Q?YqgUO10BybHiRsUrGTbRtL/BheXsJFvKCrO0vyQZ3uwzDpcZtW6vI493/m2+?=
 =?us-ascii?Q?+MzsXLX5Wl7kK9yrQtuw6ntQyn++p0nOqHkMd7MvBeBV2ZBguy3Aj6zd3Riq?=
 =?us-ascii?Q?Z2Hk3dmf+L0Ue/xgxaoFimOHolJnMoNAvtF7I4EoWyOdjNJoofF1Tmb1kJpe?=
 =?us-ascii?Q?9lFF39RAVO7mjVxvXkwkyRPX+2875AGbUFp4oLa9KCE1l9ZL0Jog/CuSzh7n?=
 =?us-ascii?Q?3A2IpQFrBUzPechpQbMApAak5g2wNF+J8gn2ZF0j4z+JuKAKwXbzEwd0GKAz?=
 =?us-ascii?Q?Y28RUnWyf1olFRKncPv+p17QItxOBEFJd10y8i5vO442Jbdi/nClW4/t+Oyq?=
 =?us-ascii?Q?OAlja54sLGAj96Jm3DXz0Kfmz66LegmV6jE5tHlg9DX+41FVKABYVCRd68hk?=
 =?us-ascii?Q?vUXWUb/eewNJcZIeHaLB3ROLqvnlw8T3hkKQDceeNWnjsx6zKAe2Kuzniyf4?=
 =?us-ascii?Q?BJqWUikTiPBpl2uNyAUrpj+aQoM0smtLgJYBzMXJdK8DoZBY17PRLwfNEw3J?=
 =?us-ascii?Q?a7pm7x1dg4Q/8+Ys0/kkfQAEueB3aMuSF5Lg3hhJeBekq7ocqC4S+aPl7+FP?=
 =?us-ascii?Q?ND89ErIxT2EXvgr43ZJbCZNIinjsrYDy32+5n8XifQo0PFJElc7D67y/rsMN?=
 =?us-ascii?Q?6PqXRiPhSVIyYDL5wQj1RpAWkIujVdVpf+c6wGjBsIdSRL5rVNkQp+cnUQl6?=
 =?us-ascii?Q?0bfuHml64Ubqlg8dEgcTr0mr6L8GnXEIxfUnhoVMLgFqebrzFN/Qj0sLLe5K?=
 =?us-ascii?Q?3JmilCCSjCw=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR01MB9382.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?d85eE1REvRDZotXef1VQ96kLOXpUYoreLqzTft5FLavSfTbNIelKhgovPmLZ?=
 =?us-ascii?Q?kDaxRofEEfZHv24DUCmLXONp8w5hoNJSEZasYDgK8flDFXaWgYul9VlNFtDz?=
 =?us-ascii?Q?ZDHmqwzaU4H/dmVj8n0zw0m503OSOal4osVX0ofQJqG/DZqyZPYAAPubSEfw?=
 =?us-ascii?Q?tPhiXe4cM6E6C3aEyezMCjyWRdmYCLclL+2CKncW2HALXP+4heySozrw3ohO?=
 =?us-ascii?Q?Wor53LRG7ughreZjrppr6FPwwb/NOlGdKk2v1S2ez1Y+g2w0m5LGXl2m46Nv?=
 =?us-ascii?Q?5AsztLZ1Kij5nrhIruTTWXAW2U8Nekf9A2O7DoooMz8baNyOJEnirsbdhKp8?=
 =?us-ascii?Q?Lo6Wi7rMCLqyqHaml9B03+qrB3qzydya+5BK9MQzwNZ9wPEIl+Q+IibnFEyL?=
 =?us-ascii?Q?GwYVT0VSow+qpuUQjIwqDaJdjX9j7630/JhbmOAJUFx7YhhMgfR0ZW/MN/YP?=
 =?us-ascii?Q?vJe53Lw5XCL7jjamJezhknx0Kh4Mz7Ys1Jq37yzVt6ZFOZNlzv96dJc70PgZ?=
 =?us-ascii?Q?/ux2fph7/7if7U3/F3yFGABnN2baZuGFyMj6+jciasA7PdfjukhRZsMhn8qH?=
 =?us-ascii?Q?3H5bGwzj3eV4ytkqtJs4bWQWkt3cya4dPDu5qFhk3ccpfLsSfFJhQzLW/CtD?=
 =?us-ascii?Q?N/CvS0gzoFsHZdkICl+yvJtt9Al/uus53InGLoAJqjVQBS7ncYpckKXRqmch?=
 =?us-ascii?Q?45+RZqp2o3i0ymX7VT/wOZ8tI4q2N26hWKdof+s73CKTG4VLrAI9tPxSpzPP?=
 =?us-ascii?Q?Ea7RjWgeQTLnC54McEOKDo+LK7WJm2HeMlu5BPqZgtzkIbgN78KnfMtL24rm?=
 =?us-ascii?Q?Eiskfh3pONCnNZX3Nu9iyKg+TlU5NbKPNw8xFGUp0VV9FMqueYlTDTK6x2oL?=
 =?us-ascii?Q?G2WcQL8jmHtCxFYY3MNhYMm2g6mrK96ZylAeWJZGX7F1ZYqB70C2n/lDDrxh?=
 =?us-ascii?Q?NVTXeY8Fp4Uwbvse/OKy3fLm9hO7Hd2OtotNC6MPVDwACU922geQWZlCvgix?=
 =?us-ascii?Q?k0a3SChoyfR1qJkmwCMgfqPGX8K0Akpd/1NzaNPbD1FA3nsbjBKPvPudc+q4?=
 =?us-ascii?Q?qrsceTlszrwtfVrIX84U7jxembWiMJOgdaN1EkXtiKfQdOsW8bMmiDX3CSGw?=
 =?us-ascii?Q?TA9pcTBOmcKVKF5TeA5TYlGfhT0vuMgLUqUbCYWFTiiF7tyUTAsc35sXXnJf?=
 =?us-ascii?Q?NTU/AoDVg7S3/c6yoXJgl5BQn8pa72Oqfw5M6Ufs1k1aI8mI2bmvS5SMUYq5?=
 =?us-ascii?Q?mNGPKqjzs+vtc5VBXcxsUlgxRyn9bDUk6iVjNDzCFvWy4gxzDvKGjcBqK3Da?=
 =?us-ascii?Q?rdxdjrjntDoIQ81pty/b0RUSIfKC5wXda4D+ng5Q0wXL0xqR9jIFQlobjCA9?=
 =?us-ascii?Q?JaWWoPxuW+LhaupZvc+/9YPw1pXvg1EpUv+bcRSLEgvBLS7rXAYuYdJqTy8f?=
 =?us-ascii?Q?xTmsup+uc5Tjz0g1xR7XydEU8aNTte5XLo0hWvmic0W9oVYev/TH6+XGVRhS?=
 =?us-ascii?Q?fcZXHu6MjIbFP/6VhAU1lecDFaSMBUF4Lw4pM5lpcS8BF2JZkLOO+U+zxf5B?=
 =?us-ascii?Q?SZD1l1qMyhFUhORbXFYOfjE9qmvS2eFa1ceOzBfO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ttcontrol.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR01MB9382.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5813cd-e9a9-4045-6e50-08dc99c486e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 11:54:13.4997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5638dc0c-ffa2-418f-8078-70f739ff781f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jn6oJR4OCZLHWzEg0FtOAbahYih4WVs6Q6iUKC9+Wfk3HIwQ5/UAp4X3DjM+aJhlssUZzv7aPjlSky6kUpJ3Y0kjCkJqXTlS1Ic/3tjJrJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR01MB9295
X-Proofpoint-ORIG-GUID: Bb1z_fGjJUOduMhba6pe2MvgMZbmImTK
X-Proofpoint-GUID: Bb1z_fGjJUOduMhba6pe2MvgMZbmImTK

When of_clk_parent_fill is run before all the parent clocks have been probe=
d then the probe function will return -EINVAL, making it so that the probe =
isn't attempted again. As fw_devlink is on by default this does not usually=
 happen, but if fw_devlink is disabled then it is very possible that the pa=
rent clock will be probed after the lpcg first attempt, and the lpcg clock =
will not work.

Signed-off-by: Diogo Silva <diogo.pais@ttcontrol.com>
---
 drivers/clk/imx/clk-imx8qxp-lpcg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8q=
xp-lpcg.c
index d0ccaa040225..520a05ea0bef 100644
--- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
@@ -225,8 +225,8 @@ static int imx_lpcg_parse_clks_from_dt(struct platform_=
device *pdev,

        ret =3D of_clk_parent_fill(np, parent_names, count);
        if (ret !=3D count) {
-               dev_err(&pdev->dev, "failed to get clock parent names\n");
-               return count;
+               dev_warn(&pdev->dev, "failed to get all clock parent names\=
n");
+               return -EPROBE_DEFER;
        }

        ret =3D of_property_read_string_array(np, "clock-output-names",
--
2.34.1


TTControl - Internal


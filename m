Return-Path: <linux-kernel+bounces-314814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EE596B967
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95FA31F28B11
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76E71D04AF;
	Wed,  4 Sep 2024 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HWX9WTDD"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636951D0145;
	Wed,  4 Sep 2024 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447341; cv=fail; b=iJg55REMD2QArA8mfMyxNqz1efiFC0jP5fV4S17qlaBgq7LmMzFH4CKoD2p7o6hnmDZsI1S8/HLtYL2/7+C2jTNGlRjXGkBKs3sp0cmJ6ztvEkNtl2K5h4DkRrK9QggdLD6blfDF/VqPar2eDxuKh2nPFJ5pzg7fpt7WlJGzcy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447341; c=relaxed/simple;
	bh=c2GJVCidrhX1BXyQTcNgVT1gDrIReiQzjgNl9ktmYns=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=X32s/1MuMJ6eUxzfadf+881MxirWkNA4jWoje0M8fO7o3XsRQRsXuDTEepDb6/gFIm2gJJ37Tu7FEYE77a9EMohcUPC31gFJhwW06vDIQfNnY/BIRdg2MQx68XfSPK9NB6CmgsfYdFdMs9a3u/ukcZGxykyMkbUlAqYFAchdMkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HWX9WTDD; arc=fail smtp.client-ip=52.101.69.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDj8a1L9kzrsq9I1ccanVUwNYwIEWuzdKLFTIWrH7VOEPasARXU5rmIzyYjGIu3pS/3wATrHYB7lSiUlZ8PYKJ1BYHdLjImUeDagrItnNmacrBcDfjCEOyNUygwzk+uGcdd9tDqcCE/4z8bP3PR4FiMOxCIZ764OfrZCi5N50KCTpHyeJ/mToDjHxdNk9jB8TdTOurZQ3+jGTIsjbOPjx1Z6zqg1s/SmNyQlb8Ry1SfgCS0n3HT0o4iDDmK6OYrDH5AZZAY/j6rgEhtyNVabd4Sbq0b4/fTIxdSfphtIuOpIEE/o2Yin8oH7Jxko7t68eOOsdv3PeCztcS3JJ8d2fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TTFyAP5yb7hZ8l7L5ej7ELeEVEO7+opRsZB4H7s0/A=;
 b=Y2u0s2JujTCkMyQKJdiyA3VeKqOfXdUG8s0noUYtuyWr1RFRJsnBHYvwbwWebvCf4xtAcdQQz/qhE809ae+6H9mYnKXfON/TQf3Ve6hRHU8azSBDAN3di3OmYHFSr9Wd5DG5ov2JwiBJTKupB7QVzQVmHBpUBnc69JDTKybauDgN5IfVJTPxkX+Asr8W+jC4f3Lpmr06PzT299ycoWlFRKx21ENZH5+HLsd1CJ72QNJFN5nz8BZVGjP/eXk00Yx1NEQ49uLTj4vkqrvsZYFwwIJrXfSobBIWrISBVyckRyblOJUvHpJMREc3abZcFfg7nraZ25Y7i7mnKZd5hMWA1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TTFyAP5yb7hZ8l7L5ej7ELeEVEO7+opRsZB4H7s0/A=;
 b=HWX9WTDDrCoE0aTLoZZ7CceidPxnpAby3H79VyONdfb08pPvtDA4aLSo1zIFjfKz4SW+NsgILB+B0mlkdDX331gqWmaMD4h8CLy4erWOqojWxyrlOIUX3FSzN+o0cwibSLkDfrWdGTmKDhhWQhOQuYHbC1HcWSHYiLtf0VNMirFn2S+QjGh9jfOdy2BGK76xmmhEnzR1Q9bGs1F61Wv3WYjMINtT6E1BuVwpGYgwo/mpCD4KvS/nNZarLkFjzmeDoOhYE1J97pAsaiYEMrg327bA/Gierh68E/Vfttqh8gD26I6KqVcZkdH51G9qTzuvNcKb3KvlcdUFg0gSDWvC5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DU2PR04MB8583.eurprd04.prod.outlook.com (2603:10a6:10:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 10:55:36 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 10:55:36 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Wed, 04 Sep 2024 16:21:18 +0530
Subject: [PATCH v7 2/5] dt-bindings: arm: fsl: add imx-se-fw binding doc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-imx-se-if-v7-2-5afd2ab74264@nxp.com>
References: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com>
In-Reply-To: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725447104; l=3095;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=c2GJVCidrhX1BXyQTcNgVT1gDrIReiQzjgNl9ktmYns=;
 b=wQbZjM/KE1AT+UADtsFWa15fhyTahVAsigCYhBCLZnMfPiIkMXKHbr9cuQUEU34rB8JPP5T0V
 VxCktow1A3lCdK+U3E2KolFnXs3g3JPVl1u3W71YMSAc8tpreFE93pG
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DU2PR04MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: f63da3fe-6429-4ea2-92a8-08dcccd01b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnFZaERnK2xLejlVMzlVeDhNd2dNL1RmMnpMVFc2SXJnYUJocHptMVRPQStW?=
 =?utf-8?B?M0RZekdVR3RpMnVIMk9oOFZ3V09VUitZd0dGenJzT3NXMWF4alI1SEFYaHRF?=
 =?utf-8?B?QUVlK25xUUhZbmh1SW1SZjBRL2VxM2ZQTG5VeDVCa0orcjlHeU9JZXZqY0Vs?=
 =?utf-8?B?VTdlQUVZN1U4Y0pQZHd3OWRSb3diOW9vTEgwYnB3WkZFT21oV1EzRjVObnpU?=
 =?utf-8?B?M0FZM2tTSzJVWmlNa3NLekNHR3FEMXQwOVJEQ2pyNVp0RjRQa1FMWlpjNklP?=
 =?utf-8?B?VHhXOEpuVlBzZEUvZzRLSlVVNTB4VlAyUHQ1QktERG9ISEM2YmJmb1JEK2lN?=
 =?utf-8?B?em5mWXZkNDFHMUxINkwvcEk3VnVmaXlzYllCVTFhN2Q0cDQ1K1lWenBGYisw?=
 =?utf-8?B?d0Nzd2lJa2ZtWUw1RE13bzIvdTVyUUxoNDFlbzVNbnZHdTl3UTBYODJPYStt?=
 =?utf-8?B?eDF6Mm5PejI0OWhKSTlOdjRkTUtQUmhkSldmVlpzT3hPeGN0T3RDYlhiSWx2?=
 =?utf-8?B?VXd6ajRwenJXL1cyOXRMNnE2SXo0ZVpLQ1pxUmIyYlgxeUp1cEdVK0E5Vjlt?=
 =?utf-8?B?QmxKc3QvR1cySTI3Nm5Ldmh3SjdqMzllZThTM0NsV0VGcWR2b0Y1N0NiM0NS?=
 =?utf-8?B?bE1adlhTUWd6ZVI1VlhVdGk1ZTFSRmwzSDJwQ21vRDVOeUsvckhBTEJBM0x2?=
 =?utf-8?B?bGV4WUpDS0JoK3FzeFp2U1pOK3pqbHlHeC9XeG9KWkUwOEVWcVFQcy9VcWFo?=
 =?utf-8?B?KzQvVEU0V2FLaG1VS0hhVnBrTFlnRkJyRGRFc1ZMaEhES1EwVWNneDlIVER6?=
 =?utf-8?B?bmhVM1BIZW9vTVlZK3BZSi95VlRSZkdyVW1tWGdaaFlrVlpVUGJEQTI4enJS?=
 =?utf-8?B?TnFYVTBxaHBkeUx6Z2RBZUtTcTM4L0NKdkx0ZTczVzE5L0xxSFNZdEdCYlc2?=
 =?utf-8?B?Z3EwY2tYSjFUbU1ZdW4rYlNXMUpUcWF1ckdtMzF3SGptclNCMmhhVHA3bTNk?=
 =?utf-8?B?emFoclBra3FVcmVlK2pVVlFCYWIxM085V1o3RjQveVpoR0lTL21PcU5yTzBG?=
 =?utf-8?B?R2FqU0JibCttdkcvckZ0VDRtejBVaHd2bVJPeFQxZGVqNGtHUmFrWWIxbDAr?=
 =?utf-8?B?ZG1DQ0MrejU3REJ2NkhrN09CWjNmZnRoaHlpZHNWNUVhR042VnBweXVQZDZu?=
 =?utf-8?B?Yzk5MlFFNlJFeEFNYjdtUmJPUmtjOTJRZTQ2dGdURXkvVmFvd1U3TWY2cEtP?=
 =?utf-8?B?amhRa3NzRlp2MUFPdlgwS3hKS1ZUZ3lTU2h1Q21wNHBMWEg3MzcyUHlacGhr?=
 =?utf-8?B?N0VNVVREZWttUlRpbm9nN3J1bGtQZ21DMVpRdkhOUnlENzFJS1N6cU9KOUUx?=
 =?utf-8?B?ck4rUFlBSkRaSXVYbzBVVWllcStwMVFHakNQUzc4YUVxSWlTVUxQL2MvalNp?=
 =?utf-8?B?MURSV1JGWTQ2WktQVS9mVnR2eDV2d0RXVlp6SVFCS2Y4R2hVbHVVc1c4VSs1?=
 =?utf-8?B?SW9kOXdESCszdE40YitJdUhLTVFjUmJ6MmFIRXF3a0lUUVZPci9Pd0hiaU1W?=
 =?utf-8?B?WEJDNHFSQlVHcjZjQk9JN0dmUnF0U0ZXbVUxcW5XRXU3Z0I5K2NialR1UGVR?=
 =?utf-8?B?akw5S3NpTDdNUURnd1p6Z1ZSZXhUS05HajFnNFNBcEgwOHMxRlVjb09PeWFD?=
 =?utf-8?B?Z05vU2lkSzQ4VTlmT1BGSTlzak1jVW95WGZVMGJhSVlaSFlocUZzMWhVcHFy?=
 =?utf-8?B?Tm9Kb3YvTHhqQmlJZWJDZ0lRZS91c1gveW8vVERva2RyUkZ1Nmt4bVhCZkRW?=
 =?utf-8?Q?rGQPaKEGn/8D4XNwYfQo8ekTzW+r6UQ28Urco=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmNHRFZna0JWcXFCZVU4WWdJTTRPbEVWQzR6UThjdHlXSzlwMjBpVXZqeVNN?=
 =?utf-8?B?K3ozNDVBRk5iZGtReldRYXNGQkRLNzZDYmo2ajVJWEgzYmtkcUo5WW1ET2dr?=
 =?utf-8?B?UFJqay9HMS9ndVlSMFlkKzJsbDhBUWxYOElCZjI5VUNNaUpUWEJycUttdytQ?=
 =?utf-8?B?WDdnaGdzOE1tNmlHMWxoU3hYRGN4MzJDckNLV05QZGZTSjJFVmNlWnJaVUVl?=
 =?utf-8?B?alBJdTNIVjJGUXViczVPNmJMZ0s5c25tWldZQ25NMWY4N29qK2NmZkNHb3RR?=
 =?utf-8?B?USt4eHpPdzVHaEN1emV1YjhXaGk2WUpDMHNqc2VrS1VxZ1h6YS8veWxyWkJm?=
 =?utf-8?B?MnhqKytmdHQwWkViNnRCZ0MzUmlMTG52QTNZUFdZdDRGQzc0VkoxcDNQcFd5?=
 =?utf-8?B?ckdXZjg4Q0RhTG5nNmhVTG5rZ3h4aU9nS29Cd29HOVRPaktBRWN6cnFyUVFB?=
 =?utf-8?B?eWhtajJ6Rk84RDVTMDFWSkNoczk5dGlGU0ZFd0ZzamRvRC82eDNCNEk5VGQy?=
 =?utf-8?B?a3EvZm1SUlBveFhBREZLaDYxWmltQmhYdTBXdnBEeks2WFVqaWh1THBkYWhH?=
 =?utf-8?B?M2FETnluSExOR3NoY3JwWngzWkJJN0Y3dGs2SVQwVHUvc2MrZllFMDJYclds?=
 =?utf-8?B?VVpzcThCM2tjTFVQUXdEL1gyVUw5VzREK0VmRnAxSlVGdG1WUGk0ZmlwVkxu?=
 =?utf-8?B?cEM2dFRET2l6eVkrd2NObURHanE0QWpyRW9PQnd3c2N3TGo1eFBwaHlNVnBp?=
 =?utf-8?B?eU9uSjRqTzloeUJlTEFObVV6MEFWTFRRdyt1eC8wSjhaZ0VKbnIvU0NxU3RO?=
 =?utf-8?B?ZFEvT0p2ZHVVdkpGcVVycUhaZzJrUEM4U0ZoWElobTFlZXovcTV5T1Z4dG8w?=
 =?utf-8?B?S3BrcEV5cktGM2JJek1hK0JlSDNsZ2xvMTVnWldoZW9ONjVCOXZaR0dURUdX?=
 =?utf-8?B?dU5ibSs5YTg3Vkp0R0FiSXpna3YvY29iVTZoVkN6bmxzMTVKd2krRHg3c29R?=
 =?utf-8?B?bVNIZlRzUVhZREdGK25HYmtxWmdMcUNRUjdZYVZRakpkaWhxdkNSU3lGamZX?=
 =?utf-8?B?UWFmZEdCSzhkWDlLc2gxa3NRNEs0NVladUtCZ2JwcE5WcWpQeE1jK2xodjB3?=
 =?utf-8?B?VjlsNzlyeXFYR09saW81djJCcEJ4UXg1NFNQbmpoUVhjVVVEbG1QNWloVzJE?=
 =?utf-8?B?a0RCNzg3TFRpbHhYUnBJbkpicDkvSlkwWjFUbVM2SEdkLzhnOFVjWVRPb1Fm?=
 =?utf-8?B?VkxFeDNiKzFML1JOcVVGNWlDd0xlU1dmQXhITU5VRGt3NHY4eDk0ZE1POEF5?=
 =?utf-8?B?Mzh5Z2t4SzcrTWlTOEFsREZDL3lBdUdqdHd0ZGZtUTlrRXdtTEtnOForZnpy?=
 =?utf-8?B?NlVaeHh2REdQUi90enFhQStOZnU1Y3VnTHpRSU9xcmFKVG5qdzlIcm5uRUtW?=
 =?utf-8?B?QTNuQmV2Vmpic1ZBem9NOXJIRlg5b3JtTm9sa2hxSWJablNYMTJqbkRGb0F1?=
 =?utf-8?B?cmFDczJPVTVUOG1YdzJzRUxrMFhvL0xoY2VpY2hJZEREOTB5SGRwWlR2OFd1?=
 =?utf-8?B?ZnFXNlNrV25OQXovYjg2VVFld20wYlptcS9MblNuNEJsbHFmUXp6K1U0N0VN?=
 =?utf-8?B?bk9oaDJTbmVjVlVIbW94NDNtVGtTazlLU3k2ZjJLYUhtTU9DQXZjNWw4enNN?=
 =?utf-8?B?TjVwc1pHNUxxMzQvWGduTm9KSHoyWnRnbXNhcHNvWHhGRjRhSitydXg1Zkto?=
 =?utf-8?B?Vm1KRENyUFVkVStkUkV2U0NENUVmbHk2eGdpaHVzaUhFVUQ4UzJmK2ZNVG11?=
 =?utf-8?B?UjA3ZGxDYVJxa2ZwbHdxZ0s0cUFOdHc2cEpkUTZBbDZITTFHblc5MG1ZbzJs?=
 =?utf-8?B?VXZrUzFNeHgxTUZta3J4dDd6QnRUd1BMaVlqVDVyNXFKby83NGF1bVdmcVB3?=
 =?utf-8?B?bjk4ZnNicE14Z3lQQ0MrY2R1ZDNIRWFzWFRETGlxUUFXWVA2WGZQZlYwUm52?=
 =?utf-8?B?SnhVa2Vpbjc5a0ZlSXJQemJBcSsxVGp4eVlEZ29BRm5PTldOOWcyQytyT1BI?=
 =?utf-8?B?N1hONXpaRTVsZjRGYVI2VUdCS3JtOWF3QU05QStFQmI3VDRMd1hFS0Exclc3?=
 =?utf-8?Q?/ju3NZUPjCMAVKVbcrrn8tT91?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63da3fe-6429-4ea2-92a8-08dcccd01b04
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 10:55:35.9451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0E7ldLb26FvBPYS0czrMyP/PNSg9DOeeiKvJbbhfMW8OlFFAmM28tgrA6oS+PB8TA5Ox04FcVR2cv7P937Bo2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8583

The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
creates an embedded secure enclave within the SoC boundary to enable
features like:
- HSM
- SHE
- V2X

Secure-Enclave(s) communication interface are typically via message
unit, i.e., based on mailbox linux kernel driver. This driver enables
communication ensuring well defined message sequence protocol between
Application Core and enclave's firmware.

Driver configures multiple misc-device on the MU, for multiple
user-space applications, to be able to communicate over single MU.

It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
new file mode 100644
index 000000000000..0b617f61640f
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
+
+maintainers:
+  - Pankaj Gupta <pankaj.gupta@nxp.com>
+
+description: |
+  NXP's SoC may contain one or multiple embedded secure-enclave HW
+  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
+  enables features like
+    - Hardware Security Module (HSM),
+    - Security Hardware Extension (SHE), and
+    - Vehicular to Anything (V2X)
+
+  Communication interface to the secure-enclaves(se) is based on the
+  messaging unit(s).
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8ulp-se
+      - fsl,imx93-se
+      - fsl,imx95-se
+
+  mboxes:
+    items:
+      - description: mailbox phandle to send message to se firmware
+      - description: mailbox phandle to receive message from se firmware
+
+  mbox-names:
+    items:
+      - const: tx
+      - const: rx
+
+  memory-region:
+    maxItems: 1
+
+  sram:
+    maxItems: 1
+
+required:
+  - compatible
+  - mboxes
+  - mbox-names
+
+allOf:
+  # memory-region
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-se
+              - fsl,imx93-se
+    then:
+      required:
+        - memory-region
+    else:
+      properties:
+        memory-region: false
+
+  # sram
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-se
+    then:
+      required:
+        - sram
+
+    else:
+      properties:
+        sram: false
+
+additionalProperties: false
+
+examples:
+  - |
+    secure-enclave {
+      compatible = "fsl,imx95-se";
+      mboxes = <&ele_mu0 0 0>, <&ele_mu0 1 0>;
+      mbox-names = "tx", "rx";
+    };
+...

-- 
2.34.1



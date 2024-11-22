Return-Path: <linux-kernel+bounces-418743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1F79D64E8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 21:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A77E283310
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 20:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6D417DE15;
	Fri, 22 Nov 2024 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uwzBkckq"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034B319BBA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732307550; cv=fail; b=RVmTZEc4866vSmZxOsiPLKBa+HfzD1OUlP3Dobm9NYiIDuiZejcA34N1qj9RodR63w8h3FJnAqvu8cxOTyReeG7osIiCMerQg8NxtWZQVe+91Ic9u3dQhy5ICukhtIntfg2mFmw+LcFE63X65VNnT2IEUJ2WMjgoR8i4hkmd2bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732307550; c=relaxed/simple;
	bh=/HgpMLd8HtbPQGmj92iy5Dr3lMRIUvahHjd+tLELRsA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mup4OnzItTNYnE/5UHz+YjWLFPeBfKc2WuA/FQwcFymGSeA3pRpdsqK9r2p6ibDIYSGdYZjRBMn6XZbcq8SWB/aNZJ0nCwXyf3TGRnzqULpSv7DRq95frWNIvLNmZTzbVE+/KO0A2hGLH+DqsZ0K/+qV6k3vhYaG6C6YQSEBHys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uwzBkckq; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9cv6qvb6OXewCCumOJE1kFjHepJYhSdoTNKn85rmFuQ1ufu2GKQPmVD85B8SkTk4DHyKL9CRKEqYfLdfJZNQoGgQCVu8OUK91Tw5zwTBX6OWj2c4jqeyGvJEDl+098xPiVQ1dNzZ+S0u1veA0ox4oVJB593rg1AsZFT+cNMvzIrLsoTykRaB32tg67GvBAvobIPY/JTZAESyL+fOltBGziprmGaWAXau9LTozoS8jAnP8wXG4lcARwMVOY0wNQLS0L+rLWJqGYyLclRDU7z8Y2LCls/rPB0TEizS6aIcbpEcbtFj5oEotqF1EGYCptGw5ng+HOix9eQNZ2FJkRgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5p8aj590V6T47MhnP04EANmrRCaytfr+MuvgH+5OJQ=;
 b=H16Zz3BhsP0kqEUey7rcix08zNnu+LmM5T2kmwjHYTYJ2fUL7EXDWp9GlCD/j+XthidfUZy7pP392+Jg8+alI+yuyPrMFY2y73+yW1HKUja3J1arzW1GzO8gCv6fPNS4bKCyOmv+KHpqTRUk5r6ObpJjA9j+gw3bWYiwRyoj2sXe0PavHNctHj2D+eh3Dt2SLzISc6r77v4Ng5UQHwr8qcPUc5ws3zLHoEYwr/x2tuAJRiS2a6MNpY5v5HwRMjPIBt2aoNWNi3sH9FiIJMRJ7t76R5x26NxzbB4ya6hwcXJdJuicSN40gxZVq64SnOPXtlTwz2aiaOSwwo99/QmGtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5p8aj590V6T47MhnP04EANmrRCaytfr+MuvgH+5OJQ=;
 b=uwzBkckqqHmsPMXxAw7kzBXMXNMXRsQEqgJRmc8njIkQAxu4snCbbANDYCFzh4vKNKV0974/VkVo74zcgcQ2gH6eGd9LUbBbwluzLVQAfHQ1SUICiX3eNuGyTalSHPuTMzVpNANj0fW8RsEdu+u+4DEY6YDk8FX4rMTx2zAzF7Q=
Received: from LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21)
 by SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 22 Nov
 2024 20:32:22 +0000
Received: from LV3PR12MB9260.namprd12.prod.outlook.com
 ([fe80::e5c3:25dc:f93:cb99]) by LV3PR12MB9260.namprd12.prod.outlook.com
 ([fe80::e5c3:25dc:f93:cb99%6]) with mapi id 15.20.8158.024; Fri, 22 Nov 2024
 20:32:22 +0000
From: "Thangaraj, Senthil Nathan" <SenthilNathan.Thangaraj@amd.com>
To: "Botcha, Mounika" <Mounika.Botcha@amd.com>, "arnd@arndb.de"
	<arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"michal.simek@xilinx.com" <michal.simek@xilinx.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Akula, Kalyani"
	<kalyani.akula@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "git
 (AMD-Xilinx)" <git@amd.com>, "Botcha, Mounika" <Mounika.Botcha@amd.com>
Subject: RE: [PATCH 1/2] firmware: xilinx: Add support for secure image load
Thread-Topic: [PATCH 1/2] firmware: xilinx: Add support for secure image load
Thread-Index: AQHbOlCHZWSsHWhwLk+wp4Gxyhv2ULLDxaog
Date: Fri, 22 Nov 2024 20:32:21 +0000
Message-ID:
 <LV3PR12MB92601B314AFB6EFD9BA88881E2232@LV3PR12MB9260.namprd12.prod.outlook.com>
References: <20241119065840.8392-1-mounika.botcha@amd.com>
 <20241119065840.8392-2-mounika.botcha@amd.com>
In-Reply-To: <20241119065840.8392-2-mounika.botcha@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9260:EE_|SJ2PR12MB8807:EE_
x-ms-office365-filtering-correlation-id: d3cd597a-5770-49d2-b7cc-08dd0b34c490
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XgQgWUJwNy+ZRJXtOD5rp0qBz7GBzNekh3e8E07ChyFpxFX3ZjIP/h/HN1QO?=
 =?us-ascii?Q?pbaMFo0x+fQ9pazIzqFENYO8ACbJRzTQDtxeqvorjxfj7CS42ob5Dn54ZBgT?=
 =?us-ascii?Q?TUyUAu9H9uavfkPZQedyAMI6bKBc2m98OC7nr4NWLN/lLdkSNYfEhbvFTUUe?=
 =?us-ascii?Q?YUU5rW6Ce2QUjRsXuaJqz8DxUvU+o98x5AVwThPYaeziAt9yl3NFCLRFgLGR?=
 =?us-ascii?Q?5l1a18QOwc9iwKuuV4jgDp25raVwryr8en1wefo6v4A+5YxfGokAoUeHLxOT?=
 =?us-ascii?Q?bySifCfE4/5ba41On+omdFzjOJMQbSWWZTrCjIou7D+8Vc3EVvFGWfQQuFFk?=
 =?us-ascii?Q?pth1kk8lmNx4PJB4Wy+FztoYgg0BEFK9DxI/CdIqmhvHcRnxOj7Q2ItfnXPg?=
 =?us-ascii?Q?o6np403AFdMSB6Abn/58IBfJIk0ZpGWcFeFNX/DJcgRfBl084rfyHV88w1e6?=
 =?us-ascii?Q?LCQuVgUhN3uC7DHdNHja5zmM6ZUilZSxzoA/xehCUPQMeCpaLNvN8EQjLKqU?=
 =?us-ascii?Q?yHBw+2eYFiH928Blxb+809neu8+RHDf8OdStSf02bV3MEDNnBDNC+6UAL7lk?=
 =?us-ascii?Q?xTk+Sg9L9KNxnG3OE9KPy8G+eLSo+WBGJ/Stn8F1060sjUwFDzxHUVRW6z6n?=
 =?us-ascii?Q?YRhhcFQ3/qwKBRqF9CfxS2ZIUT8jzaZvTkhDUB+K2Dn7i+RqQ468rLT03Cak?=
 =?us-ascii?Q?LKrEBZzflh8dNmxGNHb8nA7tg0K/xBQwFUFIazEgOncNNaWZBaU0mLqH8vRw?=
 =?us-ascii?Q?HCVfQ24M4pgtJC+nHmiiryw1z/PfGEOqs4OiKOdzSpJgZYeqHlHn05CPGJ0E?=
 =?us-ascii?Q?FcxP8TVtqpJjFqvFSHb8wZgN1HlQF6J91zsT2o+WN2OmYDqXW0Y6XJqf78dP?=
 =?us-ascii?Q?ZMicI08HTHFeKMXzZKcQ4XrlTEjHt5Y9/1pUwdM3EcaiqybvKOv1uc6hPuhl?=
 =?us-ascii?Q?+HWV66b8oeJzz9G0k3gnHzj1YSqwpL58NUgQTrQfjvG+uvlp0FXR4U9GAkPb?=
 =?us-ascii?Q?DKx2o1pvQWt5tV3S7QAXa3szYULB8NothQLaqCvgTe1gayh2IB0A21hbK8L0?=
 =?us-ascii?Q?y9kPWm0d3aqbMaz+p1nA1dnp6wzMvdIcgGEnhjgZRy5jRU2iNAPCcpUMjKkl?=
 =?us-ascii?Q?IefCUKgMyEqkaLABpSd61XZTNxWm6hSWkNxF8I3lx52fpslnG6K1hkSc3RZH?=
 =?us-ascii?Q?3GYUO5XhYQEPNFwuZl1bK4Xf1S1NOcR3xqoCFjkunvZyGj0sEbhKQdKudBaY?=
 =?us-ascii?Q?zLpp6/Y/PkyqSyqgDz21Kkzb4pcWqf/KMCQqe9sPkNwICnJhVAbhx2cSKhlk?=
 =?us-ascii?Q?48ypXz7LPh6HCoTBYWYoIKuPHaOmWypp8tfbJPHgI0drRshkU2l/tpNZs0RO?=
 =?us-ascii?Q?BCubACJgOUyNwAyJ0zPi80UaoK4U2ZXTuiMbKdw4apI15U8VCw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9260.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?alW7VwC0nE8S3yRwCfZ/LBzPUU1S5JpzbMLQLPM30gQsCKgo6crcAjf4Djf9?=
 =?us-ascii?Q?ZG88HjAqM5/C50jLlUnX5SnzONNYMY5VDTuXO8Kst4EjrKnV/BvC/hVENSGW?=
 =?us-ascii?Q?qqQER5RXqQiaKjs9STWXs4mw5w5XB36NcBkKoBRwJ6LhmjHpXJN4t2tQagVM?=
 =?us-ascii?Q?X4dEdIt4F3iaF1YnetJA2hc8cW+nTByS/oEwjKf5TXCe3+RYvsTRApJ835MP?=
 =?us-ascii?Q?x4oOrPap+VwNGm97kw3zX+PSytw6giE1Vs7kyIj+HInH4nga683SaPw1kQNX?=
 =?us-ascii?Q?4EiAiNdW3pFvx3a1n8PH7bnXZFnVdbOARn14gzPdswQv+1eSaUbhLMg0FCrN?=
 =?us-ascii?Q?qNnNahcNVGMkrrLagLu6+kl4G3XtF0dwQi1nFOT4+etNk9oXMHMhVVz0N4Wf?=
 =?us-ascii?Q?DdDNIQMvgmfJu74Hf3HT6l/5vXIbA1ZgxF6YhkGZ9g+A6CvnLADqjJlY8zRX?=
 =?us-ascii?Q?kKXsLKUtSzhhNp476a0TxwXgSqZFjVIw1yMDp0t0FHdtADe16F8PwPU6zaTS?=
 =?us-ascii?Q?MmrHxm1ClaNmeTGyLth8O6fLJVkQQlkNJdtSJzOXJONf459dlFd18NdJ8/jQ?=
 =?us-ascii?Q?yRsIVytv8go7Zhdpa2FYsH3TpPzjNUthGWwpDKcER87fXVF0qK31gVwiZZEi?=
 =?us-ascii?Q?NoKbJrLgZC+nAhmYZ1aBp1siHnL+ljyrylxE6U4P68i2HkA+B8cV7tFSqggp?=
 =?us-ascii?Q?StoZ3+mzvM+TAcRlo2lisa7CY1b/hLGw0W6sTQwMm1IVZM+ybq2S0ft4+YIX?=
 =?us-ascii?Q?ljYpp85GMkG0m53696yjn8/gNqkeKm1mzgOJrbxdEheTMrkKn7HIhNEPPbYB?=
 =?us-ascii?Q?jX+ZPvx9CqLiyt52t/EnJObio0P/SV7aTznAc3Nd50b3WLcwBO9C2oSAbYx6?=
 =?us-ascii?Q?fenbtjUDNHxkZKzA7OVAmkefs2hS3cMfUu1u0NqnTNpKIbPW/Lc4xph6UM4k?=
 =?us-ascii?Q?bsltyk7VytwvVleibXAd+noogTxuUjVOBpt3dkSKznCfpH7CDnlWG9thUc2b?=
 =?us-ascii?Q?dErXSBRsBfEPhIrFwn/gv2HnKZ2YiIKwn/MsgRWQYALeJ2XxeN4AKmzC1YAf?=
 =?us-ascii?Q?pWWYPM1bU1EhVzL+vclWsxZMJeEJPDICNB/18fcdjGfAeKMuu6wYuuRPGNLC?=
 =?us-ascii?Q?mpOIt/jgdbW5ZsoZ5Q7/pv+U70kMIJTLD8qlutP+roFY+DsYch+hGqe/ZpRR?=
 =?us-ascii?Q?tP2kK6hH446ZUeOfqRx6om63vIdbeurp3UhuoGNR67FUb5SrNZ8Vpm0Y9sgU?=
 =?us-ascii?Q?mkbqztC6W+6Lgp9WkKscsp47TDq8ANk+wkRP9fzFci4+C2XTU4T/RdG95Rni?=
 =?us-ascii?Q?N6n/ukypF5mbJZLoeLgpCbLAT7HuN5DvGPyGxVZBQcLgMjz9G9Mz1W71hFQe?=
 =?us-ascii?Q?iRlwJ0rh/gFOwDYZ7cwlOAtp00mP/27hyrBfweEOFDJpnTEmha60SpE/OMdj?=
 =?us-ascii?Q?gYQp0HObmnsIwo8fHrwOsXM6ZXnloWLZubf8VuFEZLKEXcyMpQIVszXA8SzI?=
 =?us-ascii?Q?rVJNF82Ms2fsWqwuLTWiTbexJYhnmIAWZ5lLxrlrVQuCtmBQVbO7iyQSIGJt?=
 =?us-ascii?Q?C4vyR0mRiIRjI76EiRE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9260.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3cd597a-5770-49d2-b7cc-08dd0b34c490
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2024 20:32:22.0071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: apG1SFGte+8eOpPRMbEhSiIScaOXY0lQRJI4aI79L04sehJg3im4pkC5TjWyhkwK72AsKSpv1u8+24CvYkLoCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807



> -----Original Message-----
> From: Mounika Botcha <mounika.botcha@amd.com>
> Sent: Monday, November 18, 2024 10:59 PM
> To: arnd@arndb.de; gregkh@linuxfoundation.org; michal.simek@xilinx.com; l=
inux-
> arm-kernel@lists.infradead.org; Akula, Kalyani <kalyani.akula@amd.com>
> Cc: linux-kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>; Botcha,
> Mounika <Mounika.Botcha@amd.com>
> Subject: [PATCH 1/2] firmware: xilinx: Add support for secure image load
>=20
> Add support to load secure image from linux
>=20
> Signed-off-by: Mounika Botcha <mounika.botcha@amd.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 31 +++++++++++++++++++++++++++-
>  include/linux/firmware/xlnx-zynqmp.h |  9 +++++++-
>  2 files changed, 38 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/z=
ynqmp.c
> index add8acf66a9c..c46280241589 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -3,7 +3,7 @@
>   * Xilinx Zynq MPSoC Firmware layer
>   *
>   *  Copyright (C) 2014-2022 Xilinx, Inc.
> - *  Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
> + *  Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
>   *
>   *  Michal Simek <michal.simek@amd.com>
>   *  Davorin Mista <davorin.mista@aggios.com> @@ -1358,6 +1358,35 @@ int
> zynqmp_pm_load_pdi(const u32 src, const u64 address)  }
> EXPORT_SYMBOL_GPL(zynqmp_pm_load_pdi);
>=20
> +/**
> + * zynqmp_pm_secure_load - Provides access to load secure image
> + * @src_addr:	Address of DMA buffer where image is stored
> + * @key_addr:	Key address
> + * @dst:	Destination address where image is verified
> + *
> + * This API provides support to load secure image from linux
> + *
> + * Return: status, either success or error+reason  */ int
> +zynqmp_pm_secure_load(const u64 src_addr, u64 key_addr, u64 *dst) {
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	int ret;
> +
> +	if (!dst)
> +		return -EINVAL;
> +
> +	ret =3D zynqmp_pm_invoke_fn(PM_SECURE_IMAGE, ret_payload, 4,
> +				  lower_32_bits(src_addr),
> +				  upper_32_bits(src_addr),
> +				  lower_32_bits(key_addr),
> +				  upper_32_bits(key_addr));
> +	*dst =3D ((u64)ret_payload[1] << 32) | ret_payload[2];
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_secure_load);

Can we move the above function definition to zynqmp-secure.c as well? It's =
essentially a wrapper function for zynqmp_pm_invoke_fn.

> +
>  /**
>   * zynqmp_pm_aes_engine - Access AES hardware to encrypt/decrypt the dat=
a
> using
>   * AES-GCM core.
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmwar=
e/xlnx-
> zynqmp.h
> index d7d07afc0532..6e03f0f72427 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -3,7 +3,7 @@
>   * Xilinx Zynq MPSoC Firmware layer
>   *
>   *  Copyright (C) 2014-2021 Xilinx
> - *  Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
> + *  Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
>   *
>   *  Michal Simek <michal.simek@amd.com>
>   *  Davorin Mista <davorin.mista@aggios.com> @@ -173,6 +173,7 @@ enum
> pm_api_id {
>  	PM_CLOCK_GETDIVIDER =3D 40,
>  	PM_CLOCK_SETPARENT =3D 43,
>  	PM_CLOCK_GETPARENT =3D 44,
> +	PM_SECURE_IMAGE =3D 45,
>  	PM_FPGA_READ =3D 46,
>  	PM_SECURE_AES =3D 47,
>  	PM_EFUSE_ACCESS =3D 53,
> @@ -587,6 +588,7 @@ int zynqmp_pm_pinctrl_get_config(const u32 pin, const
> u32 param,  int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 par=
am,
>  				 u32 value);
>  int zynqmp_pm_load_pdi(const u32 src, const u64 address);
> +int zynqmp_pm_secure_load(const u64 src_addr, u64 key_addr, u64 *dst);
>  int zynqmp_pm_register_notifier(const u32 node, const u32 event,
>  				const u32 wake, const u32 enable);
>  int zynqmp_pm_feature(const u32 api_id); @@ -854,6 +856,11 @@ static inl=
ine int
> zynqmp_pm_load_pdi(const u32 src, const u64 address)
>  	return -ENODEV;
>  }
>=20
> +static inline int zynqmp_pm_secure_load(const u64 src_addr, u64
> +key_addr, u64 *dst) {
> +	return -ENODEV;
> +}
> +
>  static inline int zynqmp_pm_register_notifier(const u32 node, const u32 =
event,
>  					      const u32 wake, const u32 enable)  {
> --
> 2.36.1



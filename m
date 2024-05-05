Return-Path: <linux-kernel+bounces-168866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BEA8BBF0C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 03:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0F19B212D7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 01:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E600E17CD;
	Sun,  5 May 2024 01:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MseX6TFv"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2072.outbound.protection.outlook.com [40.92.23.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47413EA4;
	Sun,  5 May 2024 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714873859; cv=fail; b=gfpWSxLUg62SeSLVbG54L3NzPND0XobSzpbVY2pm1cq8pXoCcLBbbaHgDsPntca6J7at4tGwqF9qZMwqPOyedUSRqRdu+wHgAOrse2DYtcFmOLftLxMN+eK+ZANAQ4GIRDrCUS4tOVU9Yic3OghtAVQFcEyzLd3EKGoCgYSyivU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714873859; c=relaxed/simple;
	bh=oPmJWxteKxfowPeOXkpbQeSvpY04J1IJkZHhEF2xSN0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qomHzbuiC62ndj9tggj5o0WL2gnkWFmUBbx0zKKKsGC1S9UqSx3Cix8S01DavjQp/c0C05Ou1vk3NNKeTmjaQPgofnAAY90Y0kRYeHvB2Ofk7beAuAt1ZxW3AshvrDnLfdUnT+px/pySUNZvEff/1Pd8Yb1Am/If3MEbCuNaMVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MseX6TFv; arc=fail smtp.client-ip=40.92.23.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FH+8MGy+02gNHFv0EXiTYNGl+Q8umPcGoywtY+XxfGylAjAP+kDExPh+fNO5X4WtZWFEq1WRAdaCPWEmbWveL/xXfCuusCC4m/34kefg/af4AUSPD/SdSh5gQ+iwTZZOOnfV/cuddsUP00BihUDPJfQqMp3PkxchAWRl5qhrdM9mFGp7IOLRiiKKwXgFptiU3ZXyQPOUKMK6VXhhEsyjxkzfRZwTqJa1nCDBILMvDWbTXyP9fM3WaaM5G/DXrrW1zQj+2Huogy1lcwo+WNfZ3uv1gFJ0Ty+TOkiWKPUApQpSHM409UzpYOZmpK/vwpzFlTjnXNSvNWZ0N9shXHvPIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3TzbBD0Pd7T/mFJRSVqGvIOLOUKQv4D4TKeO7nhL68=;
 b=fJLitdKzNMXiuOgPG9y+4ZWvgyFjqwgYzvkIlaYlfUXalxaEm3YO2iSYn5kknaq41oC8oAQ8Kb/xunBQq1NfLJAxybA4FBs4rcZK7fNJP/apLzSuGRB49peFHOoTI6/ir2ZOvy8q822pIjL8BK1VQ3BDlqwbuKT5gxFmQXk6yWN9zBfbHq7Y+64y93b1lMhBplvKJJhr0ucMVtqZvca9MZpW0uxld5iIOrQpPpnBlOEjMfGFV4I+fmIBBHMJLMh8QmifV7BV0pTp4c+GYRi7JvAiPVX3PEpGpRcLGMrAa0C4QwhcaIR6WfOz1PgV14vLRCGUQHB/cWDtkVuvzm0OvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3TzbBD0Pd7T/mFJRSVqGvIOLOUKQv4D4TKeO7nhL68=;
 b=MseX6TFvSWJwZqxWQMZ71bGH2IhroGNmDV9BnqQDs72dx6NbnFCERPSAEay5ihHxcPA5pMSUbCsYwFgQ3wDxCNiqFfljSlGNpE70N5XpCKP7EMFfZqa3V4inXxtfiCUwIVTW2Ub+Qv28hGU8ddyuRhmz/w8+ykWJ5Y+9sVhpExYwjW3nsNgo53DjEwTlouPr4aCH6PPkxxQzkju31FtaBv8sb4ZvKccYqPpfEOwxqA0JKXwufSIOzp6DCYQm3j4BiGtFPFe8NYx6wtueVKcnlbo/MPK6CEhqAjutODJ1STN0SjuktJ+3HGTY934hbXLzjzT318pnilGFon3IJJVE6A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH0PR20MB4304.namprd20.prod.outlook.com (2603:10b6:510:12a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Sun, 5 May
 2024 01:50:55 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7544.036; Sun, 5 May 2024
 01:50:55 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v3 0/2] riscv: sophgo: add USB phy support for CV18XX series
Date: Sun,  5 May 2024 09:50:31 +0800
Message-ID:
 <IA1PR20MB4953C1876484E149AA390DD5BB1D2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [3foKvUZL/86PvYO/IvNO6BesbAt8pKGLIsh/EaoSx6w=]
X-ClientProxiedBy: TYCPR01CA0201.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::18) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240505015032.752143-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH0PR20MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: ad4fdd9f-d60c-4747-ee1e-08dc6ca5cd6d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	nzbfIpmcJJUpEpi845Ivd9mNXYxyK8R02hSNSbUIJ54DOmNRDs+e+KPFVHiEtILq+QkmNhZqV0CrvxqGFtdqZpaxQvbQ6rhmoCto+oN3nxW6PEcyoVnivR1jJaZm8rHwOD3+A4xfA7N1D2ej549NZtx1qGl+/XtG8claqF0RA1r/csAFnudb72DvnivP0+bmOOLDFO4hZ6eBYriTyPKf/TwFNydWSKdmGYjcKEEDOraLMpIh60/fm3P/NiH51l1Zv3CIIv+oY7JJyPJXPH0FROHA72huF2Ur+GwC/OqHkfWEFmiEL4DOl5oWlVEvpY0W1Cljv/9NoCsHa/csuiBTq/qOjayz2IJweht+a1i6d8gRfN6meZ6AMXMdA27UM+woYQRnT8cyNo+pQpKxacvfmTQFR/WYuTaQF6dpoN33RxGJJKoXi4w1DE+WM+V/suMsgv7vnxzxD+B+fiLg93DkICYih83Cw9Syn/+FlKZacFbWFGT29ISLUsVQLRZY0r7jso57QSg5rtoQKTe/m3+wekyEYhYVWmtIMtochN8WEmj70XchZaajaF0N02nNDJTqSGpxvs8/6X27m7JgsJviNIjQRwjAHCJSfB2rJCBiQ52oho6/shwRQfnRaEiR5eRs92COnN1G4eeyG94OVYt7hCGNYX7GVAJoHFB3t7pfrE491wPURiBlPi4GKoFOdmFN
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G2VVOrjGTmnKLTQ3of8iwSfjKGxxxZfsPOHJh064Qky2Ai/BEbSSZPacA6ui?=
 =?us-ascii?Q?lmINeR4jid8u54MJS+pyQYYi4KzcnEucperBxk0nnX6TCLWR387v7t63hf+C?=
 =?us-ascii?Q?NyTJv+9evAZO6dfvZ8RWigJY9D7lwr5Im+ZnPwSoG9AQTEjuCONEWQjG16ie?=
 =?us-ascii?Q?/QAssyi0IAh19pIopGx0zyTp29vZ3PYlEKmXsHN3SKgwsllvOjdDW6I8yIur?=
 =?us-ascii?Q?CJWpxIogLIOZkR8JLri5zEB5yjaNxOHNMLf22CmmwHAC1yNpF4C3RNv04XQr?=
 =?us-ascii?Q?MGieQJ2Xb7JfBDDOY59z3KMHpXTtq2AfeEzp7nDmzEkdS0dCrz0+Iv43Etol?=
 =?us-ascii?Q?sxGNMqEIuckFgzLm2FOtvH59UxicYUP//rP5QZXMZPX8GVvW9Ge5YE2bgIGe?=
 =?us-ascii?Q?uGpCMysm4UBY7aJO9aRShjRpelA0/H4gWLMHdsPRoynEaA9HX3FjyVwoanTW?=
 =?us-ascii?Q?fwjNJMUpxpRmi863ba800qUJTZvgH20GqcHWabXQ3BOGxBJhpsU3EwoqUe7k?=
 =?us-ascii?Q?sHNei2irwUhN9nZiXU6fnemVCpVcEFaoIXdaJywlk1y9LldtGqYfqBNuG4T/?=
 =?us-ascii?Q?8rawIZBSeWy4gUhLP/cga9rQzR0blMhR9u6qZEwmUaF1GhagLqJtI6TKJUxJ?=
 =?us-ascii?Q?w+kLBknJfrlMqjKWeIKIxAfzuA49HlRir+fksWpYiHTwfH5QHk12yGYHpXMY?=
 =?us-ascii?Q?EmfmpsuBR50ROxIntv5yo8DrZGAOnOL0A/jYYq7XOWNv/r/dSmV1p42SZ5rR?=
 =?us-ascii?Q?FLygLx6IoYEz5rMAQjbrCWqvrxH7TgnXFNk3Mp7yCW5C6aFLdn/CYrFPEOb8?=
 =?us-ascii?Q?++uKwRpfM3ODJFwGR8SnFM5FYOQaxcSFOOXkh6QAeIOtgJzKddrgRpf70B72?=
 =?us-ascii?Q?6dfOrLC/UcHYMbc3Jq7TZ2vVUy6aLdg0INjaniN1UlY8eJ7fD0zWsJHMz/CU?=
 =?us-ascii?Q?KFtGojeZadq2SfR0/HtLVtXhC5xeBexkms6rTmdw7SMAbjj7VfrKg/p2z4DB?=
 =?us-ascii?Q?+lqQx3YyiWeg68W58m15B47aB7d4lXNzpew8Zw1uCRC70UY89n6vg7jxcwpo?=
 =?us-ascii?Q?J9AQMdUWOIynH6tRJYjkvEX67uNKdb4rKzB/a4zOy5jHwHLhduFm/seMEIb/?=
 =?us-ascii?Q?THtucZ7jdXCRGIAvagwvkzAnQaID8jwcqPGZLmku/CDk7z+dsDLkcQcx/cX1?=
 =?us-ascii?Q?0kIkcDHTaFJRPsAPIR38noUcODX+DWyPMVOBix0FeAxAT/ZtPv4gcoc/xWl2?=
 =?us-ascii?Q?jXDekxSTpuwVOHqVXxG4?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4fdd9f-d60c-4747-ee1e-08dc6ca5cd6d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 01:50:55.4875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB4304

Add USB PHY support for CV18XX/SG200X series

This patch depends a header to build from another patch:
https://lore.kernel.org/all/IA1PR20MB4953BAA0F8E06CB202C5C2FBBB062@IA1PR20MB4953.namprd20.prod.outlook.com/

Changed from v2:
1. add item description for switch gpios.

Changed from v1:
1. remove dr_mode property and use default mode instead.
2. improve the description of `vbus_det-gpios` and `sophgo,switch-gpios`

Inochi Amaoto (2):
  dt-bindings: phy: Add Sophgo CV1800 USB phy
  phy: sophgo: Add USB 2.0 PHY driver for Sophgo CV18XX/SG200X

 .../bindings/phy/sophgo,cv1800-usb-phy.yaml   |  71 ++++
 drivers/phy/Kconfig                           |   1 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/sophgo/Kconfig                    |  19 +
 drivers/phy/sophgo/Makefile                   |   2 +
 drivers/phy/sophgo/phy-cv1800-usb.c           | 378 ++++++++++++++++++
 6 files changed, 472 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
 create mode 100644 drivers/phy/sophgo/Kconfig
 create mode 100644 drivers/phy/sophgo/Makefile
 create mode 100644 drivers/phy/sophgo/phy-cv1800-usb.c

--
2.45.0



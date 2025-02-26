Return-Path: <linux-kernel+bounces-533007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D9AA454C2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD043A8C63
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A17C2253E9;
	Wed, 26 Feb 2025 05:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="KsEQbYGz"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2121.outbound.protection.outlook.com [40.107.104.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3FC25E464;
	Wed, 26 Feb 2025 05:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740546107; cv=fail; b=kRchZ+pxSsks10gWiiyO2d0A0IfKYWaTQVAfDYRjcq9IAI96x/lb5ZAuyqKoZ+C+Fs4j7AhPEmDJNCEOYXXcd9vp55JipFl2PFI4wqq5p+XaQMKtcmjivnANTDjD18kPeUzkfi7gksrK1fiEeJhOR4BFc2+FK94JhTo3oWhhta4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740546107; c=relaxed/simple;
	bh=hSj2TSfC31oZ/+yj8hhkfv6Osx3XkXiq7IVAMIWzTIY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eKq6fqUDGgo0445ZjvKxPyNl0VLPQ+5BhPZCEs2YmO7CRVOxKwyA4ONbeUzBP84ZI9B5eL5lo3ikGPFzPx+yz7KQMkMoj7qRIqefFw6D0E0HtGoED/Owl7g0f/FXryVq75txFxV9JrA/OM4iRPq8in9SVZeA1TnLz93bN4TmCV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=KsEQbYGz; arc=fail smtp.client-ip=40.107.104.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WAZnJaTmXnct5UsbhJ/oExfLpSzoN0O0L+jZ5RkDbdO9zgdfWPD+F6mKi9nRAi39cH8KAh62ToMY0iQ8jNVaAiOZqgAE3VGkrf/XozTHE8B1JpE9WsZSTOlJxiOL2b2zCDwkKuF4O0lALPm0/54PpSdKQn8rZJeUDJEuK9ondoRm2NiLsLyC7IcuhLOc8jYTQgdqNj3Y1AgwRD6roG2CH6BPZx/MRJmMyVOhNFV7Gf7Xj/wBPwZG5zZULkNZlp+OLBu8s9vcYd6pDRwNjQdC56OKYJ5JOmQZpBQXjTOaeiJ1ZIY12jbYEEIUIFT6Kbht15HF2lnc/CDNKd/KMTcPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7JGj9Y2NvlR+Ur5b6WMaXa2nlsT9ZFJEwFDS8Jks74=;
 b=lKxaa5jTbbdZ2Y2aqsv4S4lgICG8Fo2tXFH4YSPy9JCEgYwP50rYIFO/fsakykEGAd8aKM9Z23C9yVpFHn/Bio5KK2kc2HC3qUoBhFyoIieV4BVfroL7fDIpYK+SfkEpF7z3WWEQvQj6KYmaRwclbzpwg8zwgP/hyipMd25RViV1fubyNuCFe4YIoeL6gTso/D9kNox3ZGM0D3vjhREPvq47O0++Aw+N5CIZtGxMXxrEXHKlaUs24PR9dDFRI7arw14HuI1EACZNs1Pci9XzURN8qgfeGrRfi3YASThtEN2fpf9Lqw1yLC9of+mYAVq4plHnRraB2EgqqU7pHJB6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7JGj9Y2NvlR+Ur5b6WMaXa2nlsT9ZFJEwFDS8Jks74=;
 b=KsEQbYGzBH1LFIEJvy36thpFi6D+28zYnTG5OjheGt9wPkpQCQFXl7KNmearqZG7sCfUTHx/4IvqhcvvZPg1bu0TmtH+8flyRK1zqyp2jn9Hfbzk/8zEdHUR5iVYY80Z6OFSL+xnu0PyrKV+W4WQ9dCS6tcRMKyRRR9L62iW27inkG6tj2uGf91GR11NkJbRfX162lCAzHrC9vRQpZWyzrsUAwKN9xPAGgFvsrDJwBq1BCLNw8faqEWwzd/0F5LEI0M1ezXa2DBf2sV9y/UwSBW3NoaICHzvpsKgUN2PqkqC9qIo80uJK3eMFoRtVGOeNtPvLuOJKqJlmgs3n0K6QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10054.eurprd08.prod.outlook.com (2603:10a6:20b:649::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 05:01:40 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 05:01:40 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND][PATCH] arm64: dts: mediatek: mt7986: fix pwn fan settings for sinovoip bpi-r3 board
Date: Wed, 26 Feb 2025 08:01:32 +0300
Message-ID: <20250226050132.547353-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::7) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10054:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a18c20-411c-4d20-b564-08dd5622a7d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZGN4iA1L2aGqn8h0CR+lPV7gzMfGBW8T9+K9M0pIIefSsJYCy5BkQIml6z4x?=
 =?us-ascii?Q?QfO49LgCTLWnhbycDW3ZMbcsxNYctEEqXnP5zYZdcFvbo0Q2GjjwDLFQrpYH?=
 =?us-ascii?Q?KxSCVrVJ6s9ixLRa2Mun3iPdOJFzOuCi0RkRtXSP8DLRX4DxlyWJyyx7jm59?=
 =?us-ascii?Q?WSddDzGxzwfKNimCh6081XbUcU4lRiCo80lp5eQgbL6MSrDnzXRRFvdtngGH?=
 =?us-ascii?Q?1Xh0sJ9eTi2sFQKR9yCOX+aPVRsZGkdqD4VYf1RVeizERQpPDMfCLeav/LRX?=
 =?us-ascii?Q?g9H/YXXIDvOv0D1hY65JDP2KO13gHoIrt4qrxa4jjFiH+i4TgaIT+r8Rv2G5?=
 =?us-ascii?Q?rZHHVNpUKV4rtS26ZTxET1KU8cVH//cW1B5MMJvhyoyY6w1oFSQavylfaIs0?=
 =?us-ascii?Q?MF1glPPQa8zUGXrgtxYOuE2VmC2E4e60h4zev+0FLLj1EXnVMV0TEVXByOYL?=
 =?us-ascii?Q?a4WTScEnZOcefNPkXdUQBQ371lxEClyk5ECbVCgkCnzC6YRgSZPI98dJSTcz?=
 =?us-ascii?Q?8WOlYbaHSbnRizyZW7btF2jBH+0YC84Dfel/jO9tu7zW7yjH5pNLd9fm7nGE?=
 =?us-ascii?Q?+4P7mM2XuT1peVJozguQfqkrZ2T1ya26exZhTFAlOZlHNAxQ59tA3rTFWBfj?=
 =?us-ascii?Q?uLeAavcgDM57xd4pxA4YECm3yV+bruhVNEQajczziT0AuFVw++0HGF5a40tS?=
 =?us-ascii?Q?T5VXp3fgHxNVOEUpv5RjgFeHUvNGj8F3FdcXo0Dy9gTvddn/PS97k/VFybYi?=
 =?us-ascii?Q?gSP0Av2g2rTfOKoaicTJ5Di0Lj15yTLRP7TqzXFRHk9V7JnYhSh3ysMATewM?=
 =?us-ascii?Q?x7i2U20gtifFfhwi7pNe3sB2fvmzSvAlL/4iXNhgw6tNYKOSlMBUQ5E0VATB?=
 =?us-ascii?Q?97UyBl4I1Zt2yDkdqvshK94vV42QA3DZECHQtOr6kChZG/vqqxGoLcYl9M8b?=
 =?us-ascii?Q?CxF60ThIruMZcG1+B92XR5v5hGRV3JrU24saIC+MjjeLSxlc7CLGdM9tmgxP?=
 =?us-ascii?Q?ws5Vl1Zu6v5hTeHWaOpUCP0ZYaZvKQ7BKRRfv3MHzBTCMrCLnjHl+lL1WcYE?=
 =?us-ascii?Q?7DM1riv38ud5oB34mB80WPpn4odhjUfYzHho25V++wJYxLrHujgzkNmZGYxI?=
 =?us-ascii?Q?dO4tx/d6g0nENKn2Kfwhum9tBNa7+w0KhsQEU80ggYGTOfX3Egl+wpkVMxAT?=
 =?us-ascii?Q?DaC/CD9m5sPI33RkYCBXcnaOsy0X0Vm94P3Tx785Gd8v6gyo9COGJEGPe2s3?=
 =?us-ascii?Q?RmwG2gJ/9enFtLLzpEBdDRA1ekkFCNddCRn3J+fQbOcAuGN1Y+yg3VckLe8n?=
 =?us-ascii?Q?R9rqoURlV4XVgFUY29lwpF8rjjpK6B6lZP3MaG/XpBTm3HKhw4cr+yR47cF8?=
 =?us-ascii?Q?QMy+1ZtVKPdZEP5UmZM6/ywA/sYNACyF4LZSFxbFwqslUN0bx6oXb0g52mA0?=
 =?us-ascii?Q?G19WNAXz1q5rr8pcYWEPLNaSyoL67mwp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CMTHOU7YEj+vNhktFXXa9uPRO2uxp/iWpB3hm1FxJYjPHvjB8xGiG4NFlzvh?=
 =?us-ascii?Q?8CcCoIa1siP+wvIUXInPUV0oQNcYh4Xk6jOQXNX1/113AIKKPyYg2l8IgqZB?=
 =?us-ascii?Q?7vj3QzO/0HFjYGjayKRi6qnrTg1+IyE10mqz7S4DjLm6l4ddsBmAWve02wvn?=
 =?us-ascii?Q?rM5KlCC8lWMlNQ/rmC1TrFNu6504YbiBSoSbO/Jt2U5tXe+vZh/ZW+/T0Lmw?=
 =?us-ascii?Q?+R3RBdUNazDMVPCubFmgGHFjUsF+afSRZb6hUeb8tCrhuZHmCjoQp3cKO6n1?=
 =?us-ascii?Q?fN7wi1vkf3OjSgSbzA3SDBK2VO344Iv8XC9Y/gopyZpOcHT54GGP4ln4XIzH?=
 =?us-ascii?Q?y9BBiAMELsGaTe53sjpmYQaeBwJX9jgO55lfP+Dl4x/cUnm+xCPkroj4pbLs?=
 =?us-ascii?Q?FGexF8sAwAuCXvgFkIhI+5+/vJkge378g+E1nVkbtwzcoI9oA942ipF1jBSo?=
 =?us-ascii?Q?vOlEEp5pwiKA8N0sEMIG6yHSKTeLvmfqUwqFyck3OsZ2EmqevZsUzDKGBZKe?=
 =?us-ascii?Q?i5gYXKZCsSLHo5gJ3SFYB7LUXV3VudCe6EeKHHONbqrK21S5IjZsjwaZCm+f?=
 =?us-ascii?Q?zcClgD15BjswAuNoCPGySAS9PovO/eqUK6arJ4ViWd9MAXiHZLA+c+kpMFql?=
 =?us-ascii?Q?CgyN4etlHn9DJn15oU3+7yVj6KCvlEWII4TKrlenTUp1DD2Vz36Uo4mogIvK?=
 =?us-ascii?Q?5svUqS73bDwm5S7+O5tSjtvLOrI8gbWfwyXn92Veyu2E61advljuArarpxef?=
 =?us-ascii?Q?GnzRiGgmkLbsfSYmqYI2TgDxHALI9iHQPc2vYwWrimWrexY/iXwQNjTiXnZ4?=
 =?us-ascii?Q?doiUk2T/UZZlf7aJcKfHDN4Ww3XINbHwknYqaAiYA11hW5wqF5iAYFroqktU?=
 =?us-ascii?Q?I+ziRFpNUz1qJyHLx/4GIQDnKr7NK3DGyv5Mtz9jl8PWD/oIipj9FL5/icem?=
 =?us-ascii?Q?JPqHvoJmSqDlwPMNh/uLavKfX6a8nNRAQZrIrEequO+v/PCW6b9ReBIWVif2?=
 =?us-ascii?Q?paq+X9/c3DlAKBFv+r2R9sB+JkAWTIYTHZNORA3/WTg9WHUjlqmyfHf1B6Aq?=
 =?us-ascii?Q?/vNKCpAyxPgJE89PC1pWoSRfMhACzoerCSwz2pqkJhy1AC7beBK8VV6diIN/?=
 =?us-ascii?Q?mWsV2f1dVhaNSLePMjwb//CQT0Siho3jEjWPxUpIfPkV6KnJ7k9kC2QpxiSi?=
 =?us-ascii?Q?dNBkBZw+tjLA4i/PPcIvshWwf3+EFrNAzozhmtcwVEymXFTGmRx/EPZGxWR0?=
 =?us-ascii?Q?CW3uGNGfgnUZJHjfv6zVjoNdnn/jI64Ao9Az9u5ZiWFGDKxf37vGCPEeF5aS?=
 =?us-ascii?Q?kxLYSofAxrzhQ+0Pvs1byoc/BxUETL8oCSKdsBh6c2US0FowOkpmL0MauxXg?=
 =?us-ascii?Q?R0wUBY3N6/FrMlKFFHvf4iR77ehPl/TPv2Gs2/XoMg35QysSKH68/jRWo0Ol?=
 =?us-ascii?Q?tu93K5K65oZbCCeO4r8pvtGRlBLgFOSSr/xYRObY7dae2lr53xVR2GD7Xugf?=
 =?us-ascii?Q?tHyPAmy0syESXGJWUvvA64xAo4WO0egj/FQAlLPUQcnxVUHFD2+13qSIMnex?=
 =?us-ascii?Q?Vmw/YyIbQWcqhA9m3PcZiWfeC1tyA+GEw5kmP6zbX4A9V801IsgszHGaNPvX?=
 =?us-ascii?Q?UAa6WpbQMrji0T2a6+sMuFA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a18c20-411c-4d20-b564-08dd5622a7d6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 05:01:40.3271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fICigIYkSGIJHHNroR+CmPxxZqJSLv5UPCilTr9L04MHGSz57pm2QRX1XUSltIs34UcuRS7vfikTW9E4stEEvnTNBp/qqLlmEyLvgTNztMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10054

Popular bpi-r3 pwm fans like this one

  https://www.amazon.com/youyeetoo-Barebone-Fan-BPI-R3-Integrated/dp/B0CCCTY8PS

will not work properly. Trying different pwm setting using a command

  echo $value > /sys/devices/platform/pwm-fan/hwmon/hwmon1/pwm1

I found:

  pwm1 value     fan rotation speed   cpu temperature     notes
  -----------------------------------------------------------------
    0            maximal              31.5 Celsius        too noisy
   40            optimal              35.2 Celsius        no noise hearable
   95            minimal
   above 95      does not rotate      55.5 Celsius
  -----------------------------------------------------------------

At the moment we have following cooling levels defined:

  cooling-levels = <255 96 0>;

for cpu-active-low, cpu-active-medium and cpu-active-high modes
correspondingly. Thus only cpu-active-high and cpu-active-low are usable.
I think this is wrong.

This patch fixes cpu-active-medium settings for bpi-r3 board.

PS: I know, the patch is not ideal as it can break pwm fan for some users.
    There are some peoples that use handmade cooling solutions, but:
      * discussed cooler is the only 'official' pwm cooler for bpi-r3
        available on the market.
      * most peoples will use passive cooling available on the market or
        the discussed cooler.
      * the pwm-fan dts section was added before the official cooler
        appears on the market.
    Thus it should not be a lot of harm from this fix.

This patch may not be enough. Users may wants to tweak their thermal_zone0
trip points, thus tuning fan rotation speed depending on cpu temperature.
That can be done on the base of the folloving example:

  === example =========
  # cpu temterature below 25 Celsius degrees, no rotation
  echo 25000 > /sys/class/thermal/thermal_zone0/trip_point_4_temp
  # cpu temperature in [25..32] Celsius degrees, normal rotation speed
  echo 32000 > /sys/class/thermal/thermal_zone0/trip_point_3_temp
  # cpu temperature above 50 Celsius degrees, max rotation speed
  echo 50000 > /sys/class/thermal/thermal_zone0/trip_point_2_temp
  =====================

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
index ed79ad1ae871..b0cc0cbdff0f 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
@@ -42,7 +42,7 @@ fan: pwm-fan {
 		compatible = "pwm-fan";
 		#cooling-cells = <2>;
 		/* cooling level (0, 1, 2) - pwm inverted */
-		cooling-levels = <255 96 0>;
+		cooling-levels = <255 40 0>;
 		pwms = <&pwm 0 10000>;
 		status = "okay";
 	};
-- 
2.47.2



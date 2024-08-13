Return-Path: <linux-kernel+bounces-284362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CCC950033
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B931C22AF2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6539319CD11;
	Tue, 13 Aug 2024 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="jhbSQ7Z1"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020072.outbound.protection.outlook.com [52.101.193.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B1A17C231;
	Tue, 13 Aug 2024 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538543; cv=fail; b=R2RobuU2F2d6diDdbmKxgN4ARr+6MaIjESMlMeN6I1zkbvuj58IZSrruf9xG8r/OJw13JN5sQsDLwo5cGmWy+qkhnAIS6lAA5yw1a3l/VD/388h6H6DalfAW622Xqoe+vcFCqvDVS5r/NLZN7jWe8H01wFGGmh/0tQE48r2IW6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538543; c=relaxed/simple;
	bh=57oiuV8vzEl66eeSveis0Su8VNvtJh27tS+ALq+aPgM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=m1C270DlB0s+uvXitT3w/eW5lq22XqP1LVhzNfZy4hjoufuGoElVMAmjbu5A/NDxvx+1TOA5gvUn49YyE161+sQMC0wLuJGntzzZ2GC/rDONF0hmufbk2+ltmp5juRpqAynqZm6523lTkDqx362NaBcjNjcxLTt3mZHbGnJE84o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=jhbSQ7Z1; arc=fail smtp.client-ip=52.101.193.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3t19UuVhKIM2jgJZ4zW/fb6PGRYTrDLpATBQKkU9/MbD+nJYaUw94cbVQbZhfD5f2YD+OXovYGUv0xHwgGJnis/+ZH6tpC1EGRMgmz4AoRlqXk7y8G43Mvn45vPvaD8JFVahQpg61F+2Zvl4sG+FItM46ERUa+QE9wXfuuP6GB7U2GfwyXviEQ8hmWAwFXqybcVg8b3jaf2CWQJz8wDXPlv0weYzlRs3pVqSqi0cAGxy+rE6NWCsG5Oyw8pO0WmRb2QYDcH4xI9szGFU47o6lvBWBt+U0zMI6bIAlz0gZn1M0l7DWeq5PEijZSxNB5xdEGoGPmpmKQ0YoOY7eqGsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2seuTs4FhM6PMbB+991Xs2fXiFRKknwp8NsNQq0HcHg=;
 b=nPuwwcae/xfUFz9dIjIIyRLQkQZBEA2z5r3IfDpOXlQ4/Ttvh4mE6phyx3mTbYGE8qxZzd9wBOkQlZP6KF2m1TpiFCa96x7+1U5zfW9K573ouCpkn7i/MH3ensMWZspDY5jvfM9Z+eh56WhpTShMpKe8wf96/2WS9U1jTH6I3EQqzgzH5WY/AYtRoOHZygJpylEvHYBHdoa+8CaDgC/HumYLBv3L+JOKZQPxR5YfI/HIFKVsyexDTafLm4TD/EERWghzQluLIQPj8FpP3e7il+Ejh5SlGZU7b+OwI1OrvB5PEHPQoVh1U7K4knzcB8UgAp/tddsIPamzR23jAxawPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2seuTs4FhM6PMbB+991Xs2fXiFRKknwp8NsNQq0HcHg=;
 b=jhbSQ7Z1jcQ88eXavX8fotMMg4UN0K/1nLsk6QR41IbB4gj1+DRSRNhdhgPd49JoJe2pJ9QKD5zrCRQ9xevfriBtP81oC4OY+TjySh3DdfZEMb2fZGCVcTBjusHN2z0QiQQfOK5aLLzC0T/ExBqK15+oQ1vX4GwDeAK8GvboC3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL3PR01MB7057.prod.exchangelabs.com (2603:10b6:208:35c::16) by
 CH5PR01MB9029.prod.exchangelabs.com (2603:10b6:610:214::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.22; Tue, 13 Aug 2024 08:42:18 +0000
Received: from BL3PR01MB7057.prod.exchangelabs.com
 ([fe80::b69e:5684:ed7c:4d09]) by BL3PR01MB7057.prod.exchangelabs.com
 ([fe80::b69e:5684:ed7c:4d09%4]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 08:42:18 +0000
From: Chanh Nguyen <chanh@os.amperecomputing.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Justin Ledford <justinledford@google.com>,
	devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Open Source Submission <patches@amperecomputing.com>
Cc: Phong Vo <phong@os.amperecomputing.com>,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Chanh Nguyen <chanh@os.amperecomputing.com>
Subject: [PATCH v3 0/1] Update the max31790 driver
Date: Tue, 13 Aug 2024 08:41:51 +0000
Message-ID: <20240813084152.25002-1-chanh@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To BL3PR01MB7057.prod.exchangelabs.com
 (2603:10b6:208:35c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7057:EE_|CH5PR01MB9029:EE_
X-MS-Office365-Filtering-Correlation-Id: 1efd61ce-db54-4ea3-14f8-08dcbb73d685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IW5qLS5d6H7ILN/SCT0kv4OOY/BxFCeuSnhHarI4eeB7n5jZ7nbTrFZtBAoU?=
 =?us-ascii?Q?qYtTOVD179QAgxi4yKyiP7B2hkZAu1LdAshuuwiEFGXF6/NJ1eOX4mjUi+9R?=
 =?us-ascii?Q?ZkjkkLildVbFyL/ALGE764w4XboR74dgmysVR7Q78xGeK6xyaJdiR+jX/4Sy?=
 =?us-ascii?Q?uglj3OQj84ioAIBRiOD2EFTh09ik2bKMbchHTLN62t5AHAucQHU1YEDfvC0m?=
 =?us-ascii?Q?HYoc0U8yDnEz58rRrlrSEPGktJqOhp4fr9XIJEDmneQBNDrSR8inJhyvjdv3?=
 =?us-ascii?Q?u26eyrh6hnBQApmnYjNM9vVmQI4WoFFG2y919Hp3bXQwz6uIR/4YwDo8uO07?=
 =?us-ascii?Q?dz7IG3IUpRGKZdwd1obFuVXsBEBDjhkT58RdkxUIP8szz1cXQSH0NZ/9N2TJ?=
 =?us-ascii?Q?S3VrnJ92kvE/XMK9FJjAUb4TFQEMnHW/vjh1YL5UwsxY67YLP1fC2QvDnXoj?=
 =?us-ascii?Q?QClTpm3ozchFQeVflf4YWhdhzpfV+nVqmrGFQ+QxcSUYHRj5oxLN2jd9FUkl?=
 =?us-ascii?Q?kQ55K1vlBdiMH/rNtnmiAdw5qYTqO4nVzm/9uiACdkZSUz/Fo8g7p6TX6qJg?=
 =?us-ascii?Q?FG/vP/6qT8or3wR9KJpHhXri0r2dK/hELLTyI114Eb7TxEF8+kMUX68STm2M?=
 =?us-ascii?Q?SQcXB0JjpEzYStcyTootmvVk1jTys5A+vUm06li9eT1TFsc5Lac3ywfBW9wL?=
 =?us-ascii?Q?sv3gZzv74VASTcn122umb/y+gYuj0W5AL1HDucLWQRJ3tSIsHUpBMF6Ih3Mj?=
 =?us-ascii?Q?z7iGUbASCaxa2X8ihsc3Jm0lTt0uedECse8UxJzz2pBJbb30/8jXs4QhIyuj?=
 =?us-ascii?Q?EUL/PAWe6rh8Cspivsf105Ms1Km90KlG/FtXUn+gLtgH9dx+Zs19wu689yVE?=
 =?us-ascii?Q?dUECd6bjIhhj7BRvMehoToE6ptViw0wPuWUSXkUxO/MiLNmW4jaE7ClkjpC+?=
 =?us-ascii?Q?9asulgLd9FjmKMI9llEU0Ui33AWaLNcCMAFP0jnntbTdQ9ZT+JvXRaICqTNs?=
 =?us-ascii?Q?jQdYPnw/+1mm88aV8nrUZI6qmTvnazuV4vVhFnEhCthlmFtFqbKwD0RJDCO5?=
 =?us-ascii?Q?1DGnWUfgTFpFaZjMqrsfobhaFu1THTQHN5KNoPOVxuHIb8AsVHlSbjxCiqSa?=
 =?us-ascii?Q?fXTr9Kaa83iVR5Y8Qi62+PkzQFn/H5fd4hdgxdtDcMWFPUchYy7drobZsF5C?=
 =?us-ascii?Q?Bx/29X+ClBpN39BKM43oDLt7yBBkVapQgjeVcmCVsRMN0SMBLBy9ydkbt4BA?=
 =?us-ascii?Q?g9jFv0+j/19MXQ8rG707MfaBzFJwCsZoW+vJyDZErQcpCQ7O2c8SXYtwfPTv?=
 =?us-ascii?Q?ZPyyfhbt7SIvk3AQ1XnzG54RYI9TPh0zu3JcPNCjBkccKR2es6GtfLK9EDUX?=
 =?us-ascii?Q?PYFX4r+bVJSkDa9hhlcua44KsjJ3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7057.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sha+kaOrbPzCcCVVi/1C5YUS/Z3kAJrher5UIe/fGP8n1Qdg+Ymo9ZOCzcKE?=
 =?us-ascii?Q?vcZAl/lvDGa+y7QiGEyLefOmLwj7S8DQpxm+LFRJyqH3p0HZF7eHSltmfUAd?=
 =?us-ascii?Q?zefBsmD9O6ESWhlTaIw4TBGX6V8ba1dHn8uuqN6wPF2nKm/a4qmD0DvyRbhw?=
 =?us-ascii?Q?u9rvj09fAAATfOwrID6NE2/8Jc/nwooe+vH1Lq12C1eLzamcQ76cGhdVMc1Z?=
 =?us-ascii?Q?9yx2AMhZ2XZYPu06HPmv4En+jMkujya7HvbGRvGBdHrXE7UAvDvfU9pu7JC0?=
 =?us-ascii?Q?1PYM5wcysmGwuF+qSRPk+ri6dNgtzGrGT/s+9lrZhte1DVIGzOfw+e87E+th?=
 =?us-ascii?Q?jWa/YiF21DXLMYbQa66HRL6jN5LFE6DaQmVZzv0eavSUtjuBjflZegYZZhoz?=
 =?us-ascii?Q?Aqr/inWgC66ZY0t6wWi18NviEkdtgNiHs3IwuZCpXWSvNk6O6kPje7J9zX/0?=
 =?us-ascii?Q?O9QniJ1npjAQoLapeXZRqNORNGZ8PpgXwgHDAHtSM9PhVJ+WKm5oAReyEpJa?=
 =?us-ascii?Q?uCaaNFCB8EOEprCqkW7CNV0nB6uaiSQXff+UhmC4E7N3rIuLH9B2257/aMl0?=
 =?us-ascii?Q?Ux6dU447OuOLe4CjUiDA22YjPA040QVBUS7j7mvXxoYDeDON4YBiuDckVACX?=
 =?us-ascii?Q?ALaHuN9kYc/Rq7So61l5JmgPWwwtwXbzr7sYVNU5r0HYvVIwaacnQNyD8KoD?=
 =?us-ascii?Q?UvA1+8mGd+FOhu0DFrBobsBNlpoHBMFe/Fdi27WVNLHWoJyl+XbodTLk5GGg?=
 =?us-ascii?Q?FcaGbe8vPTtcVOaxM2qeOguWNZmz4X19KS+m/FMWpg1VtZDblXeAaEdSRd2a?=
 =?us-ascii?Q?TYVEAJ+ctq2oN3oFeIE7r3uL4IclqrXHUedaSX2dK/4rn3yXWEOMD20hSWeB?=
 =?us-ascii?Q?hMaxtUo1nm7QsSEhRv1j7JLm7jTVaLiJp/2YOkpdnWfliYVVeeHpH28JdaHa?=
 =?us-ascii?Q?zaL3Fb8lFNS9/SlMb3HIhrgxaxW/Re67URaSCjARRg3IkTlQWjBmBrPK0d7V?=
 =?us-ascii?Q?C3JOO06FYuD0a9urrrBPQKoTcSzwVdfXqoQiYL1luO00CGe9Su6gbgd830Oy?=
 =?us-ascii?Q?uF7VQMYs6m4M/TIqtTAtUIhAyZ5LgHSrCm/Utdp1iyU6Izz90NAEo95EP9mv?=
 =?us-ascii?Q?69jBJl+Wc44VrlA7xCuC6SOsd85cNEHeU/RLmExwNsCuX6yoj56qu7wyB5gH?=
 =?us-ascii?Q?SihIW7c3URIQyIQF6byNf4pRfW1Kw35s60/ES1jfHtUVasNgbfaFoLok8Zdw?=
 =?us-ascii?Q?mqIsHJjzt8FH1GqusaF7rIpg1ylUuQ+ErXkmaY2oueyI1qd8KQVAWtUPNSkB?=
 =?us-ascii?Q?pUtWxHy2gqa3t8Ez7/9upXTDCUvylOvXrhBiaVVBRmu9qzlH81HVCoJ0sEyS?=
 =?us-ascii?Q?MUkY7ArclT02Q57XgtJfa9l2o+uCLJx+UYE5/fjZamk+g77YD+z49EZDHVIa?=
 =?us-ascii?Q?/1tiL6+rPiseE30GJTnwO9gbHDQisUgQGi541FYd+VLsXZDPbj1oWmp1prhO?=
 =?us-ascii?Q?WvRTKQmeXOTiAcbGs5JrWDus7GQvvnI+GylUQVIqfDVyq2TioW3MFKG3pJbH?=
 =?us-ascii?Q?dcP4Z4u/91yiRe7fLhIjIZar7BuyDDJWSa67thHcl34x8umhnvjeLLra4rSh?=
 =?us-ascii?Q?Iw86brpAnaV+mNaoAKqNtEo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efd61ce-db54-4ea3-14f8-08dcbb73d685
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7057.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 08:42:18.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJB0zBFfyfG/zkBtcx5L5em8IhErelea72SwLdq/Ilr2AReCOJKfUKqHVle+DibRCEXrTbTsCMbvNvZSnwr30XfqV6OTFxgXrH4BxIcHMyM+Q4Fesv7mgVEYgU18A0tZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR01MB9029

Add device tree binding for the max31790 device.

Changes in v2:
 - Drop "driver" in the patch 1/3 commit title                           [Krzysztof]
 - Update filename of the maxim,max31790.yaml                            [Krzysztof]
 - Add the common fan schema to $ref                                     [Krzysztof]
 - Update the node name to "fan-controller" in maxim,max31790.yaml       [Krzysztof]
 - Update the vendor property name to "maxim,pwmout-pin-as-tach-input"   [Rob]
Changes in v3:
 - Drop redundant "bindings" in commit message                           [Krzysztof]
 - Add the clocks and resets property to example                         [Krzysztof]
 - Add child node refer to fan-common.yaml                               [Krzysztof, Conor]
 - Drop "Support config PWM output become TACH" patch                    [Chanh]
 - Drop "Add maxim,pwmout-pin-as-tach-input property" patch              [Chanh]

Chanh Nguyen (1):
  dt-bindings: hwmon: Add maxim max31790

 .../bindings/hwmon/maxim,max31790.yaml        | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml

-- 
2.43.0



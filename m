Return-Path: <linux-kernel+bounces-308162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F59496580D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5271F24C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B3B158539;
	Fri, 30 Aug 2024 07:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lqhvX2sM"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2080.outbound.protection.outlook.com [40.107.215.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E7114EC7C;
	Fri, 30 Aug 2024 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725001543; cv=fail; b=AWyS4nFv3Rg4Lj+LcWNx5NCJ6gPqKG2E0fcYnZB+MRA/r1BRnK4+K2H8LDPW3yMozwGH7t6fVGKPcyRq650g/lbfMBgTewUupStFSx4/Q4XqCxWDw9GNCDq7qZfu4ddFpiBzzb0eAaZc39GMALOxbTpLSr1N/4XUliVsmHLilgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725001543; c=relaxed/simple;
	bh=xcK7DMRnFshWgkQY3h6gieej/wQT6Pm5BvvgRkmnCoA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=H18mwuKcUMqDmJ4SzHmH2tVf6LBk2aUYgkPdHw8OciXcdlrKXEjeV9upfZ+W52wLnsj9oAej9z0XRLs25gV0gCvbouW812llsnSXx2ACF3fyyGeyuQb6UglFY0N79vpmJrvt0EV+sINdkLlfeqK/PcjEvPYBvrWbDqNbV/8QVuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lqhvX2sM; arc=fail smtp.client-ip=40.107.215.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOgR8BUFuTkVOI/Dahs/JV+XhQBNG4In8Y81PMpvoEXOG58AZhSRT0lImWF7xYApIsJpFCjaBe2LZoiMETZ/Ca1bj2wKR2J/7DjCm/6jVEYk8d2xVQdgUra+iCHMlcCoQg1x2ZqXeWOxVWPftgnUZiXxiVmz5z3vzjtG/hW/m4KwS19nRf+vY+doadyQu+webqdw1qFNoqrsoXO55v5poH01KdtPN41L2TxPNsqGGWmTWcpmO0YOs1r+URq5nvQ7Xp6S95q84BxxK0ov3OfSbOJ1dwXZh5nYTpghMh1QT51/G+9MsNbOu9+sZsr+rg0nrDxW81UipMOnilG4XD/zpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZe1OG7+Yr1X7hVRUJy/xCjYSjJkMA3UVP7A5N+//TY=;
 b=jiAulEwjoO0sRPMqcJilodqT4OpWTHrLFpXPK7AvJ65yJDj+7m9HhD494YYXpErkiQkCasj8fE/+Mu6e/rOhSC/9YZEzKpHqK/sga5bDVmy/sE3M1DYtT3KSfEbnNhYoBJE1syITlE4Ts4LZD1hPVciwhWT26A2BKvQgFPTTmjkCi0Q/IFIM0vw/EzciUR2ARUPgNh9O8UxsSLpKV8+VZOIfyObs1dWZog9Ea2jxw6gDAxfIjqJYSAHQmS2HV+Fuz7RTsngIL3B4/utbDliCfTLwJQjMNIWSo1jHan8H3rPwbBtERypjZrkJ6ak8vHrWTLxnja8q/+yIqxMtOHMWOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZe1OG7+Yr1X7hVRUJy/xCjYSjJkMA3UVP7A5N+//TY=;
 b=lqhvX2sMLEWpeGReLI6qWu4IbfvBmg+8Q0iRon+vSUQcnF59J7xc0GnooUMwyNkuaN6WMgCpGtheWXRCuErx8TNrGYUyVAPiaK6cwVhGS9cTE6rtpeQL9Bp+lC5AI9Qf9oo/S+ta7gERztBqmvrzZMLSkn6Ew1zAhLR2t4da31dDtoeuBziJRyQsmmnVq7R3qO7EKzUDCBtcvi+F93DqoTzStVKun3oV4FaKXZepN4qvf/S++QyEdU9k5Xe2ofnP95SE6b48Z6Hv9U+eoRJSWKEE1o6MzFDNaFNod/3Kt3pcNiMToTXDGkdSQy8rAlUMw5f5Y2ILP1M76M6jBOD9yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SEZPR06MB5071.apcprd06.prod.outlook.com (2603:1096:101:39::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 07:05:38 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 07:05:37 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: ckeepax@opensource.cirrus.com,
	rf@opensource.cirrus.com,
	tglx@linutronix.de
Cc: linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v2] irqchip: Simplify with dev_err_probe()
Date: Fri, 30 Aug 2024 15:05:04 +0800
Message-Id: <20240830070504.289450-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0008.jpnprd01.prod.outlook.com
 (2603:1096:404:a::20) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SEZPR06MB5071:EE_
X-MS-Office365-Filtering-Correlation-Id: d22ee1cb-75fe-4839-56f8-08dcc8c2269d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PRmQaZbecnIHwwp1eSLNF63gnw/SnkcuMY4S5Ze0ztOnDpWskp3BX8fTc86J?=
 =?us-ascii?Q?YvvZIcupteLg/n9JyjViijE8lf6k3BctFqcnPGRksmft5PbQaMDTNie6lFcm?=
 =?us-ascii?Q?FRb2L3+WgGc+/3YczQD6quBv8M8guUhuEaS3OeMu3VtnJdeCmCTDHE9v9kiJ?=
 =?us-ascii?Q?7gCyDH7rdWlS5LmSqAIKDACp4VCTpPNAtTO6gE37J6+4akhqIERV36DDN49s?=
 =?us-ascii?Q?O8xZexJg88Ezsxk1PYfC1sEI8Lx5J7M2l/6GXyLwNPcvSNrzfcAuiQ6Tu8a9?=
 =?us-ascii?Q?JJDMCrxN6Lfs9aWDObvclmIQOAk28d6qbsrxu0vMK+qWKA3cNR9dCkCS8Cwi?=
 =?us-ascii?Q?ECNWkG3l9B6Tku+cVJJ3QDv1pbXlA097W4rCTIQ3Dr6DeUSM0PKQE65Bd/38?=
 =?us-ascii?Q?9tXDByonZ6mS/4kyHuWZJFJp+af/O1U/1Zs1X54aLTvPaQdk/GkfAMf0jvTH?=
 =?us-ascii?Q?ShJcevOYuG5lwWsREEADO+U/fhEeZz9T1hKWtQQZHu0P24/LVgTrQg7Oih3G?=
 =?us-ascii?Q?7yVC2dhi/cTbidZVUqalhbd1tDh1VYv1AeGxMxNLuMus/omWbx6GWGck/pxt?=
 =?us-ascii?Q?IYYD5oQ78kwKiO4ojGgpaLLdL3PfW+LqqZY8nwfXuvvqniiMa07O6BX19+IF?=
 =?us-ascii?Q?1pK8+Q8ZsDzbl2028ncobRZVuI8GHzwz6KAM8z7rZNFoBspIDzuW8Wtz2kNj?=
 =?us-ascii?Q?GevE5mUnAl07h0zAXTSdxAl+oYPFxtRV5z3OtpWDIN93l9PNuo1VETBWWlnd?=
 =?us-ascii?Q?+XlvHEjKgneQHxFiG2e4F4qm8cNqNstQPuWup+Ll/UI/USFP8rtPOpefcpA/?=
 =?us-ascii?Q?tKPwKjwELHodoahKnWrSTX73eRKHqjaPhfiP/EB8Zt4TOyIlk4YeumOpwMio?=
 =?us-ascii?Q?CKVU/buPLgycuheAiG9NiF7iJYUoPifOhP9oYnoXlB7HLSCOXw+ci4iss87J?=
 =?us-ascii?Q?XTt591gM682lX51ny/cUUy77rcRNMDQFkiu4ZKFg9INJ8BKqdz7HSuIGVnpO?=
 =?us-ascii?Q?12BQh+QINnonQmkRo12PHiWo6UpDoF9XbH6tRzqv8buccX0Lyzwi/Z/C9BvG?=
 =?us-ascii?Q?HDHwok7vPBkPh+uR0Q9qgPDbTTivp0lyNOmTda7uWq/5bM1qUC3PYfFN6+Xc?=
 =?us-ascii?Q?K4ycdfUvEKRYj431/iXXu82EZL/3D+2AGdURCYWbE4Prv5C1ySil2cu/dQrh?=
 =?us-ascii?Q?jj58iwKoN4Pb8jAcrRkuCpo58TDfYFT/biLSsr/PF7OMtNWNNSKcQMbfV5ZS?=
 =?us-ascii?Q?0Xyd9V8LBx16aGtnwLRAnBXzHxiH6wovHqcq2+yzPmZzXdOzkFoSKLcrQc8Z?=
 =?us-ascii?Q?MX9hH9qYhnXsRQl5OVIWe5GEU4/+U1mcdqq3C6qf6EvujYEnPcr3J2DK8XD7?=
 =?us-ascii?Q?fH7wti3oexHIvIbnHYC1wMwU6e575DjTUpKf389A7P/gmaHgmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZGjAJqy51L84VTinLZw9W66lE8hc2D8r6y4p+njxIs45cdiejWf2G/T/y9gE?=
 =?us-ascii?Q?+H1999liBAYJwrkcEsjaAIV00Z1ENYqouH3JJbq+RP8rVVo9BYAGZhh3WGyz?=
 =?us-ascii?Q?UpGdQ6BJfdkhanAqqDrgurxiBFWJlfTZeTYTOewnbRQdvwFfUzl2eKD+B6NS?=
 =?us-ascii?Q?o3ipxROzocQnGVavnmKsyfXAFbIGXEbDAw72kh/6WIos0Vu6WlzDfdMTF0jd?=
 =?us-ascii?Q?tNqzEroovcACCpr8nohTNb2LGPPwb17aU1XufWkSNGp6zYzE36FfSW+oOcC+?=
 =?us-ascii?Q?vEiFHEwWcrNCR12U1ugF0tP+SIQ9NMImkK+tjs8C4MHaS6rG0/ASsjr9eIhD?=
 =?us-ascii?Q?b6lSDdTqMQz3Rd7+cOScvwvQS8KxnxYudpmdhzMhXV7ZaESX+blssid5BNe3?=
 =?us-ascii?Q?vKoT7JcSODZuhW/5hk7BVQDszi42fFD9MemWzs4CNdoFHl7vfUf3iQqkeS1e?=
 =?us-ascii?Q?TS/4m2758DYCDKgsf/SQ1gcKS/N/9Kkrm8mtKmswA7cjxq4ej4SeSxs+kWTe?=
 =?us-ascii?Q?1eAclghFyjGlWMMWz+WT8zUTsEnpC2L/TQ2VGEMkyDQXQ4Qsc/XQtjijC8xc?=
 =?us-ascii?Q?bpySqt7BoJC8edLDnPDN1ke5IiEjtlIDkQCFSrC76H0mwtGCNbWg53RLGplK?=
 =?us-ascii?Q?y5/UECimnEwzGOD19sQ+wUnPbnIvSjBpM2A5LEbNl18SmDT/pDW38++xr/l3?=
 =?us-ascii?Q?fDbyJlvYyv1IZgbpRoVBw14cdRicyhL8QMGdSGjONtJ06J/I9KkcomHKTM53?=
 =?us-ascii?Q?gogGuiA0TJ8UdmqRydiaRhrJv2bJ2XjQXHAmf6FSQDgFtKo9ZiLVVjM45LBD?=
 =?us-ascii?Q?fJDHK91Wiii34Mei+N73jlSrzFoQi+Fi7pwmMTbcm+h/iA/vOaUPCBktlwXC?=
 =?us-ascii?Q?L47YTCd5SUXySjg6ez+oYVSvfiFS0JEpnoJQpY8NUUlE6hQBqJ8na+TWujRD?=
 =?us-ascii?Q?krP+FAyc5G18ANlaB84LGK/JjcYFifju5+QtWnXo186hl/AZd4xILbz4kfeK?=
 =?us-ascii?Q?qQSwcdlIe0KVb4WIGTqsnfb69SiAKdFTPJ33+MoFMAlxYZ9VqNGU4h1WNx2+?=
 =?us-ascii?Q?3l/dgBejcOoB395V0Y1EnLVz9RTEnXJyLxPZYDGTnH+fJ2n+TivlBPidfM/g?=
 =?us-ascii?Q?ptKCqkeWIePcgl7A32ygREN1gTrrYPuwPSIYYXon5900zBNdlcNIK7EJX6Co?=
 =?us-ascii?Q?uciw6DJQ4yDWIXi/D8E6oUG2l5YjyhlrsgX2sJzG/3SnN4ymgj0RN3V9qfAX?=
 =?us-ascii?Q?ngEIcMqp6rEW4R7NJhwXS2UEEFhIEz39znWSfJ0c1RjYTWwKJrhn7Jx6qNnh?=
 =?us-ascii?Q?Hyr/0tuC44KBwCkeWALhcFta7CIPB7vlypxxFHdqypG0+4M7/zN6boui6Q2J?=
 =?us-ascii?Q?GC0xonXxWai3Knkedbm5W/EIEhq2hm821XBdZaf9468k5i10ouWqktYPy8WT?=
 =?us-ascii?Q?MjJbuOgwDMTsZcDmyOZ4SOLwXA4SLdMcJe0IVxCyuyy22/wyy9+ywJ6pm2lV?=
 =?us-ascii?Q?BGU8SV5TtmpArOV9JEsZ17TgNBDX5eSvVu8P6wTiWJj5/GblN3yi408aHeN8?=
 =?us-ascii?Q?q29LzjLeOFMbonGcG29ezIqkkqbg9f6d8DvWVarR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22ee1cb-75fe-4839-56f8-08dcc8c2269d
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 07:05:37.8665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: niZ2FxaVy6QqpiwGPc3Q7nK0nTlKeUpekWLDScQyOUnMRBmBRjx9dYpDsqWlb/mKk1pl4R5m285iBqiik8DGhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5071

Switch to use dev_err_probe() to simplify the error path and
unify a message template.

Using this helper is totally fine even if err is known to never
be -EPROBE_DEFER.

The benefit compared to a normal dev_err() is the standardized format
of the error code, it being emitted symbolically and the fact that
the error code is returned which allows more compact error paths. 

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---

Changes in v2:
-Rewrite the subject.
-Remove 'ret' from the message.

 drivers/irqchip/irq-madera.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-madera.c b/drivers/irqchip/irq-madera.c
index acceb6e7fa95..d5ad4466a140 100644
--- a/drivers/irqchip/irq-madera.c
+++ b/drivers/irqchip/irq-madera.c
@@ -199,9 +199,8 @@ static int madera_irq_probe(struct platform_device *pdev)
 		ret = regmap_update_bits(madera->regmap, MADERA_IRQ1_CTRL,
 					 MADERA_IRQ_POL_MASK, 0);
 		if (ret) {
-			dev_err(&pdev->dev,
-				"Failed to set IRQ polarity: %d\n", ret);
-			return ret;
+			return dev_err_probe(&pdev->dev, ret,
+						"Failed to set IRQ polarity");
 		}
 	}
 
-- 
2.34.1



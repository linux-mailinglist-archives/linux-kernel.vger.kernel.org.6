Return-Path: <linux-kernel+bounces-316511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9A696D087
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7953A2876EE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDBB19341E;
	Thu,  5 Sep 2024 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Viv6Esfi"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013040.outbound.protection.outlook.com [52.101.67.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536AD18A94F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521818; cv=fail; b=c12KQibrGdVTBZl6O1/mE9Q3JkO7TQg6abvEMs6JnSwC6QoG4NnJ42bt9CW40Hkfzma3Z4aAOKmThpFjD5Yzg90ZF1YE78OZd3vWGUfJ+njvF7dL5JDnRWrzlE+SM8qpxSv/Owba+g9OUboD46NctOZaOm72ka19G0rZ2/zx/60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521818; c=relaxed/simple;
	bh=ja9f9nxxOxBZED56XqeDYfMeEC9anG3OUofDYxUJFGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fUTJAECAFkynEHFz8mVU6Ws2+vdaiYbd8o6hbsi4EEP5kN3samDPy8yViIbhEVCuWAQRDcwl8r+OTTEHcjcA2RGMqzkex1eeKsbCKS0iv2Evr1NxpY+F9w+9CkCffcu5PmoVVXFsKikVlqhGij6HD/70DUaQDyyiXMycuV4L6/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Viv6Esfi; arc=fail smtp.client-ip=52.101.67.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uju+TmWcvChH+6QAqXDtnYuPkkwm8g5YbL/CtR8slChQr0H754YaWdaPDFZgP9NmcNnGn3+zCXSPvyKuml5k3WNqq3P4NvtSt83ckMk1qRSoRiwRL5vRqW27ZT56N2uf75XBZcpdk3Ty4gNfYsDEO+QZreWb41jBmGIQP/mi/zFuW1afeVwlP4ImHp819uRBCchz2qj+xT72kS7RpNr8H0qaqrNGSapa2JsluYK3OyZyEm89pL6uizpQfLqkbAdS474ptwK4UIqT3Od9vuUoziIDIt7JltWknjwI8oQO1lRFp+e0PDeZwvDe+E7Rfsbc2edtrNGADd+2Pn51LPdNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lniF3Qc/9VXKVYvkp8znNidReg3xMQWnKpjmqnmEmYQ=;
 b=BRuSo0Yn6VfC5nUiGWJ60IX70BJ1dEcBLKFU54vF7Z9TudSRL+BdhuHa8uFAOpTUg0Z/JGZn9zTwVm9s8b1fOR+g8o5uCnVSq3oo9D3yyo8myGm6ytMIV7rTuhBf4TgVqP4rSnfr2E3gJ1Ya02VVTYlO3Cg+f8owQEgq20wwYzD6haAwW5uTIBq54dmGiQeSp12MThMSLA57qldUqilnpYK95lXJH2lAxtgmHrhV6pRGfnHoRpdkT09Hcb20oBzKrQQqGHxwSKmFKuLndPuKzgshmqZW/fz+61Ih9+PaYaXFu1Xvzdgy6/4nyvmZeeYFMfwjo049YcPuO2uwgPRusg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lniF3Qc/9VXKVYvkp8znNidReg3xMQWnKpjmqnmEmYQ=;
 b=Viv6EsfikEXqLuPG/5Zh21bU3f+6aDavHu0/+IU/qOGObA1x+fEP/YAWs/WOg/CxpGZNu0MnjZAo36AyxGFb7kcqzkrwbqRseoJKg0SCioXrBzHq1ItrxmoKltTf0b5BnE/NUkxmC8lRdGMt0DdfjcS35tvQ4PChWPGHaNEPQcr8QRc1SIHOq00G3pN+PeBZRnB6fzF0iLVdEmBrMqne7nDxP+7lbSHpG43NVfPz7cd7a46Jgw8TmzKauho9yUJyFsZJnEV4Q8ZqB0H6eM/yOkFBfX9AJ79xk1weV5BRqEuzeUnN0RDFtl1tyDNyGLuWoC/qhp/zLjrSv1qdfC0HwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 07:36:53 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb%4]) with mapi id 15.20.7918.019; Thu, 5 Sep 2024
 07:36:53 +0000
From: Carlos Song <carlos.song@nxp.com>
To: alexandre.belloni@bootlin.com,
	miquel.raynal@bootlin.com,
	conor.culhane@silvaco.com,
	frank.li@nxp.com
Cc: linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Carlos Song <carlos.song@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH V4 1/2] i3c: master: support to adjust first broadcast address speed
Date: Thu,  5 Sep 2024 15:45:56 +0800
Message-Id: <20240905074557.3810026-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::18) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|DB9PR04MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: 99239e10-54a6-4906-1122-08dccd7d829c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mKkTh5eBuma7U2fL8CnRprpyggq2JKb4CXuvG8vAis+fl06MPLD4FgF6wWFX?=
 =?us-ascii?Q?PprdGFr/1Bb0/GmH6VnwNDvEq+bFL2QM2/MaZsCMBa3sof7WF54T+sbSlx8g?=
 =?us-ascii?Q?dRRSR6gG/ZiUXvuvFQwB4BDnz66nCncl/4v/oVwoIsefhm9EvWOYWy2WYBv4?=
 =?us-ascii?Q?+PGB0lbMarC5ZkNlS1Deem3hOuXLwgZRRKBUohkvVLfEVjhtS1t0MqP7RN31?=
 =?us-ascii?Q?OuoJLTUdGoSLN3JpzGBd6udvfcJr9tsWptncGQhBaDw3muu39aAShHp96Wk3?=
 =?us-ascii?Q?gg9AFHUupeKQeSkGAr1eQf1TAcCTONQ5ZVy2mhPSG6xOJdcAf6I90ZuZxtsN?=
 =?us-ascii?Q?u+YObVtpv7sOrvm2NckLfSyBLVQMbcDxsDCiZGHZzAMI31PWMEXZWNHPrWA8?=
 =?us-ascii?Q?lVyfb7MUWPfPD76gkW8hlTmTPTaaobHzzlz0ncB4mtSXo0arJ77pbLRb9L/Z?=
 =?us-ascii?Q?wxcQ4O5kPgc9tu8yZfrJVFsS+mzkUP6gR3VKAdRazixHv424xMPJr8os/DNx?=
 =?us-ascii?Q?hmj8xHGl1AMezmuf/Y4gJtEFOCeKDmNByQC9Iu6+MPrGb+Q0R5XDRPfPKOIO?=
 =?us-ascii?Q?1/v76ezM2Qk313ioFMPF54Ex8fIDQdQR8L4Q4hspGWsF3iyoGOViGq3FcD7x?=
 =?us-ascii?Q?hnarNg/QZ266t2WbLMZ1BmpLcnCZ+u33X9bj8n/vkFkNs8hi7RntEOVQQgst?=
 =?us-ascii?Q?jqJbp1d2uicSyi181MmJBmrheG1IfxXo0P8vgYizO77wcon+HHakXn/yUZ/2?=
 =?us-ascii?Q?gxaXdlf/CckQ70Nf6XggSrUTSjAXt7GLE92HpBhCnE3lwxgjrya2H7AF1StK?=
 =?us-ascii?Q?XLoUqgdna7bkNIMSKyk1gg72oNf1vevQLvg94kGe2WxC2mrfizXNKLMAJ6j+?=
 =?us-ascii?Q?2T3cZrJhvbnMrxXFMNQcg9lc9MsS8hlB9KuPTT8i8zo1IkKrzOYLYobs6Ww/?=
 =?us-ascii?Q?U3BI2Ud1m5+dWzaEAj6MkZChFYRmVsynDIZlsAQ2vYevJShb2GEbEFFytHA4?=
 =?us-ascii?Q?SLTg1lQC+iL/6FJUe+uxzMWPFwv51VkHtshkCsO0NYIhqK23gj9UpiJ1Utrx?=
 =?us-ascii?Q?5UfPkUgPV+FIm+t9wl16JSwkYsNyhdBAvXr0ta1xGGBOtDYrAqpRTRi/3bS1?=
 =?us-ascii?Q?4EXA4yjUScpUinkb2aKRPFsVsnPQv74dZG9LlE0i/Mm4ettrF8w0TltqdfW+?=
 =?us-ascii?Q?oCgDK1x2iZEXQoIKq9KerkNe+nkw/FbfGTMOGkuuPUqoA0vmeS1O+OERCGa8?=
 =?us-ascii?Q?OKCHsjmOn8Z1vlbT+KvHeC0+p8VeP2IZvbXVSpGxK8bbalflatDaWW8iRo/T?=
 =?us-ascii?Q?aUspFQEeg/yykzRWxj7iPyDG4sB02Z9tgDhnelQGxbvURfvxdYlTvQQkD+Cs?=
 =?us-ascii?Q?uJXME5VYURm+Etny9tA880d1XW+nom1h05F+FysudADtxZkWHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hD02rT73vBUyAb/tS2gIvS9wSXJcnoWoBf+Dnm1OEDh8EvWAchhoGk+y0JKI?=
 =?us-ascii?Q?z7EWBoV6N8LRnF5KClSmVP6fo16ThyY4xs3rLNm/IYLZ4A1X3D4Xamtyr+z/?=
 =?us-ascii?Q?sVMakzdghkqXZslqY4KquS6/bIw0RYXcOZ/HBRrTd9ZhKjdZi80c5uFNVGPb?=
 =?us-ascii?Q?OBG0jGgQwErhj8B+Q9nETz5tBAko79ZkePUOGTK3RiFOQIIWdip414jo4JBK?=
 =?us-ascii?Q?CmlDtqPpUKaklZAt+KliQpcsf6M8SWOJRSJhwBly8tclTmH0yZdB9RjWFyj0?=
 =?us-ascii?Q?95rSN39QK7t23CHAdXhzFAVlBauDCaDw6kDmiQaw++kKPumN29PMCJfkUDl9?=
 =?us-ascii?Q?n4qBFsCJ44s61EsLKdSZhVnxxfR5rExrlzaOShYIUClWwaMxrNvJBNzalpl/?=
 =?us-ascii?Q?SuUeJwwzKds+uw+bh2hdq7u+EMPLL5s/cyKslfm+JAMmErqnYuUbPhM57fgF?=
 =?us-ascii?Q?K0PKzRZOOL44yP6xrW9oqZ6ENUtDiVSE5XgXiUMd8nGSsPk7rAn45v2tnf3H?=
 =?us-ascii?Q?dH2YmbKZWQ1KBVIUnjntvOZ7PdLhn0Yj4SIVP5oloAIHaiXulUtJuF9z5SYR?=
 =?us-ascii?Q?u8uRS7qsCL0QD6N2SrS8cZptRwE1FDnGn8MdyYn6Xk7ge53tLoS1OvGYyTD6?=
 =?us-ascii?Q?lH8mflX8u+6mawpmXdFBK80abrRVx2Wi0V29J0kSn9Lx8r1z7e5OQzuDnSji?=
 =?us-ascii?Q?HbDm6LdlIg5p57YhnZ6fU4NrhsSu2dNT3nCTZu8S6l2mz3LSTmjbRtd3LT8I?=
 =?us-ascii?Q?UZdXcWeCv1rUlHXnYLPKrrh3pZ0sCcrR+updXxhvKLHXeEGHu4hlkGXOEwU5?=
 =?us-ascii?Q?NSocNbIy04tMsDKCioc+u5Wx4WGznVchjEz0sp85mJpHSb3lE9KlTD6ZH6mS?=
 =?us-ascii?Q?Uwh8v0KR+iP3G5AmtINJS1zl/XVtPXXMB9TrIzZYiTKI7wZGB5ABVyMNXOQC?=
 =?us-ascii?Q?o+TaruqwCgPI7H/fOsoNYbp1bJH595mFo4exV7W+G8g6xRj7jw00q9PEh9I9?=
 =?us-ascii?Q?VWi+ai17yCoEodIyTlRR27NrK5x6b78NhCqmmiOXZ/VM/RrFeyXrOhm9JUzo?=
 =?us-ascii?Q?fieEYv0W/d8EU56NU+ku3n5UqSGgkwU/k8W6e3ZicZbt5EM9c6TClYfCkQxo?=
 =?us-ascii?Q?i5edScQxAVJfujkwrWdXKH8jyEZM/nH9Z0iSCFNPEsCHsqhE+bokSbk1dJ5o?=
 =?us-ascii?Q?eI5+giaK1vF45Aeoupz7PjLggcAiMhoF4gmW+ueOaKwtk09DNsZkGPBI0aRp?=
 =?us-ascii?Q?EVD8O7rh6JWW6sbcbsQIT2SUyS0LtEG5A+x+4C5WffwvpXXfZHHs037iCnc+?=
 =?us-ascii?Q?FISDuoy6rypXWbAEoOQJwX0BKDFDecrSTjeyftjpMlXtsliSOQ+UDJel1ycB?=
 =?us-ascii?Q?3T7k8HQC+CmJAR1rvzS+0HgLYFVRPZ3LISCoBP/iMudpQfiiPktT2WDncnc1?=
 =?us-ascii?Q?Us50VOCjZeY4wrl1xOZUVw/S7I3Oa7dtCYXdURPVdq4JWmC+4AUD7Y6Uu7TJ?=
 =?us-ascii?Q?/5YjPtiFTlN91Gkfkz1XF8DXtodtHRpVcXHp4zf5cw7qFSGVQSGEfnkplZst?=
 =?us-ascii?Q?0V0MFU7E9gN6x3OqAaOwEX42sSZ/4WqGAnvn2cIi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99239e10-54a6-4906-1122-08dccd7d829c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 07:36:52.9719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9NI1kUOQGA0b3s09Npfq8ZHnSrQUp+kvlJFAcsLx9tN0E2BNBKpiM/PF49c2xN4G2lw/SAyZwVmGHdR1X04ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8429

According to I3C spec 6.2 Timing Specification, the Open Drain High Period
of SCL Clock timing for first broadcast address should be adjusted to 200ns
at least. I3C device working as i2c device will see the broadcast to close
its Spike Filter then change to work at I3C mode. After that I3C open drain
SCL high level should be adjusted back.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Change for V4:
- No change. Send this patch with svc-i3c-master.c fix patch.
Change for V3:
- Modify comments from Miquel's suggestion
Chnage for V2:
- Fix set_speed description from Frank's comment
---
 drivers/i3c/master.c       | 12 ++++++++++++
 include/linux/i3c/master.h | 16 ++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 7028f03c2c42..6f3eb710a75d 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1868,6 +1868,12 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 		goto err_bus_cleanup;
 	}
 
+	if (master->ops->set_speed) {
+		ret = master->ops->set_speed(master, I3C_OPEN_DRAIN_SLOW_SPEED);
+		if (ret)
+			goto err_bus_cleanup;
+	}
+
 	/*
 	 * Reset all dynamic address that may have been assigned before
 	 * (assigned by the bootloader for example).
@@ -1876,6 +1882,12 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 	if (ret && ret != I3C_ERROR_M2)
 		goto err_bus_cleanup;
 
+	if (master->ops->set_speed) {
+		master->ops->set_speed(master, I3C_OPEN_DRAIN_NORMAL_SPEED);
+		if (ret)
+			goto err_bus_cleanup;
+	}
+
 	/* Disable all slave events before starting DAA. */
 	ret = i3c_master_disec_locked(master, I3C_BROADCAST_ADDR,
 				      I3C_CCC_EVENT_SIR | I3C_CCC_EVENT_MR |
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 074f632868d9..2a1ed05d5782 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -277,6 +277,20 @@ enum i3c_bus_mode {
 	I3C_BUS_MODE_MIXED_SLOW,
 };
 
+/**
+ * enum i3c_open_drain_speed - I3C open-drain speed
+ * @I3C_OPEN_DRAIN_SLOW_SPEED: Slow open-drain speed for sending the first
+ *				broadcast address. The first broadcast address at this speed
+ *				will be visible to all devices on the I3C bus. I3C devices
+ *				working in I2C mode will turn off their spike filter when
+ *				switching into I3C mode.
+ * @I3C_OPEN_DRAIN_NORMAL_SPEED: Normal open-drain speed in I3C bus mode.
+ */
+enum i3c_open_drain_speed {
+	I3C_OPEN_DRAIN_SLOW_SPEED,
+	I3C_OPEN_DRAIN_NORMAL_SPEED,
+};
+
 /**
  * enum i3c_addr_slot_status - I3C address slot status
  * @I3C_ADDR_SLOT_FREE: address is free
@@ -436,6 +450,7 @@ struct i3c_bus {
  *		      NULL.
  * @enable_hotjoin: enable hot join event detect.
  * @disable_hotjoin: disable hot join event detect.
+ * @set_speed: adjust I3C open drain mode timing.
  */
 struct i3c_master_controller_ops {
 	int (*bus_init)(struct i3c_master_controller *master);
@@ -464,6 +479,7 @@ struct i3c_master_controller_ops {
 				 struct i3c_ibi_slot *slot);
 	int (*enable_hotjoin)(struct i3c_master_controller *master);
 	int (*disable_hotjoin)(struct i3c_master_controller *master);
+	int (*set_speed)(struct i3c_master_controller *master, enum i3c_open_drain_speed speed);
 };
 
 /**
-- 
2.34.1



Return-Path: <linux-kernel+bounces-448453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8A89F4049
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 02:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DDF9188D41A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6F9126BFA;
	Tue, 17 Dec 2024 01:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hflCKqFe"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2378650276
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734400748; cv=fail; b=L9Psarh5Q9Xm5UnJY70K5ajYyr++U19DmxtCUx3fJoI8G37L3gMn4mOMHGjFPIjyEiUTqv53/lIxiJ4ka3X/lGz7lLN04OGA803uzMJmGuQcvHEhWXeR/h2Pwa3DxXGdl5rz/+Cb4ymzi0uZ1v3x7h19jozha3V82EI1wMUlLAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734400748; c=relaxed/simple;
	bh=pmvUcn6BYaSOGjmp+C+rexTE6K7AtQQt0NPj0b1WqgU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qvhjpHDa23n6LWDHsrTsY2IwzLv/gx/8c/YATrsRpi7bs1dsN/nWRfxuJNMF+7nJF65CAeaQ4qdV6P2bNRLg9W7HnbZ4XazyfD5/A3alb5sP2zgcbsvTe4BznsvUZNihGqIuSQyFmwged+/EP2Qy7TfpsvbzqsTQGrOdARpL9WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hflCKqFe; arc=fail smtp.client-ip=40.107.22.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRsNX+W6HgEaZ3FFoI4Z4oEdRIj3H1G584XZ8S9xbUK9bDO5hBQXpbxm1WAWfk8jLKqTHBP2mYOjVPkw4kEt3AUvmj7RJqWX8nR7CGEKGRY8pGVD8wH7kI8NIMB7HAcIDFoG+qEY2EKeo2eQAGd+CRk5IBkCzkA4EH9bIF19xTyzecoBi3XKuo5OtKFy1TEi8GcYJO7EfE+cWSIqxB/9oOsTOSeMDrSsBDWFC7NespuQKc5R354qv4mYdXE5xNGQy1FOioZZPw5A6PETky7dN7L+PcJkqv0iCYwWQXGgCvwv+WoUYAkSaFSBx5cmLnoIKj5dKnOEc8zSpSHEVzs4PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQMDuaA1axLmSC9iIGYX/rPKxJnHKir/mtAAK893qbI=;
 b=Z6BKbz7DZj4MtmWPHO43odpNIAam9nKc7q+YRhkJPDIe729hK0uyg/DiYerzHlX9q0fXICsuWN4APGwyA7zinv6Wjtr88vCdd3seXej+mlpDF63s1Li4v/lZhGcJkpJzmhxhm42/J6SLTPpxfc5YQDm+jiKJzxWRVM6tXX9Y08QjJvEzqOUIkDzEFLSNYl3gqnnV6h0vE1Ir1iAUvIAHn68ABJkcdKuJpyBIUZGDQO5kZGAfQ74i3oRJZPWeiu91Y/RXgAmd7z3qoWK+0Dvek0kQnAGAgDYNNLNHMMFho9JT9uR10l+Kt2jXqyRoLSj6IU9T1KJg6nVN4wSCPScX9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQMDuaA1axLmSC9iIGYX/rPKxJnHKir/mtAAK893qbI=;
 b=hflCKqFe9kwFMSTCM262o8y/O8cpBiwytdsTsXK+joc+c2QZphI9tL8ZzIhCWp7YnO7+HPMqJvY2vjY/o/XtM5grYBZO+unFbuakV2kZ8NqeNkiDJLVzKtneORmZcjEBZddrk9cBtEq5FK9aecJa6Dtl9HOFmsS5qQsY9fin9wQWXSzARPPpZjTv6dCXw90+xkdj4lCdBs7hIgxy9WWNrObzTZVocfJ+mDpEAYPWN2EQ6dMJWMabHh+o/BVWvbeIWbmJfDRULo5j96VblFcCLE0ALXWxk+AQsyYpW/vJOnjJ4W/Mmk8ByZOdSJrKVSkKa23Dlr4pIOKdMdi6T0r7Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10851.eurprd04.prod.outlook.com (2603:10a6:150:21e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 01:58:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 01:58:58 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	marex@denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] soc: imx8m: Add remove function
Date: Tue, 17 Dec 2024 09:58:26 +0800
Message-Id: <20241217015826.1374497-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10851:EE_
X-MS-Office365-Filtering-Correlation-Id: 72961264-c6be-4524-0e6c-08dd1e3e5ed2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?90+VR6iAwACcuVuoQTHGmI/WFEAJaL72yzicwKn5NqzYVGygvchgrpVqcgGA?=
 =?us-ascii?Q?G/2LI7pdfZBBrgLHu0lcc3ipaaSNIJ5jy8eRFwEu0vApfArmNqXKs46+0jNE?=
 =?us-ascii?Q?Job+E1cNPKJw9nf/RZYPXH13WiHPGiyzJ29sQiWItKUnLYD8KNALHzUX/zrK?=
 =?us-ascii?Q?mVQEGq/M7nmBnRN4ySr6qvObN1+XL7bc42egqsWSfrWyVd2lh4VWhGzmuf27?=
 =?us-ascii?Q?bYguP5LZ8rjRiHx7Uuq+i/0gQgeJkvwUR31ucj55tAvW0+nYCepmcAUCvoxy?=
 =?us-ascii?Q?rku0QL9b4l3qBUu8ZEjwHC+JoqCtVWDu2xJrQISfpePItF6fONuBFYXUSwhK?=
 =?us-ascii?Q?zVzC9Ig2lInUnqvhc4hR0WJ332u2Q4yQrMdWg6dIrazk3Y4kVDqNhW4YZBDr?=
 =?us-ascii?Q?J57iQ+/rnGvmKkLNiyLjqRdWH0QPIDnPztdGfyO/8ah+qtSPA44EdqH8b9pJ?=
 =?us-ascii?Q?dTIggVUlmtgoEQEBU8WYph6Gaj/gkzB5fF5xPvPKp8VfBZkE4DIEQXtz4xVY?=
 =?us-ascii?Q?3UtvY9WbezdQprUOzYnB65NbRYjlo2cZTrD1C5g4sFLKLQJBMM9+TN2sLzrB?=
 =?us-ascii?Q?eHtlR82kUki52KKazZO1BexY4+PxPgWd+wrcsZ2fom2RNOBKqYoDM4CHTjsH?=
 =?us-ascii?Q?LKyjEJudOaxK/x62GgBEVcGeNl+DYZX9fsZNs1AmA3nUxrMpTXWmcObmqe1E?=
 =?us-ascii?Q?ifvH5cp2nb1Ylj66+OAXJ5zMif6DydeRT4ypM1T2xMbjJWBW3p9r2gpJf6hR?=
 =?us-ascii?Q?0YJ5DVwZfl1FVA+qi7WFGeGbCm+JUb43GQ7uQ3FkeX9LMe3kNRTAe+ySZhBA?=
 =?us-ascii?Q?dEutbofGJ+fUlmtBZ5c1w7o85dk41+Okkhn8jP3S6IejETqKMfhDIZkpGLXx?=
 =?us-ascii?Q?CNpk4HDHZ+OiEfBilB5p2yOkHr6APkcx+wE1K3KPv747WbXhb3KYMkefO567?=
 =?us-ascii?Q?HH1jXzqYF0tF3kA2A7ePeAjGW5EDJzNpxvp/ngw1AsfeVp5GujuolSL4sZgq?=
 =?us-ascii?Q?E8EWE4EBprmak9iXpuCbCPbJiJKLnJ/z01qA0mqQ/ukpzNz5bU7RHA7Kwbyd?=
 =?us-ascii?Q?U/kYnfX84e9U0x1dk/PFDiVJ704pRJ1T/EWj/OwEyQRdZ/xXmI4qps5fd9OB?=
 =?us-ascii?Q?WlXZ9d1hoHJOTJBHOQnn2/b0sLEhV3sOHfy6bL8+sNieiMnT5nx/8Flk6cyZ?=
 =?us-ascii?Q?6BATkS1kaWqsH+eC3Z6EjC17vtxvTCCIuGVrN9S9qh2azxiI9EQ2l++d8qXO?=
 =?us-ascii?Q?17ddIJGANvI7C2IgFWSMjewprY6eolqgSRnt0zJTaO4ivv+pVJdmteT/yxZp?=
 =?us-ascii?Q?bxEjtOpB4RY852k55BB9sDaQeIStjvjdBD/X0RnFxNzvar60zNnX52QC5FYH?=
 =?us-ascii?Q?3I+YKAT57ia9JPJP/TJpE94ibdAlioAgWOGGJQ9lKYP451+IQ79LNtg5S+w7?=
 =?us-ascii?Q?5xd5TjHMyCUIarqjLSO2lWsQfq7QlGEp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o9quJ1pCnkIiq95zFQDQ6av28GhFulC7AdQtExiNvCdgx48kOI0kUmxGYfUe?=
 =?us-ascii?Q?ICIT6Adjd2wsaSC9P4ZGGhL8kp/wzFNIVC6ln+9PshXRQIH+1HrmH1cXvNZd?=
 =?us-ascii?Q?IEbSGxNza9YM9QvZuzRGwiZfYpFYfJzo9kC237CvDuVPxZuXEeJgT7YTYTUN?=
 =?us-ascii?Q?X0dFpxuEJ16uFITI4JO4zKr8wPcY+ZPQgP+HEzCPxbCQhGMTES18Z0+NV0Od?=
 =?us-ascii?Q?9XXj1shw8Ug7hICgrEqdACttA5ghqMb7IF7aqiXor94qzF24QmzLIScKMEKC?=
 =?us-ascii?Q?zFuym+wFgiu9FU6sdaN8sk3C4RgVR7mRNmlzxJhEyw62m0rhbsUNhLgx+FYE?=
 =?us-ascii?Q?+SRHDSbN7yMp27V7+SxpZS9WiBYmf6nGmOnosnN7/xLishIjLwOzDkESHBDP?=
 =?us-ascii?Q?gUNxdVMjV9AanDizMjflPqymz1JNOAGsi0O8OynGsa667ak3QSf2Ah7WUb89?=
 =?us-ascii?Q?kvpmFLu/cb0JUFCUW+cdTqsis6ZhoCIVDMQf5Jmf+UDtBQdaUCn1IJr5/rc5?=
 =?us-ascii?Q?sNhuW+WOxGOYO/T08zAFpnrgjxNcvrEkP8DOyjzxycsztixP+gqTq24Cj6ux?=
 =?us-ascii?Q?kusBVTBeYgPw5DKU0c80HWahtMDOs0mOCnwiO4K3C3jLTOcG39weCpEx+rdl?=
 =?us-ascii?Q?6LbHfCv7+8xkEUB8hF3LjJiFNMUC1KafPZu4zyMWrakGjdNYXtRxgFAfJPH6?=
 =?us-ascii?Q?k5z3uYtLzQtrC6H7Ub5XBsNG9GFMHgPBz2iruybaz5SMHD30ld2yn0+L3F7j?=
 =?us-ascii?Q?7pkRe23Xl73d7lGMlujJVyzQkFZqkZMHkm2EZQEbDgGRKH0/yAIqUa9kYq4k?=
 =?us-ascii?Q?qipj1uS+8lCO3LqoNFWMec0ZckNiQxB/47auXH/W2I3oWVDGKnT3yuuHG9/y?=
 =?us-ascii?Q?OgduVq0zzUt+Rr4aW10jRYCUcN7aqH8f7rcktXMvv91u3LSL3OADDtSmG6if?=
 =?us-ascii?Q?JO5NDumTENzVP2i4omFaWEsphZDckKX/QwNCi0uSGDKpC+11abiiCb6pG2qz?=
 =?us-ascii?Q?kSbcvg4YOn7GToI8H2MRs3bTL+odScpiJV2OCuPvN6qBcpdAC5uWfQCzxL+K?=
 =?us-ascii?Q?Ih+giwen8RQ2eFV9jpngZMwC/fGLUEM8Osw5w2xn6/0yljxa6TeCwpWd+orQ?=
 =?us-ascii?Q?g6YEIuH6LkdH84dgfcctJZi+3v104s/eGdmHQded4mgbY7IuVKYYoOUNW1jS?=
 =?us-ascii?Q?wSL5QCFrMF0IG+xPm3wQWJw2II+d4fgsFaiIse0t6rl9a1t03iZ3Ke0I8FPq?=
 =?us-ascii?Q?k7eAhD41zGDIGw2zpqg3R15mTmRVsWrhF5pyNpRZMDpiggARXFnsZvFcHtMW?=
 =?us-ascii?Q?EJ/YuUincn1rcRYaLqwFhLm4agKKh8knmDXkKW5IjjRUzeI12dI8mJpMNPoy?=
 =?us-ascii?Q?jslr7fTubvlkV0xqH7cl1oe52V0wOf1jGPYm3263nHPdsMpL6kivVg9OKhkH?=
 =?us-ascii?Q?x1GKagoMbsHyYxdV8qDylmsN0m24ftH+D1EcsLih4SzJm65WClRmD+1nBD3H?=
 =?us-ascii?Q?P3fYUSjYTqVER/cIWgIq5Ge9WPKuK0Tg/Zy49hhUB32QU3dq0L3b7B4CnyRF?=
 =?us-ascii?Q?4LiBX1t7UUo/I6OpZQ1xLJlLiGagwB5h/x+9+aoE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72961264-c6be-4524-0e6c-08dd1e3e5ed2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 01:58:58.7013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/S2d86Vs7xtJr3ja+6o+4UKbeTXFTUnS0cVajGa16nWGRGnTH98melQp1W01SY81OvI2qOQQqQA/aXVgppxkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10851

From: Peng Fan <peng.fan@nxp.com>

Unregister the cpufreq device and soc device in remove path, otherwise
there will be warning when do removing test:
sysfs: cannot create duplicate filename '/devices/platform/imx-cpufreq-dt'
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-rc1-next-20241204
Hardware name: NXP i.MX8MPlus EVK board (DT)

Fixes: 9cc832d37799 ("soc: imx8m: Probe the SoC driver as platform driver")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Add err check when create the cpufreq platform device

 drivers/soc/imx/soc-imx8m.c | 41 +++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index 8ac7658e3d52..97c8718c2aa1 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -33,6 +33,11 @@ struct imx8_soc_data {
 	int (*soc_revision)(u32 *socrev, u64 *socuid);
 };
 
+struct imx8m_soc_priv {
+	struct soc_device *soc_dev;
+	struct platform_device *cpufreq_dev;
+};
+
 #ifdef CONFIG_HAVE_ARM_SMCCC
 static u32 imx8mq_soc_revision_from_atf(void)
 {
@@ -195,10 +200,11 @@ static __maybe_unused const struct of_device_id imx8_soc_match[] = {
 static int imx8m_soc_probe(struct platform_device *pdev)
 {
 	struct soc_device_attribute *soc_dev_attr;
+	struct platform_device *cpufreq_dev;
 	const struct imx8_soc_data *data;
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *id;
-	struct soc_device *soc_dev;
+	struct imx8m_soc_priv *priv;
 	u32 soc_rev = 0;
 	u64 soc_uid = 0;
 	int ret;
@@ -207,6 +213,10 @@ static int imx8m_soc_probe(struct platform_device *pdev)
 	if (!soc_dev_attr)
 		return -ENOMEM;
 
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
 	soc_dev_attr->family = "Freescale i.MX";
 
 	ret = of_property_read_string(of_root, "model", &soc_dev_attr->machine);
@@ -235,21 +245,40 @@ static int imx8m_soc_probe(struct platform_device *pdev)
 	if (!soc_dev_attr->serial_number)
 		return -ENOMEM;
 
-	soc_dev = soc_device_register(soc_dev_attr);
-	if (IS_ERR(soc_dev))
-		return PTR_ERR(soc_dev);
+	priv->soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(priv->soc_dev))
+		return PTR_ERR(priv->soc_dev);
 
 	pr_info("SoC: %s revision %s\n", soc_dev_attr->soc_id,
 		soc_dev_attr->revision);
 
-	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
-		platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
+	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT)) {
+		cpufreq_dev = platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
+		if (!IS_ERR(cpufreq_dev))
+			priv->cpufreq_dev = cpufreq_dev;
+		else
+			dev_err(dev, "Failed to create imx-cpufreq-dev device: %ld",
+				PTR_ERR(cpufreq_dev));
+	}
+
+	platform_set_drvdata(pdev, priv);
 
 	return 0;
 }
 
+static void imx8m_soc_remove(struct platform_device *pdev)
+{
+	struct imx8m_soc_priv *priv = platform_get_drvdata(pdev);
+
+	if (priv->cpufreq_dev)
+		platform_device_unregister(priv->cpufreq_dev);
+
+	soc_device_unregister(priv->soc_dev);
+}
+
 static struct platform_driver imx8m_soc_driver = {
 	.probe = imx8m_soc_probe,
+	.remove	= imx8m_soc_remove,
 	.driver = {
 		.name = "imx8m-soc",
 	},
-- 
2.37.1



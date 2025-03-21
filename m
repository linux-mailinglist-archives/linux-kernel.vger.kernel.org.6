Return-Path: <linux-kernel+bounces-571420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A81E6A6BCEC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085F03B0138
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4EF1CEACB;
	Fri, 21 Mar 2025 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VtmL7R80"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013058.outbound.protection.outlook.com [52.101.67.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987BA1CB501;
	Fri, 21 Mar 2025 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567184; cv=fail; b=bga/69ZMSqMG1djk7Uw2ykFt3urVsh/p2Dv2+AwEwQFtKn3WDclHiVyrBG91qsrNbPE/WB7AkV6RmR2kpLN9s7xcTDdHe1daMgczBP+McNzeazMQwZAoXTwDwGusGpmPkU1RiVosMU5//onitiAwvrrQAfZWD6QslAm6BsCsWAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567184; c=relaxed/simple;
	bh=12ddnSGbIaWfg7E2TPLFxJakB6OxILOhRRm6gpEsGSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CM7dT7i/W2Q4ux2/b4vK4+5Rui+EmIhQ1WANhS0jp5Jts5S54Ehsy44pFM/x5A1SM9IKur4vkJDB1g8CO1xhpPfSPUPUT6nLkxFS9yeDwxcdJSPCrVi5vKl22IakUpRtK05IFh0vjitdL1WozceuP3HoWCCs6ZEpK6OAQRcymjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VtmL7R80; arc=fail smtp.client-ip=52.101.67.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBYqJ58fkdfO0leWY2IMptAoEz1ElxTVShgILthGafa1C691XRPgCgBroCD+5RBD8hiXUKs3bwRlYg04ugPVBvOWXj78AgkCJnNWuLTxs6OQR17gbf2uaScLQcoZWOoX3qgg5/Ncvo6rnS1eFCXNSOsTdDE5G2EYloGzfx2Qs7Hg9SHCHlHFsPT/V2gNK/BBiHqDITwEShGJ2PB3UWzLEOOMSOmcEd4AUze6VQbCMg8QAFK27Vt0XYFaNCyQ3rY9ZCj4TEr/2wWFpj75o1vFFNLoNE67Tht/KrlVRzisIkTWuUoJhCYRMoanSzRtu6yGUgeXct3wql4CsOTsg6T73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SAS32sWUqrMSSHqOwA3qiSpt4GRQEm8a3yJVSVKFmM=;
 b=TlC/kVQAIb7YlY95zj87wOkIImS/zjGJ1Hgv81PYeCoBja6bDNjsVgBA91kddI9nluEd1szaIzIY3IA1z3LZ90jyD/ztuovzff4/EjZ9c/MdxOYKm4q5uqkW69MngJtfYvu4yNfOEJk+SeolnwHjVMu7CKVUHh9gJGaUB9Dr88KplntqCwNZENtuEiBalUJAdQ5JU0Z+LLRXs5T3WZbSKZvYYJj9uARJylLyxQSqRLv3rYMkJ89nhxuJ5do1qhMYma3Wt/PxVo282hrdDPgwYuRNposVMudOXKpeNKemeNdHl45Ya8PdzJwmcvcSG78m0HHr0oAfGf3oraoPQbr7Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SAS32sWUqrMSSHqOwA3qiSpt4GRQEm8a3yJVSVKFmM=;
 b=VtmL7R80oMI7pzp3kDRFGYfZ2s5m6ScaLqQpEVLyofsGeAcmxzG5EZVqAIYRVtOdA6Q6k4J8tTZb6LDCwdRrMO2Y5ZpjlGSx5LXReeboy7WjWzRJ3ZYjkCPCCwd0IjviA1kPsetnESybOzLrI5nS4Wv7zt7kKwNCrAmZI4dvDRdnX6y+AH5IU4QtZtu219gC0V+t2hARCzxXyGMCY846RgUV2I/EhN6r3jZJbcM4uFn3wfYe41mfqjjSa++hk9ME2GqkRjMCiGvu5zCkTYj7VfDtyxev60vnUJBIsFoAIDIA7awCY7Isgzm1nqjDcEtE740yy0ao9cTmUaj3Di2Guw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com (2603:10a6:10:5b3::14)
 by DUZPR04MB10061.eurprd04.prod.outlook.com (2603:10a6:10:4df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 14:26:19 +0000
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db]) by DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db%4]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 14:26:19 +0000
From: florin.leotescu@oss.nxp.com
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Shych <michaelsh@nvidia.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viorel.suman@nxp.com,
	carlos.song@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	festevam@gmail.com,
	Florin Leotescu <florin.leotescu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 3/3] hwmon: emc2305: Use devm_thermal_of_cooling_device_register
Date: Fri, 21 Mar 2025 16:33:08 +0200
Message-Id: <20250321143308.4008623-4-florin.leotescu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321143308.4008623-1-florin.leotescu@oss.nxp.com>
References: <20250321143308.4008623-1-florin.leotescu@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0302CA0033.eurprd03.prod.outlook.com
 (2603:10a6:205:2::46) To DU7PR04MB11163.eurprd04.prod.outlook.com
 (2603:10a6:10:5b3::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PR04MB11163:EE_|DUZPR04MB10061:EE_
X-MS-Office365-Filtering-Correlation-Id: bb39ee7d-5ef9-4218-fea9-08dd68845910
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?Z8xigk+HaRKXYn//n/wZp5+12Or4QSve5ejjpJNLaVmDx39PKl5Ho/mK/I?=
 =?iso-8859-1?Q?+GqeCGQbjDYND0OIkmbujS+85y7cRJNhY3/zzH+EF8Ik+SeAVprQktfJId?=
 =?iso-8859-1?Q?uHi9QsGM43JYEI8sF7sGnTKooOildkk/8KqySPKTEXI4r2JokmGbxUd0h8?=
 =?iso-8859-1?Q?z7O4XnB1SAEpyPh01/CXxqW2Jkb6t5xDfEL/A4q8nsgQVstypgns49+E2F?=
 =?iso-8859-1?Q?ilu54Y4vj2VCI3waioHTYDi0zKxVfwVqb5vNNd0NSeHykzudQ8dVj+8Gr/?=
 =?iso-8859-1?Q?3tobMLe8sRQIeve4BG7XV42kYNjEd8OBRDZtrRS+o5u/LSPOiJAuPoXSwc?=
 =?iso-8859-1?Q?cjtncbCGF8eOejdvcNsFWgh7P3ecDRdQYRVqNjUpslmtPsfCmX/xy44c84?=
 =?iso-8859-1?Q?vkmGwOdyWawociKbkyMrj2nKDzqVFNC1wMYHMGxWOTkubl3gS1gQhlNfBr?=
 =?iso-8859-1?Q?rj+s99S7BqU9YHHse9b1wCw3pYgxawcrPsJ52N+wYJCIV7k/jIPAnoZxqB?=
 =?iso-8859-1?Q?TgqnkuDDjpXF50cxcdGiMq7rxKihu9akBFogZmNh97ptLsVk6zk5T2R8sr?=
 =?iso-8859-1?Q?AyfU1MlFjX83giyJvHsf4m0X1yJRDwfzCkd9mwI96w4udWdhPXADBT++XR?=
 =?iso-8859-1?Q?HK9wlSGIoaZ9bV7rkdJcsMnaq9oYuSgBx+qVZ9+SVX6CQJUTHe44sej+VL?=
 =?iso-8859-1?Q?vEo36oWk5KqID5boZ0boZTDB/twR9KkzYhBRE5ice4vZ2wB999lS2vR8Vj?=
 =?iso-8859-1?Q?h0YsvYGvgL0OQ8WHmhKlJ3Cy83mzXSg7dOX3no3P2hzTcP2SjCNld3EGcp?=
 =?iso-8859-1?Q?yKU6ZjecfHDNA+nYNwqu5W/p3C803r0uqZsNeen852bHQOFZFtCXVwi2ov?=
 =?iso-8859-1?Q?RRJBYuwAm4WiEMGAFmtS27PzQsvlfBh0JR3Qf8G2IGHsb6I/phbOlKLqZ7?=
 =?iso-8859-1?Q?t4XlA43hQefyiw4Sp+jDqNZ3d/VtGryMwYyg6/ZZRAwXQABn/IKi1OYdJg?=
 =?iso-8859-1?Q?3P0BU1BhB9rQYW3Dl/JyZrKOxRDXxsX6qfCotXdQi7H8BaeMCFpUn9bBqt?=
 =?iso-8859-1?Q?Dv7vGGGpEPX4yXfw2uQB12tb9k1oCjPRUIgJK4Wb9VAh9Xby7fjZ46fPq+?=
 =?iso-8859-1?Q?8uZYIMZ5XfBU9XCXtZxCnOtoyinjHunr8u8ypq89Vgwen9m1Oi0EqizFVP?=
 =?iso-8859-1?Q?8fz2QnjpReP7/tcfZVY4K659JgmwE8XYFBkidETz50iDzHasIa9GP9wjdT?=
 =?iso-8859-1?Q?2G6XOQsqufgsEi/SHKFU7oflqNMSfTp7lmsipffyfivnMed/n3XgVpw3Et?=
 =?iso-8859-1?Q?cXXvRmiv4CW7AyQgO5hGug0dLdO/ealJE+6z8/TZ2cr7eEu5DwT8d5c4Eo?=
 =?iso-8859-1?Q?weVcNnp9IGjOfsYJ0eRk9EWZRDjMsG4Z7/yreEpJG0rrQFzGpTeg0jJSGH?=
 =?iso-8859-1?Q?Z5zmm2L7t5kGhimc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR04MB11163.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?t7cFTIwsv35VcYhkv0/w3NNLGRQlBIbJmKBQ3VW7AMQu0mb/nOe+l9lRmZ?=
 =?iso-8859-1?Q?gzR/ziFAn10G3jDwXl8TVfU9prv+CAMTdPwbtKHPyQLiDH1RKfra8hhhw0?=
 =?iso-8859-1?Q?hCwits9fL1xetpBoENE1bBqcnMeXhtDC2/9VVoyYMklyoiG5nnJb6omG9l?=
 =?iso-8859-1?Q?OGjUUXc3tcVEs7o/c/0Wxh1KqGxJJTfoIOa1qEhsI8kO6yovH0n/SS1Lfx?=
 =?iso-8859-1?Q?GNOjEnio9knAjxM6oyAnXg7P8dGrqnkpfW+WNNDIBUulFpwt7QILQt40Vv?=
 =?iso-8859-1?Q?10qkzwBFiqIPz3KuIXDd0+d2IZgFXXpCT5huWZ1doOflPIT4SRgxeYMDos?=
 =?iso-8859-1?Q?yOplDG1Hrt61qIba+JKSOQlxrUL4m+K8FzO/MypKInK7yzQ0cr+Bz2+kxB?=
 =?iso-8859-1?Q?oZRQIUKPFSwPXsGfjnpxo5zOSdMFK/6KwvHZgu1/eyiSa6C0KH02MIuyce?=
 =?iso-8859-1?Q?HhJJim7m/SQwPhlye1szHivb7eSIqBX/nOzr0vaBUZ8Q5Kc/zj9J909Lqp?=
 =?iso-8859-1?Q?GY25vZVaz9OE33xZ3zGpQwtbDm3cRieRKwbF0dzeuI4DfM8v8By2DmafIm?=
 =?iso-8859-1?Q?g6+fFi3lsTbvsYHZj8gBT6y8BKuYvQVCtQDBpxmu40uON4L34VfNt8IR59?=
 =?iso-8859-1?Q?+rYZPGIlOevhhxhlAMqxPUpwqHd50yCTj84VwB8ih4ac4jDk/7ySOP4hDG?=
 =?iso-8859-1?Q?6yZUKEJRmk0+6eCesCJ4X+dioP5KRY0wjcE5mMYYKxmaE0z7w+TcY6mgB5?=
 =?iso-8859-1?Q?vo5LuQ2EnKHGwU5p1zdU4y20T7EqI5qaJgeHhaU5Qm7rqbgl5y2RUVcjoH?=
 =?iso-8859-1?Q?MzLZNXZmkGyybzdc5Ay+593jO/o/ZqXEfZy7GyUf4o9ubKVWs8w3pfuzWd?=
 =?iso-8859-1?Q?JlFlHKp1lZuC5x3upYUX+LHD+YTwCrMbGngJRrJS8cjKHfkqD4/3yhtJw6?=
 =?iso-8859-1?Q?WPyWpf280QWuWSyDP/YDLgdYUMrv+7MY3a4Tn8BPFlh2du/CG/k+X1TmP7?=
 =?iso-8859-1?Q?18Hi58Gnb0yUy1E3o27h5I4vOV/G/hVQ0zGLVsi9EIuLF9iD1mq2SgjE1j?=
 =?iso-8859-1?Q?6K/KWBGk6Aj3hvrLlBroOC+UYpJiuiRPtTmtG7Af4wCbuztQOEqrL3FnOy?=
 =?iso-8859-1?Q?GvEQeVZW5vVFXAnBs3x/pyJVcBHztFmN8UWxDiqcWRCFOCa3iY5GHCN101?=
 =?iso-8859-1?Q?uipeYsD7zj24ilahkEDq2oda8fkmxdBmQAs/ARML0PnAIBNpdd8+sNmh0Q?=
 =?iso-8859-1?Q?Vnom7rokGSoEX9yNZxuRDRmUR1KsnEK9ljVKYL5TQGuk5RVGfvjI79R3zj?=
 =?iso-8859-1?Q?WG0DQ0lkD5DTVfU7LBcueWhp5jD1EM7mgzBWbN3J18nMzJZ5AETn9gNS8L?=
 =?iso-8859-1?Q?9yogmbU/ISkj4bFcxdc/NNoJtbJli70S4eoBUO489yrrHOzHKXjdnymZXY?=
 =?iso-8859-1?Q?UhsZKZCKSoNal8ebYmecXT7q4bJWZ/fxgUfe6GEGTsE1C2V49O8ovp4lkg?=
 =?iso-8859-1?Q?BHFWKZF4isNuR+mG/21DE65IkqKtUtE+uZCJzLdYUS+OBsa6VPfWzsNMLc?=
 =?iso-8859-1?Q?qu4BV57X0dWNHbs1fZ+cZ+TXH2pGTbxsDIU+Sd7FHwDd3YYkP/qndcpD3X?=
 =?iso-8859-1?Q?odIN6DkYADaV9shyu4Ee2bpJELOlrH+rw0RybBDtCLysWPLew2seNbow?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb39ee7d-5ef9-4218-fea9-08dd68845910
X-MS-Exchange-CrossTenant-AuthSource: DU7PR04MB11163.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 14:26:19.8209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SS2ev+iUOozMNIrpMxJ9PcvYc0lyCNOLVwhf3BK1QYwh13cwZpskOf5mQ6U0XOZy+NOJOmIJbBK+cz+qch2tiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10061

From: Florin Leotescu <florin.leotescu@nxp.com>

Prepare the emc2305 driver to use configuration from Device Tree nodes.
Switch to devm_thermal_of_cooling_device_register to simplify the
cleanup procedure, allowing the removal of emc2305_unset_tz and
emc2305_remove, which are no longer needed.

Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/hwmon/emc2305.c | 33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c
index f8a4c76fcadd..234c54956a4b 100644
--- a/drivers/hwmon/emc2305.c
+++ b/drivers/hwmon/emc2305.c
@@ -112,8 +112,6 @@ static char *emc2305_fan_name[] = {
 	"emc2305_fan5",
 };
 
-static void emc2305_unset_tz(struct device *dev);
-
 static int emc2305_get_max_channel(const struct emc2305_data *data)
 {
 	return data->pwm_num;
@@ -293,8 +291,9 @@ static int emc2305_set_single_tz(struct device *dev, int idx)
 	pwm = data->pwm_min[cdev_idx];
 
 	data->cdev_data[cdev_idx].cdev =
-		thermal_cooling_device_register(emc2305_fan_name[idx], data,
-						&emc2305_cooling_ops);
+		devm_thermal_of_cooling_device_register(dev, dev->of_node,
+							emc2305_fan_name[idx], data,
+							&emc2305_cooling_ops);
 
 	if (IS_ERR(data->cdev_data[cdev_idx].cdev)) {
 		dev_err(dev, "Failed to register cooling device %s\n", emc2305_fan_name[idx]);
@@ -332,24 +331,9 @@ static int emc2305_set_tz(struct device *dev)
 	for (i = 0; i < data->pwm_num; i++) {
 		ret = emc2305_set_single_tz(dev, i + 1);
 		if (ret)
-			goto thermal_cooling_device_register_fail;
+			return ret;
 	}
 	return 0;
-
-thermal_cooling_device_register_fail:
-	emc2305_unset_tz(dev);
-	return ret;
-}
-
-static void emc2305_unset_tz(struct device *dev)
-{
-	struct emc2305_data *data = dev_get_drvdata(dev);
-	int i;
-
-	/* Unregister cooling device. */
-	for (i = 0; i < EMC2305_PWM_MAX; i++)
-		if (data->cdev_data[i].cdev)
-			thermal_cooling_device_unregister(data->cdev_data[i].cdev);
 }
 
 static umode_t
@@ -599,14 +583,6 @@ static int emc2305_probe(struct i2c_client *client)
 	return 0;
 }
 
-static void emc2305_remove(struct i2c_client *client)
-{
-	struct device *dev = &client->dev;
-
-	if (IS_REACHABLE(CONFIG_THERMAL))
-		emc2305_unset_tz(dev);
-}
-
 static const struct of_device_id of_emc2305_match_table[] = {
 	{ .compatible = "microchip,emc2305", },
 	{},
@@ -619,7 +595,6 @@ static struct i2c_driver emc2305_driver = {
 		.of_match_table = of_emc2305_match_table,
 	},
 	.probe = emc2305_probe,
-	.remove	  = emc2305_remove,
 	.id_table = emc2305_ids,
 };
 
-- 
2.34.1



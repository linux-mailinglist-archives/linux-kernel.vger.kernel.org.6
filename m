Return-Path: <linux-kernel+bounces-294624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD2E959051
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC541C20E63
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7DE1C8258;
	Tue, 20 Aug 2024 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="aNWwGz/m"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020104.outbound.protection.outlook.com [52.101.51.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E0C1C7B7B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 22:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724191979; cv=fail; b=OwcvJI2pFbPaLbX8xQLpLZ2qWSWgnwX+uytHcyj+RgjzFolXRWUEo8ujEdPNbGIE+tHLvLPu/OwqS+GChh9SzNPoxTYQ+awKZUqDP2lJvmuy/5AUT8W9TgvAZFNUzrQR6yzBRPkqwTwqtjHCkLkR1kzs0zF28L+B5pF1PyjhOSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724191979; c=relaxed/simple;
	bh=22oDKWzcfTH0h7wDi7SLo6LDxI7XXCcd9gzQHwYd74w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QOUvkRzEnWv6EdzQUzR/C86IVU0x5cIbKvUdN7Y2iqW9nRr+/QSc5WVCat7dsUcGlHHpRJ+WFekGH/me3V2cbp+GWB4+d9au3O9JAlzzdJLzijfWt3l94rJgzE8F9EzKCvUaZPho4SbSgDNnV78u13wq641BKso9uIyntJ6myGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=aNWwGz/m; arc=fail smtp.client-ip=52.101.51.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYET6vm6D4XTyJbO3QxC9F8b28LtmXnbuW0+4DQphz9aA9NBfO4Hi8iMQL87+qrb+2EhB9ILqZmRHyER/Xn6zYZMWZDSR58Ax+hL8qMGcoHagPAZswy2+0m86EaNRm1XURF24zGtPbf+wybAqZMappGWISLYdXvs619RkwPAtLeZe/8sSJLHMbl3t0yBmF21c4LtL18I2w4DTiB36RQGaX5t3T1o7bS8isF0q+JyUkLsGeVAR2qPTiJRRZRTG0L1ClNHZk6GIaAYnYzbah6Y88IiEAiSBzSn2Uaj0FBwIGrS5SJ9phO2cG9C4TGov+910GsKkaDOJ7cMnHFqac5kFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWT9byCzx1h/F2NimXQpIKNzwc0SlRD8qgdi/yxbFJo=;
 b=antKFXNbJfSv2xn7KidxmB/n5TTRGc/oGF10ukOi48T0E1WsOPRD43VViHGg51kxuXi/1kvA3h7mUVHbhzmqmb8JYoUjP1gNm4Iq3IqO2ddGz4aEYL82WYLlTw0Nsx/JUapkrnun3UEDcfwm8s/X1bf7/igTJEtIAa/RQBU5kE7Yy72n/FTaJCnRmn583nJYIvwHVORAy1AUMBqYwMxTawgEa2YR221Xt4z0nCDO1I2z8OuhEHefdUFI2AEZ7TjmtOXLrjFLq6UCRcq19BlZ04aTEHd5djFxhyyw3MxaXVVirdZRs7xfx09x2kKa4LAbHRk3cSCcC4N4cDO/TmL3dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWT9byCzx1h/F2NimXQpIKNzwc0SlRD8qgdi/yxbFJo=;
 b=aNWwGz/mmId69mq+fClgh1WX/CCHCYNAeb1dCy20xSFgoQyQ0yMZiClTfN5rN9TdwuAhV5UAp7ECknP5y5LIgMXY7bxeMbnMqOSttpMjlOTT6fDcynqPA41jXQYvjdiY7ey7KhS8gvRDFvTuNNrMbUQR5vWoPEuoswX3En7sV5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 CYYPR01MB8601.prod.exchangelabs.com (2603:10b6:930:c5::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Tue, 20 Aug 2024 22:12:56 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%6]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 22:12:56 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: james.clark@arm.com,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	leo.yan@linaro.org,
	ilkka@os.ampercomputing.com,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"steve.c.clevenger.ampere" <scclevenger@os.amperecomputing.com>
Subject: [PATCH 1/5] Add dso__is_pie call to identify ELF PIE
Date: Tue, 20 Aug 2024 16:11:35 -0600
Message-Id: <323e931fe9f8f080eb0dfc2e29d112dd7edf1fb2.1724104248.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1724104248.git.scclevenger@os.amperecomputing.com>
References: <cover.1724104248.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQXP288CA0033.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::30) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|CYYPR01MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0c151b-ba9d-4e45-63a6-08dcc1653ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wsir/4LbK40O9nFlVkRK6ONIHNQ/EQqVsWqm9Qx3lU5IPQvTwHvjyraGrtyd?=
 =?us-ascii?Q?MFNn1t8rzso9b0ntrESsTl8jpMi/W2TObJCspV4jRhW2vLviNyK1Xsk8FoQb?=
 =?us-ascii?Q?XT0s4RHMiTQJAVhDq7ZxQo5Xqlp5JeNeKAbLJL29vvIqVDl1TFolHU/NtffZ?=
 =?us-ascii?Q?WNVHhp2h0NIMYGvM9MC0iZvbU5fiW8zyJJHnf+RxWWKBCf8FIxPj5qIl9QTe?=
 =?us-ascii?Q?XEQHLJo/V07degdBDB/dy77s2UZaC9OvIv86msf36/ZKfoE15DxrFrzAVki2?=
 =?us-ascii?Q?ygKl8hk4IgHyDz9qU9sq1c+KUVCrLJeEb+0g0d5I4AEWtYBXxGeH8+LmFgIY?=
 =?us-ascii?Q?U3D9hL9z8W+E4qon7wBOG3VrPLOr6HeVQP4rADgLzTkHihseRkyFk/iIYCmV?=
 =?us-ascii?Q?EXAZ1Y0Z+vTfU0c0kPNGw+ltAM91tkrrXIyXX/u/GBrRUMzPXZ/lKaph4sxe?=
 =?us-ascii?Q?RguZZ7uhalRNOAvn5JHprG0dV+piVZu4RAwYQHkdq2tX+BZFV6krKnsWYaWj?=
 =?us-ascii?Q?mqp5z5RjWzMw+tFiCV2j2XGE+M0Sihh5rbQnBGs/3R5nZPRpubBnENJatuRQ?=
 =?us-ascii?Q?uq9RefAvTCZGYJIBvFCQcqFliHz2bO203inyThtDEuMxmwwdJXKoniYUkhRN?=
 =?us-ascii?Q?8hbVuVgjveYh7TOPVp68vrQcCwNxfZXuHtEY5um3NiFojvq0bVPe0M0FOKsq?=
 =?us-ascii?Q?a9ynC5UP656MQKJgeBJ3fogpX/gIVJa7BCQ2uk21yD2x533RUxwKNcd7J88K?=
 =?us-ascii?Q?s6OFGSnWsblJF6gCRWQDBs3Am2wYEDAAMGDEESxiJP/FHaDqkyqhMFb43Nmo?=
 =?us-ascii?Q?gnda7teNZMSMLfTVn4Uk6TJfF3Rv8aUes/LhWk4J8etfEXW8e5pgupjlQ4zS?=
 =?us-ascii?Q?kW0Vl7rh0mcJbYHU0FhdFYUGLOUW2tWtcu4KeQOEPuTdjdlZAWzKKbjglsu8?=
 =?us-ascii?Q?lB1k1C3eTCWbuf4m8N3RaAn4v5+/iGqM+OCX/Mhqr4HZ0WC3ka0v+hNqeJkO?=
 =?us-ascii?Q?vDJf5YkDVTfqQb8GNAUEOrpxeWcXmkIVYqauG/9Hv2PHQ6b1fCAZFJomaGQy?=
 =?us-ascii?Q?aHDBF6XhWkziGp5/WsHOmWVBJcK/ZBALvnBdaw7PU2oc1QMKpLe/gIQTSW9I?=
 =?us-ascii?Q?RsIPMfngj/3C2HsoWrokhxUt7GSV+CIvedrDbd10qF0KBkkJo6mswTIxTbGD?=
 =?us-ascii?Q?74Gf95up6pmi6X4C1csbXzDXxI52IUhEzkQD6DabIsUj3lj6PO6ehXt5TO9W?=
 =?us-ascii?Q?M1LRMLP7fnafL6utfBGR+PQEAiTEOqDrxjUHmckGZ2FdzJ4On+DbclgZY76A?=
 =?us-ascii?Q?xT/r+8IK6aqnMnU9PsqwX6Gx93FHpfEFgnynTQWWyKstJy0HXxT4Ex7Rp8rX?=
 =?us-ascii?Q?aRVdcPCf57ho35DrQIVpe34IHBhTcWeY/6z5a7xFaMbye0pRkg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vp9Ky83OKTR5f3VVCuFw8k41pBOFL2lXebG4sKmJlZt3PyGykua9vkaG2teQ?=
 =?us-ascii?Q?UAC7Q6PjPOvEFnHUP8N+Ois6W9OFnIIV8uDfJsdqZ2dgC+yrA+3QlpvvtfkM?=
 =?us-ascii?Q?DbxO1povtN9ILR2W8fL4G6eduvShkKwwHrI0VqSIj88tYI8xnhxqP9VTxPm7?=
 =?us-ascii?Q?eHqXag+HU/w+5yk8oxotXN6wC1rlccbSE8XoFPRW5suX0sPFG9bG8rfkJDoM?=
 =?us-ascii?Q?N0qew/q8itvEHLOtJVuXGrQxoAzKiPublzDa6qn3TeDmsefJ49EWTR1iXXY8?=
 =?us-ascii?Q?2/Qzamkj68VEVBDokqkBNXJ6va6f/Aes1cOFAfKI2wOw5f040azZ8SEPLkJk?=
 =?us-ascii?Q?KcfYjH0WdZZnVwAz8loIMZFc4OcS28oJe+oevUUnYM1wqV6MPdQnD+L+7C4B?=
 =?us-ascii?Q?/jMtAwMmF8gU67RTHVxD0nsNnjJ85nKAUuEHOTvWB0pm5aFxHrh0YLIbgKIN?=
 =?us-ascii?Q?CXCU93f7Xmk4ClOAGLYYgrGS43++Rzd+QaViq6RxH8u9RHnjIOx0ZG2FvF7+?=
 =?us-ascii?Q?cV6rHjnCSyUpaMwsf8hjIcFgIue4/8Gr18luqCOOSpW6JG2Qmbj4BLueobCP?=
 =?us-ascii?Q?pM2wBqmOe3F+JxEj/6Zq0EEOl3lZByJYJvQL98G/A8bbJ9lOnADY5v7rDh/v?=
 =?us-ascii?Q?vxahbeOYRqGGekA4pVadPn1unGvOHRWgt9r7ki8AYmYGE9pBIJ8SZtbE0zx2?=
 =?us-ascii?Q?4cEKOM5WEfsrK4tECyYc3lVo4UAWuo0ADrFI/tjM2GCZ+MVxwL8BdXY73Ikx?=
 =?us-ascii?Q?FflmFkJew+DWIJWwaXUx4r85jPAw7HIcpRRkkQ+XJcFyid3Jk1XoEc8fAbQY?=
 =?us-ascii?Q?UdteS7pS0d7bmjeJVwUcTyWp7mN1/B5i6XZ3mOmM9JVYTGn+Xm6LG2ef0zJu?=
 =?us-ascii?Q?OAAg5Ognaf9hbG9KvoSGsy+EMWgm7epbRmwlBKROKdgy/fyy5swEc0YF0xla?=
 =?us-ascii?Q?SCde4XygM2X6RNeQVJ8wFSL8EYTDKCDC0fSTKv3F7DPBHXHGOn6yIk9KhAem?=
 =?us-ascii?Q?LJZDUkxJB6MASyWptPDgxr/9WZdlmyNLMkDMDVJKXHW9SP9Oj6IJreOQCD13?=
 =?us-ascii?Q?kWWDGv4NrU26lb2juH4J+oVLeZ4Wdr4SJb2OmTxrI3pmtnpKJxFggg6DrtGX?=
 =?us-ascii?Q?PDUiz8f/83GcrKyZXCnRuSlq43qJoF4gMNKB1uITI6QnGFD9HGi+QiR22+1d?=
 =?us-ascii?Q?tzXoOcWqW+U8XqouskZxVuzZ/++yQ1DXk9oNh/ZAyQRswMmWhv2Rv7RS6yhc?=
 =?us-ascii?Q?q6DZ4xvRUKpAOq++PZIjcNnNEkp3ZbzhVYwVPDdF/Jhjw6Y4Jf04KBXP/isM?=
 =?us-ascii?Q?fKDAJibdn4gp/L9WAXbbK9RN9D/sM2lHAUdGzvhgDI6gnlJHmEBjOrRzkFJt?=
 =?us-ascii?Q?7RsTDhnjIU54UsSkAclVbs+Z8SVs8LON9an/bto3IhXpmQZdk8I0BO9eYdT8?=
 =?us-ascii?Q?CknWq8JMaHlgBsut2fVcrynnOmxDpoNv/HcnGzpa+A8q2bDxbU5ivpbc/eM3?=
 =?us-ascii?Q?61i0yFbnOxNrzcOAlaFIbBuoUoEt1Qv2wRdMcJUsd7xLPHp2wsOTEbfzRz8I?=
 =?us-ascii?Q?DW0nvFKNggjHKcqqTsKJqbs/o05TiFSRFYzzI6oiaqp2cIx7N8S7f7wVeDC2?=
 =?us-ascii?Q?ucLkFE+y/52tCZVMkeL2N+cJYl6diJIY0md7KEeWcRgA?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0c151b-ba9d-4e45-63a6-08dcc1653ead
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 22:12:56.8273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0O0fNvdJdjQlD/XRgVWiDhzcSJrxUbO0lTYxd7CmebRuooqtckvxMuLgfgkIPT36YEpYovlRhYZ8VEf7c4+uHJgOhCWVkcZ1LB0/7yb5g2E6kdWH8WFQ555nGsKa9xo6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8601

From: "steve.c.clevenger.ampere" <scclevenger@os.amperecomputing.com>

Add dso__is_pie global to read the .dynamic section DT_FLAGS_1 entry for
the DF_1_PIE flag. This identifies position executable code.
 
Signed-off-by: steve.c.clevenger.ampere <scclevenger@os.amperecomputing.com>
---
 tools/perf/util/symbol-elf.c | 55 ++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index e398abfd13a0..1d4bd222b314 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -662,6 +662,61 @@ static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
 	return err;
 }
 
+/*
+ * Check dynamic section DT_FLAGS_1 for a Position Independent
+ * Executable (PIE).
+ */
+bool dso__is_pie(struct dso *dso)
+{
+	Elf *elf = NULL;
+	Elf_Scn *scn = NULL;
+	GElf_Ehdr ehdr;
+	GElf_Shdr shdr;
+	bool is_pie = false;
+	char dso_path[PATH_MAX];
+	int fd = -1;
+
+	if (!dso || (elf_version(EV_CURRENT) == EV_NONE))
+		return is_pie;	// false
+
+	dso__build_id_filename(dso, dso_path, sizeof(dso_path), false);
+
+	fd = open(dso_path, O_RDONLY);
+
+	if (fd < 0) {
+		pr_debug("%s: cannot read cached %s.\n", __func__, dso_path);
+		return is_pie;	// false
+	}
+
+	elf = elf_begin(fd, ELF_C_READ, NULL);
+	gelf_getehdr(elf, &ehdr);
+
+	if (ehdr.e_type == ET_DYN) {
+		scn = elf_section_by_name(elf, &ehdr, &shdr, ".dynamic", NULL);
+		if (scn) {	// check DT_FLAGS_1
+			Elf_Data *data;
+			GElf_Dyn *entry;
+			int n_entries = shdr.sh_size / sizeof(GElf_Dyn);
+
+			data = (Elf_Data *) elf_getdata(scn, NULL);
+			for (int i = 0; i < n_entries; i++) {
+				entry = ((GElf_Dyn *) data->d_buf) + i;
+				if (entry->d_tag == DT_FLAGS_1) {
+					if ((entry->d_un.d_val & DF_1_PIE) != 0) {
+						is_pie = true;
+						break;
+					}
+				}
+			} // end for
+		}
+	}
+
+	elf_end(elf);
+	close(fd);
+
+	return is_pie;
+}
+
 /*
  * We need to check if we have a .dynsym, so that we can handle the
  * .plt, synthesizing its symbols, that aren't on the symtabs (be it
-- 
2.25.1



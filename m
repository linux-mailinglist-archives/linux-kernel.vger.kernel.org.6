Return-Path: <linux-kernel+bounces-193207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15938D284A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874CF282ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C92A13F459;
	Tue, 28 May 2024 22:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="FFlbMHsM"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2131.outbound.protection.outlook.com [40.107.93.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B9B13E40C;
	Tue, 28 May 2024 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716936716; cv=fail; b=JpO4/T9ax9l6LVsCewZh1Z4cf/qIrzGEffl2cLqpPVdQbebg8lbE+dxWUDu+ZrXgTZMwgaVp+rSJd2Vwgk9LtQk4/iJmwWrcYqT2G5QAnQAZ2KA3JgHuQAP/CvK/5Q1Zv8w7jk8yUGEBang/m2QGKX2mExR2so/wtVqjHA6Sk74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716936716; c=relaxed/simple;
	bh=KVF8Q/V/AecVL6zcAzrAprbsOeF5Va6vbO27yUw6Uec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qvzpc7WxFB0u9fmyLPNhjFcrO9R1RvvoZG0AXenoAPDfMYctjF586+JkysKKlmnn1a6gu4VAwJRI7jzJB84W98dyD9t9tfHNN4di35+xKMnkN3JALJ7FyDm3/tYyPl0RP2vFykEmAMV4DXM0WRE9u13BAgINSY5JUfyPqK6Sfdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=FFlbMHsM; arc=fail smtp.client-ip=40.107.93.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuhKIgQpRwcqdbMLXpzwBtOPGfP8WobQ0APDJJsduNff1qaXXgBKtDSUazn6WOxij0PBblbfCoQEUnHn6Bz02AIFe7hYBVNpqEeNSYiXpYJFZNfzJjcrz4gF6YswAO9BxaYYbiV7h1Oy09OmTxLmie5YxcZtzKhk2DPI7rgDoHn9GBtm8NmfY2a2vUxJYkpb8XjvYRnWkvLCO6ZIlQp9z/uayYiTzGO2//FPxCjx3XjwcP+r+B/FiISvHffFk+OklluPkgoeDhJ+xQdLmLowPgPeuLxwF+A190oC9hm3rJW6wW1QreZk72lkAyR4iYxRM3cLvwd3CpJWqZanSlPx5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExzhjeuiWnTxf4MY7B47Ym6qYUbubvGwNO9lphzfZn4=;
 b=gviHtEZtsXo8gNF7GX/9QeBfCNc0mq6DnNXLuJZe4NyblEOQvm6LlCfVRf5TIiTeS0NNZosZok7xt1bFOCUvXFtKjqkPeG1BcdBddlm8XMnX0/XonZqouGDtHAp/Cf/ae5iYArEYFiFS91EWR885vW7NVJlMLoSQgyM+lsQ0/5TBBbgUJWGoyYc/e4ySOd/D578msjWK+ipUMrmL9oCpCDW8tw73Uc/lS50Cw917hvGLEJS8Fz1KTItlOOil6V8lPCHj8DePvefyOEkvzkW7qfTqOzu3B6G8KldT7pDF+mLOB70UTTgFjEL48cWXMB7bmv3EE3rjp1jq+Rf0QlHbOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExzhjeuiWnTxf4MY7B47Ym6qYUbubvGwNO9lphzfZn4=;
 b=FFlbMHsMrIbN/q9kNNBiLtXVRZIxs9P+nQx1eINijP9ewdxaCZnrf3xpd0WbCblXGzUKe1FMDewJEbDB32tKfQY8EluXATYMiGPikmLWcjq45zbH2AZ3EF/ymrpzacahaoou+kzuvGwqNES0szZ9SD6H/PX26PvteP3huklWUpc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by EA2PR22MB5065.namprd22.prod.outlook.com (2603:10b6:303:258::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 22:51:49 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%5]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 22:51:49 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH v2 1/4] arm64: dts: ti: k3-am64-phycore-som: Add serial_flash label
Date: Tue, 28 May 2024 15:51:34 -0700
Message-Id: <20240528225137.3629698-2-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528225137.3629698-1-nmorrisson@phytec.com>
References: <20240528225137.3629698-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR07CA0049.namprd07.prod.outlook.com
 (2603:10b6:610:5b::23) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|EA2PR22MB5065:EE_
X-MS-Office365-Filtering-Correlation-Id: 98baebdb-97ab-43d7-78ca-08dc7f68c27b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|366007|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NMn7iRQ9q4FGlVqPKDdO0ioyyxcqxVXgxUx/NSdf1mCMb/WXv8L9bPzGY0BC?=
 =?us-ascii?Q?VV9FYb4P4BsHTfD2QuGHvZi/eTq2Pb3UYM82M0zNQhGh0Edlyuy1/VqGnoKr?=
 =?us-ascii?Q?QtelR/zsUvlRLbjBFFBl7Ps/L91Cf20f4oPd7Rant08JEKIq1f0PK7pgVAnV?=
 =?us-ascii?Q?/ezbn8RrS04y+PsLvOfKxBGpE+HxZZgB7WbccZC+prrAlKCbA2Ka1AmOJvDb?=
 =?us-ascii?Q?xv1vrp1iPPKnh8EiptwyGJ+ngfV9RCPhDmKX+AYD6GXO8aBKyEvHQVKQlpva?=
 =?us-ascii?Q?ZEbKj4rWwjNbNhGT4Bq+GtwzY6e21JBn/2C4RAFYApYYMC+JUmsaX2dnpSKd?=
 =?us-ascii?Q?YPB+DQqWEJXpexwaadXFkrUj9coY1VbqwCWdUpgH3iS3W3B+g0UIJ5XfsGED?=
 =?us-ascii?Q?8E3s7KfZAEDOOwo1K6/4yOAQWrXMUF+Qo3EIGUMut1ujAsAtJha0XtChPCNw?=
 =?us-ascii?Q?IQp8TFnXWF+BH/JAhP/kkSQlur1X7NwHasvxJSkpZeQkjGul02p45gCMP2QP?=
 =?us-ascii?Q?hN6HWZY+dU/vXUF2zYS5SWEB9gJp7qmLxfm6oc+P8KDaJvxdtnEI6pzQ6HJ7?=
 =?us-ascii?Q?GPOqE7H3pzJ2ZcNuZAB1Q/sixQiJpFweUoeIhvBtacY59tvwqZ3E4uTpb767?=
 =?us-ascii?Q?4hsy3SU/XpzCcJWh+l87xOTPO1DujEMR3pAqQf/0QSrRTF1rHltCXvp7EaT8?=
 =?us-ascii?Q?qjLwR6sZxHZm0oijn+JlcREh/z7GxbxwipTcv+G9vIC4nqV6UUBKTp9Pim5a?=
 =?us-ascii?Q?7gHwOv7ubSJ6Emb5kP90nFpYXYilLeeCgos+3fTCwEskJAuw4y6gb91x3Vfn?=
 =?us-ascii?Q?3exzBBj2NfpQXubfCJ4+bqFnRbDty4OCq8I8NSIGdJELW1XEDBYl/baieSGy?=
 =?us-ascii?Q?hAArbJTWCAnjpkBpld99ljZGxan4fY+ZiW6CBw87NyqnjgMYZ+xIqjfn3UbC?=
 =?us-ascii?Q?icZ6tAF3jUMcblunvJsWfTA+GDYGS91srovWXqnS6mI7u1Ba5OAAiKx2AjdB?=
 =?us-ascii?Q?0fG4sonluCoz9KgqIdQTG8Ovzle3h2dKKNC0eD4JdyZrr3JkldrKG0ohoJ1w?=
 =?us-ascii?Q?D3gdNgJYsgDFm5MHP/OOayOCsO0QemBWILcO95g+b7LX3W7AbrWUkz+xEYhI?=
 =?us-ascii?Q?U/it6hff2ShxpeJhpNh8tRnwwZaQoNFaCmM2vM5QzGVJi6p8MWYGLxdWEbit?=
 =?us-ascii?Q?Caw967kDc+dy40czVHb1rwEJ7FcGAici7JZIlFnzwo+QPyCIPCpmSVl/smlu?=
 =?us-ascii?Q?m1g0dhNjOwcIOoaZYzEyeI/Uoa6yuziPoPfkcekdiDCf4bTmffPEFpCNAk0g?=
 =?us-ascii?Q?XodPxvd1pahfqR0hVqueb5kvsBsRc0NtIa8kO85HYrjMhA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L5o64LwEsLvJtfBFMcb8TshWegcBQuqSmPjlG+5B8TxXOzN1W4jFSdLX7xMp?=
 =?us-ascii?Q?kdTBVnBfE7rH0T2qW8nua6bfvjffwMpB06VAG605CDsePwSNkBL2UPCt/HIq?=
 =?us-ascii?Q?s3JtTJeIKPbXpcp6hKJl8rcVX2fBr1F6m1Ei5T8bfGrPjXJKH+hWDaBzRB/o?=
 =?us-ascii?Q?EL4Sa8+9X0yeCP6/ysSV2UFLD3qjvNQbPnm3vAyRsesz5jgQpbyV2f/pyjrq?=
 =?us-ascii?Q?kh4+AbzVcZg2Fuf8QLRAh6+yHcLEGg4gMQ7oo9jP0gWrWF4lYELrEDv+GS/3?=
 =?us-ascii?Q?EX7vzffzT45v4JLkhEedGwi0BGwvpOXNyYaYSFfmrUqazmohycWjTRpkaizC?=
 =?us-ascii?Q?bXlKM5wfQ5qetgoqIeqHaxvIc15JaototFyrreuov9z4vtiG0ry4D/OHsOFu?=
 =?us-ascii?Q?k8wvPQqHDZcwoVN/sqd+i3n5I7FoyFMUMLtV4uVN5XMk40ianyC3BtDddmxv?=
 =?us-ascii?Q?CjAiqDd3pp/XOKOx/R451PQCb0vCR6lvKJyIUajvwnHlD66OX1z++fkRgNd4?=
 =?us-ascii?Q?3wVzPc00ek5UX5w+SsUpo9qKcGNAgDgYODsy6n0Hyqa6SDDGY/5CoI7txNfx?=
 =?us-ascii?Q?Yzf+K9kLBCj7U9p7/a+wrskby5t3PwiISLdz1037tnDFjfl2vAiIcY3n78Pj?=
 =?us-ascii?Q?v4ReaoLi3Sko1+cGsWhrfVny1h3O+ekfpHE/vhquM2u8Xw4IfznZsSFAgTFZ?=
 =?us-ascii?Q?MM9uWLw2I89w1AMyckXeyJwtprs0QcUpzU7OThLTNBERwFeiwgQfYRxIUgoJ?=
 =?us-ascii?Q?hutKxOWDYZXMkh41Tgt4AV8sdnN7jBZXJcqbDQDjcPUfnxBs0JXLfZ0LsnhG?=
 =?us-ascii?Q?K1qzSnFuLi8dv/gfJ72NJICZPGXsb02RRY8ca8haChAr2tuieS1LWkyH//+X?=
 =?us-ascii?Q?BSJSHlmvJmdSharlfCjZzfhA5Bipvulj11Ao2WV8RRBjm127ib2Fh1BHN2Ju?=
 =?us-ascii?Q?LecA+SAFKTwuuMxz7Xm8iWIY68QF+3T5mwr8XHDmyhzso/MxYUiv8wLk10WY?=
 =?us-ascii?Q?hTawoNfgOrEHJX+hY2RICDNbSkLabFV3vmhyFjCUMOV0KRZvOSpkVKsFDIOC?=
 =?us-ascii?Q?V2St0nyls2WkiyBLAPhTJznNr51q04ynLpVAoM1AizeQrW7+TurYWGaYM7Sg?=
 =?us-ascii?Q?qCbI4Pz3A5VTCabfWgiO3IDu7m2xMFELHmZEyQSWCuJR6aW+XkjRc8hUTe4W?=
 =?us-ascii?Q?Bn5w8NNOP08rM8iJnvyl0B18lunv/7uM9qbyoNNgG1C/le5v5ssIwjP1SJtw?=
 =?us-ascii?Q?nWm8ds/aRagdEA2WiIo+uVkuKN/4HgygP2Ls1MCV/kB1bATKQ6eIc0qxbMwO?=
 =?us-ascii?Q?jkxHQhFpi3BWPXnubEv9oX94NcXDImB8r5/IMDw37L1mDqM5PMZCyeUWBdqL?=
 =?us-ascii?Q?9umi9vNwMVwFNnoAWd6P8IGu2R2lwkru/I+g0TFARe5tZiboEMl8Gs5XmdlO?=
 =?us-ascii?Q?amkkLxqw1xSKnuCKHdPzF8jRecfAneHOPhqG2iLaSAI/Q8atajOhMumcreqW?=
 =?us-ascii?Q?5bQ+8E8OGRBd/qJcH88mw8kYiuLF7+Vc+IUF2d21WnkiyKtut8B8vwdP2WnA?=
 =?us-ascii?Q?HRRXLbTqUoMFM8q2uvJbdI7Z6MZ5/bQOYUXXdjQo?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98baebdb-97ab-43d7-78ca-08dc7f68c27b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 22:51:49.7524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1abjPkMzFKYE6sPMd71d1mZLWD1vwJaMELkjLoZ/dpxsJTy4PsVJh6k4yggWjsaZlLu2XBuPKMElifZCtLu/Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR22MB5065

Label the spi nor as serial_flash. This allows us to disable the
flash with an overlay common to all am6xx-phycore-som boards.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
v2: No change

 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index 125e507966fb..ca0bbf21f7fe 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -296,7 +296,7 @@ &ospi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ospi0_pins_default>;
 
-	flash@0 {
+	serial_flash: flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <8>;
-- 
2.25.1



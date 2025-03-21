Return-Path: <linux-kernel+bounces-571524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF9CA6BE59
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D1D7A7B71
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4B01D5CC7;
	Fri, 21 Mar 2025 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Ox6d3iE3"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752459461;
	Fri, 21 Mar 2025 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742571084; cv=fail; b=uqv5rxJpgCxBoXf5+chuhsXWJIu/ZRD/Y6cDOHf8mefH7s7zCyR6hvEhSvSj6ThvlofvKYxq2iWW5zdvcNM5ulwAtMSDSvkSMWk9Zg6Rzb6hn4qp3K34CvrITzUZ5SN2UWNF0jDQfgNtLSSh+bjkPdnlWTTI+3mkdXhZsf6fW3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742571084; c=relaxed/simple;
	bh=Rm/Cqs+vTXrOxQ+84GUEXEB926E3Om9Ehd7a4AxkRSk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oUwYAqNEaqIYbGmXlN3YrMCUovpywT4zz9+MGp6GZmK+pXu/arun+wdQHG6d/q2rmV+mEPEoARax0/4iVjr9fmbEGdK7Jz9jI5zRgFfkFNcxtoSp20HPbpG26mckqMLFdR+SCvMa856xmn0S+AfMkmCWFoh4b3VzPKSeeh5HI2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Ox6d3iE3; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQCyQMoC61g84CopV5s+B4YPhB1e9C4ja7Ito2r27eHSkY89kjUG8c3kpfpCt04AOy/NUwEWQHZOmhJGr+84xEpqgeNy8HXMcgsW9JP6Wy+uSIoGR54m41o1ceNCmWMGiSTTNCwhG2q9Igi2cNxKcuWqYw/x+Ciqh9vguyT21YbEAp41oC9sk880pKGhi99aIetHbmAwayBlT8jjGY4vYOzekDUXvj3JpA8fAGpKsNmd+jLHB/n1mXj6OIjJuhAC/bz13y47FD0iDedGRE7SWO5La4+K5DZ4tlq2adxdold4Xe5x9y705ZV2wVLTRSNfIMkhs3CxruybRrRLb3AwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNY0ZihGMsQTdtmCOamL80IG0XzpI+z52L7j9gdmu20=;
 b=aRWNjhAeT9G6xWIhYJ0vJqFRaSYaiBT9Aihgh7ZOYdERw5O+ZN+kxAkp6kvkJeni3euX6plugX8dAPZhwhwqG8KGh1f47qJwSDvNGH8u5G1IqHNmD7J6NgBkfSYC/Bv+QY/K+rdEPgI5oK1R4IGBwpDw0I2IY2r9ZFmkwcjtdf1qvTm/wwRUW3ceOYC9GUL0c0HSWWiNRMTSilGy6/2tDqOIZSFW3u8k6j8jAwnuIwk6Ma3z2WxPQ931ZiSvGOLbe5midOJKpPY1+Ypq8eEAOa5CB4HH5AQjmuTAat7Ii7HlAaIwoi0nhoJ0VT+4/lSwO6W29Y1MFY+a/jB3rzFFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNY0ZihGMsQTdtmCOamL80IG0XzpI+z52L7j9gdmu20=;
 b=Ox6d3iE3aosYHj56mI5hhlwT78PoLtd4wEbF+K2mEqThYinFtsycoVNdw3X2L6e1dPj+1TiAu2hslkrYG3B93ROWOTiJPyhdL3icUQGjvZ0KoBQd2lVfHlW1CUxz8bUGXKOaEgQoShtwmzOMQCcjc7OrR1sGLBU0/mBa5OQD1hoM5yKipCza+8GlGrUmzVUn2LwZPNOpVSgDZ3dmI73yUfI1yP0UtjH9Pd0JwgJdnDFU7uf2ALITI3xcYmgxz5L3BQjxjqA2OdXURxZqz98HRJd5HLiBjQMUGUjsehuYgTiqtuwWuVnsSJcv9XZ/SzCs+NtBi7XWes89ikqiwpBMcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SA1PR03MB6562.namprd03.prod.outlook.com (2603:10b6:806:1c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 15:31:18 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%2]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 15:31:18 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH v2] dt-bindings: edac: altera-s10: Convert to YAML
Date: Fri, 21 Mar 2025 08:31:09 -0700
Message-Id: <20250321153109.8362-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::31) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|SA1PR03MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: e22aef34-1be9-4f30-727e-08dd688d6c92
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WAwN3LkaSsEFlV1vrtAm5/4Dpu6QDQw41Cf4Glxwv9xq3N8xx1ESAI7/IW9g?=
 =?us-ascii?Q?lIA4PGWOETqAfvfxs3BGqOvGlVnfMl0dxSSuHWYLmDtjE2Wx2XRlN4n5N5wG?=
 =?us-ascii?Q?bnYXO8YQ7PUL3/Q0Yd6cW0hBKeNCdbXHI3W0UAp1eoU4131YvFrkn82yw1VZ?=
 =?us-ascii?Q?MNNmiwP8MoLavA8OSDBD9jOrrvBFhOoq7MiryvQTcaskbsGPVUo4W8NTORZX?=
 =?us-ascii?Q?KMElWbVncTCYJAMnID6ux1iMCJxurexMmLx6uXPAoBPk9sJ4vkpZriji7KnU?=
 =?us-ascii?Q?i0j5Xg5i1Mb/I4qlcGOXVslAsmc00L1Uxz1Yhxrpd18/koJ82oE6ZZiui7AA?=
 =?us-ascii?Q?mC0pojPEmovtoNVHup7hldbE7Z81WI7n2YbjE03PiHjWmCuH2lFgiIxIq+yC?=
 =?us-ascii?Q?Rgz4NYdHc6FyucSWk/p27IkVfOiZE0yinNF1Bj5nDhtkEIgFQUOmNycH5kiT?=
 =?us-ascii?Q?zbi+bV1HQajMrrGcz4Uj/ItYTCJjLa7BkuKX53Tod3qSJFkqGzD5ZbrGiYaE?=
 =?us-ascii?Q?p1251pnm5C2rW4SV4uZZExNFLefoNrBucljRowbNHUwHL80Pp5FMhHZQ0M+I?=
 =?us-ascii?Q?cJf1EF9RjjS+ky3feyUNF4LapuwS+1Zd0LAJ2rko1Bn+H9GcsMOjE2zIWpmF?=
 =?us-ascii?Q?Nl+7ocXOiUw+erxRGu9NJYDpwLLpEJ5G/0OHW5E8F+17EcegWdo4hPoQRN+N?=
 =?us-ascii?Q?yNiDK/131zJOaLaKb5VwzDu+Z7wl6+4nPUFX7fHvZTORN3uH2slh+eYh32Bx?=
 =?us-ascii?Q?bzMvPnQRbL5HGT9ZxaLI+eqemXqTR6i1LE4azexwvX7pQfDQWGa2OXcc8MWK?=
 =?us-ascii?Q?JV0SdHKGlspbYhT9A57hvdnTWkfmyMK5Gv49QBUeNLTfu1obSwln8OAmjUjK?=
 =?us-ascii?Q?nPLTio6za0fV+hQVszLlQUb9zaG65BZDcr/g1JiTLWiFh1Dpdrc7CRiJJ2OK?=
 =?us-ascii?Q?wKhziCBHfv9F9Ux3SUXm+rq15G70LcRz4IoH4LRjLS9sQjinklsynXkqxWVX?=
 =?us-ascii?Q?VJGnoIhWoIHpTc0EYHJl5wLXsLqw/Ti6CEmG+SCpgON9yMLRjdH+Ex2zQ3yA?=
 =?us-ascii?Q?zOorW+blJ62wMywzCQ0cs36k5rVY611/ZuZBTmFO++aPOKWCUEs31q3BvNGq?=
 =?us-ascii?Q?tFmmHdERK1zVUSpBs9fbVJibpmgXV8X7U6jitmmHERIgdqxCEPviOMmS1y2K?=
 =?us-ascii?Q?TEu4psVoFVAMb8nQwh42+cFGlCb2xF9XR/+t+jY/a8GK6nRXbsKoWsv2OPAl?=
 =?us-ascii?Q?eYH6Oj1ljRWuohBzIEDXygwAc8+GDV8AQtp68VHr+q0VdefbSohGNgGPltnE?=
 =?us-ascii?Q?Ko2X9i+W77AIRntxkLyfWzTQGuOIKwMRagcIxY3QxvNvzw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?83GNth+83o0VfvPKC+iUOM04Zmv2A8D5UAhJ6k+JBJuH8abu+I5rpNvhm1TQ?=
 =?us-ascii?Q?560W58lU1lIyjj5g9t7IIGja71VxjPdmYrXjekRCejWfrhhri/QOH1HCpkEs?=
 =?us-ascii?Q?BaKksbSrSfbjdmwSIC6XU7cNZEk4ZJ4yukvSzAvII2nMeIo4psk51X4/trOE?=
 =?us-ascii?Q?+2SXn4l+FmXoG5o1u3upjqsLQotKj60VN4bseMNnZ60UhtufpVge8PUYjuP0?=
 =?us-ascii?Q?veUbMA92ZeZp7QwMvQLNX2WYVJxYuO+wJGwdmzgrM0G92uWAnDaeoPUh/b3I?=
 =?us-ascii?Q?0EnuA+aCGJwmVstUoX0ITd1JB/Gy9SMvirIv9zNhJAD3wFcpcrendZoLzlGg?=
 =?us-ascii?Q?W7V9+Dw3IcVUFQUZQa3THn8WepNbbwndbuvQvFebBHOWIPCKUrQZS6LlzJtA?=
 =?us-ascii?Q?EsH9lWhJAfSZijswbBwnvh1+Aib2sOXeaf7+eGCoTJalRqdgT6jlbigkmVhU?=
 =?us-ascii?Q?3r6iuzKzPKp4h7oPckNuK58+g0t13uNAVfIOXzRWdOrk3pg4FrF2+xbW8eNf?=
 =?us-ascii?Q?210vawWp59Ny1Da6TXc6hF4H1qrgQrR3nsaQ/Yxf0Re7VRGbXPr6tf4bjGgU?=
 =?us-ascii?Q?Ai2eKgxsPyfcmFv3c6LVr2HB1Pwfsb5YOTyirlGyZQ26OeabwJbfCY0I+gh8?=
 =?us-ascii?Q?4I3OHG69dlclYfLnRpwZqd3UdB4LcdIgty1pO9+/3IbngnLmumreCsHfMEmf?=
 =?us-ascii?Q?U2/XYtSM8510BvBceaGbi2KBuAQb74x6+9r0+qehHf0t4xJMABsN7pVQq6X5?=
 =?us-ascii?Q?tfu8rwIUfgQUwewBTwLvTj1nSm1GjAznQIlhFguTYznwCU5y3kFTKU+vnTK6?=
 =?us-ascii?Q?DbkCnMJsFvmJoUzvaSskLLpoovdezLH9ve0wzp/pXr2gVMgsINu7OARoS3gc?=
 =?us-ascii?Q?tqD2dIF+1tclKH05VRb0v3rTgGMmbb7SEOBbQmjg+T98oVNdVall8YV76vlJ?=
 =?us-ascii?Q?W+2HTC1SdN7P2Zk4s1pz9JG/31XVY30AW61feuAx0n10xM6vUu2IdN+XROhV?=
 =?us-ascii?Q?Jwqv8x1eILEw/S+G4HXIh4kCb79/CeYoVFa8h/utbWCnR+I3McjXBfxyUOHO?=
 =?us-ascii?Q?UneocsnlJbJ6SGzJWviw4BY4Nk+M8HglGw3jwg7tMuO8P+Mz77R6r/kL77Do?=
 =?us-ascii?Q?OEHvmkaXm0jCUc3LLOCNdLw0CPjtTkETxrG1yUqAJq2bRjyUbIExKtE7FpBU?=
 =?us-ascii?Q?R1hiGZpnd6ZYvVGMH1UZDOiXufbFfVXd3/oQS4MZhq6uWUby/3aaZw4Dc1fE?=
 =?us-ascii?Q?0/gUD5i14whrRrahYWdtTxAUUrWbViIMAZfwDHMg9t7r3vtA2SLdW4/TzE1/?=
 =?us-ascii?Q?rIzf/e9Yypn/4FRvReGKUbdi6HdUESxNkW1ARPqTUf8QC7A8mwg2CSIzP4sf?=
 =?us-ascii?Q?zsCmj6WjaVi67BIBaVyvbKShIo1uffzn7KVEpzZp4ofDai1QcQXYqsbRSdb+?=
 =?us-ascii?Q?w3CfRgpcNClM9fdsqUCBQ3wqMCkJi7NyQDPABMlTF7GhnFu187C5RTs5ssXh?=
 =?us-ascii?Q?GQsToNzKeaj+NIjwnKKQwoo6uYL+/kBEtCr3VKD4iOcpxicM1Nu0ZgAJ46JS?=
 =?us-ascii?Q?LA6+7Y0s4SOBVu4VE3Me0H3Aq7p0DqJmiVYarNXAvieJ4icW9b2WAcNriG0l?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22aef34-1be9-4f30-727e-08dd688d6c92
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 15:31:18.0871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3veheX8WTzRU6vDqOwSHBYUqm2DdVC6F6Hsr+5vBcWW4fKZh/TPiO63GWNUAyXAwYhWvvqHKCtq1RAgmalwgCNjjm8rcHM4YXOdbewkZUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6562

Convert the device tree bindings for the Altera Stratix10 SoCFPGA ECC
Manager from text to yaml.

Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
v2:
 - Fix $id: path.
 - Remove unneeded '|'.
 - Move vendor properties last (but before child nodes).
 - Add appropriate blank lines.
 - Don't break ABI.
 - Avoid changing existing DTSI and DTS.
---
 .../edac/altr,socfpga-s10-ecc-manager.yaml    | 280 ++++++++++++++++++
 .../bindings/edac/socfpga-eccmgr.txt          | 150 ----------
 MAINTAINERS                                   |   5 +
 3 files changed, 285 insertions(+), 150 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml

diff --git a/Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml b/Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml
new file mode 100644
index 000000000000..a908bb4df60f
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml
@@ -0,0 +1,280 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2025 Altera Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/altr,socfpga-s10-ecc-manager.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera Stratix10 SoCFPGA ECC Manager (ARM64)
+
+maintainers:
+  - Matthew Gerlach <matthew.gerlach@altera.com
+
+description:
+  The Stratix10 implementation of the SoCFPGA ECC Manager counts and corrects
+  single bit errors. Double bit errors are treated as SErrors in ARM64. This
+  implementation requires access to registers only available to the Secure
+  Device Manager (SDM) via Secure Monitor Calls (SMC).
+
+properties:
+
+  compatible:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: list of compatibles
+    items:
+      - const: altr,socfpga-s10-ecc-manager
+      - const: altr,socfpga-a10-ecc-manager
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  ranges: true
+
+  altr,sysmgr-syscon:
+    maxItems: 1
+
+  sdramedac:
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: altr,sdram-edac-s10
+
+      interrupts:
+        maxItems: 1
+
+      altr,sdr-syscon:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle to SDRAM parent
+
+    required:
+      - compatible
+      - interrupts
+      - altr,sdr-syscon
+
+  ocram-ecc@ff8cc000:
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        $ref: /schemas/types.yaml#/definitions/string-array
+        description: list of compatibles
+        items:
+          - const: altr,socfpga-s10-ocram-ecc
+          - const: altr,socfpga-a10-ocram-ecc
+
+      reg:
+        maxItems: 1
+
+      interrupts:
+        maxItems: 1
+
+      altr,ecc-parent:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle to OCRAM parent
+
+    required:
+      - compatible
+      - reg
+      - interrupts
+      - altr,ecc-parent
+
+  usb0-ecc@ff8c4000:
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        $ref: /schemas/types.yaml#/definitions/string-array
+        description: list of compatibles
+        items:
+          - const: altr,socfpga-s10-usb-ecc
+          - const: altr,socfpga-usb-ecc
+
+      reg:
+        maxItems: 1
+
+      interrupts:
+        maxItems: 1
+
+      altr,ecc-parent:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle to USB parent
+
+    required:
+      - compatible
+      - reg
+      - interrupts
+      - altr,ecc-parent
+
+  emac0-rx-ecc@ff8c0000:
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        $ref: /schemas/types.yaml#/definitions/string-array
+        description: list of compatibles
+        items:
+          - const: altr,socfpga-s10-eth-mac-ecc
+          - const: altr,socfpga-eth-mac-ecc
+
+      reg:
+        maxItems: 1
+
+      interrupts:
+        maxItems: 1
+
+      altr,ecc-parent:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle to ethernet parent
+
+    required:
+      - compatible
+      - reg
+      - interrupts
+      - altr,ecc-parent
+
+  emac0-tx-ecc@ff8c0400:
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        $ref: /schemas/types.yaml#/definitions/string-array
+        description: list of compatibles
+        items:
+          - const: altr,socfpga-s10-eth-mac-ecc
+          - const: altr,socfpga-eth-mac-ecc
+
+      reg:
+        maxItems: 1
+
+      interrupts:
+        maxItems: 1
+
+      altr,ecc-parent:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle to ethernet parent
+
+    required:
+      - compatible
+      - reg
+      - interrupts
+      - altr,ecc-parent
+
+  sdmmca-ecc@ff8c8c00:
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        $ref: /schemas/types.yaml#/definitions/string-array
+        description: list of compatibles
+        items:
+          - const: altr,socfpga-s10-sdmmc-ecc
+          - const: altr,socfpga-sdmmc-ecc
+
+      reg:
+        maxItems: 1
+
+      interrupts:
+        maxItems: 2
+
+      altr,ecc-parent:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle to ethernet parent
+
+    required:
+      - compatible
+      - reg
+      - interrupts
+      - altr,ecc-parent
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+  - ranges
+  - altr,sysmgr-syscon
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    eccmgr {
+        compatible = "altr,socfpga-s10-ecc-manager",
+                     "altr,socfpga-a10-ecc-manager";
+        altr,sysmgr-syscon = <&sysmgr>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        ranges;
+
+        sdramedac {
+            compatible = "altr,sdram-edac-s10";
+            altr,sdr-syscon = <&sdr>;
+            interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
+        };
+
+        ocram-ecc@ff8cc000 {
+            compatible = "altr,socfpga-s10-ocram-ecc",
+                         "altr,socfpga-a10-ocram-ecc";
+            reg = <0xff8cc000 0x100>;
+            altr,ecc-parent = <&ocram>;
+            interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+        };
+
+        usb0-ecc@ff8c4000 {
+            compatible = "altr,socfpga-s10-usb-ecc",
+                         "altr,socfpga-usb-ecc";
+            reg = <0xff8c4000 0x100>;
+            altr,ecc-parent = <&usb0>;
+            interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+        };
+
+        emac0-rx-ecc@ff8c0000 {
+            compatible = "altr,socfpga-s10-eth-mac-ecc",
+                         "altr,socfpga-eth-mac-ecc";
+            reg = <0xff8c0000 0x100>;
+            altr,ecc-parent = <&gmac0>;
+            interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+        };
+
+        emac0-tx-ecc@ff8c0400 {
+            compatible = "altr,socfpga-s10-eth-mac-ecc",
+                         "altr,socfpga-eth-mac-ecc";
+            reg = <0xff8c0400 0x100>;
+            altr,ecc-parent = <&gmac0>;
+            interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+        };
+
+        sdmmca-ecc@ff8c8c00 {
+            compatible = "altr,socfpga-s10-sdmmc-ecc",
+                         "altr,socfpga-sdmmc-ecc";
+            reg = <0xff8c8c00 0x100>;
+            altr,ecc-parent = <&mmc>;
+            interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
+                         <15 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
index 8f52206cfd2a..4a1714f96bab 100644
--- a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
+++ b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
@@ -231,153 +231,3 @@ Example:
 				     <48 IRQ_TYPE_LEVEL_HIGH>;
 		};
 	};
-
-Stratix10 SoCFPGA ECC Manager (ARM64)
-The Stratix10 SoC ECC Manager handles the IRQs for each peripheral
-in a shared register similar to the Arria10. However, Stratix10 ECC
-requires access to registers that can only be read from Secure Monitor
-with SMC calls. Therefore the device tree is slightly different. Note
-that only 1 interrupt is sent in Stratix10 because the double bit errors
-are treated as SErrors in ARM64 instead of IRQs in ARM32.
-
-Required Properties:
-- compatible : Should be "altr,socfpga-s10-ecc-manager"
-- altr,sysgr-syscon : phandle to Stratix10 System Manager Block
-	              containing the ECC manager registers.
-- interrupts : Should be single bit error interrupt.
-- interrupt-controller : boolean indicator that ECC Manager is an interrupt controller
-- #interrupt-cells : must be set to 2.
-- #address-cells: must be 1
-- #size-cells: must be 1
-- ranges : standard definition, should translate from local addresses
-
-Subcomponents:
-
-SDRAM ECC
-Required Properties:
-- compatible : Should be "altr,sdram-edac-s10"
-- interrupts : Should be single bit error interrupt.
-
-On-Chip RAM ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-s10-ocram-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent OCRAM node.
-- interrupts      : Should be single bit error interrupt.
-
-Ethernet FIFO ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-s10-eth-mac-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent Ethernet node.
-- interrupts      : Should be single bit error interrupt.
-
-NAND FIFO ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-s10-nand-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent NAND node.
-- interrupts      : Should be single bit error interrupt.
-
-DMA FIFO ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-s10-dma-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent DMA node.
-- interrupts      : Should be single bit error interrupt.
-
-USB FIFO ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-s10-usb-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent USB node.
-- interrupts      : Should be single bit error interrupt.
-
-SDMMC FIFO ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-s10-sdmmc-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent SD/MMC node.
-- interrupts      : Should be single bit error interrupt for port A
-		    and then single bit error interrupt for port B.
-
-Example:
-
-	eccmgr {
-		compatible = "altr,socfpga-s10-ecc-manager";
-		altr,sysmgr-syscon = <&sysmgr>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		interrupts = <0 15 4>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		ranges;
-
-		sdramedac {
-			compatible = "altr,sdram-edac-s10";
-			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		ocram-ecc@ff8cc000 {
-			compatible = "altr,socfpga-s10-ocram-ecc";
-			reg = <ff8cc000 0x100>;
-			altr,ecc-parent = <&ocram>;
-			interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		emac0-rx-ecc@ff8c0000 {
-			compatible = "altr,socfpga-s10-eth-mac-ecc";
-			reg = <0xff8c0000 0x100>;
-			altr,ecc-parent = <&gmac0>;
-			interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		emac0-tx-ecc@ff8c0400 {
-			compatible = "altr,socfpga-s10-eth-mac-ecc";
-			reg = <0xff8c0400 0x100>;
-			altr,ecc-parent = <&gmac0>;
-			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>'
-		};
-
-		nand-buf-ecc@ff8c8000 {
-			compatible = "altr,socfpga-s10-nand-ecc";
-			reg = <0xff8c8000 0x100>;
-			altr,ecc-parent = <&nand>;
-			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		nand-rd-ecc@ff8c8400 {
-			compatible = "altr,socfpga-s10-nand-ecc";
-			reg = <0xff8c8400 0x100>;
-			altr,ecc-parent = <&nand>;
-			interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		nand-wr-ecc@ff8c8800 {
-			compatible = "altr,socfpga-s10-nand-ecc";
-			reg = <0xff8c8800 0x100>;
-			altr,ecc-parent = <&nand>;
-			interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		dma-ecc@ff8c9000 {
-			compatible = "altr,socfpga-s10-dma-ecc";
-			reg = <0xff8c9000 0x100>;
-			altr,ecc-parent = <&pdma>;
-			interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
-
-		usb0-ecc@ff8c4000 {
-			compatible = "altr,socfpga-s10-usb-ecc";
-			reg = <0xff8c4000 0x100>;
-			altr,ecc-parent = <&usb0>;
-			interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		sdmmc-ecc@ff8c8c00 {
-			compatible = "altr,socfpga-s10-sdmmc-ecc";
-			reg = <0xff8c8c00 0x100>;
-			altr,ecc-parent = <&mmc>;
-			interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
-				     <15 IRQ_TYPE_LEVEL_HIGH>;
-		};
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index cc6536141bb3..c83565f1476b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3192,6 +3192,11 @@ M:	Dinh Nguyen <dinguyen@kernel.org>
 S:	Maintained
 F:	drivers/clk/socfpga/
 
+ARM/SOCFPGA EDAC BINDINGS
+M:	Matthew Gerlach <matthew.gerlach@altera.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/edac/altr,socfpga-s10-ecc-manager.yaml
+
 ARM/SOCFPGA EDAC SUPPORT
 M:	Dinh Nguyen <dinguyen@kernel.org>
 S:	Maintained
-- 
2.35.3



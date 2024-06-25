Return-Path: <linux-kernel+bounces-229548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E629170B0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C0E3B27DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F49217E452;
	Tue, 25 Jun 2024 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="gMUdjh+6"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2135.outbound.protection.outlook.com [40.107.93.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D7317C7BB;
	Tue, 25 Jun 2024 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341664; cv=fail; b=kq/7x8M3LbF2Z1l+GDvCGaaiiTBCdoRGGCKRmTHgjHNVC4ueE/QkQ4bjD0+JvHej+79Gb5RrEWfFMvjJAF+wZZnmG9GFFUearyMc82rVc12TPT8GSFNZkC4Ay2ewn8Ql9BseGP0LfmR4JuCt+7F5oj4qBy8tEMc3zEG+O/VRJck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341664; c=relaxed/simple;
	bh=1aE50oYaE9ERoxI1HYYCZOiE03fVfOACtrrmwr7t4Yo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mxe3GugmJitAO/RFyDlJaJ+xBnBlWVBVFnt0Naz/YmsgBCATDQrYXrlVZdsQxIhKmpPKf1cwjXUDd0aDYSwN8SC3MdULnGvpXLCDSJDWYhrnk2jltD4xatcDaZL6hI91BQfhI1XDZDs66NpfeehYcylTLqIPfZqHotujz4SQC/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=gMUdjh+6; arc=fail smtp.client-ip=40.107.93.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5RQOEU2x6KxWdDGm/zzbQBQm2Ck5YSzCa2U17U0HLWJSI4cEeqjNyAxs7b3az3tBk3mqhb7GwOaJqXHqhJhfjvDVD8hBq4uTmKCBEOZXW1YjGUz1ci77JVfhBdrFpu6Gjp7sZPL1YEp5MeThs8ffT00YA7k1u5IR3v+/XLnknMS7yoLPZplE1JmUSwP2fCHZ5Bi/w/mBLI+Pq4AEJL6+BOqy6n9FYatSL+UL9GfIphYNlrfXgaeGIr+OxNUWFwjl0nH6lyU1bfS7/ojlgtt1Rl8c6uOz9veH9nkRlAAj+p5AoAJbTA/Hb/M0oTgvXlZqMrs/rmC850UZzE6/g/rwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64+QqwIWI0IP6rf2gquR58Zu6FCmlUXlrqroKPYe0l4=;
 b=fGRY5OBvY3g3UBb1o4L0s/EQXgJMLtyIOjLkMCWFce6o6XSkm/vVxz+kjJPugaHm3WPLQKdbKtl4Y8apDg3/pw9Qw/JO/keZboTaZ73yGgoSdP7kNoI/b/Ue7RSBkvp/OtmrkyQuve0OhCph/z4wN0AQXFqaze900zXRBgKJ0iyS2iOfoa+/xuHdZbSurZbMTAZkqfVnDqOj8DzbC1M7E4SQ783qWKvYodIfeoUBDU2DqzLAhfHuZKdIzHZ9RJVZHcngpO8yD8qlqcKfPfs9C/lL8mwGwK8fhQ+J6g6Eg6DtYypkcakjGTvu81C+x9BkGhlLNQvOyO+xVB/FcZ9/eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64+QqwIWI0IP6rf2gquR58Zu6FCmlUXlrqroKPYe0l4=;
 b=gMUdjh+6CNgdNzkwGJLAy0lcboEBLfrNT1CkB6Vv2b/HNIsuF0dLtHbdY/HeW8huMTmlpWATeDDlC6SHS+urklf4en4FI6O6gFSVqeWG71qmBOUP5DBRKLqc59xni0xJFEj3mHIZME9Vf1Pmh5schOee6nBM7pJGK13+rb+qSaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by PH0PR22MB3911.namprd22.prod.outlook.com (2603:10b6:510:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 18:54:19 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%3]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 18:54:19 +0000
From: Garrett Giordano <ggiordano@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	w.egorov@phytec.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH 3/4] dt-bindings: arm: ti: Add bindings for PHYTEC AM62Ax based hardware
Date: Tue, 25 Jun 2024 11:54:01 -0700
Message-Id: <20240625185402.1896623-3-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240625185402.1896623-1-ggiordano@phytec.com>
References: <20240625185402.1896623-1-ggiordano@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR16CA0021.namprd16.prod.outlook.com
 (2603:10b6:610:50::31) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|PH0PR22MB3911:EE_
X-MS-Office365-Filtering-Correlation-Id: 6953cf97-114c-4d7c-a2a0-08dc95483824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|366014|7416012|376012|52116012|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wsI4y+bi4qC/+r9nBtvvckRdMLDVb8ZbXvK/2C3BA1VTXgwOMUWsQrFU6ttR?=
 =?us-ascii?Q?BQB5mqjPjsHXOE2h3V/3jJn8Xn+HmM4N8dxTpkm7rEIlJp9f+8WOpZnTiHx/?=
 =?us-ascii?Q?GaZKlsdoYY0xfuZK+JcZDViyHA6W86lehx3U/WOsy4F2Y0mAi5fwJT++RP1q?=
 =?us-ascii?Q?PE6po+oI3zkvyQrSBQ9DV9wcj4GDF+CmyLASOkJbHp/A+dWltPg0NNY06AMA?=
 =?us-ascii?Q?sk58w59asV9N2kh72LFY8OFsQKuHL/RCbnSYDhcpPZlifpGRmf39XJmT6aXZ?=
 =?us-ascii?Q?lULPSCiidGT5baB7dhn8ONDbYfeaPzieCwon09tHZEI8De2BZxOsQnddJj7p?=
 =?us-ascii?Q?/smkYwggeT2fPq0wDHAiEDBADALGr9PFvDLxHsn7hteRJ2pPtjg/yecHWekB?=
 =?us-ascii?Q?DauoRLexqmFvo8X87SVletpe4LGtirQOEKbR8akw097EtzOxU2OCSBNcUAFK?=
 =?us-ascii?Q?1+edtYI4JdKFEM8BBmu+ttbHmXo0xnBwVkrSmcx9Ry2B0kQymXRRs8V5g/IR?=
 =?us-ascii?Q?NZ+PN9Fy6TCHXD5r/IqdsFYCRrIEVXJlxcLNsgcyFUus8dyh74s5LNgVhudO?=
 =?us-ascii?Q?bJovLawyaAS8SuuQxeQG+fdD20qMUS+G+of1X7yAxlpKZqG8dL+MhuHyrph9?=
 =?us-ascii?Q?8l3mLTtW3kcW8v0WeWdH00Nx+QeEjKU+b40iVqVGsIgjcEInkDDZZBLejvUG?=
 =?us-ascii?Q?2t7ghYKbdgMtL+x04wO2wGFXYN4valQI15uHjDjngo9W1e3lEXLLrgcQS66i?=
 =?us-ascii?Q?yx0GACfbWvTOH9Vp7rKsCaAmshSd53eKphu4U05ZWxAdoCU7J6YOY+sDTZWG?=
 =?us-ascii?Q?mOB5Qfh9q//koe0qU/iFChJcwwR+4EyCJaRsctz0hTRI2cHYQMuonfBQwlfj?=
 =?us-ascii?Q?z/dETfUW/SwbRhOLEFBaKYcKf7ZYqIUUaaExZahj9au8w1D+0PB8wA3N5lIC?=
 =?us-ascii?Q?bpxEDcZEHu9AaSoX77zSPd1R4Kujnhze0A44rLhgg/RDcj1OIngFiBfayjVg?=
 =?us-ascii?Q?XcFe6Y3OPkxrTImmZgD1za83+ksikiuCqY8hd53f7nu+Bvc32vCvg96S+rMA?=
 =?us-ascii?Q?f9vBx9vdaiZmu6IUG+SE8l9b8invzO8AMtt+E5DpbCc7k6wk9HeCoCaVRpIL?=
 =?us-ascii?Q?CoLgOg0PmLYk+dH/768XowijvwSzrXoD1WKf9WzJKPTTdnBMX5JoilyY6iKi?=
 =?us-ascii?Q?DF/UY+uWHwEiIaEBW9JgG7lhaVmGtaG+70IctENm+GQhS3BEqeU4SwmSn7cH?=
 =?us-ascii?Q?y3Qhgfe8D6GY4we1ZoTeFMY97J6MlyzDI+usGzQANM3gOle6USilJGrvXAdb?=
 =?us-ascii?Q?OAm7DQtfbKX51OWuwASpEubx7RI1KEaaa2Qtf4N8Kcz/Hf/+QKSkDsaNAsa7?=
 =?us-ascii?Q?cx7Aq8U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB4354.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(7416012)(376012)(52116012)(38350700012);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TxsXstRqsKjYbZbmshMQ1N+ulHbX8y2ueE+cNIxGRNI3aCX2FsbtQ7ZIDu4x?=
 =?us-ascii?Q?aEqZwUrbLT8gjVApAZjS0attRQ+1BD4kGOF7MwxQrr5+y/n8innQjeG2OUvp?=
 =?us-ascii?Q?Hzr72msgGm/YISTNISwFDEPN2NKlvhXoJzacH+ekiBdHk3Py8Ii9ztzD+wgd?=
 =?us-ascii?Q?xiF66S4nIX6rcqwRmJ/5ebwcX6kTohmcOKf9r4JWOadUDrrz+KofZyeQN0KJ?=
 =?us-ascii?Q?gKHv+3jYapXR1ibfxSM9LTo6unDn9GSpWua3KF6/79+0r0l4QvibVHisDuAm?=
 =?us-ascii?Q?PbjSRLb1keChBJcxeXgEKA5V/CAmg3EM80pzIf2oTAUH5hL0pvdfefCZUwRq?=
 =?us-ascii?Q?g27UExR0SYRagVBKlpFdHZOXGVWr0qvCjK3gKryPvvD+7LEyDfs2UV1GXN6K?=
 =?us-ascii?Q?jnh9lBfzAqsm8CWMZOi+tR2kpM8YAmkjDDVJsJycHyZdvYEqjz660UK3uUeF?=
 =?us-ascii?Q?KVW5IfpwEDQuF4pyhwPMmXhNIeUx5xNd0p5llTUgYG602ke+hUmePzDFe9Pq?=
 =?us-ascii?Q?B7N6mPCyNcmW2t5bhJ622L5/QJNA256Y+0l37oEQCe2J4JW1JHDkfvpGEPrs?=
 =?us-ascii?Q?ctzXRUyNXl0XCUgsaeAC5tyUtjabFUQMByDCs4rPDbw2NLQxBBr67IzyyC8Z?=
 =?us-ascii?Q?bypqtyP3XUaD9uRKzhVllGlYbSGCf3rd1vDPksafMHPf+n0eWSU0mmI4zOth?=
 =?us-ascii?Q?P6x5RGSu8z5k7slMXUupxbCrcMfo5p+W0j+HbbkY/+EPIMl/xGbkfzi7I3d3?=
 =?us-ascii?Q?wbI88DgKrXKln323sZhUf+PbXYwRauouyAGQuYPzoSJvJzngu4jOj3x1jveA?=
 =?us-ascii?Q?+NMBLjcSjQ0gZShpxLBFcCyZH+iVrZlflhSBqYZuWk0ptHfhT42iITTl2hZ8?=
 =?us-ascii?Q?hE4Nb1hMkt7XYaExecVamQZMxPnMwl12uqa8xZr+lk703LuzCJUcv6z8uTJ3?=
 =?us-ascii?Q?LCuAFTwM2IaeeVoNNT6NgweLuVhS5jgHQ+qlDbnqsaV/AXPNOfkNCecnTBt7?=
 =?us-ascii?Q?BUxKGtMdLR2sof2M2WvUQGwLEZYNWFsGDRQQbzDjbLjRzCyP0WiwNt1rHfJg?=
 =?us-ascii?Q?aLiKlDApSVmvnmUl06Hv5ZTAixgeMw71D7wLaeDhpXOfYO6f+OvJUrqvCVe+?=
 =?us-ascii?Q?vWSTrfZys3lrJEX5KTdIf6/+tpSt1rrjCgngExm2u7CsLhYD5tC33WjISO+I?=
 =?us-ascii?Q?47yeF4PAA+H/m042suvSFS4gb4KKZz13XBa3+vQM98/YhpNJ+hku0wxDUuGW?=
 =?us-ascii?Q?nWw5f2yX577qH+8kEIzXWUgoCNsFfatYBx3SEC7Re2bwIKbZ4JlXw+vPcfom?=
 =?us-ascii?Q?7r/ZRp2rYaDbQhJuJ2BVUFzBMHbGevj7+LTJ8NR8VrQsaBmIVrJNhH7cmrHu?=
 =?us-ascii?Q?bV281I0cZzU8kPIwRwIXqgmKcRmleLe4TfmU9jZM3FuQIeBAQUhcU0ElnCmj?=
 =?us-ascii?Q?4W8yT6NS5/bNn6cq6CL5dRCBiOzxht+BgZRRaacYqh+eIwDSlGDYl8j4imAo?=
 =?us-ascii?Q?FnjstM1aB37SmyivYlJDB/G+F62lYPOY3DtATyOHpHfXzCAmSslnr+LeJP0z?=
 =?us-ascii?Q?z9SHCEcRm3HlBJak0WLAgr18J+RSd9hGPXfFPpZh?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6953cf97-114c-4d7c-a2a0-08dc95483824
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 18:54:19.3663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 501gBZs37bzhKXMajeoZVr8MFe5HrQjIXIcnqTp/R+1ixj4uWt686MxlmEfLFCJgXl3/1qQRzxMGDY4JzwZGGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR22MB3911

Add devicetree bindings for AM62Ax based phyCORE-AM62A7 SoM
and phyBOARD-Lyra RDK.

Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 52b51fd7044e..4d9c5fbb4c26 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -25,6 +25,12 @@ properties:
               - ti,am62a7-sk
           - const: ti,am62a7
 
+      - description: K3 AM62A7 SoC PHYTEC phyBOARD-Lyra
+        items:
+          - const: phytec,am62a7-phyboard-lyra-rdk
+          - const: phytec,am62a-phycore-som
+          - const: ti,am62a7
+
       - description: K3 AM62P5 SoC and Boards
         items:
           - enum:
-- 
2.25.1



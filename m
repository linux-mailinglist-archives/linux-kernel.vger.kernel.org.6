Return-Path: <linux-kernel+bounces-549428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06002A55271
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F7B37A8854
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A26C23DE85;
	Thu,  6 Mar 2025 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fQ8lWsYK"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012030.outbound.protection.outlook.com [52.101.71.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D69125A2D5;
	Thu,  6 Mar 2025 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280960; cv=fail; b=Ab5XwOkPDpqm+iLTa+RM4RmOxgq+qCq+ccc34zV93u9owIvQ4Yis7ipkIFqM+cS2HfGyHQP+cA0Nq2zMvqnPCe+AbC0L/BVCFQ+vZa/c4pIw4zF38vTHNySkI1atbVtBRpkbTb5vdyO9ceKuQKY8y4wAtGgWX93BYz7OWqs+IkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280960; c=relaxed/simple;
	bh=H82bzKuPor8gmrHqgJ9oGtjb2FMwlGu90NbQ0DjNsNs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Or9CVhuwYjelXkuf0+itnu8YtsZQyu5+C7dnyCADNsU1SMTHbNl0HBy4Q182sClLhMTWmit/8pJass+otAMCwH8gOSqwlVCkn59iuHUsgdxG5b0u3wG+hQybItrD9G57ipnQzY7INzHzEobdwGflkdiPTK3GQnKVnvgUH7nwV60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fQ8lWsYK; arc=fail smtp.client-ip=52.101.71.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z60McltDOkMrBcIqRgqq63WC8VXZo3W3t05VEEVDB5mWeJiO/Kz9CNZ9chfjcxxJQJXTXPiFllalcq5oCSJIDixFJW6vNsKCvY2IbWDcZerczjBJVYp+GRydbsIbBmb0ip/2qSdXAgFdg76bUlmeYGt6HrVeHDCIQWYL/Dis7kxOtzffM0bUEa3vQEPohQb1GESaoAtKjXW3uHF6qb4Hee5u+PGAEEUU8YlhgRx1UhOyxjvhcEj4KqbsiWlZA+JifOfM7PU4hciwO/rn4bOPZldRHoYa0bVubanmxW/c9PweSIz+YR/s3Pw5Mphj2e2Uhww4WXeUN08I/L14SVzfmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xN5W5MnLOjK2Erpvs1l8Y5ZRwwO32UIIg393Nh/R/M=;
 b=gJzJpUAX8tUY09EMzMUoI5zns8wy3XF1czhxgRuy7cXUFbFwIKYM21BFxPYVFDbCTt98/5M6cyxphW3BfJyykIm7l7mUtQPT1V9lvJdTp35S3htujohHLoEdarA1Dsne9U/AKofZxWcCt5R0VshY3ij2YbDt1oge1kMyfv0JCK1sDgc1KoYjtGkvyRY3lv7zhGtiDz7S8BUVlfxo76OW1j21pKnaBt8OY5FOENYJEUU6rGQ276cfLvYYABN8pEdmBw2JduUqpw7rqFDIalUfvZ0xlq63szF3rvXSJRc0VEQso3h33vITQiFKVYkKAaNuwZdwD26y2NkBZqmKz52Pfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xN5W5MnLOjK2Erpvs1l8Y5ZRwwO32UIIg393Nh/R/M=;
 b=fQ8lWsYKOmkixRb6VTtD7Y5PBJ26YzAGiO3+rBoDRFNbVDAjIb2c3mk8rAkFt9rmzgZI4W8DNRdwjL51phC8xlnIg/lTcoRmn6HiRF1PtPLH0x46+dW5SZMR11uMQYRps9daFvi8q408QyDF8p1Dn3hApRx9TRyy9slxzeLtRaUOe9mQmr4Kyi+QW2Us+kMawOLosrOy7ZooEv2kCTiin+2P7QdjrW+EtA//6XWJuwc+36mJpW5gk4rfI/JINvtDbm8++iXr+N5/fbVozlK3VDpg6eWve6UHxRjacCb4tZ/g3bu0qDFBPQXqvmoTMjqO8ldnqOSn5E7WF5PdRPM1sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9179.eurprd04.prod.outlook.com (2603:10a6:10:2f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 17:09:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 17:09:15 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bai Ping <ping.bai@nxp.com>,
	linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: imx@lists.linux.dev
Subject: [PATCH] dt-bindings: timer: nxp,sysctr-timer: Add i.MX94 support
Date: Thu,  6 Mar 2025 12:09:02 -0500
Message-Id: <20250306170902.241057-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0186.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: ac88a9b8-e735-42e4-b062-08dd5cd19f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WVIi5RNX7pm/pO9SIqbFue9TLBRbh5XchK845YP9E6/+Z/Jl+NW9NHmHm3Co?=
 =?us-ascii?Q?ILi1DCfhnVc8E+hWYZ5pmPFcA9ucwqHpQDyyZUdymuNi/fg9xp/C73eDmh69?=
 =?us-ascii?Q?2fr+JCqODZbQ0K49rnGUf9U68FWx0CkGEmEGpS0RT0BgZBViwAYRwrQbw9Wj?=
 =?us-ascii?Q?kNh5tVtLEIQsVxm+ZW3lxlhff4WKFCtmJn3j0Ne2BGxYyrBO9dIH1j68dmFf?=
 =?us-ascii?Q?98IFWpw0ur/NIlkDEMtSp+UThOAyFgxlHfsAWLVUfUA1bsZ5Ijz7f3yyV1F3?=
 =?us-ascii?Q?kvRZiRr3aYxAkzgvzqZohaNrPMi0zRyMnkc4JakE6ZLGrKuvBjzH3zZGfpuS?=
 =?us-ascii?Q?oBEGJbvD/4kx+xLCMl5SZc85SUa/SQ7Ov43E0shjsKPfAbTMSMLh04ukrukA?=
 =?us-ascii?Q?f34q++5nUgtaZISKvLMe34b8iluLlSFDVqr7YbaS8TPNDfmKPnOIe/8YFfaM?=
 =?us-ascii?Q?MX3yKOb/n0lyfUbqMczwoA/mwT5zsUc9oSiCocMjSlUaf1pYx1aexaYtitPq?=
 =?us-ascii?Q?dphD3yrTjWQvQXYadQ4+nrsvrbO+1sjULQw6J1p/sRbv5SDH977diy0Blhj1?=
 =?us-ascii?Q?vp5t3YYh2eVEeJPiPZUxjWW8a/hUHai5VooqtR3PqQBvTnWcDi7t9ej3w99z?=
 =?us-ascii?Q?gSSvbSl1BOZ2FvPO3XoQ3bGlF6/ZkT0S3o3y0ET1b2LKamY0R6lWRnbly1zm?=
 =?us-ascii?Q?IuRUN2PzETFDQ+6WYlbhTh0D9b4fgMlTX168nsbBS96Fg3LJ9uk4lSYK0Cya?=
 =?us-ascii?Q?3Jg9vn+SwqKfiqPDHTRZ1+T7xjxH8akh68cjNITQkwxAEOvb33ROJE9rYQkV?=
 =?us-ascii?Q?6Z+duNjfIYRc1fiZJ4N/pHBJhSsyWDasWyQ+mEdm/Es4qtaz3TuNi74QMyBi?=
 =?us-ascii?Q?g1HeM3B71jtzXaO9UnKQtr7W3YHvBWCudXV2e8byl8Be0T+qyxGvwX9m+fv6?=
 =?us-ascii?Q?TNPbgRycDfHxBNwzCqimmQ3lVlUZAdSKxS+CkOaUbtcTrDfMbEzdGCAK8CS8?=
 =?us-ascii?Q?O7YYR7U5SftBjDUiGUgoeWFB5oLIDFiuMv59JH3yYVVE9vQzM3lm1+Vf9SGG?=
 =?us-ascii?Q?QJPnq3RRnsuQy/hNfnYuRVPmiVAuBh2pjYCYh2FHXbSO3PA/xXIzkXTGwOku?=
 =?us-ascii?Q?D7PRAyPgd3Tsi3TYN84zmTncDOBwVd6tlPb/5bnuQd8+1WvXorCqdw1Z01+s?=
 =?us-ascii?Q?sBhk0SmRSvmdLyo1G4VjSq8GPBzzd5Pop6YKf+qnBvLS0Z2rd6NJxw3v63B9?=
 =?us-ascii?Q?P9vLshG5WrKVu04tt2OUTiEMpG6MPKxGRZ9lEL+QcteRF9L11gT59UU2QrKM?=
 =?us-ascii?Q?qrx2Xvj/Ol8GIyNeEIkUT1oECXvb6fziTSnDyl8Z/iPIhVKmYcdd9os+fJSt?=
 =?us-ascii?Q?dsqwZ34Xo47oHtm7FtFZJ/5yaL0Fp+K3elHGaidM6cLqMDY8tOTq/7TXDZ1Y?=
 =?us-ascii?Q?u6RUz7wCWOff9clyveQA0ZnyanZURYYj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rhDmmBUXHWXLbaCO6CwKCWdUnShp9tOwR8ETaFtepEwQ1lmEWHIZkd4oI5IT?=
 =?us-ascii?Q?1o7KfahktXCVgcguz4orn+lUBCGJMU9KZNbW2GaD3c58Cg7d7EmpeJI3IZlF?=
 =?us-ascii?Q?Fu2amM1ALg1+glTWhFp+4LMRImaXkQV+lgCpHr8mutbdt8mP2FSDxNwIUY0+?=
 =?us-ascii?Q?YdXDYe9OfJdcbKZBgVst4aYfHcbON0rF7nRICNnQCiyThpjQ19vFNNVHAwuv?=
 =?us-ascii?Q?NGMKeYy6tkPOyKjUS4nIjp7LXK6D2yDE+nZXj2XjBNDGXvPJk+wLoYdYHHax?=
 =?us-ascii?Q?3eloP7uhoT4sBpgdXWXkWP5ls52jWaro4pkeSAaQOk8yLS+0hGYtseIEVziU?=
 =?us-ascii?Q?gk0PFYnXsQIi9fAbgy/22TJ8GIIPRhR8BGHSgqrOIblVzMb0G/HzZ3aq5RjW?=
 =?us-ascii?Q?N505LI3yLzsIfMjL6eQTFLqK7QBEObebRQxTIJvNY0tJ+A0wWxvqom9x8hlO?=
 =?us-ascii?Q?1fGs3s+Lj0/jGMzFEoCdwuEc+i9C/HzWjHc9PQKUSbJBE+ZE2BPxgljEDlac?=
 =?us-ascii?Q?UPwG4dp42RYK3JCVY9SkNtrQEypZfqYWyY/NOS1c5t7raLBfVJWK+5ANWXll?=
 =?us-ascii?Q?NwG91kslzFE8QY+ttgNqtWUTmLZoMF97XpwTF0APdrxlsVfU+lDX2YtUHNu5?=
 =?us-ascii?Q?zJjqYzzbmEqk2dhptvVY+WeuAhuwHa2sl1JkbRYQuSs10mUAG0QjJpIM/+UW?=
 =?us-ascii?Q?gy7W7WIUSbCunwYAFwZlSWdYx479CZb1bw4lLsxqi0fX1BisWkOBDohj11F7?=
 =?us-ascii?Q?3o6S193+s1sQ6DmaAJ6GFC8oioEya1O6HiokoQ3nr4NQjxbhGt8uSuQQvYGi?=
 =?us-ascii?Q?DLtvUlcSRbZMFoXfoEmfWvY1lWhVbE8tsiK/QK2jVOD9Kk17yltBV5Rb4XwP?=
 =?us-ascii?Q?PVfcaoOjC/SgqDgqqyRQsdTEcgTez9xnjqheLbtrZACjd/uESDukS1ag8DXo?=
 =?us-ascii?Q?MxGpTecyVmiGJBfwiWLxmxpHJrCxGSlxNFZG/yiAqKb6HF+QCGdkmM8oO1V/?=
 =?us-ascii?Q?1UC/P7YrLsFI5OhfttanSzGZ86GNGkb1aeGqWMoeNQdgSBwWBDc+dsbcFVVB?=
 =?us-ascii?Q?gWeNMWmiFqMa2MOmIyfARij2UAGO7UU0ALf0POX83BZeqOmDjzZqHY9cKw3/?=
 =?us-ascii?Q?k9wKvNUjmwpSLFRVAYyT3burz2FD3NkKQNBKpKyITYH/damG0Lnef+M6DqEy?=
 =?us-ascii?Q?0POEfu1036Gin5GH1P9zv/RX6Lg0iTXhUhXThz76ihp0V9crEMAP5GmhfBkD?=
 =?us-ascii?Q?dra7TmjCnSshN8Q8fLJ0kcLp9+upZMZJaF69ZqVYBI2d8dUHIxIE4/BSQZD9?=
 =?us-ascii?Q?siaLbxgoQqcTj5QqMK3RgbIMulvwSI6k+PNYllLCO8wrf/2hb1uHI/zaNNqH?=
 =?us-ascii?Q?RRIJKjaR5mVgdwhz3jSjvlKu7vJWflODInJk+1Wy7sbQRj+8JH2FOWWxdoii?=
 =?us-ascii?Q?C/ko8aP/NmYZ3H3zTHkbdfW78y3gzoMQLpefJxhfsAAJBVdtHykV5/2yAe58?=
 =?us-ascii?Q?k1pypWm1qpxU5tgYQyFyDBIIWjacL2dMHTvtyaRGiRe1bKnMh0h9Qu+qsVvs?=
 =?us-ascii?Q?0CkApXrwkU+er1cR5NqxH1kIYjgP/ofgkxvHX+Fi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac88a9b8-e735-42e4-b062-08dd5cd19f8a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 17:09:15.4018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEdqjQb8w1x0xzhQMPRN6838++k8/UlJW1cPQfD+tW9X4lJ5l1S82n8qiJ9pwNGZN8KZnWk462NElHsRGowSAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9179

Add compatible string "nxp,imx94-sysctr-timer" for the i.MX94 chip, which
is backward compatible with i.MX95. Set it to fall back to
"nxp,imx95-sysctr-timer".

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/timer/nxp,sysctr-timer.yaml   | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
index 891cca0095281..6b80b060672e5 100644
--- a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
@@ -18,9 +18,14 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - nxp,imx95-sysctr-timer
-      - nxp,sysctr-timer
+    oneOf:
+      - enum:
+          - nxp,imx95-sysctr-timer
+          - nxp,sysctr-timer
+      - items:
+          - enum:
+              - nxp,imx94-sysctr-timer
+          - const: nxp,imx95-sysctr-timer
 
   reg:
     maxItems: 1
-- 
2.34.1



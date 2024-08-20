Return-Path: <linux-kernel+bounces-294621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB7095904E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F23284A19
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3CC1C7B89;
	Tue, 20 Aug 2024 22:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="b/RaYsxE"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021108.outbound.protection.outlook.com [52.101.62.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDC41C7B6A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 22:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724191969; cv=fail; b=gLBO2KA7NZ8Xx6JJ0TfpQRH39dIPcR5UYxI68+fh/gxNJBjn+Q8lK2hSRjgNAnCMoPErRQuGCQJ1/IQV6lD/+RvY6AwrnQ79QplHNzOj95AQxV1hcaJYAa6+cTYtx88ab3unmLoTHxCTMx7WAserZ9gR3BeoRvo8W80p1rDvpAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724191969; c=relaxed/simple;
	bh=SE9wnp3PNlh6ncwAdWNplsPT+lLEocEHqh/Odw+xo08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oz2QP5Yl1Frs6Xrd77xyBs2TzPUlaT2U196KShD1M2gWFcnnqnxeuZ2h6tqSVyoqSC8XJFPR14FfmjzNKggkNlYQGh5TtOlde7Jx7t11bMnFXLy52ixAxZeO2XCC3w3OWt4x7NZsbGfPj7KrIrphABUjQTQEA9xsMjb3nJdS6uE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=b/RaYsxE; arc=fail smtp.client-ip=52.101.62.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b26b5FRy7zCcVZ1IEo07sXQ+Tau5gg9J6Nr81g5cnanB+TsWlegTRtyB9V1a9RsnKY+XJoD6MxQq101ofbsCAUFzmCNt9wwqzqNP3/3B+2KyE3XDICLx86fu/fLGBG+ZcPrzqnzekBKhwDUzh1abXQkBmtNj8Poo72dtlpDnKsdRJqAaXmTV2gub2tU6ALs1cM++l1+1cYolM7zu3zAtMyxH0rSmUhC4CoEnJh5lX6JdsjppBBeC+7DwdRk3cLZtSGGatMSS0Q1QuZkOjiudsb9sbk+RiGZhY4vJeNu5sGc3OAmWXdIxOshUDBp+NAbZXXEtwOXncg0S75MzCaC7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pf3ErGzbj/xReXHB5DO1lBmCdUC2OrZTBiWWMTBwIS8=;
 b=D+Fb9cvmHORj7L9brgZPyoO+1SNmIgccACQNJy/F/7vBc2ILOji+yKmvVJ6q8CVova9tWr0+OD/eVk+wpf01JfbV2zT0Vx1crr3962V7r+SCrRUDDF67IHCKau/maNWvsVus0zYMtnkC6ZV/21EEZEElx9WccNNLdI8rk4kC/1lM5E90lVYyLa5IfSZNTy958z+ZtwkDLDIAH/f+/fdqly/+uLSgY2n5kmSa7WiWb+F1YaO7tjyxsq8szATsh4Faf0rhNk4XWGWZ8NXSM6CfpY8Yxndr2i9AK3huTY7ArhWWuY/g5JMGNQJstsbgofe4UIpZlye8ox5t1W2koAgyzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pf3ErGzbj/xReXHB5DO1lBmCdUC2OrZTBiWWMTBwIS8=;
 b=b/RaYsxE9MNxPrqc2Cml/IeAIM7WgC9O9xe+cYVIA7FxsguKJuSEH+dy7LqoSOHN6fQLP5pIRUArEUPY/zjlTWpd0Z2uT2PiQ4j0+eic0T8SI1sizCEL82ZRbUCdAAhExAXtgb+/B39wWy17Kn2UJSjKdXCKSdelHWBAuVpIgKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 CYYPR01MB8601.prod.exchangelabs.com (2603:10b6:930:c5::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Tue, 20 Aug 2024 22:12:45 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%6]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 22:12:45 +0000
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
Subject: [PATCH 4/5] Add map pgoff to python dictionary based on MAPPING_TYPE
Date: Tue, 20 Aug 2024 16:11:32 -0600
Message-Id: <a813c21ee60cd03df02b33bfa92515b659863bf7.1724104248.git.scclevenger@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: dfcb3e25-66d3-4ce0-bfae-08dcc1653803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JnDJm4b5wfQP5xcWamW2KycDlxZ/HJ0NoBf/3Jyi+2vfbWOYc+3ATIYCk6j9?=
 =?us-ascii?Q?gWIlUM0PbiFH/e/iCZmSw+YE3911bLImQEnqzJcckKJuF2lNv+rmUk8JsU0r?=
 =?us-ascii?Q?jxVlfWOFptfzCPmquvI/l0VFOREHc/OkEsGT+sYItLQcbfgpx8tobx+PJJyo?=
 =?us-ascii?Q?Rl7CdGq+ll6iPm7LYUoB9KIcMKAjgBLhaXqgNq+xzgLS0G3cMuisSc2kT3Y7?=
 =?us-ascii?Q?njFdbSrBiWE5cjUeJgd0Flf29GFg0JWj7Qe0P1xrJzeXHerbVvlCn+kAEv/q?=
 =?us-ascii?Q?JFK5eYPVp+1/wPWYVKF6yUaRFdZppOJi67IXCMd2qgL1D3wjYDucnAgVMVlz?=
 =?us-ascii?Q?+HoYKv6Y+nnJV2Top7IaAg+VVelLhgw/gDh8TiH0XIvlJEptR7NgFyNEmdFe?=
 =?us-ascii?Q?3QIU4iYZQXYdFbER4meX3n84WcF1N66NMnMI+1sD/G87/Z8wCEDUEPcwuxZv?=
 =?us-ascii?Q?titq1cYWT2sbhxd7Fz+LmPsGmsGLSp8lCJ+fIZnxkFrductsoIa6Tlz86ofA?=
 =?us-ascii?Q?HkLXVpmZgoivpzJR7snbRTd4DLNGQiPJA3/xDsL9E9n5AYHWtj4UvYlTy7uJ?=
 =?us-ascii?Q?LjEPeeMKQf5dQJqNV4DTO+Y6iTjMdDldCiLZyhvmoY2fzB6J/fszi7MYzWwH?=
 =?us-ascii?Q?o0Uoxl2QifDuU4KvWJu2p7Hs81x/IqEJfeNc+bOxB28cCVHAIm0Wk4ai1kkK?=
 =?us-ascii?Q?V3lonvkEiIBXwqD1QTpNi569s/q74H3od3AfuyOWOWq0MuHWv0pRwyjODAPd?=
 =?us-ascii?Q?vgC5t+MBxuwFy3rVkhSull9RSRooxji0eTxmDdRpG+4E9Xh6Rekz4NXp6ckN?=
 =?us-ascii?Q?/bu8FBDqTRVR8oYnqshAWUXsazuXTLx3jCN3R0JqQ9SGLV3CVyxwVfP046l2?=
 =?us-ascii?Q?lAua+XLxBAMPbtZZdX51mID2eDbWgxll1o9gCIWREuXLdHg43EZOJn9Y5FCe?=
 =?us-ascii?Q?VkZW7ehByF02anTahcFyvtzoQEHOZfn3wyXvaOFq0RpTI/ZRPhh09Rl7hI3I?=
 =?us-ascii?Q?PepsNPo9eCh7xIUWWgQwD+yKnuGOftG1gjMew8Q1ukgwMOCA14AkUY1Y8AW/?=
 =?us-ascii?Q?Im/zVkMsZJt0wz4CX/ZxVSiBmYUn0fXex/igfeZUCt2QAyyzKfZOwwrbhqzJ?=
 =?us-ascii?Q?BlxHN1dDXhbNSoEOgQK9DN0tFm05WHjQOiV7zfMKPvXK9qqY8cxOgTP29aG5?=
 =?us-ascii?Q?nlMGcelzE0+i4nE/2WvU/E8vmiM4k4zIDlAaTPlAq0DX8SgiTBJsBl3lOA1D?=
 =?us-ascii?Q?CvXVLA+ZzrfMTY6kq0nA+Vi6eukwByoa+W6XsyKhj/wN9/b3WtkHHGJo46Ka?=
 =?us-ascii?Q?z0YBmpKJFSTOH/km+sNWVsIYSOk8b1lSkSbQjoArawoTL/a4pUNKLp50Afhv?=
 =?us-ascii?Q?9/yh5DjgEnp1jySqDyjWwyh5EfHgzhlfvUw127tkXVm24boOGA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qYhOdPBviZXJc3Lr0/vdbV58dFbRW+cnuF6rw9dQP9ew6LPAqUm/Vaz1CY0h?=
 =?us-ascii?Q?e6V4oF+rUynBU7Z2wYSVdta8l1q4fq9976TxLYnIEenqufRiWYm5FsQM6jvx?=
 =?us-ascii?Q?9G0X+k5lK2GbFRXlBv4ayDESx6ZPV4uKQr8pMDYiG8pM6JxKP1P387keEpLi?=
 =?us-ascii?Q?rPz7+HVOwHEIVvqO9cAH12OpdbIR6JLL0z4OO1C/U+/hbuoB34i3S7lmCC9F?=
 =?us-ascii?Q?FOMs615QMcCqigmaHp4iG/L3adrkZ6cEniNe+03UbnNGgxMsv7ckGklF57Ih?=
 =?us-ascii?Q?gDp44DQqGMObGPUC/sOWJrRZPGcIWL6eH0+4V7gTBtTMRAsJMDQAK+FHACzF?=
 =?us-ascii?Q?x8vQciflTRBPCZZj8HNI+i4vBtXiysTHS4FhuXQJf8TP36NltLXU0LAipyEL?=
 =?us-ascii?Q?sV3fWFGrwAdg8pYIlFjh43/+qI3YRCGFWaA8ZJ7Y2w0c3eaH6P6eVeBj6Fx4?=
 =?us-ascii?Q?UMolsdR1iN8IrxC5lhWwHYB9Gvu2YgmSCKAXRnJ8P++Xp/PzvTHJiHfSmt91?=
 =?us-ascii?Q?fMnlOcsbv1HgqRN96S/L7DeQ9OrXoEKKUzpEyIOqklq1VpZnQ74L05ARpjI3?=
 =?us-ascii?Q?NkEiSno+DDYPa20zHvLT1UEioNPrjoJg2sBXYgt2luWQwRmrzFPyBLJxoDNr?=
 =?us-ascii?Q?iHMqMuonXUoe4NQChhsawqnikubMkd8SlkuKcYQe9SWuZgFw2YDtcI6fllHi?=
 =?us-ascii?Q?XCgcjJWk9zgrWFWf++WYBS/LMvjud0XlX6B8E0tpp/unQoo7YGKS07uh6PUq?=
 =?us-ascii?Q?V5JLt+QNgb0i80bTmmgRvnofWQLUO+H/OAmNPjrruhBBk2ZQ1vkONjeIfCkv?=
 =?us-ascii?Q?oLIlUKlR3hWc+P3PexRpefONCuzS8fHXlSmKUbMAsMAjmHAZZ27Hvjd2Su0Y?=
 =?us-ascii?Q?/ru3RaNpOmVNvZV5asCLOJyB9gAtmsfAzQ56KvsPKM5fw3U7/PIzpJcAV7Ux?=
 =?us-ascii?Q?axkgQ/5/4+uld7fBtjKCdrnqhI23XssHy8u96DfCc3oQWcT8QANdxO+fAQyj?=
 =?us-ascii?Q?LqsZuL5/me6Xy+aHtSCxX5wZLtkJMYNJ+kEYDcU0BDCgG8p3VaKj6JaVil8d?=
 =?us-ascii?Q?32POLPlzzkcT51wAu4szGvu3hs2u+Gc4fpDjM0AKNCi1PLJRW5+l+xdtHTo4?=
 =?us-ascii?Q?kI8uWVf1PGroR4YsUChcIiLA52np7O8rDMbutsfRJfNjB17X2hnApAe/xhwX?=
 =?us-ascii?Q?BO6i14LOy8CbN6UGNpX0aChLxlwa9LLwyr0muYL3ufAeo+oR5BfhEM7NiEQM?=
 =?us-ascii?Q?W1gr+oWl2eC5qBkCRe1mK4xAWdhvhseHya07jaAEg2tOrxf01SrBH6LiycVV?=
 =?us-ascii?Q?O5o9JdHdR+G4ohALva7VeX00DQH5QIgf2hkhrRdnZoRSfgHVW5WwQwaXfu9k?=
 =?us-ascii?Q?g03+UlNGGswyx0pTzSdeyo9TOrkpjLmHD4+CnH91RAdQytN3ltcFlD8vjz10?=
 =?us-ascii?Q?/uUfpYWdMktl8iI9ivunpflTLoB+vxInYDZQAZcpd6v71laoRSMBmxXcDzlx?=
 =?us-ascii?Q?jF43i4fmMY16xcoetcpRq6fDaPtBVAOlcdk5Mz39SI5VpgMsMMR5E5BlG2Xb?=
 =?us-ascii?Q?J6BxKLZ7mTSk8raps7RfR5tJjJiONsgsUYMWcZw8qYHIgxUxLp8uIB5tueP3?=
 =?us-ascii?Q?sakKuUHMBtbzBYFqlhsD16dvCpr0CuiT7dWETzlElMQr?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcb3e25-66d3-4ce0-bfae-08dcc1653803
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 22:12:45.6792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0Mz7L2AXNTeZxOV+DG/Y844JVsEZ898HHZ29USoQztxtP/pGp0EnBxV/3YhtVQszaTqQlgCK13FMa8ghwjbqranb8YMmP6X103huID3ylvrTqhttNvgWUb1yJmDy1p2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8601

From: "steve.c.clevenger.ampere" <scclevenger@os.amperecomputing.com>

Add map_pgoff parameter to python dictionary so it can be seen by the
python script, arm-cs-trace-disasm.py. map_pgoff is forced to zero in
the dictionary if file type is MAPPING_TYPE__IDENTITY. Otherwise, the
map_pgoff value is directly added to the dictionary.

Signed-off-by: steve.c.clevenger.ampere <scclevenger@os.amperecomputing.com>
---
 .../util/scripting-engines/trace-event-python.c     | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index fb00f3ad6815..8a056c3574ec 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -798,7 +798,8 @@ static int set_regs_in_dict(PyObject *dict,
 static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
 			    const char *dso_field, const char *dso_bid_field,
 			    const char *dso_map_start, const char *dso_map_end,
-			    const char *sym_field, const char *symoff_field)
+			    const char *sym_field, const char *symoff_field,
+			    const char *map_pgoff)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
 
@@ -814,6 +815,12 @@ static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
 			PyLong_FromUnsignedLong(map__start(al->map)));
 		pydict_set_item_string_decref(dict, dso_map_end,
 			PyLong_FromUnsignedLong(map__end(al->map)));
+		if (al->map->mapping_type == MAPPING_TYPE__DSO)
+			pydict_set_item_string_decref(dict, map_pgoff,
+				PyLong_FromUnsignedLongLong(al->map->pgoff));
+		else
+			pydict_set_item_string_decref(dict, map_pgoff,
+				PyLong_FromUnsignedLongLong(0));
 	}
 	if (al->sym) {
 		pydict_set_item_string_decref(dict, sym_field,
@@ -898,7 +905,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 	pydict_set_item_string_decref(dict, "comm",
 			_PyUnicode_FromString(thread__comm_str(al->thread)));
 	set_sym_in_dict(dict, al, "dso", "dso_bid", "dso_map_start", "dso_map_end",
-			"symbol", "symoff");
+			"symbol", "symoff", "map_pgoff")
 
 	pydict_set_item_string_decref(dict, "callchain", callchain);
 
@@ -923,7 +930,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 			PyBool_FromLong(1));
 		set_sym_in_dict(dict_sample, addr_al, "addr_dso", "addr_dso_bid",
 				"addr_dso_map_start", "addr_dso_map_end",
-				"addr_symbol", "addr_symoff");
+				"addr_symbol", "addr_symoff", "map_pgoff");
 	}
 
 	if (sample->flags)
-- 
2.25.1



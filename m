Return-Path: <linux-kernel+bounces-422041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0D49D93AE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C59E167BDC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0661B652C;
	Tue, 26 Nov 2024 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="u6LStWG9"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020132.outbound.protection.outlook.com [52.101.56.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A6F1B4F0B;
	Tue, 26 Nov 2024 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732611492; cv=fail; b=CMqUPTH9THRqrfvh1rOxX/phX2IygF5LLPMActqIf5hP4Yzdv3TlAMkeXWbO26f6wMjYuMZH3im8zfw1PAkYRg3+WDUGbEd58suQl0KleAuUvcjjj1oCFQ4pdr+BEyER7+OBVCagnrW+60Mu2BojPntcs8fuPIj7ZKt8owC8Lis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732611492; c=relaxed/simple;
	bh=FmxhM4gVQ+vsGnkL5/qxg6n9k4QAdwgz3d4+INthwRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W3/vRQHnJQPrmIKAxC+uBLMSlV0ppfxI1tZDa3DXHANEPNdGT/1/Eot71N1/0jXraD7UX1taFYbgAXgBhhVnfPXfw408pjB8amBJWqfOOvaTvLbL0JvVEq50I5oClP6R5MC9oms+haW2owKqVgI3r0OlhcUuqu3K9lQMgOsNFOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=u6LStWG9; arc=fail smtp.client-ip=52.101.56.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLIB9o2MobmfUdDf1wFno8QU2qszPjoUe0Gz2RsuUt9Y7eC5hb+qJNZVIcAXACKxT+nLbJwusobBDrz6DjJ9sK1SlO9S1EUmc3ot1/T4kIrWbxJ+yM4R1MYMR8046KpX3+rl7GXDtvryNqJT2rXbjj10PkSLmYCUH9H8Klpzro1V5NDkOAUzGr8fkMkSHisxfAFMAs/9HgNByrlKKh9ELttTS6unKFZqYFBhJJ6er2TCnZOIZI5HYrETNL6X47rWkQKuETnmGgqK5clxYUrEhf2btElpTr65VTsRJl23qLawoIAcDOUl3j7/jNj7MbqlxLNVV2Z/XkAOXSAT+YQNpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpjpmnTwu+M/9cfXmJeLGgllmPeWVSxYr07gRU47qW0=;
 b=GZMyoqC3jwkpg/e/9TzXQIH4uFgteyw/2AIiZe94E/uFQkpWLTGAOUCGZvBl0PhQpaGM9P6Awb2AQKL8d8V2focG6u/ytgVqASwWOKdBWR0MMsGhbyMIqJrqP/dw/uzC0O4rpScf9suEIAXnFCbq17Ku32qw6FAbpTvS0YGZ6YCAREvESM+Wf3Tnd2o8F4dUId5VvE0vh5lIBj0y5uCS16kiX67KjBPJ1tdouZRGQFDLzyBQRlyznc8lvt3PEZSHYMWuyjZ9GJL3e1jsCcJ4LgujHtKdLPL8SvUhaDdkQX8AEZX4Z0Sq2MTnJ6yg4GQrIta9TniyDgzp3Wq7iWzdSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpjpmnTwu+M/9cfXmJeLGgllmPeWVSxYr07gRU47qW0=;
 b=u6LStWG9Qohl4ivwLwgg4pWWyVB8I+aoB2dgb2QTo7noDnFgP7wi2FgOaQVxO9Fn+bk24MEZgk5eW7PiMCL4BA10c9/Ijtsud5yyitYdYokmUj9s9HDtIRl774n41BMKoSB5mKi3AMrPycm6MPTDhOHkE796MjRykulq78h+YgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 DS7PR01MB7688.prod.exchangelabs.com (2603:10b6:8:7b::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.11; Tue, 26 Nov 2024 08:58:07 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.8207.010; Tue, 26 Nov 2024
 08:58:07 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: patches@amperecomputing.com,
	paulmck@kernel.org,
	akpm@linux-foundation.org,
	thuth@redhat.com,
	rostedt@goodmis.org,
	xiongwei.song@windriver.com,
	ardb@kernel.org,
	steven.price@arm.com,
	suzuki.poulose@arm.com,
	mark.rutland@arm.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	cl@os.amperecomputing.com,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH v2 3/4] arm64: introduce rodata=noalias
Date: Tue, 26 Nov 2024 16:56:46 +0800
Message-Id: <20241126085647.4993-4-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241126085647.4993-1-shijie@os.amperecomputing.com>
References: <20241126085647.4993-1-shijie@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|DS7PR01MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa7ff68-7d43-4994-aef4-08dd0df871d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TEFKcpOHtg5z5zefOYJTlvAR0QnjID3Rue1zZ7fE/h8D7H3B3aLPPSdOzKE9?=
 =?us-ascii?Q?QITpfmPqQq/XW4CGmj5D234iK1AKEzt0RP8P46fRUKi9/W0snP2WlubaxaES?=
 =?us-ascii?Q?xx463rM+Z72XKsCStYw/etG1+cdGj2e9wRDgt7Z57lhFpkiIi+FtmMTBa96a?=
 =?us-ascii?Q?1hPKW6MS8iARiOJGBXPzwC55P3i+KfVb89Nz5ocGSSIrtf6Dafdqx65feITp?=
 =?us-ascii?Q?eGisikZEypt7X5Vc+nH684NnOEHWz61nVkiDW0A1eL0vjqnE6DUt1AXthe8Y?=
 =?us-ascii?Q?KKw0fbZpHKfZH9Dz2h9NodvDUaGcDuXM+ZWMp10OIw+sKFf5CF5i6MsRpxXM?=
 =?us-ascii?Q?50t4BR3KN5y3cRWG8NI7i2KX9jejNNrVi0kCcGf/0a7acrynKQFryQIZVdEf?=
 =?us-ascii?Q?dS2vhIip4yK7VfNbHAjo07ei/lpl1PBzGPI9WYBv7a2A66g0oQ2kZyQB4oKc?=
 =?us-ascii?Q?XR7JW97sE+DSkIlRYPJQjFurM/luwTBAGsGzdrJsQYAQrkJcjiFFNfbwQGW7?=
 =?us-ascii?Q?n4XImItF/zNrlMc/fA2wy7+pCfX6vMpjAvbBlnCiRArhZDj4hWk5eBJZLk7P?=
 =?us-ascii?Q?UW15A9rdOj1pbMvj6EezIVS6okTwR3kGYQukjDpB4n1wSLQuxtylWz7pTDPJ?=
 =?us-ascii?Q?dXlW5X8BDYfPdEbSNQrNbtXplhokWHXmxhySNWPOvrdRkL7RCv9zcH/pUSdl?=
 =?us-ascii?Q?CyTx3aDApRRW827qSdt/AdI5UgAfl39onIa29LmbPPHw7AEb9CvLLG1NF4zS?=
 =?us-ascii?Q?Sz+RGmnmVxlbaINPzc8hmoVlHCpxkopo8Zf2DVsCSacStqxcyElo2dsmGplU?=
 =?us-ascii?Q?ZD+sStOpJbkTIolSGkwTKN43K6fOSAfTGb4CWDiV6SO4Ag+5YIB+Cz1k/hRN?=
 =?us-ascii?Q?k2v6yOHIL8sJmO863/UzkpuK/aVWNt7vXlE8rY2DqfRHDAwtl+rEa4XxJi1l?=
 =?us-ascii?Q?Nx1LZyi0yApj4XFmASqsuUF328oTjrDPwoxv3EhGl/mNZtwb/Kt07Mc5R+rk?=
 =?us-ascii?Q?o1MExcSGAx9U/e3kHQY11DpIKEno+BFWemOl4UWSD68A2jtWPkzcauf9c4jw?=
 =?us-ascii?Q?LltdOW258jq2UKKHx3Sg99bvOlF1VtI4CE5MnqKhFhUibTnMBLqucS5Vbj2/?=
 =?us-ascii?Q?fsCelxN7polFoAzKMfiYcdW+9PCgmI+VSTOwEQC3SJbplJBePcL45hXE7PgD?=
 =?us-ascii?Q?w3P5e9oZdO4iisKqSVHOeknayUJd+eZvy+g0GWK82vlMzf0ar11jjGzStUyo?=
 =?us-ascii?Q?z82ptbqdN4xs96OpPI9dBmT/IG0UaS5QT+Kz5LxKOlNrtA4fYPjywTN93jss?=
 =?us-ascii?Q?IXdQIPTOxQKadgi+Zq+zlvkHofZ+XdnITsO+L6qMNiw5PK71fPXvMgYFOk2G?=
 =?us-ascii?Q?J93h82Vv72UGaF6NpIt+hgq9IdiThNes+EAH1VZ3XmANv4GSnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CDHvnS6inSgqIiKEkVrfjWwindJpDhK23xB8rf+PP1J3wSvv/p2g8chtXqHb?=
 =?us-ascii?Q?wjMA2iy6tgDyqpWeNiRByc4wmRNqYAUND4Pq34UUaeKxr9Sxq2fY+DD5YCNL?=
 =?us-ascii?Q?x0bAnIF0tLDzz6vuvBojVB9ldB4Ijeu7b2mqCOa5WTICY9pBl3+Bvjn48XNA?=
 =?us-ascii?Q?U3lsBheR+/Xk1eGcPL2PwcdJ5ResisTJg0Qe80JlaCAteTBootdW5tj562gd?=
 =?us-ascii?Q?BeOfiw66P0sI/ZUvQ+9MYEzppqlmTxUzavALN7RXb3gkSDozk3z0U9Tq0SSV?=
 =?us-ascii?Q?aRzhuK0AY6v1xFmrlU7Zoyk8t5PZ7YJo0FgfTYyhtWoL1EmCvbzmOn4cDkJX?=
 =?us-ascii?Q?KTdi1Wx3921dUxrYfxYTT+j5xagy6Ua6hg/nAvRQrSNKAiROqZ7p5P4o3GNZ?=
 =?us-ascii?Q?vFawjPj7LWyCjykLVjyc1A0QxjAf5GX9vGBgcvPH8y72dNyy952aZt3A9D8K?=
 =?us-ascii?Q?/YWOwC4eaXtMwDW63QVzqr88jo0d+BZWpz7j0U9wPnDCanZLXQZjEZoVintH?=
 =?us-ascii?Q?XCS8kstk92oQ0K8p4O12WEnHo/TY2eXNw4SDCnwQwTS82LE4DlpTaWItVQDW?=
 =?us-ascii?Q?cVEfP1I/MX8UAZbZthfWBtZ1a/GMRLWP/rBevEHXEmJFEriK9IyyhmDza+Di?=
 =?us-ascii?Q?A8KdZfE5+OzKM6pZPS/SeQqJFGwVnl7Z2vvj6za2dODO5zVXybhujL1hSksL?=
 =?us-ascii?Q?OAJnb1Z4yXyivdyTisHzwB0fw6+e8mgICPFBv890UkTplFWJt6ZStR4m7Xcy?=
 =?us-ascii?Q?GjNG2AnBoGLawUWuhRdrlbwsifITlua/P60osvrY4X4mAJi0lhuLaq0Ib8lr?=
 =?us-ascii?Q?Km9VdxBR28fmGHUXTSjBNXb4NoA7XPKj9iRdqCNhAiYwcga3IgTPqC0NrdaQ?=
 =?us-ascii?Q?ksHvEx1ftr+L0KtD5lggwarH2j34XdVR38tKraVph5Hp0pAD+lLZYNJLFFB7?=
 =?us-ascii?Q?BAPYyOccusVe7GFNn3+5DosIR1tX60StgevTD6mXVhaOXzAwZrdZUHtXIUCJ?=
 =?us-ascii?Q?bQL119oxN7rGdUFxtPLDS4pT2eLGhEnJYTqCwG+5UDX9zXQ3S7n1M8w9UwH2?=
 =?us-ascii?Q?SnaPOvq49X2a22JTv452rcZ5BCCnAxxjFvj1VPM3/SCqfKKLDrsZUp41LaA4?=
 =?us-ascii?Q?/stR36cpST1tHjOdZ2PlBE0jf0V4CskYkdpXhGHVH7GdjwsqldZYshpHDicK?=
 =?us-ascii?Q?CnkK522d9261U9EV0HYAlTWaNyZUwX/wm+Er3Bai+sU+wr900Y56UWztE7Or?=
 =?us-ascii?Q?NZOsNDNrq/66OcM60BohaNbqavANZclerS9uQYCOvqEZMoH80FMXfsFw7yoS?=
 =?us-ascii?Q?ogMfvy5uAw6UHyUjA8T1i1ZkW26qeY2lhKmh5yPdFt1zeLArgxwZNFRiTegX?=
 =?us-ascii?Q?nYy+AyMVn4N1+gKuOJ1hsiJg8y5SWaQFmgjQOzC2z+goYJrt+jLYdOznlSOh?=
 =?us-ascii?Q?jtVWniNn4RSWQsJOWbunaTsvwPHRjrNNB+ogG3BXBzYB/Gfzu+j7xNO6BV3D?=
 =?us-ascii?Q?ZmV6VJ143bh0wOr04BKYaMmnLSG11I23vNe0w8xoMnLDNDcIxd+6jnGO0FUr?=
 =?us-ascii?Q?ild5C/kh6kNSBDVYZiv9+qwsD1g68fN3bMcE40QFULuvuLD1Dg+KbFzKO9hi?=
 =?us-ascii?Q?DCCTLQQiXA8bcr0+VbAhwnI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa7ff68-7d43-4994-aef4-08dd0df871d2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 08:58:07.3034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hwbCM6zqsWfqAXWnAMWjLaolP1eKV2A4T3/7vnLnYF87TO1sZxK3BI00zkG1XEDGlS46TIg4ZltML2K6cNMLk5/p40djHXAxLrnrLIBJMQd+33RRTLjpdjSyiSdqgBE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7688

The rodata=noalias is the original rodata=on.

The rodata=noalias can provide us more block mappings and contiguous hits
to map the linear region which minimize the TLB footprint. And the
linear aliases of pages belonging to read-only mappings in vmalloc
region are also marked as read-only.

Also update kernel-parameters.txt for it:
   change "full" to "noalias"

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 arch/arm64/include/asm/setup.h                  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index dc663c0ca670..54b4df42e631 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5894,7 +5894,7 @@
 	rodata=		[KNL,EARLY]
 		on	Mark read-only kernel memory as read-only (default).
 		off	Leave read-only kernel memory writable for debugging.
-		full	Mark read-only kernel memory and aliases as read-only
+		noalias	Use more block mappings,may have better performance.
 		        [arm64]
 
 	rockchip.usb_uart
diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
index 5ded3bd11476..3d96dde4d214 100644
--- a/arch/arm64/include/asm/setup.h
+++ b/arch/arm64/include/asm/setup.h
@@ -31,7 +31,7 @@ static inline bool arch_parse_debug_rodata(char *arg)
 		return true;
 	}
 
-	if (!strcmp(arg, "full")) {
+	if (!strcmp(arg, "noalias")) {
 		rodata_enabled = true;
 		rodata_full = false;
 		return true;
-- 
2.40.1



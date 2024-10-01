Return-Path: <linux-kernel+bounces-346344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B731D98C35D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EDE7281220
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E54F1C9EA6;
	Tue,  1 Oct 2024 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z+hbN+t0"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011040.outbound.protection.outlook.com [52.101.70.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCF519005D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799984; cv=fail; b=blcVf2Dm5I0JvEwnBBTCyKvqpbnm0hJDUWgSAaNPzwqo93+FZbKXLzZTr3/2QytEHio+pZbpKHlp8Vb7zytMMfwbWKke0et+jrSmkXRJRWpU+2MupeBLgCt1ga9QaDGWyjxRNAJot8JyNeVjBS24M1JvUR2AsfyQNGrDnlmg2z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799984; c=relaxed/simple;
	bh=4CZCHwx4DBObQP7TCeNi/xDhW5u+XeEjN5ZEjzyuIwg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=A9Zg8zRdD+DbT2OPZn6Op0+VkYOj8jrJ5qR5NWXCkNXrcLWfywWK1lttKgabdsctTxCmXny3CcVnUDcbHOO3aczgFJ8cTVqcMWzCtI6w/01r38HHJ3oLCMWj0YZddT9RnK+rvA1suxzTv7xou8nPne86Wp5DKbhG5zsOPzDHfzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z+hbN+t0; arc=fail smtp.client-ip=52.101.70.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFu8T7hCLUyJEok+O7Aw7DNhcSYS9LZRLWZAx1qsLDZSrxHB7WAfDbJ8oER2DcVEJ4UnJZ4gOTTrugAC9lom5+GYi+L0Yk73BkSIcBqtgq5hxLbrO7JPUi0WYVkoVJPSj8ijauFzy127CUdPQtuyjG5YiIZ0/gpXYPkjKO6V4ZFjfGCrdcAqRdCIcRjUGkCgKYMRXgveX/YYth9QtkoyVV3cTiE+h1xO2ILZvVl4nKEB4gQ73eDp8OJVwWDgnSCjtadpY6+l/HyUVIqqk3nQ2vATIXqXdLaoTmXen03+Ncql0E5o2uv93cdle/QibPBQZmegQvLMZ0oapopBZMWfzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zOhi1i9xNtOysc9UcYMjdQsx+v5iz322y/GzD9a8xM=;
 b=RW8iMikkVLsob9feB6NVyjlQ+aGzZ0Cv0LMMleFh3MSeRdQcCd2klAdkSutn2QP4wDsl1Y3PKj3fvWuXuCYranL0ysNMl2nksNg+35D+FXKZ9pb9hN5Qhp4326R80U05oEF3aewpu0xQ7YvziCylYcZNwBXbC6OiemHQw5fRhX27DIvrjpo+rpm3xRUfJKWXuS5LaRdpmctlPKUd9gjVdmh9iejE1ZWA5n2VDOubtCqROI6dDZB2rtp6ivM7lj1d3pgB/gShGZP3unW5AeywmzH9FYWmQxEOmNM/J2i7Iglsxw/B0o1ruXIKpR6EWkU2PTlf2gnikBVfa2YLfzytAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zOhi1i9xNtOysc9UcYMjdQsx+v5iz322y/GzD9a8xM=;
 b=Z+hbN+t0JBJJ7uDKIIe+yS8GPE3OoHZo/ri9oej080fFv3AB4Dl5dAzwmVh9PwBDq07zHjZsoPUszoHpQWbZZCfuuehfFWgmY2qMaMQItq4Aw775DHLot3xeVr6eb6Bu4VKWqLIMCgoGbPneSdbmgaIynVdS08+6BOnoc3rKn5VuUvimJhpvhTqxOUmYhlxc7ZIDlvXI5ezzTieJLh2jARSY8nOpOQS1Spqt9UOLCM2K7fCvRQpZGj0gv+X9/BhRz/OR+lf/yJhBPCZr3uoojKM5CJ0bbI8GWkKN4e8yZPmaBLqSIxu8aJCCYgWb/ef8M/D1qG5he1dBvpkbQK++Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9432.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 16:26:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 16:26:19 +0000
From: Frank Li <Frank.Li@nxp.com>
To: miquel.raynal@bootlin.com
Cc: Frank.li@nxp.com,
	alexandre.belloni@bootlin.com,
	arnd@arndb.de,
	bbrezillon@kernel.org,
	boris.brezillon@collabora.com,
	conor.culhane@silvaco.com,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	pthombar@cadence.com,
	ravindra.yashvant.shinde@nxp.com,
	stable@kernel.org
Subject: [PATCH v5 1/1] i3c: master: Fix miss free init_dyn_addr at i3c_master_put_i3c_addrs()
Date: Tue,  1 Oct 2024 12:26:08 -0400
Message-Id: <20241001162608.224039-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0130.namprd11.prod.outlook.com
 (2603:10b6:806:131::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9432:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b282b4e-a4b4-4e1d-d4dd-08dce235c7ea
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?5V17XrMmQD0QsAHv8smMIkHPahd5xy+RKd7c6xGwNzbIM5biPEdgpMELfZk7?=
 =?us-ascii?Q?Rte/iiFzpuGUjgf9xRjOT5A+Ad82aCiEvtuvvA8ZRBw7ShW7zqJ+pduMReLr?=
 =?us-ascii?Q?sPzfF2bCN/ViZOden1fLslzNJRdR9wqR9AxEB00gEmZnBK7vEB60QHhg06J1?=
 =?us-ascii?Q?fyiERYUM6ZioOcx2P0T7d/VqwdQ5Dy7L786fYqXwQyYCp/tSnKiSfXdeXHPA?=
 =?us-ascii?Q?6d+Gk1sKBgdztGJ7/5lS+I/mOOZiQ79ZUg6JC9Y4NEyKoTTDo0nNX7vsm177?=
 =?us-ascii?Q?7plXbVteIOZSf9S1c4j9xm4uq4RrDkYqU0/C58KTk67n7o+Vu3XtJC4jFigl?=
 =?us-ascii?Q?Pa9duR+tr6OLaJ7i8IHB4ykIfPDEEeJAsuPMoYuD7kJAjgaM1sf1NQAtcDow?=
 =?us-ascii?Q?iHMsfvXsciFlx8vZ6uWuWYsUiyB2IGekJkL1mxs0HRfOt/fRnjBr11UWIlpm?=
 =?us-ascii?Q?UXuo2LKvvZrX5EdeAvZ6rD+qLu1puRH2Yiy2VXzhlJaltJNZFwTRRyxQOuAj?=
 =?us-ascii?Q?sniJRnfQz6H8P1T8W3tplZWN5tVeioa0rMFbnLeF4Bq5HlT+lgXjEQj5dhyh?=
 =?us-ascii?Q?UkkmXXc3YSN/NmxR8YyFKANWkVMwEU1eGGn5c8LBvuKP3uRn1aWC9wCIeJ3c?=
 =?us-ascii?Q?FoRro0Nn0H0UX669wx5n+iNGHjzzePOSeOkA2DQLi/ACUi4PmW5y8CVlVG+2?=
 =?us-ascii?Q?Id8CyabY3lTAav3pQv6z2uQpxDkcvgRLfdrVuPKlzD1rpQKrWyh2fEB80hrq?=
 =?us-ascii?Q?X6rJn/36+8Q78xByq+LY4mttJ3SN8xJ/o3H1wrsVo8ZhEik1/U8P/momxnnA?=
 =?us-ascii?Q?RqF2DowJSQ47cSNduzb0SAvHA0vbujTedN5y4KSFjEqHZuXRKKWyDkBRpHMW?=
 =?us-ascii?Q?fyxUUuH8MdwJS3Mz515BIQ/98ml2KLQFXNybxBeWrpvQqkfANayqfVmuYqKC?=
 =?us-ascii?Q?1XP7M/LGAMtAVHIunAl1ari6xX+fGO7mRAxQFlP6D0Qehlc8/0mI8lXBQuum?=
 =?us-ascii?Q?2AolyZm+PnmccaxOcCGj41eyA849YsMzgk23eEM2RtTAmqnSflvHVMZKGcBh?=
 =?us-ascii?Q?CJ15CbD3yrtWqv3JI17ByiBHqhSYMf16/NTnYB673kTdjM2Grq+RV+Cp69Sy?=
 =?us-ascii?Q?jTnF2IKzaxnMYX7vORdXeVhJsXE5/+uucKgiXW7yXSpGTvq9F3K1ImE1F/KD?=
 =?us-ascii?Q?5PcR+gcThRVIkoyZKtS9dr3IqNip82DfNdrj4MFLfesGCu01vLFbbVsZqs3w?=
 =?us-ascii?Q?GksIBd3fFuQFR577QD8WIoNCLapol6gn0HHT7rp6INpj4+7yz2OiCtHY/zqo?=
 =?us-ascii?Q?K9U5m2W1cxLm3ALn76p/HHDvrAlqrinBjH9r/NgOkUoYTQ=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?vmr4NuY9HuBp2KfDOOZ2uNp3ry+Evqu3lEFD8G4YvWl9DYj9wEiibQ9KGKRz?=
 =?us-ascii?Q?SPbC10MwO6OrbF0YiIPM5hEAe6wgVV++KfgsrpYAVSy9PsLtgGqu5qfntnaq?=
 =?us-ascii?Q?JJHVUkp1Y9/V+yPgLxpvv7JS9+Q/MDILVkLbKndWRPLPOKbU9VxnTPNIPact?=
 =?us-ascii?Q?p27D2tmUIGQKcXDRICjLtPBnatg8l2V8ngo4pNYbgZa3Ub+QtvIJErxW2eXS?=
 =?us-ascii?Q?8IKnsPVSksn+MtodJKQcC2/g0w17tIAUhxfHRXxCxlqilh03aZCRlngPRMPQ?=
 =?us-ascii?Q?CjQ8ZUYt+eZ1SBf7EAvb5VRyFaoI6QlbOfogZ9TITo+JI3IxbKG+CzP2TSLu?=
 =?us-ascii?Q?lBnILSxQunPzxrXX59UH3pPTqHf/bmDxrZmZuZtMSP05eizGyKdXVlaev3v+?=
 =?us-ascii?Q?1o6mksmlkVejP4c5R2csddU5VLLonPgnNMIOeQMHUqL0Ye4RXjPTF1TMmSrl?=
 =?us-ascii?Q?0GEAn1IRX1uG46r3+R57ga7x6AmAbW4rlXMLSiygLaEOn/f7iieG5A2vFkbt?=
 =?us-ascii?Q?p/ovtYMFSELRZTDnUpVx4hP94vH/EZJxghB+tG2uLJntCd+ZaEH98jeqF5Nc?=
 =?us-ascii?Q?2zL4S3CkFHJhYRlC5nG35VpECXK1rEj8Xqev6i9uPaGxfoMXfl1XozZX1lTS?=
 =?us-ascii?Q?xxXeeiw8Qr/4QM3p/64sZlXdoZn832QCt41SaKGy8Y9/lbA8KxrqilxSYsqd?=
 =?us-ascii?Q?L6pssBAmRHcFDFyvbCAQB+R/7u/tri2t/B65GirtKV+GlhlbWBfZ3Kuv8Hj2?=
 =?us-ascii?Q?yvckCpRQN9ytpl2SMTkke/KsmmPlA57TWC0KRbGavxOcNopKdTdHAsyS4pR1?=
 =?us-ascii?Q?zcsI8QF6UtWreF+Z5e3N8oWEH05FspWz2SBPRAIF0a0O+iGfxFU6afeMBkv+?=
 =?us-ascii?Q?JwiOvD5YCngS9VVzmn8DhGUq3yFh07ZnIjuGPdgDBfD9mG8x91C6YMr/VGIE?=
 =?us-ascii?Q?6vMcl6J39Xfl5Z3m+Jt/KCQ6zzMP6U9MhlVgCXpBKTxpXC30+fWBAnW+ntiW?=
 =?us-ascii?Q?TuE67AujN2ndXfIzJV7mWQpWo9WFZeHnveUzF1DXbKYjKKo6v+9jtVBJWiT8?=
 =?us-ascii?Q?GxQOgdGgz3PtH4IdFPH0g9VHhZxHgcAOJQTs/Kd1+a6fbMXfPOzUpBgsjU00?=
 =?us-ascii?Q?Cu5Tf4HndUZQeOriNISA1vdu+VNtmMY0pdLguMHnqlAzp+ZHzI6lDKVJCCWl?=
 =?us-ascii?Q?iNW3exi6666hmseq7KABZsjttV2bhNZ2f1O8BAnt9ViVEbXjRIHhNHowXi/W?=
 =?us-ascii?Q?+ftLr/kqU77kfxDkqnX2G8kP9WRdBJ3cvJMpcPHaJxs2sZivTQQ+mvUZ3TsU?=
 =?us-ascii?Q?c4O2Pbyuk4eZFVvFXYJouroTsnumNG6Hk9Lw3sGxumHvnAxlb9hEo/vpLUNJ?=
 =?us-ascii?Q?p6h0IIb98PR7bu3mDi65MOGLjbz03E5KElYf20XeTdLEFLCLgX9e2iNMRoua?=
 =?us-ascii?Q?1mkeu1g9qdvqPqXHTYvLsBmu+YxIT3EHMhulHlM0lrx/4J8rezavLTQVIz5l?=
 =?us-ascii?Q?XIjDjwDZNd1uHViaQzvkDu3mfoWN8QX6XO2ZEK+nceDWem1IDf2VHuMcdIEE?=
 =?us-ascii?Q?2KXMl03IVetZy25y2qY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b282b4e-a4b4-4e1d-d4dd-08dce235c7ea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 16:26:19.7309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUeov5qVmgU9dtTbMg3L7wSNbnIhGMiXfURyS7rVvX4DEOY9oi0RKUZrZLFT+NLLhacUNXLMbGHUkGgDGUsKCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9432

if (dev->boardinfo && dev->boardinfo->init_dyn_addr)
                                      ^^^ here check "init_dyn_addr"
	i3c_bus_set_addr_slot_status(&master->bus, dev->info.dyn_addr, ...)
						             ^^^^
							free "dyn_addr"
Fix copy/paste error "dyn_addr" by replacing it with "init_dyn_addr".

Cc: stable@kernel.org
Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v4 to v5
- none
- just split from big series
https://lore.kernel.org/linux-i3c/20240829-i3c_fix-v4-0-ebcbd5efceba@nxp.com/
that needs more discussion about dt assign-address.

change from v3 to v4
- mention copy/paste error
- Add Miquel's review tag
---
 drivers/i3c/master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 82f031928e413..402a71313985f 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1417,7 +1417,7 @@ static void i3c_master_put_i3c_addrs(struct i3c_dev_desc *dev)
 					     I3C_ADDR_SLOT_FREE);
 
 	if (dev->boardinfo && dev->boardinfo->init_dyn_addr)
-		i3c_bus_set_addr_slot_status(&master->bus, dev->info.dyn_addr,
+		i3c_bus_set_addr_slot_status(&master->bus, dev->boardinfo->init_dyn_addr,
 					     I3C_ADDR_SLOT_FREE);
 }
 
-- 
2.34.1



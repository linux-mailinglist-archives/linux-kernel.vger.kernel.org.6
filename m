Return-Path: <linux-kernel+bounces-410517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 889709CDCA3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0211F2314E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FE718FDB4;
	Fri, 15 Nov 2024 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="lnrjWCiy"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2137.outbound.protection.outlook.com [40.107.117.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7CA13D51E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731666746; cv=fail; b=iSj5klxjumGg/ovLTIuu1qgVDowi+6z2ZLk8Une41efKUHQR7f08C9v3NXF8dcfqU4m/KB3+t0ssW8GQMpjMG9jjeX2GRFU+BZTEs+B54cj/P8MboOOFoN62tEwFMrq7NgA+FgoChMjvciW7JyJE+Qx0xwa2Bat/BDVRnR+B14E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731666746; c=relaxed/simple;
	bh=cL3D2zOIv0y804apKnc9pBHjvOwatmu4kTLOQzZ6lTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=r0XSXJVpjEhLvI29ne2BILWA4n7IRzZ0lL/jGGe0CcihI2cj/F5r38acheGZac44KlfpFvRf45gc8sSpt6qEsVP7dvv4sBXmVmwKteXYw4w5r9d785DYOlPu//EWIsD2cSkPo+do7LLT0VaIQMZJSR3kOyFFsFBAb4l/M47hYBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=lnrjWCiy; arc=fail smtp.client-ip=40.107.117.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfJwcEh3Pbk65Sh8E0X9dFZdiLQN4acFxBMqNNYarx2V81++p2az1nOvojTgNLtBelFdbWE3csfwx0ivTCObZIG+bKY9XtAqBUkLy3kDQLmWLSiOwYGpKXLWmakrWp0qxqeJfaotH2NQG/ao1CyczqT88KjamvDJdcm/6hzXy75pb2BtrCW8TRbuFjDwEqrbYddSwvayHXiU4VaYMvp09bmn76mqRoo/P5Hs9VmA7rfHYy+MrnwZgBQujDugLu5p7kkMr/FoueDD08aOBkCQYDn978sn4zXmu8fXbe9vg/El9dKFzmeTRudFK75hBm7yFptMhsZ6Kgz/pkBlXGD7Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDXFqDETVYtkYJozDJgSGlh+QWd2m77AwYBhwbQf9YI=;
 b=FsuzNQo84wPiJuis4fMNsOvCAiYJx82J+dM8ejxcl5nQCowGqgWyDM4ePdtJW95No1lDzPwFnZ9uFGVL3KKo9GeNaNqF1XFBDvDEMduEI3bCdx1qmCJvC/9Q4mqP0mz0s1SgfniqE12x54TNlhZUYSIS9fZa0tsx7W16HGcP7uNpiEUNnblXOFotxCGqiLw1N6gWmBvP7NZsClDmKioEka44qeS287soTD450YfiEGmww5MJaZ2d+ccgHk8IiBivTa5zRwpNZTI9znpglsCvZcMHef0tjvBJMCI7dL0g55gDKQO8Rkx4KXnjzcftqrdnN2Ne9xh+MUozoFeLbQGAfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDXFqDETVYtkYJozDJgSGlh+QWd2m77AwYBhwbQf9YI=;
 b=lnrjWCiyMADzLD+bOwQjd/QiUd2zvPuiAgVpkVpeylsN76VHiNcX4HeqRkeqCueQ9cH99nYcrf2Nwa2/BYvE5Q8NUOcQHzZ3lITjg4a9kHTj5tNJhS2WgEGRv7Zj74JksMdy1DoSK4enPBH78B2mg0s9s9IYnw8JXHUETYvajNfdhqzcuGvC1rwagM9c32y0kFCftCgh0kYn1ORPmPzXfEnoFX7k9h3vC6215wjo5Ev1Rr6JWwCbamyg+8Zw6f/BGp5qQomcIUcl9pCE6B3JvOhhma5Pq5X+fFZUjhMiVDU+39EC8f8axdgUvYAvrbPKQYe1GTO7s25vqTtVV/bqNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by SEZPR06MB6015.apcprd06.prod.outlook.com
 (2603:1096:101:f0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17; Fri, 15 Nov
 2024 10:32:16 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82%4]) with mapi id 15.20.8137.018; Fri, 15 Nov 2024
 10:32:14 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	angus.chen@jaguarmicro.com,
	lege.wang@jaguarmicro.com,
	foryun.ma@jaguarmicro.com,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: [PATCH] nvme-rdma: add IB_SEND_SIGNALED in wr.send_flags
Date: Fri, 15 Nov 2024 18:31:49 +0800
Message-Id: <20241115103149.2312-1-rex.nie@jaguarmicro.com>
X-Mailer: git-send-email 2.39.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0146.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::26) To KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5773:EE_|SEZPR06MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f68ae3-b3df-4abb-591b-08dd0560c508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VU/eXJj6e21f33rFNmiX+hGiUc/4ZAH1DZ3iW1TW+LmmCpbEeNp/quDeRJaW?=
 =?us-ascii?Q?E8PA+MInWm6EAbF01hqVwoyFn3UNKn7WnuAF5Njjb2pIJEj8qGuKFElOLCzW?=
 =?us-ascii?Q?nV5vcd4bTBMsE4aIVQ1aBrJEqdkitAsPBO1cy/RL7C0kcy7UTmbtIYpmgucg?=
 =?us-ascii?Q?mXyeM+GWDAUrTiKl2Ev6NJHD+OEx/gTj7yg/fMY8/VK1KehCZvQ4p/2/anNm?=
 =?us-ascii?Q?5GHQvsKDX1sIHYnpJZYVRb6mTrqXsuE1SWFiCQ4l5TiOZmpt3PHpIQjDZwz4?=
 =?us-ascii?Q?MXB3ScvUDsI9T+Kaq52Anoa3s/obGUKMZ9kvZpcNO53JzX4kI7D1ItKPvSYj?=
 =?us-ascii?Q?N1D3vFLv/pYRdmsif0UJO3VgMpZ4ei2m5D9kJ+k321dHdoOAm5oDPUSPSBoO?=
 =?us-ascii?Q?0TbbKQ1rWH+pO/fQ8tjqcxIkoR+tTlnc5U+WGK6FxfIOWcTv573mgBjgE8B4?=
 =?us-ascii?Q?0RS3aG40b4L09VFZJR5E0QvjZ/M7vpFHRogSxPUbrNAuF+JGCuYHhVwYVxwP?=
 =?us-ascii?Q?ooIioXU34vQTDDqYfC4BsBilV4sOGCrZaD/Pg4Cu9jKDZH6GvEykuyQLe5Ko?=
 =?us-ascii?Q?nQbaRpKak8VRGwQlrQGFst7EKMGv7pnNgbh8vhxlAMWt2WbkQibDNyBRsD0H?=
 =?us-ascii?Q?/bJ29PQODgmpafBOOTwN+PHuxRY2EMbFOmzei4XfLC4B4v/KwgxxKCnCbmFc?=
 =?us-ascii?Q?QxAZj6Rc9bnEdRb5cgpAG6uRz7kEUgj+g5/sCT3GRUraieX9Hh/He1Rblx+h?=
 =?us-ascii?Q?LQ/Bf1iYKJooW6wdIvFVKpJ1DpT96QoPamvoU8OgvLavKKg0ophFiD1CgunH?=
 =?us-ascii?Q?SgflJDOlu5LFwUXttAUar5tfj1bRoN6tAY9Dz0DgWdyu3R61ywsNMWkjFn9Y?=
 =?us-ascii?Q?8kKNmYwm51ZX69a+Gqq/Y623OjrV5WizFmuc+0CgXqWpR5dkvLKPT5ts3KZv?=
 =?us-ascii?Q?Dd/dgJxLyKbGIr1dRXZGj3Lw9yWwgUq+XqsDAlXyWe7d1gB1E+9Juk3ygyVq?=
 =?us-ascii?Q?ehNFmCtGdG5m4XHykMthYzthCozlWODJg3w40W11mJSZWjs2HbgH5/3KOENp?=
 =?us-ascii?Q?OemQoXJTIniA4FgqB2ETAr+5WUA8x3nvpdeb0KjrFwqGRAGXcGgFgtiCpn8X?=
 =?us-ascii?Q?KdQ5PzTO3EqBK5i3j1lgsoJrIfiaZAneHPCD4RzmJanBgOraRFF7Fl6jx7h0?=
 =?us-ascii?Q?gkB7MEBe4L3mDX7hrEcszJ51Ilm+1fVpLzbvVrEdoDplrJegEmZI5x0qHG4x?=
 =?us-ascii?Q?58nt+ZH6A1B4hm6yxOE6sCLqAp53T3ZMyAbY7sMdm9UoNy+zU4/+JAbz3UGj?=
 =?us-ascii?Q?D2hACNR5g+UNaOGZRev49o9ZpHEOSaDAhaTRKsJhQFNTGnAeDzxe+yfTbGcG?=
 =?us-ascii?Q?eHn9KUM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zxmoq/pGUdjHtxwSSWma7pp2BUx7GYOOcfCQBySvl/t5MuUKkFkrPv919KMz?=
 =?us-ascii?Q?o1m1RNLWpZjbUDTsJGdyW0CUk2LruPJ9lduSEJ7TtChj3DnZibkW5Lk+ctKY?=
 =?us-ascii?Q?2OJ56tyzKWQyTuHPK/IeEm4jsjC4vdcPvuMaZ9fkpQ5BMTxQtdzkyGQTtZZ4?=
 =?us-ascii?Q?VUfJd6SKwu8Q/cgmFqok9kkqUQfyU/HzW6nesVaiXdROHCt26LQPHlqaCR8I?=
 =?us-ascii?Q?mN4lIDbXgQ4ji7cHXSi6bcFgKPwCJb+Mu/i/cd1EuAodxaduHvjjsShBx9Y6?=
 =?us-ascii?Q?+04bbv4H72pkRku7O2ESHJZ3XpNkA98ef6H5rw2RUM64Ny1pbRloS6jl4NKa?=
 =?us-ascii?Q?eFl3uRfP01HwnjN8lQMUlwJDSLaT41o0L3bwsod38Fmpe+ZMymhGMeG2suBt?=
 =?us-ascii?Q?W/d6dH15u7Q/hkxHGnGHmts2rqyWACciduN8aerj0NwU0jNpVRlca0B6Ot4Z?=
 =?us-ascii?Q?JhSEVUMXIt8syuJKy9+YpGwWtqcBh+Ys2vEvOpdlHqElx1t+M2FrAlFqFsCV?=
 =?us-ascii?Q?7zvNfMRpwjmrXoijJLfYbqdwG0UjHx2TYl1xedsczJ2wqjjfVul7ncAv8Q1r?=
 =?us-ascii?Q?OI4oylyJnaZt1ce2szgmyk311KX+uym3SFZpMckokRzhGBMSrYz/MO0mdMMN?=
 =?us-ascii?Q?QPMv3J99FmRauRIhCJ1qnnfjeZdC7keA/FOZkO9zEMeHHlfiHwrW2WRD45MX?=
 =?us-ascii?Q?HpHOVeVCk86HY/i29mfkxqQ72Sh+Zf5iJFYExCoUGOWKkF9/tzLLpkNtAvOT?=
 =?us-ascii?Q?equKxkOoU9XP3aPBqjmRuOwRNh9qXoQgQ/Qny0hn16q9Lz6cHwB2PTa6tTMT?=
 =?us-ascii?Q?ykb8xhVSFFMGdjgEe9jmtHMSIg8PHXFQyPdWjrDT7hT+okw9lLE9G7joSmSZ?=
 =?us-ascii?Q?473aXG02Sz79dzt5cyBUm86RRF0f7OVmdF0ZeiaqKkrzGcJAq3hPqmoYOfvv?=
 =?us-ascii?Q?pURqobnsEvd31YJg2Kt71h1dWMJEot4/+E3prH2pf9f9uqhDvPjNlrNTIUb8?=
 =?us-ascii?Q?zp7f7sYMAPIZuYUK4sPl+6/vmjxW5f1zUB5MNnn8BTe6hHNNRCcaND4Fr3DX?=
 =?us-ascii?Q?H2ev66yxd509ttlljrmP+erizMtbXrWAG8aB6n1eLIY3D0CTV9AQCKSj44O1?=
 =?us-ascii?Q?DvvC/NOL78e8JOu8jmj6N2YaSL9UiTKIs86l/4rxrRrBuXzN05avXPDtWAPP?=
 =?us-ascii?Q?0dmY8B3iGZhp4mJZajKoSLbfkgKoBZcI4SrzLKP/Ws++vOmaDlEITdF+KVuI?=
 =?us-ascii?Q?X10QRQHK8icpsXBXuSMq4tbi7SmqJ6W1tU5+B3nVklB1EsK9M1JmZcy4CeO1?=
 =?us-ascii?Q?1d3HXl9YFU0IlilymNn7CfiY1dWcczppgnEQNkTZXv3b1BuUpCyJqxxZw9JA?=
 =?us-ascii?Q?LkVZAYv6xXbHZRxzcmWEWlIV5gCWcQeJbitYaIdRnB8HDzhZgrzmOvRsG3po?=
 =?us-ascii?Q?CB6/Yp5HAN4gNYVxURFmUZRxMJZcKhaFYrfXg4aap6kpGInDBsjajCK0YYZN?=
 =?us-ascii?Q?daevbiTI2rqOvaoszvdD0+U6xepbQ9yzfw9YKl9YLSizAFey/Js+6HMKquKo?=
 =?us-ascii?Q?Bgy9Il6ab4bauoD7RTEtLF7szijN8buhdhqFmYLo?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f68ae3-b3df-4abb-591b-08dd0560c508
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5773.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 10:32:13.9241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSQYLeXX8RXwkId+PfA3KHd/jNIu7BlJH5Z4ls81iAEhCCB4QhklyOzcTjacWvVFfHG5tIaMlFYVRCVduTo9Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6015

Since reg_cqe.done is assigned(to nvme_rdma_memreg_done/nvme_rdma_sig_done
here), it means done callback need be called when work complete. The done
callback will only be called if IB_SEND_SIGNALED is set in wr.send_flags.

Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
---
 drivers/nvme/host/rdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 24a2759798d0..d25ee7ffca45 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1337,6 +1337,7 @@ static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
 	req->reg_wr.wr.opcode = IB_WR_REG_MR;
 	req->reg_wr.wr.wr_cqe = &req->reg_cqe;
 	req->reg_wr.wr.num_sge = 0;
+	req->reg_wr.wr.send_flags = IB_SEND_SIGNALED;
 	req->reg_wr.mr = req->mr;
 	req->reg_wr.key = req->mr->rkey;
 	req->reg_wr.access = IB_ACCESS_LOCAL_WRITE |
@@ -1443,7 +1444,7 @@ static int nvme_rdma_map_sg_pi(struct nvme_rdma_queue *queue,
 	wr->wr.opcode = IB_WR_REG_MR_INTEGRITY;
 	wr->wr.wr_cqe = &req->reg_cqe;
 	wr->wr.num_sge = 0;
-	wr->wr.send_flags = 0;
+	wr->wr.send_flags = IB_SEND_SIGNALED;
 	wr->mr = req->mr;
 	wr->key = req->mr->rkey;
 	wr->access = IB_ACCESS_LOCAL_WRITE |
-- 
2.17.1



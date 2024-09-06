Return-Path: <linux-kernel+bounces-319399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB7396FC09
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD491C20B55
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C208B1B85C9;
	Fri,  6 Sep 2024 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="dP35iIwF"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022094.outbound.protection.outlook.com [52.101.43.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A421B85F0
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725650168; cv=fail; b=EugWl5QcpHu4KMdZB7jpKUnyZJyQrHZTQL67a+jvTxPhy/CG7fNNR7d7avHd2t70YrZ0hgi0UMqGsHMFliB4Dnc6IqtWrqCcvPK4Kn0ovQss5C5Sy/1+OGS0HTspZg4P7R1tlp3ShPY0UoYXP6Nbsu+xZ06lE8R2jMSGNQi6lrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725650168; c=relaxed/simple;
	bh=uFXzVQZD9/IbeUmmDO8Uu4orUwtcOesfQdrBnILKZMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gnVoYBhImpjEnaVEjZQ1E2ATZaiS3fdGtUxNNWYkL0MXuChGfv2BHSvQ7KdqWACI+0ibkooBeSsWnG34DhO5ZkFejKxp3h7m8kjbILOS7DIzd+33bm/94Nj+2oy4XJ3MfmJCdBi48ebhEvpuyWxh902DYOEji3CEBPafMDjMMeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=dP35iIwF; arc=fail smtp.client-ip=52.101.43.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXu1dCI9HT/Vr32DUOzSrG7Dy/KyWjUk9iL9Uodrxh7qK8G36iXIN1dIfOScpdkBkvjgtBM8Upvow7YJnsjuLCvqP9t8aV41BUwqIEfrhXxWZp/I2Y/IWJ4FV0emF6sT8/Wg6RvkKa9gPfMqlfQ7An/XWIoHII19dzgUzYIErQ6qkYcZZaNfWDPdFO+68HtXea9pbsck+zUbpzXNtsu9ZZCp4athveZfozPORnl2PvUukGWm3opLF/TIXc3lhigUUOcloSXHW/WVTxK95aT0dJzG0OO7ywm1NIx46gcswBwDwsAWmvghM4vbF3uNSRL7OPqV5hhjnY/ZRs6ShlY/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6mCAW33hqgjcgwpBryIP2ae3MxVhnu2w+B9BK9Zpg4=;
 b=jxvrjurX2Io+40GWnKFaqRdOJkYFuEQUgOwA0EK3dG4JLFAkcIm5Xj9YORfBnkD9L6DDDV7lBvHjtKkJ/t94N75fEj0olGgo4hm0jXVcZx92e8iHH93NGsTrUHIdpqCB0bTubL5XvJ6UngCLJjVcEys49rxYy9YXG5X6LarA0EKxHA5+ldVabIrjP7MuJpH1Z+U36/bW84730d7A9/VQPjTCYASofZtiOaWGfC63HRKIrybhbCoxBvah779k0npOJx0P5ncltHZa5fChqiiUO03lf4F/fDJL4CqtAhJx2oFFRfEnVnPBTtL5LX5F1WOurWWb62vaIqsZgprdjTVQpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6mCAW33hqgjcgwpBryIP2ae3MxVhnu2w+B9BK9Zpg4=;
 b=dP35iIwFRFXZuCJnFP5oaKKHqZtPlQx91bBireXeWGG6ztqcVgKxGopD+yghYqApA+8qGZxcphaKRoPyChOpK0xfrI6hgFzWPUULowD+a1fNzoreJcGM3T4ItLOEl3PMGSnAEnihFaitCyqgGu0aSPWZxLPRHmBqal53QZUQlz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 DM8PR01MB7014.prod.exchangelabs.com (2603:10b6:8:17::12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.26; Fri, 6 Sep 2024 19:16:01 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%6]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 19:16:01 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ilkka@os.amperecomputing.com
Subject: [PATCH v2] perf: arm_pmuv3: Use BR_RETIRED for HW branch event if enabled
Date: Fri,  6 Sep 2024 12:15:39 -0700
Message-ID: <20240906191539.4847-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::20) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|DM8PR01MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 481a89a6-572d-4529-73fc-08dccea85814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AXeKqKDiHQNm0uaOfmO2rNVSJdFPe43m5TX869IJimlXcnLBSyw9l+C7mSoK?=
 =?us-ascii?Q?gzuEzu1F+zz8v96GEjE8h8KmgRUC1QRwr+ZW0DnwNW5BFBVSmgriSgm4eXHV?=
 =?us-ascii?Q?BxtOWw98upqdjEp9JHM9gAC34hWN0Nf4+FmA5p/zkaqDipK5lW4Hah8P7a8y?=
 =?us-ascii?Q?D2PvNPPxQByAsrmnw7YZxbUoCb0LSjIxs7uWQSkDWq+C9DbwjP1LLejKIx6U?=
 =?us-ascii?Q?XYjGeNjkkiJwDOehXffdsVnqm3ge88xfhhfiIVxQkr+LlRnzyYrCNpuiN0AR?=
 =?us-ascii?Q?TMAxYUvMZqruRaPFD4ugMc7X+FJxxAMUesGMv5Ok5wYcdRxvwynOVQYeqQJ0?=
 =?us-ascii?Q?kj7WPgE4mZcQ7HsQQKmLvrN2pJyg3mbNrQfYbn5ynFnwBu5ZmIG7ZZRvrkyD?=
 =?us-ascii?Q?dUoK8DmwcDT0i4K/fLpHIXnQbz8Y3tRZ1TQK8XogZno1XAe1Wi+4HiZ/aROk?=
 =?us-ascii?Q?PZsafhC0thLTd7nFGbLqk64twgiwxUxHtFmEvA0K1pc+x2aE6dc2pCB7+bVG?=
 =?us-ascii?Q?gfclsub1bSYVLdBspwwOrAa/wZuZ3v7XFN5rqzcBTBEKR1vSTVmmZQGnHlW3?=
 =?us-ascii?Q?qqdogevf6/SKSbaQuKkz9+UQOP6wrclphzsmgUOcw1BbUU58HJGaspDeMWQA?=
 =?us-ascii?Q?p5hVZjkjPa8//ksWnwi1BYYhFUATmeQTjShDK/R8mQULAFQgGKubXx7of5W4?=
 =?us-ascii?Q?ztjb5eNlzpkxaFIFt0Amt7mVavc+kRHiBA4RueR8LhHJzt7UjrAWBTLgT1Rm?=
 =?us-ascii?Q?Yi4NoEmJbOaPO+XHVFiQes9VN9tZ9MoGajuNfaUqmaPXYbIbi/a5/dCUvsC3?=
 =?us-ascii?Q?iQYiN7RND8nR/+j1TI6cugdYi3PHGsAylVBbCOwkuwF8HuzAJ95B7/CrRFAF?=
 =?us-ascii?Q?2hJfxplRQaVarGSYK5fgLBdRUwlfM+e6+A6/FuOAoJvuMbzeHWMAflz++gcH?=
 =?us-ascii?Q?V7xso5YWnzanXQxj1w0yDI31a9mdEgLElxJlFJFRWrCGH/N+9N76+R9yG5yk?=
 =?us-ascii?Q?X43vHKIbcGpQpwS4U3uP3whbN4Chq+UumGM07Q6fzjgFMCiuoqTRo4iAwZW8?=
 =?us-ascii?Q?ERUEgHh2/dFz/A7+3nnApWClIT00Y5o4J7IHvy6Gf7u3/yqRjNO54ZCwALOW?=
 =?us-ascii?Q?yh6zB3n73JHOOMeWiveVMGEQjWFtt6FaitNZN89MF70toWWZ2dWrjKNPNVCR?=
 =?us-ascii?Q?Se5a7XUujiRnszR1FBnrLdy0Tt/UdvtN8e586SrR6rKxanh14GZc5vKvZVY5?=
 =?us-ascii?Q?/SdXIDqQW+mB7eo3VJvsgxCzKtyrnpEz5oWL2rllNBTM+t9dfJ7BtjHUeCxf?=
 =?us-ascii?Q?E57JcmuH/c01WXfYYPItYxn4TxwMp4tU60dL7LcXqWdIi6GBCJO0VpJjgzbj?=
 =?us-ascii?Q?qLhkg8q35db2iKR54Bc2Pj6Y43UHbI7BggY+lVwyYTFWUj5mCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YnXtLewCgOU0M+LwqKcTIMuff3c6XCt/o+oSTA9SjRJWI0ecsYJjP0APmd7u?=
 =?us-ascii?Q?+TPIInb5kDbRFolE2alErR6jWyYjXR2jZBocVJTa2NNT4ts0jHrRvdALGSib?=
 =?us-ascii?Q?rv1Zu/RB/8n4CyZ61N/aiqUFgwml+IW61XfMfCUc0+BNVLv6xyEorxM4/f43?=
 =?us-ascii?Q?1Vee4Pkgd6hKlFiYLcpkKRjEKGBm1xMC2f+JARTd9Buk5tR48kF0j7rWc+Bf?=
 =?us-ascii?Q?BTiG/XxvRDBNlYrEPgisnh6zBFMif/cfKTj9uZfsdKaLrmowwVUsnQ5u6xxk?=
 =?us-ascii?Q?GflrOAmcQWe83e/4m9QrZvwTu7pVEz/0PMk+lmNfAcT8HzwFRf7MhruZKFPJ?=
 =?us-ascii?Q?a49j+dh7fKfmh259X/2OP6A2W0vYFPGqzROpFBWzvyQRsZCW07f48mSn3K15?=
 =?us-ascii?Q?nyxn+CKBr4cnKQFnOTU+LJ8JLK5RettXAdFS633nLv8y2TIW7Rbyl8kq/vFm?=
 =?us-ascii?Q?CBV9RfWn+1WFAqXZ+IjDpfliAGz4AU1t8jMprvsTHgner17q25R1IbdWr8vZ?=
 =?us-ascii?Q?4LrjV7uaVRBIQ38q2JYhPdvb7UCfwts9xMUH1G96uyTvV1Chbnr24UvcyMQe?=
 =?us-ascii?Q?aH/C3CblmZ7gO5PUknoaJTkpd7IFGuh6Csmrj4b9VkDEIjKIpbu6jgyE1EIu?=
 =?us-ascii?Q?H5mzzlDhUG/j2CybRF9Ah3/wCwt6pSC0AVejimRTyTGU26tmtyTzCbKRME15?=
 =?us-ascii?Q?+ty0VI+McF3NBeVAGE307u9ATMDdZLqxEdl785CZ+1Kgd6N9lfqwcDZ/07Tv?=
 =?us-ascii?Q?Ew2MoQDZAJhUenAcbEGAUutvCkGiCd8CBxGFxVSXU8M3d+/rgHcRvntnFA7m?=
 =?us-ascii?Q?65WpX+gKYPZxAizJyzefSsznn6ICL3MVBvEJyaQVys6chhm4Sf7ycuG9Rflz?=
 =?us-ascii?Q?SdtG2CjDAl7ArLBeCGfMLypJyddHc6fCoBOU22Njd8I8FUXOxCTTvY3NxeS9?=
 =?us-ascii?Q?TTNonSMAuVieEM1I988UQgSn1Ef8GfRoIMoGReuaX7iHcUfjwvDdynoW1L9E?=
 =?us-ascii?Q?oFT53i0HffceQ/Su0fjJ96ux2KuAqeB+ITmuyKdidglZeNbU9D5SV8Lh2RYW?=
 =?us-ascii?Q?MZxVT1ZB07ZvxOqSV+/ivYMAb6glzQ5LUl64G3FXJHdTFiQ34LnzP2Oa/M+0?=
 =?us-ascii?Q?LPIZHjwySmpb7SDtqXyOK5q5uAPHlZTTF63FkjocYRT1lLEIc7IRDvN9Cj4i?=
 =?us-ascii?Q?b46J2caOSFw+JSq1opwJZG+o5udwtZUCUkD1et7X4jOKr9Qh72jwTVeWomyZ?=
 =?us-ascii?Q?fN/jYEeA5RVQ9W15MzSHyzYPC71auRdg/JXIO8FlzMcI+PSau9uQbae+0J/V?=
 =?us-ascii?Q?UzIyO8jLDE4p4lBCpO4xVLgsTcTAMxAB/n/Nbge1LBoDPMMiwGdqOpE/QmY9?=
 =?us-ascii?Q?ilMjkUE7VnCq3LBJrsiovRCWyXytdEB6YRZ0YIV29hRUpwR48Ai+9GBepE5g?=
 =?us-ascii?Q?JGFXUP+GDZlK3OpMZHBJqU55JWuK0MQIdZbD0BSyClt3H5PuS3Qx0j3EeGtJ?=
 =?us-ascii?Q?GsIxjN++WFWazhoeBM1csnf731kbU7pJ6ARB0QPTtgPDSotXH/8VtELrqgrz?=
 =?us-ascii?Q?ZECOV4OLj+cecXEe8H81H+cKZrXqwqtV5yWZYy+b1nDNUk3/12ePCGrB70r8?=
 =?us-ascii?Q?cu1tLBi9CDL++hOz/Urfw9M=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 481a89a6-572d-4529-73fc-08dccea85814
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 19:16:01.0449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/tNSDnGj7vzZagR2Y/LOuzHj5cjAtXFGzPEqF/eRy0C/0i9rcqy3sy4Jh1/Jbs7r8H7nJk+Hb+geBIhKYPKUxM5RmQJlWbF7TyFVp5wB+YGMBtlIF74eGuY7hRraotM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7014

The PMU driver attempts to use PC_WRITE_RETIRED for the HW branch event,
if enabled. However, PC_WRITE_RETIRED counts only taken branches,
whereas BR_RETIRED counts also non-taken ones.

Furthermore, perf uses HW branch event to calculate branch misses ratio,
implying BR_RETIRED is the correct event to count.

We keep PC_WRITE_RETIRED still as an option in case BR_RETIRED isn't
implemented.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---

v2: Instead of removing PC_WRITE_RETIRED, keep it as an alternative

---

 drivers/perf/arm_pmuv3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index d246840797b6..f5ee6e2adb30 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1089,14 +1089,14 @@ static int __armv8_pmuv3_map_event_id(struct arm_pmu *armpmu,
 	if (event->attr.type == PERF_TYPE_HARDWARE &&
 	    event->attr.config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS) {
 
-		if (test_bit(ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED,
-			     armpmu->pmceid_bitmap))
-			return ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED;
-
 		if (test_bit(ARMV8_PMUV3_PERFCTR_BR_RETIRED,
 			     armpmu->pmceid_bitmap))
 			return ARMV8_PMUV3_PERFCTR_BR_RETIRED;
 
+		if (test_bit(ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED,
+			     armpmu->pmceid_bitmap))
+			return ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED;
+
 		return HW_OP_UNSUPPORTED;
 	}
 
-- 
2.42.0



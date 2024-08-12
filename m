Return-Path: <linux-kernel+bounces-282829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C588B94E91B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510F51F21E10
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E53B16B750;
	Mon, 12 Aug 2024 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="guiXbKx8"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2091.outbound.protection.outlook.com [40.107.92.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D205781E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453260; cv=fail; b=U8F9D4TfsohZyxlfnlBRU3yLbeobmFgKmMZ210TiOuDhKKJIH2WGAAoKD+Lqk0NbYveTjZ0x3P+4UYI2TFhc88BUYtZzwcT4HSJ6RpIU9KRRDhHsUswGGcvah+OhwyqTW1nc7ACe5v4e+gfviuF97CcC2rTmFWytfXqBaXQRBrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453260; c=relaxed/simple;
	bh=NTT96RrOp+kY9FKeTVf8SAhD6J8GFpIG9eBNN22DAqA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=f4S40rw/LZPrpOgUd+3j5xJ0RZDcR9/FSRamDyh1itbgVl+KGISzysjonFIwMbOCxqt7OWa6e3VWSradDhoVCFwa1bKmib6ZgmrsK7bZTZuGAXdm9ae3Vtwxffmca4IgqTgih16veKAlV4ra9mC+vB9jcr2/IVtOU/5LyQgU4wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=guiXbKx8; arc=fail smtp.client-ip=40.107.92.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9JtdauCl88+3uxCJjN151Bo4Q0zwhAmnT/wKTJQL+LuypLf8/p7OsXM24X+U6bKm0AAMS5THYAGwsikX/s2nZkuNvC239exr4cHHjWTTnBNdx7PuioejS1fgGSMrtSUT870rdLZnovH2+Uc1NLOAM8rENTKSP0Idu9mAOKfDQYQRQY9XdpSY8AjlnH445+Jp5oxasjrxgOoc/dryGTiWBB4TSVXRSVgnmWceERAPXRtM9eyenHJU7Ghgs55WvEV3EIlP2guv5LOj+rIjJNGFPRu6BeLBkPgq4mm7eLoUYJ5lNOR1AAfAAg+6TGwBQ0l9/UR9MOBYV0u43YPYIrlJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wF0VyJxIPhgvV3Vvxfdy/oaUTzKTlZTHq2i7oj6wnnw=;
 b=pv8L3NTDNMJ7kptQzIt53rOA+7hzJO4T3HDkmOODKLknYUs7KyV6CojttphVkIXEJ2AWBUjw7uv8B/IszkXsAB2xTP9LaJrUOJqI1SYGCXsKJJPRQHd9iu7gID4YiNFQ/qTzVYvlbaHkig9rGl85aVeXqh5yejO6ZL/L/MsaRyJ7MrbHBV2u1RJIYcDG3EoQFEOPG0tpVUKUb82LNiW7PIcoVVy0HnL0EjIWRBgdTYlVBbhkbxXIgL3mM5Sf2aO9WtJV7bxOZGpq3zduHZgrhmQXwibcgqXQ3ISBo3abqFqabWnlzzZG4J20NH8EPqqq1YYFuMoktUZwx2eygw/2ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wF0VyJxIPhgvV3Vvxfdy/oaUTzKTlZTHq2i7oj6wnnw=;
 b=guiXbKx8rllIzRrWHI4wLmlDLkNOlqjhS56moudFwugODOoDwK4SrOlwgC+gx4owSAG7BrognsqeLcqELQXdyTIf07fhPwmPJtJiQUOYdgOQ9bXvvvkoMn66OsHFZv+rIpiqWQCp/xX9JCo0L2FOOFW8Y/ZblJUNL/vIeHwapgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 IA0PR01MB8349.prod.exchangelabs.com (2603:10b6:208:481::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.20; Mon, 12 Aug 2024 09:00:54 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 09:00:53 +0000
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To: james.clark@arm.com,
	mike.leach@linaro.org,
	suzuki.poulose@arm.com
Cc: leo.yan@arm.com,
	acme@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	darren@os.amperecomputing.com,
	scclevenger@os.amperecomputing.com,
	gankulkarni@os.amperecomputing.com
Subject: [PATCH V3] perf scripts python arm-cs-trace-disasm.py: Skip disasm of discontiguous packets
Date: Mon, 12 Aug 2024 02:00:15 -0700
Message-Id: <20240812090015.326434-1-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR11CA0026.namprd11.prod.outlook.com
 (2603:10b6:806:6e::31) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|IA0PR01MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 10f2df25-5e1f-4b29-781a-08dcbaad4537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ffTwoIJ0lloXI9Ne39kcybGhZffGOJ0FMaAuQOfo4ZzU+N1GdIrRXBtz6k5W?=
 =?us-ascii?Q?l1AvX8tPAwPESzRavFqVBqgMWaXtuzy2WeTqX4JF6PZG3sCj30nK5Yx1zCaR?=
 =?us-ascii?Q?m2u3+rNlZPyF+RgXfsn+JTiGI8z5t+7oX3pZPubky59cANPZtb92TRG1prr5?=
 =?us-ascii?Q?P4HqrbtoQ1fl0xD5VhLt473D9vKbN1vo7GJmlzyo8ry4wrkYTTmtx7aLCTvP?=
 =?us-ascii?Q?WpyBqaaHsOeK4p6zE2yJWsUCja4rM1AvX2/62nCdxeXMCwYZtEp0Lm2KNOFs?=
 =?us-ascii?Q?d5hv1Tlc2NoUgw/Auh9tsH9TC59p+HX3HpQnD/R3pmbLPlQvXKWMXtNjW/Fu?=
 =?us-ascii?Q?bGEqzHBU3YCzoAwMTmviIFSMF7EewCf7j57A0roI4JLfP67u+EcIFzpVtyIf?=
 =?us-ascii?Q?2qfQ5N/8Kg744jeWCXBcQv5m0fhRDjHz8UGQsSEqQtKeNtH8pgRmdR8cX1wA?=
 =?us-ascii?Q?OVF1Dw5wBQyUFyk1b+aQmdY+dOYQ4rlVUx3A8rgOZEgVV10P/O7jwlB4lwdW?=
 =?us-ascii?Q?MNWvfqNzooIOpApR2PBtfIe32lDrA2poody/5boNAChn8VUN6JJpx5yswYHU?=
 =?us-ascii?Q?VqmJiv2UQu0duWXOvQJsK9V+g/vTEi1fBjq9ndvOSGdvE1XpXTWLtH/wWYgY?=
 =?us-ascii?Q?1CMDU5N4ctF3D2FVQ+US9fcM4ZDIWnZ/0OO1p4EIvVhiVareTj/M7WvsHO3X?=
 =?us-ascii?Q?e10cdRm0QEJYBEve6DpnCNGn4uR1nakib16PkAe6GyWRLroKIdxs166uvsdi?=
 =?us-ascii?Q?ZQIuzfn7Uu5/Z0FugayrtJK22rYOvn9bvJ3OAlqPuU2gE0KaARteWuwZfPFK?=
 =?us-ascii?Q?1KDtjhi2Gu3qyfYE6fmFwTioO5ZIj8IXuMpqZlPGdhMvtMxKMQ+4Pz9zqPUJ?=
 =?us-ascii?Q?1lNFlMZbjjsnWJkHoUmCxwgfEFwtsZ+bY5xPuwPXwjArQDUPUjryWHf71xzb?=
 =?us-ascii?Q?/pA7NuCovVowsthqfDmwBSacfJ291w+Q8JR2QH1iM8QYSxY9JxFfwzT/4Jis?=
 =?us-ascii?Q?KhzgpXQ+TOeGSA+p/VYVFUU2R1NZl7ksCz+9GY2kKUw1kdX4iFx+xUttiORr?=
 =?us-ascii?Q?Oqp9iEuRjK8gbzLtvmM07qjjOJq71V0wEc71gafjWdCqOSYzVQrrKG6b4clM?=
 =?us-ascii?Q?seN1p3M3N43jK5u53tfd0OIQTuafejyMrMPR8PZbjvNeYRXTXL/lv/ol6UaU?=
 =?us-ascii?Q?CXuZGeULoJMADY9XWaqdr3/TXKhwNs+SsxQFs14YKL21lOB2GlgoPKUSxLpc?=
 =?us-ascii?Q?wfipws1oz0+zrHfXvmPWdafpmRoiXNqB+tnMVoDX+sfOapi8J4VeWY3/k91j?=
 =?us-ascii?Q?loQNI+ORu3m1l+nwoA4775qnuypGYgde6OqU/91CWfpPkF/wK+WE0CXlgRtx?=
 =?us-ascii?Q?lKTIy/U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eSOsLzZdBPXxn0pVsNi4lv8pI2hBbOdiBj5Rx98lMVjmuIzhhhzd8aWFYZGy?=
 =?us-ascii?Q?SSzszdM8oX+kEF5HsPvwJMs9s9tl+djObgMhlQOfnkDAlLsM8k/LIsaDeDPZ?=
 =?us-ascii?Q?DSev12+haJEAkrdPSFNBrtiZh8FUK9kj8mWRsdnN8Tx1ynSdeLMsldPYSzB3?=
 =?us-ascii?Q?iRKUvQlXBnvkAAAg8kJe3cEkeQA8xmdUn7au36cqfmoTZ8s3DsyAkKwAE1dq?=
 =?us-ascii?Q?N63/ecCdznhd9nEhuz+feO7TSB22nUKh0kqCaG3AovmuQaT7Z47AAkjd4cP6?=
 =?us-ascii?Q?EooRjXtRoLTouBAnNdoEEYzh/jUzBMr4YP0W0rEsvUnFLyTstE1awWH8u9Wx?=
 =?us-ascii?Q?5etILASb7ojGtovRRDPsIv2HUlMtCLA2r/zt/tfXq9z8yaM7xz1uCIq+T8QE?=
 =?us-ascii?Q?TUhwf7rViMtpnP5GvyMZ2tsY3CXgkzdhpGBfHi2wuvX1lbM++A2ygOmHdhbq?=
 =?us-ascii?Q?AAUWqju9CMXWsGF2dad+GSso03rCcQAkXIW4wq1l0SAYkHkRoTMDrcLNJvjW?=
 =?us-ascii?Q?Om4zQGl/BfDYf+Mov41cP+6iZmsNRlXYzLLT/GCpztbb/rg6PCO+j/zyAZrI?=
 =?us-ascii?Q?oKo+b9IYxcKu3oMJCKa5sQbi2k+gcFXgJJoLJnhIdFjE6CWPlQv1/7MlxShO?=
 =?us-ascii?Q?nTCgCeK2/i6ygViuBAGhqnTg1WdZsAqyE0lFE7xpbzDXmTMYjCf2yi7Hftbu?=
 =?us-ascii?Q?wW+aZBfwiihZDLBxeiJDttMYgS7be5sKo0k4g6WcsEcSk5dH9qODMNc/m+Ha?=
 =?us-ascii?Q?7cwR89zNiChcjlG0LRMso1ClJCu1joYV6nYSPW05b1ype8VZGOyQLByl6qxn?=
 =?us-ascii?Q?8D7cDnWnZzWbDw8rWNqTOY6/KMTbWG1uunIBr7MWr1HvjlAVUETxf9/jONjX?=
 =?us-ascii?Q?L52fxWvG3yzVUCIZbz2QDJFyn2e+O/lK+u6aHTI57uvcnyhrPxWeCGPiu+bV?=
 =?us-ascii?Q?n1OUF9Lb7fjuPq9fXjpYn+ix38xcYVpuklpulZe2oNuNVDOufLwJpZQC2wtl?=
 =?us-ascii?Q?GcDc/ktLDI6gDeaBP5PoFkNk4fWB/7xm4fBiRurTizLNVyJRdPRsd8vdKC2A?=
 =?us-ascii?Q?5BtFHyLV+CAM3bu7Bal0s1R7LYH9Mx2fqSCnCS0k3zcBcOHYylwPPbqA+kaE?=
 =?us-ascii?Q?YjK5BjoixAjlOjqfEM4lDW9lfX2gNN+cr1H/gYLgZC7Qlu66TE8V5JffqGip?=
 =?us-ascii?Q?Kjsva2151/7VxTTpGXqUZGAijHAfb3WLDWbDZXaBCkgDJui3Nx4BamlEaIyy?=
 =?us-ascii?Q?607Rdybf8FWDcPhfQzhUWtc81nhwJAXstX5qdchwEQB4j4MftjwcTRewFhgY?=
 =?us-ascii?Q?sEl3Szz4P2AfZeBkl0qyRJ+cH3YxcENJQ1ihanzqlWUNqDDvN1BVqxzUuRV7?=
 =?us-ascii?Q?wLTlkH4qIZS8RSq+WM2m1kepEoy84JuEWjVHO6zjvg9M/vZ/F7qMV22v082u?=
 =?us-ascii?Q?Wdgs779C48YU/U0w7NKYjDXuZiEEtq9A8a1FFA1NKRx1fOntFAxSIxBRQ8JY?=
 =?us-ascii?Q?HAMzPVh2CZ0bdgc5PBwzJ/bkOZTY6i7F2sN30TTGdXW47XhXZHlOFykmRSvC?=
 =?us-ascii?Q?OMnXUmZjhq3h3XSz3IMn5LkzlGeFWGge5avsLsTGFNQWphjypQPbVAH+by7O?=
 =?us-ascii?Q?VQfBLEwOHA6mKpTkXQmMBSk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f2df25-5e1f-4b29-781a-08dcbaad4537
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 09:00:53.4226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ux5snVZoNQj3iq/pDVwBUViSwl7A7OW4vn+ApFHJlnMHgBGcjHQnTsJhFGxB1IdX87J1X03XsxSRnZHEqkyH1um77g2rdTUF5Baj9kMnskloyr0L5YqwY1zn2gh+W+Yp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8349

Script uses contiguous address range of adjacent packets to generate
the tracing. When there is a continuity brake due to discontiguous
branch address, it is resulting in to a perf tool crash(segfault).
This is expected bhehaviour since the decoder is not expecting the
discontiguous packets.

Adding an option "force" to allow the decoder to continue and complete
the tracing without application crash by dropping the discontiguous
packets from decoding.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---

Changes since V2:
		Fixed minor indentation issue.

Changes since V1:
	Updated patch as per discussions[1].

[1] https://lore.kernel.org/linux-arm-kernel/ce4af204-874f-404c-a7aa-42dc6693d072@linaro.org/T/ 

 tools/perf/scripts/python/arm-cs-trace-disasm.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index d973c2baed1c..65d59db3bcec 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -36,7 +36,10 @@ option_list = [
 		    help="Set path to objdump executable file"),
 	make_option("-v", "--verbose", dest="verbose",
 		    action="store_true", default=False,
-		    help="Enable debugging log")
+		    help="Enable debugging log"),
+	make_option("-f", "--force", dest="force",
+		    action="store_true", default=False,
+		    help="Force decoder to continue")
 ]
 
 parser = OptionParser(option_list=option_list)
@@ -257,6 +260,13 @@ def process_event(param_dict):
 		print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
 		return
 
+	if (stop_addr < start_addr):
+		if (options.verbose or not options.force):
+			print("Packet Discontinuity detected [stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, start_addr, dso))
+			print("Use option '-f' following the script for force mode")
+		if (options.force):
+			return
+
 	if (options.objdump_name != None):
 		# It doesn't need to decrease virtual memory offset for disassembly
 		# for kernel dso and executable file dso, so in this case we set
-- 
2.44.0



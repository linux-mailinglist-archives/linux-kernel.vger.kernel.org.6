Return-Path: <linux-kernel+bounces-280664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1184D94CD76
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E18D282F7D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7DF190693;
	Fri,  9 Aug 2024 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="cXxyxTHT"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2133.outbound.protection.outlook.com [40.107.93.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8D7BA41
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196474; cv=fail; b=jruVk/4Mr+K6j0jaUItNyUb26UweraLE/5laRzZwEEANVxLh2TPzb+GqbkSZgikWzZEzPYCqy7jD0o071ADBPNkQ9HS8Dt+nqTwRiaGvGrnf9ThiIUa5RahKK+Z8liNqHrkIWMUATHITaBr1AWsitkXMxWc7wWBStbfEbKUQvbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196474; c=relaxed/simple;
	bh=Z0oPDH58oR9fCNMERc2C9iFYSxTpLKSvmH209ZmCXkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PTY8yQOUxkKkNQKY6xE+oNjdqWO5R7WLgA32fBe+zPq1kcak43fxDhKj2gyBcvPwN7lFf735qkCkQb8YV1kU5ahQYaLR1mGV3lpGKPWGjhG3uG1b1mgptSNUBQy4iPMeSqX7xY4/r9uHSpuLKKH+XpZmqfV3oXVXEhgS7CzMF48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=cXxyxTHT; arc=fail smtp.client-ip=40.107.93.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hm//GJL3frumXB6JCNBxerriq7e2IvqqoooGstEPvD+XGFP09lZpVcLFD15c3EhR+JUe3aKaD5edtCQJjuHgx3mY4HSf7aCD7cUCDdUZ4o7SI/PZfp7Pi6A5+6pzcf/octXkRQN99pf3AhQ3zPCOj42WJQ6GtoLgbic3+qgRTXQHG2pkTyKCeSge64DTV0mVevYo7IB9TVicLabcLEPPx3Op3WwKKxhG2LgzCJzNZJi5+au7ebqCyaCeDM1C6P92mcy9wVRn/hvsPVtjNr0yvsP5nzXrlUJife/KSc8egZrbgu7btxAq8CAzo8/TKuRCsy9gVeof50VcdIb3ik+WPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlW2cNNZnE9ul6FF6og2+kVSdtbF4MwzEZM5rJq1Ros=;
 b=g+cmhG/vgkwZTkveKxPR9dL9yoLAtZBrFr9A5aXp32+dcrEN9DOrWKgRuJBp2vZjWlUwSF2rbsQn0s+lABtPTCEqTSTB6HDg+91HY2AA+arFdRnOaYHB97EyNx4uEcC/+DCn6YD/P+yHLNC/dqjDacMNVjMTb08Zk23LCevuwiZqUyl6HLObq1nvWNuok/bdrDgCGtASBj/tbPQOyB2In5MeziNR8CLO/cdIiMh9Q0gl/bmMMX01xCD3UIWwppTef9YuY6eWZx7klyITg3SPX9garFFn93luuz0M9BLSrCeW1OyLL21oUodnDxtNH9PlXTvRXlZtrKlybM2lCsZveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlW2cNNZnE9ul6FF6og2+kVSdtbF4MwzEZM5rJq1Ros=;
 b=cXxyxTHTcq+5WPm5YgItgRLGzhHpZY+Fkzq6gR6sUz7RAYoblS/1Fsbc42hfm/MR3WQEsJn1XNzogcTAxnCKy1adGyTjMhUgCfbs34tCXkIXp2/qoZ5Ybg+AJghNO8MYbJkngja+Siqy0lAK//FgB3KbdXx6eW88Tp9kbYJmhaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 BY1PR01MB8804.prod.exchangelabs.com (2603:10b6:a03:5b7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.32; Fri, 9 Aug 2024 09:41:09 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%4]) with mapi id 15.20.7849.015; Fri, 9 Aug 2024
 09:41:09 +0000
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
Subject: [PATCH V2] perf scripts python arm-cs-trace-disasm.py: Skip disasm of discontiguous packets
Date: Fri,  9 Aug 2024 02:40:47 -0700
Message-Id: <20240809094047.319917-1-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::18) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|BY1PR01MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: c1afb3c2-c17a-49ea-8d41-08dcb85765da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?COqfRagNe5e4GKQ0CzB1mo7HtvC2rXMQY8GpGR+USQBHXupi0PcJcl1GU+7r?=
 =?us-ascii?Q?meFVJkAQtDePm+TZkzWRKKGf3yCFhwXRbz6RqA/wKqq1Hg6e70YUJYS7FTIt?=
 =?us-ascii?Q?ZVKBH7c6F6/PgOUno632yunX0Gh6Y50ymaHXknaRUkSmy5PCftoHJwXJCqQJ?=
 =?us-ascii?Q?2stQX7JTdsBCx55Ic/lvxcTMa2YcqJeinMZXEb9OUQi3+138Aqw0ChHOoVF7?=
 =?us-ascii?Q?FvjKf8n9dBy4yNf24ObGDHK9BD7OtKXW7siOnAQhF4QF1CBf+pBTR3BbqPRI?=
 =?us-ascii?Q?Nbq1E80xYzi40SwQvfmpoqFr/ML/TZXlr1o0fgUvgz4BH6w41bevoBc/BZRN?=
 =?us-ascii?Q?kZ1SdhrnZZvhXuoVR6ff8E0v0cCcBGn8ABsc9i591EosebHI5oV0GzPbEWYh?=
 =?us-ascii?Q?2F9vF1XHSOIdBYvNXLlM901T6Ige2cROMh0JF4OTrw3klUwbALCMSfW0hi4p?=
 =?us-ascii?Q?wvMMxJVFTLfbmgnKGY3bYc1rLhN0yYQZ2XMCpnVd737HwNYjZWniKK1AJwdz?=
 =?us-ascii?Q?vHSVXzPS25F4pCvj3LDlPr04vvhEbqPxsEt/EaCX2UK+sEdUIIbsbFMvMgF2?=
 =?us-ascii?Q?vuvDel/xpzWLEQ198OL8RWgfNUub5PfTB8C+i9kBUd2l8t1YqJJ+Eex2fjLq?=
 =?us-ascii?Q?sSpyg+3O4gWM3fi7/74VEO252rb4lufnj02O8J9OEYNn4rC8hfIcM7352r09?=
 =?us-ascii?Q?pMNeACSQ6DN/C7L+mCchMqcRpja62yGcROyY3yFJyPR463L34ZC4SdWYNKuz?=
 =?us-ascii?Q?5a3FMUrF9qxHY98t3JwuIYZ+CX/NZ5FWJRP5TOJv4NVQUD3eB1wQiUaeYgke?=
 =?us-ascii?Q?FjJddeTP4JiEDuHFU8uejY8ASbhrT/r5WrPsso2WvRjLNvN6cRP25RPl58r9?=
 =?us-ascii?Q?BRQo8ALBVK3pfM4cTFoDalF3dCHnQIJxJgvC1+3p+bBOGUqW/bgw4EzjC+8u?=
 =?us-ascii?Q?Szhef/0W3Bw0vJSaSbrLid9LrEz/YoSV4zYCCbtOHeFpFb1LsC/0bPEKkroL?=
 =?us-ascii?Q?pZ/edpddZfqsSTXhG54wq9xjn49dxVdlPrE0vwOKhy5nQB36Urd43Dk29L1b?=
 =?us-ascii?Q?OPNkUyCmoai1iYNKhzB0noehC3BXSLi8NJOmKz5l5maisQPyt8MMudjApsWs?=
 =?us-ascii?Q?Q5yyqvMDu58lw4Ylmqsj9T9224kEC379bHb/l8OG46dRKY5PEFB2TLL+81r/?=
 =?us-ascii?Q?F8+vcJBn8SV3cfdWVTMQZv9VsNw8kCcSFGo72wossTjMRM5jGEJUCRFf6fbR?=
 =?us-ascii?Q?v5AFqqgbYyT7/lLBdLwiYznGEV4O/3yr3/6aAkp3Q+wZvqAdVqroirBRL697?=
 =?us-ascii?Q?SXiPry6pl1qPfqT3FuR9CMvlOiFlwkkJ/ZMVjzWzeipONse831OpDIb2s3dw?=
 =?us-ascii?Q?4Pa2rqs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NGspTUwzN+HgpzF0qveS2MlFdP76g6BJEmxPOQZjDc23D9h9DxmISuGbLoph?=
 =?us-ascii?Q?u2I8R5TBgCwbN+D5I4GpzxbwCvq2fkv1McpuDdA4Mo0/K/8KbhpvT+7xKmxM?=
 =?us-ascii?Q?KuGRfWJ/XEvXxee9pAeLKjIdHktb7hFeigQ7y456C2Ia/16l4KRmWg5Uk8+V?=
 =?us-ascii?Q?ue0Hdk8rrigJWwGqxAt8uQz6qb+4NSbg0xkntK4hfD3PsuIpwkeUlym8Cc0W?=
 =?us-ascii?Q?qp9own4FPImEPb7AJs2xGzc/quVZLP0mboTrU9yAfWJDXtAb4vwncqUqZq6t?=
 =?us-ascii?Q?DUoxU8KuCK6ReWHXv2zWpUMpBox5GRMhcBzxt5uhUArNNHnmMxhFqXqFWNwk?=
 =?us-ascii?Q?F21hMK+/moMCtQZqFaStyqNUPJYzXFVGuOXxet03f87qXvOJA3NsljoqixiH?=
 =?us-ascii?Q?OX+ctZQKVwXm4XcwMR5AR6QQnUNNx6l0XRu9oizXl0pQ/Meo1ZpTitAm8qIs?=
 =?us-ascii?Q?TYAn0qltqDSnz10zoH9phuvrB36lDQ8xENckBOFXeMhV2nIK5JZnOQKXGjMa?=
 =?us-ascii?Q?2Mr9k29myCRGJq/JVPKSpsF48RN5VHB9LF74733EQZxAzoy4yFPUe4UGjAy7?=
 =?us-ascii?Q?wf6qAqkPLlCPpF7QAjy3TmDVwl499Ox4epo8b5A1SPrf8sSIm3zbOjsViChX?=
 =?us-ascii?Q?1Wn+qp84PsfchI/7bTRUD4T9f5TcZ9CvYwzAe/hP/Zp5FvgRPjQUXW6N4s0T?=
 =?us-ascii?Q?YTdR0q0567qoh7/50gfp29tf4wWLN3zDcVjjF8hennLjHd9bGvrzYXqGGsKa?=
 =?us-ascii?Q?HRQ5NBfrxtYGbkBif8zhfW535o8OOV/tWdwvzRfZvi0bvDWbMtEzxnAk9l0p?=
 =?us-ascii?Q?DnuXYDaMUnJoJv/z9WgIdQ2GIbtrNqJR7wrskfaTtPcgiw0P5BWWvufzg9lN?=
 =?us-ascii?Q?bCHf90ypEJDBZ8GupV5X6cdVuhlos+N+zegE//YCF9kofbNTHMxRpl3TXnYk?=
 =?us-ascii?Q?0uGiWW6pSjgWqC9LijJ+sZJDacpRYV38/I3OUjV7i2tg0xcmDfA4XDhARA3R?=
 =?us-ascii?Q?6QAVHB75AlbRXUub2ta46GQardthQP8KsGvL1hwk/InF7Zeoasd2lfMLZ1Eb?=
 =?us-ascii?Q?WdNqWNeuCjSICJgdRQg+IGfVcBoBhvH8c3yIrLtZdEUGAT9oRfZYvMR7bNRU?=
 =?us-ascii?Q?YCT4Rs5GBm8jHAHCmbp7Oh078KTXDO1A3JubAu+w1ugzN0Mq3arB355C7Vbh?=
 =?us-ascii?Q?kHLZ97WgyB06ksvjPUbYbJtg8iXjiAcVUtuDuhDEMxBMhfoi8TkRg9tgRh7m?=
 =?us-ascii?Q?EKPZtzU4FWfzcdrO1BmlyaRoaEa13zWDc5D9J/vp2XRRbjLVKoVepDTrfIAG?=
 =?us-ascii?Q?Q28ePMEJhPILl2pbDdA3jBxLsVJP1cHTb6xh9LUDczjAGzBqtfzUeFJVDCOB?=
 =?us-ascii?Q?qykJMdfRtEO33ZIt017oruL3aev0Mk3xoBcAuMsA9CVvp4nmbEsaMmgZugQC?=
 =?us-ascii?Q?Iv/UfOQmdQnSuw3rFyzYC80o6Xb80LzirA8MlUSMDm/wykGrubnTU6ncbmS7?=
 =?us-ascii?Q?Wwe0yazChSO/H8z8FObp1442f10GY2xDBl5aPzMcjvAok4ZZVSrmUCkZIidv?=
 =?us-ascii?Q?z1UJe+fBzG5Xs7MozdSSqOL06Yd4wXlfLJdG6qCHJQzTyGWWPgvEr/bRxn2R?=
 =?us-ascii?Q?HpaxZxGvh+b2gMMrfJdKWpZToXmDO/LHFQwBjvKS8HhV?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1afb3c2-c17a-49ea-8d41-08dcb85765da
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:41:09.1837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmC/L8A4Z6+VaMuMzNuD6odq7SgmiYdUyjAFZ56DTTn/mFNVaVcM+CwMYTtus0Yt13CeCORs/kozR1RHgQBV047hc69Cq6lRD0OhC9etk5oo8J6d1TnS/YZYKAozQ2Bv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR01MB8804

Script uses contiguous address range of adjacent packets to generate
the tracing. When there is a continuity brake due to discontiguous
branch address, it is resulting in to a perf tool crash(segfault).
This is expected bhehaviour since the decoder is not expecting the
discontiguous packets.

Adding an option "force" to allow the decoder to continue and complete
the tracing without application crash by dropping the discontiguous
packets from decoding.

Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---

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
+				return
+
 	if (options.objdump_name != None):
 		# It doesn't need to decrease virtual memory offset for disassembly
 		# for kernel dso and executable file dso, so in this case we set
-- 
2.44.0



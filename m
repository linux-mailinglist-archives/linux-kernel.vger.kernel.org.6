Return-Path: <linux-kernel+bounces-345345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EA098B50D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD846B214EE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0044A199247;
	Tue,  1 Oct 2024 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="vhU+uFSb"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2111.outbound.protection.outlook.com [40.107.236.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72B92F3E
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727766111; cv=fail; b=ZmZhrvFDi1VyuvBN0D7GfLBa6xXxPYuOC6nLxtqW1PFq/vcgvrQI52y817h0ld+SKShBoPq9Jsk3B6QShpMPritYLa4JInsmlXA7lcp2Qb1ZQ5XHIbDkIy0H4pM+3o7cC+wISEHWHzC7JVfiumROiVXrQuz/rop4Yk5yRjYjbek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727766111; c=relaxed/simple;
	bh=DUuEKZA5HZlzMVf3jlfPg0S5iX4GF5EumtzFx6HS8oI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ghCV582+RtVoNSL2yxK9HZNDzTZx2qEaIyXziRKL/EFimL5b++Wg6/k6kLvl66nFD1HRVhy9s7IM81rPWEC9Yzjlk8nyAIlniATE3d5kyE8cEfZAe5Uod6mBiHjxuacuR2bgR9p+qfG3KeCG2ws092gzIwbUQhLV0fHRRrOXbR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=vhU+uFSb; arc=fail smtp.client-ip=40.107.236.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJiV0Z+7d0spqHGzbFhM6w+vB/SpVFPS9YMWpfvG/LqQ1HTn/vv8oysi0sETia+QM+7QVTddJD15HDJ+LjwbnRb2QNm8S7torBrsWffz5lxacisucGyc8cUMs/sAE0qFcjbpkWLTzhNrm4j2Zkuh2INfQkpnTeynj7O2Yq75CWbSw0o9zgaqdt1VggkgObv1e18v5X5+lRFPOrCVCPyeEqmdKrvS4pa9ER+1mtzS8GklISbCAy5p37+lNXkNh5MvfXAziDivUgb/lno17T2wHzy9UBAKBRaP+x2kL0LiZNkqjn3TeDccrrUCdzDj+pnAy/u7iUqx5spZCW6KuVMHFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9RZPdogMF7MQOgg/twuvcnEPTkrZGcEYk9vcDWxD7M=;
 b=cqZdxFUYhy26dN+dhIfdwDZyzjMmleNZVhFy3vnAqMj4V58JxI6QxguuIBuxJ/EXAFKRoJNV9IsAAPmEorPhgN837EqmjuL0x1TbGHHqbpox5IFeYxpAqFHGC6dcKhhGveqna9mWPN2XodBn7JFR7mq6BWeA4j07E0P9Yb/KUuFqyHRrgTgfYcOK16RcdhzLzglkMQgfsycmj4nDlmiuj/OmAVRTGvye/JDrSY3H5kml8twLg/tVhRCgAb4eC7bYByP5DqTNxNieN681bsWwAlxTIVPztAcSPi5rALAv6AOJHDVNCAco6d85n8uTkxRrXSmF6aKc+eissv5snyfK2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9RZPdogMF7MQOgg/twuvcnEPTkrZGcEYk9vcDWxD7M=;
 b=vhU+uFSbsk7JF+Y/sK9qi0pYambY1dFqJ4jqX8N9ZEtbp0Zji1+n+6f+04hXh0wyNVd/ZNG3ndz3rXzjli5GmPb/W/14Qv4j9GUzPLn/MHcnUqfZI7jQA0SU4/fQ5OnMaGb+cE1Pp2BhkDZ896wGMtkzvn+abBeM0GpAM6vKJt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 PH0PR01MB6327.prod.exchangelabs.com (2603:10b6:510:8::20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.31; Tue, 1 Oct 2024 07:01:43 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%6]) with mapi id 15.20.7982.022; Tue, 1 Oct 2024
 07:01:43 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com
Cc: patches@amperecomputing.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Christoph Lameter <cl@linux.com>
Subject: [PATCH] sched/fair: optimize the PLACE_LAG when se->vlag is zero
Date: Tue,  1 Oct 2024 15:00:21 +0800
Message-Id: <20241001070021.10626-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|PH0PR01MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b36c426-4cb2-413a-370c-08dce1e6e80d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iWJxsbZ/myAqIKT/wPdtpjjBGtOxWFQHAoEg0iWGAZ5kmKg/1ZI3aXwVebGB?=
 =?us-ascii?Q?j/PjqmfL9DlgO6KKafWYnY5maQZ+t4nHldEVfsMkrMD17xusG6bHZdY6b5hN?=
 =?us-ascii?Q?LesANBy3EoaYwVglJYyhPhWPlRWSz2HNzG68aMAcduIcABSX4NizERfE78Uc?=
 =?us-ascii?Q?y0dUV7A7+LyaFXATd9u4ViY9vetuLrLGxpRmf+DDUiYue130wr1iRVHL3BNm?=
 =?us-ascii?Q?VO24biY29LI+bGf0OHfWJQvuRZMhEy/Lpdsmxl+902QqdZfPlsxqHiCP+ejj?=
 =?us-ascii?Q?MfQov9zLrcks4qDjx9QgNt/XpyQLuUN+sBgJ9EIYfdpRI96BYlpkAV6Zz+Qk?=
 =?us-ascii?Q?cREXB9op7mKYR1ylEOn6KJ2sc/9bpxq8b4Xvx5W8uKIAh8bSWmpB9cKer0QD?=
 =?us-ascii?Q?yfr9JdXYHChurrBy5mgQfIh/AB8/LKxWAhwuABJkS8TkYABePv1k6PMuhTMh?=
 =?us-ascii?Q?X5/s/1kH9jaPstkBwdadLEl9hmlLyQzvQlQMyZvlKWoMtuNH1dSE3bZLSLnE?=
 =?us-ascii?Q?Ob7lx5IyljyC3sOLlSGNqy0E7+EMzMv1rFVtx2sqie0W93srwqKyhoL8mSuB?=
 =?us-ascii?Q?1UY1298h5kvFIel8/tK+dz6waDEEiZkFJgAgddiDlMWz655Kvm2tnbg7fSWt?=
 =?us-ascii?Q?FiK25QUWe6NuNLvi+UDt4AY+jeS+Ri/IBXmi4sDD/9Ei/7bNTuJ5iQKJDgA9?=
 =?us-ascii?Q?1GG+r1y3oDHPK+hUZZ1BdqE+GZud0PHS+luRupJBQeokmQAjOL030WiUG0ZK?=
 =?us-ascii?Q?zNFnGLnpgTYefaEV7dlz15gq2gG6KX9aPVz4O0K2+0lZRD+4KTn0+xRWYoNa?=
 =?us-ascii?Q?730Xp2mYJdDMoFjaSSonX7KyhAunaFiPSTQqkMs+oL5pFCDWu70gGdqY6w5q?=
 =?us-ascii?Q?zZAzV55yLJjv/UYqQV180isz0ty/D1g26xMCxLi3QezEOQu0XR62WCmEg7CC?=
 =?us-ascii?Q?6OSYYEKn8MOJeFl+KHhS7F/98JYPgpxizTkE/kIFSeasOR0TcPYYsHQKZ4Fc?=
 =?us-ascii?Q?y338rZudn5rUytMPjsTwGYA5T9daVaVesJL5cQAZNmX/+tqKptlu5lPEtuhQ?=
 =?us-ascii?Q?bjFFw+aXzRG9ccsXNq6wRuHHaeYWP13D1+KbttglVYrjAErJ2COGa5cWx52h?=
 =?us-ascii?Q?j6j3woIxpT1+XV2MyoZBdVVXvKUo2tysI/L6PJVaroPUMQQUEapNgpAsdyHn?=
 =?us-ascii?Q?CjrNGqC2PCIdTRk83H+AekjnVvfbdvuXajYFOg+mOr/kqQzzcfBGClw3Fyqd?=
 =?us-ascii?Q?aJNg7I7OCIBficvEo3CjNzhwwMSO437j51bPHHbpAchn23nN2cEct/sNF25q?=
 =?us-ascii?Q?v/DFqcCbNjunkMJT/ssPY40rIX7803/gLGF8BpfKeX97Pw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9qGww3xOwFjZFJ07FHyT0DwwU14BDZFwJ+E6frFLIgR3aUkINqaWI28sg3OH?=
 =?us-ascii?Q?YSDXpsyTap2moy52rZypDq6Xi5v9OWlaaCHW0wAvuiERkOZk/pT4Yp93GQSk?=
 =?us-ascii?Q?eqItiU7lWssotA59t8/pDkzED9J5rXL1ROhKWLufeRrqPk6TrVXxU2hAWLmu?=
 =?us-ascii?Q?ou2Cq+JLrl4tlzNzmI38NA3Ksd9hp93/bLxiwzHD4tXEPHdFFn6ejrmzRIt0?=
 =?us-ascii?Q?ozOVKvcgWwESk2YGwrwWtOVIhjLnBwT0T/3u/MbosM8FsI1ci7jqQMxy7prS?=
 =?us-ascii?Q?X2VQgxLtgP/l8XnfWVh6JblJ7V/UZl/IkxBfBt9VDI/gSfSTfSEkvYPOU1Ms?=
 =?us-ascii?Q?330ALiM7u3o23GarJDM6XKEZpRAlKeg+y6MaDRS7lSiqtP/M/c1qomFHUfLA?=
 =?us-ascii?Q?BRE2yoySRgg7WFaEhqCDdJLzOwP468hiCSNi05MTKBlPeQ8rlLJwGUppYyOa?=
 =?us-ascii?Q?s1fVOBky4x2Ki9GbVC049Cz5NUslbvUyhbafLB+/OfQvSg40y+zvj7eo9Hwg?=
 =?us-ascii?Q?5LFSAmGB65ujdMlZk2poabe6HPIfM9DJ8iT7CnETLHYW81E0hnat/qwwioG5?=
 =?us-ascii?Q?LrPcDJohLTvt6fYn6qicYitikHiswTAagbc8DkZT1fZHl3vCVUWjx7hFfmLR?=
 =?us-ascii?Q?9wkh5BGSaghiJKAcMdbhyhVHynFWmLoXqDjoMI9GO6+wv2ateOn1wpD6cjJQ?=
 =?us-ascii?Q?qX7bXOQ3IViQCDkIb2H5nT3SmbU2ftCRp//S6aJF2fv+qNZeB1vWFwNpIQU3?=
 =?us-ascii?Q?x6A/mol8MsPVClyFjEPoVyRbH/5ij13HjnxakX7Or8P+Q2+lKvspjvNwWxSG?=
 =?us-ascii?Q?HM0LaQgufn9RtMUeJuOG6RoFx5Va1YWk9byR3+/qhoX6H1kPUYS0MHDfS21p?=
 =?us-ascii?Q?Xu9v8go3Hl9IztiQ/jqCfbnkQgjci3Av2i6iIt6O1mo+gD8Vmknw7krszEEZ?=
 =?us-ascii?Q?ViSXRAjpFXVzQsLEgd9hI+89CiOWmbqg7t46NUeTnpYvzo6IDi31pbK97MC+?=
 =?us-ascii?Q?eKzVPng2meto8hhPWJnjwn5NFHtUXos3cuKrm71SdNFYWiySNSM+OfZhuTJX?=
 =?us-ascii?Q?zq+nd6lG4nXRcIif5Qz8vShfum1eiYXBW2qrt0YdW989v/z3w+fkGYYbgSsL?=
 =?us-ascii?Q?z+o5Wxnq3BxNKizFlweqG7BFLOJr1hL0FcKB4BvQ7vwPZqY0kd3MF1Daf+qB?=
 =?us-ascii?Q?AQipycrkawvaPPNXHQkvk3NwoA100XQaaYXY4BbvD6ZjefQoadQpxm5yR9FR?=
 =?us-ascii?Q?QlyRMPsnYBD/cTaTS2dD0SI/O60v/lRrSG6sEl2dBAYu/hMTpYTamlKGvy30?=
 =?us-ascii?Q?CH/eNBsBvrz0ugxSa//y7ErvP0Eu+5xiKFywZ1Q7hC2xefB8izhqPXEZq5aV?=
 =?us-ascii?Q?Z/xTgbarpzrdsVobGnytEScoIJahuRekqqNsZuuq2ltgzOyAFC2xP6RxhP9S?=
 =?us-ascii?Q?6Ik9ZUcZGPzF4twzJfIOQXrjfdub/JQZRcTWaBuuEap3x6jTMtrTMWeWjEfM?=
 =?us-ascii?Q?2SudEB5hdJHiyhfN9LOICBUTelkqKZkuDWzBdun2yjaDhTlPO4Ze7ZjBovCt?=
 =?us-ascii?Q?5YwpwdMrT71PPkcZyZ78ejIWTPdNqLAc3TSPatuk8fQpMZciGur5Y+cJhEhI?=
 =?us-ascii?Q?aCZ7bWofXzXJhltifpKzJBM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b36c426-4cb2-413a-370c-08dce1e6e80d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 07:01:43.5510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k16GioOY1bKeEvrGAuYjk1Ct5RleT65nlsYD8SqsDVvrZBJgBmtY34dNQPZMAY0XZ0hgHUlGgFqfAqJsqS6S7Us4nses4FIqlSW8bIpLKUtjCSVaDKgwwiGDKbw9GOKT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6327

When PLACE_LAG is enabled, from the relationship:
            vl_i = (W + w_i)*vl'_i / W
we know that if vl'_i(se->vlag) is zero, the vl_i is zero too.

So if se->vlag is zero, there is no need to waste cycles to
do the calculation.

Reviewed-by: Christoph Lameter (Ampere) <cl@linux.com>
Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a7d8bb95e17c..1812c9cc079d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5280,7 +5280,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *
 	 * EEVDF: placement strategy #1 / #2
 	 */
-	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running) {
+	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running && se->vlag) {
 		struct sched_entity *curr = cfs_rq->curr;
 		unsigned long load;
 
-- 
2.40.1



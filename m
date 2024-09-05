Return-Path: <linux-kernel+bounces-316932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5770B96D733
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7EFE1F24A0E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC70199941;
	Thu,  5 Sep 2024 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="BFC5tN3I"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2066.outbound.protection.outlook.com [40.107.255.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17CB199389
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535970; cv=fail; b=nbO8gZ3jKsBzGX6WqnJHKX/exMqAZOlJAxClzhX6NYE+GDDkZNIiYpoGqvugLHzoObyzV0CgTse68U1OkoiVFFqyfK8f3v8MJXU/8LPLenGoT920T7jsU6Aw+xaj3S+oa1MPPVpUZL5sVwvY9LKkp01EYp24akdgEsiEYZYw0a0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535970; c=relaxed/simple;
	bh=wGRHKCPc2bjRmIdydre3dOSos8lb5xKyTMCuED+2UHw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fZYxVUsrIH3XP900v5upClZGMgTmfPzgfKQhjEFGs5lWxRrceHSm3avqNMfRpWYUM+C2jI9krU37zxoyyN5b2B2WcBIcHG8AHXQ1QVviryTz6GTdILnw8Qw91ojdSxYaqtHMI+prXdYK6zd6Fh60q2kOXIc84Qg7q+aWM+bZkQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=BFC5tN3I; arc=fail smtp.client-ip=40.107.255.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wxcqegr/IccHuymjBMnkVpcCEjwmH+VN5m3pTY+gUPSE3hZdm88zNQEcgvlyOZwOMoZG3OSrx6EObn/mrUWuPvGA/Qeu9NiaHZltHJLbwchZ7O5Obz4WD/j/oLe1f6ZETyTXOqxZZeFqTo47O9vNajc8bsaPTD97Lo+CiDg3agQZ8x3VikJQVCTG/Q1vzXEY+FqaOYTu2sFDZwIIdOYe6xXE4AuqNzwh7OvOSvgmCnxzMH7eZDAWSHGnDo+DrY7NLt4lUJFwCdGF/8y74eYrfIAPDFgPRyuCgX7sMSm9ElMzqtodgljhIJE4erokVUX1cJV3dLhHViEkhuLNsXLvJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDAeRUJ1vQuDFOsV2ogqMzs50ErW/znEsZHGtaGO/Ms=;
 b=mDT/ZZ7prC0gJx5ZQth5YkJF5TsvVBVZPgt4lH9Ou630VXTDYb6/+eJLpmBF08f9oJszNCd9+ulzpTBEeCddxPZ1BwoQOGAkMg2P9e2jA2+LNpY0YZYaMWDwxLulEWBn0Sfb0DjNjoezUmAFKBrNF1M8qjPAEafVI4xKnq9XocsK8grDehFwX5KgmPUShwPwzP24N636IKOgV4bep+Eq9OcjqPgqgckltv3zblm5r6iNO5WfLPaYTF1V8PucajHWBWn/IfmdHabfs4iChWPgUF0ULm9o7lfyW+d2CNV2EZgyJS9CrPygEgjDSJA92b46T+P+YE5x50KAGl9Whl9OdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDAeRUJ1vQuDFOsV2ogqMzs50ErW/znEsZHGtaGO/Ms=;
 b=BFC5tN3Ito4uSxXCtPU9WBxvDcukK/JXiP1EqreAKycQHlDACw8CZ2unekgUzhEZVzteaKoDJjvdUK9+jthqXXMe+bbYOPpD+YIFC6/h4Iv3eW7lBzShivnkrlV5ys4NjQxkFwAgjeMT/N6iF1Bf4jpcYJ2YLdFgts+2ecp+9Adj6Qx8WRDtSIltNDVE5U7UdrrW+YlDRcZsl/v+f3pxHNK1ByiwTYEQxc7AyEeJl18ZFT3fnxAfKtByxeBaY8WPwUoSnUFdfI6nIYqEobwGeNIfYUqStecjffNVY646makVbZaR7jObIaoE4cUkLll495bWlUnQK9ZmHoiSkK2Ecw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SEZPR06MB6014.apcprd06.prod.outlook.com (2603:1096:101:ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 11:32:42 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 11:32:42 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: xiubli@redhat.com,
	idryomov@gmail.com
Cc: linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] ceph: Fix typo in the comment
Date: Thu,  5 Sep 2024 19:32:27 +0800
Message-Id: <20240905113227.1230764-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0224.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::8) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SEZPR06MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf918df-3181-437b-9cbe-08dccd9e7459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8o1hUOjw0rBfRGens5IEoR7e03pToricT85uyeNrGkRrjQJ3yajfd28SE9TG?=
 =?us-ascii?Q?KrgYq9/3j0M4pYEf9zrYS8fe1NDYil7RCb78q8JTc0zPNsRyl3zXTrkcV7lJ?=
 =?us-ascii?Q?byPB2hy8gER/rnAND+ZN1md9qHrtZHMh4GWivx/iYj+9WnT5Qvi8GuqYsLTF?=
 =?us-ascii?Q?qvXlkNoZPi/7UWrymuK/0Yg2WGiUhP7E1P7rt82v7IBxuQVsIldCnOxc7iuC?=
 =?us-ascii?Q?8T1NEphH5FJzqFucEhE80mDc4rXsXuz8welNtPv9CLyKWPsuYTrkrNMRIsbH?=
 =?us-ascii?Q?X99FDLw/FeMDbh5LcyFnYQ8pkLCN4DWCIf1vCJStR9cjSV5uFAY8kZWEBrd8?=
 =?us-ascii?Q?EgqxEMqMVrhM0WPQO/egz7ciAmn/fID3dtQ35udz8ZtA7MBnS7rZG7e/lGhQ?=
 =?us-ascii?Q?XKmIecIIM6OTzlzBcoV8r6N3aB+DjQQu/8scy1JCnKsZ739NCjVO5POZXOue?=
 =?us-ascii?Q?/6OnTZ14SA/BQFNfKQiR6qUQPTf8UCTEmHcz6muNHnOTu9MnDFaTTAX5ZmxI?=
 =?us-ascii?Q?KGAplWodm2ODBV8m8nCBa+YxpEyrJbsBjtFxzt2o0LZXCeejccgjv22/fiYl?=
 =?us-ascii?Q?nC+KUn/GKGCSnxMwvOx/jrmRTF0uhzhTCQsIsBKV4Xw6NsckCkZADyGSwDWn?=
 =?us-ascii?Q?XjgTo0m7KwOlGImLsZD8jz2FjRsDQEredG+gY4Hu9qQiLlgFHYcSzWepCaiO?=
 =?us-ascii?Q?B5KeSwKE2TvkRXMLpoYRZG0z9NAvhYSf0CXWBb+ajenFw0e4EyyFPlCIBgao?=
 =?us-ascii?Q?ydl/tMIwutbpKjfn3K1xtgaISeIY3Iv5X3KYNGVoCx1xP2Cx/I64fhz5urC+?=
 =?us-ascii?Q?ptv5ZIKP5hBw6ju5sKQpBHcmoaXO3hLUbJg5+69mXoDHJ77nRrce/Hbi+cDO?=
 =?us-ascii?Q?JirO2Lev8J5i9YDA148vokm8eLxGSL10fxz5Vbv16jLb2Z+epiOvHMdtQjPd?=
 =?us-ascii?Q?798FYdWWW5lCSVaSm+oDq9umQ4MJqrpmfOfJdTcnCLsBd41X4LNxwxL5b2F1?=
 =?us-ascii?Q?rvbrLTnZXbKOcmSDh3q5esWSCvAEEZXrcM0rReImumrfKn6k32zxccUqD96b?=
 =?us-ascii?Q?Vr3EfSh0FdJsQFMtklbKX2sZ+Djrk8yH6ecwhTWOQEFt0+WTgfb4hvLVsBME?=
 =?us-ascii?Q?MLfsoNKUGjB1xltaA9+dr8iSljKON5vPHpXtItxXSv92waiPZmq5ERcT4wfs?=
 =?us-ascii?Q?V7+JPg7B1PpldB1CkVId4dV2QfZN7MzkMje1xB3M3lcfClriSZ30W96k6ODS?=
 =?us-ascii?Q?Vr7GU9s4S34QbZ2MptcaB0iuc+ipXAmHDeO/nBtpXYhDhbCeSHdfKQYAHcmE?=
 =?us-ascii?Q?FKCrUJ+sY17uw2tpKeWbnR0TR1SsXNuQQMUyj2kyjoUb9+pKoh0HpXHfRUUO?=
 =?us-ascii?Q?hVAVxla/hRIETDyamibblL1Kyt9/Feec6aERSNa7lGgiSwuuFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qi8WLDeXOGHpgh6fyxS5qVhtwC69uGRza3MJ+yJrNBpTmBk77txdCwBanSk3?=
 =?us-ascii?Q?PrugnQRawwOVaZspVlExnT88OxLMuSHx49bDzTEgJNrCsmRbtA2ZsGKCZVx+?=
 =?us-ascii?Q?am8WLQmxmm2L48INxtzlm7pFXCEz96lWeJvFDtVFFsr+UKGNAYkq3GGpszVh?=
 =?us-ascii?Q?57Bj/+0O/u/escxYb26i64/Io+lCreJK1s/h9CezNUdXHbB7NQjb2CUyi2nE?=
 =?us-ascii?Q?9WdrlFExw37y6p0EQ8+QcLLxboz4elBvscvc3XoJpuK9BJ1SzTrpX5O/ejIu?=
 =?us-ascii?Q?SFIxfOIiBRuF7qQwis4RCYcM1zmoL4/3HnO/B35lvR0Cuks3YROtpvvHmgv9?=
 =?us-ascii?Q?TQiH9WkZLmdnyJHgyVVMT+ksoNPur495rXimvnIta9od2eav62v3NDkFqJwQ?=
 =?us-ascii?Q?Rl/h5+ejLUeSABII2DQiYe5kU2jJBn3EljSnCCEPG8BrwThsMCB18vOvYLYb?=
 =?us-ascii?Q?ubdSNEEezLrNlBWf6nwS0kT9byzje9t56y0HEQbd9LPDo/9U7ShPCfdpLxhh?=
 =?us-ascii?Q?jlbGLgkAFbuQ8/uqnoLXo9Na/wcXIvGxhr38di4NkUVgvfx3Fgj+TLZdLo9P?=
 =?us-ascii?Q?5tT8CgrkgQHVyIGeEmaHX3kD1a8mpSSr4/eUYq+WQIik60Mn6sAG/bUFho0I?=
 =?us-ascii?Q?UTh1nK5ReBr5qSa8bct7T79Etzfzh0/eIbN8uiJfM1CyVaL02UUen+YBYPkM?=
 =?us-ascii?Q?r7av+Tlszex4Th51xC/M2jX3O80n0P9FuRAnYoMGFT6hA/2SrYcEsE7JP7+y?=
 =?us-ascii?Q?6UAHHGuAqXQadAJNV4wx/odKkP56gDi6wBqWcb3u3Lw3mPyhXBqKfaF5RJmb?=
 =?us-ascii?Q?AdcHtylIUJZK0cdEGWok6u5mGk+Y8YDqi1cp1TOtGGwWXNslNF35fGOT43XF?=
 =?us-ascii?Q?M0SoKthyFKd4YAruK71HKd2eKi2QKl0z4b8AQcwMzWnCAh+fAWOq6hBETRuO?=
 =?us-ascii?Q?1t+o48vDG2BtncMeQSYJQ8J1MK1Kt7kkTD22Dc+E/Rvy1i5ispAzz4vu29JW?=
 =?us-ascii?Q?lhgx0eFCLSYC+MGMBYQEto5flMBHbPu0EGqn1ZFjIanbVxu12ytN9MDUvJgw?=
 =?us-ascii?Q?GxwmL/7XcKv3Mg3+BLyoP/Bf384/Ugzer3bEm+EkkwRPikCcE+newH7huW8u?=
 =?us-ascii?Q?7E9UQevFVZoc5ztI4F49M/chEhywDMfiTWePA9F1oDU7O3/wmcocJIsJlpg3?=
 =?us-ascii?Q?jRN3K9oUdNy6xlAk/0OkDc05gESi0Dg+3cvhQZerDRQKKi21TdJPLBDL0PfW?=
 =?us-ascii?Q?2kwF1gfoqSVJjpDHvmZn+XIswuW5u3VanIcmwjWpbQ/7nIYn8Psbu9S7xzc5?=
 =?us-ascii?Q?NOSKC2rk0zU+SCb5B9ciJ78KDgr2S6+7IrM1n3OHAa5/IUQzn5uEe62P8byX?=
 =?us-ascii?Q?VN6IlvTTatdlNUypiER8uYiux5CuW9AuxrH2aS+D/cTq2vWl03BrtAM6xtDf?=
 =?us-ascii?Q?/f6SMdiEMyraDFYP21/lYQbw0RLY1USbs/9aafhfYLAAlrWs6rtwr+wqHMxI?=
 =?us-ascii?Q?hZwpJWBYwA+jZMDgHTIt7LmX6EuEcTFRlqJ/bgqbtezZk+mvl3WBWjRSy5BM?=
 =?us-ascii?Q?48597vgs0zuHkW3adfM5yFPOtptYriKZ+YW2S5cW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf918df-3181-437b-9cbe-08dccd9e7459
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 11:32:42.0967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxMPqIJWExYVBAtRquzUi/uJ0YQgW1SxuE5unZvnowNEigC9E+kz0Idd01hHDXbScPMCTx8wgYrkitDKhi96KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6014

Correctly spelled comments make it easier for the reader to understand
the code.

replace 'tagert' with 'target' in the comment &
replace 'vaild' with 'valid' in the comment &
replace 'carefull' with 'careful' in the comment &
replace 'trsaverse' with 'traverse' in the comment.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 fs/ceph/caps.c       | 2 +-
 fs/ceph/dir.c        | 2 +-
 fs/ceph/inode.c      | 2 +-
 fs/ceph/mds_client.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 6561a6cd9..4aaaa26de 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4150,7 +4150,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		ceph_remove_cap(mdsc, cap, false);
 		goto out_unlock;
 	} else if (tsession) {
-		/* add placeholder for the export tagert */
+		/* add placeholder for the export target */
 		int flag = (cap == ci->i_auth_cap) ? CEPH_CAP_FLAG_AUTH : 0;
 		tcap = new_cap;
 		ceph_add_cap(inode, tsession, t_cap_id, issued, 0,
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 18c72b305..e23f8a40f 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -2059,7 +2059,7 @@ static int ceph_d_delete(const struct dentry *dentry)
 		return 0;
 	if (ceph_snap(d_inode(dentry)) != CEPH_NOSNAP)
 		return 0;
-	/* vaild lease? */
+	/* valid lease? */
 	di = ceph_dentry(dentry);
 	if (di) {
 		if (__dentry_lease_is_valid(di))
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 4a8eec462..315ef02f9 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1779,7 +1779,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		if (err < 0)
 			goto done;
 	} else if (rinfo->head->is_dentry && req->r_dentry) {
-		/* parent inode is not locked, be carefull */
+		/* parent inode is not locked, be careful */
 		struct ceph_vino *ptvino = NULL;
 		dvino.ino = le64_to_cpu(rinfo->diri.in->ino);
 		dvino.snap = le64_to_cpu(rinfo->diri.in->snapid);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 276e34ab3..1a1e71f20 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4910,7 +4910,7 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	} else {
 		recon_state.msg_version = 2;
 	}
-	/* trsaverse this session's caps */
+	/* traverse this session's caps */
 	err = ceph_iterate_session_caps(session, reconnect_caps_cb, &recon_state);
 
 	spin_lock(&session->s_cap_lock);
-- 
2.34.1



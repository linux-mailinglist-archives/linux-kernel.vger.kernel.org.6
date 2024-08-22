Return-Path: <linux-kernel+bounces-296885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B1395B025
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86551C22FCA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B941E17E011;
	Thu, 22 Aug 2024 08:24:01 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4675E17DFEB;
	Thu, 22 Aug 2024 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315041; cv=none; b=rW+YoX9DP0BKqf4Jc5kAw/wy7TBrott4OGUdR0Jj3g0klLdTYoj1+pMU446mrN8HOP0hQ/n0wi/zOuEGkMeKW1ArejRk9msr6+3euJXTle/SQeUeGBpCniy20c+aX8lRXNcDZd90nq+IAR9Y4S23CJygxIz5TZDcxHkDc54nBVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315041; c=relaxed/simple;
	bh=FmkK1nF3Kzc8LwR4g3OqPn4A4eKbvDeK2SLFO9/DxBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nqDCcfoxlq9mRjF1jNEOHEZAqg3Qawvmghz096qXFdXxZ32LPj9myIvXdnCwMhz5vc7ez3IFElJCSQ9N+0aISsBSVwZh7mOmvEHaj5ZPhCYumLwtHnAzqOGFMRznEIlG+INBrgVQ41zvgP/fGU62aLBQaPyj8kt7/u7ss8xZoKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
X-QQ-mid: bizesmtp78t1724314959ts0p17ad
X-QQ-Originating-IP: AdXky5XCeJ+oJgNv1RIXhQ1TiZYrcF2kiADIzIQMvhY=
Received: from localhost.localdomain ( [116.128.244.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 22 Aug 2024 16:22:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16976497135863487354
From: chenxiaosong@chenxiaosong.com
To: linkinjeon@kernel.org,
	sfrench@samba.org,
	senozhatsky@chromium.org,
	tom@talpey.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pc@manguebit.com,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	bharathsm@microsoft.com
Cc: chenxiaosong@kylinos.cn,
	liuzhengyuan@kylinos.cn,
	huhai@kylinos.cn,
	liuyun01@kylinos.cn,
	chenxiaosong@chenxiaosong.com
Subject: [PATCH v2 08/12] smb/client: rename cifs_acl to smb_acl
Date: Thu, 22 Aug 2024 08:20:57 +0000
Message-Id: <20240822082101.391272-9-chenxiaosong@chenxiaosong.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822082101.391272-1-chenxiaosong@chenxiaosong.com>
References: <20240822082101.391272-1-chenxiaosong@chenxiaosong.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:chenxiaosong.com:qybglogicsvrsz:qybglogicsvrsz4a-0

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

Preparation for moving acl definitions to new common header file.

Use the following shell command to rename:

  find fs/smb/client -type f -exec sed -i \
    's/struct cifs_acl/struct smb_acl/g' {} +

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/smb/client/cifsacl.c | 34 +++++++++++++++++-----------------
 fs/smb/client/cifsacl.h |  4 ++--
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index dd399f9a7424..2e1c9b528dde 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -758,7 +758,7 @@ static void dump_ace(struct cifs_ace *pace, char *end_of_acl)
 }
 #endif
 
-static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
+static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 		       struct smb_sid *pownersid, struct smb_sid *pgrpsid,
 		       struct cifs_fattr *fattr, bool mode_from_special_sid)
 {
@@ -793,7 +793,7 @@ static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
 	fattr->cf_mode &= ~(0777);
 
 	acl_base = (char *)pdacl;
-	acl_size = sizeof(struct cifs_acl);
+	acl_size = sizeof(struct smb_acl);
 
 	num_aces = le32_to_cpu(pdacl->num_aces);
 	if (num_aces > 0) {
@@ -1034,7 +1034,7 @@ static void populate_new_aces(char *nacl_base,
 	*pnsize = nsize;
 }
 
-static __u16 replace_sids_and_copy_aces(struct cifs_acl *pdacl, struct cifs_acl *pndacl,
+static __u16 replace_sids_and_copy_aces(struct smb_acl *pdacl, struct smb_acl *pndacl,
 		struct smb_sid *pownersid, struct smb_sid *pgrpsid,
 		struct smb_sid *pnownersid, struct smb_sid *pngrpsid)
 {
@@ -1049,11 +1049,11 @@ static __u16 replace_sids_and_copy_aces(struct cifs_acl *pdacl, struct cifs_acl
 	u16 ace_size = 0;
 
 	acl_base = (char *)pdacl;
-	size = sizeof(struct cifs_acl);
+	size = sizeof(struct smb_acl);
 	src_num_aces = le32_to_cpu(pdacl->num_aces);
 
 	nacl_base = (char *)pndacl;
-	nsize = sizeof(struct cifs_acl);
+	nsize = sizeof(struct smb_acl);
 
 	/* Go through all the ACEs */
 	for (i = 0; i < src_num_aces; ++i) {
@@ -1074,7 +1074,7 @@ static __u16 replace_sids_and_copy_aces(struct cifs_acl *pdacl, struct cifs_acl
 	return nsize;
 }
 
-static int set_chmod_dacl(struct cifs_acl *pdacl, struct cifs_acl *pndacl,
+static int set_chmod_dacl(struct smb_acl *pdacl, struct smb_acl *pndacl,
 		struct smb_sid *pownersid,	struct smb_sid *pgrpsid,
 		__u64 *pnmode, bool mode_from_sid)
 {
@@ -1091,7 +1091,7 @@ static int set_chmod_dacl(struct cifs_acl *pdacl, struct cifs_acl *pndacl,
 
 	/* Assuming that pndacl and pnmode are never NULL */
 	nacl_base = (char *)pndacl;
-	nsize = sizeof(struct cifs_acl);
+	nsize = sizeof(struct smb_acl);
 
 	/* If pdacl is NULL, we don't have a src. Simply populate new ACL. */
 	if (!pdacl) {
@@ -1103,7 +1103,7 @@ static int set_chmod_dacl(struct cifs_acl *pdacl, struct cifs_acl *pndacl,
 	}
 
 	acl_base = (char *)pdacl;
-	size = sizeof(struct cifs_acl);
+	size = sizeof(struct smb_acl);
 	src_num_aces = le32_to_cpu(pdacl->num_aces);
 
 	/* Retain old ACEs which we can retain */
@@ -1196,7 +1196,7 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 {
 	int rc = 0;
 	struct smb_sid *owner_sid_ptr, *group_sid_ptr;
-	struct cifs_acl *dacl_ptr; /* no need for SACL ptr */
+	struct smb_acl *dacl_ptr; /* no need for SACL ptr */
 	char *end_of_acl = ((char *)pntsd) + acl_len;
 	__u32 dacloffset;
 
@@ -1208,7 +1208,7 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 	group_sid_ptr = (struct smb_sid *)((char *)pntsd +
 				le32_to_cpu(pntsd->gsidoffset));
 	dacloffset = le32_to_cpu(pntsd->dacloffset);
-	dacl_ptr = (struct cifs_acl *)((char *)pntsd + dacloffset);
+	dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 	cifs_dbg(NOISY, "revision %d type 0x%x ooffset 0x%x goffset 0x%x sacloffset 0x%x dacloffset 0x%x\n",
 		 pntsd->revision, pntsd->type, le32_to_cpu(pntsd->osidoffset),
 		 le32_to_cpu(pntsd->gsidoffset),
@@ -1259,14 +1259,14 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 	__u32 sidsoffset;
 	struct smb_sid *owner_sid_ptr, *group_sid_ptr;
 	struct smb_sid *nowner_sid_ptr = NULL, *ngroup_sid_ptr = NULL;
-	struct cifs_acl *dacl_ptr = NULL;  /* no need for SACL ptr */
-	struct cifs_acl *ndacl_ptr = NULL; /* no need for SACL ptr */
+	struct smb_acl *dacl_ptr = NULL;  /* no need for SACL ptr */
+	struct smb_acl *ndacl_ptr = NULL; /* no need for SACL ptr */
 	char *end_of_acl = ((char *)pntsd) + secdesclen;
 	u16 size = 0;
 
 	dacloffset = le32_to_cpu(pntsd->dacloffset);
 	if (dacloffset) {
-		dacl_ptr = (struct cifs_acl *)((char *)pntsd + dacloffset);
+		dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 		if (end_of_acl < (char *)dacl_ptr + le16_to_cpu(dacl_ptr->size)) {
 			cifs_dbg(VFS, "Server returned illegal ACL size\n");
 			return -EINVAL;
@@ -1280,7 +1280,7 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 
 	if (pnmode && *pnmode != NO_CHANGE_64) { /* chmod */
 		ndacloffset = sizeof(struct smb_ntsd);
-		ndacl_ptr = (struct cifs_acl *)((char *)pnntsd + ndacloffset);
+		ndacl_ptr = (struct smb_acl *)((char *)pnntsd + ndacloffset);
 		ndacl_ptr->revision =
 			dacloffset ? dacl_ptr->revision : cpu_to_le16(ACL_REVISION);
 
@@ -1298,7 +1298,7 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 		*aclflag |= CIFS_ACL_DACL;
 	} else {
 		ndacloffset = sizeof(struct smb_ntsd);
-		ndacl_ptr = (struct cifs_acl *)((char *)pnntsd + ndacloffset);
+		ndacl_ptr = (struct smb_acl *)((char *)pnntsd + ndacloffset);
 		ndacl_ptr->revision =
 			dacloffset ? dacl_ptr->revision : cpu_to_le16(ACL_REVISION);
 		ndacl_ptr->num_aces = dacl_ptr ? dacl_ptr->num_aces : 0;
@@ -1580,7 +1580,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 	__u32 secdesclen = 0;
 	__u32 nsecdesclen = 0;
 	__u32 dacloffset = 0;
-	struct cifs_acl *dacl_ptr = NULL;
+	struct smb_acl *dacl_ptr = NULL;
 	struct smb_ntsd *pntsd = NULL; /* acl obtained from server */
 	struct smb_ntsd *pnntsd = NULL; /* modified acl to be sent to server */
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
@@ -1633,7 +1633,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 		nsecdesclen = sizeof(struct smb_ntsd) + (sizeof(struct smb_sid) * 2);
 		dacloffset = le32_to_cpu(pntsd->dacloffset);
 		if (dacloffset) {
-			dacl_ptr = (struct cifs_acl *)((char *)pntsd + dacloffset);
+			dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 			if (mode_from_sid)
 				nsecdesclen +=
 					le32_to_cpu(dacl_ptr->num_aces) * sizeof(struct cifs_ace);
diff --git a/fs/smb/client/cifsacl.h b/fs/smb/client/cifsacl.h
index 6a38718220fc..a23d59987828 100644
--- a/fs/smb/client/cifsacl.h
+++ b/fs/smb/client/cifsacl.h
@@ -34,7 +34,7 @@
  * owner, group and world).
  */
 #define DEFAULT_SEC_DESC_LEN (sizeof(struct smb_ntsd) + \
-			      sizeof(struct cifs_acl) + \
+			      sizeof(struct smb_acl) + \
 			      (sizeof(struct cifs_ace) * 4))
 
 /*
@@ -74,7 +74,7 @@ struct smb_sid {
 /* size of a struct smb_sid, sans sub_auth array */
 #define CIFS_SID_BASE_SIZE (1 + 1 + NUM_AUTHS)
 
-struct cifs_acl {
+struct smb_acl {
 	__le16 revision; /* revision level */
 	__le16 size;
 	__le32 num_aces;
-- 
2.34.1



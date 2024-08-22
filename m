Return-Path: <linux-kernel+bounces-296887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C706195B02A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2A4285573
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437F6180A80;
	Thu, 22 Aug 2024 08:24:20 +0000 (UTC)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D2E15CD78;
	Thu, 22 Aug 2024 08:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315059; cv=none; b=OL7Zw/77M6XrTbCscDBHcMgAxGCjW8OKU54RG0/JDwUYflPKNViuBeTPXDEFg4jxVTk4//t6c+v11RvxP+ilIc9To84TjMQPcc9FpWLGYLl/ePIyybzU3YQuFKt4CdhE5fsBs+JSxMRzQMkJVb3rou+rXjqFsKeCqXAUMDILw88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315059; c=relaxed/simple;
	bh=g6RimUv4vJVNgtXveu5qXEO7mM68/RiNwY7K+rZ5Z6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UMRS2F0TLA/tu9PeIea5PmNccpdh18UNISgikV/BytEC/VgLI80rg74nHicUZAQZlr+H9SqKTHv93kMC86lpVT3nsHbHm9XF+l8ZnIzu6LTlQUodLsbVRu/rA+GiHk5SvwQFfSVMaF01Py62XuzorrmjEirtQ5MjCROKhakde3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
X-QQ-mid: bizesmtp78t1724314954txzkvon8
X-QQ-Originating-IP: RIMfAOq7ZuiLjqe7JLusUGdoo0OXRetDxfTFSXUhbfc=
Received: from localhost.localdomain ( [116.128.244.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 22 Aug 2024 16:22:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14471600598903419160
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
Subject: [PATCH v2 07/12] smb/client: rename cifs_sid to smb_sid
Date: Thu, 22 Aug 2024 08:20:56 +0000
Message-Id: <20240822082101.391272-8-chenxiaosong@chenxiaosong.com>
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
    's/struct cifs_sid/struct smb_sid/g' {} +

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/smb/client/cifsacl.c   | 96 +++++++++++++++++++--------------------
 fs/smb/client/cifsacl.h   |  6 +--
 fs/smb/client/cifsglob.h  |  8 ++--
 fs/smb/client/cifsproto.h |  2 +-
 fs/smb/client/smb2inode.c |  4 +-
 fs/smb/client/smb2pdu.c   |  2 +-
 fs/smb/client/smb2pdu.h   |  8 ++--
 7 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index 3f7657475cd9..dd399f9a7424 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -27,18 +27,18 @@
 #include "cifs_unicode.h"
 
 /* security id for everyone/world system group */
-static const struct cifs_sid sid_everyone = {
+static const struct smb_sid sid_everyone = {
 	1, 1, {0, 0, 0, 0, 0, 1}, {0} };
 /* security id for Authenticated Users system group */
-static const struct cifs_sid sid_authusers = {
+static const struct smb_sid sid_authusers = {
 	1, 1, {0, 0, 0, 0, 0, 5}, {cpu_to_le32(11)} };
 
 /* S-1-22-1 Unmapped Unix users */
-static const struct cifs_sid sid_unix_users = {1, 1, {0, 0, 0, 0, 0, 22},
+static const struct smb_sid sid_unix_users = {1, 1, {0, 0, 0, 0, 0, 22},
 		{cpu_to_le32(1), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} };
 
 /* S-1-22-2 Unmapped Unix groups */
-static const struct cifs_sid sid_unix_groups = { 1, 1, {0, 0, 0, 0, 0, 22},
+static const struct smb_sid sid_unix_groups = { 1, 1, {0, 0, 0, 0, 0, 22},
 		{cpu_to_le32(2), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} };
 
 /*
@@ -48,17 +48,17 @@ static const struct cifs_sid sid_unix_groups = { 1, 1, {0, 0, 0, 0, 0, 22},
 /* S-1-5-88 MS NFS and Apple style UID/GID/mode */
 
 /* S-1-5-88-1 Unix uid */
-static const struct cifs_sid sid_unix_NFS_users = { 1, 2, {0, 0, 0, 0, 0, 5},
+static const struct smb_sid sid_unix_NFS_users = { 1, 2, {0, 0, 0, 0, 0, 5},
 	{cpu_to_le32(88),
 	 cpu_to_le32(1), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} };
 
 /* S-1-5-88-2 Unix gid */
-static const struct cifs_sid sid_unix_NFS_groups = { 1, 2, {0, 0, 0, 0, 0, 5},
+static const struct smb_sid sid_unix_NFS_groups = { 1, 2, {0, 0, 0, 0, 0, 5},
 	{cpu_to_le32(88),
 	 cpu_to_le32(2), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} };
 
 /* S-1-5-88-3 Unix mode */
-static const struct cifs_sid sid_unix_NFS_mode = { 1, 2, {0, 0, 0, 0, 0, 5},
+static const struct smb_sid sid_unix_NFS_mode = { 1, 2, {0, 0, 0, 0, 0, 5},
 	{cpu_to_le32(88),
 	 cpu_to_le32(3), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} };
 
@@ -106,7 +106,7 @@ static struct key_type cifs_idmap_key_type = {
 };
 
 static char *
-sid_to_key_str(struct cifs_sid *sidptr, unsigned int type)
+sid_to_key_str(struct smb_sid *sidptr, unsigned int type)
 {
 	int i, len;
 	unsigned int saval;
@@ -158,7 +158,7 @@ sid_to_key_str(struct cifs_sid *sidptr, unsigned int type)
  * the same returns zero, if they do not match returns non-zero.
  */
 static int
-compare_sids(const struct cifs_sid *ctsid, const struct cifs_sid *cwsid)
+compare_sids(const struct smb_sid *ctsid, const struct smb_sid *cwsid)
 {
 	int i;
 	int num_subauth, num_sat, num_saw;
@@ -204,11 +204,11 @@ compare_sids(const struct cifs_sid *ctsid, const struct cifs_sid *cwsid)
 }
 
 static bool
-is_well_known_sid(const struct cifs_sid *psid, uint32_t *puid, bool is_group)
+is_well_known_sid(const struct smb_sid *psid, uint32_t *puid, bool is_group)
 {
 	int i;
 	int num_subauth;
-	const struct cifs_sid *pwell_known_sid;
+	const struct smb_sid *pwell_known_sid;
 
 	if (!psid || (puid == NULL))
 		return false;
@@ -260,7 +260,7 @@ is_well_known_sid(const struct cifs_sid *psid, uint32_t *puid, bool is_group)
 }
 
 static __u16
-cifs_copy_sid(struct cifs_sid *dst, const struct cifs_sid *src)
+cifs_copy_sid(struct smb_sid *dst, const struct smb_sid *src)
 {
 	int i;
 	__u16 size = 1 + 1 + 6;
@@ -277,11 +277,11 @@ cifs_copy_sid(struct cifs_sid *dst, const struct cifs_sid *src)
 }
 
 static int
-id_to_sid(unsigned int cid, uint sidtype, struct cifs_sid *ssid)
+id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid)
 {
 	int rc;
 	struct key *sidkey;
-	struct cifs_sid *ksid;
+	struct smb_sid *ksid;
 	unsigned int ksid_size;
 	char desc[3 + 10 + 1]; /* 3 byte prefix + 10 bytes for value + NULL */
 	const struct cred *saved_cred;
@@ -312,8 +312,8 @@ id_to_sid(unsigned int cid, uint sidtype, struct cifs_sid *ssid)
 	 * it could be.
 	 */
 	ksid = sidkey->datalen <= sizeof(sidkey->payload) ?
-		(struct cifs_sid *)&sidkey->payload :
-		(struct cifs_sid *)sidkey->payload.data[0];
+		(struct smb_sid *)&sidkey->payload :
+		(struct smb_sid *)sidkey->payload.data[0];
 
 	ksid_size = CIFS_SID_BASE_SIZE + (ksid->num_subauth * sizeof(__le32));
 	if (ksid_size > sidkey->datalen) {
@@ -336,7 +336,7 @@ id_to_sid(unsigned int cid, uint sidtype, struct cifs_sid *ssid)
 }
 
 int
-sid_to_id(struct cifs_sb_info *cifs_sb, struct cifs_sid *psid,
+sid_to_id(struct cifs_sb_info *cifs_sb, struct smb_sid *psid,
 		struct cifs_fattr *fattr, uint sidtype)
 {
 	int rc = 0;
@@ -518,11 +518,11 @@ exit_cifs_idmap(void)
 static __u32 copy_sec_desc(const struct smb_ntsd *pntsd,
 				struct smb_ntsd *pnntsd,
 				__u32 sidsoffset,
-				struct cifs_sid *pownersid,
-				struct cifs_sid *pgrpsid)
+				struct smb_sid *pownersid,
+				struct smb_sid *pgrpsid)
 {
-	struct cifs_sid *owner_sid_ptr, *group_sid_ptr;
-	struct cifs_sid *nowner_sid_ptr, *ngroup_sid_ptr;
+	struct smb_sid *owner_sid_ptr, *group_sid_ptr;
+	struct smb_sid *nowner_sid_ptr, *ngroup_sid_ptr;
 
 	/* copy security descriptor control portion */
 	pnntsd->revision = pntsd->revision;
@@ -530,28 +530,28 @@ static __u32 copy_sec_desc(const struct smb_ntsd *pntsd,
 	pnntsd->dacloffset = cpu_to_le32(sizeof(struct smb_ntsd));
 	pnntsd->sacloffset = 0;
 	pnntsd->osidoffset = cpu_to_le32(sidsoffset);
-	pnntsd->gsidoffset = cpu_to_le32(sidsoffset + sizeof(struct cifs_sid));
+	pnntsd->gsidoffset = cpu_to_le32(sidsoffset + sizeof(struct smb_sid));
 
 	/* copy owner sid */
 	if (pownersid)
 		owner_sid_ptr = pownersid;
 	else
-		owner_sid_ptr = (struct cifs_sid *)((char *)pntsd +
+		owner_sid_ptr = (struct smb_sid *)((char *)pntsd +
 				le32_to_cpu(pntsd->osidoffset));
-	nowner_sid_ptr = (struct cifs_sid *)((char *)pnntsd + sidsoffset);
+	nowner_sid_ptr = (struct smb_sid *)((char *)pnntsd + sidsoffset);
 	cifs_copy_sid(nowner_sid_ptr, owner_sid_ptr);
 
 	/* copy group sid */
 	if (pgrpsid)
 		group_sid_ptr = pgrpsid;
 	else
-		group_sid_ptr = (struct cifs_sid *)((char *)pntsd +
+		group_sid_ptr = (struct smb_sid *)((char *)pntsd +
 				le32_to_cpu(pntsd->gsidoffset));
-	ngroup_sid_ptr = (struct cifs_sid *)((char *)pnntsd + sidsoffset +
-					sizeof(struct cifs_sid));
+	ngroup_sid_ptr = (struct smb_sid *)((char *)pnntsd + sidsoffset +
+					sizeof(struct smb_sid));
 	cifs_copy_sid(ngroup_sid_ptr, group_sid_ptr);
 
-	return sidsoffset + (2 * sizeof(struct cifs_sid));
+	return sidsoffset + (2 * sizeof(struct smb_sid));
 }
 
 
@@ -666,7 +666,7 @@ static void mode_to_access_flags(umode_t mode, umode_t bits_to_use,
 	return;
 }
 
-static __u16 cifs_copy_ace(struct cifs_ace *dst, struct cifs_ace *src, struct cifs_sid *psid)
+static __u16 cifs_copy_ace(struct cifs_ace *dst, struct cifs_ace *src, struct smb_sid *psid)
 {
 	__u16 size = 1 + 1 + 2 + 4;
 
@@ -686,7 +686,7 @@ static __u16 cifs_copy_ace(struct cifs_ace *dst, struct cifs_ace *src, struct ci
 }
 
 static __u16 fill_ace_for_sid(struct cifs_ace *pntace,
-			const struct cifs_sid *psid, __u64 nmode,
+			const struct smb_sid *psid, __u64 nmode,
 			umode_t bits, __u8 access_type,
 			bool allow_delete_child)
 {
@@ -759,7 +759,7 @@ static void dump_ace(struct cifs_ace *pace, char *end_of_acl)
 #endif
 
 static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
-		       struct cifs_sid *pownersid, struct cifs_sid *pgrpsid,
+		       struct smb_sid *pownersid, struct smb_sid *pgrpsid,
 		       struct cifs_fattr *fattr, bool mode_from_special_sid)
 {
 	int i;
@@ -930,8 +930,8 @@ unsigned int setup_special_user_owner_ACE(struct cifs_ace *pntace)
 }
 
 static void populate_new_aces(char *nacl_base,
-		struct cifs_sid *pownersid,
-		struct cifs_sid *pgrpsid,
+		struct smb_sid *pownersid,
+		struct smb_sid *pgrpsid,
 		__u64 *pnmode, u32 *pnum_aces, u16 *pnsize,
 		bool modefromsid)
 {
@@ -967,7 +967,7 @@ static void populate_new_aces(char *nacl_base,
 	 * updated in the inode.
 	 */
 
-	if (!memcmp(pownersid, pgrpsid, sizeof(struct cifs_sid))) {
+	if (!memcmp(pownersid, pgrpsid, sizeof(struct smb_sid))) {
 		/*
 		 * Case when owner and group SIDs are the same.
 		 * Set the more restrictive of the two modes.
@@ -1035,8 +1035,8 @@ static void populate_new_aces(char *nacl_base,
 }
 
 static __u16 replace_sids_and_copy_aces(struct cifs_acl *pdacl, struct cifs_acl *pndacl,
-		struct cifs_sid *pownersid, struct cifs_sid *pgrpsid,
-		struct cifs_sid *pnownersid, struct cifs_sid *pngrpsid)
+		struct smb_sid *pownersid, struct smb_sid *pgrpsid,
+		struct smb_sid *pnownersid, struct smb_sid *pngrpsid)
 {
 	int i;
 	u16 size = 0;
@@ -1075,7 +1075,7 @@ static __u16 replace_sids_and_copy_aces(struct cifs_acl *pdacl, struct cifs_acl
 }
 
 static int set_chmod_dacl(struct cifs_acl *pdacl, struct cifs_acl *pndacl,
-		struct cifs_sid *pownersid,	struct cifs_sid *pgrpsid,
+		struct smb_sid *pownersid,	struct smb_sid *pgrpsid,
 		__u64 *pnmode, bool mode_from_sid)
 {
 	int i;
@@ -1156,7 +1156,7 @@ static int set_chmod_dacl(struct cifs_acl *pdacl, struct cifs_acl *pndacl,
 	return 0;
 }
 
-static int parse_sid(struct cifs_sid *psid, char *end_of_acl)
+static int parse_sid(struct smb_sid *psid, char *end_of_acl)
 {
 	/* BB need to add parm so we can store the SID BB */
 
@@ -1195,7 +1195,7 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 		bool get_mode_from_special_sid)
 {
 	int rc = 0;
-	struct cifs_sid *owner_sid_ptr, *group_sid_ptr;
+	struct smb_sid *owner_sid_ptr, *group_sid_ptr;
 	struct cifs_acl *dacl_ptr; /* no need for SACL ptr */
 	char *end_of_acl = ((char *)pntsd) + acl_len;
 	__u32 dacloffset;
@@ -1203,9 +1203,9 @@ static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
 	if (pntsd == NULL)
 		return -EIO;
 
-	owner_sid_ptr = (struct cifs_sid *)((char *)pntsd +
+	owner_sid_ptr = (struct smb_sid *)((char *)pntsd +
 				le32_to_cpu(pntsd->osidoffset));
-	group_sid_ptr = (struct cifs_sid *)((char *)pntsd +
+	group_sid_ptr = (struct smb_sid *)((char *)pntsd +
 				le32_to_cpu(pntsd->gsidoffset));
 	dacloffset = le32_to_cpu(pntsd->dacloffset);
 	dacl_ptr = (struct cifs_acl *)((char *)pntsd + dacloffset);
@@ -1257,8 +1257,8 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 	__u32 dacloffset;
 	__u32 ndacloffset;
 	__u32 sidsoffset;
-	struct cifs_sid *owner_sid_ptr, *group_sid_ptr;
-	struct cifs_sid *nowner_sid_ptr = NULL, *ngroup_sid_ptr = NULL;
+	struct smb_sid *owner_sid_ptr, *group_sid_ptr;
+	struct smb_sid *nowner_sid_ptr = NULL, *ngroup_sid_ptr = NULL;
 	struct cifs_acl *dacl_ptr = NULL;  /* no need for SACL ptr */
 	struct cifs_acl *ndacl_ptr = NULL; /* no need for SACL ptr */
 	char *end_of_acl = ((char *)pntsd) + secdesclen;
@@ -1273,9 +1273,9 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 		}
 	}
 
-	owner_sid_ptr = (struct cifs_sid *)((char *)pntsd +
+	owner_sid_ptr = (struct smb_sid *)((char *)pntsd +
 			le32_to_cpu(pntsd->osidoffset));
-	group_sid_ptr = (struct cifs_sid *)((char *)pntsd +
+	group_sid_ptr = (struct smb_sid *)((char *)pntsd +
 			le32_to_cpu(pntsd->gsidoffset));
 
 	if (pnmode && *pnmode != NO_CHANGE_64) { /* chmod */
@@ -1305,7 +1305,7 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 
 		if (uid_valid(uid)) { /* chown */
 			uid_t id;
-			nowner_sid_ptr = kzalloc(sizeof(struct cifs_sid),
+			nowner_sid_ptr = kzalloc(sizeof(struct smb_sid),
 								GFP_KERNEL);
 			if (!nowner_sid_ptr) {
 				rc = -ENOMEM;
@@ -1334,7 +1334,7 @@ static int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *pnntsd,
 		}
 		if (gid_valid(gid)) { /* chgrp */
 			gid_t id;
-			ngroup_sid_ptr = kzalloc(sizeof(struct cifs_sid),
+			ngroup_sid_ptr = kzalloc(sizeof(struct smb_sid),
 								GFP_KERNEL);
 			if (!ngroup_sid_ptr) {
 				rc = -ENOMEM;
@@ -1630,7 +1630,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 			nsecdesclen += 5 * sizeof(struct cifs_ace);
 	} else { /* chown */
 		/* When ownership changes, changes new owner sid length could be different */
-		nsecdesclen = sizeof(struct smb_ntsd) + (sizeof(struct cifs_sid) * 2);
+		nsecdesclen = sizeof(struct smb_ntsd) + (sizeof(struct smb_sid) * 2);
 		dacloffset = le32_to_cpu(pntsd->dacloffset);
 		if (dacloffset) {
 			dacl_ptr = (struct cifs_acl *)((char *)pntsd + dacloffset);
diff --git a/fs/smb/client/cifsacl.h b/fs/smb/client/cifsacl.h
index 1516545d7f67..6a38718220fc 100644
--- a/fs/smb/client/cifsacl.h
+++ b/fs/smb/client/cifsacl.h
@@ -64,14 +64,14 @@ struct smb_ntsd {
 	__le32 dacloffset;
 } __attribute__((packed));
 
-struct cifs_sid {
+struct smb_sid {
 	__u8 revision; /* revision level */
 	__u8 num_subauth;
 	__u8 authority[NUM_AUTHS];
 	__le32 sub_auth[SID_MAX_SUB_AUTHORITIES]; /* sub_auth[num_subauth] */
 } __attribute__((packed));
 
-/* size of a struct cifs_sid, sans sub_auth array */
+/* size of a struct smb_sid, sans sub_auth array */
 #define CIFS_SID_BASE_SIZE (1 + 1 + NUM_AUTHS)
 
 struct cifs_acl {
@@ -116,7 +116,7 @@ struct cifs_ace {
 	__u8 flags;
 	__le16 size;
 	__le32 access_req;
-	struct cifs_sid sid; /* ie UUID of user or group who gets these perms */
+	struct smb_sid sid; /* ie UUID of user or group who gets these perms */
 } __attribute__((packed));
 
 /*
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 2a72129236fb..dd944f160973 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -202,8 +202,8 @@ struct cifs_cred {
 	int gid;
 	int mode;
 	int cecount;
-	struct cifs_sid osid;
-	struct cifs_sid gsid;
+	struct smb_sid osid;
+	struct smb_sid gsid;
 	struct cifs_ntace *ntaces;
 	struct cifs_ace *aces;
 };
@@ -231,8 +231,8 @@ struct cifs_open_info_data {
 		unsigned int	eas_len;
 	} wsl;
 	char *symlink_target;
-	struct cifs_sid posix_owner;
-	struct cifs_sid posix_group;
+	struct smb_sid posix_owner;
+	struct smb_sid posix_group;
 	union {
 		struct smb2_file_all_info fi;
 		struct smb311_posix_qinfo posix_fi;
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 36d51d57b6f4..33ca3c98900d 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -225,7 +225,7 @@ extern int cifs_set_file_info(struct inode *inode, struct iattr *attrs,
 extern int cifs_rename_pending_delete(const char *full_path,
 				      struct dentry *dentry,
 				      const unsigned int xid);
-extern int sid_to_id(struct cifs_sb_info *cifs_sb, struct cifs_sid *psid,
+extern int sid_to_id(struct cifs_sb_info *cifs_sb, struct smb_sid *psid,
 				struct cifs_fattr *fattr, uint sidtype);
 extern int cifs_acl_to_fattr(struct cifs_sb_info *cifs_sb,
 			      struct cifs_fattr *fattr, struct inode *inode,
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 9f5bc41433c1..83c831c89a7a 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -315,7 +315,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 							  SMB2_O_INFO_FILE, 0,
 							  sizeof(struct smb311_posix_qinfo *) +
 							  (PATH_MAX * 2) +
-							  (sizeof(struct cifs_sid) * 2), 0, NULL);
+							  (sizeof(struct smb_sid) * 2), 0, NULL);
 			} else {
 				rc = SMB2_query_info_init(tcon, server,
 							  &rqst[num_rqst],
@@ -325,7 +325,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 							  SMB2_O_INFO_FILE, 0,
 							  sizeof(struct smb311_posix_qinfo *) +
 							  (PATH_MAX * 2) +
-							  (sizeof(struct cifs_sid) * 2), 0, NULL);
+							  (sizeof(struct smb_sid) * 2), 0, NULL);
 			}
 			if (!rc && (!cfile || num_rqst > 1)) {
 				smb2_set_next_command(tcon, &rqst[num_rqst]);
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index bb82b295f1d4..bb56543e0a2a 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3906,7 +3906,7 @@ SMB311_posix_query_info(const unsigned int xid, struct cifs_tcon *tcon,
 		u64 persistent_fid, u64 volatile_fid, struct smb311_posix_qinfo *data, u32 *plen)
 {
 	size_t output_len = sizeof(struct smb311_posix_qinfo *) +
-			(sizeof(struct cifs_sid) * 2) + (PATH_MAX * 2);
+			(sizeof(struct smb_sid) * 2) + (PATH_MAX * 2);
 	*plen = 0;
 
 	return query_info(xid, tcon, persistent_fid, volatile_fid,
diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
index 5c458ab3b05a..076d9e83e1a0 100644
--- a/fs/smb/client/smb2pdu.h
+++ b/fs/smb/client/smb2pdu.h
@@ -364,8 +364,8 @@ struct create_posix_rsp {
 	u32 nlink;
 	u32 reparse_tag;
 	u32 mode;
-	struct cifs_sid owner; /* var-sized on the wire */
-	struct cifs_sid group; /* var-sized on the wire */
+	struct smb_sid owner; /* var-sized on the wire */
+	struct smb_sid group; /* var-sized on the wire */
 } __packed;
 
 #define SMB2_QUERY_DIRECTORY_IOV_SIZE 2
@@ -408,8 +408,8 @@ struct smb2_posix_info {
 struct smb2_posix_info_parsed {
 	const struct smb2_posix_info *base;
 	size_t size;
-	struct cifs_sid owner;
-	struct cifs_sid group;
+	struct smb_sid owner;
+	struct smb_sid group;
 	int name_len;
 	const u8 *name;
 };
-- 
2.34.1



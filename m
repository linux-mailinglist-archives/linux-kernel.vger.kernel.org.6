Return-Path: <linux-kernel+bounces-339069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7506C985FF8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2BE51C25F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4EB1D5AA2;
	Wed, 25 Sep 2024 12:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lg0mlkrI"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC081D5AA5
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266729; cv=none; b=rCRMb2A0KdLGumR6E31q/JoFxh2ZYqbe1wsVOjBBI/audUVSWqj1nHi3yovxK2oHYjfdkHGpPiMEiQPIdI3MjL6uruvbmpFAB1qL5uE+TNXdJDyopbP+7t5e8cZQOdBEnJ+C+O7bP0ouLWw9ClGP3XVzFnCzaLTlbvmUEbLr9zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266729; c=relaxed/simple;
	bh=HVChrobm56k0POkWg+Ge0IFTdeSavWkyfqUKA01l8KI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gLn/yjdMzX1KEmZpqnNygyHBraN9UWcqQoEQJqdG/GXVJNx0SQaXisqUuGml/XNQXjLJB8iuAZOP53O0D7DRuVWT0RYD+JzLSbR+pAEdjzMJJJnNNGqmvxsfilQ0xj6MJhC8yNNw9ypMuEx6mh3DRuKziO2TGW9xt7zwSO0nmFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lg0mlkrI; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1727266717; bh=ehee5zzBVWYAjZlEYmL71vLcriO/wtDFnsMdeCY4x68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lg0mlkrIaPuvwJea7shGJ38ZuA6TNmWuAFlxlTBhLxh/3GuyctjIEaXQo1v6/JBHD
	 u4Fazu4pVi9Q0qrr/4w8gG3P1wrfqKzUjpEf52z140tqyR5NNADAMDVM3VVUPCiQHk
	 PQvwNUuuswqmoHNMRR7zDjCDymzeE0rNDWQ4aBLc=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 26F0A485; Wed, 25 Sep 2024 20:09:47 +0800
X-QQ-mid: xmsmtpt1727266187thx2rxfo0
Message-ID: <tencent_11342DC56C149450EACEED06CE087BDE6F0A@qq.com>
X-QQ-XMAILINFO: OCYbvBDBNb9r8hn6TBozAikYLJd7ss1PLbMqc6ot7sjydA4n6f0KeDtwDjIHtF
	 +zntDkb3Lm9e29BGFoDyjJWR/RG4DOUvu/GsFVHaS5m8E6j1q/lh+wPqaDFSPZMmFnh4DL+4dsiU
	 FgFzCSZyiICwLoHfIgXQLMTfIwwb4tR1iXr+kuKitUIAiYN9BoZ87g3wz8L5xXTCArVv1wHenRm2
	 L2fhuKO4vVQGE5YHidh9XwdQvwIScTyFynPvWeRyhIzZ3QuQgcvMEW9nXmZUtGUsCExGL6fBZDIw
	 wUJv63WfjzY1HedubZTpsP8CfGRB6wS/oyVijRQ/ToPgl/RoAUeMd9VmdjLAaGA9xi/Pm6Lh32XX
	 hOn67xvWzWxCpWQ8DKFUAYVbgjmxsfrDn8c0K5MMu51R+cOM9Y9QP+ICt0NdmLmBT0gNHMTKrDez
	 1pLJIl3BmXCZ21flLRmC6PaVNPVe5UYZGopBpYuqdwQuKoeRiul3sqIRhHJHOopC8g95+tS8RlBF
	 BNHTHSlENmd5r4NeOhk/9R5jcben9aUL+iKo+TzjKSRS63G8fxNRvzmp0wdP/OwU4BTIC2sTV3ts
	 Lbawq/GJqNd7M8clq/CBfh9HZFLGVkIbL6WHp6DUgt5OquJUrWApZPtn++frffyPQY2slh+pUMHa
	 nW7yxaMJdeDlrSQXC9gEu5xPiyOlBzPf0kt9sEFrJuwYwpAUxlQencljlYP/B5erRhw/NyyFuOro
	 7E4yQ71YQP4i+vW5QOmpfNyWfCEv6/EMIavzLHiCrV6L1sl5JGN8lr3ukpFySF0WVgvvfMGRG9LN
	 uu/vtw7vbChrzR20kP7zsfhJxC9P265FXYm8jgV+QOIkZz51br/XoWih+MjvfDUk4FGTv1sK1QB9
	 47UxjKP0M13bpXcvShAbUL+w7E6u5vbwFI/jN9xMsqThxjbCNlAVHN0UVokLBibPFqxayfkdZE
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] kernel BUG in vfs_get_tree
Date: Wed, 25 Sep 2024 20:09:47 +0800
X-OQ-MSGID: <20240925120946.1460178-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <66f33aad.050a0220.457fc.0030.GAE@google.com>
References: <66f33aad.050a0220.457fc.0030.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

db

#syz test

diff --git a/fs/bcachefs/btree_node_scan.c b/fs/bcachefs/btree_node_scan.c
index b28c649c6838..aa247ca6270d 100644
--- a/fs/bcachefs/btree_node_scan.c
+++ b/fs/bcachefs/btree_node_scan.c
@@ -280,7 +280,7 @@ static int read_btree_nodes(struct find_btree_nodes *f)
 			percpu_ref_put(&ca->io_ref);
 			closure_put(&cl);
 			f->ret = ret;
-			bch_err(c, "error starting kthread: %i", ret);
+			bch_err(c, "error starting kthread: %i %d", ret, PTR_ERR(t));
 			break;
 		}
 	}
@@ -358,6 +358,7 @@ int bch2_scan_for_btree_nodes(struct bch_fs *c)
 	mutex_init(&f->lock);
 
 	ret = read_btree_nodes(f);
+	pr_info("ret: %d, %s\n", ret, __func__);
 	if (ret)
 		return ret;
 
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 4a1bb07a2574..49d711e9837e 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -2148,6 +2148,7 @@ static int bch2_fs_get_tree(struct fs_context *fc)
 out:
 	fc->root = dget(sb->s_root);
 err:
+	pr_info("ret: %d, sb: %p, fc: %p, fcroot: %p, %s\n", ret, sb, fc, fc->root, __func__);
 	darray_exit(&devs_to_fs);
 	bch2_darray_str_exit(&devs);
 	if (ret)
diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
index be1e7ca4362f..aeeeda0f01d4 100644
--- a/fs/bcachefs/recovery.c
+++ b/fs/bcachefs/recovery.c
@@ -522,8 +522,8 @@ static int read_btree_roots(struct bch_fs *c)
 					bch2_btree_id_str(i)) ||
 		    mustfix_fsck_err_on((ret = r->error = bch2_btree_root_read(c, i, &r->key, r->level)),
 					c, btree_root_read_error,
-					"error reading btree root %s l=%u: %s",
-					bch2_btree_id_str(i), r->level, bch2_err_str(ret))) {
+					"error reading btree root %s l=%u: %s ret: %d",
+					bch2_btree_id_str(i), r->level, bch2_err_str(ret), ret)) {
 			if (btree_id_is_alloc(i)) {
 				c->opts.recovery_passes |= BIT_ULL(BCH_RECOVERY_PASS_check_allocations);
 				c->opts.recovery_passes |= BIT_ULL(BCH_RECOVERY_PASS_check_alloc_info);
@@ -849,6 +849,7 @@ int bch2_fs_recovery(struct bch_fs *c)
 		atomic64_add(1 << 16, &c->key_version);
 
 	ret = read_btree_roots(c);
+	pr_info("ret: %d, %s\n", ret, __func__);
 	if (ret)
 		goto err;
 
@@ -967,6 +968,7 @@ int bch2_fs_recovery(struct bch_fs *c)
 
 	ret = 0;
 out:
+	pr_info("out ret: %d, %s\n", ret, __func__);
 	bch2_flush_fsck_errs(c);
 
 	if (!c->opts.retain_recovery_info) {
diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index 873e4be7e1dc..74d0af559a77 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -1036,6 +1036,7 @@ int bch2_fs_start(struct bch_fs *c)
 	ret = BCH_SB_INITIALIZED(c->disk_sb.sb)
 		? bch2_fs_recovery(c)
 		: bch2_fs_initialize(c);
+	pr_info("2ret: %d, %s\n", ret, __func__);
 	if (ret)
 		goto err;
 



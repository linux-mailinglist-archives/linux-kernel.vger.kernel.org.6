Return-Path: <linux-kernel+bounces-339087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 168EE98602F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48B41F2656A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF94199FAC;
	Wed, 25 Sep 2024 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="gE0b4qHd"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F39189BA5
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268157; cv=none; b=fhKHeQ/CSM/ZRhAPF48dDThvL3VGLiR3rWji3jnjx99NraqbTuVAlxMZmq5q9SvIX3jJOhBwlF3N/94R9prG3DYzv6OOqlNERdu3KZ2x04n4L+D+XwqlUnrUu7OxZcGuSKVNDpUFio3sfA+H0V6Ms4x9oeCwsvzjgtpHaKxfM+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268157; c=relaxed/simple;
	bh=El6oWbR7rRi08IjrUaM+P5VyJ0OlRZUZ+xlM00lD954=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=WkmQpGJJVEJcq9lvaKMwUd2UHuy/pW5KGoJWv+seDVjuGhVBSbGJp/QcHqC4dD3dfjnj3McQckN4ODppeZZrdHaEUWwhLTK+KKeQU/LAZ8bTISByrxSNAWljJYq9KC/rygWsedCJb4gz5m5IPoRIxAqs25kBnJIZKzSzBzLlyy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=gE0b4qHd; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1727268150; bh=OMizEf/W81z9x4fR7NsGieDGacS+HY7RbXRbuVcvaEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gE0b4qHdEHr+ihrmERa76ZAAYX8ofY5c3z9iaJaXRgD9MJJ6h00mLO2XQNWzKwsI/
	 160Ldj/uPTYRyLEnM5eXMZBl5JVtlmkuqh6BM24d9jqQrKvsKHTsdgqpT5aaSnn6kF
	 xasCLmJE5OKIDXwm+2rKBo81s/qiTT0no2mh+FkM=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id A9CA50CD; Wed, 25 Sep 2024 20:42:28 +0800
X-QQ-mid: xmsmtpt1727268148tqaobinr0
Message-ID: <tencent_5C26C693770376096443A5A440F760776D05@qq.com>
X-QQ-XMAILINFO: M0PjjqbLT90wa3B8JXO/EbcnUkVDZPJbyEo2MkLD4fMuzORIDYLQaS3uYhy3Sj
	 bt3wI/RS0GhKgVX5coZQhQImdqksOl94KTplZQZprUu3Wu0x/IVTxtUlX9OK1cioLcvesOEKTjcb
	 6EMqqPBoLg/meCaWWWCM+iYsVNXSzuL5R2O0rNAFs42Kjn/L7ZSPCZmMhtTItLv7ybq6PrVg9t4R
	 PVpCifUsvzxNJvW8PNVYahRko/aGiteslTuEdFMKsxnlcOoK0wK1iQ6+fxAkdcth6mG4HVY1Yh4y
	 QgJdgxok+SBX2wU6Crt7EspKAaDE6s0RspU7fQvRFe5rn2kKNtbUjVO/jGwkf5yjtyumsO/60G9/
	 UgpmgZl0wBPoB0zYZlhjGVKJPuzhpIT4M4rgwVIUIiD+dVAiXrN7G66xoa4hoRKQ3Jep0v7/05wO
	 3BCg7bMxP2entX5h/T1Gbe0PzUxROKN7JgdEa3/9Eb3xVsgJTGt4Ty5SgO790VVXeLq6tTxcwhjx
	 tXws+FBw3qiDXbwjgVjl3CCmABuNO5lRG316f3jEspNY5SHWQcYUhog7AMciwYf8lBRlbOGJri7e
	 gAuWy5PWrqx/dH3Nj+SBDdOhBoIwCwuVBOTOGhEpwMBPTCqfWv3MapZ7zrDgG++P9FfNZtEctgbj
	 WxooCbTl6DvIEd5koeyJPhIP9LtwMcnCfLgDGfPKeOUf3Ec4S9qcgBI5O+d0Ute7nxiX1ZSmp5Uh
	 IOKBuOKbndsVZ2W1XhYJyiQXLSoQKFA/sMADWPigGtuugYNkyb747fiZEPRcoEmbghMZYXVoJM+8
	 1gW5s2o2j+F/gBvlPwjdWnCZaeFh0JObW6BpqEdmFcT764IS1tLQuIsWwnFSyQgJzWQ4YvdpRnN4
	 SGnt/sDxL+oNXTgBinwdibTI24l+F0Csi/N7dqR+BiEqJa8hlBbiPT7HkiJJ2Vug==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] kernel BUG in vfs_get_tree
Date: Wed, 25 Sep 2024 20:42:29 +0800
X-OQ-MSGID: <20240925124228.1494226-2-eadavis@qq.com>
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

kthread_run return -EINTR in read_btree_nodes(), it needs to be returnned
to bch2_fs_recovery(), not back to "ret = IS_ERR_OR_NULL(t)".

#syz test

diff --git a/fs/bcachefs/btree_node_scan.c b/fs/bcachefs/btree_node_scan.c
index b28c649c6838..aa0f84d35895 100644
--- a/fs/bcachefs/btree_node_scan.c
+++ b/fs/bcachefs/btree_node_scan.c
@@ -280,12 +280,15 @@ static int read_btree_nodes(struct find_btree_nodes *f)
 			percpu_ref_put(&ca->io_ref);
 			closure_put(&cl);
 			f->ret = ret;
-			bch_err(c, "error starting kthread: %i", ret);
+			bch_err(c, "error starting kthread: %i %d", ret, PTR_ERR(t));
 			break;
 		}
 	}
 err:
 	closure_sync(&cl);
+	if (IS_ERR(t))
+		return PTR_ERR(t);
+
 	return f->ret ?: ret;
 }
 



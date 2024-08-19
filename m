Return-Path: <linux-kernel+bounces-292101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B67956B17
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A617B226D5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946B316B74B;
	Mon, 19 Aug 2024 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="LnP5EklL"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D50F16B732
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724071403; cv=none; b=mBXJcxHSC8sX2ZwJE0yao5PUp3402w+rqsLp1Mus18RQEfFfkqt/WGStb0qBRNaupeLU7PIAJQE5MESSkLPXzj0tCG6bDnnLA5cF0zfzNLmy29A6i5JhMWMe8OyLHQkt89eGnCI9YsNuse0hhtrXkb786TepgkMwn37P7NOyI+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724071403; c=relaxed/simple;
	bh=Gai2/m6Pd77eSX2qtKKlVbhFDtZu7kZrTdVCazkTGDI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=FP6S/K7NwXqLAKskDGVdfunvSzQQwPkq8ncy0FqHVIT4x1IM4E8K4jh9gIRpHkUGX6IXdLKJLe0Ajd5z3mzqAbksaRMgScG+oHc9tcnOGuTeL1uhGZILrAGGw/DhL8Jwm4pKzmXBp5jr4Kd2VWTlijCWDQYA6F7aigBCsTlzk/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=LnP5EklL; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724071091; bh=H4KEWwHR4c/iOa1WzDtme2MK/SG+05h3GqQxJ8BrG6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LnP5EklLP76dHvWozWmNpPjru3hiLZ2JdtMSUlCqVSyz/xbTDNpd/6z0vhJR8tfec
	 d4UyRLSOfGXKbruicpnHSPOEMwrXFZ8IKPM48XtiyRPSr+4dH/Nfoau5NWDiy5kcrK
	 71eDsWAHgtKLJmOodMoJ21hB1zIcJH521EwJdl3U=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 7FB3ACD1; Mon, 19 Aug 2024 20:31:59 +0800
X-QQ-mid: xmsmtpt1724070719txavzdeku
Message-ID: <tencent_E16C702F5D6FE89404EB76ED62CECC783A0A@qq.com>
X-QQ-XMAILINFO: MncAM2hB0zyG+ZMfnOOHhFZkUrQpgkKB9RarSm9o2uygkn7k/IQq3JMMQwICCY
	 00SCk2lWJEz2Owi81N7whfhNZV71a7Zn2j9THojnMmOf2YwYULv1AyYwhQoblccIerbOYkR0eQp+
	 r2yYiy6xCrU5DEbi3jp+dQVqyU3zS05+BmBp2h9lku8iybowwL8v7OnRjMN8jD07vcNVKYKk5eKM
	 COHCEy3sawps7ispIuHxtXJxmbIHo3ROpzI3bpFJMKrNv7QuanwO8UqSGeRVkanFteaTDY28ZBYc
	 FyVmSzj4cnlWBX/BQTXgmPRCas4WP5Ey8bbekQvKsiUDqZkEGdMbatAt6G93oI+0ysydnygb+U9f
	 9LNcm/GR0/vVudLEgKnMCv4BDTgbmv0tMNDJJWe4C4er/sVc8sHpjeiNNo6nHULL6kjXAnRImGt5
	 CyVYdGbH8HRok/IL2Sxux6FrtqQP+LusY6WwKmmFiWQ6LLvtVm7dbZv+Eig2EV3f1qlI3kJXyCqX
	 DlEiM8/JeLaB5rnW4EPiOeJ/9iM+Fj995LGFUllVxDQ2UvJ9NQTbvPWUv+A7396g40wI484lKwin
	 9fiNCwGjPAa2umKg9SWG9In78VuKCcDfXhHEpgeRstTTU5oT59RQyGUljLLlBLcXsS8pAXW91xvD
	 8Ne1VWd3oIL2pUiSJTjS91A0V3j3MBAUnQt9gmF2zsY6AyPetp5hPJZnem43RVokNDRMyh5fCbCn
	 lWAlKvASrJXaAhe676cDdEtQMXOllRT0JTcVU2iBb8ebd2r0KS63MAyqTUHFYpGxI06mxP4y3EAZ
	 ulnGYbWXLQqLRkTjQrBvAjWiqHscnuv9mFHYlZSDaAXKaoCM3tK928XFDvVAIX8qOacvdvrxWbFe
	 1GtaagTIOo7gNMvowwsiJRfkvgODuBObUAAPxIcvpeflDl7jPN2myAjLWGLlm6WwZFUSGLiHN9
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+05b9b39d8bdfe1a0861f@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [syzbot] [ext4?] [ocfs2?] KASAN: null-ptr-deref Write in jbd2_journal_update_sb_log_tail
Date: Mon, 19 Aug 2024 20:31:59 +0800
X-OQ-MSGID: <20240819123158.3198404-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <000000000000742b9d062005fc1c@google.com>
References: <000000000000742b9d062005fc1c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Journal too short will cause ocfs2_check_volume failed, and will set journal->j_sb_buffer to NULL

#syz test: upstream c3f2d783a459

diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 530fba34f6d3..25821077b855 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -1077,9 +1077,11 @@ void ocfs2_journal_shutdown(struct ocfs2_super *osb)
 	BUG_ON(atomic_read(&(osb->journal->j_num_trans)) != 0);
 
 	if (ocfs2_mount_local(osb)) {
-		jbd2_journal_lock_updates(journal->j_journal);
-		status = jbd2_journal_flush(journal->j_journal, 0);
-		jbd2_journal_unlock_updates(journal->j_journal);
+		if (journal->j_journal->j_sb_buffer) {
+			jbd2_journal_lock_updates(journal->j_journal);
+			status = jbd2_journal_flush(journal->j_journal, 0);
+			jbd2_journal_unlock_updates(journal->j_journal);
+		}
 		if (status < 0)
 			mlog_errno(status);
 	}



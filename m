Return-Path: <linux-kernel+bounces-293855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D347B9585C8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102ED1C2474E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CA418E04E;
	Tue, 20 Aug 2024 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="izX1EA8f"
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4602518E02C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724153178; cv=none; b=DgLjB0vGVrb+Jepibo+zlGbcOD4S7tsObTyuiX81ZCKwbhvs+Ip186LnIbF1nmoi1smqY2xhg9yFcUwvVdJBdQkIafBr6YDG59Ay+tPUCrBmSKij+wwiXUTOcGapNhaGEeIMhzNa51PWjrKXvqJj+/13qZnHcLQ+h7v5uLlaZfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724153178; c=relaxed/simple;
	bh=ip+CEKSaMxuYYC01SpBBkat6YpLzAuViN4pacIgc5Gc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=mNvJGDnAhk4+xhuPDVwQCBkt3T0XZ/Lwrt85tpbO/TqNLu+KaV2pqaPbpzwD7/7OkmTNezkaVGVBILppr1FAiKee1tFZ/u8ilo8gV9aHN1nb3HdfwbtlPXf4o4Q3wuxg/2ogsp3S9s6DjR6Plc0EVPuNrPOExqylDnjqSsF3j+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=izX1EA8f; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724153172; bh=DwcKdhf2PDcRijKKZe7TlJjkkMfCvgeE2ej0FKdO3/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=izX1EA8fyt7EkfYXPOp0lvfTerio7ZwUcWvRNhnC+e7bJ/g71aovJbvk3mrtgNtPK
	 AIUExGu07xRjnS6vECxxms9+MY9vDCyVIo+nv5NZI3YGQcSggnFoirLP54c0KjEkZ0
	 3cMCdtpaUgj0an4L6MC/QccY8FCmHl7inBjCIQzI=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 4F93F4D9; Tue, 20 Aug 2024 19:19:57 +0800
X-QQ-mid: xmsmtpt1724152797t965gaeso
Message-ID: <tencent_152025FEBA06BB5533C69ED71B124BA11B08@qq.com>
X-QQ-XMAILINFO: MesT5uKpDagVQNTUsbvt8zRfPz4FVT0FJupFVoWdz6ecnseWJAK5L2QxkuykFr
	 78WgG3TkL51c8jx4qcDTuqZfWQQOAUL6Y+TBH3+Hxm7S/wvgui5VMJlakDdnxFAydsqDq86XAmfn
	 d1I9H4VtVMNSQDE/iZ4NDub37uvIxdkDiz4F2ZtYXXNje7bZFpehr+rswB905zgd+R8kF14lQG70
	 qlr065petuxsBVyn6Ug9gqQLRo4ykY32LBgEnwHWhbb4V+OYsS+OG0IXvSoZ1Zi6cZDj1PyYLu00
	 7/rJHPDUOXxqQo3rP+qADNsLC4w2k2jgibB30yf84Jp+L8TGhjekLb55Ns/BeFSPsWC6g4uC8H/x
	 dKpHBCv/y3saeltlGpLsXo2iJX5I+A3nDFuk611/aq8y6fjCu5FStLZpEgC/ufY3Bpogi+QJ7b5a
	 nS3Ip581GQ9Wyrv6cKvVl3lsNiFjILdmcZvfV0YdYr9o+ScN93Fb1at3b5UlX65+hzHwpovHYrv1
	 BNZB6Pm0XSd5ZTwhPlmV7rVE8nhkG9OVKwt2iK2yedaBW/0fOtXxKib2eAvRJo6MAvVMK/q5a5z4
	 APDpqC7gb4EJM6U0Xa0N60xqPUyrgE95dXbrpvpTLvgRFZWgeVy1rwGMqbwVPaDi1rQjXToMvQQG
	 t7c+VYYrOaRKVI2M+1h0UandLM6jpWBefYdrnaCqBQclOKkHvZ28Pz8BZ21jIRPXO1Vp8ZZVFK3s
	 gCxAMr7kAu9fn3/bnZCMwHVW9j9iyM7D/3MsJnSzEAT/YEDVNaTWl9d7RRUMhy16e1LnqIZz0osC
	 7OuFafSpYkqdqk5duE06Siyuihw2lkorSpdf4Ff854qwp3EBbQfg6XYvmGBdJkZuisdLH8RMM4o0
	 nOdjNdaNFF7RPMwdOvsSJk9Xp1R0zb62b8sdD6D9WVPU6uzFD71wQ=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+5a64828fcc4c2ad9b04f@syzkaller.appspotmail.com
Cc: jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	mark@fasheh.com,
	ocfs2-devel@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ocfs2?] general protection fault in ocfs2_prepare_dir_for_insert
Date: Tue, 20 Aug 2024 19:19:57 +0800
X-OQ-MSGID: <20240820111956.3905944-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <0000000000005894f3062018caf1@google.com>
References: <0000000000005894f3062018caf1@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i_size_read(dir) too big, make limit overflow, cause last_de uninit.

#syz test: upstream b0da640826ba

diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index d620d4c53c6f..c308dba6d213 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -3343,6 +3343,8 @@ static int ocfs2_find_dir_space_id(struct inode *dir, struct buffer_head *di_bh,
 	unsigned long offset = 0;
 	unsigned int rec_len, new_rec_len, free_space;
 
+	if (i_size_read(dir) > OCFS2_MAX_BLOCKSIZE)
+		return -EINVAL;
 	/*
 	 * This calculates how many free bytes we'd have in block zero, should
 	 * this function force expansion to an extent tree.



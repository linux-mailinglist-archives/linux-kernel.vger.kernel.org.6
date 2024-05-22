Return-Path: <linux-kernel+bounces-186065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1A58CBF5E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5F91C2108E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4764823C3;
	Wed, 22 May 2024 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ZiPHCXrT"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D237823CB
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716374564; cv=none; b=fwU9SlJFT2Q/NM/gdPZH8E79zx3WD+HdYqwSSp9UeHE/fukTUsmnjDpYqTJtkAk3sDcDYUgkZNzdhmsA9//LknsznDvJ3smotsQsK3jNozMjyFWQoyK4lPf3zZWRpBVHN6ir9+KARveW9KdU85pkT1s+LiUiZYtWfJ8bhsxUHqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716374564; c=relaxed/simple;
	bh=Q7mt6SEDV74V/sWcKYgQGovQph+NX/2+dvUkxUuVVgQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=p01EDHmQ5OO4g6tPSKCa9KTQB6DFY8S0zb0TU3AoGYCeKu/9YENcAurJXdywsBgLNMwbohckLpZYEDwq6yQrhFt9TpOb+QnkdtLqSsTMbRpQtLulJ+ZhdyuVvDKNKtx5L3KKYts5V3jSJ9G92vL/jhc2CiCUwkg2YVvcshYuqPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ZiPHCXrT; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1716374256; bh=//B4H6k4q2guLm8x+8aMNL7vMnHQ6Gcoas3TjGr/WV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZiPHCXrTwJJlV03QHpzEkdTHeHGvKsPj1jiqN1fgjwciWHyQ+SpnPfabYAEzWf7n5
	 uL93fplRQMCekND9NhpqZn0HuuwPZUU9CRQ8wZqOLt3VoIOIOxA6gRvgsbqBsw01+u
	 yyYJkUsm/JXene1TrLF61m2hyMtJprzFyNRRtiG0=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 963118D2; Wed, 22 May 2024 18:37:35 +0800
X-QQ-mid: xmsmtpt1716374255tmbv1k070
Message-ID: <tencent_768996EEEDAEDD0CB127C786D9D2CA064906@qq.com>
X-QQ-XMAILINFO: MW5hkHoBpWXyN8YAOFjOboLa7ZM64hSbsfg+8j6OcTJVQ0nksqYGvyHKnxahiW
	 EXsnU8miIawXsIMi26t0jcC55K3OfaH/is6hHFByM7KthkBlaqwcfT3Pc1E34wuQrg05d1/kjEPY
	 PJedUcDIJaq7opSMknq4tlEOE01kNe7TMA5O4gY9C0zXuxd2xTD6njgvWDv/d/LTGG1nEUTdpreU
	 225gIJdmHWJ4pCMcS/ud2SUVZg9VM1joEZfqtCrtZl+ix6O5HjNnLGCZSPYuSuSIWUv7IEZwl05h
	 T4X0JC/Nd6ovFaF3bD60xI/RITYL4C9XZtYDjtwmPTQZdzPphbFRcgsmaU93jsUeZF4J82I65J6C
	 eKnC39Gs+K24WF33bnbhh5Gt6dt0QT0VzRy2HEzoe6raR6IvTs3gR14VLMtXZX0W2AFjQsSEi3Wv
	 xb7nzfTumrpT30YgAUclK9EVLwOiWunMjmvwPiaRWsPPgmk+3C5xnY/PuTEdbF2EhKaRjeGNNFyL
	 RM+STueDe6STYjHJem8EyVrAbeVbZE1FZOpfl1BoFqRKtuLSBNemU9rQRFXZ0IgsC64ol4cfwWJd
	 HzdX4ZET+pKdx5xDIiCbRpbSESuqoQ/FsWDvUNPPhmivzjcWHYLC5MwsedbaVCAJAki45bY1M3LF
	 Ztz8UlwICZLUU2cx1UEvYbpioBy7XpYoQFnjgJ6UmyuvgzTW1JCg9IHU5B1CHNdZ4Ev6KOwi0L9I
	 TLXDsyyg9NsqDmSIuSd74Eahz6VXXXLjK9sVCDJBTEl9NslZ2s7JfcilyxwoREUMhA34mTrVacoP
	 TyVM8XALdA/6xFYDrBy+Upx+gjiCJb/N8xfSNxgAswB90WjWstI5AUTY2IL9ior6hN9uzNm1bhPl
	 ltGGkoRxYON2zA2miKfH90MhgpRC52Lz3KmW4OOM+1RFX+SCAUMsP3OMi80RVk8KgQYbpb5G4mJk
	 Xki1LEebw=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
Date: Wed, 22 May 2024 18:37:35 +0800
X-OQ-MSGID: <20240522103734.2146269-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000002fd2de0618de2e65@google.com>
References: <0000000000002fd2de0618de2e65@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test null ptr in iter_file_splice_write

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 33e02dc69afb

diff --git a/fs/splice.c b/fs/splice.c
index 60aed8de21f8..4dd684184572 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -751,9 +751,9 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
 		/* dismiss the fully eaten buffers, adjust the partial one */
 		tail = pipe->tail;
-		while (ret) {
+		while (ret > 0) {
 			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
-			if (ret >= buf->len) {
+			if (ret >= (ssize_t)buf->len) {
 				ret -= buf->len;
 				buf->len = 0;
 				pipe_buf_release(pipe, buf);



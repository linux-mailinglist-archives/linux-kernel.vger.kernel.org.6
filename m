Return-Path: <linux-kernel+bounces-567105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3110EA68153
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 01:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49D688278D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 00:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AB51BCA0F;
	Wed, 19 Mar 2025 00:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="YMPzI8dC"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E11A9B5B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 00:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343348; cv=none; b=DtgKyFe1ay+4+uaA4XvAXF5NSD6C0k1IjP2/974SVii4mn52EhsxygVUXa0eMUXSHgFfUtjkxgfzSGzGher8uD/U+oTnttecJfL5cdWryESntgDg+1o7kZ8ibmjX+wtI9wcf7XiChPYEn3tZZ3n8fr4jAoegkdhP7t4F3SuEZ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343348; c=relaxed/simple;
	bh=5PCOzmacR5yYFup3o8g8dQwSPaboFM0aGB+HiTMI2DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmjqB5Ek4Z+kmnNt9EtWSQz2phCgxKjIEVcZZRDJv1fmQkqzlvRNwWfo3IbHmjBZU8vhjSo3Cl62yt51PrNDOBugQMbqHtriqBduya88DFJuBCoNmb+toZUc3jdsKmZSOOvjAL2kk/yXoDZLBk36AdCO5xDjwLhRooXaK9UNGMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=YMPzI8dC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224341bbc1dso119939455ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343346; x=1742948146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+Q0E5apPluO3qX6mmuEZ2SRhcKnzs7kllQ/gSC8Vl0=;
        b=YMPzI8dCZhmG0Jgrf9/z4ds0YcgMu4ROkPE9Wwm8zEbNQbTxIZakULjVeXB/WrXl+f
         m9Xf2ZWsM5ytUURf3JCxWr8GSMeMG9JXni/Zod7xJ40W92K1dPyhWLXmUAmwmAjY5WoO
         rG7RgM+Qm5FLNMSZ3wgnazMpZRemKFcKlKPuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343346; x=1742948146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+Q0E5apPluO3qX6mmuEZ2SRhcKnzs7kllQ/gSC8Vl0=;
        b=uW0GYbLbttGjNPjOCtgoz+rZ/ceC8JrSdRiV0bgKHqtsiQKwBAXPZoWdHCHB6RodUZ
         qJr9FGhqD4acxNz6ce/YflpEUn7hLsu2NkdzKXBzo/UmTHMVzGMTgr7mxMXQ2WhqWGA0
         E7KSnmz9gkqzhpv0iWTErt6YK3ZxG0mg6dkH1c5QYuXiPoTzquPHz2nvUlVNNqa23d9y
         KqZFvPRD9IaTHwaf3nn0+puAPj84WtCbwJlvPMTNRI3uQ/gIa5pQ1eC8tR6vxuB3JWkx
         1s4E5+fjGsYGyjmssy8JPClVO+wvSyIlmK8ydThgg+hKp0auIN3OOjztF49fybtAMJwa
         P3UQ==
X-Gm-Message-State: AOJu0Yx+fjSmHtmq+V1ORbePKsBcFIZKyHqMUQaToS49Cm/iBmwaxEP6
	YWoYq0m0ybTqqKkv1czE3JkFEYq0PsXhjxhO3SQalYH/aVVvyZO9mLcV6Alb0m8=
X-Gm-Gg: ASbGncvX2EnNdtj0K8Af9YuA+VR6yOs3uWekBPy2SbqLPUWvmTyJzVZj9llE8SYrtKi
	SLHlQLMTzY5lwFfojs0qZnD4jGA/zrDv6aQsspARghZnDdVp1ohHCUYjSP10oaoeXSLsi64+XxK
	4aToQiCAjoXNxpUIttdslYTsmvjEHxdzYtasiTBqoBX+nHfe4ECYEBcuKYLz3YBIdsyxW7LGeEz
	A68KJyTluRIcXjXRlSr7PvLvvrDdZcUefooOE2vM4yCbvjz4zA4MjaFwdMeAIJhvYVWiN5Rij31
	SE51uDLU3ihrJOakMY4Oa5W5B6dB1mDix0WS2izZoce3GuHkwxJrpNgLvum7Buw=
X-Google-Smtp-Source: AGHT+IEOR8SkYAUNB17u62ljjwaf2hFD6D0NrcmHhlERldyKjuA2Rr70AEoQme8oc1Ybx9thwa9WTg==
X-Received: by 2002:a17:902:f646:b0:210:fce4:11ec with SMTP id d9443c01a7336-226497ffb08mr9977165ad.1.1742343346457;
        Tue, 18 Mar 2025 17:15:46 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:46 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kuba@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	mingo@redhat.com,
	arnd@arndb.de,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	jolsa@kernel.org,
	linux-kselftest@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [RFC -next 06/10] fs: Extend do_sendfile to take a flags argument
Date: Wed, 19 Mar 2025 00:15:17 +0000
Message-ID: <20250319001521.53249-7-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319001521.53249-1-jdamato@fastly.com>
References: <20250319001521.53249-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the internal do_sendfile to take a flags argument, which will be
used in future commits to signal that userland wants zerocopy
notifications.

This commit does not change anything about sendfile or sendfile64.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/read_write.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index a6133241dfb8..03d2a93c3d1b 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1293,7 +1293,7 @@ COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd,
 #endif /* CONFIG_COMPAT */
 
 static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
-			   size_t count, loff_t max)
+			   size_t count, loff_t max, int flags)
 {
 	struct inode *in_inode, *out_inode;
 	struct pipe_inode_info *opipe;
@@ -1398,13 +1398,13 @@ SYSCALL_DEFINE4(sendfile, int, out_fd, int, in_fd, off_t __user *, offset, size_
 		if (unlikely(get_user(off, offset)))
 			return -EFAULT;
 		pos = off;
-		ret = do_sendfile(out_fd, in_fd, &pos, count, MAX_NON_LFS);
+		ret = do_sendfile(out_fd, in_fd, &pos, count, MAX_NON_LFS, 0);
 		if (unlikely(put_user(pos, offset)))
 			return -EFAULT;
 		return ret;
 	}
 
-	return do_sendfile(out_fd, in_fd, NULL, count, 0);
+	return do_sendfile(out_fd, in_fd, NULL, count, 0, 0);
 }
 
 SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd, loff_t __user *, offset, size_t, count)
@@ -1415,13 +1415,13 @@ SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd, loff_t __user *, offset, si
 	if (offset) {
 		if (unlikely(copy_from_user(&pos, offset, sizeof(loff_t))))
 			return -EFAULT;
-		ret = do_sendfile(out_fd, in_fd, &pos, count, 0);
+		ret = do_sendfile(out_fd, in_fd, &pos, count, 0, 0);
 		if (unlikely(put_user(pos, offset)))
 			return -EFAULT;
 		return ret;
 	}
 
-	return do_sendfile(out_fd, in_fd, NULL, count, 0);
+	return do_sendfile(out_fd, in_fd, NULL, count, 0, 0);
 }
 
 #ifdef CONFIG_COMPAT
@@ -1436,13 +1436,13 @@ COMPAT_SYSCALL_DEFINE4(sendfile, int, out_fd, int, in_fd,
 		if (unlikely(get_user(off, offset)))
 			return -EFAULT;
 		pos = off;
-		ret = do_sendfile(out_fd, in_fd, &pos, count, MAX_NON_LFS);
+		ret = do_sendfile(out_fd, in_fd, &pos, count, MAX_NON_LFS, 0);
 		if (unlikely(put_user(pos, offset)))
 			return -EFAULT;
 		return ret;
 	}
 
-	return do_sendfile(out_fd, in_fd, NULL, count, 0);
+	return do_sendfile(out_fd, in_fd, NULL, count, 0, 0);
 }
 
 COMPAT_SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd,
@@ -1454,13 +1454,13 @@ COMPAT_SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd,
 	if (offset) {
 		if (unlikely(copy_from_user(&pos, offset, sizeof(loff_t))))
 			return -EFAULT;
-		ret = do_sendfile(out_fd, in_fd, &pos, count, 0);
+		ret = do_sendfile(out_fd, in_fd, &pos, count, 0, 0);
 		if (unlikely(put_user(pos, offset)))
 			return -EFAULT;
 		return ret;
 	}
 
-	return do_sendfile(out_fd, in_fd, NULL, count, 0);
+	return do_sendfile(out_fd, in_fd, NULL, count, 0, 0);
 }
 #endif
 
-- 
2.43.0



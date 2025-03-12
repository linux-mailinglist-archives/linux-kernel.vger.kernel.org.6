Return-Path: <linux-kernel+bounces-558479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFC5A5E67B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C145716C7FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E0D1EF09C;
	Wed, 12 Mar 2025 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="aYQejKLd"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FA01EF370
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814578; cv=none; b=N5DD+wtl+UML5p6Juai+SEApT9bjtoc4AtDojJCa1H+TgrToW5b9Rf2uJM/9vLlYJvxvHQA1CkgwMQoQVkTPpl55UvtE9FDgTKoAD8jN5HMSQn34H65UDl3gLBFpwGbc9z6IOemHRHB6ImZIc2RGbG9NCMeerMvkvflc8MLRc/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814578; c=relaxed/simple;
	bh=mvIFvWIp9NnNpqjlb78s7uPPK/9pOen0F/aXj53TS9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmTSagEwQ2cU7IJjryhI3JOFUWyBFhPyzJqbMM09M8x+hpEYDNSYrM3xG5Zz/wXzjkMeHK9G+pXNheyYsg61GaqQ+rrZB+63Q/zbPtdYKyOkVXwReWKW2a3uybwC1xni8uofjT3v9RzD7qlD4fu2OXT/AWPA+Z9p/P1FGns/c5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=aYQejKLd; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C340A3FCCF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814565;
	bh=JJCUu0nnTlIAwhQtLazst1i1S2GtJ41RAYnP5gniTzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=aYQejKLdGr5ExUmspDdnU4wPFXdH2B9XIl3jyJjix0AkrBK9MGcHnrPzRAu8tUxiD
	 CgXF22FNABlCdCQFPRkIuncmGmy1MC2ACreWoVAnL4hUfkdlb6R5PNo7hXHZ5exizm
	 nLJqAVl8zkEerBQidWAbFE061ZVDq1+HFicGaffj/wZ/1XyXXqr7ckr/I//oWYPfhY
	 PST0r1MN8uJoG2WOyw1/4gYYr8RLnWvVe4f7K6fJrf/qhrVIF2JtQcojxe2sVjJssG
	 ngO9tp/zB0TVsprWPMtZTdrE4MoIjrgFk+CTIUNt9FIacnlsZwjYuxIpr3Mn/P5zC4
	 hitZsvYit1t3Q==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2235a1f8aadso3652775ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814564; x=1742419364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJCUu0nnTlIAwhQtLazst1i1S2GtJ41RAYnP5gniTzw=;
        b=I1ieR1htzdgd7kY2GrsMH7VOxry5Z0EyC9ALBbGGuHuXA9a/W5d7X6Gu1DDC6kk6sv
         d2z+vSZYzV5dOiUJejcPwOytjsufIpyt/TcKdmIPkgrShFieYxV1wUk7z9HcED3SmTkd
         SeDbAbgYv6FuSjHvQPrCbOCZehrePxZaKdvrW0qdWDnVYlBDGdf0eoffhHTpw+7oEHCl
         vnG3Gczb7BxE3cswp6j1dMtPqB8h2LIPYLl8nwXMzQLgyrfE7Qno1d1dma49ggIF5b6z
         FIWD5JUPXG3QYHpHRzE3s0zlTSUYiMcepwcH4zIfn+LrJZEIMvELv8cNE7PIhcQRVgne
         RhHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCRBiskHxhdfi2iInDJxmI+lIeMOgsWiEcOBw2egvr+4A4Hx8SFAw+5BCM3CvCxvyp4vcbr4aexCQpV+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4cIaSfdhts5o0CTiwNnSHRtGlrUZ8oh6dFntjglJz6Z9AROd7
	Ojt442NwK2cZEdSGsb7US/8MkTN1qWKTVNLv5EIUWZF7ltVdtcQ+Fi/tNponFodvSFrdMXGYUz+
	nicpNZL9jBO3tlYKlauN6R0m18DJyJAiyixAfg/tZlTKUZM2e+46kWYOiAS53fia/EOAlMiT8dA
	P2Ow==
X-Gm-Gg: ASbGncttW6g01wobhi9eYQCtskS0ND30B79awDhtRTMFjhVTuXBYdMpE7jbUds/ui7f
	ucjk3R++vLHf3jbKd0pz5CZZ04c4EfCh1vwlCkgfIJjvq/c/jFTnhApLj+AA+mA/26laikTxTN0
	82y6zBQOKtJ2ad50BtCg0yh211yGSjwoBtVbAr8L/kkQkI2J2y9pjYt+Q2YnneFAFxbxX3w8ByB
	6n94aXf9GPMyAKnH95g5yJyzzm2v7E6fSG2RqrOfo4XD8uxeqgdajoyL4fr7xjtRt8dCw9BM+ep
	b8LWHbHzUxZXx1D8UQiicKwcJoromwDNPX5LE71pTMj8l8TgMVbOmnmQYNgT+N/3DTEGg+E=
X-Received: by 2002:a17:902:ea07:b0:224:a79:5fe4 with SMTP id d9443c01a7336-2242888681cmr334106825ad.2.1741814564403;
        Wed, 12 Mar 2025 14:22:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjVvzREwSOFKw0Hfsl/h89sadLsPdTTQZ/I/XFETV/GwxC6RNVuLWxGdk5FbZ6Djc3RCsmNQ==
X-Received: by 2002:a17:902:ea07:b0:224:a79:5fe4 with SMTP id d9443c01a7336-2242888681cmr334106495ad.2.1741814564101;
        Wed, 12 Mar 2025 14:22:44 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:43 -0700 (PDT)
From: Ryan Lee <ryan.lee@canonical.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Cc: Ryan Lee <ryan.lee@canonical.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 1/6] fs: invoke LSM file_open hook in do_dentry_open for O_PATH fds as well
Date: Wed, 12 Mar 2025 14:21:41 -0700
Message-ID: <20250312212148.274205-2-ryan.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312212148.274205-1-ryan.lee@canonical.com>
References: <20250312212148.274205-1-ryan.lee@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, opening O_PATH file descriptors completely bypasses the LSM
infrastructure. Invoking the LSM file_open hook for O_PATH fds will
be necessary for e.g. mediating the fsmount() syscall.

Signed-off-by: Ryan Lee <ryan.lee@canonical.com>
---
 fs/open.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 30bfcddd505d..0f8542bf6cd4 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -921,8 +921,13 @@ static int do_dentry_open(struct file *f,
 	if (unlikely(f->f_flags & O_PATH)) {
 		f->f_mode = FMODE_PATH | FMODE_OPENED;
 		file_set_fsnotify_mode(f, FMODE_NONOTIFY);
 		f->f_op = &empty_fops;
-		return 0;
+		/*
+		 * do_o_path in fs/namei.c unconditionally invokes path_put
+		 * after this function returns, so don't path_put the path
+		 * upon LSM rejection of O_PATH opening
+		 */
+		return security_file_open(f);
 	}
 
 	if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ) {
-- 
2.43.0

base-kernel: v6.14-rc6


Return-Path: <linux-kernel+bounces-563077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E041A636BA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D857188FE99
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 17:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EDF1C84C9;
	Sun, 16 Mar 2025 17:13:56 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A07A18CC1C
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742145235; cv=none; b=bBsLfH17oFG+rVG0kG9N10bghm8VeDdSRw9HGUTfFqqtYaUXfn5QgF71KfIEL0SUkwu/lQ697xaYorswWYKzAG+5MoOBlCUc3Ks46qWIBM7Nmiwtb3s3ObyRzcwcwOPMqu+8cTB5wBm3bNxggWJYF1PggMDuhgBXPUtH3ojkv9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742145235; c=relaxed/simple;
	bh=H3PzNC3xIhl0GKYFcLaLS3yXa7lBJR6UI7k7WiHNrxQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UuLWFdlkV0p0cCaGl80YEsBycyLC572vLlWbgpOcsgOlRITbErEpOGpYt//b8ZRWXqUO8B00qhdjbFlZMYL2hD08SELFxNpTmY9F0CJaY5POIYsWfJ48z0CT9RS25zvyHbxKqUXOSa52LiNiQWROF/6RYdh1usTzogUVpeIRi58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so7040165e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 10:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742145232; x=1742750032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ODFreraoz8xwp2joxLm36YvpQAUecMaSczh29u2bx2Q=;
        b=FAUIoFa2LnlI71KH5W6EPZYB6d+j5kpDyyeUn0V9uxped6blS7tTvoXqVmr3uJvtNN
         r0bxAyPQ9OUvyjP3v5B24f+rsZxouCOaLgBCi6eR5cBkfFyqaqTNJ+rQwomRMAqpVI2G
         9catIpLO0367floAt/KBYS+O8R3dfdzwd0kCAZVuncZZkDPiN13HfS8cQfVmtGMZmdEm
         soD4GZhFjsxP7fMkiZeN0W0cJKTvoVtFH7NG4i8Y6q4F5tcku2qETkqB9gnaPHHNiuvd
         dJZr9uzRk2tO7M5OIlN02CGY1x4+yooF6lqQO08FwNwGv8pfgK62zVRPyYUTeS7Ese6o
         HcWg==
X-Forwarded-Encrypted: i=1; AJvYcCWm6enEWY1ul75uADDCggzGYsz0HJjBctd/+xTmmYayxMZn070x5gzGX+T4gYfDl033KloAhMYmC1UyI/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8j3iohAFKVh/PLQDdm5bHzwp2WU5ytLcPBqykIWiqMCCWJOrP
	Ewd4mvuwrMgCsBEPfkdFj1yb5OQCZlFUbTm14wpc4QQ0ltp8F7Q4
X-Gm-Gg: ASbGnctTISwYcfvspzKdvuEs2IxI+9qS5ySthZwDDNB4V1jDxclfMiKhVHWmDMYjbfY
	04rs8CkVXQg5eE6wCL+AdfgUgStt7VhuBpYhKXARLiUEg0fHMe3GwYMTeGSr7nDoChHqROHMvpd
	9Phpt0zjVghTjEAg7z8p3rCSDYNRiy0sg+TYxE05PatdmuQhoiq/M7rAQbGoBNQyJD6qj5SNDw0
	QUAYcWadR1REaSy3gIw5BvAc5dDrpnahxjTnU110Lpt2Dh35IKH3Kpm4Dfu4s0H8JDvD84KTw1+
	astYc69+9zMKX4IE57bUuXo0egd32wfj8oGhntAS81YISd9guX9DhPamSsaCMtIBZwxWgw==
X-Google-Smtp-Source: AGHT+IHKuP5+vQc6x4mhDI88FsxmG72BjhDZ4E8pdkihbSnqCpkKlO9BKPY14CWSEUJ2bjCrA5DaDw==
X-Received: by 2002:a05:600c:2191:b0:43b:bfa7:c7d with SMTP id 5b1f17b1804b1-43d1805a5b1mr139878365e9.2.1742145232088;
        Sun, 16 Mar 2025 10:13:52 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a041:e280:5300:f8dc:acb8:77bb:8cf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe6a1c7sm82007445e9.39.2025.03.16.10.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 10:13:51 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] scripts/tags.sh: Don't tag usages of DEFINE_...PERCPU_RWSEM
Date: Sun, 16 Mar 2025 19:13:32 +0200
Message-ID: <20250316171339.2989591-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For each semaphore declaration like
DEFINE_PERCPU_RWSEM(x)
DEFINE_STATIC_PERCPU_RWSEM(x)
ctags generates multiple DEFINE_PERCPU_RWSEM and
DEFINE_STATIC_PERCPU_RWSEM tags for each usage because it doesn't expand
these macros.

Configure ctags to skip generating tags for DEFINE_PERCPU_RWSEM and
DEFINE_STATIC_PERCPU_RWSEM in such cases.

The #define DEFINE_... itself and definitions of semaphores are
tagged correctly.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 scripts/tags.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 98680e9cd7be3..503371e59e366 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -271,6 +271,7 @@ exuberant()
 		ACPI_EXPORT_SYMBOL
 		DECLARE_BITMAP
 		DEFINE_{TRACE,MUTEX,TIMER}
+		DEFINE_{,STATIC_}PERCPU_RWSEM
 		EXPORT_SYMBOL EXPORT_SYMBOL_GPL
 		EXPORT_TRACEPOINT_SYMBOL EXPORT_TRACEPOINT_SYMBOL_GPL
 		____cacheline_aligned ____cacheline_aligned_in_smp
-- 
2.48.1



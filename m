Return-Path: <linux-kernel+bounces-204060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 983C88FE3B8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4C4FB2D3C2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8C617F385;
	Thu,  6 Jun 2024 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oV1szKEX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2343717E91B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667547; cv=none; b=QKN9bPxMbYGSa66aAyY+ISxiEO/8sPD4HRU35FtegOY4aDb2kqPV/0AoV4Z4s4KBJzj410N9BwuWQBwZk8EoQ7RQcT3glM++RCoPfd7oDIg8/mKZAl9V8+5Vo1pCi+gpHo3KKrPJ8v6YrWfU/BXjtLPcuO777rqz8quLIcrEU0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667547; c=relaxed/simple;
	bh=1A4x52edkxk15o++tyYBiiibRgkm7p/CeiPX3AK72eo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ejhzJVyn61iJ8vDw/y5VyNJdzpc/CSDTilEaK4KgZFOH35iNkiE9T1TnrHmiv3lhG7elsLzKimAJ8nX5siISQJVOF30C23vSlT6khbdgH43HbhK/8SnaO3WP8IbqCK3kZQnhInpIzr0mLa/Wd8vS+qEn/PiQgCmDafhdmw2RNjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oV1szKEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FD0C4AF0D;
	Thu,  6 Jun 2024 09:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717667546;
	bh=1A4x52edkxk15o++tyYBiiibRgkm7p/CeiPX3AK72eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oV1szKEXx6PIDhSbDwjHlwMXPTlD3x5MY2IXcNWWkyCBSwTAi4TTEqjoO82yl/M3V
	 wexutYQvf6Us0ZnAb3IVk5F0DOHvq/HHBJc3K0nqvJ8R4Ls3xScHAUNMQEt00vBuTO
	 qJ8zEjiMTFZVKYGKoFBPDM7j19NjNhiCuXhjhLhOctvqM/mVCxdHgNkgi4rV8B/dV1
	 wpQ+PC1TYhkRcOFGap0X9agTgBsi7kcRlDcGw1vRCmssuziSfF06JYLnwrHny7C1aM
	 6cIF2Ta+qHN05PRw+eXQvw+ZrzNCmalA1PDUvlbwc1Qt0Wu7h5yRQSw43g21/b7rOK
	 73qjGvTanl74w==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: fix to use sb_{start,end}_intwrite{_trylock,}() in gc_thread_func()
Date: Thu,  6 Jun 2024 17:52:13 +0800
Message-Id: <20240606095213.4087668-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240606095213.4087668-1-chao@kernel.org>
References: <20240606095213.4087668-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since background GC is f2fs inner operation, so, let's use
sb_{start,end}_intwrite{_trylock,}() instead of
sb_{start,end}_write{_trylock,}() in gc_thread_func().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ef667fec9a12..004587ac5530 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -76,7 +76,7 @@ static int gc_thread_func(void *data)
 			f2fs_stop_checkpoint(sbi, false,
 					STOP_CP_REASON_FAULT_INJECT);
 
-		if (!sb_start_write_trylock(sbi->sb)) {
+		if (!sb_start_intwrite_trylock(sbi->sb)) {
 			stat_other_skip_bggc_count(sbi);
 			continue;
 		}
@@ -163,7 +163,7 @@ static int gc_thread_func(void *data)
 			}
 			spin_unlock(&sbi->gc_remaining_trials_lock);
 		}
-		sb_end_write(sbi->sb);
+		sb_end_intwrite(sbi->sb);
 
 	} while (!kthread_should_stop());
 	return 0;
-- 
2.40.1



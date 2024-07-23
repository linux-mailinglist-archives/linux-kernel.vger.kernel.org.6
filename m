Return-Path: <linux-kernel+bounces-260406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B35893A880
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 23:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BA51F2367C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2797B143C5D;
	Tue, 23 Jul 2024 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="O4ew1vA7"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D671C13D538
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721768891; cv=none; b=BQyM3mYncLewx3V8PuqvVWIIlfWsdOUr5cu6eEZiHG+ghqpfNS7oXfyVHFDtmyuVfi5yt0Mr58zyhszOArVV8uuFWUVZivuK5lBEV9xPrBDAk3crn0BfNlzPPEjpg39v8D5NKLBIYnSYFlSqqvZ3zxHbf4QS9YCKHqeTj1m/+do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721768891; c=relaxed/simple;
	bh=88YayfHdkHI4GN1UZJOCGz/CycqTDikmNcIa4M/drCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMGbkdWwibUFlcvA4cpMCfkGijFaSWJcgZeBQX7boN1h82pTpF84NtfRjAO1HYtz8d/giAvkH9DvN1ChVN8G+LjtFWFu2NQEOqNehrE8imA06QHNVCMr7iaTyD+GlI2iWpenVOrgIAR0iL20CD/vGWFxe2jejP1ARjRHtumdw9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=O4ew1vA7; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so43422766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1721768887; x=1722373687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u32Gi1HBTIN6jyH7o9cSO9SUdKOXL6u24i45pPrjUnY=;
        b=O4ew1vA7T/dYAQhYbB564/9nMvzhInqgIMCLAOE+xFhyd7sqdGmVaX4G8yuqe1JFBQ
         8n0IAuYxro13yBYY+8W4MPCUtiqXZJtstvsj1Lu3JVfB13s9X8rE1Sualhw1DZgubGR6
         D79SZioEhVO3VTwXnASto59A5Dd7du3Q02D6JWBzGi0jOyKgDQZHrbaCGZpoMt9Do5re
         bbYuzWZ1eSO9NFa1d4s2EVJ276dBGvRaqx1wU7+Fd7LXcFz8jsUdLLf2ryaHHSf5g2Ah
         aX7Lyu27A6ITMCCh4F8NXy8D9IM+sZ8bk86f2g4NJ/07xvvVxe8L1B6zbo5Iw3kiQZlV
         GdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721768887; x=1722373687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u32Gi1HBTIN6jyH7o9cSO9SUdKOXL6u24i45pPrjUnY=;
        b=dLvkA2qE7DXS63OGOf3Xx21daFnUA7i8gBxKDgLGEUWHHKKF3smEXAQPz21u56Dr+H
         UlGKsD6dRDlD8ZDy1S2U8inJmg1/xLrEsdgPEnrLYTDbWeM5vtiDj/o7DRXiHjQlLKMt
         JC2TJZ+uhD/nMEbd8Z//awUmlhgqcMoBHoZABHk7p/ioQbo6ZHBL0xIviA0AziywBbi8
         ApDK6un8WYwRtLNGZfoB8EoGQVe0qjtEAcw5vE2VmW5Rw2qBw7jm9fAripGkiaiV9CO1
         Si12zZrH1A0C0Rbad43hPE5T9rMp6qjbZA29VIcnS9uwfFQSiJMPFd/8atExiTZEhFq8
         Syjw==
X-Forwarded-Encrypted: i=1; AJvYcCXTjplI5+x64pwHBMYUnHLjuH43dNfvlq2/G6RqR0hJIkcGDRvQtbybVfv5jrNbN7fKpYrORvNGrzCzQNr2prDXl703gHjTg4ccacDd
X-Gm-Message-State: AOJu0Yztkxx01Bh1V2IgOoADrqBIYfMNkqpiJLVLE+fiNkGFYAfdRnXs
	dPAQmSwXZhc7Dqmu/1Oj+mop0mBfvVx2ZYLNqYZ3qxH9oJ/HXS0XSLqZ5ifT5Oo=
X-Google-Smtp-Source: AGHT+IH2uFhwirb98UNhSBCjyhF0G1QHQorzmMDDf4xlmwnMKySKL9U12nw0yGBLsa8k3V36yIEsAw==
X-Received: by 2002:a17:907:7d88:b0:a7a:aa35:409a with SMTP id a640c23a62f3a-a7aaa354714mr80052366b.68.1721768886969;
        Tue, 23 Jul 2024 14:08:06 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6af04ba00bd1de83dc7c21243.dip0.t-ipconnect.de. [2003:f6:af04:ba00:bd1d:e83d:c7c2:1243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7aa7aea927sm45471366b.5.2024.07.23.14.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 14:08:06 -0700 (PDT)
From: Mathias Krause <minipli@grsecurity.net>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathias Krause <minipli@grsecurity.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] eventfs: Use SRCU for freeing eventfs_inodes
Date: Tue, 23 Jul 2024 23:07:53 +0200
Message-ID: <20240723210755.8970-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240723104348.645bf027@gandalf.local.home>
References: <20240723104348.645bf027@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To mirror the SRCU lock held in eventfs_iterate() when iterating over
eventfs inodes, use call_srcu() to free them too.

This was accidentally(?) degraded to RCU in commit 43aa6f97c2d0
("eventfs: Get rid of dentry pointers without refcounts").

Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Fixes: 43aa6f97c2d0 ("eventfs: Get rid of dentry pointers without refcounts")
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
 fs/tracefs/event_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index a9c28a1d5dc8..01e99e98457d 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -112,7 +112,7 @@ static void release_ei(struct kref *ref)
 			entry->release(entry->name, ei->data);
 	}
 
-	call_rcu(&ei->rcu, free_ei_rcu);
+	call_srcu(&eventfs_srcu, &ei->rcu, free_ei_rcu);
 }
 
 static inline void put_ei(struct eventfs_inode *ei)
-- 
2.43.0



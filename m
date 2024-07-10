Return-Path: <linux-kernel+bounces-247629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1EC92D230
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4D91F231D0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB1419246F;
	Wed, 10 Jul 2024 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dAWPH7SA"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7AB18FDDB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616623; cv=none; b=qlC9Nwipy0qRTQtXF+EeMzjR7ER60MdX/RW5sja9Dn6HRA/eXTLtoOeEzoYQwZ85inIwbrX97k5jewRTQ10rBJ19KoVZ6b4oRMqxjrS7JVaHDzWIg0LcQkzEJ83BA43n7lpZJ4Tdhzk+Ej9RJuprRrImZ9rs98Q6rMWcjKd6wi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616623; c=relaxed/simple;
	bh=u4xe50Y/QnZQ4d7+yhyKPuJj8WeSEb6DPqcYwez31JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTEcgVxWbiUjfekWVRhsP1AEqzA6T/EnNkNO9Lnln+/lSL+EByVtg407G59wW/G/6bYke5dhyrhcThmE/3zuDwy8ksYkZi5IYHJHNbxD81F/8NEn/CAqYeyIp01GNs8XVND2F28zRI/WL0kucAKtpI9Zv5MSv3va4I2ROlFyiMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=dAWPH7SA; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-36788bf97d4so161000f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 06:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1720616619; x=1721221419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWYvLutVvpNPgBageJj8H8A/uQDi1vyHTGEzq9IVLnI=;
        b=dAWPH7SA9zj7+TlYREoMYWujdKZJsCadj6LW8Ulhws8E5LHkPLB6zJYwiY7UmQvleL
         wZ9SLP+G6uGlqQ244smnTgavyPaqnZ3vIyx+ovUTOPatznENuUBpKPtC9ckfK3XEyKhf
         cNfoewKFykklA6rnV14cYHjO+1OhByX9EEhkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720616619; x=1721221419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWYvLutVvpNPgBageJj8H8A/uQDi1vyHTGEzq9IVLnI=;
        b=nLqp5U5zth6QGAqj28TiMpsUvH7VvQqKjPndaGuS81SFStTEgJfZav0i+nbGu7HMuS
         1Z7qpLXA7gMsIhD56pOwKcYwpcnFZ6obosV4Pzdt4Yz/24XA/cQv7b+2oVMJzLrvVdIX
         /ZBepqbiLXq+A4IFPh+zWGKtQ64c4rXOvcmgJ77TSXDODGCKgSrSrmFWiK+j6GjApH5q
         Pt8ROxKq52Ot6f2pEkEWb0yr8cupizCtvtDRnY2QuWUs2I15ajGnmzRRQbCnTTzJFMkJ
         n9TRIbnOOOUFXbJh303pbVLieptC6AW0IcMkHnVGA76oyiQ+PFY9jzw4NZ6TbN3A9FNr
         F5YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyMQ5I/sSK9ltsluUCBPekgrqV14DzP0aeYagYOcuvR13TMFtnBWKNn4zzJTKaa3eA9PkwmCNAO3pi7sj39/fWqyWH4q6kBFyH5MU6
X-Gm-Message-State: AOJu0YxzNN44S9ugtcqvmM65yOBWh9oTABg2MeXfRLVIwxest+KJcDwB
	UhkiqToYcjFwOlZ1GAh0oXYlG/NouHc1RCJJdOnoIHLvP4YWyOod7h0vsM0JZhKlOI8Rmiui1GK
	Qp7Y=
X-Google-Smtp-Source: AGHT+IGMcjQoU+OYezjQTf52YHxfgUBSeAFV3/pCB994d1Y1agNCF9MxANmKp2bdSG8HgXlodZdyZQ==
X-Received: by 2002:a05:6000:4029:b0:35f:2f97:e890 with SMTP id ffacd0b85a97d-367ce5de46cmr3793723f8f.0.1720616619170;
        Wed, 10 Jul 2024 06:03:39 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa07dasm5249869f8f.87.2024.07.10.06.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 06:03:38 -0700 (PDT)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	syzbot+6cebc1af246fe020a2f0@syzkaller.appspotmail.com,
	Daniel Vetter <daniel.vetter@intel.com>,
	stable@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] bcachefs: no console_lock in bch2_print_string_as_lines
Date: Wed, 10 Jul 2024 15:03:35 +0200
Message-ID: <20240710130335.765885-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710093120.732208-2-daniel.vetter@ffwll.ch>
References: <20240710093120.732208-2-daniel.vetter@ffwll.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

console_lock is the outermost subsystem lock for a lot of subsystems,
which means get/put_user must nest within. Which means it cannot be
acquired somewhere deeply nested in other locks, and most definitely
not while holding fs locks potentially needed to resolve faults.

console_trylock is the best we can do here. But John pointed out on a
previous version that this is futile:

"Using the console lock here at all is wrong. The console lock does not
prevent other CPUs from calling printk() and inserting lines in between.

"There is no way to guarantee a contiguous ringbuffer block using
multiple printk() calls.

"The console_lock usage should be removed."

https://lore.kernel.org/lkml/87frsh33xp.fsf@jogness.linutronix.de/

Do that.

Reported-by: syzbot+6cebc1af246fe020a2f0@syzkaller.appspotmail.com
References: https://lore.kernel.org/dri-devel/00000000000026c1ff061cd0de12@google.com/
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Fixes: a8f354284304 ("bcachefs: bch2_print_string_as_lines()")
Cc: <stable@vger.kernel.org> # v6.7+
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
--
v2: Dont trylock, drop console_lock entirely
---
 fs/bcachefs/util.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
index de331dec2a99..dc891563d502 100644
--- a/fs/bcachefs/util.c
+++ b/fs/bcachefs/util.c
@@ -8,7 +8,6 @@
 
 #include <linux/bio.h>
 #include <linux/blkdev.h>
-#include <linux/console.h>
 #include <linux/ctype.h>
 #include <linux/debugfs.h>
 #include <linux/freezer.h>
@@ -261,7 +260,6 @@ void bch2_print_string_as_lines(const char *prefix, const char *lines)
 		return;
 	}
 
-	console_lock();
 	while (1) {
 		p = strchrnul(lines, '\n');
 		printk("%s%.*s\n", prefix, (int) (p - lines), lines);
@@ -269,7 +267,6 @@ void bch2_print_string_as_lines(const char *prefix, const char *lines)
 			break;
 		lines = p + 1;
 	}
-	console_unlock();
 }
 
 int bch2_save_backtrace(bch_stacktrace *stack, struct task_struct *task, unsigned skipnr,
-- 
2.45.2



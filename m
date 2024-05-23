Return-Path: <linux-kernel+bounces-187260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D4C8CCF1E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDEDF1F239F7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F015213DDD9;
	Thu, 23 May 2024 09:23:59 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B4A7E0F1
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 09:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456239; cv=none; b=VvV3rcB50c36t7pE35jjNF/HhWusodJ2/4S1B/SsSt5Q9oqWfJS8YTsrczqjpmYTYkUtXF8VQxNBVNRW5/8OQlQBPflsWnSMrKQfX2XlIqGowZcxyr8yZyaAiHPmDRCdfoLOMTqPADcym4zLYEdUpPmNm/IgDZcZXvH0R/0mgkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456239; c=relaxed/simple;
	bh=i/kAXeaeveQl/LhDEZFxa/tIpqb06WoJDHtVFQ3cVDw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GhkhtsHo0/2k5ADQrp7KQRUfkIBhxqjagn5qpPYtIVoHRMWnNyQUNWMAhZhjlYa/Em9bzXpDeAObs72MzQ3qMymawoZVli70MU2EPVG9JXI7SQkkG5fLgOzWUU4gAH/7QrY4VivIRb+KkWmapeT/kl2z28PbFIrxPzQHhuvOCGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e1d122f75cso134421439f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716456237; x=1717061037;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/1v5n2ho6exAPz3FqoiG3p4pmvbzpXZz0rxeJDjWAU=;
        b=N0b6jVlWodWRihmSPtU6T9VBxzEC9SuIzER4CaRPpkWz/41anukiO9rTzPZFBMTS78
         LYrB5/o4nCKB0HQuYlpy/SOgYagpKalOCQC5aM2NBdLiW2gzq8NT0hT0Yw8aB/4iKGcr
         B+LiZmGQvvvrUz5UmRW2iVzfpTHQCeJM7mS2de0VrkPF6CgnsRzbu5DKtPUPHqKxkhzl
         O+CYCgK8pgTh63AoLZCyUNVPQxzAnarqSSobQ11nzv+wq7/KlaFv81cx4uBt/pJep+PZ
         Q69P9qgldG5yx7GZpHTDiCMbReye1MrSKlD1fDGLZB0FzuZe1T3tuBmtr5gZQOjyzL0Y
         1lDg==
X-Gm-Message-State: AOJu0Ywm/IiGCyD6jYOwzfTJlEinCTVeOoTAOus/F4Iyf1os4sQ2AAva
	g5pY5qXYmqPjgJKKsRPD9k+ETjYNhxAGD4cWSqRbxDtAkTS1FpjJO075rvMq+IXsBXcMjklLrCm
	UDWghp4jdxlp3v9MxgQvTsbPPIfb+UNZflV8rNwoBf3LsFUcIbi0M8cs=
X-Google-Smtp-Source: AGHT+IFUCh5BM8oHCC8THlCOM74vYit9mGhjDkgWLUq+RZ4DlbrKCG8UA2TEguWMf1ILblN8bA9aDpKp7pc91yWh82GgotRDB+s0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8619:b0:488:59cc:eb41 with SMTP id
 8926c6da1cb9f-4afe3b2cac9mr173780173.3.1716456237240; Thu, 23 May 2024
 02:23:57 -0700 (PDT)
Date: Thu, 23 May 2024 02:23:57 -0700
In-Reply-To: <0000000000002fd2de0618de2e65@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b237106191b9c7a@google.com>
Subject: Re: [syzbot] [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [fs?] general protection fault in iter_file_splice_write
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 33e02dc69afb

diff --git a/fs/splice.c b/fs/splice.c
index 60aed8de21f8..35a99fdabe9c 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -751,8 +751,18 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
 		/* dismiss the fully eaten buffers, adjust the partial one */
 		tail = pipe->tail;
-		while (ret) {
+		while (ret > 0) {
 			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
+			printk("ret: %d, nbufs: %d,  buf len: %u, m: %u, t: %u,ring size: %u, bufs len: %d, %s\n", ret, nbufs, buf->len, mask, tail, pipe->ring_size, ARRAY_SIZE(pipe->bufs), __func__);
+			if (ARRAY_SIZE(pipe->bufs) <= mask) {
+				ret = -EPIPE;
+				printk("oooh, %s\n", __func__);
+				break;
+			}
+			if (!buf->len) {
+				tail++;
+				continue;
+			}
 			if (ret >= buf->len) {
 				ret -= buf->len;
 				buf->len = 0;


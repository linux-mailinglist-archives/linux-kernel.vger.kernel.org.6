Return-Path: <linux-kernel+bounces-188189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF388CDF03
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 02:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B991F22138
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 00:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE5B63B8;
	Fri, 24 May 2024 00:52:32 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3DA2C9A
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 00:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716511951; cv=none; b=ulBjspm0Ze0C0TmcgrAIiFSYJLgNFl/H4XerHePUMZDa2ZT9XpEb1S5KpLYIv77f3DFrzpd8JW5xp8xsCOYAWXfb0MsQiS1NrnCVNHezlT6N4vkP3/+Y8zTTtmuast2jya775aFWKTK1iqIb4yBSJjRc3+3SMuyiFwshOnySvA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716511951; c=relaxed/simple;
	bh=I7O019psKEGle+OG7y2urx2gLjOC2946l4fIEZV07WI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rnNajAdXQdUGlEYf+ZlDP40wJig7i5Y1dzuqNLwEbItmWNbkT+NzkAL4GSZpD3MmpBKykKC6UvOQepcVb9EnpgGNrcj31zJ47tp3IWyG2vr2tVdH/UO7D9QnA7ydVBcaWGAWXYcJA5fU4QuPWZcO76UK0iDGirIZW38GYq1b7aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e1db7e5386so274120739f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 17:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716511949; x=1717116749;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MvU6koD8Z9tSFRE5Rf0IPguMeWjSwmeZ2kwPyXce6X8=;
        b=ma4VSMkt0sQKbxxsru8D6Lq4tlXi6hzIlwr6n4YkU32BdDLXh24upkOF/p5zTaldFN
         lgKU0jLFPtS6YffJNidK8eAcBV5uAYq0HFRiu58/nxyHaWxYeyKYPMyNK94qH9Il1eU4
         +B1PbyQACLKjgNjSXvWBnvTC8v66fq2OjJEE7ts3enPQVhfuKZF1agvSxPXqSdCUTvlo
         mcr4LDAd6/iLbpY/OFyHzZ5BmruBtFsVDU5+OsB4CAPUJRCD9vLaMlXz4PSNutT/NUar
         jEZvau+CIYCA2MtV1N6AI2y/VAp1voHFx5Du0FAMTbZXCzgxv7BUNJnqLe1Ij+EgNF+Y
         6Wkg==
X-Gm-Message-State: AOJu0YwU8/euSzNuuRYMaio6fK38xtGz+ZUVPR1vxic64gPURsdgOhcd
	uBDE3Thmh6egenR0QlrczmLphiAOhRVZxWwscBX1+wFn3FcaRhx+Iu/DiY7YAa2asICxAl3bBPg
	MXHCqBMdodzRnBwUc3HL+kb4Hf0gjTDno/sPRywN13N+s6FPEspNnhds=
X-Google-Smtp-Source: AGHT+IGse8OAmrov/Zp4iHTcPoGBDdSdrBNlqNjOtP7oph2iWz0mEKq92nUnbN023+NlboencphSeKNUSHBk7kAjCOqQ2A7G3F5a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:c98e:0:b0:4b0:3631:7257 with SMTP id
 8926c6da1cb9f-4b03f6326a4mr18780173.1.1716511949520; Thu, 23 May 2024
 17:52:29 -0700 (PDT)
Date: Thu, 23 May 2024 17:52:29 -0700
In-Reply-To: <0000000000002fd2de0618de2e65@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000112a20619289539@google.com>
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
index 60aed8de21f8..2df64a29c568 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -745,16 +745,30 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		if (ret <= 0)
 			break;
 
+		printk("ret: %ld, total len: %lu, %s\n", ret, sd.total_len, __func__);
+		if (ret > sd.total_len) {
+			ret = -EINVAL;
+			goto done;
+		}
 		sd.num_spliced += ret;
 		sd.total_len -= ret;
 		*ppos = sd.pos;
 
 		/* dismiss the fully eaten buffers, adjust the partial one */
 		tail = pipe->tail;
-		while (ret) {
+		n = 0;
+		while (ret > 0 && n < nbufs) {
 			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
+			n++;
+			if (!buf->len) {
+				tail++;
+				continue;
+			}
 			if (ret >= buf->len) {
+				printk("ret: %ld, nbufs: %d, buf:%p, buf len: %u, m: %u, t: %u,ring size: %u, t&m: %u, n:%d, %s\n", 
+					ret, nbufs, buf, buf->len, mask, tail, pipe->ring_size, tail & mask, n, __func__);
 				ret -= buf->len;
+				printk("ret: %ld, %s\n", ret, __func__);
 				buf->len = 0;
 				pipe_buf_release(pipe, buf);
 				tail++;


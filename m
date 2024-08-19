Return-Path: <linux-kernel+bounces-291332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4EB9560FD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133DB1C2124C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568751CF83;
	Mon, 19 Aug 2024 02:01:11 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805BB12B8B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724032870; cv=none; b=dEHBx3ZCujsytAI25wY+0ydzafrRRMwWfGWGNMASTZuZjZZ6TgD3EcIVbDWhjYmIu+KFNSyKnIwYUfqybXqNSkF0eFk0l+mnxyt1eXmtu+5/32s1OehsuUajfGYFeSvPrQJvvpp1OzAJUvMPgHhtn9ipjNjfMFUwE7U7f43XHWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724032870; c=relaxed/simple;
	bh=OgWOCT4Wjlm+HV9ebpkjY4u9pBTOUIOFipDgA4B67mM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UkTuawZkM97s6G4g1IiVBEhOKUk4vqQ4Od8zLJkt2fj4EPAb1ug5+h4XjRJJKfDY681eBwvfR21cCzySXD2gc+jr8lpFY88Oxsq+I61UAxydAvEb9piltPs/lE2e9K3k6SrCLiNl5QmBdfJq5mgWyOlw6bSpq6P7JHd5bapK7So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f9504974dso389766339f.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 19:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724032868; x=1724637668;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+QNJpId+oyT1kDC7KAhEmCmOfaeqxQcEtSQX5RD9F4=;
        b=VVCVkojmMILcJxbDz3mC/ngDpAQm0BPz7nMDFrmdQ8tDt2geCsMOn/c0Dkr0PFyVqv
         tFvRw4jNJuczX4AYlp2bD7r1M/FWhzomSFFOZ5nBJfON8AGKFLZxg8nNfe9PaeK/DI5F
         uKlEGuIkzWCw+6t4l3nOKAuUjCNvH+CPqSlDyNKOY7cmkmU5k9nXmJCHqFquYsUY16oT
         uHviW+NL2br5ety3Z7+UsKtSW2plWQGukfvxhBio0y5/2GLtQLg3GHnBBuH6cpIkWlDo
         wvpawU2KX55tI0w51hYo2/DNtyV/iVD2gFMZ9VFKYFdDEtdPDLv0k8TotNtfB9PjHB7J
         hzTQ==
X-Gm-Message-State: AOJu0YwStVo/MRQO3VUljXE2ir0xPB2jM5vM1sjag9+uN443tIT+//0A
	7bgwDDRiq3Xsm4l8W6KvIoCy2br2JXe8x82DqRU5vtKK7D30B5IOrj1NnVbgrxGl4RaSRJMxBrG
	5Z4KstHTylUC0DL7YckSiBJA+Xatb8c5aiDb26PkFqBMN/+FDoZR+71Y=
X-Google-Smtp-Source: AGHT+IFbsrvqWxtPr/Z4SBXtgLE6QDy61uc0rX9JF0PAMEObOP0dLEvbOcI89pjz4fAxsz2jXLvs6pGxl8y/bjUw0HsPpsjaXZ9s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1316:b0:4c0:9a3e:c260 with SMTP id
 8926c6da1cb9f-4cce13ddc5cmr690545173.0.1724032868676; Sun, 18 Aug 2024
 19:01:08 -0700 (PDT)
Date: Sun, 18 Aug 2024 19:01:08 -0700
In-Reply-To: <0000000000007541d9061ff83615@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b81092061fffae2b@google.com>
Subject: Re: [syzbot] Re: [syzbot] [ocfs2?] WARNING: bad unlock balance in ocfs2_read_blocks
From: syzbot <syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [ocfs2?] WARNING: bad unlock balance in ocfs2_read_blocks
Author: lizhi.xu@windriver.com

remove metadata io lock when sb getblk fail

#syz test: upstream c3f2d783a459

diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
index cdb9b9bdea1f..e62c7e1de4eb 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -235,7 +235,6 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
 		if (bhs[i] == NULL) {
 			bhs[i] = sb_getblk(sb, block++);
 			if (bhs[i] == NULL) {
-				ocfs2_metadata_cache_io_unlock(ci);
 				status = -ENOMEM;
 				mlog_errno(status);
 				/* Don't forget to put previous bh! */


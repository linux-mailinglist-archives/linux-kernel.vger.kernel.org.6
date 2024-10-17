Return-Path: <linux-kernel+bounces-370120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620F29A27F9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F8F4B2D261
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AEF1DF727;
	Thu, 17 Oct 2024 16:02:39 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D811DC739
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180958; cv=none; b=d3fzCcRs/aifdsW/el83YHyLzRSzcJTv1Voobc6ATqhgaMQ9t8cF2wW7WANgyPqiYxpuOaPJn7MAEPVZ21mZ2W32JzPUjE06domPSkrJ3VZURp4FwHvfdibDgnOTa8QaLs7Klhs0UUiDlv+fglW59CCNzlnKxutdUdAP6J+FMBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180958; c=relaxed/simple;
	bh=IhmXxwFE1W3iQ7RKcEmuF0YnanDkLpO90m76aOS72rg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SKOuRtvPFsa9LNRiu0OZheu04a1SJKGnX4ih22RCDnrLUMjyUQSWU6odtXt4FTv4kGOv5ZsOwCTJBQ+ssVHflYHnigmFd+G1TqzjM/9eQH6PDkiq3VKttvPiuH4LJ6pM/NFy2UB8W9lswIAl+4/zYUAcUn5TsE9bssUw/I98Z8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c90919a2so12430415ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729180953; x=1729785753;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tF3WGESUr0IlTRBqxh80woDaYSEW0lfn1aUjqO7oAsE=;
        b=A9hSYlzyHjPb00jJVmcQEMvMUJLjJqf7vD7WgLbVi0qlTrJMMTXvYgTHDe3PKCUa83
         EKhJX63lTNPBQULDNqisPximcy0o6CpYg2Zii6mSqIbxTgT64M2h8fTlAELogBE4zn89
         DdsiF4VP15Ki/fEV3kH23prrlPgIZZjZJL+EwOixoGeOAAnbG4gC5Tqm46DDV2rKR2h9
         hgZMRBJsrXe4a7Lyc4aV1VydPOZUTBGml+Qi4rzF8ia3ee5djnXMLgzh4u04rgKFc8MB
         ceEHNO4e9hwzC9cyqQca6WFcDjxm2ID6pv+q4iIDuLH6Dt4kV8IAwcbAFtT7rHSaJA8M
         WCMA==
X-Gm-Message-State: AOJu0YxBpqg+VswLkEFGdG21ntoSHxu3M6AnJx4gxi46SBb/x1SZnUfY
	OgeBy0Qqf0xJfFQRkniR1rmUHO9h3hOB0IHl5tUw2U6eDNEDPqv+CvWRouIJp0w0saSqEDu59gK
	T4G7soSPYPJB7Uqjot9P7nNUyq/QOqEEwwdnUpo13EeMuMCvyxQEhZmI=
X-Google-Smtp-Source: AGHT+IEFumw5iTfXO1m0CI5BwHOvSTxU1waEuBqNFKVBJJzzo7U60O6bFlp8m9WwT8Z/QD2us6zd2mNlmPfTkqYvYf6oRhdsTENp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1906:b0:3a0:a385:9128 with SMTP id
 e9e14a558f8ab-3a3dc4a71c6mr78170195ab.6.1729180953029; Thu, 17 Oct 2024
 09:02:33 -0700 (PDT)
Date: Thu, 17 Oct 2024 09:02:33 -0700
In-Reply-To: <670f8e80.050a0220.d9b66.0163.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67113519.050a0220.a68d8.000e.GAE@google.com>
Subject: Re: [syzbot] Re: kernel BUG in __block_write_begin_int (3)
From: syzbot <syzbot+d6ca2daf692c7a82f959@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: kernel BUG in __block_write_begin_int (3)
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git c964ced7726294d40913f2127c3f185a92cb4a41

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index fe5b1a30c509..57108bd90e8b 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -483,6 +483,13 @@ int nilfs_add_link(struct dentry *dentry, struct inode *inode)
  got_it:
  	from = offset_in_folio(folio, de);
  	to = from + rec_len;
+	if (unlikely(to > folio_size(folio))) {
+		nilfs_error(dir->i_sb, "bad entry in directory #%lu:"
+			    " from=%zu to=%zu size=%zu", dir->i_ino,
+			    from, to, folio_size(folio));
+		err = -EINVAL;
+		goto out_unlock;
+	}
  	err = nilfs_prepare_chunk(folio, from, to);
  	if (err)
  		goto out_unlock;



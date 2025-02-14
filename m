Return-Path: <linux-kernel+bounces-515561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ED3A36643
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5DB3B1239
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6721A83F9;
	Fri, 14 Feb 2025 19:39:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BCB1990B7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561944; cv=none; b=KjEot4csouhJdujN0OjPvg8DvK6n/BdEEdkZ0fSe9MkCemwFinofrkyMXZE+1IYj/pHnxlmdlsovx8P/2yKD/hpJEpH/F4jQ3WL7NQRKHO6yGdFHdr8lnMY3Z69KbCQsyxILqtVfEtq2k+KntTcsVWryW7JEFfspydytptG5rdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561944; c=relaxed/simple;
	bh=pXL1QrYP756TmKDQBZQtuKBAdGFAtIf0OZ/LQA/bTIM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ovLIMoCREiS0VmAyBq4mxgmk8EJ/jGTk0LbpHEKPnHuhzuVkgq8q3+QwSSpFFG2ezenNWyNNS0KZHfgFuDw1ndhrm14HmHix6P6/zRuaJXdwSIrhQ3LRDRvd7H+Z0KKxplxOASxFarThxlheP2kkI39KTiOTtRVPv9A9AuBENuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce81a40f5cso39929195ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:39:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739561941; x=1740166741;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DpmcrP0X5CgyWJvMhCxkALSxzE630NH+Vj+9LCM22q4=;
        b=hIwCph9FlJlyCxtZMSakk3u9sIa1cWl7UtD/1ITiW8AIVZDfkQwMedvPpz3STUUE9k
         RhRcGKt44ysRzgYuOu2bsJ1ediqJLiZodbGarVhnRzHSNRQ5M8x6mIv8jiGQLxzOOW1O
         Ks2a12Kc1cZlatOsAgkoROiYSZvcVadhAHEkxqut9i4smTFN4Qutl57fIEIqVwSqVRw6
         2mdsNP2fs7X7YeAQPEH6DedIB555gIuaK0GcZ+7VvXrXj6Ojc8KAHwJp4CwrnJKPPFGm
         cesxMl5Sp0UIzXNZzQhsxhiyjXBIyFp0YnYYSqXxSIXSEdlVXMx4baqjEDU0F7EbgaIg
         6IZA==
X-Forwarded-Encrypted: i=1; AJvYcCUmMcNACSEQxTTGEfZeeLGHJDeSdv4+9ce/cUGZyQU27YQT9EoX14jf8jjVnY2TwRXCvY+J88ftjpFhufs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNE67NLvfK55yBo5KwxlrFM8boWFK0aNrlrOuB+TT/PNGLhOUg
	khncfbKnnY4NAYZ3ptZTs12xMEiw5mzYTMQZ/bXR/x0CK2Nr29XnZwMSrvsJBDnnwLV+zQv2wix
	H7kUr3yI3AD3vj6+kZfkIO/Kn4hYm9A39s5qPQMHyv3GHAC8LXsUZpvk=
X-Google-Smtp-Source: AGHT+IHwYKRLC3mbDJI+ep30XOHzdBQ/EyqbNlPdsQu/0k9zNZ8cqCjKXSehXJ+r/XjgakVTtETWIRwe+z/+nNWugMzDa7R54Mqh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c548:0:b0:3d0:24c0:bd45 with SMTP id
 e9e14a558f8ab-3d28092cd46mr6338805ab.20.1739561941685; Fri, 14 Feb 2025
 11:39:01 -0800 (PST)
Date: Fri, 14 Feb 2025 11:39:01 -0800
In-Reply-To: <6774fb7b.050a0220.3a8527.0026.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67af9bd5.050a0220.21dd3.004f.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] WARNING in dqput
From: syzbot <syzbot+bf75d2e9b63fe9e0c330@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, jack@suse.com, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	ocfs2-devel@lists.linux.dev, rgoldwyn@suse.com, sandeen@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 9be53fe697eccf45e5c37e10ffd399eeca5eb489
Author: Eric Sandeen <sandeen@redhat.com>
Date:   Mon Oct 28 14:41:15 2024 +0000

    ocfs2: convert to the new mount API

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15b68bf8580000
start commit:   ccb98ccef0e5 Merge tag 'platform-drivers-x86-v6.13-4' of g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c541fa8af5c9cc7
dashboard link: https://syzkaller.appspot.com/bug?extid=bf75d2e9b63fe9e0c330
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e5d818580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ocfs2: convert to the new mount API

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


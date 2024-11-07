Return-Path: <linux-kernel+bounces-399758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F529C03D2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962301C21DE7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5A41F5821;
	Thu,  7 Nov 2024 11:24:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5C41F4FB4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978645; cv=none; b=hjNFW+FKdClHi7m6I27l4oemExx18EAAMqEUef6DhifZOQ4tBRdT09alkm0dlfDJrNkwAPiEgcSLz6++bzoKzXa1ZNZb4jZA1i4RQJYZRtBIgxWthL+ZqUVYjCOlpxINvrIxc5onBkGw79RMAPBl+5YTwH7W3HzLpwrzVmMWdi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978645; c=relaxed/simple;
	bh=SJ5DaTFfA9NE7JO1TVV/AkfS+1CT0OW/Iim1MWeWxL4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZXfmkv+hQTKKffhxw30ZXOLzVkXLMWwZkHc8zFnHGKecQ3+JFZpnwTj/HrbcvZy1zShpmjX7UxZBHuQPV9Fi2ZdY7WS4zUJcS0TJeAEye4alMlGNKrAgH4g6BibNVStHQnRBuvSSKyta6YdAQHSZz3LLZShksG2ptaHJL8st2Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83b567c78c3so170143239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 03:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730978642; x=1731583442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/kuQX3VmdU3VvGHoe3B0rpGazcaxNvNoeaIsi40NWo=;
        b=i6WblMAU7k/VOFCMZTd1okIjFKmGyA/8wlvJd2AnlntQ0EBLU6lNPCidXmEIqF7ygA
         OO7JMcPBC7mMr7YcKTvoBC0OeNMtMwLuXugRMTzywWrDifTV16tRoX+mn87mUJ27WQ/9
         qHkpGrWGqP1ZjJl7PAtqAvUBkACcA2ru+XJRwqnSO0X2lriauHpRMMC286pi4HpZUYXJ
         BkRL3cJRE+vfg3QwIJfE/TfB71seKT9p6l/7tc8fhVW49jG89domHftpknfKwwRtRDSh
         KT287dRozwB1gdXFo2gJQ9NGTWzO1jg5uU/xaNCHLYiKJ65vhaCcj/xLFplQFM00p/H2
         gfUA==
X-Forwarded-Encrypted: i=1; AJvYcCWUcGb6vEMdQRmyHJ0nCG33p0S2cwHJknBz3BrAI3dNypO57Czg2Se2AsXqMhEPgD4FrDDQgubwGUcghZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOudV//CEgnvbc4vVgKpUi674/AjY/fq/z9/bFeA4+F/lK4olH
	LiSA2NPb/ncK31VqiEAWqD2z22o0VTgGfZZ/IeaeEFo5KPD9PTQSb9JPdx3cLgXR9VyhxEB7SwH
	SI6XSh32+J5yGRAvpDBkhS2JuxQQCrnN8/0k/TVpZM27Q/sXU2Ina4bg=
X-Google-Smtp-Source: AGHT+IEZMvGy+Rp/56yyZKCtVAevUqCgApOzY5XSVvj5+Y6pII/CzZ4rRBxjpyqjQ8+85SERwlGxg2v/nv9K9CyM5ptoFmqLg6gB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194d:b0:3a6:abb0:59a0 with SMTP id
 e9e14a558f8ab-3a6edc0d719mr6699605ab.0.1730978642648; Thu, 07 Nov 2024
 03:24:02 -0800 (PST)
Date: Thu, 07 Nov 2024 03:24:02 -0800
In-Reply-To: <0000000000008886db06150bcc92@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672ca352.050a0220.2dcd8c.0028.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: trying to register non-static key in
 do_mpage_readpage (2)
From: syzbot <syzbot+6783b9aaa6a224fabde8@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 1fd21919de6de245b63066b8ee3cfba92e36f0e9
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Thu Aug 22 11:43:32 2024 +0000

    fs/ntfs3: Stale inode instead of bad

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16f3bd5f980000
start commit:   d5d547aa7b51 Merge tag 'random-6.11-rc6-for-linus' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d806687521800cad
dashboard link: https://syzkaller.appspot.com/bug?extid=6783b9aaa6a224fabde8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140ddf93980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c83909980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Stale inode instead of bad

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


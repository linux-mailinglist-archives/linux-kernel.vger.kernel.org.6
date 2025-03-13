Return-Path: <linux-kernel+bounces-558791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F00A5EB2E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39EE23B810D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 05:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668451F941B;
	Thu, 13 Mar 2025 05:31:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953B38635E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 05:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741843866; cv=none; b=jgNzAPFOQgnOzwQCVFA3+zwuWl7+dJpRiTxKQT2gieB+ezhqEuLZQNmz/f/LLqeX1oJNAZ4iq/sljCWaNx/MwipUMlqvxbjkdPT+lC5XqjwEwdkPiyfAGMjiMhxmGq3OZUBzqylbeUZNTkubcvx2twEj7h56N7OOJoKpI9xeIQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741843866; c=relaxed/simple;
	bh=gBY9wu9hz+XDaKMeIeZ0b1DbatMefzpr8GKdi3voHRk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=anC7MgRKIsFG09MmBOxkbiDg5NL04KJEuUZBPPSJWbCQ7P9TUEtz74hKrj6fyl8rmqvBi+pUfGezmA6Wt1OY/d99ckE7JIXcuIHSbENTbzDze3URADtuGqz+Edfaps5RpA+dLJJ/DQsKJ9B8w5OYpG9ViKghufxlWCBbYSniFIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d43b460962so13206985ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 22:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741843863; x=1742448663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7wEO8hd49tqWTUyH2y49aMSolTRzK6iWaodtgNYGLI=;
        b=w2r8iMKz206qmicS1Nf3wIP0CId52bYlbDf2m1UikdAiTSZwX8/LPFSHE0my7/eof+
         oQe+g7BkfCfREx0gDyO9BjOXkOYbz0pZMy2Iz9pG4z1miru1CJ/RYQo/LJEQCmT/RFmU
         8aXMKKpckw9+ZNZcllnrneIaiempcYRbotsKRXRtYRU4CFabOR6D8VpyCGvqqL15MU3A
         E0nwdw+lw4sE+JuCWpXjws73zcl13qSWGxL7iILLWsc7DSsdZpQhkPBvioA6i9CtOixv
         Yw2O/T0RnfqYCdr1NphDsooQsp25zfIKDawjqxZN4CTzvNcTEX/fEOSWQ8p/5LE6oP0g
         8IYw==
X-Gm-Message-State: AOJu0YzlQDGgW9EsvxptTh6hFpty/1VSRpfZP7T3mhzqhsnyvIR5JVhF
	Sj35kksumgUSkEgru7Apgmuxt1Ot9GI/SZrIgZiUEcxeDg3kFudZLnEzhGo3pXKtzWeKLwyYRTO
	QOAE1DD7YWFYQEBlU6EsT80Q0IYnIzRViljnJ0U2PJhutq3EM81HzGsI=
X-Google-Smtp-Source: AGHT+IHhVSEIMuxGu1IOL8MFDSVmeocpEvkaIx6u7qdctJ0DDPwDmfPpIW31XOPH7dsrIUv0hgNptFjUHZiCad+qC0PZ8nPop1wS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0a:b0:3d0:4a82:3f43 with SMTP id
 e9e14a558f8ab-3d46890d179mr118103045ab.5.1741843863729; Wed, 12 Mar 2025
 22:31:03 -0700 (PDT)
Date: Wed, 12 Mar 2025 22:31:03 -0700
In-Reply-To: <20250313053022.1818259-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d26d97.050a0220.14e108.002f.GAE@google.com>
Subject: Re: [syzbot] [kernel?] upstream test error: KASAN:
 slab-use-after-free Write in binderfs_evict_inode
From: syzbot <syzbot+353d7b75658a95aa955a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/android/binderfs.c
Hunk #1 FAILED at 271.
1 out of 1 hunk FAILED



Tested on:

commit:         b7f94fcf Merge tag 'sched_ext-for-6.14-rc6-fixes' of g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5498c9c3175e1fe
dashboard link: https://syzkaller.appspot.com/bug?extid=353d7b75658a95aa955a
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=169b9874580000



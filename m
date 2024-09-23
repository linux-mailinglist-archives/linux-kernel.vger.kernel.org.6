Return-Path: <linux-kernel+bounces-336122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 896EE97EF76
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DCD9282864
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6014219F413;
	Mon, 23 Sep 2024 16:45:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7E419F116
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109906; cv=none; b=lH56qK2r88xVQzQTlfOpQ8BvHCa3Q6YvvvzlUnnvqtQ/QwCILJ9W0us/4VJtRMfRPleu5oYMSA3aUjqV5YJ5vBo2cRqNLzpSxMhaXKguojrHZmdsrZVvpg+HMLWfMe8GmmKJxFGCevpvf4AejraKaxUrSha4SEvBu4AObuW+72M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109906; c=relaxed/simple;
	bh=KTWpgZuNaM8xvQYmryb1hmYNfufXk4TdbyTbHkl9Et0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IZDdwfNA4xJHXNs3mRnxG8VhZVEh6B+k+uNnslI5NTNkoWhGj6dULG6I2LN1rN3qRjbAAiVrgXUVaQk/5qANp7Hz++JX44HKmx0zxmLtClhuNcpL3d6gyWLkVZPQepVhm0GqYJGbcy3QzYKw4mDlqCy9aysod0lrphJmnQ8I18E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f56ac8d88so67296715ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727109903; x=1727714703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jn1WmDlAQ8ckydAPtmL2xfUgW6k1S1+R3yfhEnGudI=;
        b=nrVnvKJpDi/egZg33MEkntAJHb922IVtb9UASxNGlLll9ipvm8j9tPdC2Bm2Mf90D6
         LimsqsxlyMehcONWA1z+6VkLbbvswrw326vnEhevoPQDB22oten8OwVB/RntcmD778Mm
         hx6r3TE1ssh+VeZMZNQ8ygl3WfULCVqLxhH/Ie3uOpp8RjGkhVrjxUHeF1ZVT7Um44yw
         +ii8CRoOKe/cmW5H9iGiGW+yWzIXiOulp+Yy7OzT/26N+4+1YJOiLdxeNkY4/WNzeLts
         aVphX9Y4UZ8dHQjZ2CG24PrI1PcYoioV2AybAFKWuS2lAn2M0HSCJaruh6ewR664yHy+
         uWnQ==
X-Gm-Message-State: AOJu0YwlBLsA8WFS9RuuDeVFUbptPwdFTeIqtEBBXBBVwmZ1hH/iu0nw
	gbK04p/UumOP1fdj1GIvokcbVyrRJBv4ot0WovzooNTlEX1epIzPTjSDyDMfSZcZaGlujtqxAcI
	X7Xu0tdTz3F820Crq1ywANn+0OnprQihvtwMky2uT+vVL6arMrhyQgjU=
X-Google-Smtp-Source: AGHT+IEaNUCVvUlM8eO6w4Qvzu/MwbPWXPTsihqCqZUEkbagEPK1HdMtKoyM3G4J/7L1oawxfhdJCcilaTn8n/OmFhRnwK3xAMB/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a1:b0:3a0:4c31:265c with SMTP id
 e9e14a558f8ab-3a0c8d4e6bdmr102752815ab.26.1727109903635; Mon, 23 Sep 2024
 09:45:03 -0700 (PDT)
Date: Mon, 23 Sep 2024 09:45:03 -0700
In-Reply-To: <CABBYNZ+Fj1bDqSG7PkF5OFEx_OWkgm2gEm8640odaQX5EBGxPg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f19b0f.050a0220.3eed3.0015.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_connect (2)
From: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, nogikh@google.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com
Tested-by: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com

Tested on:

commit:         de5cb0dc Merge branch 'address-masking'
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13874a27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=40f2e89a3d19f42c
dashboard link: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11bff480580000

Note: testing is done by a robot and is best-effort only.


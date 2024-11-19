Return-Path: <linux-kernel+bounces-414665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8C29D2BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290CB1F26ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31651D1E62;
	Tue, 19 Nov 2024 16:49:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BF014F115
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034944; cv=none; b=aOoKewd9ELWVqruFn3cgtAR1lLxIFmAZlikq22ZOZqcUhM7jm7Fyo6DgXNOeqIlukJBOwObX3wtcUzsrr+ptxY3Iu+7IupVWqoZ24QP6bDLM21gLwxhWTTQuHzpjng6sAvA+zkH4BpY12vYe8GWQzVhSm22DjDHk1KNfos0Zh94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034944; c=relaxed/simple;
	bh=ZzJxhzqSatvzvwvHRxNXBc+h3hrR4NovvDTZxrOxenE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RRCY5gM8i+YU+xNZg/m2WKovlLhbIOJ8uOScEvfB/2qoBjfZr9NPDoY/l6xGfetTWmPVKDsHXc2kaAd/dNUirBXDR3p4FNi6uOlwFtlCrAAxUKeYTrVt1GwpXuzd50eRvywUNq1ix4JWmqsxjssRZYndBvlylPwKYOvmFq/bw6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a743d76ed9so44026825ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:49:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732034942; x=1732639742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8JoLo6u2Y5rWO/3CkaBVmN1IPa/NZhbTXeOXIyBSUrw=;
        b=PqlbOWCtXYTuKYzWWn/SkALSFc+bEtFqhd+Ci3PIsDT/e2gNEUsWsklTFRKp3Gavzx
         JuQl9XzLOaCdVq89G5LMrDMEkzPqNKwEypSQvJRY49RcvCrTOMygNpcq/+fD0j+OfhjG
         kEH9Hdly0VM4pJ02Xp6YRY9MZQFVCuzjZLDv8QNvdmOax5G6WVDyxQ8qkmsVqtUthnjO
         m2hvehU4UtEoeygqJWkcMYgXuvVzbeXQ6bNocONNppMJV8QdXSmULnjdN7Cosh8/Tx5m
         upev/h/qjBbz59fzRwYxxwvJpafS2PXSdGaz8QSb5ZfUgTdY4BSExAqpTaP20cCIXCLC
         M81w==
X-Forwarded-Encrypted: i=1; AJvYcCWPr+hCO/F3dYaZX62DY5UlFpgHVOsspnRL3xgA3ViPosPvE0b8EkFFsklB++YSBDwBebcNl4L66zg7wRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkRoxtiZdyXkGb8JPu18Tvek9S/06jfY4y4N4lWPiXAv038YGj
	5W0YGJW03ruwGFlrcS+03cZWrmXg59K7JigHbPvQROr7fbbvkj6gsmmvOQlV/msklkyzZ9cQUm9
	wA2J9MVwHSG3hbHft20xngKqf5KbhDION/WR/d5B3kthZ9JqXQoGBOo4=
X-Google-Smtp-Source: AGHT+IG0PC/cisTwJJ6z0KRX9i9VDgSjrvTRooyXCnrYWmXg3ZAAWCWim+JAj7afVp5NLjsmaXAj3G12mprdtk5r2+zB0betT0Av
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e6:b0:3a7:319c:9351 with SMTP id
 e9e14a558f8ab-3a77745b352mr52377165ab.9.1732034941966; Tue, 19 Nov 2024
 08:49:01 -0800 (PST)
Date: Tue, 19 Nov 2024 08:49:01 -0800
In-Reply-To: <20241119162852.SnMnB%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673cc17d.050a0220.87769.007a.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_search_dirblock
From: syzbot <syzbot+b9704899e166798d57c9@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b9704899e166798d57c9@syzkaller.appspotmail.com
Tested-by: syzbot+b9704899e166798d57c9@syzkaller.appspotmail.com

Tested on:

commit:         158f238a Merge tag 'for-linus-6.13-rc1-tag' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17120b78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf11fa3fbde217ff
dashboard link: https://syzkaller.appspot.com/bug?extid=b9704899e166798d57c9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=174b0ae8580000

Note: testing is done by a robot and is best-effort only.


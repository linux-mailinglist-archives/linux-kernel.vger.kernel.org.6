Return-Path: <linux-kernel+bounces-381505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA009B0028
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A12A1F21CA2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9C31D9A4E;
	Fri, 25 Oct 2024 10:31:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E39718F2F7
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729852266; cv=none; b=TuWcvprQohxBzkF1nslGAfNjUFhdClJLY+BaqG2s4NcCSsWcYr76PKQ17L33pT+9YMjUwG2kJ2XtwvLq0ZcVWgDkzdGt1UZw+4sZ0NQfOG3BdWGIGUL+D9iWm2wzHb0XORZhDm+lJqRffPNbtbKxB3OVsYlf1a3O+7jUBhAEILs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729852266; c=relaxed/simple;
	bh=Ks9YukmsODd18DuIoqWPAwldy++arjEKcnYgqiDZk34=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NZPq8wYX9f4Adlj4m+2gN0eW3xurwGHizzRFdDfuQ38iHm5unkaZCevDGlvkrgx7PGIqxujFfpg5s4mBG5RiCDWexeuo3zFW7lnW2NIgLEZW5ZsMB+LMtMPy50q9NLe9t1O5O+8xLJy6HsV8vzvmlH9Jdf6CJCOX/HnPfedc97A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83ae0af926dso182609839f.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 03:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729852262; x=1730457062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSgMWLlIt9TfQivIQ3WnN+tiBQW0fVmjjbR6xce7TQs=;
        b=mdZZlStPFgaumCwiZq2k2CHyO1EiDJwjFXUNS4gW2B8Vyy7mK5Ss9/nBQTW+F/NqBd
         Crt4JIBz+k1CCmYlLCoHi3ooGJOW4mUmX8g+IvIZlGRVTLWUb3rK84665hoZXqfpUr2p
         PNWnJfF/hcXDonJ8zGZmLuxVHMdFgIMhT2Y4Un4usaRq/2M202UCJh26libo/Tm+XoW1
         uQa/9JegUNuxc+Turi5SP+0zo13upNHa1GHodT+4Ao8AM7Jpg6O6Q959iFGTXuV6+lVR
         RLg/mwq91wvIcbmv3puoQdF/NnkawtOSRmCeUROfRE1X96+wfKJlf7vdLAnFuiADWrnk
         EOXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5Zyi+IL+UG+6w0pmswxL3OjtPk1FtV/DYMheX0os/DFQxVGDCH8q00oHikFe0qMAk2IkO3B95cnPWzJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpArwDaN+bMTmiPW/bm73dgztwG1Z9ZOn+mCcVFjLKTOxelr7u
	lZCmU9SK/h2jvwOu3264aVv/fewCyPDvqha2ZR7Zt2whXDh0n1UGH7pjNBFshuXDo9b6bnQ/m7q
	l9ri+QbMlLjFtbDZm8q6luw+IFTb+rkjeVXey2Ss/REyeNLZSZlFZDpk=
X-Google-Smtp-Source: AGHT+IGo7N3Bcp4JM+Lb4k/uPu6Vy0AQ7J82f6oah50o+OjnMbX4jogd0YWlH8Khx90cKsfLfL9i+aNQWQcejvsFYejUdt0LfZrf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cd:b0:3a3:67b1:3080 with SMTP id
 e9e14a558f8ab-3a4d595c67amr93937395ab.7.1729852262534; Fri, 25 Oct 2024
 03:31:02 -0700 (PDT)
Date: Fri, 25 Oct 2024 03:31:02 -0700
In-Reply-To: <20241025100205.635960-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671b7366.050a0220.b833e.0002.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Read in bch2_reconstruct_alloc
From: syzbot <syzbot+9fc4dac4775d07bcfe34@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9fc4dac4775d07bcfe34@syzkaller.appspotmail.com
Tested-by: syzbot+9fc4dac4775d07bcfe34@syzkaller.appspotmail.com

Tested on:

commit:         ae90f6a6 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ab0230580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=9fc4dac4775d07bcfe34
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10530230580000

Note: testing is done by a robot and is best-effort only.


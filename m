Return-Path: <linux-kernel+bounces-438122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 632119E9D1C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EDA01887060
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAA314F9FB;
	Mon,  9 Dec 2024 17:32:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF4EDDD3
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733765527; cv=none; b=Fe+owhikfDkFtsU8YemvHjSe72x/ZkLbGHOEoLDrO9T4rVt8rDaMeOgYLhgZUa8AZlTE6ZxbbVNV74Ksyh+uqFLQOYRM3j8hCtV2SkF3/8lbgxOsMFuiM3sHkiY93nAWFQGPu6o4phtAGXTXkBLiV/JrPWTg8ZAy0y0ICQCIIQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733765527; c=relaxed/simple;
	bh=2dbFz4F3lGyQECKzFO9Edvk8zlb8Isu/2tfm0Nq5Lkc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nMtTwT20jtIX4KUNCB9mAJ3kWZpCetLJ5HTjrPuJuE1CzRxX9mD0o05NgXG4IUiTZge8jQi5jCm8GLpH2BMXonKZ6BhuNoA3ZNGBXe871WlRT1fP7tanlugRzbHR13/4v4YgXGL+kuYcUspWA9ln47wTOU8FfbO5AmzLwAJDAG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a9d303a5ccso18804925ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 09:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733765525; x=1734370325;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jT/MGQxDXKDPFnbZPgiB7s7xdACGqnR8EVRt/7/8hDs=;
        b=pJKc285Vs1K0XFUGJbOTgI/WjMzW8Eb3s0xIhN+necPiNdvNrB4nsAc8YC6HUnDlnE
         HMpnOvWcMlXhXPWjdi/ESuyFCCAx7Uo4ydWFy0rQEaUWhIqyMvoy6ekF56Eg90dIqiCT
         1psAvRL+1DHImRwzRlPqmCZ5N67yq7ZBVjBue/aQO1u+Tr8db/0nFgUgaxlyS9Jl6ml+
         RKUATM8VgCMMAsGlgUocXnpUhxG3OMEL0Hy/XDikXBUt2cbzPuiIOHroObsawGx9JH7p
         pGKkTFynMt3jt9Evi/9BX/u1vL4p0Vla76kuMIB9VjRde3jiy4OzIC8+UHGGeVkM84qC
         8AhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8UXTjBg3iirq24IqSxgiW9tMcmuZRZlPIn+kXWSAMq4AsFKdhQkEyj7AFlQ/DBmBC1G3l7b3OXpkCDQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/0dQViqCFWsTcWJeV0Z3rASap6EkvU+/fdhHmLyu0TxqSzQ1B
	Yon3ih5VqcHLH3A9ELqzsOg1AoCQIC6XPS0XUx66rCxja4urURuE5mvHRearY5u69ksAiEIenhh
	Yk3YfwGr5NfG0XpO+0x2XcFoB0ZpGsevyydEnJ3X0FcSTPMPlzR0uAvQ=
X-Google-Smtp-Source: AGHT+IEbmrduPr4KcIVaGH64axnUUJmrCwgpaRUJDoVlmRGbX0Ds5oWWrgEhVPCUxpp251txjlITZJhDfXt2hN60A9Af/5ybn40p
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1745:b0:3a7:e539:c27b with SMTP id
 e9e14a558f8ab-3a811dfe123mr141144075ab.17.1733765523621; Mon, 09 Dec 2024
 09:32:03 -0800 (PST)
Date: Mon, 09 Dec 2024 09:32:03 -0800
In-Reply-To: <0000000000001126200614f5c9c4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67572993.050a0220.a30f1.01ad.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KASAN: slab-use-after-free Read in
 hfsplus_read_wrapper (2)
From: syzbot <syzbot+fa7b3ab32bcb56c10961@syzkaller.appspotmail.com>
To: brauner@kernel.org, bvanassche@acm.org, cascardo@igalia.com, 
	chao@kernel.org, jack@suse.cz, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, rdunlap@infradead.org, sandeen@redhat.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 1c82587cb57687de3f18ab4b98a8850c789bedcf
Author: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date:   Thu Nov 7 11:41:09 2024 +0000

    hfsplus: don't query the device logical block size multiple times

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17c554df980000
start commit:   48cf398f15fc Merge tag 'char-misc-6.9-rc5' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5d33c579b4e833f
dashboard link: https://syzkaller.appspot.com/bug?extid=fa7b3ab32bcb56c10961
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e3d1fd180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151a6e73180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: hfsplus: don't query the device logical block size multiple times

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


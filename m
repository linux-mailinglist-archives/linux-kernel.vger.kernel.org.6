Return-Path: <linux-kernel+bounces-414142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 451B59D23AF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2212B21237
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2691C1F2F;
	Tue, 19 Nov 2024 10:36:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C30E156661
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732012564; cv=none; b=na8tVbYKpUdepL+4dj++HqsQpw80s331eVuOK8rLnKTdE/DooHLdJpVTE8Nn9bkLd7FyuVtsOpvPnc5AJeTr9bpThJxsf0h/7C0FAx5wuBflJLjLrDtSwA4v/E5D0W5lb7mFNBEuiMxjjmWGUJmbXHXUMnRtJdF41DbDZQEwnZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732012564; c=relaxed/simple;
	bh=xUwo3wZZYVQWLtQgSzxfVN3DRvFAYHr7FOk4PHNEuEg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BJb5plbhfsC5qMl53QWwMEb3L/3gXXeNOklv/U14DLX+bPZx1xbSFyYqvJSTBNj+Q/6xbl5qZz7k2cRga4k7zTImc+mK2HLjQ34lpsYlvXwsPuLvqD+Wpn6MtKbtEpwvRXZ5vhpeGpQBEJtzP5t9KY71SklvwEL83dgofJDJW2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a75c23283cso23272205ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732012562; x=1732617362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amgwMc6OTFsPhBoe0UDa+e6OjKCPctPlX9BP3lpk4Tw=;
        b=lPM3lpzniu1EGdwXbXayRQZtCuDkTjwv/OkkC3BqO07vOlZRGhDF0RTAa4ZC5F16re
         Y+MERyiuE46aYdv6s0rbGuFEv2+tCk4wWVYgGK9tk0lW778phlo2z5+PTKoGRGjI2rXl
         RaKoBtrOqgpM/sa/eZJN3Ht62jk9wmCLlXXbdSQ84UWDyP+mPWpdolXp+Ws5rLUO7Gzu
         6XOhStNm7NyI4NlhPrKvcqNw5YYogMY1kEBzimWzlCdK5wmsuEmzCNsp5LdAOxrPf89W
         m8uSdlcNFu8WQkpxyEFxNJyA2gLh/Qs3LXeiFiDnbJ68R0YLgqWKDb9DgHVxWX/cHtFG
         4IlA==
X-Forwarded-Encrypted: i=1; AJvYcCV6NOQBIniU9Xxko+Udmi14pcRc3A9tY4kXZGtYGy9THdaMppKWT6xF27XkRgjdU6oFVZ8dNNRFFVLpEfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJMlEIwIccGtH1IHD0cyPFbdaBwR7sQFjLGXip4BoAetSAa2IT
	mKfJxu6A5HqGWnH7E3kLFAmaUz/Szu+0oPujczFG938eqzVOJYd1JRlYNsHjcdko8fuhAoXGJsc
	XmLKL7uNh6Ap5JNT6ImxTFkt4b1jL0BWF3OyhiDxKizQ8iF9ZjdBO53k=
X-Google-Smtp-Source: AGHT+IH4JLOB68J0WVaAms5rG1fSqmbBp652LVCd0s1VSCK1MCwu0N8T0U23tdmatWrAyYwbPaOyDlt2vvijnxc840hCL2uU9PNO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a65:b0:3a7:4382:668e with SMTP id
 e9e14a558f8ab-3a77738fb96mr20777805ab.2.1732012562296; Tue, 19 Nov 2024
 02:36:02 -0800 (PST)
Date: Tue, 19 Nov 2024 02:36:02 -0800
In-Reply-To: <673b6aec.050a0220.87769.004a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673c6a12.050a0220.87769.006b.GAE@google.com>
Subject: Re: [syzbot] [keyrings?] [lsm?] KASAN: slab-use-after-free Read in key_put
From: syzbot <syzbot+6105ffc1ded71d194d6d@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jarkko.sakkinen@kernel.org, jarkko@kernel.org, 
	jmorris@namei.org, keyrings@vger.kernel.org, lhenriques@suse.de, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, serge@hallyn.com, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 9578e327b2b4935a25d49e3891b8fcca9b6c10c6
Author: Luis Henriques <lhenriques@suse.de>
Date:   Tue Jan 30 10:13:44 2024 +0000

    keys: update key quotas in key_put()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10821bf7980000
start commit:   adc218676eef Linux 6.12
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12821bf7980000
console output: https://syzkaller.appspot.com/x/log.txt?x=14821bf7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=55f8591b98dd132
dashboard link: https://syzkaller.appspot.com/bug?extid=6105ffc1ded71d194d6d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dbbb5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c672e8580000

Reported-by: syzbot+6105ffc1ded71d194d6d@syzkaller.appspotmail.com
Fixes: 9578e327b2b4 ("keys: update key quotas in key_put()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


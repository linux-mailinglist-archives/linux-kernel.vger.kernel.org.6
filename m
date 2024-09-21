Return-Path: <linux-kernel+bounces-334823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE0897DCF3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 13:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C1B1F21B64
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 11:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE35161310;
	Sat, 21 Sep 2024 11:42:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3608C3BBC9
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726918924; cv=none; b=eQobWMKNx7AmiN9SYsX3jFFuaonZhu1Vr+/x4AjKwNu5gspBHXZU0gOwJFSg2H1aO62fdg3kzHtQ9SyVWFAulrHUosQ+KlTJdCjBhn/k9P8L4IcIOj8nSTJosJuT/Ia6JNAGD06E1BD1wkxwqlZUzk1m5MQeNrB86+gO65ncOck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726918924; c=relaxed/simple;
	bh=MW8Fptt4pTmvvt5RTXxkoAVzrKyn5l+mwexpoCi+Kwg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ScUydE6cG+tGr2CeMc3axd5paCVq49I8zs+NeH98QQ10FjVop9mOxOAMk1uj8aFhtzDpDjKf3G+xyvT6BRRRZPsAiSCGdVrk1PV7xUnlJc+R7i+MZaFepE9X5jufHTiGqB6yyePg/Ldj0wod2KDNyR7diQlvKdKn0Ml4ACZY01o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a049f9738fso33106895ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 04:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726918922; x=1727523722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvHtB0QDwmSzfWM5KhzO03SS1BZ6UWTNYZfgXfhEaX4=;
        b=HgTpeH4bmTw8m1KEoColSMzA84EXcGv8a9nIdbHgNPd5EacvEysE2dZ8SwhB4y7sZj
         N/a7bSoUxRc4Ufx7hCfJS/jmPDZxxWeIrrrdnaGdHFYZY6LEVdX+2gV3sjeJF4gaMjYv
         v22zLgchbkPF+j9YeyC2RyiW7sLGF36ik5wI98SbxWb1akscJFAkZ71eetS902eEqQaX
         wkdqy+ltW2Iu8QUHnnOTkWnY1eVbKl4I6LDIQBlpLWRBux/dTVHu3OFwa+VtVZtsoxdI
         hWang18MrXhkrIHPR67qzv5m47/f1X1r6fOyjqFtuIV6Py4+vVfWljR06jtJ4eRHde/4
         nPog==
X-Forwarded-Encrypted: i=1; AJvYcCXo0KyPiJs7KB3v8fRbC9m/Ji96cYBMnPNb4mX9+po6ZWQf3sRXPyWVaQXXognTQYFbSnfCL74x1Lsj3d4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0vSCWCR9rNqzyTAINDzPSdqFR6HuhgtWKAsbwO1klwHOd/57+
	H5k88rE6MJfFHyZ2IhGZJzXMXxXMM4Czkvl3Tb0WKShQKohuREKVqKmbRPtgDcmcGEwID/LkQpc
	xZozFjIzPti/ayNwVsz9aswh3cYQq2ZzYokDDxWwP4y7pZZaFaDCQDEE=
X-Google-Smtp-Source: AGHT+IEFoxVtlR+KDsq+jGe9b4w5JUTmJNk8i6eHDlzZFMCmQkZyMnCka8qjYjqxEz0roCZUihn2p3WBvjJTA1dSPwgvBFmsF0Uo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e1:b0:39d:25ef:541e with SMTP id
 e9e14a558f8ab-3a0c8d2ea1cmr52356625ab.26.1726918922413; Sat, 21 Sep 2024
 04:42:02 -0700 (PDT)
Date: Sat, 21 Sep 2024 04:42:02 -0700
In-Reply-To: <20240921112013.81961-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66eeb10a.050a0220.3195df.004d.GAE@google.com>
Subject: Re: [syzbot] [ide?] general protection fault in ata_msense_control
From: syzbot <syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com
Tested-by: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com

Tested on:

commit:         1868f9d0 Merge tag 'for-linux-6.12-ofs1' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16960080580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0b35925215243c6
dashboard link: https://syzkaller.appspot.com/bug?extid=37757dc11ee77ef850bb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12c3f607980000

Note: testing is done by a robot and is best-effort only.


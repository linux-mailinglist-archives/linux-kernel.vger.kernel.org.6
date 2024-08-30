Return-Path: <linux-kernel+bounces-307992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CCB9655FC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56631C21992
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 03:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCED4136E3F;
	Fri, 30 Aug 2024 03:53:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D8929A0
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724989985; cv=none; b=T712bLZ7nX072YfZ6yp+HQ3P8wmRC053PjETDtlMHB64EdX8Kg1LTWZp32c38gJ3CXVcoiQmVCsW2p8dZ+vhTsAvMkSiVpDs86q96LQAxtr/HLCAnjBVN6nmkNcF0dlIkQD3XUefSCMUjOLy6My35pbqsWw2iDlAewoqrSD3e38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724989985; c=relaxed/simple;
	bh=NLB3e94bPeQljtSTK29GfbRa5zKADX7oXjWcLp9eJMU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ESJYh9LD5616jvgc+9NRsFovD4ECYnB9cZyV3M0olgowaCtFXM55Ep6mcVzdFM/jCqsUhyKigwYiQ8CY3JjuHpzDt68dosmXb4TgXWaFxXTVm51Zek92UyKvY5U4twnLcCzKd09kYQxX2Wo7DvRE7hEN4dKLCjPHan69mDNk3Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8278114d3a5so162009139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724989983; x=1725594783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11gHQQkJhbNd81dV7Tj8BBptBWEnvolLEtyFBh9LJUs=;
        b=iWi16gqEczDoM/DAaxej5t6xU/o2w3itKyFxThSTClKuQqreFMSR57Y+oJgkE4JLHo
         PZ/scqrn8SMVEy6vIjFg7R7MR3zU9BKHRC+gZyce+9wrN83Vzce3FVyMwkFErI7hMGX7
         fMWYVPR1pNMmr+bYmwfJibK3R7cdW5tYbdKuBuP5mYPJyEKrlxLIy8ttz+7ngueA2UXV
         Ib+FvZyz+H+0qCX1l2WzyBsidR8oGJMzpLpnblE2F1P7Rb02j6AEtgmmfVcMZLq5ZU5a
         loxiVE2BSlG/4hgIV5YJmnq/a+q8IrZUPYONgpekRNEweIxCaPGTJqhvSjcnWps4U6qN
         BprA==
X-Gm-Message-State: AOJu0YxJv8J8NM7mOtAdgqtUJPPDzdUutIJjr1jLSFeis5fj6MYa5IWI
	dTqFE+UVY9RLwguFffJayySzULaADOe1egCkIW3BvhKqbBrCG2rB6s3MlOxdE2APn33CrVX2VHR
	xGhNrONVnIp0KYv3DgVhXuPP+Isygn3WTUsLL2BNH4nRrhs56KJGFI+E=
X-Google-Smtp-Source: AGHT+IEoyN+LtlGW3jzUJNIiWE0FN4MddluENT3XlCvOo0pP0TrSrob6EFumYtDJFB/ptCi8JYn0QE4o5loeSzz/v3DTjaV7rJBA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14c2:b0:809:b914:a53a with SMTP id
 ca18e2360f4ac-82a26113bebmr4629739f.0.1724989983016; Thu, 29 Aug 2024
 20:53:03 -0700 (PDT)
Date: Thu, 29 Aug 2024 20:53:03 -0700
In-Reply-To: <20240830031215.2068270-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ddde40620de8735@google.com>
Subject: Re: [syzbot] [net?] WARNING in hsr_fill_frame_info
From: syzbot <syzbot+3d602af7549af539274e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3d602af7549af539274e@syzkaller.appspotmail.com
Tested-by: syzbot+3d602af7549af539274e@syzkaller.appspotmail.com

Tested on:

commit:         20371ba1 Merge tag 'drm-fixes-2024-08-30' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127b604d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8605cd35ddc8ff3c
dashboard link: https://syzkaller.appspot.com/bug?extid=3d602af7549af539274e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1196692b980000

Note: testing is done by a robot and is best-effort only.


Return-Path: <linux-kernel+bounces-187655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9F58CD5EE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5189728260D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C9D14A4D9;
	Thu, 23 May 2024 14:37:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B06F12B16E
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475024; cv=none; b=oXULS5qAXl1cJ4j10RAZW8jag/dDuN01i6NLNQcQGJZ1V+MrzQ88p47py2MEivI2AqBDyG0t4MEs9e1sTGEpNDhpMHGazC10yT/G2vI87EevcwTYS82ZgqT/uv5fS/MX6rqUo66Nkz0CYR6OC7QmYOqyvUtUy7npAJS1WVzrW3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475024; c=relaxed/simple;
	bh=hkyqb1KtaEJRszTUHF/OZdndMMYaH1IiLizrIUSb+x8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tBVKCLIvpOHdXbBNE3PwHAmGsMiBGCIbpiUIt4jaEsSaeApJX92qLILuLe0q/WQ2+y7FnhlRFuo0IftRK6ZrmGGY68js7hbTo7+2CB8BbKw+cOmKjoqkg7odoZarnef8IsErAye1QyQkbvTYa5utmLPtblgSEjwTFKQAzZdTIVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e1d3e81a00so179587339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 07:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716475022; x=1717079822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSF2rMoyFhvPssdMHr5CKyA5VqEOM0OBvG4P+AVEF48=;
        b=TAgKOPeCHFjtwENQy7NH2ANflYPpeYMCJ1o/uteWa/Fag0W2QrqGioNsaJLLUw6NWi
         lH50vuRzyROUGBVL5Febtq6L8BPHL2VNUfJhIIl65S5+RsuRlkDYlTdHOtNDI4GCpksa
         6J1o6xvcXjNxQ7NuYEGhWvreVywiIo77D8XTpGORMwVwDXzycHNOGXugk5rxJpbN2ILE
         RHeop5Saj2sbnh4AgWs16P3f2j0RGOUrfkcHdgzUY3M8cTyXRhMs0PvLbO0+5gDWAAF1
         dh7YJT+OBEfcOr+ikCY8ansRxnkd/7AMItdsokyOwy38vyrJxyl36hki7nZAop9loql/
         GjiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIBNj3PZnNOT02mJgLg3c2nf5iGV4U/BQOnM065KnxRz5KOWIpdZK3ZY3jniLrAk1aYHe1XG67UiNOSbLICLjYnlsP3+VdFMdi94bz
X-Gm-Message-State: AOJu0YxH7ysyZbMJqtNFoMJntcsZnG6nMZzEU7m9zsitbgJPLWjfuHf4
	ldiXyCQjd1n5zIb+jFmV8X0dsOPk4bzFDD6BDTtn0lWeZzR2zr0V62f2HW51pZAeUiwB+BoiNue
	+pJxXAH4L5zJYXTQyC4tnDobK4RTFzKttlNTKLRcu9n5oaHuq1HnoBXQ=
X-Google-Smtp-Source: AGHT+IHneQ+JH3RhgMARMRirmHLCymoMydPR6lp95ASQqZ7JNHiou3yHeQ1AAvYCLcRuUl8lRrjw3PiES/KNBce/8C/Pe2FDlFpB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c04:b0:7de:e0de:bafb with SMTP id
 ca18e2360f4ac-7e38afe7cb6mr10069539f.2.1716475022424; Thu, 23 May 2024
 07:37:02 -0700 (PDT)
Date: Thu, 23 May 2024 07:37:02 -0700
In-Reply-To: <tencent_CAE2ED8ECCF07BB66D902CB16CA894F8EA0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa4c6106191ffb84@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com

Tested on:

commit:         33e02dc6 Merge tag 'sound-6.10-rc1' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17ccd634980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25544a2faf4bae65
dashboard link: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13fec2b2980000

Note: testing is done by a robot and is best-effort only.


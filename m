Return-Path: <linux-kernel+bounces-383505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264E69B1C9A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 10:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00771C20BAE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 09:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF7F77F11;
	Sun, 27 Oct 2024 09:15:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60CC56742
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730020504; cv=none; b=ViL+8a6+8BQUZgZpZQpr1KmUcVahZ77N3argfyYkdvPTNnmAIx2GMTaQ1A4I82H8CMXPbtl1J3/27rSEXB7BINUFXUpEMD5iqB5a2lPaWV/4jBIDj9VzoFc1Pv1PR+5Nf0fsxjPWucm7icuECisCi8OGlLiugke7gWz+EkykAJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730020504; c=relaxed/simple;
	bh=9zLN4yPAjza3cFTaRQ98qMrJsAc87sRqZdqSQIDBUWw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pQVMqMfJCP3QhyK2lCK6nKpo+x1mIqRKjA+yq85J4sjBAZb9LfZD5e3jXcS5ztLNCtnyC46B9NGXkiTCkeMGqopJ67Ac0+3nDBpre12VE227GhtZfkvjB7Bs0s4Qe7u+MBMkD5fy3/ujz51OwV4//cCurhVKIGuAVr9AutBt9fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c4554d29so30027485ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 02:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730020502; x=1730625302;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0pDFHlXnALy3dcDDeDgazC8Xnzm1TNZtM6am9fgsR8=;
        b=MBf62VDiueCvTuOWbx/PO7HGv0ppgw7WiKNbve4nmB2zCnX7sqRkCh/4AZflNCWqYc
         Y+UIfwF2WCCqVde7Ymdbz6XDR0S9CMhS7OBCBAtB1S6ewscSJh2a3bgTfMQErmPaoDsH
         9zBei/ShdfAeWXU3nMzTamxhjT8PJ1DwL6IafpPudx1RpDgfdv6UbYcGwUXCzGys7OK9
         oqIMtn6sLYOeLHcCqIoy+iws6Fy6axTcHyBJ4BXNKXB6YfEw+hp9r1qd0TqZwkgQMkZf
         Mp4G+pxyUwdDD/iBqk3WBmZhVclkJFKPtGiOvuydv5nRQs/ydGd9jY8aaqFxttIL7JzY
         cIUA==
X-Forwarded-Encrypted: i=1; AJvYcCWzpKlI+qqlEqd67WV09zZ7d4o3FyKjea1sXkPg9MWcq8RgQkdqErSoJW32V2OYjhz5M1kL56lIQHJXs7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsdf/v1DBAcjrqmHPK0uy/O491PD6hWwR+Dq2HRAXKkwoE7cfY
	NZiK/aisHMBvQViY7d2zB45owblIMx/bvID0MtFuOR3hIXehXW/+F81hxyH9MGyNYfBis3jHEAG
	HrTEPsXFt1PDXueonhmqGWmpIWBDs1gQqcbgOVobjf03clJk0letCKJ0=
X-Google-Smtp-Source: AGHT+IFLkP07N9+lJdENwHszwYT3ieIHO8/fFfMX0DNfBxQrqKaOnUpyAmwy0i7WfjroL9FgAGbTlBGDnT5nA0PJNH37zBxO392J
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b22:b0:3a4:e63e:550 with SMTP id
 e9e14a558f8ab-3a4ed27817dmr37229655ab.1.1730020501731; Sun, 27 Oct 2024
 02:15:01 -0700 (PDT)
Date: Sun, 27 Oct 2024 02:15:01 -0700
In-Reply-To: <tencent_4E83A7C006C212DC065509AAEEC86EC48C06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671e0495.050a0220.2b8c0f.01cc.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Write in ext4_insert_dentry
From: syzbot <syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com
Tested-by: syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com

Tested on:

commit:         850925a8 Merge tag '9p-for-6.12-rc5' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11cb9230580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=0c99c3f90699936c1e77
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10ec24a7980000

Note: testing is done by a robot and is best-effort only.


Return-Path: <linux-kernel+bounces-311378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28306968857
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 863CEB23D1C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3659D19C57E;
	Mon,  2 Sep 2024 13:03:28 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701AA1C36
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 13:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282207; cv=none; b=onD+rkzncpIq2EZNXRAETvfcy9+eqTI+SnapVkTSsQWKe1PUMBcJMYsoX9ZhZpBl5+6p1VEcmm6GvTCwK5xhzuZAUVxp8QlPhGFKew8lDWVzk8wSk1pGtMguZalKPxHNc5eLxWvPYkqMpcD8EZ6pOfusUAA51pj0qlr78T7SMME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282207; c=relaxed/simple;
	bh=WOqMHAOJA49vC5CQXl/er1PIt2QSO65JIS/Ocw0nKQU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qOXwLXO1eC2IlLtv2DxvdWEjk0o15i8xQ745AGx9dE9pcgqx/3nLXfSObPFzSCzNSj8W8ID0uiXl+bntWUXTgrrKsHwfJ+WLfoSDbdpcAq5b8JjD+BcA5sv76JwCYYPhElK+yvu+d+fK0QFe6mweT+aqxnAMFUf7BelSa6XXe9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a492c9d88so154557539f.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 06:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725282205; x=1725887005;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8lf4p7F8CuD7ANOVuZplSvgY5X677mHhp0Jm7xIDX0M=;
        b=ahgdHgLd3up709eUx3YVlMOf50CXkuppkSGm5b0f6jVZ+lADzY94ZcpKd+7RQ/2biJ
         upTSOBkACCF42SY39CC5X4IbdQnFM0wTvTJPGVl+N/aqA5p5mrhRqF+U0LAM/uGzlc61
         4WfGLTG0VyUyIX8y8uhqHBBBtgvdmM2CH6go64IGKXrrMREqJGl3KqbDRViIG/d76/3v
         3cvWkAMBLS3/Nj2QwFrJG40JN5Mn5p/d3lmfasHGHsB48NNa/icElXGF8V7CkNBVoFIk
         1/i6BjnvJv/SOhHIHlYlpNorlohU0cwZPUtP2hVT+BV4VGCHa2d7wuQA2KCwivqEgbxd
         Vd2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1abqFaZPwCHp2sOMAwdDDPkZ8/7p6ZOKAFn+57FUxGy05iZkM6xS1P5lno9QgXZ2mLYyu/mwEwgplL/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLdalFqf030LQg6hXPYSyJgBg8a5g6HcM2GGCMaYCmEyZNr8lA
	ePTYEH9Qe0V2KY7bOOQsOfhcS9kVlBb+Z4btlrEs/R4WgeSzb2Wa1ZnhduvepB6RQqajLOdZip0
	wfC1G3EAPM/1oYjLYz1KQFwO0LVNUbvTVursA9XrjlevbfxJCwTrseT8=
X-Google-Smtp-Source: AGHT+IEgXE/1tCbN1hzozarqMZqwXbEEES7BQe452GrTTFve/XomcKAYFO7EQqCHSe3ikm+giwwBzmXEn1XDFoUUD+naOQOWA8p8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a4:b0:39f:572d:3d85 with SMTP id
 e9e14a558f8ab-39f572d403fmr5230765ab.6.1725282205261; Mon, 02 Sep 2024
 06:03:25 -0700 (PDT)
Date: Mon, 02 Sep 2024 06:03:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb6da00621229059@google.com>
Subject: [syzbot] Monthly arm report (Sep 2024)
From: syzbot <syzbot+listf7bf7d567c1cc23222ab@syzkaller.appspotmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello arm maintainers/developers,

This is a 31-day syzbot report for the arm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/arm

During the period, 1 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 4 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2501    Yes   BUG: bad usercopy in fpa_set
                  https://syzkaller.appspot.com/bug?extid=cb76c2983557a07cdb14
<2> 421     Yes   BUG: unable to handle kernel paging request in trans_pgd_create_copy
                  https://syzkaller.appspot.com/bug?extid=2d1f5a94167d430a3bd7
<3> 68      No    WARNING in delayed_work_timer_fn
                  https://syzkaller.appspot.com/bug?extid=e13e654d315d4da1277c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


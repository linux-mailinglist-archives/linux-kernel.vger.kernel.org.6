Return-Path: <linux-kernel+bounces-392047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F439B8F11
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5641C22359
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285FA16F85E;
	Fri,  1 Nov 2024 10:20:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12C615CD60
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456405; cv=none; b=FY0QnlMp1nXtG2J/aFlOGwFDW7X5Yn/C9Z8a2S+FKk9sWJwbOZbwbZ4wPusA38zta+iZ7w8l73J6E6uiMmxghfV9galytKVbpvHEuJZtji6fBN4kJdfNr7o074/bN8sDseObWA9OdHsq4iDE8XHUucmPq2ZRQLiZWg2PdsTXfzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456405; c=relaxed/simple;
	bh=yjG34a4WfXGIgQbvGKhf9/h+RK8CR/aplWWGB7JV9YQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=caMQrdPNN27WDC92PkA24fPKxPuaL8ULRzghJ8AGPS6bzGTRbOZIawCVgAojLa361eyQB3DNVqvpsZ5b7j+zV0ylXnK/2H0EebHaigqTSNm1RuExE5qigJuyG/cDHaC6UTGxTJqik/uwtGaf3A4qDXvOCHS/0FGTHZDC82s+2ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6b7974696so1190025ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 03:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730456403; x=1731061203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3eGCsrach8NHm1xot36+n5aQ0Y9q1AeV+fvWgjGpOpI=;
        b=ZUy7mQjrboT+70IJUOqO0qgGJbhrqIkbbdxzNYiQ9u+ZTL5BHlS+RYxY65/XoOSAXm
         LMWa4/Eq1Z2Hv5wwtd2RI/SFfWmhskwFSoCDZf033jsYn123XhS3wXaYWMDuguV1ZVFB
         qHkVUHSH3uO3i9FR+jQP73pojI6JoPzDSaIgWa73IFKT0kkeMLPuL/ZLhcFkq4eOCTXU
         s412LriGFR7r0wtNEeCsXozRYrJECyX0vRkNv20DEe/LjGmWaw+Y2UUQ6Qmtkz9VGqXV
         dOIET4Jd/1co1CVFzrsl6t8sjBRaFQ5aUmI1OUbVMGb0pLIRtTXf4h/6UuwsxggupjBu
         0qVA==
X-Forwarded-Encrypted: i=1; AJvYcCWWRYYAl1L7bzk8LcJjCU3Z1XLdOlaLpBwuyCa88dILUNxOqxFbpmO9uWojvfYrJBqqAl8veLx059pdwz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYcG/qE3kbD2B91Z3co+SLAhKX4hC3HhkR3BNXUkC+OwMvJWGF
	IiPFhmJb9fbxfnFZ91p+pOzsivLGHnvasfUBBO4waOriAylVk2DoqTkwlNmIPTPI+mMlT0GaxQc
	FL5TTBuFYdvxJTHgNkUCYdXUyFhI1jF2s5UAkqZp//iGGDKpeSFFKXdw=
X-Google-Smtp-Source: AGHT+IHUsB82AaDjlT/CUOuqkmMdDgqswU2rNhtr97SeQuwsmoASOHwnTSF3josRU0bHWz0+r3ZbMdkjgaXa8XaBNi9BItssMb8F
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24a:0:b0:3a0:9f85:d74f with SMTP id
 e9e14a558f8ab-3a6b031a257mr35476215ab.16.1730456402996; Fri, 01 Nov 2024
 03:20:02 -0700 (PDT)
Date: Fri, 01 Nov 2024 03:20:02 -0700
In-Reply-To: <20241101095955.9786-1-zoo868e@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6724ab52.050a0220.3c8d68.0886.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbFindBits (2)
From: syzbot <syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com, 
	zoo868e@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com
Tested-by: syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com

Tested on:

commit:         6c52d4da Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116eb2a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35698c25466f388c
dashboard link: https://syzkaller.appspot.com/bug?extid=9e90a1c5eedb9dc4c6cc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1293e6f7980000

Note: testing is done by a robot and is best-effort only.


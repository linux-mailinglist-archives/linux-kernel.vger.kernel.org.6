Return-Path: <linux-kernel+bounces-426867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E759DF990
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46376B21E0F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 03:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C095D1E1C26;
	Mon,  2 Dec 2024 03:26:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0356E13635B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 03:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733109965; cv=none; b=PV1h1oG+9Hz/Cik6k/L6/+CSadbY6gK8TC5NbiXGa8qva/UxRZykvXnQDAWhhlJqDFJyOMz7znDm+q7Fs8T1CUxtqFz9jn3oyW/RrkD7p6i6jt1MI5dM4F7BgJE4B21axDqbbYoW9C9C1OANZOUdymdNxyWOQexWXmiUzdz7mW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733109965; c=relaxed/simple;
	bh=7RdSJr/9UVdbvMYLMRHLXdWFNU51cbNWYBhIAVazrJc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fvoOQD16ItmoW+u+3SEQrevZFfe4QJ2lOOk17Y3DiVoyW1z+BLAo3yFvfHWGkhxjPsUqTntwDyB/8UzQwq8HdM4BDGqJgrYul+lri6ya/dfCyU2/ht3FzqR0SW+AsPnmP51Gnu3jap4xCBhzRqnGc+bZBbemvK49bt3WsgOaAKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a77a808c27so45280405ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 19:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733109963; x=1733714763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b2sLdtImYjFCDhmEDp3bExyRC4gsUPO0XUz7l2yZK1E=;
        b=LnyovrgKoaDIdns42dm9oIQ1HPjY6r95xlNTJcQ3g/shli4SknXtAfCXEpvjpgYQYs
         rqhtJfLYvCEdn5W0ndPB0tSLoft8DGlHgaFq+Ylp/2hTWpwBd3jX+FlilNcvsGS5DNIv
         dOHpCcvDmtPNcCxFGBrRw5A8+atCGvhEsYFcsjm5LV89955yVGfRO7E1sY08SmkKyXWz
         RPDwNhDrCsCEQ9vhscciU7mcvJAWBJ9srLAZtuBTvS+S2hxfrHYTOd7EQHEjBxkVXghw
         vSIla1lp41osohj5miiZrly615lEjCUJMQ11RMZdkmDKAnWL8ASrj2OoT9Z/3CpJAWUe
         mEZg==
X-Forwarded-Encrypted: i=1; AJvYcCVfiomJDo6eGHTgSqD9NjdAplbtL10pOObAenrJjKpxM3D1d+bQGBh8aFPWR1NLoy5+dlveXdaoIRKgKE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWeeiWOUH139aEqcO+OAIx8KdiaUzmjkPAewJlNCtoXB8StXzk
	rp+d4bbHhivOFBfmlMo1lJQ/9JVi7JY8XuIa8Ltvmx7ek7cnJQAJiFP5IvJytXUAJWCerTfaYIm
	hMv21FWuy4mOjQPKjMymvjfubYERnkS6Mh9E60BDPayjl1KnhDgu8YBQ=
X-Google-Smtp-Source: AGHT+IF9MIEu14ZO8R+h/e4O4dSrFi12YpLId3wkU1KbVovcCmxl/dCKf2L9I+uV9ofI9EB9byA4onr6ytin2y60WFVbvF2cJ8gV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ee:b0:3a7:44d9:c7dd with SMTP id
 e9e14a558f8ab-3a7c5540a5dmr245076765ab.6.1733109963237; Sun, 01 Dec 2024
 19:26:03 -0800 (PST)
Date: Sun, 01 Dec 2024 19:26:03 -0800
In-Reply-To: <PUZPR04MB6316B2F01962538FF5C00B0C81352@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674d28cb.050a0220.48a03.001e.GAE@google.com>
Subject: Re: [syzbot] [exfat?] general protection fault in exfat_init_ext_entry
From: syzbot <syzbot+6f6c9397e0078ef60bce@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6f6c9397e0078ef60bce@syzkaller.appspotmail.com
Tested-by: syzbot+6f6c9397e0078ef60bce@syzkaller.appspotmail.com

Tested on:

commit:         f486c8aa Add linux-next specific files for 20241128
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=159ae7c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e348a4873516af92
dashboard link: https://syzkaller.appspot.com/bug?extid=6f6c9397e0078ef60bce
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1068bd30580000

Note: testing is done by a robot and is best-effort only.


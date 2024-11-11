Return-Path: <linux-kernel+bounces-404714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4169C4815
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFEE8B27D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366A11A2846;
	Mon, 11 Nov 2024 20:49:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D8F13698E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358146; cv=none; b=ImceYsAK4gjODSxNPECRjNZn8Qy6KMcszbvwEDKB5j+mSt0vXV/psq3OF8ttw67kRXQJMvgsxPbCirwmCIxrYmN7gP6NguUdEsEGMuWlUSPbRXzJ/oKfv0xJCogwtIJqyLRpkN1EnU2hU/MtIqSI30GPANV2VNQAxYRMgF3ElkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358146; c=relaxed/simple;
	bh=ZW9SHPbDzvnkCVpJo+G/LIPTZwhy147bMPzwD8k+Aqs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WOteFbbC0U8LDu2AB4EahDeAcE/VW1JHOiXAXXqk10jwqFCszImsYZyJNb9FLMvfxchMxZ7RuXBW0+ZiVDoAnuufMS5z8486j8dHh2qNkcdOP2JJn0fHgrzb04fy3Sp59yq0hsI00O89EhATKFtCv+mP3C8vR3pxoR142bVj1/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6a9cb7efdso50470685ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358144; x=1731962944;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wQfjBeegKWza/6sgH2MEBvG2A8qLJBSV74IIuFigZaE=;
        b=C/+HqE/JV64H2om5mbaBSdWy0XZu2UCOXLwARWwfXBiyw9yF4d/JcS36flcceufgcC
         MsWQXLwkq6RgWmRga4wuhLQFmWtkDiZGDYwncADVKQwVUsUx5d99piR02HQKu40CAuxr
         EHgl+Jy1dTRjnZoqL5qftLfqSY9ZcNaJzuozgDDbK2cdAFhlLqLUzeRt3s6/JjDS3Z+G
         CwdNIKQk8q4EgIiMPeVWCS5RBXue06vWBtzJXEad9qIkib7OoumKHmdAou6rMI5sqjLO
         SURL8Mdj1djKvXCir8qKofj7a1fQjzzqSLO6cpxaxtqBNm+NAg4D9iKf85ngzMjhorO8
         K6JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf9qxXr4TJYUZwscEzSKaCrZzclBKBrj0v4oc/Tbqzc1rH+Zq669sO+nSUHQ9CEbHsL59HOrBo4TNh5Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws5CrHlh5fgYnHo+uifn0YRUhPsXqu1+9Xj9Ovn0WjM7Qc9+Nc
	oAWUJz4iIxGWao3WjdUNab8G0CmH35ezpfHj962m+RL6kXDyZVdGpNcUmMJXLays6HimdOt97ES
	VD6jhYFa3qmcfiFqwKq4b4+9vuS8J/Dfabz1U5XkomKZALgULDfTI7Kc=
X-Google-Smtp-Source: AGHT+IFI87C+FKzvNvUi2zXBpi7xEMGMw2Pipg1RmGVpsxNH6IhaoekXBWWqMKaTdEZ+/zeiV3G5RZD9GvnTJ1gAf8jKiUfOiFQ9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b09:b0:3a0:8d2f:2914 with SMTP id
 e9e14a558f8ab-3a6f1a45bc1mr144908145ab.23.1731358143975; Mon, 11 Nov 2024
 12:49:03 -0800 (PST)
Date: Mon, 11 Nov 2024 12:49:03 -0800
In-Reply-To: <6f129270-4c3c-454b-831b-4fe2f5597bc7@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67326dbf.050a0220.138bd5.00cb.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_free_fork
From: syzbot <syzbot+2e6fb1f89ce5e13cd02d@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2e6fb1f89ce5e13cd02d@syzkaller.appspotmail.com
Tested-by: syzbot+2e6fb1f89ce5e13cd02d@syzkaller.appspotmail.com

Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136874e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1e659028faecb9
dashboard link: https://syzkaller.appspot.com/bug?extid=2e6fb1f89ce5e13cd02d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1739bea7980000

Note: testing is done by a robot and is best-effort only.


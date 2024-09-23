Return-Path: <linux-kernel+bounces-336325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E326E983930
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A23C1F20F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B1C82877;
	Mon, 23 Sep 2024 21:46:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1F961674
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727127965; cv=none; b=hAbxsuXpyZUnGHlpy+geqG6WeIn1uSwMLT9MmaFyJ/YwA7qBfe/QoyZCdy37K6TkBr274Do2YBr7B4MG0VahprAXyRp501kPyls/VeUHyPvLTsuekWnPx6GRFWuWwiudM3TT7S4qBJLImxm6onKGIBk0MchBGpgE1eeKzsbEZik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727127965; c=relaxed/simple;
	bh=84UDYr69D/DY8Gi0l217OzdgJ3nZcmn7Pr7NgQvfDfs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qc5Munv9cLGDRXXh7irttb21lgOV/4w8SP/Qncthu8o2rOLMG0i3f4Ws/YQJQThqI7SIVeCnzlCEEUFhvZgM3tBJ0T3LkvVCZn4XnvOH1IUglkWkDu2rbq6OEiiYJi1iASBFBA0wNtZwAuYpnw8bYfW5tA+kc1ylSdSlLtP6e14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82aa499f938so448128939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 14:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727127963; x=1727732763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7aWRRpKliHGP+iwoPzTDGzWLuysGQIPqAppoC3pFlsU=;
        b=PatgRCr8Ah3ghgWzX1Mb4GvnZ74JingII7+uLyNoe+akvHfHkSEiW6dZASw5j4eRIW
         5iqYYNekY/vsoOGWJqSC5vv2ATiVRg6GAEyUqjRbfuycmOHseaF0Pe+8FZwB1SQd3Fgw
         G9VWSU71D3Uu8zHgNamtUaG2RrjHNs5J4jd1B0AyITX2kYjvoahDU1/vJJhMQDgdfohW
         1VHfAjLi8M2DdiFR8FtNefrd231QfTrEgLje48z0FT3l9p5OwVvozcfoMyEVj/snXcX1
         cR7FgHjBcN7QRc8a/SPM83ez+M3ObseCk5pv4OkGfphiBPW9Vj1SgIeclpFsgmo4V0Qk
         OPXA==
X-Forwarded-Encrypted: i=1; AJvYcCWjpl1XiYzVyjvpALNobKbS3YfUhvjyJunRd3ZjLtxXx5mP642khukL2W8VBRR/RA13Nsybo6nMIkeBQgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW+cfA8Ju+GsrGFsDi0tLnHERYtnZlCHyEExnfqQ6UgBtxs9LA
	T1r4vQP/SIMYHrSyhJ37t7HQAf75zQbws3qNXN3+Tb+XXtCaLg2zR583J3ZwbpkTIftjMNVwOwK
	IJTR7egb9AERW90srVqTviCW3vVtwMqhkEAOvMdtqvtD8JhfNQkwiQYA=
X-Google-Smtp-Source: AGHT+IHUq9/0EN2J28/DNHxgvmd3jaR0lJrVQ587OSrC/0NGt/lmX3VZ5WMZLQhzIQfXSo5OrCFpnGiOzG2ein7wTZ0vMLVdImch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d07:b0:39f:325f:78e6 with SMTP id
 e9e14a558f8ab-3a1a2f5b4a2mr7323975ab.0.1727127962840; Mon, 23 Sep 2024
 14:46:02 -0700 (PDT)
Date: Mon, 23 Sep 2024 14:46:02 -0700
In-Reply-To: <20240923210638.121088-1-djahchankoike@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f1e19a.050a0220.3eed3.0019.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] general protection fault in __copy_super
From: syzbot <syzbot+18a5c5e8a9c856944876@syzkaller.appspotmail.com>
To: djahchankoike@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+18a5c5e8a9c856944876@syzkaller.appspotmail.com
Tested-by: syzbot+18a5c5e8a9c856944876@syzkaller.appspotmail.com

Tested on:

commit:         18ba6034 Merge tag 'nfsd-6.12' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=110d0c80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a89411f53c579df0
dashboard link: https://syzkaller.appspot.com/bug?extid=18a5c5e8a9c856944876
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=166aca27980000

Note: testing is done by a robot and is best-effort only.


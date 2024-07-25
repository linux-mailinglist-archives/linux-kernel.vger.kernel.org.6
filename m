Return-Path: <linux-kernel+bounces-262492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2185893C7AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72E31F2181F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B87D19D893;
	Thu, 25 Jul 2024 17:32:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789B912B72
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721928725; cv=none; b=eS/9E4BzlJpOW4Jjrhjk815gJwspAnBkz7OdBDv3NO0qFaP+RGLS4gasJrErmuOiNWdexJb39UtiEzKOBFo2Qje6VZuBb+LNKuAdxktIAsYSoz+DT19lQM34z+W6z8obHpLwDiMTRIDho0E2+BpvBKgL3J/oOoFxCMMGupRJ+gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721928725; c=relaxed/simple;
	bh=onjRvS+axWe8Q4FDhAZ0mLsXnu4JnCZDDvya23Fdmfo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=V76z3N2x5L9QoP/kAKTU/oCoic3VY7nKtnPoRqjUyeTeitOhi/elHhSmXfLay0xqqvx/w1R2jVuUPLNlTSZGI+P6SB7EmBjvk8kOFhBmqqIxJMUL5AkOPg1J+T565euzTsZesZNE5iTDO4Vz1KNMMgAEPUNeB+4u6bfI3PKkz1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f87561de0so54339839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721928723; x=1722533523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yInUmJZ2N1yq4ZyQvECJY6v59tbe4OHDKEmU4VskWGc=;
        b=DEENCWXyqgM5oacb5h5r2X9AInqVj5yPr3eJ6DTHdDLsP3N8WD9NnYbTviFuJ7HXWh
         0sNtLHjfGGAt6piAbegr8Z4WuD4rViV1bQ1HwJ1yr9SC75DOa3lzemH86YBtWbZAa0qO
         9dxmYkhiDbppmWarZnZ2xksG7qNy+cuwfXphW2J3wqD5yCiy4R0YudvxdaWSCu+rzgTx
         SSbEUK7lPTTL1bYSkqrRnFjUzB3DI3vNMH37DfZ+Y4JZMERxESJQbjFSXW9pSFfYY1jV
         HiiSP5ye+sjhT70tONqvRGvNhVavvcnZBJMw6t6XGdjL3zteIHFZNfyTmLlzjpsOD3Gm
         1GbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUBJl83XSQ2dOMYAI7KRZ0xZxnaRyYW1SjCXNoYpdhlJjeRMuf2SCV2pYS+IsN/xJdQgIctmSjFZshFAg52qdZX4CSrKOALaUJSmpa
X-Gm-Message-State: AOJu0YwCBmMVdDu3sBXvyinAR/x/4l1sGhc2tZypCQnwv+y1JT4jq/r6
	urrg0hK6FMb/js7zRc4JFSPmzhdqbdMEhYDKDVo/JFZtJ+sdGelOMo3GRK9unAJl3zJlup6jybb
	sukQWk64Bp3UH+lNgIt74xR/F5OYTrUtjHwST+VMeNHbj0cvuiP6J7UE=
X-Google-Smtp-Source: AGHT+IEZMQleCE7wlx5bJHfXzkZuvMlL5wDNUObSSqLZA3kjVvIMzHAlAX10J/+9pI1+SFC0nMzEqu5S71REENSCp1jQ5+9CdMS6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4120:b0:4c0:9a3e:c24d with SMTP id
 8926c6da1cb9f-4c29b6da7acmr195043173.0.1721928723594; Thu, 25 Jul 2024
 10:32:03 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:32:03 -0700
In-Reply-To: <b8783e34-1011-4eae-86cc-9ba2b310863d@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e60a6b061e15c55b@google.com>
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_req_task_work_add_remote
From: syzbot <syzbot+82609b8937a4458106ca@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+82609b8937a4458106ca@syzkaller.appspotmail.com
Tested-by: syzbot+82609b8937a4458106ca@syzkaller.appspotmail.com

Tested on:

commit:         0db4618e io_uring/msg_ring: fix uninitialized use of t..
git tree:       git://git.kernel.dk/linux io_uring-6.11
console output: https://syzkaller.appspot.com/x/log.txt?x=11879ae3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f80e9475fcd20eb6
dashboard link: https://syzkaller.appspot.com/bug?extid=82609b8937a4458106ca
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


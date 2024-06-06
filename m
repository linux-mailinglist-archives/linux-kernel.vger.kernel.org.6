Return-Path: <linux-kernel+bounces-204459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B708FEF6E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DDB5287312
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E26419A28A;
	Thu,  6 Jun 2024 14:26:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D68196434
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683967; cv=none; b=sqAp0GOG7+54wiaScsOEo0Ju1xtu3NexGN7HjBkbjgzJNBJy84n/qH8eHW+7r1GMEZZwJYjaJCqTUuVVeWqLpw6TmjNMW+DZ0EvjktrR0SJEhqNsalhvMMExOD/JR8CbyA88lfh4Y6AMhwo1csLFS62rKFTcuedh+vVxWVQvxZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683967; c=relaxed/simple;
	bh=yjKMwFAl62b+so7H00CHC6/6da94z9hi7YsksWqqaks=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NS1QQj2nQU+cuIc24LDB0ZDCbBXmcIkvQ0X9n950nK0AEQA7QEURe/XGWpnxosUoR7vCJtvsBk+JMNqGmehzxiEmYtaIBgBz+/g/rZlyPYfxIYJISWWsYUVV7cjUED1lzH0y4zH4GV+kHmK5RmIjyJdbP7pJPauHDLA69Uf+E44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3748623a318so9069005ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717683965; x=1718288765;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fg8jd2TR2fBdSZzLvWc7aAfzzCagVlQpC57o9Kb6fJ8=;
        b=n1EpAZPNpJ/nipas9RlbfVGVsu2K5TNZidAFEet2qwN80ejSP5qqPVRwD9D6SsAMiY
         9srGKflbUTq6MvXncY86zStK/0BpSKMDtcM3gl9hxdGY8TUlOMCYw8iylALg41XjwFGB
         1JEO3wbzK63XO5yio7WbH6H7WTS+/xY6YkrmjvnhsO+FiwsjpWOokyT/fHkqu1N/qXFt
         0Lj0GxryYeKc3M54tk5KSqpipQmVh4q15gwjGjhbZa68t8aSVebFZ0oqIB0gF5RC7PfA
         sL/cAThZzFjoKT2nrFibDQ6ifntEIIy2X+mnCVi0Zi2Ub3p9bzZnUcoVJebaryqo9OrP
         D4LA==
X-Gm-Message-State: AOJu0YwTBhCTCQZZA0ywSHGAFurmQHuqkJEgfqToxRulk5HtnZvLwxRI
	+MzYBEaaQ3b0p61ruPqxLUDhqwQe5crfi0z0lcsWCGaJTZBuVHkwss56X3ROQLwA/jduze4lF4U
	tFdXGWDifack9BziicW91HfFQED96BRauuegn4CGYSX8M4DrNUZoAZ2U=
X-Google-Smtp-Source: AGHT+IHtYl3REDwQ5nmadrvHO0xZQA8Vz6B7pSNwdriZq0AHp4ZBna+ycREB0idFEgI6uxkQ4LHcwo/2fHgGJ7ZJIHcJ35xYn8fc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1544:b0:374:70ae:e876 with SMTP id
 e9e14a558f8ab-374b1ee7ee7mr3066375ab.1.1717683965720; Thu, 06 Jun 2024
 07:26:05 -0700 (PDT)
Date: Thu, 06 Jun 2024 07:26:05 -0700
In-Reply-To: <20240606140352.135948-1-norkam41@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d0eae061a3976e2@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, norkam41@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/trace/bpf_trace.c
patch: **** malformed patch at line 7: diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c




Tested on:

commit:         e377d803 kernel/trace: fix possible deadlock in trie_d..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10fb9a16980000



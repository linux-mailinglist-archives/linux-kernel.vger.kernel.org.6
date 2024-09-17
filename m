Return-Path: <linux-kernel+bounces-331558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE2497AE74
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC0DFB2D84C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5AE170A1C;
	Tue, 17 Sep 2024 09:51:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00548170822
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726566664; cv=none; b=hTuQNHDMngh1QdF7g+jgI02XiNdJi8vjDdi86Y4VhCDAo2Xq3GzLFGpFWz7OAEYNO/dl08B8+ZzJH3G2pn+uk2aM5MyhoHUPnkYp1DqPyzcaFFu79rqPm0KOTS+SbjasYz/qBjJilDI05x6UUNcd/IaRHMG599haqFxAomtHMaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726566664; c=relaxed/simple;
	bh=d+BFDkFojviuUYyTlF8lf53Jk7wMgz/eph+lTUjGNJw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s/X7rJZIspktyeOm5hcC/vCKDgKKdxi/VruTwkJtPZHK+xuv5QhSU28SRRC4B5KexbhC9EroYcpNEIzsVvBVug9MzTKcbQS9XTmk6LnxIG/cb7cxAbtH2RTBwCVawVb+9KeIwE+Ib+v83Up5uxk924sr2OzF05RsMz0LhsqjJdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d49576404so84356825ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 02:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726566662; x=1727171462;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WAEizX9Y1SMbjSDqtNh8j+ktqk2hMLvxIFTpNMvgJ8=;
        b=GmFprBqtREp6xnQCdqyQagG/JtsqANPb1tXp3cKcot/5eEeieT5N5yh9UlvQVhzieU
         ZLQlvgsQes6l+EUAE0HmpGHT+vtVGmWuY37Kygow0d1Dbn6b9SS0Yb0ONmDi32Isfhgo
         8s7edK2PRJAMHrXP3UvadBj+tctyVamWvR9v8dav3RZB+XI1Ttp68qJXv3XECLkwCFia
         s/i3Akcn1JFCLtQuobIS+K6d1O8V4NFakYtlcH1WjsimFHj9w2yez0MwiDF6402bF/98
         BpKdWCcowm8r3xLqDTpK09zaMPJ0uevYaaM2eVvcNI+b9aictwQKiou6P7E29L6CyT8q
         E+0g==
X-Forwarded-Encrypted: i=1; AJvYcCWxAFa2n+GPzRQaL2Nk9aCgZxrENkuJCAqye7R7nM9ARdGeSrT945rZpd38MlpmsUjlg5fCTJ5Wig/lGpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzLfl9mxDqizWJtj1WpVi1siQSFQrQnFuPAD5RElQ7GIF2Ej54
	v2Xt+m8kfN9Czcb7Ue8Tb4qLKB504iqMs1bxpo2RJgmWBWhEolFZqq9HsY0QpWdKE5bjg4oolpU
	o57zGSbWdJQZlfN2t/JfeGUoc99hR3NheOdO5jJhfZTFEzGfICqrxP/U=
X-Google-Smtp-Source: AGHT+IElAEl5pwEDniwyOyW0Nf1KrDJxFTCIQQfsNBJMaH4x60gTb1RTLqMDHomFXNXjut1/m+HvyRhTOj6ZfZj3XtZ3uDcCjebb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c5:b0:39f:5efe:ae73 with SMTP id
 e9e14a558f8ab-3a0848eb2admr187448595ab.5.1726566662251; Tue, 17 Sep 2024
 02:51:02 -0700 (PDT)
Date: Tue, 17 Sep 2024 02:51:02 -0700
In-Reply-To: <0000000000006304400619bbfae2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095b8f806224da030@google.com>
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in bch2_copygc_stop
From: syzbot <syzbot+c6fd966ebbdea1e8ff08@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f5095b9f85a1674a92d00e7ab466499a8ba49ce1
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Tue Jan 2 00:42:37 2024 +0000

    bcachefs: dev_usage updated by new accounting

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1256e29f980000
start commit:   adfc3ded5c33 Merge tag 'for-6.12/io_uring-discard-20240913..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1156e29f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1656e29f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f94136b4da4e897
dashboard link: https://syzkaller.appspot.com/bug?extid=c6fd966ebbdea1e8ff08
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10936a8b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bdd7c7980000

Reported-by: syzbot+c6fd966ebbdea1e8ff08@syzkaller.appspotmail.com
Fixes: f5095b9f85a1 ("bcachefs: dev_usage updated by new accounting")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


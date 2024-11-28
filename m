Return-Path: <linux-kernel+bounces-425002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 233E19DBC52
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3EC8B21BB0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DCC1C1F15;
	Thu, 28 Nov 2024 18:56:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0001219DF77
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732820165; cv=none; b=U0yyv4hzRI6ea5W9NZW4ca3CVJmN7ka6ayjVG/8bMijkhzkWZjjU1iOjMIYkiHEslwH8NGyhai381bWLWdVxQLZVuwkl1ApCqAq14PEUG/pIf77S7Fah/NK3ri+moJhrtjunNWElIR1oUklOn+DyInuo9vCBpTZ8pzCzrls05Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732820165; c=relaxed/simple;
	bh=Z+PpZtkz/FpeuJ9ipJoPBWSHvemXysnT3IG2YHEnkjM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VIet1K8+ozUc0V4vcWWy6QADiHhxbra6MEuRNCRsOr634IzUJygQNsuTcAHLAajcjrvoz8pWZPPR1/Hd83joC/nckCrPTC94mbwyT8kYzlmdZiEtbSEb8R8IBoaL84X2Ie/t0Z5RSr1S+TwckTs3b6x+Nw3DAnenZ0hnm6gXbvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a71bdd158aso9901765ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732820163; x=1733424963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rFnkMusVUvztaavp+Wcshy/0sAVSnlDNlHNqkEC4OWw=;
        b=fOdn0e5499dSLk6XEjb8phW4RE2CdIDq99DEWGxPfiSMHh1tTuJz/aKzUZqUScmRiY
         t26ert2XKBJN6kPJMcRzT0OiTeDmdpmIDNz7Z5PbyAGchkvIjSHvZtMYLVBOm7qP78zD
         zzsv+BrS1K3sbahUWPGV6CTVYg46EyIEmUwt1yzb4TXEP7RgECsybgspg9y/YR+eotXn
         M1q3ojWvrj0wpE2wHxHfb2DKxlFS/+WhOMFyu9bI9650FF6VLrvoTPclRC0TB5h6s6Hr
         RKAJtl6gUEUiFHNfmdx8kw0BHlpVXZVpm5z/r3DQDbEMzOqxOeSZiDp4Vcj5yf9syPLr
         YuoA==
X-Forwarded-Encrypted: i=1; AJvYcCWGKBVhaTpIwIQtFq6/b02Ggu7k0a19cH0bt/8wIj/0oD9LYgba6oK2ATzd8rYG10DNjQ5o3Kg0RxRozmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQff62nyS27zwZYCm8wRYt1nXl29q4H8AebQmLNbIcbgLlsSfK
	FPmGDxgWL5m/hCDU9yaluTwqkivRnHMDPUMtey3+nT+uimXQOBvCWqy9n0H0l4eW+9d2nnitwy8
	0X2sPgLkIgn5fIf7Fj4NUTdWElSoPYvc1QG7rSd95zNXMYymrfWZWJLI=
X-Google-Smtp-Source: AGHT+IGNAXCnkSyv5wsjsl1uLr0IvOlIpNkPenO2sAYjOOEncjSd92ioAVMokDfo7yC3eNrZ0aBco1l6dWJiwOCw+6uPBkUTfWGX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2164:b0:3a7:6792:60f with SMTP id
 e9e14a558f8ab-3a7c5523f52mr85784815ab.4.1732820163265; Thu, 28 Nov 2024
 10:56:03 -0800 (PST)
Date: Thu, 28 Nov 2024 10:56:03 -0800
In-Reply-To: <67432dee.050a0220.1cc393.0041.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6748bcc3.050a0220.253251.008c.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in __folio_start_writeback
From: syzbot <syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nogikh@google.com, syzkaller-bugs@googlegroups.com, 
	willy@infradead.org, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c87c299776e4d75bcc5559203ae2c37dc0396d80
Author: Qu Wenruo <wqu@suse.com>
Date:   Thu Oct 10 04:46:12 2024 +0000

    btrfs: make buffered write to copy one page a time

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=165dd3c0580000
start commit:   228a1157fb9f Merge tag '6.13-rc-part1-SMB3-client-fixes' o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=155dd3c0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=115dd3c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=402159daa216c89d
dashboard link: https://syzkaller.appspot.com/bug?extid=aac7bff85be224de5156
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13840778580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17840778580000

Reported-by: syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com
Fixes: c87c299776e4 ("btrfs: make buffered write to copy one page a time")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


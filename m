Return-Path: <linux-kernel+bounces-273310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC6594673A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 05:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9912F281F70
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 03:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2C110A11;
	Sat,  3 Aug 2024 03:41:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25466FC01
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 03:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722656464; cv=none; b=u0yflQ1lcjEYcxVUM1q/QYNtPd63eybiRs9/OxLcpzC6nbJIiTBirMq+ue6H2g/Vq/fEQOZnnkFlyVMuql1TU0/OIiCqVgbBJ3hGO4Pxg5UlGSsMfNkgYIsopvzUQYQS0g04AGekt+PAVwL5EbqXH4q321TSZkS3qcpvpH2Wkb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722656464; c=relaxed/simple;
	bh=QSYOSs+PPeGn0Fj/hST+nM54iqIC7YHT/BuCNr/JtOU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nIo739iGifAKmqM3rnXrqoerl6J1TUjF4YDsYSsvgIatQ85c1vOkgWGI9m9e4Rj5jA7qvYB5uPLxD8BtoSxu1S2XX/EDmx6+SJunX57u3/aY9zRNbq2sFGrryjsTW5tsD+uliATFsBCNdT/jiihLCaPvI86Ap3qSMJqhDMY3Awo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f8489097eso1347555339f.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 20:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722656462; x=1723261262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wzrvlNvG++STwsyNxmgtVlPe18LXVowyJ1Ofn6HrFA=;
        b=UHPxZ2VOrDFqIJNJdx0jzs8rDlipDlvfqElbDqmLbPz1QpjolLKJJHZ0uKaYwGBHAF
         qwnIseFgvnkLVke+mYNC25durgQvx7RJdAV74Zipf0B6r12jXbTG/jvC7/+QyWq1OB2c
         QSKoJo6mp7atWMeWyfhN6Io+mf5wm0mWshpd8OTN8DqhE0wDGSeRTt0ohGFr8b4E+I0E
         8bQvbV2QbVzeRCBmSAWu2qoDxMyC2MmQJ1TI7z23uJoka+oScGlVryVYBB82u2Ye39Yq
         bsNYuqIC/OzK/SAbyxm2GSvgWnyrw0WeZMq+UnEc0urUrPFqJevSVgj9c++iLtLSqFuV
         EnAA==
X-Gm-Message-State: AOJu0YwvibCzSfuyDhvMnlz73gYTsj35+FV6AQe0ypK9T0TjsrjTFTHj
	B8x1KJNqZapXiz+fFzygSR7LAetvYcW5TqozeMowI+Vn8UQkByPZoiLe39cuAcI+auUW/jv49Uq
	lITg9XZc2WM5Qu1F7qwDhh5buJALMwe4UWLmMVI7K7BwGdM6bMHCiwJg=
X-Google-Smtp-Source: AGHT+IHYmiej0gIhOanOyxdeRZ77UuqW1jFNbVq/FHs64FAhpLF7Sjr6mPzuBYqLXwlVfZiUejrFVQ1nVioXJ7N0l0XXw440cKzJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:260d:b0:4b7:c9b5:6765 with SMTP id
 8926c6da1cb9f-4c8d571c3ccmr325681173.5.1722656462235; Fri, 02 Aug 2024
 20:41:02 -0700 (PDT)
Date: Fri, 02 Aug 2024 20:41:02 -0700
In-Reply-To: <20240803030358.1213065-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000807a3a061ebf36d9@google.com>
Subject: Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
From: syzbot <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com
Tested-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com

Tested on:

commit:         2f8c4f50 Merge tag 'auxdisplay-for-v6.11-tag1' of git:..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16b9dd11980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea3a063e5f96c3d6
dashboard link: https://syzkaller.appspot.com/bug?extid=24ac24ff58dc5b0d26b9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=143fc69d980000

Note: testing is done by a robot and is best-effort only.


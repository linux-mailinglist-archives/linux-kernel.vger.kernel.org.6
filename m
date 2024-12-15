Return-Path: <linux-kernel+bounces-446267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 665079F2206
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 04:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE6B164F66
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 03:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7208F5B;
	Sun, 15 Dec 2024 03:21:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB4233FD
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 03:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734232864; cv=none; b=hI+Ko5P3/3OgnjVANPUS32+XfKzpgEJpEbzbt22qHPGA6oRjLnidNfZiAMz3z3FQuEQH9gwAlsZzV7x6CDJMuOtH7vw6OV9GzNDmDAiwtJ29ZAY6hn+N8OdduToUBGyHumVSoMxOc3Jcx8qEuJPKmnGQuU+nLCPz57+YZHiGAA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734232864; c=relaxed/simple;
	bh=6aqJV0rhlMn0UbrS6paTpIqRGQToYigXJOP/27DjeYo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o9g9lME8c+CaUKeNi+DJyMDuiiuN3uePplS9qKRNKogmhoM3QclnyMNgyZFbP0mk9fUKuQfZWm9LBjw+qlym+obEhVj3+UsmOaPTrmzI8NoZmDZh+CjVG9EKXYCdn91zXeYnj5YCJffI8Dufsjq6vENlEuHdcOTGBUo5oJSoMuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a9d4ea9e0cso30788975ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 19:21:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734232862; x=1734837662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+Vcn1moma+9qnFa/6djJ8htYTS3IhloemAdDGEwDzA=;
        b=elSv2UbJJLlMCiw7NGSq/9SgEx2frA9k9gPE8u9pzhsyhUhqcH4IA7YTFrnff1pJaq
         BRdN7UCEXxZWAHGxqe407xKPXCb3ULvvFhh6L+CSwhJ7KH6S7ZE4lPgYN2DfDKAmhaZ/
         UX0PnlJ1k6TOw7VmHv+XAhLtBt9G1d2KnEltVVkzxBykduVx/WmB3HPEbAC6J6EC7WAE
         J0lFzR6W6eqZnFzXL/P+eWfUHz1uU0H/XOmpuAmzPKQAOtl/IVRGWARGlZOI84Rs5KUb
         IB3S7pDbGKgYOJSImSHMk34qZuV+5zuKf3qaie1saFZ7iTnJC1azEMkLP/PD482NJYoD
         G6CA==
X-Gm-Message-State: AOJu0YzPtbujzPoY3ZN6om+5NMYSgtwpffYEOGzp8YEjuJAXlOve46qq
	+idIIO81saKbH3pgRiZKB3SPmWi+DEn5jkRbtB0F0ES5PBlP8PAj0BOo7nHZa5GAWGsHXMqEiTB
	aNayvNFdrgpZAOb5vASixm6n5NMPhed5EmgNRTFBiHI4ECNMc7bKA5Oc=
X-Google-Smtp-Source: AGHT+IGslKKRWt7JFQSAQyVsFqibz4jr5zNTMdRAs6ddrx1npRwSgMwqPEbxOrbyWqTrrV47ARqf3Cbgsg9zLIc8l53vbyqySyOi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0e:b0:3a7:98c4:86a9 with SMTP id
 e9e14a558f8ab-3aff8aa417amr104514205ab.20.1734232861916; Sat, 14 Dec 2024
 19:21:01 -0800 (PST)
Date: Sat, 14 Dec 2024 19:21:01 -0800
In-Reply-To: <D6BX8NKJPY21.2ZDTR243JVLCI@getstate.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675e4b1d.050a0220.37aaf.00e9.GAE@google.com>
Subject: Re: [syzbot] [netfilter?] KMSAN: uninit-value in ip6table_mangle_hook (3)
From: syzbot <syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mazin@getstate.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com
Tested-by: syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com

Tested on:

commit:         2d8308bf Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17926730580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f52f17eef5016d2
dashboard link: https://syzkaller.appspot.com/bug?extid=6023ea32e206eef7920a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=125d3cdf980000

Note: testing is done by a robot and is best-effort only.


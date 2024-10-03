Return-Path: <linux-kernel+bounces-348942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEBD98EE44
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694BE1F2169C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28D6154C17;
	Thu,  3 Oct 2024 11:36:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3278A1474C5
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727955365; cv=none; b=T3XCnx9oukR8iACJnw9qChEvbChu+ys+2XX/UFkZEI7wIhD/FpBDYnS6LgFTqj4GJYZ4Vz5muWdq2qIS/aZDhyshwQGhz+UNWiDyQWkS4ZYy5FhCM94CtTfSKyNA/cRYwqAmds3j+CvWuLLYZKXn3nohBD7Rt5ZivsBUApgv7wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727955365; c=relaxed/simple;
	bh=5mzjY0sXrWU+zDGxkM9kDJTFNWVtRUFMIFNzUNtRj90=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S/o2YkEPGGfWdeHm4uKaN8ZzOPl7Ivp/lxYNfxwytNp5CWK3ItEWdBZcfDjqJcMkOrcv8qAvQDipVEl/DxS8YDnTmFW0Z1XyKn9vHnyvEbCBo+W7td0dMT4LZq/PsJHHC1pEISkCYpjjie1Gs+LAf0i+uEolbd1eoDAPZZCRzsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a364acbd2eso7759005ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 04:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727955363; x=1728560163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PoPvk0UYgPh1Fv4E7YSxt0FZj+CzecW59W9IsPrRT1A=;
        b=a7tq7jcZfaT4gKxCIiHa6qD8DBjNinLzVg4kUeufPZ4nj2OMHdf0inh7zR8A4hD8jp
         /3ooDGkbihgwpwzzt7oJLzCZGHriOHNX+izSQ/FMZBD41OnHV04OSBifDGm33mDJCKbx
         2e/rvCYM/U64QBxi4JkiF/dbQEWocwqzxST1E3xn6Cytu9h9oTwON3vFnwFQc7grDniL
         7LiMJYPDKGi0L2sIPf6Qjdn7CruB1FL/l6vOn2eUi8oe4vld2TunNa4xx9610QyIksMD
         juxIshmhTI66KFb8Mi5B6uKSi5xPKy8KC8W2PQWZMNzk2GvHahkag7qOLz6SNazGvqqr
         4WPw==
X-Forwarded-Encrypted: i=1; AJvYcCX6zle4nAshi4r/PFjQTY3es9K4YKFOSpwmb/zLpa2T/ljSV3hzoVzNSGdupUXDbVhHWrznC17I8JktU6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxo6g+yIpLmSAwNncOEU+BSVuse6MeTayE1x0gAuLAniYH+qP5
	rerp3/7FnbsLa6hhgK4j5NOvvk4LHAr9z1eGYhcM0/I73nV5jB9RxGy/W2QDgRvLjQ3WI3ezSPW
	BC2QQYmI7YVtTnDD5Qgt41mwYfW90iWj5kYwcd0dnOW7/nPmBpoyGqP8=
X-Google-Smtp-Source: AGHT+IEVIode8K3YekPCPx/GcCCQJKTboi6iFC2nmg105661tbPDgq0vhSL53NBqzP8xUKNopNwBbUW9c/E4q/yP1SQWqw4i03q7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1946:b0:3a0:ab86:928f with SMTP id
 e9e14a558f8ab-3a36595a16bmr51279915ab.26.1727955363357; Thu, 03 Oct 2024
 04:36:03 -0700 (PDT)
Date: Thu, 03 Oct 2024 04:36:03 -0700
In-Reply-To: <20241003105934.1979-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fe81a3.050a0220.28a3b.0211.GAE@google.com>
Subject: Re: [syzbot] [mm?] BUG: corrupted list in do_compact_page
From: syzbot <syzbot+b7a3118f6a494674077f@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b7a3118f6a494674077f@syzkaller.appspotmail.com
Tested-by: syzbot+b7a3118f6a494674077f@syzkaller.appspotmail.com

Tested on:

commit:         7ec46210 Merge tag 'pull-work.unaligned' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b9a307980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6248f0ab12f33349
dashboard link: https://syzkaller.appspot.com/bug?extid=b7a3118f6a494674077f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13aed927980000

Note: testing is done by a robot and is best-effort only.


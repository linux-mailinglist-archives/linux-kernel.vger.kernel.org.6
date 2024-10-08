Return-Path: <linux-kernel+bounces-354946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BC9994500
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 12:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2495286BEB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0499418DF65;
	Tue,  8 Oct 2024 10:03:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7E918BC03
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381784; cv=none; b=XXUr0v0axKP6/AqlmA9uGVZnTU05BnqaN1tA87CDtIo42aE8a7pWoiDiGN5RtYPpGX4Lx+xELuyQJGxY7B955nmuGQFl0oBv8EkB12FSOQbDh/zALctDjxJ0WIZQoO0OMdRsswFu/bLA2oq0bZ3YL3Td+2zIRhq9v+CCdbXuk38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381784; c=relaxed/simple;
	bh=CAEWxPrFRKScxByaAJ78wRJWn7m8oaXZ4H66Gc4jqIk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LyXImNVT649ecU7XfaQfIekL0+/COW6hbt199tCWFkm/h5I06UcLlgo8yaZw0e5dF+6Z2RcD4Aj0CtV+i6OFNRatlvF+1yISLrAPnQrJ8rV8qkpTJfgoOe5bSM/9ngAvsqZSzdIWRZxFcRSM+wCl13TfB1eA5Zyo1mv4TQfrG3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82b930cd6b2so791318739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 03:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728381782; x=1728986582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ElZuUT5tf3AhyXQhKTHLJGL0EUSCnFKm0SgYF0oqKU=;
        b=NahJTf9ls0nVXNNJlkVgmlCQpjFow5Enok/P3LqOubVKKGI4vdztTgvRhYKquBxMgP
         nPB6Fs5z0XRfmfMypqmrL5xlvoyTH+DswP8xnBrtFGwgX/nvpzACC88BGlg9F/TIcuVe
         3lP99MGiVHHNFZsYhfh7uX7CgK9GnGyhaJ2QzMGbIh/obfv/gKQEe869eTrnbw8WUc3l
         Rl1aYkLyIfDFk3RJWM7LbeNbPMeSwBR2mZFBJq9+MuneTJcqy02uz2Ks0xHGbIfD0lK6
         K2zZcyIK5acKv5t+Pd37PnQCCyHFEoAqSbvIlf5xq/Izxf4tGvcKzFb4AfpS7ogK7RZ2
         8eXA==
X-Forwarded-Encrypted: i=1; AJvYcCXv4YtyxZfTrxzvtDSi7+LRuFxTRagzEpfUuwq02U2aLiiqNDZC7oynQx8BRxZfT4ci00FrCBut61EQvcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIWBTk6Q88LF1dQB3rErP7fs7IQQ7LR4gZrhfvsvXOwTptq+vw
	KexMF4iZptPLkI2Srej3OKSQCcGV5YSIEgVu5R/Xyl34hLCs/Uo3jjJE4kjWHOVaAM4YH9YjKuY
	z1o2jhFewWir3Q8fTBsLrHMkTccFTTKCoS8aQPed+Ko53tDV4/s/Pg/M=
X-Google-Smtp-Source: AGHT+IHQg4eCsJN4tdqPJ2+dXzB0T2qaM0BNmTRhXiZbSRnNeby6NPKvqKliC5SM+GqG5MZOifLC6tZ2uAXgIzcpZLUu5GWoEDWS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164e:b0:3a0:b0dc:abfe with SMTP id
 e9e14a558f8ab-3a375bae0camr148534705ab.17.1728381782345; Tue, 08 Oct 2024
 03:03:02 -0700 (PDT)
Date: Tue, 08 Oct 2024 03:03:02 -0700
In-Reply-To: <tencent_E64189A52EEFAEE6CC83A7C746FAD2E6C606@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67050356.050a0220.1e4d62.008c.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KMSAN: uninit-value in hci_rx_work
From: syzbot <syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com
Tested-by: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com

Tested on:

commit:         87d6aab2 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14eba327980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=981fe2ff8a1e457a
dashboard link: https://syzkaller.appspot.com/bug?extid=6ea290ba76d8c1eb1ac2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11cbbb80580000

Note: testing is done by a robot and is best-effort only.


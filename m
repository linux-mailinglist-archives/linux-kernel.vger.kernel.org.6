Return-Path: <linux-kernel+bounces-227076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B499F9147FC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F4F1F23D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9365A137753;
	Mon, 24 Jun 2024 11:03:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D159C45025
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719226984; cv=none; b=gPM5KigItAEDzn2wOcRxlw8zQaxMqJqEwjvaPK8JcPqTWPDv89XpcTDLyiXtRv2jA2wGF2pqTdNNceuBKrmtvPtOBJHedRhgylNckgp4IwLbEl0MPnWTUuNo2+SA3c+gLc8AiM+2WPWf2rBhsUOGaWXpcieLT/WO0s4NpxvWyKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719226984; c=relaxed/simple;
	bh=A4RLSKKvWqbmhuRy6ur63eRO/GaUAPwKmZXo4ggvReg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X5c9yTq01gtRpOP4zz4LP7WYs4NwEClr3e6yWHMS3i56oafgXXkkdfhPZv/SgU0NLqfE0TVwTFHsQr/sN2QNkeG7lmxXkRhdjK08VeOitPzOvKDXuMuhFm6HX1M1YlwdoNUIVpmi997mCGxI/MPU/RZ39V7bhTjzB/2FbrfDO2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb80de5e7dso567270339f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719226982; x=1719831782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wilig1T1QNrdIwGiGCVm7ookqCr9s3+3igppAh7gh1A=;
        b=L3WOy/aR6ZB2XpksfPMYLYy/4iEOtH8KBjgkSnCUQuG+MaTGfC/FsqI+IRK7tEVTOg
         ONkNNe0MvD0rvIVyRIx8CAz47NT456sHOpys0PotNlXRwcIRMemklz4dOMobxTKe2hIc
         sVcZwcVWqjW3YxVNBH6Zrt02l8JfKQj3EBXAJ/NKHgDS5FdK1VgxjO1z7tC1R9yC6dtA
         ve4CS/R/1EuM5F85GHNwwSTfZM16ISu7psg2PMH3DxzsYPpvKJSLJBWeP7MtEqoZlM4e
         dt6bpFT2rQbN6cUIDrT9WDdNBX4HLFw5KiBWEFoEnd7/U+gg01Rp4XCKK93KHEjJr7o3
         ojPw==
X-Forwarded-Encrypted: i=1; AJvYcCWbpW5cmZz6oCqZJosDb2qqgR0nQ+H+tiw6KMhr7QOhCHvID5Vx5zLZpLTGYuToAzOIr3CSU47lO3JQc6P2w1P6BDenJBWV2ZU2M0Mx
X-Gm-Message-State: AOJu0YyH1kOkKgruFbw827OWSsTbd7w1cmg7hDOqfUsXMZOv62dgmB6/
	zKJz89Q+hkV+Z4fz8xZ62mMxhvxmxlqZsnc20p6hdrD/mOHF5tUfYyW7OYeM4+p5WbdMhpUA4GX
	to4RUYhFbzQZhIRwuGdLnNBaoYNJ05LTO42VLgh3iso99sYDxCobEpVM=
X-Google-Smtp-Source: AGHT+IH6/MpuaUb+nybUj/cGTz/Wx/EibEHlL2xDhnCWSNM7Z8pfb6bd57a+BRYjIJcGpwbOqEGEIKIG1MJksHYP6f9JKbenX+tb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c9:b0:376:44f6:a998 with SMTP id
 e9e14a558f8ab-37644f6ab3fmr3925725ab.5.1719226982003; Mon, 24 Jun 2024
 04:03:02 -0700 (PDT)
Date: Mon, 24 Jun 2024 04:03:01 -0700
In-Reply-To: <20240624104001.2004-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d0501061ba0b90d@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: invalid-free in hci_req_sync_complete
From: syzbot <syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com

Tested on:

commit:         2ccbdf43 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12cc99a6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=35ebc808442df6420eae
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1347808e980000

Note: testing is done by a robot and is best-effort only.


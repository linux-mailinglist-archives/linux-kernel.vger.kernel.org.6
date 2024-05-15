Return-Path: <linux-kernel+bounces-179867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1558C66AB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9283E1F2358C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158488564F;
	Wed, 15 May 2024 12:59:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3063BB4D
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715777945; cv=none; b=s/O+8FN55O10rtU4da8xaxPOMNBFe/XpD02G8kBy3S3zW1ATQ9AoQRVyH/tW8cpYXt1r2dYcsprmkIXB516W1THFyKqnbVVMyzBPAnuJl+Neh7SjFmIqBJMQPsP7SIoQEob/dqsxzNjvHIjoTJ68ndi+BBhjQMSkDcKDhUy6MUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715777945; c=relaxed/simple;
	bh=pU0KDP8PaOrGc7nhuKl9eruKdWFqqXHiWy9Dth7iatU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WpmY0ff/UfgBgQJ49rsacbt99eQUa4BMWAwZFxkkYSIlTAljpuHkrqbPlcqtkOYBnsGP7drJexVR2cOmX+xniCLMKPY0VNnnOYUvH1IJGKoYE8kPPqTi3ToBIF/F6n2uJQpGHXqSiROBiCrle5u74Vi5NLiIWngocne6mCw4ORY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e1d6c70aeaso456043039f.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 05:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715777943; x=1716382743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3PdFyk99KlLZYyjH5ckDM9d4Mbdv6L9rZe9o8cYGsMQ=;
        b=vQVMTnmzdBABO0YkqdMpnDMwJQ2epcbmbDP8cXc6VnycwtB9qBwQUrLBZSRdPmDwD3
         Invw3VN88gXa3wGEjOVSjAt5t8HG/Jm9en94+VPKACZGn37UbOVlLBdDkX1ZRgDnq8FE
         eCACvdOp/U/2HRnHJgBxf1H4ohTMcnOXJJe3qJN0MRQexL9UGEjCSnRHkTbaJyolbwtN
         vgxTW2fpjQjb3eH8T2mY4niNURb2XtWAW/nEdzpQ3tCN8aPJIUrvL/depHrSZvo4ZEZ1
         G+91m6ESVBBio6NQPuA1wq42pUAnKrx5vTyhtx2hhj8bbh7O2erjWa1BeiqRMxisGYpH
         Rxzw==
X-Forwarded-Encrypted: i=1; AJvYcCXXls5oJEMpcMrZl5pzU77JbMHMOmc1LoyrO2eeVjbOJxxc+/AySGiTXjndHKLl8GJP+WzXfy1sMXgmhzVgZKTuZNJXuDPS4FnQmtDH
X-Gm-Message-State: AOJu0YxoNGPdBe8I2NjDfKeGEAghtjqrjxA+Cp5cxw3GsF+CHiGkc/Oq
	BCCxJ0WY6DLobB3fkQ+pk6s93Z5ECzI1asnG0KTeBMqQjw1OcRKLmlfMNb25kfVi0sniY4fYFaz
	uCI7X5B65t2L4NH78KTu98QoAUzPRvcYevUtDgnGex7bk3kJWWiVMUho=
X-Google-Smtp-Source: AGHT+IGZaAUobKyp/kGTV7THt978f/NL99WtCI80kanlZYj9xf9fMiK/SHuTneYWfG0Bcc4mFoW2xRU0e7OFh7WGF+spPvbLpaY9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8305:b0:488:e34a:5f76 with SMTP id
 8926c6da1cb9f-4895955b89cmr1154319173.1.1715777943434; Wed, 15 May 2024
 05:59:03 -0700 (PDT)
Date: Wed, 15 May 2024 05:59:03 -0700
In-Reply-To: <20240515123946.874688-1-andrewjballance@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d50ab606187dae67@google.com>
Subject: Re: [syzbot] [ntfs3?] UBSAN: array-index-out-of-bounds in decompress_lznt
From: syzbot <syzbot+39b2fb0f2638669008ec@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, andrewjballance@gmail.com, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, skhan@linuxfoundation.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+39b2fb0f2638669008ec@syzkaller.appspotmail.com

Tested on:

commit:         1b294a1f Merge tag 'net-next-6.10' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15998648980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0cd0c5dbf8ea592
dashboard link: https://syzkaller.appspot.com/bug?extid=39b2fb0f2638669008ec
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=115b78f0980000

Note: testing is done by a robot and is best-effort only.


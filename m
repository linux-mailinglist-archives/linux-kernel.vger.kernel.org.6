Return-Path: <linux-kernel+bounces-179329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B798C5EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 03:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8774D1C21112
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 01:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ECDBE48;
	Wed, 15 May 2024 01:45:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E32BA94A
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 01:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715737508; cv=none; b=n42nzT5NISqn7P2VhqJ9w8qiBisDRfGpGxToSRdZDaD55Rc6fKT+vLnCBAQKUntlELiZ1RAbcjLlPB/ZBoEmGbGKCxEvlY3DHxfjR5UIZsHf/CN/FDUf2IHV5a9AoPJIv6EmZ4IluaVR+LV2cvyABRxU8YumxKL2kzUIcqgrYDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715737508; c=relaxed/simple;
	bh=7wOWGfKyJOdjCMfVYA6ZTG5aB6uLRYDZx8QuLiTfFSo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CdsDaW/0j9+uzCPfMnRAo72hxl1wCL2GRdBpVP801ZURQu0bLFZAAClwGqUZ72OsfVgrGl6ihqM8TkfqPDVXuT8ydyJgJXkx4nDQ1bpHZ3yp6KSQ8o8LRTmZ00jk1oFpG9+FW6YGtr3tcR64aPlhuBifCCefy3Y4qrJsiKnf6wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36d92a840abso32933365ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 18:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715737506; x=1716342306;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LYIKOU+WSzPipyUCm9VKbcGcLkEtS0/8Z2R2tPtjVC4=;
        b=qRkfEK8yR1qRRmZEbymG0337peoPUAmmnwOMnZikTHhS+vAZS0vGdJEFKoquDQ0L4B
         Rglub0VYV2ggcH+9CwzU1jp/XS8rQpZUcFUH+fNI9q2wVAjoI2fT4cYorkGpgt6474V2
         XASS845Y6JCWYq0F6RT4D8laPefD0ox02TVkxBH2bMMGY3DnxY4meHR5biNpZiP2QWd3
         vi/+jMzFIfbfZb/4r6L4aLicZLPKXa5N3iG7TcwpTESejX57eClmMT/01YUmits9raFb
         1+Dgyj8SGxBJVRIF3iuQs5hTwV5kkUnDteNQ3p9igSxC8c0eQ2JtDIkO+v8dvyVvvE+3
         3bZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDxBjn/D+lIusOw6IWm96iip5qdbW9+41hNiin8kGCmoIim7GHtbMRFVtFYtxn7ZbU83ZQbCzR8cPbuV2pJEX+wplRyRa/50iDmq9Y
X-Gm-Message-State: AOJu0YxBEOab6SevEgggfc110ikz5NV8maHb4u8Dwy6VQYA4JEuv/BME
	is1ALf1c8ppLShTgIKOgXrf6sifVIloiAIJHGQg1RyqE+4nCaRCMg5u6sjYzN1wMvMmsQgJR+rV
	gMnV8zRBnStHs+VrGCkwwaboQ4BMUJOMuemIrzqkt3JVEr36jQp9G3Ps=
X-Google-Smtp-Source: AGHT+IFUVJaWh2AT6ZrtwsTVPSWVH8IQ1bc5ycEQPln+bJSOtRdd95+Ltpao2IaV0NbcRBoLoGt9b0UY0dnljkHx8draZHMGshoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:da4a:0:b0:36c:4b24:987d with SMTP id
 e9e14a558f8ab-36cc14e79ebmr3727985ab.5.1715737506394; Tue, 14 May 2024
 18:45:06 -0700 (PDT)
Date: Tue, 14 May 2024 18:45:06 -0700
In-Reply-To: <20240515012430.2481501-1-cam.alvarez.i@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098c64606187444cd@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in bch2_sb_dev_has_data
From: syzbot <syzbot+249018ea545364f78d04@syzkaller.appspotmail.com>
To: cam.alvarez.i@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+249018ea545364f78d04@syzkaller.appspotmail.com

Tested on:

commit:         b47c1823 Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=143d3084980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=81bc9f1b05e6fe63
dashboard link: https://syzkaller.appspot.com/bug?extid=249018ea545364f78d04
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=134cb5b8980000

Note: testing is done by a robot and is best-effort only.


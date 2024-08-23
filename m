Return-Path: <linux-kernel+bounces-298595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F85195C933
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C1D21C2235F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4700E14B095;
	Fri, 23 Aug 2024 09:28:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6FC14B09C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724405284; cv=none; b=QLw52q8XgUxWNP5Hd9626A5TTqOGKCuL0+4DdmJHnO/QcSeJCLTYlOrP8d02/+VapHzxQGuz32H/8W5DVysjjroo1re8dfiC1S9jSnbwWon73kIlXoF4xSqfQ6AId/ihtWp0Jdp90+dsEAOwhbkcmSW1DFDz5DN4ffF0XBcFBtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724405284; c=relaxed/simple;
	bh=iynXqP56ixtaP4nXJKR31NascYrrHan5Cn00P05H8CY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DUazGFNi4LlHNiLL57IzmZKPehIh0t0mMXVooSLereHh/zCOEOubS8zmjqvTuHaVpf3zT6yLx1ozbzVeYjYT8FwGbKxeRwF1FGYINLnQFzgds91AHHmDbMXpaLO3t2uY9wy1q23QO04nP3ali6+6wK9y7yPV32Z18jZtVjUz+EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f9053ac4dso185133039f.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 02:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724405282; x=1725010082;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KttlhmlTALgfg5PUGPLqtRN0LNsASsNIispna5Tm+vE=;
        b=p+O6tQBom+PgBWDlLjmlXm7/QS4KVWR1swOUGXLeorpHzcgd+f2Wv1yvUb/9cJlXQT
         kZdWHiYnHcpeCt1H8MGUcYlUmPrr/NeWw/T5YBSWTTIiuW1DkZFmTZatlNRiPogjkPpU
         trup2abaOpElhuqBiMBRoxFrnDW75O8QIqZMs1Lmt4C+5HJ3OpjoSkcY+kIiH7Wnr1w5
         tEieGqQ7KUm4qGvDHyzqVBZEI1I7UqNmGQ/Hjv+5JutDqZpc/K1znKdrHnvDPS2K0iDT
         mVOHye7EIADmME3ER0TUjdKt1paYVf4WKeV+wnYHSaJkbAu3T3wenjCG4ZkUdNOjz4O/
         GVyw==
X-Forwarded-Encrypted: i=1; AJvYcCUmO+euQ7IT6uPokHt6T6LiXP6j1VtS19lfkuBvm4HCa/WnoDIIrctaHq/mtamwF3kO/WSUBc5p7+BPSUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKcz+LYJfQtjk3YCAUty5XKqSxVzQV2Oq+pyXJXXaAv5l/XBkQ
	8bXUNza8+YzXCCn5Jw0dm2F1dlHJbvB5mvHi0O1Nj/X+KKvz6Q1DAnr92sb4y6iIMaQf4cjcw0s
	2uyKaXLLBXpIyx64dm75cdqzSQm2HthlMZstPaZLd1vVHtEszR8VeiMg=
X-Google-Smtp-Source: AGHT+IGCLJEvGQ1/lj0IWgTn8+cOmkzRFeXpzvYJW36WjkLV2evLDQkx2eQ6rcO5qHF5wRW6NFcSobol36qqwhPnfKzwOFslEWez
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3404:b0:81f:7e75:4040 with SMTP id
 ca18e2360f4ac-827873744a5mr1994739f.3.1724405282584; Fri, 23 Aug 2024
 02:28:02 -0700 (PDT)
Date: Fri, 23 Aug 2024 02:28:02 -0700
In-Reply-To: <1fa0a253-d36f-49ce-bd6f-d712fb1ca0df@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000514e4306205664cb@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING: kmalloc bug in wnd_init
From: syzbot <syzbot+c6d94bedd910a8216d25@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c6d94bedd910a8216d25@syzkaller.appspotmail.com
Tested-by: syzbot+c6d94bedd910a8216d25@syzkaller.appspotmail.com

Tested on:

commit:         7529036a fs/ntfs3: Rename ntfs3_setattr into ntfs_seta..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=164bcd8d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9cfedede3362b1e2
dashboard link: https://syzkaller.appspot.com/bug?extid=c6d94bedd910a8216d25
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


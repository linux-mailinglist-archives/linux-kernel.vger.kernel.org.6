Return-Path: <linux-kernel+bounces-268415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9FB942469
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 04:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386B3285C91
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E45DF53;
	Wed, 31 Jul 2024 02:04:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023E1FC02
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722391445; cv=none; b=ocXcAKP+tOquIzCunY0bhGR/e0ehd7138s7xmyKZuz6ddh8ISUTozXQ+lIVsaN7l6ZATunQsjJLT/OjwX/tydfFZRvg2IhaR6jO/GfYErOOKZiQrhPS7q8Z3aVZsgxtRnim3A3UIqpAqStoLzL/IX0mw0tM+8/gNa5fKhiE639M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722391445; c=relaxed/simple;
	bh=T/G4RUCN356zA4DXyqKGyc6HpZ+Z3TXbkd91LLnGiu8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j0N3bjZJD+IRPyFmv0UBBgdjgzNlivrMt/Zqh7xKAUq/ak0Krb/alSLriQ1VsAD3W2bGJ2Xv83lXVwV/ywBXW3hTuAC1m9THQ7xhgu9edLQ41RfBAiaeSL1+FF4JZ29cBA87zpspYCYtNtRkuq84CC6nWectZX21CObn9/gGMws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39ace60d44fso77273865ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722391443; x=1722996243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+xxggrsURR/7ryB1jZUFz1fkl2aRd7pNagLrGnAGSA=;
        b=KwSp7EzJUr9F6whCFl/cmAKkVr3hryh7rix/QcS2EjIl3QYFju/l/BYrSHoHJ6u/B3
         Zwjg6Wct2Z/N88BVsTLSkpdQ+f9jo5QFMuEPoLWC1Kfs9nashB/qT950ucTGdFagQ/Mf
         UmWYoHm6aPUe/76uAOycKYAdbLqd6HOYe+Lm2zWKGfah0nTmW129KC4P/bpNPKAn4At2
         gHaeJLsC9wUHCI1wnnokIsPjU5mE66bqOuPJ3Gjna7DY/DKIuRqD11n0fqbAY339+8y4
         dPoJ08Q75DrEnykjg2LMSnqRRZcF1CqV8pir4r3DXg5gMcO46OpCiSq5E5symVA4rRY9
         ibkw==
X-Forwarded-Encrypted: i=1; AJvYcCXeK32QMSaJoCWR/9/EW9Jd9dS1Km1yflaKMLQCbr4JW1T9zLPGnSPqKaEZEJDUwEhTsdR1cOlZ0a0pT4C7haoKXqw8KMboIAhuf1oe
X-Gm-Message-State: AOJu0YzdM4m2u6gm0YJnq8poS24cmSj32D7D5KXrT+VDs+DVsET8yKzD
	UZxHDvywL3lwT30spPcYDPHOYID1BijggV65k0Mb9CXYtrJmftXRydVSTBgAVjok+Abjvjs2G/S
	EG4GG3T5HfsYRhpycZ/VlXb/6UY1aysuH1qCUdo25w21N4Nlv6P0Bqq4=
X-Google-Smtp-Source: AGHT+IHO2ph6U7jU4u/LCjNrSkeiU9eO1PD9v7FlYGXMf/jeBPDEfdMH0aCT3bRG8QmjiZ0ICSYljOVV56JXnl63tEa4jte4RTgh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e1:b0:397:ca8e:d377 with SMTP id
 e9e14a558f8ab-39aec138eaemr7636355ab.0.1722391443152; Tue, 30 Jul 2024
 19:04:03 -0700 (PDT)
Date: Tue, 30 Jul 2024 19:04:03 -0700
In-Reply-To: <tencent_8D66803C29363A97EC36024BCE7451774309@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000223422061e8182f5@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Read in journal_entry_dev_usage_to_text
From: syzbot <syzbot+05d7520be047c9be86e0@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+05d7520be047c9be86e0@syzkaller.appspotmail.com
Tested-by: syzbot+05d7520be047c9be86e0@syzkaller.appspotmail.com

Tested on:

commit:         1722389b Merge tag 'net-6.11-rc1' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=171ff655980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b698a1b2fcd7ef5f
dashboard link: https://syzkaller.appspot.com/bug?extid=05d7520be047c9be86e0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=179548d3980000

Note: testing is done by a robot and is best-effort only.


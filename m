Return-Path: <linux-kernel+bounces-409992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D0C9C9526
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B8ABB2333D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC81D1AF0DD;
	Thu, 14 Nov 2024 22:27:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFED01AC885
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 22:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731623226; cv=none; b=nPli/PHHsCqT21XgYxwgrnSy2M+FAg4PCIQlNEMueLbN/A+eAmYn4QqG36JJYF+DK6EUgNkusE8BhCsNytnuW/oOE2Zm/2EkXVGxVZDKqm8bju7BaN2LlCRiFHWe4hTIL1Nrgd0sNVjeF+4LunvT+b/EVDt4cGghoKO+QVkXOws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731623226; c=relaxed/simple;
	bh=co+uxS2hutTFXJmf8+QuEgJd7/tbc/lAMdwkruWm460=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EbXfrZYHFV7YRzxfE2yjwrJdWrlvqYoIS2l787h3cNdTgPZkeJkaLKp614U5KogesV0InXM7vcVDnXgSXvSUmU1O0Pa4dzRaexlZBZjm/bgKh5cg4j8LEELMFppDV71VPPZ2Rkf273maAntEP0PbUPQhLO2MDeTcOP1Ml6TNhYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a71bdd158aso12614365ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731623224; x=1732228024;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0lS+gwZ3PeX6rvUOrE7cTYAWY6b7EMUSrW1zbz6aCDw=;
        b=qlWyYC6Nju5HsCDee2bnaJTE2n7PVjNLtbZHJJ1eNJ1dkUxZaynMs10fJT96nxP595
         3s9fBrnsqqeITfjRMSYOqleZQfZM2617dhuiGjLeJpnjrYN7uyhA4ePd309gV4+/fgjF
         0mYAsdGndnXu9Z0YbJAfy+VdY3ofvz09SV/9iTVDwBjDzua7svQ5qn62WcDHH/JbOaxJ
         WBDWqaL7EQiQwkOBCj9mlIB0AAWszGhbfm0fNiesEUMttBaQs0G9fqzHcHEFf1HdGPYT
         N71E1pQmKukwdZBw5Nf8crV2YGrMSuELvqEMcqphyS522Mx6ByZE8E4zr5k3EYFiiwSK
         J/iA==
X-Forwarded-Encrypted: i=1; AJvYcCUYBZ5KgS+WXXqQacO3m9+TotDRBNj0eRCBRzY8LUZFLJB1qP5vw2AMvGoG5dLMDELrTYrqdj+S5HmL4Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDaQCZmwLICkwHm3RdqJMlZPifZIW6h8babWOkTX7M6Ey7f4PT
	oxwp3qdF2DFUsfSWKUa8lv7dKqCFi4VQ0fhs0F6qNKxG9HgopBwIkWG1Iu858yeNrWMV/zfv6M6
	WeXEmsiGfE0mCdgJPRsHY49K0YOM25aNW8IOhTyW6QvCjqPlq1oMZob0=
X-Google-Smtp-Source: AGHT+IE4TwUAPp981Ps4C4d3Liw3rbx1GBtGuzstn4nzBMibs5238Lo3m+Tl6JtBvdAG9zwbtuhZvRovvyMFJA2BZE/RnJPHAXds
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8d:b0:3a7:43db:2b63 with SMTP id
 e9e14a558f8ab-3a747ff8a45mr3973645ab.4.1731623223090; Thu, 14 Nov 2024
 14:27:03 -0800 (PST)
Date: Thu, 14 Nov 2024 14:27:03 -0800
In-Reply-To: <55018f1d-5871-4f13-aa03-bd06bda0f90f@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67367937.050a0220.2a2fcc.0070.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_copygc
From: syzbot <syzbot+8689d10f1894eedf774d@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8689d10f1894eedf774d@syzkaller.appspotmail.com
Tested-by: syzbot+8689d10f1894eedf774d@syzkaller.appspotmail.com

Tested on:

commit:         cfaaa7d0 Merge tag 'net-6.12-rc8' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16552b5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcca673786a14715
dashboard link: https://syzkaller.appspot.com/bug?extid=8689d10f1894eedf774d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1337e130580000

Note: testing is done by a robot and is best-effort only.


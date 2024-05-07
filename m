Return-Path: <linux-kernel+bounces-170587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D078BD96A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 04:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D0D1C21B6A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 02:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5308AD5E;
	Tue,  7 May 2024 02:32:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AA18F59
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715049124; cv=none; b=fYE4ziZGXzpokeGd2er9ebAAJiwCmLOcZ2KqzEvZQwJzwJ7Nga/qykwAq9IXZFaMfosSobywUlamc34/UfG2C9bRkmirgnctFTAVHvAib9+ZEiu9IeWkeNNZGjn83RDKe8n8P766XFFYPA5pBq1Rcj0l+Qt/VeEOlk5tX/7ojog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715049124; c=relaxed/simple;
	bh=y6CpsJhKxdgGJQnqFGSnhbWOXuhUH/QdSmCWUeNARgM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YJKGbCjx6TGJzkn+2TY0mLtSTypv95NpMRin0ka2Qz8MRXOdprM10iZSRtpRskjbTXGzDzOPoVYo1GxASWxk6YaTXvakQQL6focnZKonqQLHwSSsymHAwllzck8A7HRpL0hLjFEjiyXBwESCEi5y/2eicH5s92/1bHEq2a0Qlws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7da7d4ccb67so309977039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 19:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715049122; x=1715653922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzthliTpMQFx50c4Ba0O5kHg4xTiOcM1s10ubzZPP98=;
        b=SefWwR52mdJmONldfQl0m02z3QKnO6KE7x37gEcnLrW2+AFuSF7KN2knYpaTVQJGVQ
         ZPpcH9kslB4xdsYDBpWmecnSfiZLWJOlELTxrkSIkMMnVKsUlrfibXqbJdwNANqptt6w
         sEW8q8BoMsqzBh6UMgW6w3wl+OQgkPM+8A2Df6iM0508qgCLqUX9/u2EsaBxVAa/VnWR
         tpLG/yenosfjOVUQFeWtJ/8wpyofpzzVnth9sopFSqldp5LCTMg9xiPwsHZ+MnIIfuMK
         bkuuHBTLIZa7KGa2/TUko/utgkphhJ2Ge1TRIEqqujra3uTg46Ja0jOV85vZuRE4bY26
         IViw==
X-Forwarded-Encrypted: i=1; AJvYcCX2B4wPeInk9Dpn1kgiGkZxf+7rA2LFeu2oqv0xmMWEYIhMoHZR111VB5TzxHxU6qvWzNHNDedWdBELKr0GRK+rkN7Qx/dF1cScCKTN
X-Gm-Message-State: AOJu0YwQQ/jIEC6BRcl5WayBD7BsUuX4zjG/1lPzSdqtdeg8krouKPJ+
	9RkNBAhRQqLXjdZJwdAQwweyD96IueZAv4pSjrlbEiQ0RIpuanT+GrhmTsIaUsm62FiwMUrr4hm
	33XZuhn1PLZIqLPwXd2GuAWV9T4ks51N1u53NLakiRQ5Yl4O1+4sPzgs=
X-Google-Smtp-Source: AGHT+IESAVZE1pt3STgBAQU6S7iL7hUm94fDa2nlPDmNBzKdhVyarGm3KhUNZjU+qIIGwS5Rkgu+mA0AK9iZyMFNiGpTbC9BRSZL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2489:b0:488:75e3:f3c5 with SMTP id
 x9-20020a056638248900b0048875e3f3c5mr404618jat.0.1715049122119; Mon, 06 May
 2024 19:32:02 -0700 (PDT)
Date: Mon, 06 May 2024 19:32:02 -0700
In-Reply-To: <tencent_456D1097D0EAEAEEAACDD47B526E602F910A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b254a90617d3fd6b@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Read in bch2_sb_clean_to_text
From: syzbot <syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com

Tested on:

commit:         5eb4573e Merge tag 'soc-fixes-6.9-2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=165031a8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d46aa9d7a44f40d
dashboard link: https://syzkaller.appspot.com/bug?extid=c48865e11e7e893ec4ab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=146b4a04980000

Note: testing is done by a robot and is best-effort only.


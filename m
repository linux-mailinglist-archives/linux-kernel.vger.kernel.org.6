Return-Path: <linux-kernel+bounces-373086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CB79A520D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 05:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE541C21D2E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 03:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9993209;
	Sun, 20 Oct 2024 03:18:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1874C7FD
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 03:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729394285; cv=none; b=Cru7nLtasT8O9QWzH1uBIpym1GNS6P6BfCJkHuavCt7QTGheBRPSLHYOelX0ljD3DIf4iIxIvi/pWMTLgYIBZ2CPsRk24rvLzYqG9xOJVYXOJAyjNK2wH65Y5SZ1YyD5zu0G0KRds/FI5VIsR4kSrC2znLxxXymmhZ5Dxk8lG0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729394285; c=relaxed/simple;
	bh=DfXrHhjxapDYGoyNXKprM+8sX0gMhdln9XMhjN1k8vs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D0aqMetLSYumEDoOS6qIr/Kr/n9NpGcz6QVYPYJVMH4m4MJRkx9SBggFXRqcDr06IWCrbZV0Tj4RNpVhluIWDr+sLIJcF1HXlMe06Ft661C2p5UFs6/2pFedjfUSLexDD3x7xB6+9ifrwohlWOjJULA9dTDuVCKnuZh1Hq3Nexk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c70e58bfso27234405ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 20:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729394283; x=1729999083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UyuY/5SfSKcMOLRk8VtSLDc+Gty1I03LDkWihGMgfxw=;
        b=kkE/i7QkicOHI0Wiwjqq+3iDRzTF1fjnW24fcquPS+A811f/r0GZdJMV4EWRmPE5ir
         LeSss02QlS5OHTltEB7nEVowfsd4zUJ2StKOFL/37ocslAOVEfdzNl4TQNngvJ84uexM
         VMl+0txqUNjC/xp1LYH9J9x8zp4j0mMYouXuOoXf0gZixWzA0SvZ9NPc4qV8+9f6vIWI
         u8czwpPiIMyd9KthmUqTmy3YJcyHziZ2WkfhvIZ/mxFyUGp1aUwfUjmv+pszYOZKEZkz
         +Jnrjm58u6dLP717i7RFArgoNiJnvTt+r/ppelJrQBr3UfRP7KIXmKX8QqOpMTt1RwMi
         Xi0A==
X-Forwarded-Encrypted: i=1; AJvYcCUtz0Bhmhmq6wKlf00J4h1akBvQoXJabb+76+5IerYGWNk6PO4rOWP/jSKw+2I8jMCHHXvXW3FVlCy+lzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRlXdkxt/gmNrLFb30pKv0Yo9qroN0Ya43YZEQZv7XLzZJoi37
	l+c4Uwr5ARq4AscsXSw/eb6NYgsu+LYSCgUprHZcEBF2zU1lXrGVZBDIx0F1i/Eje7TDilMJqiQ
	ZzRROtCQ4hV/lO+ijbfu3FUDL7Fuyf+dir3U6AGfvCnu0rImcszHO8Os=
X-Google-Smtp-Source: AGHT+IFUolSEG3sO1XDN4wrSpm0sHZ0XRCtGTk0AiZj3tF0XwExO+qDN0kIzMfuCn5vsCKzKwFPHmH6Vp/2IWK3MYHprms5Qa+mo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2169:b0:3a3:b527:e809 with SMTP id
 e9e14a558f8ab-3a3f406326amr69811655ab.14.1729394283087; Sat, 19 Oct 2024
 20:18:03 -0700 (PDT)
Date: Sat, 19 Oct 2024 20:18:03 -0700
In-Reply-To: <tencent_CE9C9E131B1F4B491B1E25F3BA14BB123308@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6714766b.050a0220.10f4f4.0024.GAE@google.com>
Subject: Re: [syzbot] [nilfs?] possible deadlock in nilfs_dirty_inode (4)
From: syzbot <syzbot+9ef37ac20608f4836256@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/nilfs2/inode.c:260:2: error: use of undeclared identifier 'falgs'


Tested on:

commit:         715ca9dd Merge tag 'io_uring-6.12-20241019' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbd94c114a3d407
dashboard link: https://syzkaller.appspot.com/bug?extid=9ef37ac20608f4836256
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17260c87980000



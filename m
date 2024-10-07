Return-Path: <linux-kernel+bounces-352752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D399923C2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487001F22933
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 05:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9550013BAE2;
	Mon,  7 Oct 2024 05:02:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DC5139587
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 05:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728277327; cv=none; b=Y0pvdvkpUhfKzAl/bYQeoyzGDdBHfi+TbV4G5hGdQEmARSgK6mYu69tqa0tQVf1bZ+SCzBScQSOj7ArLZqU6CPZhXDBDrltTjjXeux/PRiwgovhpgulc9UCj3BPe5ENF5wxERr9hdlvDKOx12zzIuX5Z4BT7awn8+waEPl8ilUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728277327; c=relaxed/simple;
	bh=CIIjV/hWcdyFP05m5m4NTGbWgsxHfusAn7Dl+7PLsrk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=W01gwb7cuMqrVZ2JIwmfAzXvsqd2W8Pw7crHg+kespKR19JvkBomm3GhZ/QznyD8b2Zwc2NLjKZ9bbYQxXAfS8QpNwyCke0Fq5P9qhKEjWl2DLPrUihQnYWZ0c7vWONB3eqlG9+AZGBoJUEcQJWCCOAarfqjvXgr9uwydnTCvas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a1a2af837dso42013965ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 22:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728277325; x=1728882125;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M81u5pFZU9kf7CiDd7xdJW6Q5HmFx0rGdBALi4uV7Ps=;
        b=V4aLjNIohctR7qRJGAX0ujtE5b2XiRTtE4Zpa42dlSeix/+wOQuvx6R57Dex0IkljB
         P4A1uhBsqR3Rmf1EEamuvm07MKUAdu7a83BskaiaybqAMabBD6xGZPqvqtmGyLGlDbbk
         IT7RuCAbkcvH6F+544c//Dph3egzmyjayJsSEy9MSN7vo8poNWPiZ8dR+a65VBP+fbQl
         u1itSnu8FnmI39UCgreFriNK715zpPq7JLKGT9QhxgkuIjycjkxxtTW3iU5z/Ex+xcQj
         adIhtbFJTk31W+PPlOzUjK8G7cRWhzlO32gryxST4GzGj+xWpDm+R15N0Azolgv3Rlp0
         +gvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLwP771ANBthlxxFbF0RuSayisiYotXDb+ZiT1EFIm+sw7BU628Cn/pFQXkdYqCW6MEno1AmUnw2KblFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaPCTyOS/t8/P5dOpnSuoXOXnDGL1XhK+/FuUIeCNunrmfZc3U
	v9jJfdg7zYPACa3mGZsSWeB89myrAlxvTevlt+oFxa6a0YKtNGBFQfUKqPZ6E19/R2FsCtTorCm
	ztkOX+8yggcc7xpHWFKqRLN3MuGIvlHXK0nC9ImXoASzxB0PzKQfvWD8=
X-Google-Smtp-Source: AGHT+IGcHQlHbT+mZEs24tHUFLZOVw30EswUciVc4QnWf5Jxogro6ZUfcA/4pKxRE4+/8wJlDefVCu03RLZagRZjhfg17YPv2kjj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b02:b0:3a1:a2b4:6665 with SMTP id
 e9e14a558f8ab-3a375ce11c9mr76668105ab.12.1728277324939; Sun, 06 Oct 2024
 22:02:04 -0700 (PDT)
Date: Sun, 06 Oct 2024 22:02:04 -0700
In-Reply-To: <tencent_B3968DE192105D945D9F997D4FE88DAE2507@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67036b4c.050a0220.49194.04f9.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in ntfs_extend_initialized_size
From: syzbot <syzbot+e37dd1dfc814b10caa55@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, eadavis@qq.com, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e37dd1dfc814b10caa55@syzkaller.appspotmail.com
Tested-by: syzbot+e37dd1dfc814b10caa55@syzkaller.appspotmail.com

Tested on:

commit:         8cf0b939 Linux 6.12-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12e24327980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
dashboard link: https://syzkaller.appspot.com/bug?extid=e37dd1dfc814b10caa55
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13ac4327980000

Note: testing is done by a robot and is best-effort only.


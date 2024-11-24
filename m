Return-Path: <linux-kernel+bounces-420138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95389D7765
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 19:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14753B3745E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 15:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B182500CE;
	Sun, 24 Nov 2024 15:42:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD1B2500B2
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732462924; cv=none; b=dFR6j3p4uRcbnqtEv7UexgWoDYbWfnp94cJtJ3EWHH6sYoWNyHWCeuUVJhUeAz6PIR32/Fjdl839yYgOuoKz4C+pYhvOtS4UvMvJBn/+eq8LZ6oNaT2qRC9nZsOJBoB2m681D+fgLFC8E3U64LU5CBamvd3ttehI0GWQObXL3Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732462924; c=relaxed/simple;
	bh=Z/KQKu+c5WEklNo+Yt688x1xWLnf+a3nL7woaIVkYp8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cPhzDTV5gGG1FOw4YuoJDZg504GZ8V8aUhTXU1m+xo4xHKeFq5t0SQorzGW+z+PK/5+F2oQuP40bMfgrF5z3wXnockObnvGUyGN5SlKKS2vEvKVhxRuakfjAGp/VCDbTBr3JuipsFncGEzEPUrKGJEqhZa1nBg7+bjwDByOFVsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83e5dc9f6a4so436480639f.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 07:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732462922; x=1733067722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=coRcVNZpynG+ZxE9nHIs5dACc/byHyLl4kWizERwmks=;
        b=cYPPbymdsprRey8w19iH4cZSg3/GwCx6agPFDsXEUldYQDQjDujeJj/E8roZb4gXgO
         iCJm+cd8oKJY4lTXyEMPp+ftw4MpkfkrHSsTIW1Utx7AiyC6j13qNJamQf3xV8QGJm5f
         qIbCHkYKiwVxvrINQ1tNiS50kgyFwqIjncwmtv0cg3bz0bDwqIwmrTXV5MgIqa97iaL2
         qWIxFUJf0JHDlkwN5t8MKwKtNAd6RsczH223vYi82t4ehdJC06tLvzxvBoTN6GJSdcuv
         XMy7rUUhPa84/JlpguHLSBumR13o/atjh3IPnImsiyJcgJBdNpA6I8qHUVznx7SuKa83
         oUCg==
X-Forwarded-Encrypted: i=1; AJvYcCVDhLNdC3W6ZS/Dr4Srn+zPAYCKhKTIu5yQxeiZHNCCB5E34VxzqVPb/AuHhmQJqYj+4YP7lwq4w9Kso2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZz538uIpZsLbYLCJ65wUC1D0xfdWWsj2g10wRZY1jsrCJADst
	ileYQVGXH7CsTkQuxUst38+9RP+a0bj/fw4TGVqyvZseeFWM8k1MepztV3sZHVFutMFa05Wz3qB
	NgMqDIsNJ1deSZmjX+rUFLdJWrQE9KYqs+iJxCaA5QFjokCxTGUalniw=
X-Google-Smtp-Source: AGHT+IHVizeF5m7kAeRVtJocK86791i3Jl+BSPmPJQC/yyO7LSgAuZfVEZxbxgS3AmzKG/QoMRGMAfCa1aWO1ZoTb6LsAKrTEJK5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8f:b0:3a7:a58b:557e with SMTP id
 e9e14a558f8ab-3a7a58b693bmr48683065ab.12.1732462922271; Sun, 24 Nov 2024
 07:42:02 -0800 (PST)
Date: Sun, 24 Nov 2024 07:42:02 -0800
In-Reply-To: <tencent_C2474B031BD225AABA42BB7D33FC9E861B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6743494a.050a0220.1cc393.0043.GAE@google.com>
Subject: Re: [syzbot] [hfs?] WARNING in hfsplus_unlink
From: syzbot <syzbot+028180f480a74961919c@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+028180f480a74961919c@syzkaller.appspotmail.com
Tested-by: syzbot+028180f480a74961919c@syzkaller.appspotmail.com

Tested on:

commit:         9f16d5e6 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162c375f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e92fc420ca55fe33
dashboard link: https://syzkaller.appspot.com/bug?extid=028180f480a74961919c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=177319c0580000

Note: testing is done by a robot and is best-effort only.


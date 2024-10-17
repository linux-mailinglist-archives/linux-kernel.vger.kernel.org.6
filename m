Return-Path: <linux-kernel+bounces-370708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC55E9A3115
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE31E1C21AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5FB1D86ED;
	Thu, 17 Oct 2024 22:55:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0FD1D934D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729205708; cv=none; b=YtprT6E2b2Qwsbsy52s4+WRt5cgGLFV0zxkwnbsPZoyaffDIjYDZHbY8ewmzAslfdwajWTrVZLlg3Lw7alK55wnA8A/8j48LPz7Dyp76cmsCZueY24RwOf7BsHydMoW6VY0jfLb9bew/q/P0qxdn8NRmmK2VtttVpEdOEaMzDEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729205708; c=relaxed/simple;
	bh=LJ02Zqf0LWjj/jmqworrofRk+L+M68vqB71PLOiG56E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jAroOn/7wvwddbrcwbOXz2EtWoKjBtDRPy/ivH81VHy5DG9K2Ji39NFqLQ5Uz3yXcbu5aR8VoWSUOQkCnfYMyUSwhS/g6Iwv9GkC3IC3qNS+eS+T+m+vkeW+M5X3Zx9E9gDJN5cKX3NJgZ689PLnni1FYcQW0ima936Ruva19pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3bea901ffso15396645ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729205702; x=1729810502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zj+T2W3xJ8pQ9FsmSxuuuCxdtLgfcsMrzpzQ4HFzQ08=;
        b=T/drQ34lqVLGT+Tlu3qmpy/4h0++EO15KXkA+UM5fXC4X3zhV579pFZhdF1oOtWK0l
         SXox4l213G64vFaqr1E5gPNT+G0Ha8LsRtkopa0/l1qBmZkGR79TZXSgkHxKYblrWry8
         NjbcZOaW/sMvFdKEBWW0a6Skyu2qnTzrQG+qf/8Da1G96r/oKBnId3RtBtJuhWROKQyO
         oPK0nK8C3VU/SebGY5Okc0V2TShsKTzH84tVLg5ehBCvIX3yqFSE/Zs26K5o2CIS4YHJ
         ZIhOSnI0QbYKBdq598KCG4J9LEevK1jy5k3SFLipE+fG2TbQR10a4UGUAa0v2IGuBVTq
         6AXg==
X-Forwarded-Encrypted: i=1; AJvYcCV8JLyEOm/rYOT2NrCYf8KH4UFHZt3rUAfPxCtYXn0mEzNOvjkxGxZ3nURb3/Epo1wiRAo/5Kp+8d71Imw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLYEeuSb/X0cEh1Maj4QB0wqo/1Zr0Zi/DIa6MEA+vVWsCLoZc
	OKooLMuHOfWdBj97bKaxOtXEStNaB+FFw+UTKYXymzhjo0V6iJsv3K8qCr1v+SR8H+kRODeuiPH
	s0uRC0CFoIUWyBHPvSPzyq28i7Qw/HzPtyuEFJCdPVdVLXMMcwETUHEk=
X-Google-Smtp-Source: AGHT+IF3P0J3P15No4SgmAn0JkIfWoAVrMG9PoZklMEW3orNlA4mec/nbCY8tMllFulVXbSxH+DTPJ0AuqdghR/jPON8cjYGk10L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b05:b0:3a3:3e17:994e with SMTP id
 e9e14a558f8ab-3a3f4054651mr3332945ab.9.1729205702427; Thu, 17 Oct 2024
 15:55:02 -0700 (PDT)
Date: Thu, 17 Oct 2024 15:55:02 -0700
In-Reply-To: <CAGiJo8QcLHNe6kUTA6BqDye_Kzz_reee=yuO00Ar3MkHx=SNhA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671195c6.050a0220.1e4b4d.0004.GAE@google.com>
Subject: Re: [syzbot] [net?] KMSAN: kernel-infoleak in move_addr_to_user (7)
From: syzbot <syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com>
To: danielyangkang@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Tested-by: syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com

Tested on:

commit:         6efbea77 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=147caf27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5242e0e980477c72
dashboard link: https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16d4af27980000

Note: testing is done by a robot and is best-effort only.


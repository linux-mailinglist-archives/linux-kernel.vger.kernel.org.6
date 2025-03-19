Return-Path: <linux-kernel+bounces-568338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A203A69422
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766EA3AA63D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9201D90C8;
	Wed, 19 Mar 2025 15:49:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A0A1C5F1B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399345; cv=none; b=f61TDDEcOHfn3H7qTyM4FqPrD6j/S5R/tU9PyiHD1cJgx69+YfnoVhulNBDczjXd9OuKiGcF1w8SkS91g8VV2JpsTF7JlgZW/F68gKl764N/f6S+jQv2LZOzyF20cMXSre+dVLa2tFRZsrZ9w7zjusD2i89TJcyHpTvUGaI85ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399345; c=relaxed/simple;
	bh=fcWnykL2D+X3lsK2+aZi+h5+Y/7JPhjSfSZX8mz6iQE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SfgrbNjYtMZkJTaMTu99ERmUlOCHWlGRjN8Gbu/CCmB6slvv9DJGAws32z8nvACt/1NfG6Zx65THZIGP8dNRsqZSI07iVu+tDUgNAgF2XnoO61l167/9iauxhIbvlzn90crQGD9yFPPrrSIBbs5LGjtZegSop28F8Z8TYZnTHf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85b5e46a526so727360739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742399342; x=1743004142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cU5MsUCPLlub46H1EeBsFjmZwiNLwRWEGXg3sa+2OEw=;
        b=wkc6OzLTLA6NttYMTT6T84HTjMV6qialnB3/6Z23Lu608kjq+LqyQ2dX2JeOXIuRZt
         4uqFKyWKUpTBUHTBWi+iBedS625catDoDK2SGM20EbYNBcw3ELPq9aBTszi37bf1Mg7l
         ebYTkXQXCZiL1R3h/hZSg/2WU6LkaMeljCWJuJOCOYpuslnU2I8qAUoyf1FC6lGsuDzy
         98bsvrsnaDOh0/UxsfSv3+P2slkh3v45+AJV/y9bbnn/BFUHub1u9XwW/FSasYH8lPNl
         B34K5z2Ac17PwoGinoOBo+BsCZKfxkSQL3l+z3PrCaRlVwBUcP7Oclz3mkJxKaDNzfq0
         Y7UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS+vsl+9lmJat69/eFEKBK4M89VGGKDh6bfNSvuLMpdLQKtqwU3Hr5lp7hNigeGo21CW1tJSU+b5IPMdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzObSKo9/sqYski0wwQIS53HvkcQsg4GlxVPmGLZCEwrZ5dVN4X
	1EUWbQ7b1z6YC6es9ZwA9+wRmPTc6tusON8cc+F9UqN5PBdHzzW71mm5s1KHsIqwoiF2HZeqif1
	q7l4cJsuMkENiZUM+UjpzKfGDL2Eik3dPqeu4PsHFs1aHdzgRN0ESwRc=
X-Google-Smtp-Source: AGHT+IHigf+/jbu+BrDOZ0kUNEQZh8ja/sQ5P27qFvtFb3664GIL+McAifFSK3M9l9uXqP9Hc3TcZOIAlW7XNZTiIoNPl0IQs5eu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e9:b0:3cf:c9b9:3eb with SMTP id
 e9e14a558f8ab-3d58695fc90mr26735465ab.0.1742399342212; Wed, 19 Mar 2025
 08:49:02 -0700 (PDT)
Date: Wed, 19 Mar 2025 08:49:02 -0700
In-Reply-To: <2831141.1742397619@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67dae76e.050a0220.2ca2c6.0199.GAE@google.com>
Subject: Re: [syzbot] [keyrings?] [lsm?] KASAN: slab-use-after-free Read in key_put
From: syzbot <syzbot+6105ffc1ded71d194d6d@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, oleg@redhat.com, paul@paul-moore.com, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6105ffc1ded71d194d6d@syzkaller.appspotmail.com
Tested-by: syzbot+6105ffc1ded71d194d6d@syzkaller.appspotmail.com

Tested on:

commit:         81e4f8d6 Merge tag 'pmdomain-v6.14-rc4' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1216744c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=14213ea05709bce7
dashboard link: https://syzkaller.appspot.com/bug?extid=6105ffc1ded71d194d6d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16bb93b0580000

Note: testing is done by a robot and is best-effort only.


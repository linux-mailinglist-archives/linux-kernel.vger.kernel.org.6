Return-Path: <linux-kernel+bounces-186262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2148CC1D9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D771C21CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C97413DBAC;
	Wed, 22 May 2024 13:13:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95FB13D62E
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716383586; cv=none; b=aFf69jvfblLnka0JWkRPcrkOI0NjlSBGPckifmRUuSqpIcPYXN20Ipr66nz/jhTqjRE9bJgIERXeCxArDMRXvMEb+rFre+18rwUAxLGVSNFzAyD8BP/qAozWCHpw/tf8psww2S2q/wKqVxX8x9lNtGbUpktbTJBsUJ/Vxm2LgY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716383586; c=relaxed/simple;
	bh=uLEdi4M/jekM29ZYFTOqKTsYjwY+OQzhmaYyVDK/Jck=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pRmRJn31wLYJU7on4bLLpgMQ/O/J/2nSFMMfLPy9AZ42Whdq0mt5VhaAyFL7NbrHUolFjucmKijfsFFcjmDSTMD3IWIRQBV/747TWOo88c8yAhOyckOOnWZehkGPFGlrr8oel+WyO4GJwhnyoXOHh8bw1jv+ZyC5LSI+7+KZ++4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36c5d1c48d3so5357965ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 06:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716383584; x=1716988384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ki0srUVHBhA6G7AUcRMvYZdjuuZpOhRtZh1/nTKO8VU=;
        b=D0B0zR0mVttKrRkQGFk0o4fFEkqYwkskU1nmODswNxuC+LVTRbLs5DbTXYboJHKZo6
         KlVTEgeJ68wiLYomnPFXHCNrj4U2Fz/uHFY0Hgphhu0c8p7QG5MgwvG0zz2E/4nIcO/O
         HQKQibl1KnOywheViC765vMzgyFM/HHKF8MRpQ4PrL1d9aBbA6CeEelaaYloTGPmmUUG
         ZWJSlGfQ3q+EbZ0hWXJwfnr0YMMEB+dImDGonAF06rJrIb6DTfh4ue/G0vc0Bs0fHbww
         THylTA9vcZnaJ1RfwAdV02AX+5FrkznH1ltDcDH5QOAkNodz1Ze9FQOcTaZT4t0ICPgH
         N97w==
X-Forwarded-Encrypted: i=1; AJvYcCWZdb4LEa1eVya9Ch/7hu6ZfSn4RE0GrVqHUh0plhWwOaV71QNpWMYz003CwO+B9USeGWMYx+DjOq/mRkDqQACMrGm3gRxvFoINvN99
X-Gm-Message-State: AOJu0Yw9viD5dyK/TirZ8eF86WQaAfn8as9bAq/pRgjbjhXra+pkArDw
	UFWkAgz4Ql+sB57PLUDCQHPfQ//PiTKlcIKG43+3vLYpz+CTmAtLrh0Fgf1sp01ptidewHKC8A6
	9jvMM+YJyBTcsw7i4jm3t1WG9qgcxfL3XdNMOzL8GzvKwZghdN65Rn6Y=
X-Google-Smtp-Source: AGHT+IE/RMJGeAwyNzkF7LCNeKbL3f/YKl1wDCDP+UtmxXqlTVYUHA8lU+brZx75ORzCBRAk4a9fk0jtLjkpLFRjuT14RASMMZke
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a41:b0:371:a225:45b5 with SMTP id
 e9e14a558f8ab-371ee20d796mr1749715ab.1.1716383584031; Wed, 22 May 2024
 06:13:04 -0700 (PDT)
Date: Wed, 22 May 2024 06:13:04 -0700
In-Reply-To: <tencent_7BF20C9927C0C6D292CCC64BC994EEF92E06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3259106190ab127@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com

Tested on:

commit:         33e02dc6 Merge tag 'sound-6.10-rc1' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15d1f33f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25544a2faf4bae65
dashboard link: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17a34a52980000

Note: testing is done by a robot and is best-effort only.


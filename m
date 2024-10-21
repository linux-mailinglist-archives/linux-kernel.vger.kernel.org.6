Return-Path: <linux-kernel+bounces-374496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA9A9A6B52
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61A35B273EF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C230F1F9400;
	Mon, 21 Oct 2024 13:54:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CA51EF089
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518847; cv=none; b=oynpyOYMyzD+eFqdAOVWI9msOAqwa4WdmMMvaxQAozYINMICPPdlbMDP7tyHwo250MQUttRrdJn9apVltM5JaP3taLt+XaIH7lNL/E3ukuqn2hnIgDt24AVJuB0eGuY477TVf6JqRlh1JaEcgtmgnlFnPZxeIGPb7hibtbFovRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518847; c=relaxed/simple;
	bh=xrtX6jCnWSYflNtAZ2EbVIRJZkOevqfapQ5DBHrqss8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UWwhlXC868iFrN9MbpXRFP7G70VlpPalEzUajT/by+FhgQLB3jUP2p/IkGFs90stvU2i98TTbg5Vgy1e687AGmbCl2OENf7X0jMdW2KbJEQN4xe5g70HR2iyF/EFhZaG637mrXyyLmvgulePRrfiqIsTTS3xWWM/JuL9p+ZsI6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c3ecaaabso46226355ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729518844; x=1730123644;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jfQaV0rKCsLqz364Anx+IjTA2S6dx+AhKp9j3IcyO0=;
        b=DtnTbAUtJ5dHwz/7xXzQiXWmQu2AvxRBiEUeG1bLR8sVtQZQesIIgDLoosGyemb2Xp
         pO5EQTfbb23GGuVysmjfHj3LCpDQdoWc6k8OQvNwq0DrRUFjxSyNwJrtb90y5XDsayli
         BbeWedCXDOzupAC0r+iWHIxTfWBeX019qw3AexejDL/uKBoaO+nSGc/1g+6TQqSFiczS
         6VEzEDn/mlJXx9/7k3MPpCKfmUkv/7vkyimcT99bU8A19OuzPXuNLqGIHA/m7hGAxUpq
         x7yShXwJEOameub9HuwzwHjoV2dX5jaWpxcmMhNCAYCKYLzUgrsKtPDwiJyFp++/vt1y
         yOYg==
X-Forwarded-Encrypted: i=1; AJvYcCWx/nKvyzr/+Us3kpazGRvo3nUF6i359r4mNB7uC1SNhiGh7i4maC7ngMzTdveMzr3TZFkrTgj0XtTxfRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTw1rWUKmIhntjmdEuY8a4gqrlUFuYMlYiCGpSKoqVbyA4UqkA
	Tysq2Kcbw56eKZEwwefhIPA4MjCg8Ae2vg6RA8zNN6VUN7iOKyrEFJosJ94HHJB6VR+Jt+if/yB
	cfWIcSVCRHjGPqFQBQ7PDK3XJKbcNdtBAAMMTLyYj6oj/b6+iC9r/Spg=
X-Google-Smtp-Source: AGHT+IFQFmboXU50tJ86XSk0ReX5jopGah0DA6SomJkH+iJ9eAe/6SX2kfgJVLdzqMt151Uu0Tm6utS4JHc6bx1BUoXnJZlX/Jlh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2186:b0:3a0:9952:5fcb with SMTP id
 e9e14a558f8ab-3a4cb4f222amr1729595ab.17.1729518844609; Mon, 21 Oct 2024
 06:54:04 -0700 (PDT)
Date: Mon, 21 Oct 2024 06:54:04 -0700
In-Reply-To: <48e58aa4-6f63-475c-a95a-e6af935bea07@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67165cfc.050a0220.10f4f4.004c.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in bch2_alloc_to_text
From: syzbot <syzbot+7f45fa9805c40db3f108@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7f45fa9805c40db3f108@syzkaller.appspotmail.com
Tested-by: syzbot+7f45fa9805c40db3f108@syzkaller.appspotmail.com

Tested on:

commit:         42f7652d Linux 6.12-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=103fe430580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=7f45fa9805c40db3f108
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c76a40580000

Note: testing is done by a robot and is best-effort only.


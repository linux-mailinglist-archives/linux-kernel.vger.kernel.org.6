Return-Path: <linux-kernel+bounces-324688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 800C1974FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34DB51F22A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90BC177992;
	Wed, 11 Sep 2024 10:34:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364FA29422
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050844; cv=none; b=RWgYo88XzghSINhBCcIG6fjcbDc31jsBHTZDtJHiuKHHlKcPC81zgdfdxRu0GVsPmlhd5Yp/Xb5VAOUFWR8Of7JYVO9Af3BbsNGDsGiRdU1ZKzX3NmkL6AoLW/8t2cVcuZuGtmPpxFAnaUZLwLwyn/FUkpGKuzwxL8aF2S+W1S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050844; c=relaxed/simple;
	bh=GfInJLZO+l2V9f9F5JX7mQ7Zsc3sn0BVJvG5EHNWULM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cnbN4bSN/RpBn+y7a0GDNex56HP3j2dDgnYKIiRyk2CsC+JxwI8JllwLJqv0YbEylTVN8pBby+dpOF8XQH9w3/4wknnNNIimeN0e4/n1nXONZjYsb7KL5FrizMxo9PAwBtxRHIwW+wjXvto0OKPwgJaGno2KGuvSNOTTsFbwdHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a045e7ed57so119159595ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726050842; x=1726655642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0YszWmwrafKAbx7c9Nk15oYSA/tkkBSpy3uyJtq1uw=;
        b=Thd02D9JI+FQ8bdDluneisNAlit8/nF6zugu41Bk+KWNrYPDbYOCKNOkOqrMlVLCZi
         YAlTOPu9pt1X/gRK2+NMugkVgW1ChurFNPzjJOTJeTvLgWIReJSH8oJBEeMQBtr9y0bN
         uOCpXQ1cP0nNdQZJIQeAzFxMuo/ZnjfxRs5pR99dqeba/8Uu+zw4YV0dZsLJMlkWMOC7
         UlxI0+XsL3Uy52VjKCkFm5LohtZiu/5ekZy1aWJ7slg03wXpq85RIqHNnJ/8dcJ5gSq0
         UqJy+qhmvzorSj6kcWR7d1kv9O6BumhqefLzbsoB3H3R2vRZx/5HfDO3FsT6NjDWHCC3
         IGRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF9ZxwyZw4K3KIZSu2mKxh9qEQeDaD4VGwh482b6X08EeL3drYg1xtPWFOxw0Vk7tY96zoD0MmcEff7uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBrh6G8cXWopZOzTeTxfaN822WfO4Yan/ZZ3KnkgWslB6OtQ5n
	022XQheM1SZ6/Z4QxtUvoxh1h9mEng6MKlxjYQm301TudkzymJJCNveWiV6xqeaFnlPmVu9IurC
	0Vo6jzSvGav6V9e4CcJxAcqfGRSSExaDQTPqh7r17D9xYTMzlUKxRZ7A=
X-Google-Smtp-Source: AGHT+IGJWAkSA6BF+agMTBNiZm6AoqrujdhO6JeJwFJF608nhPTmarRZZcaZ387z/1dVMoafDE3zrpiiV7VRUYfshd/Qk/d/zTIR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1388:b0:39f:7a74:e6d2 with SMTP id
 e9e14a558f8ab-3a05685615bmr145725565ab.3.1726050842156; Wed, 11 Sep 2024
 03:34:02 -0700 (PDT)
Date: Wed, 11 Sep 2024 03:34:02 -0700
In-Reply-To: <59cf8d3e-2e3a-4ff3-93f5-216fa6052a66@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004fb6420621d587e1@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in rtnl_lock (8)
From: syzbot <syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/smc/smc_inet.c:127:44: error: no member named 'clcsk' in 'struct smc_sock'


Tested on:

commit:         7e3e2c7f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
kernel config:  https://syzkaller.appspot.com/x/.config?x=dde5a5ba8d41ee9e
dashboard link: https://syzkaller.appspot.com/bug?extid=51cf7cc5f9ffc1006ef2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11cda477980000



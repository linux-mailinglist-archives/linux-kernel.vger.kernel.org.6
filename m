Return-Path: <linux-kernel+bounces-286321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA7895199B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13E01C2175F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D341AE852;
	Wed, 14 Aug 2024 11:08:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FF01AE847
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723633686; cv=none; b=Pf9TE4f9TfVG1H9h4+P4/hqv9FZOJ4JwFUp1XUnVmusA37VBANR6KZeXX/kDeo6sz4rUV2JwJhTc9GUh45tdFuERJ9b5nLINnbklYmE5I0+fqbTzA64ZMzzQRHeTUtDtUJ0uVOAjybt6USCiTX9TqSIv90DJRVi0B/FxhNVMadk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723633686; c=relaxed/simple;
	bh=SD+OyeXa9APVBg9YdDPKM0vYND9PMuicoQXJtX1a4mI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cp3T5wccI92iRU2SU1QptIeTlVcrjS7U1BLX2AaBIiBIqkgtrR6dCsJUoykR9XW+7ktd5d9SFuRwqdyZqj8p2VtPxnlEIRlfiiar5VLAKuXGdp11Hj1iBVvqTheBioGnvZEY4/mCpJEGhRn4FoADbyunjS+oa42Le1tUHXMgz5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b3cd1813aso77882545ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723633684; x=1724238484;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nj7+5XvyZ2TUrlTVIqSYpUi+N0uS/cJKy21AXHIFeRY=;
        b=Twmh/lSJs3bfssaPii3sVklPIRp8peiEg2oMxEhydQT6GMEXSI4LBf8WpgiRVIdoxG
         0MoxBlZUJhQVF6X9GJh160NEtVos5PmU5kPocp85m4jzraH4WqI1UpmcUJk+RxCGz0TV
         9O4qHQyo4DKQ9x9mrFwFsVMcgjfmRLrrT/tGZ3U3gQsCPtvHatgd1x0BnW7ImfjYmfs0
         ctQxB04p7WQx+wxclCRqUUiUfm7MevvGxm38HGk8Qz45H2zVyWoYZfPL4sY35apQwymw
         +UJC+8VEkR34eYHijgGRBNQaExMilEo85pdIl9aCVu1wONyEP6GT9QTUJkHCFwpvYapm
         Hp+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9xVHFRM80MGTGQzPR9ni1jgAmEvg6fl/gaJG/Y/KvGpsjc3UKcjukRk1a9YhQuMCrrQTOrSGjkSCBZlhdtyhMLJkHWQkaWGygdPxV
X-Gm-Message-State: AOJu0Yw4fqcgQ3Wcn7SE1tIS698SAsgBMa14B9dz1HUZl8YtWEGFQ52e
	JLmJA69TEroJIsIphGK5cC0xE4idXW8aCfWrs7X3TjtFDSGKB5WB946JuHTnvdrZShGBcy4q4Z3
	oMjkuCBlZwWtHOg26SB5WwHEx5p0RbHXv9b7dLT/U9WkZpChonfuvOo8=
X-Google-Smtp-Source: AGHT+IEHaHYsdGIDkPAcmaX+E+b0sgxDdBA05z6opW758mTVV4Urf68G06/KLm4i+RrpKFToG7Q4+mDV9oIvMLjLuQazFhxecN9S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:39b:2133:8ee5 with SMTP id
 e9e14a558f8ab-39d12447420mr1763215ab.1.1723633684271; Wed, 14 Aug 2024
 04:08:04 -0700 (PDT)
Date: Wed, 14 Aug 2024 04:08:04 -0700
In-Reply-To: <tencent_82F24B9E1BD32515BAE8BBDB33A09E7F1B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000796850061fa2bdb1@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com
Tested-by: syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com

Tested on:

commit:         c0ecd638 Merge tag 'pci-v6.11-fixes-1' of git://git.ke..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12540de5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=174967d9980000

Note: testing is done by a robot and is best-effort only.


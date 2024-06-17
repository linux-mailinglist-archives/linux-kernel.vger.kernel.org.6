Return-Path: <linux-kernel+bounces-217187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D78490ACA5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EABDA2830C9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96151946C5;
	Mon, 17 Jun 2024 11:12:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0302D53AD
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718622724; cv=none; b=QsmY/cC2TWjb821Wy+4kjTxzQgFs7isQR1wjy+DaWcFxPPPG1/9nezA7ozt8XyzSemBvIs/itcYWN9k/HASSCSUQI5b42bE5Snh+yA7Ds2poTs9xIWs1SgeU/EpnEAiwrh91/xdRpeBH1nEqq2lFGAqFhldBi2dXdoLlrVihyVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718622724; c=relaxed/simple;
	bh=PE6q0olYwxVl53uNwFQCaWl+MfMDup6B9fBC5dhuyyo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O2E3CzPIvhTV7Tn244slJ+XSY8OfzTYPgfQhNAr97L+e8suB0AanQzUFg2R95JrWhz607mel/OQkw0Oa1VCFX2bQkgQs8+FXMczRZ9Es9pNArbjUFK94g2qP/4l1+2onG/sqrqrcmlZZcqZ5yoOsD95mA/UY0J+SRPGpJ/1n+rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7ec00e71ab9so293492539f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 04:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718622722; x=1719227522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6DIpsFhxrZ9UjTQFy5immLersnSHGZDczy0ctoArSw=;
        b=CE4mEbq1Iqg46dTYFip2cRp0o+61H8qkHQQ8pJjAV64J8iz4J+vbx4Trc+X/33RIRX
         5MFcBzGyrNSIYk6oVxSRpq4NsH2WIkpShQEo5r108oDerFRuQCtu7UYL+GoCozqD9ezl
         W7f8dex//TqCtqBfFJVTIuQjz+ytA4iZabWnWuH/RdmOPPio8v7mHpBkxzv4HwLMsZk6
         +pyYoxNQAK35iwZQRJd7N8toye7tJ3X+Pqd5YGui7SpyqhIM+23Dmb04/pk1MkQ/gMKn
         jsafc0Nsz7MHkIbsjFgfNMSCQwXR7qt4fBbnXfFdTNkWLt2B20gXQE7kB4xi+1t7j8GH
         PkKA==
X-Forwarded-Encrypted: i=1; AJvYcCVBTA3IebPw55pyWS+Vupyn7KXbhQf3xo1i2q7+9ejvVoDp3A/6twhet61Av2ff1QrjSjcDlpEiSxqBcayfMY9XzxBxU3InM4DkphxR
X-Gm-Message-State: AOJu0YyV27urcLOsiBYOhOU0OVyNVAC8NrX5Rn0tyH3kdIo9a80sFKA5
	Q+iZm99GBEhDLx8yPIhPorcAhXwgyYyprqg6bVNQBolMagWCMVs0v3+6I1R6iXt3ouKa9d5UiYG
	q2T063mN5uu4k+uVUmHvHuJpyDnbIxUno5lvZxyxG9T5gjSlBWTXlo6U=
X-Google-Smtp-Source: AGHT+IE2rybxVCWF62xrnUouwzkQUuf4GUhoYlfuponIhKBWCbYYtpI2KD6CG+y3VvxuzxY0KtbrtZenFvLBzVTg7f747OKOTX70
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:412a:b0:4b9:38aa:497a with SMTP id
 8926c6da1cb9f-4b963bf8296mr485899173.0.1718622722149; Mon, 17 Jun 2024
 04:12:02 -0700 (PDT)
Date: Mon, 17 Jun 2024 04:12:02 -0700
In-Reply-To: <20240617104841.1588-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db5e4b061b1408c9@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 __lock_sock (2)
From: syzbot <syzbot+9486ac2c18a7693c45d6@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9486ac2c18a7693c45d6@syzkaller.appspotmail.com

Tested on:

commit:         cea2a265 mailmap: Add my outdated addresses to the map..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=145db12e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=9486ac2c18a7693c45d6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10d3be0e980000

Note: testing is done by a robot and is best-effort only.


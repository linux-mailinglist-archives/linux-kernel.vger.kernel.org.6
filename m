Return-Path: <linux-kernel+bounces-332301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D6697B7F6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92F4AB262DA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 06:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0651482F2;
	Wed, 18 Sep 2024 06:31:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8112C9A
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 06:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726641065; cv=none; b=Tf7tINeWSds0iJu0/kNQ8jXUiW7murFyaSPwMZYhR5j+gC5wQcDhSc9simil4XXc4Iz00tLm6ZeVhjwoYLJIRGTU9DB28LVZPSsTpmko4UqMisKDPpIV0MUdAmFX0+xI8Xgc1h1qMc3AxuMbgpHSV+PerX94RThlY9mGEcsfN14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726641065; c=relaxed/simple;
	bh=h6qJInskvGOYUcEM5b1IKPMo+T6/kr6NvsU9W/XEmDw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FpSu+pBZUeCplwg+fQhKxPahLD1ey2Tzji5mbApyHEgENGmDxUGsriSYdvAC+BuGRwpw2Rq7ir8MIkZr8maFl9buvsIajgrkujDZJ9FLWEv7JM9QKRTO+aA74/u7dN1CMhL6njLNXgj3hUVB8QcpxkczBDXddbSJsDOodunwkH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82cd93852b5so143648039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 23:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726641063; x=1727245863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tbu5vqAmHMbzfSR9yiTvjc4w9SzN6dFmwBNiGZOqmk=;
        b=HCat5YOboTTG5IoKIwoGEGsSwVXmBHAWtEHqG7SJCdHVJi0zqRyswbIiSSYAgYIMs7
         X5s6LGpmxXgdLJw1pcPEVi/1xVh4mY3R6VroEAyvRrFc7uKe5Yp8oOxwchdf1mY4dj7h
         aX2Cbawq6I+WMDk1rD8yKh7ZqKNBoYUg0zBWrcOKGnNaXheO4YsOxXBFqEcOeKl4RR5O
         oAd8Mt2L6ZLdRaEdh6EQZQiiNmltxxs+Zt32CxEFapa3wAlI+NiY9IC3Z4IVHNThMTaX
         HZ9LadeitXZHosy88aJXBl9qL6L6vpJG7FmSud0EuAc7yqaNkOfKcCrrK1aF0UDp7zmi
         HvkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLnwDtJPDYGoMuJ+fI4L09DChI/Wj+iKrKaSN4M4WPpdP57+SmRiVIZXd/8Tb1lZG1qPd0jCuKQx1ORP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw44sNLWQx4mz6nE7mVTmhU52pMOVnpSe0KmZejlZsAfL5Y9ZFo
	sVor0b3oG1Y4yyTQzAFdhA7ncjlt50fKaqQOIxGI7qslTR8XfCMADiNZDxgIxGee8R4Y0KqRyeD
	6Ka3mSt+qPCo6LcU67RWrU+l+Y55hvilF+d8ZRfgL1USYBeoLcG+p/DQ=
X-Google-Smtp-Source: AGHT+IEWVHPdagiJqgeBW7wVyEqbO7IAy5+S9xJThvgfGQy7P6YYwO/eUFWDI51ygZM9LruaCqnn8epG77dG8oOjcu4hD+km3Z+T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24f:0:b0:3a0:a440:fe0a with SMTP id
 e9e14a558f8ab-3a0a4411e12mr21956265ab.4.1726641063279; Tue, 17 Sep 2024
 23:31:03 -0700 (PDT)
Date: Tue, 17 Sep 2024 23:31:03 -0700
In-Reply-To: <20240918062609.200332-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b506406225ef3b6@google.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
From: syzbot <syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ext4/super.c:317:9: error: cannot take the address of an rvalue of type '__u32' (aka 'unsigned int')
fs/ext4/super.c:319:4: error: cannot take the address of an rvalue of type 'ext4_fsblk_t' (aka 'unsigned long long')
fs/ext4/super.c:325:9: error: cannot take the address of an rvalue of type '__u32' (aka 'unsigned int')
fs/ext4/super.c:327:4: error: cannot take the address of an rvalue of type 'ext4_fsblk_t' (aka 'unsigned long long')
fs/ext4/super.c:333:9: error: cannot take the address of an rvalue of type '__u32' (aka 'unsigned int')
fs/ext4/super.c:335:4: error: cannot take the address of an rvalue of type 'ext4_fsblk_t' (aka 'unsigned long long')
fs/ext4/super.c:341:9: error: cannot take the address of an rvalue of type '__u16' (aka 'unsigned short')
fs/ext4/super.c:343:4: error: cannot take the address of an rvalue of type '__u32' (aka 'unsigned int')
fs/ext4/super.c:349:9: error: cannot take the address of an rvalue of type '__u16' (aka 'unsigned short')
fs/ext4/super.c:351:4: error: cannot take the address of an rvalue of type '__u32' (aka 'unsigned int')
fs/ext4/super.c:357:9: error: cannot take the address of an rvalue of type '__u16' (aka 'unsigned short')
fs/ext4/super.c:359:4: error: cannot take the address of an rvalue of type '__u32' (aka 'unsigned int')
fs/ext4/super.c:365:9: error: cannot take the address of an rvalue of type '__u16' (aka 'unsigned short')
fs/ext4/super.c:367:4: error: cannot take the address of an rvalue of type '__u32' (aka 'unsigned int')


Tested on:

commit:         2f27fce6 Merge tag 'sound-6.12-rc1' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=31b069fcee8f481d
dashboard link: https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10fc7500580000



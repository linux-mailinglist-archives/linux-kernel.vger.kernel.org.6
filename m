Return-Path: <linux-kernel+bounces-332152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F8997B616
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 01:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995381F22F03
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 23:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC8E169AE6;
	Tue, 17 Sep 2024 23:24:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A629443
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 23:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726615444; cv=none; b=GSFvd9HnOt+ZQjOT7a75qY6OQtZ0J7S+bhgI2LMsIQMKntcmgWOiYmSIlMeYAXYPKD8ClGhiihSkdZLafG20U7D5CBvJ0D6eCRCIr1GluS6HmQ+TeynSdgE7Ad4j+xuNqjILhdliPgKYFKAldE079Tw6jpiw1UPPd8uw+QrvZzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726615444; c=relaxed/simple;
	bh=yT8tUuPvJfgot30mEOiOGCKzq0ji+/2KryLzIYYVYD0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LL3uv7Z0e6KGTV+R2Np10vTvtZR8YfOZq0XoWkx1X/roj5QXEbMhHZUASa8jGvtFHolLurmWMmQLUKa55w1PESxkou5tWF4YUs1pt1lZBxBgdX97p+EoN7ljcknZmX4AiFUe2fa7iAlWDDAXgdPHcC6IViCvbH+oUHnkzRfRTdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0a3f10064so27863055ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 16:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726615442; x=1727220242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lu6755X7P78HXAs2KtqnTUDDiwVEzv9yjTG9JCaF6ds=;
        b=pDIQw0l7y+CT+DeAmLhlqbTCVXexFUNu9dY/NRVHYOWImdELghImslD/YxJpEa4mz/
         SDx7CeaBA1t84owfgGnJfzSBsKxPq/CuMN9T9InzIAHVeDWtVm0xj+QXMlUhkjj3z9o6
         1RiePlzRNlzUwEx8TIWcWSzyJOwzF+9uq9vRh1nea1RyUwf3wKF1l0+Ea5dJuNK5iL0e
         mkWmWZNdHNcz9+NOuGeA8fB3NO/7AgM1loY62K2CsG0SOvB1xacUcpkxoLJ+0NgHJdOc
         /0d38ybPexZqlq6gW0DjhZvjWpWBkJPcSBui957uGhDS/JHajL8KVqqnDVD57wOj3//Z
         17ow==
X-Gm-Message-State: AOJu0YwL2MJDZxFtxHauCNA1ZAC3u3/D37IUTjx3/KIQSREIOKUqHUFW
	ZrwDLSpNatuLJdlPV9nBAELu2JzvrDh3dCAzckmvzdI5riiow1yXxDf/FzJCisRKdoSqZwpp5Ek
	G1zPfBOeFDCWY1xTicgwNmgrnMpJQ8qQPBRJZ8Ciooz0UT5C3gYFSIhk=
X-Google-Smtp-Source: AGHT+IEdZG9jYAt6tGnPFOWcS5QYOCiPGCBl4jVqUxIEn4AqjWRy+oey/mUw9Eh++CHYvGxN8/mBV9xkMPo6sFj0dTwV2dGeidZ0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2145:b0:3a0:aa15:3497 with SMTP id
 e9e14a558f8ab-3a0aa153652mr57267065ab.1.1726615442040; Tue, 17 Sep 2024
 16:24:02 -0700 (PDT)
Date: Tue, 17 Sep 2024 16:24:02 -0700
In-Reply-To: <20240917225638.203403-2-srikarananta01@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001643d2062258fc82@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in do_ip_setsockopt (4)
From: syzbot <syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, srikarananta01@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com
Tested-by: syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com

Tested on:

commit:         2f27fce6 Merge tag 'sound-6.12-rc1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a844a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7e7e5a089fe8488
dashboard link: https://syzkaller.appspot.com/bug?extid=e4c27043b9315839452d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1532469f980000

Note: testing is done by a robot and is best-effort only.


Return-Path: <linux-kernel+bounces-314098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CF696AECF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 04:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E404286366
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F94D3D0AD;
	Wed,  4 Sep 2024 02:55:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7012562E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 02:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725418504; cv=none; b=KGIpdwXUy5OIx++uAvhI9DXCyQ7blIgNyzTTZOs7n8vungMjdAxhWHYvMadBMTKb9Zba7GXLVUtY/4cxGHuFA01kpbG+D0qvPE+qQiQDqNqLxeC12xEZEnkw1qUDWZAlv+cGDuik7gPJwOqwNF+aBFpfvA+9G3lzWB8bE7WOvcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725418504; c=relaxed/simple;
	bh=dFt6bhuzA6jrjXoeg7I7jO9jE7J6LNj7D968IHxZuAQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JyPJ1A1kRt1Y7fLc5c+l95KJ5asiCy0bcQbj2vhAucB6zhkILyrYJWxTOsDRd2UushskYYUwwMhcs1B67XLpieWAc1JSJtftiAk8gjGw9otarua00LiRj7CvX5W2Rp1IVu5QzD3w5gRq3O6xHmPnONHfl+iic3a/c0ZTMMz4vSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a3ad86c74so457510739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 19:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725418502; x=1726023302;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8+0FXw9SaP5q+KG5hfPrYh/4DlAELwos27XVrdnfwI=;
        b=nCPigXgVKRui/NY69zZ7xgnvjXiPV/bA/ULDwxTR0OIbNbPKkuU//WB/likgEm0v5R
         h/L3kva7jcbxe0v1xfInIpL3XdbFdvDrGJ+NcC9vXPXhq8q/o7cTwTnoI7ZmQi3Unydl
         zlkUiCrZbd7d0WFGsVXhzw49Wh2MQabWw/30C/nlDN1+bRXSxP+MELazUDZCYO7nB8yz
         /SZ4+kEfbf/pADLD22JWyoDc1fKmgQ9aADCchYr78VlA2wucFDkQ6hTpsJmD7X+ci4Y8
         LBG741ojQWKVpn1FPOVsJSoJEXHwho+CBsoTyTP/4t2T28NMX9Mk6zFCwrSot02fyvYx
         6USQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoEYSw8zI2KweTLYP483GCsnTa7Ge0kIedNBbCP8eljolmlCao+fgpF2aBcNQbQ3ggvvAKqJFbp5JvOSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkhah3N3+kq5kkAmc58gxuSNVjV+ZLdEcgslYNNycQe1w7FG6o
	UgjMqU8kdy1Z/gyBmpCWeJbAiSn6FYhx+0/QyoG6dW4de4FAO9G/55sKoZNN7QT3YW6mdENOAVB
	M6uu7dbKNtvROEPSbWelYmtH/M3JyKcg44gTP4izKcLRDl5/wN1jqQyY=
X-Google-Smtp-Source: AGHT+IHyCNbA9TulbsWy4V/tefjdD+dbryxlauNSC6v8C3qr1955cAvIaA2m/4xgCzTGjZMYy1EIy68LtZfcSmwOcj5kR7l8sNJf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d89:b0:81f:c103:3e70 with SMTP id
 ca18e2360f4ac-82a2631ae6fmr69711639f.4.1725418501675; Tue, 03 Sep 2024
 19:55:01 -0700 (PDT)
Date: Tue, 03 Sep 2024 19:55:01 -0700
In-Reply-To: <tencent_A84BB764577146D01363A3640961A3B06405@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e1acf50621424c79@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: trying to register non-static key in mark_as_free_ex
From: syzbot <syzbot+3bfd2cc059ab93efcdb4@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, eadavis@qq.com, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3bfd2cc059ab93efcdb4@syzkaller.appspotmail.com
Tested-by: syzbot+3bfd2cc059ab93efcdb4@syzkaller.appspotmail.com

Tested on:

commit:         88fac175 Merge tag 'fuse-fixes-6.11-rc7' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1587c0b3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=3bfd2cc059ab93efcdb4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1277c88b980000

Note: testing is done by a robot and is best-effort only.


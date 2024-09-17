Return-Path: <linux-kernel+bounces-332133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B165C97B5D0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E242F1C2354C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4FF192B80;
	Tue, 17 Sep 2024 22:31:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4F316130B
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 22:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612264; cv=none; b=LC1aAJ1uD9BKA3I8JTvisYoEfEyS9DDa+JBPedvvczEImnbz4KjvlwoTfiPz71XvyxA0duTJZJ7UtWtRHqAdyoNKpoEw3OI0hWWNMmMNtnyyDJk9HgjiIBVNdYqjP0zn4ApfYEg0fl5n7y1Em9Tca78aaicF9Z0QZwGeL+jvcDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612264; c=relaxed/simple;
	bh=aIHRx1WAh0Ssb9wQuea37MU+hqs16wu6+clcJa0mIeM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TDtmPYYzTtURg+2zS5m8pJ6nn5CgbjIiimAlOf0jMi3xdNWvvcKUIvGO7tC9/JuHF8BG/dxFHlA537wxkVIma2OW5HaKS7+jhEBdNo/IG7gjSBtEo7rcg7bkkk0l2TBi/6izlh/EqVoKRenEbQCxX0d0j2fAJkq/8dUVQfgr5lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82ad9fca614so1044431339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 15:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726612262; x=1727217062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxXvBeV1O30goxwxHgQ2uBduCiUKOZu0aee0Uy9tPlo=;
        b=KdlVxHKpyukkpYMKf6t7Ihq6v3V5m/yjVeEfkXO76qwwCU/66QfEgRfiJYwuhvRyA1
         0kBDNwM+xNq/2Z6507QADoWMDXV/b7nXFmaH6xzGUEbsQ1Zhcxp/Fq+7chjn68WxaH+m
         ZYh7ICvu5h0exlpe97LsheYP1WLlKiYQAkDLTUsM6Z6KtVCLnRmY4HuxdZlHg/e+RmJb
         zfPS79iYR19Q8nMQjfjcp5y0GanFtkOz576OUkhNLLoGtRF5VCyzZfbUn7boaSHeWO4y
         gcm/GYw7EtHAPUMzufrRN/iZmBGU841Nqi8SYN7+WTC0aHxyFBUCeWkRYn4y8cJbdIyc
         O+0w==
X-Forwarded-Encrypted: i=1; AJvYcCWwNHayNl/hZHV6hC2b5D7AnMV4r/7OZPo/ainoT7j+b+dFxuIxPvv8/mfz2mihqcFZ7Yh7yTd6Bj83a2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPRVknwL/XKiphKEx7FzRIm5Hf6l1bLhYNRj7GTnkq5OXhU2gL
	yVmgwEjGnF6UZfkbvHVLXPWAUPP3BziGCE/ISQ81Ehhs+qcr82pbk1l81yqSx9JNyYoP8OJu8jg
	4PO6Hfcjg9XE4D7zVXRXuIqH+wayh+R34LdGMK42RAGBJC4ydu/iJubk=
X-Google-Smtp-Source: AGHT+IEJ/nUo7tEQDiIzKno+FsLEiL+0en6penJAx5m1i+GqtzIkl07/dRJl99OHLrggknVdei9JpWrBGxV2bbnM0LmLn4Hu/72o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8b:b0:3a0:9013:83f0 with SMTP id
 e9e14a558f8ab-3a09013878amr126859565ab.3.1726612262547; Tue, 17 Sep 2024
 15:31:02 -0700 (PDT)
Date: Tue, 17 Sep 2024 15:31:02 -0700
In-Reply-To: <aa2b8eb7-a60c-43cf-ae70-9569dd7b9e85@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093078f0622583e6e@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in do_ip_setsockopt (4)
From: syzbot <syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, davem@davemloft.net, dsahern@kernel.org, 
	dust.li@linux.alibaba.com, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	schnelle@linux.ibm.com, srikarananta01@gmail.com, 
	syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/ipv4/ip_sockglue.c
patch: **** unexpected end of file in patch



Tested on:

commit:         2f27fce6 Merge tag 'sound-6.12-rc1' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fc2afd52fd008bb
dashboard link: https://syzkaller.appspot.com/bug?extid=e4c27043b9315839452d
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=152784a9980000



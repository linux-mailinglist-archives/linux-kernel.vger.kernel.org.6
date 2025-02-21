Return-Path: <linux-kernel+bounces-525766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F8FA3F4A3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D70421D73
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39CC20C486;
	Fri, 21 Feb 2025 12:44:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C0E20B80E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740141845; cv=none; b=hZR6unUEhO8nECdslV8xwVZRD/O5G5kh73IKvy1Q+YVGintoXC7TAOX6ruZOO/La3prRDSvTotugW25C83fPtPdSN/14SaoTLDEgeAVkkfjI+VVgDcoKOwXph7PMkQtQjl3OcjdF6wl6N7oaZts2xarLvUQ9Tb9luO9plJldFk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740141845; c=relaxed/simple;
	bh=Suktrg40pKqU2iNgxTGtiCQuxs2LoCxGNWE/Ep9rtgA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mZxbYjb34X1sJrzhqA/Lm3Zu5oyjtZLcLSh5IFiF850Tenv4+BBDX4m4My9xyrUTav19fGq+aTAZ0pItM3jX1E//XFzmL/BE5uLx+g4HpZSjRJX61iD71uq2OLjGJXQb3Vbh7vVOOvShZaQemIcJb/Rrxdu6kGjFGPXOTPEq++4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2a1d6747aso18456845ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 04:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740141843; x=1740746643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzpUeHl1/GrH7+83IIw6xCrCgN7JWov/Yl9aFuy3UnU=;
        b=eeliHmVEjbEFDACRB3EIcHGBXG8a1pv084rje7lVr1Zodq0+ohvcbzmt72Y6F5gDMW
         tZmNjLP8fyur2DvIVwwrj4LfqqOfQM+os0dgESbO5PUA/mdxkEU40g0YKZ1E9esbiwfD
         IgMgU07rzUe2VOaKN+pO0JHByG6y/iaIWf4qrqPxKw0Wzx1v7SwPHfX9nErjiabDR1rb
         2ye+rBuFcHqDpOJL2F9tOv529HI7EbyScWdKQ30DCxZJggkR+YKInTxZ5X2zfBmiOfo2
         u0Q1D7qd2Pjl0xc23Af/fG0Y0nmClq1P93oX9a6XJ5Q5fDfoQcCZEkgIoZo7fzMxgGZt
         zNfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlqxUJsI45iI9CG6jvjcMjUNvaXH0vNAkN3/pwrom0XsGQm9SCzfvWlxk/1ecNzyWANJOLBALXT1cRQCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtw/1kWmtcIOZg7HZzRxV408nPsvQOo3dbvQGrcInNSN1ZH1pK
	c2KO/Q44qIXJmm+F9LzdTkfQcZtv8P5Il6r5BKjtw6FmWP0lf6GGyTgCNoLkMCNIaxEldnJIdwi
	HUeG6F1XQl273TgJEuXKtoPQ3AVq5ky6hhMkuaFWY89+ZZclQoiCqfCM=
X-Google-Smtp-Source: AGHT+IFd2mrfQDcMluz4HxWhLCI1oJuPSzVbSuqmS+2b46ypHDzRj52jiFx+baNy0DT7R8fjU+LRBiQcQXzVfZyi7pcJLV6u4xV6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1066:b0:3d1:54ce:a8f9 with SMTP id
 e9e14a558f8ab-3d2c027290emr67145905ab.10.1740141842953; Fri, 21 Feb 2025
 04:44:02 -0800 (PST)
Date: Fri, 21 Feb 2025 04:44:02 -0800
In-Reply-To: <20250221121653.2463-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b87512.050a0220.14d86d.047d.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in cleanup_net (4)
From: syzbot <syzbot+30a19e01a97420719891@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+30a19e01a97420719891@syzkaller.appspotmail.com
Tested-by: syzbot+30a19e01a97420719891@syzkaller.appspotmail.com

Tested on:

commit:         33442609 Merge tag 'for-v6.14-rc' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12801fdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61cbf5ac8a063ad4
dashboard link: https://syzkaller.appspot.com/bug?extid=30a19e01a97420719891
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12d07ba4580000

Note: testing is done by a robot and is best-effort only.


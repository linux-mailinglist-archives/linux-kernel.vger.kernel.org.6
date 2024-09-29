Return-Path: <linux-kernel+bounces-342851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB0A989399
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 09:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17EE1C20A46
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 07:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCE813B580;
	Sun, 29 Sep 2024 07:56:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF5F18641
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727596565; cv=none; b=u5s8ljMd0wDr4y35q1EgDUsYo+Z4Zq1D3F4VvMU5ufzFXShnkVAn18tUGN6Q8zZ3MtYmWbuNf0pvl5RtCvz3sqhpSa2NnaCY2nbc7B4p6dv54bBi2I9xxJIrKkrjCb92fIFhphO/fDWRXxSrJyKj4YEydQZ0+uED+8whc0g9eG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727596565; c=relaxed/simple;
	bh=8+CbVdfGDne1Hvxsrd3//a46LqNwuTENbdw2JtE2UzE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FipatTdolHHLaTobO2hSUixT/foGW844w2fRRWQA/ATpv9JQRfp892L6gXcz5iQq3iWjPZH6a1yVmOrVUgZhFbtsxs+wqVm2/drwSO22b/swGFGV1C0EohBYAAb5f4xeRGO4c0crJq/i4kr79fXJWEW/tsuiw9oU8ZszVaPUcr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a34205e146so39757025ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 00:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727596563; x=1728201363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUzwX6mxYVpSgUkhjeitTncoOhzHezULz3Q3yaRvXjM=;
        b=u4QDhMtj96+dXWs8JPu+Y0lDqvuZpJ6Pzf78Ou6N9d4A3EFya2gyt+2YYd8hiuTGyQ
         RnAt3LpIt0QUpm5XymkFNQi4YIDeuYAgM+qT/OuNqo2DTMsjoawlB7/bVP6aMNN3LIiz
         ZDtYGcWSDp/OqXxGjI4p0Cags/PauasDYensrVpL2zFl7LD0Gno4y2V7mw2ucaGgVoH9
         vVrSb+e15xUwtZqi0Uq2LwuafuEOn3zBWyt98lNnVvBBwu2u6brLLf4x3V51sAHja4HU
         jV/Hfat9A4Vwq3S2K4XoILTLG2lpcM6UpjZAcY5LR0TXzeegilDMPLQKLfQbwTrTrM/3
         yjUw==
X-Forwarded-Encrypted: i=1; AJvYcCUpkCUGUKTFXxHQzwAIRzfvlmrxQVVTWify5SQfRNVGS81m69DfAqCu5W8ERrhdLgaknzS6F2Li4YxHSKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy81ryjfrUNQV3P4UekwdZxF/GJeh8XFuv/vy6TeXY3o+jQ35ya
	VOBkZ7PVo4ANRViZ526CWYlF4rUL73qw1w+bIulQLOufc2cDIPpb6wUNSisg6iD2cSrNFrCr0EZ
	P7zV03f/XxCnGVofcjSYvlWqjW0Oj9gQ9XUBWy0aGd0cnhdoBEFRScPg=
X-Google-Smtp-Source: AGHT+IFc8qoGodlVESBKbn9rG/d2rs3mzXVHpXaOvVrEpSFvCucTOb2IR2C/D1/kV1OtjPxVdra9qaDiHj2wYxIvFMMoo4MNVCOa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d84:b0:3a0:8c5f:90c0 with SMTP id
 e9e14a558f8ab-3a345169bd7mr72305835ab.10.1727596563028; Sun, 29 Sep 2024
 00:56:03 -0700 (PDT)
Date: Sun, 29 Sep 2024 00:56:02 -0700
In-Reply-To: <74a699a0-d3b1-43c2-87a9-08e8336d9c6e@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f90812.050a0220.aab67.0012.GAE@google.com>
Subject: Re: [syzbot] [bpf?] [net?] WARNING in sock_map_destroy
From: syzbot <syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/core/sock_map.c
patch: **** unexpected end of file in patch



Tested on:

commit:         3efc5736 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=968c4fa762577d3f
dashboard link: https://syzkaller.appspot.com/bug?extid=f363afac6b0ace576f45
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=118ccd9f980000



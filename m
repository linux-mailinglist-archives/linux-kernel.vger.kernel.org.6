Return-Path: <linux-kernel+bounces-174024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7358D8C0943
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0BBDB215CB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E060213B2BC;
	Thu,  9 May 2024 01:45:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249512C184
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 01:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715219106; cv=none; b=W9tAaIVOm1tyyuqQyyFvGvVKzJdO+Gl+LaKO+r4xjbmDRk45vEglzUuT8CMviL6n29AlN++8WPe56Qf1o+Umh0uVhnJhvRCoy08JS8xUkYJTN7oX+VtauNdHMshj8/AHeK04djp5AJgB0MDu4C+isteLjjzR8OlTTZcwI+XbcNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715219106; c=relaxed/simple;
	bh=vSVL60bh16yhR+ctxekFRNTh9Af0jyPIzqa8o3T8MrU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Jkx/KbzYReYHX7+NulAmojqQbvPpuyYZ/KYcqobV5w4f663/bn5T8ro2W5Ixtp8IwNXKJsUQJtwK7u7Rq8XwL8hqmsGtZRYS48j0QQZ+bjT6P9YxrX+Jazd2LOdclTTjTNlJFLuUUBO1yuMfH6x4qDU4COcATGyiuT22tVl97QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d9d0936d6aso34588039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 18:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715219104; x=1715823904;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z9e5GxcHfGQd4FmL3tkaCSV5wErLtu9uIQtGUuzPB0Q=;
        b=c0fql01njPcyx0H4zOfUn9jkpDNOqbV6urBECHVtcIx0bExd9RY5r0Gg+5SvMYLI2C
         V389u32oJEjUyKibkRSOJrHPopkcADWqaZjvn6Cja1eG8KAi5wm+v37TzbPNr9enzEgG
         GMEWpCm564xCrYVNoQaHp7q6BfG/nDaLZNEvdSnYfy6h4cNPcEo5udmQqKbNYHz1kq9w
         xjw5TX3L0pPZji4zNjrMj48PZaPGrdjBjFc+6qfpmS1hZ4T/aVWaIcKSATJUqvH8uppv
         mP2O63rfybZY974wIU6y1rlYhURs6P9F7gtP1rrOpBMbDHuwyadxweEsji+kC+ZBqRC1
         QO2Q==
X-Gm-Message-State: AOJu0YzF5biNSTDOtbkOmpJYEEWV+qpXnlXT1K9IhI+k7Bq61cgbjsAg
	fyicoO2lvwZCGtRenJKsP7/95ZS4qPGIbP77DNELAhaf7NPXMasW8N8V1CeI5q+8O+zpEJYEo4L
	+a+XO5Rf9f9A5uLlRjb4IwX2vjt2EK3yLcjQKVr4JL2DIBWhAtBbqIag=
X-Google-Smtp-Source: AGHT+IEFj2L/AOCgoUghYZTuSkLhq5eXkd5sf+lGcGQSLjxODxn2w5cY7JLa9PIj7+LmzIq0ZMfFI6GDu9Z9DTefwJ0Q8oIyOVSs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cac:b0:36c:1004:9aa1 with SMTP id
 e9e14a558f8ab-36caed1d1e4mr2690515ab.3.1715219104385; Wed, 08 May 2024
 18:45:04 -0700 (PDT)
Date: Wed, 08 May 2024 18:45:04 -0700
In-Reply-To: <ZjweBJTpThEQSw4u@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ddccf0617fb9184@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com

Tested on:

commit:         02754103 Merge branch 'rxrpc-miscellaneous-fixes'
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=1796266c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7da3ffba7152e6
dashboard link: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=110ae54c980000

Note: testing is done by a robot and is best-effort only.


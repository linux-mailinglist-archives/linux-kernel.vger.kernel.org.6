Return-Path: <linux-kernel+bounces-216105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 014A7909B6F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 05:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91272819EC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 03:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD58149657;
	Sun, 16 Jun 2024 03:52:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C6D2208E
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 03:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718509924; cv=none; b=uPZ8BzXTPudlJU1RC9ygviTk2xacF94NbIyXm3qJqliKVLu9ZdXMKpkOeeZVVL11+C+XUoyz4hAGZky/X4QjgSwhszhhkH0QUY6YM8jhvjpzfev9vVGDzxeGqbWJvY1oqA0tBQ91hNiU5vO2kofmcX7xNDTJzZHqEKgzZQH2aEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718509924; c=relaxed/simple;
	bh=33MW8ZfAnNsXOmYGMIPBdFN4qlzmPIxURjoaXbwZe+g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uNNx72XBI8sHDEGDh/G/3lIoc5spSgj21ikbrd22vb5SAZJv/MrF9ZlgHQndAO+sjj6GXQM5hol1UapUgnqRJCKZuXvCFRq6yXYPgOxkgedZElYXs3NkIOCBdXAKPFq1lZya9Uo2XHFir2WwDlXgwCh7kfPbzLggm2dqEnAfpLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-375a1dbdd4dso35435245ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 20:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718509922; x=1719114722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6a+IhYw48f5ZEKsPkoPMix4porwuiMSK6EgdXXX2BvY=;
        b=qXWJ1Zru4jKjPLkF3Vn8cjH353MbDKEnTT3l7JHXEYsNAzz9yEYSp8RFoYAi9I34Wp
         L54x7iMwSF4tRcA8N29ak5aUFm16zOcHEj76osWBNA5yRzciVkphIFitRtNro8y6vk1U
         tvz/XkQDgIAgMlZm7BP/X2+P11+16vfEkkiF/Chl6bTCHJjwgclcwQ07mtqV4Az4hHY9
         GjDuXast0wUiXARxvbnrARCcjqpKXznLmHKqZQNnrsSYzsY0yUXgCmVPMYUhx+rr/eGz
         XTmbkGX7a97Kfx8VGuusAj0eMTc06ZWASvp6+f/zyZnAlOa6SkW6t8pHHf/rT9WGajlC
         BZcg==
X-Gm-Message-State: AOJu0YxRG7zEvfbc3pKcD6fDY7cqRwKUVel5jMXV1KFKmQTlzgGeL7d+
	QoismeNnjnVH1EGYU7ZwQ9HULe7Ap8BCSW2yMjVUJLOSNdOXvPtJvECs7W3Du1iX5y7pSVBJ5CM
	XLUTcBCuJAmlU+B6GZ02bgcwwob5dg2BBfxMEjjqDOYCSo9CV/wpjdVM=
X-Google-Smtp-Source: AGHT+IFIj1EUhazCu0aAl1BedCTZYfmv+6w6EN3SSIJt6SbSm1tmVYJz106GGza9OTbB0O7ko+lJktYBabzWT/scI8tYOzJ5+NSG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca4:b0:374:a840:e5be with SMTP id
 e9e14a558f8ab-375e0c4c928mr3704635ab.0.1718509922146; Sat, 15 Jun 2024
 20:52:02 -0700 (PDT)
Date: Sat, 15 Jun 2024 20:52:02 -0700
In-Reply-To: <31ac448d-2a21-4e93-8a00-5c7090970452@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073ef2c061af9c511@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING in hci_conn_del
From: syzbot <syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, paskripkin@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed

2024/06/16 03:50:59 ignoring optional flag "sandboxArg"="0"
2024/06/16 03:50:59 parsed 1 programs
2024/06/16 03:50:59 [FATAL] failed to run ["./syz-executor" "setup" "fault" "binfmt_misc" "usb" "802154" "swap"]: exit status 67
mkdir(/syzcgroup) failed: 17
mount(binfmt_misc) failed: 16
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed
 (errno 16: Device or resource busy)


Tested on:

commit:         a3e18a54 Merge tag 'xfs-6.10-fixes-3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=145ccbfe980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa0ce06dcc735711
dashboard link: https://syzkaller.appspot.com/bug?extid=b2545b087a01a7319474
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=130eb12e980000



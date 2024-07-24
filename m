Return-Path: <linux-kernel+bounces-260488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E3593AA1F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F3A28401C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 00:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CC817FE;
	Wed, 24 Jul 2024 00:13:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B7D36B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 00:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721779983; cv=none; b=rjsw8d86FVOpFEfaknHKjwJz8tphRNo8DYXJKQAJlR4HmKM6qHOQX75nOh2RzAjmMQ2cBJ6vzWOHvgrrXQwGuNQggiRDxz5uUF6uAJGLOrwSQixhE3Ae1uGs7Ss0d+h1Mf5x1uBkF2HvURnYcF7jxcaoqoR2pv4Y0z0lp9y+Xu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721779983; c=relaxed/simple;
	bh=9eXMrgjrnEGwkONw4/sn98WfFowk/b9YWkF1jlYOxdY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RsdG3LmY4DVz/u76a3ZeXS2abyrNdV34xIhEEv98d563TQnQdSLRHLYQClpLwtgHNmRZj3IW8D3dgamfuAIhzlhK3FXS0ulU68euIMEgCZvRgQ5xMh5HTA2YN7HWXOXa2o/NeXvPKQvLSXy3jpbpVAYEGDAzZBLqx2s2HPuF7Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8152f0c4e1bso1079119239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 17:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721779981; x=1722384781;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iECquDb3LpX468GvcPGLqd7u6hFLjB85umGr3V7YPGY=;
        b=Cc8700yvIvuTLBEtikklJyNkzyQfySYqx2nLCs4KdyTR2g5YNC+/j9YwRJ5j+Mz+rJ
         LbraAS85RAi141200IN9yGHwiJ2MoV5X5pQz/29NnmWh4VIyj/ZBdMOZBfIQDEOUzTT1
         2oMiiEGMbCtcqaKcGn29aQS5vVGH6sNfWzxRiPUi5gQz6XR1XsvskKYGUXYXWBxAcDj3
         AwpdFiKLYLZJnnUUeYId01JB+k5sLTqkJuv2ymlXjNc/vNWUAtc+kTuGATHK+fgpoQCv
         lGxv5c3hHVbO7LtP8fEoUi6GIOEC+rYsZLZRNRw/3L0egFvOkRrJuLGrx6otKtI3kZ4y
         vyVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV310SoyxC0iWNCgceK7PwT38M7XgW5528/F+AMYB+5/JlndsvdhQtWzjIxvMUBoQsGWWQSX6d40751eZ7OdoUhWzZH5XGckDRTSvJu
X-Gm-Message-State: AOJu0YzKY81zDiBrI3aNY6Qmbh3FsGe6gR1wJiCAFdZGkhnIEp8fd6/a
	9JZlBnMWOlcVsI81h7rULBv7F+lokrBzGyI5ZgEsdn7Z05lnvJCYcK2ByFWJyPauzA3A77QS4NN
	JFM70gcNXw+ybcoO3c2nMy0puFFgRY3cUXh1+HLeIqb0yTO1UlqDJaak=
X-Google-Smtp-Source: AGHT+IEU7pSRVZGHBTpxd6hs1TvLjbwoEzDK/zA/ys9T3sGuFjgU1pD6VcIeNOEA+GOn6O7FPYngZZkUy5BnhWkO4iVhsLzZrSGz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1384:b0:382:6a83:f4fc with SMTP id
 e9e14a558f8ab-39a194ed0bdmr600315ab.5.1721779981610; Tue, 23 Jul 2024
 17:13:01 -0700 (PDT)
Date: Tue, 23 Jul 2024 17:13:01 -0700
In-Reply-To: <20240723234627.1630076-1-cam.alvarez.i@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f8335061df324f7@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING in bch2_trans_srcu_unlock
From: syzbot <syzbot+1e515cab343dbe5aa38a@syzkaller.appspotmail.com>
To: cam.alvarez.i@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegoups.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1e515cab343dbe5aa38a@syzkaller.appspotmail.com
Tested-by: syzbot+1e515cab343dbe5aa38a@syzkaller.appspotmail.com

Tested on:

commit:         5ad7ff87 Merge tag 'f2fs-for-6.11-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12aa26e6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f1f11254d56ccd6
dashboard link: https://syzkaller.appspot.com/bug?extid=1e515cab343dbe5aa38a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=106aab59980000

Note: testing is done by a robot and is best-effort only.


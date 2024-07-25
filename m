Return-Path: <linux-kernel+bounces-262165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4908A93C1C5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F081C21F02
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F069919AA59;
	Thu, 25 Jul 2024 12:18:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A34319AA52
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909884; cv=none; b=lafYFhmQjUg7+0bQUbnbxPsAQ5bBdn5M1+1aaA60gaQ0u+NwX2dfBHPkK8mYpSYfB0fg0+QNAdZUVlBK/T16tCePicgYklBEYayn+0EDrJsl4tq0Ai/9EunvaTivyHyFT15tl/SfwmR4E8FUDHkkHAffIe1Tf8EXId9RQK+mE4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909884; c=relaxed/simple;
	bh=QUZCTHzXeeq+2kWtXWXBo4OiRM9Vh/50lJvkB8qnI40=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eOQ8HIGtZNa3OEI+ElR78bgnNvk2ZX4adhcglENFLlP7msPyNj5RQ9EMVVoy7wNQ88wMcZdw3hHdp09bxP5oOqdQeFHOuvc3KqqEVmnDudsMD9P45P9dBHOPXJyoshPIiE3aawCgMVnDmQLm3AIHj4lWT25LuqkxxFyQK6ddQ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39835205d20so8775165ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 05:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721909882; x=1722514682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2y0RQH5RftxEUAQlMUmbsisn2CENlcney7mxLJZpDd8=;
        b=VhUjo65Tzayhwyrf9ipIdUDqLWQm2vTzCOi5HZmjhrPKtmfkQMdFxH6PBTUtCXIWlw
         GCdzBrQWlzdqv00HHSi/RQoS1xHa6uSA4eo16RYNd0YW7czETE7GrwM85CvF6G9BqOm0
         KWBPm35Sj7RjkFTD3z9pxi/qj5UC+mNKx9RFZgvo+J6v7OzAfVbRql/gL2J1I8uhO2d6
         rKNPWKgKKBeH1cehlDl4JDPs6hpnuZ2Wv5dddh03LDWngUSiNm/Mv6BzQZZKId8RVC0d
         hsf3dZlDLD2+5rh4FKHA62m5Gpy/IW8j7dOd8BvbvYcyi8d8ijvp+88F608R0B5137UV
         mtuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4Yo5SHAmcy0g+s6gYCIQxjuirgYL/Owhh9NzUuURAPgid1B1udFsDU2V4Lab9izrIpiQJeOhWKAM8hjnaJLxm1ABcBb9FqYrUijF0
X-Gm-Message-State: AOJu0Yxs6oHIgytgeP7dO0URysp1XNIc6DRAOnxI2m+vtGJPrl7Qnlh1
	Fv0KPLTzaIPiWQTqkUfh47ElN4PpUMvJUYqL8CDSnGUtO27LfGKDcny87ox9i83jAx67cpvOehb
	z2CED+OpK2T/7ZXXr+8uSB9nnYaI5QXvSBrrm/Tr2S37/UibLACfsPig=
X-Google-Smtp-Source: AGHT+IGMCqHQk/NxKDkb3t3zxzJx9D5ZgFLY1mxbx34r1lxj86NTIqAtsinub5MIOAi6AUFe+m89csXzIh6tmgMqPpM9z/wnJNK5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144c:b0:381:8fa5:3d9d with SMTP id
 e9e14a558f8ab-39a23f969demr1539505ab.1.1721909882419; Thu, 25 Jul 2024
 05:18:02 -0700 (PDT)
Date: Thu, 25 Jul 2024 05:18:02 -0700
In-Reply-To: <20240725112758.15367-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e08c95061e116256@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in __dev_flush
From: syzbot <syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com
Tested-by: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com

Tested on:

commit:         c33ffdb7 Merge tag 'phy-for-6.11' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=108cff95980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=582add3de1ac8f6
dashboard link: https://syzkaller.appspot.com/bug?extid=44623300f057a28baf1e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1462adad980000

Note: testing is done by a robot and is best-effort only.


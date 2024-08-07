Return-Path: <linux-kernel+bounces-277724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEBA94A546
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E337282008
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3AD1DD39A;
	Wed,  7 Aug 2024 10:20:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4033A1DD387
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026004; cv=none; b=Bis9l8XVLsvOxOXKFricTqxIB10eQ6tBwX6J553Vxpx9EJKylr+8htUQWhlmceW8CqbZPor7TG6Bhd5mg3qlscjwgMkOpK6nIjKx6Zd3JsdX1oBnIh3KWAkYg36UjtcrlbcX3UWZ9UwhyZM6uTrvEeG12oFlmHQUasMdHdyEdwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026004; c=relaxed/simple;
	bh=keWIxLYhpORFuIJlvoSho+uC+SaNm4Bt2dkpXZsCPxM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d2qbcrI6Q5h3UU383tlQc2gdrOngildMQX2p9DQMlMP3NQvBazoMxbI26xKnQdawMJumDiLAqtKLthAZ5X8YtAs+jmlf/mvXK/4+TwytsskbniZG2bd/AR8RzUZLI76c6UulGIP7jAd46bC/ALDxT1Lv5GfQLEXdxH8MUfJCoYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39ad7e6b4deso22359765ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 03:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723026002; x=1723630802;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IIwxkFNanEIFzzrWq2pqvNKwPcjv5CCUa75gIxK31XM=;
        b=gaR3Gu1zzFjOqTAEv/kUvv5eNYaEtTOqav97r8/MO3uK7Q+pflCVvtTblRVcvIuoUl
         Rm2U10dcF3d2bIRKzVh9pLIRnfRgDNfgThGeb7vjPM736RZs998XhdXTIIuPTd22sQNE
         /BUiZIvPfyujR7PWqjaUKWqSwLnS3jF7kfcYBqQ2jX5JU2VXdZ3iMn0blG4jnxxhP0jG
         wckiZtcpfhCc6bRR9GXPTjTg7s7r/AFsPqxK2DP55fgpcz97+lAy8favUaf6oCdc59l5
         M3q73o1wjTcO9fZk5vTMKZkNOnukc3Ml/2vMnChIniH1JmHQU9ePiURIDjkkn+/cMY1v
         07Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVmPNWwdSvQMU2IiQZCGro3b8gRSoqK5Su4Y04WLwU7794mfrTsnpLjW6aTaEE5qQS9SqnFi7DgoqVNQoqVaT6FwI1Fp2PG5hZUX62B
X-Gm-Message-State: AOJu0Yw90x4r8s0X5+o4+kh/5LCSZS23wlHHxAMQL7MAwyj9bNfjWLnv
	sz7LXXq0Lag0xpoamuj8f/woDiusAHY0IcMSQ1KC/XpYiXMWDYziF8JvLhCkxclOJ78bZIKoMEV
	JK6fF4NsOl6IvTF3aTU1VunMCpL5h6WnSoBY548uAlH7HUkccfb4Wn/c=
X-Google-Smtp-Source: AGHT+IFo1Xuh/nJQvNs8e3WwTijwy+9At9EBsz1C/AFWpO8U47/KrAt95I71g6/Qc18m3H6sLDwL6GLCEpzI3YSNJLQUEuX/+Z3H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a5:b0:39a:ea89:22e8 with SMTP id
 e9e14a558f8ab-39b1fb84174mr12483515ab.2.1723026002318; Wed, 07 Aug 2024
 03:20:02 -0700 (PDT)
Date: Wed, 07 Aug 2024 03:20:02 -0700
In-Reply-To: <tencent_F81769376726C61363E365A966E3A3044405@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cea9a8061f15409b@google.com>
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_session_put
From: syzbot <syzbot+ad601904231505ad6617@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
Tested-by: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com

Tested on:

commit:         743ff021 ethtool: Don't check for NULL info in prepare..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10835911980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
dashboard link: https://syzkaller.appspot.com/bug?extid=ad601904231505ad6617
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11743f4b980000

Note: testing is done by a robot and is best-effort only.


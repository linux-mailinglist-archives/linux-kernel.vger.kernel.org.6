Return-Path: <linux-kernel+bounces-263533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B4C93D75D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8517F1C22E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786A417C7DB;
	Fri, 26 Jul 2024 17:14:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5017BB1F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014045; cv=none; b=utzgy1bRYqU81K7F7j8EEeKUIvtcnjQ/njtCEnIEQYQrlz+fI86xXIMfHIvlo2y1Vboig2cXfiWo3FElyDzVQ5z3jKCurCwWQMXJso07czg+ZSNcQj2D9aD7tU4q/cZLyS+zKVFTVXMXj1wS1CRXqUlW45gSkgG9w+hezJcTY28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014045; c=relaxed/simple;
	bh=64yZ9RmbQ0L6we25HuuJsE7L4te9c9X8SvqEPGs7n0Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gZG3IYZ50Np4tmDyGjxbFT/14qrSf7FDT2wuIh2Yex9yvMfm104Fe7cKyaO5ld8Ijlo+HAGsClNEZwsbekppFuGPOiliCOgXhZm4C8v174ANZKMAzpoyAHtBOu6CBpn52wOxQNipFbg6l79wEi5lgCEqg1ciMT6AJU5WO0UhWRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f66b3d69a8so194763039f.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722014043; x=1722618843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3TYzz/fhzfnu28IvF0F832IHNN9S2GCU9Qdm9Pj1qQk=;
        b=FR+y+jVojRKciCTW4FT3XYAoB55b8/pii+5aA0ulz0W5VkV5aLbZVNI6R2JigUcEKe
         dr9thsTMtYgf6wYZQHovzH415S2y4RkyGLgM22fZg+vs+Yi6cunQQvpHSv5mZ+g57vjP
         vvyfBIoLWWuYmknw2CLYgNtjld+b5wcY0TZrLaU3P8PBXAhydU8C5ZRSifsTm+XLi/Mm
         rqQBNu4sUqIqIRPijaF2dbmduAq5NjZqjMuNNy5UVJKiUDfG60kKk1I7s0DkdNpDnsnv
         q+INrp3PaG9VnIH4lgJzPM83q6KwoOdbNPOlRPDO46Bc3s+kFlni6h7RppA3kwD7MRcW
         Z/bQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3iWn+1rHWjhZ27DzWi4/1MmbALh7IRGABbUFQK2fhvthyD27hkpVrzDDfdHVjv7Cw5PwzVrFMC79duWy+xebcyLzJMRaRCmMg7TE7
X-Gm-Message-State: AOJu0Yy/VZ5/EqRYxoZFgyjQPMB77dgjjETvnQgGv4rL72eVePgM06yr
	ogdMUooeF9Vcy2LBJGiW7potbCksDA4PqSMaNcfTv1lKws4PUjJJ5p9Jsmz+eAuTxslIxUki1oL
	1LxD+Z0GOAhg+6+dw07jKB9n8UNwk3Wy1eB5U11aaVqR5KWliGoO/Ve0=
X-Google-Smtp-Source: AGHT+IEptuQ6t+RWfMbk7sRlkQx06AQ9As0v+7TXOg0GNkAW2b3jOLDNTSLgp0XxGLlknowPGXzaOJmRhN4RjW14mHKFo8ab0dka
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cca:b0:81f:904a:51b1 with SMTP id
 ca18e2360f4ac-81f95a37577mr369139f.1.1722014042936; Fri, 26 Jul 2024 10:14:02
 -0700 (PDT)
Date: Fri, 26 Jul 2024 10:14:02 -0700
In-Reply-To: <tencent_ADCCB667DF06D952FB064A89952ED1AEFA06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053e7c1061e29a36e@google.com>
Subject: Re: [syzbot] [wireless?] [usb?] KASAN: use-after-free Read in rtw_load_firmware_cb
From: syzbot <syzbot+6c6c08700f9480c41fe3@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6c6c08700f9480c41fe3@syzkaller.appspotmail.com
Tested-by: syzbot+6c6c08700f9480c41fe3@syzkaller.appspotmail.com

Tested on:

commit:         93306970 Merge tag '6.11-rc-smb3-server-fixes' of git:..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
console output: https://syzkaller.appspot.com/x/log.txt?x=130f6e03980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f828342678294017
dashboard link: https://syzkaller.appspot.com/bug?extid=6c6c08700f9480c41fe3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11d23475980000

Note: testing is done by a robot and is best-effort only.


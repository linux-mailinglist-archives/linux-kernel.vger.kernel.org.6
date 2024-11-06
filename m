Return-Path: <linux-kernel+bounces-398970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAC79BF8A5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A307B223C8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F751D9337;
	Wed,  6 Nov 2024 21:48:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FE918FDD5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730929685; cv=none; b=UMx/EzLojm3F+bVKEnsk46AP5jbr5OBwXlg9z7HEG17QekRed5BYgWZ9fLCxieR/r3UJB9KeatobPr6IsneoH1o4MWYO4Ov9fmcPnR+haVHgDZYDfLlSely9LV2zU6OWMGZAr/iPoBPII2sQH3metPWdOWhD4CPrKYEuzVg/p/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730929685; c=relaxed/simple;
	bh=L/ARnIm1u6eeiUQOB1LLwKgoAkaJUeevTjZ+cEGCd6I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T1aSnfdxZnYHX/Z1s/1a0aB+AhnJBTHCdlGrQJrA3D9Ysk9zNRhEI8dk8lYjlJiYfmvDSoL+IfpzN4MFktztIM4W6fla85XMK0tjE0TQUS2VGNFjyXyDY6kkEqwFTBQk3GYk0Q+qUMt/FaGlVdNsKQgjttiTGGxMNgKNPIn+oiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4e41e2732so3793895ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 13:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730929683; x=1731534483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojInmPhleN/dUs2oSXWegTTSzM2m0iwKECEkAv/rcoA=;
        b=JBNHCbmDZA/ltqtLvAZ6TU+9Cx25Bu0dlRmzZzy+TnN9NwAMaADipow1msmrZt+4l6
         s2NiRLmD/bq4jztxfTZnOJXbQomgrU8tku88m0lP1RKzZcD26p70qAKm4nS9LbYZTFD6
         W1O8e81lqUKrXqhTWObQl66GcjnVHTEM7r+tTDpatXx92miQbgaTnLtxtaGZOKa1Pxc8
         5Srnt5lypcX++9KqaB1Ti8MQu9kLo/iBnTFKhaBBHyyXzCknXe3tdIDRDR0XvCkNfMxQ
         o9xmJMAm0kgBHH4AQNRuXw2uM/ne6KSS0EXnYDaF4X9eK+3pbbHhumVT3ioRjBU+ziHv
         qJgw==
X-Forwarded-Encrypted: i=1; AJvYcCX3nd5+1rHgorDxGMyFQ1TgHQBaI0z1Bj+jQ5frxx5Ka1QJjcnip4VVGwpXijtXp0Isw161UA1I9cfE9Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw07j1x7f9mABeui7LRviZpFfMTGB+GVSm8x1ZK6n/jwTM/wPTx
	L8Z1QC/FieN5EFJ61eVoD/MqwKlFLd7Za6Av9lo/4snezcDS24/EJGzWw3eB+OhdC/F1rXtHopT
	mhjV+7XavtnaGY+ftnDVYSQ5i1EFn2VC4VlKlY/fDvdOFBK9wDCPWO7c=
X-Google-Smtp-Source: AGHT+IFUC8aysLTjjcCNL4i9V6ZU/jbGdtX76K3kMmQ2rKrHUD010gXtdTQpAH6zxwkfTX5N79+kqbthNaKFSQiJbbhQG4mxk7Gn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b07:b0:3a5:e5cf:c5b6 with SMTP id
 e9e14a558f8ab-3a5e5cfc68bmr299261055ab.10.1730929683168; Wed, 06 Nov 2024
 13:48:03 -0800 (PST)
Date: Wed, 06 Nov 2024 13:48:03 -0800
In-Reply-To: <tencent_E298974436464AA47527762F67923C3D3609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672be413.050a0220.49393.016d.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_cat_bin_cmp_key
From: syzbot <syzbot+968ecf5dc01b3e0148ec@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+968ecf5dc01b3e0148ec@syzkaller.appspotmail.com
Tested-by: syzbot+968ecf5dc01b3e0148ec@syzkaller.appspotmail.com

Tested on:

commit:         f43b1569 Merge tag 'keys-next-6.12-rc7' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158176a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fdf74cce377223b
dashboard link: https://syzkaller.appspot.com/bug?extid=968ecf5dc01b3e0148ec
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1744ce30580000

Note: testing is done by a robot and is best-effort only.


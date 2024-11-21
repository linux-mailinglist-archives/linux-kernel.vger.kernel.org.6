Return-Path: <linux-kernel+bounces-417003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28A59D4D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F8A1B222C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384ED1D5ADC;
	Thu, 21 Nov 2024 13:10:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B511B0F0C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732194605; cv=none; b=QB86dAReYLFAluzKSi8ABNLq6WgL4uhZty3Tbejga0AFykXEpmWL+oIWO8Hdw7OpzFaytB5OXtc6X1PttY5h8LR7AHsfoRSfzLVyva4CeZd3YBbBFWU48R1BYkDu6HPhNVyaTbnuC92Q8y39HGS+7SoPHOHGsWURTuuR4ThE9hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732194605; c=relaxed/simple;
	bh=cr6soKyHEzs7FjNQynevndpr8UBZ5rR0byi3HSjwbD4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ue8RWmv2lKmUh20uXlBHUHqwoR2bmsLooUOSb8n4mEOGNg3INSeL3Y+oCapHbGTn3SRECiNM+yyz6ZWBKmJ1sl+8abOWaq+ti5N+VE+tsRqoyH0KGC+/Xo5U6IOB23Og0i7HCV3UtzdNtrTfzqcfmYUT5jkiZoABayZ36X78cJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83abef51173so95336439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 05:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732194603; x=1732799403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gv7AfqREKeXj/lQ4Lzh2ErA6NZI2NrmTQmXjhoUPtZY=;
        b=eMj+Sf1sY+SwniG0WQFgkFt3kEy56tVeh70HWhnN+gKwtTBgerwFdVN+hVqWwLxEar
         tbMEw94V3nOz89MMSvl8vovZxIMhkHUjHIjbksbeMTvso22eXCGrcKDl9S9f7IimqYcu
         +Da0HIJ75tt16ZHS9HrzehCaH6BHDWiO/pdpgINCZWlGMlls5Ft8IfO3Nzm+IdpFs9fA
         fH5pBW/JXnaOjTvgmmOQ+n+UKjEMrM8daW59Jhcp0c1VeKLVLdJJInyqGPwQVpjdr14n
         EC7ifOPggKrhcrPcXntgnJTTgKJH0rvBmB6B4lCZpuFSjpDK4uAU3f3nSohLITGox5Ha
         XjAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUaHkD6MvL/OzELi9++jfegb1/EA8rV2t/Y2Jv+8B3S2XI5Qfe+iA+PlbejgbPDp56GUijboRpDS0rj+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPNfiSrrSyWE33m9zDvUMY4O53f+VWW/maAj+XoSbRfr6rmV8F
	sJWspXjAXnJ9envv9W7rRpiL+hbNpEMtcv1TcQQHoaECRdJKuLOW/ECPN5tExAnSanD1XZOI+Aw
	Wbpg9r4TUWqUud+2tLM1BJS9GICfA4gUEshMyCo84i5PSRwacpE49MCc=
X-Google-Smtp-Source: AGHT+IH0W+dvVn27/TtKkqk1wiyXb9SfsEsiHKK6DdiXvC63BnG1hvP3NdbUW1boE/I+QJ8SRBpFmOQMoVb3GRbSSXpF0ZZnC78K
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a68:b0:3a7:88f2:cfa9 with SMTP id
 e9e14a558f8ab-3a788f2da1amr57761765ab.11.1732194602918; Thu, 21 Nov 2024
 05:10:02 -0800 (PST)
Date: Thu, 21 Nov 2024 05:10:02 -0800
In-Reply-To: <20241121124343.VLW_9%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673f312a.050a0220.3c9d61.0171.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data (2)
From: syzbot <syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com
Tested-by: syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com

Tested on:

commit:         43fb83c1 Merge tag 'soc-arm-6.13' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12c05930580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1638cad79464dac0
dashboard link: https://syzkaller.appspot.com/bug?extid=fe2a25dae02a207717a0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=149beb78580000

Note: testing is done by a robot and is best-effort only.


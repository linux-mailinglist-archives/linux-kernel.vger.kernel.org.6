Return-Path: <linux-kernel+bounces-520554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38562A3AB71
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC2C3A475B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254161C701B;
	Tue, 18 Feb 2025 22:05:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBA21D0F5A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 22:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739916304; cv=none; b=aZ1KpJekL8NyBpvBMDXGCi5asGELuK7a0iPESO4muCb3HEHG8inwSlvphcHA7OXYAmVNGVgRszxozU5VDTueoLdoJSEFd3vaMgn/vMAzzMKaxH40D0mm9U8Cvvhzk7w7auzpWJ8NRI5n82JiDgREMr3iKqEOJm2F1FO3H41P0j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739916304; c=relaxed/simple;
	bh=YAwz6c0pD7kSaVjGnc4vj0FlpUoq5ws50vP1ezS0ePU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jOpO/tDhSUD5h95TFGLC3xK0QZ97OA8wDlBMjymNfX1FOE/eiv82G8pHTphZf6YmuW89+yOpa5C5w6RgzScM/5Jd9redjl/jjU4Cor4Wwcw5g455zLEulw62LdvaVwhN8mHdYwxVTTUJH1ScFjM2EDh+DYPh3ve9yyxNjsDmYHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d2a63dc62aso10686955ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:05:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739916302; x=1740521102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FImqr+4BueBo0iUqhlEc55Y3VSXeJLj+aXSM8e+ulyE=;
        b=dNFjufogFtS2SbusUwFTuBZ+8uIs+uBCdin1Nyjxwa0QmZlR8leKZM4eeRJM7HQocX
         9slnmjOB19dWJXxydv43MiMBGXyFauUS0N0OAAEGOMnsknpb1ohvgAtkM4/HtL1ZiRL5
         87p4G715oTp2rPTciEgkGk75C98q/xo+uph+q4IWPoBqX/50wjgGgczRbcEwgA1Y+fjB
         SSI4Tjg3p/fhacoQAUwKdVU6g0pgLXr/9muoOsd7dkngih7IB/JeKGAxUkizdAKFU02A
         nN0kddPZxi00jOEHgGuyF3xSEJOtV+ZT36HMDKQGt31UjVnE5roz5+wbenm5ASPlqLZd
         9VmA==
X-Forwarded-Encrypted: i=1; AJvYcCVRdotEsDi68gLTQzfHjY/9Hm6QEUCfq49U6pQNTmiNfSPieO6vSmv6zlAA3sUHAG3wbjwfFOtaLJ4+Zyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwohxJwaEfSr/mwSNsjToRmI7mZh8Um9RNyRKA8jJol85gfhzLQ
	m87sJerPZF0kEM+styt1XIgD8XdDBMIxT2sCKRhHSyWCUIlcbwekolBbLE8tC7Rs4TixaiFCDtr
	kpooQPPERj3zYPVqgpPyiZRjUG/5tN9vs6N7evsVS8Tr8KMviWz0Lmbo=
X-Google-Smtp-Source: AGHT+IHFkQCkf7a+SjYszpFggOY908K7AMaQySeg4oPtXYgEqe6lCPeS8BsNAK7kIVcqDKND1GHr9KFAOVOrC1/lZzFlrhnkRlkU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1689:b0:3d0:4eaa:e480 with SMTP id
 e9e14a558f8ab-3d280763d29mr156645915ab.3.1739916302497; Tue, 18 Feb 2025
 14:05:02 -0800 (PST)
Date: Tue, 18 Feb 2025 14:05:02 -0800
In-Reply-To: <67b2eaf8.050a0220.173698.0020.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b5040e.050a0220.14d86d.0013.GAE@google.com>
Subject: Re: [syzbot] [bcachefs] KASAN: use-after-free Read in crypto_poly1305_update
From: syzbot <syzbot+d587b24799bd8c2d32f4@syzkaller.appspotmail.com>
To: bfoster@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	davem@davemloft.net, herbert@gondor.apana.org.au, hpa@zytor.com, 
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a303a4580000
start commit:   2408a807bfc3 Merge tag 'vfs-6.14-rc4.fixes' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17a303a4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13a303a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6cc40dfe827ffb85
dashboard link: https://syzkaller.appspot.com/bug?extid=d587b24799bd8c2d32f4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c4f2e4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e4c498580000

Reported-by: syzbot+d587b24799bd8c2d32f4@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


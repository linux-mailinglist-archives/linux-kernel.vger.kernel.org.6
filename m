Return-Path: <linux-kernel+bounces-554377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A89A59703
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C62188BC81
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C29022ACF1;
	Mon, 10 Mar 2025 14:05:11 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2FD22579E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615510; cv=none; b=EGUoK4wfnHsHGO47C2S3zbMEoh/XlDMhS8Vfhx8YjZrjG8dAjdrcvyF9CxGQKkM0xekq5DeGgQ0c+RHMNRE0621Dxwb33A2AvCY2X3yzSjGsousX5RDKZlx2eqs/uXwSvawlIXX3g96wLe0btN/hLyJz3qk/vAT/d9DdGOwGsgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615510; c=relaxed/simple;
	bh=gXBrYCoCcrkWmsP7+K4nV7uUoW+IqEsQV3WmXOQ5P2A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C/lkdu3bZNpbZozyDLLTOshGF0KzITLqHKNZ80HfIJwHmlDb1qtaauxHVTCyAzuVw3hAb9lCs8EyO8SXir3gtLaHD8J4MTS5yoDpOQRcLbC6nku9+xKJU8iS97Usy1XGtvDMBnN1lEbaM+5ZQdlQCa4aK8Wc1ShiIQP+9L3ebTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-849d26dd331so456619539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741615508; x=1742220308;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaDrDkpXTwrG6aVIZuXOhK/+8GmMdBih6elTHPJ7xwo=;
        b=PbMihWrbOnug71aSQhI1pspLzV8Do6144kuQwgTmtmCh8dVdUMRTLxWj87oZKiDU/f
         cOeNOFEEuoHV2eWM2dDEWgJ0IOYFOv9MjaWqHwZK3i0QI+J1KfpactvSMsAsiRIEx7tL
         46bhm0ZK3cRjqqi58gkJwe0ZW4+wKOhMG8mnABRgyH2CCYgRMhnU09XVhF/1Mj2bP5B1
         Uag3sh4Gh2QApCiolEaZx2hY2+8+wEpkycThOdaxqzZKtclQMKzWHljVDM2lcXTuDneO
         2k1VQl15iPorkrVb5mOi30BALasrtZrO+SNb+jzxWyyV1jchlvqfYJEdiUu7L+eXHwk5
         I7OA==
X-Forwarded-Encrypted: i=1; AJvYcCWf14M0gRtYzZGwFpzry/M3EIEokpckzV9+h3nhhANhCZAyLyuBpgEdr8B3S5u3DWeV7FAB8+4MqzTKzPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdSzdDzpjhDBU0rfyRsxs7wzravfLVEZ13JdFVKWq//AbfKd8b
	jxDYkuFAIFZUV2PksrAaE29hLjHmWHEcerKYPrGSbXL16otKTAt4FfhMtyjCTUqsgJQ8TSdtsDR
	SN1ZQkhWzYZ72fiM6YB+19o4+qXa2l0eP88ID6tmxmGWF2YUBJ5iTjfY=
X-Google-Smtp-Source: AGHT+IFcfu7iZ9iAI/dbmeiES7ZqK7CGYDHtmKqtojBc/d+p7jhFfL9oM0l6REB/F23N9BxkhMQ6AEjSytGRFKCCgcKMcAdb5ta/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a85:b0:3d4:44:958a with SMTP id
 e9e14a558f8ab-3d44ae9eb36mr107656265ab.3.1741615507153; Mon, 10 Mar 2025
 07:05:07 -0700 (PDT)
Date: Mon, 10 Mar 2025 07:05:07 -0700
In-Reply-To: <6735aa91.050a0220.2a2fcc.0062.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cef193.050a0220.3d01d1.0010.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in __journal_res_get (2)
From: syzbot <syzbot+53bb24d476ef8368a7f0@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit fb8c835b18d48dac953a5d755a8e90b0d8fb9c29
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Oct 12 02:50:48 2024 +0000

    bcachefs: bch2_journal_meta() takes ref on c->writes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1487d074580000
start commit:   bcde95ce32b6 Merge tag 'devicetree-fixes-for-6.13-1' of gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1234f097ee657d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=53bb24d476ef8368a7f0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ff98c4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ff98c4580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bcachefs: bch2_journal_meta() takes ref on c->writes

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


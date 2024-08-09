Return-Path: <linux-kernel+bounces-280801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D66E394CF65
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92118282BE2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774C1192B93;
	Fri,  9 Aug 2024 11:36:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B470515A848
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723203364; cv=none; b=JT+3PncSrcCWvlLtAtZ7bVF7iXg1kqTBCNTCrDDcXO73jlM8EUvwUDu4VWtBKBGvsm3euy2Nq6mBVXeX9WS0SOFeWVerjuqWmy2wCrPjpnx9E7xTx8KtRVbZmvXmCrFCh6dZtUyG2M8fT6xeAUCNM0dQ8O/HOehO3mP127+xHFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723203364; c=relaxed/simple;
	bh=n4mpLws280hDngb4tNI814GEf1E+wWFxR4oy9OSsW8A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fGAmXJgX1G3o1ssqN3MuzC3/U282sHPLolQW7NwL3nfnYw+9gUlupeCuYTep2a+YOk/bq/+8VILrw+8lyoSVkZaAJFqrJ43Nw8xVGkoaa5OCiAU7rNHQcpNpxcZiBo7PalgNhK/6+gw+7IQZIL+tbJKELSU4PAnJRp82E1UdugE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39b3b585980so26042415ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 04:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723203362; x=1723808162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9wPCtQeAbSrsBJvFhHjEjUiZujlSd3I5GE3r2EoOEM=;
        b=VMpxrDrMtDN6MizgV44y0X3/GB0KpYdDD8z/kt3sGYBtmcD40FrpbVcmHORX/p0c50
         AzMiu0H3ezUfyY62dE0cHNZ75OEnurLk+u4o+2HC2eCCxcus1vjwEQRI0vvpDvZjtlgW
         BjCQCwWhgmy1DL2eHzpQbOHcbptya0lk/DRm/I2V9WSrVQHgH7LckSjISZ517P0WZoCk
         a8goO6NVs+XC8xLBOA2417W2oT0rGRmgnt13xEgi5hDJKmi7J/CGS7fcABLT248RrMqP
         XG/eAMgzOUdhTjIHI/wBuqBtmnEJ9WoAtdcNMxtD/CopeaiLSpHMiFGNDJFv//KSC3qA
         1whA==
X-Forwarded-Encrypted: i=1; AJvYcCULgd+5AsGVq9CDpub4pr17ZhOyuqlp321RGzTgzwAGt6kAicO/Rvghwsf2D1C1kuAt3tlaS6B6gMpBmscwkON8LJ7XgKKa0I3+gpU1
X-Gm-Message-State: AOJu0YwzxkInhKRgQLzfWxcHMowJ7Ow6APONQILuagmibSrOyC0Uh5SH
	Wx4SU6YjfWkq4U/oM3q+3YrAkd9zcKBK88qdXXxZH0SQPmTAjkvJ23tCh5pzCd24VGlHhYKZqNT
	sksZA0xsAHTbmfpXPyhnUZFLiZ1G4DuoQ4gpcN0R5E16ScFTouQBF4zI=
X-Google-Smtp-Source: AGHT+IEqb02OAPbmz3Yd8kPUtWJVmrFvqhcpC86RVeYSS74SqzN1pTmwCs99RoZzxDs2Iu5g5WchnaHMciBW2KF7Wtj2W4B+1aBz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18ce:b0:39a:ea7d:2a9a with SMTP id
 e9e14a558f8ab-39b8709167fmr942895ab.6.1723203361747; Fri, 09 Aug 2024
 04:36:01 -0700 (PDT)
Date: Fri, 09 Aug 2024 04:36:01 -0700
In-Reply-To: <tencent_91612968A3A2A44D176F377926C453710305@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040c6ea061f3e8cb3@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/netfs/write_issue.c:531:53: error: 'wret' undeclared (first use in this function); did you mean 'wreq'?


Tested on:

commit:         c0ecd638 Merge tag 'pci-v6.11-fixes-1' of git://git.ke..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=163928ed980000



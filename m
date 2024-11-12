Return-Path: <linux-kernel+bounces-405161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBED9C4DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 05:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D644628485B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 04:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741062076D7;
	Tue, 12 Nov 2024 04:19:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA28316CD29
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 04:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731385148; cv=none; b=h/1LFS2orZX4hPCs8uBdu+zd3YryhU57KFuvPzedVW4XYfLX6GsgfwIo+5eMzrbpqSTVSfzvxje4UjYqMQ+WLeF9OmnzJlfSJIQbR5OUOj3fsKaM8fb9fjq4Bbzvoow1rzGHIx5Ynge6dycq+m/FIcnmTbaCrzdFgqglpQwXSRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731385148; c=relaxed/simple;
	bh=qcNGZb0zcfdyAR6WX7WjkGuX/xaJTtHsYCAqaxz88nQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z+SWvWHJ3jO2PFfnIt5AjnpV0qiKcw0znfCnMZh6mfkY82bMjjUOivD42eRaPKZGro++y5VP7gawSn6CG8bgc+yOZ4pPFg6qVyAHUdp6PMRkMwx1x/xty6+ZtR+2yBMHn7i+eSnEkf8c3y6xBHr/nGGayqu9p62ID74ke7/cX30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a4f2698c76so63132505ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 20:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731385145; x=1731989945;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nSHO4aEXz44u7koCxYpwnPCzcEcn/6W5q76jYKRolGc=;
        b=uADD7fmumLisaORvn9WTpJ0d8wnZS76aNKamcvok26PwCJvcJfAfnk0/3t52i+gjDO
         XMD3VFoydYZsZfhp34KwSo4nuygNJt7PNkXAUV3NEUrwDF9TW19V0B3+5z+tMBOXTtOD
         OkqXCS7oAkgdKhvpeM4DDa5YErNkwBbCGeW3PquFCbHHb1CwqANf41Sazt5IW4OV4mBR
         WvXkLbzeqDtAU4mk6PpUV0dGspyd3cqc3GzoPHxYZ7HLTOiSoRo2FVBeuR4cGzJtPymd
         G8ql9GYmpB8EAFeaZzJBeASka8e9S5tQixppfz9RlDB3cVTcIUAsJcoUpT7fBb53PxQ8
         hAsg==
X-Forwarded-Encrypted: i=1; AJvYcCUZahvsEngtWPSHrvePPfSOQ5xDU4DqTfxDGPJnWtwfQGHVKO7uv0hgGbe1I5nSQq915YIXrp9zJj6uNAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPK2ganDNB4Gyom0jYcpVcCHTV3ICZliDNTGVKZGgNtW02FwOD
	FU9GjShFCUkBLFgUqnSUNzZf7rP8VAwg5DXlcjkOKcB+2xAVL6eI1FBQPJtAsxwlAtTCvdvQd1y
	tmiVglYYaDP1Wf02cEYPG0PIzjsbs8jNNSVjAfYWA+jCaRH4hNsnSouM=
X-Google-Smtp-Source: AGHT+IFAX/wmaf+N4MZ9JDibyywnq4xw0pai+Z24GA9zOHxPX/SM8JOCbsG+9w/UZah9s2JSg4KsZtUAgHoDSKCFAfDUdhi3US7C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1685:b0:3a0:98b2:8f3b with SMTP id
 e9e14a558f8ab-3a6f19ebd22mr171526385ab.7.1731385145664; Mon, 11 Nov 2024
 20:19:05 -0800 (PST)
Date: Mon, 11 Nov 2024 20:19:05 -0800
In-Reply-To: <cdcb0458-9e94-44c6-9864-ce6de521b32c@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6732d739.050a0220.138bd5.00d0.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_copygc
From: syzbot <syzbot+8689d10f1894eedf774d@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8689d10f1894eedf774d@syzkaller.appspotmail.com
Tested-by: syzbot+8689d10f1894eedf774d@syzkaller.appspotmail.com

Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1733b8c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcca673786a14715
dashboard link: https://syzkaller.appspot.com/bug?extid=8689d10f1894eedf774d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11ae74e8580000

Note: testing is done by a robot and is best-effort only.


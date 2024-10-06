Return-Path: <linux-kernel+bounces-352486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0571991FE6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BAD280C76
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 17:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15C7189BBE;
	Sun,  6 Oct 2024 17:26:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB23231C8F
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 17:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728235565; cv=none; b=aCx88pSIq+Hv8Qwj/gghwZ5m7vlurKKDjzU+Ygjoy6FkCDFg1nYmMJMYCR/s8zzvjBEzWf3DAa4TbNsZFwatAauN5HWJBOi3K8iFdITvjU0+uIAGpMyNFw2G1Y5rm9Y7ZE+xu8LX2s/BDyFdlmR61JQJYFCJgE3cCVAyyrcXzBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728235565; c=relaxed/simple;
	bh=SSsfk3KhRZ4wR0/v6q9eKpiXGUKTImwsyf9gBgAGmCA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=b+E9gDIC6iqeB5NRvIPR2TXwLCGNE4iibInYwPCKqi0aXmQ0PSW58n61aGYQjj/Kika0O3BGdrItwvEg6J4AxJgiBBmMTgKn/cUNXxfqOixoNjQWpUG+wqZk7IUTBTWxVK4c3O+PqDxGb7L4FqrG/5I5dsoMtl0ZyXfRIMwxA9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3453139c0so53519965ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 10:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728235563; x=1728840363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ay44yW1ZI97Hrhmn2FCLpUqokOS1oswD59si82KqLbU=;
        b=gJowqUwlEYCp6Jo2VPt9axGVyLWQDgHM8OLXt3uPSD1H0/cpVWxlJ6hjilfbbt7w0L
         1a2qX8pKuSBJJcDFVmcgepTyxhrMS8+KZ0/WHIID78o0VjGfcyeiK3hu713aAV49A8+C
         EHT4HTR1TFSibKX0SKrDePss2+FjD78ARXywDhV7BKYRTkkUCQUo5hOT5gf8Vv6e0+qG
         PwEVDDD3GBBvgwg6uM+eYw/jWZmOJdV8G1LE37MoMgSQDRosYcMfa9369zGkzwZb8DUk
         9BV1v9mNOm4Es9Hq9C0u8gO9eC6vGRo0zqBa759YaGijwQ+XkRWEjgFX/032E/lW41fF
         zMzg==
X-Forwarded-Encrypted: i=1; AJvYcCXxWcI78lPFbrUmXY7HWCVxoGj87WfrwQ5+evf8VuiBYoQNFxF8fo8OKdm7sPZ5a3wO5DeIoXeakvmYovQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbi8pVKWAWFyE0UFcsldz/XGWez6NQGQGkmtGtgbikGBkjv/wb
	oCqDbMgKsFW95xp3Fo3l5YfjFU+U1gAuuyB/FPHYkBpa/nXPsj0HvobO/RRYXAmMM43IWyqrFfq
	HMyPwuKFBixqFXN2xpI5qMVl4lQvYhBxhRtDhUH/fPUDdoWI+Uggz4tQ=
X-Google-Smtp-Source: AGHT+IGjcpEOA7E9HLup4ZcbDqU4uOkGT/4pexcaiSRPXAMYvJ0AtqO5qSltOZAG4fUbTDtVrxgM5kwcFZ8A2AF1Z7JgvHsBOeuU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1846:b0:39d:2939:3076 with SMTP id
 e9e14a558f8ab-3a375bd2038mr82099585ab.25.1728235563401; Sun, 06 Oct 2024
 10:26:03 -0700 (PDT)
Date: Sun, 06 Oct 2024 10:26:03 -0700
In-Reply-To: <ZwLA_mQtFM-hTGxD@iZbp1asjb3cy8ks0srf007Z>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6702c82b.050a0220.49194.04da.GAE@google.com>
Subject: Re: [syzbot] [usb?] KMSAN: uninit-value in bcmp (3)
From: syzbot <syzbot+0399100e525dd9696764@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, qianqiang.liu@163.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0399100e525dd9696764@syzkaller.appspotmail.com
Tested-by: syzbot+0399100e525dd9696764@syzkaller.appspotmail.com

Tested on:

commit:         8f602276 Merge tag 'bcachefs-2024-10-05' of git://evil..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116cf307980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d302f14701986aa0
dashboard link: https://syzkaller.appspot.com/bug?extid=0399100e525dd9696764
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=122af380580000

Note: testing is done by a robot and is best-effort only.


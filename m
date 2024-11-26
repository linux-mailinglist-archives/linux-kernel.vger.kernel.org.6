Return-Path: <linux-kernel+bounces-422709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7839D9D42
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF7E1636E9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421E91DD884;
	Tue, 26 Nov 2024 18:21:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4A2BA3F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732645265; cv=none; b=PlbZKz58XdbSqBqCiMebaVDbYnXPBsT17MNgjjvnwmeavinSLL7cDVZOkL2zM2GsLeWqhRw93riwy3bMbcSD5hbIz/FvL0zqgq+20bYdbnT+EDcByY1Sij/NASxMaxtjlcaZIDHSQpklAAyRgxOTj+Yo7j60u7XoQUsJpy3cB9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732645265; c=relaxed/simple;
	bh=F51TgaLk9uQj6zjDSSBkBm6w5S/n7KdJOxvEpnNIol8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mk9EDPrhJtSUw+ku4Go7napiYIy68Im0qtFrjbUGBzStL4qw1jeIfg54mBjTZVsliO5je+CUY0KJzlFoBV6oK56E2N6xHhghsWTGWKsVY+W425+7n4lyfk7v9QzRjG2OgKwzU2eAs0mxwYkHmPXz0anB93ZSUrNoTe4LPUzQdbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a743d76ed9so364625ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732645263; x=1733250063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qoOBTuXmZMONzSpeUHAe5nMhij4O/OjASPmXiAfcFJ0=;
        b=bRMw0H7sHXmaYc+sGImXfZlFn8qatspf6FvBllTiAVTZCXB3BZBEitERsPqVBp6f2H
         nC9yNzbSDfFx+E/bmBlLwyjh3HLkhkO3ATuPZkzTNIJ6b5McbpF9GNKevSRtwYhfQzYy
         CzXcxBrVkq67Y0C4w2U/KIJr2R9Oq1yESh+KJlDM8JsYTA+PWlRy8r37MXnUwM0AXwag
         CD5JSx4Eze0sxKto8e1cU1pMyysG6IH2cjC3Huu4wrXMJfIxaMzpwketJBQHpzTut6C6
         6zW2fvyC0VnS/RMTq9eEPimBUiIS1Ma07W2nlQKaHD3DytX9RPeuFU0ce1wT8aIJyYCF
         a56Q==
X-Forwarded-Encrypted: i=1; AJvYcCXn7Hc2FxVThuDcxpXfHHz7xXu4jH/+lRZDkkLaPeK5HI72eYBqPuB1avxpjJlRN65BnZLvtRFR3WcDnD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0CXRWIE8Jqh8F4Aa5CwtX+4RbWGT6jguZNlgV0nEQfz+dyq81
	RVFsTHkDMkwSHNY4IxAVOBc/MpJSe7qnTKcXMN63ypvpIEGDlTJ6kjj8sgMkBBmD2iau1yGZt+c
	rRMrgmIrwPWYbNMjEyIeQnF7wOUcItNgEGjUDA9wf/eNAznspElQqjm4=
X-Google-Smtp-Source: AGHT+IHr6y+DblGQxKReJZn1KE5Jw+j2+buY/3AUa/LxGVAj+eCSoMZ3vbMBxMwGDLazwUo8ZaHvFCD/unJNQDa9ElLxKRsPw7/x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168b:b0:3a7:abdb:4a37 with SMTP id
 e9e14a558f8ab-3a7c523e8acmr1911585ab.8.1732645263694; Tue, 26 Nov 2024
 10:21:03 -0800 (PST)
Date: Tue, 26 Nov 2024 10:21:03 -0800
In-Reply-To: <20241126172834.78149-1-leocstone@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6746118f.050a0220.21d33d.001d.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] WARNING in f2fs_rename2
From: syzbot <syzbot+82064afd8bd59070fc22@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, leocstone@gmail.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yuchao0@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+82064afd8bd59070fc22@syzkaller.appspotmail.com
Tested-by: syzbot+82064afd8bd59070fc22@syzkaller.appspotmail.com

Tested on:

commit:         7eef7e30 Merge tag 'for-6.13/dm-changes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=172a0dc0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5a5b40f7e7e7d63
dashboard link: https://syzkaller.appspot.com/bug?extid=82064afd8bd59070fc22
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14279530580000

Note: testing is done by a robot and is best-effort only.


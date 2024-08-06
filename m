Return-Path: <linux-kernel+bounces-276308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C488A9491ED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FED32848D1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5867220012D;
	Tue,  6 Aug 2024 13:45:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4951E7A5D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951906; cv=none; b=Vs3Ycp1tV2lzJhMT4e08SWXUdVUY3oGTQGNvVE0yMGZpgQsBvfRV79mxfKmSZqpTWsNWAHkDyVLh8V4j+HJYLQQsiOnfMMgKmUrNUtOwNe51Jj64zbW+EXb1xcsWvzkYlEAalUNj7TrisonRvGKTPAVR6QTgzN5KZA7b8k9GfVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951906; c=relaxed/simple;
	bh=WhsHPapohe8fxE1+nP8d0FtQB6wjdpIhrC8t6EB5Tg4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WciTF+7NbUcpwsmmqjB11YVVA+i3CO4N5YGRVuWYv5sFzrhgbzEMrvYabOv4UD2sXOCdDPChT9pN7C7hkV9E9B1C/ilworwy3LcZkMcTaOd137svV/JYgp1HjIXcG9ZdEGAlggZpqem/O7jpelbxqLWQTP13Ue3tcmn+9D1Rhko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f93601444so65660639f.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 06:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722951905; x=1723556705;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJeuvAgk4m7VZs20WVV3hy6Trjd+HkFqABOuVy/VdCk=;
        b=LzVpC/+qK1gPP9YZPNAMb/vbVfuSufcPgRdh8ILhFLSDBiWY3y9eNliXMMyoPxX0Zv
         4b6Mmi2xclIWBMIyTeZJEUGLs5dNyFxUJFDSyJbgIi1gNXNHR8Wn7pu+qgz1i/kK5Pk9
         9Vdrj+WivuLIK4Ks90FIPvNuZZ0s9C6f85Ay16PWqVOkI3T0iJPcZPPEHmmIkBEgYjKU
         Z90dRBpSz5SEZU1F0qBWr0keteUfVGmWlKEKaYEsHBVnT8wIGXfjyPgvrQfGs0lBnpl5
         9SYZITRjrAcoAnR00TMopDt1gomQAQ1yyfcMms+JZOmUVKOLoJImoxpNRRIvY34UE/JU
         R5OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBDlxCDhh13tVrt3i0ddf2hFThE/qrwbn+DFGyPl+Dtq3wlHdGPaJq5zxwPzhgAMGKEAan1nU8fPPMCAbKrbJczlNvIwp4/Jl6l3EZ
X-Gm-Message-State: AOJu0YxJnjPPB6RUvIyL+04V6+cWre8mjYQ5kIWs/vhJT1mnfXkNAa81
	D2tkdZStFQtJvZWdebJrt+q6SqhEvKJWAGmYWB6zJUGADAINm22B8q1b33LGsGZfsOL/cEPksKA
	paSCQSWc2+fqt5lCQW7BjOHjI8kVdCvrcGNsRWshES/1435srJZGKnt4=
X-Google-Smtp-Source: AGHT+IG5bw77eaLxAbUJaJ46F9uGFu8xPeFOiIUqo7KqaAAjd0o3KJc+KO3Wb2Dqe/1QcEs4zDdZx6rHQHNWvD1Aq/mCvXHCHeHX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:140c:b0:80f:81f5:b469 with SMTP id
 ca18e2360f4ac-81fd4398dcdmr52989839f.2.1722951904695; Tue, 06 Aug 2024
 06:45:04 -0700 (PDT)
Date: Tue, 06 Aug 2024 06:45:04 -0700
In-Reply-To: <CAJwTMzrpwrceFoNxKT2jPbGuo3L6cBZi3BCCqN=V285AOoBmAA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ea478061f040075@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING in __hci_cmd_sync_sk
From: syzbot <syzbot+f52b6db1fe57bfb08d49@syzkaller.appspotmail.com>
To: djahchankoike@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/bluetooth/hci_core.c
patch: **** unexpected end of file in patch



Tested on:

commit:         b446a2da Merge tag 'linux_kselftest-fixes-6.11-rc3' of..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3456bae478301dc8
dashboard link: https://syzkaller.appspot.com/bug?extid=f52b6db1fe57bfb08d49
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17b4c0f5980000



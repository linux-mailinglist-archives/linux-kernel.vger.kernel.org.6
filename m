Return-Path: <linux-kernel+bounces-359149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608B4998812
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6352128A2FD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02DA1C9ED8;
	Thu, 10 Oct 2024 13:43:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6111BC9EE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567784; cv=none; b=gyk1KaJeiLnq0FqQU/qF/mU70Dj22Zo/gYLkqSBYa/7JeJIzmbDdPiBo1TeXS+vT4J/c04Ic+xgJzcvJcnM5czzzq0t8dysh0K8x7MUvH2Zl/6FVY9W52eN33qf6zQUjy/WqsWLJAXoQ/WGMLI2ieoEEexNjk+ad0tgJKBJvd8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567784; c=relaxed/simple;
	bh=matAoRRczKjmdHRDFgAd/rJLuJmBQWseJ8jDWVt3lyo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PPJOMRzsAks2LfaQyUEOZizOoTDQQkPlpxuhTKgQQvNd30VVIKdmCGRV2J3WKvYINT1g4RlKTpTwITocD+26nGqv+QghfpOnNOlhVRLL+6+8Ki6Yh5DBV78HH2Nx4gUt5bqfYmnIyb/kcYsZxMYxhBXRge8R8zfTTb9jqIIZ7Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a1a8b992d3so15082585ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728567782; x=1729172582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d6fl9OhPHmkQcFsww0ufCfVrTWXRfXqIp6y5hFDc+hg=;
        b=Gjhcd24P44m1FBg+yDQ6FTNsPv6MBSyLzIo4rymLe+wO77WkEBiuCRuwqELGEB9cXH
         QU8rtyqKxF8p9AvSyWSmTKQgd0GrpIF7BvpmHtkqWVB1ouCPgScYWAMDeAoifMKA/HNd
         A9wiJ1gjYx263FP286DTBJpMlt6ezW1d6TDMb1nKy46k9cGQJ+fbWvTNJh2jYGpdiL6a
         +vuAKYCPbMSIwt08hdMAOSC6+fJERn/wkikdBOmu991WOqmV1mXDl4DvP7uKHrNcds6P
         3KLjYAjy44FmuT2xu+eb5in4OLZciJTwdUWkofQ4hEgZynzqu/wXtf22HOqGbVeIIVr4
         KbFg==
X-Forwarded-Encrypted: i=1; AJvYcCW4ZqF+Rsr66OQEnfZaoGLSYgErDPXUiq+IXsQfsrlDiMJv8hJRGj5hWStdB3CKfM56QJbKXXiMpLAw/uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrhKbM/wmPjvITcdVNugT6yoesbVXhlJN3aS5wx0RA5vEwTQzg
	18NUBoC/kL4FFPbsms7p1KnEkGykJyMmdWTkYjZYRW9AUlXZ3UD/WQeqT3tvMTveGwKWi3xEsCZ
	VwjVP56GN+u2Fnh3uWo0miBA7eh5RAr8XZ52nJUA46cacyQ3q45thkC0=
X-Google-Smtp-Source: AGHT+IFuxMVL5cVrdI8KggZ5km8DScjiyojBIBB1nh+QYmrtsKH3slggdGgQjLq6y/o+k3KYDaV+XVP7QJy2bokWU/kj4lNAK0VF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca47:0:b0:395:e85e:f2fa with SMTP id
 e9e14a558f8ab-3a3a70a3d4emr24604315ab.1.1728567782256; Thu, 10 Oct 2024
 06:43:02 -0700 (PDT)
Date: Thu, 10 Oct 2024 06:43:02 -0700
In-Reply-To: <CAG-Bmoc95jEr_WDNmqyCDb=CPOE2+-5MytXiNR-uy87jXbWD2g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6707d9e6.050a0220.64b99.0019.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dtInsertEntry
From: syzbot <syzbot+5f7f0caf9979e9d09ff8@syzkaller.appspotmail.com>
To: ghanshyam1898@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5f7f0caf9979e9d09ff8@syzkaller.appspotmail.com
Tested-by: syzbot+5f7f0caf9979e9d09ff8@syzkaller.appspotmail.com

Tested on:

commit:         d3d15566 Merge tag 'mm-hotfixes-stable-2024-10-09-15-4..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1126cb27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
dashboard link: https://syzkaller.appspot.com/bug?extid=5f7f0caf9979e9d09ff8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=109a18bb980000

Note: testing is done by a robot and is best-effort only.


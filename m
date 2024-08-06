Return-Path: <linux-kernel+bounces-276370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41F2949297
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D531C21538
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5533617AE15;
	Tue,  6 Aug 2024 14:04:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA617AE0F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722953044; cv=none; b=l6R5to3KFjYRC7UjdDMtaPO7ynVrOhXrj5b4KNFAzN/C+ja8x1QuJNkPfBr5uCMRVk777M18Dyzok1X5n/OG1FMfFO+76eE+a7nsXCdcn+BDOvRwsxbXRbwW3senSnVhee85GQ9ZamClE54azQdqJWZBH6H6TAxfxdvsFlp1Ruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722953044; c=relaxed/simple;
	bh=/Ps1cxFDJDwB93ivToRFAhgNvNA6mzRCGx4Zywz3Bs4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CVuNPacNfH5Gk7u3PpWvMjsnDP3nL5Qz/UHL1gzZ/6SggDac/2AUuAE1sqFoWsV/1emykVbTIlG8yOtvu8/tabB+PfzRuKvTiEs3ja6sZvCRJjn1OikqLoc608lMNVVdlZkqrWtY1cjL3fTyi6T4ojvq5DodIMur/2B6ZKHAZAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81fa58fbeceso95832239f.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 07:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722953042; x=1723557842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JeTs+9g2FcNzCE+7zPc016IgJBgubaoWAC+L6LQS3yM=;
        b=X6y0+8PEQtKYq+acCQbxD3W7F2cizzUie9XMW0z4gI7SgCawihmti8dkO27u7aNWV7
         1NUoaH2w1Lu1I6zYklNmGTZ1leF01OvQ206aE2wNMLQK9Jg701pFhhqj33qNCkDpn98N
         6IyCTcBClhr+XWDSoB71Nm969x2wvzjmj2q2SJiEW4kcuyBynrhAqsENj5wlzilgXUvW
         FvhQzISSC6ZCg4ywz8P3P5EAy22iC3H4G4L8+/PxgjTAUry2ZWRZFLNB8BLBy96NKsyk
         2raZEzOFD1wOXuoDvMTtdtkWPPAFoWeRYEIKF2/bnBg6zlkb7fCyMHzuC4vxPDrF+wpU
         yomw==
X-Forwarded-Encrypted: i=1; AJvYcCXPvJSGJh4MONcn6i8OxKoCwCLQzFWHCvoAbxm+qi5o+oSY+WQxk9u18wqmCYFlkar7TZwjxMuMOq9Hau6DxTakn8N3oLvyOR9xFmwj
X-Gm-Message-State: AOJu0YztU+Ye+0RHPI3OgacOB1oA7MXXMpoUtaExNiVLZoqbshv8cB1X
	bNoiW32N7shsuNLR2aEne0G4m+yzhtpdVV1uyCRuQIydAlb2Ojq7vFvuOAXZstOnOuVBthdc4LF
	Y5ooFLFiR7Xu1mCXhbbWLBIM/zBRrBVdOcc6n1W1rnlnickyH7RSKNrM=
X-Google-Smtp-Source: AGHT+IGhiHVkBdM2WIkouN7z++Oqwp+PXOXRQCC1KN8QQAJb5sFHHyKrxXUXN9KThs43h0tOd4JbcynXQOP7G8gh3p/PPLZsM3a/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2392:b0:4b9:13c9:b0fb with SMTP id
 8926c6da1cb9f-4c8d571dcd5mr303373173.5.1722953042372; Tue, 06 Aug 2024
 07:04:02 -0700 (PDT)
Date: Tue, 06 Aug 2024 07:04:02 -0700
In-Reply-To: <tencent_71042D016F7497B0E81EEE1ECD607A9E6D0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e3d7e061f0444b7@google.com>
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_session_put
From: syzbot <syzbot+ad601904231505ad6617@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
Tested-by: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com

Tested on:

commit:         743ff021 ethtool: Don't check for NULL info in prepare..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16ad9c8d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
dashboard link: https://syzkaller.appspot.com/bug?extid=ad601904231505ad6617
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11a0d48d980000

Note: testing is done by a robot and is best-effort only.


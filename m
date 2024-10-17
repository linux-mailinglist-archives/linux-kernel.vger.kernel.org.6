Return-Path: <linux-kernel+bounces-369100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0899D9A18E5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 04:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1459280E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFA8770FE;
	Thu, 17 Oct 2024 02:57:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8284D9FB
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729133827; cv=none; b=uCmpjdedT0WODOWHiTLe1NqrqXpn25QiZVUHQLcgrrvlUKSz+J0NxZl28DE7BcGxLU2JdGlzwEBmKqTgi/eC3o3XQn75qyneoAHw5ovbDmmNjNNHYXx4uxDv9uHk15PmfAXe+2ljyG4zWA2L2SeCRpSuO8BPujVpLHoH5cejN7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729133827; c=relaxed/simple;
	bh=Nd67Jp00RXLPiVdexnjEKooKYzGEtzYZb/4vilnk2BU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qvNH+DVhvEAQC7LkAXV/EVRipq25XWpb0pZQkQgh6ChdLPJmuh/b6ZfSnDGfjAhIg8KHX9544Ijy79+rvMSK/PmGI2/KAq9lyxbbLTjvXDmqMSvIcOTXtCbJHJFylrkbLJqnlYspAgjU3wg68QiJV1vvuAYwByothYNjH1Ct/tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c72d4ac4so5440015ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 19:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729133824; x=1729738624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxWeyhD4DCS8Tj5utd6tQ7ogo4K7gLVG21FBXYaqDKM=;
        b=AlybJAlKKl+gw+8QuS2XrSbdGuwc7wWiOFilTNK/FalXDdc66mUBos25zoSpWiiws+
         KB+tiIItHjcF+XTLl60rAfSLQHsTuI2CNWRx1MnmxqrL40XY+xTwc9reZe7PxxBbSgQU
         iyvWDiQF3kgPVJ7j9tVNZisuOLsV4MpmBikZ325gWmEQILsGtNuIb2hKECIxa3SUBZUZ
         BlzCOL+EcRWfvE2Gmi+RyDrSJLYSebmeMlwaN7KuFxk9S492y3tlt/u3qQxrzZafpjPf
         GWtBg1kVthpcZQ24JldVsKWEvJBwdHnRU5xbq0MOil3sOQH28SCyZwWTrddqeGRWbrfm
         ftfw==
X-Forwarded-Encrypted: i=1; AJvYcCVkxZGWMB7xZNEnoqekXHguTrENGAEwgWTdYtXqw8npKOAzo1IwyGPCCg9eL3OpqkQuHaT+iSFNfcL9/TU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlRp3uVWIZ3im1m10+y5qDpKaEtG+rO5hLrZPxRv42ms7Cshjx
	hs6GaJRB/R+wIA8JAHLj/gxXdR4ihtEBr2WUgM2G519lzVO3NbfTOmJ4BFP7vSV6YPxWZXq6e65
	sRRQ6Ap8lXc4yZlRIFrSij/M2InZYc/4MUmjGsoSuwbq/Lcc62Ou1fr8=
X-Google-Smtp-Source: AGHT+IFMb6oj4p4WyOWBYvx2fxkNdWCnvHQYiKx/4cURjtylfxV05F5ONegNfJQPldnmZEcJqAcWZJ90nGID9vMq0uRO0p5rk/5z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188e:b0:3a3:9461:66a4 with SMTP id
 e9e14a558f8ab-3a3b5f596ccmr191029495ab.10.1729133823937; Wed, 16 Oct 2024
 19:57:03 -0700 (PDT)
Date: Wed, 16 Oct 2024 19:57:03 -0700
In-Reply-To: <PUZPR04MB631653574B414EF831C1FEDC81472@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67107cff.050a0220.d5849.001d.GAE@google.com>
Subject: Re: [syzbot] [exfat?] KMSAN: uninit-value in __exfat_get_dentry_set
From: syzbot <syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com
Tested-by: syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com

Tested on:

commit:         c964ced7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c43030580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5242e0e980477c72
dashboard link: https://syzkaller.appspot.com/bug?extid=01218003be74b5e1213a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1738345f980000

Note: testing is done by a robot and is best-effort only.


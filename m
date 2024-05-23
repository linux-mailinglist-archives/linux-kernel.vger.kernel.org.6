Return-Path: <linux-kernel+bounces-187280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C12B8CCF65
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7891C221B7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3181313D2B1;
	Thu, 23 May 2024 09:36:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B0E13D260
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456966; cv=none; b=CoKRxOrMQxwP2T5m7uzUl3x5AQtHiwn4ktN+bwwyOJRFIqX1R2tmu5cLb9Elkg3pycAI54enTfHqKz5/v4VC8+9KRmjEdrCcSgLK3GfiUszu17X6TlUHu2/lI/WG9ep38o7C1UZ2v8phjXPKUuytXWW/YGUU52WUyDUubErGL00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456966; c=relaxed/simple;
	bh=sAy9KDLJjy8l/XObHRC74k4b3Iv4z0NNrI1xYigUmaY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=P7R/YmapDWytfsYLGAh0NDcguGioR01GkQRCP2TbYgTxWZEA6xIcRD0tS9bZTRduyLuh+bh+ZPpH032QUSS2LhU3KvneW+3+KZnKrzM3Slpu6oF9FvLi5/sdhtRXxV/LlnTkVKAJACJpeTaLcJH8nMHr5w0BdjgcWo1mucG8fYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e1d3928fd4so136989339f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 02:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716456964; x=1717061764;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4LY/Fc5dxnacD2OPmHzoGAJ57Psli24OWbbcR8OaQAM=;
        b=YqY0gs2QziE+BoV4C4w4LlF+LTKdIejwPIL37GoWcG6eY0yRFn44ulGGTvLATKop5o
         ZqToJsWYrh5K93JLjnJRe0FKEsYZYM5QQaXsA+aKpljQJdfWm5Z13ZLVwpanodZE6H/i
         9UPiw4BbRFQt2tsIgZPAZSlzjS0G0sJheeXBYEEaVVmVBH/KZHP97UImycN06PDyzpYq
         SiYpdHGEiOV58oVb+Olvja1fEVTgM8zqOAN1t3N6GHiQ2S0PfeI9autYz3zRFmX0s6Gz
         Qe47q47aOJ9RUjjTHmBQiG6QPtnhb+a6tPOz1jiF3CbZKvBinodfUqUGLoVXXuwXNux+
         ZxYA==
X-Gm-Message-State: AOJu0Yywx5afxOQ49vlMXMQZn3SObogxZGFpbk6cwsLHS6SidQcOlHW9
	GoOnMwlfDp0mI3Z6ZLDRI68sIQdMYU1Gz2dnU9pyLYcM7T8sBxEifgJbPtHR4lmvr7dNlNRN/w5
	n0G+duy4psCUgkP6vse0Qvk8XHHB8QwaXM9Lm9uM8xlUFfnV/uywYSnY=
X-Google-Smtp-Source: AGHT+IHgIGSAdz150wvrhr2nFUpFCKPE/aMuNcytMdCuI6S7taRUJPsYciZkoG1jMWg1DoQEEJAlhfj7DMAsP48rjFOwVKXvqgiF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3424:b0:7d6:5f6:831b with SMTP id
 ca18e2360f4ac-7e36f131faemr11004339f.1.1716456964646; Thu, 23 May 2024
 02:36:04 -0700 (PDT)
Date: Thu, 23 May 2024 02:36:04 -0700
In-Reply-To: <20240523092352.1279292-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a679a106191bc722@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

/include/linux/build_bug.h:16:51: error: negative width in bit-field '<anonymous>'


Tested on:

commit:         33e02dc6 Merge tag 'sound-6.10-rc1' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=25544a2faf4bae65
dashboard link: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16f52fa2980000



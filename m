Return-Path: <linux-kernel+bounces-284057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB7294FC7C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14C91C22382
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836F41CD0C;
	Tue, 13 Aug 2024 03:58:14 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04161CA9E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723521494; cv=none; b=haWKAFmqhg23MQ1xhgcB3Pn4eppTOc0drmxYlHw4wWTfPfwEQ4ueL086GDIER/pn2UU3qI/CY5cUUMHh2sO/Q2DO5QeFJlfO44v80PXQZ2TBXCSXISxixgJgC8QqA5xoeuCjBjUNXcmkLWOO4fAC3kXr8SikHgnwxRcQiylQMXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723521494; c=relaxed/simple;
	bh=8Ha310UphzyfmkgPlaUXS6QujVXZAKMhvdvXv9HWmwo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T6PwY0Ubb4QpEMTkCUjjnhMsv52eA1wK7ujYGCFtmom1IrkFfDkbA/3uHaNYy1csp9omLxG5OmwRIr4kFOHtNLBl8rFORbS4oGzz/p4hdIpBu/YWJmXuJ+44FZ5nPiSg0dRHXiCg/AOGS8ZCw9g4DCUbzukpwdbUY1ZvFa+4Jyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82237159a6bso607117739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723521492; x=1724126292;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSrVKY5+NEsolaibjZnfGbaFXbQjnpT5Y7lESLekyP4=;
        b=cjaleDfecUv4ztxWnOclxIqmJnyW75BZTe4AysdD2Acy+tDZ67UWMrtDHIVPDeIU7w
         N1Krj0F8k9ZvaFc1zvOTeirc10TsLi5l2YMQW+cN51Avuh7dj9Xh/CiWW+Udt3Cy/uIK
         IiRR+1ca4m69mNRDcap3f0GLyuBYR3j5+j23ZZjE1HSSxDe8OPcXeFFt8b8JQIqreRdk
         /74OEayTnWiYe0Fj4WdyDjLsFxOYwB+/o9UNoptrGdnclZ93cqPuR24NYyMtx897zPgB
         O0FgL6PSIZWgdAfWWil/1rlD5PAEY4gmCQRNT+ybdtQhqcAr7CTYBl6kmN2zniUp502s
         XybA==
X-Forwarded-Encrypted: i=1; AJvYcCUNonx5+PqM+4AEw/zBfYZZ07EmdnrUnTb7yAtIFzk+dP7Otfgvf8uO1YsMgRQ7GxAZtthQZdPsgrynrRg7zFnqpOd6v3WoQX8SOb32
X-Gm-Message-State: AOJu0YyGnpNCkfWSM2OvwgovHKvNay4PW0rKF0SY/6tkyRV2ywYVM0l3
	N7hpz/xJWN1psXNsZrs1mrnnvetmLhySQAPw3lg6JVX++suEeo2IAln7oDMnoCPehB7RQJrJ3xG
	ofrKhsgsQXfPrRoY0uul9WoOxvpqfLr+HSUADHUuwCqTpN+lm0a/7yWk=
X-Google-Smtp-Source: AGHT+IFuj/w9JE867+xVtrOCKed1M7P/mHsFXktEiMLNF4V7OkmxSeZxKx82972hzpaaE0tLvDyJvkts/g9hxBxVn144KFMY91rv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8419:b0:4b9:ad94:2074 with SMTP id
 8926c6da1cb9f-4caa149b42amr75711173.3.1723521491773; Mon, 12 Aug 2024
 20:58:11 -0700 (PDT)
Date: Mon, 12 Aug 2024 20:58:11 -0700
In-Reply-To: <20240813032139.161994-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047bb8c061f889e4e@google.com>
Subject: Re: [syzbot] [net?] [s390?] general protection fault in smc_diag_dump_proto
From: syzbot <syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
Tested-by: syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com

Tested on:

commit:         d74da846 Merge tag 'platform-drivers-x86-v6.11-3' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c6fee5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=801d05d1ea4be1b8
dashboard link: https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1046fee5980000

Note: testing is done by a robot and is best-effort only.


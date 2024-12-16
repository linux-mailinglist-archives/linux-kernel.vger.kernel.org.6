Return-Path: <linux-kernel+bounces-446723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F309F2872
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 03:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD48A1642BE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 02:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5202CCC0;
	Mon, 16 Dec 2024 02:16:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF3BF9DD
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 02:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734315363; cv=none; b=aeXeqYmNUvrBXYBEyb2S0+mQKsX29g6SgyfLIGSvb/PihuuM1oFKTUpA9lSelUZk2Kaa0Jt3RyGvtbvTRAG/nE0nvvVGoLTFtlIlU4pwal8+ZKM8wi4w8NToxyOpmvJD/r6SdejY3K0UTkpY3Z+ASm6FL+Mu0JACkiwy+vu94q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734315363; c=relaxed/simple;
	bh=nIiz0t0zby5UXMzM5XD96zQfnoKlbyjIoLhhDIoQrc8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lmZ7pIfkW90DqgHQvNW54ShCtNeEm5B3epL8px2nzXCDtPoS/UF+dA/goldQdRbNMWj4q1BESjMAn5eTP2yJQ5cAta+WRoilFfWvrPjszJYeB/NcA807AYs1hg/usJwoYGUtodtbLPE8ZtH+wrR+zRhIEIr67w0CO+ffzk4cMwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a814406be9so67128415ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 18:16:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734315361; x=1734920161;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8vh6n0+uY/1ZKvN8yuesEQ9161vrIkUQqwYnqqU7jW4=;
        b=UrwtQYpVE8sTIab/zGz6gjd3MoXOJ+p7RARKGD+5cfo9+Mz/uabKUJQSgZl7Kp/sjc
         EmFk6Bvv48xzhBrxcteBli6VD2lJB+uK6QhGuXWC1K8s1Kdz4/mSJnQt+6IOrMkjmr3J
         VK/Db195zwdED608csm5w+69qc9c/DGYbnhRCsGXwLr/si3QPox7M4MxN/WuxorZFcVp
         sQIcsW2l2sFAQ1S8vuykK70j3rb7l+s0JQ3vcja+yJ3+e/hXTcu0Z0sHNsMdjKYkbaVl
         d6N9uGVQ4aJfjnCEVHkS//tBH+SmOXO6fE9vRkoWfvzhXBv4+Jj6w9YXPZFJz0SbweMN
         1j+g==
X-Gm-Message-State: AOJu0YwnAm/CWCMboehdbEd7A94FGsoWvzIU3ZXdgece1etnQQDWEkoL
	VEK0y0c3k7omGLODJzZ0nHfvz2DefcsvJ6WxaH0RKPAWc/DW9vifcxIe4nG3TRm6vh3B8wkVhDm
	HZ6n6G6TcbOH9FuMbfzZV6BmA29SRuVkGHD0eNRi289MV29OhZGjouuU=
X-Google-Smtp-Source: AGHT+IERH1QaKc/klSTnf/eZA2Xcf0KyLY3Z9Mrn5kmW3D3a0JWkDX66q3j7ESl2w1m4iFdJ5vI4giaERc8mLbTMMRD9IWGRcMRb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:23c4:b0:3a7:e86a:e803 with SMTP id
 e9e14a558f8ab-3afedc1a3cbmr128722295ab.8.1734315361785; Sun, 15 Dec 2024
 18:16:01 -0800 (PST)
Date: Sun, 15 Dec 2024 18:16:01 -0800
In-Reply-To: <20241216015627.2229310-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675f8d61.050a0220.37aaf.0110.GAE@google.com>
Subject: Re: [syzbot] [trace?] WARNING in bitmap_parse_user
From: syzbot <syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com
Tested-by: syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com

Tested on:

commit:         78d4f34e Linux 6.13-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1272d4f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9cac7e24ceea492
dashboard link: https://syzkaller.appspot.com/bug?extid=0aecfd34fb878546f3fd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11ef87e8580000

Note: testing is done by a robot and is best-effort only.


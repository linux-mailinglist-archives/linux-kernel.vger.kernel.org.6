Return-Path: <linux-kernel+bounces-319870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD731970341
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 18:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3348F283843
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 16:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835B8161902;
	Sat,  7 Sep 2024 16:57:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0BC15FCE7
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725728227; cv=none; b=Qrod5SMe5WSQwDQsjkjbKyKtmGpsK1iOde+DmCfZT4I03gxxMqG6FElZshmsyKmo4UoPrcvqosPwCN5mCSH2N3GWRB0dvYk+fnVvM5m04s5Na262aUqkCvWZbajoJSUTViiyG89K/G0UvT76uJM3NMa7ADz+gwhsRsuLa0mR61Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725728227; c=relaxed/simple;
	bh=ZtMU8w1tloWwxYw7AMQBvYsJJPEwFKU8fUMe+ZaWDOw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qm7RE6HC6ILXzpqb1le6s8LL47AMHwLm3GoMJ1Nk8WeH4o94cMmsKMw0NGFrmNoelriI0AqMANkMG5s2cNtI+iHvBAzu/zDKCL8c7ZXnFpuxMHqcXTM5/ShwwjHQKVUf50ZpaLXl/TWymJE5kgIZ4xH2TfIs8UmBS+g/Rk0m/Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0459a8a46so62518235ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 09:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725728225; x=1726333025;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqioQfI0jRHJ+2HyBzWQTOPsbbuKbvskWBDUXI7NhPA=;
        b=u/Bbr5auLXcJnmLCt0Az0rTobA3vbpOwC4guJMMMZwDZLXQ8PrqKRlmZ2kBAsUS4r9
         5X20eeiYovFfkC3MtEzCzxJHf2e0YJ5XsNnfhDvhZ3cC1mLrrHSQ77CaXnUXLa2/xlQT
         W7zB6Gh3whP6uUPQd7lK0DQaAFm2CkWEJDnuKz+rI8FCf6aDQrBtygIAxNqivhiKWeI7
         X3f02fZKJyrm1C6NZqfrPwlGk4Pc4ic7TF5WSzGrNEphfYHJcQ4om7+l5SPzR3Qa3Ulv
         XrOjVKdtKoYEfmX5gHo9/8JvTkHpdDuwkt2rE8qdA2ocUf8UyMH3SXtS9ZT7s34Zpiug
         oNkA==
X-Forwarded-Encrypted: i=1; AJvYcCVDnQG5RbhB/7ElbqYdWwPnqSR2JU/Feg+uMqerv4SU4iWYw+2CF7xH9yuvAN07i9GUsXLmF4F6eRb7KaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaVvkPATNpeY6F24GA34eRXalpNbN5MSeysjFa5VqQJRBVTdTp
	zHkrbGF/BpazwnMwYykpxgVwOcyLVeX2AUSfKs+xSGKiDb+XILX78g0tM5x3z0EuP+Mhy9NiKN3
	F+fPEgmldssu5JgYYQVAo9O3VAlVt5juYBKpsj5hRyHzaCJCmDONtdoM=
X-Google-Smtp-Source: AGHT+IF8SgqIXPoeZdJvxIHF/R0WhiGyZdPrZBifF5WpHod7Lg5TLFK+P/zj4no5/G7TG7yVMkfnczv8rs8e36L7Y2XEMzVhfdtl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ce:b0:3a0:4646:8a7d with SMTP id
 e9e14a558f8ab-3a04f10e30fmr2545425ab.5.1725728224995; Sat, 07 Sep 2024
 09:57:04 -0700 (PDT)
Date: Sat, 07 Sep 2024 09:57:04 -0700
In-Reply-To: <00000000000031c6c50610660f17@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4819606218a69a2@google.com>
Subject: Re: [syzbot] [net?] [s390?] possible deadlock in smc_release
From: syzbot <syzbot+621fd56ba002faba6392@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, aha310510@gmail.com, alibuda@linux.alibaba.com, 
	davem@davemloft.net, edumazet@google.com, guwen@linux.alibaba.com, 
	jaka@linux.ibm.com, johannes.berg@intel.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	nico.escande@gmail.com, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit b7d7f11a291830fdf69d3301075dd0fb347ced84
Author: Nicolas Escande <nico.escande@gmail.com>
Date:   Tue May 28 14:26:05 2024 +0000

    wifi: mac80211: mesh: Fix leak of mesh_preq_queue objects

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1536189f980000
start commit:   5f76499fb541 tsnep: Add link down PHY loopback support
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc36d99546fe9035
dashboard link: https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ad7bc3e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1461e9a7e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: wifi: mac80211: mesh: Fix leak of mesh_preq_queue objects

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


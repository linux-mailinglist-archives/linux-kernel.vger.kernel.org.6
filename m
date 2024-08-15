Return-Path: <linux-kernel+bounces-288254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5A19537F5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17928B24F62
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B961C1B3730;
	Thu, 15 Aug 2024 16:10:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D694A1714CF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723738205; cv=none; b=FlATH3DyBjgmtEuv2EaP57yJ0HYToNiBOAmBtEN4ZMDZeH7nu+HvschbMSdjoeNb5rF/Xd8PR4whc0mqsmW+/XxmDUFVE1pJ+pASfF54vdzRApKH1RTr8gfg2qojWNZ50D8nN6ujTIDunmG1vbckovQI3ppO50iyvqlXw6zQUp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723738205; c=relaxed/simple;
	bh=j2uYupfeKSgh0DfZRYYlMyC99HExdau3jIZqN4BrbAk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A1xM8khtX3sP3kwwlB32iDOVZrGMwAaZc96q8Mhl8cDATmc20fArKQKW2ZcNz7rxXs14ja5coams8Q6bJvx5cqZWVWzOldKlq+uGLlO6dYWxRXr4LHtDNIpxewOPo8eMVyuRXVL4QAGg06blBKztJoLOpAO84jXiw2y3zB6NLnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39a1f627b3dso12602085ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723738203; x=1724343003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+48SOAuLFWa3vOYJchc0yB8E8pO6GvAZqc/FFORHhSw=;
        b=k+uClnM/AKudKAxUSyECbXkJU79Isi9ZpjzGZRY6oNxQzSTlop7T6z0TeSbvIt7kGo
         t+0x4kGyyYM95m+g75s2KzPN9zvRXQzvVlpJEBAOaFIE6XFFHOPpeb/fBWYtxBS8NQ3I
         6ug4KezcGh72uyH8Rc/KuOj0UmQfT2RNBPTzO81zQhonXV/N9jvuJ0ARjFciJReoRMiC
         eIavy+L74rOfTkbl8IWQl1lWmnAU8/3BpyIIjvx62Dsy+ybrhywvbZNMDBRyR5+0iQcx
         djdchsTykhu2d4B1kj/RntMdoAPdj3kRYn+Q2fcbs2vAqmjqhKzkCxw25YknoaSJDKXA
         RAlg==
X-Forwarded-Encrypted: i=1; AJvYcCUlXRamM4/jijpiHWo6k8u4Z1LC/TQQ2SxrnMXNFY0nT6UatP92zOBEhInlLnqXTM+CY9kKk5lQgw+18CNASX5BwsrHen3CCEy+bpaI
X-Gm-Message-State: AOJu0YwZq4GU6Vs8TCS6F51kpt14Im9b3c0C/3n03poFojMabXZDIxeh
	XgmzEBBlEtn1q2M3S7tYt1eNZrtg09KZD1/HiGAuQ4AgrsC6Ne77nUNUkLM5+/6On6KgzLSdjQM
	A0Lo/6Hx5SL8viv15XNW49vvwwviizz6kWVRw/kNR0mAGc+Pv6NqOWgQ=
X-Google-Smtp-Source: AGHT+IFhijMKxOHvEmejfGCrN0UCTcPcB8Qp17m0Xsh3eQixZLpUkNfc3bISLAfaoqkI5L5Rer4110AXeccsAco0NPqCdduTR/JH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164c:b0:397:95c7:6f72 with SMTP id
 e9e14a558f8ab-39d26d95de3mr190845ab.6.1723738203044; Thu, 15 Aug 2024
 09:10:03 -0700 (PDT)
Date: Thu, 15 Aug 2024 09:10:03 -0700
In-Reply-To: <0000000000006923bb06178ce04a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004754de061fbb1356@google.com>
Subject: Re: [syzbot] [mm?] WARNING in hpage_collapse_scan_pmd (2)
From: syzbot <syzbot+5ea2845f44caa77f5543@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, borntraeger@linux.ibm.com, 
	david@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, 
	io-uring@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pbonzini@redhat.com, 
	peterx@redhat.com, shuah@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit c88033efe9a391e72ba6b5df4b01d6e628f4e734
Author: Peter Xu <peterx@redhat.com>
Date:   Mon Apr 22 13:33:11 2024 +0000

    mm/userfaultfd: reset ptes when close() for wr-protected ones

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12f2396b980000
start commit:   e67572cd2204 Linux 6.9-rc6
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3310e643b6ef5d69
dashboard link: https://syzkaller.appspot.com/bug?extid=5ea2845f44caa77f5543
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10874a40980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm/userfaultfd: reset ptes when close() for wr-protected ones

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


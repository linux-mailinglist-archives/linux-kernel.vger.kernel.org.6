Return-Path: <linux-kernel+bounces-320568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB442970C07
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 04:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D34128240A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 02:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DEC1A727A;
	Mon,  9 Sep 2024 02:47:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802501A705D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 02:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725850024; cv=none; b=euYHHSWF3kdR01I/VgNOMGmvt9JHu5YDlZrzUvZ1QgvcoraNEpJ3yojqebecL/GTeCQkoqS9T6WuK43+qlURxybT4F4FlK87OWQm9lpLRHTgNySSBsJHZkOg60bd66SnTCTLCKAxL84BMh84lllPNL+psM4O2tPqQmjqmCHlW4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725850024; c=relaxed/simple;
	bh=6Dcl5uQTWTnrcqamApQn+/k490Oc4eWnS/FLx5/9kio=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ukZFlFpl6Zt9qOnhdphgmwxeaCMzRtGcBJKxuKmpYedVtbfsbQMwS/qY+SwK26HEp6xINL+Tv0ub0bbwTngB1smvym9H+dtXEaTMDSgp52e42/OQNDJ/ciAwP+zUT8eMf0/dXsiVHD+MF1ec1ZYj/GbojvP3uIQkUIBZU4n9S0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a3ad86c74so813396839f.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 19:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725850022; x=1726454822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c733kRQBOFm8yrm+WXb/6cY5HGwkZ2YjBhAmz1YrOqs=;
        b=eFO5ECeFrHzPl0UxS5Sriig8KqA//K+YPF6TTvBCzrR2ps2OJ/aAPkdxQVBTAbCR9I
         V1aIZc3Cd2zy5WZCYcVy/DcHHCdg1d9ZvVz7MBwE6HvimxKYcCsWXNPcX+VAzcrH8dHo
         GEjW3mzsCLne+0iv8q6yBiuvqeDuawYDZrgg9W91qushUCZZMoVu8yST6XI4L+YyGufn
         QWf2LHsF90+F1p7GRdDyHVCNRwC8w1wiG7k/QaTNGl4/YunIkOKRdeipoSR3q4ygheDP
         S6pv/9N2CrmH2kaIfWNETjZH3xbyG5HAeGm7uufKG/2psvrVAQJDPCF8aiKTvcisptUs
         pgUw==
X-Forwarded-Encrypted: i=1; AJvYcCUHLQlb72duwVyAfVw/C7lBMKs33ZY3IHYjFotrwzNqLAwsYLPFXCp9wqqQyACej76+kqc/As7SMKGrJFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoGZ2XH+Xl0SlbTVyiUW5Mn0bKKcVWKA0aF7nXpCPxOdkrD3C5
	eAe8sxHVzg+DzB5oK+rbjG1qJjWghcTckeKPYCbzAvxH6qUJnZdMdO95d2Cb3gKHV3byjr1KMQj
	NqUgnruKQ2RLzmge6DKUlaFXgdKDeRthol1KXw3ks7LVeaRSOgMIz4Q8=
X-Google-Smtp-Source: AGHT+IHKhzQ8zZDWHdVyt2F1M3k/gEtYCjakknP+L7usaUIc47PwRUYqzbuC7MDerLaI5MErEzVHKFYRmir++9b7o6JdUfFqJNh7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d09:b0:82a:a693:2736 with SMTP id
 ca18e2360f4ac-82aa6932a67mr440350439f.9.1725850022681; Sun, 08 Sep 2024
 19:47:02 -0700 (PDT)
Date: Sun, 08 Sep 2024 19:47:02 -0700
In-Reply-To: <000000000000a2432a05eea26be6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089b3410621a6c54a@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in insert_state_fast
From: syzbot <syzbot+9ce4a36127ca92b59677@syzkaller.appspotmail.com>
To: clm@fb.com, djwong@kernel.org, dsterba@suse.com, fdmanana@suse.com, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit ed9b50a13edf442f5493603cc54f73bfc6eca1e9
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Wed Nov 29 18:10:31 2023 +0000

    btrfs: cache that we don't have security.capability set

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15514e00580000
start commit:   3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=29fd3392a08741ef
dashboard link: https://syzkaller.appspot.com/bug?extid=9ce4a36127ca92b59677
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12151d1ca80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e3d95ca80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: cache that we don't have security.capability set

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


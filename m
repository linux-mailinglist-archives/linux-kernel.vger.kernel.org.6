Return-Path: <linux-kernel+bounces-515795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE073A3692A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9611B189285A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F451C84D9;
	Fri, 14 Feb 2025 23:45:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EBD1FDA8B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 23:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739576704; cv=none; b=TZQ3rfYW5iRK3px7eHv9CZP0PI++H1wjo9Wp28auuyae8X8HZzKtreh29KQZX0i+Mg/jdB+6suNiQ0+cQtaM1F79SSdI1P4xOz/LXldctODmSUGlbQ5H/dK0sWZJ6zC7S1pXh5DF6ssx7WhM+ZwMrrcy8UYIInK5j2tOy/6HICk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739576704; c=relaxed/simple;
	bh=vM6H85OVLBa7BjeuJYB74bqffgQN78O6o6P/21fDMh8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XkvZGjbJm54rBmHnHVdNWb2j0O4b3H8hQS2lFB8IBgvtSt/iVPT1PeXZI+x+YxMyZg/DmeXzEKESCUh4WynR3OUpD57o5N5tq1/N7RMl/5ngQKDSsG98X4aY1YCEledhjO4gQyUzIdb+dleWSVQVjM1Kr3rOMls3I5+Xn3bselg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3cfba1ca53bso18115945ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739576702; x=1740181502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yMxngIg2JTVms49ljpbNhXGW8SV3qc9K4TvCl5Kb3o=;
        b=alsO6DeezHNe0NKgyFu2wazhMWSpiUttHttl+2nCRclJBuR2a7XrS7YnTSK53oM8EZ
         NngNmkbCnBDZKuBqwG9z1s6ePi41dXYL0A0mt1tGzSbcknhpzpKaS2QInzbjDJdq1WFy
         8ZUWKtH0AtKNzTVYoTu1Ftv0FA+uj0iTsYhqnGGoZRip6vSARQqCw74HbONqF7SL+cHV
         q+/dlBbvDYzAxxSVcoJSxbV4xISsE68HgiEIgAsA39Vn7bsxMRims7moxy8Vs1GYmh1r
         1BSMMmOKblJ5biDn4yyb9A4kUgM0c3QNoiZZyA67fhg9LvRbkNoxePDNhtlLYGAi9W/y
         Gfyg==
X-Forwarded-Encrypted: i=1; AJvYcCXmng8Iwr+py3Kzon6Tm54aFly4dknCJCC6YelgdAyv+ThIOt9vA+NezzQS8NsZpvL4Gaa0lmhi2Qov7Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb5k77ZkJCNznQnO39BIZXxWeAL75lCtbyeFfo0y0ufwFUN1n9
	ZslCNoVirloRCWc58Mku74BiE35ukIhnZ7Z9DlksmAbbmPsiO5JTff3Pz9hAYwW65WSzFEWdsA4
	HLeKEUiBbWgf6y5ce3QbR68foMk5KfCOxGPofYZqXGVuX+9uTVm7WTns=
X-Google-Smtp-Source: AGHT+IEK0ZGWzR4L4MhxblUm09RQOtCzOSWvOEr0Ph/sr7WYMYRVAG5gQmmnlJ6tZZ/C262JMxuxOLZOGntRQCBglNMem1seUhyV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2a:b0:3d1:9cee:3d24 with SMTP id
 e9e14a558f8ab-3d28090697dmr9412395ab.11.1739576702465; Fri, 14 Feb 2025
 15:45:02 -0800 (PST)
Date: Fri, 14 Feb 2025 15:45:02 -0800
In-Reply-To: <25D9A5BF-7108-455C-8A2E-B04A3A4DF5F2@nvidia.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67afd57e.050a0220.21dd3.005a.GAE@google.com>
Subject: Re: [syzbot] [mm?] general protection fault in shmem_mapping
From: syzbot <syzbot+012c6245eaea0e23f7f9@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hughd@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git@github.com:x-y-z/linux-1gb-thp.git/syzkaller_fix_20250114: failed to run ["git" "fetch" "--force" "21c4e043f63ee530c32221be8efae42773de1c65" "syzkaller_fix_20250114"]: exit status 128
Host key verification failed.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.



Tested on:

commit:         [unknown 
git tree:       git@github.com:x-y-z/linux-1gb-thp.git syzkaller_fix_20250114
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cd616b6e736ca7
dashboard link: https://syzkaller.appspot.com/bug?extid=012c6245eaea0e23f7f9
compiler:       

Note: no patches were applied.


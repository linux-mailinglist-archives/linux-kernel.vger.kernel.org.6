Return-Path: <linux-kernel+bounces-311480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EE89689B5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E91E284677
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A17113E02B;
	Mon,  2 Sep 2024 14:18:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568C319F139
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286684; cv=none; b=L+xXvImwM+LmyxLUOGpPJplm/3bEX8JxbEfoajXmbKISsZl+qvzTpwwGQixuoPXFxnOaA5sGsVQ7RVxk6iaQOaUnYJ0gu921D3mKAMfTSKS5kZlD4MGQr6rB6cUl+LIMYhRJQzLaY3jOroA8JaCZ3wIxsHocfFBeBdCK1CnKWWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286684; c=relaxed/simple;
	bh=YRg8NNmKJdVyya7PAJqmCYEfL4RCJXwVKTbgiaryzEg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IWmrgWXUjqQVfXoMu0Ml8R7fLdSvII48aPENuydUaYW1FzQ8RF32ys+VG/q0xmDdDa2Pv3Blw5GVe13FhFw2CuHF8E5eX26FCIGo2EPilRRK6jyKeGh7FrB764xLUJn3O1XoPuNKrpVJQVgM9ZykmQ7TA07/GnJ7InfYan7aQuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a246b5043so422228139f.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725286682; x=1725891482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQg3RywN/LV7REkc10nc9ziB+No7VlfGZF5p1IqB+Ao=;
        b=t3rPlEzq1yjkO4YyKGYpXu/rx1lu28fMr+UEbVKfCoJlWhhB0NpbKIuzvFjd+2i3Fj
         /f+2+e07Zbmz9bIiG6MUU2tPb0wdGDEzJArTG1gDLp1rk1o9wQhtiIgtoB/+uMiGwHxf
         CREHzItQ9KHRTOyFIEMzvpWApXale19w8jG1RwcXXjqA6YNpc7d7CutJMEJ+7VLmgpfZ
         fSylaRhF/VTB9k6p1MjNLpvaIFQDH4zCBenMXhy4MN2zQaGmz+zGFNe3vWnR2r1A9mmY
         T3YQHc1GE4Di/ngHDZqEjE4LqnpIDxW9a2VXY5ZZ8KPFbxoZw9aYVtSrlESWpNptE39B
         mTMg==
X-Forwarded-Encrypted: i=1; AJvYcCWAzd8zgQNSi22DyZAUqV25sgSLevKUa9LnKSGJcDaY4bQd+wIqlDIz7XFG9ihErBilXcqYs9SJSp+YSCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyPDLhu8ohAu/vvuexHPVAHcj5PAuw16hCq3WMy2j4X6pfh0hC
	ZJHd9oLhYkehW/H9dvp5R9QELpJwCrjXsL2xVhiCFqelqRPD1G0CgskyvUXEKtCL/KNpdJ0BM3x
	cj3xb4vomSQSH0LLlRazwZUQOr+npQPtv+s4SL5ygHxt7dpTCdvNMmxc=
X-Google-Smtp-Source: AGHT+IFs7wLBImYMHk/cGG36IM81JcNaYNKVsG95m7e3dGqVDuohZWeSL9uTWancEk5dTxtBUmGa0eEjap8Y+W0pFCJH8Elqovsk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6413:b0:803:85e8:c40b with SMTP id
 ca18e2360f4ac-82a262f597dmr59911339f.3.1725286682477; Mon, 02 Sep 2024
 07:18:02 -0700 (PDT)
Date: Mon, 02 Sep 2024 07:18:02 -0700
In-Reply-To: <20240902131729.8411-1-almaz.alexandrovich@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d859210621239b1c@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in mi_read
From: syzbot <syzbot+bc7ca0ae4591cb2550f9@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+bc7ca0ae4591cb2550f9@syzkaller.appspotmail.com
Tested-by: syzbot+bc7ca0ae4591cb2550f9@syzkaller.appspotmail.com

Tested on:

commit:         7529036a fs/ntfs3: Rename ntfs3_setattr into ntfs_seta..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=176192fb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2258b49cd9b339fa
dashboard link: https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14586b47980000

Note: testing is done by a robot and is best-effort only.


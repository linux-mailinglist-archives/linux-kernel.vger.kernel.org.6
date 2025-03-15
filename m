Return-Path: <linux-kernel+bounces-562414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C25A626A6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 06:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A53B3B1DCE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 05:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52131194C75;
	Sat, 15 Mar 2025 05:38:12 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBAA18C92F
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 05:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742017092; cv=none; b=uZ4M/mhllWJf/AooonikJZpne2b6omzb8RJeRkyy66bHxe7rxt5aixgDq0kFIinz48RwHyuCZv2B8z5a5dnxOHGeygFUh8x/f9iJojqniJsQ5Cjz8QiRfnlPwqA/9w2Vdth3pzzyUpn10tmJvpLXVZgA/dY+I1C9/zIRA4O7MDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742017092; c=relaxed/simple;
	bh=ZDiXjUknHETMzrlYn1zgWu+v7UPrqES23shmZOMFSYI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uPw5x6AwbFhET9ow61hGiAJc3cyxvFZlJXu9wuQaxJgd/dbDhJsDTS7Fvu7xMK7Y1Ki1iVfZFdgXxEjOPiSZHTUp+u97wLusVcSFMhzBtSw263a07s25DfZk0Fb6Z30xsbxEW2Wo08sL29tPztPz5bC8K+BBD/ZkgwiBhl9uEG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ce81a40f5cso58094895ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 22:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742017088; x=1742621888;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jri1wgrpQV6ijagZsM9y5nNBdN2313llFI5vyTbWILA=;
        b=HLbK2ixAJgcop43eoGgD4naQTifgWebN5qQlvr4+dUY3LcxY412Gv4pw/zH851SqLg
         WLti6Hr+IGBViaIN6tmpOWu0fxR4DmBTKpBZJ515wpP2BoGKNjGfH/WV5Nxd3JM+N/XI
         7sxGzhHaiQTE6+Lm2BAgnM2w72rDShJ3TPZHzd95HPosPpuQ7iIvocS/uSM8xztetdfg
         WwC5MveFRvNymoqTIKcR4PcD4VmoL8Z7PxapaESfCkmawjuatV2m9iqsGjzkavaaNOA+
         TjPhKDU+ofY8917nxLegwqNpFX36LHYBsc0JVXwd+rbsvudYN+qp7Lpz1jyIaWFa9joD
         FpTg==
X-Forwarded-Encrypted: i=1; AJvYcCUY5iz6jAxUCdL8+cxQkkzCpZXqduh4meFs+TTVFamn3VoLHyujwtq1HR1zMRBc6B6dzYypJ0L9CXT2Wck=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXvkfeiYd61/lxpJubIlF7aF2rFhrJU1f2bx3iIvf4H4KhzXyW
	GR6T+E9jwCZ2VcFQSF+fi9NEBCnfZCa8Il5OJTAujjys0gmb5oIivoYnOaGQQ3gmzZNWaqUhU4F
	eAGJU0aOmDtvaO5n4SDVjOthuAB0r7Vqd6tC7ruCDU16vhk4QG8NqWMw=
X-Google-Smtp-Source: AGHT+IFQ+XxRMp/jrAZMgPnZUJ5trjdXbQ0Y0KQeY63eEi4hA6eS3lbN90dOhbP8hV87Q1ta+3ekOz3dCXUnIFG3nJBSxi1Vh+6V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3312:b0:3d4:3aba:e5ce with SMTP id
 e9e14a558f8ab-3d483a906ffmr53679835ab.20.1742017088726; Fri, 14 Mar 2025
 22:38:08 -0700 (PDT)
Date: Fri, 14 Mar 2025 22:38:08 -0700
In-Reply-To: <20250315051051.1532-1-enjuk@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d51240.050a0220.14e108.0050.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Read in atomic_ptr_type_ok
From: syzbot <syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, enjuk@amazon.com, haoluo@google.com, 
	iii@linux.ibm.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yepeilin@google.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/bpf/verifier.c
patch: **** unexpected end of file in patch



Tested on:

commit:         2d7597d6 selftests/bpf: Fix sockopt selftest failure o..
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=a5964227adc0f904549c
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13ff2e54580000



Return-Path: <linux-kernel+bounces-293127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36DB957B12
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37FD21F230F3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13F31B949;
	Tue, 20 Aug 2024 01:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYFib4cA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE5717C67
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118090; cv=none; b=ae/jIabtHSVrgJekU9P5JsQ9lyrtaNONN/lAvpd549sHyF3hv6o79W1ZMMOztEVTtBSxIK3Y6UKyH8g1a6wG8y14pzp0vzhJiojeUIe4YsCgsMUXgf1++S9K+Iy62DcbqsbzAQdkbXLUu59Hksx+tdDjaUZx1Tm8+dKzrzdBlSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118090; c=relaxed/simple;
	bh=DCkLKogFb/upcpjYJqPenpeaoza5XAjOBnH2HCDseas=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fRDbOIkFC9wPJUwvoPLrH5U+YL9gom2Nschd17FnwbuPjduU6oPxZUKaTBkqNN7d92/NwbH0sClfUTAKbxsczFx5oUHrB54a0aaLq2IPm22xfmF9vKtP3t7u5rN4I8Z9UADfxUFOTkVl7HU7uKeRYeuwcY7FHNmRduBNGWnsHJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYFib4cA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC73C32782;
	Tue, 20 Aug 2024 01:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724118089;
	bh=DCkLKogFb/upcpjYJqPenpeaoza5XAjOBnH2HCDseas=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=PYFib4cAHxbYSqhpOSWIvsGGsEwGMVLadyYN6XW1hisORKzZgr0N+YEbA78XZtA2/
	 oKvMmxTFvS3vU3lsYWbLeNKdiiGSLqnmvIjWBF5+QHtQLdgHEJj7f4LBOyxdwx3VYo
	 EhnB3N9/6AdD3nh2IH1h7lIBv0nvNZQ5v/ZJE1+nAtka3Mcd1nNCU/7Zb+vwYjC9fy
	 4z+Pb7leNCwLyjRpWB1nwEgnLUYZh9b4+B0JfOGMLE2JulxSNWaVs9myjIIJ2zOS37
	 4lWp/qqsMXLHkpQFhA9zbSZQsj9/wtLvWwkHUXqOZfK0VOUwgsz+jfpzrpmkaLgpTb
	 vqGGdDXgvDj4Q==
Message-ID: <315d5849-69ea-4574-8157-22d34c2ca0b6@kernel.org>
Date: Tue, 20 Aug 2024 09:41:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_vm_page_mkwrite
To: syzbot <syzbot+f195123a45ad487ca66c@syzkaller.appspotmail.com>,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000038c729061ef13d67@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <00000000000038c729061ef13d67@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz fix: f2fs: fix return value of f2fs_convert_inline_inode()

On 2024/8/5 23:22, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit a8eb3de28e7a365690c61161e7a07a4fc7c60bbf
> Author: Chao Yu <chao@kernel.org>
> Date:   Mon Jun 3 01:07:45 2024 +0000
> 
>      f2fs: fix return value of f2fs_convert_inline_inode()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1055414b980000
> start commit:   83814698cf48 Merge tag 'powerpc-6.10-2' of git://git.kerne..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=238430243a58f702
> dashboard link: https://syzkaller.appspot.com/bug?extid=f195123a45ad487ca66c
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1129d362980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d4ce06980000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: f2fs: fix return value of f2fs_convert_inline_inode()
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection



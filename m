Return-Path: <linux-kernel+bounces-429727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E199E216B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A2E282394
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FA8204087;
	Tue,  3 Dec 2024 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="llHi3zmx";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="m5S6eSbu"
Received: from mta-03.yadro.com (mta-03.yadro.com [89.207.88.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6351F75B1
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238570; cv=none; b=W9e9OpfM6axCa9dhRm/NZdgtdr6BiBZ5g8EasPSnmdBt5rA96zDC2vW/0SycoVSQPWRkg0w2IuuCGdjiKWgeFNhNifBOtSjuQyV2E7I6hIJFeC/bS0rqor0ksLNf4Zg3umnXf/fZdhJrjMp/G8L2XL4sQe69nJdR4lehzM8NXlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238570; c=relaxed/simple;
	bh=sB7bGshRXluI0jR7pLuSjiwGvmpeRBcbuL6zGU+klIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dJM0Q7VaIZvH4X/+c/URwCT56+o9zIEHYCxrmkT/+/MZ8rzXi4hbJxDAPj4RIUcN3250leSqoJj9ZI8ZCD2WCHCVb2RWlD0iY8pLDJ6PZSDCc+MHCE7tUAOwKxhcIyjBkpJ9l2TOZHWzmMfPNbyT/SvYcApN/qayFoqUyGVlkv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=llHi3zmx; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=m5S6eSbu; arc=none smtp.client-ip=89.207.88.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 557CDE000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1733238564; bh=KVf8hUXjuSbpowAqOIXHXS+rzS1wgLVqN7lbHQj+6/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=llHi3zmx7xcvhjyT89cZ2koxmci/3H0mU5tImgKXosoBVk7NUx1KTsYI1ab1FsxTt
	 DT+foFkWPf2/WYAzP2bbUy2zxZOqZ1oYjHg/IvEu2gfNYKk/uVkdThv2ZIi5HcS9us
	 ucAtBJRRMQrajTP9grIZfw2tDXHOmIYT6iRuQPpJaqSxLT7idu1BKB++/JxwwkkacN
	 7Ribugnj+ALzHJCQMgjWR0okLR4Y1I/rVJ0VHDpLEIqllJD0veIIp6ExCXv+ynkOHR
	 LwPaPa0YbiuJBNGm/m9GCe1OcnUFoDvaZ8LfQhv9X0qCg/QN/VqQkdhlsaxq54NMav
	 bKvk0r1BFOvbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1733238564; bh=KVf8hUXjuSbpowAqOIXHXS+rzS1wgLVqN7lbHQj+6/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=m5S6eSbuDOMCFjzdM3z0oVwZE6BnHmcMVD0V+Aky94CumetunpIgGS8DuW61OO+6s
	 EyFiQsejo+6bFTCTuZMqnisJezak/5+TPqxROaP/qfKLQYZ8gCdNLk6HZlzHbGrlmB
	 EoN31rvuM4IP2Gs+M1/WErfcLKqCKHsr/JTHSJZ7TaSHy/J7Tv0iaCyn1/3XLKEXhj
	 IkMkZKpbVRi8PxsDaV7QFocUFJy22wo/u5TrkdTO5Yizk3GXfuJywA4RvIahwG+7r2
	 MczUiRj9Lgnn0+aImev/go4OcZipcyP1WMZJZ/y0RH8vXmlK6aqytl8tQLXMh0t/9h
	 etVYJbKG1XYQA==
Message-ID: <990b942d-fe91-4bda-a38e-1eb47f2f6086@yadro.com>
Date: Tue, 3 Dec 2024 18:09:22 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] riscv: ftrace: atmoic patching and preempt
 improvements
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Andy Chiu
	<andybnac@gmail.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Nathan Chancellor
	<nathan@kernel.org>, Justin Stitt <justinstitt@google.com>, Bill Wendling
	<morbo@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Paul Walmsley <paul.walmsley@sifive.com>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<llvm@lists.linux.dev>, <bjorn@rivosinc.com>, <puranjay12@gmail.com>,
	<alexghiti@rivosinc.com>, <yongxuan.wang@sifive.com>,
	<greentime.hu@sifive.com>, <nick.hu@sifive.com>, <nylon.chen@sifive.com>,
	<tommy.wu@sifive.com>, <eric.lin@sifive.com>, <viccent.chen@sifive.com>,
	<zong.li@sifive.com>, <samuel.holland@sifive.com>
References: <20241127172908.17149-1-andybnac@gmail.com>
 <87ldwxot7i.fsf@all.your.base.are.belong.to.us>
Content-Language: en-US
From: Evgenii Shatokhin <e.shatokhin@yadro.com>
In-Reply-To: <87ldwxot7i.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 T-EXCH-10.corp.yadro.com (172.17.11.60)

On 03.12.2024 15:18, Björn Töpel wrote:
> Andy!
> 
> "atomic" spelling in the Subject line.
> 
> Andy Chiu <andybnac@gmail.com> writes:
> 
>> Changes in v3:
>> - Add a fix tag for patch 1
>> - Add a data fence before sending out remote fence.i (6)
>> - Link to v2: https://lore.kernel.org/all/20240628-dev-andyc-dyn-ftrace-v4-v2-0-1e5f4cb1f049@sifive.com/
> 
> Hmm, the fixes tag was not included.
> 
> Also, there was a lot of comments from v2 that was not addressed:
> 
>   * Minor spelling nits
>   * Breaking DIRECT_CALL, and include Puranjay's CALL_OPS work in the
>     same series for DIRECT_CALL, to avoid breakage.

Yes, FTRACE_WITH_DIRECT_CALLS is currently broken. If I try to insmod 
samples/ftrace/ftrace-direct.ko, it reports a failure:


[  179.531472] ------------[ ftrace bug ]------------
[  179.531761] ftrace failed to modify
[  179.531786] [<ffffffff8005f9ac>] wake_up_process+0x0/0x24
[  179.532577]  actual:   97:e2:fa:ff:13:00:00:00
[  179.533211] Setting ftrace call site to call ftrace function
[  179.534409] ftrace record flags: 99980001
[  179.534692]  (1)     tramp: ftrace_caller+0x0/0x34 
(call_direct_funcs+0x0/0x14)
[  179.534692]  expected tramp: ffffffff01b0d000
...

> 
> I'll have a look at the barriers (which came up at plumbers)!

Thank you!
After this series and the CALL_OPS work are done, dynamic Ftrace for 
RISC-V will be even more valuable in production use cases.

> 
> 
> Cheers,
> Björn
> 

Regards,
Evgenii


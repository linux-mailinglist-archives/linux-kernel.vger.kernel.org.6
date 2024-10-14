Return-Path: <linux-kernel+bounces-363286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FF199C00A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90D421F230C9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2600145B0B;
	Mon, 14 Oct 2024 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="u91yCczv"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B451D22339
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728887472; cv=none; b=NQlyHFJomzhHDcsOB92M1dn688lEFKnakNPcR5KBKnNGnPjHMtER/kbtxCRHJg4nw5j15gsaTGihUAAUNtypYpD8QWZw5cxNOWPehE+ve5rQsu/3xvTUowfhiikVUKWON+FLRw5H+kvg7/CItZ+6OBrkIaJ7j4ZgRD167Egwwlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728887472; c=relaxed/simple;
	bh=0A4vgkAGt82wxHcpsenFQsI7HzVKtIZqnzOs2bEiezo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4+x6NWGbpgKreEIcONgQjKr5F0r3kO8ddGMwT0SHpsvGeMElBEeRHYmbWZ76UmoC+hFY6fjO1e8c2R+dc5BOFNgX8IzZ58l0Fe+0zDFtu9eef2ejzp/5Jx6bJByiDlAklv5orz5cs/bP3KuKKFkWisO9TlylsNtoJ1+qjnaUys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=u91yCczv; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728887467; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wo8Ga0ptQeAsx82Kg+bL/pEOvPAP2xUdjy9xkwJ1LT0=;
	b=u91yCczve1PWy3jG4qupu7xNd5gI6cYMr58u9At3Jb0z+FvOJG6McvTVUhQ0EKa1fLW3OVVwhQetFUuTZrGrmFRMnzBsgALcyxIpPHM4GFZfN2g0K03Q08wVWmNN9uy01iQnoiSzdcTw5yIybgp2YzGrNsvOd60Iq56o6V/YX8M=
Received: from 30.246.164.22(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0WH1hiLv_1728887465 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 14:31:06 +0800
Message-ID: <dae3a35e-2ce9-42a2-956b-039505c98082@linux.alibaba.com>
Date: Mon, 14 Oct 2024 14:31:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: arm64: nVHE: gen-hyprel: Silent build warnings
To: Marc Zyngier <maz@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20241009085751.35976-1-tianjia.zhang@linux.alibaba.com>
 <86set55yca.wl-maz@kernel.org>
 <b3c21234-73a0-43dd-8365-9039c62b7aa7@linux.alibaba.com>
 <86o73s5cv0.wl-maz@kernel.org>
Content-Language: en-US
From: "tianjia.zhang" <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <86o73s5cv0.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marc,

On 10/10/24 9:03 PM, Marc Zyngier wrote:
> On Thu, 10 Oct 2024 09:12:29 +0100,
> "tianjia.zhang" <tianjia.zhang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 10/9/24 7:07 PM, Marc Zyngier wrote:
>>> On Wed, 09 Oct 2024 09:57:51 +0100,
>>> Tianjia Zhang <tianjia.zhang@linux.alibaba.com> wrote:
>>>>
>>>> This patch silent the some mismatch format build warnings
>>>> with clang, like:
>>>>
>>>>     arch/arm64/kvm/hyp/nvhe/gen-hyprel.c:233:2: warning: format specifies
>>>>     type 'unsigned long' but the argument has type 'Elf64_Off'
>>>>     (aka 'unsigned long long') [-Wformat]
>>>>       233 |         assert_ne(off, 0UL, "%lu");
>>>>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>           |                              %llu
>>>>     arch/arm64/kvm/hyp/nvhe/gen-hyprel.c:193:34: note: expanded from macro 'assert_ne'
>>>>       193 | #define assert_ne(lhs, rhs, fmt)        assert_op(lhs, rhs, fmt, !=)
>>>>           |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>     arch/arm64/kvm/hyp/nvhe/gen-hyprel.c:188:19: note: expanded from macro 'assert_op'
>>>>       187 |                                 " failed (lhs=" fmt ", rhs=" fmt        \
>>>>           |                                                 ~~~
>>>>       188 |                                 ", line=%d)", _lhs, _rhs, __LINE__);    \
>>>>           |                                               ^~~~
>>>>     arch/arm64/kvm/hyp/nvhe/gen-hyprel.c:167:17: note: expanded from macro 'fatal_error'
>>>>       166 |                 fprintf(stderr, "error: %s: " fmt "\n",                 \
>>>>           |                                               ~~~
>>>>       167 |                         elf.path, ## __VA_ARGS__);                      \
>>>>           |                                      ^~~~~~~~~~~
>>>>
>>>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>>>
>>> I don't see these warnings. What version of LLVM are you using?
>>>
>>
>> I compiled the kernel on Apple Silicon M3 Pro in macOS 15.0.1, Maybe this is
>> a special scenario that is rarely used.
>>
>> Details of clang:
>>
>>      # clang --version
>>      Homebrew clang version 19.1.1
>>      Target: arm64-apple-darwin24.0.0
>>      Thread model: posix
>>      InstalledDir: /opt/homebrew/Cellar/llvm/19.1.1/bin
> 
> What I have is similar enough:
> 
> ClangBuiltLinux clang version 19.1.1 (https://github.com/llvm/llvm-project.git d401987fe349a87c53fe25829215b080b70c0c1a)
> Target: aarch64-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /home/maz/hot-poop/llvm/llvm-19.1.1-aarch64/bin
> 
> and yet this doesn't fire. Can you try with a compiler actually
> targeting with Linux instead of MacOS?
> 

I downloaded the precompiled version, but it didn't compile
properly, interrupted by other errors, which seemed to be
different from the brew version:

     HOSTCC  scripts/mod/modpost.o
   scripts/mod/modpost.c:16:10: fatal error: 'fnmatch.h' file not found
      16 | #include <fnmatch.h>
         |          ^~~~~~~~~~~
   1 error generated.

Details of clang:

clang version 19.1.1 (/Users/runner/work/llvm-project/llvm-project/clang 
d401987fe349a87c53fe25829215b080b70c0c1a)
Target: arm64-apple-darwin24.0.0
Thread model: posix
InstalledDir: /Users/tianjia/sbin/LLVM-19.1.1-macOS-ARM64/bin

There is no verification yet whether this patch issue will be fire.
The clang installed with brew can be compiled normally.

Thanks,
Tianjia



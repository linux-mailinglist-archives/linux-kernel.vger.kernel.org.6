Return-Path: <linux-kernel+bounces-436937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D10F9E8CDA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D573164CDB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FE8214816;
	Mon,  9 Dec 2024 08:00:18 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4780A18D656
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 08:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731218; cv=none; b=ffu+3M0HM0RKta0GkUXRNjtcrBnhdFH/iiwZPg3Aq+uZFPAuh3yLeRZp1Zae3ZLdBVUn1ezmT/n5yP9SWGLVdy43t8YLL2tB2Q9ali4ppWQ/1dp5Plm4JNDY1SPTRzvfe3FUF49jDP+1b8eAdcTeER/GuhXugp2Jh9aH/mDuCZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731218; c=relaxed/simple;
	bh=o06oYDDQfFw6zDDYQAQBSk/RmqtS53azB/vMlicYhLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfM3EzbPD3pmYaoVegLO08SqiSfZCtAspT5PkS1TqUTrtL79XmKVY0xzNPSSQbZbkCJB4SNsXlidfxmk03grdVseF2jpo1tYE0r1v+ICIEVuCnDXw0Vq15HB6B2thqgQbAV5zAsfKzJ81t3LydIx4T5gq9tpxsnO00CJ1n7annI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Y6Dmm0yg1z9tMd;
	Mon,  9 Dec 2024 09:00:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z9xJj8PxyCvC; Mon,  9 Dec 2024 09:00:08 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Y6Dmm02jxz9tC2;
	Mon,  9 Dec 2024 09:00:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E05668B764;
	Mon,  9 Dec 2024 09:00:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id LepFlSOSUUj8; Mon,  9 Dec 2024 09:00:07 +0100 (CET)
Received: from [10.25.209.139] (unknown [10.25.209.139])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BA31B8B763;
	Mon,  9 Dec 2024 09:00:07 +0100 (CET)
Message-ID: <ca5559b9-16fe-4808-a28b-b87129b0e6b8@csgroup.eu>
Date: Mon, 9 Dec 2024 09:00:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] futex: improve user space accesses
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Andreas Schwab <schwab@linux-m68k.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20241122193305.7316-1-torvalds@linux-foundation.org>
 <87bjxl6b0i.fsf@igel.home>
 <CAHk-=wjnvFU3sMjjKyqtgvPe6EMu3M4f1qyZncJR5=QDQsV=ng@mail.gmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <CAHk-=wjnvFU3sMjjKyqtgvPe6EMu3M4f1qyZncJR5=QDQsV=ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/12/2024 à 01:32, Linus Torvalds a écrit :
> On Sun, 8 Dec 2024 at 14:54, Andreas Schwab <schwab@linux-m68k.org> wrote:
>>
>> This breaks userspace on ppc32.  As soon as /init in the initrd is
>> started the kernel hangs (without any messages).
> 
> Funky, funky. Most of the diff is the code movement (and some small
> x86-specific stuff), so for ppc, the only part that should be relevant
> is the futex_get_value_locked().
> 
> And since ppc doesn't do the masked user access thing, so it
> *literally* boils down to just that
> 
>          if (!user_read_access_begin(from, sizeof(*from)))
>                  return -EFAULT;
>          unsafe_get_user(val, from, Efault);
>          user_access_end();
> 
> path.
> 
> Ahh... And now that I write that out, the bug is obvious: it should be using
> 
>          user_read_access_end();
> 
> to match up with the user_read_access_begin().

Yes indeed, especially on book3s/32, which is only able to write-protect 
user accesses. On that platform user_read_access_...() are no-ops.

user_access_end() and user_write_access_end() are similar, and rely on a 
thread var stored by user_access_begin(). When calling that 
user_access_end() without prior call to user_access_begin(), that var 
has value ~0 instead of the address of the user segment being accessed, 
and ~0 is a kernel address so user_access_end() applies some user 
segment flags to a kernel segment which most likely leads to a complete 
mess allthough I'm not able to trigger the hang with QEMU.

> 
> And yeah, ppc is the only platform that has that
> "read-vs-write-vs-both" thing, so this bug is not visible anywhere
> else.
> 
> IOW, does this one-liner fix it for you?
> 
>    --- a/kernel/futex/futex.h
>    +++ b/kernel/futex/futex.h
>    @@ -265,7 +265,7 @@
>          else if (!user_read_access_begin(from, sizeof(*from)))
>                  return -EFAULT;
>          unsafe_get_user(val, from, Efault);
>    -     user_access_end();
>    +     user_read_access_end();
>          *dest = val;
>          return 0;
>     Efault:
> 
> I bet it does, but I'll wait for confirmation before actually
> committing that fix.
> 

You'll need the same change in the Efault leg.

Christophe


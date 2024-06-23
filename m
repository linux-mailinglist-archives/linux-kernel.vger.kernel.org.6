Return-Path: <linux-kernel+bounces-226348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0E3913D56
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D452814DF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC551836CA;
	Sun, 23 Jun 2024 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AklQ98c5"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57371183063
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719164580; cv=none; b=mGWBfLYs290jZAixMWBoWYz2PwpBL/g4F3zePVcURlCz7LPHEGDoAKZfQo9ELP4HFNO2ZCCNKM+o8mvB6JwFBoCWji1JOk9cpR0QvL2wS1S0tP8cSFW/bT7xViYy0Bocr/wM6xP3tT+PO5B9b/1VGU7jeZHxKvRdIM6h0quoYlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719164580; c=relaxed/simple;
	bh=oscGVzq/NKo+oTZZ1AvZihbrJjyPE1GySVqYQwm8a2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1Eu+ixjjQl2T2nf0FnPQncqdiZ0MI5zryaavilzbHzfU42JviOV5iCQR0H9Ooyt5CKe9hO6cFOSQMD0H4ouihnz5MI0dIwqykagSPp20B3CHWOUzsWqiH+IOOWdxhTU73s32SDmt6pHDlrnFe8uwvJ29P2hr3k0qZpy/lM3i/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AklQ98c5; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52caebc6137so3512857e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 10:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719164576; x=1719769376; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r5fJ88lZfkWH2C1vrrOnmXc3j9YkLX+Ta+d42tuBCSQ=;
        b=AklQ98c5y5GpSHdzkbaILAXBawriQq9/QvitJ3a5mjQe/JDWEeIiH1RGV3LK+9EOwN
         ueqkDJowaZrMvKhShS2gpUa6B9v9iVzdek3iC/Fh96V9JsdA11a42qo/W21d7pxFu8/M
         DdWOcpqv+6vCx19jfHvoaiET4ztWWhkMGQ0yA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719164576; x=1719769376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5fJ88lZfkWH2C1vrrOnmXc3j9YkLX+Ta+d42tuBCSQ=;
        b=LmU8MEM0apL5rf9TW8DA4rGuvw2MfsFHqHYtt4WnhbR3M3NZ0npGxpAGUkvSnMr237
         WJdZkyC3JJ5Kp1ama2vjl0ExysNqH3oM/IuR161eLLRcs9lfD4o86zn3sVWvwruZ/8dl
         hWYRIT9H4LQPfKX5VdGYRyy/m5DDXPhMXJ0DUQX0kbzKT1BXa6an09pYTzpTHTNL+G1J
         muw59PDIFhVOOgP8/zc6MvRjFoUI8glj9OiUKs/BucHpgrMKoRZ+l3RjCY79dbX22rgj
         zGMhHE4MAqG3uU0m6LusJxV2sdwh9RQNCnv+UcuznB28f6GfTSlhUIQSdQx2tapN+ZJM
         cD/g==
X-Forwarded-Encrypted: i=1; AJvYcCX8liqWOsM/linHoqoQIBC059Tqdlw7TKmVWfGm3JUcNenEL2oAHIJ6KPnb5rHq9XxU6wKWvshs43GlxLMC3VB2BmkhW5G+KwzzwozA
X-Gm-Message-State: AOJu0YwhYPISsC5px7W0zmq+hacIj1yq/rHHNBzcKD4pgQ9ufqz5yf46
	p0qKVgsK5cqjuej15538lc1Pmo/N40ANayKJFzlZ7lV66AovCYSc9UOXpNxIk7g7lXWeZoXzD9j
	NEPGEAw==
X-Google-Smtp-Source: AGHT+IEKJuFegftbiPbPZtftoonlhQcWNLsZ0aFxj7oVHwY4TEkSHD0YEFSxf6IoMBdVyKprdoCeLw==
X-Received: by 2002:ac2:5e79:0:b0:52c:dc0b:42cf with SMTP id 2adb3069b0e04-52ce18324e0mr1288659e87.9.1719164576191;
        Sun, 23 Jun 2024 10:42:56 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724ae806dbsm88072266b.41.2024.06.23.10.42.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 10:42:55 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57cd26347d3so3718937a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 10:42:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtoLAvs3gnD1hUR8K+3Qkn7phAKPcyybydyVJihTSJjSeCNX2uuhdoYEqDvQLjdBdjzHlQeuPt+mtWBcBDHsQniz5PFuzyKM9EZqpb
X-Received: by 2002:a50:99de:0:b0:579:cd46:cbfd with SMTP id
 4fb4d7f45d1cf-57d4bd804c1mr1559683a12.18.1719164574484; Sun, 23 Jun 2024
 10:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406230912.F6XFIyA6-lkp@intel.com> <CAFULd4YVOwxQ4JDaOdscX_vtJsqJBJ5zhd0RtXXutW=Eqh29Qw@mail.gmail.com>
 <CAHk-=wg1h4w_m=Op1U4JsyDjsvqG0Kw1EOVMQ+=5GX_XytdorQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg1h4w_m=Op1U4JsyDjsvqG0Kw1EOVMQ+=5GX_XytdorQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 23 Jun 2024 13:42:37 -0400
X-Gmail-Original-Message-ID: <CAHk-=wiM5CNFsxnTnKxX+bGgA8E5r=sSD5iy2evcTDs0ARihHw@mail.gmail.com>
Message-ID: <CAHk-=wiM5CNFsxnTnKxX+bGgA8E5r=sSD5iy2evcTDs0ARihHw@mail.gmail.com>
Subject: Re: arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly
 requires more registers than available
To: Uros Bizjak <ubizjak@gmail.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Jun 2024 at 11:42, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> For example, why does that 32-bit __arch_try_cmpxchg64() do this:
>
>         if (unlikely(!ret))                                             \
>                 *(_oldp) = o.full;                                      \
>
> when I think it would be simpler and more straightforward to just do
> that *(_oldp) = o.full unconditionally?

I can repro the clang issue, and no, removing the conditional doesn't fix it.

A plain revert of

   95ece48165c1 ("locking/atomic/x86: Rewrite x86_32
arch_atomic64_{,fetch}_{and,or,xor}() functions")

does fix it.

The problem does *NOT* happen with a defconfig, so it's clearly
triggered by some horror in that config:

    https://download.01.org/0day-ci/archive/20240623/202406230912.F6XFIyA6-lkp@intel.com/config

and a quick config bisection seems to imply that it might just be

 X86_MINIMUM_CPU_FAMILY 6 -> 4

from setting CONFIG_MGEODEGX1=y instead of M686.

Hmm. While I'm not willing to leave x86-32 behind, I personally have
thought for a couple of years that we should leave Pentium and earlier
behind. We should just require cmpxchg64b support.

It does look like the complication at least partly comes from the
emulation alternative, but I didn't go look any closer.

                Linus


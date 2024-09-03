Return-Path: <linux-kernel+bounces-313093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D7A96A01B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AAF61C245DE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7065028C;
	Tue,  3 Sep 2024 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APQREZe9"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69CA4A15;
	Tue,  3 Sep 2024 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372805; cv=none; b=jKeIk9QyU2oyC4q3tFeViCEj/edwNC6FdYET7X1Snf6K73Uj5uSyKba1AFYGmlkWzROtgn7L+723Kuh2uBWk0iOzhVAmP6agLc4VjQ87/Ir6kiE2jhxdIHEb/d6Jzeu9lyKjeyVbhfx/BpPnAJi8DMeAEmtEd78SEelbsxACZLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372805; c=relaxed/simple;
	bh=juIOwHUPRN8vW4bywZbLSPaACj8BtTxzQFAnm9FkNFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCOnH5+TgXuprXxQtoGjdmJZyx2icoYSmE9GrGwx2QOSBQEXa9VIiCPlIsUSqrSOJ2x9sZedNBKVgdti5sbLLvWdtIs5sBmZyqjXZqXgOEHSOW6jKAbIkkesfknpE8l+ZCAMMzTRb/S+MJzUkxu2F9p3rHDKl5SOSOzDZQRpL+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APQREZe9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2068acc8b98so11278185ad.3;
        Tue, 03 Sep 2024 07:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725372803; x=1725977603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SrPZGJn6KWoXZtLiezcU+c0qMmF52QD9yccf17rPGTI=;
        b=APQREZe9p0IuJidCtVrurMIfxkcuelDVaFOp1tEHBCIPEsb4hKE2Qdof/zFgVd7NTM
         Q64qhXFT9sRC2R5gEMzYI4c4Od58vvqNruqY3RkaCxhzRm28R03DTd5/JJVmlbf1MfOm
         uSIAA+J7FAArNeX9WrRMzJ6JSZ+mRkQ+QkH7hHD4x89+OMkBQe8VdZzV6bbmDmo2xx1i
         CAi3rr8Bf57ys9SmIyxtZw8fx+sg+qO7dnijw/0f1hYjToKJOWXMp4ABSom345SLQhfB
         1qbD5fIyGKb4rsUslG49RECqGwbPZKsY3on/1GMsEFJBkwPoyeQLVcJkm4NkP8Y43+kJ
         WNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725372803; x=1725977603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrPZGJn6KWoXZtLiezcU+c0qMmF52QD9yccf17rPGTI=;
        b=IJhUyK0g5Y2+v904ObB8SReJ8nJRnDR6kW2oEF40TvliKzJFT2jrEiJesffJrD3whc
         Zx940EBY78lqJIu32jE62MvPqvTPcpLbbcqTWvzP9vOB1ZrNTcKlpYrXclUbelV8V0W5
         y0WSJ/MJivC0Ica0JTG4WmUHNyKJkIJoGfnD4zhhjlA8LSHOCFLXeKELSgAmkfixGBJJ
         kD7nksESao+wY58xQb9xwc5ZXoc031p0eTRR8TAZNF7Gg/14evKXGPzLFXZSSpFVDGSl
         mqS9fm8rpCNmyN0AkRituIOCnVrw95iYFjpzZ3TWiOBA3m/4HvD1Z6isECIoPzUmG7ZG
         SEpA==
X-Forwarded-Encrypted: i=1; AJvYcCW2D7WFFzVyyAMWUOGHBXEBG7zoMrMeyHT3kE0eN92dxbycdGfuFSm0KF5nnd70NSyGA2U26fWlUKYkXGM=@vger.kernel.org, AJvYcCWYVenwaVVkOIuvkyF/VR6hT1q96sg3UU2/pWa10zl5i30qyasU4Znd1+cGiSZ6Uxll3pnE4yxPhSTPMTvy@vger.kernel.org
X-Gm-Message-State: AOJu0YyfGHf1KePSP57aNP+Qjtk2oukKfiy5s/8Bupt2ouPBwrG8VEWT
	C65hsKC6h9T36fZKMFIaL9Zf5h+WUC9c2yePy33xOCG4ctNqT4fa
X-Google-Smtp-Source: AGHT+IEjRbIOY72pGCBavbHe7BJELVDZYV3WLdduDbQaH6rRYLYRoQUnq6dTD/kZle9J6gIeR3MBdg==
X-Received: by 2002:a17:902:e74b:b0:201:f409:ce73 with SMTP id d9443c01a7336-2050c4cf204mr198209875ad.65.1725372802888;
        Tue, 03 Sep 2024 07:13:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205f6d30bb6sm20361615ad.211.2024.09.03.07.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:13:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 3 Sep 2024 07:13:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Helge Deller <deller@gmx.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	Linux-MM <linux-mm@kvack.org>, linux-parisc@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
Message-ID: <0e8cf563-345d-4fd4-b0ff-d80e0c7ac29c@roeck-us.net>
References: <90e02d99-37a2-437e-ad42-44b80c4e94f6@suse.cz>
 <87frrh44mf.ffs@tglx>
 <76c643ee-17d6-463b-8ee1-4e30b0133671@roeck-us.net>
 <87plqjz6aa.ffs@tglx>
 <CAHk-=wi_YCS9y=0VJ+Rs9dcY-hbt_qFdiV_6AJnnHN4QaXsbLg@mail.gmail.com>
 <87a5hnyox6.ffs@tglx>
 <CAHk-=wh4rxXPpYatnuXpu98KswLzg+u7Z9vYWJCLNHC_yXZtWw@mail.gmail.com>
 <8734nezz0g.ffs@tglx>
 <CAHk-=wiZUidi6Gm_6XFArT621H7vAzhDA63zn2pSGJHdnjRCMA@mail.gmail.com>
 <250f3ae6-3a81-40c7-a747-4713e8888510@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <250f3ae6-3a81-40c7-a747-4713e8888510@gmx.de>

On Tue, Sep 03, 2024 at 09:54:19AM +0200, Helge Deller wrote:
> On 8/8/24 20:19, Linus Torvalds wrote:
> > On Thu, 8 Aug 2024 at 10:48, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > 
> > > Here is the disassembly from my latest crashing debug kernel which
> > > shifts it up a couple of pages. Add 0x10 or sub 0x20 to make it work.
> > 
> > Looks like I was off by an instruction, it's the 28th divide-step (not
> > 29) that does the page crosser:
> > 
> > >      4121dffc:   0b 21 04 41     ds r1,r25,r1
> > >      4121e000:   0b bd 07 1d     add,c ret1,ret1,ret1
> > 
> > but my parisc knowledge is not good enough to even guess at what could go wrong.
> > 
> > And I have no actual reason to believe this has *anything* to do with
> > an itlb miss, except for that whole "exact placement seems to matter,
> > and it crosses a page boundary" detail.
> 
> Well, you were on the right track :-)
> 
> Guenters kernel from
> http://server.roeck-us.net/qemu/parisc64-6.10.3/
> boots nicely on my physical C3700 machine, but crashes with Qemu.
> 
> So, it's not some bug in the kernel ITLB miss handler or other
> Linux kernel code.
> 
> Instead it's a Qemu bug, which gets triggered by the page
> boundary crossing of:
>    41218ffc:   0b 21 04 41     ds r1,r25,r1
>    41219000:   0b bd 07 1d     add,c ret1,ret1,ret1
> 
> During the ITLB miss, the carry bits and the PSW-V-bit
> (from the divide step) are saved in the IPSW register and restored
> upon irq return.
> 
> During packaging the bits there is a qemu coding bug, where we missed
> to handle the PSW-V-bit as 32-bit value even on a 64-bit CPU.
> The (copy&pasted) patch below fixes the crash for me.
> 

Yes, that works for me as well. Thanks a lot for the fix!

Guenter

> Helge
> 
> diff --git a/target/hppa/helper.c b/target/hppa/helper.c
> index b79ddd8184..d4b1a3cd5a 100644
> --- a/target/hppa/helper.c
> +++ b/target/hppa/helper.c
> @@ -53,7 +53,7 @@ target_ulong cpu_hppa_get_psw(CPUHPPAState *env)
>      }
> 
>      psw |= env->psw_n * PSW_N;
> -    psw |= (env->psw_v < 0) * PSW_V;
> +    psw |= ((env->psw_v >> 31) & 1) * PSW_V;
>      psw |= env->psw | env->psw_xb;
> 
>      return psw;
> 


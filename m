Return-Path: <linux-kernel+bounces-230762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03989918195
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FE128178A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CE31822CB;
	Wed, 26 Jun 2024 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pd/i5zHI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E972181CFF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407037; cv=none; b=D3T1po0sO1dtNXQ/Vy4/FdfsXcaspLip8dgsJXOog5nI6TnEWS0kFCvcq3uTjmDvzSP+9cQuMy8XGmEjKSHL8AWVpeyw+2VAy8bj43wx1c8dNIEBNWHNkIptUOgB1jYJ2GQpFuTZ0onjtHo0hfT2W72V+hAN3ryzYwSHGG/quMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407037; c=relaxed/simple;
	bh=Uta7Ar4IuN68vM/aeq1mQnasHGnsAdafsPir9UrleIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nn6DHeQbweqLBOHJtEJGXUxCdw+nEhigdA9eTVR29EVVVqxLzvvkX5nsgQUDs5PNh0JQjapVkKK15nDkM9LgB84W73FcNKcKaS+iOQM/ni0Fe4uJbNwvz+Tw+FMkMKp0s+SrM0Kx50e8CkZEC91CvQKQT2luChiILBgqUsfKuK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pd/i5zHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FF3C2BD10;
	Wed, 26 Jun 2024 13:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719407036;
	bh=Uta7Ar4IuN68vM/aeq1mQnasHGnsAdafsPir9UrleIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pd/i5zHIn/AQu7DnXglDjXVDP9Kqs1JHUD2n7nhTlLi8yjm2IKz+JBZx+4Yr+VtVE
	 e7yHGcUPsRbgcbw2P9+0iAa3eQIuPxdxCvD4zQ0061JLX7KAItn2oMa+/oo7u6EDKu
	 InxF+MFcm1V/lYROQX9e8N+GxCkVpWhXIeDRiX1glTL0WRzxgq4B6Rtu/igGkMkHjJ
	 kKbqnRgp6CKAu2f9hX6M/ujgXDcLOn2TSFJ7iTZJAYpwPGfOf02rZC1mJD1CS20bqy
	 b3G+YD1AUQjI6Cbskf2xxrUstH05FMPGqFtukjg1/JATbW2sStWEYgcPcvdhb0UfS+
	 VYyYxbL50Koew==
Date: Wed, 26 Jun 2024 20:49:50 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] riscv: uaccess: use input constraints for ptr of
 __put_user
Message-ID: <ZnwObmA70Bfx9yCn@xhacker>
References: <20240625040500.1788-1-jszhang@kernel.org>
 <20240625040500.1788-3-jszhang@kernel.org>
 <acd2e53f-b5c1-49c5-86e2-bc09eb917163@app.fastmail.com>
 <ZnwKXWzRz9B5FbLM@xhacker>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZnwKXWzRz9B5FbLM@xhacker>

On Wed, Jun 26, 2024 at 08:32:38PM +0800, Jisheng Zhang wrote:
> On Tue, Jun 25, 2024 at 07:54:30AM +0200, Arnd Bergmann wrote:
> > On Tue, Jun 25, 2024, at 06:04, Jisheng Zhang wrote:
> > > I believe the output constraints "=m" is not necessary, because
> > > the instruction itself is "write", we don't need the compiler
> > > to "write" for us. So tell compiler we read from memory instead
> > > of writing.
> > >
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > 
> > I think this is a bit too confusing: clearly there is no
> > read access from the __user pointer, so what you add in here
> > is not correct. There also needs to be a code comment about
> 
> Here is my understanding: the __put_user is implemented with
> sd(or its less wider variant, sw etc.), w/o considering the
> ex_table, the previous code can be simplified as below:
> 
> __asm__ __volatile__ (
> 	"sw	%z2, %1\n"
> 	: "+r" (err), "=m" (*(ptr))
> 	: "rJ" (__x));
> 
> Here ptr is really an input, just tells gcc where to store,
> And the "store" action is from the "sw" instruction, I don't
> need the gcc generates "store" instruction for me. so IMHO,
> there's no need to use output constraints here. so I changed
> it to
> 
> __asm__ __volatile__ (
> 	"sw	%z1, %2\n"
> 	: "+r" (err)
> 	: "rJ" (__x), "m"(*(ptr)));
> 
> The key here: is this correct?
> 
> 
> Here is the put_user piece code and comments from x86
> 
> /*
>  * Tell gcc we read from memory instead of writing: this is because
>  * we do not write to any memory gcc knows about, so there are no
>  * aliasing issues.
>  */
> #define __put_user_goto(x, addr, itype, ltype, label)                   \
>         asm goto("\n"                                                   \
>                 "1:     mov"itype" %0,%1\n"                             \
>                 _ASM_EXTABLE_UA(1b, %l2)                                \
>                 : : ltype(x), "m" (__m(addr))                           \
>                 : : label)

Here is the simplified put_user piece code of arm64:

#define __put_mem_asm(store, reg, x, addr, err, type)                   \
        asm volatile(                                                   \
        "1:     " store "       " reg "1, [%2]\n"                       \
        "2:\n"                                                          \
        _ASM_EXTABLE_##type##ACCESS_ERR(1b, 2b, %w0)                    \
        : "+r" (err)                                                    \
        : "rZ" (x), "r" (addr))

no output constraints either. It just uses "r" input constraints to tell
gcc to read the store address into one proper GP reg.

> 
> 
> As can be seen, x86 also doesn't put the (addr) in output constraints,
> I think x86 version did similar modification in history, but when I tried
> to searh the git history, the comment is there from the git first day.
> 
> Any hint or suggestion is appreciated!
> 
> > why you do it this way, as it's not clear that this is
> > a workaround for old compilers without
> > CONFIG_CC_HAS_ASM_GOTO_OUTPUT.
> > 
> > > index 09d4ca37522c..84b084e388a7 100644
> > > --- a/arch/riscv/include/asm/uaccess.h
> > > +++ b/arch/riscv/include/asm/uaccess.h
> > > @@ -186,11 +186,11 @@ do {								\
> > >  	__typeof__(*(ptr)) __x = x;				\
> > >  	__asm__ __volatile__ (					\
> > >  		"1:\n"						\
> > > -		"	" insn " %z2, %1\n"			\
> > > +		"	" insn " %z1, %2\n"			\
> > >  		"2:\n"						\
> > >  		_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %0)		\
> > > -		: "+r" (err), "=m" (*(ptr))			\
> > > -		: "rJ" (__x));					\
> > > +		: "+r" (err)			\
> > > +		: "rJ" (__x), "m"(*(ptr)));					\
> > >  } while (0)
> > > 
> > 
> > I suspect this could just be a "r" constraint instead of
> > "m", treating the __user pointer as a plain integer.
> 
> I tried "r", the generated code is not as good as "m"
> 
> for example
> __put_user(0x12, &frame->uc.uc_flags);
> 
> with "m", the generated code will be
> 
> ...
> csrs    sstatus,a5
> li      a4,18
> sd      a4,128(s1)
> csrc    sstatus,a5
> ...
> 
> 
> with "r", the generated code will be
> 
> ...
> csrs    sstatus,a5
> li      a4,18
> addi    s1,s1,128
> sd      a4,0(s1)
> csrc    sstatus,a5
> ...
> 
> As can be seen, "m" can make use of the 'offset' of
> sd, so save one instruction.
> 
> > 
> > For kernel pointers, using "m" and "=m" constraints
> > correctly is necessary since gcc will often access the
> > same data from C code as well. For __user pointers, we
> > can probably get away without it since no C code is
> > ever allowed to just dereference them. If you do that,
> > you may want to have the same thing in the __get_user
> > side.
> > 
> >       Arnd


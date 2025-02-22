Return-Path: <linux-kernel+bounces-526985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3C7A405EF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 07:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02CA3BE059
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 06:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02090200112;
	Sat, 22 Feb 2025 06:37:40 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97A72EB10;
	Sat, 22 Feb 2025 06:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740206259; cv=none; b=OnFCs4sha1IzqF76kBdOiuRZ+ElHWLLx0gns7i71vUePostWI8ILEg+XherjduqFM3d2UsRYa0MV9JMSNcEN9YoqvhUE7Y/uUBaiwK8lEqEipUTWorL4/bfLqbhYRfccfrxOzoHjS1V8SJTPGdLFt7IkF44dWTP5jEI+j2Ic7G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740206259; c=relaxed/simple;
	bh=swLoCvJQnqrFGFthTxPH8lzA9/e2VWZZg3VqNHBeVmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZt6jfFfiNDCdvPQPx9y/5rq+nrSqyHVBreeGTNE8nSGuUbuimURciSZYdsmfZwjPOAMESHwYk8JLpMcwcTsFdDTKZTdLWJ7dgwzREN6dIGx83OLuRHWHYG9wg76GLOEqO5uVhGe6aD0upiDMQHiJma/HOH1oCSEEaRKKdkc5cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 51M6bUeU012004;
	Sat, 22 Feb 2025 07:37:30 +0100
Date: Sat, 22 Feb 2025 07:37:30 +0100
From: Willy Tarreau <w@1wt.eu>
To: David Laight <david.laight.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Engelhardt <ej@inai.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
        ksummit@lists.linux.dev
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250222063730.GB11482@1wt.eu>
References: <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh>
 <2nn05osp-9538-11n6-5650-p87s31pnnqn0@vanv.qr>
 <2025022052-ferment-vice-a30b@gregkh>
 <9B01858A-7EBD-4570-AC51-3F66B2B1E868@zytor.com>
 <n05p910s-r5o3-0n36-5s44-qr769prp69r5@vanv.qr>
 <20250221183437.1e2b5b94@pumpkin>
 <CAHk-=wjF0wjD4ko7MgrZ1wBZ9QOrQd_AnyhDDUJQ1L5+i-o22A@mail.gmail.com>
 <20250221214501.11b76aa8@pumpkin>
 <20250222063210.GA11482@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222063210.GA11482@1wt.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Feb 22, 2025 at 07:32:10AM +0100, Willy Tarreau wrote:
> On Fri, Feb 21, 2025 at 09:45:01PM +0000, David Laight wrote:
> > On Fri, 21 Feb 2025 11:12:27 -0800
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > 
> > > On Fri, 21 Feb 2025 at 10:34, David Laight <david.laight.linux@gmail.com> wrote:
> > > >
> > > > As Linus said, most modern ABI pass short structures in one or two registers
> > > > (or stack slots).
> > > > But aggregate returns are always done by passing a hidden pointer argument.
> > > >
> > > > It is annoying that double-sized integers (u64 on 32bit and u128 on 64bit)
> > > > are returned in a register pair - but similar sized structures have to be
> > > > returned by value.  
> > > 
> > > No, they really don't. At least not on x86 and arm64 with our ABI.
> > > Two-register structures get returned in registers too.
> > > 
> > > Try something like this:
> > > 
> > >   struct a {
> > >         unsigned long val1, val2;
> > >   } function(void)
> > >   { return (struct a) { 5, 100 }; }
> > > 
> > > and you'll see both gcc and clang generate
> > > 
> > >         movl $5, %eax
> > >         movl $100, %edx
> > >         retq
> > > 
> > > (and you'll similar code on other architectures).
> > 
> > Humbug, I'm sure it didn't do that the last time I tried it.
> 
> You have not dreamed, most likely last time you tried it was on
> a 32-bit arch like i386 or ARM. Gcc doesn't do that there, most
> likely due to historic reasons that couldn't be changed later,
> it passes a pointer argument to write the data there:
> 
>   00000000 <fct>:
>      0:   8b 44 24 04             mov    0x4(%esp),%eax
>      4:   c7 00 05 00 00 00       movl   $0x5,(%eax)
>      a:   c7 40 04 64 00 00 00    movl   $0x64,0x4(%eax)
>     11:   c2 04 00                ret    $0x4
> 
> You can improve it slightly with -mregparm but that's all,
> and I never found an option nor attribute to change that:
> 
>   00000000 <fct>:
>      0:   c7 00 05 00 00 00       movl   $0x5,(%eax)
>      6:   c7 40 04 64 00 00 00    movl   $0x64,0x4(%eax)
>      d:   c3                      ret
> 
> ARM does the same on 32 bits:
> 
>   00000000 <fct>:
>      0:   2105            movs    r1, #5
>      2:   2264            movs    r2, #100        ; 0x64
>      4:   e9c0 1200       strd    r1, r2, [r0]
>      8:   4770            bx      lr
> 
> I think it's simply that this practice arrived long after these old
> architectures were fairly common and it was too late to change their
> ABI. But x86_64 and aarch64 had the opportunity to benefit from this.
> For example, gcc-3.4 on x86_64 already does the right thing:
> 
>   0000000000000000 <fct>:
>      0:   ba 64 00 00 00          mov    $0x64,%edx
>      5:   b8 05 00 00 00          mov    $0x5,%eax
>      a:   c3                      retq
>   
> So does aarch64 since the oldest gcc I have that supports it (linaro 4.7):
> 
>   0000000000000000 <fct>:
>      0:   d28000a0        mov     x0, #0x5                        // #5
>      4:   d2800c81        mov     x1, #0x64                       // #100
>      8:   d65f03c0        ret
> 
> For my use cases I consider that older architectures are not favored but
> they are not degraded either, while newer ones do significantly benefit
> from the approach, that's why I'm using it extensively.
> 
> Quite frankly, there's no reason to avoid using this for pairs of pointers
> or (status,value) pairs or coordinates etc. And if you absolutely need to
> also support 32-bit archs optimally, you can do it using a macro to turn
> your structs to a larger register and back:
> 
>   struct a {
>           unsigned long v1, v2;
>   };
> 
>   #define MKPAIR(x) (((unsigned long long)(x.v1) << 32) | (x.v2))
>   #define GETPAIR(x) ({ unsigned long long _x = x; (struct a){ .v1 = (_x >> 32), .v2 = (_x)}; })
> 
>   unsigned long long fct(void)
>   {
>           struct a a = { 5, 100 };
>           return MKPAIR(a);
>   }
> 
>   long caller(void)
>   {
>           struct a a = GETPAIR(fct());
>           return a.v1 + a.v2;
>   }
> 
>   00000000 <fct>:
>      0:   b8 64 00 00 00          mov    $0x64,%eax
>      5:   ba 05 00 00 00          mov    $0x5,%edx
>      a:   c3                      ret
> 
>   0000000b <caller>:
>      b:   b8 69 00 00 00          mov    $0x69,%eax
>     10:   c3                      ret
> 
> But quite frankly due to their relevance these days I don't think it's
> worth the effort.

Update: I found in my code a comment suggesting that it works when using
-freg-struct (which is in fact -freg-struct-return) which works both on
i386 and ARM. I just didn't remember about this and couldn't find it when
looking at gcc docs.

Willy


Return-Path: <linux-kernel+bounces-277137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A27949D1F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 02:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3321B21791
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC7F1D6AA;
	Wed,  7 Aug 2024 00:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ippvRri8";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ippvRri8"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D0A7F9;
	Wed,  7 Aug 2024 00:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722991766; cv=none; b=vCvEaaFLrihYXeniYiJHQPPfMID1u64DE5sNU0jqG9lx78eXd6STKBiBj51Pex1MB6WBYiCrv0MsrKnPA5j73TF13albgpkKjjL7HKFTRO0ekKZxsGGS6jEQdr6hqdine7ldc7j0rYY57K9yjGBaUZ4hCXhWoSPNmSLDpzf33RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722991766; c=relaxed/simple;
	bh=04Ao7Gu3iYG6Ru6uFtzLIkdWj5DpDt5JKSB2lAMwb/A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=orsBgqTm+31FB1cOPXHzDXFoLmmUB0iEO8vHVqqSIfHDfh1+y8Z+TgKQKAcoVAWQ7Cd8mXhEfkWbqCxhLUnx2I0VpsU//U4F+7+SpzMvSwkFDow9RLz1bE8WRm17dBznaL42rio8LjtgNBbYeUAbXyIP4VZ1wx2UpP9ipAbynUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ippvRri8; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ippvRri8; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722991763;
	bh=04Ao7Gu3iYG6Ru6uFtzLIkdWj5DpDt5JKSB2lAMwb/A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ippvRri8Pvnrj8TuaizEMPKDYmNUtV9gZBDnT4u+cfJF0eq9mWh0D0ofA3O5JO+zZ
	 WSuxLPSmCLqLKWt48iANvq3MYVWhh6AFEvg4uqsUqwL8O+uuQIBWHLhLnYIFuVFHMH
	 w65Exki8gOpH5GUsZ4zHY/debguECRpZ19uGaC7Q=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id D58B612811FD;
	Tue, 06 Aug 2024 20:49:23 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id TXLXoWHRPw86; Tue,  6 Aug 2024 20:49:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722991763;
	bh=04Ao7Gu3iYG6Ru6uFtzLIkdWj5DpDt5JKSB2lAMwb/A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ippvRri8Pvnrj8TuaizEMPKDYmNUtV9gZBDnT4u+cfJF0eq9mWh0D0ofA3O5JO+zZ
	 WSuxLPSmCLqLKWt48iANvq3MYVWhh6AFEvg4uqsUqwL8O+uuQIBWHLhLnYIFuVFHMH
	 w65Exki8gOpH5GUsZ4zHY/debguECRpZ19uGaC7Q=
Received: from [10.1.1.156] (wsip-70-191-149-15.dc.dc.cox.net [70.191.149.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3F00312806C0;
	Tue, 06 Aug 2024 20:49:22 -0400 (EDT)
Message-ID: <c54ab27ff0f0bb3e9e681eec9a62549e5e245a6b.camel@HansenPartnership.com>
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, Guenter Roeck
 <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, Helge
 Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Date: Tue, 06 Aug 2024 20:49:19 -0400
In-Reply-To: <87frrh44mf.ffs@tglx>
References: <20240731095022.970699670@linuxfoundation.org>
	 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
	 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
	 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz> <87le194kuq.ffs@tglx>
	 <90e02d99-37a2-437e-ad42-44b80c4e94f6@suse.cz> <87frrh44mf.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-08-07 at 01:24 +0200, Thomas Gleixner wrote:
> Cc+: Helge, parisc ML
> 
> We're chasing a weird failure which has been tracked down to the
> placement of the division library functions (I assume they are
> imported
> from libgcc).
> 
> See the thread starting at:
> 
>  
> https://lore.kernel.org/all/718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net
> 
> On Tue, Aug 06 2024 at 21:25, Vlastimil Babka wrote:
> > On 8/6/24 19:33, Thomas Gleixner wrote:
> > > 
> > > So this change adds 16 bytes to __softirq() which moves the
> > > division
> > > functions up by 16 bytes. That's all it takes to make the stupid
> > > go
> > > away....
> > 
> > Heh I was actually wondering if the division is somhow messed up
> > because
> > maxobj = order_objects() and order_objects() does a division. Now I
> > suspect
> > it even more.
> 
> check_slab() calls into that muck, but I checked the disassembly of a
> working and a broken kernel and the only difference there is the
> displacement offset when the code calculates the call address, but
> that's as expected a difference of 16 bytes.
> 
> Now it becomes interesting.
> 
> I added a unused function after __do_softirq() into the softirq text
> section and filled it with ASM nonsense so that it occupies exactly
> one
> page. That moves $$divoI, which is what check_slab() calls, exactly
> one
> page forward:
> 
>     -0000000041218c70 T $$divoI
>     +0000000041219c70 T $$divoI
> 
> Guess what happens? If falls on it's nose again.
> 
> Now with that ASM gunk I can steer the size conveniently. It works up
> to:
> 
>     0000000041219c50 T $$divoI
> 
> and fails for
> 
>     0000000041219c60 T $$divoI
>     0000000041219c70 T $$divoI
> 
> and works again at
> 
>     0000000041219c80 T $$divoI

So just on this, you seem to have proved that only exact multiples of
48 work.  In terms of how PA-RISC caching works that's completely nuts
... however, there may be something else at work, like stack frame
alignment.

> 
> So I added the following:
> 
> +extern void testme(void);
> +extern unsigned int testsize;
> +
> +unsigned int testsize = 192;
> +
> +void __init testme(void)
> +{
> +       pr_info("TESTME: %lu\n", PAGE_SIZE / testsize);
> +}
> 
> called that _before_ mm_core_init() from init/main.c and adjusted my
> ASM hack to make $$divoI be at:
> 
>     0000000041219c70 T $$divoI
> 
> again and surprisingly the output is:
> 
>     [    0.000000] softirq: TESTME: 21

OK, why is that surprising?  4096/192 is 21 due to integer rounding.

> Now I went back to the hppa64 gcc version 12.2.0 again and did the
> same ASM gunk adjustment so that $$divoI ends up at the offset 0xc70
> in the page and the same happens.
> 
> So it's not a compiler dependent problem.
> 
> But then I added a testme() call to the error path and get:
> 
> [    0.000000] softirq: TESTME: 21
> [    0.000000]
> =====================================================================
> ========
> [    0.000000] BUG kmem_cache_node (Not tainted): objects 21 > max 16
> size 192 sorder 0
> 
> Now what's wrong?
> 
> Adding more debug:
> 
> [    0.000000] BUG kmem_cache_node (Not tainted): objects 21 > max 16
> size 192 sorder 0 21
> 
> where the last '21' is the output of the same call which made maxobj
> go
> south:
> 
>  static int check_slab(struct kmem_cache *s, struct slab *slab)
>  {
>         int maxobj;
> @@ -1386,8 +1388,10 @@ static int check_slab(struct kmem_cache
>  
>         maxobj = order_objects(slab_order(slab), s->size);
>         if (slab->objects > maxobj) {
> -               slab_err(s, slab, "objects %u > max %u",
> -                       slab->objects, maxobj);
> +               testme();
> +               slab_err(s, slab, "objects %u > max %u size %u sorder
> %u %u",
> +                        slab->objects, maxobj, s->size,
> slab_order(slab),
> +                        order_objects(slab_order(slab), s->size));
>                 return 0;
>         }
>         if (slab->inuse > slab->objects) {
> 
> I don't know and I don't want to know TBH...

OK, so you're telling us we have a problem with slab_order on parisc
... that's folio_order, so it smells like a parisc bug with
folio_test_large?  Unfortuntely I'm a bit pissed in an airport lounge
on my way to the UK, so I've lost access to my pa test rig and can't
test further for a while.

Regards,

James



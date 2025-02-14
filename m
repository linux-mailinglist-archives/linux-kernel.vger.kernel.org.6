Return-Path: <linux-kernel+bounces-515144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07B6A360C9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6570716F301
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BB726656F;
	Fri, 14 Feb 2025 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjWgDJvl"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46C621CA02
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739544681; cv=none; b=pkQUCkvbtkMNLpzSr9wrn3oI9pznRgvrOfw1+pXIzjBIupMqtr2jAfiHSak9t0kPim5CC+oZri3PUmGts8t6/PhZep5KoSta+heO7sbvE9u3dC91VhcmNGyUTAeta2ogMOyCIU4peEd9/a9PrhNTszBMgSGnG1SQjoG8F3H2KOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739544681; c=relaxed/simple;
	bh=bdbMeH8oaPRgL3u9VvU6Dw1az7CyzfRo1NDkgGXUVSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d90W/jBkKCOoubM3tsa/YxL2UNd6OD8M9fr6xBzpm06FiXaA/dipxq/pnfyHXImSitWb0QCgjOglKW56VZkz2I27brlJvLJo8foCfteZjaVTNV6kCerHiZWYT8Mh/XJ9ZD/TAOG3YJQMQgb+vstqK7o0iqLWYH9ptLB5H+OPwBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjWgDJvl; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f42992f608so3522516a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739544679; x=1740149479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UtkO3BfS7RUR3ZvPkv2iNZwz0HqEh2TlEN4hK+R6VZs=;
        b=BjWgDJvlj0L8VxAAC4mD4mT1DmsAEYE6y/t6i3OIGoFjF+tfziuoHhPfwnDCmDWkal
         ORghkAhY3XjjmIys/YwE823WbHU3TnA9Qmc/b5OukRBCI1j2eNW9ytgfT26UWgp2bOZb
         +x1qLFqnqLEViBT2EYHn6DaqZIa98+xtmbVIBSZ4t4xhcnGrGikxmhF9PwY+m1q8uGs4
         +Qj0gYCPRn6PSeyDfawE0wA3oBmhpm1Qp9uOZYv0FjRz5I9aQzQHmLea+usTt9fTwlKy
         8dJrKbaK5v4ZccCnDryeWloP8AlA75dOF/DwykiSpCV/GPy6oKrOa/ex4M7ydx6VsOXW
         hmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739544679; x=1740149479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtkO3BfS7RUR3ZvPkv2iNZwz0HqEh2TlEN4hK+R6VZs=;
        b=MXlp0j0BVmShhjK8L06ePSi06p/xprWAj1WBURmQQO5unbqRWEC3/JPNr/VLelpMzY
         9Vy3cFkjNozd0XUaRzYiGL+ENAndoAfeeM7MiICdlF0mJt8vpoK3RyZB7OUiZcP0xNPt
         sLP6X4CRNGUjs/R0SIJbg8u4lipQOfGlOiCYtPQ04WroyTbuvrPdtai94utVLVgRUKtk
         ZUn3rvScQnASusMORqEOf6BZEVDOW0H+TP3HzZ0yNoGmN+mmBOEVq0TSZUZNgvmyvtde
         8PVDh3jVOUTKCAs72D57hOXXyl87P+Hcs65YjSAyaB1klFH5eXLdHYKOmAvrfHfFUonz
         8UlA==
X-Forwarded-Encrypted: i=1; AJvYcCVM8fLLuAS8QlDploOwJu07OrHzLL+itclHy8Ft1d/1JL6UZGNQ67XIq7+YOTHbbfDkFSIjUOhT5hx4B3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU9UA31uBovb2+mbvaOqRGfjMUnqcKrPG0EWUr1YODmJ7Y+LDq
	XImTZQvcVOYiIt1P2FYJlPN/G5lIIfKjv7Z/g9RQp6XpK0T0phPc
X-Gm-Gg: ASbGncsU1CjECgLDW+FBqvRN8+XsWeRk3A2h7Vq1Y2FlZ9sS+3zUapEMd3bTn5L28gn
	mLMrZjjDHBacf6fS5GUNatK8drWjRF8rM+4VjG+dC70AXoyoIi59rZtgkUffTQrlTDWnmQeNvn7
	uDBTpYUJwqVBL1OH82edKu9WvdzGe4GFSkEBxyYWqRB+fK040e9oVxCcerXsEkTSRMZSTzWvQJL
	DLQWl7zv/M+QksR18eULuSVueRt95wUyFQOP28xeiV1lMmV1Dgjw9IOyxE2vBT+mdB0NQ4MRiVe
	Fwt0uK6n23jea86elfHg5XXyQfc5es7A
X-Google-Smtp-Source: AGHT+IFshQ2u48OOIlxtH9By/ZtXEpcmtkK2VSxnuv7nA6QWRQLbgOVaJ4JYV6mRWu6zNaDuCDH2Yg==
X-Received: by 2002:a17:90b:2248:b0:2ee:e113:815d with SMTP id 98e67ed59e1d1-2fc0e2c0d3cmr11021077a91.8.1739544678687;
        Fri, 14 Feb 2025 06:51:18 -0800 (PST)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:2434:f20a:5d9e:5136])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc327f1158sm670693a91.0.2025.02.14.06.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 06:51:18 -0800 (PST)
Date: Fri, 14 Feb 2025 22:51:13 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: anshuman.khandual@arm.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw, skhan@linuxfoundation.org,
	Matthias Kaehlcke <mka@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] uapi: Refactor __GENMASK() for speed-up
Message-ID: <Z69YYeQB5E5Mi3Jf@vaxr-BM6660-BM6360>
References: <20250211162412.477655-1-richard120310@gmail.com>
 <20250211162412.477655-2-richard120310@gmail.com>
 <Z6uZZPpQ9YYfrL-I@thinkpad>
 <Z6uaW9XzaKjSrWYC@thinkpad>
 <Z6ypqCN_KI2gaSJ4@vaxr-BM6660-BM6360>
 <Z65N81jXcyKIu95l@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z65N81jXcyKIu95l@thinkpad>

On Thu, Feb 13, 2025 at 02:54:27PM -0500, Yury Norov wrote:
> + Andrew, Matthias
> 
> On Wed, Feb 12, 2025 at 10:01:12PM +0800, I Hsin Cheng wrote:
> > On Tue, Feb 11, 2025 at 01:44:18PM -0500, Yury Norov wrote:
> > > On Tue, Feb 11, 2025 at 01:39:34PM -0500, Yury Norov wrote:
> > > > On Wed, Feb 12, 2025 at 12:24:11AM +0800, I Hsin Cheng wrote:
> > > > > The calculation of "((~_UL(0)) - (_UL(1) << (l)) + 1)" is to generate a
> > > > > bitmask with "l" trailing zeroes, which is equivalent to
> > > > > "(~_UL(0) << (l))".
> > > > 
> > > > I used to think that GENMASK() is a compile-time macro. __GENMASK() is
> > > > not, but it has very limited usage through the kernel, all in the uapi.
> > > >  
> > > > > Refactor the calculation so the number of arithmetic instruction will be
> > > > > reduced from 3 to 1.
> > > > 
> > > > I'd like to look at it! Please share disassembly.
> > > > 
> > > > > Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> > > > > ---
> > > > > Test is done to show the speed-up we can get from reducing the number of
> > > > > instruction. The test machine runs with 6.9.0-0-generic kernel on x86_64
> > > > > architecture with processor AMD Ryzen 7 5700X3D 8-Core Processor.
> > > > 
> > > > So you CC arm maintainers and provide tests against x86_64. Are your
> > > > improvements consistent for arm, power and other arches?
> > > > 
> > > > Can you run bloat-o-meter against your change?
> > > 
> > > Ah, sorry, overlooked you bloat-o-meter results in cover letter.
> > > Anyways, can you provide it for each patch individually?
> > 
> > Oh ok, let me paste them here first, I'll attach them along with v2 as
> > well.
> > 
> > In the section below, vmlinux_old uses old version of GENMASK() and
> > GENMASK_ULL(), vmlinux_p1 use new version of GENMASK() and old version
> > of GENMASK_ULL(), vmlinux_p2 use new version of GENMASK() and new
> > version of GENMASK_ULL().
> > 
> > $ ./scripts/bloat-o-meter vmlinux_old vmlinux_p1
> > add/remove: 0/2 grow/shrink: 46/505 up/down: 464/-1717 (-1253)
> 
> So, I ran the build myself and I confirm that reverting c32ee3d9abd284b4
> (which this patch actually does) helps to save over 1k of .text. In my
> case it's 1269 bytes on x86_64 + defconfig for GENMASK() only.
> 
> I looked at some functions affected by this revert, and I found that
> they call for_each_*_cpu() macros. This eventually boils down to bitmap
> functions like this:
> 
>   static __always_inline
>   unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
>                               unsigned long offset)
>   {
>           if (small_const_nbits(size)) {
>                   unsigned long val;
>   
>                   if (unlikely(offset >= size))
>                           return size;
>   
>                   val = *addr & GENMASK(size - 1, offset);
>                   return val ? __ffs(val) : size;
>           }   
>   
>           return _find_next_bit(addr, size, offset);
>   }
> 
> The 'size' here is NR_CPUS, which on my machine is 64. 
> 
> GENMASK is used with non-constant parameters, but it's OK because
> from compiler's point of view, the GENMASK_INPUT_CHECK() which is
> just:
>         BUILD_BUG_ON_ZERO(const_true((l) > (h)))
> 
> It is passed as the 'offset > size', and it's is indeed a constant
> expression at that point because it's explicitly tested before.
> 
> Is this for_each_cpu() thing the only case - I don't know, but it's
> enough to consider reverting back to the original version.
> 
> I Hsing,
> 
> At first, thank you for catching this up.
> 
> I think performance testing part is trivial here, so let's focus on
> code generation and consistency.
> 
> Can you please run your build against few recent GCC and clang versions?
> Can you also build the kernel for ARM64? You don't need to run it on
> real hardware (but maybe on VM). I just need to make sure that the
> result is consistent for all important arches.
> 
> Matthias didn't mention how did he build his kernel. Did clang emit
> that warning against W=0, 1 or higher, and which code triggered the
> warning? Maybe clang already fixed it?
> 
> Can you please check how would it work if NR_CPUS is set to be say 1024?
> This way the small_const_nbits optimization will be disabled.
> 
> If you will find that clang still emits warnings at lower than W=2,
> can you please resend this patches together with a patch that
> suppresses clang warning?
> 
> Can you also please attach one or two examples of code generation for
> real functions, not an artificial one as you did before. And maybe a
> link to goldbolt?
> 
> For the next iteration can you please make sure that you refer your
> series as a revert of Matthias's patch? 
> 
> Thank you for discovering this. I realize that I'm asking you to do
> some extra work, but we all need to be 100% sure that it's not a fluke
> before reverting the c32ee3d9abd284b4 because it potentially leads to
> suppressing another clang warning.
> 
> Thanks,
> Yury

Hi Yury,

No problem ! I'll be happy to help with these tests, I'll send the next
iteration when I complete the things you mentioned.

> Is this for_each_cpu() thing the only case - I don't know, but it's
> enough to consider reverting back to the original version.

So basically the reason of sizing up is because for_each_cpu() put
non-constant parameter in GENMASK(), which is supposed to be used by
constant only?

> Can you also please attach one or two examples of code generation for
> real functions, not an artificial one as you did before. And maybe a
> link to goldbolt?

I have no problem of other tests but this one, I wrote a simple
artificial use case because most functions I found according to the
report generated by bloat-o-meter, doesn't use GENMASK() directly or
they're super long and GENMASK() only accounts for very small part of
them, it wasn't very trivial to sense the difference of disassembly at
least for me. Should I just pick 1~2 random use cases? or do you have
any suggestions?

Btw, are you talking about Online Compiler Explorer? I don't really know
what goldbolt means here, sorry XD .

Best regards,
I Hsin Cheng



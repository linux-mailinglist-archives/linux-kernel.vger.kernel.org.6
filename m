Return-Path: <linux-kernel+bounces-513791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 431B3A34EB7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF14188DC4A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F303624A057;
	Thu, 13 Feb 2025 19:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO7QDCEL"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5330245B05
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476472; cv=none; b=MNUAAM/pfc4QJKvm388LDjJ+kN6agusiq2S4cIychYnXnVm3ClaCae0XZJA6PN1rNv6lhnjSXc6Zef5WHtN6bA5wXuYLN5N0BVaUi6eGBHixGk0s1CM97KIDGuaSFHDn6pxnNQoAEkJ4D+oR3hNHeG32jRMtKeE3SV6rfNJx/DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476472; c=relaxed/simple;
	bh=5BQkpRyVYSfcyb9CTMv2NXIuU/asrygZfNiZc3+8dhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIwbRzuoxGLjmzNk6HFqFqt/zTflN3RB7MksgT4L40j46/SyKu9zsBF7MtxKWiJdUJPmsMSkVIDjEcD8652hZUbgE9Eu3hRL2aeUZko2NS2qlnWo0PC+62SlvHZaEyJav06QapdhUqhuzcm7seFXgc7L7REnZ7rmvPyq0T/fd4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO7QDCEL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220e989edb6so8733825ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739476470; x=1740081270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B3ySLHI4iFeLZR5Ten5dkpY/Jqs46fJKQx6AsYm1dyc=;
        b=SO7QDCELPxAitMzFsONqqnx6I0SDK/bJdc2hokjt4Ai3t5NMVVewpsFraVEJHV1eKZ
         PJtk0DudUZnREPb/B7q3/mrC0bguJXXG8kCZTtvZmZV0eD2muGX4GuhOz1gE/CK8j88l
         /bAQD4cxWhxVUg+ZFTCqbtRbTs8VIbYclrOY65IjTd9l53YsdLFxNysU9QWfgCbBa9Bj
         maloFYq7kabCeE9mRZy62cRQD3gDe8HUUi7s6a90aY78p+I9NV+ZkBICpMqa4RBW6jJo
         mwwMDwKoxsNGwypi7pr2AQOHWh+RzHCBq9Tgvc7QarDs9AlGiZ1q2WaOZWGnVex/vyoD
         GjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739476470; x=1740081270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3ySLHI4iFeLZR5Ten5dkpY/Jqs46fJKQx6AsYm1dyc=;
        b=Of5Xpr96e2XwAz1ld2+JJTACfERRzUtlbgdqKKILieU6PKnUWCzxRIEOzDXKhrTNHC
         EC+R9mDaDS/+2gkthZSLrW9Q41+tfjHkilYIuUDe3gj6MHa4oXe6ow3olgI3Sb1Hh7F+
         J17osAkEPg4Gx13llL+XmsKDG9l2zJrKgUxU8b01iVPXy3U2S2aLe4/qr4m2Yi3VFgjG
         2PjbH27VAQV8eJaLnCSyQOhvHc9veKmZ1LCu/OQYlhsiMrUiBsDkpqkvh7mYe87NoDLy
         rTp3AYFlWwgoztEjyLY8PoiFA0mfM9uoB7y/pIWiDFci96M706/6GD5fyXcumUlOp8qc
         O1Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWT4NZAHZJuSgQWMNWUju/oBM6iLoLOdHxDxdlaavlWk3VOA8UIqNICkJ22Y1O80kXVXAHmCIVHjwNK4q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywRy4aPMW08chL8uT55w0tDxBDwiCWvPorVXUfi8eGJOwwITKV
	BQRfHLHTrXBQ7gAGmvjGEkQ1OAoMPlXwT9EN519uOLpvRqhM0Eva
X-Gm-Gg: ASbGnctokGRTgjLt6+QsYmxMo4r+MBXFVKh2m1XrErfH/W+jkh4PQxRy9wdzmux4sII
	BvoSnVV28kwEK0hDyBvdyJffEKY0vsF2dUOelt/s7WaeRrSR/zZEYqxvb+iJtpgN+YPe82F4Yic
	pZfFfL6DMmXJwpAUv0g8slNzWLudMXcMLQn/4pcAqzpQdgCt/BjNGuPA8rZapU1jVYNX0BEFjVh
	3WDrpWOCol09ZMmwiT+6nTlnAcVhmz4cB53AaHD3zNea8wxbCcOwjb0aN783BqLHGsVEQGoVi+n
	EGik6IsLGUR4nHNscR4YxglFrUNWpQaRiabpIXY=
X-Google-Smtp-Source: AGHT+IEul0GbxV36jI6X+D85Z4/JV/MIqDf0jZeDrXfnayPCi9B2Kjj8Effog9JH9Ch7/vc7o8kWQQ==
X-Received: by 2002:a05:6a21:3a93:b0:1ea:db1d:99b with SMTP id adf61e73a8af0-1ee6b30cf39mr9329148637.3.1739476469870;
        Thu, 13 Feb 2025 11:54:29 -0800 (PST)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb5a52af2esm1567047a12.54.2025.02.13.11.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 11:54:29 -0800 (PST)
Date: Thu, 13 Feb 2025 14:54:27 -0500
From: Yury Norov <yury.norov@gmail.com>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: anshuman.khandual@arm.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw, skhan@linuxfoundation.org,
	Matthias Kaehlcke <mka@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] uapi: Refactor __GENMASK() for speed-up
Message-ID: <Z65N81jXcyKIu95l@thinkpad>
References: <20250211162412.477655-1-richard120310@gmail.com>
 <20250211162412.477655-2-richard120310@gmail.com>
 <Z6uZZPpQ9YYfrL-I@thinkpad>
 <Z6uaW9XzaKjSrWYC@thinkpad>
 <Z6ypqCN_KI2gaSJ4@vaxr-BM6660-BM6360>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6ypqCN_KI2gaSJ4@vaxr-BM6660-BM6360>

+ Andrew, Matthias

On Wed, Feb 12, 2025 at 10:01:12PM +0800, I Hsin Cheng wrote:
> On Tue, Feb 11, 2025 at 01:44:18PM -0500, Yury Norov wrote:
> > On Tue, Feb 11, 2025 at 01:39:34PM -0500, Yury Norov wrote:
> > > On Wed, Feb 12, 2025 at 12:24:11AM +0800, I Hsin Cheng wrote:
> > > > The calculation of "((~_UL(0)) - (_UL(1) << (l)) + 1)" is to generate a
> > > > bitmask with "l" trailing zeroes, which is equivalent to
> > > > "(~_UL(0) << (l))".
> > > 
> > > I used to think that GENMASK() is a compile-time macro. __GENMASK() is
> > > not, but it has very limited usage through the kernel, all in the uapi.
> > >  
> > > > Refactor the calculation so the number of arithmetic instruction will be
> > > > reduced from 3 to 1.
> > > 
> > > I'd like to look at it! Please share disassembly.
> > > 
> > > > Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> > > > ---
> > > > Test is done to show the speed-up we can get from reducing the number of
> > > > instruction. The test machine runs with 6.9.0-0-generic kernel on x86_64
> > > > architecture with processor AMD Ryzen 7 5700X3D 8-Core Processor.
> > > 
> > > So you CC arm maintainers and provide tests against x86_64. Are your
> > > improvements consistent for arm, power and other arches?
> > > 
> > > Can you run bloat-o-meter against your change?
> > 
> > Ah, sorry, overlooked you bloat-o-meter results in cover letter.
> > Anyways, can you provide it for each patch individually?
> 
> Oh ok, let me paste them here first, I'll attach them along with v2 as
> well.
> 
> In the section below, vmlinux_old uses old version of GENMASK() and
> GENMASK_ULL(), vmlinux_p1 use new version of GENMASK() and old version
> of GENMASK_ULL(), vmlinux_p2 use new version of GENMASK() and new
> version of GENMASK_ULL().
> 
> $ ./scripts/bloat-o-meter vmlinux_old vmlinux_p1
> add/remove: 0/2 grow/shrink: 46/505 up/down: 464/-1717 (-1253)

So, I ran the build myself and I confirm that reverting c32ee3d9abd284b4
(which this patch actually does) helps to save over 1k of .text. In my
case it's 1269 bytes on x86_64 + defconfig for GENMASK() only.

I looked at some functions affected by this revert, and I found that
they call for_each_*_cpu() macros. This eventually boils down to bitmap
functions like this:

  static __always_inline
  unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
                              unsigned long offset)
  {
          if (small_const_nbits(size)) {
                  unsigned long val;
  
                  if (unlikely(offset >= size))
                          return size;
  
                  val = *addr & GENMASK(size - 1, offset);
                  return val ? __ffs(val) : size;
          }   
  
          return _find_next_bit(addr, size, offset);
  }

The 'size' here is NR_CPUS, which on my machine is 64. 

GENMASK is used with non-constant parameters, but it's OK because
from compiler's point of view, the GENMASK_INPUT_CHECK() which is
just:
        BUILD_BUG_ON_ZERO(const_true((l) > (h)))

It is passed as the 'offset > size', and it's is indeed a constant
expression at that point because it's explicitly tested before.

Is this for_each_cpu() thing the only case - I don't know, but it's
enough to consider reverting back to the original version.

I Hsing,

At first, thank you for catching this up.

I think performance testing part is trivial here, so let's focus on
code generation and consistency.

Can you please run your build against few recent GCC and clang versions?
Can you also build the kernel for ARM64? You don't need to run it on
real hardware (but maybe on VM). I just need to make sure that the
result is consistent for all important arches.

Matthias didn't mention how did he build his kernel. Did clang emit
that warning against W=0, 1 or higher, and which code triggered the
warning? Maybe clang already fixed it?

Can you please check how would it work if NR_CPUS is set to be say 1024?
This way the small_const_nbits optimization will be disabled.

If you will find that clang still emits warnings at lower than W=2,
can you please resend this patches together with a patch that
suppresses clang warning?

Can you also please attach one or two examples of code generation for
real functions, not an artificial one as you did before. And maybe a
link to goldbolt?

For the next iteration can you please make sure that you refer your
series as a revert of Matthias's patch? 

Thank you for discovering this. I realize that I'm asking you to do
some extra work, but we all need to be 100% sure that it's not a fluke
before reverting the c32ee3d9abd284b4 because it potentially leads to
suppressing another clang warning.

Thanks,
Yury


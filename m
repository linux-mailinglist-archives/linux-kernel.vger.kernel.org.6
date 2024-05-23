Return-Path: <linux-kernel+bounces-188010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356C68CDBCB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538B21C22B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBEF127E0F;
	Thu, 23 May 2024 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Al+0OEOX"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77B02628D
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499082; cv=none; b=Ku27lcNDCr6l+snDpnP3W7YVT9XV+nmHNTj/cvIb9ue6sZQD9TT2+BpiLgXaUOYbPDtca0UWd1jgFQK0ORrCccv72IAZOImPnzZfZbYbmM+44OXtzgU0aqYD6m/swxbION+YTaRM+BXNASu1axMbPXJEDoc746SN9e58oO7jukU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499082; c=relaxed/simple;
	bh=Gpqhw/s2i2sLzZlRGqp7IZp6eytfKeTmUvdesErItAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwBh+MIBJFLauL8wV0n1zgLzXrjYty1uWW06yJ6I7y5Nh9R/yumS5CZSW/CCipfqiJpioHTm+u2Cb2Dh7yg9Q9WQWg8Vpj4HboU5h6Vc5WdSM9/nDmPIcunjalYj+2u8cW7xLqXG75dIKcufIy9hFvCp5vC6jZFPnW18Gp+Sj2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Al+0OEOX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f8ec7e054dso172760b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716499079; x=1717103879; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PwzV5tVaq2B4FjInYNNPwOPVrbWL6OWL1o9jsQ7m6BM=;
        b=Al+0OEOX6GH8RUjxGzOY0XowEd72FDBl0mXLDt3ygX/y/Xx4Jeju+F2YNS7CZyROiN
         si/WJ2YGWizRb/pCgeQFECSkp5HJ0LVc//YwImb3u605GKlP/y+81lrLHPcyxeh63HM7
         RRW7ObT4a01W0Icq8wsJ/h//oHGXAS4Np5CVcU4ipK1BuAzyaSWRvYUT5FYkWHbWvqdV
         +CAoipJur4L20cbPM6VxuIFMRalDFwf9ZPEOs2miqUflpMPfAPVq1NofjCC5rbv6LRTN
         ZnpALKiz9qlWWC9hRaeKquHQBScyZcTeYDA4oF9VFij6j4gp7YcP/Vdg7pwJIUsAo5UK
         PqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499079; x=1717103879;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PwzV5tVaq2B4FjInYNNPwOPVrbWL6OWL1o9jsQ7m6BM=;
        b=vOFe3ymZqESP93JXqp9oSEkjoxG3hOLTqBvROF1kw+rkDcSYdQmWjCHziBUKDbBCtL
         bZOUU+Hm/VBFVPgDIKrFpx59gYr0FLtDMBJYROQTf/uD8NTaIXMjxrmFXt01NuxG3d8E
         bXoA4ybCxmu5zBm3uVSkY7jHI5rA55hAK88eH059qAnwMUyIr9ItwET7F6KkeCHoo2kg
         Py9ntvBL/yw6+xenowbFqvvS4RBZF0dWrYbyjwoc4QSeBWFyey+ObfP76X/FzthuVpor
         nv56licnwkWObTUjObzy3DprP3z7g/KPw2zZ2dKtEzOOvZsC78paH+TzdEqCl2VkpoTL
         5IXg==
X-Forwarded-Encrypted: i=1; AJvYcCVGPifm9dSZJX8j/CZDri2Lis5Al7/rLZjQCgLwL+NzHkq2HacHFN2d4zwJhEN67gukbutrXfNEAyL1u9mqL7lKzZdE2Yjwi/hE7B/u
X-Gm-Message-State: AOJu0YwpOtnt9BdZyz6Sb0pDAwiDAyPjtf6lAh5Bgm/c49Tj61YZbQqu
	cgZNUa4AkYQt8NniOOxcZphA0cSkUgLu/f+cCYUHg7NxrFxRbYj+z8i6ylH7kWY=
X-Google-Smtp-Source: AGHT+IGx0rsWYFEjcfR9pAludyPkzfDLkr55TU0Ix9xIuJv5a2gL44nhGVX/9NJpqJnSBX4lthJzqA==
X-Received: by 2002:a05:6a20:5526:b0:1b1:c745:ea2c with SMTP id adf61e73a8af0-1b212e32cb1mr729638637.56.1716499078649;
        Thu, 23 May 2024 14:17:58 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd6d2811sm55732b3a.217.2024.05.23.14.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:17:57 -0700 (PDT)
Date: Thu, 23 May 2024 14:17:54 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Evan Green <evan@rivosinc.com>, Yangyu Chen <cyy@cyyself.name>,
	linux-riscv@lists.infradead.org, Elliott Hughes <enh@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: riscv: hwprobe: Clarify misaligned keys are
 values not bitmasks
Message-ID: <Zk+ygkJXUcW+H7Rl@ghost>
References: <tencent_9D721BDDF88C04DBB5151D57711D62524209@qq.com>
 <tencent_338DF690631BAE788C4CC858233E9FBAE006@qq.com>
 <CALs-HssGcNso6vTfbcsiWX1h_46jgDDRcEWcfZCTpxXYnubcng@mail.gmail.com>
 <20240522-d110bb16f54eebb725e943c2@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240522-d110bb16f54eebb725e943c2@orel>

On Wed, May 22, 2024 at 09:26:08AM +0200, Andrew Jones wrote:
> On Tue, May 21, 2024 at 11:36:06AM GMT, Evan Green wrote:
> > On Sat, May 18, 2024 at 9:00 AM Yangyu Chen <cyy@cyyself.name> wrote:
> > >
> > > The original documentation says hwprobe keys are bitmasks, but actually,
> > > they are values. This patch clarifies this to avoid confusion.
> > >
> > > Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> > 
> > Hm, we also have this problem in the code, since
> > hwprobe_key_is_bitmask() returns true for KEY_CPUPERF_0. This results
> > in wrong information being returned for queries using the WHICH_CPU
> > flag. If usermode asked for the set of CPUs that was specifically SLOW
> > or EMULATED, the returned cpuset would also include cpus that were
> > FAST. I believe all other queries are okay.
> > 
> > The one-liner fix is to just not return true for that key in
> > hwprobe_key_is_bitmask(). But that's technically user-visible: if some
> > software relied on the buggy behavior of FAST cpus being swept up in
> > the query for SLOW or EMULATED cpus, this change would expose that.
> > The grownups-eat-their-vegetables thing to do would be to define a new
> > key that returns this same value, but doesn't return true in
> > hwprobe_key_is_bitmask(). What do people think?
> 
> Even though I actually enjoy eating vegetables, I think it's unlikely
> that we need to be so cautious for this. I feel like kernel updates
> provide a bit of freedom to change results of hardware query syscalls,
> even when run on the same hardware. Particularly the EMULATED query,
> which I guess could change with a firmware update. And, even the SLOW
> query could change if the probing was modified directly or indirectly.
> IOW, applications that use the which-cpus syscall shouldn't freak out
> if they don't get the same cpuset after a kernel update, which means
> we can drop the FAST cpus from the result.

Dropping FAST does not really address the problem here. These keys are
being treated as a bitmap when they are in fact just values. Because
they are currently treated as bitmaps, it is semantically acceptable to
"or" two of the keys together and pass them into hwprobe. Dropping FAST
from the input of EMULATED | SLOW will make it appear to work, but it is
not reasonable to try to support or'ing of values that are not bitmaps. If a
key that maps to a value of 5 is ever introduced, then the input of
UNSUPPORTED | EMULATED will also return cpus that map to the new key.
If hwprobe recieves a value of 3 for CPUPERF_0 and or'ing is supported,
that could either be interpreted that the user is asking for cpus that are
EMULATED or SLOW or FAST, or just FAST, or just EMULATED or SLOW. The
current implementation defines that only FAST will be returned because
or'ing values like this is nonsense.

Allowing an input where keys are or'd together should not be supported
in CPUPERF_0 since it is what is causing this issue. However, the
original intent seems to be to allow an or'ing of keys. The verbosity of
using CPUPERF_0 will be greatly increased without the ability to or keys
together. If an application wants to know if misaligned accesses are
supported, it currently needs 3 separate hwprobe calls, one for each
EMULATED, SLOW, and FAST. Changing CPUPERF_0 to be a true bitmap would
require changing the values of each of the existing keys which is not an
acceptable API change.

In my previous email I proposed a new key, which could be something like
RISCV_HWPROBE_KEY_CPUPERF_1, that is actually a bitmap. That way a query
of EMULATED | SLOW | FAST would be possible in a single hwprobe call,
which seems to be the original intent of CPUPERF_0.

- Charlie


> 
> Thanks,
> drew
> 
> > 
> > -Evan
> > 
> > > ---
> > >  Documentation/arch/riscv/hwprobe.rst | 31 ++++++++++++++++------------
> > >  1 file changed, 18 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> > > index 239be63f5089..4abfa3f9fe44 100644
> > > --- a/Documentation/arch/riscv/hwprobe.rst
> > > +++ b/Documentation/arch/riscv/hwprobe.rst
> > > @@ -188,25 +188,30 @@ The following keys are defined:
> > >         manual starting from commit 95cf1f9 ("Add changes requested by Ved
> > >         during signoff")
> > >
> > > -* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
> > > +* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A value that contains performance
> > >    information about the selected set of processors.
> > >
> > > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
> > > -    scalar accesses is unknown.
> > > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_MASK`: The bitmask of the misaligned
> > > +    access performance field in the value of key `RISCV_HWPROBE_KEY_CPUPERF_0`.
> > >
> > > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned scalar accesses are
> > > -    emulated via software, either in or below the kernel.  These accesses are
> > > -    always extremely slow.
> > > +    The following values (not bitmasks) in this field are defined:
> > >
> > > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned scalar accesses are
> > > -    slower than equivalent byte accesses.  Misaligned accesses may be supported
> > > -    directly in hardware, or trapped and emulated by software.
> > > +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
> > > +      scalar accesses is unknown.
> > >
> > > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned scalar accesses are
> > > -    faster than equivalent byte accesses.
> > > +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned scalar accesses are
> > > +      emulated via software, either in or below the kernel.  These accesses are
> > > +      always extremely slow.
> > >
> > > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned scalar accesses
> > > -    are not supported at all and will generate a misaligned address fault.
> > > +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned scalar accesses are
> > > +      slower than equivalent byte accesses.  Misaligned accesses may be supported
> > > +      directly in hardware, or trapped and emulated by software.
> > > +
> > > +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned scalar accesses are
> > > +      faster than equivalent byte accesses.
> > > +
> > > +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned scalar accesses
> > > +      are not supported at all and will generate a misaligned address fault.
> > >
> > >  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
> > >    represents the size of the Zicboz block in bytes.
> > > --
> > > 2.43.0
> > >


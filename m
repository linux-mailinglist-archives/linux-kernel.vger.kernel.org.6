Return-Path: <linux-kernel+bounces-285403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9F6950D00
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416021F255B8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE151A01A1;
	Tue, 13 Aug 2024 19:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="R0rK46Ma"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957101A2C15
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576547; cv=none; b=uYwaH5RljaQDTzDPzf8lU/llzEoU9ioLop6oA1W0bwAqqynXMchja9oIPCADKBsQjkWtzjZBUUiPC2Szi3Bln1v9wGcLHTu8nR7LPBDDTtXfQNZsboeiI+rxFg63y65hDGZHXT/nmR7FOWA9XC5LA+F9zbKKWLuJH5V4wWwifGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576547; c=relaxed/simple;
	bh=toz2rrC0HiyT+Eb8eF0RQri9CoHa+oL7p0JRb3stXx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqsEcuono8Mg055LbMwdYQ8sps/aoVCPNAC4sqbMP7zAefsyXq8j7V/Q7IX+qh9DMFmsH4yt+Yo/Q8ojdpwDsM2c0lzLf5dhMpI6NGZjxq0oExbiE5slGBTThxQs90dCLgbL3VJDTsObyZ1ZnLBvEhFjuP/qmFRuXm0Zlbs6N0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=R0rK46Ma; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d2ae44790so4214311b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723576545; x=1724181345; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=upO19SozBGW3wqb+VTuxXAbPoh43oKi0VkEemu0qAIE=;
        b=R0rK46Ma+R1P5JMI/lSLP7ue9SwZQ4yYNjK3oHHdISnWADJrkZxvzDIPvoPP4J5Xl2
         gApT3oos5doN0XIM8iUyQf7VbKlybcl02UCDoa3WohnO+GCHsnkTRNyOP5idWDtQO5CL
         wjZ0RD0bBznPwMY1O4HVX9lmJC0+6u4IjwFIzXlhi6YDOGunmTEQtTRFPzz4nsPNDNth
         DMpYBIQjph8rurXBmoZNo0r/Uh8P00rA75GwMQPTHr8eB4RhWlU2VI2ddLnWdt39/ops
         74Pv4lsWnnyATTZspr6ht/Mr6IQLNPZ8EoIzWDzjJeuSk460Yinbe46YGlMlM1dFZA3T
         6IBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723576545; x=1724181345;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upO19SozBGW3wqb+VTuxXAbPoh43oKi0VkEemu0qAIE=;
        b=LEFftePO+hJ2qJ7QEBuPLbryu/fR79KeqqXaF11GYEpvAMzBwrdwU721j8GXKBtF07
         uucWpQK4vLi0vKoOGenUbb7dVxNOr7ccjTw+ZEMQLLy5hqTnUlTjYkK7EB5ADwUxhZ5B
         JB/DXncUIIq8y8g4NOQRFOt+36oT1+ZgYpWYOqFQgEJu5se2WI870e7WUAMTwzBgur1e
         kIFoIlfpWTQBB5U+AJmeFjnc++5f2ywqzFxP38mBkREGXKsnJZuHb5zOmC/Girc3aFSm
         cHz5XFGMuxCug5kEPp78sO8TUUa3Du7t9i4v45kYdXIpzBqyM4vzqniKyziegd+Vy6ZF
         pmYw==
X-Forwarded-Encrypted: i=1; AJvYcCU6L/ENqQO7cO3s9X0XOq2xqrGJp5BCOBsnR257wZhZXM+Ujmh8Qn7UWkSHd+RagiEDdkag9kT9vO0SJ0gDezT3Ug5cJJO0h43Oiv1t
X-Gm-Message-State: AOJu0YwPMLlTeeFneLu9h8qLIBbIrTQvmxpc25ERZsbshrOYM/givpUk
	AZrp7wUgtCKDo9Zjw9DkMJbsjoWwTPoIxi2SXz4dIE0plcjp9Spt1NPbRNM6Jmk=
X-Google-Smtp-Source: AGHT+IHkE8ev8c9ixTOpOS8k+f7v59VeVKfF+Zqcm+gC19sVxa1p6KC0GWQGsDmZo9DB9KuLB8MPgg==
X-Received: by 2002:a05:6a00:2383:b0:70e:9408:fc34 with SMTP id d2e1a72fcca58-712671037a2mr688748b3a.7.1723576544561;
        Tue, 13 Aug 2024 12:15:44 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5873864sm6051385b3a.35.2024.08.13.12.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:15:44 -0700 (PDT)
Date: Tue, 13 Aug 2024 12:15:41 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: "Wu, Fei" <fei2.wu@intel.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, guoren@kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: Re: riscv syscall performance regression
Message-ID: <Zruw3dUAYb3zcxaV@ghost>
References: <738d3b74-1e10-4eb5-8c0d-1db33feb740a@intel.com>
 <28cf8a77-e9af-45e4-b178-fd7a478f9b4c@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28cf8a77-e9af-45e4-b178-fd7a478f9b4c@ghiti.fr>

On Tue, Aug 13, 2024 at 02:51:09PM +0200, Alexandre Ghiti wrote:
> Hi Fei,
> 
> On 23/02/2024 06:28, Wu, Fei wrote:
> > Hi All,
> > 
> > I am doing some performance regression testing on a sophgo machine, the
> > unixbench syscall benchmark drops 14% from 6.1 to 6.6. This change
> > should be due to commit f0bddf50 riscv: entry: Convert to generic entry.
> > I know it's a tradeoff, just checking if it's been discussed already and
> > any improvement can be done.
> > 
> > The unixbench benchmark I used is:
> > 	$ ./syscall 10 getpid
> > 
> > The dynamic instruction count per syscall is increased from ~200 to
> > ~250, this should be the key factor so I switch to test it on system
> > QEMU to avoid porting different versions on sophgo, and use plugin
> > libinsn.so to count the instructions. There are a few background noises
> > during test but the impact should be limited. This is dyninst count per
> > syscall I got:
> > 
> > * commit d0db02c6 (right before the change): ~200
> > * commit f0bddf50 (the change): ~250
> > * commit ffd2cb6b (latest upstream): ~250
> > 
> > Any comment?
> > 
> > Thanks,
> > Fei.
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> 
> So I finally took some time to look into this. Indeed the conversion to the
> generic entry introduced the overhead you observe.
> 
> The numbers I get are similar:
> 
> * commit d0db02c6 (right before the change): 185
> 
> *  6.11-rc3: 245
> 
> I dived a bit deeper and noticed that we could regain ~40 instructions by
> inlining syscall_exit_to_user_mode() and do_trap_ecall_u():
> 
> - we used to intercept the syscall trap but now it's dealt with in the
> exception vector, not sure if we can inline do_trap_ecall_u()
> - I quickly tried to inline syscall_exit_to_user_mode() but it pulls quite a
> few functions and I failed to do so.
> 
> Note that a recent effort already inlined most of the common entry functions
> already
> https://lore.kernel.org/all/20231218074520.1998026-1-svens@linux.ibm.com/
> 
> The remaining instructions are caused by:
> 
> * the vector extension handling. It won't improve the above numbers because
> the test does not use the vector extension, but we could improve
> __riscv_v_vstate_discard() as mentioned in commit 9657e9b7d253 ("riscv:
> Discard vector state on syscalls")
> * the random kernel stack offset
> 
> I'll add some performance regressions in my CI in the near future :)
> 
> Thanks,
> 
> Alex

I have written patches to do this inlining but haven't sent it out yet.
I don't know a good way of showing performance improvement so I have
been hesistant to send it. It is generic so showing the improvement on
x86 is probably the best. I have also written some patches for cleaning
up some of the other syscall handling but again haven't been able to
show performance numbers. I was going to use a thead board but was
unable to get it to boot on an up-to-date kernel as I posted about here
[1]. The patches here [2] should also show improvements.

I can try to get some numbers and send out the patches.

Link: https://lore.kernel.org/linux-arm-kernel/ZoydV7vad5JWIcZb@ghost/
[1]
Link:
https://patchwork.kernel.org/project/linux-riscv/cover/20240720171232.1753-1-jszhang@kernel.org/
[2]

- Charlie

> 
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


Return-Path: <linux-kernel+bounces-565790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43D9A66F33
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807243A9DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB891F866A;
	Tue, 18 Mar 2025 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cMz/KWHd"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457B842AB4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742288451; cv=none; b=mtlrzjPCK+SiVxwRRVjDPLCfl1IL05I+o0F0vsa8uPrOgtT1ky0XgvQBjWy8EcHHuBjY6lXpDXpiRaIUMiV64lX9vxFIJeC6sMt2ufCGF+Yv1dd4FXBmflFMTk5+L4kil6D9IFPS4hHlQv+OkNMAvBsCPS+nkTzWNSZLN/+itAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742288451; c=relaxed/simple;
	bh=auc9jjfBR0pJGmOxvxfAmYDcKoS37G5b9kYn+O7PffE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJQp+uCV2dzK7kIEsysjIndXGeP5gWtai69RH2NI4VQwCHGJ6DVLnes6g8zZBKxm5LDz9YIqW0FU3DePLBjVwnU01ZsXzUXxv+kaxiiRuZM5stMukh/FJ5GCSzf0tsXFQh8vgQ2xiM1Z3iSyfWp663jwSyn5MOVHJPKzHRCsda8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=cMz/KWHd; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso9115409a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742288447; x=1742893247; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wr4dUiqaKywBCUa33frJJ04baPImRwSaV0A/LlSiREE=;
        b=cMz/KWHd06iaaU/MRfvfXUXeeF66lHNq75wWkopvw92M60yU4TzpwP0h2hu+IXiM14
         k/6WS2kR2sa/X1n/fvtTMn+4Oci8jRpkAsQ5rAekYBGNmrzTh4x1AFWt8Y9K2xWkf0a1
         5FkX2rx+UngHAhWuo9D1Qpg4sqoDC9/rVYEG6CBAsDyCHnHNbi++DGqcoTmYkuXBqOqW
         XI1K8b2+XNGlOEdIy5yRQgLYRUTqkwInW4zbokrx0Dp7sAD9rGcaznSn14CdTrneZN4w
         H3V1qADY+pCwaZfQRbcBMT42LLXHsd1zB7MDX0V1qSg8YwkRq4ogGldiObTHYMXv/CFi
         j02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742288447; x=1742893247;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wr4dUiqaKywBCUa33frJJ04baPImRwSaV0A/LlSiREE=;
        b=LQfPmcRfk/E8phMlTmd6MyagmDOKiBz1oX7dlxFCvPieWdmX/w/Hsqp2KiUVpsIVgw
         SWZ/r0Tkg4Cx/HEXFYszKbvDevVxWkWjX1Wb4Dxsn+sJtqPzV5cHgL+lUUgcb9M+jBIE
         QOuc2cfzVh9LEouJj+7LCoFakYYUeupe/xMidkdWvVKl4Ubgpe+hv9Tmt14yxk+LlAQx
         sBNSRLIlYxcZUyNByC/VhKt3GbvyOVTcfA6apR96ZuU4hhZkTc1bawEzm5g6off/OAxO
         0wE5K5w7ZEPvwXOUJFDkqmviwZQC41sBvMxzc3cGj/x4T4vGz7K4FS2DjKgA+/cHjaBs
         QSew==
X-Forwarded-Encrypted: i=1; AJvYcCXgUfOCxW8MbD2ljIlnVGUvOjzYGvUr0+foTeNhwPYOO5jzXgg9JUgzGP2/Ey47JjJifBZwQPWf+6kdRLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2xlnc8C4+m6ACBClAYtVtg37tCEJDxFkwFmGWyBugRN9wVp+a
	+nYhien9d0SpE5eghfnp3+AQ7ywIjz5nu7ba6NAPIOtB/IohtpF1am8Uv0RCamA=
X-Gm-Gg: ASbGncsew1+N42gyeghLCvJOOilwjQJW7uPPY3FztS/wxv1v+7J9RJ0kTt0NaKF66+e
	xmkgCxn3EyBL+W4MmDE3s2r/agjMKJT4UikS/r1PhCiitHhsySvhsfj33IckNvgMVaHuniKKocj
	8Dml9WVx2uI6xBYkE8PTWSGgF0WN2VZGpqFSGl3OiMKESQD7g7RaKpyAE15qtTiQJkNIcst1Q/9
	Z6DdxNypj92i+oJ448WOdA4goQibJ5z168DU9+/dRBEpdH0EXycbTDifNQlnISHopfRmjpTdFto
	ZRNHmyyH03rstY/nIHP+74WapLdZgsH9420Y9c1+Ieg=
X-Google-Smtp-Source: AGHT+IGBsklbulm+vYAotQHhh8oVdp47PW9k6WK8XOOUPLWd/0Ehy9b34njTBzMzUsYjAPB/A6Vdow==
X-Received: by 2002:a05:6402:51ca:b0:5dc:c943:7b6 with SMTP id 4fb4d7f45d1cf-5eb1dec1a1bmr2420615a12.3.1742288447279;
        Tue, 18 Mar 2025 02:00:47 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::59a5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816977a5fsm7228660a12.32.2025.03.18.02.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 02:00:46 -0700 (PDT)
Date: Tue, 18 Mar 2025 10:00:46 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	charlie@rivosinc.com, cleger@rivosinc.com, Anup Patel <apatel@ventanamicro.com>, 
	corbet@lwn.net
Subject: Re: [PATCH v3 7/8] riscv: Add parameter for skipping access speed
 tests
Message-ID: <20250318-61be6a5455ea164b45d6dc64@orel>
References: <20250304120014.143628-10-ajones@ventanamicro.com>
 <20250304120014.143628-17-ajones@ventanamicro.com>
 <1b7e3d0f-0526-4afb-9f7a-2695e4166a9b@ghiti.fr>
 <20250318-1b03e58fe508b077e5d38233@orel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250318-1b03e58fe508b077e5d38233@orel>

On Tue, Mar 18, 2025 at 09:48:21AM +0100, Andrew Jones wrote:
> On Mon, Mar 17, 2025 at 03:39:01PM +0100, Alexandre Ghiti wrote:
> > Hi Drew,
> > 
> > On 04/03/2025 13:00, Andrew Jones wrote:
> > > Allow skipping scalar and vector unaligned access speed tests. This
> > > is useful for testing alternative code paths and to skip the tests in
> > > environments where they run too slowly. All CPUs must have the same
> > > unaligned access speed.
> > 
> > I'm not a big fan of the command line parameter, this is not where we should
> > push uarch decisions because there could be many other in the future, the
> > best solution to me should be in DT/ACPI and since the DT folks, according
> > to Palmer, shut down this solution, it remains using an extension.
> > 
> > I have been reading a bit about unaligned accesses. Zicclsm was described as
> > "Even though mandated, misaligned loads and stores might execute extremely
> > slowly. Standard software distributions should assume their existence only
> > for correctness, not for performance." in rva20/22 but *not* in rva23. So
> > what about using this "hole" and consider that a platform that *advertises*
> > Zicclsm means its unaligned accesses are fast? After internal discussion, It
> > actually does not make sense to advertise Zicclsm if the platform accesses
> > are slow right?
> 
> This topic pops up every so often, including in yesterday's server
> platform TG call. In that call, and, afaict, every other time it has
> popped up, the result is to reiterate that ISA extensions never say
> anything about performance. So, Zicclsm will never mean fast and we
> won't likely be able to add any extension that does.
> 
> > 
> > arm64 for example considers that armv8 has fast unaligned accesses and can
> > then enable HAVE_EFFICIENT_ALIGNED_ACCESS in the kernel, even though some
> > uarchs are slow. Distros will very likely use rva23 as baseline so they will
> > enable Zicclsm which would allow us to take advantage of this too, without
> > this, we lose a lot of perf improvement in the kernel, see
> > https://lore.kernel.org/lkml/20231225044207.3821-1-jszhang@kernel.org/.
> > 
> > Or we could have a new named feature for this, even though it's weird to
> > have a named feature which would basically  mean "Zicclsm is fast". We don't
> > have, for example, a named feature to say "Zicboz is fast" but given the
> > vague wording in the profile spec, maybe we can ask for one in that case?
> > 
> > Sorry for the late review and for triggering this debate...
> 
> No problem, let's try to pick the best option. I'll try listing all the
> options and there pros/cons.
> 
> 1. Leave as is, which is to always probe
>    pro: Nothing to do
>    con: Not ideal in all environments
> 
> 2. New DT/ACPI description
>    pro: Describing whether or not misaligned accesses are implemented in
>         HW (which presumably means fast) is something that should be done
> 	in HW descriptions
>    con: We'll need to live with probing until we can get the descriptions
>         defined, which may be never if there's too much opposition
> 
> 3. Command line
>    pro: Easy and serves its purpose, which is to skip probing in the
>         environments where probing is not desired
>    con: Yet another command line option (which we may want to deprecate
>         someday)
> 
> 4. New ISA extension
>    pro: Easy to add to HW descriptions
>    con: Not likely to get it through ratification
> 
> 5. New SBI FWFT feature
>    pro: Probably easier to get through ratification than an ISA extension
>    con: Instead of probing, kernel would have to ask SBI -- would that
>         even be faster? Will all the environments that want to skip
> 	probing even have a complete SBI?
> 
> 6. ??

I forgot one, which was v1 of this series and already rejected,

 6. Use ID registers
    pro: None of the above cons, including the main con with the command
         line, which is that there could be many other decisions in the
	 future, implying we could need many more command line options.
    con: A slippery slope. We don't want to open the door to
         features-by-idregs. (However, we can at least always close the
	 door again if better mechanisms become available. Command
	 lines would need to be deprecated, but feature-by-idreg code
	 can just be deleted.)

Thanks,
drew

> 
> I'm voting for (3), which is why I posted this patchset, but I'm happy
> to hear other votes or other proposals and discuss.
> 
> Thanks,
> drew


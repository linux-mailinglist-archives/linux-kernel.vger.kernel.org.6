Return-Path: <linux-kernel+bounces-448360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8B09F3F42
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D28188AED9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92782156230;
	Tue, 17 Dec 2024 00:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEK6fhmj"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEAF14F108;
	Tue, 17 Dec 2024 00:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734396057; cv=none; b=SKVVIGyBauOs+SF6xaSDDFGU8OPJAMvpw5NX4UbpSW4FkXbiHFuE0WIlbBCjcy1dU4gTtpZ0u7m32MajuDQVkiYklxiTQGC/AanPNa63wgXzWG3DxcjQ74Uoeh29LwwcI7cUd8hE33mL2iDZmEzOFdoU0sr0uwHtO8aA1R76PWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734396057; c=relaxed/simple;
	bh=247vX3QT5EtTl1GXu6dgkLQz7nrsHcyczBjG8kxwV68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEUMaowbIgwBqKL+KtSB0yOrAbr6vDfINjvmn8rMqpZiL2Tkmfv8WxJxg+OVLNNqRRL7EyURTR6XWY7phRb9/ITF7ki+cAaMXubhf0sgNrvbfN++s9yO5+IuH/RwM4XvKtp4lXSHHlyc99tcA0hBakfbO8fKSmkG03RWEo3jngQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEK6fhmj; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d8fd060e27so40349646d6.1;
        Mon, 16 Dec 2024 16:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734396055; x=1735000855; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0/Cbl6nhU596TlRfXtw+zhpPruCALp8m+NWfU1RZMcs=;
        b=gEK6fhmjR5GQE+NNs8nD/tWCmHTS7rlVVrOFPaa5QpES+QYrQ6bX13WnSn19KpkXfh
         A0R0IzPwIhC6jhsUGRHozSfIaNY6evNRDylLc3kVfyDWGZZjrpWvqZvo0gIlFPCRPbOY
         MWDFOA3scy7Ws3of1UKI2EugS0ejoPZ9Xi9J1xhBnfd9LyARBxlzUOi/bkNuaNncg0ze
         rRlYfLwUV+2fjQK2xo23XURmjtmy8HS6aFejiF3kzJbud+tfdDqRLhwn6+6nB4d47uxF
         dumBeXeEAm+MAsJCoQIJrR9neKQLa0kRBFckutb24YnE5OMzsGUjTvWDmQjtbT9Cdhrb
         Vz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734396055; x=1735000855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/Cbl6nhU596TlRfXtw+zhpPruCALp8m+NWfU1RZMcs=;
        b=Ou8yQFNLTC1VtXHWn4EPb71CzEpHOjvG7yofIHAODa7BS42AplFlq3CJDC1WDnMFVQ
         4a0XNsIY5/hBxeCAAkjr+y0BCLU+DXdI9o6yBHI7SnJs25PV2EDGWqoRCgm67cJ67Ajg
         xjadL4ntmyFgvhUIfxbnwo0PRuTVxVrJu2zAgrUFueRVrsCfqVeADa3GzztG211piANj
         +RsGAjXu76ArSMIGdC3d6QwNwYMVBNLbzAnwxCvPVWYsGU7i2qGY9seOzjR3H8gtpybq
         PUrcKc9PIZgbHo7rNDxlKSA9h+ZMHEDvMQw9XrbJz2YET2SNJYqcPJ4wmaZwjcEATTay
         ao1w==
X-Forwarded-Encrypted: i=1; AJvYcCUQoxR90ObR/bKkmyX8FLuh2Pta3uzvWLUul7H7vG93f52z/JZbxh8LMpZ3yzd6a7WQXwBxP/O0DkOg1jTy@vger.kernel.org, AJvYcCVN5H/PeY0tFQZwn/liwHEirk2Zpjmx9L6vAtrfp7R9cQS3fVC41loXIow12tVRG/jKkGniDTeoxbwm@vger.kernel.org
X-Gm-Message-State: AOJu0YwUIk/r+JR/DxsXxzGZnIFtpQAt0JSq4C5aXCrCflTJhDWFZEAU
	JDOYNb45EROzf7mdPCF6R1jtoxeV/QDhD2iVCJiA30ElIPIA3MtL
X-Gm-Gg: ASbGncvJQleoqu8mv6D7PMxi6+LKWfMcmTB6M2NsXk5M/oZkCplvokkFLExpfICQWap
	RwEDD823bWe/P78b709RUG+SgG0HrmQ0ba0YAOwv/DJQ8DB7t4cFT+PdhMg1ee5KTxrap5OA+Nb
	ACnkUyV6sKz/8iexHmOkeuIWL0dHB9w4Q92Hf2fc7zZImF5s9tswzxqXuHvbnS1NCk0nj2Vi/cY
	0FjukGxd4EtqOMzGHM5DPSf750Poj72
X-Google-Smtp-Source: AGHT+IFjlHavhWPup7PYJT9N7NM8bEbqLWCujII2gri7ZdjsWeFP1Oce1YQLQy+5HsbVwzgWEwWqJg==
X-Received: by 2002:a05:6214:2123:b0:6d8:a1fe:7293 with SMTP id 6a1803df08f44-6dc9686b652mr266239766d6.42.1734396054914;
        Mon, 16 Dec 2024 16:40:54 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd257215sm33097316d6.41.2024.12.16.16.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 16:40:54 -0800 (PST)
Date: Tue, 17 Dec 2024 08:40:37 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Yangyu Chen <cyy@cyyself.name>, Inochi Amaoto <inochiama@gmail.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Evan Green <evan@rivosinc.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Jesse Taube <jesse@rivosinc.com>, Andy Chiu <andybnac@gmail.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v3 3/3] riscv: hwprobe: export bfloat16 ISA extension
Message-ID: <sh3fu66fltjccbygbdxilbos4bi5wqk2cdiihc6ixnodsbxtox@rezkyqnpp5yv>
References: <20241206055829.1059293-1-inochiama@gmail.com>
 <20241206055829.1059293-4-inochiama@gmail.com>
 <tencent_8F35B6F07D09566A873982E0E2C76085280A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_8F35B6F07D09566A873982E0E2C76085280A@qq.com>

On Tue, Dec 17, 2024 at 12:00:23AM +0800, Yangyu Chen wrote:
> Possible conflict with: https://lore.kernel.org/linux-riscv/20241111-v5_user_cfi_series-v8-22-dce14aa30207@rivosinc.com/
> 

Yeah, I know the conflict. As the time of merging these patch is
uncertain, what I can do now is to match the upstream code.

Regards,
Inochi

> On 12/6/24 13:58, Inochi Amaoto wrote:
> > Export Zfbmin, Zvfbfmin, Zvfbfwma ISA extension through hwprobe.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > Reviewed-by: Clément Léger <cleger@rivosinc.com>
> > ---
> >   Documentation/arch/riscv/hwprobe.rst  | 12 ++++++++++++
> >   arch/riscv/include/uapi/asm/hwprobe.h |  3 +++
> >   arch/riscv/kernel/sys_hwprobe.c       |  3 +++
> >   3 files changed, 18 insertions(+)
> > 
> > diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> > index 955fbcd19ce9..a9cb40e407a4 100644
> > --- a/Documentation/arch/riscv/hwprobe.rst
> > +++ b/Documentation/arch/riscv/hwprobe.rst
> > @@ -242,6 +242,18 @@ The following keys are defined:
> >     * :c:macro:`RISCV_HWPROBE_EXT_SUPM`: The Supm extension is supported as
> >          defined in version 1.0 of the RISC-V Pointer Masking extensions.
> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZFBFMIN`: The Zfbfmin extension is supported as
> > +       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
> > +       ("Added Chapter title to BF16").
> > +
> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZVFBFMIN`: The Zvfbfmin extension is supported as
> > +       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
> > +       ("Added Chapter title to BF16").
> > +
> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZVFBFWMA`: The Zvfbfwma extension is supported as
> > +       defined in the RISC-V ISA manual starting from commit 4dc23d6229de
> > +       ("Added Chapter title to BF16").
> > +
> >   * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated.  Returns similar values to
> >        :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`, but the key was
> >        mistakenly classified as a bitmask rather than a value.
> > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> > index 3af142b99f77..aecc1c800d54 100644
> > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > @@ -73,6 +73,9 @@ struct riscv_hwprobe {
> >   #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
> >   #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
> >   #define		RISCV_HWPROBE_EXT_SUPM		(1ULL << 49)
> > +#define		RISCV_HWPROBE_EXT_ZFBFMIN	(1ULL << 50)
> > +#define		RISCV_HWPROBE_EXT_ZVFBFMIN	(1ULL << 51)
> > +#define		RISCV_HWPROBE_EXT_ZVFBFWMA	(1ULL << 52)
> >   #define RISCV_HWPROBE_KEY_CPUPERF_0	5
> >   #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
> >   #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
> > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> > index cb93adfffc48..bd215f58bd1b 100644
> > --- a/arch/riscv/kernel/sys_hwprobe.c
> > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > @@ -131,6 +131,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
> >   			EXT_KEY(ZVE64D);
> >   			EXT_KEY(ZVE64F);
> >   			EXT_KEY(ZVE64X);
> > +			EXT_KEY(ZVFBFMIN);
> > +			EXT_KEY(ZVFBFWMA);
> >   			EXT_KEY(ZVFH);
> >   			EXT_KEY(ZVFHMIN);
> >   			EXT_KEY(ZVKB);
> > @@ -147,6 +149,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
> >   			EXT_KEY(ZCD);
> >   			EXT_KEY(ZCF);
> >   			EXT_KEY(ZFA);
> > +			EXT_KEY(ZFBFMIN);
> >   			EXT_KEY(ZFH);
> >   			EXT_KEY(ZFHMIN);
> >   		}
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


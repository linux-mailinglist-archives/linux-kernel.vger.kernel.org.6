Return-Path: <linux-kernel+bounces-197439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F016C8D6A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 22:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ABCC1F2513F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CC68061C;
	Fri, 31 May 2024 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AHiGC7eu"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD0F7442D
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 20:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717186760; cv=none; b=Xe2r2Xd9Fd42Sf2gDFhwWs7MPWP5EnmZwRjkxJ7f2gJeM1ZHWOypkE9GYVD04TGwo/Wk6urrFe2CODRtvP3xzGcux+QUvDyNH+1X7biXAesgn5+NQl5wD1iC4XyjZMAiEoDC1LOfELRmlM5oMIQyQn4TIxlSRh/yXtqxo3Fv3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717186760; c=relaxed/simple;
	bh=shft3RVwUwjo21em7Y9Em5jABEKo/Olm3NJpZmv8t2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cP8njcf51gTDoeCzubcu/0woeaJKKQ8lOoNbO3+shziPa6Eq15Oc1Z+oZmb9hanRQz4ejmvUX7GbSfyqW8lw7MQ7NBqigUgHu1FsKflGaYdwr0pOVll5DVyAXYLWNpCFbSZoiuR3rejc9G+9KEmsOHHNxzAXcbiRTS3KnWnF8UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=AHiGC7eu; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-702492172e3so959335b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 13:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717186758; x=1717791558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qAGjhFHnXf9IpViW/yMwbiFI16GqjUPhP70I5dCooFE=;
        b=AHiGC7euoV7P+iTbqWHS2nUYTzA6Fogz/HrYYUFYNjd98XC62IfTYzftwgtZwLQiit
         kb0riIeBIA4timmDEpfpnDZS/DB2TVGU+Nq2L8LtVYxbQUVMUsmKvgvgWpDeZ1UnrQiy
         QhMoxtulS/1Eejl+8n4aTVTap2IY0KLG+xj0jvI3NRGjsRIsfw9dBiCQ2mKpGvECYJCn
         kne8FvUYsK8Iy6eYkeYhhuS6hAW1plMf/OGJMmR82pAl/uamNLm2QhjE62/8L36xRqIs
         H1ev6akFVb+0trO2Mil/75cYHDlRGJlaHAGauhiB0vJ5gIGnwM8kduCzU4v97dujErYb
         nKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717186758; x=1717791558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAGjhFHnXf9IpViW/yMwbiFI16GqjUPhP70I5dCooFE=;
        b=vxRFW8jdMFUI2y1DY1ZOw3AazMkgo6uxiRobhFkkBOd0hsm2sJk8RBCNA2OL0ECw6V
         SIWgF9VLqEmT3Et+bXcz7ExVFcnbie5lyDqx13iS99rD9wnLHSuu6A1rTSp2awB90pVI
         lVzIlD5a3eNxh4pc4kkPKAoNbUfTgXqxF0OD9pcqTECMdI8Zfrl047HIBlRHmWRZlRzU
         1jNdlbmqReuOeAx17+FYfmK2vodv5TF2c1KvyS85SW3aLwVro1VOj3P6u0gsiD1oEFqG
         b3zzTVHZB4e6MKn89EwJYm2bZag+h8c2cx+I93DicZjPYJkJ+ThI8wNZNTaFtPu8fO9S
         5vqg==
X-Forwarded-Encrypted: i=1; AJvYcCUp1SMsIWp0grTZYvnh0pS5ITmgpiSmtJobDpnuTTXuqFbGbN+sBM46gQ0Q0f1t7ztasSoSvmnb7JUl4DSUw3//p0O7PSuq4t+SUVsF
X-Gm-Message-State: AOJu0Yy9rM0dlyVMxs7v1pMG5nt36q55R1YMmPTVhx+GfD4Om72TjFp2
	YOzt7dLNAkOrmJVPx0LtIKV7a6IVLai11AKHWNkSjsqVP+bB5HNXrEDDuRLRca4=
X-Google-Smtp-Source: AGHT+IGVzy3+vOIUubWLHwauUWb5Skr6TuZH88CsARiNo0nv/hRvULtFg2uHbqI0Wo/CnlmesOhwIw==
X-Received: by 2002:a05:6a00:198d:b0:6f0:b53c:dfb4 with SMTP id d2e1a72fcca58-7024788e80bmr3955148b3a.22.1717186757959;
        Fri, 31 May 2024 13:19:17 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:4d3b:392b:5722:91c1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242c245absm1745251b3a.200.2024.05.31.13.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 13:19:17 -0700 (PDT)
Date: Fri, 31 May 2024 13:19:14 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v0] RISC-V: Use Zkr to seed KASLR base address
Message-ID: <ZlowwohstpT0sJVl@ghost>
References: <20240531162327.2436962-1-jesse@rivosinc.com>
 <20240531-uselessly-spied-262ecf44e694@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531-uselessly-spied-262ecf44e694@spud>

On Fri, May 31, 2024 at 06:31:09PM +0100, Conor Dooley wrote:
> On Fri, May 31, 2024 at 12:23:27PM -0400, Jesse Taube wrote:
> > Dectect the Zkr extension and use it to seed the kernel base address.
> > 
> > Detection of the extension can not be done in the typical fashion, as
> > this is very early in the boot process. Instead, add a trap handler
> > and run it to see if the extension is present.
> 
> You can't rely on the lack of a trap meaning that Zkr is present unless
> you know that the platform implements Ssstrict. The CSR with that number
> could do anything if not Ssstrict compliant, so this approach gets a
> nak from me. Unfortunately, Ssstrict doesn't provide a way to detect
> it, so you're stuck with getting that information from firmware.

The Scalar Cryptography v1.0.1 spec says "If Zkr is not implemented, the
[s,u]seed bits must be hardwired to zero". It also says "Without the
corresponding access control bit set to 1, any attempted access to seed
from U, S, or HS modes will raise an illegal instruction exception."

There is a slight nuance here as the definition of Ssstrict is:

"No non-conforming extensions are present. Attempts to execute
unimplemented opcodes or access unimplemented CSRs in the standard or
reserved encoding spaces raises an illegal instruction exception that
results in a contained trap to the supervisor-mode trap handler."

The trap that Jesse is relying on in the code here is related to access
bits and not related to the CSR being unimplemented. Since the access
bits are required to be 0 on an implementation without Zkr, it is
required to trap if seed is accessed, regardless of Ssstrict.

The situation here is slightly odd because the spec is defining behavior
for what to do if the extension is not supported, and requires
implementations to follow this aspect of the Scalar Cryptography spec
even though they may not implement any of the instructions in the spec.

> 
> For DT systems, you can actually parse the DT in the pi, we do it to get
> the kaslr seed if present, so you can actually check for Zkr. With ACPI
> I have no idea how you can get that information, I amn't an ACPI-ist.

It is feasible to check if Zkr is present in the device tree at this
stage in boot, but at first glance does not seem feasible to read the
ACPI tables this early.

The CSR being read is just for entropy so even if the seed CSR doesn't
trap and provides an arbitrary value on an implementation that does not
support Zkr, it can still be used as a source of entropy. If the
implementation does trap, the entropy will be set to 0 which is just a
different hard-coded arbitrary value. 

- Charlie

> 
> Thanks,
> Conor.
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



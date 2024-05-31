Return-Path: <linux-kernel+bounces-197525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48B78D6BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4C1284939
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06F281742;
	Fri, 31 May 2024 21:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bMGRWKNr"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED467FBA3
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191611; cv=none; b=ousLQaVTwmKRgBY5nYkbbIttXtDagOK1sL6Vz7aRAttmX2PxlKcAAfmQAaG0NkrB8yrxQ3C81RefcCdResDDCH19tPvel6wodqjiDanY/dvb2D2Cv+vEB0l0Md/hlTMHdMxbU+QedUI3PSRi6eZEIu0XApfdGX6iB2/fplEPvq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191611; c=relaxed/simple;
	bh=+mZi4Mdqo9n1pYWIVXTvtvOG+w0wloffDYS2OkMLVMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jg6PswzI7iyKgptwnRtsH3LPTZx0aJNxO4Z4pPwIZ+L75Iw/4jUAiFWQ1qqFAkW6lG2+LdEJ0LS5kZOGBDNywd7UujU/ORTbqGaO7c9iWdT7iwl5vygtOjna+Fjnm/LXhd4RhE/xs8xLpDLpv1BdQRhYmCvHCwHYrrTZD/hJoB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bMGRWKNr; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f4a0050b9aso12654305ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717191608; x=1717796408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CbxzTHPbCC9+OSlgnBZBAHLV896CAURuJytC4yPNa7k=;
        b=bMGRWKNrk4EKAFEzshOIb/mewkPoraxx4Oc8s7UAG7GvqgKDkS/rmgN7bPYUl72JMe
         3KLq87SRfLgu6fw1RTRCtrTgg1Lj0GWSpzaTWKbJynM/bWW2hIiMkyVqdK6/XOhXlv35
         FaCGKEt2Hw5FLI18VoU6zFofW/i01o4fpNs//gvxN/I8WyzOStKjAVhYuQ+MlppoRs8Y
         9a4ke0wFaCwRF/SSKSFBQE+32Tlc/CneESzT1DBk9wcE3gVjDSoy3FaR0EWv2LYZNJ/T
         rXR4U6UaPxtlhbtNIqdWd9j9KzoaMMTXyj1aKneiTccwve0sm50SPuQSmwI+3ah8tiqy
         Zu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717191608; x=1717796408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbxzTHPbCC9+OSlgnBZBAHLV896CAURuJytC4yPNa7k=;
        b=c7hQRY3kJ7lNH0qpFtrbtq9QFgUvYlQSpZkgpseY/8/BtNbOiCb5uwhN26HQmahq2w
         AjQIpA5JywwqwIvqC0Ar4HRxF827xzjTydsi6+/n5qUGPYMnXMrMLt1GDvo0pWm/4Uxs
         alwTlYs/FV2wi4uQ9ujWmwl3l5WbQw5p9kLMlkjgSEoYnZY+E6tnvBCEp1LZTOQusHT4
         aMotKhifCZYhHK26u1HUaHpfYpy7XeSBemoCri+02LrUt35DJyI6cZSoSm6MhZjFc/nO
         Rf51CNWTO7NcL+frk9ugsLaRBDHpR51CzKiirpZHpHyVFLdYN8F7tLRliJuua4zRj4Hb
         eDig==
X-Forwarded-Encrypted: i=1; AJvYcCW6m2mAsMS07IXshIQrVhX4ZlKs/fjZvJVPEwVb26zQ3LGbuJzcfkUniG047WqzOEN5qQKUAp9T94m0h98Juipjur7rckPaSs2Zu0Sl
X-Gm-Message-State: AOJu0YwRDJxi4utNoAM04zdmGDpBj8rxyg+gkFl5PndC5b8LCGPqPQA5
	zNS9VS0t2+YzCGbYrMBmPt290s6WVFSeqR/nxHaf1+6u0HCEDLwts8DqRjAai0I=
X-Google-Smtp-Source: AGHT+IH2kNxy+DP2BxFop3mrfOTKvOonyr2h+6QlVJwdZ5WJPUZsjyyTJNbm91WWm+wlyt9/NWx0sA==
X-Received: by 2002:a17:902:f9ce:b0:1f4:b7ff:ac41 with SMTP id d9443c01a7336-1f63701f241mr26562825ad.36.1717191608125;
        Fri, 31 May 2024 14:40:08 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:4d3b:392b:5722:91c1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63235ae5csm21720615ad.79.2024.05.31.14.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 14:40:07 -0700 (PDT)
Date: Fri, 31 May 2024 14:40:05 -0700
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
Message-ID: <ZlpDtR7ch+nE08lm@ghost>
References: <20240531162327.2436962-1-jesse@rivosinc.com>
 <20240531-uselessly-spied-262ecf44e694@spud>
 <ZlowwohstpT0sJVl@ghost>
 <20240531-cough-yearling-bdfd49244885@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531-cough-yearling-bdfd49244885@spud>

On Fri, May 31, 2024 at 10:36:46PM +0100, Conor Dooley wrote:
> On Fri, May 31, 2024 at 01:19:14PM -0700, Charlie Jenkins wrote:
> > On Fri, May 31, 2024 at 06:31:09PM +0100, Conor Dooley wrote:
> > > On Fri, May 31, 2024 at 12:23:27PM -0400, Jesse Taube wrote:
> > > > Dectect the Zkr extension and use it to seed the kernel base address.
> > > > 
> > > > Detection of the extension can not be done in the typical fashion, as
> > > > this is very early in the boot process. Instead, add a trap handler
> > > > and run it to see if the extension is present.
> > > 
> > > You can't rely on the lack of a trap meaning that Zkr is present unless
> > > you know that the platform implements Ssstrict. The CSR with that number
> > > could do anything if not Ssstrict compliant, so this approach gets a
> > > nak from me. Unfortunately, Ssstrict doesn't provide a way to detect
> > > it, so you're stuck with getting that information from firmware.
> > 
> > The Scalar Cryptography v1.0.1 spec says "If Zkr is not implemented, the
> > [s,u]seed bits must be hardwired to zero". It also says "Without the
> > corresponding access control bit set to 1, any attempted access to seed
> > from U, S, or HS modes will raise an illegal instruction exception."
> > 
> > There is a slight nuance here as the definition of Ssstrict is:
> > 
> > "No non-conforming extensions are present. Attempts to execute
> > unimplemented opcodes or access unimplemented CSRs in the standard or
> > reserved encoding spaces raises an illegal instruction exception that
> > results in a contained trap to the supervisor-mode trap handler."
> > 
> > The trap that Jesse is relying on in the code here is related to access
> > bits and not related to the CSR being unimplemented. Since the access
> > bits are required to be 0 on an implementation without Zkr, it is
> > required to trap if seed is accessed, regardless of Ssstrict.
> > 
> > The situation here is slightly odd because the spec is defining behavior
> > for what to do if the extension is not supported, and requires
> > implementations to follow this aspect of the Scalar Cryptography spec
> > even though they may not implement any of the instructions in the spec.
> 
> Firstly, you absolutely cannot rely on the behaviour defined by a new
> extension by systems that implement a version of the ISA that predates
> it. Secondly, we're talking about non-conforming implementations that
> use a reserved CSR number for other purposes, you cannot rely on the
> behaviour that the Scalar Crypto spec prescribes for access to the
> register.

Yes that is definitely a slippery slope.

> 
> "Non-conforming" is also a moving target btw - the Andes PMU (I think
> it's that) uses an interrupt number that was moved from "platform
> specific use" to "reserved" by the AIA spec. If you only looked the
> current specs, the Andes PMU is a "non-conforming extension" but at the
> time that it was created it was compliant. I think we're gonna have a
> fun conversation defining what "Ssstrict" actually means when someone
> actually tries to document that.

Sounds fun ;)

> 
> > > For DT systems, you can actually parse the DT in the pi, we do it to get
> > > the kaslr seed if present, so you can actually check for Zkr. With ACPI
> > > I have no idea how you can get that information, I amn't an ACPI-ist.
> > 
> > It is feasible to check if Zkr is present in the device tree at this
> > stage in boot, but at first glance does not seem feasible to read the
> > ACPI tables this early.
> > 
> > The CSR being read is just for entropy so even if the seed CSR doesn't
> > trap and provides an arbitrary value on an implementation that does not
> > support Zkr, it can still be used as a source of entropy. If the
> > implementation does trap, the entropy will be set to 0 which is just a
> > different hard-coded arbitrary value. 
> 
> Right. I can see value in doing something that may contain entropy, and
> is at worst no better than the 0 we can currently get. But the patch
> we're talking about here mentions nothing of the sort, it presents itself
> as detection of Zkr and an actually random number - but all it actually
> detects is whether or not the CSR at CSR_SEED traps.
> 
> To be acceptable, the patch would need to stop claiming that it is a valid
> way to detect Zkr. The commit message, and a comment, must also explain
> what may happen on systems that do not implement Zkr as you have done
> here.
> For example, `if (!riscv_has_zkr()) return 0` would have to be something
> like `if (riscv_csr_seed_traps()) return 0`.

That is reasonable, thank you for your input!

- Charlie

> 
> Thanks,
> Conor.




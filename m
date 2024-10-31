Return-Path: <linux-kernel+bounces-390175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DD39B767F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71991C21744
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFF0186E2F;
	Thu, 31 Oct 2024 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NxytSDqs"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41C915623B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730363404; cv=none; b=H2iUyEhKn8BXCDAu2soOmi1D+75rCwtvQaiWOxX2/IIlwl2DCnY4MXnJtcYUsER+zfGhxbs/tvQLicZFApFmBlsX98hjt4lzM2jx97lnKYFM0kK5Dvsrg+w38ethW15ZSnWCfMpIBWkaqBK4nDNMYN5kIb60Akricti3pOoRPd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730363404; c=relaxed/simple;
	bh=vH8e7AOiWH3awFct5qkKtFpb6rSOcfTNhf3kUlx1Gwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dU0BPLYDATTnr2qtiD7lwFl/MvvSdEZtLTcmro/JwFwMqRSOaxZjMcvGLWVtGbmzkWRcwu589PgGPw4B0UEAHUnELWdoX1G+8zROyIgAssjZMTlYqgGgVYgLo7mRDZSyngRRFU/hXQMzY5FfAI8eFTH4pivA+drS6U4FXn8h/eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NxytSDqs; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e5fcf464ecso489426b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730363400; x=1730968200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vH8e7AOiWH3awFct5qkKtFpb6rSOcfTNhf3kUlx1Gwg=;
        b=NxytSDqs6mjuDXJM9Lc0Bk1vC/HGRLrSBfyGIaXzVy4jSIYwDJwWLuHkwVwMxdv7UX
         AFzMYM63ZGiPNU7mSSGTqy9XHdCdixtRaSw982hlHcolzJI0hPjwJXOaejXw8wFBwU6e
         MDhXnhGwUrXYERP80qxTMvjdCTmAmkQxT2mTQouVjtvTX1Izv+AuQODBSyv0Z8pRhi+f
         7TnYBNcQiDOlwZ1AL2HYrOe3WJTwIlO09HHxX90+2eSuWpF/nnt5xilPtT5Nto2aRULJ
         ukNACoqKutAgwTHdSnSWWcefcUr2FI3QNUFqDc1k7yW9YOPbai1jujuPdpjfeXLZwckH
         EIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730363400; x=1730968200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vH8e7AOiWH3awFct5qkKtFpb6rSOcfTNhf3kUlx1Gwg=;
        b=BtGK59n0xZL1KhvisLR4O43+2XRmBdinLmOCCsvCVpKbc5xiC6kLmOAS4uqoyiyZuX
         ctKzO4FeFx7r2taJB+MmY2LMZgPzYLagG0TATwnEAbHQzCcVhJY9fBSiQp+tcMME+ODO
         1m9QzohvZBnICMFO2LbteOuEFTFFfYL8vXtu+Zjz78I8m8fgxvN5pthVOvSsjF5PqVUY
         iLkjLJ9uWSmdPqYhicistuQ1Kw9eKZjXwEPWpXRwKESOIUmcPX1is0I5wapiHCnZP9+W
         XooWkIK5GNSitetDAXCCjnOwYgkwU9TsQDiJT7mSZebyKUTQrEGSrv3tVGhRNT3Aszgr
         lekQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv6bNaP9Uz9JDoNEhz+EIoJR+U72RfMyq/MtLcxw7yID4Vas0sJbVxO2sI8OS9npZmSQ6fFJgaiHwHM1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfnOax9Aq4MYvxio1XWtR+K5P/aZa94NG6WozzGIgciEmvg90q
	w3gYgpmaEM/J0gHoma1uTq4Pmj59gub8FMnGBz96I91tS5WwraLYpHdobMh1SGcjtoG4Hdu2E/X
	HUiaF6aqhsuyJdRXa4ybO+p6Mk1/+cyXurYaExw==
X-Google-Smtp-Source: AGHT+IFExSOYo4sEJSuj2lEyGg5WDXQS8nF7c/ddrKLXCYZB/1hIU7pwgiPv7OfE75XNRxhuSDwF7s7QDJmPhfL9nQI=
X-Received: by 2002:a05:6808:178c:b0:3e6:777:a799 with SMTP id
 5614622812f47-3e6384430aemr16703618b6e.25.1730363400597; Thu, 31 Oct 2024
 01:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025091527.57825-1-cuiyunhui@bytedance.com>
 <20241025-puritan-sank-b8a828ef5872@spud> <3CCBB0AB-169D-4677-9A44-53E4148908D5@jrtc27.com>
In-Reply-To: <3CCBB0AB-169D-4677-9A44-53E4148908D5@jrtc27.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 31 Oct 2024 16:29:49 +0800
Message-ID: <CAEEQ3wmn9W8A5y37aFisQqd=8Ke7Lt6nY6am99j0O2cNbsVj-A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] RISC-V: Enable Zicbom in usermode
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: Conor Dooley <conor@kernel.org>, punit.agrawal@bytedance.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, cleger@rivosinc.com, 
	charlie@rivosinc.com, evan@rivosinc.com, samuel.holland@sifive.com, 
	andybnac@gmail.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jessica,

On Sat, Oct 26, 2024 at 12:32=E2=80=AFAM Jessica Clarke <jrtc27@jrtc27.com>=
 wrote:
>
> On 25 Oct 2024, at 11:16, Conor Dooley <conor@kernel.org> wrote:
> > On Fri, Oct 25, 2024 at 05:15:27PM +0800, Yunhui Cui wrote:
> >> Like Zicboz, by enabling the corresponding bits of senvcfg,
> >> the instructions cbo.clean, cbo.flush, and cbo.inval can be
> >> executed normally in user mode.
> >>
> >> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> >> ---
> >> arch/riscv/kernel/cpufeature.c | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufea=
ture.c
> >> index 1992ea64786e..bc850518ab41 100644
> >> --- a/arch/riscv/kernel/cpufeature.c
> >> +++ b/arch/riscv/kernel/cpufeature.c
> >> @@ -924,7 +924,7 @@ unsigned long riscv_get_elf_hwcap(void)
> >> void __init riscv_user_isa_enable(void)
> >> {
> >> if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
> >> - current->thread.envcfg |=3D ENVCFG_CBZE;
> >> + current->thread.envcfg |=3D ENVCFG_CBIE | ENVCFG_CBCFE | ENVCFG_CBZE=
;
> >
> > I believe we previously decided that userspace should not be allowed to
> > use zicbom, but that not withstanding - this is wrong. It should be
> > checking for Zicbom, not Zicboz.
>
> Allowing clean/flush is safe but has the same problems as fence.i with
> regards to migrating between harts. Allowing invalidate, unless mapped
> to flush, is not safe in general unless the kernel does a lot of
> flushing to avoid userspace accessing data it shouldn=E2=80=99t be able t=
o see.
>
> Also, ENVCFG_CBIE is a mask for a multi-bit field, which happens to
> have the same value as ENVCFG_CBIE_INV (i.e. really is making cbo.inval
> be an invalidate). I note that the KVM code, which this likely copied
> from(?), makes the same mistake, but there that is the intended
> behaviour, if misleading about what the field really is.
>
> So, with suitable caveats, allowing clean/flush could be a reasonable
> thing to do (maybe useful for userspace drivers so long as they pin
> themselves to a specific hart?), but invalidate should only ever be
> allowed if mapped to flush.
>
> Jess
>
Yes. The original intention is to enable clean/flush/invalid. So
ENVCFG_CBIE | ENVCFG_CBCFE is added. When one core initiates an
invalidation, other cores will also invalidate the corresponding cache
line. So do we not need to worry about this problem? Moreover,
invalidation is not found in the logic of disabling preemption in the
kernel. Or perhaps binding cores belongs to the user-space's own
logic. Can this patch be fixed as RISCV_ISA_EXT_ZICBOM and then a v2
be sent?

Thanks,
Yunhui


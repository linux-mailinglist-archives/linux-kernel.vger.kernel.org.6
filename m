Return-Path: <linux-kernel+bounces-527549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6C7A40C86
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 03:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4EE189EC28
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 02:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99D31096F;
	Sun, 23 Feb 2025 02:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VquT1po/"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF888837
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 02:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740276351; cv=none; b=r+BVBA9aZfJmXpBvKExu/3+RkWewNBLw4LD4EvbTNbr6KG3yskSqD0CKg6LqHN3Lan6KMIqVtYsOXHh8WVWzxXabLXUdzAqS0M90Cs0nD34kshdFPMQAziQP43g7FaoGySIgVms62V+21A+91AneXaiM68tn0LtIgCXZoNAPiX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740276351; c=relaxed/simple;
	bh=s3toQqjjS/oD9wydqQT7abiPlhSbLbUpblMrUOl2+CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fc7qcmbbmK6tDOPIP5tXr0/b/HjvHh7qPz/7w3cUDXxwSnlucwgVnE9ZutpVD4SJpAthFxJ3bqaw9zaxFrRtCqxqh8lolWF4Mh9JKNH3+8I2ixXkv7VxZShd1IaV0ZTDyr6Wcp+yE/52raP5m1sPR2tolFvX4maQ+EBcYihzaDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VquT1po/; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5fd31d25ebaso28150eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 18:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740276348; x=1740881148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2XEj1hbiH6o5CDpfSnYdqt5AMNqF18Pd/CIj/Ve+KU=;
        b=VquT1po/eA3z6ALBxPSTnLj8L7Ml7nU1vR3MgEkIKlyYtCv9XbHIOr8J4NpB0vtB6D
         CKfBWTETn97Yc9nOW8yhH2ygWyZ4vAYSMDBac0x0W6N0tpPlSA/Angpa535jhCzF6zc1
         XWp8+jhhrRVHJC3H16SeKP1PCAVfqelWykT5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740276348; x=1740881148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2XEj1hbiH6o5CDpfSnYdqt5AMNqF18Pd/CIj/Ve+KU=;
        b=pke9x+RWklzwe2m4qD5zpUWzo97/N8Ak6hbOB/PkE25mlMZCHHPWoZDl417EIJzVM0
         Mi8Cnp3sAVrZlkldVypbNHFtPNuwDZbG8EwJDdtKCnYNYVcxIXFJdQ/49bR0JKdWe9Wo
         aIyt3GRj45DCrTBbaSWoEvEnzbN3BVx0apP8hZivriKvTMkKLjOLmqeYiGdCPkfYI2E9
         FauBuAhxxwPBqbnw9y9ujcPozwDCKKALjxrU1YGl5du6bKMQsiy+QjFcjDXOC1iQ7rYm
         F1PSlGqwcLLRFJvkis6zWNc+9XJkaQ3V/uHtSM2a1+XwV5D5ER7UpSVGnwLY7x252Nld
         KHpg==
X-Forwarded-Encrypted: i=1; AJvYcCXF4v6x76SE/lqZHM5trSWOvOSM/I6RE75QbQZ0um4NCXbUznMETq7V21nKayBMSX+sK4Tc+1R4SZdyxUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpzCZ0ErNWnLNLiYutWe4Zv9F47Yw9t7RD47MvXjqbZIzvjkEi
	Cttj3zwEnfKRLssug2vMNxZuQVvqunwM1+yZEhT/Mwj+5JOoD85BZQUnACUmBWD1K1Uy5mr2Cdu
	3morYIyM/cOMGg2tKSbSII81XMexvaIJtTpRg
X-Gm-Gg: ASbGnct+j8LSQRWgicBlxYE53wTiT6QwciYj1/i+/R2VETipvjY35B4+nMTNlAeeERQ
	hlH4WdxJtU9Yow10/ObJnAutqYP0l/3d/Pd3HMhaFbVVMqTAA+qsR8AiKECt6HnvhJg0XS0nusO
	wUgwWc3mLsLcM/YlvLULVv1wkZ1YIIELfDk00KXZR1
X-Google-Smtp-Source: AGHT+IFYiKfj7n9oq2z10qTkYhOrFEAS3wfYsvDaOSNLv5Kzbj7Q9svtXXu5LyLgAFkx1mNPmsy7UCDxvQfO3Nq1L3E=
X-Received: by 2002:a4a:e9b0:0:b0:5fc:f416:e315 with SMTP id
 006d021491bc7-5fd3c5e739cmr169433eaf.0.1740276348473; Sat, 22 Feb 2025
 18:05:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212032155.1276806-1-jeffxu@google.com> <b114f48a-a485-4ebd-9278-6c62a1f33d9c@lucifer.local>
 <CAKbZUD0TAX8F9kDCEEvGSbcegDD4GLyra3ewtxncBbs45WJZ3g@mail.gmail.com>
 <7545d5eb-a16e-4cc8-a9e3-5431be01aade@lucifer.local> <CAKbZUD3kaYEqQFU1TWfJWvtV02ESaMb0_ygadGgeAKo-b+GRcA@mail.gmail.com>
 <202502131240.A57C749@keescook> <CAKbZUD16kfO2OBxY2fMbnmnEinTeKbPpTOLVC=Pc+FbWN_kjcQ@mail.gmail.com>
In-Reply-To: <CAKbZUD16kfO2OBxY2fMbnmnEinTeKbPpTOLVC=Pc+FbWN_kjcQ@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Sat, 22 Feb 2025 18:05:37 -0800
X-Gm-Features: AWEUYZnuOFzxTft1Ol1ezbgtkwfxRwvwDnRZCiBdBqQfVmfm8mLtznn6nJkF5y0
Message-ID: <CABi2SkU_owKfgeUrFaFQUqHYkz1gnTbav2yAABgP2ThkFRMiQA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/7] mseal system mappings
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	akpm@linux-foundation.org, jannh@google.com, torvalds@linux-foundation.org, 
	vbabka@suse.cz, Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org, 
	oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de, 
	ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, hca@linux.ibm.com, willy@infradead.org, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	peterx@redhat.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 3:18=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
> The problem with something like prctl is that we either indirectly
> provide some kind of limited form of munseal, or we require some sort
> of handover (like personality(2) + execve(2)), which both sound like a
> huge PITA and still don't solve any of our backwards compat issues...
> all binaries would need to be patched with this
> prctl/personality()/whatever call, and old ones wouldn't work.
>
SECBIT (such as AT_EXECVE_CHECK) can be locked, which provides a
strong security guarantee.

> The semantics behind GNU_PROPERTY_MEMORY_SEAL are unclear to me (maybe
> the toolchain folks could shed some light?), but it sounds like it'd
> fit perfectly.
> I suspect we probably want to parse this on the kernel's side anyway
> (to seal the main program/interp's segments)[1], then extending them
> to the kernel system mappings should be somewhat trivial...
> I don't think we'll ever get a program that can't cope with sealing
> the system mappings but can cope with sealing itself (and if we do, we
> just won't seal the entire thing and that's _okay_).
>
> Deploying mseal-ready programs could then be done in a phased way by
> distros. e.g chromeOS and android could simply enable the
> corresponding linker option in LDFLAGS and let it rip. Other more
> mainstream distros could obviously take a little longer or test/deploy
> this on all programs not named gVisor and/or after CRIU is okay with
> all of this. We then might not need a user-configurable CONFIG_ (only
> an arch HAS_SYSTEM_MAPPINGS_MSEAL or whatever), nor a sysctl, and
> everyone is happy.
>
> I glanced through libc-alpha again and it seems like the glibc folks
> also seem to have reached the same idea, but I'd love to hear from
> Adhemerval.
>
> Am I missing anything?
>
I'm hesitant to rely on HAS_SYSTEM_MAPPINGS_MSEAL in the kernel for
special mappings.

Think this way: some apps don't want vdso, but the kernel creates it
anyway,  those apps were forced to unmap or remap them.

If the kernel should take a new dependency on the elf header, a better
approach is adding a bit in the elf header to indicate "not-creating
vdso".  This would solve problems for those apps that want to unmap
vdso.

CRIU would need more than this new bit, i.e.  an ability to create
vdso on demand. Currently, during restore workflow, CRIU remaps the
vdso created by the current kernel (can't use vdso from the back-up,
because vdso is tied to the kernel version), and the remapping address
must be the same address  as the backed-up process, to avoid
symbol-relocation. Kernel can provide a new functionality to create
this vdso mapping as desired by CRIU.

Then the vdso can be sealed from creation in all cases, this is the
most secure approach. And the kernel also doesn't need that code to
remap/unmap vdso - that is also cleaner IMO.

Thanks.
-Jeff


>
> [1] we should probably nail this responsibility handover down before
> glibc msealing (or bionic) makes it to a release. It'd probably be a
> little nicer if we could mseal these segments from the kernel instead
> of forcing the libc to take care of this, now that we have this
> property.
>
> --
> Pedro


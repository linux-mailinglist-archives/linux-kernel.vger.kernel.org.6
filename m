Return-Path: <linux-kernel+bounces-428073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E0C9E09DC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821111632F4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00AA2A1B8;
	Mon,  2 Dec 2024 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bEcBcu5Z"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B661D9694
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160512; cv=none; b=W3nh57E4JvWlYF3uB/aezeC/Inz3OGRuMEu78pENy4ZSQGBxMCKD0xICkJ5AseorehXY09Dwd8eBve0hfpSobLv3owUfEqznjOhTpR5Lp0imFH14w9Gest8bRPL79ys8OzONjvC04NY/yKpBC0W8rxYsoreu87sHfLIUXHzldM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160512; c=relaxed/simple;
	bh=wJFBfBmHYj+r40PWkie06frhHQy8OBlRzQJ5xiTFB6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsGfbNSZHgKTOYRBxjPZ+6vzlhG1waPWllRIk27qzct9mE0r7NC9+Dln2XESTJ3hs82Chmn3KbJ1Z/tpza9kT6nk50RJBuJuz/sefJz1XjU4s5RayO9r3VgCOW3790Q5vmXP63/tSKVu3yd5wB1r43D6y8OKE6rJ0t0Wj25O0fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bEcBcu5Z; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-295e9f795dbso242188fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733160509; x=1733765309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4g52UpJ3PmxcvI/j7zwPPdBS0T11At54rD3c1xjjOY=;
        b=bEcBcu5Z0ChiZ1asgoL75MV59zPDCw5NSd4R7E8tKyueEqxJWZhOi37VMhZz3roBOV
         ONLSvp3soSHLCZldgVKot+cyICXa1oWZrpMErNdP9/4H3LFohRay7CaJ8gh5E5rNg2Zd
         hQkrYNRifEjbTN3GXB5Senz6I2CgHSP+T31oM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733160509; x=1733765309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4g52UpJ3PmxcvI/j7zwPPdBS0T11At54rD3c1xjjOY=;
        b=f28alaZvG1RWd00T7moRMp8g98JsZsRsSaG4mngBWMTy9ozU2MT3MHN+mle4Bc7E91
         TZERSEktSWPpJBS3bP5+oykKF441YbvvSZHo+epyt0IfeMYhce2QeTla75EFzNduUtvc
         SlKVlIc5MM0hsL2yyvE0hampepUOc1s0UKRFcvikNGZKww3FngtXK9LAuhLBGLOXoiWG
         dG0rwZ2zdPTL19Yf8V0VYuxqGlDMp5hG/oD1wygY+r5bpzmw9wd9ks4E3GNaC6UvR9AS
         v8D/weigq4r13Jkkm/DGyMF/j/GhJy6U8DMHCprPfgljJw2F+WWrVZ2L59ItSmjcQ0W+
         Rgzg==
X-Forwarded-Encrypted: i=1; AJvYcCXTDJNGzBqv/n+6dhtgcQAwqaZU+jjr2SbULv91y2hkj8hzA7IJlPGFob+/YDW06eE7Kf9RjNbzd//1B/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUgL66lDYxXPmDogQAAkzcnZwEGuBlcPYkyWcMaTcjT7lYHTcb
	NqHE+4mM0gRTICV/39SQC7MSTFtMYchHKcpWRhr2FLxC0Fg6PF2mT+0OwA9NZ1M5HFaAi0XsmX+
	SJ4dfEotmk4mijcehkCKx0XrAX8V6rgco2IJM
X-Gm-Gg: ASbGncsU9HyPCdpzNzU9X6H4G7NfkvknhsCwMc8FzQ1fnESgOd5lYBdqGRDBT6jd6Hi
	GiGwNLjvm6AdslZvcVjIjnR4/Kgh1I7fd4yUj4z9yPfk8iPeD5otg3jvEGJ+/
X-Google-Smtp-Source: AGHT+IF0l7ckRLP+aVl+IekfkudYe/vLczB8xykS3zl9D27IHSlG37LSEt2alDzPQKCTxcNozOrr3kQuCvLEOD1SXnI=
X-Received: by 2002:a05:6870:170d:b0:295:c1ca:b99a with SMTP id
 586e51a60fabf-29dc3fbe9f0mr4690677fac.1.1733160508981; Mon, 02 Dec 2024
 09:28:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125202021.3684919-1-jeffxu@google.com> <7494c3aa-378f-4bb6-bc44-59ea49ccc5e6@lucifer.local>
In-Reply-To: <7494c3aa-378f-4bb6-bc44-59ea49ccc5e6@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 2 Dec 2024 09:28:17 -0800
Message-ID: <CABi2SkV1kSgUpXTfiGOLy2CazzQrJd75=Uwa40CvuE-JRqQfnA@mail.gmail.com>
Subject: Re: [PATCH v4 0/1] Seal system mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de, 
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	Liam.Howlett@oracle.com, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 8:40=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> +Vlastimil
>
> Jeff... :)
>
> Please review
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>
> You didn't cc- mantainers of code you are changing. And you reference my
> name without cc'ing me here. I'm sure there's some relevant Taylor Swift
> lyric...
>
I apologize,  this shouldn't happen again.

Thanks for reminding me
-Jeff


>
> On Mon, Nov 25, 2024 at 08:20:20PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> >
> > Those mappings are readonly or executable only, sealing can protect
> > them from ever changing or unmapped during the life time of the process=
.
> > For complete descriptions of memory sealing, please see mseal.rst [1].
> >
> > System mappings such as vdso, vvar, and sigpage (for arm) are
> > generated by the kernel during program initialization, and are
> > sealed after creation.
> >
> > Unlike the aforementioned mappings, the uprobe mapping is not
> > established during program startup. However, its lifetime is the same
> > as the process's lifetime [2]. It is sealed from creation.
> >
> > The vdso, vvar, sigpage, and uprobe mappings all invoke the
> > _install_special_mapping() function. As no other mappings utilize this
> > function, it is logical to incorporate sealing logic within
> > _install_special_mapping(). This approach avoids the necessity of
> > modifying code across various architecture-specific implementations.
> >
> > The vsyscall mapping, which has its own initialization function, is
> > sealed in the XONLY case, it seems to be the most common and secure
> > case of using vsyscall.
> >
> > It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
> > alter the mapping of vdso, vvar, and sigpage during restore
> > operations. Consequently, this feature cannot be universally enabled
> > across all systems.
> >
> > Currently, memory sealing is only functional in a 64-bit kernel
> > configuration.
> >
> > To enable this feature, the architecture needs to be tested to
> > confirm that it doesn't unmap/remap system mappings during the
> > the life time of the process. After the architecture enables
> > ARCH_HAS_SEAL_SYSTEM_MAPPINGS, a distribution can set
> > CONFIG_SEAL_SYSTEM_MAPPING to manage access to the feature.
> > Alternatively, kernel command line (exec.seal_system_mappings)
> > enables this feature also.
> >
> > This feature is tested using ChromeOS and Android on X86_64 and ARM64,
> > therefore ARCH_HAS_SEAL_SYSTEM_MAPPINGS is set for X86_64 and ARM64.
> > Other architectures can enable this after testing. No specific hardware
> > features from the CPU are needed.
> >
> > This feature's security enhancements will benefit ChromeOS, Android,
> > and other secure-by-default systems.
> >
> > [1] Documentation/userspace-api/mseal.rst
> > [2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkR=
kL-NrCZxYAyg@mail.gmail.com/
> >
> > History:
> > V4:
> >   ARCH_HAS_SEAL_SYSTEM_MAPPINGS (Lorenzo Stoakes)
> >   test info (Lorenzo Stoakes)
> >   Update  mseal.rst (Liam R. Howlett)
> >   Update test_mremap_vdso.c (Liam R. Howlett)
> >   Misc. style, comments, doc update (Liam R. Howlett)
> >
> > V3:
> >   https://lore.kernel.org/all/20241113191602.3541870-1-jeffxu@google.co=
m/
> >   Revert uprobe to v1 logic (Oleg Nesterov)
> >   use CONFIG_SEAL_SYSTEM_MAPPINGS instead of _ALWAYS/_NEVER (Kees Cook)
> >   Move kernel cmd line from fs/exec.c to mm/mseal.c and misc. refactor =
(Liam R. Howlett)
> >
> > V2:
> >   https://lore.kernel.org/all/20241014215022.68530-1-jeffxu@google.com/
> >   Seal uprobe always (Oleg Nesterov)
> >   Update comments and description (Randy Dunlap, Liam R.Howlett, Oleg N=
esterov)
> >   Rebase to linux_main
> >
> > V1:
> > https://lore.kernel.org/all/20241004163155.3493183-1-jeffxu@google.com/
> >
> > Jeff Xu (1):
> >   exec: seal system mappings
> >
> >  .../admin-guide/kernel-parameters.txt         | 11 ++++++
> >  Documentation/userspace-api/mseal.rst         |  4 ++
> >  arch/arm64/Kconfig                            |  1 +
> >  arch/x86/Kconfig                              |  1 +
> >  arch/x86/entry/vsyscall/vsyscall_64.c         |  8 +++-
> >  include/linux/mm.h                            | 12 ++++++
> >  init/Kconfig                                  | 25 ++++++++++++
> >  mm/mmap.c                                     | 10 +++++
> >  mm/mseal.c                                    | 39 +++++++++++++++++++
> >  security/Kconfig                              | 24 ++++++++++++
> >  10 files changed, 133 insertions(+), 2 deletions(-)
> >
> > --
> > 2.47.0.338.g60cca15819-goog
> >


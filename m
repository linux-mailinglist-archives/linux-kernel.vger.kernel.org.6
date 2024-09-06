Return-Path: <linux-kernel+bounces-319083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F5696F78D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400521F25F59
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB441D2783;
	Fri,  6 Sep 2024 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fX/BeLPk"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F94156880
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634608; cv=none; b=KxiQJaDJ675tS5bnB32cj5VBt9BB9zm6KYXPRj6zdZscq9rCl2wEEvz0/UBCN7Ay2i6aAwtLiqaRiOerP2yAS63RLhcPYZ1n1J5TzwNahuuKId7fOpE/OD013jhI0TtPNo+SanGp8l5oSDjn5XQ7H8RdAyvB3LN3HTQqGE2SgRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634608; c=relaxed/simple;
	bh=Z4WKeJmpOYFiYE7cCHqfI5S+mHBFpdvOr74BGZhwPJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUtaGmj+3Ljx+Q8s8Tbalxb9U07hWH+MA7annXGZT+G2YxJXpaNX8doJT4CgvVlYIL5ZYo92NzusHvdrvzpyEhf5GLx4xFXvHZqHciaBNVXevrEnKYHHk78KXv5muPMcfYqHlD+KI9FyESgcDN1PPHuvoCcEVTPO2jRPSKFd/Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fX/BeLPk; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-502ae81b4daso201243e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725634605; x=1726239405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8DQFAISHS7i5IP3gsOeV2GhBMoOIKb1H2ynRnefFiA=;
        b=fX/BeLPklJ3TmlNwwRWISchAp7HRYNqY6dXUsSIIJldZZf6s0kvTvLgXg51cmPH4b2
         N8ELqNwCwjPnNIg3sQo8R3L/eHcoEalymtblwAcqP/BWKcXfuKg+ej1UI+ZlMkGB1Wdo
         ojWpR3JLBI1Av98+L2SF3RDpiqUWIvLcjrZ7ZqEnd8Bj38uVzc1NdzjbCYa+Zr2fGHu7
         mH2XXNknaDOsliy1ZBduX4EyGVqEwiUGXky1rgaxuh0bgfXD1jExECbOjtD79qY1wW7G
         fpqvnTCQ1BeJ0VMrQW8TqZDjihtCeZQDPIejcYwhGWkGSzijfEQVYbke9a9X9B84U8Mt
         ZHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725634605; x=1726239405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8DQFAISHS7i5IP3gsOeV2GhBMoOIKb1H2ynRnefFiA=;
        b=eJWC4ZKFe4a4poIQRKLkKXkHuvHHl0EK/6wOYvzsBOy1R02ew7dcW85/fteqpTlfQu
         ccuSEiC9jKw1t9u1I87mFTfW2CPAnp1JId97vbbotZjFmLrv+AG5w/L8ImJT7kK4QdsF
         7Icq5C5qmzrJFN/duBAwVd9YAmtIkbnNZWCuZZzPfRpo9ShlHo5XATc+up2Qz1/YEZem
         GEBwnPkgHltmUYNjvAKauVkugr3lyfgDvgONXLAyENpvMS28QaZtb4hsQXnjdq3g/0r+
         DTbmPaSADT6TW8rd1zqGhIbbZ/7v6KOvKJxI/Wi0gjDlyFqMC0t5oWU/WefIGGLx4H44
         1ofg==
X-Forwarded-Encrypted: i=1; AJvYcCUAr5w1HPDwGgg0w8zL+CuBy5734XyDZ2TQeZ5X5XvTklqmwtLeKVCYjZifFz7gxD3buDsaHCOjFEfiBCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcl8UVBPDsqOYPKx/a1pf5+a1tLw8RkrytZZFGtJQZTDbzAVW6
	pvuGLM2je9D4f40vgwVAQ6QJi+9MmzxVAAIPjx9xGTpClCE7Oy7uogHDUgfcYO+qjFrtgVwk9I0
	3/hXkngx7vBZzEoO+co1qj760qWF1QUBbTEZU
X-Google-Smtp-Source: AGHT+IHq7ZiORKnHJ7OGW0/x1cWaLstSbHVVP69Jhc2KtxHBDUWP5W0/AltVyanWWqQY/QWC4tnW0snbDbe3WIJv/jg=
X-Received: by 2002:a05:6122:3b17:b0:501:2842:428a with SMTP id
 71dfb90a1353d-50128425272mr4021883e0c.8.1725634604866; Fri, 06 Sep 2024
 07:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906-macos-build-support-v2-0-06beff418848@samsung.com> <20240906-macos-build-support-v2-6-06beff418848@samsung.com>
In-Reply-To: <20240906-macos-build-support-v2-6-06beff418848@samsung.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 6 Sep 2024 10:56:33 -0400
Message-ID: <CAHC9VhRpHgqN2fp1J3x9=zBqNr3QHsSDgUnoZ7M-SuOQ6hQ4nw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] selinux: do not include <linux/*.h> headers from
 host programs
To: da.gomez@samsung.com
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	William Hubbs <w.d.hubbs@gmail.com>, Chris Brannon <chris@the-brannons.com>, 
	Kirk Reiser <kirk@reisers.ca>, Samuel Thibault <samuel.thibault@ens-lyon.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	speakup@linux-speakup.org, selinux@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-serial@vger.kernel.org, llvm@lists.linux.dev, 
	Finn Behrens <me@kloenk.dev>, "Daniel Gomez (Samsung)" <d+samsung@kruces.com>, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 7:01=E2=80=AFAM Daniel Gomez via B4 Relay
<devnull+da.gomez.samsung.com@kernel.org> wrote:
>
> From: Masahiro Yamada <masahiroy@kernel.org>
>
> Commit bfc5e3a6af39 ("selinux: use the kernel headers when building
> scripts/selinux") is not the right thing to do.
>
> It is clear from the warning in include/uapi/linux/types.h:
>
>   #ifndef __EXPORTED_HEADERS__
>   #warning "Attempt to use kernel headers from user space, see https://ke=
rnelnewbies.org/KernelHeaders"
>   #endif /* __EXPORTED_HEADERS__ */
>
> If you are inclined to define __EXPORTED_HEADERS__, you are likely doing
> wrong.
>
> Adding the comment:
>
>   /* NOTE: we really do want to use the kernel headers here */
>
> does not justify the hack in any way.
>
> Currently, <linux/*.h> headers are included for the following purposes:
>
>  - <linux/capability.h> is included to check CAP_LAST_CAP
>  - <linux/socket.h> in included to check PF_MAX
>
> We can skip these checks when building host programs, as they will
> be eventually tested when building the kernel space.
>
> I got rid of <linux/stddef.h> from initial_sid_to_string.h because
> it is likely that NULL is already defined. If you insist on making
> it self-contained, you can add the following:
>
>   #ifdef __KERNEL__
>   #include <linux/stddef.h>
>   #else
>   #include <stddef.h>
>   #endif
>
> scripts/selinux/mdp/mdp.c still includes <linux/kconfig.h>, which is
> also discouraged and should be fixed by a follow-up refactoring.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>  scripts/selinux/genheaders/Makefile              |  4 +---
>  scripts/selinux/genheaders/genheaders.c          |  3 ---
>  scripts/selinux/mdp/Makefile                     |  2 +-
>  scripts/selinux/mdp/mdp.c                        |  4 ----
>  security/selinux/include/classmap.h              | 19 ++++++++++++------=
-
>  security/selinux/include/initial_sid_to_string.h |  2 --
>  6 files changed, 14 insertions(+), 20 deletions(-)

Similar to patch 7/8, please read my comments on your previous posting
of this patch, it doesn't appear that you've made any of the changes I
asked for in your previous posting.

https://lore.kernel.org/selinux/317c7d20ab8a72975571cb554589522b@paul-moore=
.com

--=20
paul-moore.com


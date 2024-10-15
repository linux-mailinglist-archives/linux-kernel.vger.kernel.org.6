Return-Path: <linux-kernel+bounces-366656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D29899F852
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2F11C21F4E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8821F9EAE;
	Tue, 15 Oct 2024 20:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lVwPn3Rk"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F0B1F584E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 20:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729025722; cv=none; b=Bqv5LaE28KTz24yeBMwkKoUQtu0tNBcIUWokSgpBspfvKjzTnhL33IQsGiL3TOuqo7qOhweQ4gTwsd7NPhvuDyFLlgQyCXuCWJAIL5PPxykxWzDos0nT6aqPSQhoApPAPy1GRdx4p1JfTsvnMlUMPK9UVKKEECWLW24xO19HfwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729025722; c=relaxed/simple;
	bh=DS1XpG7s7sUoL58dCgxsJWkLljdx0HJ149nnDqY/Q7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJ1RxZR/SwIuAuc+0iP+Hg1VNQIP0242iOIkZirDwenHQaVEY+jsGDDMXzGUFZgmtqN/iWav7RVTWBqJ0P5dBC2zQVfv7+ycHLgWjO4SJ0IG/HgJ6SDSHCwPWUFZMjKO/WyP1emfSijj8E3RFDc0V6ioi9/CkuyqZjtJjxmjNw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lVwPn3Rk; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb5f647538so2894461fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729025718; x=1729630518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OveL9OkkUYT89uwk8KUSuuswqvLtHm2FwK5hFo31JeI=;
        b=lVwPn3RkU2MPbnuE4Fm9K+HojiFaNyj7Gw8sCRe0E+G4Lg7fz8P53HK6utQxtcymf4
         OCesMEBuKzcYIMBqhCmfJjpRXitE9vyKG5OIPaDjISnjImQHNeIuqy4Nv+KhA/I4/YJi
         goKhSJOI+TLu3SqNOgtQpzyav6A4GvGJCfl19rA+IJgwEq/QPR/pTK+yuVDeOuv5oXgI
         2Z+UQ7/PqHhp6GpGXrd0BVsu0SPqUPc3A7urCAQbcnKTeggiAeaOMyiOSEXLnDwzuBGn
         9RQ4Saysy2tC0Vq4pDCwXlsD0MAGqGO4FzfYHtD/5ABFGsrUMxzq6WRyMi1FlJ8qenhW
         8QBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729025718; x=1729630518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OveL9OkkUYT89uwk8KUSuuswqvLtHm2FwK5hFo31JeI=;
        b=syH5QYgDOOmdnnjHe/aV8iivazqX7A/NLdNjkWjxM2qHRb3iOAXPYv/9L91qZYtsKS
         x/v25QvM0VbUkgfiBm/ikaWkYMGXo3jmmP7VwsD7xf2iWY9uHcNR7oQ5LXmzhpqcQkE/
         27BJvZd67qadblp9AxgVW82dzHCvMX9Ao8A73WuWxYVS1H1S3TgYSIE+ilziCaIM1YfF
         k/oe49BOXqZ6sKOHyhcDEyvZks9TwzbI3I/IpdcBVRKjFlZEO+o2QVXINq0mMrll4y/5
         s5Z8ozAUm3yo9UQENYE3fZhH+qLce/fqefDNhJpZB95V1EgracJk4sGDPhfdPWwgTUIL
         Pjqw==
X-Forwarded-Encrypted: i=1; AJvYcCXHH+SIoWVVV8vxVB3CdQgxCUZTXjhNWg1bI0+MiEW43rhFw0wDBt7aBjgvb/e2h6iGL/YqxtObgWqqR2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSIAleLsLzB6CiMWuOejt/zgqMLQtRvd9LF8BBfW/Z8ZoKnxB9
	f/3hf47j0apszM7x1LfRlKBTbG1F6QWe9P3GqfP4VAFhzlGEAV7vnD2r+542rOl9mrydkUzyyrn
	RMPDVsYgSbcj9/XaYjsFLDi2dn11QW0mYL1PfIw==
X-Google-Smtp-Source: AGHT+IFOOonFjuOmrmQsFSHFjFOQ9JFHw7vA8rdJ8lawX19nbkfAelelU/UtUtsKBZt648QElRUS59pX21IXDAakbJ0=
X-Received: by 2002:a2e:a587:0:b0:2fb:62ad:89e4 with SMTP id
 38308e7fff4ca-2fb62ad8d54mr3977931fa.19.1729025717399; Tue, 15 Oct 2024
 13:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com>
 <Zw5D2aTkkUVOK89g@J2N7QTR9R3> <CACRpkdY79nbBoaHe6ijuyJS9dDduNw_sv1J90pz121YDgCvC3Q@mail.gmail.com>
 <Zw51fhCkmCYrTOeV@J2N7QTR9R3.cambridge.arm.com> <CAMj1kXEcLD3PWd-9osjo9AOe5Jg-NMOmJ8afB_x7VeboueLoeQ@mail.gmail.com>
 <Zw59x0LVS-kvs9Jv@J2N7QTR9R3.cambridge.arm.com> <CAMj1kXEnhHkxywh8TH1i=fmyAR8cXZ8D-rvV43X-N7GpCf2Axw@mail.gmail.com>
 <Zw6Jk74-d0mhR0jx@J2N7QTR9R3.cambridge.arm.com> <CAMj1kXG3bwMGpArYNUm-qMO7PPgb3--wy5kp-3Ks2Uv9M479xg@mail.gmail.com>
 <Zw6X9KQT0-z7r7SY@J2N7QTR9R3.cambridge.arm.com> <CAMj1kXGGmsWs2XpM7zLURjKp67Uz2ePi1pSV1=rPCMgviLVUgw@mail.gmail.com>
In-Reply-To: <CAMj1kXGGmsWs2XpM7zLURjKp67Uz2ePi1pSV1=rPCMgviLVUgw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Oct 2024 22:55:05 +0200
Message-ID: <CACRpkdYjeqaRzz+hBOGGLEAJn5QmFGof2ysQuVNC_+vV49WPRw@mail.gmail.com>
Subject: Re: Crash on armv7-a using KASAN
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Clement LE GOFFIC <clement.legoffic@foss.st.com>, 
	Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	Antonio Borneo <antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 7:28=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:

> > From a superficial look, it sounds like it should be possible to extend
> > that to also handle the KASAN shadow of the vmalloc area (which
> > __check_vmalloc_seq() currently doesn't copy), but I'm not sure of
> > exactly when we initialise the shadow for a vmalloc allocation relative
> > to updating vmalloc_seq.
>
> Indeed. It appears both vmalloc_seq() and arch_sync_kernel_mappings()
> need to take the vmalloc shadow into account specifically.

I'm trying to look into that.

> And we may
> also need the dummy read from the stack's shadow in __switch_to - I am
> pretty sure I added that for a reason.

I added that since it was simple:

From c3c76df2a9b8132b169809dcdf93488cb43a2688 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Oct 2024 22:50:38 +0200
Subject: [PATCH] ARM: entry: Do a dummy read from VMAP shadow

When switching task, in addition to a dummy read from the new
VMAP stack, also do a dummy read from the VMAP stack's
corresponding KASAN shadow memory to sync things up in
the new MM context.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-armv.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 1dfae1af8e31..ed2d0d89e2e9 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -25,6 +25,7 @@
 #include <asm/tls.h>
 #include <asm/system_info.h>
 #include <asm/uaccess-asm.h>
+#include <asm/kasan_def.h>

 #include "entry-header.S"
 #include <asm/probes.h>
@@ -561,6 +562,13 @@ ENTRY(__switch_to)
     @ entries covering the vmalloc region.
     @
     ldr    r2, [ip]
+#ifdef CONFIG_KASAN
+    @ Also dummy read from the KASAN shadow memory for the new stack if we
+    @ are using KASAN
+    mov_l    r2, KASAN_SHADOW_OFFSET
+    add    r2, ip, lsr #KASAN_SHADOW_SCALE_SHIFT
+    ldr    r2, [r2]
+#endif
 #endif

     @ When CONFIG_THREAD_INFO_IN_TASK=3Dn, the update of SP itself is what
--=20
2.46.2

We still get crashes in do_translation_fault() so we need the more
thorough solution. Maybe this is needed too.

Yours,
Linus Walleij


Return-Path: <linux-kernel+bounces-368444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47A39A0FD5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AF51F2122E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3AE2101B1;
	Wed, 16 Oct 2024 16:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wci8OphY"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3449020FAA6
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096488; cv=none; b=OiR3rqAvNGFeicDIClRdM+CqmrOpeNa5/omHAcws995dm6BFcP9ggE5JlOrGBQ+m8ox54uMRZzlJW8jTUW369Kfxb4+illpfmflVZJ3tOWPuQlo2PlkdO4xNavLIl74x6fY6YMFy2o0Dz0tAnGnCyCjIeKiAT36aoW/UlX8sxCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096488; c=relaxed/simple;
	bh=fCZxpmiXj5EFM/R1DS5DKExcrvR9cTPESBpWDwpsK0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsC4moUF3MJNFPLAH+Sercdy/39V1NEU+NwJWakoR5bb5zTJoL88RgQ8uVIiTxZ0WXxxN4Wf43OzNk/x/Gm1ueP/XVAG2duUOMjdkyNvuC8ruT09+Xvt9NB+lULq55jZtsO9iw0mPaaG7c2oHqufYlxTHNSK1KY9KG2Js7cHWLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wci8OphY; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7165df3a85fso3960814a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729096486; x=1729701286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rshs8JSwkn4JoxD+NjTq/04DsnCWL9TnPBUKxzKlyQ=;
        b=wci8OphYuCO2tGMa+YrQeZWA3Eul9VBaSsLMqv1lwmS7K3mc4HHMWCriOTab1bPK6d
         dLwI64PDjK6nhW+gS/lLFBIFqhoeQ/LJo6KDU23PNY9rbO/i4fGJg2KND7z8Odf1Ejk6
         jjpLV3QHJ0c74STS6CcuqF467gOJ7Oc6Ny+xTB9dpYwDIIEyvziRTEyM2v/xIO3ehlKW
         3KjBQ3BymQzxzaPSC+/o8ahCqCRz96eskbn0vT+7TMytQYj5aAstbpcj+36AzPZ/2ph1
         Nub5dtWSH3iFNiSxzjhFN51+QuB+TtxjSjHwYl1+8Ql35TLumHWZ3JpL+vvWAPZJbz/B
         59/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729096486; x=1729701286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rshs8JSwkn4JoxD+NjTq/04DsnCWL9TnPBUKxzKlyQ=;
        b=WAjtKIYy73Z/17Zjj5hGUZOjAQJ6m/aZNMymarMYgSKXVUtul6dcAo49ckn8Mrril6
         E7ML62DYxPhNyTZTUtZTqaludRi2vQySL3eGfh5qgwzeNgqc0YTOeY6c7ZNg2eRVDmTu
         ifcvweTGvarfbzkb2a/IkgQ2J09JR05WxqH1D+ixlxmBqQfXDxujES5eN2Drigicx66t
         NDRpXEJFE6gXuZ7izQiLor2Z3h476+4t585qcAAiCdDHl1R2m+kEZbCBc7AEWq1x4uJ3
         3AXPCccmw+pkEG4Vg4gMAM3mR1RQTmePswibFrmLN26p0l0bZoAM4XyB3Gv7IWz2Ts/O
         ALeg==
X-Forwarded-Encrypted: i=1; AJvYcCUAjnZVZ3yTeu0e9wuWJlJzI5GAX+u+VVNpwHHWHyrImc5jLzm2wPhdo6+koOee+x2aV6cL0Eu5Y7THvKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YydeEAretb9f5yvMzETiohz9ywN0pt04aqLTbvN+BCBe2g16DrR
	reyIOcz5pIsGDcIyFkwL5C0KAOPtVqfCzgP/c4+KnNNIJEPxF60eeSpWqK2iUdLZf5etUngzsO9
	HzW38IBB3D9PQ+PuqNu8/h8GA6hNEXWe5+QRC
X-Google-Smtp-Source: AGHT+IHP0thJ3IfszJGzZcpP+R74Kc26OgXngs+JZSNbU/9vph6eKbckbn8ri59lW7+7X5haIuncJKh5sYz2LzBOcqY=
X-Received: by 2002:a05:6830:4890:b0:715:4cb1:4409 with SMTP id
 46e09a7af769-717d65d8bc4mr13549998a34.31.1729096486089; Wed, 16 Oct 2024
 09:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016152407.3149001-1-snovitoll@gmail.com>
In-Reply-To: <20241016152407.3149001-1-snovitoll@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 16 Oct 2024 18:34:05 +0200
Message-ID: <CAG_fn=WTUXdGH+1oKx8LSwDXrFFMz3Fy1XZUAcbw3TmFmpopFg@mail.gmail.com>
Subject: Re: [PATCH] x86/traps: move kmsan check after instrumentation_begin
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 5:23=E2=80=AFPM Sabyrzhan Tasbolatov
<snovitoll@gmail.com> wrote:
>
> During x86_64 kernel build with CONFIG_KMSAN, the objtool warns
> following:
>
>   AR      built-in.a
>   AR      vmlinux.a
>   LD      vmlinux.o
> vmlinux.o: warning: objtool: handle_bug+0x4: call to
>     kmsan_unpoison_entry_regs() leaves .noinstr.text section
>   OBJCOPY modules.builtin.modinfo
>   GEN     modules.builtin
>   MODPOST Module.symvers
>   CC      .vmlinux.export.o
>
> Moving kmsan_unpoison_entry_regs() _after_ instrumentation_begin() fixes
> the warning.

Thanks for taking care of this!

> There is decode_bug(regs->ip, &imm) is left before KMSAN unpoisoining,

(side note: decode_bug itself is inlined into handle_bug(), so it is
not instrumented, and no bugs are reported in it)

> but it has the return condition and if we include it after
> instrumentation_begin() it results the warning
> "return with instrumentation enabled", hence, I'm concerned that regs
> will not be KMSAN unpoisoned if `ud_type =3D=3D BUG_NONE` is true.

So far the only caller of handle_bug() passes regs to
irqentry_enter(), which unpoisons them anyway.
I think this is fine, adding an extra instrumentation region around
kmsan_unpoison_entry_regs() in handle_bug() would be an overkill.

>
> Fixes: ba54d194f8da ("x86/traps: avoid KMSAN bugs originating from handle=
_bug()")
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Reviewed-by: Alexander Potapenko <glider@google.com>


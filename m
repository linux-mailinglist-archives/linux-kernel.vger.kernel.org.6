Return-Path: <linux-kernel+bounces-387110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3BF9B4C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D0D2848C2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DE0206E9A;
	Tue, 29 Oct 2024 14:27:00 +0000 (UTC)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9C820696B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212019; cv=none; b=Mr310/qfNH18k9+/+JnfoxwpR44pF2AcUWZTWZS/dYWidqm2xIBC3eCDyWLmnWPIuIYGtQq1KRcGjvDWbDVeoPORwVI27DuvyDTcMBqEN+m/J1zzhvP/p3048G0TkO6T7+WyjQKZapocvgKTmwTks/5AzvQRXvibUhQvqXe3P2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212019; c=relaxed/simple;
	bh=DOXptG8Kow14Aw246/i3uFt5Vrh09/WvRarRGwQLMoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsMMtzx3rv6wTIYtLAu5dR3zRyEdeHQYfbmThe+XchQWKtSC9MCFAfSwm7vH9Gk41GlHWJw9Y6njlwI9XiTkyPFL1dmEB4gLNqfB3unWZsTKuxlOtDPc0yIlLPQQ8kWy3AVHfAywIF2211zwnZvdGOYCfQlW3uLsTOTrCRxa6oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e2e2ef2e906so5652408276.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730212015; x=1730816815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3XT0mztU90dTLyu/zMIy6CbR4DNtOCuotLUVWn9+uk=;
        b=B1Gs9DR0mBaSsFjVb6lyXL+yJYH6+BUGAQ6KG2H6f3xhoHsTjq9Y+g8Vjh1yHrpjI7
         vU3tlikXQOM6ozbYjc14R7KYYnQaLDvicjtkScBLKlTjtQ5WqnAahOqku9CHFEowUgvj
         rVqVSpR3I9lehhPECdfL8q+1jU6gImxpYIVw0zxKW/C/1zy+mvRInsIl/6Kx2krsLRjp
         Wq/FGN9TYioYoa7tjbCVj1vEp1oxUPG6tsEHCVxOSGjaiaeljlRMf/HAkeQEBlAPJ52H
         otMJV1AzSAfYH1WY1zlKQQlAWZjRrnMzHsyS41xdvLOm+M3gyIBs2LucB+4JrfqZUsml
         fEKA==
X-Gm-Message-State: AOJu0YwvOcjYIcoGKXmebKfV9EL2S1L5yAsQySnIDmV9PNWk7JMIUeU5
	NtSmoPbSTDziiK9gT01D8KI3NFNYdJfN5e4o0avnBk5jBmu4cBQ2cR2OILJ3
X-Google-Smtp-Source: AGHT+IFSULdZTK/zPD0JZ87M95ygB3nr6Y2QjAFgOY4Wf6xQFXBNsMDRcg4Ria5ijqaRYv48908Kgg==
X-Received: by 2002:a05:690c:3203:b0:6e2:83d:dfb4 with SMTP id 00721157ae682-6e9d8b1d84dmr90715797b3.34.1730212015308;
        Tue, 29 Oct 2024 07:26:55 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6bb009esm19508937b3.22.2024.10.29.07.26.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 07:26:54 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e9ba45d67fso47525037b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:26:54 -0700 (PDT)
X-Received: by 2002:a05:690c:62c5:b0:6e5:cb46:4641 with SMTP id
 00721157ae682-6e9d89f2d6bmr134010557b3.13.1730212014504; Tue, 29 Oct 2024
 07:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926-regmap-maple-idiomatic-v1-1-685258a00a05@kernel.org>
In-Reply-To: <20240926-regmap-maple-idiomatic-v1-1-685258a00a05@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 29 Oct 2024 15:26:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW6KvV+HQPY28ASeGJo_xejqRFFatmFD_2ST9R+Gt-d0Q@mail.gmail.com>
Message-ID: <CAMuHMdW6KvV+HQPY28ASeGJo_xejqRFFatmFD_2ST9R+Gt-d0Q@mail.gmail.com>
Subject: Re: [PATCH] regcache: Store values more directly in maple trees
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Liam Howlett <liam.howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Thu, Sep 26, 2024 at 12:20=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:
> Currently the regmap usage of the maple tree is a bit non-idomatic, rathe=
r
> than storing register values directly we allocate arrays of contiguous
> register values and store pointers to those arrays. This is all quite
> fiddly, especially around adding values (where we may need to combine a n=
ew
> allocation with adjacent ones) or dropping values (where we may have to
> keep parts of a contiguous block). One reason for doing this is that the
> maple tree wants to store pointers rather than integers, and in particula=
r
> has some problems when we want to store 0 as a value.
>
> For 64 bit systems we can take advantage of the fact that regmap only
> supports 32 bit values and store values with an extra high bit set in the
> maple tree, avoiding the special cases with 0 and allowing us to save a
> layer of indirection. This approach was suggested by Liam Howlett.
>
> That doesn't help 32 bit systems though since we don't have any non-value=
 bits there. For those we
> can keep the same code structure by switching to do a separate allocation
> for each value. The resulting data structure is not a thing of beauty but
> the code is much less complicated, and should be able to make better use =
of
> the slab allocator in cases where contiguous blocks of registers are not
> powers of 2.
>
> Let's implement these two approaches, using CONFIG_64BIT to choose betwee=
n
> direct storage and allocating per-register storage. The end result is muc=
h
> simpler, making more direct usage of the maple tree API and the detailed
> optimisation work that goes into it's implementation. One indication of
> the simplifications is that even with having the two different allocation
> strategies we still have an overall negative diffstat.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Thanks for your patch, which is now commit 49a85851b14cf663 ("regcache:
Store values more directly in maple trees") in regmap/for-next.

I started seeing intermittent memory corruption reports during s2idle
on Salvator-XS:

    BUG: KFENCE: memory corruption in
regcache_maple_sync_block.constprop.0+0xcc/0x1c8

    Corrupted memory at 0x00000000ba391541 [ ! . . . ] (in kfence-#12):
     regcache_maple_sync_block.constprop.0+0xcc/0x1c8
     regcache_maple_sync+0x140/0x1b0
     regcache_sync+0xc8/0x208
     vc5_resume+0x28/0x54
     dpm_run_callback+0x5c/0xc8
     device_resume+0xf8/0x1d4
     async_resume+0x20/0x34
     async_run_entry_fn+0x34/0xec
     process_scheduled_works+0x2e8/0x4a8
     worker_thread+0x150/0x1dc
     kthread+0xe4/0xf4
     ret_from_fork+0x10/0x20

    kfence-#12: 0x000000003219df44-0x0000000074811d38, size=3D4, cache=3Dkm=
alloc-8

    allocated by task 1058 on cpu 6 at 694.672934s (0.104605s ago):
     regcache_maple_sync_block.constprop.0+0x70/0x1c8
     regcache_maple_sync+0x140/0x1b0
     regcache_sync+0xc8/0x208
     vc5_resume+0x28/0x54
     dpm_run_callback+0x5c/0xc8
     device_resume+0xf8/0x1d4
     async_resume+0x20/0x34
     async_run_entry_fn+0x34/0xec
     process_scheduled_works+0x2e8/0x4a8
     worker_thread+0x150/0x1dc
     kthread+0xe4/0xf4
     ret_from_fork+0x10/0x20

    freed by task 1058 on cpu 6 at 694.673657s (0.164678s ago):
     regcache_maple_sync_block.constprop.0+0xcc/0x1c8
     regcache_maple_sync+0x140/0x1b0
     regcache_sync+0xc8/0x208
     vc5_resume+0x28/0x54
     dpm_run_callback+0x5c/0xc8
     device_resume+0xf8/0x1d4
     async_resume+0x20/0x34
     async_run_entry_fn+0x34/0xec
     process_scheduled_works+0x2e8/0x4a8
     worker_thread+0x150/0x1dc
     kthread+0xe4/0xf4
     ret_from_fork+0x10/0x20

    CPU: 6 UID: 0 PID: 1058 Comm: kworker/u33:9 Tainted: G        W
      6.12.0-rc5-rcar3-05681-g29cac4e36a79 #148
    Tainted: [W]=3DWARN
    Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (=
DT)
    Workqueue: async async_run_entry_fn

While I did not bisect the issue, this change looks suspicious to me...

> --- a/drivers/base/regmap/regcache-maple.c
> +++ b/drivers/base/regmap/regcache-maple.c
> @@ -13,26 +13,53 @@
>
>  #include "internal.h"
>
> -static int regcache_maple_read(struct regmap *map,
> -                              unsigned int reg, unsigned int *value)
> +#if IS_ENABLED(CONFIG_64BIT)
> +/*
> + * On 64 bit systems uintptr_t will be 64 bit but unsigned long 32 bit
> + * so we can store the register values directly in the maple tree.  We

... as this assumption is not true: "unsigned long" is 64-bit on
64-bit platforms (and 32-bit on 32-bit platforms).

> + * need to always set an out of bounds bit due to maple tree's
> + * handling of NULL.
> + */

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


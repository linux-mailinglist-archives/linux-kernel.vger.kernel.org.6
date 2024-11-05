Return-Path: <linux-kernel+bounces-396625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B45D9BCFB6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5EE1C233B9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917821D47AF;
	Tue,  5 Nov 2024 14:48:57 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A124084D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818137; cv=none; b=qYwz/i/B2oMa3gYs2ZYGiNnp63gyO1dhjTY24AdiKqfCHQbruTJxnrbH91AH/ulyhnf28fsPm660DBb3L4Sh+vHNUdG2HRacyZRA8KCL7chzBw6Syn9+VWTfNTS151atA7vOsSpdMksBj0jFkg+jOwIxhIjbigbvtbs508+zgUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818137; c=relaxed/simple;
	bh=f4xXPtr/rczFDWSCXCnLBmqWV3vrsWDra9h8vOvQoLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qp49Q34qrU6u+jqsScXkU7NZIfhR1MruP2UHjRC9yDT37Vnj8QrNL0ZbKmxbF/leVDVbqsTROziGHktT1IAvfZBsL2Kh6ez1QEc40dKURmbGPczuTY+3BiMBuPIm6jnDYIo+C44qAjxxSr/Cq+KkaI8vd46D/Y3V62sqbOBPIhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ea7c9227bfso9322967b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 06:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730818133; x=1731422933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=062wwg7reCXnZ2jiwUr0t2popBMcfyNM3miSTWB1lmU=;
        b=HA437fvrRVKQ+9Y+QB7iT8uZh26qth8fteRuKKyv81tgf2hHOpOMjpAKOg3cvzFKLx
         ur3PCrsDZpyGofGyME2GKRrS5JF3hx3eWecPnr04ahkB4TrlwGeLSlyDb+X1Jq/mdEPL
         detDJE4UOKUrDhUVw81iuoMgln+hrcPK3NynFXOJHrFfHPpWqZl9aiTqZKK61k4/xArE
         QntMVepgaEDBosC3W9rVdHCT9emVUAvzNMJT96951hzUOxlD/mMvrQOkr2btIu3KT9OA
         mZGKP70i/1OW02+r60uCRhmY9o7eRsZReobIlJjs5YG0HoxHTQvGrVuyPEyYPkugJLAz
         3kXg==
X-Forwarded-Encrypted: i=1; AJvYcCUoURWtHkzdISSykpsxdEi0REPtwr3opWKYIs28Uis8aWmW3ASj1y65dIcMY+TebVtxTxHyJTf3DNsAbfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaXLuh8h4ThN+s96Pevqi47ltFZPzCfIOL+36LULk2crZnyWIp
	otSDvcWwYs028STTvPH1K+H1A5QXXQYexAVyZTmmvHmchPYsaAxX+qn+9XOi
X-Google-Smtp-Source: AGHT+IHIwb/No5kBAH+lgvorZrkMWM2GwTfszKpXnfMkuQ1OllXzVObPgCFfY8Zsb+ywFHgz7JwTew==
X-Received: by 2002:a05:690c:9690:b0:6b1:8834:1588 with SMTP id 00721157ae682-6e9d8b00311mr346961837b3.35.1730818133430;
        Tue, 05 Nov 2024 06:48:53 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea8082cb2dsm14217297b3.12.2024.11.05.06.48.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 06:48:52 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e38fa1f82fso6928167b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 06:48:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1qYYXoo4bdsExqaYWT40I8nvMSQQNxTxckrsqNvez6YFtzchxnGZfqnbrkpU7LjXNRy/LVR0WPlt4Bgc=@vger.kernel.org
X-Received: by 2002:a05:690c:ed3:b0:6e2:1527:446b with SMTP id
 00721157ae682-6e9d896200bmr337335377b3.3.1730818131998; Tue, 05 Nov 2024
 06:48:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b6112556472c657762f064ec5328f153e3ed03cd.1727926187.git.fthain@linux-m68k.org>
In-Reply-To: <b6112556472c657762f064ec5328f153e3ed03cd.1727926187.git.fthain@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Nov 2024 15:48:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXR6gN44MiE3Nc-bU6u92_RA2PWx37ndBKA7AD+gKErTQ@mail.gmail.com>
Message-ID: <CAMuHMdXR6gN44MiE3Nc-bU6u92_RA2PWx37ndBKA7AD+gKErTQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: mvme147: Reinstate early console
To: Finn Thain <fthain@linux-m68k.org>, Daniel Palmer <daniel@0x0f.com>
Cc: stable@kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Finn, Daniel,

On Thu, Oct 3, 2024 at 5:32=E2=80=AFAM Finn Thain <fthain@linux-m68k.org> w=
rote:
> From: Daniel Palmer <daniel@0x0f.com>
>
> Commit a38eaa07a0ce ("m68k/mvme147: config.c - Remove unused functions"),
> removed the console functionality for the mvme147 instead of wiring it
> up to an early console. Put the console write function back and wire it u=
p
> like mvme16x does so it's possible to see Linux boot on this fine hardwar=
e
> once more.

Thanks for your patch!

> Cc: Daniel Palmer <daniel@0x0f.com>
> Cc: stable@kernel.org
> Fixes: a38eaa07a0ce ("m68k/mvme147: config.c - Remove unused functions")
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> Reviewed-by: Finn Thain <fthain@linux-m68k.org>

As this patch differs from Daniel's original, I guess you want

    Co-deloped-by: Daniel Palmer <daniel@0x0f.com>
    Signed-off-by: Daniel Palmer <daniel@0x0f.com>
    Co-deloped-by: Finn Thain <fthain@linux-m68k.org>
    Signed-off-by: Finn Thain <fthain@linux-m68k.org>

instead?

> --- a/arch/m68k/mvme147/config.c
> +++ b/arch/m68k/mvme147/config.c
> @@ -33,6 +33,7 @@
>  #include <asm/mvme147hw.h>
>  #include <asm/config.h>
>
> +#include "mvme147.h"
>
>  static void mvme147_get_model(char *model);
>  extern void mvme147_sched_init(void);
> @@ -177,3 +178,29 @@ static u64 mvme147_read_clk(struct clocksource *cs)
>
>         return ticks;
>  }
> +
> +#define SCC_DELAY do { __asm__ __volatile__ ("nop; nop;"); } while (0)

Please keep on using a static (inline) function instead of a macro.

> +
> +static void scc_write(char ch)
> +{
> +       do {
> +               SCC_DELAY;
> +       } while (!(in_8(M147_SCC_A_ADDR) & BIT(2)));
> +       SCC_DELAY;
> +       out_8(M147_SCC_A_ADDR, 8);
> +       SCC_DELAY;
> +       out_8(M147_SCC_A_ADDR, ch);
> +}

The rest LGTM, so
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

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


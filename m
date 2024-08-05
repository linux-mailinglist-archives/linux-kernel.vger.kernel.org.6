Return-Path: <linux-kernel+bounces-274263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 475A69475CD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D9A2813A3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE601448C1;
	Mon,  5 Aug 2024 07:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zzLXtsSx"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6883117C68
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722842171; cv=none; b=PPBECAbiPLlVXtpvaOTZ6SDtObfWepfBxlZ+QaNWvRo81aPifz1XaVTo/uMfWb9SLZd0Ci6LKdF3c46jZT1O6YrazM5uaK8YdV4Vb4yeRsZXxwGdFPgF2J20oDKc6uuealjwcH9S/rY8KTbflS532BnxGy0iU+tKv5TqZ6njFtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722842171; c=relaxed/simple;
	bh=QuGkeZCS0vmA2EGG8/E6V+N/7CEyqxXlFwzK/1mweGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ioW6xNBN3O4m12g18fFyLRBIMtgub0a+zqN2tqZ4YvxhlbLkhhq/SSYWKg04xJELobcEsSJG7FtduRhovZdT5v9glnxQbR6loUxD/gFekGN0Llg/v9JnpoRt7toKKfH7j3OuCGE0KVRG4gJe1MZhMzKcXUjX9Sp4CyMWsrNibM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zzLXtsSx; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52f0277daa5so15882370e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 00:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722842167; x=1723446967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1HgahZErKvyf0fnLV2ZxSZ9HrSzv9jqWuvKKwc1ntU=;
        b=zzLXtsSxjVKvDAAPyGNr5+hea7uR0T+ANRObx6LxvZ1nB2/hjaGn67v66HkL0qdYbW
         czEhOV959Bi2SPdBacJ1M0u1Q8/RLGUGdGk58pGb74kWwFjaTIqseaUo64xP//kDAGZI
         Nt+6Q6ByHGj8ElqevhEUCB6nJoUuHHC1vVqn5XKZoO+HiXauzvnRNugcjYC2U6Qv1iBJ
         5SwBUKqghgZLLJ4AQVGLRLBn8fQaTjoEF09Wlp1pr1Jl3367RjZiYjTN9GaHHxGy+PIB
         fTo4VgBWE9SgAzZEXGtLVHO1knrdqdy9Qr0QPAhraDAhS6eRJHmUcjpga7pxsliCcj9m
         dMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722842167; x=1723446967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1HgahZErKvyf0fnLV2ZxSZ9HrSzv9jqWuvKKwc1ntU=;
        b=a14UCE8dVtJfju+jZY+fUJOPnfS93NU5CYAj0nGPddtE+0geL+48pKIRokSE1/4qHD
         q24emMhuWZRPY/EaJnC/z4Z5qpsPPBR5BedIN49STuYuzaxGRKGj567X58Yp+UCH3W0T
         8HduIeVwF4OF+UsnknfnQmUXAI06xEeNoP6mZfhE8AIDUAKQ9RLF7MkiL/dpoHqwWXD8
         1xJf6W4GJ1hvMZwPoFf6YFLlUbam3HJOojpGSSdyp7iM+d/YSvBPNJCQqVmO0OtbLMhK
         X4561iKOSrTXMHbRG4gU0kumhHfDC2JSS/72fd8Js230r3WyJ0jHw/imtkdFBAd5+1V3
         73/w==
X-Forwarded-Encrypted: i=1; AJvYcCXwiEn28AILZeJhU2pzlzoJhT7EPJVSSmMt8ZwrkNDqRix9A2B+lamSoTuKTlXmSZn+w3O1FAZVopXGGFz7aTWqqKlRDkDDHT2rRwJr
X-Gm-Message-State: AOJu0YxcqqH8YAZaT8/blrZ1bT/phpqBJAp/QUtGcfwmu/RhH5AIp2R6
	VX5Vo8VM4WjcRe9LQO5OSPDz8wfqC1s+C9Z/8X9kQy3H/BBJMhhLGzrLP8wOZ61tNwqGSH8I116
	bEF7kQWGhKzGp5x6qd8AwxxFZ0tzemCl70MHGlQ==
X-Google-Smtp-Source: AGHT+IGqDa7Mip4T5Ze4gJNuIM7yryOJ7VNW9gtRF+kE/YxZtKeRspxCkSMK2y9gAbawEf0T16gIsNMCKgatq/4Jndw=
X-Received: by 2002:a05:6512:1253:b0:52c:dd3d:85af with SMTP id
 2adb3069b0e04-530bb379522mr7294063e87.25.1722842167351; Mon, 05 Aug 2024
 00:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708133348.3592667-1-ruanjinjie@huawei.com> <20240708133348.3592667-2-ruanjinjie@huawei.com>
In-Reply-To: <20240708133348.3592667-2-ruanjinjie@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Aug 2024 09:15:56 +0200
Message-ID: <CACRpkdbY-Lp7_AyqvLnQCFYkaazsmMGSHY5K85oJRNmPgM_yVA@mail.gmail.com>
Subject: Re: [PATCH 1/3] crash: Fix memory reserve dead loop bug in reserve_crashkernel_generic()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux@armlinux.org.uk, bhe@redhat.com, vgoyal@redhat.com, 
	dyoung@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, arnd@arndb.de, afd@ti.com, akpm@linux-foundation.org, 
	rmk+kernel@armlinux.org.uk, eric.devolder@oracle.com, 
	gregkh@linuxfoundation.org, deller@gmx.de, javierm@redhat.com, 
	robh@kernel.org, thunder.leizhen@huawei.com, austindh.kim@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 3:30=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com> =
wrote:

> If the platform do not support memory above 4G, such as 32 bit arch,
> and CRASH_ADDR_LOW_MAX is equal to CRASH_ADDR_HIGH_MAX, the high
> crash kernel memory reservation is meaningless and it will cause
> dead loop and system stall:
>
> -> reserve_crashkernel_generic() and high is true
>  -> memblock_phys_alloc_range() fail and return 0
>     -> search_end =3D CRASH_ADDR_LOW_MAX(same as CRASH_ADDR_HIGH_MAX)
>        -> call memblock_phys_alloc_range() again and fail agin.
>           -> search_end =3D=3D CRASH_ADDR_HIGH_MAX satisfy again
>         ......
>
> However, the current check only considers the case where
> CRASH_ADDR_HIGH_MAX is greater than CRASH_ADDR_LOW_MAX. Fix it.
>
> Fixes: 0ab97169aa05 ("crash_core: add generic function to do reservation"=
)
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Looks good to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


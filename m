Return-Path: <linux-kernel+bounces-525849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43457A3F644
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2596916ED1C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B015F20CCF5;
	Fri, 21 Feb 2025 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwRMPVs6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C27C1C3BEE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145343; cv=none; b=UQzhBn9RmE+uFqmJahU5Ts9kok9ceInfkERDchvRxmiO5jVNGP7NfAgkaGXwLjAXwpYPqSylKpk4OtR7sfwiBiUYeoQ2QZthb5RUG6toXUZZisxVXDCp+QoEFVllM+PL8YrWaxJVLU8GmJTr3tyiCHf1TkNYDWLYOOLFEA+bJP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145343; c=relaxed/simple;
	bh=xBM6ZmSN0PndIHe7wKwSBCjgPYHbYHZDY3PSVng7AB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F97qU33tDZepR3SeaguTTUtRqOOj6gfCWT9ChfXVJG6jy+m6wCy7x9vloxPtJ8pNfibFgPe6LXXeuI40qUzvX/6kv58fTNIkiHzuipueMBA/4nUMTgRReZPSGqaJZisp+ULhFuvCBgPO901Wwp5gOqi4NHU5ll7gvRQruv24x3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwRMPVs6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2968C4CEE7
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740145342;
	bh=xBM6ZmSN0PndIHe7wKwSBCjgPYHbYHZDY3PSVng7AB4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lwRMPVs65iuTKaaE9k4HBw7NASEciuD9iUHsN+6oQ+1yKBKaZ13alrFBs8cmGnuC/
	 veWxrYITXLV8BpffFcZQog6CQbjFWr2xiTejUacih/vbi4HI/KGhluA4NaKlpVc+sm
	 DL4W0UCIfQ6IXjRsDgUAnsxaMp//47m9w7peyx5VS+dJu1AubS3KHxrukw8zvf4+9b
	 gNObSO0kPYOGc6w2tq5C9VK9aIzCW1Y5tO99BNKZhzFEDkM849Bxb5BjrKLK+pXy4+
	 oUzGDWnBdourJXViJF6vL66XJ8OX2jPNTT8cV0TLmsCJ5cc8FeKHiTKXMKrt+pAw+g
	 dm1bCjTvXEJ6w==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abb75200275so341199166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:42:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWmvulUETyD0WklVKMfx8mfov7fGRZlq2HHwBNQk8CfTKCcZZaq8MGGW4rXArzZiM+445SPIyfwjPi/1vw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi2Wb49/tL8Vyvvwy2e3fyymfY0GzhQ+fj1RNIQ/qcenxMLnb/
	zNc+NrhkRpQ5njD8+hqjUGPlBfBm/Llun509pZjztLTUV3PkcahahKECNHHHfsvR6WKN0oDMByD
	dOjPP/fMcySxbzU3GLVoaNnNnqwY=
X-Google-Smtp-Source: AGHT+IECcLIJ8P9b1c0Hv/sg8PUfBVbf8vqg4ZXC/cdYTtD8V7DLBxdGxLT63W+MRg0G8yD7HdckYJ5k7/zBW5TpI34=
X-Received: by 2002:a17:906:3712:b0:abc:b8c:7b2d with SMTP id
 a640c23a62f3a-abc0b8c7d83mr243228666b.32.1740145341138; Fri, 21 Feb 2025
 05:42:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221073249.481731-1-maobibo@loongson.cn>
In-Reply-To: <20250221073249.481731-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 21 Feb 2025 21:42:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6-cH1a-ghgGAp2aOp8MF09YMwj3bCXESLts==d8_4m3Q@mail.gmail.com>
X-Gm-Features: AWEUYZlohGVxTTSsgoNKxleTI1vMKNnOqVfV4ux_ldKPWxHtoW87QC0yXzL7mfM
Message-ID: <CAAhV-H6-cH1a-ghgGAp2aOp8MF09YMwj3bCXESLts==d8_4m3Q@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Remove unused option with HAVE_VIRT_CPU_ACCOUNTING_GEN
To: Bibo Mao <maobibo@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Fri, Feb 21, 2025 at 3:32=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> Option HAVE_VIRT_CPU_ACCOUNTING_GEN is selected by default in kconfig fil=
e
> arch/Kconfig. It is meaningless in file arch/loongarch/Kconfig, and on th=
e
> contrast it may bring out misunderstanding. Here remove it on arch
> specified kconfig file.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 2b8bd27a852f..7fd5708fe14a 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -175,7 +175,6 @@ config LOONGARCH
>         select HAVE_STACKPROTECTOR
>         select HAVE_SYSCALL_TRACEPOINTS
>         select HAVE_TIF_NOHZ
> -       select HAVE_VIRT_CPU_ACCOUNTING_GEN if !SMP
Please see 01f135506e2ed0403512 ("powerpc/32: select
HAVE_VIRT_CPU_ACCOUNTING_GEN"). Now HAVE_VIRT_CPU_ACCOUNTING_GEN is
available on both 32BIT and 64BIT, so I think a better solution is
unconditionally select HAVE_VIRT_CPU_ACCOUNTING_GEN which is
convenient for the upcoming LoongArch32.





Huacai

>         select IRQ_FORCED_THREADING
>         select IRQ_LOONGARCH_CPU
>         select LOCK_MM_AND_FIND_VMA
> --
> 2.39.3
>
>


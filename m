Return-Path: <linux-kernel+bounces-433136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A479E5447
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08E3283A1A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2158920CCE4;
	Thu,  5 Dec 2024 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVYpoIm/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787ED20C47B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399073; cv=none; b=gTDnKapuzHf5Wqcf3L37644kCpwiZNtyNRcDV8hOgZfYw2jivPKK3FUegcLUz3nKagWmAVEgtF8u+o8G/iMQOcYIMumQwJfc2n00ixmg4MImNB827Kc+Y7zfkx2vpuwEDGlsxK1GawKyUGS8jSRG2u/+kWIV1PcxaUWeREwp/VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399073; c=relaxed/simple;
	bh=Py5bki7QdXsXPfkQ5rPJq9xsIyXUQ/suzuBUEPT0RXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwwg52LUGJp2Y5q5K5YOxNO+xbvXxhnA9AmrYFqyknn105mW1/BvnpH2hiebegi6MropawWFdOeTAH/zx3QaKgKIdQeFZsGBSmiT1nbYO2VaxFpv90pykSgGcJZFGAOvetTg6sq8uahp0tEZ3UlUTvvyiZE3iWZdDKGP6iD1ufo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVYpoIm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B104C4CEE1
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733399073;
	bh=Py5bki7QdXsXPfkQ5rPJq9xsIyXUQ/suzuBUEPT0RXQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mVYpoIm/zMJ58SyCAObuq8SVw7E+fQcvwlcxuyftk/QEj5iixY/rHtgjVLI1kF5R/
	 d71jWvb43HyEMucLpmFj71SWaBOM1BxvSHY5cM/jQa8Xp6ACt7QUejxRbYHEOmoDVD
	 efgDn2+x5ICdjQuW6ph3yU6B7+VG2DJfesl1Id/dIzWZsz+O27Ys/DwSqlYzNouiFb
	 vk60coTYsr8SNMM5N1XtYEQEIgsdaK5GMfvjQRx2etwd74yJ3XfnKOC485GXXk7zfs
	 BleKxm/l+aaJWEjRhQwSSDfDJuhBLh/oaGlqHHvm+97RRok3AwV21ioLFcTKX3/l/X
	 hznFRXdfgKHbA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53de880c77eso911241e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:44:33 -0800 (PST)
X-Gm-Message-State: AOJu0Yyr3/pZt4vLAyw/7rhICHyewERoHEjHBGpjV05ZFu0gWpArLvTA
	7CpDrkQSeyfWOTi86sTWk6vdVsscCDTSgPfCZe6UaWVQffIUbuixbz57t6owsUrNLopFGQdp0vI
	Kv05AOoWWBnp28KrSBVuZ3dGRPFQ=
X-Google-Smtp-Source: AGHT+IGkihPr/yVVFJ84vAig1WaNhL6jA0Dvh3M4ZitxbpWVEL2tGof1zPXPHQqBaODoEx1c4Fgu4RXGNcMKHz1LY+o=
X-Received: by 2002:a05:6512:10d6:b0:53d:d3ff:83bf with SMTP id
 2adb3069b0e04-53e129f2c19mr4769274e87.18.1733399071697; Thu, 05 Dec 2024
 03:44:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105155801.1779119-1-brgerst@gmail.com> <20241105155801.1779119-3-brgerst@gmail.com>
In-Reply-To: <20241105155801.1779119-3-brgerst@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 5 Dec 2024 12:44:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEWJVhCrH0AzgEbBXsQYTAuwmUxR2kLJDU2vzVxx8GY-A@mail.gmail.com>
Message-ID: <CAMj1kXEWJVhCrH0AzgEbBXsQYTAuwmUxR2kLJDU2vzVxx8GY-A@mail.gmail.com>
Subject: Re: [PATCH v5 02/16] x86: Raise minimum GCC version to 8.1
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Uros Bizjak <ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Nov 2024 at 16:58, Brian Gerst <brgerst@gmail.com> wrote:
>
> Stack protector support on 64-bit currently requires that the percpu
> section is linked at absolute address 0 because older compilers fixed
> the location of the canary value relative to the GS segment base.
> GCC 8.1 introduced options to change where the canary value is located,
> allowing it to be configured as a standard percpu variable.  This has
> already been done for 32-bit.  Doing the same for 64-bit will enable
> removing the code needed to suport zero-based percpu.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---
>  scripts/min-tool-version.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> index 91c91201212c..06c4e410ecab 100755
> --- a/scripts/min-tool-version.sh
> +++ b/scripts/min-tool-version.sh
> @@ -19,6 +19,8 @@ binutils)
>  gcc)
>         if [ "$ARCH" = parisc64 ]; then
>                 echo 12.0.0
> +       elif [ "$SRCARCH" = x86 ]; then
> +               echo 8.1.0
>         else
>                 echo 5.1.0
>         fi

There appears to be consensus that we can bump this to GCC 8.1.0 for
all architectures:

https://lore.kernel.org/all/20240925150059.3955569-32-ardb+git@google.com/


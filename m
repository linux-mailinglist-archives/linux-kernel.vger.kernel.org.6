Return-Path: <linux-kernel+bounces-347447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6FB98D2DC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C281F230BC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470AA1CF7AA;
	Wed,  2 Oct 2024 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sapp68VD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37671CF5F8
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871246; cv=none; b=maAPFIM1jHQQcyUHew8JdOKoWVYLMPm2sp16o05ezq1OCkYxgKullRt6a5Miw3HioYHrzBTNQ1HgEAD4dEyH/2u64pboq54gWFr+IL+FdkSY3LOKDx3t/9ejhBZl0JDkX1kzqS82HlerflBo+/Er4Ri1Ot5ELI150ht0lvkWIUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871246; c=relaxed/simple;
	bh=eQObt6haSbCc8UAE4BkFEv2bQrCW2bYm6WqI7gWVZXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bAzwL0TdWZbh7bvF+LYMIhiXPwNsr4qQ4LKPbq3VFu9QIitPDNMrEw5p9CYyoi9fcYbvLQpybeT06D4D6z36njU9HkMgd4JcgWEt2fOA4UUFaYViC4nligX+58wbExwLBy/8uNX2CBW5ki841OAglPL5ZG5D9CxJUmE6Srqwk48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sapp68VD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC01C4CEC5
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 12:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727871246;
	bh=eQObt6haSbCc8UAE4BkFEv2bQrCW2bYm6WqI7gWVZXE=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=Sapp68VDWifAQXwqTPBaYUENX0KQjeh5+fUt49448otxfQPm8X3Amxul+lGNl32HZ
	 mQ39W2CkTNE4CmPttfa/SJlwUqCdSmAML6mpZIlO1Co3Zjp4bFBOkM24+8eAzRCvvP
	 aiBrYzoejwxO5Q7ZTzbA47qLNR89dgyC8Kft4xN2O0d80iZKgFaiC7iYWZVAQkiKHL
	 5uJ68yvrz2oUT+euDscNZJXOCjRAyEw2tiqy3dlKz5y6PrAWX4BSKT044GVqE6BD9s
	 z3Kc5Aw/7laSxj9FNz2avcLVNK9K2fGQhPqj6UeckbNU+ZMhdqWcsHFITbzQsKEk7O
	 ZIVtvGJGSUvew==
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e251eda7f03so657612276.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 05:14:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUF4Me+XRFZj856bFCatMcrLaUjQaMaHFmwQKrw2kI1X7KivBOfIHO3CP1kt+MVEHmaUZ6aQcGbtjWGG/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwbg0fcBjU8SzaVctcQlzvWIHvwiOfXSbmeBI9qON/wwB4ffUb
	ir3kFcW4HNkGGyzCcMGi3i7t9VgS/dwbHl/IRhN/H0mlhE1A0glqZ/GhnhYupXfnptiaZIusMGm
	Rv4HUMMdgXpVANWXq9lwR9zPXVu0=
X-Google-Smtp-Source: AGHT+IG53FUqvULfZPRnQJyxWM8oKz3X7D31rZ4wbgYPmjs+/RVWTMSDmDgZqGgT0N0XlR/H3Nf6wJ0FbagiYNrmn1k=
X-Received: by 2002:a05:690c:3190:b0:6e2:41fa:9d4 with SMTP id
 00721157ae682-6e2a34ad25dmr18396017b3.15.1727871245456; Wed, 02 Oct 2024
 05:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913092122.19523-1-tiwai@suse.de>
In-Reply-To: <20240913092122.19523-1-tiwai@suse.de>
From: Josh Boyer <jwboyer@kernel.org>
Date: Wed, 2 Oct 2024 08:13:54 -0400
X-Gmail-Original-Message-ID: <CA+5PVA7QXBGG=tRjh6BVMdyU1hHj8DtOhQkVwiBOvpjtzASUmA@mail.gmail.com>
Message-ID: <CA+5PVA7QXBGG=tRjh6BVMdyU1hHj8DtOhQkVwiBOvpjtzASUmA@mail.gmail.com>
Subject: Re: [PATCH linux-firmware] copy-firmware: Fix incorrect symlinks to
 uncompressed targets
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-firmware@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 5:20=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wrote:
>
> The script tries to make a symlink to the target with the compressed
> extension, but it ends up with a wrong symlink if the compression is
> skipped for the target (e.g. via RawFile entry).
>
> Add more checks to make a correct symlink.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>
> This fixes the installation failure with the recent change for qcom
> commit 541f96c0fa47b70e9bc13035f7a082064e5b2d4c
>
> The workaround is pretty ad hoc, so if you have a better way to manage
> it, feel free to scratch this.

Juerg came up with something slightly different:
https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/297

josh

>
>
>  copy-firmware.sh | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/copy-firmware.sh b/copy-firmware.sh
> index 6757c6ce03a3..fc096dd6daf0 100755
> --- a/copy-firmware.sh
> +++ b/copy-firmware.sh
> @@ -136,9 +136,15 @@ grep -E '^Link:' WHENCE | sed -e 's/^Link: *//g;s/->=
 //g' | while read f d; do
>          if test -d "$target"; then
>              $verbose "creating link $f -> $d"
>              ln -s "$d" "$destdir/$f"
> -        else
> +        elif test -f "$target$compext"; then
>              $verbose "creating link $f$compext -> $d$compext"
>              ln -s "$d$compext" "$destdir/$f$compext"
> +        elif test -f "$target"; then
> +            $verbose "creating link $f -> $d"
> +            ln -s "$d" "$destdir/$f"
> +        else
> +            $verbose "creating link (not yet existing) $f$compext -> $d$=
compext"
> +            ln -s "$d$compext" "$destdir/$f$compext"
>          fi
>      fi
>  done
> --
> 2.43.0
>


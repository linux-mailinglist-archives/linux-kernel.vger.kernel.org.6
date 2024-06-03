Return-Path: <linux-kernel+bounces-199805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 685928FA627
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DDDE1F241C1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860325028C;
	Mon,  3 Jun 2024 23:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ICuYMLam"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380557E583
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 23:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717455762; cv=none; b=df0U/xDCsz0UDfAU+BU0/bDDJWVwUjcFFmUd6VeKfOSPWyKnqFye/oWRR3QYE/VxUCmy2tKsW2godaKOc44irWSpIaYgvuiHCVV189nmRgPabNs4GTz/1YceAG+KXbCdYmyA5X9cMknNb5HKhc33F/Wmc3L5opm9WqZEUJwjxaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717455762; c=relaxed/simple;
	bh=5tOD2pHjMWWdT8TSGj9EPKKaUP3pnp/j6cP/I84FMmg=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDIZ0YwQbevZidzypGg1rdgB32iziUcm7uInWIUsU3kOy3Lwommqq2+BCfgpNbpvTqjrcEoUl+fWuEzYHWnTonJhMIv7KI13EPg8Z+Xwr9qhpbIOs7ygy2/whH3ql6hSdBvZ8ahn8i+mkMoGXNM5mzPyE8jESfGQWyoO4qT7268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ICuYMLam; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5b9778bb7c8so2844198eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 16:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717455759; x=1718060559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggaQ6J5T1IxPl9jccfKKlkkSH+FkZbGLyq3WMqICX4c=;
        b=ICuYMLamE/chWrfVWwNlsbzjO57nSS56w+ONXVTWS8yzc71ECSuIjvJnPXBVCjYVkP
         PrscTxhX9+Z1SKVYBYdeB4JmFPj2qYnL45xhIWlO5snkkfLV+9CAmANwx6LhlLNqVdZG
         COsNljzFFRJpyjfhN6gQnaYAuD5bxwPSck6uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717455759; x=1718060559;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggaQ6J5T1IxPl9jccfKKlkkSH+FkZbGLyq3WMqICX4c=;
        b=qAL38kg/glIH25Ar0zGXLJy6fngOesW4yz7zIZFIZb3yYPQL+XzA+RnrL8ltZ0nrwQ
         Y33Z1IwJj6ucEjlVpfXpPeIktvwso6klLkNpqoKyt+L5zV7uKR6HnQ2bBoILjshK1FMQ
         fGLgAhXNNu6AAx+b4esnW8Pw4w1tmd1d/rbiLJldCR51oWZNVCCCWMI087zElMYIh7vn
         gfDVDPXFk0RIVRtcgbR3XpxscxNbqN/9YLbwDCoDzYEQ2IL1thfYdp5TRtLz7oJAAslz
         fZnHgtS6p/3Xhu9V+5oi0pV3xYHJFQqv9Oks9M6APK64bBot2Zht9w8v36Hd3ksYigDl
         FZGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXktQRBgoCs0wvUygk0T/lGXZ5/9GoamYHQj9qOPugyhmqD/cT2QIC8EwLVGaIZyfVeIGj9jtHezU+MvDhQqN8iO8vZf6FziG781yyg
X-Gm-Message-State: AOJu0YzJJrj39/I80aU5CbJ3hNqtFZOwoTKa2W3kLxgR62I39/JAleh7
	iyMSuPCiqXGS3VCnFZmS6pEKklj7XL11HS9v7Fw8MjMqyIx8mNN2LsrraROyIGuyClHt5HB87g8
	AH4a1Mct3HPTGy3epaa2q/vEtGLA5dXwkkhZz
X-Google-Smtp-Source: AGHT+IF7d/TDt2PvSfLYQF36A+sjUkHpPi0ohhg8rJGf+olIn56FTIptan9DUYCXFiaG4Z93Ic9j80AfvaYOMw8ZPZU=
X-Received: by 2002:a05:6870:d8d3:b0:24f:d6c1:692 with SMTP id
 586e51a60fabf-2508ba20045mr12189521fac.29.1717455759199; Mon, 03 Jun 2024
 16:02:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Jun 2024 16:02:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20221006224212.569555-8-gpiccoli@igalia.com>
References: <20221006224212.569555-1-gpiccoli@igalia.com> <20221006224212.569555-8-gpiccoli@igalia.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Mon, 3 Jun 2024 16:02:38 -0700
Message-ID: <CAE-0n50vo5xkUNK0-cF9HZRXShsxbikqmdVnmMzRsn+Z7MEJTg@mail.gmail.com>
Subject: Re: [PATCH 7/8] efi: pstore: Follow convention for the efi-pstore
 backend name
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: kernel-dev@igalia.com, kernel@gpiccoli.net, keescook@chromium.org, 
	anton@enomsg.org, ccross@android.com, tony.luck@intel.com, 
	linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Guilherme G. Piccoli (2022-10-06 15:42:11)
> For some reason, the efi-pstore backend name (exposed through the
> pstore infrastructure) is hardcoded as "efi", whereas all the other
> backends follow a kind of convention in using the module name.
>
> Let's do it here as well, to make user's life easier (they might
> use this info for unloading the module backend, for example).

This patch broke ChromeOS' crash reporter when running on EFI[1], which
luckily isn't the typical mode of operation for Chromebooks. The problem
was that we had hardcoded something like dmesg-efi-<number> into the
regex logic that finds EFI pstore records. I didn't write the original
code but I think the idea was to speed things up by parsing the
filenames themselves to collect the files related to a crash record
instead of opening and parsing the header from the files to figure out
which file corresponds to which record.

I suspect the fix is pretty simple (make the driver name match either
one via a regex) but I just wanted to drop a note here that this made
some lives harder, not easier.

>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  drivers/firmware/efi/efi-pstore.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
> index 3bddc152fcd4..97a9e84840a0 100644
> --- a/drivers/firmware/efi/efi-pstore.c
> +++ b/drivers/firmware/efi/efi-pstore.c
> @@ -207,7 +207,7 @@ static int efi_pstore_erase(struct pstore_record *record)
>
>  static struct pstore_info efi_pstore_info = {
>         .owner          = THIS_MODULE,
> -       .name           = "efi",
> +       .name           = KBUILD_MODNAME,
>         .flags          = PSTORE_FLAGS_DMESG,
>         .open           = efi_pstore_open,
>         .close          = efi_pstore_close,

[1] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform2/crash-reporter/kernel_collector.cc;l=54;drc=7a522166f0b2b32ece60f520b5d3d571c7545b0b


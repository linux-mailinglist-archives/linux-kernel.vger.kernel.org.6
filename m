Return-Path: <linux-kernel+bounces-249924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4152692F1B0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D425DB22D66
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC7819FA72;
	Thu, 11 Jul 2024 22:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QuiJmk0Z"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC65442AB5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735586; cv=none; b=ukOJoDwNh1r8vUWwbmDjc9ywhOZBgrIVWPHRjL2eO7CF7BP4AzpBb4XuJsxRzrHdJ0e9O9RybXDhKPW4UUCXTXC+2d6vGASoxpNN8ygDBKTLOUtQ1U4RhMGXK8fLYr3v4an1J4gHQttxnBwK8FiMZxeK2JaqBt8L5zBue6roe4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735586; c=relaxed/simple;
	bh=0Lj0cgNDlIHXytQl/CpN1IGs/JOv2kMwX3nlkpjt79o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHcq2O1B6AdhsouV3npy3bFdMEq/d/3ASyZre4coDrtjSaS1KBuXfJYzXf9UJvIVCY7WTX8HNbgS2YXYeelsZmgzJZKO/MfLzHsdklAvhlJFhN4lJqxH48nlvcye5vYvhjM6hSmzi2xCogAf9qrKWJfE5zMKAFKi7aEVj1wV8pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QuiJmk0Z; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e03a6196223so1393666276.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720735584; x=1721340384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTwnEz0VEcMkg2Ht1CajTFaZ8D9uhTsCApUF/Ll3B8g=;
        b=QuiJmk0ZD8jWhJhJfmT8JzPn8T57vGT+yK8yvrX7HCMsCv+mEEj4E/rscbyvatgGfp
         zpCwPPO/3dfO2IVvXsIjeQJ9l5wlQcuBMQRsx102cBn6V06QPZ9ugvNCVmvumpNuApvG
         PiHCAALV33myfbwsMO06bot6b9dRy9xQFHk27Lat6yEP7Jdup9rvXGYi+O1XUR9vHPB+
         TAJQGTwEZw8zbtQvawfU1S1Rb15nsMo/AqqN14IxNmBS3n9PXdfytfH82wWnQVCgtBgK
         u03BtF2Nj9eWSwMWNcIQy4a4yLyCIhe/oN8jOvSi8u8o8/n+Q+7ZOtk1PW7TZqcXwh+K
         Mc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720735584; x=1721340384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTwnEz0VEcMkg2Ht1CajTFaZ8D9uhTsCApUF/Ll3B8g=;
        b=igFCwxCfbE+hBha3gFpYSOmyvtNsjXidwg8XFaEw0TAHtclbl5iH34e7D8oBS5nFem
         NTExA4Zq3B8f9nQ7PSK3T0zZPaoCHxtcj9aEn+lRoCFZ7ZQqReLJLi0ud+SJL5n1MCuE
         Osfs0j12io5BdeOwGK31nKdVjDZllH5Lzc0lHhJXgeRoF5nvCU5wuEd3zQ7OH2k/4CiZ
         9Bd0NKQCUGEvdJZAv7Mffk2gUtrL7Bj9G2sg2nlGxZx7IyFLLqQismfFmPPhDAZnHscX
         mJmALxRZXRjLbp13tAr5Dx4iAO/wXLllFBXiYlovJzDtucWa/FI5JpF6CB/DiHtzqhV+
         B7gw==
X-Forwarded-Encrypted: i=1; AJvYcCUH7iZnpoG5voj1+Yp/PIYjadH6xWEyF0MvFqZrJQGoGGUUoAojK5iPCYPcBu5fmhkBUejYEhUHfBZit3lBIiMOM+9r/GdSsBgtUkkH
X-Gm-Message-State: AOJu0YzqgbSwHIm8fSh6Ck7usPamDcA2QMGz0HPM/QElcJy/dmazUn2E
	J/1RO0Yyu74uiiYbrwZ4To4RMoJXdmT7yyvyY25z8W7f8R6qDTLOBT6wYHOt5b7u7VsYX6c8AUO
	7tr7h4m/+PHR4i/I16Sj2An89WXhwQaFT0k9n
X-Google-Smtp-Source: AGHT+IHJLn8D0nyG6xdr9eLP4CIHgLMA7BOjT8LRaNkWXLEwy63o/Zyvb97aT09Djm68GZu0z//vI5FzjbZPIwVmeqI=
X-Received: by 2002:a25:d511:0:b0:e03:62b3:6498 with SMTP id
 3f1490d57ef6-e041b12b3a4mr10695476276.47.1720735583493; Thu, 11 Jul 2024
 15:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711220457.1751071-1-surenb@google.com>
In-Reply-To: <20240711220457.1751071-1-surenb@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Jul 2024 15:06:12 -0700
Message-ID: <CAJuCfpFAe9=ernUbyaf=VOjMF1ktyY73vJ8snQfEETeAxSW2Tw@mail.gmail.com>
Subject: Re: [PATCH 1/3] lib: add missing newline character in the warning message
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 3:05=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Fixes: 22d407b164ff ("lib: add allocation tagging support for memory allo=
cation profiling")
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

The fixes in this patchset are cleanups, not critical and not urgent.
Thanks,
Suren.

> ---
>  include/linux/alloc_tag.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index abd24016a900..8c61ccd161ba 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -122,7 +122,7 @@ static inline void alloc_tag_add_check(union codetag_=
ref *ref, struct alloc_tag
>                   "alloc_tag was not cleared (got tag for %s:%u)\n",
>                   ref->ct->filename, ref->ct->lineno);
>
> -       WARN_ONCE(!tag, "current->alloc_tag not set");
> +       WARN_ONCE(!tag, "current->alloc_tag not set\n");
>  }
>
>  static inline void alloc_tag_sub_check(union codetag_ref *ref)
>
> base-commit: 8a18fda0febb7790de20ec1c3b4522ce026be1c6
> --
> 2.45.2.993.g49e7a77208-goog
>


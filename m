Return-Path: <linux-kernel+bounces-441840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C42479ED4C4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F62168E54
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D912204F9A;
	Wed, 11 Dec 2024 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eDG9rIMv"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3F920103C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 18:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733942218; cv=none; b=nKMXh0hBXY9wzYSJOHgqu0fQGFRvpXAZD4ukRm74/lfiuPZA1i9eKem8FdyFTKfYie5ZSEwhrobH2AqNhjSckHLWmXL6okx5idAxrJQY5hYauj8pW3TII+CFecu+vSXBGqlezbTTUSd4aRxJwqLqneVgYUHGtv5kwkaM35tCQQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733942218; c=relaxed/simple;
	bh=iN6t0jmbMy2BXZYnLWp0Fcb+mw7mnZiUiwAUjeRxRek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHezqBiIJ7kUwwa3rCWk1QNhRUqMY+rfygmJ15fHxB93UxCHopmuYTBj5dobluylOc0yAhRsU+uoPA2bPbb2s4FlaR+f1RbzlvbCGU53fbRt9WxRkii4yWKgRlX4GvkHjH/aTknJTZ7HAk7BYjblxaLBYokociu2Q+aLqa1rBto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eDG9rIMv; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-29fd8fed5bcso234701fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733942214; x=1734547014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izrLB3pJwjPC8mUg1IiwWnddscLmxjqQypvvww4i2FE=;
        b=eDG9rIMvz2oPi4W/1/RW2emNdOJWmcj/nCk4zYu7jqZxS6d7LK5bqHgWvMKzq5hwi5
         BlHSFvVlUS2/CaorLr/YXErq+bhqXG+PbpU42e6mjyhTyhZ3pARd5/M+p9TlsT5gSRkH
         hVQ4Qjytig0Ny+/4iGv2XdwHHryY3YjpqCa44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733942214; x=1734547014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izrLB3pJwjPC8mUg1IiwWnddscLmxjqQypvvww4i2FE=;
        b=k7XVb48KYbU+z++P5CErOPyKXU0xFiHGNyqe5AfJzVkbymjE8g4W/TgLNATb/sSyt3
         y+i3qPSXd4M3f7o+Qekh3vcZJ3hsWXpXZ+7l67l7a4sEX8HA71ytAC/btd+6DNDAIvDI
         tpQCigVVZ9TT1yyYWuWsVpii3tj51lGlI2yBSuBma25TQ5aMP+EfXnLCeqUPyI1QlSyT
         83UiKmuzt8Ky8N17Dnho+uL4Hd5C/nb/MXtFbGBIKx3GR3Sj73dC7Ob5K3PgzHxAoN6+
         8DO39Nf31Xpv2NN8xVE1gIkTo3m/exsn0jxB12VgS3gD4FTL1J/HVSoEWjcH1/9eK4fQ
         Mq9w==
X-Forwarded-Encrypted: i=1; AJvYcCWxFcF+Aa7GLpXxup3tqxZ6JtOV64joKm6WY2YWyOCEEIOn8h0mSzEMuREuH2pyRdsl3D56qdc6ryq0p1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqa9Kmkwk2D4Y5LBHIbhe0CRm+HKqoQLxLSzN520IAe5HCmayJ
	jljRGWKgCBI4qyhPiCoaFbiitO8e+VREcqOUOsxZ9E4CUCu2uD3sP8wKsSwwwOq7W46iP01DD8Z
	0zLybCgN7R+rQEqfTPgXbF4YdybM9dE5yyWZS
X-Gm-Gg: ASbGncu3oo/9QRu3UWnr5Z2gV/HujsU/WeWuumHJxyYWj55rG/t+lqN0hE9YzETSMG6
	zR9l3hrTJLU5bRBbvrCsdoUFN6wX8Ql2htU4ZLQMVqGUaTjZ0C80YpIu4rIIY6bD/2wZ7
X-Google-Smtp-Source: AGHT+IFGz7ioDqhBFN2yuVnUzH07nYJFxc5AOZmnLEVgU2lAEBBB0NL4rkz1hRsgMIGFq4mZjMnl9eSoihkMtkKZX00=
X-Received: by 2002:a05:6870:b521:b0:27b:56b1:9ded with SMTP id
 586e51a60fabf-2a012db10c5mr734108fac.5.1733942214495; Wed, 11 Dec 2024
 10:36:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211105315.21756-1-lorenzo.stoakes@oracle.com>
In-Reply-To: <20241211105315.21756-1-lorenzo.stoakes@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 11 Dec 2024 10:36:42 -0800
Message-ID: <CABi2SkXTSi8HKTyE1WoL3qqOTk4KDnF1-RkSOX+ne=cEFJL4qg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update MEMORY MAPPING section
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 2:53=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Update the MEMORY MAPPING section to contain VMA logic as it makes no
> sense to have these two sections separate.
>
> Additionally, add files which permit changes to the attributes and/or
> ranges spanned by memory mappings, in essence anything which might alter
> the output of /proc/$pid/[s]maps.
>
> This is necessarily fuzzy, as there is not quite as good separation of
> concerns as we would ideally like in the kernel. However each of these
> files interacts with the VMA and memory mapping logic in such a way as to
> be inseparatable from it, and it is important that they are maintained in
> conjunction with it.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  MAINTAINERS | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 68d825a4c69c..fb91389addd7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15071,7 +15071,15 @@ L:     linux-mm@kvack.org
>  S:     Maintained
>  W:     http://www.linux-mm.org
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:     mm/mlock.c
>  F:     mm/mmap.c
> +F:     mm/mprotect.c
> +F:     mm/mremap.c
> +F:     mm/mseal.c
> +F:     mm/vma.c
> +F:     mm/vma.h
> +F:     mm/vma_internal.h
> +F:     tools/testing/vma/
>
Will  madvise be here too ?
I'd like to be added as a reviewer on mm/mseal.c.  Is there any way to
indicate this from this file ?

>  MEMORY TECHNOLOGY DEVICES (MTD)
>  M:     Miquel Raynal <miquel.raynal@bootlin.com>
> @@ -25019,21 +25027,6 @@ F:     include/uapi/linux/vsockmon.h
>  F:     net/vmw_vsock/
>  F:     tools/testing/vsock/
>
> -VMA
> -M:     Andrew Morton <akpm@linux-foundation.org>
> -M:     Liam R. Howlett <Liam.Howlett@oracle.com>
> -M:     Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> -R:     Vlastimil Babka <vbabka@suse.cz>
> -R:     Jann Horn <jannh@google.com>
> -L:     linux-mm@kvack.org
> -S:     Maintained
> -W:     https://www.linux-mm.org
> -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> -F:     mm/vma.c
> -F:     mm/vma.h
> -F:     mm/vma_internal.h
> -F:     tools/testing/vma/
> -
>  VMALLOC
>  M:     Andrew Morton <akpm@linux-foundation.org>
>  R:     Uladzislau Rezki <urezki@gmail.com>
> --
> 2.47.1
>
>


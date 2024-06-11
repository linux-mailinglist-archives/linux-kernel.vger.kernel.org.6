Return-Path: <linux-kernel+bounces-209247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18594902F81
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C277E1F23644
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFA616FF37;
	Tue, 11 Jun 2024 04:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XktSqz4x"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8A32570
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 04:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718079983; cv=none; b=oIbpiMXLDCCuTHl/IhYB5iH1yShZMdkN/beAvFRlBjwAiib3EvXw8WwPeDUBggsFemLO6ojGZ5wAaQMfe6yEr/QVwpm4BsCDHjvVyTdn30XlphQbTZeiJTw7ZfsXAjT1Hl2NV0sCKXPz6LYMeTx9H0nEb4kmjWqt70GHHBVU9e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718079983; c=relaxed/simple;
	bh=uO0RrhHuqyUcZ8FW/DdPkgw2Q1fkZ4XCBhNFadXwJsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhoAvMk0ScqYPySismqyr1dK6ojIkgPTVoImMzk2dDbgd2nBMdTWmYJRwnZPsggSBEYyNoDH70KxUsFsavxs4KheergifJARSHaMROzuAZHR+BYWTUCBX043ippFuzpQhEInDSxY33YgfKt48lSzvItYK01/mIUtcuYnFXeBgp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XktSqz4x; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-254c56efe06so853883fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 21:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718079981; x=1718684781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyZsNH9Sc1x7yXcWCuPg478ZMDctoHgE18epfdz43V0=;
        b=XktSqz4xmelYHg93JGxvMVTjG4+hK/MtIsfy2LirxpdzlAbqy7smmi58FFKvkJ/1lu
         dPWKGiX3gmdEClWdEvIKuLnFxy7DwIgaeHcDQCZySxdDsXuIp9LNHkkutYmOucuvEEqR
         LEfwAytIRla7u75ACHPC535Hr0h4qCSToy1CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718079981; x=1718684781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyZsNH9Sc1x7yXcWCuPg478ZMDctoHgE18epfdz43V0=;
        b=lrvwMZEqDLJp1+Cme4TInsvD/PAgX4Ex0E7ZghYw58ZlIQEAVa+lwviVtYcaFz1/6F
         6/E8SdHRrpS2ZR0SDMsB5s9x17XfoH/hcmDdyetECvoW/snJIOqUFOPP2H/Lbaj86SSt
         rZ693aGnQF2xO/XMKjGoujFJJbtB7WqeZmMVqWp2O5DURTdLY/0CvXzCIxx+2TReyrMm
         w9fiBb1Xt7+2MtqG8MsdDV2BUrQs1iV7J9M/GkQorFBmBKnl+BMQYHuP472auevql56o
         bRtk3XapRHgp+vr6J7dnTteLrUSPliTB+mf36jAH7Q/1XWbCzn/O9+dFSwItrdUF2IWK
         +7aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMfIXs/XfotHGcl3Ve75KtF1OiaIO5uNuzD7LQ4fp/apMnLFmnbBCGy/IHxxpBlpC46zjFE0RfFGfE2UgTEjAoq3zQWA193dtovrQn
X-Gm-Message-State: AOJu0YydYfTIzjP76bYwKvtfhyfi0Y2+zrJQRab48stAfvXtEaBCF+EA
	uGtCd61IulCLi4IW8jDkL1RZ0SmwIhgrSiEgUKJq+AdG+f6TDnc1/afAVYirUUKbkvIZ0wOtT5t
	gbcDl/UmIyjUMGfjhwMTRr8LLUiq2L4Y85u57
X-Google-Smtp-Source: AGHT+IFK6lTZPxP5FNiUopooFXMRPUqIKtSzFDv00FIyn1QRlpsxx6oo/JyuSnfToVP5gluNPRqDdITOntAxxf9qVvQ=
X-Received: by 2002:a05:6870:56a4:b0:254:826f:a9d9 with SMTP id
 586e51a60fabf-254827023d3mr11111691fac.39.1718079981520; Mon, 10 Jun 2024
 21:26:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608021023.176027-1-jhubbard@nvidia.com> <20240608021023.176027-2-jhubbard@nvidia.com>
In-Reply-To: <20240608021023.176027-2-jhubbard@nvidia.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 10 Jun 2024 21:26:10 -0700
Message-ID: <CABi2SkWduvq983tXzsYc-aHQdpazm5K84hre7QtyqSgM3vHRQA@mail.gmail.com>
Subject: Re: [PATCH 1/5] selftests/mm: mseal, self_elf: fix missing __NR_mseal
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Andrei Vagin <avagin@google.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Peter Xu <peterx@redhat.com>, 
	Rich Felker <dalias@libc.org>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Jun 7, 2024 at 7:10=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> The selftests/mm build isn't exactly "broken", according to the current
> documentation, which still claims that one must run "make headers",
> before building the kselftests. However, according to the new plan to
> get rid of that requirement [1], they are future-broken: attempting to
> build selftests/mm *without* first running "make headers" will fail due
> to not finding __NR_mseal.
>
> Therefore, add __NR_mseal, to a new mseal_helpers.h file. That file is
> small right now, but subsequent patches will add a lot more content to
> it.
>
> [1] commit e076eaca5906 ("selftests: break the dependency upon local
> header files")
>
> Fixes: 4926c7a52de7 ("selftest mm/mseal memory sealing")
> Cc: Jeff Xu <jeffxu@chromium.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Jeff Xu <jeffxu@chromium.org>
Tested-by: Jeff Xu <jeffxu@chromium.org>

> ---
>  tools/testing/selftests/mm/mseal_helpers.h | 5 +++++
>  tools/testing/selftests/mm/mseal_test.c    | 1 +
>  tools/testing/selftests/mm/seal_elf.c      | 1 +
>  3 files changed, 7 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/mseal_helpers.h
>
> diff --git a/tools/testing/selftests/mm/mseal_helpers.h b/tools/testing/s=
elftests/mm/mseal_helpers.h
> new file mode 100644
> index 000000000000..b922d453a014
> --- /dev/null
> +++ b/tools/testing/selftests/mm/mseal_helpers.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __NR_mseal
> +#define __NR_mseal 462
> +#endif
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/self=
tests/mm/mseal_test.c
> index 41998cf1dcf5..20949617a036 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -17,6 +17,7 @@
>  #include <sys/ioctl.h>
>  #include <sys/vfs.h>
>  #include <sys/stat.h>
> +#include "mseal_helpers.h"
>
>  /*
>   * need those definition for manually build using gcc.
> diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selfte=
sts/mm/seal_elf.c
> index f2babec79bb6..4053951a535c 100644
> --- a/tools/testing/selftests/mm/seal_elf.c
> +++ b/tools/testing/selftests/mm/seal_elf.c
> @@ -16,6 +16,7 @@
>  #include <sys/ioctl.h>
>  #include <sys/vfs.h>
>  #include <sys/stat.h>
> +#include "mseal_helpers.h"
>
>  /*
>   * need those definition for manually build using gcc.
> --
> 2.45.2
>


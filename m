Return-Path: <linux-kernel+bounces-566721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1682DA67BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFE63AFC5C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA8C212B3D;
	Tue, 18 Mar 2025 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCePJRWC"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164C7212B39
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742321335; cv=none; b=V6jMb0kUR+Db/3i3AVyTEis0dGVvgtUkg4V/U4AUgDsiGjy9fOS+++1yZiVCpdJaPTxm1K8gRY8ZMiC9fUknclYmUQpVbx87ZHEWzpBa6kjh9Swf9bmmvTTSYlgscHfjzofIBd52G5aNX6cYP//Jj2NiNycFQSNbQ091zaa8p8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742321335; c=relaxed/simple;
	bh=HDQ8JuvGPH8hhue8nnr3OjXAGnP57T0SDq1d+nBaxQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTatwLqfS+f1rt7Fdlsx6EokKImgoautRjrb+Bt7lEZwtSfS4SyD/8oJZo1Cbvs/6htho8EyVKcs37vhax0lyTHv5ovdieu8+E5OwC3oC4FXTYLBJ0Do4HKoLZp7AGll2vHAM5oJXKbT33te4XgPwFjF30RspfslrARgyMNiyuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCePJRWC; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so59554541fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742321331; x=1742926131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7OCX1yKlYZNI20PjphESfy0gUOoHLlXTkA6fT3Kxfk=;
        b=XCePJRWCG5SemHSQI34CiFPp4I59LajnDQQ6mNJsHV6Oo2nXrDevkK/a+rVXC6NVYk
         frJBwZEGe/k262rH9edipvQPedF5vlCXbXwtAGftlix+5FIoggL2VQtEdlJ2jaMNFwjc
         jJoDoSrzSiRN9IUcKf2r6jDiOqsW7UQqsecADsJNRjPBtjP+AJAf1kYhA6vPvwl17H15
         uVohk6TqjHM8lTuXvDPsOAPOMc9GXNPhyUUvO5iZJot1OO/Pcsgq2KiUS0Ub8pqhbSJU
         +oYNBsurJI/SviaJzUge3UhKU/+NO9m1pfxeHRnnpva0eWxM7N9Jfhrfh2VG+l3fvKNX
         2tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742321331; x=1742926131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7OCX1yKlYZNI20PjphESfy0gUOoHLlXTkA6fT3Kxfk=;
        b=DXikFseHvLzC6z9zqUsz8eliTpCd+R2tH9e+UmSPp0tZWXceTZVqgZxYAEgeDaB5bR
         n+3mg7VvQ6rHiV9XsIuhRFcJVJ9Eaqv1p8e7iGVz6LiKTNguf1jfUb7gq65pLtjS7TZU
         /SelD4RtYwfXUlTEE5VAgx0u0p4CrNSvypXsYWC+d64J7hMDoQZTAdztqzT8dzxC7W+U
         /duxTv9gUk3a2aEofXq+83bsyXOEFm7kknSwu9lbjJUgMmiY5X/T5CWsATuaqem9pwIR
         ymuQUEoKUebSk6PtxVmgGEdVQpZvSZBtmaFIsARHSzTzPYj7CnLOGIe+g/9uRHbLvjkz
         aUig==
X-Forwarded-Encrypted: i=1; AJvYcCVxT5BA1JJOmNKX2Erni60lGRH6X40hXLrupzoBAM3U6zfo24mdKVE2E1RkZEl5ChrfYW+gQujcDOXaonc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4BBrhQFOpMxRYpaFZJG+UaPdSwowLMfBzbRUu4aAxPSMzkeQU
	DOWmHumdKd0QRCemW1cg4awGrEtGWUYBa8jzndgnoKhyzsJJLDqMQVGPKnVRzEDmX+tncciO5F6
	RyBiDs4bOX+3ICH4u1PzMAXTjixQ=
X-Gm-Gg: ASbGnct1e7LEe+sJxyHKGaUjI3Bo5IVlo1XS4Uirx+XjRETCSzNJegij+2tlOpOAu/n
	FRkBww4ecH8AUfiDWB+UWp4fayJWQMNnLjUS22jzvzLkwcrNUISpo7B5H32UkJMFETEm4qnQ3BI
	SIKEAyt4lCV2mbLtgSnZHLnkqNtQ==
X-Google-Smtp-Source: AGHT+IH0vggHppScZCf262EwL97fBvAT7RGb2ynWAXkwsyz/OXUomdAPvswEAEnPF4jr0T5cieKvoXHAg6sDQK0Oeik=
X-Received: by 2002:a05:651c:505:b0:30b:c479:4017 with SMTP id
 38308e7fff4ca-30d69742254mr173921fa.8.1742321330848; Tue, 18 Mar 2025
 11:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318150614.6415-1-shikemeng@huaweicloud.com> <20250318150614.6415-4-shikemeng@huaweicloud.com>
In-Reply-To: <20250318150614.6415-4-shikemeng@huaweicloud.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 19 Mar 2025 02:08:33 +0800
X-Gm-Features: AQ5f1JqnyABzhttE19pInfVd8iC_7wULguYma4htQSYtZmXUmqCnfkSDP3pDTeA
Message-ID: <CAMgjq7CXxpG0doC9iXAXkq_ozvN43gBbG7UsNk8_PYMvpLABHA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] mm: swap: use swap_entries_free() to free swap
 entry in swap_entry_put_locked()
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, tim.c.chen@linux.intel.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 2:10=E2=80=AFPM Kemeng Shi <shikemeng@huaweicloud.c=
om> wrote:
>
> In swap_entry_put_locked(), we will set slot to SWAP_HAS_CACHE before
> using swap_entries_free() to do actual swap entry freeing. This
> introduce an unnecessary intermediate state.
> By using swap_entries_free() in swap_entry_put_locked(), we can
> eliminate the need to set slot to SWAP_HAS_CACHE.
> This change would make the behavior of swap_entry_put_locked() more
> consistent with other put() operations which will do actual free work
> after put last reference.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  mm/swapfile.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 0aa7ce82c013..40e41e514813 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1348,9 +1348,11 @@ static struct swap_info_struct *_swap_info_get(swp=
_entry_t entry)
>  }
>
>  static unsigned char swap_entry_put_locked(struct swap_info_struct *si,
> -                                          unsigned long offset,
> +                                          struct swap_cluster_info *ci,
> +                                          swp_entry_t entry,
>                                            unsigned char usage)
>  {
> +       unsigned long offset =3D swp_offset(entry);
>         unsigned char count;
>         unsigned char has_cache;
>
> @@ -1382,7 +1384,7 @@ static unsigned char swap_entry_put_locked(struct s=
wap_info_struct *si,
>         if (usage)
>                 WRITE_ONCE(si->swap_map[offset], usage);
>         else
> -               WRITE_ONCE(si->swap_map[offset], SWAP_HAS_CACHE);
> +               swap_entries_free(si, ci, entry, 1);
>
>         return usage;
>  }
> @@ -1461,9 +1463,7 @@ static unsigned char swap_entry_put(struct swap_inf=
o_struct *si,
>         unsigned char usage;
>
>         ci =3D lock_cluster(si, offset);
> -       usage =3D swap_entry_put_locked(si, offset, 1);
> -       if (!usage)
> -               swap_entries_free(si, ci, swp_entry(si->type, offset), 1)=
;
> +       usage =3D swap_entry_put_locked(si, ci, entry, 1);
>         unlock_cluster(ci);
>
>         return usage;
> @@ -1551,8 +1551,8 @@ static void cluster_swap_free_nr(struct swap_info_s=
truct *si,
>
>         ci =3D lock_cluster(si, offset);
>         do {
> -               if (!swap_entry_put_locked(si, offset, usage))
> -                       swap_entries_free(si, ci, swp_entry(si->type, off=
set), 1);
> +               swap_entry_put_locked(si, ci, swp_entry(si->type, offset)=
,
> +                                     usage);
>         } while (++offset < end);
>         unlock_cluster(ci);
>  }
> @@ -1596,12 +1596,9 @@ void put_swap_folio(struct folio *folio, swp_entry=
_t entry)
>         ci =3D lock_cluster(si, offset);
>         if (swap_only_has_cache(si, offset, size))
>                 swap_entries_free(si, ci, entry, size);
> -       else {
> -               for (int i =3D 0; i < size; i++, entry.val++) {
> -                       if (!swap_entry_put_locked(si, offset + i, SWAP_H=
AS_CACHE))
> -                               swap_entries_free(si, ci, entry, 1);
> -               }
> -       }
> +       else
> +               for (int i =3D 0; i < size; i++, entry.val++)
> +                       swap_entry_put_locked(si, ci, entry, SWAP_HAS_CAC=
HE);

I'd prefer you keep the bracket here for more readability, and maybe
add bracket for the whole if statement, just a tiny nitpick so still:

Reviewed-by: Kairui Song <kasong@tencent.com>

>         unlock_cluster(ci);
>  }

>
> --
> 2.30.0
>


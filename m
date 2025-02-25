Return-Path: <linux-kernel+bounces-532464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C32A44E14
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2838D1771C3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182FC20C46B;
	Tue, 25 Feb 2025 20:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qq5VGZYA"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0A61A0BCD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740516997; cv=none; b=SeWBhrTqPTQvgUzfMkQUugGnLRbBSrDkMCbH1fvI5X/R2Ame4N2QqQfmzm2Zmx9T/2EU7JSYIplDoSxNwveFTEnG/R6Vp1wdj/ldBcVaYZug0rkrMyllqadEqk5iCoc3040CJjs71jnIb7+qs6uLXFSnE/xhB+jEdCTyLKauyfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740516997; c=relaxed/simple;
	bh=I1XPpLU3J2WHXvAfG437ac5cD5ck+k6/sPCz4L5xREk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+M++c/4UMgFgIVnkR/7C3aswgLXBUF5/dODW/wOxrYD2fxqMLfENs4epiwwv0mfa5O1Rjg0+MnCrKKTH+Dvbp0v2gTkzcLptGzMQ2EZuO078l8VAoxmjc56h4/LL3p1f2aTF+sQ5Sb0yIJM0Kc7rs6gk5aiqbzyLBewkB9/XqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qq5VGZYA; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-471f1dd5b80so9231cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740516995; x=1741121795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLQFei54lPc5IjpuxnIiS2CD+MZaB+VV8WFTCrdFhlY=;
        b=Qq5VGZYAzV3V6KlmM8XbhQBbx5NOlrYBijyFkH82ZVgsF3DiYMdZZXvk45qUIYv7C4
         Zzi3ashvj2+r243zNQgB7LuBXSYj1gpnfZRUw8TnqY14XyxHIMmg5HCSrIaQHUo0HOmu
         i7gA9w41U8mPxg56aXsKURfohQlqJ+ogSRJ1DSRNVHwT/AK1Fj5J/vECA3FD18Zb3xeT
         GZFrnX7mxA9e8cRxyfJMXkqRXaIaI+GoJkX6f46e9hjnNlb+dv4EHxp1KimCwb4gDxq2
         vH5J+HhZU8xyOmQzB25WpuRjwSKlFFBkGlrJbeFxUi3ytyPi/FsFBIJQemaMrxLf13/w
         Zheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740516995; x=1741121795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLQFei54lPc5IjpuxnIiS2CD+MZaB+VV8WFTCrdFhlY=;
        b=fHyoTIf8VocyEmfX8JM3Jls9OI5hbq9OmEOxsuww2WC0FP/ojczLqlUp+w+PItit7b
         YBEKqwP6m0kKhm80oXKlkWxMxtCIbPLUvRhvOEpHAcsMzkt91yMJ+EAIzg3aHXr3gwAI
         5VO/kfvK4X4qI8sAnPxhpXNgnhbCm6/TwFWC1B3rj1JbpSdIX4zpxEPu3xfFmw+9n5b8
         nlkHceRlaHaQpBF7WXEaPb+Q1K9wfiKnSVPgTdYVvfqKcvV/rBZSucyGSe+qSHGLqCjn
         cFjV5HCA3q9+mILFxANrk4iA8ywyns90wBNlwEd5v2hhPLF7vcumZxdKw9tkGBu2oUvW
         ERLg==
X-Forwarded-Encrypted: i=1; AJvYcCVhTN8BRjCzk7draS/wUeFqbMjL/HS92kcOvnXj1DHm7CcaFev1/BwnucspDMrL5+z7jJnAwF7YK3W3re8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8J+5pXWY0e6MyqKvmMMmoKEl2E7Zj+AdgSpTZB1U8/xjGtuGX
	f5l9b0Z8x+tek3zLiWw4FKwD3VEfPDWbN7Z4mLPA1slmnwqsuprX592x4clV4125k2O22tTm87A
	DbJCOIuvPdwnyhaz8C+O2LsWG20oqn8roqeNM
X-Gm-Gg: ASbGncuGRndA26nsQYIA8J2zSvQbL4uvWxmcejGXzXbHZ78Wa9psan6VbenXGt/qYRa
	tkKkyb8vauXWdLIyAO8mO017dJexWx76R6aFgFxVfs4rYbNUHg+LtefwoRqxH6aGHxrkjkr2EFm
	SFwx1ybZp614+ps4OaXw+BpE7XszdOAo4s0TKV
X-Google-Smtp-Source: AGHT+IE2HpGiBeVmayZi6OAx9oa2M81VAty5D9F16fCVYjWasqS1C7etoYlS+u16+CJCZx2CWz01xf+uzvrq2nGkvAo=
X-Received: by 2002:ac8:7d12:0:b0:471:f2dd:4184 with SMTP id
 d75a77b69052e-47376e80f47mr6818791cf.11.1740516994368; Tue, 25 Feb 2025
 12:56:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225204613.2316092-1-surenb@google.com>
In-Reply-To: <20250225204613.2316092-1-surenb@google.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Tue, 25 Feb 2025 12:56:22 -0800
X-Gm-Features: AQ5f1Jqt0vylsPZEiL0s8BW5MqvPM88h0-uw_12NykS6cMFAJJ6oZ8OrgF9uyQI
Message-ID: <CA+EESO59F1dMqmJAk+AjmvovN-wQe7nimk3UTT5=2pbQOR0brA@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: do not block on locking a large folio
 with raised refcount
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, aarcange@redhat.com, 21cnbao@gmail.com, 
	v-songbaohua@oppo.com, david@redhat.com, peterx@redhat.com, 
	willy@infradead.org, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	hughd@google.com, jannh@google.com, kaleshsingh@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 12:46=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> Lokesh recently raised an issue about UFFDIO_MOVE getting into a deadlock
> state when it goes into split_folio() with raised folio refcount.
> split_folio() expects the reference count to be exactly
> mapcount + num_pages_in_folio + 1 (see can_split_folio()) and fails with
> EAGAIN otherwise. If multiple processes are trying to move the same
> large folio, they raise the refcount (all tasks succeed in that) then
> one of them succeeds in locking the folio, while others will block in
> folio_lock() while keeping the refcount raised. The winner of this
> race will proceed with calling split_folio() and will fail returning
> EAGAIN to the caller and unlocking the folio. The next competing process
> will get the folio locked and will go through the same flow. In the
> meantime the original winner will be retried and will block in
> folio_lock(), getting into the queue of waiting processes only to repeat
> the same path. All this results in a livelock.
> An easy fix would be to avoid waiting for the folio lock while holding
> folio refcount, similar to madvise_free_huge_pmd() where folio lock is
> acquired before raising the folio refcount.
> Modify move_pages_pte() to try locking the folio first and if that fails
> and the folio is large then return EAGAIN without touching the folio
> refcount. If the folio is single-page then split_folio() is not called,
> so we don't have this issue.
> Lokesh has a reproducer [1] and I verified that this change fixes the
> issue.
>
> [1] https://github.com/lokeshgidra/uffd_move_ioctl_deadlock
>
Thanks so much for fixing this, Suren.

Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Reported-by: Lokesh Gidra <lokeshgidra@google.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/userfaultfd.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 867898c4e30b..f17f8290c523 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1236,6 +1236,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd=
_t *dst_pmd, pmd_t *src_pmd,
>                  */
>                 if (!src_folio) {
>                         struct folio *folio;
> +                       bool locked;
>
>                         /*
>                          * Pin the page while holding the lock to be sure=
 the
> @@ -1255,12 +1256,26 @@ static int move_pages_pte(struct mm_struct *mm, p=
md_t *dst_pmd, pmd_t *src_pmd,
>                                 goto out;
>                         }
>
> +                       locked =3D folio_trylock(folio);
> +                       /*
> +                        * We avoid waiting for folio lock with a raised =
refcount
> +                        * for large folios because extra refcounts will =
result in
> +                        * split_folio() failing later and retrying. If m=
ultiple
> +                        * tasks are trying to move a large folio we can =
end
> +                        * livelocking.
> +                        */
> +                       if (!locked && folio_test_large(folio)) {
> +                               spin_unlock(src_ptl);
> +                               err =3D -EAGAIN;
> +                               goto out;
> +                       }
> +
>                         folio_get(folio);
>                         src_folio =3D folio;
>                         src_folio_pte =3D orig_src_pte;
>                         spin_unlock(src_ptl);
>
> -                       if (!folio_trylock(src_folio)) {
> +                       if (!locked) {
>                                 pte_unmap(&orig_src_pte);
>                                 pte_unmap(&orig_dst_pte);
>                                 src_pte =3D dst_pte =3D NULL;
>
> base-commit: 801d47bd96ce22acd43809bc09e004679f707c39
> --
> 2.48.1.658.g4767266eb4-goog
>


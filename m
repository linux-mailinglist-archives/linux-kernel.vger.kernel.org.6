Return-Path: <linux-kernel+bounces-359585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385FD998D98
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A5728B9F7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A842197512;
	Thu, 10 Oct 2024 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kJ1p7nET"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D524026AFC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728578274; cv=none; b=CI9zbZqpUld79A2hx4fyr6a1z6dRkp2g2bJTY4hm5seozW8k8kH4sDtro+a/oZwJKhvu43RWtdHF7Dpfefjqr7tVF9VP0CA4O2SMS/7c2rzyOWbNaMoGkCvdnLBfBvyd/HBINxqpGvfbsZY3eJ/bhsjX6XKeOJZZg/uLKdyvN7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728578274; c=relaxed/simple;
	bh=OyvCJ6AB0lJQyPa6lVl6hKHWM/xK1ph6aDdmctplN78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMUy8Nm9rTZSVf6qLwqIFhAqGueLC1h5lZ/MZOqYTxWAfR4YW4r0xSaWiWe3Kkv8qzxD0j925gN9bUn6i4Nw7ps9EfJBvkFEEkWSNG5i+FO5zdGtLYaRfc4401S5SxVMPGoyQrjZlPoapUbT8N//WZfHcy+GaNi3GIhD8j9vuHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kJ1p7nET; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3e3dfc24a80so728194b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728578272; x=1729183072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAHZtOInJ31IBMrbipYqgvXa3vV7cOSESzJ3bwwKz9M=;
        b=kJ1p7nETOlwfQ0RnOEt28LIAX/z4bVWjnRGgs9BSTQVS2x2ARS5/2tST2iziq3rgVm
         veO+TT4OALSD5EEjNnRmm4RuYhUj7sfuU9DBxLmNku84+pwfH0to1edGYuGTYao2UCm+
         DqO8mip2a/5wPS6Ai0iK2jl9I4hnoha9TuRtmbfa48HbsiNMWpGgsdr0DnhjFOwmRzeW
         XkLQrXwyJWcwigOFBmd6PuIbUMRIr4t/TK5jOZQ4yRPt9bZEbBy31GXBLL4FWxVrxDeT
         I+QFAiFvYxmws2SH8+zGbNvliPzH2IQINSgu909hJQsoc8UidSY9ND+TjmtF52QPLP6y
         qNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728578272; x=1729183072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAHZtOInJ31IBMrbipYqgvXa3vV7cOSESzJ3bwwKz9M=;
        b=w5eIWLB+Ht02xeDOszwVraDVBvlXt0UmjnIrszXn8hdEfI4mZCCTatBE51FbiWfrbq
         LntvyQHq06X1W1aNIq0iGKGCikUxB331KGQhuTolrmE7isufDhjUN2ZOx3e0PMUvHY1l
         vQTuD072vvsvSGUU4JgwDlpKGOaPoZmp8LpSHvaGfITenby6DekmvqFxFNlurNoI0pJs
         /AoTzdBf2jOj48c/hPuPh4Cy3l/pSgG1yM7iZTPaXxALg07GYl4cxA+5cp6sSZ8jptcA
         hXMM+4ZGOWrZGq5jX6+GU8LOWAcB1WPU0dSR98ULqDHiC7up2d8nBMZz8Vakna3B0l13
         1PDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4l7zDWPrjn6XZFgIwjdToVgH2HmIJPlMJjCZuwpoz3zu2dN/0Vv5WD/ttnjOktjKrPHKgwv9WdWx9dmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbUzgqOzcoXFKmIj74o+s3K1DB+RIL8DBf6DYC7uGIpqkEppeb
	M5to67G4ihqw2/qbu+Qsl8gRN+e38eG14CqFAKbZ+OSmNRBOkJXeLah6QBA/j/o1LqyEv4r+ZAE
	VnH/27nThYkRiUPkvrcaS3D3a0dPVMNwmVhrd
X-Google-Smtp-Source: AGHT+IGuWVaO/Ggn3RMpBCD9/4w1bag/yt8XNl7DXYvoYchgTYMhOcIyJqqkYWHrjSte6NKjhNmiQubmeohX9QZRxhQ=
X-Received: by 2002:a05:6808:1b25:b0:3e3:a1ae:6a1a with SMTP id
 5614622812f47-3e4d7147fdfmr3998252b6e.4.1728578271639; Thu, 10 Oct 2024
 09:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009074953.608591-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20241009074953.608591-1-zhaoyang.huang@unisoc.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 10 Oct 2024 10:37:13 -0600
Message-ID: <CAOUHufaiKFZ6LjoQ8SChK+m0-nPzT6RYpDfLHp69vn1OYm3qhQ@mail.gmail.com>
Subject: Re: [PATCH] mm: throttle and inc min_seq when both page types reach MIN_NR_GENS
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Zhaoyang Huang <huangzhaoyang@gmail.com>, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:50=E2=80=AFAM zhaoyang.huang <zhaoyang.huang@uniso=
c.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> The test case of [1] leads to system hang which caused by a local
> watchdog thread starved over 20s on a 5.5GB RAM ANDROID15(v6.6)
> system. This commit solve the issue by have the reclaimer be throttled
> and increase min_seq if both page types reach MIN_NR_GENS, which may
> introduce a livelock of switching type with holding lruvec->lru_lock.
>
> [1]
> launch below script 8 times simutanously which allocates 1GB virtual
> memory and access it from user space by each thread.
> $ costmem -c1024000 -b12800 -o0 &
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  mm/vmscan.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index cfa839284b92..83e450d0ce3c 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4384,11 +4384,23 @@ static int scan_folios(struct lruvec *lruvec, str=
uct scan_control *sc,
>         int remaining =3D MAX_LRU_BATCH;
>         struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
>         struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
> +       struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
>
>         VM_WARN_ON_ONCE(!list_empty(list));
>
> -       if (get_nr_gens(lruvec, type) =3D=3D MIN_NR_GENS)
> -               return 0;
> +       if (get_nr_gens(lruvec, type) =3D=3D MIN_NR_GENS) {
> +               /*
> +                * throttle for a while and then increase the min_seq sin=
ce
> +                * both page types reach the limit.
> +                */

Sorry but this isn't going to work because in try_to_inc_min_seq(), there i=
s
   `while (min_seq[type] + MIN_NR_GENS <=3D lrugen->max_seq) {`
to prevent reclaimers from evicting hot memory -- they need to do aging fir=
st.

>
> +               if (get_nr_gens(lruvec, !type) =3D=3D MIN_NR_GENS) {
> +                       spin_unlock_irq(&lruvec->lru_lock);
> +                       reclaim_throttle(pgdat, VMSCAN_THROTTLE_ISOLATED)=
;
> +                       spin_lock_irq(&lruvec->lru_lock);
> +                       try_to_inc_min_seq(lruvec, get_swappiness(lruvec,=
 sc));
> +               } else
> +                       return 0;
> +       }
>
>         gen =3D lru_gen_from_seq(lrugen->min_seq[type]);
>
> --
> 2.25.1
>


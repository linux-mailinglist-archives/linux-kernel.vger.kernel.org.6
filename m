Return-Path: <linux-kernel+bounces-428243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED199E0BC2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6AC161355
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2A91DE3B9;
	Mon,  2 Dec 2024 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3wP9rMP5"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C4B381C4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166711; cv=none; b=hgL2yDyJJr5lx/JvWQN9rZI32EtwroHyW78b2Bf6VEi2cceETGmTYFO4YZyxBTBNbsHdS5TBp9/taMvcT79owUxXTUFLgnzTdHf8k7YHQWlMa7rYJ2mZE6vQQUI1L5lviB93B8TdihiAU0WkKkfIc/Xmg9zJHpw7aHWaHsdWqUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166711; c=relaxed/simple;
	bh=jkhwRGMI95d7YQEeeyWXzBeOhs8lmK/DeSf+JAmyAec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bkm4WM4xB1Km4z8U19rQKb38WynN64YTEqT44LI8/J64C1IdRjUhRzHrIMjQnm8zbDBTaYJndQoEsBXMUCjcI1Tv7llInr99RL4i2xXwTXDjj8Pygve4vbq/bJ+3Ru2rOVZ0GWVnAlfIFcUP++nYgwoo0meEidhHgriT19IzwV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3wP9rMP5; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d87fea84cdso32790726d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 11:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733166709; x=1733771509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzYyjGx3ReEQgnID5PrS6FlfDBtezYVlcauxU9d5N2Q=;
        b=3wP9rMP5Vyayh9V5/1BN1Pcej+q44/pdJMAIvBhaIvZKtOcs0a9qe7uzlhvPLQSH4o
         6qI1l/0oFVWMxn9Nyhk3VKtUnEBnFlSoiifhQ9gNd7mezeGr+RBJsL/e7viRqg7nzFhT
         cvqCS0gevT6OcPS3i9pQTHT2SVUhScGt3DxV3YHOMUnl5KIgvwDanCG0g+0eFfXYmho1
         lYzv5BnIoV0ef+gGuxCZgxq+0pgURv7Xdl/shKXICf3E58cKD63XwaURs9pKxXsbq0Xx
         gu+W57vA/f2Wk6O650aJUSZmY0VNIfOfS6rWKu8UeYLcuQQV6vQuuh6QVIz0J9lMOPlv
         Z21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733166709; x=1733771509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GzYyjGx3ReEQgnID5PrS6FlfDBtezYVlcauxU9d5N2Q=;
        b=MFeUc/97teo370SIo0eh0dzFXhDRXHvX3h8NAygxz4KoQNBpfbU9v2sUNM2bC0BHwS
         dTLSIh3Iy4+rHYxb31npISSJaKujPJpk71QEY0pozM7nI3Id6AqjPRlMPsmReMvmXCXw
         mj1Da6hCawi22gjqeEZSNZu3KwaUAv8d/AfP0yrtpNEJQDhkNKtsYJvKNF4igF/7Evac
         g8HXGSwaHUcopyqyjXoCtdHyzHQSe0DQWbgTf24ZAOZvEDCSnUn34S3Mq7+qJ2r/DNBl
         j2VMgaXhM/B7A/dzzTeIUOTcarhiFGacdcoVOe7EzcCT9k9gipaTnjk7UHRV7Fi8uh3m
         +wfg==
X-Forwarded-Encrypted: i=1; AJvYcCW4C9IS2z7fDQEsCrtvzaM7T0D500Zy0gPtn1Wr+MTh2ARGlpIzwkQu5j27R0S2nftgjUxlDAb98qHcmsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh3hghB1H7tbxJHFcuf5TM/bit+Hkl11QUnjZtQmcV9j49TT6p
	ah/ZxcDJckNmSP2pe/rSXC3DJJsEZQJO/DtV20dvYSOaR9+ZtZPTCcN7OHoP6nc4Rw4rq3PKnAA
	5lBBFlhI1Fp9QgXRW1Lps/ZFVmfC0vFcPkJFe
X-Gm-Gg: ASbGnct4inhRJA5uf1Uf3P7oph/LXhXPq0vulRwuNu58Xudq1wzPvppsoiPAI18X4XI
	xPsAAIm3dqkkZeta9NTd6C8lz3cSR
X-Google-Smtp-Source: AGHT+IH8Gv/Uqr/mCJl1g5oYLrGu5z9Qvkhd0hlZVMtO/Rs3pYyxYlYftlv6RtwVAu5kF541H04heeMtU4AMl6eNvnM=
X-Received: by 2002:a05:6214:1244:b0:6d3:b936:60d1 with SMTP id
 6a1803df08f44-6d864d892aemr364467746d6.33.1733166708816; Mon, 02 Dec 2024
 11:11:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202184154.19321-1-ryncsn@gmail.com> <20241202184154.19321-3-ryncsn@gmail.com>
In-Reply-To: <20241202184154.19321-3-ryncsn@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 2 Dec 2024 11:11:12 -0800
Message-ID: <CAJD7tka-hTDaQCJTkz-7mNhyOheEELskm9C94PXiTE6V+4m0tQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm/swap_cgroup: remove swap_cgroup_cmpxchg
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 10:42=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> This function is never used after commit 6b611388b626
> ("memcg-v1: remove charge move code").
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  include/linux/swap_cgroup.h |  2 --
>  mm/swap_cgroup.c            | 29 -----------------------------
>  2 files changed, 31 deletions(-)
>
> diff --git a/include/linux/swap_cgroup.h b/include/linux/swap_cgroup.h
> index ae73a87775b3..d521ad1c4164 100644
> --- a/include/linux/swap_cgroup.h
> +++ b/include/linux/swap_cgroup.h
> @@ -6,8 +6,6 @@
>
>  #if defined(CONFIG_MEMCG) && defined(CONFIG_SWAP)
>
> -extern unsigned short swap_cgroup_cmpxchg(swp_entry_t ent,
> -                                       unsigned short old, unsigned shor=
t new);
>  extern unsigned short swap_cgroup_record(swp_entry_t ent, unsigned short=
 id,
>                                          unsigned int nr_ents);
>  extern unsigned short lookup_swap_cgroup_id(swp_entry_t ent);
> diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
> index f63d1aa072a1..1770b076f6b7 100644
> --- a/mm/swap_cgroup.c
> +++ b/mm/swap_cgroup.c
> @@ -45,35 +45,6 @@ static struct swap_cgroup *lookup_swap_cgroup(swp_entr=
y_t ent,
>         return &ctrl->map[offset];
>  }
>
> -/**
> - * swap_cgroup_cmpxchg - cmpxchg mem_cgroup's id for this swp_entry.
> - * @ent: swap entry to be cmpxchged
> - * @old: old id
> - * @new: new id
> - *
> - * Returns old id at success, 0 at failure.
> - * (There is no mem_cgroup using 0 as its id)
> - */
> -unsigned short swap_cgroup_cmpxchg(swp_entry_t ent,
> -                                       unsigned short old, unsigned shor=
t new)
> -{
> -       struct swap_cgroup_ctrl *ctrl;
> -       struct swap_cgroup *sc;
> -       unsigned long flags;
> -       unsigned short retval;
> -
> -       sc =3D lookup_swap_cgroup(ent, &ctrl);
> -
> -       spin_lock_irqsave(&ctrl->lock, flags);
> -       retval =3D sc->id;
> -       if (retval =3D=3D old)
> -               sc->id =3D new;
> -       else
> -               retval =3D 0;
> -       spin_unlock_irqrestore(&ctrl->lock, flags);
> -       return retval;
> -}
> -
>  /**
>   * swap_cgroup_record - record mem_cgroup for a set of swap entries
>   * @ent: the first swap entry to be recorded into
> --
> 2.47.0
>


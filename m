Return-Path: <linux-kernel+bounces-443537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C329EF537
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0601116FCF2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050E04F218;
	Thu, 12 Dec 2024 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MV4nfPeY"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47A0213E9F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023225; cv=none; b=mv5J8RzkzQJW+ScxxQ5rwt/Pb7wEmie2/2BsUkTVINMkpZjDcXHySRpxkdCy3Rl46al7CN3zDsyt2Ir/s3ZO5b2mM3qn77Y2kS3+Hf7E+4Kwhnh5fIz659Tw9DBxX6xdVuu8FPwNQnAnZJbVDHWEKwzgfFHSSOK+0lTijz7rRds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023225; c=relaxed/simple;
	bh=6x6ZloTOP8xG7QluZoqD1vHcIrDmSAcWjBCNgzaKeTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hh9P0VKF3Mjebh6kIueJmAKnL/w5fGcZG+2v4DpY7kmMqL+HjEh0owjLwBbu/eZGNjQCsNUSM1OXYoobmKGR9+LrVL4ZHbHWpzg81nvx+WpRAEg6lU/hJmcwB/tstVejdAc28Nkg2X/68CF0VSWf2lH91PnleNsfk5gu1GuE7qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MV4nfPeY; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d888c38841so6736846d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734023222; x=1734628022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCU6Io7K5lloOjr5AqAuJ1H3CWWQOcWOOH73iAc8mqI=;
        b=MV4nfPeYWQRMNACsO0m5W8xd9jqjrj3aXmUDAWGS4eqylzIPbs8mfSBTaYFPGXUNjF
         jZh8Lu5ceTmR12aztjrXui1HdHLCC1B1RXDsOTJB38Yoq7yn8WgM+CIvdF2xDJYu9lUH
         DWWd/EPU8TuuIUesTzM4o4/YjdgdVQQiBDIaNgmSFCLZz0s7XPORuuwpFg3PXrGWTkuL
         RqoIBwjwl4C1hZJCRKtbJW7JaN3RdK+tdFSJF0f829y3vh9f8vz6mXSesCCnKEjBzs3I
         pwi2KbFNdLBD/9LDMOvdKLkj7WOLga1q4Dqzkx+viiPvtZeNymav6M1H4W3UMKSyW/Np
         Nc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734023222; x=1734628022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCU6Io7K5lloOjr5AqAuJ1H3CWWQOcWOOH73iAc8mqI=;
        b=cnAd57zIb2Azr/7njM4J4+OTxTf9AYkGZKyZcMOcQ5BRVFVKXDhWXh3ELLwcwjeQu2
         5AMwq7P7T53bICiMmozLGQvYDSImMnHS5FB+d5/BiLtYuSjyWDexOP4XM/fu8o3kRPIt
         6BhoK7s6S4s42B3zxvRElSQ3EjelPBVqEYxsHI29pKQQVgHk/DB2LI194BKHNy9vcpD9
         GnzhP8yXnmvzNSn5FanlImeYxF1nXCHz5R1pSkRkyMPvxP9IqRtneaoO1ftC7/9jO6F7
         fNJKOT0q7MjRfJ5atgWPXhVbvgxUajPKSTSKzFjmNFbPhaE1jB0AkuCYS4z+RZlAgYFi
         aggg==
X-Forwarded-Encrypted: i=1; AJvYcCWkyr5VC0zM6Z99rb4Vpb/0sUJ/eQL3p9RaSb3mxD80sSuo8dar029vgYGpdGWovwqk/bU1QvOh5xiqKJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQTSrN179AIrUqyE9YiKGWhV9YfVpZXlMBvBTGQ+ROMZkL+MLu
	gD0cgQvoLJ9U1Dpvuv9Zgcx9gpPOFZluZ80CtjxlMN1BxBa5XlhkpdXDBXORY2lw1l97+WZN30Q
	2c2CckPyo/81/sp8AaCTL5peZmDElEF5LCm/4
X-Gm-Gg: ASbGnctausrif4+MyjEl+4U2xTBoCgn72o4RPvzSfZB8p6twNZEHG6VNc2aL+sbfyL9
	VmVBESW9dvlUpTTS4dCm8Dn8pl2ZHYF7iI68=
X-Google-Smtp-Source: AGHT+IEWYnxKGd+UY4guVytg68DPFmVI424eT9T154/j96Ckzc2xwC/UXvDBjuCYYXtvEZKkQodesHCobvjymkaBzwE=
X-Received: by 2002:a05:6214:1d04:b0:6cb:edd7:ac32 with SMTP id
 6a1803df08f44-6db0f744d63mr13338916d6.12.1734023222307; Thu, 12 Dec 2024
 09:07:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212115754.38f798b3@fangorn>
In-Reply-To: <20241212115754.38f798b3@fangorn>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 12 Dec 2024 09:06:25 -0800
X-Gm-Features: AbW1kvYqCkeLbtm1kn4Hmr1w3G_jj-nRHwu7-NDzHzt7kzJ52IijDm_4rEdM63c
Message-ID: <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
To: Rik van Riel <riel@surriel.com>
Cc: Balbir Singh <balbirs@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	hakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Nhat Pham <nphamcs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 8:58=E2=80=AFAM Rik van Riel <riel@surriel.com> wro=
te:
>
> A task already in exit can get stuck trying to allocate pages, if its
> cgroup is at the memory.max limit, the cgroup is using zswap, but
> zswap writeback is enabled, and the remaining memory in the cgroup is
> not compressible.
>
> This seems like an unlikely confluence of events, but it can happen
> quite easily if a cgroup is OOM killed due to exceeding its memory.max
> limit, and all the tasks in the cgroup are trying to exit simultaneously.
>
> When this happens, it can sometimes take hours for tasks to exit,
> as they are all trying to squeeze things into zswap to bring the group's
> memory consumption below memory.max.
>
> Allowing these exiting programs to push some memory from their own
> cgroup into swap allows them to quickly bring the cgroup's memory
> consumption below memory.max, and exit in seconds rather than hours.
>
> Signed-off-by: Rik van Riel <riel@surriel.com>

Thanks for sending a v2.

I still think maybe this needs to be fixed on the memcg side, at least
by not making exiting tasks try really hard to reclaim memory to the
point where this becomes a problem. IIUC there could be other reasons
why reclaim may take too long, but maybe not as pathological as this
case to be fair. I will let the memcg maintainers chime in for this.

If there's a fundamental reason why this cannot be fixed on the memcg
side, I don't object to this change.

Nhat, any objections on your end? I think your fleet workloads were
the first users of this interface. Does this break their expectations?

> ---
> v2: use mm_match_cgroup as suggested by Yosry Ahmed
>
>  mm/memcontrol.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7b3503d12aaf..ba1cd9c04a02 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5371,6 +5371,18 @@ bool mem_cgroup_zswap_writeback_enabled(struct mem=
_cgroup *memcg)
>         if (!zswap_is_enabled())
>                 return true;
>
> +       /*
> +        * Always allow exiting tasks to push data to swap. A process in
> +        * the middle of exit cannot get OOM killed, but may need to push
> +        * uncompressible data to swap in order to get the cgroup memory
> +        * use below the limit, and make progress with the exit.
> +        */
> +       if (unlikely(current->flags & PF_EXITING)) {
> +               struct mm_struct *mm =3D READ_ONCE(current->mm);
> +               if (mm && mm_match_cgroup(mm, memcg))
> +                       return true;
> +       }
> +
>         for (; memcg; memcg =3D parent_mem_cgroup(memcg))
>                 if (!READ_ONCE(memcg->zswap_writeback))
>                         return false;
> --
> 2.47.0
>
>


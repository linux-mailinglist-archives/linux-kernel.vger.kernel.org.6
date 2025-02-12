Return-Path: <linux-kernel+bounces-510647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E27A31FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935FA1889182
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891B72040A7;
	Wed, 12 Feb 2025 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="P5kN9xDp"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A39220458B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739345272; cv=none; b=q0/KtQqNwhXYTrPo3H1nhwBK9pL4WqU/m0R8Q/Vx9hSQErn/KGLuW8diNkVlSrK1wcUprykoGQ45T+GZUTy3QEEo2OPj1KtOIiir03L3Fo30A1HsKmQSoUU477bCdGhwf1RIlCMgfNxh7YChEZ9x5/s41+kak6c2XbQH/73KTiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739345272; c=relaxed/simple;
	bh=X0SMSmIWGyTCxNlqPUgOBXqGts6xSo3Ri9D6KFMif6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZKOIUbCsZTBAUeXoU/ZMzNPCxUgIXwlC1/entJ4ifHQwos6ZmuaedtfCTKvh7hCIxreZDUPSn2cdirzTe7RS3XUwnxHH31kDc9hovsUkX22einHDtM74Q0g1dcDyTXnkK2meBZC+/gAB5l5QarEjJa0FfPtcAy3SGt5200ErtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch; spf=none smtp.mailfrom=easyb.ch; dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b=P5kN9xDp; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easyb.ch
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-545074b88aaso3779818e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 23:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1739345268; x=1739950068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkpApLmuMSuoEXBLQRnWWTTZmdzVTlEP/UbOXT6BIvI=;
        b=P5kN9xDpAPBYnVsqi0HbJdYhP1qaDDNrTzkA/mFqH0Xv4A8rS2bWLG7dfLJLEPacbo
         O+tt0u8y2dvRLiQPtFpurnroOzJ9aCSL4+SG+KkNQHLgCX0FBWX5nOF1w2XiVtp6JWtX
         HIBxUNtlyRWC5N4i4bhOkVKJ0+oDDXDOxCmPUotjmEZQkoKNnwL8NwXLuj1zC7d3xaBo
         TGb1HaFNT1mXJP1/PZhadMyVroPqESvFc+Z01Xsb9NM63O3vWlq/K/EGj/z5x5Gg/8yk
         R+Qe+P9TIBPEoXXZmTxcTbbOhD8cMPf/k8Xcl6/U40r63zO97VQaAf47FmfJzgtAm5zM
         BHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739345268; x=1739950068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkpApLmuMSuoEXBLQRnWWTTZmdzVTlEP/UbOXT6BIvI=;
        b=Gf9ccZtdRTKyVLxltQxpNSuS84cRKOz7vO5BDWzu4W00DarWh5p7bkwpqY9NBQddf2
         EFkVQy2u5+fd1iOcgP13lxqEopMC7Dy51teHog5urNUMOgxu5AC7VCEg0pXuSroA2C9A
         a1WUiZg4eGA6z/tJYdHiG4BGGgQoVoY3NelFemzbT3d4ovMqet4uRkc1zHJHmMmo4fGd
         DiSs7cqfIDpQx7LihPm6+Yq4Krr1uPoD451SetSODQJc8l3hU97rjTv1t9R2k1swWvQe
         T8xnXtJxyNELNTH5RGdfG2xOtwWxe1Lv07MNWPbdBdqyz+MFobHkRl7+vJ+KgomdJWYD
         OEaA==
X-Forwarded-Encrypted: i=1; AJvYcCX6Wi/PPdaGN+97/j+exEm3v2FRKNGapH+gGsM6SWqL2fek6ZXDeEb2H2TrobaVeOBZhV5vNrZzDQKit5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLL4bE2pmk7PJyx/3I8bXkHd/ZnW1HpXhiSkG+KuDqPbGf4sqC
	K6zP05Gjscm4I1D/nTgmlCzCi0uO8NYvT+hSEo9MBIynTVgcuz8sOYZMxp6hGUHI0bsfrGwY8cw
	i0oaPjRmnGDSc/xRIeux6N/phg8Z/HMtjRwem7kr5Zj0w+Bqb9po=
X-Gm-Gg: ASbGncv07R1qqs+nxMFla3l4frAxiH9H55mL4KuCsgK/g5aJ1i/d7+xV7QLUyQdbV/v
	HIiLEPQjr+7b15eHYGui5qzk6wYkY+pHefzDvKRB84RhLuQLrGOxj7NUKHtxyWK3J4vfXtH46tl
	V2r2bz9UasGmjEUoPRIi7auu2HpCg=
X-Google-Smtp-Source: AGHT+IHBuOV1u76P+sliG1ZLyRYbTKiqx9yn/XwZRRCZd7FDQnrrgDlhR9/jciNljT0bWlE6m70c+Cc75Sta0/soFRE=
X-Received: by 2002:a05:6512:3a8a:b0:545:c7d:178d with SMTP id
 2adb3069b0e04-5451810906emr456277e87.12.1739345267946; Tue, 11 Feb 2025
 23:27:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <be323425-2465-423a-a6f4-affbaa1efe09@bytedance.com> <20250212064002.55598-1-zhengqi.arch@bytedance.com>
In-Reply-To: <20250212064002.55598-1-zhengqi.arch@bytedance.com>
From: Ezra Buehler <ezra@easyb.ch>
Date: Wed, 12 Feb 2025 08:27:11 +0100
X-Gm-Features: AWEUYZmZw_dR7xZ0V1G7gpsQgXY4quV-0zHZqZHrTMP56-HGWMQZHyZg-iRxnUM
Message-ID: <CAM1KZSnWFivV-7nc55MBAEtdP1LXfW4eLKa-94HPZaTP0AOPrg@mail.gmail.com>
Subject: Re: [PATCH] arm: pgtable: fix NULL pointer dereference issue
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux@armlinux.org.uk, david@redhat.com, hughd@google.com, 
	ryan.roberts@arm.com, akpm@linux-foundation.org, muchun.song@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qi,

Thanks for the fix. I will test it as well as I can.

On Wed, Feb 12, 2025 at 7:41=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.co=
m> wrote:
>
> When update_mmu_cache_range() is called by update_mmu_cache(), the vmf
> parameter is NULL, which will cause a NULL pointer dereference issue in
> adjust_pte():
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
030 when read
> Hardware name: Atmel AT91SAM9
> PC is at update_mmu_cache_range+0x1e0/0x278
> LR is at pte_offset_map_rw_nolock+0x18/0x2c
> Call trace:
>  update_mmu_cache_range from remove_migration_pte+0x29c/0x2ec
>  remove_migration_pte from rmap_walk_file+0xcc/0x130
>  rmap_walk_file from remove_migration_ptes+0x90/0xa4
>  remove_migration_ptes from migrate_pages_batch+0x6d4/0x858
>  migrate_pages_batch from migrate_pages+0x188/0x488
>  migrate_pages from compact_zone+0x56c/0x954
>  compact_zone from compact_node+0x90/0xf0
>  compact_node from kcompactd+0x1d4/0x204
>  kcompactd from kthread+0x120/0x12c
>  kthread from ret_from_fork+0x14/0x38
> Exception stack(0xc0d8bfb0 to 0xc0d8bff8)
>
> To fix it, do not rely on whether 'ptl' is equal to decide whether to hol=
d
> the pte lock, but decide it by whether CONFIG_SPLIT_PTE_PTLOCKS is
> enabled. In addition, if two vmas map to the same PTE page, there is no
> need to hold the pte lock again, otherwise a deadlock will occur. Just ad=
d
> the need_lock parameter to let adjust_pte() know this information.
>
> Reported-by: Ezra Buehler <ezra@easyb.ch>

Perhaps a detail but, maybe better use "Ezra Buehler
<ezra.buehler@husqvarnagroup.com>" here.

Cheers,
Ezra.


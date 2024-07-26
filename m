Return-Path: <linux-kernel+bounces-263027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B35F93CFED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BBCD2817B2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB12176FA4;
	Fri, 26 Jul 2024 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/iQCOTo"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C7336D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984089; cv=none; b=s7ourS7YL9PlX+aGUQ9RIGoinbX+Evc/Ejt5ZiRngUT7pi2pqQ/elx1TySHNqKlTp9Dfla3rJVD50M6gxZH3pOMEuPUy4pTDKN+IA952G8HMw+5EQZjE1ORWQQQBtmApw0xNfoPDTEO1cdQNyyUqSxyTFX5zC7qnh9nXXKMAmNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984089; c=relaxed/simple;
	bh=TfrNugf5T133OdHb9gfWJku3PqZovzEuFmoDgnq5uO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcvf45YtzTH8X+niuevhoabhqeuO2hre1MKw3Ur5EXT6ZfRaay5vtg6D7N52ttVmapBmky6SUAwPXw/202J9uFRJCGf9hnWib4bBNOt5RgE1EUYGoTFRASjon6gmVZ/vlF0GTzCk+rPnHkrMPu6IKmcXA4uu6EFQej1IJKpM6Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/iQCOTo; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e05ef3aefcfso1665562276.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 01:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721984087; x=1722588887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/JqcV8mEVQ7/8EgwWHNQ9pvAuclyKNwszROAMV1vmM=;
        b=N/iQCOToS5q0SIr9Utn6eVr6rdNNUJywhmN85HXNb2N1k82wlO+bTXc2sES84fFaIh
         JHSou+QcPhX6fv1egttOxJRseKW1AbP6swNidYONgaoBfR5z9/zm0YPGVG2XJeZzDwxo
         zzV426UxnyayStezpi/BhsY5v2V2TxjD8mrzOgQJ1DPRuNiUFgB/VALyVLk+FLAR6SaW
         TuSCdvoHQXspYflMFCa7gGH5HfQ0zsp+7xlYaQBZso74iqTqCX8ntIfzXSthWHdK3vF8
         ol9dlOUZQEB/7OhRs3riWXpJCszF6GJ9JvltrQL4udOqYBKEPhyGBqOxf/f1SLJazcIK
         QnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721984087; x=1722588887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/JqcV8mEVQ7/8EgwWHNQ9pvAuclyKNwszROAMV1vmM=;
        b=gViFxWMH4LADnNNaUkda0jEXAIr54EUP8My+GaHwJgsuumuu9FX5mHzMg/7XZZWdqz
         iDvY6Hu/WDfzQV1VWSeUOMkGpDoZZ6GeSeucqKl93eEcCoEqQF2I0S/dhlhJ3eTj/ekU
         DZx0ZrxY3mibEOtVoqMJh78ibXZAkX0dZySuKIQZrHVB6D6Qlfxhhx+I3Eb4uwF0STZq
         fuKSMJKE62BWG56UGTt09UFGMTNnHet5c4iCLOn4tT7dd+05/s8y1t19LonYL8dc8eg5
         Sq7e9Wb38tyXMnljRDXCCY2/84+D4GtBnw4gsm5R83OG7XnbpmImiWWtXrC/Sl+9CbFd
         6/kg==
X-Forwarded-Encrypted: i=1; AJvYcCXMP0EMzjHnQCQjrCrZzmu4zkaLjH/cR0UNAwSmxqACl9NyC16UtLxN9XOkwcSPB0edbNAALjQLNWCWndaFOjW+Io6riWs2sQVkU6Kw
X-Gm-Message-State: AOJu0YzAZ7FVCDnjInH0nTibono+AsZUrxN/UstxjBKPaIspfVL8DOkk
	7EdVD5XToc2euj6nq2NKR8XVHjk4E3jnO5+/W82wR8/55kjbIhTxcfxYn6cALTs/PHszVGi4d/v
	zCEWGIVw60rwPlAgviJZjtBX7RdY=
X-Google-Smtp-Source: AGHT+IFXv3qeViSvP4rwyzqAri0VbyvpF1Nb+qBE34k7tdpJKT80WFDQASVSVFCDCn6fBFplpiKrBDg3TcjJd/QL1/A=
X-Received: by 2002:a05:6902:1b85:b0:e0b:43f4:b541 with SMTP id
 3f1490d57ef6-e0b43f4bb65mr1236916276.12.1721984087039; Fri, 26 Jul 2024
 01:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720044127.508042-1-flintglass@gmail.com> <20240720044127.508042-3-flintglass@gmail.com>
 <CAKEwX=NCm9t9Y6z8bWQ788_wnhQsGN0frroTabNpHStxGnJOqw@mail.gmail.com>
 <CAPpodddd2SAVj3JmDHOz+xdaAc4nPT49_yHqnPCtcFSWqJk1=A@mail.gmail.com> <9ac88791-54e2-4f7c-9171-5a1d44e01657@linux.dev>
In-Reply-To: <9ac88791-54e2-4f7c-9171-5a1d44e01657@linux.dev>
From: Takero Funaki <flintglass@gmail.com>
Date: Fri, 26 Jul 2024 17:54:36 +0900
Message-ID: <CAPpoddcw7BD13ME8xG5TP=kKV=5t_JCxA0DW3t7C5o1wkC5tfg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: zswap: fix global shrinker error handling logic
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your comments.


2024=E5=B9=B47=E6=9C=8826=E6=97=A5(=E9=87=91) 12:21 Chengming Zhou <chengmi=
ng.zhou@linux.dev>:
> > and, the reasons to (not) increment the progress:
> >
> > @@ -1387,10 +1407,20 @@ static void shrink_worker(struct work_struct *w=
)
> >                  /* drop the extra reference */
> >                  mem_cgroup_put(memcg);
> >
> > -               if (ret =3D=3D -EINVAL)
> > -                       break;
> > +               /*
> > +                * There are no writeback-candidate pages in the memcg.
> > +                * This is not an issue as long as we can find another =
memcg
> > +                * with pages in zswap. Skip this without incrementing =
progress
> > +                * and failures.
> > +                */
> > +               if (ret =3D=3D -ENOENT)
> > +                       continue;
> > +
> >                  if (ret && ++failures =3D=3D MAX_RECLAIM_RETRIES)
> >                          break;
> > +
> > +               /* completed writeback or incremented failures */
> > +               ++progress;
>
> Maybe the name "progress" is a little confusing here? "progress" sounds
> to me that we have some writeback completed.
>
> But actually it just means we have encountered some candidates, right?
>
> Thanks.
>
>

Yes, the `++progress` counts both error and success as an iteration
progress for valid memcgs (not writeback amount). Incrementing only on
success will overly increment failures counter if there is only one
memcg, one from writeback failure and one from tree walk ends, the
worker aborts on 8 failures instead of 16.
`++candidates;` would be better? replacing the name and fixing commit
messages for v4.


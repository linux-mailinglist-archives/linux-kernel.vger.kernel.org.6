Return-Path: <linux-kernel+bounces-212498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1EB906206
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 04:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1801C213BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 02:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EADB12B14B;
	Thu, 13 Jun 2024 02:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0KGvJec"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEEB1756A;
	Thu, 13 Jun 2024 02:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718246169; cv=none; b=nXKBk1R7YWH0Nky3LpLMHyIjYJOFmmdaKByRxxJOC4umzqs/uH1OOkYaLqwUrmLUbBU5fdAlrRg6SSiNucEkaIbFtKGR1jQ1HEb+llfCpqZzhYkWOR/ZlwAQ7H0PiPs2ugBcY99TWCn2zBE737jOYQK6/q7bHhZL/oCqVDoOPqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718246169; c=relaxed/simple;
	bh=Y6hdmKk2/Vk2ule0qdcuvwWu0NHntXbzPfcjRAUsj0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jardV2CvAUNKhXMX88KVYrIo467a7yycANNCkPOYCrNkK50QG/gVA7OXZpsZZI+cU1kNogDgw7mR2THWZlgr/3Pcrk2Q3J5jukloWNud2wGjQlzUf7IUFLhfzHxjIRCw386nuC7HRbZ+gFYHep94DFUy1iYJrJ5QUErmPUtk+Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0KGvJec; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dfef7b13c98so636590276.0;
        Wed, 12 Jun 2024 19:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718246167; x=1718850967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82RdtfxYrWWcM3I6B6y84KEkzZzezIo37YsjuYxzk9s=;
        b=A0KGvJecJWsmqk5qJOtlP/zTiZSscl2Xzo+o6v4yBWu4GfEtCDzXXLNHEB92GJOc7f
         w5eW+ZirlGw5H7+V5D/h8ZY9719/tJq2DLYY8PBlH5Gd/CumgLZYmq0jiRAq1jOZF0am
         jHKMKOJPAoKSyzDAZg/IG721Ndec/H7KYo5ot2LrVV3VOBwLCONU9hqBXZovdklYqFIz
         G6KZJ+yVN0Gz0Apym1CQzTp/ZBfYnzj+eWkNBpz1p7uAuLaDQvDGCluFGwcYaos8Zmlr
         XJ+nAZWNltA/iKYs2k230vFgh1FdK9GVuQvOxM3F06GwPhNN6uEXMxIycOTSIFVtRy84
         yFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718246167; x=1718850967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82RdtfxYrWWcM3I6B6y84KEkzZzezIo37YsjuYxzk9s=;
        b=dU5G9d90pZ8YTJkpymJFS2V/G8ieVXJf19I1MjJEKhkNrS6CFTT+biMq3vyjRBt0cV
         GJGauZDbGDjSMyqYNler6llcWC/OKbaYSaAIKTvvEmYiAsQAtgpvETTVY7lmZOM/R17N
         vv4bGoLDlDUTIVpataOO2kNGGS1RMae7K9/m8YgQNtgjZRS39SyEuUmSczwoO4EGAw6i
         0zZzkR17lLGzzpK3EL2LZLUo6in4ad+TFDnDWGQZKS7t9DeEIza17GmcZdWeLW0xnTBU
         giUuOfCi+woFE6d93ei0f2AVOMeUPiNl105o3Agmjga4+zduANVe1sT6zEALl97NO3h2
         dVVg==
X-Forwarded-Encrypted: i=1; AJvYcCXKN+NPB2qCuBbfZhdj7SrdCW8eLGGLdFz8yQT1way+xNWWyMRXyTDiFHtCtK8ZaRmN290LinRL9ivRhlQg29jaX3hlitlmPy0jwYgo39aMU564VjPZuwC9x/gt7lrMlcyMGMpvI2uq
X-Gm-Message-State: AOJu0Yxq4UaIBYoxhWMGFvHKy/txLx4w0mGkw+9KYb0J90SGSMa3rAcO
	Vasax7w1Q9ieTaaBz5rGI2Sl9AepUAy8cf55dYwA8NKgMZIDnGQKBScdCzrywhlW28XkyJDBaj/
	U528OpUAM6CgEQWUKs7P2td55l5csAnksHD13AA==
X-Google-Smtp-Source: AGHT+IHPPB9CDIIXDtRgehLklf6KAJTHBjBvn0hsTFgqzGe0BNYXVRUrc8XbhAAjaZMvR2fQ96wGc3rbtTkWa0pwhwU=
X-Received: by 2002:a25:d688:0:b0:dfa:5a37:41d0 with SMTP id
 3f1490d57ef6-dfe65e7ec75mr3578791276.7.1718246167344; Wed, 12 Jun 2024
 19:36:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608155316.451600-1-flintglass@gmail.com> <20240608155316.451600-2-flintglass@gmail.com>
 <CAKEwX=P1Ojb71AEJ2gzQTrfWidFPcJZmoNxEwji7TceBN-szCg@mail.gmail.com>
 <CAPpoddeigM44jhTA8Ua=+J4MC1MikouBZVoPrCW2LZF+9r5YeA@mail.gmail.com>
 <CAJD7tkYp3GbuXV9G5bAZ1DetMmepV5ynciA+ukae7CKuxpXDJQ@mail.gmail.com>
 <CAPpoddfj1EdfXfTUT8bLaNxat0hYiE4X9=qG38gPgRgmmVOjcw@mail.gmail.com> <CAJD7tkZTSGz1bpo-pMNP_=11O-7RrhubWonqhUJwrt+TB=Ougg@mail.gmail.com>
In-Reply-To: <CAJD7tkZTSGz1bpo-pMNP_=11O-7RrhubWonqhUJwrt+TB=Ougg@mail.gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Thu, 13 Jun 2024 11:35:56 +0900
Message-ID: <CAPpoddcp9rVvg77WapsuiMdMzFrV0UioJ+VbQuJbKNY7-=nvVw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mm: zswap: fix global shrinker memcg iteration
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B46=E6=9C=8813=E6=97=A5(=E6=9C=A8) 11:18 Yosry Ahmed <yosryahmed=
@google.com>:

> > The corrected version of the cleaner should be:
> > ```c
> > void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
> > {
> >         /* lock out zswap shrinker walking memcg tree */
> >         spin_lock(&zswap_shrink_lock);
> >         if (zswap_next_shrink =3D=3D memcg) {
> >                 do {
> >                         zswap_next_shrink =3D mem_cgroup_iter(NULL,
> >                                         zswap_next_shrink, NULL);
> >                         spin_unlock(&zswap_shrink_lock);
> >                         spin_lock(&zswap_shrink_lock);
> >                         if (!zswap_next_shrink)
> >                                 break;
> >                 } while (!mem_cgroup_online(zswap_next_shrink));
> >         }
> >         spin_unlock(&zswap_shrink_lock);
> > }
> > ```
>
> Is the idea here to avoid moving the iterator to another offline memcg
> that zswap_memcg_offline_cleanup() was already called for, to avoid
> holding a ref on that memcg until the next run of zswap shrinking?
>
> If yes, I think it's probably worth doing. But why do we need to
> release and reacquire the lock in the loop above?

Yes, the existing cleaner might leave the offline, already-cleaned memcg.

The reacquiring lock is to not loop inside the critical section.
In shrink_worker of v0 patch, the loop was restarted on offline memcg
without releasing the lock. Nhat pointed out that we should drop the
lock after every mem_cgroup_iter() call. v1 was changed to reacquire
once per iteration like the cleaner code above.


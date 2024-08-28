Return-Path: <linux-kernel+bounces-305767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A258A9633F6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595FB1F245A6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C2F1AC43B;
	Wed, 28 Aug 2024 21:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dumRzpFE"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CBE15A85A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880933; cv=none; b=KrQVm19gxJ0Agvv2L/mWeg3OpswWBLMON/Y2YKrO13V2if0VmvryIfCSw5pTYZq80NYeqaIGvEaWhyLvGlxCzIJoOdk+7L0PATUGHS2DafHPT84qmbLoGAmTTm/0AGxfsaPG0t4m7G6zOgj+1KJCl3V5zQf7rQXV8Zp+XRSNKAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880933; c=relaxed/simple;
	bh=qq3d0FfjtfTvbD/KnIGka8ZF73mSgPZs7lHC0CeNUUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4tfBPcI9JCurPNbFjgxgvdLL6Ptw/d7m6SMr1ngsGmmY1rWYA5hrz2fifBWdzv6bxB9+e+TIg8vnEyhWwUMMms2u96iNaRqwGi63XaTyKFsjOK3SLEvGZyOVEVAHpKXeoEI9P4nUKCMr4Dv+UVDT5znn/zNXwiQHyPjbYpoTpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dumRzpFE; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6bf99fee82aso37045456d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724880931; x=1725485731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7q/65fw6u/ET/AVvM+frdRKGbRF91OUqQsqzQ+d1cFw=;
        b=dumRzpFEKi1l3GeLgfWP4zYHzlUrnFqxrBNDkDF1A500yeb+H4veRdkTg+NlJCiU1T
         /S/9kEO7/V9PHX6DylcNqnaWDTc/nnNNQIgkWRjTUtc2rfZ4TSYlSJ7EYfWBkkD3C1DJ
         NNPt550+Rh9fg47b8D3owHmhGh0B0UkT0p/1sPemhrCOqCNeMZXM0wRymhsElyc/A3Ju
         nACY9CAY3p7GEvJI0722hHFo4dOk43t+lNToIf7uqQt5dMuHOy42+yuu7fVn0dDLkSZf
         E5iEqhOWk65EjWnm2s9SpyKsa4LvxSRwy0ZV7r35/x2mo5vBxPXDXXVfaqTcDpJUU/B4
         n4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724880931; x=1725485731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7q/65fw6u/ET/AVvM+frdRKGbRF91OUqQsqzQ+d1cFw=;
        b=legdz2Nj24sullvimNqwLX7LmSdsVoZzDwTHIEgXIVJAkSGOHoeija+W+pjthbrYUI
         99ROUcmopOzsY/8aziRtKh/B2nTA6+GnGSwiHLo2EOW0XEv8i1xTk1SY/i8/nZhDwhNK
         X4Uh3/S5fNaZZQsAILi/upKkNOhI5VycIWmnLWK16/LZoLSJqgROo3G8v4YS40IwDyyG
         Mkmj/pa+6GWxpqf/B28i4XwjTcBbroymqO6CDzG+2rDxFwiPWqRIX8sA523qzTU2bQCs
         rIJpXiNh4kmYVQohodibxbkZCwo5kIGIqxENXXsOZwkmBtdUEqgf/Z16SIWFp5tMFoE3
         PwfQ==
X-Gm-Message-State: AOJu0YznUlIBtEbEBcE52yqdu7aJ+Dkgh3tf2iDnzsB2nn621UfclnVl
	3aPvEgkm/wrULrUJ4fVrt1wCTJhoHOfWxkF+J7fQrlnllwIBZHkUCPIYudrDhtJbNwEydcl1WX5
	UzJO1R42taXQqL/pfhSJhs4MoWf0=
X-Google-Smtp-Source: AGHT+IHa83Ue9OEMW6d95OAnEdp3di1gNe+feVg7h7WyOfG9xgMTtD/ropKRSryPH/4PbQ4dI4kjipeaz0lKPUQu6+0=
X-Received: by 2002:a05:6214:5d0f:b0:6bf:85bb:9c2d with SMTP id
 6a1803df08f44-6c33e62304fmr8697076d6.26.1724880931087; Wed, 28 Aug 2024
 14:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828093516.30228-1-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240828093516.30228-1-kanchana.p.sridhar@intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 28 Aug 2024 14:35:20 -0700
Message-ID: <CAKEwX=Pqm3pjOO-ErOTGnNYKwMas4fdiN0bdUcrPHzfKf-Qryw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 2:35=E2=80=AFAM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> Hi All,
>
> This patch-series enables zswap_store() to accept and store mTHP
> folios. The most significant contribution in this series is from the
> earlier RFC submitted by Ryan Roberts [1]. Ryan's original RFC has been
> migrated to v6.11-rc3 in patch 2/4 of this series.
>
> [1]: [RFC PATCH v1] mm: zswap: Store large folios without splitting
>      https://lore.kernel.org/linux-mm/20231019110543.3284654-1-ryan.rober=
ts@arm.com/T/#u
>
> Additionally, there is an attempt to modularize some of the functionality
> in zswap_store(), to make it more amenable to supporting any-order
> mTHPs. For instance, the function zswap_store_entry() stores a zswap_entr=
y
> in the xarray. Likewise, zswap_delete_stored_offsets() can be used to
> delete all offsets corresponding to a higher order folio stored in zswap.
>

Will this have any conflict with mTHP swap work? Especially with mTHP
swap-in and zswap writeback.

My understanding is from zswap's perspective, the large folio is
broken apart into independent subpages, correct? What happens when we
have partially written back mTHP (i.e some subpages are in zswap
still, whereas others are written back to swap). Would this
automatically prevent mTHP swapin?


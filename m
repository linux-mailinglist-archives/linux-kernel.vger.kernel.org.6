Return-Path: <linux-kernel+bounces-376965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BEF9AB827
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3418C1F23F42
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A671CBEA6;
	Tue, 22 Oct 2024 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="zG+8RNZd"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E8E13AD2A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 21:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729631030; cv=none; b=BB+et4y6k2jz+tqea98DivejKRAG09oPLVldh8PV3E0LE0WRGbQiVcKjlJe5hto7pibZ1aIVsA7ZHUrUpJMA76WsL22mkjU11+EGVWUG02Tk02lGh9mcQvBgCmCEkeF/mIlCeA2QWeFg2F1QcKZyo/L9iS4gTMexSs7fMsmeiK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729631030; c=relaxed/simple;
	bh=MeOuekFNtvwTvmp0AmDsemHK6qoxZhx5ar7h1NwkehE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lL42fTBncFrBXGMMomdQcSP7YNT7ICH1NqPSw7dLsqCKdoCbsbc853uPB6Yocssr7fTy5RJ8iVXHiaO86GZb24XqC67hd7DO45Y+o1DCgnbuaUorzpLQCouQ7iRxhA1mJ/e0WKBNTWnSsMRLtAVOuH+JjPxXkpRJtV0wjdJ6xLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=zG+8RNZd; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5e7ae4c504fso2722122eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1729631027; x=1730235827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZYynItr3002glGRtAhKYMoiHc4P/Z4cdPRlYmwfRaU=;
        b=zG+8RNZdXvxHZ0MtV3TWmolGKZ8rGXuGjkNZofzqliErLxoCBH5xH22N3N8sz1+X+X
         EeyhkOo2gX1yVJe5CrXWghpl+nlIJ1pDtyu3OcfbflleQIbkz4RsBcTVvHivPKWH6MsR
         NaTuee3t+ahN3jerRIuM8bUzsyipVpIF8nWdONHYPDg+23R4XL1rF+5R0LuQZA/X1TU2
         8XeG1Tzga3UPS4UEySy6JxBZXeiuy/IZ2Rx5ZT6L0vyZbQ0M9V7J7nhXZYyRvziRQAme
         3zAcVEh1XnUzdgul4zja8qgER654FmyQWNtUSyoYCvu5ayc8ZX64PJ7GZwUn0I256yGV
         9MLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729631027; x=1730235827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZYynItr3002glGRtAhKYMoiHc4P/Z4cdPRlYmwfRaU=;
        b=C6Owm493udpgGQJ+2z1VlttFzVNzd8H7rx199gDxObwH0gDPp1X2SkvQ/oKT/8t92m
         n8ckun/TPg2Ia8IMDpZ0gnZui7UQTW5xaHF9XciN8mDMRmRnFUnzL9zuidiuRfvToygh
         bL/yc83pO/UqomqpHAZjKzuRNIHjbXeEfBzlDCH9WUQcQbl7X64rrs3dif74XxFl4O45
         KX2RhLgscdiqTFOnc83F0XXkYDi80mxw0rBuC16OmsMpM+cFdzNcZkAEl9vKs/mA5jkv
         nO7vdHGD91wXPQR2MT7zJFrRt6DfPZ711p1iOefAkipi4FAegakCOVWGYbTLW2XAyBai
         I64Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbna9Z117Tx1SdgTHC2QfZBprfXfysxg3QuMzA/4eEjTd6y30cdKfwSiXCGQJK8TInx6VZzYVr3Tekgss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVNol7mRMRLBrhbmdY4Mhu99RK+EeUJ77xGuXyXtvi5nVBgXSe
	zu0aeezCgcQkZ0Pdn9kfuck0EBxjPeqKpwY8B1iOhKRAW3PhzdIfvFM0PTdhrWnxxug9Ksi0EJj
	EH8u+GH4qpZIG9hZMfTXMMnyZ20qkJ/2Vz+YOPQ==
X-Google-Smtp-Source: AGHT+IEGkLwDV8Hk7DGupvh45K/EdV0qi8GDuIXpLoxjcrecG53W/vss05MygFhNIl9wlAh1otGQu277VwFw92Wm1SE=
X-Received: by 2002:a05:6358:560c:b0:1b8:32b5:4e90 with SMTP id
 e5c5f4694b2df-1c3d81b404bmr25550855d.27.1729631027330; Tue, 22 Oct 2024
 14:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022205622.133697-1-souravpanda@google.com>
In-Reply-To: <20241022205622.133697-1-souravpanda@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 22 Oct 2024 17:03:09 -0400
Message-ID: <CA+CK2bCnLyEpT-Tr_GGqTzWcNOviE93cyb=WQ09ksYexbzJ7_A@mail.gmail.com>
Subject: Re: [PATCH] mm/codetag: fix arg in pgalloc_tag_copy alloc_tag_sub
To: Sourav Panda <souravpanda@google.com>
Cc: akpm@linux-foundation.org, surenb@google.com, yuzhao@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, weixugc@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 4:56=E2=80=AFPM Sourav Panda <souravpanda@google.co=
m> wrote:
>
> alloc_tag_sub() takes bytes as opposed to number of pages as argument.
>
> Currently pgalloc_tag_copy() passes the number of pages. This fix passes
> the current unit, which is the number of bytes allocated.
>
> Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")
> Signed-off-by: Sourav Panda <souravpanda@google.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thanks,
Pasha

> ---
>  include/linux/mm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ecf63d2b0582..2890001c8b97 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4203,7 +4203,7 @@ static inline void pgalloc_tag_copy(struct folio *n=
ew, struct folio *old)
>         /* Clear the old ref to the original allocation tag. */
>         clear_page_tag_ref(&old->page);
>         /* Decrement the counters of the tag on get_new_folio. */
> -       alloc_tag_sub(ref, folio_nr_pages(new));
> +       alloc_tag_sub(ref, folio_size(new));
>
>         __alloc_tag_ref_set(ref, tag);
>
> --
> 2.47.0.105.g07ac214952-goog
>


Return-Path: <linux-kernel+bounces-236346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDCD91E0C4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BAB82812FF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B710415A863;
	Mon,  1 Jul 2024 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r9BUGdQ3"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A686EB4C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840799; cv=none; b=HHjG4Np/MsTFssP+KQ03P/jsl3M+ya9QiH+T94juaL0oNlTJ434T6eWkdtq11eHy2vtsZ1pE6lyaKWCnjDW/NY+8ZmlZ0Q8UJ67GSyVgafSFHxTXy1XBXvKz2YaR+IUY81kGR5qoZkJjP2824jLV1SpsPNznwsh2R+GrREmlqg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840799; c=relaxed/simple;
	bh=fMFaj2j2QpZkox/Cr3aghbQNsBUWRUsAkpeVtopELzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hw40CM3/m7EdPJYaPGbrX5fHfY72xKy+q99ePEGBIXzX7jkXcEsnna0D25hkNuE3xcR+vNpMM78AjUgc3sfiytmKaJzbaYLyt2rwoYA0KAIcwY7HnINa2ploJKyJ0ZwvvPg6/x3KssLujxgxd59+YqxonsvyV7m15Y47AeQwKXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r9BUGdQ3; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a725a918edaso440853666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 06:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719840796; x=1720445596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMFaj2j2QpZkox/Cr3aghbQNsBUWRUsAkpeVtopELzA=;
        b=r9BUGdQ3dtcr5qd3UTALbCpKUSVZpNAbCbfULZ2CwKBfhkOJKrGvN/zuSBgwd1mIzY
         KAmvVFxBT0N4sBR/2kAqsUGBnKtDEXxs8DlR9gxBEYHmrzK0I4ZmGIClDXzPc8IFv1gC
         dsjQFRi1g+Ow6kyHhV9O2nCYbpq3gqxAPPkGntb5p8iUQbeRuWy+c2jAoujTy8Izjs0V
         OjT+QTruTjeKwuCBPAySyMddYvwKrS4kBWWmpwsxtw+xAd6+LV3OS2+r8XIxLWkyCK1J
         9xKcRNpYoO3mAdO15AFERFR3BekyqErXxwRjCUg3NSNpT/F/wPorbz1CN6wGiefvqEvF
         D9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719840796; x=1720445596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMFaj2j2QpZkox/Cr3aghbQNsBUWRUsAkpeVtopELzA=;
        b=qVjrxPRTaPmGB2HbwigwSp8vgW1iSbKs/SzRrZonNJFcESFECAMbMpK4qsULhtuLI0
         lp1wpQuLSy5na0/Z6lv0U1ICr3VoFNvVwM+fQagI/sPukWaiprvPrxZ/6qNsp/k5o09X
         SdRQp0qg86C3+iGRVxVFGsrhujKoCMOeB+ztmSrQ73zwsGAv4hh4Imihfa9toSS/u8Dc
         qcMrLdV8PJ5UIk0feyziPctBjhfob6cZOMY5MaZC3eMx0cOer163iB0zZe+qml3Xj6Oy
         +1U8e6a/LXAjdbOF04Xhw1LdnMmtzUUtU5iQeEI1onn837RxUMS9gBTMchpmpekRmdsW
         zWJg==
X-Forwarded-Encrypted: i=1; AJvYcCXxFDp+vofcl8fPI7sFTtGwZQwdqNXGtZQKLLkJkblLu9Ll4ZC8yzW0pIbX9n5GfCYdeq4sO+zyX79CWHf/w2IMkHaEjxBu6V6bBQK6
X-Gm-Message-State: AOJu0Ywv9op3DXBpG5eARwPnfArVb6OUVvKPpHhvC8vk0y2N9kNy76LO
	EqW9UaU8tZHEiTJSezyj3l/zS57dsW+dY6ayRHDrARnrhgZHbQmwqVIb4kFsNMuoX4431l7AaHg
	brTzp8SNMQaDQDwByj6pC8uNvKdpcx0fkbv/j
X-Google-Smtp-Source: AGHT+IHu1BLuiHzE892CLZKL1woYinWVTBOp50vCOaQbetL/O/zfKJmmbJvsfBiayZX/B22FZ93jhNxsYwnpALrRjFE=
X-Received: by 2002:a17:907:86a0:b0:a5c:eafb:5288 with SMTP id
 a640c23a62f3a-a751448a596mr525273166b.31.1719840795419; Mon, 01 Jul 2024
 06:33:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629232231.42394-1-21cnbao@gmail.com>
In-Reply-To: <20240629232231.42394-1-21cnbao@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 1 Jul 2024 06:32:36 -0700
Message-ID: <CAJD7tka5NKqnbaqxmagTAi-qT0f1FaomUXHCWLoZfxY-FXsAig@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix zswap_never_enabled() for CONFIG_ZSWAP==N
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chris Li <chrisl@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 4:22=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> If CONFIG_ZSWAP is set to N, it means zswap cannot be enabled.
> zswap_never_enabled() should return true.
>
> Fixes: 0300e17d67c3 ("mm: zswap: add zswap_never_enabled()")
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Acked-by: Yosry Ahmed <yosryahmed@google.com>


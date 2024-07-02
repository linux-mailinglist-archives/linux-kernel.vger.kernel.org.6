Return-Path: <linux-kernel+bounces-237358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6193F91EFA5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F31E2839F2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 07:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA58012FF8F;
	Tue,  2 Jul 2024 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTzRQA1y"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B5A49621
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 07:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719903651; cv=none; b=oi2liIUFXoYeDHlFvrTHYeVBimw+3JVhl9GSabJ78iUk/YQSWJvlixUt7QlK3daA5Xenp0cJb/bWfXdzuDxJin8OhAEKDvDwypdfzrDDfChGJP4c47OAxINKmJ9YivoUqX0vPoCsNbwQqwbkz3g6sxPm9AzuBduiG/HCIEQNa+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719903651; c=relaxed/simple;
	bh=8H8roPeUelDOiFqQf5hjpD6XuobaMtYfjBfZzWg1rkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZoUL6z7P603/PQbvWTSwjP44lhnUrqOBazQdTrybrnLTQa5XrmK1Wl0v9mMHcZYnTauXhV/Itq51aIYDIDZBmTXSZy3QXj4QQv8PeJA00o0d3/ZcftSyfM5QEm4tAyh7pfOFg43qU7db4iixZj1WqpeUdUT3rYBs9YqqwuUB10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTzRQA1y; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4ef5c772f7bso1412484e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 00:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719903648; x=1720508448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVmRV5m1ilv4tORGGi5gpezd15POxjhkF3KSK+C3VOw=;
        b=LTzRQA1y1sl3zSGZYddK07WfuoK1tnsye5EmkeuCKXtyLtOcSNXukwju8TTMWOhc2a
         HuscBL9JTdjQvP1hwM6vkbfLlalCS34y2/vjSFDGKBxM1sq71OnqiQMu17mqF7wkeNwb
         zycyQuClLo41IetaZbSaSlMW/d0T0LQUL8AZp7detwPgiCZCTRwJ++0gRaF5HEa8go6e
         h8zkSWKSAP9ci5D3PCyrtT1ChcDUaJ/chqc+9m4jdF6OGTuzS9udMQvpHni5uTHJ8w4d
         lgEQilTJv9AauCA1yyQUXDMKBv6GcLSIKijCsxj9wzkKXcuZkLgW0LJAfspzfQsGG7JL
         mIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719903648; x=1720508448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVmRV5m1ilv4tORGGi5gpezd15POxjhkF3KSK+C3VOw=;
        b=iuFAvip38O+F5RNrBCkMvqh1vcmu0zou98XLEGlQLOg8mOfqZcDyPNB+uuOERbPS33
         q/PvvuOH4ZLkJrYmd55H7igelAtW8xepAZCCvsO8PufYUIJcg4daFVz27a3+MJh1AdJE
         GzZYaK6n/uSMoTwCcIRsaydSSV4875B2PeqC2i1K5D8y1Ta95mdi5fCmZsto4+x0AcHw
         FcD8G2TniSDme7NaJCwz5/uu/ksWNbZ8UNX2MqyD1rpKDXBbWPQbSg/0YyZbXGGp0CKA
         4rW1zs5oadv59a1RxszCyk/cZES7gFNHhsfCCoXg2hhqdlkn0w5CJ3tHR6UYKw9rLnMq
         Q0Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVN4dftltk8FMpoGRNw9zhpK7qdSzBWIOjqZBrRLBZZFV2TG0shsj6MrXR9R1Lkp1Sj6LglsNUAo+1WOccEfhs2ojZ/aTf4l/6Cbzaa
X-Gm-Message-State: AOJu0YzDELFXjLlS5j5tr5JuFghQsC/G2i2/ajiNAQ3hepXWGE3XOZWz
	lZCIU9dcwQ+ErkMvY1GRMFTPzWumEiTECOrYIAUA3fxhcp/LZFvzHLcetVq6UmzOduaqXsdUITV
	VUFNk4SvkUN3iHTLBXJXMVlSutC4=
X-Google-Smtp-Source: AGHT+IH2hGaDefj/9/VxSEr5iNCMHemG8WkrmTlZIq4MzX/b/HHXaHbltdCnRv8Sg4+xfZfO/BzNpCrp+pH60F5zRJI=
X-Received: by 2002:a05:6122:478b:b0:4ed:145:348f with SMTP id
 71dfb90a1353d-4f2a56e6f1emr8906862e0c.12.1719903648317; Tue, 02 Jul 2024
 00:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629232231.42394-1-21cnbao@gmail.com> <20240701235210.5c187c85aa225292d034cafc@linux-foundation.org>
In-Reply-To: <20240701235210.5c187c85aa225292d034cafc@linux-foundation.org>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 2 Jul 2024 19:00:36 +1200
Message-ID: <CAGsJ_4wir6nmX2xMGn2jPebCWg+wuTv05qxCBC=MgiAPN5nD1g@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix zswap_never_enabled() for CONFIG_ZSWAP==N
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chris Li <chrisl@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 6:52=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Sun, 30 Jun 2024 11:22:31 +1200 Barry Song <21cnbao@gmail.com> wrote:
>
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > If CONFIG_ZSWAP is set to N, it means zswap cannot be enabled.
> > zswap_never_enabled() should return true.
> >
> > ...
> >
> > --- a/include/linux/zswap.h
> > +++ b/include/linux/zswap.h
> > @@ -68,7 +68,7 @@ static inline bool zswap_is_enabled(void)
> >
> >  static inline bool zswap_never_enabled(void)
> >  {
> > -     return false;
> > +     return true;
> >  }
>
> Well, that code was as wrong as it's possible to get.
>
> But what effect does this have?  Seems "not much"?  Perhaps we'll
> attempt a zswap_load() which later fails for other reasons?

Yes, but the API was created to inform the mm core that zswap has never bee=
n
enabled, allowing the mm core to perform mTHP swap-in. This is a transition=
al
solution until zswap supports mTHP. If zswap has been enabled, performing
mTHP swap-in will result in corrupted data. You may find the answer in the
mTHP swap-in series:

https://lore.kernel.org/linux-mm/CAJD7tkZ4FQr6HZpduOdvmqgg_-whuZYE-Bz5O2t6y=
zw6Yg+v1A@mail.gmail.com/

Thanks
Barry


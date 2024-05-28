Return-Path: <linux-kernel+bounces-192654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9624C8D2035
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C712B1C2318F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DC3171671;
	Tue, 28 May 2024 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmHnHnKf"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1A3171069
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909518; cv=none; b=u0w2x93Sthu24zw28mNizkt+BZVqXODIre4cIx4Bx9+/QW/r0MGRmKt3CULWdpGudKTGyGZ+3m0UYzcryan8DOPFfPScPakODht16JmYbctW/Ce5u3EDgCg5me+xXJlKu6Hqv6ER80rIc++TIH5g2m/TSkO7jJsJG+jgc8+qYZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909518; c=relaxed/simple;
	bh=DAI4wTRONpyDHoevO45KRBaZnNMth7l2XRIcdvktxRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRXtbu3n2DLhHRgJGQNppFBdnMnX+YbV4edHhEYhxOAZ0ew5/ZZVeP/vlKuRERTL55/tTZfukIZ/T/w0P/NiBYNxzLEl2/PlF2529NkCB7Rmwc+sfBd8vfzKgTL0AOzAeHUMOAJwjyWyCM+qs33HI6Yj2PsOHIoMrwqKfZEMeyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmHnHnKf; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-627ebbe7720so9361827b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716909516; x=1717514316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAI4wTRONpyDHoevO45KRBaZnNMth7l2XRIcdvktxRo=;
        b=VmHnHnKf7FTNr5BzRCtSHu2scyRBZNziPTO7sDXi1ccLthEygJkunHj5VHANX2Q8nS
         4ynox/rx8rVlLBvz/Tap+9U94YqU9Bsi0JLT3Mc8lHI4CdFBgpXf5iRqXenNZbCZgpaq
         1peK2idJwqmWvF/q6+aqEy9bJ/Wc6UcMzHbOq5P9WyiNN/Hso9CbRKO84whX38QqKSUe
         NX/PmqDnnppVgfcMCW8VEGHJ22Nu0g8ybQVHr0+oZBitCSoQlCQm/G/AuxtODSQJdbFq
         fLUIxu/UPyluUOPI53KofzH0amLQs0YsqDgasbTa8lZmGUh/MRmn32kW2wjWau2P3VuN
         QkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716909516; x=1717514316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAI4wTRONpyDHoevO45KRBaZnNMth7l2XRIcdvktxRo=;
        b=byEof6Q2mgEhOY0PBS9TPHR2DfapSoZUn3HwnXYY75AlC3o8W4xIqLqcRzHdtuVzOE
         NXAjEPYFkAo9sTj+LN+0npX29NbZO9e0HA5zmgkf9UAg44EgX3ie0i5NSybs/xS73FHd
         BLYT1fwaN1tClVLnJMT0ssrkNf59RiEFuCoOiI/b4H3Y6ITXMWai6USxyU4g4aqFyj/y
         3o5fJ1yMoyC+XG/e6y36Ipwl40bs9JPG38TkqC3UbVcRFtcSYNKoxxgOW9S9qgWhQBkw
         D04l2lcsY5wW1Pa0Uh6QpbqK7vpc8vksp5fZvFNcvafs6PxSlcs3WErATWE+IxnQW227
         fFVg==
X-Forwarded-Encrypted: i=1; AJvYcCVO265qmPKBX35FA3po+8i3aD58DdpNmPFL63VuJU+I2K1eJVHVGvKANYmFQUs5QqEFPHBhmg9nWDt8tM6zmvDftb++gX7t18o9fZsi
X-Gm-Message-State: AOJu0YxaQg0ki3ciLiHBctNTx9tDPBmK53YuspFczudVE08zdSlUtaCu
	mzEdqMBplm2xMN5tL6wX0x6nqPbJ7EHE0Ma5lFeKOL/YZg8DvMoCgTJAYzrX6ie+zAj520oK59k
	+BNX6myeKwTCLdwklZal63qUngdU=
X-Google-Smtp-Source: AGHT+IELtNmAiYU/zHmIId16l19GazG/+CIjmGuOlJuak2gyzWubpM5Tcakcb/jM/SURpKaxrfe74i7P6YqLO60kihY=
X-Received: by 2002:a0d:dbc2:0:b0:618:1dab:2f0f with SMTP id
 00721157ae682-62a08d59be1mr122427817b3.2.1716909515011; Tue, 28 May 2024
 08:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524033819.1953587-1-yosryahmed@google.com> <20240524033819.1953587-4-yosryahmed@google.com>
In-Reply-To: <20240524033819.1953587-4-yosryahmed@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 28 May 2024 08:18:24 -0700
Message-ID: <CAKEwX=O9nUPwokH__KsT+M6H=6KougJfD1rm4=2G7zmyK0NA+A@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: zswap: make same_filled functions folio-friendly
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 8:38=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> A variable name 'page' is used in zswap_is_folio_same_filled() and
> zswap_fill_page() to point at the kmapped data in a folio. Use 'data'
> instead to avoid confusion and stop it from showing up when searching
> for 'page' references in mm/zswap.c.
>
> While we are at it, move the kmap/kunmap calls into zswap_fill_page(),
> make it take in a folio, and rename it to zswap_fill_folio().
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Seems reasonable to me.
Reviewed-by: Nhat Pham <nphamcs@gmail.com>


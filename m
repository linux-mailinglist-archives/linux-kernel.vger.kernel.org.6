Return-Path: <linux-kernel+bounces-316120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20F996CB79
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600801F23183
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2B013A869;
	Wed,  4 Sep 2024 23:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3DK/9nOQ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C609B181CE1
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 23:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725494271; cv=none; b=nxf+MQBxSKMcpeMhNCExr3bF7t7m0ZTmSUWA4Kwe7KBbeTdTChoUA5o4BUMdre0En22MI5hV8w7t4psdVEps+am6veaKfEMeElV347bjejhbMnA3bBItHAEO6JI9+Af93eyeaoTHyJavFfZlTqGJwFrAPHXQOkPXBdyd+DWcuFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725494271; c=relaxed/simple;
	bh=plpBKlbanw1TY6EjHJs/emaGAughx34CWvYXN4IMnDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gI4XJjwva8WLczSuScto8H/amLV+YQ+zYw6daEqcJrRB3fdvsymfvZo2Jdi6g367+lxZ4RoMiS7Yt2BdyUfk95Bc7A8ibAqdZrFkvk8402lB0wMPBUDVWIlk3Zqxc8lyQBwaq28SGri+R99TZ5k7QLCTq1Hh4GaJbs7rp9LRtXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3DK/9nOQ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a86abbd68ffso32999766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 16:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725494268; x=1726099068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y8ZJW6l094aIiV5gOLaCE7Yvrp37WDmLBURL80lG+eo=;
        b=3DK/9nOQmapXqlV9MGWDYifaizTK2VgNf0Z+UXwXTLiu8dua6rlD/bTvWTuU+abWsR
         c/qI4Fl6CDzwDToGxpJnWoqNanlChpE0tUmxA23JGa/2ZsJe5OZecWTTTvxUYWwIvgxG
         TNEfffE5Tte17N6UVA2imIr1JCZIi9j1hDGcL9VOOQwicDH2uwMmWkNKThKafJZvHVog
         tabBPmWPHB3NSdr3vZ4Yp41naGEV00FoZfY0uEToXKrakfv4z+cDinv/hfb0V9b+KcXw
         h7SWIKXHFTcp1YMyrTbH0uo0jE8gMFAnAWSBsuMZP9W/mCzga+SL8VlS/9cHqkjwYyLW
         hXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725494268; x=1726099068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y8ZJW6l094aIiV5gOLaCE7Yvrp37WDmLBURL80lG+eo=;
        b=g0mVfW9LBPPj5yNJbgD7cuQ/go43/qVi5MdfgmY3AYV16BLbcwMX6TTNnaUi/2B3jz
         CoCFN4Zz5diXyWBP0Wc9+FsCsLXh5KPgBCwZaGPs7thzyo2blQO4ZwGDiM0T8/IDdH0l
         yeui/RuI55vYgMOpyYz2P6/m+dMoIKhv96tbYq/UkqUOe9r1rs7ECQLTXYYJzbbOxsUi
         HOw4omVcAZJGx4TdzrhNFxRKuOP+0TkrJi0MU0R+bSxaRZsXDOQby3Rf+evgkorqYJrL
         +dxVCPaLbxQqgFbE9P7o0H7QjdnMu9HPy3EwRFgtbqmAy7QbAQ09h7xA6tdWq1ibmJfH
         sA5g==
X-Forwarded-Encrypted: i=1; AJvYcCVSZYIznfMOs3X0C2tsSBGnQHK1GMdH+v6WVXJfRlOvuuQQbR8G92iTgW0w0pzLchx1CtLjOTv6/eX8syc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp9KEkpvonK90KR77s8YoZWYgotj7ePdYCXKKtxqFvo78jT896
	NWv7HECg8itNjTsfZscBg4HCBpBPs3fR60lksrQ5TCHqDpOzRBoAQkpT8ATFP1M4SdhyGLcLO78
	zAKO2BMMZa/wiJcEYtHnICcn4an1MNtrKBovM
X-Google-Smtp-Source: AGHT+IE8n5yLzMt4PoToeLL8C5v5HHD1neima1v8XmZ17YvM9ylAhwJazzd0NWfB2mAJWUMNuNTd0FEwSjyHV5NKrbY=
X-Received: by 2002:a17:907:1c26:b0:a77:ca3b:996c with SMTP id
 a640c23a62f3a-a8a430b4a6amr371424066b.16.1725494267571; Wed, 04 Sep 2024
 16:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612124750.2220726-2-usamaarif642@gmail.com>
 <20240904055522.2376-1-21cnbao@gmail.com> <7a91ff31-1f56-4d0c-a4a7-a305331ba97a@gmail.com>
 <CAGsJ_4xkbOP9UCDW8sqTeXJ-=V82CEyxbz2gEr_1BUgDwzw1_g@mail.gmail.com>
In-Reply-To: <CAGsJ_4xkbOP9UCDW8sqTeXJ-=V82CEyxbz2gEr_1BUgDwzw1_g@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 4 Sep 2024 16:57:11 -0700
Message-ID: <CAJD7tkYK3ecG7cuJcxSF-cw-0K=JPnoE3L4Y=7xUp_R8apqueg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Barry Song <21cnbao@gmail.com>
Cc: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, david@redhat.com, hannes@cmpxchg.org, 
	hughd@google.com, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, shakeel.butt@linux.dev, 
	willy@infradead.org, ying.huang@intel.com, hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"

[..]
> well. i feel i have a much cheaper way to implement this, which
> can entirely iteration even in your original code:
>
> +/*
> + * Return the number of entries which are zero-filled according to
> + * swap_info_struct->zeromap. It isn't precise if the return value
> + * is 1 for nr > 1. In this case, it means entries have inconsistent
> + * zeromap.
> + */
> +static inline unsigned int swap_zeromap_entries_count(swp_entry_t
> entry, int nr)

FWIW I am not really a fan of the count() function not returning an
actual count. I think an enum with three states is more appropriate
here, and renaming the function to swap_zeromap_entries_check() or
similar.

> +{
> +       struct swap_info_struct *sis = swp_swap_info(entry);
> +       unsigned long start = swp_offset(entry);
> +       unsigned long end = start + nr;
> +       unsigned long idx = 0;
> +
> +       idx = find_next_bit(sis->zeromap, end, start);
> +       if (idx == end)
> +               return 0;
> +       if (idx > start)
> +               return 1;
> +       return nr;
> +}
> +
>
>


Return-Path: <linux-kernel+bounces-435917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EF79E7E93
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 07:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1EF1886E28
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 06:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EAC7E59A;
	Sat,  7 Dec 2024 06:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yKaL4R+r"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9819D2581
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 06:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733554171; cv=none; b=TqUWrbXtYIxpo8x/KnJ3fmHLXYattYRLuQW6jmT4AJahp+SdDylFYjH+0RppRTdHFC0BllgL4x8UtLh6A7ZbRFgzvkaUgXDVh0EooeT6HVIyMg+iJt5QpVeijbl4SYDPm9Qxuortk7e+9OFCRcYRH6A+3YNv0hZQMxqyk355rFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733554171; c=relaxed/simple;
	bh=40y1sc/2XM3qemaBKf/6rCWzdLQbvf9/HrMHhV90Y/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKmqCqIuumbNrrwQW9cC/AYT3R+RsgMR9T2vHzDIcua5XCnGQJ9BfyeNDpes+O8AEkfelz0BHLu1rRRIl+lLgPPLf/bZ/v3KWZ3TWPtNz7g7RRf7012rasPMrgRp5GP9Z/tg62eJ7d8HEi6yY9+W3UDZZDF0YnQ7Uv2xE2ocVJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yKaL4R+r; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4afa525d6bdso783719137.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 22:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733554168; x=1734158968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nTfQ78QLlRnib2YldHJNBdc7qUX8VwYhMyb+NYQ1vM=;
        b=yKaL4R+rXpE8wTmTOXQsTWeexGFLsWyDCGgtbP6OoWc1VtE/rulKOqGNSe2LVl3tK/
         66NsCqc/zy3uwG2lSFkJmgM5vPdphHnhzh3JWOEyonn0KtIlHLOUQtAzx9P0SAr1z/p2
         EzX1hfdlIGnBB7hq3FUqpX81OT7anCOJ94Tw0A8WDyc75/HN+qQ3UeoJ6pBKLS6oFIyK
         FqIUmRKI72LaVNjk57RADvm2E6JrZo/BikRNHHGdNiWSRcs+UYYuX1TuQo+l1HNkJxz2
         smY7f+NACKUMd7Tzw5C84P54BpyPGxMSrW/y8jC4Y5LngJrnaXhQ2+d3vW83Rq17Kq8/
         /Snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733554168; x=1734158968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nTfQ78QLlRnib2YldHJNBdc7qUX8VwYhMyb+NYQ1vM=;
        b=omdAokWZdpxkeBc6JgQYGc71BbX/Z4r5d1mU982WxQe3TLfSBK4ov9npXkjvMugCLS
         sg2LcdQJqwLv7CZcP3XCz/X+DJSMUKJi/obmrXa5BwvT0JCukAFkaFXb0k9DcFCu+WaH
         HEuSYjsWD9XEHTy/TPfx1N5UDMEMksh37JvrvpJlY++8wxGW/g8nLkZfQwqHr+wQ/P//
         o71PAL8zz+B1uqYdFhGYjOyIt3JUnYWVkzoi3qlATjTj7VidZzrRbOVu1sl3e/Ekx6de
         ggzP1OocF6VYwa3FPlhWBRulQngs1e8SaFKlOyQ+WsTY0HZ+I/pIEB9ZzAQg5KJ4YJgm
         DlJQ==
X-Gm-Message-State: AOJu0YwktsCZ3vpM343gAY4T/x13RINrccPjf1qvKmDsT6dUW+NjdYak
	s5GsB3RdnA8woTMOop6qiSqgsotfaeRmehxl3ptFYWIYRn/V3luIL3U51Kw2EtJRRfk/glFVSUw
	BIO4/1lP0KmQw1elnKtx37YUz1kCtMHQDnpDY
X-Gm-Gg: ASbGnctW8EZ+dUIwg6ia2gsBuhUPrpM9VoZRahItX7yXH9PU0JfEs/p59bS2YjOJlk7
	D+ERTr10gXgjvnahXS0gSYog1+nXnZ+how8LEnbELpg7xGjZEjl4W9k/ibdf3tqAp
X-Google-Smtp-Source: AGHT+IEDYKQWn4RpDYL5VcZE/5orrgWkfRQYbI9Ft0YtuhnijS3UgMYLBHyoJ+B4J4AHgfzzEobWozQd+BCencQQJrU=
X-Received: by 2002:a05:6102:4408:b0:4af:c3ed:b926 with SMTP id
 ada2fe7eead31-4afcab15941mr6903850137.23.1733554168303; Fri, 06 Dec 2024
 22:49:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206095951.98007-1-david@redhat.com> <20241206095951.98007-2-david@redhat.com>
In-Reply-To: <20241206095951.98007-2-david@redhat.com>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 6 Dec 2024 23:48:51 -0700
Message-ID: <CAOUHufbYxEByFv6H8kgbrAkgzkoNb=PTY1zBO0-Mniz6ADtk3A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mm/page_alloc: conditionally split >
 pageblock_order pages in free_one_page() and move_freepages_block_isolate()
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 3:00=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> Let's special-case for the common scenarios that:
>
> (a) We are freeing pages <=3D pageblock_order
> (b) We are freeing a page <=3D MAX_PAGE_ORDER and all pageblocks match
>     (especially, no mixture of isolated and non-isolated pageblocks)
>
> When we encounter a > MAX_PAGE_ORDER page, it can only come from
> alloc_contig_range(), and we can process MAX_PAGE_ORDER chunks.
>
> When we encounter a >pageblock_order <=3D MAX_PAGE_ORDER page,
> check whether all pageblocks match, and if so (common case), don't
> split them up just for the buddy to merge them back.
>
> This makes sure that when we free MAX_PAGE_ORDER chunks to the buddy,
> for example during system startups, memory onlining, or when isolating
> consecutive pageblocks via alloc_contig_range()/memory offlining, that
> we don't unnecessarily split up what we'll immediately merge again,
> because the migratetypes match.
>
> Rename split_large_buddy() to __free_one_page_maybe_split(), to make it
> clearer what's happening, and handle in it only natural buddy orders,
> not the alloc_contig_range(__GFP_COMP) special case: handle that in
> free_one_page() only.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Yu Zhao <yuzhao@google.com>


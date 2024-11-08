Return-Path: <linux-kernel+bounces-401054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BAA9C1575
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4EC283ACD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB301C460C;
	Fri,  8 Nov 2024 04:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9mrpwdM"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977D9433AD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 04:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731040196; cv=none; b=bMg8Mm+AXIDqauo2eu2cYCIZ0I81j941U0LamqCU7kUPxBU/ZwBcFf+trwhUOKSI/nXnvNbggIuYlM5htNniQ8NOTT8drTEnDka7MgyXW09WYUtQeYjnL0f7biIpBhkctY+Qv3BjgGPv61G4cQzJcgNdPmMwS47PdeqLcQK9TS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731040196; c=relaxed/simple;
	bh=C4JVVQcVjXpm1LMyCCfLRWXtGKMXYNdlc1xRqRBeR0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKMQpXvnnYQR+iRQP73U/Xe3LMv9loHz65SFThoUfk3FG+x7+5eqg+L7e9uZ0uAZaJ3enX3z0UH44ZsNeZqzZ17uuxPT+u5WbxzQ9Fi77msxG9a70q9iPeAEWaO6C5Q0d30RfsS19r9Pa+Jn7F4pr7X9g/oiJIB5Di11uYIqfRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9mrpwdM; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-50d2d300718so716773e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 20:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731040193; x=1731644993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KhdoN9bArhTrwgpxv+larwx17yLL0HfLyrjcE6G1uA=;
        b=b9mrpwdMmhqYlFe1aueAXW/akqODgP5zKl4SqLQG3Kr5oebyic+fhL4DAu2rlnR3yu
         A9tQh0T8+noNrt9xd9J3nuD+heTT9g361E/SvDuSJWUIRyLS9XRuk4ci9Y4fsg1N/h1t
         Rd0cICljoUwc+zR0zP2+C8jDb3cTyzUtF4QthFgL1eHaNYueVnjlyMxB05Jn3Bv26onS
         CGd8oTGtzWFl56lNb56z3/9SniJPuUw7LFX0oSztfz5p0ADzMFRZQ0eJPOzsnzfjAM3L
         MoQQILqmJ0O7Aphp5F7niuHhtxf4MQiD8BTsCS+4wAr83dHxvD5vYUVhRA7GHGOgjzR5
         xBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731040193; x=1731644993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KhdoN9bArhTrwgpxv+larwx17yLL0HfLyrjcE6G1uA=;
        b=aW7ptGEKjay+NB3P8UEp3OgrWofkNutEbAVQUvJxIknIjLhH94M7IBRdi+qAh2fQOI
         0P27P7oDKeHyBtezQ1PQ8isx+/dtCR+bCCdoQbnXxSjvE2BbJtXlYQny3xMd5Zai7GxN
         jG1FUcB+mA3Uid4mWJ8FSrYU04/pZ5GtXPkYHs9dIaNLaZQ7wixLoTrg3SX/o+kdMkz6
         XCD7fujvSNpLu+tdNmS9kB2v8i3E9P0ZclYE1E16dDFn/jvrWIFSB3r457uQalsmExcu
         BoXrKXO67663kJbbssO/CLBFUXHaCL9ZP6f3MWc8Bt35ftKm4C2Ve7uPriBKDkrf4fy4
         4P3g==
X-Forwarded-Encrypted: i=1; AJvYcCWxdLKSh0kqa/b8keDLYnSWjuSVxkxuv/Sgs0hn0hOKDnsLDjPY53d2DX+pAjJV/75hyHcN4Ma1i+mvaBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqYitMpzIEwrgHdu3BvfRHBzdAh6eAn5GDJ1eQo2DVte2Ce3m5
	SibWkkhyRRSRbnprIPKts92nvxfUV9zLx00oR9NlgbaHNQiFoD/cVIa0G2JVvN2DQRF7s+tHOKa
	+AauoRsDj6q7ufHKSrtJzTTk7C/E=
X-Google-Smtp-Source: AGHT+IGJLJRDRzWDhRUpKcISWO5NIDXFY4Ph11bFYJ3wT966olIayX8mlGqQ4aSiI2ZMn+/Vnc7dWubftBhWwpiFIdw=
X-Received: by 2002:a05:6102:549e:b0:4a3:d9da:16d6 with SMTP id
 ada2fe7eead31-4aae134b977mr1890824137.3.1731040193425; Thu, 07 Nov 2024
 20:29:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731038280.git.baolin.wang@linux.alibaba.com> <d3272b090b4f6fe92457d487c7b9f825ba72c1b5.1731038280.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <d3272b090b4f6fe92457d487c7b9f825ba72c1b5.1731038280.git.baolin.wang@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 8 Nov 2024 17:29:42 +1300
Message-ID: <CAGsJ_4y86Ma=yJOVppEBCts8XZO=vxV2bxF21FD03azNFONvLA@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: factor out the order calculation into a new helper
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
	david@redhat.com, wangkefeng.wang@huawei.com, ryan.roberts@arm.com, 
	ioworker0@gmail.com, da.gomez@samsung.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 5:13=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Factor out the order calculation into a new helper, which can be reused
> by shmem in the following patch.
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  include/linux/pagemap.h | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index bcf0865a38ae..d796c8a33647 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -727,6 +727,16 @@ typedef unsigned int __bitwise fgf_t;
>
>  #define FGP_WRITEBEGIN         (FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_S=
TABLE)
>
> +static inline unsigned int filemap_get_order(size_t size)
> +{
> +       unsigned int shift =3D ilog2(size);
> +
> +       if (shift <=3D PAGE_SHIFT)
> +               return 0;
> +
> +       return shift - PAGE_SHIFT;
> +}
> +
>  /**
>   * fgf_set_order - Encode a length in the fgf_t flags.
>   * @size: The suggested size of the folio to create.
> @@ -740,11 +750,11 @@ typedef unsigned int __bitwise fgf_t;
>   */
>  static inline fgf_t fgf_set_order(size_t size)
>  {
> -       unsigned int shift =3D ilog2(size);
> +       unsigned int order =3D filemap_get_order(size);
>
> -       if (shift <=3D PAGE_SHIFT)
> +       if (!order)
>                 return 0;
> -       return (__force fgf_t)((shift - PAGE_SHIFT) << 26);
> +       return (__force fgf_t)(order << 26);
>  }
>
>  void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
> --
> 2.39.3
>


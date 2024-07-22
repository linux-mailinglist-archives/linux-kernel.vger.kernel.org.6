Return-Path: <linux-kernel+bounces-259414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AB1939599
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41ECBB21CC1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665243C684;
	Mon, 22 Jul 2024 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyOK6BbP"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9461CAB5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721684379; cv=none; b=qaKVWBt12dVOAADulSRafQiw4dxylNuaIf8S/edp9/TN7lVf2baBbAFbOuTAm7A8IH/iwdmnkDBxf3hTgWF8wDGiPJF5oMmd35qIbwKIVttOkMxufhURj3+WWB33CFqVLAzpWhC7sjn8j6HsZ7zu7GtPFfjjG5LmxMosC/7kvag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721684379; c=relaxed/simple;
	bh=L4iHiOE6Rw0xEFgs/xuJpzTT/oQYwi1GVLVCM7PqeOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9PC02h/kf8K90ypcDExVd23BMcbV3crpyydlold9vbra3/4jM0iuSFWnGsb/bic+Pa6rXlDvub+hxf4vPFRYUgDK/mtAVMxKeV/121t7vzoW7nqaJy0jIT3vDXEJE/uxgPKO6/iBl/MvVy4wuMoYSd2hPJrtB9Z98iejNRH6v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyOK6BbP; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b97097f7fdso12216346d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721684377; x=1722289177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1Jz2M2BG7Jm1AKSR4a1EacnCUYfmHPhctjNqd1nvGI=;
        b=lyOK6BbP1RhLtAO1D1yF6wseDPBnNCZ2wsA6wezkqisi/r9+RbfQzwFJCbqsE6W75y
         dqgsIEqVDquttwXVvz9fcmdpLuT/dWqNTIkjAwtpbZZfTVKWc47lj+0+USWmH33km94S
         IvkrrDD2Jcat+x2j82/wPk+jzo/1oMRFtv0Cjy3+LKQNUenNASNU0ImJak9hDgU5RW36
         iIwyOSTQhFPsxwIm1/h/regXUePASPoS4Xo3b69GSGff3onROmslzVGxkPlc1ODGgn5b
         d06Fp2h8dgBnEPfENTD9WX62hIYWGlACVZpzJb8Wc2YGdx9yR6VYL4VpBoWCrjFfCrrd
         NGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721684377; x=1722289177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1Jz2M2BG7Jm1AKSR4a1EacnCUYfmHPhctjNqd1nvGI=;
        b=IdugwyZ+e4B+Z5f1LLsx3y35LH92HVW8SPvF4vjgtt7/VxR4smYFl+Psd2CBql6dVf
         BMmwcqcYhUnn4I8ZHgWBPSyxNWDa8gPUX1y+Qtgb4Vt5VeUHI7zY5QbyqIIjSdXIhbPB
         e0bB5GgsAPQXTyp7kTWySFpjs/d/5XfFZUBG5Wxa0IAW2+QlbObvpzRlLR7htjdOkeJ7
         BeNCZaRA6nFCWDh9ztsrfR50Z/mTri06kzHq2f5Cone224dVTNIjrlYAAsuM+26eTeXh
         puABjKqxYI8CsVKlsb6olxw6NAQ5i4EtPNOyGC3wY9oQVPx1v3pKjGSoT1smKQk1nbnN
         rQ4w==
X-Forwarded-Encrypted: i=1; AJvYcCVfi9aekAaMgy9ZEIhmSoCoHdZSOlVj4d4MoQUIixyetkgoRXoSLTTBxcoVsnqRKBhi50TU5P14UpBUwPDiMABF14RMMifZfQxA0lmx
X-Gm-Message-State: AOJu0Yx5yOZkfXhHieiZxbE7gu4J7jXn5GtrOstMqafhgxlVew+YqDPF
	YCSobM5V6V3JvneC8Bk//N8C8ioxkxBY2/cyQQiTXXWIofGFUlTukZ0RJ+qlxaUBYisBNXCrqhk
	4TuZVYjaBPk2Bw8zWy+3IchQfI2U=
X-Google-Smtp-Source: AGHT+IGbo31K+2oCMqlDUudtu4Lczyb0s1wh7dXqQFTh9uKWZW3oHVI/YP68W23DkQ9mI7o10wJoVxvWQ6aui+4iieQ=
X-Received: by 2002:a05:6214:767:b0:6b7:a32a:2eeb with SMTP id
 6a1803df08f44-6b94f12865bmr126918626d6.23.1721684376854; Mon, 22 Jul 2024
 14:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720044127.508042-1-flintglass@gmail.com> <20240720044127.508042-2-flintglass@gmail.com>
In-Reply-To: <20240720044127.508042-2-flintglass@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 22 Jul 2024 14:39:23 -0700
Message-ID: <CAKEwX=NGu_MM3bzT9eXAAJhvCvv+x4Qvf77=_RFD-M7zxKFriA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: zswap: fix global shrinker memcg iteration
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 9:41=E2=80=AFPM Takero Funaki <flintglass@gmail.com=
> wrote:
>
> This patch fixes an issue where the zswap global shrinker stopped
> iterating through the memcg tree.
>
> The problem was that shrink_worker() would stop iterating when a memcg
> was being offlined and restart from the tree root.  Now, it properly
> handles the offline memcg and continues shrinking with the next memcg.
>
> To avoid holding refcount of offline memcg encountered during the memcg
> tree walking, shrink_worker() must continue iterating to release the
> offline memcg to ensure the next memcg stored in the cursor is online.
>
> The offline memcg cleaner has also been changed to avoid the same issue.
> When the next memcg of the offlined memcg is also offline, the refcount
> stored in the iteration cursor was held until the next shrink_worker()
> run. The cleaner must release the offline memcg recursively.
>
> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> Signed-off-by: Takero Funaki <flintglass@gmail.com>
Hmm LGTM for the most part - a couple nits
[...]
> +                       zswap_next_shrink =3D mem_cgroup_iter(NULL,
> +                                       zswap_next_shrink, NULL);
nit: this can fit in a single line right? Looks like it's exactly 80 charac=
ters.
[...]
> +                       zswap_next_shrink =3D mem_cgroup_iter(NULL,
> +                                               zswap_next_shrink, NULL);
Same with this.
[...]
> +               /*
> +                * We verified the memcg is online and got an extra memcg
> +                * reference.  Our memcg might be offlined concurrently b=
ut the
> +                * respective offline cleaner must be waiting for our loc=
k.
> +                */
>                 spin_unlock(&zswap_shrink_lock);
nit: can we remove this spin_unlock() call + the one within the `if
(!memcg)` block, and just do it unconditionally outside of if
(!memcg)? Looks like we are unlocking regardless of whether memcg is
null or not.

memcg is a local variable, not protected by zswap_shrink_lock, so this
should be fine right?

Otherwise:
Reviewed-by: Nhat Pham <nphamcs@gmail.com>


Return-Path: <linux-kernel+bounces-576147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33412A70BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD07188C09C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D32F265CDF;
	Tue, 25 Mar 2025 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pzNkkNaD"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F131AE876
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742934994; cv=none; b=csGWxnVNeTQrd9nuymmoiW/7MwsY1QOclxUq26B79uXOof2d+nVpnphywzMhr5kqPuTnqhTGGw25DZ342r3+Ko6AT6UXaoMQnkPORd8Suzdg3eucTv5+V3fcnt6ZqvV5l2qQ2Lqv95hRpcuITST8tpwMVw7/h2ncno0DHQoCQB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742934994; c=relaxed/simple;
	bh=I6fba/3YoYFkl+HOqtrwLDY2LW1/t6JXRquo5TnWLac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aA1tRPRBMMb/IWG3sVVNkmdNhthmHxcxbDX8tLQIjo4I/cg9LgBDk7Wg5O0LLFonJy+2XzXB9klixfRHsKhVWZc1inyT9dH+jJ9qQnxwcKaErmKdpPDTIN59xuRuXdBxFm64VeK5VYSYOiNd26LN7aOp0H/V2adXp6zDPcU4j8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pzNkkNaD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso923199966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742934990; x=1743539790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6fba/3YoYFkl+HOqtrwLDY2LW1/t6JXRquo5TnWLac=;
        b=pzNkkNaDV/RBNII5Eq18Twp22psAHTt2csES2C1EaLKnRjXn972/G5toDg0j4RMF/V
         PLQuExOaH3NYG69ZwN5lX4Dr4DskhNjCm6tOmzZqkSxwTw/1opCZTk/vYg9ooBDCWmn1
         jeGkjHC9xI2aj998V3NUBEOLO1jqVbYckKyBAEUkGu+KkV7+glk4tETLQlTp9DmJy/+W
         xQpyOZZqIbWjnyLl0b/8wVzNaeokQeeuo9548Fvqc9l86GUf3lLwxI2JZGdo8oB/zpeH
         TJ78c6B8jyNXgJ+0stBFYH8IsvgL7JoLmuIe3qI+RycDIiB37xl+6V16/BcFCGialya9
         8A4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742934990; x=1743539790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6fba/3YoYFkl+HOqtrwLDY2LW1/t6JXRquo5TnWLac=;
        b=kDSNEgQ8lQ+2B5fOcSsWaT9u184Tk9410VdTGsld5FQ7R4ikM8ahkwMxaPfz6AmLdW
         yxox3ZNaQKduX6qL3o9vO1tFAnmYcE+qUCh4f1SWc3otbZeKlLWmUdxyFyeqgZXSXARr
         g/WQEMA6vn1VznBEwr40qxq8UQj1c8JRqmhiK3/i1HTPDP12JPN0jh5BRDKYmZhXYLR4
         eItC4yOgFXH+duECIt5DXT4I63pBb4IGBMD4Nb7a5A6A+oOlbXBogGXZdMjAVmD/TIYL
         6Pig1U+HgSIExx9ms6QEM3CM2H8rJTvdhWSPoSvZBkI5zHPXcnR+x9E/W56eLlY/NCwq
         hbPA==
X-Forwarded-Encrypted: i=1; AJvYcCXPudgAKMCyVdor564+7xc8vQluJWmhQa6HfBKe/C0mjWXZPMJKYaufDVdNkjgA6OGCK7GNOZe1nh5bjpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3XOYTZVglj7Dvnsc5hUdA+682m+S0ZqkhwPEeouLytzUO0EJu
	Z3O8YWCP19mf9yIWrrhrvukH1zfj/WHCz/rIGq0fm3MVAPkWXQiIfTS0CPaOLj2LEwboVNYy9Oz
	LNNURMas3e538/iI0O2dW6nWRukALqUeA15kWv9Yxz4bihOMCyQ==
X-Gm-Gg: ASbGnct+HxDAjff7yK57doiLcQh7EiMWwFVhOxo3UZEON6eENMPbuok0ikVM8Ft0BWi
	HmY7zOQRncHhsmpiw4awlL3pDo1Nz3FV6NsQfYxThHc2LXnuKpLxctSfuS2r0+RGLUNRe2Gksdn
	UE+cj8PrDqk8nLR6VwG07Kzk2FmEJuxTGN5Rw7xxZSBZS3OZcVMhXSD9b1Z21gl/6aRgbhKA==
X-Google-Smtp-Source: AGHT+IGFvRQOs5e6tUN234mIXeawiwHxPK6Z4AdAsFuigZXP8TTEwbaXQLCOEb1Qg9E6FEO2+4xwzhkAdrmPe+ywrrk=
X-Received: by 2002:a17:907:c810:b0:abf:4bde:51b1 with SMTP id
 a640c23a62f3a-ac3f210b1cbmr1701123566b.21.1742934990366; Tue, 25 Mar 2025
 13:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325194920.53307-1-purvayeshi550@gmail.com>
In-Reply-To: <20250325194920.53307-1-purvayeshi550@gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 25 Mar 2025 14:35:53 -0600
X-Gm-Features: AQ5f1JrLRO0dClwYTbtpc5rcUSGdAUBn4FLBcxtBoy2i32laiGK3-8lpa7tKxP8
Message-ID: <CAOUHufaFz=G+0o5c+u9YY-4n1KExS6_tOFATY1TMyWWcrAQ8Ng@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan: Initialize dirty to prevent uninitialized use
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 1:49=E2=80=AFPM Purva Yeshi <purvayeshi550@gmail.co=
m> wrote:
>
> Fix Smatch-detected error:
> mm/vmscan.c:3509 walk_pte_range() error: uninitialized symbol 'dirty'.
> mm/vmscan.c:3522 walk_pte_range() error: uninitialized symbol 'dirty'.
> mm/vmscan.c:3600 walk_pmd_range_locked() error: uninitialized symbol 'dir=
ty'.
> mm/vmscan.c:3614 walk_pmd_range_locked() error: uninitialized symbol 'dir=
ty'.
> mm/vmscan.c:4220 lru_gen_look_around() error: uninitialized symbol 'dirty=
'.
> mm/vmscan.c:4232 lru_gen_look_around() error: uninitialized symbol 'dirty=
'.
>
> Smatch reports 'dirty' as uninitialized, leading to potential
> undefined behavior.

Thanks -- this seems like false positives from Smatch, where the
problem should be fixed.

> Explicitly initialize dirty to 0 in walk_pte_range(),
> walk_pmd_range_locked(), and lru_gen_look_around() in mm/vmscan.c
> to fix Smatch error.
>
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>


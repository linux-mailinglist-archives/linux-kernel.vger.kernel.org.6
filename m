Return-Path: <linux-kernel+bounces-407099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA3B9C68C7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2DFEB22494
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 05:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2451714BD;
	Wed, 13 Nov 2024 05:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OD8B+cIZ"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702A413C90A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 05:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731476125; cv=none; b=LSSS8Hyj13TTvwj1Im2bWcgBpqoISII9aWY2IwIEAYjAciN7Fso2t1LdJ/9p1slx/NDg2nCMHzZrJNEn5Qxw8GU5AOJ2eS/5qMoK9Xjsq8WpgbdYCKVqVx3S5hZQqyFOueSLaWi5TpLarmf/IcAg0yCrYhuLMJPd0u7UsP2tSjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731476125; c=relaxed/simple;
	bh=IIv7PbRmh/BkVKDHbBE5bsjqLbat8ymgFx7jrw9iHe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfEwL/5Hi4ObxnAXh08JE/Jc+Zrog9wtkEFw+frnyJZ7QRHMfiMEdmrlNFb/lHuWeWDtsLJA4oROuwKkJRtSdX8h30a3k56Q0Vs3Vj6MG6QoG/oWhOlf5mkIXe0zGvWBQ5sDW00nlc9o49QKb1CeznsFMcFVh9xDgp72vnGF4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OD8B+cIZ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cbce8d830dso44893126d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 21:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731476122; x=1732080922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyPT0/YbDuXqIj/AzCTZh1WZxLR8mJzfYf8jckGMcP8=;
        b=OD8B+cIZVcT1zzq0OWdi5slnbZysxDz6ZchrdvCUMxman5bvMRBCzfJoKFEOKyyWLY
         Y+pk9D+PuXnr7F96sh8xit0RBPBs0MGbHk3gQ/dH5L5kWFItOD60V4778VuyR77PrLKd
         l4RJ+un91ssJT20efbjLsb8gBZrSjwVyKLtR3hRCCTJ23GWXLnPcODTB1IdXI8OOBGXT
         skxvoGt0IH2BHyrbZ89fXW6cxGaF9xZ45iRxuWu+fdNy0Tj8M4PKTCyHmcENfH1D176x
         DlXZt4udWbTJ0wYZ8SNeS+YywZTV0ZroUsVuGFv415XhzJwCNtnFBnco2JbAK0UtQ8ME
         hhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731476122; x=1732080922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyPT0/YbDuXqIj/AzCTZh1WZxLR8mJzfYf8jckGMcP8=;
        b=aanytWDigIOFu6mx4u2XCQqg4nVm24S1lKXWWRPX8y1MKxwW40Z8X4bAPY/OR2sGb3
         mezJBeLFL4RD8wgQlLOxQvQQuehiXprGqahUtijYD6HoKMhWUXnDeCCJ+iZu8gPT8cyi
         7j9nzNTl9TVMe6eby8WBYaXTzNSaaveFwRFfZ7zbS+G/AFJMrglhPQHJGWnOwVkSok1Z
         RhyE+nvYr5zNsuHhZnNvnex1cWo4B0ACQqVkdVfdDw3dhT979cEyLfBf782u0bsNAPJr
         T5daYZk9AuJUoRXYcKGIdjo4+42Uf7GkQuISVitcxHuXCoskEC482sGQCVC/pcyi1/tS
         MGoA==
X-Gm-Message-State: AOJu0Yxcyx6UhkfL/DlQt4bzAIGjOCWoXW+ljUjzfGe9xyZTa2shXHmx
	wv2fsLpnGXFfmdxX7hSB3gWAMyc+97HI2t5rxfgJRNECy2DQIOKaPvspRru8QRQKYJYm9Xeq4PT
	e5uCaPHNqp0sFyjlIVrZt3lt2vNKdJoI6L0ye
X-Google-Smtp-Source: AGHT+IGhDDWZiVRqU950S4Da0ArH/jG0Mi1RbYzsgL032N+wWEohldfNeDLZLRcsR9GRL+0QGbjgoCmvn4JroJ1AVBo=
X-Received: by 2002:a05:6214:4291:b0:6d1:87be:96d9 with SMTP id
 6a1803df08f44-6d39e1bae22mr261120866d6.46.1731476121984; Tue, 12 Nov 2024
 21:35:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
In-Reply-To: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 12 Nov 2024 21:34:45 -0800
Message-ID: <CAJD7tkZWDhOXyyZnEYFiS7F4tSV+z6TYXUYiEcrZrRuy_3R=ZA@mail.gmail.com>
Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in zswap_decompress().
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com, 
	akpm@linux-foundation.org, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 9:24=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> This is a hotfix for a potential zpool memory leak that could result in
> the existing zswap_decompress():
>
>         mutex_unlock(&acomp_ctx->mutex);
>
>         if (src !=3D acomp_ctx->buffer)
>                 zpool_unmap_handle(zpool, entry->handle);
>
> Releasing the lock before the conditional does not protect the integrity =
of
> "src", which is set earlier under the acomp_ctx mutex lock. This poses a
> risk for the conditional behaving as intended, and consequently not
> unmapping the zpool handle, which could cause a zswap zpool memory leak.
>
> This patch moves the mutex_unlock() to occur after the conditional and
> subsequent zpool_unmap_handle(). This ensures that the value of "src"
> obtained earlier, with the mutex locked, does not change.

The commit log is too complicated and incorrect. It is talking about
the stability of 'src', but that's a local variable on the stack
anyway. It doesn't need protection.

The problem is 'acomp_ctx->buffer' being reused and changed after the
mutex is released. Leading to the check not being reliable. Please
simplify this.

>
> Even though an actual memory leak was not observed, this fix seems like a
> cleaner implementation.
>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> Fixes: 9c500835f279 ("mm: zswap: fix kernel BUG in sg_init_one")
> ---
>  mm/zswap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index f6316b66fb23..58810fa8ff23 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -986,10 +986,11 @@ static void zswap_decompress(struct zswap_entry *en=
try, struct folio *folio)
>         acomp_request_set_params(acomp_ctx->req, &input, &output, entry->=
length, PAGE_SIZE);
>         BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &=
acomp_ctx->wait));
>         BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
> -       mutex_unlock(&acomp_ctx->mutex);
>
>         if (src !=3D acomp_ctx->buffer)
>                 zpool_unmap_handle(zpool, entry->handle);

Actually now that I think more about it, I think this check isn't
entirely safe, even under the lock. Is it possible that
'acomp_ctx->buffer' just happens to be equal to 'src' from a previous
decompression at the same handle? In this case, we will also
mistakenly skip the unmap.

It would be more reliable to set a boolean variable if we copy to
acomp_ctx->buffer and do the unmap, and check that flag here to check
if the unmap was done or not.

> +
> +       mutex_unlock(&acomp_ctx->mutex);
>  }
>
>  /*********************************
>
> base-commit: 0e5bdedb39ded767bff4c6184225578595cee98c
> --
> 2.27.0
>


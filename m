Return-Path: <linux-kernel+bounces-532638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3309A45022
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BDE1189A36A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B78421422A;
	Tue, 25 Feb 2025 22:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jd9yjKfX"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A89718C32C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522514; cv=none; b=Bq6fzVXVGbvnIDDt8Odb8j3ZrmhkWBQ3NY1yPxahKMLcJ/r3Pce8zC9pigFdCE5UxronkDy9sEzHp5kRwzJencNMrb6WPN7ZZTUemiydqlwkIyDauTwmRNp1NWxXJNaIhfHHERuKWd9VNGUvT0op5etxsvIv5X+xKA0yUyT+pMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522514; c=relaxed/simple;
	bh=HJj0Yz5Lll+CiPhh7qmf+hpU1aku+LfYtxgi3IkOjCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVG3yalfiNq5MlIhVoXUWcOiPhCn4b+4vnULzrSNNOQw7DEterMIjav2xEJ/gglvT05mDbyWiMx9Q+Ysxo5xFfwXCrF0o2kRGYL4m3HJq/x2qM2CuODXqbPH1ZdKqFhfVfDKWmVqMDHsUkBsEG985M1/ETKgtd6TV7Kt3EwyMUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jd9yjKfX; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e67ce516efso49107956d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740522512; x=1741127312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/vvYkyp7Hb/QOidIce1lg6CZDEUavwEmPlWHS0qFxI=;
        b=Jd9yjKfXAToczzHo4+c+1PHLDwqaGubXipmY/cUkUVsKvQN9vgePb/ifKC0kAk8ekX
         0iF4ttMRl9y6G41gHzz1X7Bfq5CfR9lTFGjC5jK9AWDDm1exNLq1zwFraNmoc9gRUAtP
         28hQyinnRyECTBYNbeY48qmNck07MPg88BIHrnDwUXabutGEiOIN1OVRI9SgH73nRex4
         UOftmgFDRltEqv3sRkjr30kkS0oMCCY1HyG1BIgJ1bmaC5CBO1n+xvtcyB0EzJytmdox
         r+zxS2YpT6BFnX6Fv3ks5z2fOMEHcogFyfjTR8aytHzzIUKiDp8w6StVQpvVld8fbWHc
         2ylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740522512; x=1741127312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/vvYkyp7Hb/QOidIce1lg6CZDEUavwEmPlWHS0qFxI=;
        b=UzTloqGZZAlMATKrY4aQId0bxdkmtrPFuo3NFpj8YneDCZVBZ7C9PZgE8uHT9a8RDN
         cL6l5eOt6zIbso5wwilxvMeDLP7u4WRo2mXiHtKyAB0/L+06A/2E/vYtv6C7AigzKNeX
         bdTUYfoZkCDJZEH7Y1HAmlYT8OsGqp/P2wCiLgNdKdrhGWyxx1xWQc0XyaccZzB1M+UT
         J8zrYxuUdqVhRys3rpL5/X+J1BLCh/HwHq69Y1PfKpfo6jlE6BNzY/jyeBUvIcj/hztm
         WPKz9zxRTqwH+IQHFjE29c0EMM2LMzvEgHFoLeVZUbG8v0yc/I1YTWD38UuEeCP9bp7u
         y+tQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8fYMn2TW7z429tdXSOweo56RkdQyGsL42zKhjatLSIbGNWX9B6iXZ4HBBGdkZs1+zGg1hz5Jy1UCjNvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9HGqy3+XC7ceGQVXtQK1KrJPr53kke8HGPq+bsnQ7UVPJIT3T
	jYTf1G/6KrDoFNMN1ggGTbbzn1JqCmg02KbNtt7ufePhmQ5DvhNBYy2uGQ6lNIrJl6aMOlGV89m
	/Dd9T+S6sT5In0XkCXdfvDt27kFs=
X-Gm-Gg: ASbGncs7cL2cZ72AWtzXKIoqks0KGES/BucrrPFd0g3r5JqMvqXi+QzjE8XorDrI6N0
	4ehZtw2ahZa34SZ3orOLG9dwHXtognH+83y7nSXEVl4lYVgEa6WAjaNTe1tdPr2ynCfXcV2aCAW
	WZjE3iqBAP5gnymIAZt67DocuvLu9pOers9VRgou0=
X-Google-Smtp-Source: AGHT+IHz/Af49tTQvF2gXpTHPb6xQHIyiSN8wd7gJXeCwTVtHe0hucq8LVTvxWzrwI0Pz8Ltsf7x4kEfoV2c7SKEQ0A=
X-Received: by 2002:a05:6214:484:b0:6e6:5d9a:9db4 with SMTP id
 6a1803df08f44-6e886901dcamr16015806d6.41.1740522512399; Tue, 25 Feb 2025
 14:28:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225213200.729056-1-nphamcs@gmail.com> <20250225142518.cec35a0ea77a0d86f3e860c3@linux-foundation.org>
In-Reply-To: <20250225142518.cec35a0ea77a0d86f3e860c3@linux-foundation.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 25 Feb 2025 14:28:20 -0800
X-Gm-Features: AQ5f1JoxxuL2tZkp3XCjgAMe7HNqcE0g1hHNvRdYOmpLmlRy-y9P30uIFJX2xeI
Message-ID: <CAKEwX=MuKwhnooRO4pHH_UqGStMdH5RHbxnYJtYmqLhBBE0StA@mail.gmail.com>
Subject: Re: [PATCH] zswap: do not crash the kernel on decompression failure
To: Andrew Morton <akpm@linux-foundation.org>
Cc: hannes@cmpxchg.org, yosryahmed@google.com, chengming.zhou@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 2:25=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 25 Feb 2025 13:32:00 -0800 Nhat Pham <nphamcs@gmail.com> wrote:
>
> > @@ -984,12 +987,19 @@ static void zswap_decompress(struct zswap_entry *=
entry, struct folio *folio)
> >       sg_init_table(&output, 1);
> >       sg_set_folio(&output, folio, PAGE_SIZE, 0);
> >       acomp_request_set_params(acomp_ctx->req, &input, &output, entry->=
length, PAGE_SIZE);
> > -     BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &=
acomp_ctx->wait));
> > -     BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
> > +     if (crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &aco=
mp_ctx->wait) ||
> > +                     acomp_ctx->req->dlen !=3D PAGE_SIZE) {
> > +             ret =3D false;
> > +             zswap_reject_decompress_fail++;
> > +             pr_alert_ratelimited(
> > +                     "decompression failed on zswap entry with offset =
%08lx\n",
> > +                     entry->swpentry.val);
> > +     }
> >       mutex_unlock(&acomp_ctx->mutex);
>
> This mutex_unlock() isn't present in current kernels.  I'd normally just =
fix
> the reject but a change in the locking environment needs some careful
> checking and retesting, please.

Hah strange. I could have sworn I pulled the latest mm-unstable, but
maybe the git pull failed and I didn't notice. Thanks for picking this
up Andrew! Lemme re-pull and rebase.


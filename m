Return-Path: <linux-kernel+bounces-339233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1EC986221
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87845B36DA9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBAA175D2F;
	Wed, 25 Sep 2024 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C97AtYnc"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6A31537AC
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274313; cv=none; b=UX+TSus22znSm+EHfShurv943V44npdT2A9N2cxR01qoPRfRefC0ECNDeRrlXNt//e73wC2HPIuWp09WJO5S7lPyfK5aBzth62OTHUbgLgfxOjofLHVo/nevT/4tU9u/uC+B5b7looFxDUcQL0SpLtRctGc5RT8niL/vsLwJxRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274313; c=relaxed/simple;
	bh=n00m11QQSfQ6NwbwsJxtlv32VdLsA/YagcRFhB1hDJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANZocejuJGeSveU74RYVrRf3HugkTPIuYvO10p3CZ2Ci6vkRzpUpDAzQhhepWdaLS35oEje6UCSUVvM9V98PO7bV7jWI5Ja3aD0+LCuqiy4S1+jj16WQlay1T/tf4TdQFGWRbXYYMJnsT2RfYRq0kWxnfv/sjLn8iZwHgF56/g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C97AtYnc; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6c351809a80so48365806d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727274310; x=1727879110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKHSbKmh/OWvf7D+QnPJyajvAk99sQW7fmf5zk+OZak=;
        b=C97AtYnccws9SqCqVTgfmYlnUW7xo3RbvGCivrjHADwyjKqG/YtzSn9h46ZKhAGCG/
         lIac4wFfju+kHU3DDp2ySkayjCtALQ+bahqmv5Qiba0H5jcsnrrITrnARQfmOm98Bmhz
         1JNAPrvhD9kLJFVHpFVwAIsFEHyTnfKK++gwVGjF8ggW43kCyE4aaloDbFiUWsbJSi6w
         aCJTTrKZc6UeA56fNm2e5yOMGTmTWvkg1DKWoUiu7nR8PZglTpLKqIu/LLVL4pqSMw32
         tXw4v8ncYv1U6S1fNnuBTt6jeNZiP39jZ3xU4RBY9v33Z25ZozRj6SuvKXlpJ5yYQson
         o1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727274310; x=1727879110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKHSbKmh/OWvf7D+QnPJyajvAk99sQW7fmf5zk+OZak=;
        b=SdaRLGzbL/ujKtl2uqVI1dOR8t2oGIIZIEM999/yUaXkr00PNythUXgf8tCQE5KjpE
         /i1Pxkwka5XQ4Gs1dbjnvD1ecvEfRkKNIQXFd86fqmiwpVpCF7LbuC0/inP+kHkl/qkf
         k/O2oQXAT+Z4SfrEJnGDAxPTWM/J8XGkD//6pflt/RGAEwWm2zxCrPH95Sg/o5yWSi7z
         aKnKMzZrLemXfgIaKO3ef9z/xbWZRQ6ANz1Md+lQVtrOQ/LOn6H9YcPV8j1EA0aIMOQ7
         vwmf+SsxOzcbZcusVhIuG0PbnklIw9zJq7aBYqN3OpvNnCvgb97e8ErCcvk93SMCPHER
         WtjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMnGdq/R4M5SZlQiGAph2QFiZJkLT2EQ18C2IfI7KnE2ffK+tZnQ6zTlWKk7oOLTvSkqXovQKqlpSJWmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi0/irsJPNjerQREQkC2bD+8JOe8biPSNk8wApIqvDOzChjHYd
	mMXSf/WkvxdJToKWwXn6dbH4FjQamMeSTnAm7caCDfsFxz3YMDBbSGqbF4fJDDvpikLz4aFdNwo
	7A1bItNts8+Cq9BDC/Zub0oFigHk=
X-Google-Smtp-Source: AGHT+IFLa0kzxCW1URmiLzO2BzTPqeUkWkh3YRKUbIonFy99BzaY1ai262Y2O72SZlbEfK/b6Tcu6tImrSFgVdwX1Jg=
X-Received: by 2002:a05:6214:469b:b0:6c7:c645:e0d3 with SMTP id
 6a1803df08f44-6cb1de0b169mr43734736d6.49.1727274310268; Wed, 25 Sep 2024
 07:25:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923231142.4155415-1-nphamcs@gmail.com> <4d38c65d-760c-43a5-bb47-8e0235c13a51@linux.alibaba.com>
 <CAJD7tkamKcaqHR5V+4+9ixmFc3dC2NnGcu7YzdXqxqNEe8FqqA@mail.gmail.com>
 <9a110f20-42ad-468b-96c6-683e162452a9@linux.alibaba.com> <CAKEwX=PiOdrR7Ad5XoT8pRZDLB=q6B_fmwQ3ScgWFPNptBuHPw@mail.gmail.com>
 <CAJD7tkZFu3DbovTwyRdQmEG=7nQtmzrjQVgyhE4mNzbCtZxFZA@mail.gmail.com>
 <CAKEwX=ML4+iW+WkyjezaqipZU=N=DeB561M4XzOqQMD6drk9dA@mail.gmail.com>
 <87o74cryhu.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4yckKO29b-BtTHazJEcf58R4JaUkTYZbhNDByLecqJGGQ@mail.gmail.com>
 <CAKEwX=NuRuu9qXA9mRMqb6Okcwa86mEkp2Ac8sQjwb0ACdS7YQ@mail.gmail.com>
In-Reply-To: <CAKEwX=NuRuu9qXA9mRMqb6Okcwa86mEkp2Ac8sQjwb0ACdS7YQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 25 Sep 2024 07:24:59 -0700
Message-ID: <CAKEwX=NWJ43LW-N-qLWnWz-wM65_2Ti-UUQe96PC8LDX9VxF+A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
To: Barry Song <baohua@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, hughd@google.com, shakeel.butt@linux.dev, 
	ryan.roberts@arm.com, chrisl@kernel.org, david@redhat.com, kasong@tencent.com, 
	willy@infradead.org, viro@zeniv.linux.org.uk, chengming.zhou@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 7:21=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
>
> I'm only supporting the case nr > 1, when there is no need to add swap
> continuations :) That's the only current use case right now (shmem) :)

Sorry, I forgot to say - but to fully support a batched variant, we
can do something like this:

>
> 1. Keep the non-batched variant:
>
> int swap_duplicate(swp_entry_t entry)
> {
>     int err =3D 0;
>
>     while (!err && __swap_duplicate(entry, 1, 1) =3D=3D -ENOMEM)
>         err =3D add_swap_count_continuation(entry, GFP_ATOMIC);
>     return err;
> }
>
> 2. Implement the batched variant:
>
> int swap_duplicate_nr(swp_entry_t entry, int nr)
> {
>     swp_entry_t cur_entry;
>     int i, err;
>
>     if (nr =3D=3D 1)
>         return swap_duplicate(entry);
>
>     err =3D __swap_duplicate(entry, 1, nr);
>     if (err =3D=3D -ENOMEM) {
>         /* fallback to non-batched version */
>         for (i =3D 0; i < nr; i++) {
>             cur_entry =3D (swp_entry_t){entry.val + i};
>             if (swap_duplicate(cur_entry)) {
>                 /* rollback */
>                 while (--i >=3D 0) {
>                      cur_entry =3D (swp_entry_t){entry.val + i};
>                      swap_free(cur_entry);
>                 }
missing a "return err;" here. Not my best idea to write (pseudo) code
before caffeine in the morning :)
>             }
>         }
>     }
>    return err;
> }
>
> How does this look? My concern is that there is not really a use for
> the fallback logic. Basically dead code.
>
> I can keep it in if you guys have a use for it soon, but otherwise I
> lean towards just adding a WARN etc. there, or return -ENOMEM, and
> WARN at shmem's callsite (because it cannot get -ENOMEM).


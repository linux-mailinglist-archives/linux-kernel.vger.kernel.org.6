Return-Path: <linux-kernel+bounces-213855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B768E907BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1A41F23B98
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AF314B95C;
	Thu, 13 Jun 2024 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Msq8uo7L"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635DA130AC8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718304207; cv=none; b=rVASZEOVzWmsQQQ1FL1LUCqfbkGZk2AApqyDy0BvBToGuHKFsYq4i24jwTwSAzegwBEksvE8oXd9LXicwcZHIi5KwiKmMg3j1jYKU+Sg5NpSR1DDqX/ZvpBvY4AcgLCAwLMjXo1GNdD5iC6s31NYkpAeU6RcHu1IUNEd2qOz8rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718304207; c=relaxed/simple;
	bh=r5DiRvR5pZWBaw2R0JM4QcTuV5NNPDsViKSFsSYOZVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Icw8h9lUenrwF3clNUzhFscFztdIQnz9oTiLTaY7Kr8XTsKX8HMFimIZQCh2E2wXz8bw0aPqH71fOxNPXN4lOmkUhuLRXLSPnPytduKOIbrSMt2IPXNwRkQ71LPp3PHHCEhWzTZqufHpxYEfQ7H2wd+StgA1Jt9HekzUpeWMOC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Msq8uo7L; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f1da33826so212985666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718304203; x=1718909003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J6MehwvGkTLXwJwX8TygZIo4GI9E/mz52rreRcv1Jb8=;
        b=Msq8uo7LISNoM1/Vov6e0Ydgzrnwvd91aqmtZs2HWaq3ZeI52W1KJCrMdh46IZgK/B
         l1Vh+QhFn9mUk2sg2rex8hvA2E31qYpZ92MeI+uPqiP04AJSGuUYPczQ0c2EmLW202i6
         DhqSlzuMiLsbS78yuh3vnbh2OQQ3ZR/jwZ5tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718304203; x=1718909003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6MehwvGkTLXwJwX8TygZIo4GI9E/mz52rreRcv1Jb8=;
        b=WUiBDAnchYf6aHOz6offKj0CRx9BLmmRs1tXrx0FoPGMpIoyQdRXsGFjJjeySdaOv2
         f0NKoIloS+uzGrIv0iVElqK0oWkuJifEuiKEMKMzDD6+WP10rI+sQ96Ey8VLb6a778/8
         oFeSJUM/ZlgjySbVdxB37GtkygHr2cNdA4YJq9eUeOPrKxAblvzoVkZt2XWWkqnSZ8HO
         NEpmLlk374F/bDbqKu+Alylq0YYQWl6iv+d5fZ4aD11OupEqPc/Zmv6xLQTNre12HEsp
         8vpmhsYR2iyXp6jWboKSKyVgEZ8rtj00KLqI+ofrQnYrTOG91jRqgW7ZmCKG+p8qqUUB
         R53Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQ+agtgBBIXAU8anoGvP+veC3J74zncVLWhEUlCT5BLXEtqmzHyn0/DDp7sbH8ZSX3MFpPK/v6ISEetx5sRc7iAubJo2tzBWTibB+j
X-Gm-Message-State: AOJu0YzLRKLZnGCXgwyudf+5wXlvABCiievWJlQiJT7N4Yf/Od4NnOq/
	2eGqyfvtN51MOSJUOG3uwxiKKc+wdTcU1w6Q5qbHmHDzC8Hh3DYrZ2nqco2tfVUMcjE9XdJW6b6
	YCeqQmQ==
X-Google-Smtp-Source: AGHT+IFP3+w7AfRDLW30n06egr0vbGeQflaQA9cwtwhZ4kxg7qj+jyT4JRO4fbjNjuVBxL39MYh6jA==
X-Received: by 2002:a17:906:a0c:b0:a6f:d57:aedc with SMTP id a640c23a62f3a-a6f60dc50eamr47258966b.57.1718304203374;
        Thu, 13 Jun 2024 11:43:23 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecdd2asm101043666b.141.2024.06.13.11.43.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 11:43:22 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6f253a06caso179018266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:43:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV02glOXx77xTpV25kJZHBi0XDy1yUhfbQUJqoMGxVPu4UJ7j02EAiEPGhRll+9sXAiWvWNo9cqVw3tV42GZhiZmhZAW8dPVjkd/HDR
X-Received: by 2002:a17:906:b182:b0:a6f:4c90:7958 with SMTP id
 a640c23a62f3a-a6f60d13a7amr46483766b.12.1718304202217; Thu, 13 Jun 2024
 11:43:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613001215.648829-1-mjguzik@gmail.com> <20240613001215.648829-2-mjguzik@gmail.com>
 <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
 <CAHk-=wgPgGwPexW_ffc97Z8O23J=G=3kcV-dGFBKbLJR-6TWpQ@mail.gmail.com>
 <5cixyyivolodhsru23y5gf5f6w6ov2zs5rbkxleljeu6qvc4gu@ivawdfkvus3p>
 <20240613-pumpen-durst-fdc20c301a08@brauner> <CAHk-=wj0cmLKJZipHy-OcwKADygUgd19yU1rmBaB6X3Wb5jU3Q@mail.gmail.com>
 <CAGudoHHWL_CftUXyeZNU96qHsi5DT_OTL5ZLOWoCGiB45HvzVA@mail.gmail.com>
In-Reply-To: <CAGudoHHWL_CftUXyeZNU96qHsi5DT_OTL5ZLOWoCGiB45HvzVA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Jun 2024 11:43:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4xCJKiCRzmDDpva+VhsrBuZfawGFb9vY6QXV2-_bELw@mail.gmail.com>
Message-ID: <CAHk-=wi4xCJKiCRzmDDpva+VhsrBuZfawGFb9vY6QXV2-_bELw@mail.gmail.com>
Subject: Re: [PATCH 1/2] lockref: speculatively spin waiting for the lock to
 be released
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 11:13, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I would assume the rule is pretty much well known and instead an
> indicator where is what (as added in my comments) would be welcome.

Oh, the rule is well-known, but I think what is worth pointing out is
the different classes of fields, and the name[] field in particular.

This ordering was last really updated back in 2011, by commit
44a7d7a878c9 ("fs: cache optimise dentry and inode for rcu-walk"). And
it was actually somewhat intentional at the time. Quoting from that
commit:

    We also fit in 8 bytes of inline name in the first 64 bytes, so for short
    names, only 64 bytes needs to be touched to perform the lookup. We should
    get rid of the hash->prev pointer from the first 64 bytes, and fit 16 bytes
    of name in there, which will take care of 81% rather than 32% of the kernel
    tree.

but what has actually really changed - and that I didn't even realize
until I now did a 'pahole' on it, was that this was all COMPLETELY
broken by

       seqcount_spinlock_t        d_seq;

because seqcount_spinlock_t has been entirely broken and went from
being 4 bytes back when, to now being 64 bytes.

Crazy crazy.

How did that happen?

               Linus


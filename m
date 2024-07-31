Return-Path: <linux-kernel+bounces-268976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C4E942BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553431F216FE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4721AC437;
	Wed, 31 Jul 2024 10:18:55 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4315253370;
	Wed, 31 Jul 2024 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421135; cv=none; b=WNzT2tMOHJKTE43qDB5+e9IfqYe/6+XGJxsG59v9uuFtXXVgv2zhWbPm4rlw6pjTAurLa0agZIsWX3IU04zCS3rCA5GCo8V2e93CKsKZHP3JoptemdumsZER0MPTdVLAQ68SniDMLZGqivwPgVXUklUyRYMXXO5wP1ddiBNkR88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421135; c=relaxed/simple;
	bh=EkOTvOnnll8O5y05XMa80C3KVe4Fh7qBLRV4CFzAfw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=liEbt2DrLu38odcEcIRMdJMKRQFrLxfdDqZn0Bgkh0qFvCo3hwi3kequ9WBVXBLngjXVkLYXy/tO32fSc4yagYmsRxyOC2FdWSmGAYymxzg7419UK00oHSGvz5+PvcQc7BYDqbXp66+FuL+j8DKgGnAP9VBGmaizTGjyZqbgAB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7d2a9a23d9so640448166b.3;
        Wed, 31 Jul 2024 03:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722421131; x=1723025931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnL6/nj6QvP3RhHvWpZGJriP7Wb5iQwYQPBn96pxO+E=;
        b=gHaIwtxIHC0tFa5OVYDxcJm7+cDpYLYWP1F0rLGH3Wy0BWZtDJe/XEVYGwIalO8awR
         sNVS9m1GaGCrUyZrWPb+JZ+LT0pTESm4LsJmwGwbGvAtSgYNfcQY8nVWoZ6WZyMhFPD6
         CFlre1abQF2/KuNbRrwxrX7w17sA86jjA4it1JX4O9yvOdAAiEhMQ35dCBLiQedz4cvV
         rf2/Skvu/rii1IICuTUuIG4VgsWriyzSi/31ssRgsEyems6BjRmZlNpXBwoMbf6rDSw4
         43caSmkdK1JNa7YZ+yW1ka0ibv/MMEF135a4A4TTXisOKoTAGV/jlNcMP+oJWg/LWHXR
         FN7A==
X-Forwarded-Encrypted: i=1; AJvYcCU/qnQ3jSwII8MzNXY8Tci7Msk33B4NX6WTCzOdcP1YS1Ai0ehz2U+ga59/vupMwXlTKM3dUBgA8LKe5EA6utvvSz4jT7rBljyliJei
X-Gm-Message-State: AOJu0YwmIzDGzvfPTZBpTmK8s22+/E6WmKo1VujmCcDc7NeEDaPsX53y
	7u7pZTIkUUnzR8CaLhCxTek0J0uP5MXBxXHzeFM51axPRe+IjRpTV1nlXStI
X-Google-Smtp-Source: AGHT+IExUMYqCAzqeBA5y1yGW0GTeMVjHnKgtQdXD66W/TK96xUIXuV51zFr1ffPAke5Q2QzBaArrg==
X-Received: by 2002:a17:907:9403:b0:a72:5470:1d6a with SMTP id a640c23a62f3a-a7d400cdbabmr1069164366b.35.1722421130787;
        Wed, 31 Jul 2024 03:18:50 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4dec6sm750087266b.61.2024.07.31.03.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 03:18:50 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-59589a9be92so8280071a12.2;
        Wed, 31 Jul 2024 03:18:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIkjJUmXR2g1G3s0i3L791qX3PM1aCAX53p5V9J/pHkA8/oy4tXgT0WjgmMDdaANONcuaiA/9CA7L/Sy7YtQ+wz2oGxeLYBRSJSGPo
X-Received: by 2002:a50:8e52:0:b0:5a1:bac7:f98a with SMTP id
 4fb4d7f45d1cf-5b020bc1395mr7347967a12.17.1722421130376; Wed, 31 Jul 2024
 03:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731032030.2847151-1-neal@gompa.dev> <CANiq72nXN-pkHAG6A19JrjiL-uKpem_-8GN8RhiVgc+sKJN6wA@mail.gmail.com>
In-Reply-To: <CANiq72nXN-pkHAG6A19JrjiL-uKpem_-8GN8RhiVgc+sKJN6wA@mail.gmail.com>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 31 Jul 2024 06:18:13 -0400
X-Gmail-Original-Message-ID: <CAEg-Je_S8hAUg9Gdp7QAOxww2dvV4_OoCTV1pvxMNAAvVkQueQ@mail.gmail.com>
Message-ID: <CAEg-Je_S8hAUg9Gdp7QAOxww2dvV4_OoCTV1pvxMNAAvVkQueQ@mail.gmail.com>
Subject: Re: [PATCH] init/Kconfig: Only block on RANDSTRUCT for RUST
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: rust-for-linux@vger.kernel.org, asahi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Asahi Lina <lina@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 4:32=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Jul 31, 2024 at 5:21=E2=80=AFAM Neal Gompa <neal@gompa.dev> wrote=
:
> >
> > When enabling Rust in the kernel, we only need to block on the
> > RANDSTRUCT feature and GCC plugin. The rest of the GCC plugins
> > are reasonably safe to enable.
>
> Yeah, only that one is what we had initially years ago, and then we
> went the easy route since anyway the mixed builds are best effort at
> the moment and GCC plugins could possibly be going away anyway.
>
> Did you test it with the other GCC plugins enabled etc.?
>

When I originally wrote this patch two years ago to get things
working, Fedora used all the GCC plugins, so I was trying to get GCC +
Rust to work while minimizing the delta on build differences. This was
the combination that worked. We've been carrying this patch in the
Asahi tree for a year now. And while Fedora does not currently have
GCC plugins enabled because it caused issues with some third-party
modules (I think it was the NVIDIA driver, but I'm not sure), it was
around long enough for me to know with some confidence that it was
fine this way.

> > +       depends on RANDSTRUCT_NONE
>
> Also, why is this changed?
>

This was mostly because I wanted it to be clearer. The negation didn't
exactly read to me the same way, but that hunk can be dropped if you want.





--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!


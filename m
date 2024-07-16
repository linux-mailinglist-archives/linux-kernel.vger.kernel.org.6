Return-Path: <linux-kernel+bounces-253973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 368CD932983
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E795928243F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6402919E7FE;
	Tue, 16 Jul 2024 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/0OYFnv"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F01C19E7EC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140763; cv=none; b=LARPzrQLVXp3z/fUI6iR6Xc3erhcfICYFr0zhfcLsKzNmvn0fRmPBH/bRpkoJKIpBVCPKKKBIEUWEn0VjIcHq8gbwTHFNej3oV0/w36d1LahRpNgUFm3uBuEUzg+3g0aB0a9I/61gRe5Sc0o82ISHl2mLRfa9MGp+y/pkM429NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140763; c=relaxed/simple;
	bh=MzRRUxdfl+9rUlnOGhrWT+i9Ba4CWdrZlHh7nGDZNM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7sHYtnOYItQkW32twAT3Xr3yZ4nzCfN4Lwa9zqXmKv7D7hjRH81VfDF9fsaRyEwwro/Y/vgqYNp9ka2o6xa1CmPTmPF1Y1nf+OkUMcAPXsIwL2pdRHvsvtBk8Ov455Gj0nFnYQPhdD5RE8rvYEB4cU2PgCPy1X4MR+k5GYsZpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D/0OYFnv; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58ce966a1d3so15927a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 07:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721140758; x=1721745558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dT5FLWbWUPfMqjFRBjpee8/HikhM3a2iAoNdQQA++MI=;
        b=D/0OYFnv7Z9RyQAEiH18j9jR2WOVYkZs3jLCRwMcCznGWHjkIZWrl4Ww84motaFZv+
         JYC/ehGqe4gEP0PzjGzJap1X5Wd3iOlyaEFqe5eLa0/SDYJj6hAMHgW+FmrU0o+WMaoj
         nR87V4yDV4L1LBnqLynsuwwUwfxotKvqrZXkwJDYHB61iQkpn7/dFTYNbhvWuj26YDd4
         vQHd6OTIvBQjdKrDdHXh9nmslEY/kbdvkPDwvP9YJyCIjk16Mqyd2DWQe/6kbsTJpaxr
         AM5D+h/ASI3R8Cy8bBB/yQeBWZT+VMcVHT43UAG+cF/+AgcL0QpzyTVukqbAuuUIiGDK
         cpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721140758; x=1721745558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dT5FLWbWUPfMqjFRBjpee8/HikhM3a2iAoNdQQA++MI=;
        b=F6QGhsAAId9PXVWcAbS6s2BPzTj7z+vJUkXYbTbJ39Kw4jAFH/vci/9BarmHA4K8mv
         IllUzgAvTDuNhCNBph6XleYQt/1x4hUi3+h+fl94jvaDDhZl21/RcG3bjcbsiz/C+H3u
         V5p35uWL0xMG3yllYjOhhMptDZNDfJN07erIt5AuE9VtTM16bHpFt1mjWBD0C0qfpfna
         Vn3uPzSDb3j/MGSJdQ7mSNRTjZiJQgldq7f8x/uVefy0xi5x7S16OrLrnnaTgnwcHijV
         ejQngAIfWsJfHRRTN+U4YtfDc5AEJvNVIkvaRinSUdE/O/Lw+UeVC7GzntJBMRGtl2RT
         B74w==
X-Forwarded-Encrypted: i=1; AJvYcCUG3QVhiQhkeIqIIi0i/b6Rqk+KVfOuR+US469Of0ri07fbw6G2IAX9PW+F7edLOpI95dIpSSzzUBHSuSCOorJi3FTycwIvk8+zhCN7
X-Gm-Message-State: AOJu0Yxyr8V5Hs1qy0WlOysVKBEABR32uyI08M2I9QbBgFQhggRn3Bm9
	Rf8XCTjUjU6cTM2OsL2DXyoUEZdMOlwa91s6GPDoDjQTdYnoSPvHq4KOZ51yZbn5dez5dL1TCvC
	qPM3r6OQ62eGmmj1Xr6eYLyX1sJFQ9x0yBTCy
X-Google-Smtp-Source: AGHT+IGmSsybD0lwtju0owF8AM0wm2lcQbvYRwn3K5A2uMn2kfbPepm0PCfZm5tU5+Hu3yXbRdLVB8GSziRa18AlELU=
X-Received: by 2002:a05:6402:5106:b0:58b:90c6:c59e with SMTP id
 4fb4d7f45d1cf-59eed87975dmr285403a12.7.1721140758063; Tue, 16 Jul 2024
 07:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240714041111.it.918-kees@kernel.org> <20240715094107.GM8432@kernel.org>
 <6d1a441d-31f9-4bc3-8856-be18620e4401@redhat.com>
In-Reply-To: <6d1a441d-31f9-4bc3-8856-be18620e4401@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Jul 2024 07:39:05 -0700
Message-ID: <CANn89i+iRU_GcRg9XUsAzahtGr5vKshJqyw02J63U_rChaCQjQ@mail.gmail.com>
Subject: Re: [PATCH v2] net/ipv4/tcp_cong: Replace strncpy() with strscpy()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 4:32=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/15/24 11:41, Simon Horman wrote:
> > On Sat, Jul 13, 2024 at 09:11:15PM -0700, Kees Cook wrote:
> >> Replace the deprecated[1] uses of strncpy() in tcp_ca_get_name_by_key(=
)
> >> and tcp_get_default_congestion_control(). The callers use the results =
as
> >> standard C strings (via nla_put_string() and proc handlers respectivel=
y),
> >> so trailing padding is not needed.
> >>
> >> Since passing the destination buffer arguments decays it to a pointer,
> >> the size can't be trivially determined by the compiler. ca->name is
> >> the same length in both cases, so strscpy() won't fail (when ca->name
> >> is NUL-terminated). Include the length explicitly instead of using the
> >> 2-argument strscpy().
> >>
> >> Link: https://github.com/KSPP/linux/issues/90 [1]
> >> Signed-off-by: Kees Cook <kees@kernel.org>
> >
> > nit: Looking at git history, the subject prefix should probably be 'tcp=
'.
> >       And it would be best to explicitly target the patch against net-n=
ext.
> >
> >       Subject: [PATCH net-next v2] tcp: ...
> >
> > That notwithstanding, this looks good to me.
> >
> > Reviewed-by: Simon Horman <horms@kernel.org>
>
> @Eric: I can fix the prefix when applying the patch. Please LMK if you
> prefer otherwise.

Sure thing, thanks for taking care of this Paolo, Simon, and Kees.

Reviewed-by: Eric Dumazet <edumazet@google.com>


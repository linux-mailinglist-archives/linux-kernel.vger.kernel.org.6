Return-Path: <linux-kernel+bounces-237053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD7B91EA58
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2337282947
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F626171653;
	Mon,  1 Jul 2024 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tv65dCRf"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7EF128812
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719869361; cv=none; b=lKmPbtSyihVUIkpM4xhiXZXQeiehXq68ZSOYT73tU1JGAFC0hT6Ul+Suild75W+0bPdH308BTAyqcEifsa/naHKl6JulwwGO5D4l7zeTR5IFTvDXGi7sI5Lzd3NNo/A/VaD4G/25zwE4rqfiWyU6GwnBOSQcgLo+/z6XmpENGWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719869361; c=relaxed/simple;
	bh=QYRodptKrW/HhfD33cZFPnsonz/sn+arLYZ+QIwl0Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etM4edOEj5Pr30IAzTKpCEiZ63vRCfrmsAeAHAXsSQLx5dwbwn6cuWeK5GcGoeX57s2SAqOEKtDo3iKogEUX7teQtBoJ9cyW36l3AygeD1Ic7kdq5iC9CwphjkezjbS8pMYTDccnucE0YEBsF1LW0gm/SHZISNKGMCaxuPPE8D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tv65dCRf; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-64a6bf15db9so29394477b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719869359; x=1720474159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSl2Z5I3t21oRckeUtUCQTf8DO87uHYoHEdnx8eg3oc=;
        b=Tv65dCRf6jaye+ibDMk340wcb+IxypZyh4pBo8l9kMqeGkHIcpgk4xAcxs7UVeNxQH
         /fRy0Vf3yZ8A2NuhCSboc3IyCcHJlI80J5fW/86Y78yDHUeJQzsfVipHYsrEXbi+jxbV
         2MzvfYmN1I7oebmAqEuWbJI397Wd+THexwspSHB2gg5B1pTo0HsN4DhaX3VuIE0SEGc8
         NB9UWJ/Gk5V9JWi6BJhHpClgM4m61kZzCTZ4lErGxO1u2pWmDN5RXK/76PBBm4steC6V
         C3IMef4X0j5TXRPmuq3ptBYhRD0PKF4upjq1uwgu3lTvaQkk1g/uoF6mmVSY0ERjVPkE
         vPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719869359; x=1720474159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSl2Z5I3t21oRckeUtUCQTf8DO87uHYoHEdnx8eg3oc=;
        b=pNLZrRIOReae0Y4QQYB/LbQhizhL+svBYo+hTRriRCkdeK6f6g/hdLkMq5t26hhV7F
         e60brcYfqfjEV034xtSjhPFNy7NKPBFnaMSdaJNG2F+j6AM1E++V+rsRQWpwp+Zaa+YU
         kDcdSe+znGDqIdTnMyoxUTZmpHIk6Kp7bEmagv6fyFTP5hbRMAQQDIF6skI2gSsjKsKa
         bVlONZV3j51W1vvVromf4G6u6h0Z/KoyczGY+GUgBoRJ5MpT4iwA8QTPTxnssXMe/w1h
         IipjA2i1d699D5WPpbI3gRCaegtcY1Dp4I29h2gT7D3NBV3qqpwFTyzHH/7SBnjuYGmf
         m5LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXef61MGdPkBYBCG31A21BPJgTsYWcycCBjbf5geLH0jOI6fESniW57JullpUvqZC0DtAPaDa5X+ZHIBIRp4i7aW4oILO9TrgL1q1DU
X-Gm-Message-State: AOJu0YySjpDJBx8fQKjF72bud/87grwPc3HhszZilJWSGOhBAQj1aICM
	cIEGz6YKUR3DBJxo1AOE+I4DLOS4aLqrtYk7Vhdx5iNsfGbtMXS4hhZCJUG0bzLj2OE1ObRM4uf
	h7nZx96FGRd0B/nhnEp0pw7qOIycWMUANDa5g
X-Google-Smtp-Source: AGHT+IGrXD+4pTPNuwEshDbV7GX9n6Y4nx9gnSj9JNfjW9ApBZxXIXAXK/wbTCLOwmtQ93G/H286x9LA3nwcDlnDZsc=
X-Received: by 2002:a81:a748:0:b0:64a:6eda:fc60 with SMTP id
 00721157ae682-64c7114568cmr54543967b3.4.1719869358874; Mon, 01 Jul 2024
 14:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701190512.49379-1-sj@kernel.org> <20240701190512.49379-2-sj@kernel.org>
In-Reply-To: <20240701190512.49379-2-sj@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 1 Jul 2024 14:29:05 -0700
Message-ID: <CAJuCfpE40946AOT9-DQouy+=HdgfFxFH6+OYu=FLXXVv7h-E3A@mail.gmail.com>
Subject: Re: [PATCH 1/4] Docs/mm/allocation-profiling: mark 'Theory of
 operation' as chapter
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 12:05=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> 'Theory of operation' part of allocation-profiling document is
> apparently a chapter.  However, it is mistakenly marked as a document
> title.  As a result, rendered mm document index page shows two items for
> the document.  Fix it to be marked as a chapter.
>
> Signed-off-by: SeongJae Park <sj@kernel.org>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  Documentation/mm/allocation-profiling.rst | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/mm/allocation-profiling.rst b/Documentation/mm=
/allocation-profiling.rst
> index d3b733b41ae6..ffd6655b7be2 100644
> --- a/Documentation/mm/allocation-profiling.rst
> +++ b/Documentation/mm/allocation-profiling.rst
> @@ -46,7 +46,6 @@ Example output::
>           55M     4887 mm/slub.c:2259 func:alloc_slab_page
>          122M    31168 mm/page_ext.c:270 func:alloc_page_ext
>
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Theory of operation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> --
> 2.39.2
>


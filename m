Return-Path: <linux-kernel+bounces-213867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B98907BCE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9539C1F241DA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9D114B950;
	Thu, 13 Jun 2024 18:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="chiYTzFs"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EA014B09C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718304998; cv=none; b=d3xgrF3QoL5pEU8ZSpwdOIm7zphD910bQ7wLd0GRFLXY7ckffRYEsLNpd/vKOic1n/R4QC0RjgXMnj1NEJ3TFpoo38rvhIzxbawYYKlwAIKE+3YseaI4Yc20PKFpMlZ5N9splzPnib7tAbGWGVloruxfCCdetOkALJAvfZcVZYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718304998; c=relaxed/simple;
	bh=xV7HcjHmeGtaHXHk72PhiXUzx2a5TJihz657tRWxpT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iL47p6UKBIRVE2rchuEqKs8HHzpQwa1NC0dZvMq2ovArEpADLpkLnMKXd+wPlK4AxMKn9o77Azcq9z5yek6I9g2XeoFawBiN4RiiSBO9fpI3R/L/ITQ0AC8nU4JYwKzmMq8COqIrO5eHRauzSSR/6fPCymeCHiyhybBpv8fWaWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=chiYTzFs; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57cb9a370ddso1340424a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718304994; x=1718909794; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=co9iiUYPpsDeUP6dIKaNWZ4aIlC8pyYiOIMGYN9qN5s=;
        b=chiYTzFs2WOiKpXm5DLxBnpoQvkb3MGE41nOAvqTveDlROzXKXms0bpqkOZE/tDB+1
         8WZpXISs5ZKz62zgLO/dSJIYF8vwN4R5cusx96CTX3aiIIkCS5FCHMXy7nDMvtlUh6Gr
         DW1cy8s0HJuPny7BfTqnMgyGFAcZDd9S7f+hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718304994; x=1718909794;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=co9iiUYPpsDeUP6dIKaNWZ4aIlC8pyYiOIMGYN9qN5s=;
        b=kBbBSJ5jGzn61AFuv4272GlJgJ8msHj4aoYZ5baoHCEI5cCYg2f9/mpM27WtAZ+3Da
         M6ocMaALl2Rh5W921MVynUE1yFYdHir/uIRJEgBUfI5ZVt3d4d/nP8RONfGoyOnMhJxX
         OZSP/z+6i7LheXeDHoU8H4g013dtZsAwjzI66vFZ/UY8W38qpPM36bRuLlIV2owTO2rP
         /UWdSaT2pdnrlkUq+0gneHQlbjjikc3mdmC5E26qPnkmt5gsaFGqSHpQ/7nsWpkt/GUc
         J2IPmgztzeerO9qPDfLHCmLAOSrL8b0hd9TayywqmHAy9C2/TkqmeMXWrlFh3uqIyNz6
         L3TA==
X-Forwarded-Encrypted: i=1; AJvYcCXXktBHA+8OUXPi4QtPiMMQlhUgBWmFWQ5l5lJmunSQRvmK/0IrENFgwZsteEnz1kbSGpdgxusNm2HdvqgSXmNyYK2Zsj0rv5tBDxW9
X-Gm-Message-State: AOJu0YwdshXwSNpNIlpybQ7XC+NeW94X0GjSDqXjmoLBgmYsFHFencfq
	I9A82jv1ESGKJoqrv1uT47VwquBdzc5OBjhut3/D1rY/xkbU4v1YxJQZ30Uhcu9jDl/1Qov4K/P
	F26AUAQ==
X-Google-Smtp-Source: AGHT+IEiSKRf11L+f/bCS8d4kQJcclBKs9RGA0WqOgxoWC6qhQwgdAJzwbCqCPH4kU8gkXpV48JPEA==
X-Received: by 2002:a50:d648:0:b0:57c:61a2:ed47 with SMTP id 4fb4d7f45d1cf-57cbd67f6b1mr458335a12.24.1718304994303;
        Thu, 13 Jun 2024 11:56:34 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb741e725sm1199269a12.69.2024.06.13.11.56.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 11:56:33 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6ef793f4b8so162862166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:56:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXu4o/uERzI3/+AvWWHQtPEo4OEWrblPPnENS5LUyI42wsVifyoCv3hk5kri+9UjuYUnhr4n47lLuVIJWqVF3k82Bs+Wc3lhoF66QhG
X-Received: by 2002:a17:906:a849:b0:a6f:4be5:a661 with SMTP id
 a640c23a62f3a-a6f60d460e3mr38707166b.46.1718304993085; Thu, 13 Jun 2024
 11:56:33 -0700 (PDT)
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
 <CAHk-=wi4xCJKiCRzmDDpva+VhsrBuZfawGFb9vY6QXV2-_bELw@mail.gmail.com> <CAGudoHGdWQYH8pRu1B5NLRa_6EKPR6hm5vOf+fyjvUzm1po8VQ@mail.gmail.com>
In-Reply-To: <CAGudoHGdWQYH8pRu1B5NLRa_6EKPR6hm5vOf+fyjvUzm1po8VQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Jun 2024 11:56:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjwqO+HSv8P4zvOyX=WNKjcXsiquT=DOaj_fQiidb3rQ@mail.gmail.com>
Message-ID: <CAHk-=whjwqO+HSv8P4zvOyX=WNKjcXsiquT=DOaj_fQiidb3rQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] lockref: speculatively spin waiting for the lock to
 be released
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 11:48, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> perhaps lockdep in your config?

Yes, happily it was just lockdep, and the fact that my regular tree
doesn't have debug info, so I looked at my allmodconfig tree.

I didn't *think* anything in the dentry struct should care about
debugging, but clearly that sequence number thing did.

But with that fixed, it's still the case that "we used to know about
this", but what you actually fixed is the case of larger names than 8
bytes.

You did mention the name clashing in your commit message, but I think
that should be the important part in the code comments too: make them
about "these fields are hot and pretty much read-only", "these fields
don't matter" and "this field is hot and written, and shouldn't be
near the read-only ones".

The exact byte counts may change, the basic notion doesn't.

(Of course, putting it at the *end* of the structure then possibly
causes cache conflicts with the next one - we don't force the dentries
be cacheline aligned even if we've tried to make them generally work
that way)

             Linus


Return-Path: <linux-kernel+bounces-532716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47487A45155
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5F0189FDF7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68885B67A;
	Wed, 26 Feb 2025 00:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gg3hBbss"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C5F1854
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740529034; cv=none; b=BfOlmrTlecMFuh7Fe0/F7b5naZXk3K1ttyjZ/PDKoyJEwLOQH6Z/ZJkN34AIFcJbJozLTEU8aEUg9ZUpIEhBi747iJ8++Uh8rjCOc7fOuD9zU2i/etocq5TzTzC7NfDHm9CiMkYbG4qCBkZ73MNpw05hN5EpusFnTyvn0sl6wXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740529034; c=relaxed/simple;
	bh=SUDSTvfJwxWrPW2D1t3bKyzv31MyUSt/Ao9b3j4Kuv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgVw7cE6GMLmhpjF6awqmgp8wHoVzZCD0RpBP0V60qKKBNE/ODMh9Ht4jSMp8WIFWaPRG0QdH6YwKaS1wsfsQEEopSfxnWeM3mI+AOPp2dip/O3igH4h05zs0C073f5JukoQVpI+jNqzQtzCArPVY1g/hsipDyynrpBIla3ZOnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gg3hBbss; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5fc6f75aa8aso218149eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740529032; x=1741133832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUDSTvfJwxWrPW2D1t3bKyzv31MyUSt/Ao9b3j4Kuv0=;
        b=gg3hBbssN8mS6e1k8r6HPAXmGlHWG+NtisBeD9+GjB2qaZjqbbYNRDVV0lhZator+o
         hT1Mz+XTG7UrXmUggqLuCnu0QUa1QcMM20VhqOqURnfKYAc1y+2xqJZf8flKsRoS543y
         UNSssj25Qqh9b1DehmVE2tJ0POEnGFPmJgCVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740529032; x=1741133832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUDSTvfJwxWrPW2D1t3bKyzv31MyUSt/Ao9b3j4Kuv0=;
        b=fZ+z5T+nfKNrrC6OQRf+GBUIjRHvjILAD6XY3rM7/hE6V+zQlPSMkUacYbJ+tRBSxG
         hB13SHwfvtER+3Eq/J6LmwhSZzhszloLPHpM7UG28zuJ2CyxZZpxwAXCk45hPNWtCTk8
         0bZld4WZ2vrH2HGfxJ5IczcrnaCn6KwGx2q9zHcmVcPgLHQAvxLs3lwOemQUP6XOAQkA
         ul8giETK0OkN5+IulQSDWqx50AYOOywWquoWp1FTjbG+/OszkeVH3ncVH5X8MnWZhnvH
         tYwo2cRNYEXntWVewRA8TwU5KG4c5fbFG32AYZxlggnY+MDKG44BjZMaf+BJR97aa/Zg
         DeVg==
X-Forwarded-Encrypted: i=1; AJvYcCWmETPULZWqjzNhPcKF7/HiTIFJUXdnVRuidugHv4z0wQvMJsyF7mcPj/lsfrNKKDjPVnuG0XZzjWh3Pec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiYkE8gPb/S9dNqXWT+k0aJ6tSGv9xws1wl8pH/xpY0d+MNetM
	3su2kNSiVPJmDknromXvTJ8ye8r44vq9rCHdW/Y+Hrl0hu3nMHALe1Utvm858pnXw1vfUo0q5f/
	Zg+/BUzOciBAPfjMjCcjifIEbmPZexmrweBdt
X-Gm-Gg: ASbGncu9L6EJD705KrzNyNgpGsfAxUt4h4XOSB+4WNAB2RurBH0Fsp+Czu5Kj0+gCq/
	E0aKpxGrggm6h05zU7iriujXTgRIKhrwte5P6dC3ADKdil1wkeWfYbts5HkqihTdG2BCOzU8ram
	PLTMXh7qVQBZPHdoGDSzRrSgjh1A3jqZKXRWw=
X-Google-Smtp-Source: AGHT+IEJbRW08WZAkye32F7Luz5x0062dckX9V7j3QHQYEUASGF10EpfqEpNtJ6/s+o1rKHakFs4IT9BHNn5BoyOy0Y=
X-Received: by 2002:a05:6820:1e02:b0:5fc:e36d:ffb6 with SMTP id
 006d021491bc7-5fd19395e2amr4533460eaf.0.1740529032488; Tue, 25 Feb 2025
 16:17:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <30b4de93-70e8-4384-ae56-9f6b6cf0f347@lucifer.local>
In-Reply-To: <30b4de93-70e8-4384-ae56-9f6b6cf0f347@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 25 Feb 2025 16:17:01 -0800
X-Gm-Features: AQ5f1JpiD8bCptvm162gy1lUaUuVkH3ub-_gESU1cDNpJhOKLkaCIve5i-unXGY
Message-ID: <CABi2SkXkfFAMhmXP1CKHCZMxdKWcHx8T9_0-nwBPWycTbxOctQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] mseal system mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 2:32=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> BTW can we please drop the 'mseal, system mappings' prefixes on this
> series, it's really weird and makes it really hard for me to actually rea=
d
> the individual summary lines for each commit. 'mseal:' will do.
>

I am not sure.
I had comments about adding mseal, system mappings, as prefixes, and I
think it is reasonable.


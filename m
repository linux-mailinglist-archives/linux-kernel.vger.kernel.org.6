Return-Path: <linux-kernel+bounces-219616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF9B90D591
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5EEE28AE35
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C76A16B39E;
	Tue, 18 Jun 2024 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LAHP0OV9"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5267016B39B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720563; cv=none; b=CAE1Tzq71Ka8eqIfSmVVeGq5cfKHUY1AtHr1XPgUVRojU7N2rGJrU4xmgJJfD312nCGI0LBaGyat+ILG2GjoZo1uBDnYShI2/BfONoI69mduEEm+5ELDQLmZ4bIdcb2ssG5X5GZ7zK9JX1mSgmfTlhNNWfSK+dXibuCaG4YeW60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720563; c=relaxed/simple;
	bh=U96e2ewUPGUwtDxZmjwxc3i6uzrFQ77Dn0ewyfhwgas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHPpQYAazDyjVuhgBbGaLNLbF+OA9K3UcDFG2C+v356Cx1PWDwHUuoJBL42YUBn7ba6AbldHLIoTGgsc9q+ZSgjntYPZE3WoDtHyTSNsEvicAwVrD9r4lxfjDP8Pd6aiN6A+K0sY71sJy+ef0VgoP2aWvv6e6MWlyqmftNOkotM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LAHP0OV9; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-795569eedcaso277847785a.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718720561; x=1719325361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U96e2ewUPGUwtDxZmjwxc3i6uzrFQ77Dn0ewyfhwgas=;
        b=LAHP0OV9310lpWuj18UtKOepuKRku28QRHcYYbeXvwyqd3mC6YypVZmXP4knIgOk3U
         UcIcgRO3POk4KsL5apSQ5qms+iG532MCIAMx+nmkeJddCojXiBEjm3xHwyClDYluKrqC
         bL0yZT+E2J6NGfwoF9JXNGlm1xU1feO7RKMfrsl5TZ8iLYjecImWqsK7xtNs2RBynCx4
         8TTT+8bxgDZHiBbpa+p4b3CJKc4mvinAya3OM9KnYHUhrXUGr2JNAyEK3HMSkiYFDpcC
         1DEWviKbCBfzvx+q9IqNHpi0OfdD6Kzpy/TyKuD3FVtxme9agtHDtr62bgNUI9s31dQ8
         lZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718720561; x=1719325361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U96e2ewUPGUwtDxZmjwxc3i6uzrFQ77Dn0ewyfhwgas=;
        b=dCe4fizKCIot72V5YI7Y7RTJcuHPdk2VHMa38Kl7tUo/yFHu9sejsS2DW0SezQPwIl
         zwB5j7VqR1TsiR3Q83w8/5I3Btlb/KaAW/OqksZC1EJOMD/pwtoXQ2AM7VKV+qkYz6v2
         iNyYdfSoN684igMUz0HlODu6M/ITLbj4NRiSoC0KtXBbHMM226+EgCf8dqT2KQw6M8AB
         Ujr/jF9fXHe0R3GRJiedQWcqjdYk6k/xwfdhdO6b9dp7iidiFo0RWMgEMu/JDfSOorkA
         th33v9C7ujnGur7eVTVhpv5KuQxOZjXLpnZvLowl7f1UbIFSbj3ku3L0kKHmL7Ba9fmd
         pDUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6jSOtFa7leF1T4vxL7FZZmQ1cof7XvOygnVTG7r0nn6VUHxcDp8ZiANs8idZ5O6c/BMvJ7g1b1zYfDX0mQ45VAHrkFWwU8s1AE+wh
X-Gm-Message-State: AOJu0YyMc78HaWf5SwblETzWnBdcc7ul/tUksM97uXFTccEstT5RtyYF
	3+vApW4hQVWagMdMWfKK5h7Io6ee4tabQCWpNns5nGRT7yNFw1y/u0Nkh0qFmEuz3W5NQoesWKY
	nykNyy9P2wL3kzQfnk+2Zmxf1baXnwmZedLy4
X-Google-Smtp-Source: AGHT+IGILaqPOZ2ED8ohKLixFiVuadcnP7+nr4oNkquXFmcYtsIiJ9uoXj8gq8qFXs/ZH/i6CuJp0jOeYz/h62OJDhY=
X-Received: by 2002:a0c:f345:0:b0:6b0:7505:8846 with SMTP id
 6a1803df08f44-6b2afcf228amr120592576d6.39.1718720560961; Tue, 18 Jun 2024
 07:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613153924.961511-1-iii@linux.ibm.com> <20240613153924.961511-16-iii@linux.ibm.com>
In-Reply-To: <20240613153924.961511-16-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 18 Jun 2024 16:21:59 +0200
Message-ID: <CAG_fn=WCNsF6HGALo0WN2POcyZ8ngmjpP9Wgqb9hXd4P9Z6geA@mail.gmail.com>
Subject: Re: [PATCH v4 15/35] mm: slub: Let KMSAN access metadata
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 5:39=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Building the kernel with CONFIG_SLUB_DEBUG and CONFIG_KMSAN causes
> KMSAN to complain about touching redzones in kfree().
>
> Fix by extending the existing KASAN-related metadata_access_enable()
> and metadata_access_disable() functions to KMSAN.
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>


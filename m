Return-Path: <linux-kernel+bounces-278447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CF394B057
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBA31F23064
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEEF145320;
	Wed,  7 Aug 2024 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LBqlN6n1"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8DE1448F1
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057949; cv=none; b=HGmyM3MfPZgUrY+ISh2p3UiLlR5IC5zd1aQoTb49WYLwnJVfYW1JtuIAhsefG2jgmDnry2/2hQYO5N9b5TLNgCDX11hunZ4f8QNs75exLUUAwHEZiKVs6ZV9TsFkzVBTr7OqI5RMW8wTnCUGfR816mOeRrDr030efTM+kNzXFI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057949; c=relaxed/simple;
	bh=1WLs4U4pJAgrGVVsxUErTGOk4QX7JD1FuPYUe1vFarI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jkj08VXJ6SypGrtoq9Pgwkt8D+uimLriULHPj3jt4DomlfThSf4Tg/xKAMkTy92vV8cBn4PegbvDXBYlgz8N5NvWBgcJ/65FCOx6sp0f40QL/xc9tzcPK1r0Vh9Ce0MAtnw2yweRaJDkPQLvf01lCpUGZvGxa90DIMHoZlWbULU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LBqlN6n1; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so95a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 12:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723057946; x=1723662746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WLs4U4pJAgrGVVsxUErTGOk4QX7JD1FuPYUe1vFarI=;
        b=LBqlN6n1DqSOctvYRJoWMxJAr+IIzgSg2GsXGsXMEeeeIih8p3o+O1ASWlomnJr/F6
         BO10+tQSqfAKSQ4jX4iAbYJXXUWstdm9OUwSy+3O2chKLgugbKQvoIUCwEOCJPg5b6jS
         iplPvG4FjH/IBetkUNFfGXjHeOnY7SjIqCj1prI8APLcrdrzC0fj5XztYAGhpXgqXSar
         /4X9avdzDb2nnVjpn8jzXjQMhJN6reya+xVrWyBMkA9II8RMWBwPQpR9roxZ7xUJbS/l
         dQRaa0ToAgL1S4jIRYwYzsozWQD4uOUAyUKCyw2HkiE2ugj3LpW0AchOknSXExEPwXr1
         jOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723057946; x=1723662746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WLs4U4pJAgrGVVsxUErTGOk4QX7JD1FuPYUe1vFarI=;
        b=UwVqrlD3xoZCYFUsiBi0aR8OR53KrjkckbPb3l2VHo/WWDfrCFN2Fa0dpIHE1atb33
         loqNkwDe8CfS2Hh/lYcBlxCeXM1wkxxSv04YZ5r185eLoYZu07qsl3MbwdRbnMUetGJx
         Vf84Sl2RQygDB6clMqWzcsL0BJ65PrJXirErAtcrMacm2dSh9INHtOA1RROjDL5cfPNT
         jEe3fkhNUloZslEr5zlmELGfxNseBApknrP8IADB0TbXVQFud9R4gzDEHmiSi6svSNlI
         9+oR/bOdFwfxoT3+mYiHZVsRPTr74oQPMjQtuZJAsJ0wqOJW8BB+YD5rDfQM+ysDcAzw
         xspw==
X-Forwarded-Encrypted: i=1; AJvYcCVUkYPLjBrlOFCnF/hV4uvqlBrzI/K0LMClM2QaYWHQpTEgOB61q66kj5+Oe6xMl6E4s7vCRFhOmfSw4sJ5cmY4mgJ4dtuARR6OcSS1
X-Gm-Message-State: AOJu0Yy+NRvM5KQhPJx+g3c2y/x4ATFzZjGA//oGXplZ2Q3E+kgjyQfU
	iOvVEekHDZqqSlUgA65F280ywcQIJU1HAJ6LRYC7t2w3Ic3+5yeH0LKA2T8QnR0BBMcz2xR+rwD
	tfUpqMm7D7M8GQvcbKZ5nKu4wYQDVwhVIhqNa
X-Google-Smtp-Source: AGHT+IHRb+iO/7Xu5LY8bZHYmwguSiyhvHwFPfxn7/tf+k+CbGWx+HjOCccF59nCcoHPtrOSEg81/FkkH0bbTysKMGU=
X-Received: by 2002:a05:6402:40d2:b0:57d:436b:68d6 with SMTP id
 4fb4d7f45d1cf-5bbb004ab49mr17751a12.7.1723057945956; Wed, 07 Aug 2024
 12:12:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz> <20240807-b4-slab-kfree_rcu-destroy-v2-3-ea79102f428c@suse.cz>
In-Reply-To: <20240807-b4-slab-kfree_rcu-destroy-v2-3-ea79102f428c@suse.cz>
From: Jann Horn <jannh@google.com>
Date: Wed, 7 Aug 2024 21:11:50 +0200
Message-ID: <CAG48ez0j7qx3mCtQwq-KfkG+nj_k7w9mmwL=FDx_sMSVphhncg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] mm, slab: move kfence_shutdown_cache() outside slab_mutex
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Jakub Kicinski <kuba@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 12:31=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
> kfence_shutdown_cache() is called under slab_mutex when the cache is
> destroyed synchronously, and outside slab_mutex during the delayed
> destruction of SLAB_TYPESAFE_BY_RCU caches.
>
> It seems it should always be safe to call it outside of slab_mutex so we
> can just move the call to kmem_cache_release(), which is called outside.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Jann Horn <jannh@google.com>


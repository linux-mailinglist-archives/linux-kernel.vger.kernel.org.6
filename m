Return-Path: <linux-kernel+bounces-262074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1497293C077
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5ABE281996
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1765A1990DE;
	Thu, 25 Jul 2024 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vVCbPlva"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5977CF16
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721904889; cv=none; b=cWDjuM9YGsxLuOEIL/rCIvIWj/gCQgBWE0NjOCzO8G+EnPWekg2Dcm289YoWVE79VQL6LVU8p+Ekhvv7m4VakqrskgRwE/sYjvBiA+x7VdKFTrSFlpeEq0IgOelDzW12y4Keex5urDl7A81JkL58qX/frxAAxn0xb/wF0aRgO/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721904889; c=relaxed/simple;
	bh=iA+Dy2gymI5rMbPMbetsdAXWUSOVO1pHxP5QyvQLaJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPi//BvGwkT5qJ+l5qNruEO99TCHxam1eas5hXZtKBE7aP2gQ4mUof4HCRtUz3hFF5kWarpcd637aTXQ5M70JGdC4VEJtW4jPLy+E9MkT70RFukqnQNNfOy4luwO7vd1ApohQPySDBJFfucUQpFuzFqd9LY41Vt/yKGrlpdR8g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vVCbPlva; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso14623a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 03:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721904886; x=1722509686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iA+Dy2gymI5rMbPMbetsdAXWUSOVO1pHxP5QyvQLaJ4=;
        b=vVCbPlvaQBhaHcxDD1RSB3ZOGetM0yJk62jzkFuBmfZKuYV+erKcwfIXzPQgJGgPqu
         fLRo+J/LyNjEtDzG0FPTFNenA4g0kwTw3QIs44/E7F8HY8S4Qwxrp70XX4pkxRwNysV5
         KIUGifNDVvJro/i+T4XcpRpOPqzn39G/AueqmNk9g7NWvXXVTZy0To0iAfUmFcBUj9Kl
         RQQAEQ+r4/3Kdv82Ga9pSxs+flIIqLCcp6i9qC23Uvezipql/t4Q5QHJv034Q/5f9yLk
         D6EuKe5alLIhC0WoS0FoAiJaqvWcuie/d+eYqP27iPovqrcT3RdrMeg60IwyStQC4mrE
         Q/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721904886; x=1722509686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iA+Dy2gymI5rMbPMbetsdAXWUSOVO1pHxP5QyvQLaJ4=;
        b=IKiQe/lHFczqWhMhI/lElkZbCkdFpN6F1/j+UhTcCiHSTfQJw+5ewRe8SmoNb6p8S6
         BUKXrtZJE5m1PUgETqCiIgGqVLMrRK0/dC4wHcCnwI9Axi7ScYUbgnV3XlnGC8xIXbv2
         tPMp+BZNha2ndIqlThCWFCfh1G1ZAJqXMjiLFkHWvR94XoxZ83WmGzUtMwnXN2pnpI0B
         fPkkLm5ZqMQxE9T4lWXwAcKT4D/jrPV4gI6xfVFRPWrIqQE8s6aIWVQFGQIK92AB573Q
         oXNlf7U4Mex7uI28AoqLJi3kIy2JUotkSCdLIfAAwZXhwmZVZJB5QP6kJsIONGR61pGe
         tNQw==
X-Forwarded-Encrypted: i=1; AJvYcCVyCNRUvSfqwL1/qr1qig7OR11LRbL/fmtQnslHSjZL4reooVVO2L6DzMdKBI6FsnX2C1iQ1EYxQ67k67Q6oW76J4BmjFxyI4rUIz87
X-Gm-Message-State: AOJu0YypSsJhiJ1pZOa5J1kb4mdE2L9robqhD7DzwWXgHrECZpnB6ffb
	nubcQ9XibBbohxZhGmWKRcL8wAebjJtJXLfGrww1xal8vCMWqXgzqZuk93f/76Wh0pk+eKuQzuy
	R5sltUH/0dO3ouV26B6bQt01KHS/9Yf0r3gMV
X-Google-Smtp-Source: AGHT+IGawKZxVugpvt+/slzYBOoHfNnulxnM7xqoBxQCACYGZ+/eH8eLBnvKwjufYc22F1Jg+2v2iomQtkj1/IKO/VA=
X-Received: by 2002:a05:6402:5250:b0:59f:9f59:9b07 with SMTP id
 4fb4d7f45d1cf-5ac2c3b3edemr213993a12.4.1721904885552; Thu, 25 Jul 2024
 03:54:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724-kasan-tsbrcu-v2-0-45f898064468@google.com>
 <20240724-kasan-tsbrcu-v2-1-45f898064468@google.com> <20240724141709.8350097a90d88f7d6d14c363@linux-foundation.org>
In-Reply-To: <20240724141709.8350097a90d88f7d6d14c363@linux-foundation.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 25 Jul 2024 12:54:09 +0200
Message-ID: <CAG48ez1d-iiWmt55-1+H4z=Didw=NaKZ0-f+RP7tSRwRNsiSyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kasan: catch invalid free before SLUB
 reinitializes the object
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Marco Elver <elver@google.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 11:17=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Wed, 24 Jul 2024 18:34:12 +0200 Jann Horn <jannh@google.com> wrote:
>
> > Currently, when KASAN is combined with init-on-free behavior, the
> > initialization happens before KASAN's "invalid free" checks.
> >
> > More importantly, a subsequent commit will want to use the object metad=
ata
> > region to store an rcu_head, and we should let KASAN check that the obj=
ect
> > pointer is valid before that. (Otherwise that change will make the exis=
ting
> > testcase kmem_cache_invalid_free fail.)
> >
> > So add a new KASAN hook that allows KASAN to pre-validate a
> > kmem_cache_free() operation before SLUB actually starts modifying the
> > object or its metadata.
>
> I added this, to fix the CONFIG_KASAN=3Dn build

Whoops, thanks for fixing that up.


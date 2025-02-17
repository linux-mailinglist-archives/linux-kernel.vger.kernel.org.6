Return-Path: <linux-kernel+bounces-518229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15889A38BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE07C167634
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59038235C0F;
	Mon, 17 Feb 2025 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTSCoPFJ"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7CB235C03
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818790; cv=none; b=YyAI0utVFZdNa01dNaxZxuOs06QmyWNHUj1WGhxBPHrP+XD/jkU72v+YDY21TnN9ArLwkAP4/1Ei2/rP4QbbvRaJDzdHiLzYvtoq5WPpKe1XSEat/OwW9IUxcyvvTvBBEUH68E7Y0ogi0O31SypJDKGNk6DTe1PZ/GbMoJEUJAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818790; c=relaxed/simple;
	bh=Vorx3UkCYgOJrLzhNIixDKvbQt/xQs6WeZhOlbJTBAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUS36jBc4B9Nca5tQwPaU3MkwAKEWG4Id6MbZQYbY56q0AeL6dTkBp/3eRLO45fTogjigUXcsczoJLSjLujmhHEvF/23JGYiV7v3s6v2QaeCw7yJju9ZQ+E4H2G5L7MyaYIjoMgp9CayyGoFfZLohkVZVD/G2h+CnJvHDeXLtss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTSCoPFJ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38de1a5f039so4561452f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739818787; x=1740423587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sK1f+sf0+Cg2T6VQTOIDYxT0Z22QiqhTwWz3Vtwgu4E=;
        b=fTSCoPFJlvZmxDlhaeXnYmiJh0isrbOsrbd1gyoGoti8nItbtZA6KAk0HLr/SS2uUf
         BaHTiOy9qezTZgSNarigjg0gbMHKNiV4IoMg1S55WRdxEYivBYSUwZXJm+XDIWoe05JM
         sTlGdVIQD/FnBapuBLU7H94trxvf8MmZs3y0znXd42fIffm2eriQsvAUg5+4qKACPMNg
         elfMdrT3IEVjnoex41XIP9v+IceMwiOmpOkCbiNVokGxCO6S5YVlrgnTR8wiawz4zCSi
         A+6lyzjOBUoz0hlyN7P7ubFzV1Qog9NLzKT/sPwd7pBhiIait0wy0ybw+EscJ30zKSUb
         LFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739818787; x=1740423587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sK1f+sf0+Cg2T6VQTOIDYxT0Z22QiqhTwWz3Vtwgu4E=;
        b=Skrpdz6ochoz20uWZwiW4wKLOzmK7DyOHjYa+tMmwA86Cv1IGZObPoueiVi1eX742P
         r1EhQSDocqCEu3jQwpUJqhGbCyHTR/6058cDvG6XiWCtAQ03ENsVD66iWz/ITyKQc9Mr
         Ul9U1P45A0gaHnwmcI+JLstoJ/lpdwIyObuxPLLdXBnK2+3b6j7gmUqpkNiO7BU7EyDG
         RGrZfMKG3El3m0OcqBBOS1qOjg3RpCjP3px4hEsOHd98yHN6/3TLuY8t5AxEHB0PiVlP
         ShHLsyjS7c2wPSlVi7ULcFpoD170+JtEQ6kif1rw5Q80VrotKsU/NKT7A8lH/neHw2Gc
         JomA==
X-Forwarded-Encrypted: i=1; AJvYcCUgB2YufNCfFkb5TD+S7flUCcE1zyMLMmX/DnkVI1ee8ILcJ+71QTl2Run6SHaxp8p9A1M+f85HZBnrdq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz49XOrp5micyscPPwIUtJOrDQWJ4xMWiOEo4KMj23nj+9fqW/J
	E4EaPYs573EYtSkLcH2vErayRc0AXEKHd5+Qo3bQFArHE+luH/mGr51wzodhZsBz19B/oNMlnWS
	xnP5gu53s7Ze+UUTwZlqd5S61xhg=
X-Gm-Gg: ASbGnctIHDpLUARj3zahVh8+MVrJ9+weOz+HWTabxP4aVq69p6b0oTWP5F9HsNfoZJy
	WLS7GyxYmH7abwepW9U1I+NjX2ALaQiCKBHjYPcIjcVD34CGDkhCWrm7YnJNLzKzVQlUifjbfNs
	0=
X-Google-Smtp-Source: AGHT+IE+k7Ek80Fa49RAv5Y4RAMxa7oY9cdhckbc6E7hMvsLWp0sBlYpearNUkEvu3arEOCU5a8iKWcfYHrPyJQ/yHQ=
X-Received: by 2002:a5d:47a7:0:b0:38f:4f62:7e29 with SMTP id
 ffacd0b85a97d-38f4f627e84mr1592906f8f.26.1739818787231; Mon, 17 Feb 2025
 10:59:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217042108.185932-1-longman@redhat.com> <CA+fCnZcaLBUUEEUNr8uZqW1dJ8fsHcOGCy3mJttfFDKq=A_9OQ@mail.gmail.com>
 <d9c96532-9598-426e-a469-dafd17d47a70@redhat.com>
In-Reply-To: <d9c96532-9598-426e-a469-dafd17d47a70@redhat.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 17 Feb 2025 19:59:36 +0100
X-Gm-Features: AWEUYZmoRBvkdpI9_aKr68h3AIVmSuRz0ygJyNHx-ItVSg0Df3xpQx3Z3q7nhsA
Message-ID: <CA+fCnZeBuWMUk4n01z0tWf65dvyBvLghqohJYKA0WkQ5pMjdEw@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: Don't call find_vm_area() in RT kernel
To: Waiman Long <llong@redhat.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Nico Pache <npache@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 6:56=E2=80=AFPM Waiman Long <llong@redhat.com> wrot=
e:
>
> >> + */
> >> +static inline void print_vmalloc_info_set_page(void *addr, struct pag=
e **ppage)
> >> +{
> >> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> >> +               static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_S=
LEEP);
> >> +               struct vm_struct *va;
> >> +
> >> +               lock_map_acquire_try(&vmalloc_map);
> >> +               va =3D find_vm_area(addr);
> >> +               if (va) {
> >> +                       pr_err("The buggy address belongs to the virtu=
al mapping at\n"
> >> +                              " [%px, %px) created by:\n"
> >> +                              " %pS\n",
> >> +                              va->addr, va->addr + va->size, va->call=
er);
> >> +                       pr_err("\n");
> >> +
> >> +                       *ppage =3D vmalloc_to_page(addr);
> > Looking at the code again, I actually like the Andrey Ryabinin's
> > suggestion from the v1 thread: add a separate function that contains
> > an annotated call of find_vm_area(). And keep vmalloc_to_page()
> > outside of it, just as done in the upstream version now.
>
> I can make the change if it is what you want.

Yes, please, I think splitting out the call that requires an
annotation into a separate function makes sense.


Return-Path: <linux-kernel+bounces-180752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CAD8C72AB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D571C21F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943D37A140;
	Thu, 16 May 2024 08:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7lE1HtM"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9073C27269
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847621; cv=none; b=OXAVcUdrh7bexBVQIzKzcMXaX0VlOcH47m8FOpUUx9PS9pD63op/M1wGltTMyjSkcB8n7l7jN7lsqU1uJrgsJ2DEWLjuhRcy0yILjHG5+Q1U9LDkuW+X7Tma7FYyqZN8zEkdrEF3qE+DlI8rR7TU4JFYIhJMGn/n0KYjxclMdQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847621; c=relaxed/simple;
	bh=bxieYVWOri+L67S4ctIpMGuDcf+jYQE9H2hDYqlsHUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGkekro679M1dIBaasZ7DX5voqXtoo6ZzlUKFUU0B7xqP3ETjIqvBPuYHL8gikm8Bg6e+iaRZ0DwVjpg3zn8j9qu+HIHxKU5Kl/ukgoNFKM+5Aj2xGIQOprSPNxxoY+xkJ9gJ+Nd+T7JNy3RQ5+rx11ZmaVjuQOw2Xhq0rGPIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7lE1HtM; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43df2c8eeb1so35895741cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 01:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715847619; x=1716452419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bxieYVWOri+L67S4ctIpMGuDcf+jYQE9H2hDYqlsHUU=;
        b=h7lE1HtMuNf/fc+AFDVCU6evQ3UeSqWa0eOQWzNVxCrisJmuVWZ7RjOF/IXD3ubnFt
         8rRD8NFGHPaLGSB67ZtONnWv13bC1isRx35ZOJcjws8gra7wXzE8+AJhGBBcNE9rWrnI
         S17rW4Lw16udFUjOHUwH8piSEjJp58gL6OoU7bxXVZXGmJXNAD5xx6/LOGrHKSmTAOJV
         vUd6cm8etER7deUtl1bbQrbfNRXSlrKGmgiM4/MDJ8LJJsPmAd4z2rYEfUOy3PKoLyz1
         iwkbkcRPKcg6/SMM4Fa0g+Z8co0v2cO0KhtRGCT7JM2LuSy6DkG3ikk3ueQuj1hqiHma
         5BCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715847619; x=1716452419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxieYVWOri+L67S4ctIpMGuDcf+jYQE9H2hDYqlsHUU=;
        b=ihl5pnCX8O/+XXzLiktQbav7JQswf1u72v39yWdFrYHy1tXlUjk35G0aEAUL20PYMv
         HTc6gC6QxBuwTtw6WFvVbPlyrdflGo+yMa+Iotp23CFfhn7rkLzmCBHosEaOqWZCUdZY
         6uip3yp+75u/v5dj3xSf+PqQtc3v6AlhC9Pv1t8aAL+v/3MWvoGwb/e75gH+d13IascQ
         5GXVkoZ9jAgnWlU/jlg4jcEg770LYuV23uN9wWLyQQ49jIUV9IRCa3KXQGkjFzJ3a6X0
         SxT31/lv6QGEv5LtZKQMqb0xFsRv7TTrOwS80DVghEowwk8a/xKI1GO05ylk//SdbN1O
         00tg==
X-Forwarded-Encrypted: i=1; AJvYcCVrzkhgVegYUvpQHVNrw7T2SN7Hrsd687bfvIDgkU7P7brdrpFYZNBX94czNrv7X6K1qzjq9+RUjNPJ3dnMFwKKUcL1x9vWAfWVsedS
X-Gm-Message-State: AOJu0Yw/J1PpxFrw8vXfYxnQ1n9c4bo8t6k+kY/IRUQSdk+SfQVXLTZK
	Ej9uaBcSFQXgG3gRdQ350saZ+6LSHyWzoumT0L1IX1QiQh4522ON0AciC+VyIi/nzpRG/rZp4LI
	EwTIQYZerVMhrowdZwW6F7wyZu20=
X-Google-Smtp-Source: AGHT+IE673mret8o5rbuKFPAoBmhQ1JpenVJ/MBGpmbELfPKWgA7z5WOxZ4SwhfbRU7JIyRf4nGx4cSNgVnw3n3oiL8=
X-Received: by 2002:a05:622a:4b0b:b0:43d:d8e3:3322 with SMTP id
 d75a77b69052e-43dfdb26c76mr235568021cf.38.1715847619433; Thu, 16 May 2024
 01:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508172621.30069-1-ppbuk5246@gmail.com> <20240509092931.35209-2-ppbuk5246@gmail.com>
 <ZkU8lm2tjm_r9FpZ@pavilion.home> <20240516075628.GC22557@noisy.programming.kicks-ass.net>
In-Reply-To: <20240516075628.GC22557@noisy.programming.kicks-ass.net>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Thu, 16 May 2024 09:20:08 +0100
Message-ID: <CAM7-yPRHp3tiZjuBTesdRQoU8WJNg1scon_txS_6R-pZq9MXHw@mail.gmail.com>
Subject: Re: [PATCH v4] time/tick-sched: idle load balancing when nohz_full
 cpu becomes idle.
To: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Vineeth Pillai <vineeth@bitbyteword.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, anna-maria@linutronix.de, mingo@kernel.org, 
	tglx@linutronix.de, Markus.Elfring@web.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> None of that HK nonsense is relevant. The NOHZ_FULL nonsense implies
> single CPU partitions, and *that* should be avoiding any and all
> load-balancing.

Do you mean.. tick_nohz_full cpu (non-HK-ticked cpu) shouldn't belong
to any sched_domain?


>
> If there still is, that's a bug, but that's not related to HK goo.
>
> As such, I don't think the HK_TYPE_SCHED check in
> nohz_balance_enter_idle() actually makes sense, the on_null_omain()
> check a little below that should already take care of things, no?

IIUC,
currently, whether cpu belongs on domain or null is determined by
HK_DOMAIN_FLAGS
However, when "nohz_full=" is used, it still on HK_DOMAIN, so it
belongs to sched_domain
so, it couldn't be filtered out by on_null_domain().

unless "isolcpus=domain" or "isolcpus={cpu_list}", it's on null domain.
with "isolcpus=tick", it participates sched_domain.


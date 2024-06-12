Return-Path: <linux-kernel+bounces-211005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AB2904BEC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588481F213F2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19903168C16;
	Wed, 12 Jun 2024 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Fg9jqOav"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B964167270
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718174958; cv=none; b=ZRZYX32lVcyFTsJySIRpOAmZO/uTihd305mUqiORe42YN+r5d/VEc1E2gIihdsgMFXEvATWyVMgwexlWrKih7aeL1EbBUdEgDebaOBACyJkqJEux2mzoJMM8RbmUr2IBSyweJeV/VJFvef4i3AxfgCUiTTAjZJDp/8DRimtMfw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718174958; c=relaxed/simple;
	bh=O9z0/04Tq+ZkFyczZntOIrucurtZxJV5B+NC3qQbK/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTU4aG8pxoo23Gi6uHwZmOd1vM3Mm0gA9W62S6NcWSlb85nvDwhMc7xc+1tW/rvAuBEtPoXjsJ3AP/RlQmkrjh4G7QwyS/P+ZTzCk8rfba43gVTAcQTlyo2a0C8AvDRvXEbBca8cpLy8kKnLVUm95BbN/09v8JaYPGKWQ77Bb20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Fg9jqOav; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6f0dc80ab9so251963866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 23:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1718174954; x=1718779754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9z0/04Tq+ZkFyczZntOIrucurtZxJV5B+NC3qQbK/E=;
        b=Fg9jqOavegl2y4kBVjszt0XjdFLGt/UMqSyNX1hxcA5ByLvYG6RynCb5XV/7n2gDy/
         rDQ1u7XTU2zL1zgHC25zRafnwaiPiODrWYE4w/sq/Sbdf9RX1IaTf6aAQRiJmC/5ZcLM
         E0TgavBbGOhwINlyKzm1i8hFnwKNeZ2A2JCxM13r8idp7+n/Ly0mDm4T6GOQZIQUe1Zi
         /n14Bw8UgaW/x7TsLlIUV5RZchfdun5WkylOdcLNfEN+/8aGCg73OjrymZnA0rNtLGZM
         ngBBCwGxmLCCZ12agteIuNKwkmLMbewcy7V1uEgArqdhi4m34MedtrbmxwZHJ0e56+g9
         HjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718174954; x=1718779754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9z0/04Tq+ZkFyczZntOIrucurtZxJV5B+NC3qQbK/E=;
        b=bnV5x6O+hsiFTc7q8dIhxnOno91NAtJseSXCzW6mIKjFCbJRAj233b6cppSNkhPLqF
         Cb2ngXTISVtzU7lYUCecEfa8TyWyotCBReiO7cxQtEdCtD/ZlcF4eVSxDoz7aUZ29qkD
         bPlSd7GPKafVxN91JJQdrk/5Rnira4RXkqqMrYcqH7c1mm8xTC43XHtaDBVDvNmApIeV
         +j0g6xx4PrSnkTLhkj01TeOAbyE2MUZTBCWKq4lL6NLGqxf5RHpJIcX3O8m4ZGN4y4TX
         aU2Y2BqfkqkTWIT8pV/6/9IVnbdRm92tD3NdvIxQe4mzu/QfNpEZ/8vTBDlyZ/6jr36G
         WDGw==
X-Forwarded-Encrypted: i=1; AJvYcCU//AWwDM+ngAZMBGVy7q0B8FRyYiChi36SPSUOffSqYnrnXl3vK7oHiyIUdjw5lbuvghkBA2HzDbV/+bBHAApwDkZ+UKDlUitnemv1
X-Gm-Message-State: AOJu0YwhA1aPlWGGrdF4r/mkz9d5RsJr49c8clfuac0/7enBoKE20O95
	plc/RVwQwxLUoOdtrELjK2iE6iPyXm5qjZiDsyn2W1eu7Wgfqv1xIMaesFvXMnp5QdKPawr5kl3
	lvrUf/stuzUh1JeBK5iQ9HYTqvIBATryfyZrqCw==
X-Google-Smtp-Source: AGHT+IG6fAFvnFy8XQ0wkplSAJt7xtYjAzW657mGoRwkIx0lGxvTO4hZpm3h98goZ8UfQ5xbL5ohfLT20oGSuwlotUY=
X-Received: by 2002:a17:907:38c:b0:a6a:b1c7:ff33 with SMTP id
 a640c23a62f3a-a6f47c7d83cmr48980566b.8.1718174953644; Tue, 11 Jun 2024
 23:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+8cD2CBcaerhwC0i7e0O4LU9oQg1w3J5RsV6qcZMEr2Uw@mail.gmail.com>
 <CAJuCfpGa55gpKHBE_0mwRPsf0f1Wp5UK7+w6N7yZi-7v31vNzw@mail.gmail.com>
In-Reply-To: <CAJuCfpGa55gpKHBE_0mwRPsf0f1Wp5UK7+w6N7yZi-7v31vNzw@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 12 Jun 2024 08:49:02 +0200
Message-ID: <CAKPOu+9vcAK3ZxB783j5u1MR0YB9WLWjUBGoujZ7+=GZisRh7A@mail.gmail.com>
Subject: Re: Bad psi_group_cpu.tasks[NR_MEMSTALL] counter
To: Suren Baghdasaryan <surenb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 7:01=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
> Instead I think what might be happening is that the task is terminated
> while it's in memstall.

How is it possible to terminate a task that's in memstall?
This must be between psi_memstall_enter() and psi_memstall_leave(),
but I had already checked all the callers and found nothing
suspicious; no obvious way to escape the section without
psi_memstall_leave(). In my understanding, it's impossible to
terminate a task that's currently stuck in the kernel. First, it needs
to leave the kernel and go back to userspace, doesn't it?

> I think if your theory was
> correct and psi_task_change() was called while task's cgroup is
> destroyed then task_psi_group() would have returned an invalid pointer
> and we would crash once that value is dereferenced.

I was thinking of something slightly different; something about the
cgroup being deleted or a task being terminated and the bookkeeping of
the PSI flags getting wrong, maybe some data race. I found the whole
PSI code with per-task flags, per-cpu per-cgroup counters and flags
somewhat obscure (but somebody else's code is always obscure, of
course); I thought there was a lot of potential for mistakes with the
bookkeeping, but I found nothing specific.

Anyway, thanks for looking into this - I hope we can get a grip on
this issue, as it's preventing me from using PSI values for actual
process management; the servers that go into this state will always
appear overloaded and that would lead to killing all the workload
processes forever.

Max


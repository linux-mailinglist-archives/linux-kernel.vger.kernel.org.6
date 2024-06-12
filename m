Return-Path: <linux-kernel+bounces-211343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECC1905050
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333FB1C2156D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D01D16EBE6;
	Wed, 12 Jun 2024 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XdJT8XQI"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F3033FE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718187634; cv=none; b=Y8aT9vh7PT5eujzThyytr9bwIlpoGR8mQC+8ojL2sbhBLu5rwSMn2l5b7EJKETF4of16SyPHHhtCaCPp/gr+rgadEkzujdy9spBDlV/62y84jMheXhzwr6UordyygR7iDxAfPzCpIZh2Aasy8ewXwxNPSWfLLK9v+evahxwtpXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718187634; c=relaxed/simple;
	bh=rAVclXOSQHliTbsOcE+ZdvLdxoXr1ZKxsFl95sESZiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYUCBCCyZqjoaBTMIKOos31qtpWqJCzYRbT3WjnzFKGxezGPChiUwDbOZQdXZtqlneZDaisaKZG8L42FDHmrstqmtOZ+foCBmoAbxhhjj8dBIYr4FSMIGRAlX0zv7xwctjeNQzX35LFv4bFVLohRbC4cI+GFbWgNeHMH/Pdg1y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XdJT8XQI; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a68b41ef3f6so763801166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1718187630; x=1718792430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAVclXOSQHliTbsOcE+ZdvLdxoXr1ZKxsFl95sESZiA=;
        b=XdJT8XQIDbIwY5Ls+AFh9FcQW6kqdvq9EnbIvOUdPGBadA/rl+EpWJowYlWR3nAPwz
         ykOG8648plsK/d++Q45//M98oay01LaewClnHVxxJMREeSKz5450bZi3Vhj0A8IaXTQQ
         nHjmZuUY9VvR9tz3hiPokMUf6dsLeNKsNxVFDJ1aGpZmYrCwQrCQJJrAR2FaL6GzcgNR
         Zh69K/qQEmKAgfjeTcAPhN5C7dU6FzlOtWrxDG0omxXbuDN5hcOYy8v6AWgpsBxVFzkI
         +QL/CP0GOejCtvzTwFYTJazzBtY+F0JoKo70deK/CkhOLwwCCRS3S5ogXp2O7klrRV/b
         t5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718187630; x=1718792430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAVclXOSQHliTbsOcE+ZdvLdxoXr1ZKxsFl95sESZiA=;
        b=kqB0jA5opyMcdd/NoX0cb4oEt5k8gSFdXnDSITT+7O4E+rtbEvHD2/zvK8i7W/mZV5
         z9+0AUma5oeObClFpGWIvKBF0MUHWSboPU2ouMhhiEeqM78MQhQlPpZVgxD6DH4/Mz5O
         g39MPVmDeaVzrx5m9WoerFAriSmSl2I9EHTLAtOO2rWW0p9Hs8Hfoi4Wg5dFol/8jzGW
         jjiYMmxEIFFyjEusd0FywUjNXRe8W5SLNPi/Zviw8FEjbfjQ6kDz9bWQ//ybKhdPHMuw
         4ZSZs87fP+KIFeSmaYLKRz5U968ikSOAH644GvxEYOyQGYweRsmr/7318CpaysDCk0I9
         pXnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdZIp4vY/VbMStQ7MKX0uqnS8h5KNE6dB1zbwCaIa+4BS1cd2CZ8Eug/cXGzfkg5kszM+0JmN6RWaTgGcGE26YQSKCKl1ltqhBl+n8
X-Gm-Message-State: AOJu0Ywg9wkX+DI5/NoHgi/1tRG/NvTUL0/OwRUHyKTSoDMrgzLWLCbA
	oqcoXz/TbSidyjKcDn33akcYFs5FiYdVKdCLvx4kU9tatGwfVPGbalWGh05lBzWH3NsZf3nS9XQ
	dAUuU/v45oBRP2C98SytOdsgg2/w12SuJ6V2W80Dj2SWS1DuCy7A=
X-Google-Smtp-Source: AGHT+IGdSXzeE4UEDaswyECjX149Cpxbw+EBGd/ZZ/ghcSC3jDTCj8Q8ciZE5cTfFErsdBTDBmK9ndWV/wa+jWGZJ2U=
X-Received: by 2002:a17:907:7e96:b0:a6f:3395:5d20 with SMTP id
 a640c23a62f3a-a6f47f71a37mr101609066b.37.1718187629717; Wed, 12 Jun 2024
 03:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+8cD2CBcaerhwC0i7e0O4LU9oQg1w3J5RsV6qcZMEr2Uw@mail.gmail.com>
 <CAJuCfpGa55gpKHBE_0mwRPsf0f1Wp5UK7+w6N7yZi-7v31vNzw@mail.gmail.com>
 <CAKPOu+9vcAK3ZxB783j5u1MR0YB9WLWjUBGoujZ7+=GZisRh7A@mail.gmail.com> <20240612094856.GV40213@noisy.programming.kicks-ass.net>
In-Reply-To: <20240612094856.GV40213@noisy.programming.kicks-ass.net>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 12 Jun 2024 12:20:18 +0200
Message-ID: <CAKPOu+-X8P8WdSEcTX_EVgA9wiMdSdXdzA58Z5vvkQKc+Oz-PQ@mail.gmail.com>
Subject: Re: Bad psi_group_cpu.tasks[NR_MEMSTALL] counter
To: Peter Zijlstra <peterz@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 11:49=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
> The erofs one is also not entirely obvious, but irrelevant if you're not =
using
> it... the below should make it a little more obvious, but what do I know.

We do use erofs a lot, and I read that very function the other day -
it is weird code with two loop levels plus continue and even goto; but
I thought it was okay. psi_memstall_enter() is only ever called if
bio!=3DNULL, and the function takes care to call psi_memstall_leave()
when NULLing bio. Therefore I think your patch is not necessary (but
adds a tiny bit of overhead). What do I miss?

> Best case would be if you could somehow find a reproducer, but
> I realize this might be tricky.

Oh, I wish. I tried for several days, adding artificial delays
everywhere, in order to make some race more likely; I created and
deleted millions of cgroups and killed just as many processes under
(artificial) memory pressure, but nothing.

Max


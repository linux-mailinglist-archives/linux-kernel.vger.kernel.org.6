Return-Path: <linux-kernel+bounces-380726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 064C39AF52A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56B11F2258D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3B5217338;
	Thu, 24 Oct 2024 22:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="puzt1NCF"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAA322B66F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 22:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729808178; cv=none; b=oUkaNup54/2ZKOOKRext9WBWzVMuofRN/xR3KJd0cZumPw9EVUXsHg0eKpWdRPpAovi8I0S+tDs0M5bdUEmwMZGOHl+zgJA8xyLhSUYKdGH9BSH1n7CHypSK2gaeX6R+sSiHeh5uZUsWWoPPF2+uIr1GyprDU8iaN5E9Z7pgNtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729808178; c=relaxed/simple;
	bh=Qk4fOV5dJ/Za8lYsM3ENTXwHw6sWnjlFtQNYNPQmcqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rAGjuCL+pY3XkJO0tXGGcDUyUWNRmYQEubIBn2zBU9iGF2a7IpdeY3OnFXvoYq7eWrnUpYgTU43Xz+8pb+qVKyJhrkEeZLABYpch0e9PHo6V74DzfYNE9o2oTmxteQbu7N4li0WSSH2pYGeURklOgvrG2zU1z71i/k9jJurmRdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=puzt1NCF; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a99f646ff1bso179394566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729808175; x=1730412975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aanE2TqJaugufsMYdVo7dhs7leISWi845GKqhPBK8o4=;
        b=puzt1NCFdN7y6SZGduZox93/Xvq2QxcHh0ggLOABbhjtcUF4pRvGuJmFAEpdUEU1WN
         OL7S0xIkk7PxF1r6vKovRJw5zG/bREN84MIX/2ZNkOkqalkOdpRtPMNskBIQJDdibTVl
         qQR5Q9xGTks4cJ9marVVR5Jn9UZ5+vUNosNOREjEfCAhitizyiBrjwHShRZncZZOOapq
         G4saqfpJDAAFwXOaqtjRfuQv7gn3hAoam89vWGgYUPYLg+SAny48LvPZU+HibprU/5o8
         3cZx3eFiTdWZt85Tl7MrLshh2r5XRkuJKKxUgbrEUHOJemGhanq4nckpmfKcEkDYXrV4
         Zq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729808175; x=1730412975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aanE2TqJaugufsMYdVo7dhs7leISWi845GKqhPBK8o4=;
        b=FJ4K7G66ViISu1M76j/oyQN5nGyYM7C3bctHrZftx3gMWnTQNuaAjyrUs/iyvPclBz
         wMFH4F2hAlTRQ5B53kUUwicqytgIuelcEufX3+2KR1hb2CZ9K0HTv7pOsVc4qaUlpcBu
         tFs88XNFuef4g9UqklwsAG0A2Kh6LltAGdMBusa4FerhHSsuWcM6mJt3ik15DgjNzRte
         3fcWbhgjK1UGsISo6ShI1UjelVM0XIflYOMApFBgt8E+BglTpvCa0Kp0uKOZmwtANc3Y
         SzRuYI0tZz0K4UZHsmf1kKnZgOMT6py9dQ+ROI/G4/SbiUChkA8bFyYF8QvwVoVuWBUA
         QugQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLevfVA6CBwRrx6Pi/Xt5rEaVVpO9zGWrFXBj2NoMw+b1bHTLiNUUuOdg9ylvQgQ7RGBi6rXO7gH7p3js=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOM5jz7JRxuJ56N6YQRTo/qhbloOhL0Hpe8fiahN/rYyEH/TOq
	uUnOjwYdGKuhW6bli4ZGjB6gb89WoPuCLY+CvBoA1LSNWyrw/P2/8DcZwucelNgaBnoAmInKZHq
	yaDANNM1gjziCI05Qz8z/RT7witMD0/PsGrg=
X-Google-Smtp-Source: AGHT+IFjmT7UzKwsmIW/o87yHLGAckkmwRkVp9fVXpelmncgZ3R8xd5zXFCtnl0sLsanS1V8WCa92Alm0aKj07++Pu4=
X-Received: by 2002:a17:906:dc91:b0:a9a:3cc6:f14c with SMTP id
 a640c23a62f3a-a9abf92d244mr732909566b.48.1729808173437; Thu, 24 Oct 2024
 15:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-19-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-19-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 15:16:02 -0700
Message-ID: <CANDhNCpy_A2VtFoXFp2EzVQA92fTQgksxE8Y=nF0FVLeeaTJ9Q@mail.gmail.com>
Subject: Re: [PATCH v2 19/25] timekeeping: Rework timekeeping_init() to use shadow_timekeeper
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:29=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> For timekeeping_init() the sequence count write held time is not relevant
> and it could keep working on the real timekeeper, but there is no reason =
to
> make it different from other timekeeper updates.
>
> Convert it to operate on the shadow timekeeper.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/timekeeping.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 6d21e9bf5c35..bb225534fee1 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1778,7 +1778,7 @@ static bool persistent_clock_exists;
>  void __init timekeeping_init(void)
>  {
>         struct timespec64 wall_time, boot_offset, wall_to_mono;
> -       struct timekeeper *tk =3D &tk_core.timekeeper;
> +       struct timekeeper *tk =3D &tk_core.shadow_timekeeper;

Same nit as earlier, otherwise
Acked-by: John Stultz <jstultz@google.com>


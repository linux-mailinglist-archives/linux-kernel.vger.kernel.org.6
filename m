Return-Path: <linux-kernel+bounces-380705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BD99AF4C5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B3028282D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DA9216A38;
	Thu, 24 Oct 2024 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mihKTFKJ"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFF81B2188
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729806213; cv=none; b=LRKFLzLF5ZCPVtduNnR0/JQcKbPywIQFEoyvkMaD/MOszbrkIXIgYJ8yZd+lcDbfJHqUhN1XuFZBuk88pETjcxbjwwFISol/TcS2wWuoYl+hHvizATXevVjVkne+ExyWNSYHz9AGHpn9//dISiE93uwuKKJFJ6lfbyLFTUDoBkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729806213; c=relaxed/simple;
	bh=Ou3/GaiFLYKzPMyV+4cPIznIN0mWR2rrjRvzqDHBrSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+vRcEaZaLpiHdW1iFFvqIOs6/E6Zfq5ytu57nQcalxpZMk23lE0uaQx3E8P5Z6HsgzrRF4Jcd08n05eVeZxLuFpKqKHOgTvwKpAwTEuSuNsNatkAyCPHBG+IpGFfSy9qSMoVDFDXLf8ixJc+HBfg+LvfcTHFXwjK/qwh8AZZVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mihKTFKJ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so21793511fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729806209; x=1730411009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ou3/GaiFLYKzPMyV+4cPIznIN0mWR2rrjRvzqDHBrSs=;
        b=mihKTFKJvOlwKgrYE7VG2Syc1qycmaoHSu61cSIcV6EkP+tlAc6brWkqT7uc7cve3F
         ti9VVTVf5HfEs6udW3pFfXK2IZkX4gvpQzeu5jhkdmHUoqsjTYQ78tXHp/faKs3gswf9
         kubPNYnXmudD7pSl/YbQ8EnclpGy9f6arpBUPxjnxdCHo38GaEJDRmwvZOGOGMdhmxsG
         XFYrDT5SkLKhjfdwu9y9sZQQExS7YNOL2JX1ImZ+9QQUkmJ0Y2gi6dPLsSeb0G2D6jIF
         tyFbohENC27o0Uuc7f5KQcxxUii3BGraP6QnW8bUU3KYZUS81HIoZnLA/wP5mIOE6aVL
         bF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729806209; x=1730411009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ou3/GaiFLYKzPMyV+4cPIznIN0mWR2rrjRvzqDHBrSs=;
        b=ZqEtv19g1yGn4kYB3wt1ZhFegW7gn5SynTErw+bix2ErfXB3vhuImeKfBEbgK31vRT
         DrESRWf/R07t+4rChbB8LeXACUdmsw5CIBg+rvh906CBWktr0cB2qQ898Y31KMxb+e6P
         fzq7zNnlZ1MR4X9WPf6ht2uIS5wfiBLXj4bP56qokIwnGGw/HDKf+4C9O9eZDuW//R/i
         CmAwbfsQXd0rjrzmrpDuYhvEPvciwGQKpcDG9BK6qmVszOn9ud/MQBeJ7mq0sUQLHLKj
         fpsEAYGuegXVC2iQimETf01Q0YvqpRCu+yqF5AOYlZkaxYwwXdcZIKAL6lUfH407Ugbf
         In1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrr22x9DQl28uZlK/z5JIwPE7Jn+7JxPoZkGOjfYGfN3WK3NAaNi0TqS6jWdpHPlRUAPXb5djQVDGE+QI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ZjaryFDaqt2Um9KGXHiEwCvyMfr/TJe31H6mfS3bE9/XFWaU
	bAMBgSkVi5Kc7O17X912squRoDRUZix25Bx2XP45o4FVHZxLII6sEEvGVApIAIJp0/KETdAaHag
	GvWeTmG/WNsSMaRTiuM8yFz1NGxp6qjNMYYU=
X-Google-Smtp-Source: AGHT+IFWeLtqmN8ZcgGfN2kk1uX0Kj8LQtzKpabyI4FcL0WKt8e/QOcReI2SWyr5yVvPpJFDkkegoXJvDdTXZSLcPyE=
X-Received: by 2002:a2e:a547:0:b0:2fb:5014:aad4 with SMTP id
 38308e7fff4ca-2fc9d2e54d5mr71283791fa.9.1729806208888; Thu, 24 Oct 2024
 14:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-13-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-13-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 14:43:17 -0700
Message-ID: <CANDhNCrSE+i_06jAMFa56d8avW84F7n_Kms6LrxGjOAVjZqS=Q@mail.gmail.com>
Subject: Re: [PATCH v2 13/25] timekeeping: Split out timekeeper update of timekeeping_advanced()
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
> timekeeping_advance() is the only optimized function which uses
> shadow_timekeeper for updating the real timekeeper to keep the sequence
> counter protected region as small as possible.
>
> To be able to transform timekeeper updates in other functions to use the
> same logic, split out functionality into a separate function
> timekeeper_update_staged().
>
> While at it, document the reason why the sequence counter must be write
> held over the call to timekeeping_update() and the copying to the real
> timekeeper and why using a pointer based update is suboptimal.
>
> No functional change.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>


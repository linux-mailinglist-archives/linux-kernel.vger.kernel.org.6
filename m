Return-Path: <linux-kernel+bounces-421488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 048069D8BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD369284898
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFA81B86F6;
	Mon, 25 Nov 2024 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fdwy0Rt/"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CD91B3952
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732558115; cv=none; b=rhR9WP6O6zg40mC/gPRGY8cwKoUarczqmJ1LThXPmlge05hrttBS2lRql/qJJ2YrXZZSfgrx5okxJXur5GEuQkTKJzLjuhr/hYo5GeWoIFiYrngE88QV3ulWPBje2dg0moRambbg8YLRYQa9Cm4HSGa078L0xvVdK4VfhYT+d3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732558115; c=relaxed/simple;
	bh=f/8NwLKDNGwA4BBNxjludT6JeLJQpYXupFh0WKIWdEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7ElFk/MAPRzBKy8/e4ao+ETNNQGrHFLCX3zRuW9ChL+U8VKLrpClp6CUfcfQvGNRfvaUCSXt1BKkySl7SPE8xrqtgWnGDzn9/cL4CvaviGf4FpkSfCmqOWvweQhySDng77uXg6d3aabQNLXjAs1D0DWfTPKQ7EJ0LuzqRvZRi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fdwy0Rt/; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cfd3a7e377so6406391a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732558112; x=1733162912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/8NwLKDNGwA4BBNxjludT6JeLJQpYXupFh0WKIWdEA=;
        b=Fdwy0Rt/VHlqgQ0xl07X/D3HQqb15N43TZn9J8LhVyQwlhspRXvcAqme9SzgiKgX/j
         Msyflet/kAp/RTl1Y0r4MZ/Xf8ZnBhb5EVQ7Gg4IHHm2hP41wl8RA2rzfolCGfIY0/WC
         NaCw1YL4Kpam7q4fCrValZM5YTM0eRy5dvEM72dFRkFjaXyCYxin1jS/saNht61Gb1TR
         syAi/+GhoGIi18aeYFr8soAoXKfmjhJwnziXmoHIR5m/YLx50TPC9aR4Ecq4D7dpe2Ib
         4YqEpXlk/0ZeY7di5Ddx8PSAokd+3dR5/bVJUG+jIzKeI0Zvo6e/sOrOp2PCVxnA3Nsa
         8ShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732558112; x=1733162912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/8NwLKDNGwA4BBNxjludT6JeLJQpYXupFh0WKIWdEA=;
        b=O314f0AZtY+nH7FCafbu2a1Ja8cUWmA8LOwzrZz5fgFo1MAOy8VxJOqbiIta1aeWUy
         KDv88z+33iRi11fOQL7+D69+04ahPaUwGqTKLhbQGU0s4lBUYDKfF5oCkEGLnfjJIU5b
         UAhhFABdFm3x6vGtARNLkX3Xzolhxznnyw7CNb1wdnpInNuStB13Q0+JJHjWyl7Zz8WP
         UCf926G8z6N3Z2u0rHJlAVW/fHUW7KN31/BmMizklkTuerdwWDCoLcEcT0QpoZsOdECO
         qQhvbyS8vnZCwr3ckOrpC7ken0VqlfkCO8X+Y3uGai9yBU+OieGMkYH/i7vtTXWJtTrn
         bzwA==
X-Forwarded-Encrypted: i=1; AJvYcCUYiyJRHlN2svU1/j19Q/ZdhsuuCKpu3EKGy2VycAe+7VxwRBlLagHuOIC6RYbfQgWbeBS23UioqwMBYEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA0jgxEkOyunhaw1GqDyOp4IbB5he3gKqjJ/+pHZ0pQEqwbnoL
	aszpo2ZQUjW4heFtwHdhEF2ceCrg+U4IQftLzLHH+h6oHEEdCa28mpo9jUHwpZ22WDzshKlcHBj
	bpWZOVNG9RrRBjf2HM3pQClmxWDOUmUPRXMNH
X-Gm-Gg: ASbGnct+26ZlL0NAAwfbOeRlrccSOYXZIDdxldIldFBslkUmLmNRS6WCq1Avbj+Tyv0
	WcqZ+PRfjgmEwLU16y5fp9THXppf5nVI=
X-Google-Smtp-Source: AGHT+IHKMdoCdYVLYstvTLbkIH5an+q5VLUZCM0/VpgrdnIYU/0qaxzK96Z5d9X4Yfsfb2kU+0cF1c0TftMw/R/GZ4w=
X-Received: by 2002:a05:6402:1e93:b0:5cf:de89:9364 with SMTP id
 4fb4d7f45d1cf-5d0205f4b61mr11330079a12.10.1732558112236; Mon, 25 Nov 2024
 10:08:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJ7uOuDCzErfeymGuyaP9ECqjFK5ZF9o3cuvR3+VLWfFg@mail.gmail.com>
 <20241125174608.1484356-1-martin.ottens@fau.de>
In-Reply-To: <20241125174608.1484356-1-martin.ottens@fau.de>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 25 Nov 2024 19:08:21 +0100
Message-ID: <CANn89iLeSEVDZv-Nx6RGghSJdpozBAdoU==VQLgH5v+Puc=i0w@mail.gmail.com>
Subject: Re: [PATCH v2] net/sched: tbf: correct backlog statistic for GSO packets
To: Martin Ottens <martin.ottens@fau.de>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"open list:TC subsystem" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 6:46=E2=80=AFPM Martin Ottens <martin.ottens@fau.de=
> wrote:
>
> When the length of a GSO packet in the tbf qdisc is larger than the burst
> size configured the packet will be segmented by the tbf_segment function.
> Whenever this function is used to enqueue SKBs, the backlog statistic of
> the tbf is not increased correctly. This can lead to underflows of the
> 'backlog' byte-statistic value when these packets are dequeued from tbf.
>
> Reproduce the bug:
> Ensure that the sender machine has GSO enabled. Configured the tbf on
> the outgoing interface of the machine as follows (burstsize =3D 1 MTU):
> $ tc qdisc add dev <oif> root handle 1: tbf rate 50Mbit burst 1514 latenc=
y 50ms
>
> Send bulk TCP traffic out via this interface, e.g., by running an iPerf3
> client on this machine. Check the qdisc statistics:
> $ tc -s qdisc show dev <oif>
>
> The 'backlog' byte-statistic has incorrect values while traffic is
> transferred, e.g., high values due to u32 underflows. When the transfer
> is stopped, the value is !=3D 0, which should never happen.
>
> This patch fixes this bug by updating the statistics correctly, even if
> single SKBs of a GSO SKB cannot be enqueued.
>
> Fixes: e43ac79a4bc6 ("sch_tbf: segment too big GSO packets")
> Signed-off-by: Martin Ottens <martin.ottens@fau.de>

This seems fine, please note we ask for a 24 hours delay between each
version, to let other reviewers chime in.

Reviewed-by: Eric Dumazet <edumazet@google.com>

Can you also take a look at net/sched/sch_taprio.c, it seems the bug
has been copy/pasted there as well.


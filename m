Return-Path: <linux-kernel+bounces-437663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF51E9E968B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E6228354D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE77233131;
	Mon,  9 Dec 2024 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEFRLIzR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC9A233125;
	Mon,  9 Dec 2024 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750435; cv=none; b=OUGllHLhmMp5FakTHertBnpyQ32jII92KLx2+HX6JGAy13GTGhHHenGAXf/4FWevQzC/VY0By6uAfSJ3bj0q17hXtiHUP13avB5G/avXSMshZsaC+P7hmdhRI6GGQEb0sbZ5FJMGpg67YQ8jivEOGzl+nQkjUgymEub7WV0jKzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750435; c=relaxed/simple;
	bh=XFMTEb8QfCMbI/gZoAO1uuLBFD648TeW70GHUbaw66c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QiQjRPjCmCCNLz0RaQqGIi79rYRyBbG69y8XMojX0sYOMQ5XigWeoxlyOchXGdseDXfnwcFEpE7bAzvyMpsYmoygxyAtpX38vi07pghZuoAtAEhH2M8XvaYtbdJriPsss0RuGXReH4AaUkBKy32Gp7j/qK/auJUhwC7pZBhF/CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEFRLIzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F799C4CEE0;
	Mon,  9 Dec 2024 13:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733750435;
	bh=XFMTEb8QfCMbI/gZoAO1uuLBFD648TeW70GHUbaw66c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UEFRLIzRl31qUfwO97NjaRgLWxjbqTr12B+u6HFfN6FnVegjNmAnOhIGuQEVoxadL
	 1JZMU+FFX5TW8J1FE/aDdtwGrJ9rLD6Sm1ytwPxz80wJ3XtWl8ix80V70zWF8+YZN5
	 g5YkTLBEHvPd8SB00vMLhEeNdtaXDm7PZrFtOAH/h4SaD3QsZxYFHxhV6dN1FCFALh
	 xEv4uipJMScpx6hg6X7IuSh4yHQiT8t5vpnYnDbP0nzXOotZlsKwkb9XYqp6aV5dEn
	 j1r3CCVjHWvPEcR584N9C2irQ9P0WZQk9FZa+yqkP73GJfHSVJSKyUBpdSB+JteKLU
	 Cc2KR/Otm4YyA==
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e398823d6aaso5021976276.0;
        Mon, 09 Dec 2024 05:20:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVUwqoyYNqhtKrts6lFPTN+jVc9tYH+9WpsDsBQtAKWjgpLRWVj0/8biJVXoqomRdLQvRHfCmmK0HTI@vger.kernel.org, AJvYcCVhx6rJQadC363/Du2NFh8xYoON40ml6/rCvkn8vGW3DuSr5Yd/UV27SRmFYUJGLc3AbjoD+hqTMO6ToRsk@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt138+aDg2oUcYoIcDwcyGPPwbbFJmdV1V0v6ErafcDhKDs9Hs
	+lmOJOcZhTBhdcqVLSd9J/4vbsSq2sBx/SMbarW63YyLI88TM0UONJcwexNAdF6gX7fGnqXCrLc
	hsatKlvHffwLLott4sfMp72l1GA==
X-Google-Smtp-Source: AGHT+IEXAhNVQ7c1s7Q5Gt/9ACLNzysGwHEAdMPMVXV0mvjexywlU78YQyDTyMQDt8Sh1Y9VGQC5TU1xIwEw6L+BXyw=
X-Received: by 2002:a05:6902:1542:b0:e38:b460:e0e6 with SMTP id
 3f1490d57ef6-e3a0a59ee3cmr11408089276.0.1733750434296; Mon, 09 Dec 2024
 05:20:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com> <20241206-of_core_fix-v1-7-dc28ed56bec3@quicinc.com>
In-Reply-To: <20241206-of_core_fix-v1-7-dc28ed56bec3@quicinc.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 9 Dec 2024 07:20:23 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+140YAXAtxmb4FPdk2C2EZSJ-9AjOz5ik6jK4oHLOdDg@mail.gmail.com>
Message-ID: <CAL_Jsq+140YAXAtxmb4FPdk2C2EZSJ-9AjOz5ik6jK4oHLOdDg@mail.gmail.com>
Subject: Re: [PATCH 07/10] of: Correct comments for of_alias_scan()
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Saravana Kannan <saravanak@google.com>, Leif Lindholm <leif.lindholm@linaro.org>, 
	Stephen Boyd <stephen.boyd@linaro.org>, Maxime Ripard <mripard@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Grant Likely <grant.likely@secretlab.ca>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 6:53=E2=80=AFPM Zijun Hu <zijun_hu@icloud.com> wrote=
:
>
> From: Zijun Hu <quic_zijuhu@quicinc.com>
>
> Correct of_alias_scan() comments by:
>
> - Replace /* with /** to start comments since it is not a API.

But it is because it's in of.h. However, you are correct in that it
has no external callers. So please move the declaration to
of_private.h.

> - Delete return value descriptions since it is a void function.
>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/of/base.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 1c62cda4ebcd9e3dc5f91d10fa68f975226693dd..33abb6227468c03fd191201aa=
2bbe05a41fdd9f4 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1812,14 +1812,13 @@ static void of_alias_add(struct alias_prop *ap, s=
truct device_node *np,
>                  ap->alias, ap->stem, ap->id, np);
>  }
>
> -/**
> +/*
>   * of_alias_scan - Scan all properties of the 'aliases' node
>   * @dt_alloc:  An allocator that provides a virtual address to memory
>   *             for storing the resulting tree
>   *
>   * The function scans all the properties of the 'aliases' node and popul=
ates
> - * the global lookup table with the properties.  It returns the
> - * number of alias properties found, or an error code in case of failure=
.
> + * the global lookup table with the properties.
>   */
>  void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
>  {
>
> --
> 2.34.1
>
>


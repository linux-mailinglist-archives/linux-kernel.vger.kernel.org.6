Return-Path: <linux-kernel+bounces-363395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B7199C1C4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FB3283DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DD914B08E;
	Mon, 14 Oct 2024 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LVeG1lyX"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D5014A0B5
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891820; cv=none; b=nsof1DGm4aGBm5bMpNomhfXLtF1UzD4WkYRHddeEbYnxiol5LRW972B+Z4vtgW/Rqr0OqyR3payEhZdbPM/DotKbOZZcvpvIyN91fhGEoLicYlY3iiebiduR0if/lZM7QPo2Iv56fj+jUp9ipDo0e6R9oDZVtp0yb4qMkDBKRj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891820; c=relaxed/simple;
	bh=+g4VLx1y4rTCco0Bfo9tUTjB1bWOGr7+O8v5/Po4yFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hi6XWxtY+x3xnTCBeYq+cwa1TQO1aPusYmNsC4ZPmTUemQIDVzWIm8IoZO3QbrPfvE9XiXp/xZwgzEOSNMvsTLgNsIOd5ry38TialkTxZ8p1V4U8u/fVK90KAg2h+ZzPbHGBuZcsXxHugErEkbPCOqVMtYrAIKZi/+wO/I0YAXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LVeG1lyX; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a994ecf79e7so627737666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728891817; x=1729496617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+g4VLx1y4rTCco0Bfo9tUTjB1bWOGr7+O8v5/Po4yFI=;
        b=LVeG1lyXx7hnoLsKQMacLX15ir9sUiYTaPcupelSSfelKngBDLEmH2SQJBpOxHOKPw
         7AbFdBGhZhLzS5NZBKoMMAMjg9SF+2lVAd+oihKGW/dxuFAibJBYoVlvB5KtN2xxQRdM
         YTsUpbZ0YL6sLrTDOp2NdzLjLr+ddA0TlsGig2Ct1QFFJuylM/fWVVlMcgaKMsqGnhsE
         k6OAijEUPshfCXimhnGjxDYbBSICqkYGxsmIScqB0rhlOfrKKFJ1A++zxRkPPWst10R7
         heqzcV6DCxk2c7+kx9AjAtlXEr+JoUjRj78xP25OWtnjUvwKO7t4zLRMZjIpqU/ydEUk
         atxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728891817; x=1729496617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+g4VLx1y4rTCco0Bfo9tUTjB1bWOGr7+O8v5/Po4yFI=;
        b=MXFsjYLWSZZHCvQ184US1ss+nz6nv6nd0ZdxQSRF6YGVQx49qVmyGUng8ENovER96q
         MAn3UFHoHII6NA9N2WE6HPD68duhWyxH0eqlRNRixeOJ6AJocg1OXfSMWlIXktebB6nb
         wtAsjBDfDnwhQHnXWG+HLIy7yPGml3njWCGoHmI+n5Dbi5MZILAltF+xzMJIK88PnvX1
         NaveJOQJLQ6Gp0QtixO41Ml3E0FME5Mx9YfTadaq3JXBUGxsEYnUMD0SUhS/MWXEti+Q
         fNF+eNcLpbXzpukGFXm/QzmKIBe33WEGREoSr7jI4CL7RvfmSRy6EUQwCf6RbUfHdyHx
         5ekA==
X-Forwarded-Encrypted: i=1; AJvYcCVAA/t+H/9IuQnp2LOorQ+Yp+7+0CfOJxUWCvb9Ksh4XAC+9tZvAlrInpmNWNM4DvbYYxaY0j4RhwlVR0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX+bDiFCHWEl1Y4HaOkt4+qHmlpOuQf/Nb8XV2crHPOfOe3xaT
	fyVgFByFsD00cqFe2OFepQZG/PQTMxpKOnkRo3672hV/1RNSeLop/dZA/JwGEiIUK/IQ8rZ25E8
	9VJ5sx4HN6DkX0kLrDu9Tl+K+0aHIh+v/AZ/0
X-Google-Smtp-Source: AGHT+IHnZkjVP2r7pHiHbF6hr7YjrWQOYu5wNEGh0c/yJ2G4DoqhzAtXz/FASCdsr2WwE42Fq2111yQTmdPNnfSAldE=
X-Received: by 2002:a17:906:f581:b0:a99:f3ab:c58d with SMTP id
 a640c23a62f3a-a99f3abe8b7mr526573766b.16.1728891816887; Mon, 14 Oct 2024
 00:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013201704.49576-1-Julia.Lawall@inria.fr> <20241013201704.49576-5-Julia.Lawall@inria.fr>
In-Reply-To: <20241013201704.49576-5-Julia.Lawall@inria.fr>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Oct 2024 09:43:25 +0200
Message-ID: <CANn89i+EwGme3GEq9j8hPUqZ3+vCy3+73tTNM=1p=51eKPpPGA@mail.gmail.com>
Subject: Re: [PATCH 04/17] ipv6: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: "David S. Miller" <davem@davemloft.net>, kernel-janitors@vger.kernel.org, vbabka@suse.cz, 
	paulmck@kernel.org, David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 10:18=E2=80=AFPM Julia Lawall <Julia.Lawall@inria.f=
r> wrote:
>
> Since SLOB was removed and since
> commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache=
_destroy()"),
> it is not necessary to use call_rcu when the callback only performs
> kmem_cache_free. Use kfree_rcu() directly.
>
> The changes were made using Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Eric Dumazet <edumazet@google.com>


Return-Path: <linux-kernel+bounces-171978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0178BEB75
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F11A282B73
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8616D16D33C;
	Tue,  7 May 2024 18:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="3asohX/a"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5499C16D30C
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715106132; cv=none; b=XRjC3TwQRBdDHFtB44fPl0YaqbLYWsZRPlf1NGiypgSW4V/od4gVmODnwAnxTnEwF4P/XylcKFmeqK707jaXoRbVhTqx89cg4pkzcMMsPOwJi7egR8JB4XEO9Gbre4NjBWNf46Y1y4VPykXkmG/JWRmc3bB9OclbZSQrIeV3WYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715106132; c=relaxed/simple;
	bh=WGrDCpLhmXG0OzKkWQlmblE8Fu1o4nkE0xfNOfdBRP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOyJ4gSwMzCsR51lC1ofsRL46vhT6Nek/pbwLCjpHlpJSYADhO9VLkBQExNLKkylBI+5vmvz+N0RdXLADa0RNZxLlCfKbZTHD6oGqDJxwWsWSdp3MbJ1Zxjh8Dttm5LpvH5Rij9dkyKaG3Wi79TfiIByWe2sP0yr95iaYBjeYHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3asohX/a; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso3022a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 11:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715106130; x=1715710930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wLflVW04KtJjzrqEX38+Aa3dYvsqD/1sar1AfKslmU=;
        b=3asohX/a0thUx9BdUrMrwqOlVpupyx8q+uiV3ouw6117tGqRUyQ6DAxVAZUj2A/TaG
         cnlJdVpMn816RRAvIQIPe6dw4ASO0sD5lzzWIQ2rwmnLsDC1xVNNPgUgBtzHa7L3X8fo
         uxq4gJJe25yEAtOUgTeps5dBXC+bCk/SQtXnWGYuJkXSQS6GOogzIOr6zkdZLjuBE9/t
         780z+x6aMSoqqE6i4sB/e17biCnPlgFNH5Zx6AnRum9MvR8/HEaMUAJgmd9CV63Y4BRt
         AtyZxAKQi9hL4lrsFAmXVTbDUN8XmxqAs8jISldmI+wv1s5k22EYIMNa+4okIPbwYzOm
         ZYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715106130; x=1715710930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wLflVW04KtJjzrqEX38+Aa3dYvsqD/1sar1AfKslmU=;
        b=AJQFR0b3SqMarkyiNcyUHlp8AjwbC3BzJdREfntcvtPaz64F+FTlU07v3pfM9+mrIL
         WeQe5D0XjjPjgYr2Z7Ev6TVmH5eBEilHRyf2uwhGCvNT0AtpCKY5WfB7eY48YkdvkDAh
         LpZtlo1xyOs4me2UzIugdE4jBJos6Sd7nJiYZRAXoHaOlyinWM4v8qRfGY1z2UpIs8Li
         +6dxXpqlARvOSZLdc+onKPh9f9skqxVW8u3SvvjMD4K9L9g4edHE3d6qRS2L7RrUZIFn
         dA0hk+tQUEMktCvQ3U4XGtRJiI9Y089QgB6O0C/UocA9Zec5lBQcobeBUQjbRYyKzLGC
         FMFA==
X-Forwarded-Encrypted: i=1; AJvYcCXZQQJyOMbScw12/s2s1m5f7xE8/xV3cuwmahsdEWeYiOuDJG1oofd2Wm6aVTpgdqpyI0lrelWhZG2Zma79pALH0Nt5D7iKtJElMGl+
X-Gm-Message-State: AOJu0Yzygl53F4vplaPRFxKAGgpxzA+bz0eyO69pc42YKemdPOcVZLzx
	8foq+HPJX1vO9NkpXZv7CdETh+9Zm9b9wPry7qjNZQ1Ry6yfuQDk5+uUXKaNzpbuB07zhRRob27
	BnHqzUtY1naNFzQjvgIwhrso576VwtZyJCOhM
X-Google-Smtp-Source: AGHT+IEAUzK+Q2fl59QehpxISiQK+7GwZsujcGUtEEc473hSQ+Nch2fZVwYDMTDd1EXoTB5TtIifc+BmsIe9TrH0kP4=
X-Received: by 2002:aa7:c988:0:b0:572:a23b:1d81 with SMTP id
 4fb4d7f45d1cf-5731ffc8a3amr12072a12.5.1715106129590; Tue, 07 May 2024
 11:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507123937.15364-1-aleksander.lobakin@intel.com>
In-Reply-To: <20240507123937.15364-1-aleksander.lobakin@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 May 2024 20:21:58 +0200
Message-ID: <CANn89iLANEp-tjkKSawPTmH8DxaSQZ_OoJaAYHjLPkmwGEJ6nw@mail.gmail.com>
Subject: Re: [PATCH net-next] netdevice: define and allocate &net_device _properly_
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Simon Horman <horms@kernel.org>, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, linux-hardening@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 2:40=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> In fact, this structure contains a flexible array at the end, but
> historically its size, alignment etc., is calculated manually.
> There are several instances of the structure embedded into other
> structures, but also there's ongoing effort to remove them and we
> could in the meantime declare &net_device properly.
> Declare the array explicitly, use struct_size() and store the array
> size inside the structure, so that __counted_by() can be applied.
> Don't use PTR_ALIGN(), as SLUB itself tries its best to ensure the
> allocated buffer is aligned to what the user expects.
> Also, change its alignment from %NETDEV_ALIGN to the cacheline size
> as per several suggestions on the netdev ML.
>
> bloat-o-meter for vmlinux:
>
> free_netdev                                  445     440      -5
> netdev_freemem                                24       -     -24
> alloc_netdev_mqs                            1481    1450     -31
>
> On x86_64 with several NICs of different vendors, I was never able to
> get a &net_device pointer not aligned to the cacheline size after the
> change.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---

..

> -       p =3D kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFA=
IL);
> -       if (!p)
> +       sizeof_priv =3D ALIGN(sizeof_priv, SMP_CACHE_BYTES);

If we have a __counted_by(priv_len), why do you ALIGN(sizeof_priv,
SMP_CACHE_BYTES) ?

If a driver pretends its private part is 4 bytes, we should get a
warning if 20 bytes are used instead.

You added two ____cacheline_aligned already in net_device already.


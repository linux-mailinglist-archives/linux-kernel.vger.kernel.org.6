Return-Path: <linux-kernel+bounces-529743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49659A42A6C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409DE16BE8A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B497B264FB6;
	Mon, 24 Feb 2025 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="URDcLzvS"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9CE264A96
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419772; cv=none; b=CI2Pl1pH7C0+gU6Lw8En12pRuBaNDhiAlPNtQhATyhRRfQy0QL83oWrkbClTcI9UJzx/+v9ndK/omgsla4npqINdL5+904Lj2fn3Ijaa6jJ/G8ITwnDWL95+gl70kUQ/jMfVwNcylTu+DrU1/ssWk0GgNoRRCkyjIMz7pEnv8aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419772; c=relaxed/simple;
	bh=JoNWtL4pjWX/dnrAeAErjeRxJjHFptmwjkCXxEap17U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Da7W25QjYDVw5TyNI+62RriZfZPcqkrNojKHLssC4IPTl23qH/B4UEAt08PB24syf/z/Kdn+prVLFmUsQYD8UyeoYFnb8tVVqpi7RBl4q4t2jwg5kcQ1z0pN8P0D2CrXxwI1EnLvYWUcdE5TC9nbIf8BZ2Zu70WjHW1pO91M80c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=URDcLzvS; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dee1626093so10376526a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740419769; x=1741024569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoNWtL4pjWX/dnrAeAErjeRxJjHFptmwjkCXxEap17U=;
        b=URDcLzvSoRMVdK/HfdIwbtHIkag4hGbbtiagn8hbiOvzRWSpfwF8deBBR8Eknl6uUt
         DYbU6J+eKRAmt7CQIzBPHwEIAFzyaHCBmBFyDvQYfxYI5OoskYTmR996aAkttkbbToKj
         PhVMWrE8WWIFNoTnBoWE3sYlpgsli1xoNmHm3M0kEdmrR0p3LIz8xehqE+9inBTvF+F8
         e5t7Z8PzzFmyyXgd9dn7N6mQWXCeeVgEXEV7eJjiSp6QdBGyOHloNfV/h97NzWywQh2t
         d0SgG7oLaucVeWQKdgVnFLroCC8dzDkgE52o3S3WLra9N+Lmx4/GIejnJ1irC6wLKHU5
         pqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419769; x=1741024569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoNWtL4pjWX/dnrAeAErjeRxJjHFptmwjkCXxEap17U=;
        b=ewmc8Ml2etG7mQh26DIBVPM2agr0aNHsOnynRU5ETx9QGzfC6qZYF9ftk8aB2eFjNo
         vFkejiqOK9mjsaFyCV0LojvojwbKxNjzNNZ+4O9+ijd5AsPudhRvNIPPYyubzZlnL1yY
         5q0gZFxyyKq5XRLJRS+PFf4Qz05oTRQz+DC8Op9xQnFx7Bc/Jdx4HH0StgK+zMtKx+j0
         7fjcazJTBh5BJcokrcJ/4WkwBPKufpPDbhr/vwC8M0UkmbIAnkj3nADDKgnT4STe4pOd
         4zO/IeZlRIguUjGwIiXVymEbjfZHFnBAvfnK8QzO7Srq35kuybkqZNe/SwAaMA+XlG4h
         dIMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJoUf/nU5ZL7MtSto2OUHVMDOfWTc5bkI56SLzC8GKLnzg0nf+hDbW0qN3eAQGnefl6OQn3sqmwu2h3Ag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0qPmLQG3bictGyLrCyi/397RiWwwWaETtvkARHKxzaQsjyQZm
	/UxyeOW61l3Vy7cKc7Tt62tfAg3Ftb7rGKnPOQIli8xP3E+UxU4ddmfUtspupE8o/71kMNpxfpD
	Ucv0MSofDQX6yT/lrvv4Pz8Fu8/U1hcdBH2s6
X-Gm-Gg: ASbGncssIvQa5u79kPazQV/FIaO3IQelg1eP/5u+v2XEOpCcxL+7i/fTUbthftKjkln
	6h1AIf02i+Z7hNpQO5R7clGOFW/zo+dW/C9wdhgX4XxJ1aFSIF6wtLKPYmZyqghP+Xz6RiaA+2M
	5aKhmsBQ==
X-Google-Smtp-Source: AGHT+IGaLhJSnUk6JJPYNcD4K1LIcwSr5VkKBquNVpILC1vv7Bk4pjUDo4vsxTybF/r0/sUSF7fvfnRl+Fr2upaH6Dw=
X-Received: by 2002:a05:6402:90b:b0:5e0:6e6c:e2b5 with SMTP id
 4fb4d7f45d1cf-5e0a1261230mr17804954a12.9.1740419768613; Mon, 24 Feb 2025
 09:56:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224174401.3582695-1-sdf@fomichev.me>
In-Reply-To: <20250224174401.3582695-1-sdf@fomichev.me>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Feb 2025 18:55:57 +0100
X-Gm-Features: AWEUYZlUvE4b-BBWZ-vm5zRw92OkDPpOO9uIKEAgcKkVITAUNhFPql7JlFP6UIs
Message-ID: <CANn89iKSxQrEPs6nzuQ-4psxHnJODg0TLCHqbj2P0F9VfLtSUg@mail.gmail.com>
Subject: Re: [PATCH net v4] tcp: devmem: don't write truncated dmabuf CMSGs to userspace
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, linux-kernel@vger.kernel.org, kuniyu@amazon.com, 
	willemb@google.com, horms@kernel.org, ncardwell@google.com, 
	dsahern@kernel.org, kaiyuanz@google.com, asml.silence@gmail.com, 
	Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 6:44=E2=80=AFPM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> Currently, we report -ETOOSMALL (err) only on the first iteration
> (!sent). When we get put_cmsg error after a bunch of successful
> put_cmsg calls, we don't signal the error at all. This might be
> confusing on the userspace side which will see truncated CMSGs
> but no MSG_CTRUNC signal.
>
> Consider the following case:
> - sizeof(struct cmsghdr) =3D 16
> - sizeof(struct dmabuf_cmsg) =3D 24
> - total cmsg size (CMSG_LEN) =3D 40 (16+24)
>
> When calling recvmsg with msg_controllen=3D60, the userspace
> will receive two(!) dmabuf_cmsg(s), the first one will
> be a valid one and the second one will be silently truncated. There is no
> easy way to discover the truncation besides doing something like
> "cm->cmsg_len !=3D CMSG_LEN(sizeof(dmabuf_cmsg))".
>
> Introduce new put_devmem_cmsg wrapper that reports an error instead
> of doing the truncation. Mina suggests that it's the intended way
> this API should work.
>
> Note that we might now report MSG_CTRUNC when the users (incorrectly)
> call us with msg_control =3D=3D NULL.
>
> Fixes: 8f0b3cc9a4c1 ("tcp: RX path for devmem TCP")
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Eric Dumazet <edumazet@google.com>


Return-Path: <linux-kernel+bounces-363391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 488A599C1B7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84721F22AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DDA14A0B7;
	Mon, 14 Oct 2024 07:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X90ynpFM"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB4145324
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891735; cv=none; b=YlQAJ5yksyUYDfI0yPl6vUhn0Gi3wS3c2ZAJzx1xK7E/PRg+Y6mbtV/KRONzjjm5sfUYhVFgDkKAqm0la9hla8goYdR54CAQOsHbYsBVoVqBAQnH5ndZ1i93tyjvwPsXUaEaZes19u/IOChvDlyBqN+OTw20NPALpXL/7GkMomM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891735; c=relaxed/simple;
	bh=Tr8ZUfI7WuIJqS+Kbyv89NZrMjAzQlMLbG0EsH6Gg/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ey8lepTFYIBDLF8+95RL71d9v7Yv4UlZDaxxYtcKkVnpj5zNPOK5ZkgSVXQpECtTlLv0KuMAvzC4vvV6D43S9wiV0kKzn+pZ0kLH8NxBvqakrQrBJJXcnHXdIuqRAPWTJ+G7RIUZ6Jhc9PRRFQyLfmF9DKTXHaaB8EyaA8BLiIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X90ynpFM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so3095391f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728891732; x=1729496532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tr8ZUfI7WuIJqS+Kbyv89NZrMjAzQlMLbG0EsH6Gg/8=;
        b=X90ynpFM9KZZZCzmHuC+gXQZ3gPfsk+uu+miwK1ej6Af9ykeBDzB1yYHDgO/Ejfely
         JKnfEKu0bJW49cRShWk4Wc0FEa64Z5QBNPMD+vl+l9LfssG3Bn8N74LEWNClfhAWLKth
         dHzCxoCVa4QzvoA2IEKu1v/knUsUCJ82qgQA0GxkfdCrvkWG6Gc2Fa5iE1tQLfLFznLS
         QrzR0hQmwE3CS13Ct2Tb2/eSwp7eRsEv64DVtDHq0FNZ5rgd72vmNs380mwbK9JGF5eN
         IanCBhhnfzdyEftjR0l2fYio+IqEuLT2/85s07lZUs2xcqqv58YnNrcwgJnkYiCR6OoK
         2fUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728891732; x=1729496532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tr8ZUfI7WuIJqS+Kbyv89NZrMjAzQlMLbG0EsH6Gg/8=;
        b=sVnIkfRp2if1lJ/Xj9EwGyyKf/AbCjCx4zRT3Rjha6Fz5BIBT2Dz5CgbjqHVD8o6gP
         WlG39/MXKPPOD4wx9824Jv+K0aLEwR90gNFJIiR0jj4b8c1qzYfX4bkw+uKRpNDEWasQ
         uCNy+pfuTE6d4prUNuuTyxPACBHW46h/7mpvISQkQd3j9BcwIOvJNiHgqXUdMJgO9Nf1
         z1jmgdFRPdhv0jncHbZfU5uCXve5wKs+Ssww9tqy8A3XDPB6+IWLeeKeX70kxWc5yP7S
         PuKkzj7EjHo8PSa4P5b1kvHDGGHjC55jb1r97gA8hOIu3UdD5ASWGCcvQ9iP/XD+4HOh
         qy/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVm8ar8EBd/xyaA8q/303Ht3NY3+tGuV5qNqRUOJLKvQmup1ZreJGELcabuWWgcy5q9fklumeeUcp4emQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxviAzKTzXsy7E4dC5Mk9S21WxXEgbeZJZqefMjGOejs1MMqYpT
	aDXagQ0yrs2DYvk44yWqDFZmGSt8Sfa0oC13JCk4x8ZQTxmJjSgbT6g3eMV1AcZJF1HMjk4GC0i
	joi3rRmmI/gaonDLHJwx3+v3wCNI7YdRH3zzt
X-Google-Smtp-Source: AGHT+IFanHxngXEXoSruIGL7Lj9eBY0UNJQ4Ee/B1N1FU2RBHqVnBPNL966Bm6XUd1wbTeZ7KNEgYUSxxBXPLPfuRfM=
X-Received: by 2002:a05:6000:10cb:b0:37c:cdbf:2cc0 with SMTP id
 ffacd0b85a97d-37d601e9acfmr7383958f8f.53.1728891732017; Mon, 14 Oct 2024
 00:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013201704.49576-1-Julia.Lawall@inria.fr> <20241013201704.49576-3-Julia.Lawall@inria.fr>
In-Reply-To: <20241013201704.49576-3-Julia.Lawall@inria.fr>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Oct 2024 09:41:58 +0200
Message-ID: <CANn89iLQE6uFHpTXq-MGEX+Wnn-BtFnbpC-bUu=zHu0Pw2dKYA@mail.gmail.com>
Subject: Re: [PATCH 02/17] ipv4: replace call_rcu by kfree_rcu for simple
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

Note that fn_alias_kmem is never destroyed, so commit 6c6c47b063b5
seems not relevant.

Reviewed-by: Eric Dumazet <edumazet@google.com>


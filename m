Return-Path: <linux-kernel+bounces-365299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806C299E027
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4546C281F9D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CDB1CACD8;
	Tue, 15 Oct 2024 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vdladWKj"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B7B19ABDE
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979294; cv=none; b=o8s/CC+OXV/AwwhumB6ofdjhq+VNkhXsgL7MpiLTm0RbF8DSkFVkcxnGksfqLXGe0NjSGXkrlVO7S3vrr27cNVEVbWRAMLN/S0cAcOfNohXcns5vKm8WUj591+mfGtTKlwr+8Bz6RyOkIFcaYAi9uO5DGLmi5FnZvUOqHdRMcFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979294; c=relaxed/simple;
	bh=zj3VWhc1JXRNGK9CsDmZf0eapyKovX4dwjoqx2Q9Dio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7bJnXymsP1xgi62WGz+a/snWfvTkP36zCyT9rvsV4vhOvDZ5QpWqEscgUGA0NnSxjNxY3DqHNaezbffz2rQ0GjmZZq788T/04qa0kNiOnMTx1SEjDtX43lxoSDnZk8CfeETP17eObP6VfMZW58+BarFEtmhbtBCUZWN0IGOqcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vdladWKj; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fad5024b8dso53528961fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979289; x=1729584089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zj3VWhc1JXRNGK9CsDmZf0eapyKovX4dwjoqx2Q9Dio=;
        b=vdladWKjT8WI2KeXleLj+/RcHhaLevl3oykRwHEj/ZVgkBv+hL95RJrvL0saG80l/8
         hvx+1Bb1fYt8letMQFveFcCn/7Bv4jMkKa0GTSDnD3WgpUDQmfKAbHlR90919YTxYlWp
         /MKxgZxRQSW5cvW6EI7vce1MPENxpdKmJ6vR1xTOZ56Myl5y/gBhADKnF2ML2nSNJBuo
         0CKgDhB/60XRjW7udytqDzU1zPwXbgv1lbIUxq2RuRGLH7WPD8QszDkoRbRkvyjXEJKE
         TyOi2XajDVnvWzSjxTBBTQUyU6PTe4QPzhkBn9L++TPSKc9bEbq5VQX4T7pRQg6sYw9v
         cyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979289; x=1729584089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zj3VWhc1JXRNGK9CsDmZf0eapyKovX4dwjoqx2Q9Dio=;
        b=StxC2/MxoboLFeIuSd8nSSjSW5X5hP2Bo1qdUyhWYnRd0qQfgEnL4p3FjobgJ8QGRm
         DmxKc98Z5zsuYj1y0wdtCKk4c4Erxl4iJwOoKAWoGgdviFQs0EJ33SYskwzJJWZzpjae
         Esvok0rJMRRP5umxc0pLe/NpHxPporCz8uNwlwuVQeP61apDrN/eEG59r9hP1KE3VHWI
         S8h/96gM58dCmzPlsR1u/gnxrx+KQM+4o/9A7cHTZITJ/nOtZHiHINKh8x1D56uTzmrv
         lm6hkj8CS3IFk46omqzlwVN/kiacfJmSUi7aotGFBeoyTpavywO4g6cayHx+nSH54YLT
         0lng==
X-Forwarded-Encrypted: i=1; AJvYcCW1ab0GOza6x4Io6nB/4i9iRQW5v5RlEuAoVgk+7Pac+iX1aY6vpOiUyJuLBx0VRqMSaZ2vQSz+fBGVjbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYmArFYOWatUIHn1OTAoNbpy6pOyWc3tpURBirHEiZG70hV/Mc
	nIYXHYHqYAsA/yCyd0kMYYLTz2Q46L8hHPNSGscjD9cGqx/7JJXO8wN6J5EJBKNueTU2iywdxh5
	gWdFbPI94Ufzcg4tBERTcKU3nSjIwZBTXzc1X
X-Google-Smtp-Source: AGHT+IHxfKaPProiszu4hPKA2JsWyWKW8QC7WkdMfm3qCN+vO+7OHhDa8OoE6YIicZSOeQRLIab3tjlWn0zyThhZ2QU=
X-Received: by 2002:a05:651c:2120:b0:2fb:5d8a:4cd3 with SMTP id
 38308e7fff4ca-2fb5d8a4f7cmr6486501fa.0.1728979289048; Tue, 15 Oct 2024
 01:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-1-ignat@cloudflare.com> <20241014153808.51894-2-ignat@cloudflare.com>
In-Reply-To: <20241014153808.51894-2-ignat@cloudflare.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:01:17 +0200
Message-ID: <CANn89iJ0i+k_wHn-aoafY1V+mJ8TAS1DzQKnu1KkjusAWLNuyg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/9] af_packet: avoid erroring out after
 sock_init_data() in packet_create()
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Alexander Aring <alex.aring@gmail.com>, 
	Stefan Schmidt <stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-wpan@vger.kernel.org, kernel-team@cloudflare.com, kuniyu@amazon.com, 
	alibuda@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 5:38=E2=80=AFPM Ignat Korchagin <ignat@cloudflare.c=
om> wrote:
>
> After sock_init_data() the allocated sk object is attached to the provide=
d
> sock object. On error, packet_create() frees the sk object leaving the
> dangling pointer in the sock object on return. Some other code may try
> to use this pointer and cause use-after-free.
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.


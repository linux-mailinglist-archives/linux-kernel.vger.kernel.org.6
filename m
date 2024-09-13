Return-Path: <linux-kernel+bounces-328500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D32F9784FF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDFAD1F277E5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75624EB51;
	Fri, 13 Sep 2024 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sEtY0NeT"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB35B2B9C6
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241870; cv=none; b=HVgl7Q7SCtFVkx9lcBvZ4W6JSWoZ30NdgYQpy1UjmJqVxVcsKLTIAKdtI+iZCCMwDZ3y/2D2XZ+1JNwvgM7XgCXYKxA5MKBsjw9D9Z8SFRJ6+bNKl39XcmSsEgzAb5mQyXZfzcTdbjerZ8Q89Cf0Ry4KOI80D61IefBi3k1Ix1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241870; c=relaxed/simple;
	bh=8ixziJ+NoVh4KOQg8C8NgzofR7i3xJZLSc06BKDtxXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mbd74ban0GGRyhNCRbnTsJNb+mUzOcp7PxRxo6sIvKvjB7OkjfxyMQKRAmQQ+xE3pS3Ubxszxd4XrdvLdSzAaY1OdlVmBVjE5ppIW1XbOu2Y7Lwlb/QCB4i8bj+weW/AlllBPzwYT0tMBvZvrQVB6ORb47lF8m1xrRd9yA0Z1jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sEtY0NeT; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c245c62362so2561435a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726241867; x=1726846667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ixziJ+NoVh4KOQg8C8NgzofR7i3xJZLSc06BKDtxXE=;
        b=sEtY0NeTFRRF0/RcRwDu45eVUcbz3bjNqVmz2rjiT+avVsEusmNo6bkt4fy+GF8aw9
         rPezas8OvrcZAwlq5yd7FzIT1E8puhG0yWxJU33qfvHCEW/u7nOoaTvz+bqW3dIE5A1X
         YxrASmZCe+7/io1+HuIqLtPKWdFFVtfuhCuQFC6hN4zr8BxmQL/CC73LLJF7Umeml5B7
         D9wai5DTnC+66bViMRa62HM/YNxEcf26j3mwzj+/IRs3yRYjukhn6/IMDkudU03RYi/4
         jaDmp7mbReG1Nn1KVOVPrW/3aUta4/mChqitfQUhGnTSG5DtKevkR4sbEOmZe1Uft2Kn
         mgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726241867; x=1726846667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ixziJ+NoVh4KOQg8C8NgzofR7i3xJZLSc06BKDtxXE=;
        b=PgK0D+XeGyn5458Cma+cEQeHtMCiFQEJIsiIKnpEK0S4SrNbwZldoLAFbovmNSOA2j
         Ga4AcGvPm1nPwgIA2Zc5Pgcb3B+QCujla01izRY4evQT7tl3H9gCuAMJAkZlqLYCqh98
         gIG1KUt72TmPY4uAeUJhEDAcTmCWJdOCDoXdBhoPojzyxI04tZsq7FVXbATiAhkjhCKO
         s17m71mGz5tqnOKjrXqiGG+hbrWlv40ZA7ayEJmfL8TxC2YkkDXO/b8UADgjvTGQmQHn
         5ZBwNeYv6iudiyOTowUhI04wHfF6YD/iGYx33JyozcLGHD6exhDkIo+0D+kbUh58z3Tk
         rTSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhP64xTNW9y6LzZM4MuXm4LuDto0k9GcG1ZeQ61JRn84WTqD1SjUU+x4at59E+b+iHswIgQWM/H9zOjjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOyQfEXRzfBXzClemgp6Q3vP4/nn0PGGXk2Ac3LmUlW/tLXPGP
	C7hO1bn4uIx7bYq/5nV/OhHlgjb34xUv00L4DOglhtBhY3ZCSfKcNvx6rDroQCgK1V1U8Qm7XKe
	5h5LeCWK1ujexOX86d2NyPYeyJ4KcHanKZQs1
X-Google-Smtp-Source: AGHT+IGb5+Ky2+5hGPg9TOJMT/1uVEafLvwFY32TQ483pUMrOKix9BbKOuCjTfYl0Y8ZspD31CnMtbkI1Ixvmdip3Nc=
X-Received: by 2002:a17:907:e2cf:b0:a8c:d6a3:d03a with SMTP id
 a640c23a62f3a-a902947d3f4mr643415066b.21.1726241866556; Fri, 13 Sep 2024
 08:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913145711.2284295-1-sean.anderson@linux.dev>
In-Reply-To: <20240913145711.2284295-1-sean.anderson@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Sep 2024 17:37:35 +0200
Message-ID: <CANn89i+BGju58H3u6-Z_tZApjaMC+LB5XEocPbuTWK9owHyM4Q@mail.gmail.com>
Subject: Re: [PATCH net v2] net: xilinx: axienet: Schedule NAPI in two steps
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Michal Simek <michal.simek@amd.com>, 
	linux-kernel@vger.kernel.org, Robert Hancock <robert.hancock@calian.com>, 
	Shannon Nelson <shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 4:57=E2=80=AFPM Sean Anderson <sean.anderson@linux.=
dev> wrote:
>
> As advised by Documentation/networking/napi.rst, masking IRQs after
> calling napi_schedule can be racy. Avoid this by only masking/scheduling
> if napi_schedule_prep returns true.
>
> Fixes: 9e2bc267e780 ("net: axienet: Use NAPI for TX completion path")
> Fixes: cc37610caaf8 ("net: axienet: implement NAPI and GRO receive")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>


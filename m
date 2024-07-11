Return-Path: <linux-kernel+bounces-249622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABA392EDF0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4A41C21ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867B816DC14;
	Thu, 11 Jul 2024 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oe9j52uy"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5030916D9BC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720719495; cv=none; b=FjVsaNqYsXQV1e0OCEqUuOnb8nZ69nnasN6sBkHoP8KAaTnYFBYEnnrQoWJF8rAFhrUVlcRzB6GKDz7ULF4eMT1Qi6gKyKacaLLTba5SwKyBmbRLaOmpe3UbTETOYl5aX0Yy6rARTuGEbples/1Kfd6Y5NKDqFUd2l4LNr35qRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720719495; c=relaxed/simple;
	bh=5Xgl+EcOjT7f93shPiHRMJ4pO5M75AEYdIGVDYwpN8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QlRvjYLCN+JF+S7SIs6q91GRWajPE2Bkb1ZLSIMZsUkE2Nwi4VkYa+Qe4E4fC2clmjuzQ2RzRSd8TSJZpict0y4Zs7EwmBWqKWVP09glRcUTMStEjV6Q/SQx+FNjZ31GENPT5WsouQA5dGLKa7K6YOUwjXKxBzzb/WRl+G1djUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oe9j52uy; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58ce966a1d3so278a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720719492; x=1721324292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmi5HLcqE6fK5ySS3lyqzl4ypWFtv4L42PctvT1OoP0=;
        b=oe9j52uyDrHceb9y99ZhuiWajBBOOb0Vu5p4YsdN8JRq9bMms36Ydg9DebfagfNYFp
         2bb8egBjYqI+xW7EYeBcnd68Br5gRMChOOnv1uqkpO/NzNAN1bdURs9I1Ys8TSpUaFUB
         GK9K/LdgpHQT24rwAzYds0+QH0TmzpcXFL/v7MaLkVVEOTer+y6D3tDqGPyJCuvrEBY8
         XXCOUzLIJGfg8/lRf2OZr7daWAW25E/BcHRFh8ZBjgx0FxsEAfmQUDDc658XqYyVrbzV
         Xk3n+MfAS1xGB9VXYXXzajf/EM9AjqCa/EMP7xGfTCwggDaU48a3latx5Cg8Bu017uWV
         qMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720719492; x=1721324292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmi5HLcqE6fK5ySS3lyqzl4ypWFtv4L42PctvT1OoP0=;
        b=MgRyF8xlMXkZyWbWiOZ2Yc7F6TbNzdnQ+47jWOs2f95hxIBNX9naRlAWgtEMaxvdLJ
         dOlqr1YsZhJiaXOyJFYB8Glgd1v6pENLoO21tlBSQ4Tf2DZdymBvi155vqtbdVaVp5WW
         oVK5FU3gGCRE3MpW1Dfhs/l2GrIT8MsbQYAa1u38+ESEt54Xau7ef0MkPwkSidlCEwDU
         sCv3oiyZZ/jIcDRbiP5lZce/JSm2T6qu0eU8231rYuzuDMb+IgyuhazBvVfRY2Lli6Q7
         4Haxr5bEZ0nA8DE/5khu9n+EhPRrP1aDLWgPi3HtRDUk+ow6OAgfrrPC7riPpXkNpdfK
         fZ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVB8V33MT4aRCuLQFLTgcwqe4mbCo98gnN67vfPbmSYZUDtF8vcoPY6PEn+Gsr2dS6mXXlsLM5XtPoOVn7MB7q2XwwwSUCBNhVaA34+
X-Gm-Message-State: AOJu0YylwxjBFHlzpGpivYNx+KQsIe2HjFk1VP/U2FHVP7gmwe/Xwfq8
	rOllVrmDQ/x6pE0cLX383Q5gvZu+Z3j7v/0JaKytVhWA2ld0mqD7LfCuWBkjdHP4OpyimysyEYs
	I8oa8/WaUb/6xAveAn9abwkRZbHmzYhxsud4V
X-Google-Smtp-Source: AGHT+IH7ZVeKGtFW1ffbCmLAUEv4AqAX1Zjzfy/SAWoRHxzSGzNdtgnfN009pJNeMEQH46pIXGbzCkhrPdNrgHUru00=
X-Received: by 2002:a05:6402:51cc:b0:58b:b1a0:4a2d with SMTP id
 4fb4d7f45d1cf-5997b09fef9mr1782a12.1.1720719492339; Thu, 11 Jul 2024 10:38:12
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711171652.work.887-kees@kernel.org>
In-Reply-To: <20240711171652.work.887-kees@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jul 2024 10:38:01 -0700
Message-ID: <CANn89iKqZD68w1QtM3ztL_X290tj_EGyWRvFrhyAz-=T+GkogQ@mail.gmail.com>
Subject: Re: [PATCH] net/ipv4: Replace tcp_ca_get_name_by_key()'s strncpy()
 with strscpy()
To: Kees Cook <kees@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 10:16=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> Replace the deprecated[1] use of strncpy() in tcp_ca_get_name_by_key().
> The only caller passes the results to nla_put_string(), so trailing
> padding is not needed.
>
> Since passing "buffer" decays it to a pointer, the size can't be
> trivially determined by the compiler. ca->name is the same length,
> so strscpy() won't fail (when ca->name is NUL-terminated). Include the
> length explicitly instead of using the 2-argument strscpy().
>
> Link: https://github.com/KSPP/linux/issues/90 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> ---
>  net/ipv4/tcp_cong.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
> index 28ffcfbeef14..2a303a7cba59 100644
> --- a/net/ipv4/tcp_cong.c
> +++ b/net/ipv4/tcp_cong.c
> @@ -203,9 +203,10 @@ char *tcp_ca_get_name_by_key(u32 key, char *buffer)
>
>         rcu_read_lock();
>         ca =3D tcp_ca_find_key(key);
> -       if (ca)
> -               ret =3D strncpy(buffer, ca->name,
> -                             TCP_CA_NAME_MAX);
> +       if (ca) {
> +               strscpy(buffer, ca->name, TCP_CA_NAME_MAX);
> +               ret =3D buffer;
> +       }
>         rcu_read_unlock();
>

Ok, but what about tcp_get_default_congestion_control() ?

Thanks.


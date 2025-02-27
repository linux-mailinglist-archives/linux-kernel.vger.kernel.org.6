Return-Path: <linux-kernel+bounces-535205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D21AA4701F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85CEC1656B3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20DE46BF;
	Thu, 27 Feb 2025 00:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="J939lYun"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918E4323D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615713; cv=none; b=auOzVYyF4jjqoypwllyZW7it3wnxVs8pr/xD0klQAe6fLig7Upmg5fKNYPFPlrxUmujkq5FzF092DvMXE9HqiZtBEyyKb8p9lpoKIFmr5RagHhPmQR4UxT/4XsYtv2nkj8ILsCircaMRJzn0v/NqgF9yy3jogrorGQGs/j6rY+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615713; c=relaxed/simple;
	bh=lA93WJsvl92fEN+e3o7YO4/3sHa1ZEPZrGW4J9LxunE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DzqBlARZlowVA+zSZC3173pYCD1UkXHgOD7q7sfphrXeob7h4odz3FaTqGGHnHlDj+e8ORWRHCHRVW6bB6+9QYFE6EAbMgaXm/bfNdI+jlcPU9nIVE5ZuvgwfeBiEb/+MFd3bvWyP1AsMtYxL4eZHDdIsBNsLXz9fnkR8htzZm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=J939lYun; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ef7c9e9592so4090517b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740615710; x=1741220510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQb8xHBG/FR0hbx6pk01W2r0mdKrQfyVO9coElE3pw0=;
        b=J939lYuneuZWUQrkJvbPdGxmYYUyvfOLN4l0NbjdK8WrKF+Mq2s6otL437IQ4aksnp
         BmnIPcX9NL5c6L3Z41bEzfKBkcv8GWO4ERluiWhjEcUJuZykn1Oo+rm1et9Avr5Jaztd
         xPKCb4BRhK0Lnd3qK0vBwms18KLhbam/cetOPdB2hkiWVBFVD+jTtDAkdyPm0VgxFBUr
         zjIsc+mRBBVGl7FU2tsRaq5eQmVy8gh8pQ+D32++rSAKKjZG8jY5Wats3xfAfasZ0Z48
         Zstw4S+FpeHahidpzlz9ylXZBQb13ow4bR1UGwjq3xtNZmSPCg6iok1gLGQdZUEG22iD
         XZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740615710; x=1741220510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQb8xHBG/FR0hbx6pk01W2r0mdKrQfyVO9coElE3pw0=;
        b=FmjDt5Oy2NR4DSb0y85wbjo1oasZn7gQVKels1wMe9Yxxk9yoHrArym++7MYf780w/
         sC0Yo5RDUHCsqbVWErKEYC2KISDC9GSnP6zpYTV1MNRD8xsL6wMPWuVUkq4EaC9qj5+Y
         q4MM0HT1hJW+WEc4XK/uq5KwzFiEpioNh7x4sBBtw71r7LtD4jgcayt8NeuV1ILa81bz
         6+CdG1fp/uQ62s7HJ4JX6xXiMw0K7jnWbDKUI401t/v6cFFpPWD3JXuiga5z1mIk6Mlo
         5E6QkFVr3GCQOkxcP3xN2BW1HoUXoTPzhVCsC7vlMZxLBdz7i/Ja6bFdvD3E4xNsboZD
         duhg==
X-Forwarded-Encrypted: i=1; AJvYcCWKnZl0NhIrjQ4DBOD3K54KUiToj0x0AzHscoyOTrcvszxdTzeowyWBbMf9T8zmFCD0R9r8MH1GxD7jRPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgSV1KF0gkf7FFXYS/sr23UOsRldAxgViOhU9oy1AdJjQi3fJi
	U2vPd3nt9r0+h0D/85q1dpJMAZiorNGgBHDswE+2vjptowXJz2hfTDbKYvyEQCR4dHY7jjV08AB
	KEKgoaPrQryAdSb6QxG7FosbsUCtlhsiAdWbq
X-Gm-Gg: ASbGncvRPTPogxB0GqeobFvECdL6gzIndELrxLMflRDKXCzKiYj64m4CP1FmI4Ww8/J
	KZwvdxUrcV6hvdSA6g0JUR+eGVehfnSE202N7Bf2hE5PKyu7F9y/zj6y7SseJJ1ZOFLFB5VVwBk
	zkZ+KNt6Q=
X-Google-Smtp-Source: AGHT+IE9M596fOsnvChdCaxBZdSAWh6n7T7MHXBJgqbUdKmToL6i4dODJlYnfR7DdaOaazxEJtI53RpYLKKE+GFsH3k=
X-Received: by 2002:a05:690c:6c04:b0:6fb:91a9:94d9 with SMTP id
 00721157ae682-6fd109aac64mr93407707b3.2.1740615710538; Wed, 26 Feb 2025
 16:21:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123-sysctl_const-pcmoore-v1-1-d9f918dbb0be@suse.com>
In-Reply-To: <20250123-sysctl_const-pcmoore-v1-1-d9f918dbb0be@suse.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Feb 2025 19:21:39 -0500
X-Gm-Features: AQ5f1JrZY5tKZxOzch7-SkqlEDKzPUv3kMxeIjzsldzlnYyGW6kgsoWl7IDE9J0
Message-ID: <CAHC9VhQpkyqaJsxj9_d4d6Vpc+FVbSnH_HeAFAVEdj0trGCh1g@mail.gmail.com>
Subject: Re: [PATCH] security: keys: Make sysctl table const
To: "Ricardo B. Marliere" <ricardo@marliere.net>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	"Ricardo B. Marliere" <rbm@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 2:50=E2=80=AFPM Ricardo B. Marliere
<ricardo@marliere.net> wrote:
>
> Since commit 7abc9b53bd51 ("sysctl: allow registration of const struct
> ctl_table"), the sysctl registration API allows for struct ctl_table to b=
e
> in read-only memory. Move key_sysctls to be declared at build time, inste=
ad
> of having to be dynamically allocated at boot time.
>
> Cc: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Suggested-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
> ---
>  security/keys/sysctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks fine to me.  David or Jarkko, this looks like something for the
keys tree, yes?

Reviewed-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/keys/sysctl.c b/security/keys/sysctl.c
> index 91f000eef3ad82370250e5238d9c9c80757aab61..cde08c478f3272081304e6db3=
4e36b64ce0d321a 100644
> --- a/security/keys/sysctl.c
> +++ b/security/keys/sysctl.c
> @@ -9,7 +9,7 @@
>  #include <linux/sysctl.h>
>  #include "internal.h"
>
> -static struct ctl_table key_sysctls[] =3D {
> +static const struct ctl_table key_sysctls[] =3D {
>         {
>                 .procname =3D "maxkeys",
>                 .data =3D &key_quota_maxkeys,
>
> ---
> base-commit: 714d87c90a766e6917f7d69f618b864d350f09d3
> change-id: 20250123-sysctl_const-pcmoore-fa14389b8329
>
> Best regards,
> --
> Ricardo B. Marliere <rbm@suse.com>

--=20
paul-moore.com


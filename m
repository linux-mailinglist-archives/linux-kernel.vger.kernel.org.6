Return-Path: <linux-kernel+bounces-288817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AA7953F16
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF2A2856C7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB7D2A1CF;
	Fri, 16 Aug 2024 01:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XWkYg7Ak"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C49282FB
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723772818; cv=none; b=XfL7/9ooJ+geOWe4+3eh6eIoEY6FjMoP+U8yzUvtC6n0jIJKhYRkaEmRaFG0+H0/FikGM8gwnwr2QofQ2yhjNtVRNXZAQK9iXKwuD8StjcVs5+9NlIRibVL/KYt3dXZr7OmMqzlPJ8+M/8gKe9LXWl4+ImgMeGxTBgroZwpfRXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723772818; c=relaxed/simple;
	bh=NIBOoJMVb1dDnKkwOEKZDat5dY+ftvJcIF5qfVLXbzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQ5KZ3qN7cbb43d/l6H7m8rLLaNVO9cDMOH9ZfWfxEYTq3n8p9BziPcVF7lzFO0gUcLiZiklU3xJRbwodYf0c8V0l7dq4DFSNPl3HgNqLsRVerVPRY36jiflfnpK7HEY9M5VardCqjFlPX4YJWTmjaX7PzS0asmpjI/GQEP7KCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XWkYg7Ak; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-65fe1239f12so15467387b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723772814; x=1724377614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXHD3XO0PVbm7MDlXwMyq4trppUptHzxvJNrfQsqgyE=;
        b=XWkYg7AkTKZ3Wy6l9jeNcP+eL7dcaV/j/nz/5DXZEGzxJTDj+CeUHpWrb8/2wPYUBR
         kcDvKE/r2sjdOHW2r0ASljGOqE+SaLjqZz7JEIpVBcNc6nBNALZlKdTxVpCzZxNChRD7
         zkVi70EgT82jcRsjV1DFhCWMdQrxFFNrL+mXfP+JmMANtbD/ldGCNxinR2M1e2xSHjdj
         H417tTuY9bNdx7NQtREmioNqADTxzBdxZjIvd6dOKb7tbKu4OfFwJ+vKyzRXu6L+gCVd
         VOU7uPBZp7MWxiEfXLGc623TDS7SveW8bUQ9Z/RU6N4SCBl92eoVowHYRG20Xf2NY3Pu
         BrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723772814; x=1724377614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXHD3XO0PVbm7MDlXwMyq4trppUptHzxvJNrfQsqgyE=;
        b=l/IJb/N2nqZRG5wvWq8MOZDedUmMRpID6nmuEP21mAQx1TxrS6d2YW8JFNYhG83jjY
         KQd1JPAGM3aYIikUGXGkQ/+yMAx9Jg8cTm5pIOl0FqFHvBbghlqQVn+JVOy5+JdvuY/A
         1GfQaY1r2a5agVB03kX+Zs8WzL7y/yz65b2LOgKVz1ap3GTDX8mrNn7XAgPyb5Xwrxxu
         QevjSMDjYQ28ZsYC8OxZvMwHFf5QMWchVIsDFdJLyVEgS+RGrlewbQuC7CUQsm38rFda
         POnhAX317xN8M0M6HhAO0TwruGrMfqh/NJDVz8qJuKj0hc4GCma/KTdgljTsea+LGp81
         AQoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt1Fk+XGUtjnYi7I+IDmYhoK1JHHS3S/aGwlXWNYq+6Bymfay+MZAusdCxIv2ptpvgTAUykrIBunWH9J5oeD03bAhWskgyLCsyi8QO
X-Gm-Message-State: AOJu0YyhPwJsYMcQfWO9KsRCphdK6O0PMmvq4IoTPGn6YqKzCO96kIuv
	L2J8xILfIgIUNLWs+11MqgExWngLz1pB3/ihn/LCYKBmR3HecrGyYRNArBEa48me8EnYWZsYzAN
	+GmveK3S7L37DqP+QpO8TwMAcb/sGwnApBps1
X-Google-Smtp-Source: AGHT+IEgrfjyTo+Vmdl9sEQ0LsmBBkJ4rasMnzHUl4tlI9dxrpz4WNlKI6P75hWT2tcxYRdGCsEh/8CmRjwaTivtMi8=
X-Received: by 2002:a05:690c:60c7:b0:69e:a7da:f9e5 with SMTP id
 00721157ae682-6b1b871ccddmr18784047b3.19.1723772814670; Thu, 15 Aug 2024
 18:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815083229.42778-1-aha310510@gmail.com>
In-Reply-To: <20240815083229.42778-1-aha310510@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Aug 2024 21:46:43 -0400
Message-ID: <CAHC9VhSrPS27KSG1_On8_WqUfR7tokbrmVwfW3+L_-XJiA=WZw@mail.gmail.com>
Subject: Re: selinux: support IPPROTO_SMC in socket_type_to_security_class()
To: Jeongjun Park <aha310510@gmail.com>
Cc: stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 4:32=E2=80=AFAM Jeongjun Park <aha310510@gmail.com>=
 wrote:
>
> IPPROTO_SMC feature has been added to net/smc. It is now possible to
> create smc sockets in the following way:
>
>   /* create v4 smc sock */
>   v4 =3D socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
>
>   /* create v6 smc sock */
>   v6 =3D socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
>
> Therefore, we need to add code to support IPPROTO_SMC in
> socket_type_to_security_class().
>
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  security/selinux/hooks.c | 2 ++
>  1 file changed, 2 insertions(+)

I'm a little concerned that the small patch below might not be all
that is needed to properly support SMC in SELinux.  Can you explain
what testing you've done with SMC on a SELinux system?

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index bfa61e005aac..36f951f0c574 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1176,6 +1176,8 @@ static inline u16 socket_type_to_security_class(int=
 family, int type, int protoc
>                                 return SECCLASS_TCP_SOCKET;
>                         else if (extsockclass && protocol =3D=3D IPPROTO_=
SCTP)
>                                 return SECCLASS_SCTP_SOCKET;
> +                       else if (extsockclass && protocol =3D=3D IPPROTO_=
SMC)
> +                               return SECCLASS_SMC_SOCKET;
>                         else
>                                 return SECCLASS_RAWIP_SOCKET;
>                 case SOCK_DGRAM:

--=20
paul-moore.com


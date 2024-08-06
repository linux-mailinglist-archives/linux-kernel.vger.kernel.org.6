Return-Path: <linux-kernel+bounces-276793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F44E949882
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECF62B243FD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C7815B10F;
	Tue,  6 Aug 2024 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMzonwQ6"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE16149C74
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722973054; cv=none; b=br+ercMIILvXH6mNLhCFHduaM/SmyINcvMm5fIhtC9PYNezge/bHFv7vgboEM7ST/Rzgtle0C5idlb8MCSqr22qVMce3AmlRPnyGLmaeZ8xh6+bPyKnMsFRn6lUMxCKlJCDPau0XItiz5hDZ0oXi3IYQJjStxU+bC6z8/eQz3Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722973054; c=relaxed/simple;
	bh=FY9WL5Ew4UpGjqQRe0kjOd5ck/2a2WaUZo90dYASdOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYDA7go4x5LP7z8iwJ34HaHXDcVyFgt/OzW1f/ndeOQwXcR0jbZZeMhT6EgUgRr/l3Mipgdk1A+q8eYfGqPvtWxIPZBSMhya/Wtktt9aQNxwB3jiKs8zPFJqJZYzi7EiI3r1riKKvKw/vNMU66BjyPFGuA9Lty6OeibIG4yIfwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OMzonwQ6; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so20539a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 12:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722973051; x=1723577851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8uEFO9W2+FLhm25gWiA80kftcKB1qkyC9ekZLOIA6A=;
        b=OMzonwQ6TaZPj3Q1ucGu7ke2nD9cx6vQbfrEnilcNylVMvSZDHnCedJlKy+hjalzmb
         Fd5PbI6aKTdynVXKOIyWgVoiFHh+1e95eCz/QHHnKcU9f7ULkx9JNr8nFbmYX0zbyA3K
         KgeEnuDa+t1hI0/yZGc0NjlByhFnIfoSXuiMWP/2A2c6c4BcOmQaMPXagTTRakEdO32s
         7d7vLUKGNniPxzHW8hLYza1aFQHptP8Zxgz4Oa3kYnbcCYwzRD2r4cpNoHTWi69J7h8o
         iU0YG0uKDdAMDYBwEXALrwMhfOaVVyjw/fG6RniAS5KpmuxqGRisAykV6MWH/8IzN+qt
         tT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722973051; x=1723577851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8uEFO9W2+FLhm25gWiA80kftcKB1qkyC9ekZLOIA6A=;
        b=py6BHFji7JKoYhRzxSLBohNGQob6Hx99iBLFo+VrjjmURG5KBQXJt9p4NgSJCEkeTT
         1IdhonMVajS7YOfq6JPSMHNTL4AWuzNEVRixgrHjDOPMGBLdH83exNv2XNaNaz9+JhiC
         3DWDswzmWng9oRt34t59Q0mkTXAzBNmqjDarZdC/EuqUNeMDVZYbYwh+Kk84JmH1yaeD
         aDLLkth1Enh+4T3uo5wRQkaLG4kkISsMr4+e7iLRWeKA3zbvIy1G7ymsnzUZQsArzze8
         5uCQOXO4Rt1FcGQmLZ6xAzXg3lJG0f1GBlpgDv5Q22XD5f6ovvB+g7755G88IBtzFLHL
         aN9g==
X-Forwarded-Encrypted: i=1; AJvYcCVnPBfvC8jHifXxt1CIVE0roQiXXZLaGeKBTlGxzFrJbXosYFgefDTYshB3eqZGsJ280SbGzt8OnDVym/N5LUv2tGir4v3ihi36MWzB
X-Gm-Message-State: AOJu0YyqIrgr+iQVbISbsmGf8SNQT4tcq1sAOdlJNZ496ZiRpPfrfNco
	qzwoHOhaBueHDSU0NtAqlYdS1+r4IfiRIC+1w2t49bFcTI5aAmrA5q45rgH9iHZ2OIJA8wtBTkv
	rc5OeJElePSdEK3w+06dSXVAVbZMXN+ENcSu4
X-Google-Smtp-Source: AGHT+IEW1GMKFCD4DKnyeN084/kX07o+WDR9IdrRnzwMCqQYEsxnNt1QCfmcpRWNQ2zFJ7nrXEKfvAxnQsHp0cWnkXQ=
X-Received: by 2002:a05:6402:84c:b0:57c:b712:47b5 with SMTP id
 4fb4d7f45d1cf-5bba28b2757mr28024a12.4.1722973050127; Tue, 06 Aug 2024
 12:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1722570749.git.fahimitahera@gmail.com> <e8da4d5311be78806515626a6bd4a16fe17ded04.1722570749.git.fahimitahera@gmail.com>
In-Reply-To: <e8da4d5311be78806515626a6bd4a16fe17ded04.1722570749.git.fahimitahera@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 6 Aug 2024 21:36:52 +0200
Message-ID: <CAG48ez39+ts9pNVvAxXcbk6X5_+s_yBXPUW-ZUNRxQq3aJAyrQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] Landlock: Add abstract unix socket connect restriction
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, mic@digikod.net, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bjorn3_gh@protonmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 6:03=E2=80=AFAM Tahera Fahimi <fahimitahera@gmail.co=
m> wrote:
> This patch introduces a new "scoped" attribute to the landlock_ruleset_at=
tr
> that can specify "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to scope
> abstract Unix sockets from connecting to a process outside of
> the same landlock domain. It implements two hooks, unix_stream_connect
> and unix_may_send to enforce this restriction.
[...]
> +static bool check_unix_address_format(struct sock *const sock)
> +{
> +       struct unix_address *addr =3D unix_sk(sock)->addr;
> +
> +       if (!addr)
> +               return true;
> +
> +       if (addr->len > sizeof(AF_UNIX)) {
> +               /* handling unspec sockets */
> +               if (!addr->name[0].sun_path)
> +                       return true;

addr->name[0] is a "struct sockaddr_un", whose member "sun_path" is an
array member, not a pointer. If "addr" is a valid pointer,
"addr->name[0].sun_path" can't be NULL.


> +               if (addr->name[0].sun_path[0] =3D=3D '\0')
> +                       if (!sock_is_scoped(sock))
> +                               return false;
> +       }
> +
> +       return true;
> +}


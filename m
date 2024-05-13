Return-Path: <linux-kernel+bounces-177880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0688C45C5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39E9EB23B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ED4208A4;
	Mon, 13 May 2024 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IFWjGER5"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581F71CD3F
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620294; cv=none; b=QKxrWynLSvY2rXC6uk/u1dHaktNcXzW1SZpt7FVwIfrERNZcmDmPlD2jfoowg5IqYiO92co5nKTyUqMAS5zLagC4HD+39Z000UWZHtbUUtjZ0P4O3R7+xGqT4p7tOdreYEG3ikwnZ/qyIqClVJYutB0YkUolp/XBvvqgqXSMums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620294; c=relaxed/simple;
	bh=QsU9VcO38mCO6VHiLHRMzidjKsNaDCBvegm7dClhejw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qs617k6S1Y04mcxP0h1iIKCtemONAU4CStMZYHbgj/I5qqrHMHNEdV5qvdKXWXY8Y+PfWTYbKj4om749PUUx8swBj0cna4dwYM4EDTj1bjjzPqzmHkzo0nM8c8qWQ3clLCbgh0BI7CxDpFmqMHPhJWvzEIeQAQRAx2euQCIm2SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IFWjGER5; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso3650562a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715620293; x=1716225093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2nC+uuvv/kRsKZflGqdXg7bseQO84xpSJ4IIawyz0U=;
        b=IFWjGER5jHfitMBcU1X+1It5hiaRxvqwPncN+RzvvWT9YfPvUX1yYtlnCky69UhiO5
         0xhYsIQPgF99WkhRIgZycGXgJlb7a4oBD474zo+DuEAor00fjNyS1tvjRd/WfIaC07qJ
         MOw+m6PkTQCDR7Yc/jpPh8yybgmj7Fovh7eyL2l30fbnn8GQ+xRgQB/YAgfaGb4TQXAU
         BctEWZ0G+sRUndZxefYeWdme+8pk8kXa6/+2l/kFyy93dUKjFuM3c/xMTSTvIhaj2tGO
         X+iVjBHSGsHUweqFiqB45xzkYEpxT2fH0JTXJU78Afe0GDpDWpqBvDu6VsSXtQjwQ0NW
         5EEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715620293; x=1716225093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2nC+uuvv/kRsKZflGqdXg7bseQO84xpSJ4IIawyz0U=;
        b=P8+IsK47Zf2yMf5RG6kH6Lw4savbeT97MCCCmAW185ZhKJNPI3jKbl0LSYR2Om7PPd
         DTLZ80dB6K5iTi/qC/i/lemQRF3KYrnsHDBpLRE/wAPK0N6q8SnFPfBN+M0K3iBKt6dL
         x2ERU4iIYYjFZojmr22MeNWv5lH6ocCpQLT3W/SUyptSuu9ECN2/Pp5XXucVgOhQcPJB
         gof0YphauJgkfnFOuL9zccbLPpJMkACVLVGcWgD7eY0tsPIF0ykO/K+80zDt2q39514K
         mJFAxuDtmCBG0Y4c7Kq61p6HLmYLEG4EDx+NNLAhj+GpaExfCTwU+Vo9vZKw7kzzKrwI
         Y+cg==
X-Forwarded-Encrypted: i=1; AJvYcCW0dK90tedy/cnyjJNb1HATA/YNAxTUzULz1/v1SyOm3e6h75GdlvT1PQlUKHJPkHNdNVIuGn8PDVm5qyxnkGpku05TunH+/yeCP1Bg
X-Gm-Message-State: AOJu0YxifC/L41goaPcQ7/lCD9zJIzDk9tb5G8avKiGMKruSVZkvtTIG
	9iXyhQw6+oAyVvAZi8rcuQWfMizQD5RGwpaxzQP0PAb20REmHKELe+XyrwehdEHIzHonGjcEqWF
	4CKJ1Eoqx0+Lg0ppdmmbS+hDukTIAN4S0BLMqTQ==
X-Google-Smtp-Source: AGHT+IFTVnywRERo05UfjqnKp/fXeBOJVobi68u/z/rIvk5ypHQIt5iRrvoBgYRgGLWTlmX/7+scABzTI91vJy6uznI=
X-Received: by 2002:a17:90b:3848:b0:2b8:5bf0:115e with SMTP id
 98e67ed59e1d1-2b85bf01370mr7491728a91.5.1715620292566; Mon, 13 May 2024
 10:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503221634.44274-1-ignat@cloudflare.com>
In-Reply-To: <20240503221634.44274-1-ignat@cloudflare.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Mon, 13 May 2024 18:11:21 +0100
Message-ID: <CALrw=nGhgRrhJ5mWWC6sV2WYWoijvD9WgFzMfOe6mHmqnza-Hw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
To: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 11:16=E2=80=AFPM Ignat Korchagin <ignat@cloudflare.c=
om> wrote:
>
> TPM derived keys get their payload from an HMAC primary key in the owner
> hierarchy mixed with some metadata from the requesting process.
>
> They are similar to trusted keys in the sense that the key security is ro=
oted
> in the TPM, but may provide easier key management for some use-cases.
>
> One inconvenience with trusted keys is that the cryptographic material sh=
ould
> be provided externally. This means either wrapping the key to the TPM on =
the

I would like to point out to myself I was wrong: it is possible to ask
the kernel to generate a trusted key inside the kernel locally with
"keyctl add trusted kmk "new 32" @u"

> executing system (which briefly exposes plaintext cryptographic material =
to
> userspace) or creating the wrapped blob externally, but then we need to g=
ather
> and transfer the TPM public key to the remote system, which may be a logi=
stical
> problem sometimes.
>
> Moreover, we need to store the wrapped key blob somewhere, and if we lose=
 it,
> the application cannot recover its data anymore.
>
> TPM derived keys may make key management for applications easier, especia=
lly on
> stateless systems as the application can always recreate its keys and the
> encrypted data is bound to the device and its TPM. They allow the applica=
tion
> to wrap/unwrap some data to the device without worrying too much about ke=
y
> management and provisioning. They are similar in a sense to device unique=
 keys
> present on many mobile devices and some IoT systems, but even better as e=
very
> application has its own unique device key.
>
> It is also easy to quickly "wipe" all the application keys by just resett=
ing
> the TPM owner hierarchy.
>
> It is worth mentioning that this functionality can be implemented in user=
space
> as a /sbin/request-key plugin. However, the advantage of the in-kernel
> implementation is that the derived key material never leaves the kernel s=
pace
> (unless explicitly read into userspace with proper permissions).
>
> Current implementation supports two modes (as demonstrated by the keyctl
> userspace tool):
>   1. keyctl add derived test '32 path' - will derive a 32 byte key based =
on
>      the TPM seed and the filesystem path of the requesting application. =
That
>      is /usr/bin/keyctl and /opt/bin/keyctl would generate different keys=
.
>
>   2. keyctl add derived test '32 csum' - will derive a 32 byte key based =
on the
>      TPM seed and the IMA measurement of the requesting application. That=
 is
>      /usr/bin/keyctl and /opt/bin/keyctl would generate the same key IFF =
their
>      code exactly matches bit for bit. The implementation does not measur=
e the
>      requesting binary itself, but rather relies on already available
>      measurement. This means for this mode to work IMA needs to be enable=
d and
>      configured for requesting applications. For example:
>        # echo 'audit func=3DBPRM_CHECK' > \
>          /sys/kernel/security/integrity/ima/policy
>
> Open questions (apart from the obvious "is this useful?"):
>   * should any other modes/derivation parameters be considered?
>   * apparently in checksum mode, when calling keyring syscalls from scrip=
ts,
>     we mix in the measurement of the interpreter, not the script itself. =
Is
>     there any way to improve this?
>
>
> Ignat Korchagin (2):
>   tpm: add some algorithm and constant definitions from the TPM spec
>   KEYS: implement derived keys
>
>  include/linux/tpm.h                     |  16 +-
>  security/keys/Kconfig                   |  16 ++
>  security/keys/Makefile                  |   1 +
>  security/keys/derived-keys/Makefile     |   8 +
>  security/keys/derived-keys/derived.c    | 226 +++++++++++++++++++++
>  security/keys/derived-keys/derived.h    |   4 +
>  security/keys/derived-keys/tpm2_shash.c | 257 ++++++++++++++++++++++++
>  7 files changed, 524 insertions(+), 4 deletions(-)
>  create mode 100644 security/keys/derived-keys/Makefile
>  create mode 100644 security/keys/derived-keys/derived.c
>  create mode 100644 security/keys/derived-keys/derived.h
>  create mode 100644 security/keys/derived-keys/tpm2_shash.c
>
> --
> 2.39.2
>


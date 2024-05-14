Return-Path: <linux-kernel+bounces-178819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7288C582B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E481F232DD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF4C17BB27;
	Tue, 14 May 2024 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ahPzsI+y"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA79144D01
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715697724; cv=none; b=hBhvepkFb5K2x762lx/ZRF3xBAPmNmFujhHWyFZxpU7BxrHPXaOrE2sDB+3JdRl41cowucBy3JzSHgRm2qw+NmWaoYbNFU5WbPiOtmblApEh69EWFmm8fVJmx7HjuhyXw7HCkMvKBTQoTbUtHG/gwujeS0hHyEyed4sJCRhYDRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715697724; c=relaxed/simple;
	bh=cL6om3Frdqvkmjt2cViIjCpSlw/JksZfeTaan2+L4Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gD80WbM62kXcLhrd7mskCKdkskD4SNiAk833E3ZwXts9ceqhL8YNyI8g0vC0Rxg03BCVRHkttmz+qxP5EidqHJU0v/VWwSVX/cgRT0Jqur37kLLMonUhkAk72tSqxTY/u5Kga+lvBChI4I1UQgPPtvO0ftitcTXFMfldArrLGZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ahPzsI+y; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f120ae1ca3so4236a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715697722; x=1716302522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TV3+UMiVWq7CksEqEGh2EzKR9H0sUTyC5OVKuFe6yD8=;
        b=ahPzsI+y8yRGSReKmAnejjLYwAxwXKmfjciMP9//NnfbIRj6aJQAE77bQO3QoDvBb9
         7Iiw4zK/nj4VYeCSWjgz0o53tBSu90gbEEtg7ftKCw5LVs/JkK96QPSehY9so7IsOuZi
         7W8U7KWG/1abFd+zrjPiiLEY5MbZoAlKw4i1GIrYW6oqXOn/uNhQZi8tW3g7kffJlmrE
         z50dfy/FbmklCmQoxdvGcb8P4hYvokLsNIs7XZm+m8ZuHMUglE70qUFil+iosDh6VJr7
         lIhAlLeBJaGSBtnfgXRM/owehx1O8cvesxlW3L4JjeymNCjAWBrh1lnNQGhn91AzQ8RD
         79DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715697722; x=1716302522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TV3+UMiVWq7CksEqEGh2EzKR9H0sUTyC5OVKuFe6yD8=;
        b=ApBY8FLtcHJxghvVgFOiRGfh29RTCc0YMc1hOaFpeifkeDSht8by6Q8HnKvVxK6JtY
         u/uHH8r8us8E/LNyf/t8TRQek/klk3+rm8GV993zfKv+FXX9FeXJyPZj2tUEnUclkeu2
         UVnSQhnraebsyXLQj5Oc7M+AF494oVVDRZna0OcsJyhXvBYrrE1tvbYXpD/usJzYTvy0
         lNHeBqgpgwgBkZTyX4YA4rA23Qt5uLcukhlWksy8qKuEl3jDKtDp/KxjG4dSgKpf4RHP
         Ec6243WHPUxPnN/tVSHSGctrzVqdziO7K/+pmtNLGP6+WN4pDBFxuKjz21USX1FqbDaT
         XviA==
X-Forwarded-Encrypted: i=1; AJvYcCVbo3DcpYm1qKhbs0P/7c/SCofnDTa7IO+AVEuH0W8I9VJwIASrs+Qj+moGyRPl9DmrcrafFm+x05mRycNHClfM42kX/4fNO6k6dJnn
X-Gm-Message-State: AOJu0YwHl5QhsHHs9JM/Vkk5hq2OELHFleyrKlj3UBNe1z60lsySudIo
	kkZ3fQ23wAlZCDWaz3FwqvTZVJQKkNjQeNt8PXaWRgygApcERbPTm2sqVVTzidSxKZuVN9nQJQr
	ldmztxwaHtgSqZCuWVYpTLJtGhYhNjW4LwUJrXg==
X-Google-Smtp-Source: AGHT+IGujis+OmK7qSGQIW3T6NzRMyAUeKIZKKlP8Yp3YXrxyht4lP+EfPBkY6NMjND/8JoX8seUVvgaMvO1hBkRSr4=
X-Received: by 2002:a05:6830:18e7:b0:6f0:4847:a984 with SMTP id
 46e09a7af769-6f0e9145ed3mr14588590a34.21.1715697721967; Tue, 14 May 2024
 07:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503221634.44274-1-ignat@cloudflare.com> <CALrw=nGhgRrhJ5mWWC6sV2WYWoijvD9WgFzMfOe6mHmqnza-Hw@mail.gmail.com>
 <D18XXJ373C2V.2M6AOMKD1B89W@kernel.org> <CALrw=nHGLN=dn3fbyAcXsBufw0tAWUT1PKVHDK5RZkHcdd3CUw@mail.gmail.com>
 <D19CUF0H9Q3S.3L5Y5S9553S5@kernel.org> <CALrw=nEZ07U9VhbGsnpchOYw1icUZCnuoHHXkJLzhFqSPe9_fQ@mail.gmail.com>
 <D19F74M6B8UC.2VEOOZHGOS87V@kernel.org>
In-Reply-To: <D19F74M6B8UC.2VEOOZHGOS87V@kernel.org>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Tue, 14 May 2024 15:41:50 +0100
Message-ID: <CALrw=nE_sV=1DnCx1eM8Sgno-di0yCaWHX467ZEf1Fddwg7_rA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 3:00=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Tue May 14, 2024 at 4:11 PM EEST, Ignat Korchagin wrote:
> > For example, a cheap NAS box with no internal storage (disks connected
> > externally via USB). We want:
> >   * disks to be encrypted and decryptable only by this NAS box
>
> So how this differs from LUKS2 style, which also systemd supports where
> the encryption key is anchored to PCR's? If I took hard drive out of my
> Linux box, I could not decrypt it in another machine because of this.

It differs with the fact that the disk has a clearly identifiable
LUKS2 header, which tells an adversary that this is a disk with some
data that is encrypted. With derived keys and plain dm-crypt mode
there is no LUKS header, so it is not possible to tell if it is an
encrypted disk or a disk with just random data. Additionally, if I
accidentally wipe the sector with the LUKS2 header - all my data is
lost (because the data encryption key from the header is lost). With
derived keys I can always decrypt at least some data, if the disk is
available.

> >   * if someone steals one of the disks - we don't want them to see it
> > has encrypted data (no LUKS header)
>
> So what happens when you reconnect?

We recover/derive the encryption key and unlock the disk again.

> > Additionally we may want to SSH into the NAS for configuration and we
> > don't want the SSH server key to change after each boot (regardless if
> > disks are connected or not).
>
> Right, interesting use case. Begin before any technical jargon exactly
> with a great example like this. Then it is easier to start to anchoring
> stuff and not be misleaded.
>
> BR, Jarkko


Return-Path: <linux-kernel+bounces-348714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DA198EAE0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C0C2831BC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4D412C7FB;
	Thu,  3 Oct 2024 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HOUu0PXv"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D25126C09
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727942181; cv=none; b=hRhVEU1ibmWQDzxmni5pBKxH3BdeKHeA9I3z2Li5+3C06wO4gIitfvNzhajTsFJvF+u3EjKi0RxpCqk1IS8oUnc72K4xlf3UXzNC7MmsBWn+/+8srVbcNaJYh3abEcit1UsW4QIzmYwPJSGflmGoBbUKMvjYZcEJ1Fs2CZrhUxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727942181; c=relaxed/simple;
	bh=v6ALvc4W24Stl4DcbfKSXH2YeE+6bGWlnQQLPePuZlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQIb3unBb0iAKn3j8VPHSu3XBN4uatlu4RGAWSsShj7i9YEDhmDKRH8nyIsMkOWsbmreww+l7wzYpybtg+CWX4R0B55pC13cHoVi04UcS2GFoNExM45O4mfiP23wW1i78LSkApccv90UR8nk2ns13IL5znS5EMu8hJCw6btG3ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HOUu0PXv; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c42e7adbddso650661a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 00:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727942178; x=1728546978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKyDwfp4Ml344QHsxkGSl5FGwY5UjFoy6Vbspzij4AE=;
        b=HOUu0PXvRUlRwG6A3NrFVfEIIqo6NrHkKLYNeqH2kXA8v0EZii/r5T8AOgJB2qcEli
         VUKchgLrjjSwUbiol/VZiWAFb6gKtSfgIXJboK/kzGdNW0lV9ZiClUp8DBlcR62cLy89
         dgkpvr1UM1xbhNPW7DfOTnUTQyIholapiKhfjiYljAX6W5+HskqrvaKUhUQdZHmv0AZ8
         29ZlsUk5RzANWOeBwPfapPv2T8UWzvWti2YSd3qZhJRBSNSsBDrs2kKtoxDPy/21UP15
         wHJxwo6L3S9bmurt/6oei4n5ztEDqY6hkUzdhn8vQjQemrgc+9KSTmyYxB4g9XOiveeA
         5a8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727942178; x=1728546978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKyDwfp4Ml344QHsxkGSl5FGwY5UjFoy6Vbspzij4AE=;
        b=txiOtv7XBECUEi9sKNGik7+YGxKF1m0Q1E3y7u8otGR3GRNAELfhoUzUf49BhzWMqR
         G6anWBjDuXXmut2fewzx9Cu/ojPH/pfJYj64cz/qyIvYxy9PDK/CC1IN+K9ijX06BhuW
         Vu3R86y4rrnWQ0wtzKT74LZ3PJQaW6Ux0n0Aiqh5ugqRzg1ZtBAAa1U5blArX1HxBlwG
         CJtCQaKsKHwLYwE6LswW46gkV5EfrDAGtZUUGPBXEUfLKBFvcQy2FpMRuTyUE3rzj203
         Uq5lMhYlVvQMHASIMZCkqVSMQ6E2ejtmwNP0bPo7swzA0aHUWY5hnp+ZlC809Eecy6DU
         sthg==
X-Forwarded-Encrypted: i=1; AJvYcCWFR+qlPSUkmoRJwcTVfos2ha+Ge9+6oDKhOj1IEKuOnO7YG7RrqquMuBUPA+E81XlhZdC8wZ+pknjprC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6jjpNGfJiKhuu91rd/cAPolQrHOLSTscsc1RRtpzNZMq7iSY9
	P4gejBxeHgX5LTe142VWcodYQtQNgeuHsDpUQOw7dCDvjwdGuoKL7k1EIG5XAsnoOoWICHU+AJW
	zMUCG5rAL9d5jYbttf9GgnFDVBbMqKb3rkiRP
X-Google-Smtp-Source: AGHT+IE1lXB/OQzfjadu4gqLsX6vwMaut6bPbMqb3wk8B2SU/Xr68rxVVKC73SYNSrAzyFVbSIuwVtACV3a0DRjhV8w=
X-Received: by 2002:a05:6402:5255:b0:5c8:ad38:165c with SMTP id
 4fb4d7f45d1cf-5c8b1b77ac0mr3450082a12.23.1727942177451; Thu, 03 Oct 2024
 00:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002053844.130553-1-danielyangkang@gmail.com>
 <CANn89i+y77-1skcxeq+OAeOVBDXhgZb75yZCq8+NBpHtZGySmw@mail.gmail.com>
 <ff22de41-07a5-4d16-9453-183b0c6a2872@iogearbox.net> <CAGiJo8TaC70QNAtFCziRUAzN1hH9zjnMAuMMToAts0yFcRqPWw@mail.gmail.com>
In-Reply-To: <CAGiJo8TaC70QNAtFCziRUAzN1hH9zjnMAuMMToAts0yFcRqPWw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 3 Oct 2024 09:56:03 +0200
Message-ID: <CANn89iK7W1CeQS-VZqakArdZqZY6UQi2kCDcpUmL4dGjAQwbCw@mail.gmail.com>
Subject: Re: [PATCH] Fix KMSAN infoleak, initialize unused data in pskb_expand_head
To: Daniel Yang <danielyangkang@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 6:42=E2=80=AFAM Daniel Yang <danielyangkang@gmail.co=
m> wrote:
>
> I took a look at https://www.spinics.net/lists/netdev/msg982652.html
> and am a little confused since the patch adds a check instead of
> initializing the memory segment.
> Is the general assumption that any packet with uninitialized memory is
> ill formed and we need to drop? Also is there any documentation for
> internal macros/function calls for BPF because I was trying to look
> and couldn't find any.

Callers wanting allocated memory to be cleared use __GFP_ZERO
If we were forcing  __GFP_ZERO all the time, network performance would
be reduced by 30% at least.

You are working around the real bug, just to silence a useful warning.

As I explained earlier, the real bug is that some layers think the
ethernet header (14 bytes) is present in the packet.

Providing 14 zero bytes (instead of random bytes) would still be a bug.

The real fix is to drop malicious packets when they are too small, like a N=
IC.


Return-Path: <linux-kernel+bounces-523725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0311DA3DA6C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87AAE17E843
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2082862BD;
	Thu, 20 Feb 2025 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JpqXsoR+"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A051C1F4621
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740055804; cv=none; b=sTjsf2oeh85yH0K+mQIHtUgm82dx6B96i7nkU6vLHzsphRAyxHttkZf3WYOJ1oct0LOA2QH1mia0XtQq42NignO9IgQXF+PUYXSF8+GS9tPHFjlfeikkGI+kRTMXsAU+6XfTBh73T5Txhf2wZ+VF08zbYyAD1wkZkaqK8dz3DB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740055804; c=relaxed/simple;
	bh=a0PT/zYjUBX1CAQ+XujfRq72lOvLUx4ndg863LM0GYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=dm0Ce6pBEOL+z3odD+pR27qurymQusFCKJJYHcOvx0BioKjC3UpApSRgFYhcePDWbfwhAZxxUiuBuEOsxyG0ipy19uurX0GIyVZaL7qcD+Ca66PWZBnPJ5ChnrCBKTX70TmsUZ/aucmPytQZM96uoco7LVibIgr+PeDegMXi90k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JpqXsoR+; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2bcceee7b40so509291fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740055801; x=1740660601; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTfGIbJp6fhC/w4BZ7isdk+PvinNZ76CiVG8LL6lKpo=;
        b=JpqXsoR+8bRCZvDn0NfM12AINfknEchhKOFp5liQ9hgioczcsaUCYTmxpB7nRx09O2
         64WO6dj4WTp2qGXtt0++PaJFNdhAabkwXRPouE/5Ji1k7QUGEGMb6KFwBkAQgBHMPhrJ
         8WlPK7SeNVExIlU6wUQQAwtCcUoSiceW55ZGWaH0WSbzUP0PIudVirfsNm4uPdzdngAL
         owgHl5nEysjwlPsz4o9lvamjPxozZb1tyPNHwpT+uSuSKJn4hRp3vn1XiGJsO/966gW3
         9PNUjH/6GWPvjCzryx+xwRtG4uhFO8YdCJfXxbCFJ+5YVxkeCWaO8ZDN0qd+kxG4IzNf
         jGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740055801; x=1740660601;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTfGIbJp6fhC/w4BZ7isdk+PvinNZ76CiVG8LL6lKpo=;
        b=bRP2wn6xHON3s/ygC04oUKwOt0Ar5fgiCy2935p16qMtnisAI0ZALjs7ndiyLlQx60
         oumKwr+0e475I8h+eVTkMEhuMC7h0g+QfgzUTxj60mjeKHGAlafmGdDX5Nkm/Zwo8mXL
         k4hgXNRpB2PrtfaLd3Z5jfV0d6fnA1X/k0KV50k6C4oRA33VS5aq8XC0+sZ1t6X9vLxZ
         97Z4XxPJy6oQVLyEuaAGunKo3dLVgLhZCYsQz0Fy2EJrWai8Ll2Nd4Urujv5k8FF8CUy
         1H1A0oSm2g+qJPZw/QLPLIqPNA3qIT3kTov9N2HkxaqJAcc+4avBbDOzONl3nXJaWjA9
         bVMg==
X-Forwarded-Encrypted: i=1; AJvYcCU+hiivZvbom4+kGQm/y6+U1UXBvIfpOeDDaBFEXVn+i8AmTlfrcYGzCQLvYsMtIqYZGvkCknbQm1Fk30w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLgzvylJdoaPLQssh588AmXYnj1oYM4wVvS/rLhy4y0esD2Dw8
	vqJr/CSv/4++vT3OD53sIOZ/YbsnyUL5yvRkFcgFjQp+undTF051E6yyO8SEFy8gG3VmmOOA7Kc
	UHHBcbs6ALluMdDMfOjcJJDeQjcfaWmMMbGefqQ==
X-Gm-Gg: ASbGncvAjCjsFRY6p76r9fGAGMPwWTuAv0Rm11VqUtYEYNIP5vKnOxs7pejVTTMZATw
	xhClXlEHyPHWEqh/Zl4Q59HBraKzoMDnnbVe0/3dRjsLE6VB7Il3egt+IPGdFH9Z0/0tC2m1x+J
	w=
X-Google-Smtp-Source: AGHT+IGIeSha9ryJ4U6TNKD7NNbEQ23H8UG2ezxZgZgwtAZvTe3i8zmcKatkatmxc3y/HKvR41GIkGPVCLafppRCyKE=
X-Received: by 2002:a05:6870:c0d0:b0:287:4904:7125 with SMTP id
 586e51a60fabf-2bd101dc2aamr6466422fac.14.1740055801566; Thu, 20 Feb 2025
 04:50:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250126033243.53069-1-cuiyunhui@bytedance.com>
In-Reply-To: <20250126033243.53069-1-cuiyunhui@bytedance.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 20 Feb 2025 20:49:50 +0800
X-Gm-Features: AWEUYZlwmLeNnklE87AV8-ot6qsm-JKfbacka5KbVT8dpuPOHW-YZs7w_qsGCxc
Message-ID: <CAEEQ3wmk5jBOPqD-5GUZ+463mcG919uuKVnBJrWedKLssVDBaA@mail.gmail.com>
Subject: Re: [PATCH] locking/mutex: add MUTEX_WARN_ON() into fast path
To: peterz@infradead.org, mingo@redhat.com, will@kernel.org, 
	boqun.feng@gmail.com, longman@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

Gentle ping. Any comments on this patch?

On Sun, Jan 26, 2025 at 11:32=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.co=
m> wrote:
>
> Scenario: In platform_device_register, the driver misuses struct
> device as platform_data, making kmemdup duplicate a device. Accessing
> the duplicate may cause list corruption due to its mutex magic or list
> holding old content.
> It recurs randomly as the first mutex - getting process skips the slow
> path and mutex check. Adding MUTEX_WARN_ON(lock->magic!=3D lock) in
> __mutex_trylock_fast() makes it always happen.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  kernel/locking/mutex.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index b36f23de48f1..19b636f60a24 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -143,6 +143,8 @@ static __always_inline bool __mutex_trylock_fast(stru=
ct mutex *lock)
>         unsigned long curr =3D (unsigned long)current;
>         unsigned long zero =3D 0UL;
>
> +       MUTEX_WARN_ON(lock->magic !=3D lock);
> +
>         if (atomic_long_try_cmpxchg_acquire(&lock->owner, &zero, curr))
>                 return true;
>
> --
> 2.39.2
>

Thanks,
Yunhui


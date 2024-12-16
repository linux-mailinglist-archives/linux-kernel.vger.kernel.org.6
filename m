Return-Path: <linux-kernel+bounces-447666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDADA9F35C5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC141697A8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE29202C3E;
	Mon, 16 Dec 2024 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="qCv+8yRB"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7351898F2
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366020; cv=none; b=lg1M3suT7iBHbXRjH7WjmNFVyU3q6kRGsSZctNkVFGFshSCIlL+1ehfverzJyu1ItNHGbkZNO/hm7vmN788tptrjvzuuBQG9CHWDZdWeBVHvRqgsFTQipgorn5EqhC7agP3Xs8v8NWDZW8SRZNkjN9tKRhyuz4Qx9Hz1QnKHTYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366020; c=relaxed/simple;
	bh=eWoOBHPDJmcteLCDTseNxkpbt8QoQjJ9yTA38acY4W8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5q7hRX1wNiLWi5g6/c4x4JY+HO9DcyEF/NvKYw9S3no5XR7tGjAj138de12/NKu5BBUrFrhDj6Tx0UPYDppfekYfHnIOSaCTrdukvAt73Ejc97tqikclUpVGWe/2NTDG774JJiKrywEkD44R8nUY6NP85j+K499UkaZ/AZk3pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=qCv+8yRB; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d437235769so7338966a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1734366016; x=1734970816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWoOBHPDJmcteLCDTseNxkpbt8QoQjJ9yTA38acY4W8=;
        b=qCv+8yRBMdZT/h9HF0PJpS8m5ygz+KhdLd4QJgPA8ZalK9D0BKOt7CRb0WF7ucBIEK
         lIldP+Q2jQQE82J+Xeb9lZq8DcVPjhG3OSIV/TyrijAM5SXTCv+/JvPjiSg3npeArpmZ
         L2suKQlhVVt8p3l5X7gw6jIJiEwdfiWInzAomg0o2UFXsqx4YFe52PsLX7qsDhcsAL/8
         a+ucKJMkbYfIopsOLww8IXSsd9Dmus1raEyO1wR8GWgpLuCLxpQKDo7pjx+k2/7NXbvx
         ircLkSF5BSejJ5Q33TjmNIR6oT69NFpWyEEuEbL8JJSkfom+leS+61xklbD/jVpYArXF
         xzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734366016; x=1734970816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWoOBHPDJmcteLCDTseNxkpbt8QoQjJ9yTA38acY4W8=;
        b=h9e/6TJ2HL148LpewUBEPwUq4PYlInzvb7VVcdIrz0+cMCUfUwR5BVSzbXURP7HjHK
         McZdZc0cfLds3fVDqt7g1bte1KCtUXncjS/6EwDhAgnalx6AROQMPVgtHwuKPoDttcW+
         5tJl1oxVeDzoR3JVnoIqLK1m3XVRcniU+Zqof7gY03zrvkk6az/kM/XPTr8HMQwwiapt
         M2DjADesqCK12XrXe5AJuxAqBSlym4OPgHNsK5CEEPzgPTwWcWqzPiak+PUcggdoPRZp
         rdUVeA4tt/Rnux6A/FpX40Qstifhma5EiJYFz2FW8QC8nahH1dG2Ow809KosjgVE4VAk
         0dPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZidbVZdHnFFe1jLTYPEEsU3p0bKGPyfFskSSC0qApKrkgvV3qMRoB9xT7XAn96wPlGaRgA/cbfm+o3Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6EUInY/lKuucfyggZXVG9oNVwTKB4V7IM5Kmmcx11QCsvXDh5
	xBLz6AEqg3ro5RqjUEVNKYTuqoZJ0pQn2kSbx9eIJSRT7yi6vTmol/wTJGa3kWoPC/AbFR807dE
	tdGIEtaX6RdBFAFF37pwLxFnXr2/fdeP90B9dQQ==
X-Gm-Gg: ASbGnct4iksezUdiawywwjZZ7tryeadLJ9tGhgoA61HNLrx7+ZHnoGyNVciKDeAL2to
	+QSiJPsds9uRlocZ+CwW4ISkCNz/yO51uheA0LkDfK39iMU++vPa2Sg==
X-Google-Smtp-Source: AGHT+IHol/awQfY1ljmVfT/oHEcR0WUOqBOGCTerL1qGCz+dHa5zZojk98zElKTsZcL+frHiYWPGH0/LMeYQui5kmhA=
X-Received: by 2002:a05:6402:270d:b0:5cf:e894:8de9 with SMTP id
 4fb4d7f45d1cf-5d63c2f8cf2mr13942816a12.3.1734366016562; Mon, 16 Dec 2024
 08:20:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213190119.3449103-1-matt@readmodwrite.com> <CAFULd4Zrnn=1=1AP329Qw23b0Ume2A5Z-U2q-M62L1gcpJD4pg@mail.gmail.com>
In-Reply-To: <CAFULd4Zrnn=1=1AP329Qw23b0Ume2A5Z-U2q-M62L1gcpJD4pg@mail.gmail.com>
From: Matt Fleming <matt@readmodwrite.com>
Date: Mon, 16 Dec 2024 16:20:06 +0000
Message-ID: <CAENh_SRw-L3UtBiz2xg_X4szdMJmNg118gL8f2g8gN5w6hc3Nw@mail.gmail.com>
Subject: Re: CONFIG_KASAN triggers ASAN bug in GCC 13.3.0 and 14.1.0
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 1:17=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> Does your config include CONFIG_UBSAN_BOOL=3Dy ?

Yes, it does!

> There is a rare interaction between CONFIG_KASAN and CONFIG_UBSAN_BOOL
> (aka -fsanitize=3Dbool), reported in [1] and fixed for gcc-14.2 in [2].
>
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D111736#c42
>
> [2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D115172
>
> Otherwise, please attach your .config, and I'll look into this issue.

Thanks. Disabling CONFIG_UBSAN_BOOL does indeed make the kernels boot again=
.

Should CONFIG_UBSAN_BOOL have a dependency on GCC 14.4+ ?


Return-Path: <linux-kernel+bounces-347453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 804A198D2EE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3511F231FA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBF21CF7B0;
	Wed,  2 Oct 2024 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnHJrHwx"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7DD1CF5FC
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871512; cv=none; b=qUV0q97wpYlQtWfxqOaxG1iQbYpuCwJJRw+SNzEh1fANsn0C7tuxUQDZa4nXgXcDYvxHA98V3ygkPL3rYPmNdFNM49qYjytWDJ6w4I2+RCDD5hbCG0fj7msjqfKQr2CpTlmbjwEO5/JvuA2T/m6h+UOyQiFg8A9uDGN63Pc+IvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871512; c=relaxed/simple;
	bh=uGNZdDkCWkPKAuzy4q0Y//VI7T6h5ZAl+IARXwylOBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YiNfvKDk0keSrdvPNwWsN0Xl4zTH4VeHNc8H/uFclf4GN+3jcGXYetUBqb3L3ofok4QCIWwePko2UbK/Q9hO/0u6kotsAuoqhtJeiYkTbbiH9rVeKYSttKxdw3wYw5hsOtMeCWKvpd35w27Z1GQRANOJ+ckpjSZmI7pSoy9Xr0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnHJrHwx; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7e6bac92bf6so519827a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 05:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727871511; x=1728476311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLHk6qyX+KxXQZXoguk0VCv3z0DziJl4ivpGk9dzOKc=;
        b=JnHJrHwxoajrPa87Iolcaya7+8xpkIfjQEpCprIo3M9uVaM0PkTC/7opa5D9bxxrYT
         sMJFJFTLoCpdUO1hZk18KpZsuSzHhhorlpUF8PB3KtcgaV6XfPWPgN5REOcPKyPXrw/t
         jA2+ugdbPxeOhALTcwO9Lo4UKNiZw7Ye7bg3hztTgvajK1KNIRe+NeqHplYMDvglW2Bq
         85trl6ubdqUjj3NLA//0w7VRGk4luY13pjdqOeh8ThExEAnpSqZASQBPGmPfa8FNGNNT
         itvLDj/qnYILIeHm3e/ymNe9i2GzDhUrPZtNO6XjpNCxFSJ0c4QmrzMyIAlow7XmnDDO
         EaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727871511; x=1728476311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLHk6qyX+KxXQZXoguk0VCv3z0DziJl4ivpGk9dzOKc=;
        b=ZcGpNGgmlf8IDwlDzGRaIDjbMgchRg1+gbEM5EAOPc9iebWUA836+1SBGh20RbZLHG
         Dch4pj/1mGDQddeX9OtDW83PyxOyW0yCtdW7hqsXRvbPEUfGNxJsFLeunGSm/QU+uHeg
         rEDgm9fKCM8xa9L2G4wB7YRANTr5bhWHPDEG68aW6QSsqToJJEi5PeSummr0uRgttaYI
         O1/KCwAY4P7ol07xz6ToVbFRAazVn49PwNaqcbJNZqtYrVrKK9E2q6YpJLAunSRt88Ic
         GGNqaZDMANY/t3rK8zDKNx6hJ3UHeUptspjl6ppffCSCN8de6cDAPaKr+0ADMV5TyYUH
         +3ew==
X-Forwarded-Encrypted: i=1; AJvYcCU+4obHHwzwdljWcULyHEM94IuHbNVoFiS/wMkNn10qBflQ+JcyZAvTnfuDpMqcOgX63lqd5pOY+Fy78yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YybROzUBA4Un8D5QOwONqcn0Xc4IXMxsQkgJkIi8EFc+SgebUPL
	n6d6w9nQ6pHEMp6Y+5k00jITWvyX7pKf0rCoYSynk27lM9QzAJ7pfVeYH0g5wkXHz0/GetdYrSK
	0AqmqolkwIgCU80a7wkF3Vo+C8UI=
X-Google-Smtp-Source: AGHT+IGF5j0aXGll4TThs4I1LIeq1mOzv2ZlFFE7Q6xHEmghUYy9bACm7UZseHcqaIpGrFl9LG+rTd1SBKcNwl5gNlY=
X-Received: by 2002:a05:6a20:729f:b0:1cf:217b:46ce with SMTP id
 adf61e73a8af0-1d5e2cafafbmr2439681637.7.1727871510721; Wed, 02 Oct 2024
 05:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1e82c551938c32b4dbf8b65dc779c1b772898307.1727853749.git.geert+renesas@glider.be>
In-Reply-To: <1e82c551938c32b4dbf8b65dc779c1b772898307.1727853749.git.geert+renesas@glider.be>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 2 Oct 2024 14:18:15 +0200
Message-ID: <CANiq72=L2XVh7a_dJpmtMzK554dkKRj+0FDd7OdVY3+UMmirHg@mail.gmail.com>
Subject: Re: [PATCH v2] compiler-gcc.h: Disable __retain on gcc-11
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Tony Ambardar <tony.ambardar@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Miguel Ojeda <ojeda@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 9:25=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> - * Optional: only supported since gcc >=3D 11, clang >=3D 13
> + * Optional: only supported since gcc >=3D 11 (partial), clang >=3D 13

Hmm... "partial" does not give much information -- perhaps something like:

    * Optional: only supported since gcc >=3D 11 (partial, see
compiler-gcc.h), gcc >=3D 12, clang >=3D 13

What do you think?

With something like that:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel


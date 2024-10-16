Return-Path: <linux-kernel+bounces-368632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 884789A129C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D795AB210B6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9122141C3;
	Wed, 16 Oct 2024 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fto4zm8j"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAD120ADDA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729107189; cv=none; b=DXXMX/+tLK0XgH/fh6r6hwYFnfrtWLCQJpXTSloszRvzJkCAcSotWjLe64bz98fg1fpzp6ZTe9vqH2KgFFqKobc3uAkaWrrxjTFKxsbTgyZtD8Hc8/lw23/gyXlSArtVItH4OpdVq7cG56Hl2O5pnQz5oxuSpEWJXsiHV/ChZFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729107189; c=relaxed/simple;
	bh=A0/ojgL2fvBi172Wbp3BrgprcWdWI/pifihLOrfrqFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DyfS+s47/59THDC8oQp8hcnpl/wLrmhsSPwYJOnuZ/6hh1egxYHE/OZFdiLaNnR6+buL39ELLMAuX73A54fvEefwDpQZ+Qgt5azCvbUM2yxCcxEGbFnYHVqknQOTMUy5hLJWY+cl8DiB7Ycvml2xIotMkb+xHALHahzwHbY75cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fto4zm8j; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e38ebcc0abso3451217b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729107187; x=1729711987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0/ojgL2fvBi172Wbp3BrgprcWdWI/pifihLOrfrqFU=;
        b=fto4zm8jEXnrZwyrpLSk5wFdsLKwuNQ/MKYiEiwgJu3nGAyxURoDzpcc6WuvQ5EPlG
         TreAAUM8XekH1LN01v64Yz2d7TQO+rZtNRKQTKCPT07zskLzxDeoViqpLEfgaRSdv2S9
         lugKzScVhNtzA3qj4wIDd82kJYoWmapBCb2k7mVTe6Py9AcN6Ncem8iDFH33q5bQMj/9
         DNshxbxJJ4pTbjPG0mg0AKDBXA3O79cstPamh4zVOpO0SLMbmVvyUCc1rqbGS3p/vgh0
         YX4sXDk3T7Ul1BYZ9wIsDq6UumjJMPGw+N3/rOraIYe7t9vhK/3wAtCSWmUwm4oNMZ8g
         bKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729107187; x=1729711987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0/ojgL2fvBi172Wbp3BrgprcWdWI/pifihLOrfrqFU=;
        b=gl/0H60D609caF4CTstyatpNaEJVKMPD0ih8s2viZJd3uSXJJVJ5OWWmn4OLkCSGM3
         yFfjwJKGMOvivq7pc2hmLjU7xI2m4YVs0khY2HQDhr21CIhWcOaMtVM+/qS8r17X2pSv
         p1bShVH9xQLD50Nv20BYkOcJb8/MnfGP00F6Ka3y7N7Q8OngDG0laB84JacmqY6IxVNZ
         O1e3Lc+5bvYgLO7OSakjhzMZQdynSNVIe3EJxFKAX4ggSfQCUPwZiSawkmoZ9kYNpiOC
         SYFIa7iosguHEbDXqKWKisuItOBFy4QqjRACfy2GzryxV6BvXK0/2RFqGwHY/OOPUyOZ
         e0jg==
X-Forwarded-Encrypted: i=1; AJvYcCW8iN/hIiXHGioPyO23xFDYm0kWgk7eIiQskONV2J5P8UJTtH0hWfNnADXfsEVFAWVoAdUSMJHWePnJOmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyeHBR0QBUWsYcP8zcmQesdUgTVM4A3tQyUrvkKhQyZpBQzYjP
	D5jwbuvG6XquKevS0z2R6gUXVt2bbRpRo1WYecgFbziUIia43pRbJ0C9JGGvLk6KLvaugtsI9gA
	8Txxo/1FXMYJuQ0fJk8P+Emxdh4SOUn2zZTMyhg==
X-Google-Smtp-Source: AGHT+IGX07jif9j6w8MTv7ARHJ9/+lXGQIE504CDxiXkTKXqPtoikEAqB670DW1Rp7uFgjkSTFhaEJvJ5+tdTlNVD8w=
X-Received: by 2002:a05:690c:388:b0:6e2:e22:12d9 with SMTP id
 00721157ae682-6e3d41d08c3mr58083187b3.35.1729107187330; Wed, 16 Oct 2024
 12:33:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016155655.334518-1-colin.i.king@gmail.com> <CACRpkdYhsnRSOgdrDKp7BNqE4TpY3r--cPByFMsq0VRRjW-sAA@mail.gmail.com>
In-Reply-To: <CACRpkdYhsnRSOgdrDKp7BNqE4TpY3r--cPByFMsq0VRRjW-sAA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 Oct 2024 21:32:55 +0200
Message-ID: <CACRpkdYxsGC5Yay0dOaQEegrLKKkLrcivX7_GVpfQsEa=psdDA@mail.gmail.com>
Subject: Re: [PATCH][next] pinctrl: th1520: Fix potential null pointer
 dereference on func
To: Colin Ian King <colin.i.king@gmail.com>, Kees Cook <kees@kernel.org>, 
	Kees Bakker <kees@ijzerbout.nl>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, linux-riscv@lists.infradead.org, 
	linux-gpio@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 9:31=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
> On Wed, Oct 16, 2024 at 5:56=E2=80=AFPM Colin Ian King <colin.i.king@gmai=
l.com> wrote:
>
> > The initialization of muxtype deferences pointer func before func
> > is sanity checked with a null pointer check, hence we have a null
> > pointer deference issue. Fix this by only deferencing func with
> > the assignment to muxtype after func has been null pointer checked.
> >
> > Fixes: 1fc30cd92770 ("pinctrl: th1520: Factor out casts")
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>
> Patch applied, added Reported-by Kees since he mailed about this too.

...which was actually the "other Kees" (Bakker), not the one the mailer
suggested.

Yours,
Linus Walleij


Return-Path: <linux-kernel+bounces-556287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF7DA5C3B3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE4F17A9E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB10B25A653;
	Tue, 11 Mar 2025 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Nb9rqbhC"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737A619AA63
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702933; cv=none; b=t0MdmVLy4p1eqSnD+rqov7wXZlCMhSqZpIGG8Y4JEaHv9vKZRvbtH1LHQ79if0TjCeg3B4uto7xPVO3QmuSfpCCILs8+x2wkVTKUPedGaDrKwjUfj1hpqorXADZi7vfWpbapkW4piyCPrL1viRLAl8CGk6DPFjAOr+yNj7zlqT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702933; c=relaxed/simple;
	bh=Yoe0EetL2HTzRcyD7RhgBZqgnaMXKmtHlUgH2pP6HVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5StTEavRrLx72nKBn6zG3TqOaYrBX0wPBZztFZ3hsUJ2DhkQCjq+GGhNPmTCRemGXSPhQMYl7W6ogLQxLCChn2MPEOUlRwOb6FvjBuCYvZcOqYP49vJUf0O1wIBhT2bwfXSyVPvgLjjwWXQLJUZdUg6W+EW6zGbcu4TnutaMxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Nb9rqbhC; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54298ec925bso7298895e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741702929; x=1742307729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yoe0EetL2HTzRcyD7RhgBZqgnaMXKmtHlUgH2pP6HVA=;
        b=Nb9rqbhCwCXDKIUeqf6QTaYxINsqPuggKPuku+fcxasriZmEEVYluUHQsL0poPgldc
         8kcwtpSuF45VabDZ5jIcrGb6c1NhPIsQ3dA2eqVrdMQ3e4KUYgo56Rmu5jd8vFUQWVjx
         m1/1ydmtIEd9rTgEP1wjZK1cLC/c3l9cCqZo5VeTMjvbdELCt2OkyR8lCCZwx7yuCm+2
         gZAg+kOvRKkQmke0YIhs0XatHBIKUMMhs+WhwRXD80xWAoPyEWPPDG/4BAlOqRUnkIko
         5bLLv83qjpov5Ar33nGyVK1tKnEw29MmZVwIeBhMavlSi5G/kv9lsqTTI6NzhOhBlTmi
         gS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741702929; x=1742307729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yoe0EetL2HTzRcyD7RhgBZqgnaMXKmtHlUgH2pP6HVA=;
        b=kgCo2U0BA65yrof9i1VSiKO9W9UeGVNpMQCtSlUSNTdvfeo8/UnryuHKz8b2vDUMGl
         OHw1i11iBXZoshtBiY9J7fqdoO0GZMT5RId3ovpP2o2y6zTnQJLN8K/Y/l6Gara6l1pS
         /5nTQZ5AKd28ENmLZrPK9GM1rJsskjGa8jcrM5GGvNdnJZ8C16Kj9ZFd/ropXe612ukl
         XPAkrxv5buT2ra4Et9ZI3ruX+Ing9MeRl0LSE3RilYx+NbHOwGbc4tNhlKoAanC0JgBm
         VuEG7sfyKaRMSLoh1d73txeejmlWf9BB9u3xut420Td5s+K1elNsI8Ao0M9m0QpHEbY2
         3s1g==
X-Forwarded-Encrypted: i=1; AJvYcCXLqRAdnB86BbWGjt2QkNhQCv2SkuyL5lwpDRkcNRILBCCie2+6TdrdXG56bljPWIp1yuUtK2lH/fY6cXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAqLFF9pkaMen8flNPxrldWzYWsj8sYRR/zb5yFf7hwz/lPzkk
	cZbBXYmXCA8JAYA7TzFW1tDiZ7WiYMUtPYaHTORoiQ4OIFpp0DN0gWfcarvb5C7nklGeNUzd0l1
	Icmodz8TocuDsLwareuCY7n2Q1brCzA3Ic1o7Rw==
X-Gm-Gg: ASbGncsaTij88whZv0V/6RR8Xsdt+wobrmbjdkNzlz46/PU1xHoEePvxv5Ip6ALJBqa
	rJ1JuFhYcrFjOoWbAVx8S9B7r33b5kxKcdcV59u975QWUbY2yJ9xwa66tYWIWHPpzDbOX22R/bK
	u/UcSpGOLsRLPMO4OZsUT4tlY3RpNbxsV6jeGxfu28ynvuHnx5lCwD/gmZ
X-Google-Smtp-Source: AGHT+IE3LgkrUS30nZJ2ZL9kzRQ97qlgQWOSjI9T0R37yASZGbgrQ2va5A95+qBJFrkCCE8JA49DbZg5SOm7a4n4YYo=
X-Received: by 2002:a05:6512:39c7:b0:549:74a7:12de with SMTP id
 2adb3069b0e04-549910da821mr6192297e87.48.1741702929498; Tue, 11 Mar 2025
 07:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311-gpiolib-line-state-raw-notifier-v1-1-d0fa44fd67cc@linaro.org>
 <20250311145407.7e05b5d9@erd003.prtnl>
In-Reply-To: <20250311145407.7e05b5d9@erd003.prtnl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Mar 2025 15:21:58 +0100
X-Gm-Features: AQ5f1JolU0bmcAi1zO0R3geoJIVzfPF4SSeLlCp8d_ghGO5BqfOQp5s-WkYo-_s
Message-ID: <CAMRc=MfESnTFU1mRDs8nW7BE+y=xTWGuN8s-yEg9ningmsXpvw@mail.gmail.com>
Subject: Re: [PATCH RFT] gpio: cdev: use raw notifier
To: David Jander <david@protonic.nl>
Cc: Kent Gibson <warthog618@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 2:54=E2=80=AFPM David Jander <david@protonic.nl> wr=
ote:
>
> On Tue, 11 Mar 2025 14:19:40 +0100
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Atomic notifiers call rcu_synchronize() in
> > atomic_notifier_chain_unregister() causing a considerable delay in some
> > circumstances. Replace the atomic notifier with the raw variant and
> > provide synchronization with a read-write spinlock.
> >
> > Fixes: fcc8b637c542 ("gpiolib: switch the line state notifier to atomic=
")
> > Reported-by: David Jander <david@protonic.nl>
> > Closes: https://lore.kernel.org/all/20250311110034.53959031@erd003.prtn=
l/
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
>
> Tested-by: David Jander <david@protonic.nl>
>
> Thanks!
>
> Seems to work correctly under some basic testing.
>

Thanks for testing, I'll improve the commit message and resend with your ta=
g.

Bart


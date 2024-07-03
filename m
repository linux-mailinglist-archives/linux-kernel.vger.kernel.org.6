Return-Path: <linux-kernel+bounces-238614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C17924CE0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 02:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4ABF281873
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DDD2900;
	Wed,  3 Jul 2024 00:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Pt+dAVqi"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A411396
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719967874; cv=none; b=RlfEYCiTmWfhZm5oD0CRsqQPWOgCBE9Rw4aEHEYuHMVUaZjuYOtNXGc5LxcSZrU9kEUCHmQEMlKdA2HRTyUenzETwgMyPjfjAFCqatcuWo13HvAJowPQnrasbO43KGhIwCdTWY/qy60vsRM/B0SwuDgSMzfsQL1Wiq6Xu7Xyins=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719967874; c=relaxed/simple;
	bh=Pay9Jch50YYBUEq5gYVHpCB8quq1U7sQk0+t7t8j9kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1Ya1S4oaoKkOR3x9DYcFxXPwAIByqdDAo6AZFUMlnavAGjRVMNzunJD8yhIk4NuEOxBxPUVltwR8DspeYvAl9HBubNn8dJzCoVg60ota3nJZu+1ppmDDZf3B/diVvbh7KXTlVAjw3fZsVjd/TOpx6W8Xu1XyMr3xB2xR2WU7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Pt+dAVqi; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52e9380add2so1431849e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 17:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719967870; x=1720572670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J71lS0vEj7xidELl6507Qotv5/zDiOIZkTdz6g4J3Pk=;
        b=Pt+dAVqiZMYt81HxAU6G4MtDlAzDUxwVAEK9wZFkppglFl3OtPAhauZ5yZqo1y34CY
         Wu2OcOXRizm4wByT+J7tG5hMtdSi06QQrzZDL7J0H0/i8rJfijG+sNJ2hu7CrI0NaeSd
         GuU48k8HCJxl3okpSBmAZs+QHle83fp9DFsjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719967870; x=1720572670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J71lS0vEj7xidELl6507Qotv5/zDiOIZkTdz6g4J3Pk=;
        b=LPeTsZaaMH6erpBIjH46/7huJpWpOF9F51IEGeM8mrNF5cf7j15UKX2TnyRODOBGAq
         2FBXbKSmjVxrc9b9f4nFX8M1b6ImG1rUuSbaX1z9d2ETgIeOr454xAUb3C8XpXrjoVP2
         Qvrnpw5bk96i2CZywBu6lhjampI82N5KXWZZt4cy57VG/MXqBJciK7cGqBBXH3QpbVu4
         WiFkjvPt15wDVsAhiUelxCuPPpjXpWZ/BrIw2xfb+CmoiC/rzLc4a2i1nEXjkp1s8mzM
         RuzsbUv71Gc8E8uElKiclnvMim7w0VfPuO0sKT0wZeQo3qEkB2dxp1VIWHz38vbHqRyc
         WYgg==
X-Forwarded-Encrypted: i=1; AJvYcCWBH447rlzZFO10BXdNYUYM1n9q9AOF8wQH2j64w/O3VjLXfPY72RfKg38HEpls75hm3L7xUNqdVESgRP1Ycp+adAcGqjGdlUfDJUJ2
X-Gm-Message-State: AOJu0YwwXbPxOSQPuVM+IdpHdE257NCURgMVvBhjVGCyMvlnLorV/vrX
	vvEEkVJ3jI6vdi0Gthor50ke1BIrJEZ74h1QB/sXvy89qUznr1Zl+uEhqcbJvBlYLmaRBrc71/f
	uR53vHA==
X-Google-Smtp-Source: AGHT+IEa94ThEk1OUj2qV3Il0DMhFJpoyoA4oHpRJdun2DcFlNtQlZUaqlo7d4GZ8w2GWcICkxP3Cg==
X-Received: by 2002:a05:6512:32ba:b0:52d:215c:4111 with SMTP id 2adb3069b0e04-52e826679b8mr6896416e87.24.1719967870464;
        Tue, 02 Jul 2024 17:51:10 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab2e670sm1966722e87.203.2024.07.02.17.51.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 17:51:09 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52e97e5a84bso99497e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 17:51:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5JZwwu46i3YSPu72j6SOw68SAutywaeqyvxI1HyJIHQ2ZycOIERbxHubQ4DS1SDRHbBM5Rl7deTtomq+ETbMzwm7ixc/65MSSP/hO
X-Received: by 2002:a05:6512:114b:b0:52c:8075:4f3 with SMTP id
 2adb3069b0e04-52e82687e84mr9050700e87.36.1719967868527; Tue, 02 Jul 2024
 17:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503081125.67990-1-arnd@kernel.org> <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de>
 <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk> <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk> <4bb50dc0-244a-4781-85ad-9ebc5e59c99a@app.fastmail.com>
 <CAHk-=wimJ2hQhKSq7+4O1EHtkg7eFBwY+fygxD+6sjWqgyDMTQ@mail.gmail.com>
 <alpine.DEB.2.21.2406302009480.43454@angie.orcam.me.uk> <CAHk-=wihNu+_bGwD8F107ds7Lv1Z6ODTwvYYvXeW3im1=4R65w@mail.gmail.com>
 <alpine.DEB.2.21.2407020219040.38148@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2407020219040.38148@angie.orcam.me.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Jul 2024 17:50:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgncrjmWSETfPt+j6DY-MLH0=Lrd8kJHR6Tz1iJ6i39VA@mail.gmail.com>
Message-ID: <CAHk-=wgncrjmWSETfPt+j6DY-MLH0=Lrd8kJHR6Tz1iJ6i39VA@mail.gmail.com>
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Arnd Bergmann <arnd@kernel.org>, 
	linux-alpha@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
	Michael Cree <mcree@orcon.net.nz>, Frank Scheiner <frank.scheiner@web.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jul 2024 at 17:12, Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> On Mon, 1 Jul 2024, Linus Torvalds wrote:
> >
> > But honestly, that's basically saying "in a different universe, alpha
> > is not a mis-design".
>
>  Precisely my point!  We got so used to think in multiples of 8 bits that
> other approaches seem ridiculous.

But Maciej - alpha *was* designed for bytes. It wasn't a Cray 1. It
wasn't a PDP-10. It was designed by the time people knew that bytes
were the dominant thing, and that bytes were important and the main
use case.

But it was designed BADLY. The architecture sucked.

Give it up. If alpha had been designed in the 60s or 70s when the
whole issue of bytes were was debatable, it would have been
incredible.

But no. It was designed for byte accesses, and it FAILED AT THEM.

              Linus


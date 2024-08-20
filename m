Return-Path: <linux-kernel+bounces-294629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64484959071
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE61E285019
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07341C7B91;
	Tue, 20 Aug 2024 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bTFGbbd+"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244451BE238
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724192722; cv=none; b=o6dohvt5ZXt9nxIDS4PwEkJmIXoeLHno3QdeTALtdTTXz0TUjRwwGQHvxjikI+oyXKdY8Ia3grJvCosSPsDaRoN4OQidEci6ZuCmJhj75hSnVRHwCPGwM86IAPWZYDD1aYpbfM22yqtT1eR8qN+Qf7WopfBNPEajS0OOP8ENrb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724192722; c=relaxed/simple;
	bh=XA2Xl9LLz1exNbfscxHunBT38eheK6GidZ5koi0zXEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWZ7gBI2djmgLObQqBjL0hZfRHB5AbNR4C/53jwojtRcNOX9avOdYKVfut7fazEZq8/WbYzQqNvJF6H3Ae0ADgA0bWShlvneTLQfU0AyJqrvu0eg/Ranyd9qXz3kt+dK8e0pxGTLYaLyDY38pi+S0zK0iELfDaH9mwRmsxKvUx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bTFGbbd+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53212e0aa92so6683778e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724192718; x=1724797518; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NsDflXvhlv7B/L933J7hmRo6Te0QXzkZ39ECbN08B6k=;
        b=bTFGbbd+uQEhNIB4wN7I7nn0Qz4pPr9ugZMWT9Hgi8ZJ8lRV1fba1n/mMo8igwsXs8
         JCbbKeb+LjQHtG5EUmZaQTvcJxpmk0fl5+osoVPHtKtAMpfvUPrvRysozyKp2lVcAoxp
         4kW4Xttbz3BNjTrYBagOEX3xl2B6jI/nfMrQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724192718; x=1724797518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NsDflXvhlv7B/L933J7hmRo6Te0QXzkZ39ECbN08B6k=;
        b=nqe90KcJFkCBqfF5hl2ngDj2BMg6GLBuQXh9d1Soq/ot+2AmeRGWb6fq/zmImZpma+
         HwV4XL3oiwzelyEmhpMxyEQJFVFurFtGe/C6tFNsW8maM+uZMS1Hl5S4vULG72jxmX6v
         3JzDskHCwNvLl83v9xN3tVg+fD+260znvF5O0cAUIr1RDHOznSqXHarc1Ri0d3p9u7Lt
         4joF43Xamw25stNRUhyL5GYyYLXGYLogJsDgvHd2gZGHTujkvWqNFToj4PDEHHxNieh0
         vNGbjKTcM9LH5oSzflDQ0/OwG5UHZ95DaUm1oLVWUmgeagdFh7dtS5039/rXwPwQT4yS
         E5eg==
X-Forwarded-Encrypted: i=1; AJvYcCUdXPUY71RZ3KI/f/q40oz9WZXU/kZlG7bHOtlOD88FS2RQmWQG9jdg/VvgZne8kS51p8wwx939EoKKYWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqm6x+69x7mtaJBGsmxcsITKXuE6j0z6VUEsu2vfjQzbJiFa0w
	dR7RR8FfDYraU48sW2CQckjFsl90nQFCzgrBx15KXaZH7zvoAnb+Z4v+ybaEFO8g8guks65Ohx5
	6AuqGdA==
X-Google-Smtp-Source: AGHT+IEhJpa/NL9rvsw9URV63KK2K9sGtQ+nPLJxzKaTutu11aL0/96E0Qu1X+zy6FdIKZJcc4in3Q==
X-Received: by 2002:a05:6512:3d1e:b0:533:4785:828b with SMTP id 2adb3069b0e04-533485976b4mr141589e87.49.1724192717382;
        Tue, 20 Aug 2024 15:25:17 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5330d41ebb9sm1863439e87.204.2024.08.20.15.25.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 15:25:16 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f3cb747ed7so43246311fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:25:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXI9FcHK35lEvUYtjV0UrEictRTLemuftzogDm8ovrpFU1+Yp+3JYsYdats6EZmklPe/iMAfHTcBX+7T7s=@vger.kernel.org
X-Received: by 2002:a2e:4e1a:0:b0:2ef:1bbb:b6f8 with SMTP id
 38308e7fff4ca-2f3f8953891mr2311831fa.32.1724192716017; Tue, 20 Aug 2024
 15:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whxS9qM36w5jmf-F32LSC=+m3opufAdgfOBCoTDaS1_Ag@mail.gmail.com>
 <172419214486.6062.12815120063228775100@noble.neil.brown.name>
In-Reply-To: <172419214486.6062.12815120063228775100@noble.neil.brown.name>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Aug 2024 15:24:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtmQyq9OZLHPDVkkq-XVQNMF1ck-vSZjQYo=g4=Ue1Zg@mail.gmail.com>
Message-ID: <CAHk-=whtmQyq9OZLHPDVkkq-XVQNMF1ck-vSZjQYo=g4=Ue1Zg@mail.gmail.com>
Subject: Re: [PATCH 0/9 RFC] Make wake_up_{bit,var} less fragile
To: NeilBrown <neilb@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Aug 2024 at 15:16, NeilBrown <neilb@suse.de> wrote:
>
> The argument is more like "we have interfaces that are often used
> wrongly and the resulting bugs are hard to find through testing because
> they don't affect the more popular architectures".

Right, but let's make the fix be that we actually then make those
places use better interfaces that don't _have_ any memory ordering
issues.

THAT is my argument. In the "combined" interface, the problem simply
goes away entirely, rather than being hidden by adding possibly
totally pointless barriers.

                 Linus


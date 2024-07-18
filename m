Return-Path: <linux-kernel+bounces-256788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE6993703D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB051F22643
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40743145B19;
	Thu, 18 Jul 2024 21:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CW7jSCKo"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBC974E26
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 21:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721339205; cv=none; b=L2PdfbrBjw6R2Rm5qt7E9XrrkxNm/p/9iGylGpyhIXrgjJkRMDsrNZv7GUKcRcQS5LYdQ/io5JZmLGmbI04XrED1VmiAx9FycOvtk69Gg7Q6jls51NLkbjDR0CzzOntflLTQ3KFyXQMuI2fHHgjyWFW6+oKIz3s80vVjXdFnz0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721339205; c=relaxed/simple;
	bh=9F6i1FAmVDoD7jHejUpq11Kfr0EDw68Wtg4/g2RXVWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pom4nubLkIpN1Ex/U2yfopiiUe5qA0Hz0RPt3MhmKj7rHbTsR85H6S0pcQc4de1Oqr1F0OOJ7qwWIruw+2G/y+EUd5X64TN6GBPBCI656k3FOLjRcEdB5NxOR7oFIhWY3zKr791wZZzVf2nbxkzI/KHnxPBY7V5lIMSDDwBNdQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CW7jSCKo; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc34722so54609a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721339202; x=1721944002; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUntPXuIddpotRRbeUHCaia3duUln3zyPmdIc4CQdv4=;
        b=CW7jSCKoCjruV3HDFlHZCJDbbRXO9BkgqiR1cwQavzI8IiXZCKWVLK8tn/uahkVT4g
         blAbEhYrn3aiPZNe30U9aYRPbHI28m8EtXdr55NOtcht+xcG5WvSky+/ET1Znp5uvuJt
         A17QjEIKsqT2F1ZOZWs8PV6zJALxA2OvoV/j8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721339202; x=1721944002;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUntPXuIddpotRRbeUHCaia3duUln3zyPmdIc4CQdv4=;
        b=KYFnvFgCtjZ2QF8B3w2df8Fq/tBJyVwoTNvpC6XIOm6CSnr4JAVeYbDOWpTMEjcJoT
         bXnovIMdkoGcflUBC2TDnLgre2bjRHcB2MUrHkMQzqZqKqfHQmVTzjcmfYGEKV6LQ7LG
         jevwLZ/7pLMWU7Nrq6odd6YYxYgrIOvDemgI3YtuF+eUVPEk2q/pDahdw2K6mzullY4M
         GxTx8eo2I0l/jC9zn/I8GYMhRd366ZX4N46FDzrZ6E1MM4TcnOKm7tKwmEoDk2YVAU3Z
         A+uuQ+6sAYFKU8WxQNphNFSJEUTl6WVqMufG/jMQtKviAF8KiwUKW1vIYZlz9sz+KGjN
         Q/EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAgfHouPg8JXDkYnnOWh+meJ4K4vt9dV1lV56Sc6xGvzamLTLgzt1XwLhz1GRBRKUSr0J+YIkYPrSlVZakZglGV+TxS0QHhRXAEpON
X-Gm-Message-State: AOJu0Yz3jiver7KAaU7cu1PEjYhk1g/aEdMrimKjHqvnxHPMxHAqcc8J
	VYCfVkRuinOgAcxTBFXISklpCVI9GNXD1fJtbG/4M4hvtASz4/vz8FRHcIL9JZbaOuaGmjrhUIh
	8woFW6Q==
X-Google-Smtp-Source: AGHT+IGhNDXcnkkK/5TOetxPpZWxDSU2Rds1jcBjAKZjtMikPGfucGejN37Ghv4gJMaHCGj3dDt++w==
X-Received: by 2002:a05:6402:2694:b0:59e:a1a6:11b9 with SMTP id 4fb4d7f45d1cf-5a2d10bbe46mr573720a12.2.1721339202042;
        Thu, 18 Jul 2024 14:46:42 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a2b68643bcsm389373a12.16.2024.07.18.14.46.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 14:46:41 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc34722so54561a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:46:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWS+drCvLsaUFfHpm+EfhG+N6sOmt4Qn5Kl5/5b0sOrogUxR7ufvfjL0wnUFSufonfTl/jhUTDsLoRHC4Rjt3OYyzrakRUFdAel3qSz
X-Received: by 2002:a50:ab13:0:b0:5a2:bfd1:b892 with SMTP id
 4fb4d7f45d1cf-5a2cb3382abmr491986a12.11.1721339200713; Thu, 18 Jul 2024
 14:46:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZpY3X1tggZC3s_1X@shikoro> <CAHk-=wigtUnqv+RXkLZ2TwqV35YQeGrYsMnrowpnmQNN6wyhCg@mail.gmail.com>
 <CAHk-=wir5OYeNSytz+EocQnQxoFX0LY962R6FDj9cAHBiXFe5Q@mail.gmail.com> <ZpizSLI-sAIng0GO@shikoro>
In-Reply-To: <ZpizSLI-sAIng0GO@shikoro>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Jul 2024 14:46:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=E0smTG5kUG-pSkcHWijF_-Xy-yu-swfTV=23K-RFhw@mail.gmail.com>
Message-ID: <CAHk-=wj=E0smTG5kUG-pSkcHWijF_-Xy-yu-swfTV=23K-RFhw@mail.gmail.com>
Subject: Re: [PULL REQUEST] i2c-for-6.11-rc1
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Wolfram Sang <wsa@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 23:16, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> > There are other merges in there too, and this just pisses me off.
>
> That part I do not get:

That was me having looked at the list in one of the merges, getting
ready to try to sort it out, and then noticing that there was
*another* set of changes entirely (admittedly apparently much
smaller).

And at that point just going "I have another 50 pull requests pending,
I'm going to skip having to figure this one out".

                        Linus


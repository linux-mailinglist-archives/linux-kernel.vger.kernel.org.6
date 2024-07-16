Return-Path: <linux-kernel+bounces-254253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1FA9330C5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50961F246E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995B719E83D;
	Tue, 16 Jul 2024 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R1AL5dgs"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4A5199EAD
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156167; cv=none; b=NdG9INfz17Bg8J+LKm+747RDekzzPNqM+3QzBKhrr79EcTx+pPmtQUaY0vvUwZn/DL/kLSh3CZoyBSxKxVmKzlKwV4wv4rV+OB7hoSiDyyfVxLaXDaPMaj9B202bH0wkEra2F+rDsxODBEEV0URRZYW6ASriixqAbg6gZXSs6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156167; c=relaxed/simple;
	bh=PaGJafHFQaae4kpA7eX3BjTakDTozfmln4dp/gjmRE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYIs+lwq79GRTVFZtZZLpQLNYdRlLZvJdFYAu/ZoOuGDjMk1dLQzYPoOjJ80h41P8epx5JOoY4g8LlOdYzpQx5Z/hNoXqdnxuz6na+ZRttPkOWU9nnThZ2GVGPS2jk739UTQDheIQ9TSnHI2aH579Ld+6g029I7SVOF9EBZXYNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R1AL5dgs; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a79f9a72a99so11380766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721156162; x=1721760962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7AkWFffnhNj8OhWOczo1nmTY8DhOykx9MPZ068Ia41E=;
        b=R1AL5dgsdSFGyZwemraoo+Weyti4htv2AJ7T8urUD1hmzU/7JXQIc5DmL/w7glUBtO
         QCckEOnj0hQN67AH4QyGVTZn3tZ8oCCLCozAQtWBgcpcQF+p9nkthEqNILGY4Ru0f4Lf
         9OUusTTviWYUsC0qnl56+UAmHvuvT0QG+sUjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156162; x=1721760962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7AkWFffnhNj8OhWOczo1nmTY8DhOykx9MPZ068Ia41E=;
        b=Smw+EGNdaLey1rGQDq0cO/FnGbmop05IHQKlqlw7Z/t2xN5lwigrvT8Ss3DLnLeYWt
         CYFILJAujGIIDlomCI2bguftkparg2Vu6NYBtmzOv9RMvE71xr4Y3bVqUkYS7sZvCiBe
         o9W69omaKYtiYfOeTUAg3UZyZIdYZXpQ1bQT57IB2iQ/Aj4fAzyILbZ0DYwH8t+BbbxA
         9GDMyri6MqT7WHggNcvM2miaEOyPRq7I01g03g1u9vAFnqk/kuV8UaYmGZQyIKtW+ERb
         Svg4y6BblWVOq3kNZwW2+rtJskRgx1lxWAGY2x2SW7U3B9kvhZ4euvULbqHXUgqyIpaU
         eTaQ==
X-Gm-Message-State: AOJu0YxStvH8xgAjNzAM+0qufc2YwqKmQZFOnReMhpwUezG1aVMJBDw/
	gcQ6D3+5dJ+L3Cv4urYc75lceLhRxNwWvo6yfSrwAp86B1f6iE1p413ARSC8KwlxOhXXuXSXAQf
	BVQRNig==
X-Google-Smtp-Source: AGHT+IHX9H4nEulEeLiW0KVbVXl6q4DFz8gnX+MH1Mkfa5/2CemGeZMQ34md55AfNWYyfvvFc1lWeA==
X-Received: by 2002:a17:907:1ca0:b0:a77:e420:9e5d with SMTP id a640c23a62f3a-a79edc7b3e8mr269238466b.34.1721156162332;
        Tue, 16 Jul 2024 11:56:02 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5ea482sm350027366b.92.2024.07.16.11.56.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 11:56:01 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58c2e5e8649so87883a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:56:01 -0700 (PDT)
X-Received: by 2002:a50:999e:0:b0:594:4d7e:1b6b with SMTP id
 4fb4d7f45d1cf-59f0ae05d51mr2757719a12.5.1721156161538; Tue, 16 Jul 2024
 11:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fe3126a0-7c32-426a-9997-77d76ade5179@app.fastmail.com> <b55b7bb8-97b6-4d25-9592-8213ecfe7b6c@app.fastmail.com>
In-Reply-To: <b55b7bb8-97b6-4d25-9592-8213ecfe7b6c@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 11:55:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=whp2O+NjOXf77hfATgEe-LHTefbFb0eR=ytQUJTOUnfdQ@mail.gmail.com>
Message-ID: <CAHk-=whp2O+NjOXf77hfATgEe-LHTefbFb0eR=ytQUJTOUnfdQ@mail.gmail.com>
Subject: Re: [GIT PULL 2/4] soc: dt updates for 6.11
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	soc@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 14:03, Arnd Bergmann <arnd@arndb.de> wrote:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-dt-6.11

WTF, Arnd?

This doesn't even *build*:

> Jagadeesh Kona (8):
>       clk: qcom: camcc-sm8650: Add SM8650 camera clock controller driver

because it has

        ret = qcom_cc_really_probe(&pdev->dev, &cam_cc_sm8650_desc, regmap);

which is entirely wrong.

And no, this is not some kind of merge mistake of mine. It was wrong
in your tree.

qcom_cc_really_probe() has always taken a

    struct platform_device *pdev

as the first argument, not a "struct device *". So the "&pdev->dev"
thing is completely wrong, and always has been.

Looking around, this was also reported by the kernel test robot at

    https://lore.kernel.org/all/202407072331.baglL4Sd-lkp@intel.com/
    https://lore.kernel.org/all/202407072212.WptVaUDt-lkp@intel.com/

and still I had to just notice it in my local build test.

I did fix it up, but this is *not* ok.

               Linus


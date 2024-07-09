Return-Path: <linux-kernel+bounces-246031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F81492BCEA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F711F22A54
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B30519B5B4;
	Tue,  9 Jul 2024 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N7nFqwjU"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F9E15279B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535320; cv=none; b=fAMq+dRsdIn11mEyElzSpIinOsEBHe7tezEQT6cXwV+WzKCvJYMnFFSf7vg8F1XGmDun8ZyXRgm+4XDPb4WM6FNcCPtJ6AiL2CEOUa8ykUdd4bPWFz/RZtc3A5ewOKH3TKRbuMyZqMq9kXpjEofY2n/f7kPTkkk/0xjIWoD67Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535320; c=relaxed/simple;
	bh=N51YY50iZM2xd0G1g1J7sL7mFACPG6CXFw/kqmSAsFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kiAZn/pCC2BRw3mL5o0DRU4ll9LbJ0XLh4xn1KSh1GONq5D4iHR4gsdLxG7LzXGJdcfPN7kf7FE8/PqgiijcgBNvFK2sE/140Tpcl2sd5kpIgT+Jsw6fuoT8teSBsv5cbxZOiPBqddhAlN0f/gqAuvff4eiNxp2T9FTUnuT5hNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N7nFqwjU; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52e99060b41so5615088e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 07:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720535317; x=1721140117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wU8bklL5Sk+P9jtPWt71PuRxvvqxwIqd0UA8CuZijlc=;
        b=N7nFqwjUwnzzlxroDNzxU3lx806q59P0H3rKjeKXO1zVjnSDACoDDskpWce9E3f1XI
         dxeFnnNk4ZDlqLTdo5KNZm4+OxwdNPsYF5ECY+BcqG0E2+eqaZkI774JLXhveQ9oD1Q8
         aDMYojZXDCx6iZRtqhiEn/27KPBXa/Pu9dQP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720535317; x=1721140117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wU8bklL5Sk+P9jtPWt71PuRxvvqxwIqd0UA8CuZijlc=;
        b=p0Y+InMalSi7he15EgjYsdFGe3h5vOd7qO74YhksCHDgWFzhAuzsBNRVm85FpNz16F
         toOe6n5RJIzhu/B6P7UL2bN21ADKwNUDQ+75gTZTV1LxzJ3J+WQhfKCgZUvnBx7cwJGu
         KhsdUQ8o5mW9u9Ld+HSWzujMBcO3YBvNDWqS8np3rnAqyi4hKZcDX23JD7OoNmG/1eIC
         4oiMXuP19YrJ6ACVpYNtkuWlwkeeDNIdzSvmwl/VzeZP+FsbhtPi42mR2MsDZydsUh6M
         kaIfItMrmq65Fm1Ebr4IfW1m8celOmwxcVl5IaW8xBiu/fYRyGKBKAKVSTo10gGcgHKj
         fCUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBwWbMa+eCNF0nixEEmyHFD+tWDRUvgNyizQlp5eZ+HvlzHXSYk5kDXDpvxFid9qhH63hXo0gpOjjGA8JECzT757e4m2sOc+TTZj0U
X-Gm-Message-State: AOJu0Yxp9sAsvBcPaEUYpf3/eie64pY2NlJB6UwaDRePxjS3b3473ZL3
	gYP4vqMHS+46fftfB1VGGpcbjqj2F0tXB6a4SXfCnC+albNBdC+jmnUuKvdvFJZCeTZR8LYRWlC
	hcRk=
X-Google-Smtp-Source: AGHT+IEuWhWNEFig1+Qbi84a2ToMy3xbAnu2jY/N8cuVszaGtGXqgLEJCfgvv7Eww0aiUm3EXvGnSg==
X-Received: by 2002:a05:6512:2206:b0:52e:bdd4:610c with SMTP id 2adb3069b0e04-52ebdd463a1mr177475e87.63.1720535317003;
        Tue, 09 Jul 2024 07:28:37 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd45a162sm1114391a12.68.2024.07.09.07.28.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 07:28:36 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58ba3e37feeso7083776a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 07:28:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbiojvteCKy2cDZpkM1t/fzWPmUTx+6mTHuGfzuiWscpPYNNSy9G6SPaHVJ3kEyzucj6InT8CwitB9v7VjGNq2LxqqDNpkRgQ3hrW/
X-Received: by 2002:a05:6402:26c6:b0:595:7640:ee79 with SMTP id
 4fb4d7f45d1cf-5957640f148mr1296551a12.17.1720535315869; Tue, 09 Jul 2024
 07:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com>
 <Zo0LECcBUElkHPGs@J2N7QTR9R3>
In-Reply-To: <Zo0LECcBUElkHPGs@J2N7QTR9R3>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Jul 2024 07:28:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgAKfXySpKFcJUdv97Rqz7RxPF-uc6xsue6Oiy=tP65oA@mail.gmail.com>
Message-ID: <CAHk-=wgAKfXySpKFcJUdv97Rqz7RxPF-uc6xsue6Oiy=tP65oA@mail.gmail.com>
Subject: Re: FYI: path walking optimizations pending for 6.11
To: Mark Rutland <mark.rutland@arm.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jul 2024 at 03:04, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Looking at the arm64 runtime constants patch, I see there's a redundant
> store in __runtime_fixup_16(), which I think is just a leftover from
> applying the last roudn or feedback:

Duh, yes.

> For the sake of review, would you be happy to post the uaccess and
> runtime-constants patches to the list again? I think there might be some
> remaining issues with (real) PAN and we might need to do a bit more
> preparatory work there.

Sure. I'll fix that silly left-over store, and post again.

           Linus


Return-Path: <linux-kernel+bounces-550711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F47FA56331
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9CF1894E9A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A371E1E17;
	Fri,  7 Mar 2025 09:05:04 +0000 (UTC)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE421DDA0F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338303; cv=none; b=TwzTJz77DJCCPRbfgeeDRs530Ojqt2SKiyHPduWD32J90TSS5MWB43aZgigPbOtNQ7SrzlIhzhKuGttClIeADYEIevaRpqRCuPQ4HYqHNlX2VRjH3qImyqcjkXqqEyRjDvuMfsn+5ewGZmCPezhfxc8pCq7betmg/v38s3JdyYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338303; c=relaxed/simple;
	bh=SiD24BiUcTdsyjxoMTPExkz+rCNxJH5FxaZCO4aW9nQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RhzMddde+kVlAjQ0Yg+d0lldgyKM+DKXuyFptdE0iQb809EgS3fh5uBCTP0yIbojQC969eIBMVYFleZhZ+nq/OMcDzsffkuj9akWn20slk3qYDkneS5B/GpCKXI0JDsTuudE//eWzwqMlXSY7tNtfIOxbn059PYdni8ar/ipYps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-86929964ed3so1348448241.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:05:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741338300; x=1741943100;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aj2k7WUreFqhJsc+1QNGJJkvjXT/u9/J2+j4Dhox32Q=;
        b=GeMed0JySn/yBAN1Bm0w219dhqgARbRmCV+krRGiWeS2LuuDRpKOE/hrfc7a4kEzFf
         /YuqB6XvRaEKtqDSb+7Sq85RSmdel0cJRP4WQAezBEkOUIjUJj7w9aw9JUjCT2OzOkKo
         wa7svKOApjhq6ffj3amTgai5xjA3Q6u4bR++eP/YtMPjzUOStdZ3KM8iC8hiJI7Ciko4
         IJ9shZIH00YFNolmcATzbX0xbW33hMroNJ7NjlO1uGA1kcbwPGeOPMwd0BY+y1XnH2DT
         BsGPcx8GlRaaUacMTGHtyMIW4/ZzNYy8vEbck1DbaRbKJsYfJ5r1Salg55x4ftTewY8+
         xvcg==
X-Gm-Message-State: AOJu0YzZI4lmRZiq7+lN0WziEDWuy1DL79Dw5kpdk2yEmmrC4iH5kDIj
	c5bH4c8eBrYq3fhJPkvDdORsFjn5gl74wNE81T2HhHQLXccXlB3qvuzpmaqVf5U=
X-Gm-Gg: ASbGnctD79NHhSxgyx6NZlynNyX9HbCPkUm6CrAL9Y43ul8VHg1Qn/j8ai66VzxS+h4
	L6rZ+OjlWIw1GHMeCtC01KabG0vSwvQcv+VwMMBMxQG3eRkV6PtvwKkwWgdG33PnrBX8Ggvo7gQ
	3oCmVNmi0ySW2j1TQLNDvRf3JsxIJkq8HYb++72xz1TfRNFgXffjCfIWUmfBHcyA0jRZXSrOkVY
	JVJcBehLJhtkPfizCRPa+IWBolho+zHC9LHENs49H4NGbJbI32QHPDKdMjpIBG540MyUrusukOt
	dzCS5Om5Fx7X1va3RwiMP+/ErjBaM190qXLUsqI7BiWeEAkXJtg9chPwJGG3ToLPOsxGvvW+LXl
	nUbNU6BU=
X-Google-Smtp-Source: AGHT+IHV0bMu2lSxeqCWjQooFa+1HOz/k+BSRt5pJg1pjON+xDZv4DmDtLvCtF/7ojjnrOyk4ZUrEw==
X-Received: by 2002:a05:6102:915:b0:4bb:d64d:8331 with SMTP id ada2fe7eead31-4c30a603936mr1510451137.11.1741338300585;
        Fri, 07 Mar 2025 01:05:00 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d33ca5bedsm595475241.26.2025.03.07.01.05.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 01:05:00 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-86929964ed3so1348444241.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:05:00 -0800 (PST)
X-Received: by 2002:a05:6102:578f:b0:4c1:9526:a636 with SMTP id
 ada2fe7eead31-4c30a63e871mr1446105137.15.1741338300224; Fri, 07 Mar 2025
 01:05:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com> <20250224173010.219024-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250224173010.219024-4-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Mar 2025 10:04:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUSCxdqJiHp6kx3mqnxuXEm124e-BdFvsAsjAWz8reTfg@mail.gmail.com>
X-Gm-Features: AQ5f1JoH2m7IUwdy18a8SQAiFMC8YqP91kTZG8qZRTFYIZLH1pmnmch60sA2OQE
Message-ID: <CAMuHMdUSCxdqJiHp6kx3mqnxuXEm124e-BdFvsAsjAWz8reTfg@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] auxdisplay: hd44780: Introduce hd44780_common_free()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Willy Tarreau <willy@haproxy.com>, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

Thanks for your patch!

On Mon, 24 Feb 2025 at 18:30, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Introduce hd44780_common_free() for symmetrical operation
> to hd44780_common_alloc(). It will allow to modify the both

s/the both/both

> in the future without touching the users.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


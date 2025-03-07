Return-Path: <linux-kernel+bounces-550708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD7CA5632C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEBA416765D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0141DE3AB;
	Fri,  7 Mar 2025 09:03:48 +0000 (UTC)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03846199E94
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338228; cv=none; b=BZccPrLSEbzaA7f1O5dINu51no0bXJePiWkK/N1Z36/7Y87fAtcYIa+ub7nYHP6w7BL6fZemfSab3vGmxEaxTcQndSYYg7kSWEtGwgDPUqjFDdppZn0GIWx1NSZxuBKsY2RLp59zq59SVK94OX+fwRB8hHAFzkeA82vrXiGZBq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338228; c=relaxed/simple;
	bh=W1SJqhrGB42CtRRe3WvV4wPy9ekmfavhmenOG7JBV0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WFVL8G27wgcumOhyV2PJRcSYAyGWg5ncy9FVA2sr8cPGY9+pmWrCtX/Vc8/7yWskXE8rXBiKWuW86ggT2U2vqnkYg7cSWVCtY5c9G6hGgKa0ZD1izoxMdRdt3HDVfIQU5FEVJv+tJuo2jFzmht5ujkXDiBW7nrra7FouPgq1mzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86d30c329f2so1609646241.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:03:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741338224; x=1741943024;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMSYukN6awa6BTR6D8Ly56nmP4d1qjbG3IPybB83J3w=;
        b=SmVsGzCJD1PpifGfcRKF1uDwssR5UhpVwbaDoTL5nSeWI12NjPOaX7QQl/fMgY5OND
         ilB7sYkaDXk8pnlx2Ou5aCACyrsE7QeRB8/dNNZs7FfumRNkP8UNZewjQmMo7o+vAY0D
         qYWQMR+z1hPRduO4JWv8gZmY+hw2uoPaxmxmNTp5s4oIP/EjC7KKQ504O+PVY1bjcSY/
         r/KWnLpYgP/pTxkkGrqg+Q52RnQ+Jy5wApamcVPSFj7L85eZg2LIZJuOI1cnxIOJPVfL
         dhDV2WxZ6luRY2DK29vPmFYGopkkdxpC7RF96k0O+sAHDuKXoEuW7Z4h0Q9VLlJ6ky5U
         ISqA==
X-Gm-Message-State: AOJu0Yz9/LBZK7e1FJOAhTjN/ej/+22/rUiYVYj2LMN99rp9MmXDSGYc
	FT19Lm5bGmU53rmKP88tV+GYKDaggLhJEAKOwAA4yzfFd/ftaFoF/Rx/PYkeWn0=
X-Gm-Gg: ASbGnctkg+80tFgTtEBSg/bI5vBVyw0jK8xvziFQYHkaIxWAGxbNmTggOKGKEKfatOF
	j2Jb34CSDKY7Otqu+Jw9WlnWPA64cpCas+uuo6rssFct8MGreU2yEXhsyG90J2lQ0+GK0RTVWBJ
	nK+JfciDslUTOjrXfX/vh7qHLqgu2BM0nCHAcWtkzwnDtBRQM60Qny341EaXKwJ+6bnH6DhLELp
	hoM9D4BDsVBhz7tMc36EPqiTH1yQo3hbRC3tAuOKU/bGTTGoTVE78Z8k7hZXkaWANbZ/fhtGN3J
	2yQDkUr4jrrLgs1NRfofzKvXxxKDhsZZ83UY20LXTCNL8KTM+kGDxBJetm2P2faXtxk+UUHAA9M
	vzoDVdyB6RvQ=
X-Google-Smtp-Source: AGHT+IEetkaCPhelQIYz8bQkyhht4k3orPzLcZb7CrVQXWq3kAl2zb963JPHwxdAxh2+YuGyxldh3Q==
X-Received: by 2002:a05:6102:2c2:b0:4c3:9af:9134 with SMTP id ada2fe7eead31-4c309af93ffmr1282279137.4.1741338224251;
        Fri, 07 Mar 2025 01:03:44 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c2fb4217e4sm636645137.4.2025.03.07.01.03.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 01:03:44 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-52361a772e7so2646750e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:03:43 -0800 (PST)
X-Received: by 2002:a05:6122:3545:b0:523:6eef:af62 with SMTP id
 71dfb90a1353d-523d50899demr4369930e0c.4.1741338223754; Fri, 07 Mar 2025
 01:03:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com> <20250224173010.219024-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250224173010.219024-2-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Mar 2025 10:03:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWBGb5AXv8Ch3XhPPHc0CVYHf31tx1Feh87OU5MDUCdPQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jqp5Hxmsc_MDtUKzGbU_FKoUJisdXKh5M15tJrsdguoHwfqywZXSutDPNU
Message-ID: <CAMuHMdWBGb5AXv8Ch3XhPPHc0CVYHf31tx1Feh87OU5MDUCdPQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] auxdisplay: charlcd: Partially revert "Move hwidth
 and bwidth to struct hd44780_common"
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Willy Tarreau <willy@haproxy.com>, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

Thanks for your patch!

On Mon, 24 Feb 2025 at 18:30, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> The commit 2545c1c948a6 ("auxdisplay: Move hwidth and bwidth to struct

s/The commit/Commit/

> hd44780_common") makes charlcd_alloc() argument-less effectively dropping
> the single allocation for the struct charlcd_priv object along with
> the driver specific one. Restore that behaviour here.
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


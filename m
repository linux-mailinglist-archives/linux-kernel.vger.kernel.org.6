Return-Path: <linux-kernel+bounces-517852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1830A386B0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906793B7226
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68273221DBE;
	Mon, 17 Feb 2025 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Whd1gznZ"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7CD2222D1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802858; cv=none; b=q1UhyVp7v8DUUscqNwUfT5+Xy1CzqSdDJ62V++9TINQc1znYaWS23h9hbprJOL1+GmKE3e7IalM/NojgeRvPKA5DNM9jSfMAJE3A6Tb1xno0apk+XDPPoy5bj1gC3xRojGWfOECOs5lgbRlIW7/kVN2jaIXE2eF9Dgi8wmmfin4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802858; c=relaxed/simple;
	bh=+dQh08J2Wrw7tq8kkvKhIgSeuAw3wVHIEItqCvMFpSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuyDXyKZHBio5waz+yFzPkNcv9m0rCGOGqWTwtXMFPbvoaElZLyS4/jQdPMldLwtxQdUlI311X++Jy0Mi0XSg+3DRGX3CtQgOSAGz3iY7sTnp83ebe3aqSArl6ZgVToPpupgn4Tn47vZkbYz8nR+z3SzSA/S/xGvjn0ATeYU2o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Whd1gznZ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6C5AA3F31E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739802855;
	bh=fFzE+iQ7/6Nth8qy0xHPs/Cj4g/jlkWpDyJC+gk/5Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=Whd1gznZS7qjCZPmEOH+BNQXqEuduvatVPqITjO/P2eeXAHjtWPa6E8unkIOR+KW6
	 eN/CCGITrJfpzylyDPgrwjvfCrNbAdvulHnoa8RGvDKyPXIJk0jLNesmYSnp+4GlWA
	 IOC0I9M7NIPHBOQuZldKwgs8iPJa3BdZ4UNxYp4JlmdLKs5lmCjV6/T+zN9j6F8UEA
	 F3XVDlgX4QZ7MTNzFh1zOkHoHW2EZ+xebnx7pXwFw6HzXKE5rZAvRdvsjN9eVkA7OV
	 KBjjsFWeE/csgWZXrO3wDfKd3Lhm/Pq4VNolYwzro5W5Co3Fz6h53v/QkMZl3HcVnU
	 ueNpHmashDuYA==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc2fee4425so9529656a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:34:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739802854; x=1740407654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFzE+iQ7/6Nth8qy0xHPs/Cj4g/jlkWpDyJC+gk/5Yg=;
        b=JjzIWwOVGsEeSBPtqB8D+BlsXnZPM963a2o9dUEVX6aYKahAXXCsbxExmYqiIw0/d3
         uhGdo0t2H1YZHczAWLaab3wqCNgkKl4EuChUvCnwXYL5LnSB2t0m7bycZy5+k/lbeJw/
         ZWcRv2PqR2sS9usRZz0HL8nLmlM0MWWP/mqixFcnXV7T4GmT67A4UDBvHXZ2JOPew6g6
         TJ1zXP3ZPR/iOwUrdWqmEjvhdJT7Koq3GM7ykBG/Z6Ryorn5cENs4XeLEu0uSXwd4Rsy
         hNvxLYY+35iV9HCbP3axfVSlpLHQWLtRCmLOPUsQeaYIrM124ReCYtA14zoXqd7tRBHi
         4Lnw==
X-Forwarded-Encrypted: i=1; AJvYcCWReILzD9xC1be6K5E2ZUAFV9jOwnPqEy3MsGl0hCwv1dp8lW7dMWO0ObKgB0/Vz0s05wkz4C/V5e5Q4mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YysWFqlyWQ5duhZ8CQ33q6WX7ytq4o8DSxjuTG4lv8tr8H0JCaF
	L5GSpHbiPkf54YQNv8+g/IdAuLvdqKrmoeRzh91S7/Ugi+B69n5c+qL0/2rojY4NXmL+lSy0OVh
	LlIe4o6cW0Cux8RNY+aNE5fDRvWfWgZHke6mHwqt6lljXUjWbhkJQwbGGHw2VqKSNRsPuPYH005
	iv7g==
X-Gm-Gg: ASbGnctf3fQDPiC7xWkm2WCMvvjwNGrGw6M41DydFlWzzoLXvjXnLNuNmUiv2C/7NF1
	CkLjToeinYV06dbOaXYD+Ce/lMNPHfN7mnAvWmA9YCW6Mt5YREc181diQ+ZNx6DFlzfXEcMCpvk
	I5o6g3UpFxdKjA1NU34Wg3St7AAv/zXhCCEIns4YJTCA91jHR4Zi7MsEEzmbfMAG2KGKV5bRsjF
	Oms6ugcr+bdITTOLsYdpYEE5qfUChWBzzriSEMMeQJc+jlS7pi1ooyceap+fSbwAW2zZlm1aFY2
	oCyB2Hg=
X-Received: by 2002:a05:6a00:1a89:b0:730:9946:5972 with SMTP id d2e1a72fcca58-7326177f450mr15128561b3a.1.1739802853703;
        Mon, 17 Feb 2025 06:34:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzREazoIMmolG1CVLrZY207BcM9g0sp5SvtvoFagvZGNZkcgfkEhbB+UfODQIu0yZpQ0fDBg==
X-Received: by 2002:a05:6a00:1a89:b0:730:9946:5972 with SMTP id d2e1a72fcca58-7326177f450mr15128543b3a.1.1739802853432;
        Mon, 17 Feb 2025 06:34:13 -0800 (PST)
Received: from localhost ([240f:74:7be:1:a6da:1fd8:6ba3:4cf3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732642d908esm4592726b3a.159.2025.02.17.06.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:34:13 -0800 (PST)
Date: Mon, 17 Feb 2025 23:34:10 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-gpio@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org, 
	maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/13] gpio: aggregator: reorder functions to prepare
 for configfs introduction
Message-ID: <4ce6vzqsmjk4l7m4riraurpgmdhhvdq7e3spkgo5nvnt5uvgav@6aloxueo7ypw>
References: <20250216125816.14430-1-koichiro.den@canonical.com>
 <20250216125816.14430-2-koichiro.den@canonical.com>
 <CAMuHMdWZy22ckxoLOWH4x40VE4pRsBCfMDXJZ5ZYcu-ABFKRWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWZy22ckxoLOWH4x40VE4pRsBCfMDXJZ5ZYcu-ABFKRWg@mail.gmail.com>

On Mon, Feb 17, 2025 at 02:07:53PM GMT, Geert Uytterhoeven wrote:
> On Sun, 16 Feb 2025 at 13:58, Koichiro Den <koichiro.den@canonical.com> wrote:
> > Reorder functions in drivers/gpio/gpio-aggregator.c to prepare for the
> > configfs-based interface additions in subsequent commits. Arrange the
> > code so that the configfs implementations will appear above the existing
> > sysfs-specific code, since the latter will partly depend on the configfs
> > interface implementations when it starts to expose the settings to
> > configfs.
> >
> > The order in drivers/gpio/gpio-aggregator.c will be as follows:
> >
> > * Basic gpio_aggregator/gpio_aggregator_line representations
> > * Common utility functions
> > * GPIO Forwarder implementations
> > * Configfs interface implementations
> > * Sysfs interface implementations
> > * Platform device implementations
> > * Module init/exit implementations
> >
> > This separate commit ensures a clean diff for the subsequent commits.
> >
> > No functional change.
> >
> > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> 
> My
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> is still valid.

Thank you, let me add the tag to the two commits in v4 since they remain
unchanged.

Koichiro

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds


Return-Path: <linux-kernel+bounces-529713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 794ADA42A22
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928FA176749
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F755264FAA;
	Mon, 24 Feb 2025 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="pfZLdgoZ"
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D2B264FA9;
	Mon, 24 Feb 2025 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418751; cv=none; b=NW79Oa4E97yE1sSXqfrieLpsDcrcf2ym+ud0bVXbDVYHv1nRwPSiZaajv0QiPHUpFcWHj7yiUwO7eC4kJcGUNf3++mbt5rFjnHzJcj+Gyuys3pd+Mwp1zqbgKm1Eg+6X+WG1i2M/t+pNxT83ht6hRwpMqI+FTbR38EeG5RIgH4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418751; c=relaxed/simple;
	bh=uEaCqTit3Hs30MjNpx5mW1Lh1YKGgfb9eHc2xm3HRtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXgU835IiVbVG5ipOZ/0AUUoGQY6KWIBG2zEv6kGhgJ+Aj+R6Ou0pB1JdGQXLCTzBUzctHETslwio1cqIJDL/zvpaXYBTRKO9tG56DLoMlvgyEX49mqbjJmQdcCnug6EXdfIwIRhFz0GCSyWUcmTAK1EVJYz17Kd3uxESE7J2WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=pfZLdgoZ; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id F128D2E08FD2;
	Mon, 24 Feb 2025 19:39:01 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740418744;
	bh=uEaCqTit3Hs30MjNpx5mW1Lh1YKGgfb9eHc2xm3HRtU=;
	h=Received:From:Subject:To;
	b=pfZLdgoZRsGj7flsBNAsYCE/QWi/Gwn6lfqVKEY4tz12sW08w3pwnRZLwYBlOM/sb
	 5OVO6NBiWIThF866NR0t7DwOkYeOJZYaXdVhJ+M3RJCmKQ5xY35OQv9P33jvocfC3V
	 n+dA1Bx7u64EjNq1WS4/H/PoL6jMDIS161WLIVOQ=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.177) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f177.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-307325f2436so45402691fa.0;
        Mon, 24 Feb 2025 09:39:01 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVFXogWmP14jkFpjeRCsdWw31DaclK9XelGGnxl9RQ6nAn8Zbkre8lJ1fJZWGa3WCQbscbCpjvpc5CFOxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw316CQQAt9pa7W0ErLk7DtaVaeKGVcbazrusChdplGtrhFVtMI
	BMcmDdYoUY8xJiAxO1QOU3FXIm58z54pwcNQHQ/jXcDyWwcKbJhhkAM2SjHU77X0DYH3wQeCCOE
	wy6vdlbsYW7DYFWNK3Ien6ftvZrc=
X-Google-Smtp-Source: 
 AGHT+IHDf/8mxULisWDqSsVCPQZDiH/35WgwcCQjxHgPMcGxWVL12+DEduABrs4BXemzCqAtnX9uVLyIsSHQNmJSzuM=
X-Received: by 2002:a2e:b006:0:b0:308:f01f:182c with SMTP id
 38308e7fff4ca-30a59898391mr43439631fa.12.1740418741149; Mon, 24 Feb 2025
 09:39:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224161016.439696-1-lkml@antheas.dev>
 <20250224161016.439696-3-lkml@antheas.dev>
 <004001db86dc$b32dec60$1989c520$@opensource.cirrus.com>
 <CAGwozwHSbzDxCiO-xYNqNH20HovMnMk+rNLEatToX4js=gO_RQ@mail.gmail.com>
 <CAGwozwE3dceooZouM2Ay9YXfehrQBk+STa1HRH5nkZ6QohTjhA@mail.gmail.com>
In-Reply-To: 
 <CAGwozwE3dceooZouM2Ay9YXfehrQBk+STa1HRH5nkZ6QohTjhA@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 24 Feb 2025 18:38:49 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwHwbX_LCm5ZOJzC3CxR3UkGnmo1UVUE0685FZdjFV806Q@mail.gmail.com>
X-Gm-Features: AWEUYZlX79aScACefcN5jqida4vr4EdufKHNwqv2xqoy0LRMx0MNbhSHtemmY8c
Message-ID: 
 <CAGwozwHwbX_LCm5ZOJzC3CxR3UkGnmo1UVUE0685FZdjFV806Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] ALSA: hda/realtek: Fix Asus Z13 2025 audio
To: "Stefan Binding (Opensource)" <sbinding@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, kailang@realtek.com,
	linux-kernel@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
	baojun.xu@ti.com, simont@opensource.cirrus.com,
	Kyle Gospodnetich <me@kylegospodneti.ch>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174041874381.28762.2039195872684370119@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Sounds about the same, perhaps a bit better. I'll swap to that one for
our use and for when/if there is a V2.

Any tips about going through this stuff are well appreciated. Online
documentation is very sparse

On that note, what's the timeline for adding support to these laptops?

And speaking of a V2, the Ally X quirk is a bit suspect. Yes it fixes
the popping during boot, but which part of it does that? It is very
long and touches a different amp quirk in the process I'd say, so it
would be nice to clean up. Let's forget about the original Ally, but
the Ally X is still relevant.

Of course, I do not expect an answer from you Stefan, as it is a
competitor amp, haha. This is mostly for Baojun et al.

Best,
Antheas


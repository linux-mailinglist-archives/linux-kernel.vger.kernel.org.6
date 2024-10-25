Return-Path: <linux-kernel+bounces-382419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E089B0D5D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75079B233A0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2158F20BB2A;
	Fri, 25 Oct 2024 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bgj2ch7d"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4239F170A31
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881140; cv=none; b=XdobpRApHQSAeFf0KXWqPKiJEEL7qVsTw1yYUyMx1CNxJtt/VT9C8FQD5ykp2yvjS0kePmkafEgMgyKLHir0Mw7lAzJqsz4GmV/yQjkIJcALCjpRMDJbAjRIcHZZZ8tPPfd84ujiYkoF9d/tvOOqhyPSHZlEHZAm5TEmvFzF6v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881140; c=relaxed/simple;
	bh=0NRe5Z9bYszwew2si7F+kgrSb5MS03WEEqD+uCRELYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ru4+OBZz+b0kIlMt4+JXljpdTQWrAtGN+lm0s2wOXY16atOZxDy9/JPRGIfKB6kSEXfcy1NTa8Ix67YtmN/q2MFkHJRlEg/46UT8jQIjqnnhPE4+9OS0ohaLJw+hZz5VMCNpFc5W/BxaKtPFH8NYMH10NfjdGkdJk1dvJ+79uNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bgj2ch7d; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so3364873e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729881136; x=1730485936; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bzuNw67+MpGyTXn9LaJ+2b1si0MHMNXbchvz8Oa27fU=;
        b=bgj2ch7dEjhgcIs3YmIp/751ah9nPWI1tkk8JUm6EZBmaA47/RYJ9Kmmzb/jI181CU
         OljxpyhnEPY5czRkyE1Us5NgrTcDd7QrHW4dhxQGTQ93gqYhnx5fXzq+IifrkayKGniE
         cAFpPEuKvO/DodZDmL9Vj7tH3gUGTDUFj1iJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729881136; x=1730485936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzuNw67+MpGyTXn9LaJ+2b1si0MHMNXbchvz8Oa27fU=;
        b=pVwO+iXZPTif84ri5cRc4zZsqtliyMV8vurlaOF16alW6VomPZuu5oZHdPtFxrNXuA
         18i/fM9B+y9Wl71XjTUB4OSyDBNzpH6uuRngoOFVc58CgrImaaB1/ET6xa0DovHmwINb
         A9G9U37jAxOa8vJY1aqxiJalPPYH4vip2fn9u0LkM1ZU9KhQQsaOF+883ei/jTE+5Ggi
         HDRwNTRL+Wjtg3lnQzpDnSTdw5H25cp7hEFtbX+putzVLS9EfONS9xJzg85p/6StuRyZ
         /vsd8Z3kgV+IfbsfMnasM71FBGH8kpkw+BSJAAHdzV/XDU5McWkS1WIBiFwIyFQ/CEef
         F00w==
X-Gm-Message-State: AOJu0Yy3W6bQbPOW2mNfdoI4r3mYrqUqbBrrov0JKfOesTK4sV51afHA
	o6Uiissw0pooCRcUIuQB4IWYIbqOKbOZ5jt6AZri4M+Y+1LJ6l49wzWHK/4J6q4AJsWWvRRy8kE
	cmys=
X-Google-Smtp-Source: AGHT+IEK12+TBGB2WZUFlRgalAKZm+Iq2TGKWY7qb5RR6kapg8Pn+B5F40CSUOjsku3pjYbM4R7F0Q==
X-Received: by 2002:a05:6512:3b08:b0:539:e97c:cb10 with SMTP id 2adb3069b0e04-53b34c5f73fmr90020e87.40.1729881136054;
        Fri, 25 Oct 2024 11:32:16 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec7a86sm96727566b.42.2024.10.25.11.32.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 11:32:15 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a156513a1so344747166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:32:15 -0700 (PDT)
X-Received: by 2002:a17:907:2d89:b0:a99:33dd:d8a0 with SMTP id
 a640c23a62f3a-a9de5ff9ad3mr4825866b.38.1729881135176; Fri, 25 Oct 2024
 11:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxvBfDuqSC_TEM78@carbonx1>
In-Reply-To: <ZxvBfDuqSC_TEM78@carbonx1>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Oct 2024 11:31:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjKouRizUF97ZABtCmijjKR+sAOmWA4uiYhhSOwhxCT3w@mail.gmail.com>
Message-ID: <CAHk-=wjKouRizUF97ZABtCmijjKR+sAOmWA4uiYhhSOwhxCT3w@mail.gmail.com>
Subject: Re: [GIT PULL] fbdev late fixes for v6.12-rc5
To: Helge Deller <deller@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Oct 2024 at 09:04, Helge Deller <deller@kernel.org> wrote:
>
> It's mostly about build warning fixes with cornercase CONFIG settings
> and one big patch which removes the now unused da8xx fbdev driver.

So I pulled this, but only later noticed that some of the Kconfig
"fixes" are anything but.

At least commit 447794e44744 ("fbdev: sstfb: Make CONFIG_FB_DEVICE
optional") is not fixing anything, and very questionable.

For no reason at all does it seem to enable 30-year old hardware in a
new configuration.

There were no build issues before, the build issues that existed were
*introduced* by broken early versions of this patch.

Does anybody even *have* that hardware? Why were those pointless changes made?

Sure, the Voodoo1 was the bomb back in 1996 if you wanted to run
hw-accelerated Quake, but in 2024, this change should have had more
explanation for why anybody would care about the CONFIG_FB_DEVICE
dependency.

And in no case should it have been marked as a "fix".

                 Linus


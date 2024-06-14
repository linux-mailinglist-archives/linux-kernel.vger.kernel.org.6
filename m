Return-Path: <linux-kernel+bounces-215311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76FD909107
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2065AB236D5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8853719CCF5;
	Fri, 14 Jun 2024 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HNmM1xtp"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ADF19ADB3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718384703; cv=none; b=P8NGhS9Xliba3i3xORUZaEqLqb2VXA9TENM4ZiVEFdIiBcCY995lD914/Rmj0VO7SoZyKiBqqRzmK/VE8moPiAaNPbnZq5QSzUmZgNpqN71mwREdBCsQoMk6JcyxiKJ+mPqjUHOHt/i3eT6MljrHHWQCc7WSJjCvjnZ+YigythI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718384703; c=relaxed/simple;
	bh=/4fOdvEdlZFsObgnP4fNcYOH3Q3/ofPLOij8hsJ8yeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMYvl8Zu3uX05dmhwr4e1gJfdENAwYe+2s6yh/MCTj/dbkPQHJuPZWCmcCSvF2SCEznwIBVBH3s2xyrajT9FPc/kGKWU+fD1EDqGd++oqPQ6U2NmMH39cDcfENt/2+U+oCUAtcW+Z78KPJqEPWt9uOV94xutM2If8qMH/z1xrXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HNmM1xtp; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6f1cf00b3aso379742166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718384699; x=1718989499; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qzYNeCAQeD4+6NsX8RjP39JkkbQ+pGWaSkdyTn1CwzA=;
        b=HNmM1xtpPU0YuvzVIIVPIltLvbDyp1d7+AlwNZiuqH3H0+Gz5bZfa099H3ZqRHfPrB
         BLO12/GBEsSfD9mwLhOGdfaqYO8ABhcAvPyI2AeRYv128qPsKMDFwPLtRR+qceUYNdpO
         agzf5Scqvq6ROYPJXiQX/BqZPkahZ6eATMwmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718384699; x=1718989499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzYNeCAQeD4+6NsX8RjP39JkkbQ+pGWaSkdyTn1CwzA=;
        b=Vs6A4PFdn6g719Rj6HlxQzCk1CQd4TovpfHPyB1jayote5z7VC7AH6NanvUz8MEkpD
         c5LKWXzLySJ/xzWPwonOtT0ptFgpP9WNmmKfSg16jF1lW7FTRMi+hutWljGPSGrQiEzY
         287aQQkrmHy0uERql7m4b+IHW9rGvY/fzOSS+WLUMEZqB/KNCl4RtykHclsR4gigL60d
         x/2kv+IRQWjrt9zNOyUI9MJeiHH0v+OIUBorsp/hhchh8wvN6dKfg2pqoHMmIJEtWwBb
         0EVUXMG5lvTOnkn8jQJ4yPrxq93qbh6AXU28NTrzv9TVKDMWFn5UZfnq8GpMoLFZYTW/
         uuhg==
X-Gm-Message-State: AOJu0Yyq+FVlaejNe02p0HnsEBBsuBjqKXoAzur5wmV5lUPXV+t5cM1e
	DgAWRCmGjZy0fGEygs8XNPM296JAyAkcB3EHDFyhYOh+Jr/P12qc2ryWt/yNi+FCeOONg6uYIjF
	7RLtERA==
X-Google-Smtp-Source: AGHT+IEHKoU/sbtEL63L3dkpOsQwlP5UM1hK48jbbuWPPnODYqLSveuD+nUUc5ZiIhrzG4ZaAAsAeg==
X-Received: by 2002:a17:906:c0c5:b0:a6e:f53c:8da0 with SMTP id a640c23a62f3a-a6f6080c781mr224177666b.8.1718384699623;
        Fri, 14 Jun 2024 10:04:59 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f6121c727sm120149766b.67.2024.06.14.10.04.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 10:04:58 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57cc7e85b4bso663650a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:04:58 -0700 (PDT)
X-Received: by 2002:a05:6402:174b:b0:57c:bec1:ff4b with SMTP id
 4fb4d7f45d1cf-57cbec1ffeamr2002152a12.10.1718384698458; Fri, 14 Jun 2024
 10:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjQv_CSPzhjOMoOjGO3FmuHe5hzm6Ds69zZSFPa4PeuCA@mail.gmail.com>
 <ZmrTZozoi0t/tuva@duo.ucw.cz> <CAHk-=wjqHL7KjOWYBVKFewcKPWL7CJxddWfJnvL3AfOqfR8vMg@mail.gmail.com>
 <ZmwHGviv/6J6FQLf@duo.ucw.cz> <CAHk-=wigB-wVK+4=NuYJxoKLnoUXB52J5WU2hpKj2de6vGuY7g@mail.gmail.com>
In-Reply-To: <CAHk-=wigB-wVK+4=NuYJxoKLnoUXB52J5WU2hpKj2de6vGuY7g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Jun 2024 10:04:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcdUUip96PnfC+iRjAwPHn3XKsgcohk1ad5VcckCFVKA@mail.gmail.com>
Message-ID: <CAHk-=wjcdUUip96PnfC+iRjAwPHn3XKsgcohk1ad5VcckCFVKA@mail.gmail.com>
Subject: Re: Linux 6.10-rc1
To: Pavel Machek <pavel@ucw.cz>, Dave Airlie <airlied@gmail.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Rafael Wysocki <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	intel-gfx <intel-gfx@lists.freedesktop.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Jun 2024 at 09:21, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Let's bring in the actual gpu people.. Dave/Jani/others - does any of
> this sound familiar? Pavel says things have gotten much slower in
> 6.10: "something was very wrong with the performance, likely to do
> with graphics"

Actually, maybe it's not graphics at all. Rafael just sent me a pull
request that fixes a "turbo is disabled at boot, but magically enabled
at runtime by firmware" issue.

The 6.10-rc1 kernel would notice that turbo was disabled, and stopped
noticing that it magically got re-enabled.

Pavel, that was with a very different laptop, but who knows... That
would match the "laptop is much slower" thing.

So current -git might be worth checking.

                Linus


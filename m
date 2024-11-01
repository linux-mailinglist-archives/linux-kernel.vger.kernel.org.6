Return-Path: <linux-kernel+bounces-392357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 801889B9305
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042711F2333E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3831A4AB3;
	Fri,  1 Nov 2024 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PdGjoBaW"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492C719D891
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730470890; cv=none; b=RgwUSgRDt4c7+PrL+ltW2z5yO7O2wpkprreQ00280lmFFsj6AXBS/dRYC+1H0JWMYndtdkEXCAc18mnJSluFaUuary61ASMf+S0mmlc6qSG7jq4A/s2j5cLhahWFODB8cJsiL8SQ1+K09CS/z+xnQDnoXsZg4h34YQAP1e43iq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730470890; c=relaxed/simple;
	bh=1qhM1tQHEWuBqWJufij4y255YpVkJdwHXr6pTWmVYMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XferUD+1Y7Lp8o6LuWyIXUdipiAGyRM0+J1KJNPW2D0CjAMgIhGaW4z9twOg+4H/uPJ6rk0lf1nFEmohn1UnhOuNojkrAMLyH1ufzhevh66w1uyrIf9GpK2JZl1mSLsVXzlZuxcQoDJ/ZAEAm7H9S8s8SwVMtaCFdT850j3q9N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PdGjoBaW; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so3452808e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 07:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730470883; x=1731075683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tomOvulL5XQAdUq7GufhSqFpxzGL4/8bpYOjTuZZ6wM=;
        b=PdGjoBaWFG+fh09NMe+Hasu1hH+AcMY8BON9KS4HFeID/tg0dHTWd/IkAxlYLP+SUG
         y/KS5jXb9xXoD3E9+j9wKOko5+XM5kLIhUwwCMnvqN16CJk0ukmFQ2qtF20MJUCh8jV5
         QgdG52lL0Sk23FhiDcPIXIFq8AkIbXjLgE9xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730470883; x=1731075683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tomOvulL5XQAdUq7GufhSqFpxzGL4/8bpYOjTuZZ6wM=;
        b=k1T1AHxf+bpVqPq+AsxCAtxN8hVxfrr/ETxU6J+zgGnzejLg+rsm3gT4zh4vvNvXKa
         poepIscHQ9cVVHIvAk+OfRrylL0acGdPOv7kMAItdjML+kK6eBkEq4aUYFe+ZiarMjq8
         JV1Vc5fNx+7UOLq6VcmTJzBLHonL9CAXMEVOdSKZdM9yMn+b9TjFuVAUw+i3e5JVyW/y
         39W9qB76PCF/kM/sWT22D1XtWqrDsszHiXN+FyDb1YXOWa0rWkqX+ypBc46We3t8mHNj
         bXmCtC7jLcJljZd1DeEmHXWMK7rp2cI2fSa8MNksN286n5Z51rXQkZydA40j0ez/LdQu
         WeUg==
X-Gm-Message-State: AOJu0YxUcngMR596jDAI5viPbzPlosUc7k3nbSJa5daDexzZJiHmRWPy
	E2AsUwVuINEeVQ4RCD3qc4zwvJZuYroxlLlF6+ExX0+NAwmw+3hyyTBauA0CpZuqebwqjKSRIkA
	nVbNv
X-Google-Smtp-Source: AGHT+IHWmlL4qlw7ww9lz01Vfz03OXMNNwUKJIMJRktzbMz6ziUppNkuCTi5AFIAFi6D2COdwVDFpg==
X-Received: by 2002:a05:6512:ba1:b0:539:fdee:fe04 with SMTP id 2adb3069b0e04-53b7ecd57d5mr5393916e87.11.1730470883040;
        Fri, 01 Nov 2024 07:21:23 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bdcc3b9sm575173e87.223.2024.11.01.07.21.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 07:21:21 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f7606199so2081788e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 07:21:21 -0700 (PDT)
X-Received: by 2002:a2e:a99b:0:b0:2fb:5bb8:7c00 with SMTP id
 38308e7fff4ca-2fd058fb962mr65453321fa.2.1730470881192; Fri, 01 Nov 2024
 07:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101103647.011707614@goodmis.org> <20241101103707.290109005@goodmis.org>
In-Reply-To: <20241101103707.290109005@goodmis.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 1 Nov 2024 07:21:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uha5xwZJtdqirJtv27ZUBz7OP5oEnYg56v2i2mn0TrLw@mail.gmail.com>
Message-ID: <CAD=FV=Uha5xwZJtdqirJtv27ZUBz7OP5oEnYg56v2i2mn0TrLw@mail.gmail.com>
Subject: Re: [for-next][PATCH 03/11] kdb: Replace the use of simple_strto with
 safer kstrto in kdb_main
To: Steven Rostedt <rostedt@goodmis.org>, Daniel Thompson <daniel.thompson@linaro.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yuran Pereira <yuran.pereira@hotmail.com>, 
	Nir Lichtman <nir@lichtman.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 1, 2024 at 3:36=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> From: Yuran Pereira <yuran.pereira@hotmail.com>
>
> The simple_str* family of functions perform no error checking in
> scenarios where the input value overflows the intended output variable.
> This results in these functions successfully returning even when the
> output does not match the input string.
>
> Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
> simple_strtoul(), and simple_strtoull() functions explicitly ignore
> overflows, which may lead to unexpected results in callers."
> Hence, the use of those functions is discouraged.
>
> This patch replaces all uses of the simple_strto* series of functions
> with their safer kstrto* alternatives.
>
> Side effects of this patch:
> - Every string to long or long long conversion using kstrto* is now
>   checked for failure.
> - kstrto* errors are handled with appropriate `KDB_BADINT` wherever
>   applicable.
> - A good side effect is that we end up saving a few lines of code
>   since unlike in simple_strto* functions, kstrto functions do not
>   need an additional "end pointer" variable, and the return values
>   of the latter can be directly checked in an "if" statement without
>   the need to define additional `ret` or `err` variables.
>   This, of course, results in cleaner, yet still easy to understand
>   code.
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple=
-strtol-simple-strtoll-simple-strtoul-simple-strtoull
>
> Link: https://lore.kernel.org/20241028191916.GA918454@lichtman.org
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> [nir: addressed review comments by fixing styling, invalid conversion and=
 a missing error return]
> Signed-off-by: Nir Lichtman <nir@lichtman.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/debug/kdb/kdb_main.c | 69 +++++++++++--------------------------
>  1 file changed, 21 insertions(+), 48 deletions(-)

FWIW, I personally have no objection to this patch and patch #3/3 in
Nir's series (#5/11 in your email thread) going through the ftrace
tree, I'm not actually the maintainer of kdb/kgdb. I'm a reviewer and
I try my best to help, but officially you should probably have Daniel
Thompson's Ack for them. ...or at least make sure he's CCed here
saying that you've picked them up.

I've added him to the conversation here.

-Doug


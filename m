Return-Path: <linux-kernel+bounces-392709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1449B9753
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D991F21108
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F61F1CDFDC;
	Fri,  1 Nov 2024 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pDVR9O7R"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3341AB523
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485330; cv=none; b=QGivEwJ7Cky9kIEf37tEvYLaE3rXBbX40Ci9wrwvpAY1QFrncqoCaEXucpZAZ0/p00+w1SR2zn7+fbzxF8OxQGHCiXVk2og54XSC6La4hTuJpaUlN7/MnUJCK3fsNEFV9Vdq/iN9R9R5CuRfJJpGkMqumHfSf3DquW0hTkid+zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485330; c=relaxed/simple;
	bh=oICbhH4YrBVRKtDgMs3rfCV3tS4XMZrZc6IQWpg2qtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBym5/Yc+hi6TgWKRo8akWqyWizX3HvzkUi7NA2zFcszoHgzDogLrEKN5NBer7BMqvMn2r3Vf8gaR2ahIV3hZcpn4gnRFkR1zOxF3ydzxc2B843JqfKwL9aauONgeC+cBB9beTo6rDKs21GjRjLqe38y7N+nSQvzj4Lx4FTpSI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pDVR9O7R; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431688d5127so17542265e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 11:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730485327; x=1731090127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oICbhH4YrBVRKtDgMs3rfCV3tS4XMZrZc6IQWpg2qtg=;
        b=pDVR9O7RTHHLpx7xE3DGwpxQHhjBOZTPwfJLhER9zJKBNO7szR60wacXGUcRitJUq6
         z5kPHcRwynCtd4sJet0f904kpenJT45KPrA7MDL3xJR/GlYwITyXyQarxqzFlC8RoPQ7
         5UsSELJIt8IARUy0RJW0RHiBzosa77ZrhduB5M2S8bPw5E7/slDYTt/7PpqyS+B0HEio
         JU0rCUQVJ/uoBx52bwCG98tnYIpcQPAlWrraJI9NQaE/Yg20iQizgFIWjeyFWlyyWJUZ
         /imwNd+DhaD12bh9+TXpLxD/a0/QcJXeoxszTNmkTr3SWcGnmlYPlXKqtAwwVpZOXaMQ
         jkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730485327; x=1731090127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oICbhH4YrBVRKtDgMs3rfCV3tS4XMZrZc6IQWpg2qtg=;
        b=wgM29JWkBjVLIJDl0Sn1iM/cdHM0hnFgDsF2TPbJ2kIKWqJnegt3+f3lfsmMBzlfA8
         OdsbStg08Lll58FvDMTe9dGeeWNvAq2/suhHrIWI1XczQhk6K4bh6qmM8/dQtHZMqttk
         41aqrjptHSxlCakIbWc+9nMhIcQXCwDdNNqBYMkBo7Ke5r2/QRSatcNM7KpigS5wLe80
         5iB8e62k704T8NyVdNPlnj63YsqPDZPNEfbGikRQ9qKLhl+DIhxqUd3GjgVLrhCfPXuy
         DkjcJ0YgNOWg73zYgecSXbzspq3ECfCbGYlgDhPIzR1J8x9J8+Db0536NkIbiWXMIyr2
         oikg==
X-Forwarded-Encrypted: i=1; AJvYcCUXXTrL5zy4UXNl/TvurvZPW9QYkt3OBxfazxVf389HKXs2Ou41rlFx3oyfw9ZuGs+2pBZKELVv4TfCHwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxITZOo/bjZEaJggJJgsJ9youpSUHPTZ57TFoeDu0LSQlsmbXtM
	Ai4UWeVNVTUUQOAfke5Knoj2loAli6UJ6cIPjE28IDnxk0NONDg5CIGFp3FXoPs=
X-Google-Smtp-Source: AGHT+IF1e6YHS9MBnl6Cjc/7OEazhzAZv/hYfqCkLGAfQ9a/hEhsUgo2X503FPumpBQrrAc9lE4dmg==
X-Received: by 2002:adf:e3c9:0:b0:37d:4a80:c395 with SMTP id ffacd0b85a97d-3806113ce39mr16235424f8f.21.1730485327365;
        Fri, 01 Nov 2024 11:22:07 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6852d9sm69929685e9.37.2024.11.01.11.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 11:22:06 -0700 (PDT)
Date: Fri, 1 Nov 2024 18:22:04 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Nir Lichtman <nir@lichtman.org>
Subject: Re: [for-next][PATCH 03/11] kdb: Replace the use of simple_strto
 with safer kstrto in kdb_main
Message-ID: <20241101182204.GA752705@aspen.lan>
References: <20241101103647.011707614@goodmis.org>
 <20241101103707.290109005@goodmis.org>
 <CAD=FV=Uha5xwZJtdqirJtv27ZUBz7OP5oEnYg56v2i2mn0TrLw@mail.gmail.com>
 <20241101103128.46faf14d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101103128.46faf14d@gandalf.local.home>

On Fri, Nov 01, 2024 at 10:31:28AM -0400, Steven Rostedt wrote:
> On Fri, 1 Nov 2024 07:21:05 -0700
> Doug Anderson <dianders@chromium.org> wrote:
>
> > FWIW, I personally have no objection to this patch and patch #3/3 in
> > Nir's series (#5/11 in your email thread) going through the ftrace
> > tree, I'm not actually the maintainer of kdb/kgdb. I'm a reviewer and
> > I try my best to help, but officially you should probably have Daniel
> > Thompson's Ack for them. ...or at least make sure he's CCed here
> > saying that you've picked them up.
> >
> > I've added him to the conversation here.
>
> Sure, I can even drop this patch if need be. Thanks for adding Daniel to
> the Cc. I probably should have run these patches through get maintainers to
> make sure everyone was accounted for.

I haven't had a chance to review or hoover up the kdb/kgdb patches for
this cycle yet (mixture of travel and other things) but they are queued
up in my TODO list for next week.

I presume the tracing tree is involved because one of them changes the
kdb ftrace command? Are there dependencies between that and other
patches in the seriesm?


Daniel.


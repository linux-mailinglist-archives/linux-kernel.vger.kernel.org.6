Return-Path: <linux-kernel+bounces-256791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D109937049
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1351BB21503
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7873A145B0B;
	Thu, 18 Jul 2024 21:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ODfY7jiC"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3452548F7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 21:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721339672; cv=none; b=hTuX/WcFMDDc2DU8App81UAhPPYGkJInJHghayWtZ8yn3GXk+I6imun8cxfnh7TD4eAmwvXHwzdoFoI2RMjuzig4nE3W1kZW9u/+NHbAXI0BWu0dEA0vz3KnA5HZ6a1/aLOFZwjQtR2qPi/zom28+bWTzYRuZ1GHi1StHvE7hQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721339672; c=relaxed/simple;
	bh=kxSaFbSZ0d4EPFrGaNadTIfqjLIMI8M1IA56GACT6vM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBcZju1gQEyOns6LvfBjBq1XTBi8Rb6NSxmnMoB7KOQaqo3IdkDdcepi4kAJAhk3OfOp1oIn4CR+tQ4ncq7NMClpOfi1XMLNd0ll2Y3v9sh5MD3vRY9Ba+RP0SorRCMbhBhUKpTVeZlJT8ItyXpPLRrGb0SryYppUr7uhEFCAb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ODfY7jiC; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58b0beaf703so257800a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721339669; x=1721944469; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VC5uDA75evt44PLJen0Ah7ms93VwuMkCHXCKwIeiJOU=;
        b=ODfY7jiCPBY5sQm6C3eeXVeigAlyItj4jPB70NyB7Z2mczmUUSkTl6y+S2zU4xB/2R
         kXQdvJ0cQLgSLe4yQVMzPGnXgMZhiDm7UBMz/3PwPG3TfKkldjAfl9pYYO6TOf0QTbgI
         k1n6lnows0jQWMqvrXeW7XnCpIM8+L/IVrFWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721339669; x=1721944469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VC5uDA75evt44PLJen0Ah7ms93VwuMkCHXCKwIeiJOU=;
        b=CrjpFxJ0qkfkNRXjvTe8C8d5akxhefP/YejyMe1OkNcr7Sgk5jd5JWOReJPqspmTeI
         oI7qnfGZmdPdDjQgl2LVvW9V/2KHJf7bBkWI7rH6AfZdcdQDbZc/XpftQ/95zOtkvitN
         gB539CLOd66nVqRg1ns/EmMJIn5XfdfSO+XVHYbEzmCadlDoa4dw8IIYRnhWNOrQBVmO
         9/9le1c94BFX5R9b5pcEQWxTT/fw3jZzOP1Z1TOx28h5MkXx/xULiYH+LUVv/9J+CbmS
         fBrtPD7o2Iu8w6+RDlHOgytVBNRYkjQh/B4ZbtqXVbFiKZKlEJeyheldO9U0DPLHFgQP
         lf8Q==
X-Gm-Message-State: AOJu0Yyt/QV1cGkd3M7DNqZEOLvvNGRmKL9BzAgLgX2aCZ+KCITr4Pg+
	Imf4OXM75I1KsS8IHChnxyKwU8RZzYPAtGdf7DFLM2z3cC1eXo1Z1EXtEdbPNZg7zz21n+x+FJZ
	ETPiQew==
X-Google-Smtp-Source: AGHT+IEaJPb+M4nKs+5RolyzRLuRBZhmKz44dzGwTqCRp358A/snD5N5TT7O10JhW8+DhfFPWJv57A==
X-Received: by 2002:a17:906:547:b0:a72:8d2f:8594 with SMTP id a640c23a62f3a-a7a01147a55mr403501266b.27.1721339668769;
        Thu, 18 Jul 2024 14:54:28 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a33aca9b3sm5496166b.79.2024.07.18.14.54.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 14:54:28 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58b0beaf703so257783a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:54:28 -0700 (PDT)
X-Received: by 2002:a05:6402:2789:b0:5a1:cb3c:bd3e with SMTP id
 4fb4d7f45d1cf-5a1cb3cca77mr2181123a12.20.1721339667796; Thu, 18 Jul 2024
 14:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716162714.48febeaf@rorschach.local.home> <CAHk-=wiJwzMR6mZ8=Mc4bhCA3qRdwo_7NEHU80mSWoaMLTFjqw@mail.gmail.com>
 <20240718172937.2fb3e91c@rorschach.local.home>
In-Reply-To: <20240718172937.2fb3e91c@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Jul 2024 14:54:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQx-BiPQLe0rHLpvn1j89B8EgYPLvw0hGC-AUvF-uE1w@mail.gmail.com>
Message-ID: <CAHk-=wgQx-BiPQLe0rHLpvn1j89B8EgYPLvw0hGC-AUvF-uE1w@mail.gmail.com>
Subject: Re: [GIT PULL] ftrace: Rewrite of function graph to allow multiple users
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 14:29, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Basically, it's just to show who owns the copyright.

.. but since basically nobody else does that, it's worthless.

You'd have to go back to the email address and date range *anyway* for
everybody else, so you doing it adds no value - and everybody doing it
would be just hugely annoying.

End result: unless there's some actual company policy, please just
don't do this. Because your "copyright" excuse is clearly just empty
words.

          Linus


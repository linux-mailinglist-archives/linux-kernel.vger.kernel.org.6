Return-Path: <linux-kernel+bounces-276671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FF19496CD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2DB28A880
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B8A38DE1;
	Tue,  6 Aug 2024 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Sz+4ERIy"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD305A7AA
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965381; cv=none; b=tmwdIlhoYDZIZ7qIyiQ7APizAf0RuNxeOB7IN+RQjbPE1tlJjvE7CTTBfYiHU0RXiPYYvZsUkX2qZCBSzv5KanS/AxkiLT4qlxwnPPV+LVQ8d2NurJPqlQjhx7J8UPuY+doC1MOhdl/Tm9x6KpCTSX6gCvoFq7dhP35npLgWGAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965381; c=relaxed/simple;
	bh=xx7v86/eocdWGGSJYqaKCaUEbAnVCRrExqYa6BVqick=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3mGkqJL+/j/apvx3eLE/j4fhZkfjBXj507uqkCLGgemu2tNfN9DVi0wFx8gwd/uSBdmMcwI+Mr/etRGyyIWUpU1XOvYvdCM+V/t9DRhAvJAflr+Dck4qja2Km/3hWGaqy1YbBWt2QcR00GCbAu3HVoEhhudzMfR/2M3RTGURoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Sz+4ERIy; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5b391c8abd7so1030823a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722965377; x=1723570177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NsHqofcvPRphx8G9IS/KmNGNOcpQuTNopvqwRikc6Yg=;
        b=Sz+4ERIyMcn1z8k4HqTBQ+D8tsI0R7fBdJ0WLw5ZUftQKYyN5KyX4x6jgT0zUGWGOG
         G13hbI7PrHl0wPILXV2+7ikiGBy3mlVdyzNjQnx8rpBv3KZtjgSJYcSWTeI0wDQamHA3
         yGZsjYjD+sK2cpUebDydUN3WzNiLAetQIqglw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722965377; x=1723570177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NsHqofcvPRphx8G9IS/KmNGNOcpQuTNopvqwRikc6Yg=;
        b=JQmxrhOX+0a39rt1H99Tx+HfMukWtkXoJ0BOdH3gcwYeh5wCL2ctwLYrOCG9wj1TMj
         paOD5bviT1VXYZpOhjCf+R5ebip5zwF0U1ZGFE7+nPsgepHpnKDlC/xd7xosyU1/DtnJ
         4HvYgrlMojjjPFkl3YUxpVKB7f4Ns18nX9ECNZ3jMsS2i8yzE33avrn1XyKfB2ollyXv
         +3sAYOTd9UY0lQjuaC+nWTFQbL88GHWVSCYgL3cyyE9iF7TasaiDYseSzsTGpkljReXk
         cqFsReo6Dzt7yakL8t18JKNEuY1+Gj4tq0XHfklzt5xw6PEgD9iDUVsVUQeCnLh3Jaf8
         JjnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUguepB8Luq4CzXxcc+94OIO1ni7cUqsAlOROTSlkyAWuuE5eB4eo9XAr5HFaro9FRJDvaYmzzeytPyT9j+KvrVkZ8WEKi5Iw87f7Rb
X-Gm-Message-State: AOJu0YxzHacdHyJ7mpNz6yirtitmgA07QZ4QXt3IWHlJTuEUgV0UJjPI
	NQnJzEiIJ+p0C5izP2/lHFO8R8NVW4z1s+xgXWFizvN9/4ykI+wGW/cd24tPmL+1/9NHoDUhkxz
	qEA6yYQ==
X-Google-Smtp-Source: AGHT+IGE6y6HtA4UDKFm9N25zwCaMnYsfhBZ8UXw+XD6T2VQuJxXhiTSz8O3T1gnOZk1idt+aOqAsQ==
X-Received: by 2002:a17:906:f592:b0:a7a:afe8:1020 with SMTP id a640c23a62f3a-a7dc4e8c3d8mr1091317266b.31.1722965377383;
        Tue, 06 Aug 2024 10:29:37 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d437d4sm563475766b.132.2024.08.06.10.29.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 10:29:36 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so86400666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:29:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJ9fMX3duLCAvbsSh5Wm+GBrKIE0QLaQBs0Nj+v9sO07ibBiGHAyUMk+e3Zl8PLtL/TStN5v6KKFUaP9zAKJOupV+FpUt0ZmfxPTdO
X-Received: by 2002:a17:907:c009:b0:a7d:cf4f:1817 with SMTP id
 a640c23a62f3a-a7dcf4f1a38mr1053374166b.0.1722965376139; Tue, 06 Aug 2024
 10:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
 <20240804005138.3722656-30-john.ogness@linutronix.de> <ZrH0CYDseR1b-QfI@pathway.suse.cz>
In-Reply-To: <ZrH0CYDseR1b-QfI@pathway.suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Aug 2024 10:29:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgh=iQD2Xb-jRSE45Qm1H=y34OdzG1B-pjMWT1Kr2E=rA@mail.gmail.com>
Message-ID: <CAHk-=wgh=iQD2Xb-jRSE45Qm1H=y34OdzG1B-pjMWT1Kr2E=rA@mail.gmail.com>
Subject: Re: [PATCH printk v7 29/35] printk: Coordinate direct printing in panic
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jani Nikula <jani.nikula@intel.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Joel Granados <j.granados@samsung.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Aug 2024 at 02:59, Petr Mladek <pmladek@suse.com> wrote:
>
> I want to be sure that this is acceptable to you.

Just going by the superficial code, it's perfectly fine to delay other
consoles, as long as *some* consoles don't get delayed.

So yes:

> It is a bit different from the buffering during Oops. In this case,
> the new nbcon consoles will still be flushed immediately.

that sounds fine to me.

In general, I think delaying flushing is fine if

 (a) re-entrancy issues with already active (ie non-buffered) printing
on a console

 (b) there are higher-priority consoles that did flush it so that
something made it out

and obviously the whole "nbcon existing" will match that (b) case.

(In a perfect world the (a) case would be per-cpu, ie a "avoid obvious
deadlock", but honestly, I think any oops while the console is already
busy synchronously printing is understandable - and any concurrent
synchronous printing may be the more immediate cause of the oops -
we've certainly seen lots of cases where a bug on one CPU will then
immediately trigger on another one).

            Linus


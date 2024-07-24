Return-Path: <linux-kernel+bounces-261467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E5393B7B5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6ADA1F24E52
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5477116C84B;
	Wed, 24 Jul 2024 19:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TDDreOo4"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA30215ECEA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721850553; cv=none; b=n06mKsOf7OFwEcdTtecfj6mGtiowYY+9wt27vWi2ra8zk8EDYUbLBx3m5lspaXhlmZX8XWfHgM9GnXgO0sLDj5btybu8A0Zu4cfMMbhWAAwYGbTMhUtWXtgxalO8PG0N7D7oA2+meBV69Df1LUmJewW6mTp2+ScPgk8Xg7ieAkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721850553; c=relaxed/simple;
	bh=VfdDSnAV3ucuOm3/iSScx0PP8UrNHThuirZH40RvPuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ac51UxnnqZMlCg2beJnw/RS4bySNqnfDMp1h2v5Co9B2QyGwl/nPrFjfagI5qVDcsucoUcTrFx/7n1NWu7+B7CgIjH48iqrtfUtHgqZ5It2Xc/dyxnRNiHfIFtP42jGZXwGQ6vRxgk/Eg+xtxL/wg2L+ud4+mZAhwdEDbScCDl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TDDreOo4; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a9e25008aso32292266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721850549; x=1722455349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ghePSl2d8bQvN8cPdHzzrvTunMGaXuooZOZcFeoWIOs=;
        b=TDDreOo4qzSWXGmmCj/cFaKizcwhkwCr5OQhqgzGVrzquguvblHhmyc/YZw9L1I43u
         vM7RrLunazvwNQmAFZICfDMbHUlu9gYWqt+pzBTh74tjcwfZW3SAaNUZxXMX1VlJ4IZ0
         vf02n4RuHIdtF5gWGHATTriThfAsaKN73sTJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721850549; x=1722455349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghePSl2d8bQvN8cPdHzzrvTunMGaXuooZOZcFeoWIOs=;
        b=rd26NZD9nPockhNO+JiJR/W8hR0M14C4eplBooEZQFeCprKXukFl1RRJFr7sR6YzdS
         vVbOzKBDyXYjd1ipb3VH1COpjv2RZa8kjrHCthhAsj/vfRCGNgRlsTmdXkLt+0XrL4s9
         QOwIAfb1x32B7f+Ic1WNzcTDM88iMc4RA/n6aEimw6PevckMKTAR588qTdfPOTIeHP6Q
         2p9howMYN58UxVbcpeznwsprQQdV2wmyQXhK3JysN0tWW4Aq6Y2JWuA10J4+YPmR0J2d
         wBC6beWnH2gwMXZQ2PRSkiCGGsK9nYpK0GLW70ZUwP3fCeDAywFE5H7X/uwhb6yNqsxd
         P84g==
X-Gm-Message-State: AOJu0Yx1mVxOnQXKlgYwGStqhiptQs/S2U6TYU5YCV3E0tqQMS/Gx4OS
	z0cxTxtQfAltS6xfLUHP08kpT/2D5YP7yIj2Jg3MjxVn4kOLzE0mJWJ9/P7TCXg7gRGdfJOTmwF
	oxoo=
X-Google-Smtp-Source: AGHT+IFL6OA5qVDVm2BXlgB7UYqvkWZX9eyuZwzXsIQvD0ylesrlYMq3bpII3ARgy/eqrhUY3OMD/w==
X-Received: by 2002:a17:906:6a27:b0:a7a:9ca6:531 with SMTP id a640c23a62f3a-a7ac5129d42mr32208166b.4.1721850549653;
        Wed, 24 Jul 2024 12:49:09 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7ab17e8db5sm94390666b.123.2024.07.24.12.49.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 12:49:08 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a167b9df7eso281966a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:49:08 -0700 (PDT)
X-Received: by 2002:a05:6402:5111:b0:5a0:c69e:56a with SMTP id
 4fb4d7f45d1cf-5ac2a0efa1amr308365a12.3.1721850548399; Wed, 24 Jul 2024
 12:49:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com> <9751d18defea406fa698630637d8e7db@AcuMS.aculab.com>
In-Reply-To: <9751d18defea406fa698630637d8e7db@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Wed, 24 Jul 2024 12:48:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQr8U7nCnUci3_20vKyU2cx0BQ7HRNqxsHm+EP-6PCPQ@mail.gmail.com>
Message-ID: <CAHk-=wiQr8U7nCnUci3_20vKyU2cx0BQ7HRNqxsHm+EP-6PCPQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] compiler.h: Add __if_constexpr(expr, if_const, if_not_const)
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>, 
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 07:30, David Laight <David.Laight@aculab.com> wrote:
>
> Implemented using _Generic() for portibility.

I do think this is ultimately the clearer implementation, if only
because the underlying trick it uses does very much depend on a very
special oddity in the C type system.

So then using the type comparison with _Generic() is rather natural,
and allows for picking other things than 0/1 as a result.

However, there is NO WAY this is a "portability" enhancement.

The original trick basically works on all ANSI C versions, while
"_Generic()" is quite a modern thing (added in C11? Something like
that)

Now, in the kernel we obviously already moved to -std=gnu11 a couple
of years ago, so doing this looks reasonable.

But what does not look reasonable to me is claiming that it's a
portability thing. Quite the opposite. It still requires the same
ternary operator type trick, now it just requires _Generic() support
in _addition_ to it.

              Linus


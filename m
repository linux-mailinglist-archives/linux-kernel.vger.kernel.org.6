Return-Path: <linux-kernel+bounces-537787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4CAA490D7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 06:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1A61891453
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F9A1BD01E;
	Fri, 28 Feb 2025 05:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UqHYHbIe"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B0F1A4F22
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740719890; cv=none; b=gBeiNdjJIX42VI5tvckrn9917k0bWWO8RKkENVW6DyXfr7lPnDYNc52ePUxvlM8ddJPbURcSNr816k2/TN1hcUMZ9r4MMOzQVFZeZcfKT4OMtJO07yNi6tzPGXxK0wZWT7/AZHHrn7NglSKtbkig23eoaXimuWL2SSxf3ygVphA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740719890; c=relaxed/simple;
	bh=Y3QDpjc8x9KPwlveUMGsg1muYaCxAUlYz/LD32JL7DQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxTjXS4B5/qoujSXLGUKLbzIT3chzCeBCPC/HiXpuA6G3Oi6/nfZ7F7i+AsrbkyjB8Bw0rwFgLyu8raGYoJ8X4KnB1y5l0EuoRzvwt8jYB7wORwMrvQHZa5soP9z4uxW0U4IubyYuPBoT6yQtvUdgkcMFM4JeQ+M/Rnf1ZA2tlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UqHYHbIe; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abf3cf3d142so2827166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 21:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740719886; x=1741324686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5yXmfMp+a66aju4mWW7FzXsEpdGr0D1aag/ZSeEsoTk=;
        b=UqHYHbIe0v9mn+rVEz+WH3HUFOIWjHaF7ofUJ8vgKe2cgkpsPs0KRMiQBWpBrQjLE8
         h5tSmgMBIuDKhTqVX2DDTu76nu1fKd4XSJ14SHeOm8KsaoHjVsfVc/LYPCt3vEKA5lsF
         ahh2WuXp1IhG3Xcl4hrWONKXhK+WNe9rRZnJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740719886; x=1741324686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5yXmfMp+a66aju4mWW7FzXsEpdGr0D1aag/ZSeEsoTk=;
        b=OLB6aY+0KJ93cU477dXoKSz+sv09m7PK0n0AbwJJW0KBc2+FkCyREV5LEh3XRiwqwD
         2d3T/tCmKtsGv5BU8D7IOrNKaGZ3YLleF3/bqxOB4VtMQv6b2XFKxYOnD6C8mtLqOOSN
         MKjw9YQxzcF2IeP6DgPL7WTK68qufiixAdM7X5J4wt8GGsPY80eaxK2d/JhyBZy4gUhL
         7Gtyx938vdmW6LyWjVK1fZJczAdnwYTBj5Ttys+t5RjRRgcNNBezHML6fihApqJPwfwc
         TibtwwTKbFrZFMCmeMz3kfH31EWk0J93+kPV6+B+8VUn+ljAnP7vjcI6Q/wgVh/5LvoN
         Iyzg==
X-Forwarded-Encrypted: i=1; AJvYcCWLq5RF89KxBApjuoVfptMnaoJI6m4T/tMCLl+UbUg+11XP8m7OZ9IsnrUHaU5CnqCLEFIKK1a8oCpFUwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbgeVoMU/ucR2b7IW2vaxILzpAyrbUCvpTSvC4llk9wBBXpJq7
	YgRp8+0rDAK1KSfmC0xWs6Xk/3oYl6TP/wLPjg1KMdZ8zPewD0X+TroSYmRKBmlFH/CklORlQHg
	CXJssxg==
X-Gm-Gg: ASbGncvMxt86+9EJph737JzKjtdZra78XQWqLYZdDthoV6a/Bjt3Unu0FCVdB9LGQe+
	oM7Uwjl9opJVSlPZTtlvznV3stXlqFaJMU1uutnXD7lS8J7XVRZ1gD1MSYjv4bqqiepNHeet38N
	zS0RfG1rRJnTbM7x5MrA7QQG2+W+82yWdiX1uM6arF2lncXSmraFbbiDKv1cUBXsIeTrm7PSNfh
	rsNCDCYCJpfuGYZCFNY4ZdQQdi63TWgaIHKas3Oc47hLj1eI5zLZcn1DWXwNf62KqgWp2H+c2eM
	x8a11NN1SV17YiMD5KIk3kElWWP1TW/uWi9qPmpSLEjbWrD0CT14LIrzdXDqHZROMWgINbYguma
	y
X-Google-Smtp-Source: AGHT+IEuD8IjZEnzFZU/4/Z/ENYVzQI+o/JxIFxyB/v01LWdE3e9CdrVeMRMWVfAJVx1rLRMvm/iFQ==
X-Received: by 2002:a05:6402:3493:b0:5de:b438:1fdb with SMTP id 4fb4d7f45d1cf-5e4d6b629b0mr2997986a12.30.1740719886061;
        Thu, 27 Feb 2025 21:18:06 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c6ee462sm228739866b.117.2025.02.27.21.18.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 21:18:04 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so1934390a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 21:18:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9cO7ZI0xUUV7J1Vi7usLP4swEjfgTSNbWlFlB319Evmwqso3KVRZ3772TH85vLo2SSMpcxwvLrapO4CM=@vger.kernel.org
X-Received: by 2002:a05:6402:2695:b0:5de:594d:e9aa with SMTP id
 4fb4d7f45d1cf-5e4d6ad7683mr3024531a12.8.1740719883992; Thu, 27 Feb 2025
 21:18:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com> <8524caa9-e1f6-4411-b86b-d9457ddb8007@efficios.com>
In-Reply-To: <8524caa9-e1f6-4411-b86b-d9457ddb8007@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 27 Feb 2025 21:17:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi5-+P49c3NPeZB_qrNyOtAJS3YadHB0q7J3eZ3UUwrjw@mail.gmail.com>
X-Gm-Features: AQ5f1JrfxM-9IRCUJ4y0kXr0sjyAxoJ14Cpfy_Qm1TIXy5Xrapi2wwGX1WZWfdo
Message-ID: <CAHk-=wi5-+P49c3NPeZB_qrNyOtAJS3YadHB0q7J3eZ3UUwrjw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Olivier Dion <odion@efficios.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Feb 2025 at 19:03, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> I'd be fine with SKSM replacing KSM entirely. However, I don't
> think we should try to re-implement the existing KSM userspace ABIs
> over SKSM.

No, absolutely. The only point (for me) for your new synchronous one
would be if it replaced the kernel thread async scanning, which would
make the old user space interface basically pointless.

But I don't actually know who uses KSM right now. My reaction really
comes from a "it's not nice code in the kernel", not from any actual
knowledge of the users.

Maybe it works really well in some cloud VM environment, and we're
stuck with it forever.

In which case I don't want to see some second different interface that
just makes it all worse.

                 Linus


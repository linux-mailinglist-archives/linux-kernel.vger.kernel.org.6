Return-Path: <linux-kernel+bounces-325477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A1F975A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910221F21C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7711B81B6;
	Wed, 11 Sep 2024 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QLQDzddJ"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5482A1B142E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726078308; cv=none; b=hSEIDYKEHdkrBcYPw0dvrYprs49cFlvx1ZuZ1Vxt0wgLemZZI2I9mJedN1kob9t91mv5/1u/NwIyBPzRw64T2SE08wAqG26r22uX2Zw/UsMkpC1wpuSW1jod/EMWEUI5zs7lmulYxYzAst82lqUI9dlV837t6x3UnrTeOemlf/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726078308; c=relaxed/simple;
	bh=z857oVhOO9Ge5wn4k4nabsLRCg+zyT2pPs33TkWJQgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVzHCBjlL38TZ3Mab8aYHL79+G0EdTj5dGVJ6Rpfke12SXVyqwS79eXqh2ifwvCfH7tw95/yEh4x5tpxg3nGvx3bI/So4KTZnaDVEbAFtY4DJCUlxkAq8l/MfOJJP8P8MG8Q35PtP6wa1DMTe9S9Lza7tnubT3vzZghbAHv7k9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QLQDzddJ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c3c3b63135so60975a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726078304; x=1726683104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QXiJI/L0vchgadKCOX7xJsbzxv2AfJtb8fmGhILgPNI=;
        b=QLQDzddJHGLjsGGeAU/V/QerDX+8YYLHUswbATuFFhKBdQrsC7CBrFaJjwOqlQn02p
         tpVFrUtM/Ca7GRyEfJ/ivHZXoEfElvTDcJrjfmEP9SY4Slse7JgyL3T6WWkSbsp9gRaI
         dpI61X7heQ6V9ISr1aKwEzIe4OZog/cF962IU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726078304; x=1726683104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXiJI/L0vchgadKCOX7xJsbzxv2AfJtb8fmGhILgPNI=;
        b=ckb2hh+ju6Tqrx6jQKan57FjChXJ9YUGFOXq6YsJ11kz6XoyXNqmHCWjSyvp8yBdPe
         6ERtD+QY6zZBdHaK+KWQcommvNiw1yXRRfAQdwG+9vQUgeARKgsMroIP5Qz28AFuH742
         wuyhkoPNtAueDQRjRWh9WCHkKRFiROfsKtEbS6NBZDu8ajJDU3Z9MrlgpYkHYAWI9Y1b
         lfZ/f+C8bCXRy17LRuaiC98LnPZgB4UBcFAg9Y173wI++olOZRxuWDoxO79xviQvYrOW
         hxWNYnr/bw1a0DyGvIa6+LuB/IJt77f/26+BtX5r1KMcXnrWDyradwsM0qkdPDDBcVZr
         iF4A==
X-Forwarded-Encrypted: i=1; AJvYcCUlmJ5b5HRQupW9MRHRtrTyuQW2Inax9hy98zcbrN35gM9RKLDMa+xs0SWMtAxZpz0oHPHgT4/a7x8SOAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhNB8Axhc4GwV8NO9EaKXvptLrMc0DkjwlJ2dYaiIKd6Kq3GvN
	aE87QAkglKfrPcjbM4n75VDd00zOnXPmoXk9Cr35y3v+tuwnTdTcDLueThExy2W3I2f+zuwEf41
	+FcfSow==
X-Google-Smtp-Source: AGHT+IFI4Scp9qdEBEayBY00Sl8V1rDbvypcdQw8bscW+irtRqzSy4pHMDkng/4c9pb67oh8E7woGg==
X-Received: by 2002:a50:eac9:0:b0:5c0:aad3:c8fc with SMTP id 4fb4d7f45d1cf-5c413e57b3dmr224999a12.30.1726078303467;
        Wed, 11 Sep 2024 11:11:43 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd46824sm5629715a12.23.2024.09.11.11.11.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 11:11:43 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c245c62362so113687a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 11:11:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/mlZTe7gSIbQnmcyhWAZXdPdrZaL7kA65w8KWs5fsjeZzZDQF6A6N1SrZAWkcESpTi5xhQnHQKU6NdE8=@vger.kernel.org
X-Received: by 2002:a05:6402:33d5:b0:5c2:5620:f70 with SMTP id
 4fb4d7f45d1cf-5c413e4fbd6mr215370a12.28.1726078302536; Wed, 11 Sep 2024
 11:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1726074904.git.lorenzo.stoakes@oracle.com> <b38d8936eaddd524d19823f7429138e2ef24e0d1.1726074904.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <b38d8936eaddd524d19823f7429138e2ef24e0d1.1726074904.git.lorenzo.stoakes@oracle.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Wed, 11 Sep 2024 11:11:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWJmQJSWz_5S8ZqEpDs1t3Abym9DPZfUzWu+OCNM3igw@mail.gmail.com>
Message-ID: <CAHk-=wgWJmQJSWz_5S8ZqEpDs1t3Abym9DPZfUzWu+OCNM3igw@mail.gmail.com>
Subject: Re: [PATCH hotfix 6.11 v2 3/3] minmax: reduce min/max macro expansion
 in atomisp driver
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Richard Narron <richard@aaazen.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>, 
	Arnd Bergmann <arnd@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-mm@kvack.org, Andrew Lunn <andrew@lunn.ch>, 
	Dan Carpenter <dan.carpenter@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Sept 2024 at 10:51, Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Avoid unnecessary nested min()/max() which results in egregious macro
> expansion. Use clamp_t() as this introduces the least possible expansion.

I took this (single) patch directly, since that's the one that
actually causes build problems in limited environments (admittedly not
in current git with the more invasive min/max cleanups, but in order
to be back-ported).

Plus it cleans up the code with more legible inline functions, rather
than just doing some minimal syntactic changes. I expanded on the
commit message to say that.

The two others I'll leave for now and see what maintainers of their
respective areas think.

            Linus


Return-Path: <linux-kernel+bounces-266575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C9D9401D2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF94282CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7E318EFD3;
	Mon, 29 Jul 2024 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UZSG6QBj"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423131E49E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722296879; cv=none; b=meBQbOq7xbLG5N7uQLy8HMKC6WCrBwVI0+AsUr0pip8/iBAoGoMlZz1QWgL0hxiM8mpS1RObT8zY5FPvv9zzb8HibwJ6CGTsy7zUGSQPC1EbcZz9aB90s5vuVKBb7nz5VNq0pKBpoi3fqt3gNTBeWUzuep4VLHuu3VYF5wOA5Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722296879; c=relaxed/simple;
	bh=0QUOS81IFaHUIcJxD0BM4wpNFOqNj+mt/UDriCusWNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWkuxU00fqXDaozA7Wj77FWaT3bZtGQsFFln0vKUYRPycv/qGu7BDLqIR3lEw4FczHYLPEYGZmDKRVCbsOnKAjryWtAn914MN/14wLGd8ZheSTVFmJIQDHy1HXYeuSr+qKt6Ov4iMRJNGqvQadxxyRxB4kBHFYZJ3INEHxZafj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UZSG6QBj; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef2d7d8854so50621061fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722296875; x=1722901675; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O/8PW+1tYbsYQWIxCthVFiu78jiJW3D7ZHGClJVXYA4=;
        b=UZSG6QBj1qMbuwlS+Q9A3SB/VMaib/7EvX3xzloGeuKbbjN8rWBWeIeyipbFMwB/RD
         /F/OJlHHLKk4xGFis3Jdcsz88GOMXdGRu877lAtAlxmEh7zhkqWmCMY195cN0/ztpDFJ
         rwtR2sieTCJWQu70bEnspC1kSMtUAZp+6O8cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722296875; x=1722901675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/8PW+1tYbsYQWIxCthVFiu78jiJW3D7ZHGClJVXYA4=;
        b=uo/RqZR3bkHI4EBuxyYwSFqPT1a0dGU3vNK1m5D57wqHSq1D1hue08vS3rOM5/4vq3
         RXl632b3F+OYHRxWrHEMzhiU2nfdM+YYYgKKNjZ2GsjTEVanf8I/muhxK0gLMixb4pwV
         TXUEYWC7UhQKeqBVc6LUdCYfqN7ujxAkINVU00BTzUzQ4BgKD++jj3/tNQceoQloI9Vg
         hf6Ilg/25dAKF4wXKBozr2M7tZQcPyOd39bFdUyT/PoQuyL24HP810ATZ9ZI0YL7xpfF
         lmaVBsUTj8+PZFFB/NxMGr0QQ0mBJ1tlrVA/6U01GWdwq5ehNkz9JAYpynH9bZnsFru3
         vunw==
X-Forwarded-Encrypted: i=1; AJvYcCVY2+7FI/dU2Gy8gE6gtDA9L+2JMAZ9KodsM7HDxQEfhlxTUxNLZdLHplHMv224RPZc8IcNCzseAlk9I8+Po7hHctIjphToboWBdvC8
X-Gm-Message-State: AOJu0Yws8dye6sHGCztD4STFUfzyiKUwUU181eQ2WM+f0W7oCijpmSoK
	1ithbzmx0rlmDVq/AwTW38hIdluTmsNBB102M69yFW/a3WZpW3hJyywn9O9ynKg8j3Y3BiDvAHe
	uMygSQA==
X-Google-Smtp-Source: AGHT+IEhIVz0QlMNke95VZK+WnmZzc6ILR49l98m/kMFhadQH0ItzBmLonrMI1r3hnRxG7rKCLJpuw==
X-Received: by 2002:a05:651c:19a9:b0:2f0:1a95:7108 with SMTP id 38308e7fff4ca-2f12ee1bd3cmr63052901fa.32.1722296875150;
        Mon, 29 Jul 2024 16:47:55 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac631b0491sm6446056a12.8.2024.07.29.16.47.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 16:47:54 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5afd7a9660eso4269736a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:47:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXiInkFvwsr/ilA38RaXM4nA6vHbCApCGfsypxjqLdqdLkcbXy5cCjfFVpsLItrgtglhsfyXBTkcEcLTrNZqiO6TvHhgVezqvHyTVgl
X-Received: by 2002:a50:cd1d:0:b0:5a4:1bde:eb18 with SMTP id
 4fb4d7f45d1cf-5b0224d00f6mr4667442a12.36.1722296873848; Mon, 29 Jul 2024
 16:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net> <CAHk-=wi-U672Eji+tz1x7JCVyEBjEGmm04umj9JqwfD5n8BMGg@mail.gmail.com>
 <CAHk-=wgEyzSxTs467NDOVfBSzWvUS6ztcwhiy=M3xog==KBmTw@mail.gmail.com> <eb1f2ec4-2bdb-4695-8e69-867ff25aa405@app.fastmail.com>
In-Reply-To: <eb1f2ec4-2bdb-4695-8e69-867ff25aa405@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jul 2024 16:47:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5ebLqtgR84OpkWCxUfVMA2OLtMfdW7G3kzkzeex1uEQ@mail.gmail.com>
Message-ID: <CAHk-=wg5ebLqtgR84OpkWCxUfVMA2OLtMfdW7G3kzkzeex1uEQ@mail.gmail.com>
Subject: Re: Linux 6.11-rc1
To: Arnd Bergmann <arnd@arndb.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Peter Zijlstra <peterz@infradead.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jul 2024 at 14:35, Arnd Bergmann <arnd@arndb.de> wrote:
>
> I suspect we can fix the alpha issue with the trivial
> change below (haven't tested yet), but the way we are
> inconsistent about these will likely keep biting us
> unless we come up with a better way to handle them
> across architectures.

Well, looking around, the other functions (ie things like
iowrite64be_lo_hi() etc) do end up being handled by lib/iomap.c, and
parisc does seem to implement its own versions.

So this may in fact be the only such case.

Knock wood.

Your suggested patch looks ObviouslyCorrect(tm) to me. I assume I'll
get it through the normal channels after testing?

          Linus


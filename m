Return-Path: <linux-kernel+bounces-207123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F60990129F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 18:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D24281F06
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 16:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1209D179949;
	Sat,  8 Jun 2024 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JezeoltD"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BED524C4
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717862597; cv=none; b=doHn+bvmxF+GhfJ+3UuYd5znZdXYeUuxTw52pM4lPxech5qUuSurUL55jhXXHRyUuPtYK/yV49QxSHUhYAqilHX4rZN5FiBRBiYbmuoRNWBNxKWjyk4fa12PNBt9lZj7LpJO7jkJwtGIwUlkKIRzLBubltN0leMZNLxrnZYLueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717862597; c=relaxed/simple;
	bh=ZUGv6tbFAcbWuiVVg5lvhzpTD6NAzR4l2AWzqaVNoDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnqAfvIhi6JrOhXUR5I50PgquxxNPg6dLO8alRgYUSGQcbOheWSyp3o2pZTvjUWCumhPSmVjte73JQ6NbBsWu+zCEkWn+bieWEq0jtTMTr+sZX/krcqfKQ6FHLUY0bE39rwiF6Z0K2aJKWF9CxWTm3JEoLaiKJz/0P9yJvXFWJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JezeoltD; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a32b0211aso4230609a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 09:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717862592; x=1718467392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sD+Q+gVC5+5P5PQukDTDDjpSK/EVimfSh49c8qeKnVc=;
        b=JezeoltDZNN18bMZogM0h+G8NJ5PL6Pzw1mJDF1XEkiFjyedw6+bwfEJCnlc03bZcG
         4HLkmWExJfXAz+qOmeeVdrPBuzVXGgTqUrul6ICayb0LHJ0TxmzpJlFVi4e+sOv6249w
         qOY3jTkoXR8bT6MLEeI6mabmML42ztaO94oDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717862592; x=1718467392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sD+Q+gVC5+5P5PQukDTDDjpSK/EVimfSh49c8qeKnVc=;
        b=FNRUb33EPM9B/ykBXoHwPq2Fm5NDWidrF0jlJgPKtqJR+D676yLSlMSNHwP1bv6b5R
         OUXyK+rS/qt2Sy5MmLQakkWQgkmmy3SkJPEU/NLtjyQBr6xJ1vLAX1r0+NCvSu6yjGfw
         b+AmIe9FQy1/LuwpUUvBM56fYRBYq5QqxrW3J9eR0h1Ds2Cj7aauf40Jr958PeP3o3hM
         II0NSJso7Zijvew4NPUXOHQydHq6QX1m6yQ71QEgZRl1nAypppLfJBMozXSP4XocPaM9
         wAxL5aYAgDMKNuroiUrPpUDHwW0kkyDCjim4mSrdDHjkhpWvP6sUvEeGNPq/PR/5g5Ds
         SOow==
X-Gm-Message-State: AOJu0Yw01svrufiK/YO6a2h0HxQSGQhwjh+7lTKM1fCGv0khq86k7/K9
	fvlFLxpWnWC+p8gGnI+Hg95+fuLPi5kFiT873JTkOE5KnQoaNxCWVA3vsBYBk2i8Vt3xinQMYOB
	eq6Q=
X-Google-Smtp-Source: AGHT+IEi9JtA8ObVGVT8g0LWsBtf40jJeoxLUGOm5A76y7Ev+f2ZwyvP9n0DfrkKglk4HwbZSQOi1Q==
X-Received: by 2002:a05:6402:3106:b0:57a:3357:5967 with SMTP id 4fb4d7f45d1cf-57c5095d696mr3382493a12.30.1717862592595;
        Sat, 08 Jun 2024 09:03:12 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae12ce21sm4427956a12.49.2024.06.08.09.03.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jun 2024 09:03:12 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a68c5524086so364735166b.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 09:03:11 -0700 (PDT)
X-Received: by 2002:a17:906:f599:b0:a6f:dda:8514 with SMTP id
 a640c23a62f3a-a6f0dda8694mr89210566b.47.1717862591608; Sat, 08 Jun 2024
 09:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wisJ8bS3qe6iBPwL9x=PqJA5oE7tum-E9oZfyPgd2mmrw@mail.gmail.com>
 <46cb50d65e414bfd9bef5549d68ae4ea@AcuMS.aculab.com>
In-Reply-To: <46cb50d65e414bfd9bef5549d68ae4ea@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 8 Jun 2024 09:02:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh170Lme6HHSGa5eM6YNcd01vdkOoPenZ0m7P+Yv6_zxg@mail.gmail.com>
Message-ID: <CAHk-=wh170Lme6HHSGa5eM6YNcd01vdkOoPenZ0m7P+Yv6_zxg@mail.gmail.com>
Subject: Re: Linux 6.10-rc2 - massive performance regression
To: David Laight <David.Laight@aculab.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Jun 2024 at 07:44, David Laight <David.Laight@aculab.com> wrote:
>
> I suspect it is due to the changes to the way the scheduler pre-empts
> processes.

The PREEMPT_AUTO changes haven't even made it into the kernel yet,
only a couple of preliminary rcu patches that aren't relevant yet.

So while there's been some scheduler changes in 6.10, they have mostly
been pretty insignificant - mostly some renaming without functional
changes, and one-liners.

Obviously even a one-liner can end up resulting in random oddities,
but could you try to bisect the issue you see to pin it down?

                 Linus


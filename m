Return-Path: <linux-kernel+bounces-226881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD819914534
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 045F51C208DF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DDB5A4D5;
	Mon, 24 Jun 2024 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zGslywoj"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB3E2907
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719218710; cv=none; b=W7WhCMyO+tTFAEFQ985SYgbCebyCMCAJd0d1hcGBR+brJtUMFn/t7MywUkXfa82rL6LYDmW6Pxvj4dzNpE3V9Cb8cj5w5OkDTrmQ0ZYFpsVy/iUeHf41eEnFDezNUe7AR/yEm6q6E7orXK19O59hwtR8EpZ090bj2xgsNUbSO1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719218710; c=relaxed/simple;
	bh=7Kgfs3Bqsi8uYJcn7x7CSEhi+9gpOZ9jwPTRhAoQ7RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raC5IKmDSYVloDk6WbKYWFUqZcuiD5uj6ilxB3YZXmmNwO+4Ih8YRlb5juQdwLnyff+8rJRAcgTm0INVv/xvRmbRzh4JNeiafTsIfWUe2vnLNnusQdYTtFi1CUBghJJfgRgLTiK5uFtIUZ7uk5IW6U3HuN6NSJPBsga+MvonnS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zGslywoj; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-80f636b0171so983336241.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719218707; x=1719823507; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qIXxm2YFEoM3D/TQ6OYSQnHC85tugn6XrgaeNPvetWA=;
        b=zGslywojYjWkUvaeWgKx99PmiccF4lnt3K1LJPOqsHZ++qI84d1x0Bkkr8yALLOq9n
         t7WLZN/kuZd0aFXZdG/o/HGMXL2Pu2wEn59u6dLYRd5Mj6mRl+gCIsnnP2lGI7KWRkm+
         ACNlNXC6kV7PJbEwmYHLzn6V/Bu/CmAeqnOok7r76+PHjv5swN31XQnZlmtMNNGH2L4t
         VSpGfuQLYIQVvL8uoOOZutX6/jXxCVVACzb5fwww6vXzS6NctmVou9Wv/ZwW1lMKA/1d
         f0atXgXuMRlczJneyDCdin2sd2Kz/G0PXvdDWiUxv5Y6qfVo6EQZ3JlF2gY7UJllvtlS
         3hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719218707; x=1719823507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIXxm2YFEoM3D/TQ6OYSQnHC85tugn6XrgaeNPvetWA=;
        b=HhvvH1SdkxxM3H3leZd0yYbZVJWiFliijWVrHzSi1kW4OAmWou3ye87nt3j2cTdSoJ
         89e5UR8v+5HsiKwzxE07K6G6HzkVovFFEdo2nGq0E8tB5j5SaSqYLLh3kL5++nw2kkWF
         wibo2PdOaQJxvkOfpjZVDI6h0TgZx8icZM8FmOJ/eVVKvRRKBUEHNC+a91lRCig3Tumj
         KoV1fnp8fZNpbBjecif8ofu2SQqLILF/CtgIKqTOQvMA3D9FUNzso6ouPkkzeNbQul4B
         54mRn8mKX+rqQIYSUUUvz83KN4Ybt8Lvsnr5KjaunxnpwWbHXsQy8KspvRslUrwZKljb
         iMFw==
X-Forwarded-Encrypted: i=1; AJvYcCVomvyFXyu+sAt9/3uSs1A/gwzukLZJaOMLRysdADSZZrLINmBcGkZMU2UdJca9BasQuzo5eS7dnXP06GA/HUA+K34DczY5eXf+woGi
X-Gm-Message-State: AOJu0Yzp74llbRNQ7nEU9dNwWUZ/+MyYwmK8xekwIPudyLFvFRP1EJSr
	NDmphGp7TfXAL+fBuF9DxWOeZqbWT8jgyJLyC3B2J9oxefZKJFUsQiFcpv9i7CbuW+AkiX76NeJ
	2EYfCMQSKETG/Ho+r4EdFzosGAsdyAlxS6Ii2VfvqGRnyfUiBAAQPpo8=
X-Google-Smtp-Source: AGHT+IE6z4mOIRGEsF2KsWC43ZlvnnLuv1sC4OyVD6BDuN8dNb1Jg7Rd30G519rdXNCLiPbDMA0f8168voawMSAByMM=
X-Received: by 2002:a05:6102:32c2:b0:48f:435c:40df with SMTP id
 ada2fe7eead31-48f52a89afdmr4359823137.19.1719218707485; Mon, 24 Jun 2024
 01:45:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623220606.134718-2-thorsten.blum@toblux.com>
 <CANpmjNMHPt7UvcZBDf-rbxP=Jm4+Ews+oYeT4b2D_nxWoN9a+g@mail.gmail.com> <A820FF35-B5A3-410A-BAF3-0446938CD951@toblux.com>
In-Reply-To: <A820FF35-B5A3-410A-BAF3-0446938CD951@toblux.com>
From: Marco Elver <elver@google.com>
Date: Mon, 24 Jun 2024 10:44:29 +0200
Message-ID: <CANpmjNO+1evgD=Ty8YXT6_ac33vJKE=UaOE8ADzd57_YoZ83ag@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Use min() to fix Coccinelle warning
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: dvyukov@google.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jun 2024 at 10:00, Thorsten Blum <thorsten.blum@toblux.com> wrote:
>
> On 24. Jun 2024, at 00:02, Marco Elver <elver@google.com> wrote:
> > On Mon, 24 Jun 2024 at 00:08, Thorsten Blum <thorsten.blum@toblux.com> wrote:
> >>
> >> Fixes the following Coccinelle/coccicheck warning reported by
> >> minmax.cocci:
> >>
> >>        WARNING opportunity for min()
> >>
> >> Use size_t instead of int for the result of min().
> >>
> >> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> >
> > Reviewed-by: Marco Elver <elver@google.com>
> >
> > Thanks for polishing (but see below). Please compile-test with
> > CONFIG_KCSAN=y if you haven't.
>
> Yes, I compile-tested it with CONFIG_KCSAN=y, but forgot to mention it.
>
> > While we're here polishing things this could be:
> >
> > const size_t read_len = min(count, sizeof(kbuf) - 1);
> >
> > ( +const, remove redundant () )
>
> Should I submit a v2 or are you adding this already?

Sending a v2 is cleaner, and also Cc Paul E. McKenney
<paulmck@kernel.org>, because the KCSAN patches go through the -rcu
kernel tree.

Thanks,
-- Marco


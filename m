Return-Path: <linux-kernel+bounces-175018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CC98C1924
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939A41C20B7A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F81129A71;
	Thu,  9 May 2024 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i7MkVkAM"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660B512839E
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 22:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715292262; cv=none; b=h5+lQkghtA3cUJw9sVJChlj+SYhnAu24ZgK0k9s0jMSvp21fK74xaRTtzew8PGtarpfc/qz4FOSDaqEFzAr4pWURu9ftEVu4BnOl+/ZH1Pyy/B8/1DotQxcC/FkFn69wOaCs4aXimgljV3fdAOzP7APrX2efuQ3KKmjQPPEKHLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715292262; c=relaxed/simple;
	bh=OgJHhmIVrHJ1rqU9C9cLleVIC11QJQgCtRwBNIfc5aY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYmeWL8kK9WVOR2ottUthdyjnIFjLT3ZXEc4hF7Amm6KZtdjmxyxckevPGqF0aDvI4OzlH0jlmlPf4Ko/C2qn+w8E3viMBCg/7uOqfOWyhchDwzQR3xltV4MN+kKwWPEc7pw4US3Yl7WaFcJ7hq7AxmIxMcDo/awBDzprpWnX24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i7MkVkAM; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f0ea2c726aso102299a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 15:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715292260; x=1715897060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaMGWwE54MRwQe9MKn89HK8vqNbPvDPLq1+qzXPGB6k=;
        b=i7MkVkAMBzPh/YgcMzJTj0BpTkhKa1M76CkeCG78rwjiARncOTqDqZeN0BjEQq9IGD
         4Fg4h66nw7oSekJh9EP5cg8rMzW1P+Ast8qIBhgvNAzfvPOgS4vMgHvq+UijhdL6UaFn
         hTsNpJ8+Pc/HQDCo0Dn/5EYm4+WdxPNsfeuxNxs33aIQaHi1CIyDISDI6kcwtWZSj6m4
         MZDzdLZK1m6ZtPupVUwIMDkEv4kk0z4GRJ3ZkKRLYum3EytByCr92AkP4T5ZqGr03HyC
         QkLu4CO9Oi080yDa+qq1YMICGGQZ+Bcf7PlOLkvW3nEIufZh6uZqwEwFeMXlwtPqO91u
         Y1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715292260; x=1715897060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaMGWwE54MRwQe9MKn89HK8vqNbPvDPLq1+qzXPGB6k=;
        b=WbcyhiVxFaGJZ1ToWJgzriV8UKq/FKXeKKfXwkjV8wiBreVHWMhqdp/awhxeSg9DJs
         tFu1j6uZY+cfbeBTYQAec7KJr8/0Q7meMHUR1hQvDJeE6I89fucKZVsv0akduFDrBfeq
         UaYs/QZUCbKTMqXmKYRbAZS14h7xGFqRl7PVon5s9AtDYQxYYCf5jqpZ20t9aN0yDuYJ
         1AZmXNshpDJjNfGcwQnHtPp06fo0jC7j1aMzdIIu9M318UpAfpIjbUarMfv/YkyfeM7d
         pEQd1VI8XAlxIdwPpTOIDYZfTSZUmS2amYNjfR+NE3rSZbXrzgZcSYytafcPjzNdFIrO
         gQmA==
X-Forwarded-Encrypted: i=1; AJvYcCWRuHY9DBIeAFcjU3m5YbPYzJfHj+8GFW+fCdhKSdZw9q8wABZYamnw0FRyddqszL9B2IZZEriraJqCOh0Y7UdBFCX/7CEFv+aAoT/H
X-Gm-Message-State: AOJu0YxTil+hW3u1pjf/ytg1pKhyUxZQG1QVv+0k5zRjwkqmMWeLNEW8
	0XY6HGVxvCqvvTvf0axUAmmpopNdFEbB/XZcUw1mFHTqYWo9Frmx2HI+QvD+ZZ0sSXM6oWHBsGR
	GSlUb+xuOGqdpK5Ozq0WrOPrknT5bQxEtDyen
X-Google-Smtp-Source: AGHT+IGOrX7CymOEEesjDKbsfowT/rCu7eZVPPyV31UhJCy/YotrYfiCNXVJAu6ojtjG96eAKvVU1kdO7vspfPuqgL4=
X-Received: by 2002:a05:6808:1688:b0:3c7:41ba:102f with SMTP id
 5614622812f47-3c997074664mr1087661b6e.34.1715292259867; Thu, 09 May 2024
 15:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-b4-sio-scrollback-delta-v1-1-4164d162a2b8@google.com>
 <f7775510-09d8-41ef-97b2-0457e721a9ec@kernel.org> <CAFhGd8qkYYQZi37Tsj-V5pN5S4xhcyUeAZj1of2kTXG+EtVMgg@mail.gmail.com>
In-Reply-To: <CAFhGd8qkYYQZi37Tsj-V5pN5S4xhcyUeAZj1of2kTXG+EtVMgg@mail.gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 9 May 2024 15:04:07 -0700
Message-ID: <CAFhGd8oZy5aKjp-mVhh2d3U3tzTMzVRAfE039gvBACC0AdDNQw@mail.gmail.com>
Subject: Re: [PATCH] tty: vt: saturate scrollback_delta to avoid overflow
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 3:01=E2=80=AFPM Justin Stitt <justinstitt@google.com=
> wrote:
>
>
> Agreed.
>
> Does an implementation like this look any better?
>
> static inline void scrolldelta(int lines)
> {
>         ...
>         /* saturate scrollback_delta so that it never wraps around */
>         if (lines > 0)
>                 scrollback_delta =3D min(scrollback_delta, INT_MAX -
> lines) + lines;
>         else
>                 scrollback_delta =3D max(scrollback_delta, INT_MIN -
> lines) + lines;
>         schedule_console_callback();
> }

I apologize for this formatting, gmail ate my tabs.

Note to self, do NOT copy/paste from vim to gmail's web client.

> Thanks
> Justin


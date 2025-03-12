Return-Path: <linux-kernel+bounces-558124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE07A5E1F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F723A4709
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BCE1DACB1;
	Wed, 12 Mar 2025 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZlMAriQ"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E318FDAB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741797947; cv=none; b=HTIcnZb9dgN+Vv5RuqOHncHae3U4bv0yKrz7r/JIuAnDuZ7Uf9zxEqy6tQRPQz70xv7XUeSVQIuxJYss9d4VUsfQ7bgIkrBbAj9JeiJzzF5U7dVWuZfW8hU48MFaaExGoMz0a2U5ez3DAN94kZcXSlL1BPCtYIKJP8kiohJSZpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741797947; c=relaxed/simple;
	bh=dzA9dr5yEwuo5a8DniMBszhgs4BUGhkytBReKeWTVeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+tCYFjZS9UNhpKcKpJWEL0PuuFi9XEl590QWxsO6PV8TqfBOkJsjnq+VYgvP8TJfYHwwTzjGCaIM/RbW8BTXSnTtaidU4bgyt2lYepxYbwyt1uqu19kcxahXxJ0vh7dgzh8APmGQZH4b2dMp7I8Prdnhliw7BvTdVLkUVjm4sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZlMAriQ; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6f6c90b51c3so68941867b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741797945; x=1742402745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzA9dr5yEwuo5a8DniMBszhgs4BUGhkytBReKeWTVeM=;
        b=MZlMAriQCkMwTHjZUfiLNAvtG//lZj5UX4ICsqjBzhzR0gt9Nwopr2aNOWHtz+77BN
         GfpM2ds5NTG2pmvU692d5PFDAq175CIBylY5uNVFzuIHStpdeAuT2zUYkPNiu8cEw1+w
         D5E1ELX3gbXzTL+8TaVdOmjuggPT5skldjXj9M/u28J+5F9GDwndz7TfZ0duODLJQF/p
         CrsaAc8qICoNgm6UNZQMCe0UPxabJYZ9k8tjnFtewew0uN8qzEfySx4CKRKq8qwxt8pH
         c1O2jHfyOnn/muLnJUPWP99qT+nNCFi6pLSV5lpuqU9CFZDqJusoXpiaPi5nUETvpT8+
         gYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741797945; x=1742402745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzA9dr5yEwuo5a8DniMBszhgs4BUGhkytBReKeWTVeM=;
        b=FQOSLOUN6PnriF6wp2i1F/ddC4TnMho5TNm0rACaCNKvQeCYCW0mf/gTXLEKxlRwMl
         35AqCKWIBBvWfBXJWYG0HeKYw8jZYZrmJF2dUGdU9s9X3o5yDIrGJfbjcbEZGJkDwA08
         WT0R9tLZbKlxxC64pZP8pFDTHed/GbNtqvmmaWOoeXqHb87kenIHxQLBFPhhqtSypUZQ
         Gwta72qEf4dcERopFXI0p1ssttBUAp2QFSfR3uwHuf+J8BfQhJ4+X9CGOVFCDtDArrch
         o+0CsaUN656ywqiOTO+Vc8wKFIFU0717bLyTzv+9YUxrkBHqZszm/tKw5MSya7CBFbDq
         lvGA==
X-Forwarded-Encrypted: i=1; AJvYcCURm6yOXdZeaTY1dYLcZOrf5lriMJdXxYs33W+qv9G6/D2QdNVycoYghVTs51epdyDYo+Xh43OuhMkA2u0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9EjE9l26qGlG5HH1Es3t+DE5a40WZL96ouV8fNjkmYcl9vzdV
	VcL0lIQ4EdkHtb6vSNGCotRz/vz4Umlb18QcMVxP3IxRq96/WPFIyPH8GhzNpKNggQI7zKfDT+p
	Iep+C+dkUHF6nGshidhGZea+mZtI=
X-Gm-Gg: ASbGnctd3U1+ket5jrA/r/uTkMPmmK56alcoUFZmpd150OohaeVFmSD1R4b9i+bhAou
	Okm9abjUSQRYXFMQBYEqfIdnaQVKblETGVsZHvmPIQ+23gbgScHUzsjro8IFa3N7w1uUE3ElMCw
	LOZT9dtmM4qURyqSSc+b9nbihE
X-Google-Smtp-Source: AGHT+IH5mtoX8GrbV7fJMMonD8s/PPOO+ay55fcdYuVwh5tT1GNL4A4jWfy8icrykHmA2rww4WmHYBOgEQ+29OKkCx4=
X-Received: by 2002:a05:690c:6d07:b0:6f9:8845:cfbf with SMTP id
 00721157ae682-6febf31b73fmr315616827b3.22.1741797945025; Wed, 12 Mar 2025
 09:45:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210235009.2405808-1-ukaszb@chromium.org> <a96af07c-b8ee-4a9e-91c8-d5d6cd1d9cb0@bootlin.com>
In-Reply-To: <a96af07c-b8ee-4a9e-91c8-d5d6cd1d9cb0@bootlin.com>
From: jim.cromie@gmail.com
Date: Wed, 12 Mar 2025 10:45:18 -0600
X-Gm-Features: AQ5f1JqZIdkNYRPux_zsr27D7ghjlBTUUUsO9JfakHtaylJGFk-CtLpmqoPQRlQ
Message-ID: <CAJfuBxwdLXwvPRdZhxs8VsrHPA2QDPATBDs5VibY6znnxg6Gmg@mail.gmail.com>
Subject: Re: [PATCH v4 00/39] dyndbg: add support for writing debug logs to trace
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>, 
	Jason Baron <jbaron@akamai.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	Douglas Anderson <dianders@chromium.org>, Guenter Roeck <groeck@google.com>, 
	Yaniv Tzoreff <yanivt@google.com>, Benson Leung <bleung@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	Pekka Paalanen <ppaalanen@gmail.com>, Sean Paul <seanpaul@chromium.org>, 
	Daniel Vetter <daniel@ffwll.ch>, Simon Ser <contact@emersion.fr>, 
	John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>, 
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, linux-kernel@vger.kernel.org, 
	upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi again Louis

On Wed, Mar 5, 2025 at 9:49=E2=80=AFAM Louis Chauvet <louis.chauvet@bootlin=
.com> wrote:
>
> Hi everyone,
>
> I am looking for an update on the status of this series. Initially, I
> intended to implement DRM logging in the trace system as suggested by
> Sean in [1].
>
> However, I came across this series which seems to offer a more
> comprehensive solution by enabling DRM logging system-wide. I have
> tested it, and it appears to work as expected after rebasing on top of
> drm-misc-next.

after productive and enthusiastic work with Lukasz
I chickened out and "stalled" it.

I decided that if I didnt fix classmaps 1st,
someone would call me on that, or otherwise blow it off.
So huge thanks for testing that patchset (and this one too)

Im newly confident that we can get this in the bull-pen,
(and classmaps on-deck), and up for a full review.

> Would it be appropriate for me to send a new version of this series with
> a minor fix for the rebase?
>
> Additionally, I haven't seen any reviews for this series yet. Have I
> missed something?
>
> Thanks,
> Louis Chauvet
>
> [1]:https://patchwork.kernel.org/project/dri-devel/cover/20200608210505.4=
8519-1-sean@poorly.run/
>
> --
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>


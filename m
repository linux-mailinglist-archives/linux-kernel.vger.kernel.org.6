Return-Path: <linux-kernel+bounces-256807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B1193709A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 00:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34FE282507
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 22:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8665146588;
	Thu, 18 Jul 2024 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hc9Q9u1W"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB1D8286A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 22:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721341637; cv=none; b=o42Fv4d4jZnMwekb3TQbUUbPNcvuShFSMKjJlaRTgiAo04iwMMKgUuAl3LfLGt4ZMFyDnNqhompLsvtvi999j3mMiuW1hYFHDAwNVfOYqbg9PT1dhjhIKLHcBbmbhabI9E1EnN8qo/c1Accb5X/O4DaXr84rTNn/854osEPaxyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721341637; c=relaxed/simple;
	bh=zDgU2SeIdYUFXxQD+LyyJxHubKApfobdHZJlnZImCX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdZdZwtGXoxqc7/y0Xcuu3Z15ggD/VubcYpxV7TYBYGzdYTqhd3hHz+0Q/eAfokiDPY+CVXDk2NL3T+9ZwB+nLJuRqlQ+nDKlOeY/bmM6wD7bvgrI1Js/pcBqthY1ECbA18pqAcajvPmgsR3MIFcQZ48rVeN+n07EGf0IvGYKTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Hc9Q9u1W; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58e76294858so582788a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721341633; x=1721946433; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RHdzQrdk/WoOtHbpZ/K+IpYkj14320RN1AlLLGKZG80=;
        b=Hc9Q9u1WoPQ1bSigW6TkgUsx1Zi0xCJ1qZa0kodWcKk0CRVNCuO/+aUZ/h8MRoZNa3
         8cd9x4YdaKpUzL0Vi2WH13ZeRrY4v4SkxqqUZfDnYFk6YX0Wz1EUh0LU4jvNsqKMUtIQ
         BFA83eqCJI0X4WUYUk7sIqqb4Fs3GdL4/Dq8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721341633; x=1721946433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHdzQrdk/WoOtHbpZ/K+IpYkj14320RN1AlLLGKZG80=;
        b=c2XmAt8jOHwb60tksihnz0BwwmQ+m1K7jBWwA1kNZj6ES2jg8w+go9VRam3mXUFaEu
         FUQOmGvpF+AAFt/BWM7oW5STEvlpAugpkucXynBMIuDaRUSfXZSjRcMy3MIDn5JZKcQo
         LFNZQHAhSAUueuOi5ssKeYeBmrQ6mIthlp+MCzcd2WnA33vga/WV7UM5l7dAGiA7LNX9
         peOU3rrDqJEM4BDcFyhcOt4ovIEmzCbfOSY1wM0FiwdDJ/x7ZvOsL6lQwuri7Q+slBgy
         94aKxWqYCkLmEbqLNIw4djd2xE9pmHBT+A3cSMXZZhxAkAeFs1EKZDx71S4BJRtCnoPm
         nRcA==
X-Forwarded-Encrypted: i=1; AJvYcCUC07wOaz/PqZbcARI5OMbT0wRzvhrYFw9DXJCq2Z6o6Z7qRoANt1ogElbw+pfV+fYXgjE0v9wl5p8fSncoLSBzrZRiUnkYOqzVSIKr
X-Gm-Message-State: AOJu0Yw5TiIaqICenGN3WHw4Nm1tPj0r/c3wVPtI5AaUW3ixV/ELVVIu
	bDORA1eH7U2YW0JxABeAf3KMNCyW8oKfc1MD8W6QYyFKODEuZRusuuuCdC+H32jz7jH1Zuw5Sa8
	glrZm6A==
X-Google-Smtp-Source: AGHT+IFSiAaFZPA92BxwArP31GEm9bZPYsdTl1C+rv5Wu357HBP4YQ8k0EkD1t0Z1d0kv9JwNQvt0g==
X-Received: by 2002:a50:f683:0:b0:58c:77b4:404b with SMTP id 4fb4d7f45d1cf-5a2d21219e2mr454162a12.15.1721341633351;
        Thu, 18 Jul 2024 15:27:13 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c2f8a5fsm22672a12.62.2024.07.18.15.27.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 15:27:13 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so564237a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:27:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXnhlWfdiHJt6Qs1Ol0g+uSZbuR5Tla4e/V4SrWl7OiFysswGtk6EvgsAALgttaPFV8RAsc5mas35yRw9WoDoJAKAyOO5+LduzINpyg
X-Received: by 2002:a05:6402:358f:b0:57d:4692:ba54 with SMTP id
 4fb4d7f45d1cf-5a2d168127emr524937a12.6.1721341632616; Thu, 18 Jul 2024
 15:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <r75jqqdjp24gikil2l26wwtxdxvqxpgfaixb2rqmuyzxnbhseq@6k34emck64hv>
 <CAHk-=wigjHuE2OPyuT6GK66BcQSAukSp0sm8vYvVJeB7+V+ecQ@mail.gmail.com>
 <5ypgzehnp2b3z2e5qfu2ezdtyk4dc4gnlvme54hm77aypl3flj@xlpjs7dbmkwu>
 <CAHk-=wgzMxdCRi9Fqhq2Si+HzyKgWEvMupq=Q-QRQ1xgD_7n=Q@mail.gmail.com> <4l32ehljkxjavy3d2lwegx3adec25apko3v355tnlnxhrs43r4@efhplbikcoqs>
In-Reply-To: <4l32ehljkxjavy3d2lwegx3adec25apko3v355tnlnxhrs43r4@efhplbikcoqs>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Jul 2024 15:26:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmXpbFKmmk53c8Um7naf-AAwOGU-26RTHiafbGbostCA@mail.gmail.com>
Message-ID: <CAHk-=wgmXpbFKmmk53c8Um7naf-AAwOGU-26RTHiafbGbostCA@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.11
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Waiman Long <longman@redhat.com>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 15:24, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Sorry, I must not have been clear. My master branch is a) not where I do
> development, and b) not not a branch that I will be sending to you -
> that's simply the primary branch I publish for people testing the latest
> bcachefs code.
>
> So: master will now be just updated by a hook on the server whenever I
> update for-next.

Oh, ok, then that's fine.

> > Now, if you want to do _additional_ testing along the lines of "what
> > happens with my branch and Linus' latest" then that is ok - but that
> > should be something you see as completely separate from testing your
> > own work.
>
> Yes, that's exactly what I was describing.

Good, sounds like we're on the same page.

            Linus


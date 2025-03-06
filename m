Return-Path: <linux-kernel+bounces-549557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13657A553DD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010543B3A36
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E265925DB02;
	Thu,  6 Mar 2025 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CV/KJ3ZL"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4833227604B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283968; cv=none; b=LMzByzEtWvKh21M/OsnsWZfCQ/+o7jl1raXe0MecaC0HQPFSzplTdbXURGFPRP4uKTh0LDXL+8n2Gr6br9yVPiY9iRg3ehbY5X5isJddxu0pRq6weKCYSrYfJEX2adDDzrBCkcRuGlbPHf0dhDPwMtm2Fnqe7rMk6mgiM2iBcnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283968; c=relaxed/simple;
	bh=NWT0F/KJlYO1vT3bElv/lrz4CjmK9qNstQ1RSsLhO5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mn3w4QoXcdLiQI+HNtAq6n429KtqhfG8daX8/9JhHcAlWmwRe1GXRbaSczDhz1tEjq3RJ3wAZPSaaPtOhJec63FGZiL+195IEVHIYrVJWJhXOhhw5n9y1jMV17Kw4/nEzO2llIUb3gQb1xqNgHaKDNblNOOBmaX8yNxNGmFAZzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CV/KJ3ZL; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5dce099f4so722119a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 09:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741283964; x=1741888764; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bSYRkarb+7IJw2j2ISIxVnW8mglX4UBJdNIvXLsVq6k=;
        b=CV/KJ3ZLAfaz3rzANXYuAMaSLYhoq6xXs4A0giCfBbFvXphdAu0wmHMmN7VbF5LIWI
         CN9QTk0a/6rPB6mAoFn0f29vXNCczL15DE1sbMzHLgxKB++tx3buFLVCE5/GnXm/8L0m
         +EoFRIW6jSfyM4SITtFVB8lGiseZAnLpW+6Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741283964; x=1741888764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSYRkarb+7IJw2j2ISIxVnW8mglX4UBJdNIvXLsVq6k=;
        b=lxIY1yhK5F4xmQKDnJJDpO/9sZm2JptiTYvbIfsHnm4J7Mhu4M0UqIIM3WlFE3L88Q
         KSIAlQdB4zmJSYomLyLFV88/JNueyd4tsWWnWjXayImpPfGJc9R4xnizEb+YLKKTU8aC
         mygo5P5iD6N/oJnmvuBLSupJzTwRBvU7XSFXsVgrU5bg1uKX0A2CY1JXW3SsFoWBxqyY
         b3rpTFGZ43HwloIKKCgtjde/E3i0q4OwMAhpQhVtxJe3/S51isQb5YHS/mLGnX8zuINz
         GTQOB5nA1e0kJj1B0gJNuPB0ZD98xch3cXFduOyK08QF48iqtyN5twlnv5RiccywYdZu
         U35g==
X-Forwarded-Encrypted: i=1; AJvYcCXs/V4JCohKI1kePyWsq8FiDQomaZCLOEAH+QhbwTdLFCsCApph/7anhCY1xCUrHh3vqLYVPD97XoE8qy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYrRyhtbioqvLQM8bsDEIH5s9dfyVVs4+43J+jCoX6E2lJsvDE
	i/Gmg5nfVrr3+EcIhdFQ/m0r0C2FGsJFKMzunnJdkoTToeprBIfG3jgR1LUK1GUFl4482BpzzQi
	fYz8=
X-Gm-Gg: ASbGncvY8mb8VMQTZTRtuwFvBturLPbSXrq976TRsbV5WDYAt+zDFuEsbKPkz2VvPb4
	+LpywCIbHRDGXqUxhHu877m3Uwy4JteQVfhJnpwO5XICfeeyxZ0Bp4IIpxcSqEh+tSVRSmJmdXM
	XA0M9Ul3nnclXPUYsgEL0RrHN1C6Bb7xynDOmEGr9RJG1Bxo6HAcF7O+TtNSAvrtuqP10ATIqcD
	qk/mRZq0PlhXt7Gh5slJ7N6zG4nMP3a7Q3lPHPtLd3Svg4Z1xZ38lPUg+pmFrNjGIrRNhjXUsdi
	877Pdy6DnXgT/e3tHGmrvveDOkq1FRC7YYL0R/bOiytkpf1I/9PpR8HmHo8E8p9soS0wgepgdCW
	JAmye2C0p2lRWbPhT+sE=
X-Google-Smtp-Source: AGHT+IEa0x5kMVGbFFMwpcqv6/G/+d3x7yq+1dNzH9vrmnoplmXpJ09WxkoOAsOhogKo5PaOtKQ4Jg==
X-Received: by 2002:a05:6402:358b:b0:5e4:cfb0:f66b with SMTP id 4fb4d7f45d1cf-5e5e22c0b42mr111329a12.7.1741283964261;
        Thu, 06 Mar 2025 09:59:24 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c747218fsm1258472a12.25.2025.03.06.09.59.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 09:59:23 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5dce099f4so722025a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 09:59:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrJySlTUdISekEOztpwfIhqZYRUMkXTIpy/Igq+yMscME7DLE+Cp78dt45GHMnOGdOxIMmbDDxJHy15DA=@vger.kernel.org
X-Received: by 2002:a17:907:3d86:b0:ac1:e6b9:57ce with SMTP id
 a640c23a62f3a-ac20d852d1dmr848759766b.7.1741283960242; Thu, 06 Mar 2025
 09:59:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228143049.GA17761@redhat.com> <20250228163347.GB17761@redhat.com>
 <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com> <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com> <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
 <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
 <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
 <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
 <20250303202735.GD9870@redhat.com> <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
 <CAHk-=wjyHsGLx=rxg6PKYBNkPYAejgo7=CbyL3=HGLZLsAaJFQ@mail.gmail.com> <87cyeu5zgk.fsf@prevas.dk>
In-Reply-To: <87cyeu5zgk.fsf@prevas.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Mar 2025 07:59:03 -1000
X-Gmail-Original-Message-ID: <CAHk-=wg8e77mmVWZrSjhDe3+3MfF_h1op7VjTJv570zrE2s9Jw@mail.gmail.com>
X-Gm-Features: AQ5f1Jq3Yhgvw2xjomqRUNpCHfEfMY6rND9DoGhv3ZSJetivAGgMEt8CTPE_-Kw
Message-ID: <CAHk-=wg8e77mmVWZrSjhDe3+3MfF_h1op7VjTJv570zrE2s9Jw@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Oleg Nesterov <oleg@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, "Sapkal, Swapnil" <swapnil.sapkal@amd.com>, 
	Manfred Spraul <manfred@colorfullife.com>, Christian Brauner <brauner@kernel.org>, 
	David Howells <dhowells@redhat.com>, WangYuli <wangyuli@uniontech.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 22:35, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> On Wed, Mar 05 2025, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > and there might be other cases where the pipe_index_t size might matter.
>
> Yeah, for example
>
>       unsigned int count, head, tail, mask;
>
>       case FIONREAD:

Thanks. I've hopefully fixed this (and the FUSE issue you also
reported), and those should work correctly no on 32-bit. Knock wood.

Mind taking a look and double-checking the fixes?

                Linus


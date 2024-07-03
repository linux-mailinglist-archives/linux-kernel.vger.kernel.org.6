Return-Path: <linux-kernel+bounces-239919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F909266D6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBF41F21954
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C046185096;
	Wed,  3 Jul 2024 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NbBCcupb"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A444D18412F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026576; cv=none; b=FKGKeAZYi1XKeUvX+50CFHgNR4jFF7lVmno9f2ncsE7JN40mGrJLKqpIeJ90meqnzRaqpr/hgTmSZbpxvsGHYTIANTof8UN/1UoIHSxqqE5OfXchl1Rgem9t9JkWjwnYXD6fBmSrzw6i/PclRgCUiTgu62nx4a8QpZbzAQR6FMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026576; c=relaxed/simple;
	bh=uRU/MzlOzw7CmWbyItl0EyiCdZwjkjyxkrbpjs0FjXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEVAQUDnFgbIlz8QWcChgKExDY8qnWnSfjh39fnhaKlps6tvrA2lsttWzUPjnVpCImxtvKCnVLGYlUn9AVe10ZVgpg6QQNOre2ERzSSvtha2B77Ow1GgIywpi+8GVgKgGIJGPGHVDBqyNm1282QWYub1b47YYdb0MZfX2Gc1OO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NbBCcupb; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58b0beaf703so3464458a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 10:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720026573; x=1720631373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kRpbCtw/E4IRbKxwJt2blPeYec2wEFVPadTklw6HsWc=;
        b=NbBCcupblJu4PVrUIvbbrMLbkzfHUFV1a1ICLrJQwWkFgPp3gTk5dYD+x7ICrix5NY
         kuvfH8lDBhfW7akW8dhbntdgiDzS13yG/D7n88brLwWhmWVT/Ql9uBPy9kZLRsskvYIL
         t+A0rPsRghA70DjGHxlqlNiSxomWhEkhkrylw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720026573; x=1720631373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRpbCtw/E4IRbKxwJt2blPeYec2wEFVPadTklw6HsWc=;
        b=O+0uq0jTPhvtpb2iLAL5D6ZCJNZyGJVlaZBINNtEZT12dT6B2gJwQq89Fvix1cxtuw
         72USFWDusXiO7jim3nG/fcqTvWVJxRLbmmZmsibL0m8SeM5/c7dOwKfUmogcrry9kPUw
         JvSh3ql5ri9f0jc4nJKb7NRqjf0DSpOaksC80bbqThK2DV4S5GF843VgWCoUVV/V+H+s
         JX+ONe4RawViL+kSqvage7PIt6j+AEeilHzKtkllvfwTc3R3WYRWtzv2N39CLvrDBPZc
         arFMjZ6wnvZTK9nXaL7D4Zhcz/7Py6yTXXNh5EHikoULmM6+6upG8mQQSbyWobiEHA4D
         yElw==
X-Forwarded-Encrypted: i=1; AJvYcCVOdPEfbgjnf6XXZ2HKlweFw8pfogE7lpdsa6Bl2axWZBWkPGF/0oz1uD8sSKp40qgRI0zc/RrHK113/y0mvO4uN/QaHoqzyjNr5Ehj
X-Gm-Message-State: AOJu0YwK4yFdcbcIerUWt5ImrSQxC3L40L4VzbG2UPHKRzKwrLgFfMFa
	teZoj6AZLggn9vDCs+jJtAvbAuzpIzySSHSoP93KpPj6lSWGuXNIE302x6T1jkbvBeBCdGKHtVz
	uU9mkrQ==
X-Google-Smtp-Source: AGHT+IHHjNvvP/nuU+wNcA5I5Gsrc1YyVM60NRbDDnvHB5cDIyXG+nymgmyS/EGFlQuLlN9zG/Uslg==
X-Received: by 2002:a05:6402:274c:b0:58c:6edf:d5d1 with SMTP id 4fb4d7f45d1cf-58c6eef1aadmr2325967a12.5.1720026572688;
        Wed, 03 Jul 2024 10:09:32 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58612c835cfsm7233440a12.14.2024.07.03.10.09.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 10:09:32 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6fd513f18bso747935766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 10:09:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuXddCSvVTZ8824PozhkV5AfT63iCYbh/PsGuHboPQ/5+mKF9MYAolg9acBxWdtGDLtS7dzxk7Af8iHlplOeTxJbUurRUdJomxrJZN
X-Received: by 2002:a17:906:f756:b0:a72:42b8:257c with SMTP id
 a640c23a62f3a-a751444c4b3mr853732366b.35.1720026571539; Wed, 03 Jul 2024
 10:09:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625110029.606032-1-mjguzik@gmail.com> <20240625110029.606032-3-mjguzik@gmail.com>
 <CAAhV-H47NiQ2c+7NynVxduJK-yGkgoEnXuXGQvGFG59XOBAqeg@mail.gmail.com>
 <e8db013bf06d2170dc48a8252c7049c6d1ee277a.camel@xry111.site>
 <CAAhV-H7iKyQBvV+J9T1ekxh9OF8h=F9zp_QMyuhFBrFXGHHmTg@mail.gmail.com>
 <30907b42d5eee6d71f40b9fc3d32ae31406fe899.camel@xry111.site>
 <1b5d0840-766b-4c3b-8579-3c2c892c4d74@app.fastmail.com> <CAAhV-H4Z_BCWRJoCOh4Cei3eFCn_wvFWxA7AzWfNxYtNqUwBPA@mail.gmail.com>
 <8f2d356d-9cd6-4b06-8e20-941e187cab43@app.fastmail.com> <20240703-bergwacht-sitzung-ef4f2e63cd70@brauner>
 <CAHk-=wi0ejJ=PCZfCmMKvsFmzvVzAYYt1K9vtwke4=arfHiAdg@mail.gmail.com> <8b6d59ffc9baa57fee0f9fa97e72121fd88cf0e4.camel@xry111.site>
In-Reply-To: <8b6d59ffc9baa57fee0f9fa97e72121fd88cf0e4.camel@xry111.site>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jul 2024 10:09:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wif5KJEdvZZfTVX=WjOOK7OqoPwYng6n-uu=VeYUpZysQ@mail.gmail.com>
Message-ID: <CAHk-=wif5KJEdvZZfTVX=WjOOK7OqoPwYng6n-uu=VeYUpZysQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] vfs: support statx(..., NULL, AT_EMPTY_PATH, ...)
To: Xi Ruoyao <xry111@xry111.site>
Cc: Christian Brauner <brauner@kernel.org>, libc-alpha@sourceware.org, 
	"Andreas K. Huettel" <dilfridge@gentoo.org>, Arnd Bergmann <arnd@arndb.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 09:54, Xi Ruoyao <xry111@xry111.site> wrote:
>
> > Honestly, 'statx' is disgusting. I don't understand why anybody pushes
> > that thing that nobody actually uses or cares about.
>
> Hmm why it was added in the first place then?  Why not just NAK it?

There are valid uses of statx - they are just VERY very few and far between.

For example, if you want the "change cookie" or any number of other
special things that aren't standard, you have to use statx.

But _normal_ programs will never do that. It's unportable, and it
really is a specialty interface.

Pushing 'statx' as a replacement for 'stat' is just crazy. It's a
different thing. It's not a "better" thing. It's an extension, yes,
but "extension" doesn't mean "better".

That's true when it was mis-designed in certain ways that we now have
to fix up, but PARTICULARLY true when it's nonstandard and no other OS
has it.

> And should we add stat_time64, fstat_time64, and fstatat_time64 to stop
> using statx on 32-bit platforms too as it's disgusting?

We already have 'stat64' for 32-bit platforms. We have had it for over
25 years - it predates not only the kernel git tree, it predates the
BK tree too.

I think stat64 was introduced in 2.3.34. That is literally last century.

Anybody who tries to make this about 2037 is being actively dishonest.

Why are people even discussing this pointless thing?

            Linus


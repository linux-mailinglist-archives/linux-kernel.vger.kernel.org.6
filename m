Return-Path: <linux-kernel+bounces-177966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AAB8C46E5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39711C222E2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F3D20B34;
	Mon, 13 May 2024 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IRZbdAg5"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EA137153
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715625263; cv=none; b=Kxr+1V9cH4V51GPbvENJ41xQ8YHSVqzCvBYPzIv5rjNDGvYcxQ1ZlAe/HZn9JYlrBZ9tJSkC0FNOBqme4CECcP8fOx8bDu0YTSjrCh4T+zrvrtpqlb/ZSZ0v5PeyHD3tN3PYjrPCzZF+nmrIWQ2J17GW5RjTCOY9gXzBpT6easw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715625263; c=relaxed/simple;
	bh=LMpgS9YUb5fP274F97/qNj06fpYzBLVeI1R6c6nW9QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvGD9wkjUKcgHnP/vcftfw236pskHaUeGZBAHWHlLuPad4mo2rYYugHEKZYjegASQukGKj0wd3euNRJqVaeLKWOcuIU/RUF6M784N2PtNIyL5Bk/6NYJRj3mDFYcqrNmHyvtmXJGakRxbGCYhqWThRpQW8QH0RaPIAO2nouSLuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IRZbdAg5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ee954e0aa6so35780945ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 11:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715625261; x=1716230061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h++n7Qlyg3sgT4EiaSRCnOzzYyK0B8BDWAHRP3/F3N0=;
        b=IRZbdAg5Fjfq1LlzW2OU3qJQiaF0Y36cLpUw+oWEwGb1ZbDoU98E6N8oHl/2rzWCHk
         0J1HOQmi4/qvXT4+9oLUQs4sUJ2KF7lmn65JzzrEUIB/BXbV/B7gvwACHU3Oyso/lcv/
         FGQOa0cTZ0i3NV+ABmzUpys6SdplIP6k+ErvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715625261; x=1716230061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h++n7Qlyg3sgT4EiaSRCnOzzYyK0B8BDWAHRP3/F3N0=;
        b=LGr/dWTs+NEqqZiHxi7fCyd9l653PU0zn2R95vAaLGgrXyhY2dTXrfvO4CMrNnqPuY
         Ktgqpo4RQpWNXxZeg3ETEOz/j8zdP9pgQdrYWgjELFVWZPgbSODzdnSxo+zhmgO/1B8O
         jAL9NPABQ5TjZF1pUD16es4nNVEdtIQqvnR2oB2oGYeL25kOSygho5Q6fRP2/Bq5J0TY
         LdZ4EPmijCkdKWXShPDIxJYKO8b99WdgIbyC5B3mffvqFK/IeID4F0O8BB9y4bNXJcnS
         zaXqko1gDhJWXXRpxkqGQJ+IzfqidmDSUPJWQe7Jdho6egdKcdB58EOZDCT141kAdeIm
         Q1Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUehz3E4ZOewgC4c4PCSbepNUQDTyq4VRKg8cUY3atdyBKRy8ocWQoz3Hx9suRinLizhoKcydg2wGEhIq6+9yKGDH8wtRBYHV0HEKHs
X-Gm-Message-State: AOJu0YyAi6oFY9dofptpRr/T4BMLFQKdA4sclp3kSphFNbNqeYSaUVG7
	tbxwttBtKq/pvWsEsR6tMr2HKuH45ZdDj5t2ejq4z7kCJFgWsm7BMe52ZoAN1g==
X-Google-Smtp-Source: AGHT+IHCc1iDoDY8y7cN3McKpzD8GoP+zaGEka3xojOMmbdy8UwKg3X31LKvQDdXyzyN7fH2gRjLEA==
X-Received: by 2002:a17:902:dac6:b0:1e0:b62a:c0a2 with SMTP id d9443c01a7336-1ef441613edmr122093915ad.51.1715625261157;
        Mon, 13 May 2024 11:34:21 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c13908bsm82642315ad.265.2024.05.13.11.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 11:34:20 -0700 (PDT)
Date: Mon, 13 May 2024 11:34:20 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Uecker <uecker@tugraz.at>, Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
Message-ID: <202405131047.A3861EC13@keescook>
References: <202404291502.612E0A10@keescook>
 <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook>
 <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook>
 <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <59f731ab619673afec4956fce6832a1cd5324fb8.camel@tugraz.at>
 <CAHk-=wjERv03yFU7-RUuqX1y89DYHcpdsuu++ako2nR41-EjYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjERv03yFU7-RUuqX1y89DYHcpdsuu++ako2nR41-EjYg@mail.gmail.com>

On Sun, May 12, 2024 at 09:09:08AM -0700, Linus Torvalds wrote:
>         unsigned char *p;
>         u32 val;
> 
>         p[0] = val;
>         p[1] = val >> 8;
>         p[2] = val >> 16;
>         p[3] = val >> 24;
> 
> kind of code is both traditional and correct, but obviously drops bits
> very much intentionally on each of those assignments.

The good news here is that the integer implicit truncation sanitizers
are already split between "signed" and "unsigned". So the 2 cases of
exploitable flaws mentioned earlier:

	u8 num_elems;
	...
	num_elems++;		/* int promotion stored back to u8 */

and

	int size;
	u16 read_size;
	...
	read_size = size;	/* large int stored to u16 */

are both confusions across signed/unsigned types, which the signed
sanitizer would catch. The signed sanitizer would entirely ignore
the quoted example at the top: everything is unsigned and no int
promotion is happening.

So, I think we can start with just the "signed integer implicit
truncation" sanitizer. The compiler will still need to deal with the
issues I outlined in [1], where I think we need some consideration
specifically on how to handle things like this (that have a
smaller-than-int size and trip the sanitizer due to int promotion):

u8 checksum(const u8 *buf)
{
	u8 sum = 0;

	for (int i = 0; i < 4; i++)
		sum += buf[i];		/* int promotion */
	return sum;
}

We want "sum" to wrap. We could avoid the "implicit" truncation by
explicitly truncating with something eye-bleedingly horrible like:

		sum = (u8)(sum + buf[i]);

Adding a wrapper for the calculation could work but repeats "sum", and
needs to be explicitly typed, making it just as unfriendly:

		sum = truncate(u8, sum + buf[i]);

Part of the work I'd done in preparation for all this was making the
verbosely named wrapping_assign_add() helper which handles all the
types by examining the arguments and avoids repeating the destination
argument. So this would become:

		wrapping_assign_add(sum, buf[i]);

Still not as clean as "+=", but at least more readable than the
alternatives and leaves no question about wrapping intent.

-Kees

[1] https://lore.kernel.org/lkml/202405081949.0565810E46@keescook/

-- 
Kees Cook


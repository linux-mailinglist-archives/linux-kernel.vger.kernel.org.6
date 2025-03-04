Return-Path: <linux-kernel+bounces-545494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 398BAA4EDCE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1944E7A5188
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65EF259C8A;
	Tue,  4 Mar 2025 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S3qwXdlU"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D211201110
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117791; cv=none; b=AcCRSmTcWaHMIKdGZFQl6GfhaT6p8q96SQEgG4rt9ihjkjkGLQkoK+J95JP6HYrg7Ivm5T3EpW/dJytVjl6CtJE/8PAj2VRs3bD+UIpA+Lw0Q9iFEitbFdj7hhe5mGht69yMV8BgB/dA/MZ28PNNQexr2ylliXMIbljhMiE6K98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117791; c=relaxed/simple;
	bh=E/lviPldO8UrFKTRm5MbYphpUidw0Pz3EPd+7yG78tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2tC6xxPK0XH27eMAX/9MGKgQJ2XGdH31eiW+mQZwb+pvdchZHF8DYpCvuCe9n9C1li6dv2G/nQHBwRb/+kM+4zao1VtcegzoDbqm9bELZkmfuG5HHfr12JFDi46MITXtkLpBmZYp7gIBWWg+obY/WOtigxZ4Ecl4abXES8RcrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S3qwXdlU; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab744d5e567so23760066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 11:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741117787; x=1741722587; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UfKi6jfA60js1G3b25D6zcCk7LBDMWoylnUtR/UrCsY=;
        b=S3qwXdlUFMOqSyw0oxK6rlku0jS6jkraFs7IvRneb555Pgs5N5ec+e9lRWkrwNLebc
         uuvnAzMyY0ZsaZfRXoJZL4OdYDq2lpCq1fib7hGYp4XA2Y14H+fxeJu7ZDG+mUClA+nv
         hVLHnrVIWY/rvG8yk5rYt7a8FAVuKIpAkMWDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741117787; x=1741722587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfKi6jfA60js1G3b25D6zcCk7LBDMWoylnUtR/UrCsY=;
        b=MAe9qQr0lz8tX3PKzXMHzEoBS9kRvDIcfl9WkWUOlKiy+5auL+R9TCEcaeHnzYHjcH
         tQkXU3oTkAQNHQ2B3UsExysvP6tWRXj09aIy7oQW9n/4Tb1aXfIS+YBVG0csOEyw4M3f
         QpH3SLJH0izNG1uCDvOVT9DE5bnrmSDxN12RfoIqoRVuYe4nDB5ly8HmG5yldIKk/meY
         SsDuDnmNYNoSRzouhgKFKiLI8sKGpTLAMCMRuyLwoM39qQFz42TT8l1ESHFdt09ANB/v
         YgnW9ww3lyDmvgy7ZLR0I7jNQk5wlpQe7LjAXBPpcV0+3rwxJ82NgW2qHaybCJNuNEB8
         M0rA==
X-Forwarded-Encrypted: i=1; AJvYcCU+jOzHb7d/cBvCuOaYGvb0WgspRgFrZeV3l7QfytYx4lPnZrz3Bc4LRTA8CrjRfJdttaDFkq3h4FF2++c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJT5qO3mkgzsRKmaFBM8ROhEPqbwluqQ2KwlrqtWjEnDkdr7ZO
	LaoMnE9QObQ0lLHDMVfBQnGeTVnzyEsW/QirOrDa1LukeQ724lkBsIoeJlUhY3+pOtez8aBq0T+
	H5XAZug==
X-Gm-Gg: ASbGncvQrfKsi5XohuYgsRbZYnZP1CJxdkWK0SINCq4WnDWB5lerHRt+ovRCRziidt6
	QR0jEklfXqfoP9tlTkSLfwb9bnPK3v5VDqcV6EjSzKEE8kfSdmKXaWh7SZj+/WtgRY3cDPyc9SY
	3UHCWvdEXFwZXtfeTr0rRy6M3MZPWRcBVombxWNoLbK0YGNR7HxoupK6hUYwNOl4Hln0hY0O58u
	clxR0p3idc2lT5PllbrHUewKRZUg5t+P4E7g4jqZY3Ma+qB6MCL0QmgyeV4DyCXbYKVerkDtL6h
	Abw/63dvvxSFf06pfWAJU6SNvcOXCEHaIwsqDJiX1UcnArDmC4ya/etjL0hi5buv3xP/wnUJdey
	1h57s7i0hatnzjGD7NYo=
X-Google-Smtp-Source: AGHT+IEs0/4y+TBsqID65I4ofliiqkKA/ohDJrsMsKfwv8xwXcUJ2gZtcJ5GLX2QfJrEM3GgAkQ0Kg==
X-Received: by 2002:a17:907:96a9:b0:ab7:b82:899 with SMTP id a640c23a62f3a-ac20ef7d07fmr32945066b.22.1741117787320;
        Tue, 04 Mar 2025 11:49:47 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf4cbd77b3sm682991666b.74.2025.03.04.11.49.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 11:49:46 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e4cbade42aso239384a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 11:49:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6++3VH8swKbdIgo7+n0GAWMV1BnBg7DVxe7Y/pH3MXuyf+DPaJaa5uZC8lCr12Qa28kJX2Hr5JHePUwQ=@vger.kernel.org
X-Received: by 2002:a17:907:6d15:b0:ac0:4364:4083 with SMTP id
 a640c23a62f3a-ac20e8282afmr44370366b.0.1741117785955; Tue, 04 Mar 2025
 11:49:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303230409.452687-1-mjguzik@gmail.com> <20250303230409.452687-2-mjguzik@gmail.com>
 <20250304140726.GD26141@redhat.com> <20250304154410.GB5756@redhat.com>
 <CAHk-=wj1V4wQBPUuhWRwmQ7Nfp2WJrH=yAv-v0sP-jXBKGoPdw@mail.gmail.com> <20250304193137.GE5756@redhat.com>
In-Reply-To: <20250304193137.GE5756@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 09:49:29 -1000
X-Gmail-Original-Message-ID: <CAHk-=wierLhQ7EWZKmzNRhBPh6cxCeBDoe-Av8Z0F=8NDXj_gA@mail.gmail.com>
X-Gm-Features: AQ5f1Jrk3jtSVTjA57AGzmLsR0KaZmt8Rg4MlMimec-gk9RnYLUm_72TU3Ug_Lk
Message-ID: <CAHk-=wierLhQ7EWZKmzNRhBPh6cxCeBDoe-Av8Z0F=8NDXj_gA@mail.gmail.com>
Subject: Re: pipes && EPOLLET, again
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 09:32, Oleg Nesterov <oleg@redhat.com> wrote:
>
> I agree that my test case is "buggy", but afaics it is not buggier than
> userspace programs which rely on the unconditional kill_fasync()'s in
> pipe_read/pipe_write?

I'm not convinced any such users actually exist.

The reason kill_fasync() is unconditional is that it's cheap. The
normal situation is "nobody there", and we test that without any
locking.

So we've never bothered to make any changes to that path, and there's
never been any real reason to have any "was_empty" like conditionals.

               Linus


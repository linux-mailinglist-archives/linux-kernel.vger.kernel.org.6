Return-Path: <linux-kernel+bounces-271592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0096C945073
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59D58B25E4F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A239C1B3F0A;
	Thu,  1 Aug 2024 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AFF16Cjn"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EFA1A4881
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529465; cv=none; b=RLcOy2cd0QzK8dImi8H7fLxYHxvPZgM8+1o3smvRxsEsSnca1Ym1JCIcciJIZ/d9a6+znHtMxMQQx9DMXMv8EvpQ5aT7if2qLQJPg13T0F0mqltk+mUjLfF8B9s+lir/F9IEmvfW+Z3l+fG366bQ6Yg8xeTy8W3O+hDTZyhKrhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529465; c=relaxed/simple;
	bh=zTWC/ZIJIXaqN4KKGvBXaRMV9OKzsQD4VWeY9YvZ9hU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ym8s3oL+qBGMLC/gnmiHkVX1/I2UhScdWSRAxa7ChtN7ARhLjw1rMC7kppUlcaNc+SgzJCkhsR9rNHz/kL8ucZUenqIRM8VAlS94U8G0aVbEZGL3kxqJ3v9pmANfbaY1X0UA/I5UirBTajYYJ+c/d4b6WTjBZDAPDQMLlvelad0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AFF16Cjn; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so15721481e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 09:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722529461; x=1723134261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=unOmqjTlmyqIRULF34AzgYdC8GCPxqjK8N3N5rddgiY=;
        b=AFF16Cjna8klgTAMF+YIKSGe6fEQ84yaBPzYTQkSV047rGPv1Us9ulFy1BWxaSTVmU
         ep6uNSFLQfxY4UHvWd7OVu9qPgnnuSocxgRpif1CeXdUt6Y/w6X+gLLTTFdtxOBw1qUo
         evSGZ2975JMQPFA7t1rA3Gocbt/w7QT5OPEUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722529461; x=1723134261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unOmqjTlmyqIRULF34AzgYdC8GCPxqjK8N3N5rddgiY=;
        b=iQLRYz95fKAGjrdh8VImAiKU/9h+RN1b/O2nyphc4MROEpVCa1xQszch6JsWWBm64W
         bJDdlBoCWqFVKXbOh7G23pnjw769NubdhovzmPPKprCqPi3qBmmahYv0Fd22HiDAfBzH
         x6kzeJSW2N4wn+2F5Hv9EQB3NJXm9fxnh7BJEXyqd7ssYuPkJCTEvVpxEqXEKhla/Bnr
         DbEeNYpBg5QCOCGSP0m0YqRSSZyaN5gtKbUQgoSWyKZmvNk/VaJN7aaq5tWh/U7E6ws0
         3X3qp6iXJNY3g7M6t9wBkl5aDjf2yxKfdCo5KgZyx8N6lFGtEBgCKGRUWVs4KookJn+b
         lDnw==
X-Forwarded-Encrypted: i=1; AJvYcCUCQZ7AOLcqdI8FOZ3xUjtsX9yI2B0Nally+RWbVW8y7P3AEZEUb7w8gDbkMFgNrq7rBx8iZC9E6R4tIQdPTldi90RwzAD0FnAZKHeb
X-Gm-Message-State: AOJu0YzT83EBwbyuRoHTC7kGWM9IqLieWT1NUYmmWoYVUNEuq1KZu0qs
	0ROeNjXwC9JdGUcKAHcAizr8AF9yBSqLOaTUjmNYKzbgdzYDbL4+JCErFUnydeVCGRzO/c8VZUH
	kxd70Ag==
X-Google-Smtp-Source: AGHT+IGhhSSEs7QWxYUSQ9/8lmopfuCuUV7V8kKZCrSLc5Yup+QezztLXuPhBaeXZyfnATAxTQ9EsA==
X-Received: by 2002:a05:6512:b8d:b0:52e:8071:e89d with SMTP id 2adb3069b0e04-530bb3b45f5mr410476e87.40.1722529461212;
        Thu, 01 Aug 2024 09:24:21 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bc419csm2683609e87.47.2024.08.01.09.24.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 09:24:20 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-530ae4ef29dso4510059e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 09:24:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXrZzuOng+889cQvUsRz2LDs8Mu8nwKygTCwF31LQP5fvjkUcb6iSP7fc5Whdkaq0Kluuck4BliXQJ6gTg2l5FQBq2G+5iWs57Y0+3s
X-Received: by 2002:a05:6512:1092:b0:52e:976a:b34b with SMTP id
 2adb3069b0e04-530bb381012mr352849e87.15.1722529459947; Thu, 01 Aug 2024
 09:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgPD+=Wi8T0A59muq46LxquhsWQSyPV6KM5xa8V1UPK=Q@mail.gmail.com>
 <20240801063442.553090-2-davidgow@google.com>
In-Reply-To: <20240801063442.553090-2-davidgow@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Aug 2024 09:24:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj40jGrTES8SL69EVdtUwauL+C_12KGMpapdkDZEgjhiw@mail.gmail.com>
Message-ID: <CAHk-=wj40jGrTES8SL69EVdtUwauL+C_12KGMpapdkDZEgjhiw@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: Zero the 8-byte get_range case on failure
To: David Gow <davidgow@google.com>
Cc: Kees Cook <kees@kernel.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jul 2024 at 23:35, David Gow <davidgow@google.com> wrote:
>
> The 486 seemed to treat the wraparound a bit differently: it's triggering
> a General Protection Fault, and so giving the WARN() normally reserved
> for non-canonical addresses.

Ahh, yes. Old i386 machines (that we no longer support) did the same.
You hit the segment limit, not the page fault.

And we had something very similar when we did the whole 64-bit address
range checking relaxation (to avoid all the crazy LAM noise in the
access_ok() code).

See commit 6014bc27561f ("x86-64: make access_ok() independent of
LAM") and the extable.c parts in particular

That wasn't because of segment limits, but the whole "non-canonical
address range" ends up having a very similar situation, and also
causes #GP before the page fault.

So yeah, the same way x86-64 no longer warns for #GP in the user
address range and the point where the sign wraps, the 32-bit warning
for this #GP would have to be suppressed.

In fact, it's the exact same gp_fault_address_ok() logic, it would
just get a 32-bit case for "#GP at the end of the address range is
ok".

> So I'm a little worried that there might be more cases where this works
> differently. Does anyone know for sure if it's worth risking it?

I don't think the address wrap-around is a risk per se.

As far as I know the "undefined behavior" is not some kind of subtle
thing where things have gone wrong in the past - it's just that later
microarchitectures just ended up special-casing the flat segment setup
and no longer do any segment limit checks (or base additions) at all.

But I'm also not going to argue that this is really worth pursuing on
32-bit if anybody is in the least worried.

It's on life support, not like it's actively maintained. Your original
patch may not be exactly "pretty", but it clearly fixes the problem
without playing any games.

          Linus


Return-Path: <linux-kernel+bounces-425892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29209DEC4F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2235DB22448
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345A91A0BCA;
	Fri, 29 Nov 2024 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ITEaKYW+"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2049146A7A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732907947; cv=none; b=pVum3bHOEocvIMSJIUYInp8YaP1moJq7mbxHFn3NOUbAyJpMNqZyM16k5ixOyy0jEoiZWV2FZYdXwiY2W6rv/H4UsFjRi8dij+BV6BbOor01RtUQ7BqjMPvH755kpxNF9+Cn4v6vmAyHOUHjJ3j1qIvym4Va74P3qllKrPLgiV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732907947; c=relaxed/simple;
	bh=mNS9FaMKCLppUduw748DyIhFvH81tqU2jublvdUmfik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xzo/AvBZq92yZPZGw00OKtgnd8INIM0RrTaK7i8WAHhNwWdha5VdjABpYSEYSfLSZb2a/7penOuusQSEqHPmqipyo8je5FPx1uQYFtNT1ZkeoaA7QPQWgbs9lkCFUwOISjczmREnrIWV6fDOX8asCWc5ZByOi3YHKSOpgCR8pV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ITEaKYW+; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ffc3f2b3a9so33024431fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732907944; x=1733512744; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XI/yTJn2K7uR/0ULxeWbYdLFp4HJLuDCg3+eK/ajORI=;
        b=ITEaKYW+GEPGv9r3A6HvifL5xoU0jur2vTVEX3BwV05Y+PxvmlnbckUnvOTaXTdsmU
         dLT+aeSLjkWt3G0pWMqGOXb3wbTQDil/xYOWSi9GivTN4DkbPwu+PyTx0lKcnVpVApgH
         sGJgb7zi9n6vGrlnRQ5b6tSF+X1HZbqBq4UrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732907944; x=1733512744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XI/yTJn2K7uR/0ULxeWbYdLFp4HJLuDCg3+eK/ajORI=;
        b=vofl2O56hllSbyq39f+XZiFNCY51cWHxcfFtcueDY0lOhr/glrlQcPjNYSn9abxMJm
         dx59B/F9d6g4obcMkvJm5ivcCoj/klIqHCSE1a7CETID/uI/z2NvZyO5YLtJt2Q8bnn5
         Q3p3rR0tDc54+qQxIreRrOoXBsNEKxXRa6Slu4mJm6WZbCrDNUjd4Gdp9kbGoyySEWo1
         t9YMRBq36nB+kVEuU4sKzKmb945TiB0MsAvQgoNxkQVzgf+0D300+9Gj8wKPh9coLLRP
         nfsrILf+GKPumOz5E4KR1FMzcDhaNEunAg01ekiaCaXHwbeuJvbZLiggkiFYozuSiFET
         LF1w==
X-Forwarded-Encrypted: i=1; AJvYcCVM9idWcL75KIARytzS43sAbLnCLXPUJO25LVGSGT9OYG01MMaO7Lr1l/KGy7mTX2zyk1eRz7RY0xmI6YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD5SNO8FEONtunbVasXkyQyQ+afprcg6Jj2RT+4+XfxIH3q2Uu
	mqHkCFG41U03/gcPV3IM98I/JMsKSWUO7+QQCvqETbhL+fzETxC2/w6xn6co+QsFYDIlXhllpAS
	kyK8mow==
X-Gm-Gg: ASbGnctHXKXdZEgLTBAqdsmzJe8EYCkAVWov7zMS45LTChM6mVB31kCEMq9VHXzu3Z5
	rjYFKYG9QLjsO/yTjDi/TuYs+lokMbQldr9ilZWegayR2JSSq9bnaSwpkCvpXuhWFOyo3e0WRGr
	zAEKj6geajdDL5/BBE2L1u3R+Pp6LeSFxFJnNpImUI2jCI4gDkY0dQoU9EuIKGjRKSX8cYOh4Vt
	AZXWc4Rg25zKJx0oKwAG5L7Mq35MR3xkZs9o6M9mQhrSNvgjNF++tURZhbx5vydpJq8ENYRgxGp
	Duta6D+50wiN6ddp8N6PDcSr
X-Google-Smtp-Source: AGHT+IH14d3e6xJbcfVGpsMF8uBeOmw6UpZuZ7axMHRS8PFOeSmOQzWs0MIX/vOSSI12ZWiJr08FqQ==
X-Received: by 2002:a05:651c:220e:b0:2ff:78be:e030 with SMTP id 38308e7fff4ca-2ffd5fcc145mr122224911fa.3.1732907943580;
        Fri, 29 Nov 2024 11:19:03 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbef7a3sm5052611fa.45.2024.11.29.11.18.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 11:19:00 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53de579f775so3355749e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:18:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXvVAdXuT07pJ01wzHrgZn3X7H8aP65a1rw1chX98TDRKGmYrjPH9HYrz3IHkIYNa0rcSpGLfVfxLhm5BQ=@vger.kernel.org
X-Received: by 2002:a05:6512:3e23:b0:53d:e5fd:a453 with SMTP id
 2adb3069b0e04-53df010b140mr12908711e87.39.1732907939280; Fri, 29 Nov 2024
 11:18:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z0jEBLLRoUKoBVPk@bombadil.infradead.org>
In-Reply-To: <Z0jEBLLRoUKoBVPk@bombadil.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Nov 2024 11:18:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh6SLoXB4zAY51yScDMwyauo0a8FJ05TO_bb6UVNXcCNQ@mail.gmail.com>
Message-ID: <CAHk-=wh6SLoXB4zAY51yScDMwyauo0a8FJ05TO_bb6UVNXcCNQ@mail.gmail.com>
Subject: Re: [GIT PULL] Modules fixes for v6.13-rc1
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: samitolvanen@google.com, petr.pavlu@suse.com, da.gomez@samsung.com, 
	linux-modules@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, geert@linux-m68k.org, masahiroy@kernel.org, 
	mmaurer@google.com, arnd@arndb.de, deller@gmx.de, song@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 11:27, Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> This consists of 3 fixes, the main one build that we build the kallsyms
> test modules all over again if we just run make twice.

Thanks, my empty builds went from 43s back to 23s where they belong.

(Obviously when some core header file changes and forces everything to
be re-built, that's all in the noise, but the small random pulls are
now much faster)

             Linus


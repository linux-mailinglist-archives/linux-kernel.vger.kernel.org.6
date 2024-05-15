Return-Path: <linux-kernel+bounces-180355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F3F8C6D60
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 417F3B238ED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72551591E8;
	Wed, 15 May 2024 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HmzEREoI"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CA415B0F1
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 20:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715805814; cv=none; b=d0LED32xEI6FGzzU56JbF5qbhguMw0/bW6vGsh85FZLNEvxkQqem3tmRwWBRVl7Tq02dHtNaazRSJ1920lm9jee7H2JIw9uZiqgL/TLdQL/IRiyOCxMwCTjGRSi5EUzrLPxNGi1ZuldexGtbRiKDqsc6Cy9UIMeCDwLKuH7HfGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715805814; c=relaxed/simple;
	bh=F+h/+8GYI45njhSeqGLkBCCG5Uccty6I//3guZmXwIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOXJNSw/qD4GL0VuARSK55EDh0IMf+S0+PEHnWhuOE8kMXW6wV31/wa/l3VAeiWIzF+qE+2mv8cqwLpc7JD7OIfoQ7q2LLA2YHJBS+OXKp/nWutCZQdjuY3g/KdI9u2N851OM+7qoQLOadznhP127X/F24MwNY/FYhCK+tA3XFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HmzEREoI; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59a352bbd9so305022966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 13:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715805810; x=1716410610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dVdeZxY54sSH0v8wTKekTlioXCSfmbN/I2OTCQ/d+0o=;
        b=HmzEREoI5glsLZgsBzs5Pjm/YRVW95pxAOb46lsPCHyjPsn6yNGq606Ahnc+unbNCD
         s4lSJDMCVCBLZSkrVgQov2OlqLbYqhwLIr4UrsvK9lS+GpA3LAMCXT6kO+5C7vut5ZSo
         iXuFhMuto5Rp3aPDXj9MIjoYBqBpyNVZcyLRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715805810; x=1716410610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dVdeZxY54sSH0v8wTKekTlioXCSfmbN/I2OTCQ/d+0o=;
        b=IWXy/hbcNo9b+RtkNHL4sKu6TvjysXdCgIiWPcYCO7kI5wApjUT4OC2GuShqBIRzSx
         /0g2F6Uc/ZgHL5Ak5cD+vwEPXXkYGiFAcjotq1koGpdulcz9v8AGLpo2VppHbHmAj5QX
         QcNqu0oTSvka7O8H+nA76Q7Lx7Oi4Ygyx8siX70gNJBMQ38dSySNA5UWNHzzYnvarOG6
         LuyocrYEgOpdlyKHpgMr41I+IYfVlg4C6s90nEi5UBVRo+p0FuWw7q1EGa+wNxDYBrvV
         5IR5sP6MVg9ZJO7Wps0lJAvZcy6UQGF0kBAA4ktOzwggM8RwmtJiFVYv9hbh9bJp/47D
         22kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy8JC6shH6qh4JaEMKKNwV/lZ4z19u+IQUrhgIpQ3SBio8fwEI1fPSFgTwoTZEB54SHdB9OZ156uubq2sA27H8n4RpUQCpLh9MwmOz
X-Gm-Message-State: AOJu0YxDh213gAw6zyAQm78eO/kZ8HpijEnewQVoaScBp2GAPQuHG0iJ
	P5mm42pjsEuQA0aEWwlcFrIpyDE+H1w7GEsRY0c4OUj+36CN3Zwkydhk094TpotvT4V+hsKJsER
	XugQpSQ==
X-Google-Smtp-Source: AGHT+IFgXzGe4zITMRWgZRTkFnMy+jq4RdmizLE695T7VulMcWXlL3bFvy5ZvNMyC3HfU5D010JBrQ==
X-Received: by 2002:a17:906:b2d6:b0:a59:dba0:1544 with SMTP id a640c23a62f3a-a5a2d318e22mr1231341466b.31.1715805810222;
        Wed, 15 May 2024 13:43:30 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781cf60sm915016466b.14.2024.05.15.13.43.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 13:43:29 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5cdd6cfae7so114498966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 13:43:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzxICFe7NSbn196+iyPIfoR4Mc7z/kfBdgTbTldP0i712EwrNVWDRzK7/vRUuZaezUR+u3wp/SQquCDA96bO4LuIjLKjvP0RWDybxO
X-Received: by 2002:a17:906:5411:b0:a5c:dad0:c464 with SMTP id
 a640c23a62f3a-a5cdad0c554mr155400166b.6.1715805809232; Wed, 15 May 2024
 13:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tw-53PCvveRcdLUUQ+mjq2X2er5zp6n1KeE8Nu8x=VP2g@mail.gmail.com>
In-Reply-To: <CAPM=9tw-53PCvveRcdLUUQ+mjq2X2er5zp6n1KeE8Nu8x=VP2g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 May 2024 13:43:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxT8D_0j=bjtrvj-O=VEOjn6GW8GK4j2V+BiDUntZKAQ@mail.gmail.com>
Message-ID: <CAHk-=whxT8D_0j=bjtrvj-O=VEOjn6GW8GK4j2V+BiDUntZKAQ@mail.gmail.com>
Subject: Re: [git pull] drm for 6.10-rc1
To: Dave Airlie <airlied@gmail.com>, Jani Nikula <jani.nikula@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 23:21, Dave Airlie <airlied@gmail.com> wrote:
>
> This is the main pull request for the drm subsystems for 6.10.

. and now that I look more at this pull request, I find other things wrong.

Why is the DRM code asking if I want to enable -Werror? I have Werror
enabled *already*.

I hate stupid config questions. They only confuse users.

If the global WERROR config is enabled, then the DRM config certainly
shouldn't ask whether you want even more -Werror. It does nothing but
annoy people.

And no, we are not going to have subsystems that can *weaken* the
existing CONFIG_WERROR. Happily, that doesn't seem to be what the DRM
code wants to do, it just wants to add -Werror, but as mentioned, its'
crazy to do that when we already have it globally enabled.

Now, it might make more sense to ask if you want -Wextra. A lot of
those warnings are bogus.

               Linus


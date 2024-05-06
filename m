Return-Path: <linux-kernel+bounces-170393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 358718BD63A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 22:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664561C211E7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 20:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5C515B10E;
	Mon,  6 May 2024 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G4Zd6+tj"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05895156C6E
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027341; cv=none; b=LD7QNNkERoDTJatcamvbBS4Px1XMZXwkZ+xbUREuY0UHNIXpgN34uPjdf+TJO/F9QY2WL/D8UymJAOuZZ8Eg8925X02w4z23WWxvioZp0AKDqbo2PFhbZ9LxC4HMkdvEX42dnqfc/HEuhxC62kKJNg3i3G12iTJE31AcxV8VgwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027341; c=relaxed/simple;
	bh=mtP1zPVwwrnnzGFw61ZIo91oUo/vvEn1hAGzwekDkNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVyFOOo0ZH+fPmmyf8nEfo4Jkmy04T853E/fPguXLMunqVkvzQHIL34UK8I2AizFXY0UczFGSwE0RKjy65hPOQZ6NhNt92wrGuH3HrrQ9uUkOx9TRD6tvfKlsbRX3pThDRmVYa80xYn0HkevR8UzpCsCRvW8ZykrPqNWrxwp5Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G4Zd6+tj; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2db13ca0363so36990231fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 13:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715027338; x=1715632138; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9rEvKV3/n/eLv6nHs7D99ycPG96v9YjV73FZYOIF6xQ=;
        b=G4Zd6+tjvbOZB2K+N2y5X28Ee/65O5L5h/CAk0wJxqzMn/3jMsnVQ6lz0gQLUCRmDz
         sVLSmlponCaAT6OrANf+n+EuUwpoYyWDIFJjBgzg6ftmYZXR0J1ijnFwYM9JKD7UZ7jT
         lWGakJ2YbTOZDZdjwKLkVqXuYxlHHfefCBk9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715027338; x=1715632138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rEvKV3/n/eLv6nHs7D99ycPG96v9YjV73FZYOIF6xQ=;
        b=Op5FSjvQnwWxtacsU6sGnFXZU6V+boCOqTFYN9oW5AdMKJKuFTzERNlfaQu9GKpCqi
         DoE+4IkA+irdVn/lloEbQG6TbM5xxAEWcuK70bheKxADWH8glCz29ab0xU2Jx9NEBbwR
         QXpnvnaLiEcBqw5xB/8uiTBXmLn+jFUQO733SyOYGQKuiajEDzKQLW5SRWiFv8/UHlnz
         dCuI1hU1y8MPMS/V5ptj5ahaXeAAkzhCvY+oDRSXwg8W6Hx3eLSbe69PNZ8qLCEujWhY
         o4hszGqxt23OuWJEJRw5z1xjNVOq8dXa92aeQzx3cYZmx4FeRaZi3QL+ZSD+KAtnJARK
         bO4w==
X-Forwarded-Encrypted: i=1; AJvYcCX7+T99LNnVqkVaAp3xDcdwH4rprOg2y9Z+bp05ize/+SvHrFzfVYs9uFpppqCB45rMe6KbOeC0zGm64CKlJ4msdK2FN0xUw7sqzizf
X-Gm-Message-State: AOJu0YwJP9BWkJhI5mCRIwF6ToMKB7DKQhmkD4Ll8oC+VuHC8VMgLAeY
	bNOP2wd8prGOERFk3kSsMS9bBYywgfh/f7R26iX7bqosiHw3XoCDZ+ajyn89HNBcE55eksbSNiX
	xlmvBlw==
X-Google-Smtp-Source: AGHT+IG6Es4jf0/5XcNE5zvJ/kHwfj6hCASvXWLTebdQmXCh0PZ87DWy0mwIojKlawbpoV/31RMIcQ==
X-Received: by 2002:a2e:994c:0:b0:2df:6df7:c363 with SMTP id r12-20020a2e994c000000b002df6df7c363mr8790037ljj.14.1715027337860;
        Mon, 06 May 2024 13:28:57 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id s17-20020a170906455100b00a599ac81707sm4211801ejq.123.2024.05.06.13.28.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 13:28:57 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34db9a38755so2200656f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 13:28:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/4sUVgKwVHXd0/Z/dXPBx7XQRXh8HR9GYOty89IUIDDwxp8MwrQ2vGqorqHHLk4j8Jm1H6XQH7efykjitKn3V1SiAvURUPGi7eCkm
X-Received: by 2002:a5d:4576:0:b0:34d:b634:9033 with SMTP id
 a22-20020a5d4576000000b0034db6349033mr9191049wrc.51.1715027336528; Mon, 06
 May 2024 13:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502081641.457aa25f@gandalf.local.home> <20240504043957.417aa98c@rorschach.local.home>
 <20240506-cuddly-elated-agouti-be981d@houat>
In-Reply-To: <20240506-cuddly-elated-agouti-be981d@houat>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 May 2024 13:28:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiS70D1sbhsvNfR0e5YjfG2NV0cVKWz9vp=_F_wkw3j9Q@mail.gmail.com>
Message-ID: <CAHk-=wiS70D1sbhsvNfR0e5YjfG2NV0cVKWz9vp=_F_wkw3j9Q@mail.gmail.com>
Subject: Re: [BUG][v6.9-rc6] Deadlock with: Revert "drm/qxl: simplify qxl_fence_wait"
To: Maxime Ripard <mripard@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alex Constantino <dreaming.about.electric.sheep@gmail.com>, 
	Timo Lindfors <timo.lindfors@iki.fi>, Dave Airlie <airlied@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 May 2024 at 05:46, Maxime Ripard <mripard@kernel.org> wrote:
>
> It looks like qxl is not well maintained. Please send the revert, we'll
> merge it.

I'll just do the revert and we don't have to do the round-trip
overhead (since we're already in rc7 and I hope to just do final next
weekend).

              Linus


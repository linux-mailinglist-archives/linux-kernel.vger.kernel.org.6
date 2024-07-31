Return-Path: <linux-kernel+bounces-269887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558F1943820
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8746A1C21B17
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD73216C87B;
	Wed, 31 Jul 2024 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UXnRf2yJ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546566CDBA
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 21:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722462140; cv=none; b=sdfYI85Nb/dg9kDd7RyY1xi2iC6RL+37afoXmC2pgGQVpu8vorTeJvKb8MXeMlJko2f1AcLLJYBQSEhAYpGpNrfySJabQxby/WdfLWzc19tWR+23+ZRXXzSm1q5T8d+zjZhcLjC02ERgbZiyQwkPSQrk7RNeYvrcHwjy0Vk2ixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722462140; c=relaxed/simple;
	bh=Gx5qdIMO1Ypbej9UT5ovasteRSV1zKzjsU0IgqzzbAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FyrG/f5SNlvDvY2oB/ukyTkgQo89kI3THMeFHfTWXXmekvBKS/augs6gtysTH6KZYP9xBLKX8zS+nKdMsIXpY3YM7kMbR58V0uKrseEdbA9CJ4hpTBpzKlNamYyTJ46xWd2xGOfs0pYH45LPLsvY1KGAFIGAvOmVY4sWGPJGyVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UXnRf2yJ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52f00ad303aso9852563e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722462136; x=1723066936; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9vPrdVB+1gFjA4A2oimdXTgokT/j6Phdyy79D/vBgkA=;
        b=UXnRf2yJWrgXT3ZqwOK6i9ughSr6jYY8RPrKCnbiUAeBocBGyqTYn8DB5euzQzRcTM
         oojgaoG9RhVOcWoaCY1zst94NiG8psks4Ks6jkptWm8qX1z2iHRAvctH3cWg3E0O55qV
         /9M6iASKqNSgPEbHp7a1rSUFPKUjahajk8bBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722462136; x=1723066936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vPrdVB+1gFjA4A2oimdXTgokT/j6Phdyy79D/vBgkA=;
        b=dlDCy/+wNmWyyfN9vKZPKXsktKMa8zJnFpQqUKFzTulBKplQ4RWQ9aOMVJny9FCsk4
         12TIjGAAnxgsaI86FvzG6DaMxoA4CbAIFmfpR6dMtUZVfUErtfSs/UCUExfpSa49De95
         /CkLIVnI0zsxtq9VTPGt/SjXJROsdUb+Tad/V+kFPCqZwVxXjg618d665hMb0HFxpynK
         7S1EgvIHfBixfH7eQaN2IkjLJd037Vn2aLpVQDHFMQuxlkXOdoqoxrxwg0FYPEUs1m5l
         AOs870jX2IxSoL3xYHzpjwaqTn630hwlIK2cuVfEZyvUaaQ6V69UfwV/ZtRp/Tu6r04t
         s1Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUHw7bLlCwZVND2E23giiNIah+EaoJflybwT/DK3BzPZMS+1McG97Fhmt8qXFnJNYsBaL3UrOZCw1POKStPXKmu1lsEPgDpj0CBA7YW
X-Gm-Message-State: AOJu0Yzt7eN7mvyTdMsz4n/rXE0d1v3LuUHI9P9izpHE6XK+/FIUC/vz
	4RFMpuRigzXl8JHIWaUyHWq3L9hBmO8ih0J3AtRU9yASEigR3XVAXI9oqfM9D+0fYv60Y7KsTuy
	LvgaqFQ==
X-Google-Smtp-Source: AGHT+IF3T+wRim/1U7XbyMxctDC/qu3SRfVp4xqHTloDaXgPQgwjlzfUgsT98n2+Ydj4Cipy9ru1hA==
X-Received: by 2002:a05:6512:328e:b0:52c:8206:b986 with SMTP id 2adb3069b0e04-530b61f82e5mr132039e87.56.1722462136094;
        Wed, 31 Jul 2024 14:42:16 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590e73sm9216281a12.35.2024.07.31.14.42.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 14:42:15 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ab2baf13d9so8849917a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:42:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSXv25DjPxzsexNWimbr+Ud1Ao8vtslO9yDP50PdnlPa82tozuRaOSaEEvdO0R64SbXjbBY/L4y4psfp7XQg+cX6QiBRGVdS7KKrG0
X-Received: by 2002:a05:6402:281:b0:5a1:c496:2447 with SMTP id
 4fb4d7f45d1cf-5b6ff2f4b74mr178073a12.21.1722462135048; Wed, 31 Jul 2024
 14:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <daef7867-b548-4acb-b8bf-0bdeb057d6a4@roeck-us.net>
 <20240731122002.GE33588@noisy.programming.kicks-ass.net> <87mslx67dm.ffs@tglx>
 <20240731155551.GF33588@noisy.programming.kicks-ass.net> <CAHk-=wjhQ-TTg40xSP5dP0a1_90LMbxhvX0bsVBdv3wpQN2xQQ@mail.gmail.com>
 <20240731163105.GG33588@noisy.programming.kicks-ass.net> <20240731165108.GH33588@noisy.programming.kicks-ass.net>
 <87bk2d5v83.ffs@tglx> <20240731212007.GW26599@noisy.programming.kicks-ass.net>
 <CAHk-=wjSs62k3p7sS3uR7TSTsZg1q8-=Vm0douhodk2R0FqP=Q@mail.gmail.com> <20240731212624.GZ40213@noisy.programming.kicks-ass.net>
In-Reply-To: <20240731212624.GZ40213@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 31 Jul 2024 14:41:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=whB1Y6xpfuJ4oT3==Z=gxLirrXxZcSX4HLOfiozi_BmDw@mail.gmail.com>
Message-ID: <CAHk-=whB1Y6xpfuJ4oT3==Z=gxLirrXxZcSX4HLOfiozi_BmDw@mail.gmail.com>
Subject: Re: Linux 6.11-rc1
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>, 
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jul 2024 at 14:26, Peter Zijlstra <peterz@infradead.org> wrote:
>
> x86_64 has everything PMD aligned. It *should* never encounter a PTE.

Ahh. I thought it only aligned the beginning, but yeah, I see that
ALIGN_ENTRY_TEXT_END is also PMD_SIZE aligned.

That smells of wasted memory, but I guess the TLB advantage is worth it.

         Linus


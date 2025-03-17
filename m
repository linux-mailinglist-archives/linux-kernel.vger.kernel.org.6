Return-Path: <linux-kernel+bounces-565084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178D2A66084
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3534B7AB152
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9602A201278;
	Mon, 17 Mar 2025 21:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mpvj0NJS"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4B21F8ADB
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742246968; cv=none; b=NLRnLY+PiZqXb0c1tQN092z2XDXvGIpx7UwCdyGUrTXTiNVVR8AtfSr8IvMxUXQ3VPAVhJdws8x9ATP65sfmqHu35cweWBMIUCIQjHzzqJ4pKr3r9wdTeIodxXTBGjw3quM7NazDkjEG1fe0DtezQLfYBi0IMC8FNjfh+INkQdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742246968; c=relaxed/simple;
	bh=vK4O45wExSGocePRqMOevgBIOA9nRmgU+D3T6rwxuxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOZL4Jw6mFd6KQdvp82n+7fxswj3+E7znHHbUNVqpkUWjRZV5g2ALQouSq6cUJgUoA2LQHrFfVnPhOxrx8lXgrv4eUg5/kmZ5cVQG8gH60CIzKNrqQzhG/GL/Uk46a6s760ahFKtUnoxOcLp9Fa/O1FMXmPOH2OuTCec7HpPiPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Mpvj0NJS; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so6881616a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742246964; x=1742851764; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rVfVjdaiHdKvLhD8GK0obNQ+wrdNPOtG9MyK2Tp8QrU=;
        b=Mpvj0NJSqzmk6p8Z7yAQd2zTfGqKBh0kyiu+SVMCqcacNRKRWzR7H+KPbirCznxzuI
         4FNWyIQ4bX87R6ZOh//nzkGBkeXPdeCHMJyRIuZvgTLk4EyVGpogUBoeVYFYPbK99LBJ
         iPNb5uN/CV5ZpL7o7zaKdVvgKk35LoEfZpNzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742246964; x=1742851764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rVfVjdaiHdKvLhD8GK0obNQ+wrdNPOtG9MyK2Tp8QrU=;
        b=KuJIdKL7YI/r6MzwBsF0SIRXqDXCg50que8fmTAzr3zWbQBgOXPgH/Uxa8MtKOWXJO
         80dxx3sVsZgQ2W70J0HP19mH2C4ljkXVRb7638ot5zPOBKx1sCOoNjeOqczNL6CxX98c
         RQrHP9tYaapN5gwpcpXTRc2l419DSAP+m7xzd4I8YBcB4xZeZEDL3+dqvfEUWDejahhC
         nWntnQnm3MUbH3vrlpkd5A8R5nCQznheYHhlIuQXqYdwW6wkJAwhmmoCjT0myNBqMsZI
         uJyjhwyaFlhHr3nP54F9aIDLOBlW0k79z0nVHyjlIwzH/SfRuB5hp8OVfUCuRruDzTHq
         frgA==
X-Forwarded-Encrypted: i=1; AJvYcCWxV6pLEIIrp/V8pBC6Xjf0KOZ3Ti3w7PRsySEj1heO7znUYjfEWIMSEDB9mZsneWnRaNNehnGOsjzHmqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNwd5Cdu9k/FrWWFdKLISTLs0jiKuluO7AlV2m5qThGl2hrEL0
	AZiXopLpKNWN/PFMdbobHlRKykKuPx6TBnnqT/V2pEjKZ10wMjhGDk6UII2cK6grCoBvcNeVX6U
	8NVs=
X-Gm-Gg: ASbGnctWh8nCCne5AzP6GHEwjUDFsf6ncyVqfG7C5Ysg13A8lKp3gl1QZ1MCeSxnXFi
	JPHK8sAIAwfs6csGocvl/CoZM8x2StRXIhIUSYsDntgy0HgdJmPqcxGV4sy96SLgYt+QTK2iS8G
	RSHwG+2v3gmcBUc2P8o4r0O3Kc6A3EPvbzBZbRpBd7NIUYYdhqaZRugWJ9gs56jEf92oZBR/Rer
	aV7+KTPhcr4psOSQD5qNWhWIyae2UdMAWIf4NyOsKOaShfiPaVVAruVv4hY9ekVt8zMHT30G8bP
	zG2RTGUb/DgmElr9dK1hA8Go8mc7PClHV6M7+k3JDHE8eOuIPRR5MVEd6pT7r+KhbaFQmm9218Z
	4T0rRwtac9FoYj6beySs=
X-Google-Smtp-Source: AGHT+IGEuj8HAbIMgU4dSrcS2ZWFxHfgCTDF8Dl/1Hwr5WYLnWux/uI8HUkz93Me2Ml2f1MA9XgkhQ==
X-Received: by 2002:a05:6402:90d:b0:5e5:ba77:6f24 with SMTP id 4fb4d7f45d1cf-5e89f92dc6fmr15363176a12.16.1742246964369;
        Mon, 17 Mar 2025 14:29:24 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e8169bca53sm6649188a12.46.2025.03.17.14.29.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 14:29:23 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so6881569a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:29:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPd8gZnTKTOysobjGYEhxflTpyDBNi/MqvNrU3g+eKfuPwNH+8MAjobgKohJWAydJ9Dwtnd/E97m/qfvs=@vger.kernel.org
X-Received: by 2002:a17:907:c28:b0:ac2:dcb9:d2d7 with SMTP id
 a640c23a62f3a-ac3301e243dmr1719133666b.12.1742246961528; Mon, 17 Mar 2025
 14:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314175309.2263997-1-herton@redhat.com> <20250314175309.2263997-2-herton@redhat.com>
 <CAHk-=wj2MhDH_zjnyrUhYUf3ZqokC-jKSeRp9G6GnhwFU9z+Hg@mail.gmail.com> <20250317131623.2cc15ada@pumpkin>
In-Reply-To: <20250317131623.2cc15ada@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 17 Mar 2025 14:29:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6aT1ytSaBouOSpu71ZFMY8ct1a6=HOQC0CZuHxQqK2w@mail.gmail.com>
X-Gm-Features: AQ5f1Jpru_4tA7Fcshs7y84OUHNY8Pr20Ph2P5__e5uENS1fJExDUd_Zuyn-QFI
Message-ID: <CAHk-=wg6aT1ytSaBouOSpu71ZFMY8ct1a6=HOQC0CZuHxQqK2w@mail.gmail.com>
Subject: Re: [PATCH] x86: add back the alignment of the destination to 8 bytes
 in copy_user_generic()
To: David Laight <david.laight.linux@gmail.com>
Cc: "Herton R. Krzesinski" <herton@redhat.com>, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, olichtne@redhat.com, atomasov@redhat.com, 
	aokuliar@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Mar 2025 at 06:16, David Laight <david.laight.linux@gmail.com> wrote:
>
> You can also something similar for any trailing bytes.
> If you are feeling 'brave' copy the last 8 bytes first.

I think that would be a mistake.

Not only does ti cause bad patterns on page faults - we should recover
ok from it (the exception will go back and do the copy in the right
order one byte at a time in the "copy_user_tail" code) - but even in
the absence of page faults it quite possibly messes with CPU
prefetching and write buffer coalescing etc if you hop around like
that.

It *might* be worth trying doing last unaligned part the same way my
patch does the first one - by just doing a full-word write at the end,
offset backwards. That avoids the byte-at-a-time tail case.

I'm not convinced it's worth it, but if somebody spends the effort on
a patch and on benchmarking...

            Linus


Return-Path: <linux-kernel+bounces-281725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D06A94DA58
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 05:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352281F213A2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 03:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1CA13213E;
	Sat, 10 Aug 2024 03:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QI0TkZte"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B484130499
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 03:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723261443; cv=none; b=d8aaqSKjnxozUKBhTLAUqP0xHdJHilGENJoxUVXGCXllmQSIiZOtSbw5bTgvdaK7hCpZc5ockYQbUc8YViu2tsQ5gOkwuZjENnW5DtsmtvhyfLI9fEdSsl/aU7XGyDGPX40vD9hzVy6xCq5DzhyxDhHQEpDHQgYDFEgVO2+CG9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723261443; c=relaxed/simple;
	bh=FE3RXVpoNHBCXWk6ztfgMYmPJ16jVDYUoJHp645GAPQ=;
	h=Subject:To:Cc:In-Reply-To:References:From:MIME-Version:
	 Content-Type:Date:Message-ID; b=DMwKpZ9GtQp9Vc4gDKvJ7cL21pge9kxyHPcjzotlJI3ChTF/XQ60b/K/Q8yoPZ7DEgrmnnk7w4h4xOJ+j9Rn/LdN0mgaz5HXTh4qv/6SwPmHnqD2TOdhRE4LIKMWeeIYh2YNeRUWOsPwRdg9Xgcu5jMBmLNPBNeCAxJcj4qZpzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QI0TkZte; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc66fc35f2so26849625ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 20:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723261441; x=1723866241; darn=vger.kernel.org;
        h=message-id:date:content-id:mime-version:from:references:in-reply-to
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=FE3RXVpoNHBCXWk6ztfgMYmPJ16jVDYUoJHp645GAPQ=;
        b=QI0TkZteRjnK3ClrIwphXvtsYPaIk3b9D98YwkpA1ImjFDe8xVLoAuaDDMh36ZYHU6
         2/faOPygo2XoGNFjpDlC5B1RSn/9hnNBcqCPLOu/AKLskDTatJ9/XPWTzA+g5LLKBzm9
         gMh2HgralJHbAhJLS50xPP9NJLvl+AK5EF2n1srYXkFXO79h3WfkHxJ3RPvAYw9xwrrN
         3LCikgJW8CzpzzqSSipg9PdJ8+azOHrkVhWCLiShK3EEoQzV3/xsD/Mti2a3TpCJd7ZO
         RceIdrWzaHvw5pQ5huvFSMKbADWrp4+xViIbSvQEN9NO+3auMGbp9mQGer71tIpT0k90
         oE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723261441; x=1723866241;
        h=message-id:date:content-id:mime-version:from:references:in-reply-to
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FE3RXVpoNHBCXWk6ztfgMYmPJ16jVDYUoJHp645GAPQ=;
        b=h92FBMi4xCwLNZmbhbv5WJObaVQ6V4Iu26Z+Fwe4uNW66O3FR38tj3VMj9x3hRsy1x
         Ov24mtWLr9WTJjV0K+6JExFoznRwVgGQ/Q6PJoqUgp9eBR/VZ8t+vIyoN8HISKafQ/cU
         osflQI2uybC6D8CxhnmM8X2KG66TVppVwQc+Unx/Sb0mwFSAkvOSv/u2WvOZ3qvRRijz
         Pfj6RgZlMt8tujs01colP8zxo3Qqc6IXeaX3qe9kmbeJwuC2ODM/2JrBUiScYHenI+32
         vw7fFRXpKHyWcHLelA5vh6clQRKXLOwQCIuVPgRdxHAe1PBKmt+9ZefCqRGVxQbYX4KV
         tOPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYmJAGgRk9id6OXjNUS2ZiDnLuuBOxot+C2s8ioQj7KwVrua86+Dv+5hsv43GifhC+h1esOo3ZFEQqJEQpRjuVb8J6SIlO5MmHmi56
X-Gm-Message-State: AOJu0YygsxK/SEo+fA0zPg9kXzgRGjOAiDcSQcBgdiMCB4kt3Aav4b8P
	vuVEbOZPXwChbAKwkjHvWYFnny9rsI5Fvvu94znwph1xC1OF3SAj
X-Google-Smtp-Source: AGHT+IEwiz4kZNJTeShbUD0UbmpzbV+9L4AW+sIzYXZhQg/B6km8AmrgM8wKstxHOtNfdmCCHLmEAg==
X-Received: by 2002:a17:903:2a8d:b0:1f7:1bf3:db10 with SMTP id d9443c01a7336-200ae5d878bmr50121265ad.20.1723261441352;
        Fri, 09 Aug 2024 20:44:01 -0700 (PDT)
Received: from jromail.nowhere (h219-110-241-048.catv02.itscom.jp. [219.110.241.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb7e8b47sm4510275ad.38.2024.08.09.20.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 20:44:01 -0700 (PDT)
Received: from jro by jrotkm2 id 1scd1K-0002Dx-2d ;
	Sat, 10 Aug 2024 12:43:58 +0900
Subject: Re: [PATCH v2 1/3] lockdep: fix upper limit for LOCKDEP_*_BITS configs
To: Carlos Llamas <cmllamas@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    linux-kernel@vger.kernel.org, kernel-team@android.com,
    Peter Zijlstra <peterz@infradead.org>,
    Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
    Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
In-Reply-To: <ZrZlY-5h5N28PMH7@google.com>
References: <20240807143922.919604-1-cmllamas@google.com> <20240807143922.919604-2-cmllamas@google.com> <1503.1723080058@jrotkm2> <ZrZlY-5h5N28PMH7@google.com>
From: hooanon05g@gmail.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8551.1723261438.1@jrotkm2>
Date: Sat, 10 Aug 2024 12:43:58 +0900
Message-ID: <8552.1723261438@jrotkm2>

Carlos Llamas:
> Yeah, I say that's expected if you bump these values to the max all at
> once. The values I gave were tested individually on top of the defconfig
> and boot completed fine (qemu x86_64 and aarch64 with -m 8G). I think
> it's fair to leave room to configure these knobs individually.

I see, understood.
Now you can freely add Acked-by from me.


J. R. Okajima


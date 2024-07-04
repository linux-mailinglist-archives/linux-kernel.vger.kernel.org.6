Return-Path: <linux-kernel+bounces-241551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C850927C79
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB811C2278F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826C549631;
	Thu,  4 Jul 2024 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QG2IMyDB"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A353FBAD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115248; cv=none; b=DNv7XXDqgFuDtOXzZ18YyEnDIOGtevX4ZGz7XJ24c7XGSjQVEN6GQO7N53eZ/aidYCXadXihiIqKmfPMY5dSOhVPUxclDsces59/Vbj/Sb5HrFeRLKHIEel5KL3zScpBcbI37vj8i/yfqDXFcsSUoyVKZfAvCwauECxjTHYM7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115248; c=relaxed/simple;
	bh=8de1y+BNZSbS5UCFbGFEnrNuy0nOypMhyMhTHcwDLGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4E/RyrwotwJ+9sXBHV5qMQkOMfLzpKz7Xsr1EiPPDE28lQ3jfnRb4x//N+678YXlkvu61n4uFuIjK+oVs9FR9/q4W+IlGoxibSti0CbStJ9oLYe9dUFHy5nvRuhsr2IGjimqV6RlwxogEwOBGpESrU0f6j+v2G3cmzf8gcmzpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QG2IMyDB; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52ea3e499b1so150288e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720115245; x=1720720045; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i/gtDd42UEoYjQD1rncZVpwLuChewFxC68t1WZvJdFw=;
        b=QG2IMyDBiUJqsofPIOItJJvNcDbqx9xA2fvq+9N39V2cEIVphi0P6s4q87Vac0GW4E
         PBLp+OFv65Jp0e88lOREVzbrPOJV6ZSYP+fUi8QXNxC7NOpp3ImSy95E/KQf1DT05XsF
         mdC+vpxn/zTvMaIM4udGOTj5WXUHL4uuQ9akc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720115245; x=1720720045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/gtDd42UEoYjQD1rncZVpwLuChewFxC68t1WZvJdFw=;
        b=sS4HPkTl0Lp8rKJ4/94mheQTuVvc4x1IVuWvPymg+nWEBaIL7vC/cf5N0K64CQgGm2
         VE14haIn/QZa548lnd3nvk/wZDUe8j/lt9v/ed6GrlcpmkSTHjXP4g955trjkzt/TG8Y
         THcknB9Yaww/vj0dxjZWi2KERSONm/seU9RRDVHLvJjEDhFO2OadHrm3eZR9LGeC0all
         tXiA6WzOqQAgaA+lEG3qevm96RqrL8HSVzT/6jPuZVWDBs/NrgPbQ5FmmOhmI+4YEIlc
         hV+HWTzo5SbFpk3ZpJXDL11pzVp/1ezmBkIgXwOTS0HiXczUon8P9IbEgeFlRFFDh6Up
         FXEg==
X-Forwarded-Encrypted: i=1; AJvYcCXF71DxbAmX2Lxr0bodbNa7T4FNjI0nrp/kCBMDkzGbzNUYXPySHh89jnFaA8isEb7mVByvHs7G3ygV0mAu8woLDCyBNLXrL6DUe0N4
X-Gm-Message-State: AOJu0YxrsqhNIX0ehO53/IXIQiSCH55sNHnbm324ceTenZgLVlxCRJIy
	Ro/nqJp/QcyLn9Zykpt5/VfAvCgdelxcdjO5cs5Lmu94QG7hvCMcsqYicKiu92fXWRpE/rv+/mt
	mpmbGcg==
X-Google-Smtp-Source: AGHT+IGEqAX/emATsaaiEZo0CjyHsBTzMDzyZiDCfTpuQjNWK8lZ+JMJAWfNDqp+PXNyalsEuaM7HA==
X-Received: by 2002:a05:6512:706:b0:52b:bf8e:ffea with SMTP id 2adb3069b0e04-52ea063f7f7mr1636024e87.40.1720115244724;
        Thu, 04 Jul 2024 10:47:24 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58d75e20c30sm1984686a12.43.2024.07.04.10.47.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 10:47:24 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7523f0870cso101300866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:47:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYa93U36tSJ35TAtc0zLqFt8fwcvH4RnIJI3/j2yPybpV4Ph48+5heKJ71NCpDAPrzZAq90+hGzOi9NLXm9pihlPAVD/HMjkQOxPlG
X-Received: by 2002:a17:906:c1c1:b0:a72:8631:2e01 with SMTP id
 a640c23a62f3a-a77ba7224eemr124424466b.64.1720115243651; Thu, 04 Jul 2024
 10:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZobXdDCYBi8OM-Fo@zx2c4.com> <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
 <CAHk-=wgiqw3q_W-B4faLHXgkDMvz-wdUHYuSweg0LJvKuw0qzg@mail.gmail.com>
In-Reply-To: <CAHk-=wgiqw3q_W-B4faLHXgkDMvz-wdUHYuSweg0LJvKuw0qzg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jul 2024 10:47:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=whmVf0Wj0FMRJtb9ofKtZ30tQFosQ6fNqO6_uEEYXa1CA@mail.gmail.com>
Message-ID: <CAHk-=whmVf0Wj0FMRJtb9ofKtZ30tQFosQ6fNqO6_uEEYXa1CA@mail.gmail.com>
Subject: Re: deconflicting new syscall numbers for 6.11
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jul 2024 at 10:33, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I need a real actual live user that says "I can't just use rdrand and
> my own chacha mixing on top" and explains why having a SSE2 chachacha
> in kernel code exposed as a vdso is so critical, and a magical buffer
> maintained by the kernel.

One final note: the reason I'm so negative about this all is that the
random number subsystem has such an absolutely _horrendous_ history of
two main conflicting issues: people wanting reasonable usable random
numbers on one side, and then the people that discuss what the word
"entropy" means on the other side.

And honestly, I don't want the kernel stuck even *more* in the middle
of that morass. I strongly suspect that one reason why glibc people
would want this is the exact same reason: _they_ don't want to be
stuck in the same padded room with the crazies _either_, so they love
the concept of "somebody else's problem".

So no. I do not think "libc people want this" is an argument at all
for the kernel doing it. Quite the reverse. It's a "pass the hot
potato" thing. Which is why I really really want those real users
standing up and saying "we can't use rdrand and rdtsc and our own
mixing".

                Linus


Return-Path: <linux-kernel+bounces-411563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B419CFBFA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 02:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39A6BB26A39
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 01:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE95418FDA5;
	Sat, 16 Nov 2024 01:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YWKHeP7h"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351C918E351
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731720450; cv=none; b=uiX0Bfc6O4QKDVqeYjfkp8+uUBOw1J0A1v89/fKtOPJN0nOr8Zfnebs3Ru6Vh/FbaTFOLRRhuR0hQZrwb1IgUZu1Hi1mTvl19/D/zcgSc9Sjsqazd1yIF7yiOR/j7FyY/rA3ZJl5qq4m87n7vMC7akr0f2obuGnlA0Tel0BbRyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731720450; c=relaxed/simple;
	bh=bOA4nUo7mfQQkw3JoxTcyaN1uMUcu+dalgd7RW7X650=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hp8dUZfUSKDtM9arXGjR642W0KYQcS0nKHnXNtp4Y81r7nbUJOM3TMdzAmgUI1FNiUPtdgfl44DctsCDeFL9NWpKmu5sLVv39b5aHuX6VF9hvw3zCbe9dzC7q+DwyaavUAeaqrrVdxBrTZ+HkonIXdyv2KXlkzhY63RrlEd3ClM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YWKHeP7h; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so1641835a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731720446; x=1732325246; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CVYMo6RE4YtZC72bkP/PJmu2mQS4HXZjPFfcPWBRsOU=;
        b=YWKHeP7huL/jMWBHDiy9rije2tZVAfTIsbOi7ThQHUkzMKydjUYBfK7e6vTRadyGO5
         5YX2T3WgUiXG62SZSsNM+JGLrS1jnt4tsmOWriBWiRl2aHN1/KUqsKzqho7sBVWzSg4u
         O9eHrKcz/kh151+M14U0iDB2t3dhr6pG20a5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731720446; x=1732325246;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CVYMo6RE4YtZC72bkP/PJmu2mQS4HXZjPFfcPWBRsOU=;
        b=ibuQUaKbLlq60YRuPcfwsp+RHkgiDUwGZ030G3Jb8bmAkq582hDDSkUZSlba1UbqZ4
         QUQsm73S7IoCvRdjb2w8EX4e6S1sYLIwvXqQYqNPgsOnUa7FgPROAKJcG8rpUqK7EcDP
         pwt/34UFioRQDNgTnqqAEoZpazycYmmeuYerJY5Eke0uWC25Fag72gXKkXojtO/nllpE
         HH9Q/bQdTGimrI+Vc03qLXmXVuIaCTsPk4jHpbec7xWr1X0Pn4214mgo+ZKhsA19uYoT
         Qw2pzY1RWCqtBECM7ENtYQXY4RUYl77Mm+FkG37rDQpXK9GnKYjO34j6f+tzIr1CYZZG
         GzfA==
X-Forwarded-Encrypted: i=1; AJvYcCXK/3sj5+TPFbzxAWRo3qt4z4ebSIfzdiAkkiIWZIsxNStkuLoQwuYXStDK2uRZZIXl8a+BRRTqnLyMwvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyAWg+4vzm6a///Ss4pUB+dLs8YOagRC8n5nmQXuA6JweARY8q
	mID1jbk5vvj+1JzYtV7sQRiWENjvtFFVGdD1FBK3vPAH2eUckA8oSMCX6EHb/uMm3UDPZUccVWD
	0TbI=
X-Google-Smtp-Source: AGHT+IHd4Dyq7BgEUche4Gz+glQqU44dJxyFP172QYNSlsGfdIo8oEqij5lDNS1/CHdk1NkshVpAgA==
X-Received: by 2002:a05:6402:1d50:b0:5c9:7dd9:3eda with SMTP id 4fb4d7f45d1cf-5cf8fc163ecmr3616282a12.5.1731720446408;
        Fri, 15 Nov 2024 17:27:26 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79bb329bsm2161057a12.38.2024.11.15.17.27.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 17:27:23 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9e44654ae3so201218666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:27:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUP/UOxuOrefZ6VZAIFz/W+COOrFdy2sZq/3dhLJb/yMs90oSeUyW24h++7X+C/3hD26/+5BVeHW3rFj84=@vger.kernel.org
X-Received: by 2002:a17:907:7f8a:b0:a9a:e91:68c5 with SMTP id
 a640c23a62f3a-aa483454536mr357189766b.33.1731720442701; Fri, 15 Nov 2024
 17:27:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730166635.git.jpoimboe@kernel.org> <82cbb9983fef5ecf6f1cb33661e977172d40a7e6.1730166635.git.jpoimboe@kernel.org>
 <20241029032735.pw3bg64bpneqnfhk@treble.attlocal.net> <76bb85ceeb854e3ab68d87f846515306@AcuMS.aculab.com>
 <20241115230653.hfvzyf3aqqntgp63@jpoimboe>
In-Reply-To: <20241115230653.hfvzyf3aqqntgp63@jpoimboe>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 15 Nov 2024 17:27:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgLCzEwa=S4hZFGeOPjix-1_fDrsqR-QLaBcDM-fgkvhw@mail.gmail.com>
Message-ID: <CAHk-=wgLCzEwa=S4hZFGeOPjix-1_fDrsqR-QLaBcDM-fgkvhw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] x86/uaccess: Avoid barrier_nospec() in 64-bit __get_user()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: David Laight <David.Laight@aculab.com>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Waiman Long <longman@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Mark Rutland <mark.rutland@arm.com>, "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 15:06, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> It's sad that __get_user() is now slower than get_user() on x86, it kind
> of defeats the whole point!

Well, honestly, we've been trying to get away from __get_user() and
__put_user() for a long long time.

With CLAC/STAC, it's been probably a decade or two since __get_user()
and friends were actually a worthwhile optimization, so let's just
strive to get rid of the ones that matter.

So I think the thing to do is

 (a) find out which __get_user() it is that matters so much for that load

Do you have a profile somewhere?

 (b) convert them to use "unsafe_get_user()", with that whole

                if (can_do_masked_user_access())
                        from = masked_user_access_begin(from);
                else if (!user_read_access_begin(from, sizeof(*from)))
                        return -EFAULT;

     sequence before it.

And if it's just a single __get_user() (rather than a sequence of
them), just convert it to get_user().

Hmm?

                Linus


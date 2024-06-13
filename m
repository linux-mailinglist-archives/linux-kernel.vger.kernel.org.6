Return-Path: <linux-kernel+bounces-212431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A1A90605F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 03:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C642282F96
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 01:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385BADF5C;
	Thu, 13 Jun 2024 01:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WYNxuXo/"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E55BB674
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718241822; cv=none; b=YJ/IiEdmwzdnFCu9vELhvY4c8tvfQTqaCrnGiEQJT513uuDUpVyLWivLYh25zSzmuX8gk+F+AUvvhGTtWjmDMu5PF7ivz+TltXKSmQg/B+gdHsWC9dBNHMbJDB0H2zdwaUVKon4vNX2kc3ZlLxVzhB5wwzx/WIdIbPX6x9GJHWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718241822; c=relaxed/simple;
	bh=X3gTgy/Iz8ikW8DHOYtGWGNub2BUS0X96bT3zDguhCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njg4t6trBXw34w5lXxB6hogfwovOahqZrw7+DKyp9UocR/2Ko9yycSLG7cgYGbceK45X8eXHAHhtRgD/frH+xKsPHrJ6QqGd80TzDa1D2hvPCtQn842x/Q3BJJ53nplOUyVo51szXxQZism0N7R4o3Q+mXUuh0HuVsUBndtLOmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WYNxuXo/; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52c84a21c62so601733e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718241818; x=1718846618; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/kwsnoySuK+lTrV2lby34gpq8HpYhI6IyK65Moq3Wr8=;
        b=WYNxuXo/c2E72jLx6aWM6y6cFhT34IYJcUQP1FBtCwULhXxy4Z7wK5V+mNW/j6zVFI
         j1YAXXIPyuwlXodmopIRnBCLutVfDH1PZRUfTbHEHnZcq9PowNNLcYT9pPqAhARYz6V2
         CFZT4d6GDxRt/IPtbdrCBH12r8OQUD6/CV92w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718241818; x=1718846618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kwsnoySuK+lTrV2lby34gpq8HpYhI6IyK65Moq3Wr8=;
        b=Pe3aZTLo02QtOnDfvHlpnwO6aJMztEhsEcU8bqPwE1jA2viCLQev4tzMADrOBQf/2l
         gJExkczG7lzEhS+hkPD5Z34yFl9+FuXkx2eNIpE9MgLLQUXMJD6fufp77F5rsiEfBG6o
         jJNhGUtFpzmQB59h9KqbdLbANLH1fKKBbxsOsnekREmk14hcLlbJwy8JVmhEhdniVozs
         b5GFsvKvR7pa3Hg6pjtgEjgXH/tiltKfkhvPdTqS4ZCDfP2KbrF91wD8YMImbQI8rRK4
         a37miDydT7h4orgbt33gwAhCPSJ05sRyxQRaxsISUvh9E4fBLsUpS1uxPHexMUwSsH3y
         cgKg==
X-Forwarded-Encrypted: i=1; AJvYcCUxN91Mcf3eY7Ap78Hp1Gc0o+5ICx1NkUtmdINLUIrbB6uy2FtlynGFJ+bg/55Dakc8ITOyq22TiyIs0GeMzahG3wxwqgxcSwIbDSvB
X-Gm-Message-State: AOJu0YyF5OtaLMWjBwp6yt9RP0Vwt+9r+78JQZGPoeEp8vVP2aAiRwoT
	jcPuX5yw9UFDc7f6SUlSUTeiPhyOF5wzS9ywxJ6xbgkbpV3YZ1v76lIC0yBWkHjGeMyahh8t+fQ
	+eaj0lw==
X-Google-Smtp-Source: AGHT+IG9rXLYksb0IZ7gVCvQlI7bDmWU5fEWx4CNLzmCqZiNLvswVwttrvtuKeI3eRpUluucuXtJpA==
X-Received: by 2002:ac2:4308:0:b0:52c:8449:d82e with SMTP id 2adb3069b0e04-52c9a3c6c31mr1981358e87.15.1718241818098;
        Wed, 12 Jun 2024 18:23:38 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287ae6esm39491e87.209.2024.06.12.18.23.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 18:23:35 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso4450401fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:23:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXOqiFLMur7RTFpOBmbINohQlXePg8diYjfXgZ9uvir3LzNEkmWOu13E31i/mFgiy8LEvRRrfZ7Gqoyt3EOr7t4NXSpiDHDP1HjuRSl
X-Received: by 2002:a2e:a454:0:b0:2eb:e365:f191 with SMTP id
 38308e7fff4ca-2ebfc9327c1mr19669261fa.15.1718241815089; Wed, 12 Jun 2024
 18:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613001215.648829-1-mjguzik@gmail.com> <20240613001215.648829-2-mjguzik@gmail.com>
In-Reply-To: <20240613001215.648829-2-mjguzik@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 12 Jun 2024 18:23:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
Message-ID: <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] lockref: speculatively spin waiting for the lock to
 be released
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000007a12d061abb598e"

--00000000000007a12d061abb598e
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Jun 2024 at 17:12, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> While I did not try to figure out who transiently took the lock (it was
> something outside of the benchmark), I devised a trivial reproducer
> which triggers the problem almost every time: merely issue "ls" of the
> directory containing the tested file (in this case: "ls /tmp").

So I have no problem with your patch 2/2 - moving the lockref data
structure away from everything else that can be shared read-only makes
a ton of sense independently of anything else.

Except you also randomly increased a retry count in there, which makes no sense.

But this patch 1/2 makes me go "Eww, hacky hacky".

We already *have* the retry loop, it's just that currently it only
covers the cmpxchg failures.

The natural thing to do is to just make the "wait for unlocked" be
part of the same loop.

In fact, I have this memory of trying this originally, and it not
mattering and just making the code uglier, but that may be me
confusing myself. It's a *loong* time ago.

With the attached patch, lockref_get() (to pick one random case) ends
up looking like this:

        mov    (%rdi),%rax
        mov    $0x64,%ecx
  loop:
        test   %eax,%eax
        jne    locked
        mov    %rax,%rdx
        sar    $0x20,%rdx
        add    $0x1,%edx
        shl    $0x20,%rdx
        lock cmpxchg %rdx,(%rdi)
        jne    fail
        // SUCCESS
        ret
  locked:
        pause
        mov    (%rdi),%rax
  fail:
        sub    $0x1,%ecx
        jne    loop

(with the rest being the "take lock and go slow" case).

It seems much better to me to have *one* retry loop that handles both
the causes of failures.

Entirely untested, I only looked at the generated code and it looked
reasonable. The patch may be entirely broken for some random reason I
didn't think of.

And in case you wonder, that 'lockref_locked()' macro I introduce is
purely to make the code more readable. Without it, that one
conditional line ends up being insanely long, the macro is there just
to break things up into slightly more manageable chunks.

Mind testing this approach instead?

                 Linus

--00000000000007a12d061abb598e
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lxckssrl0>
X-Attachment-Id: f_lxckssrl0

IGxpYi9sb2NrcmVmLmMgfCAxNCArKysrKysrKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbGliL2xvY2tyZWYuYyBi
L2xpYi9sb2NrcmVmLmMKaW5kZXggMmFmZTRjNWQ4OTE5Li43MGYzODYyMTkwMWIgMTAwNjQ0Ci0t
LSBhL2xpYi9sb2NrcmVmLmMKKysrIGIvbGliL2xvY2tyZWYuYwpAQCAtNCw2ICs0LDkgQEAKIAog
I2lmIFVTRV9DTVBYQ0hHX0xPQ0tSRUYKIAorI2RlZmluZSBsb2NrcmVmX2xvY2tlZChsKSBcCisJ
dW5saWtlbHkoIWFyY2hfc3Bpbl92YWx1ZV91bmxvY2tlZCgobCkubG9jay5ybG9jay5yYXdfbG9j
aykpCisKIC8qCiAgKiBOb3RlIHRoYXQgdGhlICJjbXB4Y2hnKCkiIHJlbG9hZHMgdGhlICJvbGQi
IHZhbHVlIGZvciB0aGUKICAqIGZhaWx1cmUgY2FzZS4KQEAgLTEzLDcgKzE2LDEyIEBACiAJc3Ry
dWN0IGxvY2tyZWYgb2xkOwkJCQkJCQlcCiAJQlVJTERfQlVHX09OKHNpemVvZihvbGQpICE9IDgp
OwkJCQkJCVwKIAlvbGQubG9ja19jb3VudCA9IFJFQURfT05DRShsb2NrcmVmLT5sb2NrX2NvdW50
KTsJCQlcCi0Jd2hpbGUgKGxpa2VseShhcmNoX3NwaW5fdmFsdWVfdW5sb2NrZWQob2xkLmxvY2su
cmxvY2sucmF3X2xvY2spKSkgeyAgCVwKKwlkbyB7CQkJCQkJCQkJXAorCQlpZiAobG9ja3JlZl9s
b2NrZWQob2xkKSkgewkJCQkJXAorCQkJY3B1X3JlbGF4KCk7CQkJCQkJXAorCQkJb2xkLmxvY2tf
Y291bnQgPSBSRUFEX09OQ0UobG9ja3JlZi0+bG9ja19jb3VudCk7CVwKKwkJCWNvbnRpbnVlOwkJ
CQkJCVwKKwkJfQkJCQkJCQkJXAogCQlzdHJ1Y3QgbG9ja3JlZiBuZXcgPSBvbGQ7CQkJCQlcCiAJ
CUNPREUJCQkJCQkJCVwKIAkJaWYgKGxpa2VseSh0cnlfY21weGNoZzY0X3JlbGF4ZWQoJmxvY2ty
ZWYtPmxvY2tfY291bnQsCQlcCkBAIC0yMSw5ICsyOSw3IEBACiAJCQkJCQkgbmV3LmxvY2tfY291
bnQpKSkgewkJXAogCQkJU1VDQ0VTUzsJCQkJCQlcCiAJCX0JCQkJCQkJCVwKLQkJaWYgKCEtLXJl
dHJ5KQkJCQkJCQlcCi0JCQlicmVhazsJCQkJCQkJXAotCX0JCQkJCQkJCQlcCisJfSB3aGlsZSAo
LS1yZXRyeSk7CQkJCQkJCVwKIH0gd2hpbGUgKDApCiAKICNlbHNlCg==
--00000000000007a12d061abb598e--


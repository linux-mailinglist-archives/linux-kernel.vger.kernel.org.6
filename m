Return-Path: <linux-kernel+bounces-417535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B2C9D5549
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839DD280E23
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008681CB32C;
	Thu, 21 Nov 2024 22:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YQUT36Mi"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3323914387B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 22:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732227397; cv=none; b=hufQOfhBKFStHN4VHWwuzrvueJDcgD3x3pdT/ghpGcdtL55g0ndkuYltGTQDTodKeSqMGCJhui1kH/Hex3kiTMsSdsXMclJHklpixNlYwO08y28StKEV6ImdeBBu6Nn9HKuHoWiTg3OUiUet0KVbL+mKKGMOem1q5TY/OwGkaP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732227397; c=relaxed/simple;
	bh=6S/SPv/7gaiejO7e/agg9U41SZjXoN61ULPizCNyjgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSRoR7A5IURCX2UthpGGPhI9KThPWYyh5T+CiM7gpsKl2ZJDBa9fWZcY6Cyg+cEgIlTcdIHnNlLIRsz/gBFtBCNgNbLP4N9mtPtJJXG0sdHeG8z7y/jrcuo9ByYyeCVFVXJXbKFvIPAC1WfWHTZLRnSJzUVPcSaWOkPAQa6Vv/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YQUT36Mi; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cefa22e9d5so1624336a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732227393; x=1732832193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nHdNuBjlvdOe2QnFjbNTu7sydbB8hdVPIUAgNsAEiuc=;
        b=YQUT36MifERLKLhgLXtpEaA7s/I7YGkxYbr0qRW0J5BedmntTSoGt9YZ4LHbFJESP0
         iihwbCCV4sLP7+51HZQafe05vl4yobRhe+/XU6lfHURjzA65C4Zuy2hQaqR6GdaO2yT1
         lK00eKb/ZztHBGSLpTxef/D3YXOAY3WZuW7YE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732227393; x=1732832193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHdNuBjlvdOe2QnFjbNTu7sydbB8hdVPIUAgNsAEiuc=;
        b=cGGekLEGxx4TP34GuV9BQhZvvz3wIIhug6/oeckVD9THvh4V0akUzI/6FOIeR8bDyH
         K7DY1WlPynS6nRt6RXNjRy+0VU41lk6eqqQQuMoUa3Sv6QPLyEkdB9aFoh1lPMQBSUcm
         Po0oeQlT0m/x5VaIruRUVUoY+TXux8zITvoWUZa7MJdU2xG6595qhUFfFrkRAhc2GyqR
         diV2bnwh/fSJvnwWA7q4wvEdp2gkHZS8wROXQ14D/VYn2A2J3C+avNt1JEaDchRRleYA
         TOxAeoQZ8cQJhK+IE0dSRTY4h4gpbjO03vL8jobogvZhEmayyuPWuYko/FfVrVwY2CmF
         83Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUsGBehtoQAjoY6Bo/mCGMW9+tWvgWqvkfi01NcLUWbfcznQ350vE9UtIH5cThQEMmMKJWKhvAWzfNg1n4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJt6/rq9656Rb1yC4Jm5ZDKJXqJlLGFcjHVFcrH+RZqgOiEoXD
	TeRBtnJ12WSa7UWa+0l4/tQHuOaItKybJN+tx2YeRKbxQGYHtR0XFHxwp6dz2VuMAobpf2jOHP5
	uFzA=
X-Gm-Gg: ASbGnctnfgR7wA8IYE7jOH9aIxAeeEL1Sf4OKFikUPzYvRAGWYSYEunr+0dbg3a3MBf
	5jdxTskzlUSHeLdwnjii7HCZS8PY5HA84X7xBWhKqByQR+sAD/nmV5Guz9nR0xq55/YDPwLoez1
	dhHQXURJu7E0q6p1oNc0zSkoHZfBWS9w7P92JuTGdltZLT46q4h5WnxSVDf2272Jbdp92xDnfeF
	zOsMIRS+cIc3Kh0sSs7c+f1BHbTzTQvd0eEw4bwvALuSOTKMeopKm80n0q15KjbJxU36UHldat2
	zsbaX8PEQjvCO0E26T4odaJ4
X-Google-Smtp-Source: AGHT+IGizK5vF/Alxczto5DZ2RjZaaOYmVi0WtW5tQFvGS/Mb7Cktzqo5c17+geSlbUr9Zzmrsto8Q==
X-Received: by 2002:a05:6402:1ec9:b0:5cf:ac4d:d992 with SMTP id 4fb4d7f45d1cf-5d0205f9525mr269036a12.9.1732227393209;
        Thu, 21 Nov 2024 14:16:33 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01f9c2dd2sm117801a12.18.2024.11.21.14.16.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 14:16:32 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso221564466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:16:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXCpyboGUshQ7BL1+JDq0mXPldogcgOIghTlC4bdnkLHYUB6fssGBmT+lM52VYLnhYCk9yoO0PfF0yCR0U=@vger.kernel.org
X-Received: by 2002:a17:906:1ba2:b0:aa5:1208:8a5b with SMTP id
 a640c23a62f3a-aa51208aa06mr5028966b.18.1732227389319; Thu, 21 Nov 2024
 14:16:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730166635.git.jpoimboe@kernel.org> <82cbb9983fef5ecf6f1cb33661e977172d40a7e6.1730166635.git.jpoimboe@kernel.org>
 <20241029032735.pw3bg64bpneqnfhk@treble.attlocal.net> <76bb85ceeb854e3ab68d87f846515306@AcuMS.aculab.com>
 <20241115230653.hfvzyf3aqqntgp63@jpoimboe> <CAHk-=wgLCzEwa=S4hZFGeOPjix-1_fDrsqR-QLaBcDM-fgkvhw@mail.gmail.com>
 <20241121214011.iiup2fdwsys7hhts@jpoimboe>
In-Reply-To: <20241121214011.iiup2fdwsys7hhts@jpoimboe>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Nov 2024 14:16:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wigHm2J4LkUL1=y_H8zGwM0JsK2CrWyLNbz9fvXfbaBQA@mail.gmail.com>
Message-ID: <CAHk-=wigHm2J4LkUL1=y_H8zGwM0JsK2CrWyLNbz9fvXfbaBQA@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="0000000000003663d40627739e4a"

--0000000000003663d40627739e4a
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 13:40, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> The profile is showing futex_get_value_locked():

Ahh.

> That has several callers, so we can probably just use get_user() there?

Yeah, that's the simplest thing. That thing isn't even some inline
function, so the real cost is the call.

That said, exactly because it's not inlined, and calls are expensive,
and this is apparently really critical, we can just do it with the
full "unsafe_get_user()" model.

It's not so complicated. The attached patch is untested, but I did
check that it generates almost perfect code:

    mov    %gs:0x0,%rax                 # current
    incl   0x1a9c(%rax)                 # current->pagefault_disable++
    movabs $0x123456789abcdef,%rcx      # magic virtual address size
    cmp    %rsi,%rcx                    # address masking
    sbb    %rcx,%rcx
    or     %rsi,%rcx
    stac                                # enable user space acccess
    mov    (%rcx),%ecx                  # get the value
    clac                                # disable user space access
    decl   0x1a9c(%rax)                 # current->pagefault_disable--
    mov    %ecx,(%rdi)                  # save the value
    xor    %eax,%eax                    # return 0
    ret

(with the error case for the page fault all out-of-line).

So this should be _faster_ than the old __get_user(), because while
the address masking is not needed, it's cheaper than the function call
used to be and the error handling is better.

If you can test this and verify that it actually help, I'll take it as
a patch. Consider it signed-off after testing.

> Also, is there any harm in speeding up __get_user()?  It still has ~80
> callers and it's likely to be slowing down things we don't know about.

How would you speed it up?  We definitely can't replace the fence with
addressing tricks. So we can't just replace it with "get_user()",
because of those horrid architecture-specific kernel uses.

Now, we could possibly say "just remove the fence in __get_user()
entirely", but that would involve moving it to access_ok().

And then it wouldn't actually speed anything up (except the horrid
architecture-specific kernel uses that then don't call access_ok() at
all - and we don't care about *those*).

               Linus

--0000000000003663d40627739e4a
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_m3rvg3zg0>
X-Attachment-Id: f_m3rvg3zg0

IGtlcm5lbC9mdXRleC9jb3JlLmMgfCAyNSArKysrKysrKysrKysrKysrKysrKysrLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9rZXJuZWwvZnV0ZXgvY29yZS5jIGIva2VybmVsL2Z1dGV4L2NvcmUuYwppbmRleCAzMjZiZmU2
NTQ5ZDcuLjllMWJkNzY2NTJkOCAxMDA2NDQKLS0tIGEva2VybmVsL2Z1dGV4L2NvcmUuYworKysg
Yi9rZXJuZWwvZnV0ZXgvY29yZS5jCkBAIC00NjQsMTMgKzQ2NCwzMiBAQCBpbnQgZnV0ZXhfY21w
eGNoZ192YWx1ZV9sb2NrZWQodTMyICpjdXJ2YWwsIHUzMiBfX3VzZXIgKnVhZGRyLCB1MzIgdXZh
bCwgdTMyIG5ldwogCiBpbnQgZnV0ZXhfZ2V0X3ZhbHVlX2xvY2tlZCh1MzIgKmRlc3QsIHUzMiBf
X3VzZXIgKmZyb20pCiB7Ci0JaW50IHJldDsKKwl1MzIgdmFsOwogCiAJcGFnZWZhdWx0X2Rpc2Fi
bGUoKTsKLQlyZXQgPSBfX2dldF91c2VyKCpkZXN0LCBmcm9tKTsKKwkvKgorCSAqIFRoZSB1c2Vy
IGFkZHJlc3MgaGFzIGJlZW4gdmVyaWZpZWQgYnkgZ2V0X2Z1dGV4X2tleSgpLAorCSAqIGFuZCBm
dXRleF9jbXB4Y2hnX3ZhbHVlX2xvY2tlZCgpIHRydXN0cyB0aGF0LCBidXQgd2UgZG8KKwkgKiBu
b3QgaGF2ZSBhbnkgb3RoZXIgd2F5cyB0byBkbyBpdCB3ZWxsLCBzbyB3ZSBkbyB0aGUKKwkgKiBm
dWxsIHVzZXIgYWNjZXNzIHNvbmcgYW5kIGRhbmNlIGhlcmUuCisJICovCisJaWYgKGNhbl9kb19t
YXNrZWRfdXNlcl9hY2Nlc3MoKSkKKwkJZnJvbSA9IG1hc2tlZF91c2VyX2FjY2Vzc19iZWdpbihm
cm9tKTsKKwllbHNlIGlmICghdXNlcl9yZWFkX2FjY2Vzc19iZWdpbihmcm9tLCBzaXplb2YoKmZy
b20pKSkKKwkJZ290byBlbmFibGVfYW5kX2Vycm9yOworCisJdW5zYWZlX2dldF91c2VyKHZhbCwg
ZnJvbSwgRWZhdWx0KTsKKwl1c2VyX2FjY2Vzc19lbmQoKTsKIAlwYWdlZmF1bHRfZW5hYmxlKCk7
CiAKLQlyZXR1cm4gcmV0ID8gLUVGQVVMVCA6IDA7CisJKmRlc3QgPSB2YWw7CisJcmV0dXJuIDA7
CisKK0VmYXVsdDoKKwl1c2VyX2FjY2Vzc19lbmQoKTsKK2VuYWJsZV9hbmRfZXJyb3I6CisJcGFn
ZWZhdWx0X2VuYWJsZSgpOworCXJldHVybiAtRUZBVUxUOwogfQogCiAvKioK
--0000000000003663d40627739e4a--


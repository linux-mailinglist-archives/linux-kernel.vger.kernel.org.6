Return-Path: <linux-kernel+bounces-418702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4BF9D647D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 20:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD2D281469
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823771DFDA8;
	Fri, 22 Nov 2024 19:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AAZTGONd"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EC416DEA2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732302812; cv=none; b=Z4hz+UsLUeLdJNFzFiswmCLlgxtWJ799TSjkJM6zWqSxciaypfQ3xuAA2QC6ToN2biQG9HNEhkEvyEeZKvJ7bvLIP3L67PQRkyEnsn4ymwoTGCtI1Jb8h4LtWh0BdiinyKMiYRY4r0Gd/4M89eqSHP9XCGHANqg50ZPn3Buhe1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732302812; c=relaxed/simple;
	bh=dgyEhrlaPQ2ub3AMvxx/ydZtfXHaLswM4vKb567kyv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWd4VoL0Jmt0GlM/zNaJ8k6oi4bMFfWVYMpr4iI6F4UnW0D6k5DN67hmPYUAYbAFhwCWCFXhvdmMW4NNO0jCphDuo+ItzOKthlmb/vTW6JFwQcLzgXAqZPlTMqwBG+RkF3i2p8xvOzwdzy9sY5O7hDLVQoIB8Kc+t8BkMLP+B40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AAZTGONd; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffb0bbe9c8so802261fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732302808; x=1732907608; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V9rknCNYPDePTJ0RvnpJE5IJL2DelNX7GA8OrQV0NdI=;
        b=AAZTGONdnUJv6K4yD9e4EfAvt1wMIX+B3p1Wm0HDFwbBGEhi6ht0QNqhf/rCoH9ZMn
         JmgmVc3/Q94FI5fw/Ef6oLs72on8qy6WAxA/2d3P156+VZcbDnkgE4RFrsadwcajujRz
         /8Uo8mMPMXMg5uSm8OkXE5l95Y1w8QlWfx73E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732302808; x=1732907608;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9rknCNYPDePTJ0RvnpJE5IJL2DelNX7GA8OrQV0NdI=;
        b=t3hQ7AuPyvmEsDydbQZVvxIOEJckwqEwfcFIHJBCrt2ChOl+yBj4UbzBL4VJz41yOG
         mHBiMAWHzpWr6zWMi8gpTYcACLkAnjh6xJkEnpLhJZRSx7TbEsJch/WbUfjv2x3FMFTe
         xKHO8iVlhcQawz0wjkiqmoPfNLOhX24du1G3aXJLrCNu5pG3BMgVT22PjOxH+aBzoLWV
         fRy1HOba9gaSBMS5RSJ3Fb2hdxSLZq4xw7Ze6IH0EV1f2/S39735e+WmIn5l0QJ6cLQs
         Qw9ARNsOOA/kmVw91QniKSvU1XLsVKj+uCxaJos4ZiOVgW4LIhwFkMihnWtoJpGZsLuZ
         YEDA==
X-Forwarded-Encrypted: i=1; AJvYcCVpoO7DskM276LC4E7YeIdP9gurxXdQ6wb2LJi/iMJhIS0Z0r5DBRHaeJ6/C7bYjboy766C11u4mHoKfXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye9Z0E/FpGQyX+GJVbPU40SL51HN0aFqquifddoCVlWeV0DB4M
	FSaMBc0pgdSORtaO5dqA0noX5hxwO2usUNXQMF5e/2CFOUfMni1JrAovKawimxONNNV+mm50dx/
	3kUhe7Q==
X-Gm-Gg: ASbGncuKWf34evANVG0tkEsimtlmFjN9JZxGwVKXeXNr0rshKhthRh/649duAfxgDdi
	QB1BoqF6ZDigcHG0cx/cmHLeoHmEHe8LwTjtbwACFziLEisKifJd4H73CLhH7+r5E6LlccIfSjl
	MF8MiW4AfTYSKjncF8zDP1CkH3ZzokEp9lE5nUPCM1q/yCcfxVbAQ88nbv5Mqhgg3bEEZldQfqt
	yRCsu3jGuNwEzEwcBqygUztXYKcODpwDCVLCckjwFZDbAtBg8pAYtDhF0AzoGB/srXSlvEzYx30
	zr5IWbJHWGKJWwmdrgoQ50WD9Fd3
X-Google-Smtp-Source: AGHT+IFk4uT3y/3SD5t/SnehHVDKR4kGiABVeinjM0myHr0/pYSychm1xbpzOX9khn7Clkn3tRWGvg==
X-Received: by 2002:a05:651c:160b:b0:2ff:a414:f120 with SMTP id 38308e7fff4ca-2ffa71bcb37mr23197681fa.38.1732302807977;
        Fri, 22 Nov 2024 11:13:27 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa4d16f84sm4687391fa.20.2024.11.22.11.13.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 11:13:24 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffa974b2b0so9968141fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:13:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzVKi25lnZM3vTBZBI+AGjB/xtxq2jhZVpJWZq/lctVHUggxKHnhcnSjEPDNdHZ9ThMSaKzMbxOIGIpyc=@vger.kernel.org
X-Received: by 2002:a05:6512:b97:b0:53d:d12c:2f02 with SMTP id
 2adb3069b0e04-53dd36a0421mr2548987e87.18.1732302803270; Fri, 22 Nov 2024
 11:13:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730166635.git.jpoimboe@kernel.org> <82cbb9983fef5ecf6f1cb33661e977172d40a7e6.1730166635.git.jpoimboe@kernel.org>
 <20241029032735.pw3bg64bpneqnfhk@treble.attlocal.net> <76bb85ceeb854e3ab68d87f846515306@AcuMS.aculab.com>
 <20241115230653.hfvzyf3aqqntgp63@jpoimboe> <CAHk-=wgLCzEwa=S4hZFGeOPjix-1_fDrsqR-QLaBcDM-fgkvhw@mail.gmail.com>
 <20241121214011.iiup2fdwsys7hhts@jpoimboe> <CAHk-=wigHm2J4LkUL1=y_H8zGwM0JsK2CrWyLNbz9fvXfbaBQA@mail.gmail.com>
 <20241122001223.t4uywacusrplpefq@jpoimboe> <CAHk-=whm4fEYrzrrRrqEhELLFz2xNCMT9be+J0uiR_EwXwa0DA@mail.gmail.com>
 <20241122031115.5aasuktqrp2sidfj@jpoimboe> <CAHk-=wjJt49tgtmYv42bXU3h0Txb+mQZEOHseahA4EcK6s=BxA@mail.gmail.com>
In-Reply-To: <CAHk-=wjJt49tgtmYv42bXU3h0Txb+mQZEOHseahA4EcK6s=BxA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Nov 2024 11:13:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiL0TepguMNaR65ZdkkiBEoi4hTE7PwG3bBO1c5SOXmWw@mail.gmail.com>
Message-ID: <CAHk-=wiL0TepguMNaR65ZdkkiBEoi4hTE7PwG3bBO1c5SOXmWw@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="0000000000003c694e0627852d0c"

--0000000000003c694e0627852d0c
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 19:57, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, that was a long way of saying: I really think we should just
> special-case the (few) important cases that get reported. Because any
> *big* improvements will come not from just inlining.

Looking around at the futex code some more, I note:

 - the cmpxchg case and futex ops use an explicit barrier too, which is bad

 - we'd actually be better off inlining not just the user access, but
the whole futex_get_value_locked(), because then the compiler will be
able to do CSE on the user address masking, and only do it once
(several places do multiple different futex_get_value_locked() calls).

iow, I think the fix for the futex case ends up being a patch
something like the attached.

[ Annoyingly, we need "can_do_masked_user_access()" even on x86,
because the 32-bit case doesn't do the address masking trick ]

I've only compiled it so far, about to actually boot into it. Pray for me,

               Linus

--0000000000003c694e0627852d0c
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_m3t4cmwq0>
X-Attachment-Id: f_m3t4cmwq0

IGFyY2gveDg2L2luY2x1ZGUvYXNtL2Z1dGV4LmggfCAgOCArKysrLS0KIGtlcm5lbC9mdXRleC9j
b3JlLmMgICAgICAgICAgfCAyMiAtLS0tLS0tLS0tLS0tLS0tLQoga2VybmVsL2Z1dGV4L2Z1dGV4
LmggICAgICAgICB8IDU5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tCiAzIGZpbGVzIGNoYW5nZWQsIDYzIGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2Z1dGV4LmggYi9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9mdXRleC5oCmluZGV4IDk5ZDM0NWI2ODZmYS4uNmUyNDU4MDg4ODAwIDEwMDY0NAot
LS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9mdXRleC5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUv
YXNtL2Z1dGV4LmgKQEAgLTQ4LDcgKzQ4LDkgQEAgZG8gewkJCQkJCQkJXAogc3RhdGljIF9fYWx3
YXlzX2lubGluZSBpbnQgYXJjaF9mdXRleF9hdG9taWNfb3BfaW51c2VyKGludCBvcCwgaW50IG9w
YXJnLCBpbnQgKm92YWwsCiAJCXUzMiBfX3VzZXIgKnVhZGRyKQogewotCWlmICghdXNlcl9hY2Nl
c3NfYmVnaW4odWFkZHIsIHNpemVvZih1MzIpKSkKKwlpZiAoY2FuX2RvX21hc2tlZF91c2VyX2Fj
Y2VzcygpKQorCQl1YWRkciA9IG1hc2tlZF91c2VyX2FjY2Vzc19iZWdpbih1YWRkcik7CisJZWxz
ZSBpZiAoIXVzZXJfYWNjZXNzX2JlZ2luKHVhZGRyLCBzaXplb2YodTMyKSkpCiAJCXJldHVybiAt
RUZBVUxUOwogCiAJc3dpdGNoIChvcCkgewpAQCAtODQsNyArODYsOSBAQCBzdGF0aWMgaW5saW5l
IGludCBmdXRleF9hdG9taWNfY21weGNoZ19pbmF0b21pYyh1MzIgKnV2YWwsIHUzMiBfX3VzZXIg
KnVhZGRyLAogewogCWludCByZXQgPSAwOwogCi0JaWYgKCF1c2VyX2FjY2Vzc19iZWdpbih1YWRk
ciwgc2l6ZW9mKHUzMikpKQorCWlmIChjYW5fZG9fbWFza2VkX3VzZXJfYWNjZXNzKCkpCisJCXVh
ZGRyID0gbWFza2VkX3VzZXJfYWNjZXNzX2JlZ2luKHVhZGRyKTsKKwllbHNlIGlmICghdXNlcl9h
Y2Nlc3NfYmVnaW4odWFkZHIsIHNpemVvZih1MzIpKSkKIAkJcmV0dXJuIC1FRkFVTFQ7CiAJYXNt
IHZvbGF0aWxlKCJcbiIKIAkJIjE6XHQiIExPQ0tfUFJFRklYICJjbXB4Y2hnbCAlMywgJTJcbiIK
ZGlmZiAtLWdpdCBhL2tlcm5lbC9mdXRleC9jb3JlLmMgYi9rZXJuZWwvZnV0ZXgvY29yZS5jCmlu
ZGV4IDMyNmJmZTY1NDlkNy4uOTgzM2ZkYjYzZTM5IDEwMDY0NAotLS0gYS9rZXJuZWwvZnV0ZXgv
Y29yZS5jCisrKyBiL2tlcm5lbC9mdXRleC9jb3JlLmMKQEAgLTQ1MSwyOCArNDUxLDYgQEAgc3Ry
dWN0IGZ1dGV4X3EgKmZ1dGV4X3RvcF93YWl0ZXIoc3RydWN0IGZ1dGV4X2hhc2hfYnVja2V0ICpo
YiwgdW5pb24gZnV0ZXhfa2V5ICoKIAlyZXR1cm4gTlVMTDsKIH0KIAotaW50IGZ1dGV4X2NtcHhj
aGdfdmFsdWVfbG9ja2VkKHUzMiAqY3VydmFsLCB1MzIgX191c2VyICp1YWRkciwgdTMyIHV2YWws
IHUzMiBuZXd2YWwpCi17Ci0JaW50IHJldDsKLQotCXBhZ2VmYXVsdF9kaXNhYmxlKCk7Ci0JcmV0
ID0gZnV0ZXhfYXRvbWljX2NtcHhjaGdfaW5hdG9taWMoY3VydmFsLCB1YWRkciwgdXZhbCwgbmV3
dmFsKTsKLQlwYWdlZmF1bHRfZW5hYmxlKCk7Ci0KLQlyZXR1cm4gcmV0OwotfQotCi1pbnQgZnV0
ZXhfZ2V0X3ZhbHVlX2xvY2tlZCh1MzIgKmRlc3QsIHUzMiBfX3VzZXIgKmZyb20pCi17Ci0JaW50
IHJldDsKLQotCXBhZ2VmYXVsdF9kaXNhYmxlKCk7Ci0JcmV0ID0gX19nZXRfdXNlcigqZGVzdCwg
ZnJvbSk7Ci0JcGFnZWZhdWx0X2VuYWJsZSgpOwotCi0JcmV0dXJuIHJldCA/IC1FRkFVTFQgOiAw
OwotfQotCiAvKioKICAqIHdhaXRfZm9yX293bmVyX2V4aXRpbmcgLSBCbG9jayB1bnRpbCB0aGUg
b3duZXIgaGFzIGV4aXRlZAogICogQHJldDogb3duZXIncyBjdXJyZW50IGZ1dGV4IGxvY2sgc3Rh
dHVzCmRpZmYgLS1naXQgYS9rZXJuZWwvZnV0ZXgvZnV0ZXguaCBiL2tlcm5lbC9mdXRleC9mdXRl
eC5oCmluZGV4IDhiMTk1ZDA2ZjRlOC4uMzIzNTcyMDE0YjMyIDEwMDY0NAotLS0gYS9rZXJuZWwv
ZnV0ZXgvZnV0ZXguaAorKysgYi9rZXJuZWwvZnV0ZXgvZnV0ZXguaApAQCAtNiw2ICs2LDcgQEAK
ICNpbmNsdWRlIDxsaW51eC9ydG11dGV4Lmg+CiAjaW5jbHVkZSA8bGludXgvc2NoZWQvd2FrZV9x
Lmg+CiAjaW5jbHVkZSA8bGludXgvY29tcGF0Lmg+CisjaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5o
PgogCiAjaWZkZWYgQ09ORklHX1BSRUVNUFRfUlQKICNpbmNsdWRlIDxsaW51eC9yY3V3YWl0Lmg+
CkBAIC0yMjUsMTAgKzIyNiw2NCBAQCBleHRlcm4gYm9vbCBfX2Z1dGV4X3dha2VfbWFyayhzdHJ1
Y3QgZnV0ZXhfcSAqcSk7CiBleHRlcm4gdm9pZCBmdXRleF93YWtlX21hcmsoc3RydWN0IHdha2Vf
cV9oZWFkICp3YWtlX3EsIHN0cnVjdCBmdXRleF9xICpxKTsKIAogZXh0ZXJuIGludCBmYXVsdF9p
bl91c2VyX3dyaXRlYWJsZSh1MzIgX191c2VyICp1YWRkcik7Ci1leHRlcm4gaW50IGZ1dGV4X2Nt
cHhjaGdfdmFsdWVfbG9ja2VkKHUzMiAqY3VydmFsLCB1MzIgX191c2VyICp1YWRkciwgdTMyIHV2
YWwsIHUzMiBuZXd2YWwpOwotZXh0ZXJuIGludCBmdXRleF9nZXRfdmFsdWVfbG9ja2VkKHUzMiAq
ZGVzdCwgdTMyIF9fdXNlciAqZnJvbSk7CiBleHRlcm4gc3RydWN0IGZ1dGV4X3EgKmZ1dGV4X3Rv
cF93YWl0ZXIoc3RydWN0IGZ1dGV4X2hhc2hfYnVja2V0ICpoYiwgdW5pb24gZnV0ZXhfa2V5ICpr
ZXkpOwogCitzdGF0aWMgaW5saW5lIGludCBmdXRleF9jbXB4Y2hnX3ZhbHVlX2xvY2tlZCh1MzIg
KmN1cnZhbCwgdTMyIF9fdXNlciAqdWFkZHIsIHUzMiB1dmFsLCB1MzIgbmV3dmFsKQoreworCWlu
dCByZXQ7CisKKwlwYWdlZmF1bHRfZGlzYWJsZSgpOworCXJldCA9IGZ1dGV4X2F0b21pY19jbXB4
Y2hnX2luYXRvbWljKGN1cnZhbCwgdWFkZHIsIHV2YWwsIG5ld3ZhbCk7CisJcGFnZWZhdWx0X2Vu
YWJsZSgpOworCisJcmV0dXJuIHJldDsKK30KKworLyoKKyAqIFRoaXMgZG9lcyBhIHBsYWluIGF0
b21pYyB1c2VyIHNwYWNlIHJlYWQsIGFuZCB0aGUgdXNlciBwb2ludGVyIGhhcworICogYWxyZWFk
eSBiZWVuIHZlcmlmaWVkIGVhcmxpZXIgYnkgZ2V0X2Z1dGV4X2tleSgpIHRvIGJlIGJvdGggYWxp
Z25lZAorICogYW5kIGFjdHVhbGx5IGluIHVzZXIgc3BhY2UsIGp1c3QgbGlrZSBmdXRleF9hdG9t
aWNfY21weGNoZ19pbmF0b21pYygpLgorICoKKyAqIFdlIHN0aWxsIHdhbnQgdG8gYXZvaWQgYW55
IHNwZWN1bGF0aW9uLCBhbmQgd2hpbGUgX19nZXRfdXNlcigpIGlzCisgKiB0aGUgdHJhZGl0aW9u
YWwgbW9kZWwgZm9yIHRoaXMsIGl0J3MgYWN0dWFsbHkgc2xvd2VyIHRoZW4gZG9pbmcKKyAqIHRo
aXMgbWFudWFsbHkgdGhlc2UgZGF5cy4KKyAqCisgKiBXZSBjb3VsZCBqdXN0IGhhdmUgYSBwZXIt
YXJjaGl0ZWN0dXJlIHNwZWNpYWwgZnVuY3Rpb24gZm9yIGl0LAorICogdGhlIHNhbWUgd2F5IHdl
IGRvIGZ1dGV4X2F0b21pY19jbXB4Y2hnX2luYXRvbWljKCksIGJ1dCByYXRoZXIKKyAqIHRoYW4g
Zm9yY2UgZXZlcnlib2R5IHRvIGRvIHRoYXQsIHdyaXRlIGl0IG91dCBsb25nLWhhbmQgdXNpbmcK
KyAqIHRoZSBsb3ctbGV2ZWwgdXNlci1hY2Nlc3MgaW5mcmFzdHJ1Y3R1cmUuCisgKgorICogVGhp
cyBsb29rcyBhIGJpdCBvdmVya2lsbCwgYnV0IGdlbmVyYWxseSBqdXN0IHJlc3VsdHMgaW4gYSBj
b3VwbGUKKyAqIG9mIGluc3RydWN0aW9ucy4KKyAqLworc3RhdGljIF9fYWx3YXlzX2lubGluZSBp
bnQgZnV0ZXhfcmVhZF9pbmF0b21pYyh1MzIgKmRlc3QsIHUzMiBfX3VzZXIgKmZyb20pCit7CisJ
dTMyIHZhbDsKKworCWlmIChjYW5fZG9fbWFza2VkX3VzZXJfYWNjZXNzKCkpCisJCWZyb20gPSBt
YXNrZWRfdXNlcl9hY2Nlc3NfYmVnaW4oZnJvbSk7CisJZWxzZSBpZiAoIXVzZXJfcmVhZF9hY2Nl
c3NfYmVnaW4oZnJvbSwgc2l6ZW9mKCpmcm9tKSkpCisJCXJldHVybiAtRUZBVUxUOworCXVuc2Fm
ZV9nZXRfdXNlcih2YWwsIGZyb20sIEVmYXVsdCk7CisJdXNlcl9hY2Nlc3NfZW5kKCk7CisJKmRl
c3QgPSB2YWw7CisJcmV0dXJuIDA7CitFZmF1bHQ6CisJdXNlcl9hY2Nlc3NfZW5kKCk7CisJcmV0
dXJuIC1FRkFVTFQ7Cit9CisKK3N0YXRpYyBpbmxpbmUgaW50IGZ1dGV4X2dldF92YWx1ZV9sb2Nr
ZWQodTMyICpkZXN0LCB1MzIgX191c2VyICpmcm9tKQoreworCWludCByZXQ7CisKKwlwYWdlZmF1
bHRfZGlzYWJsZSgpOworCXJldCA9IGZ1dGV4X3JlYWRfaW5hdG9taWMoZGVzdCwgZnJvbSk7CisJ
cGFnZWZhdWx0X2VuYWJsZSgpOworCisJcmV0dXJuIHJldDsKK30KKwogZXh0ZXJuIHZvaWQgX19m
dXRleF91bnF1ZXVlKHN0cnVjdCBmdXRleF9xICpxKTsKIGV4dGVybiB2b2lkIF9fZnV0ZXhfcXVl
dWUoc3RydWN0IGZ1dGV4X3EgKnEsIHN0cnVjdCBmdXRleF9oYXNoX2J1Y2tldCAqaGIpOwogZXh0
ZXJuIGludCBmdXRleF91bnF1ZXVlKHN0cnVjdCBmdXRleF9xICpxKTsK
--0000000000003c694e0627852d0c--


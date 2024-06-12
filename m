Return-Path: <linux-kernel+bounces-212324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9F7905E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60B371F26717
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9AD12CDB2;
	Wed, 12 Jun 2024 22:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rxw9oclt"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C7E12CD8C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718231150; cv=none; b=ZbpoufP/DMPy35Vps64Zg9+3t1KBgkB16R4iTpZBWaUZE7gxP3mrFe6fZ/AjPhf0u5t21tON3rcuUcVDJ6OZ7c3u4fnriR6GlTihD1NsRGzG1fWZPG0ngIPa2IUAVBky9cVf+UoS2KeNg6I+54bvZ+WsG1s1JQ2WlBl9jurprfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718231150; c=relaxed/simple;
	bh=A10PWhJaScq0T+vZsTNJwKbAbZ7nlQlEUFiAqdpeFdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIcjdYjBN+X9v+HrPWHyFk8YDj1i1dU1GXJpp8tIp4KvXc+mDYrcgtxq2LTbHTv4JKTyyi2/45aBo2FSTKrSuzIhPHjsURaUa1A3W62J2pFIk2k1EDKQgpHe5UsjZEDEuoKP3io/UoK+51RKZocoZmnlG+vZ7hwggh40lvkYCFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rxw9oclt; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so2963191fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718231146; x=1718835946; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9VcA85nBfAJ5pqIO2zRB3DwRkzoK3bQ4ckXVVcF3yZw=;
        b=Rxw9ocltB/ynl+qwWTT4qGURDF8bo4fEzmEo6uqkTfKSA3VQqKAHI1VP9VgCkc5Veh
         SHxF9Zo4jya2XiePVrdvrrgPwIjWVZMA620rQ/MbLGdGdTwayFQ8SOL/ondvXXR+JLmv
         nhTIv8nMnha48tGzv2lJWwc5iZqhD40R8ILmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718231146; x=1718835946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VcA85nBfAJ5pqIO2zRB3DwRkzoK3bQ4ckXVVcF3yZw=;
        b=G16UHOF3K0RiVIF/l4qjb5JD6mrQ4L8XGzlcjHkk/XEz7hkLAQcGz+9vQQNGgObR/s
         TKdedIzsHPi8NaY0/wJh/96HgfFJULDG0RbCWqDw4Ro41GWX4dRuLGHCVMzOGSQhr2Aa
         8oA4IJm4CNx0rR0vy4D7GJZS4ELYWvJatnJ0HcZEjfHrMUavZOjFm03Z9LcoD0eB7IMx
         t7W2/Kbv9DksPZDxy20/MET4afX3uYdOmmXQaTHlIFOpbu1rLlEr3LXfBBLaYUEYnUE/
         3aWjDLDVosAIoVNnQYteU4JBRdLFOdN7kcTXaHNNHmIVlFV646U4STasShkdnCJ/P1KD
         Op3g==
X-Forwarded-Encrypted: i=1; AJvYcCUzHoMhXZ2qQM5hNbHAm0SOZMmAk2UTHF88is93C0kCgql/jsT/Y2LkB0ALNVvvRHumVh/u6aQw9DfC8wXNYGPOfqqCY2nqxmdwb07y
X-Gm-Message-State: AOJu0YzwdTIKHo094c0ppnUXUXMOjug/MDXAjPs+ZbGazdgF9aj1pvLo
	IFuD637GWgCU8Bz0TgX2+LFlrKtOWqmuo81J6c46ArpIAqHudS1Ieur3gRSzQt8kjeJllueJsgf
	GfDozNA==
X-Google-Smtp-Source: AGHT+IF8P/S0LZsv04jGTDP1O5Hph3dT60Fc3XRSHUgLBM1oMCr4SB9RMFAa/yXjOH9mcfTJn5J19Q==
X-Received: by 2002:a2e:9819:0:b0:2ec:389:ad72 with SMTP id 38308e7fff4ca-2ec0389addemr3937561fa.39.1718231145773;
        Wed, 12 Jun 2024 15:25:45 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05bf44b8sm137521fa.16.2024.06.12.15.25.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 15:25:44 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5295eb47b48so462437e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:25:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/rcMTEbC+IC55i25IJ0YQWtXSt7PEOrGQjCxzZMt8Dz0YTaEkZmTjTazSKHiY6NFIRLge7cuDUALdd157MTJrbWtM+JF2jzthnVOH
X-Received: by 2002:a05:6512:31cf:b0:52c:a22e:8ffc with SMTP id
 2adb3069b0e04-52ca22e933fmr120725e87.58.1718231143517; Wed, 12 Jun 2024
 15:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610204821.230388-1-torvalds@linux-foundation.org>
 <Zmnr3BjBkV4JxsIj@J2N7QTR9R3.cambridge.arm.com> <CAHk-=wg1AffeA6HLwZG9gbnFUACuzT-pyzao6BfQeZiCFt752Q@mail.gmail.com>
In-Reply-To: <CAHk-=wg1AffeA6HLwZG9gbnFUACuzT-pyzao6BfQeZiCFt752Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 12 Jun 2024 15:25:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh9_a757XQKJZyuWXM8yEZcSCCqzdnzxxFU3LEQcukxdQ@mail.gmail.com>
Message-ID: <CAHk-=wh9_a757XQKJZyuWXM8yEZcSCCqzdnzxxFU3LEQcukxdQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] arm64 / x86-64: low-level code generation issues
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000f4689f061ab8dc01"

--000000000000f4689f061ab8dc01
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Jun 2024 at 13:02, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'll send out a new version of the arm64 patches with the KCSAN build
> failure fixed (with the simple no-op save/restore functions by making
> KCSAN and SW PAN mutually incompatible), and with the virtual address
> fix you pointed out in the other email.

Actually, unless somebody really wants to see the whole series again,
here's just the diff between the end result of the series.

The actual changes are done in the relevant commits (ie the "asm goto
for get_user()" one for the KCSAN issue, and the "arm64 runtime
constant" commit for the I$ fixup).

Holler if you want to see the full series again.

It might be worth noting that I initially made the arm64 KCSAN support
have a "depend on !ARM64_SW_TTBR0_PAN" condition, but decided that
it's actually better to do it the other way around, and make
ARM64_SW_TTBR0_PAN depend on KCSAN not being enabled.

That way we're basically more eagerly disabling the thing that should
go away, and we're also having the KCSAN code be checked for
allmodconfig builds.

But hey, it's a judgement call.

               Linus

--000000000000f4689f061ab8dc01
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lxcec86u0>
X-Attachment-Id: f_lxcec86u0

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvS2NvbmZpZyBiL2FyY2gvYXJtNjQvS2NvbmZpZwppbmRl
eCA1ZDkxMjU5ZWU3YjUuLmI2ZTg5MjAzNjRkZSAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9LY29u
ZmlnCisrKyBiL2FyY2gvYXJtNjQvS2NvbmZpZwpAQCAtMTY0OSw2ICsxNjQ5LDcgQEAgY29uZmln
IFJPREFUQV9GVUxMX0RFRkFVTFRfRU5BQkxFRAogCiBjb25maWcgQVJNNjRfU1dfVFRCUjBfUEFO
CiAJYm9vbCAiRW11bGF0ZSBQcml2aWxlZ2VkIEFjY2VzcyBOZXZlciB1c2luZyBUVEJSMF9FTDEg
c3dpdGNoaW5nIgorCWRlcGVuZHMgb24gIUtDU0FOCiAJaGVscAogCSAgRW5hYmxpbmcgdGhpcyBv
cHRpb24gcHJldmVudHMgdGhlIGtlcm5lbCBmcm9tIGFjY2Vzc2luZwogCSAgdXNlci1zcGFjZSBt
ZW1vcnkgZGlyZWN0bHkgYnkgcG9pbnRpbmcgVFRCUjBfRUwxIHRvIGEgcmVzZXJ2ZWQKZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vcnVudGltZS1jb25zdC5oIGIvYXJjaC9hcm02
NC9pbmNsdWRlL2FzbS9ydW50aW1lLWNvbnN0LmgKaW5kZXggOGRjODNkNDhhMjAyLi5kZGU0YzEx
ZWMwZDUgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vcnVudGltZS1jb25zdC5o
CisrKyBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vcnVudGltZS1jb25zdC5oCkBAIC01MCw2ICs1
MCwxMiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgX19ydW50aW1lX2ZpeHVwXzE2KF9fbGUzMiAqcCwg
dW5zaWduZWQgaW50IHZhbCkKIAkqcCA9IGNwdV90b19sZTMyKGluc24pOwogfQogCitzdGF0aWMg
aW5saW5lIHZvaWQgX19ydW50aW1lX2ZpeHVwX2NhY2hlcyh2b2lkICp3aGVyZSwgdW5zaWduZWQg
aW50IGluc25zKQoreworCXVuc2lnbmVkIGxvbmcgdmEgPSAodW5zaWduZWQgbG9uZyl3aGVyZTsK
KwljYWNoZXNfY2xlYW5faW52YWxfcG91KHZhLCB2YSArIDQqaW5zbnMpOworfQorCiBzdGF0aWMg
aW5saW5lIHZvaWQgX19ydW50aW1lX2ZpeHVwX3B0cih2b2lkICp3aGVyZSwgdW5zaWduZWQgbG9u
ZyB2YWwpCiB7CiAJX19sZTMyICpwID0gbG1fYWxpYXMod2hlcmUpOwpAQCAtNTcsNyArNjMsNyBA
QCBzdGF0aWMgaW5saW5lIHZvaWQgX19ydW50aW1lX2ZpeHVwX3B0cih2b2lkICp3aGVyZSwgdW5z
aWduZWQgbG9uZyB2YWwpCiAJX19ydW50aW1lX2ZpeHVwXzE2KHArMSwgdmFsID4+IDE2KTsKIAlf
X3J1bnRpbWVfZml4dXBfMTYocCsyLCB2YWwgPj4gMzIpOwogCV9fcnVudGltZV9maXh1cF8xNihw
KzMsIHZhbCA+PiA0OCk7Ci0JY2FjaGVzX2NsZWFuX2ludmFsX3BvdSgodW5zaWduZWQgbG9uZylw
LCAodW5zaWduZWQgbG9uZykocCArIDQpKTsKKwlfX3J1bnRpbWVfZml4dXBfY2FjaGVzKHdoZXJl
LCA0KTsKIH0KIAogLyogSW1tZWRpYXRlIHZhbHVlIGlzIDYgYml0cyBzdGFydGluZyBhdCBiaXQg
IzE2ICovCkBAIC02OCw3ICs3NCw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBfX3J1bnRpbWVfZml4
dXBfc2hpZnQodm9pZCAqd2hlcmUsIHVuc2lnbmVkIGxvbmcgdmFsKQogCWluc24gJj0gMHhmZmMw
ZmZmZjsKIAlpbnNuIHw9ICh2YWwgJiA2MykgPDwgMTY7CiAJKnAgPSBjcHVfdG9fbGUzMihpbnNu
KTsKLQljYWNoZXNfY2xlYW5faW52YWxfcG91KCh1bnNpZ25lZCBsb25nKXAsICh1bnNpZ25lZCBs
b25nKShwICsgMSkpOworCV9fcnVudGltZV9maXh1cF9jYWNoZXMod2hlcmUsIDEpOwogfQogCiBz
dGF0aWMgaW5saW5lIHZvaWQgcnVudGltZV9jb25zdF9maXh1cCh2b2lkICgqZm4pKHZvaWQgKiwg
dW5zaWduZWQgbG9uZyksCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL3VhY2Nl
c3MuaCBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vdWFjY2Vzcy5oCmluZGV4IDM3YWJkODkzYzZl
ZS4uMWYyMTE5MGQ0ZGI1IDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL3VhY2Nl
c3MuaAorKysgYi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL3VhY2Nlc3MuaApAQCAtNDI0LDYgKzQy
NCwxNCBAQCBzdGF0aWMgX19tdXN0X2NoZWNrIF9fYWx3YXlzX2lubGluZSBib29sIHVzZXJfYWNj
ZXNzX2JlZ2luKGNvbnN0IHZvaWQgX191c2VyICpwdAogI2RlZmluZSB1bnNhZmVfZ2V0X3VzZXIo
eCwgcHRyLCBsYWJlbCkgXAogCV9fcmF3X2dldF9tZW0oImxkdHIiLCB4LCB1YWNjZXNzX21hc2tf
cHRyKHB0ciksIGxhYmVsLCBVKQogCisvKgorICogS0NTQU4gdXNlcyB0aGVzZSB0byBzYXZlIGFu
ZCByZXN0b3JlIHR0YnIgc3RhdGUuCisgKiBXZSBkbyBub3Qgc3VwcG9ydCBLQ1NBTiB3aXRoIEFS
TTY0X1NXX1RUQlIwX1BBTiwgc28KKyAqIHRoZXkgYXJlIG5vLW9wcy4KKyAqLworc3RhdGljIGlu
bGluZSB1bnNpZ25lZCBsb25nIHVzZXJfYWNjZXNzX3NhdmUodm9pZCkgeyByZXR1cm4gMDsgfQor
c3RhdGljIGlubGluZSB2b2lkIHVzZXJfYWNjZXNzX3Jlc3RvcmUodW5zaWduZWQgbG9uZyBlbmFi
bGVkKSB7IH0KKwogLyoKICAqIFdlIHdhbnQgdGhlIHVuc2FmZSBhY2Nlc3NvcnMgdG8gYWx3YXlz
IGJlIGlubGluZWQgYW5kIHVzZQogICogdGhlIGVycm9yIGxhYmVscyAtIHRodXMgdGhlIG1hY3Jv
IGdhbWVzLgo=
--000000000000f4689f061ab8dc01--


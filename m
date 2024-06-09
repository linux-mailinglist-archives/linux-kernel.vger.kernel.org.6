Return-Path: <linux-kernel+bounces-207243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DF3901451
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 05:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B33281E29
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 03:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9857FB65E;
	Sun,  9 Jun 2024 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SIHebmCA"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FC36139
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 03:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717902715; cv=none; b=bzB8eWd7he31e9TplK9hFCph+5yjgmtdxgteALq06b7uRrgPBYeMR3qv6EVHuzEXLoOsWEBnRdpgbBq06KTZVs3E0wCpQvNqL6MN7ilJlBBQEyvoDIqkgXvac1URAvYSLtYQZ/RjovhRGd4h4T5NhbRRCfnh8Ii/kJ6J1YPgpJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717902715; c=relaxed/simple;
	bh=Ro+ub4ifFKSZnb+ejWJ/xsVvSkhd//wMcVYHKFO+dzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEvt3V+Mbw8MyKS1bPQOtr8EobOMWWExSjNPTlaCdtDqo3bz0FfCqdCENO5OeaOReQ+EdEjXUTj3X1N0xyFzjPTla9Y0k+uNFGwscHb085OyZLQ+KKafhut+Jm/l7Ktfk3ZZ3sEYyIuWKBVXuKnQOyO4dfLCuNZsSG+LCqI+Bhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SIHebmCA; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52962423ed8so3945428e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 20:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717902711; x=1718507511; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A7dUoCR65nMgbX7LmvgfZWZMvg21MHj7Khg3DNyY50c=;
        b=SIHebmCAAjHeKOmVHFnO0nUH0PHiJuJyZbym03QbwX5JYwryUZEVAuxrmfaD2w6SUH
         wDi3ocoR0RGcVCFiLPeSwC/7CjS2fdnEEpDwVffhACpIEYL2/EiRAdgrtKeSYwDwWUHo
         NPSUtvvt7rNzOXCkKNrQQsP1gZFqinTiKVQk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717902711; x=1718507511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7dUoCR65nMgbX7LmvgfZWZMvg21MHj7Khg3DNyY50c=;
        b=ukldvfQrrZ7dbbZ4JWtY7D1V4ZI7br0Nn3ZPG5b2zW2RFDv60IYtHyUg1FYiXchaTM
         xHxc0E0k5kwJU2qaeydnHhRUa7pZvz1pm/+42uGWpwPjQDtXR3jCxqmc6d6EUrLmIQ9g
         608pXKCFEA4CR7tEUJ2Xe/CFMj+L1tghX1Li/T2U+wwkl6v2TzOLfIfZB2oYbQggk5iq
         hGxdqyP940WQAW5B+Pgp72zT6rF5f3tQrJbPxr2IaZmHxmbhefrWwIldoXy04N6HoWiu
         o9vQODSFb9bt0SPfNxKByaGt5nGntbFN9b61o77f/83mNHRzgjxLqC49LBStT2KMZZ4Y
         QnNw==
X-Gm-Message-State: AOJu0Yzx2BndqPk4jMbKSzY71mbOX7uHwo6zaA0JbcTydFjdIq6LyF0W
	4NGPE0dLUs0V8EUnSSsGLZqhS4RoEBNSAdkJSn9Fm6n2W5+cC8UpaMUOMGKpk7SsJ4Wrk+aE7Rj
	3ER0=
X-Google-Smtp-Source: AGHT+IEZUFhx9Q8rPcDoQbMjWdi1wRl0sLXV8j77b93t0aNnH0B4Mxkp8wH+VkDBVjfe5lJokB5vIQ==
X-Received: by 2002:a05:6512:130b:b0:52b:bf8f:5690 with SMTP id 2adb3069b0e04-52bbf8f5813mr4266921e87.52.1717902711308;
        Sat, 08 Jun 2024 20:11:51 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f102c4494sm105029266b.112.2024.06.08.20.11.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jun 2024 20:11:50 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57c76497cefso267023a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 20:11:50 -0700 (PDT)
X-Received: by 2002:a17:906:f858:b0:a6e:f869:dfcd with SMTP id
 a640c23a62f3a-a6ef869e146mr209955566b.6.1717902709744; Sat, 08 Jun 2024
 20:11:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608193504.429644-2-torvalds@linux-foundation.org> <CAHk-=wjiJvGW70_A93oN_f48J0pn4MeVbWVmBPBiTh2XiSpwpg@mail.gmail.com>
In-Reply-To: <CAHk-=wjiJvGW70_A93oN_f48J0pn4MeVbWVmBPBiTh2XiSpwpg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 8 Jun 2024 20:11:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPSnaCczHp3Jy=kFjfqJa7MTQg6jht_FwZCxOnpsi4Vw@mail.gmail.com>
Message-ID: <CAHk-=wiPSnaCczHp3Jy=kFjfqJa7MTQg6jht_FwZCxOnpsi4Vw@mail.gmail.com>
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="000000000000c61ba5061a6c64c4"

--000000000000c61ba5061a6c64c4
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Jun 2024 at 13:55, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Think of this patch mostly as a "look, adding another architecture
> isn't *that* hard - even if the constant value is spread out in the
> instructions".

.. and here's a version that actually works. It wasn't that bad.

Or rather, it wouldn't have been that bad had I not spent *ages*
debugging a stupid cut-and-paste error where I instead of writing
words 0..3 of the 64-bit large constant generation, wrote words 0..2
and then overwrote word 2 (again) with the data that should have gone
into word 3. Causing the top 32 bits to be all wonky. Oops. Literally.

That stupid typo caused like two hours of wasted time.

But anyway, this patch actually works for me. It still doesn't do any
I$/D$ flushing, because it's not needed in practice, but it *should*
probably do that.

             Linus

--000000000000c61ba5061a6c64c4
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-arm64-add-runtime-const-support.patch"
Content-Disposition: attachment; 
	filename="0001-arm64-add-runtime-const-support.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lx6yvkv70>
X-Attachment-Id: f_lx6yvkv70

RnJvbSA4ODc4MjFlMWNmMzJjNTA1ZDJiYzlmYjlkY2VlNDVjZjFlMmY2NWU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFNhdCwgOCBKdW4gMjAyNCAxMzoyMjozMSAtMDcwMApTdWJqZWN0OiBb
UEFUQ0hdIGFybTY0OiBhZGQgJ3J1bnRpbWUgY29uc3QnIHN1cHBvcnQKClNpZ25lZC1vZmYtYnk6
IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tCiBhcmNo
L2FybTY0L2luY2x1ZGUvYXNtL3J1bnRpbWUtY29uc3QuaCB8IDc1ICsrKysrKysrKysrKysrKysr
KysrKysrKysrCiBhcmNoL2FybTY0L2tlcm5lbC92bWxpbnV4Lmxkcy5TICAgICAgICB8ICAzICsr
CiAyIGZpbGVzIGNoYW5nZWQsIDc4IGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCBh
cmNoL2FybTY0L2luY2x1ZGUvYXNtL3J1bnRpbWUtY29uc3QuaAoKZGlmZiAtLWdpdCBhL2FyY2gv
YXJtNjQvaW5jbHVkZS9hc20vcnVudGltZS1jb25zdC5oIGIvYXJjaC9hcm02NC9pbmNsdWRlL2Fz
bS9ydW50aW1lLWNvbnN0LmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAw
Li5hYjVmOThiYzk0MmUKLS0tIC9kZXYvbnVsbAorKysgYi9hcmNoL2FybTY0L2luY2x1ZGUvYXNt
L3J1bnRpbWUtY29uc3QuaApAQCAtMCwwICsxLDc1IEBACisvKiBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMCAqLworI2lmbmRlZiBfQVNNX1JVTlRJTUVfQ09OU1RfSAorI2RlZmluZSBf
QVNNX1JVTlRJTUVfQ09OU1RfSAorCisjZGVmaW5lIHJ1bnRpbWVfY29uc3RfcHRyKHN5bSkgKHsJ
CQkJXAorCXR5cGVvZihzeW0pIF9fcmV0OwkJCQkJXAorCWFzbSgiMTpcdCIJCQkJCQlcCisJCSJt
b3Z6ICUwLCAjMHhjZGVmXG5cdCIJCQkJXAorCQkibW92ayAlMCwgIzB4ODlhYiwgbHNsICMxNlxu
XHQiCQkJXAorCQkibW92ayAlMCwgIzB4NDU2NywgbHNsICMzMlxuXHQiCQkJXAorCQkibW92ayAl
MCwgIzB4MDEyMywgbHNsICM0OFxuXHQiCQkJXAorCQkiLnB1c2hzZWN0aW9uIHJ1bnRpbWVfcHRy
XyIgI3N5bSAiLFwiYVwiXG5cdCIJXAorCQkiLmxvbmcgMWIgLSAuXG5cdCIJCQkJXAorCQkiLnBv
cHNlY3Rpb24iCQkJCQlcCisJCToiPXIiIChfX3JldCkpOwkJCQkJXAorCV9fcmV0OyB9KQorCisj
ZGVmaW5lIHJ1bnRpbWVfY29uc3Rfc2hpZnRfcmlnaHRfMzIodmFsLCBzeW0pICh7CQlcCisJdW5z
aWduZWQgbG9uZyBfX3JldDsJCQkJCVwKKwlhc20oIjE6XHQiCQkJCQkJXAorCQkibHNyICV3MCwl
dzEsIzEyXG5cdCIJCQkJXAorCQkiLnB1c2hzZWN0aW9uIHJ1bnRpbWVfc2hpZnRfIiAjc3ltICIs
XCJhXCJcblx0IglcCisJCSIubG9uZyAxYiAtIC5cblx0IgkJCQlcCisJCSIucG9wc2VjdGlvbiIJ
CQkJCVwKKwkJOiI9ciIgKF9fcmV0KQkJCQkJXAorCQk6InIiICgwdSsodmFsKSkpOwkJCQlcCisJ
X19yZXQ7IH0pCisKKyNkZWZpbmUgcnVudGltZV9jb25zdF9pbml0KHR5cGUsIHN5bSwgdmFsdWUp
IGRvIHsJXAorCWV4dGVybiBzMzIgX19zdGFydF9ydW50aW1lXyMjdHlwZSMjXyMjc3ltW107CVwK
KwlleHRlcm4gczMyIF9fc3RvcF9ydW50aW1lXyMjdHlwZSMjXyMjc3ltW107CVwKKwlydW50aW1l
X2NvbnN0X2ZpeHVwKF9fcnVudGltZV9maXh1cF8jI3R5cGUsCVwKKwkJKHVuc2lnbmVkIGxvbmcp
KHZhbHVlKSwgCQlcCisJCV9fc3RhcnRfcnVudGltZV8jI3R5cGUjI18jI3N5bSwJCVwKKwkJX19z
dG9wX3J1bnRpbWVfIyN0eXBlIyNfIyNzeW0pOwkJXAorfSB3aGlsZSAoMCkKKworLy8gMTYtYml0
IGltbWVkaWF0ZSBmb3Igd2lkZSBtb3ZlIChtb3Z6IGFuZCBtb3ZrKSBpbiBiaXRzIDUuLjIwCitz
dGF0aWMgaW5saW5lIHZvaWQgX19ydW50aW1lX2ZpeHVwXzE2KHVuc2lnbmVkIGludCAqcCwgdW5z
aWduZWQgaW50IHZhbCkKK3sKKwl1bnNpZ25lZCBpbnQgaW5zbiA9ICpwOworCWluc24gJj0gMHhm
ZmUwMDAxZjsKKwlpbnNuIHw9ICh2YWwgJiAweGZmZmYpIDw8IDU7CisJKnAgPSBpbnNuOworfQor
CitzdGF0aWMgaW5saW5lIHZvaWQgX19ydW50aW1lX2ZpeHVwX3B0cih2b2lkICp3aGVyZSwgdW5z
aWduZWQgbG9uZyB2YWwpCit7CisJdW5zaWduZWQgaW50ICpwID0gbG1fYWxpYXMod2hlcmUpOwor
CV9fcnVudGltZV9maXh1cF8xNihwLCB2YWwpOworCV9fcnVudGltZV9maXh1cF8xNihwKzEsIHZh
bCA+PiAxNik7CisJX19ydW50aW1lX2ZpeHVwXzE2KHArMiwgdmFsID4+IDMyKTsKKwlfX3J1bnRp
bWVfZml4dXBfMTYocCszLCB2YWwgPj4gNDgpOworfQorCisvLyBJbW1lZGlhdGUgdmFsdWUgaXMg
NSBiaXRzIHN0YXJ0aW5nIGF0IGJpdCAjMTYKK3N0YXRpYyBpbmxpbmUgdm9pZCBfX3J1bnRpbWVf
Zml4dXBfc2hpZnQodm9pZCAqd2hlcmUsIHVuc2lnbmVkIGxvbmcgdmFsKQoreworCXVuc2lnbmVk
IGludCAqcCA9IGxtX2FsaWFzKHdoZXJlKTsKKwl1bnNpZ25lZCBpbnQgaW5zbiA9ICpwOworCWlu
c24gJj0gMHhmZmMwZmZmZjsKKwlpbnNuIHw9ICh2YWwgJiA2MykgPDwgMTY7CisJKnAgPSBpbnNu
OworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgcnVudGltZV9jb25zdF9maXh1cCh2b2lkICgqZm4p
KHZvaWQgKiwgdW5zaWduZWQgbG9uZyksCisJdW5zaWduZWQgbG9uZyB2YWwsIHMzMiAqc3RhcnQs
IHMzMiAqZW5kKQoreworCXdoaWxlIChzdGFydCA8IGVuZCkgeworCQlmbigqc3RhcnQgKyAodm9p
ZCAqKXN0YXJ0LCB2YWwpOworCQlzdGFydCsrOworCX0KK30KKworI2VuZGlmCmRpZmYgLS1naXQg
YS9hcmNoL2FybTY0L2tlcm5lbC92bWxpbnV4Lmxkcy5TIGIvYXJjaC9hcm02NC9rZXJuZWwvdm1s
aW51eC5sZHMuUwppbmRleCA3NTVhMjJkNGY4NDAuLjU1YThlMzEwZWExMiAxMDA2NDQKLS0tIGEv
YXJjaC9hcm02NC9rZXJuZWwvdm1saW51eC5sZHMuUworKysgYi9hcmNoL2FybTY0L2tlcm5lbC92
bWxpbnV4Lmxkcy5TCkBAIC0yNjQsNiArMjY0LDkgQEAgU0VDVElPTlMKIAkJRVhJVF9EQVRBCiAJ
fQogCisJUlVOVElNRV9DT05TVChzaGlmdCwgZF9oYXNoX3NoaWZ0KQorCVJVTlRJTUVfQ09OU1Qo
cHRyLCBkZW50cnlfaGFzaHRhYmxlKQorCiAJUEVSQ1BVX1NFQ1RJT04oTDFfQ0FDSEVfQllURVMp
CiAJSFlQRVJWSVNPUl9QRVJDUFVfU0VDVElPTgogCi0tIAoyLjQ1LjEKCg==
--000000000000c61ba5061a6c64c4--


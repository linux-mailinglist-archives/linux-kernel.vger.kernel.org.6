Return-Path: <linux-kernel+bounces-275218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 830C49481FE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38115280E00
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632A2169AD0;
	Mon,  5 Aug 2024 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gfe2xn4a"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF74115ECE8
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722884148; cv=none; b=kQhPXvztOwV3ohySjRJ0hf9lTHIfQPqiuZzXEAg5b7H4OMaFKhJZc4kgLE9+1qCQ5POkP5Hhs+SoPKTBIJMc1KO02o7SbLnlAV+yQmDd38BfmMvVnFvQhQxnLaIeHm1LgcX5tH48fKKhl+sMh916PJh5ueC8uqtD+Ji8wkBkOa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722884148; c=relaxed/simple;
	bh=+RXiaX3iYK0UfkU6Mzxlq6Aau3UDy+Ror9Grq5rFShU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3GnvvY4u1YCzRywLH6ZylU4nTslkbNWi+O7fvTOLKde792zweQgzX4mPs6B3JFfI8jF0oZeqhAcdgZ51Ogj45aU3mTvZVPZKmw9pZyeIJBbLSXmAeqUVUKxhfdaokqJoHxWog1MW73ldjkIwK8qt5y3DzsogWCFznj+77/RtaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gfe2xn4a; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a8e73b29cso906433466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 11:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722884144; x=1723488944; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tyvQPXOot/jroH3JmT/WaEXHZ1voWo5O/ydZzohEKJQ=;
        b=gfe2xn4aNM2sZynbllJoU4KpbsAoH/lgZglY8tATUe5/HQ8+yJ9yfWfPaig+emukXv
         HQv31fmIv99A7UCqBjU6yDvpEj/hJePmTQe0Fzy9g/lX4N/M/GNWX77Yi4VaIfYsGcYW
         elNS7h4cA2UbRb261kYDTz9JoRPs4+ilgVRsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722884144; x=1723488944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tyvQPXOot/jroH3JmT/WaEXHZ1voWo5O/ydZzohEKJQ=;
        b=cLD2B9rUVPmCO/YJnB4b2nfFIod5RQpUcQA3Zuo8DcpXOcJWsv2J7+a3FfNrkR3TOk
         YAlM4xhy1pmoJefX9gPvBbYw5Geg+d7t0mYfy+u8rs0coJSs7Ydz8KLkT2djJ3zZyERd
         d4CZ/GqPkfxo0z96DuDzEHC6AX6Ew+gk8Xa347ZgXHVfx0j+fcu+ir10aun9sI51Z/AM
         uKl2GMVZT7lRvCA4CZiloQFjqb54/LQnA1Z7x3R7XO+h1yqnTawJ8kSrKCqEpr0kDVXQ
         cu3+xAGhblG2JrkJ+vMAsqiK5yPS0K+C2tK6/SJWiCZUhRcMOOkGoDhHyF+ChWbATrR9
         asDA==
X-Forwarded-Encrypted: i=1; AJvYcCVWwfh0HuKLVcu5qkyiKFOcu2stntaxsFjtQ2jdvZw0FsVouQzl8GPm08xqY+Aoe9MlIbOqkqpdH5L9xpaGE5rrdGlHNvn4Hzzvbuoo
X-Gm-Message-State: AOJu0Yzlq6ZjKWYDalR1crcytTxqyNGZ2lAWxCxs89IkDqKpV/L0QlF8
	zxNA/LPjimrVTHKrbpd8bRsJ6c8u81AKGdJSFjAX67AS7gQQVTqaleLD8gvDQMvtBELHOL83IPG
	D7gI=
X-Google-Smtp-Source: AGHT+IGDMJcmPmKMtgNKRLv6fDX8BnwJs87LgyBRPJMdiS7DJfxWJ0uZTXzUreB73puDp0ruzvoPpA==
X-Received: by 2002:a17:907:a0c8:b0:a7a:cf39:ae73 with SMTP id a640c23a62f3a-a7dc510800cmr863947566b.64.1722884143895;
        Mon, 05 Aug 2024 11:55:43 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0c7ebsm481008466b.65.2024.08.05.11.55.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 11:55:42 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a156557029so15564329a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 11:55:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWktE30wZ1ToHJgpP3F9M16lBbI96vUAd40boOuJdQUZeapz7CTs1mH/yGfyS/VfBWFUk+7BKOwz5pRH+YLyk4bOI4Lc81WKLOq0WdJ
X-Received: by 2002:aa7:d34e:0:b0:5a2:7f47:c729 with SMTP id
 4fb4d7f45d1cf-5b7f3bcfee4mr9218233a12.9.1722884141890; Mon, 05 Aug 2024
 11:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408041602.caa0372-oliver.sang@intel.com> <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com> <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
In-Reply-To: <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 11:55:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
Message-ID: <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Jeff Xu <jeffxu@google.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Pedro Falcato <pedro.falcato@gmail.com>, kernel test robot <oliver.sang@intel.com>, 
	Jeff Xu <jeffxu@chromium.org>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Dave Hansen <dave.hansen@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Guenter Roeck <groeck@chromium.org>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Amer Al Shanawany <amer.shanawany@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: multipart/mixed; boundary="00000000000044bb81061ef439ea"

--00000000000044bb81061ef439ea
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 11:11, Jeff Xu <jeffxu@google.com> wrote:
>
> One thing that you can't walk around is that can_modify_mm must be
> called prior to arch_unmap, that means in-place check for the munmap
> is not possible.

Actually, we should move 'arch_unmap()'.

There is only one user of it, and it's pretty pointless.

(Ok, there are two users - x86 also has an 'arch_unmap()', but it's empty).

The reason I say that the current user of arch_unmap() is pointless is
because this is what the powerpc user does:

  static inline void arch_unmap(struct mm_struct *mm,
                                unsigned long start, unsigned long end)
  {
        unsigned long vdso_base = (unsigned long)mm->context.vdso;

        if (start <= vdso_base && vdso_base < end)
                mm->context.vdso = NULL;
  }

and that would make sense if we didn't have an actual 'vma' that
matched the vdso. But we do.

I think this code may predate the whole "create a vma for the vdso"
code. Or maybe it was just always confused.

Anyway, what the code *should* do is that we should just have a
->close() function for special mappings, and call that in
special_mapping_close().

This is an ENTIRELY UNTESTED patch that gets rid of this horrendous wart.

Michael / Nick / Christophe? Note that I didn't even compile-test this
on x86-64, much less on powerpc.

So please consider this a "maybe something like this" patch, but that
'arch_unmap()' really is pretty nasty.

Oh, and there was a bug in the error path of the powerpc vdso setup
code anyway. The patch fixes that too, although considering the
entirely untested nature of it, the "fixes" is laughably optimistic.

                 Linus

--00000000000044bb81061ef439ea
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lzhcoox80>
X-Attachment-Id: f_lzhcoox80

IGFyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9tbXVfY29udGV4dC5oIHwgIDkgLS0tLS0tLS0tCiBh
cmNoL3Bvd2VycGMva2VybmVsL3Zkc28uYyAgICAgICAgICAgICB8IDEyICsrKysrKysrKysrLQog
YXJjaC94ODYvaW5jbHVkZS9hc20vbW11X2NvbnRleHQuaCAgICAgfCAgNSAtLS0tLQogaW5jbHVk
ZS9hc20tZ2VuZXJpYy9tbV9ob29rcy5oICAgICAgICAgfCAxMSArKystLS0tLS0tLQogaW5jbHVk
ZS9saW51eC9tbV90eXBlcy5oICAgICAgICAgICAgICAgfCAgMiArKwogbW0vbW1hcC5jICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAxNSArKysrKystLS0tLS0tLS0KIDYgZmlsZXMgY2hh
bmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMzIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJj
aC9wb3dlcnBjL2luY2x1ZGUvYXNtL21tdV9jb250ZXh0LmggYi9hcmNoL3Bvd2VycGMvaW5jbHVk
ZS9hc20vbW11X2NvbnRleHQuaAppbmRleCAzN2JmZmEwZjc5MTguLmEzMzRhMTM2ODg0OCAxMDA2
NDQKLS0tIGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL21tdV9jb250ZXh0LmgKKysrIGIvYXJj
aC9wb3dlcnBjL2luY2x1ZGUvYXNtL21tdV9jb250ZXh0LmgKQEAgLTI2MCwxNSArMjYwLDYgQEAg
c3RhdGljIGlubGluZSB2b2lkIGVudGVyX2xhenlfdGxiKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLAog
CiBleHRlcm4gdm9pZCBhcmNoX2V4aXRfbW1hcChzdHJ1Y3QgbW1fc3RydWN0ICptbSk7CiAKLXN0
YXRpYyBpbmxpbmUgdm9pZCBhcmNoX3VubWFwKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLAotCQkJICAg
ICAgdW5zaWduZWQgbG9uZyBzdGFydCwgdW5zaWduZWQgbG9uZyBlbmQpCi17Ci0JdW5zaWduZWQg
bG9uZyB2ZHNvX2Jhc2UgPSAodW5zaWduZWQgbG9uZyltbS0+Y29udGV4dC52ZHNvOwotCi0JaWYg
KHN0YXJ0IDw9IHZkc29fYmFzZSAmJiB2ZHNvX2Jhc2UgPCBlbmQpCi0JCW1tLT5jb250ZXh0LnZk
c28gPSBOVUxMOwotfQotCiAjaWZkZWYgQ09ORklHX1BQQ19NRU1fS0VZUwogYm9vbCBhcmNoX3Zt
YV9hY2Nlc3NfcGVybWl0dGVkKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCBib29sIHdyaXRl
LAogCQkJICAgICAgIGJvb2wgZXhlY3V0ZSwgYm9vbCBmb3JlaWduKTsKZGlmZiAtLWdpdCBhL2Fy
Y2gvcG93ZXJwYy9rZXJuZWwvdmRzby5jIGIvYXJjaC9wb3dlcnBjL2tlcm5lbC92ZHNvLmMKaW5k
ZXggN2EyZmY5MDEwZjE3Li40ZGU4YWY0M2Y5MjAgMTAwNjQ0Ci0tLSBhL2FyY2gvcG93ZXJwYy9r
ZXJuZWwvdmRzby5jCisrKyBiL2FyY2gvcG93ZXJwYy9rZXJuZWwvdmRzby5jCkBAIC04MSwxMiAr
ODEsMjAgQEAgc3RhdGljIGludCB2ZHNvNjRfbXJlbWFwKGNvbnN0IHN0cnVjdCB2bV9zcGVjaWFs
X21hcHBpbmcgKnNtLCBzdHJ1Y3Qgdm1fYXJlYV9zdHIKIAlyZXR1cm4gdmRzb19tcmVtYXAoc20s
IG5ld192bWEsICZ2ZHNvNjRfZW5kIC0gJnZkc282NF9zdGFydCk7CiB9CiAKK3N0YXRpYyBpbnQg
dnZhcl9jbG9zZShjb25zdCBzdHJ1Y3Qgdm1fc3BlY2lhbF9tYXBwaW5nICpzbSwKKwkJICAgICAg
c3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpCit7CisJc3RydWN0IG1tX3N0cnVjdCAqbW0gPSB2
bWEtPnZtX21tOworCW1tLT5jb250ZXh0LnZkc28gPSBOVUxMOworfQorCiBzdGF0aWMgdm1fZmF1
bHRfdCB2dmFyX2ZhdWx0KGNvbnN0IHN0cnVjdCB2bV9zcGVjaWFsX21hcHBpbmcgKnNtLAogCQkJ
ICAgICBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgc3RydWN0IHZtX2ZhdWx0ICp2bWYpOwog
CiBzdGF0aWMgc3RydWN0IHZtX3NwZWNpYWxfbWFwcGluZyB2dmFyX3NwZWMgX19yb19hZnRlcl9p
bml0ID0gewogCS5uYW1lID0gIlt2dmFyXSIsCiAJLmZhdWx0ID0gdnZhcl9mYXVsdCwKKwkuY2xv
c2UgPSB2dmFyX2Nsb3NlLAogfTsKIAogc3RhdGljIHN0cnVjdCB2bV9zcGVjaWFsX21hcHBpbmcg
dmRzbzMyX3NwZWMgX19yb19hZnRlcl9pbml0ID0gewpAQCAtMjA3LDggKzIxNSwxMCBAQCBzdGF0
aWMgaW50IF9fYXJjaF9zZXR1cF9hZGRpdGlvbmFsX3BhZ2VzKHN0cnVjdCBsaW51eF9iaW5wcm0g
KmJwcm0sIGludCB1c2VzX2ludAogCXZtYSA9IF9pbnN0YWxsX3NwZWNpYWxfbWFwcGluZyhtbSwg
dmRzb19iYXNlLCB2dmFyX3NpemUsCiAJCQkJICAgICAgIFZNX1JFQUQgfCBWTV9NQVlSRUFEIHwg
Vk1fSU8gfAogCQkJCSAgICAgICBWTV9ET05URFVNUCB8IFZNX1BGTk1BUCwgJnZ2YXJfc3BlYyk7
Ci0JaWYgKElTX0VSUih2bWEpKQorCWlmIChJU19FUlIodm1hKSkgeworCQltbS0+Y29udGV4dC52
ZHNvID0gTlVMTDsKIAkJcmV0dXJuIFBUUl9FUlIodm1hKTsKKwl9CiAKIAkvKgogCSAqIG91ciB2
bWEgZmxhZ3MgZG9uJ3QgaGF2ZSBWTV9XUklURSBzbyBieSBkZWZhdWx0LCB0aGUgcHJvY2VzcyBp
c24ndApkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbW11X2NvbnRleHQuaCBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL21tdV9jb250ZXh0LmgKaW5kZXggOGRhYzQ1YTJjN2ZjLi44MGYy
YTMxODdhYTYgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL21tdV9jb250ZXh0LmgK
KysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbW11X2NvbnRleHQuaApAQCAtMjMyLDExICsyMzIs
NiBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaXNfNjRiaXRfbW0oc3RydWN0IG1tX3N0cnVjdCAqbW0p
CiB9CiAjZW5kaWYKIAotc3RhdGljIGlubGluZSB2b2lkIGFyY2hfdW5tYXAoc3RydWN0IG1tX3N0
cnVjdCAqbW0sIHVuc2lnbmVkIGxvbmcgc3RhcnQsCi0JCQkgICAgICB1bnNpZ25lZCBsb25nIGVu
ZCkKLXsKLX0KLQogLyoKICAqIFdlIG9ubHkgd2FudCB0byBlbmZvcmNlIHByb3RlY3Rpb24ga2V5
cyBvbiB0aGUgY3VycmVudCBwcm9jZXNzCiAgKiBiZWNhdXNlIHdlIGVmZmVjdGl2ZWx5IGhhdmUg
bm8gYWNjZXNzIHRvIFBLUlUgZm9yIG90aGVyCmRpZmYgLS1naXQgYS9pbmNsdWRlL2FzbS1nZW5l
cmljL21tX2hvb2tzLmggYi9pbmNsdWRlL2FzbS1nZW5lcmljL21tX2hvb2tzLmgKaW5kZXggNGRi
YjE3N2QxMTUwLi42ZWVhM2IzYzFlNjUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvYXNtLWdlbmVyaWMv
bW1faG9va3MuaAorKysgYi9pbmNsdWRlL2FzbS1nZW5lcmljL21tX2hvb2tzLmgKQEAgLTEsOCAr
MSw4IEBACiAvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLwogLyoKLSAqIERl
ZmluZSBnZW5lcmljIG5vLW9wIGhvb2tzIGZvciBhcmNoX2R1cF9tbWFwLCBhcmNoX2V4aXRfbW1h
cAotICogYW5kIGFyY2hfdW5tYXAgdG8gYmUgaW5jbHVkZWQgaW4gYXNtLUZPTy9tbXVfY29udGV4
dC5oIGZvciBhbnkKLSAqIGFyY2ggRk9PIHdoaWNoIGRvZXNuJ3QgbmVlZCB0byBob29rIHRoZXNl
LgorICogRGVmaW5lIGdlbmVyaWMgbm8tb3AgaG9va3MgZm9yIGFyY2hfZHVwX21tYXAgYW5kIGFy
Y2hfZXhpdF9tbWFwCisgKiB0byBiZSBpbmNsdWRlZCBpbiBhc20tRk9PL21tdV9jb250ZXh0Lmgg
Zm9yIGFueSBhcmNoIEZPTyB3aGljaAorICogZG9lc24ndCBuZWVkIHRvIGhvb2sgdGhlc2UuCiAg
Ki8KICNpZm5kZWYgX0FTTV9HRU5FUklDX01NX0hPT0tTX0gKICNkZWZpbmUgX0FTTV9HRU5FUklD
X01NX0hPT0tTX0gKQEAgLTE3LDExICsxNyw2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBhcmNoX2V4
aXRfbW1hcChzdHJ1Y3QgbW1fc3RydWN0ICptbSkKIHsKIH0KIAotc3RhdGljIGlubGluZSB2b2lk
IGFyY2hfdW5tYXAoc3RydWN0IG1tX3N0cnVjdCAqbW0sCi0JCQl1bnNpZ25lZCBsb25nIHN0YXJ0
LCB1bnNpZ25lZCBsb25nIGVuZCkKLXsKLX0KLQogc3RhdGljIGlubGluZSBib29sIGFyY2hfdm1h
X2FjY2Vzc19wZXJtaXR0ZWQoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsCiAJCWJvb2wgd3Jp
dGUsIGJvb2wgZXhlY3V0ZSwgYm9vbCBmb3JlaWduKQogewpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9tbV90eXBlcy5oIGIvaW5jbHVkZS9saW51eC9tbV90eXBlcy5oCmluZGV4IDQ4NTQyNDk3
OTI1NC4uZWYzMmQ4N2EzYWRjIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L21tX3R5cGVzLmgK
KysrIGIvaW5jbHVkZS9saW51eC9tbV90eXBlcy5oCkBAIC0xMzEzLDYgKzEzMTMsOCBAQCBzdHJ1
Y3Qgdm1fc3BlY2lhbF9tYXBwaW5nIHsKIAogCWludCAoKm1yZW1hcCkoY29uc3Qgc3RydWN0IHZt
X3NwZWNpYWxfbWFwcGluZyAqc20sCiAJCSAgICAgc3RydWN0IHZtX2FyZWFfc3RydWN0ICpuZXdf
dm1hKTsKKwl2b2lkICgqY2xvc2UpKGNvbnN0IHN0cnVjdCB2bV9zcGVjaWFsX21hcHBpbmcgKnNt
LAorCQkgICAgICBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSk7CiB9OwogCiBlbnVtIHRsYl9m
bHVzaF9yZWFzb24gewpkaWZmIC0tZ2l0IGEvbW0vbW1hcC5jIGIvbW0vbW1hcC5jCmluZGV4IGQw
ZGZjODViMjA5Yi4uYWRhYWYxZWYxOTdhIDEwMDY0NAotLS0gYS9tbS9tbWFwLmMKKysrIGIvbW0v
bW1hcC5jCkBAIC0yNzg5LDcgKzI3ODksNyBAQCBkb192bWlfYWxpZ25fbXVubWFwKHN0cnVjdCB2
bWFfaXRlcmF0b3IgKnZtaSwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsCiAgKgogICogVGhp
cyBmdW5jdGlvbiB0YWtlcyBhIEBtYXMgdGhhdCBpcyBlaXRoZXIgcG9pbnRpbmcgdG8gdGhlIHBy
ZXZpb3VzIFZNQSBvciBzZXQKICAqIHRvIE1BX1NUQVJUIGFuZCBzZXRzIGl0IHVwIHRvIHJlbW92
ZSB0aGUgbWFwcGluZyhzKS4gIFRoZSBAbGVuIHdpbGwgYmUKLSAqIGFsaWduZWQgYW5kIGFueSBh
cmNoX3VubWFwIHdvcmsgd2lsbCBiZSBwcmVmb3JtZWQuCisgKiBhbGlnbmVkLgogICoKICAqIFJl
dHVybjogMCBvbiBzdWNjZXNzIGFuZCBkcm9wcyB0aGUgbG9jayBpZiBzbyBkaXJlY3RlZCwgZXJy
b3IgYW5kIGxlYXZlcyB0aGUKICAqIGxvY2sgaGVsZCBvdGhlcndpc2UuCkBAIC0yODA5LDE2ICsy
ODA5LDEyIEBAIGludCBkb192bWlfbXVubWFwKHN0cnVjdCB2bWFfaXRlcmF0b3IgKnZtaSwgc3Ry
dWN0IG1tX3N0cnVjdCAqbW0sCiAJCXJldHVybiAtRUlOVkFMOwogCiAJLyoKLQkgKiBDaGVjayBp
ZiBtZW1vcnkgaXMgc2VhbGVkIGJlZm9yZSBhcmNoX3VubWFwLgotCSAqIFByZXZlbnQgdW5tYXBw
aW5nIGEgc2VhbGVkIFZNQS4KKwkgKiBDaGVjayBpZiBtZW1vcnkgaXMgc2VhbGVkLCBwcmV2ZW50
IHVubWFwcGluZyBhIHNlYWxlZCBWTUEuCiAJICogY2FuX21vZGlmeV9tbSBhc3N1bWVzIHdlIGhh
dmUgYWNxdWlyZWQgdGhlIGxvY2sgb24gTU0uCiAJICovCiAJaWYgKHVubGlrZWx5KCFjYW5fbW9k
aWZ5X21tKG1tLCBzdGFydCwgZW5kKSkpCiAJCXJldHVybiAtRVBFUk07CiAKLQkgLyogYXJjaF91
bm1hcCgpIG1pZ2h0IGRvIHVubWFwcyBpdHNlbGYuICAqLwotCWFyY2hfdW5tYXAobW0sIHN0YXJ0
LCBlbmQpOwotCiAJLyogRmluZCB0aGUgZmlyc3Qgb3ZlcmxhcHBpbmcgVk1BICovCiAJdm1hID0g
dm1hX2ZpbmQodm1pLCBlbmQpOwogCWlmICghdm1hKSB7CkBAIC0zMjMyLDE0ICszMjI4LDEyIEBA
IGludCBkb192bWFfbXVubWFwKHN0cnVjdCB2bWFfaXRlcmF0b3IgKnZtaSwgc3RydWN0IHZtX2Fy
ZWFfc3RydWN0ICp2bWEsCiAJc3RydWN0IG1tX3N0cnVjdCAqbW0gPSB2bWEtPnZtX21tOwogCiAJ
LyoKLQkgKiBDaGVjayBpZiBtZW1vcnkgaXMgc2VhbGVkIGJlZm9yZSBhcmNoX3VubWFwLgotCSAq
IFByZXZlbnQgdW5tYXBwaW5nIGEgc2VhbGVkIFZNQS4KKwkgKiBDaGVjayBpZiBtZW1vcnkgaXMg
c2VhbGVkLCBwcmV2ZW50IHVubWFwcGluZyBhIHNlYWxlZCBWTUEuCiAJICogY2FuX21vZGlmeV9t
bSBhc3N1bWVzIHdlIGhhdmUgYWNxdWlyZWQgdGhlIGxvY2sgb24gTU0uCiAJICovCiAJaWYgKHVu
bGlrZWx5KCFjYW5fbW9kaWZ5X21tKG1tLCBzdGFydCwgZW5kKSkpCiAJCXJldHVybiAtRVBFUk07
CiAKLQlhcmNoX3VubWFwKG1tLCBzdGFydCwgZW5kKTsKIAlyZXR1cm4gZG9fdm1pX2FsaWduX211
bm1hcCh2bWksIHZtYSwgbW0sIHN0YXJ0LCBlbmQsIHVmLCB1bmxvY2spOwogfQogCkBAIC0zNjI0
LDYgKzM2MTgsOSBAQCBzdGF0aWMgdm1fZmF1bHRfdCBzcGVjaWFsX21hcHBpbmdfZmF1bHQoc3Ry
dWN0IHZtX2ZhdWx0ICp2bWYpOwogICovCiBzdGF0aWMgdm9pZCBzcGVjaWFsX21hcHBpbmdfY2xv
c2Uoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpCiB7CisJY29uc3Qgc3RydWN0IHZtX3NwZWNp
YWxfbWFwcGluZyAqc20gPSB2bWEtPnZtX3ByaXZhdGVfZGF0YTsKKwlpZiAoc20tPmNsb3NlKQor
CQlzbS0+Y2xvc2Uoc20sIHZtYSk7CiB9CiAKIHN0YXRpYyBjb25zdCBjaGFyICpzcGVjaWFsX21h
cHBpbmdfbmFtZShzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSkK
--00000000000044bb81061ef439ea--


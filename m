Return-Path: <linux-kernel+bounces-263616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5198793D84A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072A8281866
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6852D39AFD;
	Fri, 26 Jul 2024 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RrCpCmKs"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4F64430
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722018273; cv=none; b=BGpwWdExVDLS3XIrFfdsxgOxmVvg8tZkK+vSKc7MZPtU4qri2qeOJhjCiOg1TqvRoc7Gj2PVIx+/ibiF1Yl85Me3PzD4fMXu5o1R2K0rSpthkhIVoon8tvx1cgogOAFG9uC8aZksyPJCmOgXNIb2HhoNy3UwuzqwBJMDsGPq6bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722018273; c=relaxed/simple;
	bh=3sZFZvbMVzkd2x/NLeqUtMaKCoo3so7iBRw+8g+Rbqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7Bwx9iGaGzbPsK7O48tgkhHYFaVXQJpT5dTkQT/41apj1ExyLmGKOC0K5S1kiRKhOf5arJ6JnuMP64PujtiDoh2uhh9fK9dPGXGjRZ4Njqb17gzh6gDygjbimOzpY+oxjbPVaw9+DbMroZrw88Oog9hTauJ3XVpVFLl3BJPTDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RrCpCmKs; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a9e25008aso254135466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 11:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722018268; x=1722623068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Etc2i2pov5hCTs+fciPUhJ/qkX6UBAJlZxEceY+agC8=;
        b=RrCpCmKsz5qT8/j8Lhr5Gepdu51+jNJtuBunY65odBI2w+j4FHekf2CAmF72sKaUQH
         128+eD44Tn2oG7DSKQEfmO+mAHwXQ8RUfWJQtc1aCmMKoqaGJbKICXDofOZG+HvfRnhX
         MtuyR6WxipDdwM1ilblJQ6ddJ+zwMOtW5Teqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722018268; x=1722623068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Etc2i2pov5hCTs+fciPUhJ/qkX6UBAJlZxEceY+agC8=;
        b=fND9y8Tk1u93fZBbzLMn3B7QZYLvnnhn8UzRNY2LIL5AhRyCg3r46uis+6VIsWRnPn
         CbkhXMP9FjQygXCNtOOsRX90h1Ein3/9dsESXDKLXxzo0SEuZKCDR06u28onYCU9rKRm
         +ScYWKZ8Q69phIVaWTkU0V1v6AxgDU7y8M3dVQyRwS1009T1c6hfm20Z99eJaMxg9mHU
         6JVjQ4wRsydphm8G7cFxFO1rZsrJf87d36JF800g5eWYCIs8B8KDaOFyXkhWFAUXsNAF
         uhdAjkhJiEZeWKcDdTGkARGsrQGCGFGSVsktevim1o10HZ8SVw+L1G74mf59faC41SmG
         EPgA==
X-Forwarded-Encrypted: i=1; AJvYcCWnTUpLJix1L+5MNc7rCfT0NCkvO0ql7zRJ3qwddw2ZebKXlG1amQ8QEIh6YFG2/Itn8TcgTeMqzVZOTBGM7/pZ/IopKX0w6kbwpRMz
X-Gm-Message-State: AOJu0YzG8SBY+m2qFT9s3n31xgK0JNYyi/bBAEuBDg7T7vlQtehDomXk
	NBgCyPfrvShcG7ObmxTtgs7fCk3PKQZKlcitH9+ZZ/LDGEv9xl2GNo7I6AR7MHuQIdkCPn+46Qc
	hWWWfHA==
X-Google-Smtp-Source: AGHT+IHAoO24OaW2J0freyvCwSO3YlMZmi/XD84co7VxprKnMAhV2vsIiZP7jN0gpkkOJYBgxyTXEg==
X-Received: by 2002:a17:907:86ac:b0:a7a:1d35:4106 with SMTP id a640c23a62f3a-a7d3ffdadcdmr24307966b.5.1722018268517;
        Fri, 26 Jul 2024 11:24:28 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab2365fsm201932366b.21.2024.07.26.11.24.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 11:24:26 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-585e774fd3dso2206836a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 11:24:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFfyk3jaRx/+FRdEHHCB4+Jzdxt1duu+7X6XNLJ/1g1nZG//2Mh+2kZKd4LJHQGAQiOeCvLPLP+6YmhOmpBdnOxdgYW7SuoFQ5MpHa
X-Received: by 2002:a50:935c:0:b0:5a4:48c9:90ca with SMTP id
 4fb4d7f45d1cf-5b0205d5ac9mr181368a12.9.1722018266062; Fri, 26 Jul 2024
 11:24:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local> <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local>
In-Reply-To: <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 26 Jul 2024 11:24:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
Message-ID: <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Laight <David.Laight@aculab.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>, 
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: multipart/mixed; boundary="0000000000000c50ed061e2a9f76"

--0000000000000c50ed061e2a9f76
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 11:13, Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> 5,447,539       ./arch/x86/xen/setup.o.pre

Can you perhaps do some kind of "max expansion" on all the
preprocessor files (you seem to have done it by changing the ".c.o"
rule to just spit it out as "o.pre", which sounds fine).

For example, this trivial patch seems to fix the setup.c expansion by
about an order of magnitude (ie 50M -> 5M).

Entirely untested, but looks ObviouslyCorrect(tm) to me.

                     Linus

                Linus

--0000000000000c50ed061e2a9f76
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lz317blj0>
X-Attachment-Id: f_lz317blj0

IGFyY2gveDg2L3hlbi9zZXR1cC5jIHwgNSArKystLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni94ZW4vc2V0dXAu
YyBiL2FyY2gveDg2L3hlbi9zZXR1cC5jCmluZGV4IGEwYzNlNzdlM2Q1Yi4uODA2ZGRiMjM5MWQ5
IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni94ZW4vc2V0dXAuYworKysgYi9hcmNoL3g4Ni94ZW4vc2V0
dXAuYwpAQCAtNjkwLDYgKzY5MCw3IEBAIGNoYXIgKiBfX2luaXQgeGVuX21lbW9yeV9zZXR1cCh2
b2lkKQogCXN0cnVjdCB4ZW5fbWVtb3J5X21hcCBtZW1tYXA7CiAJdW5zaWduZWQgbG9uZyBtYXhf
cGFnZXM7CiAJdW5zaWduZWQgbG9uZyBleHRyYV9wYWdlcyA9IDA7CisJdW5zaWduZWQgbG9uZyBt
YXhtZW1fcGFnZXM7CiAJaW50IGk7CiAJaW50IG9wOwogCkBAIC03NjEsOCArNzYyLDggQEAgY2hh
ciAqIF9faW5pdCB4ZW5fbWVtb3J5X3NldHVwKHZvaWQpCiAJICogTWFrZSBzdXJlIHdlIGhhdmUg
bm8gbWVtb3J5IGFib3ZlIG1heF9wYWdlcywgYXMgdGhpcyBhcmVhCiAJICogaXNuJ3QgaGFuZGxl
ZCBieSB0aGUgcDJtIG1hbmFnZW1lbnQuCiAJICovCi0JZXh0cmFfcGFnZXMgPSBtaW4zKEVYVFJB
X01FTV9SQVRJTyAqIG1pbihtYXhfcGZuLCBQRk5fRE9XTihNQVhNRU0pKSwKLQkJCSAgIGV4dHJh
X3BhZ2VzLCBtYXhfcGFnZXMgLSBtYXhfcGZuKTsKKwltYXhtZW1fcGFnZXMgPSBFWFRSQV9NRU1f
UkFUSU8gKiBtaW4obWF4X3BmbiwgUEZOX0RPV04oTUFYTUVNKSk7CisJZXh0cmFfcGFnZXMgPSBt
aW4zKG1heG1lbV9wYWdlcywgZXh0cmFfcGFnZXMsIG1heF9wYWdlcyAtIG1heF9wZm4pOwogCWkg
PSAwOwogCWFkZHIgPSB4ZW5fZTgyMF90YWJsZS5lbnRyaWVzWzBdLmFkZHI7CiAJc2l6ZSA9IHhl
bl9lODIwX3RhYmxlLmVudHJpZXNbMF0uc2l6ZTsK
--0000000000000c50ed061e2a9f76--


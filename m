Return-Path: <linux-kernel+bounces-263340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE9393D49C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B841C227D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77674178388;
	Fri, 26 Jul 2024 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="19sF2YN9"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3921E51F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722001927; cv=none; b=Gyxm8efLk8/P54XEQlssCAdIKjvqeD0n9agh8bmpQWAgmXg6MT/02h/EaBVFOVSvueMyP6nuSA+m1XbsTqKJyiJz6bVO+NR6f4OXpQmlLpfH6uIsPIpEI3j5kn4GfqC3tT0dhHH4ir8R9H+ncxrC+WAFsDCg+p60ZSnVNy/9x94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722001927; c=relaxed/simple;
	bh=p9LZjl6KaOwjvJF0IXHnTDzGnQo35y0H2Buy/T1CPjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1/0iarOghzAbyI2WafmLNC+E2UV6QJlGdpZWfiQU4ILb6c2UAIp0ng5JOP5qXVMaC/dzUak+BjChKfQ+dSo0VDCWACLZrD8tT/0vgeacNyFu3XiAWkx+c0RpDrBTpIAoJk7xN4SaTHqoqOpiUG/MdkAKxbzC2XkDCX6AypJJxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=19sF2YN9; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so10440a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 06:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722001924; x=1722606724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzST+WgYB+YniWsc5gywqmeeedMARG6ljFEX5tmeU7g=;
        b=19sF2YN9yZLPGUPy9HX5DAXVX2/8sQ/KSs5EUiuCaJetnQtPThcQC4SCKSqJ1naF1d
         tkc6iyq0CeL1yVJJ81RSHWo834uCoz9MVp9Hn7LVe16fLrVBxrNBbA1ry53e5tFBe2Zm
         CiGz4FgilLyKGGPNCnFt1ir59pxI6ZHH/nmSNFTjYq6ObGlkKGzIFNvjAHJYizw3IabK
         q30Jz97RAlOHegMQbpsxGmsdiIBHeu9z6kS0lV97MBYmM9gVkcyPSSXYc6c7n9syEmxJ
         34FfmiUiIPk+y3bILH87dlHtkXrGYmnZlkYZ5fMjkTyKtyXdKWxyw8pF1+VPKJGx+ljp
         7O0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722001924; x=1722606724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzST+WgYB+YniWsc5gywqmeeedMARG6ljFEX5tmeU7g=;
        b=IdQrkoGUo4f84ebnB6puXdcyF82Dm4EXa8XrraOX5AlQgIliA42Rsiuwlod2xw24rG
         k3QQA5pNg/kO5nV960CqBs4oOA1AUUXwoBmd5J5CbU0E2PF0VUc96XXK0ShH897nzY+l
         Xj8kXUiRnt38Q28qR09YU1D29xZJn8IKDgo6z1IiCIf70wrl5UJ4bOUyLIRPkN3wTniW
         e44ptkd7JaYPrnnC2dkgggWhpbLcJDh/c62fnrUaYIWmSyC8nRjjZBkAYIzSypxeOYJg
         B4ZmmQ7qt2oE3E4Ci+aD6KrTonAhYqowzZ60cTp7rZWRkP7iGZUca9mKQqxo7UcZRFRs
         vw/g==
X-Forwarded-Encrypted: i=1; AJvYcCVQOXoQg1lF34+TTJ7IvsXpyyUxLQ5sOJodWRF5f6EQp5DHDTPN0UJ94v9wSRtlQxnfD4Pjjpe4PB21uwLmmQjunh+qbdvHtbmFLBcT
X-Gm-Message-State: AOJu0Yz+Z0CMm55FKV5fL9QJVJ7DPHlq7cs+4hTlD6jpJzg4H1UjX4Jz
	bdAuPhablBtz5Wpdc7N+GXXCj9uUX8ucBqGj+7F6+V3QcRZMVNi73ATie4/2UI6cUP+zpi8bKbN
	7nS3V1tW9nbBnG8Ooj4b+eXORdVETHyeCLwkc
X-Google-Smtp-Source: AGHT+IG3nG1xboIr8vSlksNa3ilwXQsXcvozmDP5icTpDxOIkFTcoQ9u5/IcNIPgYSZ/R0o7yKwC4+p03zInZGQO4b8=
X-Received: by 2002:a05:6402:354f:b0:58b:15e4:d786 with SMTP id
 4fb4d7f45d1cf-5af44348136mr79918a12.5.1722001923695; Fri, 26 Jul 2024
 06:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725-kasan-tsbrcu-v3-0-51c92f8f1101@google.com>
 <20240725-kasan-tsbrcu-v3-1-51c92f8f1101@google.com> <CA+fCnZe-x+JOUN1P-H-i0_3ys+XgpZBKU_zi06XBRfmN+OzO+w@mail.gmail.com>
In-Reply-To: <CA+fCnZe-x+JOUN1P-H-i0_3ys+XgpZBKU_zi06XBRfmN+OzO+w@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 26 Jul 2024 15:51:25 +0200
Message-ID: <CAG48ez0hAN-bJtQtbTiNa15qkHQ+67hy95Aybgw24LyNWbuU0g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kasan: catch invalid free before SLUB
 reinitializes the object
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Marco Elver <elver@google.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 2:43=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
> On Thu, Jul 25, 2024 at 5:32=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> >
> > Currently, when KASAN is combined with init-on-free behavior, the
> > initialization happens before KASAN's "invalid free" checks.
> >
> > More importantly, a subsequent commit will want to use the object metad=
ata
> > region to store an rcu_head, and we should let KASAN check that the obj=
ect
> > pointer is valid before that. (Otherwise that change will make the exis=
ting
> > testcase kmem_cache_invalid_free fail.)
>
> This is not the case since v3, right?

Oh, you're right, this text is now wrong.

> Do we still need this patch?

I just tried removing this patch from the series; without it, the
kmem_cache_invalid_free kunit test fails because the kmem_cache_free()
no longer synchronously notices that the pointer is misaligned. I
guess I could change the testcase like this to make the tests pass
without this patch, but I'd like to hear from you or another KASAN
person whether you think that's a reasonable change:

diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index cba782a4b072..f44b0dcb0e84 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -981,14 +981,21 @@ static void kmem_cache_invalid_free(struct kunit *tes=
t)
        if (!p) {
                kunit_err(test, "Allocation failed: %s\n", __func__);
                kmem_cache_destroy(cache);
                return;
        }

-       /* Trigger invalid free, the object doesn't get freed. */
-       KUNIT_EXPECT_KASAN_FAIL(test, kmem_cache_free(cache, p + 1));
+       /*
+        * Trigger invalid free, the object doesn't get freed.
+        * Note that the invalid free detection may happen asynchronously
+        * under CONFIG_SLUB_RCU_DEBUG.
+        */
+       KUNIT_EXPECT_KASAN_FAIL(test, ({
+               kmem_cache_free(cache, p + 1);
+               rcu_barrier();
+       }));

Being able to get rid of this patch would be a nice simplification, so
if you think asynchronous invalid-free detection for TYPESAFE_BY_RCU
slabs is fine, I'll happily throw it out.


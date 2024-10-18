Return-Path: <linux-kernel+bounces-371256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830D09A38AF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A441C1C21C22
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8F418E374;
	Fri, 18 Oct 2024 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PUY3Azc5"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94BF2EB1F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729240671; cv=none; b=pJIAnECqU7WJZoKZzhynGjZ+ne7WGLotObPm7onsfYxKnO42ybIEleQqtVf2yVIsZZgqC7m8jYBUq1fECAk/0ocX0GGJ2i6VvmwVVsWHSRkkjPXlssBUZ19kItXDQV9WX2qpMJfEpEqAsHBtNvlg+Q75zvbUbYvtri1MXIt+wfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729240671; c=relaxed/simple;
	bh=U+9c6cTaB84k110WxHg12TTD2PS41ZDLNCaPxtIDkVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3My477vWYuYrhbsmez1iZN94A9O8UjGnUzgJMyieBcK87knfxW3nhMSNGqKrVCA7CiQDSGh0OSXH5Dwzw0cbhWJqawRHSGAPpeMCIrR0W3BqLX9WU+IsKF/jOpn5mBxwigf+eCQyhYPpo7Bq3y2a5W4kbofEkyuI7Zs9yCM5lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PUY3Azc5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315baec69eso13883815e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 01:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729240668; x=1729845468; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6yd32eCbtlLyyhJU30GZ0XFgAZYNVzp9z45d5h+EaM=;
        b=PUY3Azc5zsgucKvvxz1jtqu4wZhzSPXl7j4GxEF8aGj9ldr0qQd/fv7XbA5KOuKPgg
         0gZMUimyGfEN06HANR2Q56PkbdrKv1aUpQ87sYuxgui1YEnEL9scfAo9Wm1oo9o+0IfT
         L5ZRBl48rFKkPrjG/ZKoXIzj/hyaYtZln+N//W7AzKiurakyXIb5WwhQre3YjdvsC7gJ
         zonk8j4jkNebGQo3w0nJnpnShRw16UeKAW19baekN0JXxNOdO5CRrTbWTrMDQW22u4rF
         Q5FyeWrwS2Ps97YbWRHuSKWMbb2M54JmH+ICur8SB4ca65E8USphtuvTErdf8f05jMDX
         yyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729240668; x=1729845468;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6yd32eCbtlLyyhJU30GZ0XFgAZYNVzp9z45d5h+EaM=;
        b=aToEVxx+DUbsSY3emH+Q9osnLNv6p+Jf03UrcMb9gNBYkRtoOrGVtu4wyHN9Q3gc+q
         X7Ye2qaKkBtmnBwq5xBvbm7dpgMK8YRUNpGvMVoPdNm3EsFyu0H1DixYIRyacOuJO28V
         mThS2dolIHnCJYewKJ05P8KtUi0IL/He8yFzZCxQwLAaeMN9UpPm+1x4YCq6U1U3tCIo
         +8MV2qVmbHV3X/xzzYHHu2EqJgbwqoTeq05ZK6mu6g1aPWNXGrn/JrPpMzQ2Iy93i4Gm
         fI4GFb507DHpsY3JhtRc9EBr4P3L8rCS+3Tqrjz29mW1p8g3LIURVCoRR2Z/v00DVdr2
         XXSg==
X-Forwarded-Encrypted: i=1; AJvYcCUAM9aNHoP/XWwK4UPhzhNG9WIaF3JtsCBt5Nl8pLRHU89B+X67nYuK2ag8eptXgDmMauzCF1DSFZVFy50=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZUIQH+U0ANIysOZ+ZGmhf0azPsm9ifEzV/zPGO2hu7WWaYur5
	e9rXhaP1REtdxhBSSZ0XTUiHrzJxIvl3rvn3L83PGNZeUfP4ZfLRGPsjMRWRJQ==
X-Google-Smtp-Source: AGHT+IG6tqZDU5vuqQ/8yfzFcSKBZocIYfOFr93kFxBpgu3aGBq28pRnxztUk2dWRxXkAl85RTtSSA==
X-Received: by 2002:adf:f744:0:b0:37d:5103:8896 with SMTP id ffacd0b85a97d-37eab4ed1ddmr1058788f8f.41.1729240667888;
        Fri, 18 Oct 2024 01:37:47 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:5ff5:1ffe:9d80:ada1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf027d90sm1323673f8f.8.2024.10.18.01.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 01:37:47 -0700 (PDT)
Date: Fri, 18 Oct 2024 10:37:41 +0200
From: Marco Elver <elver@google.com>
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org,
	ryabinin.a.a@gmail.com, glider@google.com,
	kasan-dev@googlegroups.com, Andrey Konovalov <andreyknvl@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	syzbot+908886656a02769af987@syzkaller.appspotmail.com,
	Andrew Pinski <pinskia@gmail.com>
Subject: Re: [PATCH] kasan: Disable Software Tag-Based KASAN with GCC
Message-ID: <ZxIeVabQQS2aISe5@elver.google.com>
References: <20241014161100.18034-1-will@kernel.org>
 <172898869113.658437.16326042568646594201.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172898869113.658437.16326042568646594201.b4-ty@kernel.org>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Tue, Oct 15, 2024 at 01:39PM +0100, 'Will Deacon' via kasan-dev wrote:
> On Mon, 14 Oct 2024 17:11:00 +0100, Will Deacon wrote:
> > Syzbot reports a KASAN failure early during boot on arm64 when building
> > with GCC 12.2.0 and using the Software Tag-Based KASAN mode:
> > 
> >   | BUG: KASAN: invalid-access in smp_build_mpidr_hash arch/arm64/kernel/setup.c:133 [inline]
> >   | BUG: KASAN: invalid-access in setup_arch+0x984/0xd60 arch/arm64/kernel/setup.c:356
> >   | Write of size 4 at addr 03ff800086867e00 by task swapper/0
> >   | Pointer tag: [03], memory tag: [fe]
> > 
> > [...]
> 
> Applied to arm64 (for-next/fixes), thanks!
> 
> [1/1] kasan: Disable Software Tag-Based KASAN with GCC
>       https://git.kernel.org/arm64/c/7aed6a2c51ff

I do not think this is the right fix. Please see alternative below.
Please do double-check that the observed splat above is fixed with that.

Thanks,
-- Marco

------ >8 ------

From 23bd83dbff5a9778f34831ed292d5e52b4b0ee18 Mon Sep 17 00:00:00 2001
From: Marco Elver <elver@google.com>
Date: Fri, 18 Oct 2024 10:18:24 +0200
Subject: [PATCH] kasan: Fix Software Tag-Based KASAN with GCC

Per [1], -fsanitize=kernel-hwaddress with GCC currently does not disable
instrumentation in functions with __attribute__((no_sanitize_address)).

However, __attribute__((no_sanitize("hwaddress"))) does correctly
disable instrumentation. Use it instead.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117196 [1]
Link: https://lore.kernel.org/r/000000000000f362e80620e27859@google.com
Link: https://lore.kernel.org/r/ZvFGwKfoC4yVjN_X@J2N7QTR9R3
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218854
Reported-by: syzbot+908886656a02769af987@syzkaller.appspotmail.com
Cc: Andrew Pinski <pinskia@gmail.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/compiler-gcc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index f805adaa316e..cd6f9aae311f 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -80,7 +80,11 @@
 #define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
 #endif
 
+#ifdef __SANITIZE_HWADDRESS__
+#define __no_sanitize_address __attribute__((__no_sanitize__("hwaddress")))
+#else
 #define __no_sanitize_address __attribute__((__no_sanitize_address__))
+#endif
 
 #if defined(__SANITIZE_THREAD__)
 #define __no_sanitize_thread __attribute__((__no_sanitize_thread__))
-- 
2.47.0.rc1.288.g06298d1525-goog


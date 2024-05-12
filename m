Return-Path: <linux-kernel+bounces-176795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF8D8C3519
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 06:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8120BB214F3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 04:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAA2DDB8;
	Sun, 12 May 2024 04:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNzY02Wy"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74816BE4D
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 04:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715489734; cv=none; b=EKfxcdfIG0lYWToGxQIITDCsm+4xNdL0A4MTW9hSQgPwj0RTs8/Fu1IiMkhfnwJdfq+g2wg4FcPaUD6IfRnCNpeg63E7eVYKEZA1hjpbbdptW2LMY1SUKqO8IS9nqcpTO2Pn3+sLQFYKenZA72ciKhItB3oU63SRaPTAXaDFT+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715489734; c=relaxed/simple;
	bh=ObF5qCIA/fZxRS+KU2mWh4vNhMUFJ67AU2N2XQiI4Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hauwfpK8EQFETQeycDHQYxAFSBv6WG8ee07FnJUvhgzclZKh/JxEHg0/foXYEaiXuCkWPTBC8r3tz85BAroONrsG6JbvrditjgkBTPDaMuQbrQRTZjP5C2NtkdoqBaV5FxyvIPZgfMyrbACWvD1K7iaXwHaInTbVQjakCAcbfjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNzY02Wy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41fc2f7fbb5so17055585e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 21:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715489731; x=1716094531; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bMXmML4NHl/WVtddXgKAjgZaOBsukPoqWtAlXJ9S7LY=;
        b=kNzY02WyPn0XKzT4NHKejjbXaL/rI/LYw6xjO89IQbvk839lADv6MyhUIH/Q/u6dij
         0r/VKSE2dOn8L0i4ozpKMc9rk/M3jKZWB56AsLcQvsM9lVwOfybEyFYLLJiyvQC6SsIP
         zFpEZ2xm0zl0MpFuFlI4qllip/VT5aRrinaeX3R/PrGvfaeU2sLR+yU47wnN4gz/gGhP
         nW95Nhu5Ei0DaKPWAdJBP9s2ia859NbZBGnNmQsr0L3rgxoWS/Ph0tVWZfpVlrGZtxWw
         uFJM8Kk9aZm/bvbVGuDtAwcljX63dzpkvV0uha4dJ051HX3In5Vt3hFrTskbCyy/NdXz
         szMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715489731; x=1716094531;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMXmML4NHl/WVtddXgKAjgZaOBsukPoqWtAlXJ9S7LY=;
        b=E/axw7uP2tQKL8bNyEkm7wbPfwcc4jiPn3RknXK8e6YxBLYvC3NJbrtFWBRg/MBtzq
         RYkA24YPweoBtSu1zywmnZmw0yUK+lyzxhPlC56aJq6pJzzhZC9wqFmkbQ8SM3VfL+5H
         5ssTh3WXYrd4UKJTsxyx7rIr1vJTr6AzLFfdzhQjLmheCzCicqVlfG3FEmDfyQMOOexL
         apcs9XPLkkWQMuEiR7GteXYwE6zWy8yOUKIQ+vy5DDoG99s1IROIzB65rW9Z/XNnwrPH
         N7vlStXqibe/NcQgN153vkRr+v/JPftJ/QHUxgm6/Xj2a9DKBFXzgXoz2grVrpRAlGWT
         NWkQ==
X-Gm-Message-State: AOJu0YxJQqTwUTwocD65L0iJudqCWu1YOdCyNqLLVQFUIUhaW0xejd9+
	sSKPl/56OnGmeKBeS3sAtmofCtwz1OR7YZXYu8NUSj4PH0QjpxIKHfwy3LE=
X-Google-Smtp-Source: AGHT+IF+ggFXnZe3U4xBe6XpdHAq49GMvxqJiZ/OtQfsLforzirAVyPViOtbZ1y60IwU5qcgHgN6TQ==
X-Received: by 2002:adf:e80b:0:b0:34e:5284:4753 with SMTP id ffacd0b85a97d-3504979cd90mr5839712f8f.1.1715489730695;
        Sat, 11 May 2024 21:55:30 -0700 (PDT)
Received: from p183 ([46.53.251.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbc887sm8060343f8f.98.2024.05.11.21.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 21:55:30 -0700 (PDT)
Date: Sun, 12 May 2024 07:55:28 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] x86/vdso: add rcx clobber in syscall gettimeofday fallback
Message-ID: <e6ceb3bf-5c96-4b0a-9567-e9bcca0b821a@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

syscall instruction in fallback code is missing "rcx" and "r11" clobbers.

It doesn't seem to cause any problems because the C code looks like:

	if (do_hres(&vd[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
        	return gettimeofday_fallback(tv, tz);

and assembly looks like

	__vdso_gettimeofday:
		 0:	lea    r9, [rip]
		 7:	test   rdi,rdi
		 a:	je     b7
		10:	mov    r8d, [r9]
		13:	test   r8b, 1
		17:	jne    bf
		1d:	cmp    [rip], 1
		24:	jne    c6
		2a:	rdtsc

		c6:	mov	eax, 96
		cb:	syscall
	====>	cd:	ret		<====

rcx and r11 are caller-saved and nothing seems to use those registers
after syscall and before returning from vDSO.

Fixes: 7ac870747988 ("x86/vdso: Switch to generic vDSO implementation")
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/include/asm/vdso/gettimeofday.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -86,7 +86,7 @@ long gettimeofday_fallback(struct __kernel_old_timeval *_tv,
 	long ret;
 
 	asm("syscall" : "=a" (ret) :
-	    "0" (__NR_gettimeofday), "D" (_tv), "S" (_tz) : "memory");
+	    "0" (__NR_gettimeofday), "D" (_tv), "S" (_tz) : "rcx", "r11", "memory");
 
 	return ret;
 }


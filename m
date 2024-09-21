Return-Path: <linux-kernel+bounces-334957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0E297DEE1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 22:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9301F1C20CF1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 20:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A1013D52E;
	Sat, 21 Sep 2024 20:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoyjk6ri"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBE613CFA5
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 20:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726951770; cv=none; b=f1/syMjb13RvRn6GPbSTBcAXby9CR+wXPk4bFch8l8tRSsHA7VlbrcAaDk0kHrSpBWj+Op5UGZkTUH8kI/0ik7gcZ3jECsF0TcCB2JMZ5T65ojE1+u08dzk4HrdAxiu1ABV2nxQAti6MDY/RlFnONiZOZ1KezR0M5pIPEP7vPjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726951770; c=relaxed/simple;
	bh=DpMS7wUdHk5IVkgVUMOVgwFSAzOkqlQUSFAK20B9Mtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q10iWg+YTEw0hr+MUwihB7i43fmuw4MYy431ERFGFWcmhOh9EtQ6vNO9c6TJsXXgr67Hd/H7b8B6u/VeOvK0VXz4cwweImNPRbcsDru57d8W1ozNDZ62ESUriwxYrWUDMPJBu3NA2FyEXLaCJlFR8oOSxit+YHgHjJwZHL/9SS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoyjk6ri; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3787ddbd5a2so1766639f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 13:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726951767; x=1727556567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpMS7wUdHk5IVkgVUMOVgwFSAzOkqlQUSFAK20B9Mtg=;
        b=eoyjk6ri0XCGPUDlNwh+SbE80qYIW9k97Z3KnY1soLb3Fpr/cK3FX0zk3INcU4eOWT
         BTG+nUp1KDzEPDAb2iY++xsNIauG9n0vzOAiD24J3Fz7WqoV3Ath2iYoOm4Eeudu6WdF
         ko1rUCb7BfsKMl7zQ+n3JrTEyiVn1xGw61ozR+vQ360h+lYTvz+Bh+619QOtTmkZa8Zl
         HXeMkVxVbKwsz5amt6IQ2kj4JSP7jQb+pCtCSdXkNLud8K7GqxALELa5xLi0Go3/yCpk
         U3eqI7NZMkObbbGOKhlmmNnUoCDbP2P6K4tsspyg/6KnTFE3P2E2xm2aPei+Na9+3P9H
         ATlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726951767; x=1727556567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpMS7wUdHk5IVkgVUMOVgwFSAzOkqlQUSFAK20B9Mtg=;
        b=tDA+Zaf4QuOcpu+O791edATLSZlWX33HQLVlgzzA9qDDyEIOo9gkzpBgeSUlS00OA9
         u1BGDOU7+TPOGlJ6i7UPOuGeHvG/hLTrb4KgPli0Bxp5QfQ6BdnF4lGdhfs4lR+CQ52+
         WB/9SplLE2mcgUgaO/Nacu+7YYmG5lXYqnOrUA5cM93Aj+CthfkhBibmmahJUI0/1/q2
         nQPLZIGtbBjYMD939VVO7F33ulqCaR/v6zPQpyqp4hQXEGUl0ef0bl1aBgghgd4hFF1r
         eEJtXdBu3XuLP4LiHtAM7Vkqgd/PiZg0KTc+2W9zmojsINt0PHbop5Y6sSEx5CX0+9YZ
         Jokw==
X-Forwarded-Encrypted: i=1; AJvYcCU2BqAdEKbck0EUYuhy8COZAezzIkcbPJ9t+lhW7yOddJs5XtIz0JWoGR0IK3EPB1FfymOgBc1Imsw93JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXF/j2s9X8zaurH7zclCszFuLJ8mdqJs5uHfrTdGml9zW4Tj2W
	dgHdRdtYHjsRradQEZUOqBmifO147vC3xiNj96jvIcqTIMfbVaNmCFP9BY1xZhK+K2Tt9d6r7Cv
	t7a6ihZza1eXY+O6EeZ5hE8qDWYE=
X-Google-Smtp-Source: AGHT+IFbJfBXdTc6O4Y015mD/nF5MMHpcTtHpNY9+A/YDKXDqQd8e4KejNmxH9971L1jk1/lD6FsWn/GbbPD6Hp8inc=
X-Received: by 2002:a5d:4d8f:0:b0:374:b3a3:3f83 with SMTP id
 ffacd0b85a97d-37a423989e7mr3719363f8f.53.1726951766939; Sat, 21 Sep 2024
 13:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+fCnZeiVRiO76h+RR+uKkWNNGGNsVt_yRGGod+fmC8O519T+g@mail.gmail.com>
 <20240921071005.909660-1-snovitoll@gmail.com>
In-Reply-To: <20240921071005.909660-1-snovitoll@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 21 Sep 2024 22:49:15 +0200
Message-ID: <CA+fCnZfQT3j=GpomTZU3pa-OiQXMOGX1tOpGdmdpMWy4a7XVEw@mail.gmail.com>
Subject: Re: [PATCH v4] mm: x86: instrument __get/__put_kernel_nofault
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: akpm@linux-foundation.org, bp@alien8.de, brauner@kernel.org, 
	dave.hansen@linux.intel.com, dhowells@redhat.com, dvyukov@google.com, 
	glider@google.com, hpa@zytor.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com, 
	ryabinin.a.a@gmail.com, tglx@linutronix.de, vincenzo.frascino@arm.com, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2024 at 9:09=E2=80=AFAM Sabyrzhan Tasbolatov
<snovitoll@gmail.com> wrote:
>
> Instrument copy_from_kernel_nofault(), copy_to_kernel_nofault(),
> strncpy_from_kernel_nofault() where __put_kernel_nofault,
> __get_kernel_nofault macros are used.
>
> __get_kernel_nofault needs instrument_memcpy_before() which handles
> KASAN, KCSAN checks for src, dst address, whereas for __put_kernel_nofaul=
t
> macro, instrument_write() check should be enough as it's validated via
> kmsan_copy_to_user() in instrument_put_user().
>
> __get_user_size was appended with instrument_get_user() for KMSAN check i=
n
> commit 888f84a6da4d("x86: asm: instrument usercopy in get_user() and
> put_user()") but only for CONFIG_CC_HAS_ASM_GOTO_OUTPUT.
>
> copy_from_to_kernel_nofault_oob() kunit test triggers 4 KASAN OOB
> bug reports as expected, one for each copy_from/to_kernel_nofault call.
>
> Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D210505
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>

I tried running the tests with this patch applied, but unfortunately
the added test fails on arm64, most likely due to missing annotations
in arm64 asm code.

We need to either mark the added test as x86-only via
KASAN_TEST_NEEDS_CONFIG_ON or add annotations for arm64.

With annotations for arm64, the test might still fail for other
architectures, but I think that's fine: hopefully relevant people will
add annotations in time. But I consider both x86 and arm64 important,
so we should keep the tests working there.

If you decide to add annotations for arm64, please also test both
KASAN_SW_TAGS and KASAN_HW_TAGS modes.

Thanks!


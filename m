Return-Path: <linux-kernel+bounces-337808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CE5984F39
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC01284D78
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14490189BB8;
	Tue, 24 Sep 2024 23:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C1s8JMVQ"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB57183CA1
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727222378; cv=none; b=gvCVjEwGGnrLi9cCW8PHH+niB3JbnY1rvngBXm2blLQOqxcpTCUY9ofmpRl2hQWGBPDKlKh4RxpodpNZM2yNVF2AYSpcQnWSO8M2fgAeuJxBHl9V4iMCZB8kKarIfmffolgaOF1TaYV5GPhefjPc7htOrFM+EM6psvoAaN/jgQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727222378; c=relaxed/simple;
	bh=NPBhGsZGXeHhMhqBrOs0lKj/hQr4Of+6SHrSbODGWf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WsMfV/gS9x3rRatNE4ejDvZMDssZTzAU44WsytSvEyhkUjCcEBXj01oB9ea8m1RqKAQ6w1jcR1JOMiUyT1FFGn6XN10d39qDcUV/O8AFZWmEgEbTBSiE4SGr4h+Oj07JHnsJeuMDRcD9aqXqP9GcvAdcgtUAnWB6ZLbRxTLrrXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C1s8JMVQ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c4146c7b28so7665682a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727222375; x=1727827175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kI/ysPTxQWzKUDDa2gWjdjf1UvW+7XakeF8GyEGFOL4=;
        b=C1s8JMVQK72Or/DSqyLJddljAAr1GPC6xpU4g8GQH/zuuTw+Uq1U/eIevT0wvc8bnk
         CnPH1pzbq8lNTEQn09jeX1oOwydIX6kHmQkF2/Bret20o2Qf2ylxjJryk4GRCgfCvaL/
         USsz5xUSIkRUIDnLV9HwohaOM09bNWGy1Trtooh6tmrVkk5/fLoGz5OXxkbOy2DhpFLs
         H3C4gPzmg9THz/thIC7obNyinBGQ4hKMgwA4d1NceBGAR4Z46JErp0keHP/FMBVsRr8a
         oi5ld/RnpkgbXM9ATBYvVU3ep3o5jjeXOPBSIxyAWBdvc3jzjNC/+AcVchpCZ0p984e2
         D/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727222375; x=1727827175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kI/ysPTxQWzKUDDa2gWjdjf1UvW+7XakeF8GyEGFOL4=;
        b=mf+tQK7SUrBUypQmjncJpzoXF9ksp39YqN53+nOO9xtwO+sVkd4bHeVFURGT1mAHKO
         IRZIzhQXdQTyXFcV0ubLxh4fyDNw69rWf79G/7GGclI1huE0JCWQBkt1oXU8Od89FGUi
         hjk51sQDS+yAf2FsUG0Dua7qDM0PjtqhhyF5SCZNduESYZZ+ngCgC92BN1aJ28KHbEwQ
         McCKQywcJxX9HZay1x7gJOHLT8G9s5STGnf/Gn95/O+LBcpdEdElsSsLe+p0A1KVc+t2
         eWPiuj8D8TH7NsnJcJV1NHhQiMhXTq25MVkHD9Dk6HmFJ8qHOj4izPH4esZ1aX2qYj2L
         XuDw==
X-Forwarded-Encrypted: i=1; AJvYcCUd0/jJjRG/SJtvvHzjwsL3eL7bwq89MfYEVoNcBYAWU0sGFk2zu01OTsxZK1kPxPAqd/5FSEa3yIGLiKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlAQhBKGCfhhen3FB4q0mRzgd+JzokYXTGiCbUtG0d2RmGvDcx
	bU3PdIWANFe6cJOX9VyGUVyFOgh9AC0Pli3pPXaMjHJm1w1A7W1huIjQopnkYjCh8dZr2yPmw6c
	Qd8Y2+fEip3E2m4HzDed4ASubqS8169XZjUo=
X-Google-Smtp-Source: AGHT+IEFAG3wub9OvDEOs3FiLz5OFqv+WsMgtvScIRg52xRzRH+AwJSsf6BAU1gkGTOMfniTFrgvm8bolZPFDbB+GIQ=
X-Received: by 2002:a17:907:7d9f:b0:a77:b01b:f949 with SMTP id
 a640c23a62f3a-a93a03e3726mr75990466b.35.1727222374772; Tue, 24 Sep 2024
 16:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727191485.git.skhan@linuxfoundation.org> <f797bc704d8eb03234a3447c77fa7b704339f89a.1727191485.git.skhan@linuxfoundation.org>
In-Reply-To: <f797bc704d8eb03234a3447c77fa7b704339f89a.1727191485.git.skhan@linuxfoundation.org>
From: John Stultz <jstultz@google.com>
Date: Tue, 24 Sep 2024 16:59:22 -0700
Message-ID: <CANDhNCpsEQL+S8gadXMjvbE-6r8c6owzz+_DhN6JAVqQ8Hg=_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: timers: Remove local NSEC_PER_SEC and
 USEC_PER_SEC defines
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: tglx@linutronix.de, sboyd@kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 8:57=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> Remove local NSEC_PER_SEC and USEC_PER_SEC defines. Pick them up from
> include/vdso/time64.h. This requires -I $(top_srcdir) to the timers
> Makefile to include the include/vdso/time64.h.
>
> posix_timers test names the defines NSECS_PER_SEC and USECS_PER_SEC.
> Include the include/vdso/time64.h and change NSECS_PER_SEC and
> USECS_PER_SEC references to NSEC_PER_SEC and USEC_PER_SEC respectively.

Nit: You got the last bit switched there. This patch changes local
NSEC_PER_SEC to the upstream defined NSECS_PER_SEC.

Overall no objection from me. I've always pushed to have the tests be
mostly self-contained so they can be built outside of the kernel
source, but at this point the current kselftest.h dependencies means
it already takes some work, so this isn't introducing an undue
hardship.

Other then the nit,
  Acked-by: John Stultz <jstultz@google.com>

> diff --git a/tools/testing/selftests/timers/adjtick.c b/tools/testing/sel=
ftests/timers/adjtick.c
> index 205b76a4abb4..cb9a30f54662 100644
> --- a/tools/testing/selftests/timers/adjtick.c
> +++ b/tools/testing/selftests/timers/adjtick.c
> @@ -22,14 +22,12 @@
>  #include <sys/time.h>
>  #include <sys/timex.h>
>  #include <time.h>
> +#include <include/vdso/time64.h>
>
>  #include "../kselftest.h"
>
>  #define CLOCK_MONOTONIC_RAW    4

I suspect CLOCK_MONOTONIC_RAW (and the other clockid definitions)
could be similarly removed here as well in a future patch?

thanks
-john


Return-Path: <linux-kernel+bounces-218934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEBE90C7E3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616051C213B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D09157462;
	Tue, 18 Jun 2024 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iWYCzkO2"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB059156F31
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702734; cv=none; b=Gu7V1wrnfj6J68x2c2alT7fmktb+ns/wgdnfH/CX4DlrqXyWB3gLEx86LPRpWlu6Ic9JZXngkWQ0cfFeL92Ds9o6Ww0fzhj3U8pWE0fIbjv/VFJwAtlGGtbvuonSUCSDuXVPDo50s9VYo8VfIv1e1R/IeFuKxbMW9NxVhkTYLDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702734; c=relaxed/simple;
	bh=V4MXEMKcp5I9XclPQt9HVJ1nbtcnQ61M4kMdjmYxvDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/l3mx3nOLIcptXAqRJ6H3phorgjeJMoEJD8Q9kg/mG7G8Es6meDhr7NfP4N7D+D97Jgeb3ny2D5+7f8jWmy0OcZwa6eNMCgH1+kv1XEsNguJ8YPRbJCpfMjMOMBofjynN/psY7mHgwIpOmX4nK5y326JkeL+l+G1PHNlePo72g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iWYCzkO2; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6adc63c2ee0so20139556d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718702732; x=1719307532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4MXEMKcp5I9XclPQt9HVJ1nbtcnQ61M4kMdjmYxvDU=;
        b=iWYCzkO2aQ4jbNDIn8dhx7ku6V/hpVtnIMC/LqSHgHMo4+sylr/jQbVpzFXgelK3Td
         mYmTFx6ETJpfAnVje4CGB+fBJntk/YCA4FjskOR5YyG8EMQFVaa43o9KlXSr5lkq5pYz
         0G8DHtSZHm87gBeQuHxKcsor37yJ4O3IybtfjsDdKj3ZK3cpz2YQBUjjXlaNHszYt82N
         jbQAOZ7SiLhSlYrDTyGjyQBWR173f/A3kzEkWIznn4bjDkzFF3uJhlLRTdASGoR/6pg0
         i83flfrT7vsZwTVpBvwttYpcT3/s8aSMs3yzTIwta8ojhs+YH/zwPXygsnrVdfmykAU8
         iMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718702732; x=1719307532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4MXEMKcp5I9XclPQt9HVJ1nbtcnQ61M4kMdjmYxvDU=;
        b=eTKntXDy9DPT/rafDbzBCg/5tVL54IJvVOcIO/vJ/1dEM6Dp23Lhte4kegN/8Wt4oQ
         OlIRmHZaq8O3z+Y2wk8LeHSIgNdFB7AfuefrG7DEbKjMgPuVomUTpeW09E/FJ8e7uJlJ
         54fqnp0sr+msTNbkfQpBhSKm405xBLSGSY7qQdZa4cv43uJYOnJS+3EcqgutqhKdYRIM
         fMuf5X4dMOJLcMhKkuNBO6B0lzEq8MB9Dmzi5yiDbIodUVr5u1nE+Xc0e1p7E+Acz0d3
         KH480HFa7iLqtFSeRndakt41u/5nCVgelSGf3EkXCqU1OuM2wEV36w5nz5IREUPhG/Qo
         jvLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe/oO6WmBgPYcvagVXYkoJM+XEQntDV7yChDp9pkxkvuLIpQey3VXDt39qTA3oAKACDdyNEgcW65b4SZIXTCSvFumr+oABuwgPMskU
X-Gm-Message-State: AOJu0Yw7HAXJvbRFFjIJa5FJ5I+AYRrncX+VGSdh8tuotqR61puBth3u
	nNSvtGTJxV6pzWrOORpJoQ+ylOjGcl34gr0iXfUWitB7bE+2ZMX+haz5qNpkP202x7jaBLkZ11x
	EoYJgYdsm0GnyO5d+4IdO7ExlM2WrRR5jtoUe
X-Google-Smtp-Source: AGHT+IFRfUNJYndL8wAjatn8zq6n+Qt93BmmyIN+4VFyPbObVSvS4+erMVXHgpMv+VY+5qiKm1XXOgO0W2m66i2IHQI=
X-Received: by 2002:a0c:c607:0:b0:6b2:9c01:86b7 with SMTP id
 6a1803df08f44-6b2afc76589mr116376566d6.5.1718702731438; Tue, 18 Jun 2024
 02:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613153924.961511-1-iii@linux.ibm.com> <20240613153924.961511-33-iii@linux.ibm.com>
In-Reply-To: <20240613153924.961511-33-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 18 Jun 2024 11:24:50 +0200
Message-ID: <CAG_fn=X6wHfmGsVgdqwms_Hk1CQAZ6M5623WyatjVp=Uk-z9pQ@mail.gmail.com>
Subject: Re: [PATCH v4 32/35] s390/uaccess: Add KMSAN support to put_user()
 and get_user()
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 5:39=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> put_user() uses inline assembly with precise constraints, so Clang is
> in principle capable of instrumenting it automatically. Unfortunately,
> one of the constraints contains a dereferenced user pointer, and Clang
> does not currently distinguish user and kernel pointers. Therefore
> KMSAN attempts to access shadow for user pointers, which is not a right
> thing to do.
>
> An obvious fix to add __no_sanitize_memory to __put_user_fn() does not
> work, since it's __always_inline. And __always_inline cannot be removed
> due to the __put_user_bad() trick.
>
> A different obvious fix of using the "a" instead of the "+Q" constraint
> degrades the code quality, which is very important here, since it's a
> hot path.
>
> Instead, repurpose the __put_user_asm() macro to define
> __put_user_{char,short,int,long}_noinstr() functions and mark them with
> __no_sanitize_memory. For the non-KMSAN builds make them
> __always_inline in order to keep the generated code quality. Also
> define __put_user_{char,short,int,long}() functions, which call the
> aforementioned ones and which *are* instrumented, because they call
> KMSAN hooks, which may be implemented as macros.

I am not really familiar with s390 assembly, but I think you still
need to call kmsan_copy_to_user() and kmsan_copy_from_user() to
properly initialize the copied data and report infoleaks.
Would it be possible to insert calls to linux/instrumented.h hooks
into uaccess functions?

